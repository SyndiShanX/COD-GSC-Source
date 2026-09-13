/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\throwback_marker.gsc
*******************************************************/

init() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("throwback_marker", ["usability", "gesture"]);
}

throwbackmarker_trythrowbackmarker(streakinfo, _id_77CC3B72E7F0D103, weaponoverride, _id_58C629EDE719BBE8, _id_13F3D557B033435D, _id_A85466D943BD012D, _id_91F739C2C51347D4, _id_86356A6D4923A876) {
  _id_BDFFC63C4171C131 = ::throwbackmarker_weapongiven;
  _id_8FD4D93DD619DA88 = ::throwbackmarker_weaponswitchended;
  _id_97EE9768F7229838 = ::throwbackmarker_weaponfired;
  _id_0D55D8445518099B = ::throwbackmarker_weapontaken;
  streakinfo.throwbackmarker_weapondetonatefunc = _id_77CC3B72E7F0D103;
  streakinfo.throwbackmarker_weapongivenfunc = _id_58C629EDE719BBE8;
  streakinfo.throwbackmarker_weaponswitchendedfunc = _id_13F3D557B033435D;
  streakinfo.throwbackmarker_weaponfiredfunc = _id_A85466D943BD012D;
  streakinfo.throwbackmarker_weapontakenfunc = _id_86356A6D4923A876;
  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dothrowbackmarkerdeploy(streakinfo, weaponoverride, _id_BDFFC63C4171C131, _id_8FD4D93DD619DA88, _id_97EE9768F7229838, _id_91F739C2C51347D4, _id_0D55D8445518099B);

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  return 1;
}

throwbackmarker_weapongiven(streakinfo) {
  _id_E9053B0829A68D67 = 1;

  if(isDefined(streakinfo.throwbackmarker_weapongivenfunc))
    _id_E9053B0829A68D67 = level[[streakinfo.throwbackmarker_weapongivenfunc]](streakinfo);

  return _id_E9053B0829A68D67;
}

throwbackmarker_weaponswitchended(streakinfo, _id_41BF9BF4918115AC) {
  if(istrue(_id_41BF9BF4918115AC))
    thread throwbackmarker_watchplayerweapon(streakinfo);

  if(isDefined(streakinfo.throwbackmarker_weaponswitchendedfunc))
    level thread[[streakinfo.throwbackmarker_weaponswitchendedfunc]](streakinfo, _id_41BF9BF4918115AC);
}

throwbackmarker_watchplayerweapon(streakinfo) {
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  result = scripts\engine\utility::waittill_any_return_2("cancel_deploy", "weapon_switch_started");

  if(!isDefined(result)) {
    return;
  }
  streakinfo notify("killstreak_finished_with_deploy_weapon");
}

throwbackmarker_weaponfired(streakinfo, _id_A9DD4E8C5E5C7178, _id_B663FBBCBB2F5780) {
  _id_9CF1D5B97D062B8A = "success";
  level thread throwbackmarker_watchdetonate(streakinfo, _id_B663FBBCBB2F5780, self);
  level thread throwbackmarker_watchthrowback(streakinfo, _id_B663FBBCBB2F5780);

  if(isDefined(streakinfo.throwbackmarker_weaponfiredfunc))
    _id_9CF1D5B97D062B8A = [[streakinfo.throwbackmarker_weaponfiredfunc]](streakinfo, _id_A9DD4E8C5E5C7178, _id_B663FBBCBB2F5780);

  return _id_9CF1D5B97D062B8A;
}

throwbackmarker_watchdetonate(streakinfo, projectile, owner) {
  level endon("game_ended");
  projectile endon("trigger");
  projectile waittill("explode", _id_45292519459D6838);

  if(isDefined(streakinfo.throwbackmarker_weapondetonatefunc))
    [[streakinfo.throwbackmarker_weapondetonatefunc]](streakinfo, _id_45292519459D6838, owner);
}

throwbackmarker_watchthrowback(streakinfo, projectile) {
  projectile endon("fired_off");
  projectile waittill("trigger", player);
  player endon("death_or_disconnect");
  player waittill("grenade_fire", grenade, weapon);
  level thread throwbackmarker_watchdetonate(streakinfo, grenade, player);
  level thread throwbackmarker_watchthrowback(streakinfo, grenade);
  player thread throwbackmarker_takeweapon(weapon);
}

throwbackmarker_takeweapon(weapon) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  counter = 0;

  while(counter < 5) {
    if(self hasweapon(weapon))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
    else
      counter = counter + 1;

    wait 0.05;
  }
}

throwbackmarker_weapontaken(streakinfo) {
  if(isDefined(streakinfo.throwbackmarker_weapontakenfunc))
    [[streakinfo.throwbackmarker_weapontakenfunc]](streakinfo);
}