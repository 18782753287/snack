<?php
/**
 * User: Bosen
 * Date: 2020/7/2
 * Time: 18:00
 */

namespace app\wechatpay\controller;

use app\admin\model\Merchant;
use app\index\model\Coupon;
use app\index\model\Goods;
use app\index\model\Order;
use app\index\model\ShopCar;
use CLogFileHandler;
use Log;
use mysql_xdevapi\BaseResult;
use think\Controller;
use think\Db;
use NativePay;
use think\db\Where;
use think\Exception;
use think\facade\Session;
use WxPayUnifiedOrder;
class Pay extends Controller {
    public function index(){
        $order_num = input('order_num');
        $field = "order_num,order_price,order_mt";
        $order_data = Db::name("order")->where('order_num', $order_num)->field($field)->find();
        $order_data['order_price'] = input('order_price');
        //处理优惠卷信息
        $count = Order::where('shop_num',$order_num)->count();
        //购买
        $order_data['order_price'] = $this->coupon_action($order_data['order_price'],$order_num);
        $order_price = $order_data['order_price'];
        if (empty($order_data)) {
            $this->error("订单查询失败");
        }
        require EXTEND_PATH . 'wechatpay/lib/' . 'WxPay.Api.php';
        require EXTEND_PATH . 'wechatpay/example/' . 'WxPay.NativePay.php';
        $logHandler = new CLogFileHandler(date('Y-m-d') . '.log');
        $log = Log::Init($logHandler, 15);
        $input = new WxPayUnifiedOrder();
        $notify = new NativePay();
        $input->SetBody('零食网商品');
        $input->SetOut_trade_no($order_num);
        $input->SetTotal_fee($order_price*100);
        $input->SetTime_start(time());
        $input->SetProduct_id(time());
        $input->SetNotify_url(config('system.site_url') . '/wechatpay/pay/payReturn');
        $input->SetTrade_type("NATIVE");
        $result = $notify->GetPayUrl($input);
        try{
            $url = $result["code_url"];
        }catch (Exception $e){
            $url = null;
        }
        //二维码
        $this->assign('url',$url);
        //订单号
        $this->assign('order_data',$order_data);
        return $this->fetch();
    }
    //生成二维码
    public function qr_code($url=""){//生成支付二维码
        ob_clean();
        get_qr_code($url);
    }
    public function payReturn(){
        //获取返回的xml
        $testxml  = file_get_contents("php://input");
        //将xml转化为json格式
        $jsonxml = json_encode(simplexml_load_string($testxml, 'SimpleXMLElement', LIBXML_NOCDATA));
        //转成数组
        $result = json_decode($jsonxml, true);
        if($result){
            $order_num=$result['out_trade_no'];
            if($result['return_code'] == 'SUCCESS' && $result['result_code'] == 'SUCCESS') {
                //删除购物车中的商品
                $shop_id = Order::where('shop_num',$order_num)->select();
                if ($shop_id!=null){
                    foreach ($shop_id as $s){
                        ShopCar::destroy($s['shop_id']);
                    }
                }
                //删除使用过的优惠卷
                $coupon_id = Order::where('order_num',$order_num)->value('coupon_id');
                $coupon_id = explode(',',$coupon_id);
                if ($coupon_id[0]!=''){
                    foreach ($coupon_id as $key => $val){
                        $c_num = Coupon::where('id',$val)->value('num');
                        Coupon::where('id',$val)->update([
                            'num'   => $c_num-1
                        ]);
                    }
                }
                //修改订单状态
                $sql = Order::where('shop_num',$order_num)
                    ->update([
                        'pay_status'    => 1,
                        'pay_time'  => date('Y-m-d H:i:s'),
                    ]);
                exit('success');
            }
        }
    }
    public function pay_state(){//判断支付状态
        $order_num=input('order_num');
        $judge = Order::where('order_num',$order_num)->value('pay_status');
        if ($judge!=0){
            echo $judge;
            $this->assign('status','OK');
        }
    }
    /**
     * 优惠卷信息的处理
     * @author Bosen
     * @param $order_price
     * @param $order_num
     * @return mixed
     * @throws Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    public function coupon_action($order_price,$order_num){
        //优惠卷信息处理
        $coupon_data = input('coupon_id');
        if ($coupon_data==''){
            Order::where('shop_num',$order_num)
                ->update([
                    'coupon_id'     => null,
                ]);
            return $order_price;
        }
        $coupon = explode(',',$coupon_data);
        $goods_id = array();
        $coupon_id = array();
        $coupon_num = array();
        $goods_num = array();
        $coupon_data = array();
        $coupon_judge = array();
        $sub_coupon_num = array();
        $full_coupon_num = array();
        foreach ($coupon as $key => $val){
            $cou = explode(':',$val);
            $goods_id[$key] = $cou[0];
            $coupon_id[$key] = $cou[1];
            $coupon_num[$key] = $cou[2];
            $coupon_data[$key] = Coupon::where('id',$coupon_id[$key])->find();
            if (array_key_exists($coupon_id[$key],$coupon_judge)){
                $coupon_judge[$coupon_id[$key]] = $coupon_judge[$coupon_id[$key]]+$coupon_num[$key];
            }else{
                $coupon_judge[$coupon_id[$key]] = $coupon_num[$key];
            }
            $goods_num[$goods_id[$key]] = Order::where('shop_num',$order_num)
                ->where('goods_id',$goods_id[$key])
                ->value('goods_num');
        }
        //判断优惠劵张数是否合法
        foreach ($coupon_judge as $key => $val){
            $cou = Coupon::where('id',$key)->find();
            if ($cou['type']==1){
                if (array_key_exists($cou['mt_id'],$full_coupon_num)){
                    $full_coupon_num[$cou['mt_id']] = $full_coupon_num[$cou['mt_id']]+$val;
                }else{
                    $full_coupon_num[$cou['mt_id']] = $val;
                }
            }
            if ($cou['type']==0){
                if (array_key_exists($cou['mt_id'],$sub_coupon_num)){
                    $sub_coupon_num[$cou['mt_id']] = $sub_coupon_num[$cou['mt_id']]+$val;
                }else{
                    $sub_coupon_num[$cou['mt_id']] = $val;
                }
            }
        }
        foreach ($sub_coupon_num as $key => $val){
            $mb_sub_coupon = Coupon::where('mb_id',Session::get('mb_id'))
                ->where('mt_id',$key)->where('type',0)->sum('num');
            if ($mb_sub_coupon<$val){
                $this->error('立减卷使用张数超出了已有张数');
            }
        }
        foreach ($full_coupon_num as $key => $val){
            $mb_full_coupon = Coupon::where('mb_id',Session::get('mb_id'))
                ->where('mt_id',$key)->where('type',1)->sum('num');
            if ($mb_full_coupon<$val){
                $this->error('满减卷使用张数超出了已有张数');
            }
        }
        foreach ($coupon_judge as $key => $val){
            $num = Coupon::where('id',$key)->value('num');
            if ($val>$num){
                $this->error('每张优惠卷至多只可使用一次');
            }
        }
        foreach ($coupon_id as $key => $val){
            $coupon_id[$key] = Coupon::where('id',$val)->find();
            $coupon_id[$key]['num'] = $coupon_num[$key];
        }
        //初始化订单优惠卷信息
        Order::where('shop_num',$order_num)->update([
            'coupon_id' => null,
        ]);
        //判断是否有商品未达到满减条件的凭证
        $not_full = false;
        foreach ($coupon_id as $key => $val){
            for ($i=0;$i<$val['num'];$i++){
                $goods = Goods::where('id',$goods_id[$key])->find();
                $c = Coupon::where('id',$val['id'])->find();
                $mt = Merchant::where('id',$c['mt_id'])->value('mt_name');
                //优先使用立减卷
                if ($val['type']==0){
                    if ($goods['goods_merchant']==$mt){
                        $sub = $goods['goods_price']-$c['sub'];
                        if ($sub<=0){
                            $flag = Order::where('order_num',$order_num)->value('coupon_id');
                            if ($flag==null){
                                Order::where('order_num',$order_num)->update([
                                    'coupon_id'     => $val['id'],
                                ]);
                            }else{
                                $order = Order::where('order_num',$order_num)
                                    ->field(['coupon_id'])->find();
                                Order::where('order_num',$order_num)->update([
                                    'coupon_id'     => $val['id'].",".$order['coupon_id'],
                                ]);
                            }
                            $order_price = $order_price-$goods['goods_price'];
                        }else{
                            $flag = Order::where('order_num',$order_num)->value('coupon_id');
                            if ($flag==null){
                                Order::where('order_num',$order_num)->update([
                                    'coupon_id'     => $val['id'],
                                ]);
                            }else{
                                $order = Order::where('order_num',$order_num)
                                    ->field(['coupon_id'])->find();
                                Order::where('order_num',$order_num)->update([
                                    'coupon_id'     => $val['id'].",".$order['coupon_id'],
                                ]);
                            }
                            $order_price = $order_price-$c['sub'];
                        }
                    }
                }
                //判断满减卷条件是否符合
                if ($val['type']==1){
                    $goods = Goods::where('id',$goods_id[$key])->find();
                    $c = Coupon::where('id',$val['id'])->find();
                    $mt = Merchant::where('id',$c['mt_id'])->value('mt_name');
                    if ($goods['goods_merchant']==$mt) {
                        if ($goods['goods_price'] < $c['full']) {
                            //未达到满减条件
                            $not_full = true;
                        } else {
                            $flag = Order::where('order_num',$order_num)->value('coupon_id');
                            if ($flag==null){
                                Order::where('order_num',$order_num)->update([
                                    'coupon_id'     => $val['id'],
                                ]);
                            }else{
                                $order = Order::where('order_num',$order_num)
                                    ->field(['coupon_id'])->find();
                                Order::where('order_num',$order_num)->update([
                                    'coupon_id'     => $val['id'].",".$order['coupon_id'],
                                ]);
                            }
                            $order_price = $order_price - $c['sub'];
                        }
                    }
                }
            }
        }
        if ($not_full){
            $this->error('存在商品价格未达到优惠卷满减条件',null,null,5);
        }
        if ($order_price<=0){
            $shop = Order::where('shop_num',$order_num)->field(['shop_id','coupon_id'])->select();
            foreach ($shop as $key => $val){
                ShopCar::destroy($val['shop_id']);
                $c_num = Coupon::where('id',$val['coupon_id'])->value('num');
                if ($c_num==1){
                    Coupon::destroy($val['coupon_id']);
                } else {
                    Coupon::where('id', $val['coupon_id'])->update([
                        'num' => $c_num - 1,
                    ]);
                }
            }
            Order::where('order_num',$order_num)->update([
                'order_price'   => 0,
                'pay_status'    => 1,
                'pay_time'      => date('Y-m-d H:i:s'),
            ]);
            $this->success('此订单已通过优惠卷抵消，无需支付','/index/index/my_info');
        }
        Order::where('order_num',$order_num)->update([
            'order_price'   => $order_price,
        ]);
        return $order_price;
    }
}