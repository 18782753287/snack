<?php
/**
 * User: Bosen
 * Date: 2020/7/16
 * Time: 16:49
 */

namespace app\admin\controller;

use app\admin\model\Access;
use app\admin\model\Admin;
use app\admin\model\AdminRole;
use app\admin\model\Role;
use app\admin\model\RoleAccess;
use app\login_check\admin_login_check;
use think\Db;

class Rbac extends admin_login_check {
    public function index(){
        $admin_info = Db::name('admin')->where('id','>',0)->select();
        //将角色信息附加到admin_info中
        foreach ($admin_info as $key=>$val){
            $admin_role = AdminRole::where('admin_id',$val['id'])
                ->field(['admin_id','role_id'])->find();
            if (!empty($admin_role)){
                $role_name = Role::where('id',$admin_role['role_id'])
                    ->value('role_name');
                $admin_info[$key]['role_name'] = $role_name;
            }
        }
        //获取权限信息
        $access = Access::where('id','>',0)->select();
        //解析json
        foreach($access as $key=>$val){
            $val['url'] = json_decode($val['url']);
        }
        //获取角色权限信息
        $role_access = RoleAccess::where('id','>',0)->select();
        //获取角色信息
        $roles = Role::where('id','>',0)->select();

        $this->assign([
            'admins'            => $admin_info,
            'roles'             => $roles,
            'access'            => $access,
            'role_access'       => $role_access,
            'role_access_count'=> count($access)
        ]);
        return $this->fetch();
    }

    public function roleAccessInfo(){
        $role_id = input('role_id');
        //获取权限信息
        $access = Access::where('id','>',0)->select();
        //解析json
        foreach($access as $key=>$val){
            $val['url'] = json_decode($val['url']);
        }
        //获取角色权限信息
        $role_access = RoleAccess::where('role_id',$role_id)->select();
        //获取角色信息
        $role = Role::where('id',$role_id)->find();

        $this->assign([
            'role'             => $role,
            'access'            => $access,
            'role_access'       => $role_access,
            'role_access_count'=> count($access)
        ]);
        return $this->fetch();
    }

    /**
     * 添加角色
     * @author Bosen
     */
    public function addRole(){
        $role_name = input('role_name');
        if ($role_name==null){
            $this->error('角色名不能为空');
        }
        //判断是否已存在该名称的角色
        $flag = Role::where('role_name',$role_name)->count();
        if ($flag>0){
            $this->error('此角色已经存在，请勿重复添加');
        }
        $sql = Role::create([
            'role_name'     => $role_name,
            'create_time'   => date("Y-m-d H:i:s",time()),
        ]);
        if ($sql){
            $this->success('添加成功');
        }else{
            $this->error('添加时发生了错误');
        }
    }

    /**
     * 删除角色
     * @author Bosen
     */
    public function deleteRole(){
        $role_id = input('role_id');
        $sql = Role::destroy($role_id);
        if ($sql){
            $this->success('删除成功');
        }else{
            $this->error('删除时发生了错误');
        }
    }

    /**
     * 修改角色
     * @author Bosen
     */
    public function updateRole(){
        $role_name = input('role_name');
        $role_id = input('role_id');
        //判断是否已存在该名称的角色
        $flag = Role::where('role_name',$role_name)->count();
        if ($flag>0){
            $this->error('已存在该名称');
        }
        $sql = Role::where('id',$role_id)->update([
            'role_name'     => $role_name,
            'update_time'   => null,
        ]);
        if ($sql){
            $this->success('修改成功');
        }else{
            $this->error('修改时发生了错误');
        }
    }

    /**
     * 删除用户
     * @author Bosen
     */
    public function deleteAdmin(){
        $admin_id = input('admin_id');
        if ($admin_id==1){
            $this->error('此账号为系统默认最高权限用户，无法删除');
        }
        $sql = Admin::destroy($admin_id);
        if ($sql){
            $this->success('删除成功');
        }else{
            $this->error('删除时出现了错误');
        }
        var_dump($admin_id);
    }

    /**
     * 更改用户的角色
     * @author Bosen
     */
    public function updateAdminRole(){
        $radio = input('radio');
        $admin_id = input("admin_id");
        if ($admin_id==1){
            $this->error('此账号为系统默认最高权限用户，无法修改');
        }
        //获取对应的角色id
        $role_id = Role::where('role_name',$radio)->value('id');
        $sql = AdminRole::where('admin_id',$admin_id)->update([
            'role_id'   => $role_id,
        ]);
        if ($sql){
            $this->success('修改成功');
        }else{
            $this->error('修改时发生了错误');
        }
    }

    /**
     * 添加权限
     * @author Bosen
     */
    public function addAccess(){
        $title = input('title');
        $url = input('url');
        if ($title==null || $url==null){
            $this->error('内容不能为空');
        }
        $sql = Access::create([
            'title' => $title,
            'url'   => json_encode($url),
        ]);
        if ($sql){
            $this->success('添加成功');
        }else{
            $this->error('添加时发生了错误');
        }
    }

    /**
     * 删除权限
     * @author Bosen
     */
    public function deleteAccess(){
        $access_id = input('access_id');
        $sql = Access::destroy($access_id);
        if ($sql){
            $this->success('删除成功');
        }else{
            $this->error('删除时发生了错误');
        }
    }

    /**
     * 修改权限
     * @author Bosen
     */
    public function updateAccess(){
        $access_id = input('acc_id');
        $access_tile = input('acc_title');
        $access_url = input('acc_url');
        $flag = input('flag');
        if ($flag==null){
            $sql = Access::where('id',$access_id)->update([
                'title' => $access_tile,
                'status'=> 0,
                'url'   => json_encode($access_url),
            ]);
        }else{
            $sql = Access::where('id',$access_id)->update([
                'title' => $access_tile,
                'status'=> 1,
                'url'   => json_encode($access_url),
            ]);
        }

        if ($sql){
            $this->success('修改成功');
        }else{
            $this->error('修改时发生了错误');
        }
    }

    /**
     * 设置角色权限
     * @author Bosen
     */
    public function updateRoleAccess(){
        $params = input('post.');
        $role_id = $params['role_id'];
        array_pop($params);
        $params = array_values($params);
        //修改前清空角色原来的权限
        $count = Db::name('role_access')->where('role_id',$role_id)->count();
        $sql = Db::name('role_access')->where('role_id',$role_id)->delete();
        if ($count!=0 && !$sql){
            $this->error('角色权限初始化失败');
        }
        for($i=0;$i<count($params);$i++){
            $sql = RoleAccess::create([
                'role_id'   => $role_id,
                'access_id' => $params[$i],
            ]);
            if (!$sql){
                $this->error('设置权限时出现了错误');
            }
        }
        $this->success('设置权限成功');
    }
}