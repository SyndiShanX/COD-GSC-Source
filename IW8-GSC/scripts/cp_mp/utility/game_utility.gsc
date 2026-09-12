/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\game_utility.gsc
**************************************************/

function getmapname() {
  if(!isDefined(level.mapname)) {
    level.mapname = getDvar("mapname");
  }

  return level.mapname;
}

function registerlargemap() {
  level.largemap = 1;
}

function islargemap() {
  return istrue(level.largemap);
}

function update_ai_volumes() {
  return level.gametype == "br" && islargemap();
}

function ref_140A8() {
  if(level.gametype == "br") {
    var_0 = getdvarint("scr_br_use_ww2_announcer", 1);

    if(var_0 == 2) {
      return istrue(self.ref_12E3A);
    } else if(var_0 == 1) {
      return true;
    }
  }

  return false;
}

function tutorialzoneenter() {
  return level.gametype == "br" && getDvar("scr_br_verse") == "ww2";
}

function ref_140A9() {
  if(level.gametype == "br") {
    return getdvarint("scr_br_use_ww2_killstreak_call_in_device", 1);
  }

  return 0;
}

function ref_140AA() {
  if(level.gametype == "br") {
    return getdvarint("scr_br_use_ww2_model_swaps", 1);
  }

  return 0;
}

function ref_12B26() {
  level.unsetchainkillstreaks = 1;
}

function unsetchainkillstreaks() {
  return istrue(level.unsetchainkillstreaks);
}

function ref_12B17() {
  level.unlink_on_ai_death = 1;
}

function unlink_on_ai_death() {
  return istrue(level.unlink_on_ai_death);
}

function ref_12B18() {
  level.matchdata_br_onmatchstart = 1;
}

function unload_after_timeout() {
  return istrue(level.matchdata_br_onmatchstart);
}

function validateprojectileent() {
  switch (level.mapname) {
    case "mp_hmsisle_test":
    case "mp_sm_island_1":
      return true;
  }

  return false;
}

function turretdisabled() {
  switch (level.mapname) {
    case "mp_escape4_s5":
    case "mp_escape4":
    case "mp_escape3":
    case "mp_escape2_pm":
    case "mp_escape2":
      return true;
  }

  return false;
}

function turretlightsonstate() {
  switch (level.mapname) {
    case "mp_escape2_pm":
      return true;
  }

  return getdvarint("scr_br_atlantisNight", 0) == 1;
}

function registernightmap() {
  level.nightmap = 1;
  getnodeindex("killcam_night");
}

function isnightmap() {
  return istrue(level.nightmap);
}

function ref_12B2C() {
  level.ref_11EB5 = 1;
}

function update_operator_west_char_loc() {
  return istrue(level.ref_11EB5);
}

function registerarenamap() {
  level.arenamap = 1;
  level.loadoutdefaultfiresalediscount = 1;
  level.ref_133D1 = 1;
  level.requiresminstartspawns = 0;
}

function ref_12B3B() {
  level.loadoutdefaultfiresalediscount = 1;
  level.ref_133D1 = 1;
}

function ref_12B25() {
  level.ref_133D5 = 1;
}

function isarenamap() {
  return istrue(level.arenamap);
}

function shouldskipfirstraise() {
  return istrue(level.ref_133D1);
}

function getlocaleid() {
  if(!isDefined(level.localeid)) {
    var_0 = getdvarint("scr_localeID", 0);

    if(var_0 > 0) {
      level.localeid = "locale_" + var_0;
    } else if(var_0 == 0) {
      level.localeid = undefined;
    } else if(unlink_on_ai_death()) {
      level.localeid = "locale_6";
    } else {
      switch (getmapname()) {
        case "mp_quarry2":
          level.localeid = "locale_5";
          break;
        case "mp_downtown_gw":
          level.localeid = "locale_6";
          break;
        case "mp_farms2_gw":
          level.localeid = "locale_9";
          break;
        case "mp_aniyah":
          level.localeid = "locale_17";
          break;
      }
    }
  }

  return level.localeid;
}

function getlocaleent(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = undefined;

  if(isDefined(var_2) && var_2.size == 1) {
    return var_2[0];
  }

  jumpiffalse(isDefined(getlocaleid())) LOC_000000b4;

  foreach(var_5 in var_2) {
    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == level.localeid) {
      var_3 = var_5;
      continue;
    }

    if(level.mapname == "mp_port2_gw" && var_0 == "airstrikeheight") {
      if(var_5.origin == (34880, -26944, 3072)) {
        var_3 = var_5;
      }

      continue;
    }

    var_5 delete();
  }

  goto LOC_000000e9;
}

function removematchingents_bycodeclassname(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_3 = undefined;
  jumpiffalse(isDefined(getlocaleid())) LOC_00000062;

  foreach(var_5 in var_2) {
    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == level.localeid) {
      var_3 = var_5;
    }
  }

  goto LOC_00000092;
}

function removematchingents_bykey(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_3 = [];

  if(isDefined(getlocaleid())) {
    foreach(var_5 in var_2) {
      if(getmapname() == "mp_quarry2") {
        var_3 = var_5;
        continue;
      }

      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == level.localeid) {
        var_3 = var_5;
      }
    }

    return var_3;
  }

  if(var_5.size == 0) {
    if(istrue(var_4)) {}

    return;
  }

  return var_5;
}

function isrealismenabled() {
  if(istrue(level.tacticalmode) || istrue(self.isrealismenabled)) {
    return true;
  }

  return false;
}

function fadetoblackforplayer(var_0, var_1, var_2) {
  var_0 notify("start_fade_to_black");
  var_0 endon("start_fade_to_black");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_3 = 0;

  if(istrue(var_1)) {
    var_3 = 1;
  }

  if(!isDefined(var_2) || var_2 == 0) {
    var_0 setclientomnvar("ui_total_fade", var_3);
    return;
  }

  var_3 = 0;
  var_4 = int(var_2 / level.framedurationseconds);
  var_5 = 1 / var_4;

  if(!istrue(var_1)) {
    var_5 *= -1;
    var_3 = 1;
  }

  while(var_4 > 0) {
    var_3 += var_5;
    var_0 setclientomnvar("ui_total_fade", var_3);
    var_4--;
    waitframe();
  }
}

function gettimesincegamestart() {
  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game_utility", "getTimeSinceGameStart")]]();
}

function ref_13168(var_0) {
  self.vehicle_tracking_cp_post_spawn = var_0;
}

function setkeyearningpoolsize(var_0) {
  if(var_0 < 1) {
    return;
  }

  self.keyearningpoolsize = var_0;
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

  ref_13168(255);
  setkeyearningpoolsize(255);
  var_0 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();

  if(istrue(level.ismp)) {
    self reportchallengeuserevent("start_match", var_0);
  } else {
    self reportchallengeuserevent("start_match", var_0);
  }

  self.reportchallengeuserevent_done = 0;
}

function stopkeyearning(var_0) {
  if(isbot(self)) {
    return;
  }

  if(istrue(self.reportchallengeuserevent_done)) {
    return;
  }

  if(!istrue(level.playerxpenabled)) {
    return;
  }

  if(!isDefined(self.vehicle_tracking_cp_post_spawn)) {
    ref_13168(255);
  }

  if(!isDefined(self.keyearningpoolsize)) {
    setkeyearningpoolsize(255);
  }

  scripts\cp\vehicles\vehicle_compass_cp::flushchallengestats();
  var_1 = 0;

  if(isDefined(var_0)) {
    if(level.teambased) {
      if(var_0 == "eliminated") {
        var_1 = 4;
      } else if(var_0 == "tie") {
        var_1 = 3;
      } else if(isDefined(self.pers["team"]) && self.pers["team"] == var_0) {
        var_1 = 1;
      } else if(isDefined(self.pers["team"]) && self.pers["team"] != var_0) {
        var_1 = 2;
      }
    } else if(isDefined(self.connectedpostgame)) {
      var_1 = 0;
    } else if(!isDefined(self.timeplayed) || self.timeplayed["total"] < 1 || self.pers["participation"] < 1) {
      var_1 = 0;
    } else if(!istrue(self.pers["hasDoneAnyCombat"])) {
      var_1 = 0;
    } else if(!isDefined(level.placement)) {
      var_1 = 0;
    } else if(!isPlayer(var_0) && var_0 == "eliminated") {
      var_1 = 4;
    } else {
      var_2 = 0;

      for(var_3 = 0; var_3 < min(level.placement["all"].size, 3); var_3++) {
        if(level.placement["all"][var_3] != self) {
          continue;
        }

        var_2 = 1;
      }

      if(var_2) {
        var_1 = 1;
      } else {
        var_1 = 2;
      }
    }
  }

  var_4 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();
  var_5 = 0;

  if(isDefined(self.pers["totalDistTraveled"])) {
    var_5 = int(self.pers["totalDistTraveled"]);
  }

  var_6 = 0;

  if(isDefined(self.pers["scavengerPickedUp"])) {
    var_6 = self.pers["scavengerPickedUp"];
  }

  var_7 = 0;

  if(isDefined(self.pers["restockCount"])) {
    var_7 = self.pers["restockCount"];
  }

  var_8 = scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();
  var_9 = int(gettimesincegamestart() / 1000);

  if(self.vehicle_tracking_cp_post_spawn != 255) {
    scripts\cp\vehicles\vehicle_compass_cp::ref_1205A(self.vehicle_tracking_cp_post_spawn);
  }

  var_10 = 1;
  var_11 = 1;
  var_12 = 1;

  if(isDefined(level.rankxpmultipliers) && isDefined(level.rankxpmultipliers["online_mp_xpscale"]) && level.rankxpmultipliers["online_mp_xpscale"] >= 2) {
    var_10 = 2;
  }

  if(isDefined(level.weaponrankxpmultipliers) && isDefined(level.weaponrankxpmultipliers["online_mp_weapon_xpscale"]) && level.weaponrankxpmultipliers["online_mp_weapon_xpscale"] >= 2) {
    var_11 = 2;
  }

  if(isDefined(level.cleanupfunc) && isDefined(level.cleanupfunc["online_battle_xpscale_dvar"]) && level.cleanupfunc["online_battle_xpscale_dvar"] >= 2) {
    var_12 = 2;
  }

  var_13 = scripts\cp\vehicles\vehicle_compass_cp::relic_squadlink_onsteppedclose();
  var_14 = 0;
  var_15 = int(self.vehicle_tracking_cp_post_spawn / self.keyearningpoolsize * 100);
  var_16 = 0;

  if(isDefined(self.pers["totalDistTraveledByFoot"])) {
    var_16 = int(self.pers["totalDistTraveledByFoot"]);
  }

  if(istrue(level.ismp)) {
    self reportchallengeuserevent("end_match", var_4, var_1, var_5, var_6, var_7, var_8, var_9, self.vehicle_tracking_cp_post_spawn, int(var_10 * 100), int(var_11 * 100), int(var_12 * 100), var_13, var_14, var_15, var_16);
  } else {
    if(isDefined(var_0) && var_0 == "SUCCESS") {
      var_1 = 1;
    } else {
      var_1 = 2;
    }

    self reportchallengeuserevent("end_match", var_4, var_1, var_5, 0, 0, var_8, var_9, self.vehicle_tracking_cp_post_spawn, int(var_10 * 100), int(var_11 * 100), int(var_12 * 100), var_13, var_14, var_15, var_16);
  }

  self.reportchallengeuserevent_done = 1;
}

function _visionsetnakedforplayer(var_0, var_1) {
  if(var_0 == "") {
    self visionsetnakedforplayer(var_0, var_1);

    if(isDefined(self.activevisionsetlist)) {
      self.activevisionsetlist = undefined;
    }

    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(self.activevisionsetlist)) {
    self.activevisionsetlist = [];
  }

  if(!isDefined(self.activevisionsetlist[var_0])) {
    self.activevisionsetlist[var_0] = 1;
  } else {
    self.activevisionsetlist[var_0]++;
  }

  if(self.activevisionsetlist[var_0] == 1) {
    self visionsetnakedforplayer(var_0, var_1);
    return;
  }
}

function _visionunsetnakedforplayer(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self.activevisionsetlist[var_0]--;

  if(self.activevisionsetlist[var_0] == 0) {
    var_1 = [];

    foreach(var_4, var_3 in self.activevisionsetlist) {
      if(var_4 == var_0) {
        continue;
      }

      var_1 = var_3;
    }

    self.activevisionsetlist = var_1;
    self visionsetnakedforplayer("", 0);

    foreach(var_3 in var_1) {
      self visionsetnakedforplayer(var_4, level.framedurationseconds);
    }

    return;
  }
}

function ref_12C11(var_0, var_1) {
  var_2 = getEntArray();

  foreach(var_4 in var_2) {
    if(isDefined(var_4.model) && var_4.model == var_0) {
      if(istrue(var_1) && isDefined(var_4.target)) {
        ref_12C10(var_4.target, "targetname");
      }

      var_4 delete();
    }
  }
}

function ref_12C0F(var_0) {
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.code_classname) && var_3.code_classname == var_0) {
      var_3 delete();
    }
  }
}

function ref_12C0E(var_0) {
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.classname) && var_3.classname == var_0) {
      var_3 delete();
    }
  }
}

function ref_12C10(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  foreach(var_4 in var_2) {
    var_4 delete();
  }
}

function teamwipedobituary() {
  var_0 = spawnStruct();
  level.getallselectableattachments = var_0;
  var_0.game_type_col = [];
  var_0.game_type_col["dm"] = 5;
  var_0.game_type_col["war"] = 6;
  var_0.game_type_col["sd"] = 7;
  var_0.game_type_col["dom"] = 8;
  var_0.game_type_col["conf"] = 9;
  var_0.game_type_col["sr"] = 10;
  var_0.game_type_col["grind"] = 11;
  var_0.game_type_col["ball"] = 12;
  var_0.game_type_col["infect"] = 13;
  var_0.game_type_col["tjugg"] = 14;
  var_0.game_type_col["gun"] = 15;
  var_0.game_type_col["grnd"] = 16;
  var_0.game_type_col["siege"] = 17;
  var_0.game_type_col["koth"] = 18;
  var_0.game_type_col["ctf"] = 19;
  var_0.game_type_col["dd"] = 20;
  var_0.game_type_col["tdef"] = 21;
  var_0.game_type_col["front"] = 22;
  var_0.game_type_col["cmd"] = 23;
  var_0.game_type_col["br"] = 24;
  var_0.game_type_col["arena"] = 25;
  var_0.game_type_col["cyber"] = 26;
  var_0.game_type_col["rush"] = 27;
  var_0.game_type_col["esc"] = 28;
  var_0.game_type_col["vip"] = 29;
  var_0.game_type_col["btm"] = 30;
  var_0.game_type_col["rugby"] = 31;
  var_0.game_type_col["arm"] = 32;
  var_0.game_type_col["mtmc"] = 33;
  var_0.game_type_col["snatch"] = 34;
  var_0.game_type_col["hq"] = 35;
  var_0.game_type_col["defcon"] = 36;
  var_0.game_type_col["pill"] = 37;
  var_0.game_type_col["blitz"] = 38;
  var_0.game_type_col["brm"] = 39;
  var_0.game_type_col["hvt"] = 40;
  var_0.game_type_col["trial"] = 41;
  var_0.game_type_col["cp_survival"] = 42;
  var_0.game_type_col["cp_wave_sv"] = 43;
  var_0.game_type_col["brtdm"] = 44;
  var_0.game_type_col["oic"] = 45;
  var_0.game_type_col["cp_specops"] = 46;
}

function game_utility_init() {
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("game_utility", "init")]]();
}