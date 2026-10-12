/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\throwback_marker.gsc
*******************************************************/



#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#namespace throwback_marker;

function init() {
  val::group_register("throwback_marker", ["usability", "gesture"]);
}

function throwbackmarker_trythrowbackmarker(streakinfo, weapondetonatefunc, weaponoverride, weapongivenfunc, weaponswitchendedfunc, weaponfiredfunc, weaponcleanupcallback, weapontakenfunc) {
  weapongivencallback = &throwbackmarker_weapongiven;
  weaponswitchendedcallback = &throwbackmarker_weaponswitchended;
  weaponfiredcallback = &throwbackmarker_weaponfired;
  weapontakencallback = &throwbackmarker_weapontaken;
  streakinfo.throwbackmarker_weapondetonatefunc = weapondetonatefunc;
  streakinfo.throwbackmarker_weapongivenfunc = weapongivenfunc;
  streakinfo.throwbackmarker_weaponswitchendedfunc = weaponswitchendedfunc;
  streakinfo.throwbackmarker_weaponfiredfunc = weaponfiredfunc;
  streakinfo.throwbackmarker_weapontakenfunc = weapontakenfunc;
  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dothrowbackmarkerdeploy(streakinfo, weaponoverride, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback);

  if(!istrue(deployresult)) {
    return false;
  }

  return true;
}

function throwbackmarker_weapongiven(streakinfo) {
  var_e9053b0829a68d67 = 1;

  if(isDefined(streakinfo.throwbackmarker_weapongivenfunc)) {
    var_e9053b0829a68d67 = level[[streakinfo.throwbackmarker_weapongivenfunc]](streakinfo);
  }

  return var_e9053b0829a68d67;
}

function throwbackmarker_weaponswitchended(streakinfo, switchresult) {
  if(istrue(switchresult)) {
    thread throwbackmarker_watchplayerweapon(streakinfo);
  }

  if(isDefined(streakinfo.throwbackmarker_weaponswitchendedfunc)) {
    level thread[[streakinfo.throwbackmarker_weaponswitchendedfunc]](streakinfo, switchresult);
  }
}

function throwbackmarker_watchplayerweapon(streakinfo) {
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  result = waittill_any_return_2("cancel_deploy", "weapon_switch_started");

  if(!isDefined(result)) {
    return;
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");
}

function throwbackmarker_weaponfired(streakinfo, firedweaponobj, firedprojectile) {
  firedresult = "success";
  level thread throwbackmarker_watchdetonate(streakinfo, firedprojectile, self);
  level thread throwbackmarker_watchthrowback(streakinfo, firedprojectile);

  if(isDefined(streakinfo.throwbackmarker_weaponfiredfunc)) {
    firedresult = [[streakinfo.throwbackmarker_weaponfiredfunc]](streakinfo, firedweaponobj, firedprojectile);
  }

  return firedresult;
}

function throwbackmarker_watchdetonate(streakinfo, projectile, owner) {
  level endon("game_ended");
  projectile endon("trigger");
  projectile waittill("explode", explodepos);

  if(isDefined(streakinfo.throwbackmarker_weapondetonatefunc)) {
    [[streakinfo.throwbackmarker_weapondetonatefunc]](streakinfo, explodepos, owner);
  }
}

function throwbackmarker_watchthrowback(streakinfo, projectile) {
  projectile endon("fired_off");
  projectile waittill("trigger", player);
  player endon("death_or_disconnect");
  player waittill("grenade_fire", grenade, weapon);
  level thread throwbackmarker_watchdetonate(streakinfo, grenade, player);
  level thread throwbackmarker_watchthrowback(streakinfo, grenade);
  player thread throwbackmarker_takeweapon(weapon);
}

function throwbackmarker_takeweapon(weapon) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  counter = 0;

  while(counter < 5) {
    if(self hasweapon(weapon)) {
      _takeweapon(weapon);
    } else {
      counter += 1;
    }

    wait 0.05;
  }
}

function throwbackmarker_weapontaken(streakinfo) {
  if(isDefined(streakinfo.throwbackmarker_weapontakenfunc)) {
    [[streakinfo.throwbackmarker_weapontakenfunc]](streakinfo);
  }
}