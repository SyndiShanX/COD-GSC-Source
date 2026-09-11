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
  ref_13d61();
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
    setDvar("LNSMSSTTSK", 1);
  }

  setDvar("ai_enable_execution_victim", 0);
  setDvar("scr_game_matchstarttime", 0);
  setDvar("scr_game_roundstarttime", 0);
  setDvar("scr_trial_timelimit", 0);
  var0 = [];
  GscBinSkip0(0x2e, var0.size, level.gametype);
}

function ref_13d98(var0, var1) {
  level notify("exitLevel_called");
  processlobbydata();

  if(isDefined(level.ref_13d32)) {
    [[level.ref_13d32]]();
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
  var0 = _tablethide::ref_13d42();
  var1 = getdvarint("LTTRKNNKTQ", 0);

  if(var1 == 0) {
    var2 = tablelookup(var0, 2, getDvar("mapname"), 0);

    if(var2 != "") {
      var1 = var2;
    } else {
      return;
    }
  }

  level.trial["missionID"] = int(var1);
  level.trial["zone"] = tablelookup(var0, 0, level.trial["missionID"], 2);
  level.trial["missionScript"] = tablelookup(var0, 0, level.trial["missionID"], 3);
  level.trial["variant"] = tablelookup(var0, 0, level.trial["missionID"], 4);
  level.trial["team"] = tablelookup(var0, 0, level.trial["missionID"], 5);
  level.trial["scoreType"] = tablelookup(var0, 0, level.trial["missionID"], 6);
  level.trial["tier1"] = int(tablelookup(var0, 0, level.trial["missionID"], 8));
  level.trial["tier2"] = int(tablelookup(var0, 0, level.trial["missionID"], 9));
  level.trial["tier3"] = int(tablelookup(var0, 0, level.trial["missionID"], 10));
  level.trial["attempts"] = int(tablelookup(var0, 0, level.trial["missionID"], 11));
  level.trial["compassMaterialOverride"] = tablelookup(var0, 0, level.trial["missionID"], 18);
  level.trial["playerDataId"] = int(tablelookup(var0, 0, level.trial["missionID"], 20));

  if(level.trial["zone"] != getDvar("mapname")) {}

  setomnvar("ui_trial_mission_score_is_time", level.trial["scoreType"] == "time");
  setomnvar("ui_trial_mission_id", level.trial["missionID"]);
  setomnvar("ui_trial_mission_player_data_id", level.trial["playerDataId"]);
  setomnvar("ui_trial_tier_1_requirement", level.trial["tier1"]);
  setomnvar("ui_trial_tier_2_requirement", level.trial["tier2"]);
  setomnvar("ui_trial_tier_3_requirement", level.trial["tier3"]);
}

function getspawnpoint() {
  while(istrue(level.ref_13d6a)) {
    waitframe();
  }

  var0 = "mp_trial_spawn";
  var1 = scripts\mp\spawnlogic::getspawnpointarray(var0);
  var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);

  if(isDefined(level.ref_13d69)) {
    var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(level.ref_13d69, 1);
    var4 = spawnStruct();
    var4.useonspawn = 1;
    var4.enterstartwaitmsg = "spawned_player";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(level.ref_13d69, var3[0], self, var4);
    self.spawningintovehicle = 1;
  }

  return var2;
}

function alwaysgamemodeclass() {
  return "gamemode";
}

function onplayerconnect(var0) {
  var0 thread scripts\mp\menus::addtoteam(level.trial["team"]);
  level.teamdata["allies"]["soundInfix"] = "uk";
  level.teamdata["axis"]["soundInfix"] = "ru";
  var0 setclientomnvar("ui_skip_loadout", 1);
  var0 setclientomnvar("ui_total_fade", 1);
  var0.pers["class"] = "gamemode";
  var0.pers["lastClass"] = "";
  var0.class = var0.pers["class"];
  var0.lastclass = var0.pers["lastClass"];

  if(isDefined(level.trial_map_loadout)) {
    var0.pers["gamemodeLoadout"] = level.trial_map_loadout;
  } else {
    var0.pers["gamemodeLoadout"] = level.trial_loadout["axis"];
  }

  if(istrue(level.trial_infinite_reserve_ammo)) {
    thread infinite_reserve_ammo();
  }

  thread trial_weapon_spawn();
  level waittill("player_spawned");

  if(level.players.size > 1) {
    exitlevel(0);
  }

  level.player scripts\mp\gametypes\br::ref_1254d();
  wait 1;
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var0, 0, 0.5);

  if(game["trial"]["tries_remaining"] < level.trial["attempts"]) {
    var0 scripts\mp\utility\dialog::leaderdialogonplayer("trial_retry");
  } else if(getDvar("mapname") == getDvar("old_mapname", "")) {
    var0 scripts\mp\utility\dialog::leaderdialogonplayer("trial_intro_short");
  } else {
    var0 scripts\mp\utility\dialog::leaderdialogonplayer("trial_intro");
  }

  setDvar("old_mapname", getDvar("mapname"));
  thread ref_13d5f();
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
  var0 = getEnt("trial_starting_weapon", "script_noteworthy");
  var1 = getEnt("trial_starting_weapon_2", "script_noteworthy");

  if(isDefined(var0)) {
    var2 = strtok(var0.script_parameters, "+");
    var3 = var2[0];
    var4 = scripts\engine\utility::array_remove(var2, var3);
    level.trial_loadout["axis"]["loadoutPrimary"] = var3;

    foreach(var8, var6 in var4) {
      if(!var8) {
        level.trial_loadout["axis"]["loadoutPrimaryAttachment"] = var6;
        continue;
      }

      var7 = "loadoutPrimaryAttachment" + var8 + 1;
      level.trial_loadout["axis"][var7] = var6;
    }
  }

  if(isDefined(var1)) {
    var2 = strtok(var1.script_parameters, "+");
    var3 = var2[0];
    var4 = scripts\engine\utility::array_remove(var2, var3);
    level.trial_loadout["axis"]["loadoutSecondary"] = var3;

    foreach(var6 in var4) {
      if(!var8) {
        level.trial_loadout["axis"]["loadoutSecondaryAttachment"] = var6;
        continue;
      }

      var7 = "loadoutSecondaryAttachment" + var8 + 1;
      level.trial_loadout["axis"][var7] = var6;
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

  foreach(var1 in level.trial_weapons) {
    thread weapon_think();
  }
}

function weapon_think() {
  level.player endon("death");
  [var1] = strtok(self.script_parameters, "+");
  var2 = scripts\engine\utility::array_remove(var0, var1);
  var3 = scripts\cp_mp\utility\game_utility::isnightmap();
  var4 = scripts\mp\utility\weapon::weaponassetnamemap(var1);
  var5 = getcompleteweaponname(var4);
  var6 = [];
  var7 = 0;

  foreach(var9 in var2) {
    var10 = scripts\mp\utility\weapon::attachmentmap_tounique(var9, var4);

    if(var5 canuseattachment(var10)) {
      if(var9 == "akimbo") {
        var7 = 1;
      }

      var6 = var9;
    }
  }

  var2 = var6;
  var12 = scripts\mp\class::buildweapon(var1, var2, "none", "none", -1, undefined, undefined, undefined, var3);
  var13 = createheadicon(var12);

  if(var7) {
    thread weapon_akimbo_prop_think(var13);
  }

  for(;;) {
    jumpiftrue(isDefined(level.player.primaryinventory[0])) LOC_000000d8;
    waitframe();
  }

  for(;;) {
    var14 = 0;
    var15 = 0;

    if(isDefined(level.player.primaryinventory[0])) {
      var14 = var13 == createheadicon(level.player.primaryinventory[0]);
    }

    if(isDefined(level.player.primaryinventory[1])) {
      var15 = var13 == createheadicon(level.player.primaryinventory[1]);
    }

    if(!isDefined(self.spawned_weapon) && !var14 && !var15) {
      self.spawned_weapon = spawn("weapon_" + var13, self.origin, 17);
      self.spawned_weapon.angles = self.angles;
      var16 = weaponclipsize(var12);
      var17 = weaponmaxammo(var12);

      if(isDefined(self.script_noteworthy)) {
        if(self.script_noteworthy == "outline") {
          scripts\mp\utility\outline::outlineenableforplayer(self.spawned_weapon, level.player, "outline_trial_item", "level_script");
        } else if(self.script_noteworthy == "osp") {
          scripts\mp\utility\outline::outlineenableforplayer(self.spawned_weapon, level.player, "outlinefill_nodepth_cyan", "level_script");
          var17 = 0;
        }
      }

      if(var7) {
        var16 = 0;
      }

      if(istrue(level.ref_124c9)) {
        var17 = level.enemiestotal - var16;
      }

      self.spawned_weapon itemweaponsetammo(var16, var17);
    }

    level.player waittill("weapon_dropped", var18, var19);

    if(createheadicon(var19) == var13) {
      var18 delete();
    }
  }
}

function weapon_akimbo_prop_think(var0) {
  foreach(var2 in level.trial_akimbo_props) {
    if(var2.script_parameters == self.script_parameters) {
      self.akimbo_prop = var2;
    }
  }

  while(isDefined(self.akimbo_prop)) {
    while(!isDefined(self.spawned_weapon)) {
      waitframe();
    }

    self.akimbo_prop.spawned_prop = spawn("weapon_" + var0, self.akimbo_prop.origin, 17);
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
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = getomnvar("ui_trial_main_score");
  var4 = getomnvar("ui_trial_main_time");

  if(var3 != -1) {
    var0 = var3 >= getomnvar("ui_trial_tier_1_requirement");
    var1 = var3 >= getomnvar("ui_trial_tier_2_requirement");
    var2 = var3 >= getomnvar("ui_trial_tier_3_requirement");
  } else if(var4 != -1) {
    var0 = var4 <= getomnvar("ui_trial_tier_1_requirement");
    var1 = var4 <= getomnvar("ui_trial_tier_2_requirement");
    var2 = var4 <= getomnvar("ui_trial_tier_3_requirement");
  }

  if(istrue(level.trial_fail_alt)) {
    level.trial_fail_alt = 0;
    var5 = "trial_end_tier_0_alt";
  } else if(var3) {
    var5 = "trial_end_tier_3";
  } else if(var3) {
    var5 = "trial_end_tier_2";
  } else if(var3) {
    var5 = "trial_end_tier_1";
  } else {
    var5 = "trial_end_tier_0";
  }

  level.player scripts\mp\utility\dialog::leaderdialogonplayer(var5);
  _tablethide::trial_ui_waittill_retry();

  if(!istrue(level.ref_13d60)) {
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("trial_retry");
    return;
  }
}

function ref_13d61() {
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

function ref_13d5f() {
  for(;;) {
    level.player waittill("luinotifyserver", var0);

    if(var0 == "trial_restart") {
      if(!isDefined(level.unset_stay_at_spawn_flag_on_entering_combat) || !level.unset_stay_at_spawn_flag_on_entering_combat) {
        _tablethide::ref_13d5e();
      }
    }
  }
}

function processlobbydata() {
  ref_128af(level.player);

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch()) {
    setclientmatchdata("isPublicMatch", 1);
  } else {
    setclientmatchdata("isPublicMatch", 0);
  }

  sendclientmatchdata();
}

function ref_128af(var0) {
  if(istrue(var0.ref_128af)) {
    return;
  }

  var0.ref_128af = 1;

  if(isDefined(var0) && !isDefined(var0.clientmatchdataid)) {
    var0.clientmatchdataid = level.initship;
    level.initship++;
  }

  var1 = var0.name;
  setclientmatchdata("players", var0.clientmatchdataid, "clanTag", var0 getclantag());
  setclientmatchdata("players", var0.clientmatchdataid, "xuidHigh", var0 getxuidhigh());
  setclientmatchdata("players", var0.clientmatchdataid, "xuidLow", var0 getxuidlow());
  setclientmatchdata("players", var0.clientmatchdataid, "isBot", isbot(var0));
  setclientmatchdata("players", var0.clientmatchdataid, "uniqueClientId", var0.clientid);
  setclientmatchdata("players", var0.clientmatchdataid, "username", var1);

  if(var0 isps4player()) {
    setclientmatchdata("players", var0.clientmatchdataid, "platform", "ps4");
  } else if(var0 isxb3player()) {
    setclientmatchdata("players", var0.clientmatchdataid, "platform", "xb3");
  } else if(var0 ispcplayer()) {
    setclientmatchdata("players", var0.clientmatchdataid, "platform", "bnet");
  } else {
    setclientmatchdata("players", var0.clientmatchdataid, "platform", "none");
  }

  var0 setplayerdata("common", "round", "clientMatchIndex", var0.clientmatchdataid);
}