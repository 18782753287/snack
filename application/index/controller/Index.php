<?php
/**
 * User: Bosen
 * Date: 2020/6/19
 * Time: 15:38
 */

namespace app\index\controller;

use app\index\model\Collect;
use app\index\model\Coupon;
use app\index\model\Evaluate;
use app\index\model\Member;
use app\index\model\Order;
use app\index\model\Goods;
use app\index\model\ShopCar;
use think\facade\Cache;
use think\Controller;
use think\Db;
use think\facade\Session;
use app\index\controller\Login;

class Index extends Controller {

    public function index() {
        app('cache');
        $res = cache('index_cache');
        if($res){
            $this->assign($res);
        }
        //主页头部显示商品图片
        $img = Goods::orderRand()
            ->limit(0,9)
            ->field(['id','goods_img','goods_merchant'])->select();
        $mb_id = Session::get('mb_id');
        $mb_name = Session::get('mb_name');
        //获取用户评价信息
        $e_count = Evaluate::where('e_mb_id', $mb_id)->count();
        //获取商品数量
        $g_count = Goods::where('id','>=',1)->count();
        //获取用户订单数
        $o_count = Order::where('order_mb_id', $mb_id)
            ->where('pay_status','<>',0)
            ->count();
        //获取用户信息
        $mb = Member::where('id',$mb_id)
            ->field('mb_head_img')->find();
        //获取商品信息

        //翻页
        $num = input('num');
        $up = input('up');
        $low = input('low');
        if ($num=='')$num = 1;
        if ($up!=''){
            if ($num<$g_count/35)$num++;
        }
        if ($low!=''){
            if ($num!=1)$num--;
        }
        $goods = Goods::where('id','>=',1)
            ->field(['id','goods_img',
                'goods_describe','goods_price','goods_merchant'])
            ->page($num,35)
            ->select();
        $res = [
            'mb_name'       => $mb_name,
            'mb_id'         => $mb_id,
            'mb_head_img'   => $mb['mb_head_img'],
            'img'           => $img->toArray(),
            'e_count'       => $e_count,
            'o_count'       => $o_count,
            'goods'         => $goods,
            'num'           => $num,
        ];
        $this->assign($res);
        return $this->fetch();
    }
    //会员详情页面
    public function my_info(){
        $mb_name = Session::get('mb_name');
        $mb_id = Session::get('mb_id');
        if ($mb_id==''){
            $this->error('请先完成登陆','/index/login');
        }
        //获取用户信息
        $member = Member::where('id',$mb_id)->find();
        //获取用户评价信息
        $evaluate = Db::name('evaluate')
            ->order('id','desc')
            ->where('e_mb_id',$mb_id)
            ->select();
        $e_count = Db::name('evaluate')
            ->where('e_mb_id',$mb_id)
            ->count();
        for ($i=0;$i<$e_count;$i++){
            $goods = Db::name('goods')
                ->where('id',$evaluate[$i]['e_goods_id'])
                ->find();
            $evaluate[$i]['goods_img'] = $goods['goods_img'];
            $evaluate[$i]['goods_name'] = $goods['goods_name'];
        }
        //获取商户订单信息
        $order = Order::where('order_mb_id',$mb_id)
            ->where('pay_status','<>',0)
            ->field(['pay_time','order_num','goods_id','order_mt','order_price','goods_num'])
            ->order('id','desc')
            ->select();
        $o_count = Order::where('order_mb_id',$mb_id)
            ->where('pay_status','<>',0)
            ->field(['pay_time','order_num','goods_id'])
            ->order('id','desc')
            ->count();
        $goods = [];
        foreach($order as $o){
            $g = Goods::where('id',$o['goods_id'])
                ->field(['goods_img','goods_name','id'])
                ->find();
            $goods[] = $g;
        }
        //获取收藏夹信息
        $collect = Db::name('collect')
            ->where('mb_id',Session::get('mb_id'))
            ->select();
        $c_count = Db::name('collect')
            ->where('mb_id',Session::get('mb_id'))
            ->count();
        for($i=0;$i<$c_count;$i++){
            if ($collect[$i]['type']==0){
                $m = Db::name('merchant')
                    ->where('id',$collect[$i]['num_id'])
                    ->find();
                $collect[$i]['head_img'] = $m['mt_head_img'];
                $collect[$i]['name'] = $m['mt_name'];
            }
            if ($collect[$i]['type']==1){
                $g = Db::name('goods')
                    ->where('id',$collect[$i]['num_id'])
                    ->find();
                $collect[$i]['head_img'] = $g['goods_img'];
                $collect[$i]['name'] = $g['goods_name'];
            }
        }
        //获取购物车信息
        $shop_car = Db::name('shop_car')
            ->where('mb_id',Session::get('mb_id'))
            ->order('id','desc')
            ->select();
        $s_count = ShopCar::where('mb_id',Session::get('mb_id'))
            ->count();
        for ($i=0;$i<$s_count;$i++){
            $shop_goods = Db::name('goods')
                ->where('id',$shop_car[$i]['goods_id'])
                ->find();
            $shop_car[$i]['goods_name'] = $shop_goods['goods_name'];
            $shop_car[$i]['goods_img'] = $shop_goods['goods_img'];
            $shop_car[$i]['goods_describe'] = $shop_goods['goods_describe'];
            $shop_car[$i]['goods_price'] = $shop_goods['goods_price'];
        }
        //获取优惠卷信息
        $coupon = Coupon::where('mb_id',Session::get('mb_id'))
            ->select();
        $c_count = Coupon::where('mb_id',Session::get('mb_id'))
            ->count();
        for ($i=0;$i<$c_count;$i++){
            $mt = Db::name('merchant')
                ->where('id',$coupon[$i]['mt_id'])
                ->find();
            $coupon[$i]['mt_name'] = $mt['mt_name'];
            $coupon[$i]['mt_head_img'] = $mt['mt_head_img'];
        }
        $this->assign('member',$member);
        $this->assign([
            'mb_name'       => $mb_name,
            'mb_id'         => $mb_id,
            'mb_head_img'   => $member['mb_head_img'],
            'order'         => $order,
            'evaluate'      => $evaluate,
            'goods'         => $goods,
            'o_count'       => $o_count,
            'collect'       => $collect,
            'shop_car'      => $shop_car,
            'coupon'        => $coupon,
        ]);
        return $this->fetch();
    }
    public function del_collect(){
        $id = input('id');
        $sql = Collect::destroy($id);
        if ($sql){
            $this->success('取消成功','/index/index/my_info');
        }
    }
    //购物车购买和删除
    public function shop_car(){
        $shop_data = input('shop_data');
        //分割购物车信息
        $temp = explode(',',$shop_data);
        for($i=0;$i<count($temp);$i+=3){
            $shop_id[$i]        = $temp[$i];
            $goods_id[$i+1]     = $temp[$i+1];
            $goods_num[$i+2]    = $temp[$i+2];
        }
        $flag = input('flag');
        switch ($flag) {
            case '结算选中的商品':
                $shop_id = implode($shop_id,',');
                $goods_id = implode($goods_id,',');
                $goods_num = implode($goods_num,',');
                $this->redirect('/index/purchase?flag=' . '￥购买&goods_id=' . $goods_id . '&shop_id=' . $shop_id . '&goods_num=' . $goods_num);
                break;
            case '删除选中的商品':
                for($i=0;$i<count($temp);$i+=3) {
                    $sql = ShopCar::destroy($shop_id[$i]);
                }
                if ($sql) {
                    $this->success('删除成功', '/index/index/my_info');
                } else {
                    $this->error('删除时出现了问题，请重新删除');
                }
                break;
        }
    }
    public function del_evaluate(){
        $e_id = input('e_id');
        $sql = Evaluate::destroy($e_id);
        $this->success('删除评论成功');
    }
}