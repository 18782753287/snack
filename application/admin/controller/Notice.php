<?php
/**
 * User: Bosen
 * Date: 2020/7/23
 * Time: 21:09
 */

namespace app\admin\controller;

use app\admin\model\Natice;
use app\admin\model\Member;
use app\login_check\admin_login_check;
use app\utils\RedisUtil;
use think\Db;

class Notice extends admin_login_check {
    public function index(){
        return $this->fetch();
    }
    /*
     * 查看redis notice队列状态
     */
    public function status(){
        echo "<h2>This is redis notice</h2>";
        var_dump(RedisUtil::getInstance()->lLen('mb_id'));
    }
    //将任务信息存入redis
    public function action(){

        /******测试用户数量******/
        $num = 100;
        /**********************/

        $redis = new \Redis();
        $redis->connect('127.0.0.1',6379);
        $content = input('content');
        $title = input('title');
        if ($title=='' || $title==null){
            $this->error('标题不能为空');
        }
        if ($content=='' || $content==null){
            $this->error('内容不能为空');
        }
        //存入标题和内容
        $redis->set('title',$title);
        $redis->set('content',$content);
        //获取用户ID信息
        $mbs_id = Member::where('id','>',0)->field(['id'])->select();
        if (empty($mbs_id)){
            $this->error('此网站还未有注册过的会员');
        }
        //存入用户ID
        for($i=1;$i<=$num;$i++){
            //将信息存入到redis
            $redis->lPush('mb_id',$i);
        }
        $this->success('群发通知发送成功');
    }
    public function serviceStart(){
        return $this->fetch();
    }
    public function service(){
        $redis = new \Redis();
        $redis->connect('127.0.0.1',6379);
        if ($redis->lLen('mb_id')==0){
            //消息已发送完毕，释放内存
            $redis->flushAll();
        }else{
            //执行发送任务
            $mb_id = $redis->rPop('mb_id');
            //发送信息
            $sql = Db::name('notice')->insert([
                'mb_id'     => $mb_id,
                'title'     => $redis->get('title'),
                'content'   => $redis->get('content'),
            ]);
            if (!$sql){//插入失败，将ID信息回滚
                $redis->rPush('mb_id',$mb_id);
            }
        }
    }
}