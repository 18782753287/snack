<?php
/**
 * User: Bosen
 * Date: 2020/6/21
 * Time: 14:52
 */

namespace app\merchant\controller;

use app\login_check\merchant_login_check;
use app\merchant\model\Goods as MtGoods;
use think\Db;
use think\facade\Session;

class Goods extends merchant_login_check{

    public function index(){
        $params = input('post.');
        $num = 1;
        if ($params == null){
            $params['update'] = null;
        }
        if ($params['update'] == '下一页'){
            $num=$params['num']+1;
        }
        if ($params['update'] == '上一页'){
            $num=$params['num']-1;
            if ($num<=1){
                $num=1;
            }
        }
        $goods = MtGoods::where("goods_merchant",Session::get('mt_name'))
            ->order('id','desc')->page($num,6)->select();
        $count = MtGoods::where("goods_merchant",Session::get('mt_name'))
            ->where('id','>=',1)->count();
        if ($num > ceil($count/6)){
            $num=ceil($count/6);
            if (ceil($count/6)==0){
                $num=1;
            }
            $goods = MtGoods::where("goods_merchant",Session::get('mt_name'))
                ->order('id','desc')->page($num,6)->select();
        }
        $this->assign("goods", $goods);
        $this->assign("num", $num);
        return $this->fetch();
    }
    //添加商品
    public function add_goods(){
        $goods_stocks = input('goods_stocks');
        $goods_name = input('goods_name');
        $goods_price = input('goods_price');
        $goods_describe = input('goods_describe');
        if($goods_describe==''||$goods_name==''||$goods_price==''){
            $this->error("请完整填写商品信息");
        }
        if (!preg_match("/^[1-9][0-9]*$/" ,$goods_stocks)){
                $this->error('库存请填写整数');
        }
        if (!is_numeric($goods_price)){
            $this->error('商品价格请填数字');
        }
        if ($goods_price<0.01){
            $this->error('商品价格最小值为0.01');
        }
        if ($_FILES["g_img"]["error"] > 0) {
            $this->error("上传图片时出现了错误");
        }
        else {
            $goods_img = get_img_url($_FILES["g_img"]["tmp_name"],"goods");
            if ($goods_img==false){
                $this->error("图片在保存时出现错误，请重新上传");
            }
        }
        $sql = MtGoods::create([
            'goods_name'    => $goods_name,
            'goods_price'   => $goods_price,
            'goods_describe'=> $goods_describe,
            'goods_stocks'  => $goods_stocks,
            'goods_img'     => $goods_img,
            'goods_merchant'=> Session::get('mt_name')
        ]);
        if ($sql){
            $this->success("添加商品成功",'/merchant/goods');
        }else{
            $this->error("添加商品超时，请重新添加");
        }
    }
    //修改和删除商品
    public function update_goods(){
        $update = input('update');
        $delete = input('delete');
        $g_name = input('g_name');
        $g_id = input('g_id');
        $g_stocks = input('g_stocks');
        $g_describe = input('g_describe');
        $g_price = input('g_price');
        //记录原本的图片信息
        $old_img = MtGoods::where('id',$g_id)->field('goods_img')->find();
        //修改
        if ($update!=''){
            if ($_FILES["g_img"]["error"] > 0) {
                $g_img = $old_img['goods_img'];
            }
            else {
                $g_img = get_img_url($_FILES["g_img"]["tmp_name"],"goods");
                if ($g_img==false){
                    $this->error("图片在保存时出现错误，请重新上传");
                }else{
                    //删除原来的图片
                    del_img($old_img['goods_img']);
                }
            }
            if (!preg_match("/^[1-9][0-9]*$/" ,$g_stocks)){
                $this->error('库存请填写整数');
            }
            if ($g_name==''||$g_describe==''||$g_price==''){
                $this->error("请完整填写商品信息");
            }
            $sql1 = MtGoods::where('id',$g_id)->update([
                'goods_name'    => $g_name,
                'goods_price'   => $g_price,
                'goods_describe'=> $g_describe,
                'goods_img'     => $g_img,
                'goods_stocks'  => $g_stocks
            ]);
            if ($sql1){
                $this->success("修改商品成功",'/merchant/goods');
            }else{
                $this->error("修改时出现错误，请重新修改");
            }
        }
        //删除
        if ($delete!=''){
            var_dump($g_id);
            $sql2 = Db::name("goods")->where('id',$g_id)->delete();
            if ($sql2){
                //删除原来的图片
                del_img($old_img['goods_img']);
                $this->success("删除商品成功",'/merchant/goods');
            }else{
                $this->error("删除时出现了错误，请重新删除");
            }
        }
    }
}