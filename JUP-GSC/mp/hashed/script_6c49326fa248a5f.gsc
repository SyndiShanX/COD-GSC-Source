/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6c49326fa248a5f.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_ambient_biomes_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_ambient_biomes_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_ambient_biomes_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_ambient_biomes_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_ambient_biomes_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_ambient_biomes_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-555.66, 36884.8, 1272.17), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1700);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (3493.12, 37419.7, 1651.04), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2400);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (6143.26, 37701.9, 1520.07), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2400);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-1548.74, 35897.2, 1443.11), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-1895.03, 37644.9, 1497.26), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-5802.97, 35583.7, 1334.14), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-5811.97, 37297.8, 1357.38), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (7716.38, 36042.8, 1713.66), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (9499.99, 36724.7, 1275.66), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (11361.1, 36042.9, 1670.79), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-4205.37, 33464.7, 1357.2), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-1762.45, 33407.6, 1450.1), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (1333.22, 33101.4, 1200.1), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (5217.87, 32447.2, 1212.15), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (9065.73, 32596.6, 1570.52), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (7897.15, 30736.3, 1347.14), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (3270.28, 34077.7, 1449.91), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (2737.47, 31374, 1232.91), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (14766.8, 32291.8, 1154.1), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (14120.5, 29974.5, 1203.1), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (13050.8, 27687.7, 1178.1), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-7937.99, 28692.4, 1159.28), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-870.98, 25131.5, 1133.29), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 5000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (4916.22, 23264.6, 1304.89), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 5000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-6096.35, 23742.4, 1428.18), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-3966.01, 29723, 1286.5), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (8873.11, 25639, 1212.5), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (12620.3, 24184, 991.49), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (12132.5, 22142.9, 985.67), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (11704.7, 20708.7, 974.68), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-754.32, 18695.8, 1264.68), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-3590.32, 36707.7, 1836.86), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-7548, 36435, 1533), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}