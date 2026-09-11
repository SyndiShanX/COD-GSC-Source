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

function ref_140a8() {
  if(level.gametype == "br") {
    var0 = getdvarint("scr_br_use_ww2_announcer", 1);

    if(var0 == 2) {
      return istrue(self.ref_12e3a);
    } else if(var0 == 1) {
      return true;
    }
  }

  return false;
}

function tutorialzoneenter() {
  return level.gametype == "br" && getDvar("scr_br_verse") == "ww2";
}

function ref_140a9() {
  if(level.gametype == "br") {
    return getdvarint("scr_br_use_ww2_killstreak_call_in_device", 1);
  }

  return 0;
}

function ref_140aa() {
  if(level.gametype == "br") {
    return getdvarint("scr_br_use_ww2_model_swaps", 1);
  }

  return 0;
}

function ref_12b26() {
  level.unsetchainkillstreaks = 1;
}

function unsetchainkillstreaks() {
  return istrue(level.unsetchainkillstreaks);
}

function ref_12b17() {
  level.unlink_on_ai_death = 1;
}

function unlink_on_ai_death() {
  return istrue(level.unlink_on_ai_death);
}

function ref_12b18() {
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

function ref_12b2c() {
  level.ref_11eb5 = 1;
}

function update_operator_west_char_loc() {
  return istrue(level.ref_11eb5);
}

function registerarenamap() {
  level.arenamap = 1;
  level.loadoutdefaultfiresalediscount = 1;
  level.ref_133d1 = 1;
  level.requiresminstartspawns = 0;
}

function ref_12b3b() {
  level.loadoutdefaultfiresalediscount = 1;
  level.ref_133d1 = 1;
}

function ref_12b25() {
  level.ref_133d5 = 1;
}

function isarenamap() {
  return istrue(level.arenamap);
}

function shouldskipfirstraise() {
  return istrue(level.ref_133d1);
}

function getlocaleid() {
  if(!isDefined(level.localeid)) {
    var0 = getdvarint("scr_localeID", 0);

    if(var0 > 0) {
      level.localeid = "locale_" + var0;
    } else if(var0 == 0) {
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

function getlocaleent(var0, var1) {
  var2 = getEntArray(var0, "targetname");
  var3 = undefined;

  if(isDefined(var2) && var2.size == 1) {
    return var2[0];
  }

  jumpiffalse(isDefined(getlocaleid())) LOC_000000b4;

  foreach(var5 in var2) {
    if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == level.localeid) {
      var3 = var5;
      continue;
    }

    if(level.mapname == "mp_port2_gw" && var0 == "airstrikeheight") {
      if(var5.origin == (34880, -26944, 3072)) {
        var3 = var5;
      }

      continue;
    }

    var5 delete();
  }

  goto LOC_000000e9;
}

function removematchingents_bycodeclassname(var0, var1) {
  var2 = scripts\engine\utility::getStructArray(var0, "targetname");
  var3 = undefined;
  jumpiffalse(isDefined(getlocaleid())) LOC_00000062;

  foreach(var5 in var2) {
    if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == level.localeid) {
      var3 = var5;
    }
  }

  goto LOC_00000092;
}

function removematchingents_bykey(var0, var1) {
  var2 = scripts\engine\utility::getStructArray(var0, "targetname");
  var3 = [];

  if(isDefined(getlocaleid())) {
    foreach(var5 in var2) {
      if(getmapname() == "mp_quarry2") {
        var3 = var5;
        continue;
      }

      if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == level.localeid) {
        var3 = var5;
      }
    }

    return var3;
  }

  if(var5.size == 0) {
    if(istrue(var4)) {}

    return;
  }

  return var5;
}

function isrealismenabled() {
  if(istrue(level.tacticalmode) || istrue(self.isrealismenabled)) {
    return true;
  }

  return false;
}

function fadetoblackforplayer(var0, var1, var2) {
  var0 notify("start_fade_to_black");
  var0 endon("start_fade_to_black");
  var0 endon("disconnect");
  level endon("game_ended");
  var3 = 0;

  if(istrue(var1)) {
    var3 = 1;
  }

  if(!isDefined(var2) || var2 == 0) {
    var0 setclientomnvar("ui_total_fade", var3);
    return;
  }

  var3 = 0;
  var4 = int(var2 / level.framedurationseconds);
  var5 = 1 / var4;

  if(!istrue(var1)) {
    var5 *= -1;
    var3 = 1;
  }

  while(var4 > 0) {
    var3 += var5;
    var0 setclientomnvar("ui_total_fade", var3);
    var4--;
    waitframe();
  }
}

function gettimesincegamestart() {
  return [[scripts\cp_mp\utility\script_utility::getsharedfunc("game_utility", "getTimeSinceGameStart")]]();
}

function ref_13168(var0) {
  self.vehicle_tracking_cp_post_spawn = var0;
}

function setkeyearningpoolsize(var0) {
  if(var0 < 1) {
    return;
  }

  self.†¹¨Ÿ± à óc35oû° hLò = var0;
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
  var0 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();

  if(istrue(level.ismp)) {
    self reportchallengeuserevent("start_match", var0);
  } else {
    self reportchallengeuserevent("start_match", var0);
  }

  self.reportchallengeuserevent_done = 0;
}

function stopkeyearning(var0) {
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

  if(!isDefined(self.†¹¨Ÿ± à óc35oû° hLò)) {
    setkeyearningpoolsize(255);
  }

  scripts\cp\vehicles\vehicle_compass_cp::flushchallengestats();
  var1 = 0;

  if(isDefined(var0)) {
    if(level.teambased) {
      if(var0 == "eliminated") {
        var1 = 4;
      } else if(var0 == "tie") {
        var1 = 3;
      } else if(isDefined(self.pers["team"]) && self.pers["team"] == var0) {
        var1 = 1;
      } else if(isDefined(self.pers["team"]) && self.pers["team"] != var0) {
        var1 = 2;
      }
    } else if(isDefined(self.connectedpostgame)) {
      var1 = 0;
    } else if(!isDefined(self.timeplayed) || self.timeplayed["total"] < 1 || self.pers["participation"] < 1) {
      var1 = 0;
    } else if(!istrue(self.pers["hasDoneAnyCombat"])) {
      var1 = 0;
    } else if(!isDefined(level.placement)) {
      var1 = 0;
    } else if(!isPlayer(var0) && var0 == "eliminated") {
      var1 = 4;
    } else {
      var2 = 0;

      for(var3 = 0; var3 < min(level.placement["all"].size, 3); var3++) {
        if(level.placement["all"][var3] != self) {
          continue;
        }

        var2 = 1;
      }

      if(var2) {
        var1 = 1;
      } else {
        var1 = 2;
      }
    }
  }

  var4 = scripts\cp\vehicles\vehicle_compass_cp::relic_amped_is_there_valid_new_victim();
  var5 = 0;

  if(isDefined(self.pers["totalDistTraveled"])) {
    var5 = int(self.pers["totalDistTraveled"]);
  }

  var6 = 0;

  if(isDefined(self.pers["scavengerPickedUp"])) {
    var6 = self.pers["scavengerPickedUp"];
  }

  var7 = 0;

  if(isDefined(self.pers["restockCount"])) {
    var7 = self.pers["restockCount"];
  }

  var8 = scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();
  var9 = int(gettimesincegamestart() / 1000);

  if(self.vehicle_tracking_cp_post_spawn != 255) {
    scripts\cp\vehicles\vehicle_compass_cp::ref_1205a(self.vehicle_tracking_cp_post_spawn);
  }

  var10 = 1;
  var11 = 1;
  var12 = 1;

  if(isDefined(level.rankxpmultipliers) && isDefined(level.rankxpmultipliers["online_mp_xpscale"]) && level.rankxpmultipliers["online_mp_xpscale"] >= 2) {
    var10 = 2;
  }

  if(isDefined(level.weaponrankxpmultipliers) && isDefined(level.weaponrankxpmultipliers["online_mp_weapon_xpscale"]) && level.weaponrankxpmultipliers["online_mp_weapon_xpscale"] >= 2) {
    var11 = 2;
  }

  if(isDefined(level.cleanupfunc) && isDefined(level.cleanupfunc["online_battle_xpscale_dvar"]) && level.cleanupfunc["online_battle_xpscale_dvar"] >= 2) {
    var12 = 2;
  }

  var13 = scripts\cp\vehicles\vehicle_compass_cp::relic_squadlink_onsteppedclose();
  var14 = 0;
  var15 = int(self.vehicle_tracking_cp_post_spawn / self.†¹¨Ÿ± à óc35oû° hLò * 100);
  var16 = 0;

  if(isDefined(self.pers["totalDistTraveledByFoot"])) {
    var16 = int(self.pers["totalDistTraveledByFoot"]);
  }

  if(istrue(level.ismp)) {
    self reportchallengeuserevent("end_match", var4, var1, var5, var6, var7, var8, var9, self.vehicle_tracking_cp_post_spawn, int(var10 * 100), int(var11 * 100), int(var12 * 100), var13, var14, var15, var16);
  } else {
    if(isDefined(var0) && var0 == "SUCCESS") {
      var1 = 1;
    } else {
      var1 = 2;
    }

    self reportchallengeuserevent("end_match", var4, var1, var5, 0, 0, var8, var9, self.vehicle_tracking_cp_post_spawn, int(var10 * 100), int(var11 * 100), int(var12 * 100), var13, var14, var15, var16);
  }

  self.reportchallengeuserevent_done = 1;
}

function _visionsetnakedforplayer(var0, var1) {
  if(var0 == "") {
    self visionsetnakedforplayer(var0, var1);

    if(isDefined(self.activevisionsetlist)) {
      self.activevisionsetlist = undefined;
    }

    return;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(self.activevisionsetlist)) {
    self.activevisionsetlist = [];
  }

  if(!isDefined(self.activevisionsetlist[var0])) {
    self.activevisionsetlist[var0] = 1;
  } else {
    self.activevisionsetlist[var0]++;
  }

  if(self.activevisionsetlist[var0] == 1) {
    self visionsetnakedforplayer(var0, var1);
    return;
  }
}

function _visionunsetnakedforplayer(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self.activevisionsetlist[var0]--;

  if(self.activevisionsetlist[var0] == 0) {
    var1 = [];

    foreach(var4, var3 in self.activevisionsetlist) {
      if(var4 == var0) {
        continue;
      }

      var1 = var3;
    }

    self.activevisionsetlist = var1;
    self visionsetnakedforplayer("", 0);

    foreach(var3 in var1) {
      self visionsetnakedforplayer(var4, level.framedurationseconds);
    }

    return;
  }
}

function ref_12c11(var0, var1) {
  var2 = getEntArray();

  foreach(var4 in var2) {
    if(isDefined(var4.model) && var4.model == var0) {
      if(istrue(var1) && isDefined(var4.target)) {
        ref_12c10(var4.target, "targetname");
      }

      var4 delete();
    }
  }
}

function ref_12c0f(var0) {
  var1 = getEntArray();

  foreach(var3 in var1) {
    if(isDefined(var3.code_classname) && var3.code_classname == var0) {
      var3 delete();
    }
  }
}

function ref_12c0e(var0) {
  var1 = getEntArray();

  foreach(var3 in var1) {
    if(isDefined(var3.classname) && var3.classname == var0) {
      var3 delete();
    }
  }
}

function ref_12c10(var0, var1) {
  var2 = getEntArray(var0, var1);

  foreach(var4 in var2) {
    var4 delete();
  }
}

function teamwipedobituary() {
  var0 = spawnStruct();
  level.getallselectableattachments = var0;
  var0.game_type_col = [];
  var0.game_type_col["dm"] = 5;
  var0.game_type_col["war"] = 6;
  var0.game_type_col["sd"] = 7;
  var0.game_type_col["dom"] = 8;
  var0.game_type_col["conf"] = 9;
  var0.game_type_col["sr"] = 10;
  var0.game_type_col["grind"] = 11;
  var0.game_type_col["ball"] = 12;
  var0.game_type_col["infect"] = 13;
  var0.game_type_col["tjugg"] = 14;
  var0.game_type_col["gun"] = 15;
  var0.game_type_col["grnd"] = 16;
  var0.game_type_col["siege"] = 17;
  var0.game_type_col["koth"] = 18;
  var0.game_type_col["ctf"] = 19;
  var0.game_type_col["dd"] = 20;
  var0.game_type_col["tdef"] = 21;
  var0.game_type_col["front"] = 22;
  var0.game_type_col["cmd"] = 23;
  var0.game_type_col["br"] = 24;
  var0.game_type_col["arena"] = 25;
  var0.game_type_col["cyber"] = 26;
  var0.game_type_col["rush"] = 27;
  var0.game_type_col["esc"] = 28;
  var0.game_type_col["vip"] = 29;
  var0.game_type_col["btm"] = 30;
  var0.game_type_col["rugby"] = 31;
  var0.game_type_col["arm"] = 32;
  var0.game_type_col["mtmc"] = 33;
  var0.game_type_col["snatch"] = 34;
  var0.game_type_col["hq"] = 35;
  var0.game_type_col["defcon"] = 36;
  var0.game_type_col["pill"] = 37;
  var0.game_type_col["blitz"] = 38;
  var0.game_type_col["brm"] = 39;
  var0.game_type_col["hvt"] = 40;
  var0.game_type_col["trial"] = 41;
  var0.game_type_col["cp_survival"] = 42;
  var0.game_type_col["cp_wave_sv"] = 43;
  var0.game_type_col["brtdm"] = 44;
  var0.game_type_col["oic"] = 45;
  var0.game_type_col["cp_specops"] = 46;
}

function game_utility_init() {
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("game_utility", "init")]]();
}