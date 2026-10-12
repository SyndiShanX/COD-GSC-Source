/**************************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_zone_3_create_script.gsc
**************************************************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_skydiving_zone_3_create_script;

function main(unused, us) {
  if(flag_exist("mp_jup_skydiving_zone_3_create_script")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_skydiving_zone_3_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_skydiving_zone_3_create_script");

  if(!cs_is_starttime()) {
    endcreatescript(s);
  }
}

function cs_return_and_wait_for_flag(us, s, cf) {
  level endon("game_ended");
  wait_for_cs_flag(cf);

  if(!isDefined(us)) {
    us = "pfx";
  }

  s cs_setup_arrays(us, "mp_jup_skydiving_zone_3_create_script");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_skydiving_zone_3_create_script");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-13230, -27220, 1742.16), (0, 0, 0), "flag_point_2");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9944.51, -31539.3, 1821.97), (0, 172, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11260, -30696, 1775.61), (0, 0, 0), "flag_point_1");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9864, -29632, 1751.54), (0, 0, 0), "zone3_zombie");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10424, -28600, 1638.46), (0, 0, 0), "zone3_zombie");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-12215.9, -29536, 1816.07), (0, 350, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-12782.5, -30866.5, 2759.5), (359.67, 333.8, 0.48), "cspf_0_auto4488287958165681006", "cspf_0_auto16785510717820222328", "wm_skydiving_attacker_outro_heli_in_cam");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11244.5, -32097, 1862.8), (0, 0, 0), undefined, "cspf_0_auto4488287958165681006", "wm_skydiving_attacker_outro");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-15013, -34968.5, 3577.5), (0, 241.89, 0), "cspf_0_auto3461151972180384092", undefined, "wm_skydiving_attacker_outro_heli_out");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-5010, -28514.5, 2872), (0, 199.74, 0), undefined, "cspf_0_auto837476271497448729", "wm_skydiving_attacker_outro_heli_in");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11023.5, -32089.5, 2662.5), (0, 199.74, 0), "cspf_0_auto837476271497448729", "cspf_0_auto3461151972180384092", "wm_skydiving_attacker_outro_heli_in_goal");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9672, -29912, 1837.25), (0, 0, 0), "flag_checkpoint");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10390.5, -31413, 1914), (350.2, 229.25, 0.92), "cspf_0_auto16785510717820222328", undefined, "wm_skydiving_attacker_outro_heli_out_cam");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9888, -30112, 1783.3), (0, 0, 0), "flag_checkpoint");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9752, -29544, 1783.3), (0, 0, 0), "flag_checkpoint");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9856, -29280, 1783.32), (0, 0, 0), "flag_checkpoint");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10024, -29080, 1764.79), (0, 0, 0), "flag_checkpoint");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10264, -28824, 1743.05), (0, 0, 0), "flag_checkpoint");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10680, -28256, 1718.86), (0, 0, 0), "flag_checkpoint");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10216, -30520, 1819.58), (0, 0, 0), "flag_checkpoint");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10528, -29664, 1803.56), (0, 0, 0), "flag_checkpoint");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10880, -29160, 1788.12), (0, 0, 0), "flag_checkpoint");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11200, -28552, 1774.94), (0, 0, 0), "flag_checkpoint");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9602, -29497, 1997), (0, 180, 0), "spawn_trap_cover", undefined, "sandbag01_short_iw6");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-12690, -26060, 3418), (0, 16, 0), "cspf_0_auto17518314103305881393", "cspf_0_auto16141084730686602733", "jump_down_indicator");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-13212, -26174, 3418), (0, 16, 0), undefined, "cspf_0_auto17518314103305881393", "jump_down_indicator");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10158, -27536, 1832), (0, 0, 0), "cspf_0_auto877459028579372969", undefined, "gas_pause_down_1");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-13652, -28518, 1772), (0, 0, 0), "cspf_0_auto12228816910749965830", undefined, "gas_pause_down_3");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  s.script_parameters = "2296|10|0|gas_pause_down_1";
  fe[[f]](s, us, cf, (-10296, -27080, 1734), (0, 0, 0), undefined, "cspf_0_auto877459028579372969", "jup_skydiving_radiation_spawn");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9840.67, -31111.8, 1775.14), (0, 240, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  s.script_parameters = "1896|10|0|gas_pause_down_3";
  fe[[f]](s, us, cf, (-14148, -28476, 1734), (0, 0, 0), undefined, "cspf_0_auto12228816910749965830", "jup_skydiving_radiation_spawn");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10712, -31776, 1856.86), (0, 0, 0), "elec_2");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10648, -31760, 1856.86), (0, 0, 0), "elec_1");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10776, -31824, 1856.86), (0, 0, 0), "elec_3");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-12206, -25960, 3418), (0, 16, 0), "cspf_0_auto16141084730686602733", undefined, "jump_down_indicator");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-12119.5, -31220.9, 1864.31), (0, 66, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10743.8, -30171, 1814.7), (0, 100, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10686.7, -28479.3, 1759.03), (0, 330, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-12004.5, -32127.2, 1866.38), (0, 282, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10364.6, -28576.3, 1754.37), (0, 230, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10547.1, -29115.6, 1766.51), (0, 192, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-13039.3, -29010.4, 1778.59), (0, 350, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-12260.7, -30843.1, 1808.17), (0, 146, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-12618.5, -31147, 1826.68), (0, 40, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11662.5, -30904.7, 1799.49), (0, 40, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11445.1, -30630, 1763.94), (0, 136, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10366.7, -30986.2, 1780.84), (0, 144, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11359.9, -29768.4, 1738.98), (0, 260, 0), undefined, undefined, "rising_zombie_spawn_loc");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-10920, -31848, 1856.86), (0, 0, 0), "elec_4");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11000, -31832, 1856.86), (0, 0, 0), "elec_5");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11064, -31856, 1856.86), (0, 0, 0), "elec_6");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11056, -31912, 1856.86), (0, 0, 0), "elec_7");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11048, -31960, 1856.86), (0, 0, 0), "elec_8");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-11120, -31984, 1856.86), (0, 0, 0), "elec_9");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-12385.5, -27996.5, 1734), (0, 0, 0), "cspf_0_auto3379929676386082892", undefined, "gas_pause_down_2");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  s.script_parameters = "3084|10|0|gas_pause_down_2";
  fe[[f]](s, us, cf, (-12648, -27072, 1734), (0, 0, 0), undefined, "cspf_0_auto3379929676386082892", "jup_skydiving_radiation_spawn");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9602, -29569, 1971), (0, 180, 0), "spawn_trap_cover", undefined, "sandbag01_short_iw6");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9562, -29607, 1969), (0, 270, 0), "spawn_trap_cover", undefined, "sandbag01_short_iw6");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9602, -29569, 1997), (0, 180, 0), "spawn_trap_cover", undefined, "sandbag01_short_iw6");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9610, -29441, 1997), (0, 360, 0), "spawn_trap_cover", undefined, "sandbag01_endright_dusty_iw6");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9562, -29607, 1997), (0, 270, 0), "spawn_trap_cover", undefined, "sandbag01_short_iw6");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9502, -29607, 1998), (0, 270, 0), "spawn_trap_cover", undefined, "sandbag01_endright_dusty_iw6");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9610, -29457, 1973), (0, 180, 0), "spawn_trap_cover", undefined, "sandbag01_long_iw6");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9499, -29607, 1970), (0, 270, 0), "spawn_trap_cover", undefined, "sandbag01_endright_dusty_iw6");
  s = s();
  s.cs_flag = "mp_jup_skydiving_zone_3_create_script";
  fe[[f]](s, us, cf, (-9612, -29369, 1969), (0, 360, 0), "spawn_trap_cover", undefined, "sandbag01_endright_dusty_iw6");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_skydiving_zone_3_create_script");
}