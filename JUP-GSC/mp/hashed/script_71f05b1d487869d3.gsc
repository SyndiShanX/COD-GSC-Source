/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_71f05b1d487869d3.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_bigmap_ob_s3_relic_crayon_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_bigmap_ob_s3_relic_crayon_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_bigmap_ob_s3_relic_crayon_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_bigmap_ob_s3_relic_crayon_cs");

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

  s cs_setup_arrays(us, "mp_jup_bigmap_ob_s3_relic_crayon_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_bigmap_ob_s3_relic_crayon_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_bed_interact";
  fe[[f]](s, us, cf, (41777.6, -26954.1, 3463.06), (0, 0, 0), "relic_journal_bed_interact", undefined, "relic_journal_bed_interact", undefined, undefined, undefined, undefined, 30);
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_bed_reward";
  fe[[f]](s, us, cf, (41837.1, -26961.4, 3494), (0, 0, 0), "relic_journal_bed_reward", undefined, "relic_journal_bed_reward");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_footstep_right_03";
  fe[[f]](s, us, cf, (41803.6, -26528, 3462.06), (0, 267.84, 0), "relic_crayon_footstep_right");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_footstep_left_02";
  fe[[f]](s, us, cf, (41019.5, -26088.7, 3238), (0, 0.93, 0), "relic_crayon_footstep_left");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (32, 18, 26);
  s.var_74e936bbadd15418 = (6, 26, 6);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (41764.8, -26945.2, 3462), (0, 0, 0), "relic_crayon_footstep_bed_trigger");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_footstep_right_02";
  fe[[f]](s, us, cf, (40994.8, -26104.3, 3238.18), (0, 0.93, 0), "relic_crayon_footstep_right");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_footstep_right_01";
  fe[[f]](s, us, cf, (40325.9, -26143.1, 3215.21), (0, 0, 0), "relic_crayon_footstep_right");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_footstep_left_03";
  fe[[f]](s, us, cf, (41697.2, -26222.3, 3286.06), (0, 355.85, 0), "relic_crayon_footstep_left");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_footstep_right_04";
  fe[[f]](s, us, cf, (42097.1, -26349.4, 3462.06), (0, 187.79, 0), "relic_crayon_footstep_right");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_footstep_left_04";
  fe[[f]](s, us, cf, (41822.1, -26502.2, 3462), (0, 267.23, 0), "relic_crayon_footstep_left");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_footstep_left_01";
  fe[[f]](s, us, cf, (40300.1, -26127.5, 3211.94), (0, 0, 0), "relic_crayon_footstep_left");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_footstep_right_05";
  fe[[f]](s, us, cf, (41776.8, -26953.6, 3462.06), (0, 344.14, 0), "relic_crayon_footstep_right");
  s = s();
  s.cs_flag = "mp_jup_bigmap_ob_s3_relic_crayon_cs";
  s.name = "relic_journal_footstep_left_05";
  fe[[f]](s, us, cf, (42073.8, -26370.8, 3462.06), (0, 187.79, 0), "relic_crayon_footstep_left");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_bigmap_ob_s3_relic_crayon_cs");
}