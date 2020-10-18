<?php
/**
 * User: Bosen
 * Date: 2020/6/26
 * Time: 22:12
 */

namespace app\merchant\controller;

use app\merchant\model\Order;
use app\login_check\merchant_login_check;
use think\facade\Session;

class MtOrder extends merchant_login_check {
    public function index(){
        $flag = input('flag');
        if ($flag == ''){
            $flag = Session::get('flag');
        }
        Session::set('flag',$flag);
        $search = input('order_num');

        if ($flag=='' || $flag=='all'){//全部

            $o_count = \app\index\model\Order::where('id','>',1)
                ->where('order_mt',Session::get('mt_name'))
                ->count();
            //翻页
            $num = input('num');
            $up = input('up');
            $low = input('low');
            if ($num=='')$num = 1;
            if ($up!=''){
                if ($num<$o_count/20)$num++;
            }
            if ($low!=''){
                if ($num!=1)$num--;
            }
            $order = Order::where('id','>',1)
                ->order('id','desc')
                ->where('order_mt',Session::get('mt_name'))
                ->page($num,20)
                ->select();
        }
        if ($flag=='pay'){//已支付
            $o_count = Order::where('id','>',1)
                ->where('pay_status','<>',0)
                ->where('order_mt',Session::get('mt_name'))
                ->count();
            //翻页
            $num = input('num');
            $up = input('up');
            $low = input('low');
            if ($num=='')$num = 1;
            if ($up!=''){
                if ($num<$o_count/20)$num++;
            }
            if ($low!=''){
                if ($num!=1)$num--;
            }
            $order = Order::where('id','>',1)
                ->where('pay_status','<>',0)
                ->where('order_mt',Session::get('mt_name'))
                ->order('id','desc')
                ->page($num,20)
                ->select();
        }
        if ($flag=='not'){//未支付
            $o_count = Order::where('id','>',1)
                ->where('pay_status','=',0)
                ->where('order_mt',Session::get('mt_name'))
                ->count();
            //翻页
            $num = input('num');
            $up = input('up');
            $low = input('low');
            if ($num=='')$num = 1;
            if ($up!=''){
                if ($num<$o_count/20)$num++;
            }
            if ($low!=''){
                if ($num!=1)$num--;
            }
            $order = Order::where('id','>',1)
                ->order('id','desc')
                ->where('pay_status','=',0)
                ->where('order_mt',Session::get('mt_name'))
                ->page($num,20)
                ->select();
        }
        //搜索
        if ($search != ''){
            $order = Order::where('order_num',$search)
                ->where('order_mt',Session::get('mt_name'))
                ->select();
        }
        $this->assign([
            'order' =>$order,
            'num'   =>$num,
        ]);
        return $this->fetch();
    }
}