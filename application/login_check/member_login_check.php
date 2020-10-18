<?php
/**
 * User: Bosen
 * Date: 2020/6/25
 * Time: 14:52
 */

namespace app\login_check;

use app\merchant\model\Coupon;
use think\Controller;
use think\Db;
use think\facade\Session;

class member_login_check extends Controller {
    public function __construct(){
        parent::__construct();
/*        Session::set('mb_name','***');
        Session::set('mb_id','111');*/
        $mb_name = Session::get("mb_name");
        if ($mb_name == null){
            $this->error('请先完成登陆','/index/login');
        }
    }
}