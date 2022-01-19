<?php

use craft\elements\Entry;

class KeyPagesCest
{
    public function homepageReturns200(AcceptanceTester $I)
    {
        $I->amOnPage('/');
        $I->seeResponseCodeIs(200);
    }

    public function canSeeHeadline(AcceptanceTester $I)
    {
        $faker = Faker\Factory::create();
        $entry = Entry::find()->section('homepage')->one();

        $headline = $faker->realText(100);

        $entry->setFieldValues([
            'hero' => [
                [
                    'type' => 'standardHero',
                    'fields' => [
                        'headline' => $headline,
                    ],
                ],
            ],
        ]);
        Craft::$app->elements->saveElement($entry);

        $I->amOnPage('/');
        $I->see($headline);
    }
}
