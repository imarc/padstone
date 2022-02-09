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
        $title = 'title_' . $faker->words(5, true);
        $slug = 'slug_' . $faker->slug();
        $sectionHeading = 'heading_' . $faker->words(5, true);

        $entry = new Entry([
            'sectionId' => $this->section->id,
            'typeId' => $this->entryType->id,
            'fieldLayoutId' => $this->entryType->fieldLayoutId,
            'authorId' => $this->author->id,
            'title' => $title,
            'slug' => $slug,
            'postDate' => new DateTime(),
        ]);

        //Craft::$app->elements->saveElement($entry);

        $entry->setFieldValue(
            'contentDesigner',
            [
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
        );

        $sections = $entry->getFieldValue('contentDesigner')->all();
        fwrite(STDERR, "count: " . count($sections) . "\n\n");
        if (count($sections) === 0) {
            throw new Exception("sections count is 0");
        }
        /*

        $I->saveElement($entry);

        // After save, this reference to $entry isn't very useful anymore, and it needs to be 'refreshed'
        //$sections = $entry->getFieldValue('contentDesigner')->all();
        //fwrite(STDERR, "count: " . count($sections) . "\n\n");

        // This version of entry actually has stuff
        $entry = Entry::find()->slug($slug)->one();
        $sections = $entry->getFieldValue('contentDesigner')->all();
        fwrite(STDERR, "count: " . count($sections) . "\n\n");


        $I->amOnPage("/$slug");
        $I->see($title);
        $I->see($sectionHeading);
        */
    }
}
