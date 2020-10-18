<?php
/**
 * User: Bosen
 * Date: 2020/7/13
 * Time: 15:07
 */

namespace app\merchant\controller;

use app\login_check\merchant_login_check;
use app\merchant\model\Merchant;
use think\facade\Session;

class MtInfo extends merchant_login_check {
    public function index(){
        $mt = Merchant::where('id',Session::get('mt_id'))->find();
        $this->assign('mt',$mt);
        return $this->fetch();
    }
    public function info_action(){
        $mt_name = input('mt_name');
        if (!($_FILES["g_img_head"]["error"] > 0)){
            $g_img_head = get_img_url($_FILES["g_img_head"]["tmp_name"],"mt_head_img");
            //删除原来的图片
            $old_img = Merchant::where('id',Session::get('mt_id'))->value('mt_head_img');
            if ($old_img!=''){
                del_img($old_img);
            }
            Merchant::where('id',Session::get('mt_id'))->update([
                'mt_name'       => $mt_name,
                'mt_head_img'   => $g_img_head,
            ]);
        }
        Merchant::where('id',Session::get('mt_id'))->update([
            'mt_name'       => $mt_name,
        ]);
        Session::set('mt_name',$mt_name);
        if (!($_FILES["g_img1"]["error"] > 0)){
            $g_img1 = get_img1($_FILES["g_img1"]["tmp_name"],Session::get('mt_name'));
        }
        if (!($_FILES["g_img2"]["error"] > 0)){
            $g_img2 = get_img2($_FILES["g_img2"]["tmp_name"],Session::get('mt_name'));
        }
        if (!($_FILES["g_img3"]["error"] > 0)){
            $g_img3 = get_img3($_FILES["g_img3"]["tmp_name"],Session::get('mt_name'));
        }
        $this->success('修改成功');
    }
}