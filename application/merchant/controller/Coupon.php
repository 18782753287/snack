<?php
/**
 * User: Bosen
 * Date: 2020/6/30
 * Time: 14:35
 */

namespace app\merchant\controller;

use app\login_check\merchant_login_check;
use app\merchant\model\Coupon as Cou;
use app\merchant\model\Member;
use function PHPSTORM_META\type;
use think\Db;
use think\facade\Session;

class Coupon extends merchant_login_check {
    public function index(){
        $coupon = Db::name('coupon')
            ->order('id','desc')
            ->where('mt_id',Session::get('mt_id'))
            ->select();
        $c_count = Cou::where('mt_id',Session::get('mt_id'))
            ->count();

        for ($i=0;$i<$c_count;$i++){
            $mb = Db::name('member')
                ->where('id',$coupon[$i]['mb_id'])
                ->find();
            $coupon[$i]['mb_name'] = $mb['mb_name'];
            $coupon[$i]['mb_head_img'] = $mb['mb_head_img'];
        }
        $this->assign([
            'coupon'    => $coupon,
        ]);
        return $this->fetch();
    }
    public function coupon_send(){
        $mbs = Member::field(['mb_head_img','mb_name','id'])
            ->select();
        $this->assign([
            'mbs'    => $mbs,
        ]);
        return $this->fetch();
    }
    public function coupon_action(){
        $full   = input('full');
        $sub    = input('sub');
        $num    = input('num');
        $time   = ('time');
        if (!is_numeric($num) || $num<=0){
            $this->error('张数不合规范，请重新填写');
        }
        if ($time==''){
            $time=0;
        }else{
            $time = strtotime(input('time'));
        }
        if ($num=='')$num=1;
        $mb_id  = input('mb_id');
        $type   = input('type');
        if (($type==1 && $full=='') || $sub==''){
            $this->error('金额不能为空');
        }
        if (($type==1 && !is_numeric($full)) && $full<=0){
            $this->error('满减条件请填写大于0的数字');
        }
        if ($type==1 && $full<$sub){
            $this->error('满减条件不能小于优惠金额');
        }
        if (!is_numeric($sub) || $sub<=0){
            $this->error('优惠金额请填写大于0的数字');
        }
        if ($sub<0 || $full<0){
            $this->error('金额不能为负数');
        }
        if ($type==0){
            //立减卷
            $count = Db::name('coupon')
                ->where('type',0)
                ->where('full','>', $full-0.001)
                ->where('full','<', $full+0.001)
                ->where('sub','>', $sub-0.001)
                ->where('sub','<', $sub+0.001)
                ->where('mb_id',$mb_id)
                ->where('mt_id',Session::get('mt_id'))
                ->where('time',$time)
                ->find();
            if ($count!=''){
                $sql = Cou::where('id',$count['id'])
                    ->update([
                    'num'   => $count['num']+$num
                ]);
                if ($sql){
                    $this->success('发放立减卷成功');
                }
            }else{
                $sql = Cou::create([
                    'type'  => 0,
                    'full'  => 0,
                    'sub'   => $sub,
                    'mb_id' => $mb_id,
                    'mt_id' => Session::get('mt_id'),
                    'num'   => $num,
                    'time'  => $time,
                ]);
                if ($sql){
                    $this->success('发放立减卷成功');
                }
            }
        }else{
            //满减卷
            $count = Db::name('coupon')
                ->where('type',1)
                ->where('full','>', $full-0.001)
                ->where('full','<', $full+0.001)
                ->where('sub','>', $sub-0.001)
                ->where('sub','<', $sub+0.001)
                ->where('mb_id',$mb_id)
                ->where('mt_id',Session::get('mt_id'))
                ->where('time',$time)
                ->find();
            if ($count!=''){
                $sql = Cou::where('id',$count['id'])
                ->update([
                    'num'   => $count['num']+$num
                ]);
                if ($sql){
                    $this->success('发放满减卷成功');
                }
            }else{
                $sql = Cou::create([
                    'type'  => 1,
                    'full'  => $full,
                    'sub'   => $sub,
                    'mb_id' => $mb_id,
                    'mt_id' => Session::get('mt_id'),
                    'num'   => $num,
                    'time'  => $time,
                ]);
                if ($sql){
                    $this->success('发放满减卷成功');
                }
            }
        }
    }
}