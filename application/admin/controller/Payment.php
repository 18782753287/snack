<?php
/**
 * User: Bosen
 * Date: 2020/6/26
 * Time: 21:25
 */

namespace app\admin\controller;

use app\login_check\admin_login_check;
use app\admin\model\Order;
use think\facade\Session;

class Payment extends admin_login_check {
    public function index(){
        $wx_count = Order::where('pay_status',1)
            ->count();
        $wx_pay = Order::where('pay_status',1)
            ->sum('order_price');
        $wx_pay = round($wx_pay*100)/100;
        $ali_count = Order::where('pay_status',2)
            ->count();
        $ali_pay = Order::where('pay_status',2)
            ->sum('order_price');
        $ali_pay = round($ali_pay*100)/100;

        //翻页
        $flag = input('flag');
        $type = input('type');
        $num = input('num');
        $show = $type;
        if ($num==''){
            $num=1;
        }
        if ($flag=='上一页' && $type=='wx'){
            if ($num<=1){
                $num=1;
            }else{
                $num--;
            }
        }
        if ($flag=='下一页' && $type=='wx'){
            if ($num>=ceil($wx_count/20)){
                $num=ceil($wx_count/20);
            }else{
                $num++;
            }
        }
        if ($flag=='上一页' && $type=='ali'){
            if ($num<=1){
                $num=1;
            }else{
                $num--;
            }
        }
        if ($flag=='下一页' && $type=='ali'){
            if ($num>=ceil($wx_count/20)){
                $num=ceil($wx_count/20);
            }else{
                $num++;
            }
        }
        $ali = Order::where('pay_status',2)
            ->page($num,20)
            ->select();
        $wechat = Order::where('pay_status',1)
            ->page($num,20)
            ->select();
        $this->assign([
            'wx_count'  =>$wx_count,
            'ali_count' =>$ali_count,
            'wx_pay'    =>$wx_pay,
            'ali_pay'   =>$ali_pay,
            'ali'       =>$ali,
            'wechat'    =>$wechat,
            'show'      =>$show,
            'num'       =>$num,
        ]);
        return $this->fetch();
    }
}