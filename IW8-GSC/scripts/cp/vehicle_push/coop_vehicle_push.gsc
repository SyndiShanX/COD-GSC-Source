/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicle_push\coop_vehicle_push.gsc
*********************************************************/

function start_coop_push(var0) {
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

function debug_pre_start_coop_push(var0) {
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

function pindia_positions_override_func(var0) {
  var0[0].canshootinvehicle = 0;
  var0[1].canshootinvehicle = 1;
  var0[2].canshootinvehicle = 1;
  var0[3].canshootinvehicle = 1;
  var0[4].canshootinvehicle = 1;
  var0[5].canshootinvehicle = 1;
  return var0;
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
  var0 = getEnt("escort_vehicle_push_volume", "targetname");
  var1 = getEnt("escort_vehicle_push_clip", "targetname");
  var2 = getvehiclenode("escort_vehicle_start", "targetname");
  var3 = spawnVehicle("veh8_mil_lnd_pindia_black_physics", "target_escort_vehicle", "pindia_physics", var2.origin, var2.angles);
  var3 attachpath(var2);
  var3 startpath();
  var3 vehicle_setspeedimmediate(0, 1, 1);
  var3 hidepart("tag_trunk");
  var3 hidepart("tag_accessory_02");
  thread vehicle_to_push_damage_monitor(var3);
  thread reach_end_monitor(var3);
  set_up_bomb_model_marker(var3, var3);
  var3.little_bird_mg_enterend = 1;
  var3.obj_ow_atvs_spawned = var0;
  var3.obj_overwatch_tanks_ref = var1;
  var4 = spawn("script_model", var3.origin);
  var4 notsolid();
  var4 setModel("veh8_mil_lnd_pindia_bomb");
  var4.angles = var3.angles;
  var4 linkTo(var3, "tag_origin_animate");
  thread cpoperationcrateactivatecallback(var4, var3);
  level.vehicle_to_push = var3;
  var1 linkTo(var3);
  var0 enablelinkTo();
  var0 linkTo(var3);
  thread player_push_monitor(var0, var0);
}

function set_up_bomb_model_marker(var0) {
  var1 = 5;
  var2 = 1;
  var3 = anglestoleft(var0.angles);
  var4 = anglestoup(var0.angles);
  var5 = scripts\engine\utility::getStruct("vehicle_to_push_bomb_marker", "targetname");
  var6 = spawn("script_model", var5.origin + var3 * var1 + var4 * var2);
  var6 setModel("tag_origin");
  var6.angles = var5.angles;
  var6 linkTo(var0);
  var0.bomb_model = var6;
}

function activate_bomb_interactions(var0, var1) {
  var2 = ref_11a90(var0);
  thread ref_12398(var2, var2);
}

function ref_11a90(var0) {
  var1 = var0.bomb_model.origin;
  var2 = spawn("script_model", var1);
  var2 setModel("tag_origin");
  var2.angles = var0.bomb_model.angles;
  var2 makeusable();
  var2 setHintString(&"COOP_VEHICLE_PUSH/PLACE_C4");
  var2 setCursorHint("HINT_BUTTON");
  var2 sethintdisplayrange(156);
  var2 sethintdisplayfov(90);
  var2 setuserange(128);
  var2 setusefov(60);
  var2 sethintonobstruction("show");
  var2 setuseholdduration("duration_short");
  var2 linkTo(var0);
  return var2;
}

function ref_12398(var0, var1) {
  var0 endon("death");

  for(;;) {
    var0 waittill("trigger", var2);

    if(isPlayer(var2)) {
      var2 playSound("cp_car_bomb_toss");
      break;
    }
  }

  place_bomb_in_the_vehicle(var1);
  var0 delete();
}

function place_bomb_in_the_vehicle(var0) {
  var0.bomb_model setModel("offhand_vm_briefcase_bomb_c4_cp");
  var0.bomb_model notsolid();
  var0 playSound("cp_car_bomb_drop");
  var0.bomb_is_loaded = 1;
  try_activate_final_bomb_detonate_sequence(var0);
}

function asm_animhasfacialoverridemp() {
  foreach(var1 in level.bombs_for_coop_bomb_defusal) {
    thread forbiddencachespawns(var1);
  }
}

function forbiddencachespawns(var0) {
  var1 = ref_11a78(var0.c4);

  for(;;) {
    var1 waittill("trigger", var2);

    if(isPlayer(var2)) {
      break;
    }
  }

  activate_bomb_interactions(level.vehicle_to_push, var2);

  foreach(var4 in var0.wire_look_at_markers) {
    var4.wire_model delete();
  }

  var0.c4 delete();
  var1 delete();
}

function ref_11a78(var0) {
  var1 = var0.origin + anglestoup(var0.angles) * 1;
  var2 = spawn("script_model", var1);
  var2 setModel("tag_origin");
  var2.angles = var0.angles;
  var2 makeusable();
  var2 setHintString(&"COOP_VEHICLE_PUSH/PICK_UP_C4");
  var2 setCursorHint("HINT_BUTTON");
  var2 sethintdisplayrange(156);
  var2 sethintdisplayfov(90);
  var2 setuserange(128);
  var2 setusefov(60);
  var2 sethintonobstruction("show");
  var2 setuseholdduration("duration_short");
  var2 linkTo(var0);
  return var2;
}

function player_push_monitor(var0, var1) {
  var1 endon("death");
  var2 = 0;
  var3 = 0;

  for(;;) {
    var4 = get_num_of_player_touching_volume(var0);

    if(var4 > 0) {
      level notify("vehicle_is_being_pushed");
    }

    if(var2 != var4) {
      var1 vehicle_setspeedimmediate(get_new_vehicle_speed(var4), 1, 1);

      if(var4 > 0) {
        if(var3 == 0) {
          var1 playLoopSound("temp_vehicle_surface_sfx");
          var3 = 1;
        }
      } else {
        var1 stoploopsound("temp_vehicle_surface_sfx");
        var3 = 0;
      }

      var2 = var4;
    }

    waitframe();
  }
}

function get_new_vehicle_speed(var0) {
  var1 = 0;

  switch (var0) {
    case 1:
      var1 = 1.405;
      break;
    case 2:
      var1 = 2.81;
      break;
    case 3:
      var1 = 2.81;
      break;
    case 4:
      var1 = 2.81;
      break;
  }

  return var1;
}

function get_num_of_player_touching_volume(var0) {
  var1 = 0;

  foreach(var3 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var3)) {
      continue;
    }

    if(var3 getstance() == "prone") {
      continue;
    }

    if(var3 istouching(var0)) {
      set_player_is_pushing_vehicle(var3);
      var1++;
    }
  }

  return var1;
}

function set_player_is_pushing_vehicle(var0) {
  if(!istrue(var0.is_pushing_vehicle)) {
    var0.is_pushing_vehicle = 1;
    thread continue_to_push_monitor(var0);
    return;
  }
}

function unset_player_is_pushing_vehicle(var0) {
  if(istrue(var0.is_pushing_vehicle)) {
    var0.is_pushing_vehicle = 0;
    return;
  }
}

function continue_to_push_monitor(var0) {
  var0 endon("disconnect");
  var1 = spawn("script_model", var0.origin);
  var1 setModel("tag_origin");
  var0 playerlinkTo(var1, "tag_origin");
  var1 linkTo(level.vehicle_to_push);
  thread player_mover_clean_up_monitor(var1, var0);
  thread player_push_vehicle_stance_update_think(var0);

  for(;;) {
    waitframe();
  }

  LOC_0000006b:
    var0 unlink();
  var0 allowstand(1);
  var0 allowcrouch(1);
  var0 allowprone(1);
  var0 notify("stop_pushing_vehicle");

  if(isDefined(var1)) {
    var1 delete();
  }

  unset_player_is_pushing_vehicle(var0);
}

function player_mover_clean_up_monitor(var0, var1) {
  var1 endon("death");
  var0 scripts\engine\utility::ref_143ad("disconnect", "last_stand");
  var1 delete();
}

function player_controller_push_along_vehicle(var0) {
  [var2] = var0 getnormalizedmovement();
  var3 = var1[1];

  if(abs(var2) == 0 && abs(var3) == 0) {
    return false;
  }

  var4 = get_player_controller_direction_in_world(var0);
  var5 = anglesToForward(level.vehicle_to_push.angles);
  var6 = acos(vectordot(var4, var5));
  return var6 >= 0 && var6 <= 30 || var6 >= 330 && var6 < 360;
}

function get_player_controller_direction_in_world(var0) {
  var1 = anglesToForward(var0 getplayerangles());
  var2 = anglestoright(var0 getplayerangles());
  [var4] = var0 getnormalizedmovement();
  var5 = var3[1];
  return vectorNormalize((var1 * var4 + var2 * var5) * (1, 1, 0));
}

function player_push_vehicle_stance_update_think(var0) {
  var0 endon("disconnect");
  var0 endon("stop_pushing_vehicle");
  var0 notify("player_push_vehicle_stance_update_think");
  var0 endon("player_push_vehicle_stance_update_think");
  var1 = var0 getstance();

  switch (var1) {
    case "stand":
      var0 allowstand(1);
      var0 allowcrouch(0);
      var0 allowprone(0);
      break;
    case "crouch":
      var0 allowcrouch(1);
      var0 allowstand(0);
      var0 allowprone(0);
      break;
    default:
      break;
  }

  var0 notifyonplayercommand("change_stance", "+stance");

  for(;;) {
    var0 waittill("change_stance");
    var1 = var0 getstance();

    switch (var1) {
      case "stand":
        var0 allowcrouch(1);
        var0 allowstand(0);
        var0 allowprone(0);
        break;
      case "crouch":
        var0 allowstand(1);
        var0 allowcrouch(0);
        var0 allowprone(0);
        break;
      default:
        break;
    }
  }
}

function vehicle_to_push_damage_monitor(var0) {
  var0 endon("death");
  var0 setCanDamage(1);
  var0.health = 999999;
  var0.maxhealth = 999999;

  for(;;) {
    var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    var0.health = 999999;
    var0.maxhealth = 999999;
  }
}

function reach_end_monitor(var0) {
  var0 endon("death");
  var0 waittill("reached_end_node");
  var0.reached_end_node = 1;
  try_activate_final_bomb_detonate_sequence(var0);
}

function try_activate_final_bomb_detonate_sequence(var0) {
  if(!istrue(var0.reached_end_node)) {
    return;
  }

  if(!istrue(var0.bomb_is_loaded)) {
    return;
  }

  var1 = get_nearby_players(var0);

  foreach(var3 in var1) {
    thread nearby_player_detonate_monitor(var3, var3);
  }

  foreach(var6 in level.players) {
    thread display_get_away_from_vehicle_message(var6, var6);
  }
}

function nearby_player_detonate_monitor(var0, var1) {
  var0 endon("disconnect");
  var1 endon("death");
  thread display_detonate_hint_message(var0, var0);
  thread detonate_the_bomb_monitor(var0, var0);
}

function get_nearby_players(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(distance2dsquared(var3.origin, var0.origin) < 360000) {
      var1 = var3;
    }
  }

  return var1;
}

function display_get_away_from_vehicle_message(var0, var1) {
  var0 endon("disconnect");
  var1 endon("death");

  for(;;) {
    if(distance2dsquared(var0.origin, var1.origin) < 360000) {
      var0 scripts\cp\utility::setlowermessage("too_close_to_vehicle_warning", &"COOP_VEHICLE_PUSH/GET_AWAY_FROM_VEHICLE");
    } else {
      var0 scripts\cp\utility::clearlowermessage("too_close_to_vehicle_warning");
    }

    waitframe();
  }
}

function display_detonate_hint_message(var0, var1) {
  var0 endon("disconnect");
  var1 endon("death");
  var1 endon("player_pressed_the_bomb_detonator");

  for(;;) {
    if(distance2dsquared(var0.origin, var1.origin) >= 360000) {
      var0 scripts\cp\utility::setlowermessage("detonate_final_bomb_hint", &"COOP_VEHICLE_PUSH/DETONATE_BOMB_HINT");
    } else {
      var0 scripts\cp\utility::clearlowermessage("detonate_final_bomb_hint");
    }

    waitframe();
  }
}

function detonate_the_bomb_monitor(var0, var1) {
  var0 endon("disconnect");
  var1 endon("death");
  var1 endon("player_pressed_the_bomb_detonator");
  var0 notifyonplayercommand("detonate_the_bomb", "+usereload");
  var0 notifyonplayercommand("detonate_the_bomb", "+activate");

  for(;;) {
    var0 waittill("detonate_the_bomb");

    if(distance2dsquared(var0.origin, var1.origin) < 360000) {
      continue;
    }

    thread the_bomb_is_detonated(var1, var0);
    return;
  }
}

function the_bomb_is_detonated(var0, var1) {
  var1 notify("player_pressed_the_bomb_detonator");

  foreach(var0 in level.players) {
    var0 scripts\cp\utility::clearlowermessage("detonate_final_bomb_hint");
  }

  var4 = getcompleteweaponname("c4_empty_mp");
  var0 giveandfireoffhand(var4);
  thread kingslayerkills(level);
  wait 1;
  var0 takeweapon(var4);
}

function kingslayerkills(var0) {
  wait 0.65;
  thread vehicle_to_push_explode_sequence(level);
}

function vehicle_to_push_explode_sequence(var0) {
  foreach(var2 in level.players) {
    var2 scripts\cp\utility::clearlowermessage("too_close_to_vehicle_warning");
  }

  var0 playSound("exp_bombsite_lr");
  computer_player_listener();
  var0.bomb_model delete();
  var0.obj_ow_atvs_spawned delete();
  var0.obj_overwatch_tanks_ref delete();
  var0 delete();
  thread open_blockade_gates();
  level notify("blockade_barrier_clip", "delete");
  level notify("blockade_sequence_successful");
}

function computer_player_listener() {
  var0 = (39906.7, 15306, -357.645);
  var1 = (0, 116.999, 0);
  scripts\cp\raid_utility::pausemodetimer("vfx_cp_raid_blockade_gate_explo", var0, var1);
}

function deploy_enemy_turrets() {
  scripts\engine\utility::flag_init("enemy_turret_only_target_players_in_kill_zone");
  scripts\engine\utility::flag_set("enemy_turret_only_target_players_in_kill_zone");
  var0 = undefined;

  if(true) {
    var0 = scripts\engine\utility::getStructArray("manned_turret", "targetname");
  }

  level.enemy_turrets = [];
  var1 = scripts\engine\utility::getStructArray("enemy_turret_marker", "targetname");

  foreach(var3 in var1) {
    if(1 && isDefined(var0) && var0.size > 0) {
      var0 = sortbydistance(var0, var3.origin);

      if(distancesquared(var0[0].origin, var3.origin) < 4096) {
        continue;
      }
    }

    deploy_enemy_turret(var3);
  }
}

function delete_on_death(var0, var1) {
  var0 endon("death");
  var1 waittill("death");
  var0 delete();
}

function spawn_tag_origin(var0, var1) {
  var2 = spawn("script_model", var0);
  var2 setModel("tag_origin");
  var2.angles = scripts\engine\utility::ter_op(isDefined(var1), var1, (0, 0, 0));
  return var2;
}

function deploy_enemy_turret(var0) {
  var1 = spawnturret("misc_turret", var0.origin, "iw8_mg_50cal_cp");
  var1.angles = var0.angles;
  var1 setModel("weapon_mg_bravo50_balcony");
  var1 setturretteam("axis");
  var1 setmode("manual");
  var1 setdefaultdroppitch(90);
  var1 setleftarc(180);
  var1 setrightarc(180);
  var1 settoparc(180);
  var1 setbottomarc(180);
  var1 setconvergencetime(0, "yaw");
  var1 setconvergencetime(0, "pitch");
  var1 makeunusable();
  var2 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var1.target_ent = spawn_tag_origin(var2.origin, var2.angles);
  var1.target_ent_marker = var2;
  var1 settargetentity(var1.target_ent);
  var1.speed = 150;
  var1.wait_between_shots = 0.1;
  var1.wait_between_shot_round = 1.5;
  var1.shots_per_round = 70;
  var1.track_target_delay = 0.1;
  var1.warning_time = 0.5;
  level.enemy_turrets[level.enemy_turrets.size] = var1;
  thread delete_on_death(var1.target_ent, var1.target_ent);
}

function activate_enemy_turret(var0) {
  if(istrue(var0.little_bird_mg_reenter)) {
    return;
  }

  thread enemy_turret_fire_think(var0);
  thread player_monitor(var0);
  thread combat_logic(var0);
}

function deactivate_enemy_turret(var0) {
  var0 notify("deactivate_enemy_turret");
  stop_firing(var0);
}

function combat_logic(var0) {
  var0 endon("death");
  var0 endon("deactivate_enemy_turret");
  thread target_select_think(var0);
  var1 = undefined;

  for(;;) {
    if(isDefined(var0.current_target)) {
      if(is_different_target(var1, var0.current_target)) {
        stop_firing(var0);
        wait randomfloatrange(0.5, 1);
      }

      if(!isDefined(var1)) {
        start_firing(var0);
      }
    } else {
      stop_firing(var0);
    }

    var1 = var0.current_target;
    wait 0.5;
  }
}

function is_different_target(var0, var1) {
  return isDefined(var0) && var0 != var1;
}

function target_select_think(var0) {
  var0 endon("death");
  var0 endon("deactivate_enemy_turret");
  var0.current_target = undefined;

  for(;;) {
    var1 = scripts\cp\raid_utility::get_players_not_in_laststand();

    if(scripts\engine\utility::flag("enemy_turret_only_target_players_in_kill_zone")) {
      var1 = get_players_in_killzone(var1);
    }

    var2 = 9;
    var3 = undefined;

    foreach(var5 in var1) {
      var6 = get_player_target_score(var5, var0);

      if(var6 > var2) {
        var2 = var6;
        var3 = var5;
      }
    }

    if(isDefined(var3)) {
      var0.current_target = var3;
      var0.target_ent.origin = get_target_ent_position_on_player(var3, var0);
    } else {
      var0.current_target = undefined;
      var0.target_ent.origin = var0.target_ent_marker.origin;
    }

    wait 0.05;
  }
}

function get_players_in_killzone(var0) {
  var1 = [];
  var2 = getEnt("bridge_kill_zone", "targetname");

  foreach(var4 in var0) {
    if(var4 istouching(var2)) {
      var1 = var4;
    }
  }

  return var1;
}

function player_is_in_killzone(var0) {
  var1 = getEnt("bridge_kill_zone", "targetname");

  if(var0 istouching(var1)) {
    return 1;
  }

  return 0;
}

function get_target_ent_position_on_player(var0, var1) {
  var2 = var0 getvelocity();
  var3 = var1 gettagorigin("tag_flash");
  var4 = distance(var3, var0.origin);
  var5 = var4 / 6000;
  var6 = var0.origin + var2 * var5;

  if(is_player_part_exposed_to_enemy_turret(var0, var1, "origin")) {
    return var6;
  }

  return var6 + var0 getEye() - var0.origin;
}

function get_player_target_score(var0, var1) {
  var2 = 25000000;
  var3 = 0;

  if(is_player_part_exposed_to_enemy_turret(var0, var1, "eye")) {
    var3 += 45;
  }

  if(is_player_part_exposed_to_enemy_turret(var0, var1, "origin")) {
    var3 += 45;
  }

  var4 = distance2dsquared(var0.origin, var1.origin);
  var3 += 9 * (1 - clamp(var4 / var2, 0, 1));
  return var3;
}

function is_player_part_exposed_to_enemy_turret(var0, var1, var2) {
  var3 = var1.player_exposure_data[var0 getentitynumber()];
  return scripts\engine\utility::array_contains(var3.loc_exposed_to_enemy_turret, var2);
}

function player_monitor(var0) {
  foreach(var2 in level.players) {
    thread enemy_turret_player_monitor(var2, var2);
  }

  thread enemy_turret_players_connect_monitor(level);
}

function enemy_turret_players_connect_monitor(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("deactivate_enemy_turret");

  for(;;) {
    level waittill("connected", var1);
    thread enemy_turret_player_monitor(var1, var1);
  }
}

function enemy_turret_player_monitor(var0, var1) {
  thread exposure_monitor(var0, var0);
  thread speed_monitor(var0, var0);
}

function exposure_monitor(var0, var1) {
  var0 endon("disconnect");
  var1 endon("death");
  var1 endon("deactivate_enemy_turret");

  if(!isDefined(var1.player_exposure_data)) {
    var1.player_exposure_data = [];
  }

  var2 = var0 getentitynumber();
  var3 = spawnStruct();
  var4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
  var3.exposed_to_enemy_turret_time = 0;

  for(;;) {
    var3.loc_exposed_to_enemy_turret = [];

    if(scripts\engine\trace::ray_trace_passed(var0.origin, var1 gettagorigin("tag_aim"), [var1], var4)) {
      var3.loc_exposed_to_enemy_turret[var3.loc_exposed_to_enemy_turret.size] = "origin";
    }

    if(scripts\engine\trace::ray_trace_passed(var0 getEye() + (0, 0, -5), var1 gettagorigin("tag_aim"), [var1], var4)) {
      var3.loc_exposed_to_enemy_turret[var3.loc_exposed_to_enemy_turret.size] = "eye";
    }

    if(var3.loc_exposed_to_enemy_turret.size > 0) {
      var3.exposed_to_enemy_turret_time += 0.05;
    } else {
      var3.exposed_to_enemy_turret_time = 0;
    }

    var1.player_exposure_data[var2] = var3;
    waitframe();
  }
}

function speed_monitor(var0, var1) {
  var0 endon("disconnect");
  var1 endon("death");
  var1 endon("deactivate_enemy_turret");

  for(;;) {
    var2 = var0.origin;
    wait 0.05;
    var3 = var0.origin;
    var0.speed = length(var2 - var3);
  }
}

function enemy_turret_fire_think(var0) {
  var0 endon("death");
  var0 endon("deactivate_enemy_turret");

  for(;;) {
    var0 waittill("start_firing");
    reset_enemy_turret_shot_count(var0);
    wait var0.warning_time;

    while(enemy_turret_should_keep_firing(var0)) {
      fire_one_shot(var0);
      wait var0.wait_between_shots;

      if(!should_continue_current_shot_run(var0)) {
        if(get_shot_fired(var0) == var0.shots_per_round) {
          reset_enemy_turret_shot_count(var0);
          wait var0.wait_between_shot_round;
        }

        if(!enemy_turret_should_keep_firing(var0)) {
          break;
        }
      }
    }
  }
}

function fire_one_shot(var0) {
  var0 shootturret();
  var0.shot_count++;
}

function reset_enemy_turret_shot_count(var0) {
  var0.shot_count = 0;
}

function enemy_turret_should_keep_firing(var0) {
  return istrue(var0.keep_firing);
}

function start_firing(var0) {
  var0.keep_firing = 1;
  var0 notify("start_firing");
}

function stop_firing(var0) {
  var0.keep_firing = 0;
}

function should_continue_current_shot_run(var0) {
  if(!enemy_turret_should_keep_firing(var0)) {
    return false;
  }

  if(get_shot_fired(var0) == var0.shots_per_round) {
    return false;
  }

  return true;
}

function get_shot_fired(var0) {
  return var0.shot_count;
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
    level waittill("laststand_dogtag_spawned", var0);
    var1 = var0.owner;
    thread ref_12d12(var1);

    if(triggerremoveobjectivetext(var0)) {
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

function ref_12d12(var0) {
  var1 = 20;
  var2 = var0 scripts\engine\utility::ref_143ad("revive", "disconnect");

  if(var2 == "revive") {
    wait var1;
    scripts\engine\utility::flag_clear("heavy_enemy_spawning_paused");
    return;
  }

  if(var2 == "disconnect") {
    var3 = questrewarduav();

    if(var3 == 0) {
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
    level waittill("laststand_dogtag_spawned", var0);
    level.watch_and_open_scriptable_doors_in_radius = scripts\engine\utility::array_removeundefined(level.watch_and_open_scriptable_doors_in_radius);
    level.watch_and_open_scriptable_doors_in_radius = scripts\engine\utility::array_add(level.watch_and_open_scriptable_doors_in_radius, var0);
  }
}

function questrewarduav() {
  var0 = 0;

  foreach(var2 in level.watch_and_open_scriptable_doors_in_radius) {
    if(triggerremoveobjectivetext(var2)) {
      var0++;
    }
  }

  return var0;
}

function buy_points() {
  var0 = 0;

  foreach(var2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var2)) {
      continue;
    }

    if(triggerremoveobjectivetext(var2)) {
      var0 = 1;
      break;
    }
  }

  return var0;
}

function triggerremoveobjectivetext(var0) {
  var1 = getEnt("bridge_kill_zone", "targetname");
  var2 = getEnt("under_bridge_zone", "targetname");

  if(ispointinvolume(var0.origin, var1)) {
    return true;
  }

  if(ispointinvolume(var0.origin, var2)) {
    return true;
  }

  return false;
}

function ref_12500() {
  var0 = ["player_left_vindia", "player_right_vindia"];

  for(var1 = 5; var1 > 0; var1--) {
    var0 = scripts\engine\utility::array_randomize(var0);
  }

  for(;;) {
    if(any_player_under_bridge()) {
      break;
    }

    wait 1;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module(var0[0]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_five");
  scripts\cp\cp_modular_spawning::run_spawn_module(var0[1]);
}

function underbridge_enemy_monitor(var0) {
  var1 = self;
  c4vehiclecooperator(var1);
  thread underbridge_enemy_death_monitor(var1);
}

function ref_13f04(var0) {
  var1 = self;
  c4vehiclecooperator(var1);
}

function nocrouch(var0) {
  var1 = self;
  c4vehiclecooperator(var1);
}

function nextswitch(var0) {
  var1 = self;
  c4vehiclecooperator(var1);
}

function c4vehiclecooperator(var0) {
  var0.maxfaceenemydist = 1200;
  var0 scripts\cp\cp_modular_spawning::numfound();
}

function underbridge_enemy_death_monitor(var0) {
  var0 waittill("death");
  level notify("underbridge_enemy_death");
}

function waittill_all_spawns_dead_and_time(var0, var1, var2, var3, var4) {
  var0 endon("death");

  if(isbuiltinfunction(var1)) {
    var5 = [[var1]]();
  } else {
    var5 = var2;
  }

  var6 = 0;

  for(;;) {
    level waittill(var3);
    var6++;

    if(var6 == var5) {
      break;
    }
  }

  return randomfloatrange(var4, var5);
}

function get_enemy_right_max_spawn(var0) {
  if(scripts\engine\utility::flag("vehicle_bridge_stage_five")) {
    return 4;
  }

  if(scripts\engine\utility::flag("vehicle_bridge_stage_four")) {
    return 3;
  }

  return 2;
}

function get_enemy_left_max_spawn(var0) {
  if(scripts\engine\utility::flag("vehicle_bridge_stage_five")) {
    return 5;
  }

  if(scripts\engine\utility::flag("vehicle_bridge_stage_four")) {
    return 4;
  }

  return 3;
}

function get_under_bridge_max_spawn(var0) {
  if(scripts\engine\utility::flag("vehicle_bridge_stage_five")) {
    return 2;
  }

  return 1;
}

function get_enemy_rpg_max_spawn(var0) {
  if(scripts\engine\utility::flag("vehicle_bridge_stage_three")) {
    return 2;
  }

  return 1;
}

function get_enemy_sniper_max_spawn(var0) {
  if(scripts\engine\utility::flag("vehicle_bridge_stage_two")) {
    return 2;
  }

  return 1;
}

function select_left_turret_spawners(var0) {
  if(true) {
    return scripts\cp\raid_utility::select_random_spawners("left_manned_turret_spawner");
  }

  return scripts\cp\raid_utility::select_random_spawners("left_enemy_turret_spawner");
}

function select_right_turret_spawners(var0) {
  if(true) {
    return scripts\cp\raid_utility::select_random_spawners("right_manned_turret_spawner");
  }

  return scripts\cp\raid_utility::select_random_spawners("right_enemy_turret_spawner");
}

function select_middle_turret_spawners(var0) {
  return scripts\cp\raid_utility::select_random_spawners("middle_enemy_turret_spawner");
}

function select_enemy_right_spawners(var0) {
  return scripts\cp\raid_utility::select_random_spawners("enemy_right_spawner");
}

function select_enemy_left_spawners(var0) {
  return scripts\cp\raid_utility::select_random_spawners("enemy_left_spawner");
}

function select_under_bridge_reinforce_spawners(var0) {
  return scripts\cp\raid_utility::select_random_spawners("under_bridge_reinforce_spawner");
}

function select_mid_bridge_right_spawners(var0) {
  return scripts\cp\raid_utility::select_random_spawners("mid_bridge_right_spawner");
}

function select_mid_bridge_left_spawners(var0) {
  return scripts\cp\raid_utility::select_random_spawners("mid_bridge_left_spawner");
}

function select_end_bridge_stair_spawners(var0) {
  return scripts\cp\raid_utility::select_random_spawners("end_bridge_stair_spawner");
}

function select_enemy_sniper_spawners(var0) {
  return scripts\cp\raid_utility::select_random_spawners("enemy_sniper_spawner");
}

function select_enemy_rpg_spawners(var0) {
  return scripts\cp\raid_utility::select_random_spawners("blockade_RPG_spawner");
}

function select_mortar_spawners(var0) {
  return scripts\cp\raid_utility::select_random_spawners("mortar_spawner");
}

function left_turret_wait_between_spawn(var0) {
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

function wait_no_vehicles_and_time(var0, var1, var2, var3) {
  var0 endon("death");
  var0 waittill("vehicle_removed_from_group");
  wait randomfloatrange(var1, var2);
}

function wait_all_spawns_dead(var0, var1, var2, var3) {
  var0 endon("death");
  var0 waittill("all_group_spawns_dead");
}

function ref_143ce(var0, var1, var2, var3) {
  var0 endon("death");

  if(isbuiltinfunction(var1)) {
    var4 = [[var1]]();
  } else {
    var4 = var2;
  }

  if(var1.spawn_count % var4 == 0) {
    if(var1 scripts\cp\cp_modular_spawning::get_activecount_from_group(1) > 0) {
      var1 waittill("active_all_group_spawns_dead");

      if(scripts\engine\utility::flag("heavy_enemy_spawning_paused")) {
        scripts\engine\utility::flag_waitopen("heavy_enemy_spawning_paused");
      }

      return randomfloatrange(var3, var4);
    }

    return 1.5;
  }

  return 1.5;
}

function waittill_num_and_all_spawns_dead_and_time(var0, var1, var2, var3) {
  var0 endon("death");

  if(isbuiltinfunction(var1)) {
    var4 = [[var1]]();
  } else {
    var4 = var2;
  }

  if(var1.spawn_count % var4 == 0) {
    if(var1 scripts\cp\cp_modular_spawning::get_activecount_from_group(1) > 0) {
      var1 waittill("active_all_group_spawns_dead");
      return randomfloatrange(var3, var4);
    }

    return 1.5;
  }

  return 1.5;
}

function wait_all_spawns_dead_and_time(var0, var1, var2, var3) {
  var0 endon("death");
  var0 waittill(var3);
  wait randomfloatrange(var1, var2);
}

function run_cp_blockade_start_spawning() {
  wait 5;
  scripts\cp\cp_modular_spawning::run_spawn_module("left_enemy_turret");
  scripts\cp\cp_modular_spawning::run_spawn_module("right_enemy_turret");
  scripts\cp\cp_modular_spawning::run_spawn_module("bomb_guardian");
  var0 = get_player_side_spawn_group_randomized();
  var1 = get_rpg_group_randomized();
  var2 = get_mortar_group_randomized();
  var3 = get_sniper_group_randomized();
  var4 = get_enemy_group_randomized();
  scripts\engine\utility::flag_wait("vehicle_entered_bridge");
  scripts\cp\cp_modular_spawning::run_spawn_module(var1[0]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_one");
  scripts\cp\cp_modular_spawning::run_spawn_module(var0[0]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var1[1]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_two");
  scripts\cp\cp_modular_spawning::run_spawn_module(var0[1]);
  scripts\cp\cp_modular_spawning::run_spawn_module("mid_bridge");
  scripts\cp\cp_modular_spawning::run_spawn_module(var3[0]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var1[2]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_three");
  scripts\cp\cp_modular_spawning::run_spawn_module("end_bridge");
  scripts\cp\cp_modular_spawning::run_spawn_module(var3[1]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_four");
  scripts\cp\cp_modular_spawning::run_spawn_module("old_bridge");
  scripts\cp\cp_modular_spawning::run_spawn_module(var4[0]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var3[2]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var2[0]);
  activate_mortar(var2[0]);
  scripts\engine\utility::flag_wait("vehicle_bridge_stage_five");
  scripts\cp\cp_modular_spawning::run_spawn_module(var4[1]);
  scripts\cp\cp_modular_spawning::run_spawn_module(var2[1]);
  activate_mortar(var2[1]);
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

function activate_mortar(var0) {
  var1 = getEnt(var0, "targetname");
  thread mortar_think(var1);
}

function mortar_think(var0) {
  var0 endon("stop_mortar_think");
  var0.targets = undefined;

  for(;;) {
    var1 = scripts\cp\raid_utility::get_players_not_in_laststand();
    var1 = get_players_in_killzone(var1);

    if(var1.size > 0) {
      var0.targets = var1;
      scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_mortar(var0);
      var0.targets = undefined;
      wait randomintrange(5, 10);
      continue;
    }

    wait 1;
  }
}

function get_randomized_group(var0) {
  for(var1 = 0; var1 < 5; var1++) {
    var0 = scripts\engine\utility::array_randomize(var0);
  }

  return var0;
}

function bridge_stair_up_enemy(var0) {
  var1 = self;
  thread bridge_stair_up_combat_think(var1);
}

function bridge_stair_up_combat_think(var0) {
  self endon("death");
  level endon("game_ended");
  var1 = self;
  var1 waittill("reached_path_end");

  if(any_player_under_bridge()) {
    thread go_hunt_down_player(var1, var1);
    return;
  }

  thread go_hunt_down_player(var1, var1);
}

function activate_sniper(var0) {
  var1 = self;
  var1.neverforcesnipermissenemy = 1;
  var1.sniperaccuracyset = 1;
  var1.baseaccuracy = 1;
  var1 laseron();
  c4vehiclecooperator(var1);
  thread delay_activate_laser(var1);
}

function activate_mortar_enemy(var0) {
  var1 = self;
  var1.dontevershoot = 1;
}

function delay_activate_laser(var0) {
  var0 endon("death");
  var0 scripts\engine\utility::ref_143a5("goal", "goal_reached");
  var0.gunposeoverride = "ads";
  thread sniper_player_monitor(var0);
  thread sniper_target_think(var0);
  thread sniper_laser_think(var0);
}

function sniper_player_monitor(var0) {
  foreach(var2 in level.players) {
    thread enemy_sniper_player_monitor(var2, var2);
  }

  thread sniper_players_connect_monitor(level);
}

function sniper_players_connect_monitor(var0) {
  level endon("game_ended");
  var0 endon("death");

  for(;;) {
    level waittill("connected", var1);
    thread enemy_sniper_player_monitor(var1, var1);
  }
}

function enemy_sniper_player_monitor(var0, var1) {
  thread exposure_to_sniper_monitor(var0, var0);
}

function exposure_to_sniper_monitor(var0, var1) {
  var0 endon("disconnect");
  var1 endon("death");

  if(!isDefined(var1.player_exposure_data)) {
    var1.player_exposure_data = [];
  }

  var2 = var0 getentitynumber();
  var3 = spawnStruct();
  var4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
  var3.exposed_to_enemy_sniper_time = 0;

  for(;;) {
    var3.loc_exposed_to_enemy_sniper = [];

    if(scripts\engine\trace::ray_trace_passed(var0.origin, var1 getEye(), [var1], var4)) {
      var3.loc_exposed_to_enemy_sniper[var3.loc_exposed_to_enemy_sniper.size] = "origin";
    }

    if(scripts\engine\trace::ray_trace_passed(var0 getEye(), var1 getEye(), [var1], var4)) {
      var3.loc_exposed_to_enemy_sniper[var3.loc_exposed_to_enemy_sniper.size] = "eye";
    }

    if(scripts\engine\trace::ray_trace_passed(var0 gettagorigin("j_spineupper"), var1 getEye(), [var1], var4)) {
      var3.loc_exposed_to_enemy_sniper[var3.loc_exposed_to_enemy_sniper.size] = "chest";
    }

    if(var3.loc_exposed_to_enemy_sniper.size > 0) {
      var3.exposed_to_enemy_sniper_time += 0.05;
    } else {
      var3.exposed_to_enemy_sniper_time = 0;
    }

    var1.player_exposure_data[var2] = var3;
    waitframe();
  }
}

function sniper_target_think(var0) {
  var0 endon("death");
  var0.current_target = undefined;

  for(;;) {
    var1 = scripts\cp\raid_utility::get_players_not_in_laststand();
    var2 = 9;
    var3 = undefined;

    foreach(var5 in var1) {
      if(!isDefined(var5.num_sniper_covering_me)) {
        var5.num_snipers_covering_me = 0;
      }

      var6 = get_player_target_score_for_sniper(var5, var0);

      if(var6 > var2) {
        var2 = var6;
        var3 = var5;
      }
    }

    if(isDefined(var3) && is_new_target(var3, var0)) {
      if(has_current_target(var0)) {
        wait randomfloatrange(0.5, 1);
        unmark_player_as_sniper_target(var0.current_target);
      }

      mark_player_as_sniper_target(var0, var3);
      thread sniper_death_monitor(var3, var3);
      var8 = var3 scripts\engine\utility::ref_143b9(randomfloatrange(1.5, 2), "last_stand");

      if(var8 == "last_stand") {
        unmark_player_as_sniper_target(var3);
        wait 1.5;
      }

      continue;
    }

    wait 0.05;
  }
}

function has_current_target(var0) {
  return isDefined(var0.current_target);
}

function is_new_target(var0, var1) {
  if(!has_current_target(var1)) {
    return true;
  }

  return var1.current_target != var0;
}

function mark_player_as_sniper_target(var0, var1) {
  var0.current_target = var1;
  var0 getenemyinfo(var1);
  var0 setlookatentity(var1);
  var0.favoriteenemy = var1;
  var1.num_snipers_covering_me += 1;
}

function unmark_player_as_sniper_target(var0) {
  var0.num_snipers_covering_me -= 1;
}

function sniper_death_monitor(var0, var1) {
  var0 endon("disconnect");
  var1 waittill("death");
  unmark_player_as_sniper_target(var0);
}

function get_player_target_score_for_sniper(var0, var1) {
  var2 = 25000000;
  var3 = 0;

  if(is_player_part_exposed_to_sniper(var0, var1, "eye")) {
    var3 += 45;
  }

  if(is_player_part_exposed_to_sniper(var0, var1, "origin")) {
    var3 += 45;
  }

  if(player_is_in_killzone(var0)) {
    var3 += 200;
  }

  var4 = get_player_expose_time_to_sniper(var0, var1);
  var3 += var4 * 10;
  var3 = int(max(0, var3 + var0.num_snipers_covering_me * -45));
  var5 = distance2dsquared(var0.origin, var1.origin);
  var3 += 9 * (1 - clamp(var5 / var2, 0, 1));
  var3 += randomfloat(18);
  return var3;
}

function is_player_part_exposed_to_sniper(var0, var1, var2) {
  var3 = var1.player_exposure_data[var0 getentitynumber()];
  return scripts\engine\utility::array_contains(var3.loc_exposed_to_enemy_sniper, var2);
}

function get_player_expose_time_to_sniper(var0, var1) {
  var2 = var1.player_exposure_data[var0 getentitynumber()];
  return var2.exposed_to_enemy_sniper_time;
}

function sniper_laser_think(var0) {
  var0 endon("death");
  var1 = var0 gettagorigin("tag_laser_attach");
  var2 = create_tag_origin(var1, var0);
  thread follow_tag_laser_attach(var2, var0);
  var3 = create_tag_origin(var1, var0);
  var0.laser_start_ent = var2;
  var0.laser_end_ent = var3;
  thread waittill_any_return_no_endon_death_2(var0);

  for(;;) {
    if(has_current_target(var0)) {
      if(player_is_exposed_to_sniper(var0.current_target, var0)) {
        if(!istrue(var3.is_linked_to_target)) {
          var4 = get_target_tag_to_link_to(var0.current_target, var0);
          var5 = var0.current_target gettagorigin(var4);
          var3.origin = var5;
          var3 linkTo(var0.current_target, var4);
          var3.is_linked_to_target = 1;
        }
      } else {
        var3 unlink();
        var3.is_linked_to_target = 0;
        var6 = get_laser_end_pos(var0.current_target, var2);
        var3 moveTo(var6, 0.25);
      }
    }

    wait 0.05;
  }
}

function waittill_any_return_no_endon_death_2(var0) {
  var0 endon("death");
  ref_13e50(var0);

  for(;;) {
    if(!ref_1343b(var0) && ref_1343c(var0)) {
      ref_13e50(var0);
    } else if(ref_1343b(var0) && !ref_1343c(var0)) {
      ref_13e43(var0);
    }

    waitframe();
  }
}

function ref_13e50(var0) {
  var1 = playfxontagsbetweenclients(level._effect["sniper_red_laser"], var0.laser_start_ent, "tag_origin", var0.laser_end_ent, "tag_origin");
  var0.ref_1343d = var1;
}

function ref_13e43(var0) {
  var0.ref_1343d delete();
}

function ref_1343b(var0) {
  return isDefined(var0.ref_1343d);
}

function ref_1343c(var0) {
  var1 = 0.5;
  var2 = anglesToForward(var0 getplayerangles());
  var3 = vectorNormalize(var0.laser_end_ent.origin - var0.laser_start_ent.origin);
  var4 = vectordot(var3, var2);

  if(var4 < var1) {
    return false;
  }

  var5 = var0 getcurrentweapon();

  if(var5.classname != "sniper") {
    return false;
  }

  return true;
}

function get_target_tag_to_link_to(var0, var1) {
  if(is_player_part_exposed_to_sniper(var0, var1, "chest")) {
    return "j_spineupper";
  }

  if(is_player_part_exposed_to_sniper(var0, var1, "eye")) {
    return "tag_eye";
  }

  return "tag_origin";
}

function follow_tag_laser_attach(var0, var1) {
  var1 endon("death");

  for(;;) {
    if(var0 tagexists("tag_laser_attach")) {
      var2 = var0 gettagorigin("tag_laser_attach");
      var1.origin = var2;
    }

    waitframe();
  }
}

function try_shoot_at_current_target(var0, var1) {
  var2 = var0.current_target;

  if(!isDefined(var2.time_stamp_can_be_damaged_by_sniper)) {
    var2.time_stamp_can_be_damaged_by_sniper = 0;
  }

  if(player_can_take_sniper_damage(var2) && player_expose_to_sniper_long_enough(var2, var0)) {
    var3 = var2.origin - var1.origin;
    playFX(level._effect["sniper_muzzle_flash"], var1.origin, var3);
    var0 playSound("sniper_crack_far_near_cp");
    var2 dodamage(80, var0.origin, var0);
    set_next_can_take_sniper_damage_time_stamp(var2);
    return;
  }
}

function player_can_take_sniper_damage(var0) {
  var1 = gettime();
  return var1 > var0.time_stamp_can_be_damaged_by_sniper;
}

function set_next_can_take_sniper_damage_time_stamp(var0) {
  var1 = gettime();
  var0.time_stamp_can_be_damaged_by_sniper = var1 + randomfloatrange(3, 4) * 1000;
}

function player_expose_to_sniper_long_enough(var0, var1) {
  return get_player_expose_time_to_sniper(var0, var1) >= 1;
}

function mark_laser_end_ent(var0) {
  var0 endon("death");

  for(;;) {
    waitframe();
  }
}

function get_laser_end_pos(var0, var1) {
  var2 = 40;
  var3 = 2;
  var4 = 40;
  var5 = 50;
  var6 = 25;
  var7 = 35;
  var8 = 10;
  var9 = 5;
  var10 = anglesToForward(var0 getplayerangles());
  var11 = var0 getEye() + var10 * var2;
  var11 = (var11[0] + randomfloatrange(var3 * -1, var3), var11[1] + randomfloatrange(var3 * -1, var3), var11[2]);
  var11 = scripts\engine\utility::drop_to_ground(var11, 0, -500);
  var12 = var0 getstance();

  switch (var12) {
    case "stand":
      var11 = (var11[0], var11[1], var11[2] + randomfloatrange(var4, var5));
      break;
    case "prone":
    case "crouch":
      var11 = (var11[0], var11[1], var11[2] + randomfloatrange(var6, var7));
      break;
  }

  var13 = vectorNormalize(var11 - var1.origin);
  var14 = var1.origin + var13 * 20000;
  var15 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
  var11 = scripts\engine\trace::ray_trace(var1.origin, var14, undefined, var15);

  if(player_is_near_vehicle_to_push(var0)) {
    if(player_is_facing_away_from_vehicle_to_push(var0)) {
      var16 = var11["position"] + (0, 0, 21);
      var17 = vectorNormalize(var16 - var1.origin);
      var18 = anglestoright(vectortoangles(var17));
      var16 += var18 * randomfloatrange(var8 * -1, var8);
      var17 = vectorNormalize(var16 - var1.origin);
      var14 = var1.origin + var17 * 20000;
      var15 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
      var11 = scripts\engine\trace::ray_trace(var1.origin, var14, undefined, var15);
    } else if(player_is_facing_vehicle_to_push(var0)) {
      var16 = var11["position"] + (0, 0, 23);
      var17 = vectorNormalize(var16 - var1.origin);
      var18 = anglestoright(vectortoangles(var17));
      var16 += var18 * randomfloatrange(var9 * -1, var9);
      var17 = vectorNormalize(var16 - var1.origin);
      var14 = var1.origin + var17 * 20000;
      var15 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);
      var11 = scripts\engine\trace::ray_trace(var1.origin, var14, undefined, var15);
    }
  }

  return var11["position"];
}

function player_is_near_vehicle_to_push(var0) {
  if(istrue(var0.is_pushing_vehicle)) {
    return true;
  }

  if(!isDefined(level.vehicle_to_push)) {
    return false;
  }

  return distance2dsquared(var0.origin, level.vehicle_to_push.origin) <= 40000;
}

function player_is_facing_away_from_vehicle_to_push(var0) {
  var1 = anglesToForward(var0 getplayerangles());
  var2 = anglesToForward(level.vehicle_to_push.angles);
  var3 = var2 * -1;
  var4 = acos(vectordot(var1, var3));
  return abs(var4) < 75;
}

function player_is_facing_vehicle_to_push(var0) {
  var1 = anglesToForward(var0 getplayerangles());
  var2 = anglesToForward(level.vehicle_to_push.angles);
  var3 = acos(vectordot(var1, var2));
  return abs(var3) < 80;
}

function player_is_exposed_to_sniper(var0, var1) {
  var2 = var0 getentitynumber();
  return var1.player_exposure_data[var2].exposed_to_enemy_sniper_time > 0;
}

function create_tag_origin(var0, var1) {
  var2 = spawn("script_model", var0);
  var2 setModel("tag_origin");
  thread clean_up_think(var2, var2);
  return var2;
}

function clean_up_think(var0, var1) {
  var0 endon("death");
  var1 waittill("death");
  var0 delete();
}

function bomb_guardian_watcher(var0) {
  var1 = self;
  thread bomb_guardian_death_watcher_internal(var1);
}

function bomb_guardian_death_watcher_internal(var0) {
  var0 waittill("death");
  scripts\cp\bomb_defusal\coop_bomb_defusal::drop_bomb_detonator_from_ai(var0, "bomb_case");
  level.bomb_guardian_is_killed = 1;
}

function turret_enemy_watcher(var0) {
  thread ref_13e67(var0);
}

function ref_13e67(var0) {
  var1 = self;
  wait 0.05;
  var1 notify("basic_combat");

  if(isDefined(var1.spawnpoint) && issubstr(var1.spawnpoint.targetname, "manned_turret")) {
    if(isDefined(var1.spawnpoint.target)) {
      var2 = scripts\engine\utility::getStruct(var1.spawnpoint.target, "targetname");

      if(isDefined(var2)) {
        var1 setgoalpos(var2.origin);
        var1.script_origin_other = var2.origin;
      }
    }

    var1.goalradius = 64;
    var1 allowedstances("stand");
    var1.combatmode = "no_cover";
    return;
  }

  var1.goalradius = 10;
  var1.dontevershoot = 1;
  thread activate_enemy_turret_when_reach_it(var1);
}

function enemy_mortar_think(var0) {
  var1 = self;
  c4vehiclecooperator(var1);
  thread activate_mortar_when_reach_path_end(var1);
}

function activate_mortar_when_reach_path_end(var0) {
  var0 endon("death");
  level endon("post_blockade_combat");

  if(scripts\engine\utility::flag("post_blockade_combat")) {
    thread go_hunt_down_player(var0, var0);
    return;
  }

  var0 waittill("reached_path_end");
  var1 = scripts\engine\utility::getclosest(var0.origin, getEntArray("enemy_mortar", "targetname"));
  var0.ignoreall = 1;
  thread mortar_think(var1);
  thread mortar_enemy_death_watcher(var0, var0);
}

function mortar_enemy_death_watcher(var0, var1) {
  var0 waittill("death");
  var1 notify("stop_mortar_think");
  var1.targets = undefined;
}

function activate_enemy_turret_when_reach_it(var0) {
  var0 endon("death");
  level endon("post_blockade_combat");
  var0 scripts\engine\utility::ref_143a5("goal", "goal_reached");
  var1 = scripts\engine\utility::getclosest(var0.origin, level.enemy_turrets);
  activate_enemy_turret(var1);
  var0 allowedstances("stand");
  var0 setlookatentity(var1);
  var0.ignoreall = 1;
  var0.combatmode = "no_cover";
  link_to_turret_enemy_mover(var0, var0);
  thread death_monitor(var0, var0);
}

function link_to_turret_enemy_mover(var0) {
  var1 = scripts\engine\utility::getStructArray("turret_enemy_struct", "targetname");
  var2 = scripts\engine\utility::getclosest(var0.origin, var1, 100000);
  var2.origin = var0.origin;
  var3 = spawn("script_model", var2.origin);
  var3 setModel("tag_origin");
  var3.angles = var2.angles;
  var0.angles = var3.angles;
  var0 linkTo(var3, "tag_origin");
  var0.wztrain_info = var3;
  thread turret_enemy_mover_clean_up(var3, var3);
}

function turret_enemy_mover_clean_up(var0, var1) {
  var0 endon("death");
  var1 waittill("death");
  var0 delete();
}

function death_monitor(var0, var1) {
  var0 waittill("death");
  deactivate_enemy_turret(var1);
}

function enemy_spawner_vehicle_spawned_monitor() {
  level endon("game_ended");
  level.enemy_spawner_vehicles = [];

  for(;;) {
    level waittill("vehicle_spawned", var0, var1);

    if(scripts\engine\utility::array_contains(level.enemy_spawner_vehicles, var1)) {
      continue;
    }

    level.enemy_spawner_vehicles[level.enemy_spawner_vehicles.size] = var1;

    switch (var0.group_name) {
      case "old_bridge":
      case "end_bridge":
      case "mid_bridge":
      case "player_left_side":
      case "player_right_side":
        thread enemy_spawner_vehicle_think(var1, var1);
        break;
      case "player_right_umike":
      case "player_left_umike":
        thread enemy_spawner_umike_think(var1, var1);
        break;
      case "enemy_fastrope":
      case "player_right_vindia":
      case "player_left_vindia":
        thread enemy_back_line_spawner_think(var1, var1);
        break;
      case "lbravo_carrier_hover":
        thread watchgastrapdamage(var1, var1);
        break;
      case "lbravo_carrier_hover_front":
        thread watchgastrapdamage(var1, var1);
        break;
      case "lbravo_carrier_hover_back":
        thread watchgastrapdamage(var1, var1);
        break;
    }
  }
}

function enemy_back_line_spawner_think(var0, var1) {
  var0 endon("death");
  var0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_damage_monitor(var0, 500000);
  wait 10;
  var2 = var0.riders;
  var0 waittill("unloading");
  thread infil_enemies_attack_logic(var0, var2);
}

function get_infil_rider_start_targetname(var0) {
  switch (var0) {
    case "enemy_fastrope":
      return &get_mindia_infil_rider_start_targetname;
    case "player_left_vindia":
      return &get_left_vindia_infil_rider_start_targetname;
    case "player_right_vindia":
      return &get_right_vindia_infil_rider_start_targetname;
  }
}

function infil_enemies_attack_logic(var0, var1) {
  foreach(var3 in var0) {
    thread infil_enemy_combat_logic(var3, var3);
  }
}

function infil_enemy_combat_logic(var0, var1) {
  var0 endon("death");
  var0 waittill("jumpedout");
  var0 waittill("large_footstep");
  wait 0.1;
  var2 = getgroundposition(var0.origin, 25, 256, 256);

  if(var2 != var0.origin) {
    var0 forceteleport(var2, var0.angles, 256);
  }

  thread ref_11e5e(level, var0.origin, var0.angles);
  var0.nocorpse = 1;
  var0 dodamage(var0.health + 1000, var0.origin, var0, var0, "MOD_SUICIDE");
}

function ref_11e5e(var0, var1, var2) {
  var3 = spawnStruct();
  var3.origin = var0;
  var3.angles = var1;
  var3.script_forcespawn = 1;
  var3.script_noteworthy = "riotshield";
  var4 = var3 scripts\cp\cp_modular_spawning::spawn_ai();
  var4 endon("death");

  if(scripts\engine\utility::flag("post_blockade_combat")) {
    thread ref_127f2(var4);
    return;
  }

  var4.never_kill_off = 1;
  var4.dontkilloff = 1;
  var4.ignoreall = 0;
  var4.skip_clear_kill_off_flag = 1;
  advance_through_struct_path(var4, var4, [[var2]]());
}

function get_mindia_infil_rider_start_targetname() {
  var0 = ["police_station_one", "police_station_two", "police_station_three", "police_station_four", "office_one", "office_two", "storage_one", "storage_two", "storage_three", "attacker_one", "attacker_two", "bridge_one", "bridge_two"];

  if(!isDefined(level.mindia_infil_start_targetname_array)) {
    level.mindia_infil_start_targetname_array = randomize_start_targetname_array(var0);
    level.mindia_infil_start_targetname_array_index = 0;
  }

  var1 = level.mindia_infil_start_targetname_array[level.mindia_infil_start_targetname_array_index];
  level.mindia_infil_start_targetname_array_index++;
  return var1;
}

function get_left_vindia_infil_rider_start_targetname() {
  var0 = ["left_river_one", "left_river_two", "left_river_three", "left_river_four", "left_river_five", "left_river_six"];

  if(!isDefined(level.left_vindia_infil_start_targetname_array)) {
    level.left_vindia_infil_start_targetname_array = randomize_start_targetname_array(var0);
    level.left_vindia_infil_start_targetname_array_index = 0;
  }

  var1 = level.left_vindia_infil_start_targetname_array[level.left_vindia_infil_start_targetname_array_index];
  level.left_vindia_infil_start_targetname_array_index++;
  return var1;
}

function get_right_vindia_infil_rider_start_targetname() {
  var0 = ["right_river_one", "right_river_two", "right_river_three", "right_river_four", "right_river_five", "right_river_six"];

  if(!isDefined(level.right_vindia_infil_start_targetname_array)) {
    level.right_vindia_infil_start_targetname_array = randomize_start_targetname_array(var0);
    level.right_vindia_infil_start_targetname_array_index = 0;
  }

  var1 = level.right_vindia_infil_start_targetname_array[level.right_vindia_infil_start_targetname_array_index];
  level.right_vindia_infil_start_targetname_array_index++;
  return var1;
}

function randomize_start_targetname_array(var0) {
  for(var1 = 5; var1 > 0; var1--) {
    var0 = scripts\engine\utility::array_randomize(var0);
  }

  return var0;
}

function enemy_spawner_umike_think(var0, var1) {
  var0 endon("death");
  var0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_damage_monitor(var0, 500000);
  wait 10;
  var2 = var0.riders;
  scripts\cp\vehicle_race\coop_vehicle_race::change_riders_demeanor(var0);
  var0 notify("stop_vehicle_on_damage_internal");
  var0 waittill("unloaded");
  thread back_line_enemies_attack_logic(var0, var2, undefined);
}

function enemy_spawner_vehicle_think(var0, var1) {
  var0 endon("death");
  var0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_damage_monitor(var0, 5000);
  wait 1.5;
  scripts\cp\vehicle_race\coop_vehicle_race::change_riders_demeanor(var0);
  var0 notify("stop_vehicle_on_damage_internal");
  var0 notify("stop_waiting_for_spawns");
  var0 thread scripts\cp\vehicle_race\coop_vehicle_race::enemy_vehicle_no_rider_monitor(var0);
  wait 0.5;
  var0 vehicle_setspeedimmediate(25, 15, 15);
  thread unload_monitor(var0, var0);
}

function unload_monitor(var0, var1) {
  var0 endon("death");
  var2 = get_unload_marker_for_spawn_group(var1);

  for(;;) {
    if(distance2dsquared(var2.origin, var0.origin) < 22500) {
      break;
    }

    waitframe();
  }

  var0 vehicle_setspeedimmediate(0, 15, 15);
  var0 scripts\common\vehicle::vehicle_unload("not_driver");
  thread start_riders_combat_logic(level, var0.riders, var0.riders[0]);
  var0 notify("unloaded");
  wait 2;
  var0 vehicle_setspeedimmediate(25, 15, 15);
  thread reach_path_end_monitor(var0, var0);
}

function start_riders_combat_logic(var0, var1, var2) {
  wait 2;

  switch (var2) {
    case "old_bridge":
      send_riders_to_proper_combat_spot(var0, var1, var2, 0);
      break;
    case "end_bridge":
    case "mid_bridge":
      under_bridge_enemies_attack_logic(var0, var1, var2, 1);
      break;
    case "player_left_side":
    case "player_right_side":
      back_line_enemies_attack_logic(var0, var1, var2);
      break;
  }
}

function under_bridge_enemies_attack_logic(var0, var1, var2, var3) {
  foreach(var5 in var0) {
    thread under_bridge_enemy_attack_logic(var5, var5, var2);
  }
}

function send_riders_to_proper_combat_spot(var0, var1, var2, var3) {
  foreach(var5 in var0) {
    thread delay_set_goal_volume(var5, var5, var2);
  }
}

function back_line_enemies_attack_logic(var0, var1, var2) {
  var3 = 0;

  foreach(var5 in var0) {
    if(!isDefined(var5)) {
      continue;
    }

    var5.never_kill_off = 1;

    if(istrue(level.bomb_guardian_is_killed)) {
      if(!istrue(var3)) {
        thread go_hunt_down_player(var5, var5);
        var3 = 1;
      } else {
        thread back_line_enemy_attack_logic(var5, var5);
      }

      continue;
    }

    thread back_line_enemy_attack_logic(var5, var5);
  }
}

function get_combat_volume_targetname(var0) {
  switch (var0) {
    case "old_bridge":
      return var0;
    case "player_right_side":
      return "enemy_bridge_zone_right";
    case "player_left_side":
      return "enemy_bridge_zone_left";
    default:
      if(any_player_under_bridge()) {
        return "under_bridge";
      }

      return var0;
  }
}

function any_player_under_bridge() {
  var0 = getEnt("under_bridge_zone", "targetname");

  foreach(var2 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var2)) {
      continue;
    }

    if(var2 istouching(var0)) {
      return true;
    }
  }

  return false;
}

function advance_through_struct_path(var0, var1) {
  level endon("post_blockade_combat");
  var2 = 6;
  var3 = 3;
  var4 = scripts\engine\utility::getStruct(var1, "targetname");
  var0.goalradius = 64;
  var0 setgoalpos(getclosestpointonnavmesh(var4.origin));
  var0 waittill("goal");

  for(;;) {
    if(isDefined(var4.target)) {
      var4 = scripts\engine\utility::getStruct(var4.target, "targetname");
      var0 setgoalpos(getclosestpointonnavmesh(var4.origin));
      var0 waittill("goal");
      wait randomfloatrange(var3, var2);

      if(isDefined(var4.script_noteworthy) && var4.script_noteworthy == "go_hunt_player") {
        if(issubstr(var1, "attacker")) {
          thread go_hunt_down_player(var0, var0);
        } else {
          thread go_hunt_down_player(var0, var0);
        }
      }

      continue;
    }

    return;
  }
}

function under_bridge_enemy_attack_logic(var0, var1, var2) {
  var3 = 4;
  var4 = 2;
  var0 endon("death");
  var0.goalradius = 10;

  if(any_player_under_bridge()) {
    thread go_hunt_down_player(var0, var0);
    return;
  }

  var5 = get_under_bridge_enemy_start_structs(var1);
  var0 setgoalpos(getclosestpointonnavmesh(var5.origin));
  var0 waittill("goal");
  wait randomfloatrange(var4, var3);

  for(;;) {
    if(isDefined(var5.target)) {
      var5 = scripts\engine\utility::getStruct(var5.target, "targetname");
    } else {
      var5 = undefined;
    }

    if(should_advance_to_next_goal_struct(var5)) {
      var0 setgoalpos(getclosestpointonnavmesh(var5.origin));
      var0 waittill("goal");
      wait randomfloatrange(var4, var3);
      continue;
    }

    break;
  }

  if(istrue(var2)) {
    thread go_hunt_down_player(var0, var0);
    return;
  }
}

function get_under_bridge_enemy_start_structs(var0) {
  if(!isDefined(level.mid_bridge_start_struct_index)) {
    level.mid_bridge_start_struct_index = 0;
  }

  if(!isDefined(level.end_bridge_start_struct_index)) {
    level.end_bridge_start_struct_index = 0;
  }

  if(var0 == "mid_bridge") {
    var1 = scripts\engine\utility::getStructArray("mid_bridge_start", "targetname");
    var2 = level.mid_bridge_start_struct_index;
    level.mid_bridge_start_struct_index++;

    if(level.mid_bridge_start_struct_index == var1.size) {
      level.mid_bridge_start_struct_index = 0;
    }

    return var1[var2];
  }

  if(var2 == "end_bridge") {
    var3 = scripts\engine\utility::getStructArray("end_bridge_start", "targetname");
    var2 = level.end_bridge_start_struct_index;
    level.end_bridge_start_struct_index++;

    if(level.end_bridge_start_struct_index == var3.size) {
      level.end_bridge_start_struct_index = 0;
    }

    return var3[var2];
  }
}

function delay_set_goal_volume(var0, var1, var2) {
  var0 endon("death");
  wait 2;
  var3 = getEnt(get_combat_volume_targetname(var1), "targetname");
  var0 setgoalvolumeauto(var3);

  if(istrue(var2)) {
    var0 waittill("goal");

    if(!is_goal_volume_ahead_of_vehicle_to_push(var3)) {
      thread go_hunt_down_player(var0, var0);
      return;
    }

    return;
  }
}

function back_line_enemy_attack_logic(var0, var1) {
  level endon("game_ended");
  var0 endon("death");
  wait randomfloatrange(1.2, 2);
  var2 = get_players_groups_by_whether_in_killzone();

  if(var2.players_in_killzone.size > 0) {
    advance_down_the_bridge(var0, var1);
    return;
  }

  go_hunt_down_player(var0, 0);
}

function advance_down_the_bridge(var0, var1) {
  var2 = getEnt(get_combat_volume_targetname(var1), "targetname");

  if(isDefined(var2)) {
    advance_down_the_bridge_via_volume(var0, var2);
    return;
  }

  advance_down_the_bridge_via_struct(var0);
}

function advance_down_the_bridge_via_struct(var0) {
  var1 = 4;
  var2 = 2;
  var0.goalradius = 10;
  var3 = get_bridge_start_struct();
  var0 setgoalpos(getclosestpointonnavmesh(var3.origin));
  var0 waittill("goal");
  wait randomfloatrange(var2, var1);

  for(;;) {
    if(isDefined(var3.target)) {
      var3 = scripts\engine\utility::getStruct(var3.target, "targetname");
    } else {
      var3 = undefined;
    }

    if(should_advance_to_next_goal_struct(var3)) {
      var0 setgoalpos(getclosestpointonnavmesh(var3.origin));
      var0 waittill("goal");
      wait randomfloatrange(var2, var1);
      continue;
    }

    break;
  }

  go_hunt_down_player(var0, 1);
}

function get_bridge_start_struct() {
  var0 = scripts\engine\utility::getStructArray("bridge_start", "targetname");

  if(!isDefined(level.bridge_start_struct_index)) {
    level.bridge_start_struct_index = 0;
  }

  var1 = level.bridge_start_struct_index;
  level.bridge_start_struct_index++;

  if(level.bridge_start_struct_index == var0.size) {
    level.bridge_start_struct_index = 0;
  }

  return var0[var1];
}

function should_advance_to_next_goal_struct(var0) {
  if(!isDefined(var0)) {
    return 0;
  }

  var1 = anglesToForward(level.vehicle_to_push.angles);
  var2 = vectorNormalize(level.vehicle_to_push.origin - var0.origin);

  if(vectordot(var2, var1) < 0) {
    return 0;
  }

  return 1;
}

function advance_down_the_bridge_via_volume(var0, var1) {
  var2 = 4;
  var3 = 2;
  var0 setgoalvolumeauto(var1);
  var0 waittill("goal");
  wait randomfloatrange(var3, var2);

  for(;;) {
    if(isDefined(var1.target)) {
      var1 = getEnt(var1.target, "targetname");
    } else {
      var1 = undefined;
    }

    if(should_advance_to_next_goal_volume(var1)) {
      var0 setgoalvolumeauto(var1);
      var0 waittill("goal");
      wait randomfloatrange(var3, var2);
      continue;
    }

    break;
  }

  go_hunt_down_player(var0, 1);
}

function should_advance_to_next_goal_volume(var0) {
  if(!isDefined(var0)) {
    return 0;
  }

  var1 = anglesToForward(level.vehicle_to_push.angles);
  var2 = vectorNormalize(level.vehicle_to_push.origin - var0.origin);

  if(is_goal_volume_ahead_of_vehicle_to_push(var0)) {
    return 0;
  }

  return 1;
}

function is_goal_volume_ahead_of_vehicle_to_push(var0) {
  var1 = anglesToForward(level.vehicle_to_push.angles);
  var2 = vectorNormalize(level.vehicle_to_push.origin - var0.origin);
  return vectordot(var2, var1) < 0;
}

function go_hunt_down_player(var0, var1) {
  var0 notify("go_hunt_down_player");
  level endon("game_ended");
  var0 endon("death");
  var0 endon("go_hunt_down_player");

  if(!isai(var0)) {
    return;
  }

  var0.goalradius = 256;
  var0.goalheight = 128;
  var0 cleargoalvolume();

  for(;;) {
    var2 = get_rider_initial_target(var1);

    if(isDefined(var2)) {
      break;
    }

    wait 0.1;
  }

  var0 getenemyinfo(var2);
  var0 setgoalentity(var2, 100);

  for(var3 = var2;; var3 = var4) {
    var3 waittill("last_stand");
    var4 = get_closest_alive_player(var0);
    var0 getenemyinfo(var4);
    var0 setgoalentity(var4, 100);
  }
}

function get_closest_alive_player(var0) {
  var1 = scripts\cp\raid_utility::get_players_not_in_laststand();
  return scripts\engine\utility::getclosest(var0.origin, var1);
}

function get_rider_initial_target(var0) {
  var1 = get_players_groups_by_whether_in_killzone();

  if(istrue(var0)) {
    if(var1.players_in_killzone.size > 0) {
      return scripts\engine\utility::random(var1.players_in_killzone);
    }

    return scripts\engine\utility::random(var1.players_not_in_killzone);
  }

  if(var1.players_not_in_killzone.size > 0) {
    return scripts\engine\utility::random(var1.players_not_in_killzone);
  }

  return scripts\engine\utility::random(var1.players_in_killzone);
}

function get_players_groups_by_whether_in_killzone() {
  var0 = spawnStruct();
  var1 = scripts\cp\raid_utility::get_players_not_in_laststand();
  var2 = get_players_in_killzone(var1);
  var3 = [];

  foreach(var5 in var1) {
    if(scripts\engine\utility::array_contains(var2, var5)) {
      continue;
    }

    var3 = var5;
  }

  var0.players_in_killzone = var2;
  var0.players_not_in_killzone = var3;
  return var0;
}

function get_unload_marker_for_spawn_group(var0) {
  var1 = scripts\engine\utility::getStructArray("enemy_spawn_vehicle_unload_marker", "targetname");

  foreach(var3 in var1) {
    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == var0) {
      return var3;
    }
  }
}

function increase_script_maxdist(var0, var1, var2, var3) {
  for(var4 = 0; var4 < var0.spawn_points.size; var4++) {
    var5 = var0.spawn_points[var4];
    var5.script_maxdist = 20000;
  }
}

function assign_more_vehicle_unload_groups() {}

function create_not_driver_group() {
  var0 = [];
  GscBinSkip0(0x2e, 0, 1);
}

function reach_path_end_monitor(var0, var1) {
  var0 endon("death");
  var0 waittill("reached_end_node");

  foreach(var3 in var0.riders) {
    var3 scripts\cp\cp_modular_spawning::script_kill_ai();
  }

  var0 delete();
}

function get_pre_respawn_group_wait(var0) {
  switch (var0) {
    case "player_right_side":
      return randomfloatrange(10, 20);
    case "player_left_side":
      return randomfloatrange(10, 20);
  }
}

function vehicle_progress_marker_think() {
  waitframe();
  var0 = scripts\engine\utility::getStructArray("vehicle_to_push_progress_marker", "targetname");

  foreach(var2 in var0) {
    thread activate_vehicle_progress_marker(var2);
  }

  waitframe();
  scripts\engine\utility::flag_set("vehicle_progression_flags_have_been_set_up");
}

function player_progress_market_think() {
  var0 = getEntArray("player_progression_trigger", "targetname");

  foreach(var2 in var0) {
    thread player_progress_trigger_think(var2);
  }
}

function player_progress_trigger_think(var0) {
  var0 endon("death");

  for(;;) {
    var0 waittill("trigger", var1);

    if(isPlayer(var1)) {
      break;
    }
  }

  scripts\engine\utility::flag_set(get_player_progress_flag_to_set(var1));
}

function get_player_progress_flag_to_set(var0) {
  var1 = scripts\engine\utility::getStructArray("vehicle_to_push_progress_marker", "targetname");
  var2 = sortbydistance(var1, var0.origin)[0];
  return var2.script_noteworthy;
}

function activate_vehicle_progress_marker(var0) {
  level.vehicle_to_push endon("death");
  scripts\engine\utility::flag_init(var0.script_noteworthy);

  for(;;) {
    if(distance2dsquared(var0.origin, level.vehicle_to_push.origin) < squared(150)) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set(var0.script_noteworthy);
}

function get_mortar_impact_spot(var0) {
  if(!isDefined(var0.targets)) {
    return undefined;
  }

  var1 = scripts\engine\utility::random(var0.targets);
  var2 = var1 getvelocity();
  var3 = distance(var0.origin, var1.origin);
  var4 = 5;
  var5 = var1.origin + var2 * var4;
  var6 = scripts\engine\trace::ray_trace(var5 + (0, 0, 500), var5, var1);
  return var6["position"];
}

function linkoffset() {
  foreach(var1 in level.enemy_turrets) {
    deactivate_enemy_turret(var1);
    var1.little_bird_mg_reenter = 1;
  }
}

function brdisablefinalkillcam() {
  scripts\engine\utility::flag_set("post_blockade_combat");
  waitframe();
  scripts\cp\cp_modular_spawning::remove_pacifist_from_enemies();
  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    thread ref_127f2(var2);
  }
}

function ref_127f2(var0) {
  var0 notify("post_blockade_combat_logic");
  var0 endon("death");
  var0 endon("post_blockade_combat_logic");

  if(istrue(var0.is_on_platform)) {
    return;
  }

  if(isDefined(var0.going_to_object)) {
    var1 = var0.going_to_object;

    while(isDefined(var0.going_to_object)) {
      waitframe();
    }

    var1 notify("stop_mortar_think");
    var1.targets = undefined;
  }

  if(isDefined(var0.wztrain_info)) {
    var0 unlink();
    var0.wztrain_info delete();
    wait randomfloatrange(0.3, 0.5);
  }

  var0 thread scripts\cp\cp_modular_spawning::enter_combat();
  wait randomfloatrange(0.1, 0.3);
  var0.is_on_platform = 0;
  var0.dontevershoot = 0;
  var0 allowedstances("stand", "prone", "crouch");
  var0 setlookatentity();
  var0.ignoreall = 0;
  var0.combatmode = "cover";
  thread go_hunt_down_player(var0, var0);
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
  var0 = scripts\engine\utility::getStruct("blockade_gate", "targetname");

  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.targetname = "blockade_gate";
    var0.origin = (39812.5, 15256, -354);
    var0.angles = (0, 204.999, 0);
  }

  var1 = scripts\engine\utility::getStruct("gate_left_prestine", "targetname");

  if(!isDefined(var1)) {
    var1 = spawnStruct();
    var1.targetname = "gate_left_prestine";
    var1.origin = (39760, 15368, -354.172);
    var1.angles = (0, 114.999, 0);
  }

  var2 = scripts\engine\utility::getStruct("gate_right_prestine", "targetname");

  if(!isDefined(var2)) {
    var2 = spawnStruct();
    var2.targetname = "gate_right_prestine";
    var2.origin = (39864.6, 15143.7, -354.291);
    var2.angles = (0, 114.999, 0);
  }

  var3 = "military_blockade_gate";
  var4 = spawn("script_model", var1.origin);
  var4.angles = var1.angles;
  var4 setModel(var3);
  var5 = spawn("script_model", var2.origin);
  var5.angles = var2.angles;
  var5 setModel(var3);
  var6 = spawn("script_model", var0.origin);
  var6.angles = var0.origin;
  var6 setModel("military_blockade_gate_damaged_rig_skeleton");
  var7 = spawn("script_model", var0.origin);
  var7.angles = var0.origin;
  var7 setModel("military_blockade_gate_left_damaged_rig_skeleton");
  level.computer_objective = [];
  level.computer_objective["anim_node"] = var0;
  level.computer_objective["model"] = [];
  level.computer_objective["model"]["prestine"] = [];
  level.computer_objective["model"]["prestine"]["left"] = var4;
  level.computer_objective["model"]["prestine"]["right"] = var5;
  level.computer_objective["model"]["blown"] = [];
  level.computer_objective["model"]["blown"]["left"] = var6;
  level.computer_objective["model"]["blown"]["right"] = var7;
  level.computer_objective["clip"] = [];
  level.computer_objective["clip"]["before"] = getEnt("blockade_gate_clip_before", "targetname");
  level.computer_objective["clip"]["after"] = getEnt("blockade_gate_clip_after", "targetname");
  level.computer_objective["bone"] = [];
  level.computer_objective["bone"]["left"] = "j_blockade_gate_le";
  level.computer_objective["bone"]["right"] = "j_blockade_gate_ri";
  var6 useanimtree(#animtree);
  var6.animname = "gate_left";
  level.computer_objective["anim_node"] thread scripts\common\anim::anim_first_frame_solo(var6, "close");
  var7 useanimtree(#animtree);
  var7.animname = "gate_right";
  level.computer_objective["anim_node"] thread scripts\common\anim::anim_first_frame_solo(var7, "close");
  var8 = var4.origin - var6 gettagorigin("j_blockade_gate_le");
  var9 = var4.angles - var6 gettagangles("j_blockade_gate_le");
  var4 linktomoveoffset(var6, "j_blockade_gate_le", var8, var9);
  var8 = var7 gettagorigin("j_blockade_gate_ri") - var5.origin;
  var9 = var7 gettagangles("j_blockade_gate_ri") - var5.angles;
  var5 linktomoveoffset(var7, "j_blockade_gate_ri", var8, var9);
  var6 hide();
  var7 hide();

  if(isDefined(level.computer_objective["clip"]["before"]) && isDefined(level.computer_objective["clip"]["after"])) {
    level.computer_objective["clip"]["before"].original_origin = level.computer_objective["clip"]["before"].origin;
    level.computer_objective["clip"]["after"].original_origin = level.computer_objective["clip"]["after"].origin;
    level.computer_objective["clip"]["after"].origin = level.computer_objective["clip"]["after"].origin + (0, 0, -2000);
    return;
  }
}

function laser_switch_manager(var0) {
  var1 = getEntArray(var0, "targetname");

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      var3 delete();
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

function cpoperationcrateactivatecallback(var0, var1) {
  var1 endon("death");
  var0 waittill("death");
  var1 delete();
}

function deploy_friendly_reinforcement_convoy() {
  var0 = (48941, 12803, -121);
  level.friendly_convoy = [];
  var1 = scripts\cp\coop_escort::create_friendly_convoy_vehicle("reinforcement_convoy_start_two");
  scripts\cp\coop_escort::add_to_friendly_convoy_list(var1);
  var2 = scripts\cp\coop_escort::create_not_drivable_player_vehicle("reinforcement_convoy_start_one");
  scripts\cp\maps\cp_br_syrk\vehicle_travel::add_gunner_turret(var2);
  reinforcement_convoy_get_to_blockade(var1, var2);
  var3 = getvehiclenode("seek_convoy_start", "targetname");
  var1 attachpath(var3);
  var1 startpath();
  wait 1;
  var4 = scripts\engine\utility::getStructArray("humvee_spawner", "script_noteworthy");
  var5 = sortbydistance(var4, var0)[0];
  level thread scripts\cp\maps\cp_br_syrk\vehicle_travel::deploy_vehicle(var5, scripts\cp\maps\cp_br_syrk\vehicle_travel::get_humvee_info(var5));
  var6 = var2.origin;
  var7 = var2.angles;
  var2 delete();
  level.player_humvee vehicle_teleport(var6, var7);
  scripts\cp\coop_escort::add_to_friendly_convoy_list(level.player_humvee);
  iprintlnbold("Overload: Get in the vehicle.We need to go rescue the HVI");
  level waittill("player_entered_driver_seat");
  var1 thread scripts\cp\coop_escort::maintain_speed_with_player_vehicle(var1);
  scripts\cp\coop_escort::waittill_vehicle_node_reached("seek_path_node_43");
  iprintlnbold("Overload: Stealth into the TV Station and rescue the HVI");
}

function reinforcement_convoy_get_to_blockade(var0, var1) {
  var2 = 40;
  var3 = getvehiclenode("reinforcement_convoy_start_two", "targetname");
  var4 = getvehiclenode("reinforcement_convoy_start_one", "targetname");
  iprintlnbold("Overload: Reinforcement incoming");
  var0 attachpath(var3);
  var0 startpath();
  var1 attachpath(var4);
  var1 startpath();
  var0 vehicle_setspeedimmediate(var2, var2 * 0.5, var2 * 0.5);
  var1 vehicle_setspeedimmediate(var2, var2 * 0.5, var2 * 0.5);
  scripts\cp\coop_escort::waittill_vehicle_node_reached("lumber_safe_path_node_31");
  var0 vehicle_setspeedimmediate(0, 5, 5);
  var1 vehicle_setspeedimmediate(0, 5, 5);
}

function hide_enemy_mortar_shell() {
  var0 = getEntArray("enemy_mortar", "targetname");

  foreach(var2 in var0) {
    var2 hidepart("j_mortar_shell");
  }
}

function vehicle_bridge_stage_five_music() {}

function ref_129ed() {
  self endon("death");
  var0 = self;
  var1 = scripts\engine\utility::getStructArray(get_smoke_grenade_struct_targetname(var0), "targetname");
  deploy_smoke_grenades_for_infil_via_structs(var0, var1, ["turret_hatch_jnt"], [(0, 0, 15)]);
}

function ref_129ec() {
  self endon("death");
  var0 = self;
  var1 = scripts\engine\utility::getStructArray(get_smoke_grenade_struct_targetname(var0), "targetname");
  deploy_smoke_grenades_for_infil_via_structs(var0, var1, ["tag_window_front_right", "tag_window_front_left"], [(0, 0, 30), (0, 0, 30)]);
}

function deploy_smoke_grenades_for_infil_via_structs(var0, var1, var2, var3) {
  for(var4 = 5; var4 > 0; var4--) {
    var1 = scripts\engine\utility::array_randomize(var1);
  }

  foreach(var6 in var1) {
    var7 = var6.origin;
    var8 = readytoleave(var0, var7, var2, var3);
    var9 = var7 - var8;
    var9 *= (1, 1, 0);
    var9 += (0, 0, 1) * length(var9);
    magicgrenademanual("smoke_grenade_mp", var8, var9 * 0.5, 0.05);
    wait randomfloatrange(1, 1.5);
  }
}

function readytoleave(var0, var1, var2, var3) {
  var4 = undefined;
  var5 = 99999999;

  foreach(var7 in var2) {
    var8 = var0 gettagorigin(var7);
    var9 = distance2dsquared(var8, var1);

    if(var9 <= var5) {
      var4 = var10;
      var5 = var9;
    }
  }

  var11 = var2[var4];
  var12 = var3[var4];
  return var0 gettagorigin(var11) + var12;
}

function get_smoke_grenade_struct_targetname(var0) {
  switch (var0.targetname) {
    case "player_left_vindia_spawner":
    case "player_left_umike_spawner":
      return "left_vindia_smoke_grenade";
    case "player_right_vindia_spawner":
    case "player_right_umike_spawner":
      return "right_vindia_smoke_grenade";
  }
}

function watchgastrapdamage(var0, var1) {
  var0 endon("death");
  var0.spawn_riders_and_play_intro_idle_anim = ["clockwise", "counterclockwise"];

  for(;;) {
    var2 = var0 scripts\engine\utility::ref_143b5("hover_attack", "increase_accuracy", "hover_retreat");

    switch (var2) {
      case "hover_retreat":
        var0.spawn_removefromarrays = undefined;
        var3 = player_vo_confirm_pickup(var0);
        var4 = init_civs(var3.origin, var0, 2500, 256, 1, 50, race_ui_add_critical_message(), 12);
        var5 = var4[0];
        var0 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var5);
        break;
      case "hover_attack":
        var6 = [[var1]](var0);
        var7 = init_civs(var6, var0, 2500, 256, 1, 40, protect_obj_a_internal(var0), 12);
        var8 = var7[0];
        var0 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var8);
        break;
      case "increase_accuracy":
        var9 = var0.riders;

        foreach(var11 in var9) {
          var11.baseaccuracy = 1000;
          thread watchheatreduction(var0, var11);
        }

        break;
    }
  }
}

function ref_12ff5(var0) {
  var1 = scripts\engine\utility::getclosest(var0.origin, level.players);
  var2 = scripts\cp\raid_utility::get_players_not_in_laststand();

  if(var2.size >= 1) {
    var3 = get_players_in_killzone(var2);

    if(var3.size >= 1) {
      var1 = scripts\engine\utility::getclosest(var0.origin, var3);
    }
  }

  return var1.origin + (0, 0, 756);
}

function ref_12ff6(var0) {
  var1 = level.vehicle_to_push;
  var2 = scripts\cp\raid_utility::get_players_not_in_laststand();

  if(var2.size >= 1) {
    var3 = get_players_in_killzone(var2);

    if(var3.size >= 1) {
      var1 = scripts\engine\utility::getclosest(var0.origin, var3);
    }
  }

  return var1.origin + (0, 0, 756);
}

function ref_12ff7(var0) {
  var1 = scripts\engine\utility::getStruct("lbravo_carrier_back_center", "targetname");
  var2 = var1;
  var3 = scripts\cp\raid_utility::get_players_not_in_laststand();

  if(var3.size >= 1) {
    var4 = get_players_groups_by_whether_in_killzone();
    var5 = var4.players_not_in_killzone;

    if(var5.size >= 1) {
      var2 = scripts\engine\utility::getclosest(var0.origin, var5);
    }
  }

  return var2.origin + (0, 0, 756);
}

function race_ui_add_critical_message() {
  return scripts\engine\utility::random(["clockwise", "counterclockwise"]);
}

function player_vo_confirm_pickup(var0) {
  var1 = rebirthloadout(var0);
  var2 = (var0.origin + var1.origin) / 2;
  var3 = ref_11a81(var2, var0.angles, 256, 1, 55);
  var0 thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var3);
  var0 scripts\engine\utility::ref_143a5("near_goal", "goal");
  return var1;
}

function ref_11a81(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var5.origin = var0;
  var5.angles = var1;
  var5.radius = var2;
  var5.speed = var3;

  if(istrue(var4)) {
    var5.script_goalyaw = 1;
  }

  return var5;
}

function rebirthloadout(var0) {
  var1 = scripts\engine\utility::getStructArray("hover_retreat", "targetname");
  var2 = -99999;
  var3 = var1[0];
  var4 = anglesToForward(var0.angles);

  foreach(var6 in var1) {
    var7 = vectorNormalize(var6.origin - var0.origin);
    var8 = vectordot(var7, var4);

    if(var8 > var2) {
      var2 = var8;
      var3 = var6;
    }
  }

  return var3;
}

function watchheatreduction(var0, var1) {
  var1 endon("death");
  var0 waittill("death");
  waitframe();
  getdismembermentlist(var1);
}

function getdismembermentlist(var0) {
  if(!c130_lights(var0, [2, 3, 4])) {
    ref_12bd4(var0, "counterclockwise");
    return;
  }

  if(!c130_lights(var0, [5, 6, 7])) {
    ref_12bd4(var0, "clockwise");
    return;
  }
}

function ref_12bd4(var0, var1) {
  var0.spawn_riders_and_play_intro_idle_anim = scripts\engine\utility::array_remove(var0.spawn_riders_and_play_intro_idle_anim, var1);

  if(isDefined(var0.spawn_removefromarrays) && var0.spawn_removefromarrays == var1) {
    var0 notify("hover_retreat");
    return;
  }
}

function ref_13b6f(var0) {
  wait 10 + var0.vehicle_position * 2;
  var0 dodamage(var0.health + 100, var0.origin);
}

function c130_lights(var0, var1) {
  foreach(var3 in var1) {
    foreach(var5 in var0.riders) {
      if(isalive(var5) && isDefined(var5.vehicle_position) && var5.vehicle_position == var3) {
        return true;
      }
    }
  }

  return false;
}

function protect_obj_a_internal(var0) {
  if(isDefined(var0.spawn_removefromarrays)) {
    return var0.spawn_removefromarrays;
  }

  var1 = scripts\engine\utility::random(var0.spawn_riders_and_play_intro_idle_anim);
  var0.spawn_removefromarrays = var1;
  return var1;
}

function init_civs(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = vectorNormalize(var1.origin - var0);
  var9 = int(360 / var7);
  var10 = vectortoangles(var8);

  if(var6 == "clockwise") {
    var9 *= -1;
  }

  var11 = [];

  for(var12 = 1; var12 <= var7; var12++) {
    var13 = var10 + (0, var9 * var12, 0);
    var14 = ref_11a8e(var0, var13, var2, var3, var4, var5, var6);

    if(var12 == var7) {
      var14.script_noteworthy = "hover_attack";
    }

    var11 = var14;
  }

  hostage_vo(var11);
  return var11;
}

function hostage_vo(var0) {
  for(var1 = 0; var1 < var0.size - 1; var1++) {
    var2 = var0[var1];
    var3 = var0[var1 + 1];
    var2.target = var3.targetname;
    scripts\cp\utility::addtostructarray("target", var2.targetname, var3);
  }
}

function ref_11a8e(var0, var1, var2, var3, var4, var5, var6) {
  var7 = spawnStruct();
  var7.origin = var0 + anglesToForward(var1) * var2;
  var7.radius = var3;
  var7.speed = var5;
  var7.targetname = scripts\cp\cp_vehicles::create_unique_kvp_string();
  scripts\cp\utility::addtostructarray("targetname", var7.targetname, var7);
  var8 = vectortoangles(vectorNormalize(var7.origin - var0));

  if(istrue(var4)) {
    var7.script_goalyaw = 1;
  }

  if(var6 == "counterclockwise") {
    var7.angles = vectortoangles(anglestoleft(var8));
  } else {
    var7.angles = vectortoangles(anglestoright(var8));
  }

  return var7;
}

function build_vehicles() {
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_physics_mp", "techo_phys_convoy_cp", "script_vehicle_iw8_truck_techo_white");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo", "truck", "script_vehicle_iw8_truck_techo_white");
  scripts\cp\cp_vehicles::register_combined_vehicles(&scripts\vehicle\umike::main, "veh8_mil_lnd_umike_physics", "umike_physics_sp", "script_vehicle_iw8_truck_umike_covered_physics", undefined, "umike_covered_physics", "umike_covered_physics");
  scripts\cp\cp_vehicles::register_combined_vehicles(&scripts\vehicle\umike::main, "veh8_mil_lnd_umike_pickup_physics", "umike_physics_sp", "script_vehicle_iw8_truck_umike_pickup_physics", undefined, "umike_physics", "umike_physics");
  scripts\vehicle\vindia::main("veh8_mil_lnd_vindia_a2_physics", "vindia_physics_sp", "script_vehicle_iw8_vindia_a2");
}

function ascendermodelworld() {
  var0 = getEntArray("gunshop_safehouse_loot", "targetname");

  foreach(var2 in var0) {
    var2 thread scripts\cp\utility::create_fake_loot(["brloot_munition_ammo"]);
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
  var0 = getEnt("blockade_bridge_pressure_sensor_trigger", "targetname");
  jumpiftrue(isDefined(level.vehicle_to_push)) LOC_00000039;

  for(;;) {
    jumpiftrue(isDefined(level.vehicle_to_push)) LOC_00000039;
    wait 0.5;
  }

  for(;;) {
    var1 = level.vehicle_to_push gettagorigin("tag_grill");

    if(ispointinvolume(var1, var0)) {
      break;
    }

    var2 = anglesToForward(level.vehicle_to_push.angles) * (1, 1, 0);
    var3 = vectorNormalize(var0.origin - var1) * (1, 1, 0);

    if(vectordot(var3, var2) < 0) {
      break;
    }

    wait 0.1;
  }

  var0 delete();
  level thread scripts\cp\bomb_defusal\coop_bomb_defusal::bombs_explode();
}

function ref_138c3() {
  level notify("stop_pressure_sensor_monitor");
  var0 = getEnt("blockade_bridge_pressure_sensor_trigger", "targetname");
  var0 delete();
}

function computermakingnose() {
  if(istrue(level.coop_bomb_defusal_count_down_started)) {
    return 2;
  }

  return 1;
}

function computer_listener_all(var0) {
  level endon("game_ended");
  var1 = getEnt("blockade_player_clip", "targetname");

  if(!isDefined(var1)) {
    return;
  }

  var2 = (0, 0, -10000);
  var1.original_origin = var1.origin;
  jumpiftrue(istrue(var0)) LOC_00000053;
  var1.origin = var1.original_origin + var2;

  for(;;) {
    level waittill("blockade_barrier_clip", var3);

    if(var3 == "on") {
      var1.origin = var1.original_origin;
      continue;
    }

    if(var3 == "off") {
      var1.origin = var1.original_origin + var2;
      continue;
    }

    if(var3 == "delete") {
      var1 delete();
      return;
    }

    wait 0.05;
  }
}

function computer_interface_think_internal() {
  var0 = getEntArray("player_trigger_hurt", "targetname");

  if(!isDefined(var0)) {
    return;
  }

  foreach(var2 in var0) {
    thread scripts\cp\raid_utility::ref_130a9(var2);
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
  var0 = scripts\engine\utility::getStructArray("landmine_sign", "targetname");

  foreach(var2 in var0) {
    var3 = spawn("script_model", var2.origin);
    var3 setModel("me_sign_minefield_02");
    var3.angles = var2.angles;
    waitframe();
  }
}

function landmine_think() {
  self endon("death");
  self endon("entitydeleted");

  while(!istrue(self.landmine_disabled)) {
    self waittill("trigger", var0, var1, var2, var3, var4, var5);

    if(!isPlayer(var0)) {
      continue;
    }

    if(!isDefined(var0) || istrue(self.landmine_disabled)) {
      continue;
    }

    if(istrue(var0.landmine_active)) {
      continue;
    }

    if(istrue(var0.spectating)) {
      continue;
    }

    GscBinSkip4(0x35, var0);
  }
}

function landmine_run_on_player(var0) {
  self endon("death");
  level endon("game_ended");
  var0 endon("disconnect");
  var0.landmine_active = 1;
  var0.waiting_for_lethal_restock = var0.origin;
  var1 = 50000;
  var2 = 3;
  var3 = "";
  var4 = var0 getdroptofloorposition(var0.origin);

  while(var0 istouching(self) && var2 > 0) {
    if(abs(var0.origin[2] - var4[2]) < 4) {
      break;
    }

    var2 -= 0.05;
    wait 0.05;
  }

  var5 = randomfloatrange(0.35, 0.75);
  var6 = var0.origin;
  var7 = var6;

  while(var0 istouching(self) && var5 > 0) {
    if(distance2dsquared(var6, var0.origin) >= 12) {
      break;
    }

    if(distance2dsquared(var7, var0.origin) > 2) {
      var7 = var0.origin;
      var5 -= 0.05;
    }

    wait 0.05;
  }

  if(!var0 istouching(self)) {
    var0.shouldskipdeathsshield = undefined;
    var0.landmine_active = 0;
    var0.shouldskiplaststand = 0;
    return;
  }

  var0.shouldskiplaststand = 1;
  var4 = var0 getdroptofloorposition(var0.origin);
  var8 = magicgrenademanual("at_mine_mp", var4 + (0, 0, 10), (0, 0, 4), 0.05);
  var9 = var8.origin;
  var8.owner = spawnStruct();
  var8.owner.team = "axis";
  var8.team = "axis";
  wait 0.1;
  var0.shouldskipdeathsshield = 1;
  var0 dodamage(var1, var0.origin, self);

  if(istrue(var0.inlaststand)) {
    var0 notify("force_bleed_out");
  }

  var0 scripts\engine\utility::ref_143b9(1, "death");
  var0.shouldskipdeathsshield = undefined;
  var0.landmine_active = 0;
  var0.shouldskiplaststand = 0;

  while(!isDefined(var0.dogtag)) {
    wait 0.05;
  }

  var10 = (0, 0, 40);

  if(isDefined(var0.last_good_pos)) {
    var0.dogtag.origin = var0.last_good_pos + var10;
    return;
  }

  if(isDefined(var0.waiting_for_lethal_restock)) {
    var0.dogtag.origin = getclosestpointonnavmesh(var0.waiting_for_lethal_restock) + var10;
    return;
  }

  var0.dogtag.origin = getclosestpointonnavmesh(var0.dogtag.origin) + var10;
}