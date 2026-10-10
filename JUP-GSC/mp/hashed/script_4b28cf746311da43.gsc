/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4b28cf746311da43.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_bigmap_ob_s2_rift_gate_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_bigmap_ob_s2_rift_gate_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_bigmap_ob_s2_rift_gate_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_bigmap_ob_s2_rift_gate_cs");

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

  s cs_setup_arrays(us, "mp_jup_bigmap_ob_s2_rift_gate_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_bigmap_ob_s2_rift_gate_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.name = "ob_s2_rift_gate_pedestal_gloves";
  fe[[f]](s, us, cf, (12910.9, 9177.33, 2601.68), (359.69, 255.19, -13.93), "gloves", "s2_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.name = "ob_s2_rift_gate_pedestal_targets";
  fe[[f]](s, us, cf, (12795.8, 11098.1, 2470.82), (344.23, 255.32, -1.2), "targets", "s2_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.name = "ob_s2_rift_gate_pedestal_drums";
  fe[[f]](s, us, cf, (12093.7, 9034.85, 2651.42), (0.17, 256.45, -0.21), "drums", "s2_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.name = "ob_s2_rift_gate_pedestal_mirror";
  fe[[f]](s, us, cf, (11438.8, 9684.08, 2622.35), (356.74, 257.41, 5.37), "mirror", "s2_rift_gate", "ob_rift_gate_pedestal");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.name = "s2_rift_gate";
  fe[[f]](s, us, cf, (12290, 9488.19, 2634.14), (359.29, 178.48, -5.3), "s2_rift_gate", undefined, "s2_rift_gate");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_gloves";
  s.name = "punching_bag_handler_01";
  fe[[f]](s, us, cf, (528, -37102, 2142), (0, 0, 0), "punching_bag_handler_01", undefined, "punching_bag_handler_01");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_gloves";
  s.name = "punching_bag_handler_00";
  fe[[f]](s, us, cf, (544, -37180, 2143), (0, 0, 0), "punching_bag_handler_00", undefined, "punching_bag_handler_00");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.name = "ob_s2_rift_token_prompt";
  s.script_label = "low";
  fe[[f]](s, us, cf, (12109.5, 9442.44, 2687.93), (0, 360, 91.6), "s2_rift_token_prompt", "s2_rift_gate", "ob_rift_token_prompt");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.name = "ob_s2_rift_token_prompt";
  s.script_label = "high";
  fe[[f]](s, us, cf, (12483.5, 9526.69, 2691.18), (359.69, 180.96, 87.33), "s2_rift_token_prompt", "s2_rift_gate", "ob_rift_token_prompt");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.name = "ob_s2_rift_encounter";
  fe[[f]](s, us, cf, (6053, -11503, 1503), (0, 268.5, 0), "s2_rift_encounter", "s2_rift_gate", "ob_rift_encounter");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.name = "ob_s2_rift_gate_reward";
  fe[[f]](s, us, cf, (6050, -11781, 1506.28), (0, 270, 0), "s2_rift_gate_reward", "s2_rift_gate", "ob_rift_gate_reward");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_gloves";
  s.name = "punching_bag_handler_02";
  fe[[f]](s, us, cf, (508, -37036, 2143), (0, 0, 0), "punching_bag_handler_02", undefined, "punching_bag_handler_02");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_targets";
  s.name = "targets_relic_offering";
  fe[[f]](s, us, cf, (26213.6, -39986.3, 3112), (0, 312.42, 0), "targets_relic_offering", undefined, "targets_relic_offering");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_gloves";
  s.name = "gloves_zombie_spawn_location";
  fe[[f]](s, us, cf, (856, -36896, 2167), (0, 0, 0), "gloves_zombie_spawn", undefined, "gloves_zombie_spawn");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_targets";
  s.name = "target_00";
  fe[[f]](s, us, cf, (26183.6, -40012.5, 3175), (0, 312.42, 0), "target_00", undefined, "target_00");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_targets";
  s.name = "target_01";
  fe[[f]](s, us, cf, (25796.6, -40650.5, 3303), (0, 312.42, 0), "target_01", undefined, "target_01");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_targets";
  s.name = "target_02";
  fe[[f]](s, us, cf, (25098.6, -40267.5, 3302), (0, 312.42, 0), "target_02", undefined, "target_02");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_targets";
  s.name = "target_03";
  fe[[f]](s, us, cf, (25782.6, -39595.5, 3219), (0, 35.62, 0), "target_03", undefined, "target_03");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_targets";
  s.name = "target_04";
  fe[[f]](s, us, cf, (25985.6, -39497.5, 3223), (0, 35.62, 0), "target_04", undefined, "target_04");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_targets";
  s.name = "target_06";
  fe[[f]](s, us, cf, (25920.6, -39081.5, 3334), (0, 35.62, 0), "target_06", undefined, "target_06");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_targets";
  s.name = "target_05";
  fe[[f]](s, us, cf, (26669.6, -39378.5, 3162), (0, 35.62, 0), "target_05", undefined, "target_05");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_targets";
  s.name = "target_07";
  fe[[f]](s, us, cf, (26575.6, -38250.5, 3187), (0, 73.22, 0), "target_07", undefined, "target_07");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.name = "ob_s2_story_mission_portal_acv";
  fe[[f]](s, us, cf, (6262.5, 10705.8, 1438.25), (0, 43.57, 0), "ob_s2_story_mission_portal_acv", undefined, "ob_s2_story_mission_portal_acv");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_mirror";
  s.name = "grave_mirror";
  fe[[f]](s, us, cf, (33644.8, 19122, 3070.84), (0, 321.88, 0), "grave_mirror", undefined, "grave_mirror");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_mirror";
  s.name = "s2_mirror_electric";
  fe[[f]](s, us, cf, (34835.3, 19166.4, 3283), (360, 195.8, 0.01), "s2_mirror_electric", undefined, "s2_mirror_electric");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_mirror";
  s.name = "s2_mirror_fire";
  fe[[f]](s, us, cf, (35013.8, 19191.3, 3283), (360, 187.71, 0.01), "s2_mirror_fire", undefined, "s2_mirror_fire");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_mirror";
  s.name = "s2_mirror_ice";
  fe[[f]](s, us, cf, (34944.8, 19079.5, 3283), (0, 275.11, -0), "s2_mirror_ice", undefined, "s2_mirror_ice");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.groupid = "relic_mirror";
  s.name = "s2_mirror_toxic";
  fe[[f]](s, us, cf, (34921.4, 19260.1, 3283), (0, 277.71, 0), "s2_mirror_toxic", undefined, "s2_mirror_toxic");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s2_rift_gate_cs";
  s.name = "ob_s2_story_mission_portal";
  fe[[f]](s, us, cf, (6430.5, 10563.8, 1430.25), (0, 343.57, 0), "ob_s2_story_mission_portal", undefined, "ob_s2_story_mission_portal");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_bigmap_ob_s2_rift_gate_cs");
}