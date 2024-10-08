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

        'blogs.json' => function() {
            $criteria  = ['section' => 'blogArticle'];
            $relatedTo = array();

            $criteria['orderBy'] = Craft::$app->request->getQueryParam('orderBy', ['publicDate' => SORT_DESC, 'title' => SORT_ASC]);

            if ($search = Craft::$app->request->getQueryParam('search')) {
                $criteria['search'] = $search;
            }

            $blogCategory  = Craft::$app->request->getQueryParam('category');

            if ($blogCategory) {
                $category = Category::findOne([
                    'group' => 'blogCategories',
                    'slug' => $blogCategory
                ]);

                $criteria['relatedTo'] = ["targetElement" => $category];
            }

            return [
                'criteria' => $criteria,
                'elementType' => Entry::class,
                'transformer' => function(Entry $entry) {

                    return [
                        'title' => $entry->title,
                        'description' => $entry->abstract,
                        'image' => $entry->featuredImage->one() ? $entry->featuredImage->one()->url : 'https://via.placeholder.com/350x230',
                        'imageAltText' => $entry->featuredImage->one() ? $entry->featuredImage->one()->altText : null,
                        'id' => $entry->id,
                        'url' => $entry->url,
                        'cta' => 'More',
                        'date' => $entry->publicDate->format('F jS, Y'),
                    ];
                },
            ];
        },
        'blogs/<entryId:\d+>.json' => function($entryId) {
            return [
                'criteria' => ['id' => $entryId, 'section' => 'blogArticle'],
                'one' => true,
                'transformer' => function(Entry $entry) {
                    return [
                        'id' => $entry->id,
                        'title' => $entry->title,
                        'url' => $entry->url,
                        'description' => $entry->abstract,
                    ];
                },
            ];
        },

        'resources.json' => function() {
            $criteria  = ['section' => 'resources'];
            $relatedTo = array();

            $criteria['orderBy'] = Craft::$app->request->getQueryParam('orderBy', ['publicDate' => SORT_DESC, 'title' => SORT_ASC]);

            if ($search = Craft::$app->request->getQueryParam('search')) {
                $criteria['search'] = $search;
            }

            $resourceType  = Craft::$app->request->getQueryParam('type');
            $resourceTopic = Craft::$app->request->getQueryParam('topic');

            $topicCategories = [];
            $typeCategories = [];
            $paramCount = 0;

            if ($resourceType) {
                $resourceTypes = explode(',', $resourceType);
                foreach ($resourceTypes as $type) {
                    $category = Category::findOne([
                        'group' => 'resourceTypes',
                        'slug' => $type
                    ]);
                    if ($category) {
                        $typeCategories[] = $category;
                    }
                }

                $paramCount++;
            }    

            if ($resourceTopic) {
                $resourceTopics = explode(',', $resourceTopic);
                foreach ($resourceTopics as $topic) {
                    $category = Category::findOne([
                        'group' => 'resourceTopics',
                        'slug' => $topic
                    ]);
                    if ($category) {
                        $topicCategories[] = $category;
                    }
                }
                $paramCount++;
            }

            if ($paramCount > 1) {
                $relatedTo[] = 'and';
            }

            if ($resourceType || $resourceTopic) {
                $relatedTo[] = ["targetElement" => $typeCategories];
                $relatedTo[] = ["targetElement" => $topicCategories];
                $criteria['relatedTo'] = $relatedTo;
            }
        
            return [
                'criteria' => $criteria,
                'transformer' => function(Entry $entry) {
                    if ($entry->type == 'resourceLink' && count($entry->ctaLinkBlock->all())) {
                        $url = $entry->ctaLinkBlock->one()->ctaLink->link;
                        $cta = $entry->ctaLinkBlock->one()->linkText ?: 'More';
                    } else {
                        $url = $entry->url;
                        $cta = $entry->ctaText ?: 'More';
                    }

                    return [
                        'title' => $entry->title,
                        'type' => $entry->resourceTypes->one() ? $entry->resourceTypes->one()->title : null,
                        'description' => $entry->abstract,
                        'image' => $entry->featuredImage->one() ? $entry->featuredImage->one()->url : 'https://via.placeholder.com/350x230',
                        'imageAltText' => $entry->featuredImage->one() ? $entry->featuredImage->one()->altText : null,
                        'id' => $entry->id,
                        'url' => $url,
                        'cta' => $cta,
                        'date' => $entry->publicDate->format('F jS, Y'),
                    ];
                },
            ];
        },
    //     'resources/<entryId:\d+>.json' => function($entryId) {
    //         return [
    //             'criteria' => ['id' => $entryId, 'section' => 'resources'],
    //             'one' => true,
    //             'transformer' => function(Entry $entry) {
    //                 return [
    //                     'id' => $entry->id,
    //                     'title' => $entry->title,
    //                     'url' => $entry->url,
    //                     'description' => $entry->resourceDescription,
    //                 ];
    //             },
    //         ];
    //     },
        

        'blogCategories.json' => function() {
            return [
                'elementType' => Category::class,
                'elementsPerPage' => 100,
                'criteria' => ['group' => 'blogCategories'],
            ];
        },

        'resourceTypes.json' => function() {
            return [
                'elementType' => Category::class,
                'elementsPerPage' => 100,
                'criteria' => ['group' => 'resourceTypes'],
            ];
        },
        

    //     'resourceTopics.json' => function() {
    //         return [
    //             'elementType' => Category::class,
    //             'elementsPerPage' => 100,
    //             'criteria' => ['group' => 'resourceTopics'],
    //         ];
    //     },
    ],
];
