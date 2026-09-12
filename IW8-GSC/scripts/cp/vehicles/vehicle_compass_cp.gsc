/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\vehicle_compass_cp.gsc
******************************************************/

function init() {
  level.ismountdisabled = getdvarint("debug_challenges", 0) != 0;
  level.play_intel_collect_vo = getdvarint("OLPQMTTQR", 1) != 0;
  level.getallactivequestsforteam = getdvarint("current_season", 1);

  if(!challengesenabled()) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    if(isDefined(var_0) && (var_0 == "br" || var_0 == "brtdm")) {
      level.getattractionomnvarbitpackinginfo = 1;
      setupchallengelocales(level);
      thread ref_13c45();
      ref_13223();
      return;
    }

    return;
  }
}

function ref_13223() {
  var_0 = [];
  GscBinSkip0(0x2e, "sprintout_sh_t9semiauto01", 1);
}

function turn_on_have_target_hud(var_0) {
  var_1 = var_0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getWeaponRootName")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getWeaponRootName")]](var_0);
  }

  if(isDefined(level.ref_14580) && istrue(level.ref_14580[var_1])) {
    return true;
  }

  return false;
}

function setupchallengelocales() {
  var_0 = getDvar("map_for_poi_nameset", level.mapname);
  level.challengemapid = 0;

  switch (var_0) {
    case "mp_escape4":
    case "mp_escape3":
      level.challengemapid = 2;
      _id_11AD7();
      break;
    case "mp_don4_pm":
    case "mp_don3_ch2":
    case "mp_don3":
    case "mp_don4":
      level.challengemapid = 1;
      _id_11ADB();
      break;
    case "mp_wz_island":
      level.challengemapid = 3;
      _id_11AD9();
      break;
    case "mp_sm_island_1":
      level.challengemapid = 4;
      mapchallengelocalesfortuneskeep();
      break;
    case "mp_br_mechanics":
      _id_11ADB();
      _id_11AD7();
      _id_11AD9();
      mapchallengelocalesfortuneskeep();
      break;
    default:
      _id_11AD8(var_0);
      break;
  }
}

function getchallengemapid() {
  if(isDefined(level.challengemapid))
    return level.challengemapid;

  return 0;
}

function ref_11adb() {
  level.localetriggers = [];
  var_0 = getEntArray("location_volume", "targetname");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.script_noteworthy)) {
        continue;
      }

      switch (var_2.script_noteworthy) {
        case "airfield":
          var_2.localeid = 1;
          break;
        case "boneyard":
          var_2.localeid = 2;
          break;
        case "coast":
          var_2.localeid = 3;
          break;
        case "dam":
        case "summit":
          var_2.localeid = 4;
          break;
        case "downtown":
          var_2.localeid = 5;
          break;
        case "farms":
          var_2.localeid = 6;
          break;
        case "gulag":
          var_2.localeid = 7;
          break;
        case "hospital":
          var_2.localeid = 8;
          break;
        case "junkyard":
          var_2.localeid = 9;
          break;
        case "layover":
          var_2.localeid = 10;
          break;
        case "lumber":
          var_2.localeid = 11;
          break;
        case "maintenance":
          var_2.localeid = 12;
          break;
        case "outskirts":
          var_2.localeid = 13;
          break;
        case "park":
          var_2.localeid = 14;
          break;
        case "port":
          var_2.localeid = 15;
          break;
        case "salt_mine":
        case "quarry":
          var_2.localeid = 16;
          break;
        case "river_east":
          var_2.localeid = 17;
          break;
        case "river_north":
          var_2.localeid = 18;
          break;
        case "river_south":
          var_2.localeid = 19;
          break;
        case "stadium":
          var_2.localeid = 20;
          break;
        case "storagetown":
          var_2.localeid = 21;
          break;
        case "suburbs_airfield":
          var_2.localeid = 22;
          break;
        case "suburbs_coast":
          var_2.localeid = 23;
          break;
        case "suburbs_dam":
          var_2.localeid = 24;
          break;
        case "suburbs_eastriver":
          var_2.localeid = 25;
          break;
        case "suburbs_hospital":
          var_2.localeid = 26;
          break;
        case "suburbs_quarry":
          var_2.localeid = 27;
          break;
        case "suburbs_stadium":
          var_2.localeid = 28;
          break;
        case "suburbs_super":
          var_2.localeid = 29;
          break;
        case "suburbs_transit":
          var_2.localeid = 30;
          break;
        case "super":
          var_2.localeid = 31;
          break;
        case "transit":
          var_2.localeid = 32;
          break;
        case "tvstation":
          var_2.localeid = 33;
          break;
        case "hills":
          var_2.localeid = 34;
          break;
        case "shopping_district_w":
        case "shopping_district_e":
          var_2.localeid = 35;
          break;
        default:
          ref_11ad6(var_2.script_noteworthy);
          break;
      }
    }

    level.localetriggers = var_0;
    return;
  }
}

function ref_11ad9() {
  level.localetriggers = [];
  var_0 = getEntArray("location_volume", "targetname");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.script_noteworthy)) {
        continue;
      }

      switch (var_2.script_noteworthy) {
        case "airfield":
          var_2.localeid = 36;
          break;
        case "airstrip":
          var_2.localeid = 37;
          break;
        case "arsenal":
          var_2.localeid = 38;
          break;
        case "beachhead":
          var_2.localeid = 39;
          break;
        case "caldera":
          var_2.localeid = 40;
          break;
        case "capital":
          var_2.localeid = 41;
          break;
        case "docks":
          var_2.localeid = 42;
          break;
        case "farms":
          var_2.localeid = 43;
          break;
        case "lagoon":
          var_2.localeid = 44;
          break;
        case "mines":
          var_2.localeid = 45;
          break;
        case "powerplant":
          var_2.localeid = 46;
          break;
        case "resort":
          var_2.localeid = 47;
          break;
        case "ruins":
          var_2.localeid = 48;
          break;
        case "subpen":
          var_2.localeid = 49;
          break;
        case "village":
          var_2.localeid = 50;
          break;
        case "storagetown":
          var_2.localeid = 62;
          break;
        case "chem_factory":
          var_2.localeid = 63;
          break;
        default:
          ref_11ad6(var_2.script_noteworthy);
          break;
      }
    }

    level.localetriggers = var_0;
    return;
  }
}

function ref_11ad7() {
  level.localetriggers = [];
  var_0 = getEntArray("location_volume", "targetname");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.script_noteworthy)) {
        continue;
      }

      switch (var_2.script_noteworthy) {
        case "biolab":
          var_2.localeid = 51;
          break;
        case "chemplant":
          var_2.localeid = 52;
          break;
        case "commstower":
          var_2.localeid = 53;
          break;
        case "control":
          var_2.localeid = 54;
          break;
        case "deconfacility":
          var_2.localeid = 55;
          break;
        case "factory":
          var_2.localeid = 56;
          break;
        case "harbor":
          var_2.localeid = 57;
          break;
        case "headquarters":
          var_2.localeid = 58;
          break;
        case "qblock":
          var_2.localeid = 59;
          break;
        case "residence":
          var_2.localeid = 60;
          break;
        case "shore":
          var_2.localeid = 61;
          break;
        default:
          ref_11ad6(var_2.script_noteworthy);
          break;
      }
    }

    level.localetriggers = var_0;
    return;
  }
}

function mapchallengelocalesfortuneskeep() {
  level.localetriggers = [];
  var_0 = getEntArray("location_volume", "targetname");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.script_noteworthy)) {
        continue;
      }

      switch (var_2.script_noteworthy) {
        case "coast":
          var_2.localeid = 64;
          break;
        case "beach":
          var_2.localeid = 65;
          break;
        case "graveyard":
          var_2.localeid = 66;
          break;
        case "town_square":
          var_2.localeid = 67;
          break;
        case "overlook":
          var_2.localeid = 68;
          break;
        case "town_outskirts":
          var_2.localeid = 69;
          break;
        case "cenote_top":
          var_2.localeid = 70;
          break;
        case "cenote_bottom":
          var_2.localeid = 71;
          break;
        case "radio_station":
          var_2.localeid = 72;
          break;
        case "smugglers_bay":
          var_2.localeid = 73;
          break;
        case "lighthouse":
          var_2.localeid = 74;
          break;
        case "airfield":
          var_2.localeid = 75;
          break;
        case "beach_east":
          var_2.localeid = 76;
          break;
        case "cove":
          var_2.localeid = 77;
          break;
        case "winery":
          var_2.localeid = 78;
          break;
        case "fort_east":
          var_2.localeid = 79;
          break;
        case "fort_south":
          var_2.localeid = 80;
          break;
        case "fort_west":
          var_2.localeid = 81;
          break;
        case "fort_keep":
          var_2.localeid = 82;
          break;
        case "church":
          var_2.localeid = 83;
          break;
        case "gardens":
          var_2.localeid = 84;
          break;
        case "smuggler_camp":
          var_2.localeid = 85;
          break;
        default:
          ref_11ad6(var_2.script_noteworthy);
          break;
      }
    }

    level.localetriggers = var_0;
    return;
  }
}

function ref_11ad8(var_0) {
  if(var_0 == "mp_br_mechanics" || var_0 == "mp_vg_mechanics" || var_0 == "mp_firingrange" || var_0 == "mp_hmsisle_test") {
    return;
  }
}

function ref_11ad6(var_0) {}

function challengesenabled() {
  return level.challengesallowed;
}

function challengesenabledforplayer() {
  if(!challengesenabled()) {
    return false;
  }

  if(!isPlayer(self) || isai(self)) {
    return false;
  }

  if(istrue(level.getarenapickupattachmentoverrides)) {
    return false;
  }

  return true;
}

function relic_amped_is_there_valid_new_victim() {
  var_0 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
  }

  if(!isDefined(var_0)) {
    var_0 = getDvar("g_gametype");
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(level.getallselectableattachments) || !isDefined(level.getallselectableattachments.game_type_col) || !isDefined(level.getallselectableattachments.game_type_col[var_0])) {
    return 0;
  }

  if(var_0 == "br") {
    if(getdvarint("enable_rebirth_gamemodes_shared_id", 0) && scripts\cp_mp\utility\game_utility::turretdisabled()) {
      return 95;
    }

    var_1 = "";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getSubGameType")) {
      var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getSubGameType")]]();
    }

    switch (var_1) {
      case "rat_race":
      case "dmz":
        return 99;
      case "extract":
        return 98;
      case "evac":
        return 97;
      case "sandbox":
        return 96;
      case "olaride":
      case "rebirth_dbd_reverse":
      case "rebirth_dbd":
      case "rebirth_reverse":
      case "rebirth":
        return 95;
      case "payload":
        return 94;
      case "mendota":
        return 93;
      case "gold_war":
        return 92;
      case "tdbd":
        return 91;
      case "br":
        break;
      default:
        break;
    }
  }

  return level.getallselectableattachments.game_type_col[var_0];
}

function getatvspawns() {
  if(!istrue(level.getattractionomnvarbitpackinginfo)) {
    return false;
  }

  if(!challengesenabledforplayer()) {
    return false;
  }

  return true;
}

function ref_140db(var_0) {
  if(!isDefined(self.getattachmentoverride)) {
    return false;
  }

  if(!isDefined(self.getattachmentoverride[var_0])) {
    return false;
  }

  return true;
}

function ref_12c6e(var_0) {
  if(!getatvspawns()) {
    return;
  }

  if(!ref_140db(var_0)) {
    return;
  }

  self.getattachmentoverride[var_0] = 0;
}

function ref_1383b(var_0) {
  if(!getatvspawns()) {
    return;
  }

  if(!isDefined(self.getattachmentoverride)) {
    self.getattachmentoverride = [];
  }

  if(!isDefined(self.getattachmentoverride[var_0])) {
    self.getattachmentoverride[var_0] = 0;
  }

  self.getattachmentoverride[var_0] = gettime();
}

function getchallengestatcacheamount(var_0) {
  switch (var_0) {
    case "totalDistTraveled":
      return getdvarint("scr_challenge_cache_amount_totalDistTraveled", 63360);
    case "totalDistTraveledByFoot":
      return getdvarint("scr_challenge_cache_amount_totalDistTraveledByFoot", 19685);
    default:
      return -1;
  }
}

function reportchallengestatamount(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(var_1 <= 0) {
    return;
  }

  var_2 = "scr_challenge_killswitch_stat_" + var_0;
  var_3 = getdvarint(var_2, 0);

  if(var_3 > 0) {
    return;
  }

  var_4 = resetstuckthermite();
  var_5 = relic_amped_is_there_valid_new_victim();

  switch (var_0) {
    case "driving":
      self reportchallengeuserevent("stats", var_4, var_5, var_1, 0, 0, 0, 0, 0, 0);
      break;
    case "alive_in_gas":
      self reportchallengeuserevent("stats", var_4, var_5, 0, var_1, 0, 0, 0, 0, 0);
      break;
    case "alive_not_downed":
      self reportchallengeuserevent("stats", var_4, var_5, 0, 0, var_1, 0, 0, 0, 0);
      break;
    case "totalDistTraveled":
      self reportchallengeuserevent("stats", var_4, var_5, 0, 0, 0, var_1, 0, 0, 0);
      break;
    case "totalDistTraveledByFoot":
      self reportchallengeuserevent("stats", var_4, var_5, 0, 0, 0, 0, var_1, 0, 0);
      break;
    case "spray":
      self reportchallengeuserevent("stats", var_4, var_5, 0, 0, 0, 0, 0, var_1, 0);
      break;
    case "gesture":
      self reportchallengeuserevent("stats", var_4, var_5, 0, 0, 0, 0, 0, 0, var_1);
      break;
  }
}

function ref_138d5(var_0) {
  if(!getatvspawns()) {
    return;
  }

  if(!ref_140db(var_0)) {
    return;
  }

  if(self.getattachmentoverride[var_0] > 0) {
    var_1 = gettime() - self.getattachmentoverride[var_0];

    if(var_1 > 0) {
      reportchallengestatamount(var_0, var_1);
    }

    self.getattachmentoverride[var_0] = 0;
    return;
  }
}

function getextractionpadent(var_0, var_1) {
  if(!getatvspawns()) {
    return;
  }

  if(!ref_140db(var_0)) {
    return;
  }

  if(self.getattachmentoverride[var_0] > 0) {
    var_2 = gettime() - self.getattachmentoverride[var_0];

    if(var_2 >= var_1) {
      reportchallengestatamount(var_0, var_2);
      self.getattachmentoverride[var_0] = gettime();
      return;
    }

    return;
  }
}

function ref_13c45() {
  level endon("game_ended");

  for(;;) {
    if(isDefined(level.players)) {
      var_0 = level.players.size;

      for(var_1 = 0; var_1 < var_0; var_1++) {
        if(isalive(level.players[var_1])) {
          getextractionpadent(level.players[var_1], "driving", 60000);
        }
      }
    }

    wait 1;
  }
}

function flushchallengestat(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(!isDefined(self.challengestatcache)) {
    return;
  }
  if(!isDefined(self.challengestatcache[var_0])) {
    return;
  }
  var_1 = int(self.challengestatcache[var_0]);
  self.challengestatcache[var_0] = 0;
  reportchallengestatamount(var_0, var_1);
}

function incchallengestat(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }
  if(var_1 <= 0) {
    return;
  }
  if(!isDefined(self.challengestatcache))
    self.challengestatcache = [];

  if(!isDefined(self.challengestatcache[var_0]))
    self.challengestatcache[var_0] = 0;

  self.challengestatcache[var_0] = self.challengestatcache[var_0] + var_1;

  if(self.challengestatcache[var_0] <= 0) {
    return;
  }
  var_2 = getchallengestatcacheamount(var_0);

  if(var_2 < 0) {
    return;
  }
  if(self.challengestatcache[var_0] >= var_2) {
    var_3 = int(self.challengestatcache[var_0]);
    self.challengestatcache[var_0] = 0;
    reportchallengestatamount(var_0, var_3);
  }
}

function flushchallengestats() {
  if(!challengesenabledforplayer()) {
    return;
  }

  flushchallengestat("totalDistTraveled");
  flushchallengestat("totalDistTraveledByFoot");
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!challengesenabledforplayer(var_1)) {
    return;
  }

  var_10 = self;

  if(!isPlayer(var_1)) {
    if(isDefined(var_0) && isPlayer(var_0)) {
      var_1 = var_0;
    } else {
      return;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](var_1.team, var_10)) {
      if(isDefined(var_5.ref_121d9)) {
        var_5 = var_5.ref_121d9;
      }

      var_11 = ref_14583(var_5, var_1);
      init_sentry_traps(var_0, var_1, var_11, var_10, var_7, var_8, var_5, var_2, var_4, var_9);
      return;
    }

    return;
  }
}

function ref_11ffc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!challengesenabledforplayer(var_1)) {
    return;
  }

  var_9 = self;
  var_10 = play_sound_from_closest_player(var_9);
  var_11 = ref_14583(var_5, var_1);

  if(var_10 == 2048 && level.getallactivequestsforteam == 8) {
    thread ref_14010();
    chooseanim_arrival_forcode(var_1, var_10, var_11[0], var_7, var_8, var_0, var_4);
    return;
  }
}

function ref_12097(var_0, var_1) {
  if(level.getallactivequestsforteam >= 10) {
    if(var_0.staticdata.ref == "super_supply_drop" && !var_1) {
      ref_12c3f("t9_ch_global_call_in_care_package_or_loadout_drops_for_operator_mission_s4", 1);
    }
  }

  if(level.getallactivequestsforteam >= 10) {
    if(var_0.staticdata.ref == "super_supply_drop" && !var_1) {
      ref_12c3f("t9_ch_global_call_in_care_package_or_loadout_drops_for_operator_mission_s5", 1);
      return;
    }

    return;
  }
}

function chooseanim_arrival_forcode(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "";
  var_7 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "getEquipmentTableInfo")) {
    var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "getEquipmentTableInfo")]](var_1);

    if(isDefined(var_8)) {
      var_7 = var_8.defaultslot == "primary";
    } else if(var_1 != "iav_weapon_mp") {
      var_6 = weaponclass(var_1);
    }
  } else if(var_1 != "iav_weapon_mp") {
    var_6 = weaponclass(var_1);
  }

  var_9 = var_5 == "MOD_CRUSH" && isDefined(var_4) && isDefined(var_4.vehiclename);

  if(var_2 & 1048576) {
    ref_12c3f("t9_ch_global_t9_wz_zm_critical_kills_for_event", 1);
  }

  ref_12c3f("t9_ch_global_t9_wz_zm_eliminations_for_event", 1);

  if(!isDefined(self.ref_146c8)) {
    self.ref_146c8 = 1;
  } else {
    self.ref_146c8++;
  }

  if(istrue(var_7)) {
    ref_12c3f("t9_ch_global_t9_wz_zm_lethal_equipment_kills_for_event", 1);
  }

  if(istrue(var_9)) {
    ref_12c3f("t9_ch_global_t9_wz_zm_vehicle_eliminations_for_event", 1);
  }

  if(self.ref_146c8 >= 5 && !istrue(self.show_balloon_purchase_hint)) {
    ref_12c3f("t9_ch_global_t9_wz_zm_eliminations_per_game_for_event", 1);
    self.show_balloon_purchase_hint = 1;
  }

  if(var_6 == "spread") {
    ref_12c3f("t9_ch_global_t9_wz_zm_shotgun_eliminations_for_event", 1);
  }

  if(isDefined(self.ref_12a8d) && self.ref_12a8d == 2) {
    ref_12c3f("t9_ch_global_t9_wz_zm_multikills_for_event", 1);
  }

  if(var_6 == "pistol") {
    ref_12c3f("t9_ch_global_t9_wz_zm_pistol_eliminations_for_event", 1);
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && level.br_circle.circleindex == 0) {
    ref_12c3f("t9_ch_global_t9_wz_zm_eliminations_before_circle_for_event", 1);
    return;
  }
}

function ref_14010() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentZombieKills");
  self endon("updateRecentZombieKills");

  if(!isDefined(self.ref_12a8d)) {
    self.ref_12a8d = 1;
  } else {
    self.ref_12a8d++;
  }

  wait 4;
  self.ref_12a8d = 0;
}

function vehiclekilled(var_0, var_1, var_2, var_3, var_4) {
  if(!challengesenabledforplayer(var_2)) {
    return;
  }

  var_5 = var_0;

  if(isDefined(var_4.ref_121d9)) {
    var_4 = var_4.ref_121d9;
  }

  var_6 = ref_14583(var_4, var_2);
  var_7 = "MOD_UNKNOWN";
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;

  if(isDefined(var_2.modifiers)) {
    var_8 = var_2.modifiers["mask"];
    var_9 = var_2.modifiers["mask2"];
    var_10 = var_2.modifiers["mask3"];
  }

  init_sentry_traps(var_1, var_2, var_6, var_5, var_8, var_9, var_4, var_3, var_7, var_10);
}

function equipmentdestroyed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer(var_1)) {
    return;
  }

  var_8 = self;

  if(!isPlayer(var_1)) {
    if(isDefined(var_0) && isPlayer(var_0)) {
      var_1 = var_0;
    } else {
      return;
    }
  }

  if(!isDefined(var_8.owner)) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](var_1.team, var_8.owner)) {
      if(isDefined(var_5.ref_121d9)) {
        var_5 = var_5.ref_121d9;
      }

      var_9 = ref_14583(var_5, var_1);
      var_10 = 0;
      var_11 = 0;
      var_12 = 0;

      if(isDefined(var_7)) {
        var_10 = var_7["mask"];
        var_11 = var_7["mask2"];
        var_12 = var_7["mask3"];
      }

      init_sentry_traps(var_0, var_1, var_9, var_8, var_10, var_11, var_5, var_2, var_4, var_12);
      return;
    }

    return;
  }
}

function killstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer(var_3)) {
    return;
  }

  var_8 = self;

  if(!isPlayer(var_3)) {
    return;
  }

  if(!isDefined(var_8.owner)) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](var_3.team, var_8.owner)) {
      if(isDefined(var_6.ref_121d9)) {
        var_6 = var_6.ref_121d9;
      }

      var_9 = ref_14583(var_6, var_3);
      var_10 = "MOD_UNKNOWN";
      var_11 = 0;
      var_12 = 0;
      var_13 = 0;

      if(isDefined(var_3.modifiers)) {
        var_11 = var_3.modifiers["mask"];
        var_12 = var_3.modifiers["mask2"];
        var_13 = var_3.modifiers["mask3"];
      }

      init_sentry_traps(undefined, var_3, var_9, var_8, var_11, var_12, var_6, var_4, var_10, var_13);
      return;
    }

    return;
  }
}

function ondeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer()) {
    return;
  }

  self reportchallengeuserevent("death", 0);
}

function onplayerkillassist(var_0) {
  var_1 = self;

  if(!challengesenabledforplayer(var_1)) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isFriendly")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](var_1.team, var_0)) {
      var_2 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
      }

      if(!isDefined(var_2)) {
        var_2 = getDvar("g_gametype");
      }

      var_3 = "";

      if(isDefined(var_1.primaryweaponobj)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName")) {
          var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](var_1.primaryweaponobj.basename);
        }
      }

      var_4 = "";

      if(isDefined(var_1.secondaryweaponobj)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName")) {
          var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](var_1.secondaryweaponobj.basename);
        }
      }

      var_5 = [var_3, var_4];
      var_6 = [0, 0];
      var_7 = 0;
      var_8 = level.carnage_enemydummycleanup;
      var_9 = relic_amped_is_there_valid_new_victim();
      var_10 = "";
      var_11 = "";
      var_12 = "";
      var_13 = "";
      var_14 = "";
      var_15 = -1;
      var_16 = 0;
      var_17 = "no_attachments";
      var_18 = resetstuckthermite(var_1);
      var_1 reportchallengeuserevent("assist", var_6, var_5, var_7, var_8, var_18, var_9, var_17, var_10, var_12, var_11, gettouchinglocaletriggers(var_1, var_0), var_13, var_14, var_15, var_16);
      var_12 = play_sound_from_closest_player(var_0);

      if((var_2 == "br" || var_2 == "brtdm") && (isPlayer(var_0) || var_12 & 32)) {
        var_19 = var_1.primaryweaponobj;

        if(isDefined(var_0.attackerdata)) {
          var_20 = var_0.attackerdata[var_1.guid];

          if(isDefined(var_20)) {
            if(isDefined(var_20.objweapon)) {
              var_19 = var_20.objweapon;

              if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName")) {
                var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](var_19.basename);
              }
            }

            if(isDefined(var_20.ref_11c8d)) {
              var_7 = var_20.ref_11c8d;
            }

            if(isDefined(var_20.ref_11c8e)) {
              var_8 = var_20.ref_11c8e;
              var_8 |= 2097152;
            }
          }
        }

        init_turrets(var_1, var_12, var_3, var_19, var_17, var_7, var_8, undefined, 0);
        return;
      }

      return;
    }

    return;
  }
}

function ref_12047(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_2 = var_0;
  var_3 = undefined;

  switch (var_1) {
    case "earned":
      var_3 = 0;
      break;
    case "carepackage":
      var_3 = 1;
      break;
    case "other":
    default:
      var_3 = 2;
      break;
  }

  var_4 = relic_amped_is_there_valid_new_victim();
  var_5 = resetstuckthermite();
  var_6 = play_stealthy_disguise_vo(self);
  var_7 = play_stealthy_disguise_vo(self, 1);
  self reportchallengeuserevent("killstreak_available", var_2, var_3, var_4, var_5, var_6, var_7);
}

function ref_1204a(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_7 = var_0;
  var_8 = var_1;
  var_9 = var_2;
  var_10 = var_3;
  var_11 = var_4;
  var_12 = var_5;
  var_13 = var_6;

  if(var_7 == "bradley") {
    var_7 = "pac_sentry";
  }

  var_14 = resetstuckthermite();
  var_15 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("killstreak_end", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
}

function ref_12032(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && isDefined(self) && !challengesenabledforplayer(var_2)) {
    return;
  }

  var_4 = var_0;
  var_5 = var_1;
  var_6 = 0;

  if(isDefined(var_2) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    var_7 = scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk");
    var_6 = var_2[[var_7]]("specialty_tactical_recon");
  }

  if(level.getallactivequestsforteam >= 8 && istrue(var_3) && isDefined(var_2) && self.team != var_2.team && istrue(var_6)) {
    ref_12c3f(var_2, "t9_ch_global_destroy_field_upgrade_with_engineer_or_spotter_perk_for_operator_mission", 1);
  }

  if(level.getallactivequestsforteam >= 10 && istrue(var_3) && isDefined(var_2) && self.team != var_2.team) {
    ref_12c3f(var_2, "t9_ch_global_destroy_field_upgrade_for_operator_mission_s4", 1);
  }

  if(level.getallactivequestsforteam >= 9 && istrue(var_3) && isDefined(var_2) && self.team != var_2.team) {
    ref_12c3f(var_2, "t9_ch_global_field_upgrade_destructions_s3", 1);
    ref_12c3f(var_2, "t9_ch_global_destroy_field_upgrade_for_operator_mission_s3", 1);
  }

  if(level.getallactivequestsforteam >= 11 && istrue(var_3) && isDefined(var_2) && self.team != var_2.team && istrue(var_6)) {
    ref_12c3f(var_2, "t9_ch_global_destroy_field_upgrade_with_engineer_or_spotter_perk_for_operator_mission_s5", 1);
  }

  if(level.getallactivequestsforteam >= 11 && istrue(var_3) && isDefined(var_2) && self.team != var_2.team) {
    ref_12c3f(var_2, "t9_ch_global_destroy_field_upgrade_for_operator_mission_s5", 1);
  }

  var_8 = resetstuckthermite();
  var_9 = relic_amped_is_there_valid_new_victim();

  if(challengesenabledforplayer()) {
    self reportchallengeuserevent("field_end", var_4, var_5, var_8, var_9);
    return;
  }
}

function ref_12021(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(level.getallactivequestsforteam >= 12) {
    if(isDefined(var_0) && istrue(var_0.isequipment)) {
      ref_12c3f("t9_ch_global_jam_or_wz_emp_field_upgrades_and_scorestreaks_s6", 1);
      return;
    }

    return;
  }
}

function ref_12003(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["mask"];
    var_2 = var_0["mask2"];
  }

  var_3 = relic_amped_is_there_valid_new_victim();
  var_4 = resetstuckthermite();
  self reportchallengeuserevent("capture", var_3, var_1, var_2, var_4);
}

function ref_1201f(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["mask"];
    var_2 = var_0["mask2"];
  }

  var_3 = relic_amped_is_there_valid_new_victim();
  var_4 = resetstuckthermite();
  self reportchallengeuserevent("defuse", var_3, var_1, var_2, var_4);
}

function ref_12062(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0["mask"];
    var_2 = var_0["mask2"];
  }

  var_3 = relic_amped_is_there_valid_new_victim();
  var_4 = resetstuckthermite();
  self reportchallengeuserevent("defuse", var_3, var_1, var_2, var_4);
}

function ref_12096(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = relic_amped_is_there_valid_new_victim();
  var_2 = resetstuckthermite();
  self reportchallengeuserevent("stun", var_0, var_1, var_2);
}

function ref_12092(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = relic_amped_is_there_valid_new_victim();
  var_2 = resetstuckthermite();
  self.watch_for_player_enter_trigger = gettime();
  self.ref_14072 = 1;
  self reportchallengeuserevent("stim", var_0, var_1, var_2);

  if(level.getallactivequestsforteam >= 7) {
    ref_12c3f("t9_ch_global_stim_shot_health_recovery_for_operator_mission", var_0);
  }

  if(level.getallactivequestsforteam >= 9) {
    ref_12c3f("t9_ch_global_stim_shot_health_recovery_for_operator_mission_s3", var_0);
  }

  if(level.getallactivequestsforteam >= 11) {
    ref_12c3f("t9_ch_global_stim_shot_health_recovery_for_operator_mission_s5", var_0);
    return;
  }
}

function ref_1203d(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = play_stealthy_disguise_vo(self);
  var_2 = relic_amped_is_there_valid_new_victim();
  var_3 = resetstuckthermite();
  self reportchallengeuserevent("hack", var_0, var_1, var_2, var_3);
  var_4 = 0;

  if(isDefined(self) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    var_5 = scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk");
    var_4 = self[[var_5]]("specialty_tactical_recon");
  }

  if(level.getallactivequestsforteam >= 10) {
    if(istrue(var_4)) {
      ref_12c3f("t9_ch_global_hack_enemy_field_upgrades_for_operator_mission_s4", 1);
    }
  }

  if(level.getallactivequestsforteam >= 11) {
    if(istrue(var_4)) {
      ref_12c3f("t9_ch_global_hacked_field_upgrade_events_for_operator_missions_s5", 1);
      return;
    }

    return;
  }
}

function ondestroyedbytrophy() {
  if(!isDefined(self.owner)) {
    return;
  }

  if(level.getallactivequestsforteam >= 8) {
    ref_12c3f(self.owner, "t9_ch_global_destroy_explosive_with_trophy_for_operator_mission", 1);
  }

  var_0 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    var_1 = scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk");
    var_0 = self.owner[[var_1]]("specialty_tactical_recon");
  }

  if(level.getallactivequestsforteam >= 9 && var_0 && istrue(self.ishacked)) {
    ref_12c3f(self.owner, "t9_ch_global_interceptions_with_hacked_trophy_s3", 1);
  }

  var_2 = self getlinkedparent();

  if(level.getallactivequestsforteam >= 9 && isDefined(var_2) && var_2 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    ref_12c3f(self.owner, "t9_ch_global_vehicle_mounted_trophy_intercepts_for_operator_mission_s3", 1);
  }

  if(level.getallactivequestsforteam >= 11) {
    ref_12c3f(self.owner, "t9_ch_global_destroy_projectiles_with_trophy_for_operator_mission_s5", 1);
    ref_12c3f(self.owner, "t9_ch_global_hacked_field_upgrade_events_s5", 1);
    return;
  }
}

function gettouchinglocaletriggers(var_0, var_1) {
  var_2 = "";

  if(!isDefined(level.localetriggers)) {
    return var_2;
  }

  var_3 = 0;

  foreach(var_5 in level.localetriggers) {
    if(var_0 istouching(var_5) || isDefined(var_1) && var_1 istouching(var_5)) {
      if(isDefined(var_5.localeid)) {
        if(var_3) {
          var_2 += "|";
        }

        var_2 += var_5.localeid;
        var_3 = 1;
      }
    }
  }

  return var_2;
}

function run_laser_vfx_loop(var_0) {
  if(!isDefined(level.localetriggers)) {
    return -1;
  }

  foreach(var_2 in level.localetriggers) {
    if(var_0 istouching(var_2)) {
      var_3 = isDefined(var_2.localeid) && var_2.localeid > 0;
      var_4 = isDefined(var_0.wasingulag) && var_0.wasingulag == var_2.localeid;

      if(var_3 && !var_4) {
        if(!isDefined(var_0.wasingulag)) {
          var_0.wasingulag = 0;
        }

        var_0.wasingulag = var_2.localeid;
        return var_2.localeid;
      }
    }
  }

  return -1;
}

function ref_1200a(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_2 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("contract_start", gettouchinglocaletriggers(self, undefined), gettouchinglocaletriggers(var_1, undefined), resetstuckthermite(), var_2, var_0);
}

function ref_12009(var_0, var_1, var_2) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(var_1 == level.questinfo.hotfootabsloops) {
    if(!isDefined(self.hotfootreset)) {
      self.hotfootreset = 1;
    } else {
      self.hotfootreset++;
    }

    if(self.hotfootreset == 3) {
      ref_12c3f("t9_ch_global_complete_three_contracts_one_match_s1_wz", 1);
    }

    if(var_0 == "domination") {
      if(level.getallactivequestsforteam >= 10) {
        ref_12c3f("t9_ch_global_objective_capture_for_operator_mission_s4", 1);
      }

      if(level.getallactivequestsforteam >= 11) {
        ref_12c3f("t9_ch_global_objective_capture_for_operator_mission_s5", 1);
      }
    }

    if(level.getallactivequestsforteam >= 11) {
      ref_12c3f("t9_ch_global_clear_2_attackers_or_wz_contract_s5", 1);
    }

    if(level.getallactivequestsforteam >= 12) {
      ref_12c3f("t9_ch_global_finish_match_with_five_objective_kills_or_wz_bounty_s6", 1);
    }
  }

  var_3 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("contract_end", var_0, var_1, isalive(self), var_2, resetstuckthermite(), var_3);
}

function ref_1204b(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(var_1 == "supply_drop") {
    ref_12c3f("t9_ch_global_complete_loadout_drop_for_operator_mission", 1);
  } else if(var_1 == "teamrevive") {
    ref_12c3f("t9_ch_global_teammate_buyback_for_operator_mission", 1);
  } else if(level.getallactivequestsforteam >= 8 && var_1 == "killstreak") {
    ref_12c3f("t9_ch_global_killstreaks_purchased_or_acquired_s2", 1);
  }

  var_2 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("buy_item", var_0, var_1, resetstuckthermite(), var_2);
}

function ref_1205f(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_2 = level.getallactivequestsforteam;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;

  if(var_0 == "weapon") {
    var_3 = 1;

    if(isDefined(var_1)) {
      var_6 = var_1;
    }
  } else if(var_0 == "plunder") {
    var_4 = 1;

    if(isDefined(var_1)) {
      var_8 = var_1;
    }
  } else if(var_2 >= 8 && var_0 == "killstreak") {
    ref_12c3f("t9_ch_global_killstreaks_purchased_or_acquired_s2", 1);
  } else if(var_2 >= 8 && var_0 == "scavengerAmmo") {
    ref_12c3f("t9_ch_global_ammo_pickup_scavenger_s2", 1);
    ref_12c3f("t9_ch_global_ammo_pickup_scavenger_for_operator_mission", 1);
  } else if(var_0 == "equipment") {
    var_5 = 1;

    if(isDefined(var_1)) {
      var_7 = var_1;
    }
  }

  if(var_2 >= 9 && var_0 == "scavengerAmmo") {
    ref_12c3f("t9_ch_global_ammo_pickup_scavenger_for_operator_mission_s3", 1);
  }

  if(var_2 >= 10 && var_0 == "scavengerAmmo") {
    ref_12c3f("t9_ch_global_ammo_pickup_scavenger_for_operator_mission_s4", 1);
  }

  if(var_2 >= 11 && var_0 == "scavengerAmmo") {
    ref_12c3f("t9_ch_global_ammo_pickup_scavenger_for_operator_mission_s5", 1);
  }

  if(var_2 >= 12 && var_0 == "scavengerAmmo") {
    ref_12c3f("t9_ch_global_ammo_pickup_scavenger_for_operator_mission_s6", 1);
  }

  if(var_2 >= 12 && var_0 == "killstreak") {
    ref_12c3f("t9_ch_global_killstreaks_purchased_or_acquired_for_operator_mission_s6", 1);
  }

  var_9 = relic_amped_is_there_valid_new_victim();
  var_10 = gettouchinglocaletriggers(self, undefined);
  var_11 = getchallengemapid();
  self reportchallengeuserevent("pickup", var_3, var_4, 0, resetstuckthermite(), var_10, var_9, var_5, var_6, var_7, var_8, var_11);
}

function ref_12060(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "gold_war") {
    return;
  }

  var_1 = var_0 * 100;

  if(level.getallactivequestsforteam >= 9) {
    ref_12c3f("t9_ch_global_earn_score_for_operator_mission_s3", var_1);
  }

  if(level.getallactivequestsforteam >= 11) {
    ref_12c3f("t9_ch_global_earn_score_or_wz_cash_for_operator_mission_s5", var_1);
    ref_12c3f("t9_ch_global_earn_score_or_wz_cash_s5", var_1);
    ref_12c3f("t9_ch_common_opbundle_01_objective_3", var_1);
  }

  if(level.getallactivequestsforteam >= 12) {
    ref_12c3f("t9_ch_global_earn_score_or_wz_cash_for_operator_mission_s6", var_1);
    ref_12c3f("t9_ch_common_opbundle_05_objective_3", var_1);

    if(!isDefined(self.get_tv_station_infil_rider_start_targetname)) {
      self.get_tv_station_infil_rider_start_targetname = 0;
    }

    self.get_tv_station_infil_rider_start_targetname += var_1;

    while(self.get_tv_station_infil_rider_start_targetname >= 15000) {
      ref_12c3f("t9_ch_common_opbundle_04_objective_4", 1);
      self.get_tv_station_infil_rider_start_targetname -= 15000;
    }

    if(!isDefined(self.get_trap_room_spawnpoints)) {
      if(!isDefined(self.get_turret_target_pos)) {
        self.get_turret_target_pos = 0;
      }

      self.get_turret_target_pos += var_1;

      if(self.get_turret_target_pos >= 25000) {
        ref_12c3f("t9_ch_common_opbundle_06_objective_4", 1);
        self.get_trap_room_spawnpoints = 1;
        return;
      }

      return;
    }

    return;
  }
}

function ref_12002() {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_0 = relic_amped_is_there_valid_new_victim();
  var_1 = gettouchinglocaletriggers(self, undefined);
  var_2 = getchallengemapid();
  self reportchallengeuserevent("pickup", 0, 0, 1, resetstuckthermite(), var_1, var_0, 0, 0, 0, var_2);
}

function ref_120a8(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("use_item", var_0, resetstuckthermite(), var_1);
}

function ref_12098(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(level.getallactivequestsforteam >= 7) {
    ref_12c3f("t9_ch_global_resupply_teammates_for_operator_mission", 1);
  }

  if(level.getallactivequestsforteam >= 10) {
    ref_12c3f("t9_ch_global_support_assist_score_event_s4", 1);
    return;
  }
}

function ref_12004(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("collect_item", var_0, resetstuckthermite(), var_2, var_1);
}

function ref_120a4(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("collect_item", var_0, resetstuckthermite(), var_2, var_1);
}

function ref_12061(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("ping", var_0, resetstuckthermite(), var_1);
}

function ref_12053(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("loadout", var_0, resetstuckthermite(), var_1);
}

function ref_12050(var_0, var_1) {
  var_2 = relic_amped_is_there_valid_new_victim();

  if(var_0 == var_1) {
    if(challengesenabledforplayer(var_0)) {
      var_0 reportchallengeuserevent("revive", 1, 1, resetstuckthermite(var_0), var_2);
      return;
    }

    return;
  }

  if(challengesenabledforplayer(var_0)) {
    var_0 reportchallengeuserevent("revive", 1, 0, resetstuckthermite(var_0), var_2);
  }

  if(challengesenabledforplayer(var_1)) {
    var_1 reportchallengeuserevent("revive", 0, 1, resetstuckthermite(var_0), var_2);
    return;
  }
}

function ref_1203c(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_1 = relic_amped_is_there_valid_new_victim();
  self reportchallengeuserevent("gulag_end_match", var_0, resetstuckthermite(), var_1);

  if(level.getallactivequestsforteam >= 11) {
    var_2 = 1;

    if(var_0 == var_2) {
      ref_12c3f("t9_ch_global_gunfight_or_wz_gulag_wins_s5", 1);
      return;
    }

    return;
  }
}

function ref_1205a(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(var_0 <= 0) {
    return;
  }

  if(var_0 <= 15) {
    ref_12c3f("t9_ch_global_earn_team_top_15_for_operator_mission", 1);
  }

  if(var_0 <= 3) {
    ref_12c3f("t9_ch_global_place_top3_ft_s1", 1);
  }

  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getEnemyTeams")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getEnemyTeams")]](self.team);
  }

  var_2 = 0;

  if(var_1.size != 0) {
    var_2 = var_0 / var_1.size;
  }

  if(var_2 <= 0.25) {
    ref_12c3f("t9_ch_global_top_25_percent_finish_s3", 1);
  }

  if(level.getallactivequestsforteam >= 10) {
    if(isDefined(self.kills) && isDefined(self.assists) && isDefined(self.deaths)) {
      var_3 = self.kills + self.assists;
      var_4 = 0;

      if(var_3 > 0) {
        if(self.deaths > 0) {
          var_4 = var_3 / self.deaths;
        } else {
          var_4 = var_3 / 1;
        }
      }

      if(var_4 >= 2) {
        ref_12c3f("t9_ch_global_finish_match_with_2x_more_ekia_than_deaths_s4", 1);
      }

      if(var_3 > self.deaths) {
        ref_12c3f("t9_ch_global_finish_match_with_more_ekia_than_deaths_for_operator_mission_s4", 1);

        if(level.getallactivequestsforteam >= 11) {
          ref_12c3f("t9_ch_global_finish_match_with_more_ekia_than_deaths_for_operator_mission_s5", 1);
        }

        if(level.getallactivequestsforteam >= 12) {
          ref_12c3f("t9_ch_global_finish_match_with_more_ekia_than_deaths_for_operator_mission_s6", 1);
          ref_12c3f("t9_ch_common_opbundle_05_objective_4", 1);
        }
      }
    }

    if(var_2 <= 0.1) {
      ref_12c3f("t9_ch_global_top_10_percent_finish_s4", 1);
    }

    if(var_2 <= 0.25) {
      ref_12c3f("t9_ch_global_finish_match_in_top_25_percent_for_operator_mission_s4", 1);

      if(level.getallactivequestsforteam >= 12) {
        ref_12c3f("t9_ch_global_finish_match_in_top_25_percent_for_operator_mission_s6", 1);
        ref_12c3f("t9_ch_common_opbundle_04_objective_2", 1);
        ref_12c3f("t9_ch_common_opbundle_07_objective_4", 1);
      }
    }
  }

  if(level.getallactivequestsforteam >= 11) {
    if(var_2 <= 0.5) {
      ref_12c3f("t9_ch_common_opbundle_01_objective_4", 1);
    }

    if(isDefined(self.kills) && isDefined(self.assists) && isDefined(self.deaths)) {
      var_3 = self.kills + self.assists;

      if(var_3 > self.deaths) {
        ref_12c3f("t9_ch_common_opbundle_02_objective_4", 1);
      }
    }
  }

  if(level.getallactivequestsforteam >= 12) {
    if(isDefined(level.disable_super_in_turret.name) && level.disable_super_in_turret.name == "gxp") {
      ref_12c3f("t9_ch_common_season_6_wz_event_challenge_1", 1);

      if(var_0 <= 10) {
        ref_12c3f("t9_ch_common_season_6_wz_event_challenge_2", 1);
      }
    }
  }

  var_5 = getDvar("scr_br_gametype");

  if(var_0 == 1 && var_5 == "dbd" && scripts\cp_mp\utility\game_utility::turretdisabled()) {
    ref_120a4("dbd_atlantis_victory_reward");
  }

  if(var_5 == "vov") {
    if(var_0 == 1) {
      ref_120a4("vov_victory_reward");
    }

    ref_120a4("vov_participation_reward");
  }

  if(scripts\cp_mp\utility\game_utility::tutorialzoneenter() && var_0 == 1) {
    ref_120a4("vr_victory_reward");
  }

  if(var_0 == 1 && (var_5 == "rebirth" || var_5 == "rebirth_reverse" || var_5 == "rebirth_dbd" || var_5 == "rebirth_dbd_reverse")) {
    ref_12004("resu_victory");
  }

  if(var_0 == 1 && var_5 == "zxp" && !ref_125f3()) {
    ref_12004("zxp_win");
  }

  if(var_0 == 1 && (var_5 == "rebirth_dbd" || var_5 == "rebirth_dbd_reverse") && self.kills >= 15) {
    ref_12004("dbd_w_15");
    return;
  }
}

function ref_1208f() {
  if(!challengesenabledforplayer()) {
    return;
  }

  reportchallengestatamount("spray", 1);
  var_0 = run_laser_vfx_loop(self);

  if(var_0 != -1) {
    var_1 = resetstuckthermite();
    var_2 = relic_amped_is_there_valid_new_victim();
    self reportchallengeuserevent("spray", var_0, var_1, var_2);
    return;
  }
}

function ongesture() {
  if(!challengesenabledforplayer()) {
    return;
  }

  reportchallengestatamount("gesture", 1);
}

function ref_1301e(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_2 = relic_amped_is_there_valid_new_victim();
  var_3 = gettouchinglocaletriggers(self, undefined);
  var_4 = resetstuckthermite();
  var_5 = "mv_event_intel_1";

  switch (var_0) {
    case "mv_event_intel_1":
      self reportchallengeuserevent("aggregate", var_5, var_2, var_4, var_3, var_1, 0, 0, 0, 0);
      break;
    case "mv_event_intel_3":
      self reportchallengeuserevent("aggregate", var_5, var_2, var_4, var_3, 0, var_1, 0, 0, 0);
      break;
    case "mv_event_intel_4":
      self reportchallengeuserevent("aggregate", var_5, var_2, var_4, var_3, 0, 0, var_1, 0, 0);
      break;
    case "mv_event_intel_5":
      self reportchallengeuserevent("aggregate", var_5, var_2, var_4, var_3, 0, 0, 0, var_1, 0);
      break;
    case "mv_event_intel_6":
      self reportchallengeuserevent("aggregate", var_5, var_2, var_4, var_3, 0, 0, 0, 0, var_1);
      break;
    default:
      self reportchallengeuserevent("aggregate", var_0, var_2, var_4, var_3, var_1, 0, 0, 0, 0);
      break;
  }
}

function ref_12000(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  ref_12c3f("t9_ch_global_block_damage_inserted_armor_for_operator_mission_s3", var_0);
}

function ref_12007(var_0, var_1) {
  if(!challengesenabledforplayer()) {
    return;
  }

  switch (weaponclass(var_0)) {
    case "sniper":
      if(level.getallactivequestsforteam >= 10 && var_1 > 0 && var_1 % 3 == 0) {
        ref_12c3f("t9_ch_global_fire_x_consecutive_damaging_shots_with_sniper_rifle_s4", 1);
      }

      if(level.getallactivequestsforteam >= 12 && var_1 > 0 && var_1 % 3 == 0) {
        ref_12c3f("t9_ch_global_fire_x_consecutive_damaging_shots_with_sniper_rifle_for_operator_mission_s6", 1);
      }

      break;
    default:
      break;
  }
}

function ref_12094() {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(level.getallactivequestsforteam >= 9) {
    ref_12c3f("t9_ch_global_kills_scorestreak_or_loadout_drop_weapons_s3", 1);
  }

  if(level.getallactivequestsforteam >= 10) {
    ref_12c3f("t9_ch_global_scorestreak_weapon_or_stopping_power_kill_for_operator_mission_s4", 1);
  }

  if(level.getallactivequestsforteam >= 12) {
    ref_12c3f("t9_ch_global_scorestreak_weapon_or_stopping_power_kill_for_operator_mission_s6", 1);

    if(!isDefined(self.ref_12a8a)) {
      self.ref_12a8a = 0;
    }

    self.ref_12a8a++;

    if(self.ref_12a8a >= 2) {
      ref_12c3f("t9_ch_global_rapid_kills_with_scorestreak_weapon_or_wz_stopping_power_s6", 1);
      return;
    }

    return;
  }
}

function ref_1207c() {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(level.getallactivequestsforteam >= 9) {
    ref_12c3f("t9_ch_global_detected_kill_field_mic_or_recon_drone_for_operator_mission_s3", 1);
  }

  if(level.getallactivequestsforteam >= 11) {
    ref_12c3f("t9_ch_global_detected_kill_field_mic_or_recon_drone_for_operator_mission_s5", 1);
    return;
  }
}

function ref_14583(var_0, var_1) {
  var_2 = undefined;

  switch (var_0.basename) {
    case "lighttank_tur_ks_mp":
    case "tur_gun_lighttank_ks_mp":
    case "bradley_tow_proj_mp":
    case "lighttank_tur_mp":
    case "pac_sentry_turret_mp":
    case "tur_gun_payload_truck_mp":
    case "bradley_tow_proj_ks_mp":
    case "tur_gun_little_bird_left_mp":
    case "tur_gun_little_bird_right_mp":
    case "tur_gun_cargo_truck_mp":
    case "tur_gun_lighttank_mp":
      var_2 = "iav_weapon_mp";
      break;
    case "little_bird_mp":
      var_2 = "little_bird_mp";
      break;
    case "tur_apc_rus_mp":
      var_2 = "tur_apc_rus_mp";
      break;
    default:
      var_2 = undefined;
      break;
  }

  if(!isDefined(var_2)) {
    var_2 = "";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "getEquipmentRefFromWeapon")) {
      var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "getEquipmentRefFromWeapon")]](var_0);
    }

    if(!isDefined(var_2)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](var_0.basename);
      }
    }

    if(var_2 == "equip_throwing_knife_fire" || var_2 == "equip_throwing_knife_electric" || var_2 == "equip_throwing_knife_drill") {
      var_2 = "equip_throwing_knife";
    }
  }

  var_3 = "";

  if(isDefined(var_1.secondaryweaponobj) && isDefined(var_1.primaryweaponobj)) {
    if(var_0 == var_1.primaryweaponobj) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName")) {
        var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](var_1.secondaryweaponobj.basename);
      }
    } else if(var_0 == var_1.secondaryweaponobj) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName")) {
        var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](var_1.primaryweaponobj.basename);
      }
    }
  }

  var_4 = [var_2, var_3];
  return var_4;
}

function ref_12c3f(var_0, var_1) {
  if(!isPlayer(self) || isai(self)) {
    return;
  }

  if(level.play_intel_collect_vo) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "canSendT9UserEvent")) {
      var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "canSendT9UserEvent")]](var_0);

      if(!var_2) {
        return;
      }
    }
  }

  self reportchallengeuserevent("t9_challenge", var_0, var_1);
}

function ref_13276() {
  if(isDefined(level.ref_139e2)) {
    return;
  }

  var_0 = [];
  GscBinSkip0(0x2e, "iw8_pi_t9burst_mp", "t9_ch_pistol_burst_t9_");
}

function routers_picked_up(var_0) {
  ref_13276();
  var_1 = level.ref_139e2[var_0];

  if(isDefined(var_1)) {
    var_2 = var_0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getWeaponRootName")) {
      var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getWeaponRootName")]](var_0);
    }

    if(!scripts\cp_mp\utility\weapon_utility::vehicle_clearpreventplayercollisiondamagefortimeafterexit(var_2)) {
      var_1 = undefined;
    }
  }

  return var_1;
}

function init_turrets(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!challengesenabledforplayer()) {
    return;
  }

  var_8 = level.getallactivequestsforteam;
  var_9 = 1;
  var_10 = 0;

  if(var_7) {
    if(isDefined(self.killcountthislife)) {
      var_9 = self.killcountthislife + 1;
    }

    if(self.recentkillcount > 1 && !istrue(self.ref_11e04)) {
      self.ref_11e04 = 1;
      var_10 = 1;
    }
  }

  var_11 = "";
  var_12 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "getEquipmentTableInfo")) {
    var_13 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "getEquipmentTableInfo")]](var_1);

    if(isDefined(var_13)) {
      var_12 = var_13.defaultslot == "primary";
    } else if(var_1 != "iav_weapon_mp") {
      var_11 = weaponclass(var_1);
    }
  } else if(var_1 != "iav_weapon_mp") {
    var_11 = weaponclass(var_1);
  }

  var_14 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    var_14 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](var_2.basename);
  }

  var_15 = "";

  if(istrue(var_14)) {
    var_15 = getkillstreaknamefromweapon(var_2);
  }

  var_16 = 0;
  var_17 = 0;
  var_18 = 0;
  var_19 = 0;
  var_20 = 0;
  var_21 = 0;

  if(isDefined(var_6) && isDefined(var_6.equipmentref)) {
    if(var_6.equipmentref == "equip_c4") {
      var_16 = 1;
    }

    if(var_6.equipmentref == "equip_molotov") {
      var_17 = 1;
    }

    if(var_6.equipmentref == "equip_at_mine") {
      var_18 = 1;
    }

    if(var_6.equipmentref == "equip_semtex") {
      var_19 = 1;
    }

    if(var_6.equipmentref == "equip_frag") {
      var_20 = 1;
    }

    if(var_6.equipmentref == "equip_throwing_knife") {
      var_21 = 1;
    }
  }

  var_22 = scripts\cp_mp\utility\player_utility::isinvehicle();
  var_23 = undefined;
  var_24 = 0;

  if(istrue(var_22)) {
    var_23 = scripts\cp_mp\utility\player_utility::getvehicle();

    if(var_23 scripts\cp_mp\vehicles\vehicle::vehiclecanfly()) {
      var_24 |= 4;
    } else {
      var_24 |= 2;
    }
  }

  var_25 = 0;
  var_26 = 0;
  var_27 = 0;
  var_28 = 0;
  var_29 = 0;
  var_30 = 0;
  var_31 = 0;
  var_32 = 0;
  var_33 = 0;
  var_34 = 0;
  var_35 = 0;
  var_36 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    var_37 = scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk");
    var_25 = [[var_37]]("specialty_restock");
    var_26 = [[var_37]]("specialty_recharge_equipment");
    var_27 = [[var_37]]("specialty_tac_resist");
    var_28 = [[var_37]]("specialty_stun_resistance");
    var_29 = [[var_37]]("specialty_coldblooded");
    var_30 = [[var_37]]("specialty_surveillance");
    var_31 = [[var_37]]("specialty_tracker");
    var_32 = [[var_37]]("specialty_ghost");
    var_33 = [[var_37]]("specialty_tactical_recon");
    var_34 = [[var_37]]("specialty_eod");
    var_35 = [[var_37]]("specialty_hustle");
    var_36 = [[var_37]]("specialty_gung_ho");
  }

  var_38 = routers_picked_up(var_1);
  var_39 = isDefined(var_38) && turn_on_have_target_hud(var_1);

  if(!(var_0 & 1)) {
    if(var_7) {
      if(var_39) {
        if(var_0 & 8) {
          ref_12c3f(var_38 + "destroy_vehicle_ground", 1);
        }

        if(var_0 & 4) {
          ref_12c3f(var_38 + "destroy_vehicle_air", 1);
        }

        if(var_0 & 98 && var_1 != "iw8_sn_t9crossbow_mp") {
          ref_12c3f(var_38 + "destroy_any", 1);
        }

        if(var_0 & 32 && var_11 == "rocketlauncher" && var_1 != "iw8_sn_t9crossbow_mp") {
          if(!isDefined(self.ref_12d7b)) {
            self.ref_12d7b = 0;
          }

          self.ref_12d7b += 1;

          if(self.ref_12d7b == 3) {
            ref_12c3f(var_38 + "destroy_3_vehicles_in_one_game", 1);
          }
        }

        if((var_0 & 4 || var_0 & 2) && var_11 == "rocketlauncher") {
          if(var_8 >= 8) {
            ref_12c3f("t9_ch_global_destroy_aircraft_with_launchers_for_operator_mission", 1);
          }

          if(var_8 >= 11) {
            ref_12c3f("t9_ch_global_destroy_aircraft_with_launchers_for_operator_mission_s5", 1);
          }
        }
      }

      if(var_0 & 32) {
        ref_12c3f("t9_ch_global_destroy_vehicle_for_operator_unlock", 1);
        ref_12c3f("t9_ch_global_destroy_vehicle_for_operator_mission", 1);
        ref_12c3f("t9_ch_global_destroy_vehicle_for_operator_mission_op2", 1);
      }

      if(var_8 >= 7) {
        if(var_0 & 8 && istrue(var_16)) {
          ref_12c3f("t9_ch_global_satchel_charge_ground_vehicle_destructions_s1", 1);
        }

        if(var_0 & 6) {
          ref_12c3f("t9_ch_global_destroy_aircraft_s1", 1);
        }
      }

      if(var_8 >= 8) {
        if(var_0 & 8) {
          ref_12c3f("t9_ch_global_ground_vehicle_destructions_s2", 1);
          ref_12c3f("t9_ch_global_ground_vehicle_destructions_for_operator_mission", 1);

          if(istrue(var_18)) {
            ref_12c3f("t9_ch_global_land_mine_ground_vehicle_destructions_s2", 1);
          }
        }
      }

      if(var_8 >= 9) {
        var_40 = isDefined(var_5) && (var_5 & 65536 || var_5 & 4096);
        var_41 = var_15 == "cruise_predator" || var_15 == "pac_sentry" || var_15 == "bradley" || var_15 == "chopper_gunner" || var_15 == "juggernaut";

        if((var_40 || var_41) && var_0 & 32) {
          ref_12c3f("t9_ch_global_vehicle_destruction_in_vehicle_s3", 1);
        }

        if(var_0 & 32) {
          ref_12c3f("t9_ch_global_destroy_vehicle_for_operator_mission_s3", 1);
        }
      }

      if(var_8 >= 10) {
        if(var_0 & 34) {
          ref_12c3f("t9_ch_global_destroy_vehicle_or_scorestreak_for_operator_mission_s4", 1);
          ref_12c3f("t9_ch_global_destroy_vehicle_or_scorestreak_s4", 1);
        }
      }

      if(var_8 >= 11) {
        if(var_0 & 34) {
          ref_12c3f("t9_ch_global_destroy_vehicle_or_scorestreak_for_operator_mission_s5", 1);
        }
      }
    }

    return;
  }

  if(var_4 & 8 && isDefined(var_2) && isDefined(var_2.attachments) && var_7) {
    var_42 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
      var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase");
    }

    foreach(var_44 in var_2.attachments) {
      var_45 = "";

      if(isDefined(var_42)) {
        var_45 = [[var_42]](var_44);
      }

      var_46 = tablelookup("mp/attachmenttable.csv", 5, var_45, 2);

      if(isDefined(var_46) && var_46 == "optic") {
        var_47 = tablelookup("mp/attachmenttable.csv", 4, var_44, 11);

        if(isDefined(level.ref_139e1[var_47])) {
          ref_12c3f(level.ref_139e1[var_47], 1);
        }

        break;
      }
    }
  }

  if(var_39) {
    ref_12c3f(var_38 + "ekia", 1);

    if(var_7) {
      ref_12c3f(var_38 + "kills", 1);

      if(var_9 % 2 == 0) {
        ref_12c3f(var_38 + "killstreak_3", 1);
      }

      if(var_9 % 5 == 0) {
        ref_12c3f(var_38 + "killstreak_5", 1);
      }

      if(isDefined(self.ref_12a86) && isDefined(self.ref_12a86[var_2.basename]) && self.ref_12a86[var_2.basename] == 2) {
        ref_12c3f(var_38 + "multikill_2", 1);
      }

      if(var_4 & 268435456) {
        ref_12c3f(var_38 + "kill_enemy_while_holding_breath", 1);
      }

      if(var_4 & 4096) {
        ref_12c3f(var_38 + "kill_enemy_when_injured", 1);
      }

      if(var_4 & 256) {
        ref_12c3f(var_38 + "kill_enemy_while_sliding", 1);
      }

      if(var_5 & 1048576) {
        if(var_1 == "iw8_sn_t9crossbow_mp" && !(var_5 & 1073741824)) {
          ref_12c3f(var_38 + "kill_enemy_taking_cover_from_you", 1);
        } else {
          ref_12c3f(var_38 + "kill_smoked_blinded_stunned", 1);
        }
      }

      if(var_5 & 524288) {
        if(var_1 == "iw8_sn_t9crossbow_mp" && !(var_5 & 1073741824)) {
          ref_12c3f(var_38 + "kill_enemy_taking_cover_from_you", 1);
        } else {
          ref_12c3f(var_38 + "kill_detected_stunned_blinded", 1);
        }
      }

      if(var_4 & 262144) {
        if(var_1 != "iw8_sn_t9crossbow_mp") {
          ref_12c3f(var_38 + "kill_enemy_taking_cover_from_you", 1);
        }
      }

      if(var_4 & 4) {
        ref_12c3f(var_38 + "backstabber_kill", 1);
      }

      if(var_4 & 262144) {
        ref_12c3f(var_38 + "longshot_kill", 1);
      }

      if(var_4 & 1048576) {
        if(var_1 == "iw8_sn_t9crossbow_mp") {
          ref_12c3f(var_38 + "destroy_any", 1);
        } else {
          ref_12c3f(var_38 + "headshots", 1);
        }
      }

      if(var_4 & 1) {
        if(var_1 == "iw8_sn_t9crossbow_mp") {
          ref_12c3f(var_38 + "destroy_3_vehicles_in_one_game", 1);
        } else {
          ref_12c3f(var_38 + "kill_enemy_one_bullet_sniper", 1);
        }
      }

      if(var_4 & 524288) {
        ref_12c3f(var_38 + "point_blank_kill", 1);
      }
    }
  }

  if(var_7 && var_5 & 256 && isDefined(self.weaponlist)) {
    foreach(var_50 in self.weaponlist) {
      var_51 = "";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName")) {
        var_51 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](var_50.basename);
      }

      var_52 = routers_picked_up(var_51);

      if(isDefined(var_52) && turn_on_have_target_hud(var_51)) {
        ref_12c3f(var_52 + "finishing_move_kill", 1);
      }
    }
  }

  if(var_7) {
    if(var_11 == "rocketlauncher") {
      ref_12c3f("t9_ch_global_kill_with_launcher_for_operator_mission", 1);
    }

    if(var_11 == "spread") {
      if(!isDefined(self.intel_guys)) {
        self.intel_guys = 1;
      } else {
        self.intel_guys++;
      }

      if(turn_on_have_target_hud("iw8_sh_t9fullauto_mp") && self.intel_guys == 3 && !istrue(self.shouldzombiespawntags)) {
        ref_12c3f("t9_ch_global_shotgun_killstreak_3_for_weapon_unlock", 1);
        self.shouldzombiespawntags = 1;
      }
    }

    if(turn_on_have_target_hud("iw8_ar_t9fasthandling_mp") && var_11 == "rifle" && var_9 == 3 && !istrue(self.shouldreflect)) {
      ref_12c3f("t9_ch_global_assault_killstreak_3_for_weapon_unlock", 1);
      self.shouldreflect = 1;
    }

    if(turn_on_have_target_hud("iw8_sm_t9fastfire_mp") && var_11 == "smg" && isDefined(self.ref_12a89) && self.ref_12a89 == 2 && !istrue(self.shouldrespawn)) {
      ref_12c3f("t9_ch_global_smg_multikill_2_for_weapon_unlock", 1);
      self.shouldrespawn = 1;
    }

    if(var_11 == "sniper" && var_4 & 1) {
      ref_12c3f("t9_ch_global_kill_enemy_one_bullet_sniper_for_operator_mission", 1);
    }

    if(var_11 == "throwingknife" || istrue(var_21)) {
      ref_12c3f("t9_ch_global_hatchet_kill_for_operator_mission", 1);
    }

    if(var_1 == "iw8_me_t9loadout_mp") {
      ref_12c3f("t9_ch_global_knife_loadout_kill_for_operator_mission", 1);
      ref_12c3f("t9_ch_global_knife_loadout_kill_for_operator_mission_op2", 1);
    }

    if(var_5 & 1073741824) {
      if(isDefined(self.ref_12a86) && isDefined(self.ref_12a86[var_2.basename]) && self.ref_12a86[var_2.basename] == 2 && !istrue(self.should_enter_combat_after_checking_smoke_grenade)) {
        if(turn_on_have_target_hud("iw8_me_t9sledgehammer_mp")) {
          ref_12c3f("t9_ch_global_knife_loadout_multikill_2_for_weapon_unlock", 1);
          self.should_enter_combat_after_checking_smoke_grenade = 1;
        }
      }
    }

    if(var_9 % 5 == 0) {
      ref_12c3f("t9_ch_global_killstreak_5_for_operator_unlock", 1);
      ref_12c3f("t9_ch_global_killstreak_5_for_operator_mission", 1);
      ref_12c3f("t9_ch_global_killstreak_5_for_operator_mission_op2", 1);
    }

    if(var_10) {
      ref_12c3f("t9_ch_global_multikill_2_for_operator_mission", 1);
    }

    if(istrue(var_14)) {
      ref_12c3f("t9_ch_global_kill_with_scorestreak_for_operator_unlock", 1);
      ref_12c3f("t9_ch_global_kill_with_scorestreak_for_operator_mission", 1);
    }

    if(istrue(var_12) && (istrue(var_25) || istrue(var_26))) {
      ref_12c3f("t9_ch_global_lethal_kill_with_quartermaster_or_restock_perk_for_operator_mission", 1);
    }

    if(var_5 & 524288) {
      ref_12c3f("t9_ch_global_kill_detected_enemies_for_operator_unlock", 1);
    }

    if(var_5 & 256) {
      ref_12c3f("t9_ch_global_finishing_move_kill_for_operator_unlock", 1);
      ref_12c3f("t9_ch_global_finishing_move_kill_for_operator_mission", 1);

      if(!istrue(self.show_balloon_deploy_hint) && var_5 & 1073741824) {
        if(!isDefined(self.ref_1440a)) {
          self.ref_1440a = 1;
        } else {
          self.ref_1440a++;
        }

        if(self.ref_1440a == 2) {
          if(turn_on_have_target_hud("iw8_me_t9wakizashi_mp")) {
            ref_12c3f("t9_ch_global_knife_loadout_finishing_move_kill_2_for_weapon_unlock", 1);
            self.show_balloon_deploy_hint = 1;
            self.ref_1440a = undefined;
          }
        }
      }
    }

    if(istrue(self.gulag)) {
      ref_12c3f("t9_ch_global_win_one_v_one_as_prisoner_for_operator_mission", 1);
      ref_12c3f("t9_ch_global_win_one_v_one_as_prisoner_for_operator_mission_op2", 1);
    }

    if(var_4 & 512 || var_4 & 1024) {
      ref_12c3f("t9_ch_global_kill_enemy_while_crouched_or_prone_for_operator_mission", 1);
    }

    if(var_4 & 1048576) {
      ref_12c3f("t9_ch_global_headshots_for_operator_mission", 1);
    }

    if(var_4 & 524288) {
      ref_12c3f("t9_ch_global_point_blank_kill_for_operator_mission", 1);
    }

    if(var_4 & 262144) {
      ref_12c3f("t9_ch_global_longshot_kill_for_operator_mission", 1);
    }

    if(var_4 & 4096) {
      ref_12c3f("t9_ch_global_kill_enemy_when_injured_for_operator_mission", 1);
    }

    if(var_4 & 2097152) {
      ref_12c3f("t9_ch_global_kill_enemy_who_killed_teammate_for_operator_mission", 1);
    }

    if(istrue(var_16)) {
      ref_12c3f("t9_ch_global_satchel_charge_kill_for_operator_mission", 1);
    }

    if(istrue(var_17)) {
      ref_12c3f("t9_ch_global_molotov_kill_for_operator_mission", 1);
    }
  }

  if(var_8 >= 8) {
    if(var_7) {
      if(istrue(var_17)) {
        ref_12c3f("t9_ch_global_molotov_kill_for_operator_mission", 1);
      }

      if(var_1 == "iw8_me_t9loadout_mp") {
        ref_12c3f("t9_ch_global_knife_loadout_kill_for_operator_mission_op3", 1);
      }

      if(istrue(var_14)) {
        ref_12c3f("t9_ch_global_kill_with_scorestreak_for_operator_mission_op2", 1);

        if(isDefined(var_15) && (var_15 == "precision_airstrike" || var_15 == "toma_strike")) {
          ref_12c3f("t9_ch_global_kill_with_scorestreak_strike_for_operator_mission", 1);
        }
      }

      if(var_5 & 8388608) {
        ref_12c3f("t9_ch_global_kill_blinded_for_operator_mission", 1);
      }

      if(isDefined(self.waitillcanspawnclient) && gettime() < self.waitillcanspawnclient + 20000) {
        ref_12c3f("t9_ch_global_kill_enemy_after_skydiving_for_operator_mission", 1);
      }

      if(var_4 & 524288) {
        ref_12c3f("t9_ch_global_point_blank_kill_for_operator_mission_op2", 1);
      }

      if(istrue(var_16)) {
        ref_12c3f("t9_ch_global_satchel_charge_kill_for_operator_mission_op2", 1);
      }

      if(istrue(var_19) || var_1 == "equip_semtex") {
        ref_12c3f("t9_ch_global_semtex_kill_for_operator_mission", 1);
      }

      if(var_11 == "rifle" && var_4 & 1048576) {
        ref_12c3f("t9_ch_global_headshots_assault_for_operator_mission", 1);
      }

      if(isDefined(self.plantedsuperequip)) {
        foreach(var_55 in self.plantedsuperequip) {
          if(isDefined(var_55.origin) && distancesquared(var_55.origin, self.origin) < 640000) {
            ref_12c3f("t9_ch_global_kill_near_non_lethal_field_upgrade_for_operator_mission", 1);
            break;
          }
        }
      }

      if(var_5 & 536870912) {
        ref_12c3f("t9_ch_global_nightingale_kills_for_operator_mission", 1);
      }

      if(var_5 & 4194304) {
        ref_12c3f("t9_ch_global_uav_kill_for_operator_mission", 1);
        ref_12c3f("t9_ch_global_uav_kill_for_operator_mission_op2", 1);
      }

      if(var_11 == "throwingknife" || istrue(var_21)) {
        ref_12c3f("t9_ch_global_hatchet_kill_for_operator_mission_op2", 1);
      }

      if(var_4 & 262144) {
        ref_12c3f("t9_ch_global_longshot_kill_for_operator_mission_op2", 1);
      }

      if(var_5 & 512) {
        ref_12c3f("t9_ch_global_smoke_grenade_kill_for_operator_mission", 1);
      }

      if(var_9 == 3) {
        ref_12c3f("t9_ch_global_killstreak_3_for_operator_mission", 1);
      }

      if(istrue(var_20)) {
        ref_12c3f("t9_ch_global_frag_grenade_kill_for_operator_mission", 1);
      }

      if(self.recentkillcount == 2) {
        ref_12c3f("t9_ch_global_multikill_2_for_operator_mission_op2", 1);
      }

      if(var_5 & 256) {
        ref_12c3f("t9_ch_global_finishing_move_kill_for_operator_mission_op2", 1);
      }
    }

    if(var_4 & 16384) {
      ref_12c3f("t9_ch_global_ekia_with_picked_up_weapon_for_operator_mission", 1);
    }

    if(var_11 == "pistol") {
      ref_12c3f("t9_ch_global_ekia_pistol_for_operator_mission", 1);
      ref_12c3f("t9_ch_global_ekia_pistol_for_operator_mission_op2", 1);
    }

    if(var_4 & 131072) {
      ref_12c3f("t9_ch_global_ekia_secondary_for_operator_mission", 1);
    }

    if(isDefined(self) && isDefined(self.modifiers) && istrue(self.modifiers["victimstunnedkill"])) {
      ref_12c3f("t9_ch_global_concussion_grenade_kill_for_operator_mission", 1);
    }

    var_57 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getWeaponMenuCategory")) {
      var_57 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getWeaponMenuCategory");
    }

    if(isDefined(var_57) && [[var_57]](var_2.basename) == "weapon_tactical") {
      ref_12c3f("t9_ch_global_ekia_tactical_rifle_for_operator_mission", 1);
      ref_12c3f("t9_ch_global_ekia_tactical_rifle_for_operator_mission_op2", 1);
    }

    if(istrue(var_34)) {
      ref_12c3f("t9_ch_global_ekia_with_flak_jacket_perk_for_operator_mission", 1);
    }

    if(var_11 == "smg") {
      ref_12c3f("t9_ch_global_ekia_smg_for_operator_mission", 1);
    }

    if(var_24 & 2) {
      ref_12c3f("t9_ch_global_ekia_while_in_ground_vehicle_for_operator_mission", 1);
    }

    if(istrue(var_30)) {
      ref_12c3f("t9_ch_global_ekia_paranoia_or_high_alert_for_operator_mission_op2", 1);
    }

    if(var_5 & 2048) {
      ref_12c3f("t9_ch_global_ekia_downed_for_operator_mission_op2", 1);
    }

    if(var_11 == "spread") {
      ref_12c3f("t9_ch_global_ekia_shotgun_for_operator_mission_op2", 1);
    }

    if(istrue(var_31)) {
      ref_12c3f("t9_ch_global_ekia_tracker_for_operator_mission_op2", 1);
    }

    if(var_11 == "sniper") {
      ref_12c3f("t9_ch_global_ekia_sniper_for_operator_mission", 1);
    }

    var_58 = self stopplayermusicstate();

    if(var_58 <= 35 && !issubstr(var_3, "default_sniper_scope")) {
      ref_12c3f("t9_ch_global_ekia_2x_or_greater_magnified_scope_attachment_for_operator_mission", 1);
    }

    if(istrue(var_32) && var_5 & 1) {
      ref_12c3f("t9_ch_global_ekia_under_enemy_detection_with_ghost_perk_for_operator_mission_op2", 1);
    }

    var_42 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
      var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase");
    }

    foreach(var_44 in var_2.attachments) {
      var_45 = "";

      if(isDefined(var_42)) {
        var_45 = [[var_42]](var_44);
      }

      if(isstartstr(var_45, "thermal")) {
        ref_12c3f("t9_ch_global_ekia_thermal_scope_for_operator_mission", 1);
        break;
      }
    }

    if(var_11 == "mg") {
      ref_12c3f("t9_ch_global_ekia_lmg_for_operator_mission", 1);
    }

    var_61 = strtok(var_3, "|").size;

    if(var_61 >= 5) {
      ref_12c3f("t9_ch_global_ekia_5_or_more_attachments_for_operator_mission", 1);
    }

    if(var_24 & 4) {
      ref_12c3f("t9_ch_global_ekia_while_in_aerial_vehicle_for_operator_mission", 1);
    }
  }

  if(var_11 == "sniper") {
    ref_12c3f("t9_ch_global_ekia_sniper_for_operator_unlock", 1);
  }

  if(var_11 == "spread") {
    ref_12c3f("t9_ch_global_ekia_shotgun_for_operator_mission", 1);
  }

  if(var_11 == "rifle") {
    ref_12c3f("t9_ch_global_ekia_assault_for_operator_mission", 1);
  }

  if(var_5 & 131072) {
    ref_12c3f("t9_ch_global_ekia_with_silenced_weapons_for_operator_mission", 1);
  }

  if(var_5 & 16777216) {
    ref_12c3f("t9_ch_global_ekia_enemies_gas_mine_or_gas_grenade_for_operator_mission", 1);
  }

  if(var_5 & 8388608) {
    ref_12c3f("t9_ch_global_ekia_blinded_for_operator_mission", 1);
  }

  if(var_5 & 4096) {
    ref_12c3f("t9_ch_global_ekia_while_in_vehicle_for_operator_mission", 1);
  }

  if(var_5 & 2048) {
    ref_12c3f("t9_ch_global_ekia_downed_for_operator_mission", 1);
  }

  if(istrue(var_27) || istrue(var_28)) {
    ref_12c3f("t9_ch_global_ekia_with_tac_mask_or_battle_hardened_perk_for_operator_mission", 1);
  }

  if(istrue(var_29)) {
    ref_12c3f("t9_ch_global_ekia_cold_blooded_for_operator_mission", 1);
  }

  if(istrue(var_30)) {
    ref_12c3f("t9_ch_global_ekia_paranoia_or_high_alert_for_operator_mission", 1);
  }

  if(istrue(var_31)) {
    ref_12c3f("t9_ch_global_ekia_tracker_for_operator_mission", 1);
  }

  if(istrue(var_32) && var_5 & 1) {
    ref_12c3f("t9_ch_global_ekia_under_enemy_detection_with_ghost_perk_for_operator_mission", 1);
  }

  if(var_8 >= 8) {
    if(var_7) {
      if(istrue(var_17)) {
        ref_12c3f("t9_ch_global_molotov_kill_for_operator_mission_op2", 1);
      }
    }

    if(var_5 & 1073741824) {
      if(!isDefined(self.ref_11bc2)) {
        self.ref_11bc2 = 1;
      } else {
        self.ref_11bc2++;
      }

      if(turn_on_have_target_hud("iw8_me_t9etool_mp") && self.ref_11bc2 == 3 && !istrue(self.shouldrecorddamagestats)) {
        ref_12c3f("t9_ch_global_knife_loadout_killstreak_3_for_weapon_unlock", 1);
        self.shouldrecorddamagestats = 1;
      }
    }

    if(turn_on_have_target_hud("iw8_me_t9machete_mp") && var_4 & 4 && !istrue(self.shouldspawndropscommon)) {
      ref_12c3f("t9_ch_global_backstabber_kill_for_weapon_unlock", 1);
      self.shouldspawndropscommon = 1;
    }

    if(turn_on_have_target_hud("iw8_sn_t9crossbow_mp") && var_4 & 1 && isDefined(var_3) && (var_3 == "" || var_3 == "default_sniper_scope") && !istrue(self.shouldplayerovertimedialog)) {
      if(!isDefined(self.ref_1202c)) {
        self.ref_1202c = 1;
      } else {
        self.ref_1202c++;
      }

      if(self.ref_1202c >= 3) {
        ref_12c3f("t9_ch_global_kill_enemy_one_bullet_no_attachments_3_for_weapon_unlock", 1);
        self.shouldplayerovertimedialog = 1;
      }
    }

    if(turn_on_have_target_hud("iw8_sn_t9cannon_mp") && var_11 == "sniper" && var_4 & 262144 && !istrue(self.shouldspawnloot)) {
      if(!isDefined(self.ref_13dbf)) {
        self.ref_13dbf = 0;
      }

      self.ref_13dbf++;

      if(self.ref_13dbf >= 2) {
        ref_12c3f("t9_ch_global_longshot_kill_sniper_2_for_weapon_unlock", 1);
        self.shouldspawnloot = 1;
      }
    }
  }

  if(var_8 >= 9) {
    if(var_7) {
      if(turn_on_have_target_hud("iw8_me_t9ballisticknife_mp") && !isDefined(self.chopper_watch_death)) {
        if(var_4 & 1) {
          self.ref_1202b = 1;
        }

        if(istrue(self.ref_1202b) && isDefined(self.ref_11bc2) && self.ref_11bc2 > 0) {
          self.chopper_watch_death = 1;
          ref_12c3f("t9_ch_global_kill_enemy_one_bullet_and_melee_weapon_kill_1life_for_weapon_unlock_s3", 1);
        }
      }

      if(var_11 == "smg" && turn_on_have_target_hud("iw8_sm_t9accurate_mp") && !isDefined(self.watchspawninput)) {
        if(!isDefined(self.ref_1341b)) {
          self.ref_1341b = 1;
        } else {
          self.ref_1341b++;
        }

        if(self.ref_1341b == 3) {
          self.watchspawninput = 1;
          ref_12c3f("t9_ch_global_smg_killstreak_3_for_weapon_unlock_s3", 1);
        }
      }

      if(var_11 == "rifle" && turn_on_have_target_hud("iw8_ar_t9slowhandling_mp")) {
        if(!isDefined(self.pendingtimer) && var_4 & 1048576) {
          if(!isDefined(self.cargo_truck_initomnvars)) {
            self.cargo_truck_initomnvars = 1;
          } else {
            self.cargo_truck_initomnvars++;
          }

          if(self.cargo_truck_initomnvars == 2) {
            self.pendingtimer = 1;
            ref_12c3f("t9_ch_global_ar_headsots_2_for_weapon_unlock_s3", 1);
          }
        }
      }

      if(turn_on_have_target_hud("iw8_ar_t9fastburst_mp")) {
        var_57 = undefined;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getWeaponMenuCategory")) {
          var_57 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getWeaponMenuCategory");
        }

        if(!isDefined(self.playerzombiesetradar) && isDefined(var_57) && [[var_57]](var_2.basename) == "weapon_tactical") {
          if(isDefined(self.ref_12a86) && isDefined(self.ref_12a86[var_2.basename]) && self.ref_12a86[var_2.basename] == 2) {
            self.playerzombiesetradar = 1;
            ref_12c3f("t9_ch_global_tr_multikill_2_for_weapon_unlock_s3", 1);
          }
        }
      }

      if(turn_on_have_target_hud("iw8_me_t9bat_mp") && var_5 & 1073741824 && var_5 & 4194304 && !isDefined(self.cinderblock_damage_monitor)) {
        self.cinderblock_damage_monitor = 1;
        ref_12c3f("t9_ch_global_melee_weapon_kill_detected_for_weapon_unlock_s3", 1);
      }
    }

    if(turn_on_have_target_hud("iw8_pi_t9fullauto_mp") && var_11 == "pistol" && !isDefined(self.ref_127d6)) {
      if(!isDefined(self.ref_1237a)) {
        self.ref_1237a = 1;
      } else {
        self.ref_1237a++;
      }

      if(self.ref_1237a == 5) {
        self.ref_127d6 = 1;
        ref_12c3f("t9_ch_global_pistol_ekia_5_for_weapon_unlock_s3", 1);
      }
    }

    if(var_7) {
      if(var_5 & 1073741824) {
        ref_12c3f("t9_ch_global_melee_weapon_kill_for_operator_mission_s3", 1);
      }

      if(isDefined(self.waitillcanspawnclient) && gettime() < self.waitillcanspawnclient + 20000) {
        ref_12c3f("t9_ch_global_kill_enemy_after_skydiving_for_operator_mission_s3", 1);
      }

      if(var_11 == "throwingknife" || istrue(var_21)) {
        ref_12c3f("t9_ch_global_hatchet_kill_for_operator_mission_s3", 1);
      }

      if(isDefined(self) && isDefined(self.modifiers) && istrue(self.modifiers["victimstunnedkill"])) {
        ref_12c3f("t9_ch_global_concussion_grenade_kill_for_operator_mission_s3", 1);
      }

      if(self.intel_guys % 3 == 0) {
        ref_12c3f("t9_ch_global_killstreak_shotgun_without_dying_for_operator_mission_s3", 1);
      }

      if(istrue(var_12) && (istrue(var_25) || istrue(var_26))) {
        ref_12c3f("t9_ch_global_lethal_kill_with_quartermaster_or_restock_perk_for_operator_mission_s3", 1);
      }

      if(var_11 == "rocketlauncher") {
        ref_12c3f("t9_ch_global_launcher_kill_or_destruction_for_operator_mission_s3", 1);
      }

      if(var_11 == "rifle" && isDefined(self.ref_12a86) && isDefined(self.ref_12a86[var_2.basename]) && self.ref_12a86[var_2.basename] >= 2) {
        ref_12c3f("t9_ch_global_assault_multikill_for_operator_mission_s3", 1);
      }

      if(istrue(var_19) || var_1 == "equip_semtex") {
        ref_12c3f("t9_ch_global_semtex_kill_for_operator_mission_s3", 1);
      }

      if(var_5 & 4194304) {
        ref_12c3f("t9_ch_global_kill_while_friendly_uav_active_for_operator_mission_s3", 1);
      }

      if(istrue(var_12)) {
        ref_12c3f("t9_ch_global_lethal_kill_for_operator_mission_s3", 1);
      }

      if(var_4 & 4) {
        ref_12c3f("t9_ch_global_finishing_move_kill_for_operator_mission_s3", 1);
      }

      if(istrue(var_14)) {
        ref_12c3f("t9_ch_global_kill_with_scorestreak_for_operator_mission_s3", 1);
      }

      if(var_5 & 8388608) {
        ref_12c3f("t9_ch_global_kill_blinded_for_operator_mission_s3", 1);
      }

      if(var_5 & 512) {
        ref_12c3f("t9_ch_global_smoke_grenade_kill_for_operator_mission_s3", 1);
      }

      if(istrue(var_20)) {
        ref_12c3f("t9_ch_global_frag_grenade_kill_for_operator_mission_s3", 1);
      }

      if(var_5 & 4096) {
        ref_12c3f("t9_ch_global_kill_while_in_vehicle_for_operator_mission_s3", 1);

        if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
          var_62 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self.vehicle, 1);

          if(isDefined(var_62) && var_62 != self) {
            ref_12c3f(var_62, "t9_ch_global_passenger_kill_while_driving_for_operator_mission_s3", 1);
          }
        }
      }

      if(var_5 & 268435456) {
        ref_12c3f("t9_ch_global_kill_without_taking_damage_for_operator_mission_s3", 1);
      }
    }

    if(istrue(var_35) || istrue(var_36)) {
      ref_12c3f("t9_ch_global_ekia_gung_ho_double_time_for_operator_mission_s3", 1);
    }

    if(isDefined(var_2) && isDefined(var_2.attachments)) {
      var_42 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
        var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase");
      }

      foreach(var_44 in var_2.attachments) {
        var_45 = "";

        if(isDefined(var_42)) {
          var_45 = [[var_42]](var_44);
        }

        if(var_11 == "smg" && var_45 == "stockno") {
          ref_12c3f("t9_ch_global_smg_ekia_no_stock_for_operator_mission_s3", 1);
        }

        if(var_11 == "pistol" && issubstr(var_45, "reflex")) {
          ref_12c3f("t9_ch_global_pistol_ekia_led_optic_for_operator_mission_s3", 1);
        }

        if(isstartstr(var_45, "grip")) {
          ref_12c3f("t9_ch_global_grip_kill_for_operator_mission_s3", 1);
        }
      }
    }

    if(istrue(var_34)) {
      ref_12c3f("t9_ch_global_ekia_with_flak_jacket_perk_for_operator_mission_s3", 1);
    }

    if(var_1 == "iw8_sn_t9crossbow_mp" || var_1 == "iw8_la_t9launcher_mp" || var_1 == "special_ballisticknife") {
      ref_12c3f("t9_ch_global_special_weapon_ekia_for_operator_mission_s3", 1);
    }

    if(var_11 == "rifle") {
      ref_12c3f("t9_ch_global_ekia_assault_for_operator_mission_s3", 1);

      if(isDefined(var_2) && isDefined(var_2.attachments)) {
        var_42 = undefined;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
          var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase");
        }

        foreach(var_44 in var_2.attachments) {
          var_45 = "";

          if(isDefined(var_42)) {
            var_45 = [[var_42]](var_44);
          }

          if(isstartstr(var_45, "xmag") || isstartstr(var_45, "smag") || isstartstr(var_45, "drum")) {
            ref_12c3f("t9_ch_global_ar_kill_extended_mag_for_operator_mission_s3", 1);
          }
        }
      }
    }

    if(var_11 == "sniper") {
      ref_12c3f("t9_ch_global_ekia_sniper_for_operator_mission_s3", 1);
    }

    var_57 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getWeaponMenuCategory")) {
      var_57 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getWeaponMenuCategory");

      if(isDefined(var_57) && [[var_57]](var_2.basename) == "weapon_tactical") {
        var_58 = self stopplayermusicstate();

        if(var_58 <= 35 && !issubstr(var_3, "default_sniper_scope")) {
          ref_12c3f("t9_ch_global_tr_ekia_2x_scope_for_operator_mission_s3", 1);
        }
      }
    }

    if(istrue(var_31)) {
      ref_12c3f("t9_ch_global_ekia_tracker_for_operator_mission_s3", 1);
    }

    if(var_11 == "mg") {
      ref_12c3f("t9_ch_global_ekia_lmg_for_operator_mission_s3", 1);

      if(isDefined(var_2) && isDefined(var_2.attachments)) {
        var_42 = undefined;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
          var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase");
        }

        foreach(var_44 in var_2.attachments) {
          var_45 = "";

          if(isDefined(var_42)) {
            var_45 = [[var_42]](var_44);
          }

          var_68 = tablelookup("mp/attachmenttable.csv", 5, var_45, 3);

          if(issubstr(var_68, "DRUM")) {
            ref_12c3f("t9_ch_global_smg_ekia_drum_magazine_for_operator_mission_s3", 1);
            break;
          }
        }
      }
    }

    if(var_11 == "spread") {
      if(isDefined(var_2) && isDefined(var_2.attachments) && isDefined(level.ref_132bd)) {
        foreach(var_44 in var_2.attachments) {
          if(isDefined(level.ref_132bd[var_44])) {
            ref_12c3f("t9_ch_global_shotgun_ekia_wire_stock_for_operator_mission_s3", 1);
            break;
          }
        }
      }
    }

    if(var_11 == "pistol") {
      if(var_5 & 2048) {
        ref_12c3f("t9_ch_global_pistol_ekia_downed_for_operator_mission_s3", 1);
      }

      if(var_2 hasattachment("akimbo", 1)) {
        ref_12c3f("t9_ch_global_pistol_dw_ekia_for_operator_mission_s3", 1);
      }

      if(isDefined(var_2) && isDefined(var_2.attachments) && isDefined(level.ref_1237c)) {
        foreach(var_44 in var_2.attachments) {
          if(isDefined(level.ref_1237c[var_44])) {
            ref_12c3f("t9_ch_global_pistol_ekia_led_optic_for_operator_mission_s3", 1);
            break;
          }
        }
      }
    }

    if(istrue(var_29)) {
      ref_12c3f("t9_ch_global_ekia_cold_blooded_for_operator_missions_s3", 1);
    }

    if(var_4 & 16777216) {
      ref_12c3f("t9_ch_global_revenge_kill_for_operator_mission_s3", 1);
    }
  }

  if(var_8 >= 10) {
    if(getdvarint("scr_enable_br_satellite_hunt", 0) == 1) {
      if(var_7 && update_objective_ownerclient(self.origin)) {
        ref_12c3f("t9_ch_global_eliminate_enemy_near_active_satlink_or_crashed_satellite_for_s4_event_wz", 1);
      }
    }

    if(var_7) {
      if(turn_on_have_target_hud("iw8_sm_t9spray_mp") && var_11 == "smg") {
        var_74 = 1500;
        var_75 = self method_87c5();
        var_76 = var_75 < var_74;

        if(!isDefined(self.ref_1283c) && var_76) {
          if(!isDefined(self.ref_1341a)) {
            self.ref_1341a = 1;
          } else {
            self.ref_1341a++;
          }

          if(self.ref_1341a == 3) {
            ref_12c3f("t9_ch_global_smg_kills_after_sprinting_for_weapon_unlock_s4", 1);
            self.ref_1283c = 1;
            self.ref_1341a = undefined;
          }
        }
      }

      if(!isDefined(self.ref_139ca) && turn_on_have_target_hud("iw8_sn_t9accurate_mp") && var_11 == "sniper" && var_4 & 1048576) {
        if(!isDefined(self.ref_1343e)) {
          self.ref_1343e = 1;
        } else {
          self.ref_1343e++;
        }

        if(self.ref_1343e == 2) {
          ref_12c3f("t9_ch_global_sniper_headshots_for_weapon_unlock_s4", 1);
          self.ref_139ca = 1;
          self.ref_1343e = undefined;
        }
      }

      if(turn_on_have_target_hud("iw8_me_t9mace_mp") && !isDefined(self.ref_11a6b) && var_5 & 1073741824 && var_4 & 256) {
        ref_12c3f("t9_ch_global_melee_weapon_kill_while_sliding_for_weapon_unlock_s4", 1);
        self.ref_11a6b = 1;
      }

      if(turn_on_have_target_hud("iw8_sm_t9cqb_mp") && !isDefined(self.ref_12159) && var_11 == "smg") {
        if(isDefined(self.ref_12a86) && isDefined(self.ref_12a86[var_2.basename]) && self.ref_12a86[var_2.basename] == 2) {
          ref_12c3f("t9_ch_global_smg_multikill_for_weapon_unlock_s4", 1);
          self.ref_12159 = 1;
        }
      }
    }

    if(turn_on_have_target_hud("iw8_sm_t9nailgun_mp") && !isDefined(self.ref_11e22) && useserverhud(var_1)) {
      if(!isDefined(self.ref_136d4)) {
        self.ref_136d4 = 1;
      } else {
        self.ref_136d4++;
      }

      if(self.ref_136d4 == 5) {
        ref_12c3f("t9_ch_global_special_ekia_for_weapon_unlock_s4", 1);
        self.ref_136d4 = undefined;
        self.ref_11e22 = 1;
      }
    }

    if(var_7) {
      var_77 = var_4 & 524288;
      var_78 = var_11 == "spread";

      if(var_77 && var_78) {
        ref_12c3f("t9_ch_global_shotgun_point_blank_kill_for_operator_mission_s4", 1);
      }

      if(isDefined(self.watch_for_player_enter_trigger)) {
        var_79 = gettime() - self.watch_for_player_enter_trigger < 10000;

        if(istrue(var_79)) {
          ref_12c3f("t9_ch_global_kill_after_stim_shot_for_operator_mission_s4", 1);
        }
      }

      if(var_4 & 8) {
        ref_12c3f("t9_ch_global_kills_while_ads_for_operator_mission_s4", 1);
      }

      if(var_4 & 1048576) {
        if(!isDefined(self.getanglesfacingorigin)) {
          self.getanglesfacingorigin = 0;
        }

        self.getanglesfacingorigin++;

        if(self.getanglesfacingorigin == 3) {
          ref_12c3f("t9_ch_global_headshots_in_one_game_for_operator_mission_s4", 1);
        }
      }

      var_80 = var_11 == "sniper" || va_cluster_spawnpoint_valid(var_2);
      var_81 = var_4 & 1048576 && var_4 & 262144;

      if(var_80 && var_81) {
        ref_12c3f("t9_ch_global_sniper_or_tactical_longshot_headshots_for_operator_mission_s4", 1);
      }

      if(var_5 & 1048576) {
        ref_12c3f("t9_ch_global_concussion_grenade_kill_for_operator_mission_s4", 1);
      }

      if(istrue(var_12)) {
        if(!isDefined(self.getarenaomnvarbitpackinginfo)) {
          self.getarenaomnvarbitpackinginfo = 0;
        }

        self.getarenaomnvarbitpackinginfo++;

        if(self.getarenaomnvarbitpackinginfo == 3) {
          ref_12c3f("t9_ch_global_lethal_kills_in_one_game_for_operator_mission_s4", 1);
        }
      }

      if(istrue(var_19) || var_1 == "equip_semtex") {
        ref_12c3f("t9_ch_global_semtex_kill_for_operator_mission_s4", 1);
      }

      if(istrue(var_12)) {
        ref_12c3f("t9_ch_global_lethal_kill_for_operator_mission_s4", 1);

        if(var_25) {
          if(!isDefined(self.weapon_xp_iw8_sh_dpapa12)) {
            self.weapon_xp_iw8_sh_dpapa12 = 1;
          } else {
            self.weapon_xp_iw8_sh_dpapa12++;
          }

          if(self.weapon_xp_iw8_sh_dpapa12 == 2) {
            ref_12c3f("t9_ch_global_two_lethal_kills_same_life_with_quartermaster_or_restock_perk_for_operator_mission_s4", 1);
          }
        }
      }

      if(var_4 & 8) {
        ref_12c3f("t9_ch_global_kills_while_ads_for_operator_mission_s4", 1);
      }

      if(!isDefined(self.getanimsforplanefacing)) {
        self.getanimsforplanefacing = var_1;
      } else if(self.getanimsforplanefacing != var_1) {
        ref_12c3f("t9_ch_global_kills_from_different_weapons_without_dying_for_operator_mission_s4", 1);
      }

      var_80 = var_11 == "sniper" || va_cluster_spawnpoint_valid(var_2);
      var_81 = var_4 & 1048576 && var_4 & 262144;

      if(var_80 && var_81) {
        ref_12c3f("t9_ch_global_sniper_or_tactical_longshot_headshots_for_operator_mission_s4", 1);
      }

      if(var_14 && getkillstreaknamefromweapon(var_2) == "precision_airstrike") {
        ref_12c3f("t9_ch_global_kill_with_scorestreak_strike_for_operator_mission_s4", 1);
      }

      if(var_4 & 256) {
        ref_12c3f("t9_ch_global_sliding_kill_for_operator_mission_s4", 1);
      }

      if(var_5 & 1073741824 || var_1 == "iw8_me_t9ballisticknife_mp") {
        ref_12c3f("t9_ch_global_melee_weapon_or_ballistic_knife_kill_for_operator_mission_s4", 1);
      }

      if(!isDefined(self.ref_145a3)) {
        self.ref_145a3 = [];
      }

      self.ref_145a3[var_1] = 1;

      if(self.ref_145a3.size == 6 && !isDefined(self.lightsreset)) {
        self.lightsreset = 1;
        ref_12c3f("t9_ch_global_kill_with_different_weapons_for_operator_mission_s4", 1);
      }

      if(isDefined(self.player_equip_primary) && self.recentkillcount >= 2 && weaponclass(self.player_equip_primary) == "smg" && var_2 == self.player_equip_primary) {
        ref_12c3f("t9_ch_global_smg_multikill_for_operator_mission_s4", 1);
      }

      if(istrue(var_12) && isDefined(self.recentkillcount) && self.recentkillcount >= 2) {
        ref_12c3f("t9_ch_global_lethal_kills_from_same_thrown_in_one_game_for_operator_mission_s4", 1);
      }

      if(var_5 & 262144) {
        ref_12c3f("t9_ch_global_kill_with_penetrated_bullet_for_operator_mission_s4", 1);
      }

      if(var_4 & 524288) {
        ref_12c3f("t9_ch_global_point_blank_kill_for_operator_mission_s4", 1);
      }

      if(var_4 & 8 && isDefined(var_2) && isDefined(var_2.attachments)) {
        var_42 = undefined;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
          var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase");
        }

        foreach(var_44 in var_2.attachments) {
          var_45 = "";

          if(isDefined(var_42)) {
            var_45 = [[var_42]](var_44);
          }

          if(issubstr(var_45, "reflex")) {
            ref_12c3f("t9_ch_global_ads_kill_with_led_optic_for_operator_mission_s4", 1);
            break;
          }
        }
      }

      if(var_14) {
        if(var_15 == "toma_strike") {
          ref_12c3f("t9_ch_global_napalm_strike_or_cluster_strike_kill_for_operator_mission_s4", 1);
        }

        if(var_15 == "toma_strike" || var_15 == "precision_airstrike" || var_15 == "cruise_predator" || var_15 == "chopper_gunner" || var_15 == "fuel_airstrike" || var_15 == "gunship") {
          ref_12c3f("t9_ch_global_aerial_scorestreak_kill_for_operator_mission_s4", 1);
        }
      }

      if(var_4 & 1048576 && va_cluster_spawnpoint_valid(var_2)) {
        ref_12c3f("t9_ch_global_tactical_headshots_for_operator_mission_s4", 1);
      }

      if(var_5 & 16777216) {
        ref_12c3f("t9_ch_global_gas_kill_for_operator_mission_s4", 1);
      }

      if(var_11 == "rocketlauncher") {
        ref_12c3f("t9_ch_global_launcher_kill_or_destruction_for_operator_mission_s4", 1);
      }

      if(var_4 & 524288 && var_11 == "pistol" && isDefined(self.lastkilledplayer)) {
        var_84 = vectorNormalize(self.origin - self.lastkilledplayer.origin);
        var_85 = anglesToForward(self.lastkilledplayer getplayerangles(1));
        var_86 = vectordot(var_84, var_85);

        if(var_86 < 0) {
          ref_12c3f("t9_ch_global_pistol_point_blank_kill_from_behind_for_operator_mission_s4", 1);
        }
      }

      if(self.killcountthislife == 5) {
        ref_12c3f("t9_ch_global_killstreak_5_for_operator_mission_s4", 1);
      }
    }

    if(isDefined(var_2) && var_2.inventorytype == "primary" && !(var_4 & 131072)) {
      ref_12c3f("t9_ch_global_primary_weapon_ekia_operator_mission_s4", 1);
    }

    if(istrue(var_34)) {
      ref_12c3f("t9_ch_global_ekia_with_flak_jacket_perk_for_operator_mission_s4", 1);
    }

    if(isDefined(var_2) && weaponissemiauto(var_2)) {
      ref_12c3f("t9_ch_global_semi_auto_ekia_for_operator_mission_s4", 1);
    }

    var_87 = "pistolgrip03";
    var_88 = isDefined(var_3) && issubstr(var_3, var_87);

    if(var_88) {
      ref_12c3f("t9_ch_global_ekia_with_speed_tape_attachment_for_operator_mission_s4", 1);
    }

    if(var_11 == "mg") {
      ref_12c3f("t9_ch_global_lmg_ekia_for_operator_mission_s4", 1);
    }

    if(isDefined(var_2) && isDefined(var_2.attachments)) {
      var_42 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
        var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase");
      }

      foreach(var_44 in var_2.attachments) {
        var_45 = "";

        if(isDefined(var_42)) {
          var_45 = [[var_42]](var_44);
        }

        if(isstartstr(var_45, "laser")) {
          ref_12c3f("t9_ch_global_ekia_with_laser_body_attachment_for_operator_mission_s4", 1);
          break;
        }
      }
    }

    if(var_4 & 131072) {
      ref_12c3f("t9_ch_global_ekia_secondary_for_operator_mission_s4", 1);
    }

    if(var_11 == "spread") {
      ref_12c3f("t9_ch_global_shotgun_ekia_for_operator_mission_s4", 1);
    }

    if(var_11 == "smg" && var_5 & 131072) {
      ref_12c3f("t9_ch_global_smg_ekia_with_silenced_weapons_for_operator_mission_s4", 1);
    }

    if(turret_struct(var_2)) {
      ref_12c3f("t9_ch_global_assault_ekia_for_operator_mission_s4", 1);
    }

    if(isDefined(var_2) && weaponinventorytype(var_2) == "primary" && var_1 != "iav_weapon_mp" && var_1 != "equip_pop_rocket" && (weaponburstcount(var_1) > 0 || var_1 == "iw8_ar_anovember94_mp")) {
      ref_12c3f("t9_ch_global_burst_fire_ekia_for_operator_mission_s4", 1);
    }
  }

  if(var_8 >= 11) {
    if(var_7) {
      if(turn_on_have_target_hud("iw8_lm_t9fastfire_mp") && !isDefined(self.ref_11bd7) && var_11 == "mg") {
        if(!isDefined(self.zombieloadout)) {
          self.zombieloadout = 1;
          thread watchreloading("MG82_challenge_progressed");
        } else {
          self.zombieloadout++;
        }

        if(self.zombieloadout == 3) {
          ref_12c3f("t9_ch_global_lmg_kill_x_without_reloading_for_weapon_unlock_s5", 1);
          self notify("MG82_challenge_progressed");
          self.ref_11bd7 = 1;
        }
      }

      if(turn_on_have_target_hud("iw8_ar_t9slowfire_mp") && !isDefined(self.force_group_thermites) && turret_struct(var_2) && var_4 & 262144) {
        ref_12c3f("t9_ch_global_ar_longshot_kill_for_weapon_unlock_s5", 1);
        self.force_group_thermites = 1;
      }

      if(turn_on_have_target_hud("iw8_pi_t9pistolshot_mp") && !isDefined(self.ref_11b1a) && var_11 == "pistol" && var_4 & 1048576) {
        ref_12c3f("t9_ch_global_pistol_headshot_kill_for_weapon_unlock_s5", 1);
        self.ref_11b1a = 1;
      }

      if(turn_on_have_target_hud("iw8_me_t9cane_mp") && !isDefined(self.get_actual_grenade_name) && var_5 & 1073741824) {
        var_91 = var_5 & 1048576;
        var_92 = var_5 & 8388608;

        if(var_91 || var_92) {
          ref_12c3f("t9_ch_global_melee_weapon_kill_blinded_stunned_for_weapon_unlock_s5", 1);
          self.get_actual_grenade_name = 1;
        }
      }

      if(turn_on_have_target_hud("iw8_me_t9sai_mp") && !isDefined(self.ref_12e7a) && var_5 & 1073741824 && var_5 & 268435456) {
        ref_12c3f("t9_ch_global_melee_weapon_kill_no_return_fire_for_weapon_unlock_s5", 1);
        self.ref_12e7a = 1;
      }
    }

    if(var_7) {
      if(var_5 & 536870912) {
        ref_12c3f("t9_ch_global_nightingale_kills_for_operator_mission_s5", 1);
      }

      if(istrue(var_17)) {
        ref_12c3f("t9_ch_global_molotov_kill_for_operator_mission_s5", 1);
      }

      if(var_11 == "pistol") {
        if(!isDefined(self.ref_1237b)) {
          self.ref_1237b = 1;
        } else {
          self.ref_1237b++;
        }

        if(self.ref_1237b > 0 && self.ref_1237b % 3 == 0) {
          ref_12c3f("t9_ch_global_pistol_killstreak_5_for_operator_mission_s5", 1);
        }
      }

      if(var_5 & 1073741824) {
        ref_12c3f("t9_ch_global_melee_weapon_kill_for_operator_mission_s5", 1);
      }

      if(istrue(var_12)) {
        ref_12c3f("t9_ch_global_lethal_kill_for_operator_mission_s5", 1);
      }

      if(var_4 & 1048576 && va_cluster_spawnpoint_valid(var_2)) {
        ref_12c3f("t9_ch_global_tactical_headshots_for_operator_mission_s5", 1);
      }

      if(var_11 == "throwingknife" || istrue(var_21)) {
        ref_12c3f("t9_ch_global_hatchet_or_throwing_knife_kill_for_operator_mission_s5", 1);
      }

      if(var_2.inventorytype == "primary" && !(var_4 & 131072)) {
        if(!isDefined(self.vip_questthink_iconposition)) {
          self.vip_questthink_iconposition = 1;
        } else {
          self.vip_questthink_iconposition++;
        }

        if(!isDefined(self.vip_removequestinstance)) {
          self.vip_removequestinstance = 1;
        } else {
          self.vip_removequestinstance++;
        }
      }

      if(var_4 & 131072) {
        if(!isDefined(self.vip_respawnplayer)) {
          self.vip_respawnplayer = 1;
        } else {
          self.vip_respawnplayer++;
        }

        if(!isDefined(self.vipbot_movesup)) {
          self.vipbot_movesup = 1;
        } else {
          self.vipbot_movesup++;
        }
      }

      if(var_12) {
        if(!isDefined(self.vip_playerremoved)) {
          self.vip_playerremoved = 1;
        } else {
          self.vip_playerremoved++;
        }
      }

      if(isDefined(self.vip_questthink_iconposition) && isDefined(self.vip_respawnplayer) && self.vip_questthink_iconposition > 0 && self.vip_respawnplayer > 0) {
        self.vip_questthink_iconposition--;
        self.vip_respawnplayer--;
        ref_12c3f("t9_ch_global_kill_primary_secondary_without_dying_for_operator_mission_s3", 1);
        ref_12c3f("t9_ch_global_kill_primary_secondary_without_dying_for_operator_mission_s5", 1);
      }

      if(isDefined(self.vip_removequestinstance) && isDefined(self.vip_respawnplayer) && isDefined(self.vip_playerremoved) && self.vip_removequestinstance > 0 && self.vipbot_movesup > 0 && self.vip_playerremoved > 0) {
        self.vip_removequestinstance--;
        self.vipbot_movesup--;
        self.vip_playerremoved--;
        ref_12c3f("t9_ch_global_kill_primary_secondary_lethal_without_dying_for_operator_mission_s3", 1);

        if(var_8 >= 12) {
          ref_12c3f("t9_ch_global_kill_primary_secondary_lethal_without_dying_for_operator_mission_s6", 1);
          ref_12c3f("t9_ch_global_primary_secondary_equipment_scorestreak_kill_in_single_game_s6", 1);
        }
      }

      if(var_4 & 524288) {
        ref_12c3f("t9_ch_global_point_blank_kill_for_operator_mission_s5", 1);
      }

      if(var_4 & 512 || var_4 & 1024) {
        ref_12c3f("t9_ch_global_kill_enemy_while_crouched_or_prone_for_operator_mission_s5", 1);
      }

      if(var_4 & 262144) {
        ref_12c3f("t9_ch_global_longshot_kill_for_operator_mission_s5", 1);
      }

      if(var_14 && getkillstreaknamefromweapon(var_2) == "precision_airstrike") {
        ref_12c3f("t9_ch_global_kill_with_scorestreak_strike_for_operator_mission_s5", 1);
      }

      if(istrue(var_19) || var_1 == "equip_semtex") {
        ref_12c3f("t9_ch_global_semtex_kill_for_operator_mission_s5", 1);
      }

      if(var_11 == "rocketlauncher") {
        ref_12c3f("t9_ch_global_launcher_kill_or_destruction_for_operator_mission_s5", 1);
      }

      if(turret_struct(var_2)) {
        if(isDefined(self.ref_12a86) && isDefined(self.ref_12a86[var_2.basename]) && self.ref_12a86[var_2.basename] == 2) {
          ref_12c3f("t9_ch_global_ar_multikill_for_operator_mission_s5", 1);
        }
      }

      if(var_15 == "toma_strike" || var_15 == "precision_airstrike" || var_15 == "cruise_predator" || var_15 == "chopper_gunner" || var_15 == "fuel_airstrike" || var_15 == "gunship") {
        ref_12c3f("t9_ch_global_kill_with_aerial_scorestreak_or_killstreak_for_operator_mission_s5", 1);
      }

      if(var_5 & 1073741824 || var_1 == "iw8_me_t9ballisticknife_mp") {
        ref_12c3f("t9_ch_global_melee_weapon_or_ballistic_knife_kill_for_operator_mission_s5", 1);
      }

      if(self.killcountthislife == 3) {
        ref_12c3f("t9_ch_common_opbundle_01_objective_2", 1);
      }

      if(var_4 & 1048576) {
        ref_12c3f("t9_ch_common_opbundle_02_objective_2", 1);
      }

      if(isDefined(self.recentkillcount) && self.recentkillcount == 2) {
        ref_12c3f("t9_ch_common_opbundle_02_objective_3", 1);
      }

      if(var_12) {
        ref_12c3f("t9_ch_common_opbundle_03_objective_3", 1);
      }

      if(self.killcountthislife == 5) {
        ref_12c3f("t9_ch_common_opbundle_03_objective_4", 1);
      }
    }

    if(var_11 == "smg") {
      ref_12c3f("t9_ch_global_smg_ekia_no_stock_for_operator_mission_s5", 1);
    }

    if(istrue(var_31)) {
      ref_12c3f("t9_ch_global_ekia_tracker_for_operator_mission_s5", 1);
    }

    if(turret_struct(var_2)) {
      ref_12c3f("t9_ch_global_assault_ekia_for_operator_mission_s5", 1);
    }

    if(var_5 & 2048) {
      ref_12c3f("t9_ch_global_ekia_downed_for_operator_mission_s5", 1);
    }

    if(istrue(var_30)) {
      ref_12c3f("t9_ch_global_ekia_paranoia_or_high_alert_for_operator_mission_s5", 1);
    }

    var_42 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
      var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase");
    }

    foreach(var_44 in var_2.attachments) {
      var_45 = "";

      if(isDefined(var_42)) {
        var_45 = [[var_42]](var_44);
      }

      if(isstartstr(var_45, "thermal")) {
        ref_12c3f("t9_ch_global_ekia_thermal_scope_for_operator_mission_s5", 1);
      }

      if(var_11 == "spread" && isstartstr(var_45, "stockno")) {
        ref_12c3f("t9_ch_global_shotgun_ekia_no_stock_for_operator_mission_s5", 1);
      }
    }

    if(istrue(var_29)) {
      ref_12c3f("t9_ch_global_ekia_cold_blooded_for_operator_mission_s5", 1);
    }

    if(istrue(var_34)) {
      ref_12c3f("t9_ch_global_ekia_with_flak_jacket_perk_for_operator_mission_s5", 1);
    }

    if(istrue(var_32) && var_5 & 1) {
      ref_12c3f("t9_ch_global_ekia_under_enemy_detection_with_ghost_perk_for_operator_mission_s5", 1);
    }

    if(var_5 & 16777216) {
      ref_12c3f("t9_ch_global_ekia_enemies_gas_mine_or_gas_grenade_for_operator_mission_s5", 1);
    }

    if(useserverhud(var_1)) {
      ref_12c3f("t9_ch_global_special_weapon_ekia_for_operator_mission_s5", 1);
    }

    if(istrue(var_35) || istrue(var_36)) {
      ref_12c3f("t9_ch_global_ekia_gung_ho_double_time_for_operator_mission_s5", 1);
    }

    if(var_11 == "sniper") {
      ref_12c3f("t9_ch_global_sniper_ekia_for_operator_mission_s5", 1);
    }

    if(var_11 == "mg") {
      ref_12c3f("t9_ch_global_lmg_ekia_for_operator_mission_s5", 1);
    }

    var_61 = strtok(var_3, "|").size;

    if(var_61 >= 5) {
      ref_12c3f("t9_ch_global_ekia_5_or_more_attachments_for_operator_mission_s5", 1);
    }

    var_95 = 0;
    var_96 = 0;
    var_97 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      var_37 = scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk");
      var_95 = self[[var_37]]("specialty_quieter");
      var_96 = self[[var_37]]("specialty_no_battle_chatter");
      var_97 = self[[var_37]]("specialty_lightweight");
    }

    var_98 = var_95 && var_96 && var_97;

    if(var_98) {
      ref_12c3f("t9_ch_global_ekia_while_using_ninja_or_dead_silence_for_operator_mission_s5", 1);
    }

    if(var_11 == "pistol" && var_5 & 131072) {
      ref_12c3f("t9_ch_global_pistol_ekia_with_silenced_weapons_for_operator_mission_s5", 1);
    }

    switch (var_1) {
      case "iw8_sm_t9handling_mp":
      case "iw8_ar_t9mobility_mp":
        ref_12c3f("t9_ch_common_opbundle_01_objective_1", 1);
        break;
      case "iw8_ar_akilo47_mp":
      case "iw8_sh_t9pump_mp":
      case "iw8_sm_t9burst_mp":
      case "iw8_ar_t9damage_mp":
        ref_12c3f("t9_ch_common_opbundle_02_objective_1", 1);
        break;
      case "iw8_sm_t9heavy_mp":
      case "iw8_ar_t9standard_mp":
        ref_12c3f("t9_ch_common_opbundle_03_objective_1", 1);
        break;
    }
  }

  if(var_8 >= 12) {
    if(var_7) {
      if(turn_on_have_target_hud("iw8_sm_t9semiauto_mp") && !isDefined(self.ref_13ad4) && var_11 == "smg" && var_4 & 1048576) {
        if(!isDefined(self.ref_13419)) {
          self.ref_13419 = 0;
        }

        self.ref_13419++;

        if(self.ref_13419 == 2) {
          ref_12c3f("t9_ch_global_smg_headshot_kills_for_weapon_unlock_s6", 1);
          self.ref_13ad4 = 1;
        }
      }

      if(turn_on_have_target_hud("iw8_ar_t9british_mp") && !isDefined(self.monitoraveragevelocities) && isDefined(var_2) && turret_struct(var_2)) {
        if(isDefined(self.ref_12a86) && isDefined(self.ref_12a86[var_2.basename]) && self.ref_12a86[var_2.basename] == 2) {
          ref_12c3f("t9_ch_global_ar_multikill_for_weapon_unlock_s6", 1);
          self.monitoraveragevelocities = 1;
        }
      }

      var_99 = var_2.inventorytype == "primary" && !(var_4 & 131072);
      var_100 = var_4 & 131072;
      var_101 = !(var_5 & 1073741824);

      if((var_99 || var_100) && var_101) {
        if(!isDefined(self.ref_12a0c)) {
          self.ref_12a0c = 0;
        }

        self.ref_12a0c++;
      }

      if(var_12) {
        if(!isDefined(self.numnonrallyvehicles)) {
          self.numnonrallyvehicles = 0;
        }

        self.numnonrallyvehicles++;
      }

      if(turn_on_have_target_hud("iw8_me_t9battleaxe_mp") && !isDefined(self.chooseanim_vehicleturret)) {
        if(isDefined(self.ref_11bc2) && self.ref_11bc2 > 0 && isDefined(self.numnonrallyvehicles) && self.numnonrallyvehicles > 0 && isDefined(self.ref_12a0c) && self.ref_12a0c > 0) {
          ref_12c3f("t9_ch_global_kills_by_gun_and_melee_weapon_and_lethal_same_life_for_weapon_unlock_s6", 1);
          self.chooseanim_vehicleturret = 1;
        }
      }

      if(turn_on_have_target_hud("iw8_me_t9coldwar_mp") && !isDefined(self.setteamlastzombietime)) {
        if(var_11 == "throwingknife" || istrue(var_21) || var_1 == "equip_throwing_knife") {
          self.ref_13b5b = 1;
        }

        if(isDefined(self.ref_11bc2) && self.ref_11bc2 >= 0 && istrue(self.ref_13b5b)) {
          ref_12c3f("t9_ch_global_melee_kill_plus_hatchet_or_throwing_kill_single_life_for_weapon_unlock_s6", 1);
          self.setteamlastzombietime = 1;
        }
      }

      if(turn_on_have_target_hud("iw8_sm_t9season6_mp") && !isDefined(self.waitingforteammaterevive)) {
        if(var_11 == "smg" && var_4 & 8) {
          if(!isDefined(self.ref_13418)) {
            self.ref_13418 = 0;
          }

          self.ref_13418++;

          if(self.ref_13418 == 3) {
            ref_12c3f("t9_ch_global_smg_ads_x_kills_for_weapon_unlock_s6", 1);
            self.waitingforteammaterevive = 1;
          }
        }
      }

      if(turn_on_have_target_hud("iw8_sh_t9leveraction_mp") && !isDefined(self.trial_targs_combo)) {
        if(var_11 == "spread" && var_4 & 524288) {
          if(!isDefined(self.ref_132bc)) {
            self.ref_132bc = 0;
          }

          self.ref_132bc++;

          if(self.ref_132bc == 2) {
            ref_12c3f("t9_ch_global_shotgun_point_blank_kills_for_weapon_unlock_s6", 1);
            self.trial_targs_combo = 1;
          }
        }
      }

      if(turn_on_have_target_hud("iw8_ar_t9season6_mp") && !isDefined(self.send_notify_to_module_struct)) {
        if(turret_struct(var_2) && isDefined(self.lastkilledplayer) && make_c4_pick_up_interact(self, self.lastkilledplayer)) {
          if(!isDefined(self.cargo_truck_initcollision)) {
            self.cargo_truck_initcollision = 0;
          }

          self.cargo_truck_initcollision++;

          if(self.cargo_truck_initcollision == 3) {
            ref_12c3f("t9_ch_global_ar_kill_enemy_at_lower_elevation_for_weapon_unlock_s6", 1);
            self.send_notify_to_module_struct = 1;
          }
        }
      }
    }

    if(var_7) {
      if(var_12) {
        ref_12c3f("t9_ch_global_lethal_kill_for_operator_mission_s6", 1);
      }

      if(isDefined(self.getanglesfacingorigin) && self.getanglesfacingorigin == 2) {
        ref_12c3f("t9_ch_global_two_headshots_same_game_for_operator_mission_s6", 1);
      }

      if(var_9 == 5) {
        ref_12c3f("t9_ch_global_killstreak_5_for_operator_mission_s6", 1);
        ref_12c3f("t9_ch_common_opbundle_05_objective_2", 1);
      }

      if(var_9 == 3) {
        ref_12c3f("t9_ch_common_opbundle_06_objective_3", 1);
      }

      if(isDefined(var_2) && isDefined(var_2.classname) && var_2.classname == "grenade") {
        ref_12c3f("t9_ch_global_explosive_kills_for_operator_mission_s6", 1);
        ref_12c3f("t9_ch_common_opbundle_06_objective_2", 1);
      }

      if(isDefined(self.cargo_truck_mg_addgunnerdamagemod) && self.cargo_truck_mg_addgunnerdamagemod == 3) {
        ref_12c3f("t9_ch_global_ar_killstreak_3_for_operator_mission_s6", 1);
      }

      if(self.recentkillcount >= 2) {
        ref_12c3f("t9_ch_global_kills_while_on_streak_for_operator_mission_s6", 1);
      }

      if(istrue(var_2.ref_12cc1)) {
        ref_12c3f("t9_ch_global_supplypod_kill_for_operator_mission_s6", 1);
      }

      if(var_5 & 268435456) {
        ref_12c3f("t9_ch_global_kill_without_taking_damage_for_operator_mission_s6", 1);
        ref_12c3f("t9_ch_common_opbundle_07_objective_2", 1);
        var_95 = 0;
        var_96 = 0;
        var_97 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          var_37 = scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk");
          var_95 = self[[var_37]]("specialty_quieter");
          var_96 = self[[var_37]]("specialty_no_battle_chatter");
          var_97 = self[[var_37]]("specialty_lightweight");
        }

        var_98 = var_95 && var_96 && var_97;

        if(var_98) {
          ref_12c3f("t9_ch_global_ninja_kill_without_taking_damage_for_operator_mission_s6", 1);
        }
      }

      if(var_4 & 1048576) {
        ref_12c3f("t9_ch_global_headshots_for_operator_mission_s6", 1);
        ref_12c3f("t9_ch_common_opbundle_04_objective_3", 1);
      }

      if(isDefined(self.player_equip_primary) && self.recentkillcount >= 2 && weaponclass(self.player_equip_primary) == "smg" && var_2 == self.player_equip_primary) {
        ref_12c3f("t9_ch_global_smg_multikill_for_operator_mission_s6", 1);
      }

      if(var_11 == "smg" && var_4 & 16) {
        if(isDefined(var_2) && isDefined(var_2.attachments)) {
          var_42 = undefined;

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
            var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase");
          }

          foreach(var_44 in var_2.attachments) {
            var_45 = "";

            if(isDefined(var_42)) {
              var_45 = [[var_42]](var_44);
            }

            if(isstartstr(var_45, "laser")) {
              ref_12c3f("t9_ch_global_smg_hipfire_laser_attachment_ekia_for_operator_mission_s6", 1);
              break;
            }
          }
        }
      }

      if(var_5 & 262144) {
        ref_12c3f("t9_ch_global_kill_through_wall_for_operator_mission_s6", 1);
      }

      if(var_14 && getkillstreaknamefromweapon(var_2) == "toma_strike") {
        ref_12c3f("t9_ch_global_napalm_strike_or_cluster_strike_kill_for_operator_mission_s6", 1);
      }

      if(var_4 & 512 || var_4 & 1024) {
        ref_12c3f("t9_ch_global_kill_enemy_while_crouched_or_prone_for_operator_mission_s6", 1);
      }

      if(var_5 & 16777216) {
        ref_12c3f("t9_ch_global_ekia_enemies_gas_mine_or_gas_grenade_for_operator_mission_s6", 1);
      }

      if(isDefined(self.ref_142ad) && var_12) {
        var_104 = self.origin + (0, 0, 35);

        if(var_4 & 1024) {
          var_104 = self.origin + (0, 0, 17);
        }

        var_105 = scripts\engine\trace::ray_trace(self.ref_142ad.origin + (0, 0, 35), var_104, undefined, undefined, undefined, 1);

        if(isDefined(var_105["entity"]) && var_105["entity"] != self) {
          ref_12c3f("t9_ch_global_lethal_equipment_kills_on_unseen_targets_for_operator_mission_s6", 1);
        }
      }

      if(self.recentkillcount >= 3) {
        ref_12c3f("t9_ch_global_triple_kills_for_operator_mission_s6", 1);
      }

      if(isDefined(self.ref_142ad) && !(var_4 & 512)) {
        var_104 = self.origin + (0, 0, 35);

        if(var_4 & 1024) {
          var_104 = self.origin + (0, 0, 17);
        }

        var_105 = scripts\engine\trace::ray_trace(var_104, self.ref_142ad.origin + (0, 0, 35), undefined, undefined, undefined, 1);

        if(var_105["fraction"] < 1) {
          ref_12c3f("t9_ch_global_kill_enemies_while_partially_covered_for_operator_mission_s6", 1);
        }
      }

      if(isDefined(self.watch_for_player_enter_trigger)) {
        var_79 = gettime() - self.watch_for_player_enter_trigger < 10000;

        if(istrue(var_79)) {
          ref_12c3f("t9_ch_global_three_or_more_kills_with_stim_shot_for_operator_mission_s6", 1);
        }
      }

      if(isDefined(self.plantedsuperequip)) {
        foreach(var_55 in self.plantedsuperequip) {
          if(isDefined(var_55.origin) && distancesquared(var_55.origin, self.origin) < 640000) {
            ref_12c3f("t9_ch_global_kill_near_non_lethal_field_upgrade_for_operator_mission_s6", 1);
            break;
          }
        }
      }

      if(isDefined(self.ref_11bc1) && self.ref_11bc1 == 3) {
        ref_12c3f("t9_ch_global_three_melee_kills_in_single_game_for_operator_mission_s6", 1);
      }

      if(isDefined(self.attackerdata) && isDefined(self.lastkilledplayer) && isDefined(self.attackerdata[self.lastkilledplayer.guid]) && isDefined(self.attackerdata[self.lastkilledplayer.guid].lasttimedamaged)) {
        ref_12c3f("t9_ch_global_kill_enemy_damage_you_for_operator_mission_s6", 1);
      }

      if(istrue(var_20)) {
        ref_12c3f("t9_ch_global_frag_grenade_kill_for_operator_mission_s6", 1);
      }

      if(var_11 == "rocketlauncher") {
        ref_12c3f("t9_ch_global_launcher_kill_or_destruction_for_operator_mission_s6", 1);
      }

      if(isDefined(self.lastkilledplayer)) {
        var_108 = 3936.8;
        var_109 = distance2d(self.origin, self.lastkilledplayer.origin);

        if(var_109 >= var_108) {
          ref_12c3f("t9_ch_global_kill_enemy_over_100m_away_for_operator_mission_s6", 1);
        }
      }
    }

    ref_12c3f("t9_ch_global_ekia_for_operator_mission_s6", 1);

    if(istrue(var_27) || istrue(var_28)) {
      ref_12c3f("t9_ch_global_ekia_with_tac_mask_or_battle_hardened_perk_for_operator_mission_s6", 1);
    }

    if(isDefined(var_2) && va_cluster_spawnpoint_valid(var_2)) {
      ref_12c3f("t9_ch_global_ekia_tactical_rifle_for_operator_mission_s6", 1);
    }

    if(isDefined(var_2) && turret_struct(var_2)) {
      ref_12c3f("t9_ch_global_assault_ekia_for_operator_mission_s6", 1);
    }

    switch (level.disable_super_in_turret.name) {
      case "mini":
      case "":
        ref_12c3f("t9_ch_global_ekia_single_life_elim_mode_for_operator_mission_s6", 1);
        break;
      default:
        break;
    }

    if(var_11 == "smg") {
      ref_12c3f("t9_ch_global_smg_ekia_for_operator_mission_s6", 1);
    }

    if(var_11 == "pistol") {
      ref_12c3f("t9_ch_global_pistol_ekia_for_operator_mission_for_operator_mission_s6", 1);
    }

    if(var_4 & 131072) {
      ref_12c3f("t9_ch_global_ekia_secondary_for_operator_mission_s6", 1);
    }

    if(isDefined(var_2) && isDefined(var_2.attachments)) {
      var_42 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
        var_42 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase");
      }

      foreach(var_44 in var_2.attachments) {
        var_45 = "";

        if(isDefined(var_42)) {
          var_45 = [[var_42]](var_44);
        }

        if(isstartstr(var_45, "xmag") || isstartstr(var_45, "smag") || isstartstr(var_45, "drum")) {
          ref_12c3f("t9_ch_global_ekia_extra_ammo_magazine_for_operator_mission_s6", 1);
        }
      }
    }

    if(var_11 == "spread") {
      ref_12c3f("t9_ch_global_shotgun_ekia_for_operator_mission_s6", 1);
    }

    if(isDefined(var_2) && unset_relic_focus_fire(var_2)) {
      ref_12c3f("t9_ch_global_ekia_full_auto_for_operator_mission_s6", 1);
    }

    if(var_11 == "mg") {
      ref_12c3f("t9_ch_global_lmg_ekia_for_operator_mission_s6", 1);
    }

    if(istrue(var_30)) {
      ref_12c3f("t9_ch_global_ekia_paranoia_or_high_alert_for_operator_mission_s6", 1);
    }

    switch (var_1) {
      case "iw8_sm_t9burst_mp":
        ref_12c3f("t9_ch_common_opbundle_04_objective_1", 1);
        break;
      case "iw8_lm_t9light_mp":
      case "iw8_sm_t9heavy_mp":
      case "iw8_ar_t9slowhandling_mp":
        ref_12c3f("t9_ch_common_opbundle_05_objective_1", 1);
        break;
      case "iw8_la_t9launcher_mp":
      case "iw8_sm_t9standard_mp":
        ref_12c3f("t9_ch_common_opbundle_06_objective_1", 1);
        break;
      case "iw8_sm_t9handling_mp":
      case "iw8_pi_t9fullauto_mp":
        ref_12c3f("t9_ch_common_opbundle_07_objective_1", 1);
        break;
      case "iw8_ar_t9british_mp":
        ref_12c3f("t9_ch_common_opbundle_04_objective_1", 1);
        ref_12c3f("t9_ch_common_opbundle_07_objective_1", 1);
        break;
    }
  }

  if(var_8 >= 14) {
    if(var_7) {
      var_95 = 0;
      var_96 = 0;
      var_97 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        var_37 = scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk");
        var_95 = self[[var_37]]("specialty_quieter");
        var_96 = self[[var_37]]("specialty_no_battle_chatter");
        var_97 = self[[var_37]]("specialty_lightweight");
      }

      var_98 = istrue(var_95) && istrue(var_96) && istrue(var_97);

      if(turn_on_have_target_hud("iw8_me_t9scythe_mp") && var_98 && var_5 & 1073741824) {
        if(!isDefined(self.isgroundwardom)) {
          self.isgroundwardom = 1;
        } else {
          self.isgroundwardom++;
        }

        if(self.isgroundwardom == 2) {
          ref_12c3f("t9_ch_global_melee_weapon_kill_while_using_ninja_or_dead_silence_for_weapon_unlock_s7", 1);
        }
      }
    }
  }

  if(var_8 >= 15) {
    if(var_7) {
      if(turn_on_have_target_hud("iw8_sm_t9flechette_mp") && var_11 == "smg" && var_5 & 4194304 && !istrue(self.smgdetectedkill)) {
        _id_12C3F("t9_ch_global_smg_kill_detected_enemies_for_weapon_unlock_s7", 1);
        self.smgdetectedkill = 1;
      }
    }
  }
}

function runplunderextractsitetimer(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName")) {
      var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](var_0.basename);
      var_3 = tablelookup("mp/statstable.csv", 5, var_2, 4);
      var_4 = var_3 + "_variant_0";
      var_1 = int(tablelookup("loot/weapon_ids.csv", 6, var_4, 0));
    }
  }

  return var_1;
}

function resetstreamerposhint() {
  var_0 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "lookupCurrentOperator")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "lookupCurrentOperator")]](self.team);

    if(var_1 != "") {
      var_0 = int(tablelookup("loot/operator_ids.csv", 1, var_1, 0));
    }
  }

  return var_0;
}

function init_silo_elevator(var_0, var_1, var_2, var_3) {
  if(!challengesenabledforplayer(var_0)) {
    return;
  }

  if(var_3 <= 0) {
    return;
  }

  var_4 = relic_amped_is_there_valid_new_victim();
  var_5 = runplunderextractsitetimer(var_0, var_2);
  var_6 = resetstreamerposhint(var_0);

  if(!isDefined(var_1)) {
    var_1 = [];
  }

  var_7 = 0;

  if(istrue(var_1["mounted"])) {
    var_7 |= 1;
  }

  if(istrue(var_0.modifiers["collateral"])) {
    var_7 |= 2;
  }

  var_8 = 0;
  var_9 = weaponclass(var_2.basename);

  if(issubstr(var_2.basename, "_me_")) {
    var_9 = "melee";
  }

  switch (var_9) {
    case "rifle":
      var_8 = 3;
      break;
    case "mg":
      var_8 = 17;
      break;
    case "melee":
      var_8 = 513;
      break;
    case "pistol":
      var_8 = 129;
      break;
    case "spread":
      var_8 = 9;
      break;
    case "smg":
      var_8 = 5;
      break;
    case "sniper":
      var_8 = 65;
      break;
    default:
      break;
  }

  if(var_9 == "melee" && !isDefined(var_0.pers["meleeMultikillOnce"])) {
    var_7 |= 32;
    var_0.pers["meleeMultikillOnce"] = 1;
  }

  if(var_9 == "lethal" && !isDefined(var_0.pers["lethalMultikillOnce"])) {
    var_7 |= 4;
    var_0.pers["lethalMultikillOnce"] = 1;
  }

  var_0 reportchallengeuserevent("generic", 1, var_5, var_3, var_6, var_4, var_7, var_8);
}

function init_sentry_traps(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = resetstuckthermite(var_1);
  var_11 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
  }

  if(!isDefined(var_11)) {
    var_11 = getDvar("g_gametype");
  }

  var_12 = play_station_closed_vo(var_6);
  var_13 = play_stealthy_disguise_vo(var_1);
  var_14 = [var_7, 0];
  var_15 = play_sound_from_closest_player(var_3);
  var_16 = "";

  if(isDefined(var_1.modifiers) && isDefined(var_1.modifiers["active_field_upgrade"])) {
    var_16 = var_1.modifiers["active_field_upgrade"];
  }

  var_17 = 65535;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    var_17 = level.br_circle.circleindex;
  }

  var_18 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getWeaponRarity")) {
    var_18 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getWeaponRarity")]](var_6);
  }

  if(!isDefined(var_18)) {
    var_18 = 65535;
  }

  if(var_2[0] == "iav_weapon_mp" || var_2[0] == "tur_apc_rus_mp") {
    var_8 = "MOD_CRUSH";
  }

  if(getdvarint("onlinegame", 1)) {
    var_19 = var_1 getfireteammembers();
    var_20 = var_19.size;
  } else {
    var_20 = 1;
  }

  if(isDefined(var_2.pers["meleeKills"]) && var_2.pers["meleeKills"] == 5) {
    var_2.mp_village2_patches["5_melee_weapon_kills"] = 1;
  }

  if(isDefined(var_2.pers["smgADSKills"]) && var_2.pers["smgADSKills"] == 10) {
    var_2.mp_village2_patches["10_ads_smg_kills"] = 1;
  }

  if(isDefined(var_2.pers["arHeadshots"]) && var_2.pers["arHeadshots"] == 5) {
    var_2.mp_village2_patches["5_headshot_ar_kills"] = 1;
  }

  if(isDefined(var_2.pers["sniperOneShotKills"]) && var_2.pers["sniperOneShotKills"] == 10) {
    var_2.mp_village2_patches["10_sn_1shot_kills"] = 1;
  }

  if(isDefined(var_2.pers["fireKills"]) && var_2.pers["fireKills"] == 5) {
    var_2.mp_village2_patches["5_firekills"] = 1;
  }

  if(isDefined(var_2.pers["movingKills"]) && var_2.pers["movingKills"] == 10) {
    var_2.mp_village2_patches["10_movingkill"] = 1;
  }

  if(isDefined(var_2.pers["pointBlankKills"]) && var_2.pers["pointBlankKills"] == 10) {
    var_2.mp_village2_patches["10_closerangekill"] = 1;
  }

  if(isDefined(var_2.pers["hipfireKills"]) && var_2.pers["hipfireKills"] == 10) {
    var_2.mp_village2_patches["10_hipfirekill"] = 1;
  }

  if(isDefined(var_2.pers["slideKills"]) && var_2.pers["slideKills"] == 3) {
    var_2.mp_village2_patches["3_slide_kills"] = 1;
  }

  if(isDefined(var_2.pers["oneShotOneKills"]) && var_2.pers["oneShotOneKills"] == 10) {
    var_2.mp_village2_patches["10_oneshotonekills"] = 1;
  }

  var_21 = gettouchinglocaletriggers(var_2, var_4);
  var_22 = relic_amped_is_there_valid_new_victim();
  var_23 = 0;
  var_24 = 0;
  var_25 = 0;
  var_26 = runleadmarkers(var_7);
  var_27 = getchallengemapid();
  var_2 reportchallengeuserevent("kill", var_15, var_3, var_5, var_6, var_11, var_22, var_13, var_14, var_16, var_17, var_21, var_9, var_20, var_18, var_20, var_10, var_23, var_26, var_25, var_24, var_27);

  if((var_12 == "br" || var_12 == "brtdm") && (isPlayer(var_4) || var_16 & 32)) {
    var_28 = var_3[0];

    if(isDefined(var_2.modifiers) && istrue(var_2.modifiers["execution"])) {
      if(isDefined(var_2.primaryweaponobj)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName")) {
          var_28 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](var_2.primaryweaponobj.basename);
        }
      }

      if(isDefined(var_2.weaponlist)) {
        foreach(var_30 in var_2.weaponlist) {
          if(var_30.basename == "iw8_me_t9loadout_mp") {
            var_28 = "iw8_me_t9loadout_mp";
          }
        }
      }
    }

    var_2.ref_142ad = var_4;
    init_turrets(var_2, var_16, var_28, var_7, var_13, var_5, var_6, var_1, 1);
    return;
  }
}

function relic_squadlink_onsteppedclose() {
  var_0 = 0;

  if(isDefined(self.mp_village2_patches)) {
    foreach(var_2 in self.mp_village2_patches) {
      switch (var_3) {
        case "5_melee_weapon_kills":
          var_0 |= 2;
          break;
        case "10_ads_smg_kills":
          var_0 |= 4;
          break;
        case "5_headshot_ar_kills":
          var_0 |= 8;
          break;
        case "10_sn_1shot_kills":
          var_0 |= 16;
          break;
        case "5_firekills":
          var_0 |= 32;
          break;
        case "10_movingkill":
          var_0 |= 64;
          break;
        case "10_closerangekill":
          var_0 |= 128;
          break;
        case "10_hipfirekill":
          var_0 |= 512;
          break;
        case "3_slide_kills":
          var_0 |= 16384;
          break;
        case "10_oneshotonekills":
          var_0 |= 32768;
          break;
      }
    }
  }

  if(function_043e(self)) {
    var_0 |= 1;
  }

  return var_0;
}

function runleadmarkers(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_1 = "";
  }

  if(!isDefined(var_0) || !isDefined(var_0.attachments)) {
    return var_1;
  }

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getDefaultWeaponBaseName")) {
    return var_1;
  }

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
    return var_1;
  }

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentIsSelectable")) {
    return var_1;
  }

  var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getDefaultWeaponBaseName")]](var_0.basename);
  var_4 = tablelookup("mp/statstable.csv", 5, var_3, 4);
  var_5 = "loot/" + var_4 + "_attachment_ids.csv";
  var_6 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase");
  var_7 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentIsSelectable");
  var_2 = 0;

  foreach(var_9 in var_0.attachments) {
    var_10 = [[var_6]](var_9);

    if([[var_7]](var_0, var_10)) {
      var_1 = tablelookup(var_5, 1, var_10, 0);
      var_2++;
      continue;
    }

    if(isDefined(level.attachmentoverridetobase) && isDefined(level.attachmentoverridetobase[var_9]) && [[var_7]](var_0, level.attachmentoverridetobase[var_9])) {
      var_1[var_2] = tablelookup(var_5, 1, level.attachmentoverridetobase[var_9], 0);
      var_2++;
    }
  }

  if(var_2 > 10) {}

  return var_1;
}

function play_station_closed_vo(var_0) {
  var_1 = "";
  var_2 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "isCACPrimaryOrSecondary")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "isCACPrimaryOrSecondary")]](var_0)) {
      var_1 = "no_attachments";
    }
  }

  if(isDefined(var_0.attachments)) {
    var_3 = 0;

    foreach(var_5 in var_0.attachments) {
      var_6 = "";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentMap_toBase")) {
        var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentMap_toBase")]](var_5);
      }

      if(var_6 == "scope") {
        var_3 = 1;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "attachmentIsSelectable")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "attachmentIsSelectable")]](var_0, var_6)) {
          if(!var_2) {
            var_1 += "|";
          }

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "remapAttachmentParentName")) {
            var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "remapAttachmentParentName")]](var_6);
          }

          var_1 += var_6;
          var_2 = 0;
        }
      }
    }

    if(var_3) {
      if(!var_2) {
        var_1 += "|";
      }

      var_1 += "default_sniper_scope";
    }
  }

  return var_1;
}

function play_stealthy_disguise_vo(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0.classstruct)) {
    if(istrue(var_1)) {
      var_2 = var_0.classstruct.loadoutextraperks;
    } else {
      var_2 = var_0.classstruct.loadoutperks;
    }
  }

  var_3 = "";
  var_4 = 1;

  if(isDefined(var_2)) {
    foreach(var_6 in var_2) {
      if(!var_4) {
        var_3 += "|";
      }

      var_3 += var_6;
      var_4 = 0;
    }
  }

  return var_3;
}

function play_sound_from_closest_player(var_0) {
  var_1 = 0;

  if(isPlayer(var_0)) {
    var_1 |= 1;
  }

  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_0.streakinfo)) {
    var_1 |= 2;
    var_6 = var_0.streakinfo.streakname;
    var_5 = unsetreduceregendelayonkill(var_6);

    switch (var_6) {
      case "sentry_gun":
      case "pac_sentry":
      case "manual_turret":
      case "bradley":
      case "juggernaut":
        var_2 = 1;
        break;
      case "nuke":
      case "white_phosphorus":
      case "toma_strike":
      case "precision_airstrike":
      case "hover_jet":
      case "gunship":
      case "cruise_predator":
      case "chopper_support":
      case "chopper_gunner":
        var_3 = 1;
        break;
      case "scrambler_drone_guard":
      case "directional_uav":
      case "uav":
      case "radar_drone_overwatch":
        var_3 = 1;
        var_4 = 1;
        break;
      case "airdrop_multiple":
      case "airdrop":
        var_4 = 1;
        break;
    }

    if(var_2) {
      var_1 |= 8;
    }

    if(var_3) {
      var_1 |= 4;
    }

    if(var_4) {
      var_1 |= 16;
    }
  }

  if(isDefined(var_0.vehiclename) || var_5) {
    var_1 |= 32;

    if(!var_2 && isDefined(var_0.vehiclename) && !istrue(var_0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
      var_1 |= 8;
    }

    if(!var_3 && isDefined(var_0.vehiclename) && istrue(var_0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly())) {
      var_1 |= 4;
    }
  }

  if(isDefined(var_0.equipmentref)) {
    var_1 |= 64;
  }

  if(isagent(var_0)) {
    var_1 = ref_12ce0(var_1, var_0);
  }

  return var_1;
}

function ref_12ce0(var_0, var_1) {
  if(isDefined(var_1.unittype) && var_1.unittype == "zombie") {
    var_0 |= 2048;
  }

  if(!isDefined(var_1.aitype)) {
    return var_0;
  }

  switch (var_1.aitype) {
    case "soldier":
      var_0 |= 512;
      break;
    case "juggernaut":
      var_0 |= 128;
      break;
    case "suicidebomber":
      var_0 |= 1024;
      break;
    case "riotshield":
      var_0 |= 256;
      break;
    default:
      var_0 |= 512;
      break;
  }

  return var_0;
}

function watchreloading(var_0) {
  self endon(var_0);
  self waittill("reload_start");

  if(level.getallactivequestsforteam >= 11) {
    self.zombieloadout = undefined;
    return;
  }
}

function va_cluster_spawnpoint_valid(var_0) {
  var_1 = weaponclass(var_0);

  if(var_1 != "rifle") {
    return false;
  }

  var_2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "getWeaponMenuCategory")) {
    var_2 = scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "getWeaponMenuCategory");
  }

  if(!isDefined(var_2)) {
    return false;
  }

  return [[var_2]](var_0.basename) == "weapon_tactical";
}

function turret_struct(var_0) {
  var_1 = va_cluster_spawnpoint_valid(var_0);
  var_2 = weaponclass(var_0);
  return var_2 == "rifle" && !var_1;
}

function unset_relic_focus_fire(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(weaponisauto(var_0)) {
    var_1 = weaponclass(var_0);

    switch (var_1) {
      case "rifle":
        return !va_cluster_spawnpoint_valid(var_0);
      case "smg":
      case "pistol":
      case "spread":
      case "mg":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function useserverhud(var_0) {
  switch (var_0) {
    case "iw8_sn_crossbow_mp":
    case "iw8_me_t9ballisticknife_mp":
    case "iw8_la_t9launcher_mp":
    case "iw8_sn_t9crossbow_mp":
    case "iw8_sm_t9nailgun_mp":
    case "iw8_la_mike32_mp":
      return 1;
    default:
      return 0;
  }
}

function make_c4_pick_up_interact(var_0, var_1) {
  if(isDefined(var_0.origin) && isDefined(var_1.origin)) {
    var_2 = var_0.origin[2] - var_1.origin[2];
    var_3 = 70;

    if(var_2 >= var_3) {
      return true;
    }
  }

  return false;
}

function ref_1424b() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self, 1);

  if(!isDefined(var_0)) {
    return;
  }

  if(!challengesenabledforplayer(var_0)) {
    return;
  }

  if(level.getallactivequestsforteam >= 10 && self.targetname == "motorcycle") {
    if(!self vehicle_isonground()) {
      if(!isDefined(var_0.investigate_someone_using_bomb)) {
        var_0.investigate_someone_using_bomb = gettime();
        return;
      }

      var_1 = gettime() - var_0.investigate_someone_using_bomb;

      if(var_1 >= 1000) {
        ref_12c3f(var_0, "t9_ch_global_dirt_bike_airtime_for_operator_mission_s4", var_1 / 1000);
        var_0.investigate_someone_using_bomb = undefined;
        return;
      }

      return;
    }

    if(isDefined(var_1.investigate_someone_using_bomb)) {
      var_1 = gettime() - var_1.investigate_someone_using_bomb;

      if(var_1 >= 1000) {
        ref_12c3f(var_1, "t9_ch_global_dirt_bike_airtime_for_operator_mission_s4", var_1 / 1000);
      }

      var_1.investigate_someone_using_bomb = undefined;
      return;
    }

    return;
  }
}

function update_objective_ownerclient(var_0) {
  if(isDefined(level.ref_13641) && isDefined(level.modeupdateloadoutclass)) {
    var_1 = 348100;

    foreach(var_3 in level.ref_13641) {
      var_4 = distance2dsquared(var_0, var_3.curorigin);

      if(var_4 <= var_1) {
        return true;
      }
    }

    foreach(var_7 in level.modeupdateloadoutclass) {
      var_4 = distance2dsquared(var_0, var_7.origin);

      if(var_4 <= var_1) {
        return true;
      }
    }
  }

  return false;
}

function ref_12083() {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(level.getallactivequestsforteam >= 10 && getdvarint("scr_enable_br_satellite_hunt", 0) == 1) {
    ref_12c3f("t9_ch_global_secure_satlink_for_s4_event_wz", 1);
    return;
  }
}

function ref_12005() {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(level.getallactivequestsforteam >= 10 && getdvarint("scr_enable_br_satellite_hunt", 0) == 1) {
    ref_12c3f("t9_ch_global_collect_satellite_reward_for_s4_event_wz", 1);
    return;
  }
}

function ref_120a9(var_0) {
  if(!challengesenabledforplayer()) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(level.getallactivequestsforteam >= 11 && getdvarint("scr_br_numbers_tower_enabled", 0) == 1 && getdvarint("scr_br_numbers_tower_usable", 0) == 1) {
    ref_12c3f(var_0, 1);
    return;
  }
}

function ref_125f3() {
  return istrue(self.iszombie);
}

function onplayerteamrevive(var_0, var_1) {}

function onsuccessfulhit(var_0) {}

function onspawn() {}

function updatesuperweaponkills(var_0, var_1) {}

function updatesuperkills(var_0, var_1, var_2) {}

function resistedstun(var_0) {}

function triggereddelayedexplosion() {}

function minedestroyed(var_0, var_1, var_2) {}

function roundbegin() {}

function roundend(var_0) {}

function playerdamaged(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1) && !challengesenabledforplayer(var_1)) {
    return;
  }

  if(level.getallactivequestsforteam >= 12) {
    if(isDefined(var_1)) {
      ref_12c3f(var_1, "t9_ch_global_damage_done_for_operator_mission_s6", var_2);
      ref_12c3f(var_1, "t9_ch_global_damage_done_s6", var_2);
    }
  }

  if(turn_on_have_target_hud("iw8_ar_t9soviet_mp") && isDefined(var_1) && !isDefined(var_1.ref_139e3)) {
    if(isDefined(var_4) && turret_struct(var_4)) {
      if(!isDefined(var_1.ref_11b21)) {
        var_1.ref_11b21 = var_2;
      } else {
        var_1.ref_11b21 += var_2;
      }

      if(var_1.ref_11b21 >= 1000) {
        ref_12c3f(var_1, "t9_ch_global_ar_deal_1000_damage_for_weapon_unlock_s7", 1);
        var_1.ref_139e3 = 1;
        return;
      }

      return;
    }

    return;
  }
}

function processuavassist(var_0, var_1) {}

function killstreakdamaged(var_0, var_1, var_2, var_3, var_4) {}

function unsetreduceregendelayonkill(var_0) {
  switch (var_0) {
    case "sentry_gun":
    case "manual_turret":
    case "cruise_predator":
    case "juggernaut":
      return false;
  }

  return true;
}

function getkillstreaknamefromweapon(var_0) {
  var_1 = var_0.basename;

  if(isDefined(level.killstreakweaponmap[var_1])) {
    return level.killstreakweaponmap[var_1];
  }

  return undefined;
}

function processfinalkillchallenges(var_0, var_1) {}

function usedkillstreak(var_0) {
  if(!isDefined(self.vote_player_init)) {
    if(!isDefined(self.fuelsequencestability)) {
      self.fuelsequencestability = 1;
    } else {
      self.fuelsequencestability++;
    }

    if(self.fuelsequencestability >= 5) {
      ref_12c3f("t9_ch_global_x_scorestreak_activations_single_match_s3", 1);
      self.vote_player_init = 1;
    }
  }

  if(level.getallactivequestsforteam >= 9 && (var_0 == "nuke" || var_0 == "precision_airstrike" || var_0 == "cruise_predator" || var_0 == "manual_turret" || var_0 == "pac_sentry" || var_0 == "toma_strike" || var_0 == "chopper_gunner" || var_0 == "bradley" || var_0 == "gunship" || var_0 == "fuel_airstrike" || var_0 == "chopper_support" || var_0 == "sentry_gun" || var_0 == "white_phosphorus" || var_0 == "hover_jet" || var_0 == "juggernaut" || var_0 == "assault_drone")) {
    ref_12c3f("t9_ch_global_call_in_lethal_scorestreak_for_operator_mission_s3", 1);
  }

  if(level.getallactivequestsforteam >= 12) {
    ref_12c3f("t9_ch_common_opbundle_07_objective_3", 1);
    return;
  }
}

function resetstuckthermite() {
  var_0 = [];

  if(isDefined(self.team) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "lookupCurrentOperator")) {
    GscBinSkip0(0x2e, 0, self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "lookupCurrentOperator")]](self.team));
  }

  GscBinSkip0(0x2e, 0, "");
}

function attachmentgroup(var_0) {
  return tablelookup("mp/attachmenttable.csv", 4, var_0, 2);
}

function getoperatorfavoriteweapon(var_0) {
  var_1 = "";

  if(var_0 != "") {
    var_1 = tablelookup("operators.csv", 1, var_0, 33);
  }

  return var_1;
}