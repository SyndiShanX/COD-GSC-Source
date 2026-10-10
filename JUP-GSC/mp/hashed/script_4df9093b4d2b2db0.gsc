/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4df9093b4d2b2db0.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_sira_ob_contracts_outlast_stadium_instance_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_sira_ob_contracts_outlast_stadium_instance_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_sira_ob_contracts_outlast_stadium_instance_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs");

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

  s cs_setup_arrays(us, "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_3";
  fe[[f]](s, us, cf, (-36545.2, -16812.7, 252), (0, 338.62, 0), "zombie_spawn_wave_3", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_3");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_3";
  fe[[f]](s, us, cf, (-36311.6, -18051.8, 251.5), (0, 214.44, 0), "zombie_spawn_wave_3", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_3");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  fe[[f]](s, us, cf, (-35836.5, -16872.7, 315), (0, 315.72, 0), "s_outlast_sira_reward", "s_outlast_s2_5_mission_stadium", "s_outlast_sira_reward");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "PND";
  fe[[f]](s, us, cf, (-35850.2, -16974.9, 316), (0, 217.12, -0), "pnd", "s_outlast_s2_5_mission_stadium", "pnd");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_2";
  fe[[f]](s, us, cf, (-35189.1, -16660, 252), (0, 220.44, 0), "zombie_spawn_wave_2", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_2");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  fe[[f]](s, us, cf, (-35137.2, -8430.9, 1725.5), (0, 193.56, 0), "activity_nexus_instance_joiner", "s_outlast_s2_5_mission_stadium", "OUTLAST_SIRA");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_1";
  fe[[f]](s, us, cf, (-35446.6, -16406.6, 252), (0, 236.9, 0), "zombie_spawn_wave_1", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_1");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "s_outlast_s2_5_mission_stadium";
  fe[[f]](s, us, cf, (-35464, -17428.5, 345), (0, 291.68, 0), "s_outlast_s2_5_mission_stadium");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_2";
  fe[[f]](s, us, cf, (-36455.1, -16988.3, 252), (0, 20.61, 0), "zombie_spawn_wave_2", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_2");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_1";
  fe[[f]](s, us, cf, (-36441.2, -17477.6, 250), (0, 347.64, 0), "zombie_spawn_wave_1", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_1");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_2";
  fe[[f]](s, us, cf, (-36493.3, -17728.9, 250.11), (0, 14.07, 0), "zombie_spawn_wave_2", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_2");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_1";
  fe[[f]](s, us, cf, (-35915.8, -18554.3, 252), (0, 72.77, 0), "zombie_spawn_wave_1", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_1");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_1";
  fe[[f]](s, us, cf, (-35529.5, -18597.2, 250.12), (0, 96.43, 0), "zombie_spawn_wave_1", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_1");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_3";
  fe[[f]](s, us, cf, (-35242.2, -18516.5, 250.07), (0, 120.5, 0), "zombie_spawn_wave_3", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_3");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_2";
  fe[[f]](s, us, cf, (-34887.9, -18167.4, 250.08), (0, 133.37, 0), "zombie_spawn_wave_2", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_2");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_1";
  fe[[f]](s, us, cf, (-34842, -17217.1, 250.11), (0, 199.52, 0), "zombie_spawn_wave_1", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_1");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (609.25, 823, 178);
  s.var_74e936bbadd15418 = (1946.75, 1069.25, 32);
  s.height = 128;
  s.length = "128";
  s.name = "noent_volume_trigger_box";
  s.width = "128";
  fe[[f]](s, us, cf, (-35134.5, -16816, 205.5), (0, 37.08, 0), "outlast_noent_entrance_trigger", "s_outlast_s2_5_mission_stadium");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "zombie_spawn_wave_3";
  fe[[f]](s, us, cf, (-35122.1, -17083.3, 252), (0, 214.44, 0), "zombie_spawn_wave_3", "s_outlast_s2_5_mission_stadium", "zombie_spawn_wave_3");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.name = "outlast_space";
  fe[[f]](s, us, cf, (-35658.5, -17314, 256), (0, 291.5, 0), "outlast_space", "s_outlast_s2_5_mission_stadium", "outlast_space", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_contracts_outlast_stadium_instance_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 195;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-35654.5, -17269.5, 256), (0, 20, 0), "outlast_noent_entrance_trigger", "s_outlast_s2_5_mission_stadium", undefined, undefined, undefined, undefined, undefined, 750);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_sira_ob_contracts_outlast_stadium_instance_cs");
}