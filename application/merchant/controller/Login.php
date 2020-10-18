<?php
/**
 * User: Bosen
 * Date: 2020/6/20
 * Time: 10:48
 */

namespace app\merchant\controller;

use app\merchant\model\Merchant;
use think\Controller;
use think\facade\Session;

class  Login extends Controller {
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
        $mb = Merchant::where('mt_name',$params['name'])
            ->field(['mt_name','mt_pwd','mt_head_img','id','mt_status'])->find();
        if ($mb!=null||$mb!=''){
            if ($mb['mt_status']==0){
                $this->error('您的审核还未通过，请耐心等待');
            }
            if ($mb['mt_pwd']==md5($params['pass'])){
                Session::set('mt_name',$params['name']);
                Session::set('mt_id',$mb['id']);
                Session::set('mt_head_img',$mb['mt_head_img']);
                $this->redirect("/merchant");
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
        $mb_name = Merchant::where("mt_name", $params['name'])->find();
        if ($mb_name!=''||$mb_name!=null){
            $this->error("该名称已被注册");
        }
        //判断邮箱是否已被注册
        $mb_email = Merchant::where("mt_email", $params['email'])->find();
        if ($mb_email!=''||$mb_email!=null){
            $this->error("该邮箱已注册过");
        }
        //生成验证码
        $email_code = mt_rand(100000,999999);
        Session::set('email_code', $email_code);
        //记录用户信息
        Session::set('sign_mt_name',$params['name']);
        Session::set('sign_mt_email',$params['email']);
        Session::set('sign_mt_pwd',$params['pwd']);
        if (mailto($params['email'],$email_code)){
            $this->redirect("/merchant/login/input_code");
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
            $sql = Merchant::create([
                'mt_name'    => Session::get('sign_mt_name'),
                'mt_pwd'     => md5(Session::get('sign_mt_pwd')),
                'mt_email'   => Session::get('sign_mt_email')
            ]);
            if ($sql){
                $this->success("注册成功，请耐心等待管理员审核，通过后将由邮箱通知您","/merchant/login",null,10);
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
        $mt_email = Merchant::where("mt_email", $email)->find();
        if ($mt_email==''||$mt_email==null){
            $this->error("该邮箱还未在此注册过");
        }else{
            //生成验证码
            $forgot_code = mt_rand(100000,999999);
            Session::set('forgot_mt_code',$forgot_code);
            //记录忘记密码的用户邮箱
            Session::set('forgot_mt_email',$email);
            if (mailto($email,$forgot_code)){
                $this->redirect("/merchant/login/input_forgot_code");
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
        if ($code == Session::get('forgot_mt_code')){
            $this->redirect("/mt/login/mt_update_pwd");
        }else{
            $this->error("验证码有误，请重新输入");
        }
    }
    //修改密码
    public function mt_update_pwd(){
        return $this->fetch();
    }
    public function update_pwd_adction(){
        $pwd = input('pwd');
        $re_pwd = input('re_pwd');
        if ($pwd==$re_pwd){
            $sql = Merchant::where('mt_name',Session::get('mt_name'))
                ->update([
                    'mt_pwd' => md5($pwd)
                ]);
            if ($sql || $sql==0){
                Session::set('mt_name',null);
                $this->success("修改密码成功，正在跳转至登陆页面","/merchant/login");
            }
        }else{
            $this->error("两次密码输入不一");
        }
    }
    public function out_login(){
        Session::set('mt_name',null);
        $this->redirect("/merchant");
    }
}