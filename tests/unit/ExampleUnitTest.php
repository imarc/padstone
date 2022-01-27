<?php

use Codeception\Test\Unit;

use UnitTester;
use Craft;

/**
 * Example Unit Test. As a guideline, think of Unit tests as testing a specific
 * PHP function, method, class, or setting. If you are trying to test a module,
 * then you're in the right place.
 *
 * Not that this file ends with Test and is not using the Codeception Cest
 * format. The Cest format is designed for functional/acceptance tests, whereas
 * using the plain Test format makes more sense for unit tests.
 */
class ExampleUnitTest extends Unit
{
    /**
     * @var UnitTester
     */
    protected $tester;

    public function testExample()
    {
        Craft::$app->setEdition(Craft::Pro);

        $this->assertSame(
            Craft::Pro,
            Craft::$app->getEdition());
    }
}
