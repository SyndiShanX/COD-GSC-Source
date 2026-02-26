/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_score.gsc
*****************************************************/

#using script_7a8059ca02b7b09e;
#using script_7f6cd71c43c45c57;
#using scripts\abilities\ability_util;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\armor;
#using scripts\core_common\array_shared;
#using scripts\core_common\bb_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicles\player_vehicle;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\high_value_target;
#using scripts\mp_common\scoreevents;
#namespace globallogic_score;

function autoexec __init__() {
  level.scoreevents_givekillstats = &givekillstats;
  level.scoreevents_processassist = &function_b1a3b359;

  for(i = 1; i <= 30; i++) {
    eventname = hash("killstreak_" + i);
    level.killstreakevents[eventname] = eventname;
  }

  var_5191d6f7 = # "killstreak_more_than_30";
  level.killstreakevents[var_5191d6f7] = var_5191d6f7;
  clientfield::register_clientuimodel("hudItems.scoreProtected", 1, 1, "int");
  clientfield::register_clientuimodel("hudItems.minorActions.action0", 1, 1, "counter");
  clientfield::register_clientuimodel("hudItems.minorActions.action1", 1, 1, "counter");
  clientfield::register_clientuimodel("hudItems.hotStreak.level", 1, 3, "int");
  callback::on_joined_team(&set_character_spectate_on_index);
  callback::on_joined_spectate(&function_30ab51a4);
  callback::on_changed_specialist(&function_30ab51a4);
}

function event_handler[gametype_init] main(eventstruct) {
  profilestart();
  level thread function_39193e3a();
  profilestop();
}

function event_handler[level_finalizeinit] codecallback_finalizeinitialization(eventstruct) {
  level.var_b961672f = 0.5;

  if(level.var_5b544215 === 0) {
    level.var_43723615 = &function_3ba7c551;
    level.var_43701269 = &function_b58be5d;
    level.var_b961672f = 0;
    level.killstreakdeathpenaltyindividualearn = undefined;
    return;
  }

  if(level.var_5b544215 === 1) {
    level.var_43723615 = &function_5dda25b9;
    level.var_43701269 = &function_fdbd4189;
    level.var_b961672f = (isDefined(getgametypesetting(#"hash_56a31bddd92a64dc")) ? getgametypesetting(#"hash_56a31bddd92a64dc") : 0) / 100;
    level.killstreakdeathpenaltyindividualearn = undefined;
    return;
  }

  if(level.var_5b544215 === 2) {
    level.var_43723615 = &function_94765bca;
    level.var_43701269 = &function_4301d2e0;
    level.var_b961672f = (isDefined(getgametypesetting(#"killstreakdeathpenaltyindividualearn")) ? getgametypesetting(#"killstreakdeathpenaltyindividualearn") : 0) / 100;
    level.var_bbaf4cdf = &function_fd1f8965;
    level.scorestreaksmaxstacking = 1;
  }
}

function function_39193e3a() {
  self notify("58dd3f77db08c661");
  self endon("58dd3f77db08c661");
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

function function_eaa4e6f7() {
  if(!level.timelimit || level.forcedend) {
    gamelength = float(globallogic_utils::gettimepassed()) / 1000;
    gamelength = min(gamelength, 1200);
  } else {
    gamelength = level.timelimit * 60;
  }

  return gamelength;
}

function function_d68cdc5d() {
  var_96974d12 = isDefined(getgametypesetting(#"hash_24c718cc0c526c38")) ? getgametypesetting(#"hash_24c718cc0c526c38") : 3;
  return var_96974d12;
}

function function_984a57ca(player) {
  var_96974d12 = function_d68cdc5d();

  for(pidx = 0; pidx < min(level.placement[#"all"].size, var_96974d12); pidx++) {
    if(level.placement[#"all"][pidx] != player) {
      continue;
    }

    return true;
  }

  return false;
}

function function_78e7b549(scale, outcome) {
  player = self;

  if(isDefined(player) && isDefined(player.pers) && scoreevents::shouldaddrankxp(player) && isDefined(player.pers[#"hash_150795bee4d46ce4"])) {
    var_28ee869a = gettime() - player.pers[#"hash_150795bee4d46ce4"];
    var_7f4c0762 = min(var_28ee869a / 1000 / 60, 30);
    score = int(getdvarint(#"hash_3cccb7d9e336696a", 0) * var_7f4c0762 * scale * level.var_b4320b5b[#"hash_31b5b9e273560fa9"] + 0.5);
    player addrankxpvalue(outcome, score, 3);
    player.matchbonus = score;
  }
}

function function_f7e4fb88(outcome) {
  if(!game.timepassed) {
    return;
  }

  if(!level.rankedmatch) {
    updatecustomgamewinner(outcome);
    return;
  }

  tie = outcome::get_flag(outcome, "tie");

  if(tie) {
    winnerscale = 1;
    loserscale = 1;
  } else {
    winnerscale = 1.15;
    loserscale = 0.85;
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

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == # "spectator") {
      continue;
    }

    if(level.teambased) {
      if(tie) {
        player function_78e7b549(winnerscale, "tie");
      } else if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == winning_team) {
        player function_78e7b549(winnerscale, "win");
      } else {
        player function_78e7b549(loserscale, "loss");
      }
    } else if(function_984a57ca(player)) {
      player function_78e7b549(winnerscale, "win");
    } else {
      player function_78e7b549(loserscale, "loss");
    }

    player.pers[#"totalmatchbonus"] += player.matchbonus;
  }
}

function function_863d9af1(weapon) {
  if(isDefined(self.pickedupweapons[weapon])) {
    return;
  }

  if(self.pers[#"hash_34c4a79728ef275a"].size < 10 || isDefined(self.pers[#"hash_34c4a79728ef275a"][weapon.statname])) {
    if(!isDefined(self.pers[#"hash_34c4a79728ef275a"][weapon.statname])) {
      self.pers[#"hash_34c4a79728ef275a"][weapon.statname] = 0;
    }

    self.pers[#"hash_34c4a79728ef275a"][weapon.statname]++;
  }
}

function function_3ecf3e8d() {
  players = level.players;

  foreach(player in players) {
    if(player.timeplayed[#"total"] < 1 || player.pers[#"participation"] < 1) {
      continue;
    }

    if(level.hostforcedend && player ishost()) {
      continue;
    }

    if(player.pers[#"score"] < 0) {
      continue;
    }

    var_20ba9666 = player.timeplayed[#"total"] / 60;
    var_f9c03957 = level.var_b4320b5b[#"hash_71fab2192fa2537d"] / 60 * var_20ba9666;

    if(player.ekia < var_f9c03957) {
      var_3d6175e7 = var_f9c03957 - player.ekia;
      var_a0173673 = var_3d6175e7 * level.var_b4320b5b[#"hash_1f866ae0a3a62832"];

      if(isDefined(level.scoreinfo[#"ekia"][#"xp"])) {
        foreach(weaponname, ekia in player.pers[#"hash_34c4a79728ef275a"]) {
          var_98217d33 = ekia / player.ekia;
          player function_f93152a5(#"ekia_boost", getweapon(weaponname), int(var_98217d33 * var_a0173673 * level.scoreinfo[#"ekia"][#"xp"]));
        }
      }
    }
  }
}

function updatecustomgamewinner(outcome) {
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
    } else if(function_984a57ca(player)) {
      player.pers[#"victory"] = 2;
    } else {
      player.pers[#"victory"] = 0;
    }

    player.pers[#"sbtimeplayed"] = player.timeplayed[#"total"];
  }
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

function function_15683f39() {
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

function resetplayerscorechainandmomentum(player) {
  player thread _setplayermomentum(self, 0);
  player thread resetscorechain();
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

function giveplayermomentumnotification(score, label, descvalue, weapon, combatefficiencybonus, eventindex = 0, event, playersaffected, var_dbaa74e2) {
  weapon += eventindex;

  if(is_true(level.var_5ee570bd)) {
    weapon = rank::function_bcb5e246(playersaffected);

    if(!isDefined(weapon)) {
      weapon = 0;
    }
  }

  if(weapon != 0) {
    if(!isDefined(event)) {
      event = 1;
    }

    if(var_dbaa74e2.notificationtype === # "streak") {
      self luinotifyevent(#"hash_4aa652796cc3e19", 3, combatefficiencybonus, weapon, var_dbaa74e2.var_c874a8ab);
      self function_8ba40d2f(#"hash_4aa652796cc3e19", 3, combatefficiencybonus, weapon, var_dbaa74e2.var_c874a8ab);
      potm::function_bcad6f70(#"hash_4aa652796cc3e19", self, combatefficiencybonus, weapon, var_dbaa74e2.var_c874a8ab);
    } else {
      self luinotifyevent(#"score_event", 4, combatefficiencybonus, weapon, eventindex, event);
      self function_8ba40d2f(#"score_event", 4, combatefficiencybonus, weapon, eventindex, event);
      potm::function_d6b60141(#"score_event", self, combatefficiencybonus, weapon, eventindex, event);
    }
  }

  weapon = weapon;

  if(weapon > 0 && self hasperk(#"specialty_earnmoremomentum")) {
    weapon = roundtonearestfive(int(weapon * getdvarfloat(#"perk_killstreakmomentummultiplier", 0) + 0.5));
  }

  if(!isDefined(self.pers[#"momentum"])) {
    self.pers[#"momentum"] = 0;
  }

  _setplayermomentum(self, self.pers[#"momentum"] + weapon);
}

function resetplayermomentum() {
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

function resetplayermomentumonspawn() {
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
      [[level.var_43701269]](self);
      self thread resetscorechain();
    }

    var_8c68675a = var_a68a55cd > (isDefined(self.var_28749ebe) ? self.var_28749ebe : 0);
    self clientfield::set_player_uimodel("hudItems.scoreProtected", var_8c68675a);
  }
}

function function_1ceb2820() {
  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks) {
    if(isDefined(level.var_bbaf4cdf)) {
      [[level.var_bbaf4cdf]](self);
    }

    self thread resetscorechain();
  }
}

function giveplayermomentum(event, player, victim, descvalue, weapon, playersaffected, var_dbaa74e2) {
  if(isDefined(level.disablemomentum) && level.disablemomentum == 1) {
    return;
  }

  if(level.var_73e51905 === 1 && getdvarint(#"hash_1aa5f986ed71357d", 1) != 0) {
    if(isDefined(player) && !isalive(player)) {
      return;
    }
  }

  score = player rank::getscoreinfovalue(event);
  assert(isDefined(score));
  label = rank::getscoreinfolabel(event);
  eventindex = level.scoreinfo[event][#"row"];

  if(score == 0) {
    return;
  }

  if(event == "death") {
    if(!isDefined(victim.pers[#"momentum"])) {
      victim.pers[#"momentum"] = 0;
    }

    _setplayermomentum(victim, victim.pers[#"momentum"] + score);
  }

  if(level.gameended) {
    return;
  }

  if(!isDefined(label)) {
    player giveplayermomentumnotification(score, #"hash_480234a872bd64ac", descvalue, weapon, 0, eventindex, event, playersaffected, var_dbaa74e2);
    return;
  }

  player giveplayermomentumnotification(score, label, descvalue, weapon, 0, eventindex, event, playersaffected, var_dbaa74e2);
}

function giveplayerscore(event, player, victim, descvalue, weapon = level.weaponnone, playersaffected, var_dbaa74e2) {
  scorediff = 0;
  momentum = isDefined(player.pers[#"momentum"]) ? player.pers[#"momentum"] : 0;
  giveplayermomentum(event, player, victim, descvalue, weapon, playersaffected, var_dbaa74e2);
  newmomentum = player.pers[#"momentum"];

  if(level.overrideplayerscore) {
    return 0;
  }

  pixbeginevent(#"");
  score = player.pers[#"score"];
  [[level.onplayerscore]](event, player, victim);
  newscore = player.pers[#"score"];
  pixendevent();

  if(!isDefined(score)) {
    score = 0;
  }

  if(!isDefined(newscore)) {
    newscore = 0;
  }

  scorediff = newscore - score;
  mpplayerscore = {};
  mpplayerscore.gamemode = level.gametype;
  mpplayerscore.spawnid = getplayerspawnid(player);
  mpplayerscore.gametime = function_f8d53445();
  mpplayerscore.type = ishash(event) ? event : hash(event);
  mpplayerscore.isscoreevent = scoreevents::isregisteredevent(event);
  mpplayerscore.delta = scorediff;
  mpplayerscore.deltamomentum = newmomentum - momentum;
  mpplayerscore.team = player.team;
  mpplayerscore.is_wearing_armor = player armor::has_armor();
  mpplayerscore.weapon = weapon.name;
  self thread function_3172cf59(player, newscore, weapon, mpplayerscore);

  if(scorediff > 0) {
    return scorediff;
  }

  return 0;
}

function function_e1573815() {
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

function function_3172cf59(player, newscore, weapon, mpplayerscore) {
  player endon(#"disconnect");
  function_e1573815();
  pixbeginevent(#"");
  event = mpplayerscore.type;
  scorediff = mpplayerscore.delta;

  if(sessionmodeismultiplayergame() && !isbot(player)) {
    player function_678f57c8(#"hash_120b2cf3162c3bc1", mpplayerscore);
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

    player stats::function_bcf9602(#"hash_5a974e436e73bc2", scorediff, #"hash_6abe83944d701459");
  }

  if(level.hardcoremode) {
    player stats::function_dad108fa(#"score_hc", scorediff);

    if(challengesenabled) {
      player stats::function_dad108fa(#"career_score_hc", scorediff);
    }
  } else if(level.arenamatch) {
    player stats::function_bb7eedf0(#"score_arena", scorediff);
  } else {
    player stats::function_bb7eedf0(#"score_core", scorediff);
  }

  if(level.multiteam) {
    player stats::function_dad108fa(#"score_multiteam", scorediff);

    if(challengesenabled) {
      player stats::function_dad108fa(#"career_score_multiteam", scorediff);
    }
  }

  player contracts::player_contract_event(#"score", newscore, scorediff);
  player stats::function_dad108fa(#"hash_1bc5843853724fa9", scorediff);
  player stats::function_dad108fa(#"hash_550ac37d4c3f5f49", scorediff);
  player stats::function_dad108fa(#"hash_6bf229eca4bb8729", scorediff);
  player stats::function_dad108fa(#"hash_6bf226eca4bb8210", scorediff);
  player stats::function_42277145(#"hash_76bf5af08a08d8fe", scorediff);
  player stats::function_42277145(#"hash_3d915bbfdb0453ba", scorediff);

  if(isDefined(player.var_b9962de6)) {
    if(player.var_b9962de6 < 1000) {
      player.var_b9962de6 += scorediff;

      if(player.var_b9962de6 >= 1000) {
        player stats::function_42277145(#"hash_24abad59aafa4b84", 1);
      }
    }
  }

  var_e1d4d88c = isDefined(player.pers[#"hash_6bbef30173021ea1"]) ? player.pers[#"hash_6bbef30173021ea1"] : 0;

  if(var_e1d4d88c < 5000) {
    var_ad686cbd = var_e1d4d88c + scorediff;

    if(var_ad686cbd > 5000) {
      player stats::function_42277145(#"hash_3a26c1202d86e50e", 1);
    }

    player.pers[#"hash_6bbef30173021ea1"] = var_ad686cbd;
  }

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

function function_a85339ff(event) {
  if(event == # "golden_kill_bonus" || event == # "hash_7b62ccbe655dc08a" || event == # "hash_131b23d720fc82c3") {
    return 1;
  }

  return 0;
}

function function_bb3eba01(event) {
  return isDefined(level.killstreakevents[event]);
}

function default_onplayerscore(event, player, victim) {
  score = victim rank::getscoreinfovalue(player);
  rolescore = victim rank::getscoreinfoposition(player);
  objscore = 0;

  if(victim rank::function_f7b5d9fa(player)) {
    objscore = score;
  }

  assert(isDefined(score));

  if(level.var_73e51905 === 1 && getdvarint(#"hash_1aa5f986ed71357d", 1) != 0) {
    if(isDefined(victim) && !isalive(victim)) {
      score = 0;
      objscore = 0;
      rolescore = 0;
    }
  }

  function_889ed975(victim, score, objscore, rolescore);

  if(!function_bb3eba01(player) && !function_a85339ff(player) && !high_value_target::function_66a9a1e4(player)) {
    victim incpersstat(#"hash_26948141ff5e29a3", score, 0, 0);
  }
}

function function_37d62931(player, amount) {
  player.pers[#"objectives"] += amount;
  player.objectives = player.pers[#"objectives"];
}

function _setplayerscore(player, score, var_e21e8076, var_53c3aa0b) {
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
    amount = var_e21e8076 - player.pers[#"objscore"] + player stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"statvalue");
    player stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"objective_score", #"statvalue", amount);
    player.pers[#"objscore"] = var_e21e8076;
    player.objscore = player.pers[#"objscore"];
  }
}

function _getplayerscore(player) {
  return player.pers[#"score"];
}

function function_17a678b7(player, scoresub) {
  score = player.pers[#"score"] - scoresub;

  if(score < 0) {
    score = 0;
  }

  _setplayerscore(player, score);
}

function function_889ed975(player, score_add, var_252f7989, var_f8258842) {
  var_1eb7c454 = getdvarfloat(#"hash_eae9a8ee387705d", 1);
  score_add = int(score_add * var_1eb7c454);
  var_252f7989 = int(var_252f7989 * var_1eb7c454);
  var_f8258842 = int(var_f8258842 * var_1eb7c454);

  if(!isDefined(score_add)) {
    return;
  }

  if(!isDefined(player.pers[#"score"])) {
    player.pers[#"score"] = 0;
  }

  if(!isDefined(player.pers[#"objscore"])) {
    player.pers[#"objscore"] = 0;
  }

  if(!isDefined(player.pers[#"rolescore"])) {
    player.pers[#"rolescore"] = 0;
  }

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

function setpointstowin(points) {
  self.pers[#"pointstowin"] = math::clamp(points, 0, 65000);
  self.pointstowin = self.pers[#"pointstowin"];
  self thread globallogic::checkscorelimit();
  self thread globallogic::checkroundscorelimit();
  self thread globallogic::checkplayerscorelimitsoon();
}

function givepointstowin(points) {
  self setpointstowin(self.pers[#"pointstowin"] + points);
}

function _setplayermomentum(player, momentum, updatescore = 1) {
  if(level.var_5b544215 != 2 || momentum > 0) {
    profilestart();

    if(isDefined(level.var_43723615)) {
      self[[level.var_43723615]](player, momentum, updatescore);
    }

    profilestop();
  }
}

function function_3ba7c551(player, momentum, updatescore) {
  momentum = math::clamp(momentum, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
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

    function_1b25db30(player, momentum, oldmomentum, killstreaktypearray);

    while(highestmomentumcost > 0 && momentum >= highestmomentumcost) {
      oldmomentum = 0;
      momentum -= highestmomentumcost;
      function_1b25db30(player, momentum, oldmomentum, killstreaktypearray);
    }
  }

  player.pers[#"momentum"] = momentum;
  player.momentum = player.pers[#"momentum"];

  if(getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
    iprintln("<dev string:x38>" + player.pers[#"momentum"]);
  }
}

function function_5dda25b9(player, momentum, updatescore) {
  momentum = math::clamp(momentum, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
  oldmomentum = player.pers[#"momentum"];

  if(momentum == oldmomentum) {
    return;
  }

  if(updatescore) {
    player bb::add_to_stat("momentum", momentum - oldmomentum);
  }

  player.pers[#"momentum"] = momentum;
  player.momentum = player.pers[#"momentum"];

  for(i = 0; i < 3; i++) {
    killstreaktype = killstreaks::get_by_menu_name(player.killstreak[i]);

    if(isDefined(killstreaktype)) {
      weapon = killstreaks::get_killstreak_weapon(killstreaktype);
      var_1f8971a2 = isDefined(player.pers[#"held_killstreak_ammo_count"][weapon]) && player.pers[#"held_killstreak_ammo_count"][weapon] > 0;
      var_6a0527c5 = isDefined(level.var_a385666[killstreaktype]) ? [[level.var_a385666[killstreaktype]]](i) : 0;
      var_723c42dd = isDefined(level.var_65977c6) && level.var_65977c6 == 1;

      if(function_bb8a71b(player, killstreaktype) && function_605fde09(player, killstreaktype) && player killstreakrules::iskillstreakallowed(killstreaktype, player.team, 0) && !var_1f8971a2 && !var_6a0527c5 && !var_723c42dd) {
        player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, undefined, killstreaktype, 0, 0);
      }
    }
  }

  if(getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
    iprintln("<dev string:x46>" + player.pers[#"momentum"]);
  }
}

function private function_bb8a71b(player, killstreaktype) {
  if(isDefined(killstreaktype)) {
    momentum = player.pers[#"momentum"];
    streakcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);

    if(player killstreakrules::function_40451ab0(killstreaktype)) {
      if(player.pers[#"hash_b05d8e95066f3ce"][killstreaktype] !== 1) {
        player.pers[#"hash_b05d8e95066f3ce"][killstreaktype] = 1;
        return true;
      }
    } else if(player.pers[#"hash_b05d8e95066f3ce"][killstreaktype] === 1) {
      player.pers[#"hash_b05d8e95066f3ce"][killstreaktype] = 0;
    }
  }

  return false;
}

function function_4301d2e0(player) {
  for(slot = 0; slot < 3; slot++) {
    killstreaktype = killstreaks::get_by_menu_name(player.killstreak[slot]);
    var_dc3a7628 = 0;

    if(isDefined(killstreaktype)) {
      var_464ac60 = player.pers[level.var_e57efb05[slot]];
      var_b961672f = level.var_b961672f;
      killstreakweapon = killstreaks::get_killstreak_weapon(killstreaktype);

      if(isDefined(level.killstreakdeathpenaltyindividualearn[killstreakweapon.statname])) {
        var_b961672f = level.killstreakdeathpenaltyindividualearn[killstreakweapon.statname];
      }

      var_d152ff83 = player function_95ecfff8();
      var_c64c6d64 = var_464ac60 * var_b961672f - var_d152ff83;

      if(var_c64c6d64 < 0) {
        var_c64c6d64 = 0;
      }

      var_dc3a7628 = int(floor((var_464ac60 - var_c64c6d64) / 10) * 10);
      var_dc3a7628 = math::clamp(var_dc3a7628, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
    }

    player.pers[level.var_e57efb05[slot]] = var_dc3a7628;
    player function_2c334e8f(slot, var_dc3a7628);

    if(getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
      iprintln(killstreaktype + "<dev string:x51>" + var_dc3a7628);
    }
  }
}

function function_fd1f8965(player) {
  for(slot = 0; slot < 3; slot++) {
    killstreaktype = killstreaks::get_by_menu_name(player.killstreak[slot]);
    var_dc3a7628 = 0;

    if(isDefined(killstreaktype)) {
      var_dc3a7628 = player.pers[level.var_e57efb05[slot]];
      var_dc3a7628 = math::clamp(var_dc3a7628, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
    }

    player.pers[level.var_e57efb05[slot]] = var_dc3a7628;
    player function_2c334e8f(slot, var_dc3a7628);
  }
}

function function_fdbd4189(player) {
  oldmomentum = player.pers[#"momentum"];
  var_d152ff83 = player function_95ecfff8();
  var_c64c6d64 = oldmomentum * level.var_b961672f - var_d152ff83;

  if(var_c64c6d64 < 0) {
    var_c64c6d64 = 0;
  }

  var_4c619c7a = int(floor((oldmomentum - var_c64c6d64) / 10) * 10);
  var_4c619c7a = math::clamp(var_4c619c7a, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
  player.pers[#"momentum"] = var_4c619c7a;
  player.momentum = player.pers[#"momentum"];

  if(var_4c619c7a !== oldmomentum) {
    for(i = 0; i < 3; i++) {
      killstreaktype = killstreaks::get_by_menu_name(player.killstreak[i]);
      function_bb8a71b(player, killstreaktype);
    }
  }

  if(getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
    iprintln("<dev string:x46>" + var_4c619c7a);
  }
}

function function_b58be5d(player) {
  oldmomentum = player.pers[#"momentum"];
  var_d152ff83 = player function_95ecfff8();
  var_559e5a31 = math::clamp(player function_3ef59ab3(), 0, 1);
  var_c64c6d64 = oldmomentum * var_559e5a31 - var_d152ff83;

  if(var_c64c6d64 < 0) {
    var_c64c6d64 = 0;
  }

  new_momentum = int(oldmomentum - var_c64c6d64);
  _setplayermomentum(player, new_momentum);

  if(getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
    iprintln("<dev string:x38>" + player.pers[#"momentum"]);
  }
}

function function_94765bca(player, momentum, updatescore) {
  if(!isDefined(level.var_212e8400)) {
    level.var_212e8400 = [];
  }

  entnum = momentum getentitynumber();

  if(!isDefined(level.var_212e8400[entnum])) {
    level.var_212e8400[entnum] = 0;
  }

  level.var_212e8400[entnum] += updatescore;

  if(level.var_8a1954d1 !== 1) {
    level thread function_4f4a98bf(momentum, updatescore);
  }
}

function private function_4f4a98bf(player, momentum) {
  level.var_8a1954d1 = 1;
  waittillframeend();

  foreach(entnum, momentum in level.var_212e8400) {
    player = getentbynum(entnum);

    if(!isDefined(player)) {
      continue;
    }

    function_c17ecb35(player, momentum);
  }

  level.var_212e8400 = undefined;
  level.var_8a1954d1 = undefined;
}

function private function_c17ecb35(player, momentum) {
  momentum = math::clamp(momentum, 0, getdvarint(#"hash_6cc2b9f9d4cbe073", 20000));
  oldmomentum = player.pers[#"momentum"];
  assert(oldmomentum == 0);

  if(momentum == oldmomentum) {
    return;
  }

  deltamomentum = momentum - oldmomentum;

  if(deltamomentum > 0) {
    numkillstreaks = 0;

    if(isDefined(player.killstreak)) {
      numkillstreaks = player.killstreak.size;
    }

    for(slot = 0; slot < numkillstreaks; slot++) {
      var_dc3a7628 = 0;
      killstreaktype = killstreaks::get_by_menu_name(player.killstreak[slot]);

      if(!isDefined(level.var_e57efb05[slot])) {
        continue;
      }

      if(isDefined(killstreaktype) && function_1d5c913f(player, killstreaktype)) {
        momentumcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);
        var_464ac60 = player.pers[level.var_e57efb05[slot]];
        var_dc3a7628 = var_464ac60 + deltamomentum;
        given = function_9492ba27(player, var_dc3a7628, var_464ac60, killstreaktype);

        if(var_dc3a7628 > momentumcost) {
          var_dc3a7628 = momentumcost;
        }

        if(given) {
          var_dc3a7628 -= momentumcost;
          assert(var_dc3a7628 >= 0);
        }
      }

      if(getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
        iprintln(killstreaktype + "<dev string:x51>" + var_dc3a7628);
      }

      player.pers[level.var_e57efb05[slot]] = var_dc3a7628;
      player function_2c334e8f(slot, var_dc3a7628);
    }
  }

  player.pers[#"momentum"] = 0;
  player.momentum = player.pers[#"momentum"];
}

function function_1d5c913f(player, killstreaktype) {
  weapon = killstreaks::get_killstreak_weapon(killstreaktype);

  if((isDefined(player.pers[#"killstreak_quantity"][weapon]) ? player.pers[#"killstreak_quantity"][weapon] : 0) >= level.scorestreaksmaxstacking) {
    return false;
  }

  var_d0ecbc61 = getdvarint(#"hash_71ffe2a6c9f43529", 0) != 0;
  activekillstreaks = player killstreaks::getactivekillstreaks();

  if(isDefined(activekillstreaks)) {
    foreach(killstreak in activekillstreaks) {
      if(killstreak.killstreakslot === 3) {
        continue;
      }

      if(killstreak.killstreaktype === killstreaktype) {
        if(var_d0ecbc61) {
          if(!player killstreaks::function_55e3fed6(killstreaktype)) {
            return false;
          }

          continue;
        }

        return false;
      }
    }
  }

  if(isDefined(player.pers[#"held_killstreak_ammo_count"][weapon])) {
    if(player.pers[#"held_killstreak_ammo_count"][weapon] > 0) {
      return false;
    }
  }

  if(!var_d0ecbc61 && player killstreaks::function_55e3fed6(killstreaktype)) {
    return false;
  }

  return true;
}

function function_605fde09(player, killstreaktype) {
  weapon = killstreaks::get_killstreak_weapon(killstreaktype);

  if((isDefined(player.pers[#"killstreak_quantity"][weapon]) ? player.pers[#"killstreak_quantity"][weapon] : 0) >= level.scorestreaksmaxstacking) {
    return false;
  }

  if(!isalive(player)) {
    return false;
  }

  activekillstreaks = player killstreaks::getactivekillstreaks();

  if(isDefined(activekillstreaks)) {
    foreach(killstreak in activekillstreaks) {
      if(killstreak.killstreaktype === killstreaktype) {
        return false;
      }
    }
  }

  if(player killstreaks::function_55e3fed6(killstreaktype)) {
    return false;
  }

  return true;
}

function function_1b25db30(player, momentum, oldmomentum, killstreaktypearray) {
  for(killstreaktypeindex = 0; killstreaktypeindex < killstreaktypearray.size; killstreaktypeindex++) {
    killstreaktype = killstreaktypearray[killstreaktypeindex];
    self function_d6377216(player, momentum, oldmomentum, killstreaktype);
  }
}

function function_9492ba27(player, momentum, oldmomentum, killstreaktype) {
  given = self function_d6377216(player, momentum, oldmomentum, killstreaktype);
  return given;
}

function function_d6377216(player, momentum, oldmomentum, killstreaktype) {
  given = 0;
  var_2b85d59c = is_true(level.var_2b85d59c);
  momentumcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);

  if(momentumcost > oldmomentum && momentumcost <= momentum) {
    weapon = killstreaks::get_killstreak_weapon(killstreaktype);
    was_already_at_max_stacking = 0;

    if(is_true(level.usingscorestreaks)) {
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
            given = 1;
          }
        } else {
          player.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
          player.pers[#"held_killstreak_ammo_count"][weapon] = weapon.maxammo;
          player loadout::function_3ba6ee5d(weapon, player.pers[#"held_killstreak_ammo_count"][weapon]);
          given = 1;
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
          }
        }
      }

      if(!was_already_at_max_stacking) {
        given = 1;

        if(player.pers[#"hash_b05d8e95066f3ce"][killstreaktype] === 1) {
          var_2b85d59c = 1;
        }

        if(level.var_5b544215 == 2 && player killstreaks::function_55e3fed6(killstreaktype)) {
          var_2b85d59c = 1;
        }

        player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, new_killstreak_quantity, killstreaktype, var_2b85d59c, 0);
      }
    } else {
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

  return given;
}

function function_3bd226fa(killstreaktype, var_9595834) {
  if(!isDefined(level.var_a385666)) {
    level.var_a385666 = [];
  }

  level.var_a385666[killstreaktype] = var_9595834;
}

function function_13123cee(player, killstreakslot) {
  if(game.state != # "playing") {
    return 0;
  }

  if(!isalive(player)) {
    return 0;
  }

  killstreaktype = killstreaks::get_by_menu_name(player.killstreak[killstreakslot]);

  if(killstreaks::should_delay_killstreak(killstreaktype)) {
    killstreaks::display_unavailable_time();
    return 0;
  }

  given = 0;

  if(isDefined(killstreaktype)) {
    weapon = killstreaks::get_killstreak_weapon(killstreaktype);

    if(weapon.issupplydropweapon) {
      if(player getammocount(weapon) > 0) {
        player switchtoweapon(weapon);
        return 0;
      }
    }

    if(isDefined(player.pers[#"held_killstreak_ammo_count"][weapon])) {
      if(player.pers[#"held_killstreak_ammo_count"][weapon] > 0) {
        player switchtoweapon(weapon);
        return 0;
      }
    }

    if(isDefined(level.var_a385666[killstreaktype])) {
      var_6a0527c5 = [[level.var_a385666[killstreaktype]]](killstreakslot);

      if(var_6a0527c5) {
        player switchtoweapon(weapon);
        return 0;
      }
    }

    if(player getammocount(weapon) > 0) {
      player switchtoweapon(weapon);
      return 0;
    }

    momentum = player.pers[#"momentum"];

    if(momentum > 0 && function_605fde09(player, killstreaktype) && player killstreakrules::iskillstreakallowed(killstreaktype, player.team, 0)) {
      momentumcost = player function_dceb5542(level.killstreaks[killstreaktype].itemindex);
      given = function_9492ba27(player, momentum, 0, killstreaktype);

      if(given) {
        momentum -= momentumcost;
        player.pers[#"momentum"] = momentum;
        player.momentum = player.pers[#"momentum"];

        for(i = 0; i < 3; i++) {
          var_d64761c7 = killstreaks::get_by_menu_name(player.killstreak[i]);

          if(isDefined(var_d64761c7)) {
            streakcost = player function_dceb5542(level.killstreaks[var_d64761c7].itemindex);

            if(player.momentum < streakcost) {
              player.pers[#"hash_b05d8e95066f3ce"][var_d64761c7] = 0;
            }
          }
        }

        if(getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
          iprintln("<dev string:x46>" + momentum);
        }
      }
    }
  }

  return given;
}

function function_8b375624(player, killstreaktype, momentumcost) {
  given = 0;

  if(isDefined(killstreaktype)) {
    weapon = killstreaks::get_killstreak_weapon(killstreaktype);

    if(isDefined(player.pers[#"held_killstreak_ammo_count"][weapon])) {
      if(player.pers[#"held_killstreak_ammo_count"][weapon] > 0) {
        player switchtoweapon(weapon);
        return 0;
      }
    }

    momentum = player.pers[#"momentum"];

    if(momentum >= momentumcost && function_605fde09(player, killstreaktype)) {
      momentum -= momentumcost;
      player.pers[#"momentum"] = momentum;
      player.momentum = player.pers[#"momentum"];
      given = 1;

      if(getdvarint(#"hash_4f17b3fc9d5ba79a", 0) > 0) {
        iprintln("<dev string:x46>" + momentum);
      }
    }
  }

  return given;
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
        _setplayermomentum(player, int(getdvarint(#"hash_6cc2b9f9d4cbe073", 20000) * var_2227c36c / 100));
      }
    }
  }
}

function giveteamscore(event, team) {
  if(level.overrideteamscore) {
    return;
  }

  pixbeginevent(#"");
  teamscore = game.stat[#"teamscores"][team];
  [[level.onteamscore]](event, team);
  pixendevent();
  newscore = game.stat[#"teamscores"][team];

  if(teamscore == newscore) {
    return;
  }

  updateteamscores(team);
  thread globallogic::checkscorelimit();
  thread globallogic::checkroundscorelimit();
}

function giveteamscoreforobjective_delaypostprocessing(team, score) {
  teamscore = game.stat[#"teamscores"][team];
  onteamscore_incrementscore(score, team);
  newscore = game.stat[#"teamscores"][team];

  if(sessionmodeismultiplayergame()) {
    mpteamobjscores = {
      #gametime: function_f8d53445(), #team: team, #diff: newscore - teamscore, #score: newscore
    };
    function_92d1707f(#"hash_22921c2c027fa389", mpteamobjscores);
  }

  if(teamscore == newscore) {
    return;
  }

  updateteamscores(team);
}

function postprocessteamscores() {
  onteamscore_postprocess();
  thread globallogic::checkscorelimit();
  thread globallogic::checkroundscorelimit();
}

function giveteamscoreforobjective(team, score) {
  if(!isDefined(level.teams[team])) {
    return;
  }

  teamscore = game.stat[#"teamscores"][team];
  onteamscore(score, team);
  newscore = game.stat[#"teamscores"][team];

  if(sessionmodeismultiplayergame()) {
    mpteamobjscores = {
      #gametime: function_f8d53445(), #team: team, #diff: newscore - teamscore, #score: newscore
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

function _setteamscore(team, teamscore) {
  if(teamscore == game.stat[#"teamscores"][team]) {
    return;
  }

  game.stat[#"teamscores"][team] = math::clamp(teamscore, 0, 1000000);
  updateteamscores(team);
  thread globallogic::checkscorelimit();
  thread globallogic::checkroundscorelimit();
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
  score = getteamscore(team);
  var_d0266750 = globallogic_utils::function_fd90317f(team, score);
  level thread globallogic::function_b6caec44(score, var_d0266750);
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
  onteamscore_incrementscore(score, team);
  onteamscore_postprocess();
}

function onteamscore_incrementscore(score, team) {
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

function function_e3a10376(winning_teams) {
  if(winning_teams.size == 0) {
    return;
  }

  if(gettime() - level.laststatustime < 5000) {
    return;
  }

  if(areteamarraysequal(winning_teams, level.waswinning)) {
    return;
  }

  if(winning_teams.size == 1) {
    level.laststatustime = gettime();

    foreach(team in winning_teams) {
      if(isDefined(level.waswinning[team])) {
        if(level.waswinning.size == 1) {
          continue;
        }
      }

      if(isDefined(level.var_e7b05b51) ? level.var_e7b05b51 : 1) {
        globallogic_audio::leader_dialog("gameLeadTaken", team, "status");
      }
    }
  } else {
    return;
  }

  if(level.waswinning.size == 1) {
    foreach(team in level.waswinning) {
      if(isDefined(winning_teams[team])) {
        if(winning_teams.size == 1) {
          continue;
        }

        if(level.waswinning.size > 1) {
          continue;
        }
      }

      if(isDefined(level.var_e7b05b51) ? level.var_e7b05b51 : 1) {
        globallogic_audio::leader_dialog("gameLeadLost", team, "status");
      }
    }
  }

  level.waswinning = winning_teams;
}

function onteamscore_postprocess() {
  if(level.splitscreen) {
    return;
  }

  if(level.scorelimit == 1) {
    return;
  }

  iswinning = gethighestteamscoreteam();
  function_e3a10376(iswinning);
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
  pixbeginevent(#"");

  if(isDefined(self.pers[dataname])) {
    self.pers[dataname] += increment;
  }

  if(includegametype === 1) {
    self stats::function_bb7eedf0(dataname, increment);
  } else {
    self stats::function_dad108fa(dataname, increment);
  }

  if(record_stats !== 0) {
    self thread threadedrecordplayerstats(dataname);
  }

  pixendevent();
}

function threadedrecordplayerstats(dataname) {
  self endon(#"disconnect");
  waittillframeend();

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[dataname])) {
    recordplayerstats(self, dataname, self.pers[dataname]);
  }
}

function updatewinstats(winner) {
  winner stats::function_bb7eedf0(#"losses", -1);
  winner.pers[#"outcome"] = # "win";
  winner stats::function_bb7eedf0(#"wins", 1);

  if(level.rankedmatch && !level.disablestattracking && sessionmodeismultiplayergame()) {
    if(winner stats::get_stat_global(#"wins") >= 50) {
      winner giveachievement(#"mp_achievement_match_wins");
    }
  }

  if(level.hardcoremode) {
    winner stats::function_dad108fa(#"wins_hc", 1);
    winner updatestatratio("wlratio_hc", "wins_hc", "losses_hc");
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

  if(level.hardcoremode === 1) {
    winner stats::function_dad108fa(#"hash_4a226bdcff995085", 1);
  } else {
    winner stats::function_dad108fa(#"cur_win_streak", 1);
  }

  winner stats::function_cc215323(#"cur_win_streak", 1);
  winner notify(#"win");
  winner.lootxpmultiplier = 1;
  cur_gamemode_win_streak = winner stats::function_ed81f25e(#"cur_win_streak");
  gamemode_win_streak = winner stats::function_ed81f25e(#"win_streak");
  var_845aa849 = level.hardcoremode === 1 ? winner stats::get_stat_global(#"hash_55658382e18b3ec8") : winner stats::get_stat_global(#"hash_5778f54a3c432314");
  cur_win_streak = winner stats::get_stat_global(#"cur_win_streak");

  if(isDefined(cur_win_streak) && isDefined(var_845aa849) && cur_win_streak > var_845aa849) {
    if(level.hardcoremode === 1) {
      winner stats::set_stat_global(#"hash_55658382e18b3ec8", cur_win_streak);
    } else {
      winner stats::set_stat_global(#"hash_5778f54a3c432314", cur_win_streak);
    }
  }

  if(isDefined(cur_gamemode_win_streak) && isDefined(gamemode_win_streak) && cur_gamemode_win_streak > gamemode_win_streak) {
    winner stats::function_baa25a23(#"win_streak", cur_gamemode_win_streak);
  }

  if(bot::is_bot_ranked_match()) {
    combattrainingwins = winner stats::get_stat(#"combattrainingwins");
    winner stats::set_stat(#"combattrainingwins", combattrainingwins + 1);
  }

  if(level.var_73e51905 === 1) {
    winner stats::function_dad108fa(#"hash_56a0e77eea02664d", 1);
  }

  if(level.tournamentmatch === 1) {
    var_4461529a = 0;

    if(globallogic::function_701eb149()) {
      winner stats::function_cc215323(#"hash_5cd164b625ff1544", 1);
      winner stats::function_cc215323(#"hash_19d9303e05e8a7df", -1);
      var_4461529a = 5000;
    } else if(globallogic::function_7db5c6ae()) {
      winner stats::function_cc215323(#"hash_19d9303e05e8a7df", 1);
      winner stats::function_cc215323(#"hash_19d92e3e05e8a479", -1);
      var_4461529a = 2500;
    } else if(globallogic::function_d26d580()) {
      winner stats::function_cc215323(#"hash_19d92e3e05e8a479", 1);
      winner stats::function_cc215323(#"hash_19d93a3e05e8b8dd", -1);
      var_4461529a = 1000;
    } else if(globallogic::function_5871e964()) {
      winner stats::function_cc215323(#"hash_19d93a3e05e8b8dd", 1);
      var_4461529a = 500;
    }

    if(var_4461529a > 0 && scoreevents::shouldaddrankxp(winner)) {
      winner addrankxpvalue("tournament_round_win_xp", var_4461529a, 3);
    }
  }

  winner stats::function_42277145(#"hash_76bf5df08a08de17", 1);
  updateweaponcontractwin(winner);
  updatecontractwin(winner);
}

function canupdateweaponcontractstats() {
  if(getdvarint(#"enable_weapon_contract", 0) == 0) {
    return false;
  }

  if(!level.rankedmatch && !level.arenamatch) {
    return false;
  }

  return true;
}

function updateweaponcontractstart(player) {
  if(!canupdateweaponcontractstats()) {
    return;
  }

  if(player stats::get_stat(#"weaponcontractdata", #"starttimestamp") == 0) {
    player stats::set_stat(#"weaponcontractdata", #"starttimestamp", getutc());
  }
}

function updateweaponcontractwin(winner) {
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

function updateweaponcontractplayed() {
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

function updatecontractwin(winner) {
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

function registercontractwinevent(event) {
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

function updatelossstats(loser) {
  loser.pers[#"outcome"] = # "loss";
  loser stats::function_bb7eedf0(#"losses", 1);
  loser updatestatratio("wlratio", "wins", "losses");

  if(level.hardcoremode) {
    loser stats::function_bb7eedf0(#"losses_hc", 1);
    loser updatestatratio("wlratio_hc", "wins_hc", "losses_hc");
  }

  loser notify(#"loss");
}

function updatelosslatejoinstats(loser) {
  loser stats::function_bb7eedf0(#"losses", -1);
  loser stats::function_bb7eedf0(#"losses_late_join", 1);
  loser updatestatratio("wlratio", "wins", "losses");

  if(level.hardcoremode) {
    loser stats::function_bb7eedf0(#"losses_hc", -1);
    loser updatestatratio("wlratio_hc", "wins_hc", "losses_hc");
  }
}

function updatetiestats(loser) {
  loser stats::function_bb7eedf0(#"losses", -1);
  loser.pers[#"outcome"] = # "draw";
  loser stats::function_bb7eedf0(#"ties", 1);
  loser updatestatratio("wlratio", "wins", "losses");

  if(level.hardcoremode) {
    loser stats::function_bb7eedf0(#"losses_hc", -1);
    loser stats::function_bb7eedf0(#"ties_hc", 1);
    loser updatestatratio("wlratio_hc", "wins_hc", "losses_hc");
  }

  if(!level.disablestattracking) {
    if(level.hardcoremode === 1) {
      loser stats::set_stat_global(#"hash_4a226bdcff995085", 0);
    } else {
      loser stats::set_stat_global(#"cur_win_streak", 0);
    }

    if(level.var_73e51905 === 1) {
      loser stats::set_stat_global(#"hash_56a0e77eea02664d", 0);
    }
  }

  loser notify(#"tie");
}

function updatewinlossstats() {
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
      var_ced71946 = min(function_d68cdc5d(), placement.size);

      for(index = 1; index < var_ced71946; index++) {
        nexttopplayer = placement[index];
        updatewinstats(nexttopplayer);
      }

      foreach(player in players) {
        if(winner == player) {
          continue;
        }

        for(index = 1; index < var_ced71946; index++) {
          if(player == placement[index]) {
            break;
          }
        }

        if(index < var_ced71946) {
          continue;
        }

        if(level.rankedmatch && !level.leaguematch && player.pers[#"latejoin"] === 1) {
          updatelosslatejoinstats(player);
        }
      }
    }

    return;
  }

  if(function_d68cdc5d() > 1) {
    var_96974d12 = min(function_d68cdc5d(), level.var_eed7c027.size);

    foreach(team, ranking in level.var_eed7c027) {
      if(ranking <= var_96974d12) {
        winners = getplayers(team);

        foreach(winner in winners) {
          updatewinstats(winner);
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
      if(level.hardcoremode === 1) {
        player stats::set_stat_global(#"hash_4a226bdcff995085", 0);
      } else {
        player stats::set_stat_global(#"cur_win_streak", 0);
      }

      if(level.var_73e51905 === 1) {
        player stats::set_stat_global(#"hash_56a0e77eea02664d", 0);
      }
    }
  }
}

function backupandclearwinstreaks() {
  if(is_true(level.freerun)) {
    return;
  }

  self.pers[#"winstreak"] = self stats::get_stat_global(#"cur_win_streak");

  if(!level.disablestattracking) {
    if(level.hardcoremode === 1) {
      self.pers[#"hash_5396d3210ae83d7a"] = self stats::get_stat_global(#"hash_4a226bdcff995085");
      self stats::set_stat_global(#"hash_4a226bdcff995085", 0);
    } else {
      self stats::set_stat_global(#"cur_win_streak", 0);
    }

    if(level.var_73e51905 === 1) {
      self.pers[#"hash_130610255352357c"] = self stats::get_stat_global(#"hash_56a0e77eea02664d");
      self stats::set_stat_global(#"hash_56a0e77eea02664d", 0);
    }
  }

  self.pers[#"winstreakforgametype"] = self stats::function_ed81f25e(#"cur_win_streak");
  self stats::function_baa25a23(#"cur_win_streak", 0);
}

function restorewinstreaks(winner) {
  if(!level.disablestattracking) {
    winner stats::set_stat_global(#"cur_win_streak", winner.pers[#"winstreak"]);

    if(level.var_73e51905 === 1) {
      winner stats::set_stat_global(#"hash_56a0e77eea02664d", winner.pers[#"hash_130610255352357c"]);
    }

    if(level.hardcoremode === 1) {
      winner stats::set_stat_global(#"hash_4a226bdcff995085", winner.pers[#"hash_5396d3210ae83d7a"]);
    }
  }

  winner stats::function_baa25a23(#"cur_win_streak", isDefined(winner.pers[#"winstreakforgametype"]) ? winner.pers[#"winstreakforgametype"] : 0);
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

function trackattackerkill(name, rank, xp, prestige, xuid, weapon) {
  self endon(#"disconnect");
  attacker = self;
  waittillframeend();
  pixbeginevent(#"");

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

  if(isDefined(attacker.pers[#"nemesis_name"]) && attacker.pers[#"nemesis_name"] == name) {
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

function trackattackeedeath(attackername, rank, xp, prestige, xuid) {
  self endon(#"disconnect");
  waittillframeend();
  pixbeginevent(#"");

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

function default_iskillboosting() {
  return false;
}

function givekillstats(smeansofdeath, weapon, evictim, var_e7a369ea) {
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
    self iprintlnbold("<dev string:x58>");

    return;
  }

  pixbeginevent(#"");

  if(self === var_e7a369ea) {
    self activecamo::function_896ac347(weapon, #"kills", 1);
    self incpersstat(#"kills", 1, 1, 1);
    self.kills = self getpersstat(#"kills");
    self updatestatratio("kdratio", "kills", "deaths");

    if(!killstreaks::is_killstreak_weapon(weapon)) {
      self incpersstat(#"hash_766a818213440d53", 1, 0, 0);
    }

    if(level.hardcoremode === 1) {
      self incpersstat(#"kills_hc", 1, 1, 1);
      self updatestatratio("kdratio_hc", "kills_hc", "deaths_hc");
    }

    if(isDefined(evictim) && isPlayer(evictim) && isDefined(evictim.attackerdamage)) {
      if(isarray(evictim.attackerdamage) && isDefined(self.clientid) && isDefined(evictim.attackerdamage[self.clientid]) && evictim.attackerdamage.size == 1) {
        stats::function_dad108fa(#"direct_action_kills", 1);
      }
    }

    if(isDefined(self.origin) && isDefined(evictim.origin)) {
      var_40fd58bf = distancesquared(self.origin, evictim.origin) * 0.000645161;

      if(var_40fd58bf >= sqr(60)) {
        var_74e5763 = 4;
      } else if(var_40fd58bf >= sqr(40)) {
        var_74e5763 = 3;
      } else if(var_40fd58bf >= sqr(20)) {
        var_74e5763 = 2;
      } else if(var_40fd58bf >= sqr(10)) {
        var_74e5763 = 1;
      } else {
        var_74e5763 = 0;
      }

      self stats::function_6cdd992f(weapon.name, var_74e5763, 1);
    }

    if(sessionmodeismultiplayergame() && self armor::has_armor()) {
      self stats::function_8fb23f94("weapon_armor", #"armored_kills", 1);
      self stats::function_b04e7184("weapon_armor", #"best_kills");
      evictim stats::function_8fb23f94("weapon_armor", #"deaths", 1);
    }

    if(isDefined(level.var_c8453874)) {
      [[level.var_c8453874]](self, evictim, laststandparams);
    }

    vehicle = self getvehicleoccupied();

    if(isvehicle(vehicle) && vehicle.isphysicsvehicle) {
      seat = vehicle getoccupantseat(self);

      if(isDefined(seat)) {
        if(vehicle player_vehicle::function_f89e1149(seat)) {
          self stats::function_dad108fa(#"kills_vehicle_driver", 1);
        }

        if(seat > 0) {
          self stats::function_dad108fa(#"kills_vehicle_passenger", 1);
        }

        if(self.var_9ff5ff83 !== 1) {
          driverkills = self stats::get_stat_global(#"kills_vehicle_driver");
          passengerkills = self stats::get_stat_global(#"kills_vehicle_passenger");

          if(driverkills + passengerkills >= 100) {
            self giveachievement(#"mp_achievement_vehicle_kills");
            self.var_9ff5ff83 = 1;
          }
        }
      }
    }
  }

  if(isDefined(evictim) && isPlayer(evictim)) {
    self incpersstat(#"ekia", 1, 1, 1);
    self stats::function_e24eec31(weapon, #"ekia", 1);
    self stats::function_e24eec31(weapon, #"hash_14b7133a39a0456e", 1);
    self stats::function_e24eec31(weapon, #"hash_497df827743010c3", 1);
    self stats::function_e24eec31(weapon, #"hash_67536f932f6aeb36", 1);
    self stats::function_80099ca1(weapon.name, #"best_ekia");
    var_bb166c5e = stats::function_3f64434(weapon);
    self stats::function_6fb0b113(var_bb166c5e, #"best_ekia");

    if(level.hardcoremode === 1) {
      self incpersstat(#"ekia_hc", 1, 1, 1);
    }

    if(level.tournamentmatch === 1) {
      self stats::function_cc215323(#"hash_5f135c62c4abba27", 1);
      var_54b9b877 = self stats::function_ed81f25e(#"hash_5f135c62c4abba27");
      var_e4710965 = self stats::function_ed81f25e(#"hash_7aa5d966aaba6d3e");

      if(var_54b9b877 > var_e4710965) {
        self stats::function_baa25a23(#"hash_7aa5d966aaba6d3e", var_54b9b877);
      }
    }

    self contracts::player_contract_event(#"ekia", weapon, evictim);
    self.ekia = self getpersstat(#"ekia");
    self function_863d9af1(weapon);

    if(self.var_ba29f4f6 !== 1 && self stats::get_stat_global(#"ekia") >= 200) {
      self giveachievement(#"mp_achievement_eliminations");
      self.var_ba29f4f6 = 1;
    }
  }

  attacker = self;

  if(!killstreaks::is_killstreak_weapon(weapon)) {
    if(smeansofdeath === "MOD_HEAD_SHOT") {
      self activecamo::function_896ac347(weapon, #"headshots", 1);
      attacker thread incpersstat(#"headshots", 1, 1, 0);
      attacker.headshots = attacker.pers[#"headshots"];

      if(isDefined(evictim)) {
        level thread telemetry::function_18135b72(#"hash_37f96a1d3c57a089", {
          #player: evictim, #var_bdc4bbd2: # "headshot"});
      }

      if(attacker.headshots % 5 == 0) {
        self contracts::increment_contract(#"hash_ca75e54eb5e5ef8");
      }

      if(attacker.headshots % 3 == 0) {
        self stats::function_dad108fa(#"hash_1b9a630b78eba522", 1);
      }

      attacker stats::function_dad108fa(#"hash_185c3c78ebc24268", 1);
      weaponclass = util::getweaponclass(weapon);

      if(weaponclass === # "weapon_tactical") {
        attacker stats::function_dad108fa(#"hash_70d4e38a66f99086", 1);
        attacker stats::function_dad108fa(#"hash_70d4e48a66f99239", 1);
      }

      attacker stats::function_42277145(#"hash_734eed49f5390a8", 1);
    }
  }

  pixendevent();
}

function setinflictorstat(einflictor, eattacker, weapon) {
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
  currentweapon = self getcurrentweapon();
  scoreevents::processscoreevent(#"shield_assist", self, killedplayer, currentweapon);
}

function function_b1a3b359(killedplayer, damagedone, weapon, assist_level) {
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
      case # "hash_577b41452577c37f":
      case # "concussion_grenade":
        assist_level = "assist_concussion";
        break;
      case # "hash_af1a40bb1375dab":
      case # "flash_grenade":
        assist_level = "assist_flash";
        break;
      case # "hash_4cd586d22c20b3cf":
      case # "emp_grenade":
        assist_level = "assist_emp";
        break;
      case # "proximity_grenade":
      case # "proximity_grenade_aoe":
        assist_level = "assist_proximity";
        break;
    }

    self challenges::assisted();
    scoreevents::processscoreevent(assist_level, self, killedplayer, weapon);
    return;
  }

  self challenges::function_57ca42c6(weapon);
}

function function_672746e0(attacker, inflictor, weapon) {
  if(!isDefined(weapon) || !isDefined(weapon.team) || self util::isenemyplayer(weapon) == 0) {
    return false;
  }

  if(self == weapon || weapon.classname == "trigger_hurt" || weapon.classname == "worldspawn") {
    return false;
  }

  if(weapon.team == # "spectator") {
    return false;
  }

  return true;
}

function function_c2ea00b2(attacker, inflictor, weapon) {
  if(!function_672746e0(attacker, inflictor, weapon)) {
    return;
  }

  params = {
    #players: [], #attacker: attacker, #inflictor: inflictor, #weapon: weapon
  };

  foreach(player in getplayers()) {
    if(util::function_fbce7263(player.team, attacker.team)) {
      continue;
    }

    if(player == attacker) {
      continue;
    }

    if(player.sessionstate != "playing") {
      continue;
    }

    params.players[player getentitynumber()] = player;
  }

  callback::callback(#"hash_7c6da2f2c9ef947a", params);
}

function function_9779ac61() {
  if(level.scoreroundwinbased) {
    if(level.teambased) {
      foreach(team, _ in level.teams) {
        [[level._setteamscore]](team, game.stat[#"roundswon"][team]);
      }
    }
  }
}

function function_e7b4c25c(nemesis_name, value, nemesis_rank, var_15574043, nemesis_xp, nemesis_xuid) {
  if(!isDefined(self.pers[#"nemesis_tracking"][nemesis_name])) {
    self.pers[#"nemesis_tracking"][nemesis_name] = {
      #name: nemesis_name, #value: 0
    };
  }

  self.pers[#"nemesis_tracking"][nemesis_name].value += value;
  var_b5c193c6 = self.pers[#"nemesis_tracking"][self.pers[#"nemesis_name"]];

  if(self.pers[#"nemesis_name"] === "" || !isDefined(var_b5c193c6) || self.pers[#"nemesis_tracking"][nemesis_name].value > var_b5c193c6.value) {
    assert(isDefined(nemesis_name), "<dev string:xa2>" + self.name);
    assert(isstring(nemesis_name), "<dev string:xc6>" + nemesis_name + "<dev string:xd2>" + self.name);
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

function function_30ab51a4(params) {
  if(isDefined(self) && isDefined(self.pers)) {
    self.pers[#"hash_49e7469988944ecf"] = undefined;
    self.pers[#"hash_53919d92ff1d039"] = undefined;
  }
}

function set_character_spectate_on_index(params) {
  if(params.var_b66879ad === 0) {
    return;
  }

  function_30ab51a4(params);
}