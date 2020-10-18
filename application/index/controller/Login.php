<?php
/**
 * User: Bosen
 * Date: 2020/6/19
 * Time: 22:32
 */

namespace app\index\controller;

use app\test\model\Member;
use think\Controller;
use think\facade\Session;

class Login extends Controller {

    /**
     * 初始化
     * @access public
     * @return static
     */
    public static function getInstance($opt = [])
    {
        if (is_null(static::$instance)) {
            static::$instance = new static($opt);
        }
        return static::$instance;
    }

    public function index(){

        return $this->fetch();
    }
    public function out_login(){
        Session::set('mb_name',null);
        Session::set('mb_id',null);
        $this->redirect("/");
    }
    //检查
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
        $mb = Member::where('mb_name',$params['name'])
            ->field(['mb_name','mb_pwd','mb_head_img','id'])->find();
        if ($mb!=null||$mb!=''){
            if ($mb['mb_pwd']==md5($params['pass'])){
                Session::set('mb_name',$params['name']);
                Session::set('mb_id',$mb['id']);
                Session::set('mb_head_img',$mb['mb_head_img']);
                $this->redirect("/");
            }else{
                $this->error("密码错误，请重新输入");
            }
        }else{
            $this->error("不存在该用户");
        }
    }
    //注册
    public function sign_up(){
        $params = input('post.');
        if ($params['mb_name']==''||$params['mb_name']==null){
            $this->error("用户名不能为空");
        }
        if ($params['mb_pwd']==''||$params['mb_pwd']==null){
            $this->error("密码不能为空");
        }
        if (strlen($params['mb_pwd']) < 6){
            $this->error("密码最少为六位");
        }
        if ($params['mb_email']==''||$params['mb_email']==null){
            $this->error("邮箱不能为空");
        }
        //判断名字是否已被注册
        $mb_name = Member::where("mb_name", $params['mb_name'])->find();
        if ($mb_name!=''||$mb_name!=null){
            $this->error("该名称已被注册");
        }
        //判断邮箱是否已被注册
        $mb_email = Member::where("mb_email", $params['mb_email'])->find();
        if ($mb_email!=''||$mb_email!=null){
            $this->error("该邮箱已注册过");
        }
        //生成验证码
        $mb_code = mt_rand(100000,999999);
        Session::set('mb_code',$mb_code);
        Session::set('sign_mb_name', $params['mb_name']);
        Session::set('sign_mb_pwd', $params['mb_pwd']);
        Session::set('sign_mb_email', $params['mb_email']);
        if (mailto($params['mb_email'],$mb_code)){
            $this->redirect("/index/login/input_code");
        }else{
            $this->error("验证码发送失败，请检查您的邮箱是否可用");
        }

    }
    //注册验证码检查
    public function check_code(){

        $code = input('code');
        if ($code == Session::get('mb_code')){
            $sql = Member::create([
                'mb_name'   => Session::get('sign_mb_name'),
                'mb_pwd'    => md5(Session::get('sign_mb_pwd')),
                'mb_email'  => Session::get('sign_mb_email')
            ]);
            if ($sql){
                $this->success("注册成功，正在跳转至登陆页面","/index/login");
            }
        }else{
            $this->error("验证码有误，请重新输入");
        }
    }
    //忘记密码
    public function input_code(){
        return $this->fetch();
    }
    public function input_email(){
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
        $mb_email = Member::where("mb_email", $email)->find();
        if ($mb_email==''||$mb_email==null){
            $this->error("该邮箱还未在此注册过");
        }else{
            //生成验证码
            $forgot_code = mt_rand(100000,999999);
            Session::set('forgot_code',$forgot_code);
            //记录忘记密码的用户邮箱
            Session::set('forgot_mb_email',$email);
            if (mailto($email,$forgot_code)){
                $this->redirect("/index/login/input_forgot_code");
            }else{
                $this->error("邮件发送超时，请重试");
            }
        }
    }
    //忘记密码验证码检查
    public function input_forgot_code(){
        return $this->fetch();
    }
    public function check_forgot_code(){
        $code = input('code');
        if ($code == Session::get('forgot_code')){
            $this->redirect("/index/login/mb_update_pwd");
        }else{
            $this->error("验证码有误，请重新输入");
        }
    }
    //修改密码
    public function mb_update_pwd(){
        return $this->fetch();
    }
    public function update_pwd_adction(){
        $pwd = input('pwd');
        $re_pwd = input('re_pwd');
        if ($pwd==$re_pwd){
            if (Session::get('mb_id')==''){
                $sql = Member::where('mb_email',Session::get('forgot_mb_email'))
                    ->update([
                        'mb_pwd' => md5($pwd)
                    ]);
            }else{
                $sql = Member::where('id',Session::get('mb_id'))
                    ->update([
                        'mb_pwd' => md5($pwd)
                    ]);
            }
            if ($sql || $sql==0){
                Session::set('mb_name',null);
                Session::set('mb_id',null);
                $this->success("修改密码成功，正在跳转至登陆页面","/index/login");
            }
        }else{
            $this->error("两次密码输入不一");
        }
    }
}