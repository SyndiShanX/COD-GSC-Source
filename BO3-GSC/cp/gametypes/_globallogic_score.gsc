/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_globallogic_score.gsc
*************************************************/

#using scripts\cp\_bb;
#using scripts\cp\_challenges;
#using scripts\cp\_scoreevents;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_globallogic;
#using scripts\cp\gametypes\_globallogic_score;
#using scripts\cp\gametypes\_globallogic_utils;
#using scripts\cp\gametypes\_loadout;
#using scripts\cp\gametypes\_spawning;
#using scripts\cp\gametypes\_wager;
#using scripts\shared\bb_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\persistence_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\util_shared;
#namespace globallogic_score;

function updatematchbonusscores(winner) {
  if(!game["timepassed"]) {
    return;
  }
  if(!level.rankedmatch) {
    return;
  }
  if(level.teambased && isDefined(winner)) {
    if(winner == "endregulation") {
      return;
    }
  }
  if(!level.timelimit || level.forcedend) {
    gamelength = globallogic_utils::gettimepassed() / 1000;
    gamelength = min(gamelength, 1200);
    if(level.gametype == "twar" && game["roundsplayed"] > 0) {
      gamelength = gamelength + (level.timelimit * 60);
    }
  } else {
    gamelength = level.timelimit * 60;
  }
  if(level.teambased) {
    winningteam = "tie";
    foreach(team in level.teams) {
      if(winner == team) {
        winningteam = team;
        break;
      }
    }
    if(winningteam != "tie") {
      winnerscale = 1;
      loserscale = 0.5;
    } else {
      winnerscale = 0.75;
      loserscale = 0.75;
    }
    players = level.players;
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(player.timeplayed["total"] < 1 || player.pers["participation"] < 1) {
        player thread rank::endgameupdate();
        continue;
      }
      totaltimeplayed = player.timeplayed["total"];
      if(totaltimeplayed > gamelength) {
        totaltimeplayed = gamelength;
      }
      if(level.hostforcedend && player ishost()) {
        continue;
      }
      if(player.pers["score"] < 0) {
        continue;
      }
      spm = player rank::getspm();
      if(winningteam == "tie") {
        playerscore = int((winnerscale * ((gamelength / 60) * spm)) * (totaltimeplayed / gamelength));
        player thread givematchbonus("tie", playerscore);
        player.matchbonus = playerscore;
        continue;
      }
      if(isDefined(player.pers["team"]) && player.pers["team"] == winningteam) {
        playerscore = int((winnerscale * ((gamelength / 60) * spm)) * (totaltimeplayed / gamelength));
        player thread givematchbonus("win", playerscore);
        player.matchbonus = playerscore;
        continue;
      }
      if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator") {
        playerscore = int((loserscale * ((gamelength / 60) * spm)) * (totaltimeplayed / gamelength));
        player thread givematchbonus("loss", playerscore);
        player.matchbonus = playerscore;
      }
    }
  } else {
    if(isDefined(winner)) {
      winnerscale = 1;
      loserscale = 0.5;
    } else {
      winnerscale = 0.75;
      loserscale = 0.75;
    }
    players = level.players;
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(player.timeplayed["total"] < 1 || player.pers["participation"] < 1) {
        player thread rank::endgameupdate();
        continue;
      }
      totaltimeplayed = player.timeplayed["total"];
      if(totaltimeplayed > gamelength) {
        totaltimeplayed = gamelength;
      }
      spm = player rank::getspm();
      iswinner = 0;
      for(pidx = 0; pidx < min(level.placement["all"][0].size, 3); pidx++) {
        if(level.placement["all"][pidx] != player) {
          continue;
        }
        iswinner = 1;
      }
      if(iswinner) {
        playerscore = int((winnerscale * ((gamelength / 60) * spm)) * (totaltimeplayed / gamelength));
        player thread givematchbonus("win", playerscore);
        player.matchbonus = playerscore;
        continue;
      }
      playerscore = int((loserscale * ((gamelength / 60) * spm)) * (totaltimeplayed / gamelength));
      player thread givematchbonus("loss", playerscore);
      player.matchbonus = playerscore;
    }
  }
}

function givematchbonus(scoretype, score) {
  self endon("disconnect");
  level waittill("give_match_bonus");
  if(scoreevents::shouldaddrankxp(self)) {
    self addrankxpvalue(scoretype, score);
  }
  self rank::endgameupdate();
}

function gethighestscoringplayer() {
  players = level.players;
  winner = undefined;
  tie = 0;
  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i].pointstowin)) {
      continue;
    }
    if(players[i].pointstowin < 1) {
      continue;
    }
    if(!isDefined(winner) || players[i].pointstowin > winner.pointstowin) {
      winner = players[i];
      tie = 0;
      continue;
    }
    if(players[i].pointstowin == winner.pointstowin) {
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

function giveplayerscore(event, player, victim, descvalue) {
  scorediff = 0;
  if(level.overrideplayerscore) {
    return 0;
  }
  pixbeginevent("level.onPlayerScore");
  score = player.pers["score"];
  [[level.onplayerscore]](event, player, victim);
  newscore = player.pers["score"];
  pixendevent();
  player bb::add_to_stat("score", newscore - score);
  if(score == newscore) {
    return 0;
  }
  pixbeginevent("givePlayerScore");
  recordplayerstats(player, "score", newscore);
  scorediff = newscore - score;
  challengesenabled = !level.disablechallenges;
  player addplayerstatwithgametype("score", scorediff);
  if(challengesenabled) {
    player addplayerstat("CAREER_SCORE", scorediff);
  }
  if(level.hardcoremode) {
    player addplayerstat("SCORE_HC", scorediff);
    if(challengesenabled) {
      player addplayerstat("CAREER_SCORE_HC", scorediff);
    }
  }
  if(level.multiteam) {
    player addplayerstat("SCORE_MULTITEAM", scorediff);
    if(challengesenabled) {
      player addplayerstat("CAREER_SCORE_MULTITEAM", scorediff);
    }
  }
  if(!level.disablestattracking && isDefined(player.pers["lastHighestScore"]) && newscore > player.pers["lastHighestScore"]) {
    player setdstat("HighestStats", "highest_score", newscore);
  }
  player persistence::add_recent_stat(0, 0, "score", scorediff);
  pixendevent();
  player notify("score_event", scorediff);
  return scorediff;
}

function default_onplayerscore(event, player, victim) {
  score = rank::getscoreinfovalue(event);
  assert(isDefined(score));
  if(level.wagermatch) {
    player thread rank::updaterankscorehud(score);
  }
  _setplayerscore(player, player.pers["score"] + score);
}

function _setplayerscore(player, score) {
  if(score == player.pers["score"]) {
    return;
  }
  if(!level.rankedmatch) {
    player thread rank::updaterankscorehud(score - player.pers["score"]);
  }
  player.pers["score"] = score;
  player.score = player.pers["score"];
  recordplayerstats(player, "score", player.pers["score"]);
  if(level.wagermatch) {
    player thread wager::player_scored();
  }
}

function _getplayerscore(player) {
  return player.pers["score"];
}

function playtop3sounds() {
  wait(0.05);
  globallogic::updateplacement();
  for(i = 0; i < level.placement["all"].size; i++) {
    prevscoreplace = level.placement["all"][i].prevscoreplace;
    if(!isDefined(prevscoreplace)) {
      prevscoreplace = 1;
    }
    currentscoreplace = i + 1;
    for(j = i - 1; j >= 0; j--) {
      if(level.placement["all"][i].score == level.placement["all"][j].score) {
        currentscoreplace--;
      }
    }
    wasinthemoney = prevscoreplace <= 3;
    isinthemoney = currentscoreplace <= 3;
    level.placement["all"][i].prevscoreplace = currentscoreplace;
  }
}

function setpointstowin(points) {
  self.pers["pointstowin"] = math::clamp(points, 0, 65000);
  self.pointstowin = self.pers["pointstowin"];
  self thread globallogic::checkscorelimit();
  self thread globallogic::checkplayerscorelimitsoon();
  level thread playtop3sounds();
}

function givepointstowin(points) {
  self setpointstowin(self.pers["pointstowin"] + points);
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

function giveteamscoreforobjective_delaypostprocessing(team, score) {
  teamscore = game["teamScores"][team];
  onteamscore_incrementscore(score, team);
  newscore = game["teamScores"][team];
  if(teamscore == newscore) {
    return;
  }
  updateteamscores(team);
}

function postprocessteamscores(teams) {
  foreach(team in teams) {
    onteamscore_postprocess(team);
  }
  thread globallogic::checkscorelimit();
}

function giveteamscoreforobjective(team, score) {
  if(!isDefined(level.teams[team])) {
    return;
  }
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
  game["teamScores"][team] = math::clamp(teamscore, 0, 1000000);
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
  onteamscore_incrementscore(score, team);
  onteamscore_postprocess(team);
}

function onteamscore_incrementscore(score, team) {
  game["teamScores"][team] = game["teamScores"][team] + score;
  if(game["teamScores"][team] < 0) {
    game["teamScores"][team] = 0;
  }
  if(level.scorelimit && game["teamScores"][team] > level.scorelimit) {
    game["teamScores"][team] = level.scorelimit;
  }
}

function onteamscore_postprocess(team) {
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
  if(iswinning.size == 1) {
    level.laststatustime = gettime();
    foreach(team in iswinning) {
      if(isDefined(level.waswinning[team])) {
        if(level.waswinning.size == 1) {
          continue;
        }
      }
    }
  } else {
    return;
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
    }
  }
  level.waswinning = iswinning;
}

function default_onteamscore(event, team) {
  score = rank::getscoreinfovalue(event);
  assert(isDefined(score));
  onteamscore(score, team);
}

function initpersstat(dataname, record_stats) {
  if(!isDefined(self.pers[dataname])) {
    self.pers[dataname] = 0;
  }
  if(!isDefined(record_stats) || record_stats == 1) {
    recordplayerstats(self, dataname, int(self.pers[dataname]));
  }
}

function getpersstat(dataname) {
  return self.pers[dataname];
}

function incpersstat(dataname, increment, record_stats, includegametype) {
  pixbeginevent("incPersStat");
  self.pers[dataname] = self.pers[dataname] + increment;
  if(isDefined(includegametype) && includegametype) {
    self addplayerstatwithgametype(dataname, increment);
  } else {
    self addplayerstat(dataname, increment);
  }
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

function updatewinstats(winner) {
  winner addplayerstatwithgametype("losses", -1);
  winner addplayerstatwithgametype("wins", 1);
  if(level.hardcoremode) {
    winner addplayerstat("wins_HC", 1);
  }
  if(level.multiteam) {
    winner addplayerstat("wins_MULTITEAM", 1);
  }
  winner updatestatratio("wlratio", "wins", "losses");
  restorewinstreaks(winner);
  winner addplayerstatwithgametype("cur_win_streak", 1);
  winner notify("win");
  cur_gamemode_win_streak = winner persistence::stat_get_with_gametype("cur_win_streak");
  gamemode_win_streak = winner persistence::stat_get_with_gametype("win_streak");
  cur_win_streak = winner getdstat("playerstatslist", "cur_win_streak", "StatValue");
  if(!level.disablestattracking && cur_win_streak > winner getdstat("HighestStats", "win_streak")) {
    winner setdstat("HighestStats", "win_streak", cur_win_streak);
  }
  if(cur_gamemode_win_streak > gamemode_win_streak) {
    winner persistence::stat_set_with_gametype("win_streak", cur_gamemode_win_streak);
  }
}

function updatelossstats(loser) {
  loser addplayerstatwithgametype("losses", 1);
  loser updatestatratio("wlratio", "wins", "losses");
  loser notify("loss");
}

function updatetiestats(loser) {
  loser addplayerstatwithgametype("losses", -1);
  loser addplayerstatwithgametype("ties", 1);
  loser updatestatratio("wlratio", "wins", "losses");
  if(!level.disablestattracking) {
    loser setdstat("playerstatslist", "cur_win_streak", "StatValue", 0);
  }
  loser notify("tie");
}

function updatewinlossstats(winner) {
  if(!util::waslastround() && !level.hostforcedend) {
    return;
  }
  players = level.players;
  if(!isDefined(winner) || (isDefined(winner) && !isplayer(winner) && winner == "tie")) {
    for(i = 0; i < players.size; i++) {
      if(!isDefined(players[i].pers["team"])) {
        continue;
      }
      if(level.hostforcedend && players[i] ishost()) {
        continue;
      }
      updatetiestats(players[i]);
    }
  } else {
    if(isplayer(winner)) {
      if(level.hostforcedend && winner ishost()) {
        return;
      }
      updatewinstats(winner);
      if(!level.teambased) {
        placement = level.placement["all"];
        topthreeplayers = min(3, placement.size);
        for(index = 1; index < topthreeplayers; index++) {
          nexttopplayer = placement[index];
          updatewinstats(nexttopplayer);
        }
      }
    } else {
      for(i = 0; i < players.size; i++) {
        if(!isDefined(players[i].pers["team"])) {
          continue;
        }
        if(level.hostforcedend && players[i] ishost()) {
          continue;
        }
        if(winner == "tie") {
          updatetiestats(players[i]);
          continue;
        }
        if(players[i].pers["team"] == winner) {
          updatewinstats(players[i]);
          continue;
        }
        if(!level.disablestattracking) {
          players[i] setdstat("playerstatslist", "cur_win_streak", "StatValue", 0);
        }
      }
    }
  }
}

function backupandclearwinstreaks() {
  self.pers["winStreak"] = self getdstat("playerstatslist", "cur_win_streak", "StatValue");
  if(!level.disablestattracking) {
    self setdstat("playerstatslist", "cur_win_streak", "StatValue", 0);
  }
  self.pers["winStreakForGametype"] = persistence::stat_get_with_gametype("cur_win_streak");
  self persistence::stat_set_with_gametype("cur_win_streak", 0);
}

function restorewinstreaks(winner) {
  if(!level.disablestattracking) {
    winner setdstat("playerstatslist", "cur_win_streak", "StatValue", winner.pers["winStreak"]);
  }
  winner persistence::stat_set_with_gametype("cur_win_streak", winner.pers["winStreakForGametype"]);
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
  if(!isDefined(attacker.lastkilledvictim) || !isDefined(attacker.lastkilledvictimcount)) {
    attacker.lastkilledvictim = name;
    attacker.lastkilledvictimcount = 0;
  }
  if(attacker.lastkilledvictim == name) {
    attacker.lastkilledvictimcount++;
    if(attacker.lastkilledvictimcount >= 5) {
      attacker.lastkilledvictimcount = 0;
      attacker addplayerstat("streaker", 1);
    }
  } else {
    attacker.lastkilledvictim = name;
    attacker.lastkilledvictimcount = 1;
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
    if(isDefined(evictim) && isplayer(evictim)) {
      evictim recordkillmodifier("headshot");
    }
  }
  if(isDefined(evictim.lastflashedtime)) {
    if((evictim.lastflashedtime + 2000) >= gettime()) {
      self addweaponstat(getweapon("flash_grenade"), "CombatRecordStat", 1);
    }
  }
  if(isDefined(evictim.var_63fb6c7d)) {
    if((evictim.var_63fb6c7d + 2000) >= gettime()) {
      self addweaponstat(getweapon("proximity_grenade"), "CombatRecordStat", 1);
    }
  }
  if(isDefined(evictim.var_4d6fef21)) {
    if((evictim.var_4d6fef21 + 2000) >= gettime()) {
      self addweaponstat(getweapon("emp_grenade"), "CombatRecordStat", 1);
    }
  }
  if(isDefined(evictim.var_7097b5af)) {
    if((evictim.var_7097b5af + 2000) >= gettime()) {
      function_28c6cf9e(getitemindexfromref("cybercom_ravagecore"));
    }
  }
  if(isDefined(weapon)) {
    weaponpickedup = 0;
    if(isDefined(attacker.pickedupweapons) && isDefined(attacker.pickedupweapons[weapon])) {
      weaponpickedup = 1;
    }
    attacker addweaponstat(weapon, "kills", 1, attacker.class_num, weaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
    if(smeansofdeath == "MOD_HEAD_SHOT") {
      attacker addweaponstat(weapon, "headshots", 1, attacker.class_num, weaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
    }
    if(weapon.name == "launcher_standard_df" || weapon.name == "launcher_standard") {
      if(weapon.name == "launcher_standard_df") {
        weapon = getweapon("launcher_standard");
      } else {
        weapon = getweapon("launcher_standard_df");
      }
      attacker addweaponstat(weapon, "kills", 1, attacker.class_num, weaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
      if(smeansofdeath == "MOD_HEAD_SHOT") {
        attacker addweaponstat(weapon, "headshots", 1, attacker.class_num, weaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
      }
    }
  }
  if(isplayer(attacker)) {
    itemindex = undefined;
    if(weapon.name == "gadget_firefly_swarm" || weapon.name == "gadget_firefly_swarm_upgraded") {
      itemindex = getitemindexfromref("cybercom_fireflyswarm");
    } else {
      if(weapon.name == "hero_gravityspikes_cybercom" || weapon.name == "hero_gravityspikes_cybercom_upgraded") {
        itemindex = getitemindexfromref("cybercom_concussive");
      } else {
        if(weapon.name == "gadget_unstoppable_force" || weapon.name == "gadget_unstoppable_force_upgraded") {
          itemindex = getitemindexfromref("cybercom_unstoppableforce");
        } else {
          if(weapon.name == "gadget_es_strike") {
            itemindex = getitemindexfromref("cybercom_es_strike");
          } else if(weapon.name == "amws_gun_turret_player" || weapon.name == "hunter_main_turret_player" || weapon.name == "hunter_side_turret_player" || weapon.name == "pamws_gun_turret_player" || weapon.name == "quadtank_side_turret_player" || weapon.name == "siegebot_gun_turret_player" || weapon.name == "wasp_main_turret_player" || weapon.name == "amws_launcher_turret_player" || weapon.name == "hunter_rocket_turret_player" || weapon.name == "pamws_launcher_turret_player" || weapon.name == "quadtank_main_turret_player" || weapon.name == "rocket_wasp_launcher_turret_player" || weapon.name == "siegebot_launcher_turret_player") {
            itemindex = getitemindexfromref("cybercom_hijack");
          }
        }
      }
    }
    function_28c6cf9e(itemindex);
    if(isDefined(attacker.active_camo) && attacker.active_camo) {
      function_28c6cf9e(getitemindexfromref("cybercom_camo"));
    }
    if(isDefined(evictim.enemy) && isDefined(evictim.enemy.var_e42818a3) && evictim.enemy.var_e42818a3) {
      function_28c6cf9e(getitemindexfromref("cybercom_misdirection"));
    }
    if(attacker flagsys::get("gadget_overdrive_on")) {
      function_28c6cf9e(getitemindexfromref("cybercom_overdrive"));
    }
    if(isDefined(evictim.var_d90f9ddb) && evictim.var_d90f9ddb) {
      function_28c6cf9e(getitemindexfromref("cybercom_smokescreen"));
    }
  }
  pixendevent();
}

function function_28c6cf9e(itemindex) {
  if(isDefined(itemindex)) {
    self adddstat("ItemStats", itemindex, "stats", "kills", "statValue", 1);
  }
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
    if(weapon.name == "concussion_grenade" || weapon.name == "tabun_gas") {
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
  scoreevents::processscoreevent("shield_assist", self, killedplayer, "riotshield");
}

function processassist(killed_sentient, damagedone, weapon, assist_level) {
  self endon("disconnect");
  killed_sentient endon("disconnect");
  wait(0.05);
  util::waittillslowprocessallowed();
  if(!isDefined(level.teams[self.team])) {
    return;
  }
  if(isDefined(killed_sentient) && isDefined(killed_sentient.team) && self.team == killed_sentient.team) {
    return;
  }
  if(!level.teambased) {
    return;
  }
  if(!isDefined(assist_level)) {
    assist_level = "assist";
  }
  assist_level_value = int(ceil(damagedone / 25));
  if(assist_level_value < 1) {
    assist_level_value = 1;
  } else if(assist_level_value > 3) {
    assist_level_value = 3;
  }
  assist_level = (assist_level + "_") + (assist_level_value * 25);
  self incpersstat("assists", 1, 1, 1);
  self.assists = self getpersstat("assists");
  if(isDefined(weapon)) {
    self addweaponstat(weapon, "assists", 1);
  }
  self challenges::assisted();
  scoreevents::processscoreevent(assist_level, self, killed_sentient, weapon);
}

function xpratethread() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(level.inprematchperiod) {
    wait(0.05);
  }
  for(;;) {
    wait(5);
    if(isDefined(level.teams[level.players[0].pers[""]])) {
      self rank::giverankxp("", int(min(getdvarint(""), 50)));
    }
  }
}