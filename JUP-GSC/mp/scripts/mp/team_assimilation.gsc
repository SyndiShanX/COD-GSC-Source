/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\team_assimilation.gsc
***********************************************/

#using script_2342b8aad723994e;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\cash;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\menus;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace team_assimilation;

function init() {
  registersharedfunc("teamAssim", "requestLeaveTeam", &requestleaveteam);
  registersharedfunc("teamAssim", "requestNearbyTeamChange", &requestnearbyteamchange);
  registersharedfunc("teamAssim", "resolveAssimRequest", &resolveassimrequest);
  registersharedfunc("teamAssim", "isWaitingForAssimResponse", &iswaitingforassimresponse);
  registersharedfunc("teamAssim", "isEnabled", &function_6934349b7823d888);
  registersharedfunc("teamAssim", "disablePlayer", &function_bb4125d6847af349);
  registersharedfunc("teamAssim", "enablePlayer", &function_59cf08630dd70540);
  registersharedfunc("teamAssim", "isPlayersAssimDisabled", &isplayersassimdisabled);
  registersharedfunc("teamAssim", "permanentlyDisableAssim", &permanentlydisableassim);
  registersharedfunc("teamAssim", "registerTeamAssimilateCallback", &registerteamassimilatecallback);
  registersharedfunc("teamAssim", "canAssimilate", &canassimilate);
  registersharedfunc("teamAssim", "canTeamAssimilate", &canteamassimilate);
  registersharedfunc("teamAssim", "assimilatePlayer", &assimilateplayer);
  registersharedfunc("teamAssim", "shouldAutoAcceptTeamSwitch", &shouldautoacceptteamswitch);
  registersharedfunc("teamAssim", "getMaxAssimilationTeamSize", &getmaxassimilationteamsize);
  registersharedfunc("teamAssim", "sendDirectAssimRequest", &senddirectassimrequest);

  if(squad_utility::issquadmode()) {
    namespace_c31609f90efcf2ca::function_a99987c7bf114da4(&function_2a1e4811621fdcde);
  }

  level thread function_ec7c2b6761cd9ab3();
}

function registerteamassimilatecallback(callback) {
  if(!isDefined(level.var_6b08d5e6b7943575)) {
    level.var_6b08d5e6b7943575 = [];
  }

  level.var_6b08d5e6b7943575[level.var_6b08d5e6b7943575.size] = callback;
}

function function_80139212a4c66a94(player, oldteam, newteam, oldsquadindex, newsquadindex) {
  if(!isDefined(level.var_6b08d5e6b7943575)) {
    return;
  }

  foreach(callback in level.var_6b08d5e6b7943575) {
    [[callback]](player, oldteam, newteam);
  }

  params = spawnStruct();
  params.player = player;
  params.oldsquadindex = oldsquadindex;
  params.newsquadindex = newsquadindex;
  params.oldteam = oldteam;
  params.newteam = newteam;
  scripts\common\callbacks::callback("player_assimilated", params);
}

function function_6934349b7823d888() {
  if(!isDefined(level.var_cc0d5a1e8a904e5c)) {
    if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.var_1685d95f041d2a96)) {
      level.var_cc0d5a1e8a904e5c = level.gametypebundle.var_1685d95f041d2a96 && getdvarint(@ "scr_team_assimilation_enabled", 1);
    } else {
      level.var_cc0d5a1e8a904e5c = getdvarint(@ "scr_team_assimilation_enabled", 0);
    }
  }

  return level.var_cc0d5a1e8a904e5c;
}

function function_9f3b05f2ea701548() {
  if(!isDefined(level.var_f759b9e710865ce3)) {
    level.var_f759b9e710865ce3 = getdvarint(@ "hash_1d0d8806c4170519", 0);
  }

  return level.var_f759b9e710865ce3;
}

function getmaxassimilationteamsize() {
  if(!isDefined(level.var_5f92f1f4d7faf5a0)) {
    if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.var_e4db1f07df5076a0)) {
      level.var_5f92f1f4d7faf5a0 = getdvarint(@ "hash_cf23e6b4c2ae4e63", level.gametypebundle.var_e4db1f07df5076a0);
    } else {
      level.var_5f92f1f4d7faf5a0 = getdvarint(@ "hash_cf23e6b4c2ae4e63", level.maxteamsize);
    }
  }

  return level.var_5f92f1f4d7faf5a0;
}

function function_82aca4b8517cf46a() {
  if(!isDefined(level.var_414ea35a258152f2)) {
    level.var_414ea35a258152f2 = getdvarint(@ "hash_a530e29a7e6e465f", 10);
  }

  return level.var_414ea35a258152f2;
}

function function_47e8570f3b3f9f83() {
  if(!isDefined(level.var_e69e9946b0c86b5b)) {
    level.var_e69e9946b0c86b5b = getdvarint(@ "hash_2295fd2d3dd21f90", 20);
  }

  return level.var_e69e9946b0c86b5b;
}

function function_ef81e6fd30058e1b() {
  if(!isDefined(level.var_2cdb5739576268c2)) {
    level.var_2cdb5739576268c2 = getdvarint(@ "hash_b030f536fdd71efb", 1);
  }

  return level.var_2cdb5739576268c2;
}

function function_75a3d83d6f553a46() {
  if(!isDefined(level.var_c650833ce57ce717)) {
    level.var_c650833ce57ce717 = getdvarint(@ "hash_f1801dd0c0e36ab6", 5);
  }

  return level.var_c650833ce57ce717;
}

function function_f258ca1fd3c63122() {
  if(!isDefined(level.var_4466ec3279c26727)) {
    level.var_4466ec3279c26727 = getdvarint(@ "hash_bb74d762ec936b6d", 1000);
  }

  return level.var_4466ec3279c26727;
}

function canteamassimilate(team) {
  if(!function_6934349b7823d888()) {
    return false;
  }

  players = scripts\mp\utility\teams::getteamdata(team, "players");
  teamsize = players.size;
  return teamsize < getmaxassimilationteamsize();
}

function function_2a6e88019515e213(team, squadid) {
  if(!function_6934349b7823d888()) {
    return false;
  }

  if(!isDefined(level.squaddata[team]) || !isDefined(level.squaddata[team][squadid])) {
    return false;
  }

  return level.squaddata[team][squadid].players.size < getmaxassimilationteamsize();
}

function canassimilate(playerswitching, var_784c8ada1184ff89, var_e80f1eb2c1910ad4, hidemessage) {
  if(!isDefined(playerswitching) || !isDefined(var_784c8ada1184ff89)) {
    return false;
  }

  if(isplayersassimdisabled(var_e80f1eb2c1910ad4)) {
    var_e80f1eb2c1910ad4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_DISABLED");
    return false;
  }

  if(isplayersassimdisabled(playerswitching) || isplayersassimdisabled(var_784c8ada1184ff89)) {
    var_e80f1eb2c1910ad4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_DISABLED_ENEMY");
    return false;
  }

  usingsquads = isDefined(level.squaddata);
  var_1672c24528714d7d = var_784c8ada1184ff89.team;

  if(usingsquads && playerswitching.sessionsquadid == var_784c8ada1184ff89.sessionsquadid) {
    return false;
  } else if(!usingsquads && var_1672c24528714d7d == playerswitching.team) {
    return false;
  }

  if(!function_4aaeca4295a600d(var_784c8ada1184ff89, playerswitching, var_e80f1eb2c1910ad4, hidemessage)) {
    return false;
  }

  return true;
}

function iswaitingforassimresponse(player) {
  return isDefined(player.var_7f1423df13bbb144);
}

function private shouldautoacceptteamswitch() {
  if(!isDefined(level.autoacceptteamswitch)) {
    level.autoacceptteamswitch = getdvarint(@ "hash_a267ff0e64f57760", 0);
  }

  return level.autoacceptteamswitch;
}

function private function_4aaeca4295a600d(var_784c8ada1184ff89, playerswitching, var_e80f1eb2c1910ad4, var_72ce9fa792fd31a1) {
  if(function_9f3b05f2ea701548() && !istrue(playerswitching.inlaststand)) {
    if(!istrue(var_72ce9fa792fd31a1)) {
      var_e80f1eb2c1910ad4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_PLAYER_NOT_DOWNED");
    }

    return false;
  } else if(isDefined(level.squaddata) && !function_2a6e88019515e213(var_784c8ada1184ff89.team, var_784c8ada1184ff89.sessionsquadid)) {
    if(!istrue(var_72ce9fa792fd31a1)) {
      var_e80f1eb2c1910ad4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_TEAM_SIZE");
    }

    return false;
  } else if(!isDefined(level.squaddata) && !canteamassimilate(var_784c8ada1184ff89.team)) {
    if(!istrue(var_72ce9fa792fd31a1)) {
      var_e80f1eb2c1910ad4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_TEAM_SIZE");
    }

    return false;
  } else if(playerswitching scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    if(!istrue(var_72ce9fa792fd31a1)) {
      var_e80f1eb2c1910ad4 scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_PLAYER_IN_VEHICLE");
    }

    return false;
  }

  return true;
}

function function_bb4125d6847af349(player, request) {
  if(!isDefined(player.var_cd20b5c89ca5f5d0)) {
    player.var_cd20b5c89ca5f5d0 = [];
  }

  initiallydisabled = isplayersassimdisabled(player);
  player.var_cd20b5c89ca5f5d0[request] = 1;
  nowdisabled = isplayersassimdisabled(player);

  if(nowdisabled && !initiallydisabled) {
    player setclientomnvar("ui_assimilation_disabled", 1);
  }
}

function function_59cf08630dd70540(player, request) {
  if(!isDefined(player.var_cd20b5c89ca5f5d0)) {
    player.var_cd20b5c89ca5f5d0 = [];
  }

  initiallydisabled = isplayersassimdisabled(player);
  player.var_cd20b5c89ca5f5d0[request] = undefined;
  nowdisabled = isplayersassimdisabled(player);

  if(!nowdisabled && initiallydisabled) {
    player setclientomnvar("ui_assimilation_disabled", 0);
  }
}

function isplayersassimdisabled(player) {
  return istrue(level.var_ed844db90cb6d370) || isDefined(player.var_cd20b5c89ca5f5d0) && player.var_cd20b5c89ca5f5d0.size;
}

function permanentlydisableassim() {
  if(istrue(level.var_ed844db90cb6d370)) {
    return;
  }

  foreach(player in level.players) {
    function_bb4125d6847af349(player, "permanent");
  }

  level.var_ed844db90cb6d370 = 1;
}

function function_a84bf6c8ff064511(targetplayer) {
  targetplayer.var_7f1423df13bbb144 = undefined;
  targetplayer.var_4f8afa3693e318d4 = undefined;
  targetplayer.var_312490cd130c9914 = undefined;
  targetplayer setclientomnvar("ui_assimilation_clientnum", -1);
}

function function_e81936c3b6775f2b(player) {
  if(isplayersassimdisabled(player)) {
    if(player scripts\mp\laststand::function_a2dd7d8143656503(player)) {
      player scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/BLOCKED_BY_INTERROGATE");
    } else if(isDefined(level.var_3938090780aa0be)) {
      [[level.var_3938090780aa0be]](player);
    }

    return false;
  } else if(player scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    player scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_PLAYER_IN_VEHICLE");
    return false;
  }

  return true;
}

function function_b530aa511cac761(player) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("assimilation_resolved");
  timeout = function_47e8570f3b3f9f83();
  wait timeout;
  function_a84bf6c8ff064511(player);
}

function function_e5dbb2b054d0cabd(player, blockedteam) {
  level endon("game_ended");
  player endon("disconnect");
  period = function_75a3d83d6f553a46();
  player.damageblockedteam = blockedteam;
  wait period;
  player.damageblockedteam = undefined;
}

function requestleaveteam(player) {
  if(!getdvarint(@ "hash_df8987540c302b00", 0)) {
    return 0;
  }

  if(!function_e81936c3b6775f2b(player)) {
    return 0;
  }

  usingsquads = isDefined(level.squaddata);

  if(!usingsquads) {
    return 0;
  }

  if(level.squaddata[player.team][player.sessionsquadid].players.size <= 1) {
    player scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_SOLO");
    return 0;
  }

  oldteam = player.team;
  oldsquadindex = player.sessionsquadid;
  player callback::callback("player_request_leave_team");
  squads::leavesquad(oldteam, oldsquadindex);
  squads::requestnewsquad(player.team, undefined, 0);
  leavingteammembers = [];
  oldteammembers = [];

  if(isDefined(level.squaddata[oldteam][oldsquadindex])) {
    oldteammembers = level.squaddata[oldteam][oldsquadindex].players;
  }

  scripts\cp_mp\calloutmarkerping::function_47990577bda08bb4(player, oldteammembers);
  player scripts\cp_mp\calloutmarkerping::calloutmarkerping_removeallcalloutsforplayer();

  foreach(teammember in oldteammembers) {
    if(isDefined(teammember) && player != teammember) {
      scripts\cp_mp\calloutmarkerping::function_47990577bda08bb4(teammember, [player]);
      leavingteammembers[leavingteammembers.size] = teammember;
    }
  }

  scripts\cp_mp\overlord::playevent("assim_request_response_leaving_team", leavingteammembers);

  if(issharedfuncdefined("hud", "showBrDMZSplash")) {
    [[getsharedfunc("hud", "showBrDMZSplash")]]("player_left_alone", [player], undefined, undefined, undefined, level.splashlistoverride);
    players = oldteammembers;

    if(isDefined(players)) {
      players = array_remove(players, player);
      [[getsharedfunc("hud", "showBrDMZSplash")]]("player_left_team", players, undefined, player getentitynumber(), undefined, level.splashlistoverride);
    }
  }

  function_810613fb0e83165e(player.team, player.sessionsquadid, player);
  function_9ad90f0a744225a8(player.team);
  function_80139212a4c66a94(player, oldteam, player.team, oldsquadindex, player.sessionsquadid);
}

function requestnearbyteamchange(player, var_99bcf6bdf31a0e49) {
  if(!function_e81936c3b6775f2b(player)) {
    return 0;
  }

  usingsquads = isDefined(level.squaddata);

  if(!var_99bcf6bdf31a0e49 && (!usingsquads && !canteamassimilate(player.team) || usingsquads && !function_2a6e88019515e213(player.team, player.sessionsquadid))) {
    player scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/ASSIM_FAILED_TEAM_SIZE");
    return 0;
  }

  if(issharedfuncdefined("hud", "showBrDMZSplash")) {
    if(var_99bcf6bdf31a0e49) {
      [[getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_used_join_on_target", [player], undefined, undefined, undefined, level.splashlistoverride);
    } else {
      [[getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_used", [player], undefined, undefined, undefined, level.splashlistoverride);
    }
  }

  requestradius = function_f258ca1fd3c63122();
  playersinradius = scripts\mp\utility\player::getplayersinradius(player.origin, requestradius);
  var_3d290d914e1249a0 = [];
  var_e4fc35b9446269cf = function_ef81e6fd30058e1b();

  foreach(targetplayer in playersinradius) {
    if(targetplayer == player || !isPlayer(targetplayer) || isplayersassimdisabled(targetplayer)) {
      continue;
    }

    if(usingsquads && self.sessionsquadid == targetplayer.sessionsquadid) {
      continue;
    } else if(!usingsquads && targetplayer.team == player.team) {
      continue;
    }

    success = senddirectassimrequest(player, targetplayer, var_99bcf6bdf31a0e49, var_e4fc35b9446269cf);

    if(istrue(success)) {
      var_3d290d914e1249a0[var_3d290d914e1249a0.size] = targetplayer;
    }
  }

  if(!var_99bcf6bdf31a0e49) {
    scripts\cp_mp\overlord::playevent("assim_request_you_join_me", [player]);
  }

  if(var_3d290d914e1249a0.size > 0) {
    scripts\cp_mp\overlord::playevent("assim_request_nearby", var_3d290d914e1249a0);
    callsharedfunc("pmc_missions", "onRequestTeamAssimilate", player, var_3d290d914e1249a0);
  }
}

function resolveassimrequest(player, var_e3f7965361b1e757) {
  assert(isDefined(player.var_7f1423df13bbb144));
  playerswitching = ter_op(istrue(player.var_4f8afa3693e318d4), player.var_7f1423df13bbb144, player);
  var_784c8ada1184ff89 = ter_op(istrue(player.var_4f8afa3693e318d4), player, player.var_7f1423df13bbb144);

  if(!canassimilate(playerswitching, var_784c8ada1184ff89, player, 0)) {
    player setclientomnvar("ui_assimilation_clientnum", -1);
    return;
  }

  if(var_e3f7965361b1e757) {
    assimilateplayer(playerswitching, var_784c8ada1184ff89, 0);

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      scripts\mp\gametypes\br::updateplayerandteamcountui();
    }
  } else if(player.var_4f8afa3693e318d4) {
    [[getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_request_denied_join_on_target", [player.var_7f1423df13bbb144], undefined, undefined, undefined, level.splashlistoverride);
    [[getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_request_you_denied_join_on_target", [player], undefined, undefined, undefined, level.splashlistoverride);
  } else {
    [[getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_request_denied", [player.var_7f1423df13bbb144], undefined, player getentitynumber(), undefined, level.splashlistoverride);
    [[getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_request_you_denied", [player], undefined, undefined, undefined, level.splashlistoverride);
  }

  function_a84bf6c8ff064511(player);
  player notify("assimilation_resolved");
}

function function_9ad90f0a744225a8(team) {
  teammembers = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(teammember in teammembers) {
    if(isDefined(teammember)) {
      teammember notify("refresh_revives");

      if(isDefined(level.br_plunder)) {
        plundercount = teammember.plundercount;
        data = scripts\mp\gametypes\br_plunder::createplayerplundereventdata();
        data.setplunderifunchanged = 1;
        teammember scripts\mp\gametypes\br_plunder::playersetplundercount(plundercount, data);
      } else {
        var_e28612e69968bb98 = scripts\mp\gamescore::_getplayerscore(teammember);
        teammember scripts\cp_mp\cash::function_52bea99a5c38fbe5(var_e28612e69968bb98, 1);
      }
    }

    teammember thread scripts\cp_mp\armor::setarmoromnvars();
  }

  if(teammembers.size > 0) {
    teammembers[0] scripts\mp\gametypes\br_utility::updateplayereliminatedomnvar("assimilation");
  }
}

function assimilateplayer(playerswitching, var_784c8ada1184ff89, torespawn) {
  oldteam = playerswitching.team;
  newteam = var_784c8ada1184ff89.team;
  oldsquadindex = playerswitching.sessionsquadid;
  newsquadindex = var_784c8ada1184ff89.sessionsquadid;
  var_67d0631ad9027f83 = !istrue(torespawn);
  usingsquad = isDefined(level.squaddata);
  leavingteammembers = [];
  oldteammembers = ter_op(usingsquad, level.squaddata[oldteam][oldsquadindex].players, scripts\mp\utility\teams::getteamdata(oldteam, "players"));

  foreach(teammember in oldteammembers) {
    if(isDefined(teammember) && playerswitching != teammember) {
      leavingteammembers[leavingteammembers.size] = teammember;
    }
  }

  scripts\cp_mp\overlord::playevent("assim_request_response_leaving_team", leavingteammembers);

  if(issharedfuncdefined("hud", "showBrDMZSplash")) {
    if(var_67d0631ad9027f83) {
      [[getsharedfunc("hud", "showBrDMZSplash")]]("player_team_switched", [playerswitching], undefined, undefined, undefined, level.splashlistoverride);
    }

    players = ter_op(usingsquad, level.squaddata[newteam][newsquadindex].players, scripts\mp\utility\teams::getteamdata(newteam, "players"));
    [[getsharedfunc("hud", "showBrDMZSplash")]]("player_joined_team", players, undefined, playerswitching getentitynumber(), undefined, level.splashlistoverride);
    players = ter_op(usingsquad, level.squaddata[oldteam][oldsquadindex].players, scripts\mp\utility\teams::getteamdata(oldteam, "players"));

    if(isDefined(players)) {
      players = array_remove(players, playerswitching);
      [[getsharedfunc("hud", "showBrDMZSplash")]]("player_left_team", players, undefined, playerswitching getentitynumber(), undefined, level.splashlistoverride);
    }
  }

  if(newteam != oldteam) {
    playerswitching thread scripts\mp\menus::addtoteam(newteam, undefined, var_67d0631ad9027f83, 1);
  }

  if(squad_utility::issquadmode()) {
    squadmates = playerswitching squad_utility::getsquadmembers();
    scripts\cp_mp\calloutmarkerping::function_47990577bda08bb4(playerswitching, squadmates);
    function_810613fb0e83165e(newteam, newsquadindex, playerswitching);
    playerswitching thread scripts\cp_mp\squads::changesquad(newteam, oldteam, newsquadindex);
  } else {
    function_8902607e87bb6d89(newteam, playerswitching);
    playerswitching thread scripts\cp_mp\squads::setsquad(newteam, newsquadindex);
  }

  playerswitching thread function_e5dbb2b054d0cabd(playerswitching, oldteam);
  playerswitching scripts\cp_mp\calloutmarkerping::calloutmarkerping_removeallcalloutsforplayer();
  function_9ad90f0a744225a8(newteam);
  function_9ad90f0a744225a8(oldteam);
  newteammembers = ter_op(usingsquad, level.squaddata[newteam][newsquadindex].players, scripts\mp\utility\teams::getteamdata(newteam, "players"));

  foreach(teammember in newteammembers) {
    if(isDefined(teammember)) {
      teammember notify("refresh_revives");

      if(isDefined(level.br_plunder)) {
        plundercount = teammember.plundercount;
        data = scripts\mp\gametypes\br_plunder::createplayerplundereventdata();
        data.setplunderifunchanged = 1;
        teammember scripts\mp\gametypes\br_plunder::playersetplundercount(plundercount, data);
      } else {
        var_e28612e69968bb98 = scripts\mp\gamescore::_getplayerscore(teammember);
        teammember scripts\cp_mp\cash::function_52bea99a5c38fbe5(var_e28612e69968bb98, 1);
      }
    }

    teammember thread scripts\cp_mp\armor::setarmoromnvars();
  }

  if(usingsquad && !isDefined(level.squaddata[oldteam][oldsquadindex])) {
    function_80139212a4c66a94(playerswitching, oldteam, newteam, oldsquadindex, newsquadindex);
    return;
  }

  oldteammembers = ter_op(usingsquad, level.squaddata[oldteam][oldsquadindex].players, scripts\mp\utility\teams::getteamdata(oldteam, "players"));

  foreach(teammember in oldteammembers) {
    if(isDefined(teammember)) {
      teammember notify("refresh_revives");

      if(isDefined(level.br_plunder)) {
        plundercount = teammember.plundercount;
        data = scripts\mp\gametypes\br_plunder::createplayerplundereventdata();
        data.setplunderifunchanged = 1;
        teammember scripts\mp\gametypes\br_plunder::playersetplundercount(plundercount, data);
        continue;
      }

      var_e28612e69968bb98 = scripts\mp\gamescore::_getplayerscore(teammember);
      teammember scripts\cp_mp\cash::function_52bea99a5c38fbe5(var_e28612e69968bb98, 1);
    }
  }

  function_80139212a4c66a94(playerswitching, oldteam, newteam, oldsquadindex, newsquadindex);
  playerswitching function_6401ee62bfbff899(oldteam, newteam);
}

function senddirectassimrequest(var_e65d25126ef3331b, targetplayer, var_99bcf6bdf31a0e49, var_e4fc35b9446269cf) {
  if(targetplayer == var_e65d25126ef3331b || targetplayer.team == var_e65d25126ef3331b.team && !(squad_utility::issquadmode() && !squad_utility::function_9b1d18c04d310cfc(var_e65d25126ef3331b, targetplayer)) || !isPlayer(targetplayer) || isplayersassimdisabled(targetplayer)) {
    return false;
  }

  var_1672c24528714d7d = ter_op(var_99bcf6bdf31a0e49, targetplayer.team, var_e65d25126ef3331b.team);
  playerswitching = ter_op(var_99bcf6bdf31a0e49, var_e65d25126ef3331b, targetplayer);
  var_784c8ada1184ff89 = ter_op(var_99bcf6bdf31a0e49, targetplayer, var_e65d25126ef3331b);

  if(!function_4aaeca4295a600d(var_784c8ada1184ff89, playerswitching, var_784c8ada1184ff89, 1)) {
    return false;
  }

  if(var_e4fc35b9446269cf) {
    toenemy = vectorNormalize(targetplayer.origin - self.origin);
    dotproduct = vectordot(anglesToForward(self.angles), toenemy);

    if(dotproduct < 0) {
      return false;
    }
  }

  targetplayer setclientomnvar("ui_assimilation_clientnum", var_e65d25126ef3331b getentitynumber());
  targetplayer setclientomnvar("ui_assimilation_join_on_target", var_99bcf6bdf31a0e49);
  targetplayer.var_7f1423df13bbb144 = var_e65d25126ef3331b;
  targetplayer thread function_b530aa511cac761(targetplayer);

  if(issharedfuncdefined("hud", "showBrDMZSplash")) {
    splashcooldown = function_82aca4b8517cf46a();

    if(!isDefined(targetplayer.var_312490cd130c9914) || targetplayer.var_312490cd130c9914 + splashcooldown > gettime() || targetplayer.var_4f8afa3693e318d4 != var_99bcf6bdf31a0e49) {
      if(var_99bcf6bdf31a0e49) {
        [[getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_requested_join_on_target", [targetplayer], undefined, var_e65d25126ef3331b getentitynumber(), undefined, level.splashlistoverride);
      } else {
        [[getsharedfunc("hud", "showBrDMZSplash")]]("dmz_team_assimilation_requested", [targetplayer], undefined, var_e65d25126ef3331b getentitynumber(), undefined, level.splashlistoverride);
      }

      targetplayer.var_312490cd130c9914 = gettime();
    }
  }

  targetplayer.var_4f8afa3693e318d4 = var_99bcf6bdf31a0e49;

  if(shouldautoacceptteamswitch()) {
    resolveassimrequest(targetplayer, 1);
  }

  return true;
}

function function_6401ee62bfbff899(oldteam, newteam) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  eventparams = [];
  eventparams[eventparams.size] = "player_xuid";
  eventparams[eventparams.size] = player getxuid();
  eventparams[eventparams.size] = "player_entity_num";
  eventparams[eventparams.size] = player getentitynumber();
  eventparams[eventparams.size] = "old_team";
  eventparams[eventparams.size] = oldteam;
  eventparams[eventparams.size] = "old_team_alive_teammates";

  if(isDefined(level.teamdata[oldteam]["alivePlayers"])) {
    eventparams[eventparams.size] = level.teamdata[oldteam]["alivePlayers"].size;
  } else {
    eventparams[eventparams.size] = -1;
  }

  eventparams[eventparams.size] = "new_team";
  eventparams[eventparams.size] = newteam;
  eventparams[eventparams.size] = "new_team_alive_teammates";

  if(isDefined(level.teamdata[newteam]["alivePlayers"])) {
    eventparams[eventparams.size] = level.teamdata[newteam]["alivePlayers"].size;
  } else {
    eventparams[eventparams.size] = -1;
  }

  eventparams[eventparams.size] = "last_assimilation_request_time";

  if(isDefined(player.var_312490cd130c9914)) {
    eventparams[eventparams.size] = player.var_312490cd130c9914;
  } else {
    eventparams[eventparams.size] = -1;
  }

  eventparams[eventparams.size] = "game_time";
  eventparams[eventparams.size] = int(gettime() / 1000);
  player dlog_recordplayerevent("dlog_event_team_assimilation", eventparams);
}

function function_810613fb0e83165e(team, squadindex, player) {
  if(!isDefined(level.squaddata)) {
    return;
  }

  if(!isDefined(level.squaddata[team][squadindex].properties["lastAssimedPlayer"])) {
    level.squaddata[team][squadindex].properties["lastAssimedPlayer"] = player;
    return;
  }

  scripts\cp_mp\squads::function_a20a10ce593f692b(team, squadindex, "lastAssimedPlayer", player);
}

function function_8902607e87bb6d89(team, player) {
  if(!isDefined(level.teamdata)) {
    return;
  }

  if(!isDefined(level.teamdata[team]["lastAssimedPlayer"])) {
    level.teamdata[team]["lastAssimedPlayer"] = undefined;
    return;
  }

  scripts\mp\utility\teams::setteamdata(team, "lastAssimedPlayer", player);
}

function function_2a1e4811621fdcde(player) {
  thread function_351ea84f3d394eea(player);
}

function private function_351ea84f3d394eea(player) {
  level endon("game_ended");
  player endon("disconnect");
  waitframe();
  squadmates = player squad_utility::getsquadmembers();
  scripts\cp_mp\calloutmarkerping::function_3d92221d673d555c(player, squadmates);
}

function function_ec7c2b6761cd9ab3() {
  thread function_10cf654ff5fef6eb();
  waitframe();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x35>", @ "hash_f7804c5dfa9407ca");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x48>", @ "hash_b954d42a85390b5b");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x64>", @ "hash_5eedf824f533d2e6");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x82>", @ "hash_8b77db100df49d5e");
  scripts\common\devgui::function_fe953f000498048f();
}

function private function_10cf654ff5fef6eb() {
  level endon("<dev string:x98>");

  while(true) {
    if(getdvarint(@ "hash_f7804c5dfa9407ca", 0)) {
      setDvar(@ "hash_f7804c5dfa9407ca", 0);
      newsquadindex = 0;

      foreach(player in level.players) {
        player thread scripts\cp_mp\squads::changesquad(player.team, player.team, newsquadindex);
        newsquadindex++;
      }
    }

    if(getdvarint(@ "hash_b954d42a85390b5b", 0)) {
      setDvar(@ "hash_b954d42a85390b5b", 0);
      playerteam = "<dev string:xa6>";
      playersquad = 0;
      humanplayer = undefined;

      foreach(player in level.players) {
        if(isPlayer(player)) {
          playerteam = player.team;
          playersquad = player.sessionsquadid;
          humanplayer = player;
          break;
        }
      }

      foreach(bot in level.players) {
        if(bot != humanplayer && bot.sessionsquadid != playersquad) {
          if(!function_4aaeca4295a600d(humanplayer, bot, humanplayer, 1)) {
            continue;
          }

          assimilateplayer(bot, humanplayer, 0);
          break;
        }
      }
    }

    if(getdvarint(@ "hash_5eedf824f533d2e6", 0)) {
      setDvar(@ "hash_5eedf824f533d2e6", 0);
      playersquad = 0;
      humanplayer = undefined;

      foreach(player in level.players) {
        if(isPlayer(player)) {
          playersquad = player.sessionsquadid;
          humanplayer = player;
          break;
        }
      }

      foreach(bot in level.players) {
        if(bot != humanplayer && bot.sessionsquadid != playersquad) {
          function_5a35520fca6b5b34(bot, humanplayer);
          break;
        }
      }
    }

    if(getdvarint(@ "hash_8b77db100df49d5e", 0)) {
      setDvar(@ "hash_8b77db100df49d5e", 0);
      playerteam = "<dev string:xa6>";
      playersquad = 0;
      humanplayer = undefined;

      foreach(player in level.players) {
        if(isPlayer(player)) {
          playerteam = player.team;
          playersquad = player.sessionsquadid;
          humanplayer = player;
          break;
        }
      }

      foreach(bot in level.players) {
        if(bot != humanplayer && bot.sessionsquadid == playersquad) {
          bot requestleaveteam(bot);
          break;
        }
      }
    }

    waitframe();
  }
}

function private function_5a35520fca6b5b34(bot, player) {
  if(!function_4aaeca4295a600d(bot, player, player, 1)) {
    return;
  }

  player setclientomnvar("<dev string:xaa>", bot getentitynumber());
  player setclientomnvar("<dev string:xc7>", 0);
  player.var_7f1423df13bbb144 = bot;
  player thread function_b530aa511cac761(player);

  if(issharedfuncdefined("<dev string:xe9>", "<dev string:xf0>")) {
    splashcooldown = function_82aca4b8517cf46a();

    if(!isDefined(player.var_312490cd130c9914) || player.var_312490cd130c9914 + splashcooldown > gettime() || player.var_4f8afa3693e318d4 != 0) {
      [[getsharedfunc("<dev string:xe9>", "<dev string:xf0>")]]("<dev string:x103>", [player], undefined, bot getentitynumber());
      player.var_312490cd130c9914 = gettime();
    }
  }

  player.var_4f8afa3693e318d4 = 0;
  scripts\cp_mp\overlord::playevent("<dev string:x126>", [bot]);
  var_3d290d914e1249a0 = [player];

  if(var_3d290d914e1249a0.size > 0) {
    scripts\cp_mp\overlord::playevent("<dev string:x143>", var_3d290d914e1249a0);
    callsharedfunc("<dev string:x15b>", "<dev string:x16b>", bot, var_3d290d914e1249a0);
  }
}

# /