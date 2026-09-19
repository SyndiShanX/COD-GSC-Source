/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1408.gsc
**************************************/

init() {
  _id_0547::_id_7BD0("tesla_shock", ::_id_8316, undefined, 5, ::_id_8315);
  common_scripts\utility::_id_092C("shock", "vfx/sparks/tesla_stun_sparks");
  common_scripts\utility::_id_092C("head_sparks", "vfx/sparks/microwave_grenade_sparks_char_1");
  _id_054D::_id_7BC6(::_id_98EC);
  var_0 = spawnStruct();
  var_0._id_6042 = 5;
  var_0._id_6053 = 5;
  var_0._id_78CA = 300;
  var_0._id_78C4 = 20;
  var_0._id_0F43 = 0.5;
  common_scripts\utility::flag_init("teslagun_punch_active");
  level._id_98F5 = var_0;
  _id_0581::_id_17FD();
  _id_0583::_id_6402();
  _id_0584::_id_9434();
  _id_0582::_id_2A99();
}

_id_98F6(var_0) {
  var_1 = self;
  var_1.player = var_0;
  var_2 = var_0 common_scripts\utility::_id_A74D("disconnect", 5);

  if(!_id_0547::_id_5565("timeout", var_2))
    var_1.player = undefined;
}

_id_98FD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(_id_0547::_id_5565(var_2, var_0)) {
    return;
  }
  if(_id_0547::_id_5565(var_2._id_000A, level._id_746E)) {
    return;
  }
  if(_id_0547::_id_5565(var_4, "MOD_MELEE")) {
    return;
  }
  if(_id_0547::_id_5565(var_2._id_98FE, _id_4385())) {
    return;
  }
  if(common_scripts\utility::_id_562E(var_2._id_6012)) {
    return;
  }
  var_8 = spawnStruct();
  var_8._id_953E = var_5;
  var_8._id_8CD7 = var_4;
  var_8._id_6B87 = var_6;
  var_8._id_4DCD = 0;
  var_8._id_94B3 = var_7;

  if(isDefined(var_1))
    var_8 thread _id_98F6(var_1);

  var_2 thread _id_9900(var_2.origin, var_3, var_8, 1, var_1, var_4, var_5);
}

_id_98EC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = self;

  if(!isDefined(var_5)) {
    return;
  }
  var_12 = _func_05F(var_5);

  if(!isDefined(var_12)) {
    return;
  }
  if(var_12 != "teslagun_zm" && var_12 != "teslagun_pap_zm") {
    return;
  }
  if(_id_0547::_id_5565(var_4, "MOD_MELEE")) {
    return;
  }
  if(var_2 == _id_4382()) {
    return;
  }
  _id_98FD(var_0, var_1, var_11, "j_head", var_4, var_5, ::_id_98FF);
}

_id_9900(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self;

  if(!isalive(var_7)) {
    return;
  }
  if(common_scripts\utility::_id_562E(var_7._id_172A) || var_7 _id_0547::has_scripted_state_queued("tesla_shock")) {
    var_8 = 2000;

    if(isDefined(var_6) && issubstr(var_6, "teslagun_pap_zm"))
      var_8 = 6000;

    var_7 _meth_8059(var_8, var_0, var_4, var_7, var_5, var_6);
    return;
  }

  var_7 endon("death");
  wait 0;
  var_7._id_98FE = _id_4385();

  if(var_7 maps\mp\agents\humanoid\_humanoid_util::_id_56BC()) {
    var_7 _meth_8059(var_7.health + 10, var_0, var_4, var_7, var_5, "dot_generic_zm");
    return;
  }

  if(self._id_0A4B != "zombie_heavy" && self._id_0A4B != "zombie_fireman") {
    var_9 = "shock";

    if(isDefined(var_2._id_94B3))
      var_9 = var_2._id_94B3;

    var_7 thread play_shock_fx(var_9, "j_spine4", 4);
    thread play_shock_sound(4);
  }

  if(isDefined(var_7._id_98F0) && _id_4385() < var_7._id_98F0)
    var_7 _id_9901();
  else
    var_7 childthread[[var_2._id_6B87]](var_0, var_2);

  var_10 = level._id_98F5;
  wait(var_10._id_0F43);
  var_11 = var_10._id_78CA - var_10._id_78C4 * var_3;
  var_12 = _func_0DA(var_11);

  if(var_11 <= 0 || var_3 >= var_10._id_6042) {
    return;
  }
  var_13 = var_7 gettagorigin(var_1);
  var_14 = _id_4385();

  foreach(var_16 in _id_0547::_id_408F()) {
    if(!isalive(var_16)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_16._id_5D5F)) {
      continue;
    }
    if(distancesquared(var_7.origin, var_16.origin) > var_12) {
      continue;
    }
    if(isDefined(var_7._id_98FE) && var_14 - var_7._id_98FE < 1) {
      continue;
    }
    if(var_2._id_4DCD >= var_10._id_6053) {
      break;
    }

    var_17 = "j_head";

    if(-1 == var_16 _meth_8445(var_17))
      var_17 = "j_spine4";

    var_18 = var_16 gettagorigin(var_17);

    if(!_func_07E(var_13, var_18, 0, var_7)) {
      continue;
    }
    var_2._id_4DCD++;
    _id_98EA(var_7, var_1, var_16, var_17, var_10._id_953E);
    var_16 thread _id_9900(var_7.origin, var_17, var_2, var_3 + 1);
  }
}

play_shock_fx(var_0, var_1, var_2) {
  self endon("death");

  for(var_3 = 0; var_3 < var_2; var_3 = var_3 + 0.35) {
    _func_147(common_scripts\utility::_id_44F5(var_0), self, var_1);
    wait 0.35;
  }
}

play_shock_sound(var_0) {
  self notify("play_shock_sound");
  wait 0;
  thread _id_0378::_id_8D74("aud_wonder_weapon_electrocute_strt");
  common_scripts\utility::_id_A71B(var_0, "death", "play_shock_sound");
  thread _id_0378::_id_8D74("aud_wonder_weapon_electrocute_end");
}

_id_9901(var_0) {
  var_1 = 3;

  if(isDefined(var_0))
    var_1 = var_0;

  var_2 = self;
  var_2._id_98F0 = _id_4385() + var_1 + _func_0A5(0.1, 0.6);
}

_id_98FF(var_0, var_1) {
  var_2 = self;

  if(_id_0547::_id_5565(var_2._id_0A4B, "zombie_fireman") || var_2 maps\mp\agents\humanoid\_humanoid_util::_id_56BC() || common_scripts\utility::_id_562E(var_2.isteslastunimmune))
    var_2 thread _id_98EE(var_0, var_1.player, var_1._id_8CD7, var_1._id_953E, 0);
  else {
    var_3 = _id_8317(var_0, var_1.player);
    var_2 thread _id_0547::_id_7D1A("tesla_shock", [var_3], 4);
  }
}

_id_98EE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self;

  if(!isalive(var_7)) {
    return;
  }
  if(!isDefined(var_0)) {
    if(isDefined(var_1))
      var_0 = var_1.origin;
    else if(isDefined(var_7))
      var_0 = var_7.origin;
  }

  var_8 = "head_sparks";

  if(isDefined(var_5))
    var_8 = var_5;

  foreach(var_10 in ["j_head", "j_spine4"]) {
    if(-1 == var_7 _meth_8445(var_10)) {
      continue;
    }
    _func_147(common_scripts\utility::_id_44F5(var_8), var_7, var_10);
    break;
  }

  var_12 = 2000;

  if(isDefined(var_3) && issubstr(var_3, "teslagun_pap_zm"))
    var_12 = 6000;

  if(isDefined(var_7._id_0A4B))
    var_12 = [[var_7 maps\mp\agents\_agent_utility::_id_0A59("tesla_delayed_dmg")]](var_12, var_4, var_6);

  var_7 endon("death");
  var_7._id_172A = 0;

  if(!isDefined(var_3))
    var_3 = "teslagun_zm";

  var_7 _meth_8059(var_12, var_0, var_1, var_7, var_2, var_3);
}

_id_4382() {
  return int(3);
}

_id_98E9(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_0547::_id_408F();
  var_8 = _func_0DA(var_1);

  if(isDefined(var_3))
    var_7 = common_scripts\utility::_id_0F93(var_7, var_3);

  foreach(var_10 in var_7) {
    if(distancesquared(var_10.origin, var_0) > var_8) {
      continue;
    }
    var_10 thread _id_98EE(var_0, var_2, "MOD_ENERGY", var_4, 1, undefined, var_6);
  }

  radiusdamage(var_0, var_1, _id_4382(), _id_4382(), var_2, "MOD_ENERGY", var_4);
  _func_176(var_0, var_1, 0, 1.7);
}

_id_98FA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5._id_8FAD = var_1;
  var_5._id_9014 = var_2;
  var_5._id_606B = var_3;
  var_5._id_A0A7 = var_4;
  var_5._id_953E = var_0;
  level thread maps\mp\_utility::_id_6F74(::_id_98F9, var_5);
}

_id_98F7(var_0) {
  var_1 = self;

  if(!isalive(var_0)) {
    return;
  }
  var_2 = undefined;

  foreach(var_4 in ["j_head", "j_spine4"]) {
    if(-1 == var_0 _meth_8445(var_4)) {
      continue;
    }
    var_2 = var_4;
    break;
  }

  if(!isDefined(var_2)) {
    return;
  }
  _id_98EA(var_1, "tag_origin", var_0, var_2, var_1._id_953E);
}

_id_98F8(var_0, var_1) {
  var_2 = self;
  var_0 thread _id_98EE(var_2.origin, var_2.player, "MOD_ENERGY", var_2._id_953E, 1, var_1);
}

_id_98FC() {
  var_0 = self;
  var_0 endon("death");
  var_1 = 30.0;
  var_2 = [];
  var_3 = 0;

  for(;;) {
    waitframe();

    foreach(var_5 in _id_0547::_id_408F()) {
      if(!isalive(var_5)) {
        continue;
      }
      var_6 = 30;

      if(isDefined(var_5._id_8303))
        var_6 = var_5._id_8303;

      if(_func_0E1(var_5.origin, var_0.origin) > var_6 + var_1) {
        continue;
      }
      var_7 = 70;

      if(isDefined(var_5._id_8302))
        var_7 = var_5._id_8302;

      if(var_0.origin[2] < var_5.origin[2] - var_1 || var_0.origin[2] > var_5.origin[2] + var_7 + var_1) {
        continue;
      }
      var_8 = var_5 getentitynumber();

      if(isDefined(var_2[var_8])) {
        continue;
      }
      var_2[var_8] = 1;

      if(issubstr(var_0._id_953E, "moon"))
        var_0 _id_0583::_id_63FC(var_5);
      else {
        var_0 _id_98F7(var_5);
        var_0 _id_98F8(var_5);
      }

      var_3++;

      if(var_3 == 4) {
        var_3 = 0;
        waitframe();
      }
    }
  }
}

_id_98F9(var_0) {
  var_1 = self;

  for(;;) {
    var_1 waittill("weapon_fired", var_2);

    if(!_id_0547::_id_5565(var_2, var_0._id_953E)) {
      continue;
    }
    var_3 = [[var_0._id_8FAD]]();
    var_4 = [[var_0._id_9014]]();
    var_5 = [[var_0._id_606B]]();
    var_6 = var_1 _meth_8566();
    var_7 = anglesToForward(var_6);
    var_8 = anglestoup(var_6);
    var_9 = var_1 getEye() + var_7 * var_3 + var_8 * var_4;
    var_10 = bulletTrace(var_9, var_9 + var_5 * var_7, 0, undefined, 0, 0, 0, 0, 0, 0, 0);
    var_11 = spawn("script_model", var_9);
    var_11.angles = var_1.angles;
    var_11 setModel("tag_origin");
    var_11._id_2DA7 = var_10["position"];
    var_11._id_2F0C = vectorNormalize(var_11._id_2DA7 - var_11.origin);
    var_11._id_9B7F = var_10["fraction"];
    var_11.player = var_1;
    var_11._id_953E = var_0._id_953E;
    var_11 thread _id_98FB();
    var_11 thread _id_98FC();
    var_11 thread[[var_0._id_A0A7]]();
  }
}

_id_98FB() {
  var_0 = self;
  var_0 endon("death");
  var_0.player waittill("disconnect");
  var_0.player = undefined;
}

tesla_ammo_tracker(var_0) {
  self endon("death");
  level endon(var_0 + "_stop_tracking");

  for(;;) {
    common_scripts\utility::_id_A70C(self, "missile_fire", level, "maxAmmoPickup", self, "heavyMeleeClip_earned");

    if(self _meth_8319(var_0)) {
      self._id_A2AF[var_0] = self getweaponammostock(var_0);
      self._id_A2B0[var_0] = self getweaponammoclip(var_0);
    }
  }
}

tesla_drop_watcher(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  for(;;) {
    var_3 = var_0 common_scripts\utility::_id_A715("bleedout", "weapon_change", "becameSpectator", "disconnect", "death");

    if(var_3 == "weapon_change") {
      if(_id_0547::_id_577E(var_0))
        continue;
      else if(!_id_0547::_id_73F9(var_0, var_1)) {
        if(var_2)
          tesla_variant_set_available(var_1);

        level notify(var_1 + "_stop_tracking");
        return;
      }
    } else if(var_3 == "bleedout" || var_3 == "becameSpectator" || var_3 == "disconnect") {
      if(var_2)
        tesla_variant_set_available(var_1);

      return;
    }
  }
}

init_variant_structs_simple() {
  if(!isDefined(level._id_AACA))
    level._id_AACA = [];

  var_0 = _id_43B4();

  foreach(var_2 in var_0)
  level._id_AACA[var_2] = tesla_variant_struct_init(var_2);
}

tesla_variant_struct_init(var_0) {
  var_1 = spawnStruct();
  var_1._id_A9E0 = var_0;
  var_1._id_2916 = "not built";
  var_1._id_2909 = undefined;
  return var_1;
}

tesla_variant_check_if_available(var_0) {
  if(!isDefined(var_0) || !isDefined(level._id_AACA) || !isDefined(level._id_AACA[var_0])) {}

  if(level._id_AACA[var_0]._id_2916 == "available" || level._id_AACA[var_0]._id_2916 == "not built")
    return 1;
  else
    return 0;
}

tesla_variant_set_available(var_0) {
  level._id_AACA[var_0]._id_2916 = "available";
  level._id_AACA[var_0]._id_2909 = undefined;
}

tesla_variant_set_taken(var_0, var_1) {
  level._id_AACA[var_0]._id_2916 = "taken";
  level._id_AACA[var_0]._id_2909 = var_1;
}

_id_5533(var_0) {
  if(!_func_031(var_0))
    return 0;

  return issubstr(var_0, "teslagun");
}

_id_408C() {
  var_0 = common_scripts\utility::_id_0F73(["teslagun_zm"], _id_43B4());
  var_0 = common_scripts\utility::_id_0F73(["teslagun_pap_zm"], var_0);
  return var_0;
}

_id_43B4() {
  return ["teslagun_zm_blood", "teslagun_zm_death", "teslagun_zm_moon", "teslagun_zm_storm"];
}

_id_563A(var_0) {
  if(!_func_031(var_0))
    return 0;

  return common_scripts\utility::_id_0F79(_id_43B4(), var_0);
}

_id_4385() {
  var_0 = gettime();
  var_1 = var_0 * 0.001;
  return var_1;
}

_id_40C5(var_0) {
  switch (var_0) {
    case "teslagun_zm_blood":
      return "zmb_tesla_blood_beam";
    case "teslagun_zm_moon":
      return "zmb_tesla_moon_beam";
    case "teslagun_zm_death":
      return "zmb_tesla_death_beam";
    case "teslagun_zm_storm":
      return "zmb_tesla_storm_beam";
    default:
      return "zmb_tesla_reg_beam";
  }
}

_id_98EB(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _func_382(_id_40C5(var_4), var_0, var_1, var_2, var_3);
  wait(level._id_98F5._id_0F43);
  var_5 delete();
}

_id_98EA(var_0, var_1, var_2, var_3, var_4) {
  level thread _id_98EB(var_0, var_1, var_2, var_3, var_4);
}

_id_8317(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_29A8 = var_0;
  var_4.player = var_1;
  var_4._id_6AA0 = var_2;
  var_4._id_8365 = var_3;
  return var_4;
}

_id_8316(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1._id_98EF = 1;
  var_1._id_172A = 1;
  var_2 = "scripted_tesla_shock";

  if(var_1 maps\mp\agents\humanoid\_humanoid_util::_id_56BC())
    var_2 = "stun_hold";

  var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_2);

  if(isDefined(var_3)) {
    thread maps\mp\agents\humanoid\_humanoid_util::_id_8318(self.origin, self.angles, var_3, undefined, 0, undefined, 1, 1, undefined, "stop_shock");
    var_1 _id_9901(var_0._id_8365);

    for(;;) {
      var_4 = var_1._id_98F0 - _id_4385();

      if(var_4 <= 0) {
        break;
      }

      wait(var_4);
    }
  }
}

_id_8315(var_0) {
  var_1 = self;
  var_1._id_98EF = 0;
  var_1 notify("stop_shock");

  if(isDefined(var_0._id_6AA0))
    var_1 thread[[var_0._id_6AA0]](var_0);
  else
    var_1 thread _id_98EE(var_0._id_29A8, var_0.player, var_0._id_8CD7, var_0._id_953E, 0);
}