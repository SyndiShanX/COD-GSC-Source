/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_logswing.gsc
*******************************************************/

init_logswing_trap() {
  wait(1);
  var_00 = getent("logswing_trap", "targetname");
  var_01 = getent("logswing_trig", "targetname");
  if(!isDefined(var_00) || !isDefined(var_01)) {
    return;
  }

  var_01 enablelinkto();
  var_01 linkto(var_00, "tag_trigger");
  var_02 = getEntArray("swing_trap_pole", "targetname");
  foreach(var_04 in var_02) {
    var_04 setscriptablepartstate("light", "on");
  }
}

use_logswing_trap(param_00, param_01) {
  param_01 playlocalsound("purchase_generic");
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  var_02 = getent("logswing_trig", "targetname");
  var_03 = getEntArray("swing_trap_pole", "targetname");
  foreach(var_05 in var_03) {
    var_05 setscriptablepartstate("light", "off");
  }

  var_07 = getent("logswing_trap", "targetname");
  var_07 thread log_swing_trap_sfx();
  var_08 = getanimlength( % iw7_cp_log_swing);
  var_07 scriptmodelplayanimdeltamotion("IW7_cp_log_swing", 1);
  param_00.trap_kills = 0;
  var_07 thread kill_zombies(var_02, param_01, param_00);
  wait(var_08);
  var_07 scriptmodelplayanimdeltamotion("IW7_cp_log_swing", 1);
  wait(var_08);
  var_02 notify("stop_trap");
  level notify("logswing_trap_kills", param_00.trap_kills);
  scripts\cp\cp_interaction::enable_linked_interactions(param_00);
  scripts\cp\cp_interaction::interaction_cooldown(param_00, 45);
  foreach(var_05 in var_03) {
    var_05 setscriptablepartstate("light", "on");
  }
}

log_swing_trap_sfx() {
  var_00 = spawn("script_model", self.origin);
  wait(0.05);
  var_00 linkto(self, "tag_trigger");
  wait(0.05);
  var_00 playsoundonmovingent("rave_log_swing_trap_sfx");
  wait(9);
  var_00 delete();
}

kill_zombies(param_00, param_01, param_02) {
  param_00 endon("stop_trap");
  for(;;) {
    param_00 waittill("trigger", var_03);
    if(isplayer(var_03) && !scripts\cp\cp_laststand::player_in_laststand(var_03)) {
      var_03 dodamage(var_03.health + 100, var_03.origin);
      continue;
    }

    if(isDefined(var_03.flung)) {
      continue;
    }

    if(isDefined(var_03.agent_type) && var_03.agent_type == "slasher") {
      continue;
    }

    var_03.flung = 1;
    param_02.trap_kills++;
    level thread fling_zombie(var_03, self, param_01);
  }
}

fling_zombie(param_00, param_01, param_02) {
  param_00 endon("death");
  param_00.do_immediate_ragdoll = 1;
  param_00.customdeath = 1;
  param_00.disable_armor = 1;
  param_00.nocorpse = 1;
  param_00.full_gib = 1;
  var_03 = ["kill_trap_generic", "kill_trap_1", "kill_trap_2", "kill_trap_3", "kill_trap_4", "kill_trap_5", "kill_trap_6", "trap_kill_7"];
  param_02 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_03), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
  if(param_02 scripts\cp\utility::is_valid_player()) {
    param_00 dodamage(param_00.health + 1000, param_00.origin, param_02, param_02, "MOD_UNKNOWN", "iw7_discotrap_zm");
    return;
  }

  param_00 dodamage(param_00.health + 1000, param_00.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_discotrap_zm");
}