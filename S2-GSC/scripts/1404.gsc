/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1404.gsc
**************************************/

init() {
  if(isDefined(level._id_5FEC))
    [[level._id_5FEC]]();

  level thread _id_057B::init();
  level thread _id_398E();
  level._id_5A7D["orbital_carepackage_pod_zm_mp"] = "carepackage";
  level._id_69A6 = "orbital_carepackage_pod_zm_mp";
  level thread _id_7F1C();
}

_id_398E() {
  level.teamemped["allies"] = 0;
  level.teamemped["axis"] = 0;
  level._id_6C25 = 0;
  level._id_6241 = [];
}

_id_1A4E() {
  var_0 = gettime();

  if(!isDefined(level._id_5A59)) {
    maps\mp\bots\_bots_ks::_id_1AB3("zm_squadmate", maps\mp\bots\_bots_ks::_id_1A50);
    maps\mp\bots\_bots_ks::_id_1AB3("uav", maps\mp\bots\_bots_ks::_id_1A4B, maps\mp\bots\_bots_ks::_id_1A3E);
    maps\mp\bots\_bots_ks::_id_1AB3("carepackage", maps\mp\bots\_bots_ks::_id_1A4B, maps\mp\bots\_bots_ks::_id_1A3E);
    maps\mp\bots\_bots_ks::_id_1AB3("missile_strike", maps\mp\bots\_bots_ks::_id_1A4B, maps\mp\bots\_bots_ks::_id_1A3E);
    maps\mp\bots\_bots_ks::_id_1AB3("airstrike", maps\mp\bots\_bots_ks::_id_1A4B, maps\mp\bots\_bots_ks::_id_1A3E);
  }
}

_id_0B81() {}

geteye() {
  var_0 = undefined;

  if(isDefined(level._id_AB45) && level._id_AB45.size > 0)
    var_0 = level._id_AB45[level._id_AB45.size - 1];

  level._id_AB45 = [];
  level._id_AB44 = 0;
  var_1 = [];

  if(isDefined(level._id_AB30))
    var_1 = [[level._id_AB30]]();
  else {
    var_1[var_1.size] = "sentry_" + _randomintrange(1, 4);
    var_1[var_1.size] = "drone_" + _randomintrange(1, 3);
    var_1[var_1.size] = "money";
    var_1[var_1.size] = "camo";
    var_1[var_1.size] = "sentry_" + _randomintrange(1, 4);
    var_1[var_1.size] = "drone_" + _randomintrange(1, 3);
    var_1[var_1.size] = "money";
    var_1[var_1.size] = "camo";
  }

  var_1 = common_scripts\utility::array_randomize(var_1);
  var_2 = var_1.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = _id_45AC(var_1, var_2, var_0);

    if(var_4 != -1) {
      level._id_AB45[level._id_AB45.size] = var_1[var_4];
      var_0 = var_1[var_4];
      var_1[var_4] = undefined;
      continue;
    }

    level._id_AB45[level._id_AB45.size] = level._id_AB45[0];
    var_4 = getarraykeys(var_1)[0];
    level._id_AB45[0] = var_1[var_4];
  }
}

_id_45AC(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = strtok(var_2, "_");
    var_2 = var_3[0];
  }

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = var_0[var_4];

    if(isDefined(var_5)) {
      if(!isDefined(var_2))
        return var_4;
      else {
        var_3 = strtok(var_5, "_");
        var_5 = var_3[0];

        if(var_5 != var_2)
          return var_4;
      }
    }
  }

  return -1;
}

_id_8A17() {
  level._id_AB20 = common_scripts\utility::_id_46B7("carepackageDropPosition", "targetname");

  foreach(var_1 in level._id_AB20) {
    var_1._id_510A = isDefined(var_1.setlookatent) && var_1.setlookatent == "indoors";
    var_1._id_4882 = var_1.origin;

    if(var_1._id_510A) {
      var_2 = var_1.origin;
      var_3 = var_1.origin + (0, 0, -10000);
      var_4 = bulletTrace(var_2, var_3, 0);
      var_1._id_4882 = var_4["position"];
    }

    waitframe();
  }
}

unlinkfromplayerview() {
  var_0 = [];
  var_0[var_0.size] = 100;
  var_0[var_0.size] = 100;
  var_0[var_0.size] = 300;
  var_0[var_0.size] = 400;
  var_0[var_0.size] = 600;
  var_0[var_0.size] = 700;
  var_0[var_0.size] = 800;
  var_0[var_0.size] = 1000;
  level._id_AB38 = common_scripts\utility::array_randomize(var_0);
  level._id_AB39 = 0;
}

_id_45A8() {
  if(level._id_AB38.size == level._id_AB39)
    unlinkfromplayerview();

  var_0 = level._id_AB38[level._id_AB39];
  level._id_AB39++;
  return var_0;
}

_id_7F1C() {
  level._id_AB20 = common_scripts\utility::_id_46B7("carepackageDropPosition", "targetname");

  if(level._id_AB20.size == 0) {
    return;
  }
  level._id_AB47 = [];
  level._id_4477 = ::_id_4476;
  level._id_AB34 = 0;
  level._id_AB35 = 0;
  level._id_AB33 = 0;
  thread _id_8A17();
  thread geteye();
  thread unlinkfromplayerview();
  var_0 = _randomintrange(3, 5);

  for(;;) {
    level waittill("zombie_wave_started");

    while(level._id_A980 >= var_0) {
      var_1 = _randomfloatrange(20, 30);
      var_2 = level common_scripts\utility::_id_A74D("zombie_wave_ended", var_1);

      if(!isDefined(var_2) || var_2 != "timeout") {
        continue;
      }
      if(isDefined(level._id_671D) && level._id_671D == 1) {
        continue;
      }
      var_2 = _id_3493();

      if(isDefined(var_2)) {
        if(isDefined(level._id_7F25))
          level._id_7F25[level._id_7F25.size] = var_2;

        if(level.players.size == 4) {
          var_2 = _id_3493();

          if(isDefined(var_2) && isDefined(level._id_7F25))
            level._id_7F25[level._id_7F25.size] = var_2;
        }

        var_0 = var_0 + _randomintrange(2, 4);
      }
    }

    level waittill("zombie_wave_ended");
  }
}

_id_4460(var_0) {
  var_1 = _sortbydistance(level.players, var_0);
  return var_1[0];
}

_id_4476(var_0) {
  if(level._id_AB45.size == level._id_AB44)
    geteye();

  var_4 = level._id_AB45[level._id_AB44];
  level._id_AB44++;
  return var_4;
}

_id_3493(var_0) {
  var_1 = _id_45F6();

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = _id_4478(var_1);

  if(!isDefined(var_0)) {
    return;
  }
  if(!var_0._id_510A) {
    var_2 = _id_0529::_id_4AAE(var_1, var_0, "zombies", []);

    if(isDefined(var_2) && !level._id_AB34) {
      var_1 = _id_4460(var_0.origin);
      level._id_AB34 = 1;
    }

    return var_2;
  } else
    return _id_3495(var_1, var_0);
}

_id_3495(var_0, var_1) {
  var_2 = "airdrop_assault";
  var_3 = _id_4476(var_2);
  var_4 = var_0 _id_0514::_id_27CB(var_0, var_2, var_3, var_1.origin, undefined, 0, 1);
  var_4 physicslaunchserver((0, 0, 0));
  var_4 thread _id_0529::_id_2745();
  var_4 _id_0514::_id_6FAD(var_2, var_3);
  return var_3;
}

_id_45F6() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      return var_1;
  }
}

_id_4478(var_0) {
  var_1 = 2;
  var_2 = _id_470A();

  if(var_2.size == 0) {
    level._id_AB47 = [];
    var_2 = _id_470A();
  }

  var_2 = common_scripts\utility::array_randomize(var_2);
  var_3 = undefined;
  var_4 = 0;

  foreach(var_6 in var_2) {
    if(_id_2454(var_6.origin)) {
      continue;
    }
    if(var_4 >= var_1) {
      waitframe();
      var_4 = 0;
    }

    var_7 = _id_1FFF(var_6._id_4882, var_0);
    var_4++;

    if(var_7) {
      var_3 = var_6;
      break;
    }
  }

  if(isDefined(var_3)) {
    level._id_AB47[level._id_AB47.size] = var_3;
    return var_3;
  }
}

_id_470A() {
  var_0 = [];

  foreach(var_2 in level._id_AB20) {
    if(common_scripts\utility::_id_0F79(level._id_AB47, var_2)) {
      continue;
    }
    if(isDefined(var_2._id_0165) && !common_scripts\utility::_id_3C77(var_2._id_0165)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_4689(var_0) {
  var_1 = undefined;
  var_2 = 2;
  var_3 = 5;

  for(var_4 = var_2; var_4 < var_3; var_4++) {
    var_5 = var_0.pers["killstreaks"][var_4];

    if(!isDefined(var_5) || !isDefined(var_5._id_944C) || var_5._id_13AF == 0) {
      var_1 = var_4;
      break;
    }
  }

  return var_1;
}

_id_4AD0(var_0) {
  if(!isDefined(_id_4689(var_0))) {
    _id_8C1A(var_0);
    return 1;
  }

  return 0;
}

_id_8C1A(var_0) {
  var_0 iprintlnbold(&"ZOMBIES_STREAK_LIMIT");
}

_id_2454(var_0) {
  var_1 = 26;

  foreach(var_3 in level._id_6C20) {
    var_4 = var_1 * 2;
    var_5 = var_4 * var_4;
    var_6 = _distance2dsquared(var_3.origin, var_0);

    if(var_6 < var_5)
      return 1;
  }

  return 0;
}

_id_1FFF(var_0, var_1) {
  var_2 = 100;
  var_3 = 26;
  return _capsuletracepassed(var_0 + (0, 0, 6), var_3, var_2, var_1, 0);
}

_id_5A5F(var_0) {
  self endon("death");

  if(!level._id_AB35) {
    var_1 = _id_4460(self.origin);
    level._id_AB35 = 1;
  }

  self._id_0117 = undefined;
  var_2 = self._id_944E;
  var_3 = isDefined(self._id_0117) && self._id_0117 maps\mp\_utility::_hasperk("specialty_highroller");
  var_4 = undefined;

  if(var_3)
    var_4 = &"MP_PACKAGE_REROLL";

  var_5 = undefined;

  if(isDefined(game["strings"][var_0 + self._id_275E + "_hint"]))
    var_5 = game["strings"][var_0 + self._id_275E + "_hint"];
  else
    var_5 = &"PLATFORM_GET_KILLSTREAK";

  _id_0514::_id_275B(var_5, var_4);
  _id_0514::_id_275A("all", _id_051E::_id_4533(var_2));
  thread _id_274F();

  for(;;) {
    self waittill("captured", var_1);
    var_6 = _id_4689(var_1);
    var_2 = self._id_944E;

    if(isDefined(self._id_0117) && var_1 != self._id_0117) {
      if(!level.teambased || var_1.team != self.team)
        var_1 thread _id_047A::_id_4D4F(self._id_0117);
      else
        self._id_0117 thread _id_047A::_id_8AD6();
    }

    var_1 playlocalsound("orbital_pkg_use");

    if(!level._id_AB33)
      level._id_AB33 = 1;
    else {}

    var_1 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_2, undefined, undefined, var_6);
    var_1 thread _id_051E::_id_478D(var_2, 0, 0, var_1, var_6);
    _id_0514::_id_2D30(1);
  }
}

_id_274F(var_0, var_1) {
  self endon("captured");
  var_2 = self;

  if(isDefined(self._id_6C62))
    var_2 = self._id_6C62;

  if(!isDefined(var_1))
    var_1 = 0;

  while(isDefined(self)) {
    var_2 waittill("trigger", var_3);

    if(isDefined(self._id_0117) && var_3 == self._id_0117) {
      continue;
    }
    if(!var_1 && _id_4AD0(var_3)) {
      continue;
    }
    if(var_3 isjumping() || isDefined(var_3._id_3900) && var_3._id_3900) {
      continue;
    }
    if(!var_3 isonground() && !_id_0514::_id_A6F8(var_3)) {
      continue;
    }
    if(!_id_0514::_id_A276(var_3)) {
      continue;
    }
    var_3._id_56A1 = 1;
    var_4 = _id_0514::_id_2836();
    var_5 = 0;

    if(self._id_275E == "booby_trap")
      var_5 = var_4 _id_0514::_id_A213(var_3, 500, var_0);
    else
      var_5 = var_4 _id_0514::_id_A213(var_3, 2000, var_0);

    if(isDefined(var_4))
      var_4 delete();

    if(!var_5) {
      if(isDefined(var_3))
        var_3._id_56A1 = 0;

      continue;
    }

    var_3._id_56A1 = 0;

    if(isDefined(level._id_68A1))
      level._id_68A1--;

    self notify("captured", var_3);
  }
}

_id_62D5(var_0) {
  self endon("death");
  self._id_0117 = undefined;
  var_1 = undefined;

  if(isDefined(game["strings"][var_0 + self._id_275E + "_hint"]))
    var_1 = game["strings"][var_0 + self._id_275E + "_hint"];
  else
    var_1 = &"PLATFORM_GET_KILLSTREAK";

  _id_0514::_id_275B(var_1);
  _id_0514::_id_275A("all", "hud_carepkg_world_credits");
  thread _id_274F(undefined, 1);

  for(;;) {
    self waittill("captured", var_2);
    var_2 playlocalsound("zmb_ss_credits_acquire");
    var_3 = _id_45A8();
    var_2 maps\mp\gametypes\zombies::_id_47AE("crate", var_3, 1);
    _id_0514::_id_2D30(1);
  }
}

_id_62A8(var_0, var_1, var_2, var_3) {
  var_4 = var_2;

  if(isPlayer(var_1) && _isagent(var_0))
    return var_4 * level._id_A980;

  switch (var_3) {
    case "ugv_missile_mp":
    case "drone_assault_remote_turret_mp":
    case "killstreakmahem_mp":
    case "remote_energy_turret_mp":
    case "sentry_minigun_mp":
      if(_id_0547::_id_580A())
        var_4 = int(var_4 * 0.1);
      else
        var_4 = var_4 * 3;

      break;
    case "turretheadmg_mp":
      var_4 = 200 + level._id_A980 * 10;
      break;
    case "turretheadrocket_mp":
      var_4 = 800 + level._id_A980 * _randomintrange(50, 75);
      break;
    case "turretheadenergy_mp":
      var_4 = var_4 * 3 + int(level._id_A980 / 2);
      break;
    default:
      break;
  }

  return var_4;
}