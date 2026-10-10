/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_107f57229aa7af6e.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_s5_relic_drum_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_s5_relic_drum_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_s5_relic_drum_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_s5_relic_drum_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_s5_relic_drum_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_s5_relic_drum_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (64, 136, 146);
  s.var_74e936bbadd15418 = (76, 104, 32);
  s.height = 128;
  s.length = "128";
  s.name = "s5_relic_drum_race_trigger_end";
  s.width = "128";
  fe[[f]](s, us, cf, (12725.6, -12211.3, 1785.53), (0, 267, 0), "s5_relic_drum_race_trigger_end", undefined, "s5_relic_drum_race_trigger_end");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.name = "s5_relic_drum_race_struct_arrow";
  fe[[f]](s, us, cf, (11351.2, 1216.81, 1727.91), (270, 351.45, 171.45), "s5_relic_drum_race_struct_arrow", undefined, "s5_relic_drum_race_struct_arrow");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.name = "s5_relic_drum_race_struct_reward";
  fe[[f]](s, us, cf, (12691.5, -12430.9, 1785.68), (0, 0, 0), "s5_relic_drum_race_struct_reward", undefined, "s5_relic_drum_race_struct_reward");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.name = "s5_relic_drum_race_struct_arrow";
  fe[[f]](s, us, cf, (12658.8, -6625.83, 1536.47), (359.4, 80.53, -19.11), "s5_relic_drum_race_struct_arrow", undefined, "s5_relic_drum_race_struct_arrow");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.name = "s5_relic_drum_race_struct_mrpeeks_spawn";
  fe[[f]](s, us, cf, (11337.2, 1237.78, 1759.47), (0, 298, 0), "s5_relic_drum_race_struct_mrpeeks_spawn", undefined, "s5_relic_drum_race_struct_mrpeeks_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.name = "s5_relic_drum_race_struct_arrow";
  fe[[f]](s, us, cf, (12681.6, -11165.8, 1723.96), (359.97, 358.32, 124.01), "s5_relic_drum_race_struct_arrow", undefined, "s5_relic_drum_race_struct_arrow");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.name = "s5_relic_drum_race_struct_arrow";
  fe[[f]](s, us, cf, (14571.3, -3682.73, 1415.95), (301.63, 136.28, -51.42), "s5_relic_drum_race_struct_arrow", undefined, "s5_relic_drum_race_struct_arrow");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.name = "s5_relic_drum_race_struct_arrow";
  fe[[f]](s, us, cf, (13347.7, -1946.39, 1576.14), (0, 123.5, -94.2), "s5_relic_drum_race_struct_arrow", undefined, "s5_relic_drum_race_struct_arrow");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.name = "s5_relic_drum_race_struct_arrow";
  fe[[f]](s, us, cf, (11918.1, -7037.39, 1649.78), (359.13, 5.85, 132.49), "s5_relic_drum_race_struct_arrow", undefined, "s5_relic_drum_race_struct_arrow");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (-92, 266, 146);
  s.var_74e936bbadd15418 = (140, 266, -2);
  s.height = 128;
  s.length = "128";
  s.name = "s5_relic_drum_race_trigger_start";
  s.width = "128";
  fe[[f]](s, us, cf, (11441.6, 1084.37, 1752), (0, 304, 0), "s5_relic_drum_race_trigger_start", undefined, "s5_relic_drum_race_trigger_start");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.name = "s5_relic_drum_race_struct_mrpeeks_spawn";
  fe[[f]](s, us, cf, (12769.8, -12473.7, 1809.15), (0, 119.18, 0), "s5_relic_drum_race_struct_mrpeeks_spawn", undefined, "s5_relic_drum_race_struct_mrpeeks_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (130, 176, 146);
  s.var_74e936bbadd15418 = (124, 158, 32);
  s.height = 128;
  s.length = "128";
  s.name = "s5_relic_drum_race_trigger_checkpoint_1";
  s.width = "128";
  fe[[f]](s, us, cf, (13379.4, -2188.88, 1408), (0, 304, 0), "s5_relic_drum_race_trigger_checkpoint", undefined, "s5_relic_drum_race_trigger_checkpoint_1");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (130, 176, 146);
  s.var_74e936bbadd15418 = (124, 190, 32);
  s.height = 128;
  s.length = "128";
  s.name = "s5_relic_drum_race_trigger_checkpoint_2";
  s.width = "128";
  fe[[f]](s, us, cf, (12166.4, -7659.15, 1579.54), (0, 282.26, 0), "s5_relic_drum_race_trigger_checkpoint", undefined, "s5_relic_drum_race_trigger_checkpoint_2");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_s5_relic_drum_cs";
  s.name = "s5_relic_drum_race_struct_arrow";
  fe[[f]](s, us, cf, (12405.7, -9247.87, 1652), (359.13, 15.25, 132.49), "s5_relic_drum_race_struct_arrow", undefined, "s5_relic_drum_race_struct_arrow");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_s5_relic_drum_cs");
}