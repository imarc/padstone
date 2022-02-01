<?php

use craft\elements\Entry;
use craft\elements\User;

class BasicSectionCest
{
    protected $section = null;
    protected $author = null;

    public function _before()
    {
        $this->section = Craft::$app->sections->getSectionByHandle('pages');
        $this->entryType = current($this->section->getEntryTypes());

        $this->author = User::find()->admin()->one();
    }

    public function canAddSectionToHomepage(FunctionalTester $I)
    {
        $faker = Faker\Factory::create();
        $title = $faker->words(5, true);
        $slug = $faker->slug();
        $sectionHeading = $faker->words(5, true);

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

        $entry->setFieldValues([
            'contentDesigner' => [
                'blocks' => [
                    'new1' => [
                        'modified' => 1,
                        'type' => 'basic',
                        'level' => 0,
                        'enabled' => true,
                        'collapsed' => false,
                        'fields' => [
                            'sectionHeading' => $sectionHeading,
                        ],
                    ],
                ],
                'sortOrder' => [
                    'new1',
                ],
            ],
        ]);

        Craft::$app->elements->saveElement($entry);

        $I->amOnPage("/$slug");
        $I->see($sectionHeading);
    }
}
