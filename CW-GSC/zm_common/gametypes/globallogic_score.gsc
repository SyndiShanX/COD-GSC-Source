/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_score.gsc
*****************************************************/

#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\bb_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\zm_common\bb;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_audio;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_stats;
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
  self notify(#"reset_score_chain");
  self.scorechain = 0;
  self.rankupdatetotal = 0;
}

function scorechaintimer() {
  self notify(#"score_chain_timer");
  self endon(#"reset_score_chain", #"score_chain_timer", #"death", #"disconnect");
  wait 20;
  self thread resetscorechain();
}

function roundtonearestfive(score) {
  rounding = score % 5;

  if(rounding <= 2) {
    return (score - rounding);
  }

  return score + 5 - rounding;
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
      rampagebonus = roundtonearestfive(int(label * level.rampagebonusscale + 0.5));
    }
  }

  combat_efficiency_factor = 0;

  if(label != 0) {
    self luinotifyevent(#"score_event", 4, descvalue, label, rampagebonus, combat_efficiency_factor);
  }

  label += rampagebonus;

  if(label > 0 && self hasperk(#"specialty_earnmoremomentum")) {
    label = roundtonearestfive(int(label * getdvarfloat(#"perk_killstreakmomentummultiplier", 0) + 0.5));
  }

  _setplayermomentum(self, self.pers[#"momentum"] + label);
}

function resetplayermomentumondeath() {
  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks) {
    _setplayermomentum(self, 0);
    self thread resetscorechain();
  }
}

function function_144d0392(event, player, victim, descvalue, var_dbaa74e2) {
  score = victim rank::getscoreinfovalue(player);
  assert(isDefined(score));
  xp = victim rank::getscoreinfoxp(player);
  assert(isDefined(xp));
  label = rank::getscoreinfolabel(player);
  var_b393387d = victim.pers[#"score"];
  pixbeginevent(#"");
  [[level.onplayerscore]](player, victim, descvalue);
  newscore = victim.pers[#"score"];
  pixendevent();
  var_89b2d9e4 = newscore - var_b393387d;
  var_10d67c1a = {
    #type: ishash(player) ? player : hash(player), #player: victim.name, #delta: var_89b2d9e4
  };
  victim stats::function_dad108fa(#"hash_6a861f1323ce4ae9", var_89b2d9e4);

  if(!isDefined(victim.var_42dd3eba)) {
    victim.var_42dd3eba = 0;
  }

  if(!isDefined(victim.var_93369bb6)) {
    victim.var_93369bb6 = 0;
  }

  if(!isDefined(victim.var_2e139723)) {
    victim.var_2e139723 = 0;
  }

  victim.var_42dd3eba += var_89b2d9e4;
  victim zm_stats::function_fbce465a(#"hash_76bf5af08a08d8fe", var_89b2d9e4);
  victim zm_stats::function_fbce465a(#"hash_3d915bbfdb0453ba", var_89b2d9e4);
  victim zm_stats::function_17ee4529(#"hash_5a974e436e73bc2", var_89b2d9e4, #"hash_6abe83944d701459");
  victim.var_93369bb6 += var_89b2d9e4;

  if(victim.var_93369bb6 > 25000) {
    victim.var_93369bb6 = 0;
    victim zm_stats::function_fbce465a(#"hash_24abad59aafa4b84");
  }

  victim.var_2e139723 += var_89b2d9e4;

  if(victim.var_2e139723 > 35000) {
    victim.var_2e139723 = 0;
    victim zm_stats::function_fbce465a(#"hash_3a26c1202d86e50e");
  }

  if(var_89b2d9e4 && !level.gameended && isDefined(label)) {
    if(isDefined(descvalue.var_14e19734)) {
      actor_name = descvalue.var_14e19734;
    } else if(isactor(descvalue)) {
      actor_name = descvalue function_7f0363e8(1);
    } else if(ishash(descvalue.var_c7e611ea)) {
      actor_name = descvalue.var_c7e611ea;
    } else if(ishash(descvalue.actor_name)) {
      actor_name = descvalue.actor_name;
    }

    var_3fb48d9c = isDefined(var_dbaa74e2) && is_true(var_dbaa74e2.var_3fb48d9c);

    if(ishash(actor_name)) {
      victim luinotifyevent(#"score_event", 5, label, var_89b2d9e4, actor_name, -1, var_3fb48d9c);
    } else {
      victim luinotifyevent(#"score_event", 5, label, var_89b2d9e4, #"", -1, var_3fb48d9c);
    }
  }

  self function_3172cf59(victim, newscore, level.weaponnone, var_10d67c1a);
  victim.objscore = victim.score_total;
  return var_89b2d9e4;
}

function giveplayerscore(event, player, victim, descvalue, weapon, playersaffected, var_dbaa74e2) {
  if(killstreaks::is_killstreak_weapon(playersaffected) && isDefined(var_dbaa74e2)) {
    var_dbaa74e2.var_3fb48d9c = 0;
  }

  return function_144d0392(player, victim, descvalue, weapon, var_dbaa74e2);
}

function default_onplayerscore(event, player, victim) {
  score = rank::getscoreinfovalue(player);

  if(!isDefined(level.var_96ab8769)) {
    level.var_96ab8769 = isDefined(getgametypesetting(#"hash_f3d3533f21841ae")) ? getgametypesetting(#"hash_f3d3533f21841ae") : 1;

    if(level.var_96ab8769 <= 0) {
      level.var_96ab8769 = 1;
    }
  }

  score *= level.var_96ab8769;
  var_a08ade2e = zombie_utility::get_zombie_var_team(#"zombie_point_scalar", victim.team);
  score = int(score * var_a08ade2e);
  assert(isDefined(score));
  _setplayerscore(victim, victim.pers[#"score"] + score);
}

function function_3172cf59(player, newscore, weapon, var_10d67c1a) {
  newscore endon(#"disconnect");
  pixbeginevent(#"");
  event = var_10d67c1a.type;
  scorediff = var_10d67c1a.delta;
  newscore bb::add_to_stat("score", var_10d67c1a.delta);

  if(!isbot(newscore)) {
    if(!isDefined(newscore.pers[#"scoreeventcache"])) {
      newscore.pers[#"scoreeventcache"] = [];
    }

    if(!isDefined(newscore.pers[#"scoreeventcache"][event])) {
      newscore.pers[#"scoreeventcache"][event] = 1;
    } else {
      newscore.pers[#"scoreeventcache"][event] += 1;
    }
  }

  if(scorediff <= 0) {
    pixendevent();
    return;
  }

  recordplayerstats(newscore, "score", weapon);
  newscore stats::function_bb7eedf0(#"score", scorediff);
  newscore stats::function_bb7eedf0(#"score_core", scorediff);
  newscore.score_total += scorediff;
  pixendevent();
}

function _setplayerscore(player, score) {
  if(score == player.pers[#"score"]) {
    return;
  }

  player.pers[#"score"] = score;
  player.score = player.pers[#"score"];
  recordplayerstats(player, "score", player.pers[#"score"]);
  player notify(#"hash_e456bbcb1359350");
  player thread globallogic::checkscorelimit();
  player thread globallogic::checkplayerscorelimitsoon();
}

function _getplayerscore(player) {
  return player.pers[#"score"];
}

function _setplayermomentum(player, momentum) {
  momentum = math::clamp(momentum, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 2000));
  oldmomentum = player.pers[#"momentum"];

  if(momentum == oldmomentum) {
    return;
  }

  player bb::add_to_stat("momentum", momentum - oldmomentum);

  if(momentum < oldmomentum) {}

  player.pers[#"momentum"] = momentum;
  player.momentum = player.pers[#"momentum"];
}

function setplayermomentumdebug() {
  setDvar(#"sv_momentumpercent", 0);

  while(true) {
    wait 1;
    var_2227c36c = getdvarfloat(#"sv_momentumpercent", 0);

    if(var_2227c36c != 0) {
      player = util::gethostplayer();

      if(!isDefined(player)) {
        return;
      }

      if(isDefined(player.killstreak)) {
        _setplayermomentum(player, int(getdvarint(#"hash_6cc2b9f9d4cbe073", 2000) * var_2227c36c / 100));
      }
    }
  }
}

function giveteamscore(event, team, player, victim) {
  if(level.overrideteamscore) {
    return;
  }

  pixbeginevent(#"");
  teamscore = game.stat[#"teamscores"][victim];
  [[level.onteamscore]](player, victim);
  pixendevent();
  newscore = game.stat[#"teamscores"][victim];
  zmteamscores = {
    #gametime: function_f8d53445(), #event: player, #team: victim, #diff: newscore - teamscore, #score: newscore
  };
  function_92d1707f(#"hash_6823717ff11a304a", zmteamscores);

  if(teamscore == newscore) {
    return;
  }

  updateteamscores(victim);
  thread globallogic::checkscorelimit();
}

function giveteamscoreforobjective(team, score) {
  teamscore = game.stat[#"teamscores"][team];
  onteamscore(score, team);
  newscore = game.stat[#"teamscores"][team];

  if(teamscore == newscore) {
    return;
  }

  updateteamscores(team);
  thread globallogic::checkscorelimit();
}

function _setteamscore(team, teamscore) {
  if(teamscore == game.stat[#"teamscores"][team]) {
    return;
  }

  game.stat[#"teamscores"][team] = teamscore;
  updateteamscores(team);
  thread globallogic::checkscorelimit();
}

function resetteamscores() {
  if(level.scoreroundwinbased || util::isfirstround()) {
    foreach(team, _ in level.teams) {
      game.stat[#"teamscores"][team] = 0;
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
    if(isDefined(players[i].pers[#"score"])) {
      _setplayerscore(players[i], 0);
    }
  }
}

function updateteamscores(team) {
  setteamscore(team, game.stat[#"teamscores"][team]);
  level thread globallogic::checkteamscorelimitsoon(team);
}

function updateallteamscores() {
  foreach(team, _ in level.teams) {
    updateteamscores(team);
  }
}

function _getteamscore(team) {
  return game.stat[#"teamscores"][team];
}

function gethighestteamscoreteam() {
  score = 0;
  winning_teams = [];

  foreach(team, _ in level.teams) {
    team_score = game.stat[#"teamscores"][team];

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
  game.stat[#"teamscores"][team] += score;

  if(level.scorelimit && game.stat[#"teamscores"][team] > level.scorelimit) {
    game.stat[#"teamscores"][team] = level.scorelimit;
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

  if(gettime() - level.laststatustime < 5000) {
    return;
  }

  if(areteamarraysequal(iswinning, level.waswinning)) {
    return;
  }

  level.laststatustime = gettime();

  if(iswinning.size == 1) {
    foreach(team in iswinning) {
      if(isDefined(level.waswinning[team])) {
        if(level.waswinning.size == 1) {}
      }
    }
  }

  if(level.waswinning.size == 1) {
    foreach(team in level.waswinning) {
      if(isDefined(iswinning[team])) {
        if(iswinning.size == 1) {
          continue;
        }

        if(level.waswinning.size > 1) {}
      }
    }
  }

  level.waswinning = iswinning;
}

function initpersstat(dataname, record_stats, init_to_stat_value) {
  if(!isDefined(self.pers[dataname])) {
    self.pers[dataname] = 0;
  }

  if(!isDefined(record_stats) || record_stats == 1) {
    recordplayerstats(self, dataname, int(self.pers[dataname]));
  }

  if(isDefined(init_to_stat_value) && init_to_stat_value == 1) {
    self.pers[dataname] = self stats::get_stat(#"playerstatslist", dataname, #"statvalue");
  }
}

function getpersstat(dataname) {
  return self.pers[dataname];
}

function incpersstat(dataname, increment, record_stats, includegametype) {
  pixbeginevent(#"");
  assert(isDefined(self.pers[increment]), function_9e72a96(increment) + "<dev string:x38>");
  self.pers[increment] += record_stats;
  self stats::function_dad108fa(increment, record_stats);

  if(!isDefined(includegametype) || includegametype == 1) {
    self thread threadedrecordplayerstats(increment);
  }

  pixendevent();
}

function threadedrecordplayerstats(dataname) {
  self endon(#"disconnect");
  waittillframeend();

  if(isDefined(self)) {
    recordplayerstats(self, dataname, self.pers[dataname]);
  }
}

function inckillstreaktracker(weapon) {
  self endon(#"disconnect");
  waittillframeend();

  if(weapon.name == # "artillery") {
    self.pers[#"artillery_kills"]++;
  }

  if(weapon.name == # "dog_bite") {
    self.pers[#"dog_kills"]++;
  }
}

function trackattackerkill(name, rank, xp, prestige, xuid) {
  self endon(#"disconnect");
  attacker = self;
  waittillframeend();
  pixbeginevent(#"");

  if(!isDefined(attacker.pers[#"killed_players"][name])) {
    attacker.pers[#"killed_players"][name] = 0;
  }

  if(!isDefined(attacker.killedplayerscurrent[name])) {
    attacker.killedplayerscurrent[name] = 0;
  }

  if(!isDefined(attacker.pers[#"nemesis_tracking"][name])) {
    attacker.pers[#"nemesis_tracking"][name] = 0;
  }

  attacker.pers[#"killed_players"][name]++;
  attacker.killedplayerscurrent[name]++;
  attacker.pers[#"nemesis_tracking"][name] += 1;

  if(attacker.pers[#"nemesis_name"] == name) {
    attacker challenges::killednemesis();
  }

  if(attacker.pers[#"nemesis_name"] == "" || attacker.pers[#"nemesis_tracking"][name] > attacker.pers[#"nemesis_tracking"][attacker.pers[#"nemesis_name"]]) {
    attacker.pers[#"nemesis_name"] = name;
    attacker.pers[#"nemesis_rank"] = rank;
    attacker.pers[#"nemesis_rankicon"] = prestige;
    attacker.pers[#"nemesis_xp"] = xp;
    attacker.pers[#"nemesis_xuid"] = xuid;
  } else if(isDefined(attacker.pers[#"nemesis_name"]) && attacker.pers[#"nemesis_name"] == name) {
    attacker.pers[#"nemesis_rank"] = rank;
    attacker.pers[#"nemesis_xp"] = xp;
  }

  pixendevent();
}

function trackattackeedeath(attackername, rank, xp, prestige, xuid) {
  self endon(#"disconnect");
  waittillframeend();
  pixbeginevent(#"");

  if(!isDefined(self.pers[#"killed_by"][attackername])) {
    self.pers[#"killed_by"][attackername] = 0;
  }

  self.pers[#"killed_by"][attackername]++;

  if(!isDefined(self.pers[#"nemesis_tracking"][attackername])) {
    self.pers[#"nemesis_tracking"][attackername] = 0;
  }

  self.pers[#"nemesis_tracking"][attackername] += 1.5;

  if(self.pers[#"nemesis_name"] == "" || self.pers[#"nemesis_tracking"][attackername] > self.pers[#"nemesis_tracking"][self.pers[#"nemesis_name"]]) {
    self.pers[#"nemesis_name"] = attackername;
    self.pers[#"nemesis_rank"] = rank;
    self.pers[#"nemesis_rankicon"] = prestige;
    self.pers[#"nemesis_xp"] = xp;
    self.pers[#"nemesis_xuid"] = xuid;
  } else if(isDefined(self.pers[#"nemesis_name"]) && self.pers[#"nemesis_name"] == attackername) {
    self.pers[#"nemesis_rank"] = rank;
    self.pers[#"nemesis_xp"] = xp;
  }

  if(self.pers[#"nemesis_name"] == attackername && self.pers[#"nemesis_tracking"][attackername] >= 2) {
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
  self endon(#"disconnect");
  waittillframeend();

  if(level.rankedmatch && self[[level.iskillboosting]]()) {
    self iprintlnbold("<dev string:x85>");

    return;
  }

  pixbeginevent(#"");
  self incpersstat(#"kills", 1, 1, 1);
  self.kills = self getpersstat(#"kills");
  self.kills_critical = self getpersstat(#"kills_critical");
  self updatestatratio("kdratio", "kills", "deaths");
  attacker = self;

  if(evictim == "MOD_HEAD_SHOT") {
    attacker thread incpersstat(#"headshots", 1, 1, 0);
    attacker.headshots = attacker.pers[#"headshots"];
  }

  pixendevent();
}

function inctotalkills(team) {
  if(level.teambased && isDefined(level.teams[team])) {
    game.totalkillsteam[team]++;
  }

  game.totalkills++;
}

function setinflictorstat(einflictor, eattacker, weapon) {
  if(!isDefined(eattacker)) {
    return;
  }

  if(!isDefined(einflictor)) {
    eattacker stats::function_e24eec31(weapon, #"hits", 1);
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
      eattacker stats::function_e24eec31(weapon, #"used", 1);
    }

    eattacker stats::function_e24eec31(weapon, #"hits", 1);
  }
}

function processshieldassist(killedplayer) {
  self endon(#"disconnect");
  killedplayer endon(#"disconnect");
  waitframe(1);
  util::waittillslowprocessallowed();

  if(!isDefined(level.teams[self.pers[#"team"]])) {
    return;
  }

  if(self.pers[#"team"] == killedplayer.pers[#"team"]) {
    return;
  }

  if(!level.teambased) {
    return;
  }

  self incpersstat(#"assists", 1, 1, 1);
  self.assists = self getpersstat(#"assists");
}

function processassist(killedplayer, damagedone, weapon, assist_level = undefined) {
  self endon(#"disconnect");
  killedplayer endon(#"disconnect");
  waitframe(1);
  util::waittillslowprocessallowed();

  if(!isDefined(level.teams[self.pers[#"team"]])) {
    return;
  }

  if(self.pers[#"team"] == killedplayer.pers[#"team"]) {
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

  assist_level = assist_level + "_" + assist_level_value * 25;
  self incpersstat(#"assists", 1, 1, 1);
  self.assists = self getpersstat(#"assists");

  switch (weapon.name) {
    case # "concussion_grenade":
      assist_level = "assist_concussion";
      break;
    case # "flash_grenade":
      assist_level = "assist_flash";
      break;
    case # "emp_grenade":
      assist_level = "assist_emp";
      break;
    case # "proximity_grenade":
    case # "proximity_grenade_aoe":
      assist_level = "assist_proximity";
      break;
  }

  self challenges::assisted();
}