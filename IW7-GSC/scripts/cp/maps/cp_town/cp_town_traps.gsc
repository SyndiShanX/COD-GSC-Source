/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_traps.gsc
*****************************************************/

register_traps() {
  level.interaction_hintstrings["fix_electric_trap"] = &"CP_TOWN_INTERACTIONS_MISSING_COMPONENTS";
  level.interaction_hintstrings["add_component"] = &"CP_TOWN_INTERACTIONS_ADD_COMPONENT";
  level.interaction_hintstrings["trap_electric_part"] = "";
  level.interaction_hintstrings["trap_electric"] = &"CP_TOWN_INTERACTIONS_ELECTRIC_TRAP";
  scripts\cp\cp_interaction::register_interaction("fix_electric_trap", "trap", undefined, ::electric_trap_fix_hint, ::electric_trap_fix, 0, 0);
  scripts\cp\cp_interaction::register_interaction("trap_electric", "trap", undefined, undefined, ::electric_trap_use, 750, 1, ::electric_trap_init);
  scripts\cp\cp_interaction::register_interaction("trap_electric_part", "trap", undefined, undefined, ::electric_trap_take_part, 0, 0);
  scripts\engine\utility::flag_init("electric_trap_part_taken");
  scripts\engine\utility::flag_init("electric_trap_part_added");
  level.interactions["trap_electric_part"].disable_guided_interactions = 1;
  level.interactions["fix_electric_trap"].disable_guided_interactions = 1;
  level.interaction_hintstrings["fix_freeze_trap"] = &"CP_TOWN_INTERACTIONS_FREEZER_CONTROL";
  level.interaction_hintstrings["replace_freeze_panel"] = &"CP_TOWN_INTERACTIONS_REPLACE_CONTROLBOX";
  level.interaction_hintstrings["trap_freeze_part"] = "";
  level.interaction_hintstrings["trap_freeze"] = &"CP_TOWN_INTERACTIONS_USE_FREEZETRAP";
  scripts\cp\cp_interaction::register_interaction("fix_freeze_trap", "trap", undefined, ::freeze_trap_fix_hint, ::freeze_trap_fix, 0, 0);
  scripts\cp\cp_interaction::register_interaction("trap_freeze_part", "trap", undefined, undefined, ::freeze_trap_take_part, 0, 0);
  scripts\cp\cp_interaction::register_interaction("trap_freeze", "trap", undefined, undefined, ::freeze_trap_use, 750, 1, ::freeze_trap_init);
  scripts\engine\utility::flag_init("freeze_trap_part_taken");
  scripts\engine\utility::flag_init("freeze_trap_part_added");
  level.interactions["trap_freeze_part"].disable_guided_interactions = 1;
  level.interaction_hintstrings["fix_pool_trap"] = &"CP_TOWN_INTERACTIONS_FIX_POOL";
  level.interaction_hintstrings["pool_trap_gas"] = &"CP_TOWN_INTERACTIONS_ADD_GAS";
  level.interaction_hintstrings["trap_pool_part"] = "";
  level.interaction_hintstrings["trap_pool"] = &"CP_TOWN_INTERACTIONS_USE_POOL_TRAP";
  scripts\cp\cp_interaction::register_interaction("fix_pool_trap", "trap", undefined, ::pool_trap_fix_hint, ::pool_trap_fix, 0, 0);
  scripts\cp\cp_interaction::register_interaction("trap_pool_part", "trap", undefined, undefined, ::pool_trap_take_part, 0, 0);
  scripts\cp\cp_interaction::register_interaction("trap_pool", "trap", undefined, undefined, ::pool_trap_use, 750, 1, ::pool_trap_init);
  scripts\engine\utility::flag_init("pool_trap_part_taken");
  scripts\engine\utility::flag_init("pool_trap_part_added");
  level.interactions["trap_pool_part"].disable_guided_interactions = 1;
  level.interaction_hintstrings["fix_propane_trap"] = &"CP_TOWN_INTERACTIONS_FIX_PROPANE";
  level.interaction_hintstrings["propane_trap_attach_hose"] = &"CP_TOWN_INTERACTIONS_ATTACH_VALVE";
  level.interaction_hintstrings["trap_propane_part"] = "";
  level.interaction_hintstrings["trap_propane"] = &"CP_TOWN_INTERACTIONS_USE_PROPANE_TRAP";
  scripts\cp\cp_interaction::register_interaction("fix_propane_trap", "trap", undefined, ::propane_trap_fix_hint, ::propane_trap_fix, 0, 0);
  scripts\cp\cp_interaction::register_interaction("trap_propane_part", "trap", undefined, undefined, ::propane_trap_take_part, 0, 0);
  scripts\cp\cp_interaction::register_interaction("trap_propane", "trap", undefined, undefined, ::propane_trap_use, 750, 1, ::propane_trap_init);
  scripts\engine\utility::flag_init("propane_trap_part_taken");
  scripts\engine\utility::flag_init("propane_trap_part_added");
  level.interactions["trap_propane_part"].disable_guided_interactions = 1;
  level.interaction_hintstrings["elvira_trap"] = &"CP_TOWN_INTERACTIONS_USE_ELVIRA_TRAP";
  scripts\cp\cp_interaction::register_interaction("elvira_trap", "trap", undefined, undefined, ::elvira_trap_use, 750, 1, ::init_elvira_trap);
}

check_for_trap_master_achievement(var_0) {
  if(!isDefined(self.used_traps)) {
    self.used_traps = [];
  }

  self.used_traps = scripts\engine\utility::array_add_safe(self.used_traps, var_0);
  self.used_traps = scripts\engine\utility::array_remove_duplicates(self.used_traps);
  if(self.used_traps.size > 4) {
    scripts\cp\zombies\achievement::update_achievement("BAIT_AND_SWITCH", 1);
  }
}

trap_debug_devgui() {
  for(;;) {
    wait(1);
    if(getdvar("scr_craft_pickup") != "") {
      var_0 = getdvar("scr_craft_pickup");
      switch (var_0) {
        case "freeze":
          var_1 = scripts\engine\utility::getstruct("trap_freeze_part", "script_noteworthy");
          freeze_trap_take_part(var_1, level.players[0]);
          break;

        case "pool":
          var_1 = scripts\engine\utility::getstruct("trap_pool_part", "script_noteworthy");
          pool_trap_take_part(var_1, level.players[0]);
          break;

        case "electric":
          var_1 = scripts\engine\utility::getstruct("trap_electric_part", "script_noteworthy");
          electric_trap_take_part(var_1, level.players[0]);
          break;

        case "propane":
          var_1 = scripts\engine\utility::getstruct("trap_propane_part", "script_noteworthy");
          propane_trap_take_part(var_1, level.players[0]);
          break;
      }

      setdvar("scr_craft_pickup", "");
    }
  }
}

electric_trap_init() {
  var_0 = scripts\engine\utility::getstructarray("trap_electric_part", "script_noteworthy");
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  var_3 = scripts\engine\utility::getstructarray("trap_electric", "script_noteworthy");
  foreach(var_5 in var_3) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_5);
    level thread func_13611(var_5);
  }

  foreach(var_8 in var_0) {
    if(var_8 == var_2) {
      continue;
    } else {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_8);
    }
  }

  var_0A = scripts\engine\utility::getstruct(var_2.target, "targetname");
  if(isDefined(var_0A.angles)) {
    var_0B = (322.4, 26, -6.6);
  } else {
    var_0B = (0, 0, 0);
  }

  var_2.part = spawn("script_model", (5561, -2903, 119));
  var_2.part.angles = var_0B;
  var_2.part setModel("container_electrical_box_01_components");
  var_0C = scripts\engine\utility::getstruct("fix_electric_trap", "script_noteworthy");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0C);
  level waittill("power_active");
  level.interactions["fix_electric_trap"].disable_guided_interactions = undefined;
  level thread elec_trap_sparks();
  wait(1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0C);
}

elec_trap_sparks() {
  level endon("electric_trap_part_added");
  var_0 = scripts\engine\utility::getstructarray("electric_trap_sparks", "targetname");
  for(;;) {
    var_1 = scripts\engine\utility::random(var_0).origin;
    playFX(level._effect["elec_trap_sparks"], var_1);
    wait(randomintrange(2, 6));
  }
}

electric_trap_fix_hint(var_0, var_1) {
  if(!scripts\engine\utility::flag("electric_trap_part_taken")) {
    return level.interaction_hintstrings["fix_electric_trap"];
  }

  return level.interaction_hintstrings["add_component"];
}

electric_trap_fix(var_0, var_1) {
  if(!scripts\engine\utility::flag("electric_trap_part_taken")) {
    return;
  }

  scripts\engine\utility::flag_set("electric_trap_part_added");
  var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_3 = spawn("script_model", var_2.origin);
  var_3.angles = var_2.angles;
  var_3 setModel("container_electrical_box_01_components");
  var_4 = scripts\engine\utility::getstructarray("trap_electric", "script_noteworthy");
  foreach(var_6 in var_4) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_6);
    var_7 = getent(var_6.target, "targetname");
    var_7 setModel("mp_frag_button_on");
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 playlocalsound("zmb_coin_sounvenir_place");
  playFX(level._effect["elec_trap_sparks"], var_2.origin);
  wait(0.5);
  playsoundatpos(var_2.origin, "tesla_shock");
  var_9 = getent("elec_trap_door", "script_noteworthy");
  var_9 rotateto((0, 20, 0), 0.25);
  level.traps_fixed_electric = 1;
  check_traps_fixed_merit();
  taketrapparticon("electric");
}

ww_activate_trap_vo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  wait(1);
  if(randomint(100) >= 50 && randomint(100) < 60) {
    thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    return;
  }

  if(randomint(100) > 60) {
    level thread scripts\cp\cp_vo::try_to_play_vo("ww_activate_trap_" + var_0, "rave_announcer_vo", "highest", 70, 0, 0, 1);
    return;
  }

  level thread scripts\cp\cp_vo::try_to_play_vo("ww_activate_trap_generic", "rave_announcer_vo", "highest", 70, 0, 0, 1);
}

electric_trap_take_part(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_set("electric_trap_part_taken");
  var_1 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_0.part.origin);
  var_0.part delete();
  givetrapparticon("electric");
}

electric_trap_use(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_0.powered_on)) {
    return;
  }

  var_2 = scripts\engine\utility::getstructarray("trap_electric", "script_noteworthy");
  foreach(var_4 in var_2) {
    level thread scripts\cp\cp_interaction::interaction_cooldown(var_4, 325);
    var_5 = getent(var_4.target, "targetname");
    var_5 setModel("mp_frag_button_on");
  }

  var_1 thread ww_activate_trap_vo("transformer");
  var_1 check_for_trap_master_achievement("electric");
  level notify("use_electric_trap");
  level thread electric_trap_damage(var_0, var_1);
  level thread electric_trap_rumble();
  scripts\engine\utility::exploder(105);
  var_7 = getent("electric_trap_trig", "targetname");
  var_7 playLoopSound("town_electric_trap_electricity_on_lp");
  wait(0.1);
  var_8 = spawn("script_origin", var_7.origin + (0, 0, 60));
  var_8 playLoopSound("town_pap_electric_big_lp");
  wait(25);
  level notify("stop_electric_trap");
  var_7 stoploopsound();
  var_8 stoploopsound();
  var_8 delete();
  wait(300);
  foreach(var_4 in var_2) {
    var_5 = getent(var_4.target, "targetname");
    var_5 setModel("mp_frag_button_on_green");
  }
}

electric_trap_damage(var_0, var_1) {
  level endon("stop_electric_trap");
  var_2 = gettime();
  var_3 = getent("electric_trap_trig", "targetname");
  for(;;) {
    var_3 waittill("trigger", var_4);
    if(isDefined(level.elvira_ai) && var_4 == level.elvira_ai) {
      continue;
    }

    if(isplayer(var_4) && isalive(var_4) && !scripts\cp\cp_laststand::player_in_laststand(var_4) && !isDefined(var_4.padding_damage)) {
      playsoundatpos(var_4.origin, "trap_electric_shock");
      playfxontagforclients(level._effect["electric_shock_plyr"], var_4, "tag_eye", var_4);
      var_4.padding_damage = 1;
      var_4 dodamage(20, var_3.origin, var_3, var_3, "MOD_UNKNOWN", "iw7_electrictrap_zm");
      var_4 thread remove_padding_damage();
      continue;
    }

    if(scripts\engine\utility::istrue(var_4.is_turned) || !scripts\cp\utility::should_be_affected_by_trap(var_4, 0, 1)) {
      continue;
    }

    if(var_4 is_crog()) {
      continue;
    }

    if(gettime() > var_2 + 1000) {
      playsoundatpos(var_4.origin, "trap_electric_shock");
      var_2 = gettime();
    }

    level thread electrocute_zombie(var_4, var_1);
  }
}

is_crog() {
  return self.agent_type == "crab_mini" || self.agent_type == "crab_brute";
}

electrocute_zombie(var_0, var_1) {
  var_0 endon("death");
  wait(randomfloat(3));
  var_2 = scripts\engine\utility::getstructarray("electric_trap_spots", "targetname");
  var_3 = scripts\engine\utility::getclosest(var_0.origin, var_2);
  var_4 = var_3.origin + (0, 0, randomintrange(100, 170));
  var_5 = var_0.origin + (0, 0, randomintrange(20, 60));
  playfxbetweenpoints(level._effect["electric_trap_attack"], var_4, vectortoangles(var_5 - var_4), var_5);
  playFX(level._effect["electric_trap_shock"], var_5);
  var_0.dontmutilate = 1;
  var_0.electrocuted = 1;
  var_0 setscriptablepartstate("electrocuted", "on");
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    var_6 = var_1;
  } else {
    var_6 = undefined;
  }

  var_7 = ["kill_trap_generic"];
  var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_7), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
  var_0 dodamage(var_0.health + 100, var_0.origin, var_6, var_6, "MOD_UNKNOWN", "iw7_electrictrap_zm");
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.5);
  self.padding_damage = undefined;
}

electric_trap_rumble() {
  level endon("stop_electric_trap");
  var_0 = getent("electric_trap_trig", "targetname");
  for(;;) {
    wait(0.2);
    earthquake(0.18, 1, var_0.origin, 784);
    wait(0.05);
    playrumbleonposition("artillery_rumble", var_0.origin);
  }
}

freeze_trap_init() {
  var_0 = scripts\engine\utility::getstructarray("trap_freeze_part", "script_noteworthy");
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  var_3 = scripts\engine\utility::getstructarray("trap_freeze", "script_noteworthy");
  foreach(var_5 in var_3) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_5);
  }

  foreach(var_8 in var_0) {
    if(var_8 == var_2) {
      continue;
    } else {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_8);
    }
  }

  var_0A = scripts\engine\utility::getstruct(var_2.target, "targetname");
  if(isDefined(var_0A.angles)) {
    var_0B = var_0A.angles;
  } else {
    var_0B = (0, 0, 0);
  }

  var_2.part = spawn("script_model", var_0A.origin);
  var_2.part.angles = var_0B;
  var_2.part setModel("ship_hallway_fuse_box");
  level thread freeze_trap_panel_fx();
  foreach(var_5 in var_3) {
    level thread func_13611(var_5);
  }

  while(!scripts\engine\utility::istrue(var_3[0].powered_on)) {
    wait(0.1);
  }

  scripts\engine\utility::exploder(75);
  var_3 = scripts\engine\utility::getstructarray("trap_freeze", "script_noteworthy");
  foreach(var_5 in var_3) {
    var_0F = getent(var_5.target, "targetname");
    var_0F setModel("mp_frag_button_on_green");
  }
}

func_13611(var_0) {
  if(scripts\engine\utility::istrue(var_0.requires_power)) {
    var_1 = undefined;
    if(isDefined(var_0.script_area)) {
      var_1 = var_0.script_area;
    } else {
      var_1 = scripts\cp\cp_interaction::get_area_for_power(var_0);
    }

    if(isDefined(var_1)) {
      level scripts\engine\utility::waittill_any_3("power_on", var_1 + " power_on");
    }
  }

  var_0.powered_on = 1;
  level notify("power_active");
}

check_traps_fixed_merit() {
  if(scripts\engine\utility::istrue(level.traps_fixed_freeze) && scripts\engine\utility::istrue(level.traps_fixed_electric) && scripts\engine\utility::istrue(level.traps_fixed_pool) && scripts\engine\utility::istrue(level.traps_fixed_propane)) {
    if(!scripts\engine\utility::istrue(level.traps_fixed_merit_awarded)) {
      foreach(var_1 in level.players) {
        var_1 scripts\cp\cp_merits::processmerit("mt_dlc3_traps_fixed");
      }

      level.traps_fixed_merit_awarded = 1;
    }
  }
}

freeze_trap_panel_fx() {
  level endon("freeze_trap_fixed");
  var_0 = scripts\engine\utility::getstruct("fix_freeze_trap", "script_noteworthy");
  var_1 = getent(var_0.target, "targetname");
  for(;;) {
    playFX(level._effect["elec_trap_sparks"], var_1.origin);
    wait(randomintrange(2, 6));
  }
}

freeze_trap_fix_hint(var_0, var_1) {
  if(!scripts\engine\utility::flag("freeze_trap_part_taken")) {
    return level.interaction_hintstrings["fix_freeze_trap"];
  }

  return level.interaction_hintstrings["replace_freeze_panel"];
}

freeze_trap_fix(var_0, var_1) {
  if(!scripts\engine\utility::flag("freeze_trap_part_taken")) {
    return;
  }

  level notify("freeze_trap_fixed");
  scripts\engine\utility::flag_set("freeze_trap_part_added");
  var_2 = getent(var_0.target, "targetname");
  var_2 setModel("ship_hallway_fuse_box");
  playFX(level._effect["elec_trap_sparks"], var_2.origin);
  var_3 = scripts\engine\utility::getstructarray("trap_freeze", "script_noteworthy");
  foreach(var_5 in var_3) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_5);
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 playlocalsound("zmb_coin_sounvenir_place");
  wait(0.5);
  playsoundatpos(var_2.origin, "tesla_shock");
  level.traps_fixed_freeze = 1;
  check_traps_fixed_merit();
  taketrapparticon("freeze");
}

freeze_trap_take_part(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_set("freeze_trap_part_taken");
  var_1 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_0.part.origin);
  var_0.part delete();
  givetrapparticon("freeze");
}

freeze_trap_use(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray("trap_freeze", "script_noteworthy");
  foreach(var_4 in var_2) {
    var_4.cooling_down = 1;
    var_5 = getent(var_4.target, "targetname");
    var_5 setModel("mp_frag_button_on");
  }

  var_1 thread ww_activate_trap_vo("freezer");
  var_1 check_for_trap_master_achievement("freeze");
  scripts\engine\utility::exploder(85);
  level thread freeze_trap_sfx();
  level notify("start_freeze_trap");
  var_7 = getent("freeze_trig", "targetname");
  var_7 thread freeze_players();
  wait(25);
  level notify("end_freeze_trap");
  wait(300);
  foreach(var_4 in var_2) {
    var_4.cooling_down = undefined;
    var_5 = getent(var_4.target, "targetname");
    var_5 setModel("mp_frag_button_on_green");
  }
}

freeze_trap_sfx() {
  var_0 = scripts\engine\utility::play_loopsound_in_space("town_freezer_trap_wind6_lp", (6102, -507, 396));
  scripts\engine\utility::waitframe();
  var_1 = scripts\engine\utility::play_loopsound_in_space("town_freezer_trap_wind_lp", (6297, -589, 396));
  scripts\engine\utility::waitframe();
  var_2 = scripts\engine\utility::play_loopsound_in_space("town_freezer_trap_wind5_lp", (6280, -479, 463));
  level waittill("end_freeze_trap");
  scripts\engine\utility::play_sound_in_space("town_freezer_trap_end", (6189, -488, 408));
  wait(0.5);
  var_0 stoploopsound();
  var_0 delete();
  wait(0.2);
  var_1 stoploopsound();
  var_1 delete();
  wait(0.2);
  var_2 stoploopsound();
  var_2 delete();
}

freeze_players() {
  level endon("end_freeze_trap");
  for(;;) {
    self waittill("trigger", var_0);
    if(isDefined(level.elvira_ai) && var_0 == level.elvira_ai) {
      continue;
    }

    if(isplayer(var_0)) {
      if(!scripts\engine\utility::istrue(var_0.padding_damage)) {
        var_0.padding_damage = 1;
        var_0 dodamage(10, self.origin, self, self, "MOD_UNKNOWN", "iw7_electrictrap_zm");
        var_0 thread remove_padding_damage();
      }

      if(!isDefined(var_0.scrnfx)) {
        var_0 thread chill_scrnfx();
      }

      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_0) || scripts\engine\utility::istrue(var_0.is_turned)) {
      continue;
    }

    if(var_0 is_crog()) {
      continue;
    } else if(!isDefined(var_0.isfrozen)) {
      var_0.isfrozen = 1;
      var_0.health = 1;
      var_0 thread kill_frozen_guys_after_time();
    }
  }
}

kill_frozen_guys_after_time() {
  self endon("death");
  wait(randomintrange(3, 8));
  self dodamage(self.health + 100, self.origin);
}

chill_scrnfx() {
  self endon("disconnect");
  self.scrnfx = spawnfxforclient(level._effect["vfx_freezer_frost_scrn"], self getEye(), self);
  wait(0.1);
  triggerfx(self.scrnfx);
  scripts\engine\utility::waittill_any_timeout_1(5, "last_stand");
  self.scrnfx delete();
  self.scrnfx = undefined;
}

pool_trap_init() {
  var_0 = scripts\engine\utility::getstructarray("trap_pool_part", "script_noteworthy");
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  var_3 = scripts\engine\utility::getstructarray("trap_pool", "script_noteworthy");
  foreach(var_5 in var_3) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_5);
  }

  foreach(var_8 in var_0) {
    if(var_8 == var_2) {
      continue;
    } else {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_8);
    }
  }

  var_0A = scripts\engine\utility::getstruct(var_2.target, "targetname");
  if(isDefined(var_0A.angles)) {
    var_0B = var_0A.angles;
  } else {
    var_0B = (0, 0, 0);
  }

  var_2.part = spawn("script_model", var_0A.origin);
  var_2.part.angles = var_0B;
  var_2.part setModel("gas_canister_iw6");
}

pool_trap_fix_hint(var_0, var_1) {
  if(!scripts\engine\utility::flag("pool_trap_part_taken")) {
    return level.interaction_hintstrings["fix_pool_trap"];
  }

  return level.interaction_hintstrings["pool_trap_gas"];
}

pool_trap_fix(var_0, var_1) {
  if(!scripts\engine\utility::flag("pool_trap_part_taken")) {
    return;
  }

  level notify("pool_trap_fixed");
  scripts\engine\utility::flag_set("pool_trap_part_added");
  var_2 = scripts\engine\utility::getstructarray("trap_pool", "script_noteworthy");
  foreach(var_4 in var_2) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_4);
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 playlocalsound("zmb_coin_sounvenir_place");
  level.traps_fixed_pool = 1;
  check_traps_fixed_merit();
  taketrapparticon("pool");
}

pool_trap_take_part(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_set("pool_trap_part_taken");
  var_1 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_0.part.origin);
  var_0.part delete();
  givetrapparticon("pool");
}

pool_trap_use(var_0, var_1) {
  var_0.cooling_down = 1;
  level thread generator_sfx();
  if(isDefined(level.radiation_extraction_interaction)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(level.radiation_extraction_interaction);
  }

  level.using_pool_trap = 1;
  var_2 = getent("pool_dmg", "targetname");
  var_1 thread ww_activate_trap_vo("pool");
  var_1 check_for_trap_master_achievement("pool");
  scripts\engine\utility::exploder(50);
  var_2 playLoopSound("town_trap_pool_boiling_lp");
  level.pool_kills = 0;
  var_2 thread pool_dmg_players(var_1);
  wait(25);
  level notify("end_pool_trap");
  var_2 stoploopsound();
  if(isDefined(level.radiation_extraction_interaction)) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(level.radiation_extraction_interaction);
  }

  level notify("pool_trap_kills", level.pool_kills);
  wait(300);
  var_0.cooling_down = undefined;
}

generator_sfx() {
  scripts\cp\utility::playsoundinspace("town_electric_trap_gen_power_up", (488, -714, 460));
  wait(1);
  var_0 = spawn("script_origin", (488, -714, 460));
  wait(1);
  var_0 playLoopSound("town_electric_trap_gen_on_lp");
  wait(23);
  var_0 playSound("town_electric_trap_gen_power_down");
  var_0 stoploopsound("town_electric_trap_gen_on_lp");
}

pool_dmg_players(var_0) {
  level endon("end_pool_trap");
  var_1 = gettime();
  var_2 = getent("pool_dmg", "targetname");
  for(;;) {
    var_2 waittill("trigger", var_3);
    if(isDefined(level.elvira_ai) && var_3 == level.elvira_ai) {
      continue;
    }

    if(isplayer(var_3) && isalive(var_3) && !scripts\cp\cp_laststand::player_in_laststand(var_3) && !isDefined(var_3.padding_damage)) {
      playsoundatpos(var_3.origin, "trap_electric_shock");
      playfxontagforclients(level._effect["electric_shock_plyr"], var_3, "tag_eye", var_3);
      var_3.padding_damage = 1;
      var_3 dodamage(20, var_3.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_electrictrap_zm");
      var_3 thread remove_padding_damage();
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.is_turned) || !scripts\cp\utility::should_be_affected_by_trap(var_3, 0, 1)) {
      continue;
    }

    if(var_3 is_crog()) {
      continue;
    }

    if(gettime() > var_1 + 1000) {
      playsoundatpos(var_3.origin, "trap_electric_shock");
      var_1 = gettime();
    }

    var_0 thread scripts\cp\cp_vo::try_to_play_vo("kill_trap_generic", "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    level thread pool_damage_zombie(var_3, var_0);
  }
}

pool_damage_zombie(var_0, var_1) {
  var_0 endon("death");
  wait(randomfloatrange(1, 4));
  var_0.marked_for_death = 1;
  var_0.dontmutilate = 1;
  var_0.electrocuted = 1;
  var_0 setscriptablepartstate("electrocuted", "on");
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    var_2 = var_1;
  } else {
    var_2 = undefined;
  }

  level.pool_kills++;
  var_0 dodamage(var_0.health + 100, var_0.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_electrictrap_zm");
}

propane_trap_init() {
  var_0 = scripts\engine\utility::getstructarray("trap_propane_part", "script_noteworthy");
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  var_3 = scripts\engine\utility::getstructarray("trap_propane", "script_noteworthy");
  foreach(var_5 in var_3) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_5);
  }

  foreach(var_8 in var_0) {
    if(var_8 == var_2) {
      continue;
    } else {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_8);
    }
  }

  var_0A = scripts\engine\utility::getstruct(var_2.target, "targetname");
  if(isDefined(var_0A.angles)) {
    var_0B = var_0A.angles;
  } else {
    var_0B = (0, 0, 0);
  }

  var_2.part = spawn("script_model", var_0A.origin);
  var_2.part.angles = var_0B;
  var_2.part setModel("cp_town_pipe_t_valve");
}

propane_trap_fix_hint(var_0, var_1) {
  if(!scripts\engine\utility::flag("propane_trap_part_taken")) {
    return level.interaction_hintstrings["fix_propane_trap"];
  }

  return level.interaction_hintstrings["propane_trap_attach_hose"];
}

propane_trap_fix(var_0, var_1) {
  if(!scripts\engine\utility::flag("propane_trap_part_taken")) {
    return;
  }

  level notify("propane_trap_fixed");
  scripts\engine\utility::flag_set("propane_trap_part_added");
  var_2 = scripts\engine\utility::getstructarray("trap_propane", "script_noteworthy");
  foreach(var_4 in var_2) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_4);
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 playlocalsound("zmb_coin_sounvenir_place");
  var_6 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_7 = scripts\engine\utility::getstruct("trap_propane", "script_noteworthy");
  var_7.valve = spawn("script_model", var_6.origin);
  var_7.valve.angles = var_6.angles;
  var_7.valve setModel("cp_town_pipe_t_valve");
  level.traps_fixed_propane = 1;
  check_traps_fixed_merit();
  taketrapparticon("propane");
}

propane_trap_take_part(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_set("propane_trap_part_taken");
  var_1 playlocalsound("part_pickup");
  playFX(level._effect["generic_pickup"], var_0.part.origin);
  var_0.part delete();
  givetrapparticon("propane");
}

propane_trap_use(var_0, var_1) {
  var_0.cooling_down = 1;
  var_2 = scripts\engine\utility::getstruct("propane_tank_fx", "targetname");
  if(!isDefined(var_2)) {
    var_2 = spawnStruct();
    var_2.origin = (831.5, 3601, 440);
    var_2.angles = (330.478, 214.339, -63.6374);
  }

  var_1 thread ww_activate_trap_vo("propane");
  var_1 check_for_trap_master_achievement("propane");
  level thread propane_trap_sfx();
  wait(1);
  scripts\engine\utility::exploder(45);
  level thread propane_dmg_players(var_1, var_0);
  wait(25);
  level notify("end_propane_trap");
  wait(300);
  var_0.cooling_down = undefined;
}

propane_trap_sfx() {
  level thread scripts\engine\utility::play_sound_in_space("town_propane_tank_turn_valve", (1002, 3536, 456));
  var_0 = scripts\engine\utility::play_loopsound_in_space("town_propane_tank_air_lp", (1002, 3536, 456));
  wait(0.9);
  wait(0.7);
  level thread scripts\engine\utility::play_sound_in_space("town_propane_tank_explo", (1002, 3536, 456));
  wait(0.1);
  var_0 stoploopsound();
  var_0 delete();
  wait(0.3);
  var_0 = scripts\engine\utility::play_loopsound_in_space("town_propane_tank_fire_spout_lp", (966, 3564, 440));
  var_1 = scripts\engine\utility::play_loopsound_in_space("town_propane_tank_fire_tip_lp", (745, 3730, 464));
  wait(22.3);
  level thread scripts\engine\utility::play_sound_in_space("town_propane_tank_fire_tip_end", (1002, 3536, 456));
  wait(0.6);
  var_1 stoploopsound();
  var_1 delete();
  wait(0.5);
  var_0 stoploopsound();
  var_0 delete();
}

propane_dmg_players(var_0, var_1) {
  level endon("end_propane_trap");
  var_2 = getent("propane_dmg_trig", "targetname");
  for(;;) {
    var_2 waittill("trigger", var_3);
    if(isDefined(level.elvira_ai) && var_3 == level.elvira_ai) {
      continue;
    }

    if(isplayer(var_3) && isalive(var_3) && !scripts\cp\cp_laststand::player_in_laststand(var_3) && !isDefined(var_3.padding_damage)) {
      playfxontagforclients(level._effect["player_scr_fire"], var_3, "tag_eye", var_3);
      var_3.padding_damage = 1;
      var_3 dodamage(20, var_1.origin + (0, 0, 30), var_2, var_2, "MOD_UNKNOWN", "iw7_electrictrap_zm");
      var_3 thread remove_padding_damage();
      continue;
    }

    if(scripts\engine\utility::istrue(var_3.is_turned) || !scripts\cp\utility::should_be_affected_by_trap(var_3, 0, 1)) {
      continue;
    }

    if(var_3 is_crog()) {
      continue;
    }

    level thread propane_damage_zombie(var_3, var_0);
    var_4 = ["kill_trap_generic"];
    var_0 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_4), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
  }
}

propane_damage_zombie(var_0, var_1) {
  var_0 endon("death");
  wait(randomfloatrange(1, 4));
  var_0.marked_for_death = 1;
  var_0.dontmutilate = 1;
  var_0.is_burning = 1;
  var_0 setscriptablepartstate("burning", "active");
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    var_2 = var_1;
  } else {
    var_2 = undefined;
  }

  wait(randomintrange(2, 4));
  var_0 dodamage(var_0.health + 100, var_0.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_electrictrap_zm");
}

elvira_trap_use(var_0, var_1) {
  var_0.cooling_down = 1;
  var_1 check_for_trap_master_achievement("elvira");
  var_2 = getent(var_0.target, "targetname");
  var_2 setModel("mp_frag_button_on");
  scripts\engine\utility::exploder(60);
  level thread elvira_trap_dmg(var_1);
  level thread elvira_trap_sound((-338, -2978.5, 578));
  wait(0.05);
  scripts\engine\utility::exploder(65);
  level thread elvira_trap_sound((224, -2143.5, 578));
  wait(25);
  level notify("end_elvira_trap");
  wait(300);
  var_2 setModel("mp_frag_button_on_green");
  var_0.cooling_down = undefined;
}

elvira_trap_sound(var_0) {
  level endon("end_elvira_trap");
  for(;;) {
    playsoundatpos(var_0, "town_door_spear_close");
    wait(1);
  }
}

elvira_trap_dmg(var_0) {
  level endon("end_elvira_trap");
  var_1 = getent("elvira_trap_trig", "targetname");
  for(;;) {
    var_1 waittill("trigger", var_2);
    if(isDefined(level.elvira_ai) && var_2 == level.elvira_ai) {
      continue;
    }

    if(isplayer(var_2) && isalive(var_2) && !scripts\cp\cp_laststand::player_in_laststand(var_2) && !isDefined(var_2.padding_damage)) {
      var_2.padding_damage = 1;
      var_2 dodamage(20, var_1.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_electrictrap_zm");
      var_2 thread remove_padding_damage();
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.is_turned) || !scripts\cp\utility::should_be_affected_by_trap(var_2, 0, 1)) {
      continue;
    }

    if(var_2 is_crog()) {
      continue;
    }

    level thread elvira_trap_damage_zombie(var_2, var_0);
    var_3 = ["kill_trap_generic"];
    var_0 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_3), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
  }
}

elvira_trap_damage_zombie(var_0, var_1) {
  var_0 endon("death");
  var_0.marked_for_death = 1;
  var_0.full_gib = 1;
  var_0.customdeath = 1;
  var_0.nocorpse = 1;
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    var_2 = var_1;
  } else {
    var_2 = undefined;
  }

  wait(randomfloatrange(0.1, 1));
  var_0 dodamage(var_0.health + 100, var_0.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_electrictrap_zm");
}

init_elvira_trap() {
  var_0 = scripts\engine\utility::getstruct("elvira_trap", "script_noteworthy");
  var_1 = undefined;
  if(isDefined(var_0.script_area)) {
    var_1 = var_0.script_area;
  } else {
    var_1 = scripts\cp\cp_interaction::get_area_for_power(var_0);
  }

  if(isDefined(var_1)) {
    level scripts\engine\utility::waittill_any_3("power_on", var_1 + " power_on");
  }

  var_0.powered_on = 1;
  var_2 = getent(var_0.target, "targetname");
  var_2 setModel("mp_frag_button_on_green");
}

taketrapparticon(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "electric":
      var_1 = 6;
      break;

    case "propane":
      var_1 = 8;
      break;

    case "freeze":
      var_1 = 7;
      break;

    case "pool":
      var_1 = 5;
      break;

    case "lever":
      var_1 = 9;
      break;

    default:
      break;
  }

  if(var_1 > 0) {
    foreach(var_3 in level.players) {
      var_3 setclientomnvarbit("zm_charms_active", var_1, 0);
    }
  }
}

givetrapparticon(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "electric":
      var_1 = 6;
      break;

    case "propane":
      var_1 = 8;
      break;

    case "freeze":
      var_1 = 7;
      break;

    case "pool":
      var_1 = 5;
      break;

    case "lever":
      var_1 = 9;
      break;

    default:
      break;
  }

  foreach(var_3 in level.players) {
    var_3 setclientomnvarbit("zm_charms_active", var_1, 1);
  }
}