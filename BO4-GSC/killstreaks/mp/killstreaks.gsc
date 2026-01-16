/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\killstreaks.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\system_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\mp\killstreak_vehicle;
#include scripts\killstreaks\mp\killstreakrules;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_score;

#namespace killstreaks;

autoexec __init__system__() {
  system::register(#"killstreaks", &__init__, undefined, #"weapons");
}

__init__() {
  init_shared();
  killstreak_vehicle::init();
  killstreakrules::init();
  callback::on_start_gametype(&init);
  level.var_1492d026 = &play_killstreak_start_dialog;
  level.var_bdff8e21 = getgametypesetting(#"hash_2560dae45cc112e3");
}

init() {

  level.killstreak_init_start_time = getmillisecondsraw();
  thread debug_ricochet_protection();

    function_447e6858();
  level.var_b0dc03c7 = &function_395f82d0;
  level.play_killstreak_firewall_being_hacked_dialog = &function_427f6a2e;
  level.play_killstreak_firewall_hacked_dialog = &function_6fa91236;
  level.play_killstreak_being_hacked_dialog = &function_1cd175ba;
  level.play_killstreak_hacked_dialog = &function_520a5752;
  level.play_killstreak_start_dialog = &function_7bed52a;
  level.play_pilot_dialog_on_owner = &function_9716fce9;
  level.play_pilot_dialog = &function_f6370f75;
  level.play_destroyed_dialog_on_owner = &function_6a5cc212;
  level.play_taacom_dialog_response_on_owner = &function_3cf68327;
  level.play_taacom_dialog = &function_3d6e0cd9;
  level.var_514f9d20 = &function_b11487a4;
  level.var_9f8e080d = &function_ed335136;
  level.var_19a15e42 = &function_daabc818;
  callback::callback(#"hash_45f35669076bc317");

  level.killstreak_init_end_time = getmillisecondsraw();
  elapsed_time = level.killstreak_init_end_time - level.killstreak_init_start_time;
  println("<dev string:x38>" + elapsed_time + "<dev string:x58>");
  level thread killstreak_debug_think();

}

private function_395f82d0(killstreaktype) {
  globallogic_score::_setplayermomentum(self, self.momentum - self function_dceb5542(level.killstreaks[killstreaktype].itemindex));
}

private function_427f6a2e(killstreaktype, killstreakid) {
  if(self killstreak_dialog_queued("firewallBeingHacked", killstreaktype, killstreakid)) {
    return;
  }

  self globallogic_audio::play_taacom_dialog("firewallBeingHacked", killstreaktype, killstreakid);
}

private function_6fa91236(killstreaktype, killstreakid) {
  if(self killstreak_dialog_queued("firewallHacked", killstreaktype, killstreakid)) {
    return;
  }

  self globallogic_audio::play_taacom_dialog("firewallHacked", killstreaktype, killstreakid);
}

private function_1cd175ba(killstreaktype, killstreakid) {
  if(self killstreak_dialog_queued("beingHacked", killstreaktype, killstreakid)) {
    return;
  }

  self globallogic_audio::play_taacom_dialog("beingHacked", killstreaktype, killstreakid);
}

private function_520a5752(killstreaktype, killstreakid, hacker) {
  self globallogic_audio::flush_killstreak_dialog_on_player(killstreakid);
  self globallogic_audio::play_taacom_dialog("hacked", killstreaktype);
  excludeself = [];
  excludeself[0] = self;

  if(level.teambased) {
    globallogic_audio::leader_dialog(level.killstreaks[killstreaktype].hackeddialogkey, self.team, excludeself);
    globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].hackedstartdialogkey, self.team, undefined, killstreakid);
    return;
  }

  self globallogic_audio::leader_dialog_on_player(level.killstreaks[killstreaktype].hackeddialogkey);
  hacker globallogic_audio::leader_dialog_on_player(level.killstreaks[killstreaktype].hackedstartdialogkey);
}

private function_7bed52a(killstreaktype, team, killstreakid) {
  if(!isDefined(killstreaktype) || !isDefined(killstreakid)) {
    return;
  }

  self notify("killstreak_start_" + killstreaktype);
  self notify("killstreak_start_inventory_" + killstreaktype);
  excludeself = [];
  excludeself[0] = self;

  if(level.teambased) {
    if(!isDefined(self.currentkillstreakdialog) && isDefined(level.var_cb4eb1d1)) {
      self thread[[level.var_cb4eb1d1]](level.killstreaks[killstreaktype].requestdialogkey, level.killstreaks[killstreaktype].var_3b69c05b);
    }

    if(isDefined(level.killstreakrules[killstreaktype]) && level.killstreakrules[killstreaktype].curteam[team] > 1) {
      globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].enemystartmultipledialogkey, team, undefined, killstreakid);
    } else {
      globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].enemystartdialogkey, team, undefined, killstreakid);
    }

    return;
  }

  if(!isDefined(self.currentkillstreakdialog) && isDefined(level.killstreaks[killstreaktype].requestdialogkey) && isDefined(level.heroplaydialog)) {
    self thread[[level.heroplaydialog]](level.killstreaks[killstreaktype].requestdialogkey);
  }

  if(isDefined(level.killstreakrules[killstreaktype]) && level.killstreakrules[killstreaktype].cur > 1) {
    globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].enemystartmultipledialogkey, team, undefined, killstreakid);
    return;
  }

  globallogic_audio::leader_dialog(level.killstreaks[killstreaktype].enemystartdialogkey, undefined, excludeself, undefined, killstreakid);
}

private function_6a5cc212(killstreaktype, killstreakid) {
  if(!isDefined(self.owner) || !isDefined(self.team) || self.team != self.owner.team) {
    return;
  }

  self.owner globallogic_audio::flush_killstreak_dialog_on_player(killstreakid);
  self.owner globallogic_audio::play_taacom_dialog("destroyed", killstreaktype);
}

private function_9716fce9(dialogkey, killstreaktype, killstreakid) {
  if(!isDefined(self.owner) || !isDefined(self.owner.team) || !isDefined(self.team) || self.team != self.owner.team) {
    return;
  }

  self.owner play_pilot_dialog(dialogkey, killstreaktype, killstreakid, self.pilotindex);
}

private function_f6370f75(dialogkey, killstreaktype, killstreakid, pilotindex) {
  if(!isDefined(killstreaktype) || !isDefined(pilotindex)) {
    return;
  }

  self globallogic_audio::killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex);
}

private function_3d6e0cd9(dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority) {
  self globallogic_audio::play_taacom_dialog(dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority);
}

private function_3cf68327(dialogkey, killstreaktype, killstreakid) {
  assert(isDefined(dialogkey));
  assert(isDefined(killstreaktype));

  if(!isDefined(self.owner) || !isDefined(self.team) || self.team != self.owner.team) {
    return;
  }

  self.owner play_taacom_dialog_response(dialogkey, killstreaktype, killstreakid, self.pilotindex);
}

private function_ed335136(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
  globallogic_audio::leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey);
}

private function_b11487a4(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey) {
  globallogic_audio::leader_dialog(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey);
}

private function_daabc818(event, player, victim, weapon) {
  scoreevents::processscoreevent(event, player, victim, weapon);
}