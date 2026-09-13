/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\trial.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\engine\utility::flag_init("strike_init_done");
  trial_mission_data_init();
  trial_retrieve_persistent_values();
  scripts\mp\trials\mp_trials_patches::init_trial_patches();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(isusingmatchrulesdata())
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  else {
    setdynamicdvar("dvar_127490A7577F169F", 0);
    setdynamicdvar("scr_game_onlyheadshots", 0);
  }

  if(issubstr(getDvar("g_mapname"), "mp_t_"))
    setDvar("scr_game_enableMinimap", 0);

  if(getDvar("bg_trial_mission_is_event") == "1")
    setDvar("dvar_4D8ED5D95D54900A", 1);
  else
    setDvar("lui_trial_ending", 1);

  setDvar("dvar_84BCA47B0009D424", 0);
  setDvar("scr_game_matchstarttime", 0);
  setDvar("scr_game_roundstarttime", 0);
  setDvar("dvar_9A6A321C990CEC4E", 0);
  _id_9BBACB179DEA3237 = [];
  _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = level.gametype;
  _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = "trial_variant_" + level.trial["variant"];
  _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = "trial_mission_" + level.trial["missionScript"];
  _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = "t_variant_" + level.trial["variant"];
  _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = "t_mission_" + level.trial["missionScript"];

  if(scripts\mp\trials\trial_utility::trial_is_event())
    _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = "t_event";

  switch (level.trial["missionScript"]) {
    case "arm_course":
    case "race":
      _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = "arm";
      break;
    default:
      break;
  }

  level.allowed_gametypes = _id_9BBACB179DEA3237;
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);
  scripts\mp\utility\game::registerroundswitchdvar(level.gametype, 0, 0, 9);
  scripts\mp\utility\game::registertimelimitdvar(level.gametype, 0);
  scripts\mp\utility\game::registerscorelimitdvar(level.gametype, 0);
  scripts\mp\utility\game::registerroundlimitdvar(level.gametype, 1);
  scripts\mp\utility\game::registerwinlimitdvar(level.gametype, 1);
  scripts\mp\utility\game::registernumlivesdvar(level.gametype, 0);
  scripts\mp\utility\game::registerhalftimedvar(level.gametype, 0);
  setspecialloadout();
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  scripts\cp_mp\parachute::initparachutedvars();
  level.supportintel = 0;
  level.supportnuke = 0;
  level.disablespawncamera = 1;
  level.teambased = 1;
  level.challengesallowed = 0;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerconnect = ::onplayerconnect;
  level.bypassclasschoicefunc = scripts\mp\class::alwaysgamemodeclass;
  level.endgame = ::trialendgame;

  if(level.scripted_spawner_func.size) {
    level.starttime = 0;

    while(!isDefined(level.struct_class_names))
      waitframe();

    foreach(index, func in level.scripted_spawner_func)[[func]](1, "cs" + index);

    foreach(struct in level.cs_object_container) {
      foreach(object in struct.objects) {
        if(isent(object) && isDefined(object.struct.script_gameobjectname)) {
          _id_265D16014B56096D = 0;

          foreach(name in _id_9BBACB179DEA3237) {
            if(object.struct.script_gameobjectname == name)
              _id_265D16014B56096D = 1;
          }

          if(!_id_265D16014B56096D)
            object delete();
        }
      }
    }
  }

  while(!isDefined(level.trial_missionscript_init_funcs))
    waitframe();

  if(isDefined(level.trial["triggeredTrialName"])) {
    switch (level.trial["missionScript"]) {
      case "gun_nonlinear":
      case "gun":
        thread[[level.trial_missionscript_init_funcs["gun"]]](level.trial["triggeredTrialName"]);
        break;
      case "clear":
        thread[[level.trial_missionscript_init_funcs["clear"]]]();
        break;
      case "sniper":
        thread[[level.trial_missionscript_init_funcs["sniper"]]](level.trial["triggeredTrialName"]);
        break;
      case "gunslinger":
        thread[[level.trial_missionscript_init_funcs["gunslinger"]]]();
        break;
      case "tdm":
        thread[[level.trial_missionscript_init_funcs["tdm"]]]();
        break;
      default:
        break;
    }
  } else {
    switch (level.trial["missionScript"]) {
      case "gun_nonlinear":
      case "gun":
        thread[[level.trial_missionscript_init_funcs["gun"]]]();
        break;
      case "clear":
        thread[[level.trial_missionscript_init_funcs["clear"]]]();
        break;
      case "sniper":
        thread[[level.trial_missionscript_init_funcs["sniper"]]]();
        break;
      case "jugg":
        thread[[level.trial_missionscript_init_funcs["jugg"]]]();
        break;
      case "lava":
        thread[[level.trial_missionscript_init_funcs["lava"]]]();
        break;
      case "pitcher":
        thread[[level.trial_missionscript_init_funcs["pitcher"]]]();
        break;
      case "gunslinger":
        thread[[level.trial_missionscript_init_funcs["gunslinger"]]]();
        break;
      case "race":
        thread[[level.trial_missionscript_init_funcs["race"]]]();
        break;
      case "arm_course":
        thread[[level.trial_missionscript_init_funcs["arm_course"]]]();
        break;
      default:
        break;
    }
  }

  scripts\mp\trials\trial_enemy_sentry_turret::init();

  if(level.trial["compassMaterialOverride"] != "") {
    waitframe();
    scripts\mp\compass::setupminimap(level.trial["compassMaterialOverride"]);
  }
}

trialendgame(winner, _id_F0500919D8C387B9) {
  level notify("exitLevel_called");
  processlobbydata();

  if(isDefined(level.trial_dlog_func))
    [[level.trial_dlog_func]]();

  if(getomnvar("ui_trial_reward_tier") >= 1) {
    setomnvar("ui_trial_reward_received", 1);
    setomnvar("ui_trial_failed", 0);

    if(getDvar("bg_trial_mission_is_event") != "1") {
      wait 0.1;
      level.player openmenu("RoundEndTeamHud");
      wait 3;
    }
  }

  exitlevel(0);
}

trial_mission_data_init() {
  _id_6FED165AC80BC702 = scripts\mp\trials\trial_utility::trial_fetch_mission_table();
  missionid = getdvarint("bg_trial_mission_id", 0);

  if(missionid == 0) {
    _id_6AE64D9896AEF8F2 = tablelookup(_id_6FED165AC80BC702, 2, getDvar("g_mapname"), 0);

    if(_id_6AE64D9896AEF8F2 != "")
      missionid = _id_6AE64D9896AEF8F2;
    else
      return;
  }

  level.trial["missionID"] = int(missionid);
  level.trial["zone"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 2);
  level.trial["missionScript"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 3);
  level.trial["variant"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 4);
  level.trial["team"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 5);
  level.trial["scoreType"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 6);
  level.trial["tier1"] = int(tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 8));
  level.trial["tier2"] = int(tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 9));
  level.trial["tier3"] = int(tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 10));
  level.trial["attempts"] = int(tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 11));
  level.trial["compassMaterialOverride"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 18);
  level.trial["playerDataId"] = int(tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 20));

  if(level.trial["zone"] != getDvar("g_mapname")) {}

  setomnvar("ui_trial_mission_score_is_time", level.trial["scoreType"] == "time");
  setomnvar("ui_trial_mission_id", level.trial["missionID"]);
  setomnvar("ui_trial_mission_player_data_id", level.trial["playerDataId"]);
  setomnvar("ui_trial_tier_1_requirement", level.trial["tier1"]);
  setomnvar("ui_trial_tier_2_requirement", level.trial["tier2"]);
  setomnvar("ui_trial_tier_3_requirement", level.trial["tier3"]);
}

_id_72965BDB36677EE9(missionid) {
  _id_6FED165AC80BC702 = scripts\mp\trials\trial_utility::trial_fetch_mission_table();

  if(missionid == 0) {
    _id_6AE64D9896AEF8F2 = tablelookup(_id_6FED165AC80BC702, 2, getDvar("g_mapname"), 0);

    if(_id_6AE64D9896AEF8F2 != "")
      missionid = _id_6AE64D9896AEF8F2;
    else
      return;
  }

  level.trial["missionID"] = int(missionid);
  level.trial["zone"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 2);
  level.trial["missionScript"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 3);
  level.trial["variant"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 4);
  level.trial["team"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 5);
  level.trial["scoreType"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 6);
  level.trial["tier1"] = int(tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 8));
  level.trial["tier2"] = int(tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 9));
  level.trial["tier3"] = int(tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 10));
  level.trial["attempts"] = int(tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 11));
  level.trial["compassMaterialOverride"] = tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 18);
  level.trial["playerDataId"] = int(tablelookup(_id_6FED165AC80BC702, 0, level.trial["missionID"], 20));

  if(level.trial["zone"] != getDvar("g_mapname")) {}

  setomnvar("ui_trial_mission_score_is_time", level.trial["scoreType"] == "time");
  setomnvar("ui_trial_mission_id", level.trial["missionID"]);
  setomnvar("ui_trial_mission_player_data_id", level.trial["playerDataId"]);
  setomnvar("ui_trial_tier_1_requirement", level.trial["tier1"]);
  setomnvar("ui_trial_tier_2_requirement", level.trial["tier2"]);
  setomnvar("ui_trial_tier_3_requirement", level.trial["tier3"]);
}

getspawnpoint() {
  while(istrue(level.trial_spawn_wait))
    waitframe();

  _id_700A871A46435669 = "mp_trial_spawn";
  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(_id_700A871A46435669);
  spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);

  if(isDefined(level.trial_spawn_vehicle)) {
    seat = scripts\cp_mp\vehicles\vehicle_occupancy::_id_D3D95972F58AD2BC(level.trial_spawn_vehicle);
    data = spawnStruct();
    data.useonspawn = 1;
    data.enterstartwaitmsg = "spawned_player";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(level.trial_spawn_vehicle, seat, self, data);
    self.spawningintovehicle = 1;
  }

  return spawnpoint;
}

onplayerconnect(player) {
  if(scripts\common\utility::_id_D5D0823D606A2A6E("tdm")) {
    if(isbot(player))
      return;
  }

  player thread scripts\mp\menus::addtoteam(level.trial["team"]);
  level.teamdata["allies"]["soundInfix"] = "uk";
  level.teamdata["axis"]["soundInfix"] = "ru";
  player scripts\mp\class::_id_A16868D4DCD81A4B();
  player setclientomnvar("ui_total_fade", 1);

  if(isDefined(level.trial_map_loadout))
    player.pers["gamemodeLoadout"] = level.trial_map_loadout;
  else
    player.pers["gamemodeLoadout"] = level.trial_loadout["axis"];

  if(istrue(level.trial_infinite_reserve_ammo))
    player thread infinite_reserve_ammo();

  thread trial_weapon_spawn();
  level waittill("player_spawned");

  if(level.players.size > 1)
    exitlevel(0);

  level.player _id_1E4A61DB11011446::playerexecutionsdisable();
  wait 1;
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.5);

  if(game["trial"]["tries_remaining"] < level.trial["attempts"])
    player scripts\mp\utility\dialog::leaderdialogonplayer("trial_retry");
  else if(getDvar("g_mapname") == getDvar("old_mapname", ""))
    player scripts\mp\utility\dialog::leaderdialogonplayer("trial_intro_short");
  else
    player scripts\mp\utility\dialog::leaderdialogonplayer("trial_intro");

  setDvar("old_mapname", getDvar("g_mapname"));
  thread trial_restart_watcher();
}

setspecialloadout() {
  level.trial_loadout["axis"]["loadoutPrimary"] = "iw9_me_fists";
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
  _id_9309E04671262786 = getEnt("trial_starting_weapon", "script_noteworthy");
  _id_226DD676A3CF59CB = getEnt("trial_starting_weapon_2", "script_noteworthy");

  if(isDefined(_id_9309E04671262786)) {
    _id_5660BEE41C94AF5F = strtok(_id_9309E04671262786.script_parameters, "+");
    _id_51B7953D0E3A6F82 = _id_5660BEE41C94AF5F[0];
    _id_116A551DC9D3C305 = scripts\engine\utility::array_remove(_id_5660BEE41C94AF5F, _id_51B7953D0E3A6F82);
    level.trial_loadout["axis"]["loadoutPrimary"] = _id_51B7953D0E3A6F82;

    foreach(_id_AC0E594AC96AA3A8, attachment in _id_116A551DC9D3C305) {
      if(!_id_AC0E594AC96AA3A8) {
        level.trial_loadout["axis"]["loadoutPrimaryAttachment"] = attachment;
        continue;
      }

      key = "loadoutPrimaryAttachment" + (_id_AC0E594AC96AA3A8 + 1);
      level.trial_loadout["axis"][key] = attachment;
    }
  }

  if(isDefined(_id_226DD676A3CF59CB)) {
    _id_5660BEE41C94AF5F = strtok(_id_226DD676A3CF59CB.script_parameters, "+");
    _id_51B7953D0E3A6F82 = _id_5660BEE41C94AF5F[0];
    _id_116A551DC9D3C305 = scripts\engine\utility::array_remove(_id_5660BEE41C94AF5F, _id_51B7953D0E3A6F82);
    level.trial_loadout["axis"]["loadoutSecondary"] = _id_51B7953D0E3A6F82;

    foreach(_id_AC0E594AC96AA3A8, attachment in _id_116A551DC9D3C305) {
      if(!_id_AC0E594AC96AA3A8) {
        level.trial_loadout["axis"]["loadoutSecondaryAttachment"] = attachment;
        continue;
      }

      key = "loadoutSecondaryAttachment" + (_id_AC0E594AC96AA3A8 + 1);
      level.trial_loadout["axis"][key] = attachment;
    }
  }

  level.trial_loadout["allies"] = level.trial_loadout["axis"];
}

infinite_reserve_ammo() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload");
    self givemaxammo(self.currentprimaryweapon);
  }
}

trial_weapon_spawn() {
  level.trial_weapons = getEntArray("trial_weapon", "targetname");
  level.trial_akimbo_props = getEntArray("trial_weapon_akimbo_prop", "targetname");

  while(!isDefined(level.weaponmapdata))
    waitframe();

  waitframe();

  foreach(weapon in level.trial_weapons)
  weapon thread weapon_think();
}

weapon_think() {
  level.player endon("death");
  _id_5660BEE41C94AF5F = strtok(self.script_parameters, "+");
  _id_51B7953D0E3A6F82 = _id_5660BEE41C94AF5F[0];
  _id_116A551DC9D3C305 = scripts\engine\utility::array_remove(_id_5660BEE41C94AF5F, _id_51B7953D0E3A6F82);
  _id_11A1FA68AEB971C0 = scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4();
  basename = _id_2669878CF5A1B6BC::weaponassetnamemap(_id_51B7953D0E3A6F82);
  _id_A7408DBFED49F3F9 = makeweapon(basename);
  _id_98A8134515DF9081 = [];
  _id_A1AE8FF6D228344D = 0;

  foreach(a in _id_116A551DC9D3C305) {
    if(_id_A7408DBFED49F3F9 canuseattachment(a)) {
      if(a == "akimbo")
        _id_A1AE8FF6D228344D = 1;

      _id_98A8134515DF9081[_id_98A8134515DF9081.size] = a;
      continue;
    }
  }

  _id_116A551DC9D3C305 = _id_98A8134515DF9081;
  _id_91C18F9D87634D94 = _id_2669878CF5A1B6BC::buildweapon(_id_51B7953D0E3A6F82, _id_116A551DC9D3C305, "none", "none", -1, undefined, undefined, undefined, _id_11A1FA68AEB971C0);
  weapon_name = getcompleteweaponname(_id_91C18F9D87634D94);

  if(_id_A1AE8FF6D228344D)
    thread weapon_akimbo_prop_think(weapon_name);

  while(!isDefined(level.player.primaryinventory[0]))
    waitframe();

  for(;;) {
    _id_CAF3A434DC6E3312 = 0;
    _id_CAF3A534DC6E3545 = 0;

    if(isDefined(level.player.primaryinventory[0]))
      _id_CAF3A434DC6E3312 = weapon_name == getcompleteweaponname(level.player.primaryinventory[0]);

    if(isDefined(level.player.primaryinventory[1]))
      _id_CAF3A534DC6E3545 = weapon_name == getcompleteweaponname(level.player.primaryinventory[1]);

    if(!isDefined(self.spawned_weapon) && !_id_CAF3A434DC6E3312 && !_id_CAF3A534DC6E3545) {
      self.spawned_weapon = spawn("weapon_" + weapon_name, self.origin, 17);
      self.spawned_weapon.angles = self.angles;
      clip_ammo = weaponclipsize(_id_91C18F9D87634D94);
      _id_59CF20581D014F8E = weaponmaxammo(_id_91C18F9D87634D94);

      if(isDefined(self.script_noteworthy)) {
        if(self.script_noteworthy == "outline")
          scripts\mp\utility\outline::outlineenableforplayer(self.spawned_weapon, level.player, "outline_trial_item", "level_script");
        else if(self.script_noteworthy == "osp") {
          scripts\mp\utility\outline::outlineenableforplayer(self.spawned_weapon, level.player, "outlinefill_nodepth_cyan", "level_script");
          _id_59CF20581D014F8E = 0;
        }
      }

      if(_id_A1AE8FF6D228344D)
        clip_ammo = 0;

      if(istrue(level.player_limitedammo))
        _id_59CF20581D014F8E = level.enemiestotal - clip_ammo;

      self.spawned_weapon itemweaponsetammo(clip_ammo, _id_59CF20581D014F8E);
    }

    level.player waittill("weapon_dropped", _id_47DCFBC98E2103EE, objweapon);

    if(isDefined(_id_47DCFBC98E2103EE) && isDefined(objweapon) && getcompleteweaponname(objweapon) == weapon_name)
      _id_47DCFBC98E2103EE delete();
  }
}

weapon_akimbo_prop_think(weapon_name) {
  foreach(prop in level.trial_akimbo_props) {
    if(prop.script_parameters == self.script_parameters)
      self.akimbo_prop = prop;
  }

  while(isDefined(self.akimbo_prop)) {
    while(!isDefined(self.spawned_weapon))
      waitframe();

    self.akimbo_prop.spawned_prop = spawn("weapon_" + weapon_name, self.akimbo_prop.origin, 17);
    self.akimbo_prop.spawned_prop.angles = self.akimbo_prop.angles;
    self.akimbo_prop.spawned_prop sethintinoperable(1);

    while(isDefined(self.spawned_weapon))
      waitframe();

    if(isDefined(self.akimbo_prop.spawned_prop))
      self.akimbo_prop.spawned_prop delete();
  }
}

trial_end_score_dialogue() {
  _id_A14D1D7D5339E7FE = undefined;
  _id_A14D1C7D5339E5CB = undefined;
  _id_A14D1B7D5339E398 = undefined;
  _id_76526F2B092D6A59 = getomnvar("ui_trial_main_score");
  _id_F642A654EDAF0A48 = getomnvar("ui_trial_main_time");

  if(_id_76526F2B092D6A59 != -1) {
    _id_A14D1D7D5339E7FE = _id_76526F2B092D6A59 >= getomnvar("ui_trial_tier_1_requirement");
    _id_A14D1C7D5339E5CB = _id_76526F2B092D6A59 >= getomnvar("ui_trial_tier_2_requirement");
    _id_A14D1B7D5339E398 = _id_76526F2B092D6A59 >= getomnvar("ui_trial_tier_3_requirement");
  } else if(_id_F642A654EDAF0A48 != -1) {
    _id_A14D1D7D5339E7FE = _id_F642A654EDAF0A48 <= getomnvar("ui_trial_tier_1_requirement");
    _id_A14D1C7D5339E5CB = _id_F642A654EDAF0A48 <= getomnvar("ui_trial_tier_2_requirement");
    _id_A14D1B7D5339E398 = _id_F642A654EDAF0A48 <= getomnvar("ui_trial_tier_3_requirement");
  }

  if(istrue(level.trial_fail_alt)) {
    level.trial_fail_alt = 0;
    dialog = "trial_end_tier_0_alt";
  } else if(_id_A14D1B7D5339E398)
    dialog = "trial_end_tier_3";
  else if(_id_A14D1C7D5339E5CB)
    dialog = "trial_end_tier_2";
  else if(_id_A14D1D7D5339E7FE)
    dialog = "trial_end_tier_1";
  else
    dialog = "trial_end_tier_0";

  level.player scripts\mp\utility\dialog::leaderdialogonplayer(dialog);
  scripts\mp\trials\trial_utility::trial_ui_waittill_retry();

  if(!istrue(level.trial_restarting))
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("trial_retry");
}

trial_retrieve_persistent_values() {
  if(!isDefined(game["trial"]))
    game["trial"] = [];

  if(!isDefined(game["trial"]["best_score"]))
    game["trial"]["best_score"] = -1;

  if(!isDefined(game["trial"]["best_time"]))
    game["trial"]["best_time"] = -1;

  if(!isDefined(game["trial"]["tries_remaining"]))
    game["trial"]["tries_remaining"] = level.trial["attempts"];

  setomnvar("ui_trial_best_score", int(game["trial"]["best_score"]));
  setomnvar("ui_trial_best_time", int(game["trial"]["best_time"]));
  setomnvar("ui_trial_tries_remaining", int(game["trial"]["tries_remaining"]));
}

trial_restart_watcher() {
  for(;;) {
    level.player waittill("luinotifyserver", msg);

    if(msg == "trial_restart") {
      if(!isDefined(level.isinrewardflow) || !level.isinrewardflow)
        scripts\mp\trials\trial_utility::trial_restart();
    }
  }
}

processlobbydata() {
  processlobbydataforclient(level.player);

  if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch())
    setclientmatchdata("isPublicMatch", 1);
  else
    setclientmatchdata("isPublicMatch", 0);

  sendclientmatchdata();
}

processlobbydataforclient(player) {
  if(istrue(player.processlobbydataforclient)) {
    return;
  }
  player.processlobbydataforclient = 1;

  if(isDefined(player) && !isDefined(player.clientmatchdataid)) {
    player.clientmatchdataid = level.currentclientmatchdataid;
    level.currentclientmatchdataid++;
  }

  _id_81A6DCF8641471F7 = player.name;
  setclientmatchdata("players", player.clientmatchdataid, "clanTag", player getclantag());
  setclientmatchdata("players", player.clientmatchdataid, "xuidHigh", player getxuidhigh());
  setclientmatchdata("players", player.clientmatchdataid, "xuidLow", player getxuidlow());
  setclientmatchdata("players", player.clientmatchdataid, "isBot", isbot(player));
  setclientmatchdata("players", player.clientmatchdataid, "uniqueClientId", player.clientid);
  setclientmatchdata("players", player.clientmatchdataid, "username", _id_81A6DCF8641471F7);

  if(player isps4player())
    setclientmatchdata("players", player.clientmatchdataid, "platform", "ps4");
  else if(player isxb3player())
    setclientmatchdata("players", player.clientmatchdataid, "platform", "xb3");
  else if(player ispcplayer())
    setclientmatchdata("players", player.clientmatchdataid, "platform", "bnet");
  else
    setclientmatchdata("players", player.clientmatchdataid, "platform", "none");

  player setplayerdata("common", "round", "clientMatchIndex", player.clientmatchdataid);
}