/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_19633385c373011d.gsc
*************************************************/

#using script_303fd53078a244f1;
#using script_4a0d1f5f6be0f8c7;
#using script_5bab271917698dc4;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_champion_task;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_killstreaks;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_rewards;
#using scripts\mp\gametypes\br_skydive_protection;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\music_and_dialog;
#using scripts\mp\outofbounds;
#using scripts\mp\perks\perks;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_304d296a920c310e;

function autoexec main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "champion") {
    return;
  }

  init();
}

function init() {
  namespace_bd131dfa920d03b9::init();
  level thread initfeatures();
  level thread initpostmain();
  level thread initdialog();
  setdvarifuninitialized(@ "hash_98fad011285f3011", 0);
  setdvarifuninitialized(@ "scr_br_project_kick", 1500);
  level thread initrespawn();
  level thread function_90066bc128fbd493();
  namespace_a5b4009d7c2e0b3d::init();
  scripts\mp\gametypes\br_champion_task::init();
  level.brdisablefinalkillcam = 1;
  level.var_c5dc0e983c929728 = getdvarint(@ "hash_58e2b234d0a26865", 0);
}

function initrespawn() {
  setomnvar("ui_br_resurgence_respawn_enabled", 1);
  initloadouts("mp/classtable_br_resurgence_mgl.csv");
  initloadouts("mp/classtable_br_resurgence_mgl_circle2.csv");
  initloadouts("mp/classtable_br_resurgence_mgl_circle3.csv");
  level.brgametype.var_6420b42c7add53cc = getdvarint(@ "hash_d2891d4180de0553", 1);
  level.brgametype.usevengeance = getmatchrulesdata("brData", "resurgenceUseVengeance");
  level.brgametype.vengeanceuseanykill = getmatchrulesdata("brData", "resurgenceVengeanceUseAnyKill");
  level.brgametype.usevengeancedecreaserespawntimer = getmatchrulesdata("brData", "resurgenceUseVengeanceDecreaseRespawnTimer");
  level.brgametype.var_fc3b5a2e206a85f2 = getdvarint(@ "hash_9a00313371f55de1", 0);
  level.brgametype.usepointstoreducerespawntime = getmatchrulesdata("brData", "resurgenceUsePointsToReduceRespawnTime");
  level.brgametype.aircraftmaxallowed = getdvarfloat(@ "hash_6772e6c744d1d962", 30);
  level.brgametype.var_59af2e5140d3fed7 = getdvarfloat(@ "hash_e9b60187d57107b9", 1);
  level.respawnheightoverride = getdvarint(@ "scr_bmo_respawnheightoverride", 7500);
  level.brgametype.var_a916b204f027af6b = getdvarint(@ "hash_a91b489383d89274", 0);
  level.brgametype.var_6f3c4d74a8c614ab = getdvarint(@ "hash_38aff65bda44b82a", 1);
  level.brgametype.var_b43745b85f249e68 = 1;
  scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af("mayConsiderPlayerDead");
  scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af("onMarkPlayerAsEliminated");
  scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af("getDefaultLoadout");
  scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af("kioskRevivePlayer");
  scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af("onPlayerKilled");
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("circleTimer", &circletimer);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("mayConsiderPlayerDead", &brmayconsiderplayerdead);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("triggerRespawnOverlay", &triggerrespawnoverlay);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerNakedDropLoadout", &playernakeddroploadout);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("getDefaultLoadout", &getdefaultloadout);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("kioskRevivePlayer", &kioskreviveplayer);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("dropOnPlayerDeath", &droponplayerdeath);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onMarkPlayerAsEliminated", &onmarkplayeraseliminated);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onCloseCircleCompleted", &onclosecirclecompleted);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPlayerKilled", &function_735fe9ec0c4dd312);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onDeadEvent", &ondeadevent);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerGetRespawnPoint", &playergetrespawnpoint);
  waittillframeend();

  if(level.brgametype.usepointstoreducerespawntime) {
    level.var_5dfd73c97bf5d03d = &function_5dfd73c97bf5d03d;
  }

  level.var_484f1a4bdb5cda1e = &function_a2131d000491ae2c;
  function_641eee023180065();
  thread function_49a4f952ccb3fd45();
  thread setupteamtrack();
  thread function_aaacd0f0a1d84290();
  thread function_e003a419d3914c23();
  thread function_2573e08a439335f7();
}

function function_90066bc128fbd493() {
  level endon("game_ended");
  level waittill("prematch_done");
  scripts\mp\gametypes\br_circle::function_4448b165e1f42719(4);
  scripts\mp\gametypes\br_circle::registercirclecallbacks(4, &scripts\mp\gametypes\br_armory_kiosk::dangercircletick);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&namespace_a5b4009d7c2e0b3d::function_c9a0784e88fcf18d);
}

function triggerovertime() {
  if(!istrue(level.overtimestarted)) {
    level.canprocessot = 1;
    level.ontimelimitgraceperiod = getdvarfloat(@ "hash_b1dc99c22b12bd63", 0);
    level.currenttimelimitdelay = 0;
    level.overtimestarted = level.ontimelimitgraceperiod > 0;
    level.setallclientomnvarot = level.overtimestarted;
    level.forceotlogictorun = level.overtimestarted;
    scripts\mp\hud_util::showsplashtoall("br_champion_overtime_activated");
    level thread scripts\mp\music_and_dialog::function_283a36147406b42f();
  }
}

function initfeatures() {
  if(getdvarint(@ "hash_5a1dae481ef5d089", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::enablefeature("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::disablefeature("gulag");
  scripts\mp\gametypes\br_gametypes::disablefeature("randomizeCircleCenter");
  scripts\mp\gametypes\br_gametypes::disablefeature("planeSnapToOOB");
  scripts\mp\gametypes\br_gametypes::enablefeature("planeUseCircleRadius");
  scripts\mp\gametypes\br_gametypes::enablefeature("circleEarlyStart");
}

function initpostmain() {
  scripts\engine\utility::registersharedfunc("champion", "packClientMatchData", &packclientmatchdata);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("createC130PathStruct", &createc130pathstruct);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("addToC130Infil", &addtoc130infil);
  level.bots_gametype_handles_class_choice = 0;

  if(getdvarint(@ "hash_bb3cfa989a77b2c5", 1) == 1) {
    thread setdropbagdelay();
  }

  waittillframeend();
  level.ontimelimit = &ontimelimit;
  cleanupents();
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
}

function function_b79b55c5a0aaa08(player_ref, state, missionid, var_c08e41851ed100e8) {
  player = player_ref getentitynumber();

  if(!isDefined(state)) {
    state = 0;
  }

  if(!isDefined(player)) {
    player = 0;
  }

  if(!isDefined(missionid)) {
    missionid = 0;
  }

  statebits = 4;
  playershift = statebits;
  playerbits = 8;
  var_d8354a49cc36aa44 = playershift + playerbits;
  var_d950a79d86f32708 = 16;
  var_d5f8c4084a83331b = 0;
  var_3faa24937366bd8c = var_d8354a49cc36aa44 + var_d950a79d86f32708;

  foreach(reviveplayer in var_c08e41851ed100e8) {
    var_d5f8c4084a83331b |= reviveplayer << var_3faa24937366bd8c;
    var_3faa24937366bd8c++;
  }

  value = 0;
  value = var_d5f8c4084a83331b | missionid << var_d8354a49cc36aa44 | player << playershift | state;
  self setclientomnvar("ui_br_expanded_obit_message", value);
}

function function_4bb3153d2bc88c04(team, player_ref, state, missionid, var_c08e41851ed100e8) {
  foreach(player in getteamdata(team, "players")) {
    player function_b79b55c5a0aaa08(player_ref, state, missionid, var_c08e41851ed100e8);
  }
}

function function_a380c47216dc87a7(attacker, killedtarget, var_73cacd5a645aab1f) {
  if(getdvarint(@ "hash_5b0a580d2ed6f60e", 1) == 0) {
    return;
  }

  killedtargetentnum = killedtarget getentitynumber();
  attackerentnum = attacker getentitynumber();
  var_af9cbb6cb7344131 = [];
  index = 1;
  teamplayers = getteamdata(level.players[attackerentnum].team, "players");

  foreach(entry in teamplayers) {
    if(entry == level.players[attackerentnum]) {
      var_af9cbb6cb7344131[index] = 0;
      index++;
      continue;
    }

    var_af9cbb6cb7344131[index] = 0;

    foreach(playerrevived in var_73cacd5a645aab1f) {
      if(entry == playerrevived) {
        var_af9cbb6cb7344131[index] = 1;
        break;
      }
    }

    index++;
  }

  for(var_ac61d946afdba08b = index; var_ac61d946afdba08b < 4; var_ac61d946afdba08b++) {
    var_af9cbb6cb7344131[var_ac61d946afdba08b] = 0;
  }

  function_4bb3153d2bc88c04(level.players[attackerentnum].team, level.players[attackerentnum], 15, killedtargetentnum, var_af9cbb6cb7344131);
}

function initdialog() {
  level endon("game_ended");
  game["dialog"]["match_start"] = "gametype_resurgence";
  game["dialog"]["match_desc"] = "gametype_desc_resurgence";
  game["dialog"]["last_man_standing"] = "rsrg_squad_last_alive";
  game["dialog"]["champion_avenge_teammate"] = "resurgence_avenge_teammate";
  game["dialog"]["champion_redeploy"] = "resurgence_redeploy";
  game["dialog"]["champion_disabled"] = "resurgence_reinforcement_disabled";
  game["dialog"]["champion_ending"] = "resurgence_reinforcement_ending";
  game["dialog"]["champion_teammate_respawn"] = "resurgence_teammate_respawn";
}

function function_747b066379119d51() {
  game["dialog"]["last_man_standing"] = "resurgence_last_alive";
}

function cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

function function_49a4f952ccb3fd45() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.brgametype.respawnenable = 1;
  level.var_843573804b98eb7e = 1;
}

function setupteamtrack() {
  waittillframeend();
  allteam = level.allteamnamelist;

  foreach(index, team in allteam) {
    level.teamdata[team]["index"] = index;
  }

  var_840b848760f488a4 = getdvarint(@ "hash_96c8e4682ff85b5f", 0);

  if(istrue(var_840b848760f488a4)) {
    foreach(name, team in level.teamdata) {
      level.teamdata[name]["trackedTeams"] = [];
    }

    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(player in level.players) {
    player.trackedteams = [];
  }
}

function function_aaacd0f0a1d84290() {
  foreach(name, team in level.teamdata) {
    level.teamdata[name]["deadPlayers"] = [];
  }
}

function function_ec09c585da4071ed(reason) {
  winner = namespace_a5b4009d7c2e0b3d::gethighestscoringteam();
  level thread scripts\mp\gamelogic::endgame(winner, reason);
}

function ontimelimit() {
  if(!isDefined(level.ontimelimitgraceperiod)) {
    level triggerovertime();
    return;
  }

  foreach(entry in level.teamnamelist) {
    scripts\mp\gametypes\br::setaardata(entry);
  }

  function_ec09c585da4071ed(game["end_reason"]["time_limit_reached"]);
}

function brmayconsiderplayerdead(player) {
  if(scripts\mp\flags::gameflag("prematch_done") && scripts\mp\flags::gameflag("prematch_fade_done")) {
    player thread waitrespawn();

    if(!istrue(level.brgametype.var_b43745b85f249e68)) {
      scripts\mp\gametypes\br_utility::markplayeraseliminated(player);
    }
  }

  return true;
}

function ondeadevent(team) {
  return true;
}

function packclientmatchdata() {
  if(!isDefined(self.var_11e422333cb859e)) {
    self.var_11e422333cb859e = 0;
  }

  packedvalue = self.var_11e422333cb859e;

  if(packedvalue > 255) {
    packedvalue = 255;
  }

  self.extrascore0 = packedvalue;
  self.pers["extrascore0"] = packedvalue;
  return packedvalue;
}

function function_348449f96ff7cef8(teamdata, var_75c8cc005e7e9f3) {
  var_2f945dac0cd1edcb = !istrue(level.teamdata[self.team]["teamHadFirstRevive"]);

  if(var_2f945dac0cd1edcb) {
    level.teamdata[self.team]["teamHadFirstRevive"] = 1;
  }

  foreach(aliveteammate in teamdata) {
    if(!isDefined(aliveteammate.var_11e422333cb859e)) {
      aliveteammate.var_11e422333cb859e = 0;
    }

    aliveteammate.var_11e422333cb859e++;
    aliveteammate scripts\mp\gametypes\br_public::updatebrscoreboardstat("reviveCount", aliveteammate.var_11e422333cb859e);
    aliveteammate packclientmatchdata();
    var_75a087e96d31ddc5 = !isDefined(var_75c8cc005e7e9f3) || aliveteammate != var_75c8cc005e7e9f3;
    var_4b59e709fd5bcc45 = var_2f945dac0cd1edcb && var_75a087e96d31ddc5;

    if(var_4b59e709fd5bcc45) {
      aliveteammate thread scripts\mp\hud_message::showsplash("br_resurgence_first_revive", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp_mgl");
    }
  }
}

function kioskreviveplayer(var_84e2123aaca9a965, tokenused) {
  var_c7869d69dbcf7fd3 = self;
  var_c7869d69dbcf7fd3 thread scripts\mp\gametypes\br_gulag::playergulagautowin("championKioskRevive", var_84e2123aaca9a965, tokenused);
  var_c7869d69dbcf7fd3 function_348449f96ff7cef8(level.teamdata[var_c7869d69dbcf7fd3.team]["alivePlayers"], var_84e2123aaca9a965);
  function_1f8da2719751fc5f();
}

function droponplayerdeath(attacker) {
  if(istrue(level.brgametype.loadoutrestore) && !isDefined(self.savedloadout)) {
    scripts\mp\gametypes\br::function_10ffa1071b1c2681();
  }

  return false;
}

function onmarkplayeraseliminated(player) {
  namespace_bd131dfa920d03b9::function_305f60799dc60d7c(player);
}

function function_735fe9ec0c4dd312(deathdata) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  if(!isDefined(deathdata.victim)) {
    return;
  }

  thread scripts\mp\gametypes\br_gametypes::runbrgametypefunc("preOnPlayerKilled", deathdata);

  if(!isDefined(deathdata.attacker) || !isPlayer(deathdata.attacker) || deathdata.attacker == deathdata.victim) {
    return;
  }

  alivecount = getteamdata(deathdata.attacker.team, "aliveCount");

  if(alivecount <= 0) {
    return;
  }

  deathdata.attacker function_ff9954eb6fa229a8(deathdata.attacker.team, deathdata.victim.team);
  deathdata.attacker thread function_7af0dacee64943c2(deathdata.attacker.team, deathdata.victim);
}

function function_ff9954eb6fa229a8(trackerteam, trackedteam) {
  if(!level.brgametype.var_6420b42c7add53cc) {
    return;
  }

  trackteam(trackerteam, trackedteam);
}

function function_7af0dacee64943c2(team, potentialkiller) {
  level endon("game_ended");

  if(!level.brgametype.usevengeance) {
    return;
  }

  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  alivecount = getteamdata(team, "aliveCount");

  if(alivecount <= 0) {
    return;
  }

  var_d0b996fde8bfc937 = level.teamdata[team]["deadPlayers"];

  if(var_d0b996fde8bfc937.size <= 0) {
    return;
  }

  var_4e776a22240ff174 = function_c033ab6f3faa6fca(var_d0b996fde8bfc937, potentialkiller);
  function_5535ff78fc16526e(var_4e776a22240ff174, potentialkiller);
}

function function_c033ab6f3faa6fca(var_d0b996fde8bfc937, potentialkiller) {
  var_4e776a22240ff174 = [];

  if(istrue(level.brgametype.vengeanceuseanykill)) {
    foreach(item in var_d0b996fde8bfc937) {
      if(!isDefined(item)) {
        continue;
      }

      var_4e776a22240ff174 = array_add(var_4e776a22240ff174, item);
      break;
    }
  } else {
    foreach(item in var_d0b996fde8bfc937) {
      if(!isDefined(item)) {
        continue;
      }

      if(isDefined(item.killer) && item.killer == potentialkiller && isDefined(item.player)) {
        var_4e776a22240ff174 = array_add(var_4e776a22240ff174, item.player);
      }
    }
  }

  return var_4e776a22240ff174;
}

function function_5535ff78fc16526e(var_4e776a22240ff174, killedtarget) {
  if(var_4e776a22240ff174.size <= 0) {
    return;
  }

  foreach(teammate in var_4e776a22240ff174) {
    if(!isDefined(teammate)) {
      continue;
    }

    avenge(teammate);
  }

  if(!istrue(level.brgametype.usevengeancedecreaserespawntimer)) {
    function_a380c47216dc87a7(self, killedtarget, var_4e776a22240ff174);
  }

  thread scripts\mp\events::killeventtextpopup("br_resurgence_vengeance", 0, 0);
  scripts\mp\gametypes\br_public::brleaderdialogplayer("champion_avenge_teammate", self);
}

function avenge(var_92a674d94df29e77) {
  if(istrue(level.brgametype.usevengeancedecreaserespawntimer)) {
    var_92a674d94df29e77.respawndelay -= getmatchrulesdata("brData", "resurgenceVengeanceDecreaseRespawnDelay");
    return;
  }

  var_92a674d94df29e77 thread doingrespawn(1, level.teamdata[var_92a674d94df29e77.team]["alivePlayers"]);
}

function function_6f0f4e7b3ff7b57c(trackedteams) {
  oldestindex = -1;
  oldesttime = 2147483647;

  foreach(arrayindex, trackedteam in trackedteams) {
    if(trackedteam["startTime"] < oldesttime) {
      oldestindex = arrayindex;
      oldesttime = trackedteam["startTime"];
    }
  }

  return oldestindex;
}

function function_85fee305e2d829c1(array, teamname) {
  foundindex = -1;

  foreach(index, team in array) {
    if(team["name"] == teamname) {
      foundindex = index;
      break;
    }
  }

  return foundindex;
}

function function_611500f4751aaf1(bitfield, teamindex, arrayindex) {
  var_5ba62be302f54d98 = int(pow(2, 8));
  assertex(level.teamdata.size < var_5ba62be302f54d98, "<dev string:x1c>" + level.teamdata.size + "<dev string:x28>" + 8 + "<dev string:x48>");
  assertex(teamindex < var_5ba62be302f54d98, "<dev string:x60>" + var_5ba62be302f54d98 - 1 + "<dev string:x94>" + level.teamdata.size + "<dev string:xa3>");
  assertex(arrayindex >= 0 && arrayindex < 4, "<dev string:xad>");
  leftshift = 8 * arrayindex;
  bitmask = var_5ba62be302f54d98 - 1;
  bitmask <<= leftshift;
  var_f8f977081d3da8b4 = ~bitmask;
  bitfield &= var_f8f977081d3da8b4;
  var_1cc902f24ef7cc11 = teamindex << leftshift;
  bitfield |= var_1cc902f24ef7cc11;
  return bitfield;
}

function function_d6d795db2cae2c1b(var_29412b34af141c29, trackedteamindex, var_8db0c8d0a8da2329) {
  bitfield = -1;

  foreach(player in var_29412b34af141c29) {
    if(isDefined(player)) {
      if(bitfield < 0) {
        bitfield = player getclientomnvar("ui_br_resurgence_tracked_teams");
        bitfield = function_611500f4751aaf1(bitfield, trackedteamindex, var_8db0c8d0a8da2329);
      }

      player setclientomnvar("ui_br_resurgence_tracked_teams", bitfield);
    }
  }
}

function function_f6686365221e78cb() {
  var_840b848760f488a4 = getdvarint(@ "hash_96c8e4682ff85b5f", 0);
  trackedteams = [];

  if(istrue(var_840b848760f488a4)) {
    trackedteams = getteamdata(self.team, "trackedTeams");
  } else {
    if(!isDefined(self.trackedteams)) {
      self.trackedteams = [];
    }

    trackedteams = self.trackedteams;
  }

  return trackedteams;
}

function trackteam(trackerteam, trackedteam) {
  addindex = -1;
  trackedteams = function_f6686365221e78cb();
  addindex = function_85fee305e2d829c1(trackedteams, trackedteam);

  if(addindex < 0) {
    if(trackedteams.size == 4) {
      addindex = function_6f0f4e7b3ff7b57c(trackedteams);
    } else {
      addindex = trackedteams.size;
    }
  }

  if(addindex < 0 || addindex >= 4) {
    return;
  }

  thread function_7ca4d46dfe174e90(trackerteam, trackedteam, addindex);
}

function function_7ca4d46dfe174e90(trackerteam, trackedteam, addindex) {
  if(addindex < 0 || addindex >= 4) {
    return;
  }

  notifyname = "trackTeam" + trackerteam + addindex;
  var_29412b34af141c29 = [];
  var_5b1596320df748c = [];
  var_5b1596320df748c["name"] = trackedteam;
  var_5b1596320df748c["startTime"] = gettime();
  var_840b848760f488a4 = getdvarint(@ "hash_96c8e4682ff85b5f", 0);

  if(istrue(var_840b848760f488a4)) {
    level notify(notifyname);
    level endon(notifyname);
    level.teamdata[trackerteam]["trackedTeams"][addindex] = var_5b1596320df748c;
    var_29412b34af141c29 = getteamdata(trackerteam, "players");
  } else {
    self notify(notifyname);
    self endon(notifyname);
    self.trackedteams[addindex] = var_5b1596320df748c;
    var_29412b34af141c29 = [self];
  }

  trackedteamindex = getteamindex(trackedteam);
  function_d6d795db2cae2c1b(var_29412b34af141c29, trackedteamindex, addindex);
  cleardelay = getdvarfloat(@ "scr_br_tracked_teams_clear_delay", 2.5);
  wait cleardelay;
  function_d6d795db2cae2c1b(var_29412b34af141c29, 0, addindex);
}

function function_e003a419d3914c23() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level waittill("infils_ready");
  var_10b5c13c81db5079 = function_b398acc9ba21ecb5();

  if(var_10b5c13c81db5079 < 0) {
    return;
  }

  totaltime = 0;

  for(i = 0; i < var_10b5c13c81db5079; i++) {
    totaltime += level.br_level.br_circleclosetimes[i] + level.br_level.br_circledelaytimes[i];
  }

  totaltimems = int(totaltime * 1000);
  starttimems = gettime();
  var_3112e3de7bf7f005 = starttimems + totaltimems;
  setomnvarforallclients("ui_br_timed_feature_end_time", var_3112e3de7bf7f005);
  setomnvarforallclients("ui_br_resurgence_will_disable", 0);
  level.var_1fcba68efd8d4bf = totaltime;
  remainingtimems = totaltimems;
  maxtimems = getdvarint(@ "hash_342776b421ce99fa", 90000);
  thread function_c2890d0252b9f16d(remainingtimems / 1000);

  while(remainingtimems > maxtimems) {
    wait(remainingtimems - maxtimems) / 1000;
    elapsedtimems = gettime() - starttimems;
    remainingtimems = totaltimems - elapsedtimems;
  }

  setomnvarforallclients("ui_br_resurgence_will_disable", 1);
  setomnvarforallclients("ui_br_timed_feature_end_time", int(gettime() + remainingtimems));

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    player thread scripts\mp\hud_message::showsplash("br_resurgence_reinforcement_closing", undefined, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp_mgl");
  }
}

function function_c2890d0252b9f16d(remainingtime) {
  wait remainingtime - 90;
  scripts\mp\gametypes\br_public::brleaderdialog("champion_ending");
}

function function_2573e08a439335f7() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.brgametype.respawndelay = [];
  level.brgametype.var_a427c307de983162 = getdvarint(@ "hash_8676fe51daaeabe1", 1);
  var_10b5c13c81db5079 = function_b398acc9ba21ecb5();

  if(level.brgametype.var_a427c307de983162 && var_10b5c13c81db5079 >= 0) {
    var_31f53a82b8311132 = [@ "hash_54321ad57677ee05", @ "hash_543219d57677ebd2", @ "hash_543218d57677e99f", @ "hash_543217d57677e76c", @ "hash_543216d57677e539", @ "hash_543215d57677e306", @ "hash_543214d57677e0d3", @ "hash_543213d57677dea0", @ "hash_543222d57677ff9d", @ "hash_543221d57677fd6a"];
    assertex(var_10b5c13c81db5079 < var_31f53a82b8311132.size, "<dev string:xd9>");

    for(i = 0; i < var_10b5c13c81db5079; i++) {
      level.brgametype.respawndelay[i] = getdvarint(var_31f53a82b8311132[i], 20);
    }

    return;
  }

  level.brgametype.respawndelay[0] = getdvarint(@ "hash_4db324f75255cc28", 20);
}

function function_b909abb7a17a92ad() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  newvalue = currentvalue &~16384;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", newvalue);
}

function function_6bb3d05538568538() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  newvalue = currentvalue | 16384;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", newvalue);
}

function function_9b57a5870079dee1() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  newvalue = currentvalue | 32768;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", newvalue);
}

function function_80a44396d4052334() {
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  newvalue = currentvalue &~32768;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", newvalue);
}

function function_6238a0c9226288bc(value) {
  assert(value <= 16384 - 1);
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  otherbits = currentvalue &~(16384 - 1);
  newvalue = otherbits | value;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", newvalue);
}

function function_a4f5eae4925ad484(value) {
  assert(value <= 16384 - 1);
  currentvalue = self getclientomnvar("ui_resurgenceRespawnTimer");
  otherbits = currentvalue &~(1073741824 - 65536 + 1073741824);
  forceupdate = currentvalue & 1073741824;

  if(forceupdate != 0) {
    forceupdate = 0;
  } else {
    forceupdate = 1073741824;
  }

  newvalue = otherbits | value << 16 | forceupdate;
  self setclientomnvar("ui_resurgenceRespawnTimer", newvalue);
  self setclientomnvar("ui_resurgenceRespawnTimer_solo", newvalue);
}

function function_d04daab64ea0d3df(player) {
  teamplayers = getteamdata(player.team, "players");

  foreach(teammate in teamplayers) {
    goingtogulag = teammate scripts\mp\gametypes\br_public::isplayerinorgoingtogulag();
    var_73409c2edfa9e4f9 = isalive(teammate) && !istrue(teammate.inlaststand);

    if(teammate != player && var_73409c2edfa9e4f9 && !goingtogulag) {
      return true;
    }
  }

  return false;
}

function function_de118d63bf624508() {
  player = self;

  if(player scripts\mp\gametypes\br_gulag::function_4a25d64251fab1b7()) {
    player function_348449f96ff7cef8(level.teamdata[player.team]["alivePlayers"]);
    function_1f8da2719751fc5f();
    player scripts\mp\playerlogic::addtoalivecount("champion_gulag");
    scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(player);
    var_4911936f026c8e38 = scripts\mp\gametypes\br::brmayconsiderplayerdead(player);

    if(!var_4911936f026c8e38) {
      scripts\mp\gametypes\br_gulag::entergulag(player);
    }

    self.waitingtospawn = 0;
  }
}

function function_aac26c7a1cfe6c48() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("doingRespawn");

  if(istrue(level.brgametype.var_55f0d9f2a10553c4)) {
    while(function_d04daab64ea0d3df(self)) {
      waitframe();
    }

    function_b909abb7a17a92ad();
    self notify("squad_wiped");
    waitframe();
    function_de118d63bf624508();
    return;
  }

  for(var_849d01afb2fc0f0a = getteamdata(self.team, "aliveCount"); var_849d01afb2fc0f0a > 0; var_849d01afb2fc0f0a = getteamdata(self.team, "aliveCount")) {
    waitframe();
  }

  function_b909abb7a17a92ad();
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", 0);
  self notify("squad_wiped");
}

function function_5dfd73c97bf5d03d(player, evictim, event, points, var_645b1a1d2a1ddfb7) {
  if(!isDefined(player)) {
    return;
  }

  if(!isalive(player)) {
    return;
  }

  if(points <= 0) {
    return;
  }

  if(!scripts\mp\flags::gameflag("prematch_done") || !scripts\mp\flags::gameflag("prematch_fade_done")) {
    return;
  }

  if(isDefined(event) && isDefined(var_645b1a1d2a1ddfb7) && event == "br_kioskBuy" && var_645b1a1d2a1ddfb7 == "br_team_revive") {
    var_780d8a24242378d5 = scripts\mp\utility\teams::getteamdata(player.team, "aliveCount");
    squadsize = scripts\mp\utility\teams::getteamdata(player.team, "teamCount");
    var_de1f625722d92973 = squadsize - var_780d8a24242378d5;

    if(var_de1f625722d92973 == 1) {
      return;
    }
  }

  var_9a5e708d6675417 = getmatchrulesdata("brData", "resurgencePointsToSecondRatio");
  firstsecondoffset = getmatchrulesdata("brData", "resurgencePointsToFirstSecondOffset");
  delaymodifier = int(floor((points + firstsecondoffset) * var_9a5e708d6675417));

  if(isDefined(event)) {
    if(event == "br_kioskBuy") {
      kioskbuyratio = getmatchrulesdata("brData", "resurgencePointsToSecondKioskBuyRatio");
      delaymodifier = int(ceil(delaymodifier * kioskbuyratio));
    } else if(event == "kill") {
      delaymodifier = int(floor((250 + firstsecondoffset) * var_9a5e708d6675417));
    } else if(event == "br_cacheOpen") {
      delaymodifier = int(floor((100 + firstsecondoffset) * var_9a5e708d6675417));
    }
  }

  if(delaymodifier <= 0) {
    return;
  }

  playerteam = level.teamdata[player.team];

  if(!isDefined(playerteam)) {
    return;
  }

  deadplayers = playerteam["deadPlayers"];

  if(!isDefined(deadplayers)) {
    return;
  }

  var_7cd081d8bbc27830 = 0;

  foreach(dead in deadplayers) {
    if(isDefined(dead) && isDefined(dead.player) && dead.player != player) {
      if(dead.player.respawndelay > 0) {
        dead.player.respawndelay = int(max(0, dead.player.respawndelay - delaymodifier));

        if(!isDefined(dead.player.respawndelta)) {
          dead.player.respawndelta = 0;
        }

        dead.player.respawndelta += delaymodifier;
        var_7cd081d8bbc27830 = 1;
      }
    }
  }

  if(var_7cd081d8bbc27830) {
    if(istrue(player.var_5c3b157495f480a2)) {
      player.var_5449b5708779ee8e += delaymodifier;
      return;
    }

    player.var_5c3b157495f480a2 = 1;
    player.var_5449b5708779ee8e = delaymodifier;
    player thread function_bb5d745ad4aed02c();
  }
}

function function_bb5d745ad4aed02c() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("squad_wiped");
  wait 0.5;

  if(isDefined(self.var_5449b5708779ee8e) && self.var_5449b5708779ee8e > 0) {
    function_a4f5eae4925ad484(self.var_5449b5708779ee8e);
  }

  self.var_5449b5708779ee8e = undefined;
  self.var_5c3b157495f480a2 = 0;
}

function waitrespawn() {
  if(!istrue(level.brgametype.respawnenable)) {
    return;
  }

  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("squad_wiped");
  player endon("force_stop_respawn");

  if(!istrue(level.brgametype.var_b43745b85f249e68)) {
    player thread function_aac26c7a1cfe6c48();
  }

  player thread function_c1a20edbed65900b();

  if(isDefined(level.brgametype.var_c655c38108f1827f)) {
    player.respawndelay = level.brgametype.var_c655c38108f1827f;
  } else if(level.br_circle.circleindex < 0) {
    player.respawndelay = level.brgametype.respawndelay[0];

    if(istrue(level.brgametype.var_fc3b5a2e206a85f2)) {
      player.respawndelay = level.brgametype.waverespawntimer;
    }
  } else {
    circleindex = int(min(level.br_circle.circleindex, level.brgametype.respawndelay.size - 1));
    player.respawndelay = level.brgametype.respawndelay[circleindex];

    if(istrue(level.brgametype.var_fc3b5a2e206a85f2)) {
      player.respawndelay = level.brgametype.waverespawntimer;
    }
  }

  if(!isDefined(player.respawndelay)) {
    errormsg = "";
    gameflags = "\n";
    flagnames = getarraykeys(game["flags"]);

    foreach(name in flagnames) {
      gameflags += name + " -> " + game["flags"][name] + "\n";
    }

    errormsg += gameflags;
    scripts\mp\utility\script::demoforcesre(errormsg);
    player.respawndelay = 20;
  }

  if(getdvarint(@ "hash_d31b1c01a86089c2", 1) == 1 && isalive(player)) {
    scripts\mp\utility\script::demoforcesre("Alive player added to resurgence countdown. IsAlive: " + isalive(player) + ". Sessionstate: " + player.sessionstate);
    waitframe();
    scripts\mp\utility\script::demoforcesre("Alive player added to resurgence countdown - after waitframe. IsAlive: " + isalive(player) + ". Sessionstate: " + player.sessionstate);
  }

  player function_80a44396d4052334();
  player function_6bb3d05538568538();
  player function_6238a0c9226288bc(player.respawndelay);
  player.respawndelta = 0;

  while(player.respawndelay > 0) {
    if(player.respawndelay <= 5) {
      player playsoundtoplayer("ui_mp_resurgence_timer_quarter_sec", player);
    } else if(player.respawndelay <= 10) {
      player playsoundtoplayer("ui_mp_resurgence_timer_half_sec", player);
    } else if(player.respawndelay % 4 == 2) {
      player playsoundtoplayer("ui_mp_resurgence_timer", player);
    } else {
      player playsoundtoplayer("ui_mp_resurgence_timer_tick", player);
    }

    if(isalive(player)) {
      player.respawndelay = 0;
    } else {
      player function_6238a0c9226288bc(player.respawndelay);
    }

    player function_a4f5eae4925ad484(player.respawndelta);
    player scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", player.respawndelay);
    player.respawndelta = 0;
    wait 1;
    player.respawndelay--;
  }

  player function_b909abb7a17a92ad();
  player function_a4f5eae4925ad484(0);
  player scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", 0);

  if(!isalive(player)) {
    if(isDefined(player.team)) {
      displaysquadmessagetoteam(player.team, player, 14, 1);

      foreach(teammate in level.teamdata[player.team]["alivePlayers"]) {
        if(!istrue(teammate.var_24278e2ec4540e)) {
          teammate thread function_53b4caf82507f423();
        }
      }
    }

    player thread doingrespawn(0, level.teamdata[player.team]["alivePlayers"]);
  }
}

function function_53b4caf82507f423() {
  level endon("game_ended");
  self.var_24278e2ec4540e = 1;
  thread scripts\mp\gametypes\br_public::brleaderdialogplayer("champion_teammate_respawn", self);
  wait 5;
  self.var_24278e2ec4540e = undefined;
}

function function_c1a20edbed65900b() {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();
  function_81f2b277d31bb707();
}

function function_81f2b277d31bb707() {
  if(istrue(level.brgametype.var_ad3c825b1dd7d9a8)) {
    return;
  }

  newentry = self;

  if(!istrue(level.brgametype.vengeanceuseanykill)) {
    newentry = spawnStruct();
    newentry.player = self;
    newentry.killer = self.lastkilledby;
  }

  var_7193e062042f638d = [];
  deadplayers = level.teamdata[self.team]["deadPlayers"];

  foreach(dead in deadplayers) {
    if(isDefined(dead)) {
      var_7193e062042f638d[var_7193e062042f638d.size] = dead.player.name;
    }
  }

  assertex(!array_contains(var_7193e062042f638d, newentry.player.name), "<dev string:x11a>");
  level.teamdata[self.team]["deadPlayers"] = array_add(level.teamdata[self.team]["deadPlayers"], newentry);
}

function function_1f8da2719751fc5f() {
  if(istrue(level.brgametype.var_ad3c825b1dd7d9a8)) {
    return;
  }

  deadplayers = level.teamdata[self.team]["deadPlayers"];

  if(istrue(level.brgametype.vengeanceuseanykill)) {
    deadplayers = array_remove(deadplayers, self);
  } else {
    newents = [];

    foreach(item in deadplayers) {
      if(isDefined(item) && item.player != self) {
        newents[newents.size] = item;
      }
    }

    deadplayers = newents;
  }

  level.teamdata[self.team]["deadPlayers"] = deadplayers;
}

function doingrespawn(var_cb5ba4c3282c39c1, aliveteammates) {
  assertex(isDefined(self), "<dev string:x137>");
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("doingRespawn");

  if(istrue(player.respawningfromtoken)) {
    return;
  }

  player.respawningfromtoken = 1;

  if(istrue(level.brgametype.var_6f3c4d74a8c614ab)) {
    player notify("started_spawnPlayer");
  }

  if(istrue(var_cb5ba4c3282c39c1)) {
    player function_9b57a5870079dee1();
    player thread scripts\mp\events::killeventtextpopup("br_resurgence_vengeance", 0, 0);
    wait 1.5;
  }

  player function_348449f96ff7cef8(aliveteammates);
  function_1f8da2719751fc5f();
  player scripts\mp\playerlogic::addtoalivecount("champion");
  scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(player);
  player scripts\mp\gametypes\br_pickups::addrespawntoken(1);
  var_1476e0f78320a501 = 0;

  if(istrue(level.brgametype.var_a916b204f027af6b)) {
    var_1476e0f78320a501 = player namespace_8bfdb6eb5a3df67a::playerwaitforprestreaming();
  }

  streamtimeout = scripts\mp\gametypes\br_public::getdefaultstreamhinttimeoutms() / 1000;
  spawnpoint = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint(0, streamtimeout);
  streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
  self.forcespawnorigin = streamorigin;

  if(var_1476e0f78320a501) {
    player scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }

  var_b59f471c2c064e56 = 1;
  player namespace_8bfdb6eb5a3df67a::function_334a8fe67e88bbe7();
  wait var_b59f471c2c064e56;
  player function_b909abb7a17a92ad();
  player scripts\mp\hud_message::clearsplashqueue();
  player scripts\mp\playerlogic::spawnplayer(undefined, 0);
  player scripts\cp_mp\execution::_clearexecution();
  player scripts\mp\gametypes\br_pickups::initplayer();
  player scripts\mp\gametypes\br_spectate::playerclearspectatekillchainsystem();
  player.respawningfromtoken = undefined;
  player function_80a44396d4052334();
  player thread namespace_8bfdb6eb5a3df67a::triggerrespawnoverlay(20);
  player respawn(spawnpoint, streamorigin);
}

function triggerrespawnoverlay() {
  wait 0.5;
  return true;
}

function respawn(spawnpoint, streamorigin) {
  println("<dev string:x15e>" + self.name);
  level notify("update_circle_hide");

  if(isDefined(self.oobimmunity)) {
    scripts\mp\outofbounds::disableoobimmunity(self);
  }

  scripts\mp\gametypes\br::givelaststandifneeded(self);
  function_c04b5edf3f9ea340();

  if(!isDefined(spawnpoint)) {
    spawnpoint = namespace_8bfdb6eb5a3df67a::playergetrespawnpoint();
  }

  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  startorigin = spawnorigin;

  if(isDefined(streamorigin)) {
    startorigin = streamorigin;
  }

  namespace_8bfdb6eb5a3df67a::function_961b4afc4c695b94();
  self setOrigin(startorigin, 1);
  self setplayerangles(spawnangles);
  linker = spawn("script_model", startorigin);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(self);
  self playerlinktoabsolute(linker, "tag_origin");
  function_a593971d75d82113();
  function_379bb555405c16bb("br_gametype_champion::respawn()");
  thread namespace_8bfdb6eb5a3df67a::playercleanupentondisconnect(linker);
  waitframe();
  playerrespawncleanup();

  if(getdvarint(@ "scr_skip_respawn_gate", 1) == 0) {
    scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
  }

  scripts\mp\gametypes\br_public::playerclearstreamhintorigin();

  if(isDefined(streamorigin)) {
    linker.origin = spawnorigin;
  }

  linker playsoundtoplayer("br_ac130_flyby", self);
  wait 1.5;
  self unlink();
  scripts\common\damage_effects::function_a2b4e6088394bade();

  if(scripts\mp\gametypes\br_public::isbrpracticemode()) {
    self clearsoundsubmix("iw8_br_gulag_tutorial", 2);
  } else {
    self clearsoundsubmix("solo_cin_igc_music", 2);
  }

  self clearclienttriggeraudiozone(1);
  function_6fb380927695ee76();
  function_985b0973f29da4f8("br_gametype_champion::respawn()");
  playersetcontrols(1);
  falltime = 0;

  if(isDefined(level.parachutedeploydelay)) {
    falltime = level.parachutedeploydelay;
  }

  if(!scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf()) {
    thread scripts\cp_mp\parachute::startfreefall(falltime, 0, undefined, undefined, 1);
  }

  if(getgametype() == "br") {
    self setclientomnvar("ui_show_spectateHud", -1);
  }

  namespace_8bfdb6eb5a3df67a::resetplayermovespeedscale();
  scripts\cp_mp\armor::givestartingarmor();
  scripts\mp\gametypes\br_quest_util::onplayerrespawn();
  scripts\mp\gametypes\br_rewards::onplayerrespawn();
  scripts\mp\gametypes\br_pickups::removerespawntoken();
  wait 0.5;

  if(getgametype() == "br") {
    thread namespace_8bfdb6eb5a3df67a::playercinematicfadeout();
  }

  waitframe();
  linker delete();

  if(istrue(level.var_3ff7c73209fcf59d)) {
    scripts\mp\gametypes\br_skydive_protection::initprotection();
  }

  if(scripts\mp\gametypes\br_public::isbrpracticemode()) {
    self notify("respawn_from_gulag");
  }

  self notify("can_show_splashes");

  if(!istrue(level.ignoregulagredeploysplash)) {
    thread scripts\mp\hud_message::showsplash("br_resurgence_redeploy", 20, undefined, undefined, undefined, "splash_list_iw9_br_resurgence_mp_mgl");
  }

  scripts\mp\gametypes\br_public::brleaderdialogplayer("champion_redeploy", self);
}

function playerrespawncleanup() {
  self notify("resurgenceRespawn");
  self.health = self.maxhealth;
  val::set("resurgenceRespawn", "player_for_spawn_logic", 0);
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("isRespawning", 0);
}

function function_c04b5edf3f9ea340() {
  if(isDefined(level.br_standard_loadout) || getdvarint(@ "hash_f97d261e2f377ad9", 1) != 0) {
    self.gulagtableloadout = 1;
  }
}

function playersetcontrols(enable) {
  if(enable) {
    self enableoffhandweapons();
    self enableusability();
    return;
  }

  self disableoffhandweapons();
  self disableusability();
}

function getdefaultloadout() {
  loadout = level.br_standard_loadout;

  if(isDefined(level.var_c04b5edf3f9ea340)) {
    circleindex = 0;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      circleindex = min(level.br_circle.circleindex, level.var_c04b5edf3f9ea340.size);
      circleindex = int(circleindex);
    }

    if(isDefined(level.var_77c121d31e587ba8[circleindex])) {
      loadout = level.var_c04b5edf3f9ea340[circleindex][level.var_77c121d31e587ba8[circleindex]];
    }
  }

  return loadout;
}

function function_b8d1b2b54ad5f08d() {
  noextraammo = 0;

  if(isDefined(level.var_c04b5edf3f9ea340)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      if(level.br_circle.circleindex == level.var_c04b5edf3f9ea340.size - 1) {
        noextraammo = 1;
      }
    }
  }

  return noextraammo;
}

function playernakeddroploadout() {
  if(istrue(level.brgametype.loadoutrestore) && isDefined(self.savedloadout)) {
    scripts\mp\gametypes\br::playerloadoutrestore();
  } else {
    if(!istrue(self.var_ab5f5270cb22e3c8)) {
      var_dab2d2efde751b62 = "classtable:classtable_br_vanilla";
      level.br_standard_loadout = scripts\mp\gametypes\br::initstandardloadout(var_dab2d2efde751b62, 0);
      self.var_ab5f5270cb22e3c8 = 1;
    } else {
      level.br_standard_loadout = getdefaultloadout();
    }

    noextraammo = function_b8d1b2b54ad5f08d();
    scripts\mp\gametypes\br::givestandardtableloadout(0, 1, noextraammo);
  }

  scripts\cp_mp\armor::givestartingarmor();

  if(!isDefined(self.firstspawndone)) {
    self.firstspawndone = 1;
    var_ce214afc7b96a3a7 = getdvarint(@ "hash_e67c864263196598", 0);

    if(var_ce214afc7b96a3a7) {
      scripts\mp\gametypes\br_pickups::addselfrevivetoken(1);
    }

    givespecialist = getdvarint(@ "hash_5868a46b12b1b4dd", 0);

    if(givespecialist) {
      scripts\mp\perks\perks::addspecialistbonus();
    }
  } else {
    var_ce214afc7b96a3a7 = getdvarint(@ "scr_br_give_self_revive_on_respawn", 0);

    if(var_ce214afc7b96a3a7) {
      scripts\mp\gametypes\br_pickups::addselfrevivetoken(1);
    }

    givespecialist = getdvarint(@ "hash_5868a46b12b1b4dd", 0);

    if(givespecialist) {
      scripts\mp\perks\perks::addspecialistbonus();
    }
  }

  return false;
}

function function_b398acc9ba21ecb5() {
  return getdvarint(@ "hash_5c872af62541d1d", 3);
}

function circletimer(circleindex) {
  if(istrue(level.brgametype.respawnenable)) {
    var_10b5c13c81db5079 = function_b398acc9ba21ecb5();

    if(circleindex >= var_10b5c13c81db5079 && var_10b5c13c81db5079 >= 0) {
      disablerespawn();
    }
  }
}

function disablerespawn() {
  level.brgametype.respawnenable = 0;
  level notify("respawn_disabled");
  function_747b066379119d51();
  scripts\mp\gametypes\br_gametypes::runbrgametypefunc("resurgenceDisable");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    scripts\mp\gametypes\br_killstreaks::dangernotifyplayer(player, "respawn_disabled", 2);
    player setclientomnvar("ui_br_timed_feature_end_time", 0);
    player scripts\mp\gametypes\br_gametypes::runbrgametypefunc("playerResurgenceDisable");
  }

  scripts\mp\gametypes\br_public::brleaderdialog("champion_disabled");
}

function initloadouts(table) {
  if(!isDefined(level.var_c04b5edf3f9ea340)) {
    level.var_c04b5edf3f9ea340 = [];
  }

  newloadoutindex = level.var_c04b5edf3f9ea340.size;
  var_7d958726e11b327 = tablelookupgetnumcols(table) - 1;
  level.var_c04b5edf3f9ea340[newloadoutindex] = [];

  for(classindex = 0; classindex < var_7d958726e11b327; classindex++) {
    level.var_c04b5edf3f9ea340[newloadoutindex][level.var_c04b5edf3f9ea340[newloadoutindex].size] = function_aa8a954d66bf39b4(classindex, table);
  }

  level.var_77c121d31e587ba8 = [];

  foreach(circleindex, circleloadout in level.var_c04b5edf3f9ea340) {
    if(isDefined(level.var_c04b5edf3f9ea340[circleindex]) && level.var_c04b5edf3f9ea340[circleindex].size > 0) {
      level.var_77c121d31e587ba8[circleindex] = randomintrange(0, level.var_c04b5edf3f9ea340[circleindex].size);
    }
  }
}

function function_aa8a954d66bf39b4(classindex, table) {
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = tablelookup(table, 0, "loadoutPrimary", classindex + 1);
  loadout["loadoutPrimaryAttachment"] = tablelookup(table, 0, "loadoutPrimaryAttachment1", classindex + 1);
  loadout["loadoutPrimaryAttachment2"] = tablelookup(table, 0, "loadoutPrimaryAttachment2", classindex + 1);
  loadout["loadoutPrimaryAttachment3"] = tablelookup(table, 0, "loadoutPrimaryAttachment3", classindex + 1);
  loadout["loadoutPrimaryAttachment4"] = tablelookup(table, 0, "loadoutPrimaryAttachment4", classindex + 1);
  loadout["loadoutPrimaryAttachment5"] = tablelookup(table, 0, "loadoutPrimaryAttachment5", classindex + 1);
  loadout["loadoutPrimaryCamo"] = tablelookup(table, 0, "loadoutPrimaryCamo", classindex + 1);
  loadout["loadoutPrimaryReticle"] = tablelookup(table, 0, "loadoutPrimaryReticle", classindex + 1);
  loadout["loadoutSecondary"] = tablelookup(table, 0, "loadoutSecondary", classindex + 1);
  loadout["loadoutSecondaryAttachment"] = tablelookup(table, 0, "loadoutSecondaryAttachment1", classindex + 1);
  loadout["loadoutSecondaryAttachment2"] = tablelookup(table, 0, "loadoutSecondaryAttachment2", classindex + 1);
  loadout["loadoutSecondaryAttachment3"] = tablelookup(table, 0, "loadoutSecondaryAttachment3", classindex + 1);
  loadout["loadoutSecondaryAttachment4"] = tablelookup(table, 0, "loadoutSecondaryAttachment4", classindex + 1);
  loadout["loadoutSecondaryAttachment5"] = tablelookup(table, 0, "loadoutSecondaryAttachment5", classindex + 1);
  loadout["loadoutSecondaryCamo"] = tablelookup(table, 0, "loadoutSecondaryCamo", classindex + 1);
  loadout["loadoutSecondaryReticle"] = tablelookup(table, 0, "loadoutSecondaryReticle", classindex + 1);
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = tablelookup(table, 0, "loadoutEquipmentPrimary", classindex + 1);
  loadout["loadoutEquipmentSecondary"] = tablelookup(table, 0, "loadoutEquipmentSecondary", classindex + 1);
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [tablelookup(table, 0, "loadoutPerk1", classindex + 1), tablelookup(table, 0, "loadoutPerk2", classindex + 1), tablelookup(table, 0, "loadoutPerk3", classindex + 1), tablelookup(table, 0, "loadoutExtraPerk1", classindex + 1), tablelookup(table, 0, "loadoutExtraPerk2", classindex + 1), tablelookup(table, 0, "loadoutExtraPerk3", classindex + 1)];
  loadout["loadoutGesture"] = "playerData";
  loadout["tableColumn"] = classindex;
  return loadout;
}

function function_641eee023180065() {
  if(!istrue(level.brgametype.var_fc3b5a2e206a85f2)) {
    return;
  }

  if(!isDefined(level.brgametype.waverespawndelays)) {
    level.brgametype.waverespawndelays = [60, 30];
  }

  thread function_9ead22d4f0ee52da();
}

function function_9ead22d4f0ee52da() {
  level endon("game_ended");
  var_415a76657415492e = 0;
  level.brgametype.waverespawntimer = level.brgametype.waverespawndelays[var_415a76657415492e];
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level waittill("infils_ready");

  while(level.brgametype.respawnenable) {
    while(level.brgametype.waverespawntimer > 0) {
      wait 1;
      level.brgametype.waverespawntimer--;
    }

    wait 1;
    var_415a76657415492e = int(min(var_415a76657415492e + 1, level.brgametype.waverespawndelays.size - 1));
    level.brgametype.waverespawntimer = level.brgametype.waverespawndelays[var_415a76657415492e];
  }
}

function createc130pathstruct() {
  assertex(isDefined(level.br_level) && isDefined(level.br_level.br_circlecenters) && isDefined(level.br_level.br_circleradii), "<dev string:x18a>");
  originoverride = (level.br_level.br_circlecenters[1][0], level.br_level.br_circlecenters[1][1], 0);
  radiusoverride = level.br_level.br_circleradii[1];
  c130pathstruct = scripts\mp\gametypes\br_c130::createtestc130path(originoverride, radiusoverride);
  return c130pathstruct;
}

function addtoc130infil() {
  thread scripts\mp\gametypes\br_public::kickplayersatcircleedge();
}

function setdropbagdelay() {
  waittillframeend();
  deltatime = -15;
  closetime = scripts\mp\gametypes\br_circle::getcircleclosetime(1);
  defaultval = max(0, closetime + deltatime);
  dropdelay = getdvarfloat(@ "hash_b81b25bcd8c7d749", defaultval);
  scripts\mp\gametypes\br_gametypes::registerbrgametypedata("dropBagDelay", dropdelay);
}

function onclosecirclecompleted(var_6b890e6be7982efb) {
  timeremaining = scripts\mp\gamelogic::gettimeremaining() / 1000;
  timeremaining += getdvarint(@ "hash_b1dc99c22b12bd63", 0);
  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = scripts\mp\gametypes\br_circle::getdangercircleorigin() + (0, 0, scripts\mp\gametypes\br_circle::getdangercircleradius());
  scripts\mp\gametypes\br_circle::setstaticuicircles(timeremaining, level.br_circle.safecircleui, level.br_circle.dangercircleui, var_6b890e6be7982efb);
}

function playergetrespawnpoint(forcefallback, timeuntilspawn, overrideheight) {
  percentmin = getdvarfloat(@ "hash_d9e0311bd167f06b", 0);
  percentmax = getdvarfloat(@ "hash_d9bc471bd13fa615", 1);
  spawnorigin = scripts\mp\gametypes\br_circle::getrandompointinsafecircle(percentmin, percentmax);

  if(isDefined(spawnorigin)) {
    spawnorigin = scripts\mp\gametypes\br_public::droptogroundmultitrace(spawnorigin);
  }

  return spawnorigin;
}

function function_a2131d000491ae2c(eattacker, victim) {
  if(victim.agent_type == "actor_enemy_mp_jugg_mgl" && isPlayer(eattacker)) {
    eattacker thread scripts\mp\utility\points::doscoreevent(#"hash_17ab30c9bc1e4c7c");
  }
}