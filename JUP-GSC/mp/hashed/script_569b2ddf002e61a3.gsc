/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_569b2ddf002e61a3.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_ambient_biomes_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_ambient_biomes_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_ambient_biomes_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_ambient_biomes_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_ambient_biomes_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_ambient_biomes_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-32562, 11107.4, 1084.4), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-36291, 9134.7, 960.37), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-33077.3, 7494.54, 1168.35), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-32892.5, 3031.88, 1249.35), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-24958.4, -145.85, 1087.4), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-22635, -1126.19, 1390.97), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-21336.4, -1562.28, 1578.96), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-20599.4, 2107.47, 1399.66), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-22321.1, 3089.82, 1377.64), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-19224.7, 4310.18, 1425.62), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-17460.4, 2712.8, 1271.59), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-27145.1, 1712.34, 1030.66), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-24631, 2843.47, 1188.44), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-18519.1, 37.64, 1271.94), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-27459.6, 14206, 1241.92), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-32229, 14498, 1145), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-27502.9, 11334.1, 1232.87), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-27304.1, 8209.46, 1196.51), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-26752.2, 5816.37, 1178.1), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-26340.8, 3544.21, 1379.1), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}