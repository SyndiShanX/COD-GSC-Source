/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\killstreak_dialog.gsc
***********************************************/

#using scripts\core_common\struct;
#namespace killstreak_dialog;

function function_196f2c38() {
  level.play_killstreak_firewall_being_hacked_dialog = undefined;
  level.play_killstreak_firewall_hacked_dialog = undefined;
  level.play_killstreak_being_hacked_dialog = undefined;
  level.play_killstreak_hacked_dialog = undefined;
  level.play_pilot_dialog_on_owner = undefined;
  level.play_pilot_dialog = undefined;
  level.play_taacom_dialog_response_on_owner = undefined;
  level.play_taacom_dialog = undefined;
  level.var_daaa6db3 = undefined;
  level.var_514f9d20 = undefined;
  level.var_992ad5b3 = undefined;
  level.var_6d7da491 = undefined;
  level.var_9f8e080d = undefined;
}

function killstreak_dialog_queued(dialogkey, killstreaktype, killstreakid) {
  if(!isDefined(dialogkey) || !isDefined(killstreaktype)) {
    return;
  }

  if(isDefined(self.currentkillstreakdialog)) {
    if(dialogkey === self.currentkillstreakdialog.dialogkey && killstreaktype === self.currentkillstreakdialog.killstreaktype && killstreakid === self.currentkillstreakdialog.killstreakid) {
      return 1;
    }
  }

  for(i = 0; i < self.killstreakdialogqueue.size; i++) {
    if(dialogkey === self.killstreakdialogqueue[i].dialogkey && killstreaktype === self.killstreakdialogqueue[i].killstreaktype && killstreaktype === self.killstreakdialogqueue[i].killstreaktype) {
      return 1;
    }
  }

  return 0;
}

function play_killstreak_ready_dialog(killstreaktype, taacomwaittime) {
  self notify("killstreak_ready_" + killstreaktype);
  self endon(#"death", "killstreak_start_" + killstreaktype, "killstreak_ready_" + killstreaktype);
  level endon(#"game_ended");

  if(isDefined(level.gameended) && level.gameended) {
    return;
  }

  if(killstreak_dialog_queued("ready", killstreaktype)) {
    return;
  }

  if(isDefined(taacomwaittime)) {
    wait taacomwaittime;
  }

  self play_taacom_dialog("ready", killstreaktype);
}

function play_taacom_dialog_response(dialogkey, killstreaktype, killstreakid, pilotindex) {
  assert(isDefined(dialogkey));
  assert(isDefined(killstreaktype));

  if(!isDefined(pilotindex)) {
    return;
  }

  self play_taacom_dialog(dialogkey + pilotindex, killstreaktype, killstreakid);
}

function play_taacom_dialog(dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority) {
  if(isDefined(level.play_taacom_dialog)) {
    self[[level.play_taacom_dialog]](dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority);
  }
}

function function_daaa6db3(weapon, var_df17fa82, var_53c10ed8) {
  if(isDefined(level.var_daaa6db3)) {
    self[[level.var_daaa6db3]](weapon, var_df17fa82, var_53c10ed8);
  }
}

function play_taacom_dialog_response_on_owner(dialogkey, killstreaktype, killstreakid) {
  if(isDefined(level.play_taacom_dialog_response_on_owner)) {
    self[[level.play_taacom_dialog_response_on_owner]](dialogkey, killstreaktype, killstreakid);
  }
}

function leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
  if(isDefined(level.var_9f8e080d)) {
    [[level.var_9f8e080d]](dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey);
  }
}

function leader_dialog(dialogkey, team, objectivekey, killstreakid, dialogbufferkey) {
  if(isDefined(level.var_514f9d20)) {
    [[level.var_514f9d20]](dialogkey, team, objectivekey, killstreakid, dialogbufferkey);
  }
}

function function_b4319f8e(dialogkey, team, exclusion, objectivekey, killstreakid, dialogbufferkey) {
  if(isDefined(level.var_992ad5b3)) {
    [[level.var_992ad5b3]](dialogkey, team, exclusion, objectivekey, killstreakid, dialogbufferkey);
  }
}

function function_248fc9f7(dialogkey, team, exclusions, objectivekey, killstreakid, dialogbufferkey) {
  if(isDefined(level.var_6d7da491)) {
    [[level.var_6d7da491]](dialogkey, team, exclusions, objectivekey, killstreakid, dialogbufferkey);
  }
}

function play_killstreak_firewall_being_hacked_dialog(killstreaktype, killstreakid) {
  if(isDefined(level.play_killstreak_firewall_being_hacked_dialog)) {
    self[[level.play_killstreak_firewall_being_hacked_dialog]](killstreaktype, killstreakid);
  }
}

function play_killstreak_firewall_hacked_dialog(killstreaktype, killstreakid) {
  if(isDefined(level.play_killstreak_firewall_hacked_dialog)) {
    self[[level.play_killstreak_firewall_hacked_dialog]](killstreaktype, killstreakid);
  }
}

function play_killstreak_being_hacked_dialog(killstreaktype, killstreakid) {
  if(isDefined(level.play_killstreak_being_hacked_dialog)) {
    self[[level.play_killstreak_being_hacked_dialog]](killstreaktype, killstreakid);
  }
}

function play_killstreak_hacked_dialog(killstreaktype, killstreakid, hacker) {
  if(isDefined(level.play_killstreak_hacked_dialog)) {
    self[[level.play_killstreak_hacked_dialog]](killstreaktype, killstreakid, hacker);
  }
}

function play_killstreak_start_dialog(hardpointtype, team, killstreak_id) {
  if(isDefined(level.play_killstreak_start_dialog)) {
    self[[level.play_killstreak_start_dialog]](hardpointtype, team, killstreak_id);
  }
}

function play_pilot_dialog(dialogkey, killstreaktype, killstreakid, pilotindex) {
  if(isDefined(level.play_pilot_dialog)) {
    self[[level.play_pilot_dialog]](dialogkey, killstreaktype, killstreakid, pilotindex);
  }
}

function play_pilot_dialog_on_owner(dialogkey, killstreaktype, killstreakid) {
  if(isDefined(level.play_pilot_dialog_on_owner)) {
    self[[level.play_pilot_dialog_on_owner]](dialogkey, killstreaktype, killstreakid);
  }
}

function play_destroyed_dialog_on_owner(killstreaktype, killstreakid) {
  if(isDefined(level.play_destroyed_dialog_on_owner)) {
    self[[level.play_destroyed_dialog_on_owner]](killstreaktype, killstreakid);
  }
}

function function_1110a5de(killstreaktype) {
  assert(isDefined(killstreaktype), "<dev string:x38>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x74>");
  pilotdialogarraykey = level.killstreaks[killstreaktype].script_bundle.var_b7bd2ff9;

  if(isDefined(pilotdialogarraykey)) {
    taacombundles = getscriptbundles("mpdialog_taacom");

    foreach(bundle in taacombundles) {
      if(!isDefined(bundle.pilotbundles)) {
        bundle.pilotbundles = [];
      }

      bundle.pilotbundles[killstreaktype] = [];
      i = 0;
      field = pilotdialogarraykey + i;

      for(fieldvalue = bundle.(field); isDefined(fieldvalue); fieldvalue = bundle.(field)) {
        bundle.pilotbundles[killstreaktype][i] = fieldvalue;
        i++;
        field = pilotdialogarraykey + i;
      }
    }

    level.tacombundles = taacombundles;
  }
}

function get_killstreak_inform_dialog(killstreaktype) {
  if(isDefined(level.killstreaks[killstreaktype].script_bundle.var_5fbfc70d)) {
    return level.killstreaks[killstreaktype].script_bundle.var_5fbfc70d;
  }

  return "";
}

function get_mpdialog_tacom_bundle(name) {
  if(!isDefined(level.tacombundles)) {
    return undefined;
  }

  return level.tacombundles[name];
}

function function_d2219b7d(type) {
  self play_pilot_dialog_on_owner("timeout", type);
  self play_taacom_dialog_response_on_owner("timeoutConfirmed", type);
}

function get_random_pilot_index(killstreaktype) {
  if(!isDefined(killstreaktype)) {
    return undefined;
  }

  if(!isDefined(self.pers[level.var_bc01f047])) {
    return undefined;
  }

  taacombundle = get_mpdialog_tacom_bundle(self.pers[level.var_bc01f047]);

  if(!isDefined(taacombundle) || !isDefined(taacombundle.pilotbundles)) {
    return undefined;
  }

  if(!isDefined(taacombundle.pilotbundles[killstreaktype])) {
    return undefined;
  }

  numpilots = taacombundle.pilotbundles[killstreaktype].size;

  if(numpilots <= 0) {
    return undefined;
  }

  return randomint(numpilots);
}