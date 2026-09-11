/*********************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_vig_script_street_intro.gsc
*********************************************************************************/

function vig_street_intro_init() {}

function vig_street_intro_start() {
  thread set_up_fx();
  thread hallway_peak_handler();
}

function set_up_fx() {}

function hallway_peak_handler() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("civ_doorPeak_intro", 1);
  waitframe();
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  var_0.animname = "doorPeak";
  var_0 setModel("body_civ_stpeterburg_male_5_1");
  var_1 = scripts\engine\utility::getStruct("vig_struct_doorPeak_intro", "targetname");
  var_2 = getEnt("intro_door_peak_door", "targetname");
  var_2 scripts\engine\sp\utility::assign_animtree("door");
  var_2.animname = "door";
  var_3 = getEnt("intro_door_peak_box", "targetname");
  var_3 scripts\engine\sp\utility::assign_animtree("box");
  var_3.animname = "box";
  var_1 scripts\common\anim::anim_first_frame_solo(var_3, "stp_vig_doorpeak_casual");
  var_1 scripts\common\anim::anim_first_frame_solo(var_2, "stp_vig_doorpeak");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0, "stp_vig_doorpeak");
  scripts\engine\sp\utility::trigger_wait_targetname("intro_stakeout_enter_hallway_trig");
  wait 0.2;
  thread door_peak_death_monitor();
  var_1 thread scripts\common\anim::anim_single_solo(var_2, "stp_vig_doorpeak");
  var_1 scripts\common\anim::anim_single_solo(var_0, "stp_vig_doorpeak");
  var_4 = getEnt("intro_stakeout_civ_sight_vol", "targetname");

  if(scripts\sp\maps\stpetersburg\stpetersburg_utility::player_weapon_holstered() == 0 && level.player istouching(var_4)) {
    var_5 = "stp_vig_doorpeak_alert";
    var_0 thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_civ_on_stairs_alerted();
  } else {
    var_5 = "stp_vig_doorpeak_casual";
    var_1 thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_civ_on_stairs_casual();
  }

  var_2 thread scripts\common\anim::anim_single_solo(var_4, var_5);
  var_2 thread scripts\common\anim::anim_single_solo(var_3, var_5);
  var_2 scripts\common\anim::anim_single_solo(var_1, var_5);
  var_2 scripts\common\anim::anim_last_frame_solo(var_1, var_5);
  wait 1;
  var_1 delete();
  var_4 delete();
}

function door_peak_alerted_monitor() {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_monitor");

  while(scripts\sp\maps\stpetersburg\stpetersburg_utility::player_weapon_holstered()) {
    wait 0.1;
  }

  self notify("civ_alerted");
  wait 1;
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_civ_on_stairs_alerted();
}

function door_peak_death_monitor() {
  self endon("entitydeleted");
  self waittill("death");
  thread door_peek_death_fail();
}

function door_peek_death_fail() {
  scripts\engine\utility::flag_set("disable_autosaves");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_civ_on_stairs_killed();
  wait 1;
  scripts\sp\player_death::set_custom_death_quote(9);
  thread scripts\sp\utility::missionfailedwrapper();
}

function door_peak_timer(var_0) {
  wait 2;
}