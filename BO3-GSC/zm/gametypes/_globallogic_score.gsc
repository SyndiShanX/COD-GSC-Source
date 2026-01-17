/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\gametypes\_globallogic_score.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\bb_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\math_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_bb;
#using scripts\zm\_challenges;
#using scripts\zm\_util;
#using scripts\zm\gametypes\_globallogic;
#using scripts\zm\gametypes\_globallogic_audio;
#using scripts\zm\gametypes\_globallogic_utils;
#namespace globallogic_score;

function gethighestscoringplayer() {
  players = level.players;
  winner = undefined;
  tie = 0;
  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i].score)) {
      continue;
    }
    if(players[i].score < 1) {
      continue;
    }
    if(!isDefined(winner) || players[i].score > winner.score) {
      winner = players[i];
      tie = 0;
      continue;
    }
    if(players[i].score == winner.score) {
      tie = 1;
    }
  }
  if(tie || !isDefined(winner)) {
    return undefined;
  }
  return winner;
}

function resetscorechain() {
  self notify("reset_score_chain");
  self.scorechain = 0;
  self.rankupdatetotal = 0;
}

function scorechaintimer() {
  self notify("score_chain_timer");
  self endon("reset_score_chain");
  self endon("score_chain_timer");
  self endon("death");
  self endon("disconnect");
  wait(20);
  self thread resetscorechain();
}

function roundtonearestfive(score) {
  rounding = score % 5;
  if(rounding <= 2) {
    return score - rounding;
  }
  return score + (5 - rounding);
}

function giveplayermomentumnotification(score, label, descvalue, countstowardrampage) {
  rampagebonus = 0;
  if(isDefined(level.usingrampage) && level.usingrampage) {
    if(countstowardrampage) {
      if(!isDefined(self.scorechain)) {
        self.scorechain = 0;
      }
      self.scorechain++;
      self thread scorechaintimer();
    }
    if(isDefined(self.scorechain) && self.scorechain >= 999) {
      rampagebonus = roundtonearestfive(int((score * level.rampagebonusscale) + 0.5));
    }
  }
  combat_efficiency_factor = 0;
  if(score != 0) {
    self luinotifyevent(&"score_event", 4, label, score, rampagebonus, combat_efficiency_factor);
  }
  score = score + rampagebonus;
  if(score > 0 && self hasperk("specialty_earnmoremomentum")) {
    score = roundtonearestfive(int((score * getdvarfloat("perk_killstreakMomentumMultiplier")) + 0.5));
  }
  _setplayermomentum(self, self.pers["momentum"] + score);
}

function resetplayermomentumondeath() {
  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks) {
    _setplayermomentum(self, 0);
    self thread resetscorechain();
  }
}

function giveplayerxpdisplay(event, player, victim, descvalue) {
  score = rank::getscoreinfovalue(event);
  assert(isDefined(score));
  xp = rank::getscoreinfoxp(event);
  assert(isDefined(xp));
  label = rank::getscoreinfolabel(event);
  if(xp && !level.gameended && isDefined(label)) {
    xpscale = player getxpscale();
    if(1 != xpscale) {
      xp = int((xp * xpscale) + 0.5);
    }
    player luinotifyevent(&"score_event", 2, label, xp);
  }
  return score;
}

function giveplayerscore(event, player, victim, descvalue, weapon) {
  return giveplayerxpdisplay(event, player, victim, descvalue);
}

function default_onplayerscore(event, player, victim) {}

function _setplayerscore(player, score) {}

function _getplayerscore(player) {
  return player.pers["score"];
}

function _setplayermomentum(player, momentum) {
  momentum = math::clamp(momentum, 0, 2000);
  oldmomentum = player.pers["momentum"];
  if(momentum == oldmomentum) {
    return;
  }
  player bb::add_to_stat("momentum", momentum - oldmomentum);
  if(momentum > oldmomentum) {
    highestmomentumcost = 0;
    numkillstreaks = player.killstreak.size;
    killstreaktypearray = [];
  }
  player.pers["momentum"] = momentum;
  player.momentum = player.pers["momentum"];
}

function _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray) {}

function setplayermomentumdebug() {
  setdvar("", 0);
  while(true) {
    wait(1);
    momentumpercent = getdvarfloat("", 0);
    if(momentumpercent != 0) {
      player = util::gethostplayer();
      if(!isDefined(player)) {
        return;
      }
      if(isDefined(player.killstreak)) {
        _setplayermomentum(player, int(2000 * (momentumpercent / 100)));
      }
    }
  }
}

function giveteamscore(event, team, player, victim) {
  if(level.overrideteamscore) {
    return;
  }
  pixbeginevent("level.onTeamScore");
  teamscore = game["teamScores"][team];
  [[level.onteamscore]](event, team);
  pixendevent();
  newscore = game["teamScores"][team];
  bbprint("mpteamscores", "gametime %d event %s team %d diff %d score %d", gettime(), event, team, newscore - teamscore, newscore);
  if(teamscore == newscore) {
    return;
  }
  updateteamscores(team);
  thread globallogic::checkscorelimit();
}

function giveteamscoreforobjective(team, score) {
  teamscore = game["teamScores"][team];
  onteamscore(score, team);
  newscore = game["teamScores"][team];
  if(teamscore == newscore) {
    return;
  }
  updateteamscores(team);
  thread globallogic::checkscorelimit();
}

function _setteamscore(team, teamscore) {
  if(teamscore == game["teamScores"][team]) {
    return;
  }
  game["teamScores"][team] = teamscore;
  updateteamscores(team);
  thread globallogic::checkscorelimit();
}

function resetteamscores() {
  if(level.scoreroundwinbased || util::isfirstround()) {
    foreach(team in level.teams) {
      game["teamScores"][team] = 0;
    }
  }
  updateallteamscores();
}

function resetallscores() {
  resetteamscores();
  resetplayerscores();
}

function resetplayerscores() {
  players = level.players;
  winner = undefined;
  tie = 0;
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i].pers["score"])) {
      _setplayerscore(players[i], 0);
    }
  }
}

function updateteamscores(team) {
  setteamscore(team, game["teamScores"][team]);
  level thread globallogic::checkteamscorelimitsoon(team);
}

function updateallteamscores() {
  foreach(team in level.teams) {
    updateteamscores(team);
  }
}

function _getteamscore(team) {
  return game["teamScores"][team];
}

function gethighestteamscoreteam() {
  score = 0;
  winning_teams = [];
  foreach(team in level.teams) {
    team_score = game["teamScores"][team];
    if(team_score > score) {
      score = team_score;
      winning_teams = [];
    }
    if(team_score == score) {
      winning_teams[team] = team;
    }
  }
  return winning_teams;
}

function areteamarraysequal(teamsa, teamsb) {
  if(teamsa.size != teamsb.size) {
    return false;
  }
  foreach(team in teamsa) {
    if(!isDefined(teamsb[team])) {
      return false;
    }
  }
  return true;
}

function onteamscore(score, team) {
  game["teamScores"][team] = game["teamScores"][team] + score;
  if(level.scorelimit && game["teamScores"][team] > level.scorelimit) {
    game["teamScores"][team] = level.scorelimit;
  }
  if(level.splitscreen) {
    return;
  }
  if(level.scorelimit == 1) {
    return;
  }
  iswinning = gethighestteamscoreteam();
  if(iswinning.size == 0) {
    return;
  }
  if((gettime() - level.laststatustime) < 5000) {
    return;
  }
  if(areteamarraysequal(iswinning, level.waswinning)) {
    return;
  }
  level.laststatustime = gettime();
  if(iswinning.size == 1) {
    foreach(team in iswinning) {
      if(isDefined(level.waswinning[team])) {
        if(level.waswinning.size == 1) {
          continue;
        }
      }
      globallogic_audio::leaderdialog("lead_taken", team, "status");
    }
  }
  if(level.waswinning.size == 1) {
    foreach(team in level.waswinning) {
      if(isDefined(iswinning[team])) {
        if(iswinning.size == 1) {
          continue;
        }
        if(level.waswinning.size > 1) {
          continue;
        }
      }
      globallogic_audio::leaderdialog("lead_lost", team, "status");
    }
  }
  level.waswinning = iswinning;
}

function default_onteamscore(event, team) {}

function initpersstat(dataname, record_stats, init_to_stat_value) {
  if(!isDefined(self.pers[dataname])) {
    self.pers[dataname] = 0;
  }
  if(!isDefined(record_stats) || record_stats == 1) {
    recordplayerstats(self, dataname, int(self.pers[dataname]));
  }
  if(isDefined(init_to_stat_value) && init_to_stat_value == 1) {
    self.pers[dataname] = self getdstat("PlayerStatsList", dataname, "StatValue");
  }
}

function getpersstat(dataname) {
  return self.pers[dataname];
}

function incpersstat(dataname, increment, record_stats, includegametype) {
  pixbeginevent("incPersStat");
  self.pers[dataname] = self.pers[dataname] + increment;
  self addplayerstat(dataname, increment);
  if(!isDefined(record_stats) || record_stats == 1) {
    self thread threadedrecordplayerstats(dataname);
  }
  pixendevent();
}

function threadedrecordplayerstats(dataname) {
  self endon("disconnect");
  waittillframeend();
  recordplayerstats(self, dataname, self.pers[dataname]);
}

function inckillstreaktracker(weapon) {
  self endon("disconnect");
  waittillframeend();
  if(weapon.name == "artillery") {
    self.pers["artillery_kills"]++;
  }
  if(weapon.name == "dog_bite") {
    self.pers["dog_kills"]++;
  }
}

function trackattackerkill(name, rank, xp, prestige, xuid) {
  self endon("disconnect");
  attacker = self;
  waittillframeend();
  pixbeginevent("trackAttackerKill");
  if(!isDefined(attacker.pers["killed_players"][name])) {
    attacker.pers["killed_players"][name] = 0;
  }
  if(!isDefined(attacker.killedplayerscurrent[name])) {
    attacker.killedplayerscurrent[name] = 0;
  }
  if(!isDefined(attacker.pers["nemesis_tracking"][name])) {
    attacker.pers["nemesis_tracking"][name] = 0;
  }
  attacker.pers["killed_players"][name]++;
  attacker.killedplayerscurrent[name]++;
  attacker.pers["nemesis_tracking"][name] = attacker.pers["nemesis_tracking"][name] + 1;
  if(attacker.pers["nemesis_name"] == name) {
    attacker challenges::killednemesis();
  }
  if(attacker.pers["nemesis_name"] == "" || attacker.pers["nemesis_tracking"][name] > attacker.pers["nemesis_tracking"][attacker.pers["nemesis_name"]]) {
    attacker.pers["nemesis_name"] = name;
    attacker.pers["nemesis_rank"] = rank;
    attacker.pers["nemesis_rankIcon"] = prestige;
    attacker.pers["nemesis_xp"] = xp;
    attacker.pers["nemesis_xuid"] = xuid;
  } else if(isDefined(attacker.pers["nemesis_name"]) && attacker.pers["nemesis_name"] == name) {
    attacker.pers["nemesis_rank"] = rank;
    attacker.pers["nemesis_xp"] = xp;
  }
  pixendevent();
}

function trackattackeedeath(attackername, rank, xp, prestige, xuid) {
  self endon("disconnect");
  waittillframeend();
  pixbeginevent("trackAttackeeDeath");
  if(!isDefined(self.pers["killed_by"][attackername])) {
    self.pers["killed_by"][attackername] = 0;
  }
  self.pers["killed_by"][attackername]++;
  if(!isDefined(self.pers["nemesis_tracking"][attackername])) {
    self.pers["nemesis_tracking"][attackername] = 0;
  }
  self.pers["nemesis_tracking"][attackername] = self.pers["nemesis_tracking"][attackername] + 1.5;
  if(self.pers["nemesis_name"] == "" || self.pers["nemesis_tracking"][attackername] > self.pers["nemesis_tracking"][self.pers["nemesis_name"]]) {
    self.pers["nemesis_name"] = attackername;
    self.pers["nemesis_rank"] = rank;
    self.pers["nemesis_rankIcon"] = prestige;
    self.pers["nemesis_xp"] = xp;
    self.pers["nemesis_xuid"] = xuid;
  } else if(isDefined(self.pers["nemesis_name"]) && self.pers["nemesis_name"] == attackername) {
    self.pers["nemesis_rank"] = rank;
    self.pers["nemesis_xp"] = xp;
  }
  if(self.pers["nemesis_name"] == attackername && self.pers["nemesis_tracking"][attackername] >= 2) {
    self setclientuivisibilityflag("killcam_nemesis", 1);
  } else {
    self setclientuivisibilityflag("killcam_nemesis", 0);
  }
  pixendevent();
}

function default_iskillboosting() {
  return false;
}

function givekillstats(smeansofdeath, weapon, evictim) {
  self endon("disconnect");
  waittillframeend();
  if(level.rankedmatch && self[[level.iskillboosting]]()) {
    self iprintlnbold("");
    return;
  }
  pixbeginevent("giveKillStats");
  self incpersstat("kills", 1, 1, 1);
  self.kills = self getpersstat("kills");
  self updatestatratio("kdratio", "kills", "deaths");
  attacker = self;
  if(smeansofdeath == "MOD_HEAD_SHOT") {
    attacker thread incpersstat("headshots", 1, 1, 0);
    attacker.headshots = attacker.pers["headshots"];
    evictim recordkillmodifier("headshot");
  }
  pixendevent();
}

function inctotalkills(team) {
  if(level.teambased && isDefined(level.teams[team])) {
    game["totalKillsTeam"][team]++;
  }
  game["totalKills"]++;
}

function setinflictorstat(einflictor, eattacker, weapon) {
  if(!isDefined(eattacker)) {
    return;
  }
  if(!isDefined(einflictor)) {
    eattacker addweaponstat(weapon, "hits", 1);
    return;
  }
  if(!isDefined(einflictor.playeraffectedarray)) {
    einflictor.playeraffectedarray = [];
  }
  foundnewplayer = 1;
  for(i = 0; i < einflictor.playeraffectedarray.size; i++) {
    if(einflictor.playeraffectedarray[i] == self) {
      foundnewplayer = 0;
      break;
    }
  }
  if(foundnewplayer) {
    einflictor.playeraffectedarray[einflictor.playeraffectedarray.size] = self;
    if(weapon == "concussion_grenade" || weapon == "tabun_gas") {
      eattacker addweaponstat(weapon, "used", 1);
    }
    eattacker addweaponstat(weapon, "hits", 1);
  }
}

function processshieldassist(killedplayer) {
  self endon("disconnect");
  killedplayer endon("disconnect");
  wait(0.05);
  util::waittillslowprocessallowed();
  if(!isDefined(level.teams[self.pers["team"]])) {
    return;
  }
  if(self.pers["team"] == killedplayer.pers["team"]) {
    return;
  }
  if(!level.teambased) {
    return;
  }
  self incpersstat("assists", 1, 1, 1);
  self.assists = self getpersstat("assists");
}

function processassist(killedplayer, damagedone, weapon) {
  self endon("disconnect");
  killedplayer endon("disconnect");
  wait(0.05);
  util::waittillslowprocessallowed();
  if(!isDefined(level.teams[self.pers["team"]])) {
    return;
  }
  if(self.pers["team"] == killedplayer.pers["team"]) {
    return;
  }
  if(!level.teambased) {
    return;
  }
  assist_level = "assist";
  assist_level_value = int(ceil(damagedone / 25));
  if(assist_level_value < 1) {
    assist_level_value = 1;
  } else if(assist_level_value > 3) {
    assist_level_value = 3;
  }
  assist_level = (assist_level + "_") + (assist_level_value * 25);
  self incpersstat("assists", 1, 1, 1);
  self.assists = self getpersstat("assists");
  switch (weapon.name) {
    case "concussion_grenade": {
      assist_level = "assist_concussion";
      break;
    }
    case "flash_grenade": {
      assist_level = "assist_flash";
      break;
    }
    case "emp_grenade": {
      assist_level = "assist_emp";
      break;
    }
    case "proximity_grenade":
    case "proximity_grenade_aoe": {
      assist_level = "assist_proximity";
      break;
    }
  }
  self challenges::assisted();
}

function xpratethread() {}