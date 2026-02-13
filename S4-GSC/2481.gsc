/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2481.gsc
*************************************************/

init() {
  level._effect["vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx");
  level._effect["vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_contrails.vfx"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_contrails.vfx");
  level._effect["vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_heat_dist.vfx"] = loadfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_heat_dist.vfx");
  level._effect["vfx/iw8_mp/killstreak/vfx_rc_plane_rotor.vfx"] = loadfx("vfx/iw8_mp/killstreak/vfx_rc_plane_rotor.vfx");
  level._effect["vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx");
  level._effect["vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp_drone_targeted", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("emp_drone_targeted", "init")]]();
  }
}

_id_5195() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  thread _id_51AA();
  return 1;
}

_id_51AA() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("emp_drone", self);
  var_1 = _id_51AC(var_0);
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

  _id_09B9::_id_AAB1(var_0);
  var_1 = makeweapon("ks_remote_map_mp");
  var_2 = _id_09B9::_id_1097E;
  var_3 = ::_id_51AF;
  var_4 = _id_09B9::_id_EC37(var_1, var_0, var_2, var_3);
  _id_09B9::_id_AAB0(var_0, istrue(var_4));

  if(!istrue(var_4)) {
    return 0;
  }

  var_5 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("empDroneTargeted", "getSelectMapPoint")) {
    var_5 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("empDroneTargeted", "getSelectMapPoint")]](var_0, 1);
  } else {
    return 0;
  }

  if(!isDefined(var_5)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  thread _id_5199(var_0, var_5[0]._id_96CF);

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_0);
  }

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
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("empDroneTargeted", "startMapSelectSequence")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("empDroneTargeted", "startMapSelectSequence")]](0, 0, undefined, 3);
  } else {
    return 0;
  }

  return 1;
}

_id_5199(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_2 = _id_5196(var_1);
  var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("emp_drone_proj_mp"), var_2._id_0405, var_2._id_EEF5, self);
  var_3 setentityowner(self);
  var_3.owner = self;
  var_3._id_ADA4 = self getentitynumber();
  var_3.team = self.team;
  var_3.streakinfo = var_0;
  var_3._id_FE46 = 0;
  var_3._id_EB31 = level._id_EB2B._id_E76D["super_emp_drone"]._id_7C8C;
  var_3 hidepart("j_propeller");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx"), var_3, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_contrails.vfx"), var_3, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_heat_dist.vfx"), var_3, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8_mp/killstreak/vfx_rc_plane_rotor.vfx"), var_3, "j_propeller");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("empDroneTargeted", "monitorDamage")) {
    var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("empDroneTargeted", "monitorDamage")]](25, "hitequip", ::_id_51A6, undefined, 0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_0.streakname, "Killstreak_Air", self, 0, 1, 25);
  }

  var_3 playLoopSound("iw8_rc_plane_engine");
  var_3 thread _id_51AB();
  var_3 thread _id_51A4();
  var_3 thread _id_5198();

  if(getdvarint("#x3600bf2cb6e953510", 0) == 0) {
    var_3 thread _id_519C(var_2);
  } else {
    var_3 thread _id_51A7(var_2);
  }

  var_3 _id_078D::_id_D15E(::_id_519D);
  return var_3;
}

_id_5196(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_2 = (0, 0, 1500);

  if(isDefined(var_1)) {
    var_3 = var_1.origin[2] + -1500;
    var_2 = (0, 0, var_3);
  }

  var_4 = anglesToForward(self.angles);
  var_5 = undefined;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;

  for(;;) {
    var_9 = rotatevector(var_4, (0, var_7, 0));
    var_10 = var_2 + var_0;
    var_5 = var_10 - var_9 * 4500;
    var_11 = (0, 0, 1500);
    var_5 = var_5 + var_11;
    var_12 = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_6 = scripts\engine\trace::ray_trace_passed(var_5, var_10, undefined, var_12);
    var_8++;

    if(var_6) {
      break;
    }

    if(var_8 >= 13) {
      break;
    }

    wait 0.05;
    var_7 = var_7 + 55.3;
  }

  var_13 = vectornormalize(var_5 - var_10) * 1000 + var_10;
  var_14 = spawnStruct();
  var_14._id_0405 = var_5;
  var_14._id_4BC1 = var_13;
  var_14._id_EEF5 = var_0;
  return var_14;
}

_id_51AB() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  var_0 = gettime() * 0.001;
  var_1 = var_0 + 20;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  thread _id_519B();
}

_id_51A4() {
  self.owner endon("disconnect");
  self endon("death");
  level scripts\engine\utility::waittill_any_2("game_ended", "prematch_cleanup");
  thread _id_519B();
}

_id_5198() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self waittill("missile_stuck");
  thread _id_51A1();
}

_id_519C(var_0) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self _meth_8234(var_0._id_4BC1);
  var_1 = 50;

  while(distancesquared(var_0._id_4BC1, self.origin) > var_1 * var_1) {
    wait 0.05;
  }

  var_2 = anglesToForward(self.angles);
  var_3 = distance(var_0._id_EEF5, self.origin);
  var_4 = self.origin + var_2 * var_3;
  var_5 = gettime();
  var_6 = 0;
  var_7 = 0;

  for(;;) {
    wait 0.05;
    var_6 = (gettime() - var_5) / 1300.0;
    var_6 = clamp(var_6, 0, 1);
    var_8 = var_4 * (1 - var_6) + var_0._id_EEF5 * var_6;
    self _meth_8234(var_8);
  }
}

_id_51A7(var_0) {}

_id_51A6(var_0, var_1, var_2) {
  _id_51A5(var_0);
  _id_519B();
}

_id_51A1() {
  self playSound("iw8_rc_plane_engine_exp");
  var_0 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"), self.origin, var_0);
  _id_51A2();
  _id_519A();
}

_id_519B() {
  self playSound("recondrone_damaged");
  var_0 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"), self.origin, var_0);
  _id_519A();
}

_id_519A() {
  self stoploopsound("iw8_rc_plane_engine");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_emp_drone", self._id_FE46);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "fieldUpgradeExpired")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self._id_EB31, self._id_FE46, 0);
  }

  self delete();
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
  var_2 = [];
  var_3 = _id_078D::_id_646E();

  foreach(var_5 in var_3) {
    if(var_5 == self) {
      continue;
    }
    var_6 = var_5.owner;

    if(isDefined(var_6)) {
      if(var_6 != self.owner && !scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_6)) {
        continue;
      }
    }

    var_7 = distancesquared(self.origin, var_5.origin);

    if(var_7 > 640000) {
      continue;
    }
    var_8 = var_5 scripts\cp_mp\vehicles\vehicle::_id_8AF5();
    var_9 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BB(var_5);

    if(var_8 && var_9) {
      var_10 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_5);

      foreach(var_12 in var_10) {
        var_2[var_2.size] = var_12;
      }
    }

    var_14 = scripts\engine\utility::ter_op(var_7 > 6400, var_0, var_1);
    var_5 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var_14);
    var_15 = _id_09BF::_id_ADCA(self.owner, var_5, 1, var_14, "MOD_EXPLOSIVE", self, self.origin);
    thread _id_5194(var_15);
  }

  var_17 = makeweapon("emp_drone_player_mp");
  self radiusdamage(self.origin, 80, 120, 80, self.owner, "MOD_EXPLOSIVE", var_17);
  var_18 = scripts\common\utility::_id_B7BF(self.origin, 800);
  var_18 = scripts\engine\utility::_id_1B9D(var_18, var_2);

  foreach(var_20 in var_18) {
    if(!isDefined(var_20)) {
      continue;
    }
    if(!var_20 _id_078D::_id_30C2()) {
      continue;
    }
    if(var_20 != self.owner && !scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_20)) {
      continue;
    }
    var_20 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", var_17);
    var_15 = _id_09BF::_id_ADCA(self.owner, var_20, 1, var_17, "MOD_EXPLOSIVE", self, self.origin);
    thread _id_5194(var_15);
  }

  var_22 = scripts\common\utility::_id_B7BF(self.origin, 2000);
  var_22 = scripts\engine\utility::_id_1B9D(var_22, var_2);

  foreach(var_20 in var_22) {
    if(!isDefined(var_20)) {
      continue;
    }
    if(var_20 == self.owner) {
      continue;
    }
    var_20 earthquakeforplayer(0.3, 1, self.origin, 2000);
    var_20 setclientomnvar("ui_hud_shake", 1);
    var_20 _meth_827A("artillery_rumble_light", self.origin);
  }

  self.owner earthquakeforplayer(0.2, 1, self.owner.origin, 2000);
  self.owner setclientomnvar("ui_hud_shake", 1);
  self.owner _meth_827A("artillery_rumble_light", self.origin);
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

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("empDroneHits", 1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "combatRecordSuperMisc")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "combatRecordSuperMisc")]]("super_emp_drone");
  }

  self._id_FE46++;
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