<?php

use Craft;
use craft\elements\Entry;
use craft\elements\Category;

return [
    'defaults' => [
        'elementType' => Entry::class,
        'elementsPerPage' => 9,
        'transformer' => function($element) {
            return [
                'title'=> $element->title,
                'slug' => $element->slug,
            ];
        },
    ],

    'endpoints' => [

        'resources.json' => function() {
            $criteria  = ['section' => 'resources'];
            $relatedTo = array();

            $criteria['orderBy'] = Craft::$app->request->getQueryParam('orderBy', ['resourceDate' => SORT_DESC, 'title' => SORT_ASC]);

            if ($search = Craft::$app->request->getQueryParam('search')) {
                $criteria['search'] = $search;
            }

            $resourceType  = Craft::$app->request->getQueryParam('type');
            $resourceTopic = Craft::$app->request->getQueryParam('topic');


            if ($resourceType && $resourceTopic) {
                $relatedTo[] = 'and';
            }

            if ($resourceType) {
                $category = Category::findOne([
                    'group' => 'resourceTypes',
                    'slug' => $resourceType
                ]);

                $relatedTo[] = ["targetElement" => $category];
            }    

            if ($resourceTopic) {
                $category = Category::findOne([
                    'group' => 'resourceTopics',
                    'slug' => $resourceTopic
                ]);

                $relatedTo[] = ["targetElement" => $category];
            }

            $criteria['relatedTo'] = $relatedTo;

            return [
                'criteria' => $criteria,
                'transformer' => function(Entry $entry) {
                    if ($entry->type == 'resourceLink') {
                        $url = $entry->resourceUrl->url;
                        $cta = $entry->resourceUrl->text ?: 'More';
                    } else {
                        $url = $entry->url;
                        $cta = $entry->resourceCTA ?: 'More';
                    }

                    return [
                        'title' => $entry->title,
                        'type' => $entry->type->handle,
                        'description' => $entry->resourceDescription,
                        'id' => $entry->id,
                        'url' => $url,
                        'cta' => $cta,
                        'date' => $entry->resourceDate->format('F jS, Y'),
                    ];
                },
            ];
        },
        'resources/<entryId:\d+>.json' => function($entryId) {
            return [
                'criteria' => ['id' => $entryId, 'section' => 'resources'],
                'one' => true,
                'transformer' => function(Entry $entry) {
                    return [
                        'id' => $entry->id,
                        'title' => $entry->title,
                        'url' => $entry->url,
                        'description' => $entry->resourceDescription,
                    ];
                },
            ];
        },

        'resourceTypes.json' => function() {
            return [
                'elementType' => Category::class,
                'elementsPerPage' => 100,
                'criteria' => ['group' => 'resourceTypes'],
            ];
        },
        

        'resourceTopics.json' => function() {
            return [
                'elementType' => Category::class,
                'elementsPerPage' => 100,
                'criteria' => ['group' => 'resourceTopics'],
            ];
        },
    ],
];
