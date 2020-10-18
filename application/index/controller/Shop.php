<?php
/**
 * User: Bosen
 * Date: 2020/6/24
 * Time: 9:16
 */

namespace app\index\controller;

use app\index\model\Evaluate;
use app\index\model\Goods;
use app\index\model\Member;
use think\Controller;
use app\index\model\Merchant;
use think\Db;
use think\facade\Session;

class Shop extends Controller {
    public function index(){
        //获取用户信息
        $mb_name = Session::get('mb_name');
        $mb_head_img = Session::get('mb_head_img');
        $mb = Member::where('mb_name',$mb_name)->find();
        //获取商品信息
        $goods_id = input('goods_id');
        $good = Goods::where('id',$goods_id)->orderRand()->find();
        $goods = Goods::orderRand()->limit(0,20)->select();
        $mt_id = Merchant::where('mt_name',$good['goods_merchant'])
            ->value('id');
        $mt_goods = Goods::where('goods_merchant',$good['goods_merchant'])
            ->orderRand()
            ->limit(0,3)
            ->select();
        //获取商品评价信息
        $evaluate = Db::name('evaluate')
            ->order('id','desc')
            ->where('e_goods_id',$goods_id)
            ->select();
        $e_count = Evaluate::where('e_goods_id',$goods_id)->count();
        for($i=0;$i<$e_count;$i++){
            $mb = Db::name('member')
                ->where('id',$evaluate[$i]['e_mb_id'])
                ->find();
            $evaluate[$i]['e_mb_name'] = $mb['mb_name'];
            $evaluate[$i]['mb_head_img'] = $mb['mb_head_img'];
        }

        $this->assign([
            'mb_name'       => $mb_name,
            'good'          => $good,
            'goods'         => $goods,
            'mb_head_img'   => $mb['mb_head_img'],
            'evaluate'      => $evaluate,
            'e_count'       => $e_count,
            'mt_goods'      => $mt_goods,
            'mt_id'         => $mt_id,
            'mb_head_img'   => $mb_head_img,
        ]);
        return $this->fetch();
    }
    /**
     * @author Bosen
     * 商品评价
     */
    public function evaluate(){
        $e_content = input('e_content');
        $e_goods_id = input('e_goods_id');
        $e_mt_name = input('mt_name');
        $e_mb_id = Session::get('mb_id');
        $sql = Evaluate::create([
            'e_content'     =>$e_content,
            'e_goods_id'    =>$e_goods_id,
            'e_mt_name'     =>$e_mt_name,
            'e_mb_id'       =>$e_mb_id,
        ]);
        if ($sql){
            $this->redirect('/index/shop?goods_id='.$e_goods_id);
        }
    }
}