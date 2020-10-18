<?php
/**
 * User: Bosen
 * Date: 2020/6/26
 * Time: 13:42
 */

namespace app\admin\controller;

use app\login_check\admin_login_check;
use app\admin\model\Admin as A;
use think\facade\Session;

class Admin extends admin_login_check {
    public function index(){
        $admin = A::where('id','>=',1)->select();
        $this->assign([
            'admin'     =>$admin,
            'admin_id'  =>Session::get('admin_id'),
        ]);
        return $this->fetch();
    }
    public function update(){
        $flag = input('flag');
        $admin_id = input('admin_id');
        if ($admin_id==1){
            $this->error('此账号未系统默认最高权限用户，无法修改');
        }
        switch ($flag){
            case '删除':
                $sql = A::destroy($admin_id);
                $this->success('删除成功');
                break;
            case '停用':
                $sql = A::where('id',$admin_id)
                    ->update(['admin_status'=>2]);
                $this->success('停用成功');
                break;
            case '启用':
                $sql = A::where('id',$admin_id)
                    ->update(['admin_status'=>1]);
                $this->success('启用成功');
                break;
            case '通过':
                $admin = A::where('id',$admin_id)->find();
                if (!remind_admin($admin['admin_email'],$admin['admin_name'])){
                    $this->error('通知商户的邮件发送失败');
                }
                $sql = A::where('id',$admin_id)
                    ->update(['admin_status'=>1]);
                $this->success('审核通过，已通过邮箱通知');
                break;
        }
    }
}