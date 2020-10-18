<?php
/**
 * User: Bosen
 * Date: 2020/6/26
 * Time: 21:17
 */

namespace app\admin\controller;

use app\admin\model\Member as Mb;
use app\login_check\admin_login_check;

class Member extends admin_login_check {
    public function index(){
        $mbs = Mb::where('id','>=',1)
            ->select();
        $this->assign([
            'mbs'   =>$mbs,
        ]);
        return $this->fetch();
    }
}