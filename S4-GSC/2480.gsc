/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2480.gsc
*************************************************/

init() {
  level._id_0BCE["vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx");
  level._id_0BCE["vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp_drone", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("emp_drone", "init")]]();
  }
}

_id_5195() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B()) {
    return 0;
  }

  thread _id_51AA();
  return 1;
}

_id_51AA() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("emp_drone", self);
  var_1 = _id_51AC(var_0);

  if(!var_1) {
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  }

  wait 0.05;

  if(var_1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_emp_drone");
    }
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
}

_id_51AC(var_0) {
  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_1 = _id_09B9::_id_EA05(var_0, ::_id_51AF);

  if(!istrue(var_1)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  thread _id_51A9(var_0);
  return 1;
}

_id_519F(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var_1);
  }

  var_3 = scripts\cp_mp\utility\killstreak_utility::_id_4056("emp_drone", self);
  var_4 = _id_51AC(var_3);

  if(!var_4) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_empdrone", var_1);
    }
  }
}

_id_51AF(var_0) {
  return 1;
}

_id_51A9(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self _meth_865E();
  scripts\common\utility::_id_153E(0);
  scripts\common\utility::_id_1554(0);
  scripts\common\utility::_id_1593(0);
  scripts\common\utility::_id_158A(0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "allowGesture")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "allowGesture")]](0);
  }

  var_1 = _id_5199(var_0);
  var_1._id_87BF = 1;
  var_1._id_FE46 = 0;
  var_1._id_EB31 = level._id_EB2B._id_E76D["super_emp_drone"]._id_7C8C;
  self _meth_8094(var_1);
  self cameralinkto(var_1, "tag_origin");
  self setplayerangles(var_1.angles);
  self painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::_id_8DBE();
  self setclientomnvar("ui_emp_drone_overlay", 1);
}

_id_5199(var_0) {
  var_1 = _id_51A3();
  var_2 = vectortoangles(var_1._id_EEF5 - var_1._id_0405);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  var_3 = spawnStruct();
  var_3.origin = var_1._id_0405;
  var_3.angles = var_2;
  var_3.modelname = "veh8_ind_air_bombing_drone";
  var_3._id_04DE = "rcplane_physics_mp";
  var_3._id_0481 = "rcplane";
  var_3._id_31A0 = 1;
  var_4 = spawnStruct();
  var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_3, var_4);

  if(!isDefined(var_5)) {
    return;
  }
  var_5 setotherent(self);
  var_5 setentityowner(self);
  var_5.owner = self;
  var_5._id_ADA4 = self getentitynumber();
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
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var_0.streakname, ::_id_51A6);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_102C5(var_5, var_5._id_1031E);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_0.streakname, "Killstreak_Air", self, 0, 1, 25);
  }

  self notifyonplayercommand("emp_drone_detonate", "+attack");
  var_5 playLoopSound("iw8_rc_plane_engine");
  var_5 thread _id_51AB();
  var_5 thread _id_5198();
  var_5 thread _id_51AE();
  var_5 thread _id_51AD();
  var_5 _id_078D::_id_D15E(::_id_519D);
  return var_5;
}

_id_51A3() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
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
  var_7._id_0405 = var_5;
  var_7._id_EEF5 = var_6;
  return var_7;
}

_id_51AB() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  var_0 = 20;

  while(var_0 > 0) {
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(var_0 * 1000));
    var_0 = var_0 - 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  thread _id_519B();
}

_id_5198() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self _meth_8654(1);
  self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  thread _id_51A1();
}

_id_51AD() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("emp_drone_exited");
  self.owner waittill("emp_drone_detonate");
  thread _id_51A1();
}

_id_51AE() {
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
  thread _id_51A0();
}

_id_51A6(var_0) {
  var_1 = var_0.attacker;
  _id_51A5(var_1);
  _id_519B();
}

_id_51A1() {
  self playSound("iw8_rc_plane_engine_exp");
  var_0 = anglesToForward(self.angles);
  playFX(level._id_0BCE["vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"], self.origin, var_0);
  _id_51A2();
  _id_519A();
}

_id_519B() {
  self playSound("recondrone_damaged");
  var_0 = anglesToForward(self.angles);
  playFX(level._id_0BCE["vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"], self.origin, var_0);
  _id_519A();
}

_id_51A0() {
  self.owner _id_51A8(self);
}

_id_519A() {
  self.owner _id_51A8(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "fieldUpgradeExpired")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self._id_EB31, self._id_FE46, 0);
  }

  self stoploopsound("iw8_rc_plane_engine");
  scripts\cp_mp\vehicles\vehicle_tracking::_id_102BB(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(self);
}

_id_51A8(var_0) {
  if(!istrue(var_0._id_87BF)) {
    return;
  }
  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_0.streakinfo);
  }

  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::_id_8DBA();
  self _meth_8095();
  self _meth_8060(var_0);
  _id_5197();
  scripts\common\utility::_id_153E(1);
  scripts\common\utility::_id_1554(1);
  scripts\common\utility::_id_1593(1);
  scripts\common\utility::_id_158A(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "allowGesture")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "allowGesture")]](1);
  }

  var_0 stoploopsound("iw8_rc_plane_engine");
  self _meth_824C("emp_drone_detonate", "+frag");
  var_0._id_87BF = undefined;
  var_0.streakinfo notify("killstreak_finished_with_deploy_weapon");
  var_0 notify("emp_drone_exited");
}

_id_5197() {
  self setclientomnvar("ui_emp_drone_overlay", 0);
}

_id_519D(var_0) {
  var_1 = var_0.attacker;
  _id_51A5(var_1);
  _id_519B();
}

_id_51A5(var_0) {
  if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("destroyed_equipment");
    }
  }
}

_id_51A2() {
  var_0 = makeweapon("emp_drone_non_player_mp");
  var_1 = makeweapon("emp_drone_non_player_direct_mp");
  var_2 = _id_078D::_id_646E();

  foreach(var_4 in var_2) {
    if(var_4 == self) {
      continue;
    }
    var_5 = var_4.owner;

    if(isDefined(var_5)) {
      if(var_5 != self.owner && !scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_5)) {
        continue;
      }
    }

    var_6 = distancesquared(self.origin, var_4.origin);

    if(var_6 > 589824) {
      continue;
    }
    var_7 = scripts\engine\utility::ter_op(var_6 > 4096, var_0, var_1);
    var_4 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var_7);
    var_8 = _id_09BF::_id_ADCA(self.owner, var_4, 1, var_7, "MOD_EXPLOSIVE", self, self.origin);
    thread _id_5194(var_8);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat")) {
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("empDroneHits", 1);
    }

    self._id_FE46++;
  }

  var_10 = makeweapon("emp_drone_player_mp");
  _func_01BA(self.origin, 64, 60, 1, self.owner, "MOD_EXPLOSIVE", var_10);
  var_11 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
    var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](self.origin, 768);
  }

  foreach(var_13 in var_11) {
    if(!var_13 _id_078D::_id_30C2()) {
      continue;
    }
    if(var_13 != self.owner && !scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_13)) {
      continue;
    }
    var_13 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var_10);
    var_8 = _id_09BF::_id_ADCA(self.owner, var_13, 1, var_10, "MOD_EXPLOSIVE", self, self.origin);
    thread _id_5194(var_8);
  }
}

_id_5194(var_0) {
  _id_078D::_id_19B9(var_0);
  var_1 = 8;

  if(isPlayer(var_0._id_103C2)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(var_0._id_103C2 != self.owner && var_0._id_103C2[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_emp_resist")) {
        var_1 = 2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hittacresist");
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "trackDebuffAssist")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "trackDebuffAssist")]](var_0.attacker, var_0._id_103C2, var_0.objweapon.basename);
    }
  }

  _id_519E(var_0, var_1);

  if(isDefined(var_0._id_103C2)) {
    var_0._id_103C2 _id_078D::_id_C3AE();

    if(isDefined(var_0.attacker) && isPlayer(var_0._id_103C2)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "untrackDebuffAssist")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "untrackDebuffAssist")]](var_0.attacker, var_0._id_103C2, var_0.objweapon.basename);
      }
    }
  }
}

_id_519E(var_0, var_1) {
  var_0._id_103C2 endon("death_or_disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::_id_108F7("emp_cleared", var_1);

  if(var_2 != "emp_cleared") {
    var_0._id_51BD = 1;
  }
}