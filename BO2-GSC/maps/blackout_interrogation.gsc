/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_interrogation.gsc
*******************************************/

#include common_scripts\utility;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_objectives;
#include maps\_scene;
#include maps\_utility;
#include maps\_music;
#include maps\createart\blackout_art;
#include maps\blackout_util;
#include maps\blackout_anim;
#include maps\_audio;
#include maps\_fxanim;
#include maps\_turret;
#include maps\_rusher;

skipto_mason_start() {
  skipto_teleport_players("player_skipto_mason_interrogation_room");
  spawn_interrogation_heroes();
}

skipto_mason_interrogation_room() {
  spawn_interrogation_heroes();
  maps\blackout_anim::mason_intro_animations();
  skipto_teleport_players("player_skipto_mason_interrogation_room");
  run_scene_first_frame("intro_setup_chair");
  level thread run_scene_and_delete("intro_table");
  level thread intro_setup_player();
  level thread notetrack_player_leaves_monitor();
  place_player_loadout();
  flag_set("intro_cctv_done");
}

skipto_mason_wakeup() {
  maps\blackout_anim::mason_intro_animations();
  skipto_teleport_players("player_skipto_mason_wakeup");
  level.salazar = init_hero("salazar");
  screen_fade_out(0.01);
  level thread taser_knuckles_pickup();
  level thread intro_setup_player();
  place_player_loadout();
}

skipto_mason_hallway() {
  maps\blackout_anim::scene_wakeup();
  skipto_teleport_players("player_skipto_mason_interrogation_room");
  level.salazar = init_hero_startstruct("salazar", "salazar_hallway_start");
}

run_mason_start() {
  maps\blackout_anim::mason_intro_animations();
  run_scene_first_frame("intro_nag_loop");
  run_scene_first_frame("intro_cctv");
  run_scene_first_frame("intro_setup_chair");
  run_scene_first_frame("intro_guard_2");
  level.player allowpickupweapons(0);
  level clientnotify("intr_on");
  setmusicstate("BLACKOUT_INTRO");
  level thread intro_setup_player();
  level thread run_scene_and_delete("intro_player_loop");
  level thread run_scene_and_delete("intro_table");
  level thread interrogation_camera();
  level thread interrogation_handcuffs();
  place_player_loadout();
  wait_network_frame();
  e_streamer_hint = createstreamerhint((280, -133, 34), 1.0);
  turn_on_intro_cam();

  if(isDefined(is_mature()) && !is_mature()) {
    a_m_blood = getentarray("intro_blood", "targetname");
    array_delete(a_m_blood);
  }

  flag_wait("starting final intro screen fadeout");
  clientnotify("snd_commotion");
  level.player playsound("sce_cctv_intro");
  level.player clientnotify("intro_cctv_started");
  level thread interrogation_menendez_bleed();
  level thread set_force_no_cull_on_actors_during_scene("intro_cctv", "enter_interrogation_room_started");
  level thread set_force_no_cull_on_actors_during_scene("intro_table", "enter_interrogation_room_started");
  run_scene_and_delete("intro_cctv");
  playsoundatposition("sce_metal_door", (343, 22, 80));
  e_streamer_hint delete();
  clean_up_mason_start();
}

clean_up_mason_start() {
  a_to_delete = array("menendez_plane_pip_org", "security_intro_camera");
  level thread clean_up_ent_array(a_to_delete);
}

run_mason_interrogation_room() {
  level thread taser_knuckles_pickup();
  vision_set_interrogation();
  level.m_original_exposure = getdvarfloat(#"r_exposureValue");
  delay_thread(3, ::set_objective, level.obj_interrogate, get_struct("interrogate_menendez_objective_struct", "targetname"), "breadcrumb");
  trigger_wait("interrogation_room_trig");
  level thread maps\_audio::switch_music_wait("BLACKOUT_INTERROGATION", 6.5);
  set_objective(level.obj_interrogate, undefined);
  turn_off_intro_cam();
  end_scene("intro_guard_2");
  exploder(102);
  run_scene_and_delete("enter_interrogation_room");
  stop_exploder(102);
  run_scene_and_delete("enter_interrogation_room_part_2");
  level thread mason_interrogation_streamer_hint();
  run_scene_and_delete("enter_interrogation_room_part_3");
  clientnotify("snd_argument");
  set_objective(level.obj_interrogate, undefined, "done", undefined, 0);
  scene_interrogation();
  clientnotify("argument_done");
  level.salazar custom_ai_weapon_loadout("hk416_sp", undefined, "fiveseven_sp");
  setdvar("r_exposureTweak", 0);
  stop_exploder(439);
  delete_exploder(439);
  clean_up_mason_interrogation_room();
}

mason_interrogation_streamer_hint() {
  wait 0.1;
  m_player_body = get_model_or_models_from_scene("enter_interrogation_room_part_3", "player_body");
  e_streamer_hint = createstreamerhint(m_player_body.origin, 1);
  e_streamer_hint linkto(m_player_body);
  scene_wait("enter_interrogation_room_part_3");
  e_streamer_hint delete();
}

clean_up_mason_interrogation_room() {
  a_to_delete = array("intro_screen");
  level thread clean_up_ent_array(a_to_delete);
}

intercom_dialog() {
  wait 1.5;
  level.player say_dialog("pa_all_hands_all_hand_1");
  wait 1.0;
  level.player say_dialog("pa_shoot_on_sight_0");
  level.player say_dialog("pa_repeat_shoot_on_si_1");
}

run_mason_wakeup() {
  flag_set("distant_explosions_on");
  emergency_light_init();
  setup_swinging_light();
  set_light_flicker_fx_area(70100);
  load_gump("blackout_gump_mason_before");
  level thread run_scene_and_delete("wakeup_table");
  level notify("mason_wakeup");
  level.player shellshock("death", 11.5);
  run_scene_first_frame("sal_door_open", 1);
  s_player_pos = getstruct("player_skipto_mason_wakeup", "targetname");
  level thread add_posed_corpses("wakeup_deadguys", "sal_door_open_done");
  run_scene_first_frame("player_wakes_up_in_interrogation_room");
  level.player stop_magic_bullet_shield();
  level thread intercom_dialog();
  level clientnotify("knc_off");
  screen_fade_in(4);
  level clientnotify("knc_on");
  level clientnotify("knc_on_snd");
  screen_fade_out(1);
  wait 3.0;
  run_scene_first_frame("salazar_wakes_player_up_and_walks_to_armory");
  level clientnotify("knc_off");
  level thread screen_fade_in(2);

  if(isDefined(level.sndknockedoutent) && isDefined(level.sndknockedoutent2)) {
    level.sndknockedoutent delete();
    level.sndknockedoutent2 delete();
  }

  level thread dialog_wakeup();
  level thread run_scene_and_delete("player_wakes_up_in_interrogation_room");
  wait 1.0;
  level thread wakeup_sequence_salazar();
  level thread maps\_audio::switch_music_wait("BLACKOUT_POST_INTERROGATION", 1);
  autosave_by_name("mason_combat_start");
  s_armory = getstruct("player_equipment_objective", "targetname");
  level.player waitill_armed();
  scene_wait("salazar_walks_to_hallway_door");
  trigger_wait("hallway_door_trigger");
  setmusicstate("BLACKOUT_BRIDGE_FIGHT");
  clean_up_mason_wakeup();
}

setup_swinging_light() {
  m_light = get_ent("fxanim_mason_wakeup_light", "targetname");
  playfxontag(level._effect["fx_lf_commandcenter_light4"], m_light, "tag_fx");
}

clean_up_mason_wakeup() {
  cleanup_structs("player_equipment_objective", "targetname");
  delete_emergency_light("intro_light");
  maps\_fxanim::fxanim_delete("mason_wakeup_light");
  cleanup_ents("loadout_spot", "script_noteworthy");
  cleanup_ents("armory_weapon", "targetname");
  a_to_delete = array("player_primary_loadout_spot", "player_secondary_loadout_spot", "knuckle_crate", "interrogation_door_upper", "interrogation_door_lower");
  level thread clean_up_ent_array(a_to_delete);
}

dialog_wakeup() {
  level endon("dialog_wakeup_kill");

  if(level.is_harper_alive) {
  } else {
  }

  wait 4.5;
  level.player say_dialog("maso_what_1");

  if(level.is_harper_alive) {
    level.player say_dialog("harp_pmcs_used_glider_win_0");
    level.player say_dialog("harp_they_used_stealth_te_0");
    level.player say_dialog("harp_they_re_tearing_the_0");
  } else {
    level.player say_dialog("brig_pmcs_launched_a_jet_0");
    level.player say_dialog("brig_they_use_stealth_tec_0");
  }

  flag_wait("salazar_waits_to_enter_hallway_started");
  level.player queue_dialog("sect_right_now_we_have_to_0");
}

wakeup_sequence_salazar() {
  run_scene_and_delete("salazar_wakes_player_up_and_walks_to_armory");
  run_scene_and_delete("salazar_walks_to_hallway_door");
  run_scene_and_delete("salazar_waits_to_enter_hallway");
}

dialog_hallway_breach() {
  level notify("dialog_wakeup_kill");
  level.salazar say_dialog("sala_ready_1", 2.5);
  level.player say_dialog("sect_go_4");
}

objective_hallway_breadcrumb() {
  t_objective = get_ent("hallway_breadcrumb_trigger", "targetname");
  set_objective(level.obj_restore_control, t_objective, "breadcrumb");
  t_objective waittill("trigger");
  set_objective(level.obj_restore_control, undefined);
}

run_mason_hallway() {
  init_doors();
  maps\blackout_anim::scene_hallway_devestation();
  add_trigger_function(get_ent("obs_hallway_color_back", "targetname"), ::flag_set, "obs_hallway_color_back_hit");
  level notify("mason_hallway_started");
  set_objective(level.obj_pickup_weapons, undefined, "delete");
  level thread objective_hallway_breadcrumb();
  flag_set("distant_explosions_on");
  run_scene_first_frame("salazar_exit", 1);
  run_scene_first_frame("stairfall", 1);
  add_spawn_function_veh("observation_hallway_turret", ::hallway_turret_think);
  emergency_light_activate("intro_hallway_light");
  level thread scene_hallway();
  level thread scene_sal_open_door();
  level thread autosave_now("observation_hallway_start");
  spawn_manager_enable("sm_friendly_hallway");
  level.salazar.ignoreall = 0;
  level.salazar.ignoreme = 0;
  level.salazar.ignoresuppression = 1;
  level.salazar disable_pain();
  level.salazar disable_react();
  level.salazar change_movemode("cqb_run");
  trigger_use("observation_start_enemies");
  trigger_use("observation_start_colors_trig");
  level thread dialog_intro_hallway();
  level thread run_mason_hallway_friendly();
  delay_thread(10, ::hallway_front_rush);
  trigger_wait("observation_hallway_done_trigger");
  level thread weaken_ai_group("intro_hallway_guys");
  level thread weaken_ai_group("obs_hallway_group_back");
  level thread weaken_ai_group("obs_hallway_group_front");
  delay_thread(randomfloatrange(1.0, 2.0), ::sal_exit_explosion);
  spawn_manager_kill("sm_friendly_hallway");
  add_flag_function("hallway_cleared", ::autosave_by_name, "observation_hallway_complete");
  flag_clear("distant_explosions_on");
  clean_up_mason_hallway();
}

clean_up_mason_hallway() {
  level thread kill_spawnernum(1);
}

dialog_intro_hallway() {
  flag_wait("sal_door_open_done");
  level.salazar queue_dialog("sala_come_on_0");
  queue_dialog_ally("nav0_turret_s_firing_on_u_0");
  queue_dialog_ally("nav1_he_s_hit_get_him_c_0");

  if(level.is_harper_alive) {
    level.player queue_dialog("harp_section_the_obama_0");
    level.player queue_dialog("sect_where_s_briggs_0");
    level.player queue_dialog("harp_the_server_room_lo_0");
  } else {
    level.player queue_dialog("brig_section_our_automat_0");
    level.player queue_dialog("sect_where_are_you_admir_0");
    level.player queue_dialog("brig_below_decks_in_the_s_0");
  }

  level thread dialog_intro_hallway_combat();
}

dialog_intro_hallway_combat() {
  ai_hallway_surgeon = get_ent("observation_hallway_surgery02_ai", "targetname");
  ai_hallway_surgeon thread queue_dialog("nav0_it_s_gonna_be_okay_0", 0, "hallway_surgery_lookat", "salazar_exit_started", 1, 1);
  level thread set_flag_when_ai_touches_trigger("hallway_stairs_dialog", "intro_hallway_enemy_on_stairs");
  level.salazar thread queue_dialog("sala_more_on_the_stairs_0", 0, "intro_hallway_enemy_on_stairs", "salazar_exit_started", 1, 0);
  level thread set_flag_on_ai_group_clear("hallway_cleared", "intro_hallway_guys", "obs_hallway_group_back");
  level.salazar thread queue_dialog("sala_move_up_0", 1, "hallway_cleared", "salazar_exit_started", 1, 1);
  level thread queue_dialog_enemy("cub3_turret_s_down_0", 0, "observation_turret_killed", "salazar_exit_started", 1);
  a_chatter_conditional_friendly = [];
  a_chatter_generic_friendly = [];
  a_chatter_conditional_friendly[a_chatter_conditional_friendly.size] = "nav3_destroy_that_fucking_0";
  a_chatter_generic_friendly[a_chatter_generic_friendly.size] = "nav2_stay_in_cover_0";
  a_chatter_generic_friendly[a_chatter_generic_friendly.size] = "nav3_give_em_covering_fi_0";
  a_chatter_generic_friendly[a_chatter_generic_friendly.size] = "nav0_right_behind_you_0";
  level thread start_combat_vo_group_friendly(a_chatter_generic_friendly, "hallway_cleared", a_chatter_conditional_friendly, "observation_turret_killed");
  a_chatter_conditional_enemy = [];
  a_chatter_generic_enemy = [];
  a_chatter_generic_enemy[a_chatter_generic_enemy.size] = "cub1_there_s_only_a_few_o_0";
  a_chatter_generic_enemy[a_chatter_generic_enemy.size] = "cub0_maintain_fire_0";
  a_chatter_generic_enemy[a_chatter_generic_enemy.size] = "cub2_move_in_0";
  a_chatter_conditional_enemy[a_chatter_conditional_enemy.size] = "cub0_the_turret_has_them_0";
  level thread start_combat_vo_group_enemy(a_chatter_generic_enemy, "salazar_exit_started", a_chatter_conditional_enemy, "observation_turret_killed");
}

dialog_intro_hallway_combat_friendly() {
  level endon("salazar_exit_started");
  a_chatter_generic = [];
  a_chatter_conditional = [];
  str_conditional_flag = "observation_turret_killed";
  a_chatter_conditional[a_chatter_conditional.size] = "nav3_destroy_that_fucking_0";
  a_chatter_generic[a_chatter_generic.size] = "nav2_stay_in_cover_0";

  while(a_chatter_generic.size > 0) {
    if(!flag(str_conditional_flag) && a_chatter_conditional.size > 0) {
      str_line = random(a_chatter_conditional);
      arrayremovevalue(a_chatter_conditional, str_line);
    } else {
      str_line = random(a_chatter_generic);
      arrayremovevalue(a_chatter_generic, str_line);
    }

    queue_dialog_ally(str_line, 0, undefined, undefined, 0);
    wait(randomfloatrange(3, 10));
  }

  level thread dialog_intro_hallway_combat_friendly();
}

place_player_loadout() {
  level.str_primary_weapon = getloadoutweapon("primary");
  level.str_secondary_weapon = getloadoutweapon("secondary");
  primarycamoindex = getloadoutitemindex("primarycamo");
  secondarycamoindex = getloadoutitemindex("secondarycamo");
  primaryweaponoptions = level.player calcweaponoptions(primarycamoindex);
  secondaryweaponoptions = level.player calcweaponoptions(secondarycamoindex);
  s_anchor = get_struct("armory_anchor_struct", "targetname");
  place_loadout_item(level.str_primary_weapon, "player_primary_loadout_spot", s_anchor, primaryweaponoptions);
  place_loadout_item(level.str_secondary_weapon, "player_secondary_loadout_spot", s_anchor, secondaryweaponoptions);
  wait_network_frame();
  level.player giveweapon("knife_sp");
}

place_loadout_item(str_weapon, str_origin, s_anchor, weaponoptions) {
  if(!issubstr(str_weapon, "null")) {
    a_weapon_mount = getentarray(str_origin, "targetname");

    for(i = 0; i < a_weapon_mount.size; i++) {
      m_weapon_script_model = spawn("weapon_" + str_weapon, a_weapon_mount[i].origin);
      m_weapon_script_model.angles = a_weapon_mount[i].angles;
      m_weapon_script_model linkto(a_weapon_mount[i]);
      m_weapon_script_model itemweaponsetammo(9999, 9999, 0);
      m_weapon_script_model itemweaponsetammo(9999, 9999, 1);
      m_weapon_script_model itemweaponsetoptions(weaponoptions);
      m_weapon_script_model.targetname = "armory_weapon";
      a_weapon_mount[i] set_loadout_offset(str_weapon, s_anchor, str_origin);
    }
  }
}

set_loadout_offset(str_weapon_full, s_anchor, str_origin) {
  if(!isDefined(s_anchor)) {
    return;
  }
  a_tokens = strtok(str_weapon_full, "_");
  str_weapon = a_tokens[0];

  if(a_tokens.size > 2) {
    for(i = 1; i < a_tokens.size; i++) {
      if(a_tokens[i] != "sp" && !issubstr(a_tokens[i], "+"))
        str_weapon = str_weapon + ("_" + a_tokens[i]);
    }
  }

  if(str_origin == "player_primary_loadout_spot")
    b_left_side = 1;
  else
    b_left_side = 0;

  b_use_offset = 1;

  switch (str_weapon) {
    case "870mcs":
      v_origin = (145.3, 308.5, 316) + vectorscale((0, 0, 1), 15.0);
      v_angles = (270, 0.00000125224, -0.0000112701);
      break;
    case "afghanstinger":
      v_origin = (153.067, 307.417, 341) + vectorscale((-1, 0, 0), 7.0);
      v_angles = (270, 6.8, -0.000000423884);
      break;
    case "ak47":
      v_origin = (145.3, 309, 321) + (4, 0, 10);
      v_angles = (270, 0.00000125224, -0.0000112701);
      break;
    case "ak74u":
      v_origin = (184.8, 307.25, 322) + (-3, 0, 6);
      v_angles = (270, 286.955, -106.955);
      break;
    case "an94":
      v_origin = (145.3, 309, 321) + vectorscale((0, 0, 1), 12.0);
      v_angles = (270, 0.00000125224, -0.0000112701);
      break;
    case "as50":
      v_origin = (184.8, 309, 322) + vectorscale((0, 0, 1), 15.0);
      v_angles = (270, 286.955, -106.955);
      break;
    case "ballista":
      v_origin = (145.3, 309, 321) + (4, 0, 12);
      v_angles = (270, 0.00000125224, -0.0000112701);
      break;
    case "barretm82":
      v_origin = (184.8, 309.25, 322) + (0, -2, 8);
      v_angles = (270, 286.955, -106.955);
      break;
    case "beretta93r":
      v_origin = (153.91, 309.5, 325.987) + vectorscale((-1, 0, 0), 16.0);
      v_angles = (325.1, 0.000000234491, 180);
      break;
    case "browninghp":
      v_origin = (183.996, 309.25, 321.355) + vectorscale((0, 0, 1), 5.0);
      v_angles = (322.6, 180, 180);
      break;
    case "crossbow":
      v_origin = (153, 309.487, 324.41) + (0, -3, 2);
      v_angles = (270, 270, -0.000000683245);
      break;
    case "crossbow80s":
      v_origin = (183.996, 309.25, 321.355) + vectorscale((0, 0, 1), 2.0);
      v_angles = (270, 270, -0.000000683245);
      break;
    case "dragunov":
      v_origin = (154.364, 308.97, 317.91) + (-7, 0, 13);
      v_angles = (270, 7.59997, -0.000000846274);
      break;
    case "dsr50":
      v_origin = (184.882, 308.384, 329.246) + vectorscale((1, 0, 1), 4.0);
      v_angles = (270, 172.4, 0.0000101553);
      break;
    case "evoskorpion":
      v_origin = (154.364, 308.97, 317.91) + (-4, 0, 12);
      v_angles = (270, 7.59997, -0.000000846274);
      break;
    case "exptitus6":
      v_origin = (184.882, 308.384, 329.246) + vectorscale((0, 0, 1), 7.0);
      v_angles = (270, 172.4, 0.0000101553);
      break;
    case "fhj18":
      v_origin = (152.114, 307.97, 339.41) + vectorscale((-1, 0, 0), 8.0);
      v_angles = (270, 7.59997, -0.000000846274);
      break;
    case "fiveseven":
      v_origin = (183.496, 308.616, 325.6) + vectorscale((1, 0, 0), 4.0);
      v_angles = (311.3, 180, 172.4);
      break;
    case "fnfal":
      v_origin = (152.114, 307.97, 339.41) + vectorscale((-1, 0, 0), 4.0);
      v_angles = (270, 7.59997, -0.000000846274);
      break;
    case "fnp45":
      v_origin = (177, 308.62, 332.1);
      v_angles = (311.3, 180, 172.4);
      break;
    case "galil":
      v_origin = (152.114, 307.97, 328.41) + vectorscale((-1, 0, 1), 5.0);
      v_angles = (270, 7.59997, -0.000000846274);
      break;
    case "hamr":
      v_origin = (180.975, 307.884, 328.371) + vectorscale((1, 0, 1), 5.0);
      v_angles = (270, 0.00000250448, 180);
      break;
    case "hk416":
      v_origin = (152.114, 307.97, 328.41) + vectorscale((-1, 0, 1), 5.0);
      v_angles = (270, 7.59997, -0.000000846274);
      break;
    case "insas":
      v_origin = (180.975, 307.884, 328.371) + (5, 0, 6);
      v_angles = (270, 0.00000250448, 180);
      break;
    case "judge":
      v_origin = (160.834, 307.53, 329.558) + vectorscale((-1, 0, 0), 10.0);
      v_angles = (312.4, 0.000000285214, -172.4);
      break;
    case "kard":
      v_origin = (171.243, 307.116, 329.291) + vectorscale((1, 0, 0), 10.0);
      v_angles = (320.4, 180, -180);
      break;
    case "knife_ballistic":
      v_origin = (159.518, 310.289, 317.342) + (-8, -0.5, 5);
      v_angles = (14.065, 9.18945, -177.431);
      break;
    case "knife_ballistic_80s":
      v_origin = (172.859, 309.78, 319.683) + (7, 0.5, 5);
      v_angles = (16.7998, 180.056, -179.8);
      break;
    case "ksg":
      v_origin = (150.658, 309.289, 330.018) + vectorscale((-1, 0, 1), 5.0);
      v_angles = vectorscale((1, 0, 0), 270.0);
      break;
    case "lsat":
      v_origin = (181.683, 308.72, 327.359) + vectorscale((1, 0, 1), 5.0);
      v_angles = (270, 180, -0.00000500896);
      break;
    case "m16":
      v_origin = (150.658, 309.289, 330.018) + vectorscale((-1, 0, 0), 4.0);
      v_angles = vectorscale((1, 0, 0), 270.0);
      break;
    case "m1911":
      v_origin = (172.444, 309.53, 329.31) + vectorscale((1, 0, 0), 6.0);
      v_angles = (322.4, 180, 180);
      break;
    case "m32":
      v_origin = (149.822, 305.711, 330.018) + (0, 0, 0);
      v_angles = (270, 333.6, -0.00000611788);
      break;
    case "m60":
      v_origin = (182.58, 308.153, 327.944) + (4, 0, 6);
      v_angles = (270, 202.4, -0.000176005);
      break;
    case "makarov":
      v_origin = (161.152, 309.539, 334.118) + vectorscale((-1, 0, 0), 12.0);
      v_angles = (314.6, 0.000000746699, -180);
      break;
    case "metalstorm_mms":
      v_origin = (181.944, 309.347, 330.33) + (8, 0, 3);
      v_angles = (270, 206.565, -26.565);
      break;
    case "mgl":
      v_origin = (150.528, 309.045, 320.402) + (-8, 0, 5);
      v_angles = (270, 313.8, -0.0000409926);
      break;
    case "minigun":
      v_origin = (172.806, 304.403, 318.33) + vectorscale((1, 0, 0), 15.0);
      v_angles = (270, 26.565, -26.565);
      break;
    case "minigun80s":
      v_origin = (161.902, 306.468, 318.538) + vectorscale((-1, 0, 1), 15.0);
      v_angles = (270, 180, -0.00000500896);
      break;
    case "mk48":
      v_origin = (151.205, 305.978, 320.402) + vectorscale((0, 0, 1), 15.0);
      v_angles = (270, 336, 0.0000138684);
      break;
    case "mp5k":
      v_origin = (180.444, 309.347, 318.33) + vectorscale((0, 0, 1), 8.0);
      v_angles = (270, 206.565, -26.565);
      break;
    case "mp7":
      v_origin = (151.538, 307.032, 329.902) + (0, -1.5, 6);
      v_angles = (270, 1.19997, 0.000115306);
      break;
    case "pdw57":
      v_origin = (180.444, 309.097, 327.83) + (4, 0, 6);
      v_angles = (270, 206.565, -26.565);
      break;
    case "qbb95":
      v_origin = (180.444, 309.097, 327.83) + (8, 0, 7);
      v_angles = (270, 206.565, -26.565);
      break;
    case "qcw05":
      v_origin = (184.459, 308.935, 323.732) + (-1, 0, 6);
      v_angles = (270, 175.4, 0.0000492077);
      break;
    case "riotshield":
      v_origin = (148.402, 301.032, 327.212) + (0, -3, -14);
      v_angles = (90, 354.045, -5.95453);
      break;
    case "rottweil72":
      v_origin = (187.444, 309.097, 323.33) + (-6, 0, 7);
      v_angles = (270, 206.565, -26.565);
      break;
    case "rpd":
      v_origin = (148.788, 308.869, 322.538) + vectorscale((-1, 0, 1), 6.0);
      v_angles = (270, 339.155, -5.95441);
      break;
    case "rpg_player":
      v_origin = (184.708, 307.65, 341.33) + (4, 0, -8);
      v_angles = (270, 188.965, -26.565);
      break;
    case "sa58":
      v_origin = (150.462, 309.119, 324.038) + (-6, 0, 7);
      v_angles = vectorscale((1, 0, 0), 270.0);
      break;
    case "saiga12":
      v_origin = (186.33, 307.35, 324.458) + (-1, 0, 7);
      v_angles = (270, 180, -0.00000500896);
      break;
    case "saritch":
      v_origin = (150.462, 309.119, 324.038) + vectorscale((0, 0, 1), 8.0);
      v_angles = vectorscale((1, 0, 0), 270.0);
      break;
    case "scar":
      v_origin = (185.33, 307.35, 324.458) + (-1, 0, 8);
      v_angles = (270, 180, -0.00000500896);
      break;
    case "sig556":
      v_origin = (151.212, 309.119, 323.038) + (-1, 0, 10);
      v_angles = vectorscale((1, 0, 0), 270.0);
      break;
    case "smaw":
      v_origin = (182.982, 307.678, 337.458) + (5, 0.5, 3);
      v_angles = (270, 172, 0.0000609786);
      break;
    case "spas":
      v_origin = (149.712, 309.119, 315.038) + (-6, 0, 7);
      v_angles = vectorscale((1, 0, 0), 270.0);
      break;
    case "srm1216":
      v_origin = (182.708, 308.822, 313.982) + vectorscale((0, 0, 1), 15.0);
      v_angles = (270, 180, -0.00000500896);
      break;
    case "svu":
      v_origin = (150.962, 309.119, 328.288) + (-5, 0, 8);
      v_angles = vectorscale((1, 0, 0), 270.0);
      break;
    case "tar21":
      v_origin = (184.732, 309.325, 327.97) + (3, 0, 8);
      v_angles = (270, 180, -0.00000500896);
      break;
    case "type95":
      v_origin = (150.962, 309.119, 328.288) + vectorscale((-1, 0, 1), 7.0);
      v_angles = vectorscale((1, 0, 0), 270.0);
      break;
    case "usrpg_player":
      v_origin = (184.47, 307.925, 338.732) + (5, 0, -6);
      v_angles = (270, 168.8, 0.000151697);
      break;
    case "uzi":
      v_origin = (151.212, 309.119, 325.538) + (-6, 0, 7);
      v_angles = vectorscale((1, 0, 0), 270.0);
      break;
    case "vector":
      v_origin = (187.482, 309.325, 325.22) + (-8, 0, 5);
      v_angles = (270, 180, -0.00000500896);
      break;
    case "xm8":
      v_origin = (151.212, 309.119, 325.788) + (-6, 0, 8);
      v_angles = vectorscale((1, 0, 0), 270.0);
      break;
    default:
      b_use_offset = 0;
      break;
  }

  if(b_use_offset) {
    if(v_origin[0] > 170)
      v_origin = (v_origin[0] - 39.5, v_origin[1], v_origin[2]);

    v_offset_origin = v_origin - s_anchor.origin;
    self.origin = self.origin + v_offset_origin;

    if(b_left_side)
      v_debug_color = (1, 0, 0);
    else
      v_debug_color = (0, 0, 1);

    debugstar(self.origin, 1000, v_debug_color);

  } else {
    iprintlnbold(str_weapon + " is not supported by set_loadout_offset()");

  }
}

waitill_armed() {
  scene_wait("player_wakes_up_in_interrogation_room");
  s_armory = getstruct("player_equipment_objective", "targetname");
  set_objective(level.obj_pickup_weapons, s_armory.origin, "");
  level.player allowpickupweapons(1);
  b_armed_for_combat = 0;

  while(!b_armed_for_combat) {
    str_current_weapon = self getcurrentweapon();
    str_weapon_type = weapontype(str_current_weapon);
    b_armed_for_combat = str_current_weapon != "noweapon_sp" && (str_weapon_type == "bullet" || str_weapon_type == "projectile");
    wait 0.1;
  }

  level notify("objective_update_player_armed");
  t_objective_door = get_ent("hallway_door_trigger", "targetname");
  s_objective_marker = get_struct(t_objective_door.target, "targetname");
  set_objective(level.obj_pickup_weapons, s_objective_marker);
  str_primary_grenade = getloadoutitem("primarygrenade");
  str_secondary_grenade = getloadoutitem("specialgrenade");
  level.player giveweapon(str_primary_grenade);
  level.player giveweapon(str_secondary_grenade);
  level.player takeweapon("noweapon_sp");
  setsaveddvar("cg_DrawCrosshair", 1);
}

hallway_turret_think() {
  self waittill("death");
  flag_set("observation_turret_killed");
}

run_mason_hallway_friendly() {
  level thread redshirt_rushes_turret();
  str_color = level.salazar get_force_color();
  level.salazar clear_force_color();
  nd_cover = getnode("salazar_hallway_turret_cover_node", "targetname");
  level.salazar thread force_goal(nd_cover);
  level.salazar thread disable_melee_until_flag("observation_turret_killed");
  level.salazar thread move_up_on_hallway_clear();
  level thread friendlies_focus_fire_on_turret_after_time();
  flag_wait("observation_turret_killed");
  use_trigger_on_group_clear("obs_hallway_group_front", "obs_hallway_color_front");
  use_trigger_on_group_clear("obs_hallway_group_back", "obs_hallway_color_back");
  level.salazar set_force_color(str_color);
  flag_wait("obs_hallway_color_back_hit");
  wait 0.05;
  array_delete(getentarray("hallway_color_trigger", "script_noteworthy"));
}

friendlies_focus_fire_on_turret_after_time() {
  level endon("hallway_cleared");
  wait 15;

  if(!flag("observation_turret_killed")) {
    vh_turret = get_ent("observation_hallway_turret", "targetname");
    vh_turret.health = 10;

    while(is_alive(vh_turret))
      level.salazar shoot_at_target(vh_turret, undefined, 0, 2);
  }
}

move_up_on_hallway_clear() {
  level endon("friendly_face_started");
  flag_wait("hallway_cleared");
  level.salazar clear_force_color();
  level.salazar set_goalradius(16);
  level.salazar set_goal_node(getnode("salazar_exit_reach_setup", "targetname"));
}

redshirt_rushes_turret() {
  wait 5.5;
  vh_turret = get_ent("observation_hallway_turret", "targetname");
  nd_safe_spot = getnode("intro_hallway_safe_start_node", "targetname");
  nd_death = getnode("intro_hallway_turret_fodder_node", "targetname");

  if(isnodeoccupied(nd_safe_spot)) {
    setenablenode(nd_safe_spot, 0);
    ai_user = getnodeowner(nd_safe_spot);

    if(isDefined(ai_user) && isalive(ai_user)) {
      str_color = ai_user get_force_color();
      ai_user clear_force_color();
      ai_user thread force_goal(nd_death);

      if(isDefined(vh_turret))
        vh_turret maps\_turret::set_turret_target(ai_user, (0, 0, 0), 0);
    }

    flag_wait("observation_turret_killed");
    setenablenode(nd_safe_spot, 1);

    if(isalive(ai_user))
      ai_user set_force_color(str_color);
  }
}

hallway_front_rush() {
  a_enemies = get_ai_group_ai("obs_hallway_group_front");

  foreach(enemy in a_enemies) {
    if(isalive(enemy))
      enemy maps\_rusher::rush();

    wait 10;
  }
}

run_masons_quarters(str_door_name, str_trigger_name, open_angle, str_open_notify) {
  m_door = getent("masons_door", "targetname");
  m_door_clip = getent("masons_door_clip", "targetname");
  m_door_clip linkto(m_door, "tag_animate");
  t_door = getent("masons_door_trigger", "targetname");
  t_door setcursorhint("HINT_NOICON");
  t_door sethintstring(&"BLACKOUT_OPEN_DOOR");
  t_door waittill("trigger");
  level.player thread run_masons_quarters_rumble();
  run_scene_and_delete("open_masons_door");
  t_cigar_box = getent("mason_personal_effects_trigger", "targetname");
  t_cigar_box setcursorhint("HINT_NOICON");
  t_cigar_box sethintstring(&"BLACKOUT_USE_PERSONAL_EFFECTS");
  t_cigar_box waittill("trigger");
  level.player playsound("evt_masonroom_info_pickup");
  level notify("masons_personal_effects_found");
  e_cigar_box = getent("mason_personal_effects", "targetname");
  e_cigar_box delete();
}

run_masons_quarters_rumble() {
  wait 0.6;
  self playrumbleonentity("damage_light");
}

init_doors() {
  hallway_door = getent("interrogation_hallway_door", "targetname");
  collision = getent(hallway_door.target, "targetname");
  collision linkto(hallway_door, "tag_origin");
  glass_list = getentarray("interrogation_mirror_broken", "targetname");

  foreach(glass in glass_list)
  glass hide();

  level thread run_masons_quarters();
}

interrogation_menendez_bleed() {
  ai_menendez = getent("menendez_ai", "targetname");
  wait 1.5;

  if(is_mature()) {
    println("**** Setting shoulder blood client flag****");

    ai_menendez setclientflag(12);
  }
}

interrogation_camera() {
  a_m_camera = getentarray("security_intro_camera", "targetname");

  foreach(m_camera in a_m_camera)
  play_fx("camera_recording", m_camera.origin, m_camera.angles, "stop_record");

  flag_wait("intro_disable_camera");
  level notify("stop_record");
}

interrogation_handcuffs() {
  m_handcuffs = getent("intro_handcuffs", "targetname");
  m_handcuffs play_fx("handcuffs_light", m_handcuffs.origin, m_handcuffs.angles, "stop_handcuffs", 1);
  flag_wait("intro_disable_handcuffs");
  level.player playsound("evt_power_down");
  m_handcuffs notify("stop_handcuffs");
}

notetrack_lights_out(ai_menendez) {
  clientnotify("INT_out");
  setdvar("r_exposureTweak", 1);
  setdvar("r_exposureValue", 10.0);
}

notetrack_lights_on(ai_menendez) {
  setdvar("r_exposureTweak", 0);
  clientnotify("interrogation_light");
  stop_exploder(1000);
}

notetrack_light_flicker(ai_menendez) {
  setdvar("r_exposureTweak", 1);
  clientnotify("INT_flick");
  blend_exposure_over_time(1.0, 0.5);
  blend_exposure_over_time(7.0, 0.2);
  blend_exposure_over_time(level.m_original_exposure, 3.0);
  setdvar("r_exposureTweak", 0);
}

notetrack_interrogation_explosion(m_player_body) {
  setdvar("r_exposureTweak", 1);
  clientnotify("INT_flick");
  playsoundatposition("exp_carrier_impact", (0, 0, 0));
  level.player playrumbleonentity("artillery_rumble");
  earthquake(0.1, 1, level.player.origin, 128, level.player);
  blend_exposure_over_time(1.0, 0.5);
  blend_exposure_over_time(4.0, 0.2);
  blend_exposure_over_time(level.m_original_exposure, 3.0);
  setdvar("r_exposureTweak", 0);
}

notetrack_table_shake(ai_menendez) {
  earthquake(0.3, 0.35, level.player.origin, 128);
  playrumbleonposition("grenade_rumble", level.player.origin);
}

interrogation_break_mirror(ai_salazar) {
  broken_glass_brushes = getentarray("interrogation_mirror_broken", "targetname");

  foreach(brush in broken_glass_brushes)
  brush show();

  exploder(999);
  level.player lerpviewangleclamp(3.0, 0.5, 0.5, 0, 0, 0, 0);
}

notetrack_briggs_transmission(m_player_body) {
  level clientnotify("alarm_start");
  maps\_glasses::play_bink_on_hud("blackout_intro_jetwing", 0, 1, 0, 0, 1);
}

scene_hallway() {
  vision_set_hallway();
  add_spawn_function_group("observation_hallway_friend", "targetname", ::hallway_friendly_think);
  add_spawn_function_ai_group("obs_hallway_group_back", ::rush_when_grouped);
  level thread run_scene_and_delete("hallway_entry_attackers");
  level thread run_scene_and_delete("hallway_entry_victims");
  level thread run_scene_and_delete("hallway_cougher");
  level thread run_scene_and_delete("hallway_dead");
  wait 1.5;
  run_scene_and_delete("hallway_drag");
  level thread run_scene_and_delete("hallway_surgery");
  trigger_wait("deck_reveal_trigger");
  array_delete(getentarray("observation_hallway", "script_noteworthy"));
  end_scene("hallway_dead");
}

hallway_friendly_think(ai_guy) {
  ai_guy set_ignoreme(1);
  ai_guy set_ignoreall(1);
  ai_guy.a.deathforceragdoll = 1;
}

scene_sal_open_door() {
  level notify("opening_hallway_door");
  run_scene_first_frame("salazar_runs_into_hallway");
  level thread dialog_hallway_breach();
  set_objective(level.obj_pickup_weapons, undefined, "delete");
  run_scene_and_delete("sal_door_open");
  level thread run_scene_and_delete("hallway_door_closes_behind_player");
  hall_door = getent("interrogation_hallway_door", "targetname");
  hall_door_collision = getent(hall_door.target, "targetname");
  hall_door_collision connectpaths();

  if(scene_exists("taser_knuckles_extras")) {
    end_scene("taser_knuckles_extras");
    delete_scene("taser_knuckles_extras", 1, 1);
  }
}

notetrack_salazar_runs_into_hallway(e_player_body) {
  level.salazar headtracking_off();
  run_scene_and_delete("salazar_runs_into_hallway");
}

scene_sal_open_door_rumble(player_body) {
  for(i = 0; i < 2; i++) {
    level.player playrumbleonentity("tank_rumble");
    earthquake(0.1, 0.1, level.player.origin, 1000, level.player);
    wait 0.1;
  }
}

notetrack_player_leaves_monitor(e_player_body) {
  level.briggs thread say_dialog("brig_david_0", 2);
  level thread run_scene_and_delete("intro_playerturn");
  level thread run_scene_and_delete("intro_guard_2");
  level.player show_hud();
  turn_off_intro_cam_hud();
  scene_wait("intro_cctv");
  level thread run_scene_and_delete("intro_nag_loop");
  scene_wait("enter_interrogation_room");
  level thread run_scene_and_delete("intro_briggs_leave");
}

scene_interrogation() {
  level thread run_scene_and_delete("intro_fight");
  level thread run_scene_and_delete("intro_fight_sailors");
  wait_network_frame();
  ais = get_ais_from_scene("intro_fight");

  foreach(ai in ais) {
    if(issubstr(ai.targetname, "mirror"))
      ai.name = "";
  }

  mirror_menendez = getent("menendez_ai", "targetname");
  mirror_menendez custom_ai_weapon_loadout("fiveseven_sp");
  scene_wait("intro_fight");
}

sal_exit_explosion() {
  exploder(1001);
  level notify("fxanim_stairwell_ceiling_start");
  size = randomfloatrange(0.2, 0.4);
  duration = randomfloatrange(0.5, 1.5);
  level thread maps\blackout_util::light_flicker(duration);
  playrumbleonposition("grenade_rumble", level.player.origin);
  earthquake(0.8, 0.8, level.player.origin, 100);
  level.player playsound("exp_carrier_impact_room");
  level clientnotify("cpb");
}

turn_on_intro_cam() {
  setsaveddvar("r_extracam_custom_aspectratio", 1.61538);
  s_camera = getstruct("interrogation_cam_pos", "targetname");
  s_camera_target = getstruct(s_camera.target, "targetname");
  s_camera.angles = vectortoangles(s_camera_target.origin - s_camera.origin);
  level.e_camera = spawn("script_model", s_camera.origin);
  level.e_camera setmodel("tag_origin");
  level.e_camera.angles = s_camera.angles;
  level.e_camera setclientflag(11);
  level.e_camera thread camera_aim_update();
  level.player clientnotify("intro_cctv_assigned");
  level.extra_cam_surfaces["observation"] show();
  level.player hide_hud();
  flag_set("intro_camera_on");
}

turn_off_intro_cam() {
  clientnotify("intro_cctv_complete");

  if(isDefined(level.e_camera)) {
    level.e_camera notify("stop_camera_control");
    level.e_camera clearclientflag(11);
    wait_network_frame();
    level.e_camera delete();
    level.player show_hud();
  }

  level.extra_cam_surfaces["observation"] hide();
  flag_clear("intro_camera_on");
}

turn_off_intro_cam_hud() {
}

room_cams_init() {
  s_right_mirror = getstruct("mirror_1_dir", "targetname");
  level.e_right_mirror = spawn("script_model", s_right_mirror.origin);
  level.e_right_mirror setmodel("tag_origin");
  level.e_right_mirror.angles = s_right_mirror.angles;
  level.e_right_mirror.is_reflected_over_y = 0;
  level.e_right_mirror.s_fake_mirror = s_right_mirror;
  level.e_right_mirror.s_real_mirror = getstruct("mirror_1_real_room", "targetname");
  s_left_mirror = getstruct("mirror_2_dir", "targetname");
  level.e_left_mirror = spawn("script_model", s_left_mirror.origin);
  level.e_left_mirror setmodel("tag_origin");
  level.e_left_mirror.angles = s_left_mirror.angles;
  level.e_left_mirror.is_reflected_over_y = 1;
  level.e_left_mirror.s_fake_mirror = s_left_mirror;
  level.e_left_mirror.s_real_mirror = getstruct("mirror_2_real_room", "targetname");
}

get_mirror_cam_offset() {
  v_player = level.player.origin;
  v_output = (0, 0, 0);
  v_mirror = self.s_real_mirror.origin;
  v_vake = self.s_fake_mirror.origin;
  v_reflection = v_player - v_mirror;

  if(self.is_reflected_over_y)
    v_reflection = (-1 * v_reflection[0], v_reflection[1], v_reflection[2]);
  else
    v_reflection = (v_reflection[0], -1 * v_reflection[1], v_reflection[2]);

  return v_reflection;
}

run_mirror_camera() {
  self endon("end_camera");
  dist_mult = 0.6;
  offset_amount = 32;

  while(true) {
    v_offset = get_mirror_cam_offset();
    a_dir = vectortoangles(-1 * v_offset);

    if(self.is_reflected_over_y) {
      v_offset = v_offset * dist_mult;
      v_offset = v_offset - (offset_amount, 0, 0);
    } else {
      v_offset = v_offset * dist_mult;
      v_offset = v_offset - (0, offset_amount, 0);
    }

    frametime = 0.05;
    self moveto(self.s_fake_mirror.origin + v_offset, frametime, 0, 0);
    self rotateto(a_dir, frametime, 0, 0);
    wait(frametime);
    self.origin = self.s_fake_mirror.origin + v_offset;
    self.angles = a_dir;
  }
}

room_cams_left_on(m_player) {
  level.e_right_mirror clearclientflag(14);
  level.e_right_mirror notify("end_camera");
  wait 0.1;
  level.e_left_mirror setclientflag(14);
  level.e_left_mirror thread run_mirror_camera();
}

room_cams_right_on(m_player) {
  level.e_left_mirror clearclientflag(14);
  level.e_left_mirror notify("end_camera");
  wait 0.1;
  level.e_right_mirror setclientflag(14);
  level.e_right_mirror thread run_mirror_camera();
}

room_cams_cleanup(delete_cams) {
  level.e_left_mirror clearclientflag(14);
  level.e_right_mirror clearclientflag(14);
  level.e_left_mirror notify("end_camera");
  level.e_right_mirror notify("end_camera");
  wait_network_frame();

  if(delete_cams) {
    level.e_left_mirror delete();
    level.e_right_mirror delete();
  }
}

camera_aim_update() {
  self endon("stop_camera_control");
  offset = (0, 0, 0);
  intro_cam_aim_vel = (0, 0, 0);
  max_intro_cam_aim_vel = (1, 1, 0);
  start_angles = (self.angles[0], self.angles[1], 0);
  angle_x_1 = self.angles[0] - 10;
  angle_x_2 = self.angles[0] + 10;
  angle_y_1 = self.angles[1] - 10;
  angle_y_2 = self.angles[1] + 10;

  while(true) {
    stick = level.player getnormalizedcameramovement();
    clamp_yaw = 5;
    clamp_pitch = 5;
    desired_aim_vel_yaw = abs(offset[1]) >= clamp_yaw && offset[1] * (stick[1] * -1) >= 0 ? 0 : stick[1] * -1 * max_intro_cam_aim_vel[1];
    desired_aim_vel_pitch = abs(offset[0]) >= clamp_pitch && offset[0] * (stick[0] * -1) >= 0 ? 0 : stick[0] * -1 * max_intro_cam_aim_vel[0];
    intro_cam_aim_vel_yaw = difftrack(desired_aim_vel_yaw, intro_cam_aim_vel[1], 3, 0.05);
    intro_cam_aim_vel_pitch = difftrack(desired_aim_vel_pitch, intro_cam_aim_vel[0], 3, 0.05);
    intro_cam_aim_vel = (intro_cam_aim_vel_pitch, intro_cam_aim_vel_yaw, 0);
    offset = offset + intro_cam_aim_vel * 0.05;
    p = clamp(offset[0], clamp_pitch * -1, clamp_pitch);
    y = clamp(offset[1], clamp_yaw * -1, clamp_yaw);
    offset = (p, y, 0);
    new_angles = start_angles + offset;
    a_x = clamp(new_angles[0], angle_x_1, angle_x_2);
    a_y = clamp(new_angles[1], angle_y_1, angle_y_2);
    self.angles = (a_x, a_y, self.angles[2]);
    wait 0.05;
  }
}

intro_setup_player() {
  level.player takeallweapons();
  level.player giveweapon("noweapon_sp");
  setsaveddvar("cg_DrawCrosshair", 0);
}

spawn_interrogation_heroes() {
  level.briggs = init_hero("briggs");
  level.briggs.ignoreme = 1;
  level.briggs.ignoreall = 1;
  level.briggs.name = "Briggs";
  level.salazar = init_hero("salazar");
  level.salazar.name = "Salazar";
  level.menendez = init_hero("menendez");
  level.menendez.name = "Menendez";
  level.salazar custom_ai_weapon_loadout("fiveseven_sp");
}

taser_knuckles_pickup() {
  run_scene_first_frame("taser_knuckle_crate");
  run_scene_first_frame("taser_knuckles_extras");
  taser_trigger = getent("knuckles_pickup_trigger", "targetname");
  taser_trigger trigger_off();
  level.player waittill_player_has_intruder_perk();
  taser_trigger trigger_on();
  scene_wait("player_wakes_up_in_interrogation_room");
  taser_trigger setcursorhint("HINT_NOICON");
  taser_trigger sethintstring(&"SCRIPT_HINT_HACK");
  set_objective(level.obj_lock_perk, taser_trigger, "interact");
  waittill_knuckles_trigger();
  set_objective(level.obj_lock_perk, undefined, "remove");
  wait_network_frame();
  taser_trigger delete();
}

waittill_knuckles_trigger() {
  level endon("mason_hallway_started");
  trigger_wait("knuckles_pickup_trigger");
  level.player takeweapon("knife_sp");
  level.player giveweapon("tazer_knuckles_sp");
  flag_set("lockbreaker_used");
  flag_set("player_got_knuckles");
  set_objective(level.obj_lock_perk, undefined, "remove");
  level thread run_scene_and_delete("taser_knuckle_crate");
  level thread run_scene_and_delete("taser_knuckle_get");
}

setup_hallway_ally() {
  self endon("death");
  self change_movemode("cqb_run");
  wait 3.0;
  self setnormalhealth(1);
}

callback_player_knocked_out(player) {
  level.player playrumbleonentity("damage_heavy");
  level clientnotify("knc_on");
  level.player dodamage(50, level.player.origin);
  level.player shellshock("death", 1.5);
  wait 0.5;
  level.sndknockedoutent = spawn("script_origin", level.player.origin);
  level.sndknockedoutent2 = spawn("script_origin", level.player.origin);
  level.sndknockedoutent playloopsound("evt_mason_knockout1", 3);
  level.sndknockedoutent2 playloopsound("evt_mason_knockout_breath", 2);
  level.player magic_bullet_shield();
  screen_fade_out(1.0);
}

init_flags() {
  flag_init("intro_disable_camera");
  flag_init("intro_disable_handcuffs");
  flag_init("accept_getup_help");
  flag_init("intro_camera_on");
  flag_init("player_got_knuckles");
  flag_init("observation_turret_killed");
  flag_init("intro_hallway_enemy_on_stairs");
  flag_init("hallway_cleared");
  flag_init("obs_hallway_color_back_hit");
}

notetrack_setup_table(m_tag_origin) {
  m_tag_origin attach("p_rus_office_table_metal_cufflock", "origin_animate_jnt");
}

notetrack_menendez_punched_in_the_face(ai_menendez) {
  playfxontag(level._effect["intro_punch_spit"], ai_menendez, "J_Head");
}

notetrack_prestige_sailor_shot(ai_sailor) {
  m_gun = get_model_or_models_from_scene("intro_fight", "prestige_player_gun");
  v_start = m_gun gettagorigin("TAG_FX");
  v_end = ai_sailor gettagorigin("J_Head");
  magicbullet("fiveseven_sp", v_start, v_end);

  if(is_mature())
    playfxontag(level._effect["menendez_shoots_guard"], ai_sailor, "J_Head");

  exploder(439);
  m_player_body = get_model_or_models_from_scene("intro_fight", "player_body");
  ai_menendez = get_ent("menendez_ai", "targetname");
  m_player_body setforcenocull();
  ai_menendez setforcenocull();
}