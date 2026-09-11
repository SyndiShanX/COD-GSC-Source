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
  var0 = getdvarint("scr_br_alt_mode_hh", 0) == 1;

  if(!var0) {
    return;
  }

  level.spawn_lot_paratroopers = 1;
  thread airdrop_givecrateuseweapon();
  var1 = getdvarint("scr_br_hh_debug_SpawnTrees", 0) == 1;

  if(var1) {
    level.spawn_and_enter_little_bird_mg = airduct_locations();
  } else {
    level.spawn_and_enter_little_bird_mg = airstrike_watchdeployweaponchange();
  }

  all_but_one_player_in_vehicle();
  var2 = getdvarint("scr_br_hh_debug_SpawnCaches", 0) == 1;

  for(var3 = 0; var3 < level.spawn_and_enter_little_bird_mg.size; var3++) {
    if(var2) {
      airdropbasecashamount(var3);
      continue;
    }

    airdrop_specialcasecanusecrate(var3);
  }

  foreach(var5 in level.spawn_and_enter_little_bird_mg) {
    thread airstrike_canbeused(level, var5, 0, 1);
  }

  var7 = getdvarint("scr_br_hh_wait_for_prematch", 1) == 1;

  if(var7) {
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

    foreach(var1 in level.spawn_and_enter_little_bird_mg) {
      all_modes(var1.ref_13d19);
    }
  }
}

function airdrop_givecrateuseweapon() {
  scripts\mp\utility\sound::besttime("br_mode_holiday_hunt");
}

function airlock_slot_think(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = getdvarint("scr_br_hh_tree_blacklist_" + var1, 0) == 1;

    if(var2) {
      var0[var1].complete_hack_console = 1;
    }
  }

  for(var1 = var0.size - 1; var1 >= 0; var1--) {
    if(istrue(var0[var1].complete_hack_console)) {
      var0 = scripts\engine\utility::can_path_to_target(var0, var1);
    }
  }

  var3 = getdvarint("scr_br_hh_num_trees", 6);
  var3 = min(var3, var0.size);
  var4 = [];
  var5 = scripts\engine\utility::array_randomize(var0);

  for(var1 = 0; var1 < var3; var1++) {
    var4 = var5[var1];
  }

  return var4;
}

function airlock() {
  airlock_stop("hidden", "br_deckthehalls_cache_common");
  airlock_stop("hidden", "br_deckthehalls_cache_legendary");
  airlock_stop("hidden", "br_deckthehalls_cache_holiday");
}

function airlock_stop(var0, var1) {
  var2 = getentitylessscriptablearrayinradius(var1, "script_noteworthy");

  foreach(var4 in var2) {
    var4 setscriptablepartstate("body", var0, 0);
  }
}

function airdrop_specialcasecanusecrate(var0) {
  var1 = level.spawn_and_enter_little_bird_mg[var0].origin;
  var2 = 5000;
  level.spawn_and_enter_little_bird_mg[var0].hideintelinstancefromplayer = getentitylessscriptablearrayinradius("br_deckthehalls_cache_common", "script_noteworthy", var1, var2);
  level.spawn_and_enter_little_bird_mg[var0].waypoints_creation = getentitylessscriptablearrayinradius("br_deckthehalls_cache_legendary", "script_noteworthy", var1, var2);
  level.spawn_and_enter_little_bird_mg[var0].spawn_lootcrates_on_each_traincar = getentitylessscriptablearrayinradius("br_deckthehalls_cache_holiday", "script_noteworthy", var1, var2);
  var3 = 5;
  var4 = 5;
  var5 = 10;
  airlock_back_blocker(level.spawn_and_enter_little_bird_mg[var0].hideintelinstancefromplayer, var0, var3);
  airlock_back_blocker(level.spawn_and_enter_little_bird_mg[var0].waypoints_creation, var0, var4);
  airlock_back_blocker(level.spawn_and_enter_little_bird_mg[var0].spawn_lootcrates_on_each_traincar, var0, var5);
}

function airlock_back_blocker(var0, var1, var2) {
  var3 = randomint(var2);

  foreach(var5 in var0) {
    var3++;
    var3 %= var2;
    var5.spawn_maint_wave = var1;
    var5.ref_11a25 = var3;
  }
}

function airstrike_watchdeployweaponchange() {
  var0 = scripts\engine\utility::getStructArray("br_deckthehalls_tree", "script_noteworthy");
  var1 = airlock_slot_think(var0);
  var2 = [];

  foreach(var4 in var1) {
    var5 = airstrike_removeactivestrike(var4.origin);
    var2 = var5;
  }

  return var2;
}

function airholder() {
  var0 = getdvarint("scr_br_hh_wait_for_prematch", 1) == 1;

  if(var0) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  var1 = 6;
  wait var1;
  var2 = 1;

  for(var3 = 0; var3 < level.spawn_and_enter_little_bird_mg.size; var3++) {
    airstrike_addactivestrike(level.spawn_and_enter_little_bird_mg[var3], var2);
    thread airstrike_canbeused(level, level.spawn_and_enter_little_bird_mg[var3], var2, 1);
    level.spawn_and_enter_little_bird_mg[var3] setscriptablepartstate("dom_circle", "white", 0);
    level.spawn_and_enter_little_bird_mg[var3].ref_13d19 scripts\mp\gametypes\br_gulag::calloutmarkerping_watchwhenobjectivedeleted(1);
  }
}

function airduct_locations() {
  var0 = [];
  var1 = (-1852, -1253, 0);
  var2 = airstrike_removeactivestrike(var1);
  var0 = var2;
  var1 = (-1859, -3900, 0);
  var2 = airstrike_removeactivestrike(var1);
  var0 = var2;
  return var0;
}

function airstrike_removeactivestrike(var0) {
  var1 = spawn("script_model", var0);
  var1 setModel("lm_christmas_tree_large_set_01");
  var1.unset_relic_noregen = 1;
  return var1;
}

function airdropbasecashamount(var0) {
  level.spawn_and_enter_little_bird_mg[var0].hideintelinstancefromplayer = [];
  level.spawn_and_enter_little_bird_mg[var0].waypoints_creation = [];
  level.spawn_and_enter_little_bird_mg[var0].spawn_lootcrates_on_each_traincar = [];
  var1 = [];
  GscBinSkip0(0x2e, 0, (100, 0, 0));
}

function spawn_allies_at_defend(var0, var1, var2, var3) {
  var4 = easepower(var0, var1, var2);
  return var4;
}

function airstrike_addactivestrike(var0, var1) {
  if(istrue(var0.stopdragonsbreathburning)) {
    var1 = 0;
  }

  var0.ref_13a12 = var1;

  switch (var1) {
    case 0:
      var0 setscriptablepartstate("tacmap", "hidden", 0);
      break;
    case 1:
      var0 setscriptablepartstate("tacmap", "level_one", 0);
      break;
    case 2:
      var0 setscriptablepartstate("tacmap", "level_two", 0);
      break;
    case 3:
      var0 setscriptablepartstate("tacmap", "level_three", 0);
      break;
  }
}

function airstrike_canbeused(var0, var1, var2, var3) {
  var0 notify("newTreeSettings");
  var0 endon("newTreeSettings");
  var0.ref_13d1b = var1;
  wait var3;
  airdrop_watchforcrateuseend("Setting tree to level: " + var1 + " refreshing crates: " + var2);

  if(isDefined(var0.ref_13d19.claimplayer)) {
    scripts\mp\gametypes\br_analytics::destroy_vehicles(var0.ref_13d19.claimplayer, var1);
  }

  switch (var1) {
    case 0:
      var0 setscriptablepartstate("vfx_one_shot", "hidden", 0);
      var0 setscriptablepartstate("tree", "hidden", 0);
      var0 setscriptablepartstate("decorations", "hidden", 0);
      var0 setscriptablepartstate("star", "hidden", 0);
      var0 setscriptablepartstate("presents", "hidden", 0);

      if(!istrue(var0.ref_12744)) {
        var0 setscriptablepartstate("lights_off", "hidden", 0);
        var0 setscriptablepartstate("lights_on", "hidden", 0);
      }

      break;
    case 1:
      var0 setscriptablepartstate("vfx_one_shot", "hidden", 0);
      var0 setscriptablepartstate("tree", "visible", 0);
      var0 setscriptablepartstate("decorations", "hidden", 0);
      var0 setscriptablepartstate("star", "hidden", 0);
      var0 setscriptablepartstate("presents", "hidden", 0);

      if(!istrue(var0.ref_12744)) {
        var0 setscriptablepartstate("lights_off", "hidden", 0);
        var0 setscriptablepartstate("lights_on", "hidden", 0);
      }

      break;
    case 2:
      var0 setscriptablepartstate("tree", "visible", 0);
      var0 setscriptablepartstate("decorations", "visible", 0);
      var0 setscriptablepartstate("star", "hidden", 0);
      var0 setscriptablepartstate("presents", "hidden", 0);

      if(!istrue(var0.ref_12744)) {
        var0 setscriptablepartstate("lights_off", "visible", 0);
        var0 setscriptablepartstate("lights_on", "hidden", 0);
      }

      break;
    case 3:
      var0 setscriptablepartstate("tree", "visible", 0);
      var0 setscriptablepartstate("decorations", "visible", 0);
      var0 setscriptablepartstate("star", "visible", 0);
      var0 setscriptablepartstate("presents", "visible", 0);

      if(!istrue(var0.ref_12744)) {
        var0 setscriptablepartstate("lights_off", "visible", 0);
        var0 setscriptablepartstate("lights_on", "visible", 0);
      }

      break;
  }

  if(var2) {
    var4 = undefined;
    var5 = undefined;
    var6 = undefined;

    switch (var1) {
      case 0:
        var4 = "hidden";
        var5 = "hidden";
        var6 = "hidden";
        break;
      case 1:
        var4 = "closed";
        var5 = "hidden";
        var6 = "hidden";
        break;
      case 2:
        var4 = "hidden";
        var5 = "closed";
        var6 = "hidden";
        break;
      case 3:
        var4 = "hidden";
        var5 = "hidden";
        var6 = "closed";
        break;
    }

    foreach(var8 in var0.hideintelinstancefromplayer) {
      var8 setscriptablepartstate("body", var4, 0);
    }

    foreach(var8 in var0.waypoints_creation) {
      var8 setscriptablepartstate("body", var5, 0);
    }

    foreach(var8 in var0.spawn_lootcrates_on_each_traincar) {
      var8 setscriptablepartstate("body", var6, 0);
    }

    return;
  }
}

function all_but_one_player_in_vehicle() {
  var0 = getdvarint("scr_br_hh_tree_dom_radius", 250);
  var1 = getdvarint("scr_br_hh_tree_dom_height", 100);
  var2 = getdvarint("scr_br_dom_quest_capture_time", 30);
  var3 = var2 * 2;

  if(getdvarint("scr_br_hh_dom_duration_override", 0) != 0) {
    var3 = getdvarint("scr_br_hh_dom_duration_override", 30);
  }

  for(var4 = 0; var4 < level.spawn_and_enter_little_bird_mg.size; var4++) {
    var5 = level.spawn_and_enter_little_bird_mg[var4].origin;
    var6 = spawn("trigger_radius", var5, 0, var0, var1);
    var6.ref_13dc7 = [];
    var7 = scripts\mp\gametypes\obj_dom::setupobjective(var6, "neutral");
    var7.ref_13d1a = var4;
    var6.ref_13d19 = var7;
    var7.onuse = &aitype_counts;
    var7.onbeginuse = &all_alive_players;
    var7.onuseupdate = &all_alive_players_entities;
    var7.onenduse = &all_alive_players_entites;
    var7.ref_128b9 = &all_but_one_player_downed;
    var7.ref_12079 = &alertforspawngroupdirection;
    var7.oncontested = &alcove_trig;
    var7.onuncontested = &alivejuggernauts;
    var7.forest_barrels = &airstrikebetweentwopoints;
    var7.gate_swings_open = 1;
    var7.id = "domFlag";
    var7.pinobj = 0;
    var7.lockupdatingicons = 1;
    var7 scripts\mp\gameobjects::setcapturebehavior("normal");
    var7 scripts\mp\gameobjects::setusetime(var3);
    scripts\mp\objidpoolmanager::update_objective_setneutrallabel(var7.objidnum, "");
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var7.objidnum);
    var7.flagmodel delete();
    var7.flagmodel = undefined;
    var7.outlineent = undefined;
    var7.visibilitymanuallycontrolled = 1;
    var7 scripts\mp\gametypes\br_gulag::calloutmarkerping_watchwhenobjectivedeleted(0);
    level.spawn_and_enter_little_bird_mg[var4].ref_13d19 = var7;
    level.spawn_and_enter_little_bird_mg[var4].weapongroupdata = [];
    level.spawn_and_enter_little_bird_mg[var4].weapongetflinchtype = [];
    level.spawn_and_enter_little_bird_mg[var4].trial_mount_nag = [];
    level.spawn_and_enter_little_bird_mg[var4].trial_missionscript_init_funcs = [];
  }
}

function airfield_safehouse_edit_loadout(var0) {
  level endon("game_ended");
  self notify("loot_clear_delay_extended");
  self endon("loot_clear_delay_extended");
  var1 = getdvarint("scr_br_hh_dom_clear_delay", 30);
  wait var1;
  var2 = getdvarint("scr_br_hh_dom_clear_radius", 260);

  if(var2 <= 0) {
    return;
  }

  var3 = 520;
  var4 = scripts\mp\utility\player::getplayersinradius(var0.ref_13d19.trigger.origin, var3);

  if(var4.size > 0) {
    thread airfield_safehouse_edit_loadout(var0);
    return;
  }

  var5 = canceljoins(undefined, undefined, var0.origin, var2);

  if(isDefined(var5)) {
    foreach(var7 in var5) {
      if(scripts\engine\utility::string_starts_with(var7.type, "br_loot_always_spawn_cache_")) {
        continue;
      }

      if(scripts\engine\utility::string_starts_with(var7.type, "br_loot_cache")) {
        continue;
      }

      if(var7 getscriptableisreserved() && !isDefined(var7.embassy_main)) {
        continue;
      }

      scripts\mp\gametypes\br_pickups::ref_11a21(var7);
    }

    return;
  }
}

function airstrikebetweentwopoints() {
  var0 = getdvarint("scr_br_hh_dom_decay_rate_below_half", 13);
  var1 = getdvarint("scr_br_hh_dom_decay_rate_above_half", 26);
  var2 = self;
  var3 = var2.curprogress > 0.5 * var2.usetime;
  return scripts\engine\utility::ter_op(var3, var1, var0);
}

function alcove_trig() {
  var0 = self;
  var1 = "waypoint_contested";
  var0 scripts\mp\gameobjects::setobjectivestatusicons(var1);
  scripts\mp\objidpoolmanager::objective_set_progress_team(var0.objidnum, undefined);
  all_modes(var0);
  var2 = "dx_brm_sant_santa_better_watch_10";
  all_alive_players_near_exfil(var0, var2);
}

function all_alive_players_near_exfil(var0, var1) {
  if(all_obit_models(var0)) {
    var2 = airstrikecount(var0);

    foreach(var4 in var2) {
      var4 playsoundtoplayer(var1, var4, var4);
    }

    return;
  }
}

function alivejuggernauts(var0) {
  var1 = self;
  var2 = level.spawn_and_enter_little_bird_mg[var1.ref_13d1a];
  var2.trial_mount_nag = [];
  scripts\mp\gametypes\br_gametype_bodycount::onarmorboxusedbyplayer(var0, 0);
  all_modes(var1);
}

function aitype_counts(var0) {
  var1 = self;
  var2 = level.spawn_and_enter_little_bird_mg[var1.ref_13d1a];
  var2.cheese = 1;
  var1.claimteam = var0.team;
  var1.curprogress = var1.usetime;
  alertforspawngroupdirection(1);
}

function all_but_one_player_downed(var0) {
  var1 = self;
  var2 = level.spawn_and_enter_little_bird_mg[var1.ref_13d1a];

  if(istrue(var2.stopdragonsbreathburning)) {
    return 0;
  }

  var3 = scripts\engine\utility::array_contains(var2.weapongetflinchtype, var1.claimteam);
  var4 = getdvarint("scr_br_hh_allowRepeatCompletion", 0) == 1;

  if(var3 && !var4) {
    var1.claimplayer setclientomnvar("ui_securing", 13);
    var5 = 0;
    return var5;
  }

  var6 = istrue(var2.playerkilled_washitbyvehicle);
  var7 = !scripts\engine\utility::array_contains(var3.trial_mount_nag, var2.claimteam);
  var8 = var6 && var1 && var7;
  var5 = !var8;
  return var5;
}

function all_alive_players_entities(var0, var1, var2, var3) {
  var4 = self;
  all_modes(var4);
}

function alertforspawngroupdirection(var0) {
  var1 = self;
  var2 = level.spawn_and_enter_little_bird_mg[var1.ref_13d1a];
  var3 = var1.curprogress / var1.usetime;

  if(!isDefined(var2.ref_13d1b)) {
    return;
  }

  if(!var0) {
    var1.playerkilled_washitbyvehicle = 1;
  }

  var4 = var0 && istrue(var1.playerkilled_washitbyvehicle);

  if(var4) {
    var1.playerkilled_washitbyvehicle = 0;
  }

  if(!scripts\engine\utility::array_contains(var2.trial_mount_nag, var1.claimteam)) {
    var2.trial_mount_nag = scripts\engine\utility::array_add(var2.trial_mount_nag, var1.claimteam);
  }

  var5 = scripts\engine\utility::ter_op(var0 && !istrue(var2.stopdragonsbreathburning), "up", "hidden");

  if(var2 getscriptablehaspart("vfx_loop")) {
    var2 setscriptablepartstate("vfx_loop", var5, 0);
  }

  if(!var0 && istrue(var2.cheese)) {
    var2.cheese = undefined;

    if(var2 getscriptablehaspart("vfx_one_shot")) {
      var2 setscriptablepartstate("vfx_one_shot", "despawn", 0);
    }
  }

  var6 = var2.ref_13d1b;

  if(var3 == 1) {
    if(var6 != 3) {
      var7 = "dx_brm_sant_santa_holidays_10";
      all_alive_players_near_exfil(var1, var7);
      var8 = 265;
      var9 = scripts\mp\utility\player::getplayersinradius(var2.ref_13d19.trigger.origin, var8);

      foreach(var11 in var9) {
        if(var11.team == var1.claimteam) {
          scripts\mp\gametypes\br_quest_util::displayplayersplash(var11, "br_tree_decoration_completed");
          var11 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("hh_tree_completed");
          var11 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("hh_riddle_completed");
        }
      }

      all_end_checkpoints_activated(var1);

      if(var2 getscriptablehaspart("vfx_one_shot")) {
        var2 setscriptablepartstate("vfx_one_shot", "spawn_star", 0);
      }

      var13 = scripts\engine\utility::array_contains(var2.weapongetflinchtype, var1.claimteam);
      var14 = var1.claimteam != "none" && !var13;
      var15 = getdvarfloat("scr_br_hh_dom_level_three_reveal_delay", 1);
      thread airstrike_canbeused(level, var2, 3, var14);

      if(!var13) {
        var2.weapongetflinchtype = scripts\engine\utility::array_add(var2.weapongetflinchtype, var1.claimteam);
      }

      if(!istrue(var2.ref_12744)) {
        airlock_slot(var1.ref_13d1a);
      }
    }
  } else if(var3 > 0.5) {
    if(var6 != 2) {
      if(var0) {
        all_end_checkpoints_activated(var1);

        if(var2 getscriptablehaspart("vfx_one_shot")) {
          var2 setscriptablepartstate("vfx_one_shot", "spawn_decorations", 0);
        }
      }

      var16 = scripts\engine\utility::array_contains(var2.weapongroupdata, var1.claimteam);
      var14 = var1.claimteam != "none" && !var16;
      var15 = getdvarfloat("scr_br_hh_dom_level_two_reveal_delay", 1);
      thread airstrike_canbeused(level, var2, 2, var14);

      if(!var16) {
        var2.weapongroupdata = scripts\engine\utility::array_add(var2.weapongroupdata, var1.claimteam);
      }

      var17 = "dx_brm_sant_santa_ho_10";
      all_alive_players_near_exfil(var1, var17);
    }
  } else if(var3 <= 0.01 && !var0) {
    var1.curprogress = 0;
    var1.playerkilled_washitbyvehicle = 0;
    var2.trial_mount_nag = [];

    if(var2 getscriptablehaspart("vfx_loop")) {
      var2 setscriptablepartstate("vfx_loop", "hidden", 0);
    }

    thread airfield_safehouse_edit_loadout(var2);
  } else if(var3 < 0.5 && !var0) {
    if(var6 != 1) {
      thread airstrike_canbeused(level, var2, 1, 0);
      var2.trial_mount_nag = [];
    }
  }

  var18 = var2.ref_13a12;

  if(var3 > 0.5 && var0) {
    if(var18 != 3) {
      airstrike_addactivestrike(var2, 3);
      return;
    }

    return;
  }

  if(var3 < 0.5 && var0 || var3 > 0.5 && !var0) {
    if(var18 != 2) {
      airstrike_addactivestrike(var2, 2);
      return;
    }

    return;
  }

  if(var3 < 0.5) {
    if(var18 != 1) {
      airstrike_addactivestrike(var2, 1);
      return;
    }

    return;
  }
}

function all_end_checkpoints_activated(var0) {
  if(isDefined(var0.ref_11e61)) {
    if(gettime() < var0.ref_11e61) {
      return;
    }
  }

  var1 = var0.trigger.origin;
  level thread scripts\mp\gametypes\br_quest_util::ref_140b1(var1, "dom", 3);
  var2 = 15000;
  var0.ref_11e61 = gettime() + var2;
}

function all_obit_models(var0) {
  if(isDefined(var0.isloadinggulag)) {
    if(gettime() < var0.isloadinggulag) {
      return false;
    }
  }

  var1 = 5000;
  var0.isloadinggulag = gettime() + var1;
  return true;
}

function all_alive_players(var0) {
  var1 = self;
  var2 = level.spawn_and_enter_little_bird_mg[var1.ref_13d1a];
  var2 notify("loot_clear_delay_extended");

  if(!scripts\engine\utility::array_contains(var1.trigger.ref_13dc7, var0)) {
    var1.trigger.ref_13dc7 = scripts\engine\utility::array_add(var1.trigger.ref_13dc7, var0);
  }

  var1 thread scripts\mp\gameobjects::useobjectdecay(var0.team);
  var3 = scripts\engine\utility::array_contains(var2.weapongetflinchtype, var0.team);
  var4 = scripts\engine\utility::array_contains(var2.trial_mount_nag, var0.team);

  if(!var3 && var4 && istrue(var1.playerkilled_washitbyvehicle)) {
    var1.playerkilled_washitbyvehicle = 0;
  }

  var5 = var1.claimteam == "none" || istrue(var1.stalemate);

  if(!istrue(var2.stopdragonsbreathburning) && !var3 && !var5) {
    all_end_checkpoints_activated(var1);
  }

  if(!var4 && !var3) {
    var6 = "dx_brm_sant_santa_holiday_cheer_10";
    all_alive_players_near_exfil(var1, var6);
  }

  if(!isDefined(var1.ref_11f63) || !var1.ref_11f63) {
    var1.ref_11f63 = 1;
    var7 = scripts\mp\utility\teams::getfriendlyplayers(var0.team, 0);

    foreach(var9 in var7) {
      var9 notify("calloutmarkerping_warzoneKillQuestIcon");
    }
  }

  if(!istrue(var2.stopdragonsbreathburning) && !scripts\engine\utility::array_contains(var2.trial_missionscript_init_funcs, var0)) {
    var2.trial_missionscript_init_funcs = scripts\engine\utility::array_add(var2.trial_missionscript_init_funcs, var0);
    var0 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("codmas_intel_6");
  }

  all_modes(var1);
}

function all_alive_players_entites(var0, var1, var2) {
  var3 = self;
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);

  if(var2) {
    aitype_counts(var1);
  }

  all_modes(var3);
}

function airstrikecount(var0) {
  var1 = level.spawn_and_enter_little_bird_mg[var0.ref_13d1a];
  var2 = getdvarint("scr_br_hh_tree_dom_radius", 250);
  var3 = var2 + 15;
  var4 = var3 * var3;
  var5 = [];

  for(var6 = var0.trigger.ref_13dc7.size - 1; var6 >= 0; var6--) {
    var7 = var0.trigger.ref_13dc7[var6];
    var8 = distance2dsquared(var7.origin, var0.trigger.origin);
    var9 = var8 > var4;
    var10 = scripts\engine\utility::array_contains(var1.weapongetflinchtype, var7.team);

    if(!var9 && !var10) {
      var5 = var7;
    }
  }

  return var5;
}

function airstrikeid(var0) {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return false;
  }

  var1 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var2 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  return distance2dsquared(var1, var0) > var2 * var2;
}

function all_gas_trap_structs(var0, var1) {
  var2 = [];
  var3 = 0;

  foreach(var5 in level.teamnamelist) {
    if(var0.touchlist[var5].size > 0) {
      var3++;
      var6 = var0.touchlist[var5];
      var7 = getarraykeys(var6);

      for(var8 = 0; var8 < var7.size; var8++) {
        var9 = var6[var7[var8]].player;
        var2 = var9;
      }
    }
  }

  var11 = [];

  foreach(var9 in var1) {
    if(!scripts\engine\utility::array_contains(var2, var9)) {
      var11 = var9;
    }
  }

  return [var2, var11, var3];
}

function all_modes(var0) {
  var1 = level.spawn_and_enter_little_bird_mg[var0.ref_13d1a];

  if(istrue(var1.stopdragonsbreathburning)) {
    return;
  }

  var1.stopdragonsbreathburning = airstrikeid(var0.trigger.origin);

  if(istrue(var1.stopdragonsbreathburning)) {
    airstrike_addactivestrike(var1, 0);
    thread airstrike_canbeused(level, var1, 1, 0);
  }

  var2 = var0.trigger.ref_13dc7;
  var3 = all_gas_trap_structs(var0, var2);
  var4 = var3[0];
  var5 = var3[1];
  var6 = var3[2];
  var3 = undefined;
  var0.trigger.ref_13dc7 = var4;

  foreach(var8 in var5) {
    var8 setclientomnvar("ui_securing_progress", 0);
    var8 setclientomnvar("ui_securing", 0);
  }

  var10 = var0.curprogress / var0.usetime;

  foreach(var12 in var4) {
    var13 = scripts\engine\utility::array_contains(var1.weapongetflinchtype, var12.team);

    if(var1.stopdragonsbreathburning) {
      var12 setclientomnvar("ui_securing_progress", 0);
      var12 setclientomnvar("ui_securing", 0);
      continue;
    }

    if(var13) {
      var12 setclientomnvar("ui_securing_progress", 1);
      var12 setclientomnvar("ui_securing", 13);
      continue;
    }

    var12 setclientomnvar("ui_securing_progress", var10);

    if(var6 > 1 || var0.claimteam == "none" || var0.claimteam == "neutral" || istrue(var0.stalemate)) {
      var12 setclientomnvar("ui_securing", 20);
      continue;
    }

    if(var0.claimteam == var12.team) {
      var12 setclientomnvar("ui_securing", 18);
      continue;
    }

    var12 setclientomnvar("ui_securing", 20);
  }

  if(var1.stopdragonsbreathburning) {
    var1 setscriptablepartstate("dom_circle", "hidden", 0);
    return;
  }

  if(var6 > 1) {
    var1 setscriptablepartstate("dom_circle", "yellow", 0);
    return;
  }

  if(var6 == 1) {
    var1 setotherent(var0.claimplayer);
    var1 setscriptablepartstate("dom_circle", "blue_red", 0);
    return;
  }

  var1 setscriptablepartstate("dom_circle", "white", 0);
}

function airlock_doors() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [26, 36, 2, 0, 18, 19, 36, 0]);
}

function airlock_slot(var0) {
  if(getdvarint("scr_br_hh_morse_message", 0) == 0) {
    return;
  }

  var1 = level.spawn_and_enter_little_bird_mg[var0];
  var2 = airlock_doors();
  var3 = randomint(var2.size);
  var4 = getdvarint("scr_br_hh_override_message_index", -1);

  if(var4 != -1) {
    var3 = var4;
  }

  thread airlock_show_front_doors(level, var2[var3], var1, &airlock_positions);
}

function airlock_callbuttons() {
  var0 = [];
  GscBinSkip0(0x2e, 0, ". -");
}

function airlock_show_front_doors(var0, var1, var2, var3) {
  level endon("game_ended");
  var1 notify("riddle_start");
  var1 endon("riddle_start");
  var1.ref_12744 = 1;
  var4 = 0.5;
  var5 = airlock_callbuttons();

  foreach(var7 in var0) {
    if(var5[var7] == "|") {
      [[var3]](var1);
      wait var4 * 7;
      continue;
    }

    var8 = var5[var7];
    var9 = strtok(var8, " ");

    foreach(var11 in var9) {
      if(var11 == ".") {
        [[var2]](var1);
        wait var4;
        [[var3]](var1);
      } else if(var11 == "-") {
        [[var2]](var1);
        wait var4 * 3;
        [[var3]](var1);
      }

      [[var3]](var1);
      wait var4;
    }

    [[var3]](var1);
    wait var4 * 3;
  }

  [[var3]](var1);
  wait var4 * 7;
  var1.ref_12744 = 0;
  thread airstrike_canbeused(level, var1, var1.ref_13d1b, 0);
}

function airlock_positions(var0) {
  var0 setscriptablepartstate("lights_off", "hidden", 0);
  var0 setscriptablepartstate("lights_on", "visible", 0);
}

function airlock_pivot(var0) {
  var0 setscriptablepartstate("lights_off", "visible", 0);
  var0 setscriptablepartstate("lights_on", "hidden", 0);
}

function airlock_show_doors(var0) {
  var1 = (11188, 13178, 7261);
  var2 = distance(var1, var0.origin);
  var3 = 200;
  var4 = var2 <= var3;

  if(var4) {
    var0.ref_13442 = 1;
    return;
  }
}

function airlock_show_back_doors(var0) {
  if(istrue(var0.ref_13442)) {
    var1 = istrue(var0.play_found_leads_counting_building_two);

    if(airlock_show_room_doors(var0) && !var1) {
      var0 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("hh_riddle_completed");
      var0.play_found_leads_counting_building_two = 1;
      airlock_front_blocker(var0);
      return;
    }

    return;
  }
}

function airlock_front_blocker(var0) {
  var1 = "dx_brm_sant_santa_suckers_10";
  var0 playsoundtoplayer(var1, var0, var0);
  var0 playsoundtoplayer("br_splash_mission_complete", var0);
  var0 thread scripts\mp\hud_message::showsplash("br_tree_riddle_solved");
  scripts\mp\gametypes\br_alt_mode_eas::ai_ascender_animloop(var0.origin, var0.angles);
  scripts\mp\gametypes\br_analytics::destroy_vehicle_on_pilot_death(var0);
}

function airlock_show_room_doors() {
  if(!isDefined(self) || !isPlayer(self)) {
    return false;
  }

  var0 = self;
  return istrue(var0.unset_relic_punchbullets);
}

function airdrop_playdeploydialog(var0, var1, var2, var3, var4) {
  if(!isDefined(var0) || !isDefined(var3)) {
    return;
  }

  var5 = getcompleteweaponname("coal_mp");

  if(var3 hasweapon(var5) && var3 getammocount(var5) > 0) {
    return;
  }

  var0 setscriptablepartstate("brloot_coal", "hidden");
  var3 thread scripts\mp\gametypes\br_pickups::playerplaypickupanim();
  var3 scripts\mp\equipment::giveequipment("equip_coal", "primary");
  var3 playlocalsound("br_rock_pickup");
}

function airstrike_movewithplane(var0, var1, var2, var3, var4) {
  if(!isDefined(var0) || !isDefined(var3)) {
    return;
  }

  var5 = getcompleteweaponname("snowball_mp");

  if(var3 hasweapon(var5) && var3 getammocount(var5) > 0) {
    return;
  }

  var0 setscriptablepartstate("brloot_snowball", "hidden");
  var3 thread scripts\mp\gametypes\br_pickups::playerplaypickupanim();
  var3 scripts\mp\equipment::giveequipment("equip_snowball", "primary");
  var3 playlocalsound("br_rock_pickup");
  airlock_show_doors(var3);
}

function airstrike_watchgameend() {
  var0 = self;
  var0 scripts\engine\utility::waittill_notify_or_timeout("missile_stuck", 4);
  wait 2;

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function airstrike_watchownerdisown(var0, var1, var2) {
  if(var0 == "coal_mp") {
    var2 playlocalsound("br_gulag_rock_player_impact");
    airdrop_crushchicken(var2);
    return;
  }

  if(var0 == "snowball_mp") {
    playFXOnTag(level.ref_13443["vanish"], var2, "j_head");
    return;
  }
}

function airdrop_crushchicken(var0) {
  var0 thread scripts\mp\equipment\gas_grenade::gas_applycough(var0, 1);
  playfxontagforclients(level.helidrivableenablesiteonflyaway["screen"], var0, "tag_eye", var0);
  playFXOnTag(level.helidrivableenablesiteonflyaway["vanish"], var0, "j_head");

  if(isDefined(level.playerentercombatareamessage)) {
    var0[[level.playerentercombatareamessage]]();
    return;
  }
}

function airlock_button_l() {
  var0 = scripts\cp_mp\utility\game_utility::tutorialzoneenter();
  var1 = getdvarint("scr_br_ff_xmas_blueprint", 1) == 0;
  return !var0 && !var1;
}

function airlock_button_think() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "brloot_weapon_sn_t9quickscope_epic");
}

function airlock_button_r(var0, var1) {
  var2 = [];
  var3 = 0;
  var4 = 0;

  if(var0.type == "br_loot_always_spawn_cache_common") {
    var5 = 15;
    var4 = getdvarint("scr_br_hh_common_cache_snow_chance", var5);
    var6 = 5;
    var3 = getdvarint("scr_br_hh_common_cache_coal_chance", var6);
    var7 = 5;
    var2 = verifybunkercode("festive_fervor_base_crate", var0.ref_11a25);
  } else if(var0.type == "br_loot_always_spawn_cache_legendary") {
    var8 = 15;
    var4 = getdvarint("scr_br_hh_legendary_cache_snow_chance", var8);
    var9 = 15;
    var3 = getdvarint("scr_br_hh_legendary_cache_coal_chance", var9);
    var7 = 5;
    var2 = verifybunkercode("festive_fervor_lege_crate", var0.ref_11a25);
  } else if(var0.type == "br_loot_always_spawn_cache_holiday") {
    var10 = 10;
    var4 = getdvarint("scr_br_hh_holiday_cache_snow_chance", var10);
    var11 = 30;
    var3 = getdvarint("scr_br_hh_holiday_cache_coal_chance", var11);
    var7 = 5;
    var2 = verifybunkercode("festive_fervor_ultra_crate", var0.ref_11a25);
  }

  var1 scripts\cp\vehicles\vehicle_compass_cp::ref_120a4("codmas_intel_5");
  var12 = randomint(100);
  var13 = var12 <= var3;
  var14 = var12 > var3 && var12 <= var3 + var4;

  if(!isDefined(var1.ref_136ca)) {
    var1.ref_136ca = [];
  }

  var15 = !scripts\engine\utility::array_contains(var1.ref_136ca, var0.spawn_maint_wave);
  var16 = 15;
  var17 = getdvarint("scr_br_hh_holiday_blueprint_chance", var16);
  var12 = randomint(100);
  var18 = var12 <= var17;

  if((var18 || var14) && airlock_button_l()) {
    var2 = airlock_button_think();
  }

  if(getdvarint("scr_br_alt_mode_ff", 0) > 0 && getdvarint("scr_br_ff_double_cash", 0) > 0) {
    if(var0.type == "br_loot_always_spawn_cache_common") {
      var2 = "brloot_plunder_cash_uncommon_3";
    } else if(var0.type == "br_loot_always_spawn_cache_legendary") {
      var2 = "brloot_plunder_cash_epic_2";
    } else if(var0.type == "br_loot_always_spawn_cache_holiday") {
      var2 = "brloot_plunder_cash_rare_2";
    }
  }

  if(var15) {
    if(var13) {
      playFX(scripts\engine\utility::getfx("vfx_br_loot_cache_holiday_coal"), var0.origin, anglesToForward(var0.angles), anglestoup(var0.angles));
      var2 = [];
      var2 = "brloot_coal";
      var19 = "dx_brm_sant_santa_naughty_10";
      var1 playsoundtoplayer(var19, var1, var1);
      airdrop_crushchicken(var1);
      var1.ref_136ca = scripts\engine\utility::array_add(var1.ref_136ca, var0.spawn_maint_wave);
    } else if(var14) {
      var2 = "brloot_snowball";
      var20 = "dx_brm_sant_santa_nice_10";
      var1 playsoundtoplayer(var20, var1, var1);
      var1.ref_136ca = scripts\engine\utility::array_add(var1.ref_136ca, var0.spawn_maint_wave);
    }
  }

  return var2;
}

function airdrop_watchforcrateuseend(var0) {
  var1 = getdvarint("scr_br_hh_debugLog", 0) == 1;

  if(var1) {
    iprintlnbold("HH: " + var0);
    return;
  }
}