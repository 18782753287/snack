<?php

namespace app\utils;
/**
 * reids工具类
 * @author: Bosen
 * @date: 2020/8/31 12:59
 */
class RedisUtil{

    private static $instance = NULL;

    /*
     * 连接redis
     */
    public static function getInstance()
    {
        if (!self::$instance) {
            $redis = new \Redis();
            $redis->connect('127.0.0.1', 6379);
            $redis->auth('23');
            self::$instance = $redis;
        }
        return self::$instance;
    }
}