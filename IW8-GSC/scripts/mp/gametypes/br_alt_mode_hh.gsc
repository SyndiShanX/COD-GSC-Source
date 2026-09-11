/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_hh.gsc
***************************************************/

function spawn_and_enter_cargo_truck_mg() {
  thread airfield_safehouse_loot();
}

function airfield_safehouse_loot() {
  level.ref_13443["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  level.helidrivableenablesiteonflyaway["vanish"] = loadfx("vfx/iw8_br/island/gameplay/festferv/vfx_br_holiday_coal_dust_emit.vfx");
  level.helidrivableenablesiteonflyaway["screen"] = loadfx("vfx/iw8_br/island/gameplay/festferv/vfx_br_holiday_coal_imp_1st.vfx");
  level.ref_1207b = &airlock_show_back_doors;
  level.playerwaittospawn = &airlock_button_r;
  level._effect["vfx_br_loot_cache_holiday_coal"] = loadfx("vfx/iw8_br/island/gameplay/festferv/vfx_br_loot_cache_holiday_coal");

  if(!scripts\mp\flags::levelflag("scriptables_ready")) {
    scripts\mp\flags::levelflagwait("scriptables_ready");
  }

  airlock();
  var_0 = getdvarint("scr_br_alt_mode_hh", 0) == 1;

  if(!var_0) {
    return;
  }

  level.spawn_lot_paratroopers = 1;
  thread airdrop_givecrateuseweapon();
  var_1 = getdvarint("scr_br_hh_debug_SpawnTrees", 0) == 1;

  if(var_1) {
    level.spawn_and_enter_little_bird_mg = airduct_locations();
  } else {
    level.spawn_and_enter_little_bird_mg = airstrike_watchdeployweaponchange();
  }

  all_but_one_player_in_vehicle();
  var_2 = getdvarint("scr_br_hh_debug_SpawnCaches", 0) == 1;

  for(var_3 = 0; var_3 < level.spawn_and_enter_little_bird_mg.size; var_3++) {
    if(var_2) {
      airdropbasecashamount(var_3);
      continue;
    }

    airdrop_specialcasecanusecrate(var_3);
  }

  foreach(var_5 in level.spawn_and_enter_little_bird_mg) {
    thread airstrike_canbeused(level, var_5, 0, 1);
  }

  var_7 = getdvarint("scr_br_hh_wait_for_prematch", 1) == 1;

  if(var_7) {
    thread airholder();
  }

  thread airlock_callbutton_think();
  scripts\engine\scriptable::ref_12f5b("brloot_coal", &airdrop_playdeploydialog);
  scripts\engine\scriptable::ref_12f5b("brloot_snowball", &airstrike_movewithplane);
}

function airlock_callbutton_think() {
  level endon("game_ended");

  for(;;) {
    level waittill("br_circle_set");

    if(!isDefined(level.spawn_and_enter_little_bird_mg)) {
      continue;
    }

    foreach(var_1 in level.spawn_and_enter_little_bird_mg) {
      all_modes(var_1.ref_13d19);
    }
  }
}

function airdrop_givecrateuseweapon() {
  scripts\mp\utility\sound::besttime("br_mode_holiday_hunt");
}

function airlock_slot_think(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = getdvarint("scr_br_hh_tree_blacklist_" + var_1, 0) == 1;

    if(var_2) {
      var_0[var_1].complete_hack_console = 1;
    }
  }

  for(var_1 = var_0.size - 1; var_1 >= 0; var_1--) {
    if(istrue(var_0[var_1].complete_hack_console)) {
      var_0 = scripts\engine\utility::can_path_to_target(var_0, var_1);
    }
  }

  var_3 = getdvarint("scr_br_hh_num_trees", 6);
  var_3 = min(var_3, var_0.size);
  var_4 = [];
  var_5 = scripts\engine\utility::array_randomize(var_0);

  for(var_1 = 0; var_1 < var_3; var_1++) {
    var_4 = var_5[var_1];
  }

  return var_4;
}

function airlock() {
  airlock_stop("hidden", "br_deckthehalls_cache_common");
  airlock_stop("hidden", "br_deckthehalls_cache_legendary");
  airlock_stop("hidden", "br_deckthehalls_cache_holiday");
}

function airlock_stop(var_0, var_1) {
  var_2 = getentitylessscriptablearrayinradius(var_1, "script_noteworthy");

  foreach(var_4 in var_2) {
    var_4 setscriptablepartstate("body", var_0, 0);
  }
}

function airdrop_specialcasecanusecrate(var_0) {
  var_1 = level.spawn_and_enter_little_bird_mg[var_0].origin;
  var_2 = 5000;
  level.spawn_and_enter_little_bird_mg[var_0].hideintelinstancefromplayer = getentitylessscriptablearrayinradius("br_deckthehalls_cache_common", "script_noteworthy", var_1, var_2);
  level.spawn_and_enter_little_bird_mg[var_0].waypoints_creation = getentitylessscriptablearrayinradius("br_deckthehalls_cache_legendary", "script_noteworthy", var_1, var_2);
  level.spawn_and_enter_little_bird_mg[var_0].spawn_lootcrates_on_each_traincar = getentitylessscriptablearrayinradius("br_deckthehalls_cache_holiday", "script_noteworthy", var_1, var_2);
  var_3 = 5;
  var_4 = 5;
  var_5 = 10;
  airlock_back_blocker(level.spawn_and_enter_little_bird_mg[var_0].hideintelinstancefromplayer, var_0, var_3);
  airlock_back_blocker(level.spawn_and_enter_little_bird_mg[var_0].waypoints_creation, var_0, var_4);
  airlock_back_blocker(level.spawn_and_enter_little_bird_mg[var_0].spawn_lootcrates_on_each_traincar, var_0, var_5);
}

function airlock_back_blocker(var_0, var_1, var_2) {
  var_3 = randomint(var_2);

  foreach(var_5 in var_0) {
    var_3++;
    var_3 %= var_2;
    var_5.spawn_maint_wave = var_1;
    var_5.ref_11a25 = var_3;
  }
}

function airstrike_watchdeployweaponchange() {
  var_0 = scripts\engine\utility::getStructArray("br_deckthehalls_tree", "script_noteworthy");
  var_1 = airlock_slot_think(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = airstrike_removeactivestrike(var_4.origin);
    var_2 = var_5;
  }

  return var_2;
}

function airholder() {
  var_0 = getdvarint("scr_br_hh_wait_for_prematch", 1) == 1;

  if(var_0) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  var_1 = 6;
  wait var_1;
  var_2 = 1;

  for(var_3 = 0; var_3 < level.spawn_and_enter_little_bird_mg.size; var_3++) {
    airstrike_addactivestrike(level.spawn_and_enter_little_bird_mg[var_3], var_2);
    thread airstrike_canbeused(level, level.spawn_and_enter_little_bird_mg[var_3], var_2, 1);
    level.spawn_and_enter_little_bird_mg[var_3] setscriptablepartstate("dom_circle", "white", 0);
    level.spawn_and_enter_little_bird_mg[var_3].ref_13d19 scripts\mp\gametypes\br_gulag::calloutmarkerping_watchwhenobjectivedeleted(1);
  }
}

function airduct_locations() {
  var_0 = [];
  var_1 = (-1852, -1253, 0);
  var_2 = airstrike_removeactivestrike(var_1);
  var_0 = var_2;
  var_1 = (-1859, -3900, 0);
  var_2 = airstrike_removeactivestrike(var_1);
  var_0 = var_2;
  return var_0;
}

function airstrike_removeactivestrike(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("lm_christmas_tree_large_set_01");
  var_1.unset_relic_noregen = 1;
  return var_1;
}

function airdropbasecashamount(var_0) {
  level.spawn_and_enter_little_bird_mg[var_0].hideintelinstancefromplayer = [];
  level.spawn_and_enter_little_bird_mg[var_0].waypoints_creation = [];
  level.spawn_and_enter_little_bird_mg[var_0].spawn_lootcrates_on_each_traincar = [];
  var_1 = [];
  GscBinSkip0(0x2e, 0, (100, 0, 0));
}

function spawn_allies_at_defend(var_0, var_1, var_2, var_3) {
  var_4 = easepower(var_0, var_1, var_2);
  return var_4;
}

function airstrike_addactivestrike(var_0, var_1) {
  if(istrue(var_0.stopdragonsbreathburning)) {
    var_1 = 0;
  }

  var_0.ref_13a12 = var_1;

  switch (var_1) {
    case 0:
      var_0 setscriptablepartstate("tacmap", "hidden", 0);
      break;
    case 1:
      var_0 setscriptablepartstate("tacmap", "level_one", 0);
      break;
    case 2:
      var_0 setscriptablepartstate("tacmap", "level_two", 0);
      break;
    case 3:
      var_0 setscriptablepartstate("tacmap", "level_three", 0);
      break;
  }
}

function airstrike_canbeused(var_0, var_1, var_2, var_3) {
  var_0 notify("newTreeSettings");
  var_0 endon("newTreeSettings");
  var_0.ref_13d1b = var_1;
  wait var_3;
  airdrop_watchforcrateuseend("Setting tree to level: " + var_1 + " refreshing crates: " + var_2);

  if(isDefined(var_0.ref_13d19.claimplayer)) {
    scripts\mp\gametypes\br_analytics::destroy_vehicles(var_0.ref_13d19.claimplayer, var_1);
  }

  switch (var_1) {
    case 0:
      var_0 setscriptablepartstate("vfx_one_shot", "hidden", 0);
      var_0 setscriptablepartstate("tree", "hidden", 0);
      var_0 setscriptablepartstate("decorations", "hidden", 0);
      var_0 setscriptablepartstate("star", "hidden", 0);
      var_0 setscriptablepartstate("presents", "hidden", 0);

      if(!istrue(var_0.ref_12744)) {
        var_0 setscriptablepartstate("lights_off", "hidden", 0);
        var_0 setscriptablepartstate("lights_on", "hidden", 0);
      }

      break;
    case 1:
      var_0 setscriptablepartstate("vfx_one_shot", "hidden", 0);
      var_0 setscriptablepartstate("tree", "visible", 0);
      var_0 setscriptablepartstate("decorations", "hidden", 0);
      var_0 setscriptablepartstate("star", "hidden", 0);
      var_0 setscriptablepartstate("presents", "hidden", 0);

      if(!istrue(var_0.ref_12744)) {
        var_0 setscriptablepartstate("lights_off", "hidden", 0);
        var_0 setscriptablepartstate("lights_on", "hidden", 0);
      }

      break;
    case 2:
      var_0 setscriptablepartstate("tree", "visible", 0);
      var_0 setscriptablepartstate("decorations", "visible", 0);
      var_0 setscriptablepartstate("star", "hidden", 0);
      var_0 setscriptablepartstate("presents", "hidden", 0);

      if(!istrue(var_0.ref_12744)) {
        var_0 setscriptablepartstate("lights_off", "visible", 0);
        var_0 setscriptablepartstate("lights_on", "hidden", 0);
      }

      break;
    case 3:
      var_0 setscriptablepartstate("tree", "visible", 0);
      var_0 setscriptablepartstate("decorations", "visible", 0);
      var_0 setscriptablepartstate("star", "visible", 0);
      var_0 setscriptablepartstate("presents", "visible", 0);

      if(!istrue(var_0.ref_12744)) {
        var_0 setscriptablepartstate("lights_off", "visible", 0);
        var_0 setscriptablepartstate("lights_on", "visible", 0);
      }

      break;
  }

  if(var_2) {
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;

    switch (var_1) {
      case 0:
        var_4 = "hidden";
        var_5 = "hidden";
        var_6 = "hidden";
        break;
      case 1:
        var_4 = "closed";
        var_5 = "hidden";
        var_6 = "hidden";
        break;
      case 2:
        var_4 = "hidden";
        var_5 = "closed";
        var_6 = "hidden";
        break;
      case 3:
        var_4 = "hidden";
        var_5 = "hidden";
        var_6 = "closed";
        break;
    }

    foreach(var_8 in var_0.hideintelinstancefromplayer) {
      var_8 setscriptablepartstate("body", var_4, 0);
    }

    foreach(var_8 in var_0.waypoints_creation) {
      var_8 setscriptablepartstate("body", var_5, 0);
    }

    foreach(var_8 in var_0.spawn_lootcrates_on_each_traincar) {
      var_8 setscriptablepartstate("body", var_6, 0);
    }

    return;
  }
}

function all_but_one_player_in_vehicle() {
  var_0 = getdvarint("scr_br_hh_tree_dom_radius", 250);
  var_1 = getdvarint("scr_br_hh_tree_dom_height", 100);
  var_2 = getdvarint("scr_br_dom_quest_capture_time", 30);
  var_3 = var_2 * 2;

  if(getdvarint("scr_br_hh_dom_duration_override", 0) != 0) {
    var_3 = getdvarint("scr_br_hh_dom_duration_override", 30);
  }

  for(var_4 = 0; var_4 < level.spawn_and_enter_little_bird_mg.size; var_4++) {
    var_5 = level.spawn_and_enter_little_bird_mg[var_4].origin;
    var_6 = spawn("trigger_radius", var_5, 0, var_0, var_1);
    var_6.ref_13dc7 = [];
    var_7 = scripts\mp\gametypes\obj_dom::setupobjective(var_6, "neutral");
    var_7.ref_13d1a = var_4;
    var_6.ref_13d19 = var_7;
    var_7.onuse = &aitype_counts;
    var_7.onbeginuse = &all_alive_players;
    var_7.onuseupdate = &all_alive_players_entities;
    var_7.onenduse = &all_alive_players_entites;
    var_7.ref_128b9 = &all_but_one_player_downed;
    var_7.ref_12079 = &alertforspawngroupdirection;
    var_7.oncontested = &alcove_trig;
    var_7.onuncontested = &alivejuggernauts;
    var_7.forest_barrels = &airstrikebetweentwopoints;
    var_7.gate_swings_open = 1;
    var_7.id = "domFlag";
    var_7.pinobj = 0;
    var_7.lockupdatingicons = 1;
    var_7 scripts\mp\gameobjects::setcapturebehavior("normal");
    var_7 scripts\mp\gameobjects::setusetime(var_3);
    scripts\mp\objidpoolmanager::update_objective_setneutrallabel(var_7.objidnum, "");
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_7.objidnum);
    var_7.flagmodel delete();
    var_7.flagmodel = undefined;
    var_7.outlineent = undefined;
    var_7.visibilitymanuallycontrolled = 1;
    var_7 scripts\mp\gametypes\br_gulag::calloutmarkerping_watchwhenobjectivedeleted(0);
    level.spawn_and_enter_little_bird_mg[var_4].ref_13d19 = var_7;
    level.spawn_and_enter_little_bird_mg[var_4].weapongroupdata = [];
    level.spawn_and_enter_little_bird_mg[var_4].weapongetflinchtype = [];
    level.spawn_and_enter_little_bird_mg[var_4].trial_mount_nag = [];
    level.spawn_and_enter_little_bird_mg[var_4].trial_missionscript_init_funcs = [];
  }
}

function airfield_safehouse_edit_loadout(var_0) {
  level endon("game_ended");
  self notify("loot_clear_delay_extended");
  self endon("loot_clear_delay_extended");
  var_1 = getdvarint("scr_br_hh_dom_clear_delay", 30);
  wait var_1;
  var_2 = getdvarint("scr_br_hh_dom_clear_radius", 260);

  if(var_2 <= 0) {
    return;
  }

  var_3 = 520;
  var_4 = scripts\mp\utility\player::getplayersinradius(var_0.ref_13d19.trigger.origin, var_3);

  if(var_4.size > 0) {
    thread airfield_safehouse_edit_loadout(var_0);
    return;
  }

  var_5 = canceljoins(undefined, undefined, var_0.origin, var_2);

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      if(scripts\engine\utility::string_starts_with(var_7.type, "br_loot_always_spawn_cache_")) {
        continue;
      }

      if(scripts\engine\utility::string_starts_with(var_7.type, "br_loot_cache")) {
        continue;
      }

      if(var_7 getscriptableisreserved() && !isDefined(var_7.embassy_main)) {
        continue;
      }

      scripts\mp\gametypes\br_pickups::ref_11a21(var_7);
    }

    return;
  }
}

function airstrikebetweentwopoints() {
  var_0 = getdvarint("scr_br_hh_dom_decay_rate_below_half", 13);
  var_1 = getdvarint("scr_br_hh_dom_decay_rate_above_half", 26);
  var_2 = self;
  var_3 = var_2.curprogress > 0.5 * var_2.usetime;
  return scripts\engine\utility::ter_op(var_3, var_1, var_0);
}

function alcove_trig() {
  var_0 = self;
  var_1 = "waypoint_contested";
  var_0 scripts\mp\gameobjects::setobjectivestatusicons(var_1);
  scripts\mp\objidpoolmanager::objective_set_progress_team(var_0.objidnum, undefined);
  all_modes(var_0);
  var_2 = "dx_brm_sant_santa_better_watch_10";
  all_alive_players_near_exfil(var_0, var_2);
}

function all_alive_players_near_exfil(var_0, var_1) {
  if(all_obit_models(var_0)) {
    var_2 = airstrikecount(var_0);

    foreach(var_4 in var_2) {
      var_4 playsoundtoplayer(var_1, var_4, var_4);
    }

    return;
  }
}

function alivejuggernauts(var_0) {
  var_1 = self;
  var_2 = level.spawn_and_enter_little_bird_mg[var_1.ref_13d1a];
  var_2.trial_mount_nag = [];
  scripts\mp\gametypes\br_gametype_bodycount::onarmorboxusedbyplayer(var_0, 0);
  all_modes(var_1);
}

function aitype_counts(var_0) {
  var_1 = self;
  var_2 = level.spawn_and_enter_little_bird_mg[var_1.ref_13d1a];
  var_2.cheese = 1;
  var_1.claimteam = var_0.team;
  var_1.curprogress = var_1.usetime;
  alertforspawngroupdirection(1);
}

function all_but_one_player_downed(var_0) {
  var_1 = self;
  var_2 = level.spawn_and_enter_little_bird_mg[var_1.ref_13d1a];

  if(istrue(var_2.stopdragonsbreathburning)) {
    return 0;
  }

  var_3 = scripts\engine\utility::array_contains(var_2.weapongetflinchtype, var_1.claimteam);
  var_4 = getdvarint("scr_br_hh_allowRepeatCompletion", 0) == 1;

  if(var_3 && !var_4) {
    var_1.claimplayer setclientomnvar("ui_securing", 13);
    var_5 = 0;
    return var_5;
  }

  var_6 = istrue(var_2.playerkilled_washitbyvehicle);
  var_7 = !scripts\engine\utility::array_contains(var_3.trial_mount_nag, var_2.claimteam);
  var_8 = var_6 && var_1 && var_7;
  var_5 = !var_8;
  return var_5;
}

function all_alive_players_entities(var_0, var_1, var_2, var_3) {
  var_4 = self;
  all_modes(var_4);
}

function alertforspawngroupdirection(var_0) {
  var_1 = self;
  var_2 = level.spawn_and_enter_little_bird_mg[var_1.ref_13d1a];
  var_3 = var_1.curprogress / var_1.usetime;

  if(!isDefined(var_2.ref_13d1b)) {
    return;
  }

  if(!var_0) {
    var_1.playerkilled_washitbyvehicle = 1;
  }

  var_4 = var_0 && istrue(var_1.playerkilled_washitbyvehicle);

  if(var_4) {
    var_1.playerkilled_washitbyvehicle = 0;
  }

  if(!scripts\engine\utility::array_contains(var_2.trial_mount_nag, var_1.claimteam)) {
    var_2.trial_mount_nag = scripts\engine\utility::array_add(var_2.trial_mount_nag, var_1.claimteam);
  }

  var_5 = scripts\engine\utility::ter_op(var_0 && !istrue(var_2.stopdragonsbreathburning), "up", "hidden");

  if(var_2 getscriptablehaspart("vfx_loop")) {
    var_2 setscriptablepartstate("vfx_loop", var_5, 0);
  }

  if(!var_0 && istrue(var_2.cheese)) {
    var_2.cheese = undefined;

    if(var_2 getscriptablehaspart("vfx_one_shot")) {
      var_2 setscriptablepartstate("vfx_one_shot", "despawn", 0);
    }
  }

  var_6 = var_2.ref_13d1b;

  if(var_3 == 1) {
    if(var_6 != 3) {
      var_7 = "dx_brm_sant_santa_holidays_10";
      all_alive_players_near_exfil(var_1, var_7);
      var_8 = 265;
      var_9 = scripts\mp\utility\player::getplayersinradius(var_2.ref_13d19.trigger.origin, var_8);

      foreach(var_11 in var_9) {
        if(var_11.team == var_1.claimteam) {
          scripts\mp\gametypes\br_quest_util::displayplayersplash(var_11, "br_tree_decoration_completed");
          var_11 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("hh_tree_completed");
          var_11 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("hh_riddle_completed");
        }
      }

      all_end_checkpoints_activated(var_1);

      if(var_2 getscriptablehaspart("vfx_one_shot")) {
        var_2 setscriptablepartstate("vfx_one_shot", "spawn_star", 0);
      }

      var_13 = scripts\engine\utility::array_contains(var_2.weapongetflinchtype, var_1.claimteam);
      var_14 = var_1.claimteam != "none" && !var_13;
      var_15 = getdvarfloat("scr_br_hh_dom_level_three_reveal_delay", 1);
      thread airstrike_canbeused(level, var_2, 3, var_14);

      if(!var_13) {
        var_2.weapongetflinchtype = scripts\engine\utility::array_add(var_2.weapongetflinchtype, var_1.claimteam);
      }

      if(!istrue(var_2.ref_12744)) {
        airlock_slot(var_1.ref_13d1a);
      }
    }
  } else if(var_3 > 0.5) {
    if(var_6 != 2) {
      if(var_0) {
        all_end_checkpoints_activated(var_1);

        if(var_2 getscriptablehaspart("vfx_one_shot")) {
          var_2 setscriptablepartstate("vfx_one_shot", "spawn_decorations", 0);
        }
      }

      var_16 = scripts\engine\utility::array_contains(var_2.weapongroupdata, var_1.claimteam);
      var_14 = var_1.claimteam != "none" && !var_16;
      var_15 = getdvarfloat("scr_br_hh_dom_level_two_reveal_delay", 1);
      thread airstrike_canbeused(level, var_2, 2, var_14);

      if(!var_16) {
        var_2.weapongroupdata = scripts\engine\utility::array_add(var_2.weapongroupdata, var_1.claimteam);
      }

      var_17 = "dx_brm_sant_santa_ho_10";
      all_alive_players_near_exfil(var_1, var_17);
    }
  } else if(var_3 <= 0.01 && !var_0) {
    var_1.curprogress = 0;
    var_1.playerkilled_washitbyvehicle = 0;
    var_2.trial_mount_nag = [];

    if(var_2 getscriptablehaspart("vfx_loop")) {
      var_2 setscriptablepartstate("vfx_loop", "hidden", 0);
    }

    thread airfield_safehouse_edit_loadout(var_2);
  } else if(var_3 < 0.5 && !var_0) {
    if(var_6 != 1) {
      thread airstrike_canbeused(level, var_2, 1, 0);
      var_2.trial_mount_nag = [];
    }
  }

  var_18 = var_2.ref_13a12;

  if(var_3 > 0.5 && var_0) {
    if(var_18 != 3) {
      airstrike_addactivestrike(var_2, 3);
      return;
    }

    return;
  }

  if(var_3 < 0.5 && var_0 || var_3 > 0.5 && !var_0) {
    if(var_18 != 2) {
      airstrike_addactivestrike(var_2, 2);
      return;
    }

    return;
  }

  if(var_3 < 0.5) {
    if(var_18 != 1) {
      airstrike_addactivestrike(var_2, 1);
      return;
    }

    return;
  }
}

function all_end_checkpoints_activated(var_0) {
  if(isDefined(var_0.ref_11e61)) {
    if(gettime() < var_0.ref_11e61) {
      return;
    }
  }

  var_1 = var_0.trigger.origin;
  level thread scripts\mp\gametypes\br_quest_util::ref_140b1(var_1, "dom", 3);
  var_2 = 15000;
  var_0.ref_11e61 = gettime() + var_2;
}

function all_obit_models(var_0) {
  if(isDefined(var_0.isloadinggulag)) {
    if(gettime() < var_0.isloadinggulag) {
      return false;
    }
  }

  var_1 = 5000;
  var_0.isloadinggulag = gettime() + var_1;
  return true;
}

function all_alive_players(var_0) {
  var_1 = self;
  var_2 = level.spawn_and_enter_little_bird_mg[var_1.ref_13d1a];
  var_2 notify("loot_clear_delay_extended");

  if(!scripts\engine\utility::array_contains(var_1.trigger.ref_13dc7, var_0)) {
    var_1.trigger.ref_13dc7 = scripts\engine\utility::array_add(var_1.trigger.ref_13dc7, var_0);
  }

  var_1 thread scripts\mp\gameobjects::useobjectdecay(var_0.team);
  var_3 = scripts\engine\utility::array_contains(var_2.weapongetflinchtype, var_0.team);
  var_4 = scripts\engine\utility::array_contains(var_2.trial_mount_nag, var_0.team);

  if(!var_3 && var_4 && istrue(var_1.playerkilled_washitbyvehicle)) {
    var_1.playerkilled_washitbyvehicle = 0;
  }

  var_5 = var_1.claimteam == "none" || istrue(var_1.stalemate);

  if(!istrue(var_2.stopdragonsbreathburning) && !var_3 && !var_5) {
    all_end_checkpoints_activated(var_1);
  }

  if(!var_4 && !var_3) {
    var_6 = "dx_brm_sant_santa_holiday_cheer_10";
    all_alive_players_near_exfil(var_1, var_6);
  }

  if(!isDefined(var_1.ref_11f63) || !var_1.ref_11f63) {
    var_1.ref_11f63 = 1;
    var_7 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_9 in var_7) {
      var_9 notify("calloutmarkerping_warzoneKillQuestIcon");
    }
  }

  if(!istrue(var_2.stopdragonsbreathburning) && !scripts\engine\utility::array_contains(var_2.trial_missionscript_init_funcs, var_0)) {
    var_2.trial_missionscript_init_funcs = scripts\engine\utility::array_add(var_2.trial_missionscript_init_funcs, var_0);
    var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("codmas_intel_6");
  }

  all_modes(var_1);
}

function all_alive_players_entites(var_0, var_1, var_2) {
  var_3 = self;
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);

  if(var_2) {
    aitype_counts(var_1);
  }

  all_modes(var_3);
}

function airstrikecount(var_0) {
  var_1 = level.spawn_and_enter_little_bird_mg[var_0.ref_13d1a];
  var_2 = getdvarint("scr_br_hh_tree_dom_radius", 250);
  var_3 = var_2 + 15;
  var_4 = var_3 * var_3;
  var_5 = [];

  for(var_6 = var_0.trigger.ref_13dc7.size - 1; var_6 >= 0; var_6--) {
    var_7 = var_0.trigger.ref_13dc7[var_6];
    var_8 = distance2dsquared(var_7.origin, var_0.trigger.origin);
    var_9 = var_8 > var_4;
    var_10 = scripts\engine\utility::array_contains(var_1.weapongetflinchtype, var_7.team);

    if(!var_9 && !var_10) {
      var_5 = var_7;
    }
  }

  return var_5;
}

function airstrikeid(var_0) {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return false;
  }

  var_1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_2 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  return distance2dsquared(var_1, var_0) > var_2 * var_2;
}

function all_gas_trap_structs(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in level.teamnamelist) {
    if(var_0.touchlist[var_5].size > 0) {
      var_3++;
      var_6 = var_0.touchlist[var_5];
      var_7 = getarraykeys(var_6);

      for(var_8 = 0; var_8 < var_7.size; var_8++) {
        var_9 = var_6[var_7[var_8]].player;
        var_2 = var_9;
      }
    }
  }

  var_11 = [];

  foreach(var_9 in var_1) {
    if(!scripts\engine\utility::array_contains(var_2, var_9)) {
      var_11 = var_9;
    }
  }

  return [var_2, var_11, var_3];
}

function all_modes(var_0) {
  var_1 = level.spawn_and_enter_little_bird_mg[var_0.ref_13d1a];

  if(istrue(var_1.stopdragonsbreathburning)) {
    return;
  }

  var_1.stopdragonsbreathburning = airstrikeid(var_0.trigger.origin);

  if(istrue(var_1.stopdragonsbreathburning)) {
    airstrike_addactivestrike(var_1, 0);
    thread airstrike_canbeused(level, var_1, 1, 0);
  }

  var_2 = var_0.trigger.ref_13dc7;
  var_3 = all_gas_trap_structs(var_0, var_2);
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = var_3[2];
  var_3 = undefined;
  var_0.trigger.ref_13dc7 = var_4;

  foreach(var_8 in var_5) {
    var_8 setclientomnvar("ui_securing_progress", 0);
    var_8 setclientomnvar("ui_securing", 0);
  }

  var_10 = var_0.curprogress / var_0.usetime;

  foreach(var_12 in var_4) {
    var_13 = scripts\engine\utility::array_contains(var_1.weapongetflinchtype, var_12.team);

    if(var_1.stopdragonsbreathburning) {
      var_12 setclientomnvar("ui_securing_progress", 0);
      var_12 setclientomnvar("ui_securing", 0);
      continue;
    }

    if(var_13) {
      var_12 setclientomnvar("ui_securing_progress", 1);
      var_12 setclientomnvar("ui_securing", 13);
      continue;
    }

    var_12 setclientomnvar("ui_securing_progress", var_10);

    if(var_6 > 1 || var_0.claimteam == "none" || var_0.claimteam == "neutral" || istrue(var_0.stalemate)) {
      var_12 setclientomnvar("ui_securing", 20);
      continue;
    }

    if(var_0.claimteam == var_12.team) {
      var_12 setclientomnvar("ui_securing", 18);
      continue;
    }

    var_12 setclientomnvar("ui_securing", 20);
  }

  if(var_1.stopdragonsbreathburning) {
    var_1 setscriptablepartstate("dom_circle", "hidden", 0);
    return;
  }

  if(var_6 > 1) {
    var_1 setscriptablepartstate("dom_circle", "yellow", 0);
    return;
  }

  if(var_6 == 1) {
    var_1 setotherent(var_0.claimplayer);
    var_1 setscriptablepartstate("dom_circle", "blue_red", 0);
    return;
  }

  var_1 setscriptablepartstate("dom_circle", "white", 0);
}

function airlock_doors() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, [26, 36, 2, 0, 18, 19, 36, 0]);
}

function airlock_slot(var_0) {
  if(getdvarint("scr_br_hh_morse_message", 0) == 0) {
    return;
  }

  var_1 = level.spawn_and_enter_little_bird_mg[var_0];
  var_2 = airlock_doors();
  var_3 = randomint(var_2.size);
  var_4 = getdvarint("scr_br_hh_override_message_index", -1);

  if(var_4 != -1) {
    var_3 = var_4;
  }

  thread airlock_show_front_doors(level, var_2[var_3], var_1, &airlock_positions);
}

function airlock_callbuttons() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, ". -");
}

function airlock_show_front_doors(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_1 notify("riddle_start");
  var_1 endon("riddle_start");
  var_1.ref_12744 = 1;
  var_4 = 0.5;
  var_5 = airlock_callbuttons();

  foreach(var_7 in var_0) {
    if(var_5[var_7] == "|") {
      [[var_3]](var_1);
      wait var_4 * 7;
      continue;
    }

    var_8 = var_5[var_7];
    var_9 = strtok(var_8, " ");

    foreach(var_11 in var_9) {
      if(var_11 == ".") {
        [[var_2]](var_1);
        wait var_4;
        [[var_3]](var_1);
      } else if(var_11 == "-") {
        [[var_2]](var_1);
        wait var_4 * 3;
        [[var_3]](var_1);
      }

      [[var_3]](var_1);
      wait var_4;
    }

    [[var_3]](var_1);
    wait var_4 * 3;
  }

  [[var_3]](var_1);
  wait var_4 * 7;
  var_1.ref_12744 = 0;
  thread airstrike_canbeused(level, var_1, var_1.ref_13d1b, 0);
}

function airlock_positions(var_0) {
  var_0 setscriptablepartstate("lights_off", "hidden", 0);
  var_0 setscriptablepartstate("lights_on", "visible", 0);
}

function airlock_pivot(var_0) {
  var_0 setscriptablepartstate("lights_off", "visible", 0);
  var_0 setscriptablepartstate("lights_on", "hidden", 0);
}

function airlock_show_doors(var_0) {
  var_1 = (11188, 13178, 7261);
  var_2 = distance(var_1, var_0.origin);
  var_3 = 200;
  var_4 = var_2 <= var_3;

  if(var_4) {
    var_0.ref_13442 = 1;
    return;
  }
}

function airlock_show_back_doors(var_0) {
  if(istrue(var_0.ref_13442)) {
    var_1 = istrue(var_0.play_found_leads_counting_building_two);

    if(airlock_show_room_doors(var_0) && !var_1) {
      var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("hh_riddle_completed");
      var_0.play_found_leads_counting_building_two = 1;
      airlock_front_blocker(var_0);
      return;
    }

    return;
  }
}

function airlock_front_blocker(var_0) {
  var_1 = "dx_brm_sant_santa_suckers_10";
  var_0 playsoundtoplayer(var_1, var_0, var_0);
  var_0 playsoundtoplayer("br_splash_mission_complete", var_0);
  var_0 thread scripts\mp\hud_message::showsplash("br_tree_riddle_solved");
  scripts\mp\gametypes\br_alt_mode_eas::ai_ascender_animloop(var_0.origin, var_0.angles);
  scripts\mp\gametypes\br_analytics::destroy_vehicle_on_pilot_death(var_0);
}

function airlock_show_room_doors() {
  if(!isDefined(self) || !isPlayer(self)) {
    return false;
  }

  var_0 = self;
  return istrue(var_0.unset_relic_punchbullets);
}

function airdrop_playdeploydialog(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isDefined(var_3)) {
    return;
  }

  var_5 = getcompleteweaponname("coal_mp");

  if(var_3 hasweapon(var_5) && var_3 getammocount(var_5) > 0) {
    return;
  }

  var_0 setscriptablepartstate("brloot_coal", "hidden");
  var_3 thread scripts\mp\gametypes\br_pickups::playerplaypickupanim();
  var_3 scripts\mp\equipment::giveequipment("equip_coal", "primary");
  var_3 playlocalsound("br_rock_pickup");
}

function airstrike_movewithplane(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isDefined(var_3)) {
    return;
  }

  var_5 = getcompleteweaponname("snowball_mp");

  if(var_3 hasweapon(var_5) && var_3 getammocount(var_5) > 0) {
    return;
  }

  var_0 setscriptablepartstate("brloot_snowball", "hidden");
  var_3 thread scripts\mp\gametypes\br_pickups::playerplaypickupanim();
  var_3 scripts\mp\equipment::giveequipment("equip_snowball", "primary");
  var_3 playlocalsound("br_rock_pickup");
  airlock_show_doors(var_3);
}

function airstrike_watchgameend() {
  var_0 = self;
  var_0 scripts\engine\utility::waittill_notify_or_timeout("missile_stuck", 4);
  wait 2;

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function airstrike_watchownerdisown(var_0, var_1, var_2) {
  if(var_0 == "coal_mp") {
    var_2 playlocalsound("br_gulag_rock_player_impact");
    airdrop_crushchicken(var_2);
    return;
  }

  if(var_0 == "snowball_mp") {
    playFXOnTag(level.ref_13443["vanish"], var_2, "j_head");
    return;
  }
}

function airdrop_crushchicken(var_0) {
  var_0 thread scripts\mp\equipment\gas_grenade::gas_applycough(var_0, 1);
  playfxontagforclients(level.helidrivableenablesiteonflyaway["screen"], var_0, "tag_eye", var_0);
  playFXOnTag(level.helidrivableenablesiteonflyaway["vanish"], var_0, "j_head");

  if(isDefined(level.playerentercombatareamessage)) {
    var_0[[level.playerentercombatareamessage]]();
    return;
  }
}

function airlock_button_l() {
  var_0 = scripts\cp_mp\utility\game_utility::tutorialzoneenter();
  var_1 = getdvarint("scr_br_ff_xmas_blueprint", 1) == 0;
  return !var_0 && !var_1;
}

function airlock_button_think() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "brloot_weapon_sn_t9quickscope_epic");
}

function airlock_button_r(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = 0;

  if(var_0.type == "br_loot_always_spawn_cache_common") {
    var_5 = 15;
    var_4 = getdvarint("scr_br_hh_common_cache_snow_chance", var_5);
    var_6 = 5;
    var_3 = getdvarint("scr_br_hh_common_cache_coal_chance", var_6);
    var_7 = 5;
    var_2 = verifybunkercode("festive_fervor_base_crate", var_0.ref_11a25);
  } else if(var_0.type == "br_loot_always_spawn_cache_legendary") {
    var_8 = 15;
    var_4 = getdvarint("scr_br_hh_legendary_cache_snow_chance", var_8);
    var_9 = 15;
    var_3 = getdvarint("scr_br_hh_legendary_cache_coal_chance", var_9);
    var_7 = 5;
    var_2 = verifybunkercode("festive_fervor_lege_crate", var_0.ref_11a25);
  } else if(var_0.type == "br_loot_always_spawn_cache_holiday") {
    var_10 = 10;
    var_4 = getdvarint("scr_br_hh_holiday_cache_snow_chance", var_10);
    var_11 = 30;
    var_3 = getdvarint("scr_br_hh_holiday_cache_coal_chance", var_11);
    var_7 = 5;
    var_2 = verifybunkercode("festive_fervor_ultra_crate", var_0.ref_11a25);
  }

  var_1 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("codmas_intel_5");
  var_12 = randomint(100);
  var_13 = var_12 <= var_3;
  var_14 = var_12 > var_3 && var_12 <= var_3 + var_4;

  if(!isDefined(var_1.ref_136ca)) {
    var_1.ref_136ca = [];
  }

  var_15 = !scripts\engine\utility::array_contains(var_1.ref_136ca, var_0.spawn_maint_wave);
  var_16 = 15;
  var_17 = getdvarint("scr_br_hh_holiday_blueprint_chance", var_16);
  var_12 = randomint(100);
  var_18 = var_12 <= var_17;

  if((var_18 || var_14) && airlock_button_l()) {
    var_2 = airlock_button_think();
  }

  if(getdvarint("scr_br_alt_mode_ff", 0) > 0 && getdvarint("scr_br_ff_double_cash", 0) > 0) {
    if(var_0.type == "br_loot_always_spawn_cache_common") {
      var_2 = "brloot_plunder_cash_uncommon_3";
    } else if(var_0.type == "br_loot_always_spawn_cache_legendary") {
      var_2 = "brloot_plunder_cash_epic_2";
    } else if(var_0.type == "br_loot_always_spawn_cache_holiday") {
      var_2 = "brloot_plunder_cash_rare_2";
    }
  }

  if(var_15) {
    if(var_13) {
      playFX(scripts\engine\utility::getfx("vfx_br_loot_cache_holiday_coal"), var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
      var_2 = [];
      var_2 = "brloot_coal";
      var_19 = "dx_brm_sant_santa_naughty_10";
      var_1 playsoundtoplayer(var_19, var_1, var_1);
      airdrop_crushchicken(var_1);
      var_1.ref_136ca = scripts\engine\utility::array_add(var_1.ref_136ca, var_0.spawn_maint_wave);
    } else if(var_14) {
      var_2 = "brloot_snowball";
      var_20 = "dx_brm_sant_santa_nice_10";
      var_1 playsoundtoplayer(var_20, var_1, var_1);
      var_1.ref_136ca = scripts\engine\utility::array_add(var_1.ref_136ca, var_0.spawn_maint_wave);
    }
  }

  return var_2;
}

function airdrop_watchforcrateuseend(var_0) {
  var_1 = getdvarint("scr_br_hh_debugLog", 0) == 1;

  if(var_1) {
    iprintlnbold("HH: " + var_0);
    return;
  }
}