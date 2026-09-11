/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gulag_pacific.gsc
*****************************************************/

function thermite_damage_over_time() {
  scripts\engine\scriptable::scriptable_addusedcallback(&scriptable_used);
  scripts\engine\scriptable::ref_12f5a(&ref_12f64);
  waitframe();
  all_players_skip_last_stand();
  ally_initial_spawners();
  allownvgsatmatchstart();
  activenumber();
  thread ref_144ce();
  thread apc_rus_monitordriverturretfire();
}

function all_players_skip_last_stand() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, allow_nvgs("bdg_button1", "scr_switch_1_targets", "bdg_timer1", "set1", "bdg_light1"));
}

function apc_rus_monitordriverturretfire() {
  level endon("game_ended");

  for(;;) {
    level waittill("gulag_begin_new_fight", var_0);
    var_1 = getdvarint("scr_escape_route_chance", "4");

    if(randomint(100) < var_1) {
      thread activeintelchallengekeys(var_0);
    }
  }
}

function recentghostridekillcount(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = var_0.origin;
  }

  if(!isDefined(var_2)) {
    var_2 = 1200;
  }

  var_3 = getentitylessscriptablearrayinradius("scriptable_scriptable_door_button", "classname", var_1, var_2);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(isDefined(var_6.timer) && var_6.timer == var_0) {
      var_4 = var_6;
    }
  }

  return var_4;
}

function processcashpileovertimemultiplier(var_0, var_1, var_2) {
  var_3 = [];

  if(isDefined(var_0) && isDefined(var_0.ref_13a7b) && isDefined(level.set_relic_martyrdom[var_0.ref_13a7b])) {
    if(!isDefined(var_1)) {
      var_1 = var_0.origin;
    }

    if(!isDefined(var_2)) {
      var_2 = 1200;
    }

    var_4 = level.set_relic_martyrdom[var_0.ref_13a7b];

    foreach(var_6 in var_4) {
      var_7 = getentitylessscriptablearrayinradius(var_6, "script_noteworthy", var_1, var_2);

      foreach(var_9 in var_7) {
        var_3 = var_9;
      }
    }
  }

  return var_3;
}

function activeintelchallengekeys(var_0) {
  var_1 = var_0.origin;
  var_2 = getentitylessscriptablearrayinradius("bdg_escdoor", "script_noteworthy", var_1, 1200);

  if(isDefined(var_2.size) &var_2.size > 0) {
    var_2 = var_2[0];
  } else {
    return;
  }

  ammobox_tryuse(var_2, 1);
  var_3 = getentitylessscriptablearrayinradius("scriptable_status_light", "classname", var_1, 1200);

  foreach(var_5 in var_3) {
    var_5 setscriptablepartstate("light", "active");
  }

  var_7 = getentitylessscriptablearrayinradius("scriptable_gulag_timer", "classname", var_1, 1200);

  if(isDefined(var_7) && isDefined(var_7[0])) {
    var_7 = var_7[0];
    var_8 = recentghostridekillcount(var_7, var_1);

    foreach(var_10 in var_8) {
      var_10.stack_patch_waittill_context = 0;
    }

    if(var_7 getscriptablepartstate("timer") != "on") {
      var_7 setscriptablepartstate("timer", "on");
      wait var_7.timeout;
      var_7 setscriptablepartstate("timer", "off");
      ammobox_canweaponacceptmoreattachments(var_7);

      foreach(var_5 in var_3) {
        var_5 setscriptablepartstate("light", "inactive");
      }

      foreach(var_10 in var_8) {
        var_10.stack_patch_waittill_context = 1;
      }

      return;
    }

    return;
  }
}

function allow_nvgs(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.name = var_0;
  var_6.ref_13a7b = var_1;
  var_6.timer = var_2;
  var_6.flightyaw = var_3;
  var_6.light = var_4;
  var_6.stack_patch_waittill_context = 0;
  var_6.ref_12029 = var_5;
  return var_6;
}

function allow_offhand_throwback(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.name = var_0;
  var_3.ref_12c7e = var_1;
  var_3.timeout = var_2;
  return var_3;
}

function ally_initial_spawners() {
  var_0 = getentitylessscriptablearrayinradius("scriptable_gulag_timer", "classname");

  foreach(var_2 in var_0) {
    var_3 = getentitylessscriptablearrayinradius("scriptable_scriptable_door_button", "classname", var_2.position, 1200);
    var_4 = [];

    foreach(var_6 in var_3) {
      var_7 = var_6.flightyaw;

      if(!isDefined(var_7)) {
        continue;
      }

      if(!isDefined(var_4[var_7])) {
        var_4 = [];
      }

      var_4[var_4[var_7].size] = var_6;
    }

    foreach(var_10 in var_4) {
      for(var_11 = 0; var_11 < var_10.size; var_11++) {
        var_10[var_11].enabled = 0;
        var_10[var_11].stack_patch_waittill_context = 1;
      }

      var_12 = randomintrange(0, var_10.size);
      var_10[var_12].enabled = 1;
    }
  }
}

function activenumber() {
  var_0 = getentitylessscriptablearrayinradius("bdg_timer1", "script_noteworthy");

  foreach(var_2 in var_0) {
    ammobox_canweaponacceptmoreattachments(var_2);
  }
}

function allassassin_initteamlist(var_0) {
  if(isDefined(var_0.ref_1202a) && var_0.ref_1202a == 1) {
    return true;
  }

  return false;
}

function analytics_init(var_0, var_1) {
  if(allassassin_initteamlist(var_0)) {
    return;
  }

  var_0.ref_1202a = 1;
  wait var_1;
  ammobox_tryuse(var_0, 0);
  var_0.ref_1202a = 0;
}

function ammobox_canweaponacceptmoreattachments(var_0) {
  level.set_relic_mythic = [];

  if(!isDefined(var_0.ref_12c7e)) {
    return;
  }

  var_1 = strtok(var_0.ref_12c7e, ",");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = strtok(var_4, "=");

    if(var_5[1] == "true") {
      var_2 = [var_5[0], 1];
      continue;
    }

    var_2 = [var_5[0], 0];
  }

  foreach(var_4 in var_2) {
    var_8 = var_4[0];
    var_9 = var_4[1];

    if(isDefined(var_0)) {
      var_1 = getentitylessscriptablearrayinradius(var_8, "script_noteworthy", var_0.position, 1200);
    } else {
      var_1 = getentitylessscriptablearrayinradius(var_8, "script_noteworthy");
    }

    foreach(var_11 in var_1) {
      var_12 = aigroundturret_dismountcompleted(var_11);

      if(var_12 != var_9) {
        ammobox_tryuse(var_11, var_9);
      }
    }
  }
}

function allownvgsatmatchstart() {
  var_0 = getDvar("scr_switch_1_targets", "bdg_redepdoor");
  var_1 = strtok(var_0, ",");
  level.set_relic_martyrdom["scr_switch_1_targets"] = var_1;
  var_2 = getDvar("scr_switch_2_targets", "door1");
  var_1 = strtok(var_2, ",");
  level.set_relic_martyrdom["scr_switch_2_targets"] = var_1;
  var_3 = getDvar("scr_switch_3_targets", "door2,door3");
  var_1 = strtok(var_3, ",");
  level.set_relic_martyrdom["scr_switch_3_targets"] = var_1;
  var_4 = getDvar("scr_switch_6_targets", "bdg_vent1,bdg_vent2");
  var_1 = strtok(var_4, ",");
  level.set_relic_martyrdom["scr_switch_6_targets"] = var_1;
  var_5 = getDvar("scr_switch_7_targets", "bdg_vent1,bdg_vent2");
  var_1 = strtok(var_5, ",");
  level.set_relic_martyrdom["scr_switch_7_targets"] = var_1;
}

function aigroundturret_dismountcompleted(var_0) {
  var_1 = var_0.set_relic_mythic;

  if(!isDefined(var_1)) {
    if(var_0 scriptableisdoor()) {
      var_1 = !var_0 scriptabledoorisclosed();
    } else {
      var_2 = var_0 getscriptablepartstate("vent_steam");

      if(isDefined(var_2)) {
        var_1 = var_2 == "active";
      }
    }
  }

  return var_1;
}

function ammobox_tryuse(var_0, var_1) {
  var_0.set_relic_mythic = var_1;

  if(var_0 scriptableisdoor()) {
    if(var_1) {
      var_0 constraintoscriptgoalRadius();
      return;
    }

    var_0 vehicle_getinputvalue();
    return;
  }

  var_2 = var_0 getscriptablepartstate("vent_steam");

  if(isDefined(var_2)) {
    if(var_1) {
      var_0 setscriptablepartstate("vent_steam", "active");
      return;
    }

    var_0 setscriptablepartstate("vent_steam", "idle");
    return;
  }
}

function any_player_in_laststand(var_0) {
  var_1 = aigroundturret_dismountcompleted(var_0);

  if(isDefined(var_1)) {
    ammobox_tryuse(var_0, !var_1);
    return;
  }
}

function ref_12f64(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_2.classname == "scriptable_scriptable_door_button") {
    scriptable_used(var_2, "button", "usable", var_1, 0);
    return;
  }
}

function scriptable_used(var_0, var_1, var_2, var_3, var_4) {
  if(var_0.classname == "scriptable_scriptable_door_button") {
    if(var_0.stack_patch_waittill_context == 1) {
      return;
    }

    if(isDefined(var_0.enabled) && var_0.enabled == 0) {
      if(isDefined(var_0.light) && var_0.light getscriptablepartstate("light") != "negative") {
        var_0.light setscriptablepartstate("light", "negative");
      }

      return;
    }

    var_5 = processcashpileovertimemultiplier(var_0);

    foreach(var_7 in var_5) {
      var_2 = aigroundturret_dismountcompleted(var_7);

      if(!allassassin_initteamlist(var_7)) {
        ammobox_tryuse(var_7, !var_2);

        if(isDefined(var_0.ref_12029)) {
          thread analytics_init(var_7, var_0.ref_12029);
        }
      }
    }

    if(var_5.size > 0) {
      var_0 setscriptablepartstate(var_1, "wait");

      if(isDefined(var_0.light) && var_0.light getscriptablepartstate("light") != "positive") {
        var_0.light setscriptablepartstate("light", "positive");
        return;
      }

      return;
    }

    return;
  }
}

function ref_144ce() {
  self endon("death_or_disconnect");

  for(;;) {
    var_0 = scripts\engine\utility::getent_or_struct("bdg_esctrigger", "script_noteworthy");

    if(isDefined(var_0)) {
      var_0 waittill("trigger", var_1);

      if(var_1 == level.player) {
        ref_12ab1(var_1);
      }

      waitframe();
    }

    wait 0.05;
  }
}

function ref_12ab1() {
  if(!isDefined(self.arena)) {
    var_0 = scripts\mp\gametypes\br_gulag::playergetnextarena();
    self.arena = var_0;
  }

  if(isalive(self) && scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    thread scripts\mp\gametypes\br_gulag::ref_12642(self, "debug");
    return;
  }
}