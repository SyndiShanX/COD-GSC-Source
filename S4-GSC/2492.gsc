/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2492.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("toma_strike", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("toma_strike", "init")]]();
  }

  level._id_F30F = [];
  _id_80D8();
}

_id_80D8() {
  game["dialog"]["cluster_strike_hit"] = "cluster_strike_hit";
  game["dialog"]["cluster_strike_miss"] = "cluster_strike_miss";
}

_id_F762(var_0) {
  var_1 = var_0.streakname;
  var_2 = getdvarint("#x34b34e4f64cf897ca", 3);
  return 1;
}

_id_10D72(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = getdvarint("#x34b34e4f64cf897ca", 3);
  var_2 thread _id_F310(var_3, undefined, var_1, var_0);
}

_id_10D96(var_0) {
  if(isDefined(level._id_F30F) && level._id_F30F.size >= 2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  return 1;
}

_id_10DE3(var_0, var_1) {
  var_2 = getdvarint("#x34b34e4f64cf897ca", 3);
}

_id_10D83(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_EEF2)) {
    var_3 = _id_F316(self);

    if(!isDefined(var_3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");
      }

      return "continue";
    }
  }

  if(_id_078D::_id_85B3()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }

    return "continue";
  }

  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_4 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_0.streakname, 1, var_4);
  return "success";
}

_id_F7A2() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("toma_strike", self);
  return _id_F7A3(var_0);
}

_id_F7A3(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_1 = getdvarint("#x34b34e4f64cf897ca", 3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    if(var_2 == "br") {
      var_1 = 5;
    }
  }

  if(var_1 == 4) {
    var_3 = _id_0A62::_id_F17C(var_0, ::_id_10D72);

    if(!istrue(var_3)) {
      return 0;
    }
  } else if(var_1 == 5 && isDefined(self._id_8E53)) {
    var_0._id_EEF2 = self._id_8E53;
    self._id_8E53 = undefined;
    var_4 = _id_10D83(var_0, undefined, undefined);

    if(var_4 != "success") {
      return 0;
    }
  } else {
    var_3 = _id_09B9::_id_EA03(var_0, makeweapon("s4_ks_targeting_radio_mp"), "weapon_fired", ::_id_10D96, ::_id_10DE3, ::_id_10D83);

    if(!istrue(var_3)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  if(_id_F31C(var_1)) {
    var_5 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level._id_59E1 + var_5 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
        self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
        var_0 notify("killstreak_finished_with_deploy_weapon");
        return 0;
      }
    }

    var_3 = _id_09B9::_id_EA05(var_0, ::_id_10D96, ::_id_10DE3);

    if(!istrue(var_3)) {
      return 0;
    }
  }

  var_6 = undefined;

  if(var_1 == 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
    }

    var_6 = _id_4067(self, var_0);

    if(!isDefined(var_6)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      }

      return 0;
    }
  } else if(var_1 == 1) {
    if(level._id_F2EB.size == 0) {
      var_7 = ["ks_strike_camera_1", "ks_strike_camera_2", "ks_strike_camera_3", "ks_strike_camera_4"];

      foreach(var_9 in var_7) {
        var_10 = scripts\engine\utility::getstruct(var_9, "targetname");

        if(!isDefined(var_10)) {
          var_0 notify("killstreak_finished_with_deploy_weapon");
          return;
        }

        var_11 = spawn("script_model", var_10.origin);
        var_11.angles = var_10.angles;
        var_11._id_0481 = var_10._id_0481;
        var_11 setModel("tag_player");
        level._id_F2EB[level._id_F2EB.size] = var_11;
      }
    }
  } else if(var_1 == 2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
    }

    var_6 = _id_4066(self, var_0);

    if(!isDefined(var_6)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      }

      return 0;
    }
  } else
    level._id_F30F[level._id_F30F.size] = self;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_toma_strike", self);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0.streakname, self.origin);
  }

  if(var_1 != 4) {
    thread _id_E732(var_1, var_6, level._id_F2EB, var_0);
  }

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("toma_strike", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("toma_strike", "munitionUsed")]]();
  }

  return 1;
}

_id_4067(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_3 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_3 = (0, 0, var_2.origin[2]);
  } else {
    var_3 = (0, 0, 600);
  }

  var_3 = var_3 - (0, 0, 900);
  var_4 = spawnhelicopter(var_0, var_0.origin + (0, 0, 1000), var_0.angles, "veh_toma_drone_mp", "veh8_mil_air_mquebec8");

  if(!isDefined(var_4)) {
    return;
  }
  var_4.speed = 100;
  var_4.accel = 50;
  var_4.health = 9999;
  var_4.maxhealth = 2000;
  var_4.lifetime = 10;
  var_4.team = var_0.team;
  var_4.owner = var_0;
  var_4.angles = var_0.angles;
  var_4.streakinfo = var_1;
  var_4.streakname = var_1.streakname;
  var_4._id_41BE = 0;
  var_4._id_CC16 = "destroyed_toma_strike";
  var_4._id_1068F = "destroyed_toma_strike";
  var_4._id_106B4 = "timeout_toma_strike";
  var_4._id_484B = "callout_destroyed_toma_strike";
  var_4._id_4208 = "proto_apache_flir_mp";
  level._id_F30F[level._id_F30F.size] = var_4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1.streakname, "Killstreak_Air", var_0, 0, 1, 25);
  }

  var_4 setmaxpitchroll(15, 15);
  var_4 vehicle_setspeed(var_4.speed, var_4.accel);
  var_4 sethoverparams(50, 5, 2.5);
  var_4 setturningability(1);
  var_4 setyawspeed(500, 100, 25, 0.5);
  var_4 setotherent(var_0);
  var_4 setentityowner(var_0);
  var_4 setCanDamage(1);
  var_4 setneargoalnotifydist(100);
  return var_4;
}

_id_4066(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_3 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_3 = (0, 0, var_2.origin[2] + 8000);
  } else {
    var_3 = (0, 0, 5000);
  }

  var_3 = var_3 - (0, 0, 900);
  var_4 = level._id_9AAC - anglesToForward(var_0.angles) * 5000 + var_3;
  var_5 = level._id_9AAC + anglesToForward(var_0.angles) * 20000 + var_3;
  var_6 = spawn("script_model", var_4);
  var_6 setModel("veh8_mil_air_acharlie130");
  var_6.health = 9999;
  var_6.maxhealth = 2000;
  var_6.angles = var_0.angles;
  var_6.owner = var_0;
  var_6.team = var_0.team;
  var_6.streakinfo = var_1;
  var_6.streakname = var_1.streakname;
  var_6._id_AEE6 = var_4;
  var_6._id_AEDC = var_5;
  var_6._id_5C8A = 1;
  var_6 setotherent(var_0);
  var_6 setentityowner(var_0);
  var_6 setCanDamage(1);
  var_6 _meth_856D();
  var_6 _meth_85AF();
  var_6._id_2FF8 = spawn("script_model", var_6.origin - (0, 0, 10));
  var_6._id_2FF8 setModel("tag_player");
  var_6._id_2FF8.angles = vectortoangles(level._id_9AAC - var_6._id_2FF8.origin);
  var_6._id_2FF8 linkto(var_6);
  var_6._id_3A00 = spawn("script_model", var_6._id_2FF8.origin - (0, 0, 10));
  var_6._id_3A00 setModel("ks_toma_strike_mp");
  var_6._id_3A00.angles = var_6.angles;
  var_6._id_3A00 linkto(var_6._id_2FF8);
  level._id_F30F[level._id_F30F.size] = var_6;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1.streakname, "Killstreak_Air", var_0, 0, 1, 25);
  }

  return var_6;
}

_id_E732(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");

  if(_id_F31C(var_0)) {
    scripts\common\utility::_id_153E(0);
    scripts\common\utility::_id_1593(0);
    scripts\common\utility::_id_1530(0);
    scripts\common\utility::_id_1570(0);
    scripts\common\utility::_id_158A(0);
    scripts\common\utility::_id_154F(0);
    self._id_C707 = self.angles;
    var_4 = 1;
    var_5 = spawn("script_model", self.origin);
    var_5 setModel("ks_toma_strike_marker_mp");
    var_5 setotherent(self);
    var_6 = [];

    foreach(var_8 in level.players) {
      if(level.teambased && var_8.team == self.team) {
        continue;
      }
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var_8[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          continue;
        }
      }

      var_6[var_6.size] = var_8;
    }

    var_10 = _id_079B::_id_EEDF("thermalvisionenemydefault", self, var_6, self, 0, 1, 1);
    var_11 = _id_079B::_id_EEDF("thermalvisionfriendlydefault", self, self, self);

    if(var_0 == 0) {
      if(!isDefined(var_1)) {
        return;
      }
      self setplayerangles(var_1.angles);
      self cameralinkto(var_1, "tag_origin");
      self remotecontrolvehicle(var_1);
      var_1 thread _id_F32A();
      var_1 thread _id_F326();
      var_1 thread _id_F331();
      var_1 thread _id_F328(var_5);
      thread _id_F330(var_5, var_1);
      var_1._id_B7AB = spawn("script_origin", var_1.origin);
      var_1._id_B7AB linkto(var_1);
      var_1._id_B7AB playLoopSound("veh_apache_killstreak_amb_lr");
      self setclientomnvar("ui_killstreak_health", (var_1.maxhealth - var_1._id_014E) / var_1.maxhealth);
    } else if(var_0 == 1) {
      if(!isDefined(var_2) || var_2.size == 0) {
        return;
      }
      var_4 = 0;
      scripts\cp_mp\utility\player_utility::_freezecontrols(1);
      thread _id_F325(var_2, var_5);
      thread _id_F330(var_5, var_1);
    } else if(var_0 == 2) {
      if(!isDefined(var_1)) {
        return;
      }
      self _meth_826E(var_1._id_2FF8, "tag_player", 1, 180, 180, 10, 90, 0);
      self _meth_8266(0);
      var_1 thread _id_F32A();
      var_1 thread _id_F326();
      var_1 thread _id_F331();
      var_1 thread _id_F328(var_5);
      var_1 thread _id_F32F(var_5);
      var_1 thread _id_F31F();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
        var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](::_id_F318);
      }

      if(isPlayer(var_1.owner)) {
        var_1.owner _meth_82FA("cluster_strike", 2);
      }

      var_1._id_3A00 setscriptablepartstate("clouds", "on");
      var_1 moveto(var_1._id_AEDC, 70);
    }

    self._id_3A05 = 3;
    self setclientomnvar("ui_cluster_controls", 1);
    self setclientomnvar("ui_cluster_missiles_left", self._id_3A05);
    self visionsetkillstreakforplayer("proto_toma_strike_mp");
    thread _id_F31E(var_5, var_1);
    thread _id_F324(var_5, var_1, var_4);
    thread _id_F32E(var_0, var_5, var_1, var_3);
    thread _id_F332(var_3, var_0, var_10, var_11);
  } else {
    thread _id_F310(var_0, undefined, undefined, var_3);
    var_3 notify("killstreak_finished_with_deploy_weapon");
    thread _id_F32B(var_3);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(20);
    self notify("cluster_strike_finished");
    scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_3);
  }
}

_id_F318(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 _meth_8174(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2._id_5C8A > 0) {
      var_2._id_5C8A--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
        var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, var_3);
      }

      var_6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
        var_6 = var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](var_0);
      }

      self missile_settargetent(var_6);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

_id_F32A() {
  self.owner endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("death");
  }

  self waittill("killstreakExit");
  self notify("death");
}

_id_F330(var_0, var_1) {
  self endon("disconnect");
  self endon("stop_marker_guide");
  var_2 = 1;

  if(isDefined(var_1)) {
    var_1 endon("death");
    var_1 endon("leaving");
    var_2 = 0;
  }

  level endon("game_ended");
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(10000));
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("timeout_toma_strike");

  if(isDefined(var_1)) {
    var_1 notify("death");
  }

  self notify("tomaStrike_returnPlayer", var_2);

  if(isDefined(var_0)) {
    var_0 delete();
  }

  self notify("stop_marker_guide");
}

_id_F326() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("toma_strike", "monitorDamage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("toma_strike", "monitorDamage")]](self.maxhealth, "hitequip", ::_id_F327, ::_id_F31D, 1);
  }
}

_id_F31D(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    var_6 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var_1, var_2, var_3, var_6, self.maxhealth, 2, 3, 4);
  }

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::_id_8ACE()) {
    if(istrue(self._id_8EE2)) {
      earthquake(0.25, 0.2, self.origin, 150);
      self.owner playrumbleonentity("damage_heavy");
    } else {
      earthquake(0.15, 0.15, self.origin, 150);
      self.owner playrumbleonentity("damage_light");
    }
  }

  self._id_41CA = self.maxhealth - (self._id_014E + var_6);
  self.owner setclientomnvar("ui_killstreak_health", self._id_41CA / self.maxhealth);
  return var_6;
}

_id_F327(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](self.streakname, var_1, var_2, var_3, var_4, self._id_CC16, self._id_1068F, self._id_484B);
  }

  self notify("death");
}

_id_F328(var_0) {
  self endon("gone");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self.owner notify("toma_strike_end");

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::_id_8ACE()) {
    self.owner notify("tomaStrike_returnPlayer", 0);
  }

  thread _id_F311(self.owner, self.origin, "s4_ks_ord_ger_mp", var_0);
}

_id_F32F(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(35.0);
  self notify("leaving");

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::_id_8ACE()) {
    self.owner notify("tomaStrike_returnPlayer", 0);
  }

  if(isDefined(self._id_F81F)) {
    self._id_F81F delete();
  }

  if(isDefined(self._id_2FF8)) {
    self._id_2FF8 delete();
  }

  if(isDefined(self._id_3A00)) {
    self._id_3A00 delete();
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }

  thread _id_F32C(var_0);
}

_id_F32C(var_0) {
  self endon("death");
  level endon("game_ended");

  while(self.origin != self._id_AEDC) {
    waitframe();
  }

  level._id_F30F = scripts\engine\utility::array_remove(level._id_F30F, self);

  if(isDefined(self._id_B7AB)) {
    self._id_B7AB stoploopsound();
    self._id_B7AB delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  self delete();
}

_id_F31F() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");

  for(;;) {
    self.owner earthquakeforplayer(0.07, 0.1, self gettagorigin("tag_origin"), 700);
    wait 0.1;
  }
}

_id_F331() {
  self endon("death");
  level endon("game_ended");
  self.owner scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  self notify("death");
}

_id_F325(var_0, var_1) {
  self endon("disconnect");
  self endon("stop_marker_guide");
  var_2 = var_0[0];
  self _meth_826E(var_2, "tag_player", 1, 45, 45, 20, 70, 0);
  self setplayerangles(var_2.angles);
  self._id_41B9 = var_2;
  self notifyonplayercommand("switch_camera_left", "+actionslot 3");
  self notifyonplayercommand("switch_camera_left", "+moveleft");
  self notifyonplayercommand("switch_camera_right", "+actionslot 4");
  self notifyonplayercommand("switch_camera_right", "+moveright");
  var_3 = 0;
  var_4 = var_0.size - 1;
  var_5 = var_3;

  for(;;) {
    var_6 = scripts\engine\utility::_id_10897("switch_camera_left", "switch_camera_right");
    var_7 = var_0[var_5].origin;
    var_8 = self getplayerangles();

    if(!isDefined(var_6)) {
      continue;
    }
    switch (var_6) {
      case "switch_camera_left":
        var_5++;

        if(var_5 > var_4) {
          var_5 = var_3;
        }

        break;
      case "switch_camera_right":
        var_5--;

        if(var_5 < var_3) {
          var_5 = var_4;
        }

        break;
    }

    _id_F320(var_7, var_8, var_0[var_5], var_1);
    waitframe();
  }
}

_id_F320(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_player");
  var_4.owner = self;
  var_4.angles = var_1;
  self _meth_826E(var_4, "tag_player", 1, 0, 0, 0, 0, 0);
  self _meth_8266(0);
  self _meth_844E("bw", 0.25);
  self visionsetkillstreakforplayer("");
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.25);
  self setclientomnvar("ui_cluster_controls", 0);
  var_3 setscriptablepartstate("target", "off", 0);
  var_4 moveto(var_2.origin, 0.25);
  var_4 rotateto(var_2.angles, 0.25);
  var_4 waittill("rotatedone");
  self visionsetnakedforplayer("", 0.2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  self setclientomnvar("ui_cluster_controls", 1);
  self _meth_844E("", 0);
  self visionsetkillstreakforplayer("proto_toma_strike_mp");
  self visionsetnakedforplayer("", 0);
  var_3 setscriptablepartstate("target", "guide", 0);
  self _meth_826E(var_2, "tag_player", 1, 45, 45, 20, 70, 0);
  self._id_41B9 = var_2;
  var_4 delete();
}

_id_F332(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self waittill("tomaStrike_returnPlayer", var_4);
  _id_F321(var_0, var_1, var_4, var_2, var_3);
}

_id_F32E(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("stop_marker_guide");

  if(isDefined(var_2)) {
    var_2 endon("death");
    var_2 endon("leaving");
  }

  level endon("game_ended");
  self notifyonplayercommand("drone_target_start", "+attack");

  for(;;) {
    self waittill("drone_target_start");

    if(self._id_3A05 == 0) {
      continue;
    }
    var_4 = spawn("script_model", self.origin);
    var_4 setModel("ks_toma_strike_marker_mp");
    var_4 setotherent(self);
    var_4.owner = self;
    thread _id_F323(var_0, var_2, var_1, var_4, var_3);

    if(var_0 == 2) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    }
  }
}

_id_F324(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("stop_marker_guide");
  var_3 = 1;

  if(isDefined(var_1)) {
    var_1 endon("death");
    var_1 endon("leaving");
    var_3 = 0;
  }

  for(;;) {
    self waittill("ammo_used");
    self._id_3A05--;
    self setclientomnvar("ui_cluster_missiles_left", self._id_3A05);

    if(self._id_3A05 == 0 && istrue(var_2)) {
      var_0 setscriptablepartstate("target", "off", 0);
      self setclientomnvar("ui_cluster_controls", 2);
      wait 5;
      var_0 setscriptablepartstate("target", "guide", 0);
      self._id_3A05 = 3;
      self setclientomnvar("ui_cluster_controls", 1);
      self setclientomnvar("ui_cluster_missiles_left", self._id_3A05);
      continue;
    }

    self setclientomnvar("ui_cluster_missiles_left", self._id_3A05);

    if(self._id_3A05 == 0) {
      self notify("tomaStrike_returnPlayer", var_3);

      if(isDefined(var_0)) {
        var_0 delete();
      }

      self notify("stop_marker_guide");
      break;
    }
  }
}

_id_F31E(var_0, var_1) {
  self endon("disconnect");
  self endon("stop_marker_guide");

  if(isDefined(var_1)) {
    var_1 endon("death");
    var_1 endon("leaving");
  }

  var_0 setscriptablepartstate("target", "guide", 0);

  for(;;) {
    var_2 = _id_F316(self);
    var_0.origin = var_2;
    waitframe();
  }
}

_id_F316(var_0) {
  var_1 = ["physicscontents_water", "physicscontents_glass", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight", "physicscontents_vehicleclip"];
  var_2 = physics_createcontents(var_1);
  var_3 = var_0 getvieworigin();
  var_4 = var_3 + anglesToForward(var_0 getplayerangles()) * 50000;
  var_5 = var_0 scripts\cp_mp\utility\killstreak_utility::_id_B702();
  var_6 = scripts\engine\trace::ray_trace(var_3, var_4, var_5, var_2);
  var_7 = undefined;

  if(isDefined(var_6["hittype"]) && var_6["hittype"] != "hittype_none") {
    var_7 = var_6["position"];
  }

  return var_7;
}

_id_F32D(var_0) {
  var_1 = self.owner;
  var_1 endon("disconnect");
  var_1 endon("drone_target_placed");
  self endon("death");
  level endon("game_ended");
  thread _id_F329();
  var_1 waittill("drone_target_release");
  var_1 notify("drone_target_cancel");
  var_0 setscriptablepartstate("target", "off", 0);
}

_id_F329() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_0 endon("drone_target_release");
  self waittill("death");
  var_0 notify("toma_strike_end");
  var_0 notify("drone_target_cancel");
}

_id_F323(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_3.origin = var_2.origin;
  var_3 setscriptablepartstate("target", "placed", 0);

  if(var_0 == 1) {
    var_3 thread _id_46D9(7);
  } else {
    var_3 thread _id_46D9(3);
  }

  self playlocalsound("weap_cluster_target_beep");
  self notify("ammo_used");

  if(isDefined(self)) {
    thread _id_F310(var_0, var_1, var_3, var_4);
  }
}

_id_F310(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("drone_target_placed");
  var_3._id_DA63++;
  var_4 = undefined;
  var_5 = undefined;

  if(var_0 == 0 || var_0 == 2) {
    var_4 = var_1.origin - (0, 0, 10) + anglesToForward(var_1.angles) * 20;
    var_5 = var_1.angles;
  } else if(var_0 == 1) {
    var_4 = self._id_41B9.origin - (0, 0, 3000);
    var_5 = anglestoright(self._id_41B9.angles);
  } else {
    var_4 = self.origin + (0, 0, 5000) - anglesToForward(self.angles) * 5000;
    var_5 = anglestoright(self.angles);
  }

  var_6 = undefined;

  if(isDefined(var_2)) {
    if(isvector(var_2)) {
      var_6 = var_2;
    } else {
      var_6 = var_2.origin;
    }
  } else {
    if(var_0 == 5 && isDefined(var_3._id_EEF2)) {
      var_6 = var_3._id_EEF2;
    } else {
      var_6 = _id_F316(self);
    }

    var_2 = spawn("script_model", var_6);
    var_2 setModel("ks_toma_strike_marker_mp");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
      var_2._id_A908 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
    }

    var_2._id_7C3B = "icon_waypoint_clusterstrike";
    var_2 setotherent(self);
    var_2 _id_F302(var_2._id_A908, var_2._id_7C3B, self, 50);
    var_2 thread _id_F2F9();
  }

  var_7 = 3;
  var_8 = 300;

  if(var_0 == 5) {
    var_7 = 6;
    var_8 = 900;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var_6, var_8 + 300, var_3.streakname);
    }
  }

  if(var_0 == 0 || var_0 == 2) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.3);
    var_4 = var_1.origin - (0, 0, 10) + anglesToForward(var_1.angles) * 50;
    var_9 = var_6;
    var_10 = spawnStruct();
    var_10._id_E06F = var_4;
    var_10._id_0200 = var_9;
    var_10._id_82B5 = var_10._id_0200 - var_10._id_E06F;
    thread _id_F313(var_10, var_3, var_1);
  } else if(var_0 == 1 || var_0 == 3 || var_0 == 4 || var_0 == 5) {
    var_11 = 2;
    var_12 = anglesToForward(self getplayerangles());
    var_13 = anglesToForward(self.angles);
    var_14 = anglestoright(self.angles);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_11);

    for(var_16 = 0; var_16 < var_7; var_16++) {
      var_10 = _id_5B09(var_6, var_8, var_12, var_13, var_14);
      thread _id_F313(var_10, var_3);
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(randomfloatrange(1.35, 2.5));
    }

    level._id_F30F = scripts\engine\utility::array_remove(level._id_F30F, self);
  }
}

_id_5B09(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_6 = _id_F312(var_0, var_2, var_3, var_4);
  var_7 = vectornormalize(var_0 - (var_6[0], var_6[1], 0));
  var_8 = _id_F317(var_0, var_1, var_7);
  var_9 = (0, 0, -1 * getdvarint("#x33c01342f08fa6256", 800));
  var_10 = (var_8.point - 0.5 * var_9 * _func_0219(4) - var_6) / 4;
  var_12 = var_6 + var_10 * 3.925 + 0.5 * var_9 * _func_0219(3.925);
  var_5._id_E06F = var_6;
  var_5._id_5506 = var_8._id_5506;
  var_5._id_5507 = var_8._id_5507;
  var_5._id_0200 = var_8.point;
  var_5._id_BB7E = var_12;
  var_5._id_82B5 = var_10;
  return var_5;
}

_id_46D9(var_0) {
  self.owner endon("disconnect");
  self endon("death");
  self.owner scripts\engine\utility::_id_108A7(var_0, "stop_marker_guide");
  self setscriptablepartstate("target", "off", 0);
  self delete();
}

_id_F322(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("disconnect");

  if(isDefined(var_2)) {
    var_2 visionsetthermalforplayer(var_1);

    if(isDefined(var_0)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
      var_2 visionsetthermalforplayer(self._id_4208);
    }
  }
}

_id_F317(var_0, var_1, var_2) {
  var_3 = randomint(var_1);
  var_4 = randomint(360);
  var_5 = var_0[0] + var_3 * cos(var_4);
  var_6 = var_0[1] + var_3 * sin(var_4);
  var_7 = var_0[2];
  var_8 = (var_5, var_6, var_7);

  if(isDefined(var_2)) {
    var_8 = var_8 - var_2 * 100;
  }

  var_9 = 10000;

  if(isDefined(level._id_F30B)) {
    var_9 = level._id_F30B;
  }

  var_10 = spawnStruct();
  var_11 = scripts\engine\trace::_id_3EF6(1);
  var_12 = scripts\engine\trace::ray_trace(var_8 + (0, 0, var_9), var_8 - (0, 0, var_9), undefined, var_11);

  if(isDefined(var_12["entity"])) {
    var_13 = var_12["entity"];
    var_10._id_5506 = var_13;

    if(_id_F31A(var_13) || _id_F319(var_13)) {
      var_10._id_5507 = "flying";
    }
  }

  if(isDefined(var_12["position"])) {
    var_8 = var_12["position"];
  }

  var_10.point = var_8;
  return var_10;
}

_id_F31A(var_0) {
  return var_0 scripts\cp_mp\vehicles\vehicle::_id_8AF5() && istrue(var_0 scripts\cp_mp\vehicles\vehicle::_id_102EE());
}

_id_F319(var_0) {
  return isDefined(var_0.streakinfo) && isDefined(var_0._id_D0CA) && var_0._id_D0CA == "Killstreak_Air";
}

_id_F313(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(var_2)) {
    self earthquakeforplayer(0.35, 1, var_2.origin, 1000);
  }

  var_3 = var_0._id_82B5;
  var_4 = 512;
  var_5 = var_3 * var_3;
  var_6 = magicgrenademanual("s4_ks_ord_ger_mp", var_0._id_E06F, var_3, 5, self);
  var_6.angles = vectortoangles(vectornormalize(var_0._id_0200 - var_0._id_E06F));
  var_6 setentityowner(self);
  var_6 setotherent(self);
  var_6._id_57B8 = spawn("script_model", var_6.origin);
  var_6._id_57B8 setModel("ks_toma_strike_missile_mp");
  var_6._id_57B8 linkto(var_6);
  var_6._id_57B8 dontinterpolate();
  var_6._id_57B8 setentityowner(self);
  var_6._id_57B8.streakinfo = var_1;
  thread _id_084C::bombing_run_incoming_close(var_6);
  var_7 = spawn("script_model", var_0._id_E06F);
  var_7 linkto(var_6, "tag_origin", (10, 0, 10), (0, 0, 0));
  var_6.killcament = var_7;
  var_6.owner = self;
  var_6.streakinfo = var_1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_0._id_0200, 512, 300, self.team, 6, self, 1);
  }

  var_6 thread _id_F30D();
  var_6 thread _id_F30E(vectortoangles(var_0._id_82B5), gettime(), var_0._id_82B5);
}

_id_F315(var_0) {
  var_1 = var_0;

  foreach(var_3 in level.players) {
    if(level.teambased && var_3.team == self.team) {
      continue;
    } else if(!level.teambased && var_3 == self) {
      continue;
    }
    if(!var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(istrue(var_3._id_9B3C)) {
      continue;
    }
    if(distancesquared(var_0, var_3.origin) > 250000) {
      continue;
    }
    var_3._id_9B3C = 1;
    var_1 = var_3.origin;
    var_3 thread _id_395A();
    break;
  }

  return var_1;
}

_id_395A() {
  self endon("disconnect");
  scripts\engine\utility::_id_108A7(10, "death");
  self._id_9B3C = undefined;
}

_id_F321(var_0, var_1, var_2, var_3, var_4) {
  scripts\common\utility::_id_153E(1);
  scripts\common\utility::_id_1593(1);
  scripts\common\utility::_id_1530(1);
  scripts\common\utility::_id_1570(1);
  scripts\common\utility::_id_158A(1);
  scripts\common\utility::_id_154F(1);
  self _meth_8078(1);

  if(var_1 == 1) {
    scripts\cp_mp\utility\player_utility::_freezecontrols(0);
  }

  if(!istrue(var_2)) {
    if(var_1 == 0) {
      self _meth_8294();
      self _meth_8060();
      self setplayerangles(self._id_C707);
      self._id_C707 = undefined;
    } else if(var_1 == 2)
      self unlink();
  } else {
    self unlink();
    self setplayerangles(self._id_C707);
    self._id_C707 = undefined;
  }

  self setclientomnvar("ui_cluster_controls", 0);
  self setclientomnvar("ui_cluster_missiles_left", 0);
  self visionsetkillstreakforplayer("", 0);
  self _meth_844E("", 0);
  self visionsetnakedforplayer("", 0);
  _id_079B::_id_EEDE(var_3);
  _id_079B::_id_EEDE(var_4);
  var_0 notify("killstreak_finished_with_deploy_weapon");
}

_id_F311(var_0, var_1, var_2, var_3) {
  self playSound("weap_hellfire_impact");

  if(isDefined(self._id_B7AB)) {
    self._id_B7AB stoploopsound();
    self._id_B7AB delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "grenade_earthQuakeAtPosition")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "grenade_earthQuakeAtPosition")]](var_1, 1.5);
  }

  level._id_F30F = scripts\engine\utility::array_remove(level._id_F30F, self);

  if(isDefined(self._id_F81F)) {
    self._id_F81F delete();
  }

  if(isDefined(self._id_2FF8)) {
    self._id_2FF8 delete();
  }

  if(isDefined(self._id_3A00)) {
    self._id_3A00 delete();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }

  self delete();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }
}

_id_F2FB(var_0) {
  self endon("death");
  self._id_57CE = 1;
  self._id_57B8 unlink();
  self._id_57B8.origin = var_0;
  self._id_57B8 setscriptablepartstate("explode", "active", 0);
  thread _id_084C::_id_629F(self._id_57B8.origin);
  self hide();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);

  if(isDefined(self._id_57B8)) {
    self._id_57B8 delete();
  }

  if(isDefined(self.stuck)) {
    self.stuck delete();
  }

  self delete();
}

_id_F2F2() {
  self endon("death");
  wait 0.05;
  self hide();
}

_id_F30D() {
  self endon("death");
  var_0 = self.owner;
  var_0 waittill("disconnect");

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  thread _id_F2FB(self.origin);
  self notify("missile_dest_failed");
}

_id_F30C(var_0, var_1, var_2) {
  self endon("death");
  self endon("missile_dest_failed");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.925);
  thread _id_F2FB(var_0);
}

_id_F2FE(var_0, var_1) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self unlink();
  self moveto(var_1, 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

_id_F30E(var_0, var_1, var_2) {
  self endon("death");
  self endon("missile_dest_failed");
  self waittill("missile_stuck", var_3);
  var_4 = -1 * getdvarint("#x33c01342f08fa6256", 800);
  var_5 = (gettime() - var_1) / 1000;
  var_6 = var_2 + (0, 0, var_4 * var_5);

  if(isDefined(var_3) && isPlayer(var_3)) {
    _id_F30A(self, var_3, var_0, var_6);
  } else {
    _id_F309(var_3, var_0, var_6);
  }

  thread _id_F2FB(self.origin);

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }
}

_id_F309(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = vectornormalize(var_2);
  var_5 = anglestoup(self.angles);
  var_6 = anglestoright(var_1);

  if(abs(vectordot(var_4, var_5)) >= 0.9848) {
    var_3 = _id_F301(var_5, var_6);
  } else {
    var_3 = _id_F300(var_5, var_4);
  }

  self.angles = var_3;
  self.stuck = _id_F2F1(self.origin, var_3, var_0, self.owner, gettime(), self.streakinfo);
}

_id_F30A(var_0, var_1, var_2, var_3) {
  var_3 = var_3 * (0, 0, 1);
  var_4 = var_0.origin;
  var_5 = (0, 0, -1);
  var_6 = var_4 + var_5 * 128;
  var_7 = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  var_8 = _func_02C1(var_4, var_6, var_7, var_0, 0, "physicsquery_closest", 1);

  if(isDefined(var_8) && var_8.size > 0) {
    var_6 = var_8[0]["position"];
    var_9 = var_8[0]["normal"];
    var_10 = var_8[0]["entity"];
    var_6 = var_6 - var_9 * 1;
    var_11 = -1 * getdvarint("#x33c01342f08fa6256", 800);
    var_12 = vectordot(var_6 - var_4, var_5);
    var_13 = _func_0218(2 * var_12 / (-1 * var_11));
    var_14 = var_9;
    var_15 = anglestoright(var_2);
    var_16 = _id_F301(var_14, var_15);
    self.stuck = _id_F2F1(var_6, var_16, var_10, self.owner, gettime(), self.streakinfo);
  }
}

_id_F2FA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0.owner;
  var_6 = var_0.killcament;
  var_7 = anglestoup(var_2);
  var_8 = var_1 + var_7 * 1;
  var_9 = var_8 + var_7 * 25;
  var_10 = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  var_11 = _func_02C1(var_8, var_9, var_10, var_0, 0, "physicsquery_closest", 1);

  if(isDefined(var_11) && var_11.size > 0) {
    var_9 = var_11[0]["position"] - var_7 * 1;
  }

  var_12 = var_9;
  var_13 = _id_F2F7(var_5, var_0.streakinfo, var_4, var_6);
  var_14 = _id_F2F4();
  var_15 = _id_F2F0(var_13, var_14, undefined, var_12, var_2, var_3, 0, undefined, undefined);
  var_13._id_2B0E[var_13._id_2B0E.size] = var_15;
  var_15.killcament = var_6;
  var_16 = anglesToForward(var_2);
  var_17 = anglestoright(var_2);
  var_18 = anglestoup(var_2);
  var_19 = _func_01C6(var_18, var_16, 45);
  var_20 = vectornormalize(_func_025B(var_19, var_18));
  var_21 = _func_025B(var_20, var_16);
  var_22 = _func_0017(var_19, var_20, var_21);
  var_14 = _id_F2F4();
  var_15 = _id_F2F0(var_13, var_14, undefined, var_12, var_22, var_3, 0, undefined, undefined);
  var_15.killcament = var_6;
  var_13._id_2B0E[var_13._id_2B0E.size] = var_15;
  var_19 = _func_01C6(var_18, var_16, -45);
  var_20 = vectornormalize(_func_025B(var_19, var_18));
  var_21 = _func_025B(var_20, var_16);
  var_22 = _func_0017(var_19, var_20, var_21);
  var_14 = _id_F2F4();
  var_15 = _id_F2F0(var_13, var_14, undefined, var_12, var_22, var_3, 0, undefined, undefined);
  var_15.killcament = var_6;
  var_13._id_2B0E[var_13._id_2B0E.size] = var_15;
  var_13 _id_F305();

  foreach(var_15 in var_13._id_2B0E) {
    var_15 thread _id_F307();
  }
}

_id_F307() {
  var_0 = self.killcament;

  if(!isDefined(self._id_BC1D)) {
    self._id_BC1D = gettime();
  }

  if(!isDefined(self._id_E6CA)) {
    if(!self._id_D9B6 _id_F304()) {
      var_1 = _id_F2ED(self._id_E6D5, self._id_E6C9, self._id_E6D7, self._id_D9B6.streakinfo);
      var_1.killcament = var_0;
      var_1 thread _id_F308();
      self._id_87B9 = 1;
      self._id_D9B6 _id_F304(1);
    }
  } else {
    self._id_3317 = self._id_E6D5;
    self._id_330F = undefined;
    self._id_3309 = self._id_E6C9;
    self._id_330D = undefined;
    self._id_331B = self._id_E6CA;
    self._id_E6D5 = undefined;
    self._id_E6C9 = undefined;
    self._id_E6CA = undefined;

    for(;;) {
      if(self._id_D9B6 _id_F304()) {
        break;
      }

      if(_id_F2EE()) {
        break;
      }

      if(!self._id_D9B6 _id_F303()) {
        waitframe();
        continue;
      }

      if(self._id_331B == 0) {
        var_2 = self._id_330B._id_5BD1;

        if(isDefined(var_2)) {
          self._id_3309 = [[var_2]](self._id_3309);
          self._id_330B._id_5BD1 = undefined;
        }
      }

      self._id_330D = _id_F2F5(self._id_3309, self._id_331B);
      self._id_330F = self._id_3317 + self._id_330D * _id_F2F6(self._id_331B, self._id_330B);
      var_3 = undefined;
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;
      var_8 = _func_02C1(self._id_3317, self._id_330F, self._id_D9B6._id_330A, undefined, 0, "physicsquery_closest", 1);

      if(isDefined(var_8) && var_8.size > 0) {
        var_3 = 1;
        var_4 = var_8[0]["position"];
        var_5 = var_8[0]["normal"];
        var_6 = var_8[0]["entity"];
      }

      switch (self._id_331B) {
        case 0:
          if(istrue(var_3)) {
            _id_F2EF(self._id_331B, 0, var_4);
            var_9 = 1;

            if(isDefined(self._id_330B._id_5BCE)) {
              var_10 = var_4 - self._id_3317;
              var_11 = vectordot(var_10, self._id_330D);
              self._id_330B._id_5BCE = self._id_330B._id_5BCE - var_11;

              if(self._id_330B._id_5BCE > self._id_330B._id_5BD0) {
                var_9 = 0;
              } else {
                self._id_330B._id_5BCE = undefined;
              }
            }

            var_7 = _id_F301(var_5, anglestoright(self._id_3309));

            if(var_9) {
              var_1 = _id_F2ED(var_4, var_7, var_6, self._id_D9B6.streakinfo);
              var_1.killcament = var_0;
              var_1 thread _id_F308();
            }

            self._id_331B = 2;
            self._id_3317 = var_4 + var_5 * 1;
            self._id_3309 = var_7;
          } else {
            _id_F2EF(self._id_331B, undefined, undefined);

            if(isDefined(self._id_330B._id_5BCE)) {
              var_10 = self._id_330F - self._id_3317;
              var_11 = vectordot(var_10, self._id_330D);
              self._id_330B._id_5BCE = self._id_330B._id_5BCE - var_11;

              if(self._id_330B._id_5BCE <= self._id_330B._id_5BD0) {
                self._id_330B._id_5BCE = undefined;
              }
            }

            self._id_331B = 1;
            self._id_3317 = self._id_330F;
          }

          break;
        case 1:
          if(istrue(var_3)) {
            var_7 = _id_F301(var_5, anglestoright(self._id_3309));
            var_1 = _id_F2ED(var_4, var_7, var_6, self._id_D9B6.streakinfo);
            var_1.killcament = var_0;
            var_1 thread _id_F308();
            var_12 = vectordot(anglestoup(self._id_3309), var_5);

            if(var_12 < 0.9848) {
              _id_F2EF(self._id_331B, 2, var_4);
              self._id_331B = 2;
              self._id_3317 = var_4 + var_5 * 1;
              self._id_3309 = var_7;
            } else {
              _id_F2EF(self._id_331B, 1, var_4);
              self._id_331B = 0;
            }
          } else {
            _id_F2EF(self._id_331B, undefined, undefined);
            self._id_3317 = self._id_330F;
          }

          break;
        case 2:
          if(istrue(var_3)) {
            _id_F2EF(self._id_331B, 3, var_4);
            self._id_331B = 0;
            self._id_3317 = var_4 + var_5 * 1;
          } else {
            _id_F2EF(self._id_331B, undefined, undefined);
            self._id_331B = 0;
          }

          break;
      }

      waittillframeend;
    }

    self._id_87B9 = 1;
    self._id_D9B6 _id_F304(1);
    self._id_D9B6._id_2B0E = [];
  }
}

_id_F2ED(var_0, var_1, var_2, var_3) {
  var_4 = 300;

  if(1) {
    var_4 = randomintrange(300, 350);
  }

  var_5 = self._id_BC1D + var_4;
  var_6 = _id_F2F1(var_0 + anglestoup(var_1), var_1, var_2, self._id_D9B6.owner, var_5, var_3);
  self._id_BC1D = var_5;
  self._id_5526[self._id_5526.size] = var_6;
  self._id_D9B6 _id_F306();
  return var_6;
}

_id_F2F1(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_model", var_0);
  var_6.angles = var_1;
  var_6._id_EA93 = var_2;
  var_6.owner = var_3;
  var_6._id_E72D = var_4;
  var_6.streakinfo = var_5;
  var_6 setModel("s4_ks_toma_strike_cluster_mp");
  var_6 setotherent(var_3);
  var_6 setentityowner(var_3);

  if(isDefined(var_2)) {
    var_6 linkto(var_2);
  }

  return var_6;
}

_id_F308() {
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self._id_EA93)) {
    self._id_EA93 endon("death");
  }

  while(gettime() < self._id_E72D) {
    waitframe();
  }

  thread _id_F2F3();
}

_id_F2F3() {
  self setscriptablepartstate("explode", "active", 0);
  wait 1;
  self delete();
}

_id_F305() {
  self._id_331A++;
  self._id_3319++;
  self._id_5F3E = gettime();
}

_id_F306() {
  self._id_552A++;
}

_id_F303() {
  if(self._id_5F3E < gettime()) {
    self._id_5F3E = gettime();
    self._id_3319 = 0;
  }

  return self._id_3319 < 3;
}

_id_F304(var_0) {
  var_1 = 0;

  if(self._id_331A >= 60) {
    var_1 = 1;
  } else if(self._id_552A >= 20) {
    var_1 = 1;
  } else if(istrue(var_0)) {
    var_2 = 1;

    foreach(var_4 in self._id_2B0E) {
      if(!var_4 _id_F2EE()) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      var_1 = 1;
    }
  }

  if(var_1) {
    self._id_87B9 = 1;
  }

  return var_1;
}

_id_F2EF(var_0, var_1, var_2) {
  self._id_D9B6 _id_F305();
  self._id_3316++;

  if(isDefined(var_1)) {
    if(var_1 == 0 || var_1 == 1 || var_1 == 2) {
      self._id_3310 = 0;
    }
  } else if(var_0 == 1)
    self._id_3310++;
}

_id_F2EE(var_0) {
  var_1 = 0;
  var_2 = undefined;

  if(self._id_D9B6 _id_F304()) {
    var_1 = 1;
  } else if(isDefined(self._id_330B) && self._id_3310 >= self._id_330B._id_9C6F) {
    var_1 = 1;
  } else if(isDefined(self._id_330B) && self._id_3316 >= self._id_330B._id_9C5A) {
    var_1 = 1;
  } else if(isDefined(self._id_330B) && self._id_5526.size >= self._id_330B._id_9C6B) {
    var_1 = 1;
  } else if(istrue(var_0)) {
    var_2 = 1;

    foreach(var_4 in self._id_2B0E) {
      if(!var_4 _id_F2EE()) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      var_1 = 1;
    }
  }

  if(var_1 && !istrue(self._id_87B9)) {
    var_6 = self._id_AA8C;

    if(isDefined(var_6)) {
      self[[var_6]]();
    }

    if(istrue(var_2)) {
      var_1 = 0;

      foreach(var_4 in self._id_2B0E) {
        if(!var_4 _id_F2EE()) {
          var_2 = 0;
          break;
        }
      }

      if(var_2) {
        var_1 = 1;
      }
    }
  }

  if(var_1) {
    self._id_87B9 = 1;
  }

  return var_1;
}

_id_F2F0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9._id_D9B6 = var_0;
  var_9._id_330B = var_1;
  var_9._id_E6D5 = var_3;
  var_9._id_E6C9 = var_4;
  var_9._id_E6D7 = var_5;
  var_9._id_E6CA = var_6;
  var_9._id_AA8C = var_8;
  var_9._id_5526 = [];
  var_9._id_2B0E = [];
  var_9._id_79B2 = [];
  var_9._id_79C2 = [];
  var_9._id_3316 = 0;
  var_9._id_3310 = 0;
  var_9._id_BC1D = var_7;
  return var_9;
}

_id_F2F7(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.owner = var_0;
  var_4.team = var_0.team;
  var_4.streakinfo = var_1;
  var_4._id_7D57 = var_2;
  var_4._id_2B0E = [];
  var_4._id_552A = 0;
  var_4._id_331A = 0;
  var_4._id_3319 = 0;
  var_4._id_5F3E = gettime();
  var_4._id_330A = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  return var_4;
}

_id_F2F4() {
  var_0 = spawnStruct();
  var_0._id_4BA2 = 250;
  var_0._id_4BA1 = 50;
  var_0._id_4BBF = 25;
  var_0._id_9C5A = 2;
  var_0._id_9C6F = 2;
  var_0._id_9C6B = 2;
  return var_0;
}

_id_F2F5(var_0, var_1) {
  switch (var_1) {
    case 0:
      return anglesToForward(var_0);
    case 1:
      return -1 * anglestoup(var_0);
    case 2:
      return anglestoup(var_0);
  }

  return undefined;
}

_id_F2F6(var_0, var_1) {
  switch (var_0) {
    case 0:
      if(isDefined(var_1._id_5BCE)) {
        return var_1._id_5BCE;
      } else {
        return var_1._id_4BA2;
      }
    case 1:
      return var_1._id_4BA1;
    case 2:
      return var_1._id_4BBF;
  }

  return undefined;
}

_id_F301(var_0, var_1) {
  var_2 = vectornormalize(_func_025B(var_0, var_1));
  var_1 = _func_025B(var_2, var_0);
  return _func_0017(var_2, var_1, var_0);
}

_id_F300(var_0, var_1) {
  var_2 = vectornormalize(_func_025B(var_1, var_0));
  var_1 = _func_025B(var_0, var_2);
  return _func_0017(var_1, var_2, var_0);
}

_id_F31C(var_0) {
  var_1 = 0;

  switch (var_0) {
    case 2:
    case 1:
    case 0:
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_F31B(var_0) {
  var_1 = 0;

  switch (var_0) {
    case 4:
    case 3:
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_F302(var_0, var_1, var_2, var_3) {
  _func_015D(var_0, var_1);
  _func_018C(var_0);
  _func_0185(var_0, var_2);
  _func_0160(var_0, self);
  _func_0161(var_0, var_3);
  _func_0172(var_0, 0);
  _func_0173(var_0, 0);
  _func_017A(var_0, 1);

  if(level.teambased) {
    _func_0182(var_0, var_2.team);
  } else {
    _func_0181(var_0, var_2);
  }

  _func_016B(var_0, "current");
}

_id_F2F9() {
  self endon("death");
  self setscriptablepartstate("target", "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self._id_A908);
    }

    self delete();
  }
}

_id_F312(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\trace::_id_3EF6(1);
  var_5 = scripts\engine\trace::ray_trace(var_0 - var_1 * 30, var_0 + var_1 * 1000, undefined, var_4);
  var_6 = var_5["position"] + var_5["normal"] * 20;
  var_7 = var_6;
  var_8 = 5000;
  var_9 = 5000;
  var_10 = [var_7 + var_2 * 100, var_7 - var_2 * 100, var_7 + var_3 * 100, var_7 - var_3 * 100, var_7 + (var_2 + var_3) * 100, var_7 + (var_2 - var_3) * 100, var_7 + (var_3 - var_2) * 100, var_7 + (-1 * var_2 - var_3) * 100];
  var_11 = var_7 + (0, 0, var_8 * 1.5);

  foreach(var_13 in var_10) {
    var_14 = vectornormalize(var_13 - var_7);
    var_15 = var_7 + (0, 0, var_8) - var_14 * var_9;
    var_16 = var_7;
    var_17 = scripts\engine\trace::ray_trace_passed(var_15, var_16, undefined, var_4);

    if(!istrue(var_17)) {
      wait 0.05;
      continue;
    }

    var_11 = var_15;
    break;
  }

  return var_11;
}

_id_F32B(var_0) {
  self endon("cluster_strike_finished");
  self endon("disconnect");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
}