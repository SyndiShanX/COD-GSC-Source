/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_events.gsc
***************************************/

init() {
  setdvarifuninitialized("set scr_dom_score_kill", "");
  setdvarifuninitialized("set scr_dom_score_divisions_infantry_kill", "");
  setdvarifuninitialized("set scr_dom_score_divisions_airborne_kill", "");
  setdvarifuninitialized("set scr_dom_score_divisions_armored_kill", "");
  setdvarifuninitialized("set scr_dom_score_divisions_mountain_kill", "");
  setdvarifuninitialized("set scr_dom_score_divisions_cavalry_kill", "");
  setdvarifuninitialized("set scr_dom_score_division_resistance_kill", "");
  setdvarifuninitialized("set scr_dom_score_mg_nest_kill", "");
  setdvarifuninitialized("set scr_dom_score_assist_mid", "");
  setdvarifuninitialized("set scr_dom_score_assist_high", "");
  setdvarifuninitialized("set scr_dom_score_assist_steal", "");
  setdvarifuninitialized("set scr_dom_score_assist_tactical", "");
  setdvarifuninitialized("set scr_dom_score_assist_painted", "");
  var_0 = getDvar("1924");
  var_1 = 0;
  var_2 = [];
  var_2["dm"] = 4;
  var_2["war"] = 5;
  var_2["sd"] = 6;
  var_2["dom"] = 7;
  var_2["conf"] = 8;
  var_2["sr"] = 9;
  var_2["infect"] = 10;
  var_2["gun"] = 11;
  var_2["ctf"] = 12;
  var_2["br"] = 13;
  var_2["twar"] = 14;
  var_2["hp"] = 15;
  var_2["ball"] = 16;
  var_2["lockdown"] = 17;
  var_2["hub"] = 18;
  var_2["demo"] = 19;
  var_2["raid"] = 20;
  var_2["prop"] = 22;
  var_2["spy"] = 23;
  var_2["blades"] = 24;
  var_2["scorestreak_training"] = 5;
  var_2["aon"] = 25;
  var_2["oitc"] = 26;
  var_2["undead"] = 27;
  var_2["relic"] = 28;

  for(;;) {
    if(!isDefined(var_2[var_0]))
      var_0 = "war";

    var_3 = _func_1AE("mp/xp_event_table.csv", var_1, 0);
    var_4 = _func_1AE("mp/xp_event_table.csv", var_1, 1);
    var_5 = _func_1AE("mp/xp_event_table.csv", var_1, 2);
    var_6 = _func_1AE("mp/xp_event_table.csv", var_1, var_2[var_0]);

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    if(var_3 == "win" || var_3 == "loss" || var_3 == "tie")
      var_6 = _func_0AD(var_6);
    else
      var_6 = int(var_6);

    if(var_6 != -1) {
      var_5 = int(var_5);
      var_4 = int(var_4);
      maps\mp\gametypes\_rank::_id_7C06(var_3, var_6, var_5, var_4);
    }

    var_1++;
  }

  level._id_6892 = 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_5A42 = [];
    var_0._id_5A43 = [];
    var_0._id_29BD = [];
    var_0._id_5A3C = [];
    var_0.recentkills = [];
    var_0._id_5BB1 = undefined;
    var_0._id_7AD2 = 0;
    var_0._id_5BB4 = 0;
    var_0._id_1D84 = 0;
    var_0._id_5B87 = 0;
  }
}

_id_5A40(var_0, var_1, var_2, var_3, var_4) {
  level._id_6892++;
  level._id_A239 = 0;
  var_5 = var_1.guid;
  var_6 = var_1.pers["cur_kill_streak"];
  var_7 = self.guid;
  var_8 = gettime();
  var_9 = [];
  maps\mp\gametypes\_missions::processchallenge("ch_career_kills");

  if(maps\mp\_utility::isbulletdamage(var_3)) {
    if(self._id_5BB4 == var_8)
      self._id_1D84++;
    else
      self._id_1D84 = 1;
  } else
    self._id_1D84 = 0;

  self._id_5BB4 = gettime();
  self._id_5BB2 = var_1;
  self._id_62A1 = [];
  self._id_29BD[var_5] = undefined;
  thread _id_A159(var_0, var_2);

  if(maps\mp\_utility::iskillstreakweapon(var_2)) {
    if(isDefined(level._id_5A7D) && isDefined(level._id_5A7D[var_2]))
      maps\mp\gametypes\_persistence::incrementscorestreakstat(level._id_5A7D[var_2], "killsOrAssists", 1);
  } else {
    if(var_2 == "none")
      return 0;

    if(isDefined(var_1.throwinggrenade)) {
      if(var_1.throwinggrenade == "frag_grenade_mp" || var_1.throwinggrenade == "frag_grenade_german_mp")
        self._id_62A1["cooking"] = 1;
    }

    if(weaponinventorytype(var_2) == "primary") {
      self._id_838A["killDistanceTotal"] = self._id_838A["killDistanceTotal"] + _func_0E1(self.origin, var_1.origin);
      self._id_838A["killDistanceCount"]++;
    }

    if(isDefined(common_scripts\utility::_id_0F7E(self._id_1193, var_1)))
      self notify("turned_on_battlecry");

    if(var_3 == "MOD_HEAD_SHOT")
      _id_4BF6(var_0, var_2, var_3);

    if(level.teambased && var_8 - var_1._id_5BB4 < 3000 && var_1._id_5BB2 != self)
      _id_13BA(var_0, var_2, var_3);

    if(ispostdeathkillevent(var_1, var_4))
      _id_75E2(var_0);

    if(isDefined(self._id_6E6B) && self._id_6E6B)
      maps\mp\gametypes\_missions::processchallenge("ch_commando_weapon");

    if(isDefined(self.basictrainingserumactive) && self.basictrainingserumactive)
      maps\mp\gametypes\_missions::processchallenge("ch_dlc4_catalyst");

    if(self.pers["cur_death_streak"] > 3)
      _id_2535(var_0, var_2, var_3);

    if(isDefined(self._id_10E9) && self._id_10E9)
      _id_10EA(var_0, var_2, var_3);

    if(_id_574D(self, var_2, var_3, var_1)) {
      _id_5EB3(var_0, var_2, var_3);
      var_9[var_9.size] = "longshot";
    }

    if(_id_57A8(var_1, var_8))
      _id_2C77(var_0, var_2, var_3);

    if(var_6 > 0 && _id_5698(var_1))
      _id_1DE7(var_0, var_1, var_2, var_3);

    if(_id_5766(var_1, var_2, var_3))
      _id_6B12(var_0, var_2, var_3);

    if(isDefined(self._id_5BB1) && self._id_5BB1 == var_1) {
      _id_7E3F(var_0, var_2);
      var_9[var_9.size] = "payback";
    }

    if(isDefined(var_1._id_5033) && var_1._id_5033 &level.idflags_penetration)
      _id_1D7E(var_0, var_2);

    if(_id_5789(var_1, var_3))
      _id_753F(var_0, var_2, var_3);

    if(isDefined(var_2) && var_2 == "boost_slam_mp")
      _id_191A(var_0, var_2, var_3);

    if(self.health < 20 && self.health > 0)
      _id_6634(var_2, var_3);

    if(self._id_57CF)
      _id_9131(var_2, var_3);

    if(isDefined(self._id_5BDE) && var_8 - self._id_5BDE < 2000)
      _id_1EC2(var_2, var_3);

    if(var_1 common_scripts\utility::_id_56B5())
      concusskillevent(var_0);

    if(var_1 common_scripts\utility::_id_5701())
      gaskillevent(var_0);

    if(var_1 common_scripts\utility::_id_56F2())
      flarekillevent(var_0);

    if(var_1 common_scripts\utility::_id_56F4())
      _id_3D4B(var_0);

    if(common_scripts\utility::_id_56F2() || common_scripts\utility::_id_56B5() || common_scripts\utility::_id_56F4())
      blindfightkillevent(var_2, var_3);

    if(common_scripts\utility::_id_56F2() || common_scripts\utility::_id_56B5() || common_scripts\utility::_id_5701() || common_scripts\utility::_id_56F4())
      _id_7E2E(var_1, "focused");

    if(common_scripts\utility::_id_57D0())
      _id_8C5D(var_2, var_3);

    if(_id_57F1(var_3))
      _id_7E2E(var_1, "thickskin");

    if(_id_5803(var_2, var_3))
      _id_9965();

    if(maps\mp\_utility::_hasperk("specialty_fastadsaftersprint"))
      _id_3A56();

    if(self._id_1D84 == 2)
      _id_6513();

    if(_id_57CE(var_2, var_3)) {
      _id_8C55();
      var_9[var_9.size] = "dediMelee";
    }

    if(_id_5681(var_1, var_2, var_3))
      _id_14EE(var_2);

    if(maps\mp\_utility::_id_5755(var_3))
      _id_60EB(var_2, var_3);

    if(_id_5805(var_1, var_2, var_3, var_4)) {
      _id_99A8();
      var_9[var_9.size] = "throwback";
    }

    if(_id_0513::_id_5747(var_2))
      _id_5CA9(var_1, var_2);

    if(_id_56A2(var_1))
      _id_2007();

    var_10 = undefined;

    if(maps\mp\_utility::_id_57E5(var_2, "alt_"))
      var_10 = getsubstr(var_2, 4);

    if(isDefined(self._id_6FBA[var_2]) && self._id_6FBA[var_2] == var_1 && !maps\mp\_utility::_id_5755(var_3)) {
      _id_95D1();
      var_9[var_9.size] = "backfire";
    } else if(isDefined(var_10) && isDefined(self._id_6FBA[var_10]) && self._id_6FBA[var_10] == var_1 && !maps\mp\_utility::_id_5755(var_3)) {
      _id_95D1();
      var_9[var_9.size] = "backfire";
    }

    if(isDefined(var_2) && var_2 == "iw5_carrydrone_mp")
      _id_5A83();

    if(isDefined(var_2) && var_2 == "relic_mp")
      killwithrelicevent();

    if(isDefined(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_ballcarrier")) {
      if(level.gametype == "ball")
        _id_5A3A();
      else if(level.gametype == "relic")
        killedreliccarrierevent();
    }

    if(_id_5757(self))
      _id_6161();

    if(self _meth_82E4() || self _meth_801D())
      _id_241E();

    _id_21C5(var_1, var_0, var_2, var_3, var_4);
    var_11 = _id_21C4(var_1);

    if(isDefined(var_11) && var_11)
      var_9[var_9.size] = "kingslayer";

    _id_21F2(var_1, var_2, var_3);

    if(isDefined(self._id_3448) && self._id_3448.size > 0) {
      foreach(var_13 in self._id_3448) {
        if(common_scripts\utility::_id_302B(self.origin, var_13.origin) <= 57600 && common_scripts\utility::_id_302B(var_1.origin, var_13.origin) <= 57600) {
          maps\mp\gametypes\_missions::processchallenge("ch_streak_trap");
          break;
        }
      }
    }
  }

  if(level._id_6892 == 1) {
    _id_3C63(var_0, var_2, var_3);

    if(level.gametype == "sd")
      maps\mp\_utility::_id_863E(21, self.team, self getentitynumber());
  }

  if(!level._id_53C7)
    _id_21E6(var_1);

  if(!isDefined(self._id_5A42[var_5]))
    self._id_5A42[var_5] = 0;

  if(!isDefined(self._id_5A43[var_5]))
    self._id_5A43[var_5] = 0;

  if(!isDefined(var_1._id_5A3C[var_7]))
    var_1._id_5A3C[var_7] = 0;

  self._id_5A42[var_5]++;
  self._id_5A43[var_5]++;
  var_1._id_5A3C[var_7]++;
  var_1._id_5BB1 = self;
  _id_0468::_id_0A23(var_1, var_2, var_3, var_9);

  if(self._id_0079 == 7) {
    if(isDefined(self.pers["grenadier_kills"]))
      self.pers["grenadier_kills"]++;
    else
      self.pers["grenadier_kills"] = 1;
  }

  if(isDefined(level.gametype) && level.gametype == "war") {
    if(self.pers["kills"] + 1 == 25)
      _id_0468::_id_0A22("tdm25kills");
  }

  if(isDefined(level.gametype) && level.gametype == "sd") {
    if(self.pers["kills"] + 1 == 10)
      _id_0468::_id_0A22("sdKiller");
  }

  if(maps\mp\_utility::_id_579B()) {
    if(self.pers["raidKillz"] + 1 == 45)
      _id_0468::_id_0A22("warKills45");
  }

  if(level.gametype == "ctf" && self.team != var_1.team && isDefined(var_1._id_2013)) {
    if(self.pers["defends"] + 1 == 3)
      _id_0468::_id_0A22("3KillsFlagCarrier");
  }

  if(level.gametype == "hp" && isDefined(level._id_AC7C._id_9D5E) && self istouching(level._id_AC7C._id_9D5E)) {
    if(!isDefined(self.killsonhp))
      self.killsonhp = 0;

    self.killsonhp++;

    if(self.killsonhp == 5)
      _id_0468::_id_0A22("5KillsOnHp");
  }
}

_id_5789(var_0, var_1) {
  if(maps\mp\_utility::isbulletdamage(var_1)) {
    var_2 = self.origin;
    var_3 = 9216;

    if(isDefined(var_0._id_1192))
      var_2 = var_0._id_1192;

    if(distancesquared(var_2, var_0.origin) < var_3)
      return 1;
  }

  return 0;
}

_id_753F(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("pointblank", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("pointblank", self, var_1, undefined, var_2);

  if(isDefined(var_1)) {
    var_3 = maps\mp\_utility::_id_4431(var_1, 1);

    if(maps\mp\_utility::_id_5856(var_3))
      var_3 = maps\mp\gametypes\_class::_id_4432(var_3);

    var_4 = maps\mp\gametypes\_missions::_id_40EE(var_1, var_3);

    if(issubstr(var_3, "dlcgun") && var_4 == "weapon_special")
      maps\mp\gametypes\_missions::processchallenge("ch_tier1_1_" + var_3);
    else
      maps\mp\gametypes\_missions::processchallenge("ch_pointblank_" + var_3);
  }
}

_id_5A41(var_0, var_1, var_2, var_3) {
  if(var_0 _meth_8347())
    level thread maps\mp\gametypes\_rank::_id_1457("killed_mg_nest", self, var_1, var_0, var_2, var_3);

  if(isDefined(var_0._id_A258) && var_0._id_A258)
    level thread maps\mp\gametypes\_rank::_id_1457("killed_flamethrower", self, var_1, var_0, var_2, var_3);

  if(isDefined(var_0._id_A25A) && var_0._id_A25A)
    level thread maps\mp\gametypes\_rank::_id_1457("killed_molotovs", self, var_1, var_0, var_2, var_3);

  if(isDefined(var_0.usingriotshield) && var_0.usingriotshield)
    level thread maps\mp\gametypes\_rank::_id_1457("killed_riotshield", self, var_1, var_0, var_2, var_3);

  if(_func_3AF() || isDefined(level._id_2F8B) && level._id_2F8B || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    var_4 = _id_43D6(var_1, var_2);

    if(var_4 == "kill") {
      var_4 = _id_04CB::_id_4499("kill", self, var_0, var_1, var_2);

      if(var_4 != "kill")
        self._id_62A1[var_4] = 1;
    }

    level thread maps\mp\gametypes\_rank::_id_1457(var_4, self, var_1, var_0, var_2, var_3);

    if(maps\mp\_utility::_id_579B()) {
      self._id_79A2++;
      maps\mp\_utility::setpersstat("raidKillz", self._id_79A2);
      self _meth_82FF("ui_onevone_class_1", self._id_79A2);
      maps\mp\gametypes\_persistence::statsetchild("round", "rescues", self._id_79A2);
      _id_6324();
    } else {
      maps\mp\_utility::incplayerstat("kills", 1);
      maps\mp\_utility::incpersstat("kills", 1);
      self._id_00E3 = maps\mp\_utility::getpersstat("kills");
    }

    return;
  }

  maps\mp\_utility::incplayerstat("kills", 1);
  maps\mp\_utility::incpersstat("kills", 1);
  self._id_00E3 = maps\mp\_utility::getpersstat("kills");
  _id_6324();
  maps\mp\gametypes\_persistence::statsetchild("round", "kills", self._id_00E3);
  _id_04CA::_id_50FC(self._id_0079, 1, "kills");

  if(maps\mp\_utility::getweaponclass(var_1) == _id_04CA::getdivisionweaponclass(self._id_0079))
    _id_04CA::_id_50FC(self._id_0079, 1, "weaponClassKills");

  maps\mp\_utility::updatepersratio("kdRatio", "kills", "deaths");
  var_4 = _id_43D6(var_1, var_2);

  if(var_4 != "kill") {
    maps\mp\_utility::incplayerstat(var_4, 1);
    maps\mp\gametypes\_missions::_id_20A0(var_4);
  } else if(isDefined(var_0) && isDefined(var_0._id_6E6B) && var_0._id_6E6B)
    var_4 = "tac_insert_kill";

  if(var_4 == "kill") {
    var_4 = _id_04CB::_id_4499(var_4, self, var_0, var_1, var_2);

    if(var_4 != "kill") {
      maps\mp\_utility::incplayerstat(var_4, 1);
      _id_04CA::_id_50FC(self._id_0079, 1, "skillKills");
      self._id_62A1[var_4] = 1;
    }
  }

  if(level._id_7616)
    thread _id_761F(var_0, var_4, var_1, var_2);

  level thread maps\mp\gametypes\_rank::_id_1457(var_4, self, var_1, var_0, var_2, var_3);
}

_id_6324(var_0) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_1 = maps\mp\gametypes\_persistence::statgetchild("round", "rescues");
  var_2 = maps\mp\gametypes\_persistence::statget("kills");

  if(isDefined(var_2) && isDefined(var_1) && var_1 + var_2 == 10)
    self _meth_80F0("MP_KILL_10");
}

_id_43D6(var_0, var_1) {
  switch (var_0) {
    case "carepackage_crate_mp":
      return "airdrop_kill";
    case "azon_projectile_grenadier_mp":
    case "fritzx_projectile_grenadier_mp":
    case "azon_projectile_mp":
    case "fritzx_projectile_mp":
      return "fritzx_kill";
    case "mortar_strike_projectile_axis_mp":
    case "mortar_strike_projectile_mp":
      return "mortar_strike_kill";
    case "missile_strike_projectile_axis_mp":
    case "missile_strike_projectile_mp":
      return "missile_strike_kill";
    case "v2_rocket_mp":
      return "v2_rocket_kill";
    case "airstrike_bomb_axis_mp":
    case "airstrike_bomb_mp":
      return "airstrike_kill";
    case "fighter_strike_gun_mp":
      return "fighter_strike_kill";
    case "firebomb_flames_mp":
    case "firebomb_bomb_axis_grenadier_mp":
    case "firebomb_bomb_grenadier_mp":
    case "firebomb_bomb_axis_mp":
    case "firebomb_bomb_mp":
      return "firebomb_kill";
    case "agent_mp":
      return "paratroopers_kill";
    case "agent_raid_fighters_mp":
      return "raid_fighters_kill";
    case "plane_gunner_bomber_projectile_mp":
    case "turretweapon_plane_gunner_turret_grenadier_mp":
    case "turretweapon_plane_gunner_turret_mp":
    case "turretweapon_plane_gunner_bomber_mp":
      return "plane_gunner_kill";
    case "flamethrower_german_grenadier_mp":
    case "flamethrower_grenadier_mp":
    case "flamethrower_german_mp":
    case "flamethrower_mp":
      if(isDefined(var_1) && !maps\mp\_utility::_id_5755(var_1))
        return "flamethrower_kill";

      break;
    case "thermite_flames_mp":
    case "killstreak_molotov_cocktail_grenadier_mp":
    case "killstreak_molotov_cocktail_mp":
      if(isDefined(var_1) && !maps\mp\_utility::_id_5755(var_1))
        return "molotovs_kill";

      break;
    case "turret_mg42_raid_stand_guardtower_mp":
    case "turret_mg42_raid_crouch_mp":
    case "turret_mg42_raid_stand_mp":
    case "turret_mg42_mp":
      return "mg_nest_kill";
    case "turretweapon_mg42_bucket_mp":
    case "turretweapon_usa_m1919_tank_sherman_bucket_mp":
    case "ger_tank_king_tiger_turret_snow_mp":
    case "ger_tank_king_tiger_turret_mp":
    case "usa_tank_sherman_turret_mp":
      return "raids_tank_turret_kill";
    case "killstreak_flak_gun_raids":
      if(maps\mp\_utility::isdogfightgametype())
        return "dogfight_flak_kill";
      else
        return "raid_flak_kill";
  }

  return "kill";
}

_id_761D() {
  return !isDefined(self._id_66AD) || gettime() > self._id_66AD;
}

_id_761C() {
  self._id_66AD = gettime() + _func_0A4(20000, 40000);
}

_id_761F(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");

  if(isbot(self)) {
    return;
  }
  self playlocalsound("ui_practice_round_kill");
  var_4 = 0.5;

  if(!isDefined(self._id_1730))
    self._id_1730 = self getplayerdata(common_scripts\utility::_id_46A7(), "bests", "kills");

  if(self._id_1730 > 0 && self._id_00E3 > self._id_1730) {
    _id_761C();
    wait(var_4);
    maps\mp\_utility::leaderdialogonplayer("ptr_new_best");
    self._id_1730 = 0;
  } else if(var_1 == "kill" && !maps\mp\_utility::_id_5755(var_3)) {
    if(var_3 == "MOD_HEAD_SHOT") {
      _id_761C();
      wait(var_4);
      maps\mp\_utility::leaderdialogonplayer("ptr_headshot");
    } else {
      if(!_id_761D()) {
        return;
      }
      _id_761C();
      wait(var_4);
      maps\mp\_utility::leaderdialogonplayer("ptr_greatshot");
    }
  }
}

_id_7617(var_0) {
  self endon("disconnect");
  level endon("game_ended");

  if(isbot(self)) {
    return;
  }
  var_1 = 0.5;
  _id_761C();
  wait(var_1);
  maps\mp\_utility::leaderdialogonplayer("ptr_assist");
}

_id_5803(var_0, var_1) {
  if(var_1 == "MOD_IMPACT" || var_1 == "MOD_HEAD_SHOT") {
    if(_id_5804(var_0))
      return 1;
  }

  return 0;
}

_id_5804(var_0) {
  switch (var_0) {
    case "smoke_grenade_axis_expeditionary_mp":
    case "smoke_grenade_expeditionary_mp":
    case "frag_grenade_german_mp":
    case "semtex_mp":
    case "paint_grenade_mp":
    case "emp_grenade_mp":
    case "stun_grenade__mp":
    case "smoke_grenade_axis_mp":
    case "smoke_grenade_mp":
    case "frag_grenade_mp":
      return 1;
    default:
      return 0;
  }
}

_id_3A56() {
  var_0 = gettime();

  if(isDefined(self._id_5BE3) && var_0 - self._id_5BE3 <= 2000 && maps\mp\_utility::_hasperk("specialty_sprintfire"))
    thread maps\mp\gametypes\_missions::processchallenge("ch_perks2_agile");
}

_id_9965() {
  maps\mp\_utility::incplayerstat("think_fast", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("think_fast", self);
}

_id_191A(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("boostslamkill", 1);
  thread maps\mp\gametypes\_missions::processchallenge("ch_limited_lookoutbelow", 1);
  thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_hot", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("boostslamkill", self, var_1, undefined, var_2);
}

_id_353A(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat(var_0 + "_earned", 1);
  level thread maps\mp\gametypes\_rank::_id_1457(var_0 + "_earned", self);
  thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_0, var_1, undefined, var_2);
  _id_0485::_id_5E99(var_0);
}

_id_1D7E(var_0, var_1) {
  maps\mp\_utility::incplayerstat("bulletpenkills", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("bulletpen", self);

  if(isDefined(var_1)) {
    var_2 = maps\mp\_utility::_id_4431(var_1, 1);

    if(maps\mp\_utility::_id_5856(var_2))
      var_2 = maps\mp\gametypes\_class::_id_4432(var_2);

    var_3 = maps\mp\gametypes\_missions::_id_40EE(var_1, var_2);

    if(var_3 == "weapon_sniper") {
      if(isDefined(level._id_20AA["ch_penetrate_" + var_2]))
        maps\mp\gametypes\_missions::processchallenge("ch_penetrate_" + var_2);
    }
  }

  maps\mp\gametypes\_missions::processchallenge("ch_boot_xray");
}

_id_6513() {
  maps\mp\_utility::incplayerstat("multiKillOneBullet", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("multiKillOneBullet", self);
  maps\mp\gametypes\_missions::processchallenge("ch_killer_greedy");
}

_id_21C5(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4) && isDefined(var_4._id_2093))
    var_5 = var_4._id_2093;
  else
    var_5 = self _meth_83B9();

  if(isDefined(var_4) && isDefined(var_4._id_2094))
    var_6 = var_4._id_2094;
  else
    var_6 = var_0 _meth_83B9();

  if(var_5 && var_6)
    _id_0BA1(var_1, var_2, var_3);

  if(var_5 && !var_6)
    _id_0BA2(var_1, var_2, var_3);

  if(!var_5 && var_6)
    _id_488C(var_1, var_2, var_3);
}

_id_21F2(var_0, var_1, var_2) {
  if(_id_0513::_id_57AE(var_1))
    _id_7EA0(var_1, var_2);

  if(issubstr(var_1, "exoknife_mp"))
    _id_390B(var_1, var_2, var_0);
}

_id_390B(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("exo_knife_kill", 1);

  if(isDefined(var_2._id_A876) && var_2._id_A876) {
    maps\mp\_utility::incplayerstat("exo_knife_recall_kill", 1);
    level thread maps\mp\gametypes\_rank::_id_1457("exo_knife_recall_kill", self, var_0, undefined, var_1);
  } else
    level thread maps\mp\gametypes\_rank::_id_1457("exo_knife_kill", self, var_0, undefined, var_1);
}

_id_6634(var_0, var_1) {
  self notify("neardeath_battlecry");
  maps\mp\_utility::incplayerstat("near_death_kill", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("near_death_kill", self, var_0, undefined, var_1);
  maps\mp\gametypes\_missions::_id_99C5(var_0, "ch_camoT2_neardeath_");
}

_id_9131(var_0, var_1) {
  maps\mp\_utility::incplayerstat("slide_kill", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("slide_kill", self, var_0, undefined, var_1);
  maps\mp\gametypes\_missions::processchallenge("ch_boot_hero");
}

concusskillevent(var_0) {
  maps\mp\gametypes\_missions::processchallenge("ch_tacticals_concussionkills");

  if(maps\mp\_utility::_hasperk("specialty_class_concussed"))
    maps\mp\gametypes\_missions::processchallenge("ch_explosives_concussed");
}

gaskillevent(var_0) {
  maps\mp\gametypes\_missions::processchallenge("ch_tacticals_poisonkills");
}

flarekillevent(var_0) {
  maps\mp\gametypes\_missions::processchallenge("ch_tacticals_flarekills");
}

_id_3D4B(var_0) {
  maps\mp\gametypes\_missions::processchallenge("ch_tacticals_flashkills");
}

blindfightkillevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("flash_kill", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("flash_kill", self, var_0, undefined, var_1);
}

_id_8C5D(var_0, var_1) {
  if(isDefined(self._id_1189)) {
    foreach(var_3 in self._id_1189) {
      if(_func_17B(var_3._id_8CD7) && maps\mp\_utility::_hasperk("specialty_stun_resistance") && maps\mp\_utility::_hasperk("specialty_blastshield2")) {
        maps\mp\gametypes\_missions::processchallenge("ch_perks1_cantbebothered");
        break;
      }
    }
  }
}

_id_57F1(var_0) {
  if(isDefined(self._id_1189)) {
    foreach(var_2 in self._id_1189) {
      if(_func_17B(var_2._id_8CD7) && maps\mp\_utility::_hasperk("specialty_blastshield2"))
        return 1;
    }
  }

  return 0;
}

_id_7E2E(var_0, var_1) {
  if(isDefined(var_0) && isDefined(self._id_1189[var_0.guid])) {
    foreach(var_3 in self._id_1189[var_0.guid]._id_A9DF) {
      if(var_1 == "thickskin" && (var_3 != "throwingknife_mp" && _id_0513::_id_5747(var_3)))
        maps\mp\gametypes\_missions::processchallenge("ch_perks1_thickskin");

      if(var_1 == "focused" && (var_3 == "flash_grenade_mp" || var_3 == "stun_grenade_mp" || var_3 == "signal_flare_mp" || var_3 == "tabun_grenade_mp" || var_3 == "concussion_grenade_mp"))
        maps\mp\gametypes\_missions::processchallenge("ch_humiliation_focused");
    }
  }
}

_id_3DD4(var_0) {
  if(isDefined(var_0) && isDefined(var_0._id_1189[self.guid])) {
    foreach(var_2 in var_0._id_1189[self.guid]._id_A9DF) {
      if(var_2 == "flash_grenade_mp" || var_2 == "stun_grenade_mp" || var_2 == "signal_flare_mp")
        maps\mp\gametypes\_missions::processchallenge("ch_lethals_dazed");
    }
  }
}

_id_7EA0(var_0, var_1) {
  maps\mp\_utility::incplayerstat("riot_kill", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("riot_kill", self, var_0, undefined, var_1);
}

riotshielddamagetakenevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("shield_dmg_taken", self);
}

_id_0BA1(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("air_to_air_kill", 1);
  thread maps\mp\gametypes\_missions::processchallenge("ch_limited_acepilot", 1);
  thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_redbaron", 1);
  var_3 = maps\mp\_utility::_id_4431(var_1, 1);

  if(maps\mp\_utility::_id_5856(var_3))
    var_3 = maps\mp\gametypes\_class::_id_4432(var_3);

  var_4 = maps\mp\gametypes\_missions::_id_40EE(var_1, var_3);

  if(maps\mp\_utility::_id_5755(var_2)) {
    maps\mp\_utility::incplayerstat("melee_air_to_air", 1);
    level thread maps\mp\gametypes\_rank::_id_1457("melee_air_to_air", self, var_1, undefined, var_2);
  } else {
    level thread maps\mp\gametypes\_rank::_id_1457("air_to_air_kill", self, var_1, undefined, var_2);

    if(var_4 == "weapon_smg" || var_4 == "weapon_shotgun") {
      if(isDefined(level._id_20AA["ch_dogfight_" + var_3]))
        maps\mp\gametypes\_missions::processchallenge("ch_dogfight_" + var_3);
    }
  }
}

_id_0BA2(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("air_to_ground_kill", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("air_to_ground_kill", self, var_1, undefined, var_2);
  thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_buzz");
  var_3 = maps\mp\_utility::_id_4431(var_1, 1);

  if(maps\mp\_utility::_id_5856(var_3))
    var_3 = maps\mp\gametypes\_class::_id_4432(var_3);

  var_4 = maps\mp\gametypes\_missions::_id_40EE(var_1, var_3);

  if(var_4 == "weapon_assault" || var_4 == "weapon_heavy" || issubstr(var_1, "exocrossbow")) {
    if(issubstr(var_3, "dlcgun") && (var_4 == "weapon_assault" || var_4 == "weapon_heavy"))
      maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_" + var_3);
    else
      maps\mp\gametypes\_missions::processchallenge("ch_strafe_" + var_3);
  }
}

_id_488C(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("ground_to_air_kill", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("ground_to_air_kill", self, var_1, undefined, var_2);
  thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_pull");
  var_3 = maps\mp\_utility::_id_4431(var_1, 1);

  if(maps\mp\_utility::_id_5856(var_3))
    var_3 = maps\mp\gametypes\_class::_id_4432(var_3);

  var_4 = maps\mp\gametypes\_missions::_id_40EE(var_1, var_3);

  if(var_4 == "weapon_heavy" || issubstr(var_1, "exocrossbow")) {
    if(issubstr(var_3, "dlcgun") && var_4 == "weapon_heavy")
      maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_" + var_3);
    else
      maps\mp\gametypes\_missions::processchallenge("ch_skeet_" + var_3);
  }
}

_id_5766(var_0, var_1, var_2) {
  if(var_0._id_1193.size != 1)
    return 0;

  if(!isDefined(var_0._id_1193[self.guid]))
    return 0;

  if(maps\mp\_utility::_id_5755(var_2))
    return 0;

  if(gettime() != var_0._id_1189[self.guid]._id_3C71)
    return 0;

  var_3 = maps\mp\_utility::getweaponclass(var_1);
  var_4 = maps\mp\_utility::_id_45B5(var_1);

  if(var_3 == "weapon_sniper" || var_3 == "weapon_shotgun" || var_4 == "dp28_mp")
    return 1;

  return 0;
}

_id_574D(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3._id_0A4F))
    return 0;

  var_4 = self.origin;

  if(isDefined(var_3._id_1192))
    var_4 = var_3._id_1192;

  if(isalive(var_0) && !var_0 maps\mp\_utility::isusingremote() && (var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_HEAD_SHOT" || issubstr(var_1, "throwingknife") || issubstr(var_1, "exoknife_mp") || issubstr(var_1, "exocrossbow")) && !maps\mp\_utility::iskillstreakweapon(var_1) && !isDefined(var_0._id_10E9)) {
    var_5 = maps\mp\_utility::getweaponclass(var_1);

    switch (var_5) {
      case "weapon_pistol":
        var_6 = 800;
        break;
      case "weapon_smg":
        var_6 = 1200;
        break;
      case "weapon_heavy":
      case "weapon_assault":
        var_6 = 1500;
        break;
      case "weapon_sniper":
        var_6 = 2000;
        break;
      case "weapon_shotgun":
        var_6 = 500;
        break;
      case "weapon_projectile":
      default:
        var_6 = 1536;
        break;
    }

    if(issubstr(var_1, "throwingknife"))
      var_6 = 1200;

    if(issubstr(var_1, "exoknife_mp") || issubstr(var_1, "exocrossbow"))
      var_6 = 1200;

    var_7 = var_6 * var_6;

    if(distancesquared(var_4, var_3.origin) > var_7)
      return 1;
  }

  return 0;
}

_id_57A8(var_0, var_1) {
  if(!level.teambased)
    return 0;

  foreach(var_4, var_3 in var_0._id_29BD) {
    if(var_4 != self.guid && var_1 - var_3 < 500)
      return 1;
  }

  return 0;
}

_id_5EB3(var_0, var_1, var_2) {
  self._id_62A1["longshot"] = 1;
  maps\mp\_utility::incplayerstat("longshots", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("longshot", self, var_1, undefined, var_2);
  thread _id_0485::_id_5E96(var_0, "longshot");
  maps\mp\gametypes\_missions::_id_99C5(var_1, "ch_camoT2_longshot_");
}

_id_4BF6(var_0, var_1, var_2) {
  self._id_62A1["headshot"] = 1;
  maps\mp\_utility::incpersstat("headshots", 1);
  maps\mp\_utility::incplayerstat("headshots", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "headshots", maps\mp\_utility::_id_2315(self.pers["headshots"]));
  self._id_4BF9 = maps\mp\_utility::getpersstat("headshots");

  if(self._id_0079 == 7) {}

  level thread maps\mp\gametypes\_rank::_id_1457("headshot", self, var_1, undefined, var_2);
  thread _id_0485::_id_5E96(var_0, "headshot");
  maps\mp\gametypes\_missions::processchallenge("ch_limited_headhunter");
  maps\mp\gametypes\_missions::processchallenge("ch_career_headshots");
  maps\mp\gametypes\_missions::tier4camochallenge(var_1, "ch_camoT4_headshot_");

  if(level.gametype == "war" || level.gametype == "dm")
    maps\mp\_utility::_id_867C(self.pers["headshots"]);
}

_id_5805(var_0, var_1, var_2, var_3) {
  if(!_func_17B(var_2))
    return 0;

  if(!maps\mp\_utility::_id_57E5(var_1, "frag_"))
    return 0;

  if(isDefined(var_0) && isDefined(var_3) && isDefined(var_3._id_0117) && var_0.team == var_3._id_0117.team)
    return 0;

  if(isDefined(var_0) && isDefined(var_0._id_3961) && isDefined(var_0._id_3961["throwbackKill"]) && var_0._id_3961["throwbackKill"])
    return 1;

  return 0;
}

_id_99A8() {
  maps\mp\_utility::incplayerstat("throwback_kill", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("throwback_kill", self);
}

_id_56A2(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_0) && isDefined(var_3.team) && isDefined(var_0.team) && var_3.team == level._id_6C63[var_0.team] && (isDefined(var_3._id_2013) || var_3 maps\mp\_utility::_hasperk("specialty_ballcarrier")))
      var_1 = var_3.guid;
  }

  if(isDefined(var_1)) {
    foreach(var_3 in var_0._id_29BD) {
      if(isDefined(var_0._id_29BD[var_1]) && var_0._id_29BD[var_1] == var_3)
        return 1;
    }
  }

  return 0;
}

_id_2007() {
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_coveringfire");
}

_id_5CA9(var_0, var_1) {
  if(self._id_A25D)
    self notify("increment_resupplylethal_kills");

  _id_3DD4(var_0);
}

_id_3E49() {
  maps\mp\_utility::incplayerstat("four_play", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("four_play", self);
}

_id_13BA(var_0, var_1, var_2) {
  self._id_62A1["avenger"] = 1;
  maps\mp\_utility::incplayerstat("avengekills", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("avenger", self, var_1, undefined, var_2);
  thread _id_0485::_id_5E96(var_0, "avenger");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_avenger");
}

_id_10EA(var_0, var_1, var_2) {
  self._id_62A1["assistedsuicide"] = 1;
  maps\mp\_utility::incplayerstat("assistedsuicide", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("assistedsuicide", self, var_1, undefined, var_2);
  thread _id_0485::_id_5E96(var_0, "assistedsuicide");
}

_id_2C77(var_0, var_1, var_2) {
  self._id_62A1["defender"] = 1;
  maps\mp\_utility::incplayerstat("rescues", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("defender", self, var_1, undefined, var_2);
  thread _id_0485::_id_5E96(var_0, "defender");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_savior");
}

_id_2C80(var_0, var_1, var_2, var_3) {
  maps\mp\_utility::incplayerstat("defends", 1);
  maps\mp\_utility::incpersstat("defends", 1);

  if(maps\mp\_utility::_id_579B())
    self _meth_82FF("ui_onevone_class_2", self.pers["defends"]);

  maps\mp\gametypes\_persistence::statsetchild("round", "defends", self.pers["defends"]);

  if(!isDefined(var_2) || !maps\mp\_utility::iskillstreakweapon(var_2))
    level thread maps\mp\gametypes\_rank::_id_1457("defend", self);

  maps\mp\gametypes\_missions::_id_0B9D();
  var_0 thread _id_0485::_id_5E96(var_1, "assaulting");

  if(isDefined(var_3))
    thread _id_0485::_id_5E93("hp_defend", self.origin, var_3);
  else
    thread _id_0485::_id_5E93("defend", self.origin);
}

_id_10BA(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("assault", 1);

  if(!isDefined(var_2) || !maps\mp\_utility::iskillstreakweapon(var_2))
    level thread maps\mp\gametypes\_rank::_id_1457("assault", self);

  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_attacker");
  maps\mp\gametypes\_missions::_id_0B9D();
  var_0 thread _id_0485::_id_5E96(var_1, "defending");
}

ispostdeathkillevent(var_0, var_1) {
  if(isalive(self) && !(isDefined(var_1) && isDefined(var_1._id_5CC6) && isDefined(self._id_5CC6) && var_1._id_5CC6 != self._id_5CC6 && !(isDefined(var_1._id_0117) && var_1._id_0117 != self)))
    return 0;

  if(!(self != var_0 && isDefined(self._id_2AB8) && self._id_2AB8 + 1200 < gettime()))
    return 0;

  return 1;
}

_id_75E2(var_0) {
  self._id_62A1["posthumous"] = 1;
  maps\mp\_utility::incplayerstat("posthumous", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("posthumous", self);
  thread _id_0485::_id_5E96(var_0, "posthumous");
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_afterlife");
}

_id_57CE(var_0, var_1) {
  if(isDefined(var_1) && maps\mp\_utility::_id_5755(var_1) && isDefined(var_0) && _func_1A9(var_0) == "melee")
    return 1;

  return 0;
}

_id_8C55() {
  maps\mp\_utility::incplayerstat("silentkill", 1);
}

_id_5681(var_0, var_1, var_2) {
  if(!maps\mp\_utility::_id_5755(var_2))
    return 0;

  if(_id_0513::_id_57AE(var_1))
    return 0;

  var_3 = var_0 getplayerangles();
  var_4 = self getplayerangles();
  var_5 = _func_0DD(var_3[1] - var_4[1]);

  if(_func_0AE(var_5) < 75)
    return 1;

  return 0;
}

_id_14EE(var_0) {
  maps\mp\_utility::incplayerstat("backstab", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("backstab", self);
  maps\mp\gametypes\_missions::_id_99C5(var_0, "ch_camoT2_backstab_");
  maps\mp\gametypes\_missions::tier3camochallenge(var_0, "ch_camoT3_backstab_");
}

_id_60EB(var_0, var_1) {
  maps\mp\gametypes\_missions::processchallenge("ch_career_meleekills");
}

_id_7E3F(var_0, var_1) {
  self._id_62A1["revenge"] = 1;
  self._id_5BB1 = undefined;
  maps\mp\_utility::incplayerstat("revengekills", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("revenge", self);
  thread _id_0485::_id_5E96(var_0, "revenge");
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_revenge");
  maps\mp\gametypes\_missions::_id_99C5(var_1, "ch_camoT2_revenge_");
}

_id_6512(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = maps\mp\gametypes\_missions::_id_40EE(var_2);
  var_5 = maps\mp\_utility::_id_4431(var_2, 1);

  if(maps\mp\_utility::_id_5856(var_5))
    var_5 = maps\mp\gametypes\_class::_id_4432(var_5);

  var_6 = "";

  if(common_scripts\utility::_id_9467(var_5, "iw5_"))
    var_6 = getsubstr(var_5, 4);

  if(level._id_53C7 && var_1 >= 4)
    maps\mp\gametypes\_missions::processchallenge("ch_scorestreaktraining_multikill");

  maps\mp\gametypes\_gamelogic::_id_8A67(var_5, 1, "multikills");

  if(maps\mp\_utility::iskillstreakweapon(var_5)) {
    if(isDefined(level._id_5A7D) && isDefined(level._id_5A7D[var_5]))
      maps\mp\gametypes\_persistence::incrementscorestreakstat(level._id_5A7D[var_5], "multikills", 1);
  }

  if(_id_0513::_id_5747(var_5))
    self notify("increment_lethaldouble_kills");

  switch (var_1) {
    case 2:
      level thread maps\mp\gametypes\_rank::_id_1457("doublekill", self, var_5);
      maps\mp\_utility::incplayerstat("doublekill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_double");
      maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_double");

      if(var_4 == "weapon_smg" || var_4 == "weapon_shotgun" || var_4 == "weapon_sniper" || var_5 == "iw5_microdronelauncher" || var_5 == "iw5_exocrossbow") {
        if(isDefined(level._id_20AA["ch_double_" + var_5]))
          maps\mp\gametypes\_missions::processchallenge("ch_double_" + var_5);
      }

      if(isDefined(level._id_20AA["ch_attach_unlock_double_" + var_6]))
        maps\mp\gametypes\_missions::processchallenge("ch_attach_unlock_double_" + var_6);

      break;
    case 3:
      level thread maps\mp\gametypes\_rank::_id_1457("triplekill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_3xkill", self);
      maps\mp\_utility::incplayerstat("triplekill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_triple");
      maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_triple");

      if(maps\mp\gametypes\_missions::_id_5678())
        maps\mp\gametypes\_missions::processchallenge("ch_precision_sitcrit");

      if(isDefined(var_4) && (var_4 == "weapon_smg" || var_4 == "weapon_heavy") && var_3 == 0)
        maps\mp\gametypes\_missions::processchallenge("ch_precision_hello");

      break;
    case 4:
      level thread maps\mp\gametypes\_rank::_id_1457("fourkill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_4xkill", self);
      maps\mp\_utility::incplayerstat("fourkill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_fury");
      maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed_fury");
      maps\mp\_utility::_id_863E(18, self.team, self getentitynumber(), 4);
      break;
    case 5:
      level thread maps\mp\gametypes\_rank::_id_1457("fivekill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_5xkill", self);
      maps\mp\_utility::incplayerstat("fivekill", 1);
      break;
    case 6:
      level thread maps\mp\gametypes\_rank::_id_1457("sixkill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_6xkill", self);
      maps\mp\_utility::incplayerstat("sixkill", 1);
      break;
    case 7:
      level thread maps\mp\gametypes\_rank::_id_1457("sevenkill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_7xkill", self);
      maps\mp\_utility::incplayerstat("sevenkill", 1);
      break;
    case 8:
      level thread maps\mp\gametypes\_rank::_id_1457("eightkill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_8xkill", self);
      maps\mp\_utility::incplayerstat("eightkill", 1);
      break;
    default:
      level thread maps\mp\gametypes\_rank::_id_1457("multikill", self, var_5);
      thread maps\mp\_utility::teamplayercardsplash("callout_9xpluskill", self);
      maps\mp\_utility::incplayerstat("multikill", 1);
      break;
  }

  thread _id_0485::_id_5E9D(var_0, var_1);
}

_id_95D1() {
  maps\mp\_utility::incplayerstat("take_and_kill", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("take_and_kill", self);
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_backfire");
}

_id_5A3A() {
  maps\mp\_utility::incplayerstat("killedBallCarrier", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("killedBallCarrier", self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_takedown");

  if(level.gametype == "ball") {
    maps\mp\_utility::_id_867C(maps\mp\_utility::getplayerstat("killedBallCarrier"));
    thread _id_0485::_id_5E93("kill_carrier", self.origin);
  }
}

_id_8A2C() {
  var_0 = maps\mp\_utility::getplayerstat("fieldgoal") + maps\mp\_utility::getplayerstat("touchdown") * 2;
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", var_0);
  maps\mp\_utility::_id_867B(var_0);
}

_id_9ABB(var_0) {
  thread maps\mp\_utility::teamplayercardsplash("callout_touchdown", self, undefined, var_0);
  maps\mp\_utility::incplayerstat("touchdown", 1);
  _id_8A2C();
  level thread maps\mp\gametypes\_rank::_id_1457("touchdown", self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_touchdown");
  thread _id_0485::_id_5E93("touchdown", self.origin);
}

_id_3AA1(var_0) {
  thread maps\mp\_utility::teamplayercardsplash("callout_fieldgoal", self, undefined, var_0);
  maps\mp\_utility::incplayerstat("fieldgoal", 1);
  _id_8A2C();
  level thread maps\mp\gametypes\_rank::_id_1457("fieldgoal", self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_fieldgoal");
  thread _id_0485::_id_5E93("fieldgoal", self.origin);
}

_id_5415() {
  maps\mp\_utility::incplayerstat("interception", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("interception", self);
  thread _id_0485::_id_5E93("interception", self.origin);
}

_id_5A83() {
  maps\mp\_utility::incplayerstat("kill_with_ball", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("kill_with_ball", self);
  thread _id_0485::_id_5E93("kill_with_ball", self.origin);
}

_id_1563() {
  maps\mp\_utility::incplayerstat("ball_score_assist", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("ball_score_assist", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_assist");
}

_id_6EB2() {
  maps\mp\_utility::incplayerstat("pass_kill_pickup", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("pass_kill_pickup", self);
}

firsttouchrelicevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("relic_first_touch", self);
}

relicgoalevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("relic_goal", self);
}

heldrelicevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("relic_held", self);
}

killwithrelicevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("relic_kill_as_carrier", self);
}

killedreliccarrierevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("relic_killed_carrier", self);
  _id_0468::ae_sendzombiekillevent();
}

relicpasskillevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("relic_pass_kill", self);
}

relicinterceptionevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("relic_interception", self);
}

_id_3CC1() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagpickup", self);
  maps\mp\_utility::incplayerstat("flagscarried", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("flag_pickup", self);
  thread _id_0485::_id_5E93("pickup", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_carry");
}

_id_3CB7() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagcapture", self);
  maps\mp\_utility::incplayerstat("flagscaptured", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::_id_867B(self.pers["captures"]);
  level thread maps\mp\gametypes\_rank::_id_1457("flag_capture", self);
  thread _id_0485::_id_5E93("capture", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_capture");
}

_id_3CC3() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagreturn", self);
  maps\mp\_utility::incplayerstat("flagsreturned", 1);
  maps\mp\_utility::incpersstat("returns", 1);
  self._id_0021 = self.pers["returns"];
  maps\mp\gametypes\_persistence::statsetchild("round", "returns", self.pers["returns"]);
  level thread maps\mp\gametypes\_rank::_id_1457("flag_return", self);
  thread _id_0485::_id_5E93("return", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_return");
}

_id_5A84(var_0) {
  maps\mp\_utility::incplayerstat("killsasflagcarrier", 1);

  if(!isDefined(var_0) || !maps\mp\_utility::iskillstreakweapon(var_0))
    level thread maps\mp\gametypes\_rank::_id_1457("kill_with_flag", self);
}

_id_5A46(var_0) {
  thread maps\mp\_utility::teamplayercardsplash("callout_killflagcarrier", self);
  maps\mp\_utility::incplayerstat("flagcarrierkills", 1);
  maps\mp\_utility::incpersstat("defends", 1);
  maps\mp\_utility::_id_867C(self.pers["defends"]);
  maps\mp\gametypes\_persistence::statsetchild("round", "defends", self.pers["defends"]);
  level thread maps\mp\gametypes\_rank::_id_1457("kill_flag_carrier", self);
  thread _id_0485::_id_5E96(var_0, "carrying");
  thread _id_0485::_id_5E93("kill_carrier", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_takedown");
}

_id_5A38(var_0) {
  maps\mp\_utility::incplayerstat("killsdenied", 1);
  maps\mp\_utility::incpersstat("denied", 1);
  maps\mp\_utility::_id_867C(self.pers["denied"]);
  maps\mp\gametypes\_persistence::statsetchild("round", "denied", self.pers["denied"]);
  var_1 = "kill_denied";

  if(var_0) {
    var_1 = "kill_denied_retrieved";
    maps\mp\_utility::incplayerstat("kill_denied_retrieved", 1);
    maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_save_yourself");
  }

  level thread maps\mp\gametypes\_rank::_id_1457(var_1, self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_denial");
}

_id_5A35() {
  maps\mp\_utility::incplayerstat("killsconfirmed", 1);
  maps\mp\_utility::incpersstat("confirmed", 1);
  maps\mp\_utility::_id_867B(self.pers["confirmed"]);
  maps\mp\gametypes\_persistence::statsetchild("round", "confirmed", self.pers["confirmed"]);
  level thread maps\mp\gametypes\_rank::_id_1457("kill_confirmed", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_collector");
}

_id_95B5() {
  maps\mp\_utility::incplayerstat("tag_collector", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("tag_collector", self);
}

_id_63E9(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 notify("tagCollector");
  var_0 endon("tagCollector");

  if(!isDefined(var_0._id_95B6))
    var_0._id_95B6 = 0;

  var_0._id_95B6++;

  if(var_0._id_95B6 > 2) {
    var_0 _id_95B5();
    var_0._id_95B6 = 0;
  }

  wait 2.5;

  if(isDefined(var_0))
    var_0._id_95B6 = 0;
}

_id_18FC(var_0, var_1) {
  maps\mp\_utility::incplayerstat("bombsplanted", 1);
  maps\mp\_utility::incpersstat("plants", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "plants", self.pers["plants"]);
  maps\mp\_utility::_id_867B(self.pers["plants"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted", self);

  if(isDefined(var_1) && var_1)
    level thread maps\mp\gametypes\_rank::_id_1457("raids_plant_multi", self);
  else
    level thread maps\mp\gametypes\_rank::_id_1457("plant", self);

  thread _id_0485::_id_5E93("bomb_plant_complete", self.origin, var_0);
}

_id_18D4(var_0, var_1) {
  maps\mp\_utility::incplayerstat("bombsdefused", 1);
  maps\mp\_utility::incpersstat("defuses", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "defuses", self.pers["defuses"]);
  maps\mp\_utility::_id_867C(self.pers["defuses"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_bombdefused", self);

  if(var_0 == "ninja_defuse" || var_0 == "last_man_defuse") {
    maps\mp\_utility::incplayerstat(var_0, 1);

    if(var_0 == "last_man_defuse")
      maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_ninja");
  }

  level thread maps\mp\gametypes\_rank::_id_1457(var_0, self);
  thread _id_0485::_id_5E93("bomb_defuse_complete", self.origin, var_1);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_defuser");
}

_id_35D2(var_0, var_1) {
  maps\mp\_utility::incplayerstat("elimination", 1);
  level thread maps\mp\_utility::teamplayercardsplash("callout_eliminated", var_1);

  if(var_0) {
    maps\mp\_utility::incplayerstat("last_man_standing", 1);
    level thread maps\mp\gametypes\_rank::_id_1457("last_man_standing", self);
  } else
    level thread maps\mp\gametypes\_rank::_id_1457("elimination", self);
}

_id_7E63(var_0) {
  maps\mp\_utility::incplayerstat("sr_tag_revive", 1);
  maps\mp\_utility::incplayerstat("killsdenied", 1);
  maps\mp\_utility::incpersstat("denied", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "denied", self.pers["denied"]);
  self._id_0021 = self.pers["denied"];
  level thread maps\mp\_utility::teamplayercardsplash("callout_tag_revive", var_0);
  level thread maps\mp\gametypes\_rank::_id_1457("sr_tag_revive", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_medic");
}

_id_35D3() {
  maps\mp\_utility::incplayerstat("sr_tag_elimination", 1);
  maps\mp\_utility::incplayerstat("killsconfirmed", 1);
  maps\mp\_utility::incpersstat("confirmed", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "confirmed", self.pers["confirmed"]);
  level thread maps\mp\gametypes\_rank::_id_1457("sr_tag_elimination", self);
}

_id_18D6(var_0) {
  maps\mp\_utility::incplayerstat("targetsdestroyed", 1);
  maps\mp\_utility::incpersstat("destructions", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "destructions", self.pers["destructions"]);
  level thread maps\mp\gametypes\_rank::_id_1457("destroy", self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");
  thread _id_0485::_id_5E93("bomb_detonate", self.origin, var_0);
}

_id_50ED() {
  maps\mp\_utility::incplayerstat("levelup", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("gained_gun_score", self);
}

_id_2B72() {
  maps\mp\_utility::incplayerstat("dejavu", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("dropped_gun_score", self);
}

_id_8634() {
  maps\mp\_utility::incplayerstat("humiliation", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("dropped_enemy_gun_rank", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_regression");
}

_id_7893() {
  maps\mp\_utility::incplayerstat("gunslinger", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("quick_gun_rank", self);
}

_id_8635() {
  maps\mp\_utility::incplayerstat("regicide", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("dropped_first_player_gun_rank", self);
}

increasedbladesscoreriflebulletevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("gained_blades_score_riflebullet", self);
}

increasedbladesscoredefectivegrenadeevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("gained_blades_score_defectivegrenade", self);
}

increasedbladesscoremeleeevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("gained_blades_score_melee", self);
}

quickbladesscoreevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("quick_blades_score", self);
}

bankruptedbladesscoreevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("bankrupt_blades_score", self);
}

bankruptedbladesscoresuicideevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("bankrupt_blades_score_suicide", self);
}

bankruptenemybladesscoreevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("bankrupt_enemy_blades_score", self);
}

bankruptfirstplayerbladesscoreevent() {
  level thread maps\mp\gametypes\_rank::_id_1457("bankrupt_first_player_blades_score", self);
}

_id_3C69() {
  maps\mp\_utility::incplayerstat("patientzero", 1);
  maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
  level thread maps\mp\_utility::teamplayercardsplash("callout_first_infected", self);
  level thread maps\mp\gametypes\_rank::_id_1457("first_infected", self);
  self._id_6EF6 = 0;
}

_id_3B5F() {
  maps\mp\_utility::incplayerstat("omegaman", 1);
  maps\mp\_utility::playsoundonplayers("mp_obj_captured");
  level thread maps\mp\_utility::teamplayercardsplash("callout_final_survivor", self);
  level thread maps\mp\gametypes\_rank::_id_1457("final_survivor", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_survivor");
}

_id_4817() {
  maps\mp\_utility::incplayerstat("careless", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("got_infected", self);
}

_id_700A() {
  maps\mp\_utility::incplayerstat("plague", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("infected_plague", self);
}

_id_511D() {
  maps\mp\_utility::incplayerstat("contagious", 1);
  level thread maps\mp\_utility::teamplayercardsplash("callout_infected_survivor", self, "axis");
  level thread maps\mp\gametypes\_rank::_id_1457("infected_survivor", self);
}

_id_9522() {
  maps\mp\_utility::incplayerstat("survivor", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("survivor", self);
}

_id_320C(var_0, var_1) {
  maps\mp\_utility::incplayerstat("pointscaptured", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::_id_867B(self.pers["captures"]);
  var_2 = "capture";

  if(var_0) {
    var_2 = "opening_move";
    maps\mp\_utility::incplayerstat("opening_move", 1);
  }

  if(var_1)
    var_2 = "starting_flag";

  if(isDefined(self._id_5137) || isDefined(self._id_5384))
    maps\mp\gametypes\_missions::processchallenge("ch_tacticals_smokescreen");

  level thread maps\mp\gametypes\_rank::_id_1457(var_2, self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");
  thread _id_0485::_id_5E93("capture", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_aggression");
}

_id_3218() {
  level thread maps\mp\gametypes\_rank::_id_1457("neutralize", self);
}

_id_5E67(var_0, var_1) {
  maps\mp\_utility::incplayerstat("pointscaptured", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::_id_867B(self.pers["captures"]);
  var_2 = "capture";

  if(var_0) {
    var_2 = "opening_move";
    maps\mp\_utility::incplayerstat("opening_move", 1);
  }

  if(var_1)
    var_2 = "starting_flag";

  level thread maps\mp\gametypes\_rank::_id_1457(var_2, self);
  thread _id_0485::_id_5E93("capture", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_aggression");
}

_id_5E68() {
  level thread maps\mp\gametypes\_rank::_id_1457("neutralize", self);
}

_id_5A82(var_0, var_1, var_2, var_3) {
  maps\mp\_utility::incplayerstat("assault", 1);
  maps\mp\_utility::incplayerstat("kill_while_capture", 1);

  if(!isDefined(var_2) || !maps\mp\_utility::iskillstreakweapon(var_2)) {
    if(level.gametype == "hp" || level.gametype == "undead")
      level thread maps\mp\gametypes\_rank::_id_1457("kill_on_hardpoint", self);
    else
      level thread maps\mp\gametypes\_rank::_id_1457("kill_while_capture", self);
  }

  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_defender");
  maps\mp\gametypes\_missions::_id_0B9D();
  var_0 thread _id_0485::_id_5E96(var_1, "defending");
}

_id_836D(var_0) {
  maps\mp\_utility::incplayerstat("hp_secure", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_hp_captured_by", self);
  level thread maps\mp\gametypes\_rank::_id_1457("hp_secure", self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");

  if(isDefined(self._id_5137) || isDefined(self._id_5384))
    maps\mp\gametypes\_missions::processchallenge("ch_tacticals_smokescreen");

  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_aggression");
}

_id_4C68() {
  level thread maps\mp\gametypes\_rank::_id_1457("hp_held", self);
}

_id_3C63(var_0, var_1, var_2) {
  self._id_62A1["firstblood"] = 1;
  maps\mp\_utility::incplayerstat("firstblood", 1);
  self._id_0097++;
  thread maps\mp\_utility::teamplayercardsplash("callout_firstblood", self);
  level thread maps\mp\gametypes\_rank::_id_1457("firstblood", self, var_1, undefined, var_2);
  thread _id_0485::_id_5E96(var_0, "firstblood");
}

_id_5757(var_0) {
  var_1 = var_0 _meth_833D();
  var_2 = var_1[2];

  if(!var_0 _meth_8346() && (var_2 > 50 || var_2 < -50))
    return 1;

  return 0;
}

_id_6161() {
  maps\mp\gametypes\_missions::processchallenge("ch_boot_airborne");
}

_id_241E() {
  maps\mp\gametypes\_missions::processchallenge("ch_boot_commando");
}

_id_5698(var_0) {
  if(maps\mp\_utility::_id_0F5C()) {
    foreach(var_2 in var_0.killstreaks) {
      if(_id_051E::_id_57F0(var_0, var_2)) {
        continue;
      }
      var_3 = var_0 _id_051E::_id_46B4(var_2);
      var_4 = var_0._id_0A06;
      var_5 = var_0 maps\mp\_utility::_hasperk("specialty_killstreaks");

      if(var_3 < var_4) {
        continue;
      }
      if(!var_5 && var_3 - var_4 < 101 || var_5 && var_3 - var_4 <= 1)
        return 1;
    }
  }

  return 0;
}

_id_1DE7(var_0, var_1, var_2, var_3) {
  self._id_62A1["buzzkill"] = var_1.pers["cur_kill_streak"];
  maps\mp\_utility::incplayerstat("buzzkill", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("buzzkill", self, var_2, undefined, var_3);
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_buzzkill");
}

_id_6B12(var_0, var_1, var_2) {
  self._id_62A1["oneshotkill"] = 1;
  maps\mp\_utility::incplayerstat("oneshotkill", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("oneshotkill", self, var_1, undefined, var_2);
  maps\mp\gametypes\_missions::processchallenge("ch_limited_deadeye");

  if(maps\mp\_utility::getweaponclass(var_1) == "weapon_sniper")
    self notify("increment_sharpshooter_kills");
  else if(maps\mp\_utility::getweaponclass(var_1) == "weapon_shotgun")
    self notify("increment_oneshotgun_kills");
}

_id_2535(var_0, var_1, var_2) {
  self._id_62A1["comeback"] = 1;
  maps\mp\_utility::incplayerstat("comebacks", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("comeback", self, var_1, undefined, var_2);
  thread _id_0485::_id_5E96(var_0, "comeback");
}

_id_83CD(var_0) {
  maps\mp\_utility::incplayerstat("semtex_stick", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("semtex_stick", self);
  var_0 maps\mp\_utility::incplayerstat("stuck_with_explosive", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("stuck_with_explosive", var_0);
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_stuck");
  self notify("increment_stuck_kills");
}

_id_285D(var_0) {
  maps\mp\_utility::incplayerstat("crossbow_stick", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("crossbow_stick", self);
  var_0 maps\mp\_utility::incplayerstat("stuck_with_explosive", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("stuck_with_explosive", var_0);
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_stuck");
  self notify("increment_stuck_kills");
}

_id_2FC1() {
  var_0 = self.guid;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(isDefined(level.players[var_1]._id_5A42[var_0]))
      level.players[var_1]._id_5A42[var_0] = undefined;

    if(isDefined(level.players[var_1]._id_5A43[var_0]))
      level.players[var_1]._id_5A43[var_0] = undefined;

    if(isDefined(level.players[var_1]._id_5A3C[var_0]))
      level.players[var_1]._id_5A3C[var_0] = undefined;
  }
}

_id_A159(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "";

  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self._id_7AD2++;
  var_2 = 0;

  if(self _meth_8345() >= 0.2)
    var_2 = 1;

  wait 4.0;

  if(self._id_7AD2 > 1)
    _id_6512(var_0, self._id_7AD2, var_1, var_2);

  self._id_7AD2 = 0;
  self._id_62C3 = 0;
  self._id_3D1D = 0;
  self.recentkills = [];
}

_id_4D4F(var_0) {
  maps\mp\_utility::incplayerstat("hijacker", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("hijacker", self);
  thread maps\mp\gametypes\_missions::genericchallenge("hijacker_airdrop");
  thread maps\mp\gametypes\_missions::processchallenge("ch_streak_thief");

  if(isDefined(var_0))
    var_0 maps\mp\gametypes\_hud_message::playercardsplashnotify("hijacked_airdrop", self);
}

_id_8AD6() {
  maps\mp\_utility::incplayerstat("sharepackage", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("sharepackage", self);
}

_id_5A79() {
  maps\mp\_utility::incplayerstat("killstreak_tag", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("killstreak_tag", self);
}

_id_5A6A() {
  var_0 = gettime();
  var_1 = self._id_5B87 + 10000;

  if(var_1 > var_0) {
    return;
  }
  self._id_5B87 = var_0;
  maps\mp\_utility::incplayerstat("killstreak_join", 1);
  level thread maps\mp\gametypes\_rank::_id_1457("killstreak_join", self);
}

_id_21EF(var_0) {
  if(!isDefined(self._id_118F)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = self;

  var_1 = self._id_0117;

  if(!isDefined(var_1))
    var_1 = self;

  foreach(var_3 in self._id_118F) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == var_1) {
      continue;
    }
    if(var_3 == var_0) {
      continue;
    }
    if(var_3.team == self.team) {
      continue;
    }
    var_3 maps\mp\_utility::incplayerstat("assist_killstreak_destroyed", 1);
    level thread maps\mp\gametypes\_rank::_id_1457("assist_killstreak_destroyed", var_3);
  }
}

_id_21E6(var_0) {
  var_1 = self._id_00E4 + 1;

  if(var_1 % 5 && var_1 < 30) {
    return;
  }
  switch (var_1) {
    case 5:
      level thread maps\mp\gametypes\_rank::_id_1457("killstreak5", self);
      maps\mp\_utility::incplayerstat("killstreak5", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_blood");

      if(isDefined(self._id_20A9) && isDefined(self._id_20A9["ch_limited_bloodshed"]) && self._id_20A9["ch_limited_bloodshed"] == 1)
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);

      break;
    case 7:
      maps\mp\_utility::_id_863E(17, self.team, self getentitynumber(), 7);
      break;
    case 10:
      level thread maps\mp\gametypes\_rank::_id_1457("killstreak10", self);
      maps\mp\_utility::incplayerstat("killstreak10", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_merciless");
      maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_merciless");

      if(isDefined(self._id_20A9) && isDefined(self._id_20A9["ch_limited_bloodshed"]) && self._id_20A9["ch_limited_bloodshed"] == 2)
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);

      if(isDefined(self._id_5DF8) && self._id_5DF8.guid == 0 && isDefined(self._id_5DF5) && self._id_5DF5.guid == 0)
        maps\mp\gametypes\_missions::processchallenge("ch_precision_wetwork");

      break;
    case 15:
      level thread maps\mp\gametypes\_rank::_id_1457("killstreak15", self);
      maps\mp\_utility::incplayerstat("killstreak15", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_ruthless");

      if(isDefined(self._id_20A9) && isDefined(self._id_20A9["ch_limited_bloodshed"]) && self._id_20A9["ch_limited_bloodshed"] == 3)
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);

      break;
    case 20:
      level thread maps\mp\gametypes\_rank::_id_1457("killstreak20", self);
      maps\mp\_utility::incplayerstat("killstreak20", 1);

      if(isDefined(self._id_20A9) && isDefined(self._id_20A9["ch_limited_bloodshed"]) && self._id_20A9["ch_limited_bloodshed"] == 4)
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);

      break;
    case 25:
      level thread maps\mp\gametypes\_rank::_id_1457("killstreak25", self);
      maps\mp\_utility::incplayerstat("killstreak25", 1);

      if(isDefined(self._id_20A9) && isDefined(self._id_20A9["ch_limited_bloodshed"]) && self._id_20A9["ch_limited_bloodshed"] == 5)
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);

      break;
    case 30:
      level thread maps\mp\gametypes\_rank::_id_1457("killstreak30", self);
      maps\mp\_utility::incplayerstat("killstreak30", 1);

      if(isDefined(self._id_20A9) && isDefined(self._id_20A9["ch_limited_bloodshed"]) && self._id_20A9["ch_limited_bloodshed"] == 6)
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);

      break;
    default:
      level thread maps\mp\gametypes\_rank::_id_1457("killstreak30plus", self);
      maps\mp\_utility::incplayerstat("killstreak30plus", 1);
      break;
  }

  thread maps\mp\_utility::teamplayercardsplash("callout_kill_streaking", self, undefined, var_1);
}

_id_21C4(var_0) {
  if(maps\mp\_utility::gettimepassed() < 90000.0) {
    return;
  }
  var_1 = level.players;

  if(level.teambased)
    var_1 = level._id_9859[maps\mp\_utility::getotherteam(self.team)];

  if(!isDefined(var_1) || var_1.size < 3) {
    return;
  }
  var_2 = common_scripts\utility::_id_0FA5(var_1, ::_id_5601);

  if(isDefined(var_2[0]) && var_0 == var_2[0]) {
    maps\mp\_utility::incplayerstat("firstplacekill", 1);
    level thread maps\mp\gametypes\_rank::_id_1457("firstplacekill", self);
    maps\mp\gametypes\_missions::processchallenge("ch_humiliation_highvalue");
    return 1;
  }
}

_id_5601(var_0, var_1) {
  return var_0.score > var_1.score;
}

_id_774E(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_10EB) && level._id_10EB) {
    return;
  }
  var_4 = "assist_low";

  if(isDefined(var_1))
    var_4 = var_1;

  self endon("disconnect");
  var_0 endon("disconnect");
  waitframe();

  if(self.team != "axis" && self.team != "allies") {
    return;
  }
  if(self.team == var_0.team) {
    return;
  }
  level thread maps\mp\gametypes\_rank::_id_1457(var_4, self, var_2, var_0);

  if(var_4 == "assist_low" || var_4 == "assist_mid" || var_4 == "assist_high" || var_4 == "assist_steal" || var_4 == "assist_tactical" || var_4 == "assist_painted" || var_4 == "assist_painted_expeditionary" || var_4 == "assist_riot_shield") {
    _id_0468::ae_sendassistevent(var_4);

    if(isDefined(level._id_80A8) && level._id_80A8 == 1) {
      return;
    }
    maps\mp\_utility::incplayerstat("assists", 1);
    maps\mp\_utility::incpersstat("assists", 1);
    self._id_0021 = maps\mp\_utility::getpersstat("assists");

    if(isDefined(var_3)) {
      foreach(var_6 in var_3) {
        var_7 = maps\mp\_utility::_id_4431(var_6, 1);

        if(maps\mp\_utility::_id_5856(var_7))
          var_7 = maps\mp\gametypes\_class::_id_4432(var_7);

        maps\mp\gametypes\_gamelogic::_id_8A67(var_7, 1, "assists");
      }
    }

    if(var_4 != "assist_riot_shield" && maps\mp\_utility::_hasperk("specialty_extraobjectivescore")) {
      if(!isDefined(self.pers["extraObjectiveScoreAssists"]))
        self.pers["extraObjectiveScoreAssists"] = 0;

      self.pers["extraObjectiveScoreAssists"] = self.pers["extraObjectiveScoreAssists"] + 1;

      if(self.pers["extraObjectiveScoreAssists"] % 2 == 0)
        level thread maps\mp\gametypes\_rank::_id_1457("assist_cavalry", self, var_2, var_0);
    }

    maps\mp\gametypes\_persistence::statsetchild("round", "assists", self._id_0021);
    thread maps\mp\gametypes\_missions::_id_73B5();

    if(level._id_7616)
      thread _id_7617(var_0);

    if(maps\mp\_utility::_hasperk("specialty_class_espionage"))
      thread maps\mp\gametypes\_missions::processchallenge("ch_operations_espionage");
  }
}

_id_7751(var_0, var_1, var_2) {
  if(isDefined(level._id_10EB) && level._id_10EB) {
    return;
  }
  var_3 = "crossfire_low";

  if(isDefined(var_1))
    var_3 = var_1;

  self endon("disconnect");
  var_0 endon("disconnect");
  waitframe();
  level thread maps\mp\gametypes\_rank::_id_1457(var_3, self, var_2, var_0);

  if(var_3 != "crossfire_riot_shield" && maps\mp\_utility::_hasperk("specialty_extraobjectivescore")) {
    if(!isDefined(self.pers["extraObjectiveScoreCrossfires"]))
      self.pers["extraObjectiveScoreCrossfires"] = 0;

    self.pers["extraObjectiveScoreCrossfires"] = self.pers["extraObjectiveScoreCrossfires"] + 1;

    if(self.pers["extraObjectiveScoreCrossfires"] % 2 == 0)
      level thread maps\mp\gametypes\_rank::_id_1457("crossfire_cavalry", self, var_2, var_0);
  }

  _id_0468::ae_sendassistevent();

  if(isDefined(level._id_80A8) && level._id_80A8 == 1) {
    return;
  }
  maps\mp\_utility::incplayerstat("assists", 1);
  maps\mp\_utility::incpersstat("assists", 1);
  self._id_0021 = maps\mp\_utility::getpersstat("assists");
  maps\mp\gametypes\_persistence::statsetchild("round", "assists", self._id_0021);
}

_id_5A27(var_0) {
  maps\mp\gametypes\_missions::processchallenge("ch_exomech_evasive");

  if(isDefined(var_0)) {
    var_1 = maps\mp\_utility::_id_4431(var_0, 1);

    if(maps\mp\_utility::_id_5856(var_1))
      var_1 = maps\mp\gametypes\_class::_id_4432(var_1);

    var_2 = maps\mp\gametypes\_missions::_id_40EE(var_0, var_1);

    if(var_2 == "weapon_assault" || var_2 == "weapon_pistol" || var_2 == "weapon_special") {
      if(issubstr(var_1, "dlcgun") && (var_2 == "weapon_assault" || var_2 == "weapon_special"))
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_" + var_1);
      else
        maps\mp\gametypes\_missions::processchallenge("ch_dodge_" + var_1);
    }
  }
}

_id_1EC2(var_0, var_1) {
  var_2 = maps\mp\_utility::_id_4431(var_0, 1);

  if(maps\mp\_utility::_id_5856(var_2))
    var_2 = maps\mp\gametypes\_class::_id_4432(var_2);

  var_3 = maps\mp\gametypes\_missions::_id_40EE(var_0, var_2);

  switch (var_3) {
    case "weapon_pistol":
    case "weapon_special":
    case "weapon_shotgun":
    case "weapon_smg":
      if(issubstr(var_2, "dlcgun") && var_3 == "weapon_special")
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_" + var_2);
      else
        maps\mp\gametypes\_missions::processchallenge("ch_slide_" + var_2);

      break;
  }
}

iskillevent(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "attack_dogs_kill":
      case "division_commando_kill":
      case "division_grenadier_kill":
      case "kill":
      case "mg_nest_kill":
      case "v2_rocket_kill":
      case "airdrop_kill":
      case "tac_insert_kill":
      case "division_artillery_kill":
      case "division_scout_kill":
      case "division_resistance_kill":
      case "divisions_cavalry_kill":
      case "divisions_mountain_kill":
      case "divisions_armored_kill":
      case "divisions_airborne_kill":
      case "divisions_infantry_kill":
      case "paratroopers_kill":
      case "missile_strike_kill":
      case "mortar_strike_kill":
      case "flamethrower_kill":
      case "molotovs_kill":
      case "plane_gunner_kill":
      case "airstrike_kill":
      case "firebomb_kill":
      case "fritzx_kill":
      case "fighter_strike_kill":
        return 1;
    }
  }

  return 0;
}