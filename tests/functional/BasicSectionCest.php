<?php

use craft\base\Element;
use craft\elements\Entry;
use craft\elements\User;
use yii\base\Event;
use craft\events\ModelEvent;

function d(...$args) {
    //$trace = debug_backtrace(false, 1);
    fwrite(STDERR, print_r($args, true));
    //fwrite(STDERR, json_encode($trace, JSON_PRETTY_PRINT));
}

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
                            'sectionHeading' => 'testing sectionHeading',
                        ],
                    ],
                ],
                'sortOrder' => [
                    'new1',
                ],
            ],
        ]);

        /*
        Event::on(Entry::class, Element::EVENT_BEFORE_SAVE, function(ModelEvent $e) {
            d('EVENT_BEFORE_SAVE');
        });

        Event::on(Entry::class, Element::EVENT_AFTER_SAVE, function(ModelEvent $e) {
            d('EVENT_AFTER_SAVE');
        });

        Event::on(Entry::class, Element::EVENT_AFTER_PROPAGATE, function(ModelEvent $e) {
            d('EVENT_AFTER_PROPAGATE');
        });
         */

        Craft::$app->elements->saveElement($entry);

        d('here');
        d($entry->getFieldValue('contentDesigner')->count());

        $I->amOnPage("/$slug");
        $I->see('sectionHeading');
    }
}
