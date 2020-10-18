<?php
/**
 * User: Bosen
 * Date: 2020/6/19
 * Time: 22:16
 */

namespace app\admin\controller;

use app\admin\model\Admin;
use think\Controller;
use think\facade\Session;

class Login extends Controller {
    //登陆
    public function index(){
        return $this->fetch();
    }
    //登陆检查
    public function check(){
        $params = input('post.');
        //检测格式是否合法
        if ($params['name']=="" || $params['name']==null){
            $this->error("名字不能为空");
        }
        if ($params['pass']=="" || $params['pass']==null){
            $this->error("密码不能为空");
        }
        //检查用户
        $admin = Admin::where('admin_name',$params['name'])
            ->field('admin_name','admin_pwd')->find();
        if($admin['admin_status']==2){
            $this->error('您的账号已被超级管理员停用');
        }
        if($admin['admin_status']==3){
            $this->error('您的账号还在审核中，请耐心等待');
        }
        if ($admin!=null||$admin!=''){
            if ($admin['admin_pwd']==md5($params['pass'])){
                Session::set('admin_name',$params['name']);
                Session::set('admin_id',$admin['id']);
                $this->redirect("/admin");
            }else{
                $this->error("密码错误，请重新输入");
            }
        }else{
            $this->error("不存在该用户");
        }
    }
    //注册
    public function sign_up(){
        return $this->fetch();
    }
    public function sign_up_action(){
        $params = input('post.');
        if ($params['name']==''||$params['name']==null){
            $this->error("名字不能为空");
        }
        if ($params['email']==''||$params['email']==null){
            $this->error("邮箱不能为空");
        }
        if ($params['pwd']==''||$params['pwd']==null){
            $this->error("密码不能为空");
        }
        if ($params['re_pwd']==''||$params['re_pwd']==null){
            $this->error("请确认密码");
        }
        if ($params['pwd']!=$params['re_pwd']) {
            $this->error("两次密码输入不一");
        }
        //判断名字是否已被注册
        $mb_name = Admin::where("admin_name", $params['name'])->find();
        if ($mb_name!=''||$mb_name!=null){
            $this->error("该名称已被注册");
        }
        //判断邮箱是否已被注册
        $mb_email = Admin::where("admin_email", $params['email'])->find();
        if ($mb_email!=''||$mb_email!=null){
            $this->error("该邮箱已注册过");
        }
        //生成验证码
        $email_code = mt_rand(100000,999999);
        Session::set('email_code', $email_code);
        //记录用户信息
        Session::set('sign_admin_name',$params['name']);
        Session::set('sign_admin_email',$params['email']);
        Session::set('sign_admin_pwd',$params['pwd']);
        if (mailto($params['email'],$email_code)){
            $this->redirect("/admin/login/input_code");
        }else{
            $this->error("注册失败，请检查您的邮箱是否可用");
        }
    }
    //注册检查验证码
    public function input_code(){
        return $this->fetch();
    }
    public function check_code(){
        $code = input('code');
        if ($code == Session::get('email_code')){
            $sql = Admin::create([
                'admin_name'    => Session::get('sign_admin_name'),
                'admin_pwd'     => md5(Session::get('sign_admin_pwd')),
                'admin_email'   => Session::get('sign_admin_email')
            ]);
            if ($sql){
                $this->success("注册成功，请耐心等待管理员的审核，届时将通过邮箱通知你",'/admin');
            }
        }else{
            $this->error("验证码有误，请重新输入");
        }
    }
    //忘记密码
    public function forgot(){
        return $this->fetch();
    }
    //忘记密码邮箱检查
    public function check_email(){
        $email = input('email');
        if ($email==''||$email==null){
            $this->error("邮箱不能为空");
        }
        if (!check_email($email)){
            $this->error('请检查邮箱是否填写正确');
        }
        $admin_email = Admin::where("admin_email", $email)->find();
        if ($admin_email==''||$admin_email==null){
            $this->error("该邮箱还未在此注册过");
        }else{
            //生成验证码
            $forgot_code = mt_rand(100000,999999);
            Session::set('forgot_admin_code',$forgot_code);
            //记录忘记密码的用户邮箱
            Session::set('forgot_admin_email',$email);
            if (mailto($email,$forgot_code)){
                $this->redirect("/admin/login/input_forgot_code");
            }else{
                $this->error("邮件发送超时，请重试");
            }
        }
    }
    public function input_forgot_code(){
        return $this->fetch();
    }
    public function check_forgot_code(){
        $code = input('code');
        if ($code == Session::get('forgot_admin_code')){
            $this->redirect("/admin/login/admin_update_pwd");
        }else{
            $this->error("验证码有误，请重新输入");
        }
    }
    //修改密码
    public function admin_update_pwd(){
        return $this->fetch();
    }
    public function update_pwd_adction(){
        $pwd = input('pwd');
        $re_pwd = input('re_pwd');
        if ($pwd==$re_pwd){
            if (Session::get('admin_name')==''){
                //忘记密码
                $sql = Admin::where('admin_email',Session::get('forgot_admin_email'))
                    ->update([
                        'admin_pwd' => md5($pwd)
                    ]);
            }else{
                //修改密码
                $sql = Admin::where('admin_name',Session::get('admin_name'))
                    ->update([
                        'admin_pwd' => md5($pwd)
                    ]);
            }

            if ($sql || $sql==0){
                Session::set('admin_name',null);
                $this->success("修改密码成功，正在跳转至登陆页面","/admin/login");
            }
        }else{
            $this->error("两次密码输入不一");
        }
    }
    //退出登陆
    public function out_login(){
        Session::set('admin_name',null);
        $this->redirect('/admin');
    }
}