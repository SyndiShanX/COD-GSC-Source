/*****************************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_create_script.gsc
*****************************************************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_launchfacility_create_script;

function main(unused, us) {
  if(flag_exist("mp_jup_launchfacility_create_script")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_launchfacility_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_launchfacility_create_script");

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

  s cs_setup_arrays(us, "mp_jup_launchfacility_create_script");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_launchfacility_create_script");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (38389, 9370, 21868), (314.81, 279.81, 35.53), "wm_launch_ending_cam_attackers");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30937, 30776, 1720), (346, 338, 0), "wm_launch_ending_cam_defenders");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  s.animation = "jup_war_mp_attacker_exfil_guy01";
  fe[[f]](s, us, cf, (39190.1, 34005.8, 965.5), (0, 90, 0), "attacker_outro_body", undefined, "attacker_outro_body");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  s.animation = "jup_war_mp_attacker_exfil_player";
  fe[[f]](s, us, cf, (39190.1, 34005.8, 965.5), (0, 90, 0), "attacker_outro_player", undefined, "attacker_outro_player");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (32672, 33968, 1708.27), (0, 0, 0), undefined, undefined, "package_zone2_attacker");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  s.animation = "jup_war_defender_exfil_tank_cougar";
  fe[[f]](s, us, cf, (31078.3, 30937, 1690.5), (0, 214.97, 0.4), "defender_outro_tank", undefined, "defender_outro_tank");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  s.animation = "jup_war_defender_exfil_soldier_01";
  fe[[f]](s, us, cf, (31078.3, 30937, 1690.5), (0, 214.97, 0.4), "defender_outro_soldier_01", undefined, "defender_outro_soldier_01");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  s.animation = "jup_war_defender_exfil_soldier_02";
  fe[[f]](s, us, cf, (31078.3, 30937, 1690.5), (0, 214.97, 0.4), "defender_outro_soldier_02", undefined, "defender_outro_soldier_02");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  s.animation = "jup_war_defender_exfil_soldier_03";
  fe[[f]](s, us, cf, (31078.3, 30937, 1690.5), (0, 214.97, 0.4), "defender_outro_soldier_03", undefined, "defender_outro_soldier_03");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  s.animation = "jup_war_defender_exfil_missile_01_launch";
  fe[[f]](s, us, cf, (31078.3, 30937, 1690.5), (0, 214.97, 0.4), "defender_outro_missile_01", undefined, "defender_outro_missile_01");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  s.animation = "jup_war_defender_exfil_missile_02_launch";
  fe[[f]](s, us, cf, (31078.3, 30937, 1690.5), (0, 214.97, 0.4), "defender_outro_missile_02", undefined, "defender_outro_missile_02");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (32417.8, 31313.6, 1894), (0, 119.18, 0), "cspf_0_auto10975649990024141835");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  s.animation = "jup_war_defender_exfil_missile";
  fe[[f]](s, us, cf, (31078.3, 30937, 1690.5), (0, 214.97, 0.4), "defender_outro_missile", undefined, "defender_outro_missile");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  s.animation = "jup_war_mp_attacker_exfil_end_missile";
  fe[[f]](s, us, cf, (38896, 32784, 17392), (0, 0, 0), "attacker_outro_missile", undefined, "attacker_outro_missile");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (28816, 30792, 1700.4), (0, 0, 0), undefined, undefined, "package_zone1_attacker");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (34712, 31344, 1543), (0, 0, 0), undefined, undefined, "package_zone2_defender");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (32369.5, 31300, 1894), (0, 205.77, 0), "defender_outro_MG", "cspf_0_auto10975649990024141835", "defender_outro_MG");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (31695.8, 30763.6, 1677.25), (0, 0, 0), undefined, undefined, "defender_outro_extra_missile");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (31192.5, 30527.5, 1659.75), (0, 0, 0), undefined, undefined, "defender_outro_MG_fire_pos");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30776, 31750, 1706), (0, 110, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30672, 31712, 1714), (0, 46, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30952, 31752, 1706), (0, 20, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30712, 31952, 1706), (0, 80, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (29349.8, 33146.7, 1706), (0, 260, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30149.8, 31480.7, 1706), (0, 176, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30625.4, 31113.8, 1714), (0, 166, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30197.7, 31129.5, 1706), (0, 180, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (29537.8, 33370.7, 1706), (0, 224, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30322, 31346, 1706), (0, 190, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (29729.8, 33122.7, 1706), (0, 22, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (29829.8, 33316.7, 1706), (0, 22, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (29485.8, 33240.7, 1706), (0, 184, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (29769.8, 33566.7, 1706), (0, 302, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (29429.8, 31980.7, 1706), (0, 302, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (29821.8, 31778.7, 1706), (0, 134, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30221.8, 32250.7, 1714), (0, 180, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30045.8, 32262.7, 1714), (0, 72, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (29959.8, 32308.7, 1886), (0, 352, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (30089.8, 32066.7, 1886), (0, 250, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  fe[[f]](s, us, cf, (29419.8, 32020.7, 1886), (0, 18, 0), undefined, undefined, "zombie_point");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_create_script";
  s.animation = "jup_war_defender_exfil_tank_cougar_dst";
  fe[[f]](s, us, cf, (31078.3, 30937, 1690.5), (0, 214.97, 0.4), "defender_outro_tank_dst", undefined, "defender_outro_tank_dst");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_launchfacility_create_script");
}