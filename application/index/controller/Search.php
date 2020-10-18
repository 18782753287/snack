<?php
/**
 * User: Bosen
 * Date: 2020/6/29
 * Time: 15:39
 */

namespace app\index\controller;

use app\index\model\Goods;
use think\Controller;
use think\facade\Session;
use app\index\model\Merchant;

class Search extends Controller {
    public function index(){
        $flag = input('flag');
        //店铺
        $merchant = Merchant::where('mt_name','like','%'.$flag.'%')
            ->select();
        //商品
        $goods = Goods::where('goods_name','like','%'.$flag.'%')
            ->whereOr('goods_describe','like','%'.$flag.'%')
            ->select();
        $mb_name = Session::get('mb_name');
        $mb_head_img = Session::get('mb_head_img');
        $this->assign([
            'mb_name'       => $mb_name,
            'mb_head_img'   => $mb_head_img,
            'merchant'      => $merchant,
            'goods'         => $goods,
            'flag'          => $flag,
        ]);
        return $this->fetch();
    }
}