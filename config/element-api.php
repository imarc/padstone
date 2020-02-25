<?php

use Craft;
use craft\elements\Entry;

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
            $criteria = ['section' => 'resources'];

            $criteria['orderBy'] = Craft::$app->request->getQueryParam('orderBy', 'title asc');

            if ($search = Craft::$app->request->getQueryParam('search')) {
                $criteria['search'] = $search;
            }

            return [
                'criteria' => $criteria,
                'transformer' => function(Entry $entry) {
                    if ($entry->type === 'resourceLink') {
                        $url = $entry->resourceUrl;
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
                        'date' => $entry->resourceDate ? $entry->resourceDate->format('F jS, Y') : null,
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
    ],
];
