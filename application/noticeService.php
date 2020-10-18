<?php
ignore_user_abort(); // 用户退出继续执行
set_time_limit(0); // 永远不超时
$redis = new \Redis();
$redis->connect('127.0.0.1',6379);
while (true){
    //任务处理完后清除缓存
    if ($redis->lLen('mb_id')==0){
        $redis->flushAll();
        echo "清除缓存\n";
    }else{
        echo "执行任务\n";
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
    sleep(1);
}
?>