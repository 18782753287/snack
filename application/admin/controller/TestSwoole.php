<?php

namespace app\admin\controller;

use swoole_process;
use think\Controller;

class TestSwoole extends Controller {
    public function index(){
        $workers = [];
        $worker_num = 2;

        // 批量创建进程
        for ($i=0;$i<$worker_num;$i++){
            $process = new swoole_process(function(swoole_process $process){
                    $recv = $process->pop();
                    echo "从主进程获取数据：$recv\n";
                    NoticeService::index();// 调用处理消息队列的方法
                    $process->exit(0);
            },false,false);
            $process->useQueue();// 开启队列
            $pid = $process->start();
            $workers[$pid] = $process;
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
    }
}