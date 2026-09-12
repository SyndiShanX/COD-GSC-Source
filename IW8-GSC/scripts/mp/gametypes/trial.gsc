/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\trial.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\engine\utility::flag_init("strike_init_done");
  trial_mission_data_init();
  ref_13D61();
  scripts\mp\trials\mp_trials_patches::init_trial_patches();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  } else {
    setdynamicdvar("scr_game_tacticalmode", 0);
    setdynamicdvar("scr_game_onlyheadshots", 0);
  }

  if(issubstr(getDvar("mapname"), "mp_t_")) {
    setDvar("scr_game_enableMinimap", 0);
  }

  if(getDvar("LOQKLRKQMO") == "1") {
    setDvar("lui_trial_event_ending", 1);
  } else {
    setDvar("lui_trial_ending", 1);
  }

  setDvar("ai_enable_execution_victim", 0);
  setDvar("scr_game_matchstarttime", 0);
  setDvar("scr_game_roundstarttime", 0);
  setDvar("scr_trial_timelimit", 0);
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, level.gametype);
}

function ref_13D98(var_0, var_1) {
  level notify("exitLevel_called");
  processlobbydata();

  if(isDefined(level.ref_13D32)) {
    [[level.ref_13D32]]();
  }

  if(getomnvar("ui_trial_reward_tier") >= 1) {
    setomnvar("ui_trial_reward_received", 1);
    setomnvar("ui_trial_failed", 0);

    if(getDvar("LOQKLRKQMO") != "1") {
      wait 0.1;
      level.player openmenu("RoundEndTeamHud");
      wait 3;
    }
  }

  exitlevel(0);
}

function trial_mission_data_init() {
  var_0 = _tablethide::ref_13D42();
  var_1 = getdvarint("bg_trial_mission_id", 0);

  if(var_1 == 0) {
    var_2 = tablelookup(var_0, 2, getDvar("mapname"), 0);

    if(var_2 != "") {
      var_1 = var_2;
    } else {
      return;
    }
  }

  level.trial["missionID"] = int(var_1);
  level.trial["zone"] = tablelookup(var_0, 0, level.trial["missionID"], 2);
  level.trial["missionScript"] = tablelookup(var_0, 0, level.trial["missionID"], 3);
  level.trial["variant"] = tablelookup(var_0, 0, level.trial["missionID"], 4);
  level.trial["team"] = tablelookup(var_0, 0, level.trial["missionID"], 5);
  level.trial["scoreType"] = tablelookup(var_0, 0, level.trial["missionID"], 6);
  level.trial["tier1"] = int(tablelookup(var_0, 0, level.trial["missionID"], 8));
  level.trial["tier2"] = int(tablelookup(var_0, 0, level.trial["missionID"], 9));
  level.trial["tier3"] = int(tablelookup(var_0, 0, level.trial["missionID"], 10));
  level.trial["attempts"] = int(tablelookup(var_0, 0, level.trial["missionID"], 11));
  level.trial["compassMaterialOverride"] = tablelookup(var_0, 0, level.trial["missionID"], 18);
  level.trial["playerDataId"] = int(tablelookup(var_0, 0, level.trial["missionID"], 20));

  if(level.trial["zone"] != getDvar("mapname")) {}

  setomnvar("ui_trial_mission_score_is_time", level.trial["scoreType"] == "time");
  setomnvar("ui_trial_mission_id", level.trial["missionID"]);
  setomnvar("ui_trial_mission_player_data_id", level.trial["playerDataId"]);
  setomnvar("ui_trial_tier_1_requirement", level.trial["tier1"]);
  setomnvar("ui_trial_tier_2_requirement", level.trial["tier2"]);
  setomnvar("ui_trial_tier_3_requirement", level.trial["tier3"]);
}

function getspawnpoint() {
  while(istrue(level.ref_13D6A)) {
    waitframe();
  }

  var_0 = "mp_trial_spawn";
  var_1 = scripts\mp\spawnlogic::getspawnpointarray(var_0);
  var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);

  if(isDefined(level.ref_13D69)) {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(level.ref_13D69, 1);
    var_4 = spawnStruct();
    var_4.useonspawn = 1;
    var_4.enterstartwaitmsg = "spawned_player";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(level.ref_13D69, var_3[0], self, var_4);
    self.spawningintovehicle = 1;
  }

  return var_2;
}

function alwaysgamemodeclass() {
  return "gamemode";
}

function onplayerconnect(var_0) {
  var_0 thread scripts\mp\menus::addtoteam(level.trial["team"]);
  level.teamdata["allies"]["soundInfix"] = "uk";
  level.teamdata["axis"]["soundInfix"] = "ru";
  var_0 setclientomnvar("ui_skip_loadout", 1);
  var_0 setclientomnvar("ui_total_fade", 1);
  var_0.pers["class"] = "gamemode";
  var_0.pers["lastClass"] = "";
  var_0.class = var_0.pers["class"];
  var_0.lastclass = var_0.pers["lastClass"];

  if(isDefined(level.trial_map_loadout)) {
    var_0.pers["gamemodeLoadout"] = level.trial_map_loadout;
  } else {
    var_0.pers["gamemodeLoadout"] = level.trial_loadout["axis"];
  }

  if(istrue(level.trial_infinite_reserve_ammo)) {
    thread infinite_reserve_ammo();
  }

  thread trial_weapon_spawn();
  level waittill("player_spawned");

  if(level.players.size > 1) {
    exitlevel(0);
  }

  level.player scripts\mp\gametypes\br::ref_1254D();
  wait 1;
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_0, 0, 0.5);

  if(game["trial"]["tries_remaining"] < level.trial["attempts"]) {
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer("trial_retry");
  } else if(getDvar("mapname") == getDvar("old_mapname", "")) {
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer("trial_intro_short");
  } else {
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer("trial_intro");
  }

  setDvar("old_mapname", getDvar("mapname"));
  thread ref_13D5F();
}

function setspecialloadout() {
  level.trial_loadout["axis"]["loadoutPrimary"] = "iw8_fists";
  level.trial_loadout["axis"]["loadoutPrimaryAttachment"] = "none";
  level.trial_loadout["axis"]["loadoutPrimaryAttachment2"] = "none";
  level.trial_loadout["axis"]["loadoutPrimaryCamo"] = "none";
  level.trial_loadout["axis"]["loadoutPrimaryReticle"] = "none";
  level.trial_loadout["axis"]["loadoutSecondary"] = "none";
  level.trial_loadout["axis"]["loadoutSecondaryAttachment"] = "none";
  level.trial_loadout["axis"]["loadoutSecondaryAttachment2"] = "none";
  level.trial_loadout["axis"]["loadoutSecondaryCamo"] = "none";
  level.trial_loadout["axis"]["loadoutSecondaryReticle"] = "none";
  level.trial_loadout["axis"]["loadoutEquipment"] = "specialty_null";
  level.trial_loadout["axis"]["loadoutOffhand"] = "none";
  level.trial_loadout["axis"]["loadoutStreakType"] = "assault";
  level.trial_loadout["axis"]["loadoutKillstreak1"] = "none";
  level.trial_loadout["axis"]["loadoutKillstreak2"] = "none";
  level.trial_loadout["axis"]["loadoutKillstreak3"] = "none";
  level.trial_loadout["axis"]["loadoutPerks"] = [];
  level.trial_loadout["axis"]["loadoutGesture"] = "playerData";
  var_0 = getEnt("trial_starting_weapon", "script_noteworthy");
  var_1 = getEnt("trial_starting_weapon_2", "script_noteworthy");

  if(isDefined(var_0)) {
    var_2 = strtok(var_0.script_parameters, "+");
    var_3 = var_2[0];
    var_4 = scripts\engine\utility::array_remove(var_2, var_3);
    level.trial_loadout["axis"]["loadoutPrimary"] = var_3;

    foreach(var_8, var_6 in var_4) {
      if(!var_8) {
        level.trial_loadout["axis"]["loadoutPrimaryAttachment"] = var_6;
        continue;
      }

      var_7 = "loadoutPrimaryAttachment" + var_8 + 1;
      level.trial_loadout["axis"][var_7] = var_6;
    }
  }

  if(isDefined(var_1)) {
    var_2 = strtok(var_1.script_parameters, "+");
    var_3 = var_2[0];
    var_4 = scripts\engine\utility::array_remove(var_2, var_3);
    level.trial_loadout["axis"]["loadoutSecondary"] = var_3;

    foreach(var_6 in var_4) {
      if(!var_8) {
        level.trial_loadout["axis"]["loadoutSecondaryAttachment"] = var_6;
        continue;
      }

      var_7 = "loadoutSecondaryAttachment" + var_8 + 1;
      level.trial_loadout["axis"][var_7] = var_6;
    }
  }

  level.trial_loadout["allies"] = level.trial_loadout["axis"];
}

function infinite_reserve_ammo() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload");
    self givemaxammo(self.currentprimaryweapon);
  }
}

function trial_weapon_spawn() {
  level.trial_weapons = getEntArray("trial_weapon", "targetname");
  level.trial_akimbo_props = getEntArray("trial_weapon_akimbo_prop", "targetname");

  while(!isDefined(level.weaponmapdata)) {
    waitframe();
  }

  waitframe();

  foreach(var_1 in level.trial_weapons) {
    thread weapon_think();
  }
}

function weapon_think() {
  level.player endon("death");
  [var_1] = strtok(self.script_parameters, "+");
  var_2 = scripts\engine\utility::array_remove(var_0, var_1);
  var_3 = scripts\cp_mp\utility\game_utility::isnightmap();
  var_4 = scripts\mp\utility\weapon::weaponassetnamemap(var_1);
  var_5 = getcompleteweaponname(var_4);
  var_6 = [];
  var_7 = 0;

  foreach(var_9 in var_2) {
    var_10 = scripts\mp\utility\weapon::attachmentmap_tounique(var_9, var_4);

    if(var_5 canuseattachment(var_10)) {
      if(var_9 == "akimbo") {
        var_7 = 1;
      }

      var_6 = var_9;
    }
  }

  var_2 = var_6;
  var_12 = scripts\mp\class::buildweapon(var_1, var_2, "none", "none", -1, undefined, undefined, undefined, var_3);
  var_13 = createheadicon(var_12);

  if(var_7) {
    thread weapon_akimbo_prop_think(var_13);
  }

  for(;;) {
    jumpiftrue(isDefined(level.player.primaryinventory[0])) LOC_000000d8;
    waitframe();
  }

  for(;;) {
    var_14 = 0;
    var_15 = 0;

    if(isDefined(level.player.primaryinventory[0])) {
      var_14 = var_13 == createheadicon(level.player.primaryinventory[0]);
    }

    if(isDefined(level.player.primaryinventory[1])) {
      var_15 = var_13 == createheadicon(level.player.primaryinventory[1]);
    }

    if(!isDefined(self.spawned_weapon) && !var_14 && !var_15) {
      self.spawned_weapon = spawn("weapon_" + var_13, self.origin, 17);
      self.spawned_weapon.angles = self.angles;
      var_16 = weaponclipsize(var_12);
      var_17 = weaponmaxammo(var_12);

      if(isDefined(self.script_noteworthy)) {
        if(self.script_noteworthy == "outline") {
          scripts\mp\utility\outline::outlineenableforplayer(self.spawned_weapon, level.player, "outline_trial_item", "level_script");
        } else if(self.script_noteworthy == "osp") {
          scripts\mp\utility\outline::outlineenableforplayer(self.spawned_weapon, level.player, "outlinefill_nodepth_cyan", "level_script");
          var_17 = 0;
        }
      }

      if(var_7) {
        var_16 = 0;
      }

      if(istrue(level.ref_124C9)) {
        var_17 = level.enemiestotal - var_16;
      }

      self.spawned_weapon itemweaponsetammo(var_16, var_17);
    }

    level.player waittill("weapon_dropped", var_18, var_19);

    if(createheadicon(var_19) == var_13) {
      var_18 delete();
    }
  }
}

function weapon_akimbo_prop_think(var_0) {
  foreach(var_2 in level.trial_akimbo_props) {
    if(var_2.script_parameters == self.script_parameters) {
      self.akimbo_prop = var_2;
    }
  }

  while(isDefined(self.akimbo_prop)) {
    while(!isDefined(self.spawned_weapon)) {
      waitframe();
    }

    self.akimbo_prop.spawned_prop = spawn("weapon_" + var_0, self.akimbo_prop.origin, 17);
    self.akimbo_prop.spawned_prop.angles = self.akimbo_prop.angles;
    self.akimbo_prop.spawned_prop sethintinoperable(1);

    while(isDefined(self.spawned_weapon)) {
      waitframe();
    }

    if(isDefined(self.akimbo_prop.spawned_prop)) {
      self.akimbo_prop.spawned_prop delete();
    }
  }
}

function trial_end_score_dialogue() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = getomnvar("ui_trial_main_score");
  var_4 = getomnvar("ui_trial_main_time");

  if(var_3 != -1) {
    var_0 = var_3 >= getomnvar("ui_trial_tier_1_requirement");
    var_1 = var_3 >= getomnvar("ui_trial_tier_2_requirement");
    var_2 = var_3 >= getomnvar("ui_trial_tier_3_requirement");
  } else if(var_4 != -1) {
    var_0 = var_4 <= getomnvar("ui_trial_tier_1_requirement");
    var_1 = var_4 <= getomnvar("ui_trial_tier_2_requirement");
    var_2 = var_4 <= getomnvar("ui_trial_tier_3_requirement");
  }

  if(istrue(level.trial_fail_alt)) {
    level.trial_fail_alt = 0;
    var_5 = "trial_end_tier_0_alt";
  } else if(var_3) {
    var_5 = "trial_end_tier_3";
  } else if(var_3) {
    var_5 = "trial_end_tier_2";
  } else if(var_3) {
    var_5 = "trial_end_tier_1";
  } else {
    var_5 = "trial_end_tier_0";
  }

  level.player scripts\mp\utility\dialog::leaderdialogonplayer(var_5);
  _tablethide::trial_ui_waittill_retry();

  if(!istrue(level.ref_13D60)) {
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("trial_retry");
    return;
  }
}

function ref_13D61() {
  if(!isDefined(game["trial"])) {
    game["trial"] = [];
  }

  if(!isDefined(game["trial"]["best_score"])) {
    game["trial"]["best_score"] = -1;
  }

  if(!isDefined(game["trial"]["best_time"])) {
    game["trial"]["best_time"] = -1;
  }

  if(!isDefined(game["trial"]["tries_remaining"])) {
    game["trial"]["tries_remaining"] = level.trial["attempts"];
  }

  setomnvar("ui_trial_best_score", int(game["trial"]["best_score"]));
  setomnvar("ui_trial_best_time", int(game["trial"]["best_time"]));
  setomnvar("ui_trial_tries_remaining", int(game["trial"]["tries_remaining"]));
}

function ref_13D5F() {
  for(;;) {
    level.player waittill("luinotifyserver", var_0);

    if(var_0 == "trial_restart") {
      if(!isDefined(level.unset_stay_at_spawn_flag_on_entering_combat) || !level.unset_stay_at_spawn_flag_on_entering_combat) {
        _tablethide::ref_13D5E();
      }
    }
  }
}

function processlobbydata() {
  ref_128AF(level.player);

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch()) {
    setclientmatchdata("isPublicMatch", 1);
  } else {
    setclientmatchdata("isPublicMatch", 0);
  }

  sendclientmatchdata();
}

function ref_128AF(var_0) {
  if(istrue(var_0.ref_128AF)) {
    return;
  }

  var_0.ref_128AF = 1;

  if(isDefined(var_0) && !isDefined(var_0.clientmatchdataid)) {
    var_0.clientmatchdataid = level.initship;
    level.initship++;
  }

  var_1 = var_0.name;
  setclientmatchdata("players", var_0.clientmatchdataid, "clanTag", var_0 getclantag());
  setclientmatchdata("players", var_0.clientmatchdataid, "xuidHigh", var_0 getxuidhigh());
  setclientmatchdata("players", var_0.clientmatchdataid, "xuidLow", var_0 getxuidlow());
  setclientmatchdata("players", var_0.clientmatchdataid, "isBot", isbot(var_0));
  setclientmatchdata("players", var_0.clientmatchdataid, "uniqueClientId", var_0.clientid);
  setclientmatchdata("players", var_0.clientmatchdataid, "username", var_1);

  if(var_0 isps4player()) {
    setclientmatchdata("players", var_0.clientmatchdataid, "platform", "ps4");
  } else if(var_0 isxb3player()) {
    setclientmatchdata("players", var_0.clientmatchdataid, "platform", "xb3");
  } else if(var_0 ispcplayer()) {
    setclientmatchdata("players", var_0.clientmatchdataid, "platform", "bnet");
  } else {
    setclientmatchdata("players", var_0.clientmatchdataid, "platform", "none");
  }

  var_0 setplayerdata("common", "round", "clientMatchIndex", var_0.clientmatchdataid);
}