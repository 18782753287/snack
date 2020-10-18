<?php
/**
 * User: Bosen
 * Date: 2020/6/20
 * Time: 10:47
 */

namespace app\login_check;

use app\merchant\model\Coupon;
use think\Controller;
use think\Db;
use think\facade\Session;

class merchant_login_check extends Controller {
    public function __construct(){
        parent::__construct();
        //Session::set("mt_name",null);
        $mt_name = Session::get("mt_name");
        if ($mt_name == null){
            $this->redirect('../merchant/login/');
        }
    }
}