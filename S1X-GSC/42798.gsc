/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42798.gsc
**************************************/

init() {
  var_0 = getdvar("g_gametype");
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
  var_2["horde"] = 13;
  var_2["twar"] = 14;
  var_2["hp"] = 15;
  var_2["ball"] = 16;

  for(;;) {
    if(!isDefined(var_2[var_0])) {
      var_0 = "war";
    }

    var_3 = tablelookupbyrow("mp/xp_event_table.csv", var_1, 0);
    var_4 = tablelookupbyrow("mp/xp_event_table.csv", var_1, 1);
    var_5 = tablelookupbyrow("mp/xp_event_table.csv", var_1, 2);
    var_6 = tablelookupbyrow("mp/xp_event_table.csv", var_1, var_2[var_0]);

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    if(var_3 == "win" || var_3 == "loss" || var_3 == "tie") {
      var_6 = float(var_6);
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
    var_0.lastkilledby = undefined;
    var_0.recentkillcount = 0;
    var_0.lastkilltime = 0;
    var_0.bulletstreak = 0;
    var_0.lastcoopstreaktime = 0;
  }
}

killedplayer(var_0, var_1, var_2, var_3, var_4) {
  level.numkills++;
  var_5 = var_1.guid;
  var_6 = var_1.pers["cur_kill_streak"];
  var_7 = self.guid;
  var_8 = gettime();

  if(maps\mp\_utility::isbulletdamage(var_3)) {
    if(self.lastkilltime == var_8) {
      self.bulletstreak++;
    } else {
      self.bulletstreak = 1;
    }
  } else {
    self.bulletstreak = 0;
  }

  self.lastkilltime = gettime();
  self.lastkilledplayer = var_1;
  self.modifiers = [];
  self.damagedplayers[var_5] = undefined;
  thread updaterecentkills(var_0, var_2);

  if(!maps\mp\_utility::iskillstreakweapon(var_2)) {
    if(var_2 == "none") {
      return 0;
    }

    if(isDefined(var_1.throwinggrenade)) {
      var_9 = maps\mp\_utility::strip_suffix(var_1.throwinggrenade, "_lefthand");

      if(var_9 == "frag_grenade_mp") {
        self.modifiers["cooking"] = 1;
      }
    }

    if(weaponinventorytype(var_2) == "primary") {
      self.segments["killDistanceTotal"] = self.segments["killDistanceTotal"] + distance2d(self.origin, var_1.origin);
      self.segments["killDistanceCount"]++;
    }

    if(var_3 == "MOD_HEAD_SHOT") {
      headshotevent(var_0, var_2, var_3);
    }

    if(level.numkills == 1) {
      firstbloodevent(var_0, var_2, var_3);
    }

    if(level.teambased && var_8 - var_1.lastkilltime < 3000 && var_1.lastkilledplayer != self) {
      avengedplayerevent(var_0, var_2, var_3);
    }

    if(!isalive(self) && self != var_1 && isDefined(self.deathtime) && self.deathtime + 1200 < gettime()) {
      postdeathkillevent(var_0);
    }

    if(self.pers["cur_death_streak"] > 3) {
      comebackevent(var_0, var_2, var_3);
    }

    if(isDefined(self.assistedsuicide) && self.assistedsuicide) {
      assistedsuicideevent(var_0, var_2, var_3);
    }

    if(islongshot(self, var_2, var_3, var_1)) {
      longshotevent(var_0, var_2, var_3);
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
      revengeevent(var_0);
    }

    if(var_1.idflags &level.idflags_penetration) {
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

    if(common_scripts\utility::isflashed()) {
      flashedkillevent(var_2, var_3);
    }

    if(isthinkfast(var_2, var_3)) {
      thinkfastevent();
    }

    if(self.bulletstreak == 2) {
      multikillonebulletevent();
    }

    if(isbackstabevent(var_1, var_2, var_3)) {
      backstabevent();
    }

    if(isthrowbackevent(var_1, var_2, var_3)) {
      throwbackkillevent();
    }

    var_10 = undefined;

    if(maps\mp\_utility::isstrstart(var_2, "alt_")) {
      var_10 = getsubstr(var_2, 4);
    }

    if(isDefined(self.pickedupweaponfrom[var_2]) && self.pickedupweaponfrom[var_2] == var_1 && !maps\mp\_utility::ismeleemod(var_3)) {
      takeandkillevent();
    } else if(isDefined(var_10) && isDefined(self.pickedupweaponfrom[var_10]) && self.pickedupweaponfrom[var_10] == var_1 && !maps\mp\_utility::ismeleemod(var_3)) {
      takeandkillevent();
    }

    if(isDefined(var_2) && var_2 == "iw5_carrydrone_mp") {
      killwithballevent();
    }

    if(isDefined(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_ballcarrier") && !(isDefined(var_1.weaponusagename) && var_1.weaponusagename == "iw5_dlcgun12loot9_mp")) {
      killedballcarrierevent();
    }

    if(isDefined(self.exomostrecenttimedeciseconds["exo_dodge"]) && 20 > maps\mp\_utility::gettimepasseddecisecondsincludingrounds() - self.exomostrecenttimedeciseconds["exo_dodge"]) {
      killafterdodgeevent(var_2);
    }

    checkhighjumpevents(var_1, var_0, var_2, var_3, var_4);
    checkhigherrankkillevents(var_1);
    checkweaponspecifickill(var_1, var_2, var_3);
  }

  checkstreakingevents(var_1);

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
    var_3 = maps\mp\_utility::getbaseweaponname(var_1, 1);

    if(maps\mp\_utility::islootweapon(var_3)) {
      var_3 = maps\mp\gametypes\_class::getbasefromlootversion(var_3);
    }

    var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_1, var_3);

    if(var_4 == "weapon_special" || var_4 == "weapon_shotgun" || var_4 == "weapon_pistol") {
      switch (var_3) {
        case "iw5_dlcgun4":
        case "iw5_dlcgun3":
          maps\mp\gametypes\_missions::processchallenge("ch_tier1_1_" + var_3);
          break;
        case "iw5_dlcgun8loot1":
          maps\mp\gametypes\_missions::processchallenge("ch_tier1_1_iw5_dlcgun9");
          break;
        case "iw5_dlcgun13":
          maps\mp\gametypes\_missions::processchallenge("ch_tier1_1_iw5_dlcgun10");
          break;
        default:
          maps\mp\gametypes\_missions::processchallenge("ch_pointblank_" + var_3);
          break;
      }
    }
  }
}

killedplayerevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("kills", 1);
  maps\mp\_utility::incpersstat("kills", 1);
  self.kills = maps\mp\_utility::getpersstat("kills");
  maps\mp\gametypes\_persistence::statsetchild("round", "kills", self.kills);
  maps\mp\_utility::updatepersratio("kdRatio", "kills", "deaths");
  var_3 = "kill";

  switch (var_1) {
    case "killstreak_orbital_laser_mp":
    case "orbital_laser_fov_mp":
      var_3 = "vulcan_kill";
      break;
    case "paint_missile_killstreak_mp":
    case "warbird_player_turret_mp":
    case "warbird_remote_turret_mp":
    case "warbird_missile_mp":
      var_3 = "warbird_kill";
      break;
    case "orbitalsupport_small_turret_mp":
    case "orbitalsupport_medium_turret_mp":
    case "orbitalsupport_big_turret_mp":
    case "orbitalsupport_40mmbuddy_mp":
    case "orbitalsupport_40mm_mp":
    case "orbitalsupport_missile_mp":
    case "orbitalsupport_105mm_mp":
      var_3 = "paladin_kill";
      break;
    case "airdrop_trap_explosive_mp":
      var_3 = "airdrop_trap_kill";
      break;
    case "orbital_carepackage_pod_mp":
      var_3 = "airdrop_kill";
      break;
    case "remotemissile_projectile_secondary_mp":
    case "remotemissile_projectile_cluster_child_hellfire_mp":
    case "killstreak_strike_missile_gas_mp":
    case "remotemissile_projectile_cluster_child_mp":
    case "remotemissile_projectile_gas_mp":
    case "remotemissile_projectile_cluster_parent_mp":
    case "remotemissile_projectile_mp":
      var_3 = "missile_strike_kill";
      break;
    case "iw5_dlcgun12loot3_mp":
    case "remote_turret_mp":
    case "killstreakmahem_mp":
    case "remote_energy_turret_mp":
    case "sentry_minigun_mp":
    case "turretheadmg_mp":
    case "turretheadrocket_mp":
    case "turretheadenergy_mp":
      var_3 = "sentry_gun_kill";
      break;
    case "airstrike_missile_mp":
    case "orbital_carepackage_pod_plane_mp":
    case "stealth_bomb_mp":
      var_3 = "strafing_run_kill";
      break;
    case "assaultdrone_c4_mp":
    case "drone_assault_remote_turret_mp":
    case "ugv_missile_mp":
      var_3 = "assault_drone_kill";
      break;
    case "playermech_rocket_mp":
    case "iw5_mechpunch_mp":
    case "iw5_exominigun_mp":
    case "iw5_exoxmgjugg_mp_akimbo":
    case "iw5_juggernautrockets_mp":
    case "juggernaut_sentry_mg_mp":
    case "killstreak_goliathsd_mp":
    case "orbital_carepackage_droppod_mp":
    case "iw5_juggtitan45_mp":
      var_3 = "goliath_kill";
      break;
    case "iw5_dlcgun12loot2_mp":
    case "iw5_dlcgun12loot5_mp":
    case "mp_laser2_core":
    case "killstreak_comeback_mp":
    case "killstreak_terrace_mp":
    case "detroit_tram_turret_mp":
    case "dam_turret_mp":
    case "refraction_turret_mp":
    case "killstreak_solar_mp":
      var_3 = "map_killstreak_kill";
      break;
  }

  if(var_3 != "kill") {
    maps\mp\_utility::incplayerstat(var_3, 1);
    maps\mp\gametypes\_missions::ch_streak_kill(var_3);
  }

  if(level.practiceround) {
    thread practiceroundkillevent(var_0, var_3, var_1, var_2);
  }

  level thread maps\mp\gametypes\_rank::awardgameevent(var_3, self, var_1, var_0, var_2);
}

practicerounddialogvalid() {
  return !isDefined(self.next_pr_dialog_time) || gettime() > self.next_pr_dialog_time;
}

practicerounddialogplayed() {
  self.next_pr_dialog_time = gettime() + randomintrange(20000, 40000);
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
    self.best_pr_kills = self getcommonplayerdata("bests", "kills");
  }

  if(self.best_pr_kills > 0 && self.kills > self.best_pr_kills) {
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
    case "stun_grenade__mp":
    case "smoke_grenade_var_mp":
    case "paint_grenade_var_mp":
    case "emp_grenade_var_mp":
    case "stun_grenade_var_mp":
    case "smoke_grenade_mp":
    case "emp_grenade_mp":
    case "paint_grenade_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      return 1;
    default:
      return 0;
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

earnedkillstreakevent(var_0, var_1, var_2, var_3) {
  maps\mp\_utility::incplayerstat(var_0 + "_earned", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent(var_0 + "_earned", self);
  thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_0, var_1, undefined, var_2, var_3);
  maps\mp\gametypes\_missions::processchallengedaily(22, var_0, undefined);
  maps\mp\gametypes\_missions::processchallengedaily(23, var_0, undefined);
  maps\mp\gametypes\_missions::processchallengedaily(32, var_0, undefined);
  maps\mp\gametypes\_missions::processchallengedaily(35, var_0, undefined);
}

bulletpenetrationevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("bulletpenkills", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("bulletpen", self);

  if(isDefined(var_1)) {
    var_2 = maps\mp\_utility::getbaseweaponname(var_1, 1);

    if(maps\mp\_utility::islootweapon(var_2)) {
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
    airtoairevent(var_1, var_2, var_3);
  }

  if(var_5 && !var_6) {
    airtogroundevent(var_1, var_2, var_3);
  }

  if(!var_5 && var_6) {
    groundtoairevent(var_1, var_2, var_3);
  }
}

checkweaponspecifickill(var_0, var_1, var_2) {
  if(maps\mp\gametypes\_weapons::isriotshield(var_1) || var_1 == maps\mp\_exo_shield::get_exo_shield_weapon()) {
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
    maps\mp\gametypes\_missions::processchallenge("ch_humiliation_boomerang");
  } else {
    level thread maps\mp\gametypes\_rank::awardgameevent("exo_knife_kill", self, var_0, undefined, var_1);
  }
}

neardeathkillevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("near_death_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("near_death_kill", self, var_0, undefined, var_1);
}

sprintslidekillevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("slide_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("slide_kill", self, var_0, undefined, var_1);
}

flashedkillevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("flash_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("flash_kill", self, var_0, undefined, var_1);
}

riotshieldkillevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("riot_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("riot_kill", self, var_0, undefined, var_1);
}

airtoairevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("air_to_air_kill", 1);
  thread maps\mp\gametypes\_missions::processchallenge("ch_limited_acepilot", 1);
  thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_redbaron", 1);
  var_3 = maps\mp\_utility::getbaseweaponname(var_1, 1);

  if(maps\mp\_utility::islootweapon(var_3)) {
    var_3 = maps\mp\gametypes\_class::getbasefromlootversion(var_3);
  }

  var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_1, var_3);

  if(maps\mp\_utility::ismeleemod(var_2)) {
    maps\mp\_utility::incplayerstat("melee_air_to_air", 1);
    level thread maps\mp\gametypes\_rank::awardgameevent("melee_air_to_air", self, var_1, undefined, var_2);
  } else {
    level thread maps\mp\gametypes\_rank::awardgameevent("air_to_air_kill", self, var_1, undefined, var_2);

    if(var_4 == "weapon_smg" || var_4 == "weapon_shotgun") {
      switch (var_3) {
        case "iw5_dlcgun4":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_" + var_3);
          break;
        case "iw5_dlcgun8loot1":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_iw5_dlcgun9");
          break;
        case "iw5_dlcgun18":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_iw5_dlcgun11");
          break;
        case "iw5_dlcgun28":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_iw5_dlcgunb");
          break;
        case "iw5_dlcgun38":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_iw5_dlcgund");
          break;
        default:
          maps\mp\gametypes\_missions::processchallenge("ch_dogfight_" + var_3);
          break;
      }
    }
  }
}

airtogroundevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("air_to_ground_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("air_to_ground_kill", self, var_1, undefined, var_2);
  thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_buzz");
  var_3 = maps\mp\_utility::getbaseweaponname(var_1, 1);

  if(maps\mp\_utility::islootweapon(var_3)) {
    var_3 = maps\mp\gametypes\_class::getbasefromlootversion(var_3);
  }

  var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_1, var_3);

  if(var_4 == "weapon_assault" || var_4 == "weapon_heavy" || issubstr(var_1, "exocrossbow")) {
    switch (var_3) {
      case "iw5_dlcgun1":
      case "iw5_dlcgun2":
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_" + var_3);
        break;
      case "iw5_dlcgun6":
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_iw5_dlcgun5");
        break;
      case "iw5_dlcgun7loot0":
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_iw5_dlcgun7");
        break;
      case "iw5_dlcgun7loot6":
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_iw5_dlcgun8");
        break;
      case "iw5_dlcgun23":
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_iw5_dlcguna");
        break;
      case "iw5_dlcgun33":
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_iw5_dlcgunc");
        break;
      default:
        maps\mp\gametypes\_missions::processchallenge("ch_strafe_" + var_3);
        break;
    }
  }
}

groundtoairevent(var_0, var_1, var_2) {
  maps\mp\_utility::incplayerstat("ground_to_air_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("ground_to_air_kill", self, var_1, undefined, var_2);
  thread maps\mp\gametypes\_missions::processchallenge("ch_exomech_pull");
  var_3 = maps\mp\_utility::getbaseweaponname(var_1, 1);

  if(maps\mp\_utility::islootweapon(var_3)) {
    var_3 = maps\mp\gametypes\_class::getbasefromlootversion(var_3);
  }

  var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_1, var_3);

  if(var_4 == "weapon_heavy" || issubstr(var_1, "exocrossbow")) {
    switch (var_3) {
      case "iw5_dlcgun2":
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_" + var_3);
        break;
      default:
        maps\mp\gametypes\_missions::processchallenge("ch_skeet_" + var_3);
        break;
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

  if(var_3 == "weapon_sniper" || var_3 == "weapon_shotgun") {
    return 1;
  }

  return 0;
}

islongshot(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3.agentbody)) {
    return 0;
  }

  var_4 = self.origin;

  if(isDefined(var_3.attackerposition)) {
    var_4 = var_3.attackerposition;
  }

  if(isalive(var_0) && !var_0 maps\mp\_utility::isusingremote() && (var_2 == "MOD_RIFLE_BULLET" || var_2 == "MOD_PISTOL_BULLET" || var_2 == "MOD_HEAD_SHOT" || issubstr(var_1, "exoknife_mp") || issubstr(var_1, "exocrossbow") || issubstr(var_1, "m990")) && !maps\mp\_utility::iskillstreakweapon(var_1) && !isDefined(var_0.assistedsuicide)) {
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
  thread maps\mp\_matchdata::logkillevent(var_0, "longshot");
}

headshotevent(var_0, var_1, var_2) {
  self.modifiers["headshot"] = 1;
  maps\mp\_utility::incpersstat("headshots", 1);
  maps\mp\_utility::incplayerstat("headshots", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "headshots", maps\mp\_utility::clamptoshort(self.pers["headshots"]));
  self.headshots = maps\mp\_utility::getpersstat("headshots");
  level thread maps\mp\gametypes\_rank::awardgameevent("headshot", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "headshot");
  maps\mp\gametypes\_missions::processchallenge("ch_limited_headhunter");
}

isthrowbackevent(var_0, var_1, var_2) {
  if(!isexplosivedamagemod(var_2)) {
    return 0;
  }

  if(!maps\mp\_utility::isstrstart(var_1, "frag_")) {
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

fourplayevent() {
  maps\mp\_utility::incplayerstat("four_play", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("four_play", self);
}

avengedplayerevent(var_0, var_1, var_2) {
  self.modifiers["avenger"] = 1;
  maps\mp\_utility::incplayerstat("avengekills", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("avenger", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "avenger");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_avenger");
}

assistedsuicideevent(var_0, var_1, var_2) {
  self.modifiers["assistedsuicide"] = 1;
  maps\mp\_utility::incplayerstat("assistedsuicide", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("assistedsuicide", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "assistedsuicide");
}

defendedplayerevent(var_0, var_1, var_2) {
  self.modifiers["defender"] = 1;
  maps\mp\_utility::incplayerstat("rescues", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("defender", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "defender");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_savior");
}

defendobjectiveevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("defends", 1);
  maps\mp\_utility::incpersstat("defends", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "defends", self.pers["defends"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("defend", self);
  var_0 thread maps\mp\_matchdata::logkillevent(var_1, "assaulting");
}

assaultobjectiveevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("assault", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("assault", self);
  var_0 thread maps\mp\_matchdata::logkillevent(var_1, "defending");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_attacker");
  maps\mp\gametypes\_missions::processchallengedaily(7, undefined, undefined);
}

postdeathkillevent(var_0) {
  self.modifiers["posthumous"] = 1;
  maps\mp\_utility::incplayerstat("posthumous", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("posthumous", self);
  thread maps\mp\_matchdata::logkillevent(var_0, "posthumous");
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_afterlife");
}

isbackstabevent(var_0, var_1, var_2) {
  if(!maps\mp\_utility::ismeleemod(var_2)) {
    return 0;
  }

  if(maps\mp\gametypes\_weapons::isriotshield(var_1) || var_1 == maps\mp\_exo_shield::get_exo_shield_weapon()) {
    return 0;
  }

  var_3 = var_0 getangles();
  var_4 = self getangles();
  var_5 = angleclamp180(var_3[1] - var_4[1]);

  if(abs(var_5) < 75) {
    return 1;
  }

  return 0;
}

backstabevent(var_0) {
  maps\mp\_utility::incplayerstat("backstab", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("backstab", self);
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_backstab");
}

revengeevent(var_0) {
  self.modifiers["revenge"] = 1;
  self.lastkilledby = undefined;
  maps\mp\_utility::incplayerstat("revengekills", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("revenge", self);
  thread maps\mp\_matchdata::logkillevent(var_0, "revenge");
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_revenge");
}

multikillevent(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_2);
  var_5 = maps\mp\_utility::getbaseweaponname(var_2, 1);

  if(maps\mp\_utility::islootweapon(var_5)) {
    var_5 = maps\mp\gametypes\_class::getbasefromlootversion(var_5);
  }

  var_6 = "";

  if(common_scripts\utility::string_starts_with(var_5, "iw5_")) {
    var_6 = getsubstr(var_5, 4);
  }

  switch (var_1) {
    case 2:
      level thread maps\mp\gametypes\_rank::awardgameevent("doublekill", self);
      maps\mp\_utility::incplayerstat("doublekill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_double");
      maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_double");

      if(var_4 == "weapon_smg" || var_4 == "weapon_shotgun" || var_4 == "weapon_sniper" || var_5 == "iw5_microdronelauncher" || var_5 == "iw5_exocrossbow") {
        switch (var_5) {
          case "iw5_dlcgun6loot5":
            maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_iw5_dlcgun6");
            break;
          case "iw5_dlcgun18":
            maps\mp\gametypes\_missions::processchallenge("ch_tier2_2_iw5_dlcgun11");
            break;
          case "iw5_dlcgun28":
            maps\mp\gametypes\_missions::processchallenge("ch_tier2_2_iw5_dlcgunb");
            break;
          case "iw5_dlcgun38":
            maps\mp\gametypes\_missions::processchallenge("ch_tier2_2_iw5_dlcgund");
            break;
          default:
            maps\mp\gametypes\_missions::processchallenge("ch_double_" + var_5);
            break;
        }
      }

      if(isDefined(level.challengeinfo["ch_attach_unlock_double_" + var_6])) {
        maps\mp\gametypes\_missions::processchallenge("ch_attach_unlock_double_" + var_6);
      }

      break;
    case 3:
      level thread maps\mp\gametypes\_rank::awardgameevent("triplekill", self);
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
      level thread maps\mp\gametypes\_rank::awardgameevent("fourkill", self);
      level thread maps\mp\_utility::teamplayercardsplash("callout_4xkill", self);
      maps\mp\_utility::incplayerstat("fourkill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_feed");
      maps\mp\gametypes\_missions::processchallenge("ch_killer_fury");
      maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed_fury");
      break;
    case 5:
      level thread maps\mp\gametypes\_rank::awardgameevent("fivekill", self);
      level thread maps\mp\_utility::teamplayercardsplash("callout_5xkill", self);
      maps\mp\_utility::incplayerstat("fivekill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_frenzy");
      break;
    case 6:
      level thread maps\mp\gametypes\_rank::awardgameevent("sixkill", self);
      level thread maps\mp\_utility::teamplayercardsplash("callout_6xkill", self);
      maps\mp\_utility::incplayerstat("sixkill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_super");
      break;
    case 7:
      level thread maps\mp\gametypes\_rank::awardgameevent("sevenkill", self);
      level thread maps\mp\_utility::teamplayercardsplash("callout_7xkill", self);
      maps\mp\_utility::incplayerstat("sevenkill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_mega");
      break;
    case 8:
      level thread maps\mp\gametypes\_rank::awardgameevent("eightkill", self);
      level thread maps\mp\_utility::teamplayercardsplash("callout_8xkill", self);
      maps\mp\_utility::incplayerstat("eightkill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_ultra");
      break;
    default:
      level thread maps\mp\gametypes\_rank::awardgameevent("multikill", self);
      thread maps\mp\_utility::teamplayercardsplash("callout_9xpluskill", self);
      maps\mp\_utility::incplayerstat("multikill", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_chain");
      break;
  }

  thread maps\mp\_matchdata::logmultikill(var_0, var_1);
}

takeandkillevent() {
  maps\mp\_utility::incplayerstat("take_and_kill", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("take_and_kill", self);
  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_backfire");
}

killedballcarrierevent() {
  maps\mp\_utility::incplayerstat("killedBallCarrier", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("killedBallCarrier", self);
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
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_touchdown");
  maps\mp\gametypes\_missions::processchallengedaily(13, var_0, undefined);
}

fieldgoalevent(var_0) {
  thread maps\mp\_utility::teamplayercardsplash("callout_fieldgoal", self, undefined, var_0);
  maps\mp\_utility::incplayerstat("fieldgoal", 1);
  setuplinkstats();
  level thread maps\mp\gametypes\_rank::awardgameevent("fieldgoal", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_fieldgoal");
  maps\mp\gametypes\_missions::processchallengedaily(13, var_0, undefined);
}

interceptionevent() {
  maps\mp\_utility::incplayerstat("interception", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("interception", self);
}

killwithballevent() {
  maps\mp\_utility::incplayerstat("kill_with_ball", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_with_ball", self);
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

flagpickupevent() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagpickup", self);
  maps\mp\_utility::incplayerstat("flagscarried", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("flag_pickup", self);
  thread maps\mp\_matchdata::loggameevent("pickup", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_carry");
}

flagcaptureevent() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagcapture", self);
  maps\mp\_utility::incplayerstat("flagscaptured", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("flag_capture", self);
  thread maps\mp\_matchdata::loggameevent("capture", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_capture");
  maps\mp\gametypes\_missions::processchallengedaily(16, undefined, undefined);
}

flagreturnevent() {
  thread maps\mp\_utility::teamplayercardsplash("callout_flagreturn", self);
  maps\mp\_utility::incplayerstat("flagsreturned", 1);
  maps\mp\_utility::incpersstat("returns", 1);
  self.assists = self.pers["returns"];
  maps\mp\gametypes\_persistence::statsetchild("round", "returns", self.pers["returns"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("flag_return", self);
  thread maps\mp\_matchdata::loggameevent("return", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_return");
  maps\mp\gametypes\_missions::processchallengedaily(17, undefined, undefined);
}

killwithflagevent() {
  maps\mp\_utility::incplayerstat("killsasflagcarrier", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_with_flag", self);
}

killflagcarrierevent(var_0) {
  thread maps\mp\_utility::teamplayercardsplash("callout_killflagcarrier", self);
  maps\mp\_utility::incplayerstat("flagcarrierkills", 1);
  maps\mp\_utility::incpersstat("defends", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "defends", self.pers["defends"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_flag_carrier", self);
  thread maps\mp\_matchdata::logkillevent(var_0, "carrying");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_flag_defend");
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
  maps\mp\gametypes\_missions::processchallengedaily(21, undefined, undefined);
}

killconfirmedevent() {
  maps\mp\_utility::incplayerstat("killsconfirmed", 1);
  maps\mp\_utility::incpersstat("confirmed", 1);
  maps\mp\_utility::setextrascore0(self.pers["confirmed"]);
  maps\mp\gametypes\_persistence::statsetchild("round", "confirmed", self.pers["confirmed"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_confirmed", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_collector");
  maps\mp\gametypes\_missions::processchallengedaily(4, undefined, undefined);
}

tagcollectorevent() {
  maps\mp\_utility::incplayerstat("tag_collector", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("tag_collector", self);
}

monitortagcollector(var_0) {
  if(!isplayer(var_0)) {
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
  var_0.tagcollectortotal = 0;
}

bombplantevent() {
  maps\mp\_utility::incplayerstat("bombsplanted", 1);
  maps\mp\_utility::incpersstat("plants", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "plants", self.pers["plants"]);
  maps\mp\_utility::setextrascore0(self.pers["plants"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("plant", self);
  thread maps\mp\_matchdata::loggameevent("plant", self.origin);
}

bombdefuseevent(var_0) {
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
  thread maps\mp\_matchdata::loggameevent("defuse", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_bombdefuse");
}

eliminateplayerevent(var_0, var_1) {
  maps\mp\_utility::incplayerstat("elimination", 1);
  level thread maps\mp\_utility::teamplayercardsplash("callout_eliminated", var_1);

  if(var_0) {
    maps\mp\_utility::incplayerstat("last_man_standing", 1);
    level thread maps\mp\gametypes\_rank::awardgameevent("last_man_standing", self);
  } else {
    level thread maps\mp\gametypes\_rank::awardgameevent("elimination", self);
  }
}

revivetagevent(var_0) {
  maps\mp\_utility::incplayerstat("sr_tag_revive", 1);
  maps\mp\_utility::incplayerstat("killsdenied", 1);
  maps\mp\_utility::incpersstat("denied", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "denied", self.pers["denied"]);
  self.assists = self.pers["denied"];
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

bombdetonateevent() {
  maps\mp\_utility::incplayerstat("targetsdestroyed", 1);
  maps\mp\_utility::incpersstat("destructions", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "destructions", self.pers["destructions"]);
  level thread maps\mp\gametypes\_rank::awardgameevent("destroy", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_destroyer");
}

increasegunlevelevent() {
  maps\mp\_utility::incplayerstat("levelup", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("gained_gun_score", self);
}

decreasegunlevelevent() {
  maps\mp\_utility::incplayerstat("dejavu", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("dropped_gun_score", self);
}

setbackenemygunlevelevent() {
  maps\mp\_utility::incplayerstat("humiliation", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("dropped_enemy_gun_rank", self);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_regression");
}

quickgunlevelevent() {
  maps\mp\_utility::incplayerstat("gunslinger", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("quick_gun_rank", self);
}

setbackfirstplayergunlevelevent() {
  maps\mp\_utility::incplayerstat("regicide", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("dropped_first_player_gun_rank", self);
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

domcaptureevent(var_0) {
  maps\mp\_utility::incplayerstat("pointscaptured", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
  var_1 = "capture";

  if(var_0) {
    var_1 = "opening_move";
    maps\mp\_utility::incplayerstat("opening_move", 1);
  }

  level thread maps\mp\gametypes\_rank::awardgameevent(var_1, self);
  thread maps\mp\_matchdata::loggameevent("capture", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_aggression");
  maps\mp\gametypes\_missions::processchallengedaily(6, undefined, undefined);
}

domneutralizeevent() {
  level thread maps\mp\gametypes\_rank::awardgameevent("neutralize", self);
}

killwhilecapture(var_0, var_1) {
  maps\mp\_utility::incplayerstat("assault", 1);
  maps\mp\_utility::incplayerstat("kill_while_capture", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("kill_while_capture", self);
  var_0 thread maps\mp\_matchdata::logkillevent(var_1, "defending");
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_defender");
}

securehardpointevent() {
  maps\mp\_utility::incplayerstat("hp_secure", 1);
  maps\mp\_utility::incpersstat("captures", 1);
  maps\mp\gametypes\_persistence::statsetchild("round", "captures", self.pers["captures"]);
  maps\mp\_utility::setextrascore0(self.pers["captures"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_hp_captured_by", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("hp_secure", self);
  thread maps\mp\_matchdata::loggameevent("capture", self.origin);
  maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_aggression");
}

firstbloodevent(var_0, var_1, var_2) {
  self.modifiers["firstblood"] = 1;
  maps\mp\_utility::incplayerstat("firstblood", 1);
  thread maps\mp\_utility::teamplayercardsplash("callout_firstblood", self);
  level thread maps\mp\gametypes\_rank::awardgameevent("firstblood", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "firstblood");
}

isbuzzkillevent(var_0) {
  foreach(var_2 in var_0.killstreaks) {
    if(maps\mp\killstreaks\_killstreaks::issupportstreak(var_0, var_2)) {
      continue;
    }
    var_3 = maps\mp\killstreaks\_killstreaks::getstreakcost(var_2);
    var_4 = var_0.adrenaline;

    if(var_3 < var_4) {
      continue;
    }
    if(var_3 - var_4 < 101) {
      return 1;
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
  var_3 = maps\mp\_utility::getbaseweaponname(var_1, 1);

  if(maps\mp\_utility::islootweapon(var_3)) {
    var_3 = maps\mp\gametypes\_class::getbasefromlootversion(var_3);
  }

  var_4 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_1, var_3);

  if(var_4 == "weapon_shotgun") {
    switch (var_3) {
      case "iw5_dlcgun4":
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_2_" + var_3);
        break;
      case "iw5_dlcgun8loot1":
        maps\mp\gametypes\_missions::processchallenge("ch_tier2_2_iw5_dlcgun9");
        break;
      default:
        break;
    }
  }

  if(var_4 == "weapon_sniper") {
    self notify("increment_sharpshooter_kills");
  } else if(var_4 == "weapon_shotgun") {
    self notify("increment_oneshotgun_kills");
  }
}

comebackevent(var_0, var_1, var_2) {
  self.modifiers["comeback"] = 1;
  maps\mp\_utility::incplayerstat("comebacks", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("comeback", self, var_1, undefined, var_2);
  thread maps\mp\_matchdata::logkillevent(var_0, "comeback");
}

semtexstickevent(var_0) {
  maps\mp\_utility::incplayerstat("semtex_stick", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("semtex_stick", self);
  var_0 maps\mp\_utility::incplayerstat("stuck_with_explosive", 1);

  if(!(isDefined(level.iszombiegame) && level.iszombiegame == 1)) {
    level thread maps\mp\gametypes\_rank::awardgameevent("stuck_with_explosive", var_0);
  }

  maps\mp\gametypes\_missions::processchallenge("ch_humiliation_stuck");
  self notify("increment_stuck_kills");
}

crossbowstickevent(var_0) {
  maps\mp\_utility::incplayerstat("crossbow_stick", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("crossbow_stick", self);
  var_0 maps\mp\_utility::incplayerstat("stuck_with_explosive", 1);

  if(!(isDefined(level.iszombiegame) && level.iszombiegame == 1)) {
    level thread maps\mp\gametypes\_rank::awardgameevent("stuck_with_explosive", var_0);
  }

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

  wait 2.0;

  if(self.recentkillcount > 1) {
    multikillevent(var_0, self.recentkillcount, var_1, var_2);
  }

  self.recentkillcount = 0;
}

hijackerevent(var_0) {
  maps\mp\_utility::incplayerstat("hijacker", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("hijacker", self);
  thread maps\mp\gametypes\_missions::genericchallenge("hijacker_airdrop");

  if(isDefined(var_0)) {
    var_0 maps\mp\gametypes\_hud_message::playercardsplashnotify("hijacked_airdrop", self);
  }
}

sharedevent() {
  maps\mp\_utility::incplayerstat("sharepackage", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("sharepackage", self);
}

mapkillstreakevent() {
  var_0 = getmatchdata("players", self.clientid, "numberOfMapstreaksReceived");
  var_0++;
  setmatchdata("players", self.clientid, "numberOfMapstreaksReceived", maps\mp\_utility::clamptobyte(var_0));
  maps\mp\_utility::incplayerstat("map_killstreak", 1);
  level thread maps\mp\gametypes\_rank::awardgameevent("map_killstreak", self);
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
  if(isDefined(level.ishorde)) {
    return;
  }
  if(!isDefined(self.attackerlist)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_1 = self.owner;

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
  var_1 = self.killstreakcount + 1;

  if(var_1 % 5 && var_1 < 30) {
    return;
  }
  switch (var_1) {
    case 5:
      level thread maps\mp\gametypes\_rank::awardgameevent("5killstreak", self);
      maps\mp\_utility::incplayerstat("5killstreak", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_blood");

      if(isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 1) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      break;
    case 10:
      level thread maps\mp\gametypes\_rank::awardgameevent("10killstreak", self);
      maps\mp\_utility::incplayerstat("10killstreak", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_merciless");
      maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_merciless");

      if(isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 2) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      if(self.loadoutoffhand == "specialty_null" && self.loadoutequipment == "specialty_null") {
        maps\mp\gametypes\_missions::processchallenge("ch_precision_wetwork");
      }

      break;
    case 15:
      level thread maps\mp\gametypes\_rank::awardgameevent("15killstreak", self);
      maps\mp\_utility::incplayerstat("15killstreak", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_ruthless");

      if(isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 3) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      break;
    case 20:
      level thread maps\mp\gametypes\_rank::awardgameevent("20killstreak", self);
      maps\mp\_utility::incplayerstat("20killstreak", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_relentless");

      if(isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 4) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      break;
    case 25:
      level thread maps\mp\gametypes\_rank::awardgameevent("25killstreak", self);
      maps\mp\_utility::incplayerstat("25killstreak", 1);
      maps\mp\gametypes\_missions::processchallenge("ch_killer_brutal");

      if(isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 5) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      break;
    case 30:
      level thread maps\mp\gametypes\_rank::awardgameevent("30killstreak", self);
      maps\mp\_utility::incplayerstat("30killstreak", 1);

      if(isDefined(self.challengedata["ch_limited_bloodshed"]) && self.challengedata["ch_limited_bloodshed"] == 6) {
        maps\mp\gametypes\_missions::processchallenge("ch_limited_bloodshed", 5);
      }

      break;
    default:
      level thread maps\mp\gametypes\_rank::awardgameevent("30pluskillstreak", self);
      maps\mp\_utility::incplayerstat("30pluskillstreak", 1);
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

  if(var_1.size < 3) {
    return;
  }
  var_2 = common_scripts\utility::array_sort_with_func(var_1, ::is_score_a_greater_than_b);

  if(isDefined(var_2[0]) && var_0 == var_2[0]) {
    maps\mp\_utility::incplayerstat("firstplacekill", 1);
    level thread maps\mp\gametypes\_rank::awardgameevent("firstplacekill", self);
    maps\mp\gametypes\_missions::processchallenge("ch_precision_highvalue");
  }
}

is_score_a_greater_than_b(var_0, var_1) {
  return var_0.score > var_1.score;
}

processassistevent(var_0, var_1) {
  if(isDefined(level.assists_disabled) && level.assists_disabled) {
    return;
  }
  var_2 = "assist";

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  self endon("disconnect");
  var_0 endon("disconnect");
  wait 0.05;

  if(self.team != "axis" && self.team != "allies") {
    return;
  }
  if(self.team == var_0.team) {
    return;
  }
  level thread maps\mp\gametypes\_rank::awardgameevent(var_2, self, undefined, var_0);
  var_0 maps\mp\_matchdata::logspecialassists(self, var_2);

  if(var_2 == "assist" || var_2 == "assist_riot_shield") {
    maps\mp\_utility::incplayerstat("assists", 1);
    maps\mp\_utility::incpersstat("assists", 1);
    self.assists = maps\mp\_utility::getpersstat("assists");

    if(var_2 == "assist_riot_shield") {
      maps\mp\_utility::incplayerstat("assist_riot_shield", 1);
    }

    maps\mp\gametypes\_persistence::statsetchild("round", "assists", self.assists);
    thread maps\mp\gametypes\_missions::playerassist();

    if(level.practiceround) {
      thread practiceroundassistevent(var_0);
    }
  }
}

killafterdodgeevent(var_0) {
  maps\mp\gametypes\_missions::processchallenge("ch_exomech_evasive");
  maps\mp\gametypes\_missions::processchallengedaily(34, undefined, undefined);

  if(isDefined(var_0)) {
    var_1 = maps\mp\_utility::getbaseweaponname(var_0, 1);

    if(maps\mp\_utility::islootweapon(var_1)) {
      var_1 = maps\mp\gametypes\_class::getbasefromlootversion(var_1);
    }

    var_2 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_0, var_1);

    if(var_2 == "weapon_assault" || var_2 == "weapon_pistol" || var_2 == "weapon_special") {
      switch (var_1) {
        case "iw5_dlcgun3":
        case "iw5_dlcgun1":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_" + var_1);
          break;
        case "iw5_dlcgun6":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_iw5_dlcgun5");
          break;
        case "iw5_dlcgun7loot0":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_iw5_dlcgun7");
          break;
        case "iw5_dlcgun7loot6":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_iw5_dlcgun8");
          break;
        case "iw5_dlcgun13":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_2_iw5_dlcgun10");
          break;
        case "iw5_dlcgun23":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_iw5_dlcguna");
          break;
        case "iw5_dlcgun33":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_iw5_dlcgunc");
          break;
        default:
          maps\mp\gametypes\_missions::processchallenge("ch_dodge_" + var_1);
          break;
      }
    }
  }
}

camosprintslidekillevent(var_0, var_1) {
  var_2 = maps\mp\_utility::getbaseweaponname(var_0, 1);

  if(maps\mp\_utility::islootweapon(var_2)) {
    var_2 = maps\mp\gametypes\_class::getbasefromlootversion(var_2);
  }

  var_3 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_0, var_2);

  switch (var_3) {
    case "weapon_pistol":
    case "weapon_special":
    case "weapon_shotgun":
    case "weapon_smg":
      switch (var_2) {
        case "iw5_dlcgun3":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_iw5_dlcgun3");
          break;
        case "iw5_dlcgun4":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_iw5_dlcgun4");
          break;
        case "iw5_dlcgun8loot1":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_iw5_dlcgun9");
          break;
        case "iw5_dlcgun13":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_1_iw5_dlcgun10");
          break;
        case "iw5_dlcgun18":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_iw5_dlcgun11");
          break;
        case "iw5_dlcgun28":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_iw5_dlcgunb");
          break;
        case "iw5_dlcgun38":
          maps\mp\gametypes\_missions::processchallenge("ch_tier2_3_iw5_dlcgund");
          break;
        default:
          maps\mp\gametypes\_missions::processchallenge("ch_slide_" + var_2);
          break;
      }

      break;
  }
}