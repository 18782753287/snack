<?php

namespace app\test\controller;

class ConBuilder implements Builder {
    private $person;
    public function __construct(){
        $this->person = new Person();
    }

    function builderHead(){
        $this->person->setHead("建造一个人的头部");
    }

    function builderBody(){
        $this->person->setBody("建造一个人的身体");
    }

    function builderFoot(){
        $this->person->setFoot("建造一个人的腿部");
    }

    function builderPerson(){
        return $this->person->toString();
    }

}