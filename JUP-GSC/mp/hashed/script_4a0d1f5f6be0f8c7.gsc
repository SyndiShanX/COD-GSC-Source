/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4a0d1f5f6be0f8c7.gsc
*************************************************/

#using script_26ccbfe3954cacf4;
#using script_40e63dd222434655;
#using script_4a0d1f5f6be0f8c7;
#using script_59ff79d681bb860c;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_message;
#using scripts\mp\menus;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace namespace_11d8f65c2828dad8;

function main() {
  level.var_cdc15ee14362fbf = &namespace_bd131dfa920d03b9::init;
  scripts\mp\gametypes\br::main();
}

function init() {
  namespace_bc2665cbe6cf4e1f::function_5865e18adb02de38();
  level.var_2c93542553c664f5 = 0;
  level.var_472d7a6d15e57940 = 0;
  level.var_1d814f83596d0a02 = 0;
  level.var_c1d58bf29dcae79 = 1;
  level.minplunderdropondeath = getdvarint(@ "hash_e0a487b88d0e4410", 1);
  level.var_cc9e990b6e83975b = getdvarint(@ "hash_c39067c564e9be9", 1);
  disableloadout = getdvarint(@ "hash_4c8e33496c92cd2e", 0);

  if(disableloadout == 1) {
    scripts\mp\gametypes\br_gametypes::disablefeature("drogBagLoadout");
  }

  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("modifyPlayerDamage", &namespace_bc2665cbe6cf4e1f::function_92a85a0dda6ca085);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("getBestSpectateCandidate", &getbestspectatecandidate);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("isValidSpectateTarget", &isvalidspectatetarget);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onMarkPlayerAsEliminated", &onmarkplayeraseliminated);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onUnmarkPlayerAsEliminated", &onunmarkplayeraseliminated);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("getDefaultLoadout", &getdefaultloadout);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("kioskRevivePlayer", &function_b8ce7e76dc2dc587);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerWelcomeSplashes", &playerwelcomesplashes);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("GetRandomLoadout", &getrandomloadout);
  level.getplayerspawnangles = &getplayerspawnangles;
  level.var_cb87db3f189cf3f1 = &function_3363de115c63751d;
  level.quest_domdistmin = getdvarint(@ "hash_a733bbfd9d9909fe", 500);
  level.quest_domdistmax = getdvarint(@ "hash_a710cdfd9d72e9dc", 7000);
  level.quest_assdistmin = getdvarint(@ "hash_4512e59f0eae9", 500);
  level.quest_assdistmax = getdvarint(@ "hash_ffe1432e59ca8467", 7000);
  level.quest_scavdistmin = getdvarint(@ "hash_a607164e2c76e4f1", 500);
  level.quest_scavdistmax = getdvarint(@ "hash_a62a284e2c9d543f", 7000);
  level.shownonspectatingwinnersplash = 1;
  thread function_ced5973479a0e03b();
}

function function_ced5973479a0e03b() {
  level endon("game_ended");

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  while(true) {
    foreach(team in level.teamnamelist) {
      totalplunder = level.teamdata[team]["plunderTeamTotal"];
      players = scripts\mp\utility\teams::getfriendlyplayers(team, 0);

      foreach(player in players) {
        player setclientomnvar("ui_br_team_cash_pockets", totalplunder);
      }
    }

    waitframe();
  }
}

function getdefaultloadout() {
  var_dab2d2efde751b62 = "classtable:classtable_br_vanilla";
  return scripts\mp\gametypes\br::initstandardloadout(var_dab2d2efde751b62, 0);
}

function getplayerspawnangles() {
  if(istrue(level.skipprematch)) {
    return undefined;
  }

  if(scripts\mp\gamelogic::inprematch() && isDefined(level.var_c360d548f96125f2) && level.var_c360d548f96125f2.size > 0) {
    randomlookat = level.var_c360d548f96125f2[randomint(level.var_c360d548f96125f2.size)];
    return vectortoangles(randomlookat - self getEye());
  }

  return undefined;
}

function function_7e904ff184e6794c(var_9f4a3632d9f75d32, var_d4884966c59032e3, var_46ed5dc5c4434238, spawnangle, var_5623feabb8673fa2) {
  defaultpos = namespace_bc2665cbe6cf4e1f::function_ec232ea2a444176b((0, 0, 10000), level.br_level.c130_heightoverride);

  if(!isDefined(var_9f4a3632d9f75d32)) {
    activatelocation = getStruct("br_bot_activate_location", "script_noteworthy");

    if(isDefined(activatelocation)) {
      var_9f4a3632d9f75d32 = activatelocation.origin;
    } else {
      var_9f4a3632d9f75d32 = defaultpos;
    }
  }

  if(!isDefined(var_46ed5dc5c4434238)) {
    var_46ed5dc5c4434238 = defaultpos;
  }

  var_60b36839d21113f = scripts\mp\gametypes\br_public::isbrpracticemode();
  assert(!var_60b36839d21113f);
  skiptype = getdvarint(@ "hash_25ad2925d6075c8f", 0);

  if(skiptype != 0) {
    level.skipprematch = 1;

    if(skiptype == 2) {
      level.skipprematchdropspawn = 1;
      level.br_infils_disabled = 1;
      level thread function_f6e343c0b9912601();
      assert(isDefined(var_46ed5dc5c4434238));
      spawnangle = default_to(spawnangle, (0, 60, 0));
      spawns = [];
      spawns[spawns.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", var_46ed5dc5c4434238, spawnangle);
      scripts\mp\spawnlogic::addscriptedspawnpoints(spawns);
    }
  } else {
    var_d9d6c656a9fd19ac = 150;
    var_54401a32bf2a02b = scripts\mp\gametypes\br::function_cb40f77c51717ea1();
    var_32c7d201a42335ff = var_d9d6c656a9fd19ac / var_54401a32bf2a02b;
    var_78de90a02fd7622b = namespace_95d8d8ec67e3e074::function_d6d3f0e8a701880f();
    level.var_2f78f22edf92faa9 = ceil(var_78de90a02fd7622b / var_32c7d201a42335ff);
  }

  level.br_level.var_61321b51908d55cb = "classtable:classtable_br_bot_loadouts_phase1";
  level.br_level.var_61321c51908d57fe = "classtable:classtable_br_bot_loadouts_phase2";
  level.br_standard_loadout = getdefaultloadout();
  level.var_5623feabb8673fa2 = var_5623feabb8673fa2;
  function_900efe56e44a6c12();
  namespace_95d8d8ec67e3e074::initialize(var_9f4a3632d9f75d32);

  if(isDefined(var_d4884966c59032e3) && var_d4884966c59032e3 > 0) {
    setDvar(@ "hash_749412e5db698400", var_d4884966c59032e3);
  }

  level thread namespace_bc2665cbe6cf4e1f::function_c38398385afc10fc();
}

function function_f6e343c0b9912601() {
  level waittill("player_spawned", player);
  player setclientomnvar("ui_br_infiled", 1);
  level waittill("infils_ready");
  level.br_c130spawndone = 1;
  player scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  player scripts\mp\gametypes\br_weapons::br_give_starting_ammo();
  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(player);
  player skydive_setdeploymentstatus(1);
  player skydive_setbasejumpingstatus(1);
}

function function_900efe56e44a6c12() {
  rawzones = getStructArray("br_bot_landing_group", "script_noteworthy");
  var_3a1b0d8a5d8da62a = 0;

  if(rawzones.size == 0 && isDefined(level.landingspots) && level.landingspots.size > 0) {
    rawzones = level.landingspots;
    var_3a1b0d8a5d8da62a = 1;
  }

  assertex(rawzones.size > 0, "<dev string:x1c>");
  zones = [];
  level.var_c360d548f96125f2 = [];

  foreach(rawzone in rawzones) {
    zone = spawnStruct();
    zone.name = rawzone.target;
    zone.centralpoint = rawzone.origin;
    zone.weight = int(rawzone.script_parameters);

    if(zone.weight <= 0) {
      assertmsg("<dev string:x43>" + zone.name + "<dev string:x63>");
      zone.weight = 1;
    }

    zone.landingspots = [];
    zones[zones.size] = zone;
    landingspots = [];

    if(!var_3a1b0d8a5d8da62a) {
      landingspots = rawzone get_target_array();
    }

    landingspots[landingspots.size] = rawzone;

    foreach(landingspot in landingspots) {
      struct = spawnStruct();
      struct.origin = getclosestpointonnavmesh(landingspot.origin);
      zone.landingspots[zone.landingspots.size] = struct;
      var_49e421b4bf8cf977 = 0;

      if(var_49e421b4bf8cf977) {
        level.var_c360d548f96125f2[level.var_c360d548f96125f2.size] = landingspot.origin;
      }
    }
  }

  level.botzones = spawnStruct();
  level.botzones.zones = zones;
  level thread function_b0d6c85d2f044e95();
}

function function_b0d6c85d2f044e95() {
  function_514703d9665f6f93();

  if(istrue(level.br_infils_disabled)) {
    return;
  }

  level waittill("br_c130_in_bounds");
  function_74149d8336258367();
  level waittill("br_c130_left_bounds");
  function_514703d9665f6f93();
}

function function_514703d9665f6f93() {
  zones = level.botzones.zones;
  sum = 0;

  for(index = 0; index < zones.size; index++) {
    zone = zones[index];

    if(isDefined(zone)) {
      sum += zone.weight;
      zone.var_68e87685aa19da24 = sum;
    }
  }

  level.botzones.sumweight = sum;
}

function function_74149d8336258367() {
  var_da9d0b7a05252ce1 = 100;
  zones = level.botzones.zones;
  sumweight = 0;
  startpoint = level.infilstruct.c130pathstruct.startpt;
  endpoint = level.infilstruct.c130pathstruct.endpt;
  maxdistance = level.var_5623feabb8673fa2;

  if(isDefined(maxdistance)) {
    maxdistancesq = 1 * maxdistance * maxdistance;
  } else {
    maxdistancesq = undefined;
  }

  for(index = 0; index < zones.size; index++) {
    zone = zones[index];
    weight = zone.weight;

    if(isDefined(maxdistancesq)) {
      linetopoint = vectorfromlinetopoint(startpoint, endpoint, zone.centralpoint);
      distancesq = length2dsquared(linetopoint);

      if(distancesq <= maxdistancesq) {
        weight *= var_da9d0b7a05252ce1;
      }
    }

    if(scripts\mp\gametypes\br_circle::function_c11714256f856e10(zone.centralpoint)) {
      weight *= var_da9d0b7a05252ce1;
    }

    sumweight += weight;
    zone.var_68e87685aa19da24 = sumweight;
  }

  level.botzones.sumweight = sumweight;
}

function getbestspectatecandidate(victim, attacker) {
  playertospectate = undefined;

  if(isvalidspectatetarget(victim.nextplayertospectate)) {
    playertospectate = victim.nextplayertospectate;
    victim.nextplayertospectate = undefined;
    return playertospectate;
  }

  playertospectate = function_c041447b9139985b(victim);

  if(isvalidspectatetarget(playertospectate)) {
    return playertospectate;
  }

  if(isvalidspectatetarget(attacker)) {
    return attacker;
  }

  var_b0dfeeb00d0acf03 = balancespectators(victim);

  if(isDefined(var_b0dfeeb00d0acf03)) {
    return var_b0dfeeb00d0acf03;
  }

  var_1d17d55b8c1ec9cf = undefined;

  foreach(bot in level.players) {
    if(bot != victim && isvalidspectatetarget(bot)) {
      if(!bot namespace_95d8d8ec67e3e074::function_d012729eac1e7053()) {
        return bot;
      }

      if(!isDefined(var_1d17d55b8c1ec9cf)) {
        var_1d17d55b8c1ec9cf = bot;
      }
    }
  }

  if(isDefined(var_1d17d55b8c1ec9cf)) {
    return var_1d17d55b8c1ec9cf;
  }

  return undefined;
}

function isvalidspectatetarget(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(player namespace_95d8d8ec67e3e074::isuibot()) {
    return false;
  }

  if(!isaliveplayer(player)) {
    return false;
  }

  if(istrue(player.var_7ca8ac9793bc9c22)) {
    return false;
  }

  return !istrue(player.br_iseliminated);
}

function function_c041447b9139985b(victim) {
  if(istrue(level.onlinegame) && isDefined(victim) && victim getprivatepartysize()) {
    var_aa90f92ce9f7f1de = victim getfireteammembers();
    var_cad1692006efd64a = undefined;

    foreach(player in var_aa90f92ce9f7f1de) {
      if(player == victim) {
        continue;
      }

      if(player isfireteamleader() && isvalidspectatetarget(player)) {
        return player;
      }
    }

    var_cad1692006efd64a = undefined;
    closestdist = undefined;

    foreach(player in var_aa90f92ce9f7f1de) {
      if(victim != player && isvalidspectatetarget(player)) {
        if(isDefined(victim.lastdeathpos)) {
          var_12810e24e83acb1d = distance2dsquared(victim.lastdeathpos, player.origin);

          if(!isDefined(closestdist) || var_12810e24e83acb1d < closestdist) {
            var_cad1692006efd64a = player;
            closestdist = var_12810e24e83acb1d;
          }

          continue;
        }

        return player;
      }
    }

    if(isDefined(var_cad1692006efd64a)) {
      return var_cad1692006efd64a;
    }
  }

  botcandidate = undefined;

  if(isDefined(victim.team)) {
    teammates = scripts\mp\utility\teams::getfriendlyplayers(victim.team, 1);

    if(isDefined(victim.lastdeathpos)) {
      var_e9dc9ecbe66722fe = undefined;
      var_2854e504ec9ed2bd = undefined;
      closestdist = undefined;

      foreach(player in teammates) {
        var_12810e24e83acb1d = distance2dsquared(victim.lastdeathpos, player.origin);

        if(function_78e25eb20dbfe396(player)) {
          if(!isDefined(var_2854e504ec9ed2bd) || var_12810e24e83acb1d < var_2854e504ec9ed2bd) {
            var_e9dc9ecbe66722fe = player;
            var_2854e504ec9ed2bd = var_12810e24e83acb1d;
          }

          continue;
        }

        if(!isDefined(var_e9dc9ecbe66722fe) && isvalidspectatetarget(player)) {
          if(!isDefined(closestdist) || var_12810e24e83acb1d < closestdist) {
            botcandidate = player;
            closestdist = var_12810e24e83acb1d;
          }
        }
      }

      if(isDefined(var_e9dc9ecbe66722fe)) {
        return var_e9dc9ecbe66722fe;
      }
    } else {
      foreach(player in teammates) {
        if(function_78e25eb20dbfe396(player)) {
          return player;
        }

        if(isvalidspectatetarget(player)) {
          botcandidate = player;
        }
      }
    }
  }

  return botcandidate;
}

function balancespectators(victim) {
  playertospectate = undefined;
  var_45c781aa56fc57ec = level.players.size;

  foreach(player in level.players) {
    if(player != victim && function_78e25eb20dbfe396(player)) {
      spectators = scripts\mp\gametypes\br_spectate::getspectatorsofplayer(player);

      if(spectators.size < var_45c781aa56fc57ec) {
        var_45c781aa56fc57ec = spectators.size;
        playertospectate = player;
      }
    }
  }

  return playertospectate;
}

function function_78e25eb20dbfe396(player) {
  if(!isDefined(player) || isai(player)) {
    return false;
  }

  if(!isaliveplayer(player)) {
    return false;
  }

  return !istrue(player.br_iseliminated);
}

function function_6f2a3c608d954d4(immediate) {
  uibots = namespace_95d8d8ec67e3e074::function_749723c2a45a0233();
  teammembers = scripts\mp\utility\teams::getteamdata(self.team, "players");

  if(!istrue(immediate)) {
    foreach(member in teammembers) {
      if(!member namespace_bc2665cbe6cf4e1f::iseliminated() && member != self) {
        return;
      }
    }

    foreach(uibot in uibots) {
      if(uibot.team == self.team) {
        return;
      }
    }
  }

  totalplayers = level.players.size;
  activeteams = [];

  for(i = 0; i < totalplayers; i++) {
    player = level.players[i];

    if(!player namespace_bc2665cbe6cf4e1f::iseliminated() && player.team != self.team) {
      activeteams[player.team] = 1;
    }
  }

  foreach(uibot in uibots) {
    if(uibot.team != self.team) {
      activeteams[uibot.team] = 1;
    }
  }

  place = activeteams.size + 1;

  foreach(member in teammembers) {
    member.pers["br_place"] = place;
  }

  self.pers["br_place"] = place;
}

function function_305f60799dc60d7c(player) {
  player function_6f2a3c608d954d4();
  player.pers["br_survival_time"] = gettime() - level.starttime;
}

function onmarkplayeraseliminated(player) {
  function_305f60799dc60d7c(player);
}

function onunmarkplayeraseliminated(player) {
  player.pers["br_place"] = 0;
  player.pers["br_survival_time"] = 0;
}

function getrandomloadout() {
  var_b84a7e9373dcbe39 = 10;
  newclass = randomint(var_b84a7e9373dcbe39);

  if(getomnvar("ui_only_default_loadouts") == 1) {
    var_d7d1c6c477af4621 = 100;
    newclass += var_d7d1c6c477af4621;
  }

  newclasschoice = scripts\mp\menus::getclasschoice(newclass);
  self.pers["class"] = newclasschoice;
  self.class = newclasschoice;
  scripts\mp\class::preloadandqueueclass(newclasschoice);
  return true;
}

function function_b8ce7e76dc2dc587(player, usetoken) {
  scripts\mp\gametypes\br_gulag::playergulagautowin("vanillaKioskRevive", player, usetoken);
  scripts\mp\gametypes\br_plunder::playersetplundercount(0);
}

function function_3363de115c63751d(var_a37e3649cfb19f73, var_ac0f8be89fa21057) {
  var_2a05c2d2d4716320 = getdvarint(@ "hash_2d936fb12b19ca30", 0);

  if(var_2a05c2d2d4716320) {
    counttime = clamp(var_a37e3649cfb19f73 - var_ac0f8be89fa21057, 0, 65535);
    setomnvar("ui_match_start_countdown_not_reach_minplayer", int(counttime));
  }
}

function playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  gametype = scripts\mp\utility\game::getsubgametype();

  if(gametype == "mini_mgl") {
    scripts\mp\hud_message::showsplash("br_gametype_mini_prematch_welcome");
  } else if(gametype == "resurgence_mgl") {
    scripts\mp\hud_message::showsplash("br_gametype_resurgence_prematch_welcome");
  } else if(gametype == "champion") {
    scripts\mp\hud_message::showsplash("br_gametype_champion_prematch_welcome");
  } else if(!istrue(game["liveLobbyCompleted"])) {
    scripts\mp\hud_message::showsplash("br_prematch_welcome");
  }

  if(!istrue(level.br_infils_disabled)) {
    thread function_79d674479a5744bb();
  }

  if(!istrue(self.infil_landing_done)) {
    self waittill("infil_landing_done");
  }

  wait 1;

  if(gametype == "mini_mgl") {
    scripts\mp\hud_message::showsplash("br_gametype_mini_mgl_welcome");
  }

  scripts\mp\gametypes\br_public::brleaderdialogplayer("primary_objective", self, 0);
}

function function_79d674479a5744bb() {
  self waittill("infil_move");
  gametype = scripts\mp\utility\game::getsubgametype();

  if(gametype == "mini_mgl") {
    scripts\mp\hud_message::showsplash("br_gametype_mini_mgl_match_introduction");
    return;
  }

  if(gametype == "resurgence_mgl") {
    scripts\mp\hud_message::showsplash("br_gametype_resurgence_match_introduction");
    return;
  }

  if(gametype == "champion") {
    scripts\mp\hud_message::showsplash("br_gametype_champion_match_introduction");
    return;
  }

  scripts\mp\hud_message::showsplash("br_gametype_vanilla_match_introduction");
}