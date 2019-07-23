<?php
/**
 * @filesource modules/inventory/models/category.php
 *
 * @copyright 2016 Goragod.com
 * @license http://www.kotchasan.com/license/
 *
 * @see http://www.kotchasan.com/
 */

namespace Inventory\Category;

/**
 * คลาสสำหรับอ่านข้อมูลหมวดหมู่
 *
 * @author Goragod Wiriya <admin@goragod.com>
 *
 * @since 1.0
 */
class Model extends \Kotchasan\Model
{
    /**
     * @var array
     */
    private $datas = array();

    /**
     * อ่านรายชื่อหมวดหมู่จากฐานข้อมูลตามภาษาปัจจุบัน
     * สำหรับการแสดงผล
     *
     * @param string $type
     *
     * @return static
     */
    public static function init($type)
    {
        // Model
        $model = new static();
        // Query
        $query = $model->db()->createQuery()
            ->select('id', 'category_id', 'topic')
            ->from('category')
            ->where(array('type', $type))
            ->order('category_id')
            ->toArray()
            ->cacheOn();
        foreach ($query->execute() as $item) {
            $model->datas[$item['category_id']] = array(
                'id' => $item['id'],
                'category_id' => $item['category_id'],
                'topic' => $item['topic'],
            );
        }

        return $model;
    }

    /**
     * ลิสต์รายการหมวดหมู่
     * สำหรับใส่ลงใน select
     *
     * @return array
     */
    public function toSelect()
    {
        $result = array();
        foreach ($this->datas as $category_id => $item) {
            $result[$category_id] = $item['topic'];
        }

        return $result;
    }

    /**
     * อ่านหมวดหมู่จาก $category_id
     * ไม่พบ คืนค่าว่าง
     *
     * @param int $category_id
     *
     * @return string
     */
    public function get($category_id)
    {
        return isset($this->datas[$category_id]) ? $this->datas[$category_id]['topic'] : '';
    }
}
