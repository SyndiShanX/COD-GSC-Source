/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1321.gsc
**************************************/

_id_52F4(var_0) {
  if(getdvarint("4017", 0) || _func_367()) {
    return;
  }
  level._effect["care_package_axis_destroy"] = loadfx("vfx/props/care_package_explode_axis");
  level._effect["care_package_allies_destroy"] = loadfx("vfx/props/care_package_explode_allies");
  level._effect["care_package_allies_beacon"] = loadfx("vfx/lights/usa_carepackage_beacon");
  level._effect["care_package_axis_beacon"] = loadfx("vfx/lights/ger_carepackage_beacon");
  level._effect["care_package_landed"] = loadfx("vfx/smoke/care_package_landed");
  level._id_5A7D["killstreak_carepackage_grenade_mp"] = "carepackage";
  level._id_5A7D["killstreak_carepackage_grenade_axis_mp"] = "carepackage";
  level._id_5A7D["killstreak_emergency_carepackage_grenade_mp"] = "emergency_carepackage";
  level._id_5A7D["killstreak_emergency_carepackage_grenade_axis_mp"] = "emergency_carepackage";
  level._id_5A7D["carepackage_crate_mp"] = "carepackage";
  level._id_80B7["carepackage"] = 0;
  level._id_80B8["carepackage"] = 0;
  level.setwhizbyprobabilities["carepackage"] = 0;
  level._id_80B9["carepackage"] = 1;
  level.makeglobalunusable["carepackage"] = 0;
  level._id_80B7["raid_carepackage"] = 0;
  level._id_80B8["raid_carepackage"] = 0;
  level.setwhizbyprobabilities["raid_carepackage"] = 0;
  level._id_80B9["raid_carepackage"] = 1;
  level.makeglobalunusable["raid_carepackage"] = 0;
  level._id_80B7["emergency_carepackage"] = 0;
  level._id_80B8["emergency_carepackage"] = 0;
  level.setwhizbyprobabilities["emergency_carepackage"] = 0;
  level._id_80B9["emergency_carepackage"] = 1;
  level.makeglobalunusable["emergency_carepackage"] = 0;
  level._id_80B7["zm_carepackage"] = 0;
  level._id_80B8["zm_carepackage"] = 0;
  level.setwhizbyprobabilities["zm_carepackage"] = 0;
  level._id_80B9["zm_carepackage"] = 1;
  level.makeglobalunusable["zm_carepackage"] = 0;
  _id_8A0E();

  if(isDefined(var_0))
    _id_27D5(var_0);
  else
    _id_27D4();

  addstreakhintstringentries();
}

_id_27D4() {
  level._id_275F = [];
  _id_09A9("uav", 120, "lowEndStreak", &"MP_UAV_PICKUP");
  _id_09A9("counter_uav", 105, "lowEndStreak", &"MP_COUNTER_UAV_PICKUP");
  _id_09A9("fighter_strike", 100, "lowEndStreak", &"MP_FIGHTER_STRIKE_PICKUP");
  _id_09A9("fritzx", 90, "lowEndStreak", &"MP_FRITZX_PICKUP");
  _id_09A9("flamethrower", 80, "lowEndStreak", &"MP_FLAMETHROWER_PICKUP");
  _id_09A9("mortar_strike", 75, "lowEndStreak", &"MP_MORTAR_STRIKE_PICKUP");
  _id_09A9("missile_strike", 70, "highEndStreak", &"MP_MISSILE_STRIKE_PICKUP");
  _id_09A9("paratroopers", 30, "highEndStreak", &"MP_PARATROOPERS_PICKUP");
  _id_09A9("airstrike", 25, "highEndStreak", &"MP_AIRSTRIKE_PICKUP");
  _id_09A9("plane_gunner", 10, "highEndStreak", &"MP_PLANE_GUNNER_PICKUP");

  if(getdvarint("1258", 0) == 0 && getdvarint("2803", 0) == 0) {
    _id_09A9("flak_gun", 50, "lowEndStreak", &"MP_FLAK_GUN_PICKUP");
    _id_09A9("firebomb", 45, "highEndStreak", &"MP_FIREBOMB_PICKUP");
  }

  _id_4019();
}

addstreakhintstringentries() {
  game["strings"]["v2_rocket_hint"] = &"MP_V2_ROCKET_PICKUP";
  game["strings"]["tripwire_hint"] = &"MP_TRIPWIRE_PICKUP";
}

_id_27D5(var_0) {
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 3;

  foreach(var_6 in var_0)
  _id_09A9(var_6[var_1], var_6[var_2], var_6[var_3], var_6[var_4]);

  _id_4019();
}

_id_4019() {
  level._id_274B["all"] = 0;

  foreach(var_1 in level._id_275F) {
    var_2 = var_1._id_944E;
    var_3 = var_1._id_9451;

    if(!isDefined(level._id_274B[var_1._id_9451]))
      level._id_274B[var_1._id_9451] = 0;

    level._id_274B[var_3] = level._id_274B[var_3] + var_1._id_7A8F;
    level._id_275F[var_2]._id_9452 = level._id_274B[var_3];
    level._id_274B["all"] = level._id_274B["all"] + var_1._id_7A8F;
    level._id_275F[var_2]._id_0C36 = level._id_274B["all"];
  }
}

_id_09A9(var_0, var_1, var_2, var_3) {
  if(getdvarint("scorestreak_enabled_" + var_0) == 0) {
    return;
  }
  level._id_275F[var_0] = spawnStruct();
  level._id_275F[var_0]._id_944E = var_0;
  level._id_275F[var_0]._id_9451 = var_2;
  level._id_275F[var_0]._id_7A8F = var_1;
  level._id_275F[var_0]._id_0C36 = var_1;
  level._id_275F[var_0]._id_9452 = var_1;

  if(isDefined(var_3))
    game["strings"][var_0 + "_hint"] = var_3;
}

_id_8A0E() {
  var_0 = getEntArray("care_package", "targetname");

  if(!isDefined(var_0) || var_0.size == 0) {
    return;
  }
  level._id_1FFC = _getent(var_0[0].target, "targetname");

  foreach(var_2 in var_0)
  var_2 _id_2D30(0, 0, 0);
}

_id_464D(var_0, var_1) {
  if(_func_367())
    return "ammo";

  var_3 = undefined;

  if(isDefined(var_0) && var_0 != "all") {
    while(!isDefined(var_3) || common_scripts\utility::_id_0F79(var_1, var_3)) {
      var_4 = randomint(level._id_274B[var_0]);

      foreach(var_6 in level._id_275F) {
        if(var_6._id_9451 != var_0) {
          continue;
        }
        var_3 = var_6._id_944E;

        if(var_6._id_9452 > var_4) {
          break;
        }
      }
    }
  } else {
    var_4 = randomint(level._id_274B["all"]);

    foreach(var_6 in level._id_275F) {
      var_3 = var_6._id_944E;

      if(var_6._id_0C36 > var_4) {
        break;
      }
    }
  }

  return var_3;
}

_id_7032(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0 endon("crashing");

  if(isDefined(var_1)) {
    var_1 endon("disconnect");
    var_1 endon("joined_team");
  }

  _id_0527::_id_A6E4(var_0, _id_445E(var_2), var_1);
  level notify("airdropInbound");
  var_0._id_6F2A = 1;
  var_5 = _id_464E();
  var_6 = [];

  for(var_7 = 0; var_7 < _id_45BE(var_2); var_7++) {
    var_8 = _id_3493(var_0, var_1, _id_448E(var_2, var_5[var_7]), var_2, var_6, var_3, var_4);
    var_6[var_6.size] = var_8;

    if(var_8 == "uav")
      var_6[var_6.size] = "counter_uav";
    else if(var_8 == "counter_uav")
      var_6[var_6.size] = "uav";

    wait(_randomfloatrange(0.075, 0.15));
  }
}

_id_3493(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_0527::_id_34B0(var_0.origin, var_0);
  var_7 = var_0.origin + (_randomintrange(-3, 3), _randomfloatrange(-3, 3), -5);
  return _id_4AAE(var_1, var_7, var_3, var_2, var_4, var_5, var_6);
}

_id_45BE(var_0) {
  switch (var_0) {
    case "zm_carepackage":
    case "raid_carepackage":
    case "carepackage":
      return 1;
    case "emergency_carepackage":
      return 3;
  }
}

_id_448E(var_0, var_1) {
  switch (var_0) {
    case "zm_carepackage":
    case "raid_carepackage":
    case "carepackage":
      return "all";
    case "emergency_carepackage":
      return var_1;
  }
}

_id_464E() {
  return common_scripts\utility::array_randomize(["lowEndStreak", "lowEndStreak", "highEndStreak"]);
}

_id_445E(var_0) {
  switch (var_0) {
    case "zm_carepackage":
    case "raid_carepackage":
    case "carepackage":
      return 50;
    case "emergency_carepackage":
      return 200;
  }
}

_id_9E38(var_0, var_1) {
  if(maps\mp\_utility::_id_5668() && !_func_367())
    return 0;

  if(isDefined(self.team) && self.team == "allies")
    var_2 = "killstreak_carepackage_grenade_mp";
  else
    var_2 = "killstreak_carepackage_grenade_axis_mp";

  if(var_1 == "emergency_carepackage") {
    if(isDefined(self.team) && self.team == "allies")
      var_2 = "killstreak_emergency_carepackage_grenade_mp";
    else
      var_2 = "killstreak_emergency_carepackage_grenade_axis_mp";
  }

  var_3 = _id_7470(var_2, var_0, var_1);

  if(!isDefined(var_3) || !var_3)
    return 0;

  _id_0485::_id_5E9A(var_1, self.origin);
  return 1;
}

_id_7470(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("carepackage_grenade_switch");
  thread _id_742D(var_0);

  for(;;) {
    self waittill("grenade_fire", var_3, var_4);

    if(isDefined(var_4) && var_4 == var_0) {
      self notify("grenade_info_processing");
      thread _id_1E84(var_3, var_1, var_2);
      return 1;
    }
  }
}

_id_1E84(var_0, var_1, var_2) {
  var_0 waittill("explode", var_3);
  var_4 = _id_0527::_id_4570();
  _id_0527::_id_9302(var_1, [var_3], [var_4], var_2);
}

_id_742D(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("grenade_info_processing");
  var_1 = self getcurrentweapon();

  while(var_1 == var_0 || maps\mp\_utility::_id_568F(var_1) || maps\mp\_utility::isuseweapon(var_1))
    self waittill("weapon_change", var_1);

  if(maps\mp\_utility::iskillstreakweapon(var_1))
    self._id_5992 = var_1;

  self notify("carepackage_grenade_switch");
}

_id_4AAE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6))
    var_7 = var_6;
  else
    var_7 = _id_464D(var_3, var_4);

  thread _id_8A0F(var_0, var_1, var_7, var_2, var_5);
  return var_7;
}

_id_8A0F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 _id_27D3(var_0, var_2, var_1, undefined, 0, var_3, var_4);

  if(!isDefined(var_0._id_3448))
    var_0._id_3448 = [];

  var_0._id_3448[var_0._id_3448.size] = var_5;

  if(!isDefined(level.all_drop_crates))
    level.all_drop_crates = [];

  level.all_drop_crates[level.all_drop_crates.size] = var_5;

  if(level.all_drop_crates.size > 18)
    level.all_drop_crates[0] _id_2D30(1, 1, 1);

  var_5 thread _id_2358(var_0);
  var_6 = spawn("script_model", var_5 gettagorigin("tag_origin") + (0, 0, -10));
  var_6.angles = (0, 180, 0);
  var_6.visualteam = var_0.team;

  if(isDefined(var_4))
    var_6.visualteam = var_4;

  if(var_6.visualteam == "allies" || var_6.visualteam == "zm")
    var_6 setModel("usa_carepackage_parachute_anim");
  else
    var_6 setModel("ger_carepackage_parachute_anim");

  var_6.team = var_0.team;
  var_7 = spawn("script_model", var_6.origin);
  var_7.angles = var_6.angles;
  var_7 setModel("ger_carepackage_parachute");
  var_7 setcandamage(1);
  var_7 hide();
  var_7 linktosynchronizedparent(var_6);
  var_5.angles = var_6 gettagangles("TAG_CRATE");
  var_5.origin = var_6 gettagorigin("TAG_CRATE");
  var_5 linktosynchronizedparent(var_6, "TAG_CRATE");
  var_5._id_6E4A = var_6;
  var_5._id_6E4C = var_7;

  if(isDefined(var_5._id_5A2C)) {
    var_5._id_5A2C linkto(var_6, "tag_origin", (0, 0, 250), (90, 0, 0));
    var_5._id_5A2C._id_5A32 = gettime();
  }

  var_6 thread _id_64B8();
  var_6 scriptmodelplayanim("carepackage_parachute_deploy");
  wait 1.75;

  if(!isDefined(var_6) || !isDefined(var_5)) {
    return;
  }
  var_6._id_2D6A = 1;

  if(isDefined(var_5._id_6E4A))
    var_6 scriptmodelplayanim("carepackage_parachute_loop");

  if(maps\mp\_utility::_id_585F() && isDefined(level.zombiekillstreaksenabled) && level.zombiekillstreaksenabled)
    level notify("zombies_crate_spawned", var_5);

  var_6 thread _id_63BB(var_5, var_6);
  var_7 thread _id_63BA(var_6, var_5);
  var_5 thread _id_6376(var_0);
  var_5 thread _id_2745();
  var_5 thread _id_2752(var_2, var_0);
  var_5 thread _id_74BA();
}

_id_2358(var_0) {
  level endon("death");
  self waittill("death");

  if(isDefined(var_0) && isDefined(var_0._id_3448))
    var_0._id_3448 = common_scripts\utility::_id_0FA0(var_0._id_3448);

  if(isDefined(level.all_drop_crates))
    level.all_drop_crates = common_scripts\utility::_id_0FA0(level.all_drop_crates);
}

_id_64B8() {
  self endon("death");
  self endon("detach");
  _id_0378::_id_8D74("ks_carepackage_parachute");

  for(;;) {
    if(!isDefined(self._id_2D6A) || !self._id_2D6A)
      self moveto(self.origin + (0, 0, -45), 0.05);
    else
      self moveto(self.origin + (0, 0, -20), 0.05);

    waitframe();
  }
}

_id_63BA(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("detach");

  if(_func_367()) {
    for(;;) {
      self waittill("damage", var_2, var_3);

      if(var_2 == 1) {
        break;
      }
    }
  } else
    common_scripts\utility::_id_A732("damage", "death");

  var_0 thread _id_2E45(var_1, 1);
}

_id_63BB(var_0, var_1) {
  self endon("detach");
  var_0 endon("death");
  var_1 endon("death");
  var_2 = undefined;

  for(;;) {
    var_3 = var_1 gettagorigin("tag_origin");
    var_4 = (var_3[0], var_3[1], var_3[2] - 1000);
    var_5 = var_3;
    var_6 = bulletTrace(var_3, var_4, 1, var_0);

    if(var_6["fraction"] <= 0.5) {
      thread _id_2E45(var_0, 0);
      break;
    }

    if(isDefined(var_5) && isDefined(var_2) && var_5 == var_2) {
      break;
    }

    var_2 = var_5;
    waitframe();
  }
}

_id_2E45(var_0, var_1) {
  var_2 = 2.66667;

  if(!isDefined(var_0) || !isDefined(self)) {
    return;
  }
  if(isDefined(var_0._id_34A3) && var_0._id_34A3) {
    return;
  }
  self notify("detach");

  if(isDefined(var_0._id_6E4C))
    var_0._id_6E4C delete();

  var_0._id_34A3 = 1;
  self scriptmodelplayanimdeltamotion("carepackage_parachute_detach");
  wait 0.2;

  if(var_0.visualteam == "allies")
    _playfxontag(common_scripts\utility::_id_44F5("care_package_allies_beacon"), var_0, "TAG_FX");
  else
    _playfxontag(common_scripts\utility::_id_44F5("care_package_axis_beacon"), var_0, "TAG_FX");

  var_0 unlink();

  if(isDefined(var_0._id_5A2C)) {
    var_0._id_5A2C unlink();
    var_0._id_5A2C thread _id_5A2E(var_0);
  }

  if(!_func_367())
    var_0 clonebrushmodeltoscriptmodel(level._id_1FFC);

  if(_func_367() && var_1)
    var_0 _id_2D30(1, 1, 1);
  else {
    var_3 = 500;

    if(maps\mp\_utility::_id_579B())
      var_3 = 100;

    var_0 physicslaunchserver((0, 0, 0), (0, 0, 1000), 3000, var_3);
  }

  var_4 = 1.0;
  wait(var_2 - 0.2 - var_4);
  self _meth_8450(1, 1, 0);

  if(self.visualteam == "allies")
    self setModel("usa_carepackage_parachute_anim_fade");
  else
    self setModel("ger_carepackage_parachute_anim_fade");

  self _meth_8450(1, 0, var_4);
  wait(var_4);
  self delete();
}

_id_74BA() {
  self endon("death");
  self waittill("physics_impact", var_0, var_1, var_2, var_3);
  _id_0378::_id_8D74("ks_carepackage_firstImpact");
  playFX(common_scripts\utility::_id_44F5("care_package_landed"), var_0, var_1);

  if(_func_367())
    self._id_5AFA = 1;

  thread _id_720C();
}

_id_720C() {
  self endon("physics_finished");
  self waittill("physics_impact", var_0, var_1, var_2, var_3);
  _id_0380::_id_6844("ks_carepackage_physics", undefined, self);
  playFX(common_scripts\utility::_id_44F5("care_package_landed"), var_0, var_1);
}

_id_2745() {
  if(!isDefined(self)) {
    return;
  }
  self endon("physics_finished");
  self endon("death");
  var_0 = 0;
  var_1 = self.origin;

  for(;;) {
    waitframe();

    if(!isDefined(self)) {
      return;
    }
    var_2 = distancesquared(var_1, self.origin);

    if(var_2 < 56.25)
      var_0++;
    else
      var_0 = 0;

    var_1 = self.origin;
  }
}

_id_0F30(var_0, var_1) {
  var_2 = 300;
  var_3 = 100;
  var_4 = 1250;
  var_5 = vectorNormalize(var_1 - var_0.origin);
  var_6 = var_5[0] * var_2;
  var_7 = var_5[1] * var_2;
  var_8 = -1 * var_5[1] * var_4;
  var_9 = var_5[0] * var_4;
  self _meth_8274((var_6, var_7, var_3), (var_8, var_9, 0));
}

_id_6376(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("physics_finished");

  if(maps\mp\_utility::_id_579B() || !isDefined(var_0)) {
    return;
  }
  var_1 = self.origin;

  for(;;) {
    var_2 = self gettagorigin("tag_weapon");

    if(distancesquared(var_1, var_2) > 100) {
      foreach(var_4 in level.players) {
        if(var_4.team != "spectator" && var_4.team != self.team || isDefined(var_0) && var_4 == var_0) {
          if(var_4 istouching(self)) {
            thread _id_0F30(var_4, var_2);

            if(isDefined(var_0))
              var_4 dodamage(150, var_2, var_0, self, "MOD_PROJECTILE", "carepackage_crate_mp");

            self notify("hit_player");
          }
        }
      }
    }

    var_1 = var_2;
    waitframe();
  }
}

_id_2752(var_0, var_1) {
  self endon("death");
  self waittill("physics_finished");
  self._id_34A3 = 0;
  thread _id_5A5F(var_0);

  if(!_func_367()) {
    if(maps\mp\_utility::_id_585F() && isDefined(level.zombie_crate_timeout_callback))
      level thread[[level.zombie_crate_timeout_callback]](self);
    else
      level thread _id_34B2(self);
  }

  var_2 = getEntArray("trigger_hurt", "classname");

  foreach(var_4 in var_2) {
    if(self istouching(var_4)) {
      _id_2D30();
      return;
    }
  }

  if(isDefined(self._id_0117) && _abs(self.origin[2] - self._id_0117.origin[2]) > 4000) {
    _id_2D30();
    return;
  }

  var_6 = spawnStruct();
  var_6._id_2AA8 = ::_id_64EB;
  var_6._id_9AC2 = ::_id_64EC;
  thread _id_0488::_id_4A27(var_6);
  thread _id_275D();
}

_id_64EB(var_0) {
  _id_2D30(1, 1);
}

_id_64EC(var_0) {
  return _id_1FFA(var_0) && _id_1FFB(var_0);
}

_id_1FFA(var_0) {
  return !isDefined(self.targetname) || !isDefined(var_0.targetname) || self.targetname != "care_package" || var_0.targetname != "care_package";
}

_id_1FFB(var_0) {
  return !isDefined(self.targetname) || !isDefined(var_0._id_1FFE) || self.targetname != "care_package" || !var_0._id_1FFE;
}

_id_275D() {
  var_0 = _getnodesinradiussorted(self.origin, 300, 0, 300);

  foreach(var_2 in _func_2D1()) {
    if(!isalive(var_2)) {
      continue;
    }
    if(var_2 istouching(self)) {
      foreach(var_4 in var_0) {
        if(distancesquared(var_4.origin, self.origin) > 10000) {
          var_2 setOrigin(var_4.origin, 1);
          var_0 = common_scripts\utility::_id_0F93(var_0, var_4);
          break;
        }
      }
    }
  }
}

_id_27D3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_3))
    var_3 = (0, 0, 0);

  if(!isDefined(var_4))
    var_4 = 1;

  var_7 = spawn("script_model", var_2);
  var_7.angles = var_3;
  var_7._id_28D5 = 0;
  var_7._id_A22B = 0;

  if(_func_367())
    var_7.team = "any";
  else
    var_7.team = var_0.team;

  if(isDefined(var_0))
    var_7._id_0117 = var_0;
  else
    var_7._id_0117 = undefined;

  var_7.visualteam = "any";

  if(isDefined(var_6))
    var_7.visualteam = var_6;
  else if(isDefined(var_0))
    var_7.visualteam = var_0.team;

  var_7._id_944E = var_1;
  var_7._id_8F52 = var_5;
  var_7.targetname = "care_package";
  var_7._id_3009 = spawn("script_model", var_7.origin);
  var_7._id_65E1 = ::_id_2D30;

  if(var_7.visualteam == "any") {
    var_7 setModel("ger_carepackage_crate");
    var_7._id_3009 setModel("ger_carepackage_crate");
    _playfxontag(common_scripts\utility::_id_44F5("care_package_axis_beacon"), var_7, "TAG_FX");
    var_7.visualteam = "axis";
  } else if(var_7.visualteam == "zm") {
    var_7 setModel("zbw_carepackage_crate");
    var_7._id_3009 setModel("zbw_carepackage_crate");
    _playfxontag(common_scripts\utility::_id_44F5("care_package_axis_beacon"), var_7, "TAG_FX");
    var_7.visualteam = "zm";
  } else {
    var_8 = _id_0510::_id_46C6(var_7.visualteam);
    var_7 setModel(var_8);
    var_7._id_3009 setModel(var_8);

    if(var_7.visualteam == "axis")
      _playfxontag(common_scripts\utility::_id_44F5("care_package_axis_beacon"), var_7, "TAG_FX");
    else
      _playfxontag(common_scripts\utility::_id_44F5("care_package_allies_beacon"), var_7, "TAG_FX");
  }

  var_7._id_3009 linkto(var_7, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_7._id_3009 notsolid();
  var_7._id_54F5 = 0;

  if(var_4)
    var_7 clonebrushmodeltoscriptmodel(level._id_1FFC);

  var_7._id_5A2C = spawn("script_model", var_7.origin + (0, 0, 250));
  var_7._id_5A2C setscriptmoverkillcam("script_entity");
  var_7._id_5A2C _meth_80B1();
  return var_7;
}

_id_5A2E(var_0) {
  var_0 endon("death");
  var_0 endon("hit_player");
  var_0 endon("physics_finished");
  self endon("death");
  var_1 = (0, 0, 250);
  self.origin = var_0.origin + var_1;
  var_2 = var_0.origin;
  var_3 = 0;

  for(;;) {
    var_4 = var_0.origin - var_2;

    if(length(var_4) > 0.01) {
      var_5 = vectorNormalize(var_4);
      var_6 = var_5 * -250;

      if(var_3 < 1) {
        var_7 = _vectorlerp(var_1, var_6, var_3);
        var_3 = var_3 + 0.05;
      } else
        var_7 = var_6;

      self.origin = var_0.origin + var_7;
    }

    var_2 = var_0.origin;
    waitframe();
  }
}

_id_275A(var_0) {
  if(_func_367()) {
    if(self.origin[2] >= 90) {
      _playfxontag(level._effect["care_package_hit"], self, "tag_origin");
      common_scripts\utility::_id_0F93(level._id_1FFD, self);
      _setomnvar("ui_fge_carepackages_remaining", level._id_1FFD.size);
      _id_2D30(1, 1, 1);
    } else {
      var_1 = spawn("trigger_radius", self.origin + (0, 0, -1), 0, 160, 128);
      var_2 = _id_04D1::_id_2837("neutral", var_1, [self], (0, 0, 100));
      var_2 _id_04D1::_id_0C30("enemy");
      var_2 _id_04D1::_id_8A5A(10);
      var_2 _id_04D1::_id_8A59(&"MP_SECURING_CRATE");
      var_2._id_6ABC = ::_id_6AC0;
      var_2._id_6AFA = ::_id_6AFD;
      level._id_76FD = 200;
      level._id_76FA = 5;
      self._id_321B = var_2;
      self hudoutlineenableforclients(level.players, 2, 0);

      if(isDefined(level._id_320F))
        self._id_320E = _spawnfx(level._id_320F, self.origin);

      self notify("crate_start_countdown");
      return;
    }
  }

  self makeusable();

  if(self.team == "any") {
    var_3 = _id_04D1::_id_45A9();
    _objective_add(var_3, "invisible", (0, 0, 0));
    _objective_position(var_3, self.origin);
    _objective_state(var_3, "active");
    _objective_icon(var_3, "waypoint_empty_icon");
    _func_36F(var_3, "scorestreak_minimap_care_package_crate");
    _func_370(var_3, _id_04D1::_id_446B("friendly"));
    _objective_team(var_3, "none");
    self._id_698E = var_3;
  } else {
    if(level.teambased || isDefined(self._id_0117)) {
      var_3 = _id_04D1::_id_45A9();
      _objective_add(var_3, "invisible", (0, 0, 0));
      _objective_position(var_3, self.origin);
      _objective_state(var_3, "active");
      _objective_icon(var_3, "waypoint_empty_icon");
      _func_36F(var_3, "scorestreak_minimap_care_package_crate");
      _func_370(var_3, _id_04D1::_id_446B("friendly"));

      if(!level.teambased && isDefined(self._id_0117))
        _objective_playerenemyteam(var_3, self._id_0117 getentitynumber());
      else if(level.gametype == "infect")
        _objective_team(var_3, "allies");
      else
        _objective_team(var_3, self.team);

      self._id_698E = var_3;
    }

    if(isDefined(self._id_0117)) {
      var_3 = _id_04D1::_id_45A9();
      _objective_add(var_3, "invisible", (0, 0, 0));
      _objective_position(var_3, self.origin);
      _objective_state(var_3, "active");
      _objective_icon(var_3, "waypoint_empty_icon");
      _func_36F(var_3, "scorestreak_minimap_care_package_crate");
      _func_370(var_3, _id_04D1::_id_446B("enemy"));

      if(!level.teambased && isDefined(self._id_0117))
        _objective_playerteam(var_3, self._id_0117 getentitynumber());
      else
        _objective_team(var_3, level._id_6C63[self.team]);

      self._id_698D = var_3;
    }
  }

  self._id_5022 = var_0;
  _id_8A21(var_0);
}

_id_8A21(var_0, var_1) {
  if(self.team == "any") {
    foreach(var_3 in level._id_985B) {
      if(isDefined(var_0) && _isarray(var_0)) {
        _id_869F(var_3, var_0);
        continue;
      }

      _id_0479::_id_869E(var_3, var_0, (0, 0, 25), 14, 14, undefined, undefined, undefined, undefined, undefined, 0, "tag_weapon", var_1);
    }
  } else {
    var_5 = self._id_944E;

    if(level.teambased) {
      if(isDefined(var_0) && _isarray(var_0))
        _id_869F(self.team, var_0);
      else
        _id_0479::_id_869E(self.team, var_0, (0, 0, 25), 14, 14, undefined, undefined, undefined, undefined, undefined, 0, "tag_weapon", var_1);
    } else if(isDefined(self._id_0117)) {
      if(isDefined(var_0) && _isarray(var_0))
        _id_869F(self._id_0117, var_0);
      else
        _id_0479::_id_869E(self._id_0117, var_0, (0, 0, 25), 14, 14, undefined, undefined, undefined, undefined, undefined, 0, "tag_weapon", var_1);
    }
  }
}

_id_869F(var_0, var_1) {
  var_2 = 10;
  var_3 = 0;
  self._id_5010 = [];

  foreach(var_5 in var_1) {
    self._id_5010[var_5] = common_scripts\utility::_id_8FFC();
    self._id_5010[var_5] _id_0479::_id_869E(var_0, var_5, (0, 0, 20 + var_3 * var_2), 14, 14, undefined, undefined, undefined, undefined, "tag_weapon", 0);
    var_3++;
  }
}

_id_6AC0(var_0, var_1) {
  if(!isDefined(self._id_7450))
    self._id_7450 = 1;
  else
    self._id_7450++;
}

_id_6AFD(var_0, var_1, var_2) {
  if(!var_2) {
    self._id_28D5 = 0;
    self._id_7450--;
    return;
  }

  var_3 = self._id_9AC3["allies"];

  foreach(var_5 in var_3)
  var_5.player thread maps\mp\gametypes\_missions::processchallenge("ch_hq_aagun");

  self._id_A582[0] notify("captured", var_1);
}

_id_2744() {
  self endon("captured");

  while(isDefined(self)) {
    self waittill("trigger", var_0);
    thread _id_11C3(var_0);
  }
}

preventactionslotspam() {
  self _meth_8309(0);
  common_scripts\utility::_id_A716("death", "game_ended", "disconnect", "attemptCaptureEnd");
  self _meth_8309(1);
}

_id_11C3(var_0) {
  if(var_0 isjumping()) {
    return;
  }
  if(!var_0 isonground() && !_id_A7A0(var_0)) {
    return;
  }
  if(!_id_A276(var_0)) {
    return;
  }
  if(level.gametype == "infect" && isDefined(var_0._id_0179) && var_0._id_0179 == "axis") {
    return;
  }
  if(maps\mp\_utility::_id_579B() || maps\mp\_utility::_id_585F())
    var_1 = 500;
  else {
    var_1 = 3000;

    if(isDefined(self._id_0117)) {
      if(var_0 == self._id_0117)
        var_1 = 500;
    } else if(var_0.team == self.team)
      var_1 = 500;
  }

  var_0._id_56A1 = 1;
  var_0 thread preventactionslotspam();
  var_2 = _id_2836();
  var_3 = var_2 _id_A213(var_0, var_1, self);

  if(isDefined(var_2))
    var_2 delete();

  if(isDefined(var_0))
    var_0._id_56A1 = 0;

  if(!var_3) {
    var_0 notify("attemptCaptureEnd");
    return;
  }

  self notify("captured", var_0);
  wait 0.2;
  var_0 notify("attemptCaptureEnd");
}

_id_A7A0(var_0) {
  if(var_0 isonground())
    return 0;

  var_1 = var_0.origin;
  var_2 = gettime();

  while(isDefined(var_0) && maps\mp\_utility::isreallyalive(var_0) && !var_0 isonground() && var_1 == var_0.origin && var_0 usebuttonpressed()) {
    var_3 = gettime() - var_2;

    if(var_3 >= 200)
      return 1;

    waitframe();
  }

  return 0;
}

_id_A276(var_0) {
  var_1 = var_0 getcurrentprimaryweapon();

  if(maps\mp\_utility::_id_579B() && (issubstr(var_1, "flamethrower") || common_scripts\utility::_id_73F5(var_0) && !maps\mp\_utility::playerhaskillstreak(var_0, "basic_training_serum"))) {
    var_0 iprintlnbold(&"RAIDS_HAVE_AIRDROP_ITEM");
    return 0;
  }

  if(issubstr(var_1, "turrethead") || issubstr(var_1, "flamethrower") || issubstr(var_1, "carepackage"))
    return 1;

  if(!var_0 _id_051E::_id_1F6E())
    return 0;

  if(isDefined(var_0._id_20CC) && !var_0 _id_051E::_id_1F6E())
    return 0;

  return 1;
}

_id_5A5F(var_0) {
  self endon("death");
  var_1 = isDefined(self._id_0117) && (self._id_0117 maps\mp\_utility::_hasperk("specialty_unwrapper") || self._id_0117 maps\mp\_utility::_hasperk("specialty_improvedstreaks")) && !maps\mp\_utility::_id_579B();

  if(maps\mp\_utility::_id_585F() || level.gametype == "infect")
    var_1 = 0;

  var_2 = undefined;

  if(isDefined(game["strings"][var_0 + "_hint"]))
    var_2 = game["strings"][var_0 + "_hint"];
  else
    var_2 = &"PLATFORM_GET_KILLSTREAK";

  if(!maps\mp\_utility::_id_585F())
    _id_275A(_id_051E::_id_4533(var_0));

  if(isDefined(self._id_56C5) && self._id_56C5)
    self waittill("physics_finished");

  if(maps\mp\_utility::_id_585F() && isDefined(level.zombiekillstreaksenabled) && level.zombiekillstreaksenabled) {
    if(isDefined(level.zombiecratecapturethink))
      self thread[[level.zombiecratecapturethink]]();
  } else {
    thread _id_2744();
    var_3 = undefined;

    if(var_1) {
      var_4 = &"MP_PACKAGE_REROLL";
      self settertiaryhintstring(var_4);
      self sethintstringvisibleonlytoowner(1);
      thread _id_2750();
    }

    self setcursorhint("HINT_NOICON");
    self sethintstring(var_2);
    self setsecondaryhintstring(&"MP_CARE_PACKAGE_PICKUP");
    self _meth_84A6(1);

    if(level.gametype == "infect") {
      self setsecondaryhintstring(&"INFECT_NO_CAPTURE_CRATE");
      self _meth_84A6(1);
    }
  }

  for(;;) {
    self waittill("captured", var_5);

    if(_func_367()) {
      level._id_2758++;
      common_scripts\utility::_id_0F93(level._id_1FFD, self);
      _setomnvar("ui_fge_carepackages_secured", level._id_2758);
      _setomnvar("ui_fge_carepackages_remaining", level._id_1FFD.size);

      foreach(var_5 in level.players) {
        if(var_5._id_572A) {
          continue;
        }
        var_5 _meth_866C(&"delete_supply_drop_countdown", 1, self);
      }
    } else if(maps\mp\_utility::_id_585F()) {
      if(isDefined(level.zombiecarepackageusefunc))
        var_5[[level.zombiecarepackageusefunc]](self);

      continue;
    } else {
      if(isDefined(self._id_0117)) {
        if(var_5 == self._id_0117) {
          if(isDefined(self._id_8F52)) {
            if(self._id_8F52 == "carepackage" || self._id_8F52 == "raid_carepackage")
              var_5 maps\mp\gametypes\_missions::processchallenge("ch_streak_carepackage");
            else if(self._id_8F52 == "emergency_carepackage")
              var_5 maps\mp\gametypes\_missions::processchallenge("ch_streak_emergencycare");
          }
        } else if(!level.teambased || var_5.team != self.team) {
          var_5 thread _id_047A::_id_4D4F(self._id_0117);

          if(isDefined(level.hijackeventfunc))
            self[[level.hijackeventfunc]]();
        } else {
          _id_0468::_id_0A1A("sharepackage", self._id_0117, undefined, undefined, undefined);
          self._id_0117 thread _id_047A::_id_8AD6();
        }
      }

      if(isDefined(self.visualteam))
        var_5.raidcarepackageteam = self.visualteam;

      _id_0380::_id_6840("scavenger_pack_pickup", var_5);
      var_8 = undefined;

      if(maps\mp\_utility::_id_579B()) {
        if(var_5.team == game["attackers"])
          var_8 = "attacker_" + self._id_944E;
        else
          var_8 = "defender_" + self._id_944E;
      }

      var_9 = var_5 _id_051E::_id_45A5(self._id_944E, 0);
      var_5 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(self._id_944E, undefined, undefined, var_9, var_8);
      var_5 thread _id_051E::_id_478D(self._id_944E, 0, 0, self._id_0117);
      var_5 _id_0468::_id_0A28("packageCapped");
    }

    _id_2D30(1);
  }
}

_id_2750() {
  self._id_6DDE = 0;
  self._id_6DDF = 0;

  while(!level.gameended && isDefined(self)) {
    if(maps\mp\_utility::isreallyalive(self._id_0117)) {
      var_0 = self._id_0117 getusableentity();

      if(isDefined(var_0) && var_0 == self && self._id_0117 usebuttonpressed())
        self._id_6DDE++;
      else if(self._id_6DDE > 0) {
        if(self._id_6DDE < 5) {
          if(self._id_6DDF == 1) {
            self notify("package_double_tap");
            var_1 = self._id_944E;

            for(var_2 = 0; self._id_944E == var_1 && var_2 < 100; self._id_944E = _id_464D())
              var_2++;

            var_3 = game["strings"][self._id_944E + "_hint"];

            if(!isDefined(var_3))
              var_3 = &"PLATFORM_GET_KILLSTREAK";

            self sethintstring(var_3);
            self settertiaryhintstring("");
            self._id_5022 = _id_051E::_id_4533(self._id_944E);
            _id_8A21(self._id_5022);
            _id_0380::_id_6840("scavenger_pack_pickup", self._id_0117);
            return 1;
          } else {
            self._id_6DDF = 1;
            thread _id_97F9();
          }
        }

        self._id_6DDE = 0;
      }
    }

    waitframe();
  }
}

_id_97F9() {
  level endon("game_ended");
  self endon("death");
  self endon("package_double_tap");
  wait 0.2;
  self._id_6DDF = 0;
}

_id_A213(var_0, var_1, var_2) {
  if(isPlayer(var_0))
    var_0 playerlinkto(self);
  else
    var_0 linkto(self);

  var_0 common_scripts\utility::_id_0602();
  thread _id_A215(var_0);
  self._id_28D5 = 0;
  self._id_54F5 = 1;
  self._id_A22B = 0;

  if(isPlayer(var_0))
    var_0 thread _id_6F82(self, var_1, var_2);

  var_3 = _id_A214(var_0, var_1);

  if(!isDefined(self))
    return 0;

  self notify("useHoldThinkLoopDone");
  self._id_54F5 = 0;
  self._id_28D5 = 0;
  return var_3;
}

_id_A215(var_0) {
  var_0 endon("death");
  common_scripts\utility::_id_A70A("death", "captured", "useHoldThinkLoopDone");

  if(isalive(var_0)) {
    var_0 common_scripts\utility::_id_0616();

    if(var_0 islinked())
      var_0 unlink();
  }
}

_id_6F82(var_0, var_1, var_2) {
  self endon("disconnect");
  self setclientomnvar("ui_use_bar_text", 1);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  var_3 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0) && var_0._id_54F5 && !level.gameended) {
    if(var_3 != var_0._id_A22B) {
      if(var_0._id_28D5 > var_1)
        var_0._id_28D5 = var_1;

      if(var_0._id_A22B > 0) {
        var_4 = int(var_2.origin[0]);
        var_5 = int(var_2.origin[1]);
        var_6 = int(var_2.origin[2] + 25);
        self _meth_85EF(&"carepackage_icon_world_position", 3, var_4, var_5, var_6);
        var_7 = gettime();
        var_8 = var_0._id_28D5 / var_1;
        var_9 = var_7 + (1 - var_8) * (var_1 / var_0._id_A22B);
        self setclientomnvar("ui_use_bar_end_time", int(var_9));
        self setclientomnvar("ui_mp_carepackage_scorestreak", maps\mp\_utility::_id_453F(var_2._id_944E));
        self setclientomnvar("ui_mp_carepackage_team", maps\mp\_utility::_id_46D4(var_2.team));

        if(isDefined(var_2._id_0117))
          self setclientomnvar("ui_mp_carepackage_owner", var_2._id_0117 getentitynumber());

        var_2 _id_8A21(var_2._id_5022, self);
      }

      var_3 = var_0._id_A22B;
    }

    waitframe();
  }

  if(isDefined(var_2))
    var_2 _id_8A21(var_2._id_5022);

  self setclientomnvar("ui_use_bar_end_time", 0);
}

_id_A214(var_0, var_1) {
  while(!level.gameended && isDefined(self) && maps\mp\_utility::isreallyalive(var_0) && var_0 usebuttonpressed() && self._id_28D5 < var_1) {
    self._id_28D5 = self._id_28D5 + self._id_A22B * 50;

    if(!self._id_A22B)
      self._id_A22B = 1;

    if(self._id_28D5 >= var_1)
      return maps\mp\_utility::isreallyalive(var_0);

    waitframe();
  }

  return 0;
}

_id_2836() {
  var_0 = spawn("script_origin", self.origin);
  var_0._id_28D5 = 0;
  var_0._id_A22B = 0;
  var_0._id_54F5 = 0;
  var_0 thread _id_2D57(self);
  return var_0;
}

_id_2D57(var_0) {
  self endon("death");
  var_0 waittill("death");
  self delete();
}

_id_2D30(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(isDefined(self._id_698E))
    maps\mp\_utility::_objective_delete(self._id_698E);

  if(isDefined(self._id_698D))
    maps\mp\_utility::_objective_delete(self._id_698D);

  if(isDefined(self._id_5A2C))
    self._id_5A2C delete();

  if(isDefined(self._id_6DB1))
    self._id_6DB1 delete();

  if(isDefined(self._id_6C62))
    self._id_6C62 delete();

  if(isDefined(self._id_3009))
    self._id_3009 delete();

  if(var_0 && (self.visualteam == "axis" || self.visualteam == "zm"))
    playFX(common_scripts\utility::_id_44F5("care_package_axis_destroy"), self.origin, anglesToForward(self.angles));

  if(var_0 && self.visualteam == "allies")
    playFX(common_scripts\utility::_id_44F5("care_package_allies_destroy"), self.origin, anglesToForward(self.angles));

  if(var_1 && self.visualteam == "allies")
    _id_0380::_id_6842("ks_carepackage_open_allies", undefined, self.origin);

  if(var_1 && (self.visualteam == "axis" || self.visualteam == "zm"))
    _id_0380::_id_6842("ks_carepackage_open_axis", undefined, self.origin);

  if(isDefined(self._id_5010)) {
    foreach(var_4 in self._id_5010)
    var_4 delete();
  }

  if(var_2 && (self.visualteam == "axis" || self.visualteam == "zm"))
    thread _id_27DF(self.origin, self.angles);

  if(_func_367() && isDefined(self._id_321B)) {
    if(isDefined(self._id_320E))
      self._id_320E delete();

    if(isDefined(self._id_321B._id_9D65))
      self._id_321B._id_9D65 delete();

    self._id_321B _id_04D1::_id_2D58();
  }

  self delete();
}

_id_34B2(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(90);

  while(var_0._id_28D5 != 0)
    wait 1;

  var_0 _id_2D30(1, 1);
}

_id_27DF(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_3 = "ger_carepackage_crate_chunks";

  if(maps\mp\_utility::_id_585F() && self.visualteam == "zm")
    var_3 = "zbw_carepackage_crate_chunks";

  var_2 setModel(var_3);
  var_2.angles = var_1;
  var_2 show();
  waitframe();
  _physicsexplosionsphere(var_0, 100, 80, 0.6);
  wait 2;
  var_2 delete();
}