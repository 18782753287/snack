<?php

namespace app\test\controller;
/**
 * redis swoole测试类
 * @author: Bosen
 * @date: 2020/8/30 14:07
 */

use app\test\model\Notice;
use app\utils\RedisUtil;
use think\Controller;
use think\Db;

class Index extends Controller {
    public function index(){
        phpinfo();
        /*return $this->fetch();*/
    }
    /*
     * 往redis中添加任务
     */
    public function notice(){
        $title = input('title');
        $content = input('content');
        for ($i=1;$i<=10;$i++){
            $notice = json_encode(array('mb_id'=>$i,'title'=>$title,'content'=>$content));
            RedisUtil::getInstance()->lPush('notice',$notice);
        }
        $this->success("发送信息成功");
    }
    /*
     * ajax处理redis队列
     */
    public function start(){
        return $this->fetch();
    }
    public function service(){
        if (RedisUtil::getInstance()->lLen('notice')!=0){
            $notice = json_decode(RedisUtil::getInstance()->rPop("notice"),true);
            $sql = Db::name('notice')->insert([
                'mb_id'     => $notice['mb_id'],
                'title'     => $notice['title'],
                'content'   => $notice['content'],
            ]);
            if (!$sql){
                // sql语句执行失败，回滚信息
                RedisUtil::getInstance()->rPush('notice',json_encode($notice));
            }
        }
    }
    /*
     * 查看redis notice队列状态
     */
    public function status(){
        echo "<h2>This is redis notice</h2>";
        var_dump(RedisUtil::getInstance()->lLen('notice'));
    }
}