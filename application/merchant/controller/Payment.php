<?php
/**
 * User: Bosen
 * Date: 2020/6/26
 * Time: 21:25
 */

namespace app\merchant\controller;

use app\login_check\merchant_login_check;
use app\merchant\model\Order;
use think\facade\Session;

class Payment extends merchant_login_check {
    public function index(){
        $wx_count = Order::where('pay_status',1)
            ->where('order_mt',Session::get('mt_name'))
            ->count();
        $wx_pay = Order::where('pay_status',1)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price');
        $wx_pay = round($wx_pay*100)/100;
        $ali_count = Order::where('pay_status',2)
            ->where('order_mt',Session::get('mt_name'))
            ->count();
        $ali_pay = Order::where('pay_status',2)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price');
        $ali_pay = round($ali_pay*100)/100;
        $ali = Order::where('pay_status',2)
            ->where('order_mt',Session::get('mt_name'))
            ->select();
        $wechat = Order::where('pay_status',1)
            ->where('order_mt',Session::get('mt_name'))
            ->select();
        $this->assign([
            'wx_count'  =>$wx_count,
            'ali_count' =>$ali_count,
            'wx_pay'    =>$wx_pay,
            'ali_pay'   =>$ali_pay,
            'ali'       =>$ali,
            'wechat'    =>$wechat,
        ]);
        return $this->fetch();
    }
}