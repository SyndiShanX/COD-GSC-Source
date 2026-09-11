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
  var0 = scripts\engine\sp\utility::spawn_targetname("civ_doorPeak_intro", 1);
  waitframe();
  var0 endon("death");
  var0 endon("entitydeleted");
  var0 scripts\engine\sp\utility::set_allowdeath(1);
  var0.animname = "doorPeak";
  var0 setModel("body_civ_stpeterburg_male_5_1");
  var1 = scripts\engine\utility::getStruct("vig_struct_doorPeak_intro", "targetname");
  var2 = getEnt("intro_door_peak_door", "targetname");
  var2 scripts\engine\sp\utility::assign_animtree("door");
  var2.animname = "door";
  var3 = getEnt("intro_door_peak_box", "targetname");
  var3 scripts\engine\sp\utility::assign_animtree("box");
  var3.animname = "box";
  var1 scripts\common\anim::anim_first_frame_solo(var3, "stp_vig_doorpeak_casual");
  var1 scripts\common\anim::anim_first_frame_solo(var2, "stp_vig_doorpeak");
  var1 scripts\common\anim::anim_first_frame_solo(var0, "stp_vig_doorpeak");
  scripts\engine\sp\utility::trigger_wait_targetname("intro_stakeout_enter_hallway_trig");
  wait 0.2;
  thread door_peak_death_monitor();
  var1 thread scripts\common\anim::anim_single_solo(var2, "stp_vig_doorpeak");
  var1 scripts\common\anim::anim_single_solo(var0, "stp_vig_doorpeak");
  var4 = getEnt("intro_stakeout_civ_sight_vol", "targetname");

  if(scripts\sp\maps\stpetersburg\stpetersburg_utility::player_weapon_holstered() == 0 && level.player istouching(var4)) {
    var5 = "stp_vig_doorpeak_alert";
    var0 thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_civ_on_stairs_alerted();
  } else {
    var5 = "stp_vig_doorpeak_casual";
    var1 thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_civ_on_stairs_casual();
  }

  var2 thread scripts\common\anim::anim_single_solo(var4, var5);
  var2 thread scripts\common\anim::anim_single_solo(var3, var5);
  var2 scripts\common\anim::anim_single_solo(var1, var5);
  var2 scripts\common\anim::anim_last_frame_solo(var1, var5);
  wait 1;
  var1 delete();
  var4 delete();
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

function door_peak_timer(var0) {
  wait 2;
}