/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_defend_zodiac.gsc
******************************************/

defend_zodiac_pre_load() {
  common_scripts\utility::flag_init("defend_zodiac");
  common_scripts\utility::flag_init("defend_zodiac_finished");
  common_scripts\utility::flag_init("defend_zodiac_wave_01");
  common_scripts\utility::flag_init("defend_zodiac_wave_02");
  common_scripts\utility::flag_init("defend_zodiac_wave_03b");
  common_scripts\utility::flag_init("gunboats_01");
  common_scripts\utility::flag_init("defend_osprey_online");
  common_scripts\utility::flag_init("lower_blastshield");
  common_scripts\utility::flag_init("gunship_attack");
  common_scripts\utility::flag_init("defend_zodiac_ally_cleanup");
  common_scripts\utility::flag_init("dz_respawn_friendlies");
  common_scripts\utility::flag_init("dz_friendly_spawner_locked");
  common_scripts\utility::flag_init("post_osprey");
  common_scripts\utility::flag_init("start_knockdown_moment");
  common_scripts\utility::flag_init("knockdown_moment");
  common_scripts\utility::flag_init("osprey_intermission");
  common_scripts\utility::flag_init("dz_deck_explode");
  common_scripts\utility::flag_init("gunship_attack_01");
  common_scripts\utility::flag_init("gunship_attacking");
  common_scripts\utility::flag_init("pre_gunship_attack_vo");
  common_scripts\utility::flag_init("destroyed_fed_destroyer_guns");
  common_scripts\utility::flag_init("dz_warning");
  common_scripts\utility::flag_init("hesh_close_to_knockdown");
  precacherumble("damage_light");
  precacherumble("damage_heavy");
  precacheshader("overlay_static");
  precachemodel("crr_zodiac_full");
  precachemodel("crr_assault_rope_static");
  precachestring(&"CARRIER_CUT_ROPE_HINT");
  precachemodel("cnd_rope_rappel_coil_04");
  precacheitem("panzerfaust3_cheap");
  precacheitem("panzerfaust3_player");
  maps\carrier_depth_charge::depth_charge_init();
  thread maps\carrier_code::player_rain_drops();
  level.zodiacs = [];
  level.gunboats = [];
  level.water_splash_trigger = getent("water_splash_trigger", "targetname");
  level.defend_zodiac_ally_respawner = getent("defend_zodiac_ally_respawner", "targetname");
  level.dz_intermission_enemies = [];
  level.dead_ally_drones = [];
  level.cut_ropes = [];
  level.zodiac_ally_shoot_targets = common_scripts\utility::getstructarray("zodiac_ally_shoot_target", "targetname");
  level.zodiac_allies = [];
  level.corpse_entnums = [];
  level.defend_zodiac_arrived_right = getent("defend_zodiac_arrived_right", "targetname");
  level.defend_zodiac_arrived_right maps\_utility::hide_entity();
  level.defend_zodiac_arrived_catwalk = getent("defend_zodiac_arrived_catwalk", "targetname");
  level.defend_zodiac_arrived_catwalk maps\_utility::hide_entity();
  level.start_climbover = getent("start_climbover", "targetname");
  level.start_climbover maps\_utility::hide_entity();
  level.stern_corner_clean = getEntArray("stern_corner_clean", "targetname");
  level.stern_corner_dmg = getEntArray("stern_corner_dmg", "targetname");
  common_scripts\utility::array_thread(level.stern_corner_dmg, maps\_utility::hide_entity);
  var_0 = getEntArray("dz_kill_triggers", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, maps\_utility::hide_entity);
  level.gunship_trans_triggers = getEntArray("gunship_trans_triggers", "targetname");
  common_scripts\utility::array_thread(level.gunship_trans_triggers, maps\_utility::hide_entity);
  var_1 = getEntArray("anim_tugger", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::hide_entity);
  level.dz_deck_explode_dmg = getEntArray("dz_deck_explode_dmg", "targetname");
  common_scripts\utility::array_thread(level.dz_deck_explode_dmg, maps\carrier_code::hide_and_drop_entity);
  level.deck_ac130_dmg = getEntArray("deck_ac130_dmg", "targetname");
  common_scripts\utility::array_thread(level.deck_ac130_dmg, maps\carrier_code::hide_and_drop_entity);
  level.deck_ac130_dmg_clip = getEntArray("deck_ac130_dmg_clip", "targetname");
  common_scripts\utility::array_thread(level.deck_ac130_dmg_clip, maps\_utility::hide_entity);
  level.elevator_ac130_dmg = getEntArray("elevator_ac130_dmg", "targetname");
  common_scripts\utility::array_thread(level.elevator_ac130_dmg, maps\carrier_code::hide_and_drop_entity);
  level.elevator_dmg_models = getEntArray("elevator_dmg_models", "targetname");
  common_scripts\utility::array_thread(level.elevator_dmg_models, maps\carrier_code::hide_and_drop_entity);
  level.elevator_ac130_dmg_02 = getEntArray("elevator_ac130_dmg_02", "targetname");
  common_scripts\utility::array_thread(level.elevator_ac130_dmg_02, maps\carrier_code::hide_and_drop_entity);
  level.fed_destroyer_osprey = getent("fed_destroyer_osprey", "targetname");
  level.fed_destroyer_clip = getent("fed_destroyer_clip", "targetname");
  level.destroyer_guy_nodes = getEntArray("destroyer_guy_nodes", "script_noteworthy");
  level.fed_destroyer_fx_guns = getEntArray("fed_destroyer_fx_gun", "targetname");
  level.destroyer_targets_big = [];
  level.fed_destroyer_guys = [];
  level.osprey_carrier_vol = getent("osprey_carrier_vol", "targetname");
  level.ally_edge_nodes = getnodearray("ally_edge_node_02", "targetname");
  level.ally_shoot_nodes = getnodearray("ally_shoot_node_02", "targetname");
  level.cut_rope_trigger = getent("cut_rope_trigger", "targetname");
  level.cut_rope_trigger maps\_utility::hide_entity();
}

setup_defend_zodiac() {
  level.start_point = "defend_zodiac";
  maps\carrier_code::setup_common();
  maps\carrier_code::spawn_allies();
  maps\_utility::set_team_bcvoice("allies", "delta");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::flavorbursts_on("allies");
  common_scripts\utility::flag_set("hesh_run");
  common_scripts\utility::flag_set("hesh_talking_finished");
  common_scripts\utility::flag_set("deck_transition_finished");
  thread maps\carrier::obj_defend_carrier();
  thread maps\carrier_audio::aud_check("defend_zodiac");
  var_0 = getent("blast_shield1_clip", "targetname");
  var_0 maps\_utility::show_entity();
  var_1 = getent("blast_shield2_clip", "targetname");
  var_1 maps\_utility::show_entity();
  thread run_allies(1);
  var_2 = getent("water_wake_intro", "targetname");
  var_2 delete();
  level.debug_function = ::osprey_intermission;
  thread run_jet_takeoff();
}

begin_defend_zodiac() {
  common_scripts\utility::flag_set("defend_zodiac");
  thread cleanup_deck_transition();
  thread maps\carrier_code::setup_edge_lean();
  thread run_defend_zodiac();
  thread maps\carrier_code_zodiac::monitor_zodiac_count();
  thread ally_drone_cleanup();
  thread run_enemy_destroyer();
  thread maps\carrier_code_zodiac::run_corpse_cleanup();
  thread maps\carrier_code_zodiac::setup_cut_rope_hint();
  level.zodiac_repulsor = missile_createrepulsorent(level.player, 5000, 2000);
  thread kill_trigger_setup();
  setsaveddvar("ragdoll_max_life", 100000);
  level.defend_zodiac_arrived_right maps\_utility::show_entity();
  level.defend_zodiac_arrived_catwalk maps\_utility::show_entity();
  thread maps\carrier_audio::aud_defend_zodiac_zone();
  common_scripts\utility::flag_wait("defend_zodiac_finished");
  missile_deleteattractor(level.zodiac_repulsor);
  level.player notify("stop_tracking_hold_use");
  thread gunship_attack_autosave();
  thread spawner_cleanup();
}

gunship_attack_autosave() {
  wait 0.5;

  if(common_scripts\utility::flag("dz_warning_right") || common_scripts\utility::flag("dz_warning_front") || common_scripts\utility::flag("dz_warning_rear")) {
    return;
  }
  if(level.player istouching(getent("gunship_attack_save_vol", "targetname"))) {
    thread maps\_utility::autosave_now();
  }
}

cleanup_deck_transition() {
  common_scripts\utility::flag_wait("defend_zodiac_wave_01");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
  var_2 kill();
  }

  wait 2;
  var_4 = vehicle_getarray();

  foreach(var_6 in var_4) {
    if(isDefined(var_6.classname) && !issubstr(var_6.classname, "mig")) {
      thread maps\_utility::ai_delete_when_out_of_sight([var_6], 4000);
    }
  }

  thread maps\carrier_code::phalanx_gun_offline("crr_phalanx_03");
  thread maps\carrier_code::phalanx_gun_offline("crr_phalanx_05");
}

catchup_defend_zodiac() {
  thread lower_blastshield(0);
  thread spawner_cleanup();
  common_scripts\utility::flag_set("defend_zodiac");
  common_scripts\utility::flag_set("post_osprey");
  common_scripts\utility::array_thread(level.deck_ac130_dmg, maps\carrier_code::show_and_raise_entity);
  common_scripts\utility::array_thread(level.deck_ac130_dmg_clip, maps\_utility::show_entity);
  common_scripts\utility::array_thread(level.elevator_ac130_dmg, maps\carrier_code::show_and_raise_entity);
  common_scripts\utility::array_thread(level.dz_deck_explode_dmg, maps\carrier_code::show_and_raise_entity);
  common_scripts\utility::array_thread(getEntArray("barrel_impact_2", "targetname"), maps\_utility::hide_entity);
  common_scripts\utility::array_thread(getEntArray("odin_phys_objects_2", "targetname"), maps\_utility::hide_entity);
  thread cleanup_enemy_destroyer();
  var_0 = getEntArray("deck_combat_weapons", "targetname");
  maps\_utility::array_delete(var_0);
  common_scripts\utility::flag_set("gunship_trans_mid");
}

run_defend_zodiac() {
  thread run_vignettes();
  thread run_enemies();
  thread run_helis();
  thread run_hesh();
  thread run_vo();
  common_scripts\utility::flag_wait("gunship_attack");
  gunship_attack();
}

run_hesh() {
  common_scripts\utility::flag_wait("hesh_run");
  level.hesh maps\_utility::delaythread(1.5, maps\_utility::enable_exits);
  level.hesh maps\_utility::disable_cqbwalk();
  level.hesh maps\_utility::set_goalradius(100);
  level.hesh maps\_utility::pathrandompercent_zero();
  level.hesh maps\_utility::set_baseaccuracy(15);
  level.hesh maps\_utility::unset_forcegoal();
  level.hesh disable_flinch();
  thread hesh_initial_sprint();
  var_0 = common_scripts\utility::getstruct("hesh_defend_run_1", "targetname");
  level.hesh setgoalpos(var_0.origin);
  level.hesh waittill("goal");
  var_1 = common_scripts\utility::getstruct("hesh_defend_run_2", "targetname");
  level.hesh setgoalpos(var_1.origin);
  level.hesh maps\_utility::set_goalradius(8);
  level.hesh.ignoreall = 0;
  common_scripts\utility::flag_wait("dz_deck_explode");
  wait 0.25;
  level.hesh maps\_anim::anim_generic_custom_animmode(level.hesh, "gravity", "run_react_stumble");
  level.hesh maps\_utility::set_ignoreall(0);
  var_2 = common_scripts\utility::getstruct("hesh_defend_run_jumpdown", "targetname");
  var_2 maps\_anim::anim_generic_reach(level.hesh, "traverse_jumpdown_56");
  var_2 thread maps\_anim::anim_generic(level.hesh, "traverse_jumpdown_56");
  wait 1.2;
  level.hesh stopanimscripted();
  level.hesh maps\_utility::set_goalradius(8);
  level.hesh maps\_utility::disable_sprint();
  var_3 = getnode("defend_zodiac_hesh_node_right", "targetname");
  var_3 maps\_anim::anim_generic_reach(level.hesh, "carrier_rappel_defend_ally_lean_enter");
  level.hesh enable_flinch();
  level.hesh thread ally_edge_think(var_3);
}

hesh_initial_sprint() {
  common_scripts\utility::flag_wait("defend_zodiac_arrived_right");
  var_0 = common_scripts\utility::getstruct("defend_dot", "targetname");
  var_1 = distance(var_0.origin, level.player.origin);
  var_2 = distance(var_0.origin, level.hesh.origin);

  if(var_1 <= var_2 + 200) {
    level.hesh maps\_utility::enable_sprint();
  }
}

enable_flinch() {
  maps\_utility::enable_pain();
  self.ignoreall = 0;
  self.ignoreme = 0;
  maps\_utility::set_ignoresuppression(0);
  self.ignorerandombulletdamage = 0;
  self.disablebulletwhizbyreaction = 0;
}

disable_flinch() {
  maps\_utility::disable_pain();
  self.ignoreall = 1;
  self.ignoreme = 1;
  maps\_utility::set_ignoresuppression(1);
  self.ignorerandombulletdamage = 1;
  self.disablebulletwhizbyreaction = 1;
}

run_vo() {
  common_scripts\utility::flag_wait("hesh_run");
  wait 5;
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_letsgotheyretrying");

  if(!common_scripts\utility::flag("defend_zodiac_arrived_right")) {
    hesh_nag_follow_vo();
  }

  wait 1;
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_takeoutthezodiacs");
  thread zodiac_background_sparrow_vo();
  maps\_utility::smart_radio_dialogue("carrier_wsp1_wasp1weare");
  thread zodiacs_defend_vo();
  thread zodiac_defend_clear_vo();
  wait 4;
  thread maps\_utility::smart_radio_dialogue("carrier_ttn_osprey22is1");
  maps\_utility::smart_radio_dialogue("carrier_ttn_beadvised10plus");
  common_scripts\utility::flag_wait("defend_zodiac_wave_02");
  maps\_utility::smart_radio_dialogue("carrier_com_allsquadsadditional");
  common_scripts\utility::flag_wait("gunboats_01");
  maps\_utility::smart_radio_dialogue("carrier_ttn_hostilegunboatsincoming");
  wait 3.5;
  thread maps\_utility::smart_radio_dialogue("carrier_ttn_osprey22isready");
  wait 0.5;
  common_scripts\utility::flag_set("defend_osprey_online");
  thread run_osprey_nag_first_time_vo();
  thread run_osprey_start_vo();
  thread run_osprey_hit_vo();
  thread run_osprey_finish_vo();
  common_scripts\utility::flag_wait("defend_zodiac_osprey_turn");
  wait 1;
  maps\_utility::smart_radio_dialogue("carrier_hp2_goodruncomingback");
  wait 1;
  thread maps\_utility::smart_radio_dialogue("carrier_ttn_ospreyisinposition");
  common_scripts\utility::flag_wait("osprey_intermission");
  wait 2;
  thread intermission_vo();
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_morezodiacsincoming");
  wait 4;
  maps\_utility::smart_radio_dialogue("carrier_plt1_v22isonlinemaking");
  wait 3;
  common_scripts\utility::flag_set("defend_zodiac_wave_03b");
  thread maps\_utility::smart_radio_dialogue("carrier_ttn_ospreyisreadyfor");
  common_scripts\utility::flag_wait("defend_osprey_online");
  thread run_osprey_nag_vo();
  thread run_osprey_start_2_vo();
  thread run_osprey_hit_vo();
}

hesh_nag_follow_vo() {
  level endon("defend_zodiac_arrived_right");

  for(;;) {
    wait(randomfloatrange(4, 6));
    level.hesh maps\_utility::smart_dialogue("carrier_hsh_loganthisway");
    wait(randomfloatrange(4, 6));
    level.hesh maps\_utility::smart_dialogue("carrier_hsh_letsgotheyretrying");
  }
}

zodiacs_defend_vo() {
  level.player endon("start_using_depth_charge");
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_tangosclimbingupthe");
  wait 5;
  level.hesh maps\_utility::smart_dialogue("carrier_mrk_takeoutthoseropes");
  wait 4;
  var_0 = get_closest_ally();

  if(isDefined(var_0)) {
    var_0 maps\_utility::smart_dialogue("carrier_us2_mandown");
  }

  wait 2;
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_takeoutthezodiacs");
  wait 3;
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_cuttheropes");
  wait 4;
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_dontletthemup");
  wait 5;
  var_0 = get_closest_ally();

  if(isDefined(var_0)) {
    var_0 maps\_utility::smart_dialogue("carrier_us2_clearthoseropes");
  }
}

zodiac_defend_clear_vo() {
  level.player endon("using_depth_charge");
  defend_zodiac_waittill_enemies_remaining(1, 999);
  var_0 = get_closest_ally();

  if(isDefined(var_0)) {
    var_0 maps\_utility::smart_dialogue("carrier_us2_ropesclear");
  }
}

intermission_vo() {
  wait 3;
  var_0 = get_closest_ally();

  if(isDefined(var_0)) {
    var_0 maps\_utility::smart_dialogue("carrier_us2_mandown");
  }

  wait 4;
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_takeoutthezodiacs");
}

zodiac_background_sparrow_vo() {
  wait(randomfloatrange(5.0, 9.0));
  maps\_utility::smart_radio_dialogue_overlap("carrier_us1_sparrow1and2");
  wait(randomfloatrange(5.0, 9.0));
  maps\_utility::smart_radio_dialogue_overlap("carrier_us3_sparrow4firing");
  wait(randomfloatrange(5.0, 9.0));
  maps\_utility::smart_radio_dialogue_overlap("carrier_us2_sparrow3reloading");
  wait(randomfloatrange(5.0, 9.0));
  maps\_utility::smart_radio_dialogue_overlap("carrier_us3_sparrow4isdamaged");
  common_scripts\utility::flag_wait("osprey_intermission");
  wait 4;
  maps\_utility::smart_radio_dialogue_overlap("carrier_us2_sparrow3targetingsystems");
  wait(randomfloatrange(5.0, 9.0));
  maps\_utility::smart_radio_dialogue_overlap("carrier_us1_etaonsparrow3");
  wait(randomfloatrange(5.0, 9.0));
  maps\_utility::smart_radio_dialogue_overlap("carrier_us2_workingongettingthe");
}

run_enemies() {
  thread initial_climb_over();
  thread initial_edge_ally_left();
  thread initial_drone_allies();
  waittill_kickoff_zodiac();

  if(!common_scripts\utility::flag("dz_warning_right") && !common_scripts\utility::flag("dz_warning_front") && !common_scripts\utility::flag("dz_warning_rear")) {
    thread maps\_utility::autosave_now();
  }

  common_scripts\utility::flag_set("defend_zodiac_wave_01");
  maps\_utility::delaythread(3.5, ::initial_rpgs);
  common_scripts\utility::flag_wait("defend_zodiac_arrived_right");
  thread zodiac_initial_attack();
  wait 4;
  defend_zodiac_waittill_enemies_remaining(8, 17);
  thread defend_zodiac_autosave(1);
  thread zodiac_main_wave();
  wait 2;
  common_scripts\utility::flag_set("defend_zodiac_wave_02");
  common_scripts\utility::flag_wait("defend_osprey_online");
  level.player thread maps\carrier_depth_charge::depth_charge_give_control();
  level.player waittill("using_depth_charge");
  thread defend_zodiac_autosave(1);
  maps\carrier_code_zodiac::clear_all_corpses();
  thread zodiac_osprey_wave();
  common_scripts\utility::flag_wait("defend_zodiac_osprey_turn");
  maps\_utility::delaythread(0, ::zodiac_turn_wave);
  level.player waittill("depth_charge_exit");
  maps\carrier_code_zodiac::clear_all_corpses();
  thread defend_zodiac_autosave(0, 1);
  thread osprey_intermission();
  common_scripts\utility::flag_clear("defend_osprey_online");
  thread zodiac_main_wave_2();
  common_scripts\utility::flag_wait("defend_zodiac_wave_03b");
  wait 1;
  level.player thread maps\carrier_depth_charge::depth_charge_give_control();
  common_scripts\utility::flag_set("defend_osprey_online");
  level.player_ignored_2nd_osprey = level.player common_scripts\utility::waittill_notify_or_timeout_return("using_depth_charge", 60);

  if(isDefined(level.player_ignored_2nd_osprey)) {
    level.player thread maps\carrier_depth_charge::depth_charge_remove_control();
    maps\_utility::delaythread(0, ::pre_gunship_attack_vo);
    wait 2;
    thread cleanup_intermission_enemies();
  } else {
    thread defend_zodiac_autosave(1);
    maps\carrier_code_zodiac::clear_all_corpses();
    thread zodiac_osprey_2_wave();
    thread cleanup_intermission_enemies();
    thread run_enemy_destroyer_2();
    common_scripts\utility::flag_wait("defend_zodiac_osprey_turn");
    maps\_utility::delaythread(0, ::zodiac_turn_wave);
    common_scripts\utility::flag_wait("defend_zodiac_osprey_end_turn");
    maps\_utility::delaythread(0, ::pre_gunship_attack_vo);
    maps\_utility::delaythread(0, ::osprey2_gunship_attack);
    level.player waittill("depth_charge_exit");
    level.player thread maps\carrier_depth_charge::depth_charge_remove_control();
    maps\carrier_code_zodiac::clear_all_corpses();
    thread maps\carrier_vista::clear_vista_vehicles();
  }

  common_scripts\utility::flag_clear("defend_osprey_online");
  common_scripts\utility::flag_set("post_osprey");
  maps\_utility::array_delete(level.destroyer_guy_nodes);
  common_scripts\utility::flag_set("gunship_attack");
  thread lower_blastshield();
}

waittill_kickoff_zodiac() {
  level endon("defend_zodiac_arrived_right");
  var_0 = common_scripts\utility::getstruct("hesh_defend_run_1", "targetname");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1 maps\_utility::waittill_player_lookat(0.7, 1.5, 1);
  var_1 delete();
}

initial_edge_ally_left() {
  var_0 = maps\_utility::spawn_targetname("initial_edge_ally_left", 1);
  var_0.animname = "generic";
  var_0.no_edge_death = 1;
  var_1 = getnode("initial_edge_ally_left_node", "script_noteworthy");
  level.ally_edge_nodes = common_scripts\utility::array_remove(level.ally_edge_nodes, var_1);
  var_0 thread ally_left_death(var_1);
  common_scripts\utility::flag_wait("defend_zodiac_wave_01");
  var_0 thread ally_edge_think(var_1);
  common_scripts\utility::waitframe();

  foreach(var_3 in level.zodiac_allies) {
    if(isDefined(var_3.mynode) && var_3.mynode == var_1) {
      var_3 notify("stop_edge_think");
      var_3 thread ally_node_logic();
      break;
    }
  }

  var_0 endon("death");
  common_scripts\utility::flag_wait("defend_zodiac_arrived_right");
  wait 25;
  var_0 ally_edge_death();
}

ally_left_death(var_0) {
  self waittill("death");
  level.ally_edge_nodes = common_scripts\utility::array_add(level.ally_edge_nodes, var_0);
}

zodiac_initial_attack() {
  thread lookdown_zodiacs();
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_00b");
  maps\_utility::delaythread(0.66, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_01b");
  maps\_utility::delaythread(1.2, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_02b");
  maps\_utility::delaythread(1.5, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_03b");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_vista_00b");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_vista_01b");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_vista_02b");
  maps\_utility::delaythread(2, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_vista_03b");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_initial_driveby_01");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_initial_driveby_02");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_initial_driveby_03");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_10");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_11");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_12");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_13");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_14");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_15");
  thread maps\carrier_code_zodiac::spawn_fake_zodiacs("defend_zodiac_fake_initial_01", 25);
}

lookdown_zodiacs() {
  common_scripts\utility::flag_wait("lookdown_zodiacs");
  var_0 = maps\_utility::getvehiclespawnerarray("defend_zodiac_05");

  if(common_scripts\utility::flag("inhibit_lookdown_zodiacs")) {
    return;
  }
  foreach(var_2 in var_0) {
    if(player_can_see(var_2)) {
      return;
    }
  }

  var_4 = maps\carrier_code_zodiac::spawn_zodiacs("defend_zodiac_05");
}

player_can_see(var_0) {
  if(sighttracepassed(level.player getEye(), var_0.origin, 0, level.player)) {
    return 1;
  }

  return 0;
}

initial_rpgs() {
  var_0 = common_scripts\utility::getstruct("dz_initial_rpg_01", "targetname");
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 5000;
  magicbullet("panzerfaust3_cheap", var_0.origin, var_1);
  wait 1;
  var_0 = common_scripts\utility::getstruct("dz_initial_rpg_02", "targetname");
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 5000;
  magicbullet("panzerfaust3_cheap", var_0.origin, var_1);
}

initial_climb_over() {
  level.start_climbover maps\_utility::show_entity();
  var_0 = maps\_utility::spawn_targetname("pushover_ally", 1);
  var_0 thread maps\_utility::magic_bullet_shield(1);
  common_scripts\utility::flag_wait("start_climbover");
  var_1 = climb_over("climbover_03", undefined, 0, 1);
  var_2 = climb_over("climbover_04", 2, 100);
  var_1.allowdeath = 0;
  var_0.push_enemy = var_1;
  var_0 ally_push();
  var_0 thread maps\_anim::anim_generic_loop(var_0, "carrier_rappel_defend_ally_lean_shoot_long");
  wait 4;
  var_0 notify("stop_loop");

  if(isalive(var_0)) {
    if(isDefined(var_0.magic_bullet_shield)) {
      var_0 maps\_utility::stop_magic_bullet_shield();
    }

    var_0 ally_edge_death();
  }
}

climb_over(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_4 = common_scripts\utility::getstruct(var_0 + "_rappel", "targetname");
  var_5 = maps\carrier_code_zodiac::setup_rope(var_4);
  var_5 thread maps\carrier_code_zodiac::shoot_rope(var_4, 1);
  var_6 = var_1 + 2;
  var_5 thread maps\_utility::notify_delay("rappel_done", var_6);
  var_7 = getent(var_0, "targetname");
  var_8 = maps\_utility::spawn_targetname(var_0, 1);
  var_8.spawner = var_7;
  var_8.dropweapon = 0;
  var_8.nodrop = 1;
  var_8.grenadeammo = 0;
  var_8.allowdeath = 1;
  var_8.ignoreme = 1;
  var_8.ref_node = var_4;
  var_8 thread maps\carrier_code_zodiac::rappel_exit(var_4, var_1, var_2, var_3);

  if(isai(var_8)) {
    var_8 maps\_utility::delaythread(var_1 + randomfloatrange(2, 3), maps\_utility::set_ignoreme, 0);
  }

  return var_8;
}

zodiac_main_wave() {
  maps\_utility::delaythread(5, maps\carrier_code::spawn_gunboat, "defend_gunboat_21", 1);
  maps\_utility::delaythread(5, maps\carrier_code::spawn_gunboat, "defend_gunboat_22");
  maps\_utility::delaythread(7, common_scripts\utility::flag_set, "gunboats_01");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_20", 0, 1, "using_depth_charge");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_21", 0, 1, "using_depth_charge");
  maps\_utility::delaythread(5, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_20", 0, 1, "using_depth_charge");
  maps\_utility::delaythread(5, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_21", 0, 1, "using_depth_charge");
  maps\_utility::delaythread(5, maps\carrier_code_zodiac::spawn_fake_zodiacs, "defend_zodiac_fake_01", 25);
}

zodiac_osprey_wave() {
  if(level.zodiacs.size < level.max_zodiacs - 4) {
    maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_20");
    maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_21");
  }

  maps\_utility::delaythread(0, maps\carrier_code::spawn_gunboat, "defend_gunboat_turn_01");
  maps\_utility::delaythread(0, maps\carrier_code::spawn_gunboat, "defend_gunboat_turn_02");
  maps\_utility::delaythread(0, maps\carrier_code::spawn_gunboat, "defend_gunboat_turn_03");
  maps\_utility::delaythread(2, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_turn_01");
  maps\_utility::delaythread(2, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_turn_02");
  maps\_utility::delaythread(2, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_turn_03");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_21", undefined, undefined, undefined, 1);
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_osprey_10", undefined, undefined, undefined, 1);
  maps\_utility::delaythread(2, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_osprey_20");
  maps\_utility::delaythread(2, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_osprey_21");
}

zodiac_main_wave_2() {
  maps\_utility::array_delete(get_zodiacs("defend_zodiac_20"));
  maps\_utility::array_delete(get_zodiacs("defend_zodiac_21"));
  maps\_utility::array_delete(get_gunboats("defend_gunboat_turn_01"));
  maps\_utility::array_delete(get_gunboats("defend_gunboat_turn_02"));
  maps\_utility::array_delete(get_gunboats("defend_gunboat_turn_03"));
  maps\_utility::delaythread(5, maps\carrier_code::spawn_gunboat, "defend_gunboat_21", 1);
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_30", 0, 0, "using_depth_charge", 1);
  maps\_utility::delaythread(3, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_20", 0, 1, "using_depth_charge");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_21", 0, 1, "using_depth_charge");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_20", 0, 1, "using_depth_charge");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_21", 0, 1, "using_depth_charge");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_fake_zodiacs, "defend_zodiac_fake_01", 25);
  common_scripts\utility::waitframe();
  level.player notify("teleport_zodiacs");
}

get_zodiacs(var_0) {
  var_1 = [];

  foreach(var_3 in level.zodiacs) {
    if(isDefined(var_3.saved_targetname) && var_3.saved_targetname == var_0) {
      var_1 = common_scripts\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

get_gunboats(var_0) {
  var_1 = [];

  foreach(var_3 in level.gunboats) {
    if(isDefined(var_3.saved_targetname) && var_3.saved_targetname == var_0) {
      var_1 = common_scripts\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

zodiac_osprey_2_wave() {
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_21", undefined, undefined, undefined, 1);
  maps\_utility::delaythread(4, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_osprey_20");
  maps\_utility::delaythread(4, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_osprey_21");
  maps\_utility::delaythread(4, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_osprey_22");
  maps\_utility::delaythread(0, maps\carrier_code::spawn_gunboat, "defend_gunboat_turn_02");
  maps\_utility::delaythread(0, maps\carrier_code::spawn_gunboat, "defend_gunboat_turn_03");
  maps\_utility::delaythread(2, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_turn_01");
  maps\_utility::delaythread(2, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_turn_03");
}

zodiac_turn_wave() {
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_30");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_31");
  maps\_utility::delaythread(3, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_filler_32");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_20");
  maps\_utility::delaythread(0, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_21");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_vista_00b");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_vista_01b");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_vista_02b");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiac_rappel, "defend_zodiac_vista_03b");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_initial_driveby_01");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_initial_driveby_02");
  maps\_utility::delaythread(1, maps\carrier_code_zodiac::spawn_zodiacs, "defend_zodiac_initial_driveby_03");
}

osprey_intermission() {
  common_scripts\utility::flag_set("osprey_intermission");
  var_0 = common_scripts\utility::getstruct("osprey_intermission_lookat", "targetname").origin;
  var_1 = vectortoangles(var_0 - level.player.origin);
  var_1 = maps\_utility::set_x(var_1, 0);
  level.player setplayerangles(var_1);
  var_2 = getent("inhibit_intermission_climbover", "targetname");
  var_3 = getaicount("all");

  if(var_3 < 20 && !level.player istouching(var_2)) {
    thread intermission_climbover();
  }
  else {}
}

intermission_climbover() {
  clear_ally_drones("osprey_intermission_drones");
  var_0 = maps\_utility::spawn_targetname("intermission_enemy_catwalk_01", 1);
  var_0.accuracy = var_0.accuracy / 10;
  var_1 = maps\_utility::spawn_targetname("intermission_pushover_ally", 1);
  var_1 thread maps\_utility::magic_bullet_shield(1);
  var_2 = climb_over("intermission_climbover_01", 1);

  if(isDefined(var_2)) {
    level.dz_intermission_enemies = common_scripts\utility::array_add(level.dz_intermission_enemies, var_2);
    var_2.accuracy = var_2.accuracy / 10;
  }

  var_3 = climb_over("intermission_climbover_02", undefined, 0, 1);
  level.dz_intermission_enemies = common_scripts\utility::array_add(level.dz_intermission_enemies, var_3);

  if(isDefined(var_3)) {
    level.dz_intermission_enemies = common_scripts\utility::array_add(level.dz_intermission_enemies, var_3);
    var_1.push_enemy = var_3;
    var_1 ally_push();
  }

  if(isalive(var_1)) {
    var_1 maps\_utility::stop_magic_bullet_shield();
  }

  wait 1;

  if(isalive(var_1)) {
    var_1 kill();
  }
}

cleanup_intermission_enemies() {
  foreach(var_1 in level.dz_intermission_enemies) {
    if(isalive(var_1)) {
      var_1 kill();
    }
  }
}

clear_ally_drones(var_0) {
  var_1 = getEntArray("osprey_intermission_drones", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isspawner(var_3)) {
      var_3 maps\_utility::delaythread(0, maps\carrier_code::inhibit_respawn, 1);
      var_3 maps\_utility::delaythread(10, maps\carrier_code::inhibit_respawn, 0);
      continue;
    }

    var_3 delete();
  }
}

defend_zodiac_waittill_enemies_remaining(var_0, var_1) {
  var_2 = gettime();

  while(gettime() < var_2 + var_1 * 1000) {
    var_3 = get_all_enemies();
    var_4 = 0;

    foreach(var_6 in var_3) {
      if(isDefined(var_6) && isalive(var_6) && !maps\carrier_code::eval(var_6.dead)) {
        var_4++;

        if(var_4 > var_0) {
          break;
        }
      }
    }

    if(var_4 <= var_0) {
      return;
    }
    wait 1;
  }
}

get_all_enemies() {
  var_0 = getaiarray("bad_guys");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "enemy_defend_zodiac") {
      var_1 = common_scripts\utility::array_add(var_1, var_3);
    }
  }

  var_5 = level.drones["axis"].array;
  var_6 = [];

  foreach(var_8 in var_5) {
    if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == "enemy_defend_zodiac") {
      var_6 = common_scripts\utility::array_add(var_6, var_8);
    }
  }

  return common_scripts\utility::array_combine(var_1, var_6);
}

run_helis() {
  common_scripts\utility::flag_wait("defend_zodiac_osprey_pre_finished");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("dz_heli_01");

  foreach(var_2 in var_0.riders) {
    if(isalive(var_2)) {
      var_2.accuracy = var_2.accuracy / 2;
    }
  }

  var_0 thread update_heli_crash_location();
  var_0 maps\_vehicle::godon();
  wait 1;
  var_0 maps\_vehicle::godoff();
  level.player waittill("using_depth_charge");

  if(isalive(var_0)) {
    var_0 delete();
  }
}

update_heli_crash_location() {
  self endon("death");
  var_0 = common_scripts\utility::getstructarray("dz_heli_01_crash_location", "targetname");

  for(;;) {
    self.perferred_crash_location = common_scripts\utility::getclosest(self.origin, var_0);
    wait 0.1;
  }
}

run_vignettes() {
  thread run_intro();
}

run_intro() {
  thread deck_explode();
  thread heli_flyover();
  common_scripts\utility::flag_wait("defend_zodiac_wave_01");
  thread intro_migs();
  thread deck_explode_vista();
}

intro_migs() {
  maps\_utility::array_spawn_function_targetname("dz_intro_jet_01", maps\carrier_vista::jet_phalanx_spawn_function, "tracking_start", "tracking_end");
  getent("dz_intro_jet_01", "targetname") maps\carrier_code::waittill_player_not_looking(1);
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("dz_intro_jet_01");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("dz_intro_jet_02");
  maps\carrier_code::phalanx_gun_fire_target("crr_phalanx_01", var_0, "tracking_start", "tracking_end", (0, 0, 0), "tag_body");
}

deck_explode() {
  thread deck_explode_guys();
  common_scripts\utility::flag_wait("defend_zodiac_wave_01");
  thread maps\carrier_audio::aud_carr_zodiac_deck_explode();
  wait 2.5;
  common_scripts\utility::flag_set("dz_deck_explode");
  var_0 = common_scripts\utility::getstruct("dz_intro_deck_explode", "targetname");
  playFX(common_scripts\utility::getfx("vfx_missile_death_deck"), var_0.origin);
  radiusdamage(var_0.origin, var_0.radius, 300, 90, undefined, "MOD_EXPLOSIVE");
  physicsexplosionsphere(var_0.origin, var_0.radius * 2, var_0.radius, 100);
  screenshake(var_0.origin, 3, 2, 2, 0.8, 0, 0.8, 2000, 4, 6, 5);
  level.player playrumbleonentity("heavy_1s");
  common_scripts\utility::array_thread(level.dz_deck_explode_dmg, maps\carrier_code::show_and_raise_entity);
  common_scripts\utility::array_thread(getEntArray("barrel_impact_2", "targetname"), maps\_utility::hide_entity);
  common_scripts\utility::array_thread(getEntArray("odin_phys_objects_2", "targetname"), maps\_utility::hide_entity);
  getent("dz_deck_explode_weapon", "script_noteworthy") delete();
}

deck_explode_guys() {
  var_0 = maps\_utility::array_spawn_targetname("dz_deck_explode_guy");
  common_scripts\utility::flag_wait("defend_zodiac_wave_01");
  wait 1;

  foreach(var_2 in var_0) {
    var_2 maps\_utility::set_goalradius(4);
    var_2 setgoalpos(common_scripts\utility::getstruct(var_2.target, "targetname").origin);
  }
}

deck_explode_vista() {
  common_scripts\utility::flag_wait("defend_zodiac_arrived_catwalk");
  var_0 = common_scripts\utility::getstruct("dz_intro_deck_explode_vista", "targetname");
  playFX(common_scripts\utility::getfx("vfx_missile_death_deck"), var_0.origin);
  thread maps\carrier_audio::aud_carr_zodiac_deck_explode_vista();
  radiusdamage(var_0.origin, var_0.radius, 300, 90, undefined, "MOD_EXPLOSIVE");
  physicsexplosionsphere(var_0.origin, var_0.radius * 2, var_0.radius, 100);
  screenshake(var_0.origin, 3, 2, 2, 0.8, 0, 0.8, 2000, 4, 6, 5);
}

heli_flyover() {
  var_0 = common_scripts\utility::getstruct("hesh_defend_run_1", "targetname");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1 maps\_utility::waittill_player_lookat(0.5, 0, 1);
  var_1 delete();
  var_2 = [];
  var_2[var_2.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("dz_intro_heli_01");
  var_2[var_2.size] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("dz_intro_heli_02");
  wait 5;
  thread maps\_utility::ai_delete_when_out_of_sight(var_2, 5000);
}

run_jet_takeoff() {
  thread maps\carrier_audio::aud_zodiac_jet_catapult_01();
  maps\carrier_code::carrier_life_jet_takeoff_jet("anim_jet_launcher1", "jet_launcher1", "jet_takeoff1_exit", 6, 8);
  level.player waittill("using_depth_charge");

  if(isDefined(level.old_player_origin)) {
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.origin = level.old_player_origin;
    var_1 = getent("nearby_jet2", "targetname");

    if(!var_0 istouching(var_1)) {
      common_scripts\utility::flag_wait("defend_zodiac_osprey_turn");
      thread maps\carrier_audio::aud_zodiac_jet_catapult_02();
      maps\carrier_code::carrier_life_jet_takeoff_jet("anim_jet_launcher2", "jet_launcher2", "jet_takeoff2_exit", 7);
    }

    var_0 delete();
  }
}

run_allies(var_0) {
  if(maps\carrier_code::eval(var_0)) {
    spawn_checkpoint_only_allies();
  }
  else {
    var_1 = getEntArray("defend_zodiac_ally", "targetname");
    maps\_utility::array_delete(var_1);
  }

  level.respawn_spawner_org = common_scripts\utility::getstruct("defend_zodiac_allies_respawn_struct", "targetname").origin;
  common_scripts\utility::flag_clear("respawn_friendlies");
  maps\_utility::activate_trigger_with_targetname("defend_zodiac_allies_move");
  level.friendly_startup_thread = ::ally_think;

  if(!maps\carrier_code::eval(var_0)) {
    var_2 = common_scripts\utility::array_combine(maps\_utility::get_force_color_guys("allies", "r"), maps\_utility::get_force_color_guys("allies", "o"));
    common_scripts\utility::array_thread(var_2, ::ally_think);

    if(var_2.size < 5) {
      for(var_3 = var_2.size; var_3 < 4; var_3++) {
        thread defend_zodiac_spawn_reinforcement();
      }
    }
  }

  common_scripts\utility::flag_wait("defend_zodiac_wave_01");
  common_scripts\utility::array_thread(getEntArray("defend_zodiac_ally_drone_wave_01", "targetname"), maps\carrier_code::drone_respawner, "defend_zodiac_finished", 20, 30, 1, 3);
}

initial_drone_allies() {
  var_0 = maps\_utility::spawn_targetname("defend_zodiac_ally_drone_initial", 0);

  if(isDefined(var_0)) {
    var_0.noragdoll = undefined;
    var_0 thread maps\carrier_code::randomly_kill_drone();
  }

  common_scripts\utility::flag_wait("defend_zodiac_wave_01");
  var_1 = getent("defend_zodiac_ally_drone_initial_02", "targetname");

  if(!maps\_utility::either_player_looking_at(var_1.origin)) {
    var_0 = maps\_utility::spawn_targetname("defend_zodiac_ally_drone_initial_02", 0);

    if(isDefined(var_0)) {
      var_0.noragdoll = undefined;
      var_0 thread maps\carrier_code::randomly_kill_drone();
    }
  }
}

spawn_checkpoint_only_allies() {
  maps\_utility::array_spawn_function_targetname("defend_zodiac_ally", ::ally_think);
  var_0 = maps\carrier_code::array_spawn_targetname_allow_fail("defend_zodiac_ally", 1);
  var_1 = getEntArray("defend_zodiac_ally", "targetname");
  maps\_utility::array_delete(var_1);
}

ally_think() {
  self endon("death");
  thread ally_cleanup();
  thread defend_zodiac_replace_on_death();
  maps\_utility::disable_ai_color();
  self.animname = "generic";
  self.script_accuracy = 0.1;
  self.health = self.health * 3;
  self.maxsightdistsqrd = 144000000;
  self.goalradius = 8;
  self.downaimlimit = -90;

  if(!isDefined(level.zodiac_allies)) {
    level.zodiac_allies = [];
  }

  level.zodiac_allies = common_scripts\utility::array_add(level.zodiac_allies, self);
  thread traversal_hack();
  wait 0.1;
  ally_node_logic();
}

ally_node_logic() {
  var_0 = get_free_edge_node();

  if(isDefined(var_0)) {
    self.mynode = var_0;
    thread ally_edge_think(var_0);
  } else {
    for(var_0 = get_free_shoot_node(); !isDefined(var_0); var_0 = get_free_shoot_node()) {
      wait 1;
    }

    self.mynode = var_0;
    thread ally_shoot_think(var_0);
  }
}

get_free_edge_node() {
  foreach(var_1 in level.ally_edge_nodes) {
    if(!isDefined(var_1.reserved) || !var_1.reserved) {
      return var_1;
    }
  }

  return undefined;
}

get_free_shoot_node() {
  foreach(var_1 in level.ally_shoot_nodes) {
    if(!isDefined(var_1.reserved) || !var_1.reserved) {
      return var_1;
    }
  }

  return undefined;
}

reserve_node(var_0) {
  var_0 endon("freed");
  var_0.reserved = 1;
  self waittill("death");
  free_node(var_0);
}

free_node(var_0) {
  var_0.reserved = 0;
  var_0 notify("freed");
}

ally_shoot_think(var_0, var_1) {
  self endon("death");
  level endon("defend_zodiac_finished");
  thread reserve_node(var_0);
  self setgoalnode(var_0);
  self waittill("goal");
  maps\_utility::set_ignoreall(0);

  for(;;) {
    thread shoot_at_fake_target();
    wait(randomfloatrange(2, 4));

    if(maps\carrier_code::eval(var_1) && should_lean()) {
      free_node(var_0);
      self notify("stop_shoot");
      thread ally_edge_think(var_0);
      return;
    }
  }
}

shoot_at_fake_target() {
  self endon("death");
  self endon("stop_shoot");
  level endon("defend_zodiac_finished");

  if(maps\carrier_code::eval(self.isreloading) || maps\carrier_code::eval(self.a.exposedreloading)) {
    return;
  }
  self.noreload = 1;
  var_0 = level.zodiac_ally_shoot_targets[randomint(level.zodiac_ally_shoot_targets.size)];
  var_1 = randomintrange(6, 12);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self shoot(0.5, var_0.origin, 1);
    wait 0.1;
  }

  self.noreload = undefined;
}

ally_edge_think(var_0) {
  self endon("death");
  level endon("defend_zodiac_finished");
  self endon("stop_edge_think");
  thread reserve_node(var_0);
  maps\_utility::set_ignoreall(0);

  for(;;) {
    if(should_lean()) {
      lean_anim(var_0, 1);
    }
    else {
      thread ally_shoot_think(var_0, 1);
      return;
    }

    wait(randomfloatrange(0.5, 2));
  }
}

run_ally_edge_death() {
  self endon("death");
  wait(randomfloatrange(2, 3));

  if(self.leaning && randomint(100) > 80 && !maps\carrier_code::eval(self.no_edge_death)) {
    thread ally_edge_death();
  }
}

ally_edge_death() {
  self.ignoreme = 1;
  self setlookattext("", &"");
  self setCanDamage(0);
  self.a.nodeath = 1;
  self notify("stop_loop");
  self notify("stop_lean");
  self notify("stop_edge_think");
  thread maps\carrier_code_zodiac::splash_on_hit_water_ragdoll();
  maps\_anim::anim_single_solo(self, "carrier_rappel_defend_ally_lean_death");
  self kill();
}

lean_anim(var_0, var_1) {
  self endon("death");
  self endon("stop_lean");
  var_2 = var_0;
  self.goal_node = var_2;

  if(!maps\carrier_code::eval(var_1)) {
    var_2 maps\_anim::anim_generic_reach(self, "carrier_rappel_defend_ally_lean_enter");
  }

  var_2 maps\_anim::anim_generic(self, "carrier_rappel_defend_ally_lean_enter");
  self.leaning = 1;
  self notify("start_lean");
  var_3 = 25;

  while(should_lean()) {
    if(self != level.hesh) {
      thread run_ally_edge_death();
    }

    self notify("stop_loop");
    thread maps\_anim::anim_generic_loop(self, "carrier_rappel_defend_ally_lean_shoot_long", "stop_loop");
    wait(randomfloatrange(4, 6));
    self notify("stop_loop");

    if(randomint(100) < var_3) {
      maps\_anim::anim_generic(self, "carrier_rappel_defend_ally_lean_wave");
      continue;
    }

    thread maps\_anim::anim_generic_loop(self, "carrier_rappel_defend_ally_lean_idle", "stop_loop");
    wait(randomfloatrange(0.5, 2));
  }

  stop_lean();
}

stop_lean() {
  self notify("stop_loop");
  maps\_anim::anim_generic(self, "carrier_rappel_defend_ally_lean_exit");
  self.leaning = 0;
  self notify("stop_lean");
}

should_lean() {
  var_0 = 600;
  var_1 = 0;
  var_2 = getEntArray("enemy_defend_zodiac", "script_noteworthy");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isspawner(var_5) && isalive(var_5)) {
      var_3[var_3.size] = var_5;
    }
  }

  foreach(var_8 in var_3) {
    var_9 = var_8 gettagorigin("j_head");
    var_10 = distance2dsquared(self.origin, var_9);
    var_11 = maps\_utility::players_within_distance(64, self.origin);

    if(var_10 <= var_0 * var_0 && !var_11) {
      return 1;
    }
  }

  return 0;
}

ally_cleanup() {
  common_scripts\utility::flag_wait("defend_zodiac_finished");

  if(isDefined(self)) {
    thread disable_defend_zodiac_replace_on_death();
  }

  common_scripts\utility::flag_wait("defend_zodiac_ally_cleanup");

  if(isDefined(self)) {
    self kill();
  }
}

ally_drone_cleanup() {
  level endon("defend_zodiac_finished");

  for(;;) {
    if(level.dead_ally_drones.size > 6) {
      while(level.dead_ally_drones.size > 6) {
        if(isDefined(level.dead_ally_drones[0])) {
          level.dead_ally_drones[0] delete();
        }

        level.dead_ally_drones = maps\_utility::array_remove_index(level.dead_ally_drones, 0);
      }
    }

    wait 5;
  }
}

ally_push() {
  if(!isalive(self)) {
    return;
  }
  self.push_enemy endon("death");
  self.animname = "generic";
  self.push_enemy stopanimscripted();
  self.push_enemy unlink();
  self.push_enemy.ref_node thread maps\_anim::anim_generic(self.push_enemy, "carrier_rappel_defend_ally_push_victim");
  self.push_enemy thread kill_push_enemy();
  var_0 = spawnStruct();
  var_0.origin = self.push_enemy.ref_node.origin - (0, 0, 3);
  var_0.angles = self.push_enemy.ref_node.angles;
  var_0 maps\_anim::anim_generic(self, "carrier_rappel_defend_ally_push");
}

kill_push_enemy() {
  maps\carrier_code_zodiac::splash_on_hit_water_ragdoll();
  wait 1;

  if(isDefined(self)) {
    self delete();
  }
}

defend_zodiac_replace_on_death() {
  self endon("disable_defend_zodiac_replace_on_death");

  if(isDefined(self.defend_zodiac_replace_on_death)) {
    return;
  }
  self.defend_zodiac_replace_on_death = 1;
  self waittill("death");
  level.zodiac_allies = maps\_utility::array_removedead(level.zodiac_allies);
  defend_zodiac_spawn_reinforcement();
}

defend_zodiac_spawn_reinforcement() {
  var_0 = defend_zodiac_spawn_hidden_reinforcement();

  if(isDefined(level.friendly_startup_thread)) {
    var_0 thread[[level.friendly_startup_thread]]();
  }
}

defend_zodiac_spawn_hidden_reinforcement() {
  var_0 = undefined;

  for(;;) {
    if(!maps\_colors::respawn_friendlies_without_vision_check()) {
      if(!isDefined(level.friendly_respawn_vision_checker_thread)) {
        thread maps\_colors::friendly_spawner_vision_checker();
      }

      for(;;) {
        maps\_colors::wait_until_vision_check_satisfied_or_disabled();
        common_scripts\utility::flag_waitopen("friendly_spawner_locked");

        if(common_scripts\utility::flag("player_looks_away_from_spawner") || maps\_colors::respawn_friendlies_without_vision_check()) {
          break;
        }
      }

      common_scripts\utility::flag_set("friendly_spawner_locked");
    }

    var_1 = level.defend_zodiac_ally_respawner;
    var_1.count = 1;
    var_2 = var_1.origin;
    var_0 = var_1 stalingradspawn();
    var_1.origin = var_2;

    if(maps\_utility::spawn_failed(var_0)) {
      thread maps\_colors::lock_spawner_for_awhile();
      wait 1;
      continue;
    }

    level notify("reinforcement_spawned", var_0);
    break;
  }

  thread maps\_colors::lock_spawner_for_awhile();
  return var_0;
}

disable_defend_zodiac_replace_on_death() {
  self.defend_zodiac_replace_on_death = undefined;
  self notify("disable_defend_zodiac_replace_on_death");
}

get_closest_ally() {
  if(isDefined(level.zodiac_allies) && level.zodiac_allies.size > 0) {
    level.zodiac_allies = sortbydistance(level.zodiac_allies, level.player.origin);
    return level.zodiac_allies[0];
  }

  return undefined;
}

#using_animtree("generic_human");

traversal_hack() {
  self endon("death");

  for(;;) {
    if(isDefined(self.traverseanim) && self.traverseanim == % traverse_jumpdown_56) {
      wait 1.2;
      self notify("killanimscript");
      return;
    }

    common_scripts\utility::waitframe();
  }
}

run_osprey_nag_first_time_vo() {
  level endon("defend_zodiac_finished");
  level.player endon("using_depth_charge");

  if(maps\carrier_code::eval(level.player.using_depth_charge)) {
    return;
  }
  wait 3;
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_adamcallinthe");
  wait 2;
  thread run_osprey_nag_vo();
}

run_osprey_nag_vo() {
  level endon("defend_zodiac_finished");
  level.player endon("using_depth_charge");

  if(maps\carrier_code::eval(level.player.using_depth_charge)) {
    return;
  }
  wait(randomfloatrange(3, 4));
  var_0 = ["carrier_hsh_usetheospreyto", "carrier_hsh_adamcallinthe"];
  var_1 = 0;

  for(;;) {
    level.hesh maps\_utility::smart_dialogue(var_0[var_1]);
    var_1++;

    if(var_1 >= var_0.size) {
      var_1 = 0;
    }

    wait(randomfloatrange(8, 12));
  }
}

run_osprey_start_vo() {
  level.player waittill("start_using_depth_charge");
  maps\_utility::smart_radio_dialogue("carrier_hp2_titanthreeonestartingour");
  maps\_utility::smart_radio_dialogue("carrier_com_copythreeone");
  maps\_utility::smart_radio_dialogue("carrier_hp2_titanthreeoneinboundlets");
}

run_osprey_start_2_vo() {
  level.player waittill("start_using_depth_charge");
  maps\_utility::smart_radio_dialogue("carrier_hp2_beginningourrun");
  maps\_utility::smart_radio_dialogue("carrier_com_understoodthreeone");
  maps\_utility::smart_radio_dialogue("carrier_hp2_titanthreeonecomingin");
}

run_osprey_hit_vo() {
  level.player endon("depth_charge_exit");
  level endon("pre_gunship_attack_vo");
  level.player waittill("using_depth_charge");
  var_0 = 0;

  for(;;) {
    var_1 = level.osprey_hit_zodiacs + level.osprey_hit_gunboats + level.osprey_hit_fake_targets;

    if(var_1 >= 7 && gettime() > var_0 + 5000) {
      wait 1;
      maps\_utility::smart_radio_dialogue("carrier_com_8plushitsnice");
      var_0 = gettime();
    } else if(var_1 >= 2) {
      var_2 = ["carrier_com_multiplehitstitanthreeone", "carrier_ttn_multipleboatsconfirmedhit", "carrier_hsh_goodhits", "carrier_hsh_multiplehits"];

      if(level.osprey_hit_zodiacs > 0) {
        var_2 = common_scripts\utility::array_add(var_2, "carrier_ttn_zodiacsdown");
      }

      wait 1;
      maps\_utility::smart_radio_dialogue(var_2[randomint(var_2.size)]);
      wait 2;
    }

    level.osprey_hit_zodiacs = 0;
    level.osprey_hit_gunboats = 0;
    level.osprey_hit_fake_targets = 0;
    wait 3;
  }
}

run_osprey_finish_vo() {
  level.player waittill("depth_charge_exit");
  wait 0.5;

  if(level.zodiac_allies.size == 0) {
    return;
  }
  level.zodiac_allies = sortbydistance(level.zodiac_allies, level.player.origin);
  level.zodiac_allies[0] thread maps\_utility::smart_dialogue("carrier_us6_hellyeah");
}

run_enemy_destroyer() {
  level.player waittill("using_depth_charge");
  level.fake_targets = common_scripts\utility::array_removeundefined(level.fake_targets);
  level.fed_destroyer_osprey.rig setanimtime(level.scr_anim["boat"]["carrier_destroyer_idle"][0], 0);
  thread run_enemy_destroyer_gun();
  var_0 = common_scripts\utility::getstructarray("destroyer_target_big", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = var_2.origin;
    var_3.angles = var_2.angles;
    var_3.script_noteworthy = "big";
    var_3 thread maps\carrier_code::setup_target_on_vehicle();
    level.destroyer_targets_big = common_scripts\utility::array_add(level.destroyer_targets_big, var_3);
    level.fake_targets = common_scripts\utility::array_add(level.fake_targets, var_3);
  }

  var_5 = maps\_vehicle::spawn_vehicle_from_targetname("osprey_heli_01");
  var_5 thread maps\carrier_code::setup_target_on_vehicle();
  level.fake_targets = common_scripts\utility::array_add(level.fake_targets, var_5);
  maps\_utility::delaythread(5, maps\_vehicle::gopath, var_5);
  maps\_utility::array_spawn_function_targetname("osprey_destroyer_guys", ::enemy_destroyer_guy_logic);
  level.fed_destroyer_guys = maps\_utility::array_spawn_targetname("osprey_destroyer_guys");
  level.player waittill("depth_charge_exit");
  thread cleanup_enemy_destroyer();
}

run_enemy_destroyer_2() {
  thread run_enemy_destroyer_gun();
  maps\_utility::array_spawn_function_targetname("osprey_destroyer_guys", ::enemy_destroyer_guy_logic);
  level.fed_destroyer_guys = maps\_utility::array_spawn_targetname("osprey_destroyer_guys");

  foreach(var_1 in level.fed_destroyer_guys) {
    if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "first_run_only") {
      var_1 delete();
    }
  }

  level.player waittill("depth_charge_exit");
  thread cleanup_enemy_destroyer();
}

run_enemy_destroyer_gun() {
  level.player endon("depth_charge_exit");
  level endon("stop_fed_destroyer_guns");

  while(!common_scripts\utility::flag("destroyed_fed_destroyer_guns")) {
    level.fed_destroyer_osprey.gun rotatetolinked((0, 0, 0), 5, 2, 2);
    wait 5;
    level.fed_destroyer_osprey.gun rotatetolinked((0, 30, 0), 5, 2, 2);
    wait 5;
  }
}

cleanup_enemy_destroyer() {
  foreach(var_1 in level.destroyer_targets_big) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }

  foreach(var_4 in level.fed_destroyer_guys) {
    if(isDefined(var_4)) {
      var_4 delete();
    }
  }
}

enemy_destroyer_guy_logic() {
  self endon("death");
  level.fake_targets = common_scripts\utility::array_removeundefined(level.fake_targets);
  level.fake_targets = common_scripts\utility::array_add(level.fake_targets, self);
  thread maps\carrier_code::setup_target_on_vehicle();
  self.drone_run_speed = 140;

  if(isDefined(self.script_moveoverride)) {
    self linkto(level.fed_destroyer_osprey);
    wait(self.script_moveoverride);
    self notify("move");
    self unlink();
  }

  self waittill("goal");
  self linkto(level.fed_destroyer_osprey);
}

pre_gunship_attack_vo() {
  common_scripts\utility::flag_set("pre_gunship_attack_vo");
  maps\_utility::smart_radio_dialogue("carrier_com_allsquadsbeadvised");
  maps\_utility::smart_radio_dialogue("carrier_us6_gunshipaboveus");
  maps\_utility::smart_radio_dialogue("carrier_us6_yankee11fedgunship");
}

osprey2_gunship_attack() {
  var_0 = common_scripts\utility::getstruct("osprey2_gunship_attack_pos", "targetname");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  wait 5.5;
  maps\_utility::delaythread(4.5, maps\carrier_code::gunship_line_attack_fake, "osprey2_gunship_attack_25_01", var_0.origin);
  var_2 = common_scripts\utility::getstruct("osprey2_gunship_attack_105_01", "targetname");
  thread maps\carrier_code::ac130_magic_105_fake(var_0.origin, var_2.origin);
  thread maps\carrier_audio::aud_zodiac_gunship_attack_105_fake(var_2);
  wait 1;
  var_2 = common_scripts\utility::getstruct("osprey2_gunship_attack_105_02", "targetname");
  thread maps\carrier_code::ac130_magic_105_fake(var_0.origin, var_2.origin);
  thread maps\carrier_audio::aud_zodiac_gunship_attack_105_fake(var_2);
  wait 0.5;
  var_2 = common_scripts\utility::getstruct("osprey2_gunship_attack_105_03", "targetname");
  thread maps\carrier_code::ac130_magic_bullet_fake("40mm", var_0.origin, var_2.origin);
  var_1 maps\_utility::play_sound_on_entity("ac130_40mm_fire_npc");
  thread maps\carrier_audio::aud_zodiac_gunship_attack_105_fake(var_2);
  wait 1;
  var_2 = common_scripts\utility::getstruct("osprey2_gunship_attack_105_04", "targetname");
  thread maps\carrier_code::ac130_magic_105_fake(var_0.origin, var_2.origin);
  thread maps\carrier_audio::aud_zodiac_gunship_attack_105_fake(var_2);
  wait 2;
  var_2 = common_scripts\utility::getstruct("osprey2_gunship_attack_105_deck", "targetname");
  thread maps\carrier_code::ac130_magic_bullet_fake("40mm", var_0.origin, var_2.origin);
  var_1 maps\_utility::play_sound_on_entity("ac130_40mm_fire_npc");
  thread maps\carrier_audio::aud_zodiac_gunship_attack_105_fake(var_2);
  wait 1;
  var_2 = common_scripts\utility::getstruct("osprey2_gunship_attack_105_05", "targetname");
  thread maps\carrier_code::ac130_magic_bullet_fake("40mm", var_0.origin, var_2.origin);
  var_1 maps\_utility::play_sound_on_entity("ac130_40mm_fire_npc");
  thread maps\carrier_audio::aud_zodiac_gunship_attack_105_fake(var_2);
  wait 1;
  var_1 delete();
}

gunship_attack() {
  if(isDefined(level.player_ignored_2nd_osprey)) {
    var_0 = getent("enemy_ac130", "targetname");
    var_0 maps\carrier_code::waittill_player_not_looking(1);
  }

  maps\_utility::delaythread(0, maps\carrier_audio::aud_zodiac_to_sparrow_zone);
  common_scripts\utility::flag_set("defend_zodiac_finished");
  common_scripts\utility::array_thread(level.gunship_trans_triggers, maps\_utility::show_entity);

  if(!isDefined(level.player_ignored_2nd_osprey)) {
    teleport_player_post_osprey();
    thread gunship_damage();
    var_1 = getent("gunship_transition_turn_player_vol", "targetname");

    if(level.player istouching(var_1)) {
      var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");
      level.player setplayerangles(var_2.angles);
    }
  }

  var_3 = getdvar("ai_friendlyFireBlockDuration");
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  thread player_handle_speed_for_knockdown();
  thread allies_gunship_run();
  thread hesh_gunship_run();
  var_4 = common_scripts\utility::getstruct("gunship_105_01", "targetname");

  if(level.player.origin[1] < var_4.origin[1]) {
    var_5 = common_scripts\utility::spawn_tag_origin();
    var_5.origin = var_4.origin;
    var_5 maps\_utility::waittill_player_lookat(0.8, 0.1, 1, 5);
    var_5 delete();
  }

  level.player thread gunship_death();
  thread gunship_attacking();
  waittill_knockdown_moment();
  common_scripts\utility::flag_set("start_knockdown_moment");
  setsaveddvar("ai_friendlyFireBlockDuration", var_3);
  thread cleanup_boats();

  if(isDefined(level.defend_zodiac_osprey)) {
    level.defend_zodiac_osprey delete();
  }
}

waittill_knockdown_moment() {
  common_scripts\utility::flag_wait("trigger_knockdown_moment");
  common_scripts\utility::flag_wait_or_timeout("hesh_close_to_knockdown", 5);
}

gunship_damage() {
  common_scripts\utility::array_thread(level.deck_ac130_dmg, maps\carrier_code::show_and_raise_entity);
  common_scripts\utility::array_thread(level.deck_ac130_dmg_clip, maps\_utility::show_entity);
  var_0 = common_scripts\utility::getstructarray("deck_ac130_dmg_badplace", "targetname");

  foreach(var_3, var_2 in var_0) {
  badplace_cylinder("deck_ac130_dmg_badplace" + var_3, -1, var_2.origin, var_2.radius, 100, "allies");
  }

  level.deck_ac130_dmg_badplace_size = var_0.size;
  common_scripts\utility::array_thread(level.elevator_ac130_dmg, maps\carrier_code::show_and_raise_entity);
  common_scripts\utility::array_thread(getEntArray("barrel_impact", "targetname"), maps\_utility::hide_entity);
  common_scripts\utility::array_thread(getEntArray("barrel_impact_2", "targetname"), maps\_utility::hide_entity);
  common_scripts\utility::array_thread(getEntArray("odin_phys_objects", "targetname"), maps\_utility::hide_entity);
  common_scripts\utility::array_thread(getEntArray("odin_phys_objects_2", "targetname"), maps\_utility::hide_entity);
  common_scripts\utility::array_thread(getEntArray("odin_impact_objects_2", "targetname"), maps\_utility::hide_entity);
  var_4 = getscriptablearray("scriptable_destructible_barrel", "targetname");

  foreach(var_6 in var_4) {
  var_6 delete();
  }

  var_8 = getEntArray("deck_combat_weapons", "targetname");
  maps\_utility::array_delete(var_8);
}

teleport_player_post_osprey() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = level.player.origin;
  var_1 = getent("player_near_knockdown_vol", "targetname");

  if(var_0 istouching(var_1)) {
    level.player.near_knockdown = 1;
    maps\_utility::teleport_player(common_scripts\utility::getstruct("player_near_knockdown_teleport", "targetname"));
    var_0 delete();
    return;
  }

  var_2 = getEntArray("gunship_attack_player_teleport_vol", "targetname");

  foreach(var_1 in var_2) {
    if(var_0 istouching(var_1)) {
      var_4 = common_scripts\utility::getstructarray("gunship_attack_player_teleport_node", "targetname");
      var_4 = sortbydistance(var_4, level.player.origin);
      maps\_utility::teleport_player(var_4[0]);
      break;
    }
  }

  var_0 delete();
}

allies_gunship_run() {
  var_0 = getent("gunship_trans_ally_runto_elevator_vol", "targetname");

  foreach(var_2 in level.zodiac_allies) {
    if(isalive(var_2)) {
      var_2 thread single_ally_run(var_0);
    }
  }
}

single_ally_run(var_0) {
  self endon("death");
  self notify("stop_edge_think");

  if(maps\carrier_code::eval(self.leaning)) {
    stop_lean();
  }

  maps\_utility::enable_sprint();
  self setgoalpos(self.origin);
  self setgoalvolumeauto(var_0);

  while(!self istouching(var_0)) {
    common_scripts\utility::waitframe();
  }

  thread maps\carrier_code::run_to_volume_and_delete("gunship_trans_ally_runto_vol");
}

hesh_gunship_run() {
  level endon("knockdown_moment");
  level.hesh notify("stop_edge_think");
  var_0 = common_scripts\utility::getstruct("sparrow_run_hesh_start_idle", "targetname");

  if(!isDefined(level.player_ignored_2nd_osprey)) {
    var_1 = teleport_hesh_post_osprey();
    level.hesh notify("stop_loop");
    level.hesh stopanimscripted();

    if(maps\carrier_code::eval(level.player.near_knockdown)) {
      level.hesh forceteleport(var_0.origin, var_0.angles);
      level.hesh thread maps\_utility::smart_dialogue("carrier_hsh_wevegottoget_3");
    } else if(level.player.origin[2] > 1380) {
      var_1 thread maps\_anim::anim_single_solo(level.hesh, "carrier_rappel_defend_hesh_dialog");
      maps\_utility::delaythread(0.05, maps\_anim::anim_set_time, [level.hesh], "carrier_rappel_defend_hesh_dialog", 0.25 / getanimlength(level.scr_anim["hesh"]["carrier_rappel_defend_hesh_dialog"]));
    } else
      var_1 thread maps\_anim::anim_single_solo(level.hesh, "carrier_rappel_defend_hesh_dialog");
  } else {
    if(maps\carrier_code::eval(level.hesh.leaning)) {
      level.hesh stop_lean();
    }
    else {
      wait 2;
    }

    level.hesh thread maps\_utility::smart_dialogue("carrier_hsh_wevegottoget_3");
  }

  level.hesh disable_flinch();
  level.hesh maps\_utility::enable_sprint();

  if(!maps\carrier_code::eval(level.player.near_knockdown)) {
    wait 2;
  }
  else {
    wait 0.1;
  }

  common_scripts\utility::flag_set("gunship_attacking");
  common_scripts\utility::flag_set("obj_defend_carrier_complete");
  thread maps\carrier::obj_sparrow();
  var_2 = common_scripts\utility::getstruct("sparrow_run_animnode", "targetname");
  thread hesh_close_to_knockdown(var_0);
  var_0 maps\_anim::anim_reach_solo(level.hesh, "sparrow_start_idle");
  level.hesh enable_flinch();
  level.hesh maps\_utility::disable_sprint();
  thread hesh_gunship_nag_vo();
  var_0 maps\_anim::anim_loop_solo(level.hesh, "sparrow_start_idle");
}

hesh_close_to_knockdown(var_0) {
  while(distance2d(level.hesh.origin, var_0.origin) > 80) {
    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("hesh_close_to_knockdown");
}

hesh_gunship_nag_vo() {
  level endon("knockdown_moment");
  wait 3;

  for(;;) {
    maps\_utility::smart_radio_dialogue("carrier_hsh_comeonadam");
    wait 6;
    maps\_utility::smart_radio_dialogue("carrier_hsh_loganthisway");
    wait 7;
  }
}

player_handle_speed_for_knockdown() {
  level.player endon("death");
  level.hesh endon("death");
  level endon("knockdown_moment");
  thread reset_player_speed();
  var_0 = common_scripts\utility::getstruct("sparrow_run_animnode", "targetname");

  for(;;) {
    if(level.player.origin[1] > level.hesh.origin[1] && level.player.origin[1] < var_0.origin[1] + 200) {
      thread maps\_utility::blend_movespeedscale_percent(75, 0.5);
      wait 0.5;
      continue;
    }

    thread maps\_utility::blend_movespeedscale_percent(100, 0.5);
    wait 0.5;
  }
}

reset_player_speed() {
  common_scripts\utility::flag_wait("knockdown_moment");
  maps\_utility::blend_movespeedscale_percent(100, 0.5);
}

teleport_hesh_post_osprey() {
  if(level.player.origin[2] > 1380) {
    var_0 = common_scripts\utility::getstructarray("hesh_post_osprey_teleport_deck", "targetname");
  }
  else {
    var_0 = common_scripts\utility::getstructarray("hesh_post_osprey_teleport", "targetname");
  }

  var_0 = sortbydistance(var_0, level.player.origin + (0, 550, 0));
  var_1 = var_0[0];
  level.hesh forceteleport(maps\_utility::set_z(var_1.origin, 1344), var_1.angles);
  return var_1;
}

gunship_attacking() {
  common_scripts\utility::flag_wait("gunship_attacking");
  thread gunship_trans_1();
  thread gunship_trans_2();
  thread gunship_trans_3();
  thread gunship_trans_4();
  thread gunship_trans_loop();
  thread gunship_trans_death_warning();
  thread elevator_105();
  level.ac_130 maps\_utility::delaythread(0, maps\carrier_code::ac130_magic_bullet, "40mm", common_scripts\utility::getstruct("gunship_105_01", "targetname").origin);
  level.ac_130 maps\_utility::play_sound_on_entity("ac130_40mm_fire_npc");
  thread maps\carrier_audio::aud_gunship_incoming_zodiac();
  maps\_utility::delaythread(2, maps\carrier_code::phalanx_gun_offline, "crr_phalanx_01");
  maps\_utility::delaythread(3, ::launch_props, "gunship_trans_impact_objects_01");
  thread maps\carrier_audio::aud_zodiac_gunship_attack_barrels();
}

gunship_trans_1() {
  level endon("gunship_trans_2");
  level endon("gunship_trans_3");
  level endon("gunship_trans_4");
  common_scripts\utility::flag_wait("gunship_trans_1");
  maps\_utility::delaythread(0, maps\carrier_code::gunship_line_attack, "gunship_25_01");
}

gunship_trans_2() {
  level endon("gunship_trans_3");
  level endon("gunship_trans_4");
  common_scripts\utility::flag_wait("gunship_trans_2");
  maps\_utility::delaythread(0, maps\carrier_code::gunship_line_attack, "gunship_25_02");
  level.ac_130 maps\_utility::delaythread(0, maps\carrier_code::ac130_magic_bullet, "40mm", common_scripts\utility::getstruct("gunship_105_02", "targetname").origin);
  level.ac_130 maps\_utility::play_sound_on_entity("ac130_40mm_fire_npc");
  thread maps\carrier_audio::aud_gunship_incoming_zodiac();
  maps\_utility::delaythread(1, ::launch_props, "gunship_trans_impact_objects_02");
}

gunship_trans_3() {
  level endon("gunship_trans_4");
  common_scripts\utility::flag_wait("gunship_trans_3");
  maps\_utility::delaythread(0, maps\carrier_code::gunship_line_attack, "gunship_25_03");
  level.ac_130 maps\_utility::delaythread(0, maps\carrier_code::ac130_magic_bullet, "40mm", common_scripts\utility::getstruct("gunship_105_03", "targetname").origin);
  level.ac_130 maps\_utility::play_sound_on_entity("ac130_40mm_fire_npc");
  thread maps\carrier_audio::aud_gunship_incoming_zodiac();
}

gunship_trans_4() {
  common_scripts\utility::flag_wait("gunship_trans_4");
  maps\_utility::delaythread(0, maps\carrier_code::gunship_line_attack, "gunship_25_04");
  var_0 = common_scripts\utility::getstruct("sparrow_trans_105_pre_start", "targetname");
  var_1 = common_scripts\utility::getstruct("sparrow_trans_105_pre_01", "targetname");
  level.ac_130 maps\_utility::delaythread(0, maps\carrier_code::ac130_magic_105_fake, var_0.origin, var_1.origin);
  thread maps\carrier_audio::aud_gunship_incoming_zodiac();
  thread maps\carrier_audio::aud_gunship_trans_4_105_01();
  var_2 = common_scripts\utility::getstruct("sparrow_trans_105_pre_02", "targetname");
  level.ac_130 maps\_utility::delaythread(0.6, maps\carrier_code::ac130_magic_105_fake, var_0.origin, var_2.origin);
  thread maps\carrier_audio::aud_gunship_incoming_zodiac();
  thread maps\carrier_audio::aud_gunship_trans_4_105_02();
  level.ac_130 maps\_utility::delaythread(0, maps\carrier_code::ac130_magic_bullet, "40mm", common_scripts\utility::getstruct("gunship_105_04", "targetname").origin);
  level.ac_130 maps\_utility::play_sound_on_entity("ac130_40mm_fire_npc");
  thread maps\carrier_audio::aud_gunship_incoming_zodiac();
}

gunship_trans_loop() {
  level endon("knockdown_moment");
  common_scripts\utility::flag_wait("gunship_trans_4");

  for(;;) {
    maps\carrier_code::gunship_line_attack("gunship_25_loop");
    wait(randomfloatrange(0.5, 2));
  }
}

gunship_trans_death_warning() {
  level endon("knockdown_moment");
  level.player endon("death");

  for(;;) {
    common_scripts\utility::flag_wait("gunship_trans_death_warning");

    while(common_scripts\utility::flag("gunship_trans_death_warning")) {
      maps\carrier_code::gunship_line_attack("gunship_25_death_warning", 3);
      wait(randomfloatrange(0.5, 1));
    }
  }
}

launch_props(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_4 = spawn("script_model", var_3.origin);
    var_4 setModel(var_4.model);
    var_5 = (randomfloatrange(3000, 5000), common_scripts\utility::ter_op(common_scripts\utility::cointoss(), randomfloatrange(3000, 6000), randomfloatrange(-6000, -3000)), randomfloatrange(3000, 5000));
    var_4 physicslaunchclient(var_3.origin + (0, 0, 32), var_5);
    wait(randomfloatrange(0.05, 0.25));
  }
}

cleanup_boats() {
  common_scripts\utility::flag_wait("player_knocked_down");
  maps\carrier_code::ai_cleanup_fake_death("enemy_defend_zodiac");
  maps\carrier_code::ai_cleanup_fake_death("enemy_defend_zodiac_vista");
  maps\carrier_code::ai_cleanup_fake_death("enemy_defend_zodiac_filler");
  thread maps\carrier_code::kill_remaining_gunboats();
}

elevator_105(var_0) {
  var_1 = elevator_105_guys(var_0);
  common_scripts\utility::flag_wait("knockdown_moment");
  wait 1;
  var_1 = maps\_utility::array_removedead(var_1);
  common_scripts\utility::array_thread(var_1, maps\_utility::stop_magic_bullet_shield);
  var_2 = common_scripts\utility::getstruct("dz_elevator_explode", "targetname");
  radiusdamage(var_2.origin, var_2.radius, 300, 90, undefined, "MOD_EXPLOSIVE");
  physicsexplosionsphere(var_2.origin, var_2.radius * 2, var_2.radius, 100);
  common_scripts\utility::waitframe();

  foreach(var_4 in var_1) {
    if(isalive(var_4)) {
      var_4 kill();
    }
  }
}

elevator_105_guys(var_0) {
  var_1 = maps\_utility::array_spawn_targetname("dz_elevator_explode_guy");

  foreach(var_3 in var_1) {
  var_3 maps\_utility::magic_bullet_shield(1);
  }

  return var_1;
}

elevator_lean_over(var_0) {
  self endon("death");
  self.allowdeath = 0;
  self.dropweapon = 0;
  self.nodrop = 1;
  self.grenadeammo = 0;
  var_1 = common_scripts\utility::getstruct(self.target, "targetname");

  if(!maps\carrier_code::eval(var_0)) {
    var_1 maps\_anim::anim_generic_reach(self, "carrier_rappel_defend_ally_lean_enter");
  }

  var_1 maps\_anim::anim_generic(self, "carrier_rappel_defend_ally_lean_enter");

  for(;;) {
    thread maps\_anim::anim_generic_loop(self, "carrier_rappel_defend_ally_lean_shoot_long");
    wait(randomfloatrange(1, 5));
    self notify("stop_loop");
    thread maps\_anim::anim_generic_loop(self, "carrier_rappel_defend_ally_lean_idle");
    wait(randomfloatrange(1, 5));
    self notify("stop_loop");
  }
}

gunship_death() {
  level endon("knockdown_moment");
  self endon("death");
  var_0 = getEntArray("gunship_trans_kill", "targetname");
  var_1 = 0;
  wait 10;

  for(;;) {
    foreach(var_3 in var_0) {
      if(self istouching(var_3)) {
        level.ac_130 maps\_utility::delaythread(0, maps\carrier_code::ac130_magic_bullet, "40mm", level.player.origin + anglesToForward(level.player getplayerangles()) * 400);
        level.ac_130 maps\_utility::play_sound_on_entity("ac130_40mm_fire_npc");
        maps\carrier_code::gunship_line_attack_death();
        wait 1;

        if(isalive(self) && self istouching(var_3)) {
          setdvar("ui_deadquote", &"CARRIER_DEATH_GUNSHIP");
          maps\_utility::missionfailedwrapper();
          self kill();
        }
      }
    }

    if(var_1 >= 30.0) {
      maps\carrier_code::gunship_line_attack_death();
      wait 1;
      setdvar("ui_deadquote", &"CARRIER_DEATH_GUNSHIP");
      maps\_utility::missionfailedwrapper();
      self kill();
    }

    wait 0.05;
    var_1 = var_1 + 0.05;
  }
}

lower_blastshield(var_0) {
  var_1 = getent("blastshield", "targetname");
  var_2 = getent("blastshield_clip", "targetname");
  var_2 linkto(var_1);
  var_3 = common_scripts\utility::getstruct(var_1.target, "targetname");

  if(maps\carrier_code::eval(var_0)) {
    var_1 moveto(var_3.origin, 0.1);
    var_1 rotateto(var_3.angles, 0.1);
    wait 5;
    var_2 connectpaths();
  } else {
    var_1 moveto(var_3.origin, 5, 2, 2);
    var_1 rotateto(var_3.angles, 5, 2, 2);
    wait 5;
    var_2 connectpaths();
  }
}

spawner_cleanup() {
  common_scripts\utility::waitframe();
  var_0 = getEntArray("enemy_defend_zodiac_vista", "script_noteworthy");
  var_1 = getEntArray("enemy_defend_zodiac", "script_noteworthy");
  var_2 = vehicle_getspawnerarray();

  foreach(var_4 in var_2) {
    if(isDefined(var_4.targetname) && (issubstr(var_4.targetname, "defend_zodiac") || issubstr(var_4.targetname, "defend_gunboat"))) {
      var_4 delete();
    }
  }

  foreach(var_7 in var_0) {
    if(isDefined(var_7) && isspawner(var_7)) {
      var_7 delete();
    }
  }

  foreach(var_7 in var_1) {
    if(isDefined(var_7) && isspawner(var_7)) {
      var_7 delete();
    }
  }
}

defend_zodiac_autosave(var_0, var_1) {
  if(common_scripts\utility::flag("dz_warning_right") || common_scripts\utility::flag("dz_warning_front") || common_scripts\utility::flag("dz_warning_rear")) {
    return;
  }
  if(maps\carrier_code::eval(var_0)) {
    maps\_utility::autosave_now_silent();
  }
  else {
    maps\_utility::autosave_now();
  }

  if(maps\carrier_code::eval(var_1)) {
    level.player enabledeathshield(1);
    wait 5;
    level.player enabledeathshield(0);
  }
}

kill_trigger_setup() {
  var_0 = getEntArray("dz_kill_triggers", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, maps\_utility::show_entity);
  var_1 = getent("dz_kill_vol_right", "targetname");
  var_2 = getent("dz_kill_vol_front", "targetname");
  var_3 = getent("dz_kill_vol_rear", "targetname");
  var_4 = [var_1, var_2, var_3];
  thread kill_trigger(var_4, "dz_warning_right", "dz_warning_front", "dz_warning_rear");
  common_scripts\utility::flag_wait("knockdown_moment");
  common_scripts\utility::array_thread(var_0, maps\_utility::hide_entity);
}

kill_trigger(var_0, var_1, var_2, var_3) {
  level endon("knockdown_moment");

  for(;;) {
    common_scripts\utility::flag_wait_any(var_1, var_2, var_3);
    level.player thread maps\carrier_depth_charge::depth_charge_remove_control();
    maps\_utility::smart_radio_dialogue_interrupt("carrier_hsh_regrouponme");

    if(level.player is_touching_any(var_0)) {
      wait 1.5;
      maps\_utility::smart_radio_dialogue_interrupt("carrier_hsh_moveyourasslogan");

      if(level.player is_touching_any(var_0)) {
        wait 1.5;
        maps\_utility::smart_radio_dialogue_interrupt("carrier_hsh_logangetoverhere");

        if(level.player is_touching_any(var_0)) {
          wait 1;
          setdvar("ui_deadquote", &"CARRIER_FAIL_FAR_AWAY");
          maps\_utility::missionfailedwrapper();
        }
      }
    }

    if(common_scripts\utility::flag("defend_osprey_online") && !maps\carrier_code::eval(level.player.osprey_control)) {
      level.player thread maps\carrier_depth_charge::depth_charge_give_control();
    }

    common_scripts\utility::flag_clear(var_1);
    common_scripts\utility::flag_clear(var_2);
    common_scripts\utility::flag_clear(var_3);
    wait 0.05;
  }
}

is_touching_any(var_0) {
  foreach(var_2 in var_0) {
    if(self istouching(var_2)) {
      return 1;
    }
  }

  return 0;
}