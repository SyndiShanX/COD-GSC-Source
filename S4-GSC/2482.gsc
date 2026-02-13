/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2482.gsc
*************************************************/

init() {
  level._effect["airstrike_death"] = loadfx("vfx/s4/killstreaks/vfx_airstrike_death_exp_medium.vfx");
  level._effect["firebombing_impact"] = loadfx("vfx/s4/killstreaks/vfx_firebomb_imp_exp_rnr.vfx");
  level._id_0F6C = [];
  level._id_0F6B = [];
  level._id_10E0A = getent("white_phosphorus_damage", "targetname");
}

_id_10F9E() {
  self endon("disconnect");
  level endon("game_ended");
  self setclientomnvar("ui_airspace_crowded_firebombing", 1);

  while(istrue(level._id_10FA1)) {
    waitframe();
  }

  self setclientomnvar("ui_airspace_crowded_firebombing", 0);
}

_id_F7A9(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("#x36894c5b0c08cd4b7", 1) == 0) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DD3)) {
    level[[level._id_8DD3]](var_0);
  }

  if(istrue(level._id_10FA1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/FIREBOMBING_ACTIVE");
    }

    return 0;
  }

  if(istrue(level._id_13DD)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    _id_0A8D::_id_9137("airspace_crowded");
    return 0;
  }

  var_1 = makeweapon("s4_binoculars_mp", ["spotterscope"]);
  var_2 = _id_09B9::_id_EA03(var_0, var_1, "weapon_fired", undefined, ::_id_10DDF, ::_id_10D80);

  if(!istrue(var_2)) {
    return 0;
  }

  var_3 = _id_D050(var_0);

  if(!istrue(var_3)) {
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("white_phosphorus", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_white_phosphorus", self);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
  }

  return 1;
}

_id_10F84(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  level._id_10FA1 = 1;
  thread _id_10F9E();

  foreach(var_6, var_3 in var_0) {
    var_4 = var_3._id_96CF;
    var_5 = var_3.angles;
    _id_10F68(var_4, var_5, var_1);

    if(var_0.size > 1 && var_6 < var_0.size - 1) {
      wait(randomfloatrange(1, 3.0));
    }
  }
}

_id_10F68(var_0, var_1, var_2) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  thread _id_10F91("disconnect");
  thread _id_10F91("joined_team");
  thread _id_10F91("joined_spectator");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  var_3 = _id_10F5B(var_0, var_1, var_2);

  if(!isDefined(var_3)) {
    return 0;
  }

  var_3._id_873F = 1;
  var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "monitorDamage")]](100, "hitequip", ::_id_10F73, undefined, 1);
  var_3 thread _id_10F9A();
  var_3 thread _id_10F62(var_2);
}

_id_10F91(var_0, var_1) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  self waittill(var_0);
  level._id_10FA1 = undefined;
  level notify("white_phosphorus_end");
  _id_0A2D::_id_F2DA(self, undefined);
}

_id_10F5B(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_4 = 28000;
  var_5 = 5000;
  var_6 = 2500;
  var_7 = 1500;
  var_8 = (0, var_1, 0);

  if(!isDefined(var_3)) {
    var_6 = var_6 + 3000;
  } else {
    var_6 = var_3.origin[2] + 3000;
    var_7 = _id_09AB::_id_6A21(var_6);
  }

  var_9 = _id_09AB::_id_6A4E(var_0, var_8, var_4, var_3, var_6, var_5, var_7);
  var_10 = spawn("script_model", var_9["startPoint"]);
  var_10.angles = var_8;
  var_10._id_5CF4 = var_9;
  var_10.owner = self;
  var_10.team = self.team;
  var_10.streakinfo = var_2;
  var_10.speed = var_5;
  var_11 = "plane_ilima4";

  if(scripts\cp_mp\utility\player_utility::_id_6C67(self)) {
    var_11 = "plane_ilima4";
  }

  var_10 setModel(var_11);
  var_12 = undefined;
  var_13 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_13 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective");
  }

  if(isDefined(var_13)) {
    var_12 = var_10[[var_13]]("v_ui_icon_hud_minimap_killstreak03", var_10.team, 1, 1, 1);
    var_10._id_9F26 = var_12;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_10[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_10.streakinfo.streakname, "Killstreak_Air", self);
  }

  thread _id_084C::_id_5B63(var_10);
  return var_10;
}

_id_10F73(var_0) {
  var_1 = var_0.attacker;
  _id_10F63();
}

_id_10F63() {
  level notify("white_phosphorus_end");
  self notify("death");
  level._id_10FA1 = undefined;
  var_0 = anglesToForward(self.angles);
  playFX(level._effect["airstrike_death"], self.origin, var_0);
  playsoundatpos(self.origin, level._id_F902["directional_uav"]._id_E053);
  _id_10F7E(self);
}

_id_10F9A() {
  self endon("death");
  level waittill("white_phosphorus_end");
  _id_10F7E(self);
}

_id_10F62(var_0) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_1 = self._id_5CF4["startPoint"];
  var_2 = self._id_5CF4["endPoint"];
  var_3 = self._id_5CF4["flyTime"];
  var_4 = var_1 + anglesToForward(self.angles) * 17500;
  var_5 = var_2 - anglesToForward(self.angles) * 17500;
  var_6 = length(var_4 - var_5);
  var_7 = 30;
  self.owner thread _id_10F92(var_0, var_7);
  self.owner thread _id_10F99(var_0);
  self moveto(var_2, var_3);
  self setscriptablepartstate("bodyFX", "on", 0);
  self _meth_82CB("mp_suniform25_flyin");
  var_9 = 3;
  _id_10F72(var_0, ::_id_10F6B, var_1, var_4, var_6, var_7, 300, 24);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3);
  self _meth_83F8();
  self _meth_82CC("mp_suniform25_exit");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5.33);
  _id_0A2D::_id_F2DA(self.owner, undefined);
  _id_10F7E(self);
}

_id_10F72(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = int(var_4 / var_6);
  var_10 = 0;

  if(!isDefined(var_7)) {
    var_7 = var_9;
  } else {
    var_11 = var_9 - var_7;
    var_10 = int(var_11 / 2);
  }

  if(isDefined(var_8)) {
    var_10 = var_10 + var_8;
  }

  var_12 = anglesToForward(self.angles);
  var_13 = anglestoright(self.angles);
  var_14 = var_3;
  thread _id_084C::_id_5B60(var_7);
  var_15 = 0;

  for(var_16 = 0; var_16 < var_9; var_16++) {
    var_17 = length(var_2 - var_14) / self.speed;

    if(var_16 < var_10) {
      var_14 = var_14 + var_12 * var_6;
      continue;
    }

    var_18 = randomintrange(-256, 256);
    var_19 = var_14 - (0, 0, 500) + var_13 * var_18;
    self thread[[var_1]](var_19, var_12, var_17, var_0);
    var_14 = var_14 + var_12 * var_6;
    var_15++;

    if(var_15 == var_7) {
      break;
    }
  }
}

_id_10F6B(var_0, var_1, var_2, var_3) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);

  if(!isDefined(self)) {
    return;
  }
  var_4 = 512;
  var_5 = var_1 * var_4;
  var_0 = var_0 + var_5 * -1;
  var_6 = magicgrenademanual("s4_firebombing_run_mp", var_0, var_5, 5, self.owner);
  var_6 setmissileminimapvisible(1);
  var_6 setentityowner(self);
  var_6 setotherent(self);
  var_6._id_57B8 = spawn("script_model", var_6.origin);
  var_6._id_57B8 setModel("aae_ger_scharlie_50_00");
  var_6._id_57B8.angles = vectortoangles(anglestoup(var_6.angles) * -1);
  var_6._id_57B8 notsolid();
  var_6._id_57B8 setentityowner(self.owner);
  var_6._id_57B8 thread bombmovementrotation(var_6);
  var_7 = spawn("script_model", var_0);
  var_7 linkto(var_6, "tag_origin", (10, 0, 10), (0, 0, 0));
  var_6.killcament = var_7;
  var_6.owner = self.owner;
  var_6.team = self.team;
  var_6.angles = vectortoangles(var_1);
  var_6.streakinfo = var_3;
  var_6 thread _id_F30D();
  var_6 thread _id_F30E(vectortoangles(var_1), gettime(), var_1);
  var_6 thread toma_strike_watch_timeout(gettime());
}

bombmovementrotation(var_0) {
  self endon("death");
  var_0 endon("death");
  level endon("game_ended");
  var_1 = randomintrange(5, 15);

  for(;;) {
    self.origin = var_0.origin;
    self rotatepitch(var_1, 0.05);
    wait 0.05;
  }
}

toma_strike_abort_missile() {
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self setmissileminimapvisible(0);
  thread _id_F2FB(self.origin);
  self notify("missile_dest_failed");
}

toma_strike_watch_timeout(var_0) {
  self endon("missile_stuck");
  var_1 = 10;
  var_2 = scripts\engine\utility::_id_108F7("death", var_1);

  if(var_2 == "timeout") {
    toma_strike_abort_missile();
  } else {
    var_3 = gettime() - var_0;

    if(var_1 * 1000 > var_3) {
      wait(var_1 - var_3 / 1000);
    }
  }

  if(level._id_0F6B.size <= 0) {
    level._id_10FA1 = undefined;
  }
}

_id_F30D() {
  self endon("death");
  var_0 = self.owner;
  var_0 waittill("disconnect");
  toma_strike_abort_missile();
}

_id_F30E(var_0, var_1, var_2) {
  self endon("death");
  self endon("missile_dest_failed");
  self waittill("missile_stuck", var_3);
  self setmissileminimapvisible(0);
  wait 0.05;
  var_4 = -1 * getdvarint("#x33c01342f08fa6256", 800);
  var_5 = (gettime() - var_1) / 1000;
  var_6 = var_2 + (0, 0, var_4 * var_5);
  _id_F309(var_3, var_0, var_6);
  thread _id_E2ED(self.origin);
  thread _id_F2FB(self.origin);
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

_id_F2FB(var_0) {
  self endon("death");
  self._id_57CE = 1;
  self._id_57B8 unlink();
  self._id_57B8.origin = var_0;
  playFX(level._effect["firebombing_impact"], var_0);
  level notify("aud_firebomb_exp");
  thread _id_084C::_id_5B62(var_0, 30);
  thread _id_F2F2();

  if(isDefined(self._id_57B8)) {
    self._id_57B8 delete();
  }

  self delete();
}

_id_F2F2() {
  self endon("death");
  wait 0.05;
  self hide();
}

_id_E2ED(var_0) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_1 = self.owner;
  var_2 = self.team;
  var_3 = self.angles;
  var_4 = isDefined(level._id_10E0A);

  if(istrue(var_4)) {
    level._id_10E0A dontinterpolate();
    level._id_10E0A.owner = var_1;
    level._id_10E0A.team = var_2;
    level._id_10E0A.streakinfo = self.streakinfo;
  }

  var_5 = 30;
  var_6 = spawnStruct();
  var_6._id_4315 = var_0;
  var_6._id_5C71 = var_0;
  var_7 = spawn("script_model", var_0);
  var_7 setModel("ks_white_phosphorus_mp");
  var_7 setentityowner(var_1);
  var_7.angles = var_3;
  var_7.owner = var_1;
  var_7.team = var_2;
  var_7.streakinfo = self.streakinfo;
  var_7._id_EA6A = var_6;
  var_7.weapon_name = "s4_firebombing_run_mp";
  var_7 thread _id_10F94("burn");
  var_7 thread _id_10F7C(var_5, "burn", "surftype_none");

  if(istrue(var_4)) {
    level._id_10E0A.origin = (0, 0, 50000);
  }
}

_id_10F94(var_0) {
  self endon("death");
  level waittill("white_phosphorus_end");

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(_id_10F75("inner", self)) {
    level _id_10F7D("inner", self, var_0, 1);
  }

  self notify("stop_wp_status_effect");
  var_1 = 0;

  if(var_1) {
    self _meth_86BE();
  } else {
    self delete();
  }
}

_id_10F92(var_0, var_1) {
  self endon("disconnect");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  self notify("white_phosphorus_finished");
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
}

_id_10F99(var_0) {
  self endon("disconnect");
  self endon("white_phosphorus_finished");
  level endon("white_phosphorus_end");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
}

_id_10F79(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_1 = var_1 - var_2 * 3500;
  var_4 = var_1 - var_2 * 1000;
  self moveto(var_1, var_0 + 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0 + 2);
  self moveto(var_4, 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3);
  self delete();
}

_id_10F8D(var_0, var_1, var_2) {
  self endon("death");
}

_id_10F69(var_0, var_1, var_2) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_3 = var_0 - var_1 * 3000;
  var_4 = var_0 - var_1 * 2000;
  var_5 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  playFX(scripts\engine\utility::getfx("white_phosphorus_inair_explosion"), var_3, var_1);
}

_id_10F7C(var_0, var_1, var_2) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  self._id_BDA3 = 1;
  level _id_10F5A("inner", self);
  var_3 = self._id_EA6A._id_4315 + (0, 0, 10);

  if(isDefined(self.owner)) {
    self radiusdamage(var_3, 512, 500, 500, self.owner, "MOD_EXPLOSIVE", "s4_firebombing_run_mp");
  }

  if(isDefined(var_2) && var_2 != "surftype_water") {
    if(isDefined(var_1)) {
      self.killcament = spawn("script_model", self.origin + (0, 0, 100));

      if(var_1 == "burn") {
        thread _id_10F8F(300, "s4_firebombing_run_mp");
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
    level _id_10F7D("inner", self, var_1, 1);
    self notify("stop_wp_status_effect");
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  thread _id_10F60(15);
}

_id_10F61() {
  level endon("game_ended");
  var_0 = self._id_4349;
  self waittill("death");
  scripts\cp_mp\utility\killstreak_utility::_id_8DB2(var_0);
}

_id_10F60(var_0) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_1 = 0;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(var_1) {
    self _meth_86BE();
  } else {
    self delete();
  }
}

_id_10F90(var_0, var_1, var_2, var_3) {
  self endon("death");
  self._id_B7B7 = [];

  if(isDefined(var_1) && isDefined(var_2)) {
    thread _id_10F5F(0.15, 2000, var_1, var_3);
    thread _id_10F5F(0.25, undefined, var_2, var_3);
  } else {
    for(;;) {
      var_4 = scripts\common\utility::_id_B7B6(self.origin, var_0);
      var_5 = scripts\engine\utility::_id_1BA6(level.players, var_4);

      foreach(var_7 in var_4) {
        if(var_7 scripts\cp_mp\utility\killstreak_utility::_id_0C44("specialty_gasmask")) {
          continue;
        }
        if(!var_7 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        if(!_id_10F77("smoke", var_7, self)) {
          _id_10F59("smoke", var_7);
        }

        if(!istrue(var_7._id_10F9F)) {
          var_7 thread _id_10F85(self, var_3);
        }
      }

      foreach(var_7 in var_5) {
        if(!var_7 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        if(istrue(var_7._id_10F9F) && _id_10F77("smoke", var_7, self)) {
          var_7 thread _id_10F8B(self);
        }
      }

      waitframe();
    }
  }
}

_id_10F70(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(distance2dsquared(self.origin, var_4.origin) <= var_1 * var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_10F5F(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(isDefined(var_0) && var_0 > 0) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  }

  var_4 = var_2;

  if(isDefined(var_1) && var_1 > 0) {
    var_4 = _id_10F70(var_2, var_1);
  }

  foreach(var_6 in var_4) {
    if(var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
      _id_10F59("smoke", var_6);

      if(!istrue(var_6._id_10F9F)) {
        var_6 thread _id_10F85(self, var_3);
      }
    }

    var_6 thread _id_10F86(self, var_3);
  }
}

_id_10F8F(var_0, var_1) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self._id_B7BA = [];

  for(;;) {
    foreach(var_3 in level.players) {
      if(!var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distance2d(self.origin, var_3.origin) <= var_0 && scripts\engine\trace::ray_trace_passed(var_3 getEye(), self.origin + (0, 0, 30), var_3)) {
        if(!istrue(var_3._id_10F9D)) {
          var_3 thread _id_10F83(self, self.owner, var_1);
        }

        continue;
      }

      if(istrue(var_3._id_10F9D) && _id_10F77("inner", var_3, self)) {
        var_3 _id_10F89(self);
      }
    }

    waitframe();
  }
}

_id_10F5A(var_0, var_1) {
  if(var_0 == "smoke") {
    level._id_0F6C[level._id_0F6C.size] = var_1;
  } else {
    level._id_0F6B[level._id_0F6B.size] = var_1;
  }
}

_id_10F75(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "smoke") {
    foreach(var_4 in level._id_0F6C) {
      if(var_4 == var_1) {
        var_2 = 1;
        break;
      }
    }
  } else {
    foreach(var_4 in level._id_0F6B) {
      if(var_4 == var_1) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

_id_10F7D(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(var_0 == "smoke") {
    foreach(var_6 in level._id_0F6C) {
      if(var_6 == var_1) {
        continue;
      }
      var_4[var_4.size] = var_6;
    }

    level._id_0F6C = var_4;

    if(isDefined(var_1._id_B7B7)) {
      foreach(var_9 in var_1._id_B7B7) {
        if(!_id_10F76("smoke", var_9)) {
          var_9 thread _id_10F8B(var_1);
        }
      }
    }

    if(level._id_0F6C.size <= 0) {
      level._id_10FA1 = undefined;
    }
  } else {
    foreach(var_6 in level._id_0F6B) {
      if(var_6 == var_1) {
        continue;
      }
      var_4[var_4.size] = var_6;
    }

    level._id_0F6B = var_4;

    foreach(var_9 in var_1._id_B7BA) {
      if(!_id_10F76("inner", var_9)) {
        if(var_2 == "burn") {
          var_9 thread _id_10F89(var_1);
        }
      }
    }

    if(level._id_0F6B.size <= 0) {
      level._id_10FA1 = undefined;
    }
  }

  if(istrue(var_3)) {
    return;
  }
  var_15 = 0;

  if(var_15) {
    var_1 _meth_86BE();
  } else {
    var_1 delete();
  }
}

_id_10F76(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "smoke") {
    foreach(var_4 in level._id_0F6C) {
      if(_id_10F77(var_0, var_1, var_4)) {
        var_2 = 1;
        break;
      }
    }
  } else {
    foreach(var_4 in level._id_0F6B) {
      if(_id_10F77(var_0, var_1, var_4)) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

_id_10F77(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = undefined;

  if(var_0 == "smoke") {
    var_4 = var_2._id_B7B7;
  } else {
    var_4 = var_2._id_B7BA;
  }

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(var_6 == var_1) {
        var_3 = 1;
        break;
      }
    }
  }

  return var_3;
}

_id_10F59(var_0, var_1) {
  if(var_0 == "smoke") {
    self._id_B7B7[self._id_B7B7.size] = var_1;
  } else {
    self._id_B7BA[self._id_B7BA.size] = var_1;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "codcasterAddPhosphorousStatusEffect")) {
    var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "codcasterAddPhosphorousStatusEffect")]]();
  }
}

_id_10F80(var_0, var_1) {
  if(var_0 == "smoke") {
    var_2 = [];

    foreach(var_4 in self._id_B7B7) {
      if(var_4 == var_1) {
        continue;
      }
      var_2[var_2.size] = var_4;
    }

    self._id_B7B7 = var_2;
  } else {
    var_2 = [];

    foreach(var_4 in self._id_B7BA) {
      if(var_4 == var_1) {
        continue;
      }
      var_2[var_2.size] = var_4;
    }

    self._id_B7BA = var_2;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "codcasterRemovePhosphorousStatusEffect")) {
    var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "codcasterRemovePhosphorousStatusEffect")]]();
  }
}

_id_10F7F(var_0, var_1) {
  if(var_0 == "smoke") {
    foreach(var_3 in level._id_0F6C) {
      if(_id_10F77(var_0, var_1, var_3)) {
        var_3 _id_10F80(var_0, var_1);
      }
    }
  } else {
    foreach(var_3 in level._id_0F6B) {
      if(_id_10F77(var_0, var_1, var_3)) {
        var_3 _id_10F80(var_0, var_1);
      }
    }
  }
}

_id_10F86(var_0, var_1) {
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    var_0 _id_10F59("smoke", self);
    thread _id_10F85(var_0, var_1);
  }
}

_id_10F85(var_0, var_1) {
  var_0 endon("death");
  self endon("death_or_disconnect");
  self endon("stop_disorient");
  level endon("game_ended");
  self._id_10F9F = 1;

  while(isDefined(self.sessionstate) && self.sessionstate != "playing") {
    waitframe();
  }

  thread _id_10F8A(var_0);
  thread _id_10F78(var_0);
  _func_019D(scripts\engine\utility::getfx("white_phosphorus_screen"), self, "tag_eye", self);

  if(level.teambased && self.team == var_0.team || self == var_0.owner) {
    var_2 = 1;

    if(istrue(var_2)) {
      return;
    }
  }

  self._id_10FA0 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");
  }

  if(self.health > 10 && var_1 != "s4_smoke_gbr_n77_mp") {
    var_4 = _id_10F6E();
    _id_10F5E(var_4, var_0);
  }

  if(!_id_10F74()) {
    _id_525A();
  }
}

_id_10F5E(var_0, var_1) {
  if(istrue(self._id_61D4)) {
    return;
  }
  if(!isDefined(self._id_10FA0)) {
    self._id_10FA0 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");
    }
  }

  self dodamage(var_0, self.origin, var_1.owner, var_1, "MOD_EXPLOSIVE", "s4_firebombing_run_mp");
}

_id_10F87(var_0) {
  var_0 endon("death");
  self endon("death");
  level endon("game_ended");

  while(istrue(self._id_10F9F)) {
    wait(randomfloatrange(1, 3));
  }
}

_id_10F8A(var_0) {
  var_0 endon("death");
  self endon("stop_disorient");
  level endon("game_ended");
  self waittill("death");
  _id_10F8B(var_0, 1);
}

_id_10F8B(var_0, var_1) {
  level endon("game_ended");

  if(istrue(var_1)) {
    level _id_10F7F("smoke", self);
  } else {
    var_0 _id_10F80("smoke", self);
  }

  if(!_id_10F76("smoke", self) || istrue(var_1)) {
    if(istrue(self._id_10F9F)) {
      self._id_10F9F = undefined;

      if(scripts\cp_mp\utility\player_utility::_isalive()) {
        self visionsetnakedforplayer("", 2);
      }

      _func_02D1(scripts\engine\utility::getfx("white_phosphorus_screen"), self, "tag_eye", self);

      if(istrue(self._id_10FA0)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_block_health_regen");
        }

        self._id_10FA0 = undefined;
      }

      _id_4ACA();
      self notify("stop_disorient");
    }
  }
}

_id_10F83(var_0, var_1, var_2) {
  var_0 endon("death");
  self endon("stop_wp_burn");
  self endon("death");
  level endon("game_ended");

  if(level.teambased && self.team == var_0.team && self != var_0.owner) {
    var_3 = 1;

    if(istrue(var_3)) {
      return;
    }
  }

  var_0 _id_10F59("inner", self);
  self._id_10F9D = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "enableBurnFX")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "enableBurnFX")]](undefined, "active");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "enqueueCorpsetableFunc")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "enqueueCorpsetableFunc")]]("white_phosphorus_burning", ::_id_10F7A);
  }

  thread _id_10F8C(var_0);

  if(isDefined(var_2) && var_2 == "s4_smoke_gbr_n77_mp") {
    var_5 = 3;
  } else {
    var_5 = 10;
  }

  for(;;) {
    if(self.health <= var_5) {
      self notify("stop_degen");
    }

    self dodamage(var_5, self.origin, var_1, var_0, "MOD_FIRE", var_2);
    wait 0.5;
    var_5++;

    if(var_5 >= 20) {
      var_5 = 20;
    }

    self._id_8F9E = gettime();
  }
}

_id_10F89(var_0) {
  var_0 _id_10F80("inner", self);

  if(!_id_10F76("inner", self)) {
    _id_10F81();
    self notify("stop_wp_burn");
  }
}

_id_10F8C(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  _id_10F81(1);
}

_id_10F81(var_0) {
  if(istrue(self._id_10F9D)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "disableBurnFX")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "disableBurnFX")]](undefined, "active");
    }

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "dequeueCorpsetableFunc")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "dequeueCorpsetableFunc")]]("white_phosphorus_burning");
      }
    }

    self._id_10F9D = undefined;
  }

  if(istrue(self._id_10F9C)) {
    self._id_10F9C = undefined;

    if(_id_10F76("smoke", self)) {
      self visionsetnakedforplayer(_id_10F71(), 1);
    } else {
      self visionsetnakedforplayer("", 1);
    }
  }

  if(istrue(var_0)) {
    level _id_10F7F("inner", self);
  }
}

_id_10F7E(var_0) {
  if(isDefined(var_0._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0._id_9F26);
    }

    var_0._id_9F26 = undefined;
  }

  var_0 delete();
}

_id_10F71() {
  var_0 = "wp_smoke";
  var_1 = "wp_smoke_night";
  var_2 = var_0;

  if(scripts\cp_mp\utility\game_utility::isnightmap() || scripts\cp_mp\utility\game_utility::_id_894E()) {
    var_2 = var_1;
  }

  return var_2;
}

_id_10F78(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  self endon("stop_disorient");
  self endon("death");
  level endon("game_ended");
  var_1 = undefined;

  for(;;) {
    if(istrue(self._id_10F9F)) {
      var_2 = _id_10F71();

      if(!isDefined(var_1) || var_2 != var_1) {
        var_1 = var_2;
        self visionsetnakedforplayer(var_2, 2);
      }
    }

    waitframe();
  }
}

_id_10F6E() {
  var_0 = 50;
  var_1 = 10;

  if(_id_10F74()) {
    var_0 = var_0 * 0.5;
  }

  var_2 = self.health;
  var_3 = var_2 - var_0;

  if(var_3 < var_1) {
    var_0 = var_0 - (var_1 - var_3);
  }

  return var_0;
}

_id_10F7A(var_0) {
  var_0 setscriptablepartstate("wp_burning", "flareUp", 0);
}

_id_10F74() {
  return isDefined(self.perks) && isDefined(self.perks["specialty_tac_resist"]);
}

_id_525A() {
  if(!isDefined(self._id_983B)) {
    self._id_983B = 0;
  }

  self._id_983B++;

  if(self._id_983B == 1) {
    thread _id_E6E3();
  }
}

_id_4ACA() {
  if(!isDefined(self._id_983B)) {
    return;
  }
  self._id_983B--;

  if(self._id_983B == 0) {
    thread _id_E915();
    self._id_983B = undefined;
  }
}

_id_E6E3() {
  self endon("death_or_disconnect");
  self endon("clearLoopingCoughAudio");
  level endon("game_ended");

  for(;;) {
    var_0 = randomfloatrange(5, 7);

    if(!_id_983C()) {
      var_1 = "generic_cough_3_enemy_1";

      if(self.team == "allies") {
        if(isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
          var_2 = game["dialogue"]["allies_female_cough"].size;
          var_3 = randomint(var_2);
          var_1 = game["dialogue"]["allies_female_cough"][var_3];
        } else {
          var_2 = game["dialogue"]["allies_male_cough"].size;
          var_3 = randomint(var_2);
          var_1 = game["dialogue"]["allies_male_cough"][var_3];
        }
      } else if(isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female") {
        var_2 = game["dialogue"]["axis_female_cough"].size;
        var_3 = randomint(var_2);
        var_1 = game["dialogue"]["axis_female_cough"][var_3];
      } else {
        var_2 = game["dialogue"]["axis_male_cough"].size;
        var_3 = randomint(var_2);
        var_1 = game["dialogue"]["axis_male_cough"][var_3];
      }
    }

    wait(var_0);
  }
}

_id_E915() {
  self notify("clearLoopingCoughAudio");
}

_id_525B() {
  if(!isDefined(self._id_983D)) {
    self._id_983D = 0;
  }

  self._id_983D++;
}

_id_4ACB() {
  if(!isDefined(self._id_983D)) {
    return;
  }
  self._id_983D--;
}

_id_983C() {
  return isDefined(self._id_983D) && self._id_983D > 0;
}

_id_3956() {
  self notify("clearLoopingCoughAudio");
  self._id_983B = undefined;
  self._id_983D = undefined;
}

_id_10F7B(var_0) {
  var_0 setscriptablepartstate("impact_center", "on", 0);
  waitframe();
  var_0 setscriptablepartstate("impact_center", "off", 0);
}

_id_10DDF(var_0, var_1) {
  if(istrue(var_1)) {
    thread _id_13DC(var_0);
    thread _id_13D6(var_0, "v_ui_hud_marker_killstreak_02");
  }
}

_id_13D6(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("deploy_cancelled");
  self endon("deploy_fired");
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("ks_airstrike_marker_mp");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
    var_2._id_A908 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
  }

  var_2 setotherent(self);
  var_2 dontinterpolate();
  var_2 hide();
  var_3 = "icon_waypoint_airstrike";

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_2 _id_13D0(var_2._id_A908, var_3, self, 50);
  var_2 thread _id_13DB(self);
  var_2 thread _id_13D4(self);
  var_2 thread _id_13D5(self);
  var_2._id_FCB9 = 0;
  scripts\common\utility::_id_153E(0);

  for(;;) {
    if(_id_078D::_id_85B3() && istrue(var_2._id_FCB9)) {
      scripts\common\utility::_id_153E(0);
      var_2 hide();
      var_2 setscriptablepartstate("marker_scope", "off", 0);
      self notify("stop_update_marker");
      var_2._id_FCB9 = 0;
    }

    var_4 = self playerads();

    if(var_4 == 1 && !istrue(var_2._id_FCB9)) {
      if(!_id_078D::_id_85B3()) {
        scripts\common\utility::_id_153E(1);
        var_2 show();
        var_2 setscriptablepartstate("marker_scope", "on", 0);
        var_2 thread _id_13D3(self);
        var_2._id_FCB9 = 1;
      }
    } else if(var_4 < 1 && istrue(var_2._id_FCB9)) {
      scripts\common\utility::_id_153E(0);
      var_2 hide();
      var_2 setscriptablepartstate("marker_scope", "off", 0);
      self notify("stop_update_marker");
      var_2._id_FCB9 = 0;
    }

    waitframe();
  }
}

_id_13DB(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 waittill("death_or_disconnect");
  _id_13CF();
}

_id_13D4(var_0) {
  var_0 endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  var_1 = var_0 scripts\engine\utility::_id_10897("cancel_fire", "successful_fire");

  if(isDefined(var_1) && var_1 == "successful_fire") {
    var_0 notify("deploy_fired");
    self setscriptablepartstate("marker_scope", "off", 0);
    var_2 = anglesToForward(var_0 getplayerangles());
    var_3 = var_0 getEye();
    var_4 = vectornormalize(self.origin - var_3);
    var_5 = self.origin + var_4 * 20;
    var_6 = scripts\engine\trace::ray_trace(var_3, var_5, var_0);
    var_7 = var_6["normal"];
    self.angles = var_0.angles + (0, 90, 0);
    self.angles = _func_0316(var_7, self.angles);
    self setscriptablepartstate("marker_placed", "on", 0);
    _func_016B(self._id_A908, "current");
    thread _id_13CF(7);
  } else {
    var_0 notify("deploy_cancelled");
    var_0 notify("cancel_all_killstreak_deployments");

    if(!var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]()) {
      var_0 scripts\common\utility::_id_153E(1);
    }

    _id_13CF();
  }
}

_id_13D5(var_0) {
  var_0 endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  var_1 = var_0 getcurrentweapon();

  for(;;) {
    if(var_0 getcurrentweapon() != var_1) {
      break;
    }

    waitframe();
  }

  var_0 notify("cancel_fire");
}

_id_13CF(var_0) {
  if(isDefined(var_0)) {
    self endon("death");
    level endon("game_ended");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  }

  if(isDefined(self._id_A908)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self._id_A908);
    }
  }

  self delete();
}

_id_13D3(var_0) {
  self endon("death");
  var_0 endon("deploy_cancelled");
  var_0 endon("deploy_fired");
  var_0 endon("stop_update_marker");
  var_0 endon("death_or_disconnect");
  var_1 = 0;
  var_0 setclientomnvar("ui_spotter_scope_danger", 0);

  for(;;) {
    var_2 = _id_13C3(var_0);
    var_3 = -1;
    var_4 = -1;
    var_5 = -1;

    if(isDefined(var_2)) {
      self.origin = var_2;
      var_3 = int(self.origin[0]);
      var_4 = int(self.origin[1]);
      var_5 = int(self.origin[2]);
    }

    var_0 setclientomnvar("ui_ac130_coord3_posx", var_3);
    var_0 setclientomnvar("ui_ac130_coord3_posy", var_4);
    var_0 setclientomnvar("ui_ac130_coord3_posz", var_5);

    if(isDefined(var_2)) {
      if(!istrue(var_1) && distance2dsquared(var_0.origin, var_2) <= 1638400) {
        var_0 setclientomnvar("ui_spotter_scope_danger", 1);
        var_1 = 1;
      } else if(istrue(var_1) && distance2dsquared(var_0.origin, var_2) > 1638400) {
        var_0 setclientomnvar("ui_spotter_scope_danger", 0);
        var_1 = 0;
      }
    }

    waitframe();
  }
}

_id_13C3(var_0, var_1) {
  var_2 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicleclip"];
  var_3 = physics_createcontents(var_2);
  var_4 = var_0 getvieworigin();
  var_5 = var_4 + anglesToForward(var_0 getplayerangles()) * 50000;
  var_6 = var_0 scripts\cp_mp\utility\killstreak_utility::_id_B702();
  var_7 = scripts\engine\trace::ray_trace(var_4, var_5, var_6, var_3);
  var_8 = var_7["position"];

  if(var_7["hittype"] == "hittype_none") {
    var_8 = undefined;
  }

  return var_8;
}

_id_10D80(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_EEF2)) {
    var_3 = _id_13C3(self);

    if(!isDefined(var_3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");
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

  return "success";
}

_id_13D0(var_0, var_1, var_2, var_3) {
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

  _func_016B(var_0, "done");
}

_id_D050(var_0) {
  var_1 = (0, 0, 0);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = spawn("script_origin", self.origin);
  var_6 = "used_" + var_0.streakname;

  if(isDefined(var_0._id_EEF2)) {
    var_1 = var_0._id_EEF2;
  } else {
    var_1 = _id_13C3(self, 1);
  }

  thread finishfirebombusage(var_1, var_3, var_0);
  var_0 notify("killstreak_finished_with_deploy_weapon");
  self notify("successful_fire");
  return 1;
}

finishfirebombusage(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = spawnStruct();
  var_4._id_96CF = var_0;
  var_4.angles = var_2.owner.angles[1] + 90;
  var_4._id_EA52 = "confirm_location";
  var_3[var_3.size] = var_4;
  _id_0A2D::_id_F2DA(self, 1);
  thread _id_10F84(var_3, var_2);
}

_id_13DC(var_0) {
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var_1 = scripts\engine\utility::_id_10897("cancel_deploy", "weapon_switch_started");

  if(!isDefined(var_1)) {
    return;
  }
  var_0 notify("killstreak_finished_with_deploy_weapon");
}