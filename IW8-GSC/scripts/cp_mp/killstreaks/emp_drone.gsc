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
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp_drone", self);
  var1 = empdrone_tryuse(var0);

  if(!var1) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }

  wait 0.05;

  if(var1) {
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

function empdrone_tryuse(var0) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return false;
    }
  }

  var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var0, &empdrone_weapongiven);

  if(!istrue(var1)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      return false;
    }
  }

  thread empdrone_rundrone(var0);
  return true;
}

function empdrone_equipment_wrapper(var0, var1, var2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var1);
  }

  var3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp_drone", self);
  var4 = empdrone_tryuse(var3);

  if(!var4) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_empdrone", var1);
      return;
    }

    return;
  }
}

function empdrone_weapongiven(var0) {
  return true;
}

function empdrone_rundrone(var0) {
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

  var1 = empdrone_createdrone(var0);
  var1.iscontrolled = 1;
  var1.usedcount = 0;
  var1.superid = level.superglobals.staticsuperdata["super_emp_drone"].id;
  self controlslinkTo(var1);
  self cameralinkTo(var1, "tag_origin");
  self setplayerangles(var1.angles);
  self painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  self setclientomnvar("ui_emp_drone_overlay", 1);
}

function empdrone_createdrone(var0) {
  var1 = empdrone_findstartposition();
  var2 = vectortoangles(var1.targetpos - var1.startpos);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var3 = spawnStruct();
  var3.origin = var1.startpos;
  var3.angles = var2;
  var3.modelname = "veh8_ind_air_bombing_drone";
  var3.vehicletype = "rcplane_physics_mp";
  var3.targetname = "rcplane";
  var3.cannotbesuspended = 1;
  var4 = spawnStruct();
  var5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var3, var4);

  if(!isDefined(var5)) {
    return;
  }

  var5 setotherent(self);
  var5 setentityowner(self);
  var5.owner = self;
  var5.ownerid = self getentitynumber();
  var5.team = self.team;
  var5.streakinfo = var0;
  var5 setCanDamage(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var0.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var0.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var0.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var0.streakname, &empdrone_handledeathdamage);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var5, var5.vehiclename);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var0.streakname, "Killstreak_Air", self, 0, 1, 25);
  }

  self notifyonplayercommand("emp_drone_detonate", "+attack");
  var5 playLoopSound("iw8_rc_plane_engine");
  thread empdrone_timeoutthink();
  thread empdrone_collidethink();
  thread empdrone_watchearlyexit();
  thread empdrone_watchdetonate();
  var5 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&empdrone_empapplied);
  return var5;
}

function empdrone_findstartposition() {
  var0 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var1 = (0, 0, 600);

  if(isDefined(var0)) {
    var2 = var0.origin[2] + -100;
    var1 = (0, 0, var2);
  }

  var3 = anglesToForward(self.angles);
  var4 = var1 + self.origin;
  var5 = var4 - var3 * 4000;
  var6 = var4;
  var7 = spawnStruct();
  var7.startpos = var5;
  var7.targetpos = var6;
  return var7;
}

function empdrone_timeoutthink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  var0 = 20;

  while(var0 > 0) {
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(var0 * 1000));
    var0 -= 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  thread empdrone_destroy();
}

function empdrone_collidethink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self vehphys_enablecollisioncallback(1);
  self waittill("collision", var0, var1, var2, var3, var4, var5, var6, var7);
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

function empdrone_handledeathdamage(var0) {
  var1 = var0.attacker;
  empdrone_givepointsfordeath(var1);
  empdrone_destroy();
}

function empdrone_explode() {
  self playSound("iw8_rc_plane_engine_exp");
  var0 = anglesToForward(self.angles);
  playFX(level._effects["vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"], self.origin, var0);
  empdrone_explodeemp();
  empdrone_delete();
}

function empdrone_destroy() {
  self playSound("recondrone_damaged");
  var0 = anglesToForward(self.angles);
  playFX(level._effects["vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"], self.origin, var0);
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

function empdrone_returnplayer(var0) {
  if(!istrue(var0.iscontrolled)) {
    return;
  }

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var0.streakinfo);
  }

  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  self controlsunlink();
  self cameraunlink(var0);
  empdrone_clearomnvars();
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_melee(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_usability(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "allowGesture")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "allowGesture")]](1);
  }

  var0 stoploopsound("iw8_rc_plane_engine");
  self notifyonplayercommandremove("emp_drone_detonate", "+frag");
  var0.iscontrolled = undefined;
  var0.streakinfo notify("killstreak_finished_with_deploy_weapon");
  var0 notify("emp_drone_exited");
}

function empdrone_clearomnvars() {
  self setclientomnvar("ui_emp_drone_overlay", 0);
}

function empdrone_empapplied(var0) {
  var1 = var0.attacker;
  empdrone_givepointsfordeath(var1);
  empdrone_destroy();
}

function empdrone_givepointsfordeath(var0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0))) {
    var0 notify("destroyed_equipment");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
      var0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("destroyed_equipment");
      return;
    }

    return;
  }
}

function empdrone_explodeemp() {
  var0 = getcompleteweaponname("emp_drone_non_player_mp");
  var1 = getcompleteweaponname("emp_drone_non_player_direct_mp");
  var2 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var4 in var2) {
    if(var4 == self) {
      continue;
    }

    var5 = var4.owner;

    if(isDefined(var5)) {
      if(var5 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var5)) {
        continue;
      }
    }

    var6 = distancesquared(self.origin, var4.origin);

    if(var6 > 589824) {
      continue;
    }

    var7 = scripts\engine\utility::ter_op(var6 > 4096, var0, var1);
    var4 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var7);
    var8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var4, 1, var7, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(var8);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat")) {
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("empDroneHits", 1);
    }

    self.usedcount++;
  }

  var10 = getcompleteweaponname("emp_drone_player_mp");
  radiusdamage(self.origin, 64, 60, 1, self.owner, "MOD_EXPLOSIVE", var10);
  var11 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
    var11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](self.origin, 768);
  }

  foreach(var13 in var11) {
    if(!var13 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }

    if(var13 != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var13)) {
      continue;
    }

    var13 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var10);
    var8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, var13, 1, var10, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(var8);
  }
}

function empdrone_applyemp(var0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var0);
  var1 = 8;

  if(isPlayer(var0.victim)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(var0.victim != self.owner && var0.victim[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_emp_resist")) {
        var1 = 2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hittacresist");
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "trackDebuffAssist")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "trackDebuffAssist")]](var0.attacker, var0.victim, var0.objweapon.basename);
    }
  }

  empdrone_empendearly(var0, var1);

  if(isDefined(var0.victim)) {
    var0.victim scripts\cp_mp\emp_debuff::remove_emp();

    if(isDefined(var0.attacker) && isPlayer(var0.victim)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "untrackDebuffAssist")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "untrackDebuffAssist")]](var0.attacker, var0.victim, var0.objweapon.basename);
        return;
      }

      return;
    }

    return;
  }
}

function empdrone_empendearly(var0, var1) {
  var0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var1);

  if(var2 != "emp_cleared") {
    var0.empremoved = 1;
    return;
  }
}