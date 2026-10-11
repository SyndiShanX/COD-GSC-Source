/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_697b7ae06ba9b28c.gsc
*************************************************/

#using script_4cdabcd91a92977;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\rank;
#using scripts\mp\teams;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#namespace leagueplay_br;

function init() {
  if(!level.var_77907d733abe8b63) {
    return;
  }

  namespace_bf9ffd2b22c7d819::function_8ce5b106fbba9e9f(&ondisconnect);
  namespace_bf9ffd2b22c7d819::function_8fe6d6539ed31a88(&function_adcdfd1b1a3efa51);
  namespace_bf9ffd2b22c7d819::function_ead10448a780a58(&function_3e87ebe7f88f1249);
  level.var_c8001f5313a05589 = getdvarint(@ "hash_b5256fb3f4ed76af", 0);
  level.var_7272c293f31c587c = getdvarint(@ "hash_a94c6ed8a414196", 0);
  level.var_8eed04dc7bdc9766 = getdvarint(@ "leagueplay_wait_for_players_s", 60);
  level.var_764459b234d5c391 = getdvarint(@ "live_lobby_minplayers_start", 0);
  level.var_58bec65ec9494d11 = getdvarint(@ "max_time_to_backfill_s", 60);
  level.var_8a4997ca061aa1e5 = getdvarint(@ "hash_683c426d1ee9a40b", 3);
  level.var_809aa817d70fd977 = getdvarint(@ "minplayers_before_disband", 99);
  level.var_cce73e718062d33c = getdvarint(@ "hash_198448220f60dcf0", 150);
  level.var_79814d80c62f8ebe = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb();
  level.var_a176083f858ec97b = getdvarint(@ "hash_1d776bc9e844239c", 0);
  level.var_ad381e249ebe26d0 = getdvarint(@ "wz_leagueplay_hide_sr_widget_on_spectate_team", 1);
  level.var_9573ac4c1f716a60 = getdvarint(@ "hash_ca82e8691a799ce6", 500);
  level.var_a663d955218dcc0c = getdvarint(@ "hash_437738f209d2d423", 3);
  scripts\mp\rank::registerscoreinfo(#"shield_assist", #"value", 25);
  level.leagueid = function_9be1e9f1351a5c97();
  level.var_75b72a33aeab21d4 = function_ce30512fcd3a11a1();
  level.var_cbbf84a8e78caeee = function_8345f2ac499e5ab();
  level.var_bbcb5f6b1b0a78ae = 1;
  level.var_7b46fd91db5fefdc = 0;

  if(!isDefined(level.var_75b72a33aeab21d4)) {
    level.var_75b72a33aeab21d4 = 0;
  }

  requiredplayers = 3;

  if(isusingmatchrulesdata()) {
    requiredplayers = getmatchrulesdata("commonOption", "squadSize");
  }

  level thread onconnect();
  level thread ongameplaying();
  var_5f4a4aacb73b91d7 = int(tablelookup("mp/leagueplay_config.csv", 0, "ladderPointsPlacement", 1));
  level.var_f67ee22da6041b9b = function_1e73e03e20e15dff();

  if(getdvarint(@ "hash_3438d68f1f0e7c0a", 1) && istrue(level.var_77907d733abe8b63)) {
    level.var_561addf876799987 = &function_bc0b95efa029ffb;
    level.onplayerkilledcallback = &function_7e9f0b973f0cdda3;
    level.var_c596a10a13c5cd7c = &function_5b4b593ace7e0ac1;
    level.var_e82dd38d666141db = &function_7b4d239188b80bb1;
    level function_b9a99d80c18f3c6b();
  }

  level thread function_ca85981ca17b83ef();
  level thread trackprematch();
}

function onconnect() {
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);

    if(istrue(level.leagueplaymatchcancelled)) {
      return;
    }

    if(!isPlayer(player) || isbot(player)) {
      return;
    }

    xuid = player getxuid();

    if(!function_4707c41ed8bae2d2(player)) {
      player function_6c42f05b6c82b35e();
    }

    if(getdvarint(@ "hash_7e8b150c928a062f", 0)) {
      player match_start();
    }

    var_da4da6075aa47d27 = ter_op(istrue(player.pers["LPAllowLeave"]), 2, 3);
    player setclientomnvar("ui_leagueplay_allow_quit", var_da4da6075aa47d27);
    player setclientomnvar("ui_league_play_br_can_leave_with_party", 0);
  }
}

function function_adcdfd1b1a3efa51(player) {
  if(istrue(level.leagueplaymatchcancelled)) {
    return;
  }

  if(!isPlayer(player) || isbot(player)) {
    return;
  }

  player.pers["leaguePlayDisconnected"] = 0;
  player.pers["leaguePlayMatchCompleted"] = 0;
  xuid = player getxuid();

  if(function_4707c41ed8bae2d2(player)) {
    squadmates = getteamdata(player.team, "players");
    completesquad = 1;

    foreach(squadmate in squadmates) {
      var_558ce91125646a22 = squadmate getxuid();
      logstring("LeaguePlay: Checking user: " + var_558ce91125646a22);

      if(isDefined(squadmate.pers["leaguePlayDisconnected"]) && squadmate.pers["leaguePlayDisconnected"] == 1) {
        logstring("LeaguePlay: Incomplete squad, skipping loss forgiveness changes due to" + var_558ce91125646a22 + " still disconnected");
        completesquad = 0;
        break;
      }
    }

    if(completesquad) {
      player function_b64ccf1f4584f9be(0);
    }

    var_bca6691d9622c899 = function_78fcc96be9d69371();
    gamemode = scripts\cp_mp\challenges::getchallengegamemode(self);
    aeeventname = #"connection_update";
    aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);

    if(var_bca6691d9622c899 > -1) {
      params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d708505d31d66ef6"), 0, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c9361150947eb728"), function_94c7ae7049488358(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e03f5709c8cd8a03"), function_4f9373a1227db35c(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_23d400c5be24f34b"), var_bca6691d9622c899, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_cbbf84a8e78caeee, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e8d0ec1cb1f306c4"), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25()];

      if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
        player callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
      }

      return;
    }

    params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d708505d31d66ef6"), 0, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c9361150947eb728"), function_94c7ae7049488358(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e03f5709c8cd8a03"), function_4f9373a1227db35c(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_cbbf84a8e78caeee, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e8d0ec1cb1f306c4"), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25()];

    if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
      player callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
    }
  }
}

function ondisconnect(player, aeeventname) {
  if(!isDefined(player)) {
    logstring("LeaguePlay: Skipping disconnect penalty due to undefined player parameter");
    return;
  }

  xuid = player getxuid();

  if(!isDefined(xuid)) {
    logstring("LeaguePlay: Skipping disconnect penalty due to undefined xuid");
    return;
  }

  if(!isPlayer(player) || isbot(player)) {
    logstring("LeaguePlay: Skipping disconnect penalty due to not being a player, or a bot, xuid " + xuid);
    return;
  }

  if(istrue(player.pers["leaguePlayMatchCompleted"]) || istrue(level.leagueplaymatchcancelled) || istrue(level.gameended)) {
    logstring("LeaguePlay: Skipping disconnect penalty due to game already ended, xuid " + xuid);
    return;
  }

  if(!isDefined(player.team)) {
    logstring("LeaguePlay: Skipping disconnect penalty due to undefined team, xuid " + xuid);
    return;
  }

  if(!isDefined(player.pers["leaguePlayInit"]) || player.pers["leaguePlayInit"] == 0) {
    logstring("LeaguePlay: Skipping disconnect penalty due to not being initialized, xuid " + xuid);
    return;
  }

  squadmembers = [];

  if(istrue(level.matchmakingmatch)) {
    squadmembers = player getfireteammembers();
  }

  foreach(ent in level.players) {
    if(is_equal(ent.team, player.team) && isPlayer(ent)) {
      if(array_contains(squadmembers, ent)) {
        ent setclientomnvar("ui_leagueplay_allow_quit", 0);
      } else {
        ent setclientomnvar("ui_leagueplay_allow_quit", 2);
      }

      ent.pers["LPAllowLeave"] = 1;
    }
  }

  disconnectreason = 0;
  playercounts = scripts\mp\teams::countplayers();
  var_6aa85ad804fe30f6 = player getclientomnvar("ui_league_play_br_leave_penalty_timer");
  xuid = player getxuid();

  if(isDefined(playercounts) && isDefined(playercounts[player.team]) && playercounts[player.team] == level.var_79814d80c62f8ebe - 1) {
    disconnectreason = 1;
  } else {
    disconnectreason = 2;
  }

  if(isDefined(player.hitffkicklimit) && istrue(player.hitffkicklimit)) {
    disconnectreason = 3;
  } else if(isDefined(player.var_72c19b43b99e7097) && istrue(player.var_72c19b43b99e7097)) {
    disconnectreason = 7;
  } else if(istrue(player.pers["leaguePlayIncompleteSquad"])) {
    logstring("LeaguePlay: Sending unpenalized disconnect due to incomplete squad kick, xuid " + xuid);
    disconnectreason = 13;
  } else if(isDefined(player.pers["leaguePlayActivityPartyKick"])) {
    logstring("LeaguePlay: Skipping unpenalized disconnect due to incomplete activity party kick, xuid " + xuid);
    disconnectreason = 13;
  } else if(scripts\mp\gamelogic::inprematch()) {
    disconnectreason = 9;

    if(getdvarint(@ "hash_6aad2f4df487c409", 1) && isDefined(player.pers["subpartyIndex"]) && player.pers["subpartyIndex"] != -1) {
      playerxuid = player getxuid();
      squadmates = getteamdata(player.team, "players");

      foreach(squadmate in squadmates) {
        if(playerxuid != squadmate getxuid()) {
          if(isDefined(squadmate.pers["subpartyIndex"]) && squadmate.pers["subpartyIndex"] != -1 && squadmate.pers["subpartyIndex"] == player.pers["subpartyIndex"]) {
            logstring("LeaguePlay: Marking client for kick, xuid: " + squadmate getxuid() + " ( subpartyId: " + squadmate.pers["subpartyIndex"] + " ) due to disconnected activity party member in prematch");
            squadmate.pers["leaguePlayActivityPartyKick"] = 0;
          }
        }
      }
    }
  } else if(isDefined(var_6aa85ad804fe30f6) && var_6aa85ad804fe30f6 == 0) {
    disconnectreason = 12;
  }

  if(!scripts\mp\gamelogic::inprematch() && disconnectreason != 9 && disconnectreason != 13) {
    placement = scripts\cp_mp\challenges::function_5d99311b5a7dffda() + 1;

    if(getdvarint(@ "hash_da00458ff3dcc382", 0) && isDefined(player.teamplacement)) {
      placement = player.teamplacement;
    }

    is_disconnect = !(istrue(player.squadwiped) && scripts\mp\gametypes\br::function_99e3948bfd8a99b8(player.team) == 0);
    logstring("LeaguePlay: Triggering match end for disconnecting(" + is_disconnect + ") player xuid " + xuid);
    match_end(placement, 0, is_disconnect);
  }

  if(istrue(player.squadwiped)) {
    logstring("LeaguePlay: Skipping disconnect penalty due to player squad wiped, xuid " + xuid);
    return;
  }

  if(scripts\mp\gametypes\br::function_99e3948bfd8a99b8(player.team) == 0) {
    logstring("LeaguePlay: Skipping disconnect penalty due to player squad eliminated, xuid " + xuid);
    return;
  }

  if(getdvarint(@ "leagueplay_enable_loss_forgiveness", 0)) {
    var_a3865961cc8323cd = disconnectreason == 1;
    var_a3865961cc8323cd = var_a3865961cc8323cd || disconnectreason == 3;
    var_a3865961cc8323cd = var_a3865961cc8323cd || disconnectreason == 7;

    if(var_a3865961cc8323cd) {
      player function_b64ccf1f4584f9be(100);
    }
  }

  player.pers["leaguePlayDisconnected"] = 1;
  logstring("LeaguePlay: Disconnection for user " + xuid + " ( subpartyId: " + player.pers["subpartyIndex"] + " ) with reason: " + disconnectreason);
  var_bca6691d9622c899 = function_78fcc96be9d69371();
  gamemode = scripts\cp_mp\challenges::getchallengegamemode(self);

  if(var_bca6691d9622c899 > -1) {
    return [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d708505d31d66ef6"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c9361150947eb728"), function_94c7ae7049488358(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e03f5709c8cd8a03"), function_4f9373a1227db35c(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"disconnect_reason"), disconnectreason, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_23d400c5be24f34b"), var_bca6691d9622c899, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_ab984d923d5f2c96"), function_fb67b62bbd718b34(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_cbbf84a8e78caeee, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e8d0ec1cb1f306c4"), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25()];
  }

  return [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d708505d31d66ef6"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c9361150947eb728"), function_94c7ae7049488358(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e03f5709c8cd8a03"), function_4f9373a1227db35c(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"disconnect_reason"), disconnectreason, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_ab984d923d5f2c96"), function_fb67b62bbd718b34(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_cbbf84a8e78caeee, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e8d0ec1cb1f306c4"), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25()];
}

function function_3e87ebe7f88f1249(player, var_c4f3e9732aa81389) {
  if(var_c4f3e9732aa81389 == 2 || var_c4f3e9732aa81389 == 14) {
    var_6aa85ad804fe30f6 = player getclientomnvar("ui_league_play_br_leave_penalty_timer");

    if(isDefined(var_6aa85ad804fe30f6) && var_6aa85ad804fe30f6 == 0 && istrue(level.var_8c4a1a7b619d8e7c)) {
      return false;
    }
  }

  return true;
}

function ongameplaying() {
  level endon("game_ended");
  level waittill("br_prematchEnded");

  if(istrue(level.leagueplaymatchcancelled)) {
    return;
  }

  if(getdvarint(@ "hash_3438d68f1f0e7c0a", 1) && istrue(level.var_77907d733abe8b63)) {
    function_123fc096f9059fe0(1);
    thread function_3ec6d3cd62b16199();
  }

  function_9502b0bb442142b6("on_game_playing");

  if(!getdvarint(@ "hash_7e8b150c928a062f", 0)) {
    foreach(player in level.players) {
      player match_start();
    }
  }
}

function function_b64ccf1f4584f9be(forgivenesslevel) {
  player = self;
  playerxuid = player getxuid();
  squadmates = getteamdata(player.team, "players");

  foreach(squadmate in squadmates) {
    var_558ce91125646a22 = squadmate getxuid();

    if(playerxuid != var_558ce91125646a22) {
      if(isDefined(squadmate.pers["subpartyIndex"])) {
        if(squadmate.pers["subpartyIndex"] != -1 && squadmate.pers["subpartyIndex"] != player.pers["subpartyIndex"]) {
          logstring("LeaguePlay: due to user: " + playerxuid + " disconnecting, setting forgiveness to " + forgivenesslevel + " for user " + var_558ce91125646a22);
          squadmate.pers["forgiveness_level"] = forgivenesslevel;
        }
      }
    }
  }
}

function trackprematch() {
  if(istrue(level.skipprematch)) {
    return;
  }

  level.isprematch = 1;
  level waittill("prematch_done");
  level.isprematch = 0;
}

function function_9502b0bb442142b6(string) {
  if(getdvarint(@ "hash_1b391677375c45cd", 1) == 0) {
    return;
  }

  logstring("<dev string:x1c>");
  logstring("<dev string:x2b>" + string + "<dev string:x3c>");
  logstring("<dev string:x4b>");
  logstring("<dev string:x66>" + level.var_764459b234d5c391);
  logstring("<dev string:x9d>" + getdvarint(@ "br_minplayers", 1));
  logstring("<dev string:xd4>" + getdvarint(@ "hash_42b032b7e139b113", 1));
  logstring("<dev string:x10b>" + getdvarint(@ "hash_520364dd384db9e7", 1));
  logstring("<dev string:x142>" + level.var_58bec65ec9494d11);
  logstring("<dev string:x179>" + level.var_8eed04dc7bdc9766);
  logstring("<dev string:x1c>");
  logstring("<dev string:x1b0>");
  logstring("<dev string:x1d4>" + level.players.size);
  logstring("<dev string:x20b>" + scripts\mp\gamelogic::getstreamedinplayercount());
  logstring("<dev string:x242>" + function_5a7cb04f2683c1df());
  logstring("<dev string:x1c>");
  logstring("<dev string:x279>");
  teamindex = 0;

  foreach(teamname in level.teamnamelist) {
    players = getteamdata(teamname, "<dev string:x29a>");
    playerindex = 0;

    foreach(player in players) {
      logstring("<dev string:x2a5>" + teamindex + "<dev string:x2c2>" + playerindex + "<dev string:x2d2>" + player getxuid() + "<dev string:x2e0>" + player.pers["<dev string:x2f5>"] + "<dev string:x306>" + player.pers["<dev string:x31a>"]);
      playerindex += 1;
    }

    if(players.size > 0) {
      logstring("<dev string:x1c>");
    }

    teamindex += 1;
  }
}

function function_237daa716de2f328() {
  if(getdvarint(@ "hash_520364dd384db9e7", 1) == 1) {
    foreach(team in level.teamnamelist) {
      teamcount = getteamdata(team, "teamCount");

      if(teamcount != level.var_79814d80c62f8ebe) {
        players = getteamdata(team, "players");

        foreach(player in players) {
          player dlog_recordplayerevent("dlog_event_br_lp_kick", ["reason", "Kicked due to incomplete squad"]);
          logstring("LeaguePlay: Kicking " + player getxuid() + " due to incomplete squad");
          player.pers["leaguePlayIncompleteSquad"] = 1;
          kick(player getentitynumber(), "EXE/PLAYERKICKED_INCOMPLETESQUAD");
        }
      }
    }
  }
}

function function_d794d8a20e142efa() {
  level endon("game_ended");
  level endon("prematch_done");

  if(getdvarint(@ "hash_f5c6c9de0d50a94a", 1) == 0) {
    return;
  }

  while(true) {
    function_237daa716de2f328();
    wait 3;
  }
}

function function_ca85981ca17b83ef() {
  level endon("game_ended");
  waitforplayers();
  logstring("LeaguePlay: done waiting for players to stream in");

  if(getdvarint(@ "hash_4e03166c385327ee", 1) == 1) {
    timeout = gettime() + level.var_58bec65ec9494d11 * 1000;

    while(gettime() < timeout) {
      var_d6b13083b4470881 = function_5a7cb04f2683c1df();

      if(var_d6b13083b4470881 >= level.var_764459b234d5c391) {
        if(getdvarint(@ "hash_17699fe04fac9749", 1) == 1) {
          logstring("LeaguePlay: live_lobby_minplayers_start ( " + level.var_764459b234d5c391 + " ) requirement satisfied");
          break;
        } else if(getdvarint(@ "hash_efba2ae3c5b484c7", 1) == 1) {
          if(var_d6b13083b4470881 >= level.var_cce73e718062d33c) {
            logstring("LeaguePlay: max_vsps_during_backfill requirement satisfied");
            break;
          }
        }
      }

      foreach(player in level.players) {
        if(isDefined(player.pers["leaguePlayActivityPartyKick"]) && player.pers["leaguePlayActivityPartyKick"] == 0) {
          player dlog_recordplayerevent("dlog_event_br_lp_kick", ["reason", "Activity party kick"]);
          logstring("LeaguePlay: kicking player xuid: " + player getxuid() + " since they've been marked for activity party kick");
          player.pers["leaguePlayActivityPartyKick"] = 1;
          kick(player getentitynumber(), "EXE/PLAYERKICKED_INCOMPLETESQUAD");
        }
      }

      if(isDefined(level.players) && level.players.size < level.var_809aa817d70fd977) {
        if(getdvarint(@ "hash_42b032b7e139b113", 1) == 1) {
          dlog_recordevent("dlog_event_br_lp_match_cancel", ["reason", "Player count dropped below minplayersBeforeDisband while backfilling", "player_count", level.players.size, "min_players", level.var_809aa817d70fd977]);
          logstring("LeaguePlay: cancel match due to player count(" + level.players.size + ") dropping below disband threshold(" + level.var_809aa817d70fd977 + ")");
          thread cancel_match();
          return;
        }
      }

      wait level.var_8a4997ca061aa1e5;
    }
  }

  logstring("LeaguePlay: closing join in progress");
  function_9502b0bb442142b6("join in progress closed");
  function_5ea9c8005581107f();
  function_237daa716de2f328();
  logstring("LeaguePlay: kicked incomplete players if there were any, notifying that backfill closed");

  if(getdvarint(@ "hash_51aa9c88bb0c1224", 1) == 1) {
    level notify("leagueplay_br_backfill_closed");
  }
}

function function_5a7cb04f2683c1df() {
  var_fb40706eab350d91 = getdvarint(@ "hash_52c2d6ea6600d2aa", -1);

  if(var_fb40706eab350d91 >= 0) {
    return var_fb40706eab350d91;
  }

  var_d6b13083b4470881 = 0;

  foreach(team in level.teamnamelist) {
    teamcount = getteamdata(team, "teamCount");

    if(teamcount == level.var_79814d80c62f8ebe) {
      var_d6b13083b4470881 += teamcount;
    }
  }

  return var_d6b13083b4470881;
}

function function_5ea9c8005581107f() {
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  level.nojip = 1;
}

function waitforplayers() {
  starttime = gettime();
  endtime = starttime + level.var_8eed04dc7bdc9766 * 1000;

  while(true) {
    curtime = gettime();
    var_b7652eea48ae3d62 = scripts\mp\gamelogic::getstreamedinplayercount();
    var_93e3fe0e5693889b = var_b7652eea48ae3d62 >= level.var_809aa817d70fd977 + 4;

    if(var_93e3fe0e5693889b || curtime > endtime) {
      break;
    }

    wait 1;
  }
}

function function_562f080949959cfc() {
  level endon("game_ended");
  level endon("prematch_done");

  if(getdvarint(@ "hash_42b032b7e139b113", 1) == 0) {
    return;
  }

  minplayers = getdvarint(@ "br_minplayers", 1);

  while(function_5a7cb04f2683c1df() >= minplayers) {
    wait 1;
  }

  dlog_recordevent("dlog_event_br_lp_match_cancel", ["reason", "Low VSP count in prematch", "player_count", level.players.size, "min_players", minplayers]);

  var_d6b13083b4470881 = function_5a7cb04f2683c1df();
  logstring("<dev string:x330>" + var_d6b13083b4470881 + "<dev string:x361>" + minplayers + "<dev string:x384>");

  thread cancel_match();
}

function function_9a30317c91cfaf5e() {
  if(level.var_7b46fd91db5fefdc) {
    return;
  }

  foreach(player in level.players) {
    if(isDefined(player) && istrue(player.var_632bad3edb4e449e) && istrue(player.var_2ff6825157b156e)) {
      logstring("LeaguePlay: calling setLobbyNotRejoinable to rollback penalty due to squads dropping below rejoinable threshold");
      var_bca6691d9622c899 = function_78fcc96be9d69371();
      gamemode = scripts\cp_mp\challenges::getchallengegamemode(self);
      aeeventname = #"connection_update";
      aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);

      if(var_bca6691d9622c899 > -1) {
        player namespace_bf9ffd2b22c7d819::function_e90d7800fb5eec03(0, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d708505d31d66ef6"), 0, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c9361150947eb728"), function_94c7ae7049488358(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e03f5709c8cd8a03"), function_4f9373a1227db35c(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_23d400c5be24f34b"), var_bca6691d9622c899, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_cbbf84a8e78caeee, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e8d0ec1cb1f306c4"), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25()]);
        continue;
      }

      player namespace_bf9ffd2b22c7d819::function_e90d7800fb5eec03(0, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d708505d31d66ef6"), 0, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c9361150947eb728"), function_94c7ae7049488358(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e03f5709c8cd8a03"), function_4f9373a1227db35c(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_cbbf84a8e78caeee, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e8d0ec1cb1f306c4"), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25()]);
    }
  }

  level.var_7b46fd91db5fefdc = 1;
}

function function_e197f06b7037e7a1(team) {
  teamplayers = getteamdata(team, "players");

  foreach(player in teamplayers) {
    if(isDefined(player) && istrue(player.var_632bad3edb4e449e) && istrue(player.var_2ff6825157b156e)) {
      logstring("LeaguePlay: calling setLobbyNotRejoinable to rollback penalty due to no teammates being alive");
      var_bca6691d9622c899 = function_78fcc96be9d69371();
      gamemode = scripts\cp_mp\challenges::getchallengegamemode(self);
      aeeventname = #"connection_update";
      aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);

      if(var_bca6691d9622c899 > -1) {
        player namespace_bf9ffd2b22c7d819::function_e90d7800fb5eec03(0, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d708505d31d66ef6"), 0, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c9361150947eb728"), function_94c7ae7049488358(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e03f5709c8cd8a03"), function_4f9373a1227db35c(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_23d400c5be24f34b"), var_bca6691d9622c899, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_cbbf84a8e78caeee, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e8d0ec1cb1f306c4"), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25()]);
        continue;
      }

      player namespace_bf9ffd2b22c7d819::function_e90d7800fb5eec03(0, aeeventname, [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d708505d31d66ef6"), 0, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c9361150947eb728"), function_94c7ae7049488358(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e03f5709c8cd8a03"), function_4f9373a1227db35c(), ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_cbbf84a8e78caeee, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e8d0ec1cb1f306c4"), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25()]);
    }
  }
}

function function_4707c41ed8bae2d2(player) {
  if(isDefined(player.pers["leaguePlayInit"])) {
    return (player.pers["leaguePlayInit"] == 1);
  }

  return false;
}

function function_6c42f05b6c82b35e() {
  player = self;

  if(!isPlayer(player) || isbot(player)) {
    return;
  }

  if(isDefined(player.pers["leaguePlayInit"]) && player.pers["leaguePlayInit"] == 1) {
    return;
  }

  xuid = player getxuid();
  player.pers["subpartyIndex"] = function_508d1cbb2f7d25c1(xuid);
  logstring("LeaguePlay: initializing subparty index to: " + player.pers["subpartyIndex"] + " for xuid: " + xuid);
  player.pers["sr"] = player getplayerdata(level.progressiongroup, "leaguePlayData", level.var_bbcb5f6b1b0a78ae, "season", level.var_f67ee22da6041b9b, "sr");
  player.pers["leaguePlayInit"] = 1;
}

function cancel_match() {
  level endon("game_ended");
  warningtime = getdvarfloat(@ "hash_d8ed8c2fccd1d9b1", 30);

  if(warningtime > 0) {
    level.var_60f7d8bd0181980f = 1;
    thread scripts\mp\gamelogic::function_46eb417b582d5179(warningtime * 1000, "match_cancelling_in_squads");
  }

  setomnvar("ui_prematch_period", 0);
  level.leagueplaymatchcancelled = 1;
  level.var_7ebde40af908fcf8 = 0;
  level.brdisablefinalkillcam = 1;
  wait warningtime;

  if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0) {
    foreach(player in level.players) {
      if(!isDefined(player.clientmatchdataid)) {
        scripts\mp\gamelogic::assignclientmatchdataid(player);
      }

      setclientmatchdata("players", player.clientmatchdataid, "leaguePlayMatchCancelled", level.leagueplaymatchcancelled);
    }
  }

  if(!getdvarint(@ "hash_b42271f0cb794f9e", 1)) {
    scripts\mp\gamescore::updateplacement();
    scripts\mp\gamelogic::processlobbydata();
  } else if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0) {
    sendclientmatchdata();
  }

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    function_e6da5914f27071a0();
    wait 1;
    level notify("exitLevel_called");
    exitlevel(0);
    return;
  }

  level thread scripts\mp\gamelogic::forceend();
}

function function_78fcc96be9d69371() {
  if(isDefined(level.var_f67ee22da6041b9b) && level.var_f67ee22da6041b9b >= 0) {
    return level.var_f67ee22da6041b9b;
  }

  return -1;
}

function function_883f3d0fdef74fbf(placement, matchcancelled) {
  player = self;

  if(matchcancelled) {
    return 0;
  }

  if(!isDefined(placement)) {
    return 2;
  }

  if(placement == 1) {
    return 3;
  }

  return 1;
}

function match_start() {
  player = self;

  if(!isPlayer(player) || isbot(player)) {
    return;
  }

  if(!isDefined(player.pers["leaguePlayInit"]) || player.pers["leaguePlayInit"] == 0) {
    return;
  }

  if(istrue(player.pers["leaguePlayDisconnected"])) {
    return;
  }

  lobbyid = function_4f9373a1227db35c();
  matchid = function_94c7ae7049488358();
  var_bca6691d9622c899 = function_78fcc96be9d69371();
  gamemode = scripts\cp_mp\challenges::getchallengegamemode(self);

  if(isDefined(level.leagueid) && var_bca6691d9622c899 > -1) {
    aeeventname = #"hash_22675ae5492f866c";
    aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
    params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5c84471bbbd6a98e"), level.leagueid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_23d400c5be24f34b"), var_bca6691d9622c899, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c9361150947eb728"), matchid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e03f5709c8cd8a03"), lobbyid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f1733e44a51e82be"), level.var_75b72a33aeab21d4, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_cbbf84a8e78caeee, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_9a5ce95c690217e7"), level.var_a176083f858ec97b, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5e6b6b11777a5cb"), level.var_9573ac4c1f716a60];

    if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
      callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
    }
  }
}

function match_end(placement, var_bedbe1ce13e22104, is_disconnect) {
  player = self;
  xuid = player getxuid();

  if(!isDefined(placement)) {
    placement = 0;
  }

  if(!isDefined(var_bedbe1ce13e22104)) {
    logstring("LeaguePlay: Skipping match_end due to undefined at_match_end for xuid " + xuid);
    return;
  }

  if(!isPlayer(player) || isbot(player)) {
    logstring("LeaguePlay: Skipping match_end due to entity not being a player.");
    return;
  }

  if(!isDefined(player.pers["leaguePlayInit"]) || player.pers["leaguePlayInit"] == 0) {
    logstring("LeaguePlay: Skipping match_end due to leaguePlayInit not being set for xuid " + xuid);
    return;
  }

  if(istrue(player.pers["leaguePlayMatchCompleted"])) {
    logstring("LeaguePlay: Skipping match_end since it has already been sent for xuid " + xuid);
    return;
  }

  player.pers["leaguePlayMatchCompleted"] = 1;
  matchcancelled = istrue(level.leagueplaymatchcancelled);
  var_bca6691d9622c899 = function_78fcc96be9d69371();
  gamemode = scripts\cp_mp\challenges::getchallengegamemode(self);
  lobbyid = function_4f9373a1227db35c();
  matchid = function_94c7ae7049488358();
  var_abbf42875a7797ad = getdvarint(@ "hash_74b99125b3898193", 86400);
  forgiveness_level = player.pers["forgiveness_level"];

  if(!isDefined(forgiveness_level)) {
    forgiveness_level = 0;
  }

  matchresult = player function_883f3d0fdef74fbf(placement, matchcancelled);

  if(!isDefined(level.leagueid)) {
    logstring("LeaguePlay: Skipping match end event due to invalid league ID for user " + xuid);
    return;
  }

  if(!isDefined(matchresult)) {
    logstring("LeaguePlay: Skipping match end event due to invalid match result for user " + xuid);
    return;
  }

  if(var_bca6691d9622c899 <= -1) {
    logstring("LeaguePlay: Skipping match end event due to invalid league season for user " + xuid);
    return;
  }

  aeeventname = #"hash_46314392af70142b";
  aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
  reportvalues = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5c84471bbbd6a98e"), level.leagueid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d555f3589ac28cc"), matchresult, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_23d400c5be24f34b"), var_bca6691d9622c899, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c9361150947eb728"), matchid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e03f5709c8cd8a03"), lobbyid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f1733e44a51e82be"), level.var_75b72a33aeab21d4, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_cb5895c719e93d31"), var_abbf42875a7797ad, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d885ae7541734272"), var_bedbe1ce13e22104, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_cbbf84a8e78caeee, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_28284b187b4b4c21"), forgiveness_level, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_334ca6ff472c2d06"), placement, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d708505d31d66ef6"), is_disconnect, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e8d0ec1cb1f306c4"), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25()];

  if(getdvarint(@ "hash_6c80c23763bc8efb", 0)) {
    player thread function_43230c03c0098996(reportvalues);
    return;
  }

  if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
    player callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", "80", reportvalues);
  }
}

function function_43230c03c0098996(reportvalues) {
  var_2876bd36736c8c7f = getdvarfloat(@ "hash_743498c38d8aa460", 2);
  waittill_any_timeout_1(var_2876bd36736c8c7f, "disconnect");

  if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
    callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", "80", reportvalues);
  }
}

function function_e6da5914f27071a0() {
  level.gameended = 1;
  level.leagueplaymatchcompleted = 1;
  matchcancelled = istrue(level.leagueplaymatchcancelled);
  var_bca6691d9622c899 = function_78fcc96be9d69371();
  gamemode = scripts\cp_mp\challenges::getchallengegamemode(self);
  lobbyid = function_4f9373a1227db35c();
  matchid = function_94c7ae7049488358();
  var_abbf42875a7797ad = getdvarint(@ "hash_74b99125b3898193", 86400);

  foreach(player in level.players) {
    if(!isPlayer(player) || isbot(player)) {
      continue;
    }

    if(!isDefined(player.pers["leaguePlayInit"]) || player.pers["leaguePlayInit"] == 0) {
      continue;
    }

    if(istrue(player.pers["leaguePlayDisconnected"])) {
      continue;
    }

    placement = 0;
    matchresult = player function_883f3d0fdef74fbf(undefined, matchcancelled);

    if(isDefined(level.leagueid) && isDefined(matchresult) && var_bca6691d9622c899 > -1) {
      aeeventname = #"hash_46314392af70142b";
      aeeventid = ae_utility::function_6e2deb013c9ca85e(aeeventname);
      params = [ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5c84471bbbd6a98e"), level.leagueid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d555f3589ac28cc"), matchresult, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_23d400c5be24f34b"), var_bca6691d9622c899, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_c9361150947eb728"), matchid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e03f5709c8cd8a03"), lobbyid, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_f1733e44a51e82be"), level.var_75b72a33aeab21d4, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_cb5895c719e93d31"), var_abbf42875a7797ad, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d885ae7541734272"), 1, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_5fba2f25f07000f5"), level.var_cbbf84a8e78caeee, ae_utility::function_d6f771aedba70ce7(aeeventname, #"gamemode"), gamemode, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_28284b187b4b4c21"), 100, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_334ca6ff472c2d06"), placement, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_d708505d31d66ef6"), 0, ae_utility::function_d6f771aedba70ce7(aeeventname, #"hash_e8d0ec1cb1f306c4"), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25()];

      if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
        player callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
      }
    }
  }
}

function function_b9a99d80c18f3c6b() {
  if(isDefined(level.var_e461f6b82b97cc19)) {
    return;
  }

  var_257795cb138d946a = getscriptbundle("wzleagueplaysrtriggers:iw9_wz_leagueplay_sr_triggers");
  assertex(isDefined(var_257795cb138d946a), "<dev string:x389>");
  var_5eafc68070d5e0cd = undefined;

  foreach(var_307d37c6248a5f8 in var_257795cb138d946a.var_9e33e57bb41164eb) {
    bundleversion = ter_op(isDefined(var_307d37c6248a5f8.version), var_307d37c6248a5f8.version, 0);

    if(bundleversion == level.var_a176083f858ec97b) {
      var_5eafc68070d5e0cd = var_307d37c6248a5f8;
      break;
    }

    var_5a96955026675112 = 0;

    if(isDefined(var_5eafc68070d5e0cd) && isDefined(var_5eafc68070d5e0cd.version)) {
      var_5a96955026675112 = var_5eafc68070d5e0cd.version;
    }

    if(!isDefined(var_5eafc68070d5e0cd) || bundleversion > var_5a96955026675112) {
      var_5eafc68070d5e0cd = var_307d37c6248a5f8;
    }
  }

  if(!isDefined(var_5eafc68070d5e0cd)) {
    return;
  }

  level.var_e461f6b82b97cc19 = spawnStruct();
  level.var_e461f6b82b97cc19.var_696b5913bd732376 = [];

  foreach(triggertype in var_5eafc68070d5e0cd.triggers) {
    scorestruct = spawnStruct();
    scorestruct.var_5763131521e910e1 = [];
    scorestruct.var_602223d6e01fd5b5 = [];

    foreach(trigger in triggertype.triggers) {
      teamsremaining = trigger.var_5763131521e910e1;

      if(!isDefined(teamsremaining)) {
        teamsremaining = 0;
      }

      scorestruct.var_5763131521e910e1[scorestruct.var_5763131521e910e1.size] = teamsremaining;
      srval = trigger.sr;

      if(!isDefined(srval)) {
        srval = 0;
      }

      scorestruct.var_602223d6e01fd5b5[scorestruct.var_602223d6e01fd5b5.size] = srval;
    }

    if(triggertype.triggername == "placement") {
      scorestruct.var_602223d6e01fd5b5 = function_546e92e285c884a(scorestruct.var_602223d6e01fd5b5);
      level.var_e461f6b82b97cc19.var_696b5913bd732376[3] = scorestruct;
      var_95eb99747525d474 = level.var_e461f6b82b97cc19.var_696b5913bd732376[3].var_5763131521e910e1.size - 1;
      level.var_e461f6b82b97cc19.var_ac0560ffa2ea0ad = var_95eb99747525d474;
      continue;
    }

    if(triggertype.triggername == "kill") {
      level.var_e461f6b82b97cc19.var_696b5913bd732376[0] = scorestruct;
      continue;
    }

    if(triggertype.triggername == "assist") {
      level.var_e461f6b82b97cc19.var_696b5913bd732376[1] = scorestruct;
      continue;
    }

    if(triggertype.triggername == "unassisted") {
      level.var_e461f6b82b97cc19.var_696b5913bd732376[2] = scorestruct;
    }
  }

  level.var_e461f6b82b97cc19.var_696b5913bd732376[4] = function_fd1ac57db0563c35("wzleagueplaydeploymentfees:iw9_wz_leagueplay_deployment_fees");

  if(function_7a857500882a5379()) {
    level.var_e461f6b82b97cc19.var_696b5913bd732376[5] = function_fd1ac57db0563c35("wzleagueplayresurgencedeathfees:iw9_wz_leagueplay_resurgence_death_fees");
  }
}

function function_fd1ac57db0563c35(bundlename) {
  bundlebasename = strtoksubstr(bundlename, ":")[0];
  var_2c900d8096471151 = getscriptbundle(bundlename);
  assertex(isDefined(var_2c900d8096471151), "<dev string:x3cd>" + bundlebasename + "<dev string:x3e9>");
  var_a6ad8a7ab133e16e = spawnStruct();
  var_a6ad8a7ab133e16e.var_e03f12a82126047b = [];
  var_a6ad8a7ab133e16e.endsr = [];
  var_a6ad8a7ab133e16e.penaltyvalue = [];
  assertex(isDefined(var_2c900d8096471151.fees), "<dev string:x3f7>" + bundlebasename + "<dev string:x40d>");
  index = 0;

  foreach(var_b6468e2e27024876 in var_2c900d8096471151.fees) {
    var_e03f12a82126047b = 0;
    endsr = 0;
    fee = 0;

    if(isDefined(var_b6468e2e27024876.var_e03f12a82126047b)) {
      var_e03f12a82126047b = var_b6468e2e27024876.var_e03f12a82126047b;
    }

    if(isDefined(var_b6468e2e27024876.endsr)) {
      endsr = var_b6468e2e27024876.endsr;
    }

    if(isDefined(var_b6468e2e27024876.fee)) {
      fee = var_b6468e2e27024876.fee;
    }

    var_a6ad8a7ab133e16e.var_e03f12a82126047b[index] = var_e03f12a82126047b;
    var_a6ad8a7ab133e16e.endsr[index] = endsr;
    var_a6ad8a7ab133e16e.penaltyvalue[index] = fee;
    index++;
  }

  return var_a6ad8a7ab133e16e;
}

function function_546e92e285c884a(valuearray) {
  newarray = [];

  for(index = 0; index < valuearray.size; index++) {
    if(index == valuearray.size - 1) {
      newarray[index] = valuearray[index];
      break;
    }

    difference = valuearray[index] - valuearray[index + 1];
    newarray[index] = difference;
  }

  return newarray;
}

function function_bc0b95efa029ffb(var_2d23f02e647a1ed5, optionalarg) {
  assertex(isDefined(var_2d23f02e647a1ed5), "<dev string:x444>");
  player = self;

  if(var_2d23f02e647a1ed5 == "kill") {
    player function_cc11b7aeffd6b54a(0, optionalarg);
    return;
  }

  if(var_2d23f02e647a1ed5 == "assist") {
    player function_cc11b7aeffd6b54a(1, optionalarg);
    return;
  }

  if(var_2d23f02e647a1ed5 == "unassisted") {
    player function_cc11b7aeffd6b54a(2, optionalarg);
    return;
  }

  if(var_2d23f02e647a1ed5 == "placement") {
    function_123fc096f9059fe0(0, optionalarg);
    return;
  }

  if(var_2d23f02e647a1ed5 == "deploymentfee") {
    player function_cc11b7aeffd6b54a(4);
    return;
  }

  if(var_2d23f02e647a1ed5 == "deathfee") {
    player function_cc11b7aeffd6b54a(5);
    return;
  }

  assertmsg("<dev string:x479>" + var_2d23f02e647a1ed5 + "<dev string:x496>");
}

function function_cfff1dfa3522761a(srtype, var_1ec56f9e5ec2ef34) {
  valuestruct = function_d262826255e696e9(srtype);
  assertex(isDefined(valuestruct.var_5763131521e910e1), "<dev string:x4b1>");
  maxtier = valuestruct.var_5763131521e910e1.size - 1;
  var_5763131521e910e1 = scripts\cp_mp\challenges::function_5d99311b5a7dffda();

  if(srtype != 3 && isDefined(var_1ec56f9e5ec2ef34)) {
    var_5763131521e910e1 = function_5b4b593ace7e0ac1(var_5763131521e910e1, var_1ec56f9e5ec2ef34);
  }

  for(tierindex = 0; tierindex <= maxtier; tierindex++) {
    if(var_5763131521e910e1 > valuestruct.var_5763131521e910e1[tierindex]) {
      continue;
    }

    return tierindex;
  }

  return maxtier;
}

function function_93f8804217884a25(srtype, var_1ec56f9e5ec2ef34) {
  assertex(isDefined(level.var_e461f6b82b97cc19), "<dev string:x4e4>");
  player = self;

  if(srtype == 3) {
    return function_be03c4a8b29d8cfc(srtype, level.var_e461f6b82b97cc19.var_ac0560ffa2ea0ad);
  }

  if(function_eefff17ad836a17e(srtype)) {
    return player function_cd3d2fd0d6fbea02(srtype);
  }

  tierindex = function_cfff1dfa3522761a(srtype, var_1ec56f9e5ec2ef34);
  return function_be03c4a8b29d8cfc(srtype, tierindex);
}

function function_be03c4a8b29d8cfc(srtype, tierindex) {
  valuestruct = function_d262826255e696e9(srtype);
  assertex(isDefined(valuestruct.var_602223d6e01fd5b5), "<dev string:x524>");
  return valuestruct.var_602223d6e01fd5b5[tierindex];
}

function function_d262826255e696e9(srtype) {
  assertex(isDefined(level.var_e461f6b82b97cc19), "<dev string:x54a>");
  return level.var_e461f6b82b97cc19.var_696b5913bd732376[srtype];
}

function function_7a857500882a5379() {
  if(getsubgametype() == "resurgence") {
    return true;
  }

  return false;
}

function function_cd3d2fd0d6fbea02(var_1cfbed628e4e00f4) {
  player = self;
  assertex(function_eefff17ad836a17e(var_1cfbed628e4e00f4), "<dev string:x592>" + var_1cfbed628e4e00f4);
  playersr = 0;

  if(isDefined(player.pers["sr"])) {
    playersr = player.pers["sr"];
  }

  var_a6ad8a7ab133e16e = function_d262826255e696e9(var_1cfbed628e4e00f4);
  var_3829b53649865904 = var_a6ad8a7ab133e16e.penaltyvalue[var_a6ad8a7ab133e16e.penaltyvalue.size - 1];

  for(index = 0; index < var_a6ad8a7ab133e16e.penaltyvalue.size; index++) {
    if(playersr >= var_a6ad8a7ab133e16e.var_e03f12a82126047b[index] && playersr < var_a6ad8a7ab133e16e.endsr[index]) {
      var_3829b53649865904 = var_a6ad8a7ab133e16e.penaltyvalue[index];
      break;
    }
  }

  return -1 * var_3829b53649865904;
}

function function_3ec6d3cd62b16199() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  allplayers = scripts\mp\gametypes\br::function_f297f4741391514d();

  foreach(player in level.players) {
    player[[level.var_561addf876799987]]("deploymentfee");
  }
}

function function_eefff17ad836a17e(srtype) {
  return srtype == 4 || srtype == 5;
}

function function_123fc096f9059fe0(forceupdate, eliminatedteam) {
  assertex(isDefined(level.var_e461f6b82b97cc19), "<dev string:x54a>");

  if(isDefined(eliminatedteam)) {
    function_f6185e055127f5(eliminatedteam, 1);
  }

  tierindex = function_cfff1dfa3522761a(3);

  if(tierindex < level.var_e461f6b82b97cc19.var_ac0560ffa2ea0ad || istrue(forceupdate)) {
    level.var_e461f6b82b97cc19.var_ac0560ffa2ea0ad = tierindex;
    thread function_54a23beb9c779f84();
  }
}

function function_54a23beb9c779f84() {
  level endon("game_ended");
  assertex(isDefined(level.var_e461f6b82b97cc19), "<dev string:x5d7>");
  waitframe();
  var_bb26fe41cf283738 = scripts\mp\gametypes\br::function_f297f4741391514d();

  foreach(player in var_bb26fe41cf283738) {
    player function_cc11b7aeffd6b54a(3);
  }
}

function function_9a9e71365eb6010b(assistingplayers, victim) {
  attacker = self;
  level endon("game_ended");

  if(isDefined(attacker.team) && issharedfuncdefined("game", "getTeamData")) {
    attackersquad = [[getsharedfunc("game", "getTeamData")]](attacker.team, "players");

    if(isDefined(assistingplayers)) {
      if(!isarray(assistingplayers)) {
        assistingplayers = [assistingplayers];
      }

      attackersquad = array_remove_array(attackersquad, assistingplayers);
    }

    foreach(squadmate in attackersquad) {
      if(squadmate != attacker) {
        squadmate function_cc11b7aeffd6b54a(2, victim);
      }
    }
  }
}

function function_f6185e055127f5(team, hidden) {
  players = getteamdata(team, "players");

  foreach(player in players) {
    player function_7b4d239188b80bb1(hidden, 1);
  }
}

function function_7b4d239188b80bb1(hidden, forcetoggle) {
  player = self;

  if(!istrue(forcetoggle) && !istrue(level.var_ad381e249ebe26d0)) {
    return;
  }

  player setclientomnvar("ui_br_skillrank_widget_hidden", hidden);
}

function function_cc11b7aeffd6b54a(srtype, optionalarg) {
  if(!istrue(level.var_77907d733abe8b63)) {
    return;
  }

  player = self;

  if(!isDefined(player.var_8eda8a21ec98626f)) {
    player.var_8eda8a21ec98626f = 0;
  }

  if(!isDefined(player.var_86a8dca0c21f00df)) {
    player.var_86a8dca0c21f00df = 0;
  }

  if(!isDefined(player.var_1ba3942d47bee37e)) {
    player.var_1ba3942d47bee37e = 0;
  }

  var_36f3228e1d630f1b = player function_93f8804217884a25(srtype, optionalarg);

  if((srtype == 0 || srtype == 1 || srtype == 2) && level.var_9573ac4c1f716a60 > 0) {
    if(player.var_1ba3942d47bee37e >= level.var_9573ac4c1f716a60) {
      var_36f3228e1d630f1b = 0;

      if(!isDefined(player.var_ba95011c2f9d16b4)) {
        player.var_ba95011c2f9d16b4 = 0;
      }

      if(player.var_ba95011c2f9d16b4 < level.var_a663d955218dcc0c) {
        player iprintln(&"MP_BR_INGAME/KILL_SR_LIMIT");
        player.var_ba95011c2f9d16b4++;
      }
    } else {
      player.var_1ba3942d47bee37e += var_36f3228e1d630f1b;
    }
  }

  if(srtype == 4) {
    player.var_86a8dca0c21f00df = var_36f3228e1d630f1b;
  }

  player.var_8eda8a21ec98626f = int(max(player.var_8eda8a21ec98626f + var_36f3228e1d630f1b, player.var_86a8dca0c21f00df));
  var_f6adbcd287921ab6 = player.var_8eda8a21ec98626f < 0;
  var_1343ab307ce38f3b = var_36f3228e1d630f1b < 0;
  packedvalue = 0;
  maxvalue = 134217728 - 1;
  bitspacked = 0;
  packedvalue += (int(abs(player.var_8eda8a21ec98626f)) &maxvalue) << bitspacked;
  bitspacked += 10;
  packedvalue += (int(var_f6adbcd287921ab6) &maxvalue) << bitspacked;
  bitspacked += 1;
  packedvalue += (int(abs(var_36f3228e1d630f1b)) &maxvalue) << bitspacked;
  bitspacked += 8;
  packedvalue += (int(var_1343ab307ce38f3b) &maxvalue) << bitspacked;
  bitspacked += 1;
  packedvalue += (int(level.var_e461f6b82b97cc19.var_ac0560ffa2ea0ad) &maxvalue) << bitspacked;
  bitspacked += 4;
  packedvalue += (int(srtype) &maxvalue) << bitspacked;
  player setclientomnvar("ui_br_skillrank_widget_data", packedvalue);
}

function function_7e9f0b973f0cdda3(attacker, var_b9c265f657115663) {
  victim = self;

  if(isDefined(attacker)) {
    if(istrue(var_b9c265f657115663)) {
      attacker scripts\mp\gamescore::function_5a48de6e3fb64115();

      if(isDefined(level.var_561addf876799987)) {
        attacker[[level.var_561addf876799987]]("assist", victim);
      }
    } else {
      if(isDefined(level.var_561addf876799987)) {
        attacker[[level.var_561addf876799987]]("kill", victim);
      }

      assistingplayers = victim.attackers;

      if(istrue(victim.var_f215f63a4834bb72)) {
        assistingplayers[assistingplayers.size] = self.lastattackedshieldplayer;
      }

      attacker scripts\mp\gamescore::function_6251f7723be2f90c(victim, assistingplayers);
    }
  }

  if(function_7a857500882a5379()) {
    victim[[level.var_561addf876799987]]("deathfee");
  }
}

function function_5b4b593ace7e0ac1(squadsremaining, victim) {
  if(isDefined(victim) && scripts\mp\gametypes\br::function_99e3948bfd8a99b8(victim.team) == 0) {
    squadsremaining += 1;
  }

  return squadsremaining;
}