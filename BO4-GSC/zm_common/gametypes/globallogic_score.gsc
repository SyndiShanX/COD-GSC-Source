/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_score.gsc
*****************************************************/

#include scripts\core_common\bb_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\rank_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\bb;
#include scripts\zm_common\gametypes\globallogic;
#include scripts\zm_common\gametypes\globallogic_audio;
#include scripts\zm_common\gametypes\globallogic_utils;
#include scripts\zm_common\util;

#namespace globallogic_score;

gethighestscoringplayer() {
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

resetscorechain() {
  self notify(#"reset_score_chain");
  self.scorechain = 0;
  self.rankupdatetotal = 0;
}

scorechaintimer() {
  self notify(#"score_chain_timer");
  self endon(#"reset_score_chain", #"score_chain_timer", #"death", #"disconnect");
  wait 20;
  self thread resetscorechain();
}

roundtonearestfive(score) {
  rounding = score % 5;

  if(rounding <= 2) {
    return (score - rounding);
  }

  return score + 5 - rounding;
}

giveplayermomentumnotification(score, label, descvalue, countstowardrampage) {
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
      rampagebonus = roundtonearestfive(int(score * level.rampagebonusscale + 0.5));
    }
  }

  combat_efficiency_factor = 0;

  if(score != 0) {
    self luinotifyevent(#"score_event", 4, label, score, rampagebonus, combat_efficiency_factor);
  }

  score += rampagebonus;

  if(score > 0 && self hasperk(#"specialty_earnmoremomentum")) {
    score = roundtonearestfive(int(score * getdvarfloat(#"perk_killstreakmomentummultiplier", 0) + 0.5));
  }

  _setplayermomentum(self, self.pers[#"momentum"] + score);
}

resetplayermomentumondeath() {
  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks) {
    _setplayermomentum(self, 0);
    self thread resetscorechain();
  }
}

giveplayerxpdisplay(event, player, victim, descvalue) {
  score = player rank::getscoreinfovalue(event);
  assert(isDefined(score));
  xp = player rank::getscoreinfoxp(event);
  assert(isDefined(xp));
  label = rank::getscoreinfolabel(event);

  if(xp && !level.gameended && isDefined(label)) {
    xpscale = player getxpscale();

    if(1 != xpscale) {
      xp = int(xp * xpscale + 0.5);
    }

    player luinotifyevent(#"score_event", 2, label, xp);
  }

  return score;
}

giveplayerscore(event, player, victim, descvalue, weapon, playersaffected) {
  return giveplayerxpdisplay(event, player, victim, descvalue);
}

default_onplayerscore(event, player, victim) {}

_setplayerscore(player, score) {}

_getplayerscore(player) {
  return player.pers[#"score"];
}

_setplayermomentum(player, momentum) {
  momentum = math::clamp(momentum, 0, 2000);
  oldmomentum = player.pers[#"momentum"];

  if(momentum == oldmomentum) {
    return;
  }

  player bb::add_to_stat("momentum", momentum - oldmomentum);

  if(momentum > oldmomentum) {
    highestmomentumcost = 0;
    numkillstreaks = player.killstreak.size;
    killstreaktypearray = [];
  }

  player.pers[#"momentum"] = momentum;
  player.momentum = player.pers[#"momentum"];
}

_giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray) {}

setplayermomentumdebug() {
  setdvar(#"sv_momentumpercent", 0);

  while(true) {
    wait 1;
    momentumpercent = getdvarfloat(#"sv_momentumpercent", 0);

    if(momentumpercent != 0) {
      player = util::gethostplayer();

      if(!isDefined(player)) {
        return;
      }

      if(isDefined(player.killstreak)) {
        _setplayermomentum(player, int(2000 * momentumpercent / 100));
      }
    }
  }
}

  function giveteamscore(event, team, player, victim) {
    if(level.overrideteamscore) {
      return;
    }

    pixbeginevent(#"hash_66d4a941ef078585");
    teamscore = game.stat[#"teamscores"][team];
    [[level.onteamscore]](event, team);
    pixendevent();
    newscore = game.stat[#"teamscores"][team];
    zmteamscores = {
      #gametime: function_f8d53445(), 
      #event: event, 
      #team: team, 
      #diff: newscore - teamscore, 
      #score: newscore
    };
    function_92d1707f(#"hash_6823717ff11a304a", zmteamscores);

    if(teamscore == newscore) {
      return;
    }

    updateteamscores(team);
    thread globallogic::checkscorelimit();
  }

giveteamscoreforobjective(team, score) {
  teamscore = game.stat[#"teamscores"][team];
  onteamscore(score, team);
  newscore = game.stat[#"teamscores"][team];

  if(teamscore == newscore) {
    return;
  }

  updateteamscores(team);
  thread globallogic::checkscorelimit();
}

_setteamscore(team, teamscore) {
  if(teamscore == game.stat[#"teamscores"][team]) {
    return;
  }

  game.stat[#"teamscores"][team] = teamscore;
  updateteamscores(team);
  thread globallogic::checkscorelimit();
}

resetteamscores() {
  if(level.scoreroundwinbased || util::isfirstround()) {
    foreach(team, _ in level.teams) {
      game.stat[#"teamscores"][team] = 0;
    }
  }

  updateallteamscores();
}

resetallscores() {
  resetteamscores();
  resetplayerscores();
}

resetplayerscores() {
  players = level.players;
  winner = undefined;
  tie = 0;

  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i].pers[#"score"])) {
      _setplayerscore(players[i], 0);
    }
  }
}

updateteamscores(team) {
  setteamscore(team, game.stat[#"teamscores"][team]);
  level thread globallogic::checkteamscorelimitsoon(team);
}

updateallteamscores() {
  foreach(team, _ in level.teams) {
    updateteamscores(team);
  }
}

_getteamscore(team) {
  return game.stat[#"teamscores"][team];
}

gethighestteamscoreteam() {
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

areteamarraysequal(teamsa, teamsb) {
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

onteamscore(score, team) {
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

initpersstat(dataname, record_stats, init_to_stat_value) {
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

getpersstat(dataname) {
  return self.pers[dataname];
}

incpersstat(dataname, increment, record_stats, includegametype) {
  pixbeginevent(#"incpersstat");
  assert(isDefined(self.pers[dataname]), dataname + "<dev string:x38>");
  self.pers[dataname] += increment;
  self stats::function_dad108fa(dataname, increment);

  if(!isDefined(record_stats) || record_stats == 1) {
    self thread threadedrecordplayerstats(dataname);
  }

  pixendevent();
}

threadedrecordplayerstats(dataname) {
  self endon(#"disconnect");
  waittillframeend();
  recordplayerstats(self, dataname, self.pers[dataname]);
}

inckillstreaktracker(weapon) {
  self endon(#"disconnect");
  waittillframeend();

  if(weapon.name == #"artillery") {
    self.pers[#"artillery_kills"]++;
  }

  if(weapon.name == #"dog_bite") {
    self.pers[#"dog_kills"]++;
  }
}

trackattackerkill(name, rank, xp, prestige, xuid) {
  self endon(#"disconnect");
  attacker = self;
  waittillframeend();
  pixbeginevent(#"trackattackerkill");

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

trackattackeedeath(attackername, rank, xp, prestige, xuid) {
  self endon(#"disconnect");
  waittillframeend();
  pixbeginevent(#"trackattackeedeath");

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

default_iskillboosting() {
  return false;
}

givekillstats(smeansofdeath, weapon, evictim) {
  self endon(#"disconnect");
  waittillframeend();

  if(level.rankedmatch && self[[level.iskillboosting]]()) {

    self iprintlnbold("<dev string:x84>");

      return;
  }

  pixbeginevent(#"givekillstats");
  self incpersstat(#"kills", 1, 1, 1);
  self.kills = self getpersstat(#"kills");
  self updatestatratio("kdratio", "kills", "deaths");
  attacker = self;

  if(smeansofdeath == "MOD_HEAD_SHOT") {
    attacker thread incpersstat(#"headshots", 1, 1, 0);
    attacker.headshots = attacker.pers[#"headshots"];
    evictim recordkillmodifier("headshot");
  }

  pixendevent();
}

inctotalkills(team) {
  if(level.teambased && isDefined(level.teams[team])) {
    game.totalkillsteam[team]++;
  }

  game.totalkills++;
}

setinflictorstat(einflictor, eattacker, weapon) {
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

processshieldassist(killedplayer) {
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

processassist(killedplayer, damagedone, weapon, assist_level = undefined) {
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
    case #"concussion_grenade":
      assist_level = "assist_concussion";
      break;
    case #"flash_grenade":
      assist_level = "assist_flash";
      break;
    case #"emp_grenade":
      assist_level = "assist_emp";
      break;
    case #"proximity_grenade":
    case #"proximity_grenade_aoe":
      assist_level = "assist_proximity";
      break;
  }

  self challenges::assisted();
}