/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2478.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_support", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_support", "init")]]();
  }

  level._effect["chopper_support_explosion"] = loadfx("vfx/iw8_mp/killstreak/vfx_chopper_support_explosion.vfx");
  level._id_36E7 = [];
  _id_7F20();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_support", "set_vehicle_hit_damage_data")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_support", "set_vehicle_hit_damage_data")]]("chopper_support", 12);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_bolt_mp", 1, "chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_support", 36, "thermite_bolt_mp");
  }

  level._id_774A = scripts\cp_mp\utility\game_utility::_id_6B1A("ks_heli_entrance");
  level._id_774B = scripts\cp_mp\utility\game_utility::_id_6B1A("ks_heli_goal");
  level._id_774C = scripts\cp_mp\utility\game_utility::_id_6B1A("ks_heli_path");
  level._id_7D9F = 0;
  level._id_7DA5["allies"] = 0;
  level._id_7DA5["axis"] = 0;
}

_id_7F20() {
  game["dialog"]["chopper_support_light_damage"] = "chopper_support_health_high";
  game["dialog"]["chopper_support_med_damage"] = "chopper_support_health_med";
  game["dialog"]["chopper_support_heavy_damage"] = "chopper_support_health_low";
  game["dialog"]["chopper_support_engage_target"] = "chopper_support_engage";
  game["dialog"]["chopper_support_patrol"] = "chopper_support_patrol";
  game["dialog"]["chopper_support_flares"] = "chopper_support_flares";
  game["dialog"]["chopper_support_crash"] = "chopper_support_crash";
}

_id_F771(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056(var_0, self);
  return _id_F772(var_1);
}

_id_F772(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B()) {
    return 0;
  }

  var_1 = _id_09B9::_id_EA01(var_0, makeweapon("ks_gesture_generic_mp"));

  if(!istrue(var_1)) {
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    return 0;
  }

  level._id_7D9F++;
  var_2 = 1;

  if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
    var_2 = 2;
  }

  if(level._id_36E7.size >= var_2 || level._id_36E7.size + level._id_7D9F > var_2) {
    scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    level._id_7D9F--;
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::_id_88FE() && level.teambased) {
    var_3 = 1;
    level._id_7DA5[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::_id_6BAC(self.team, level._id_36E7) + level._id_7DA5[self.team] > var_3) {
      level._id_7D9F--;
      level._id_7DA5[self.team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_SUPPORT_HELO");
      }

      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  var_4 = _id_FE31(self, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("chopper_support", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_chopper_support", self);
  }

  return var_4;
}

_id_FE31(var_0, var_1) {
  var_2 = _id_E284(var_0, var_1);
  level._id_7D9F--;

  if(scripts\cp_mp\utility\game_utility::_id_88FE() && level.teambased) {
    level._id_7DA5[var_0.team]--;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  var_2 thread _id_E68D(var_0, var_1);

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_1);
  }

  return 1;
}

_id_E284(var_0, var_1) {
  var_2 = (0, 0, 1750);
  var_4 = var_0.origin - anglesToForward(var_0.angles) * 15000 + var_2;
  var_5 = var_0.origin + anglesToForward(var_0.angles) * 2000 + var_2;
  var_6 = var_0.angles;
  var_7 = getdvarint("#x34e21110d3061fa26", 45);
  var_9 = undefined;

  if(isDefined(level._id_774A) && level._id_774A.size > 0) {
    var_10 = randomint(level._id_774A.size);
    var_11 = level._id_774A[var_10];
    var_9 = _id_36BF(var_11._id_0399, level._id_774B);

    if(isDefined(var_9)) {
      var_12 = var_11.origin * (1, 1, 0) + var_2;
      var_13 = var_9.origin * (1, 1, 0) + var_2;
      var_14 = vectornormalize(var_13 - var_12);
      var_4 = var_13 - var_14 * 15000;
      var_5 = var_13;
      var_6 = vectortoangles(var_14);
    } else {}
  } else {}

  var_21 = "veh8_mil_air_palfa";

  if(scripts\cp_mp\utility\player_utility::_id_6C67(var_0)) {
    var_21 = "veh8_mil_air_palfa_east";
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  var_22 = scripts\cp_mp\vehicles\vehicle_tracking::_id_0D7D(var_0, var_4, var_6, "veh_chopper_support_mp", var_21);

  if(!isDefined(var_22)) {
    return undefined;
  }

  var_22.speed = 100;
  var_22.accel = 50;
  var_22.lifetime = var_7;
  var_22.team = var_0.team;
  var_22.owner = var_0;
  var_22.angles = var_6;
  var_22.streakinfo = var_1;
  var_22.streakname = var_1.streakname;
  var_22._id_5C8A = 1;
  var_22._id_41BE = 0;
  var_22._id_AEE6 = var_4;
  var_22._id_AEDC = var_5;
  var_22._id_41AF = "patrol";
  var_22._id_41FB = undefined;
  var_22._id_41DF = var_9;
  var_22._id_7668 = var_2;
  var_22._id_3E69 = var_2[2] - 750;
  var_22._id_E521 = 50;
  var_22._id_E522 = 25;
  var_22._id_E523 = undefined;
  var_22._id_9F3C = 7;
  var_22._id_9F3D = 12;
  var_22 _meth_83A6(var_22.team);
  var_22.health = 3500;
  var_22.maxhealth = 3500;
  var_22 _id_0812::_id_C2B2("Killstreak_Air", var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var_1.streakname, "destroyed_chopper_support", undefined, "timeout_chopper_support", "callout_destroyed_chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var_1.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var_1.streakname, ::_id_36D0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var_1.streakname, ::_id_36C7);
  }

  level._id_36E7[level._id_36E7.size] = var_22;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1.streakname, "Killstreak_Air", var_0, 0, 1, 100);
  }

  var_22 setmaxpitchroll(15, 15);
  var_22 vehicle_setspeed(var_22.speed, var_22.accel);
  var_22 sethoverparams(50, 5, 2.5);
  var_22 setturningability(0.5);
  var_22 setyawspeed(100, 25, 25, 0.1);
  var_22 setotherent(var_0);
  var_22 setCanDamage(1);
  var_22 setneargoalnotifydist(768);
  var_22 setscriptablepartstate("blinking_lights", "on", 0);
  var_22 setscriptablepartstate("engine", "on", 0);
  var_23 = "veh8_mil_air_ahotel64_turret_wm";

  if(scripts\cp_mp\utility\player_utility::_id_6C67(var_0)) {
    var_23 = "veh8_mil_air_ahotel64_turret_wm_east";
  }

  var_22._id_5FE5 = spawnturret("misc_turret", var_22 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var_22._id_5FE5 setModel(var_23);
  var_22._id_5FE5.owner = var_0;
  var_22._id_5FE5.team = var_0.team;
  var_22._id_5FE5.angles = var_22.angles;
  var_22._id_5FE5.streakinfo = var_1;
  var_22._id_5FE5._id_F88D = 1;
  var_22._id_5FE5.name = "front_turret";
  var_22._id_5FE5._id_1DF2 = undefined;
  var_22._id_5FE5 linkto(var_22);
  var_22._id_5FE5 _meth_83A0(var_0.team);
  var_22._id_5FE5 _meth_839D(0);
  var_22._id_5FE5 setmode("manual");
  var_22._id_5FE5 setotherent(var_0);
  var_22._id_5FE5 setdefaultdroppitch(45);
  var_22._id_5FE5._id_71F1 = spawn("script_model", self.origin);
  var_22._id_5FE5._id_71F1 setModel("tag_origin");
  var_22._id_5FE5._id_71F1 dontinterpolate();
  var_22._id_C0C8 = spawnturret("misc_turret", var_22 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var_22._id_C0C8 setModel(var_23);
  var_22._id_C0C8.owner = var_0;
  var_22._id_C0C8.team = var_0.team;
  var_22._id_C0C8.angles = var_22.angles;
  var_22._id_C0C8.streakinfo = var_1;
  var_22._id_C0C8._id_F88D = 1;
  var_22._id_C0C8.name = "rear_turret";
  var_22._id_C0C8._id_1DF2 = undefined;
  var_22._id_C0C8 linkto(var_22);
  var_22._id_C0C8 _meth_83A0(var_0.team);
  var_22._id_C0C8 _meth_839D(0);
  var_22._id_C0C8 setmode("manual");
  var_22._id_C0C8 setotherent(var_0);
  var_22._id_C0C8 setdefaultdroppitch(45);
  var_22._id_C0C8._id_71F1 = spawn("script_model", self.origin);
  var_22._id_C0C8._id_71F1 setModel("tag_origin");
  var_22._id_C0C8._id_71F1 dontinterpolate();
  var_22.killcament = spawn("script_model", var_22 gettagorigin("tag_ground"));
  var_22.killcament linkto(var_22, "tag_ground", (-600, 0, 1000), (0, 0, 0));
  var_22._id_5FE5.killcament = var_22.killcament;
  var_22._id_C0C8.killcament = var_22.killcament;
  level notify("matchrecording_chopper", var_22);
  return var_22;
}

_id_E68D(var_0, var_1) {
  self endon("death");
  self setvehgoalpos(self._id_AEDC, 1);
  var_2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](var_0, var_1.streakname);
    var_2 = 2.0;
  }

  var_0 thread scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_1.streakname, 1, var_2);
  thread _id_36D2();
  thread _id_36D4();
  self _meth_827E("ks_chopper_support_approach");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](::_id_36C8);
  }
}

_id_36D2() {
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread _id_36CE();
    return;
  }

  self.owner scripts\engine\utility::waittill_any_2("joined_team", "disconnect");
  thread _id_36CE();
}

_id_36D4() {
  self endon("leaving");
  self endon("death");
  self waittill("near_goal");
  self vehicle_setspeed(int(self.speed / 2), int(self.accel / 3));
  thread _id_36E3();
  thread _id_36DC();
  thread _id_36E0();
  thread _id_36E1();
  thread _id_36D6(1);
  thread _id_36BA(self._id_5FE5);
  thread _id_36BA(self._id_C0C8);
}

_id_36C8(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 _meth_8174(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2._id_5C8A > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](var_2);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
        var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, var_3);
      }

      if(isDefined(var_2.streakinfo)) {
        var_2 scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_support_flares");
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

_id_36BA(var_0) {
  self endon("leaving");
  self endon("death");

  for(;;) {
    if(!istrue(var_0._id_F88D)) {
      waitframe();
      continue;
    }

    var_1 = _id_36C5(var_0, 6000, 1, 1);

    if(isDefined(var_1) && var_1.size > 0) {
      var_2 = _id_36B2(var_0, var_1);

      if(isDefined(var_2) && var_2 == "stopped_firing") {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
      }

      if(!_id_36B6()) {
        thread _id_36D6();
      }
    }

    wait 0.05;
  }
}

_id_36B2(var_0, var_1) {
  self notify("engaging_target");
  var_2 = undefined;
  [var_4, var_5, var_6] = _id_36C3(var_0, var_1);

  if(isDefined(var_4)) {
    var_7 = undefined;

    if(istrue(var_6)) {
      var_7 = var_4 scripts\cp_mp\utility\player_utility::getvehicle();
    }

    _id_36D9(var_0, var_4);

    if(istrue(var_5) && self._id_41FB == var_4) {
      thread _id_36D3(var_4, 1);
    }

    _id_36C0(var_0, var_4, var_7, 1, var_5);
    var_2 = "stopped_firing";
  } else
    var_2 = "continue_searching";

  return var_2;
}

_id_36D9(var_0, var_1) {
  var_0 _meth_8389(var_0._id_71F1);
  var_0._id_1DF2 = var_1;

  if(!isDefined(self._id_41FB)) {
    self._id_41FB = var_1;
    self setlookatent(self._id_41FB);
  }
}

_id_36B8(var_0) {
  if(isDefined(self._id_41FB) && self._id_41FB == var_0._id_1DF2) {
    self._id_41FB = undefined;
  }

  if(istrue(var_0._id_EE9C)) {
    var_0._id_EE9C = undefined;
  }

  var_0._id_1DF2 = undefined;
  var_0 _meth_8086();
  var_0._id_71F1 unlink();
  var_1 = _id_36C2();

  if(self._id_41AF != "patrol") {
    if(var_1.size == 0) {
      self _meth_807E();
    }
  }

  var_0 notify("lost_target");
}

_id_36C0(var_0, var_1, var_2, var_3, var_4) {
  if(self._id_41AF != "attacking") {
    self._id_41AF = "attacking";
  }

  if(istrue(var_3) && isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::_isalive() && (!isDefined(self._id_8FD6) || self._id_8FD6 + 15000 <= gettime())) {
    scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_support_engage_target");
    self._id_8FD6 = gettime();
  }

  _id_36DE(var_0);
  thread _id_36E2(var_0);
  thread _id_36E4(var_0, var_2);
  thread _id_36E6(var_0);
  thread _id_36DD(var_0);
  var_5 = weaponfiretime("chopper_support_turret_mp");
  var_6 = 0;
  var_7 = 100;

  if(isDefined(self._id_E521)) {
    var_7 = self._id_E521;
  }

  var_8 = 20;

  if(isDefined(self._id_9F3C)) {
    var_8 = self._id_9F3C;
  }

  var_9 = 40;

  if(isDefined(self._id_9F3D)) {
    var_9 = self._id_9F3D;
  }

  if(istrue(var_4)) {
    var_10 = 3750;

    while(istrue(_id_36B4(var_0, var_1))) {
      if(distance2dsquared(self.origin, var_1.origin) < var_10 * var_10) {
        break;
      }

      waitframe();
    }
  }

  thread _id_36E5(var_0);

  while(istrue(_id_36B4(var_0, var_1))) {
    if(istrue(var_0._id_EE9C)) {
      if(isDefined(self._id_41FB) && var_1 == self._id_41FB) {
        _id_36D3(self._id_41FB, 1);
      } else {
        var_0 notify("chopperSupport_targetBrokeLOS");
      }
    } else if(var_0 _id_36DB()) {
      var_11 = undefined;

      if(isDefined(var_2)) {
        var_11 = var_1.origin;
      } else {
        var_11 = var_1 gettagorigin("j_mainroot");
      }

      _id_36D8(var_0, var_1, var_11, var_7);

      if(var_6 == var_8) {
        var_7 = 50;

        if(isDefined(self._id_E522)) {
          var_7 = self._id_E522;
        }
      } else if(var_6 == var_9) {
        var_7 = undefined;

        if(isDefined(self._id_E523)) {
          var_7 = self._id_E523;
        }
      }

      var_0 _meth_83C1("tag_flash");
      var_6++;

      if(isDefined(var_0.streakinfo)) {
        var_0.streakinfo._id_DA63++;
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_5);
  }
}

_id_36B4(var_0, var_1) {
  return isDefined(self) && isDefined(var_0) && isDefined(var_1) && !isDefined(self._id_87D7) && !isDefined(self._id_8908) && isDefined(var_0._id_1DF2);
}

_id_36D8(var_0, var_1, var_2, var_3) {
  var_4 = var_2;

  if(isDefined(var_3)) {
    var_5 = [self, var_0];
    var_6 = randomint(var_3);
    var_7 = randomint(360);
    var_8 = var_2[0] + var_6 * cos(var_7);
    var_9 = var_2[1] + var_6 * sin(var_7);
    var_10 = var_2[2];
    var_4 = (var_8, var_9, var_10);
    var_0._id_71F1.origin = var_4;
  } else if(!var_0._id_71F1 _meth_81CC())
    var_0._id_71F1 linkto(var_1, "tag_origin", (0, 0, 30), (0, 0, 0));
}

_id_36DB() {
  var_0 = 0.992;
  var_1 = anglesToForward(self gettagangles("tag_flash"));
  var_2 = vectornormalize(self._id_71F1.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(isDefined(self _meth_817F(1)) && var_3 >= var_0) {
    return 1;
  }

  return 0;
}

_id_36DE(var_0) {
  thread _id_36DF(var_0, "death_or_disconnect");
  thread _id_36DF(var_0, "chopperSupport_maxAggroRange");
  thread _id_36DF(var_0, "chopperSupport_targetLeftRange");
  thread _id_36DF(var_0, "chopperSupport_targetBrokeLOS");
  thread _id_36DF(var_0, "chopperSupport_targetTimeout");
  thread _id_36DF(var_0, "chopperSupport_targetLastStand");
}

_id_36DF(var_0, var_1) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("crashing");
  var_0 endon("lost_target");
  var_2 = var_0;

  if(var_1 == "death_or_disconnect") {
    var_2 = var_0._id_1DF2;
  }

  var_2 waittill(var_1);
  _id_36B8(var_0);
}

_id_36E2(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var_0 endon("lost_target");

  if(!scripts\cp_mp\utility\game_utility::_id_88FD()) {
    return;
  }
  var_1 = self._id_AEDC;

  for(;;) {
    if(isDefined(var_0._id_1DF2)) {
      if(distance2dsquared(var_1, self.origin) > 100000000) {
        if(!istrue(self._id_79A7)) {
          self._id_79A7 = 1;
        }

        var_0 notify("chopperSupport_maxAggroRange");
        break;
      }
    }

    waitframe();
  }
}

_id_36E5(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var_0 endon("lost_target");

  for(;;) {
    if(isDefined(var_0._id_1DF2)) {
      var_1 = var_0._id_1DF2;

      if(distance2dsquared(var_0.origin, var_1.origin) > 20250000) {
        wait 2;
        var_0 notify("chopperSupport_targetLeftRange");
        break;
      }
    }

    waitframe();
  }
}

_id_36E4(var_0, var_1) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var_0 endon("lost_target");
  var_2 = undefined;
  var_3 = 500;
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_5 = [var_0];

  if(isDefined(var_1)) {
    var_5[var_5.size] = var_1;
    var_6 = var_1 _meth_8150();

    if(isDefined(var_6) && var_6.size > 0) {
      var_5 = scripts\engine\utility::array_combine(var_5, var_6);
    }
  }

  for(;;) {
    if(!istrue(var_0._id_EE9C) && isDefined(var_0._id_1DF2)) {
      var_7 = scripts\engine\trace::ray_trace_passed(var_0 gettagorigin("tag_barrel"), var_0._id_1DF2 gettagorigin("j_head"), var_5, var_4);

      if(!istrue(var_7)) {
        if(!isDefined(var_2)) {
          var_2 = gettime();
        }

        if(gettime() - var_2 > var_3) {
          var_0._id_EE9C = 1;
        }
      } else
        var_2 = undefined;
    }

    wait 0.25;
  }
}

_id_36E6(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var_0 endon("lost_target");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  var_0 notify("chopperSupport_targetTimeout");
}

_id_36DD(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var_0 endon("lost_target");

  for(;;) {
    if(isDefined(var_0._id_1DF2) && istrue(var_0._id_1DF2.inlaststand)) {
      var_0 notify("chopperSupport_targetLastStand");
      break;
    }

    waitframe();
  }
}

_id_36C9(var_0) {
  var_1 = 0;

  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(self._id_5FE5._id_1DF2)) {
    if(self._id_5FE5._id_1DF2 == var_0) {
      var_1 = 1;
    }
  }

  if(isDefined(self._id_C0C8._id_1DF2)) {
    if(self._id_C0C8._id_1DF2 == var_0) {
      var_1 = 1;
    }
  }

  return var_1;
}

_id_36B6() {
  return isDefined(self._id_5FE5._id_1DF2) || isDefined(self._id_C0C8._id_1DF2);
}

_id_36C2() {
  var_0 = [];

  if(isDefined(self._id_5FE5._id_1DF2)) {
    var_0[var_0.size] = self._id_5FE5._id_1DF2;
  }

  if(isDefined(self._id_C0C8._id_1DF2)) {
    var_0[var_0.size] = self._id_C0C8._id_1DF2;
  }

  return var_0;
}

_id_36D6(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("engaging_target");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  if(isDefined(self._id_AF47)) {
    self[[self._id_AF47]](var_0);
  } else {
    if(self._id_41AF != "patrol") {
      self._id_41AF = "patrol";
    } else if(self._id_41AF == "patrol" && !istrue(var_0)) {
      return;
    }
    self _meth_807E();
    var_1 = 500;

    if(_id_36CB()) {
      var_1 = 50;
    }

    self setneargoalnotifydist(var_1);
    var_2 = 0;

    for(;;) {
      if(self._id_41AF == "attacking") {
        if(!istrue(var_2)) {
          var_2 = 1;
        }

        waitframe();
        continue;
      }

      if(!istrue(var_0) && istrue(var_2)) {
        scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_support_patrol");
        var_2 = 0;
      }

      var_3 = _id_36BD();

      if(isDefined(var_3)) {
        _id_36D3(var_3, 1);
      } else {
        var_5 = [];
        var_6 = (0, 0, 0);
        var_7 = self._id_AEDC;

        foreach(var_9 in level.players) {
          if(var_9 == self.owner) {
            continue;
          }
          if(level.teambased && var_9.team == self.owner.team) {
            continue;
          }
          if(!var_9 scripts\cp_mp\utility\player_utility::_isalive()) {
            continue;
          }
          var_6 = var_6 + var_9.origin;
          var_5[var_5.size] = var_9;
        }

        if(isDefined(var_6) && var_5.size > 0) {
          var_11 = var_6 / var_5.size;
          _id_36D3(var_11);
        }
      }

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    }
  }
}

_id_36BD() {
  var_0 = scripts\engine\utility::array_combine(level._id_774B, level._id_774C);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(isDefined(self._id_41DF) && var_5 == self._id_41DF) {
      continue;
    }
    var_6 = distance2dsquared(var_5.origin, self.origin);

    if(!isDefined(var_3) || var_6 < var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(isDefined(var_2)) {
    var_1 = _id_36BF(var_2._id_0399, var_0);
    self._id_41DF = var_2;
  }

  return var_1;
}

_id_36B5(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 1, 0);
  var_3 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_origin")];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_4], self, var_2)) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

_id_36D3(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_2 = undefined;
  var_3 = var_0;

  if(!isvector(var_0)) {
    var_3 = var_0.origin;
  }

  var_4 = [self, self._id_5FE5, self._id_C0C8];

  for(;;) {
    var_5 = self.origin;
    var_6 = var_3 * (1, 1, 0) + (0, 0, self.origin[2]);
    var_7 = scripts\engine\trace::_id_E409(var_5, var_6, 256, var_4);
    var_8 = 0;
    var_9 = var_3[0];
    var_10 = var_3[1];

    if(isDefined(var_7)) {
      if(var_7["hittype"] != "hittype_none") {
        var_9 = var_7["position"][0];
        var_10 = var_7["position"][1];
        var_8 = 1;
      }
    }

    if(istrue(self._id_5688)) {
      var_11 = var_9 + randomintrange(-500, 500);
      var_12 = var_10 + randomintrange(-500, 500);
      var_13 = _id_6988(var_11, var_12, 350);
      var_2 = (var_11, var_12, var_13);
    } else {
      var_13 = _id_6988(var_9, var_10, 20);
      var_2 = (var_9, var_10, var_13);
    }

    var_14 = 0;

    if(istrue(var_1) && !istrue(var_8)) {
      var_14 = var_1;
    }

    self setvehgoalpos(var_2, var_14);
    scripts\engine\utility::waittill_any_2("near_goal", "begin_evasive_maneuvers");

    if(!istrue(var_8)) {
      break;
    }
  }
}

_id_36CE() {
  self endon("death");
  self _meth_827E("ks_chopper_support_leave");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self._id_8908 = 1;
  self _meth_807E();
  var_0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_0 = var_0 + (0, 0, 1000);
  self setvehgoalpos(var_0, 1);
  self setneargoalnotifydist(100);
  self waittill("near_goal");
  var_1 = _id_6C1C();
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(var_1, 1);
  self waittill("goal");
  self stoploopsound();
  self notify("chopperSupport_gone");
  thread _id_36B7();
}

_id_36B7(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - jackal", self.owner);
  }

  if(isDefined(self._id_5FE5)) {
    self._id_5FE5 setentityowner(undefined);
    self._id_5FE5._id_71F1 delete();
    self._id_5FE5 delete();
  }

  if(isDefined(self._id_C0C8)) {
    self._id_C0C8 setentityowner(undefined);
    self._id_C0C8._id_71F1 delete();
    self._id_C0C8 delete();
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self._id_3887)) {
    self[[self._id_3887]]();
  }

  if(isDefined(self.streakinfo)) {
    self.streakinfo._id_57A7 = istrue(var_0);
  }

  if(!istrue(self._id_C143)) {
    if(isDefined(self.streakinfo)) {
      self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);
    }
  }

  if(isDefined(level._id_36E7)) {
    level._id_36E7 = scripts\engine\utility::array_remove(level._id_36E7, self);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(self);
}

_id_36E3() {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self.lifetime);
  thread _id_36CE();
}

_id_36E0() {
  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  self._id_C143 = 1;

  if(isDefined(self.streakinfo)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);
  }

  thread _id_36CE();
}

_id_36E1() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(!scripts\cp_mp\utility\game_utility::_id_88FD()) {
    return;
  }
  for(;;) {
    if(istrue(self._id_79A7)) {
      self._id_5FE5._id_F88D = 0;
      self._id_C0C8._id_F88D = 0;
      var_0 = 8000;

      for(;;) {
        if(distance2dsquared(self.origin, self._id_AEDC) <= var_0 * var_0) {
          self._id_79A7 = undefined;
          self._id_5FE5._id_F88D = 1;
          self._id_C0C8._id_F88D = 1;
          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

_id_36C5(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("leaving");
  var_4 = [];
  var_5 = level.players;

  if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
    var_6 = 4500;

    if(isDefined(var_1)) {
      var_6 = var_1;
    }

    var_5 = scripts\common\utility::_id_B7BF(self.origin, var_6);
  }

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    var_8 = var_5[var_7];
    [var_10, var_11, var_12] = _id_36CC(var_0, var_8, var_2, var_3);

    if(istrue(var_10)) {
      var_13 = spawnStruct();
      var_13.player = var_8;
      var_13._id_CFB4 = var_11;
      var_13._id_EF0F = var_12;
      var_4[var_4.size] = var_13;
    } else
      continue;

    wait 0.05;
  }

  return var_4;
}

_id_36CC(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("leaving");

  if(!_id_36CA(var_1)) {
    return [0, 0, 0];
  }

  if(isDefined(self.owner) && var_1 == self.owner) {
    return [0, 0, 0];
  }

  if(!isDefined(var_1.pers["team"])) {
    return [0, 0, 0];
  }

  if(level.teambased && var_1.pers["team"] == self.team) {
    return [0, 0, 0];
  }

  if(var_1.pers["team"] == "spectator") {
    return [0, 0, 0];
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye")) {
      return [0, 0, 0];
    }
  }

  if(istrue(var_1.inlaststand)) {
    return [0, 0, 0];
  }

  if(_id_0797::_id_8970() && (var_1 _meth_86B8() || var_1 isskydiving())) {
    return [0, 0, 0];
  }

  var_5 = 0;

  if(istrue(var_2)) {
    if(distance2dsquared(self.origin, var_1.origin) > 20250000) {
      if(distance2dsquared(self.origin, var_1.origin) > 36000000) {
        return [0, 0, 0];
      }

      var_5 = 1;
    }
  }

  var_6 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_7 = [var_0];
  var_8 = 0;

  if(istrue(var_3)) {
    var_8 = var_1 scripts\cp_mp\utility\player_utility::isinvehicle();

    if(istrue(var_8)) {
      var_9 = var_1 scripts\cp_mp\utility\player_utility::getvehicle();
      var_7[var_7.size] = var_9;
      var_10 = var_9 _meth_8150();

      if(isDefined(var_10) && var_10.size > 0) {
        var_7 = scripts\engine\utility::array_combine(var_7, var_10);
      }
    }
  }

  var_11 = scripts\engine\trace::ray_trace_passed(var_0 gettagorigin("tag_barrel"), var_1 gettagorigin("j_head"), var_7, var_6);

  if(!istrue(var_11)) {
    return [0, 0, 0];
  }

  return [1, var_5, var_8];
}

_id_36CA(var_0) {
  return isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && var_0.sessionstate == "playing";
}

_id_36C3(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  foreach(var_7 in var_1) {
    if(!_id_36CA(var_7.player)) {
      continue;
    }
    if(_id_36C9(var_7.player) && !istrue(var_7._id_EF0F)) {
      continue;
    }
    var_8 = 0;
    var_9 = 0;
    var_10 = abs(vectortoangles(var_7.player.origin - self.origin)[1]);
    var_11 = abs(self gettagangles("tag_flash")[1]);
    var_10 = abs(var_10 - var_11);
    var_12 = var_7.player _meth_8194();

    foreach(var_14 in var_12) {
      var_15 = weaponclass(var_14);

      if(var_15 == "rocketlauncher") {
        var_10 = var_10 - 40;
      }
    }

    if(istrue(var_7._id_CFB4)) {
      var_8 = 1;
      var_10 = var_10 + 40;
    }

    if(istrue(var_7._id_EF0F)) {
      var_9 = 1;
      var_10 = var_10 + 20;
    }

    if(!isDefined(var_2) || var_2 > var_10) {
      var_2 = var_10;
      var_3 = var_7.player;
      var_5 = var_9;
      var_4 = var_8;
    }
  }

  return [var_3, var_4, var_5];
}

_id_6988(var_0, var_1, var_2) {
  var_3 = self._id_7668[2];
  var_4 = _id_F3CB(var_0, var_1);
  var_5 = var_4 + var_3;
  var_5 = var_5 + randomint(var_2);
  return var_5;
}

_id_36DC() {
  level endon("game_ended");
  self endon("chopperSupport_gone");
  var_0 = self.owner;
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](self._id_8D79)) {
      _id_36B9(100);
    }
  }

  _id_36BC();
}

_id_36BC() {
  self notify("explode");
  self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_support_turret_mp");
  self setscriptablepartstate("explode", "on", 0);

  if(isDefined(self._id_9883)) {
    self[[self._id_9883]]();
  }

  wait 0.35;
  _id_36B7(1);
}

_id_36B9(var_0) {
  self endon("explode");
  self setscriptablepartstate("crash", "on", 0);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament.origin = self.origin + (0, 0, 100);
  }

  self _meth_807E();
  self notify("crashing");
  self._id_87D7 = 1;
  self vehicle_setspeed(var_0, 20, 20);
  self setneargoalnotifydist(100);
  var_1 = _id_36BE(3500, 500, 1000);

  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(self.streakinfo)) {
    scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_support_crash", 1);
  }

  self setvehgoalpos(var_1, 0);
  thread _id_36DA(var_0);
  self _meth_843A();
  self waittill("near_goal");

  if(isDefined(self.streakinfo)) {
    _id_09C1::_id_B8A7();
  }
}

_id_36BE(var_0, var_1, var_2) {
  var_3 = self.origin;
  var_4 = self._id_3E69;
  var_5 = undefined;
  var_6 = anglesToForward(self.angles);
  var_7 = anglestoright(self.angles);
  var_8 = var_3 + var_6 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 - var_6 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + var_7 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 - var_7 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (var_6 + var_7) - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (var_6 - var_7) - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (var_7 - var_6) - (0, 0, var_4);
  var_9 = scripts\engine\trace::ray_trace(var_3, var_8, self);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (-1 * var_6 - var_7) - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  return var_5;
}

_id_36DA(var_0) {
  self endon("death");
  self setyawspeed(var_0, 50, 50, 0.5);

  while(isDefined(self)) {
    self _meth_838A(self.angles[1] + var_0 * 0.4);
    wait 0.5;
  }
}

_id_F3CC(var_0, var_1, var_2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");
  var_3 = scripts\engine\trace::_id_E409(self.origin, (var_0, var_1, var_2), 256, self, undefined, 1);

  if(var_3["surfacetype"] != "surftype_none") {
    return 0;
  }

  var_4 = (var_0, var_1, var_2);
  return var_4;
}

_id_F3CB(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_2 = -99999;
  var_3 = self.origin[2] + 2000;
  var_4 = level._id_1F9C;
  var_5 = [self];

  if(isDefined(self._id_502B)) {
    foreach(var_7 in self._id_502B) {
      var_5[var_5.size] = var_7;
    }
  }

  var_9 = scripts\engine\trace::_id_E409((var_0, var_1, var_3), (var_0, var_1, var_2), 800, var_5, undefined, 1);

  if(var_9["position"][2] < var_4) {
    var_10 = var_4;
  } else {
    var_10 = var_9["position"][2];
  }

  return var_10;
}

_id_24A9() {
  self endon("death");
  self notify("begin_evasive_maneuvers");
  self endon("begin_evasive_maneuvers");
  self._id_5688 = 1;
  var_0 = scripts\engine\utility::_id_108A7(3.0, "death");

  if(var_0 == "timeout") {
    self._id_5688 = 0;
  }
}

_id_6989(var_0, var_1, var_2, var_3) {
  var_4 = 200;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  var_5 = _id_F3CB(var_0, var_1);
  var_6 = var_5 + var_4;
  var_6 = var_6 + randomint(var_2);
  return var_6;
}

_id_36D0(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  self._id_41CA = self.health - var_4;

  if(self._id_41CA <= 1500 && self._id_41BE == 0) {
    self._id_41BE = 1;
    self setscriptablepartstate("body_damage_light", "on");

    if(isDefined(self.streakinfo)) {
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_support_light_damage");
    }
  } else if(self._id_41CA <= 1000 && self._id_41BE == 1) {
    self._id_41BE = 2;
    self setscriptablepartstate("body_damage_medium", "on");

    if(isDefined(self.streakinfo)) {
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_support_med_damage");
    }
  } else if(self._id_41CA <= 500 && self._id_41BE == 2) {
    self._id_41BE = 3;
    self setscriptablepartstate("body_damage_heavy", "on");

    if(isDefined(self.streakinfo)) {
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_support_heavy_damage");
    }
  }

  return 1;
}

_id_36C7(var_0) {
  self._id_8D79 = var_0.objweapon;
  return 1;
}

_id_36B1() {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self._id_8F81 = "randomMovement";
  var_0 = self._id_461E;
  var_1 = _id_6CC5(self.origin);
  self setvehgoalpos(var_1, 1);
  thread _id_09C0::_id_4F43(self.origin, var_1, 5, (1, 0, 1));
  self waittill("goal");
}

_id_6CC5(var_0) {
  self _meth_807E();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    var_1 = self.owner.origin[0];
    var_2 = self.owner.origin[1];
    var_3 = _id_6988(var_1, var_2, 20);
    var_4 = (var_1, var_2, var_3);
    self setlookatent(self.owner);
    return var_4;
  } else {
    var_5 = self.angles[1];
    var_6 = int(var_5 - 60);
    var_7 = int(var_5 + 60);
    var_8 = randomintrange(var_6, var_7);
    var_9 = (0, var_8, 0);
    var_10 = self.origin + anglesToForward(var_9) * randomintrange(400, 800);
    var_11 = var_10[0];
    var_12 = var_10[1];
    var_13 = _id_6988(var_11, var_12, 20);
    var_14 = _id_F3CC(var_11, var_12, var_13);

    if(var_14 != 0) {
      return var_14;
    }

    var_11 = randomfloatrange(var_0[0] - 1200, var_0[0] + 1200);
    var_12 = randomfloatrange(var_0[1] - 1200, var_0[1] + 1200);
    var_15 = (var_11, var_12, var_13);
    return var_15;
  }
}

_id_6B78(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = [];

  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }
    if(!level.teambased || var_4.team != self.team) {
      var_2[var_2.size] = var_4.origin;
    }
  }

  if(var_2.size > 0) {
    var_6 = _func_0016(var_2);
    var_7 = var_6[0];
    var_8 = var_6[1];
  } else {
    var_9 = level._id_9AAC;
    var_10 = level._id_9AC7 / 4;
    var_7 = randomfloatrange(var_9[0] - var_10, var_9[0] + var_10);
    var_8 = randomfloatrange(var_9[1] - var_10, var_9[1] + var_10);
  }

  var_11 = _id_6988(var_7, var_8, 20);
  var_12 = _id_F3CC(var_7, var_8, var_11);

  if(var_12 != 0) {
    return var_12;
  }

  var_7 = randomfloatrange(var_0[0] - 1200, var_0[0] + 1200);
  var_8 = randomfloatrange(var_0[1] - 1200, var_0[1] + 1200);
  var_11 = _id_6988(var_7, var_8, 20);
  var_13 = (var_7, var_8, var_11);
  return var_13;
}

_id_6C1E(var_0) {
  var_1 = 100;
  var_2 = 15000;
  var_3 = randomfloat(360);
  var_4 = (0, var_3, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_2);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_1, (randomfloat(2) - 1) * var_1, 0);
  return var_5;
}

_id_6C1C() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

_id_36BF(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(var_4._id_0398 == var_0) {
      var_2 = var_4;
      break;
    }
  }

  return var_2;
}

_id_36CB() {
  var_0 = 0;

  switch (level.mapname) {
    case "mp_m_speed":
    case "mp_shipment":
      var_0 = 1;
      break;
  }

  return var_0;
}