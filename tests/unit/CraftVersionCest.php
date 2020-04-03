<?php
use Codeception\Test\Unit;

use UnitTester;
use Craft;

class CraftVersionTest extends Unit
{
    /**
     * @var UnitTester
     */
    protected $tester;

    /**
     * Validates that Craft Pro is installed
     */
    public function hasCraftPro()
    {
        Craft::$app->setEdition(Craft::Pro);

        $this->assertSame(
            Craft::Pro,
            1
        );
    }
}