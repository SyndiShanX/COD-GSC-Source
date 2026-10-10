/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5cc103e78831ad9f.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_ambient_biomes_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_ambient_biomes_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_ambient_biomes_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_ambient_biomes_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_ambient_biomes_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_ambient_biomes_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (25571.8, -38592.6, 3287.1), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (26202.7, -37298.9, 3101.1), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (21907.4, -35497.2, 3618.75), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (27193.3, -30724.4, 3616), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (24236.3, -32602.1, 3684), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (21690.7, -30489.5, 3376), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (21541.5, -28141.6, 3341.96), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (23867.8, -25806.8, 3179.24), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (26137.9, -25089.3, 3112.95), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (29161.7, -27221.8, 3420.95), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (29800.8, -26014.4, 3264.95), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (29567.4, -23354, 3343.81), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (30479.7, -22756.6, 3218.67), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (21862.4, -20849.7, 2884.53), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (22290.6, -18217, 3027.37), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (18966.9, -23085, 2899.37), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (38383.4, -19621.8, 3220.96), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (36933.1, -21247, 3161.46), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (40069.6, -23699.5, 3122), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (41482.1, -26264.8, 3456.62), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1700);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (41618, -21569.4, 3171.58), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (39057.7, -28089.7, 3121.95), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (42742.6, -28417.1, 3156.71), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (44363.1, -30045.1, 3128.78), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (44261.1, -28707.9, 3116.86), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (33025, -35116, 3248.35), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (36589.5, -35409.9, 3328.65), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (27360, -39648, 3216), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}