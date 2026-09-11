/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\emp_drone.gsc
***************************************************/

function init() {
  level._effects["vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx");
  level._effects["vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp_drone", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("emp_drone", "init")]]();
    return;
  }
}

function empdrone_beginsuper() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return false;
  }

  thread empdrone_superusethink();
  return true;
}

function empdrone_superusethink() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp_drone", self);
  var_1 = empdrone_tryuse(var_0);

  if(!var_1) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }

  wait 0.05;

  if(var_1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_emp_drone");
      return;
    }

    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
    return;
  }
}

function empdrone_tryuse(var_0) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, &empdrone_weapongiven);

  if(!istrue(var_1)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  thread empdrone_rundrone(var_0);
  return true;
}

function empdrone_equipment_wrapper(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var_1);
  }

  var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp_drone", self);
  var_4 = empdrone_tryuse(var_3);

  if(!var_4) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_empdrone", var_1);
      return;
    }

    return;
  }
}

function empdrone_weapongiven(var_0) {
  return true;
}

function empdrone_rundrone(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self disablephysicaldepthoffieldscripting();
  scripts\common\utility::allow_fire(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_weapon_switch(0);
  scripts\common\utility::allow_usability(0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "allowGesture")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "allowGesture")]](0);
  }

  var_1 = empdrone_createdrone(var_0);
  var_1.iscontrolled = 1;
  var_1.usedcount = 0;
  var_1.superid = level.superglobals.staticsuperdata["super_emp_drone"].id;
  self controlslinkTo(var_1);
  self cameralinkTo(var_1, "tag_origin");
  self setplayerangles(var_1.angles);
  self painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  self setclientomnvar("ui_emp_drone_overlay", 1);
}

function empdrone_createdrone(var_0) {
  var_1 = empdrone_findstartposition();
  var_2 = vectortoangles(var_1.targetpos - var_1.startpos);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var_3 = spawnStruct();
  var_3.origin = var_1.startpos;
  var_3.angles = var_2;
  var_3.modelname = "veh8_ind_air_bombing_drone";
  var_3.vehicletype = "rcplane_physics_mp";
  var_3.targetname = "rcplane";
  var_3.cannotbesuspended = 1;
  var_4 = spawnStruct();
  var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_3, var_4);

  if(!isDefined(var_5)) {
    return;
  }

  var_5 setotherent(self);
  var_5 setentityowner(self);
  var_5.owner = self;
  var_5.ownerid = self getentitynumber();
  var_5.team = self.team;
  var_5.streakinfo = var_0;
  var_5 setCanDamage(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var_0.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var_0.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var_0.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var_0.streakname, &empdrone_handledeathdamage);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var_5, var_5.vehiclename);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_0.streakname, "Killstreak_Air", self, 0, 1, 25);
  }

  self notifyonplayercommand("emp_drone_detonate", "+attack");
  var_5 playLoopSound("iw8_rc_plane_engine");
  thread empdrone_timeoutthink();
  thread empdrone_collidethink();
  thread empdrone_watchearlyexit();
  thread empdrone_watchdetonate();
  var_5 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&empdrone_empapplied);
  return var_5;
}

function empdrone_findstartposition() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_1 = (0, 0, 600);

  if(isDefined(var_0)) {
    var_2 = var_0.origin[2] + -100;
    var_1 = (0, 0, var_2);
  }

  var_3 = anglesToForward(self.angles);
  var_4 = var_1 + self.origin;
  var_5 = var_4 - var_3 * 4000;
  var_6 = var_4;
  var_7 = spawnStruct();
  var_7.startpos = var_5;
  var_7.targetpos = var_6;
  return var_7;
}

function empdrone_timeoutthink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  var_0 = 20;

  while(var_0 > 0) {
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(var_0 * 1000));
    var_0 -= 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  thread empdrone_destroy();
}

function empdrone_collidethink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self vehphys_enablecollisioncallback(1);
  self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  thread empdrone_explode();
}

function empdrone_watchdetonate() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("emp_drone_exited");
  self.owner waittill("emp_drone_detonate");
  thread empdrone_explode();
}

function empdrone_watchearlyexit() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("emp_drone_exited");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("death");
  }

  self waittill("killstreakExit");
  self setotherent(undefined);
  self setentityowner(undefined);
  thread empdrone_exit();
}

function empdrone_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  empdrone_givepointsfordeath(var_1);
  empdrone_destroy();
}

function empdrone_explode() {
  self playSound("iw8_rc_plane_engine_exp");
  var_0 = anglesToForward(self.angles);
  playFX(level._effects["vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"], self.origin, var_0);
  empdrone_explodeemp();
  empdrone_delete();
}

function empdrone_destroy() {
  self playSound("recondrone_damaged");
  var_0 = anglesToForward(self.angles);
  playFX(level._effects["vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"], self.origin, var_0);
  empdrone_delete();
}

function empdrone_exit() {
  empdrone_returnplayer(self.owner, self);
}

function empdrone_delete() {
  empdrone_returnplayer(self.owner, self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "fieldUpgradeExpired")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self.superid, self.usedcount, 0);
  }

  self stoploopsound("iw8_rc_plane_engine");
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function empdrone_returnplayer(var_0) {
  if(!istrue(var_0.iscontrolled)) {
    return;
  }

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_0.streakinfo);
  }

  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  self controlsunlink();
  self cameraunlink(var_0);
  empdrone_clearomnvars();
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_melee(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_usability(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "allowGesture")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "allowGesture")]](1);
  }

  var_0 stoploopsound("iw8_rc_plane_engine");
  self notifyonplayercommandremove("emp_drone_detonate", "+frag");
  var_0.iscontrolled = undefined;
  var_0.streakinfo notify("killstreak_finished_with_deploy_weapon");
  var_0 notify("emp_drone_exited");
}

function empdrone_clearomnvars() {
  self setclientomnvar("ui_emp_drone_overlay", 0);
}

function empdrone_empapplied(var_0) {
  var_1 = var_0.attacker;
  empdrone_givepointsfordeath(var_1);
  empdrone_destroy();
}

function empdrone_givepointsfordeath(var_0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("destroyed_equipment");
      return;
    }

    return;
  }
}

function empdrone_explodeemp() {
  var_0 = getcompleteweaponname("emp_drone_non_player_mp");
  var_1 = getcompleteweaponname("emp_drone_non_player_direct_mp");
  var_2 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var_4 in var_2) {
    if(var_4 == self) {
      continue;
    }

    var_5 = var_4.owner;

    if(isDefined(var_5)) {
      if(var_5 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_5)) {
        continue;
      }
    }

    var_6 = distancesquared(self.origin, var_4.origin);

    if(var_6 > 589824) {
      continue;
    }

    var_7 = scripts\engine\utility::ter_op(var_6 > 4096, var_0, var_1);
    var_4 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var_7);
    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var_4, 1, var_7, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(var_8);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat")) {
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("empDroneHits", 1);
    }

    self.usedcount++;
  }

  var_10 = getcompleteweaponname("emp_drone_player_mp");
  radiusdamage(self.origin, 64, 60, 1, self.owner, "MOD_EXPLOSIVE", var_10);
  var_11 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
    var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](self.origin, 768);
  }

  foreach(var_13 in var_11) {
    if(!var_13 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }

    if(var_13 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_13)) {
      continue;
    }

    var_13 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var_10);
    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var_13, 1, var_10, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(var_8);
  }
}

function empdrone_applyemp(var_0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  var_1 = 8;

  if(isPlayer(var_0.victim)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(var_0.victim != self.owner && var_0.victim[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_emp_resist")) {
        var_1 = 2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hittacresist");
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "trackDebuffAssist")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "trackDebuffAssist")]](var_0.attacker, var_0.victim, var_0.objweapon.basename);
    }
  }

  empdrone_empendearly(var_0, var_1);

  if(isDefined(var_0.victim)) {
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();

    if(isDefined(var_0.attacker) && isPlayer(var_0.victim)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "untrackDebuffAssist")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "untrackDebuffAssist")]](var_0.attacker, var_0.victim, var_0.objweapon.basename);
        return;
      }

      return;
    }

    return;
  }
}

function empdrone_empendearly(var_0, var_1) {
  var_0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var_1);

  if(var_2 != "emp_cleared") {
    var_0.empremoved = 1;
    return;
  }
}