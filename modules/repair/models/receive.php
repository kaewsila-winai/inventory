<?php
/**
 * @filesource modules/repair/models/receive.php
 *
 * @copyright 2016 Goragod.com
 * @license http://www.kotchasan.com/license/
 *
 * @see http://www.kotchasan.com/
 */

namespace Repair\Receive;

use Gcms\Login;
use Kotchasan\Database\Sql;
use Kotchasan\Http\Request;
use Kotchasan\Language;

/**
 * เพิ่ม-แก้ไข ใบแจ้งซ่อม
 *
 * @author Goragod Wiriya <admin@goragod.com>
 *
 * @since 1.0
 */
class Model extends \Kotchasan\Model
{
    /**
     * อ่านข้อมูลรายการที่เลือก
     * ถ้า $id = 0 หมายถึงรายการใหม่.
     *
     * @param int $id ID
     *
     * @return object|null คืนค่าข้อมูล object ไม่พบคืนค่า null
     */
    public static function get($id)
    {
        if (empty($id)) {
            // ใหม่
            return (object) array(
                'equipment' => '',
                'serial' => '',
                'inventory_id' => 0,
                'job_description' => '',
                'id' => 0,
                'comment' => '',
                'status_id' => 0,
            );
        } else {
            // แก้ไข
            $model = new static();
            $q1 = $model->db()->createQuery()
                ->select('repair_id', Sql::MAX('id', 'max_id'))
                ->from('repair_status')
                ->groupBy('repair_id');

            return $model->db()->createQuery()
                ->from('repair R')
                ->join(array($q1, 'T'), 'LEFT', array('T.repair_id', 'R.id'))
                ->join('repair_status S', 'LEFT', array('S.id', 'T.max_id'))
                ->join('inventory V', 'LEFT', array('V.id', 'R.inventory_id'))
                ->where(array('R.id', $id))
                ->first('R.*', 'V.equipment', 'V.serial', 'S.status', 'S.comment', 'S.id status_id');
        }
    }

    /**
     * บันทึกค่าจากฟอร์ม
     *
     * @param Request $request
     */
    public function submit(Request $request)
    {
        $ret = array();
        // session, token, can_received_repair, ไม่ใช่สมาชิกตัวอย่าง
        if ($request->initSession() && $request->isSafe() && $login = Login::isMember()) {
            if (Login::notDemoMode($login)) {
                // รับค่าจากการ POST
                $repair = array(
                    'job_description' => $request->post('job_description')->textarea(),
                    'inventory_id' => $request->post('inventory_id')->toInt(),
                );
                $equipment = $request->post('equipment')->topic();
                $serial = $request->post('serial')->topic();
                // ตรวจสอบรายการที่เลือก
                $index = self::get($request->post('id')->toInt());
                if (!$index || $index->id > 0 && ($login['id'] != $index->customer_id && !Login::checkPermission($login, 'can_manage_repair'))) {
                    // ไม่พบรายการที่แก้ไข
                    $ret['alert'] = Language::get('Sorry, Item not found It&#39;s may be deleted');
                } elseif (empty($equipment)) {
                    // equipment
                    $ret['ret_equipment'] = 'Please fill in';
                } elseif (empty($serial)) {
                    // serial
                    $ret['ret_serial'] = 'Please fill in';
                } elseif (empty($repair['inventory_id'])) {
                    // ไม่พบรายการพัสดุที่เลือก
                    $ret['ret_equipment'] = Language::get('Please select the item from the search list');
                } else {
                    if ($index->id == 0) {
                        $repair['customer_id'] = $login['id'];
                        $repair['create_date'] = date('Y-m-d H:i:s');
                        // บันทึกรายการแจ้งซ่อม
                        $log = array(
                            'repair_id' => $this->db()->insert($this->getTableName('repair'), $repair),
                            'member_id' => $login['id'],
                            'comment' => $request->post('comment')->topic(),
                            'status' => isset(self::$cfg->repair_first_status) ? self::$cfg->repair_first_status : 1,
                            'create_date' => $repair['create_date'],
                            'operator_id' => 0,
                        );
                        // บันทึกประวัติการทำรายการ แจ้งซ่อม
                        $this->db()->insert($this->getTableName('repair_status'), $log);
                    } else {
                        // แก้ไขรายการแจ้งซ่อม
                        $this->db()->update($this->getTableName('repair'), $index->id, $repair);
                        // อัปเดทหมายเหตุ
                        $this->db()->update($this->getTableName('repair_status'), $index->status_id, array(
                            'comment' => $request->post('comment')->topic(),
                        ));
                    }
                    // คืนค่า
                    $ret['alert'] = Language::get('Saved successfully');
                    $ret['location'] = 'index.php?module=repair-setup';
                    // clear
                    $request->removeToken();
                }
            }
        }
        if (empty($ret)) {
            $ret['alert'] = Language::get('Unable to complete the transaction');
        }
        // คืนค่าเป็น JSON
        echo json_encode($ret);
    }
}
