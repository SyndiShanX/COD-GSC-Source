/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_52e2837d89d8de06.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_s5_attunement_giraffe_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_s5_attunement_giraffe_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_s5_attunement_giraffe_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_s5_attunement_giraffe_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_s5_attunement_giraffe_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_s5_attunement_giraffe_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_s5_attunement_giraffe_cs";
  s.name = "s5_attunement_giraffe_starter";
  fe[[f]](s, us, cf, (8620.97, 6913.39, 1447.37), (0, 143.63, 0), "s5_attunement_giraffe_starter", undefined, "s5_attunement_giraffe_starter");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_s5_attunement_giraffe_cs";
  s.name = "s5_attunement_giraffe_encounter_spawn";
  fe[[f]](s, us, cf, (8496.28, 6375.93, 1436), (0, 310, 0), "s5_attunement_giraffe_encounter_spawn", undefined, "s5_attunement_giraffe_encounter_spawn", undefined, undefined, undefined, undefined, 450);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_s5_attunement_giraffe_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 3000;
  s.name = "s5_attunement_giraffe_leave_radius";
  fe[[f]](s, us, cf, (8496.28, 6375.93, 397.83), (0, 0, 0), "s5_attunement_giraffe_leave_radius", undefined, "s5_attunement_giraffe_leave_radius", undefined, undefined, undefined, undefined, 10000, undefined, 512);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_s5_attunement_giraffe_cs";
  s.name = "s5_attunement_setdressing_zombie";
  fe[[f]](s, us, cf, (8614.55, 6941.08, 1414.02), (0, 357.18, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", undefined, "zombie_setdressing_sat2");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_s5_attunement_giraffe_cs");
}