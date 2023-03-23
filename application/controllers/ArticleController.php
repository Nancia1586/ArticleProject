<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class ArticleController extends CI_Controller {

    public function listeArticle() {
        $this->load->model('Article');
        $this->load->view('listeArticle');
    }
}
