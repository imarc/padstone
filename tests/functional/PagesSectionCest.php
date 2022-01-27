<?php

use craft\elements\Entry;
use craft\elements\User;

class PagesSectionCest
{
    protected $section = null;
    protected $author = null;

    public function _before()
    {
        $this->section = Craft::$app->sections->getSectionByHandle('pages');
        $this->entryType = current($this->section->getEntryTypes());

        $this->author = User::find()->admin()->one();
    }

    public function canCreateEntry(FunctionalTester $I)
    {
        $faker = Faker\Factory::create();
        $title = $faker->words(5, true);
        $slug = $faker->slug();

        $entry = new Entry([
            'sectionId' => $this->section->id,
            'typeId' => $this->entryType->id,
            'fieldLayoutId' => $this->entryType->fieldLayoutId,
            'authorId' => $this->author->id,
            'title' => $title,
            'slug' => $slug,
            'postDate' => new DateTime(),
        ]);

        Craft::$app->elements->saveElement($entry);

        $I->amOnPage("/$slug");
        $I->see($title);
    }
}
