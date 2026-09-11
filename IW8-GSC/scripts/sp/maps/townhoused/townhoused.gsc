/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\townhoused\townhoused.gsc
*****************************************************/

function main() {
  level.demo = scripts\sp\utility::is_demo();
  scripts\sp\maps\townhoused\gen\townhoused_art::main();
  scripts\sp\maps\townhoused\townhoused_fx::main();
  scripts\sp\maps\townhoused\townhoused_precache::main();
  scripts\sp\maps\townhoused\townhoused_lighting::main();
  scripts\sp\maps\townhoused\townhoused_anim::main();
  precache();
  init_strings();
  init_squads();
  scripts\sp\maps\townhoused\townhoused_code::init_footsteps();
  level.default_goalheight = 80;
  var0 = scripts\sp\player_rig::get_player_rig();
  var0 hide();
  scripts\engine\sp\utility::set_default_start("backyard_intro");
  var1 = undefined;
  scripts\engine\sp\utility::add_start("backyard_intro", &backyard_intro_start, var1, &backyard_intro_main, var1);
  scripts\engine\sp\utility::add_start("backyard", &backyard_start, var1, &backyard_main, var1, &backyard_catchup);
  scripts\engine\sp\utility::add_start("kitchen", &kitchen_start, var1, &kitchen_main, var1, &kitchen_catchup);
  scripts\engine\sp\utility::add_start("dining_room", &dining_room_start, var1, &dining_room_main, var1, &dining_room_catchup);
  scripts\engine\sp\utility::add_start("stairtrain1", &stairtrain1_start, var1, &stairtrain1_main, var1, &stairtrain1_catchup);
  scripts\engine\sp\utility::add_start("2nd_floor", &second_floor_start, var1, &second_floor_main, var1, &second_floor_catchup);
  scripts\engine\sp\utility::add_start("stairtrain2", &stairtrain2_start, var1, &stairtrain2_main, var1);
  scripts\engine\sp\utility::add_start("3rd_floor", &third_floor_start, var1, &third_floor_main, var1, &third_floor_catchup);
  scripts\engine\sp\utility::add_start("stairtrain3", &stairtrain3_start, var1, &stairtrain3_main, var1);
  scripts\engine\sp\utility::add_start("4th_floor", &fourth_floor_start, var1, &fourth_floor_main, var1, &fourth_floor_catchup);
  scripts\engine\sp\utility::add_start("attic", &attic_start, var1, &attic_main, var1);
  level.door_hint_dist_scale = 0.8;
  init_introscreen();
  scripts\engine\utility::delaythread(0.2, &scripts\sp\player\context_melee::disable_dynamic_takedowns);
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  scripts\sp\stealth\manager::main();
  level.player thread scripts\stealth\player::main();
  init_spawnfunctions();
  scripts\sp\nvg\nvg_player::main("nvg_townhoused");
  init_dvars();
  init_flags();
  scripts\sp\maps\townhoused\townhoused_code::deployable_ladder_init();
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
  scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::battlechatter_off);
  thread init_demo();
  init_hints();
  scripts\sp\maps\townhoused\townhoused_code::init_train();
  init_script_brushmodels();
  init_auto_crouch();
  thread patch_ent_fixes();
  thread init_door_state();
  thread scripts\sp\maps\townhoused\townhoused_inner::baby_cry();
  thread scripts\sp\maps\townhoused\townhoused_inner::kitchen_player_deployed_ladder();
  level thread scripts\sp\maps\townhoused\townhoused_code::player_going_loud();
  scripts\sp\maps\townhoused\townhoused_code::ai_stance_init();
  thread scripts\sp\maps\townhoused\townhoused_inner::ambient_garage_welding();
  thread scripts\sp\maps\townhoused\townhoused_code::track_player_weapon_fire_time();
  thread scripts\sp\maps\townhoused\townhoused_code::bump_weapon_onpickup();
  thread scripts\sp\maps\townhoused\townhoused_inner::nvg_death_hint();
  level thread scripts\sp\maps\townhoused\townhoused_code::planes();
  scripts\sp\maps\townhoused\townhoused_code::init_player_clips();
  level.player.lastprojectiledamagetime["flash"] = 0;
  level.player.lastprojectiledamagetime["frag"] = 0;
  thread scripts\sp\maps\townhoused\townhoused_code::player_grenade_fire_thread();

  if(scripts\sp\starts::is_after_start("overwatch")) {
    townhouse_stealth_settings();
  } else {
    streets_stealth_settings();
  }

  level.dialoguelinescale = 1.25;
  GscBinSkip1(0x45, "price_at_dining_room", &scripts\sp\maps\townhoused\townhoused_inner::price_dining_room);
}

function patch_ent_fixes() {
  var0 = getEntArray("trigger_multiple_flag_set", "classname");

  foreach(var2 in var0) {
    if(scripts\engine\utility::is_equal(var2.script_flag, "player_at_attic_stairs")) {
      var2.origin += (0, 0, 11);
    }
  }
}

function recently_loaded_thread() {
  for(;;) {
    if(issaverecentlyloaded()) {
      iprintlnbold("---- RECENTLY LOADED ----");
    }

    waitframe();
  }
}

function init_demo() {
  if(!istrue(level.demo)) {
    return;
  }

  setsaveddvar("LKQLKNRLQ", 0);
  var0 = getspawner("buddy_down_enemy", "script_noteworthy");
  var0.script_moveoverride = 1;
  var1 = getnode(var0.target, "targetname");
  var2 = getnodearray(var1.target, "targetname");

  foreach(var1 in var2) {
    if(var1.type == "Cover Right") {
      var0.go_to_node = var1;
    }
  }

  var5 = scripts\engine\sp\utility::get_spawner_array("dining_enemies", "script_noteworthy");

  foreach(var0 in var5) {
    if(var0.script_animname == "dining_enemy1") {
      var0.script_char_index = 1;
      continue;
    }

    if(var0.script_animname == "dining_enemy2") {
      var0.script_char_index = 3;
    }
  }

  var0 = getspawner("bed_guy", "script_noteworthy");
  var0.script_char_index = 7;
}

function init_introscreen() {
  scripts\engine\sp\utility::intro_screen_custom_func(&introscreen_delayed);
}

function init_spawnfunctions() {
  scripts\engine\sp\utility::add_global_spawn_function("allies", &scripts\sp\maps\townhoused\townhoused_code::postspawn_allies);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &scripts\sp\maps\townhoused\townhoused_code::postspawn_axis);
  scripts\engine\sp\utility::array_spawn_function_targetname("bravo2", &scripts\sp\maps\townhoused\townhoused_code::postspawn_bravo2);
  scripts\engine\sp\utility::array_spawn_function_targetname("bravo3", &scripts\sp\maps\townhoused\townhoused_code::postspawn_bravo3);
  scripts\engine\sp\utility::array_spawn_function_targetname("bravo4", &scripts\sp\maps\townhoused\townhoused_inner::postspawn_bravo4);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("price", &scripts\sp\maps\townhoused\townhoused_code::postspawn_friendlies);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("backyard_alley_extra", &scripts\sp\maps\townhoused\townhoused_inner::postspawn_backyard_alley_extra);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("dining_enemies", &scripts\sp\maps\townhoused\townhoused_inner::postspawn_dining_enemy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("2nd_floor_enemies", &scripts\sp\maps\townhoused\townhoused_inner::postspawn_second_floor_enemy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("buddy_down_enemy", &scripts\sp\maps\townhoused\townhoused_inner::postspawn_buddy_down_enemy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("buddy_down_gunner", &scripts\sp\maps\townhoused\townhoused_inner::postspawn_buddy_down_gunner);
  scripts\engine\sp\utility::array_spawn_function_targetname("hiding_door_enemy", &scripts\sp\maps\townhoused\townhoused_inner::postspawn_hiding_door_enemy);
  scripts\engine\sp\utility::array_spawn_function_targetname("bravo4_reinforcements", &scripts\sp\maps\townhoused\townhoused_inner::postspawn_bravo4_reinforcement);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("baby_mom", &scripts\sp\maps\townhoused\townhoused_inner::postspawn_baby_mom);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("bed_guy", &scripts\sp\maps\townhoused\townhoused_inner::postspawn_bed_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("attic_enemy", &scripts\sp\maps\townhoused\townhoused_inner::postspawn_attic_enemy);
}

function precache() {
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

  var0 = scripts\sp\maps\townhoused\townhoused_code::get_player_weapons();

  foreach(var2 in var0) {
    var3 = getweaponviewmodel(var2);
    precachemodel(var3);
  }

  level.sniper_rifle = spawnStruct();
  level.sniper_rifle.name = "iw8_ar_mcharlie";
  level.sniper_rifle.attachments = ["lasermic_townhouse", "silencer_west01_townhouse", "bipod", "snprscope_alpha50_townhouse"];
  level.sniper_rifle.stowed_weapon = scripts\sp\utility::make_weapon(level.sniper_rifle.name, level.sniper_rifle.attachments);
}

function introscreen_delayed() {
  scripts\engine\utility::flag_wait("show_introscreen");
  scripts\sp\introscreen::introscreen(1);
}

function init_hints() {}

function init_squads() {
  level.squads = [];
  level.squads["alpha"] = [];
  level.squads["bravo"] = [];
  level.squads["bravo2"] = [];
  level.squads["bravo3"] = [];
  level.squads["bravo4"] = [];
  level.squads["charlie"] = [];
}

function init_strings() {}

function init_dvars() {
  setDvar("scr_disable_civ_kills", 1);
  setdvarifuninitialized("scr_attic_switch", 0);
  setdvarifuninitialized("scr_debug_going_hot", 0);
}

function init_dynolights_state() {
  scripts\engine\utility::flag_wait("scriptables_ready");

  foreach(var1 in level.dynolights) {
    if(issubstr(var1.script_noteworthy, "_off_")) {
      var1 setscriptablepartstate("onoff", "off");
    }

    var1.nextflickertime = 0;

    if(var1 scripts\sp\maps\townhoused\townhoused_code::has_multiple_lights()) {
      var1 thread scripts\sp\maps\townhoused\townhoused_code::lights_off_thread();
    }
  }
}

function init_flags() {
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

function init_auto_crouch() {
  var0 = getEntArray("player_auto_crouch", "targetname");
  scripts\engine\utility::array_thread(var0, &scripts\sp\maps\townhoused\townhoused_code::trigger_auto_crouch);
}

function init_script_brushmodels() {
  var0 = getEnt("stair_player_pusher", "targetname");
  var0.og_origin = var0.origin;
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var0.origin = var1.origin;
  var0 = getEnt("2nd_floor_door_playerclip", "targetname");
  var0 notsolid();
  var0 = getEnt("3rd_floor_door_playerclip", "targetname");
  var0 notsolid();
  thread scripts\sp\maps\townhoused\townhoused_code::delete_onflag("stairtrain1_clip");
}

function streets_stealth_settings() {
  var0 = [];
  GscBinSkip0(0x2e, "ai_eventDistFootstepSprint", "hidden", 20);
}

function townhouse_stealth_settings() {
  var0 = [];
  GscBinSkip0(0x2e, "ai_eventDistFootstepSprint", "hidden", 200);
}

function init_door_state() {
  var0 = scripts\engine\utility::getStruct("bathroom_door_opener", "targetname");
  level.bathroom_door = scripts\sp\door::get_interactive_door(var0.target);
  level.bathroom_door.fndamage = &scripts\sp\maps\townhoused\townhoused_inner::bathroom_damage_func;
  level.bathroom_door scripts\sp\utility::do_damage(5, level.bathroom_door.origin);
  var1 = scripts\sp\door::get_interactive_door("hiding_door");
  var1.ignore_grenades = 1;
  var1.lockedforai = 1;
  var1.og_origin = var1.origin;
  var0 = scripts\engine\utility::getStruct("back_bedroom_door_opener", "targetname");
  var1 = scripts\sp\door::get_interactive_door(var0.target);
  var0 scripts\sp\maps\townhoused\townhoused_code::force_open_door(var1, 1);
  var1 = scripts\sp\door::get_interactive_door("buddydown_door");
  var1.fndamage = &scripts\sp\maps\townhoused\townhoused_inner::buddy_down_door_damage;
  var1 = scripts\sp\door::get_interactive_door("kitchen_door");
  var1.fndamage = &scripts\sp\maps\townhoused\townhoused_inner::dining_room_door_damage;
  var1 = scripts\sp\door::get_interactive_door("kitchen_girl_door");
  var1.fndamage = &scripts\sp\maps\townhoused\townhoused_inner::dining_room_door_damage;
}

function apc_start() {}

function apc_main() {
  streets_stealth_settings();
  scripts\sp\maps\townhoused\townhoused_outer::init_bravo_gate();
  scripts\sp\maps\townhoused\townhoused_code::setup_player("streets", 1);
  level.player_rig = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  level.player_rig hide();
  thread apc_intro_sounds_start();
  thread scripts\sp\maps\townhoused\townhoused_outer::street_jogger();
  thread scripts\sp\maps\townhoused\townhoused_outer::street_knocknock();
  var0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var1 = getEnt("apc", "targetname");
  var1 scripts\engine\sp\utility::assign_animtree("apc");
  var2 = getEnt("apc_light", "targetname");
  var2 linkTo(var1, "tag_origin", (-10, 0, 100), (90, 0, 0));
  var3 = getEnt("apc_spot_light", "targetname");
  var3 setlightintensity(0.1);
  var3 linkTo(var2);
  var0 scripts\common\anim::anim_first_frame_solo(var1, "intro_ride");
  var1 scripts\common\anim::anim_first_frame_solo(level.player_rig, "apc_ride_loop");
  var4 = spawn("script_model", var1.origin);
  var4 setModel(getweaponviewmodel(level.player_weapons["primary"]));
  var4 linkTo(level.player_rig, "tag_weapon", (0, 0, 0), (0, 0, 0));
  level.player scripts\common\utility::allow_weapon(0);
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.8, 0.05);
  scripts\engine\sp\utility::array_spawn_noteworthy("price", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("ctbuddy", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo1", 1);
  scripts\engine\sp\utility::array_spawn_targetname("alpha", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("barrier_cops", 1);
  thread spawn_idle_cop(var0);
  var5 = scripts\sp\maps\townhoused\townhoused_outer::get_cop_barriers();
  var6 = scripts\engine\sp\utility::get_living_ai_array("barrier_cops", "script_noteworthy");
  var0 thread scripts\common\anim::anim_loop(var6, "apc_ride_loop", "stop_loop_apc_infil");
  level.groundrefent = scripts\engine\utility::spawn_script_origin();
  level.groundrefent linkTo(level.player_rig, "tag_player", (0, 0, 0), (0, 0, 0));
  var7 = [level.price, level.ctbuddy, level.bravo1, level.alpha1, level.alpha2];

  foreach(var9 in var7) {
    var9 linkTo(var1, "tag_origin", (0, 0, 0), (0, 0, 0));
    var1 thread scripts\common\anim::anim_loop_solo(var9, "apc_ride_loop", "stop_loop_apc_infil");
  }

  level.player_rig linkTo(var1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var1 thread scripts\common\anim::anim_loop_solo(level.player_rig, "apc_ride_loop", "stop_loop_apc_infil");
  var11 = getEnt("whatever", "targetname");
  var12 = scripts\engine\utility::getStruct("0.5", "targetname");
  var13 = spawnStruct();
  var13.origin = (0, 0, 0);
  var13.origin = (0, 0, 0);
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 0, 0, 0, 0);
  level.player playersetgroundreferenceent(level.groundrefent);
  level.player scripts\engine\utility::delaycall(0.5, &lerpviewangleclamp, 1, 0, 0, 30, 30, 20, 20);
  var0 thread scripts\common\anim::anim_single_solo(var1, "intro_ride");
  apc_intro_vo();
  var1 notify("stop_loop_apc_infil");
  var0 notify("stop_loop_apc_infil");
  level.price scripts\engine\utility::delaythread(0.8, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_sastl_intro_truck_40");
  thread sfx_barrier_open();
  thread scripts\sp\maps\townhoused\townhoused_outer::apc_exit_sequence(var0, var7, var1);
  thread scripts\sp\maps\townhoused\townhoused_outer::apc_exit_cops_sequence(var0, var6, var5);
  scripts\engine\utility::flag_set("start_player_exit_apc");
  level.player_rig unlink();
  var1 scripts\common\anim::anim_single_solo(level.player_rig, "apc_ride_exit");
  scripts\engine\utility::flag_set("player_exited_apc");
  scripts\sp\maps\townhoused\townhoused_code::set_objective("alley_gate");
  level thread scripts\sp\maps\townhoused\townhoused_code::train_go("north");
  level.player playersetgroundreferenceent(undefined);
  level.player unlink();
  level.player_rig hide();
  level.player scripts\common\utility::allow_weapon(1);
  level.groundrefent delete();
}

function spawn_idle_cop(var0) {
  var1 = getspawner("street_police1", "targetname");
  level.street_police1 = scripts\engine\sp\utility::dronespawn_bodyonly(var1);
  level.street_police1.animname = "street_police1";
  level.street_police1 scripts\common\ai::gun_remove();
  var0 scripts\common\anim::anim_loop_solo(level.street_police1, "apc_ride_exit_loop", "stop_street_police_idle");
}

function apc_intro_vo() {
  wait 0.2;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_intro_truck_10");
  wait 1;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_intro_truck_20");
  wait 1.5;
  level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_sastl_intro_truck_30");
  wait 2;
}

function sfx_barrier_open() {
  wait 10.5;
}

function apc_intro_sounds_start() {
  level.apc_1_sound_ent = spawn("script_origin", (-3299, -1399, -417));
  wait 3;
}

function street_start() {
  scripts\engine\sp\utility::array_spawn_noteworthy("price", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("ctbuddy", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("bravo1", 1);
  scripts\engine\sp\utility::array_spawn_targetname("alpha", 1);
  var0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  scripts\sp\maps\townhoused\townhoused_code::setup_player("streets", 1);
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_street", [level.player]);
  var0 thread scripts\common\anim::anim_loop_solo(level.bravo1, "gate_approach_pre_idle", "stop_loop_gate_approach_bravo");
  var0 thread scripts\common\anim::anim_loop([level.price, level.alpha1, level.alpha2, level.ctbuddy], "gate_approach_pre_idle", "stop_loop_gate_approach");
  scripts\engine\utility::flag_set("apc_exited");
  scripts\sp\maps\townhoused\townhoused_code::set_objective("alley_gate");
}

function street_main() {
  scripts\sp\maps\townhoused\townhoused_outer::spawn_padlock();
  scripts\engine\sp\utility::autosave_by_name("alley_main");
  var0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  scripts\engine\utility::flag_wait_all("apc_exited", "player_approaching_alley_gate", "street_movement_done");
  var0 notify("stop_loop_gate_approach");
  var0 notify("stop_loop_gate_approach_alpha1");
  level.alpha1 scripts\engine\utility::ent_flag_set("goto_alley_gate");
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_sas1_intro_street_530");
  level.alpha1.boltcutters unlink();
  var1 = [level.price, level.alpha1, level.alpha1.boltcutters];
  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop(var1, "gate_approach", "gate_approach_loop", "stop_loop_guys_cutting_gate");
  var1 = [level.alpha2, level.ctbuddy];
  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop(var1, "gate_approach", "gate_approach_loop", "stop_loop_guys_move_up_alley");
  thread alley_cutter_at_gate();
  thread alley_price_at_gate();
  scripts\engine\utility::flag_wait("cutter_at_alley_gate");
}

function alley_cutter_at_gate() {
  level.alpha1 waittillmatch("single anim", "end");
  level.alpha1 scripts\engine\sp\utility::smart_dialogue("dx_vom_sas2_intro_alley_10");
  scripts\engine\utility::flag_set("cutter_at_alley_gate");
}

function alley_price_at_gate() {
  level.price waittillmatch("single anim", "end");
  scripts\engine\utility::flag_set("price_at_alley_gate");
}

function alley_start() {
  scripts\sp\maps\townhoused\townhoused_code::setup_player("streets", 1);
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_alley", [level.player]);
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("ctbuddy", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo", 1);
  scripts\engine\sp\utility::array_spawn_targetname("alpha", 1);
  scripts\engine\utility::flag_set_delayed("price_at_alley_gate", 0.2);
  scripts\sp\maps\townhoused\townhoused_outer::spawn_padlock();
  var0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var1 = getspawner("bravo_driver", "targetname");
  level.bravo_driver = scripts\engine\sp\utility::dronespawn_bodyonly(var1);
  level.bravo_driver.animname = "bravo_driver";
  var1 = getspawner("street_police1", "targetname");
  level.street_police1 = scripts\engine\sp\utility::dronespawn_bodyonly(var1);
  level.street_police1.animname = "street_police1";
  level.street_police1 scripts\common\ai::gun_remove();
  var0 thread scripts\common\anim::anim_loop([level.bravo_driver, level.street_police1], "apc_ride_exit_loop", "stop_loop_street_police");
  var2 = [level.bravo2, level.bravo3, level.bravo4, level.bravo5, level.bravo6, level.bravo7];
  var0 thread scripts\common\anim::anim_loop(var2, "apc_ride_exit_loop");
  var0 thread scripts\common\anim::anim_loop([level.price, level.alpha1], "gate_approach_loop", "stop_loop_guys_cutting_gate");
  var0 thread scripts\common\anim::anim_loop([level.alpha2, level.ctbuddy], "gate_approach_loop", "stop_loop_alpha2_atgate");
  scripts\sp\maps\townhoused\townhoused_code::set_objective("alley_gate");
}

function alley_main() {
  var0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  thread scripts\sp\maps\townhoused\townhoused_outer::garage_tires();
  scripts\engine\utility::flag_wait_all("player_approaching_alley_gate", "price_at_alley_gate");
  scripts\engine\sp\utility::trigger_wait_targetname("player_at_alley_gate");
  var0 notify("stop_loop_guys_cutting_gate");
  level thread scripts\sp\maps\townhoused\townhoused_outer::alley_gate_open(var0);
  scripts\engine\utility::flag_wait("player_in_alley");
  scripts\sp\maps\townhoused\townhoused_code::set_objective("garage_entry");
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 5);
  scripts\engine\utility::flag_wait("player_at_end_of_alley");
  scripts\engine\utility::flag_set("player_can_go_loud");
  thread scripts\sp\maps\townhoused\townhoused_outer::garage_tv();
  var0 notify("stop_loop_guys_move_up_alley");
  var0 notify("stop_loop_alpha2_atgate");
  var0 notify("stop_loop_alpha1_through_gate");
  level.alpha1 scripts\engine\sp\utility::set_force_color("y");
  level.alpha2 scripts\engine\sp\utility::set_force_color("y");
  var0 thread scripts\common\anim::anim_single_solo(level.alpha2, "alley_enter");
  level.ctbuddy thread scripts\sp\maps\townhoused\townhoused_outer::alley_ctbuddy_anim(var0);
  level thread scripts\sp\maps\townhoused\townhoused_outer::alley_approach_garage(var0);
}

function garage_entry_start() {
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("ctbuddy", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo", 1);
  scripts\engine\sp\utility::array_spawn_targetname("alpha", 1);
  scripts\sp\maps\townhoused\townhoused_code::setup_player("streets", 1);
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_garage", [level.player, level.ctbuddy, level.alpha1, level.alpha2]);
  level.alpha1 scripts\engine\sp\utility::set_force_color("y");
  level.alpha2 scripts\engine\sp\utility::set_force_color("y");
  var0 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var0 thread scripts\common\anim::anim_loop_solo(level.price, "garage_entry_arrive_loop", "stop_loop_price_warehouse");
  scripts\engine\utility::flag_set("price_ready_for_garage_entry");
  var1 = getspawner("bravo_driver", "targetname");
  level.bravo_driver = scripts\engine\sp\utility::dronespawn_bodyonly(var1);
  level.bravo_driver.animname = "bravo_driver";
  var1 = getspawner("street_police1", "targetname");
  level.street_police1 = scripts\engine\sp\utility::dronespawn_bodyonly(var1);
  level.street_police1.animname = "street_police1";
  level.street_police1 scripts\common\ai::gun_remove();
  var0 thread scripts\common\anim::anim_loop([level.bravo_driver, level.street_police1], "apc_ride_exit_loop", "stop_loop_street_police");
  scripts\sp\maps\townhoused\townhoused_code::set_objective("garage_entry");
  scripts\engine\utility::delaythread(0.5, &scripts\sp\maps\townhoused\townhoused_outer::garage_tv);
}

function garage_init() {
  scripts\sp\maps\townhoused\townhoused_outer::garage_explosives_init();
  garage_fire_init();
  scripts\sp\maps\townhoused\townhoused_outer::garage_tripwire_init();
}

function garage_entry_main() {
  garage_init();
  scripts\engine\sp\utility::activate_trigger("garage_entry_colors", "targetname");
  scripts\engine\sp\utility::trigger_wait_targetname("trigger_player_near_garage_entry");
  scripts\engine\utility::flag_set("player_near_garage_entry");
  var0 = scripts\sp\door::get_interactive_door("warehouse_entrance_door");
  var0 scripts\sp\door::remove_open_ability();
  var0.locked = 1;
  scripts\engine\sp\utility::autosave_by_name_silent("garage1");
  level notify("move_bravo_through_gate");
  var1 = scripts\engine\utility::getStruct("apc_animnode", "targetname");
  var1 notify("stop_loop_gate_approach_bravo");
  var1 notify("stop_loop");
  thread scripts\sp\maps\townhoused\townhoused_outer::close_alley_gate();
  level thread scripts\sp\maps\townhoused\townhoused_outer::garage_knock();
  scripts\engine\utility::flag_wait("player_in_garage");
  thread garage2_lights();
  scripts\sp\maps\townhoused\townhoused_code::clear_objective_icons();
  scripts\sp\maps\townhoused\townhoused_code::set_objective("secure_garage");
  scripts\engine\utility::flag_wait("price_inside_garage");
}

function garage_entry_catchup() {
  thread garage2_lights();
  garage_init();
}

function garage_inner_start() {
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("ctbuddy", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha1", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha2", 1);
  scripts\sp\maps\townhoused\townhoused_code::setup_player("streets", 1);
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_garage2", [level.player, level.ctbuddy, level.price, level.alpha1, level.alpha2]);
  level.price scripts\engine\sp\utility::set_force_color("r");
  level.alpha1 scripts\engine\sp\utility::set_force_color("y");
  level.alpha2 scripts\engine\sp\utility::set_force_color("y");
  scripts\engine\sp\utility::array_spawn_noteworthy("garage2_enemy");
  scripts\sp\maps\townhoused\townhoused_code::set_objective("secure_garage");
  scripts\sp\maps\townhoused\townhoused_code::clear_objective_icons();
  scripts\sp\maps\townhoused\townhoused_outer::garage_tripwire_init();
}

function garage_inner_main() {
  scripts\engine\utility::flag_wait("player_near_garage2");
  scripts\engine\sp\utility::autosave_by_name("garage2");
  thread scripts\sp\maps\townhoused\townhoused_outer::garage2_lifted_taxi();
  thread scripts\sp\maps\townhoused\townhoused_outer::garage2_train();
  scripts\engine\utility::flag_wait("garage2_dead");
}

function garage2_lights() {
  scripts\engine\utility::flag_wait("garage2_light_off");
  thread scripts\engine\utility::add_dialogue_line("Distant Enemy", "Get the lights!");
  wait randomfloatrange(0.5, 2);
  var0 = getEntArray("garage2_lights", "targetname");

  foreach(var2 in var0) {
    var3 = getEnt(var2.target, "targetname");
    var3 setlightintensity(0);
    var2 setModel(scripts\engine\sp\utility::getmodel("garage_light_off"));
  }
}

function garage_fire_init() {
  var0 = getEntArray("garage_fire", "targetname");
  scripts\engine\utility::array_thread(var0, &garage_fire_thread);
}

function garage_fire_thread() {
  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(var4 == "MOD_EXPLOSIVE") {
      break;
    }
  }

  var10 = scripts\engine\utility::getStruct(self.target, "targetname");
  playFX(scripts\engine\utility::getfx("garage_fire"), var10.origin, anglesToForward(var10.angles));

  if(isDefined(level.garage_fire)) {
    return;
  }

  level.garage_fire = 1;
  var11 = getEnt("garage_fire_light", "targetname");
  var11.script_type = "pulse";
  var11.script_delay_min = 0.2;
  var11.script_delay_max = 0.5;
  var11 thread scripts\sp\lights::init_pulse();
}

function go_to_backyard_start() {
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha1", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("alpha2", 1);
  scripts\sp\maps\townhoused\townhoused_code::setup_player("streets");
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_go_to_backyard", [level.player, level.price, level.alpha1, level.alpha2]);
  level.alpha1 scripts\engine\sp\utility::set_force_color("y");
  level.alpha2 scripts\engine\sp\utility::set_force_color("y");
  scripts\engine\utility::flag_set("garage2_dead");
}

function go_to_backyard_main() {
  thread scripts\sp\maps\townhoused\townhoused_outer::garage2_price_exit();
  var0 = getEntArray("garage_color_triggers", "script_noteworthy");
  scripts\engine\utility::array_delete(var0);
  scripts\engine\sp\utility::activate_trigger_with_targetname("garage_exit_colors");
  scripts\engine\utility::flag_wait("player_outside_garage2");
  scripts\engine\utility::flag_set("cleanup_garage2");
  thread scripts\sp\analytics::analytics_kleenex_update("garage_done");
  thread guys_exit_garage();
  scripts\sp\maps\townhoused\townhoused_outer::cam_fly_up();
  level notify("cam_up");
  wait 0.1;
  backyard_setup();
}

function guys_exit_garage() {
  var0 = scripts\engine\utility::getStructArray("garage2_exit", "targetname");
  var0 = scripts\engine\sp\utility::array_index_by_script_index(var0);
  var1 = scripts\engine\sp\utility::spawn_targetname("kyle", 1);
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  waitframe();
  var2 = [var1, level.price];
  var2 = scripts\engine\utility::array_combine(var2, level.arrays_of_colorforced_ai["allies"]["y"]);

  foreach(var5, var4 in var2) {
    var4 forceteleport(var0[var5].origin, var0[var5].angles);
    var4 thread scripts\sp\spawner::go_to_node(var0[var5]);
  }

  level waittill("cam_up");
  var1 scripts\common\ai::stop_magic_bullet_shield();
  var1 delete();
}

function backyard_intro_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting::lt_backyard_intro_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo2", 1);
  var0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  var0 = scripts\engine\utility::array_add(var0, level.player);
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_backyard", var0);
}

function backyard_intro_main() {
  var0 = scripts\sp\hud_util::get_optional_overlay();
  var0.alpha = 1;
  thread remove_bg_hud();
  scripts\engine\sp\utility::array_spawn_noteworthy("backyard_alley_extra");
  thread sfx_distant_airplane();
  thread audio_intro_mix_change();
  scripts\sp\maps\townhoused\townhoused_inner::backyard_intro();
}

function remove_bg_hud() {
  wait 0.2;
  var0 = scripts\sp\hud_util::get_optional_overlay();
  var0.alpha = 0;
}

function audio_intro_mix_change() {
  wait 5;
  level.player clearclienttriggeraudiozone(9);
}

function backyard_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting::lt_backyard_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo2", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("backyard_alley_extra");
  var0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  var0 = scripts\engine\utility::array_add(var0, level.player);
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_backyard", var0);
  level.player scripts\engine\sp\utility::set_player_demeanor("safe");
  thread scripts\sp\maps\townhoused\townhoused_inner::restore_player_demeanor();
  thread sfx_distant_airplane();
  scripts\sp\maps\townhoused\townhoused_code::setup_player("backyard");
  var0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  scripts\engine\utility::array_thread(var0, &scripts\sp\maps\townhoused\townhoused_inner::backyard_alley_move_solo);
}

function backyard_setup() {
  var0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_backyard", var0);
}

function backyard_main() {
  scripts\engine\utility::flag_set("show_introscreen");
  var0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);

  foreach(var2 in var0) {
    var2 scripts\engine\utility::set_movement_speed(70);
  }

  thread scripts\engine\utility::flag_set_delayed("backyard_alley_extra_move", 2);
  thread scripts\sp\maps\townhoused\townhoused_inner::backyard_fail_thread();
  scripts\sp\maps\townhoused\townhoused_inner::backyard_door_setup();
  scripts\engine\utility::flag_wait("backyard_alley_ready");
  var4 = ["dx_vom_pri_backyard_alleyway_12", "dx_vom_pri_backyard_alleyway_13"];
  level.price thread scripts\sp\maps\townhoused\townhoused_code::nag(var4, "near_backyard_door", 12, 15);
  scripts\engine\utility::delaythread(3, &set_backyard_objective);
  scripts\engine\utility::flag_wait("near_backyard_door");
  scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::smart_radio_dialogue, "dx_vom_pri_backyard_alleyway_20");
  scripts\engine\utility::delaythread(1, &scripts\common\anim::anim_single_solo, level.price, "dx_vom_pri_backyard_alleyway_20");
  scripts\sp\maps\townhoused\townhoused_inner::backyard_door_open();
  scripts\engine\utility::delaythread(3, &scripts\sp\maps\townhoused\townhoused_code::train_go, "north", 50);
  var4 = ["dx_vom_pri_backyard_nag_10", "dx_vom_pri_backyard_nag_20", "dx_vom_pri_backyard_nag_30"];
  level.price thread scripts\engine\utility::delaythread(12, &scripts\sp\maps\townhoused\townhoused_code::nag, var4, "player_in_backyard", 12, 15);
  scripts\sp\maps\townhoused\townhoused_inner::backyard_move();
}

function test_prints() {}

function set_backyard_objective() {
  scripts\sp\maps\townhoused\townhoused_code::set_objective("townhouse_entry");
  scripts\sp\maps\townhoused\townhoused_code::objective_add_structpos("obj_townhouse_entry");
}

function clear_backyard_objective() {
  var0 = scripts\engine\utility::getStruct("obj_townhouse_entry", "targetname");
  scripts\sp\maps\townhoused\townhoused_code::objective_clear_structpos(var0);
}

function backyard_catchup() {
  set_backyard_objective();
  thread scripts\sp\maps\townhoused\townhoused_inner::backyard_fail_thread();
}

function kitchen_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting::lt_kitchen_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo2", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo3", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("backyard_alley_extra", 1);
  scripts\sp\maps\townhoused\townhoused_code::setup_player("backyard");
  var0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  var0 = scripts\engine\utility::array_add(var0, level.player);
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_kitchen", var0);
  scripts\engine\utility::flag_set("player_in_backyard");
  var1 = scripts\engine\sp\utility::get_living_ai("bravo2_4", "animname");
  var2 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  var2 thread scripts\common\anim::anim_loop_solo(var1, "backyard_move_idle", "stop_backyard_move_loop");
  scripts\sp\maps\townhoused\townhoused_inner::backdoor_freeze();
}

function kitchen_main() {
  thread scripts\sp\maps\townhoused\townhoused_inner::dining_light_death();
  thread scripts\sp\maps\townhoused\townhoused_inner::kitchen_player_clip();
  thread scripts\sp\maps\townhoused\townhoused_inner::kitchen_sequence();
  scripts\engine\utility::flag_wait("player_in_kitchen");
  clear_backyard_objective();
  scripts\sp\maps\townhoused\townhoused_code::set_objective("townhouse_1st_floor");
  thread audio_toggle_door_propagation();
  setglobalsoundcontext("trainby", "int", 2);
}

function kitchen_catchup() {
  setglobalsoundcontext("trainby", "int", 2);
  clear_backyard_objective();
  scripts\sp\maps\townhoused\townhoused_code::set_objective("townhouse_1st_floor");
  scripts\engine\utility::flag_set("backdoor_enter_done");
  scripts\engine\utility::flag_set("kitchen_takedown_fastforward");
  thread scripts\sp\maps\townhoused\townhoused_inner::kitchen_player_clip();
}

function audio_toggle_door_propagation() {
  var0 = getEnt("PropPortal", "targetname");
  var1 = getEnt("PropPortalTrigger", "targetname");
  var1 waittill("trigger");
  var0 enableaudioportal(0);
  var1 delete();
}

function audio_door_sound_clip_init() {
  scripts\engine\utility::flag_wait("interactive_doors_ready");
  var0 = [];
  GscBinSkip0(0x2e, 0, "kitchen_door");
}

function audio_door_clip_thread(var0) {
  var1 = scripts\sp\door::get_interactive_door(var0);
  var2 = getEnt(var0 + "_soundclip", "targetname");
  thread audio_door_damage_thread(var1);
  audio_door_interaction_wait(var1);
  var2 delete();
}

function audio_door_interaction_wait() {
  self endon("open_completely");
  self endon("ajar");
  self endon("bashed");
  self waittill("door_damaged_enough");
}

function audio_door_damage_thread(var0) {
  self endon("death");
  var0 setCanDamage(1);
  var1 = 0;

  while(var1 < 300) {
    self waittill("damage", var2);
    var1 += var2;
  }

  self notify("door_damaged_enough");
}

function dining_room_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting::lt_dining_room_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo2", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo3", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4", 1);
  scripts\engine\sp\utility::array_spawn_noteworthy("dining_enemies", 1);
  scripts\sp\maps\townhoused\townhoused_code::setup_player("townhouse");
  var0 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  var0 = scripts\engine\utility::array_add(var0, level.player);
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_dining_room", var0);
  var1 = scripts\engine\utility::getStruct("dining_room_price", "script_noteworthy");
  scripts\engine\utility::flag_set("player_in_kitchen");
  scripts\engine\utility::flag_set("kitchen_intro_vo_done");
  level.price thread scripts\sp\maps\townhoused\townhoused_code::force_nvg("on");
  scripts\sp\maps\townhoused\townhoused_inner::interior_price_settings();
  level.price scripts\sp\maps\townhoused\townhoused_code::scripted_movement(var1);
  level.price thread scripts\sp\maps\townhoused\townhoused_inner::stairtrain1_setup();
  thread scripts\sp\maps\townhoused\townhoused_inner::dining_light_death();
}

function dining_room_main() {
  scripts\engine\utility::flag_wait("dining_room_dead");
  thread dining_room_clear();
  wait 3;
  scripts\engine\utility::flag_wait_or_timeout("player_near_stairtrain1", 2);
  scripts\engine\sp\utility::autosave_by_name("1st_floor_done");
}

function dining_room_catchup() {
  scripts\sp\maps\townhoused\townhoused_inner::disable_player_sealth();
  scripts\engine\utility::flag_set("player_in_kitchen");
}

function dining_room_clear() {
  level.player endon("death");
  var0 = scripts\engine\utility::getStruct("dining_room_lookat_pos", "targetname");

  while(!level.player scripts\engine\trace::can_see_origin(var0.origin, 0)) {
    waitframe();
  }

  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code::wait_weapon_fire_cooldown(1, 4);
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_dining_room_frontroom_310");
  scripts\engine\utility::flag_set("player_said_dining_clear");
  level.player setsoundsubmix("sp_th_baby_cry");
}

function dining_room_ceiling_dialogue() {
  var0 = scripts\engine\utility::getStruct("2ndfloor_footsteps_bedroom", "targetname");
  var1 = scripts\engine\utility::getStruct("2ndfloor_footsteps_backbedroom", "targetname");
  var2 = scripts\engine\utility::spawn_script_origin(var0.origin);
  var2.animname = "temp1";
  var3 = scripts\engine\utility::spawn_script_origin(var1.origin);
  var3.animname = "temp2";
  var4 = scripts\engine\utility::spawn_script_origin(var0.origin);
  var4.animname = "temp3";
  var5 = scripts\engine\utility::spawn_script_origin(var1.origin);
  var5.animname = "temp4";
  dining_room_ceiling_dialogue_internal(var2, var3, var4, var5);

  while(var2 iswaitingonsound()) {
    waitframe();
  }

  wait 3;
  var2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_dining_room_aq_convo3_130");
  wait 0.3;
  var5 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_dining_room_aq_convo3_120");
  var2 delete();
  var3 delete();
  var4 delete();
  var5 delete();
}

function dining_room_ceiling_dialogue_internal(var0, var1, var2, var3) {
  if(scripts\engine\utility::flag("stairtrain1_done")) {
    return;
  }

  level endon("stairtrain1_done");
  thread scripts\sp\maps\townhoused\townhoused_inner::stairtrain1_ready_thread();
  wait 3.5;
  var2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_dining_room_aq_convo3_10");
  wait 0.4;
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_dining_room_aq_convo3_20");
  wait 0.6;
  var3 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_dining_room_aq_convo3_30");
  wait 0.3;
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_dining_room_aq_convo3_50");
  thread scripts\sp\maps\townhoused\townhoused_code::sound_mover("2ndfloor_footsteps_backbedroom");
  var4 = [];
  GscBinSkip0(0x2e, var4.size, "dx_vom_pri_stairtrain1_rally_40");
}

function stairtrain1_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting::lt_stairtrain1_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4", 1);
  scripts\sp\maps\townhoused\townhoused_code::setup_player("townhouse");
  var0 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
  var1 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
  var2 = [level.price, var0, var1, level.player];
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_stairtrain1", var2);
  scripts\engine\utility::flag_set("stairtrain1_go");
  scripts\engine\utility::flag_set("dining_room_dead");
  scripts\engine\utility::flag_set("player_said_dining_clear");
  level.price thread scripts\sp\maps\townhoused\townhoused_inner::stairtrain1_setup();
  level.player setsoundsubmix("sp_th_baby_cry");
}

function stairtrain1_main() {
  thread dining_room_ceiling_dialogue();
  scripts\sp\maps\townhoused\townhoused_code::set_objective("townhouse_2nd_floor");
  level waittill("stairtrain_reached_end");
  scripts\engine\utility::flag_set("stairtrain1_done");
}

function stairtrain1_catchup() {
  scripts\sp\maps\townhoused\townhoused_code::set_objective("townhouse_2nd_floor");
  scripts\engine\utility::flag_set("stairtrain1_remove_clip");
}

function second_floor_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting::lt_second_floor_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code::force_nvg("on");
  scripts\engine\utility::array_thread(level.squads["bravo4"], &scripts\sp\maps\townhoused\townhoused_code::force_nvg, "on");
  scripts\engine\sp\utility::array_spawn_noteworthy("2nd_floor_enemies", 1);
  scripts\sp\maps\townhoused\townhoused_code::setup_player("townhouse");
  var0 = scripts\engine\utility::array_add(level.squads["bravo4"], level.price);
  var0 = scripts\engine\utility::array_add(var0, level.player);
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_2nd_floor", var0);
  level.player setsoundsubmix("sp_th_baby_cry");
}

function second_floor_main() {
  thread scripts\sp\maps\townhoused\townhoused_inner::second_floor_movement();
  thread second_floor_enemies_dead_dialogue();
  scripts\engine\utility::flag_wait("2ndfloor_bathroom_enemy_dead");
  thread scripts\sp\maps\townhoused\townhoused_code::clear_floor("2nd_floor_clear", "2nd_floor_clear");
  scripts\engine\utility::flag_wait("2nd_floor_clear");
  thread second_floor_clear();
  wait 0.4;
  scripts\engine\sp\utility::autosave_by_name("2nd_floor_done");
}

function second_floor_clear() {
  level.player endon("death");
  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code::wait_last_nag_finished();
  scripts\sp\maps\townhoused\townhoused_code::wait_weapon_fire_cooldown(1.5, 5);
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_2nd_floor_bedroom2_170");
  wait 0.2;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_stairtrain2_rally_40");
  scripts\sp\maps\townhoused\townhoused_code::set_objective("townhouse_3rd_floor");
  thread stairtrain2_nags();
}

function second_floor_enemies_dead_dialogue() {
  level.player endon("death");
  level endon("2nd_floor_clear");
  scripts\engine\utility::flag_wait("hostage_guys_dead_or_longdeath");

  while(!level.player scripts\engine\trace::can_see_origin(level.last_hostage_death_position, 0)) {
    waitframe();
  }

  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code::wait_weapon_fire_cooldown(1, 3);
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_2nd_floor_bedroom2_100");
  wait 0.2;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a12_2nd_floor_bedroom2_110");
  wait 0.5;

  if(!scripts\engine\utility::flag("2nd_floor_clear")) {
    scripts\sp\maps\townhoused\townhoused_code::objective_add_structpos("obj_townhouse_1st_floor");
  }

  thread second_floor_clear_nag();
}

function second_floor_catchup() {
  scripts\sp\maps\townhoused\townhoused_code::set_objective("townhouse_3rd_floor");
  scripts\sp\maps\townhoused\townhoused_inner::interior_price_settings();
}

function second_floor_clear_nag() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_pri_2nd_floor_bedroom2_120");
}

function stairtrain2_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting::lt_stairtrain2_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code::force_nvg("on");
  scripts\engine\utility::array_thread(level.squads["bravo4"], &scripts\sp\maps\townhoused\townhoused_code::force_nvg, "on");
  scripts\sp\maps\townhoused\townhoused_code::setup_player("townhouse");
  scripts\engine\utility::flag_set("player_near_stairtrain2");
  var0 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
  var1 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
  var2 = [level.price, var0, var1, level.player];
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_stairtrain2", var2);
  var2 = scripts\engine\utility::array_remove(var2, level.player);

  foreach(var4 in var2) {
    var4 thread scripts\sp\maps\townhoused\townhoused_inner::stairtrain2_setup();
  }
}

function stairtrain2_main() {
  scripts\engine\utility::delaythread(2, &scripts\sp\maps\townhoused\townhoused_code::set_objective, "townhouse_3rd_floor");
  level waittill("stairtrain_reached_end");
  scripts\engine\utility::flag_set("stairtrain2_done");
}

function stairtrain2_nags() {
  level endon("player_near_stairtrain2");
  wait 5;
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_pri_stairtrain2_rally_10");
}

function third_floor_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting::lt_third_floor_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code::force_nvg("on");
  scripts\engine\utility::array_thread(level.squads["bravo4"], &scripts\sp\maps\townhoused\townhoused_code::force_nvg, "on");
  scripts\sp\maps\townhoused\townhoused_code::setup_player("townhouse");
  var0 = scripts\engine\utility::array_add(level.squads["bravo4"], level.price);
  var0 = scripts\engine\utility::array_add(var0, level.player);
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_3rd_floor", var0);
  level.player setsoundsubmix("sp_th_baby_cry");
}

function third_floor_main() {
  thread scripts\sp\maps\townhoused\townhoused_inner::third_floor_movement();
  thread third_floor_clear_nag();
  thread scripts\sp\maps\townhoused\townhoused_code::clear_floor("3rd_floor_clear", "3rd_floor_clear", &on_see_3f_struct);
  scripts\engine\utility::flag_wait("3rd_floor_enemies_dead");
  setmusicstate("mx_townhouse_area1secure_lp");
  thread scripts\engine\utility::flag_set_delayed("start_baby_cry", 3);
  scripts\engine\utility::flag_wait("3rd_floor_clear");
  thread third_floor_clear();
  scripts\engine\sp\utility::autosave_by_name("3rd_floor_done");
}

function third_floor_catchup() {
  scripts\sp\maps\townhoused\townhoused_code::set_objective("townhouse_4th_floor");
}

function on_see_3f_struct(var0) {
  level.player endon("death");

  if(var0 != scripts\engine\utility::getStructArray("3rd_floor_clear", "targetname")[1]) {
    return;
  }

  wait randomfloatrange(0.4, 1);

  if(scripts\engine\utility::flag("3rd_floor_clear") && scripts\engine\utility::flag("3rd_floor_enemies_dead")) {
    return;
  }

  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_3rd_floor_bedroom_140");
}

function third_floor_clear() {
  level.player endon("death");
  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code::wait_weapon_fire_cooldown(0.6, 3);
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_3rd_floor_bedroom_150");
  thread third_floor_clear_extra();
  thread stairtrain3_player_near();
}

function third_floor_clear_extra() {
  if(scripts\engine\utility::flag("buddy_down_skip")) {
    wait 2;
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_stairtrain3_rally_43");
    scripts\sp\utility::giveachievement_wrapper("wallhax");
  }

  wait 0.65;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_stairtrain3_rally_10");
  scripts\sp\maps\townhoused\townhoused_code::set_objective("townhouse_4th_floor");
  thread stairtrain3_nag();
}

function stairtrain3_nag() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_pri_stairtrain3_rally_20");
}

function third_floor_clear_nag() {
  scripts\engine\utility::flag_wait("3rd_floor_bedroom_enemy_dead");

  if(!scripts\engine\utility::flag("3rd_floor_clear")) {
    scripts\sp\maps\townhoused\townhoused_code::objective_add_structpos("obj_townhouse_2nd_floor");
  }

  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_pri_3rd_floor_bedroom_110");
}

function stairtrain3_player_near() {
  var0 = getEnt("player_near_stairtrain3", "targetname");
  var0 waittill("trigger");
  scripts\engine\utility::flag_set("player_near_stairtrain3");
}

function stairtrain3_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting::lt_stairtrain3_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4_reinforcements", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code::force_nvg("on");
  scripts\sp\maps\townhoused\townhoused_code::setup_player("townhouse");
  var0 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
  var1 = [var0, level.price, level.player];
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_stairtrain3", var1);
  level.price thread scripts\sp\maps\townhoused\townhoused_inner::stairtrain3_setup();
  level.player setsoundsubmix("sp_th_baby_cry");
}

function stairtrain3_main() {
  scripts\sp\maps\townhoused\townhoused_code::set_objective("attic");
  thread scripts\sp\maps\townhoused\townhoused_inner::baby_mom_prior_dialog();
  level waittill("stairtrain_reached_end");
  scripts\engine\utility::flag_set("stairtrain3_done");
}

function fourth_floor_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting::lt_fourth_floor_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  scripts\engine\sp\utility::array_spawn_targetname("bravo4_reinforcements", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code::force_nvg("on");
  scripts\sp\maps\townhoused\townhoused_code::setup_player("townhouse");
  var0 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
  var1 = [var0, level.price, level.player];
  var0 scripts\engine\utility::ent_flag_init("stairtrain_on");
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_4th_floor", var1);
  scripts\engine\sp\utility::activate_trigger("4th_floor_spawn", "targetname");
  scripts\engine\utility::flag_set("start_baby_cry");
}

function fourth_floor_main() {
  level.player endon("death");
  thread scripts\sp\maps\townhoused\townhoused_inner::fourth_floor_door();
  thread scripts\sp\maps\townhoused\townhoused_inner::fourth_floor_movement();
  thread scripts\sp\maps\townhoused\townhoused_inner::fourth_floor_clear_nag();
  scripts\engine\utility::flag_wait("4th_floor_enemies_dead");
  wait 1;
  thread music_clear_4th_floor();
  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code::wait_weapon_fire_cooldown(1, 4);
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_4th_floor_bedroom_100");
  scripts\engine\sp\utility::autosave_by_name("4th_floor_done");
  wait 1;
  thread scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_4th_floor_bedroom_110");
  scripts\sp\maps\townhoused\townhoused_code::set_objective("townhouse_attic");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_pri_4th_floor_bedroom_120");
}

function music_clear_4th_floor() {
  wait 2;
  setmusicstate("mx_townhouse_area2secure_lp");
}

function fourth_floor_catchup() {
  scripts\sp\maps\townhoused\townhoused_code::set_objective("thownhouse_attic");
}

function attic_start() {
  thread scripts\sp\maps\townhoused\townhoused_lighting::lt_attic_start();
  scripts\engine\sp\utility::array_spawn_targetname("price", 1);
  level.price thread scripts\sp\maps\townhoused\townhoused_code::force_nvg("on");
  scripts\sp\maps\townhoused\townhoused_code::setup_player("townhouse");
  var0 = [level.price, level.player];
  scripts\sp\maps\townhoused\townhoused_code::set_start_location_by_animname("start_attic", var0);
}

function attic_main() {
  if(level.start_point == "attic") {
    scripts\engine\utility::flag_wait("player_at_attic_stairs");
  }

  thread scripts\sp\maps\townhoused\townhoused_inner::attic_room();
  scripts\engine\utility::flag_wait("end_scene_done");
  scripts\engine\sp\utility::nextmission();
}

function sfx_distant_airplane() {
  var0 = spawn("script_origin", (-1036, -165, 979));
  var0 playSound("emt_amb_jet_distant_lp", "sound_done");
  wait 7;
  var0 moveTo((-979, 2604, 432), 30);
  var0 waittill("sound_done");
  var0 delete();
}

function audio_front_door_dog_sfx() {
  level.frontdoordog = spawn("script_origin", (60, 1263, -335));
  level.frontdoordog scripts\engine\sp\utility::sound_fade_in("emt_dog_barking_dist_03", 1, 0.8, 1);
  level waittill("stop_dog_sounds_front_door");
  level.frontdoordog scripts\engine\sp\utility::sound_fade_and_delete(8, 1);
}