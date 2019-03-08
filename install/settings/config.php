<?php

/* config.php */

return array(
    'version' => '2.0.2',
    'web_title' => 'Repair',
    'web_description' => 'ระบบบันทึกข้อมูลงานซ่อม',
    'timezone' => 'Asia/Bangkok',
    'member_status' => array(
        0 => 'สมาชิก',
        1 => 'ผู้ดูแลระบบ',
        2 => 'ช่างซ่อม',
        3 => 'ผู้รับผิดชอบ',
    ),
    'color_status' => array(
        0 => '#259B24',
        1 => '#FF0000',
        2 => '#0000FF',
        3 => '#827717',
    ),
    'repair_first_status' => 1,
);
