<?php

class ElementApiCest
{
    public function _before(ApiTester $I)
    {
        //
    }

    public function canGetBlogArticles(ApiTester $I)
    {
        $response = $I->sendGet('/blogs.json');
        $I->seeResponseCodeIs(200);
        $I->seeResponseIsJson();
    }
}
