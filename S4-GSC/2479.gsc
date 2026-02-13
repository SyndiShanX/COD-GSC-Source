/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2479.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "init")]]();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "registerVO")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "registerVO")]]();
  }

  level._effect["predator_pod_break"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion.vfx");
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("cruise_predator", "invisible", 7);
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("cruise_predator", "on", 8);
}

_id_10D8B(var_0) {
  return 1;
}

_id_F774() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("cruise_predator", self);
  return _id_F775(var_0);
}

_id_F775(var_0) {
  if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B()) {
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  var_1 = _id_09B9::_id_EA01(var_0, makeweapon("s4_ks_gesture_generic_mp"));

  if(!istrue(var_1)) {
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  if(level.gameended) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  var_2 = getdvarint("#x3bc865ed8136afed2", 0);
  var_3 = _id_CA2C(var_0.streakname, var_0, var_2);

  if(!istrue(var_3)) {
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_cruise_predator", self);
  }

  return 1;
}

_id_CA2C(var_0, var_1, var_2) {
  self _meth_865E();
  var_3 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_4 = 10000;

  if(isDefined(var_3)) {
    var_4 = var_3.origin[2] + 6000;
  }

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

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "directionOverride")) {
    var_8 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "directionOverride")]](var_8);
  }

  var_14 = var_5 + (0, 0, var_4);
  var_15 = var_14 + var_8 * -3000;
  var_16 = var_14;
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
  self._id_C707 = self.angles;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0, var_17.origin);
  }

  level._id_C8B8[var_17.entitynumber] = var_17;
  level._id_C341 = 1;
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_0, 1);
  var_18 = _id_40C9(var_17, var_16, var_2, var_1);
  return var_18;
}

_id_40D8(var_0, var_1, var_2) {
  self endon("death");
  level endon("game_ended");
  self waittill("disowned");

  if(isDefined(self)) {
    _id_40C5(var_0, var_1, var_2);
    self delete();
  }
}

_id_40C5(var_0, var_1, var_2) {
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
    var_3 setclientomnvar("ui_predator_missile", 0);
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

#using_animtree("script_model");

_id_40C9(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::_id_65F1(%mp_cruise_missile_move_intro, "wingtrails");
  var_5 = scripts\engine\utility::_id_65F1(%mp_cruise_missile_move_intro, "shell_break");
  var_6 = scripts\engine\utility::_id_65F1(%mp_cruise_missile_move_intro, "second_missile_thruster");
  var_7 = scripts\engine\utility::_id_65F1(%mp_cruise_missile_move_intro, "anim_end");
  var_8 = var_4;
  var_9 = var_5 - var_4;
  var_10 = var_6 - var_5;
  var_11 = var_7 - var_6;
  var_12 = undefined;
  var_13 = undefined;

  if(!istrue(var_2)) {
    _id_09C8::_id_0D89();
    scripts\common\utility::_id_153E(0);
    scripts\common\utility::_id_1554(0);
    scripts\common\utility::_id_1593(0);
    scripts\common\utility::_id_158A(0);
    scripts\common\utility::_id_157E(0);
    scripts\cp_mp\utility\killstreak_utility::_id_0CF8(var_3.streakname, "invisible");
    self setclientomnvar("ui_predator_missile", 1);
    var_14 = [];
    var_15 = [];
    var_16 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "assignTargetMarkers")) {
      var_16 = self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "assignTargetMarkers")]](self);
    }

    if(isDefined(var_16._id_542C)) {
      var_14 = var_16._id_542C;
    }

    if(isDefined(var_16._id_5FBD)) {
      var_15 = var_16._id_5FBD;
    }

    var_12 = _id_079B::_id_EEDF("thermalvisionenemydefault", self, var_14, self, 0, 1, 1);
    var_13 = _id_079B::_id_EEDF("thermalvisionfriendlydefault", self, var_15, self, 1, 1);
    self _meth_826E(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
    self _meth_8266(0);
    var_0 thread _id_40CC();
    self painvisionoff();
    scripts\cp_mp\utility\killstreak_utility::_id_8DBE();
    var_0 thread _id_40D8(var_3, var_12, var_13);
    var_0 thread _id_40DF("disconnect");
    var_0 thread _id_40DF("joined_team");
    var_0 thread _id_40DF("joined_spectators");
  }

  var_17 = "mp_cruise_missile_move_intro";
  var_18 = getdvarint("#x33ead3f9f0e9e8151", 0);

  if(var_18 == 1) {
    var_17 = "mp_cruise_missile_move_angle_intro";
  }

  var_0 _meth_82CC(var_17);
  var_0 setscriptablepartstate("main_thruster", "on", 0);
  var_0 setscriptablepartstate("clouds", "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_8);

  if(!isDefined(var_0)) {
    return 0;
  }

  var_0 setscriptablepartstate("wing_trails", "on");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_9);

  if(!isDefined(var_0)) {
    return 0;
  }

  var_0 setscriptablepartstate("wing_trails", "off");
  var_0 setscriptablepartstate("main_thruster", "off", 0);
  playFXOnTag(scripts\engine\utility::getfx("predator_pod_break"), var_0, "tag_missile");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_10);

  if(!isDefined(var_0)) {
    return 0;
  }

  var_0 setscriptablepartstate("sub_thruster", "on", 0);

  if(!isDefined(var_0) || !isDefined(self)) {
    return 0;
  }

  thread _id_40C4(var_11 - 0.15, var_2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_11 - 0.05);

  if(!isDefined(var_0) || !isDefined(self)) {
    return 0;
  }

  thread _id_40D3(var_0, var_3, var_2, var_12, var_13);
  return 1;
}

_id_40CC() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.owner _meth_865D();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self.owner _meth_8660(0.2, 300, 20, 10);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  self.owner _meth_8660(5.6, 5000, 3, 10);
}

_id_40D3(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 setscriptablepartstate("clouds", "off", 0);
  var_0 setscriptablepartstate("sub_thruster", "off", 0);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  var_5 = spawnStruct();
  var_5.origin = var_0 gettagorigin("tag_missile");
  var_5.angles = var_0 gettagangles("tag_missile");
  var_5.modelname = "wmd_vm_missile_cruise_warhead";
  var_5._id_04DE = "veh_cruise_predator_mp";
  var_5._id_0481 = "rcplane";
  var_5._id_31A0 = 1;
  var_6 = spawnStruct();
  var_7 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_5, var_6);

  if(!isDefined(var_7)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var_1.streakname);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_102C5(var_7);
  var_1._id_DA63++;
  var_7 setCanDamage(0);
  var_7 setotherent(self);
  var_7 setentityowner(self);
  var_7.angles = var_0 gettagangles("tag_missile");
  var_7.team = self.team;
  var_7.owner = self;
  var_7.streakinfo = var_1;
  var_7.lifetime = 10;
  var_7 setscriptablepartstate("warhead_thruster", "on", 0);
  var_7 _meth_83A6(var_7.team);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1.streakname, "Killstreak_Air", self, 0, 1, 50);
  }

  var_7.killcament = spawn("script_model", var_7 gettagorigin("tag_player"));
  var_7.killcament setModel("tag_origin");
  var_7.killcament linkto(var_7, "tag_player");
  var_7 endon("death");
  var_7 _id_078D::_id_D15E(::_id_40C7);
  var_8 = spawn("script_model", var_7 gettagorigin("tag_fx"));
  var_8 setModel("ks_cruise_predator_mp");
  var_8.angles = var_7 gettagangles("tag_fx");
  var_8.team = var_7.team;
  var_8.owner = var_7.owner;
  var_8.streakinfo = var_7.streakinfo;
  var_8 linkto(var_7, "tag_fx");
  var_8 setscriptablepartstate("fake_trail", "on", 0);
  var_8 setotherent(self);
  var_8 thread _id_40D7(var_1);
  var_8 thread _id_40DD(var_7);
  var_8 thread _id_40DC(var_7, self, var_7.killcament, var_2, var_3, var_4);
  var_7 thread _id_40DF("disconnect");
  var_7 thread _id_40DF("joined_team");
  var_7 thread _id_40DF("joined_spectators");

  if(!istrue(var_2)) {
    self visionsetkillstreakforplayer("", 0.1);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(!istrue(var_2)) {
    self _meth_865E();
    self unlink();
    self cameralinkto(var_7, "tag_player", 1);
    self _meth_8094(var_7);
    self visionsetkillstreakforplayer("cruise_color");
    self._id_E061 = spawn("script_origin", var_7.origin);
    self._id_E061 _meth_83CA(self);
    self._id_E061 playLoopSound("iw8_cruise_missile_plr");
    _id_09C8::_id_0CF9("killstreak_veh_camera_mp", "top", var_7.lifetime, 0);
    scripts\cp_mp\utility\killstreak_utility::_id_0CF8(var_1.streakname, "on");
    self setclientomnvar("ui_predator_missile", 2);
    self setclientomnvar("ui_killstreak_health", 1);
    self setclientomnvar("ui_killstreak_countdown", gettime() + int(10000));
    self setclientomnvar("ui_predator_missiles_left", -1);

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      self visionsetthermalforplayer("flir_0_black_to_white");
      scripts\cp_mp\utility\player_utility::_id_D720(1, 12, 1500);
      _id_09C8::_id_0CF9("killstreak_veh_camera_flir_mp", "top", var_7.lifetime, 0);
    }
  }

  var_7 thread _id_40C3();
  var_9 = randomintrange(1, 3);
  var_7 scripts\cp_mp\utility\killstreak_utility::_id_B86F("cruise_control_" + var_9);
  var_7 thread _id_40E0(self);
  waitframe();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_40D9() {
  if(!isDefined(level._id_8D0B)) {
    return;
  }
  self endon("death");
  self endon("explode");
  self endon("collision");
  self endon("emp_defused");
  self endon("trophy_blocked");

  for(;;) {
    if(_id_40CB(level._id_8D0B)) {
      self notify("explode");
      break;
    }

    waitframe();
  }
}

_id_40CB(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(self istouching(var_3)) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_40C3() {
  self endon("explode");
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.75);
  self _meth_8654(1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.25);
  thread _id_40D9();
}

_id_40D7(var_0) {
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("cruise_missile_finished");
  level waittill("game_ended");
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
}

_id_40DD(var_0) {
  self endon("death");

  for(;;) {
    self._id_9F71 = var_0.origin;
    self._id_9F70 = var_0.angles;
    waitframe();
  }
}

_id_40DC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_2;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = var_0.streakinfo;
  var_10 = var_0 _id_40D4("collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked");

  if(isDefined(var_4)) {
    _id_079B::_id_EEDE(var_4);
  }

  if(isDefined(var_5)) {
    _id_079B::_id_EEDE(var_5);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "CPUnMarkEnemies")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "CPUnMarkEnemies")]](var_1);
  }

  if(isDefined(self)) {
    var_7 = self._id_9F71;
    var_8 = self._id_9F70;

    if(isDefined(var_1)) {
      var_1 _meth_8060();
      var_1 _meth_8095();
    }

    if(isDefined(var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_102C5(var_0);
      scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(var_0);
    }

    if(!isDefined(var_10) || var_10._id_A2B9 != "emp_defused" && var_10._id_A2B9 != "trophy_blocked") {
      var_11 = 600;
      var_12 = "MOD_EXPLOSIVE";
      var_13 = "cruise_proj_mp";

      if(isDefined(var_1)) {
        var_14 = isDefined(var_10) && var_10._id_A2B9 == "disowned";

        if(!istrue(var_14)) {
          self radiusdamage(var_7, var_11, 1000, 1000, var_1, var_12, var_13);
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
    thread _id_40CA(var_10);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "eventRecord")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "eventRecord")]](var_7);
  }

  if(isDefined(var_1)) {
    var_1 thread _id_40DA(var_10);

    if(!istrue(var_3)) {
      if(isDefined(var_1._id_E061)) {
        var_1._id_E061 stoploopsound("iw8_cruise_missile_plr");
        var_1._id_E061 delete();
      }

      var_1 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(var_9.streakname, "off");
      var_1 setclientomnvar("ui_predator_missile", 0);
      var_19 = 1;
      var_20 = spawn("script_model", var_7);
      var_20 setModel("tag_player");
      var_21 = getdvarint("#x33d3aee96a2edee51", 1000);
      var_22 = getdvarint("#x31d85af254b31c4a", 0);
      var_23 = anglesToForward(var_8);
      var_24 = var_7 - var_23 * var_21;
      var_25 = (0, 0, var_22);
      var_26 = var_24 + var_25;
      var_20.angles = vectortoangles(var_7 + (0, 0, 150) - var_26);
      var_6 unlink();
      var_6 linkto(var_20, "tag_player", (0, 0, 0), (0, 0, 0));

      if(scripts\cp_mp\utility\game_utility::isnightmap()) {
        var_1 scripts\cp_mp\utility\player_utility::_id_D720(0);
      }

      var_20.origin = var_26;
      var_1 cameralinkto(var_20, "tag_origin");
      var_27 = "cruise_predator_static";

      if(var_19 == 2) {
        var_27 = "cruise_predator_flash";
      }

      var_1 thread _id_40D2(0.4, 0.6, 0.05, var_27);
      var_28 = scripts\common\utility::_id_B7BF(var_7, 2000);

      foreach(var_17 in var_28) {
        if(!isDefined(var_17) || !var_17 scripts\cp_mp\utility\player_utility::_isalive() || var_17 == var_1) {
          continue;
        }
        var_17 earthquakeforplayer(0.3, 2, var_17.origin, 100);
        var_17 setclientomnvar("ui_hud_shake", 1);
        var_17 _meth_827A("artillery_rumble", var_17.origin);
      }

      var_1 earthquakeforplayer(0.3, 3, var_1.origin, 100);
      var_1 setclientomnvar("ui_hud_shake", 1);
      var_1 _meth_827A("artillery_rumble", var_1.origin);
      wait 0.5;
      var_1 notify("cruise_missile_finished");
      var_1 _id_40CF(var_9, var_20);
      var_1 scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_9);
    }
  }

  if(isDefined(var_6)) {
    var_6 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "removeItemFromSlot")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "removeItemFromSlot")]](var_1);
  }
}

_id_40BF(var_0, var_1) {
  self moveto(var_0, 0.2, 0, 0.05);
  wait 0.15;
  self moveto(var_0 + vectornormalize(var_1 - var_0) * 24, 2);
}

_id_40CF(var_0, var_1) {
  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_0);
  }

  _id_09C8::_id_0D89();
  self _meth_8060();
  var_1 delete();
  self visionsetkillstreakforplayer("");
  scripts\common\utility::_id_153E(1);
  scripts\common\utility::_id_1554(1);
  scripts\common\utility::_id_1593(1);
  scripts\common\utility::_id_158A(1);
  scripts\common\utility::_id_157E(1);
  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::_id_8DBA();
  level thread scripts\cp_mp\utility\killstreak_utility::_id_C70C(self);
  var_0 notify("killstreak_finished_with_deploy_weapon");
}

_id_40E0(var_0) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10.1);
  self notify("explode", self.origin);
}

_id_40D6(var_0, var_1) {
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

_id_40DB(var_0) {
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

_id_40DF(var_0) {
  self endon("death");
  self endon("disowned");
  level endon("game_ended");
  var_1 = self.owner;
  var_1 waittill(var_0);
  self notify("disowned");
}

_id_40D1() {
  self visionsetkillstreakforplayer("cruise_predator_slamzoom", 0.05);
  wait 0.1;
  self visionsetkillstreakforplayer("", 0.05);
}

_id_40D2(var_0, var_1, var_2, var_3) {
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

_id_40D0(var_0) {
  self endon("disconnect");
  var_1 = 0;

  while(var_1 < var_0) {
    self _meth_827A("damage_light", self.origin);
    var_1 = var_1 + 0.05;
    wait 0.05;
  }
}

_id_40D4(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
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
  self endon("death");
  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  var_1 notify("returned", var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_40CA(var_0) {
  self endon("death");
  self unlink();

  if(!isDefined(var_0) || var_0._id_A2B9 == "explode" || var_0._id_A2B9 == "disowned" || var_0._id_A2B9 == "emp_defused" || var_0._id_A2B9 == "trophy_blocked") {
    self setscriptablepartstate("air_explosion", "on", 0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.2);
    self delete();
  }

  var_1 = (0, 0, 1);
  var_2 = var_0._id_AE45;
  self.angles = vectortoangles(var_2);
  var_3 = vectordot(var_2, var_1);

  if(var_3 >= 0.7) {
    self setscriptablepartstate("ground_explosion", "on", 0);
  } else {
    self setscriptablepartstate("air_explosion", "on", 0);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self delete();
}

_id_40DA(var_0) {
  self endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(isDefined(self) && isDefined(self._id_C0F3)) {
    if(self._id_C0F3 >= 1) {
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("cruise_kill", 1);
    } else {
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("cruise_miss", 1);
    }
  }
}

_id_40C4(var_0, var_1) {
  self endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(!istrue(var_1)) {
    self visionsetkillstreakforplayer("cruise_predator_slamzoom", 0.1);
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 1, 0.2);
    wait 0.2;
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0);
  }
}

_id_40C7(var_0) {
  if(isDefined(self)) {
    self notify("emp_defused");
  }
}