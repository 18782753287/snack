<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件

//app路径
define('__APP__', '/application');
//css文件路径
define('__CSS__', '/static/css');
//js文件路径
define('__JS__', '/static/js');
//img文件路径
define('__IMG__', '/static/img');
//会员默认头像路径
define('__MB_HEAD_IMG__', '/static/img/mb_head_img');
//登陆检查
define('__CHECK__', '/application/login_check');
//网页背景图
define('__BG_IMG__', '/static/img/bg.png');
//收银台背景图
define('__PAY_IMG__', '/static/img/pay.jpg');
//数据库保存的图片
define('__DATA__', '/static/data/');
//扩展路径
define('EXTEND_PATH','../extend/');


//redis
function redis(){
    return Cache::store('redis');
}
//判断邮箱是否合法
function check_email($email){
    return preg_match("/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/i",$email);
}
//生成二维码
function get_qr_code($url=""){
    include_once EXTEND_PATH . 'phpqrcode/phpqrcode.php';
    $data = $url;
    // 纠错级别：L、M、Q、H
    $level = 'H';
    // 点的大小：1到10,用于手机端4就可以了
    $size = 7;
    // 下面注释了把二维码图片保存到本地的代码,如果要保存图片,用$fileName替换第二个参数false
    //$path = "images/";
    // 生成的文件名
    //$fileName = $path.$size.'.png';
    QRcode::png($data, false, $level, $size);die();
}
//将图片保存在static
function get_img_url($file,$table){
    $fp = fopen($file,'rb');
    $str = '';
    while(!feof($fp)) {
        $str = $str.fgets($fp); //读取一行
    }
    $img_url = __DATA__.$table.'/'.time().rand(100000,999999).'.jpg';
    $data = fopen(getRoot().$img_url,'x');
    fwrite($data, $str);
    fclose($fp);
    return $img_url;
}
function get_img1($file,$mt_name){
    $fp = fopen($file,'rb');
    $str = '';
    while(!feof($fp)) {
        $str = $str.fgets($fp); //读取一行
    }
    $img_url = __IMG__.'/merchant/'.$mt_name.'1.jpg';
    $data = fopen(getRoot().iconv('utf-8', 'gbk', $img_url),'w+');
    fwrite($data, $str);
    fclose($fp);
    return $img_url;
}
function get_img2($file,$mt_name){
    $fp = fopen($file,'rb');
    $str = '';
    while(!feof($fp)) {
        $str = $str.fgets($fp); //读取一行
    }
    $img_url = __IMG__.'/merchant/'.$mt_name.'2.jpg';
    $data = fopen(getRoot().iconv('utf-8', 'gbk', $img_url),'w+');
    fwrite($data, $str);
    fclose($fp);
    return $img_url;
}
function get_img3($file,$mt_name){
    $fp = fopen($file,'rb');
    $str = '';
    while(!feof($fp)) {
        $str = $str.fgets($fp); //读取一行
    }
    $img_url = __IMG__.'/merchant/'.$mt_name.'3.jpg';
    $data = fopen(getRoot().iconv('utf-8', 'gbk', $img_url),'w+');
    fwrite($data, $str);
    fclose($fp);
    return $img_url;
}
//删除文件
function del_img($filename){
    unlink(getRoot().$filename);
}

//网站根目录
function getRoot(){
    $d = $_SERVER['DOCUMENT_ROOT'];
    return $d;
}

//发送邮件
use PHPMailer\PHPMailer\PHPMailer;
use think\facade\Cache;//引入邮件类
function mailto($user,$code){
    //实例化PHPMailer核心类
    $mail = new PHPMailer();

    //$mail->SMTPDebug = 1;#是否启用smtp的debug进行调试 开发环境建议开启 生产环境注释掉即可 默认关闭debug调试模式
    $mail->isSMTP(); #使用smtp鉴权方式发送邮件
    $mail->SMTPAuth = true; #smtp需要鉴权 这个必须是true
    $mail->Host = 'smtp.qq.com'; #链接qq域名邮箱的服务器地址

    $mail->SMTPSecure = 'ssl'; #设置使用ssl加密方式登录鉴权
    $mail->Port = 465; #设置ssl连接smtp服务器的远程服务器端口号

    $mail->CharSet = 'UTF-8'; #设置发送的邮件的编码
    $mail->FromName = '零食网'; #设置发件人昵称 显示在收件人邮件的发件人邮箱地址前的发件人姓名
    $mail->Username = 'bosen_qe@qq.com'; #smtp登录的账号
    $mail->Password = 'qpnmjbdjaqpcdjcg'; #smtp登录的密码 使用生成的授权码
    $mail->From = 'bosen_qe@qq.com'; #设置发件人邮箱地址 同登录账号

    //邮件正文是否为html编码
    $mail->isHTML(true);
    //设置收件人邮箱地址
    $mail->addAddress($user);
    //添加多个收件人 则多次调用方法即可
    //$mail->addAddress('xxx@qq.com');
    //添加该邮件的主题
    $mail->Subject = '验证码';
    //添加邮件正文
    $mail->Body = "您的验证码是：" . $code;
    //为该邮件添加附件
    //$mail->addAttachment('./example.pdf');
    //发送邮件 返回状态
    if ($mail->send()) {
        //成功
        return true;
    } else {
        //失败
        return false;
    }
}
//提醒商户审核通过
function remind_mt($user,$mt_name){
//实例化PHPMailer核心类
    $mail = new PHPMailer();

    //$mail->SMTPDebug = 1;#是否启用smtp的debug进行调试 开发环境建议开启 生产环境注释掉即可 默认关闭debug调试模式
    $mail->isSMTP(); #使用smtp鉴权方式发送邮件
    $mail->SMTPAuth = true; #smtp需要鉴权 这个必须是true
    $mail->Host = 'smtp.qq.com'; #链接qq域名邮箱的服务器地址

    $mail->SMTPSecure = 'ssl'; #设置使用ssl加密方式登录鉴权
    $mail->Port = 465; #设置ssl连接smtp服务器的远程服务器端口号

    $mail->CharSet = 'UTF-8'; #设置发送的邮件的编码
    $mail->FromName = '零食网'; #设置发件人昵称 显示在收件人邮件的发件人邮箱地址前的发件人姓名
    $mail->Username = 'bosen_qe@qq.com'; #smtp登录的账号
    $mail->Password = 'qpnmjbdjaqpcdjcg'; #smtp登录的密码 使用生成的授权码
    $mail->From = 'bosen_qe@qq.com'; #设置发件人邮箱地址 同登录账号

    //邮件正文是否为html编码
    $mail->isHTML(true);
    //设置收件人邮箱地址
    $mail->addAddress($user);
    //添加多个收件人 则多次调用方法即可
    //$mail->addAddress('xxx@qq.com');
    //添加该邮件的主题
    $mail->Subject = '商户账号审核通过提醒';
    //添加邮件正文
    $mail->Body = "您在零食网注册的商户账号已通过管理员的审核,账号名称为：$mt_name";
    //为该邮件添加附件
    //$mail->addAttachment('./example.pdf');
    //发送邮件 返回状态
    if ($mail->send()) {
        //成功
        return true;
    } else {
        //失败
        return false;
    }
}
//提醒新的管理员审核通过
function remind_admin($user,$admin_name){
//实例化PHPMailer核心类
    $mail = new PHPMailer();

    //$mail->SMTPDebug = 1;#是否启用smtp的debug进行调试 开发环境建议开启 生产环境注释掉即可 默认关闭debug调试模式
    $mail->isSMTP(); #使用smtp鉴权方式发送邮件
    $mail->SMTPAuth = true; #smtp需要鉴权 这个必须是true
    $mail->Host = 'smtp.qq.com'; #链接qq域名邮箱的服务器地址

    $mail->SMTPSecure = 'ssl'; #设置使用ssl加密方式登录鉴权
    $mail->Port = 465; #设置ssl连接smtp服务器的远程服务器端口号

    $mail->CharSet = 'UTF-8'; #设置发送的邮件的编码
    $mail->FromName = '零食网'; #设置发件人昵称 显示在收件人邮件的发件人邮箱地址前的发件人姓名
    $mail->Username = 'bosen_qe@qq.com'; #smtp登录的账号
    $mail->Password = 'qpnmjbdjaqpcdjcg'; #smtp登录的密码 使用生成的授权码
    $mail->From = 'bosen_qe@qq.com'; #设置发件人邮箱地址 同登录账号

    //邮件正文是否为html编码
    $mail->isHTML(true);
    //设置收件人邮箱地址
    $mail->addAddress($user);
    //添加多个收件人 则多次调用方法即可
    //$mail->addAddress('xxx@qq.com');
    //添加该邮件的主题
    $mail->Subject = '管理员账号审核通过提醒';
    //添加邮件正文
    $mail->Body = "您在零食网注册的管理员账号已通过超级管理员的审核,账号名称为：$admin_name";
    //为该邮件添加附件
    //$mail->addAttachment('./example.pdf');
    //发送邮件 返回状态
    if ($mail->send()) {
        //成功
        return true;
    } else {
        //失败
        return false;
    }
}
