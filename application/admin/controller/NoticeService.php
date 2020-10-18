<?php
/**
 * User: Bosen
 * Date: 2020/8/14
 * Time: 11:18
 */

namespace app\admin\controller;

use think\Controller;
use think\Db;

class NoticeService extends Controller {
    public static function index(){
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