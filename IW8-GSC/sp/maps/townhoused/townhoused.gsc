/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\townhoused\townhoused.gsc
***********************************************/

main() {
  level.demo = scripts\sp\utility::is_demo();
  scripts\sp\maps\townhoused\gen\townhoused_art.gsc::main();
  scripts\sp\maps\townhoused\townhoused_fx.gsc::main();
  scripts\sp\maps\townhoused\townhoused_precache.gsc::main();
  scripts\sp\maps\townhoused\townhoused_lighting.gsc::main();
  scripts\sp\maps\townhoused\townhoused_anim.gsc::main();
  precache();
  init_strings();
  init_squads();
  scripts\sp\maps\townhoused\townhoused_code.gsc::init_footsteps();
  level.default_goalheight = 80;
  var_0 = scripts\sp\player_rig::get_player_rig();
  var_0 hide();
  scripts\engine\sp\utility::set_default_start("backyard_intro");
  var_1 = undefined;
  scripts\engine\sp\utility::add_start("backyard_intro", ::backyard_intro_start, var_1, ::backyard_intro_main, var_1);
  scripts\engine\sp\utility::add_start("backyard", ::backyard_start, var_1, ::backyard_main, var_1, ::backyard_catchup);
  scripts\engine\sp\utility::add_start("kitchen", ::kitchen_start, var_1, ::kitchen_main, var_1, ::kitchen_catchup);
  scripts\engine\sp\utility::add_start("dining_room", ::dining_room_start, var_1, ::dining_room_main, var_1, ::dining_room_catchup);
  scripts\engine\sp\utility::add_start("stairtrain1", ::stairtrain1_start, var_1, ::stairtrain1_main, var_1, ::stairtrain1_catchup);
  scripts\engine\sp\utility::add_start("2nd_floor", ::second_floor_start, var_1, ::second_floor_main, var_1, ::second_floor_catchup);
  scripts\engine\sp\utility::add_start("stairtrain2", ::stairtrain2_start, var_1, ::stairtrain2_main, var_1);
  scripts\engine\sp\utility::add_start("3rd_floor", ::third_floor_start, var_1, ::third_floor_main, var_1, ::third_floor_catchup);
  scripts\engine\sp\utility::add_start("stairtrain3", ::stairtrain3_start, var_1, ::stairtrain3_main, var_1);
  scripts\engine\sp\utility::add_start("4th_floor", ::fourth_floor_start, var_1, ::fourth_floor_main, var_1, ::fourth_floor_catchup);
  scripts\engine\sp\utility::add_start("attic", ::attic_start, var_1, ::attic_main, var_1);
  level.door_hint_dist_scale = 0.8;
  init_introscreen();
  scripts\engine\utility::delaythread(0.2, scripts\sp\player\context_melee::disable_dynamic_takedowns);
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  scripts\sp\stealth\manager::main();
  level.player thread scripts\stealth\player::main();
  init_spawnfunctions();
  scripts\sp\nvg\nvg_player::main("nvg_townhoused");
  init_dvars();
  init_flags();
  scripts\sp\maps\townhoused\townhoused_code.gsc::deployable_ladder_init();
  setsaveddvar("NOSQLKNSQO", 45);
  setsaveddvar("TLMMOPMSK", 1);
  setsaveddvar("NKLMONNPNN", 512);
  setsaveddvar("NQQSKRQMTS", 0);
  setdvarifuninitialized("scr_bedguy_alt", 0);
  setdvarifuninitialized("scr_switch_to_ground", 0);
  setdvarifuninitialized("scr_ladder_hack", 0);
  setdvarifuninitialized("scr_golden_path_fail_print", 0);
  setomnvar("ai_fulllight", 0.01);
  setomnvar("ai_nolight", 0.008);
  scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::battlechatter_off);
  thread init_demo();
  init_hints();
  scripts\sp\maps\townhoused\townhoused_code.gsc::init_train();
  init_script_brushmodels();
  init_auto_crouch();
  thread patch_ent_fixes();
  thread init_door_state();
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::baby_cry();
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::kitchen_player_deployed_ladder();
  level thread scripts\sp\maps\townhoused\townhoused_code.gsc::player_going_loud();
  scripts\sp\maps\townhoused\townhoused_code.gsc::ai_stance_init();
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::ambient_garage_welding();
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::track_player_weapon_fire_time();
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::bump_weapon_onpickup();
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::nvg_death_hint();
  level thread scripts\sp\maps\townhoused\townhoused_code.gsc::planes();
  scripts\sp\maps\townhoused\townhoused_code.gsc::init_player_clips();
  level.player.lastprojectiledamagetime["flash"] = 0;
  level.player.lastprojectiledamagetime["frag"] = 0;
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::player_grenade_fire_thread();

  if(scripts\sp\starts::is_after_start("overwatch"))
    townhouse_stealth_settings();
  else
    streets_stealth_settings();

  level.dialoguelinescale = 1.25;
  var_2["price_at_dining_room"] = scripts\sp\maps\townhoused\townhoused_inner.gsc::price_dining_room;
  var_2["price_end_dining_room"] = scripts\sp\maps\townhoused\townhoused_inner.gsc::price_dining_room_end;
  scripts\sp\maps\townhoused\townhoused_code.gsc::add_scripted_movement_arrivefuncs("dining_room", var_2);
  level.stealth.bstayincombatoncealerted = 1;
  thread audio_door_sound_clip_init();
  init_dynolights_state();
}

patch_ent_fixes() {
  var_0 = getEntArray("trigger_multiple_flag_set", "classname");

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.script_flag, "player_at_attic_stairs"))
      var_2.origin = var_2.origin + (0, 0, 11);
  }
}

recently_loaded_thread() {
  for(;;) {
    if(issaverecentlyloaded())
      iprintlnbold("---- RECENTLY LOADED ----");

    waitframe();
  }
}

init_demo() {
  if(!istrue(level.demo)) {
    return;
  }
  setsaveddvar("LKQLKNRLQ", 0);
  var_0 = getspawner("buddy_down_enemy", "script_noteworthy");
  var_0.script_moveoverride = 1;
  var_1 = getnode(var_0.target, "targetname");
  var_2 = getnodearray(var_1.target, "targetname");

  foreach(var_1 in var_2) {
    if(var_1.type == "Cover Right")
      var_0.go_to_node = var_1;
  }

  var_5 = scripts\engine\sp\utility::get_spawner_array("dining_enemies", "script_noteworthy");

  foreach(var_0 in var_5) {
    if(var_0.script_animname == "dining_enemy1") {
      var_0.script_char_index = 1;
      continue;
    }

    if(var_0.script_animname == "dining_enemy2")
      var_0.script_char_index = 3;
  }

  var_0 = getspawner("bed_guy", "script_noteworthy");
  var_0.script_char_index = 7;
}

init_introscreen() {
  scripts\engine\sp\utility::intro_screen_custom_func(::introscreen_delayed);
}

init_spawnfunctions() {
  scripts\engine\sp\utility::add_global_spawn_function("allies", scripts\sp\maps\townhoused\townhoused_code.gsc::postspawn_allies);
  scripts\engine\sp\utility::add_global_spawn_function("axis", scripts\sp\maps\townhoused\townhoused_code.gsc::postspawn_axis);
  scripts\engine\sp\utility::array_spawn_function_targetname("bravo2", scripts\sp\maps\townhoused\townhoused_code.gsc::postspawn_bravo2);
  scripts\engine\sp\utility::array_spawn_function_targetname("bravo3", scripts\sp\maps\townhoused\townhoused_code.gsc::postspawn_bravo3);
  scripts\engine\sp\utility::array_spawn_function_targetname("bravo4", scripts\sp\maps\townhoused\townhoused_inner.gsc::postspawn_bravo4);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("price", scripts\sp\maps\townhoused\townhoused_code.gsc::postspawn_friendlies);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("backyard_alley_extra", scripts\sp\maps\townhoused\townhoused_inner.gsc::postspawn_backyard_alley_extra);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("dining_enemies", scripts\sp\maps\townhoused\townhoused_inner.gsc::postspawn_dining_enemy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("2nd_floor_enemies", scripts\sp\maps\townhoused\townhoused_inner.gsc::postspawn_second_floor_enemy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("buddy_down_enemy", scripts\sp\maps\townhoused\townhoused_inner.gsc::postspawn_buddy_down_enemy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("buddy_down_gunner", scripts\sp\maps\townhoused\townhoused_inner.gsc::postspawn_buddy_down_gunner);
  scripts\engine\sp\utility::array_spawn_function_targetname("hiding_door_enemy", scripts\sp\maps\townhoused\townhoused_inner.gsc::postspawn_hiding_door_enemy);
  scripts\engine\sp\utility::array_spawn_function_targetname("bravo4_reinforcements", scripts\sp\maps\townhoused\townhoused_inner.gsc::postspawn_bravo4_reinforcement);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("baby_mom", scripts\sp\maps\townhoused\townhoused_inner.gsc::postspawn_baby_mom);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("bed_guy", scripts\sp\maps\townhoused\townhoused_inner.gsc::postspawn_bed_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("attic_enemy", scripts\sp\maps\townhoused\townhoused_inner.gsc::postspawn_attic_enemy);
}

precache() {
  precacheshader("intel_hint_icon");
  precachemodel("default_character_shadow");
  precachemodel("tag_origin_only_collision");
  precachemodel("com_junktire");
  precacheitem("flash");
  precachemodel("london_computer_monitor_broken_stage_1");
  precachemodel("computer_pc_tower_01");
  precachemodel("misc_keyboard_black_01");
  precachemodel("misc_computer_mouse_black_01");
  precachemodel("com_copypaper_box");
  precachemodel("com_copypaper_box_open");
  precacheshader("hint_mantle");

  if(getdvarint("LLQQOPKTKM") || getdvarint("SMNRNLNRN") > 0) {
    return;
  }
  var_0 = scripts\sp\maps\townhoused\townhoused_code.gsc::get_player_weapons();

  foreach(var_2 in var_0) {
    var_3 = getweaponviewmodel(var_2);
    precachemodel(var_3);
  }

  level.sniper_rifle = spawnStruct();
  level.sniper_rifle.name = "iw8_ar_mcharlie";
  level.sniper_rifle.attachments = ["lasermic_townhouse", "silencer_west01_townhouse", "bipod", "snprscope_alpha50_townhouse"];
  level.sniper_rifle.stowed_weapon = scripts\sp\utility::make_weapon(level.sniper_rifle.name, level.sniper_rifle.attachments);
}

introscreen_delayed() {
  scripts\engine\utility::flag_wait("show_introscreen");
  scripts\sp\introscreen::introscreen(1);
}

init_hints() {}

init_squads() {
  level.squads = [];
  level.squads["alpha"] = [];
  level.squads["bravo"] = [];
  level.squads["bravo2"] = [];
  level.squads["bravo3"] = [];
  level.squads["bravo4"] = [];
  level.squads["charlie"] = [];
}

init_strings() {}

init_dvars() {
  setDvar("scr_disable_civ_kills", 1);
  setdvarifuninitialized("scr_attic_switch", 0);
  setdvarifuninitialized("scr_debug_going_hot", 0);
}

init_dynolights_state() {
  scripts\engine\utility::flag_wait("scriptables_ready");

  foreach(var_1 in level.dynolights) {
    if(issubstr(var_1.script_noteworthy, "_off_"))
      var_1 setscriptablepartstate("onoff", "off");

    var_1.nextflickertime = 0;

    if(var_1 scripts\sp\maps\townhoused\townhoused_code.gsc::has_multiple_lights())
      var_1 thread scripts\sp\maps\townhoused\townhoused_code.gsc::lights_off_thread();
  }
}

init_flags() {
  scripts\engine\utility::flag_init("pause_nag");
  scripts\engine\utility::flag_init("player_can_go_loud");
  scripts\engine\utility::flag_init("show_introscreen");
  scripts\engine\utility::flag_init("start_player_exit_apc");
  scripts\engine\utility::flag_init("player_exited_apc");
  scripts\engine\utility::flag_init("apc_exited");
  scripts\engine\utility::flag_init("bravo_gate_setup");
  scripts\engine\utility::flag_init("street_apc_wait");
  scripts\engine\utility::flag_init("street_apc_stops");
  scripts\engine\utility::flag_init("street_movement_done");
  scripts\engine\utility::flag_init("cutter_at_alley_gate");
  scripts\engine\utility::flag_init("price_at_alley_gate");
  scripts\engine\utility::flag_init("price_at_end_of_alley");
  scripts\engine\utility::flag_init("price_ready_for_garage_entry");
  scripts\engine\utility::flag_init("price_inside_garage");
  scripts\engine\utility::flag_init("price_near_garage_office");
  scripts\engine\utility::flag_init("player_used_garage_office_snakecam");
  scripts\engine\utility::flag_init("player_missed_garage_office_snakecam");
  scripts\engine\utility::flag_init("garage_office_reacted");
  scripts\engine\utility::flag_init("office_runner_step_over");
  scripts\engine\utility::flag_init("priced_got_to_garage2");
  scripts\engine\utility::flag_init("price_cleared_office");
  scripts\engine\utility::flag_init("price_open_garage_exit_door");
  scripts\engine\utility::flag_init("cellphone_guy_executed");
  scripts\engine\utility::flag_init("player_near_garage_entry");
  scripts\engine\utility::flag_init("garage2_lights_off");
  scripts\engine\utility::flag_init("garage2_lower_carjack");
  scripts\engine\utility::flag_init("price_garage2_animate");
  scripts\engine\utility::flag_init("garage2_train_start");
  scripts\engine\utility::flag_init("price_garage2_done");
  scripts\engine\utility::flag_init("garage_hot");
  scripts\engine\utility::flag_init("cleanup_garage2");
  scripts\engine\utility::flag_init("backyard_alley_extra_move");
  scripts\engine\utility::flag_init("backyard_alley_ready");
  scripts\engine\utility::flag_init("backyard_basement_ready");
  scripts\engine\utility::flag_init("basement_freeze_ready");
  scripts\engine\utility::flag_init("bravo4_in_position");
  scripts\engine\utility::flag_init("backdoor_enter");
  scripts\engine\utility::flag_init("backdoor_enter_done");
  scripts\engine\utility::flag_init("top_of_ladder_failsafe");
  scripts\engine\utility::flag_init("combat_hot");
  scripts\engine\utility::flag_init("player_deploying_kitchen_ladder");
  scripts\engine\utility::flag_init("player_on_ladder");
  scripts\engine\utility::flag_init("player_top_of_ladder");
  scripts\engine\utility::flag_init("player_in_kitchen");
  scripts\engine\utility::flag_init("kitchen_girl_secured");
  scripts\engine\utility::flag_init("kitchen_done");
  scripts\engine\utility::flag_init("kitchen_intro_vo_done");
  scripts\engine\utility::flag_init("dining_room_player_should_engage");
  scripts\engine\utility::flag_init("dining_room_react");
  scripts\engine\utility::flag_init("dining_room_done");
  scripts\engine\utility::flag_init("dining_room_drop_em_ready");
  scripts\engine\utility::flag_init("dining_room_dialogue_finished");
  scripts\engine\utility::flag_init("player_said_dining_clear");
  scripts\engine\utility::flag_init("dining_room_price_in_position");
  scripts\engine\utility::flag_init("stairtrain1_go");
  scripts\engine\utility::flag_init("stairtrain1_started");
  scripts\engine\utility::flag_init("stairtrain1_done");
  scripts\engine\utility::flag_init("delete_stair_player_pusher");
  scripts\engine\utility::flag_init("boy_near_bathroom");
  scripts\engine\utility::flag_init("2ndfloor_execute");
  scripts\engine\utility::flag_init("back_bedroom_enemy_dead");
  scripts\engine\utility::flag_init("2nd_floor_clear_nag_started");
  scripts\engine\utility::flag_init("2ndfloor_bathroom_enemy_dead");
  scripts\engine\utility::flag_init("bravo4_2_move_to_stairtrain2");
  scripts\engine\utility::flag_init("hostage_guys_dead_or_longdeath");
  scripts\engine\utility::flag_init("bathroom_guy_engage");
  scripts\engine\utility::flag_init("player_near_stairtrain2");
  scripts\engine\utility::flag_init("stairtrain2_done");
  scripts\engine\utility::flag_init("3rd_floor_clear");
  scripts\engine\utility::flag_init("3rd_floor_enemies_dead");
  scripts\engine\utility::flag_init("3rd_floor_bedroom_enemy_dead");
  scripts\engine\utility::flag_init("player_near_buddy_down");
  scripts\engine\utility::flag_init("buddy_down");
  scripts\engine\utility::flag_init("buddy_downed");
  scripts\engine\utility::flag_init("buddy_down_skip");
  scripts\engine\utility::flag_init("buddy_down_player_engaging_early");
  scripts\engine\utility::flag_init("player_near_stairtrain3");
  scripts\engine\utility::flag_init("stairtrain3_done");
  scripts\engine\utility::flag_init("start_baby_cry");
  scripts\engine\utility::flag_init("baby_mom_go");
  scripts\engine\utility::flag_init("baby_picked_up");
  scripts\engine\utility::flag_init("fourth_floor_bravo4_4_ready");
  scripts\engine\utility::flag_init("4th_floor_clear");
  scripts\engine\utility::flag_init("price_move_attic_stairs");
  scripts\engine\utility::flag_init("attic_door_used");
  scripts\engine\utility::flag_init("end_scene_done");
  scripts\engine\utility::flag_init("player_picked_up_clacker");
  scripts\engine\utility::flag_init("train_passing");
  scripts\engine\utility::flag_init("train_player_nearby");
  scripts\engine\utility::flag_init("lt_wooden_gate");
}

init_auto_crouch() {
  var_0 = getEntArray("player_auto_crouch", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\townhoused\townhoused_code.gsc::trigger_auto_crouch);
}

init_script_brushmodels() {
  var_0 = getEnt("stair_player_pusher", "targetname");
  var_0.og_origin = var_0.origin;
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_0.origin = var_1.origin;
  var_0 = getEnt("2nd_floor_door_playerclip", "targetname");
  var_0 notsolid();
  var_0 = getEnt("3rd_floor_door_playerclip", "targetname");
  var_0 notsolid();
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::delete_onflag("stairtrain1_clip");
}

streets_stealth_settings() {
  var_0 = [];
  var_0["ai_eventDistFootstepSprint"]["hidden"] = 20;
  scripts\stealth\manager::set_custom_distances(var_0);
}

townhouse_stealth_settings() {
  var_0 = [];
  var_0["ai_eventDistFootstepSprint"]["hidden"] = 200;
  scripts\stealth\manager::set_custom_distances(var_0);
}

init_door_state() {
  var_0 = scripts\engine\utility::getStruct("bathroom_door_opener", "targetname");
  level.bathroom_door = scripts\sp\door::get_interactive_door(var_0.target);
  level.bathroom_door.fndamage = scripts\sp\maps\townhoused\townhoused_inner.gsc::bathroom_damage_func;
  level.bathroom_door scripts\sp\utility::do_damage(5, level.bathroom_door.origin);
  var_1 = scripts\sp\door::get_interactive_door("hiding_door");
  var_1.ignore_grenades = 1;
  var_1.lockedforai = 1;
  var_1.og_origin = var_1.origin;
  var_0 = scripts\engine\utility::getStruct("back_bedroom_door_opener", "targetname");
  var_1 = scripts\sp\door::get_interactive_door(var_0.target);
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::force_open_door(var_1, 1);
  var_1 = scripts\sp\door::get_interactive_door("buddydown_door");
  var_1.fndamage = scripts\sp\maps\townhoused\townhoused_inner.gsc::buddy_down_door_damage;
  var_1 = scripts\sp\door::get_interactive_door("kitchen_door");
  var_1.fndamage = scripts\sp\maps\townhoused\townhoused_inner.gsc::dining_room_door_damage;
  var_1 = scripts\sp\door::get_interactive_door("kitchen_girl_door");
  var_1.fndamage = scripts\sp\maps\townhoused\townhoused_inner.gsc::dining_room_door_damage;
}

apc_start() {}

apc_main() {
  streets_stealth_settings();
  scripts\sp\maps\townhoused\townhoused_outer.gsc::init_bravo_gate();
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("streets", 1);
  level.player_rig = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  level.player_rig hide();
  thread apc_intro_sounds_start();
  thread scripts\sp\maps\townhoused\townhoused_outer.gsc::street_jogger();
  thread scripts\sp\maps\townhoused\townhoused_outer.gsc::street_knocknock();
  var_0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var_1 = getEnt("apc", "targetname");
  var_1 scripts\engine\sp\utility::assign_animtree("apc");
  var_2 = getEnt("apc_light", "targetname");
  var_2 linkTo(var_1, "tag_origin", (-10, 0, 100), (90, 0, 0));
  var_3 = getEnt("apc_spot_light", "targetname");
  var_3 setlightintensity(0.1);
  var_3 linkTo(var_2);
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "intro_ride");
  var_1 scripts\common\anim::anim_first_frame_solo(level.player_rig, "apc_ride_loop");
  var_4 = spawn("script_model", var_1.origin);
  var_4 setModel(getweaponviewmodel(level.player_weapons["primary"]));
  var_4 linkTo(level.player_rig, "tag_weapon", (0, 0, 0), (0, 0, 0));
  level.player scripts\common\utility::allow_weapon(0);
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.8, 0.05);
  scripts\engine\sp\utility::array_spawn_noteworthy("price", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("ctbuddy", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo1", 1);
  scripts\engine\sp\utility::array_spawn_targetname("alpha", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("barrier_cops", 1);
  thread spawn_idle_cop(var_0);
  var_5 = scripts\sp\maps\townhoused\townhoused_outer.gsc::get_cop_barriers();
  var_6 = scripts\engine\sp\utility::get_living_ai_array("barrier_cops", "script_noteworthy");
  var_0 thread scripts\common\anim::anim_loop(var_6, "apc_ride_loop", "stop_loop_apc_infil");
  level.groundrefent = scripts\engine\utility::spawn_script_origin();
  level.groundrefent linkTo(level.player_rig, "tag_player", (0, 0, 0), (0, 0, 0));
  var_7 = [level.price, level.ctbuddy, level.bravo1, level.alpha1, level.alpha2];

  foreach(var_9 in var_7) {
    var_9 linkTo(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_1 thread scripts\common\anim::anim_loop_solo(var_9, "apc_ride_loop", "stop_loop_apc_infil");
  }

  level.player_rig linkTo(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 thread scripts\common\anim::anim_loop_solo(level.player_rig, "apc_ride_loop", "stop_loop_apc_infil");
  var_11 = getEnt("whatever", "targetname");
  var_12 = scripts\engine\utility::getStruct("0.5", "targetname");
  var_13 = spawnStruct();
  var_13.origin = (0, 0, 0);
  var_13.origin = (0, 0, 0);
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 0, 0, 0, 0);
  level.player playersetgroundreferenceent(level.groundrefent);
  level.player scripts\engine\utility::delaycall(0.5, ::lerpviewangleclamp, 1, 0, 0, 30, 30, 20, 20);
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "intro_ride");
  apc_intro_vo();
  var_1 notify("stop_loop_apc_infil");
  var_0 notify("stop_loop_apc_infil");
  level.price scripts\engine\utility::delaythread(0.8, scripts\engine\sp\utility::smart_dialogue, "dx_vom_sastl_intro_truck_40");
  thread sfx_barrier_open();
  thread scripts\sp\maps\townhoused\townhoused_outer.gsc::apc_exit_sequence(var_0, var_7, var_1);
  thread scripts\sp\maps\townhoused\townhoused_outer.gsc::apc_exit_cops_sequence(var_0, var_6, var_5);
  scripts\engine\utility::flag_set("start_player_exit_apc");
  level.player_rig unlink();
  var_1 scripts\common\anim::anim_single_solo(level.player_rig, "apc_ride_exit");
  scripts\engine\utility::flag_set("player_exited_apc");
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("alley_gate");
  level thread scripts\sp\maps\townhoused\townhoused_code.gsc::train_go("north");
  level.player playersetgroundreferenceent(undefined);
  level.player unlink();
  level.player_rig hide();
  level.player scripts\common\utility::allow_weapon(1);
  level.groundrefent delete();
}

spawn_idle_cop(var_0) {
  var_1 = getspawner("street_police1", "targetname");
  level.street_police1 = scripts\engine\sp\utility::dronespawn_bodyonly(var_1);
  level.street_police1.animname = "street_police1";
  level.street_police1 scripts\common\ai::gun_remove();
  var_0 scripts\common\anim::anim_loop_solo(level.street_police1, "apc_ride_exit_loop", "stop_street_police_idle");
}

apc_intro_vo() {
  wait 0.2;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_intro_truck_10");
  wait 1;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_intro_truck_20");
  wait 1.5;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_intro_truck_30");
  wait 2;
}

sfx_barrier_open() {
  wait 10.5;
}

apc_intro_sounds_start() {
  level.apc_1_sound_ent = spawn("script_origin", (-3299, -1399, -417));
  wait 3.0;
}

street_start() {
  scripts\engine\sp\utility::array_spawn_noteworthy("price", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("ctbuddy", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo1", 1);
  scripts\engine\sp\utility::array_spawn_targetname("alpha", 1);
  var_0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("streets", 1);
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_street", [level.player]);
  var_0 thread scripts\common\anim::anim_loop_solo(level.bravo1, "gate_approach_pre_idle", "stop_loop_gate_approach_bravo");
  var_0 thread scripts\common\anim::anim_loop([level.price, level.alpha1, level.alpha2, level.ctbuddy], "gate_approach_pre_idle", "stop_loop_gate_approach");
  scripts\engine\utility::flag_set("apc_exited");
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("alley_gate");
}

street_main() {
  scripts\sp\maps\townhoused\townhoused_outer.gsc::spawn_padlock();
  scripts\engine\sp\utility::autosave_by_name("alley_main");
  var_0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  scripts\engine\utility::flag_wait_all("apc_exited", "player_approaching_alley_gate", "street_movement_done");
  var_0 notify("stop_loop_gate_approach");
  var_0 notify("stop_loop_gate_approach_alpha1");
  level.alpha1 scripts\engine\utility::ent_flag_set("goto_alley_gate");
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_sas1_intro_street_530");
  level.alpha1.boltcutters unlink();
  var_1 = [level.price, level.alpha1, level.alpha1.boltcutters];
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop(var_1, "gate_approach", "gate_approach_loop", "stop_loop_guys_cutting_gate");
  var_1 = [level.alpha2, level.ctbuddy];
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop(var_1, "gate_approach", "gate_approach_loop", "stop_loop_guys_move_up_alley");
  thread alley_cutter_at_gate();
  thread alley_price_at_gate();
  scripts\engine\utility::flag_wait("cutter_at_alley_gate");
}

alley_cutter_at_gate() {
  level.alpha1 waittillmatch("single anim", "end");
  level.alpha1 scripts\engine\sp\utility::smart_dialogue("dx_vom_sas2_intro_alley_10");
  scripts\engine\utility::flag_set("cutter_at_alley_gate");
}

alley_price_at_gate() {
  level.price waittillmatch("single anim", "end");
  scripts\engine\utility::flag_set("price_at_alley_gate");
}

alley_start() {
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("streets", 1);
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_alley", [level.player]);
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("ctbuddy", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo", 1);
  scripts\engine\sp\utility::array_spawn_targetname("alpha", 1);
  scripts\engine\utility::flag_set_delayed("price_at_alley_gate", 0.2);
  scripts\sp\maps\townhoused\townhoused_outer.gsc::spawn_padlock();
  var_0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var_1 = getspawner("bravo_driver", "targetname");
  level.bravo_driver = scripts\engine\sp\utility::dronespawn_bodyonly(var_1);
  level.bravo_driver.animname = "bravo_driver";
  var_1 = getspawner("street_police1", "targetname");
  level.street_police1 = scripts\engine\sp\utility::dronespawn_bodyonly(var_1);
  level.street_police1.animname = "street_police1";
  level.street_police1 scripts\common\ai::gun_remove();
  var_0 thread scripts\common\anim::anim_loop([level.bravo_driver, level.street_police1], "apc_ride_exit_loop", "stop_loop_street_police");
  var_2 = [level.bravo2, level.bravo3, level.bravo4, level.bravo5, level.bravo6, level.bravo7];
  var_0 thread scripts\common\anim::anim_loop(var_2, "apc_ride_exit_loop");
  var_0 thread scripts\common\anim::anim_loop([level.price, level.alpha1], "gate_approach_loop", "stop_loop_guys_cutting_gate");
  var_0 thread scripts\common\anim::anim_loop([level.alpha2, level.ctbuddy], "gate_approach_loop", "stop_loop_alpha2_atgate");
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("alley_gate");
}

alley_main() {
  var_0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  thread scripts\sp\maps\townhoused\townhoused_outer.gsc::garage_tires();
  scripts\engine\utility::flag_wait_all("player_approaching_alley_gate", "price_at_alley_gate");
  scripts\engine\sp\utility::trigger_wait_targetname("player_at_alley_gate");
  var_0 notify("stop_loop_guys_cutting_gate");
  level thread scripts\sp\maps\townhoused\townhoused_outer.gsc::alley_gate_open(var_0);
  scripts\engine\utility::flag_wait("player_in_alley");
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("garage_entry");
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 5);
  scripts\engine\utility::flag_wait("player_at_end_of_alley");
  scripts\engine\utility::flag_set("player_can_go_loud");
  thread scripts\sp\maps\townhoused\townhoused_outer.gsc::garage_tv();
  var_0 notify("stop_loop_guys_move_up_alley");
  var_0 notify("stop_loop_alpha2_atgate");
  var_0 notify("stop_loop_alpha1_through_gate");
  level.alpha1 scripts\engine\sp\utility::set_force_color("y");
  level.alpha2 scripts\engine\sp\utility::set_force_color("y");
  var_0 thread scripts\common\anim::anim_single_solo(level.alpha2, "alley_enter");
  level.ctbuddy thread scripts\sp\maps\townhoused\townhoused_outer.gsc::alley_ctbuddy_anim(var_0);
  level thread scripts\sp\maps\townhoused\townhoused_outer.gsc::alley_approach_garage(var_0);
}

garage_entry_start() {
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("ctbuddy", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo", 1);
  scripts\engine\sp\utility::array_spawn_targetname("alpha", 1);
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("streets", 1);
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_garage", [level.player, level.ctbuddy, level.alpha1, level.alpha2]);
  level.alpha1 scripts\engine\sp\utility::set_force_color("y");
  level.alpha2 scripts\engine\sp\utility::set_force_color("y");
  var_0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var_0 thread scripts\common\anim::anim_loop_solo(level.price, "garage_entry_arrive_loop", "stop_loop_price_warehouse");
  scripts\engine\utility::flag_set("price_ready_for_garage_entry");
  var_1 = getspawner("bravo_driver", "targetname");
  level.bravo_driver = scripts\engine\sp\utility::dronespawn_bodyonly(var_1);
  level.bravo_driver.animname = "bravo_driver";
  var_1 = getspawner("street_police1", "targetname");
  level.street_police1 = scripts\engine\sp\utility::dronespawn_bodyonly(var_1);
  level.street_police1.animname = "street_police1";
  level.street_police1 scripts\common\ai::gun_remove();
  var_0 thread scripts\common\anim::anim_loop([level.bravo_driver, level.street_police1], "apc_ride_exit_loop", "stop_loop_street_police");
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("garage_entry");
  scripts\engine\utility::delaythread(0.5, scripts\sp\maps\townhoused\townhoused_outer.gsc::garage_tv);
}

garage_init() {
  scripts\sp\maps\townhoused\townhoused_outer.gsc::garage_explosives_init();
  garage_fire_init();
  scripts\sp\maps\townhoused\townhoused_outer.gsc::garage_tripwire_init();
}

garage_entry_main() {
  garage_init();
  scripts\engine\sp\utility::activate_trigger("garage_entry_colors", "targetname");
  scripts\engine\sp\utility::trigger_wait_targetname("trigger_player_near_garage_entry");
  scripts\engine\utility::flag_set("player_near_garage_entry");
  var_0 = scripts\sp\door::get_interactive_door("warehouse_entrance_door");
  var_0 scripts\sp\door::remove_open_ability();
  var_0.locked = 1;
  scripts\engine\sp\utility::autosave_by_name_silent("garage1");
  level notify("move_bravo_through_gate");
  var_1 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var_1 notify("stop_loop_gate_approach_bravo");
  var_1 notify("stop_loop");
  thread scripts\sp\maps\townhoused\townhoused_outer.gsc::close_alley_gate();
  level thread scripts\sp\maps\townhoused\townhoused_outer.gsc::garage_knock();
  scripts\engine\utility::flag_wait("player_in_garage");
  thread garage2_lights();
  scripts\sp\maps\townhoused\townhoused_code.gsc::clear_objective_icons();
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("secure_garage");
  scripts\engine\utility::flag_wait("price_inside_garage");
}

garage_entry_catchup() {
  thread garage2_lights();
  garage_init();
}

garage_inner_start() {
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("ctbuddy", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha1", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha2", 1);
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("streets", 1);
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_garage2", [level.player, level.ctbuddy, level.price, level.alpha1, level.alpha2]);
  level.price scripts\engine\sp\utility::set_force_color("r");
  level.alpha1 scripts\engine\sp\utility::set_force_color("y");
  level.alpha2 scripts\engine\sp\utility::set_force_color("y");
  scripts\engine\sp\utility::array_spawn_noteworthy("garage2_enemy");
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("secure_garage");
  scripts\sp\maps\townhoused\townhoused_code.gsc::clear_objective_icons();
  scripts\sp\maps\townhoused\townhoused_outer.gsc::garage_tripwire_init();
}

garage_inner_main() {
  scripts\engine\utility::flag_wait("player_near_garage2");
  scripts\engine\sp\utility::autosave_by_name("garage2");
  thread scripts\sp\maps\townhoused\townhoused_outer.gsc::garage2_lifted_taxi();
  thread scripts\sp\maps\townhoused\townhoused_outer.gsc::garage2_train();
  scripts\engine\utility::flag_wait("garage2_dead");
}

garage2_lights() {
  scripts\engine\utility::flag_wait("garage2_light_off");
  thread scripts\engine\utility::add_dialogue_line("Distant Enemy", "Get the lights!");
  wait(randomfloatrange(0.5, 2));
  var_0 = getEntArray("garage2_lights", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2.target, "targetname");
    var_3 setlightintensity(0);
    var_2 setModel(scripts\engine\sp\utility::getmodel("garage_light_off"));
  }
}

garage_fire_init() {
  var_0 = getEntArray("garage_fire", "targetname");
  scripts\engine\utility::array_thread(var_0, ::garage_fire_thread);
}

garage_fire_thread() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_4 == "MOD_EXPLOSIVE") {
      break;
    }
  }

  var_10 = scripts\engine\utility::getStruct(self.target, "targetname");
  playFX(scripts\engine\utility::getfx("garage_fire"), var_10.origin, anglesToForward(var_10.angles));

  if(isDefined(level.garage_fire)) {
    return;
  }
  level.garage_fire = 1;
  var_11 = getEnt("garage_fire_light", "targetname");
  var_11.script_type = "pulse";
  var_11.script_delay_min = 0.2;
  var_11.script_delay_max = 0.5;
  var_11 thread scripts\sp\lights::init_pulse();
}

go_to_backyard_start() {
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha1", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha2", 1);
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("streets");
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_go_to_backyard", [level.player, level.price, level.alpha1, level.alpha2]);
  level.alpha1 scripts\engine\sp\utility::set_force_color("y");
  level.alpha2 scripts\engine\sp\utility::set_force_color("y");
  scripts\engine\utility::flag_set("garage2_dead");
}

go_to_backyard_main() {
  thread scripts\sp\maps\townhoused\townhoused_outer.gsc::garage2_price_exit();
  var_0 = getEntArray("garage_color_triggers", "script_noteworthy");
  scripts\engine\utility::array_delete(var_0);
  scripts\engine\sp\utility::activate_trigger_with_targetname("garage_exit_colors");
  scripts\engine\utility::flag_wait("player_outside_garage2");
  scripts\engine\utility::flag_set("cleanup_garage2");
  thread scripts\sp\analytics::analytics_kleenex_update("garage_done");
  thread guys_exit_garage();
  scripts\sp\maps\townhoused\townhoused_outer.gsc::cam_fly_up();
  level notify("cam_up");
  wait 0.1;
  backyard_setup();
}

guys_exit_garage() {
  var_0 = scripts\engine\utility::getStructArray("garage2_exit", "targetname");
  var_0 = scripts\engine\sp\utility::array_index_by_script_index(var_0);
  var_1 = scripts\engine\sp\utility::spawn_targetname("kyle", 1);
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  waitframe();
  var_2 = [var_1, level.price];
  var_2 = scripts\engine\utility::array_combine(var_2, level.arrays_of_colorforced_ai["allies"]["y"]);

  foreach(var_5, var_4 in var_2) {
    var_4 forceteleport(var_0[var_5].origin, var_0[var_5].angles);
    var_4 thread scripts\sp\spawner::go_to_node(var_0[var_5]);
  }

  level waittill("cam_up");
  var_1 scripts\common\ai::stop_magic_bullet_shield();
  var_1 delete();
}

backyard_intro_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::lt_backyard_intro_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo2", 1);
  var_0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  var_0 = scripts\engine\utility::array_add(var_0, level.player);
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_backyard", var_0);
}

backyard_intro_main() {
  var_0 = scripts\sp\hud_util::get_optional_overlay();
  var_0.alpha = 1;
  thread remove_bg_hud();
  scripts\engine\sp\utility::array_spawn_noteworthy("backyard_alley_extra");
  thread sfx_distant_airplane();
  thread audio_intro_mix_change();
  scripts\sp\maps\townhoused\townhoused_inner.gsc::backyard_intro();
}

remove_bg_hud() {
  wait 0.2;
  var_0 = scripts\sp\hud_util::get_optional_overlay();
  var_0.alpha = 0;
}

audio_intro_mix_change() {
  wait 5.0;
  level.player clearclienttriggeraudiozone(9.0);
}

backyard_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::lt_backyard_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo2", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("backyard_alley_extra");
  var_0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  var_0 = scripts\engine\utility::array_add(var_0, level.player);
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_backyard", var_0);
  level.player scripts\engine\sp\utility::set_player_demeanor("safe");
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::restore_player_demeanor();
  thread sfx_distant_airplane();
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("backyard");
  var_0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\townhoused\townhoused_inner.gsc::backyard_alley_move_solo);
}

backyard_setup() {
  var_0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_backyard", var_0);
}

backyard_main() {
  scripts\engine\utility::flag_set("show_introscreen");
  var_0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);

  foreach(var_2 in var_0)
  var_2 scripts\engine\utility::set_movement_speed(70);

  thread scripts\engine\utility::flag_set_delayed("backyard_alley_extra_move", 2);
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::backyard_fail_thread();
  scripts\sp\maps\townhoused\townhoused_inner.gsc::backyard_door_setup();
  scripts\engine\utility::flag_wait("backyard_alley_ready");
  var_4 = ["dx_vom_pri_backyard_alleyway_12", "dx_vom_pri_backyard_alleyway_13"];
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::nag(var_4, "near_backyard_door", 12, 15);
  scripts\engine\utility::delaythread(3, ::set_backyard_objective);
  scripts\engine\utility::flag_wait("near_backyard_door");
  scripts\engine\utility::delaythread(1, scripts\engine\sp\utility::smart_radio_dialogue, "dx_vom_pri_backyard_alleyway_20");
  scripts\engine\utility::delaythread(1, scripts\common\anim::anim_single_solo, level.price, "dx_vom_pri_backyard_alleyway_20");
  scripts\sp\maps\townhoused\townhoused_inner.gsc::backyard_door_open();
  scripts\engine\utility::delaythread(3, scripts\sp\maps\townhoused\townhoused_code.gsc::train_go, "north", 50);
  var_4 = ["dx_vom_pri_backyard_nag_10", "dx_vom_pri_backyard_nag_20", "dx_vom_pri_backyard_nag_30"];
  level.price thread scripts\engine\utility::delaythread(12, scripts\sp\maps\townhoused\townhoused_code.gsc::nag, var_4, "player_in_backyard", 12, 15);
  scripts\sp\maps\townhoused\townhoused_inner.gsc::backyard_move();
}

test_prints() {}

set_backyard_objective() {
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("townhouse_entry");
  scripts\sp\maps\townhoused\townhoused_code.gsc::objective_add_structpos("obj_townhouse_entry");
}

clear_backyard_objective() {
  var_0 = scripts\engine\utility::getStruct("obj_townhouse_entry", "targetname");
  scripts\sp\maps\townhoused\townhoused_code.gsc::objective_clear_structpos(var_0);
}

backyard_catchup() {
  set_backyard_objective();
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::backyard_fail_thread();
}

kitchen_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::lt_kitchen_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo2", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo3", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("backyard_alley_extra", 1);
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("backyard");
  var_0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  var_0 = scripts\engine\utility::array_add(var_0, level.player);
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_kitchen", var_0);
  scripts\engine\utility::flag_set("player_in_backyard");
  var_1 = scripts\engine\sp\utility::get_living_ai("bravo2_4", "animname");
  var_2 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  var_2 thread scripts\common\anim::anim_loop_solo(var_1, "backyard_move_idle", "stop_backyard_move_loop");
  scripts\sp\maps\townhoused\townhoused_inner.gsc::backdoor_freeze();
}

kitchen_main() {
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::dining_light_death();
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::kitchen_player_clip();
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::kitchen_sequence();
  scripts\engine\utility::flag_wait("player_in_kitchen");
  clear_backyard_objective();
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("townhouse_1st_floor");
  thread audio_toggle_door_propagation();
  setglobalsoundcontext("trainby", "int", 2.0);
}

kitchen_catchup() {
  setglobalsoundcontext("trainby", "int", 2.0);
  clear_backyard_objective();
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("townhouse_1st_floor");
  scripts\engine\utility::flag_set("backdoor_enter_done");
  scripts\engine\utility::flag_set("kitchen_takedown_fastforward");
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::kitchen_player_clip();
}

audio_toggle_door_propagation() {
  var_0 = getEnt("PropPortal", "targetname");
  var_1 = getEnt("PropPortalTrigger", "targetname");
  var_1 waittill("trigger");
  var_0 enableaudioportal(0);
  var_1 delete();
}

audio_door_sound_clip_init() {
  scripts\engine\utility::flag_wait("interactive_doors_ready");
  var_0 = [];
  var_0[0] = "kitchen_door";
  var_0[1] = "secondfloor_door_one";
  var_0[2] = "secondfloor_door_two";
  var_0[3] = "baby_room_door";
  var_0[4] = "baby_room_exit";
  var_0[5] = "4thfloor_bedroom_exit";

  foreach(var_2 in var_0)
  thread audio_door_clip_thread(var_2);
}

audio_door_clip_thread(var_0) {
  var_1 = scripts\sp\door::get_interactive_door(var_0);
  var_2 = getEnt(var_0 + "_soundclip", "targetname");
  var_1 thread audio_door_damage_thread(var_2);
  var_1 audio_door_interaction_wait();
  var_2 delete();
}

audio_door_interaction_wait() {
  self endon("open_completely");
  self endon("ajar");
  self endon("bashed");
  self waittill("door_damaged_enough");
}

audio_door_damage_thread(var_0) {
  self endon("death");
  var_0 setCanDamage(1);

  for(var_1 = 0; var_1 < 300; var_1 = var_1 + var_2)
    self waittill("damage", var_2);

  self notify("door_damaged_enough");
}

dining_room_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::lt_dining_room_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo2", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo3", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("dining_enemies", 1);
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("townhouse");
  var_0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  var_0 = scripts\engine\utility::array_add(var_0, level.player);
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_dining_room", var_0);
  var_1 = scripts\engine\utility::getStruct("dining_room_price", "script_noteworthy");
  scripts\engine\utility::flag_set("player_in_kitchen");
  scripts\engine\utility::flag_set("kitchen_intro_vo_done");
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg("on");
  scripts\sp\maps\townhoused\townhoused_inner.gsc::interior_price_settings();
  level.price scripts\sp\maps\townhoused\townhoused_code.gsc::scripted_movement(var_1);
  level.price thread scripts\sp\maps\townhoused\townhoused_inner.gsc::stairtrain1_setup();
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::dining_light_death();
}

dining_room_main() {
  scripts\engine\utility::flag_wait("dining_room_dead");
  thread dining_room_clear();
  wait 3;
  scripts\engine\utility::flag_wait_or_timeout("player_near_stairtrain1", 2);
  scripts\engine\sp\utility::autosave_by_name("1st_floor_done");
}

dining_room_catchup() {
  scripts\sp\maps\townhoused\townhoused_inner.gsc::disable_player_sealth();
  scripts\engine\utility::flag_set("player_in_kitchen");
}

dining_room_clear() {
  level.player endon("death");
  var_0 = scripts\engine\utility::getStruct("dining_room_lookat_pos", "targetname");

  while(!level.player scripts\engine\trace::can_see_origin(var_0.origin, 0))
    waitframe();

  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code.gsc::wait_weapon_fire_cooldown(1, 4);
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_dining_room_frontroom_310");
  scripts\engine\utility::flag_set("player_said_dining_clear");
  level.player setsoundsubmix("sp_th_baby_cry");
}

dining_room_ceiling_dialogue() {
  var_0 = scripts\engine\utility::getStruct("2ndfloor_footsteps_bedroom", "targetname");
  var_1 = scripts\engine\utility::getStruct("2ndfloor_footsteps_backbedroom", "targetname");
  var_2 = scripts\engine\utility::spawn_script_origin(var_0.origin);
  var_2.animname = "temp1";
  var_3 = scripts\engine\utility::spawn_script_origin(var_1.origin);
  var_3.animname = "temp2";
  var_4 = scripts\engine\utility::spawn_script_origin(var_0.origin);
  var_4.animname = "temp3";
  var_5 = scripts\engine\utility::spawn_script_origin(var_1.origin);
  var_5.animname = "temp4";
  dining_room_ceiling_dialogue_internal(var_2, var_3, var_4, var_5);

  while(var_2 iswaitingonsound())
    waitframe();

  wait 3;
  var_2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_dining_room_aq_convo3_130");
  wait 0.3;
  var_5 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_dining_room_aq_convo3_120");
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
}

dining_room_ceiling_dialogue_internal(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::flag("stairtrain1_done")) {
    return;
  }
  level endon("stairtrain1_done");
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::stairtrain1_ready_thread();
  wait 3.5;
  var_2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_dining_room_aq_convo3_10");
  wait 0.4;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_dining_room_aq_convo3_20");
  wait 0.6;
  var_3 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_dining_room_aq_convo3_30");
  wait 0.3;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_dining_room_aq_convo3_50");
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::sound_mover("2ndfloor_footsteps_backbedroom");
  var_4 = [];
  var_4[var_4.size] = "dx_vom_pri_stairtrain1_rally_40";
  var_4[var_4.size] = "dx_vom_pri_stairtrain1_rally_50";
  var_4[var_4.size] = "dx_vom_pri_stairtrain1_rally_60";
  var_4[var_4.size] = "dx_vom_pri_stairtrain1_rally_70";
  var_4[var_4.size] = "dx_vom_pri_stairtrain1_rally_80";
  var_4[var_4.size] = "dx_vom_pri_stairtrain1_rally_90";
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::nag(var_4, "stairtrain1_started", 12, 15);
  scripts\engine\utility::flag_wait("stairtrain1_started");
  wait 0.9;
  level thread scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_stairtrain1_rally_100");
  wait 2.6;
  var_3 thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_dining_room_aq_convo3_60");
  wait 1.2;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_dining_room_aq_convo3_70");
  wait 0.4;
  var_1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_dining_room_aq_convo3_80");
  wait 0.4;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_dining_room_aq_convo3_90");
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::sound_mover("2ndfloor_footsteps_bedroom");
  scripts\engine\utility::flag_wait("half_up_1f_stairs");
  var_3 thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_dining_room_aq_convo3_100");
  wait 2;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_dining_room_aq_convo3_110");
  var_3 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_dining_room_aq_convo3_140");
  wait 8;
  var_2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_2nd_floor_landing_10");
  wait 1.3;
  var_2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_2nd_floor_landing_20");
  wait 0.4;
  var_2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_2nd_floor_landing_30");
  wait 0.2;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_landing_40");
}

stairtrain1_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::lt_stairtrain1_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4", 1);
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("townhouse");
  var_0 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
  var_1 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
  var_2 = [level.price, var_0, var_1, level.player];
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_stairtrain1", var_2);
  scripts\engine\utility::flag_set("stairtrain1_go");
  scripts\engine\utility::flag_set("dining_room_dead");
  scripts\engine\utility::flag_set("player_said_dining_clear");
  level.price thread scripts\sp\maps\townhoused\townhoused_inner.gsc::stairtrain1_setup();
  level.player setsoundsubmix("sp_th_baby_cry");
}

stairtrain1_main() {
  thread dining_room_ceiling_dialogue();
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("townhouse_2nd_floor");
  level waittill("stairtrain_reached_end");
  scripts\engine\utility::flag_set("stairtrain1_done");
}

stairtrain1_catchup() {
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("townhouse_2nd_floor");
  scripts\engine\utility::flag_set("stairtrain1_remove_clip");
}

second_floor_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::lt_second_floor_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg("on");
  scripts\engine\utility::array_thread(level.squads["bravo4"], scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg, "on");
  scripts\engine\sp\utility::array_spawn_noteworthy("2nd_floor_enemies", 1);
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("townhouse");
  var_0 = scripts\engine\utility::array_add(level.squads["bravo4"], level.price);
  var_0 = scripts\engine\utility::array_add(var_0, level.player);
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_2nd_floor", var_0);
  level.player setsoundsubmix("sp_th_baby_cry");
}

second_floor_main() {
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::second_floor_movement();
  thread second_floor_enemies_dead_dialogue();
  scripts\engine\utility::flag_wait("2ndfloor_bathroom_enemy_dead");
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::clear_floor("2nd_floor_clear", "2nd_floor_clear");
  scripts\engine\utility::flag_wait("2nd_floor_clear");
  thread second_floor_clear();
  wait 0.4;
  scripts\engine\sp\utility::autosave_by_name("2nd_floor_done");
}

second_floor_clear() {
  level.player endon("death");
  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code.gsc::wait_last_nag_finished();
  scripts\sp\maps\townhoused\townhoused_code.gsc::wait_weapon_fire_cooldown(1.5, 5);
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_2nd_floor_bedroom2_170");
  wait 0.2;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_stairtrain2_rally_40");
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("townhouse_3rd_floor");
  thread stairtrain2_nags();
}

second_floor_enemies_dead_dialogue() {
  level.player endon("death");
  level endon("2nd_floor_clear");
  scripts\engine\utility::flag_wait("hostage_guys_dead_or_longdeath");

  while(!level.player scripts\engine\trace::can_see_origin(level.last_hostage_death_position, 0))
    waitframe();

  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code.gsc::wait_weapon_fire_cooldown(1, 3);
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_2nd_floor_bedroom2_100");
  wait 0.2;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a12_2nd_floor_bedroom2_110");
  wait 0.5;

  if(!scripts\engine\utility::flag("2nd_floor_clear"))
    scripts\sp\maps\townhoused\townhoused_code.gsc::objective_add_structpos("obj_townhouse_1st_floor");

  thread second_floor_clear_nag();
}

second_floor_catchup() {
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("townhouse_3rd_floor");
  scripts\sp\maps\townhoused\townhoused_inner.gsc::interior_price_settings();
}

second_floor_clear_nag() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_pri_2nd_floor_bedroom2_120";
  var_0[var_0.size] = "dx_vom_pri_2nd_floor_bedroom2_130";
  var_0[var_0.size] = "dx_vom_pri_2nd_floor_bedroom2_140";
  var_0 = scripts\engine\sp\utility::create_deck(var_0);

  if(!scripts\engine\utility::flag("2nd_floor_clear")) {
    level.last_nag_time = gettime();
    level.last_nag_alias = "dx_vom_pri_2nd_floor_bedroom2_120";
    scripts\engine\sp\utility::smart_radio_dialogue(var_0 scripts\engine\sp\utility::deck_draw_specific("dx_vom_pri_2nd_floor_bedroom2_120"));
  }

  wait 2;
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::nag(var_0, "2nd_floor_clear", 8, 12);
}

stairtrain2_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::lt_stairtrain2_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg("on");
  scripts\engine\utility::array_thread(level.squads["bravo4"], scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg, "on");
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("townhouse");
  scripts\engine\utility::flag_set("player_near_stairtrain2");
  var_0 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
  var_1 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
  var_2 = [level.price, var_0, var_1, level.player];
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_stairtrain2", var_2);
  var_2 = scripts\engine\utility::array_remove(var_2, level.player);

  foreach(var_4 in var_2)
  var_4 thread scripts\sp\maps\townhoused\townhoused_inner.gsc::stairtrain2_setup();
}

stairtrain2_main() {
  scripts\engine\utility::delaythread(2, scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective, "townhouse_3rd_floor");
  level waittill("stairtrain_reached_end");
  scripts\engine\utility::flag_set("stairtrain2_done");
}

stairtrain2_nags() {
  level endon("player_near_stairtrain2");
  wait 5;
  var_0 = [];
  var_0[var_0.size] = "dx_vom_pri_stairtrain2_rally_10";
  var_0[var_0.size] = "dx_vom_pri_stairtrain2_rally_20";
  var_0[var_0.size] = "dx_vom_pri_stairtrain2_rally_30";
  scripts\sp\maps\townhoused\townhoused_code.gsc::radio_nag(var_0, "player_near_stairtrain2", 8, 12);
}

third_floor_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::lt_third_floor_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg("on");
  scripts\engine\utility::array_thread(level.squads["bravo4"], scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg, "on");
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("townhouse");
  var_0 = scripts\engine\utility::array_add(level.squads["bravo4"], level.price);
  var_0 = scripts\engine\utility::array_add(var_0, level.player);
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_3rd_floor", var_0);
  level.player setsoundsubmix("sp_th_baby_cry");
}

third_floor_main() {
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::third_floor_movement();
  thread third_floor_clear_nag();
  thread scripts\sp\maps\townhoused\townhoused_code.gsc::clear_floor("3rd_floor_clear", "3rd_floor_clear", ::on_see_3f_struct);
  scripts\engine\utility::flag_wait("3rd_floor_enemies_dead");
  setmusicstate("mx_townhouse_area1secure_lp");
  thread scripts\engine\utility::flag_set_delayed("start_baby_cry", 3);
  scripts\engine\utility::flag_wait("3rd_floor_clear");
  thread third_floor_clear();
  scripts\engine\sp\utility::autosave_by_name("3rd_floor_done");
}

third_floor_catchup() {
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("townhouse_4th_floor");
}

on_see_3f_struct(var_0) {
  level.player endon("death");

  if(var_0 != scripts\engine\utility::getStructArray("3rd_floor_clear", "targetname")[1]) {
    return;
  }
  wait(randomfloatrange(0.4, 1));

  if(scripts\engine\utility::flag("3rd_floor_clear") && scripts\engine\utility::flag("3rd_floor_enemies_dead")) {
    return;
  }
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_3rd_floor_bedroom_140");
}

third_floor_clear() {
  level.player endon("death");
  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code.gsc::wait_weapon_fire_cooldown(0.6, 3);
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_3rd_floor_bedroom_150");
  thread third_floor_clear_extra();
  thread stairtrain3_player_near();
}

third_floor_clear_extra() {
  if(scripts\engine\utility::flag("buddy_down_skip")) {
    wait 2;
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_stairtrain3_rally_43");
    scripts\sp\utility::giveachievement_wrapper("wallhax");
  }

  wait 0.65;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_stairtrain3_rally_10");
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("townhouse_4th_floor");
  thread stairtrain3_nag();
}

stairtrain3_nag() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_pri_stairtrain3_rally_20";
  var_0[var_0.size] = "dx_vom_pri_stairtrain3_rally_30";
  var_0[var_0.size] = "dx_vom_pri_stairtrain3_rally_40";
  var_0[var_0.size] = "dx_vom_pri_stairtrain3_rally_60";
  var_0[var_0.size] = "dx_vom_pri_stairtrain3_rally_70";
  var_0[var_0.size] = "dx_vom_pri_stairtrain3_rally_80";
  level.price scripts\sp\maps\townhoused\townhoused_code.gsc::radio_nag(var_0, "player_near_stairtrain3", 8, 12);
}

third_floor_clear_nag() {
  scripts\engine\utility::flag_wait("3rd_floor_bedroom_enemy_dead");

  if(!scripts\engine\utility::flag("3rd_floor_clear"))
    scripts\sp\maps\townhoused\townhoused_code.gsc::objective_add_structpos("obj_townhouse_2nd_floor");

  var_0 = [];
  var_0[var_0.size] = "dx_vom_pri_3rd_floor_bedroom_110";
  var_0[var_0.size] = "dx_vom_pri_3rd_floor_bedroom_120";
  var_0[var_0.size] = "dx_vom_pri_3rd_floor_bedroom_130";
  scripts\sp\maps\townhoused\townhoused_code.gsc::radio_nag(var_0, "3rd_floor_clear", 8, 12);
}

stairtrain3_player_near() {
  var_0 = getEnt("player_near_stairtrain3", "targetname");
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("player_near_stairtrain3");
}

stairtrain3_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::lt_stairtrain3_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4_reinforcements", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg("on");
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("townhouse");
  var_0 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
  var_1 = [var_0, level.price, level.player];
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_stairtrain3", var_1);
  level.price thread scripts\sp\maps\townhoused\townhoused_inner.gsc::stairtrain3_setup();
  level.player setsoundsubmix("sp_th_baby_cry");
}

stairtrain3_main() {
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("attic");
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::baby_mom_prior_dialog();
  level waittill("stairtrain_reached_end");
  scripts\engine\utility::flag_set("stairtrain3_done");
}

fourth_floor_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::lt_fourth_floor_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4_reinforcements", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg("on");
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("townhouse");
  var_0 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
  var_1 = [var_0, level.price, level.player];
  var_0 scripts\engine\utility::ent_flag_init("stairtrain_on");
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_4th_floor", var_1);
  scripts\engine\sp\utility::activate_trigger("4th_floor_spawn", "targetname");
  scripts\engine\utility::flag_set("start_baby_cry");
}

fourth_floor_main() {
  level.player endon("death");
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::fourth_floor_door();
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::fourth_floor_movement();
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::fourth_floor_clear_nag();
  scripts\engine\utility::flag_wait("4th_floor_enemies_dead");
  wait 1;
  thread music_clear_4th_floor();
  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code.gsc::wait_weapon_fire_cooldown(1, 4);
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_4th_floor_bedroom_100");
  scripts\engine\sp\utility::autosave_by_name("4th_floor_done");
  wait 1;
  thread scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_4th_floor_bedroom_110");
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("townhouse_attic");
  var_0 = [];
  var_0[var_0.size] = "dx_vom_pri_4th_floor_bedroom_120";
  var_0[var_0.size] = "dx_vom_pri_4th_floor_bedroom_130";
  var_0[var_0.size] = "dx_vom_pri_4th_floor_bedroom_140";
  scripts\engine\utility::delaythread(5, scripts\sp\maps\townhoused\townhoused_code.gsc::radio_nag, var_0, "player_at_attic_stairs");
  scripts\engine\utility::flag_wait("player_at_attic_stairs");
  scripts\engine\utility::flag_set("price_move_attic_stairs");
  scripts\engine\utility::flag_set("fourth_floor_bravo4_4_ready");
}

music_clear_4th_floor() {
  wait 2.0;
  setmusicstate("mx_townhouse_area2secure_lp");
}

fourth_floor_catchup() {
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_objective("thownhouse_attic");
}

attic_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting.gsc::lt_attic_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code.gsc::force_nvg("on");
  scripts\sp\maps\townhoused\townhoused_code.gsc::setup_player("townhouse");
  var_0 = [level.price, level.player];
  scripts\sp\maps\townhoused\townhoused_code.gsc::set_start_location_by_animname("start_attic", var_0);
}

attic_main() {
  if(level.start_point == "attic")
    scripts\engine\utility::flag_wait("player_at_attic_stairs");

  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::attic_room();
  scripts\engine\utility::flag_wait("end_scene_done");
  scripts\engine\sp\utility::nextmission();
}

sfx_distant_airplane() {
  var_0 = spawn("script_origin", (-1036, -165, 979));
  var_0 playSound("emt_amb_jet_distant_lp", "sound_done");
  wait 7;
  var_0 moveTo((-979, 2604, 432), 30.0);
  var_0 waittill("sound_done");
  var_0 delete();
}

audio_front_door_dog_sfx() {
  level.frontdoordog = spawn("script_origin", (60, 1263, -335));
  level.frontdoordog scripts\engine\sp\utility::sound_fade_in("emt_dog_barking_dist_03", 1.0, 0.8, 1);
  level waittill("stop_dog_sounds_front_door");
  level.frontdoordog scripts\engine\sp\utility::sound_fade_and_delete(8.0, 1);
}