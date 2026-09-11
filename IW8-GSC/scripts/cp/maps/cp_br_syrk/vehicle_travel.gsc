/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_br_syrk\vehicle_travel.gsc
*********************************************************/

function init() {
  init_vehicle_repair_anims();
  load_fx();
  thread hostage_near_vehicle_monitor();
  thread watch_for_host_migration();
  level.vehicle_interaction_info = [];
  level.unidentified_ieds = [];
  level.marked_enemy_ai = [];
  level.marked_critical_enemy_ai = [];
  level.removefromtargetmarkeronkillfunc = &remove_from_overwatch_target_group;
  register_vehicle_interaction_info("driver", &"CP_VEHICLE_TRAVEL/DRIVER", &try_start_driving, &start_driver_role, &exit_driver_role, "+stance", 200, 90, 72, 90, "duration_short", 1);
  register_vehicle_interaction_info("passenger", &"CP_VEHICLE_TRAVEL/ENTER", undefined, &enter_passenger_seat, &exit_passenger_seat, "+stance", 200, 90, 72, 90, "duration_short", 1);
  register_vehicle_interaction_info("left_back_seat", &"CP_VEHICLE_TRAVEL/ENTER", undefined, &enter_left_back_seat, &exit_left_back_seat, "+stance", 200, 90, 72, 90, "duration_short", 1);
  register_vehicle_interaction_info("right_back_seat", &"CP_VEHICLE_TRAVEL/ENTER", undefined, &enter_right_back_seat, &exit_right_back_seat, "+stance", 200, 90, 72, 90, "duration_short", 1);
  register_vehicle_interaction_info("gunner", &"CP_VEHICLE_TRAVEL/GUNNER", undefined, &enter_gunner_seat, &exit_gunner_seat, "+stance", 100, 360, 64, 360, "duration_short", 1);
  register_vehicle_interaction_info("grenadier", &"CP_VEHICLE_TRAVEL/GRENADIER", undefined, &enter_grenadier_seat, &exit_grenadier_seat, "+stance", 100, 90, 64, 90, "duration_short", 1);
  register_vehicle_interaction_info("overwatch_right", &"CP_VEHICLE_TRAVEL/OVERWATCH", undefined, &enter_reaper_right, &exit_reaper, "+stance", 30, 90, 30, 65, "duration_short", 1);
  register_vehicle_interaction_info("overwatch_left", &"CP_VEHICLE_TRAVEL/OVERWATCH", undefined, &enter_reaper_left, &exit_reaper, "+stance", 30, 90, 30, 65, "duration_short", 1);
  register_vehicle_interaction_info("missile_defense_right", &"CP_VEHICLE_TRAVEL/MISSILE_DEFENSE", undefined, &enter_missile_defense_right, &exit_missile_defense, "+stance", 20, 90, 20, 40, "duration_short", 1);
  register_vehicle_interaction_info("missile_defense_left", &"CP_VEHICLE_TRAVEL/MISSILE_DEFENSE", undefined, &enter_missile_defense_left, &exit_missile_defense, "+stance", 20, 90, 20, 40, "duration_short", 1);
  register_vehicle_interaction_info("back_left_repair", &"CP_VEHICLE_TRAVEL/REPAIR", undefined, &enter_repair, &exit_repair, undefined, 200, 90, 72, 90, "duration_none", 0);
  register_vehicle_interaction_info("back_right_repair", &"CP_VEHICLE_TRAVEL/REPAIR", undefined, &enter_repair, &exit_repair, undefined, 200, 90, 72, 90, "duration_none", 0);
  register_vehicle_interaction_info("front_left_repair", &"CP_VEHICLE_TRAVEL/REPAIR", undefined, &enter_repair, &exit_repair, undefined, 200, 90, 72, 90, "duration_none", 0);
  register_vehicle_interaction_info("front_right_repair", &"CP_VEHICLE_TRAVEL/REPAIR", undefined, &enter_repair, &exit_repair, undefined, 200, 90, 72, 90, "duration_none", 0);
  register_vehicle_interaction_info("hood_repair", &"CP_VEHICLE_TRAVEL/REPAIR", undefined, &enter_hood_repair, &exit_hood_repair, undefined, 200, 90, 72, 90, "duration_none", 0);
  register_vehicle_interaction_info("change_loadout", &"CP_VEHICLE_TRAVEL/CHANGE_LOADOUT", undefined, &enter_change_loadout, &exit_change_loadout, undefined, 200, 45, 72, 45, "duration_short", 1);
  register_vehicle_interaction_info("front_refill_ammo", &"CP_VEHICLE_TRAVEL/REFILL_AMMO", undefined, &enter_refill_ammo, undefined, undefined, 35, 45, 30, 45, "duration_medium", 1);
  register_vehicle_interaction_info("back_right_refill_ammo", &"CP_VEHICLE_TRAVEL/REFILL_AMMO", undefined, &enter_refill_ammo, undefined, undefined, 20, 15, 20, 15, "duration_medium", 1);
  register_vehicle_interaction_info("back_left_refill_ammo", &"CP_VEHICLE_TRAVEL/REFILL_AMMO", undefined, &enter_refill_ammo, undefined, undefined, 20, 15, 20, 15, "duration_medium", 1);
  register_vehicle_interaction_info("retrieve_hostage", &"CP_VEHICLE_TRAVEL/RETRIEVE_HOSTAGE", undefined, &enter_retrieve_hostage, &exit_retrieve_hostage, undefined, 200, 90, 72, 90, "duration_short", 0);
}

function deploy_vehicle(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_2 = spawnVehicle(var_1.model, "armoredtruck", var_1.vehicle_gdt, var_0.origin, var_0.angles);
  var_2 makeentitysentient("allies", 0);
  process_linked_ents(var_2, var_0);
  init_vehicle(var_2, var_1);
  var_2.infected_music = "armoredtruck";
  set_up_fake_character_models(var_2);
  set_up_vehicle_interactions(var_2, var_1);
  set_up_ied_triggering_tags(var_2, var_1);
  add_additional_parts(var_2, var_1);
  add_to_vehicle_travel_array(var_2);
  make_reaper_drone(var_2);
  thread vehicle_damage_monitor(var_2, var_2);
  thread tread_vfx_think(var_2);
  thread debug_setup_warp_jeep_to_players();
  thread ref_14222(var_2);
  thread ref_14223(var_2);
  level.player_humvee = var_2;
  level notify("spawned_player_car");
  var_2.nav_obstacle = createnavrepulsor("ply_vehicle", 0, var_2, 128, 1);
}

function deploy_friendly_hvi_vehicle(var_0, var_1) {
  var_2 = spawnVehicle(var_1.model, "friendlyhvi", var_1.vehicle_gdt, var_0.origin, var_0.angles);
  process_linked_ents(var_2, var_0);
  init_vehicle(var_2, var_1);
  set_up_fake_character_models(var_2);
  set_up_vehicle_interactions(var_2, var_1);
  set_up_ied_triggering_tags(var_2, var_1);
  add_additional_parts(var_2, var_1);
  thread tread_vfx_think(var_2);
  disable_vehicle_interaction(var_2, "driver");
  disable_vehicle_interaction(var_2, "passenger");
  disable_vehicle_interaction(var_2, "right_back_seat");
  return var_2;
}

function process_linked_ents(var_0, var_1) {
  var_2 = getEntArray(var_1.target, "targetname");

  foreach(var_4 in var_2) {
    switch (var_4.script_noteworthy) {
      case "no_sight_clip":
        var_4 linkTo(var_0);
        thread vehicle_linked_ent_clean_up_think(var_4, var_0);
        break;
      case "under_vehicle_trigger":
        var_4 enablelinkTo();
        var_4 linkTo(var_0);
        thread vehicle_linked_ent_clean_up_think(var_4, var_0);
        var_0.under_vehicle_trigger = var_4;
        break;
      default:
        break;
    }
  }
}

function vehicle_linked_ent_clean_up_think(var_0, var_1) {
  var_1 endon("death");
  var_0 waittill("death");
  var_1 delete();
}

function teleport_humvee_to_struct(var_0) {
  if(isDefined(level.player_humvee)) {
    if(level.player_humvee vehicle_isphysveh()) {
      var_1 = getclosestpointonnavmesh(var_0.origin);
      var_2 = (0, var_0.angles[1], 0);
      level.player_humvee vehicle_teleport(var_1, var_2);
      return;
    }

    return;
  }
}

function enter_change_loadout(var_0, var_1, var_2) {
  var_1 notify("enter_change_loadout");
  var_1 setclientomnvar("ui_options_menu", 2);
  waitframe();

  for(;;) {
    var_1 waittill("luinotifyserver", var_3, var_4);

    if(var_3 == "class_select" || var_3 == "class_edit" || var_3 == "class_menu_closed") {
      enable_vehicle_interaction(var_2, "change_loadout");
      break;
    }
  }

  var_0 notify("interaction_point_disabled");
}

function exit_change_loadout(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_change_loadout");
}

function enter_refill_ammo(var_0, var_1, var_2) {
  var_1 thread scripts\cp\cp_ammo_crate::supportbox_onusedeployable();
  waitframe();
  var_0 notify("interaction_point_disabled");
  waitframe();
  var_0 makeusable();
  var_0.being_used = 0;
}

function try_start_driving(var_0, var_1) {
  update_driver_interaction_hint(var_0);

  if(istrue(var_0.disabled)) {
    level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/REPAIR_VEHICLE");
    return 0;
  }

  if(isDefined(level.ref_13e02)) {
    return [[level.ref_13e02]]();
  }

  return 1;
}

function start_driver_role(var_0, var_1, var_2) {
  level notify("player_entered_driver_seat");
  var_1.disable_map_tablet = 1;
  enter_vehicle(var_1, var_2);
  var_1.current_vehicle_seat = "driver";
  var_1.start_anim_train_scene = 1;
  enter_seat_omnvar(var_1, var_1, "driver");
  var_1 setclientomnvar("ui_veh_controls", 1);
  var_1 scripts\common\utility::allow_weapon(0);
  var_1 setplayerangles(var_2.angles);
  var_1 controlslinkTo(var_2);
  var_1 scripts\common\utility::allow_usability(0);
  var_2 setotherent(var_1);
  var_2 setentityowner(var_1);
  play_seat_animation(var_1, var_2, "driver");
}

function exit_driver_role(var_0, var_1, var_2, var_3) {
  var_2 setotherent(undefined);
  var_2 setentityowner(undefined);
  var_1.start_anim_train_scene = undefined;
  technical_stopanimatingplayer(var_1);
  var_1 scripts\common\utility::allow_weapon(1);
  var_1 controlsunlink();
  var_1 unlink();
  exit_vehicle(var_1, var_1, var_2, "driver");
  exit_seat_omnvar(var_1, var_1, "driver", var_2);
  var_1 setclientomnvar("ui_veh_controls", 0);
  var_1.disable_map_tablet = undefined;
  var_1 scripts\common\utility::allow_usability(1);
}

function enter_repair(var_0, var_1, var_2) {
  var_3 = do_vehicle_repair_animation(var_2, var_1, var_0.repair_tag);

  if(!var_3) {
    var_0 makeusable();
    var_0.being_used = 0;
    return;
  }

  waitframe();
  var_0 notify("interaction_point_disabled");
  remove_from_vehicle_repair_interaction_list(var_2, var_0, var_0.repair_tag);
}

function exit_repair(var_0, var_1, var_2, var_3) {
  if(all_repairs_are_done(var_2)) {
    var_2.disabled = 0;
    set_repair_omnvars("hood_repair", 0);
    update_driver_interaction_hint(var_2);
    level notify("vehicle_repaired");
    return;
  }
}

function enter_retrieve_hostage(var_0, var_1, var_2) {
  waitframe();

  if(!isDefined(var_1.hostagecarried) && !has_hostage_on_board(var_2)) {
    return;
  }

  var_0 notify("interaction_point_disabled");
}

function exit_retrieve_hostage(var_0, var_1, var_2, var_3) {
  if(isPlayer(var_1) && !isDefined(var_1.hostagecarried) && !has_hostage_on_board(var_2)) {
    return;
  }

  if(!has_hostage_on_board(var_2)) {
    return;
  }

  var_4 = var_2.hostage;
  var_4 unlink();
  var_2.hostage = undefined;

  if(isPlayer(var_1)) {
    var_4 notify("trigger", var_1);
  } else {
    var_4.origin = var_1.origin;
    disable_vehicle_interaction(var_2, "retrieve_hostage");
    var_4.carried_by_vehicle = 0;
  }

  var_4 notify("trigger", var_1);
}

function enter_hood_repair(var_0, var_1, var_2) {
  thread ref_1421e(var_2);
  var_3 = do_hood_repair_animation(var_2, var_1, "tag_grill", var_0);
  var_2 notify("hood_repair_finished");

  if(!var_3) {
    var_0 makeusable();
    var_0.being_used = 0;
    return;
  }

  waitframe();
  var_0 notify("interaction_point_disabled");
  remove_from_vehicle_repair_interaction_list(var_2, var_0);
}

function ref_1421e(var_0) {
  var_0 endon("death");
  var_0 endon("hood_repair_finished");
  var_1 = var_0.origin;
  var_2 = var_0.angles;

  for(;;) {
    var_0 vehicle_teleport(var_1, var_2);
    waitframe();
  }
}

function exit_hood_repair(var_0, var_1, var_2, var_3) {
  if(all_repairs_are_done(var_2)) {
    var_2.disabled = 0;
    var_2.fake_health = var_2.max_fake_health;
    var_2.showing_damage_state = 0;
    var_2.disabled_due_to_damage = 0;
    set_repair_omnvars("hood_repair", 0);
    update_driver_interaction_hint(var_2);
    level notify("vehicle_repaired");
    return;
  }
}

function enter_passenger_seat(var_0, var_1, var_2) {
  enter_vehicle(var_1, var_2);
  enter_seat(var_1, var_2, "passenger");
}

function exit_passenger_seat(var_0, var_1, var_2, var_3) {
  exit_seat(var_1, 1);
  try_exit_vehicle(var_1, var_2, "passenger");
}

function enter_left_back_seat(var_0, var_1, var_2) {
  enter_vehicle(var_1, var_2);
  enter_seat(var_1, var_2, "left_back_seat");
}

function exit_left_back_seat(var_0, var_1, var_2, var_3) {
  exit_seat(var_1, 1);
  try_exit_vehicle(var_1, var_2, "left_back_seat");
}

function enter_right_back_seat(var_0, var_1, var_2) {
  enter_vehicle(var_1, var_2);
  enter_seat(var_1, var_2, "right_back_seat");
}

function exit_right_back_seat(var_0, var_1, var_2, var_3) {
  exit_seat(var_1, 1);
  try_exit_vehicle(var_1, var_2, "right_back_seat");
}

function enter_gunner_seat(var_0, var_1, var_2) {
  level notify("player_used_vehicle_gunner_turret");
  var_1 unlink();
  var_1 setworldupreference(undefined);
  var_1.disable_map_tablet = 1;
  scripts\cp\coop_super::little_bird_mg_init(var_1);
  exit_seat_but_stay_in_vehicle(var_1, var_2);
  record_seat(var_1, "gunner");
  enter_seat_omnvar(var_1, var_1, "gunner");
  var_1 setplayerangles(var_2.gunner_turret.angles);
  thread give_gunner_turret(var_1, var_0, var_1);
  var_1 setclientomnvar("ui_veh_vehicle", 10);
}

function give_gunner_turret(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("exit_gunner_seat");
  var_1.pre_gunner_weapon = var_1 getcurrentweapon();
  var_1 scripts\cp\utility::_giveweapon(var_2.gunner_weapon, undefined, undefined, 1);

  while(var_1 scripts\cp\cp_weapons::switchtoweaponreliable(var_2.gunner_weapon, 1) == 0) {
    waitframe();
  }

  var_2.gunner_turret setotherent(var_1);
  var_2.gunner_turret setentityowner(var_1);
  var_2.gunner_turret setsentryowner(var_1);
  var_2.gunner_turret.owner = var_1;
  var_1 disableturretdismount();
  var_1 controlturreton(var_2.gunner_turret);
}

function exit_gunner_seat(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_gunner_seat");
  var_1 takeweapon(var_2.gunner_weapon);
  var_1 switchtoweapon(var_1.pre_gunner_weapon);
  var_1 enableturretdismount();
  var_1 controlturretoff(var_2.gunner_turret);
  var_1 unlink();
  var_2.gunner_turret setotherent(undefined);
  var_2.gunner_turret setentityowner(undefined);
  var_2.gunner_turret setsentryowner(undefined);
  enable_vehicle_interaction(var_2, "gunner");
  var_1.disable_map_tablet = undefined;
  scripts\cp\coop_super::mousetraps(var_1);

  if(var_3 == "last_stand" || var_3 == "force_player_exit_vehicle") {
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
    exit_seat_omnvar(var_1, var_1, "gunner", var_2);
    return;
  }

  return_to_previous_seat(var_1, var_2);
  exit_seat_omnvar(var_1, var_1, "gunner", var_2);
}

function enter_grenadier_seat(var_0, var_1, var_2) {
  var_1 unlink();
  var_1 setworldupreference(undefined);
  var_1.disable_map_tablet = 1;
  exit_seat_but_stay_in_vehicle(var_1, var_2);
  waitframe();
  record_seat(var_1, "grenadier");
  enter_seat_omnvar(var_1, var_1, "grenadier");
  var_1 setplayerangles(var_2.angles);
  var_1 playerlinktodelta(var_2.grenadier_anchor, "tag_origin", 0, 180, 180, 180, 25);
  thread give_grenadier_launcher(var_1, var_0, var_1);
  var_1 setclientomnvar("ui_veh_vehicle", 10);
}

function give_grenadier_launcher(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("exit_grenadier_seat");
  var_1.pre_gunner_weapon = var_1 getcurrentweapon();
  var_1 scripts\cp\utility::_giveweapon(var_2.grenadier_weapon, undefined, undefined, 1);

  while(var_1 scripts\cp\cp_weapons::switchtoweaponreliable(var_2.grenadier_weapon, 1) == 0) {
    waitframe();
  }
}

function exit_grenadier_seat(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_grenadier_seat");
  var_1 takeweapon(var_2.grenadier_weapon);
  var_1 switchtoweapon(var_1.pre_gunner_weapon);
  var_1 unlink();
  enable_vehicle_interaction(var_2, "grenadier");
  var_1.disable_map_tablet = undefined;

  if(var_3 == "last_stand" || var_3 == "force_player_exit_vehicle") {
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
    exit_seat_omnvar(var_1, var_1, "grenadier", var_2);
    return;
  }

  return_to_previous_seat(var_1, var_2);
  exit_seat_omnvar(var_1, var_1, "grenadier", var_2);
}

function ref_11d06(var_0, var_1, var_2) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_1 notify("monitor_exit_initiated");
  var_1 endon("monitor_exit_initiated");
  var_3 = gettime() + 1000;
  var_4 = 0;
  var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
  var_5 = level.framedurationseconds;
  waitframe();

  for(;;) {
    var_6 = 0;
    var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);

    while(var_1 stancebuttonPressed()) {
      var_6 += var_5;

      if(var_1 usinggamepad()) {
        var_1 setclientomnvar("ui_veh_exit_button_holdtime", var_6 / 0.3);
      }

      if(var_1 usinggamepad() && var_6 > 0.3 || istrue(var_2) || !var_1 usinggamepad()) {
        var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
        return 1;
      }

      wait var_5;
    }

    waitframe();
  }
}

function ref_11d05(var_0, var_1, var_2) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_1 notify("monitor_exit_initiated");
  var_1 endon("monitor_exit_initiated");
  var_3 = gettime() + 1000;
  var_4 = 0;
  var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
  var_5 = level.framedurationseconds;
  waitframe();

  for(;;) {
    var_6 = 0;
    var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);

    while(var_1 useButtonPressed()) {
      var_6 += var_5;

      if(var_1 usinggamepad()) {
        var_1 setclientomnvar("ui_veh_exit_button_holdtime", var_6 / 0.3);
      }

      if(var_1 usinggamepad() && var_6 > 0.3 || istrue(var_2) || !var_1 usinggamepad()) {
        var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
        return 1;
      }

      wait var_5;
    }

    waitframe();
  }
}

function enter_mine_drone_right(var_0, var_1, var_2) {
  var_0 = get_vehicle_interaction_point(var_2, "mine_drone_left");
  var_0 makeunusable();
  var_0.being_used = 1;
  enter_mine_drone(var_0, var_1, var_2, "mine_drone_right");
}

function enter_mine_drone_left(var_0, var_1, var_2) {
  var_0 = get_vehicle_interaction_point(var_2, "mine_drone_right");
  var_0 makeunusable();
  var_0.being_used = 1;
  enter_mine_drone(var_0, var_1, var_2, "mine_drone_left");
}

function enter_mine_drone(var_0, var_1, var_2, var_3) {
  level notify("player_used_vehicle_mine_drone");
  var_1 notify("enter_mine_drone");
  var_1.outofrangefunc = &mine_drone_out_of_range;
  var_1.disable_map_tablet = 1;
  var_1 setplayerangles(var_2.angles);
  show_fake_player(var_1, var_1, var_2);
  exit_seat_but_stay_on_seat(var_1);
  record_seat(var_1, var_3);
  var_1 scripts\common\utility::allow_weapon(0);
  remove_from_players_cannot_see_vehicle_icon_list(var_1, var_2, var_1);
  update_vehicle_objective_visibility(var_1, var_2);
  var_1 animscriptexitvehicle();
  thread unlink_and_travel_with_vehicle(var_1, var_1);
  var_1 thread scripts\cp\drone\scout_drone::deploy_scout_detonate_drone(var_1);
  var_1.drone scripts\cp_mp\outofrange::setupoutofrangewatcher(var_1.drone, undefined, var_2, "tag_origin", 2560000, 5760000);
  thread drone_killed_due_to_out_of_range_monitor(var_1.drone, var_1.drone);
}

function show_fake_player(var_0, var_1) {
  if(var_0.current_vehicle_seat == "right_back_seat") {
    var_1.fake_back_right_passenger show();
    return;
  }

  if(var_0.current_vehicle_seat == "left_back_seat") {
    var_1.fake_back_left_passenger show();
    return;
  }
}

function mine_drone_out_of_range(var_0) {
  var_1 = 10;

  if(!isDefined(var_0.next_mine_drone_out_of_range_vo_time)) {
    var_0.next_mine_drone_out_of_range_vo_time = 0;
  }

  var_2 = gettime();

  if(var_2 > var_0.next_mine_drone_out_of_range_vo_time) {
    var_0.next_mine_drone_out_of_range_vo_time = var_2 + var_1 * 1000;
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("dx_cps_ovl_vehicle_out_of_range_10", "cp_comment_vo", "highest", 10, 0, 0, 1, 100);
    return;
  }
}

function unlink_and_travel_with_vehicle(var_0, var_1) {
  var_0 endon("exit_mine_drone");
  var_0 endon("exiting_drone");
  var_0 waittill("drone_exists");
  var_0 unlink();
  var_0 playerhide();
  var_2 = var_0.origin;
  var_3 = var_0.origin;

  for(;;) {
    var_2 = get_player_seat_org(var_0, var_1);

    if(var_2 != var_3) {
      var_0 setOrigin(var_2);
      var_3 = var_2;
    }

    waitframe();
  }
}

function get_player_seat_org(var_0, var_1) {
  switch (var_0.current_vehicle_seat) {
    case "mine_drone_left":
      return var_1 gettagorigin("tag_seat_2");
    case "mine_drone_right":
      return var_1 gettagorigin("tag_seat_3");
  }
}

function drone_killed_due_to_out_of_range_monitor(var_0, var_1) {
  var_0 waittill("death");
  var_1 notify("exit_mine_drone_right");
  var_1 notify("exit_mine_drone_left");
}

function exit_mine_drone(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_mine_drone");

  if(isDefined(var_1.drone)) {
    var_1.drone dodamage(var_1.drone.fake_health + 100, var_1.drone.origin);
  }

  var_1.outofrangefunc = undefined;
  level notify("vision_set_change_request", undefined, var_1, 0.05, "static");
  var_1 setclientomnvar("ui_out_of_bounds_countdown", 0);
  var_1 scripts\common\utility::allow_weapon(1);
  enable_vehicle_interaction(var_2, "mine_drone_right");
  enable_vehicle_interaction(var_2, "mine_drone_left");
  add_to_players_cannot_see_vehicle_icon_list(var_1, var_2, var_1);
  update_vehicle_objective_visibility(var_1, var_2);
  var_2.fake_back_right_passenger hide();
  var_2.fake_back_left_passenger hide();
  var_1 playershow();
  var_1.disable_map_tablet = undefined;

  if(var_3 == "last_stand") {
    var_1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
    return;
  }

  var_1 animscriptentervehicle();
  return_to_previous_seat(var_1, var_2);
}

function enter_missile_defense_right(var_0, var_1, var_2) {
  var_0 = get_vehicle_interaction_point(var_2, "missile_defense_left");
  var_0 makeunusable();
  var_0.being_used = 1;
  enter_missile_defense(var_0, var_1, var_2, "missile_defense_right");
}

function enter_missile_defense_left(var_0, var_1, var_2) {
  var_0 = get_vehicle_interaction_point(var_2, "missile_defense_right");
  var_0 makeunusable();
  var_0.being_used = 1;
  enter_missile_defense(var_0, var_1, var_2, "missile_defense_left");
}

function enter_missile_defense(var_0, var_1, var_2, var_3) {
  var_1 notify("enter_missile_defense");
  var_1.disable_map_tablet = 1;
  var_1.target_circle_fov = 35;
  var_1.target_circle_radius = 20;
  exit_seat_but_stay_on_seat(var_1);
  record_seat(var_1, var_3);
  var_1 setclientomnvar("ui_veh_vehicle", -1);
  var_1 setclientomnvar("ui_overwatch_view", 2);
  var_1 setclientomnvar("ui_missile_lock", 0);
  enter_missile_defense_view(var_1, var_1, var_2);
  mark_vehicle_as_friendly_target_group(var_1, var_1, var_2);
  give_missile_defense_weapons(var_1, var_1);
  see_icon_on_cruise_missiles(var_1, var_1);
  see_icon_on_interceptor_missiles(var_1, var_1);
  thread enter_missile_defense_control(var_1, var_1);
  thread enter_missile_defense_vision_set(var_1);
}

function enter_missile_defense_control(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_missile_defense");
  thread missile_defense_lock_on_cruise_missile_think(var_0, var_0);
  thread missile_defense_fire_interceptor_missiles(var_0, var_0);
  thread missile_defense_camera_focus_think(var_0, var_0);
}

function missile_defense_camera_focus_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_missile_defense");
  var_1 endon("death ");
  var_0 notifyonplayercommand("reset_missile_defense_camera", "+weapnext");

  for(;;) {
    var_0 waittill("reset_missile_defense_camera");
    var_0 setplayerangles(vectortoangles(var_1.origin - var_1.reaper.missile_defense_camera_anchor.origin));
  }
}

function missile_defense_fire_interceptor_missiles(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_missile_defense");
  var_1 endon("death ");
  var_0 notifyonplayercommand("fire_interceptor_missile", "+attack");

  for(;;) {
    var_0 waittill("fire_interceptor_missile");
    var_2 = get_locked_on_cruise_missile_to_intercept();

    if(isDefined(var_2)) {
      fire_interceptor_missile_toward(var_2, var_0, var_1);
    }
  }
}

function get_locked_on_cruise_missile_to_intercept() {
  if(!isDefined(level.locked_on_cruise_missiles)) {
    return undefined;
  }

  var_0 = [];

  foreach(var_2 in level.locked_on_cruise_missiles) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(istrue(var_2.being_intercepted)) {
      continue;
    }

    var_0 = var_2;
  }

  return sortbydistance(var_0, level.player_humvee.origin)[0];
}

function fire_interceptor_missile_toward(var_0, var_1, var_2) {
  var_3 = 3;
  var_0.being_intercepted = 1;
  var_4 = anglestoleft(var_1 getplayerangles());
  var_5 = var_2.reaper.missile_defense_camera_anchor.origin + var_4 * var_3;
  var_6 = magicbullet("interceptor_missile_cp", var_5, var_0.origin);
  var_6.target_anchor = make_interceptor_missile_target_anchor(var_6);
  var_6 missile_settargetEnt(var_6.target_anchor);
  var_6 missile_setflightmodedirect();
  var_6 setscriptablepartstate("thruster", "on", 0);
  set_interceptor_missile_target(var_6, var_0);
  thread hit_target_entity_monitor(var_6);
  thread get_away_from_target_entity_monitor(var_6);

  if(!isDefined(level.interceptor_missiles)) {
    level.interceptor_missiles = [];
  }

  level.interceptor_missiles[level.interceptor_missiles.size] = var_6;
  var_0.interceptor_missile = var_6;
  put_objective_icon_on_interceptor_missile(var_6);
  thread interceptor_missile_death_monitor(var_6, var_6, var_6.interceptor_missile_objective_id);
  update_missile_lock_hud_for_missile_defense_player();
}

function put_objective_icon_on_interceptor_missile(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("interceptor_missile_entity_number_" + var_0 getentitynumber(), 22);
  objective_state(var_1, "invisible");
  objective_icon(var_1, "hud_callsign_bg");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 0);
  objective_removeallfrommask(var_1);
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_setshowdistance(var_1, 1);
  objective_setshowprogress(var_1, 1);
  objective_setfadedisabled(var_1, 1);
  var_0.interceptor_missile_objective_id = var_1;
  make_visible_to_missile_defense_player(var_1);
}

function get_away_from_target_entity_monitor(var_0) {
  var_0 endon("death");
  thread start_chasing_target_entity_think(var_0);
  var_0 waittill("start_chasing_target_entity");
  var_1 = distancesquared(var_0.origin, var_0.target_entity.origin);

  for(;;) {
    waitframe();

    if(isDefined(var_0.target_entity) && isDefined(var_0.target_entity.origin)) {
      var_2 = distancesquared(var_0.origin, var_0.target_entity.origin);

      if(var_2 < var_1) {
        var_1 = var_2;
      } else {
        interceptor_missile_explodes_with_target(var_0);
        return;
      }
    }
  }
}

function start_chasing_target_entity_think(var_0) {
  var_0 endon("death");

  for(;;) {
    if(isDefined(var_0.target_entity) && isDefined(var_0.target_entity.angles)) {
      var_1 = anglesToForward(var_0.angles);
      var_2 = anglesToForward(var_0.target_entity.angles);

      if(vectordot(var_2, var_1) > 0) {
        var_0 notify("start_chasing_target_entity");
        return;
      }
    }

    waitframe();
  }
}

function hit_target_entity_monitor(var_0) {
  var_0 endon("death");

  for(;;) {
    if(isDefined(var_0.target_entity) && isDefined(var_0.target_entity.origin)) {
      if(distancesquared(var_0.origin, var_0.target_entity.origin) <= 22500) {
        interceptor_missile_explodes_with_target(var_0);
      }
    }

    waitframe();
  }
}

function interceptor_missile_explodes_with_target(var_0) {
  playFX(scripts\engine\utility::getfx("interceptor_hit_air_exp"), var_0.target_entity.origin);
  playsoundatpos(var_0.target_entity.origin, "iw8_cruise_missile_exp");
  var_0.target_entity delete();
  var_0 delete();
}

function interceptor_missile_death_monitor(var_0, var_1, var_2) {
  var_0 waittill("death");
  level.interceptor_missiles = scripts\engine\utility::array_remove(level.interceptor_missiles, var_0);
  scripts\cp\cp_objectives::freeworldid("interceptor_missile_entity_number_" + var_2);
  objective_delete(var_1);
}

function make_interceptor_missile_target_anchor(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  thread missile_anchor_clean_up_think(var_1, var_1);
  return var_1;
}

function missile_anchor_clean_up_think(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

function missile_defense_lock_on_cruise_missile_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_missile_defense");
  var_1 endon("death");

  for(;;) {
    if(isDefined(level.cruise_missiles)) {
      foreach(var_3 in level.cruise_missiles) {
        if(var_0 worldpointinreticle_circle(var_3.origin, var_0.target_circle_fov, var_0.target_circle_radius)) {
          var_3.lock_on_progress += 0.05;
        }

        if(var_3.lock_on_progress >= 0.5) {
          mark_cruise_missile_as_locked_on(var_3, var_0, var_1);
        }
      }
    }

    waitframe();
  }
}

function mark_cruise_missile_as_locked_on(var_0, var_1, var_2) {
  if(!isDefined(level.locked_on_cruise_missiles)) {
    level.locked_on_cruise_missiles = [];
  }

  if(!scripts\engine\utility::array_contains(level.locked_on_cruise_missiles, var_0)) {
    objective_icon(var_0.cruise_missile_objective_id, "hud_callsign_bg_rd_full");
    var_2.reaper.missile_defense_camera_anchor playsoundtoplayer("breach_warning_beep_05", var_1);
    level.locked_on_cruise_missiles = scripts\engine\utility::array_add(level.locked_on_cruise_missiles, var_0);
    var_1 setclientomnvar("ui_missile_lock", 1);
    return;
  }
}

function enter_missile_defense_vision_set(var_0) {
  var_0 endon("disconnect");
  var_0 endon("exit_missile_defense");
  overwatch_screen_transition(var_0);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color_glitch", var_0, 0.25);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color", var_0, 0);
}

function give_missile_defense_weapons(var_0) {
  var_0 scripts\cp\utility::_giveweapon("ac130_105mm_cp");
  var_0 scripts\cp\cp_weapons::_switchtoweaponimmediate("ac130_105mm_cp");
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0.pre_missile_defense_weapon = var_0 getcurrentweapon();
}

function enter_missile_defense_view(var_0, var_1) {
  var_0 playerlinkweaponviewtodelta(var_1.reaper.missile_defense_camera_anchor, "tag_player", 1, 180, 180, 90, 80, 0);
  var_0 playerlinkedsetviewznear(0);
  var_2 = anglesToForward(var_1.angles);
  var_2 *= (1, 1, 0);
  var_0 setplayerangles(vectortoangles(var_2));
}

function exit_missile_defense(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_missile_defense");
  thread exit_missile_defense_vision_set(var_1);
  var_1 setclientomnvar("ui_overwatch_view", 0);
  var_1 setclientomnvar("ui_veh_vehicle", 10);
  enable_vehicle_interaction(var_2, "missile_defense_left");
  enable_vehicle_interaction(var_2, "missile_defense_right");
  var_1.disable_map_tablet = undefined;
  exit_missile_defense_view(var_1, var_1);
  unmark_vehicle_as_friendly_target_group(var_1, var_1);
  remove_missile_defense_weapons(var_1, var_1);
  clear_icon_on_cruise_missiles(var_1, var_1);
  clear_icon_on_interceptor_missiles(var_1, var_1);

  if(var_3 == "last_stand") {
    var_1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
    return;
  }

  var_1 animscriptentervehicle();
  return_to_previous_seat(var_1, var_2);
}

function clear_icon_on_cruise_missiles(var_0) {
  if(isDefined(level.cruise_missiles)) {
    foreach(var_2 in level.cruise_missiles) {
      objective_removeclientfrommask(var_2.cruise_missile_objective_id, var_0);
    }

    return;
  }
}

function clear_icon_on_interceptor_missiles(var_0) {
  if(isDefined(level.interceptor_missiles)) {
    foreach(var_2 in level.interceptor_missiles) {
      if(isDefined(var_2)) {
        objective_removeclientfrommask(var_2.interceptor_missile_objective_id, var_0);
      }
    }

    return;
  }
}

function remove_missile_defense_weapons(var_0) {
  var_0 scripts\cp\cp_weapons::_takeweapon("ac130_105mm_cp");
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0 switchtoweaponimmediate(var_0.pre_missile_defense_weapon);
}

function exit_missile_defense_view(var_0) {
  var_0 cameraunlink();
}

function exit_missile_defense_vision_set(var_0) {
  var_0 endon("disconnect");
  var_0 endon("enter_missile_defense");
  overwatch_screen_transition(var_0);
  level notify("vision_set_change_request", undefined, var_0, 0, "ac130_color");
  waitframe();
  level notify("vision_set_change_request", undefined, var_0, 0, "ac130_color_glitch");
}

function enter_reaper_right(var_0, var_1, var_2) {
  enter_reaper(var_0, var_1, var_2, "overwatch_right");
  disable_vehicle_interaction(var_2, "overwatch_left");
}

function enter_reaper_left(var_0, var_1, var_2) {
  enter_reaper(var_0, var_1, var_2, "overwatch_left");
  disable_vehicle_interaction(var_2, "overwatch_right");
}

function enter_reaper(var_0, var_1, var_2, var_3) {
  var_1 notify("enter_overwatch");
  var_1.disable_map_tablet = 1;
  exit_seat_but_stay_on_seat(var_1);
  record_seat(var_1, var_3);
  var_1 setclientomnvar("ui_veh_vehicle", -1);
  var_1 setclientomnvar("ui_overwatch_view", 1);
  show_ied_zone_to_player(var_1, var_1);
  update_enemy_visualization_for_entering_reaper(var_1, var_1);
  delete_non_overwatch_ied_marker_vfx_for_player(var_1, var_1);
  enter_reaper_view(var_1, var_1, var_2);
  make_camera_point(var_1, var_1, var_2);
  mark_vehicle_as_friendly_target_group(var_1, var_1, var_2);
  give_reaper_weapons(var_1, var_1);
  thread enter_reaper_control(var_1, var_1);
  thread enter_overwatch_vision_set(var_1);
  thread target_in_red_circle_think(var_1, var_1);
  thread reaper_radar_control(var_1, var_1);
}

function see_icon_on_cruise_missiles(var_0) {
  if(isDefined(level.cruise_missiles)) {
    foreach(var_2 in level.cruise_missiles) {
      objective_addclienttomask(var_2.cruise_missile_objective_id, var_0);
    }

    return;
  }
}

function see_icon_on_interceptor_missiles(var_0) {
  if(isDefined(level.interceptor_missiles)) {
    foreach(var_2 in level.interceptor_missiles) {
      objective_addclienttomask(var_2.interceptor_missile_objective_id, var_0);
    }

    return;
  }
}

function play_cloud_vfx(var_0, var_1) {
  playfxontagforclients(scripts\engine\utility::getfx("reaper_clouds"), var_1.reaper.missile_defense_camera_anchor, "tag_player", var_0);
}

function enter_reaper_control(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  thread reaper_camera_zoom_think(var_0, var_0);
  thread reaper_camera_reset_think(var_0, var_0);
  thread reaper_fire_missile_think(var_0, var_0);
}

function reaper_fire_missile_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_1 endon("death");

  if(ref_12a4d()) {
    ref_12a4c(var_0);
  }

  var_0 notifyonplayercommand("reaper_fire_missile", "+attack");
  var_2 = 2;
  var_0 setclientomnvar("ui_killstreak_weapon_2_ammo", var_2);

  for(;;) {
    var_0 waittill("reaper_fire_missile");
    var_3 = fire_reaper_missile(var_0, var_1);
    var_2 -= 1;
    var_0 setclientomnvar("ui_killstreak_weapon_2_ammo", var_2);

    if(var_2 == 0) {
      reaper_waitforweaponreloadtime(var_0, var_0);
      var_2 = 2;
      var_0 setclientomnvar("ui_killstreak_weapon_2_ammo", var_2);
    }
  }
}

function fire_reaper_missile(var_0, var_1) {
  var_2 = 3;
  var_3 = make_reaper_missile_target_ent(var_0, var_1);
  var_4 = anglestoleft(var_0 getplayerangles());
  var_5 = var_1.reaper.missile_defense_camera_anchor.origin + var_4 * var_2;
  var_6 = magicbullet("overwatch_missile_cp", var_5, var_3.origin, var_0);
  var_6 missile_settargetEnt(var_3);
  var_6 missile_setflightmodedirect();
  var_6 setscriptablepartstate("thruster", "on", 0);
  thread clean_up_monitor(var_3, var_3);
  return var_6;
}

function reaper_waitforweaponreloadtime(var_0) {
  var_1 = 4;
  level.ref_12a4b = gettime() + int(var_1 * 1000);
  var_0 setclientomnvar("ui_ac130_40mm_reloadtime", level.ref_12a4b);

  for(;;) {
    wait 0.05;
    var_1 -= 0.05;

    if(var_1 <= 0) {
      break;
    }
  }
}

function ref_12a4d() {
  return isDefined(level.ref_12a4b) && level.ref_12a4b > gettime();
}

function ref_12a4c(var_0) {
  var_1 = gettime();
  var_2 = level.ref_12a4b - var_1;
  var_3 = var_2 / 1000;
  var_0 setclientomnvar("ui_ac130_40mm_reloadtime", level.ref_12a4b);
  wait var_3;
}

function clean_up_monitor(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

function make_reaper_missile_target_ent(var_0, var_1) {
  var_2 = get_reaper_player_look_at_ground_pos(var_0, var_1);
  var_3 = spawn("script_model", var_2);
  var_3 setModel("tag_origin");
  thread ref_123fc(var_3, var_3);
  put_objective_icon_on_reaper_missile_target_ent(var_3, var_0);
  thread follow_player_look_at(var_3, var_3, var_0);
  return var_3;
}

function ref_123fc(var_0, var_1) {
  var_0 endon("death");
  waitframe();
  playfxontagforclients(level._effect["reaper_missile_marker"], var_0, "tag_origin", var_1);
}

function put_objective_icon_on_reaper_missile_target_ent(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::requestworldid("reaper_missile_target_ent" + var_0 getentitynumber(), 22);
  objective_state(var_2, "invisible");
  objective_icon(var_2, "hud_overwatch_missile_target");
  objective_onentity(var_2, var_0);
  objective_setzoffset(var_2, 0);
  objective_removeallfrommask(var_2);
  objective_setplayintro(var_2, 0);
  objective_setplayoutro(var_2, 0);
  objective_setbackground(var_2, 1);
  objective_setshowdistance(var_2, 0);
  objective_setshowprogress(var_2, 1);
  objective_setfadedisabled(var_2, 1);
  objective_addclienttomask(var_2, var_1);
  thread reaper_missile_target_ent_objective_clean_up_think(var_0, var_0, var_2);
}

function reaper_missile_target_ent_objective_clean_up_think(var_0, var_1, var_2) {
  var_0 waittill("death");
  scripts\cp\cp_objectives::freeworldid("reaper_missile_target_ent" + var_2);
  objective_delete(var_1);
}

function follow_player_look_at(var_0, var_1, var_2) {
  var_0 endon("death");
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  var_1 endon("exit_overwatch");

  for(;;) {
    waitframe();
    var_0.origin = get_reaper_player_look_at_ground_pos(var_1, var_2);
  }
}

function reaper_radar_control(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_0 notifyonplayercommand("overwatch_radar_pin", "+speed_throw");

  for(;;) {
    var_0 waittill("overwatch_radar_pin");
    var_0.overwatch_camera_point playsoundtoplayer("reaper_scan_target", var_0);
    var_2 = get_reaper_player_look_at_ground_pos(var_0, var_1);
    waitframe();
    thread show_unidentified_ied_within_target_circle(level, var_0);
    thread show_ai_within_target_circle(level, var_0);
    wait 1;
  }
}

function get_reaper_player_look_at_ground_pos(var_0, var_1) {
  var_2 = anglesToForward(var_0 getplayerangles());
  var_3 = var_1.reaper.scanning_camera_anchor.origin + var_2 * 50;
  var_4 = var_1.reaper.scanning_camera_anchor.origin + var_2 * 30000;
  var_5 = scripts\engine\trace::ray_trace_detail(var_3, var_4, var_1.reaper);
  var_6 = var_5["position"];
  return var_6;
}

function show_unidentified_ied_within_target_circle(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_2 = [];

  foreach(var_4 in level.unidentified_ieds) {
    if(istrue(var_4.in_reaper_target_circle)) {
      var_2 = var_4;
    }
  }

  var_6 = sortbydistance(var_2, var_1);

  foreach(var_8 in var_6) {
    var_0.overwatch_camera_point playsoundtoplayer("breach_warning_beep_05", var_0);
    mark_ied_as_identified(var_0, var_8);
    wait randomfloatrange(0.05, 0.1);
  }
}

function show_ai_within_target_circle(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_2 = [];

  foreach(var_4 in level.agentarray) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(!isalive(var_4)) {
      continue;
    }

    if(istrue(var_4.marked_by_overwatch_scan)) {
      continue;
    }

    if(var_4.team == "allies") {
      continue;
    }

    if(istrue(var_4.in_reaper_target_circle)) {
      var_2 = var_4;
    }
  }

  var_6 = sortbydistance(var_2, var_1);

  foreach(var_4 in var_6) {
    var_0.overwatch_camera_point playsoundtoplayer("breach_warning_beep_05", var_0);
    var_4.marked_by_overwatch_scan = 1;
    add_ai_to_marked_enemy_ai_list(var_4);
    outline_enemy_ai_for_overwatch(var_4, var_0);

    if(istrue(var_4.is_critical_ai_target)) {
      add_ai_to_marked_critical_enemy_ai_list(var_4);
      put_target_marker_on_critical_enemy_ai(var_4, var_0);
      make_critical_target_icon_on_ai(var_4);

      foreach(var_9 in level.players) {
        if(var_9 == var_0) {
          continue;
        }

        show_critical_target_icon_to_player(var_4, var_9);
      }
    }

    wait randomfloatrange(0.05, 0.1);
  }
}

function reaper_get_target_in_circle_omnvar_value(var_0) {
  if(player_in_intercept_mode(var_0)) {
    return intercept_mode_get_target_in_circle_omnvar_value(var_0);
  }

  return scanning_mode_get_target_in_circle_omnvar_value(var_0);
}

function player_in_intercept_mode(var_0) {
  return var_0.current_reaper_camera_zoom_level == 3;
}

function intercept_mode_get_target_in_circle_omnvar_value(var_0) {
  foreach(var_2 in level.unidentified_ieds) {
    var_2.in_reaper_target_circle = undefined;
  }

  foreach(var_5 in level.agentarray) {
    var_5.in_reaper_target_circle = undefined;
  }

  return false;
}

function scanning_mode_get_target_in_circle_omnvar_value(var_0) {
  var_1 = 0;

  foreach(var_3 in level.unidentified_ieds) {
    if(var_0 worldpointinreticle_circle(var_3.origin, var_0.target_circle_fov, var_0.target_circle_radius)) {
      var_3.in_reaper_target_circle = 1;
      var_1 += 1;
      continue;
    }

    var_3.in_reaper_target_circle = undefined;
  }

  foreach(var_6 in level.agentarray) {
    if(!isDefined(var_6)) {
      var_6.in_reaper_target_circle = undefined;
      continue;
    }

    if(!isalive(var_6)) {
      var_6.in_reaper_target_circle = undefined;
      continue;
    }

    if(istrue(var_6.marked_by_overwatch_scan)) {
      var_6.in_reaper_target_circle = undefined;
      continue;
    }

    if(istrue(var_6.team == "allies")) {
      var_6.in_reaper_target_circle = undefined;
      continue;
    }

    if(var_0 worldpointinreticle_circle(var_6.origin, var_0.target_circle_fov, var_0.target_circle_radius)) {
      var_6.in_reaper_target_circle = 1;
      var_1 += 1;
    }
  }

  var_1 = min(var_1, 7) / 7 * 0.4;
  return var_1;
}

function reaper_camera_zoom_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_1 endon("death ");
  var_0 notifyonplayercommand("reaper_camera_zoom_in", "+actionslot 1");
  var_0 notifyonplayercommand("reaper_camera_zoom_out", "+actionslot 2");
  set_current_reaper_camera_zoom_level(var_0, 2, var_1);

  for(;;) {
    var_2 = var_0 scripts\engine\utility::ref_143ad("reaper_camera_zoom_in", "reaper_camera_zoom_out");

    if(var_2 == "reaper_camera_zoom_in") {
      adjust_reaper_camera_zoom_level(var_0, -1, var_1);
    } else if(var_2 == "reaper_camera_zoom_out") {
      adjust_reaper_camera_zoom_level(var_0, 1, var_1);
    }

    waitframe();
  }
}

function reaper_camera_reset_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_1 endon("death");
  var_0 notifyonplayercommand("reset_overwatch_camera", "+weapnext");

  for(;;) {
    var_0 waittill("reset_overwatch_camera");
    var_0 setplayerangles(vectortoangles(var_1.origin - var_1.reaper.scanning_camera_anchor.origin));
  }
}

function adjust_reaper_camera_zoom_level(var_0, var_1, var_2) {
  var_3 = int(clamp(var_0.current_reaper_camera_zoom_level + var_1, 1, 2));
  set_current_reaper_camera_zoom_level(var_0, var_3, var_2);
}

function set_current_reaper_camera_zoom_level(var_0, var_1, var_2) {
  if(isDefined(var_0.current_reaper_camera_zoom_level) && var_0.current_reaper_camera_zoom_level == var_1) {
    return;
  }

  var_3 = var_0.current_reaper_camera_zoom_level;
  var_0.current_reaper_camera_zoom_level = var_1;
  switch_to_proper_zoom_weapon(var_0);
  adjust_target_circle_fov_and_radius(var_0);
}

function switch_to_proper_zoom_weapon(var_0) {
  var_1 = get_proper_zoom_weapon(var_0);
  var_0 scripts\cp\cp_weapons::_switchtoweaponimmediate(var_1);
}

function adjust_target_circle_fov_and_radius(var_0) {
  switch (var_0.current_reaper_camera_zoom_level) {
    case 1:
      var_0.target_circle_fov = 10;
      var_0.target_circle_radius = 150;
      return;
    case 2:
      var_0.target_circle_fov = 22;
      var_0.target_circle_radius = 150;
      return;
    case 3:
      var_0.target_circle_fov = 35;
      var_0.target_circle_radius = 20;
      return;
  }
}

function get_proper_zoom_weapon(var_0) {
  switch (var_0.current_reaper_camera_zoom_level) {
    case 1:
      return "ac130_25mm_cp";
    case 2:
      return "ac130_40mm_cp";
    case 3:
      return "ac130_105mm_cp";
  }
}

function mark_vehicle_as_friendly_target_group(var_0, var_1) {
  var_0.humvee_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", var_0, var_1, var_0);

  if(isDefined(level.friendly_convoy)) {
    foreach(var_3 in level.friendly_convoy) {
      if(!isDefined(var_3)) {
        continue;
      }

      if(var_3 == var_1) {
        continue;
      }

      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_3, var_0.humvee_marker_group_id);
    }

    return;
  }
}

function unmark_vehicle_as_friendly_target_group(var_0) {
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_0.humvee_marker_group_id);
}

function make_camera_point(var_0, var_1) {
  var_2 = spawn("script_model", var_1.reaper.scanning_camera_anchor.origin);
  var_2 setModel("tag_origin");
  var_2.angles = var_1.reaper.scanning_camera_anchor.angles;
  var_2 linkTo(var_1.reaper.scanning_camera_anchor);
  var_0.overwatch_camera_point = var_2;
}

function enter_reaper_view(var_0, var_1) {
  var_0 playerlinkweaponviewtodelta(var_1.reaper.scanning_camera_anchor, "tag_player", 1, 45, 45, 30, 30, 0);
  var_0 playerlinkedsetviewznear(0);
  var_0 setplayerangles(vectortoangles(var_1.origin - var_1.reaper.scanning_camera_anchor.origin));
}

function give_reaper_weapons(var_0) {
  var_0 scripts\cp\utility::_giveweapon("ac130_105mm_cp");
  var_0 scripts\cp\utility::_giveweapon("ac130_40mm_cp");
  var_0 scripts\cp\utility::_giveweapon("ac130_25mm_cp");
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0.pre_reaper_weapon = var_0 getcurrentweapon();
}

function exit_reaper(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_overwatch");
  thread exit_overwatch_vision_set(var_1);
  var_1 setclientomnvar("ui_overwatch_view", 0);
  var_1 setclientomnvar("ui_veh_vehicle", 10);
  hide_ied_zone_from_player(var_1, var_1);
  update_enemy_visualization_for_exiting_reaper(var_1, var_1);
  hide_ai_marker_vfx_to_player(var_1, var_1);
  enable_vehicle_interaction(var_2, "overwatch_right");
  enable_vehicle_interaction(var_2, "overwatch_left");
  var_1.disable_map_tablet = undefined;
  exit_reaper_view(var_1, var_1);
  delete_camera_point(var_1, var_1);
  unmark_vehicle_as_friendly_target_group(var_1, var_1);
  remove_reaper_weapons(var_1, var_1);
  unset_player_zoom_setting(var_1, var_1);

  if(var_3 == "last_stand" || var_3 == "force_player_exit_vehicle") {
    var_1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
    return;
  }

  return_to_previous_seat(var_1, var_2);
}

function unset_player_zoom_setting(var_0) {
  var_0.current_reaper_camera_zoom_level = undefined;
}

function delete_camera_point(var_0) {
  var_0.overwatch_camera_point delete();
}

function exit_reaper_view(var_0) {
  var_0 cameraunlink();
}

function remove_reaper_weapons(var_0) {
  var_0 scripts\cp\cp_weapons::_takeweapon("ac130_105mm_cp");
  var_0 scripts\cp\cp_weapons::_takeweapon("ac130_40mm_cp");
  var_0 scripts\cp\cp_weapons::_takeweapon("ac130_25mm_cp");
  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0 switchtoweaponimmediate(var_0.pre_reaper_weapon);
}

function put_target_marker_on_critical_enemy_ai(var_0, var_1) {
  if(isDefined(var_1.overwatch_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_0, var_1.overwatch_target_marker_group_id);
  } else {
    var_1.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("ieddronetarget", var_1, var_0, var_1);
  }

  var_0.target_marker_group_id = var_1.overwatch_target_marker_group_id;
}

function add_ai_to_marked_enemy_ai_list(var_0) {
  if(scripts\engine\utility::array_contains(level.marked_enemy_ai, var_0)) {
    return;
  }

  level.marked_enemy_ai = scripts\engine\utility::array_add(level.marked_enemy_ai, var_0);
  thread remove_from_marked_enemy_ai_list_on_death(var_0);
}

function remove_from_marked_enemy_ai_list_on_death(var_0) {
  var_0 waittill("death");
  level.marked_enemy_ai = scripts\engine\utility::array_remove(level.marked_enemy_ai, var_0);
}

function add_ai_to_marked_critical_enemy_ai_list(var_0) {
  if(scripts\engine\utility::array_contains(level.marked_critical_enemy_ai, var_0)) {
    return;
  }

  level.marked_critical_enemy_ai = scripts\engine\utility::array_add(level.marked_critical_enemy_ai, var_0);
  thread remove_from_marked_critical_enemy_ai_list_on_death(var_0);
}

function remove_from_marked_critical_enemy_ai_list_on_death(var_0) {
  var_0 waittill("death");
  level.marked_critical_enemy_ai = scripts\engine\utility::array_remove(level.marked_critical_enemy_ai, var_0);
}

function make_critical_target_icon_on_ai(var_0) {
  if(has_critical_target_icon(var_0)) {
    return;
  }

  var_1 = scripts\cp\cp_objectives::requestworldid("enemy_AI_critical_target_ID_" + var_0 getentitynumber(), 22);
  objective_state(var_1, "invisible");
  objective_icon(var_1, "icon_faction_head_enemy");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 90);
  objective_removeallfrommask(var_1);
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_setshowdistance(var_1, 0);
  objective_setshowprogress(var_1, 0);
  objective_setfadedisabled(var_1, 1);
  var_0.critical_target_icon_objective_id = var_1;
  thread delete_critical_target_icon_on_death(var_0, var_0, var_0 getentitynumber());
}

function has_critical_target_icon(var_0) {
  return isDefined(var_0.critical_target_icon_objective_id);
}

function delete_critical_target_icon_on_death(var_0, var_1, var_2) {
  var_0 waittill("death");
  scripts\cp\cp_objectives::freeworldid("enemy_AI_critical_target_ID_" + var_1);
  objective_delete(var_2);
  var_0.critical_target_icon_objective_id = undefined;
}

function show_critical_target_icon_to_player(var_0, var_1) {
  if(has_critical_target_icon(var_0)) {
    objective_addclienttomask(var_0.critical_target_icon_objective_id, var_1);
    return;
  }
}

function hide_critical_target_icon_to_player(var_0, var_1) {
  if(has_critical_target_icon(var_0)) {
    objective_removeclientfrommask(var_0.critical_target_icon_objective_id, var_1);
    return;
  }
}

function update_enemy_visualization_for_entering_reaper(var_0) {
  foreach(var_2 in level.marked_enemy_ai) {
    outline_enemy_ai_for_overwatch(var_2, var_0);
  }

  foreach(var_2 in level.marked_critical_enemy_ai) {
    hide_critical_target_icon_to_player(var_2, var_0);

    if(isDefined(var_0.overwatch_target_marker_group_id)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_2, var_0.overwatch_target_marker_group_id);
    } else {
      var_0.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("ieddronetarget", var_0, var_2, var_0);
    }

    var_2.target_marker_group_id = var_0.overwatch_target_marker_group_id;
  }
}

function update_enemy_visualization_for_exiting_reaper(var_0) {
  foreach(var_2 in level.marked_enemy_ai) {
    remove_enemy_ai_outline_for_overwatch(var_2, var_0);
  }

  foreach(var_2 in level.marked_critical_enemy_ai) {
    make_critical_target_icon_on_ai(var_2);
    show_critical_target_icon_to_player(var_2, var_0);
  }

  if(isDefined(var_0.overwatch_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_0.overwatch_target_marker_group_id);
    var_0.overwatch_target_marker_group_id = undefined;
    return;
  }
}

function outline_enemy_ai_for_overwatch(var_0, var_1) {
  var_0 hudoutlineenableforclient(var_1, "overwatch_target_outline");
}

function remove_enemy_ai_outline_for_overwatch(var_0, var_1) {
  var_0 hudoutlinedisableforclient(var_1);
}

function enter_overwatch(var_0, var_1, var_2) {
  var_1 notify("enter_overwatch");
  var_1.disable_map_tablet = 1;
  exit_seat_but_stay_on_seat(var_1);
  record_seat(var_1, "overwatch");
  var_1 scripts\common\utility::allow_weapon(0);
  var_1 setclientomnvar("ui_veh_vehicle", -1);
  var_1 setclientomnvar("ui_overwatch_view", 1);
  show_ied_zone_to_player(var_1, var_1);
  remove_from_players_cannot_see_vehicle_icon_list(var_1, var_2, var_1);
  update_vehicle_objective_visibility(var_1, var_2);
  delete_non_overwatch_ied_marker_vfx_for_player(var_1, var_1);
  show_ai_marker_vfx_to_player(var_1, var_1);
  thread enter_overwatch_vision_set(var_1);
  thread enter_overwatch_control(var_1, var_1);
  thread target_in_red_circle_think(var_1, var_1);
  thread move_cursor_near_identified_ied(var_1);
  thread overwatch_radar_control(var_1, var_1);
  thread enable_overwatch_model();
}

function exit_overwatch(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_overwatch");
  thread exit_overwatch_vision_set(var_1);
  var_1 scripts\common\utility::allow_weapon(1);
  var_1 setclientomnvar("ui_overwatch_view", 0);
  var_1 setclientomnvar("ui_veh_vehicle", 10);
  hide_ied_zone_from_player(var_1, var_1);
  add_to_players_cannot_see_vehicle_icon_list(var_1, var_2, var_1);
  update_vehicle_objective_visibility(var_1, var_2);
  hide_ai_marker_vfx_to_player(var_1, var_1);
  exit_overwatch_control(var_1, var_2);
  enable_vehicle_interaction(var_2, "overwatch");
  thread disable_overwatch_model();
  var_1.disable_map_tablet = undefined;

  if(var_3 == "last_stand") {
    var_1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var_1, 1);
    exit_vehicle(var_1, var_2, var_1.previous_vehicle_seat);
    return;
  }

  return_to_previous_seat(var_1, var_2);
}

function put_icon_on_vehicle(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("vehicle_icon", 20);
  objective_setplayintro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_state(var_1, "invisible");
  objective_icon(var_1, "cp_tac_hud_icon_vehicle");
  objective_setlabel(var_1, "");
  objective_onentity(var_1, var_0);
  objective_addalltomask(var_1);
  var_0.objective_id = var_1;

  if(getdvarint("scr_disable_vehicle_icon", 0) != 0) {
    objective_removeallfrommask(var_0.objective_id);
  }

  thread icon_clean_up_think(var_0);
}

function icon_clean_up_think(var_0) {
  var_0 waittill("death");
  scripts\cp\cp_objectives::freeworldid("vehicle_icon");
}

function enter_overwatch_control(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_2 = spawn("script_model", get_camera_spawn_point(var_1));
  var_2 setModel("tag_origin");
  var_2.angles = vectortoangles((0, 0, -1));
  var_2.camera_height = var_2.origin[2];
  var_2.camera_min_height = var_2.camera_height - get_overwatch_camera_zoom_max_delta();
  var_2.camera_max_height = var_2.camera_height + get_overwatch_camera_zoom_max_delta();
  thread clean_up_overwatch_camera_point(var_2, var_2, var_0);
  var_0.overwatch_camera_point = var_2;
  var_0 cameralinkTo(var_2, "tag_origin");
  thread camera_zoom_think(var_0, var_0);
  thread camera_movement_think(var_0, var_0);
  thread camera_reset_think(var_0, var_0);
  thread camera_min_height_think(var_0, var_0);
  thread overwatch_radar_control(var_0, var_0);
}

function get_overwatch_camera_zoom_max_delta() {
  if(isDefined(level.overwatch_camera_zoom_max_delta)) {
    return level.overwatch_camera_zoom_max_delta;
  }

  return 2000;
}

function target_in_red_circle_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_0 setclientomnvar("ui_targets_in_circle", 0);

  for(;;) {
    var_2 = [[var_1]](var_0);
    var_0 setclientomnvar("ui_targets_in_circle", var_2);
    waitframe();
  }
}

function overwatch_get_target_in_circle_omnvar_value(var_0) {
  var_1 = 0;
  var_2 = get_unidentidied_ieds_within_scan_range(var_0, var_0.overwatch_camera_point.camera_ground_point);
  var_3 = squared(600);

  foreach(var_5 in var_2) {
    var_1 += 1 - distance2dsquared(var_5.origin, var_0.overwatch_camera_point.camera_ground_point) / var_3;
  }

  foreach(var_8 in level.agentarray) {
    if(!isDefined(var_8)) {
      continue;
    }

    if(!isalive(var_8)) {
      continue;
    }

    if(istrue(var_8.marked_by_overwatch_scan)) {
      continue;
    }

    var_9 = distance2dsquared(var_8.origin, var_0.overwatch_camera_point.camera_ground_point);

    if(var_9 <= var_3) {
      var_1 += 1 - var_9 / var_3;
    }
  }

  var_1 = min(var_1, 7) / 7 * 0.4;
  return var_1;
}

function overwatch_radar_control(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_0.false_positive_dots_bank = [];
  var_0.next_false_positive_bank_index = 0;
  var_0 notifyonplayercommand("overwatch_radar_pin", "+goStand");

  for(;;) {
    var_0 waittill("overwatch_radar_pin");
    playFX(level._effect["IED_radar_ping"], var_0.overwatch_camera_point.camera_ground_point, undefined, undefined, var_0);
    show_unidentified_ied_within_scan_range(var_0, var_0.overwatch_camera_point.camera_ground_point);
    thread show_ai_within_scan_range(level, var_0);
    wait 1;
  }
}

function show_false_positive_dots(var_0, var_1, var_2) {
  var_3 = get_false_positive_dots_within_scan_range(var_1, var_0);
  var_4 = [];

  if(additional_false_positive_dots_needed(var_3)) {
    var_5 = get_additional_num_false_positive_dots_needed(var_3);
    var_4 = make_false_positive_dots(var_0, var_1, var_5);
  }

  foreach(var_7 in var_3) {
    thread show_false_positive_dot(level, var_0, var_1);
  }

  foreach(var_7 in var_4) {
    thread show_false_positive_dot(level, var_0, var_1);
  }
}

function show_unidentified_ied_within_scan_range(var_0, var_1) {
  var_2 = get_unidentidied_ieds_within_scan_range(var_0, var_1);

  foreach(var_4 in var_2) {
    thread show_ied(level, var_0, var_1);
  }
}

function show_ai_within_scan_range(var_0, var_1) {
  var_2 = int(30);
  var_3 = 400;
  var_4 = var_3 * 0.05;

  for(var_5 = 1; var_5 <= var_2; var_5++) {
    var_6 = min(600, var_4 * 1.5 * var_5);

    foreach(var_8 in level.agentarray) {
      if(!isDefined(var_8)) {
        continue;
      }

      if(!isalive(var_8)) {
        continue;
      }

      if(istrue(var_8.marked_by_overwatch_scan)) {
        continue;
      }

      if(distance2dsquared(var_8.origin, var_1) <= var_6 * var_6) {
        var_0.overwatch_camera_point playsoundtoplayer("breach_warning_beep_05", var_0);
        var_8 hudoutlineenable("outlinefill_nodepth_orange");
        var_8.marked_by_overwatch_scan = 1;
        show_enemy_ai_to_overwatch_player(var_8, var_0);
      }
    }

    waitframe();
  }
}

function show_enemy_ai_to_overwatch_player(var_0, var_1) {
  if(isDefined(var_1.enemy_ai_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_0, var_1.enemy_ai_target_marker_group_id);
  } else {
    var_1.enemy_ai_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("ieddronetarget", var_1, var_0, var_1);
  }

  var_0.target_marker_group_id = var_1.overwatch_target_marker_group_id;
}

function hide_ai_marker_vfx_to_player(var_0) {
  if(isDefined(var_0.enemy_ai_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_0.enemy_ai_target_marker_group_id);
    var_0.enemy_ai_target_marker_group_id = undefined;
    return;
  }
}

function show_ai_marker_vfx_to_player(var_0) {
  foreach(var_2 in level.agentarray) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(!isalive(var_2)) {
      continue;
    }

    if(istrue(var_2.marked_by_overwatch_scan)) {
      show_enemy_ai_to_overwatch_player(var_2, var_0);
    }
  }
}

function additional_false_positive_dots_needed(var_0) {
  return var_0.size < 5;
}

function make_false_positive_dots(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = get_random_value_in_segment(var_2, 360);
  var_5 = get_random_value_in_segment(var_2, 600);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = (0, var_4[var_6], 0);
    var_8 = anglesToForward(var_7);
    var_9 = var_5[var_6];
    var_10 = var_0.overwatch_camera_point.origin;
    var_11 = var_1 + var_8 * var_9;
    var_10 = (var_11[0], var_11[1], var_10[2]);
    var_11 = scripts\engine\trace::ray_trace_detail(var_10, var_11 + (0, 0, -5000))["position"] + (0, 0, 5);
    var_3 = var_11;
    put_into_player_false_positive_bank(var_0, var_11);
  }

  return var_3;
}

function put_into_player_false_positive_bank(var_0, var_1) {
  var_0.false_positive_dots_bank[var_0.next_false_positive_bank_index] = var_1;
  var_0.next_false_positive_bank_index++;

  if(var_0.next_false_positive_bank_index >= 200) {
    var_0.next_false_positive_bank_index = 0;
    return;
  }
}

function get_additional_num_false_positive_dots_needed(var_0) {
  var_1 = get_num_of_segments();
  return var_1 - var_0.size;
}

function get_false_positive_dots_within_scan_range(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1.false_positive_dots_bank) {
    if(distance2dsquared(var_4, var_0) <= 360000) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function get_unidentidied_ieds_within_scan_range(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.unidentified_ieds) {
    if(distance2dsquared(var_4.origin, var_1) <= 360000) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function show_ied(var_0, var_1, var_2) {
  var_3 = distance(var_1, var_2.origin);
  var_4 = 400;
  var_5 = var_3 / var_4;
  var_6 = int(var_5 * 20);
  var_5 = var_6 * 0.05;
  wait max(0.05, var_5 - 0.55);

  if(isDefined(var_0.overwatch_camera_point)) {
    var_0.overwatch_camera_point playsoundtoplayer("breach_warning_beep_05", var_0);
  }

  mark_ied_as_identified(var_0, var_2);
}

function show_false_positive_dot(var_0, var_1, var_2) {
  var_3 = distance(var_1, var_2);
  var_4 = 400;
  var_5 = var_3 / var_4;
  var_6 = int(var_5 * 20);
  var_5 = var_6 * 0.05;
  wait max(0.05, var_5 - 0.5);
  playFX(level._effect["IED_false_positive"], var_2, (0, 0, 1), (1, 0, 0), var_0);
}

function get_random_value_in_segment(var_0, var_1) {
  var_2 = [];
  var_3 = var_1 / var_0;

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_2 = randomfloatrange(var_4 * var_3, (var_4 + 1) * var_3);
  }

  for(var_5 = 0; var_5 < 5; var_5++) {
    var_2 = scripts\engine\utility::array_randomize(var_2);
  }

  return var_2;
}

function get_num_of_segments() {
  return randomintrange(5, 11);
}

function get_ai_highlight_hudoutline(var_0) {
  return "outlinefill_nodepth_red";
}

function mark_enemy_as_identified(var_0, var_1) {
  var_0.highlighted_enemies = scripts\engine\utility::array_remove(var_0.highlighted_enemies, var_1);
  var_1.marked_by_overwatch = 1;
  var_1 hudoutlineenable(get_ai_highlight_hudoutline(var_1));
}

function mark_ied_as_identified(var_0, var_1) {
  if(!is_ied_identified(var_1) && isDefined(var_1)) {
    level notify("IED_marked");
    remove_from_unidentified_ieds_list(var_1);
    mark_ied_controller_as_identified(var_1);
    add_to_identified_ieds_list(var_1);
    show_identified_ied_to_overwatch(var_1, var_0);
    show_identified_ied_to_non_overwatch(var_1, var_0);
    set_ied_scanned_flag_from_ied_controller(var_1);
    return;
  }
}

function mark_ied_controller_as_identified(var_0) {
  var_1 = var_0.ied_controller;
  var_1.identified = 1;

  if(isDefined(var_1.unidentified_zone_vfxs)) {
    foreach(var_3 in var_1.unidentified_zone_vfxs) {
      if(isDefined(var_3)) {
        var_3 delete();
      }
    }

    return;
  }
}

function camera_movement_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_1 endon("death ");

  for(;;) {
    var_2 = var_0 getnormalizedmovement();
    var_3 = var_2[0];
    var_4 = var_2[1];

    if(player_moving_camera(var_3, var_4)) {
      var_0 notify("start_moving_camera");
      var_5 = (var_3 * get_camera_dist_per_frame(var_0), var_4 * get_camera_dist_per_frame(var_0) * -1, 0);
      var_6 = var_0.overwatch_camera_point.origin + var_5;
      var_6 = (var_6[0], var_6[1], var_0.overwatch_camera_point.camera_height);
      var_0.overwatch_camera_point.origin = var_6;
    }

    waitframe();
  }
}

function get_camera_dist_per_frame(var_0) {
  var_1 = var_0.overwatch_camera_point.camera_max_height - var_0.overwatch_camera_point.camera_min_height;
  var_2 = var_0.overwatch_camera_point.camera_height - var_0.overwatch_camera_point.camera_min_height;
  var_3 = var_2 / var_1 * 90;
  var_4 = 10 + var_3;
  return var_4;
}

function camera_zoom_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_1 endon("death ");

  for(;;) {
    if(var_0 attackButtonPressed()) {
      var_0 notify("start_moving_camera");
      var_0.overwatch_camera_point.camera_height = max(var_0.overwatch_camera_point.camera_min_height, var_0.overwatch_camera_point.camera_height - 160);
      var_0.overwatch_camera_point.origin = (var_0.overwatch_camera_point.origin[0], var_0.overwatch_camera_point.origin[1], var_0.overwatch_camera_point.camera_height);
    }

    if(var_0 adsButtonPressed()) {
      var_0 notify("start_moving_camera");
      var_0.overwatch_camera_point.camera_height = min(var_0.overwatch_camera_point.camera_max_height, var_0.overwatch_camera_point.camera_height + 160);
      var_0.overwatch_camera_point.origin = (var_0.overwatch_camera_point.origin[0], var_0.overwatch_camera_point.origin[1], var_0.overwatch_camera_point.camera_height);
    }

    waitframe();
  }
}

function camera_min_height_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_1 endon("death ");

  for(;;) {
    var_2 = scripts\engine\trace::ray_trace_detail(var_0.overwatch_camera_point.origin + (0, 0, -5), var_0.overwatch_camera_point.origin + (0, 0, -50000));
    var_3 = var_2["position"];
    var_0.overwatch_camera_point.camera_ground_point = var_3;
    var_4 = var_3[2] + 500;
    var_0.overwatch_camera_point.camera_min_height = var_4;

    if(var_0.overwatch_camera_point.origin[2] < var_4) {
      var_0.overwatch_camera_point.origin = (var_0.overwatch_camera_point.origin[0], var_0.overwatch_camera_point.origin[1], var_4);
    }

    waitframe();
  }
}

function clean_up_overwatch_camera_point(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::waittill_any_ents_return(var_1, "exit_overwatch", var_1, "disconnect", var_1, "last_stand", var_2, "death");
  var_0 delete();
}

function player_moving_camera(var_0, var_1) {
  if(abs(var_0) != 0) {
    return true;
  }

  if(abs(var_1) != 0) {
    return true;
  }

  return false;
}

function camera_reset_think(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_1 endon("death ");
  var_0 notifyonplayercommand("reset_overwatch_camera", "+weapnext");

  for(;;) {
    thread lock_camera_on_vehicle_until_moving_camera(var_0, var_0);
    var_0 waittill("reset_overwatch_camera");
  }
}

function lock_camera_on_vehicle_until_moving_camera(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_0 endon("start_moving_camera");
  var_1 endon("death");

  for(;;) {
    var_2 = get_camera_reset_point(var_0, var_1);
    var_0.overwatch_camera_point.origin = var_2;
    waitframe();
  }
}

function get_camera_spawn_point(var_0) {
  return var_0 gettagorigin("tag_origin") + (0, 0, get_camera_control_up_offset());
}

function get_camera_control_up_offset() {
  if(isDefined(level.overwatch_control_up_offset)) {
    return level.overwatch_control_up_offset;
  }

  return 2550;
}

function get_camera_reset_point(var_0, var_1) {
  var_2 = var_1 gettagorigin("tag_origin");
  return (var_2[0], var_2[1], var_0.overwatch_camera_point.camera_height);
}

function exit_overwatch_control(var_0, var_1) {
  var_0 cameraunlink();
}

function enter_overwatch_vision_set(var_0) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  overwatch_screen_transition(var_0);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color_glitch", var_0, 0.25);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color", var_0, 0);
}

function exit_overwatch_vision_set(var_0) {
  var_0 endon("disconnect");
  var_0 endon("enter_overwatch");
  overwatch_screen_transition(var_0);
  level notify("vision_set_change_request", undefined, var_0, 0, "ac130_color");
  waitframe();
  level notify("vision_set_change_request", undefined, var_0, 0, "ac130_color_glitch");
}

function enable_overwatch_model() {
  if(isDefined(level.uavrig)) {
    level.uavrig show();
    return;
  }

  var_0 = getEntArray("minimap_corner", "targetname");

  if(var_0.size) {
    var_1 = var_0[0].origin;
    var_2 = var_0[1].origin;
    var_3 = (0, 0, 0);
    var_3 = var_2 - var_1;
    var_3 = (var_3[0] / 2, var_3[1] / 2, var_3[2] / 2) + var_1;
    level.uavrotationorigin = var_3;
  } else {
    level.uavrotationorigin = (0, 0, 0);
  }

  level.uavrig = spawn("script_model", level.uavrotationorigin);
  level.uavrig setModel("tag_origin");
  level.uavrig.angles = (0, 115, 0);
  level.uavrig.targetname = "uavrig_script_model";
  thread rotateuavrig(level.uavrig);
}

function disable_overwatch_model() {
  if(isDefined(level.uavrig)) {
    level.uavrig hide();
    return;
  }
}

function rotateuavrig(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(!isDefined(var_0)) {
    var_0 = 60;
  }

  if(!isDefined(var_1)) {
    var_1 = -360;
  }

  for(;;) {
    self rotateYaw(var_1, var_0);
    wait var_0;
  }
}

function disable_vehicle_interaction(var_0, var_1) {
  var_2 = get_vehicle_interaction_point(var_0, var_1);
  var_2 makeunusable();
}

function enable_vehicle_interaction(var_0, var_1) {
  var_2 = get_vehicle_interaction_point(var_0, var_1);
  var_2 makeusable();
  var_2.being_used = 0;
}

function enter_seat(var_0, var_1, var_2) {
  record_seat(var_0, var_2);
  var_0.exit_vehicle_when_exit_seat = 1;
  var_0.stay_on_seat_when_exit_seat = 0;
  play_seat_animation(var_0, var_1, var_2);
  enter_seat_omnvar(var_0, var_0, var_2);
}

function play_seat_animation(var_0, var_1, var_2) {
  var_3 = "viewhands_base_iw8";
  var_4 = get_seat_tag_name(var_2);
  var_5 = var_1 gettagorigin(var_4);
  var_6 = var_1 gettagangles(var_4);
  var_0.player_rig = spawn("script_model", var_5);
  var_0.player_rig.angles = var_6;
  var_0.player_rig linkTo(var_1, var_4);
  var_0.player_rig setModel(var_3);
  var_0.player_rig hide();
  var_0 setstance("stand");
  var_0 animscriptentervehicle();
  var_0 setplayerangles(var_0.player_rig.angles);
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 0, 120, 120, 120, 35, 1);
}

function technical_stopanimatingplayer() {
  if(!isDefined(self.player_rig)) {
    return;
  }

  self notify("technical_stopAnimatingPlayer");
  self.animname = undefined;
  self.player_rig delete();

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self stopanimscriptsceneevent();
  }

  self animscriptexitvehicle();
}

function get_seat_tag_name(var_0) {
  var_1 = "tag_seat_0";

  switch (var_0) {
    case "driver":
      var_1 = "tag_seat_0";
      break;
    case "passenger":
      var_1 = "tag_seat_1";
      break;
    case "left_back_seat":
      var_1 = "tag_seat_2";
      break;
    case "right_back_seat":
      var_1 = "tag_seat_3";
      break;
  }

  return var_1;
}

function enter_seat_omnvar(var_0, var_1) {
  for(var_2 = 0; var_2 <= var_0.vehicle_riding_on.players_as_passenger.size - 1; var_2++) {
    var_3 = var_0.vehicle_riding_on.players_as_passenger[var_2];
    var_4 = var_3 getentitynumber() + 1;
    var_1 = var_3.current_vehicle_seat;
    thread enter_seat_omnvar_internal(var_3, var_3, var_4);
  }
}

function enter_seat_omnvar_internal(var_0, var_1, var_2) {
  var_3 = get_seat_omnvar_name(var_2);

  foreach(var_5 in level.players) {
    if(isDefined(var_5.vehicle_riding_on) && var_5.vehicle_riding_on == var_0.vehicle_riding_on) {
      var_6 = var_5.vehicle_riding_on;
      var_5 setclientomnvar(var_3, var_1 - 1);

      if(isDefined(var_6.fake_health) && isDefined(var_6.max_fake_health)) {
        var_7 = int(clamp(var_6.fake_health / var_6.max_fake_health * 100, 0, 100));
        var_5 setclientomnvar("ui_veh_health_percent", int(var_7));

        if(var_7 < 1 && var_7 > 0) {
          var_5 setclientomnvar("ui_veh_show_health", 1);
        } else {
          var_5 setclientomnvar("ui_veh_show_health", 0);
        }
      } else {
        var_5 setclientomnvar("ui_veh_show_health", 0);
      }
    }
  }
}

function get_seat_omnvar_name(var_0) {
  var_1 = "ui_veh_occupant_0";

  switch (var_0) {
    case "driver":
      var_1 = "ui_veh_occupant_0";
      break;
    case "overwatch":
    case "passenger":
      var_1 = "ui_veh_occupant_1";
      break;
    case "mine_drone_left":
    case "missile_defense_left":
    case "overwatch_left":
    case "left_back_seat":
      var_1 = "ui_veh_occupant_2";
      break;
    case "mine_drone_right":
    case "missile_defense_right":
    case "overwatch_right":
    case "right_back_seat":
      var_1 = "ui_veh_occupant_3";
      break;
    case "grenadier":
    case "gunner":
      var_1 = "ui_veh_occupant_4";
      break;
  }

  return var_1;
}

function watch_for_host_migration() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");

    foreach(var_1 in level.players) {
      var_1 setclientomnvar("ui_hide_minimap", 1);
      var_1 scripts\cp\utility::init_vehicle_omnvars();

      if(isDefined(var_1.vehicle_riding_on.players_as_passenger)) {
        enter_seat_omnvar(var_1);
        continue;
      }

      var_1 setclientomnvar("ui_veh_vehicle", -1);
    }
  }
}

function exit_seat_omnvar(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  var_0 setclientomnvar("ui_veh_vehicle", -1);
  var_4 = get_seat_omnvar_name(var_1);

  foreach(var_0 in level.players) {
    if(isDefined(var_0.vehicle_riding_on) && var_0.vehicle_riding_on == var_2) {
      var_0 setclientomnvar(var_4, -1);
    }
  }
}

function delay_relax_view_arc(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("player_exit_vehicle");
  waitframe();
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 0, 120, 120, 120, 120, 1);
}

function exit_seat(var_0, var_1) {
  if(istrue(var_1) && !istrue(var_0.stay_on_seat_when_exit_seat)) {
    technical_stopanimatingplayer(var_0);
    var_0 unlink();
    return;
  }
}

function exit_seat_but_stay_in_vehicle(var_0, var_1) {
  var_0.exit_vehicle_when_exit_seat = 0;
  var_0 notify("exit_" + var_0.current_vehicle_seat);
  exit_seat_omnvar(var_0, var_0, var_0.current_vehicle_seat, var_1);
}

function exit_seat_but_stay_on_seat(var_0) {
  var_0.exit_vehicle_when_exit_seat = 0;
  var_0.stay_on_seat_when_exit_seat = 1;
  var_0 notify("exit_" + var_0.current_vehicle_seat);
}

function record_seat(var_0, var_1) {
  var_0.previous_vehicle_seat = var_0.current_vehicle_seat;
  var_0.current_vehicle_seat = var_1;
}

function return_to_previous_seat(var_0, var_1) {
  var_2 = get_vehicle_interaction_point(var_1, var_0.previous_vehicle_seat);
  var_2 notify("trigger", var_0);
  enter_seat_omnvar(var_0, var_0, var_0.previous_vehicle_seat);
}

function force_player_to_stand(var_0) {
  var_0 endon("disconnect");
  var_0 allowstand(1);
  var_0 allowprone(0);
  var_0 allowcrouch(0);
  wait 0.5;
  var_0 allowprone(1);
  var_0 allowcrouch(1);
}

function try_exit_vehicle(var_0, var_1, var_2) {
  if(istrue(var_0.exit_vehicle_when_exit_seat)) {
    exit_vehicle(var_0, var_1, var_2);
    return;
  }
}

function enter_vehicle(var_0, var_1) {
  level notify("players_entered_vehicle");
  var_0 notify("player_enter_vehicle");
  var_0 setclientomnvar("ui_veh_vehicle", 10);
  var_0.vehicle_riding_on = var_1;
  var_0 disableoffhandprimaryweapons();
  var_0 disableoffhandsecondaryweapons();
  var_0 allowsprint(0);
  var_0 allowsupersprint(0);
  var_0 scripts\cp\cp_kidnapper::setimmunetokidnapper(1);
  add_to_players_as_passenger_list(var_1, var_0);
  add_to_players_cannot_see_vehicle_icon_list(var_1, var_0);
  update_vehicle_objective_visibility(var_1);
  ref_12bec(var_0, var_1);
  update_driver_interaction_hint(var_1);
}

function exit_vehicle(var_0, var_1, var_2) {
  var_0 notify("player_exit_vehicle");
  exit_seat_omnvar(var_0, var_0, var_2, var_1);
  var_0.vehicle_riding_on = undefined;
  var_0 scripts\cp\cp_kidnapper::setimmunetokidnapper(0);
  remove_from_players_as_passenger_list(var_1, var_0);
  remove_from_players_cannot_see_vehicle_icon_list(var_1, var_0);
  update_vehicle_objective_visibility(var_1);
  var_0.current_vehicle_seat = undefined;
  var_3 = get_exit_vehicle_teleport_to_loc(var_0, var_1, var_2);
  var_0 setOrigin(var_3, 1);
  var_0 setworldupreference(undefined);
  var_0 enableoffhandprimaryweapons();
  var_0 enableoffhandsecondaryweapons();
  var_0 allowsprint(1);
  var_0 allowsupersprint(1);
  thread force_player_to_stand(var_0);
  race_set_next_checkpoint(var_0, var_0);
  update_driver_interaction_hint(var_1);

  if(should_enable_seat_when_exit_vehicle(var_1, var_2)) {
    enable_vehicle_interaction(var_1, var_2);
    return;
  }
}

function ref_12bec(var_0, var_1) {
  if(isDefined(var_1.ref_128c0)) {
    var_0.ref_128c1 = [];
    var_2 = var_0 getweaponslistprimaries();
    var_3 = var_0 getcurrentweapon();
    var_4 = scripts\engine\utility::array_contains(var_1.ref_128c0, var_3.basename);

    foreach(var_6 in var_2) {
      if(isDefined(var_6.basename) && scripts\engine\utility::array_contains(var_1.ref_128c0, var_6.basename)) {
        var_0.ref_128c1[var_0.ref_128c1.size] = var_6;
        var_0 takeweapon(var_6);
      }
    }

    if(istrue(var_4)) {
      var_0 switchtoweapon(var_0 getweaponslistprimaries()[0]);
      return;
    }

    return;
  }
}

function race_set_next_checkpoint(var_0) {
  var_1 = 0;

  if(isDefined(var_0.ref_128c1)) {
    foreach(var_3 in var_0.ref_128c1) {
      var_0 giveweapon(var_3);

      if(issubstr(var_3.basename, "riotshield")) {
        var_1 = 1;
      }
    }

    var_0.ref_128c1 = undefined;
  }

  if(istrue(var_1)) {
    var_0 scripts\cp\cp_weapon::riotshieldonweaponchange();
    return;
  }
}

function update_vehicle_objective_visibility(var_0) {
  if(getdvarint("scr_disable_vehicle_icon", 0) != 0) {
    return;
  }

  if(!isDefined(var_0.objective_id)) {
    return;
  }

  foreach(var_2 in level.players) {
    if(scripts\engine\utility::array_contains(var_0.players_cannot_see_vehicle_icon, var_2)) {
      objective_removeclientfrommask(var_0.objective_id, var_2);
      continue;
    }

    objective_addclienttomask(var_0.objective_id, var_2);
  }

  objective_showtoplayersinmask(var_0.objective_id);
}

function should_enable_seat_when_exit_vehicle(var_0, var_1) {
  return true;
}

function get_exit_vehicle_teleport_to_loc(var_0, var_1, var_2) {
  var_3 = create_seat_name_array(var_2);
  var_4 = 0;
  var_2 = var_3[var_4];
  var_5 = get_exit_base_interaction_point(var_0, var_1, var_2);
  var_6 = get_exit_direction_vector(var_0, var_1, var_2);
  var_7 = vectorNormalize(var_6);
  var_7 *= -5;
  var_8 = var_5.origin + var_6;
  var_9 = scripts\engine\trace::capsule_trace(var_5.origin + var_7, var_8, 6, 80, undefined, var_1);
  var_10 = 1;

  if(distance2dsquared(var_9["position"], var_8) < 225) {
    if(abs(var_9["position"][2] - var_8[2]) < 25) {
      var_10 = 0;
    }

    if(!ispointonnavmesh(var_9["position"])) {
      var_10 = 0;
    }
  }

  while(var_10 && var_4 < var_3.size) {
    var_2 = var_3[var_4];
    var_5 = get_exit_base_interaction_point(var_0, var_1, var_2);

    if(isDefined(var_5)) {
      var_6 = get_exit_direction_vector(var_0, var_1, var_2);
      var_7 = vectorNormalize(var_6);
      var_7 *= -5;
      var_8 = var_5.origin + var_6;
      var_9 = scripts\engine\trace::capsule_trace(var_5.origin + var_7, var_8, 6, 80, undefined, var_1);

      if(distance2dsquared(var_9["position"], var_8) < 225) {
        if(abs(var_9["position"][2] - var_8[2]) < 25) {
          var_10 = 0;
        }

        if(!ispointonnavmesh(var_9["position"])) {
          var_10 = 0;
        }
      }
    }

    if(var_10) {
      var_4++;
    }

    waitframe();
  }

  if(var_4 >= var_3.size) {
    var_8 = var_1.origin + (0, 0, 100);
  }

  var_11 = scripts\engine\trace::capsule_trace(var_8 + (0, 0, 0), var_8 + (0, 0, -256), 6, 80)["position"];
  return var_11;
}

function create_seat_name_array(var_0) {
  switch (var_0) {
    case "driver":
      return ["driver", "left_back_seat", "passenger", "right_back_seat"];
    case "passenger":
      return ["passenger", "right_back_seat", "driver", "left_back_seat"];
    case "left_back_seat":
      return ["left_back_seat", "driver", "right_back_seat", "passenger"];
    case "right_back_seat":
      return ["right_back_seat", "passenger", "left_back_seat", "driver"];
  }
}

function get_exit_base_interaction_point(var_0, var_1, var_2) {
  switch (var_2) {
    case "driver":
      return get_vehicle_interaction_point(var_1, "driver");
    case "passenger":
      return get_vehicle_interaction_point(var_1, "passenger");
    case "left_back_seat":
      return get_vehicle_interaction_point(var_1, "left_back_seat");
    case "right_back_seat":
      return get_vehicle_interaction_point(var_1, "right_back_seat");
  }
}

function get_exit_direction_vector(var_0, var_1, var_2) {
  var_3 = anglestoright(var_1.angles);
  var_4 = var_3 * -1;

  switch (var_2) {
    case "left_back_seat":
    case "driver":
      return (var_4 * 50);
    case "right_back_seat":
    case "passenger":
      return (var_3 * 50);
  }
}

function get_vehicle_interaction_point(var_0, var_1) {
  return var_0.vehicle_interactions[var_1];
}

function make_vehicle_seat(var_0, var_1, var_2, var_3) {
  var_4 = var_0 gettagorigin("tag_origin");
  var_5 = anglesToForward(var_0.angles);
  var_6 = anglestoright(var_0.angles);
  var_7 = anglestoup(var_0.angles);
  var_8 = var_4 + var_5 * var_1 + var_6 * var_2 + var_7 * var_3;
  var_9 = spawn("script_model", var_8);
  var_9 setModel("tag_origin");
  var_9.angles = var_0.angles;
  var_9.vehicle = var_0;
  var_9 linkTo(var_0);
  thread clean_up_on_vehicle_death(var_9, var_9);
  return var_9;
}

function init_vehicle(var_0, var_1) {
  var_0.ied_triggering_tag_to_repair_tag_mapping = var_1.ied_triggering_tag_to_repair_tag_mapping;
  var_0.repair_interaction_list = [];
  var_0.players_as_passenger = [];
  var_0.players_cannot_see_vehicle_icon = [];
  var_0.disabled = 0;
  var_0.script_badplace = 1;
  var_0.classname_mp = var_1.classname_mp;
  var_0.slow_tread_vfx_trigger_speed = var_1.slow_tread_vfx_trigger_speed;
  var_0.fast_tread_vfx_trigger_speed = var_1.fast_tread_vfx_trigger_speed;
  var_0.tread_vfx_tags = var_1.tread_vfx_tags;
  var_0.ref_128c0 = var_1.ref_128c0;
}

function vehicle_damage_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_0.max_fake_health = var_1.fake_health;
  var_0.fake_health = var_1.fake_health;
  var_0.trigger_damage_state_health = int(var_0.fake_health * var_1.show_damage_state_health_ratio);
  var_0.showing_damage_state = 0;
  var_0.disabled_due_to_damage = 0;

  for(;;) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0.health = 999999;

    if(is_friendly_fire(var_3, var_11)) {
      thread melee_to_nudge_car(var_0, var_0, var_5);
      continue;
    }

    if(isDefined(var_2)) {
      if(isDefined(var_11)) {
        var_2 = adjust_damage_to_vehicle(var_2, var_11, var_0);
      }

      var_0.fake_health -= var_2;
      var_12 = int(clamp(var_0.fake_health / var_1.fake_health * 100, 0, 100));

      foreach(var_14 in level.players) {
        if(isDefined(var_14.vehicle_riding_on) && var_14.vehicle_riding_on == var_0) {
          var_14 setclientomnvar("ui_veh_health_percent", int(var_12));
          var_14 setclientomnvar("ui_veh_show_health", 1);
        }
      }

      if(var_0.fake_health < 0 && !istrue(var_0.disabled_due_to_damage)) {
        disabling_vehicle_due_to_damage(var_0);
      } else if(var_0.fake_health < var_0.trigger_damage_state_health) {
        show_vehicle_damage_state(var_0);
      }
    }
  }
}

function adjust_damage_to_vehicle(var_0, var_1, var_2) {
  if(isDefined(var_1.basename) && (var_1.basename == "juliet_missile_cp" || var_1.basename == "rpg_missile_cp" || var_1.basename == "cruise_missile_warhead_cp")) {
    return (var_2.fake_health + 100);
  }

  return var_0;
}

function is_friendly_fire(var_0, var_1) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isPlayer(var_0)) {
    return true;
  }

  if(isDefined(var_0.owner) && isPlayer(var_0.owner)) {
    return true;
  }

  if(isDefined(var_1) && isDefined(var_1.basename) && var_1.basename == "overwatch_missile_cp") {
    return true;
  }

  return false;
}

function melee_to_nudge_car(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 == "MOD_MELEE" && var_0.players_as_passenger.size == 0) {
    var_3 = (var_1 + var_0.origin) / 2 - (0, 0, 40);
    physicsexplosionsphere(var_3, 3, 2, 4);
    return;
  }
}

function show_vehicle_damage_state(var_0) {
  if(istrue(var_0.showing_damage_state)) {
    return;
  }

  var_0.showing_damage_state = 1;
  var_1 = get_vehicle_interaction_point(var_0, "hood_repair");
  thread play_vfx_on_repair_part(var_1, var_0, "tag_grill", "vehicle_hood_damage_smoke", var_1);
}

function disabling_vehicle_due_to_damage(var_0) {
  var_0.disabled_due_to_damage = 1;
  var_0.disabled = 1;
  update_driver_interaction_hint(var_0);
  level notify("vehicle_needs_repair");
  var_1 = get_vehicle_interaction_point(var_0, "hood_repair");
  put_icon_on_vehicle_repair_point(var_0, var_1);
  set_repair_omnvars("hood_repair", 1);
  thread play_vfx_on_repair_part(var_1, var_0, "tag_light_front_right_2", "vehicle_hood_damage_smoke", var_1);
  thread play_vfx_on_repair_part(var_1, var_0, "tag_light_front_left_2", "vehicle_hood_damage_smoke", var_1);
  force_driver_out_of_vehicle(var_0);
  show_vehicle_damage_state(var_0);
  enable_vehicle_interaction(var_0, "hood_repair");
  var_1 = get_vehicle_interaction_point(var_0, "hood_repair");
  add_to_vehicle_repair_interaction_list(var_0, var_1);
}

function set_up_vehicle_interactions(var_0, var_1) {
  var_2 = var_0.angles;
  var_3 = anglesToForward(var_2);
  var_4 = anglestoright(var_2);
  var_5 = anglestoup(var_2);
  var_6 = var_0 gettagorigin("tag_origin");
  var_0.vehicle_interactions = [];

  foreach(var_11, var_8 in var_1.interaction_setups_array) {
    var_9 = var_6 + var_3 * var_8.front_offset_from_tag_origin + var_4 * var_8.right_offset_from_tag_origin + var_5 * var_8.up_offset_from_tag_origin;
    var_10 = spawn("script_model", var_9);
    var_10 setModel("tag_origin");
    var_10 linkTo(var_0);
    var_8 = get_vehicle_interaction_info(var_11);
    var_10 setHintString(var_8.hint_string);
    var_10 setCursorHint("HINT_BUTTON");
    var_10 sethintdisplayrange(var_8.display_range);
    var_10 sethintdisplayfov(var_8.display_fov);
    var_10 setuserange(var_8.use_range);
    var_10 setusefov(var_8.use_fov);
    var_10 sethintonobstruction("hide");
    var_10 setuseholdduration(var_8.use_hold_duration);
    thread use_think(var_10, var_11, var_10, var_0, var_8.try_use_func, var_8.start_use_func, var_8.exit_use_func, var_8.exit_button);
    var_0.vehicle_interactions[var_11] = var_10;
  }
}

function set_up_ied_triggering_tags(var_0, var_1) {
  var_0.ied_triggering_tags = var_1.ied_triggering_tags;
}

function use_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_2 endon("death");
  var_8 = "exit_" + var_0;

  if(istrue(var_7)) {
    var_1 makeusable();
  }

  var_1.being_used = 0;

  for(;;) {
    var_1 waittill("trigger", var_9);

    if(isDefined(var_3) && ![[var_3]](var_2, var_9)) {
      continue;
    }

    if(isDefined(var_6)) {
      var_9 notifyonplayercommand(var_8, var_6);
    }

    var_1 makeunusable();
    var_1.being_used = 1;
    var_1 thread[[var_4]](var_1, var_9, var_2);

    if(isDefined(var_6)) {
      var_10 = var_9 scripts\engine\utility::waittill_any_ents_return(var_9, "disconnect", var_9, var_8, var_1, "interaction_point_disabled", var_9, "last_stand", var_9, "force_player_exit_vehicle", var_9, "force_player_exit_seat");
    } else {
      var_10 = var_9 scripts\engine\utility::waittill_any_ents_return(var_9, "disconnect", var_1, "interaction_point_disabled", var_9, "last_stand", var_9, "repair_failed", var_9, "force_player_exit_vehicle", var_9, "force_player_exit_seat");
    }

    if(isDefined(var_5)) {
      var_1 thread[[var_5]](var_1, var_9, var_2, var_10);
    }
  }
}

function register_vehicle_interaction_info(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = spawnStruct();
  var_12.hint_string = var_1;
  var_12.try_use_func = var_2;
  var_12.start_use_func = var_3;
  var_12.exit_use_func = var_4;
  var_12.exit_button = var_5;
  var_12.display_range = var_6;
  var_12.display_fov = var_7;
  var_12.use_range = var_8;
  var_12.use_fov = var_9;
  var_12.use_hold_duration = var_10;
  var_12.available_on_start = var_11;
  level.vehicle_interaction_info[var_0] = var_12;
}

function get_vehicle_interaction_info(var_0) {
  return level.vehicle_interaction_info[var_0];
}

function assign_vehicle_interaction(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.front_offset_from_tag_origin = var_1;
  var_5.right_offset_from_tag_origin = var_2;
  var_5.up_offset_from_tag_origin = var_3;
  var_4 = var_5;
  return var_4;
}

function debug_interaction_point(var_0) {
  for(;;) {
    waitframe();
  }
}

function add_additional_parts(var_0, var_1) {
  if(isDefined(var_1.add_additional_parts_func)) {
    level thread[[var_1.add_additional_parts_func]](var_0);
    return;
  }
}

function set_up_fake_character_models(var_0) {
  var_0.fake_back_right_passenger = make_fake_character_model(var_0, "tag_seat_3", 1);
  var_0.fake_back_left_passenger = make_fake_character_model(var_0, "tag_seat_2", 1);
}

#using_animtree("script_model");

function make_fake_character_model(var_0, var_1, var_2, var_3) {
  var_4 = var_0 gettagorigin(var_1);
  var_5 = spawn("script_model", var_4, 0, 1);
  var_5 setModel("fullbody_hero_price_urban");
  var_5.angles = var_0.angles;
  var_5 useanimtree(#animtree);

  if(isDefined(var_3)) {
    var_5 linkTo(var_0, var_1, var_3, (0, 0, 0));
  } else {
    var_5 linkTo(var_0, var_1);
  }

  thread fake_driver_anim_loop(var_5);
  thread clean_up_on_vehicle_death(var_5, var_5);

  if(istrue(var_2)) {
    var_5 hide();
  }

  return var_5;
}

function clean_up_on_vehicle_death(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

#using_animtree("");

function fake_driver_anim_loop(var_0) {
  var_0 endon("death");
  var_1 = 17.5;
  wait randomfloatrange(0.5, 3.5);

  for(;;) {
    var_0 scriptmodelplayanim(%mp_infil_lbravo_a_pilot);
    wait var_1;
  }
}

function overwatch_screen_transition(var_0) {
  if(!isDefined(var_0.overwatch_transition_screen)) {
    var_0.overwatch_transition_screen = newclienthudelem(var_0);
    var_0.overwatch_transition_screen.x = 0;
    var_0.overwatch_transition_screen.y = 0;
    var_0.overwatch_transition_screen setshader("black", 640, 480);
    var_0.overwatch_transition_screen.alignx = "left";
    var_0.overwatch_transition_screen.aligny = "top";
    var_0.overwatch_transition_screen.sort = 1;
    var_0.overwatch_transition_screen.horzalign = "fullscreen";
    var_0.overwatch_transition_screen.vertalign = "fullscreen";
    var_0.overwatch_transition_screen.foreground = 1;
  }

  var_0.overwatch_transition_screen.alpha = 1;
  var_0.overwatch_transition_screen fadeovertime(0.25);
  var_0.overwatch_transition_screen.alpha = 0;
}

function set_up_ieds() {
  level.unidentified_ieds = [];
  level.identified_ieds = [];

  if(!ied_enabled()) {
    return;
  }

  var_0 = scripts\engine\utility::getStructArray("IED_controller", "script_noteworthy");

  foreach(var_2 in var_0) {
    spawn_ied_zone(var_2);
    waitframe();
  }
}

function spawn_ied_zone(var_0) {
  if(!should_spawn_ied_zone(var_0)) {
    return;
  }

  var_0.identified = 0;
  var_1 = get_num_of_ied_to_spawn(var_0);

  if(isDefined(var_0.target)) {
    var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  } else {
    var_2 = [];
  }

  if(var_2.size > 0) {
    for(var_3 = 0; var_3 < 5; var_3++) {
      var_2 = scripts\engine\utility::array_randomize(var_2);
    }

    for(var_4 = 0; var_4 < var_2; var_4++) {
      spawn_ied(var_2[var_4], var_1);
    }
  } else if(var_2.size == 0 && var_2 > 0) {
    if(!isDefined(level.ied_unique_names)) {
      level.ied_unique_names = 0;
    }

    var_5 = "IED_auto_group_" + level.ied_unique_names;
    var_1.target = var_5;
    level.ied_unique_names++;
    var_6 = 256;

    if(isDefined(var_1.radius)) {
      var_6 = var_1.radius;
    }

    if(var_6 < 20) {
      var_6 = 20;
    }

    var_7 = var_6 * 0.1;

    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_8 = randomfloatrange(var_7, var_6);
      var_9 = randomfloatrange(var_7, var_6);

      if(scripts\engine\utility::cointoss()) {
        var_8 *= -1;
      }

      if(scripts\engine\utility::cointoss()) {
        var_9 *= -1;
      }

      var_10 = (var_8, var_9, 0);
      var_11 = spawnStruct();
      var_11.origin = var_1.origin + var_10;
      var_11.origin = scripts\engine\utility::drop_to_ground(var_11.origin);

      if(isDefined(var_1.script_label) && var_1.script_label != "") {
        var_11.script_parameters = var_1.script_label;
        var_11.angles = (0, randomfloat(360), 0);
        var_11.origin += (0, 0, 2);
      } else {
        var_11.script_parameters = "bomb_homemade_jug_01";
        var_11.angles = (randomfloat(360), randomfloat(360), randomfloat(360));
      }

      var_11.targetname = var_5;
      spawn_ied(var_11, var_1);
    }
  }

  thread ied_controller_activation_monitor(var_1);
}

function should_spawn_ied_zone(var_0) {
  var_1 = 1;

  if(getdvarfloat("scr_ied_spawn_chance", 0) != 0) {
    var_1 = getdvarfloat("scr_ied_spawn_chance");
  }

  return randomfloat(1) < var_1;
}

function get_num_of_ied_to_spawn(var_0) {
  if(isDefined(var_0.script_parameters)) {
    return int(var_0.script_parameters);
  }

  return scripts\engine\utility::getStructArray(var_0.target, "targetname").size;
}

function spawn_ied(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_0.script_parameters);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_2.target = var_0.target;
  var_2.ied_controller = var_1;
  var_2.active = 0;
  var_3 = anglestoup(var_2.angles);
  var_2.center_point = var_2.origin + var_3 * 10;
  add_to_unidentified_ieds_list(var_2);
  thread ied_damage_monitor(var_2);
  thread ied_trigger_monitor(var_2);
}

function ied_damage_monitor(var_0) {
  var_0 endon("IED_exploded");
  var_0 setCanDamage(1);
  var_0.health = 999999;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    var_0.health = 999999;

    if(isDefined(var_2) && isPlayer(var_2) || isDefined(var_2.owner) && isPlayer(var_2.owner) || isDefined(var_10) && var_10.basename == "overwatch_missile_cp") {
      ied_explodes(var_0);
    }
  }
}

function ied_controller_activation_monitor(var_0) {
  for(;;) {
    if(!isDefined(scripts\engine\utility::getclosest(var_0.origin, level.players, 1024))) {
      deactivate_linked_ied_spawners(var_0);
    } else {
      activate_linked_ied_spawners(var_0);
    }

    wait 0.25;
  }
}

function deactivate_linked_ied_spawners(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2].ied_controller) && istrue(var_1[var_2].active)) {
      var_1[var_2] notify("IED_trigger_monitor");
      var_1[var_2].active = 0;
    }
  }
}

function activate_linked_ied_spawners(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2].ied_controller) && !istrue(var_1[var_2].active)) {
      var_1[var_2].active = 1;
      thread ied_trigger_monitor(var_1[var_2]);
    }
  }
}

function ied_trigger_monitor(var_0) {
  var_0 notify("IED_trigger_monitor");
  var_0 endon("IED_trigger_monitor");
  var_0 endon("IED_exploded");

  for(;;) {
    if(ied_should_explode(var_0)) {
      ied_explodes(var_0);
    }

    wait 0.1;
  }
}

function ied_should_explode(var_0) {
  if(ied_triggered_by_players(var_0)) {
    return true;
  }

  if(ied_triggered_by_vehicles(var_0)) {
    return true;
  }

  return false;
}

function ied_explodes(var_0, var_1) {
  earthquake(0.5, 1.2, var_0.origin, 400);
  playFX(level._effect["IED_explosion"], var_0.origin);
  playsoundatpos(var_0.origin, "frag_grenade_expl_trans");

  if(isDefined(var_0.overwatch_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_0, var_0 getentitynumber(), var_0.overwatch_target_marker_group_id);
  }

  remove_from_unidentified_ieds_list(var_0);
  remove_from_identified_ieds_list(var_0);
  remove_ied_marker_vfx(var_0);
  mark_ied_controller_as_identified(var_0);
  thread delay_respawn_ied_zone(level);
  damage_nearby_players(var_0, 100, 6400);
  damage_nearby_map_vehicles(var_0, 9216);
  damage_nearby_vehicles(var_0, 1600);
  send_notify_from_ied_controller(var_0);
  delete_ied_marker_vfx_to_non_overwatch(var_0);
  do_level_specific_callback(var_0);
  var_0 delete();
  var_0 notify("IED_exploded");
}

function remove_from_target_marker_group(var_0) {
  if(isDefined(var_0.target_marker_group_id_list)) {
    foreach(var_2 in var_0.target_marker_group_id_list) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_0, var_2);
    }

    return;
  }
}

function do_level_specific_callback(var_0) {
  if(isDefined(level.ied_explosion_action_func)) {
    level thread[[level.ied_explosion_action_func]](var_0);
    return;
  }
}

function delete_ied_marker_vfx_to_non_overwatch(var_0) {
  if(!isDefined(var_0.ied_marker_vfxs_non_overwatch)) {
    return;
  }

  foreach(var_2 in var_0.ied_marker_vfxs_non_overwatch) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

function send_notify_from_ied_controller(var_0) {
  var_1 = var_0.ied_controller;

  if(isDefined(var_1.groupname)) {
    level notify(var_1.groupname);
    return;
  }
}

function set_ied_scanned_flag_from_ied_controller(var_0) {
  var_1 = var_0.ied_controller;

  if(isDefined(var_1.script_side)) {
    if(!scripts\engine\utility::flag_exist(var_1.script_side)) {
      scripts\engine\utility::flag_init(var_1.script_side);
    }

    scripts\engine\utility::flag_set(var_1.script_side);
    return;
  }
}

function ied_triggered_by_vehicles(var_0) {
  for(var_1 = 0; var_1 < level.vehicle_travel_array.size; var_1++) {
    if(isDefined(level.vehicle_travel_array[var_1].under_vehicle_trigger) && var_0 istouching(level.vehicle_travel_array[var_1].under_vehicle_trigger)) {
      return 1;
    }
  }

  if(isDefined(level.ied_triggered_by_friendly_convoy_func)) {
    return [[level.ied_triggered_by_friendly_convoy_func]](var_0);
  }

  return 0;
}

function ied_triggered_by_players(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(istrue(level.players[var_1].b_in_vehicle)) {
      continue;
    }

    if(isDefined(level.player_is_terrorist_func) && [[level.player_is_terrorist_func]](level.players[var_1])) {
      continue;
    }

    if(distancesquared(level.players[var_1].origin, var_0.center_point) < 1600) {
      return true;
    }
  }

  return false;
}

function add_to_vehicle_travel_array(var_0) {
  if(!isDefined(level.vehicle_travel_array)) {
    level.vehicle_travel_array = [];
  }

  level.vehicle_travel_array = scripts\engine\utility::array_add(level.vehicle_travel_array, var_0);
}

function damage_nearby_players(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0.origin) < var_2) {
      var_4 dodamage(var_1, var_0.origin);
    }
  }
}

function damage_nearby_map_vehicles(var_0, var_1) {
  if(!isDefined(level.veh_map_ieddamage)) {
    level.veh_map_ieddamage = getcompleteweaponname("at_mine_ap_mp");
  }

  var_0.team = "axis";

  foreach(var_3 in level.technicals) {
    if(!isent(var_3)) {
      continue;
    }

    if(distancesquared(var_3.origin, var_0.origin) < var_1) {
      var_3 dodamage(800, var_0.origin, var_0, var_0, "MOD_SUICIDE", level.veh_map_ieddamage);
    }
  }
}

function damage_nearby_vehicles(var_0, var_1) {
  var_2 = get_nearby_vehicles(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = var_4.vehicle;
    var_6 = var_4.ied_triggering_tag;
    var_7 = get_repair_interaction_point_name(var_6);
    var_8 = get_vehicle_interaction_point(var_5, var_7);
    try_enable_repair_interaction(var_5, var_6, var_0.origin, var_7, var_8);
  }
}

function try_enable_repair_interaction(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\engine\utility::array_contains(var_0.repair_interaction_list, var_4)) {
    thread do_damage_to_all_players_as_passenger(level, var_2);
    enable_vehicle_interaction(var_0, var_3);
    var_5 = var_0.ied_triggering_tag_to_repair_tag_mapping[var_1];
    var_4.repair_tag = var_5;
    add_to_vehicle_repair_interaction_list(var_0, var_4, var_5);
    put_icon_on_vehicle_repair_point(var_0, var_4);
    thread play_vfx_on_repair_part(var_4, var_0, var_5, get_fire_damage_vfx(var_5), var_4);
    var_0.disabled = 1;
    update_driver_interaction_hint(var_0);
    level notify("vehicle_needs_repair");
    force_driver_out_of_vehicle(var_0);
    return;
  }
}

function update_driver_interaction_hint(var_0) {
  var_1 = get_vehicle_interaction_point(var_0, "driver");
  var_1 setHintString(prophidetime(var_0));
}

function prophidetime(var_0) {
  if(istrue(var_0.disabled)) {
    return &"CP_VEHICLE_TRAVEL/REPAIR_FIRST";
  }

  if(isDefined(level.reduce_accuracy_while_stunned)) {
    return [[level.reduce_accuracy_while_stunned]](var_0);
  }

  return &"CP_VEHICLE_TRAVEL/DRIVER";
}

function get_fire_damage_vfx(var_0) {
  if(issubstr(var_0, "left")) {
    return "vehicle_tire_damage_smoke_left";
  }

  return "vehicle_tire_damage_smoke_right";
}

function force_driver_out_of_vehicle(var_0) {
  var_1 = get_vehicle_interaction_point(var_0, "driver");
  var_1 notify("interaction_point_disabled");
}

function do_damage_to_all_players_as_passenger(var_0, var_1) {
  waitframe();

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && !scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      var_3 dodamage(20, var_0);
    }
  }
}

function get_repair_interaction_point_name(var_0) {
  switch (var_0) {
    case "tag_wheel_back_left":
      return "back_left_repair";
    case "tag_wheel_back_right":
      return "back_right_repair";
    case "tag_wheel_front_left":
      return "front_left_repair";
    case "tag_wheel_front_right":
      return "front_right_repair";
  }
}

function add_to_vehicle_repair_interaction_list(var_0, var_1, var_2) {
  if(!scripts\engine\utility::array_contains(var_0.repair_interaction_list, var_1)) {
    var_0.repair_interaction_list = scripts\engine\utility::array_add(var_0.repair_interaction_list, var_1);

    if(isDefined(var_2)) {
      set_repair_omnvars(var_2, 1);
      return;
    }

    return;
  }
}

function remove_from_vehicle_repair_interaction_list(var_0, var_1, var_2) {
  if(scripts\engine\utility::array_contains(var_0.repair_interaction_list, var_1)) {
    var_0.repair_interaction_list = scripts\engine\utility::array_remove(var_0.repair_interaction_list, var_1);

    if(isDefined(var_2)) {
      set_repair_omnvars(var_2, 0);
      return;
    }

    return;
  }
}

function set_repair_omnvars(var_0, var_1) {
  var_2 = "cp_vehicle_damage_1";

  switch (var_0) {
    case "tag_wheel_center_front_left":
      var_2 = "cp_vehicle_damage_1";
      break;
    case "tag_wheel_center_front_right":
      var_2 = "cp_vehicle_damage_2";
      break;
    case "tag_wheel_center_back_left":
      var_2 = "cp_vehicle_damage_3";
      break;
    case "tag_wheel_center_back_right":
      var_2 = "cp_vehicle_damage_4";
      break;
    case "hood_repair":
      var_2 = "cp_vehicle_damage_5";
      break;
  }

  if(istrue(var_1)) {
    var_3 = 1;
  } else {
    var_3 = 0;
  }

  foreach(var_5 in level.players) {
    var_5 setclientomnvar(var_3, var_3);
  }
}

function all_repairs_are_done(var_0) {
  if(var_0.repair_interaction_list.size == 0) {
    return true;
  } else if(var_0.repair_interaction_list.size == 1) {
    if(!var_0.disabled_due_to_damage && var_0.repair_interaction_list[0] == var_0.vehicle_interactions["hood_repair"]) {
      return true;
    }
  }

  return false;
}

function add_to_players_as_passenger_list(var_0, var_1) {
  var_1.b_in_vehicle = 1;

  if(!scripts\engine\utility::array_contains(var_0.players_as_passenger, var_1)) {
    var_0.players_as_passenger = scripts\engine\utility::array_add(var_0.players_as_passenger, var_1);
    return;
  }
}

function remove_from_players_as_passenger_list(var_0, var_1) {
  var_1.b_in_vehicle = 0;

  if(scripts\engine\utility::array_contains(var_0.players_as_passenger, var_1)) {
    var_0.players_as_passenger = scripts\engine\utility::array_remove(var_0.players_as_passenger, var_1);
    return;
  }
}

function add_to_players_cannot_see_vehicle_icon_list(var_0, var_1) {
  if(!scripts\engine\utility::array_contains(var_0.players_cannot_see_vehicle_icon, var_1)) {
    var_0.players_cannot_see_vehicle_icon = scripts\engine\utility::array_add(var_0.players_cannot_see_vehicle_icon, var_1);
    return;
  }
}

function remove_from_players_cannot_see_vehicle_icon_list(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_0.players_cannot_see_vehicle_icon, var_1)) {
    var_0.players_cannot_see_vehicle_icon = scripts\engine\utility::array_remove(var_0.players_cannot_see_vehicle_icon, var_1);
    return;
  }
}

function player_in_vehicle(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_1.players_as_passenger, var_0);
}

function get_nearby_vehicles(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.vehicle_travel_array) {
    if(isDefined(var_4.ied_triggering_tags)) {
      foreach(var_6 in var_4.ied_triggering_tags) {
        if(distancesquared(var_4 gettagorigin(var_6), var_0.origin) < var_1 && !scripts\engine\utility::array_contains(var_2, var_4)) {
          var_7 = spawnStruct();
          var_7.vehicle = var_4;
          var_7.ied_triggering_tag = var_6;
          var_2 = scripts\engine\utility::array_add(var_2, var_7);
        }
      }
    }
  }

  return var_2;
}

function play_vfx_on_repair_part(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 gettagorigin(var_1);
  var_6 = spawn("script_model", var_5);
  var_6 setModel("tag_origin");
  var_6.angles = vectortoangles(var_4);
  var_6 linkTo(var_0);
  wait 0.1;
  playFXOnTag(level._effect[var_2], var_6, "tag_origin");
  scripts\engine\utility::waittill_any_ents(var_0, "death", var_3, "interaction_point_disabled");
  stopFXOnTag(level._effect[var_2], var_6, "tag_origin");
  var_6 delete();
}

function put_icon_on_vehicle_repair_point(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::requestworldid("repair_icon", 21);
  objective_setplayintro(var_2, 0);
  objective_setbackground(var_2, 1);
  objective_state(var_2, "invisible");
  objective_icon(var_2, "cp_tac_hud_icon_repair");
  objective_setlabel(var_2, "");
  objective_onentity(var_2, var_1);
  objective_addalltomask(var_2);
  var_1.objective_id = var_2;
  thread repair_icon_clean_up_think(var_1, var_0, var_1);
}

function repair_icon_clean_up_think(var_0, var_1, var_2) {
  scripts\engine\utility::waittill_any_ents(var_0, "death", var_1, "interaction_point_disabled");
  objective_delete(var_2);
  scripts\cp\cp_objectives::freeworldid("repair_icon");
}

function delay_respawn_ied_zone(var_0) {
  level endon("game_ended");
  var_1 = var_0.ied_controller;
  wait randomfloatrange(600, 900);

  for(;;) {
    if(can_respawn_ied_zone(var_1)) {
      spawn_ied_zone(var_1);
      return;
    }

    wait 15;
  }
}

function can_respawn_ied_zone(var_0) {
  foreach(var_2 in level.players) {
    if(distance2dsquared(var_2.origin, var_0.origin) < 250000) {
      return false;
    }

    if(isDefined(var_2.overwatch_camera_point) && distance2dsquared(var_2.overwatch_camera_point.origin, var_0.origin) < 1000000) {
      return false;
    }
  }

  return true;
}

function remove_ied_marker_vfx(var_0) {
  if(isDefined(var_0.marker_vfx)) {
    var_0.marker_vfx delete();
  }

  if(isDefined(var_0.mine_drone_marker_vfx)) {
    var_0.mine_drone_marker_vfx delete();
    return;
  }
}

function show_ied_zone_to_player(var_0) {
  if(!ied_enabled()) {
    return;
  }

  show_identified_ieds_to_overwatch(var_0);
}

function ied_enabled() {
  return getdvarint("scr_enable_ied", 0) != 0;
}

function show_identified_ieds_to_overwatch(var_0) {
  if(!isDefined(level.identified_ieds)) {
    return;
  }

  level.identified_ieds = scripts\engine\utility::array_removeundefined(level.identified_ieds);

  if(level.identified_ieds.size > 0) {
    var_0.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("ieddronetarget", var_0, level.identified_ieds, var_0);
    return;
  }
}

function show_identified_ied_to_overwatch(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.origin)) {
    if(isDefined(var_1.overwatch_target_marker_group_id)) {
      handle_identified_ied_to_overwatch_max(var_1);
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_0, var_1.overwatch_target_marker_group_id);
      update_target_marker_group_id_on_ied(var_0, var_1.overwatch_target_marker_group_id);
    } else {
      var_1.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("ieddronetarget", var_1, var_0, var_1);
    }

    var_0.overwatch_target_marker_group_id = var_1.overwatch_target_marker_group_id;
    return;
  }
}

function update_target_marker_group_id_on_ied(var_0, var_1) {
  if(!isDefined(var_0.target_marker_group_id_list)) {
    var_0.target_marker_group_id_list = [];
  }

  if(!scripts\engine\utility::array_contains(var_0.target_marker_group_id_list, var_1)) {
    var_0.target_marker_group_id_list = scripts\engine\utility::array_add(var_0.target_marker_group_id_list, var_1);
    return;
  }
}

function move_cursor_near_identified_ied(var_0) {
  level endon("game_ended");
  var_0 endon("exit_overwatch");
  var_0 endon("disconnect");
  var_1 = 100;
  var_2 = var_1 * var_1;
  var_3 = 1500;
  var_4 = var_3 * var_3;
  var_5 = var_0.overwatch_target_marker_group_id;
  var_6 = undefined;

  if(isDefined(var_5)) {
    var_6 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var_5);
  }

  for(;;) {
    jumpiffalse(!isDefined(var_5) || !isDefined(var_6)) LOC_0000006d;
    var_5 = var_0.overwatch_target_marker_group_id;

    if(isDefined(var_5)) {
      var_6 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var_5);
    }

    wait 0.1;
  }

  for(;;) {
    var_7 = var_0.overwatch_camera_point.origin;
    wait 0.1;
    var_8 = var_0.overwatch_camera_point.origin;

    if(distance2dsquared(var_7, var_8) > var_2) {
      for(var_9 = 0; var_9 < level.identified_ieds.size; var_9++) {
        if(distance2dsquared(level.identified_ieds[var_9].origin, var_8) < var_4) {
          var_10 = level.identified_ieds[var_9] getentitynumber();

          if(!isDefined(var_6.markedents[var_10])) {
            handle_identified_ied_to_overwatch_max(var_0);
            scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(level.identified_ieds[var_9], var_5);
          }
        }
      }
    }
  }
}

function handle_identified_ied_to_overwatch_max(var_0) {
  var_1 = var_0.overwatch_target_marker_group_id;

  if(isDefined(var_1)) {
    var_2 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var_1);

    if(var_2.markedents.size > 18) {
      var_3 = var_0.overwatch_camera_point.origin;
      hide_farthest_targetmarker_for_player(var_3, var_1, level.identified_ieds);
      return;
    }

    return;
  }
}

function hide_farthest_targetmarker_for_player(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var_1);
  var_4 = sortbydistance(var_2, var_0);
  var_5 = 1;

  for(var_6 = var_4.size - 1; var_6 > 0; var_6--) {
    if(!var_5) {
      break;
    }

    if(isent(var_4[var_6])) {
      var_7 = var_4[var_6] getentitynumber();

      if(isDefined(var_3.markedents[var_7])) {
        scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_4[var_6], var_1);
        var_5 = 0;
      }
    }
  }
}

function show_identified_ied_to_non_overwatch(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.origin)) {
    var_0 hudoutlineenable("outlinefill_depth_red");
    return;
  }
}

function show_non_overwatch_ied_marker_vfx_to_player(var_0, var_1) {
  if(!isDefined(var_1.ied_marker_vfxs_non_overwatch)) {
    var_1.ied_marker_vfxs_non_overwatch = [];
  }

  var_2 = spawnfxforclient(level._effect["IED_marker_to_non_overwatch"], var_0.origin, var_1);
  triggerfx(var_2);
  var_1.ied_marker_vfxs_non_overwatch[var_1.ied_marker_vfxs_non_overwatch.size] = var_2;
  var_0.ied_marker_vfxs_non_overwatch[var_0.ied_marker_vfxs_non_overwatch.size] = var_2;
}

function delete_non_overwatch_ied_marker_vfx_for_player(var_0) {
  if(!isDefined(var_0.ied_marker_vfxs_non_overwatch)) {
    return;
  }

  foreach(var_2 in var_0.ied_marker_vfxs_non_overwatch) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

function show_all_non_overwatch_ied_marker_vfx_to_player(var_0) {
  foreach(var_2 in level.identified_ieds) {
    show_non_overwatch_ied_marker_vfx_to_player(var_2, var_0);
  }
}

function hide_ied_zone_from_player(var_0) {
  if(isDefined(var_0.overwatch_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_0.overwatch_target_marker_group_id);
    var_0.overwatch_target_marker_group_id = undefined;
    return;
  }
}

function add_to_unidentified_ieds_list(var_0) {
  if(!scripts\engine\utility::array_contains(level.unidentified_ieds, var_0)) {
    level.unidentified_ieds = scripts\engine\utility::array_add(level.unidentified_ieds, var_0);
    return;
  }
}

function remove_from_unidentified_ieds_list(var_0) {
  level.unidentified_ieds = scripts\engine\utility::array_remove(level.unidentified_ieds, var_0);
}

function add_to_identified_ieds_list(var_0) {
  if(!scripts\engine\utility::array_contains(level.identified_ieds, var_0)) {
    level.identified_ieds = scripts\engine\utility::array_add(level.identified_ieds, var_0);
    return;
  }
}

function is_ied_identified(var_0) {
  return scripts\engine\utility::array_contains(level.identified_ieds, var_0);
}

function remove_from_identified_ieds_list(var_0) {
  level.identified_ieds = scripts\engine\utility::array_remove(level.identified_ieds, var_0);
}

function hostage_near_vehicle_monitor() {
  level endon("game_ended");
  level endon("stop_hostage_vehicle_monitor");

  for(;;) {
    level waittill("player_picked_up_hostage", var_0);

    while(!isDefined(level.vehicle_travel_array)) {
      wait 1;
    }

    thread carried_hostage_near_vehicle_monitor(var_0);
  }
}

function carried_hostage_near_vehicle_monitor(var_0) {
  var_0 endon("disconnect");
  var_0 endon("hostage_dropped_by_me");
  var_0 endon("dropped_hostage");

  for(;;) {
    var_1 = get_closest_vehicle_within_range(var_0, 200);

    if(isDefined(var_1)) {
      if(has_hostage_on_board(var_1)) {
        var_0.hostage_drop_override_data = undefined;
        var_0.hostagecarried.overridehintstring = undefined;
      } else {
        var_2 = get_closest_vehicle_door_available(var_0, var_1);
        var_3 = var_1 gettagorigin("tag_origin");
        var_4 = var_1.angles;
        var_5 = anglesToForward(var_4);
        var_6 = anglestoright(var_4);
        var_7 = anglestoup(var_4);
        var_8 = var_3 + var_5 * -92 + var_6 * 0 + var_7 * 50;
        var_9 = distance(var_0.origin, var_8) < 100;

        if(var_9) {
          var_0.hostage_drop_override_data = make_hostage_drop_override_data(var_1, var_2, var_0);
          var_0.hostagecarried.overridehintstring = "enter_vehicle_with_hostage";
        } else {
          var_0.hostage_drop_override_data = undefined;
          var_0.hostagecarried.overridehintstring = undefined;
        }
      }
    } else {
      var_0.hostage_drop_override_data = undefined;
    }

    waitframe();
  }
}

function get_closest_vehicle_door_available(var_0, var_1) {
  var_2 = ["driver", "passenger", "left_back_seat", "right_back_seat"];
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = get_vehicle_interaction_point(var_1, var_5);

    if(istrue(var_6.being_used)) {
      continue;
    }

    var_3 = var_6;
  }

  if(var_3.size > 0) {
    return scripts\engine\utility::getclosest(var_0.origin, var_3);
  }

  return undefined;
}

function get_closest_vehicle_within_range(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 100;
  }

  var_2 = scripts\engine\utility::getclosest(var_0.origin, level.vehicle_travel_array, var_1);
  return var_2;
}

function make_hostage_drop_override_data(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;
  var_5 = -60;
  var_6 = anglesToForward(var_0.angles);
  var_7 = anglestoup(var_0.angles);
  var_8 = anglestoright(var_0.angles);
  var_9 = spawnStruct();
  var_9.vehicle = var_0;
  var_9.vehicle_door_interaction = var_1;
  var_9.player = var_2;
  var_9.position = var_0 gettagorigin("tag_origin") + var_6 * var_5 + var_7 * var_3 + var_8 * var_4;
  var_9.waittime = 0.05;
  var_9.forcepos = 1;
  var_9.preventuse = 0;
  var_9.call_back_func = &hostage_drop_call_back_func;
  return var_9;
}

function hostage_drop_call_back_func(var_0, var_1) {
  var_2 = var_1.vehicle_door_interaction;
  var_3 = var_1.player;
  var_4 = var_1.vehicle;
  var_3 scripts\cp\utility::hint_prompt("enter_vehicle_with_hostage", 0);
  var_0 makeunusable();
  var_0.angles = (var_0.angles[0], var_4.angles[1] + 180, var_0.angles[2]);
  var_0 linkTo(var_4);

  if(isDefined(var_0.waypoint)) {
    objective_delete(var_0.waypoint);
  }

  var_4.hostage = var_0;
  var_0.carried_by_vehicle = 1;
  var_0 notify("placed_into_player_vehicle");
  wait 2;
  enable_vehicle_interaction(var_4, "retrieve_hostage");
}

function has_hostage_on_board(var_0) {
  return isDefined(var_0.hostage);
}

function tread_vfx_think(var_0) {
  if(!tread_vfx_set_up(var_0)) {
    return;
  }

  foreach(var_2 in var_0.tread_vfx_tags) {
    thread play_tread_vfx_think(var_0, var_0);
  }
}

function play_tread_vfx_think(var_0, var_1) {
  var_0 endon("death");

  for(;;) {
    var_2 = get_speed_type(var_0);

    if(should_play_tread_vfx(var_2)) {
      var_3 = get_tread_vfx(var_0, var_1, var_2);

      if(isDefined(var_3)) {
        play_new_tread_vfx(var_0, var_1, var_3);
      }
    }

    wait 0.1;
  }
}

function get_tread_vfx(var_0, var_1, var_2) {
  var_3 = var_0 gettagorigin(var_1);
  var_4 = scripts\engine\trace::ray_trace(var_3 + (0, 0, 20), var_3 + (0, 0, -50), var_0, undefined, 1);

  if(var_4["fraction"] == 1) {
    return undefined;
  }

  var_5 = spawnStruct();
  var_6 = filter_surface_type(var_4["surfacetype"], var_2, var_0);
  var_5.surface_speed_index = var_6 + "_" + var_2;
  var_5.contact_pos = var_4["position"];
  return var_5;
}

function filter_surface_type(var_0, var_1, var_2) {
  var_3 = var_0 + "_" + var_1;
  var_4 = var_2 scripts\common\vehicle_code::get_vehicle_classname();

  if(isDefined(level.vehicle.templates.surface_effects[var_4][var_3])) {
    return var_0;
  }

  return "default";
}

function should_play_tread_vfx(var_0) {
  if(var_0 == "stop") {
    return false;
  }

  return true;
}

function get_speed_type(var_0, var_1) {
  var_2 = var_0.slow_tread_vfx_trigger_speed;
  var_3 = var_0.fast_tread_vfx_trigger_speed;
  var_1 = var_0 vehicle_getspeed();

  if(var_1 < var_2) {
    return "stop";
  }

  if(var_1 >= var_2 && var_1 < var_3) {
    return "slow";
  }

  return "fast";
}

function play_new_tread_vfx(var_0, var_1, var_2) {
  var_3 = var_0 vehicle_getvelocity();
  var_4 = var_0 scripts\common\vehicle_code::get_vehicle_classname();
  var_5 = var_0 gettagorigin(var_1);
  playFX(level.vehicle.templates.surface_effects[var_4][var_2.surface_speed_index], var_2.contact_pos, var_3);
}

function tread_vfx_set_up(var_0) {
  var_1 = var_0 scripts\common\vehicle_code::get_vehicle_classname();
  return isDefined(level.vehicle.templates.surface_effects[var_1]);
}

function load_fx() {
  level._effect["IED_marker_to_non_overwatch"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_marker_reticle.vfx");
  level._effect["IED_explosion"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_explo_ied.vfx");
  level._effect["IED_radar_ping"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_drone_radar_ping.vfx");
  level._effect["IED_false_positive"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_marker_false_pos.vfx");
  level._effect["vehicle_tire_damage_smoke_left"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_runner.vfx");
  level._effect["vehicle_tire_damage_smoke_right"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_runner_right_side.vfx");
  level._effect["vehicle_hood_damage_smoke"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood.vfx");
  level._effect["reaper_clouds"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_clouds.vfx");
  level._effect["cruise_missile_pod_break"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion.vfx");
  level._effect["interceptor_hit_air_exp"] = loadfx("vfx/iw8/level/drone/vfx_drn_hellfire_explosion_air_01.vfx");
  level._effect["reaper_missile_marker"] = loadfx("vfx/iw8_cp/raid/vfx_reaper_missile_marker.vfx");
}

function init_vehicle_repair_anims() {
  level.scr_animtree["veh_repair_plyr"] = #animtree;
  level.scr_anim["veh_repair_plyr"]["tire_repair_start"] = % sdr_cp_tirefix_start;
  level.scr_animname["veh_repair_plyr"]["tire_repair_start"] = "sdr_cp_tirefix_start";
  level.scr_eventanim["veh_repair_plyr"]["tire_repair_start"] = "repair_in";
  scripts\common\anim::addnotetrack_customfunction("veh_repair_plyr", "sfx_scn_cp_repair_tire_enter_foley", &ref_13b9f);
  scripts\common\anim::addnotetrack_customfunction("veh_repair_plyr", "sfx_scn_cp_repair_tire_air_start", &ref_13b9d);
  level.scr_anim["veh_repair_plyr"]["tire_repair_loop"] = % sdr_cp_tirefix_loop;
  level.scr_animname["veh_repair_plyr"]["tire_repair_loop"] = "sdr_cp_tirefix_loop";
  level.scr_eventanim["veh_repair_plyr"]["tire_repair_loop"] = "repair_lp";
  level.scr_anim["veh_repair_plyr"]["tire_repair_stop"] = % sdr_cp_tirefix_end;
  level.scr_animname["veh_repair_plyr"]["tire_repair_stop"] = "sdr_cp_tirefix_end";
  level.scr_eventanim["veh_repair_plyr"]["tire_repair_stop"] = "repair_out";
  scripts\common\anim::addnotetrack_customfunction("veh_repair_plyr", "sfx_scn_cp_repair_tire_air_stop", &ref_13b9e);
  scripts\common\anim::addnotetrack_customfunction("veh_repair_plyr", "sfx_scn_cp_repair_tire_exit_foley", &ref_13ba0);
  level.scr_anim["veh_repair_plyr"]["repair_grill_start"] = % cp_scripted_fixdecho_enter;
  level.scr_animname["veh_repair_plyr"]["repair_grill_start"] = "cp_scripted_fixdecho_enter";
  level.scr_eventanim["veh_repair_plyr"]["repair_grill_start"] = "decho_repair_hood_enter";
  scripts\common\anim::addnotetrack_customfunction("veh_repair_plyr", "sfx_scn_cp_repair_engine_enter_foley", &ref_12c30);
  level.scr_anim["veh_repair_plyr"]["repair_grill_stop"] = % cp_scripted_fixdecho_exit;
  level.scr_animname["veh_repair_plyr"]["repair_grill_stop"] = "cp_scripted_fixdecho_exit";
  level.scr_eventanim["veh_repair_plyr"]["repair_grill_stop"] = "decho_repair_hood_exit";
  scripts\common\anim::addnotetrack_customfunction("veh_repair_plyr", "sfx_scn_cp_repair_engine_exit_foley", &ref_12c31);
  level.scr_anim["veh_repair_plyr"]["repair_grill"] = % cp_scripted_fixdecho_idle;
  level.scr_animname["veh_repair_plyr"]["repair_grill"] = "cp_scripted_fixdecho_idle";
  level.scr_eventanim["veh_repair_plyr"]["repair_grill"] = "decho_repair_hood_idle";
  scripts\common\anim::addnotetrack_customfunction("veh_repair_plyr", "sfx_scn_cp_repair_engine_fixing_long", &ref_12c2e);
  scripts\common\anim::addnotetrack_customfunction("veh_repair_plyr", "sfx_scn_cp_repair_engine_fixing_short", &ref_12c2f);
}

function ref_13b9f(var_0) {
  var_0 playsoundonmovingent("scn_cp_repair_tire_enter_foley");
}

function ref_13b9d(var_0) {
  var_0 playsoundonmovingent("scn_cp_repair_tire_air_start");
}

function ref_13b9e(var_0) {
  var_0 playsoundonmovingent("scn_cp_repair_tire_air_stop");
}

function ref_13ba0(var_0) {
  var_0 playsoundonmovingent("scn_cp_repair_tire_exit_foley");
}

function ref_12c30(var_0) {
  var_0 playsoundonmovingent("scn_cp_repair_engine_enter_foley");
}

function ref_12c31(var_0) {
  var_0 playsoundonmovingent("scn_cp_repair_engine_exit_foley");
}

function ref_12c2e(var_0) {
  var_0 playsoundonmovingent("scn_cp_repair_engine_fixing_long");
}

function ref_12c2f(var_0) {
  var_0 playsoundonmovingent("scn_cp_repair_engine_fixing_short");
}

function do_vehicle_repair_animation(var_0, var_1, var_2) {
  var_3 = var_1.origin;
  var_4 = var_1.angles;
  var_5 = get_tag_anim_offset(var_2, var_0);
  var_6 = getgroundposition(var_5.animorg, 2, 100, 24);
  var_7 = var_5.animang;
  var_8 = spawn("script_model", var_6);
  var_8.origin = var_6;
  var_8.angles = var_7;
  var_1 setOrigin(var_6, 1);
  var_1 setplayerangles(var_7);
  var_1 setstance("stand");
  var_1 disableweapons();
  var_1 forceusehinton(&"CP_VEHICLE_TRAVEL/REPAIR");
  spawn_can(var_1);
  thread do_vehicle_repair_animation_actual(var_1, var_0, var_1);
  var_9 = wait_for_repair_done(var_0, var_1, var_8);
  remove_can(var_1);
  waitframe();
  var_1 stoploopsound("scn_cp_repair_tire_air_lp");
  var_8 delete();
  scripts\cp\cp_destruction::remove_player_rig(var_1);
  var_1 forceusehintoff();
  var_1 setplayerangles(var_4);
  var_1 setstance("stand");
  var_1 cameradefault();
  var_1 enableweapons();
  var_1 setOrigin(var_3, 1);

  if(istrue(var_9)) {
    return true;
  }

  return false;
}

function do_vehicle_repair_animation_actual(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("repair_failed");
  var_3 = getanimlength(%sdr_cp_tirefix_start);
  var_4 = getanimlength(%sdr_cp_tirefix_loop);
  var_5 = getanimlength(%sdr_cp_tirefix_end);
  var_6 = var_3 - 0.1;
  var_7 = var_4 - 0.1;
  var_1 thread scripts\cp\cp_destruction::create_player_rig(var_1, "veh_repair_plyr");
  var_1 cameraset("camera_custom_orbit_2");
  var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "tire_repair_start");
  wait var_6;
  var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "tire_repair_loop");
  var_1 playLoopSound("scn_cp_repair_tire_air_lp");
  wait var_7 / 10;

  if(!scripts\cp\cp_laststand::player_in_laststand(var_1)) {
    var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "tire_repair_stop");
    wait 1;
    var_1.can hide();
    wait var_5 - 1;
    return;
  }
}

function do_hood_repair_animation_actual(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("repair_failed");
  var_3 = getanimlength(%cp_scripted_fixdecho_enter);
  var_4 = getanimlength(%cp_scripted_fixdecho_idle);
  var_5 = getanimlength(%cp_scripted_fixdecho_exit);
  var_6 = var_3;
  var_7 = var_4;
  var_1 thread scripts\cp\cp_destruction::create_player_rig(var_1, "veh_repair_plyr");
  var_1 cameraset("camera_custom_orbit_1");
  var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "repair_grill_start");
  wait var_6;
  var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "repair_grill");
  wait var_7;

  if(!scripts\cp\cp_laststand::player_in_laststand(var_1)) {
    var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "repair_grill_stop");
    wait var_5;
    return;
  }
}

function do_hood_repair_animation(var_0, var_1, var_2, var_3) {
  var_4 = var_1.origin;
  var_5 = var_1.angles;
  var_6 = get_tag_anim_offset(var_2, var_0);
  var_7 = var_0 gettagorigin("tag_origin_animate");
  var_8 = spawn("script_model", var_7);
  var_8.angles = var_0 gettagangles("tag_origin_animate");
  var_1 setstance("stand");
  var_1 disableweapons();
  var_1 forceusehinton(&"CP_VEHICLE_TRAVEL/REPAIR");
  thread do_hood_repair_animation_actual(var_1, var_0, var_1);
  var_9 = wait_for_hood_repair_done(var_0, var_1, var_8);
  var_8 delete();
  scripts\cp\cp_destruction::remove_player_rig(var_1);
  var_1 forceusehintoff();
  var_1 setplayerangles(var_5);
  var_1 setstance("stand");
  var_1 cameradefault();
  var_1 enableweapons();
  var_1 setOrigin(var_4, 0);
  return var_9;
}

function get_tag_anim_offset(var_0, var_1) {
  var_2 = var_1 gettagorigin(var_0);
  var_3 = var_1 gettagangles(var_0);
  var_4 = spawnStruct();
  var_4.origin = var_2;
  var_4.angles = var_3;
  var_4.animorg = var_2;
  var_4.animang = var_3;

  switch (var_0) {
    case "tag_wheel_center_back_left":
    case "tag_wheel_center_front_left":
      var_4.animang = var_3 + (0, 180, 0);
      return var_4;
    case "tag_wheel_center_back_right":
    case "tag_wheel_center_front_right":
      return var_4;
    case "tag_grill":
      var_4.animang = var_3 + (0, 180, 0);
      return var_4;
  }
}

function spawn_can(var_0) {
  var_1 = spawn("script_model", var_0 gettagorigin("tag_accessory_left"));
  var_1 setModel("automotive_fix_a_can_01");
  var_1.angles = var_0 gettagangles("tag_accessory_left");
  var_1 linkTo(var_0, "tag_accessory_left");
  var_0.can = var_1;
}

function remove_can(var_0) {
  if(isDefined(var_0.can)) {
    var_0.can delete();
    return;
  }
}

function wait_for_repair_done(var_0, var_1, var_2) {
  var_3 = getanimlength(%sdr_cp_tirefix_start);
  var_4 = getanimlength(%sdr_cp_tirefix_loop);
  var_5 = getanimlength(%sdr_cp_tirefix_end);
  var_6 = var_3 - 0.1;
  var_7 = var_4 / 10 - 0.25;
  var_8 = var_5 - 0.1;
  var_9 = var_6 + var_7 + var_8;
  var_10 = var_0 scripts\cp\utility::player_lua_progressbar(var_1, var_9 * 1000, undefined, 12);

  if(!istrue(var_10)) {
    var_1 notify("repair_failed");
  }

  var_1 stoploopsound("scn_cp_repair_tire_air_lp");
  return var_10;
}

function wait_for_hood_repair_done(var_0, var_1, var_2) {
  var_3 = getanimlength(%cp_scripted_fixdecho_enter);
  var_4 = getanimlength(%cp_scripted_fixdecho_idle);
  var_5 = getanimlength(%cp_scripted_fixdecho_exit);
  var_6 = var_3;
  var_7 = var_4;
  var_8 = var_5;
  var_9 = var_6 + var_7 + var_8;
  var_10 = var_0 scripts\cp\utility::player_lua_progressbar(var_1, var_9 * 1000, undefined, 12);

  if(!istrue(var_10)) {
    var_1 notify("repair_failed");
  }

  return var_10;
}

function do_hood_repair_anims(var_0, var_1, var_2) {
  var_1 endon("repair_failed");
  var_2 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "repair_grill");
}

function fire_cruise_missile_toward(var_0, var_1) {
  var_2 = make_cruise_missile_target_ent(var_0, var_1);
  var_3 = make_cruise_missile(var_0, var_2);
  put_objective_icon_on_cruise_missile(var_3, var_3);
  add_to_cruise_missile_list(var_3, var_3);
  thread keep_following_target_while_remain_height(var_2, var_2, var_1);
  thread cruise_missile_target_ent_clean_up(var_2, var_2);
  thread cruise_missile_reach_target_ent_monitor(var_3, var_3, var_2);
  thread death_monitor(var_3, var_3, var_3.cruise_missile_objective_id);
}

function cruise_missile_reach_target_ent_monitor(var_0, var_1, var_2) {
  var_2 endon("death");
  var_0 endon("death");

  for(;;) {
    if(distancesquared(var_0.origin, var_1.origin) < 250000) {
      break;
    }

    var_3 = anglesToForward(var_0.angles);
    var_4 = vectorNormalize(var_1.origin - var_0.origin);

    if(vectordot(var_3, var_4) < 0) {
      break;
    }

    waitframe();
  }

  thread fire_warhead_toward_target(level, var_0);
}

function fire_warhead_toward_target(var_0, var_1) {
  var_1 endon("death");
  var_0 setscriptablepartstate("wing_trails", "off");
  var_0 setscriptablepartstate("main_thruster", "off", 0);
  playFXOnTag(scripts\engine\utility::getfx("cruise_missile_pod_break"), var_0, "tag_missile");
  var_0 notify("stop_cruise_missile_death_monitor");
  var_2 = var_0.cruise_missile_objective_id;
  var_3 = var_0 getentitynumber();
  waitframe();
  var_4 = make_cruise_missile_warhead_target_ent(var_0);
  var_5 = make_cruise_missile_warhead(var_0, var_4);
  var_5.cruise_missile_objective_id = var_2;
  put_objective_icon_on_warhead(var_5, var_2);
  level.cruise_missiles = scripts\engine\utility::array_remove(level.cruise_missiles, var_0);

  if(isDefined(level.locked_on_cruise_missiles)) {
    level.locked_on_cruise_missiles = scripts\engine\utility::array_remove(level.locked_on_cruise_missiles, var_0);
    update_missile_lock_hud_for_missile_defense_player();
  }

  if(isDefined(var_0.interceptor_missile)) {
    set_interceptor_missile_target(var_0.interceptor_missile, var_5);
  }

  var_0 delete();
  thread delay_target_cruise_missile_target(var_5, var_5, var_4);
  thread death_monitor(var_5, var_5, var_2);
}

function update_missile_lock_hud_for_missile_defense_player() {
  var_0 = 0;

  foreach(var_2 in level.locked_on_cruise_missiles) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(istrue(var_2.being_intercepted)) {
      continue;
    }

    var_0++;
  }

  if(var_0 == 0) {
    var_4 = get_missile_defense_player();

    if(isDefined(var_4)) {
      var_4 setclientomnvar("ui_missile_lock", 0);
      return;
    }

    return;
  }
}

function get_missile_defense_player() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.current_vehicle_seat) && (var_1.current_vehicle_seat == "missile_defense_right" || var_1.current_vehicle_seat == "missile_defense_left")) {
      return var_1;
    }
  }

  return undefined;
}

function set_interceptor_missile_target(var_0, var_1) {
  var_0.target_anchor.origin = var_1.origin;
  var_0.target_anchor linkTo(var_1);
  var_0.target_entity = var_1;
}

function put_objective_icon_on_warhead(var_0, var_1) {
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 0);
}

function delay_target_cruise_missile_target(var_0, var_1, var_2) {
  var_0 endon("death");
  wait 0.25;

  if(isDefined(var_2)) {
    var_0 missile_settargetEnt(var_2);
  }

  var_1 delete();
}

function add_to_cruise_missile_list(var_0) {
  if(!isDefined(level.cruise_missiles)) {
    level.cruise_missiles = [];
  }

  level.cruise_missiles[level.cruise_missiles.size] = var_0;
}

function death_monitor(var_0, var_1, var_2) {
  var_0 endon("stop_cruise_missile_death_monitor");
  var_0 waittill("death");
  level.cruise_missiles = scripts\engine\utility::array_remove(level.cruise_missiles, var_0);

  if(isDefined(level.locked_on_cruise_missiles)) {
    level.locked_on_cruise_missiles = scripts\engine\utility::array_remove(level.locked_on_cruise_missiles, var_0);
    update_missile_lock_hud_for_missile_defense_player();
  }

  scripts\cp\cp_objectives::freeworldid("cruise_missile_entity_number_" + var_2);
  objective_delete(var_1);
}

function put_objective_icon_on_cruise_missile(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("cruise_missile_entity_number_" + var_0 getentitynumber(), 22);
  objective_state(var_1, "invisible");
  objective_icon(var_1, "hud_callsign_bg_rd");
  objective_onentity(var_1, var_0);
  objective_setzoffset(var_1, 0);
  objective_removeallfrommask(var_1);
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 1);
  objective_setshowdistance(var_1, 1);
  objective_setshowprogress(var_1, 1);
  objective_setfadedisabled(var_1, 1);
  var_0.cruise_missile_objective_id = var_1;
  make_visible_to_missile_defense_player(var_1);
}

function make_visible_to_missile_defense_player(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2.current_vehicle_seat) && (var_2.current_vehicle_seat == "missile_defense_right" || var_2.current_vehicle_seat == "missile_defense_left")) {
      objective_addclienttomask(var_0, var_2);
    }
  }
}

function cruise_missile_target_ent_clean_up(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

function keep_following_target_while_remain_height(var_0, var_1, var_2) {
  var_1 endon("death");
  var_2 endon("death");
  var_3 = var_0.origin[2];

  for(;;) {
    var_4 = var_2.origin - var_1.origin;
    var_4 *= (1, 1, 0);
    var_4 = vectorNormalize(var_4);
    var_5 = var_1.origin + var_4 * 7500;
    var_5 = (var_5[0], var_5[1], var_3);
    var_0.origin = var_5;
    waitframe();
  }
}

function make_cruise_missile(var_0, var_1) {
  var_2 = magicbullet("cruise_missile_cp", var_0, var_1.origin);
  var_2 missile_settargetEnt(var_1);
  var_2 missile_setflightmodedirect();
  var_2 setscriptablepartstate("main_thruster", "on", 0);
  var_2 setscriptablepartstate("wing_trails", "on");
  var_2.lock_on_progress = 0;
  return var_2;
}

function make_cruise_missile_warhead(var_0, var_1) {
  var_2 = magicbullet("cruise_missile_warhead_cp", var_0 gettagorigin("tag_missile"), var_1.origin);
  var_2 missile_settargetEnt(var_1);
  var_2 missile_setflightmodedirect();
  var_2 setscriptablepartstate("sub_thruster", "on", 0);
  var_2.lock_on_progress = 0;
  level.cruise_missiles = scripts\engine\utility::array_add(level.cruise_missiles, var_2);

  if(isDefined(level.locked_on_cruise_missiles) && scripts\engine\utility::array_contains(level.locked_on_cruise_missiles, var_0)) {
    level.locked_on_cruise_missiles = scripts\engine\utility::array_add(level.locked_on_cruise_missiles, var_2);
  }

  return var_2;
}

function make_cruise_missile_target_ent(var_0, var_1) {
  var_2 = var_0[2];
  var_3 = var_1.origin - var_0;
  var_3 *= (1, 1, 0);
  var_3 = vectorNormalize(var_3);
  var_4 = var_1.origin + var_3 * 7500;
  var_4 = (var_4[0], var_4[1], var_2);
  var_5 = spawn("script_model", var_4);
  var_5 setModel("tag_origin");
  return var_5;
}

function make_cruise_missile_warhead_target_ent(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_2 = var_0.origin + var_1 * 10000;
  var_3 = spawn("script_model", var_2);
  var_3 setModel("tag_origin");
  return var_3;
}

function make_reaper_drone(var_0) {
  var_1 = anglestoright(var_0.angles);
  var_2 = var_0.origin + var_1 * 10000 + (0, 0, 10000);
  var_3 = spawn("script_model", var_2);
  var_3 setModel("veh8_mil_air_mquebec9");
  var_3.angles = var_0.angles;
  thread clean_up_on_vehicle_death(var_3, var_3);
  thread keep_circling_around_vehicle(var_3, var_0);
  var_3.missile_defense_camera_anchor = create_missile_defense_camera_anchor(var_0, var_3);
  var_3.scanning_camera_anchor = create_scanning_camera_anchor(var_0, var_3);
  var_0.reaper = var_3;
  return var_3;
}

function keep_circling_around_vehicle(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("tag_player");
  var_1 linkTo(var_2, "tag_player");
  thread keep_rotating(var_2);
  thread keep_following_vehicle(var_2, var_2);
  thread clean_up_on_vehicle_death(var_2, var_2);
}

function keep_rotating(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 rotateYaw(360, 180);
    wait 180;
  }
}

function keep_following_vehicle(var_0, var_1) {
  var_0 endon("death");
  wait 2;

  for(;;) {
    var_2 = (var_1.origin[0], var_1.origin[1], var_0.origin[2]);
    var_3 = distance2d(var_0.origin, var_2);
    var_4 = var_3 / get_rotation_anchor_move_speed(var_3);

    if(var_3 <= 10) {
      waitframe();
      continue;
    }

    if(var_3 <= 100) {
      var_0 moveTo(var_2, var_4, 0, var_4);
      waitframe();
      continue;
    }

    var_0 moveTo(var_2, var_4);
    var_0 scripts\engine\utility::ref_143b9(var_4, "movedone");
  }
}

function get_rotation_anchor_move_speed(var_0) {
  if(var_0 <= 150) {
    return 500;
  }

  return 1000;
}

function create_missile_defense_camera_anchor(var_0, var_1) {
  var_2 = anglesToForward(var_1.angles);
  var_3 = spawn("script_model", var_1.origin + var_2 * 170 + (0, 0, -140));
  var_3 setModel("tag_player");
  var_3.angles = vectortoangles((0, 0, -1));
  var_3 linkTo(var_1);
  thread clean_up_on_vehicle_death(var_3, var_3);
  return var_3;
}

function create_scanning_camera_anchor(var_0, var_1) {
  var_2 = anglesToForward(var_1.angles);
  var_3 = spawn("script_model", var_1.origin + var_2 * 0 + (0, 0, -140));
  var_3 setModel("tag_player");
  var_3.angles = vectortoangles(var_0.origin - var_3.origin);
  var_3 linkTo(var_1);
  thread clean_up_on_vehicle_death(var_3, var_3);
  thread keep_focus_on_vehicle(var_3, var_3);
  return var_3;
}

function keep_focus_on_vehicle(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");

  for(;;) {
    var_0.angles = vectortoangles(var_1.origin - var_0.origin);
    waitframe();
  }
}

function get_humvee_info(var_0) {
  var_1 = spawnStruct();
  var_1.model = "veh8_civ_lnd_decho_rebel_2";
  var_1.vehicle_gdt = "decho_physics_cp";
  var_1.add_additional_parts_func = &humvee_add_additional_parts_func;
  var_1.ied_triggering_tags = ["tag_wheel_back_left", "tag_wheel_front_left", "tag_wheel_back_right", "tag_wheel_front_right"];
  var_1.fake_health = 750;
  var_1.show_damage_state_health_ratio = 0.3;
  var_1.classname_mp = "cp_decho_rebel";
  var_1.slow_tread_vfx_trigger_speed = 1;
  var_1.fast_tread_vfx_trigger_speed = 20;
  var_1.tread_vfx_tags = ["tag_wheel_back_right", "tag_wheel_back_left", "tag_wheel_front_right", "tag_wheel_front_left"];
  var_1.ref_128c0 = ["iw8_me_riotshield_mp"];
  var_2 = [];
  GscBinSkip0(0x2e, "tag_wheel_back_left", "tag_wheel_center_back_left");
}

function humvee_add_additional_parts_func(var_0) {
  add_gunner_turret(var_0);
}

function add_gunner_turret(var_0) {
  var_1 = spawnturret("misc_turret", var_0 gettagorigin("tag_turret"), "tur_gun_decho_cp", 0);
  var_1.angles = var_0.angles;
  var_1.team = "allies";
  var_1 linkTo(var_0);
  var_1 setModel("veh8_civ_lnd_decho_rebel_mg_no_hatch");
  var_1 setmode("sentry_offline");
  var_1 setsentryowner(undefined);
  var_1 makeunusable();
  var_1 setdefaultdroppitch(0);
  var_1 setturretmodechangewait(1);
  var_0.gunner_turret = var_1;
  var_0.gunner_weapon = "tur_gun_decho_cp";
  thread clean_up_on_vehicle_death(var_1, var_1);
}

function get_friendly_hvi_vehicle_info(var_0) {
  var_1 = spawnStruct();
  var_1.model = "veh8_civ_lnd_decho_rebel_2";
  var_1.vehicle_gdt = "decho_physics_cp";
  var_1.add_additional_parts_func = &friendly_hvi_vehicle_add_additional_parts_func;
  var_1.ied_triggering_tags = ["tag_wheel_back_left", "tag_wheel_front_left", "tag_wheel_back_right", "tag_wheel_front_right"];
  var_1.fake_health = 5000;
  var_1.show_damage_state_health_ratio = 0.3;
  var_1.classname_mp = "cp_decho_rebel";
  var_1.slow_tread_vfx_trigger_speed = 1;
  var_1.fast_tread_vfx_trigger_speed = 20;
  var_1.tread_vfx_tags = ["tag_wheel_back_right", "tag_wheel_back_left", "tag_wheel_front_right", "tag_wheel_front_left"];
  var_1.ref_128c0 = ["iw8_me_riotshield_mp"];
  var_2 = [];
  GscBinSkip0(0x2e, "tag_wheel_back_left", "tag_wheel_center_back_left");
}

function friendly_hvi_vehicle_add_additional_parts_func(var_0) {
  add_gunner_turret(var_0);
}

function add_grenadier_anchor(var_0) {
  var_1 = -15;
  var_2 = 0;
  var_3 = 50;
  var_4 = var_0.angles;
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = anglestoup(var_4);
  var_8 = var_0 gettagorigin("tag_origin");
  var_9 = var_8 + var_5 * var_1 + var_6 * var_2 + var_7 * var_3;
  var_10 = spawn("script_model", var_9);
  var_10 setModel("tag_origin");
  var_10 linkTo(var_0);
  thread clean_up_on_vehicle_death(var_10, var_10);
  var_0.grenadier_anchor = var_10;
  var_0.grenadier_weapon = "iw8_la_mike32_mp";
}

function remove_from_overwatch_target_group(var_0) {
  if(isDefined(var_0.target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_0, var_0 getentitynumber(), var_0.target_marker_group_id);
    return;
  }
}

function debug_setup_warp_jeep_to_players() {}

function debug_warp_jeep_to_player(var_0) {
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("warpjeeptome");

    if(self vehicle_isphysveh()) {
      var_1 = getclosestpointonnavmesh(var_0.origin);
      var_1 += (0, 0, 50);
      var_2 = (0, self.angles[1], 0);
      self vehicle_teleport(var_1, var_2);
    }

    wait 0.05;
  }
}

function ref_14222(var_0) {
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_1);
    update_driver_interaction_hint(var_0);
  }
}

function ref_14223(var_0) {
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("player_disconnect");
    update_driver_interaction_hint(var_0);
  }
}