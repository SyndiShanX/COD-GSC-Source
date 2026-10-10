/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2b421d13744fcb7e.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_s5_attunement_drum_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_s5_attunement_drum_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_s5_attunement_drum_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_s5_attunement_drum_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_s5_attunement_drum_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_s5_attunement_drum_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_starter";
  fe[[f]](s, us, cf, (8680.74, -24589, 1970.14), (0, 155.38, 0), "s5_attunement_drum_starter", undefined, "s5_attunement_drum_starter");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (88, 88, 132);
  s.var_74e936bbadd15418 = (90, 88, 32);
  s.height = 128;
  s.length = "128";
  s.name = "s5_attunement_drum_ammomod_napalmburst_trigger";
  s.width = "128";
  fe[[f]](s, us, cf, (9041.95, -25076.2, 1768), (0, -4, 0), "s5_attunement_drum_ammomod_trigger", undefined, "napalmburst");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammomod_napalmburst_spawn";
  fe[[f]](s, us, cf, (9044.64, -25036.3, 1768), (0, 86, 0), "s5_attunement_drum_ammomod_spawn", undefined, "napalmburst");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (90, 88, 132);
  s.var_74e936bbadd15418 = (90, 88, 32);
  s.height = 128;
  s.length = "128";
  s.name = "s5_attunement_drum_ammomod_brainrot_trigger";
  s.width = "128";
  fe[[f]](s, us, cf, (8229.55, -25022.7, 1768), (0, -4, 0), "s5_attunement_drum_ammomod_trigger", undefined, "brainrot");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (92, 88, 132);
  s.var_74e936bbadd15418 = (90, 88, 32);
  s.height = 128;
  s.length = "128";
  s.name = "s5_attunement_drum_ammomod_cryofreeze_trigger";
  s.width = "128";
  fe[[f]](s, us, cf, (9095.37, -24263.7, 1768), (0, -4, 0), "s5_attunement_drum_ammomod_trigger", undefined, "cryofreeze");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (90, 88, 132);
  s.var_74e936bbadd15418 = (88, 90, 32);
  s.height = 128;
  s.length = "128";
  s.name = "s5_attunement_drum_ammomod_deadwire_trigger";
  s.width = "128";
  fe[[f]](s, us, cf, (8282.21, -24209.2, 1768), (0, -4, 0), "s5_attunement_drum_ammomod_trigger", undefined, "deadwire");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammozombie_spawn";
  fe[[f]](s, us, cf, (9607.32, -24700.7, 1768), (0, 86, 0), "s5_attunement_drum_ammozombie_spawn", undefined, "s5_attunement_drum_ammozombie_spawn", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammozombie_spawn";
  fe[[f]](s, us, cf, (8725.42, -23700.3, 1744.69), (0, 86, 0), "s5_attunement_drum_ammozombie_spawn", undefined, "s5_attunement_drum_ammozombie_spawn", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammomod_cryofreeze_spawn";
  fe[[f]](s, us, cf, (9092.56, -24303.4, 1768), (0, 266, 0), "s5_attunement_drum_ammomod_spawn", undefined, "cryofreeze");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammozombie_spawn";
  fe[[f]](s, us, cf, (7718.02, -24582.2, 1768), (0, 86, 0), "s5_attunement_drum_ammozombie_spawn", undefined, "s5_attunement_drum_ammozombie_spawn", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammozombie_spawn";
  fe[[f]](s, us, cf, (8600.87, -25589.2, 1768), (0, 86, 0), "s5_attunement_drum_ammozombie_spawn", undefined, "s5_attunement_drum_ammozombie_spawn", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_setdressing_zombie";
  fe[[f]](s, us, cf, (8667.85, -24554.2, 1929.37), (0, 282.2, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_09", undefined, "zombie_setdressing_hang");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_floodencounter_spawn";
  fe[[f]](s, us, cf, (8788.96, -24653.4, 1744.69), (0, 86, 0), "s5_attunement_drum_floodencounter_spawn", undefined, "s5_attunement_drum_floodencounter_spawn", undefined, undefined, undefined, undefined, 1150);
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammomod_deadwire_spawn";
  fe[[f]](s, us, cf, (8279.71, -24250.1, 1768), (0, 266, 0), "s5_attunement_drum_ammomod_spawn", undefined, "deadwire");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammomod_napalmburst_vfxspawn";
  fe[[f]](s, us, cf, (9044.64, -25036.3, 1808), (0, 86, 0), "s5_attunement_drum_ammomod_vfxspawn", undefined, "napalmburst");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammomod_brainrot_spawn";
  fe[[f]](s, us, cf, (8228.47, -24982.9, 1768), (0, 86, 0), "s5_attunement_drum_ammomod_spawn", undefined, "brainrot");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammomod_cryofreeze_vfxspawn";
  fe[[f]](s, us, cf, (9092.56, -24303.4, 1808), (0, 266, 0), "s5_attunement_drum_ammomod_vfxspawn", undefined, "cryofreeze");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammomod_deadwire_vfxspawn";
  fe[[f]](s, us, cf, (8279.71, -24250.1, 1808), (0, 266, 0), "s5_attunement_drum_ammomod_vfxspawn", undefined, "deadwire");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_s5_attunement_drum_cs";
  s.name = "s5_attunement_drum_ammomod_brainrot_vfxspawn";
  fe[[f]](s, us, cf, (8228.47, -24982.9, 1808), (0, 86, 0), "s5_attunement_drum_ammomod_vfxspawn", undefined, "brainrot");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_s5_attunement_drum_cs");
}