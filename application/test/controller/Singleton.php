<?php

namespace app\test\controller;

/**
 * 单例设计模式
 * @author: Bosen
 * @date: 2020/9/2 10:34
 */
class Singleton{
    private static $instance = null;
    public function getInstance(){
        if (self::$instance==null){
            self::$instance = new self();
        }
        return self::$instance;
    }
}