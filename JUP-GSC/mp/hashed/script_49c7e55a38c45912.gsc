/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_49c7e55a38c45912.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_activities_summon_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_activities_summon_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_activities_summon_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_activities_summon_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_activities_summon_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_activities_summon_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "summon_console_green_controller";
  fe[[f]](s, us, cf, (26068.7, -24927.8, 3301), (0, 93.5, 0), "summon_console_green_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26734, -23099, 3097), (0, 0, 0), undefined, "cspf_1_auto7205886467820540478", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26915, -23263, 3105), (0, 0, 0), "cspf_1_auto7205886467820540478", undefined, "refractor_set", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26751, -23276, 3106), (0, 0, 0), undefined, "cspf_1_auto7205886467820540478", "ammo_crate", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26723, -22077, 2963), (0, 0, 0), undefined, "cspf_1_auto13076757328401767664", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26783, -23390, 3102), (0, 0, 0), undefined, "cspf_1_auto7205886467820540478", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (27043, -23384, 3107), (0, 0, 0), undefined, "cspf_1_auto7205886467820540478", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26490, -22101, 2962), (0, 0, 0), undefined, "cspf_1_auto13076757328401767664", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26671, -22265, 2970), (0, 0, 0), "cspf_1_auto13076757328401767664", undefined, "refractor_set", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (27040, -23256, 3107), (0, 0, 0), undefined, "cspf_1_auto7205886467820540478", "ammo_crate", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26539, -22392, 2967), (0, 0, 0), undefined, "cspf_1_auto13076757328401767664", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26799, -22386, 2972), (0, 0, 0), undefined, "cspf_1_auto13076757328401767664", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26967, -23075, 3098), (0, 0, 0), undefined, "cspf_1_auto7205886467820540478", "refractor", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26498, -22277, 2967), (0, 0, 0), undefined, "cspf_1_auto13076757328401767664", "ammo_crate", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26780, -22216, 2967), (0, 0, 0), undefined, "cspf_1_auto13076757328401767664", "ammo_crate", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26485, -29638, 3584), (0, 0, 0), undefined, "cspf_2_auto15210430063923400149", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (25485, -29638, 3584), (0, 0, 0), undefined, "cspf_2_auto15210430063923400149", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26485, -30638, 3583), (0, 0, 0), undefined, "cspf_2_auto15210430063923400149", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (25485, -30638, 3586), (0, 0, 0), undefined, "cspf_2_auto15210430063923400149", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (25985, -30138, 3595), (0, 0, 0), "cspf_2_auto15210430063923400149", undefined, "aether_storm_spawnpoint", undefined, undefined, (0, 0, 0), (0, 0, 0), 2048);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "summon_console_yellow_controller";
  fe[[f]](s, us, cf, (25223.1, -25369.8, 3315), (0, 93.5, 0), "summon_console_yellow_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "summon_console_red_controller";
  fe[[f]](s, us, cf, (24485.3, -25235.2, 3297), (0, 93.5, 0), "summon_console_red_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_2_a";
  fe[[f]](s, us, cf, (25204.1, -24933.8, 3246), (0, 93.5, 0), "map_location_2_a", "map_controller", "map_location_2");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_1_a";
  fe[[f]](s, us, cf, (25412.1, -24922.8, 3246), (0, 93.5, 0), "map_location_1_a", "map_controller", "map_location_1");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_3_a";
  fe[[f]](s, us, cf, (25413.1, -24923.8, 3110), (0, 93.5, 0), "map_location_3_a", "map_controller", "map_location_3");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_4_a";
  fe[[f]](s, us, cf, (25203.1, -24936.8, 3110), (0, 93.5, 0), "map_location_4_a", "map_controller", "map_location_4");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_controller";
  fe[[f]](s, us, cf, (25303.1, -24930.8, 3177), (0, 93.5, 0), "map_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_2_b";
  fe[[f]](s, us, cf, (25215.1, -25000.8, 3243), (0, 93.5, 0), "map_location_2_b", undefined, "map_location_2");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_1_b";
  fe[[f]](s, us, cf, (25411.1, -24990.8, 3243), (0, 93.5, 0), "map_location_1_b", undefined, "map_location_1");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (25505, -24242, 3112), (0, 0, 0), "summon_z_spawn1");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (25770, -24274, 3115), (0, 0, 0), "summon_z_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_3_b";
  fe[[f]](s, us, cf, (25413.1, -24992.8, 3109), (0, 93.5, 0), "map_location_3_b", undefined, "map_location_3");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_4_b";
  fe[[f]](s, us, cf, (25215.1, -25004.8, 3109), (0, 93.5, 0), "map_location_4_b", undefined, "map_location_4");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_2_c";
  fe[[f]](s, us, cf, (25221.1, -25085.8, 3243), (0, 93.5, 0), "map_location_2_c", undefined, "map_location_2");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_1_c";
  fe[[f]](s, us, cf, (25417.1, -25075.8, 3243), (0, 93.5, 0), "map_location_1_c", undefined, "map_location_1");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_3_c";
  fe[[f]](s, us, cf, (25419.1, -25077.8, 3109), (0, 93.5, 0), "map_location_3_c", undefined, "map_location_3");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_4_c";
  fe[[f]](s, us, cf, (25221.1, -25089.8, 3109), (0, 93.5, 0), "map_location_4_c", undefined, "map_location_4");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_2_d";
  fe[[f]](s, us, cf, (25227.1, -25177.8, 3243), (0, 93.5, 0), "map_location_2_d", undefined, "map_location_2");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_1_d";
  fe[[f]](s, us, cf, (25423.1, -25167.8, 3243), (0, 93.5, 0), "map_location_1_d", undefined, "map_location_1");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_3_d";
  fe[[f]](s, us, cf, (25425.1, -25169.8, 3109), (0, 93.5, 0), "map_location_3_d", undefined, "map_location_3");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "map_location_4_d";
  fe[[f]](s, us, cf, (25227.1, -25181.8, 3109), (0, 93.5, 0), "map_location_4_d", undefined, "map_location_4");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26455, -25448, 3106), (0, 14.7, 0), "spawn_refractor");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26308.9, -25486.3, 3106), (0, 14.7, 0), "spawn_refractor");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (26378.6, -25468, 3106), (0, 14.7, 0), "spawn_refractor");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (26529.5, -25428.5, 3106), (0, 14.7, 0), "spawn_refractor");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (25525, -24178, 3142), (0, 0, 0), "summon_button");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "green_console_3";
  fe[[f]](s, us, cf, (26069, -24986, 3104), (0, 14.2, 0), "green_console_3", "summon_console_green_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "green_console_4";
  fe[[f]](s, us, cf, (25883.2, -25022.1, 3101), (0, 13.6, 0), "green_console_4", "summon_console_green_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "green_console_5";
  fe[[f]](s, us, cf, (25684.3, -25065.8, 3102), (0, 4.1, 0), "green_console_5", "summon_console_green_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "green_console_2";
  fe[[f]](s, us, cf, (26225.8, -24947, 3101), (0, 4.9, 0), "green_console_2", "summon_console_green_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "green_console_1";
  fe[[f]](s, us, cf, (26384.7, -24900.8, 3101), (0, 3.7, 0), "green_console_1", "summon_console_green_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "yellow_console_1";
  fe[[f]](s, us, cf, (25548.9, -25341.3, 3103), (0, 93.5, 0), "yellow_console_1", "summon_console_yellow_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "yellow_console_2";
  fe[[f]](s, us, cf, (25336.1, -25361.8, 3103), (0, 93.5, 0), "yellow_console_2", "summon_console_yellow_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "yellow_console_3";
  fe[[f]](s, us, cf, (25123.3, -25369.2, 3105), (0, 93.5, 0), "yellow_console_3", "summon_console_yellow_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "yellow_console_4";
  fe[[f]](s, us, cf, (24906.5, -25382.1, 3106), (0, 93.5, 0), "yellow_console_4", "summon_console_yellow_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "red_console_1";
  fe[[f]](s, us, cf, (24675, -25236.2, 3106), (0, 93.5, 0), "red_console_1", "summon_console_red_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "red_console_2";
  fe[[f]](s, us, cf, (24478.3, -25235.2, 3107), (0, 93.5, 0), "red_console_2", "summon_console_red_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  s.name = "red_console_3";
  fe[[f]](s, us, cf, (24260.8, -25176.2, 3106), (0, 93.5, 0), "red_console_3", "summon_console_red_controller");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_summon_cs";
  fe[[f]](s, us, cf, (25158, -27425, 3485), (0, 0, 0), "summon_cs");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_activities_summon_cs");
}