/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\game_utility.gsc
**************************************************/

#using scripts\common\ae_utility;
#using scripts\common\string;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\events;
#namespace game_utility;

function private autoexec init() {
  level.var_80d9f200fb6ac50b = getdvarfloat(@ "hash_d11b505a097056cf", 0.25);
  level.var_80d9f100fb6ac2d8 = getdvarfloat(@ "hash_d11b4f5a0970549c", 0.25);
  level.var_ea1f92bd3f0e2fdd = getdvarfloat(@ "hash_233f233fe59ce656", 0.3);
  level.var_9a4affc0f167ca7b = getdvarfloat(@ "hash_b678e6b5a972d764", 0.25);
  level.var_9a4afec0f167c848 = getdvarfloat(@ "hash_b678e7b5a972d997", 0.25);
  level.var_8e3bab95e06e99ed = getdvarfloat(@ "hash_f6606a515c264687", 0.3);
  level.var_fe795d1588196bc5 = getdvarfloat(@ "hash_ccbcc43256294106", 0);
  level.var_fe795c1588196992 = getdvarfloat(@ "hash_ccbcc53256294339", 0.25);
  level.var_e9a1de60e6051507 = getdvarfloat(@ "hash_ff6c6fb49f512849", 0.3);
  level.var_46569ffe2bee9b77 = getdvarfloat(@ "hash_23afb2011b6bbe3b", 1);
  level.var_b74129ea79dcdc04 = getdvarfloat(@ "hash_8baf136f90ca01c5", 1);
  level.var_e709d275ac801177 = getdvarfloat(@ "hash_edda3d403bf1cea0", 1);
  level.var_9a6392a8e18cb204 = getdvarfloat(@ "hash_85f40fedb4275aa4", 1);
  level.var_453fc056b2c0a611 = getdvarfloat(@ "hash_7468b2cc0f86cc02", 0);
  level.var_26d265e7d8635562 = getdvarfloat(@ "hash_170c7e08f2a119a2", 1);
  registersharedfunc("game_utility", "isInfectedGametype", &isinfectedgametype);
}

function getmapname() {
  if(!isDefined(level.mapname)) {
    level.mapname = getDvar(@ "g_mapname");
  }

  return level.mapname;
}

function getgametype() {
  if(!isDefined(level.gametype)) {
    if(isbrstylegametype()) {
      level.gametype = "br";
    } else {
      level.gametype = tolower(getDvar(@ "g_gametype"));
    }
  }

  if(isinfectedgametype()) {
    level.gametype = "infect";
  }

  return level.gametype;
}

function getbasegametype() {
  if(isDefined(level.var_7b79f7162d8f11f6)) {
    return level.var_7b79f7162d8f11f6;
  }

  gametype = getgametype();
  tokens = strtok(gametype, "_");

  if(tokens[0] == "hc" || tokens[0] == "cdl" || tokens[0] == "lp") {
    gametype = tokens[tokens.size - 1];
  }

  if(isDefined(tokens[1]) && (tokens[1] == "snipers" || tokens[1] == "horde" || tokens[1] == "jugg")) {
    gametype = tokens[0];
  }

  if(tokens[0] == "ob") {
    gametype = tokens[0];
  }

  if(gametype == "war_cranked") {
    gametype = "war";
  }

  if(!isDefined(level.var_7b79f7162d8f11f6)) {
    level.var_7b79f7162d8f11f6 = gametype;
  }

  return level.var_7b79f7162d8f11f6;
}

function isinfectedgametype() {
  if(!isDefined(level.gametype)) {
    return false;
  }

  if(level.gametype == "infect" || level.gametype == "infect_holiday" || level.gametype == "infect_phishing" || level.gametype == "infect_haunting") {
    return true;
  }

  return false;
}

function function_b276be88d495440b() {
  if(!isDefined(level.gametype)) {
    return false;
  }

  if(level.gametype == "koth_horde") {
    return true;
  }

  return false;
}

function isbrstylegametype() {
  if(isDefined(level.gametypebundle)) {
    return default_to(level.gametypebundle.isbrstylegametype, 0);
  }

  if(!isDefined(level.gametype)) {
    return 0;
  }

  return level.gametype == "br";
}

function function_42e2dcfd4571b89b() {
  return isbrstylegametype() && (function_6c1fce6f6b8779d5() == "dmz" || function_6c1fce6f6b8779d5() == "exgm");
}

function function_a3a69db84e39e0b8() {
  if(!isDefined(level.gametype)) {
    return false;
  }

  return level.gametype == "xfire";
}

function function_d04af493b6e718ac() {
  if(!isDefined(level.gametype)) {
    return false;
  }

  return level.gametype == "wm";
}

function function_8b6131109e66d962() {
  return function_d04af493b6e718ac() && istrue(game["roundsPlayed"]);
}

function function_22cd3d64fdb05892() {
  if(!isDefined(level.gametype)) {
    return false;
  }

  return level.gametype == "arm" || level.gametype == "gwtdm" || level.gametype == "conflict";
}

function function_eb455c18ac9d8ac5() {
  return getsubstr(level.gametype, 0, 4) == "cdl_";
}

function ismagellanmode() {
  return getdvarint(@ "mgl", 0) != 0;
}

function function_fa7bfcc1d68b7b73() {
  return ismagellanmode() && isbrstylegametype();
}

function function_2d79a7a3b91c4c3e() {
  return ismagellanmode() && !isbrstylegametype();
}

function function_a0148d3a4a97bbb1() {
  return function_2d79a7a3b91c4c3e() && level.mapname == "mp_don3_mobile";
}

function function_7f8a6a1772bd6f5f() {
  level.highhealth = 1;
}

function function_244067e915c0eabe() {
  return istrue(level.highhealth);
}

function function_6493ec89ae923684() {
  return getdvarint(@ "enable_automation_bot", 0);
}

function function_6910a4c65560c44b() {
  return function_6493ec89ae923684();
}

function registerlargemap() {
  level.largemap = 1;
}

function islargemap() {
  return istrue(level.largemap);
}

function islargebrmap() {
  return isbrstylegametype() && islargemap();
}

function registerdonetskmap() {
  registerlargemap();
  level.isdonetskmap = 1;
}

function isdonetskmap() {
  return istrue(level.isdonetskmap);
}

function registerdonetsksubmap() {
  level.donetsksubmap = 1;
}

function isdonetsksubmap() {
  return istrue(level.donetsksubmap);
}

function function_5258141665ff7b95() {
  registerlargemap();
  level.var_7ee65fae13124702 = 1;
}

function function_7ee65fae13124702() {
  return istrue(level.var_7ee65fae13124702);
}

function function_5b9e95acd14775a5() {
  level.var_6c8c09778110ddf8 = 1;
}

function function_da8c49606d8aa048() {
  return istrue(level.var_6c8c09778110ddf8);
}

function function_db54db563ac2ec62() {
  registerlargemap();
  level.var_3678e32ea86b4da7 = 1;
}

function function_3678e32ea86b4da7() {
  return istrue(level.var_3678e32ea86b4da7);
}

function function_9cfe515677727128() {
  level.var_e0708dadcdaba5ab = 1;
}

function function_47eb75d4e513b67b() {
  return istrue(level.var_e0708dadcdaba5ab);
}

function function_743719859fbab899() {
  registerlargemap();
  level.var_e21746abaaaf8414 = 1;
}

function function_e21746abaaaf8414() {
  return istrue(level.var_e21746abaaaf8414);
}

function function_7643f25d8ef9f5d9() {
  level.var_9eb5d18392a3526e = 1;
}

function function_9eb5d18392a3526e() {
  return istrue(level.var_9eb5d18392a3526e);
}

function function_4b8e6239b2d87474() {
  registerlargemap();
  level.var_5e0e3a24dbb1fae1 = 1;
}

function function_5e0e3a24dbb1fae1() {
  return istrue(level.var_5e0e3a24dbb1fae1);
}

function function_ac85a5ab21db294e() {
  level.var_a88026e516cded1 = 1;
}

function function_a88026e516cded1() {
  return istrue(level.var_a88026e516cded1);
}

function function_35f5b4e643757db7() {
  registerlargemap();
  level.var_eb4bce9b222e36ac = 1;
}

function function_eb4bce9b222e36ac() {
  return istrue(level.var_eb4bce9b222e36ac);
}

function function_3673befc7dcade8b() {
  level.var_24e8e1db997c8248 = 1;
}

function function_b1d9cdb3f16a7678() {
  return istrue(level.var_24e8e1db997c8248);
}

function function_daf8300f9f179ee6() {
  registerlargemap();
  level.var_314ff105a27cc131 = 1;
}

function function_314ff105a27cc131() {
  return istrue(level.var_314ff105a27cc131);
}

function function_f22234472142284f() {
  registerlargemap();
  level.var_d945f73c1a21c452 = 1;
}

function function_ffbbb4525b11d5a2() {
  return istrue(level.mapname == "mp_bio_lab");
}

function function_ee0c2958aa2ee59e() {
  return istrue(level.mapname == "mp_biobunker");
}

function function_934ac55aa85ce574() {
  return istrue(level.mapname == "mp_bio_lab") || istrue(level.mapname == "mp_biobunker");
}

function function_d945f73c1a21c452() {
  return istrue(level.var_d945f73c1a21c452);
}

function function_6d696efa3fa61b93() {
  level.var_69c987308ed50f76 = 1;
}

function function_d5f96052f275a4a6() {
  return istrue(level.var_69c987308ed50f76);
}

function function_a373e183d1b9bae9() {
  registerlargemap();
  level.var_107d784c61b514da = 1;
}

function function_35f564beac680d88() {
  level.var_da466a8aa038e27d = 1;
}

function function_da466a8aa038e27d() {
  return istrue(level.var_da466a8aa038e27d) || isdonetsksubmap() || function_da8c49606d8aa048() || function_47eb75d4e513b67b() || function_9eb5d18392a3526e() || function_b1d9cdb3f16a7678() || function_d5f96052f275a4a6();
}

function function_7fd83d3e076a309() {
  return istrue(level.mapname == "mp_saba_pm") || istrue(level.mapname == "mp_delta_pm");
}

function registernightmap(usenvgs) {
  if(!isDefined(usenvgs)) {
    usenvgs = 1;
  }

  level.nightmap = 1;
  visionsetkillcamthirdpersonnight("killcam_night");

  if(usenvgs) {
    function_67c053f33e4f21a1();
  }
}

function isnightmap() {
  return istrue(level.nightmap);
}

function function_67c053f33e4f21a1() {
  level.var_3eac2a21ee8e9d4f = 1;
}

function function_d2d2b803a7b741a4() {
  return istrue(level.var_3eac2a21ee8e9d4f);
}

function registerarenamap() {
  level.arenamap = 1;
  level.disablespawncamera = 1;
  level.skipfirstraise = 1;
  level.requiresminstartspawns = 0;
}

function registersmallmap() {
  level.disablespawncamera = 1;
  level.skipfirstraise = 1;
}

function isarenamap() {
  return istrue(level.arenamap);
}

function function_5a094c7dc3b36ebd() {
  if(issharedfuncdefined("game", "isLifeLimited")) {
    return [[getsharedfunc("game", "isLifeLimited")]]();
  }

  return 0;
}

function function_6ae03efb52c52c29(player) {
  if(function_5a094c7dc3b36ebd()) {
    gametypenumlives = callsharedfunc("game", "getGametypeNumLives");

    if(isDefined(player.pers["deaths"]) && player.pers["deaths"] >= gametypenumlives) {
      return true;
    }
  }

  return false;
}

function function_9cdaadfddeda4d7a() {
  return istrue(level.var_9cdaadfddeda4d7a);
}

function function_6c1fce6f6b8779d5() {
  if(isbrstylegametype()) {
    subgametype = level.gametypebundle.brsubgametype;

    if(!isDefined(subgametype)) {
      subgametype = "";
    }

    if(subgametype != "") {
      return subgametype;
    }
  }

  return getgametype();
}

function function_4fb37368ae3585bb() {
  if(!isDefined(level.maxteamsize)) {
    level.maxteamsize = getmatchrulesdata("commonOption", "teamSize");
  }

  return level.maxteamsize;
}

function function_17314ce12820727a(var_e1b4718a23e1d361) {
  assertex(isDefined(var_e1b4718a23e1d361), "<dev string:x1c>");
  mapname = getmapname();
  bestmatch = var_e1b4718a23e1d361.var_abd731ee6e3696c;

  if(default_to(var_e1b4718a23e1d361.var_2b60e5280dfc35cd, 0) == 0) {
    return bestmatch;
  }

  foreach(kvp in default_to(var_e1b4718a23e1d361.mapoverrides, [])) {
    var_b95ce7540f070172 = default_to(kvp.key.mapasset, "");

    if(var_b95ce7540f070172 == mapname) {
      bestmatch = kvp.value;
      break;
    }
  }

  return bestmatch;
}

function shouldskipfirstraise() {
  if(!isDefined(level.skipfirstraise)) {
    level.skipfirstraise = getdvarint(@ "scr_game_weapon_skip_first_raise", 0) == 1;
  }

  return istrue(level.skipfirstraise);
}

function getlocaleid() {
  if(!isDefined(level.localeid)) {
    localeid = getdvarint(@ "hash_6beec004cdf37c0", 0);
    println("<dev string:x4d>" + localeid);

    if(localeid > 0) {
      level.localeid = "locale_" + localeid;
    } else if(localeid == 0) {
      level.localeid = undefined;
    } else if(scripts\cp_mp\utility\game_utility::isdonetskmap()) {
      level.localeid = "locale_6";
    } else {
      switch (getmapname()) {
        case #"hash_7a28db3c5928c489":
          level.localeid = "locale_5";
          break;
        case #"hash_32eaa112f8caa7e4":
          level.localeid = "locale_6";
          break;
        case #"hash_50de71be6e7469ff":
          level.localeid = "locale_9";
          break;
        case #"hash_a8b272dba33a4aed":
          level.localeid = "locale_17";
          break;
      }
    }
  }

  return level.localeid;
}

function getlocaleent(entname, var_8a8a9680c8ad47a2, var_783ab83623b57681) {
  possibleents = getEntArray(entname, "targetname");
  var_44716bcb2430218b = undefined;

  if(isDefined(possibleents) && possibleents.size == 1) {
    return possibleents[0];
  }

  if(isDefined(getlocaleid()) && !istrue(var_783ab83623b57681)) {
    foreach(ent in possibleents) {
      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == level.localeid) {
        var_44716bcb2430218b = ent;
        continue;
      }

      if(level.mapname == "mp_port2_gw" && entname == "airstrikeheight") {
        if(ent.origin == (34880, -26944, 3072)) {
          var_44716bcb2430218b = ent;
        }

        continue;
      }

      ent delete();
    }
  } else {
    foreach(ent in possibleents) {
      if(!isDefined(var_44716bcb2430218b)) {
        var_44716bcb2430218b = ent;
        continue;
      }

      ent delete();
    }
  }

  if(isDefined(var_44716bcb2430218b)) {
    return var_44716bcb2430218b;
  }

  if(isDefined(level.localeid)) {
    println("<dev string:x6b>" + entname + "<dev string:x84>" + level.localeid + "<dev string:xa1>");
  }

  if(istrue(var_8a8a9680c8ad47a2)) {
    assertmsg("<dev string:xc6>");
  }
}

function getlocalestruct(structname, var_8a8a9680c8ad47a2) {
  possibleents = getStructArray(structname, "targetname");
  var_44716bcb2430218b = undefined;

  if(isDefined(getlocaleid())) {
    foreach(ent in possibleents) {
      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == level.localeid) {
        var_44716bcb2430218b = ent;
      }
    }
  } else {
    foreach(ent in possibleents) {
      if(!isDefined(var_44716bcb2430218b)) {
        var_44716bcb2430218b = ent;
        break;
      }
    }
  }

  if(isDefined(var_44716bcb2430218b)) {
    return var_44716bcb2430218b;
  }

  if(isDefined(level.localeid)) {
    println("<dev string:x6b>" + structname + "<dev string:x84>" + level.localeid + "<dev string:xa1>");
  }

  if(istrue(var_8a8a9680c8ad47a2)) {
    assertmsg("<dev string:xc6>");
  }
}

function getlocalestructarray(structname, var_8a8a9680c8ad47a2) {
  possibleents = getStructArray(structname, "targetname");
  var_134cb8f60ff902c0 = [];

  if(isDefined(getlocaleid())) {
    foreach(ent in possibleents) {
      if(getmapname() == "mp_quarry2") {
        var_134cb8f60ff902c0[var_134cb8f60ff902c0.size] = ent;
        continue;
      }

      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == level.localeid) {
        var_134cb8f60ff902c0[var_134cb8f60ff902c0.size] = ent;
      }
    }

    return var_134cb8f60ff902c0;
  }

  if(possibleents.size == 0) {
    if(isDefined(level.localeid)) {
      println("<dev string:x6b>" + structname + "<dev string:x84>" + level.localeid + "<dev string:xa1>");
    }

    if(istrue(var_8a8a9680c8ad47a2)) {
      assertmsg("<dev string:xc6>");
    }

    return;
  }

  return possibleents;
}

function function_b2c4b42f9236924() {
  return istrue(level.tier1modeenabled);
}

function function_21322da268e71c19() {
  return istrue(level.hardcoremodeenabled) || scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924();
}

function fadetoblackforplayerkeepui(player, fadetoblack, fadetime) {
  if(getdvarint(@ "hash_19e3006228036170", 0)) {
    return;
  }

  if(player function_6d451118968a70bb()) {
    return;
  }

  player notify("start_fade_to_black_keep_ui");
  player endon("start_fade_to_black_keep_ui");
  player endon("disconnect");
  level endon("game_ended");
  assertex(!isDefined(fadetime) || fadetime >= 0, "<dev string:xfe>");
  fadealpha = 0;

  if(istrue(fadetoblack)) {
    fadealpha = 1;
  }

  if(!isDefined(fadetime) || fadetime == 0) {
    player setclientomnvar("ui_world_fade", fadealpha);
    return;
  }

  finalalpha = fadealpha;
  fadealpha = 0;
  fadetimecounter = int(fadetime / level.framedurationseconds);
  fadechange = 1 / fadetimecounter;

  if(!istrue(fadetoblack)) {
    fadechange *= -1;
    fadealpha = 1;
  }

  while(fadetimecounter > 0) {
    fadealpha += fadechange;
    player setclientomnvar("ui_world_fade", fadealpha);
    fadetimecounter--;
    waitframe();
  }

  player setclientomnvar("ui_world_fade", finalalpha);
}

function function_20cb4a5f727abe6e(bool) {
  self.var_2214edc8665072ab = bool;
}

function function_6d451118968a70bb() {
  return istrue(self.var_2214edc8665072ab);
}

function fadetoblackforplayer(player, fadetoblack, fadetime, var_dd8b0e146fd638e) {
  if(getdvarint(@ "hash_19e3006228036170", 0)) {
    return;
  }

  if(player function_6d451118968a70bb()) {
    return;
  }

  player notify("start_fade_to_black");
  player endon("start_fade_to_black");
  player endon("disconnect");

  if(!istrue(var_dd8b0e146fd638e)) {
    level endon("game_ended");
  }

  assertex(!isDefined(fadetime) || fadetime >= 0, "<dev string:x13b>");
  fadealpha = 0;

  if(istrue(fadetoblack)) {
    fadealpha = 1;
  }

  if(!isDefined(fadetime) || fadetime == 0) {
    player setclientomnvar("ui_total_fade", fadealpha);
    return;
  }

  finalalpha = fadealpha;
  fadealpha = 0;
  fadetimecounter = int(fadetime / level.framedurationseconds);
  fadechange = 1 / fadetimecounter;

  if(!istrue(fadetoblack)) {
    fadechange *= -1;
    fadealpha = 1;
  }

  while(fadetimecounter > 0) {
    fadealpha += fadechange;

    if(!isDefined(player)) {
      return;
    }

    player setclientomnvar("ui_total_fade", fadealpha);
    fadetimecounter--;
    waitframe();
  }

  if(!isDefined(player)) {
    return;
  }

  player setclientomnvar("ui_total_fade", finalalpha);
  player notify("finish_fade_to_black");
}

function gettimesincegamestart() {
  return [[getsharedfunc("game_utility", "getTimeSinceGameStart")]]();
}

function startkeyearning() {
  if(isbot(self)) {
    return;
  }

  if(isDefined(self.reportchallengeuserevent_done)) {
    return;
  }

  if(!istrue(level.playerxpenabled)) {
    return;
  }

  if(istrue(callsharedfunc("br", "isInstancedSpace"))) {
    return;
  }

  var_8283ee79fff791be = int(function_53c9c4130046f113() * 100);
  aeeventname = #"start_match";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  params = [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"playlist_id"), getplaylistid(), function_d6f771aedba70ce7(aeeventname, #"hash_f49dbd32adacb71c"), var_8283ee79fff791be, function_d6f771aedba70ce7(aeeventname, #"lobby_id"), function_4f9373a1227db35c(), function_d6f771aedba70ce7(aeeventname, #"match_id"), function_94c7ae7049488358()];

  if(issharedfuncdefined("challenges", "reportChallengeUserSerializedEventWrapper")) {
    callsharedfunc("challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params);
  }

  self.reportchallengeuserevent_done = 0;
}

function stopkeyearning(winner) {
  if(!isDefined(self)) {
    assertmsg("<dev string:x172>");
    return;
  }

  if(isbot(self)) {
    return;
  }

  if(istrue(self.reportchallengeuserevent_done)) {
    return;
  }

  if(!istrue(level.playerxpenabled)) {
    return;
  }

  result = function_b40278e5e468c6c1(#"matchresult", #"match_result_none");

  if(istrue(self.disconnecting) && !isDefined(self.connectedpostgame)) {
    result = function_b40278e5e468c6c1(#"matchresult", #"match_result_loss");
  }

  if(!isDefined(winner)) {
    assertmsg("<dev string:x1ae>");
  }

  if(isDefined(winner)) {
    if(level.teambased) {
      if(winner == "eliminated") {
        result = function_b40278e5e468c6c1(#"matchresult", #"match_result_br_team_eliminated");
      } else if(winner == "tie") {
        result = function_b40278e5e468c6c1(#"matchresult", #"match_result_draw");
      } else if(isDefined(self.pers["team"]) && self.pers["team"] == winner) {
        result = function_b40278e5e468c6c1(#"matchresult", #"match_result_win");
      } else if(isDefined(self.pers["team"]) && self.pers["team"] != winner) {
        result = function_b40278e5e468c6c1(#"matchresult", #"match_result_loss");
      }
    } else if(isDefined(self.connectedpostgame)) {
      result = function_b40278e5e468c6c1(#"matchresult", #"match_result_none");
    } else if(!isDefined(self.timeplayed) || self.timeplayed["total"] < 1 || self.pers["participation"] < 1) {
      result = function_b40278e5e468c6c1(#"matchresult", #"match_result_none");
    } else if(!istrue(self.pers["hasDoneAnyCombat"])) {
      result = function_b40278e5e468c6c1(#"matchresult", #"match_result_none");
    } else if(!isDefined(level.placement)) {
      result = function_b40278e5e468c6c1(#"matchresult", #"match_result_none");
    } else if(!isPlayer(winner) && winner == "eliminated") {
      result = function_b40278e5e468c6c1(#"matchresult", #"match_result_br_team_eliminated");
    } else {
      iswinner = 0;

      for(pidx = 0; pidx < min(level.placement["all"].size, 3); pidx++) {
        if(level.placement["all"][pidx] != self) {
          continue;
        }

        iswinner = 1;
      }

      if(iswinner) {
        result = function_b40278e5e468c6c1(#"matchresult", #"match_result_win");
      } else {
        result = function_b40278e5e468c6c1(#"matchresult", #"match_result_loss");
      }
    }
  }

  scripts\mp\events::function_f4fa8b16599b57d7(1);
  scripts\cp_mp\challenges::function_b5929663421247fa(self, result, winner);
  self.reportchallengeuserevent_done = 1;
}

function _visionsetnakedforplayer(visionset, transitionduration) {
  assertex(isDefined(visionset), "<dev string:x1f9>");

  if(visionset == "") {
    self visionsetnakedforplayer(visionset, transitionduration);

    if(isDefined(self.activevisionsetlist)) {
      self.activevisionsetlist = undefined;
    }

    return;
  }

  if(!isDefined(transitionduration)) {
    transitionduration = 0;
  }

  if(!isDefined(self.activevisionsetlist)) {
    self.activevisionsetlist = [];
  }

  if(!isDefined(self.activevisionsetlist[visionset])) {
    self.activevisionsetlist[visionset] = 1;
  } else {
    self.activevisionsetlist[visionset]++;
  }

  if(self.activevisionsetlist[visionset] == 1) {
    self visionsetnakedforplayer(visionset, transitionduration);
  }
}

function _visionunsetnakedforplayer(visionset) {
  self endon("disconnect");
  level endon("game_ended");
  assertex(isDefined(self.activevisionsetlist[visionset]), "<dev string:x238>");
  self.activevisionsetlist[visionset]--;

  if(self.activevisionsetlist[visionset] == 0) {
    var_bfd32f432f9daccf = [];

    foreach(visionindex, visionsetcount in self.activevisionsetlist) {
      if(visionindex == visionset) {
        continue;
      }

      var_bfd32f432f9daccf[visionindex] = visionsetcount;
    }

    self.activevisionsetlist = var_bfd32f432f9daccf;
    self visionsetnakedforplayer("", 0);

    foreach(visionindex, visionsetcount in var_bfd32f432f9daccf) {
      waitframe();
      self visionsetnakedforplayer(visionindex, level.framedurationseconds);
    }
  }
}

function removematchingents_bymodel(name, var_4732c617e87c7c9d) {
  ents = getEntArray();

  foreach(ent in ents) {
    if(isDefined(ent.model) && ent.model == name) {
      if(istrue(var_4732c617e87c7c9d) && isDefined(ent.target)) {
        removematchingents_bykey(ent.target, "targetname");
      }

      ent delete();
    }
  }
}

function removematchingents_bycodeclassname(name) {
  ents = getEntArray();

  foreach(ent in ents) {
    if(isDefined(ent.code_classname) && ent.code_classname == name) {
      ent delete();
    }
  }
}

function removematchingents_byclassname(name) {
  ents = getEntArray();

  foreach(ent in ents) {
    if(isDefined(ent.classname) && ent.classname == name) {
      ent delete();
    }
  }
}

function removematchingents_bykey(name, key) {
  ents = getEntArray(name, key);

  foreach(ent in ents) {
    ent delete();
  }
}

function initchallengeandeventglobals() {
  globals = spawnStruct();
  level.challengeandeventglobals = globals;
  globals.game_type_col = [];
  globals.game_type_col["missions"] = function_b40278e5e468c6c1(#"gametype", #"hash_94a3e9eef8486ceb");
  globals.game_type_col["dm"] = function_b40278e5e468c6c1(#"gametype", #"hash_283088392650cf49");
  globals.game_type_col["war"] = function_b40278e5e468c6c1(#"gametype", #"hash_27a9511c6b561209");
  globals.game_type_col["sd"] = function_b40278e5e468c6c1(#"gametype", #"hash_28716139268823f9");
  globals.game_type_col["dom"] = function_b40278e5e468c6c1(#"gametype", #"hash_9b3fa11c1b49e24a");
  globals.game_type_col["conf"] = function_b40278e5e468c6c1(#"gametype", #"hash_ef25fedf53b657bc");
  globals.game_type_col["sr"] = function_b40278e5e468c6c1(#"gametype", #"hash_287173392688428f");
  globals.game_type_col["grind"] = function_b40278e5e468c6c1(#"gametype", #"hash_ef9a4413a5aba5c4");
  globals.game_type_col["ball"] = function_b40278e5e468c6c1(#"gametype", #"hash_cfecd0d34f64445f");
  globals.game_type_col["infect"] = function_b40278e5e468c6c1(#"gametype", #"hash_d2318c9d1c1c48c7");
  globals.game_type_col["tjugg"] = function_b40278e5e468c6c1(#"gametype", #"hash_dc39a236526e4509");
  globals.game_type_col["gun"] = function_b40278e5e468c6c1(#"gametype", #"hash_93dc951c177762dc");
  globals.game_type_col["grnd"] = function_b40278e5e468c6c1(#"gametype", #"hash_8be52fbbc7559ed1");
  globals.game_type_col["siege"] = function_b40278e5e468c6c1(#"gametype", #"hash_32ae842c947a11b1");
  globals.game_type_col["koth"] = function_b40278e5e468c6c1(#"gametype", #"hash_e72de898a6de98ec");
  globals.game_type_col["ctf"] = function_b40278e5e468c6c1(#"gametype", #"hash_b7b1431c2c18d7ed");
  globals.game_type_col["dd"] = function_b40278e5e468c6c1(#"gametype", #"hash_28308f392650db2e");
  globals.game_type_col["tdef"] = function_b40278e5e468c6c1(#"gametype", #"hash_bae2324a6357ff25");
  globals.game_type_col["front"] = function_b40278e5e468c6c1(#"gametype", #"hash_9596002d37fafad9");
  globals.game_type_col["cmd"] = function_b40278e5e468c6c1(#"gametype", #"hash_b7ff231c2c5ac2de");
  globals.game_type_col["arena"] = function_b40278e5e468c6c1(#"gametype", #"hash_b6b155127486c1e9");
  globals.game_type_col["cyber"] = function_b40278e5e468c6c1(#"gametype", #"hash_d5007927e17e9f2f");
  globals.game_type_col["rush"] = function_b40278e5e468c6c1(#"gametype", #"hash_a237b75bff436418");
  globals.game_type_col["esc"] = function_b40278e5e468c6c1(#"gametype", #"hash_a595c41c219e743f");
  globals.game_type_col["vip"] = function_b40278e5e468c6c1(#"gametype", #"hash_1572e41c60c50539");
  globals.game_type_col["btm"] = function_b40278e5e468c6c1(#"gametype", #"hash_ace80f1c2562eb87");
  globals.game_type_col["rugby"] = function_b40278e5e468c6c1(#"gametype", #"hash_96132a53224a13f9");
  globals.game_type_col["arm"] = function_b40278e5e468c6c1(#"gametype", #"hash_c68b8a1c33cecfb0");
  globals.game_type_col["mtmc"] = function_b40278e5e468c6c1(#"gametype", #"hash_4083828bb7543117");
  globals.game_type_col["snatch"] = function_b40278e5e468c6c1(#"gametype", #"hash_7cad9b981acb29d");
  globals.game_type_col["hq"] = function_b40278e5e468c6c1(#"gametype", #"hash_28236c3926461559");
  globals.game_type_col["defcon"] = function_b40278e5e468c6c1(#"gametype", #"hash_155388b4618596b");
  globals.game_type_col["pill"] = function_b40278e5e468c6c1(#"gametype", #"hash_cb35b96938bb6729");
  globals.game_type_col["blitz"] = function_b40278e5e468c6c1(#"gametype", #"hash_400b8b2cb23f693d");
  globals.game_type_col["brm"] = function_b40278e5e468c6c1(#"gametype", #"hash_acfbf31c257364fd");
  globals.game_type_col["hvt"] = function_b40278e5e468c6c1(#"gametype", #"hash_7a4a101c0919e0e8");
  globals.game_type_col["trial"] = function_b40278e5e468c6c1(#"gametype", #"hash_637597fbdf194e7a");
  globals.game_type_col["cp_survival"] = function_b40278e5e468c6c1(#"gametype", #"hash_79cc8147f3dc8572");
  globals.game_type_col["cp_wave_sv"] = function_b40278e5e468c6c1(#"gametype", #"hash_210b7c134eaec1f3");
  globals.game_type_col["brtdm"] = function_b40278e5e468c6c1(#"gametype", #"hash_67c1df9e3d5023ed");
  globals.game_type_col["oic"] = function_b40278e5e468c6c1(#"gametype", #"hash_4f413a1bf0cd2d97");
  globals.game_type_col["ko"] = function_b40278e5e468c6c1(#"gametype", #"hash_281f8639264258b0");
  globals.game_type_col["risk"] = function_b40278e5e468c6c1(#"gametype", #"hash_94545e5c8846c395");
  globals.game_type_col["hstg"] = function_b40278e5e468c6c1(#"gametype", #"hash_c8df63a365d0db66");
  globals.game_type_col["fr"] = function_b40278e5e468c6c1(#"gametype", #"hash_282a7939264c4a1e");
  globals.game_type_col["gwbomb"] = function_b40278e5e468c6c1(#"gametype", #"hash_259348284f0f4cc4");
  globals.game_type_col["rescue"] = function_b40278e5e468c6c1(#"gametype", #"hash_9ebabf7a445387c3");
  globals.game_type_col["war_mgl"] = function_b40278e5e468c6c1(#"gametype", #"hash_2c940e978e2052e6");
  globals.game_type_col["dom_mgl"] = function_b40278e5e468c6c1(#"gametype", #"hash_6bfe18dcf0bec72d");
  globals.game_type_col["zm_rb"] = function_b40278e5e468c6c1(#"gametype", #"hash_ee1508011908d6f0");
  globals.game_type_col["gwai"] = function_b40278e5e468c6c1(#"gametype", #"hash_a51fa5bbd5689172");
  globals.game_type_col["control"] = function_b40278e5e468c6c1(#"gametype", #"hash_b7a4eaad0b7e7803");
  globals.game_type_col["ob"] = function_b40278e5e468c6c1(#"gametype", #"hash_28127b392637bba3");
  globals.game_type_col["elim"] = 7;
  globals.game_type_col["benchmark"] = function_b40278e5e468c6c1(#"gametype", #"hash_6cca546ad092b105");
  globals.game_type_col["ballmode"] = function_b40278e5e468c6c1(#"gametype", #"hash_3fe61236bae85f58");
  globals.game_type_col["dungeons"] = 10;
  globals.game_type_col["zm_turned"] = 6;
  globals.game_type_col["bounty"] = function_b40278e5e468c6c1(#"gametype", #"hash_77c2b42a34b997bd");
  globals.game_type_col["brtdm_mgl"] = function_b40278e5e468c6c1(#"gametype", #"hash_b04061cb04f6f43a");
  globals.game_type_col["conflict"] = function_b40278e5e468c6c1(#"gametype", #"hash_44f627b6b4df0374");
  globals.game_type_col["training_course"] = function_b40278e5e468c6c1(#"gametype", #"hash_206378862002a2dc");
  globals.game_type_col["wm"] = function_b40278e5e468c6c1(#"gametype", #"hash_28638839267c28e2");
  globals.game_type_col["war_cranked"] = function_b40278e5e468c6c1(#"gametype", #"hash_5da6de525b828211");
  globals.game_type_col["havoc"] = function_b40278e5e468c6c1(#"gametype", #"hash_a6e9240671c5c5f");
  globals.game_type_col["warrior"] = function_b40278e5e468c6c1(#"gametype", #"hash_1a3efb5505755948");
  globals.game_type_col["more_battles"] = function_b40278e5e468c6c1(#"gametype", #"hash_6a5d5bf198caa0bb");
  globals.game_type_col["slam"] = function_b40278e5e468c6c1(#"gametype", #"hash_b69f616253f7af27");
  globals.game_type_col["br"] = function_b40278e5e468c6c1(#"gametype", #"hash_283771392656c6e2");
  globals.game_type_col["resurgence"] = function_b40278e5e468c6c1(#"gametype", #"hash_f619a150a59cd8b8");
  globals.game_type_col["zonecontrol"] = function_b40278e5e468c6c1(#"gametype", #"hash_1c4004bc52aa7574");
  globals.game_type_col["plunder"] = function_b40278e5e468c6c1(#"gametype", #"hash_731d29529dec358d");
  globals.game_type_col["culture"] = function_b40278e5e468c6c1(#"gametype", #"hash_4035d81e96395b65");
  globals.game_type_col["codmas_resurgence"] = function_b40278e5e468c6c1(#"gametype", #"hash_5e0811865efa4064");
  globals.game_type_col["dmz"] = function_b40278e5e468c6c1(#"gametype", #"hash_a418775e254600ac");
  globals.game_type_col["exgm"] = function_b40278e5e468c6c1(#"gametype", #"hash_a418775e254600ac");
  globals.game_type_col["sandbox"] = function_b40278e5e468c6c1(#"gametype", #"hash_e69084c35403cc98");
  globals.game_type_col["evac"] = function_b40278e5e468c6c1(#"gametype", #"hash_1c7e60f30e7507d2");
  globals.game_type_col["extract"] = function_b40278e5e468c6c1(#"gametype", #"hash_67fa599409d2c6d2");
  globals.game_type_col["resurgence_loaded"] = function_b40278e5e468c6c1(#"gametype", #"hash_36525d0e608862e0");
  globals.game_type_col["battleroyale_ftue"] = function_b40278e5e468c6c1(#"gametype", #"hash_9e4e019605131b02");
  globals.game_type_col["resurgence_supreme"] = function_b40278e5e468c6c1(#"gametype", #"hash_b87a92bbe8eb304c");
  globals.game_type_col["limbo"] = function_b40278e5e468c6c1(#"gametype", #"hash_1022e20a2a500a56");
  globals.game_type_col["zxp"] = function_b40278e5e468c6c1(#"gametype", #"hash_c439415da6d9d379");
}

function function_e1770d1e0f2d89e2() {
  globals = spawnStruct();
  level.challengeandeventglobals = globals;
  globals.game_type_col = [];
  globals.game_type_col["dm"] = 5;
  globals.game_type_col["war"] = 6;
  globals.game_type_col["sd"] = 7;
  globals.game_type_col["dom"] = 8;
  globals.game_type_col["conf"] = 9;
  globals.game_type_col["sr"] = 10;
  globals.game_type_col["grind"] = 11;
  globals.game_type_col["ball"] = 12;
  globals.game_type_col["infect"] = 13;
  globals.game_type_col["tjugg"] = 14;
  globals.game_type_col["gun"] = 15;
  globals.game_type_col["grnd"] = 16;
  globals.game_type_col["siege"] = 17;
  globals.game_type_col["koth"] = 18;
  globals.game_type_col["ctf"] = 19;
  globals.game_type_col["dd"] = 20;
  globals.game_type_col["tdef"] = 21;
  globals.game_type_col["front"] = 22;
  globals.game_type_col["cmd"] = 23;
  globals.game_type_col["br"] = 24;
  globals.game_type_col["arena"] = 25;
  globals.game_type_col["cyber"] = 26;
  globals.game_type_col["rush"] = 27;
  globals.game_type_col["esc"] = 28;
  globals.game_type_col["vip"] = 29;
  globals.game_type_col["btm"] = 30;
  globals.game_type_col["rugby"] = 31;
  globals.game_type_col["arm"] = 32;
  globals.game_type_col["mtmc"] = 33;
  globals.game_type_col["snatch"] = 34;
  globals.game_type_col["hq"] = 35;
  globals.game_type_col["defcon"] = 36;
  globals.game_type_col["pill"] = 37;
  globals.game_type_col["blitz"] = 38;
  globals.game_type_col["brm"] = 39;
  globals.game_type_col["hvt"] = 40;
  globals.game_type_col["trial"] = 41;
  globals.game_type_col["cp_survival"] = 42;
  globals.game_type_col["cp_wave_sv"] = 43;
  globals.game_type_col["brtdm"] = 44;
  globals.game_type_col["oic"] = 45;
  globals.game_type_col["cp_specops"] = 46;
  globals.game_type_col["incursion"] = 47;
  globals.game_type_col["missions"] = 48;
  globals.game_type_col["cqc"] = 49;
  globals.game_type_col["dungeons"] = 50;
}

function function_6b6b6273f8180522(var_e6f187bcb4b1648e, origin, radius, entityowner) {
  assertex(isDefined(self), "<dev string:x28f>");

  if(isDefined(origin)) {
    self.mapcircle = function_dc11c1caffe56e16(var_e6f187bcb4b1648e, origin[0], origin[1], radius, entityowner);
  } else {
    self.mapcircle = function_dc11c1caffe56e16(var_e6f187bcb4b1648e, undefined, undefined, radius, entityowner);
  }

  function_4eaf685bc40a3b9();
}

function function_6e148c8da2e4db13(neworigin) {
  assertex(isDefined(self.mapcircle), "<dev string:x2f1>");

  if(function_acaa75ca8754452e()) {
    self.mapcircle.origin = (neworigin[0], neworigin[1], self.mapcircle.origin[2]);
  }
}

function function_6a52fd9d448df322(newindex) {
  assertex(isDefined(self.mapcircle), "<dev string:x358>");

  if(function_acaa75ca8754452e()) {
    self.mapcircle function_9a27bb9750c77935(newindex);
  }
}

function function_6988310081de7b45() {
  assertex(isDefined(self.mapcircle), "<dev string:x3c3>");

  if(function_acaa75ca8754452e()) {
    self.mapcircle show();
  }
}

function function_4eaf685bc40a3b9() {
  assertex(isDefined(self.mapcircle), "<dev string:x42f>");

  if(function_acaa75ca8754452e()) {
    self.mapcircle hide();
  }
}

function function_cfd53c8f6878014f(player) {
  assertex(isDefined(self.mapcircle), "<dev string:x49d>");

  if(function_acaa75ca8754452e()) {
    self.mapcircle showtoplayer(player);
  }
}

function function_d7d113d56ef0ef5b(player) {
  assertex(isDefined(self.mapcircle), "<dev string:x50c>");

  if(function_acaa75ca8754452e()) {
    self.mapcircle hidefromplayer(player);
  }
}

function function_4584ad1c0e2c58ec(newradius) {
  assertex(isDefined(self.mapcircle), "<dev string:x57d>");

  if(function_acaa75ca8754452e()) {
    self.mapcircle.origin = (self.mapcircle.origin[0], self.mapcircle.origin[1], newradius);
  }
}

function function_af5604ce591768e1() {
  if(function_acaa75ca8754452e()) {
    self.mapcircle delete();
  }
}

function function_d9583306c5a171e4() {
  var_2a73dee08dd771a7 = (0, 0, 0);

  if(function_acaa75ca8754452e()) {
    var_2a73dee08dd771a7 = self.mapcircle.origin;
  }

  return var_2a73dee08dd771a7;
}

function function_acaa75ca8754452e() {
  return isDefined(self.mapcircle);
}

function function_db48978d7206bd41(var_e6f187bcb4b1648e, origin, radius, var_a567a9249da5e49b) {
  assertex(isDefined(self), "<dev string:x28f>");
  self.var_616c7052c6c2d9b9 = function_dc11c1caffe56e16(var_e6f187bcb4b1648e, origin[0], origin[1], radius, var_a567a9249da5e49b);
  function_8d43e0a01e766078();
}

function function_1d0718fb3b210270(neworigin) {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "<dev string:x5e9>");

  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9.origin = (neworigin[0], neworigin[1], self.var_616c7052c6c2d9b9.origin[2]);
  }
}

function function_6c06a9a26af579e8() {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "<dev string:x651>");

  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9 show();
  }
}

function function_8d43e0a01e766078() {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "<dev string:x6be>");

  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9 hide();
  }
}

function function_fab8ec5feb7d4c9c(player) {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "<dev string:x72d>");

  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9 showtoplayer(player);
  }
}

function function_74c4cd59f26eb9ec(player) {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "<dev string:x79d>");

  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9 hidefromplayer(player);
  }
}

function function_ae2bfaa147f91ca5(newradius) {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "<dev string:x80f>");

  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9.origin = (self.var_616c7052c6c2d9b9.origin[0], self.var_616c7052c6c2d9b9.origin[1], newradius);
  }
}

function function_f630402329582086() {
  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9 delete();
  }
}

function function_dcc52394e28dafad() {
  var_2a73dee08dd771a7 = (0, 0, 0);

  if(function_28f9dfe13002dbb9()) {
    var_2a73dee08dd771a7 = self.var_616c7052c6c2d9b9.origin;
  }

  return var_2a73dee08dd771a7;
}

function function_28f9dfe13002dbb9() {
  return isDefined(self.var_616c7052c6c2d9b9);
}

function isaigameparticipant(ent) {
  if(isagent(ent) && istrue(ent.agent_gameparticipant)) {
    return true;
  }

  if(isbot(ent)) {
    return true;
  }

  return false;
}

function isgameparticipant(ent) {
  if(isaigameparticipant(ent)) {
    return true;
  }

  if(isPlayer(ent)) {
    return true;
  }

  return false;
}

function addtoparticipantsarray() {
  assert(isgameparticipant(self));
  level.participants[level.participants.size] = self;
}

function function_1802112b9d0b0ff1() {
  self.agent_teamparticipant = 1;
  level.var_96df914b8abdd34f = 1;
}

function removefromparticipantsarray() {
  found = 0;

  for(entry = 0; entry < level.participants.size; entry++) {
    if(level.participants[entry] == self) {
      found = 1;

      while(entry < level.participants.size - 1) {
        level.participants[entry] = level.participants[entry + 1];
        assert(level.participants[entry] != self);
        entry++;
      }

      level.participants[entry] = undefined;
      break;
    }
  }

  assert(found);
}

function addtocharactersarray() {
  assert(isPlayer(self) || isbot(self) || isagent(self));
  assert(!isDefined(self.var_7a9bd393dfab7faf));
  self.var_7a9bd393dfab7faf = level.characters.size;
  level.characters[level.characters.size] = self;
}

function removefromcharactersarray() {
  assert(isDefined(self.var_7a9bd393dfab7faf));
  toremoveindex = undefined;

  if(isDefined(self.var_7a9bd393dfab7faf)) {
    assert(isDefined(level.characters[self.var_7a9bd393dfab7faf]));

    if(isDefined(level.characters[self.var_7a9bd393dfab7faf])) {
      assert(level.characters[self.var_7a9bd393dfab7faf] == self);

      if(level.characters[self.var_7a9bd393dfab7faf] == self) {
        toremoveindex = self.var_7a9bd393dfab7faf;
      }
    }
  }

  if(!isDefined(toremoveindex)) {
    found = 0;

    for(entry = 0; entry < level.characters.size; entry++) {
      if(level.characters[entry] == self) {
        toremoveindex = entry;
        found = 1;
        break;
      }
    }

    assert(found);
  }

  if(isDefined(toremoveindex)) {
    level.characters[toremoveindex] = level.characters[level.characters.size - 1];
    level.characters[toremoveindex].var_7a9bd393dfab7faf = toremoveindex;
    level.characters[level.characters.size - 1] = undefined;
    self.var_7a9bd393dfab7faf = undefined;
    return;
  }

  assertmsg("<dev string:x87c>");
}

function trackprojectiles() {
  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  if(!isDefined(level.projectilekillstreaks)) {
    level.projectilekillstreaks = [];
  }

  if(!isDefined(level.var_2d97afead10e4548)) {
    level.var_2d97afead10e4548 = 0;
  }

  while(true) {
    level.grenades = getEntArray("grenade", "classname");
    level.missiles = getEntArray("rocket", "classname");
    level.projectilepartition = undefined;
    level.smallprojectilepartition = undefined;
    waitframe();
  }
}

function createprojectilepartition() {
  if(isDefined(level.projectilepartition)) {
    return;
  }

  level.projectilepartition = function_8e7fb050ec31dcb1(400);
}

function function_9ed62e98a39d59eb() {
  if(isDefined(level.smallprojectilepartition)) {
    return;
  }

  level.smallprojectilepartition = function_8e7fb050ec31dcb1(400);
}

function private function_8e7fb050ec31dcb1(size) {
  arr2d = [];
  arr2d[0] = level.grenades;
  arr2d[1] = level.missiles;
  arr2d[2] = level.mines;
  arr2d[3] = level.projectilekillstreaks;
  projectiles = [];

  foreach(array in arr2d) {
    foreach(entity in array) {
      if(isent(entity)) {
        projectiles[entity getentitynumber()] = entity;
      }
    }
  }

  return create_partition(projectiles, size);
}

function game_utility_init() {
  issharedfuncdefined("<dev string:x8a9>", "<dev string:x8b9>", 1);

  [[getsharedfunc("game_utility", "init")]]();

  issharedfuncdefined("<dev string:x8a9>", "<dev string:x8c1>", 1);

  battlepassxpscale = function_6d29dcaf4fd78604();
  var_1a6adab6eb352e70 = function_5d1c0ff7078f3160();

  if(var_1a6adab6eb352e70 && (battlepassxpscale > 4 || battlepassxpscale < 0)) {
    exitlevel(0);
  }

  level addbattlepassxpmultiplier(battlepassxpscale, "online_battle_xpscale_dvar");
}

function values_init() {
  val::register("player_for_spawn_logic", 1, 0, "$self", &function_a3d2fe29dc7c7c4c, "$value");
  val::register("cg_drawcrosshair", 1, 0, "$self", &set_allow_crosshair, "$value");
}

function private function_a3d2fe29dc7c7c4c(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  self ignorecharacterduringspawnselection(!b_value);
}

function function_53c9c4130046f113() {
  xpmodifier = level getbattlepassxpmultiplier();
  var_9a43fe5a154b7bc8 = 1;
  var_18648eb9853b55b = getdvarint(@ "hash_a429ab6edb6e3023", 0) == 0;

  if(var_18648eb9853b55b) {
    var_18648eb9853b55b = function_5d1c0ff7078f3160();
  }

  if((xpmodifier > 4 || xpmodifier < 0) && var_18648eb9853b55b) {
    exitlevel(0);
  }

  if(self isbnetigrplayer()) {
    var_9a43fe5a154b7bc8 = getbnetigrbattlepassxpmultiplier(self);
  }

  returnval = xpmodifier * var_9a43fe5a154b7bc8;
  return returnval;
}

function getbattlepassxpmultiplier() {
  if(!isDefined(self.battlepassxpmultipliers)) {
    return 1;
  }

  modifiertotal = 1;

  foreach(modifier in self.battlepassxpmultipliers) {
    if(!isDefined(modifier)) {
      continue;
    }

    modifiertotal *= modifier;
  }

  return modifiertotal;
}

function addbattlepassxpmultiplier(multiplier, ref) {
  maxmultiplier = 4 / level getbattlepassxpmultiplier();

  if(!function_5d1c0ff7078f3160()) {
    maxmultiplier = 2147483647;
  }

  if(multiplier > maxmultiplier) {
    return;
  }

  if(!isDefined(self.battlepassxpmultipliers)) {
    self.battlepassxpmultipliers = [];
  }

  if(isDefined(self.battlepassxpmultipliers[ref])) {
    self.battlepassxpmultipliers[ref] = max(self.battlepassxpmultipliers[ref], multiplier);
    return;
  }

  self.battlepassxpmultipliers[ref] = multiplier;
}

function function_e3ef0908b595e8e1() {
  playlistid = getplaylistid();
  xpscale = 1;
  playlistxpscale = 1;

  if(function_b50db665dabc3242()) {
    xpscale = function_1110ad9d0083fab2();
  }

  if(!isDefined(playlistid) || playlistid == 0) {
    return xpscale;
  }

  if(function_fe302421a06d131(playlistid)) {
    playlistxpscale = function_ebc8c5847567a441(playlistid);
  }

  return int(max(xpscale, playlistxpscale));
}

function function_7d04fc91bee2ccd1() {
  playlistid = getplaylistid();
  xpscale = 1;
  playlistxpscale = 1;

  if(function_fd12123fa2b20ae2()) {
    xpscale = function_5aa5cd80dca3a13e();
  }

  if(!isDefined(playlistid) || playlistid == 0) {
    return xpscale;
  }

  if(function_fe302421a06d131(playlistid)) {
    playlistxpscale = function_c68b375ee4d21125(playlistid);
  }

  return int(max(xpscale, playlistxpscale));
}

function function_6d29dcaf4fd78604() {
  playlistid = getplaylistid();
  xpscale = 1;
  playlistxpscale = 1;

  if(function_d1b91b2d7266daa7()) {
    xpscale = function_102cd99503a736eb();
  }

  if(!isDefined(playlistid) || playlistid == 0) {
    return xpscale;
  }

  if(function_fe302421a06d131(playlistid)) {
    playlistxpscale = function_e25f303d003e51d8(playlistid);
  }

  return int(max(xpscale, playlistxpscale));
}

function function_b3bd8c86dbdd11c1() {
  playlistid = getplaylistid();
  xpscale = 1;
  playlistxpscale = 1;

  if(function_ea5f12135b20a4f2()) {
    xpscale = function_be370af9d6d6a162();
  }

  if(!isDefined(playlistid) || playlistid == 0) {
    return xpscale;
  }

  if(function_fe302421a06d131(playlistid)) {
    playlistxpscale = function_55663c81ba8c769(playlistid);
  }

  return int(max(xpscale, playlistxpscale));
}

function function_574c0312c915c601() {
  playlistid = getplaylistid();
  xpscale = 1;
  playlistxpscale = 1;

  if(function_2c1e51a829c5e74e()) {
    xpscale = function_67fd921df2b7ff06();
  }

  if(!isDefined(playlistid) || playlistid == 0) {
    return xpscale;
  }

  if(function_fe302421a06d131(playlistid)) {
    playlistxpscale = function_5045e85bf84c189(playlistid);
  }

  return int(max(xpscale, playlistxpscale));
}

function private set_allow_crosshair(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }
}

function gettimepassed() {
  if(!isDefined(level.starttime) || !isDefined(level.discardtime)) {
    return 0;
  }

  if(level.timerstopped) {
    return (level.timerpausetime - level.starttime - level.discardtime - level.overtimetotal);
  }

  return gettime() - level.starttime - level.discardtime - level.overtimetotal;
}

function private function_55602ddbca3038e4() {
  assert(isDefined(self));
  assert(isPlayer(self));
  player = self;

  if(!isDefined(player.var_24475874b6697c12) || isDefined(player.operatorcustomization) && !is_equal(player.var_24475874b6697c12.var_774225f630d95336, player.operatorcustomization.skinlootid)) {
    var_24475874b6697c12 = spawnStruct();
    var_24475874b6697c12.var_c6e4b758ed335f41 = 0;

    if(!isDefined(player.operatorcustomization)) {
      if(isDefined(player.team) && utility::callsharedfunc("game", "isGameplayTeam", player.team)) {
        player utility::callsharedfunc("game", "getOperatorCustomization");
      }
    }

    if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.skinlootid)) {
      var_24475874b6697c12.var_275e96b5342e77ff = function_6a80a96a06a99d38(player.operatorcustomization.skinlootid);
      var_24475874b6697c12.var_774225f630d95336 = player.operatorcustomization.skinlootid;
    }

    var_fd476bda738b0d05 = scripts\common\utility::ismp() && !isbrstylegametype() && getgametype() != "ob" && getgametype() != "ob_rift_run" && getgametype() != "ob_pvpve";

    if(var_fd476bda738b0d05) {
      var_48c6afe9d308416c = player scripts\cp_mp\operator::function_e64d40930c925cd8();

      if(isDefined(var_48c6afe9d308416c)) {
        var_24475874b6697c12.var_48c6afe9d308416c = var_48c6afe9d308416c;
        var_24475874b6697c12.var_cc4d633744b9d54a = scripts\cp_mp\operator::function_6a80a96a06a99d38(var_48c6afe9d308416c);
      }

      var_1c6922a7d061f276 = player scripts\cp_mp\operator::function_9b7c8b7b979d92de();

      if(isDefined(var_1c6922a7d061f276)) {
        var_24475874b6697c12.var_1c6922a7d061f276 = var_1c6922a7d061f276;
        var_24475874b6697c12.var_34e6e75dc23f5f3c = scripts\cp_mp\operator::function_6a80a96a06a99d38(var_1c6922a7d061f276);
      }
    }

    player.var_24475874b6697c12 = var_24475874b6697c12;
  }

  return player.var_24475874b6697c12;
}

function private function_91f9ac96c832a4b7(var_867dbf4e9f8c953c) {
  assert(isPlayer(self));
  var_3263abad29fc00f9 = function_55602ddbca3038e4();
  var_3263abad29fc00f9.var_c6e4b758ed335f41 = 0;

  if(!isDefined(self.var_768319c29f83fe5c)) {
    self.var_768319c29f83fe5c = 0;
  }

  if(isDefined(var_3263abad29fc00f9.var_275e96b5342e77ff) || isDefined(var_3263abad29fc00f9.var_cc4d633744b9d54a) || isDefined(var_3263abad29fc00f9.var_34e6e75dc23f5f3c)) {
    var_3263abad29fc00f9.var_c6e4b758ed335f41++;

    foreach(other in self getfireteammembers()) {
      if(isDefined(var_867dbf4e9f8c953c) && other == var_867dbf4e9f8c953c) {
        continue;
      }

      var_3263a8ad29fbfa60 = other function_55602ddbca3038e4();
      var_2de85c503a8fc4bd = is_equal(var_3263abad29fc00f9.var_275e96b5342e77ff, var_3263a8ad29fbfa60.var_275e96b5342e77ff);
      var_eb7fe31335aa989c = is_equal(var_3263abad29fc00f9.var_cc4d633744b9d54a, var_3263a8ad29fbfa60.var_cc4d633744b9d54a);
      var_fd4f590e1ffc501e = is_equal(var_3263abad29fc00f9.var_34e6e75dc23f5f3c, var_3263a8ad29fbfa60.var_34e6e75dc23f5f3c);

      if(var_2de85c503a8fc4bd || var_eb7fe31335aa989c || var_fd4f590e1ffc501e) {
        var_3263abad29fc00f9.var_c6e4b758ed335f41++;
      }
    }
  }

  self.var_768319c29f83fe5c = max(self.var_768319c29f83fe5c, var_3263abad29fc00f9.var_c6e4b758ed335f41);
}

function function_b6af940d92701b15(playeractive) {
  assert(isPlayer(self));

  if(!istrue(level.onlinegame)) {
    return;
  }

  if(playeractive) {
    function_91f9ac96c832a4b7();

    foreach(member in self getfireteammembers()) {
      member function_91f9ac96c832a4b7();
    }

    return;
  }

  self.var_24475874b6697c12 = undefined;

  foreach(member in self getfireteammembers()) {
    member function_91f9ac96c832a4b7(self);
  }
}

function function_48cd6b808f1b2644() {
  assert(isPlayer(self));

  if(!isDefined(self.var_24475874b6697c12)) {
    return 0;
  }

  return self.var_24475874b6697c12.var_c6e4b758ed335f41;
}

function function_5e61313ccc7db173(var_499d049610f9de69, basexp) {
  assert(isPlayer(self));

  if(!isxhash(var_499d049610f9de69)) {
    assertex(1, "<dev string:x8da>");
    var_499d049610f9de69 = getxhash(var_499d049610f9de69);
  }

  modifier = 0;

  if(!isDefined(self.var_ac7bacff44259d9)) {
    self.var_ac7bacff44259d9 = 0;
  }

  partysize = self getprivatepartysize();
  self.var_ac7bacff44259d9 = max(self.var_ac7bacff44259d9, partysize);

  if(partysize == 2) {
    switch (var_499d049610f9de69) {
      case #"account":
        modifier = level.var_80d9f200fb6ac50b;
        break;
      case #"weapon":
        modifier = level.var_9a4affc0f167ca7b;
        break;
      case #"bp":
        modifier = level.var_fe795d1588196bc5;
        break;
    }
  } else if(partysize == 3) {
    switch (var_499d049610f9de69) {
      case #"account":
        modifier = level.var_80d9f100fb6ac2d8;
        break;
      case #"weapon":
        modifier = level.var_9a4afec0f167c848;
        break;
      case #"bp":
        modifier = level.var_fe795c1588196992;
        break;
    }
  } else if(partysize >= 4) {
    switch (var_499d049610f9de69) {
      case #"account":
        modifier = level.var_ea1f92bd3f0e2fdd;
        break;
      case #"weapon":
        modifier = level.var_8e3bab95e06e99ed;
        break;
      case #"bp":
        modifier = level.var_e9a1de60e6051507;
        break;
    }
  }

  return int(basexp * modifier);
}

function function_526238fba52ecffb(var_499d049610f9de69, basexp) {
  assert(isPlayer(self));

  if(!isxhash(var_499d049610f9de69)) {
    assertex(1, "<dev string:x8da>");
    var_499d049610f9de69 = getxhash(var_499d049610f9de69);
  }

  modifier = 0;
  var_bd3a1534864b8da9 = function_48cd6b808f1b2644();

  if(var_bd3a1534864b8da9 == 2) {
    switch (var_499d049610f9de69) {
      case #"account":
        modifier = level.var_46569ffe2bee9b77;
        break;
      case #"weapon":
        modifier = level.var_e709d275ac801177;
        break;
      case #"bp":
        modifier = level.var_453fc056b2c0a611;
        break;
    }
  } else if(var_bd3a1534864b8da9 >= 3) {
    switch (var_499d049610f9de69) {
      case #"account":
        modifier = level.var_b74129ea79dcdc04;
        break;
      case #"weapon":
        modifier = level.var_9a6392a8e18cb204;
        break;
      case #"bp":
        modifier = level.var_26d265e7d8635562;
        break;
    }
  }

  return int(basexp * modifier);
}