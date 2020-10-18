<?php

$workers = [];
$worker_num = 2;

// 批量创建进程
for ($i=0;$i<$worker_num;$i++){
    $process = new swoole_process('doProcess',false,false);
    $process->useQueue();// 开启队列
    $pid = $process->start();
    $workers[$pid] = $process;
}

// 进程执行函数
function doProcess(swoole_process $process){
    $recv = $process->pop();
    echo "从主进程获取数据：$recv\n";
    echo "调用方法：NoticeService\n";
    require_once '../admin/controller/NoticeService.php';
    $notice = new NoticeService();
    $notice->index();
    sleep(3);
    $process->exit(0);
}

// 从主进程添加数据
foreach ($workers as $pid=>$process){
    $process->push("hello 子进程$pid\n");
}

// 等待子进程结束  回收资源
for ($i=0;$i<$worker_num;$i++){
    $ret = swoole_process::wait();
    $pid = $ret['pid'];
    unset($workers[$pid]);
    echo "子进程$pid 退出\n";
}
