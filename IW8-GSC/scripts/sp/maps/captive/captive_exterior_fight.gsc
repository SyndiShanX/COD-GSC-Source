/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\captive\captive_exterior_fight.gsc
**************************************************************/

function exterior_fight_flags() {
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

function exterior_fight_start() {
  scripts\engine\utility::flag_set("saved_azadeh");
  scripts\engine\utility::flag_set("reached_exterior_start");
  scripts\engine\utility::flag_set("flag_vfx_exterior");
  scripts\engine\sp\utility::set_start_location("player_spawn_exterior_fight", [level.player]);
  scripts\sp\player\teenagefarah::teenage_farah_combat_setup();
  scripts\sp\maps\captive\captive_util::spawn_prisoners();
  scripts\engine\sp\utility::set_start_location("exterior_fight_ayah_start", [level.ayah]);
  scripts\engine\sp\utility::set_start_location("exterior_fight_nadia_start", [level.nadia]);

  if(isDefined(level.azadeh)) {
    scripts\engine\sp\utility::set_start_location("exterior_fight_azadeh_start", [level.azadeh]);
  }

  scripts\engine\sp\utility::set_start_location("exterior_fight_darine_start", [level.darine]);
  scripts\engine\sp\utility::set_start_location("exterior_fight_ghalia_start", [level.ghalia]);
  level.player scripts\engine\sp\utility::give_offhand("frag_farah", 2);
  scripts\sp\maps\captive\captive_lighting::lights_off("hadir_cell");
  scripts\sp\maps\captive\captive_lighting::lights_off("main_cell");
  scripts\sp\maps\captive\captive_lighting::lights_off("break_final");
  scripts\sp\maps\captive\captive_lighting::lights_off("waterboarding");
  scripts\sp\maps\captive\captive_lighting::lights_off("pre_explosion");
  scripts\sp\maps\captive\captive_lighting::lights_off("post_explosion");
  scripts\sp\maps\captive\captive_lighting::lights_off("fallen_grate");
  scripts\sp\maps\captive\captive_lighting::lights_on("upstairs");
}

function exterior_fight_main() {
  thread check_for_sniper_achievement();
  scripts\engine\sp\utility::add_global_spawn_function("axis", &check_for_vehicle_unload);
  thread scripts\sp\maps\captive\captive_lighting::exterior_cascade();
  thread allies_move_through_exterior();
  thread check_sniper_dead();
  thread fake_windows_close();
  thread warehouse_sun_settings();
  level scripts\engine\utility::delaythread(2, &do_slide_hint);
  scripts\engine\sp\utility::flagwaitthread("sniper_killed", &scripts\sp\maps\captive\captive_meet_sas::sniper_achievement_check);
  var0 = getEnt("sniper_intro_go", "targetname");
  thread scripts\engine\sp\utility::set_flag_on_trigger(var0, "sniper_intro_go");
  var1 = getaiarray("axis");

  if(var1.size) {
    thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var1, 300);
  }

  thread scripts\sp\maps\captive\captive_vo::vo_ex_all_dead_warehouse_nag();
  thread scripts\sp\maps\captive\captive_vo::vo_ex_ally_deaths();
  scripts\engine\utility::flag_wait("near_factory_gate");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("reach_building_objective", "targetname").origin);
  thread scripts\sp\analytics::analytics_kleenex_update("Top of stairs to compound gate");
  var2 = scripts\engine\utility::getStruct("sniper_scene", "targetname");
  thread start_sniper();
  scripts\engine\utility::flag_wait("reached_start_area");
  thread autosave_loop();
  var3 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("main_gate_vehicle_1");
  var4 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("main_gate_vehicle_2");
  thread sfx_veh_main_gate_trucks(var3, var4);
  level thread scripts\sp\maps\captive\captive_vo::vo_ex_reinforcements();
  wait 4;
  level.wave1guys = scripts\engine\sp\utility::array_spawn_targetname("exterior_wave_1_3", 1);
  scripts\engine\utility::flag_wait("crossed_open_area");
  var5 = scripts\engine\sp\utility::get_ai_group_ai("exterior_intro_group");

  foreach(var7 in var5) {
    var7 cleargoalvolume();
  }

  var9 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("main_gate_vehicle_3");
  thread final_vehicle_check();
  thread sfx_veh_main_gate_truck_03(var9);
  thread scripts\sp\maps\captive\captive_vo::mus_exterior_battle_stop();

  if(!scripts\engine\utility::flag("sniper_targeting_player")) {
    level thread scripts\engine\sp\utility::autosave_by_name("exterior_fight_sniper");
  }

  scripts\engine\utility::flag_wait("spawn_construction_reinforcements");

  if(!scripts\engine\utility::flag("sniper_targeting_player")) {
    level thread scripts\engine\sp\utility::autosave_by_name("exterior_fight_sniper");
  }

  thread open_side_gate();
  wait 2;
  var10 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("side_gate_vehicle_1");
  var11 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("side_gate_vehicle_2");
  thread check_close_side_gate();
  thread sfx_veh_side_gate_trucks(var10, var11);
  var12 = getaiarray("axis");

  if(var12.size <= 14) {
    scripts\engine\sp\utility::array_spawn_targetname("exterior_wave_3_extra");
  }

  scripts\engine\utility::flag_wait("reached_building_front");
  scripts\engine\sp\utility::array_spawn_targetname("building_defense", 1);

  if(!scripts\engine\utility::flag("sniper_targeting_player")) {
    level thread scripts\engine\sp\utility::autosave_by_name("exterior_fight_sniper");
  }

  scripts\engine\utility::flag_wait("approaching_building");

  if(isDefined(level.fakesniper)) {
    level.fakesniper notify("exit_nest");
  }

  scripts\engine\utility::flag_wait("reached_building");
  thread scripts\sp\analytics::analytics_kleenex_update("Compound gate to meet sas");
  level thread scripts\engine\sp\utility::autosave_by_name("meet_sas");
}

function sfx_veh_main_gate_trucks(var0, var1) {
  var0 vehicle_turnengineoff();
  var1 vehicle_turnengineoff();
  var2 = spawn("script_origin", var0.origin);
  var2 linkTo(var0);
  var2 playSound("scn_captive_truck_main_drivein_02");
  var3 = spawn("script_origin", var1.origin);
  var3 linkTo(var1);
  var3 playSound("scn_captive_truck_main_drivein_01");
  wait 8;
  var2 delete();
  var3 delete();
}

function sfx_veh_main_gate_truck_03(var0) {
  var0 vehicle_turnengineoff();
  var1 = spawn("script_origin", var0.origin);
  var1 linkTo(var0);
  var1 playSound("scn_captive_truck_main_drivein_03", "sounddone");
  var1 waittill("sounddone");
  var1 delete();
}

function sfx_veh_side_gate_trucks(var0, var1) {
  var0 vehicle_turnengineoff();
  var1 vehicle_turnengineoff();
  var2 = spawn("script_origin", var0.origin);
  var2 linkTo(var0);
  var2 playSound("scn_captive_truck_main_drivein_04");
  var3 = spawn("script_origin", var1.origin);
  var3 linkTo(var1);
  var3 playSound("scn_captive_truck_main_drivein_05");
  wait 10;
  var2 delete();
  var3 delete();
}

function check_for_sniper_achievement() {
  level endon("sniper_killed");

  for(;;) {
    self waittill("damage", var0, var0, var0, var0, var0, var0, var0, var0, var0, var1);

    if(isDefined(var1) && (var1.basename == "iw8_sn_delta" || var1.basename == "iw8_sn_scripted")) {
      level.dodgedbullet = 0;
      return;
    }
  }
}

function warehouse_sun_settings() {
  level endon("start_meet_sas_scene");

  for(;;) {
    scripts\engine\utility::flag_wait("warehouse_front");
    scripts\sp\maps\captive\captive_lighting::warehouse_cascade();
    scripts\engine\utility::flag_waitopen("warehouse_front");

    if(scripts\engine\utility::flag("start_meet_sas_scene")) {
      return;
    }

    scripts\sp\maps\captive\captive_lighting::exterior_cascade();
  }
}

function exterior_fight_catchup() {
  if(level.start_point == "bink_speech") {
    return;
  }

  scripts\engine\sp\utility::add_global_spawn_function("axis", &check_for_vehicle_unload);
  thread fake_windows_close();
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("reach_building_objective", "targetname").origin);
}

function fake_windows_close() {
  var0 = getEnt("fake_cell_windows", "targetname");
  var1 = scripts\engine\utility::getStruct("fake_cell_windows_origin", "targetname");
  var0.origin = var1.origin;
}

function do_slide_hint() {
  thread slide_monitor();
  var0 = "slide";

  if(level.player usinggamepad()) {
    if(level.player getlocalplayerprofiledata("tapToSlideEnabledGamepad")) {
      var0 = "slide_tap";
    }
  } else if(level.player getlocalplayerprofiledata("tapToSlideEnabledKeyboard")) {
    var0 = "slide_tap";
  }

  thread scripts\engine\sp\utility::display_hint(var0, 8);
}

function slide_monitor() {
  level.player scripts\engine\utility::waittill_any("sprint_slide_begin", "sprint_slide_end");
  scripts\engine\utility::flag_set("player_did_slide");
}

function player_did_slide() {
  return scripts\engine\utility::flag("player_did_slide");
}

function allies_move_through_exterior() {
  scripts\engine\utility::flag_wait("exit_factory_1");
  scripts\engine\utility::flag_wait("exit_factory_2");
  scripts\engine\utility::flag_wait("exit_factory_3");
  scripts\engine\sp\utility::activate_trigger_with_targetname("exit_factory_3");
  scripts\engine\utility::flag_wait("sniper_intro");

  foreach(var1 in scripts\engine\utility::array_removedead(level.allprisoners)) {
    var1 scripts\engine\utility::set_movement_speed(250);
  }

  scripts\engine\utility::flag_wait("sniper_intro_done");

  if(!scripts\engine\utility::flag("sniper_intro_go")) {
    scripts\engine\sp\utility::activate_trigger_with_targetname("sniper_intro_go");
  }

  scripts\engine\utility::flag_wait_or_timeout("reached_start_area", 10);
  scripts\engine\sp\utility::battlechatter_on();
  scripts\engine\utility::flag_wait("exterior_move_2");
  var3 = scripts\engine\sp\utility::spawn_targetname("rpg_enemy", 1);
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

function sniper_tracks_friendlies() {
  level endon("sniper_killed");

  for(;;) {
    level waittill("new_color_trigger");
    level thread scripts\sp\scriptedsniper::sniper_track_allies();
  }
}

function autosave_loop() {
  while(!scripts\engine\utility::flag("sniper_killed") && !scripts\engine\utility::flag("in_warehouse")) {
    wait 40;

    while(scripts\engine\utility::flag("sniper_targeting_player")) {
      wait 1;
    }

    level thread scripts\engine\sp\utility::autosave_by_name("exterior_fight_sniper");
  }
}

function start_sniper() {
  var0 = scripts\engine\utility::getStruct("fake_sniper", "targetname");
  level.fakesniper = scripts\engine\utility::spawn_script_origin(var0.origin, var0.angles);
  level.fakesniper thread scripts\sp\scriptedsniper::spawn_scripted_sniper("fake_sniper", "sniper_model", "fake_sniper_pullback", "sniper_targeting_player", "sniper_killed", "script_control");
  level.fakesniper.weapon = "iw8_sn_scripted";
  thread snipernest_damage_trigger();
  thread sniper_nest_scriptable_dmg();
  level.missileattractorent = scripts\engine\utility::spawn_script_origin(scripts\engine\utility::getStruct("missile_attractor", "targetname").origin, (0, 0, 0));
  level.snipermissileattractor = missile_createattractorent(level.missileattractorent, 3000, 800);

  if(isDefined(level.azadeh) && isalive(level.azadeh)) {
    level.fakesniper.checkgroup[level.fakesniper.checkgroup.size] = level.azadeh;
  }

  if(isDefined(level.nadia) && isalive(level.nadia)) {
    level.fakesniper.checkgroup[level.fakesniper.checkgroup.size] = level.nadia;
  }

  if(isDefined(level.ghalia) && isalive(level.ghalia)) {
    level.fakesniper.checkgroup[level.fakesniper.checkgroup.size] = level.ghalia;
  }

  level.fakesniper.slowreactweapons = ["iw8_la_rpapa7_tfarah"];
  level.fakesniper.desiredaimpos = scripts\engine\utility::getStruct("start_sniper_aim", "targetname").origin;
  level.fakesniper.aimtarget moveTo(level.fakesniper.desiredaimpos, 0.1, 0, 0);
  scripts\engine\utility::flag_wait("sniper_intro");
  level.fakesniper.desiredaimpos = scripts\engine\utility::getStruct("sniper_intro_aim", "targetname").origin;
  level.fakesniper.aimtarget moveTo(level.fakesniper.desiredaimpos, 0.5, 0.1, 0.1);
  wait 0.5;
  var1 = scripts\engine\utility::getStructArray("sniper_intro_target", "targetname");
  var2 = scripts\engine\sp\utility::get_closest_index_to_player_view(var1);
  var3 = var1[var2];
  level.fakesniper.desiredaimpos = var3.origin;
  level.fakesniper.aimtarget moveTo(level.fakesniper.desiredaimpos, 0.5, 0.1, 0.1);
  wait 0.5;
  level.fakesniper scripts\sp\scriptedsniper::sniper_fire_shot(level.fakesniper.desiredaimpos);
  wait 0.5;
  thread sniper_tracks_friendlies();
  scripts\sp\maps\captive\captive_vo::vo_ex_spot_sniper();
  scripts\engine\utility::flag_set("sniper_intro_done");
  level thread scripts\engine\sp\utility::autosave_by_name("exterior_fight_sniper_done");
  wait 5;
  level thread scripts\sp\maps\captive\captive_vo::vo_ex_spotted_by_sniper();
}

function final_vehicle_check() {
  self waittill("final_vehicle_at_gate");
  var0 = scripts\sp\maps\captive\captive_util::get_prefab_base_ent("main_gate", "script_noteworthy");
  var1 = scripts\engine\utility::getStruct("main_gate_shut", "targetname");
  var0 moveTo(var1.origin, 3.5, 1, 1);
}

function open_side_gate() {
  var0 = scripts\sp\maps\captive\captive_util::get_prefab_base_ent("side_gate", "script_noteworthy");
  var1 = scripts\engine\utility::getStruct("side_gate_open", "targetname");
  var0 moveTo(var1.origin, 3.5, 1, 1);
}

function check_close_side_gate() {
  self waittill("final_vehicle_entered");
  var0 = scripts\sp\maps\captive\captive_util::get_prefab_base_ent("side_gate", "script_noteworthy");
  var1 = scripts\engine\utility::getStruct("side_gate_closed", "targetname");
  var0 moveTo(var1.origin, 3.5, 1, 1);
}

function get_current_exterior_path(var0, var1, var2) {
  var3 = scripts\engine\utility::getStruct(var0, "targetname");
  var4 = undefined;

  if(isDefined(var1)) {
    var4 = scripts\engine\utility::getStruct(var1, "targetname");
  }

  var5 = scripts\engine\utility::getStruct(var2, "targetname");
  var6 = [var3, var5];

  if(isDefined(var4)) {
    var6 = [var3, var4, var5];
  }

  var7 = scripts\engine\utility::getclosest(level.player.origin, var6);

  if(var7 == var3) {
    return "left";
  } else if(var7 == var5) {
    return "right";
  }

  return "mid";
}

function check_sniper_dead() {
  level waittill("sniper_killed");

  if(isDefined(level.snipermissileattractor)) {
    missile_deleteattractor(level.snipermissileattractor);
    level.missileattractorent delete();
  }

  wait 2;

  if(!istrue(level.dont_callout_sniper_kill)) {
    level thread scripts\sp\maps\captive\captive_vo::vo_ex_killed_sniper();
  }

  level thread scripts\engine\sp\utility::autosave_by_name("sniper_dead");
}

function snipernest_damage_trigger() {
  level endon("sniper_killed");
  self.last_dmg_hint_time = gettime() - 10000;
  var0 = 10000;

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5);

    if(isDefined(var5) && isexplosivedamagemod(var5) && var1 > 100) {
      level.snipernest scripts\sp\utility::do_damage(20, level.snipernest.origin, level.player, undefined, "MOD_PROJECTILE_SPLASH");
      level.sniperroof hide();
      level.sniperroofdestroyed show();
      scripts\sp\analytics::analytics_event_upload("Player RPGd Sniper", 1);
    }
  }
}

function sniper_nest_scriptable_dmg() {
  level endon("sniper_killed");
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getEnt("sniper_nest", "targetname");
  var0.last_dmg_hint_time = gettime() - 10000;
  var1 = 10000;

  for(;;) {
    var0 waittill("damage", var2, var3, var2, var2, var4);

    if(scripts\engine\utility::is_equal(var3, level.player) && isDefined(var4) && scripts\engine\utility::isbulletdamage(var4)) {
      if(abs(gettime() - var0.last_dmg_hint_time) >= var1) {
        level.fakesniper notify("changed_state");
        thread supress_sniper(4);
        var0.last_dmg_hint_time = gettime();
      }
    }
  }
}

function supress_sniper(var0) {
  level.fakesniper notify("script_control");
  level.fakesniper.laser laserforceoff();
  wait var0;
  level.fakesniper.laser laserforceon();
  level.fakesniper notify("end_script_control");
}

function check_for_vehicle_unload() {
  self endon("death");
  waitframe();
  waitframe();

  if(!istrue(self.vehicle_idling)) {
    return;
  }

  self waittill("jumpedout");
  var0 = getEnt("construction_area", "targetname");
  self setgoalvolumeauto(var0);
}

function global_color_func() {
  self endon("death");
}

function rpg_ai() {
  self endon("death");
  self.dontevershoot = 1;
  self.fixednode = 1;
  thread rpg_guy_scripted();
  thread check_dropped_weapon();
  thread rpg_guy_proximity();
  level thread scripts\sp\maps\captive\captive_vo::vo_ex_rpg_guy_fired();
}

#using_animtree("generic_human");

function rpg_guy_scripted() {
  self endon("death");
  self endon("drop_rpg");
  self.used_destructible_targets = [];
  self.target_ent = spawn("script_origin", level.player.origin);
  self.ignoreall = 1;
  self setentitytarget(self.target_ent);
  self.target_ent dontinterpolate();
  var0 = 1;
  self.lastshoottime = gettime() - 3000;
  level.scr_anim["generic"]["rpg_reload"] = % sdr_com_exposed_stand_rpg_reload;
  scripts\engine\utility::set_movement_speed(250);
  var1 = scripts\engine\utility::getStructArray("rpg_guy_node", "targetname");

  for(;;) {
    foreach(var3 in var1) {
      self.goalradius = 24;
      scripts\sp\spawner::go_to_node(var3);

      for(;;) {
        var4 = rpg_get_shoot_pos();

        if(!isDefined(var4)) {
          break;
        }

        var5 = 0;

        foreach(var7 in getaiarray("axis")) {
          if(var7 scripts\engine\utility::doinglongdeath()) {
            continue;
          }

          var8 = distancesquared(var7.origin, var4);

          if(var8 <= 40000) {
            var5 = 1;
            break;
          }

          if(distancesquared(self.origin, var7.origin) < 400000 && scripts\engine\math::is_point_in_front(var7.origin)) {
            var5 = 1;
            break;
          }
        }

        if(var5) {
          break;
        }

        level notify("rpg_guy_fired");
        rpg_guy_face_target(var4);
        rpg_guy_shoot(var4);
        scripts\sp\spawner::go_to_node(var3);
        wait randomintrange(8, 14);
      }

      waitframe();
    }

    waitframe();
  }
}

function rpg_guy_proximity() {
  self endon("death");

  for(;;) {
    self.ignoreme = 1;

    while(!allies_are_close()) {
      wait 1;
    }

    break;
  }

  while(self isinscriptedstate()) {
    waitframe();
  }

  self notify("drop_rpg");
  scripts\anim\shared::forceuseweapon(self.sidearm, "primary");
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.dontevershoot = 0;
  self forcethreatupdate();
  self.newenemyreactiontime = gettime();

  if(!isDefined(self.lastattacker)) {
    self.forcenewenemyreaction = 1;
  }

  self notify("stop_going_to_node");
  self.goalradius = 1000;
}

function allies_are_close() {
  foreach(var1 in scripts\engine\utility::array_add(getaiarray("allies"), level.player)) {
    var2 = distance2dsquared(var1.origin, self.origin);

    if(var2 <= 160000) {
      return true;
    }
  }

  return false;
}

function rpg_guy_face_target(var0) {
  var1 = cos(20);
  var2 = vectortoangles(var0 - self.origin);

  for(var3 = 0; !scripts\engine\utility::within_fov(self.origin, self.angles, var0, var1) || var3 < 10; var3++) {
    self orientmode("face angle", var2[1]);
    wait 0.15;
  }
}

function rpg_guy_shoot(var0) {
  var1 = vectortoangles(var0 - self.origin);
  self.target_ent.origin = self.origin + anglesToForward(var1) * 200;
  var2 = self.origin + (0, 0, 45) + anglesToForward(var1) * 35;
  wait 0.75;
  self.lastshoottime = gettime();
  var3 = magicbullet("iw8_la_rpapa7_tfarah", var2, var0);
  thread rpg_impact(var3);
  var4 = 1.2;
  wait var4 * 0.5;
  thread scripted_reload_dmg();
  scripts\common\anim::anim_generic(self, "rpg_reload");
  self notify("done_reloading");
}

function check_dropped_weapon() {
  self endon("entitydeleted");
  self.dropweapon = 0;
  scripts\engine\utility::waittill_any("death", "drop_rpg");
  var0 = self gettagorigin("tag_weapon_right");

  if(!isDefined(var0)) {
    var0 = self.origin + (0, 0, 30);
  }

  var1 = spawn("weapon_iw8_la_rpapa7_tfarah", var0, 0);
}

function wait_for_dropped_weapon_or_timeout() {
  self endon("abort_wait_for_dropped_weapon");
  thread scripts\engine\sp\utility::notify_delay("abort_wait_for_dropped_weapon", 1);
  self waittill("weapon_dropped", var0);
  return var0;
}

function print_dot() {
  for(;;) {
    iprintln(scripts\engine\math::get_dot(level.player.origin, level.player.angles, self.origin));
    waitframe();
  }
}

function scripted_reload_dmg() {
  self endon("done_reloading");
  self waittill("damage");

  if(isalive(self)) {
    scripts\engine\sp\utility::anim_stopanimScripted();
    return;
  }
}

function rpg_get_shoot_pos() {
  var0 = scripts\engine\math::get_dot(level.player.origin, level.player.angles, self.origin);

  if(var0 > 0.929747) {
    var1 = randomintrange(60, 90);

    if(scripts\engine\utility::cointoss()) {
      var1 *= -1;
    }

    var2 = level.player getEye() + anglestoright(level.player.angles) * var1;

    if(scripts\engine\trace::ray_trace_passed(rpg_get_shoot_start_pos(var2), var2, self)) {
      return var2;
    }
  } else {
    var2 = level.player getEye() + anglesToForward(level.player.angles) * 200;

    if(scripts\engine\trace::ray_trace_passed(rpg_get_shoot_start_pos(var2), var2, self)) {
      return var2;
    }
  }

  return undefined;
}

function rpg_get_shoot_start_pos(var0) {
  return self.origin + (0, 0, 45) + anglesToForward(vectortoangles(var0 - self.origin + (0, 0, 45))) * 35;
}

function rpg_guy_death_func() {
  return false;
}

function rpg_impact(var0) {
  var0 waittill("explode", var1);

  if(isDefined(var1)) {
    thread scripts\engine\sp\utility::earthquake_and_rumble(var1);
    return;
  }
}