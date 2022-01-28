<?php

use craft\elements\Entry;

class BasicSectionCest {

    public function canAddSectionToHomepage(FunctionalTester $I)
    {
        $homepage = Entry::find()->section('homepage')->one();

        $homepage->setFieldValues([

            'contentDesigner' => [
                'blocks' => [
                    'new1' => [
                        'type' => 'basic',
                        'level' => 1,
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

            //'contentDesigner' => [
            //    'new1' => [
            //        'enabled' => 1,
            //        'type' => 1,
            //        'fields' => [
            //            'sectionHeading' => 'contentDesigner.*.fields.sectionHeading',
            //        ],
            //    ],
            //    'new2' => [
            //        'enabled' => 1,
            //        'type' => 1,
            //    ],
            //    'new3' => [
            //        'enabled' => 1,
            //        'type' => 1,
            //    ],
            //],

            //'contentDesigner' => [
            //    'sortOrder' => ['new1'],
            //    'blocks' => [
            //        'new1' => [
            //            'enabled' => 1,
            //            'level' => '00',
            //            'type' => 'basic',
            //            'fields' => [
            //                'sectionHeading' => 'contentDesigner.*.fields.sectionHeading',
            //            ],
            //        ],
            //    ],
            //],

            //'contentDesigner' => [
            //    'sortOrder' => ['new1'],
            //    'blocks' => [
            //        'new1' => [
            //            'enabled' => 1,
            //            'level' => 0,
            //            'type' => 'basic',
            //            'fields' => [
            //                'sectionHeading' => 'contentDesigner.*.fields.sectionHeading',
            //            ],
            //        ],
            //    ],
            //],

            //'contentDesigner' => [
            //    'sortOrder' => ['new1'],
            //    'blocks' => [
            //        'new1' => [
            //            'type' => 'basic',
            //            'fields' => [
            //                'sectionHeading' => 'contentDesigner.*.fields.sectionHeading',
            //            ],
            //        ],
            //    ],
            //],

            //'contentDesigner' => [
            //    'sortOrder' => ['new1'],
            //    'blocks' => [
            //        'new1' => [
            //            'type' => 'basic',
            //            'sectionHeading' => 'contentDesigner.*.fields.sectionHeading',
            //        ],
            //    ],
            //],

            //'contentDesigner' => [
            //    'blocks' => [
            //        [
            //            'type' => 'basic',
            //            'sectionHeading' => 'contentDesigner.*.fields.sectionHeading',
            //        ],
            //    ]
            //],

            //'contentDesigner' => [
            //    'blocks' => [
            //        [
            //            'type' => 'basic',
            //            'fields' => [
            //                'sectionHeading' => 'contentDesigner.*.fields.sectionHeading',
            //            ],
            //        ],
            //    ]
            //],

            // 'contentDesigner' => [
            //     'blocks' => [
            //         'type' => 'basic',
            //         'fields' => [
            //             'sectionHeading' => 'contentDesigner.*.fields.sectionHeading',
            //         ],
            //     ]
            // ],

            //'contentDesigner' => [
            //    [
            //        'type' => 'basic',
            //        'fields' => [
            //            'sectionHeading' => 'contentDesigner.*.fields.sectionHeading',
            //        ],
            //    ]
            //],
        ]);

        fwrite(STDERR, print_r($homepage->getDirtyFields(), true));

        Craft::$app->elements->saveElement($homepage);

        $I->amOnPage('/');
        $I->see('contentDesigner');
    }
}
