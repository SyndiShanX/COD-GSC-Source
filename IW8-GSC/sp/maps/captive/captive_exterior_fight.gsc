/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive_exterior_fight.gsc
******************************************************/

exterior_fight_flags() {
  scripts\engine\utility::flag_init("exit_factory_1");
  scripts\engine\utility::flag_init("exit_factory_2");
  scripts\engine\utility::flag_init("exit_factory_3");
  scripts\engine\utility::flag_init("exterior_move_2");
  scripts\engine\utility::flag_init("exterior_move_3");
  scripts\engine\utility::flag_init("exterior_move_4");
  scripts\engine\utility::flag_init("exterior_move_5");
  scripts\engine\utility::flag_init("exterior_move_6");
  scripts\engine\utility::flag_init("exterior_move_7");
  scripts\engine\utility::flag_init("near_factory_gate");
  scripts\engine\utility::flag_init("sniper_intro");
  scripts\engine\utility::flag_init("reached_start_area");
  scripts\engine\utility::flag_init("reached_open_area");
  scripts\engine\utility::flag_init("crossed_open_area");
  scripts\engine\utility::flag_init("sniper_targeting_player");
  scripts\engine\utility::flag_init("spawn_construction_reinforcements");
  scripts\engine\utility::flag_init("reached_building_front");
  scripts\engine\utility::flag_init("approaching_building");
  scripts\engine\utility::flag_init("reached_building");
  scripts\engine\utility::flag_init("sniper_killed");
  scripts\engine\utility::flag_init("flag_vfx_exterior");
  scripts\engine\utility::flag_init("sniper_intro_done");
  scripts\engine\utility::flag_init("player_did_slide");
  scripts\engine\utility::flag_init("sniper_intro_go");
}

exterior_fight_start() {
  scripts\engine\utility::flag_set("saved_azadeh");
  scripts\engine\utility::flag_set("reached_exterior_start");
  scripts\engine\utility::flag_set("flag_vfx_exterior");
  scripts\engine\sp\utility::set_start_location("player_spawn_exterior_fight", [level.player]);
  scripts\sp\player\teenagefarah::teenage_farah_combat_setup();
  scripts\sp\maps\captive\captive_util.gsc::spawn_prisoners();
  scripts\engine\sp\utility::set_start_location("exterior_fight_ayah_start", [level.ayah]);
  scripts\engine\sp\utility::set_start_location("exterior_fight_nadia_start", [level.nadia]);

  if(isDefined(level.azadeh))
    scripts\engine\sp\utility::set_start_location("exterior_fight_azadeh_start", [level.azadeh]);

  scripts\engine\sp\utility::set_start_location("exterior_fight_darine_start", [level.darine]);
  scripts\engine\sp\utility::set_start_location("exterior_fight_ghalia_start", [level.ghalia]);
  level.player scripts\engine\sp\utility::give_offhand("frag_farah", 2);
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("hadir_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("main_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("break_final");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("waterboarding");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("pre_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("post_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("fallen_grate");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("upstairs");
}

exterior_fight_main() {
  level.player thread check_for_sniper_achievement();
  scripts\engine\sp\utility::add_global_spawn_function("axis", ::check_for_vehicle_unload);
  thread scripts\sp\maps\captive\captive_lighting.gsc::exterior_cascade();
  level thread allies_move_through_exterior();
  level thread check_sniper_dead();
  level thread fake_windows_close();
  level thread warehouse_sun_settings();
  level scripts\engine\utility::delaythread(2, ::do_slide_hint);
  scripts\engine\sp\utility::flagwaitthread("sniper_killed", scripts\sp\maps\captive\captive_meet_sas.gsc::sniper_achievement_check);
  var_0 = getEnt("sniper_intro_go", "targetname");
  thread scripts\engine\sp\utility::set_flag_on_trigger(var_0, "sniper_intro_go");
  var_1 = getaiarray("axis");

  if(var_1.size)
    thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var_1, 300);

  thread scripts\sp\maps\captive\captive_vo.gsc::vo_ex_all_dead_warehouse_nag();
  thread scripts\sp\maps\captive\captive_vo.gsc::vo_ex_ally_deaths();
  scripts\engine\utility::flag_wait("near_factory_gate");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("reach_building_objective", "targetname").origin);
  thread scripts\sp\analytics::analytics_kleenex_update("Top of stairs to compound gate");
  var_2 = scripts\engine\utility::getStruct("sniper_scene", "targetname");
  level thread start_sniper();
  scripts\engine\utility::flag_wait("reached_start_area");
  level thread autosave_loop();
  var_3 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("main_gate_vehicle_1");
  var_4 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("main_gate_vehicle_2");
  thread sfx_veh_main_gate_trucks(var_3, var_4);
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ex_reinforcements();
  wait 4;
  level.wave1guys = scripts\engine\sp\utility::array_spawn_targetname("exterior_wave_1_3", 1);
  scripts\engine\utility::flag_wait("crossed_open_area");
  var_5 = scripts\engine\sp\utility::get_ai_group_ai("exterior_intro_group");

  foreach(var_7 in var_5)
  var_7 cleargoalvolume();

  var_9 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("main_gate_vehicle_3");
  var_9 thread final_vehicle_check();
  thread sfx_veh_main_gate_truck_03(var_9);
  thread scripts\sp\maps\captive\captive_vo.gsc::mus_exterior_battle_stop();

  if(!scripts\engine\utility::flag("sniper_targeting_player"))
    level thread scripts\engine\sp\utility::autosave_by_name("exterior_fight_sniper");

  scripts\engine\utility::flag_wait("spawn_construction_reinforcements");

  if(!scripts\engine\utility::flag("sniper_targeting_player"))
    level thread scripts\engine\sp\utility::autosave_by_name("exterior_fight_sniper");

  level thread open_side_gate();
  wait 2;
  var_10 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("side_gate_vehicle_1");
  var_11 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("side_gate_vehicle_2");
  var_11 thread check_close_side_gate();
  thread sfx_veh_side_gate_trucks(var_10, var_11);
  var_12 = getaiarray("axis");

  if(var_12.size <= 14)
    scripts\engine\sp\utility::array_spawn_targetname("exterior_wave_3_extra");

  scripts\engine\utility::flag_wait("reached_building_front");
  scripts\engine\sp\utility::array_spawn_targetname("building_defense", 1);

  if(!scripts\engine\utility::flag("sniper_targeting_player"))
    level thread scripts\engine\sp\utility::autosave_by_name("exterior_fight_sniper");

  scripts\engine\utility::flag_wait("approaching_building");

  if(isDefined(level.fakesniper))
    level.fakesniper notify("exit_nest");

  scripts\engine\utility::flag_wait("reached_building");
  thread scripts\sp\analytics::analytics_kleenex_update("Compound gate to meet sas");
  level thread scripts\engine\sp\utility::autosave_by_name("meet_sas");
}

sfx_veh_main_gate_trucks(var_0, var_1) {
  var_0 vehicle_turnengineoff();
  var_1 vehicle_turnengineoff();
  var_2 = spawn("script_origin", var_0.origin);
  var_2 linkTo(var_0);
  var_2 playSound("scn_captive_truck_main_drivein_02");
  var_3 = spawn("script_origin", var_1.origin);
  var_3 linkTo(var_1);
  var_3 playSound("scn_captive_truck_main_drivein_01");
  wait 8;
  var_2 delete();
  var_3 delete();
}

sfx_veh_main_gate_truck_03(var_0) {
  var_0 vehicle_turnengineoff();
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkTo(var_0);
  var_1 playSound("scn_captive_truck_main_drivein_03", "sounddone");
  var_1 waittill("sounddone");
  var_1 delete();
}

sfx_veh_side_gate_trucks(var_0, var_1) {
  var_0 vehicle_turnengineoff();
  var_1 vehicle_turnengineoff();
  var_2 = spawn("script_origin", var_0.origin);
  var_2 linkTo(var_0);
  var_2 playSound("scn_captive_truck_main_drivein_04");
  var_3 = spawn("script_origin", var_1.origin);
  var_3 linkTo(var_1);
  var_3 playSound("scn_captive_truck_main_drivein_05");
  wait 10;
  var_2 delete();
  var_3 delete();
}

check_for_sniper_achievement() {
  level endon("sniper_killed");

  for(;;) {
    self waittill("damage", var_0, var_0, var_0, var_0, var_0, var_0, var_0, var_0, var_0, var_1);

    if(isDefined(var_1) && (var_1.basename == "iw8_sn_delta" || var_1.basename == "iw8_sn_scripted")) {
      level.dodgedbullet = 0;
      return;
    }
  }
}

warehouse_sun_settings() {
  level endon("start_meet_sas_scene");

  for(;;) {
    scripts\engine\utility::flag_wait("warehouse_front");
    scripts\sp\maps\captive\captive_lighting.gsc::warehouse_cascade();
    scripts\engine\utility::flag_waitopen("warehouse_front");

    if(scripts\engine\utility::flag("start_meet_sas_scene")) {
      return;
    }
    scripts\sp\maps\captive\captive_lighting.gsc::exterior_cascade();
  }
}

exterior_fight_catchup() {
  if(level.start_point == "bink_speech") {
    return;
  }
  scripts\engine\sp\utility::add_global_spawn_function("axis", ::check_for_vehicle_unload);
  thread fake_windows_close();
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("reach_building_objective", "targetname").origin);
}

fake_windows_close() {
  var_0 = getEnt("fake_cell_windows", "targetname");
  var_1 = scripts\engine\utility::getStruct("fake_cell_windows_origin", "targetname");
  var_0.origin = var_1.origin;
}

do_slide_hint() {
  thread slide_monitor();
  var_0 = "slide";

  if(level.player usinggamepad()) {
    if(level.player getlocalplayerprofiledata("tapToSlideEnabledGamepad"))
      var_0 = "slide_tap";
  } else if(level.player getlocalplayerprofiledata("tapToSlideEnabledKeyboard"))
    var_0 = "slide_tap";

  thread scripts\engine\sp\utility::display_hint(var_0, 8);
}

slide_monitor() {
  level.player scripts\engine\utility::waittill_any("sprint_slide_begin", "sprint_slide_end");
  scripts\engine\utility::flag_set("player_did_slide");
}

player_did_slide() {
  return scripts\engine\utility::flag("player_did_slide");
}

allies_move_through_exterior() {
  scripts\engine\utility::flag_wait("exit_factory_1");
  scripts\engine\utility::flag_wait("exit_factory_2");
  scripts\engine\utility::flag_wait("exit_factory_3");
  scripts\engine\sp\utility::activate_trigger_with_targetname("exit_factory_3");
  scripts\engine\utility::flag_wait("sniper_intro");

  foreach(var_1 in scripts\engine\utility::array_removedead(level.allprisoners))
  var_1 scripts\engine\utility::set_movement_speed(250);

  scripts\engine\utility::flag_wait("sniper_intro_done");

  if(!scripts\engine\utility::flag("sniper_intro_go"))
    scripts\engine\sp\utility::activate_trigger_with_targetname("sniper_intro_go");

  scripts\engine\utility::flag_wait_or_timeout("reached_start_area", 10);
  scripts\engine\sp\utility::battlechatter_on();
  scripts\engine\utility::flag_wait("exterior_move_2");
  var_3 = scripts\engine\sp\utility::spawn_targetname("rpg_enemy", 1);
  scripts\engine\utility::flag_wait("exterior_move_3");

  switch (get_current_exterior_path("move4_left", undefined, "move4_right")) {
    case "left":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_5");

  switch (get_current_exterior_path("stack_to_left", "stack_to_mid", "stack_to_right")) {
    case "left":
      break;
    case "mid":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_6");

  switch (get_current_exterior_path("stack_to_left", "stack_to_mid", "stack_to_right")) {
    case "left":
      break;
    case "mid":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_7");

  switch (get_current_exterior_path("stack_to_left", "stack_to_mid", "stack_to_right")) {
    case "left":
      break;
    case "mid":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_8");

  switch (get_current_exterior_path("stack_to_left", "stack_to_mid", "stack_to_right")) {
    case "left":
      break;
    case "mid":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_9");

  switch (get_current_exterior_path("mid_stack_to_left", "mid_stack_to_mid", "mid_stack_to_right")) {
    case "left":
      break;
    case "mid":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_10");

  switch (get_current_exterior_path("mid_stack_to_left", "mid_stack_to_mid", "mid_stack_to_right")) {
    case "left":
      break;
    case "mid":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_11");

  switch (get_current_exterior_path("mid_stack_to_left", "mid_stack_to_mid", "mid_stack_to_right")) {
    case "left":
      break;
    case "mid":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_12");

  switch (get_current_exterior_path("mid_stack_to_left", "mid_stack_to_mid", "mid_stack_to_right")) {
    case "left":
      break;
    case "mid":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_13");

  switch (get_current_exterior_path("mid_stack_to_left", "mid_stack_to_mid", "mid_stack_to_right")) {
    case "left":
      break;
    case "mid":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_14");

  switch (get_current_exterior_path("end_stack_to_left", undefined, "end_stack_to_right")) {
    case "left":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_15");

  switch (get_current_exterior_path("end_stack_to_left", undefined, "end_stack_to_right")) {
    case "left":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_16");

  switch (get_current_exterior_path("end_stack_to_left", undefined, "end_stack_to_right")) {
    case "left":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_17");

  switch (get_current_exterior_path("end_stack_to_left", undefined, "end_stack_to_right")) {
    case "left":
      break;
    case "right":
      break;
  }

  scripts\engine\utility::flag_wait("exterior_move_18");
  scripts\engine\sp\utility::activate_trigger_with_targetname("exterior_move_18");
}

sniper_tracks_friendlies() {
  level endon("sniper_killed");

  for(;;) {
    level waittill("new_color_trigger");
    level thread scripts\sp\scriptedsniper::sniper_track_allies();
  }
}

autosave_loop() {
  while(!scripts\engine\utility::flag("sniper_killed") && !scripts\engine\utility::flag("in_warehouse")) {
    wait 40;

    while(scripts\engine\utility::flag("sniper_targeting_player"))
      wait 1;

    level thread scripts\engine\sp\utility::autosave_by_name("exterior_fight_sniper");
  }
}

start_sniper() {
  var_0 = scripts\engine\utility::getStruct("fake_sniper", "targetname");
  level.fakesniper = scripts\engine\utility::spawn_script_origin(var_0.origin, var_0.angles);
  level.fakesniper thread scripts\sp\scriptedsniper::spawn_scripted_sniper("fake_sniper", "sniper_model", "fake_sniper_pullback", "sniper_targeting_player", "sniper_killed", "script_control");
  level.fakesniper.weapon = "iw8_sn_scripted";
  getEnt("snipernest_damage_trigger", "targetname") thread snipernest_damage_trigger();
  thread sniper_nest_scriptable_dmg();
  level.missileattractorent = scripts\engine\utility::spawn_script_origin(scripts\engine\utility::getStruct("missile_attractor", "targetname").origin, (0, 0, 0));
  level.snipermissileattractor = missile_createattractorent(level.missileattractorent, 3000, 800);

  if(isDefined(level.azadeh) && isalive(level.azadeh))
    level.fakesniper.checkgroup[level.fakesniper.checkgroup.size] = level.azadeh;

  if(isDefined(level.nadia) && isalive(level.nadia))
    level.fakesniper.checkgroup[level.fakesniper.checkgroup.size] = level.nadia;

  if(isDefined(level.ghalia) && isalive(level.ghalia))
    level.fakesniper.checkgroup[level.fakesniper.checkgroup.size] = level.ghalia;

  level.fakesniper.slowreactweapons = ["iw8_la_rpapa7_tfarah"];
  level.fakesniper.desiredaimpos = scripts\engine\utility::getStruct("start_sniper_aim", "targetname").origin;
  level.fakesniper.aimtarget moveTo(level.fakesniper.desiredaimpos, 0.1, 0, 0);
  scripts\engine\utility::flag_wait("sniper_intro");
  level.fakesniper.desiredaimpos = scripts\engine\utility::getStruct("sniper_intro_aim", "targetname").origin;
  level.fakesniper.aimtarget moveTo(level.fakesniper.desiredaimpos, 0.5, 0.1, 0.1);
  wait 0.5;
  var_1 = scripts\engine\utility::getStructArray("sniper_intro_target", "targetname");
  var_2 = scripts\engine\sp\utility::get_closest_index_to_player_view(var_1);
  var_3 = var_1[var_2];
  level.fakesniper.desiredaimpos = var_3.origin;
  level.fakesniper.aimtarget moveTo(level.fakesniper.desiredaimpos, 0.5, 0.1, 0.1);
  wait 0.5;
  level.fakesniper scripts\sp\scriptedsniper::sniper_fire_shot(level.fakesniper.desiredaimpos);
  wait 0.5;
  level thread sniper_tracks_friendlies();
  scripts\sp\maps\captive\captive_vo.gsc::vo_ex_spot_sniper();
  scripts\engine\utility::flag_set("sniper_intro_done");
  level thread scripts\engine\sp\utility::autosave_by_name("exterior_fight_sniper_done");
  wait 5;
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ex_spotted_by_sniper();
}

final_vehicle_check() {
  self waittill("final_vehicle_at_gate");
  var_0 = scripts\sp\maps\captive\captive_util.gsc::get_prefab_base_ent("main_gate", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("main_gate_shut", "targetname");
  var_0 moveTo(var_1.origin, 3.5, 1, 1);
}

open_side_gate() {
  var_0 = scripts\sp\maps\captive\captive_util.gsc::get_prefab_base_ent("side_gate", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("side_gate_open", "targetname");
  var_0 moveTo(var_1.origin, 3.5, 1, 1);
}

check_close_side_gate() {
  self waittill("final_vehicle_entered");
  var_0 = scripts\sp\maps\captive\captive_util.gsc::get_prefab_base_ent("side_gate", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("side_gate_closed", "targetname");
  var_0 moveTo(var_1.origin, 3.5, 1, 1);
}

get_current_exterior_path(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_4 = undefined;

  if(isDefined(var_1))
    var_4 = scripts\engine\utility::getStruct(var_1, "targetname");

  var_5 = scripts\engine\utility::getStruct(var_2, "targetname");
  var_6 = [var_3, var_5];

  if(isDefined(var_4))
    var_6 = [var_3, var_4, var_5];

  var_7 = scripts\engine\utility::getclosest(level.player.origin, var_6);

  if(var_7 == var_3)
    return "left";
  else if(var_7 == var_5)
    return "right";

  return "mid";
}

check_sniper_dead() {
  level waittill("sniper_killed");

  if(isDefined(level.snipermissileattractor)) {
    missile_deleteattractor(level.snipermissileattractor);
    level.missileattractorent delete();
  }

  wait 2;

  if(!istrue(level.dont_callout_sniper_kill))
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ex_killed_sniper();

  level thread scripts\engine\sp\utility::autosave_by_name("sniper_dead");
}

snipernest_damage_trigger() {
  level endon("sniper_killed");
  self.last_dmg_hint_time = gettime() - 10000;
  var_0 = 10000;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_5) && isexplosivedamagemod(var_5) && var_1 > 100) {
      level.snipernest scripts\sp\utility::do_damage(20, level.snipernest.origin, level.player, undefined, "MOD_PROJECTILE_SPLASH");
      level.sniperroof hide();
      level.sniperroofdestroyed show();
      scripts\sp\analytics::analytics_event_upload("Player RPGd Sniper", 1);
    }
  }
}

sniper_nest_scriptable_dmg() {
  level endon("sniper_killed");
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getEnt("sniper_nest", "targetname");
  var_0.last_dmg_hint_time = gettime() - 10000;
  var_1 = 10000;

  for(;;) {
    var_0 waittill("damage", var_2, var_3, var_2, var_2, var_4);

    if(scripts\engine\utility::is_equal(var_3, level.player) && isDefined(var_4) && scripts\engine\utility::isbulletdamage(var_4)) {
      if(abs(gettime() - var_0.last_dmg_hint_time) >= var_1) {
        level.fakesniper notify("changed_state");
        thread supress_sniper(4);
        var_0.last_dmg_hint_time = gettime();
      }
    }
  }
}

supress_sniper(var_0) {
  level.fakesniper notify("script_control");
  level.fakesniper.laser laserforceoff();
  wait(var_0);
  level.fakesniper.laser laserforceon();
  level.fakesniper notify("end_script_control");
}

check_for_vehicle_unload() {
  self endon("death");
  waitframe();
  waitframe();

  if(!istrue(self.vehicle_idling)) {
    return;
  }
  self waittill("jumpedout");
  var_0 = getEnt("construction_area", "targetname");
  self setgoalvolumeauto(var_0);
}

global_color_func() {
  self endon("death");
}

rpg_ai() {
  self endon("death");
  self.dontevershoot = 1;
  self.fixednode = 1;
  thread rpg_guy_scripted();
  thread check_dropped_weapon();
  thread rpg_guy_proximity();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ex_rpg_guy_fired();
}

#using_animtree("generic_human");

rpg_guy_scripted() {
  self endon("death");
  self endon("drop_rpg");
  self.used_destructible_targets = [];
  self.target_ent = spawn("script_origin", level.player.origin);
  self.ignoreall = 1;
  self setentitytarget(self.target_ent);
  self.target_ent dontinterpolate();
  var_0 = 1;
  self.lastshoottime = gettime() - 3000;
  level.scr_anim["generic"]["rpg_reload"] = % sdr_com_exposed_stand_rpg_reload;
  scripts\engine\utility::set_movement_speed(250);
  var_1 = scripts\engine\utility::getStructArray("rpg_guy_node", "targetname");

  for(;;) {
    foreach(var_3 in var_1) {
      self.goalradius = 24;
      scripts\sp\spawner::go_to_node(var_3);

      for(;;) {
        var_4 = rpg_get_shoot_pos();

        if(!isDefined(var_4)) {
          break;
        }

        var_5 = 0;

        foreach(var_7 in getaiarray("axis")) {
          if(var_7 scripts\engine\utility::doinglongdeath()) {
            continue;
          }
          var_8 = distancesquared(var_7.origin, var_4);

          if(var_8 <= 40000) {
            var_5 = 1;
            break;
          }

          if(distancesquared(self.origin, var_7.origin) < 400000 && scripts\engine\math::is_point_in_front(var_7.origin)) {
            var_5 = 1;
            break;
          }
        }

        if(var_5) {
          break;
        }

        level notify("rpg_guy_fired");
        rpg_guy_face_target(var_4);
        rpg_guy_shoot(var_4);
        scripts\sp\spawner::go_to_node(var_3);
        wait(randomintrange(8, 14));
      }

      waitframe();
    }

    waitframe();
  }
}

rpg_guy_proximity() {
  self endon("death");

  for(;;) {
    self.ignoreme = 1;

    while(!allies_are_close())
      wait 1;

    break;
  }

  while(self isinscriptedstate())
    waitframe();

  self notify("drop_rpg");
  scripts\anim\shared.gsc::forceuseweapon(self.sidearm, "primary");
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.dontevershoot = 0;
  self forcethreatupdate();
  self.newenemyreactiontime = gettime();

  if(!isDefined(self.lastattacker))
    self.forcenewenemyreaction = 1;

  self notify("stop_going_to_node");
  self.goalradius = 1000;
}

allies_are_close() {
  foreach(var_1 in scripts\engine\utility::array_add(getaiarray("allies"), level.player)) {
    var_2 = distance2dsquared(var_1.origin, self.origin);

    if(var_2 <= 160000)
      return 1;
  }

  return 0;
}

rpg_guy_face_target(var_0) {
  var_1 = cos(20);
  var_2 = vectortoangles(var_0 - self.origin);

  for(var_3 = 0; !scripts\engine\utility::within_fov(self.origin, self.angles, var_0, var_1) || var_3 < 10; var_3++) {
    self orientmode("face angle", var_2[1]);
    wait 0.15;
  }
}

rpg_guy_shoot(var_0) {
  var_1 = vectortoangles(var_0 - self.origin);
  self.target_ent.origin = self.origin + anglesToForward(var_1) * 200;
  var_2 = self.origin + (0, 0, 45) + anglesToForward(var_1) * 35;
  wait 0.75;
  self.lastshoottime = gettime();
  var_3 = magicbullet("iw8_la_rpapa7_tfarah", var_2, var_0);
  thread rpg_impact(var_3);
  var_4 = 1.2;
  wait(var_4 * 0.5);
  thread scripted_reload_dmg();
  scripts\common\anim::anim_generic(self, "rpg_reload");
  self notify("done_reloading");
}

check_dropped_weapon() {
  self endon("entitydeleted");
  self.dropweapon = 0;
  scripts\engine\utility::waittill_any("death", "drop_rpg");
  var_0 = self gettagorigin("tag_weapon_right");

  if(!isDefined(var_0))
    var_0 = self.origin + (0, 0, 30);

  var_1 = spawn("weapon_iw8_la_rpapa7_tfarah", var_0, 0);
}

wait_for_dropped_weapon_or_timeout() {
  self endon("abort_wait_for_dropped_weapon");
  thread scripts\engine\sp\utility::notify_delay("abort_wait_for_dropped_weapon", 1);
  self waittill("weapon_dropped", var_0);
  return var_0;
}

print_dot() {
  for(;;) {
    iprintln(scripts\engine\math::get_dot(level.player.origin, level.player.angles, self.origin));
    waitframe();
  }
}

scripted_reload_dmg() {
  self endon("done_reloading");
  self waittill("damage");

  if(isalive(self))
    scripts\engine\sp\utility::anim_stopanimScripted();
}

rpg_get_shoot_pos() {
  var_0 = scripts\engine\math::get_dot(level.player.origin, level.player.angles, self.origin);

  if(var_0 > 0.929747) {
    var_1 = randomintrange(60, 90);

    if(scripts\engine\utility::cointoss())
      var_1 = var_1 * -1;

    var_2 = level.player getEye() + anglestoright(level.player.angles) * var_1;

    if(scripts\engine\trace::ray_trace_passed(rpg_get_shoot_start_pos(var_2), var_2, self))
      return var_2;
  } else {
    var_2 = level.player getEye() + anglesToForward(level.player.angles) * 200;

    if(scripts\engine\trace::ray_trace_passed(rpg_get_shoot_start_pos(var_2), var_2, self))
      return var_2;
  }

  return undefined;
}

rpg_get_shoot_start_pos(var_0) {
  return self.origin + (0, 0, 45) + anglesToForward(vectortoangles(var_0 - self.origin + (0, 0, 45))) * 35;
}

rpg_guy_death_func() {
  return 0;
}

rpg_impact(var_0) {
  var_0 waittill("explode", var_1);

  if(isDefined(var_1))
    thread scripts\engine\sp\utility::earthquake_and_rumble(var_1);
}