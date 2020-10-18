<?php
/**
 * User: Bosen
 * Date: 2020/6/26
 * Time: 21:17
 */

namespace app\merchant\controller;

use app\merchant\model\Member as Mb;
use app\login_check\merchant_login_check;

class Member extends merchant_login_check {
    public function index(){
        $mbs = Mb::where('id','>=',1)
            ->select();
        $this->assign([
            'mbs'   =>$mbs,
        ]);
        return $this->fetch();
    }
}