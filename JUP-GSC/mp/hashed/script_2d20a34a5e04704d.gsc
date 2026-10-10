/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2d20a34a5e04704d.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_puzzles;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_puzzles")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_puzzles");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_puzzles");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_puzzles");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_puzzles");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_puzzles";
  s.name = "spatial_water_obelisk";
  fe[[f]](s, us, cf, (16122.2, -20053, 1478.52), (0.22, 0, 0.96), "spatial_water_obelisk");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_puzzles";
  s.name = "spatial_water_runes";
  fe[[f]](s, us, cf, (15447.7, -18926.2, 1130.09), (28.45, 132.41, 12.65), undefined, undefined, "spatial_water_runes");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_puzzles";
  s.name = "spatial_water_runes";
  fe[[f]](s, us, cf, (13666.5, -20014.9, 1363.27), (355.23, 244.21, -1.89), undefined, undefined, "spatial_water_runes");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_puzzles";
  s.name = "spatial_water_runes";
  fe[[f]](s, us, cf, (14684.3, -18457.7, 1163.75), (308.7, 340.36, 0.32), undefined, undefined, "spatial_water_runes");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_puzzles";
  s.name = "spatial_water_alignment";
  fe[[f]](s, us, cf, (14424, -19783, 1356), (0, 86, 0), "spatial_water_alignment");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_puzzles";
  s.name = "spatial_water_reward";
  fe[[f]](s, us, cf, (16068.2, -19819, 1477.87), (352.92, 283.06, -0.52), "spatial_water_reward");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_puzzles";
  s.name = "spatial_water_runes";
  fe[[f]](s, us, cf, (14867, -19205.4, 1134.75), (31.14, 196.85, 53.29), undefined, undefined, "spatial_water_runes");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_puzzles";
  s.name = "spatial_water_runes";
  fe[[f]](s, us, cf, (15935.5, -18592.7, 1198.24), (357.36, 73.4, 25.9), undefined, undefined, "spatial_water_runes");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_puzzles";
  s.name = "spatial_water_runes";
  fe[[f]](s, us, cf, (15577.8, -19416.2, 1269.71), (345.39, 150.8, 12.82), undefined, undefined, "spatial_water_runes");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_puzzles";
  s.name = "spatial_water_orb";
  fe[[f]](s, us, cf, (16122.2, -20053, 1678.52), (0, 0, 0), "spatial_water_orb");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_puzzles";
  s.name = "spatial_water_runes";
  fe[[f]](s, us, cf, (15033.5, -19950.9, 1347.99), (287.09, 148.78, -25.28), undefined, undefined, "spatial_water_runes");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_puzzles");
}