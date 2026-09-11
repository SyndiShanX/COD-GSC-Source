/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicle_push\coop_vehicle_push.gsc
*********************************************************/

function start_coop_push(var_0) {
  scripts\cp\cp_create_script_utility::thermometerwatch("coop_push_cs");
  level.get_mortar_impact_pos = &get_mortar_impact_spot;
  level.bomb_defusal_success_func = &blockade_bomb_defusal_success_func;
  level.process_entities_inside_subway_car = &computermakingnose;
  level.open_trap_room_door = &cp_arms_dealer_sound_load;
  level.unloading_func["mindia8"] = &scripts\cp\raid_utility::ref_129e7;
  level.unloading_func["vindia_a2"] = &ref_129ed;
  level.unloading_func["umike_covered_physics"] = &ref_129ec;
  scripts\cp\cp_modular_spawning::register_aitype_setup("sniper", "actor_enemy_cp_rus_desert_sniper", undefined, undefined);
  scripts\cp\cp_modular_spawning::register_aitype_setup("rpg_helmet", "actor_enemy_cp_alq_desert_rpg_helmet", undefined, undefined);
  setDvar("QOSTSKSTO", 0);
  scripts\cp\raid_utility::assignspectatortospectatetryagain(["zone_blockade"]);
  scripts\cp\raid_utility::set_raid_checkpoint("raid_coop_push", "coop_push_player_start");
  hide_enemy_mortar_shell();
  assign_more_vehicle_unload_groups();
  set_up_modular_spawning();
  ascendermodelworld();
  scripts\cp\bomb_defusal\coop_bomb_defusal::start_coop_bomb_defusal_sequence("blockade_bomb_defusal_controller");
  deploy_enemy_turrets();
  scripts\cp\raid_utility::init_player_achievements("sniper_pickup", "weapon_wm_sn_alpha50_brprop", &"COOP_VEHICLE_PUSH/PICK_UP_SNIPER", "iw8_sn_alpha50", ["vzscope"]);
  set_up_blockade_gates();
  thread close_blockade_gates();
  thread blockade_landmine();
  thread computer_interface_think_internal();
  thread computer_listener_all();
  thread associate_digit_display_model();
  thread vehicle_progress_marker_think();
  thread player_progress_market_think();

  if(true) {
    level thread scripts\asm\soldier\ground_turret::survival_ai_manager(&ref_11aba);
    level.sentrysettings["manned_turret"].overheattime = 6;
    level.sentrysettings["manned_turret"].cooldowntime = 0.75;
    level.sentrysettings["manned_turret"].burstmin = 60;
    level.sentrysettings["manned_turret"].burstmax = 90;
    level.sentrysettings["manned_turret"].pausemin = 0.2;
    level.sentrysettings["manned_turret"].pausemax = 0.35;
  }

  level waittill("blockade_sequence_successful");
  scripts\cp\bomb_defusal\coop_bomb_defusal::spawn_and_hide_usb();
  stop_all_spawn_groups();
  linkoffset();
  brdisablefinalkillcam();
  scripts\cp\cp_create_script_utility::cleanup_cs_file_objects("coop_push_cs");
}

function ref_11aba() {
  thread scripts\asm\soldier\ground_turret::lockscriptabledoors(1);
}

function islongshotspecial() {
  while(!isDefined(level.player) || !isalive(level.player)) {
    wait 1;
  }

  setDvar("drop_phone", "");
  wait 1;

  while(getDvar("drop_phone") != "1") {
    wait 1;
  }

  scripts\cp\bomb_defusal\coop_bomb_defusal::drop_bomb_detonator_from_ai(level.player, "bomb_case");
}

function debug_pre_start_coop_push(var_0) {
  scripts\cp\coop_escort::delay_teleport_players(2, "coop_push_cs_completed", "coop_push_player_start");
  ref_13102();
}

function init() {
  scripts\engine\utility::flag_init("vehicle_progression_flags_have_been_set_up");
  scripts\engine\utility::flag_init("post_blockade_combat");
  scripts\engine\utility::flag_init("heavy_enemy_spawning_paused");
  load_vfx();
  scripts\cp\maps\cp_donetsk\milbase\ai_flare::load_fx();
  level.pindia_positions_override_func = &pindia_positions_override_func;
  build_vehicles();
}

function pindia_positions_override_func(var_0) {
  var_0[0].canshootinvehicle = 0;
  var_0[1].canshootinvehicle = 1;
  var_0[2].canshootinvehicle = 1;
  var_0[3].canshootinvehicle = 1;
  var_0[4].canshootinvehicle = 1;
  var_0[5].canshootinvehicle = 1;
  return var_0;
}

function ref_13102() {
  deploy_vehicle_to_push();
}

function start_vehicle_push_sequence() {
  set_up_modular_spawning();
}

function blockade_bomb_defusal_success_func() {
  level thread scripts\cp\bomb_defusal\coop_bomb_defusal::playerpowerscleanuphud();
  ref_138c3();
  wait 1.5;
  asm_animhasfacialoverridemp();
}

function deploy_vehicle_to_push() {
  var_0 = getEnt("escort_vehicle_push_volume", "targetname");
  var_1 = getEnt("escort_vehicle_push_clip", "targetname");
  var_2 = getvehiclenode("escort_vehicle_start", "targetname");
  var_3 = spawnVehicle("veh8_mil_lnd_pindia_black_physics", "target_escort_vehicle", "pindia_physics", var_2.origin, var_2.angles);
  var_3 attachpath(var_2);
  var_3 startpath();
  var_3 vehicle_setspeedimmediate(0, 1, 1);
  var_3 hidepart("tag_trunk");
  var_3 hidepart("tag_accessory_02");
  thread vehicle_to_push_damage_monitor(var_3);
  thread reach_end_monitor(var_3);
  set_up_bomb_model_marker(var_3, var_3);
  var_3.little_bird_mg_enterend = 1;
  var_3.obj_ow_atvs_spawned = var_0;
  var_3.obj_overwatch_tanks_ref = var_1;
  var_4 = spawn("script_model", var_3.origin);
  var_4 notsolid();
  var_4 setModel("veh8_mil_lnd_pindia_bomb");
  var_4.angles = var_3.angles;
  var_4 linkTo(var_3, "tag_origin_animate");
  thread cpoperationcrateactivatecallback(var_4, var_3);
  level.vehicle_to_push = var_3;
  var_1 linkTo(var_3);
  var_0 enablelinkTo();
  var_0 linkTo(var_3);
  thread player_push_monitor(var_0, var_0);
}

function set_up_bomb_model_marker(var_0) {
  var_1 = 5;
  var_2 = 1;
  var_3 = anglestoleft(var_0.angles);
  var_4 = anglestoup(var_0.angles);
  var_5 = scripts\engine\utility::getStruct("vehicle_to_push_bomb_marker", "targetname");
  var_6 = spawn("script_model", var_5.origin + var_3 * var_1 + var_4 * var_2);
  var_6 setModel("tag_origin");
  var_6.angles = var_5.angles;
  var_6 linkTo(var_0);
  var_0.bomb_model = var_6;
}

function activate_bomb_interactions(var_0, var_1) {
  var_2 = ref_11a90(var_0);
  thread ref_12398(var_2, var_2);
}

function ref_11a90(var_0) {
  var_1 = var_0.bomb_model.origin;
  var_2 = spawn("script_model", var_1);
  var_2 setModel("tag_origin");
  var_2.angles = var_0.bomb_model.angles;
  var_2 makeusable();
  var_2 setHintString(&"COOP_VEHICLE_PUSH/PLACE_C4");
  var_2 setCursorHint("HINT_BUTTON");
  var_2 sethintdisplayrange(156);
  var_2 sethintdisplayfov(90);
  var_2 setuserange(128);
  var_2 setusefov(60);
  var_2 sethintonobstruction("show");
  var_2 setuseholdduration("duration_short");
  var_2 linkTo(var_0);
  return var_2;
}

function ref_12398(var_0, var_1) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      var_2 playSound("cp_car_bomb_toss");
      break;
    }
  }

  place_bomb_in_the_vehicle(var_1);
  var_0 delete();
}

function place_bomb_in_the_vehicle(var_0) {
  var_0.bomb_model setModel("offhand_vm_briefcase_bomb_c4_cp");
  var_0.bomb_model notsolid();
  var_0 playSound("cp_car_bomb_drop");
  var_0.bomb_is_loaded = 1;
  try_activate_final_bomb_detonate_sequence(var_0);
}

function asm_animhasfacialoverridemp() {
  foreach(var_1 in level.bombs_for_coop_bomb_defusal) {
    thread forbiddencachespawns(var_1);
  }
}

function forbiddencachespawns(var_0) {
  var_1 = ref_11a78(var_0.c4);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      break;
    }
  }

  activate_bomb_interactions(level.vehicle_to_push, var_2);

  foreach(var_4 in var_0.wire_look_at_markers) {
    var_4.wire_model delete();
  }

  var_0.c4 delete();
  var_1 delete();
}

function ref_11a78(var_0) {
  var_1 = var_0.origin + anglestoup(var_0.angles) * 1;
  var_2 = spawn("script_model", var_1);
  var_2 setModel("tag_origin");
  var_2.angles = var_0.angles;
  var_2 makeusable();
  var_2 setHintString(&"COOP_VEHICLE_PUSH/PICK_UP_C4");
  var_2 setCursorHint("HINT_BUTTON");
  var_2 sethintdisplayrange(156);
  var_2 sethintdisplayfov(90);
  var_2 setuserange(128);
  var_2 setusefov(60);
  var_2 sethintonobstruction("show");
  var_2 setuseholdduration("duration_short");
  var_2 linkTo(var_0);
  return var_2;
}

function player_push_monitor(var_0, var_1) {
  var_1 endon("death");
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_4 = get_num_of_player_touching_volume(var_0);

    if(var_4 > 0) {
      level notify("vehicle_is_being_pushed");
    }

    if(var_2 != var_4) {
      var_1 vehicle_setspeedimmediate(get_new_vehicle_speed(var_4), 1, 1);

      if(var_4 > 0) {
        if(var_3 == 0) {
          var_1 playLoopSound("temp_vehicle_surface_sfx");
          var_3 = 1;
        }
      } else {
        var_1 stoploopsound("temp_vehicle_surface_sfx");
        var_3 = 0;
      }

      var_2 = var_4;
    }

    waitframe();
  }
}

function get_new_vehicle_speed(var_0) {
  var_1 = 0;

  switch (var_0) {
    case 1:
      var_1 = 1.405;
      break;
    case 2:
      var_1 = 2.81;
      break;
    case 3:
      var_1 = 2.81;
      break;
    case 4:
      var_1 = 2.81;
      break;
  }

  return var_1;
}

function get_num_of_player_touching_volume(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }

    if(var_3 getstance() == "prone") {
      continue;
    }

    if(var_3 istouching(var_0)) {
      set_player_is_pushing_vehicle(var_3);
      var_1++;
    }
  }

  return var_1;
}

function set_player_is_pushing_vehicle(var_0) {
  if(!istrue(var_0.is_pushing_vehicle)) {
    var_0.is_pushing_vehicle = 1;
    thread continue_to_push_monitor(var_0);
    return;
  }
}

function unset_player_is_pushing_vehicle(var_0) {
  if(istrue(var_0.is_pushing_vehicle)) {
    var_0.is_pushing_vehicle = 0;
    return;
  }
}

function continue_to_push_monitor(var_0) {
  var_0 endon("disconnect");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_0 playerlinkTo(var_1, "tag_origin");
  var_1 linkTo(level.vehicle_to_push);
  thread player_mover_clean_up_monitor(var_1, var_0);
  thread player_push_vehicle_stance_update_think(var_0);

  for(;;) {
    waitframe();
  }

  LOC_0000006b:
    var_0 unlink();
  var_0 allowstand(1);
  var_0 allowcrouch(1);
  var_0 allowprone(1);
  var_0 notify("stop_pushing_vehicle");

  if(isDefined(var_1)) {
    var_1 delete();
  }

  unset_player_is_pushing_vehicle(var_0);
}

function player_mover_clean_up_monitor(var_0, var_1) {
  var_1 endon("death");
  var_0 scripts\engine\utility::ref_143ad("disconnect", "last_stand");
  var_1 delete();
}

function player_controller_push_along_vehicle(var_0) {
  [var_2] = var_0 getnormalizedmovement();
  var_3 = var_1[1];

  if(abs(var_2) == 0 && abs(var_3) == 0) {
    return false;
  }

  var_4 = get_player_controller_direction_in_world(var_0);
  var_5 = anglesToForward(level.vehicle_to_push.angles);
  var_6 = acos(vectordot(var_4, var_5));
  return var_6 >= 0 && var_6 <= 30 || var_6 >= 330 && var_6 < 360;
}

function get_player_controller_direction_in_world(var_0) {
  var_1 = anglesToForward(var_0 getplayerangles());
  var_2 = anglestoright(var_0 getplayerangles());
  [var_4] = var_0 getnormalizedmovement();
  var_5 = var_3[1];
  return vectorNormalize((var_1 * var_4 + var_2 * var_5) * (1, 1, 0));
}

function player_push_vehicle_stance_update_think(var_0) {
  var_0 endon("disconnect");
  var_0 endon("stop_pushing_vehicle");
  var_0 notify("player_push_vehicle_stance_update_think");
  var_0 endon("player_push_vehicle_stance_update_think");
  var_1 = var_0 getstance();

  switch (var_1) {
    case "stand":
      var_0 allowstand(1);
      var_0 allowcrouch(0);
      var_0 allowprone(0);
      break;
    case "crouch":
      var_0 allowcrouch(1);
      var_0 allowstand(0);
      var_0 allowprone(0);
      break;
    default:
      break;
  }

  var_0 notifyonplayercommand("change_stance", "+stance");

  for(;;) {
    var_0 waittill("change_stance");
    var_1 = var_0 getstance();

    switch (var_1) {
      case "stand":
        var_0 allowcrouch(1);
        var_0 allowstand(0);
        var_0 allowprone(0);
        break;
      case "crouch":
        var_0 allowstand(1);
        var_0 allowcrouch(0);
        var_0 allowprone(0);
        break;
      default:
        break;
    }
  }
}

function vehicle_to_push_damage_monitor(var_0) {
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_0.maxhealth = 999999;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 999999;
    var_0.maxhealth = 999999;
  }
}

function reach_end_monitor(var_0) {
  var_0 endon("death");
  var_0 waittill("reached_end_node");
  var_0.reached_end_node = 1;
  try_activate_final_bomb_detonate_sequence(var_0);
}

function try_activate_final_bomb_detonate_sequence(var_0) {
  if(!istrue(var_0.reached_end_node)) {
    return;
  }

  if(!istrue(var_0.bomb_is_loaded)) {
    return;
  }

  var_1 = get_nearby_players(var_0);

  foreach(var_3 in var_1) {
    thread nearby_player_detonate_monitor(var_3, var_3);
  }

  foreach(var_6 in level.players) {
    thread display_get_away_from_vehicle_message(var_6, var_6);
  }
}

function nearby_player_detonate_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");
  thread display_detonate_hint_message(var_0, var_0);
  thread detonate_the_bomb_monitor(var_0, var_0);
}

function get_nearby_players(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(distance2dsquared(var_3.origin, var_0.origin) < 360000) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function display_get_away_from_vehicle_message(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");

  for(;;) {
    if(distance2dsquared(var_0.origin, var_1.origin) < 360000) {
      var_0 scripts\cp\utility::setlowermessage("too_close_to_vehicle_warning", &"COOP_VEHICLE_PUSH/GET_AWAY_FROM_VEHICLE");
    } else {
      var_0 scripts\cp\utility::clearlowermessage("too_close_to_vehicle_warning");
    }

    waitframe();
  }
}

function display_detonate_hint_message(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");
  var_1 endon("player_pressed_the_bomb_detonator");

  for(;;) {
    if(distance2dsquared(var_0.origin, var_1.origin) >= 360000) {
      var_0 scripts\cp\utility::setlowermessage("detonate_final_bomb_hint", &"COOP_VEHICLE_PUSH/DETONATE_BOMB_HINT");
    } else {
      var_0 scripts\cp\utility::clearlowermessage("detonate_final_bomb_hint");
    }

    waitframe();
  }
}

function detonate_the_bomb_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");
  var_1 endon("player_pressed_the_bomb_detonator");
  var_0 notifyonplayercommand("detonate_the_bomb", "+usereload");
  var_0 notifyonplayercommand("detonate_the_bomb", "+activate");

  for(;;) {
    var_0 waittill("detonate_the_bomb");

    if(distance2dsquared(var_0.origin, var_1.origin) < 360000) {
      continue;
    }

    thread the_bomb_is_detonated(var_1, var_0);
    return;
  }
}

function the_bomb_is_detonated(var_0, var_1) {
  var_1 notify("player_pressed_the_bomb_detonator");

  foreach(var_0 in level.players) {
    var_0 scripts\cp\utility::clearlowermessage("detonate_final_bomb_hint");
  }

  var_4 = getcompleteweaponname("c4_empty_mp");
  var_0 giveandfireoffhand(var_4);
  thread kingslayerkills(level);
  wait 1;
  var_0 takeweapon(var_4);
}

function kingslayerkills(var_0) {
  wait 0.65;
  thread vehicle_to_push_explode_sequence(level);
}

function vehicle_to_push_explode_sequence(var_0) {
  foreach(var_2 in level.players) {
    var_2 scripts\cp\utility::clearlowermessage("too_close_to_vehicle_warning");
  }

  var_0 playSound("exp_bombsite_lr");
  computer_player_listener();
  var_0.bomb_model delete();
  var_0.obj_ow_atvs_spawned delete();
  var_0.obj_overwatch_tanks_ref delete();
  var_0 delete();
  thread open_blockade_gates();
  level notify("blockade_barrier_clip", "delete");
  level notify("blockade_sequence_successful");
}

function computer_player_listener() {
  var_0 = (39906.7, 15306, -357.645);
  var_1 = (0, 116.999, 0);
  scripts\cp\raid_utility::pausemodetimer("vfx_cp_raid_blockade_gate_explo", var_0, var_1);
}

function deploy_enemy_turrets() {
  scripts\engine\utility::flag_init("enemy_turret_only_target_players_in_kill_zone");
  scripts\engine\utility::flag_set("enemy_turret_only_target_players_in_kill_zone");
  var_0 = undefined;

  if(true) {
    var_0 = scripts\engine\utility::getStructArray("manned_turret", "targetname");
  }

  level.enemy_turrets = [];
  var_1 = scripts\engine\utility::getStructArray("enemy_turret_marker", "targetname");

  foreach(var_3 in var_1) {
    if(1 && isDefined(var_0) && var_0.size > 0) {
      var_0 = sortbydistance(var_0, var_3.origin);

      if(distancesquared(var_0[0].origin, var_3.origin) < 4096) {
        continue;
      }
    }

    deploy_enemy_turret(var_3);
  }
}

function delete_on_death(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

function spawn_tag_origin(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin");
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_1), var_1, (0, 0, 0));
  return var_2;
}

function deploy_enemy_turret(var_0) {
  var_1 = spawnturret("misc_turret", var_0.origin, "iw8_mg_50cal_cp");
  var_1.angles = var_0.angles;
  var_1 setModel("weapon_mg_bravo50_balcony");
  var_1 setturretteam("axis");
  var_1 setmode("manual");
  var_1 setdefaultdroppitch(90);
  var_1 setleftarc(180);
  var_1 setrightarc(180);
  var_1 settoparc(180);
  var_1 setbottomarc(180);
  var_1 setconvergencetime(0, "yaw");
  var_1 setconvergencetime(0, "pitch");
  var_1 makeunusable();
  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_1.target_ent = spawn_tag_origin(var_2.origin, var_2.angles);
  var_1.target_ent_marker = var_2;
  var_1 settargetentity(var_1.target_ent);
  var_1.speed = 150;
  var_1.wait_between_shots = 0.1;
  var_1.wait_between_shot_round = 1.5;
  var_1.shots_per_round = 70;
  var_1.track_target_delay = 0.1;
  var_1.warning_time = 0.5;
  level.enemy_turrets[level.enemy_turrets.size] = var_1;
  thread delete_on_death(var_1.target_ent, var_1.target_ent);
}

function activate_enemy_turret(var_0) {
  if(istrue(var_0.little_bird_mg_reenter)) {
    return;
  }

  thread enemy_turret_fire_think(var_0);
  thread player_monitor(var_0);
  thread combat_logic(var_0);
}

function deactivate_enemy_turret(var_0) {
  var_0 notify("deactivate_enemy_turret");
  stop_firing(var_0);
}

function combat_logic(var_0) {
  var_0 endon("death");
  var_0 endon("deactivate_enemy_turret");
  thread target_select_think(var_0);
  var_1 = undefined;

  for(;;) {
    if(isDefined(var_0.current_target)) {
      if(is_different_target(var_1, var_0.current_target)) {
        stop_firing(var_0);
        wait randomfloatrange(0.5, 1);
      }

      if(!isDefined(var_1)) {
        start_firing(var_0);
      }
    } else {
      stop_firing(var_0);
    }

    var_1 = var_0.current_target;
    wait 0.5;
  }
}

function is_different_target(var_0, var_1) {
  return isDefined(var_0) && var_0 != var_1;
}

function target_select_think(var_0) {
  var_0 endon("death");
  var_0 endon("deactivate_enemy_turret");
  var_0.current_target = undefined;

  for(;;) {
    var_1 = scripts\cp\raid_utility::get_players_not_in_laststand();

    if(scripts\engine\utility::flag("enemy_turret_only_target_players_in_kill_zone")) {
      var_1 = get_players_in_killzone(var_1);
    }

    var_2 = 9;
    var_3 = undefined;

    foreach(var_5 in var_1) {
      var_6 = get_player_target_score(var_5, var_0);

      if(var_6 > var_2) {
        var_2 = var_6;
        var_3 = var_5;
      }
    }

    if(isDefined(var_3)) {
      var_0.current_target = var_3;
      var_0.target_ent.origin = get_target_ent_position_on_player(var_3, var_0);
    } else {
      var_0.current_target = undefined;
      var_0.target_ent.origin = var_0.target_ent_marker.origin;
    }

    wait 0.05;
  }
}

function get_players_in_killzone(var_0) {
  var_1 = [];
  var_2 = getEnt("bridge_kill_zone", "targetname");

  foreach(var_4 in var_0) {
    if(var_4 istouching(var_2)) {
      var_1 = var_4;
    }
  }

  return var_1;
}

function player_is_in_killzone(var_0) {
  var_1 = getEnt("bridge_kill_zone", "targetname");

  if(var_0 istouching(var_1)) {
    return 1;
  }

  return 0;
}

function get_target_ent_position_on_player(var_0, var_1) {
  var_2 = var_0 getvelocity();
  var_3 = var_1 gettagorigin("tag_flash");
  var_4 = distance(var_3, var_0.origin);
  var_5 = var_4 / 6000;
  var_6 = var_0.origin + var_2 * var_5;

  if(is_player_part_exposed_to_enemy_turret(var_0, var_1, "origin")) {
    return var_6;
  }

  return var_6 + var_0 getEye() - var_0.origin;
}

function get_player_target_score(var_0, var_1) {
  var_2 = 25000000;
  var_3 = 0;

  if(is_player_part_exposed_to_enemy_turret(var_0, var_1, "eye")) {
    var_3 += 45;
  }

  if(is_player_part_exposed_to_enemy_turret(var_0, var_1, "origin")) {
    var_3 += 45;
  }

  var_4 = distance2dsquared(var_0.origin, var_1.origin);
  var_3 += 9 * (1 - clamp(var_4 / var_2, 0, 1));
  return var_3;
}

function is_player_part_exposed_to_enemy_turret(var_0, var_1, var_2) {
  var_3 = var_1.player_exposure_data[var_0 getentitynumber()];
  return scripts\engine\utility::array_contains(var_3.loc_exposed_to_enemy_turret, var_2);
}

function player_monitor(var_0) {
  foreach(var_2 in level.players) {
    thread enemy_turret_player_monitor(var_2, var_2);
  }

  thread enemy_turret_players_connect_monitor(level);
}

function enemy_turret_players_connect_monitor(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("deactivate_enemy_turret");

  for(;;) {
    level waittill("connected", var_1);
    thread enemy_turret_player_monitor(var_1, var_1);
  }
}

function enemy_turret_player_monitor(var_0, var_1) {
  thread exposure_monitor(var_0, var_0);
  thread speed_monitor(var_0, var_0);
}

function exposure_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");
  var_1 endon("deactivate_enemy_turret");

  if(!isDefined(var_1.player_exposure_data)) {
    var_1.player_exposure_data = [];
  }

  var_2 = var_0 getentitynumber();
  var_3 = spawnStruct();
  var_4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
  var_3.exposed_to_enemy_turret_time = 0;

  for(;;) {
    var_3.loc_exposed_to_enemy_turret = [];

    if(scripts\engine\trace::ray_trace_passed(var_0.origin, var_1 gettagorigin("tag_aim"), [var_1], var_4)) {
      var_3.loc_exposed_to_enemy_turret[var_3.loc_exposed_to_enemy_turret.size] = "origin";
    }

    if(scripts\engine\trace::ray_trace_passed(var_0 getEye() + (0, 0, -5), var_1 gettagorigin("tag_aim"), [var_1], var_4)) {
      var_3.loc_exposed_to_enemy_turret[var_3.loc_exposed_to_enemy_turret.size] = "eye";
    }

    if(var_3.loc_exposed_to_enemy_turret.size > 0) {
      var_3.exposed_to_enemy_turret_time += 0.05;
    } else {
      var_3.exposed_to_enemy_turret_time = 0;
    }

    var_1.player_exposure_data[var_2] = var_3;
    waitframe();
  }
}

function speed_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");
  var_1 endon("deactivate_enemy_turret");

  for(;;) {
    var_2 = var_0.origin;
    wait 0.05;
    var_3 = var_0.origin;
    var_0.speed = length(var_2 - var_3);
  }
}

function enemy_turret_fire_think(var_0) {
  var_0 endon("death");
  var_0 endon("deactivate_enemy_turret");

  for(;;) {
    var_0 waittill("start_firing");
    reset_enemy_turret_shot_count(var_0);
    wait var_0.warning_time;

    while(enemy_turret_should_keep_firing(var_0)) {
      fire_one_shot(var_0);
      wait var_0.wait_between_shots;

      if(!should_continue_current_shot_run(var_0)) {
        if(get_shot_fired(var_0) == var_0.shots_per_round) {
          reset_enemy_turret_shot_count(var_0);
          wait var_0.wait_between_shot_round;
        }

        if(!enemy_turret_should_keep_firing(var_0)) {
          break;
        }
      }
    }
  }
}

function fire_one_shot(var_0) {
  var_0 shootturret();
  var_0.shot_count++;
}

function reset_enemy_turret_shot_count(var_0) {
  var_0.shot_count = 0;
}

function enemy_turret_should_keep_firing(var_0) {
  return istrue(var_0.keep_firing);
}

function start_firing(var_0) {
  var_0.keep_firing = 1;
  var_0 notify("start_firing");
}

function stop_firing(var_0) {
  var_0.keep_firing = 0;
}

function should_continue_current_shot_run(var_0) {
  if(!enemy_turret_should_keep_firing(var_0)) {
    return false;
  }

  if(get_shot_fired(var_0) == var_0.shots_per_round) {
    return false;
  }

  return true;
}

function get_shot_fired(var_0) {
  return var_0.shot_count;
}

function set_up_modular_spawning() {
  level endon("game_ended");

  if(!isDefined(level.ambientgroups)) {
    level.ambientgroups = [];
  }

  if(!isDefined(level.active_spawn_modules)) {
    level.active_spawn_modules = [];
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(getdvarint("scr_enemy_nospawn", 0) != 0) {
    return;
  }

  thread enemy_spawner_vehicle_spawned_monitor();

  if(level.script == "cp_blockade") {
    cp_blockade_spawning();
    return;
  }

  if(level.script == "cp_raid_phase1" || level.script == "cp_donetsk" || level.script == "cp_dntsk_raid") {
    cp_donetsk_spawning();
    return;
  }
}

function cp_donetsk_spawning() {
  scripts\cp\cp_modular_spawning::registerambientgroup("left_enemy_turret", 1, 1, 999999, [ &ref_143ce, 1, 10, 20], undefined, &select_left_turret_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("right_enemy_turret", 1, 1, 999999, [ &ref_143ce, 1, 10, 20], undefined, &select_right_turret_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("middle_enemy_turret", 1, 1, 999999, [ &ref_143ce, 1, 7, 15], undefined, &select_middle_turret_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("enemy_mortar", 1, 1, 999999, [ &ref_143ce, 1, 25, 35], undefined, &select_mortar_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("enemy_sniper", 1, &get_enemy_sniper_max_spawn, 999999, [ &ref_143ce, &get_enemy_sniper_max_spawn, 15, 25], undefined, &select_enemy_sniper_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("bomb_guardian", 1, 1, 1, 0.05, 0, "bomb_guardian_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("player_right_side", 2, 6, 6, 1, [ &wait_all_spawns_dead_and_time, 20, 35, "all_group_spawns_dead"], "player_right_side_spawner", &increase_script_maxdist, "player_right_side", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("player_left_side", 2, 6, 6, 1, [ &wait_all_spawns_dead_and_time, 20, 35, "all_group_spawns_dead"], "player_left_side_spawner", &increase_script_maxdist, "player_left_side", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("player_left_umike", 2, 8, 8, 0.05, undefined, "player_left_umike_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("player_right_umike", 2, 8, 8, 0.05, undefined, "player_right_umike_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("player_left_vindia", 2, 6, 6, 0.05, undefined, "player_left_vindia_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("player_right_vindia", 2, 6, 6, 0.05, undefined, "player_right_vindia_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mid_bridge_right", 1, &get_under_bridge_max_spawn, 999999, [ &waittill_num_and_all_spawns_dead_and_time, &get_under_bridge_max_spawn, 10, 20], undefined, &select_mid_bridge_right_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mid_bridge_left", 1, &get_under_bridge_max_spawn, 999999, [ &waittill_num_and_all_spawns_dead_and_time, &get_under_bridge_max_spawn, 10, 20], undefined, &select_mid_bridge_left_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("end_bridge_stair", 1, 2, 999999, 4.5, undefined, &select_end_bridge_stair_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("enemy_RPG", 1, &get_enemy_rpg_max_spawn, 9999999, [ &waittill_num_and_all_spawns_dead_and_time, &get_enemy_rpg_max_spawn, 15, 25], undefined, &select_enemy_rpg_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("enemy_right", 1, &get_enemy_right_max_spawn, 999999, 3.5, undefined, &select_enemy_right_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("enemy_left", 1, &get_enemy_left_max_spawn, 999999, 3.5, undefined, &select_enemy_left_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("under_bridge", 1, 3, 3, 1.5, [ &waittill_all_spawns_dead_and_time, 3, "underbridge_enemy_death", 5, 8], "under_bridge_spawner", &increase_script_maxdist, "under_bridge_reinforce", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("under_bridge_reinforce", 1, 2, 8, 3.5, undefined, &select_under_bridge_reinforce_spawners, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("enemy_fastrope", 6, 48, 12, 0.5, undefined, "enemy_fastrope_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("lbravo_carrier_hover", 8, 8, 8, 0.1, 0, "lbravo_carrier_hover", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("lbravo_carrier_hover_front", 3, 8, 8, 0.1, 0, "lbravo_carrier_hover_front", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("lbravo_carrier_hover_back", 3, 8, 8, 0.1, 0, "lbravo_carrier_hover_back", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("left_enemy_turret", &turret_enemy_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("right_enemy_turret", &turret_enemy_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("middle_enemy_turret", &turret_enemy_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bomb_guardian", &bomb_guardian_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("enemy_sniper", &activate_sniper);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mid_bridge_right", &bridge_stair_up_enemy);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mid_bridge_left", &bridge_stair_up_enemy);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("end_bridge_stair", &bridge_stair_up_enemy);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("enemy_mortar", &enemy_mortar_think);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("under_bridge", &underbridge_enemy_monitor);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("under_bridge_reinforce", &ref_13f04);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("enemy_right", &nocrouch);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("enemy_left", &nextswitch);
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("enemy_right");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("enemy_left");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("under_bridge_reinforce");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("mid_bridge_right");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("mid_bridge_left");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("end_bridge_stair");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("enemy_sniper");
  scripts\cp\cp_spawning_util::register_module_for_spawn_owner_disables("enemy_RPG");
  thread run_cp_donetsk_start_spawning();
}

function stop_all_spawn_groups() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("left_enemy_turret");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("right_enemy_turret");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("middle_enemy_turret");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bomb_guardian");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("player_right_side");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("player_left_side");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("player_left_umike");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("player_right_umike");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("mid_bridge_right");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("mid_bridge_left");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("end_bridge_stair");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("enemy_mortar");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("enemy_RPG");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("enemy_sniper");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("enemy_right");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("enemy_left");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("under_bridge");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("under_bridge_reinforce");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("enemy_fastrope");
}

function run_cp_donetsk_start_spawning() {
  scripts\engine\utility::flag_wait("vehicle_progression_flags_have_been_set_up");
  thread ref_12500();
  scripts\cp\cp_modular_spawning::run_spawn_module("left_enemy_turret");
  scripts\cp\cp_modular_spawning::run_spawn_module("right_enemy_turret");
  scripts\cp\cp_modular_spawning::run_spawn_module("middle_enemy_turret");
  scripts\cp\cp_modular_spawning::run_spawn_module("under_bridge");
  scripts\cp\cp_modular_spawning::run_spawn_module("bomb_guardian");
  scripts\engine\utility::flag_wait("vehicle_entered_bridge");
  scripts\cp\cp_modular_spawning::run_spawn_module("enemy_mortar");
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_one");
  scripts\cp\cp_modular_spawning::run_spawn_module("enemy_right");
  scripts\cp\cp_modular_spawning::run_spawn_module("enemy_left");
  scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_carrier_hover");
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_two");
  scripts\cp\cp_modular_spawning::run_spawn_module("enemy_sniper");
  scripts\cp\cp_modular_spawning::run_spawn_module("enemy_fastrope");
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_three");
  scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_carrier_hover_front");
  scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_carrier_hover_back");
  thread shrink_poi();
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_four");
  scripts\cp\cp_modular_spawning::run_spawn_module("mid_bridge_right");
  scripts\cp\cp_modular_spawning::run_spawn_module("mid_bridge_left");
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_five");
  scripts\cp\cp_modular_spawning::run_spawn_module("end_bridge_stair");
}

function shrink_poi() {
  level endon("game_ended");
  level endon("blockade_sequence_successful");
  thread wassquadspawned();

  for(;;) {
    level waittill("laststand_dogtag_spawned", var_0);
    var_1 = var_0.owner;
    thread ref_12d12(var_1);

    if(triggerremoveobjectivetext(var_0)) {
      if(!buy_points()) {
        scripts\engine\utility::flag_set("heavy_enemy_spawning_paused");
        thread ref_124de();
        scripts\engine\utility::flag_waitopen("heavy_enemy_spawning_paused");
      }
    }
  }
}

function ref_124de() {
  level endon("game_ended");
  level endon("blockade_sequence_successful");
  level endon("heavy_enemy_spawning_paused");
  level waittill("vehicle_is_being_pushed");
  scripts\engine\utility::flag_clear("heavy_enemy_spawning_paused");
}

function ref_12d12(var_0) {
  var_1 = 20;
  var_2 = var_0 scripts\engine\utility::ref_143ad("revive", "disconnect");

  if(var_2 == "revive") {
    wait var_1;
    scripts\engine\utility::flag_clear("heavy_enemy_spawning_paused");
    return;
  }

  if(var_2 == "disconnect") {
    var_3 = questrewarduav();

    if(var_3 == 0) {
      scripts\engine\utility::flag_clear("heavy_enemy_spawning_paused");
      return;
    }

    return;
  }
}

function wassquadspawned() {
  level endon("game_ended");
  level endon("blockade_sequence_successful");
  level.watch_and_open_scriptable_doors_in_radius = [];

  for(;;) {
    level waittill("laststand_dogtag_spawned", var_0);
    level.watch_and_open_scriptable_doors_in_radius = scripts\engine\utility::array_removeundefined(level.watch_and_open_scriptable_doors_in_radius);
    level.watch_and_open_scriptable_doors_in_radius = scripts\engine\utility::array_add(level.watch_and_open_scriptable_doors_in_radius, var_0);
  }
}

function questrewarduav() {
  var_0 = 0;

  foreach(var_2 in level.watch_and_open_scriptable_doors_in_radius) {
    if(triggerremoveobjectivetext(var_2)) {
      var_0++;
    }
  }

  return var_0;
}

function buy_points() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    if(triggerremoveobjectivetext(var_2)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

function triggerremoveobjectivetext(var_0) {
  var_1 = getEnt("bridge_kill_zone", "targetname");
  var_2 = getEnt("under_bridge_zone", "targetname");

  if(ispointinvolume(var_0.origin, var_1)) {
    return true;
  }

  if(ispointinvolume(var_0.origin, var_2)) {
    return true;
  }

  return false;
}

function ref_12500() {
  var_0 = ["player_left_vindia", "player_right_vindia"];

  for(var_1 = 5; var_1 > 0; var_1--) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  for(;;) {
    if(any_player_under_bridge()) {
      break;
    }

    wait 1;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module(var_0[0]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_five");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_0[1]);
}

function underbridge_enemy_monitor(var_0) {
  var_1 = self;
  c4vehiclecooperator(var_1);
  thread underbridge_enemy_death_monitor(var_1);
}

function ref_13f04(var_0) {
  var_1 = self;
  c4vehiclecooperator(var_1);
}

function nocrouch(var_0) {
  var_1 = self;
  c4vehiclecooperator(var_1);
}

function nextswitch(var_0) {
  var_1 = self;
  c4vehiclecooperator(var_1);
}

function c4vehiclecooperator(var_0) {
  var_0.maxfaceenemydist = 1200;
  var_0 scripts\cp\cp_modular_spawning::numfound();
}

function underbridge_enemy_death_monitor(var_0) {
  var_0 waittill("death");
  level notify("underbridge_enemy_death");
}

function waittill_all_spawns_dead_and_time(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");

  if(isbuiltinfunction(var_1)) {
    var_5 = [[var_1]]();
  } else {
    var_5 = var_2;
  }

  var_6 = 0;

  for(;;) {
    level waittill(var_3);
    var_6++;

    if(var_6 == var_5) {
      break;
    }
  }

  return randomfloatrange(var_4, var_5);
}

function get_enemy_right_max_spawn(var_0) {
  if(scripts\engine\utility::flag("vehicle_bridge_stage_five")) {
    return 4;
  }

  if(scripts\engine\utility::flag("vehicle_bridge_stage_four")) {
    return 3;
  }

  return 2;
}

function get_enemy_left_max_spawn(var_0) {
  if(scripts\engine\utility::flag("vehicle_bridge_stage_five")) {
    return 5;
  }

  if(scripts\engine\utility::flag("vehicle_bridge_stage_four")) {
    return 4;
  }

  return 3;
}

function get_under_bridge_max_spawn(var_0) {
  if(scripts\engine\utility::flag("vehicle_bridge_stage_five")) {
    return 2;
  }

  return 1;
}

function get_enemy_rpg_max_spawn(var_0) {
  if(scripts\engine\utility::flag("vehicle_bridge_stage_three")) {
    return 2;
  }

  return 1;
}

function get_enemy_sniper_max_spawn(var_0) {
  if(scripts\engine\utility::flag("vehicle_bridge_stage_two")) {
    return 2;
  }

  return 1;
}

function select_left_turret_spawners(var_0) {
  if(true) {
    return scripts\cp\raid_utility::select_random_spawners("left_manned_turret_spawner");
  }

  return scripts\cp\raid_utility::select_random_spawners("left_enemy_turret_spawner");
}

function select_right_turret_spawners(var_0) {
  if(true) {
    return scripts\cp\raid_utility::select_random_spawners("right_manned_turret_spawner");
  }

  return scripts\cp\raid_utility::select_random_spawners("right_enemy_turret_spawner");
}

function select_middle_turret_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("middle_enemy_turret_spawner");
}

function select_enemy_right_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("enemy_right_spawner");
}

function select_enemy_left_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("enemy_left_spawner");
}

function select_under_bridge_reinforce_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("under_bridge_reinforce_spawner");
}

function select_mid_bridge_right_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("mid_bridge_right_spawner");
}

function select_mid_bridge_left_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("mid_bridge_left_spawner");
}

function select_end_bridge_stair_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("end_bridge_stair_spawner");
}

function select_enemy_sniper_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("enemy_sniper_spawner");
}

function select_enemy_rpg_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("blockade_RPG_spawner");
}

function select_mortar_spawners(var_0) {
  return scripts\cp\raid_utility::select_random_spawners("mortar_spawner");
}

function left_turret_wait_between_spawn(var_0) {
  return randomfloatrange(5, 10);
}

function cp_blockade_spawning() {
  scripts\cp\cp_modular_spawning::registerambientgroup("player_right_building", 8, 8, 8, 0.05, 0, "player_right_building_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("player_left_building", 2, 2, 2, 0.05, 0, "player_left_building_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("left_enemy_turret", 0, 1, undefined, [ &wait_all_spawns_dead_and_time, 5, 10, "active_all_group_spawns_dead"], 0, "left_enemy_turret_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("right_enemy_turret", 0, 1, undefined, [ &wait_all_spawns_dead_and_time, 5, 10, "active_all_group_spawns_dead"], 0, "right_enemy_turret_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("bomb_guardian", 1, 1, 1, 0.05, 0, "bomb_guardian_spawner", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("player_right_side", 2, 5, 5, 0.05, [ &wait_all_spawns_dead_and_time, 15, 30, "all_group_spawns_dead"], "player_right_side_spawner", &increase_script_maxdist, "player_right_side", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("player_left_side", 2, 5, 5, 0.05, [ &wait_all_spawns_dead_and_time, 15, 30, "all_group_spawns_dead"], "player_left_side_spawner", &increase_script_maxdist, "player_left_side", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mid_bridge", 2, 3, 3, 0.05, [ &wait_all_spawns_dead, 20, 30], "mid_bridge_spawner", &increase_script_maxdist, "mid_bridge", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("end_bridge", 2, 3, 3, 0.05, [ &wait_all_spawns_dead, 20, 30], "end_bridge_spawner", &increase_script_maxdist, "end_bridge", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("old_bridge", 2, 5, 5, 0.05, [ &wait_all_spawns_dead, 10, 20], "old_bridge_spawner", &increase_script_maxdist, "old_bridge", undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("right_RPG", 0, 1, undefined, [ &wait_all_spawns_dead_and_time, 15, 25, "active_all_group_spawns_dead"], 1.5, "right_RPG_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("left_RPG", 0, 1, undefined, [ &wait_all_spawns_dead_and_time, 15, 25, "active_all_group_spawns_dead"], 1.5, "left_RPG_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mid_RPG", 0, 1, undefined, [ &wait_all_spawns_dead_and_time, 15, 25, "active_all_group_spawns_dead"], 1.5, "mid_RPG_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("right_mortar", 0, 1, undefined, [ &wait_all_spawns_dead_and_time, 20, 30, "active_all_group_spawns_dead"], 1.5, "right_mortar_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("left_mortar", 0, 1, undefined, [ &wait_all_spawns_dead_and_time, 20, 30, "active_all_group_spawns_dead"], 1.5, "left_mortar_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("mid_sniper", 0, 1, undefined, [ &wait_all_spawns_dead_and_time, 20, 30, "active_all_group_spawns_dead"], 1.5, "mid_sniper_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("left_sniper", 0, 1, undefined, [ &wait_all_spawns_dead_and_time, 20, 30, "active_all_group_spawns_dead"], 1.5, "left_sniper_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("right_sniper", 0, 1, undefined, [ &wait_all_spawns_dead_and_time, 20, 20, "active_all_group_spawns_dead"], 1.5, "right_sniper_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("enemy_right", 1, 2, undefined, [ &wait_all_spawns_dead_and_time, 5, 10, "active_all_group_spawns_dead"], 1.5, "enemy_right_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("enemy_left", 1, 3, undefined, [ &waittill_num_and_all_spawns_dead_and_time, 3, 5, 10], 1.5, "enemy_left_spawner", &increase_script_maxdist, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("left_enemy_turret", &turret_enemy_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("right_enemy_turret", &turret_enemy_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bomb_guardian", &bomb_guardian_watcher);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("right_sniper", &activate_sniper);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("left_sniper", &activate_sniper);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mid_sniper", &activate_sniper);
  thread run_cp_blockade_start_spawning();
}

function wait_no_vehicles_and_time(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 waittill("vehicle_removed_from_group");
  wait randomfloatrange(var_1, var_2);
}

function wait_all_spawns_dead(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 waittill("all_group_spawns_dead");
}

function ref_143ce(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  if(isbuiltinfunction(var_1)) {
    var_4 = [[var_1]]();
  } else {
    var_4 = var_2;
  }

  if(var_1.spawn_count % var_4 == 0) {
    if(var_1 scripts\cp\cp_modular_spawning::get_activecount_from_group(1) > 0) {
      var_1 waittill("active_all_group_spawns_dead");

      if(scripts\engine\utility::flag("heavy_enemy_spawning_paused")) {
        scripts\engine\utility::flag_waitopen("heavy_enemy_spawning_paused");
      }

      return randomfloatrange(var_3, var_4);
    }

    return 1.5;
  }

  return 1.5;
}

function waittill_num_and_all_spawns_dead_and_time(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  if(isbuiltinfunction(var_1)) {
    var_4 = [[var_1]]();
  } else {
    var_4 = var_2;
  }

  if(var_1.spawn_count % var_4 == 0) {
    if(var_1 scripts\cp\cp_modular_spawning::get_activecount_from_group(1) > 0) {
      var_1 waittill("active_all_group_spawns_dead");
      return randomfloatrange(var_3, var_4);
    }

    return 1.5;
  }

  return 1.5;
}

function wait_all_spawns_dead_and_time(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 waittill(var_3);
  wait randomfloatrange(var_1, var_2);
}

function run_cp_blockade_start_spawning() {
  wait 5;
  scripts\cp\cp_modular_spawning::run_spawn_module("left_enemy_turret");
  scripts\cp\cp_modular_spawning::run_spawn_module("right_enemy_turret");
  scripts\cp\cp_modular_spawning::run_spawn_module("bomb_guardian");
  var_0 = get_player_side_spawn_group_randomized();
  var_1 = get_rpg_group_randomized();
  var_2 = get_mortar_group_randomized();
  var_3 = get_sniper_group_randomized();
  var_4 = get_enemy_group_randomized();
  scripts\engine\utility::flag_wait("vehicle_entered_bridge");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_1[0]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_one");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_0[0]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_1[1]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_two");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_0[1]);
  scripts\cp\cp_modular_spawning::run_spawn_module("mid_bridge");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_3[0]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_1[2]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_three");
  scripts\cp\cp_modular_spawning::run_spawn_module("end_bridge");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_3[1]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_four");
  scripts\cp\cp_modular_spawning::run_spawn_module("old_bridge");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_4[0]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_3[2]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_2[0]);
  activate_mortar(var_2[0]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_five");
  scripts\cp\cp_modular_spawning::run_spawn_module(var_4[1]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_2[1]);
  activate_mortar(var_2[1]);
}

function get_player_side_spawn_group_randomized() {
  return get_randomized_group(["player_right_side", "player_left_side"]);
}

function get_rpg_group_randomized() {
  return get_randomized_group(["right_RPG", "left_RPG", "mid_RPG"]);
}

function get_mortar_group_randomized() {
  return get_randomized_group(["right_mortar", "left_mortar"]);
}

function get_sniper_group_randomized() {
  return get_randomized_group(["right_sniper", "left_sniper", "mid_sniper"]);
}

function get_enemy_group_randomized() {
  return get_randomized_group(["enemy_right", "enemy_left"]);
}

function activate_mortar(var_0) {
  var_1 = getEnt(var_0, "targetname");
  thread mortar_think(var_1);
}

function mortar_think(var_0) {
  var_0 endon("stop_mortar_think");
  var_0.targets = undefined;

  for(;;) {
    var_1 = scripts\cp\raid_utility::get_players_not_in_laststand();
    var_1 = get_players_in_killzone(var_1);

    if(var_1.size > 0) {
      var_0.targets = var_1;
      scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_mortar(var_0);
      var_0.targets = undefined;
      wait randomintrange(5, 10);
      continue;
    }

    wait 1;
  }
}

function get_randomized_group(var_0) {
  for(var_1 = 0; var_1 < 5; var_1++) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}

function bridge_stair_up_enemy(var_0) {
  var_1 = self;
  thread bridge_stair_up_combat_think(var_1);
}

function bridge_stair_up_combat_think(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = self;
  var_1 waittill("reached_path_end");

  if(any_player_under_bridge()) {
    thread go_hunt_down_player(var_1, var_1);
    return;
  }

  thread go_hunt_down_player(var_1, var_1);
}

function activate_sniper(var_0) {
  var_1 = self;
  var_1.neverforcesnipermissenemy = 1;
  var_1.sniperaccuracyset = 1;
  var_1.baseaccuracy = 1;
  var_1 laseron();
  c4vehiclecooperator(var_1);
  thread delay_activate_laser(var_1);
}

function activate_mortar_enemy(var_0) {
  var_1 = self;
  var_1.dontevershoot = 1;
}

function delay_activate_laser(var_0) {
  var_0 endon("death");
  var_0 scripts\engine\utility::ref_143a5("goal", "goal_reached");
  var_0.gunposeoverride = "ads";
  thread sniper_player_monitor(var_0);
  thread sniper_target_think(var_0);
  thread sniper_laser_think(var_0);
}

function sniper_player_monitor(var_0) {
  foreach(var_2 in level.players) {
    thread enemy_sniper_player_monitor(var_2, var_2);
  }

  thread sniper_players_connect_monitor(level);
}

function sniper_players_connect_monitor(var_0) {
  level endon("game_ended");
  var_0 endon("death");

  for(;;) {
    level waittill("connected", var_1);
    thread enemy_sniper_player_monitor(var_1, var_1);
  }
}

function enemy_sniper_player_monitor(var_0, var_1) {
  thread exposure_to_sniper_monitor(var_0, var_0);
}

function exposure_to_sniper_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");

  if(!isDefined(var_1.player_exposure_data)) {
    var_1.player_exposure_data = [];
  }

  var_2 = var_0 getentitynumber();
  var_3 = spawnStruct();
  var_4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
  var_3.exposed_to_enemy_sniper_time = 0;

  for(;;) {
    var_3.loc_exposed_to_enemy_sniper = [];

    if(scripts\engine\trace::ray_trace_passed(var_0.origin, var_1 getEye(), [var_1], var_4)) {
      var_3.loc_exposed_to_enemy_sniper[var_3.loc_exposed_to_enemy_sniper.size] = "origin";
    }

    if(scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), [var_1], var_4)) {
      var_3.loc_exposed_to_enemy_sniper[var_3.loc_exposed_to_enemy_sniper.size] = "eye";
    }

    if(scripts\engine\trace::ray_trace_passed(var_0 gettagorigin("j_spineupper"), var_1 getEye(), [var_1], var_4)) {
      var_3.loc_exposed_to_enemy_sniper[var_3.loc_exposed_to_enemy_sniper.size] = "chest";
    }

    if(var_3.loc_exposed_to_enemy_sniper.size > 0) {
      var_3.exposed_to_enemy_sniper_time += 0.05;
    } else {
      var_3.exposed_to_enemy_sniper_time = 0;
    }

    var_1.player_exposure_data[var_2] = var_3;
    waitframe();
  }
}

function sniper_target_think(var_0) {
  var_0 endon("death");
  var_0.current_target = undefined;

  for(;;) {
    var_1 = scripts\cp\raid_utility::get_players_not_in_laststand();
    var_2 = 9;
    var_3 = undefined;

    foreach(var_5 in var_1) {
      if(!isDefined(var_5.num_sniper_covering_me)) {
        var_5.num_snipers_covering_me = 0;
      }

      var_6 = get_player_target_score_for_sniper(var_5, var_0);

      if(var_6 > var_2) {
        var_2 = var_6;
        var_3 = var_5;
      }
    }

    if(isDefined(var_3) && is_new_target(var_3, var_0)) {
      if(has_current_target(var_0)) {
        wait randomfloatrange(0.5, 1);
        unmark_player_as_sniper_target(var_0.current_target);
      }

      mark_player_as_sniper_target(var_0, var_3);
      thread sniper_death_monitor(var_3, var_3);
      var_8 = var_3 scripts\engine\utility::ref_143b9(randomfloatrange(1.5, 2), "last_stand");

      if(var_8 == "last_stand") {
        unmark_player_as_sniper_target(var_3);
        wait 1.5;
      }

      continue;
    }

    wait 0.05;
  }
}

function has_current_target(var_0) {
  return isDefined(var_0.current_target);
}

function is_new_target(var_0, var_1) {
  if(!has_current_target(var_1)) {
    return true;
  }

  return var_1.current_target != var_0;
}

function mark_player_as_sniper_target(var_0, var_1) {
  var_0.current_target = var_1;
  var_0 getenemyinfo(var_1);
  var_0 setlookatentity(var_1);
  var_0.favoriteenemy = var_1;
  var_1.num_snipers_covering_me += 1;
}

function unmark_player_as_sniper_target(var_0) {
  var_0.num_snipers_covering_me -= 1;
}

function sniper_death_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 waittill("death");
  unmark_player_as_sniper_target(var_0);
}

function get_player_target_score_for_sniper(var_0, var_1) {
  var_2 = 25000000;
  var_3 = 0;

  if(is_player_part_exposed_to_sniper(var_0, var_1, "eye")) {
    var_3 += 45;
  }

  if(is_player_part_exposed_to_sniper(var_0, var_1, "origin")) {
    var_3 += 45;
  }

  if(player_is_in_killzone(var_0)) {
    var_3 += 200;
  }

  var_4 = get_player_expose_time_to_sniper(var_0, var_1);
  var_3 += var_4 * 10;
  var_3 = int(max(0, var_3 + var_0.num_snipers_covering_me * -45));
  var_5 = distance2dsquared(var_0.origin, var_1.origin);
  var_3 += 9 * (1 - clamp(var_5 / var_2, 0, 1));
  var_3 += randomfloat(18);
  return var_3;
}

function is_player_part_exposed_to_sniper(var_0, var_1, var_2) {
  var_3 = var_1.player_exposure_data[var_0 getentitynumber()];
  return scripts\engine\utility::array_contains(var_3.loc_exposed_to_enemy_sniper, var_2);
}

function get_player_expose_time_to_sniper(var_0, var_1) {
  var_2 = var_1.player_exposure_data[var_0 getentitynumber()];
  return var_2.exposed_to_enemy_sniper_time;
}

function sniper_laser_think(var_0) {
  var_0 endon("death");
  var_1 = var_0 gettagorigin("tag_laser_attach");
  var_2 = create_tag_origin(var_1, var_0);
  thread follow_tag_laser_attach(var_2, var_0);
  var_3 = create_tag_origin(var_1, var_0);
  var_0.laser_start_ent = var_2;
  var_0.laser_end_ent = var_3;
  thread waittill_any_return_no_endon_death_2(var_0);

  for(;;) {
    if(has_current_target(var_0)) {
      if(player_is_exposed_to_sniper(var_0.current_target, var_0)) {
        if(!istrue(var_3.is_linked_to_target)) {
          var_4 = get_target_tag_to_link_to(var_0.current_target, var_0);
          var_5 = var_0.current_target gettagorigin(var_4);
          var_3.origin = var_5;
          var_3 linkTo(var_0.current_target, var_4);
          var_3.is_linked_to_target = 1;
        }
      } else {
        var_3 unlink();
        var_3.is_linked_to_target = 0;
        var_6 = get_laser_end_pos(var_0.current_target, var_2);
        var_3 moveTo(var_6, 0.25);
      }
    }

    wait 0.05;
  }
}

function waittill_any_return_no_endon_death_2(var_0) {
  var_0 endon("death");
  ref_13e50(var_0);

  for(;;) {
    if(!ref_1343b(var_0) && ref_1343c(var_0)) {
      ref_13e50(var_0);
    } else if(ref_1343b(var_0) && !ref_1343c(var_0)) {
      ref_13e43(var_0);
    }

    waitframe();
  }
}

function ref_13e50(var_0) {
  var_1 = playfxontagsbetweenclients(level._effect["sniper_red_laser"], var_0.laser_start_ent, "tag_origin", var_0.laser_end_ent, "tag_origin");
  var_0.ref_1343d = var_1;
}

function ref_13e43(var_0) {
  var_0.ref_1343d delete();
}

function ref_1343b(var_0) {
  return isDefined(var_0.ref_1343d);
}

function ref_1343c(var_0) {
  var_1 = 0.5;
  var_2 = anglesToForward(var_0 getplayerangles());
  var_3 = vectorNormalize(var_0.laser_end_ent.origin - var_0.laser_start_ent.origin);
  var_4 = vectordot(var_3, var_2);

  if(var_4 < var_1) {
    return false;
  }

  var_5 = var_0 getcurrentweapon();

  if(var_5.classname != "sniper") {
    return false;
  }

  return true;
}

function get_target_tag_to_link_to(var_0, var_1) {
  if(is_player_part_exposed_to_sniper(var_0, var_1, "chest")) {
    return "j_spineupper";
  }

  if(is_player_part_exposed_to_sniper(var_0, var_1, "eye")) {
    return "tag_eye";
  }

  return "tag_origin";
}

function follow_tag_laser_attach(var_0, var_1) {
  var_1 endon("death");

  for(;;) {
    if(var_0 tagexists("tag_laser_attach")) {
      var_2 = var_0 gettagorigin("tag_laser_attach");
      var_1.origin = var_2;
    }

    waitframe();
  }
}

function try_shoot_at_current_target(var_0, var_1) {
  var_2 = var_0.current_target;

  if(!isDefined(var_2.time_stamp_can_be_damaged_by_sniper)) {
    var_2.time_stamp_can_be_damaged_by_sniper = 0;
  }

  if(player_can_take_sniper_damage(var_2) && player_expose_to_sniper_long_enough(var_2, var_0)) {
    var_3 = var_2.origin - var_1.origin;
    playFX(level._effect["sniper_muzzle_flash"], var_1.origin, var_3);
    var_0 playSound("sniper_crack_far_near_cp");
    var_2 dodamage(80, var_0.origin, var_0);
    set_next_can_take_sniper_damage_time_stamp(var_2);
    return;
  }
}

function player_can_take_sniper_damage(var_0) {
  var_1 = gettime();
  return var_1 > var_0.time_stamp_can_be_damaged_by_sniper;
}

function set_next_can_take_sniper_damage_time_stamp(var_0) {
  var_1 = gettime();
  var_0.time_stamp_can_be_damaged_by_sniper = var_1 + randomfloatrange(3, 4) * 1000;
}

function player_expose_to_sniper_long_enough(var_0, var_1) {
  return get_player_expose_time_to_sniper(var_0, var_1) >= 1;
}

function mark_laser_end_ent(var_0) {
  var_0 endon("death");

  for(;;) {
    waitframe();
  }
}

function get_laser_end_pos(var_0, var_1) {
  var_2 = 40;
  var_3 = 2;
  var_4 = 40;
  var_5 = 50;
  var_6 = 25;
  var_7 = 35;
  var_8 = 10;
  var_9 = 5;
  var_10 = anglesToForward(var_0 getplayerangles());
  var_11 = var_0 getEye() + var_10 * var_2;
  var_11 = (var_11[0] + randomfloatrange(var_3 * -1, var_3), var_11[1] + randomfloatrange(var_3 * -1, var_3), var_11[2]);
  var_11 = scripts\engine\utility::drop_to_ground(var_11, 0, -500);
  var_12 = var_0 getstance();

  switch (var_12) {
    case "stand":
      var_11 = (var_11[0], var_11[1], var_11[2] + randomfloatrange(var_4, var_5));
      break;
    case "prone":
    case "crouch":
      var_11 = (var_11[0], var_11[1], var_11[2] + randomfloatrange(var_6, var_7));
      break;
  }

  var_13 = vectorNormalize(var_11 - var_1.origin);
  var_14 = var_1.origin + var_13 * 20000;
  var_15 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
  var_11 = scripts\engine\trace::ray_trace(var_1.origin, var_14, undefined, var_15);

  if(player_is_near_vehicle_to_push(var_0)) {
    if(player_is_facing_away_from_vehicle_to_push(var_0)) {
      var_16 = var_11["position"] + (0, 0, 21);
      var_17 = vectorNormalize(var_16 - var_1.origin);
      var_18 = anglestoright(vectortoangles(var_17));
      var_16 += var_18 * randomfloatrange(var_8 * -1, var_8);
      var_17 = vectorNormalize(var_16 - var_1.origin);
      var_14 = var_1.origin + var_17 * 20000;
      var_15 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
      var_11 = scripts\engine\trace::ray_trace(var_1.origin, var_14, undefined, var_15);
    } else if(player_is_facing_vehicle_to_push(var_0)) {
      var_16 = var_11["position"] + (0, 0, 23);
      var_17 = vectorNormalize(var_16 - var_1.origin);
      var_18 = anglestoright(vectortoangles(var_17));
      var_16 += var_18 * randomfloatrange(var_9 * -1, var_9);
      var_17 = vectorNormalize(var_16 - var_1.origin);
      var_14 = var_1.origin + var_17 * 20000;
      var_15 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
      var_11 = scripts\engine\trace::ray_trace(var_1.origin, var_14, undefined, var_15);
    }
  }

  return var_11["position"];
}

function player_is_near_vehicle_to_push(var_0) {
  if(istrue(var_0.is_pushing_vehicle)) {
    return true;
  }

  if(!isDefined(level.vehicle_to_push)) {
    return false;
  }

  return distance2dsquared(var_0.origin, level.vehicle_to_push.origin) <= 40000;
}

function player_is_facing_away_from_vehicle_to_push(var_0) {
  var_1 = anglesToForward(var_0 getplayerangles());
  var_2 = anglesToForward(level.vehicle_to_push.angles);
  var_3 = var_2 * -1;
  var_4 = acos(vectordot(var_1, var_3));
  return abs(var_4) < 75;
}

function player_is_facing_vehicle_to_push(var_0) {
  var_1 = anglesToForward(var_0 getplayerangles());
  var_2 = anglesToForward(level.vehicle_to_push.angles);
  var_3 = acos(vectordot(var_1, var_2));
  return abs(var_3) < 80;
}

function player_is_exposed_to_sniper(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  return var_1.player_exposure_data[var_2].exposed_to_enemy_sniper_time > 0;
}

function create_tag_origin(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin");
  thread clean_up_think(var_2, var_2);
  return var_2;
}

function clean_up_think(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

function bomb_guardian_watcher(var_0) {
  var_1 = self;
  thread bomb_guardian_death_watcher_internal(var_1);
}

function bomb_guardian_death_watcher_internal(var_0) {
  var_0 waittill("death");
  scripts\cp\bomb_defusal\coop_bomb_defusal::drop_bomb_detonator_from_ai(var_0, "bomb_case");
  level.bomb_guardian_is_killed = 1;
}

function turret_enemy_watcher(var_0) {
  thread ref_13e67(var_0);
}

function ref_13e67(var_0) {
  var_1 = self;
  wait 0.05;
  var_1 notify("basic_combat");

  if(isDefined(var_1.spawnpoint) && issubstr(var_1.spawnpoint.targetname, "manned_turret")) {
    if(isDefined(var_1.spawnpoint.target)) {
      var_2 = scripts\engine\utility::getStruct(var_1.spawnpoint.target, "targetname");

      if(isDefined(var_2)) {
        var_1 setgoalpos(var_2.origin);
        var_1.script_origin_other = var_2.origin;
      }
    }

    var_1.goalradius = 64;
    var_1 allowedstances("stand");
    var_1.combatmode = "no_cover";
    return;
  }

  var_1.goalradius = 10;
  var_1.dontevershoot = 1;
  thread activate_enemy_turret_when_reach_it(var_1);
}

function enemy_mortar_think(var_0) {
  var_1 = self;
  c4vehiclecooperator(var_1);
  thread activate_mortar_when_reach_path_end(var_1);
}

function activate_mortar_when_reach_path_end(var_0) {
  var_0 endon("death");
  level endon("post_blockade_combat");

  if(scripts\engine\utility::flag("post_blockade_combat")) {
    thread go_hunt_down_player(var_0, var_0);
    return;
  }

  var_0 waittill("reached_path_end");
  var_1 = scripts\engine\utility::getclosest(var_0.origin, getEntArray("enemy_mortar", "targetname"));
  var_0.ignoreall = 1;
  thread mortar_think(var_1);
  thread mortar_enemy_death_watcher(var_0, var_0);
}

function mortar_enemy_death_watcher(var_0, var_1) {
  var_0 waittill("death");
  var_1 notify("stop_mortar_think");
  var_1.targets = undefined;
}

function activate_enemy_turret_when_reach_it(var_0) {
  var_0 endon("death");
  level endon("post_blockade_combat");
  var_0 scripts\engine\utility::ref_143a5("goal", "goal_reached");
  var_1 = scripts\engine\utility::getclosest(var_0.origin, level.enemy_turrets);
  activate_enemy_turret(var_1);
  var_0 allowedstances("stand");
  var_0 setlookatentity(var_1);
  var_0.ignoreall = 1;
  var_0.combatmode = "no_cover";
  link_to_turret_enemy_mover(var_0, var_0);
  thread death_monitor(var_0, var_0);
}

function link_to_turret_enemy_mover(var_0) {
  var_1 = scripts\engine\utility::getStructArray("turret_enemy_struct", "targetname");
  var_2 = scripts\engine\utility::getclosest(var_0.origin, var_1, 100000);
  var_2.origin = var_0.origin;
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("tag_origin");
  var_3.angles = var_2.angles;
  var_0.angles = var_3.angles;
  var_0 linkTo(var_3, "tag_origin");
  var_0.wztrain_info = var_3;
  thread turret_enemy_mover_clean_up(var_3, var_3);
}

function turret_enemy_mover_clean_up(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

function death_monitor(var_0, var_1) {
  var_0 waittill("death");
  deactivate_enemy_turret(var_1);
}

function enemy_spawner_vehicle_spawned_monitor() {
  level endon("game_ended");
  level.enemy_spawner_vehicles = [];

  for(;;) {
    level waittill("vehicle_spawned", var_0, var_1);

    if(scripts\engine\utility::array_contains(level.enemy_spawner_vehicles, var_1)) {
      continue;
    }

    level.enemy_spawner_vehicles[level.enemy_spawner_vehicles.size] = var_1;

    switch (var_0.group_name) {
      case "old_bridge":
      case "end_bridge":
      case "mid_bridge":
      case "player_left_side":
      case "player_right_side":
        thread enemy_spawner_vehicle_think(var_1, var_1);
        break;
      case "player_right_umike":
      case "player_left_umike":
        thread enemy_spawner_umike_think(var_1, var_1);
        break;
      case "enemy_fastrope":
      case "player_right_vindia":
      case "player_left_vindia":
        thread enemy_back_line_spawner_think(var_1, var_1);
        break;
      case "lbravo_carrier_hover":
        thread watchgastrapdamage(var_1, var_1);
        break;
      case "lbravo_carrier_hover_front":
        thread watchgastrapdamage(var_1, var_1);
        break;
      case "lbravo_carrier_hover_back":
        thread watchgastrapdamage(var_1, var_1);
        break;
    }
  }
}

function enemy_back_line_spawner_think(var_0, var_1) {
  var_0 endon("death");
  var_0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_damage_monitor(var_0, 500000);
  wait 10;
  var_2 = var_0.riders;
  var_0 waittill("unloading");
  thread infil_enemies_attack_logic(var_0, var_2);
}

function get_infil_rider_start_targetname(var_0) {
  switch (var_0) {
    case "enemy_fastrope":
      return &get_mindia_infil_rider_start_targetname;
    case "player_left_vindia":
      return &get_left_vindia_infil_rider_start_targetname;
    case "player_right_vindia":
      return &get_right_vindia_infil_rider_start_targetname;
  }
}

function infil_enemies_attack_logic(var_0, var_1) {
  foreach(var_3 in var_0) {
    thread infil_enemy_combat_logic(var_3, var_3);
  }
}

function infil_enemy_combat_logic(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("jumpedout");
  var_0 waittill("large_footstep");
  wait 0.1;
  var_2 = getgroundposition(var_0.origin, 25, 256, 256);

  if(var_2 != var_0.origin) {
    var_0 forceteleport(var_2, var_0.angles, 256);
  }

  thread ref_11e5e(level, var_0.origin, var_0.angles);
  var_0.nocorpse = 1;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_0, var_0, "MOD_SUICIDE");
}

function ref_11e5e(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = var_1;
  var_3.script_forcespawn = 1;
  var_3.script_noteworthy = "riotshield";
  var_4 = var_3 scripts\cp\cp_modular_spawning::spawn_ai();
  var_4 endon("death");

  if(scripts\engine\utility::flag("post_blockade_combat")) {
    thread ref_127f2(var_4);
    return;
  }

  var_4.never_kill_off = 1;
  var_4.dontkilloff = 1;
  var_4.ignoreall = 0;
  var_4.skip_clear_kill_off_flag = 1;
  advance_through_struct_path(var_4, var_4, [[var_2]]());
}

function get_mindia_infil_rider_start_targetname() {
  var_0 = ["police_station_one", "police_station_two", "police_station_three", "police_station_four", "office_one", "office_two", "storage_one", "storage_two", "storage_three", "attacker_one", "attacker_two", "bridge_one", "bridge_two"];

  if(!isDefined(level.mindia_infil_start_targetname_array)) {
    level.mindia_infil_start_targetname_array = randomize_start_targetname_array(var_0);
    level.mindia_infil_start_targetname_array_index = 0;
  }

  var_1 = level.mindia_infil_start_targetname_array[level.mindia_infil_start_targetname_array_index];
  level.mindia_infil_start_targetname_array_index++;
  return var_1;
}

function get_left_vindia_infil_rider_start_targetname() {
  var_0 = ["left_river_one", "left_river_two", "left_river_three", "left_river_four", "left_river_five", "left_river_six"];

  if(!isDefined(level.left_vindia_infil_start_targetname_array)) {
    level.left_vindia_infil_start_targetname_array = randomize_start_targetname_array(var_0);
    level.left_vindia_infil_start_targetname_array_index = 0;
  }

  var_1 = level.left_vindia_infil_start_targetname_array[level.left_vindia_infil_start_targetname_array_index];
  level.left_vindia_infil_start_targetname_array_index++;
  return var_1;
}

function get_right_vindia_infil_rider_start_targetname() {
  var_0 = ["right_river_one", "right_river_two", "right_river_three", "right_river_four", "right_river_five", "right_river_six"];

  if(!isDefined(level.right_vindia_infil_start_targetname_array)) {
    level.right_vindia_infil_start_targetname_array = randomize_start_targetname_array(var_0);
    level.right_vindia_infil_start_targetname_array_index = 0;
  }

  var_1 = level.right_vindia_infil_start_targetname_array[level.right_vindia_infil_start_targetname_array_index];
  level.right_vindia_infil_start_targetname_array_index++;
  return var_1;
}

function randomize_start_targetname_array(var_0) {
  for(var_1 = 5; var_1 > 0; var_1--) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}

function enemy_spawner_umike_think(var_0, var_1) {
  var_0 endon("death");
  var_0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_damage_monitor(var_0, 500000);
  wait 10;
  var_2 = var_0.riders;
  scripts\cp\vehicle_race\coop_vehicle_race::change_riders_demeanor(var_0);
  var_0 notify("stop_vehicle_on_damage_internal");
  var_0 waittill("unloaded");
  thread back_line_enemies_attack_logic(var_0, var_2, undefined);
}

function enemy_spawner_vehicle_think(var_0, var_1) {
  var_0 endon("death");
  var_0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_damage_monitor(var_0, 5000);
  wait 1.5;
  scripts\cp\vehicle_race\coop_vehicle_race::change_riders_demeanor(var_0);
  var_0 notify("stop_vehicle_on_damage_internal");
  var_0 notify("stop_waiting_for_spawns");
  var_0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_no_rider_monitor(var_0);
  wait 0.5;
  var_0 vehicle_setspeedimmediate(25, 15, 15);
  thread unload_monitor(var_0, var_0);
}

function unload_monitor(var_0, var_1) {
  var_0 endon("death");
  var_2 = get_unload_marker_for_spawn_group(var_1);

  for(;;) {
    if(distance2dsquared(var_2.origin, var_0.origin) < 22500) {
      break;
    }

    waitframe();
  }

  var_0 vehicle_setspeedimmediate(0, 15, 15);
  var_0 scripts\common\vehicle::vehicle_unload("not_driver");
  thread start_riders_combat_logic(level, var_0.riders, var_0.riders[0]);
  var_0 notify("unloaded");
  wait 2;
  var_0 vehicle_setspeedimmediate(25, 15, 15);
  thread reach_path_end_monitor(var_0, var_0);
}

function start_riders_combat_logic(var_0, var_1, var_2) {
  wait 2;

  switch (var_2) {
    case "old_bridge":
      send_riders_to_proper_combat_spot(var_0, var_1, var_2, 0);
      break;
    case "end_bridge":
    case "mid_bridge":
      under_bridge_enemies_attack_logic(var_0, var_1, var_2, 1);
      break;
    case "player_left_side":
    case "player_right_side":
      back_line_enemies_attack_logic(var_0, var_1, var_2);
      break;
  }
}

function under_bridge_enemies_attack_logic(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    thread under_bridge_enemy_attack_logic(var_5, var_5, var_2);
  }
}

function send_riders_to_proper_combat_spot(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    thread delay_set_goal_volume(var_5, var_5, var_2);
  }
}

function back_line_enemies_attack_logic(var_0, var_1, var_2) {
  var_3 = 0;

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }

    var_5.never_kill_off = 1;

    if(istrue(level.bomb_guardian_is_killed)) {
      if(!istrue(var_3)) {
        thread go_hunt_down_player(var_5, var_5);
        var_3 = 1;
      } else {
        thread back_line_enemy_attack_logic(var_5, var_5);
      }

      continue;
    }

    thread back_line_enemy_attack_logic(var_5, var_5);
  }
}

function get_combat_volume_targetname(var_0) {
  switch (var_0) {
    case "old_bridge":
      return var_0;
    case "player_right_side":
      return "enemy_bridge_zone_right";
    case "player_left_side":
      return "enemy_bridge_zone_left";
    default:
      if(any_player_under_bridge()) {
        return "under_bridge";
      }

      return var_0;
  }
}

function any_player_under_bridge() {
  var_0 = getEnt("under_bridge_zone", "targetname");

  foreach(var_2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    if(var_2 istouching(var_0)) {
      return true;
    }
  }

  return false;
}

function advance_through_struct_path(var_0, var_1) {
  level endon("post_blockade_combat");
  var_2 = 6;
  var_3 = 3;
  var_4 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_0.goalradius = 64;
  var_0 setgoalpos(getclosestpointonnavmesh(var_4.origin));
  var_0 waittill("goal");

  for(;;) {
    if(isDefined(var_4.target)) {
      var_4 = scripts\engine\utility::getStruct(var_4.target, "targetname");
      var_0 setgoalpos(getclosestpointonnavmesh(var_4.origin));
      var_0 waittill("goal");
      wait randomfloatrange(var_3, var_2);

      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "go_hunt_player") {
        if(issubstr(var_1, "attacker")) {
          thread go_hunt_down_player(var_0, var_0);
        } else {
          thread go_hunt_down_player(var_0, var_0);
        }
      }

      continue;
    }

    return;
  }
}

function under_bridge_enemy_attack_logic(var_0, var_1, var_2) {
  var_3 = 4;
  var_4 = 2;
  var_0 endon("death");
  var_0.goalradius = 10;

  if(any_player_under_bridge()) {
    thread go_hunt_down_player(var_0, var_0);
    return;
  }

  var_5 = get_under_bridge_enemy_start_structs(var_1);
  var_0 setgoalpos(getclosestpointonnavmesh(var_5.origin));
  var_0 waittill("goal");
  wait randomfloatrange(var_4, var_3);

  for(;;) {
    if(isDefined(var_5.target)) {
      var_5 = scripts\engine\utility::getStruct(var_5.target, "targetname");
    } else {
      var_5 = undefined;
    }

    if(should_advance_to_next_goal_struct(var_5)) {
      var_0 setgoalpos(getclosestpointonnavmesh(var_5.origin));
      var_0 waittill("goal");
      wait randomfloatrange(var_4, var_3);
      continue;
    }

    break;
  }

  if(istrue(var_2)) {
    thread go_hunt_down_player(var_0, var_0);
    return;
  }
}

function get_under_bridge_enemy_start_structs(var_0) {
  if(!isDefined(level.mid_bridge_start_struct_index)) {
    level.mid_bridge_start_struct_index = 0;
  }

  if(!isDefined(level.end_bridge_start_struct_index)) {
    level.end_bridge_start_struct_index = 0;
  }

  if(var_0 == "mid_bridge") {
    var_1 = scripts\engine\utility::getStructArray("mid_bridge_start", "targetname");
    var_2 = level.mid_bridge_start_struct_index;
    level.mid_bridge_start_struct_index++;

    if(level.mid_bridge_start_struct_index == var_1.size) {
      level.mid_bridge_start_struct_index = 0;
    }

    return var_1[var_2];
  }

  if(var_2 == "end_bridge") {
    var_3 = scripts\engine\utility::getStructArray("end_bridge_start", "targetname");
    var_2 = level.end_bridge_start_struct_index;
    level.end_bridge_start_struct_index++;

    if(level.end_bridge_start_struct_index == var_3.size) {
      level.end_bridge_start_struct_index = 0;
    }

    return var_3[var_2];
  }
}

function delay_set_goal_volume(var_0, var_1, var_2) {
  var_0 endon("death");
  wait 2;
  var_3 = getEnt(get_combat_volume_targetname(var_1), "targetname");
  var_0 setgoalvolumeauto(var_3);

  if(istrue(var_2)) {
    var_0 waittill("goal");

    if(!is_goal_volume_ahead_of_vehicle_to_push(var_3)) {
      thread go_hunt_down_player(var_0, var_0);
      return;
    }

    return;
  }
}

function back_line_enemy_attack_logic(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  wait randomfloatrange(1.2, 2);
  var_2 = get_players_groups_by_whether_in_killzone();

  if(var_2.players_in_killzone.size > 0) {
    advance_down_the_bridge(var_0, var_1);
    return;
  }

  go_hunt_down_player(var_0, 0);
}

function advance_down_the_bridge(var_0, var_1) {
  var_2 = getEnt(get_combat_volume_targetname(var_1), "targetname");

  if(isDefined(var_2)) {
    advance_down_the_bridge_via_volume(var_0, var_2);
    return;
  }

  advance_down_the_bridge_via_struct(var_0);
}

function advance_down_the_bridge_via_struct(var_0) {
  var_1 = 4;
  var_2 = 2;
  var_0.goalradius = 10;
  var_3 = get_bridge_start_struct();
  var_0 setgoalpos(getclosestpointonnavmesh(var_3.origin));
  var_0 waittill("goal");
  wait randomfloatrange(var_2, var_1);

  for(;;) {
    if(isDefined(var_3.target)) {
      var_3 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    } else {
      var_3 = undefined;
    }

    if(should_advance_to_next_goal_struct(var_3)) {
      var_0 setgoalpos(getclosestpointonnavmesh(var_3.origin));
      var_0 waittill("goal");
      wait randomfloatrange(var_2, var_1);
      continue;
    }

    break;
  }

  go_hunt_down_player(var_0, 1);
}

function get_bridge_start_struct() {
  var_0 = scripts\engine\utility::getStructArray("bridge_start", "targetname");

  if(!isDefined(level.bridge_start_struct_index)) {
    level.bridge_start_struct_index = 0;
  }

  var_1 = level.bridge_start_struct_index;
  level.bridge_start_struct_index++;

  if(level.bridge_start_struct_index == var_0.size) {
    level.bridge_start_struct_index = 0;
  }

  return var_0[var_1];
}

function should_advance_to_next_goal_struct(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = anglesToForward(level.vehicle_to_push.angles);
  var_2 = vectorNormalize(level.vehicle_to_push.origin - var_0.origin);

  if(vectordot(var_2, var_1) < 0) {
    return 0;
  }

  return 1;
}

function advance_down_the_bridge_via_volume(var_0, var_1) {
  var_2 = 4;
  var_3 = 2;
  var_0 setgoalvolumeauto(var_1);
  var_0 waittill("goal");
  wait randomfloatrange(var_3, var_2);

  for(;;) {
    if(isDefined(var_1.target)) {
      var_1 = getEnt(var_1.target, "targetname");
    } else {
      var_1 = undefined;
    }

    if(should_advance_to_next_goal_volume(var_1)) {
      var_0 setgoalvolumeauto(var_1);
      var_0 waittill("goal");
      wait randomfloatrange(var_3, var_2);
      continue;
    }

    break;
  }

  go_hunt_down_player(var_0, 1);
}

function should_advance_to_next_goal_volume(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = anglesToForward(level.vehicle_to_push.angles);
  var_2 = vectorNormalize(level.vehicle_to_push.origin - var_0.origin);

  if(is_goal_volume_ahead_of_vehicle_to_push(var_0)) {
    return 0;
  }

  return 1;
}

function is_goal_volume_ahead_of_vehicle_to_push(var_0) {
  var_1 = anglesToForward(level.vehicle_to_push.angles);
  var_2 = vectorNormalize(level.vehicle_to_push.origin - var_0.origin);
  return vectordot(var_2, var_1) < 0;
}

function go_hunt_down_player(var_0, var_1) {
  var_0 notify("go_hunt_down_player");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("go_hunt_down_player");

  if(!isai(var_0)) {
    return;
  }

  var_0.goalradius = 256;
  var_0.goalheight = 128;
  var_0 cleargoalvolume();

  for(;;) {
    var_2 = get_rider_initial_target(var_1);

    if(isDefined(var_2)) {
      break;
    }

    wait 0.1;
  }

  var_0 getenemyinfo(var_2);
  var_0 setgoalentity(var_2, 100);

  for(var_3 = var_2;; var_3 = var_4) {
    var_3 waittill("last_stand");
    var_4 = get_closest_alive_player(var_0);
    var_0 getenemyinfo(var_4);
    var_0 setgoalentity(var_4, 100);
  }
}

function get_closest_alive_player(var_0) {
  var_1 = scripts\cp\raid_utility::get_players_not_in_laststand();
  return scripts\engine\utility::getclosest(var_0.origin, var_1);
}

function get_rider_initial_target(var_0) {
  var_1 = get_players_groups_by_whether_in_killzone();

  if(istrue(var_0)) {
    if(var_1.players_in_killzone.size > 0) {
      return scripts\engine\utility::random(var_1.players_in_killzone);
    }

    return scripts\engine\utility::random(var_1.players_not_in_killzone);
  }

  if(var_1.players_not_in_killzone.size > 0) {
    return scripts\engine\utility::random(var_1.players_not_in_killzone);
  }

  return scripts\engine\utility::random(var_1.players_in_killzone);
}

function get_players_groups_by_whether_in_killzone() {
  var_0 = spawnStruct();
  var_1 = scripts\cp\raid_utility::get_players_not_in_laststand();
  var_2 = get_players_in_killzone(var_1);
  var_3 = [];

  foreach(var_5 in var_1) {
    if(scripts\engine\utility::array_contains(var_2, var_5)) {
      continue;
    }

    var_3 = var_5;
  }

  var_0.players_in_killzone = var_2;
  var_0.players_not_in_killzone = var_3;
  return var_0;
}

function get_unload_marker_for_spawn_group(var_0) {
  var_1 = scripts\engine\utility::getStructArray("enemy_spawn_vehicle_unload_marker", "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == var_0) {
      return var_3;
    }
  }
}

function increase_script_maxdist(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.spawn_points.size; var_4++) {
    var_5 = var_0.spawn_points[var_4];
    var_5.script_maxdist = 20000;
  }
}

function assign_more_vehicle_unload_groups() {}

function create_not_driver_group() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, 1);
}

function reach_path_end_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("reached_end_node");

  foreach(var_3 in var_0.riders) {
    var_3 scripts\cp\cp_modular_spawning::script_kill_ai();
  }

  var_0 delete();
}

function get_pre_respawn_group_wait(var_0) {
  switch (var_0) {
    case "player_right_side":
      return randomfloatrange(10, 20);
    case "player_left_side":
      return randomfloatrange(10, 20);
  }
}

function vehicle_progress_marker_think() {
  waitframe();
  var_0 = scripts\engine\utility::getStructArray("vehicle_to_push_progress_marker", "targetname");

  foreach(var_2 in var_0) {
    thread activate_vehicle_progress_marker(var_2);
  }

  waitframe();
  scripts\engine\utility::flag_set("vehicle_progression_flags_have_been_set_up");
}

function player_progress_market_think() {
  var_0 = getEntArray("player_progression_trigger", "targetname");

  foreach(var_2 in var_0) {
    thread player_progress_trigger_think(var_2);
  }
}

function player_progress_trigger_think(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      break;
    }
  }

  scripts\engine\utility::flag_set(get_player_progress_flag_to_set(var_1));
}

function get_player_progress_flag_to_set(var_0) {
  var_1 = scripts\engine\utility::getStructArray("vehicle_to_push_progress_marker", "targetname");
  var_2 = sortbydistance(var_1, var_0.origin)[0];
  return var_2.script_noteworthy;
}

function activate_vehicle_progress_marker(var_0) {
  level.vehicle_to_push endon("death");
  scripts\engine\utility::flag_init(var_0.script_noteworthy);

  for(;;) {
    if(distance2dsquared(var_0.origin, level.vehicle_to_push.origin) < squared(150)) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set(var_0.script_noteworthy);
}

function get_mortar_impact_spot(var_0) {
  if(!isDefined(var_0.targets)) {
    return undefined;
  }

  var_1 = scripts\engine\utility::random(var_0.targets);
  var_2 = var_1 getvelocity();
  var_3 = distance(var_0.origin, var_1.origin);
  var_4 = 5;
  var_5 = var_1.origin + var_2 * var_4;
  var_6 = scripts\engine\trace::ray_trace(var_5 + (0, 0, 500), var_5, var_1);
  return var_6["position"];
}

function linkoffset() {
  foreach(var_1 in level.enemy_turrets) {
    deactivate_enemy_turret(var_1);
    var_1.little_bird_mg_reenter = 1;
  }
}

function brdisablefinalkillcam() {
  scripts\engine\utility::flag_set("post_blockade_combat");
  waitframe();
  scripts\cp\cp_modular_spawning::remove_pacifist_from_enemies();
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    thread ref_127f2(var_2);
  }
}

function ref_127f2(var_0) {
  var_0 notify("post_blockade_combat_logic");
  var_0 endon("death");
  var_0 endon("post_blockade_combat_logic");

  if(istrue(var_0.is_on_platform)) {
    return;
  }

  if(isDefined(var_0.going_to_object)) {
    var_1 = var_0.going_to_object;

    while(isDefined(var_0.going_to_object)) {
      waitframe();
    }

    var_1 notify("stop_mortar_think");
    var_1.targets = undefined;
  }

  if(isDefined(var_0.wztrain_info)) {
    var_0 unlink();
    var_0.wztrain_info delete();
    wait randomfloatrange(0.3, 0.5);
  }

  var_0 thread scripts\cp\cp_modular_spawning::enter_combat();
  wait randomfloatrange(0.1, 0.3);
  var_0.is_on_platform = 0;
  var_0.dontevershoot = 0;
  var_0 allowedstances("stand", "prone", "crouch");
  var_0 setlookatentity();
  var_0.ignoreall = 0;
  var_0.combatmode = "cover";
  thread go_hunt_down_player(var_0, var_0);
}

function set_up_blockade_gates() {
  if(!scripts\engine\utility::flag_exist("blockade_gates_have_been_set_up")) {
    scripts\engine\utility::flag_init("blockade_gates_have_been_set_up");
  }

  ref_130ff();
  scripts\engine\utility::flag_set("blockade_gates_have_been_set_up");
}

#using_animtree("");

function ref_130ff() {
  laser_switch_manager("gate_door_left");
  laser_switch_manager("gate_door_right");
  laser_switch_manager("gate_post");
  level.scr_animtree["gate_left"] = #animtree;
  level.scr_model["gate_left"] = "military_blockade_gate_damaged_rig_skeleton";
  level.scr_anim["gate_left"]["close"] = $cp_raid_blockade_gate_le_close;
  level.scr_animname["gate_left"]["close"] = "cp_raid_blockade_gate_le_close";
  level.scr_anim["gate_left"]["blow"] = % cp_raid_blockade_gate_le_blowup;
  level.scr_animname["gate_left"]["blow"] = "cp_raid_blockade_gate_le_blowup";
  level.scr_animtree["gate_right"] = #animtree;
  level.scr_model["gate_right"] = "military_blockade_gate_left_damaged_rig_skeleton";
  level.scr_anim["gate_right"]["close"] = % cp_raid_blockade_gate_ri_close;
  level.scr_animname["gate_right"]["close"] = "cp_raid_blockade_gate_ri_close";
  level.scr_anim["gate_right"]["blow"] = % cp_raid_blockade_gate_ri_blowup;
  level.scr_animname["gate_right"]["blow"] = "cp_raid_blockade_gate_ri_blowup";
  var_0 = scripts\engine\utility::getStruct("blockade_gate", "targetname");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.targetname = "blockade_gate";
    var_0.origin = (39812.5, 15256, -354);
    var_0.angles = (0, 204.999, 0);
  }

  var_1 = scripts\engine\utility::getStruct("gate_left_prestine", "targetname");

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_1.targetname = "gate_left_prestine";
    var_1.origin = (39760, 15368, -354.172);
    var_1.angles = (0, 114.999, 0);
  }

  var_2 = scripts\engine\utility::getStruct("gate_right_prestine", "targetname");

  if(!isDefined(var_2)) {
    var_2 = spawnStruct();
    var_2.targetname = "gate_right_prestine";
    var_2.origin = (39864.6, 15143.7, -354.291);
    var_2.angles = (0, 114.999, 0);
  }

  var_3 = "military_blockade_gate";
  var_4 = spawn("script_model", var_1.origin);
  var_4.angles = var_1.angles;
  var_4 setModel(var_3);
  var_5 = spawn("script_model", var_2.origin);
  var_5.angles = var_2.angles;
  var_5 setModel(var_3);
  var_6 = spawn("script_model", var_0.origin);
  var_6.angles = var_0.origin;
  var_6 setModel("military_blockade_gate_damaged_rig_skeleton");
  var_7 = spawn("script_model", var_0.origin);
  var_7.angles = var_0.origin;
  var_7 setModel("military_blockade_gate_left_damaged_rig_skeleton");
  level.computer_objective = [];
  level.computer_objective["anim_node"] = var_0;
  level.computer_objective["model"] = [];
  level.computer_objective["model"]["prestine"] = [];
  level.computer_objective["model"]["prestine"]["left"] = var_4;
  level.computer_objective["model"]["prestine"]["right"] = var_5;
  level.computer_objective["model"]["blown"] = [];
  level.computer_objective["model"]["blown"]["left"] = var_6;
  level.computer_objective["model"]["blown"]["right"] = var_7;
  level.computer_objective["clip"] = [];
  level.computer_objective["clip"]["before"] = getEnt("blockade_gate_clip_before", "targetname");
  level.computer_objective["clip"]["after"] = getEnt("blockade_gate_clip_after", "targetname");
  level.computer_objective["bone"] = [];
  level.computer_objective["bone"]["left"] = "j_blockade_gate_le";
  level.computer_objective["bone"]["right"] = "j_blockade_gate_ri";
  var_6 useanimtree(#animtree);
  var_6.animname = "gate_left";
  level.computer_objective["anim_node"] thread scripts\common\anim::anim_first_frame_solo(var_6, "close");
  var_7 useanimtree(#animtree);
  var_7.animname = "gate_right";
  level.computer_objective["anim_node"] thread scripts\common\anim::anim_first_frame_solo(var_7, "close");
  var_8 = var_4.origin - var_6 gettagorigin("j_blockade_gate_le");
  var_9 = var_4.angles - var_6 gettagangles("j_blockade_gate_le");
  var_4 linktomoveoffset(var_6, "j_blockade_gate_le", var_8, var_9);
  var_8 = var_7 gettagorigin("j_blockade_gate_ri") - var_5.origin;
  var_9 = var_7 gettagangles("j_blockade_gate_ri") - var_5.angles;
  var_5 linktomoveoffset(var_7, "j_blockade_gate_ri", var_8, var_9);
  var_6 hide();
  var_7 hide();

  if(isDefined(level.computer_objective["clip"]["before"]) && isDefined(level.computer_objective["clip"]["after"])) {
    level.computer_objective["clip"]["before"].original_origin = level.computer_objective["clip"]["before"].origin;
    level.computer_objective["clip"]["after"].original_origin = level.computer_objective["clip"]["after"].origin;
    level.computer_objective["clip"]["after"].origin = level.computer_objective["clip"]["after"].origin + (0, 0, -2000);
    return;
  }
}

function laser_switch_manager(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_3 delete();
    }

    return;
  }
}

function open_blockade_gates() {
  if(!scripts\engine\utility::flag_exist("blockade_gates_have_been_set_up")) {
    scripts\engine\utility::flag_init("blockade_gates_have_been_set_up");
  }

  scripts\engine\utility::flag_wait("blockade_gates_have_been_set_up");

  if(istrue(level.blockade_gates_are_opening)) {
    return;
  }

  level.blockade_gates_are_opening = 1;
  level.computer_objective["model"]["blown"]["left"] show();
  level.computer_objective["model"]["blown"]["right"] show();
  level.computer_objective["model"]["prestine"]["left"] hide();
  level.computer_objective["model"]["prestine"]["right"] hide();
  level.computer_objective["anim_node"] thread scripts\common\anim::anim_single_solo(level.computer_objective["model"]["blown"]["left"], "blow");
  level.computer_objective["anim_node"] scripts\common\anim::anim_single_solo(level.computer_objective["model"]["blown"]["right"], "blow");

  if(isDefined(level.computer_objective["clip"]["before"]) && isDefined(level.computer_objective["clip"]["after"])) {
    level.computer_objective["clip"]["after"].origin = level.computer_objective["clip"]["after"].original_origin;
    level.computer_objective["clip"]["before"].origin = level.computer_objective["clip"]["before"].origin + (0, 0, -2000);
  }

  level.computer_objective["model"]["blown"]["left"] notsolid();
  level.computer_objective["model"]["blown"]["right"] notsolid();
  level.blockade_gates_are_opening = undefined;
}

function close_blockade_gates() {
  if(!scripts\engine\utility::flag_exist("blockade_gates_have_been_set_up")) {
    scripts\engine\utility::flag_init("blockade_gates_have_been_set_up");
  }

  scripts\engine\utility::flag_wait("blockade_gates_have_been_set_up");

  if(istrue(level.blockade_gates_are_closing)) {
    return;
  }

  level.blockade_gates_are_closing = 1;
  level.computer_objective["model"]["blown"]["left"] hide();
  level.computer_objective["model"]["blown"]["right"] hide();
  level.computer_objective["model"]["prestine"]["left"] show();
  level.computer_objective["model"]["prestine"]["left"] show();
  level.computer_objective["anim_node"] thread scripts\common\anim::anim_single_solo(level.computer_objective["model"]["blown"]["left"], "close");
  level.computer_objective["anim_node"] scripts\common\anim::anim_single_solo(level.computer_objective["model"]["blown"]["right"], "close");

  if(isDefined(level.computer_objective["clip"]["before"]) && isDefined(level.computer_objective["clip"]["after"])) {
    level.computer_objective["clip"]["after"].origin = level.computer_objective["clip"]["after"].origin + (0, 0, -2000);
    level.computer_objective["clip"]["before"].origin = level.computer_objective["clip"]["before"].original_origin;
  }

  level.blockade_gates_are_closing = undefined;
}

function cpoperationcrateactivatecallback(var_0, var_1) {
  var_1 endon("death");
  var_0 waittill("death");
  var_1 delete();
}

function deploy_friendly_reinforcement_convoy() {
  var_0 = (48941, 12803, -121);
  level.friendly_convoy = [];
  var_1 = scripts\cp\coop_escort::create_friendly_convoy_vehicle("reinforcement_convoy_start_two");
  scripts\cp\coop_escort::add_to_friendly_convoy_list(var_1);
  var_2 = scripts\cp\coop_escort::create_not_drivable_player_vehicle("reinforcement_convoy_start_one");
  scripts\cp\maps\cp_br_syrk\vehicle_travel::add_gunner_turret(var_2);
  reinforcement_convoy_get_to_blockade(var_1, var_2);
  var_3 = getvehiclenode("seek_convoy_start", "targetname");
  var_1 attachpath(var_3);
  var_1 startpath();
  wait 1;
  var_4 = scripts\engine\utility::getStructArray("humvee_spawner", "script_noteworthy");
  var_5 = sortbydistance(var_4, var_0)[0];
  level thread scripts\cp\maps\cp_br_syrk\vehicle_travel::deploy_vehicle(var_5, scripts\cp\maps\cp_br_syrk\vehicle_travel::get_humvee_info(var_5));
  var_6 = var_2.origin;
  var_7 = var_2.angles;
  var_2 delete();
  level.player_humvee vehicle_teleport(var_6, var_7);
  scripts\cp\coop_escort::add_to_friendly_convoy_list(level.player_humvee);
  iprintlnbold("Overload: Get in the vehicle.We need to go rescue the HVI");
  level waittill("player_entered_driver_seat");
  var_1 thread scripts\cp\coop_escort::maintain_speed_with_player_vehicle(var_1);
  scripts\cp\coop_escort::waittill_vehicle_node_reached("seek_path_node_43");
  iprintlnbold("Overload: Stealth into the TV Station and rescue the HVI");
}

function reinforcement_convoy_get_to_blockade(var_0, var_1) {
  var_2 = 40;
  var_3 = getvehiclenode("reinforcement_convoy_start_two", "targetname");
  var_4 = getvehiclenode("reinforcement_convoy_start_one", "targetname");
  iprintlnbold("Overload: Reinforcement incoming");
  var_0 attachpath(var_3);
  var_0 startpath();
  var_1 attachpath(var_4);
  var_1 startpath();
  var_0 vehicle_setspeedimmediate(var_2, var_2 * 0.5, var_2 * 0.5);
  var_1 vehicle_setspeedimmediate(var_2, var_2 * 0.5, var_2 * 0.5);
  scripts\cp\coop_escort::waittill_vehicle_node_reached("lumber_safe_path_node_31");
  var_0 vehicle_setspeedimmediate(0, 5, 5);
  var_1 vehicle_setspeedimmediate(0, 5, 5);
}

function hide_enemy_mortar_shell() {
  var_0 = getEntArray("enemy_mortar", "targetname");

  foreach(var_2 in var_0) {
    var_2 hidepart("j_mortar_shell");
  }
}

function vehicle_bridge_stage_five_music() {}

function ref_129ed() {
  self endon("death");
  var_0 = self;
  var_1 = scripts\engine\utility::getStructArray(get_smoke_grenade_struct_targetname(var_0), "targetname");
  deploy_smoke_grenades_for_infil_via_structs(var_0, var_1, ["turret_hatch_jnt"], [(0, 0, 15)]);
}

function ref_129ec() {
  self endon("death");
  var_0 = self;
  var_1 = scripts\engine\utility::getStructArray(get_smoke_grenade_struct_targetname(var_0), "targetname");
  deploy_smoke_grenades_for_infil_via_structs(var_0, var_1, ["tag_window_front_right", "tag_window_front_left"], [(0, 0, 30), (0, 0, 30)]);
}

function deploy_smoke_grenades_for_infil_via_structs(var_0, var_1, var_2, var_3) {
  for(var_4 = 5; var_4 > 0; var_4--) {
    var_1 = scripts\engine\utility::array_randomize(var_1);
  }

  foreach(var_6 in var_1) {
    var_7 = var_6.origin;
    var_8 = readytoleave(var_0, var_7, var_2, var_3);
    var_9 = var_7 - var_8;
    var_9 *= (1, 1, 0);
    var_9 += (0, 0, 1) * length(var_9);
    magicgrenademanual("smoke_grenade_mp", var_8, var_9 * 0.5, 0.05);
    wait randomfloatrange(1, 1.5);
  }
}

function readytoleave(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = 99999999;

  foreach(var_7 in var_2) {
    var_8 = var_0 gettagorigin(var_7);
    var_9 = distance2dsquared(var_8, var_1);

    if(var_9 <= var_5) {
      var_4 = var_10;
      var_5 = var_9;
    }
  }

  var_11 = var_2[var_4];
  var_12 = var_3[var_4];
  return var_0 gettagorigin(var_11) + var_12;
}

function get_smoke_grenade_struct_targetname(var_0) {
  switch (var_0.targetname) {
    case "player_left_vindia_spawner":
    case "player_left_umike_spawner":
      return "left_vindia_smoke_grenade";
    case "player_right_vindia_spawner":
    case "player_right_umike_spawner":
      return "right_vindia_smoke_grenade";
  }
}

function watchgastrapdamage(var_0, var_1) {
  var_0 endon("death");
  var_0.spawn_riders_and_play_intro_idle_anim = ["clockwise", "counterclockwise"];

  for(;;) {
    var_2 = var_0 scripts\engine\utility::ref_143b5("hover_attack", "increase_accuracy", "hover_retreat");

    switch (var_2) {
      case "hover_retreat":
        var_0.spawn_removefromarrays = undefined;
        var_3 = player_vo_confirm_pickup(var_0);
        var_4 = init_civs(var_3.origin, var_0, 2500, 256, 1, 50, race_ui_add_critical_message(), 12);
        var_5 = var_4[0];
        var_0 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_5);
        break;
      case "hover_attack":
        var_6 = [[var_1]](var_0);
        var_7 = init_civs(var_6, var_0, 2500, 256, 1, 40, protect_obj_a_internal(var_0), 12);
        var_8 = var_7[0];
        var_0 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_8);
        break;
      case "increase_accuracy":
        var_9 = var_0.riders;

        foreach(var_11 in var_9) {
          var_11.baseaccuracy = 1000;
          thread watchheatreduction(var_0, var_11);
        }

        break;
    }
  }
}

function ref_12ff5(var_0) {
  var_1 = scripts\engine\utility::getclosest(var_0.origin, level.players);
  var_2 = scripts\cp\raid_utility::get_players_not_in_laststand();

  if(var_2.size >= 1) {
    var_3 = get_players_in_killzone(var_2);

    if(var_3.size >= 1) {
      var_1 = scripts\engine\utility::getclosest(var_0.origin, var_3);
    }
  }

  return var_1.origin + (0, 0, 756);
}

function ref_12ff6(var_0) {
  var_1 = level.vehicle_to_push;
  var_2 = scripts\cp\raid_utility::get_players_not_in_laststand();

  if(var_2.size >= 1) {
    var_3 = get_players_in_killzone(var_2);

    if(var_3.size >= 1) {
      var_1 = scripts\engine\utility::getclosest(var_0.origin, var_3);
    }
  }

  return var_1.origin + (0, 0, 756);
}

function ref_12ff7(var_0) {
  var_1 = scripts\engine\utility::getStruct("lbravo_carrier_back_center", "targetname");
  var_2 = var_1;
  var_3 = scripts\cp\raid_utility::get_players_not_in_laststand();

  if(var_3.size >= 1) {
    var_4 = get_players_groups_by_whether_in_killzone();
    var_5 = var_4.players_not_in_killzone;

    if(var_5.size >= 1) {
      var_2 = scripts\engine\utility::getclosest(var_0.origin, var_5);
    }
  }

  return var_2.origin + (0, 0, 756);
}

function race_ui_add_critical_message() {
  return scripts\engine\utility::random(["clockwise", "counterclockwise"]);
}

function player_vo_confirm_pickup(var_0) {
  var_1 = rebirthloadout(var_0);
  var_2 = (var_0.origin + var_1.origin) / 2;
  var_3 = ref_11a81(var_2, var_0.angles, 256, 1, 55);
  var_0 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_3);
  var_0 scripts\engine\utility::ref_143a5("near_goal", "goal");
  return var_1;
}

function ref_11a81(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.origin = var_0;
  var_5.angles = var_1;
  var_5.radius = var_2;
  var_5.speed = var_3;

  if(istrue(var_4)) {
    var_5.script_goalyaw = 1;
  }

  return var_5;
}

function rebirthloadout(var_0) {
  var_1 = scripts\engine\utility::getStructArray("hover_retreat", "targetname");
  var_2 = -99999;
  var_3 = var_1[0];
  var_4 = anglesToForward(var_0.angles);

  foreach(var_6 in var_1) {
    var_7 = vectorNormalize(var_6.origin - var_0.origin);
    var_8 = vectordot(var_7, var_4);

    if(var_8 > var_2) {
      var_2 = var_8;
      var_3 = var_6;
    }
  }

  return var_3;
}

function watchheatreduction(var_0, var_1) {
  var_1 endon("death");
  var_0 waittill("death");
  waitframe();
  getdismembermentlist(var_1);
}

function getdismembermentlist(var_0) {
  if(!c130_lights(var_0, [2, 3, 4])) {
    ref_12bd4(var_0, "counterclockwise");
    return;
  }

  if(!c130_lights(var_0, [5, 6, 7])) {
    ref_12bd4(var_0, "clockwise");
    return;
  }
}

function ref_12bd4(var_0, var_1) {
  var_0.spawn_riders_and_play_intro_idle_anim = scripts\engine\utility::array_remove(var_0.spawn_riders_and_play_intro_idle_anim, var_1);

  if(isDefined(var_0.spawn_removefromarrays) && var_0.spawn_removefromarrays == var_1) {
    var_0 notify("hover_retreat");
    return;
  }
}

function ref_13b6f(var_0) {
  wait 10 + var_0.vehicle_position * 2;
  var_0 dodamage(var_0.health + 100, var_0.origin);
}

function c130_lights(var_0, var_1) {
  foreach(var_3 in var_1) {
    foreach(var_5 in var_0.riders) {
      if(isalive(var_5) && isDefined(var_5.vehicle_position) && var_5.vehicle_position == var_3) {
        return true;
      }
    }
  }

  return false;
}

function protect_obj_a_internal(var_0) {
  if(isDefined(var_0.spawn_removefromarrays)) {
    return var_0.spawn_removefromarrays;
  }

  var_1 = scripts\engine\utility::random(var_0.spawn_riders_and_play_intro_idle_anim);
  var_0.spawn_removefromarrays = var_1;
  return var_1;
}

function init_civs(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = vectorNormalize(var_1.origin - var_0);
  var_9 = int(360 / var_7);
  var_10 = vectortoangles(var_8);

  if(var_6 == "clockwise") {
    var_9 *= -1;
  }

  var_11 = [];

  for(var_12 = 1; var_12 <= var_7; var_12++) {
    var_13 = var_10 + (0, var_9 * var_12, 0);
    var_14 = ref_11a8e(var_0, var_13, var_2, var_3, var_4, var_5, var_6);

    if(var_12 == var_7) {
      var_14.script_noteworthy = "hover_attack";
    }

    var_11 = var_14;
  }

  hostage_vo(var_11);
  return var_11;
}

function hostage_vo(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    var_2 = var_0[var_1];
    var_3 = var_0[var_1 + 1];
    var_2.target = var_3.targetname;
    scripts\cp\utility::addtostructarray("target", var_2.targetname, var_3);
  }
}

function ref_11a8e(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.origin = var_0 + anglesToForward(var_1) * var_2;
  var_7.radius = var_3;
  var_7.speed = var_5;
  var_7.targetname = scripts\cp\cp_vehicles::create_unique_kvp_string();
  scripts\cp\utility::addtostructarray("targetname", var_7.targetname, var_7);
  var_8 = vectortoangles(vectorNormalize(var_7.origin - var_0));

  if(istrue(var_4)) {
    var_7.script_goalyaw = 1;
  }

  if(var_6 == "counterclockwise") {
    var_7.angles = vectortoangles(anglestoleft(var_8));
  } else {
    var_7.angles = vectortoangles(anglestoright(var_8));
  }

  return var_7;
}

function build_vehicles() {
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_physics_mp", "techo_phys_convoy_cp", "script_vehicle_iw8_truck_techo_white");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo", "truck", "script_vehicle_iw8_truck_techo_white");
  scripts\cp\cp_vehicles::register_combined_vehicles(&scripts\vehicle\umike::main, "veh8_mil_lnd_umike_physics", "umike_physics_sp", "script_vehicle_iw8_truck_umike_covered_physics", undefined, "umike_covered_physics", "umike_covered_physics");
  scripts\cp\cp_vehicles::register_combined_vehicles(&scripts\vehicle\umike::main, "veh8_mil_lnd_umike_pickup_physics", "umike_physics_sp", "script_vehicle_iw8_truck_umike_pickup_physics", undefined, "umike_physics", "umike_physics");
  scripts\vehicle\vindia::main("veh8_mil_lnd_vindia_a2_physics", "vindia_physics_sp", "script_vehicle_iw8_vindia_a2");
}

function ascendermodelworld() {
  var_0 = getEntArray("gunshop_safehouse_loot", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread scripts\cp\utility::create_fake_loot(["brloot_munition_ammo"]);
  }
}

function cp_arms_dealer_sound_load() {
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42580.9, 16468.8, -566.727), (359.354, 192.412, 354.078));
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_2", (42423, 16664.8, -583), (339.085, 204.711, 164.005));
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_2", (42558.8, 16441.9, -594.659), (338.039, 268.227, 151.674));
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_2", (42613.7, 16665.5, -366.528), (341.61, 118.659, 198.868));
  scripts\cp\raid_utility::pausemodetimer("vfx_raid_smoke_column", (42610.1, 16495.5, -640.002), (0, 107, 0));
  wait 0.25;
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42570.9, 16519.9, -517.571), (1.58926, 195.306, 1.01012));
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_2", (42706.8, 16481.8, -367.527), (288.424, 317.631, 68.1296));
  wait 0.25;
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42537.3, 16571.5, -382.172), (0, 0, 168.999));
  wait 0.25;
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42408.3, 16542.9, -382.157), (0, 0, 164.999));
  wait 0.25;
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42176.4, 16473.7, -382.092), (0, 0, 173.999));
  wait 0.2;
  scripts\cp\raid_utility::pausemodetimer("vfx_raid_big_fire", (42670.9, 16822.8, -368.998), (5.6547, 193.44, 1.89147));
  wait 0.1;
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42215.1, 16380.4, -382.157), (0, 0, 167.999));
  wait 0.4;
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42181.3, 16613, -379.426), (0, 0, 169.999));
  wait 0.1;
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42691.5, 16368, -360.016), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42494, 16781.1, -360.068), (8.65305, 193.54, 1.90393));
  scripts\cp\raid_utility::pausemodetimer("vfx_raid_big_fire", (42713.7, 16433.5, -363.777), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("vfx_raid_big_fire", (41949, 16462.9, -362.998), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("vfx_br_spot_fire_sml", (42743.4, 16725.1, -366.527), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("vfx_br_spot_fire_sml", (42973.5, 16521.4, -363.503), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("vfx_br_spot_fire_sml", (42330.3, 16200.4, -363.385), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("vfx_br_spot_fire_sml", (42759, 16904.5, -363.503), (5.6547, 193.44, 1.89147));
  wait 0.2;
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42361.1, 16563.5, -366.527), (275.445, 52.3922, 144.714));
  wait 0.1;
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42379.1, 16701.9, -360.149), (5.6547, 193.44, 1.89147));
  scripts\cp\raid_utility::pausemodetimer("vfx_br_spot_fire_sml", (42776.9, 16515.3, -372.527), (5.6547, 193.44, 1.89147));
  wait 0.2;
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42584.2, 16279.4, -360.373), (5.6547, 193.44, 1.89147));
  wait 0.1;
  scripts\cp\raid_utility::pausemodetimer("vfx_blockade_wire_fail_exp_1", (42435.8, 16342.2, -366.527), (275.022, 171.293, 22.0371));
}

function load_vfx() {
  level._effect["sniper_muzzle_flash"] = loadfx("vfx/iw8_cp/vfx_sniper_muzzle_flash.vfx");
  level._effect["sniper_red_laser"] = loadfx("vfx/iw8_cp/vfx_sniper_red_laser_cp.vfx");
}

function associate_digit_display_model() {
  level endon("game_ended");
  level endon("stop_pressure_sensor_monitor");
  var_0 = getEnt("blockade_bridge_pressure_sensor_trigger", "targetname");
  jumpiftrue(isDefined(level.vehicle_to_push)) LOC_00000039;

  for(;;) {
    jumpiftrue(isDefined(level.vehicle_to_push)) LOC_00000039;
    wait 0.5;
  }

  for(;;) {
    var_1 = level.vehicle_to_push gettagorigin("tag_grill");

    if(ispointinvolume(var_1, var_0)) {
      break;
    }

    var_2 = anglesToForward(level.vehicle_to_push.angles) * (1, 1, 0);
    var_3 = vectorNormalize(var_0.origin - var_1) * (1, 1, 0);

    if(vectordot(var_3, var_2) < 0) {
      break;
    }

    wait 0.1;
  }

  var_0 delete();
  level thread scripts\cp\bomb_defusal\coop_bomb_defusal::bombs_explode();
}

function ref_138c3() {
  level notify("stop_pressure_sensor_monitor");
  var_0 = getEnt("blockade_bridge_pressure_sensor_trigger", "targetname");
  var_0 delete();
}

function computermakingnose() {
  if(istrue(level.coop_bomb_defusal_count_down_started)) {
    return 2;
  }

  return 1;
}

function computer_listener_all(var_0) {
  level endon("game_ended");
  var_1 = getEnt("blockade_player_clip", "targetname");

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = (0, 0, -10000);
  var_1.original_origin = var_1.origin;
  jumpiftrue(istrue(var_0)) LOC_00000053;
  var_1.origin = var_1.original_origin + var_2;

  for(;;) {
    level waittill("blockade_barrier_clip", var_3);

    if(var_3 == "on") {
      var_1.origin = var_1.original_origin;
      continue;
    }

    if(var_3 == "off") {
      var_1.origin = var_1.original_origin + var_2;
      continue;
    }

    if(var_3 == "delete") {
      var_1 delete();
      return;
    }

    wait 0.05;
  }
}

function computer_interface_think_internal() {
  var_0 = getEntArray("player_trigger_hurt", "targetname");

  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_2 in var_0) {
    thread scripts\cp\raid_utility::ref_130a9(var_2);
  }
}

function blockade_landmine() {
  level.landmine_trig = getEnt("landmine_trig", "targetname");

  if(!isDefined(level.landmine_trig)) {
    return;
  }

  thread populate_landmine_signs();
  thread landmine_think();
}

function populate_landmine_signs() {
  var_0 = scripts\engine\utility::getStructArray("landmine_sign", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("me_sign_minefield_02");
    var_3.angles = var_2.angles;
    waitframe();
  }
}

function landmine_think() {
  self endon("death");
  self endon("entitydeleted");

  while(!istrue(self.landmine_disabled)) {
    self waittill("trigger", var_0, var_1, var_2, var_3, var_4, var_5);

    if(!isPlayer(var_0)) {
      continue;
    }

    if(!isDefined(var_0) || istrue(self.landmine_disabled)) {
      continue;
    }

    if(istrue(var_0.landmine_active)) {
      continue;
    }

    if(istrue(var_0.spectating)) {
      continue;
    }

    GscBinSkip4(0x35, var_0);
  }
}

function landmine_run_on_player(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0.landmine_active = 1;
  var_0.waiting_for_lethal_restock = var_0.origin;
  var_1 = 50000;
  var_2 = 3;
  var_3 = "";
  var_4 = var_0 getdroptofloorposition(var_0.origin);

  while(var_0 istouching(self) && var_2 > 0) {
    if(abs(var_0.origin[2] - var_4[2]) < 4) {
      break;
    }

    var_2 -= 0.05;
    wait 0.05;
  }

  var_5 = randomfloatrange(0.35, 0.75);
  var_6 = var_0.origin;
  var_7 = var_6;

  while(var_0 istouching(self) && var_5 > 0) {
    if(distance2dsquared(var_6, var_0.origin) >= 12) {
      break;
    }

    if(distance2dsquared(var_7, var_0.origin) > 2) {
      var_7 = var_0.origin;
      var_5 -= 0.05;
    }

    wait 0.05;
  }

  if(!var_0 istouching(self)) {
    var_0.shouldskipdeathsshield = undefined;
    var_0.landmine_active = 0;
    var_0.shouldskiplaststand = 0;
    return;
  }

  var_0.shouldskiplaststand = 1;
  var_4 = var_0 getdroptofloorposition(var_0.origin);
  var_8 = magicgrenademanual("at_mine_mp", var_4 + (0, 0, 10), (0, 0, 4), 0.05);
  var_9 = var_8.origin;
  var_8.owner = spawnStruct();
  var_8.owner.team = "axis";
  var_8.team = "axis";
  wait 0.1;
  var_0.shouldskipdeathsshield = 1;
  var_0 dodamage(var_1, var_0.origin, self);

  if(istrue(var_0.inlaststand)) {
    var_0 notify("force_bleed_out");
  }

  var_0 scripts\engine\utility::ref_143b9(1, "death");
  var_0.shouldskipdeathsshield = undefined;
  var_0.landmine_active = 0;
  var_0.shouldskiplaststand = 0;

  while(!isDefined(var_0.dogtag)) {
    wait 0.05;
  }

  var_10 = (0, 0, 40);

  if(isDefined(var_0.last_good_pos)) {
    var_0.dogtag.origin = var_0.last_good_pos + var_10;
    return;
  }

  if(isDefined(var_0.waiting_for_lethal_restock)) {
    var_0.dogtag.origin = getclosestpointonnavmesh(var_0.waiting_for_lethal_restock) + var_10;
    return;
  }

  var_0.dogtag.origin = getclosestpointonnavmesh(var_0.dogtag.origin) + var_10;
}