<?php
/**
 * User: Bosen
 * Date: 2020/7/23
 * Time: 20:42
 */

namespace app\index\controller;

use app\index\model\Member;
use app\index\model\Notice as modelNotice;
use app\login_check\member_login_check;
use think\facade\Session;

class Notice extends member_login_check {
    public function index(){
        $notice = modelNotice::where('mb_id',Session::get('mb_id'))->select();
        $mb_name = Session::get('mb_name');
        $mb_head_img = Member::where('id',Session::get('mb_id'))->value('mb_head_img');
        $this->assign([
            'notice'        => $notice,
            'mb_name'       => $mb_name,
            'mb_head_img'   => $mb_head_img,
        ]);
        return $this->fetch();
    }
}