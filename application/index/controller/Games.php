<?php
/**
 * User: Bosen
 * Date: 2020/6/23
 * Time: 20:09
 */

namespace app\index\controller;

use think\Controller;

class Games extends Controller {
    public function index(){
        return $this->fetch();
    }
}