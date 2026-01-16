/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_score.gsc
*****************************************************/

#include scripts\abilities\ability_player;
#include scripts\abilities\ability_util;
#include scripts\core_common\activecamo_shared;
#include scripts\core_common\bb_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\contracts_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\loadout_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\persistence_shared;
#include scripts\core_common\player\player_role;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\potm_shared;
#include scripts\core_common\rank_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\killstreaks_util;
#include scripts\mp_common\callbacks;
#include scripts\mp_common\challenges;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\gametypes\match;
#include scripts\mp_common\gametypes\outcome;
#include scripts\mp_common\scoreevents;
#include scripts\mp_common\util;

#namespace globallogic_score;

autoexec __init__() {
  level.scoreevents_givekillstats = &givekillstats;
  level.scoreevents_processassist = &function_b1a3b359;
  clientfield::register("clientuimodel", "hudItems.scoreProtected", 1, 1, "int");
  clientfield::register("clientuimodel", "hudItems.minorActions.action0", 1, 1, "counter");
  clientfield::register("clientuimodel", "hudItems.minorActions.action1", 1, 1, "counter");
  clientfield::register("clientuimodel", "hudItems.hotStreak.level", 1, 3, "int");
  callback::on_joined_team(&set_character_spectate_on_index);
  callback::on_joined_spectate(&function_30ab51a4);
  callback::on_changed_specialist(&function_30ab51a4);
}

event_handler[gametype_init] main(eventstruct) {
  profilestart();
  level thread function_39193e3a();
  profilestop();
}

function_39193e3a() {
  self notify("18852d080139d2c5");
  self endon("18852d080139d2c5");
  level endon(#"game_ended");

  while(true) {
    waitresult = level waittill(#"hero_gadget_activated");

    if(isDefined(waitresult.weapon) && isDefined(waitresult.player)) {
      player = waitresult.player;

      if(isDefined(player.pers[#"hash_53919d92ff1d039"])) {
        scoreevents::function_6f51d1e9("battle_command_ultimate_command", player.pers[#"hash_53919d92ff1d039"], undefined, undefined);
        player.pers[#"hash_53919d92ff1d039"] = undefined;
      }
    }
  }
}

function_eaa4e6f7() {
  if(!level.timelimit || level.forcedend) {
    gamelength = float(globallogic_utils::gettimepassed()) / 1000;
    gamelength = min(gamelength, 1200);
  } else {
    gamelength = level.timelimit * 60;
  }

  return gamelength;
}

function_61f303f5(game_length) {
  totaltimeplayed = self.timeplayed[#"total"];

  if(totaltimeplayed > game_length) {
    totaltimeplayed = game_length;
  }

  return totaltimeplayed;
}

function_c9de50a6(player) {
  for(pidx = 0; pidx < min(level.placement[#"all"].size, 3); pidx++) {
    if(level.placement[#"all"][pidx] != player) {
      continue;
    }

    return true;
  }

  return false;
}

function_78e7b549(scale, type, game_length) {
  total_time_played = self function_61f303f5(game_length);
  spm = self rank::getspm();
  playerscore = int(scale * game_length / 60 * spm * total_time_played / game_length);
  self thread givematchbonus(type, playerscore);
  self.matchbonus = playerscore;
}

updatematchbonusscores(outcome) {
  if(!game.timepassed) {
    return;
  }

  if(!level.rankedmatch) {
    updatecustomgamewinner(outcome);
    return;
  }

  gamelength = function_eaa4e6f7();
  tie = outcome::get_flag(outcome, "tie");

  if(tie) {
    winnerscale = 0.75;
    loserscale = 0.75;
  } else {
    winnerscale = 1;
    loserscale = 0.5;
  }

  winning_team = outcome::get_winning_team(outcome);
  players = level.players;

  foreach(player in players) {
    if(player.timeplayed[#"total"] < 1 || player.pers[#"participation"] < 1) {
      player thread rank::endgameupdate();
      continue;
    }

    if(level.hostforcedend && player ishost()) {
      continue;
    }

    if(player.pers[#"score"] < 0) {
      continue;
    }

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == #"spectator") {
      continue;
    }

    if(level.teambased) {
      if(tie) {
        player function_78e7b549(winnerscale, "tie", gamelength);
      } else if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == winning_team) {
        player function_78e7b549(winnerscale, "win", gamelength);
      } else {
        player function_78e7b549(loserscale, "loss", gamelength);
      }
    } else if(function_c9de50a6(player)) {
      player function_78e7b549(winnerscale, "win", gamelength);
    } else {
      player function_78e7b549(loserscale, "loss", gamelength);
    }

    player.pers[#"totalmatchbonus"] += player.matchbonus;
  }
}

updatecustomgamewinner(outcome) {
  if(!level.mpcustommatch) {
    return;
  }

  winner_team = outcome::get_winning_team(outcome);
  tie = outcome::get_flag(outcome, "tie");

  foreach(player in level.players) {
    if(!isDefined(winner_team)) {
      player.pers[#"victory"] = 0;
    } else if(level.teambased) {
      if(player.team == winner_team) {
        player.pers[#"victory"] = 2;
      } else if(tie) {
        player.pers[#"victory"] = 1;
      } else {
        player.pers[#"victory"] = 0;
      }
    } else if(function_c9de50a6(player)) {
      player.pers[#"victory"] = 2;
    } else {
      player.pers[#"victory"] = 0;
    }

    player.victory = player.pers[#"victory"];
    player.pers[#"sbtimeplayed"] = player.timeplayed[#"total"];
    player.sbtimeplayed = player.pers[#"sbtimeplayed"];
  }
}

givematchbonus(scoretype, score) {
  self endon(#"disconnect");
  level waittill(#"give_match_bonus");

  if(!isDefined(self)) {
    return;
  }

  if(sessionmodeiswarzonegame()) {
    return;
  }

  if(scoreevents::shouldaddrankxp(self)) {
    if(isDefined(self.pers) && isDefined(self.pers[#"totalmatchbonus"])) {
      score = self.pers[#"totalmatchbonus"];
    }

    self addrankxpvalue(scoretype, score);
  }

  self rank::endgameupdate();
}

gethighestscoringplayer() {
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

function_15683f39() {
  players = level.players;
  highestscoringplayer = undefined;
  tie = 0;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isDefined(player.score)) {
      continue;
    }

    if(player.score < 1) {
      continue;
    }

    if(!isDefined(highestscoringplayer) || player.score > highestscoringplayer.score) {
      highestscoringplayer = player;
      tie = 0;
      continue;
    }

    if(player.score == highestscoringplayer.score) {
      tie = 1;
    }
  }

  if(tie || !isDefined(highestscoringplayer)) {
    return undefined;
  }

  return highestscoringplayer;
}

resetplayerscorechainandmomentum(player) {
  player thread _setplayermomentum(self, 0);
  player thread resetscorechain();
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

giveplayermomentumnotification(score, label, descvalue, countstowardrampage, weapon, combatefficiencybonus = 0, eventindex, event, playersaffected) {
  score += combatefficiencybonus;

  if(isDefined(level.var_5ee570bd) && level.var_5ee570bd) {
    score = rank::function_bcb5e246(event);

    if(!isDefined(score)) {
      score = 0;
    }
  }

  if(score != 0) {
    if(!isDefined(eventindex)) {
      eventindex = 1;
    }

    self luinotifyevent(#"score_event", 4, label, score, combatefficiencybonus, eventindex);
    self function_b552ffa9(#"score_event", 4, label, score, combatefficiencybonus, eventindex);
    potm::function_d6b60141(#"score_event", self, label, score, combatefficiencybonus, eventindex);
  }

  if(isDefined(event) && isDefined(level.scoreinfo[event][#"job_type"]) && level.scoreinfo[event][#"job_type"] == "hotstreak") {
    if(!isDefined(playersaffected) || playersaffected < 2) {
      self luinotifyevent(#"challenge_coin_received", 1, eventindex);
      self function_b552ffa9(#"challenge_coin_received", 1, eventindex);
    } else {
      self luinotifyevent(#"challenge_coin_received", 2, eventindex, playersaffected);
      self function_b552ffa9(#"challenge_coin_received", 2, eventindex, playersaffected);
    }
  }

  score = score;

  if(score > 0 && self hasperk(#"specialty_earnmoremomentum")) {
    score = roundtonearestfive(int(score * getdvarfloat(#"perk_killstreakmomentummultiplier", 0) + 0.5));
  }

  if(isalive(self)) {
    if(isDefined(level.var_bdff8e21) && level.var_bdff8e21) {
      score = event === #"kill" ? 1 : 0;
    }

    _setplayermomentum(self, self.pers[#"momentum"] + score);
  }
}

resetplayermomentum() {
  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks) {
    _setplayermomentum(self, 0);
    self thread resetscorechain();
    weaponslist = self getweaponslist();

    for(idx = 0; idx < weaponslist.size; idx++) {
      weapon = weaponslist[idx];

      if(killstreaks::is_killstreak_weapon(weapon)) {
        quantity = killstreaks::get_killstreak_quantity(weapon);

        if(isDefined(quantity) && quantity > 0) {
          self killstreaks::change_killstreak_quantity(weapon, quantity * -1);
        }
      }
    }
  }
}

resetplayermomentumonspawn() {
  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks) {
    var_a4e87ee3 = isDefined(self.deathtime) && self.deathtime > 0;
    var_a68a55cd = self function_80172c6();

    if(var_a4e87ee3 && var_a68a55cd > 0) {
      var_28749ebe = isDefined(self.var_28749ebe) ? self.var_28749ebe : 0;
      var_347218dd = var_a68a55cd > var_28749ebe;

      if(var_347218dd) {
        self.var_28749ebe = var_28749ebe + 1;
        var_a4e87ee3 = 0;
      } else {
        self.var_28749ebe = undefined;
      }
    } else {
      self.var_28749ebe = undefined;
    }

    if(var_a4e87ee3) {
      new_momentum = int(self.pers[#"momentum"] * (1 - math::clamp(self function_3ef59ab3(), 0, 1)));
      _setplayermomentum(self, new_momentum);
      self thread resetscorechain();
    }

    var_8c68675a = var_a68a55cd > (isDefined(self.var_28749ebe) ? self.var_28749ebe : 0);
    self clientfield::set_player_uimodel("hudItems.scoreProtected", var_8c68675a);
  }
}

giveplayermomentum(event, player, victim, descvalue, weapon, playersaffected) {
  if(isDefined(level.disablemomentum) && level.disablemomentum == 1) {
    return;
  }

  if(level.var_aa5e6547 === 1 && getdvarint(#"hash_1aa5f986ed71357d", 1) != 0) {
    if(isDefined(player) && !isalive(player)) {
      return;
    }
  }

  score = player rank::getscoreinfovalue(event);
  assert(isDefined(score));
  label = rank::getscoreinfolabel(event);
  eventindex = level.scoreinfo[event][#"row"];
  countstowardrampage = rank::doesscoreinfocounttowardrampage(event);
  combatefficiencyscore = 0;

  if(player ability_util::gadget_combat_efficiency_enabled()) {
    combatefficiencyscore = rank::function_4587103(event);

    if(isDefined(combatefficiencyscore) && combatefficiencyscore > 0) {
      player ability_util::gadget_combat_efficiency_power_drain(combatefficiencyscore);
      slot = -1;

      if(isDefined(weapon)) {
        slot = player gadgetgetslot(weapon);
        hero_slot = player ability_util::gadget_slot_for_type(11);
      }
    }
  }

  if(event == "death") {
    _setplayermomentum(victim, victim.pers[#"momentum"] + score);
  }

  if(level.gameended) {
    return;
  }

  if(!isDefined(label)) {
    player giveplayermomentumnotification(score, #"hash_480234a872bd64ac", descvalue, countstowardrampage, weapon, combatefficiencyscore, eventindex, event, playersaffected);
    return;
  }

  player giveplayermomentumnotification(score, label, descvalue, countstowardrampage, weapon, combatefficiencyscore, eventindex, event, playersaffected);
}

giveplayerscore(event, player, victim, descvalue, weapon = level.weaponnone, playersaffected) {
  scorediff = 0;
  momentum = player.pers[#"momentum"];
  giveplayermomentum(event, player, victim, descvalue, weapon, playersaffected);
  newmomentum = player.pers[#"momentum"];

  if(level.overrideplayerscore) {
    return 0;
  }

  pixbeginevent(#"hash_50e89abe6f3fe4f1");
  score = player.pers[#"score"];
  [[level.onplayerscore]](event, player, victim);
  newscore = player.pers[#"score"];
  pixendevent();
  isusingheropower = 0;

  if(player ability_player::is_using_any_gadget()) {
    isusingheropower = 1;
  }

  scorediff = newscore - score;
  mpplayerscore = {};
  mpplayerscore.gamemode = level.gametype;
  mpplayerscore.spawnid = getplayerspawnid(player);
  mpplayerscore.playerspecialist = function_b14806c6(player player_role::get(), currentsessionmode());
  mpplayerscore.gametime = function_f8d53445();
  mpplayerscore.type = ishash(event) ? event : hash(event);
  mpplayerscore.isscoreevent = scoreevents::isregisteredevent(event);
  mpplayerscore.player = player.name;
  mpplayerscore.delta = scorediff;
  mpplayerscore.deltamomentum = newmomentum - momentum;
  mpplayerscore.team = player.team;
  mpplayerscore.isusingheropower = isusingheropower;
  self thread function_3172cf59(player, newscore, weapon, mpplayerscore);

  if(scorediff > 0) {
    return scorediff;
  }

  return 0;
}

function_e1573815() {
  if(!isDefined(level.var_a5c930dd)) {
    level.var_a5c930dd = 0;
  }

  if(!isDefined(level.var_445b1bca)) {
    level.var_445b1bca = 0;
  }

  while(level.var_a5c930dd == gettime() || level.var_445b1bca == gettime()) {
    waitframe(1);
  }

  level.var_a5c930dd = gettime();
}

function_3172cf59(player, newscore, weapon, mpplayerscore) {
  player endon(#"disconnect");
  function_e1573815();
  pixbeginevent(#"hash_12a44df598cfa600");
  event = mpplayerscore.type;
  scorediff = mpplayerscore.delta;

  if(sessionmodeismultiplayergame() && !isbot(player)) {
    function_92d1707f(#"hash_120b2cf3162c3bc1", mpplayerscore);
  }

  player bb::add_to_stat("score", mpplayerscore.delta);

  if(!isbot(player)) {
    if(!isDefined(player.pers[#"scoreeventcache"])) {
      player.pers[#"scoreeventcache"] = [];
    }

    if(!isDefined(player.pers[#"scoreeventcache"][event])) {
      player.pers[#"scoreeventcache"][event] = 1;
    } else {
      player.pers[#"scoreeventcache"][event] += 1;
    }
  }

  if(scorediff <= 0) {
    pixendevent();
    return;
  }

  recordplayerstats(player, "score", newscore);
  challengesenabled = !level.disablechallenges;
  player stats::function_bb7eedf0(#"score", scorediff);

  if(challengesenabled) {
    player stats::function_dad108fa(#"career_score", scorediff);
    scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
    var_8a4cfbd = weapon.var_76ce72e8 && isDefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;

    if(var_8a4cfbd) {
      player stats::function_dad108fa(#"score_specialized_equipment", scorediff);
    } else if(weapon.issignatureweapon) {
      player stats::function_dad108fa(#"score_specialized_weapons", scorediff);
    }
  }

  if(level.hardcoremode) {
    player stats::function_dad108fa(#"score_hc", scorediff);

    if(challengesenabled) {
      player stats::function_dad108fa(#"career_score_hc", scorediff);
    }
  } else if(!level.arenamatch) {
    player stats::function_bb7eedf0(#"score_core", scorediff);
  }

  if(level.arenamatch) {
    player stats::function_bb7eedf0(#"score_arena", scorediff);
  }

  if(level.multiteam) {
    player stats::function_dad108fa(#"score_multiteam", scorediff);

    if(challengesenabled) {
      player stats::function_dad108fa(#"career_score_multiteam", scorediff);
    }
  }

  player contracts::player_contract_event(#"score", newscore, scorediff);

  if(isDefined(weapon) && killstreaks::is_killstreak_weapon(weapon)) {
    killstreak = killstreaks::get_from_weapon(weapon);
    killstreakpurchased = 0;

    if(isDefined(killstreak) && isDefined(level.killstreaks[killstreak])) {
      killstreakpurchased = player util::is_item_purchased(level.killstreaks[killstreak].menuname);
    }

    player contracts::player_contract_event(#"killstreak_score", scorediff, killstreakpurchased);
  }

  pixendevent();
}

default_onplayerscore(event, player, victim) {
  score = player rank::getscoreinfovalue(event);
  rolescore = player rank::getscoreinfoposition(event);
  objscore = 0;

  if(player rank::function_f7b5d9fa(event)) {
    objscore = score;
  }

  assert(isDefined(score));

  if(level.var_aa5e6547 === 1 && getdvarint(#"hash_1aa5f986ed71357d", 1) != 0) {
    if(isDefined(player) && !isalive(player)) {
      score = 0;
      objscore = 0;
      rolescore = 0;
    }
  }

  function_889ed975(player, score, objscore, rolescore);
}

function_37d62931(player, amount) {
  player.pers[#"objectives"] += amount;
  player.objectives = player.pers[#"objectives"];
}

_setplayerscore(player, score, var_e21e8076, var_53c3aa0b) {
  if(score != player.pers[#"score"]) {
    player.pers[#"score"] = score;
    player.score = player.pers[#"score"];
    recordplayerstats(player, "score", player.pers[#"score"]);
  }

  if(isDefined(var_53c3aa0b) && var_53c3aa0b != player.pers[#"rolescore"]) {
    player.pers[#"rolescore"] = var_53c3aa0b;
    player.rolescore = player.pers[#"rolescore"];
  }

  if(isDefined(var_e21e8076) && var_e21e8076 != player.pers[#"objscore"]) {
    if(isarenamode()) {
      amount = var_e21e8076 - player.pers[#"objscore"] + player stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"arenavalue");
      player stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"arenavalue", amount);
    } else {
      amount = var_e21e8076 - player.pers[#"objscore"] + player stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"statvalue");
      player stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"statvalue", amount);
    }

    player.pers[#"objscore"] = var_e21e8076;
    player.objscore = player.pers[#"objscore"];
  }
}

_getplayerscore(player) {
  return player.pers[#"score"];
}

function_17a678b7(player, scoresub) {
  score = player.pers[#"score"] - scoresub;

  if(score < 0) {
    score = 0;
  }

  _setplayerscore(player, score);
}

function_889ed975(player, score_add, var_252f7989, var_f8258842) {

  var_1eb7c454 = getdvarfloat(#"hash_eae9a8ee387705d", 1);
  score_add = int(score_add * var_1eb7c454);
  var_252f7989 = int(var_252f7989 * var_1eb7c454);
  var_f8258842 = int(var_f8258842 * var_1eb7c454);

    score = player.pers[#"score"] + score_add;
  var_e21e8076 = player.pers[#"objscore"];

  if(isDefined(var_252f7989)) {
    var_e21e8076 += var_252f7989;
  }

  var_53c3aa0b = player.pers[#"rolescore"];

  if(isDefined(var_f8258842)) {
    var_53c3aa0b += var_f8258842;
  }

  _setplayerscore(player, score, var_e21e8076, var_53c3aa0b);
}

playtop3sounds() {
  waitframe(1);
  globallogic::updateplacement();

  for(i = 0; i < level.placement[#"all"].size; i++) {
    prevscoreplace = level.placement[#"all"][i].prevscoreplace;

    if(!isDefined(prevscoreplace)) {
      prevscoreplace = 1;
    }

    currentscoreplace = i + 1;

    for(j = i - 1; j >= 0; j--) {
      if(level.placement[#"all"][i].score == level.placement[#"all"][j].score) {
        currentscoreplace--;
      }
    }

    wasinthemoney = prevscoreplace <= 3;
    isinthemoney = currentscoreplace <= 3;
    level.placement[#"all"][i].prevscoreplace = currentscoreplace;
  }
}

setpointstowin(points) {
  self.pers[#"pointstowin"] = math::clamp(points, 0, 65000);
  self.pointstowin = self.pers[#"pointstowin"];
  self thread globallogic::checkscorelimit();
  self thread globallogic::checkroundscorelimit();
  self thread globallogic::checkplayerscorelimitsoon();
  level thread playtop3sounds();
}

givepointstowin(points) {
  self setpointstowin(self.pers[#"pointstowin"] + points);
}

_setplayermomentum(player, momentum, updatescore = 1) {
  momentum = math::clamp(momentum, 0, 2000);
  oldmomentum = player.pers[#"momentum"];

  if(momentum == oldmomentum) {
    return;
  }

  if(updatescore) {
    player bb::add_to_stat("momentum", momentum - oldmomentum);
  }

  if(momentum > oldmomentum) {
    highestmomentumcost = 0;
    numkillstreaks = 0;

    if(isDefined(player.killstreak)) {
      numkillstreaks = player.killstreak.size;
    }

    killstreaktypearray = [];

    for(currentkillstreak = 0; currentkillstreak < numkillstreaks; currentkillstreak++) {
      killstreaktype = killstreaks::get_by_menu_name(player.killstreak[currentkillstreak]);

      if(isDefined(killstreaktype)) {
        momentumcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);

        if(momentumcost > highestmomentumcost) {
          highestmomentumcost = momentumcost;
        }

        killstreaktypearray[killstreaktypearray.size] = killstreaktype;
      }
    }

    _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray);

    while(highestmomentumcost > 0 && momentum >= highestmomentumcost) {
      oldmomentum = 0;
      momentum -= highestmomentumcost;
      _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray);
    }
  }

  player.pers[#"momentum"] = momentum;
  player.momentum = player.pers[#"momentum"];
}

_giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray) {
  var_2b85d59c = isDefined(level.var_2b85d59c) && level.var_2b85d59c;

  for(killstreaktypeindex = 0; killstreaktypeindex < killstreaktypearray.size; killstreaktypeindex++) {
    killstreaktype = killstreaktypearray[killstreaktypeindex];
    momentumcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);

    if(momentumcost > oldmomentum && momentumcost <= momentum) {
      weapon = killstreaks::get_killstreak_weapon(killstreaktype);
      was_already_at_max_stacking = 0;

      if(isDefined(level.usingscorestreaks) && level.usingscorestreaks) {
        if(isDefined(level.var_ed3e6ff3)) {
          player[[level.var_ed3e6ff3]](weapon, momentum);
        }

        if(weapon.iscarriedkillstreak) {
          if(!isDefined(player.pers[#"held_killstreak_ammo_count"][weapon])) {
            player.pers[#"held_killstreak_ammo_count"][weapon] = 0;
          }

          if(!isDefined(player.pers[#"killstreak_quantity"][weapon])) {
            player.pers[#"killstreak_quantity"][weapon] = 0;
          }

          currentweapon = player getcurrentweapon();

          if(currentweapon == weapon) {
            if(player.pers[#"killstreak_quantity"][weapon] < level.scorestreaksmaxstacking) {
              player.pers[#"killstreak_quantity"][weapon]++;
            }
          } else {
            player.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
            player.pers[#"held_killstreak_ammo_count"][weapon] = weapon.maxammo;
            player loadout::function_3ba6ee5d(weapon, player.pers[#"held_killstreak_ammo_count"][weapon]);
          }
        } else {
          old_killstreak_quantity = player killstreaks::get_killstreak_quantity(weapon);
          new_killstreak_quantity = player killstreaks::change_killstreak_quantity(weapon, 1);
          was_already_at_max_stacking = new_killstreak_quantity == old_killstreak_quantity;

          if(!was_already_at_max_stacking) {
            player challenges::earnedkillstreak();
            player contracts::increment_contract(#"hash_3ddcd024e6e13a32");

            if(player ability_util::gadget_is_active(12)) {
              scoreevents::processscoreevent(#"focus_earn_scorestreak", player, undefined, undefined);
              player scoreevents::specialistmedalachievement();
              player scoreevents::specialiststatabilityusage(4, 1);

              if(player.heroability.name == "gadget_combat_efficiency") {
                player stats::function_e24eec31(player.heroability, #"scorestreaks_earned", 1);

                if(!isDefined(player.scorestreaksearnedperuse)) {
                  player.scorestreaksearnedperuse = 0;
                }

                player.scorestreaksearnedperuse++;

                if(player.scorestreaksearnedperuse >= 3) {
                  scoreevents::processscoreevent(#"focus_earn_multiscorestreak", player, undefined, undefined);
                  player.scorestreaksearnedperuse = 0;
                }
              }
            }
          }
        }

        if(!was_already_at_max_stacking) {
          player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, new_killstreak_quantity, killstreaktype, var_2b85d59c, 0);
        }

        continue;
      }

      player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, 0, killstreaktype, var_2b85d59c, 0);
      activeeventname = "reward_active";

      if(isDefined(weapon)) {
        neweventname = weapon.name + "_active";

        if(scoreevents::isregisteredevent(neweventname)) {
          activeeventname = neweventname;
        }
      }
    }
  }
}

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

    if(sessionmodeismultiplayergame()) {
      mpteamscores = {
        #gametime: function_f8d53445(), 
        #event: event, 
        #team: team, 
        #diff: newscore - teamscore, 
        #score: newscore
      };
      function_92d1707f(#"hash_48d5ef92d24477d2", mpteamscores);
    }

    if(teamscore == newscore) {
      return;
    }

    updateteamscores(team);
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
  }

giveteamscoreforobjective_delaypostprocessing(team, score) {
  teamscore = game.stat[#"teamscores"][team];
  onteamscore_incrementscore(score, team);
  newscore = game.stat[#"teamscores"][team];

  if(sessionmodeismultiplayergame()) {
    mpteamobjscores = {
      #gametime: function_f8d53445(), 
      #team: team, 
      #diff: newscore - teamscore, 
      #score: newscore
    };
    function_92d1707f(#"hash_22921c2c027fa389", mpteamobjscores);
  }

  if(teamscore == newscore) {
    return;
  }

  updateteamscores(team);
}

postprocessteamscores(teams) {
  foreach(team in teams) {
    onteamscore_postprocess(team);
  }

  thread globallogic::checkscorelimit();
  thread globallogic::checkroundscorelimit();
}

giveteamscoreforobjective(team, score) {
  if(!isDefined(level.teams[team])) {
    return;
  }

  teamscore = game.stat[#"teamscores"][team];
  onteamscore(score, team);
  newscore = game.stat[#"teamscores"][team];

  if(sessionmodeismultiplayergame()) {
    mpteamobjscores = {
      #gametime: function_f8d53445(), 
      #team: team, 
      #diff: newscore - teamscore, 
      #score: newscore
    };
    function_92d1707f(#"hash_22921c2c027fa389", mpteamobjscores);
  }

  if(teamscore == newscore) {
    return;
  }

  updateteamscores(team);
  thread globallogic::checkscorelimit();
  thread globallogic::checkroundscorelimit();
  thread globallogic::checksuddendeathscorelimit(team);
}

_setteamscore(team, teamscore) {
  if(teamscore == game.stat[#"teamscores"][team]) {
    return;
  }

  game.stat[#"teamscores"][team] = math::clamp(teamscore, 0, 1000000);
  updateteamscores(team);
  thread globallogic::checkscorelimit();
  thread globallogic::checkroundscorelimit();
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
  onteamscore_incrementscore(score, team);
  onteamscore_postprocess(team);
}

onteamscore_incrementscore(score, team) {
  game.stat[#"teamscores"][team] += score;

  if(game.stat[#"teamscores"][team] < 0) {
    game.stat[#"teamscores"][team] = 0;
  }

  if(level.clampscorelimit) {
    if(level.scorelimit && game.stat[#"teamscores"][team] > level.scorelimit) {
      game.stat[#"teamscores"][team] = level.scorelimit;
    }

    if(level.roundscorelimit && game.stat[#"teamscores"][team] > util::get_current_round_score_limit()) {
      game.stat[#"teamscores"][team] = util::get_current_round_score_limit();
    }
  }
}

onteamscore_postprocess(team) {
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

  if(iswinning.size == 1) {
    level.laststatustime = gettime();

    foreach(team in iswinning) {
      if(isDefined(level.waswinning[team])) {
        if(level.waswinning.size == 1) {
          continue;
        }
      }

      if(isDefined(level.var_e7b05b51) ? level.var_e7b05b51 : 1) {
        globallogic_audio::leader_dialog("gameLeadTaken", team, undefined, "status");
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

      if(isDefined(level.var_e7b05b51) ? level.var_e7b05b51 : 1) {
        globallogic_audio::leader_dialog("gameLeadLost", team, undefined, "status");
      }
    }
  }

  level.waswinning = iswinning;
}

default_onteamscore(event, team) {
  score = rank::getscoreinfovalue(event);
  assert(isDefined(score));
  onteamscore(score, team);
}

initpersstat(dataname, record_stats) {
  if(!isDefined(self.pers[dataname])) {
    self.pers[dataname] = 0;
  }

  if(!isDefined(record_stats) || record_stats == 1) {
    recordplayerstats(self, dataname, int(self.pers[dataname]));
  }
}

getpersstat(dataname) {
  return self.pers[dataname];
}

incpersstat(dataname, increment, record_stats, includegametype) {
  pixbeginevent(#"incpersstat");

  if(isDefined(self.pers[dataname])) {
    self.pers[dataname] += increment;
  }

  if(isDefined(includegametype) && includegametype) {
    self stats::function_bb7eedf0(dataname, increment);
  } else {
    self stats::function_dad108fa(dataname, increment);
  }

  if(!isDefined(record_stats) || record_stats == 1) {
    self thread threadedrecordplayerstats(dataname);
  }

  pixendevent();
}

threadedrecordplayerstats(dataname) {
  self endon(#"disconnect");
  waittillframeend();

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[dataname])) {
    recordplayerstats(self, dataname, self.pers[dataname]);
  }
}

updatewinstats(winner) {
  winner stats::function_bb7eedf0(#"losses", -1);
  winner.pers[#"outcome"] = #"win";
  winner stats::function_bb7eedf0(#"wins", 1);

  if(level.rankedmatch && !level.disablestattracking && sessionmodeismultiplayergame()) {
    if(winner stats::get_stat_global(#"wins") > 49) {
      winner giveachievement("mp_trophy_vanquisher");
    }
  }

  if(level.hardcoremode) {
    winner stats::function_dad108fa(#"wins_hc", 1);
  } else if(!level.arenamatch) {
    winner stats::function_dad108fa(#"wins_core", 1);
  }

  if(level.arenamatch) {
    winner stats::function_dad108fa(#"wins_arena", 1);
  }

  if(level.multiteam) {
    winner stats::function_dad108fa(#"wins_multiteam", 1);
  }

  winner updatestatratio("wlratio", "wins", "losses");
  restorewinstreaks(winner);
  winner stats::function_bb7eedf0(#"cur_win_streak", 1);
  winner notify(#"win");
  winner.lootxpmultiplier = 1;
  cur_gamemode_win_streak = winner stats::function_ed81f25e(#"cur_win_streak");
  gamemode_win_streak = winner stats::function_ed81f25e(#"win_streak");
  cur_win_streak = winner stats::get_stat_global(#"cur_win_streak");

  if(isDefined(cur_gamemode_win_streak) && isDefined(gamemode_win_streak) && cur_gamemode_win_streak > gamemode_win_streak) {
    winner stats::function_baa25a23(#"win_streak", cur_gamemode_win_streak);
  }

  if(bot::is_bot_ranked_match()) {
    combattrainingwins = winner stats::get_stat(#"combattrainingwins");
    winner stats::set_stat(#"combattrainingwins", combattrainingwins + 1);
  }

  if(level.var_aa5e6547 === 1) {
    winner stats::function_dad108fa(#"hash_a06075423336d9c", 1);
  }

  updateweaponcontractwin(winner);
  updatecontractwin(winner);
}

canupdateweaponcontractstats() {
  if(getdvarint(#"enable_weapon_contract", 0) == 0) {
    return false;
  }

  if(!level.rankedmatch && !level.arenamatch) {
    return false;
  }

  if(sessionmodeiswarzonegame()) {
    return false;
  }

  return true;
}

updateweaponcontractstart(player) {
  if(!canupdateweaponcontractstats()) {
    return;
  }

  if(player stats::get_stat(#"weaponcontractdata", #"starttimestamp") == 0) {
    player stats::set_stat(#"weaponcontractdata", #"starttimestamp", getutc());
  }
}

updateweaponcontractwin(winner) {
  if(!canupdateweaponcontractstats()) {
    return;
  }

  matcheswon = winner stats::get_stat(#"weaponcontractdata", #"currentvalue") + 1;
  winner stats::set_stat(#"weaponcontractdata", #"currentvalue", matcheswon);

  if((isDefined(winner stats::get_stat(#"weaponcontractdata", #"completetimestamp")) ? winner stats::get_stat(#"weaponcontractdata", #"completetimestamp") : 0) == 0) {
    targetvalue = getdvarint(#"weapon_contract_target_value", 100);

    if(matcheswon >= targetvalue) {
      winner stats::set_stat(#"weaponcontractdata", #"completetimestamp", getutc());
    }
  }
}

updateweaponcontractplayed() {
  if(!canupdateweaponcontractstats()) {
    return;
  }

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isDefined(player.pers[#"team"])) {
      continue;
    }

    matchesplayed = player stats::get_stat(#"weaponcontractdata", #"matchesplayed") + 1;
    player stats::set_stat(#"weaponcontractdata", #"matchesplayed", matchesplayed);
  }
}

updatecontractwin(winner) {
  if(!isDefined(level.updatecontractwinevents)) {
    return;
  }

  foreach(contractwinevent in level.updatecontractwinevents) {
    if(!isDefined(contractwinevent)) {
      continue;
    }

    [[contractwinevent]](winner);
  }
}

registercontractwinevent(event) {
  if(!isDefined(level.updatecontractwinevents)) {
    level.updatecontractwinevents = [];
  }

  if(!isDefined(level.updatecontractwinevents)) {
    level.updatecontractwinevents = [];
  } else if(!isarray(level.updatecontractwinevents)) {
    level.updatecontractwinevents = array(level.updatecontractwinevents);
  }

  level.updatecontractwinevents[level.updatecontractwinevents.size] = event;
}

updatelossstats(loser) {
  loser.pers[#"outcome"] = #"loss";
  loser stats::function_bb7eedf0(#"losses", 1);
  loser updatestatratio("wlratio", "wins", "losses");
  loser notify(#"loss");
}

updatelosslatejoinstats(loser) {
  loser stats::function_bb7eedf0(#"losses", -1);
  loser stats::function_bb7eedf0(#"losses_late_join", 1);
  loser updatestatratio("wlratio", "wins", "losses");
}

updatetiestats(loser) {
  loser stats::function_bb7eedf0(#"losses", -1);
  loser.pers[#"outcome"] = #"draw";
  loser stats::function_bb7eedf0(#"ties", 1);
  loser updatestatratio("wlratio", "wins", "losses");

  if(!level.disablestattracking) {
    loser stats::set_stat_global(#"cur_win_streak", 0);

    if(level.var_aa5e6547 === 1) {
      loser stats::set_stat_global(#"hash_a06075423336d9c", 0);
    }
  }

  loser notify(#"tie");
}

updatewinlossstats() {
  if(!util::waslastround() && !level.hostforcedend) {
    return;
  }

  players = level.players;
  updateweaponcontractplayed();

  if(match::function_75f97ac7()) {
    if(level.hostforcedend && match::function_517c0ce0()) {
      return;
    }

    winner = match::get_winner();
    updatewinstats(winner);

    if(!level.teambased) {
      placement = level.placement[#"all"];
      topthreeplayers = min(3, placement.size);

      for(index = 1; index < topthreeplayers; index++) {
        nexttopplayer = placement[index];
        updatewinstats(nexttopplayer);
      }

      foreach(player in players) {
        if(winner == player) {
          continue;
        }

        for(index = 1; index < topthreeplayers; index++) {
          if(player == placement[index]) {
            break;
          }
        }

        if(index < topthreeplayers) {
          continue;
        }

        if(level.rankedmatch && !level.leaguematch && player.pers[#"latejoin"] === 1) {
          updatelosslatejoinstats(player);
        }
      }
    }

    return;
  }

  if(match::get_flag("tie")) {
    foreach(player in players) {
      if(!isDefined(player.pers[#"team"])) {
        continue;
      }

      if(level.hostforcedend && player ishost()) {
        continue;
      }

      updatetiestats(player);
    }

    return;
  }

  foreach(player in players) {
    if(!isDefined(player.pers[#"team"])) {
      continue;
    }

    if(level.hostforcedend && player ishost()) {
      continue;
    }

    if(match::get_flag("tie")) {
      updatetiestats(player);
      continue;
    }

    if(match::function_a2b53e17(player)) {
      updatewinstats(player);
      continue;
    }

    if(level.rankedmatch && !level.leaguematch && player.pers[#"latejoin"] === 1) {
      updatelosslatejoinstats(player);
    }

    if(!level.disablestattracking) {
      player stats::set_stat_global(#"cur_win_streak", 0);

      if(level.var_aa5e6547 === 1) {
        player stats::set_stat_global(#"hash_a06075423336d9c", 0);
      }
    }
  }
}

backupandclearwinstreaks() {
  if(isDefined(level.freerun) && level.freerun) {
    return;
  }

  self.pers[#"winstreak"] = self stats::get_stat_global(#"cur_win_streak");

  if(!level.disablestattracking) {
    self stats::set_stat_global(#"cur_win_streak", 0);

    if(level.var_aa5e6547 === 1) {
      self.pers[#"winstreakcwl"] = self stats::get_stat_global(#"hash_a06075423336d9c");
      self stats::set_stat_global(#"hash_a06075423336d9c", 0);
    }
  }

  self.pers[#"winstreakforgametype"] = self stats::function_ed81f25e(#"cur_win_streak");
  self stats::function_baa25a23(#"cur_win_streak", 0);
}

restorewinstreaks(winner) {
  if(!level.disablestattracking) {
    winner stats::set_stat_global(#"cur_win_streak", winner.pers[#"winstreak"]);

    if(level.var_aa5e6547 === 1) {
      winner stats::set_stat_global(#"hash_a06075423336d9c", winner.pers[#"winstreakcwl"]);
    }
  }

  winner stats::function_baa25a23(#"cur_win_streak", isDefined(winner.pers[#"winstreakforgametype"]) ? winner.pers[#"winstreakforgametype"] : 0);
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

trackattackerkill(name, rank, xp, prestige, xuid, weapon) {
  self endon(#"disconnect");
  attacker = self;
  waittillframeend();
  pixbeginevent(#"trackattackerkill");

  if(!isDefined(attacker.pers[#"killed_players"][name])) {
    attacker.pers[#"killed_players"][name] = 0;
  }

  if(!isDefined(attacker.pers[#"killed_players_with_specialist"][name])) {
    attacker.pers[#"killed_players_with_specialist"][name] = 0;
  }

  if(!isDefined(attacker.killedplayerscurrent[name])) {
    attacker.killedplayerscurrent[name] = 0;
  }

  attacker.pers[#"killed_players"][name]++;
  attacker.killedplayerscurrent[name]++;

  if(weapon.isheavyweapon) {
    attacker.pers[#"killed_players_with_specialist"][name]++;
  }

  if(attacker.pers[#"nemesis_name"] == name) {
    attacker challenges::killednemesis();
  }

  attacker function_e7b4c25c(name, 1.5, rank, prestige, xp, xuid);

  if(!isDefined(attacker.lastkilledvictim) || !isDefined(attacker.lastkilledvictimcount)) {
    attacker.lastkilledvictim = name;
    attacker.lastkilledvictimcount = 0;
  }

  if(attacker.lastkilledvictim == name) {
    attacker.lastkilledvictimcount++;

    if(attacker.lastkilledvictimcount >= 5) {
      attacker.lastkilledvictimcount = 0;
      attacker stats::function_dad108fa(#"streaker", 1);
    }
  } else {
    attacker.lastkilledvictim = name;
    attacker.lastkilledvictimcount = 1;
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
  self function_e7b4c25c(attackername, 1.5, rank, prestige, xp, xuid);

  if(self.pers[#"nemesis_name"] == attackername && self.pers[#"nemesis_tracking"][attackername].value >= 2) {
    self setclientuivisibilityflag("killcam_nemesis", 1);
  } else {
    self setclientuivisibilityflag("killcam_nemesis", 0);
  }

  selfkillstowardsattacker = 0;

  if(isDefined(self.pers[#"killed_players"][attackername])) {
    selfkillstowardsattacker = self.pers[#"killed_players"][attackername];
  }

  self luinotifyevent(#"track_victim_death", 2, self.pers[#"killed_by"][attackername], selfkillstowardsattacker);
  pixendevent();
}

default_iskillboosting() {
  return false;
}

givekillstats(smeansofdeath, weapon, evictim, var_e7a369ea) {
  self endon(#"disconnect");

  if(self === var_e7a369ea) {
    self.kills += 1;
  }

  laststandparams = undefined;

  if(isDefined(evictim)) {
    laststandparams = evictim.laststandparams;
  }

  waittillframeend();

  if(level.rankedmatch && self[[level.iskillboosting]]()) {

    self iprintlnbold("<dev string:x38>");

      return;
  }

  pixbeginevent(#"givekillstats");

  if(self === var_e7a369ea) {
    self activecamo::function_896ac347(weapon, #"kills", 1);
    self activecamo::function_1af985ba(weapon);
    self incpersstat(#"kills", 1, 1, 1);
    self.kills = self getpersstat(#"kills");
    self updatestatratio("kdratio", "kills", "deaths");

    if(isDefined(evictim) && isplayer(evictim) && isDefined(evictim.attackerdamage)) {
      if(isarray(evictim.attackerdamage) && isDefined(self.clientid) && isDefined(evictim.attackerdamage[self.clientid]) && evictim.attackerdamage.size == 1) {
        stats::function_dad108fa(#"direct_action_kills", 1);
      }
    }

    if(isDefined(level.var_c8453874)) {
      [
        [level.var_c8453874]
      ](self, evictim, laststandparams);
    }
  }

  if(isDefined(evictim) && isplayer(evictim)) {
    self incpersstat(#"ekia", 1, 1, 1);
    self stats::function_e24eec31(weapon, #"ekia", 1);
    self contracts::player_contract_event(#"ekia", weapon);
    self.ekia = self getpersstat(#"ekia");
  }

  attacker = self;

  if(smeansofdeath === "MOD_HEAD_SHOT" && !killstreaks::is_killstreak_weapon(weapon)) {
    self activecamo::function_896ac347(weapon, #"headshots", 1);
    attacker thread incpersstat(#"headshots", 1, 1, 0);
    attacker.headshots = attacker.pers[#"headshots"];

    if(isDefined(evictim)) {
      evictim recordkillmodifier("headshot");
    }

    if(attacker.headshots % 5 == 0) {
      self contracts::increment_contract(#"hash_ca75e54eb5e5ef8");
    }
  }

  pixendevent();
}

setinflictorstat(einflictor, eattacker, weapon) {
  if(!isDefined(eattacker)) {
    return;
  }

  weaponpickedup = 0;

  if(isDefined(eattacker.pickedupweapons) && isDefined(eattacker.pickedupweapons[weapon])) {
    weaponpickedup = 1;
  }

  if(!isDefined(einflictor)) {
    eattacker stats::function_eec52333(weapon, #"hits", 1, eattacker.class_num, weaponpickedup);
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

    if(weapon.rootweapon.name == "tabun_gas") {
      eattacker stats::function_e24eec31(weapon, #"used", 1);
    }

    eattacker stats::function_eec52333(weapon, #"hits", 1, eattacker.class_num, weaponpickedup);
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
  currentweapon = self getcurrentweapon();
  scoreevents::processscoreevent(#"shield_assist", self, killedplayer, currentweapon);
}

function_b1a3b359(killedplayer, damagedone, weapon, assist_level = undefined) {
  self endon(#"disconnect");
  killedplayer endon(#"disconnect");

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

  if(isDefined(weapon)) {
    weaponpickedup = 0;

    if(isDefined(self.pickedupweapons) && isDefined(self.pickedupweapons[weapon])) {
      weaponpickedup = 1;
    }

    self stats::function_eec52333(weapon, #"assists", 1, self.class_num, weaponpickedup);
  }

  if(!level.var_724cf71) {
    switch (weapon.name) {
      case #"hash_577b41452577c37f":
      case #"concussion_grenade":
        assist_level = "assist_concussion";
        break;
      case #"hash_af1a40bb1375dab":
      case #"flash_grenade":
        assist_level = "assist_flash";
        break;
      case #"hash_4cd586d22c20b3cf":
      case #"emp_grenade":
        assist_level = "assist_emp";
        break;
      case #"proximity_grenade":
      case #"proximity_grenade_aoe":
        assist_level = "assist_proximity";
        break;
    }

    self challenges::assisted();
    scoreevents::processscoreevent(assist_level, self, killedplayer, weapon);
    return;
  }

  self challenges::function_57ca42c6(weapon);
}

function_f38e3d84(attacker, inflictor, weapon) {
  if(!isDefined(attacker) || !isDefined(attacker.team) || self util::isenemyplayer(attacker) == 0) {
    return false;
  }

  if(self == attacker || attacker.classname == "trigger_hurt_new" || attacker.classname == "worldspawn") {
    return false;
  }

  if(killstreaks::is_killstreak_weapon(weapon)) {
    return false;
  }

  if(attacker.team == #"spectator") {
    return false;
  }

  return true;
}

processkillstreakassists(attacker, inflictor, weapon) {
  if(!function_f38e3d84(attacker, inflictor, weapon)) {
    return;
  }

  params = {
    #players: [], 
    #attacker: attacker, 
    #inflictor: inflictor, 
    #weapon: weapon
  };

  foreach(player in level.players) {
    if(util::function_fbce7263(player.team, attacker.team)) {
      continue;
    }

    if(player == attacker) {
      continue;
    }

    if(player.sessionstate != "playing") {
      continue;
    }

    if(!isDefined(params.players)) {
      params.players = [];
    } else if(!isarray(params.players)) {
      params.players = array(params.players);
    }

    params.players[params.players.size] = player;
  }

  callback::callback(#"hash_425352b435722271", params);
}

updateteamscorebyroundswon() {
  if(level.scoreroundwinbased) {
    foreach(team, _ in level.teams) {
      [
        [level._setteamscore]
      ](team, game.stat[#"roundswon"][team]);
    }
  }
}

function_e7b4c25c(nemesis_name, value, nemesis_rank, var_15574043, nemesis_xp, nemesis_xuid) {
  if(!isDefined(self.pers[#"nemesis_tracking"][nemesis_name])) {
    self.pers[#"nemesis_tracking"][nemesis_name] = {
      #name: nemesis_name, 
      #value: 0
    };
  }

  self.pers[#"nemesis_tracking"][nemesis_name].value += value;
  var_b5c193c6 = self.pers[#"nemesis_tracking"][self.pers[#"nemesis_name"]];

  if(self.pers[#"nemesis_name"] == "" || !isDefined(var_b5c193c6) || self.pers[#"nemesis_tracking"][nemesis_name].value > var_b5c193c6.value) {
    assert(isDefined(nemesis_name), "<dev string:x81>" + self.name);
    assert(isstring(nemesis_name), "<dev string:xa4>" + nemesis_name + "<dev string:xaf>" + self.name);
    self.pers[#"nemesis_name"] = nemesis_name;
    self.pers[#"nemesis_rank"] = nemesis_rank;
    self.pers[#"nemesis_rankicon"] = var_15574043;
    self.pers[#"nemesis_xp"] = nemesis_xp;
    self.pers[#"nemesis_xuid"] = nemesis_xuid;
    return;
  }

  if(isDefined(self.pers[#"nemesis_name"]) && self.pers[#"nemesis_name"] == nemesis_name) {
    self.pers[#"nemesis_rank"] = nemesis_rank;
    self.pers[#"nemesis_xp"] = nemesis_xp;
  }
}

function_30ab51a4(params) {
  if(isDefined(self) && isDefined(self.pers)) {
    self.pers[#"hash_49e7469988944ecf"] = undefined;
    self.pers[#"hash_53919d92ff1d039"] = undefined;
  }
}

set_character_spectate_on_index(params) {
  if(params.var_b66879ad === 0) {
    return;
  }

  function_30ab51a4(params);
}