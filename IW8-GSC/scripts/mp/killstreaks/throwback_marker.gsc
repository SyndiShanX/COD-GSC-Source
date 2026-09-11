/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\throwback_marker.gsc
*******************************************************/

function init() {
  scripts\mp\playeractions::registeractionset("throwback_marker", ["usability", "gesture"]);
}

function throwbackmarker_trythrowbackmarker(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = &throwbackmarker_weapongiven;
  var9 = &throwbackmarker_weaponswitchended;
  var10 = &throwbackmarker_weaponfired;
  var11 = &throwbackmarker_weapontaken;
  var0.throwbackmarker_weapondetonatefunc = var1;
  var0.throwbackmarker_weapongivenfunc = var3;
  var0.throwbackmarker_weaponswitchendedfunc = var4;
  var0.throwbackmarker_weaponfiredfunc = var5;
  var0.throwbackmarker_weapontakenfunc = var7;
  var12 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dothrowbackmarkerdeploy(var0, var2, var8, var9, var10, var6, var11);

  if(!istrue(var12)) {
    return false;
  }

  return true;
}

function throwbackmarker_weapongiven(var0) {
  var1 = 1;

  if(isDefined(var0.throwbackmarker_weapongivenfunc)) {
    var1 = level[[var0.throwbackmarker_weapongivenfunc]](var0);
  }

  return var1;
}

function throwbackmarker_weaponswitchended(var0, var1) {
  if(istrue(var1)) {
    thread throwbackmarker_watchplayerweapon(var0);
  }

  if(isDefined(var0.throwbackmarker_weaponswitchendedfunc)) {
    level thread[[var0.throwbackmarker_weaponswitchendedfunc]](var0, var1);
    return;
  }
}

function throwbackmarker_watchplayerweapon(var0) {
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var1 = scripts\engine\utility::ref_143ad("cancel_deploy", "weapon_switch_started");

  if(!isDefined(var1)) {
    return;
  }

  var0 notify("killstreak_finished_with_deploy_weapon");
}

function throwbackmarker_weaponfired(var0, var1, var2) {
  var3 = "success";
  thread throwbackmarker_watchdetonate(level, var0, var2);
  thread throwbackmarker_watchthrowback(level, var0);

  if(isDefined(var0.throwbackmarker_weaponfiredfunc)) {
    var3 = [[var0.throwbackmarker_weaponfiredfunc]](var0, var1, var2);
  }

  return var3;
}

function throwbackmarker_watchdetonate(var0, var1, var2) {
  level endon("game_ended");
  var1 endon("trigger");
  var1 waittill("explode", var3);

  if(isDefined(var0.throwbackmarker_weapondetonatefunc)) {
    [[var0.throwbackmarker_weapondetonatefunc]](var0, var3, var2);
    return;
  }
}

function throwbackmarker_watchthrowback(var0, var1) {
  var1 endon("fired_off");
  var1 waittill("trigger", var2);
  var2 endon("death_or_disconnect");
  var2 waittill("grenade_fire", var3, var4);
  thread throwbackmarker_watchdetonate(level, var0, var3);
  thread throwbackmarker_watchthrowback(level, var0);
  thread throwbackmarker_takeweapon(var2);
}

function throwbackmarker_takeweapon(var0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var1 = 0;

  while(var1 < 5) {
    if(self hasweapon(var0)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
    } else {
      var1 += 1;
    }

    wait 0.05;
  }
}

function throwbackmarker_weapontaken(var0) {
  if(isDefined(var0.throwbackmarker_weapontakenfunc)) {
    [[var0.throwbackmarker_weapontakenfunc]](var0);
    return;
  }
}