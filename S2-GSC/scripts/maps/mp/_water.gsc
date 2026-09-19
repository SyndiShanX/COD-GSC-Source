/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_water.gsc
**************************************/

init() {
  if(isDefined(level.water_wake))
    level._effect["water_wake"] = loadfx(level.water_wake);
  else
    level._effect["water_wake"] = loadfx("vfx/treadfx/body_wake_water");

  if(isDefined(level.water_wake_stationary))
    level._effect["water_wake_stationary"] = loadfx(level.water_wake_stationary);
  else
    level._effect["water_wake_stationary"] = loadfx("vfx/treadfx/body_wake_water_stationary");

  if(isDefined(level.water_splash_emerge))
    level._effect["water_splash_emerge"] = loadfx(level.water_splash_emerge);
  else
    level._effect["water_splash_emerge"] = loadfx("vfx/water/body_splash_exit");

  if(isDefined(level.water_splash_enter))
    level._effect["water_splash_enter"] = loadfx(level.water_splash_enter);
  else
    level._effect["water_splash_enter"] = loadfx("vfx/water/body_splash");

  _func_13E("underwater");

  if(!isDefined(level._id_A968))
    level._id_A968 = [];

  if(!isDefined(level._id_A969))
    level._id_A969 = 0;

  if(!isDefined(level._id_8ACF)) {
    if(isDefined(level._id_585D) && level._id_585D)
      _id_8720("shovel_zm");
    else
      _id_8720("iw5_underwater_mp");
  }

  if(!isDefined(level._id_2B7C))
    _id_865D("iw5_underwater_mp");

  if(!isDefined(level._id_0C19))
    level._id_0C19 = 1;

  if(level._id_2B7C == level._id_8ACF)
    level._id_0C19 = 0;

  if(!isDefined(level._id_9545))
    level._id_9545 = 48;

  var_0 = getEntArray("trigger_underwater", "targetname");
  level._id_A964 = var_0;

  foreach(var_2 in var_0) {
    var_2 _id_278A();
    var_2 thread _id_A935();
  }

  level thread _id_2415(var_0);
  level thread _id_6B6E();
  setDvar("scr_ball_water_drop_delay", 10);
}

_id_7320(var_0) {
  if(var_0)
    self._id_5525 = 1;
  else
    self._id_5525 = undefined;
}

_id_A90E() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("player_migrated");

    foreach(var_1 in level._id_A968)
    self _meth_84E9(var_1._id_0165, var_1);
  }
}

_id_6B6E() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_A90E();

    foreach(var_2 in level._id_A968)
    var_0 _meth_84E9(var_2._id_0165, var_2);
  }
}

_id_278A() {
  var_0 = common_scripts\utility::_id_46B5(self.target, "targetname");
  var_0.origin = var_0.origin + (0, 0, level._id_A969);
  var_1 = var_0 common_scripts\utility::_id_8FFC();
  var_1 _meth_805B();

  if(isDefined(self._id_0165)) {
    var_1._id_0165 = self._id_0165;
    level._id_A968 = common_scripts\utility::_id_0F6F(level._id_A968, var_1);
  }
}

_id_2415(var_0) {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_1);
    var_2 = 0;

    foreach(var_4 in var_0) {
      if(var_1 istouching(var_4)) {
        var_2 = 1;
        break;
      }
    }

    if(!var_2) {
      var_1 _id_7320(0);
      var_1._id_A019 = undefined;
      var_1._id_542A = undefined;
      var_1 _meth_86C7();
      var_1._id_57F2 = undefined;
      var_1._id_5849 = undefined;
      var_1._id_A95F = undefined;
      var_1.watermovespeedscale = 1;
      var_1._id_57C9 = undefined;
      var_1 notify("out_of_water");
    }
  }
}

_id_A935() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0) && !_func_0C1(var_0)) {
      continue;
    }
    if(!isalive(var_0)) {
      continue;
    }
    if(var_0 _id_028D::_id_5855()) {
      continue;
    }
    if(!isDefined(var_0._id_5525)) {
      var_0 _id_7320(1);
      var_0 thread _id_740D(self);
    }
  }
}

_id_740D(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  thread _id_5526(var_0);
  thread _id_748F();
  self._id_3999 = 0;
  self._id_3997 = 0;

  for(;;) {
    if(maps\mp\_utility::isusingremote()) {
      if(isDefined(self._id_A019) && isDefined(self._id_57C9)) {
        self notify("stop_water_shellshock");
        self _meth_8184();
        self _meth_812A(1);
        self._id_57C9 = undefined;
      }
    } else if(isDefined(self._id_A019) && !isDefined(self._id_57C9)) {
      thread playerapplyshellshock();
      self _meth_812A(0);
    }

    if(!self istouching(var_0)) {
      _id_7320(0);
      self._id_A019 = undefined;
      self._id_542A = undefined;
      self _meth_86C7();
      self._id_57F2 = undefined;
      self.watermovespeedscale = 1;
      _id_0513::_id_A13B();
      self notify("out_of_water");
      self._id_5849 = undefined;

      if(!maps\mp\_utility::isusingremote()) {
        self _meth_8184();
        self _meth_812A(1);
        self._id_57C9 = undefined;
      }

      _id_73D6();
      maps\mp\_utility::_id_73AF(1);
      var_1 = distance(self _meth_833D(), (0, 0, 0));
      var_2 = (self.origin[0], self.origin[1], _id_471B(var_0));
      playFX(level._effect["water_splash_emerge"], var_2, anglesToForward((0, self.angles[1], 0) + (270, 180, 0)));
      break;
    }

    if(isDefined(self._id_542A) && _id_53CA(var_0, 32)) {
      self._id_542A = undefined;
      self.watermovespeedscale = 1;
      _id_0513::_id_A13B();
    }

    if(_id_53CA(var_0, 32)) {
      self._id_542A = undefined;

      if(isDefined(level._id_A96A))
        self.watermovespeedscale = level._id_A96A;
      else
        self.watermovespeedscale = 1;

      _id_0513::_id_A13B();
    }

    if(!isDefined(self._id_542A) && !_id_53CA(var_0, 32)) {
      self._id_542A = 1;
      self.watermovespeedscale = 0.7;
      _id_0513::_id_A13B();
    }

    if(!isDefined(self._id_A019) && (!_id_565D(var_0, 0) || isunderwaterprop())) {
      if(isDefined(self._id_1561) && self._id_1561 > 0) {
        self._id_1561--;
        waitframe();
        continue;
      }

      self._id_A019 = 1;

      if(isDefined(level._id_A96B))
        self thread[[level._id_A96B]]();
      else if(!(level.gametype == "prop" && self.team != game["defenders"]))
        thread _id_73F2();

      maps\mp\_utility::_id_73AF(0);

      if(!maps\mp\_utility::isusingremote()) {
        thread playerapplyshellshock();
        self _meth_812A(0);
      }

      var_3 = self getcurrentweapon();

      if(var_3 != "none") {
        var_4 = weaponinventorytype(var_3);

        if(var_4 == "primary" || var_4 == "altmode")
          self._id_A95F = var_3;
        else if(maps\mp\_utility::iskillstreakweapon(var_3))
          self._id_A95F = _id_051E::_id_73EB();
        else if(isDefined(self._id_5BC5) && self _meth_8319(self._id_5BC5))
          self._id_A95F = self._id_5BC5;
      }

      if(isDefined(level._id_3FC9))
        self[[level._id_3FC9]](var_0);
    }

    if(isDefined(self._id_A019) && (isDefined(self._id_57F2) || !isDefined(self._id_5849)) && (_id_53CA(var_0, level._id_9545) || self _meth_8178() == "prone" || !level._id_0C19)) {
      self._id_5849 = 1;
      self _meth_86C6();
      self._id_57F2 = undefined;
      _id_73D6();

      if(isDefined(self._id_5738) && self._id_5738 == 1) {
        _id_73DE("none");
        self _meth_812B(0);
        self _meth_84CB();
      } else if(!isDefined(level._id_585D) || !_func_2BF(self))
        _id_73DE("shallow");
    }

    if(isDefined(self._id_A019) && (isDefined(self._id_5849) || !isDefined(self._id_57F2)) && (!_id_53CA(var_0, level._id_9545) && self _meth_8178() != "prone" && level._id_0C19)) {
      self _meth_86C6();
      self._id_57F2 = 1;
      self._id_5849 = undefined;
      _id_73D6();

      if(isDefined(self._id_5738) && self._id_5738 == 1) {
        _id_73DE("none");
        self _meth_812B(0);
        self _meth_84CB();
      } else if(!isDefined(level._id_585D) || !_func_2BF(self))
        _id_73DE("deep");
    }

    if(isDefined(self._id_1561))
      self._id_1561 = getdvarint("scr_ball_water_drop_delay", 10);

    if(isDefined(self._id_A019) && _id_565D(var_0, 0) && !isunderwaterprop()) {
      self._id_A019 = undefined;
      self _meth_86C7();
      self._id_57F2 = undefined;
      self._id_5849 = undefined;
      self notify("above_water");
      var_1 = distance(self _meth_833D(), (0, 0, 0));
      var_2 = (self.origin[0], self.origin[1], _id_471B(var_0));
      playFX(level._effect["water_splash_emerge"], var_2, anglesToForward((0, self.angles[1], 0) + (270, 180, 0)));

      if(!maps\mp\_utility::isusingremote()) {
        self _meth_8184();
        self _meth_812A(1);
        self._id_57C9 = undefined;
      }

      _id_73D6();
      maps\mp\_utility::_id_73AF(1);
    }

    waitframe();
  }
}

isunderwaterprop() {
  var_0 = level.gametype == "prop";
  var_1 = self.team == game["defenders"];
  var_2 = maps\mp\_utility::_id_4571() != "mp_wolfslair";
  return var_0 && var_1 && var_2;
}

playerapplyshellshock() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("stop_water_shellshock");
  self endon("out_of_water");
  self endon("above_water");
  self._id_57C9 = 1;

  for(;;) {
    self _meth_8182("underwater", 19, undefined, 0);
    wait 19;
  }
}

_id_5660(var_0) {
  if(isDefined(var_0._id_5A69)) {
    var_1 = self.pers["killstreaks"][self._id_5A69]._id_944C;

    if(isDefined(var_1)) {
      if(issubstr(var_1, "turret") || issubstr(var_1, "sentry"))
        return 1;
    }
  }

  return 0;
}

_id_748F() {
  var_0 = common_scripts\utility::_id_A715("death", "out_of_water");

  if(isDefined(self)) {
    self._id_A01A = undefined;
    self._id_3236 = undefined;
    _id_7320(0);
    self._id_A019 = undefined;
    self._id_542A = undefined;
    self._id_A95F = undefined;
    self.watermovespeedscale = 1;
    _id_0513::_id_A13B();
  }
}

inwaterwakevfxcleanup() {
  self endon("inWaterWakeVFXCleanup");

  if(_func_1EF(self)) {
    maps\mp\agents\_agent_utility::deleteentonagentdeath(self.fxentwake);
    maps\mp\agents\_agent_utility::deleteentonagentdeath(self.fxentstationary);
  }

  if(!isDefined(self.waterwakevfxdeletefunc))
    self.waterwakevfxdeletefunc = ::waterwakevfxdelete;

  common_scripts\utility::_id_A70C(self, "death", level, "game_ended", self, "disconnect", self, "out_of_water", self.fxentwake, "entitydeleted", self.fxentstationary, "entitydeleted");
  thread waterwakevfxdelete();
}

waterwakevfxdelete() {
  self notify("inWaterWakeVFXCleanup");
  self notify("out_of_water");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.fxentwake))
    self.fxentwake delete();

  if(isDefined(self.fxentstationary))
    self.fxentstationary delete();

  if(isDefined(self.waterwakevfxdeletefunc))
    self.waterwakevfxdeletefunc = undefined;
}

_id_5526(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("out_of_water");
  var_1 = distance(self _meth_833D(), (0, 0, 0));

  if(var_1 > 90) {
    var_2 = (self.origin[0], self.origin[1], _id_471B(var_0));
    playFX(level._effect["water_splash_enter"], var_2, anglesToForward((0, self.angles[1], 0) + (270, 180, 0)));
  }

  var_3 = _func_2A8(common_scripts\utility::_id_44F5("water_wake"), self, "tag_origin");
  var_4 = _func_2A8(common_scripts\utility::_id_44F5("water_wake_stationary"), self, "tag_origin");
  self.fxentwake = var_3;
  self.fxentstationary = var_4;
  thread inwaterwakevfxcleanup();
  _func_14C(var_3);
  _func_14C(var_4);
  var_5 = 0;
  var_6 = 4000;

  for(;;) {
    var_7 = self _meth_833D();
    var_1 = distance(var_7, (0, 0, 0));

    if(var_1 > 0)
      wait(max(1 - var_1 / 120, 0.1));
    else
      wait 0.3;

    var_8 = _id_471B(var_0) - self.origin[2];

    if((self _meth_8178() == "prone" && var_8 > 24) == 0) {
      if(var_1 > 5) {
        _func_14C(var_3);
        continue;
      }

      _func_14C(var_4);
    }
  }
}

_id_73F2() {
  level endon("game_ended");
  self endon("death");
  self endon("stopped_using_remote");
  self endon("disconnect");
  self endon("above_water");
  self endon("out_of_water");
  thread _id_6B74();
  wait 13;

  for(;;) {
    if(!isDefined(self._id_5738) || self._id_5738 == 0)
      self _meth_8059(20, self.origin + anglesToForward(self.angles) * 5, undefined, undefined, "MOD_TRIGGER_HURT");

    wait 1;
  }
}

_id_6B74() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("above_water");
  self endon("out_of_water");
  self waittill("death");
  _id_7320(0);
  self._id_A019 = undefined;
  self._id_542A = undefined;
  self _meth_86C7();
  self._id_57F2 = undefined;
  self._id_5849 = undefined;
  self._id_A95F = undefined;
  self._id_A01A = undefined;
  self._id_3997 = 0;
  self._id_3999 = 0;
}

_id_53CA(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 32;

  if(level _id_471B(var_0) - self.origin[2] <= var_1)
    return 1;

  return 0;
}

_id_565D(var_0, var_1) {
  if(_id_4620() + var_1 >= level _id_471B(var_0))
    return 1;
  else
    return 0;
}

_id_4620() {
  var_0 = self getEye();
  self._id_3997 = var_0[2] - self._id_3999;
  self._id_3999 = var_0[2];
  return var_0[2];
}

_id_471B(var_0) {
  var_1 = common_scripts\utility::_id_46B5(var_0.target, "targetname");
  var_2 = var_1.origin[2];
  return var_2;
}

_id_5728() {
  return isDefined(self._id_5378) && self._id_5378;
}

_id_73DE(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("end_swimming");

  if(!isDefined(var_0))
    var_0 = "shallow";

  if(var_0 == "shallow" && self _meth_8319(level._id_8ACF) || var_0 == "deep" && self _meth_8319(level._id_2B7C) || isDefined(level._id_2F6B))
    self._id_3236 = 1;

  switch (var_0) {
    case "deep":
      _id_476D(level._id_2B7C);

      if(!_id_5728())
        self _meth_831B(level._id_2B7C);

      self._id_A01A = "deep";
      break;
    case "shallow":
      _id_476D(level._id_8ACF);

      if(!_id_5728())
        self _meth_831B(level._id_8ACF);

      self._id_A01A = "shallow";
      break;
    case "none":
      self._id_A01A = "none";
      break;
    default:
      _id_476D(level._id_8ACF);

      if(!_id_5728())
        self _meth_831B(level._id_8ACF);

      self._id_A01A = "shallow";
      break;
  }

  self _meth_82CD();
  common_scripts\utility::_id_0603();
  common_scripts\utility::_disableoffhandweapons();
}

_id_73D6() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(isDefined(self._id_A01A)) {
    var_0 = self._id_A01A;
    self notify("end_swimming");
    self _meth_82CE();
    common_scripts\utility::_id_0617();
    common_scripts\utility::_id_0614();

    if(isDefined(self._id_5738) && self._id_5738 == 1 && isDefined(self._id_4C26)) {
      self _meth_812B(1);

      if(!isDefined(self._id_4C26._id_4B77) || self._id_4C26._id_4B77 == 0)
        self _meth_8324();

      if(!isDefined(self._id_4C26._id_4B8E) || self._id_4C26._id_4B8E == 0)
        self _meth_84CB();
      else
        self _meth_84CC();
    } else if(isDefined(self._id_A95F)) {
      if(!_id_5728())
        maps\mp\_utility::_id_955C(self._id_A95F);
    }

    switch (var_0) {
      case "deep":
        _id_95CF(level._id_2B7C);
        break;
      case "shallow":
        _id_95CF(level._id_8ACF);
        break;
      case "none":
        break;
      default:
        _id_95CF(level._id_8ACF);
        break;
    }

    self._id_A01A = undefined;
    self._id_3236 = undefined;
  }
}

_id_476D(var_0) {
  if(!isDefined(self._id_3236) || !self._id_3236)
    self giveweapon(var_0);
}

_id_95CF(var_0) {
  if(!isDefined(self._id_3236) || !self._id_3236)
    self takeweapon(var_0);
}

_id_8720(var_0) {
  level._id_8ACF = var_0;
}

_id_865D(var_0) {
  level._id_2B7C = var_0;
}

_id_5840(var_0) {
  switch (var_0) {
    case "combatknife_zm":
    case "iw5_underwater_mp":
    case "shovel_zm":
    case "boxing_gloves_mp":
    case "baseballbat_mp":
    case "trenchknife_mp":
    case "combatknife_mp":
    case "icepick_mp":
    case "shovel_mp":
    case "none":
      return 1;
    default:
      return 0;
  }
}