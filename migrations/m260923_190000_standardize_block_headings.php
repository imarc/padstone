<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;
use craft\db\Query;
use craft\db\Table;
use craft\helpers\Json;

/**
 * Moves content to match the standardized Content Designer headings:
 *
 * - Image Card: the old Headline field value becomes the entry title.
 * - Related Resources: the old entry title becomes the Headline field value.
 */
class m260923_190000_standardize_block_headings extends Migration
{
    // Layout element UID of the Headline field in the old Image Card layout.
    private const OLD_IMAGE_CARD_HEADLINE = '131fb942-4184-4c34-bb2d-722a8619f59a';

    public function safeUp(): bool
    {
        $entries = Craft::$app->getEntries();

        $imageCard = $entries->getEntryTypeByHandle('imageCard');
        if ($imageCard) {
            foreach ($this->rowsForType($imageCard->id) as $row) {
                $content = Json::decodeIfJson($row['content'] ?? '') ?: [];
                $headline = $content[self::OLD_IMAGE_CARD_HEADLINE] ?? null;
                if (is_string($headline) && $headline !== '' && empty($row['title'])) {
                    $this->update(Table::ELEMENTS_SITES, ['title' => $headline], ['id' => $row['id']]);
                }
            }
        }

        $related = $entries->getEntryTypeByHandle('relatedResourcesSection');
        $headlineField = $related?->getFieldLayout()->getFieldByHandle('headline');
        if ($headlineField) {
            $headlineUid = $headlineField->layoutElement->uid;
            foreach ($this->rowsForType($related->id) as $row) {
                $content = Json::decodeIfJson($row['content'] ?? '') ?: [];
                if (!empty($row['title']) && empty($content[$headlineUid])) {
                    $content[$headlineUid] = $row['title'];
                    $this->update(Table::ELEMENTS_SITES, ['content' => $content], ['id' => $row['id']]);
                }
            }
        }

        return true;
    }

    public function safeDown(): bool
    {
        echo "m260923_190000_standardize_block_headings cannot be reverted.\n";
        return false;
    }

    private function rowsForType(int $typeId): array
    {
        return (new Query())
            ->select(['es.id', 'es.title', 'es.content'])
            ->from(['es' => Table::ELEMENTS_SITES])
            ->innerJoin(['e' => Table::ENTRIES], '[[e.id]] = [[es.elementId]]')
            ->where(['e.typeId' => $typeId])
            ->all();
    }
}
