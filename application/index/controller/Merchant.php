<?php
/**
 * User: Bosen
 * Date: 2020/6/23
 * Time: 21:27
 */

namespace app\index\controller;

use app\merchant\model\Goods;
use think\Controller;
use think\Db;
use think\facade\Session;

class Merchant extends Controller {
    public function index(){
        $mb_name = Session::get('mb_name');
        $mb_head_img = Session::get('mb_head_img');
        $merchant = input('merchant');
        //翻页
        //获取商品数量
        $g_count = \app\index\model\Goods::where('goods_merchant',$merchant)
            ->count();
        $num = input('num');
        $up = input('up');
        $low = input('low');
        if ($num=='')$num = 1;
        if ($up!=''){
            if ($num<$g_count/24)$num++;
        }
        if ($low!=''){
            if ($num!=1)$num--;
        }
        $goods = Goods::where('goods_merchant',$merchant)
            ->field(['id','goods_img',
                'goods_describe','goods_price','goods_merchant'])
            ->page($num,24)
            ->select();
        $mt_id = Db::name('merchant')
            ->where('mt_name',$merchant)
            ->value('id');
        $this->assign([
            'merchant'      => $merchant,
            'goods'         => $goods,
            'num'           => $num,
            'mb_name'       => $mb_name,
            'mb_head_img'   => $mb_head_img,
            'mt_id'         => $mt_id,
        ]);
        return $this->fetch();
    }
}