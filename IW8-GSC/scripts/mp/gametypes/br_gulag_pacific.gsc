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
  var0 = [];
  GscBinSkip0(0x2e, var0.size, allow_nvgs("bdg_button1", "scr_switch_1_targets", "bdg_timer1", "set1", "bdg_light1"));
}

function apc_rus_monitordriverturretfire() {
  level endon("game_ended");

  for(;;) {
    level waittill("gulag_begin_new_fight", var0);
    var1 = getdvarint("scr_escape_route_chance", "4");

    if(randomint(100) < var1) {
      thread activeintelchallengekeys(var0);
    }
  }
}

function recentghostridekillcount(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = var0.origin;
  }

  if(!isDefined(var2)) {
    var2 = 1200;
  }

  var3 = getentitylessscriptablearrayinradius("scriptable_scriptable_door_button", "classname", var1, var2);
  var4 = [];

  foreach(var6 in var3) {
    if(isDefined(var6.timer) && var6.timer == var0) {
      var4 = var6;
    }
  }

  return var4;
}

function processcashpileovertimemultiplier(var0, var1, var2) {
  var3 = [];

  if(isDefined(var0) && isDefined(var0.ref_13a7b) && isDefined(level.set_relic_martyrdom[var0.ref_13a7b])) {
    if(!isDefined(var1)) {
      var1 = var0.origin;
    }

    if(!isDefined(var2)) {
      var2 = 1200;
    }

    var4 = level.set_relic_martyrdom[var0.ref_13a7b];

    foreach(var6 in var4) {
      var7 = getentitylessscriptablearrayinradius(var6, "script_noteworthy", var1, var2);

      foreach(var9 in var7) {
        var3 = var9;
      }
    }
  }

  return var3;
}

function activeintelchallengekeys(var0) {
  var1 = var0.origin;
  var2 = getentitylessscriptablearrayinradius("bdg_escdoor", "script_noteworthy", var1, 1200);

  if(isDefined(var2.size) &var2.size > 0) {
    var2 = var2[0];
  } else {
    return;
  }

  ammobox_tryuse(var2, 1);
  var3 = getentitylessscriptablearrayinradius("scriptable_status_light", "classname", var1, 1200);

  foreach(var5 in var3) {
    var5 setscriptablepartstate("light", "active");
  }

  var7 = getentitylessscriptablearrayinradius("scriptable_gulag_timer", "classname", var1, 1200);

  if(isDefined(var7) && isDefined(var7[0])) {
    var7 = var7[0];
    var8 = recentghostridekillcount(var7, var1);

    foreach(var10 in var8) {
      var10.stack_patch_waittill_context = 0;
    }

    if(var7 getscriptablepartstate("timer") != "on") {
      var7 setscriptablepartstate("timer", "on");
      wait var7.timeout;
      var7 setscriptablepartstate("timer", "off");
      ammobox_canweaponacceptmoreattachments(var7);

      foreach(var5 in var3) {
        var5 setscriptablepartstate("light", "inactive");
      }

      foreach(var10 in var8) {
        var10.stack_patch_waittill_context = 1;
      }

      return;
    }

    return;
  }
}

function allow_nvgs(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();
  var6.name = var0;
  var6.ref_13a7b = var1;
  var6.timer = var2;
  var6.flightyaw = var3;
  var6.light = var4;
  var6.stack_patch_waittill_context = 0;
  var6.ref_12029 = var5;
  return var6;
}

function allow_offhand_throwback(var0, var1, var2) {
  var3 = spawnStruct();
  var3.name = var0;
  var3.ref_12c7e = var1;
  var3.timeout = var2;
  return var3;
}

function ally_initial_spawners() {
  var0 = getentitylessscriptablearrayinradius("scriptable_gulag_timer", "classname");

  foreach(var2 in var0) {
    var3 = getentitylessscriptablearrayinradius("scriptable_scriptable_door_button", "classname", var2.position, 1200);
    var4 = [];

    foreach(var6 in var3) {
      var7 = var6.flightyaw;

      if(!isDefined(var7)) {
        continue;
      }

      if(!isDefined(var4[var7])) {
        var4 = [];
      }

      var4[var4[var7].size] = var6;
    }

    foreach(var10 in var4) {
      for(var11 = 0; var11 < var10.size; var11++) {
        var10[var11].enabled = 0;
        var10[var11].stack_patch_waittill_context = 1;
      }

      var12 = randomintrange(0, var10.size);
      var10[var12].enabled = 1;
    }
  }
}

function activenumber() {
  var0 = getentitylessscriptablearrayinradius("bdg_timer1", "script_noteworthy");

  foreach(var2 in var0) {
    ammobox_canweaponacceptmoreattachments(var2);
  }
}

function allassassin_initteamlist(var0) {
  if(isDefined(var0.ref_1202a) && var0.ref_1202a == 1) {
    return true;
  }

  return false;
}

function analytics_init(var0, var1) {
  if(allassassin_initteamlist(var0)) {
    return;
  }

  var0.ref_1202a = 1;
  wait var1;
  ammobox_tryuse(var0, 0);
  var0.ref_1202a = 0;
}

function ammobox_canweaponacceptmoreattachments(var0) {
  level.set_relic_mythic = [];

  if(!isDefined(var0.ref_12c7e)) {
    return;
  }

  var1 = strtok(var0.ref_12c7e, ",");
  var2 = [];

  foreach(var4 in var1) {
    var5 = strtok(var4, "=");

    if(var5[1] == "true") {
      var2 = [var5[0], 1];
      continue;
    }

    var2 = [var5[0], 0];
  }

  foreach(var4 in var2) {
    var8 = var4[0];
    var9 = var4[1];

    if(isDefined(var0)) {
      var1 = getentitylessscriptablearrayinradius(var8, "script_noteworthy", var0.position, 1200);
    } else {
      var1 = getentitylessscriptablearrayinradius(var8, "script_noteworthy");
    }

    foreach(var11 in var1) {
      var12 = aigroundturret_dismountcompleted(var11);

      if(var12 != var9) {
        ammobox_tryuse(var11, var9);
      }
    }
  }
}

function allownvgsatmatchstart() {
  var0 = getDvar("scr_switch_1_targets", "bdg_redepdoor");
  var1 = strtok(var0, ",");
  level.set_relic_martyrdom["scr_switch_1_targets"] = var1;
  var2 = getDvar("scr_switch_2_targets", "door1");
  var1 = strtok(var2, ",");
  level.set_relic_martyrdom["scr_switch_2_targets"] = var1;
  var3 = getDvar("scr_switch_3_targets", "door2,door3");
  var1 = strtok(var3, ",");
  level.set_relic_martyrdom["scr_switch_3_targets"] = var1;
  var4 = getDvar("scr_switch_6_targets", "bdg_vent1,bdg_vent2");
  var1 = strtok(var4, ",");
  level.set_relic_martyrdom["scr_switch_6_targets"] = var1;
  var5 = getDvar("scr_switch_7_targets", "bdg_vent1,bdg_vent2");
  var1 = strtok(var5, ",");
  level.set_relic_martyrdom["scr_switch_7_targets"] = var1;
}

function aigroundturret_dismountcompleted(var0) {
  var1 = var0.set_relic_mythic;

  if(!isDefined(var1)) {
    if(var0 scriptableisdoor()) {
      var1 = !var0 scriptabledoorisclosed();
    } else {
      var2 = var0 getscriptablepartstate("vent_steam");

      if(isDefined(var2)) {
        var1 = var2 == "active";
      }
    }
  }

  return var1;
}

function ammobox_tryuse(var0, var1) {
  var0.set_relic_mythic = var1;

  if(var0 scriptableisdoor()) {
    if(var1) {
      var0 constraintoscriptgoalRadius();
      return;
    }

    var0 vehicle_getinputvalue();
    return;
  }

  var2 = var0 getscriptablepartstate("vent_steam");

  if(isDefined(var2)) {
    if(var1) {
      var0 setscriptablepartstate("vent_steam", "active");
      return;
    }

    var0 setscriptablepartstate("vent_steam", "idle");
    return;
  }
}

function any_player_in_laststand(var0) {
  var1 = aigroundturret_dismountcompleted(var0);

  if(isDefined(var1)) {
    ammobox_tryuse(var0, !var1);
    return;
  }
}

function ref_12f64(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(var2.classname == "scriptable_scriptable_door_button") {
    scriptable_used(var2, "button", "usable", var1, 0);
    return;
  }
}

function scriptable_used(var0, var1, var2, var3, var4) {
  if(var0.classname == "scriptable_scriptable_door_button") {
    if(var0.stack_patch_waittill_context == 1) {
      return;
    }

    if(isDefined(var0.enabled) && var0.enabled == 0) {
      if(isDefined(var0.light) && var0.light getscriptablepartstate("light") != "negative") {
        var0.light setscriptablepartstate("light", "negative");
      }

      return;
    }

    var5 = processcashpileovertimemultiplier(var0);

    foreach(var7 in var5) {
      var2 = aigroundturret_dismountcompleted(var7);

      if(!allassassin_initteamlist(var7)) {
        ammobox_tryuse(var7, !var2);

        if(isDefined(var0.ref_12029)) {
          thread analytics_init(var7, var0.ref_12029);
        }
      }
    }

    if(var5.size > 0) {
      var0 setscriptablepartstate(var1, "wait");

      if(isDefined(var0.light) && var0.light getscriptablepartstate("light") != "positive") {
        var0.light setscriptablepartstate("light", "positive");
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
    var0 = scripts\engine\utility::getent_or_struct("bdg_esctrigger", "script_noteworthy");

    if(isDefined(var0)) {
      var0 waittill("trigger", var1);

      if(var1 == level.player) {
        ref_12ab1(var1);
      }

      waitframe();
    }

    wait 0.05;
  }
}

function ref_12ab1() {
  if(!isDefined(self.arena)) {
    var0 = scripts\mp\gametypes\br_gulag::playergetnextarena();
    self.arena = var0;
  }

  if(isalive(self) && scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    thread scripts\mp\gametypes\br_gulag::ref_12642(self, "debug");
    return;
  }
}