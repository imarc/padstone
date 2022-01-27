<?php

use craft\elements\Entry;

class HomepageCest
{
    public function canSeePage(FunctionalTester $I)
    {
        $I->amOnPage('/');
        $I->seeResponseCodeIs(200);
    }

    public function canSeeTitle(FunctionalTester $I)
    {
        $entry = Entry::find()->section('homepage')->one();

        $title = Faker\Factory::create()->realText(50);

        $entry->title = $title;
        Craft::$app->elements->saveElement($entry);

        $I->amOnPage('/');
        $I->see($title);
    }
}
