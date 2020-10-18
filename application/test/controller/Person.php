<?php

namespace app\test\controller;

class Person{
    private $head;
    private $body;
    private $foot;
    public function toString(){
        echo "Person{head=$this->head,body=.$this->body,foot=.$this->foot}";
    }
    /**
     * @return mixed
     */
    public function getHead()
    {
        return $this->head;
    }

    /**
     * @param mixed $head
     */
    public function setHead($head)
    {
        $this->head = $head;
    }

    /**
     * @return mixed
     */
    public function getBody()
    {
        return $this->body;
    }

    /**
     * @param mixed $body
     */
    public function setBody($body)
    {
        $this->body = $body;
    }

    /**
     * @return mixed
     */
    public function getFoot()
    {
        return $this->foot;
    }

    /**
     * @param mixed $foot
     */
    public function setFoot($foot)
    {
        $this->foot = $foot;
    }

}