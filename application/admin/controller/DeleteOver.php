<?php

namespace app\admin\controller;

use app\index\model\Goods;
use think\Controller;
use think\Db;

class DeleteOver extends Controller {
    public function index(){
        //删除过期的优惠卷
        Db::name('coupon')
            ->where('time','<',time())
            ->where('time','>',0)
            ->delete();

        //删除过期的订单
        Db::startTrans();
        try {
            $goods_num = Db::name('order')
                ->where('pay_status','=',0)
                ->where('time','<>',0)
                ->where('time','<',time())
                ->field(['goods_id','goods_num'])
                ->select();
            if ($goods_num!=null){
                Db::name('order')
                    ->where('pay_status','=',0)
                    ->where('time','<>',0)
                    ->where('time','<',time())
                    ->delete();
            }
            //恢复库存信息
            foreach ($goods_num as $key=>$val){
                $goods_stocks = Goods::where('id',$val['goods_id'])->value('goods_stocks');
                $res = Goods::where('id',$val['goods_id'])->update([
                    'goods_stocks'  => $goods_stocks+$val['goods_num']
                ]);
                if (!$res){
                    Db::rollback();
                }
            }
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
        }
    }
}