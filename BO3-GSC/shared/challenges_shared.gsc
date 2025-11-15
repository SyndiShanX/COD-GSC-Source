/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\challenges_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\drown;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace challenges;

function init_shared() {}

function pickedupballisticknife() {
  self.retreivedblades++;
}

function trackassists(attacker, damage, isflare) {
  if(!isDefined(self.flareattackerdamage)) {
    self.flareattackerdamage = [];
  }
  if(isDefined(isflare) && isflare == 1) {
    self.flareattackerdamage[attacker.clientid] = 1;
  } else {
    self.flareattackerdamage[attacker.clientid] = 0;
  }
}

function destroyedequipment(weapon) {
  if(isDefined(weapon) && weapon.isemp) {
    if(self util::is_item_purchased("emp_grenade")) {
      self addplayerstat("destroy_equipment_with_emp_grenade", 1);
    }
    self addweaponstat(weapon, "combatRecordStat", 1);
    if(self util::has_hacker_perk_purchased_and_equipped()) {
      self addplayerstat("destroy_equipment_with_emp_engineer", 1);
      self addplayerstat("destroy_equipment_engineer", 1);
    }
  } else if(self util::has_hacker_perk_purchased_and_equipped()) {
    self addplayerstat("destroy_equipment_engineer", 1);
  }
  self addplayerstat("destroy_equipment", 1);
  if(isDefined(weapon) && weapon.isbulletweapon) {
    self addplayerstat("destroy_equipment_with_bullet", 1);
  }
  self hackedordestroyedequipment();
}

function destroyedtacticalinsert() {
  if(!isDefined(self.pers["tacticalInsertsDestroyed"])) {
    self.pers["tacticalInsertsDestroyed"] = 0;
  }
  self.pers["tacticalInsertsDestroyed"]++;
  if(self.pers["tacticalInsertsDestroyed"] >= 5) {
    self.pers["tacticalInsertsDestroyed"] = 0;
    self addplayerstat("destroy_5_tactical_inserts", 1);
  }
}

function addflyswatterstat(weapon, aircraft) {
  if(!isDefined(self.pers["flyswattercount"])) {
    self.pers["flyswattercount"] = 0;
  }
  self addweaponstat(weapon, "destroyed_aircraft", 1);
  self.pers["flyswattercount"]++;
  if(self.pers["flyswattercount"] == 5) {
    self addweaponstat(weapon, "destroyed_5_aircraft", 1);
  }
  if(isDefined(aircraft) && isDefined(aircraft.birthtime)) {
    if((gettime() - aircraft.birthtime) < 20000) {
      self addweaponstat(weapon, "destroyed_aircraft_under20s", 1);
    }
  }
  if(!isDefined(self.destroyedaircrafttime)) {
    self.destroyedaircrafttime = [];
  }
  if(isDefined(self.destroyedaircrafttime[weapon]) && (gettime() - self.destroyedaircrafttime[weapon]) < 10000) {
    self addweaponstat(weapon, "destroyed_2aircraft_quickly", 1);
    self.destroyedaircrafttime[weapon] = undefined;
  } else {
    self.destroyedaircrafttime[weapon] = gettime();
  }
}

function destroynonairscorestreak_poststatslock(weapon) {
  self addweaponstat(weapon, "destroyed_aircraft", 1);
}

function canprocesschallenges() {
  if(getdvarint("", 0)) {
    return true;
  }
  if(level.rankedmatch || level.arenamatch || level.wagermatch || sessionmodeiscampaigngame()) {
    return true;
  }
  return false;
}

function initteamchallenges(team) {
  if(!isDefined(game["challenge"])) {
    game["challenge"] = [];
  }
  if(!isDefined(game["challenge"][team])) {
    game["challenge"][team] = [];
    game["challenge"][team]["plantedBomb"] = 0;
    game["challenge"][team]["destroyedBombSite"] = 0;
    game["challenge"][team]["capturedFlag"] = 0;
  }
  game["challenge"][team]["allAlive"] = 1;
}

function registerchallengescallback(callback, func) {
  if(!isDefined(level.challengescallbacks[callback])) {
    level.challengescallbacks[callback] = [];
  }
  level.challengescallbacks[callback][level.challengescallbacks[callback].size] = func;
}

function dochallengecallback(callback, data) {
  if(!isDefined(level.challengescallbacks)) {
    return;
  }
  if(!isDefined(level.challengescallbacks[callback])) {
    return;
  }
  if(isDefined(data)) {
    for(i = 0; i < level.challengescallbacks[callback].size; i++) {
      thread[[level.challengescallbacks[callback][i]]](data);
    }
  } else {
    for(i = 0; i < level.challengescallbacks[callback].size; i++) {
      thread[[level.challengescallbacks[callback][i]]]();
    }
  }
}

function on_player_connect() {
  self thread initchallengedata();
  self thread spawnwatcher();
  self thread monitorreloads();
}

function monitorreloads() {
  self endon("disconnect");
  self endon("killmonitorreloads");
  while(true) {
    self waittill("reload");
    currentweapon = self getcurrentweapon();
    if(currentweapon == level.weaponnone) {
      continue;
    }
    time = gettime();
    self.lastreloadtime = time;
    if(weaponhasattachment(currentweapon, "supply") || weaponhasattachment(currentweapon, "dualclip")) {
      self thread reloadthenkill(currentweapon);
    }
  }
}

function reloadthenkill(reloadweapon) {
  self endon("disconnect");
  self endon("death");
  self endon("reloadthenkilltimedout");
  self notify("reloadthenkillstart");
  self endon("reloadthenkillstart");
  self thread reloadthenkilltimeout(5);
  for(;;) {
    self waittill("killed_enemy_player", time, weapon);
    if(reloadweapon == weapon) {
      self addplayerstat("reload_then_kill_dualclip", 1);
    }
  }
}

function reloadthenkilltimeout(time) {
  self endon("disconnect");
  self endon("death");
  self endon("reloadthenkillstart");
  wait(time);
  self notify("reloadthenkilltimedout");
}

function initchallengedata() {
  self.pers["bulletStreak"] = 0;
  self.pers["lastBulletKillTime"] = 0;
  self.pers["stickExplosiveKill"] = 0;
  self.pers["carepackagesCalled"] = 0;
  self.explosiveinfo = [];
}

function isdamagefromplayercontrolledaitank(eattacker, einflictor, weapon) {
  if(weapon.name == "ai_tank_drone_gun") {
    if(isDefined(eattacker) && isDefined(eattacker.remoteweapon) && isDefined(einflictor)) {
      if(isDefined(einflictor.controlled) && einflictor.controlled) {
        if(eattacker.remoteweapon == einflictor) {
          return true;
        }
      }
    }
  } else if(weapon.name == "ai_tank_drone_rocket") {
    if(isDefined(einflictor) && !isDefined(einflictor.from_ai)) {
      return true;
    }
  }
  return false;
}

function isdamagefromplayercontrolledsentry(eattacker, einflictor, weapon) {
  if(weapon.name == "auto_gun_turret") {
    if(isDefined(eattacker) && isDefined(eattacker.remoteweapon) && isDefined(einflictor)) {
      if(eattacker.remoteweapon == einflictor) {
        if(isDefined(einflictor.controlled) && einflictor.controlled) {
          return true;
        }
      }
    }
  }
  return false;
}

function perkkills(victim, isstunned, time) {
  player = self;
  if(player hasperk("specialty_movefaster")) {
    player addplayerstat("perk_movefaster_kills", 1);
  }
  if(player hasperk("specialty_noname")) {
    player addplayerstat("perk_noname_kills", 1);
  }
  if(player hasperk("specialty_quieter")) {
    player addplayerstat("perk_quieter_kills", 1);
  }
  if(player hasperk("specialty_longersprint")) {
    if(isDefined(player.lastsprinttime) && (gettime() - player.lastsprinttime) < 2500) {
      player addplayerstat("perk_longersprint", 1);
    }
  }
  if(player hasperk("specialty_fastmantle")) {
    if(isDefined(player.lastsprinttime) && (gettime() - player.lastsprinttime) < 2500 && player playerads() >= 1) {
      player addplayerstat("perk_fastmantle_kills", 1);
    }
  }
  if(player hasperk("specialty_loudenemies")) {
    player addplayerstat("perk_loudenemies_kills", 1);
  }
  if(isstunned == 1 && player hasperk("specialty_stunprotection")) {
    player addplayerstat("perk_protection_stun_kills", 1);
  }
  activeenemyemp = 0;
  activecuav = 0;
  if(level.teambased) {
    foreach(team in level.teams) {
      assert(isDefined(level.activecounteruavs[team]));
      assert(isDefined(level.activeemps[team]));
      if(team == player.team) {
        continue;
      }
      if(level.activecounteruavs[team] > 0) {
        activecuav = 1;
      }
      if(level.activeemps[team] > 0) {
        activeenemyemp = 1;
      }
    }
  } else {
    assert(isDefined(level.activecounteruavs[victim.entnum]));
    assert(isDefined(level.activeemps[victim.entnum]));
    players = level.players;
    for(i = 0; i < players.size; i++) {
      if(players[i] != player) {
        if(isDefined(level.activecounteruavs[players[i].entnum]) && level.activecounteruavs[players[i].entnum] > 0) {
          activecuav = 1;
        }
        if(isDefined(level.activeemps[players[i].entnum]) && level.activeemps[players[i].entnum] > 0) {
          activeenemyemp = 1;
        }
      }
    }
  }
  if(activecuav == 1 || activeenemyemp == 1) {
    if(player hasperk("specialty_immunecounteruav")) {
      player addplayerstat("perk_immune_cuav_kills", 1);
    }
  }
  activeuavvictim = 0;
  if(level.teambased) {
    if(level.activeuavs[victim.team] > 0) {
      activeuavvictim = 1;
    }
  } else {
    activeuavvictim = isDefined(level.activeuavs[victim.entnum]) && level.activeuavs[victim.entnum] > 0;
  }
  if(activeuavvictim == 1) {
    if(player hasperk("specialty_gpsjammer")) {
      player addplayerstat("perk_gpsjammer_immune_kills", 1);
    }
  }
  if((player.lastweaponchange + 5000) > time) {
    if(player hasperk("specialty_fastweaponswitch")) {
      player addplayerstat("perk_fastweaponswitch_kill_after_swap", 1);
    }
  }
  if(player.scavenged == 1) {
    if(player hasperk("specialty_scavenger")) {
      player addplayerstat("perk_scavenger_kills_after_resupply", 1);
    }
  }
}

function flakjacketprotected(weapon, attacker) {
  if(weapon.name == "claymore") {
    self.flakjacketclaymore[attacker.clientid] = 1;
  }
  self addplayerstat("survive_with_flak", 1);
  self.challenge_lastsurvivewithflakfrom = attacker;
  self.challenge_lastsurvivewithflaktime = gettime();
}

function earnedkillstreak() {
  if(self util::has_purchased_perk_equipped("specialty_anteup")) {
    self addplayerstat("earn_scorestreak_anteup", 1);
    if(!isDefined(self.challenge_anteup_earned)) {
      self.challenge_anteup_earned = 0;
    }
    self.challenge_anteup_earned++;
    if(self.challenge_anteup_earned >= 5) {
      self addplayerstat("earn_5_scorestreaks_anteup", 1);
      self.challenge_anteup_earned = 0;
    }
  }
}

function genericbulletkill(data, victim, weapon) {
  player = self;
  time = data.time;
  if(player.pers["lastBulletKillTime"] == time) {
    player.pers["bulletStreak"]++;
  } else {
    player.pers["bulletStreak"] = 1;
  }
  player.pers["lastBulletKillTime"] = time;
  if(data.victim.idflagstime == time) {
    if(data.victim.idflags & 8) {
      player addplayerstat("kill_enemy_through_wall", 1);
      if(isDefined(weapon) && weaponhasattachment(weapon, "fmj")) {
        player addplayerstat("kill_enemy_through_wall_with_fmj", 1);
      }
    }
  }
}

function ishighestscoringplayer(player) {
  if(!isDefined(player.score) || player.score < 1) {
    return false;
  }
  players = level.players;
  if(level.teambased) {
    team = player.pers["team"];
  } else {
    team = "all";
  }
  highscore = player.score;
  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i].score)) {
      continue;
    }
    if(players[i] == player) {
      continue;
    }
    if(players[i].score < 1) {
      continue;
    }
    if(team != "all" && players[i].pers["team"] != team) {
      continue;
    }
    if(players[i].score >= highscore) {
      return false;
    }
  }
  return true;
}

function spawnwatcher() {
  self endon("disconnect");
  self endon("killspawnmonitor");
  self.pers["stickExplosiveKill"] = 0;
  self.pers["pistolHeadshot"] = 0;
  self.pers["assaultRifleHeadshot"] = 0;
  self.pers["killNemesis"] = 0;
  while(true) {
    self waittill("spawned_player");
    self.pers["longshotsPerLife"] = 0;
    self.flakjacketclaymore = [];
    self.weaponkills = [];
    self.attachmentkills = [];
    self.retreivedblades = 0;
    self.lastreloadtime = 0;
    self.crossbowclipkillcount = 0;
    self thread watchfordtp();
    self thread watchformantle();
    self thread monitor_player_sprint();
  }
}

function watchfordtp() {
  self endon("disconnect");
  self endon("death");
  self endon("killdtpmonitor");
  self.dtptime = 0;
  while(true) {
    self waittill("dtp_end");
    self.dtptime = gettime() + 4000;
  }
}

function watchformantle() {
  self endon("disconnect");
  self endon("death");
  self endon("killmantlemonitor");
  self.mantletime = 0;
  while(true) {
    self waittill("mantle_start", mantleendtime);
    self.mantletime = mantleendtime;
  }
}

function disarmedhackedcarepackage() {
  self addplayerstat("disarm_hacked_carepackage", 1);
}

function destroyed_car() {
  if(!isDefined(self) || !isplayer(self)) {
    return;
  }
  self addplayerstat("destroy_car", 1);
}

function killednemesis() {
  self.pers["killNemesis"]++;
  if(self.pers["killNemesis"] >= 5) {
    self.pers["killNemesis"] = 0;
    self addplayerstat("kill_nemesis", 1);
  }
}

function killwhiledamagingwithhpm() {
  self addplayerstat("kill_while_damaging_with_microwave_turret", 1);
}

function longdistancehatchetkill() {
  self addplayerstat("long_distance_hatchet_kill", 1);
}

function blockedsatellite() {
  self addplayerstat("activate_cuav_while_enemy_satelite_active", 1);
}

function longdistancekill() {
  self.pers["longshotsPerLife"]++;
  if(self.pers["longshotsPerLife"] >= 3) {
    self.pers["longshotsPerLife"] = 0;
    self addplayerstat("longshot_3_onelife", 1);
  }
}

function challengeroundend(data) {
  player = data.player;
  winner = data.winner;
  if(endedearly(winner)) {
    return;
  }
  if(level.teambased) {
    winnerscore = game["teamScores"][winner];
    loserscore = getlosersteamscores(winner);
  }
  switch (level.gametype) {
    case "sd": {
      if(player.team == winner) {
        if(game["challenge"][winner]["allAlive"]) {
          player addgametypestat("round_win_no_deaths", 1);
        }
        if(isDefined(player.lastmansddefeat3enemies)) {
          player addgametypestat("last_man_defeat_3_enemies", 1);
        }
      }
      break;
    }
    default: {
      break;
    }
  }
}

function roundend(winner) {
  wait(0.05);
  data = spawnStruct();
  data.time = gettime();
  if(level.teambased) {
    if(isDefined(winner) && isDefined(level.teams[winner])) {
      data.winner = winner;
    }
  } else if(isDefined(winner)) {
    data.winner = winner;
  }
  for(index = 0; index < level.placement["all"].size; index++) {
    data.player = level.placement["all"][index];
    if(isDefined(data.player)) {
      data.place = index;
      dochallengecallback("roundEnd", data);
    }
  }
}

function gameend(winner) {
  wait(0.05);
  data = spawnStruct();
  data.time = gettime();
  if(level.teambased) {
    if(isDefined(winner) && isDefined(level.teams[winner])) {
      data.winner = winner;
    }
  } else if(isDefined(winner) && isplayer(winner)) {
    data.winner = winner;
  }
  for(index = 0; index < level.placement["all"].size; index++) {
    data.player = level.placement["all"][index];
    data.place = index;
    if(isDefined(data.player)) {
      dochallengecallback("gameEnd", data);
    }
    data.player.completedgame = 1;
  }
  for(index = 0; index < level.players.size; index++) {
    if(!isDefined(level.players[index].completedgame) || level.players[index].completedgame != 1) {
      scoreevents::processscoreevent("completed_match", level.players[index]);
    }
  }
}

function getfinalkill(player) {
  if(isplayer(player)) {
    player addplayerstat("get_final_kill", 1);
  }
}

function destroyrcbomb(weapon) {
  if(!isplayer(self)) {
    return;
  }
  self destroyscorestreak(weapon, 1, 1);
  if(weapon.rootweapon.name == "hatchet") {
    self addplayerstat("destroy_hcxd_with_hatchet", 1);
  }
}

function capturedcrate(owner) {
  if(isDefined(self.lastrescuedby) && isDefined(self.lastrescuedtime)) {
    if((self.lastrescuedtime + 5000) > gettime()) {
      self.lastrescuedby addplayerstat("defend_teammate_who_captured_package", 1);
    }
  }
  if(owner != self && (level.teambased && owner.team != self.team || !level.teambased)) {
    self addplayerstat("capture_enemy_carepackage", 1);
  }
}

function destroyscorestreak(weapon, playercontrolled, groundbased, countaskillstreakvehicle = 1) {
  if(!isplayer(self)) {
    return;
  }
  if(isDefined(level.killstreakweapons[weapon])) {
    if(level.killstreakweapons[weapon] == "dart") {
      self addplayerstat("destroy_scorestreak_with_dart", 1);
    }
  } else {
    if(isDefined(weapon.isheroweapon) && weapon.isheroweapon == 1) {
      self addplayerstat("destroy_scorestreak_with_specialist", 1);
    } else if(weaponhasattachment(weapon, "fmj", "rf")) {
      self addplayerstat("destroy_scorestreak_rapidfire_fmj", 1);
    }
  }
  if(!isDefined(playercontrolled) || playercontrolled == 0) {
    if(self util::has_cold_blooded_perk_purchased_and_equipped()) {
      if(groundbased) {
        self addplayerstat("destroy_ai_scorestreak_coldblooded", 1);
      }
      if(self util::has_blind_eye_perk_purchased_and_equipped()) {
        if(groundbased) {
          self.pers["challenge_destroyed_ground"]++;
        } else {
          self.pers["challenge_destroyed_air"]++;
        }
        if(self.pers["challenge_destroyed_ground"] > 0 && self.pers["challenge_destroyed_air"] > 0) {
          self addplayerstat("destroy_air_and_ground_blindeye_coldblooded", 1);
          self.pers["challenge_destroyed_air"] = 0;
          self.pers["challenge_destroyed_ground"] = 0;
        }
      }
    }
  }
  if(!isDefined(self.pers["challenge_destroyed_killstreak"])) {
    self.pers["challenge_destroyed_killstreak"] = 0;
  }
  self.pers["challenge_destroyed_killstreak"]++;
  if(self.pers["challenge_destroyed_killstreak"] >= 5) {
    self.pers["challenge_destroyed_killstreak"] = 0;
    self addweaponstat(weapon, "destroy_5_killstreak", 1);
    self addweaponstat(weapon, "destroy_5_killstreak_vehicle", 1);
  }
  self addweaponstat(weapon, "destroy_killstreak", 1);
  weaponpickedup = 0;
  if(isDefined(self.pickedupweapons) && isDefined(self.pickedupweapons[weapon])) {
    weaponpickedup = 1;
  }
  self addweaponstat(weapon, "destroyed", 1, self.class_num, weaponpickedup, undefined, self.primaryloadoutgunsmithvariantindex, self.secondaryloadoutgunsmithvariantindex);
  self thread watchforrapiddestroy(weapon);
}

function watchforrapiddestroy(weapon) {
  self endon("disconnect");
  if(!isDefined(self.challenge_previousdestroyweapon) || self.challenge_previousdestroyweapon != weapon) {
    self.challenge_previousdestroyweapon = weapon;
    self.challenge_previousdestroycount = 0;
  } else {
    self.challenge_previousdestroycount++;
  }
  self waittilltimeoutordeath(4);
  if(self.challenge_previousdestroycount > 1) {
    self addweaponstat(weapon, "destroy_2_killstreaks_rapidly", 1);
  }
}

function capturedobjective(capturetime, objective) {
  if(isDefined(self.smokegrenadetime) && isDefined(self.smokegrenadeposition)) {
    if((self.smokegrenadetime + 14000) > capturetime) {
      distsq = distancesquared(self.smokegrenadeposition, self.origin);
      if(distsq < 57600) {
        if(self util::is_item_purchased("willy_pete")) {
          self addplayerstat("capture_objective_in_smoke", 1);
        }
        self addweaponstat(getweapon("willy_pete"), "CombatRecordStat", 1);
      }
    }
  } else {
    if(isDefined(level.capturedobjectivefunction)) {
      self[[level.capturedobjectivefunction]]();
    }
    heroabilitywasactiverecently = isDefined(self.heroabilityactive) || (isDefined(self.heroabilitydectivatetime) && self.heroabilitydectivatetime > (gettime() - 3000));
    if(heroabilitywasactiverecently && isDefined(self.heroability) && self.heroability.name == "gadget_camo") {
      scoreevents::processscoreevent("optic_camo_capture_objective", self);
    }
    if(isDefined(objective)) {
      if(self.challenge_objectivedefensive === objective) {
        if((isDefined(self.challenge_objectivedefensivekillcount) ? self.challenge_objectivedefensivekillcount : 0) > 0 && ((isDefined(self.recentkillcount) ? self.recentkillcount : 0) > 2 || self.challenge_objectivedefensivetriplekillmedalorbetterearned === 1)) {
          self addplayerstat("triple_kill_defenders_and_capture", 1);
        }
        self.challenge_objectivedefensivekillcount = 0;
        self.challenge_objectivedefensive = undefined;
        self.challenge_objectivedefensivetriplekillmedalorbetterearned = undefined;
      }
    }
  }
}

function hackedordestroyedequipment() {
  if(self util::has_hacker_perk_purchased_and_equipped()) {
    self addplayerstat("perk_hacker_destroy", 1);
  }
}

function bladekill() {
  if(!isDefined(self.pers["bladeKills"])) {
    self.pers["bladeKills"] = 0;
  }
  self.pers["bladeKills"]++;
  if(self.pers["bladeKills"] >= 15) {
    self.pers["bladeKills"] = 0;
    self addplayerstat("kill_15_with_blade", 1);
  }
}

function destroyedexplosive(weapon) {
  self destroyedequipment(weapon);
  self addplayerstat("destroy_explosive", 1);
}

function assisted() {
  self addplayerstat("assist", 1);
}

function earnedmicrowaveassistscore(score) {
  self addplayerstat("assist_score_microwave_turret", score);
  self addplayerstat("assist_score_killstreak", score);
  self addweaponstat(getweapon("microwave_turret_deploy"), "assists", 1);
  self addweaponstat(getweapon("microwave_turret_deploy"), "assist_score", score);
}

function earnedcuavassistscore(score) {
  self addplayerstat("assist_score_cuav", score);
  self addplayerstat("assist_score_killstreak", score);
  self addweaponstat(getweapon("counteruav"), "assists", 1);
  self addweaponstat(getweapon("counteruav"), "assist_score", score);
}

function earneduavassistscore(score) {
  self addplayerstat("assist_score_uav", score);
  self addplayerstat("assist_score_killstreak", score);
  self addweaponstat(getweapon("uav"), "assists", 1);
  self addweaponstat(getweapon("uav"), "assist_score", score);
}

function earnedsatelliteassistscore(score) {
  self addplayerstat("assist_score_satellite", score);
  self addplayerstat("assist_score_killstreak", score);
  self addweaponstat(getweapon("satellite"), "assists", 1);
  self addweaponstat(getweapon("satellite"), "assist_score", score);
}

function earnedempassistscore(score) {
  self addplayerstat("assist_score_emp", score);
  self addplayerstat("assist_score_killstreak", score);
  self addweaponstat(getweapon("emp_turret"), "assists", 1);
  self addweaponstat(getweapon("emp_turret"), "assist_score", score);
}

function teamcompletedchallenge(team, challenge) {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i].team) && players[i].team == team) {
      players[i] addgametypestat(challenge, 1);
    }
  }
}

function endedearly(winner) {
  if(level.hostforcedend) {
    return true;
  }
  if(!isDefined(winner)) {
    return true;
  }
  if(level.teambased) {
    if(winner == "tie") {
      return true;
    }
  }
  return false;
}

function getlosersteamscores(winner) {
  teamscores = 0;
  foreach(team in level.teams) {
    if(team == winner) {
      continue;
    }
    teamscores = teamscores + game["teamScores"][team];
  }
  return teamscores;
}

function didloserfailchallenge(winner, challenge) {
  foreach(team in level.teams) {
    if(team == winner) {
      continue;
    }
    if(game["challenge"][team][challenge]) {
      return false;
    }
  }
  return true;
}

function challengegameend(data) {
  player = data.player;
  winner = data.winner;
  if(endedearly(winner)) {
    return;
  }
  if(level.teambased) {
    winnerscore = game["teamScores"][winner];
    loserscore = getlosersteamscores(winner);
  }
  switch (level.gametype) {
    case "tdm": {
      if(player.team == winner) {
        if(winnerscore >= (loserscore + 20)) {
          player addgametypestat("CRUSH", 1);
        }
      }
      mostkillsleastdeaths = 1;
      for(index = 0; index < level.placement["all"].size; index++) {
        if(level.placement["all"][index].deaths < player.deaths) {
          mostkillsleastdeaths = 0;
        }
        if(level.placement["all"][index].kills > player.kills) {
          mostkillsleastdeaths = 0;
        }
      }
      if(mostkillsleastdeaths && player.kills > 0 && level.placement["all"].size > 3) {
        player addgametypestat("most_kills_least_deaths", 1);
      }
      break;
    }
    case "dm": {
      if(player == winner) {
        if(level.placement["all"].size >= 2) {
          secondplace = level.placement["all"][1];
          if(player.kills >= (secondplace.kills + 7)) {
            player addgametypestat("CRUSH", 1);
          }
        }
      }
      break;
    }
    case "ctf": {
      if(player.team == winner) {
        if(loserscore == 0) {
          player addgametypestat("SHUT_OUT", 1);
        }
      }
      break;
    }
    case "dom": {
      if(player.team == winner) {
        if(winnerscore >= (loserscore + 70)) {
          player addgametypestat("CRUSH", 1);
        }
      }
      break;
    }
    case "hq": {
      if(player.team == winner && winnerscore > 0) {
        if(winnerscore >= (loserscore + 70)) {
          player addgametypestat("CRUSH", 1);
        }
      }
      break;
    }
    case "koth": {
      if(player.team == winner && winnerscore > 0) {
        if(winnerscore >= (loserscore + 70)) {
          player addgametypestat("CRUSH", 1);
        }
      }
      if(player.team == winner && winnerscore > 0) {
        if(winnerscore >= (loserscore + 110)) {
          player addgametypestat("ANNIHILATION", 1);
        }
      }
      break;
    }
    case "dem": {
      if(player.team == game["defenders"] && player.team == winner) {
        if(loserscore == 0) {
          player addgametypestat("SHUT_OUT", 1);
        }
      }
      break;
    }
    case "sd": {
      if(player.team == winner) {
        if(loserscore <= 1) {
          player addgametypestat("CRUSH", 1);
        }
      }
    }
    default: {
      break;
    }
  }
}

function multikill(killcount, weapon) {
  if(killcount >= 3 && isDefined(self.lastkillwheninjured)) {
    if((self.lastkillwheninjured + 5000) > gettime()) {
      self addplayerstat("multikill_3_near_death", 1);
    }
  }
  self addweaponstat(weapon, "doublekill", int(killcount / 2));
  self addweaponstat(weapon, "triplekill", int(killcount / 3));
  if(weapon.isheroweapon) {
    doublekill = int(killcount / 2);
    if(doublekill) {
      self addplayerstat("MULTIKILL_2_WITH_HEROWEAPON", doublekill);
    }
    triplekill = int(killcount / 3);
    if(triplekill) {
      self addplayerstat("MULTIKILL_3_WITH_HEROWEAPON", triplekill);
    }
  }
}

function domattackermultikill(killcount) {
  self addgametypestat("kill_2_enemies_capturing_your_objective", 1);
}

function totaldomination(team) {
  teamcompletedchallenge(team, "control_3_points_3_minutes");
}

function holdflagentirematch(team, label) {
  switch (label) {
    case "_a": {
      event = "hold_a_entire_match";
      break;
    }
    case "_b": {
      event = "hold_b_entire_match";
      break;
    }
    case "_c": {
      event = "hold_c_entire_match";
      break;
    }
    default: {
      return;
    }
  }
  teamcompletedchallenge(team, event);
}

function capturedbfirstminute() {
  self addgametypestat("capture_b_first_minute", 1);
}

function controlzoneentirely(team) {
  teamcompletedchallenge(team, "control_zone_entirely");
}

function multi_lmg_smg_kill() {
  self addplayerstat("multikill_3_lmg_or_smg_hip_fire", 1);
}

function killedzoneattacker(weapon) {
  if(weapon.name == "planemortar" || weapon.name == "remote_missile_missile" || weapon.name == "remote_missile_bomblet") {
    self thread updatezonemultikills();
  }
}

function killeddog() {
  origin = self.origin;
  if(level.teambased) {
    teammates = util::get_team_alive_players_s(self.team);
    foreach(player in teammates.a) {
      if(player == self) {
        continue;
      }
      distsq = distancesquared(origin, player.origin);
      if(distsq < 57600) {
        self addplayerstat("killed_dog_close_to_teammate", 1);
        break;
      }
    }
  }
}

function updatezonemultikills() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updaterecentzonekills");
  self endon("updaterecentzonekills");
  if(!isDefined(self.recentzonekillcount)) {
    self.recentzonekillcount = 0;
  }
  self.recentzonekillcount++;
  wait(4);
  if(self.recentzonekillcount > 1) {
    self addplayerstat("multikill_2_zone_attackers", 1);
  }
  self.recentzonekillcount = 0;
}

function multi_rcbomb_kill() {
  self addplayerstat("multikill_2_with_rcbomb", 1);
}

function multi_remotemissile_kill() {
  self addplayerstat("multikill_3_remote_missile", 1);
}

function multi_mgl_kill() {
  self addplayerstat("multikill_3_with_mgl", 1);
}

function immediatecapture() {
  self addgametypestat("immediate_capture", 1);
}

function killedlastcontester() {
  self addgametypestat("contest_then_capture", 1);
}

function bothbombsdetonatewithintime() {
  self addgametypestat("both_bombs_detonate_10_seconds", 1);
}

function calledincarepackage() {
  self.pers["carepackagesCalled"]++;
  if(self.pers["carepackagesCalled"] >= 3) {
    self addplayerstat("call_in_3_care_packages", 1);
    self.pers["carepackagesCalled"] = 0;
  }
}

function destroyedhelicopter(attacker, weapon, damagetype, playercontrolled) {
  if(!isplayer(attacker)) {
    return;
  }
  attacker destroyscorestreak(weapon, playercontrolled, 0);
  if(damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET") {
    attacker addplayerstat("destroyed_helicopter_with_bullet", 1);
  }
}

function destroyedqrdrone(damagetype, weapon) {
  self destroyscorestreak(weapon, 1, 0);
  self addplayerstat("destroy_qrdrone", 1);
  if(damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET") {
    self addplayerstat("destroyed_qrdrone_with_bullet", 1);
  }
  self destroyedplayercontrolledaircraft();
}

function destroyedplayercontrolledaircraft() {
  if(self hasperk("specialty_noname")) {
    self addplayerstat("destroy_helicopter", 1);
  }
}

function destroyedaircraft(attacker, weapon, playercontrolled) {
  if(!isplayer(attacker)) {
    return;
  }
  attacker destroyscorestreak(weapon, playercontrolled, 0);
  if(isDefined(weapon)) {
    if(weapon.name == "emp" && attacker util::is_item_purchased("killstreak_emp")) {
      attacker addplayerstat("destroy_aircraft_with_emp", 1);
    } else {
      if(weapon.name == "missile_drone_projectile" || weapon.name == "missile_drone") {
        attacker addplayerstat("destroy_aircraft_with_missile_drone", 1);
      } else if(weapon.isbulletweapon) {
        attacker addplayerstat("shoot_aircraft", 1);
      }
    }
  }
  if(attacker util::has_blind_eye_perk_purchased_and_equipped()) {
    attacker addplayerstat("perk_nottargetedbyairsupport_destroy_aircraft", 1);
  }
  attacker addplayerstat("destroy_aircraft", 1);
  if(isDefined(playercontrolled) && playercontrolled == 0) {
    if(attacker util::has_blind_eye_perk_purchased_and_equipped()) {
      attacker addplayerstat("destroy_ai_aircraft_using_blindeye", 1);
    }
  }
}

function killstreakten() {
  if(!isDefined(self.class_num)) {
    return;
  }
  primary = self getloadoutitem(self.class_num, "primary");
  if(primary != 0) {
    return;
  }
  secondary = self getloadoutitem(self.class_num, "secondary");
  if(secondary != 0) {
    return;
  }
  primarygrenade = self getloadoutitem(self.class_num, "primarygrenade");
  if(primarygrenade != 0) {
    return;
  }
  specialgrenade = self getloadoutitem(self.class_num, "specialgrenade");
  if(specialgrenade != 0) {
    return;
  }
  for(numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
    perk = self getloadoutitem(self.class_num, "specialty" + (numspecialties + 1));
    if(perk != 0) {
      return;
    }
  }
  self addplayerstat("killstreak_10_no_weapons_perks", 1);
}

function scavengedgrenade() {
  self endon("disconnect");
  self endon("death");
  self notify("scavengedgrenade");
  self endon("scavengedgrenade");
  self notify("scavenged_primary_grenade");
  for(;;) {
    self waittill("lethalgrenadekill");
    self addplayerstat("kill_with_resupplied_lethal_grenade", 1);
  }
}

function stunnedtankwithempgrenade(attacker) {
  attacker addplayerstat("stun_aitank_wIth_emp_grenade", 1);
}

function playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance, bledout) {
  print(level.gametype);
  self.anglesondeath = self getplayerangles();
  if(isDefined(attacker)) {
    attacker.anglesonkill = attacker getplayerangles();
  }
  if(!isDefined(weapon)) {
    weapon = level.weaponnone;
  }
  self endon("disconnect");
  data = spawnStruct();
  data.victim = self;
  data.victimorigin = self.origin;
  data.victimstance = self getstance();
  data.einflictor = einflictor;
  data.attacker = attacker;
  data.attackerstance = attackerstance;
  data.idamage = idamage;
  data.smeansofdeath = smeansofdeath;
  data.weapon = weapon;
  data.shitloc = shitloc;
  data.time = gettime();
  data.bledout = 0;
  if(isDefined(bledout)) {
    data.bledout = bledout;
  }
  if(isDefined(einflictor) && isDefined(einflictor.lastweaponbeforetoss)) {
    data.lastweaponbeforetoss = einflictor.lastweaponbeforetoss;
  }
  if(isDefined(einflictor) && isDefined(einflictor.ownerweaponatlaunch)) {
    data.ownerweaponatlaunch = einflictor.ownerweaponatlaunch;
  }
  waslockingon = 0;
  washacked = 0;
  if(isDefined(einflictor)) {
    if(isDefined(einflictor.locking_on)) {
      waslockingon = waslockingon | einflictor.locking_on;
    }
    if(isDefined(einflictor.locked_on)) {
      waslockingon = waslockingon | einflictor.locked_on;
    }
    washacked = einflictor util::ishacked();
  }
  waslockingon = waslockingon & (1 << data.victim.entnum);
  if(waslockingon != 0) {
    data.waslockingon = 1;
  } else {
    data.waslockingon = 0;
  }
  data.washacked = washacked;
  data.wasplanting = data.victim.isplanting;
  data.wasunderwater = data.victim isplayerunderwater();
  if(!isDefined(data.wasplanting)) {
    data.wasplanting = 0;
  }
  data.wasdefusing = data.victim.isdefusing;
  if(!isDefined(data.wasdefusing)) {
    data.wasdefusing = 0;
  }
  data.victimweapon = data.victim.currentweapon;
  data.victimonground = data.victim isonground();
  data.victimwaswallrunning = data.victim iswallrunning();
  data.victimlaststunnedby = data.victim.laststunnedby;
  data.victimwasdoublejumping = data.victim isdoublejumping();
  data.victimcombatefficiencylastontime = data.victim.combatefficiencylastontime;
  data.victimspeedburstlastontime = data.victim.speedburstlastontime;
  data.victimcombatefficieny = data.victim ability_util::gadget_is_active(15);
  data.victimflashbacktime = data.victim.flashbacktime;
  data.victimheroabilityactive = ability_player::gadget_checkheroabilitykill(data.victim);
  data.victimelectrifiedby = data.victim.electrifiedby;
  data.victimheroability = data.victim.heroability;
  data.victimwasinslamstate = data.victim isslamming();
  data.victimwaslungingwitharmblades = data.victim isgadgetmeleecharging();
  data.victimwasheatwavestunned = data.victim isheatwavestunned();
  data.victimpowerarmorlasttookdamagetime = data.victim.power_armor_last_took_damage_time;
  data.victimheroweaponkillsthisactivation = data.victim.heroweaponkillsthisactivation;
  data.victimgadgetpower = data.victim gadgetpowerget(0);
  data.victimgadgetwasactivelastdamage = data.victim.gadget_was_active_last_damage;
  data.victimisthieforroulette = data.victim.isthief === 1 || data.victim.isroulette === 1;
  data.victimheroabilityname = data.victim.heroabilityname;
  if(!isDefined(data.victimflashbacktime)) {
    data.victimflashbacktime = 0;
  }
  if(!isDefined(data.victimcombatefficiencylastontime)) {
    data.victimcombatefficiencylastontime = 0;
  }
  if(!isDefined(data.victimspeedburstlastontime)) {
    data.victimspeedburstlastontime = 0;
  }
  data.victimvisionpulseactivatetime = data.victim.visionpulseactivatetime;
  if(!isDefined(data.victimvisionpulseactivatetime)) {
    data.victimvisionpulseactivatetime = 0;
  }
  data.victimvisionpulsearray = util::array_copy_if_array(data.victim.visionpulsearray);
  data.victimvisionpulseorigin = data.victim.visionpulseorigin;
  data.victimvisionpulseoriginarray = util::array_copy_if_array(data.victim.visionpulseoriginarray);
  data.victimattackersthisspawn = util::array_copy_if_array(data.victim.attackersthisspawn);
  data.victim_doublejump_begin = data.victim.challenge_doublejump_begin;
  data.victim_doublejump_end = data.victim.challenge_doublejump_end;
  data.victim_jump_begin = data.victim.challenge_jump_begin;
  data.victim_jump_end = data.victim.challenge_jump_end;
  data.victim_swimming_begin = data.victim.challenge_swimming_begin;
  data.victim_swimming_end = data.victim.challenge_swimming_end;
  data.victim_slide_begin = data.victim.challenge_slide_begin;
  data.victim_slide_end = data.victim.challenge_slide_end;
  data.victim_wallrun_begin = data.victim.challenge_wallrun_begin;
  data.victim_wallrun_end = data.victim.challenge_wallrun_end;
  data.victim_was_drowning = data.victim drown::is_player_drowning();
  if(isDefined(data.victim.activeproximitygrenades)) {
    data.victimactiveproximitygrenades = [];
    arrayremovevalue(data.victim.activeproximitygrenades, undefined);
    foreach(proximitygrenade in data.victim.activeproximitygrenades) {
      proximitygrenadeinfo = spawnStruct();
      proximitygrenadeinfo.origin = proximitygrenade.origin;
      data.victimactiveproximitygrenades[data.victimactiveproximitygrenades.size] = proximitygrenadeinfo;
    }
  }
  if(isDefined(data.victim.activebouncingbetties)) {
    data.victimactivebouncingbetties = [];
    arrayremovevalue(data.victim.activebouncingbetties, undefined);
    foreach(bouncingbetty in data.victim.activebouncingbetties) {
      bouncingbettyinfo = spawnStruct();
      bouncingbettyinfo.origin = bouncingbetty.origin;
      data.victimactivebouncingbetties[data.victimactivebouncingbetties.size] = bouncingbettyinfo;
    }
  }
  if(isplayer(attacker)) {
    data.attackerorigin = data.attacker.origin;
    data.attackeronground = data.attacker isonground();
    data.attackerwallrunning = data.attacker iswallrunning();
    data.attackerdoublejumping = data.attacker isdoublejumping();
    data.attackertraversing = data.attacker istraversing();
    data.attackersliding = data.attacker issliding();
    data.attackerspeedburst = data.attacker ability_util::gadget_is_active(13);
    data.attackerflashbacktime = data.attacker.flashbacktime;
    data.attackerheroabilityactive = ability_player::gadget_checkheroabilitykill(data.attacker);
    data.attackerheroability = data.attacker.heroability;
    if(!isDefined(data.attackerflashbacktime)) {
      data.attackerflashbacktime = 0;
    }
    data.attackervisionpulseactivatetime = attacker.visionpulseactivatetime;
    if(!isDefined(data.attackervisionpulseactivatetime)) {
      data.attackervisionpulseactivatetime = 0;
    }
    data.attackervisionpulsearray = util::array_copy_if_array(attacker.visionpulsearray);
    data.attackervisionpulseorigin = attacker.visionpulseorigin;
    if(!isDefined(data.attackerstance)) {
      data.attackerstance = data.attacker getstance();
    }
    data.attackervisionpulseoriginarray = util::array_copy_if_array(attacker.visionpulseoriginarray);
    data.attackerwasflashed = data.attacker isflashbanged();
    data.attackerlastflashedby = data.attacker.lastflashedby;
    data.attackerlaststunnedby = data.attacker.laststunnedby;
    data.attackerlaststunnedtime = data.attacker.laststunnedtime;
    data.attackerwasconcussed = isDefined(data.attacker.concussionendtime) && data.attacker.concussionendtime > gettime();
    data.attackerwasheatwavestunned = data.attacker isheatwavestunned();
    data.attackerwasunderwater = data.attacker isplayerunderwater();
    data.attackerlastfastreloadtime = data.attacker.lastfastreloadtime;
    data.attackerwassliding = data.attacker issliding();
    data.attackerwassprinting = data.attacker issprinting();
    data.attackeristhief = attacker.isthief === 1;
    data.attackerisroulette = attacker.isroulette === 1;
    data.attacker_doublejump_begin = data.attacker.challenge_doublejump_begin;
    data.attacker_doublejump_end = data.attacker.challenge_doublejump_end;
    data.attacker_jump_begin = data.attacker.challenge_jump_begin;
    data.attacker_jump_end = data.attacker.challenge_jump_end;
    data.attacker_swimming_begin = data.attacker.challenge_swimming_begin;
    data.attacker_swimming_end = data.attacker.challenge_swimming_end;
    data.attacker_slide_begin = data.attacker.challenge_slide_begin;
    data.attacker_slide_end = data.attacker.challenge_slide_end;
    data.attacker_wallrun_begin = data.attacker.challenge_wallrun_begin;
    data.attacker_wallrun_end = data.attacker.challenge_wallrun_end;
    data.attacker_was_drowning = data.attacker drown::is_player_drowning();
    data.attacker_sprint_begin = data.attacker.challenge_sprint_begin;
    data.attacker_sprint_end = data.attacker.challenge_sprint_end;
    data.attacker_wallrantwooppositewallsnoground = data.attacker.wallrantwooppositewallsnoground;
    if(level.allow_vehicle_challenge_check === 1 && attacker isinvehicle()) {
      vehicle = attacker getvehicleoccupied();
      if(isDefined(vehicle)) {
        data.attackerinvehiclearchetype = vehicle.archetype;
      }
    }
  } else {
    data.attackeronground = 0;
    data.attackerwallrunning = 0;
    data.attackerdoublejumping = 0;
    data.attackertraversing = 0;
    data.attackersliding = 0;
    data.attackerspeedburst = 0;
    data.attackerflashbacktime = 0;
    data.attackervisionpulseactivatetime = 0;
    data.attackerwasflashed = 0;
    data.attackerwasconcussed = 0;
    data.attackerheroabilityactive = 0;
    data.attackerwasheatwavestunned = 0;
    data.attackerstance = "stand";
    data.attackerwasunderwater = 0;
    data.attackerwassprinting = 0;
    data.attackeristhief = 0;
    data.attackerisroulette = 0;
  }
  if(isDefined(einflictor)) {
    if(isDefined(einflictor.iscooked)) {
      data.inflictoriscooked = einflictor.iscooked;
    } else {
      data.inflictoriscooked = 0;
    }
    if(isDefined(einflictor.challenge_hatchettosscount)) {
      data.inflictorchallenge_hatchettosscount = einflictor.challenge_hatchettosscount;
    } else {
      data.inflictorchallenge_hatchettosscount = 0;
    }
    if(isDefined(einflictor.ownerwassprinting)) {
      data.inflictorownerwassprinting = einflictor.ownerwassprinting;
    } else {
      data.inflictorownerwassprinting = 0;
    }
    if(isDefined(einflictor.playerhasengineerperk)) {
      data.inflictorplayerhasengineerperk = einflictor.playerhasengineerperk;
    } else {
      data.inflictorplayerhasengineerperk = 0;
    }
  } else {
    data.inflictoriscooked = 0;
    data.inflictorchallenge_hatchettosscount = 0;
    data.inflictorownerwassprinting = 0;
    data.inflictorplayerhasengineerperk = 0;
  }
  waitandprocessplayerkilledcallback(data);
  data.attacker notify("playerkilledchallengesprocessed");
}

function doscoreeventcallback(callback, data) {
  if(!isDefined(level.scoreeventcallbacks)) {
    return;
  }
  if(!isDefined(level.scoreeventcallbacks[callback])) {
    return;
  }
  if(isDefined(data)) {
    for(i = 0; i < level.scoreeventcallbacks[callback].size; i++) {
      thread[[level.scoreeventcallbacks[callback][i]]](data);
    }
  } else {
    for(i = 0; i < level.scoreeventcallbacks[callback].size; i++) {
      thread[[level.scoreeventcallbacks[callback][i]]]();
    }
  }
}

function waitandprocessplayerkilledcallback(data) {
  if(isDefined(data.attacker)) {
    data.attacker endon("disconnect");
  }
  wait(0.05);
  util::waittillslowprocessallowed();
  level thread dochallengecallback("playerKilled", data);
  level thread doscoreeventcallback("playerKilled", data);
}

function weaponisknife(weapon) {
  if(weapon == level.weaponbasemelee || weapon == level.weaponbasemeleeheld || weapon == level.weaponballisticknife) {
    return true;
  }
  return false;
}

function eventreceived(eventname) {
  self endon("disconnect");
  util::waittillslowprocessallowed();
  switch (level.gametype) {
    case "tdm": {
      if(eventname == "killstreak_10") {
        self addgametypestat("killstreak_10", 1);
      } else {
        if(eventname == "killstreak_15") {
          self addgametypestat("killstreak_15", 1);
        } else {
          if(eventname == "killstreak_20") {
            self addgametypestat("killstreak_20", 1);
          } else {
            if(eventname == "multikill_3") {
              self addgametypestat("multikill_3", 1);
            } else {
              if(eventname == "kill_enemy_who_killed_teammate") {
                self addgametypestat("kill_enemy_who_killed_teammate", 1);
              } else if(eventname == "kill_enemy_injuring_teammate") {
                self addgametypestat("kill_enemy_injuring_teammate", 1);
              }
            }
          }
        }
      }
      break;
    }
    case "dm": {
      if(eventname == "killstreak_10") {
        self addgametypestat("killstreak_10", 1);
      } else {
        if(eventname == "killstreak_15") {
          self addgametypestat("killstreak_15", 1);
        } else {
          if(eventname == "killstreak_20") {
            self addgametypestat("killstreak_20", 1);
          } else if(eventname == "killstreak_30") {
            self addgametypestat("killstreak_30", 1);
          }
        }
      }
      break;
    }
    case "sd": {
      if(eventname == "defused_bomb_last_man_alive") {
        self addgametypestat("defused_bomb_last_man_alive", 1);
      } else {
        if(eventname == "elimination_and_last_player_alive") {
          self addgametypestat("elimination_and_last_player_alive", 1);
        } else {
          if(eventname == "killed_bomb_planter") {
            self addgametypestat("killed_bomb_planter", 1);
          } else if(eventname == "killed_bomb_defuser") {
            self addgametypestat("killed_bomb_defuser", 1);
          }
        }
      }
      break;
    }
    case "ctf": {
      if(eventname == "kill_flag_carrier") {
        self addgametypestat("kill_flag_carrier", 1);
      } else if(eventname == "defend_flag_carrier") {
        self addgametypestat("defend_flag_carrier", 1);
      }
      break;
    }
    case "dem": {
      if(eventname == "killed_bomb_planter") {
        self addgametypestat("killed_bomb_planter", 1);
      } else if(eventname == "killed_bomb_defuser") {
        self addgametypestat("killed_bomb_defuser", 1);
      }
      break;
    }
    default: {
      break;
    }
  }
}

function monitor_player_sprint() {
  self endon("disconnect");
  self endon("killplayersprintmonitor");
  self endon("death");
  self.lastsprinttime = undefined;
  while(true) {
    self waittill("sprint_begin");
    self waittill("sprint_end");
    self.lastsprinttime = gettime();
  }
}

function isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

function isheatwavestunned() {
  return isDefined(self._heat_wave_stuned_end) && gettime() < self._heat_wave_stuned_end;
}

function trophy_defense(origin, radius) {
  if(isDefined(level.challenge_scorestreaksenabled) && level.challenge_scorestreaksenabled == 1) {
    entities = getdamageableentarray(origin, radius);
    foreach(entity in entities) {
      if(isDefined(entity.challenge_isscorestreak)) {
        self addplayerstat("protect_streak_with_trophy", 1);
        break;
      }
    }
  }
}

function waittilltimeoutordeath(timeout) {
  self endon("death");
  wait(timeout);
}