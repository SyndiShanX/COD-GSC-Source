/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\game_utility.gsc
**************************************************/



#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace game_utility;

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

  return level.gametype;
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

function function_9cdaadfddeda4d7a() {
  return istrue(level.var_9cdaadfddeda4d7a);
}

function function_6c1fce6f6b8779d5() {
  if(isbrstylegametype()) {
    subgametype = getDvar(@ "hash_7611a2790a0bf7fe", "");

    if(subgametype != "") {
      return subgametype;
    }
  }

  return level.gametype;
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
    println("<dev string:x1c>" + localeid);

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
    println("<dev string:x37>" + entname + "<dev string:x4d>" + level.localeid + "<dev string:x67>");
  }

  if(istrue(var_8a8a9680c8ad47a2)) {
    assertmsg("Asking for a locale tagged ent that cannot be found.");
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
    println("<dev string:x37>" + structname + "<dev string:x4d>" + level.localeid + "<dev string:x67>");
  }

  if(istrue(var_8a8a9680c8ad47a2)) {
    assertmsg("Asking for a locale tagged ent that cannot be found.");
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
      println("<dev string:x37>" + structname + "<dev string:x4d>" + level.localeid + "<dev string:x67>");
    }

    if(istrue(var_8a8a9680c8ad47a2)) {
      assertmsg("Asking for a locale tagged ent that cannot be found.");
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
  assertex(!isDefined(fadetime) || fadetime >= 0, "fadeToBlackForPlayerKeepUI: fadeTime can't be less than 0");
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

  assertex(!isDefined(fadetime) || fadetime >= 0, "fadeToBlackForPlayer: fadeTime can't be less than 0");
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
    player setclientomnvar("ui_total_fade", fadealpha);
    fadetimecounter--;
    waitframe();
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

  var_8283ee79fff791be = int(getbattlepassxpultipliertotal() * 100);
  aeeventname = #"start_match";
  aeeventid = function_6e2deb013c9ca85e(aeeventname);
  self function_db073176839d77fb(aeeventid, [function_d6f771aedba70ce7(aeeventname, #"version"), 1, function_d6f771aedba70ce7(aeeventname, #"playlist_id"), getplaylistid(), function_d6f771aedba70ce7(aeeventname, #"hash_f49dbd32adacb71c"), var_8283ee79fff791be, function_d6f771aedba70ce7(aeeventname, #"lobby_id"), function_4f9373a1227db35c(), function_d6f771aedba70ce7(aeeventname, #"match_id"), function_94c7ae7049488358()]);
  self.reportchallengeuserevent_done = 0;
}

function stopkeyearning(winner) {
  if(!isDefined(self)) {
    assertmsg("Game_utility.gsc - stopKeyEarning: passed undefined self");
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
    assertmsg("Game_utility.gsc - stopKeyEarning was passed an undefined winner string");
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

  scripts\cp_mp\challenges::function_b5929663421247fa(self, result, winner);
  self reportchallengeuserevent("death", 0);
  self.reportchallengeuserevent_done = 1;
}

function _visionsetnakedforplayer(visionset, transitionduration) {
  assertex(isDefined(visionset), "_visionSetNakedForPlayer(): needs to have a valid visionSet");

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
  assertex(isDefined(self.activevisionsetlist[visionset]), "_visionUnSetNakedForPlayer(): Trying to remove an invalid visionset from the player");
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
  globals.game_type_col["br"] = function_b40278e5e468c6c1(#"gametype", #"hash_283771392656c6e2");
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
  assertex(isDefined(self), "questCircle_create: self is undefined, please make sure you call this with a valid ent/struct.");

  if(isDefined(origin)) {
    self.mapcircle = function_dc11c1caffe56e16(var_e6f187bcb4b1648e, origin[0], origin[1], radius, entityowner);
  } else {
    self.mapcircle = function_dc11c1caffe56e16(var_e6f187bcb4b1648e, undefined, undefined, radius, entityowner);
  }

  function_4eaf685bc40a3b9();
}

function function_6e148c8da2e4db13(neworigin) {
  assertex(isDefined(self.mapcircle), "questCircle_move: self.mapCircle is undefined. Please make sure you call createQuestCircle() first.");

  if(function_acaa75ca8754452e()) {
    self.mapcircle.origin = (neworigin[0], neworigin[1], self.mapcircle.origin[2]);
  }
}

function function_6a52fd9d448df322(newindex) {
  assertex(isDefined(self.mapcircle), "questCircle_setIndex: self.mapCircle is undefined. Please make sure you call createQuestCircle() first.");

  if(function_acaa75ca8754452e()) {
    self.mapcircle function_9a27bb9750c77935(newindex);
  }
}

function function_6988310081de7b45() {
  assertex(isDefined(self.mapcircle), "questCircle_showToAll: self.mapCircle is undefined. Please make sure you call createQuestCircle() first.");

  if(function_acaa75ca8754452e()) {
    self.mapcircle show();
  }
}

function function_4eaf685bc40a3b9() {
  assertex(isDefined(self.mapcircle), "questCircle_hideFromAll: self.mapCircle is undefined. Please make sure you call createQuestCircle() first.");

  if(function_acaa75ca8754452e()) {
    self.mapcircle hide();
  }
}

function function_cfd53c8f6878014f(player) {
  assertex(isDefined(self.mapcircle), "questCircle_showToPlayer: self.mapCircle is undefined. Please make sure you call createQuestCircle() first.");

  if(function_acaa75ca8754452e()) {
    self.mapcircle showtoplayer(player);
  }
}

function function_d7d113d56ef0ef5b(player) {
  assertex(isDefined(self.mapcircle), "questCircle_hideFromPlayer: self.mapCircle is undefined. Please make sure you call createQuestCircle() first.");

  if(function_acaa75ca8754452e()) {
    self.mapcircle hidefromplayer(player);
  }
}

function function_4584ad1c0e2c58ec(newradius) {
  assertex(isDefined(self.mapcircle), "questCircle_setRadius: self.mapCircle is undefined. Please make sure you call createQuestCircle() first.");

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
  assertex(isDefined(self), "questCircle_create: self is undefined, please make sure you call this with a valid ent/struct.");
  self.var_616c7052c6c2d9b9 = function_dc11c1caffe56e16(var_e6f187bcb4b1648e, origin[0], origin[1], radius, var_a567a9249da5e49b);
  function_8d43e0a01e766078();
}

function function_1d0718fb3b210270(neworigin) {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "questCircle_move: self.mapCircle2 is undefined. Please make sure you call createQuestCircle() first.");

  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9.origin = (neworigin[0], neworigin[1], self.var_616c7052c6c2d9b9.origin[2]);
  }
}

function function_6c06a9a26af579e8() {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "questCircle_showToAll: self.mapCircle2 is undefined. Please make sure you call createQuestCircle() first.");

  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9 show();
  }
}

function function_8d43e0a01e766078() {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "questCircle_hideFromAll: self.mapCircle2 is undefined. Please make sure you call createQuestCircle() first.");

  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9 hide();
  }
}

function function_fab8ec5feb7d4c9c(player) {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "questCircle_showToPlayer: self.mapCircle2 is undefined. Please make sure you call createQuestCircle() first.");

  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9 showtoplayer(player);
  }
}

function function_74c4cd59f26eb9ec(player) {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "questCircle_hideFromPlayer: self.mapCircle2 is undefined. Please make sure you call createQuestCircle() first.");

  if(function_28f9dfe13002dbb9()) {
    self.var_616c7052c6c2d9b9 hidefromplayer(player);
  }
}

function function_ae2bfaa147f91ca5(newradius) {
  assertex(isDefined(self.var_616c7052c6c2d9b9), "questCircle_setRadius: self.mapCircle2 is undefined. Please make sure you call createQuestCircle() first.");

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
  level.characters[level.characters.size] = self;
}

function removefromcharactersarray() {
  found = 0;

  for(entry = 0; entry < level.characters.size; entry++) {
    if(level.characters[entry] == self) {
      found = 1;

      while(entry < level.characters.size - 1) {
        level.characters[entry] = level.characters[entry + 1];
        assert(level.characters[entry] != self);
        entry++;
      }

      level.characters[entry] = undefined;
      break;
    }
  }

  assert(found);
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
  issharedfuncdefined("<dev string:x89>", "<dev string:x96>", 1);

  [[getsharedfunc("game_utility", "init")]]();

  issharedfuncdefined("<dev string:x89>", "<dev string:x9b>", 1);

  battlepassxpscale = getdvarint(@ "hash_95f4193739093e89");

  if(battlepassxpscale > 4 || battlepassxpscale < 0) {
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

function getbattlepassxpultipliertotal() {
  xpmodifier = level getbattlepassxpmultiplier();
  var_9a43fe5a154b7bc8 = 1;
  var_18648eb9853b55b = getdvarint(@ "hash_a429ab6edb6e3023", 0) == 0;

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
  xpscale = getdvarint(@ "online_mp_xpscale");

  if(!isDefined(playlistid) || playlistid == 0) {
    return xpscale;
  }

  playlistxpscale = function_ebc8c5847567a441();
  return int(max(xpscale, playlistxpscale));
}

function private set_allow_crosshair(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }
}