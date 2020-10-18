<?php
/**
 * User: Bosen
 * Date: 2020/6/20
 * Time: 10:46
 */

namespace app\merchant\controller;

use app\merchant\model\Merchant;
use app\merchant\model\Order;
use app\login_check\merchant_login_check;
use think\facade\Session;

class Index extends merchant_login_check {
    public function index(){
        //年月日
        $month = date('Y-m');
        $day = date('Y-m-d');
        $yesterday = date("Y-m-d",strtotime("-1 day"));
        //总订单数量
        $o_count = Order::where('id','>=',1)
            ->where('order_mt',Session::get('mt_name'))
            ->count();
        //月
        $month_o_count = Order::where('id','>=',1)
            ->where('month',$month)
            ->where('order_mt',Session::get('mt_name'))
            ->count();
        //日
        $day_o_count = Order::where('id','>=',1)
            ->where('day',$day)
            ->where('order_mt',Session::get('mt_name'))
            ->count();
        //昨日
        $yesterday_o_count = Order::where('id','>=',1)
            ->where('day',$yesterday)
            ->where('order_mt',Session::get('mt_name'))
            ->count();
        //总已支付订单数量
        $pay_count = Order::where('pay_status','<>',0)
            ->where('order_mt',Session::get('mt_name'))
            ->count();
        //月
        $month_pay_count = Order::where('pay_status','<>',0)
            ->where('month',$month)
            ->where('order_mt',Session::get('mt_name'))
            ->count();
        //日
        $day_pay_count = Order::where('pay_status','<>',0)
            ->where('day',$day)
            ->where('order_mt',Session::get('mt_name'))
            ->count();
        //昨日
        $yesterday_pay_count = Order::where('pay_status','<>',0)
            ->where('day',$month)
            ->where('order_mt',Session::get('mt_name'))
            ->count();
        //平台总收益
        $all_profit_order = Order::where('pay_status','<>',0)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price*mt_ratio');
        $all_profit = Order::where('pay_status','<>',0)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price');
        $all_profit_order = round(($all_profit-$all_profit_order)*1000)/1000;
        //平台总收款
        $all_pay_order = Order::where('pay_status','<>',0)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price');
        $all_pay_order = round($all_pay_order*100)/100;
        //本月平台收益
        $month_profit_order = Order::where('pay_status','<>',0)
            ->where('month',$month)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price*mt_ratio');
        $month_profit = Order::where('pay_status','<>',0)
            ->where('month',$month)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price');
        $month_profit_order = round(($month_profit-$month_profit_order)*1000)/1000;
        //本月平台收款
        $month_pay_order = Order::where('pay_status','<>',0)
            ->where('month',$month)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price');
        $month_pay_order = round($month_pay_order*100)/100;
        //今日平台收益
        $day_profit_order = Order::where('pay_status','<>',0)
            ->where('day',$day)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price*mt_ratio');
        $day_profit= Order::where('pay_status','<>',0)
            ->where('day',$day)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price');
        $day_profit_order = round(($day_profit-$day_profit_order)*1000)/1000;
        //今日平台收款
        $day_pay_order = Order::where('pay_status','<>',0)
            ->where('day',$day)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price');
        $day_pay_order = round($day_pay_order*100)/100;
        //昨日平台收益
        $yesterday_profit_order = Order::where('pay_status','<>',0)
            ->where('day',$yesterday)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price*mt_ratio');
        $yesterday_profit = Order::where('pay_status','<>',0)
            ->where('day',$yesterday)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price');
        $yesterday_profit_order = round(($yesterday_profit-$yesterday_profit_order)*1000)/1000;
        //昨日平台收款
        $yesterday_pay_order = Order::where('pay_status','<>',0)
            ->where('day',$yesterday)
            ->where('order_mt',Session::get('mt_name'))
            ->sum('order_price');
        //成功率
        if ($pay_count==0){
            $all_suc = 0;
        }else{
            $all_suc = (round(($pay_count/$o_count)*100)/100)*100;
        }
        if ($month_pay_count==0){
            $month_suc = 0;
        }else{
            $month_suc = (round(($month_pay_count/$month_o_count)*100)/100)*100;
        }
        if ($day_pay_count==0){
            $day_suc = 0;
        }else{
            $day_suc = (round(($day_pay_count/$day_o_count)*100)/100)*100;
        }
        if ($yesterday_pay_count==0){
            $yesterday_suc = 0;
        }else{
            $yesterday_suc = (round(($yesterday_pay_count/$yesterday_o_count)*100)/100)*100;
        }
        $yesterday_pay_order = round($yesterday_pay_order*100)/100;
        //获取商户信息
        $mts = Merchant::field(['mt_name'])
            ->where('mt_name',Session::get('mt_name'))
            ->select();
        //交易金额
        $mts_money = [];
        $mts_ratio = [];
        $mts_all_order = [];
        $mts_pay_order = [];
        foreach ($mts as $mt){
            $mt_all_order = Order::where('order_mt',$mt['mt_name'])
                ->where('order_mt',Session::get('mt_name'))
                ->count();
            $mt_pay_order = Order::where('order_mt',$mt['mt_name'])
                ->where('pay_status','<>',0)
                ->where('order_mt',Session::get('mt_name'))
                ->count();
            $mt_money = Order::where('order_mt',$mt['mt_name'])
                ->where('pay_status','<>',0)
                ->where('order_mt',Session::get('mt_name'))
                ->sum('order_price');
            $mt_ratio = Merchant::where('mt_name',$mt['mt_name'])
                ->value('mt_ratio');
            $mts_money[] = round(($mt_money)*100)/100;
            $mts_ratio[] = round(($mt_ratio*$mt_money)*1000)/1000;
            $mts_all_order[] = $mt_all_order;
            $mts_pay_order[] = $mt_pay_order;
        }
        $this->assign([
            'o_count'               =>$o_count,
            'pay_count'             =>$pay_count,
            'all_profit_order'      =>$all_profit_order,
            'all_pay_order'         =>$all_pay_order,
            'month_profit_order'    =>$month_profit_order,
            'month_pay_order'       =>$month_pay_order,
            'day_profit_order'      =>$day_profit_order,
            'day_pay_order'         =>$day_pay_order,
            'yesterday_pay_order'   =>$yesterday_pay_order,
            'yesterday_profit_order'=>$yesterday_profit_order,
            'month_o_count'         =>$month_o_count,
            'day_o_count'           =>$day_o_count,
            'yesterday_o_count'     =>$yesterday_o_count,
            'month_pay_count'       =>$month_pay_count,
            'day_pay_count'         =>$day_pay_count,
            'yesterday_pay_count'   =>$yesterday_pay_count,
            'all_suc'               =>$all_suc,
            'month_suc'             =>$month_suc,
            'day_suc'               =>$day_suc,
            'yesterday_suc'         =>$yesterday_suc,
            'mts_money'             =>$mts_money,
            'mts_ratio'             =>$mts_ratio,
            'mts_all_order'         =>$mts_all_order,
            'mts_pay_order'         =>$mts_pay_order,
            'mts'                   =>$mts,
        ]);
        return $this->fetch();
    }
}