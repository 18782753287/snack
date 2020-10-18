<?php
/**
 * User: Bosen
 * Date: 2020/6/27
 * Time: 20:47
 */

namespace app\index\controller;

use app\index\model\Member;
use app\login_check\member_login_check;
use think\facade\Session;

class UpdateInfo extends member_login_check {
    public function index(){
        $mb_name = input('mb_name');
        if ($mb_name == ''){
            $this->error('用户名不能为空');
        }
        $old_name = input("old_name");
        $old_img = input('old_img');
        if ($_FILES["new_img"]["error"] > 0) {
            $sql = Member::where('mb_name',$old_name)
                ->update([
                    'mb_name'       =>$mb_name
                ]);
            if ($sql){
                Session::set('mb_name',$mb_name);
                $this->success('更改信息成功','/index/index/my_info');
            }else{
                $this->error('修改信息时发生了错误，请重新修改');
            }
        }
        else {
            $mb_img = get_img_url($_FILES["new_img"]["tmp_name"],"mb_head_img");
            if ($mb_img==false){
                $this->error("图片在保存时出现错误，请重新上传");
            }else{
                //删除原来的图片
                if ($old_img != '/static/img/head_img.jpg'){
                    del_img($old_img);
                }
            }
            $sql = Member::where('mb_name',$old_name)
                ->update([
                    'mb_name'       =>$mb_name,
                    'mb_head_img'   =>$mb_img,
                ]);
            if ($sql){
                Session::set('mb_name',$mb_name);
                $this->success('更改信息成功','/index/index/my_info');
            }else{
                $this->error('修改信息时发生了错误，请重新修改');
            }
        }
    }
}