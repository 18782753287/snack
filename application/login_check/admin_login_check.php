<?php
/**
 * User: Bosen
 * Date: 2020/6/19
 * Time: 22:11
 */

namespace app\login_check;

use app\admin\model\Access;
use app\admin\model\AdminRole;
use app\admin\model\RoleAccess;
use think\Controller;
use think\facade\Session;

class admin_login_check extends Controller {
    public function __construct(){
        parent::__construct();
        $admin_name = Session::get("admin_name");
        if ($admin_name == null){
            $this->redirect('../admin/login/');
        }
        $this->checkAccess();//权限检查
    }

    /**
     * 查看用户权限
     * @author Bosen
     */
    public function checkAccess(){
        $admin_id = Session::get('admin_id');
        if ($admin_id!=1){
            $curr_url = parse_url($_SERVER["REQUEST_URI"],PHP_URL_PATH);
            $role_id = AdminRole::where('admin_id',$admin_id)->value('role_id');
            $access_id = RoleAccess::where('role_id',$role_id)->field('access_id')->select();
            $access_urls = array();
            foreach ($access_id as $key=>$val){
                $access_urls[] = @json_decode(Access::where('id',$val['access_id'])
                    ->where('status',1)->value('url'));
            }
            $flag = false;//判断是否有权限访问该地址
            foreach ($access_urls as $key=>$val){
                if ($curr_url==$val){
                    $flag=true;
                }
            }
            if ($flag==false){
                $this->error('你还未拥有此权限');
            }
        }
    }
}