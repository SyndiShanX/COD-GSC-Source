/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1404.gsc
**************************************/

init() {
  if(isDefined(level.mapcustomkillstreakfunc)) {
    [[level.mapcustomkillstreakfunc]]();
  }

  level thread _id_057B::init();
  level thread extrainit();
  level.killstreakwieldweapons["orbital_carepackage_pod_zm_mp"] = "carepackage";
  level.ocp_weap_name = "orbital_carepackage_pod_zm_mp";
  level thread roundlogic();
}

extrainit() {
  level.teamemped["allies"] = 0;
  level.teamemped["axis"] = 0;
  level.orbitalsupportinuse = 0;
  level.missile_strike_gas_clouds = [];
}

bot_killstreak_setup() {
  var_0 = gettime();

  if(!isDefined(level.killstreak_botfunc)) {
    maps\mp\bots\_bots_ks::bot_register_killstreak_func("zm_squadmate", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
    maps\mp\bots\_bots_ks::bot_register_killstreak_func("uav", maps\mp\bots\_bots_ks::bot_killstreak_never_use, maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
    maps\mp\bots\_bots_ks::bot_register_killstreak_func("carepackage", maps\mp\bots\_bots_ks::bot_killstreak_never_use, maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
    maps\mp\bots\_bots_ks::bot_register_killstreak_func("missile_strike", maps\mp\bots\_bots_ks::bot_killstreak_never_use, maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
    maps\mp\bots\_bots_ks::bot_register_killstreak_func("airstrike", maps\mp\bots\_bots_ks::bot_killstreak_never_use, maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
  }
}

_id_0B81() {}

getEye() {
  var_0 = undefined;

  if(isDefined(level.zmscorestreaks) && level.zmscorestreaks.size > 0) {
    var_0 = level.zmscorestreaks[level.zmscorestreaks.size - 1];
  }

  level.zmscorestreaks = [];
  level.zmscorestreakindex = 0;
  var_1 = [];

  if(isDefined(level.zmgetscorestreaksforschedule)) {
    var_1 = [[level.zmgetscorestreaksforschedule]]();
  } else {
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
      level.zmscorestreaks[level.zmscorestreaks.size] = var_1[var_4];
      var_0 = var_1[var_4];
      var_1[var_4] = undefined;
      continue;
    }

    level.zmscorestreaks[level.zmscorestreaks.size] = level.zmscorestreaks[0];
    var_4 = getarraykeys(var_1)[0];
    level.zmscorestreaks[0] = var_1[var_4];
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
      if(!isDefined(var_2)) {
        return var_4;
      } else {
        var_3 = strtok(var_5, "_");
        var_5 = var_3[0];

        if(var_5 != var_2) {
          return var_4;
        }
      }
    }
  }

  return -1;
}

setupdroppositions() {
  level.zmcarepackagelandingspots = common_scripts\utility::getstructarray("carepackageDropPosition", "targetname");

  foreach(var_1 in level.zmcarepackagelandingspots) {
    var_1.indoors = isDefined(var_1.setlookatent) && var_1.setlookatent == "indoors";
    var_1.groundorg = var_1.origin;

    if(var_1.indoors) {
      var_2 = var_1.origin;
      var_3 = var_1.origin + (0, 0, -10000);
      var_4 = bulletTrace(var_2, var_3, 0);
      var_1.groundorg = var_4["position"];
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
  level.zmmoneyschedule = common_scripts\utility::array_randomize(var_0);
  level.zmmoneyscheduleindex = 0;
}

_id_45A8() {
  if(level.zmmoneyschedule.size == level.zmmoneyscheduleindex) {
    unlinkfromplayerview();
  }

  var_0 = level.zmmoneyschedule[level.zmmoneyscheduleindex];
  level.zmmoneyscheduleindex++;
  return var_0;
}

roundlogic() {
  level.zmcarepackagelandingspots = common_scripts\utility::getstructarray("carepackageDropPosition", "targetname");

  if(level.zmcarepackagelandingspots.size == 0) {
    return;
  }
  level.zmusedcarepackagelandingspots = [];
  level.getcratefordroptype = ::getcrate;
  level.zmkillstreakcrateprevo = 0;
  level.zmkillstreakcratereactvo = 0;
  level.zmkillstreakcratefirstvo = 0;
  thread setupdroppositions();
  thread getEye();
  thread unlinkfromplayerview();
  var_0 = _randomintrange(3, 5);

  for(;;) {
    level waittill("zombie_wave_started");

    while(level.wavecounter >= var_0) {
      var_1 = _randomfloatrange(20, 30);
      var_2 = level common_scripts\utility::waittill_notify_or_timeout_return("zombie_wave_ended", var_1);

      if(!isDefined(var_2) || var_2 != "timeout") {
        continue;
      }
      if(isDefined(level._id_671D) && level._id_671D == 1) {
        continue;
      }
      var_2 = dropcarepackage();

      if(isDefined(var_2)) {
        if(isDefined(level.roundsupplydrops)) {
          level.roundsupplydrops[level.roundsupplydrops.size] = var_2;
        }

        if(level.players.size == 4) {
          var_2 = dropcarepackage();

          if(isDefined(var_2) && isDefined(level.roundsupplydrops)) {
            level.roundsupplydrops[level.roundsupplydrops.size] = var_2;
          }
        }

        var_0 = var_0 + _randomintrange(2, 4);
      }
    }

    level waittill("zombie_wave_ended");
  }
}

getcloseplayertodroppoint(var_0) {
  var_1 = _sortbydistance(level.players, var_0);
  return var_1[0];
}

getcrate(var_0) {
  if(level.zmscorestreaks.size == level.zmscorestreakindex) {
    getEye();
  }

  var_4 = level.zmscorestreaks[level.zmscorestreakindex];
  level.zmscorestreakindex++;
  return var_4;
}

dropcarepackage(var_0) {
  var_1 = getowner();

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = getcratelandingspot(var_1);
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(!var_0.indoors) {
    var_2 = _id_0529::_id_4AAE(var_1, var_0, "zombies", []);

    if(isDefined(var_2) && !level.zmkillstreakcrateprevo) {
      var_1 = getcloseplayertodroppoint(var_0.origin);
      level.zmkillstreakcrateprevo = 1;
    }

    return var_2;
  } else
    return dropcratephysics(var_1, var_0);
}

dropcratephysics(var_0, var_1) {
  var_2 = "airdrop_assault";
  var_3 = getcrate(var_2);
  var_4 = var_0 _id_0514::createairdropcrate(var_0, var_2, var_3, var_1.origin, undefined, 0, 1);
  var_4 physicslaunchserver((0, 0, 0));
  var_4 thread _id_0529::cratedetectstopphysics();
  var_4 _id_0514::physicswaiter(var_2, var_3);
  return var_3;
}

getowner() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      return var_1;
    }
  }
}

getcratelandingspot(var_0) {
  var_1 = 2;
  var_2 = getvalidnodes();

  if(var_2.size == 0) {
    level.zmusedcarepackagelandingspots = [];
    var_2 = getvalidnodes();
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

    var_7 = carepackagetrace(var_6.groundorg, var_0);
    var_4++;

    if(var_7) {
      var_3 = var_6;
      break;
    }
  }

  if(isDefined(var_3)) {
    level.zmusedcarepackagelandingspots[level.zmusedcarepackagelandingspots.size] = var_3;
    return var_3;
  }
}

getvalidnodes() {
  var_0 = [];

  foreach(var_2 in level.zmcarepackagelandingspots) {
    if(common_scripts\utility::_id_0F79(level.zmusedcarepackagelandingspots, var_2)) {
      continue;
    }
    if(isDefined(var_2._id_0165) && !common_scripts\utility::flag(var_2._id_0165)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

getslotnumber(var_0) {
  var_1 = undefined;
  var_2 = 2;
  var_3 = 5;

  for(var_4 = var_2; var_4 < var_3; var_4++) {
    var_5 = var_0.pers["killstreaks"][var_4];

    if(!isDefined(var_5) || !isDefined(var_5.streakname) || var_5.available == 0) {
      var_1 = var_4;
      break;
    }
  }

  return var_1;
}

handlekillstreaklimit(var_0) {
  if(!isDefined(getslotnumber(var_0))) {
    showstreaklimitreached(var_0);
    return 1;
  }

  return 0;
}

showstreaklimitreached(var_0) {
  var_0 iprintlnbold(&"ZOMBIES_STREAK_LIMIT");
}

_id_2454(var_0) {
  var_1 = 26;

  foreach(var_3 in level._id_6C20) {
    var_4 = var_1 * 2;
    var_5 = var_4 * var_4;
    var_6 = _distance2dsquared(var_3.origin, var_0);

    if(var_6 < var_5) {
      return 1;
    }
  }

  return 0;
}

carepackagetrace(var_0, var_1) {
  var_2 = 100;
  var_3 = 26;
  return _capsuletracepassed(var_0 + (0, 0, 6), var_3, var_2, var_1, 0);
}

_id_5A5F(var_0) {
  self endon("death");

  if(!level.zmkillstreakcratereactvo) {
    var_1 = getcloseplayertodroppoint(self.origin);
    level.zmkillstreakcratereactvo = 1;
  }

  self._id_0117 = undefined;
  var_2 = self._id_944E;
  var_3 = isDefined(self._id_0117) && self._id_0117 maps\mp\_utility::_hasperk("specialty_highroller");
  var_4 = undefined;

  if(var_3) {
    var_4 = &"MP_PACKAGE_REROLL";
  }

  var_5 = undefined;

  if(isDefined(game["strings"][var_0 + self.cratetype + "_hint"])) {
    var_5 = game["strings"][var_0 + self.cratetype + "_hint"];
  } else {
    var_5 = &"PLATFORM_GET_KILLSTREAK";
  }

  _id_0514::cratesetuphintstrings(var_5, var_4);
  _id_0514::cratesetupforuse("all", _id_051E::getkillstreakcrateicon(var_2));
  thread _id_274F();

  for(;;) {
    self waittill("captured", var_1);
    var_6 = getslotnumber(var_1);
    var_2 = self._id_944E;

    if(isDefined(self._id_0117) && var_1 != self._id_0117) {
      if(!level.teambased || var_1.team != self.team) {
        var_1 thread _id_047A::hijackerevent(self._id_0117);
      } else {
        self._id_0117 thread _id_047A::sharedevent();
      }
    }

    var_1 playlocalsound("orbital_pkg_use");

    if(!level.zmkillstreakcratefirstvo) {
      level.zmkillstreakcratefirstvo = 1;
    } else {}

    var_1 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_2, undefined, undefined, var_6);
    var_1 thread _id_051E::givekillstreak(var_2, 0, 0, var_1, var_6);
    _id_0514::deletecrate(1);
  }
}

_id_274F(var_0, var_1) {
  self endon("captured");
  var_2 = self;

  if(isDefined(self._id_6C62)) {
    var_2 = self._id_6C62;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  while(isDefined(self)) {
    var_2 waittill("trigger", var_3);

    if(isDefined(self._id_0117) && var_3 == self._id_0117) {
      continue;
    }
    if(!var_1 && handlekillstreaklimit(var_3)) {
      continue;
    }
    if(var_3 isjumping() || isDefined(var_3._id_3900) && var_3._id_3900) {
      continue;
    }
    if(!var_3 isonground() && !_id_0514::waitplayerstuckoncarepackagereturn(var_3)) {
      continue;
    }
    if(!_id_0514::validateopenconditions(var_3)) {
      continue;
    }
    var_3.iscapturingcrate = 1;
    var_4 = _id_0514::_id_2836();
    var_5 = 0;

    if(self.cratetype == "booby_trap") {
      var_5 = var_4 _id_0514::useholdthink(var_3, 500, var_0);
    } else {
      var_5 = var_4 _id_0514::useholdthink(var_3, 2000, var_0);
    }

    if(isDefined(var_4)) {
      var_4 delete();
    }

    if(!var_5) {
      if(isDefined(var_3)) {
        var_3.iscapturingcrate = 0;
      }

      continue;
    }

    var_3.iscapturingcrate = 0;

    if(isDefined(level.numzombierewarddrops)) {
      level.numzombierewarddrops--;
    }

    self notify("captured", var_3);
  }
}

moneycratethink(var_0) {
  self endon("death");
  self._id_0117 = undefined;
  var_1 = undefined;

  if(isDefined(game["strings"][var_0 + self.cratetype + "_hint"])) {
    var_1 = game["strings"][var_0 + self.cratetype + "_hint"];
  } else {
    var_1 = &"PLATFORM_GET_KILLSTREAK";
  }

  _id_0514::cratesetuphintstrings(var_1);
  _id_0514::cratesetupforuse("all", "hud_carepkg_world_credits");
  thread _id_274F(undefined, 1);

  for(;;) {
    self waittill("captured", var_2);
    var_2 playlocalsound("zmb_ss_credits_acquire");
    var_3 = _id_45A8();
    var_2 maps\mp\gametypes\zombies::givepointsforevent("crate", var_3, 1);
    _id_0514::deletecrate(1);
  }
}

_id_62A8(var_0, var_1, var_2, var_3) {
  var_4 = var_2;

  if(isPlayer(var_1) && _isagent(var_0)) {
    return var_4 * level.wavecounter;
  }

  switch (var_3) {
    case "ugv_missile_mp":
    case "drone_assault_remote_turret_mp":
    case "killstreakmahem_mp":
    case "remote_energy_turret_mp":
    case "sentry_minigun_mp":
      if(_id_0547::istrapresistant()) {
        var_4 = int(var_4 * 0.1);
      } else {
        var_4 = var_4 * 3;
      }

      break;
    case "turretheadmg_mp":
      var_4 = 200 + level.wavecounter * 10;
      break;
    case "turretheadrocket_mp":
      var_4 = 800 + level.wavecounter * _randomintrange(50, 75);
      break;
    case "turretheadenergy_mp":
      var_4 = var_4 * 3 + int(level.wavecounter / 2);
      break;
    default:
      break;
  }

  return var_4;
}