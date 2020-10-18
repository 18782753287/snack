<?php
/**
 * User: Bosen
 * Date: 2020/6/25
 * Time: 14:53
 */

namespace app\index\controller;

use app\index\model\Collect;
use app\index\model\Coupon;
use app\index\model\Goods;
use app\index\model\Group;
use app\index\model\Order;
use app\index\model\Merchant;
use app\index\model\ShopCar;
use app\login_check\member_login_check;
use think\Db;
use think\facade\Session;

class Purchase extends member_login_check {
    public function index(){
        $flag = input('flag');
        switch ($flag) {
            case '进入店铺':
                $mt_id = input('mt_id');
                $mt_name = Merchant::where('id',$mt_id)->value('mt_name');
                $this->redirect('/index/merchant?merchant='.$mt_name);
                break;
            case '￥购买':
                $shop_ids = input('shop_id');
                $goods_ids = input('goods_id');
                $goods_nums = input('goods_num');
                //处理数据
                $shop_id = explode(',',$shop_ids);
                $goods_id = explode(',',$goods_ids);
                $goods_num = explode(',',$goods_nums);
                $order_price[] = null;
                $coupon_arr[] = null;
                $order_num[] = null;
                $order_mt[] = null;
                $goods[] = null;
                $mt_ratio[] = null;
                for ($j=0;$j<count($shop_id);$j++){
                    $order_num[$j] = time() . rand(1000, 9999);
                    if($goods_num[$j]<=0){
                        $this->error('商品数填写不合法');
                    }
                    if ($j==0){
                        Session::set('shop_num',$order_num[$j]);
                    }
                    if ($goods_num[$j]==''){
                        $goods_num[$j] = 1;
                    }
                    //开启事务
                    Db::startTrans();
                    try {
                        /**
                         * @notes: 查询库存
                         * @author: Bosen
                         * @date: 2020/8/24 23:36
                         */
                        $goods[$j] = Goods::where('id', $goods_id[$j])
                            ->find();
                        if ($goods[$j]['goods_stocks'] < $goods_num[$j]){
                            Db::rollback();
                            //exit('商品库存不足！');
                            $this->error("商品库存不足！");
                        } else {
                            /**
                             * @notes: 修改库存
                             * @author: Bosen
                             * @date: 2020/8/24 23:36
                             */
                            $res = Goods::where('id', $goods_id[$j])->update([
                                'goods_stocks' => $goods[$j]['goods_stocks'] - $goods_num[$j],
                            ]);
                            if (!$res) {
                                Db::rollback();
                                //exit('商品库存不足！');
                                $this->error("商品库存不足！");
                            }
                        }
                        $goods[$j]['goods_num'] = $goods_num[$j];
                        $order_price[$j] = ($goods[$j]['goods_price'] * $goods_num[$j]);
                        $order_mb_id = Session::get('mb_id');
                        $order_mb = Session::get('mb_name');
                        $order_mt[$j] = $goods[$j]['goods_merchant'];
                        $mt_ratio[$j] = Merchant::where('mt_name', $order_mt[$j])
                            ->value('mt_ratio');
                        $mt_id = Merchant::where('mt_name', $order_mt[$j])
                            ->value('id');
                        //获取用户在该商户下的优惠卷信息
                        $coupon = Db::name('coupon')
                            ->where('mb_id', Session::get('mb_id'))
                            ->where('mt_id', $mt_id)
                            ->select();
                        $c_count = Coupon::where('mb_id', Session::get('mb_id'))
                            ->where('mt_id', $mt_id)
                            ->count();
                        for ($i = 0; $i < $c_count; $i++) {
                            $mt = Db::name('merchant')
                                ->where('id', $coupon[$i]['mt_id'])
                                ->find();
                            $coupon[$i]['mt_name'] = $mt['mt_name'];
                            $coupon[$i]['mt_head_img'] = $mt['mt_head_img'];
                        }
                        $coupon_arr[$j] = $coupon;
                        //创建订单
                        /**
                         * @notes: 创建订单
                         * @author: Bosen
                         * @date: 2020/8/24 23:38
                         */
                        $sql = Order::create([
                            'order_num' => $order_num[$j],
                            'goods_id' => $goods_id[$j],
                            'order_price' => $order_price[$j],
                            'order_mb_id' => $order_mb_id,
                            'order_mb' => $order_mb,
                            'order_mt' => $order_mt[$j],
                            'mt_ratio' => $mt_ratio[$j],
                            'goods_num' => $goods_num[$j],
                            'year' => date('Y'),
                            'month' => date('Y-m'),
                            'day' => date('Y-m-d'),
                            'shop_id' => $shop_id[$j],
                            'shop_num' => Session::get('shop_num'),
                            'time' => time() + 30
                        ]);
                        //提交事务
                        Db::commit();
                    }catch (\Exception $e){
                        Db::rollback();
                    }
                }
                $order_mt = $this->del_mt($order_mt);
                $coupon_arr = $this->del_re($coupon_arr);
                //传递参数
                if ($sql) {
                    $this->assign([
                        'order_num'     => $order_num,
                        'goods_id'      => $goods_id,
                        'order_price'   => array_sum($order_price),
                        'order_mb_id'   => $order_mb_id,
                        'order_mb'      => $order_mb,
                        'order_mt'      => $order_mt,
                        'goods_num'     => array_sum($goods_num),
                        'goods'         => $goods,
                        'coupon'        => $coupon_arr,
                        'goods_end'     => count($goods_id),
                        'mt_end'        => count($order_mt),
                    ]);
                } else {
                    $this->error('创建订单时出现了错误，请重新购买');
                }
                return $this->fetch();
                break;
            case '关注店铺':
                $mt_id = input('mt_id');
                //判断用户之前是否已关注
                $count = Collect::where('type',0)
                    ->where('mb_id', Session::get('mb_id'))
                    ->where('num_id',$mt_id)
                    ->count();
                if ($count==0){
                    $sql = Collect::create([
                        'type'  => 0,
                        'mb_id' => Session::get('mb_id'),
                        'num_id'=> $mt_id,
                    ]);

                    if ($sql){
                        $this->success('关注成功');
                    }
                }else{
                    $this->error('您在此前已关注过了');
                }
                break;
            case '收藏商品':
                $goods_id = input('goods_id');
                //判断用户之前是否已关注
                $count = Collect::where('type',1)
                    ->where('mb_id', Session::get('mb_id'))
                    ->where('num_id',$goods_id)
                    ->count();
                if ($count==0){
                    $sql = Collect::create([
                        'type'  => 1,
                        'mb_id' => Session::get('mb_id'),
                        'num_id'=> $goods_id,
                    ]);

                    if ($sql){
                        $this->success('收藏成功');
                    }
                }else{
                    $this->error('您在此前已收藏过了');
                }
                break;
            case '+加入购物车':
                $goods_id = input('goods_id');
                $mb_id = Session::get('mb_id');
                $goods_num = input('goods_num');
                $count = Db::name('shop_car')
                    ->where('goods_id',$goods_id)
                    ->where('mb_id',$mb_id)
                    ->find();
                if ($count!=''){
                    $sql = ShopCar::where('id',$count['id'])
                        ->update([
                        'num'   => $count['num']+$goods_num,
                    ]);
                }else{
                    $sql = ShopCar::create([
                        'goods_id'  => $goods_id,
                        'mb_id'     => $mb_id,
                        'num' => $goods_num,
                    ]);
                }
                $this->success('加入购物车成功');
                break;
        }
        return null;
    }
    //删除优惠卷数组中重复的优惠卷
    public function del_re($array){
        $coupon_arr = array();
        $id = array();
        foreach ($array as $arr){
            foreach ($arr as $a){
                if (!in_array($a['id'],$id)){
                    $id[] = $a['id'];
                    $coupon_arr[] = $a;
                }
            }
        }
        return $coupon_arr;
    }
    public function del_mt($arr){
        $mt_arr = array();
        foreach (array_unique($arr) as $a){
            $mt_arr[] = $a;
        }
        return $mt_arr;
    }
}