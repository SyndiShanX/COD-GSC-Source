/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7396e8f29969c90c.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_hydro_ob_s3_rift_run_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_hydro_ob_s3_rift_run_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_hydro_ob_s3_rift_run_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_hydro_ob_s3_rift_run_cs");

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

  s cs_setup_arrays(us, "mp_jup_hydro_ob_s3_rift_run_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_hydro_ob_s3_rift_run_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.name = "zombieObject_damage";
  fe[[f]](s, us, cf, (-12201.6, 12386.4, 506.5), (0, 315, 0), "obeliskspawn", undefined, "damage");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.name = "riftHeart";
  fe[[f]](s, us, cf, (-8381.61, 8636.14, 309), (0, 48, 0), "heartspawn");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.name = "riftHeartArtery";
  fe[[f]](s, us, cf, (-6713.75, 9984.25, 197.74), (0, 0, -0), "arteryspawn");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.name = "riftHeartArtery";
  fe[[f]](s, us, cf, (-10162.6, 6681.04, 137.89), (0, 0, 0), "arteryspawn");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.name = "riftHeartArtery";
  fe[[f]](s, us, cf, (-9353.5, 9446.82, 342.63), (0, 0, 0), "arteryspawn");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.name = "zombieObject_movement";
  fe[[f]](s, us, cf, (-5652.98, 14501.5, 352), (0, 315, 0), "obeliskspawn", undefined, "speedboost");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.name = "zombieObject_vision";
  fe[[f]](s, us, cf, (-4048.54, 6989.3, 984), (0, 238.31, 0), "obeliskspawn", undefined, "vision");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.name = "rr_damage_object_proximity_spawn";
  fe[[f]](s, us, cf, (-12302.5, 12495.7, 506.5), (0, 310, 0), "rr_damage_object_proximity_spawn", undefined, "rr_damage_object_proximity_spawn", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 1132;
  s.name = "rr_movement_object_proximity_trigger";
  fe[[f]](s, us, cf, (-5653.13, 14501.7, 352), (0, 0, 0), "rr_movement_object_proximity_trigger", undefined, undefined, undefined, undefined, undefined, undefined, 1750, undefined, 512);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.name = "rr_movement_object_proximity_spawn";
  fe[[f]](s, us, cf, (-5164.73, 14444.7, 352), (0, 310, 0), "rr_movement_object_proximity_spawn", undefined, "rr_movement_object_proximity_spawn", undefined, undefined, undefined, undefined, 500);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 888;
  s.name = "rr_vision_object_proximity_trigger";
  fe[[f]](s, us, cf, (-4050.98, 6985.96, 339), (0, 0, 0), "rr_vision_object_proximity_trigger", undefined, undefined, undefined, undefined, undefined, undefined, 1750, undefined, 512);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.name = "rr_vision_object_proximity_spawn";
  fe[[f]](s, us, cf, (-4154.23, 6914.54, 984), (0, 310, 0), "rr_vision_object_proximity_spawn", undefined, "rr_vision_object_proximity_spawn", undefined, undefined, undefined, undefined, 500);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (824, 736, 536);
  s.var_74e936bbadd15418 = (326, 544, 260);
  s.height = 128;
  s.length = "128";
  s.name = "rr_starting_platform_trigger";
  s.width = "128";
  fe[[f]](s, us, cf, (-14452.5, 1803.25, 1187), (0, 45, 0), "rr_starting_platform_trigger");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.name = "stormspawn";
  fe[[f]](s, us, cf, (-8692.12, 8858.51, 304), (0, 43.8, 0), "stormspawn", undefined, undefined, undefined, undefined, undefined, undefined, 1750);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_s3_rift_run_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 800;
  s.name = "rr_damage_object_proximity_trigger";
  fe[[f]](s, us, cf, (-12201.1, 12385.7, 440), (0, 0, 0), "rr_damage_object_proximity_trigger", undefined, undefined, undefined, undefined, undefined, undefined, 1750, undefined, 512);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_hydro_ob_s3_rift_run_cs");
}