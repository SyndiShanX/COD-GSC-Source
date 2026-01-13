/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_logswing.gsc
*******************************************************/

init_logswing_trap() {
  wait(1);
  var_0 = getent("logswing_trap", "targetname");
  var_1 = getent("logswing_trig", "targetname");
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  var_1 enablelinkto();
  var_1 linkto(var_0, "tag_trigger");
  var_2 = getEntArray("swing_trap_pole", "targetname");
  foreach(var_4 in var_2) {
    var_4 setscriptablepartstate("light", "on");
  }
}

use_logswing_trap(var_0, var_1) {
  var_1 playlocalsound("purchase_generic");
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  var_2 = getent("logswing_trig", "targetname");
  var_3 = getEntArray("swing_trap_pole", "targetname");
  foreach(var_5 in var_3) {
    var_5 setscriptablepartstate("light", "off");
  }

  var_7 = getent("logswing_trap", "targetname");
  var_7 thread log_swing_trap_sfx();
  var_8 = getanimlength( % iw7_cp_log_swing);
  var_7 scriptmodelplayanimdeltamotion("IW7_cp_log_swing", 1);
  var_0.trap_kills = 0;
  var_7 thread kill_zombies(var_2, var_1, var_0);
  wait(var_8);
  var_7 scriptmodelplayanimdeltamotion("IW7_cp_log_swing", 1);
  wait(var_8);
  var_2 notify("stop_trap");
  level notify("logswing_trap_kills", var_0.trap_kills);
  scripts\cp\cp_interaction::enable_linked_interactions(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, 45);
  foreach(var_5 in var_3) {
    var_5 setscriptablepartstate("light", "on");
  }
}

log_swing_trap_sfx() {
  var_0 = spawn("script_model", self.origin);
  wait(0.05);
  var_0 linkto(self, "tag_trigger");
  wait(0.05);
  var_0 playsoundonmovingent("rave_log_swing_trap_sfx");
  wait(9);
  var_0 delete();
}

kill_zombies(var_0, var_1, var_2) {
  var_0 endon("stop_trap");
  for(;;) {
    var_0 waittill("trigger", var_3);
    if(isplayer(var_3) && !scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      var_3 dodamage(var_3.health + 100, var_3.origin);
      continue;
    }

    if(isDefined(var_3.flung)) {
      continue;
    }

    if(isDefined(var_3.agent_type) && var_3.agent_type == "slasher") {
      continue;
    }

    var_3.flung = 1;
    var_2.trap_kills++;
    level thread fling_zombie(var_3, self, var_1);
  }
}

fling_zombie(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0.do_immediate_ragdoll = 1;
  var_0.customdeath = 1;
  var_0.disable_armor = 1;
  var_0.nocorpse = 1;
  var_0.full_gib = 1;
  var_3 = ["kill_trap_generic", "kill_trap_1", "kill_trap_2", "kill_trap_3", "kill_trap_4", "kill_trap_5", "kill_trap_6", "trap_kill_7"];
  var_2 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_3), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
  if(var_2 scripts\cp\utility::is_valid_player()) {
    var_0 dodamage(var_0.health + 1000, var_0.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_discotrap_zm");
    return;
  }

  var_0 dodamage(var_0.health + 1000, var_0.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_discotrap_zm");
}