<?php
/**
 * User: Bosen
 * Date: 2020/6/26
 * Time: 16:05
 */

namespace app\admin\controller;

use app\login_check\admin_login_check;
use app\admin\model\Merchant as Mt;

class Merchant extends admin_login_check {
    public function index(){
        $mts = Mt::where('id','>=',1)
            ->select();
        $this->assign([
            'mts'   =>$mts,
        ]);
        return $this->fetch();
    }
    public function update_ratio(){
        $ratio = input('ratio');
        $mt_id = input('mt_id');
        if (!is_numeric($ratio)){
            $this->error('请输入数字');
        }
        if ($ratio>0.5 || $ratio<0.1){
            $this->error('手续费收费比例要在0.1-0.5之间');
        }
        $sql = Mt::where('id',$mt_id)
            ->update(['mt_ratio'  => $ratio,]);
        $this->success('修改成功');
    }
    public function delete_mt(){
        $mt_id = input('mt_id');
        $sql = Mt::destroy($mt_id);
        $this->success('删除成功');
    }
    //审核通过
    public function pass_mt(){
        $mt_id = input('mt_id');
        $mt_email = Mt::where('id',$mt_id)->value('mt_email');
        $mt_name = Mt::where('id',$mt_id)->value('mt_name');
        //发送邮箱提醒
        if (!remind_mt($mt_email,$mt_name)){
            $this->error('通知商户的邮件发送失败');
        }
        $sql = Mt::where('id',$mt_id)->update(['mt_status'=>2]);
        $this->success('审核商家成功,已通过邮件通知该商户');

    }
}