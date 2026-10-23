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
    if(!isDefined(var_2[var_0])) {
      var_0 = "war";
    }

    var_3 = _tablelookupbyrow("mp/xp_event_table.csv", var_1, 0);
    var_4 = _tablelookupbyrow("mp/xp_event_table.csv", var_1, 1);
    var_5 = _tablelookupbyrow("mp/xp_event_table.csv", var_1, 2);
    var_6 = _tablelookupbyrow("mp/xp_event_table.csv", var_1, var_2[var_0]);

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    if(var_3 == "win" || var_3 == "loss" || var_3 == "tie") {
      var_6 = _float(var_6);
    } else {
      var_6 = int(var_6);
    }

    if(var_6 != -1) {
      var_5 = int(var_5);
      var_4 = int(var_4);
      maps\mp\gametypes\_rank::registerxpeventinfo(var_3, var_6, var_5, var_4);
    }

    var_1++;
  }

  level.numkills = 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.killedplayers = [];
    var_0.killedplayerscurrent = [];
    var_0.damagedplayers = [];
    var_0.killedby = [];
    var_0.recentkills = [];
    var_0.lastkilledby = undefined;
    var_0.recentkillcount = 0;
    var_0.lastkilltime = 0;
    var_0.bulletstreak = 0;
    var_0.lastcoopstreaktime = 0;
  }
}

killedplayer(var_0, var_1, var_2, var_3, var_4) {
  level.numkills++;
  level.usestartspawns = 0;
  var_5 = var_1.guid;
  var_6 = var_1.pers["cur_kill_streak"];
  var_7 = self.guid;
  var_8 = gettime();
  var_9 = [];
  maps\mp\gametypes\_missions::processchallenge("ch_career_kills");

  if(maps\mp\_utility::isbulletdamage(var_3)) {
    if(self.lastkilltime == var_8) {
      self.bulletstreak++;
    } else {
      self.bulletstreak = 1;
    }
  } else
    self.bulletstreak = 0;

  self.lastkilltime = gettime();
  self.lastkilledplayer = var_1;
  self.modifiers = [];
  self.damagedplayers[var_5] = undefined;
  thread updaterecentkills(var_0, var_2);

  if(maps\mp\_utility::iskillstreakweapon(var_2)) {
    if(isDefined(level.killstreakwieldweapons) && isDefined(level.killstreakwieldweapons[var_2])) {
      maps\mp\gametypes\_persistence::incrementscorestreakstat(level.killstreakwieldweapons[var_2], "killsOrAssists", 1);
    }
  } else {
    if(var_2 == "none") {
      return 0;
    }

    if(isDefined(var_1.throwinggrenade)) {
      if(var_1.throwinggrenade == "frag_grenade_mp" || var_1.throwinggrenade == "frag_grenade_german_mp") {
        self.modifiers["cooking"] = 1;
      }
    }

    if(weaponinventorytype(var_2) == "primary") {
      self.getnearestnode["killDistanceTotal"] = self.getnearestnode["killDistanceTotal"] + _distance2d(self.origin, var_1.origin);
      self.getnearestnode["killDistanceCount"]++;
    }

    if(isDefined(common_scripts\utility::_id_0F7E(self.attackers, var_1))) {
      self notify("turned_on_battlecry");
    }

    if(var_3 == "MOD_HEAD_SHOT") {
      _id_4BF6(var_0, var_2, var_3);
    }

    if(level.teambased && var_8 - var_1.lastkilltime < 3000 && var_1.lastkilledplayer != self) {
      avengedplayerevent(var_0, var_2, var_3);
    }

    if(ispostdeathkillevent(var_1, var_4)) {
      postdeathkillevent(var_0);
    }

    if(isDefined(self._id_6E6B) && self._id_6E6B) {
      maps\mp\gametypes\_missions::processchallenge("ch_commando_weapon");
    }

    if(isDefined(self.basictrainingserumactive) && self.basictrainingserumactive) {
      maps\mp\gametypes\_missions::processchallenge("ch_dlc4_catalyst");
    }

    if(self.pers["cur_death_streak"] > 3) {
      comebackevent(var_0, var_2, var_3);
    }

    if(isDefined(self.assistedsuicide) && self.assistedsuicide) {
      assistedsuicideevent(var_0, var_2, var_3);
    }

    if(islongshot(self, var_2, var_3, var_1)) {
      longshotevent(var_0, var_2, var_3);
      var_9[var_9.size] = "longshot";
    }

    if(isresuce(var_1, var_8)) {
      defendedplayerevent(var_0, var_2, var_3);
    }

    if(var_6 > 0 && isbuzzkillevent(var_1)) {
      buzzkillevent(var_0, var_1, var_2, var_3);
    }

    if(isoneshotkill(var_1, var_2, var_3)) {
      oneshotkillevent(var_0, var_2, var_3);
    }

    if(isDefined(self.lastkilledby) && self.lastkilledby == var_1) {
      revengeevent(var_0, var_2);
      var_9[var_9.size] = "payback";
    }

    if(isDefined(var_1.idflags) && var_1.idflags &level.idflags_penetration) {
      bulletpenetrationevent(var_0, var_2);
    }

    if(ispointblank(var_1, var_3)) {
      pointblankevent(var_0, var_2, var_3);
    }

    if(isDefined(var_2) && var_2 == "boost_slam_mp") {
      boostslamkillevent(var_0, var_2, var_3);
    }

    if(self.health < 20 && self.health > 0) {
      neardeathkillevent(var_2, var_3);
    }

    if(self.issiliding) {
      sprintslidekillevent(var_2, var_3);
    }

    if(isDefined(self.lastslidetime) && var_8 - self.lastslidetime < 2000) {
      camosprintslidekillevent(var_2, var_3);
    }

    if(var_1 common_scripts\utility::_id_56B5()) {
      concusskillevent(var_0);
    }

    if(var_1 common_scripts\utility::_id_5701()) {
      gaskillevent(var_0);
    }

    if(var_1 common_scripts\utility::_id_56F2()) {
      flarekillevent(var_0);
    }

    if(var_1 common_scripts\utility::_id_56F4()) {
      _id_3D4B(var_0);
    }

    if(common_scripts\utility::_id_56F2() || common_scripts\utility::_id_56B5() || common_scripts\utility::_id_56F4()) {
      blindfightkillevent(var_2, var_3);
    }

    if(common_scripts\utility::_id_56F2() || common_scripts\utility::_id_56B5() || common_scripts\utility::_id_5701() || common_scripts\utility::_id_56F4()) {
      _id_7E2E(var_1, "focused");
    }

    if(common_scripts\utility::_id_57D0()) {
      _id_8C5D(var_2, var_3);
    }

    if(_id_57F1(var_3)) {
      _id_7E2E(var_1, "thickskin");
    }

    if(isthinkfast(var_2, var_3)) {
      thinkfastevent();
    }

    if(maps\mp\_utility::_hasperk("specialty_fastadsaftersprint")) {
      _id_3A56();
    }

    if(self.bulletstreak == 2) {
      multikillonebulletevent();
    }

    if(_id_57CE(var_2, var_3)) {
      _id_8C55();
      var_9[var_9.size] = "dediMelee";
    }

    if(isbackstabevent(var_1, var_2, var_3)) {
      backstabevent(var_2);
    }

    if(maps\mp\_utility::ismeleemod(var_3)) {
      _id_60EB(var_2, var_3);
    }

    if(isthrowbackevent(var_1, var_2, var_3, var_4)) {
      throwbackkillevent();
      var_9[var_9.size] = "throwback";
    }

    if(_id_0513::_id_5747(var_2)) {
      _id_5CA9(var_1, var_2);
    }

    if(_id_56A2(var_1)) {
      _id_2007();
    }

    var_10 = undefined;

    if(maps\mp\_utility::isstrstart(var_2, "alt_")) {
      var_10 = getsubstr(var_2, 4);
    }

    if(isDefined(self.pickedupweaponfrom[var_2]) && self.pickedupweaponfrom[var_2] == var_1 && !maps\mp\_utility::ismeleemod(var_3)) {
      takeandkillevent();
      var_9[var_9.size] = "backfire";
    } else if(isDefined(var_10) && isDefined(self.pickedupweaponfrom[var_10]) && self.pickedupweaponfrom[var_10] == var_1 && !maps\mp\_utility::ismeleemod(var_3)) {
      takeandkillevent();
      var_9[var_9.size] = "backfire";
    }

    if(isDefined(var_2) && var_2 == "iw5_carrydrone_mp") {
      killwithballevent();
    }

    if(isDefined(var_2) && var_2 == "relic_mp") {
      killwithrelicevent();
    }

    if(isDefined(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_ballcarrier")) {
      if(level.gametype == "ball") {
        _id_5A3A();
      } else if(level.gametype == "relic") {
        killedreliccarrierevent();
      }
    }

    if(_id_5757(self)) {
      _id_6161();
    }

    if(self ismantling() || self isonladder()) {
      _id_241E();
    }

    checkhighjumpevents(var_1, var_0, var_2, var_3, var_4);
    var_11 = checkhigherrankkillevents(var_1);

    if(isDefined(var_11) && var_11) {
      var_9[var_9.size] = "kingslayer";
    }

    checkweaponspecifickill(var_1, var_2, var_3);

    if(isDefined(self._id_3448) && self._id_3448.size > 0) {
      foreach(var_13 in self._id_3448) {
        if(common_scripts\utility::distance_2d_squared(self.origin, var_13.origin) <= 57600 && common_scripts\utility::distance_2d_squared(var_1.origin, var_13.origin) <= 57600) {
          maps\mp\gametypes\_missions::processchallenge("ch_streak_trap");
          break;
        }
      }
    }
  }

  if(level.numkills == 1) {
    firstbloodevent(var_0, var_2, var_3);

    if(level.gametype == "sd") {
      maps\mp\_utility::_id_863E(21, self.team, self getentitynumber());
    }
  }

  if(!level._id_53C7) {
    checkstreakingevents(var_1);
  }

  if(!isDefined(self.killedplayers[var_5])) {
    self.killedplayers[var_5] = 0;
  }

  if(!isDefined(self.killedplayerscurrent[var_5])) {
    self.killedplayerscurrent[var_5] = 0;
  }

  if(!isDefined(var_1.killedby[var_7])) {
    var_1.killedby[var_7] = 0;
  }

  self.killedplayers[var_5]++;
  self.killedplayerscurrent[var_5]++;
  var_1.killedby[var_7]++;
  var_1.lastkilledby = self;
  _id_0468::_id_0A23(var_1, var_2, var_3, var_9);

  if(self._id_0079 == 7) {
    if(isDefined(self.pers["grenadier_kills"])) {
      self.pers["grenadier_kills"]++;
    } else {
      self.pers["grenadier_kills"] = 1;
    }
  }

  if(isDefined(level.gametype) && level.gametype == "war") {
    if(self.pers["kills"] + 1 == 25) {
      _id_0468::_id_0A22("tdm25kills");
    }
  }

  if(isDefined(level.gametype) && level.gametype == "sd") {
    if(self.pers["kills"] + 1 == 10) {
      _id_0468::_id_0A22("sdKiller");
    }
  }

  if(maps\mp\_utility::_id_579B()) {
    if(self.pers["raidKillz"] + 1 == 45) {
      _id_0468::_id_0A22("warKills45");
    }
  }

  if(level.gametype == "ctf" && self.team != var_1.team && isDefined(var_1.carryflag)) {
    if(self.pers["defends"] + 1 == 3) {
      _id_0468::_id_0A22("3KillsFlagCarrier");
    }
  }

  if(level.gametype == "hp" && isDefined(level.zone.trig) && self istouching(level.zone.trig)) {
    if(!isDefined(self.killsonhp)) {
      self.killsonhp = 0;
    }

    self.killsonhp++;

    if(self.killsonhp == 5) {
      _id_0468::_id_0A22("5KillsOnHp");
    }
  }
}

ispointblank(var_0, var_1) {
  if(maps\mp\_utility::isbulletdamage(var_1)) {
    var_2 = self.origin;
    var_3 = 9216;

    if(isDefined(var_0.attackerposition)) {
      var_2 = var_0.attackerposition;
    }

    if(distancesquared(var_2, var_0.origin) < var_3) {
      return 1;
    }
  }

  return 0;
}

pointblankevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("pointblank", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("pointblank", self, var_1, undefined, var_2);

  if(isDefined(var_1)) {
    var_3 = maps\mp\_utility::_id_4431(var_1, 1);

    if(maps\mp\_utility::_id_5856(var_3)) {
      var_3 = maps\mp\gametypes\_class::getbasefromlootversion(var_3);
    }

    var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_1, var_3);

    if(issubstr(var_3, "dlcgun") && var_4 == "weapon_special") {
      maps\mp\gametypes\_missions::processchallenge("ch_tier1_1_" + var_3);
    } else {
      maps\mp\gametypes\_missions::processchallenge("ch_pointblank_" + var_3);
    }
  }
}

killedplayerevent(var_0, var_1, var_2, var_3) {
  if(var_0 isusingturret()) {
    level thread maps\mp\gametypes\_rank::awardgameevent("killed_mg_nest", self, var_1, var_0, var_2, var_3);
  }

  if(isDefined(var_0._id_A258) && var_0._id_A258) {
    level thread maps\mp\gametypes\_rank::awardgameevent("killed_flamethrower", self, var_1, var_0, var_2, var_3);
  }

  if(isDefined(var_0._id_A25A) && var_0._id_A25A) {
    level thread maps\mp\gametypes\_rank::awardgameevent("killed_molotovs", self, var_1, var_0, var_2, var_3);
  }

  if(isDefined(var_0.usingriotshield) && var_0.usingriotshield) {
    level thread maps\mp\gametypes\_rank::awardgameevent("killed_riotshield", self, var_1, var_0, var_2, var_3);
  }

  if(xmodelalias/alias_ger_heads_scarf_for_muddy_cheap() || isDefined(level._id_2F8B) && level._id_2F8B || isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    var_4 = _id_43D6(var_1, var_2);

    if(var_4 == "kill") {
      var_4 = _id_04CB::_id_4499("kill", self, var_0, var_1, var_2);

      if(var_4 != "kill") {
        self.modifiers[var_4] = 1;
      }
    }

    level thread maps\mp\gametypes\_rank::awardgameevent(var_4, self, var_1, var_0, var_2, var_3);

    if(maps\mp\_utility::_id_579B()) {
      self._id_79A2++;
      maps\mp\_utility::setpersstat("raidKillz", self._id_79A2);
      self setclientomnvar("ui_onevone_class_1", self._id_79A2);
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

  if(maps\mp\_utility::getweaponclass(var_1) == _id_04CA::getdivisionweaponclass(self._id_0079)) {
    _id_04CA::_id_50FC(self._id_0079, 1, "weaponClassKills");
  }

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
      self.modifiers[var_4] = 1;
    }
  }

  if(level.practiceround) {
    thread practiceroundkillevent(var_0, var_4, var_1, var_2);
  }

  level thread maps\mp\gametypes\_rank::awardgameevent(var_4, self, var_1, var_0, var_2, var_3);
}

_id_6324(var_0) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_1 = maps\mp\gametypes\_persistence::statgetchild("round", "rescues");
  var_2 = maps\mp\gametypes\_persistence::statget("kills");

  if(isDefined(var_2) && isDefined(var_1) && var_1 + var_2 == 10) {
    self giveachievement("MP_KILL_10");
  }
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
      if(isDefined(var_1) && !maps\mp\_utility::ismeleemod(var_1)) {
        return "flamethrower_kill";
      }

      break;
    case "thermite_flames_mp":
    case "killstreak_molotov_cocktail_grenadier_mp":
    case "killstreak_molotov_cocktail_mp":
      if(isDefined(var_1) && !maps\mp\_utility::ismeleemod(var_1)) {
        return "molotovs_kill";
      }

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
      if(maps\mp\_utility::isdogfightgametype()) {
        return "dogfight_flak_kill";
      } else {
        return "raid_flak_kill";
      }
  }

  return "kill";
}

practicerounddialogvalid() {
  return !isDefined(self.next_pr_dialog_time) || gettime() > self.next_pr_dialog_time;
}

practicerounddialogplayed() {
  self.next_pr_dialog_time = gettime() + _randomintrange(20000, 40000);
}

practiceroundkillevent(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");

  if(isbot(self)) {
    return;
  }
  self playlocalsound("ui_practice_round_kill");
  var_4 = 0.5;

  if(!isDefined(self.best_pr_kills)) {
    self.best_pr_kills = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "bests", "kills");
  }

  if(self.best_pr_kills > 0 && self._id_00E3 > self.best_pr_kills) {
    practicerounddialogplayed();
    wait(var_4);
    maps\mp\_utility::leaderdialogonplayer("ptr_new_best");
    self.best_pr_kills = 0;
  } else if(var_1 == "kill" && !maps\mp\_utility::ismeleemod(var_3)) {
    if(var_3 == "MOD_HEAD_SHOT") {
      practicerounddialogplayed();
      wait(var_4);
      maps\mp\_utility::leaderdialogonplayer("ptr_headshot");
    } else {
      if(!practicerounddialogvalid()) {
        return;
      }
      practicerounddialogplayed();
      wait(var_4);
      maps\mp\_utility::leaderdialogonplayer("ptr_greatshot");
    }
  }
}

practiceroundassistevent(var_0) {
  self endon("disconnect");
  level endon("game_ended");

  if(isbot(self)) {
    return;
  }
  var_1 = 0.5;
  practicerounddialogplayed();
  wait(var_1);
  maps\mp\_utility::leaderdialogonplayer("ptr_assist");
}

isthinkfast(var_0, var_1) {
  if(var_1 == "MOD_IMPACT" || var_1 == "MOD_HEAD_SHOT") {
    if(isthinkfastweapon(var_0)) {
      return 1;
    }
  }

  return 0;
}

isthinkfastweapon(var_0) {
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

  if(isDefined(self._id_5BE3) && var_0 - self._id_5BE3 <= 2000 && maps\mp\_utility::_hasperk("specialty_sprintfire")) {
    thread maps\mp\gametypes\_missions::processchallenge("ch_perks2_agile");
  }
}

thinkfastevent() {
  maps\mp\_utility::incplayerstat("think_fast", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("think_fast", self);
}

boostslamkillevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("boostslamkill", 1);
  thread maps\mp\gametypes\_missions::processchallenge("ch_limited_lookoutbelow", 1);
  thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_hot", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("boostslamkill", self, var_1, undefined, var_2);
}

earnedkillstreakevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat(var_0 + "_earned", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent(var_0 + "_earned", self);
  thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_0, var_1, undefined, var_2);
  _id_0485::_id_5E99(var_0);
}

bulletpenetrationevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("bulletpenkills", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("bulletpen", self);

  if(isDefined(var_1)) {
    var_2 = maps\mp\_utility::_id_4431(var_1, 1);

    if(maps\mp\_utility::_id_5856(var_2)) {
      var_2 = maps\mp\gametypes\_class::getbasefromlootversion(var_2);
    }

    var_3 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_1, var_2);

    if(var_3 == "weapon_sniper") {
      if(isDefined(level.challengeinfo["ch_penetrate_" + var_2])) {
        maps\mp\gametypes\_missions::processchallenge("ch_penetrate_" + var_2);
      }
    }
  }

  maps\mp\gametypes\_missions::processchallenge("ch_boot_xray");
}

multikillonebulletevent() {
  maps\mp\_utility::incplayerstat("multiKillOneBullet", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("multiKillOneBullet", self);
  maps\mp\gametypes\_missions::processchallenge("ch_killer_greedy");
}

checkhighjumpevents(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4) && isDefined(var_4.ch_crossbow_player_jumping)) {
    var_5 = var_4.ch_crossbow_player_jumping;
  } else {
    var_5 = self ishighjumping();
  }

  if(isDefined(var_4) && isDefined(var_4.ch_crossbow_victim_jumping)) {
    var_6 = var_4.ch_crossbow_victim_jumping;
  } else {
    var_6 = var_0 ishighjumping();
  }

  if(var_5 && var_6) {
    _id_0BA1(var_1, var_2, var_3);
  }

  if(var_5 && !var_6) {
    _id_0BA2(var_1, var_2, var_3);
  }

  if(!var_5 && var_6) {
    groundtoairevent(var_1, var_2, var_3);
  }
}

checkweaponspecifickill(var_0, var_1, var_2) {
  if(_id_0513::isriotshield(var_1)) {
    riotshieldkillevent(var_1, var_2);
  }

  if(issubstr(var_1, "exoknife_mp")) {
    exoknifekillevent(var_1, var_2, var_0);
  }
}

exoknifekillevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("exo_knife_kill", 1);

  if(isDefined(var_2.wasrecall) && var_2.wasrecall) {
    maps\mp\_utility::incplayerstat("exo_knife_recall_kill", 1);
    level thread maps\mp\gametypes\_rank::awardgameevent("exo_knife_recall_kill", self, var_0, undefined, var_1);
  } else
    level thread maps\mp\gametypes\_rank::awardgameevent("exo_knife_kill", self, var_0, undefined, var_1);
}

neardeathkillevent(var_0, var_1) {
  self notify("neardeath_battlecry");
  maps\mp\_utility::incplayerstat("near_death_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("near_death_kill", self, var_0, undefined, var_1);
  maps\mp\gametypes\_missions::_id_99C5(var_0, "ch_camoT2_neardeath_");
}

sprintslidekillevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("slide_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("slide_kill", self, var_0, undefined, var_1);
  maps\mp\gametypes\_missions::processchallenge("ch_boot_hero");
}

concusskillevent(var_0) {
  maps\mp\gametypes\_missions::processchallenge("ch_tacticals_concussionkills");

  if(maps\mp\_utility::_hasperk("specialty_class_concussed")) {
    maps\mp\gametypes\_missions::processchallenge("ch_explosives_concussed");
  }
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
  level thread maps\mp\gametypes\_rank::awardgameevent("flash_kill", self, var_0, undefined, var_1);
}

_id_8C5D(var_0, var_1) {
  if(isDefined(self.attackerdata)) {
    foreach(var_3 in self.attackerdata) {
      if(_isexplosivedamagemod(var_3.smeansofdeath) && maps\mp\_utility::_hasperk("specialty_stun_resistance") && maps\mp\_utility::_hasperk("specialty_blastshield2")) {
        maps\mp\gametypes\_missions::processchallenge("ch_perks1_cantbebothered");
        break;
      }
    }
  }
}

_id_57F1(var_0) {
  if(isDefined(self.attackerdata)) {
    foreach(var_2 in self.attackerdata) {
      if(_isexplosivedamagemod(var_2.smeansofdeath) && maps\mp\_utility::_hasperk("specialty_blastshield2")) {
        return 1;
      }
    }
  }

  return 0;
}

_id_7E2E(var_0, var_1) {
  if(isDefined(var_0) && isDefined(self.attackerdata[var_0.guid])) {
    foreach(var_3 in self.attackerdata[var_0.guid]._id_A9DF) {
      if(var_1 == "thickskin" && (var_3 != "throwingknife_mp" && _id_0513::_id_5747(var_3))) {
        maps\mp\gametypes\_missions::processchallenge("ch_perks1_thickskin");
      }

      if(var_1 == "focused" && (var_3 == "flash_grenade_mp" || var_3 == "stun_grenade_mp" || var_3 == "signal_flare_mp" || var_3 == "tabun_grenade_mp" || var_3 == "concussion_grenade_mp")) {
        maps\mp\gametypes\_missions::processchallenge("ch_humiliation_focused");
      }
    }
  }
}

_id_3DD4(var_0) {
  if(isDefined(var_0) && isDefined(var_0.attackerdata[self.guid])) {
    foreach(var_2 in var_0.attackerdata[self.guid]._id_A9DF) {
      if(var_2 == "flash_grenade_mp" || var_2 == "stun_grenade_mp" || var_2 == "signal_flare_mp") {
        maps\mp\gametypes\_missions::processchallenge("ch_lethals_dazed");
      }
    }
  }
}

riotshieldkillevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("riot_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("riot_kill", self, var_0, undefined, var_1);
}

riotshielddamagetakenevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("shield_dmg_taken", self);
}

_id_0BA1(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("air_to_air_kill", 1);
  thread maps\mp\gametypes\_missions::processchallenge("ch_limited_acepilot", 1);
  thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_redbaron", 1);
  var_3 = maps\mp\_utility::_id_4431(var_1, 1);

  if(maps\mp\_utility::_id_5856(var_3)) {
    var_3 = maps\mp\gametypes\_class::getbasefromlootversion(var_3);
  }

  var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_1, var_3);

  if(maps\mp\_utility::ismeleemod(var_2)) {
    maps\mp\_utility::incplayerstat("melee_air_to_air", 1);
    level thread maps\mp\gametypes\_rank::awardgameevent("melee_air_to_air", self, var_1, undefined, var_2);
  } else {
    level thread maps\mp\gametypes\_rank::awardgameevent("air_to_air_kill", self, var_1, undefined, var_2);

    if(var_4 == "weapon_smg" || var_4 == "weapon_shotgun") {
      if(isDefined(level.challengeinfo["ch_dogfight_" + var_3])) {
        maps\mp\gametypes\_missions::processchallenge("ch_dogfight_" + var_3);
      }
    }
  }
}

_id_0BA2(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("air_to_ground_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("air_to_ground_kill", self, var_1, undefined, var_2);
  thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_buzz");
  var_3 = maps\mp\_utility::_id_4431(var_1, 1);

  if(maps\mp\_utility::_id_5856(var_3)) {
    var_3 = maps\mp\gametypes\_class::getbasefromlootversion(var_3);
  }

  var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_1, var_3);

  if(var_4 == "weapon_assault" || var_4 == "weapon_heavy" || issubstr(var_1, "exocrossbow")) {
    if(issubstr(var_3, "dlcgun") && (var_4 == "weapon_assault" || var_4 == "weapon_heavy")) {
      maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_" + var_3);
    } else {
      maps\mp\gametypes\_missions::processchallenge("ch_strafe_" + var_3);
    }
  }
}

groundtoairevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("ground_to_air_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("ground_to_air_kill", self, var_1, undefined, var_2);
  thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_pull");
  var_3 = maps\mp\_utility::_id_4431(var_1, 1);

  if(maps\mp\_utility::_id_5856(var_3)) {
    var_3 = maps\mp\gametypes\_class::getbasefromlootversion(var_3);
  }

  var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_1, var_3);

  if(var_4 == "weapon_heavy" || issubstr(var_1, "exocrossbow")) {
    if(issubstr(var_3, "dlcgun") && var_4 == "weapon_heavy") {
      maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_" + var_3);
    } else {
      maps\mp\gametypes\_missions::processchallenge("ch_skeet_" + var_3);
    }
  }
}

isoneshotkill(var_0, var_1, var_2) {
  if(var_0.attackers.size != 1) {
    return 0;
  }

  if(!isDefined(var_0.attackers[self.guid])) {
    return 0;
  }

  if(maps\mp\_utility::ismeleemod(var_2)) {
    return 0;
  }

  if(gettime() != var_0.attackerdata[self.guid].firsttimedamaged) {
    return 0;
  }

  var_3 = maps\mp\_utility::getweaponclass(var_1);
  var_4 = maps\mp\_utility::_id_45B5(var_1);

  if(var_3 == "weapon_sniper" || var_3 == "weapon_shotgun" || var_4 == "dp28_mp") {
    return 1;
  }

  return 0;
}

islongshot(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3._id_0A4F)) {
    return 0;
  }

  var_4 = self.origin;

  if(isDefined(var_3.attackerposition)) {
    var_4 = var_3.attackerposition;
  }

  if(isalive(var_0) && !var_0 maps\mp\_utility::isusingremote() && (var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_HEAD_SHOT" || issubstr(var_1, "throwingknife") || issubstr(var_1, "exoknife_mp") || issubstr(var_1, "exocrossbow")) && !maps\mp\_utility::iskillstreakweapon(var_1) && !isDefined(var_0.assistedsuicide)) {
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

    if(issubstr(var_1, "throwingknife")) {
      var_6 = 1200;
    }

    if(issubstr(var_1, "exoknife_mp") || issubstr(var_1, "exocrossbow")) {
      var_6 = 1200;
    }

    var_7 = var_6 * var_6;

    if(distancesquared(var_4, var_3.origin) > var_7) {
      return 1;
    }
  }

  return 0;
}

isresuce(var_0, var_1) {
  if(!level.teambased) {
    return 0;
  }

  foreach(var_4, var_3 in var_0.damagedplayers) {
    if(var_4 != self.guid && var_1 - var_3 < 500) {
      return 1;
    }
  }

  return 0;
}

longshotevent(var_0, var_1, var_2) {
  self.modifiers["longshot"] = 1;
  maps\mp\_utility::incplayerstat("longshots", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("longshot", self, var_1, undefined, var_2);
  thread _id_0485::logkillevent(var_0, "longshot");
  maps\mp\gametypes\_missions::_id_99C5(var_1, "ch_camoT2_longshot_");
}

_id_4BF6(var_0, var_1, var_2) {
  self.modifiers["headshot"] = 1;
  maps\mp\_utility::incpersstat("headshots", 1);
  maps\mp\_utility::incplayerstat("headshots", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "headshots", maps\mp\_utility::clamptoshort(self.pers["headshots"]));
  self.headshots = maps\mp\_utility::getpersstat("headshots");

  if(self._id_0079 == 7) {}

  level thread maps\mp\gametypes\_rank::awardgameevent("headshot", self, var_1, undefined, var_2);
  thread _id_0485::logkillevent(var_0, "headshot");
  maps\mp\gametypes\_missions::processchallenge("ch_limited_headhunter");
  maps\mp\gametypes\_missions::processchallenge("ch_career_headshots");
  maps\mp\gametypes\_missions::tier4camochallenge(var_1, "ch_camoT4_headshot_");

  if(level.gametype == "war" || level.gametype == "dm") {
    maps\mp\_utility::setextrascore1(self.pers["headshots"]);
  }
}

isthrowbackevent(var_0, var_1, var_2, var_3) {
  if(!_isexplosivedamagemod(var_2)) {
    return 0;
  }

  if(!maps\mp\_utility::isstrstart(var_1, "frag_")) {
    return 0;
  }

  if(isDefined(var_0) && isDefined(var_3) && isDefined(var_3._id_0117) && var_0.team == var_3._id_0117.team) {
    return 0;
  }

  if(isDefined(var_0) && isDefined(var_0.explosiveinfo) && isDefined(var_0.explosiveinfo["throwbackKill"]) && var_0.explosiveinfo["throwbackKill"]) {
    return 1;
  }

  return 0;
}

throwbackkillevent() {
  maps\mp\_utility::incplayerstat("throwback_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("throwback_kill", self);
}

_id_56A2(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_0) && isDefined(var_3.team) && isDefined(var_0.team) && var_3.team == level.otherteam[var_0.team] && (isDefined(var_3.carryflag) || var_3 maps\mp\_utility::_hasperk("specialty_ballcarrier"))) {
      var_1 = var_3.guid;
    }
  }

  if(isDefined(var_1)) {
    foreach(var_3 in var_0.damagedplayers) {
      if(isDefined(var_0.damagedplayers[var_1]) && var_0.damagedplayers[var_1] == var_3) {
        return 1;
      }
    }
  }

  return 0;
}

_id_2007() {
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_coveringfire");
}

_id_5CA9(var_0, var_1) {
  if(self._id_A25D) {
    self notify("increment_resupplylethal_kills");
  }

  _id_3DD4(var_0);
}

fourplayevent() {
  maps\mp\_utility::incplayerstat("four_play", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("four_play", self);
}

avengedplayerevent(var_0, var_1, var_2) {
  self.modifiers["avenger"] = 1;
  maps\mp\_utility::incplayerstat("avengekills", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("avenger", self, var_1, undefined, var_2);
  thread _id_0485::logkillevent(var_0, "avenger");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_avenger");
}

assistedsuicideevent(var_0, var_1, var_2) {
  self.modifiers["assistedsuicide"] = 1;
  maps\mp\_utility::incplayerstat("assistedsuicide", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("assistedsuicide", self, var_1, undefined, var_2);
  thread _id_0485::logkillevent(var_0, "assistedsuicide");
}

defendedplayerevent(var_0, var_1, var_2) {
  self.modifiers["defender"] = 1;
  maps\mp\_utility::incplayerstat("rescues", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("defender", self, var_1, undefined, var_2);
  thread _id_0485::logkillevent(var_0, "defender");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_savior");
}

defendobjectiveevent(var_0, var_1, var_2, var_3) {
  maps\mp\_utility::incplayerstat("defends", 1);
  maps\mp\_utility::incpersstat("defends", 1);

  if(maps\mp\_utility::_id_579B()) {
    self setclientomnvar("ui_onevone_class_2", self.pers["defends"]);
  }

  maps\mp\gametypes\_persistence::statsetchild("round", "defends", self.pers["defends"]);

  if(!isDefined(var_2) || !maps\mp\_utility::iskillstreakweapon(var_2)) {
    level thread maps\mp\gametypes\_rank::awardgameevent("defend", self);
  }

  maps\mp\gametypes\_missions::_id_0B9D();
  var_0 thread _id_0485::logkillevent(var_1, "assaulting");

  if(isDefined(var_3)) {
    thread _id_0485::loggameevent("hp_defend", self.origin, var_3);
  } else {
    thread _id_0485::loggameevent("defend", self.origin);
  }
}

assaultobjectiveevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("assault", 1);

  if(!isDefined(var_2) || !maps\mp\_utility::iskillstreakweapon(var_2)) {
    level thread maps\mp\gametypes\_rank::awardgameevent("assault", self);
  }

  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_attacker");
  maps\mp\gametypes\_missions::_id_0B9D();
  var_0 thread _id_0485::logkillevent(var_1, "defending");
}

ispostdeathkillevent(var_0, var_1) {
  if(isalive(self) && !(isDefined(var_1) && isDefined(var_1._id_5CC6) && isDefined(self._id_5CC6) && var_1._id_5CC6 != self._id_5CC6 && !(isDefined(var_1._id_0117) && var_1._id_0117 != self))) {
    return 0;
  }

  if(!(self != var_0 && isDefined(self.deathtime) && self.deathtime + 1200 < gettime())) {
    return 0;
  }

  return 1;
}

postdeathkillevent(var_0) {
  self.modifiers["posthumous"] = 1;
  maps\mp\_utility::incplayerstat("posthumous", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("posthumous", self);
  thread _id_0485::logkillevent(var_0, "posthumous");
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_afterlife");
}

_id_57CE(var_0, var_1) {
  if(isDefined(var_1) && maps\mp\_utility::ismeleemod(var_1) && isDefined(var_0) && _weapontype(var_0) == "melee") {
    return 1;
  }

  return 0;
}

_id_8C55() {
  maps\mp\_utility::incplayerstat("silentkill", 1);
}

isbackstabevent(var_0, var_1, var_2) {
  if(!maps\mp\_utility::ismeleemod(var_2)) {
    return 0;
  }

  if(_id_0513::isriotshield(var_1)) {
    return 0;
  }

  var_3 = var_0 getplayerangles();
  var_4 = self getplayerangles();
  var_5 = _angleclamp180(var_3[1] - var_4[1]);

  if(_abs(var_5) < 75) {
    return 1;
  }

  return 0;
}

backstabevent(var_0) {
  maps\mp\_utility::incplayerstat("backstab", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("backstab", self);
  maps\mp\gametypes\_missions::_id_99C5(var_0, "ch_camoT2_backstab_");
  maps\mp\gametypes\_missions::tier3camochallenge(var_0, "ch_camoT3_backstab_");
}

_id_60EB(var_0, var_1) {
  maps\mp\gametypes\_missions::processchallenge("ch_career_meleekills");
}

revengeevent(var_0, var_1) {
  self.modifiers["revenge"] = 1;
  self.lastkilledby = undefined;
  maps\mp\_utility::incplayerstat("revengekills", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("revenge", self);
  thread _id_0485::logkillevent(var_0, "revenge");
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_revenge");
  maps\mp\gametypes\_missions::_id_99C5(var_1, "ch_camoT2_revenge_");
}

multikillevent(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_2);
  var_5 = maps\mp\_utility::_id_4431(var_2, 1);

  if(maps\mp\_utility::_id_5856(var_5)) {
    var_5 = maps\mp\gametypes\_class::getbasefromlootversion(var_5);
  }

  var_6 = "";

  if(common_scripts\utility::string_starts_with(var_5, "iw5_")) {
    var_6 = getsubstr(var_5, 4);
  }

  if(level._id_53C7 && var_1 >= 4) {
    maps\mp\gametypes\_missions::processchallenge("ch_scorestreaktraining_multikill");
  }

  maps\mp\gametypes\_gamelogic::setweaponstat(var_5, 1, "multikills");

  if(maps\mp\_utility::iskillstreakweapon(var_5)) {
    if(isDefined(level.killstreakwieldweapons) && isDefined(level.killstreakwieldweapons[var_5])) {
      maps\mp\gametypes\_persistence::incrementscorestreakstat(level.killstreakwieldweapons[var_5], "multikills", 1);
    }
  }

  if(_id_0513::_id_5747(var_5)) {
    self notify("increment_lethaldouble_kills");
  }

  switch (var_1) {
    case 2:
      level thread maps\mp\gametypes\_rank::awardgameevent("doublekill", self, var_5);
      maps\mp\_utility::incplayerstat("doublekill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_double");
      maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_double");

      if(var_4 == "weapon_smg" || var_4 == "weapon_shotgun" || var_4 == "weapon_sniper" || var_5 == "iw5_microdronelauncher" || var_5 == "iw5_exocrossbow") {
        if(isDefined(level.challengeinfo["ch_double_" + var_5])) {
          maps\mp\gametypes\_missions::processchallenge("ch_double_" + var_5);
        }
      }

      if(isDefined(level.challengeinfo["ch_attach_unlock_double_" + var_6])) {
        maps\mp\gametypes\_missions::processchallenge("ch_attach_unlock_double_" + var_6);
      }

      break;
    case 3:
      level thread maps\mp\gametypes\_rank::awardgameevent("triplekill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_3xkill", self);
      maps\mp\_utility::incplayerstat("triplekill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_triple");
      maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_triple");

      if(maps\mp\gametypes\_missions::isatbrinkofdeath()) {
        maps\mp\gametypes\_missions::processchallenge("ch_precision_sitcrit");
      }

      if(isDefined(var_4) && (var_4 == "weapon_smg" || var_4 == "weapon_heavy") && var_3 == 0) {
        maps\mp\gametypes\_missions::processchallenge("ch_precision_hello");
      }

      break;
    case 4:
      level thread maps\mp\gametypes\_rank::awardgameevent("fourkill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_4xkill", self);
      maps\mp\_utility::incplayerstat("fourkill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_fury");
      maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed_fury");
      maps\mp\_utility::_id_863E(18, self.team, self getentitynumber(), 4);
      break;
    case 5:
      level thread maps\mp\gametypes\_rank::awardgameevent("fivekill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_5xkill", self);
      maps\mp\_utility::incplayerstat("fivekill", 1);
      break;
    case 6:
      level thread maps\mp\gametypes\_rank::awardgameevent("sixkill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_6xkill", self);
      maps\mp\_utility::incplayerstat("sixkill", 1);
      break;
    case 7:
      level thread maps\mp\gametypes\_rank::awardgameevent("sevenkill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_7xkill", self);
      maps\mp\_utility::incplayerstat("sevenkill", 1);
      break;
    case 8:
      level thread maps\mp\gametypes\_rank::awardgameevent("eightkill", self, var_5);
      level thread maps\mp\_utility::teamplayercardsplash("callout_8xkill", self);
      maps\mp\_utility::incplayerstat("eightkill", 1);
      break;
    default:
      level thread maps\mp\gametypes\_rank::awardgameevent("multikill", self, var_5);
      thread maps\mp\_utility::teamplayercardsplash("callout_9xpluskill", self);
      maps\mp\_utility::incplayerstat("multikill", 1);
      break;
  }

  thread _id_0485::logmultikill(var_0, var_1);
}

takeandkillevent() {
  maps\mp\_utility::incplayerstat("take_and_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("take_and_kill", self);
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_backfire");
}

_id_5A3A() {
  maps\mp\_utility::incplayerstat("killedBallCarrier", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("killedBallCarrier", self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_takedown");

  if(level.gametype == "ball") {
    maps\mp\_utility::setextrascore1(maps\mp\_utility::getplayerstat("killedBallCarrier"));
    thread _id_0485::loggameevent("kill_carrier", self.origin);
  }
}

setuplinkstats() {
  var_0 = maps\mp\_utility::getplayerstat("fieldgoal") + maps\mp\_utility::getplayerstat("touchdown") * 2;
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", var_0);
  maps\mp\_utility::setextrascore0(var_0);
}

touchdownevent(var_0) {
  thread maps\mp\_utility::teamplayercardsplash("callout_touchdown", self, undefined, var_0);
  maps\mp\_utility::incplayerstat("touchdown", 1);
  setuplinkstats();
  level thread maps\mp\gametypes\_rank::awardgameevent("touchdown", self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_touchdown");
  thread _id_0485::loggameevent("touchdown", self.origin);
}

fieldgoalevent(var_0) {
  thread maps\mp\_utility::teamplayercardsplash("callout_fieldgoal", self, undefined, var_0);
  maps\mp\_utility::incplayerstat("fieldgoal", 1);
  setuplinkstats();
  level thread maps\mp\gametypes\_rank::awardgameevent("fieldgoal", self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_fieldgoal");
  thread _id_0485::loggameevent("fieldgoal", self.origin);
}

interceptionevent() {
  maps\mp\_utility::incplayerstat("interception", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("interception", self);
  thread _id_0485::loggameevent("interception", self.origin);
}

killwithballevent() {
  maps\mp\_utility::incplayerstat("kill_with_ball", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_with_ball", self);
  thread _id_0485::loggameevent("kill_with_ball", self.origin);
}

ballscoreassistevent() {
  maps\mp\_utility::incplayerstat("ball_score_assist", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("ball_score_assist", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_assist");
}

passkillpickupevent() {
  maps\mp\_utility::incplayerstat("pass_kill_pickup", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("pass_kill_pickup", self);
}

firsttouchrelicevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("relic_first_touch", self);
}

relicgoalevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("relic_goal", self);
}

heldrelicevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("relic_held", self);
}

killwithrelicevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("relic_kill_as_carrier", self);
}

killedreliccarrierevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("relic_killed_carrier", self);
  _id_0468::ae_sendzombiekillevent();
}

relicpasskillevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("relic_pass_kill", self);
}

relicinterceptionevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("relic_interception", self);
}

flagpickupevent() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagpickup", self);
  maps\mp\_utility::incplayerstat("flagscarried", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("flag_pickup", self);
  thread _id_0485::loggameevent("pickup", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_carry");
}

flagcaptureevent() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagcapture", self);
  maps\mp\_utility::incplayerstat("flagscaptured", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("flag_capture", self);
  thread _id_0485::loggameevent("capture", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_capture");
}

flagreturnevent() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagreturn", self);
  maps\mp\_utility::incplayerstat("flagsreturned", 1);
  maps\mp\_utility::incpersstat("returns", 1);
  self._id_0021 = self.pers["returns"];
  maps\mp\gametypes\_persistence::statsetchild("round", "returns", self.pers["returns"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("flag_return", self);
  thread _id_0485::loggameevent("return", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_return");
}

killwithflagevent(var_0) {
  maps\mp\_utility::incplayerstat("killsasflagcarrier", 1);

  if(!isDefined(var_0) || !maps\mp\_utility::iskillstreakweapon(var_0)) {
    level thread maps\mp\gametypes\_rank::awardgameevent("kill_with_flag", self);
  }
}

killflagcarrierevent(var_0) {
  thread maps\mp\_utility::teamplayercardsplash("callout_killflagcarrier", self);
  maps\mp\_utility::incplayerstat("flagcarrierkills", 1);
  maps\mp\_utility::incpersstat("defends", 1);
  maps\mp\_utility::setextrascore1(self.pers["defends"]);
  maps\mp\gametypes\_persistence::statsetchild("round", "defends", self.pers["defends"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_flag_carrier", self);
  thread _id_0485::logkillevent(var_0, "carrying");
  thread _id_0485::loggameevent("kill_carrier", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_takedown");
}

killdeniedevent(var_0) {
  maps\mp\_utility::incplayerstat("killsdenied", 1);
  maps\mp\_utility::incpersstat("denied", 1);
  maps\mp\_utility::setextrascore1(self.pers["denied"]);
  maps\mp\gametypes\_persistence::statsetchild("round", "denied", self.pers["denied"]);
  var_1 = "kill_denied";

  if(var_0) {
    var_1 = "kill_denied_retrieved";
    maps\mp\_utility::incplayerstat("kill_denied_retrieved", 1);
    maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_save_yourself");
  }

  level thread maps\mp\gametypes\_rank::awardgameevent(var_1, self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_denial");
}

killconfirmedevent() {
  maps\mp\_utility::incplayerstat("killsconfirmed", 1);
  maps\mp\_utility::incpersstat("confirmed", 1);
  maps\mp\_utility::setextrascore0(self.pers["confirmed"]);
  maps\mp\gametypes\_persistence::statsetchild("round", "confirmed", self.pers["confirmed"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_confirmed", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_collector");
}

tagcollectorevent() {
  maps\mp\_utility::incplayerstat("tag_collector", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("tag_collector", self);
}

monitortagcollector(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  var_0 notify("tagCollector");
  var_0 endon("tagCollector");

  if(!isDefined(var_0.tagcollectortotal)) {
    var_0.tagcollectortotal = 0;
  }

  var_0.tagcollectortotal++;

  if(var_0.tagcollectortotal > 2) {
    var_0 tagcollectorevent();
    var_0.tagcollectortotal = 0;
  }

  wait 2.5;

  if(isDefined(var_0)) {
    var_0.tagcollectortotal = 0;
  }
}

bombplantevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("bombsplanted", 1);
  maps\mp\_utility::incpersstat("plants", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "plants", self.pers["plants"]);
  maps\mp\_utility::setextrascore0(self.pers["plants"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted", self);

  if(isDefined(var_1) && var_1) {
    level thread maps\mp\gametypes\_rank::awardgameevent("raids_plant_multi", self);
  } else {
    level thread maps\mp\gametypes\_rank::awardgameevent("plant", self);
  }

  thread _id_0485::loggameevent("bomb_plant_complete", self.origin, var_0);
}

bombdefuseevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("bombsdefused", 1);
  maps\mp\_utility::incpersstat("defuses", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "defuses", self.pers["defuses"]);
  maps\mp\_utility::setextrascore1(self.pers["defuses"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_bombdefused", self);

  if(var_0 == "ninja_defuse" || var_0 == "last_man_defuse") {
    maps\mp\_utility::incplayerstat(var_0, 1);

    if(var_0 == "last_man_defuse") {
      maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_ninja");
    }
  }

  level thread maps\mp\gametypes\_rank::awardgameevent(var_0, self);
  thread _id_0485::loggameevent("bomb_defuse_complete", self.origin, var_1);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_defuser");
}

eliminateplayerevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("elimination", 1);
  level thread maps\mp\_utility::teamplayercardsplash("callout_eliminated", var_1);

  if(var_0) {
    maps\mp\_utility::incplayerstat("last_man_standing", 1);
    level thread maps\mp\gametypes\_rank::awardgameevent("last_man_standing", self);
  } else
    level thread maps\mp\gametypes\_rank::awardgameevent("elimination", self);
}

revivetagevent(var_0) {
  maps\mp\_utility::incplayerstat("sr_tag_revive", 1);
  maps\mp\_utility::incplayerstat("killsdenied", 1);
  maps\mp\_utility::incpersstat("denied", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "denied", self.pers["denied"]);
  self._id_0021 = self.pers["denied"];
  level thread maps\mp\_utility::teamplayercardsplash("callout_tag_revive", var_0);
  level thread maps\mp\gametypes\_rank::awardgameevent("sr_tag_revive", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_medic");
}

eliminatetagevent() {
  maps\mp\_utility::incplayerstat("sr_tag_elimination", 1);
  maps\mp\_utility::incplayerstat("killsconfirmed", 1);
  maps\mp\_utility::incpersstat("confirmed", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "confirmed", self.pers["confirmed"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("sr_tag_elimination", self);
}

bombdetonateevent(var_0) {
  maps\mp\_utility::incplayerstat("targetsdestroyed", 1);
  maps\mp\_utility::incpersstat("destructions", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "destructions", self.pers["destructions"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("destroy", self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");
  thread _id_0485::loggameevent("bomb_detonate", self.origin, var_0);
}

increasegunlevelevent() {
  maps\mp\_utility::incplayerstat("levelup", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("gained_gun_score", self);
}

decreasegunlevelevent() {
  maps\mp\_utility::incplayerstat("dejavu", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("dropped_gun_score", self);
}

stopdynamicambience() {
  maps\mp\_utility::incplayerstat("humiliation", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("dropped_enemy_gun_rank", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_regression");
}

quickgunlevelevent() {
  maps\mp\_utility::incplayerstat("gunslinger", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("quick_gun_rank", self);
}

enablefocus() {
  maps\mp\_utility::incplayerstat("regicide", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("dropped_first_player_gun_rank", self);
}

increasedbladesscoreriflebulletevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("gained_blades_score_riflebullet", self);
}

increasedbladesscoredefectivegrenadeevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("gained_blades_score_defectivegrenade", self);
}

increasedbladesscoremeleeevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("gained_blades_score_melee", self);
}

quickbladesscoreevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("quick_blades_score", self);
}

bankruptedbladesscoreevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("bankrupt_blades_score", self);
}

bankruptedbladesscoresuicideevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("bankrupt_blades_score_suicide", self);
}

bankruptenemybladesscoreevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("bankrupt_enemy_blades_score", self);
}

bankruptfirstplayerbladesscoreevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("bankrupt_first_player_blades_score", self);
}

firstinfectedevent() {
  maps\mp\_utility::incplayerstat("patientzero", 1);
  maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
  level thread maps\mp\_utility::teamplayercardsplash("callout_first_infected", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("first_infected", self);
  self.patient_zero = 0;
}

finalsurvivorevent() {
  maps\mp\_utility::incplayerstat("omegaman", 1);
  maps\mp\_utility::playsoundonplayers("mp_obj_captured");
  level thread maps\mp\_utility::teamplayercardsplash("callout_final_survivor", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("final_survivor", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_survivor");
}

gotinfectedevent() {
  maps\mp\_utility::incplayerstat("careless", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("got_infected", self);
}

plagueevent() {
  maps\mp\_utility::incplayerstat("plague", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("infected_plague", self);
}

infectedsurvivorevent() {
  maps\mp\_utility::incplayerstat("contagious", 1);
  level thread maps\mp\_utility::teamplayercardsplash("callout_infected_survivor", self, "axis");
  level thread maps\mp\gametypes\_rank::awardgameevent("infected_survivor", self);
}

survivorevent() {
  maps\mp\_utility::incplayerstat("survivor", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("survivor", self);
}

domcaptureevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("pointscaptured", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
  var_2 = "capture";

  if(var_0) {
    var_2 = "opening_move";
    maps\mp\_utility::incplayerstat("opening_move", 1);
  }

  if(var_1) {
    var_2 = "starting_flag";
  }

  if(isDefined(self._id_5137) || isDefined(self.inplayersmokescreen)) {
    maps\mp\gametypes\_missions::processchallenge("ch_tacticals_smokescreen");
  }

  level thread maps\mp\gametypes\_rank::awardgameevent(var_2, self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");
  thread _id_0485::loggameevent("capture", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_aggression");
}

domneutralizeevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("neutralize", self);
}

_id_5E67(var_0, var_1) {
  maps\mp\_utility::incplayerstat("pointscaptured", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
  var_2 = "capture";

  if(var_0) {
    var_2 = "opening_move";
    maps\mp\_utility::incplayerstat("opening_move", 1);
  }

  if(var_1) {
    var_2 = "starting_flag";
  }

  level thread maps\mp\gametypes\_rank::awardgameevent(var_2, self);
  thread _id_0485::loggameevent("capture", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_aggression");
}

_id_5E68() {
  level thread maps\mp\gametypes\_rank::awardgameevent("neutralize", self);
}

killwhilecapture(var_0, var_1, var_2, var_3) {
  maps\mp\_utility::incplayerstat("assault", 1);
  maps\mp\_utility::incplayerstat("kill_while_capture", 1);

  if(!isDefined(var_2) || !maps\mp\_utility::iskillstreakweapon(var_2)) {
    if(level.gametype == "hp" || level.gametype == "undead") {
      level thread maps\mp\gametypes\_rank::awardgameevent("kill_on_hardpoint", self);
    } else {
      level thread maps\mp\gametypes\_rank::awardgameevent("kill_while_capture", self);
    }
  }

  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_defender");
  maps\mp\gametypes\_missions::_id_0B9D();
  var_0 thread _id_0485::logkillevent(var_1, "defending");
}

botgetdifficulty(var_0) {
  maps\mp\_utility::incplayerstat("hp_secure", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_hp_captured_by", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("hp_secure", self);
  maps\mp\gametypes\_missions::processchallenge("ch_heroics_destroyer");

  if(isDefined(self._id_5137) || isDefined(self.inplayersmokescreen)) {
    maps\mp\gametypes\_missions::processchallenge("ch_tacticals_smokescreen");
  }

  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_aggression");
}

_id_4C68() {
  level thread maps\mp\gametypes\_rank::awardgameevent("hp_held", self);
}

firstbloodevent(var_0, var_1, var_2) {
  self.modifiers["firstblood"] = 1;
  maps\mp\_utility::incplayerstat("firstblood", 1);
  self._id_0097++;
  thread maps\mp\_utility::teamplayercardsplash("callout_firstblood", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("firstblood", self, var_1, undefined, var_2);
  thread _id_0485::logkillevent(var_0, "firstblood");
}

_id_5757(var_0) {
  var_1 = var_0 getvelocity();
  var_2 = var_1[2];

  if(!var_0 isonground() && (var_2 > 50 || var_2 < -50)) {
    return 1;
  }

  return 0;
}

_id_6161() {
  maps\mp\gametypes\_missions::processchallenge("ch_boot_airborne");
}

_id_241E() {
  maps\mp\gametypes\_missions::processchallenge("ch_boot_commando");
}

isbuzzkillevent(var_0) {
  if(maps\mp\_utility::_id_0F5C()) {
    foreach(var_2 in var_0.killstreaks) {
      if(_id_051E::issupportstreak(var_0, var_2)) {
        continue;
      }
      var_3 = var_0 _id_051E::getstreakcost(var_2);
      var_4 = var_0._id_0A06;
      var_5 = var_0 maps\mp\_utility::_hasperk("specialty_killstreaks");

      if(var_3 < var_4) {
        continue;
      }
      if(!var_5 && var_3 - var_4 < 101 || var_5 && var_3 - var_4 <= 1) {
        return 1;
      }
    }
  }

  return 0;
}

buzzkillevent(var_0, var_1, var_2, var_3) {
  self.modifiers["buzzkill"] = var_1.pers["cur_kill_streak"];
  maps\mp\_utility::incplayerstat("buzzkill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("buzzkill", self, var_2, undefined, var_3);
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_buzzkill");
}

oneshotkillevent(var_0, var_1, var_2) {
  self.modifiers["oneshotkill"] = 1;
  maps\mp\_utility::incplayerstat("oneshotkill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("oneshotkill", self, var_1, undefined, var_2);
  maps\mp\gametypes\_missions::processchallenge("ch_limited_deadeye");

  if(maps\mp\_utility::getweaponclass(var_1) == "weapon_sniper") {
    self notify("increment_sharpshooter_kills");
  } else if(maps\mp\_utility::getweaponclass(var_1) == "weapon_shotgun") {
    self notify("increment_oneshotgun_kills");
  }
}

comebackevent(var_0, var_1, var_2) {
  self.modifiers["comeback"] = 1;
  maps\mp\_utility::incplayerstat("comebacks", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("comeback", self, var_1, undefined, var_2);
  thread _id_0485::logkillevent(var_0, "comeback");
}

setdoghandler(var_0) {
  maps\mp\_utility::incplayerstat("semtex_stick", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("semtex_stick", self);
  var_0 maps\mp\_utility::incplayerstat("stuck_with_explosive", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("stuck_with_explosive", var_0);
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_stuck");
  self notify("increment_stuck_kills");
}

crossbowstickevent(var_0) {
  maps\mp\_utility::incplayerstat("crossbow_stick", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("crossbow_stick", self);
  var_0 maps\mp\_utility::incplayerstat("stuck_with_explosive", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("stuck_with_explosive", var_0);
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_stuck");
  self notify("increment_stuck_kills");
}

disconnected() {
  var_0 = self.guid;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(isDefined(level.players[var_1].killedplayers[var_0])) {
      level.players[var_1].killedplayers[var_0] = undefined;
    }

    if(isDefined(level.players[var_1].killedplayerscurrent[var_0])) {
      level.players[var_1].killedplayerscurrent[var_0] = undefined;
    }

    if(isDefined(level.players[var_1].killedby[var_0])) {
      level.players[var_1].killedby[var_0] = undefined;
    }
  }
}

updaterecentkills(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.recentkillcount++;
  var_2 = 0;

  if(self playerads() >= 0.2) {
    var_2 = 1;
  }

  wait 4.0;

  if(self.recentkillcount > 1) {
    multikillevent(var_0, self.recentkillcount, var_1, var_2);
  }

  self.recentkillcount = 0;
  self._id_62C3 = 0;
  self._id_3D1D = 0;
  self.recentkills = [];
}

hijackerevent(var_0) {
  maps\mp\_utility::incplayerstat("hijacker", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("hijacker", self);
  thread maps\mp\gametypes\_missions::genericchallenge("hijacker_airdrop");
  thread maps\mp\gametypes\_missions::processchallenge("ch_streak_thief");

  if(isDefined(var_0)) {
    var_0 maps\mp\gametypes\_hud_message::playercardsplashnotify("hijacked_airdrop", self);
  }
}

sharedevent() {
  maps\mp\_utility::incplayerstat("sharepackage", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("sharepackage", self);
}

killstreaktagevent() {
  maps\mp\_utility::incplayerstat("killstreak_tag", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("killstreak_tag", self);
}

killstreakjoinevent() {
  var_0 = gettime();
  var_1 = self.lastcoopstreaktime + 10000;

  if(var_1 > var_0) {
    return;
  }
  self.lastcoopstreaktime = var_0;
  maps\mp\_utility::incplayerstat("killstreak_join", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("killstreak_join", self);
}

checkvandalismmedal(var_0) {
  if(!isDefined(self.attackerlist)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_1 = self._id_0117;

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  foreach(var_3 in self.attackerlist) {
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
    level thread maps\mp\gametypes\_rank::awardgameevent("assist_killstreak_destroyed", var_3);
  }
}

checkstreakingevents(var_0) {
  var_1 = self._id_00E4 + 1;

  if(var_1 % 5 && var_1 < 30) {
    return;
  }
  switch (var_1) {
    case 5:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak5", self);
      maps\mp\_utility::incplayerstat("killstreak5", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_blood");

      if(isDefined(self.challengedata) && isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 1) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      break;
    case 7:
      maps\mp\_utility::_id_863E(17, self.team, self getentitynumber(), 7);
      break;
    case 10:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak10", self);
      maps\mp\_utility::incplayerstat("killstreak10", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_merciless");
      maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_merciless");

      if(isDefined(self.challengedata) && isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 2) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      if(isDefined(self._id_5DF8) && self._id_5DF8.guid == 0 && isDefined(self._id_5DF5) && self._id_5DF5.guid == 0) {
        maps\mp\gametypes\_missions::processchallenge("ch_precision_wetwork");
      }

      break;
    case 15:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak15", self);
      maps\mp\_utility::incplayerstat("killstreak15", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_ruthless");

      if(isDefined(self.challengedata) && isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 3) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      break;
    case 20:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak20", self);
      maps\mp\_utility::incplayerstat("killstreak20", 1);

      if(isDefined(self.challengedata) && isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 4) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      break;
    case 25:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak25", self);
      maps\mp\_utility::incplayerstat("killstreak25", 1);

      if(isDefined(self.challengedata) && isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 5) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      break;
    case 30:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak30", self);
      maps\mp\_utility::incplayerstat("killstreak30", 1);

      if(isDefined(self.challengedata) && isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 6) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      break;
    default:
      level thread maps\mp\gametypes\_rank::awardgameevent("killstreak30plus", self);
      maps\mp\_utility::incplayerstat("killstreak30plus", 1);
      break;
  }

  thread maps\mp\_utility::teamplayercardsplash("callout_kill_streaking", self, undefined, var_1);
}

checkhigherrankkillevents(var_0) {
  if(maps\mp\_utility::gettimepassed() < 90000.0) {
    return;
  }
  var_1 = level.players;

  if(level.teambased) {
    var_1 = level.teamlist[maps\mp\_utility::getotherteam(self.team)];
  }

  if(!isDefined(var_1) || var_1.size < 3) {
    return;
  }
  var_2 = common_scripts\utility::_id_0FA5(var_1, ::is_score_a_greater_than_b);

  if(isDefined(var_2[0]) && var_0 == var_2[0]) {
    maps\mp\_utility::incplayerstat("firstplacekill", 1);
    level thread maps\mp\gametypes\_rank::awardgameevent("firstplacekill", self);
    maps\mp\gametypes\_missions::processchallenge("ch_humiliation_highvalue");
    return 1;
  }
}

is_score_a_greater_than_b(var_0, var_1) {
  return var_0.score > var_1.score;
}

processassistevent(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_10EB) && level._id_10EB) {
    return;
  }
  var_4 = "assist_low";

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  self endon("disconnect");
  var_0 endon("disconnect");
  waitframe();

  if(self.team != "axis" && self.team != "allies") {
    return;
  }
  if(self.team == var_0.team) {
    return;
  }
  level thread maps\mp\gametypes\_rank::awardgameevent(var_4, self, var_2, var_0);

  if(var_4 == "assist_low" || var_4 == "assist_mid" || var_4 == "assist_high" || var_4 == "assist_steal" || var_4 == "assist_tactical" || var_4 == "assist_painted" || var_4 == "assist_painted_expeditionary" || var_4 == "assist_riot_shield") {
    _id_0468::ae_sendassistevent(var_4);

    if(isDefined(level.thermalvisionon) && level.thermalvisionon == 1) {
      return;
    }
    maps\mp\_utility::incplayerstat("assists", 1);
    maps\mp\_utility::incpersstat("assists", 1);
    self._id_0021 = maps\mp\_utility::getpersstat("assists");

    if(isDefined(var_3)) {
      foreach(var_6 in var_3) {
        var_7 = maps\mp\_utility::_id_4431(var_6, 1);

        if(maps\mp\_utility::_id_5856(var_7)) {
          var_7 = maps\mp\gametypes\_class::getbasefromlootversion(var_7);
        }

        maps\mp\gametypes\_gamelogic::setweaponstat(var_7, 1, "assists");
      }
    }

    if(var_4 != "assist_riot_shield" && maps\mp\_utility::_hasperk("specialty_extraobjectivescore")) {
      if(!isDefined(self.pers["extraObjectiveScoreAssists"])) {
        self.pers["extraObjectiveScoreAssists"] = 0;
      }

      self.pers["extraObjectiveScoreAssists"] = self.pers["extraObjectiveScoreAssists"] + 1;

      if(self.pers["extraObjectiveScoreAssists"] % 2 == 0) {
        level thread maps\mp\gametypes\_rank::awardgameevent("assist_cavalry", self, var_2, var_0);
      }
    }

    maps\mp\gametypes\_persistence::statsetchild("round", "assists", self._id_0021);
    thread maps\mp\gametypes\_missions::playerassist();

    if(level.practiceround) {
      thread practiceroundassistevent(var_0);
    }

    if(maps\mp\_utility::_hasperk("specialty_class_espionage")) {
      thread maps\mp\gametypes\_missions::processchallenge("ch_operations_espionage");
    }
  }
}

_id_7751(var_0, var_1, var_2) {
  if(isDefined(level._id_10EB) && level._id_10EB) {
    return;
  }
  var_3 = "crossfire_low";

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  self endon("disconnect");
  var_0 endon("disconnect");
  waitframe();
  level thread maps\mp\gametypes\_rank::awardgameevent(var_3, self, var_2, var_0);

  if(var_3 != "crossfire_riot_shield" && maps\mp\_utility::_hasperk("specialty_extraobjectivescore")) {
    if(!isDefined(self.pers["extraObjectiveScoreCrossfires"])) {
      self.pers["extraObjectiveScoreCrossfires"] = 0;
    }

    self.pers["extraObjectiveScoreCrossfires"] = self.pers["extraObjectiveScoreCrossfires"] + 1;

    if(self.pers["extraObjectiveScoreCrossfires"] % 2 == 0) {
      level thread maps\mp\gametypes\_rank::awardgameevent("crossfire_cavalry", self, var_2, var_0);
    }
  }

  _id_0468::ae_sendassistevent();

  if(isDefined(level.thermalvisionon) && level.thermalvisionon == 1) {
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

    if(maps\mp\_utility::_id_5856(var_1)) {
      var_1 = maps\mp\gametypes\_class::getbasefromlootversion(var_1);
    }

    var_2 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_0, var_1);

    if(var_2 == "weapon_assault" || var_2 == "weapon_pistol" || var_2 == "weapon_special") {
      if(issubstr(var_1, "dlcgun") && (var_2 == "weapon_assault" || var_2 == "weapon_special")) {
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_" + var_1);
      } else {
        maps\mp\gametypes\_missions::processchallenge("ch_dodge_" + var_1);
      }
    }
  }
}

camosprintslidekillevent(var_0, var_1) {
  var_2 = maps\mp\_utility::_id_4431(var_0, 1);

  if(maps\mp\_utility::_id_5856(var_2)) {
    var_2 = maps\mp\gametypes\_class::getbasefromlootversion(var_2);
  }

  var_3 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_0, var_2);

  switch (var_3) {
    case "weapon_pistol":
    case "weapon_special":
    case "weapon_shotgun":
    case "weapon_smg":
      if(issubstr(var_2, "dlcgun") && var_3 == "weapon_special") {
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_" + var_2);
      } else {
        maps\mp\gametypes\_missions::processchallenge("ch_slide_" + var_2);
      }

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