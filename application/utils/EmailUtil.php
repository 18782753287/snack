<?php
namespace app\utils;

use PHPMailer\PHPMailer;
use think\facade\Session;

/**
 * 邮箱发送工具类
 * @author: Bosen
 * @date: 2020/8/30 21:07
 */
class EmailUtil{
    public static function getInstance(){
        return new EmailUtil();
    }
    /* 发送邮件方法
     * @param $to：接收者 $title：标题 $content：邮件内容
     * @return bool true:发送成功 false:发送失败
     */
    public function sendMail($to,$title,$content) {
        if ($this->checkEmail($to)!=1){
            jsError("邮箱格式不合法，请检查后再试");
        }
        // 这个PHPMailer 就是之前从 Github上下载下来的那个项目
        $mail = new PHPMailer();
        //使用smtp鉴权方式发送邮件
        $mail->isSMTP();
        //smtp需要鉴权 这个必须是true
        $mail->SMTPAuth = true;
        // qq 邮箱的 smtp服务器地址，这里当然也可以写其他的 smtp服务器地址
        $mail->Host = 'smtp.163.com';
        //smtp登录的账号 这里填入字符串格式的qq号即可
        $mail->Username = config('system.EMAIL_USER');
        // 这个就是之前得到的授权码，一共16位
        $mail->Password = config('system.EMAIL_SMTP');
        $mail->setFrom(config('system.EMAIL_USER'), '百货商城网');
        // $to 为收件人的邮箱地址，如果想一次性发送向多个邮箱地址，则只需要将下面这个方法多次调用即可
        $mail->addAddress($to);
        // 该邮件的主题
        $mail->Subject = $title;
        // 该邮件的正文内容
        $mail->Body = $content;
        $mail->CharSet = "utf-8";

        // 使用 send() 方法发送邮件
        if(!$mail->send()) {
            return '发送失败: ' . $mail->ErrorInfo;
        } else {
            return "发送成功";
        }
    }
    /*
     * 检查邮箱格式是否合法
     */
    public function checkEmail($email){
        return preg_match("/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,})$/",$email);
    }
    /*
     * 生成六位数的验证码
     */
    public function emailCode(){
        $email_code = rand(100000,999999);
        Session::set('email_code',$email_code);
        return $email_code;
    }
    /*
     * 验证验证码
     */
    public function checkEmailCode($email_code){
        if ($email_code==Session::get('email_code')){
            return true;
        }else{
            return false;
        }
    }
}