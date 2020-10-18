<?php

namespace app\test\controller;

class Director{
    public function createPerson(Builder $builder){
        $builder->builderHead();
        $builder->builderBody();
        $builder->builderFoot();
        return $builder->builderPerson();
    }
}