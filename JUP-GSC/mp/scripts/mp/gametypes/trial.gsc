/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\trial.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\compass;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\menus;
#using scripts\mp\spawnlogic;
#using scripts\mp\trials\mp_trials_patches;
#using scripts\mp\trials\trial_enemy_sentry_turret;
#using scripts\mp\trials\trial_utility;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#namespace trial;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  flag_init("strike_init_done");
  trial_mission_data_init();
  trial_retrieve_persistent_values();
  scripts\mp\trials\mp_trials_patches::init_trial_patches();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    setcommonrulesfrommatchrulesdata();
  } else {
    setdynamicdvar(@ "hash_127490a7577f169f", 0);
    setdynamicdvar(@ "hash_a54edeed7c5b587f", 0);
  }

  if(issubstr(getDvar(@ "g_mapname"), "mp_t_")) {
    setDvar(@ "scr_game_enableminimap", 0);
  }

  if(getDvar(@ "hash_a1767cfd7ede043b") == "1") {
    setDvar(@ "hash_4d8ed5d95d54900a", 1);
  } else {
    setDvar(@ "hash_ec7061888c9ec27f", 1);
  }

  setDvar(@ "hash_84bca47b0009d424", 0);
  setDvar(@ "scr_game_matchstarttime", 0);
  setDvar(@ "hash_da33635b62d4e5b3", 0);
  setDvar(@ "hash_9a6a321c990cec4e", 0);

  setDvar(@ "hash_3f36284b49b3d7a", 0);

  allowed = [];
  allowed[allowed.size] = level.gametype;
  allowed[allowed.size] = "trial_variant_" + level.trial["variant"];
  allowed[allowed.size] = "trial_mission_" + level.trial["missionScript"];
  allowed[allowed.size] = "t_variant_" + level.trial["variant"];
  allowed[allowed.size] = "t_mission_" + level.trial["missionScript"];

  if(trial_is_event()) {
    allowed[allowed.size] = "t_event";
  }

  switch (level.trial["missionScript"]) {
    case #"hash_5dfce04e1af9553":
    case #"hash_20d4a490009a1ff8":
      allowed[allowed.size] = "arm";
      break;
    default:
      break;
  }

  level.allowed_gametypes = allowed;
  scripts\mp\gameobjects::main(allowed);
  scripts\mp\utility\game::registerroundswitchdvar(level.gametype, 0, 0, 9);
  scripts\mp\utility\game::registertimelimitdvar(level.gametype, 0);
  scripts\mp\utility\game::registerscorelimitdvar(level.gametype, 0);
  scripts\mp\utility\game::registerroundlimitdvar(level.gametype, 1);
  scripts\mp\utility\game::registerwinlimitdvar(level.gametype, 1);
  scripts\mp\utility\game::registernumlivesdvar(level.gametype, 0);
  scripts\mp\utility\game::registerhalftimedvar(level.gametype, 0);
  setspecialloadout();
  scripts\mp\gametypes\common::updatecommongametypedvars();
  scripts\cp_mp\parachute::initparachutedvars();
  level.supportintel = 0;
  level.supportnuke = 0;
  level.disablespawncamera = 1;
  level.teambased = 1;
  level.challengesallowed = 0;
  level.getspawnpoint = &getspawnpoint;
  level.onplayerconnect = &onplayerconnect;
  level.bypassclasschoicefunc = &scripts\mp\class::alwaysgamemodeclass;
  level.endgame = &trialendgame;

  if(level.scripted_spawner_func.size) {
    level.starttime = 0;

    while(!isDefined(level.struct_class_names)) {
      waitframe();
    }

    foreach(index, func in level.scripted_spawner_func) {
      [[func]](1, "cs" + index);
    }

    foreach(struct in level.cs_object_container) {
      foreach(object in struct.objects) {
        if(isent(object) && isDefined(object.struct.script_gameobjectname)) {
          var_265d16014b56096d = 0;

          foreach(name in allowed) {
            if(object.struct.script_gameobjectname == name) {
              var_265d16014b56096d = 1;
            }
          }

          if(!var_265d16014b56096d) {
            object delete();
          }
        }
      }
    }
  }

  while(!isDefined(level.trial_missionscript_init_funcs)) {
    waitframe();
  }

  if(isDefined(level.trial["triggeredTrialName"])) {
    switch (level.trial["missionScript"]) {
      case #"hash_3303663b5c9c9d6c":
      case #"hash_fb5b5e6c07253005":
        thread[[level.trial_missionscript_init_funcs["gun"]]](level.trial["triggeredTrialName"]);
        break;
      case #"hash_e9d9fcb8daba8602":
        thread[[level.trial_missionscript_init_funcs["clear"]]]();
        break;
      case #"hash_6191aaef9f922f96":
        thread[[level.trial_missionscript_init_funcs["sniper"]]](level.trial["triggeredTrialName"]);
        break;
      case #"hash_c2e89d8135aae861":
        thread[[level.trial_missionscript_init_funcs["gunslinger"]]]();
        break;
      case #"hash_6d20826c437003d8":
        thread[[level.trial_missionscript_init_funcs["tdm"]]]();
        break;
      default:
        break;
    }
  } else {
    switch (level.trial["missionScript"]) {
      case #"hash_3303663b5c9c9d6c":
      case #"hash_fb5b5e6c07253005":
        thread[[level.trial_missionscript_init_funcs["gun"]]]();
        break;
      case #"hash_e9d9fcb8daba8602":
        thread[[level.trial_missionscript_init_funcs["clear"]]]();
        break;
      case #"hash_6191aaef9f922f96":
        thread[[level.trial_missionscript_init_funcs["sniper"]]]();
        break;
      case #"hash_9196025f8ae8e51e":
        thread[[level.trial_missionscript_init_funcs["jugg"]]]();
        break;
      case #"hash_aae08c3a072df6bb":
        thread[[level.trial_missionscript_init_funcs["lava"]]]();
        break;
      case #"hash_9cda66e2792cde2a":
        thread[[level.trial_missionscript_init_funcs["pitcher"]]]();
        break;
      case #"hash_c2e89d8135aae861":
        thread[[level.trial_missionscript_init_funcs["gunslinger"]]]();
        break;
      case #"hash_20d4a490009a1ff8":
        thread[[level.trial_missionscript_init_funcs["race"]]]();
        break;
      case #"hash_5dfce04e1af9553":
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

  function_2e9e80d411685c12();
}

function trialendgame(winner, endreasontext) {
  level notify("exitLevel_called");
  processlobbydata();

  if(isDefined(level.trial_dlog_func)) {
    [[level.trial_dlog_func]]();
  }

  if(getomnvar("ui_trial_reward_tier") >= 1) {
    setomnvar("ui_trial_reward_received", 1);
    setomnvar("ui_trial_failed", 0);

    if(getDvar(@ "hash_a1767cfd7ede043b") != "1") {
      wait 0.1;
      level.player openmenu("RoundEndTeamHud");
      wait 3;
    }
  }

  exitlevel(0);
}

function trial_mission_data_init() {
  mission_table = trial_fetch_mission_table();
  assert(tableexists(mission_table));
  missionid = getdvarint(@ "hash_b93f834a6e6a8b21", 0);

  if(missionid == 0) {
    fallbackid = tablelookup(mission_table, 2, getDvar(@ "g_mapname"), 0);

    if(fallbackid != "") {
      println("<dev string:x1c>" + fallbackid + "<dev string:x56>" + getDvar(@ "g_mapname"));
      missionid = fallbackid;
    } else {
      assertmsg("<dev string:x79>" + getDvar(@ "g_mapname") + "<dev string:xe7>");
      return;
    }
  }

  level.trial["missionID"] = int(missionid);
  level.trial["zone"] = tablelookup(mission_table, 0, level.trial["missionID"], 2);
  level.trial["missionScript"] = tablelookup(mission_table, 0, level.trial["missionID"], 3);
  level.trial["variant"] = tablelookup(mission_table, 0, level.trial["missionID"], 4);
  level.trial["team"] = tablelookup(mission_table, 0, level.trial["missionID"], 5);
  level.trial["scoreType"] = tablelookup(mission_table, 0, level.trial["missionID"], 6);
  level.trial["tier1"] = int(tablelookup(mission_table, 0, level.trial["missionID"], 8));
  level.trial["tier2"] = int(tablelookup(mission_table, 0, level.trial["missionID"], 9));
  level.trial["tier3"] = int(tablelookup(mission_table, 0, level.trial["missionID"], 10));
  level.trial["attempts"] = int(tablelookup(mission_table, 0, level.trial["missionID"], 11));
  level.trial["compassMaterialOverride"] = tablelookup(mission_table, 0, level.trial["missionID"], 18);
  level.trial["playerDataId"] = int(tablelookup(mission_table, 0, level.trial["missionID"], 20));

  if(level.trial["zone"] != getDvar(@ "g_mapname")) {
    assertmsg("<dev string:x106>" + getDvar(@ "g_mapname") + "<dev string:x119>" + level.trial["<dev string:x137>"] + "<dev string:x144>" + level.trial["<dev string:x153>"] + "<dev string:x15b>");
  }

  setomnvar("ui_trial_mission_score_is_time", level.trial["scoreType"] == "time");
  setomnvar("ui_trial_mission_id", level.trial["missionID"]);
  setomnvar("ui_trial_mission_player_data_id", level.trial["playerDataId"]);
  setomnvar("ui_trial_tier_1_requirement", level.trial["tier1"]);
  setomnvar("ui_trial_tier_2_requirement", level.trial["tier2"]);
  setomnvar("ui_trial_tier_3_requirement", level.trial["tier3"]);
}

function function_72965bdb36677ee9(missionid) {
  mission_table = trial_fetch_mission_table();
  assert(tableexists(mission_table));

  if(missionid == 0) {
    fallbackid = tablelookup(mission_table, 2, getDvar(@ "g_mapname"), 0);

    if(fallbackid != "") {
      println("<dev string:x1c>" + fallbackid + "<dev string:x56>" + getDvar(@ "g_mapname"));
      missionid = fallbackid;
    } else {
      assertmsg("<dev string:x79>" + getDvar(@ "g_mapname") + "<dev string:xe7>");
      return;
    }
  }

  level.trial["missionID"] = int(missionid);
  level.trial["zone"] = tablelookup(mission_table, 0, level.trial["missionID"], 2);
  level.trial["missionScript"] = tablelookup(mission_table, 0, level.trial["missionID"], 3);
  level.trial["variant"] = tablelookup(mission_table, 0, level.trial["missionID"], 4);
  level.trial["team"] = tablelookup(mission_table, 0, level.trial["missionID"], 5);
  level.trial["scoreType"] = tablelookup(mission_table, 0, level.trial["missionID"], 6);
  level.trial["tier1"] = int(tablelookup(mission_table, 0, level.trial["missionID"], 8));
  level.trial["tier2"] = int(tablelookup(mission_table, 0, level.trial["missionID"], 9));
  level.trial["tier3"] = int(tablelookup(mission_table, 0, level.trial["missionID"], 10));
  level.trial["attempts"] = int(tablelookup(mission_table, 0, level.trial["missionID"], 11));
  level.trial["compassMaterialOverride"] = tablelookup(mission_table, 0, level.trial["missionID"], 18);
  level.trial["playerDataId"] = int(tablelookup(mission_table, 0, level.trial["missionID"], 20));

  if(level.trial["zone"] != getDvar(@ "g_mapname")) {
    assertmsg("<dev string:x106>" + getDvar(@ "g_mapname") + "<dev string:x119>" + level.trial["<dev string:x137>"] + "<dev string:x144>" + level.trial["<dev string:x153>"] + "<dev string:x15b>");
  }

  setomnvar("ui_trial_mission_score_is_time", level.trial["scoreType"] == "time");
  setomnvar("ui_trial_mission_id", level.trial["missionID"]);
  setomnvar("ui_trial_mission_player_data_id", level.trial["playerDataId"]);
  setomnvar("ui_trial_tier_1_requirement", level.trial["tier1"]);
  setomnvar("ui_trial_tier_2_requirement", level.trial["tier2"]);
  setomnvar("ui_trial_tier_3_requirement", level.trial["tier3"]);
}

function getspawnpoint() {
  while(istrue(level.trial_spawn_wait)) {
    waitframe();
  }

  spawnpointname = "mp_trial_spawn";
  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray(spawnpointname);
  assert(spawnpoints.size);
  spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn(spawnpoints);

  if(isDefined(level.trial_spawn_vehicle)) {
    seat = scripts\cp_mp\vehicles\vehicle_occupancy::function_d3d95972f58ad2bc(level.trial_spawn_vehicle);
    data = spawnStruct();
    data.useonspawn = 1;
    data.enterstartwaitmsg = "spawned_player";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(level.trial_spawn_vehicle, seat, self, data);
    self.spawningintovehicle = 1;
  }

  return spawnpoint;
}

function onplayerconnect(player) {
  if(utility::is_trial("tdm")) {
    if(isbot(player)) {
      return;
    }
  }

  player thread scripts\mp\menus::addtoteam(level.trial["team"]);
  level.teamdata["allies"]["soundInfix"] = "uk";
  level.teamdata["axis"]["soundInfix"] = "ru";
  player scripts\mp\class::function_a16868d4dcd81a4b();
  player setclientomnvar("ui_total_fade", 1);

  if(isDefined(level.trial_map_loadout)) {
    player.pers["gamemodeLoadout"] = level.trial_map_loadout;
  } else {
    player.pers["gamemodeLoadout"] = level.trial_loadout["axis"];
  }

  if(istrue(level.trial_infinite_reserve_ammo)) {
    player thread infinite_reserve_ammo();
  }

  thread trial_weapon_spawn();
  level waittill("player_spawned");

  if(level.players.size > 1) {
    println("<dev string:x160>");
    exitlevel(0);
  }

  level.player scripts\mp\gametypes\br::playerexecutionsdisable();
  wait 1;
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.5);

  if(game["trial"]["tries_remaining"] < level.trial["attempts"]) {
    player scripts\mp\utility\dialog::leaderdialogonplayer("trial_retry");
  } else if(getDvar(@ "g_mapname") == getDvar(@ "old_mapname", "")) {
    player scripts\mp\utility\dialog::leaderdialogonplayer("trial_intro_short");
  } else {
    player scripts\mp\utility\dialog::leaderdialogonplayer("trial_intro");
  }

  setDvar(@ "old_mapname", getDvar(@ "g_mapname"));
  thread trial_restart_watcher();
}

function setspecialloadout() {
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
  var_9309e04671262786 = getEnt("trial_starting_weapon", "script_noteworthy");
  var_226dd676a3cf59cb = getEnt("trial_starting_weapon_2", "script_noteworthy");

  if(isDefined(var_9309e04671262786)) {
    weap_tokens = strtok(var_9309e04671262786.script_parameters, "+");
    var_51b7953d0e3a6f82 = weap_tokens[0];
    weap_attachments = array_remove(weap_tokens, var_51b7953d0e3a6f82);
    level.trial_loadout["axis"]["loadoutPrimary"] = var_51b7953d0e3a6f82;

    foreach(i, attachment in weap_attachments) {
      if(!i) {
        level.trial_loadout["axis"]["loadoutPrimaryAttachment"] = attachment;
        continue;
      }

      key = "loadoutPrimaryAttachment" + i + 1;
      level.trial_loadout["axis"][key] = attachment;
    }
  }

  if(isDefined(var_226dd676a3cf59cb)) {
    weap_tokens = strtok(var_226dd676a3cf59cb.script_parameters, "+");
    var_51b7953d0e3a6f82 = weap_tokens[0];
    weap_attachments = array_remove(weap_tokens, var_51b7953d0e3a6f82);
    level.trial_loadout["axis"]["loadoutSecondary"] = var_51b7953d0e3a6f82;

    foreach(i, attachment in weap_attachments) {
      if(!i) {
        level.trial_loadout["axis"]["loadoutSecondaryAttachment"] = attachment;
        continue;
      }

      key = "loadoutSecondaryAttachment" + i + 1;
      level.trial_loadout["axis"][key] = attachment;
    }
  }

  level.trial_loadout["allies"] = level.trial_loadout["axis"];
}

function infinite_reserve_ammo() {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
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

  foreach(weapon in level.trial_weapons) {
    weapon thread weapon_think();
  }

  strid = tablelookup(trial_fetch_mission_table(), 0, level.trial["<dev string:x137>"], 1);

  if(strid == "<dev string:x199>") {
    println("<dev string:x19d>");
    return;
  }

  println("<dev string:x219>");
  println("<dev string:x199>");
  print(strid);

  foreach(weap in level.trial_weapons) {
    if(isDefined(weap.spawned_weapon)) {
      str = getsubstr(weap.spawned_weapon.classname, 7);
      print("<dev string:x277>" + str);
    }
  }

  println("<dev string:x199>");
}

function weapon_think() {
  level.player endon("death");
  weap_tokens = strtok(self.script_parameters, "+");
  var_51b7953d0e3a6f82 = weap_tokens[0];
  weap_attachments = array_remove(weap_tokens, var_51b7953d0e3a6f82);
  hasnvg = scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4();
  basename = scripts\cp_mp\weapon::weaponassetnamemap(var_51b7953d0e3a6f82);
  weapobj = makeweapon(basename);
  attachmentsvalid = [];
  has_akimbo = 0;

  foreach(a in weap_attachments) {
    if(weapobj canuseattachment(a)) {
      if(a == "akimbo") {
        has_akimbo = 1;
      }

      attachmentsvalid[attachmentsvalid.size] = a;
      continue;
    }

    assertmsg("<dev string:x27c>" + a + "<dev string:x294>" + basename);
  }

  weap_attachments = attachmentsvalid;
  built_weapon = scripts\cp_mp\weapon::buildweapon(var_51b7953d0e3a6f82, weap_attachments, "none", "none", -1, undefined, undefined, undefined, hasnvg);
  weapon_name = getcompleteweaponname(built_weapon);

  if(has_akimbo) {
    thread weapon_akimbo_prop_think(weapon_name);
  }

  while(!isDefined(level.player.primaryinventory[0])) {
    waitframe();
  }

  while(true) {
    var_caf3a434dc6e3312 = 0;
    var_caf3a534dc6e3545 = 0;

    if(isDefined(level.player.primaryinventory[0])) {
      var_caf3a434dc6e3312 = weapon_name == getcompleteweaponname(level.player.primaryinventory[0]);
    }

    if(isDefined(level.player.primaryinventory[1])) {
      var_caf3a534dc6e3545 = weapon_name == getcompleteweaponname(level.player.primaryinventory[1]);
    }

    if(!isDefined(self.spawned_weapon) && !var_caf3a434dc6e3312 && !var_caf3a534dc6e3545) {
      self.spawned_weapon = spawn("weapon_" + weapon_name, self.origin, 17);
      self.spawned_weapon.angles = self.angles;
      clip_ammo = weaponclipsize(built_weapon);
      reserve_ammo = weaponmaxammo(built_weapon);

      if(isDefined(self.script_noteworthy)) {
        if(self.script_noteworthy == "outline") {
          scripts\mp\utility\outline::outlineenableforplayer(self.spawned_weapon, level.player, "outline_trial_item", "level_script");
        } else if(self.script_noteworthy == "osp") {
          scripts\mp\utility\outline::outlineenableforplayer(self.spawned_weapon, level.player, "outlinefill_nodepth_cyan", "level_script");
          reserve_ammo = 0;
        }
      }

      if(has_akimbo) {
        clip_ammo = 0;
      }

      if(istrue(level.player_limitedammo)) {
        reserve_ammo = level.enemiestotal - clip_ammo;
      }

      self.spawned_weapon itemweaponsetammo(clip_ammo, reserve_ammo);
    }

    level.player waittill("weapon_dropped", droppedent, objweapon);

    if(isDefined(droppedent) && isDefined(objweapon) && getcompleteweaponname(objweapon) == weapon_name) {
      droppedent delete();
    }
  }
}

function weapon_akimbo_prop_think(weapon_name) {
  foreach(prop in level.trial_akimbo_props) {
    if(prop.script_parameters == self.script_parameters) {
      self.akimbo_prop = prop;
    }
  }

  while(isDefined(self.akimbo_prop)) {
    while(!isDefined(self.spawned_weapon)) {
      waitframe();
    }

    self.akimbo_prop.spawned_prop = spawn("weapon_" + weapon_name, self.akimbo_prop.origin, 17);
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
  var_a14d1d7d5339e7fe = undefined;
  var_a14d1c7d5339e5cb = undefined;
  var_a14d1b7d5339e398 = undefined;
  main_score = getomnvar("ui_trial_main_score");
  main_time = getomnvar("ui_trial_main_time");

  if(main_score != -1) {
    var_a14d1d7d5339e7fe = main_score >= getomnvar("ui_trial_tier_1_requirement");
    var_a14d1c7d5339e5cb = main_score >= getomnvar("ui_trial_tier_2_requirement");
    var_a14d1b7d5339e398 = main_score >= getomnvar("ui_trial_tier_3_requirement");
  } else if(main_time != -1) {
    var_a14d1d7d5339e7fe = main_time <= getomnvar("ui_trial_tier_1_requirement");
    var_a14d1c7d5339e5cb = main_time <= getomnvar("ui_trial_tier_2_requirement");
    var_a14d1b7d5339e398 = main_time <= getomnvar("ui_trial_tier_3_requirement");
  }

  if(istrue(level.trial_fail_alt)) {
    level.trial_fail_alt = 0;
    dialog = "trial_end_tier_0_alt";
  } else if(var_a14d1b7d5339e398) {
    dialog = "trial_end_tier_3";
  } else if(var_a14d1c7d5339e5cb) {
    dialog = "trial_end_tier_2";
  } else if(var_a14d1d7d5339e7fe) {
    dialog = "trial_end_tier_1";
  } else {
    dialog = "trial_end_tier_0";
  }

  level.player scripts\mp\utility\dialog::leaderdialogonplayer(dialog);
  trial_ui_waittill_retry();

  if(!istrue(level.trial_restarting)) {
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("trial_retry");
  }
}

function trial_retrieve_persistent_values() {
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

function trial_restart_watcher() {
  while(true) {
    level.player waittill("luinotifyserver", msg);

    if(msg == "trial_restart") {
      if(!isDefined(level.isinrewardflow) || !level.isinrewardflow) {
        trial_restart();
      }
    }
  }
}

function processlobbydata() {
  processlobbydataforclient(level.player);

  if(matchmakinggame() && !privatematch()) {
    setclientmatchdata("isPublicMatch", 1);
  } else {
    setclientmatchdata("isPublicMatch", 0);
  }

  sendclientmatchdata();
}

function processlobbydataforclient(player) {
  if(istrue(player.processlobbydataforclient)) {
    return;
  }

  player.processlobbydataforclient = 1;

  if(isDefined(player) && !isDefined(player.clientmatchdataid)) {
    player.clientmatchdataid = level.currentclientmatchdataid;
    level.currentclientmatchdataid++;
  }

  playername = player.name;
  setclientmatchdata("players", player.clientmatchdataid, "clanTag", player getclantag());
  setclientmatchdata("players", player.clientmatchdataid, "xuidHigh", player getxuidhigh());
  setclientmatchdata("players", player.clientmatchdataid, "xuidLow", player getxuidlow());
  setclientmatchdata("players", player.clientmatchdataid, "isBot", isbot(player));
  setclientmatchdata("players", player.clientmatchdataid, "uniqueClientId", player.clientid);
  setclientmatchdata("players", player.clientmatchdataid, "username", playername);

  if(player isps4player()) {
    setclientmatchdata("players", player.clientmatchdataid, "platform", "ps4");
  } else if(player isxb3player()) {
    setclientmatchdata("players", player.clientmatchdataid, "platform", "xb3");
  } else if(player ispcplayer()) {
    setclientmatchdata("players", player.clientmatchdataid, "platform", "bnet");
  } else {
    setclientmatchdata("players", player.clientmatchdataid, "platform", "none");
  }

  player setplayerdata("common", "round", "clientMatchIndex", player.clientmatchdataid);
}

function function_2e9e80d411685c12() {
  thread function_c27ed1f1252188f8();
}

function function_c27ed1f1252188f8() {
  setdevdvarifuninitialized(@ "hash_8b4dddca0bda590f", -1);

  while(true) {
    force_tier = getdvarint(@ "hash_8b4dddca0bda590f", -1);

    if(force_tier != -1) {
      function_7bd94570d05ebf80(force_tier);
    }

    waitframe();
  }
}

# /