<?php
/**
 * @filesource modules/repair/controllers/init.php
 *
 * @copyright 2016 Goragod.com
 * @license http://www.kotchasan.com/license/
 *
 * @see http://www.kotchasan.com/
 */

namespace Repair\Init;

use Gcms\Login;
use Kotchasan\Http\Request;

/**
 * Init Module.
 *
 * @author Goragod Wiriya <admin@goragod.com>
 *
 * @since 1.0
 */
class Controller extends \Kotchasan\KBase
{
    /**
     * ฟังก์ชั่นเริ่มต้นการทำงานของโมดูลที่ติดตั้ง
     * และจัดการเมนูของโมดูล.
     *
     * @param Request                $request
     * @param \Index\Menu\Controller $menu
     * @param array                  $login
     */
    public static function execute(Request $request, $menu, $login)
    {
        $submenus = array(
            array(
                'text' => '{LNG_Get a repair}',
                'url' => 'index.php?module=repair-receive',
            ),
            array(
                'text' => '{LNG_History}',
                'url' => 'index.php?module=repair-history',
            ),
        );
        // สามารถตั้งค่าระบบได้
        if (Login::checkPermission($login, 'can_config')) {
            $menu->add('settings', '{LNG_Repair status}', 'index.php?module=repair-repairstatus');
        }
        // สามารถจัดการรายการซ่อมได้, ช่างซ่อม
        if (Login::checkPermission($login, array('can_manage_repair', 'can_repair'))) {
            $submenus[] = array(
                'text' => '{LNG_Repair list}',
                'url' => 'index.php?module=repair-setup',
            );
        }
        // เมนูแจ้งซ่อม
        $menu->add('repair', '{LNG_Repair jobs}', null, $submenus);
        $menu->addTopLvlMenu('repair', '{LNG_Repair jobs}', null, $submenus, 'member');
    }

    /**
     * รายการ permission ของโมดูล.
     *
     * @param array $permissions
     *
     * @return array
     */
    public static function updatePermissions($permissions)
    {
        $permissions['can_manage_repair'] = '{LNG_Can manage repair}';
        $permissions['can_repair'] = '{LNG_Repairman}';

        return $permissions;
    }
}
