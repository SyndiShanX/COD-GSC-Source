/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2483.gsc
*************************************************/

init() {
  var_0 = getEntArray("trigger_hurt", "classname");

  if(isDefined(level._id_AD0F) && _func_0107(level._id_AD0F) && isDefined(var_0) && _func_0107(var_0)) {
    level.glidebomboutofboundstriggers = scripts\engine\utility::array_combine(level._id_AD0F, var_0);
  } else if(isDefined(var_0) && _func_0107(var_0)) {
    level.glidebomboutofboundstriggers = var_0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("glide_bomb", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("glide_bomb", "init")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("glide_bomb", "registerVO")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("glide_bomb", "registerVO")]]();
  }

  level._effect["predator_pod_break"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion.vfx");
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("glide_bomb", "invisible", 7);
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("glide_bomb", "on", 8);
}

_id_10D8F(var_0) {
  return 1;
}

_id_F781() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("glide_bomb", self);
  return _id_F782(var_0);
}

_id_F782(var_0) {
  if(getdvarint("#x31aea218a9509f6cb", 1) == 0) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_1 = _id_09B9::_id_EA01(var_0, makeweapon("s4_ks_gesture_generic_mp"));

  if(!istrue(var_1)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(level.gameended) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  var_2 = getdvarint("#x3bc865ed8136afed2", 0);
  var_3 = _id_CA3E(var_0.streakname, var_0, var_2);

  if(!istrue(var_3)) {
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_cruise_predator", self);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
  }

  return 1;
}

_id_CA3E(var_0, var_1, var_2) {
  self _meth_865E();
  var_3 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_4 = 15000;
  var_5 = level._id_9AAC;

  if(scripts\cp_mp\utility\game_utility::_id_88FE() || scripts\common\utility::iscp() || level.mapname == "mp_scrapyard") {
    var_5 = self.origin;
  }

  var_6 = [];
  var_7 = (0, 0, 0);
  var_8 = undefined;
  var_9 = level.players;

  if(scripts\common\utility::iscp()) {
    var_9 = level.characters;
  }

  foreach(var_11 in var_9) {
    if(var_11 == self) {
      continue;
    }
    if(level.teambased && var_11.team == self.team) {
      continue;
    }
    var_7 = var_7 + (var_11.origin - var_5);
    var_6[var_6.size] = var_11;
  }

  if(isDefined(var_7) && var_6.size > 0) {
    var_8 = vectornormalize(var_7 / var_6.size);
    var_8 = var_8 * (1, 1, 0);
  } else {
    var_13 = randomint(360);
    var_8 = anglesToForward((0, var_13, 0));
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("glide_bomb", "directionOverride")) {
    var_8 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("glide_bomb", "directionOverride")]](var_8);
  }

  var_14 = var_5 + (0, 0, var_4);
  var_15 = var_14 + var_8 * -50;
  var_16 = var_5;
  var_17 = spawn("script_model", var_15);
  var_17 setModel("wmd_vm_missile_cruise");
  var_17.owner = self;
  var_17.origin = var_15;
  var_17.angles = vectortoangles(var_16 - var_15);
  var_17.type = "remote";
  var_17.team = self.team;
  var_17.entitynumber = var_17 getentitynumber();
  var_17.streakinfo = var_1;
  var_17._id_5090 = 30;
  var_17 hide();
  self._id_C707 = self.angles;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0, var_17.origin);
  }

  level._id_C8B8[var_17.entitynumber] = var_17;
  level._id_C341 = 1;
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_0, 1);
  var_18 = _id_701C(var_17, var_16, var_2, var_1);
  return var_18;
}

_id_702A(var_0, var_1, var_2) {
  self endon("death");
  level endon("game_ended");
  self waittill("disowned");

  if(isDefined(self)) {
    _id_7019(var_0, var_1, var_2);
    self delete();
  }
}

_id_7019(var_0, var_1, var_2) {
  var_3 = self.owner;

  if(isDefined(var_3)) {
    var_3 _meth_865E();
    var_3 unlink();
    var_3 scripts\common\utility::_id_153E(1);
    var_3 scripts\common\utility::_id_1554(1);
    var_3 scripts\common\utility::_id_1593(1);
    var_3 scripts\common\utility::_id_158A(1);
    var_3 scripts\common\utility::_id_157E(1);
    var_3 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(var_0.streakname, "off");
    var_3 painvisionon();
    var_3 scripts\cp_mp\utility\killstreak_utility::_id_8DBA();
    var_3 visionsetkillstreakforplayer("");
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_3, 0, 0);
  }

  var_0 notify("killstreak_finished_with_deploy_weapon");

  if(isDefined(var_1)) {
    _id_079B::_id_EEDE(var_1);
  }

  if(isDefined(var_2)) {
    _id_079B::_id_EEDE(var_2);
  }
}

_id_701C(var_0, var_1, var_2, var_3) {
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 1, 0.1);
  wait 0.1;
  var_4 = undefined;
  var_5 = undefined;

  if(!istrue(var_2)) {
    _id_09C8::_id_0D89();
    self painvisionoff();
    scripts\cp_mp\utility\player_utility::_id_D8D4(var_3.streakname);
    scripts\common\utility::_id_153E(0);
    scripts\common\utility::_id_1554(0);
    scripts\common\utility::_id_1593(0);
    scripts\common\utility::_id_158A(0);
    scripts\common\utility::_id_157E(0);
    scripts\cp_mp\utility\killstreak_utility::_id_0CF8(var_3.streakname, "invisible");
    var_6 = [];
    var_7 = [];
    var_8 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("glide_bomb", "assignTargetMarkers")) {
      var_8 = self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("glide_bomb", "assignTargetMarkers")]](self);
    }

    if(isDefined(var_8._id_542C)) {
      var_6 = var_8._id_542C;
    }

    if(isDefined(var_8._id_5FBD)) {
      var_7 = var_8._id_5FBD;
    }

    var_4 = _id_079B::_id_EEDF("thermalvisionenemydefault", self, var_6, self, 0, 1, 1);
    var_5 = _id_079B::_id_EEDF("thermalvisionfriendlydefault", self, var_7, self, 1, 1);
    self _meth_826E(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
    self _meth_8266(0);
    var_0.owner _meth_8660(5.6, 5000, 3, 10);
    self painvisionoff();
    scripts\cp_mp\utility\killstreak_utility::_id_8DBE();
    var_0 thread _id_702A(var_3, var_4, var_5);
    var_0 thread _id_7030("disconnect");
    var_0 thread _id_7030("joined_team");
    var_0 thread _id_7030("joined_spectators");
  }

  if(!isDefined(var_0) || !isDefined(self)) {
    return 0;
  }

  thread _id_7026(var_0, var_3, var_2, var_4, var_5);
  return 1;
}

_id_7020() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.owner _meth_865D();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self.owner _meth_8660(0.2, 300, 20, 10);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  self.owner _meth_8660(5.6, 5000, 3, 10);
}

glide_bomb_watchoob() {
  self endon("death");

  for(;;) {
    if(glide_bomb_istouchingoobtrigger()) {
      self notify("death", self.origin);
    }

    waitframe();
  }
}

glide_bomb_istouchingoobtrigger() {
  if(istrue(self._id_15AE)) {
    return 0;
  }

  if(!isDefined(level.glidebomboutofboundstriggers)) {
    return 0;
  }

  foreach(var_1 in level.glidebomboutofboundstriggers) {
    if(!scripts\mp\outofbounds::_id_83B3(var_1, self)) {
      continue;
    }
    if(self istouching(var_1)) {
      return 1;
    }
  }

  return 0;
}

glide_bomb_fovlerp(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self setclientdvar("#x356e0c9e15809767a", 15);
  self _meth_8577("glide_bomb_fov_lerp");
  wait 1.2;
  self setclientdvar("#x356e0c9e15809767a", 40);
}

glide_bomb_earthquake(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = gettime();
  var_2 = var_1 + 7000;
  var_3 = 0;

  while(var_3 < 1) {
    var_3 = (7 - (var_2 - gettime()) / 1000) / 7;
    var_4 = 0.01 + 0.14 * var_3;
    self earthquakeforplayer(var_4, 0.01, var_0.origin, 50000);
    wait 0.01;
  }
}

glide_bomb_delaycontrolslinkto(var_0) {
  wait 1;
  self _meth_8094(var_0);
}

_id_7026(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 setscriptablepartstate("clouds", "on", 0);
  var_0 setscriptablepartstate("sub_thruster", "off", 0);
  var_5 = spawnStruct();
  var_5.origin = var_0 gettagorigin("tag_missile");
  var_5.angles = var_0 gettagangles("tag_missile");
  var_5.modelname = "wmd_vm_missile_cruise_warhead";
  var_5._id_0481 = "rcplane";
  var_5._id_31A0 = 1;
  var_6 = spawnStruct();
  var_7 = var_5.origin;
  var_8 = self.origin + (0, 0, -15000);
  var_9 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("s4_glidebomb_fromeo_mp"), var_7, var_8, self, self);
  var_9.angles = vectortoangles((0, 0, -1));
  var_1._id_DA63++;
  var_9 setmissileminimapvisible(1);
  var_9 setCanDamage(0);
  var_9 setotherent(self);
  var_9 setentityowner(self);
  var_9.team = self.team;
  var_9.owner = self;
  var_9.streakinfo = var_1;
  var_9.lifetime = 10;
  var_9.type = "remote";
  var_9._id_7665 = 0;
  var_9._id_5E14 = 160.0;
  thread _id_084C::_id_701E(var_9);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1.streakname, "Killstreak_Air", self, 0, 1, 50);
  }

  self cameralinkto(var_9, "tag_player", 0, 0, 1);
  thread glide_bomb_fovlerp(var_9);
  thread glide_bomb_earthquake(var_9);
  thread _id_10A38();
  var_9.killcament = spawn("script_model", var_9 gettagorigin("tag_player"));
  var_9.killcament setModel("tag_origin");
  var_9.killcament linkto(var_9, "tag_player");
  var_9 endon("death");
  var_9 _id_078D::_id_D15E(::_id_701A);
  var_10 = spawn("script_model", var_9 gettagorigin("tag_fx"));
  var_10 setModel("ks_cruise_predator_mp");
  var_10.angles = var_9 gettagangles("tag_fx");
  var_10.team = var_9.team;
  var_10.owner = var_9.owner;
  var_10.streakinfo = var_9.streakinfo;
  var_10 linkto(var_9, "tag_fx");
  var_10 setotherent(self);
  var_10 thread _id_7029(var_1);
  var_10 thread _id_702F(var_9);
  var_10 thread _id_702E(var_9, self, var_9.killcament, var_2, var_3, var_4);
  var_9 thread glide_bomb_watchoob();
  var_9 thread _id_7030("disconnect");
  var_9 thread _id_7030("joined_team");
  var_9 thread _id_7030("joined_spectators");

  if(!istrue(var_2) && isDefined(level._id_8DED)) {
    self visionsetkillstreakforplayer(level._id_8DED);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(!istrue(var_2)) {
    self _meth_865E();
    self unlink();
    thread glide_bomb_delaycontrolslinkto(var_9);
    self._id_036B = 0;
    _id_09C8::_id_0CF9("killstreak_veh_camera_mp", "top", var_9.lifetime, 0);
    scripts\cp_mp\utility\killstreak_utility::_id_0CF8(var_1.streakname, "on");
    self setclientomnvar("ui_killstreak_health", 1);
    self setclientomnvar("ui_killstreak_countdown", gettime() + int(10000));
    self setclientomnvar("ui_predator_missiles_left", -1);

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      self visionsetthermalforplayer("flir_0_black_to_white");
      scripts\cp_mp\utility\player_utility::_id_D720(1, 12, 1500);
      _id_09C8::_id_0CF9("killstreak_veh_camera_flir_mp", "top", var_9.lifetime, 0);
    }
  }

  var_9 thread _id_7017();
  var_11 = randomintrange(1, 3);
  var_9 scripts\cp_mp\utility\killstreak_utility::_id_B86F("cruise_control_" + var_11);
  var_9 thread _id_7031(self);
  var_9 _meth_80AA();
  waitframe();
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0.1);

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_702B() {
  if(!isDefined(level._id_8D0B)) {
    return;
  }
  self endon("death");
  self endon("explode");
  self endon("collision");
  self endon("emp_defused");
  self endon("trophy_blocked");

  for(;;) {
    if(_id_701F(level._id_8D0B)) {
      self notify("death");
      break;
    }

    waitframe();
  }
}

_id_701F(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(self istouching(var_3)) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_7017() {
  self endon("explode");
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2.0);
  thread _id_702B();
}

_id_7029(var_0) {
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("cruise_missile_finished");
  level waittill("game_ended");
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
}

_id_702F(var_0) {
  self endon("death");

  for(;;) {
    self._id_9F71 = var_0.origin;
    self._id_9F70 = var_0.angles;
    waitframe();
  }
}

_id_702E(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_2;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = var_0.streakinfo;
  var_10 = var_0 _id_7027("explode", "death", "disowned", "emp_defused", "trophy_blocked");
  var_0 setmissileminimapvisible(0);

  if(isDefined(var_4)) {
    _id_079B::_id_EEDE(var_4);
  }

  if(isDefined(var_5)) {
    _id_079B::_id_EEDE(var_5);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("glide_bomb", "CPUnMarkEnemies")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("glide_bomb", "CPUnMarkEnemies")]](var_1);
  }

  if(isDefined(self)) {
    var_7 = self._id_9F71;
    var_8 = self._id_9F70;

    if(isDefined(var_1)) {
      var_1 setclientdvar("#x356e0c9e15809767a", 65);
      var_1 _meth_8577("default");
      var_1 _meth_8060();
      var_1 _meth_8095();
      var_1._id_036B = 0;
      var_1 painvisionon();
      var_1 scripts\cp_mp\utility\player_utility::_id_3990();
    }

    if(!isDefined(var_10) || var_10._id_A2B9 != "emp_defused" && var_10._id_A2B9 != "trophy_blocked") {
      var_11 = 600;
      var_12 = "MOD_EXPLOSIVE";
      var_13 = "s4_glidebomb_fromeo_mp";

      if(isDefined(var_1)) {
        var_14 = isDefined(var_10) && var_10._id_A2B9 == "disowned";

        if(!istrue(var_14)) {
          var_0 radiusdamage(var_7, var_11, 1000, 1000, var_1, var_12, var_13);
        }

        var_15 = scripts\common\utility::_id_B7BF(var_7, var_11);

        foreach(var_17 in var_15) {
          if(var_17 scripts\cp_mp\utility\player_utility::_isalive() && scripts\cp_mp\utility\player_utility::_id_B78C(var_17, var_1)) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
              level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](var_17, "flavor_closecall", undefined, 1);
            }
          }
        }
      }
    }

    _id_09C8::_id_D9C8(var_7, 1, 1, 1000);
    thread _id_701D(var_10);
    thread _id_084C::glidebomb_explosion(var_7, var_0, self);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("glide_bomb", "eventRecord")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("glide_bomb", "eventRecord")]](var_7);
  }

  if(isDefined(var_1)) {
    var_1 thread _id_702C(var_10);

    if(!istrue(var_3)) {
      if(isDefined(var_1._id_E061)) {
        var_1._id_E061 stoploopsound("iw8_cruise_missile_plr");
        var_1._id_E061 delete();
      }

      var_1 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(var_9.streakname, "off");
      var_19 = 0;
      var_20 = spawn("script_model", var_7);
      var_20 setModel("tag_player");
      var_21 = getdvarint("#x33d3aee96a2edee51", 1000);
      var_22 = getdvarint("#x31d85af254b31c4a", 3250);
      var_23 = vectornormalize((0.5, 0, -1));
      var_24 = var_7 - var_23 * var_21;
      var_25 = (0, 0, var_22);
      var_26 = var_24 + var_25;
      var_20.angles = (5, 0, 0);
      var_6 unlink();
      var_6 linkto(var_20, "tag_player", (0, 0, 0), (0, 0, 0));

      if(scripts\cp_mp\utility\game_utility::isnightmap()) {
        var_1 scripts\cp_mp\utility\player_utility::_id_D720(0);
      }

      var_20.origin = var_26;
      var_1 cameralinkto(var_20, "tag_player");
      var_27 = 1;
      var_28 = 0.4;
      var_29 = 0.6;
      var_30 = 0.05;
      var_31 = undefined;

      if(var_19 == 0) {
        var_27 = 0;
      } else if(var_19 == 1) {
        var_31 = "cruise_predator_static";
      } else if(var_19 == 2) {
        var_31 = "cruise_predator_flash";
      }

      if(var_27) {
        var_1 thread _id_7025(var_28, var_29, var_30, var_31);
      }

      var_32 = scripts\common\utility::_id_B7BF(var_7, 2000);

      foreach(var_17 in var_32) {
        if(!isDefined(var_17) || !var_17 scripts\cp_mp\utility\player_utility::_isalive() || var_17 == var_1 && var_19 != 0) {
          continue;
        }
        var_17 earthquakeforplayer(0.3, 2, var_17.origin, 100);
        var_17 setclientomnvar("ui_hud_shake", 1);
        var_17 _meth_827A("artillery_rumble", var_17.origin);
      }

      if(var_19 != 0) {
        var_1 earthquakeforplayer(0.3, 3, var_1.origin, 100);
        var_1 setclientomnvar("ui_hud_shake", 1);
        var_1 _meth_827A("artillery_rumble", var_1.origin);
      }

      if(var_19 != 0) {
        wait 0.5;
      }

      wait 1;
      var_1 notify("cruise_missile_finished");
      var_1 _id_7022(var_9, var_20);
      var_1 scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_9);
    }
  }

  if(isDefined(var_6)) {
    var_6 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("glide_bomb", "removeItemFromSlot")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("glide_bomb", "removeItemFromSlot")]](var_1);
  }
}

_id_10A38() {
  level endon("match_ended");
  self endon("cruise_missile_finished");
  self endon("disconnect ");
  self waittill("death");
  self.waskilledduringglidebomb = 1;
}

_id_7022(var_0, var_1) {
  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_0);
  }

  _id_09C8::_id_0D89();
  self setclientdvar("#x356e0c9e15809767a", 65);
  self _meth_8577("default");
  self _meth_8060();
  self._id_036B = 0;
  var_1 delete();
  self visionsetkillstreakforplayer("");

  if(!isDefined(self.waskilledduringglidebomb) || !self.waskilledduringglidebomb) {
    scripts\common\utility::_id_153E(1);
    scripts\common\utility::_id_1554(1);
    scripts\common\utility::_id_1593(1);
    scripts\common\utility::_id_158A(1);
    scripts\common\utility::_id_157E(1);
    level thread scripts\cp_mp\utility\killstreak_utility::_id_C70C(self);
  }

  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::_id_8DBA();
  self.waskilledduringglidebomb = undefined;
  var_0 notify("killstreak_finished_with_deploy_weapon");
}

_id_7031(var_0) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);
  self notify("death", self.origin);
}

_id_7028(var_0, var_1) {
  self endon("death");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_2 = [self, var_1];
  var_3 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 1, 1, 0, 0);

  for(;;) {
    var_4 = anglesToForward(self.angles);
    var_5 = self gettagorigin("tag_missile");
    var_0._id_9003 = var_5;
    var_0._id_9002 = self.angles;
    var_6 = getdvarint("#x37115ddfd6b6567f2", 50);

    if(isDefined(self._id_9F6A)) {
      var_6 = getdvarint("#x32eb75f2fc2b7dea", 150);
    }

    var_7 = var_5 + var_4 * var_6;
    var_8 = scripts\engine\trace::_id_E409(var_5, var_7, 5, var_2, var_3);

    if(isDefined(var_8["hittype"]) && var_8["hittype"] != "hittype_none") {
      if(isDefined(var_8["position"])) {
        var_0._id_9006 = var_8;
        self notify("missile_close_explode", var_8["position"]);
        break;
      }
    }

    wait 0.05;
  }
}

_id_702D(var_0) {
  var_0 endon("disconnect");
  self endon("death");
  level endon("game_ended");
  var_0 notifyonplayercommand("missile_boost_on", "+attack");

  for(;;) {
    var_0 waittill("missile_boost_on");
    self._id_9F6A = 1;
    break;
  }
}

_id_7030(var_0) {
  self endon("death");
  self endon("disowned");
  level endon("game_ended");
  var_1 = self.owner;
  var_1 waittill(var_0);
  self notify("disowned");
}

_id_7024() {
  self visionsetkillstreakforplayer("cruise_predator_slamzoom", 0.05);
  wait 0.1;
  self visionsetkillstreakforplayer("", 0.05);
}

_id_7025(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.5;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.05;
  }

  if(isDefined(var_3)) {
    self visionsetkillstreakforplayer(var_3, var_0);
    wait(var_1);
    self visionsetkillstreakforplayer("", var_2);
  } else {
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 1, var_0);
    wait(var_1);
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, var_2);
  }
}

_id_7023(var_0) {
  self endon("disconnect");
  var_1 = 0;

  while(var_1 < var_0) {
    self _meth_827A("damage_light", self.origin);
    var_1 = var_1 + 0.05;
    wait 0.05;
  }
}

_id_7027(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    thread _id_108D1(var_0, var_6);
  }

  if(isDefined(var_1)) {
    thread _id_108D1(var_1, var_6);
  }

  if(isDefined(var_2)) {
    thread _id_108D1(var_2, var_6);
  }

  if(isDefined(var_3)) {
    thread _id_108D1(var_3, var_6);
  }

  if(isDefined(var_4)) {
    thread _id_108D1(var_4, var_6);
  }

  if(isDefined(var_5)) {
    thread _id_108D1(var_5, var_6);
  }

  var_6 waittill("returned", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
  var_6 notify("die");
  self.owner notify("cruise_missile_explode");
  var_16 = spawnStruct();
  var_16._id_A2B9 = var_7;
  var_16._id_AE40 = var_8;
  var_16._id_AE41 = var_9;
  var_16._id_AE42 = var_10;
  var_16._id_AE43 = var_11;
  var_16._id_AE44 = var_12;
  var_16._id_AE45 = var_13;
  var_16._id_AE46 = var_14;
  var_16._id_AE47 = var_15;
  return var_16;
}

_id_108D1(var_0, var_1) {
  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  var_1 notify("returned", var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_701D(var_0) {
  self endon("death");
  self unlink();

  if(!isDefined(var_0) || var_0._id_A2B9 == "death" || var_0._id_A2B9 == "disowned" || var_0._id_A2B9 == "emp_defused" || var_0._id_A2B9 == "trophy_blocked") {
    self setscriptablepartstate("air_explosion", "on", 0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.2);
    self delete();
  }

  var_1 = (0, 0, 1);
  var_2 = var_0._id_AE41;
  self.angles = vectortoangles((1, 0, 0));
  var_3 = vectordot(var_2, var_1);

  if(var_3 >= 0.7) {
    self setscriptablepartstate("ground_explosion", "on", 0);
  } else {
    self setscriptablepartstate("air_explosion", "on", 0);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self delete();
}

_id_702C(var_0) {
  self endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(isDefined(self) && isDefined(self._id_C0F3)) {
    if(self._id_C0F3 >= 1) {
      _id_0A8D::_id_9137("cruise_kill");
    } else {
      _id_0A8D::_id_9137("cruise_miss");
    }
  }
}

_id_7018(var_0, var_1) {
  self endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(!istrue(var_1)) {
    self visionsetkillstreakforplayer("cruise_predator_slamzoom", 0.1);
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 1, 0.2);
    wait 0.2;
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0);
  }
}

_id_701A(var_0) {
  if(isDefined(self)) {
    self notify("emp_defused");
  }
}