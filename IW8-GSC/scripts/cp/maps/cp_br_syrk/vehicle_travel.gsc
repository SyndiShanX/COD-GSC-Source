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

function deploy_vehicle(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var2 = spawnVehicle(var1.model, "armoredtruck", var1.vehicle_gdt, var0.origin, var0.angles);
  var2 makeentitysentient("allies", 0);
  process_linked_ents(var2, var0);
  init_vehicle(var2, var1);
  var2.infected_music = "armoredtruck";
  set_up_fake_character_models(var2);
  set_up_vehicle_interactions(var2, var1);
  set_up_ied_triggering_tags(var2, var1);
  add_additional_parts(var2, var1);
  add_to_vehicle_travel_array(var2);
  make_reaper_drone(var2);
  thread vehicle_damage_monitor(var2, var2);
  thread tread_vfx_think(var2);
  thread debug_setup_warp_jeep_to_players();
  thread ref_14222(var2);
  thread ref_14223(var2);
  level.player_humvee = var2;
  level notify("spawned_player_car");
  var2.nav_obstacle = createnavrepulsor("ply_vehicle", 0, var2, 128, 1);
}

function deploy_friendly_hvi_vehicle(var0, var1) {
  var2 = spawnVehicle(var1.model, "friendlyhvi", var1.vehicle_gdt, var0.origin, var0.angles);
  process_linked_ents(var2, var0);
  init_vehicle(var2, var1);
  set_up_fake_character_models(var2);
  set_up_vehicle_interactions(var2, var1);
  set_up_ied_triggering_tags(var2, var1);
  add_additional_parts(var2, var1);
  thread tread_vfx_think(var2);
  disable_vehicle_interaction(var2, "driver");
  disable_vehicle_interaction(var2, "passenger");
  disable_vehicle_interaction(var2, "right_back_seat");
  return var2;
}

function process_linked_ents(var0, var1) {
  var2 = getEntArray(var1.target, "targetname");

  foreach(var4 in var2) {
    switch (var4.script_noteworthy) {
      case "no_sight_clip":
        var4 linkTo(var0);
        thread vehicle_linked_ent_clean_up_think(var4, var0);
        break;
      case "under_vehicle_trigger":
        var4 enablelinkTo();
        var4 linkTo(var0);
        thread vehicle_linked_ent_clean_up_think(var4, var0);
        var0.under_vehicle_trigger = var4;
        break;
      default:
        break;
    }
  }
}

function vehicle_linked_ent_clean_up_think(var0, var1) {
  var1 endon("death");
  var0 waittill("death");
  var1 delete();
}

function teleport_humvee_to_struct(var0) {
  if(isDefined(level.player_humvee)) {
    if(level.player_humvee vehicle_isphysveh()) {
      var1 = getclosestpointonnavmesh(var0.origin);
      var2 = (0, var0.angles[1], 0);
      level.player_humvee vehicle_teleport(var1, var2);
      return;
    }

    return;
  }
}

function enter_change_loadout(var0, var1, var2) {
  var1 notify("enter_change_loadout");
  var1 setclientomnvar("ui_options_menu", 2);
  waitframe();

  for(;;) {
    var1 waittill("luinotifyserver", var3, var4);

    if(var3 == "class_select" || var3 == "class_edit" || var3 == "class_menu_closed") {
      enable_vehicle_interaction(var2, "change_loadout");
      break;
    }
  }

  var0 notify("interaction_point_disabled");
}

function exit_change_loadout(var0, var1, var2, var3) {
  var1 notify("exit_change_loadout");
}

function enter_refill_ammo(var0, var1, var2) {
  var1 thread scripts\cp\cp_ammo_crate::supportbox_onusedeployable();
  waitframe();
  var0 notify("interaction_point_disabled");
  waitframe();
  var0 makeusable();
  var0.being_used = 0;
}

function try_start_driving(var0, var1) {
  update_driver_interaction_hint(var0);

  if(istrue(var0.disabled)) {
    level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/REPAIR_VEHICLE");
    return 0;
  }

  if(isDefined(level.ref_13e02)) {
    return [[level.ref_13e02]]();
  }

  return 1;
}

function start_driver_role(var0, var1, var2) {
  level notify("player_entered_driver_seat");
  var1.disable_map_tablet = 1;
  enter_vehicle(var1, var2);
  var1.current_vehicle_seat = "driver";
  var1.start_anim_train_scene = 1;
  enter_seat_omnvar(var1, var1, "driver");
  var1 setclientomnvar("ui_veh_controls", 1);
  var1 scripts\common\utility::allow_weapon(0);
  var1 setplayerangles(var2.angles);
  var1 controlslinkTo(var2);
  var1 scripts\common\utility::allow_usability(0);
  var2 setotherent(var1);
  var2 setentityowner(var1);
  play_seat_animation(var1, var2, "driver");
}

function exit_driver_role(var0, var1, var2, var3) {
  var2 setotherent(undefined);
  var2 setentityowner(undefined);
  var1.start_anim_train_scene = undefined;
  technical_stopanimatingplayer(var1);
  var1 scripts\common\utility::allow_weapon(1);
  var1 controlsunlink();
  var1 unlink();
  exit_vehicle(var1, var1, var2, "driver");
  exit_seat_omnvar(var1, var1, "driver", var2);
  var1 setclientomnvar("ui_veh_controls", 0);
  var1.disable_map_tablet = undefined;
  var1 scripts\common\utility::allow_usability(1);
}

function enter_repair(var0, var1, var2) {
  var3 = do_vehicle_repair_animation(var2, var1, var0.repair_tag);

  if(!var3) {
    var0 makeusable();
    var0.being_used = 0;
    return;
  }

  waitframe();
  var0 notify("interaction_point_disabled");
  remove_from_vehicle_repair_interaction_list(var2, var0, var0.repair_tag);
}

function exit_repair(var0, var1, var2, var3) {
  if(all_repairs_are_done(var2)) {
    var2.disabled = 0;
    set_repair_omnvars("hood_repair", 0);
    update_driver_interaction_hint(var2);
    level notify("vehicle_repaired");
    return;
  }
}

function enter_retrieve_hostage(var0, var1, var2) {
  waitframe();

  if(!isDefined(var1.hostagecarried) && !has_hostage_on_board(var2)) {
    return;
  }

  var0 notify("interaction_point_disabled");
}

function exit_retrieve_hostage(var0, var1, var2, var3) {
  if(isPlayer(var1) && !isDefined(var1.hostagecarried) && !has_hostage_on_board(var2)) {
    return;
  }

  if(!has_hostage_on_board(var2)) {
    return;
  }

  var4 = var2.hostage;
  var4 unlink();
  var2.hostage = undefined;

  if(isPlayer(var1)) {
    var4 notify("trigger", var1);
  } else {
    var4.origin = var1.origin;
    disable_vehicle_interaction(var2, "retrieve_hostage");
    var4.carried_by_vehicle = 0;
  }

  var4 notify("trigger", var1);
}

function enter_hood_repair(var0, var1, var2) {
  thread ref_1421e(var2);
  var3 = do_hood_repair_animation(var2, var1, "tag_grill", var0);
  var2 notify("hood_repair_finished");

  if(!var3) {
    var0 makeusable();
    var0.being_used = 0;
    return;
  }

  waitframe();
  var0 notify("interaction_point_disabled");
  remove_from_vehicle_repair_interaction_list(var2, var0);
}

function ref_1421e(var0) {
  var0 endon("death");
  var0 endon("hood_repair_finished");
  var1 = var0.origin;
  var2 = var0.angles;

  for(;;) {
    var0 vehicle_teleport(var1, var2);
    waitframe();
  }
}

function exit_hood_repair(var0, var1, var2, var3) {
  if(all_repairs_are_done(var2)) {
    var2.disabled = 0;
    var2.fake_health = var2.max_fake_health;
    var2.showing_damage_state = 0;
    var2.disabled_due_to_damage = 0;
    set_repair_omnvars("hood_repair", 0);
    update_driver_interaction_hint(var2);
    level notify("vehicle_repaired");
    return;
  }
}

function enter_passenger_seat(var0, var1, var2) {
  enter_vehicle(var1, var2);
  enter_seat(var1, var2, "passenger");
}

function exit_passenger_seat(var0, var1, var2, var3) {
  exit_seat(var1, 1);
  try_exit_vehicle(var1, var2, "passenger");
}

function enter_left_back_seat(var0, var1, var2) {
  enter_vehicle(var1, var2);
  enter_seat(var1, var2, "left_back_seat");
}

function exit_left_back_seat(var0, var1, var2, var3) {
  exit_seat(var1, 1);
  try_exit_vehicle(var1, var2, "left_back_seat");
}

function enter_right_back_seat(var0, var1, var2) {
  enter_vehicle(var1, var2);
  enter_seat(var1, var2, "right_back_seat");
}

function exit_right_back_seat(var0, var1, var2, var3) {
  exit_seat(var1, 1);
  try_exit_vehicle(var1, var2, "right_back_seat");
}

function enter_gunner_seat(var0, var1, var2) {
  level notify("player_used_vehicle_gunner_turret");
  var1 unlink();
  var1 setworldupreference(undefined);
  var1.disable_map_tablet = 1;
  scripts\cp\coop_super::little_bird_mg_init(var1);
  exit_seat_but_stay_in_vehicle(var1, var2);
  record_seat(var1, "gunner");
  enter_seat_omnvar(var1, var1, "gunner");
  var1 setplayerangles(var2.gunner_turret.angles);
  thread give_gunner_turret(var1, var0, var1);
  var1 setclientomnvar("ui_veh_vehicle", 10);
}

function give_gunner_turret(var0, var1, var2) {
  var1 endon("disconnect");
  var1 endon("exit_gunner_seat");
  var1.pre_gunner_weapon = var1 getcurrentweapon();
  var1 scripts\cp\utility::_giveweapon(var2.gunner_weapon, undefined, undefined, 1);

  while(var1 scripts\cp\cp_weapons::switchtoweaponreliable(var2.gunner_weapon, 1) == 0) {
    waitframe();
  }

  var2.gunner_turret setotherent(var1);
  var2.gunner_turret setentityowner(var1);
  var2.gunner_turret setsentryowner(var1);
  var2.gunner_turret.owner = var1;
  var1 disableturretdismount();
  var1 controlturreton(var2.gunner_turret);
}

function exit_gunner_seat(var0, var1, var2, var3) {
  var1 notify("exit_gunner_seat");
  var1 takeweapon(var2.gunner_weapon);
  var1 switchtoweapon(var1.pre_gunner_weapon);
  var1 enableturretdismount();
  var1 controlturretoff(var2.gunner_turret);
  var1 unlink();
  var2.gunner_turret setotherent(undefined);
  var2.gunner_turret setentityowner(undefined);
  var2.gunner_turret setsentryowner(undefined);
  enable_vehicle_interaction(var2, "gunner");
  var1.disable_map_tablet = undefined;
  scripts\cp\coop_super::mousetraps(var1);

  if(var3 == "last_stand" || var3 == "force_player_exit_vehicle") {
    exit_seat(var1, 1);
    exit_vehicle(var1, var2, var1.previous_vehicle_seat);
    exit_seat_omnvar(var1, var1, "gunner", var2);
    return;
  }

  return_to_previous_seat(var1, var2);
  exit_seat_omnvar(var1, var1, "gunner", var2);
}

function enter_grenadier_seat(var0, var1, var2) {
  var1 unlink();
  var1 setworldupreference(undefined);
  var1.disable_map_tablet = 1;
  exit_seat_but_stay_in_vehicle(var1, var2);
  waitframe();
  record_seat(var1, "grenadier");
  enter_seat_omnvar(var1, var1, "grenadier");
  var1 setplayerangles(var2.angles);
  var1 playerlinktodelta(var2.grenadier_anchor, "tag_origin", 0, 180, 180, 180, 25);
  thread give_grenadier_launcher(var1, var0, var1);
  var1 setclientomnvar("ui_veh_vehicle", 10);
}

function give_grenadier_launcher(var0, var1, var2) {
  var1 endon("disconnect");
  var1 endon("exit_grenadier_seat");
  var1.pre_gunner_weapon = var1 getcurrentweapon();
  var1 scripts\cp\utility::_giveweapon(var2.grenadier_weapon, undefined, undefined, 1);

  while(var1 scripts\cp\cp_weapons::switchtoweaponreliable(var2.grenadier_weapon, 1) == 0) {
    waitframe();
  }
}

function exit_grenadier_seat(var0, var1, var2, var3) {
  var1 notify("exit_grenadier_seat");
  var1 takeweapon(var2.grenadier_weapon);
  var1 switchtoweapon(var1.pre_gunner_weapon);
  var1 unlink();
  enable_vehicle_interaction(var2, "grenadier");
  var1.disable_map_tablet = undefined;

  if(var3 == "last_stand" || var3 == "force_player_exit_vehicle") {
    exit_seat(var1, 1);
    exit_vehicle(var1, var2, var1.previous_vehicle_seat);
    exit_seat_omnvar(var1, var1, "grenadier", var2);
    return;
  }

  return_to_previous_seat(var1, var2);
  exit_seat_omnvar(var1, var1, "grenadier", var2);
}

function ref_11d06(var0, var1, var2) {
  var1 endon("death_or_disconnect");
  var1 endon("last_stand_start");
  var1 notify("monitor_exit_initiated");
  var1 endon("monitor_exit_initiated");
  var3 = gettime() + 1000;
  var4 = 0;
  var1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
  var5 = level.framedurationseconds;
  waitframe();

  for(;;) {
    var6 = 0;
    var1 setclientomnvar("ui_veh_exit_button_holdtime", 0);

    while(var1 stancebuttonPressed()) {
      var6 += var5;

      if(var1 usinggamepad()) {
        var1 setclientomnvar("ui_veh_exit_button_holdtime", var6 / 0.3);
      }

      if(var1 usinggamepad() && var6 > 0.3 || istrue(var2) || !var1 usinggamepad()) {
        var1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
        return 1;
      }

      wait var5;
    }

    waitframe();
  }
}

function ref_11d05(var0, var1, var2) {
  var1 endon("death_or_disconnect");
  var1 endon("last_stand_start");
  var1 notify("monitor_exit_initiated");
  var1 endon("monitor_exit_initiated");
  var3 = gettime() + 1000;
  var4 = 0;
  var1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
  var5 = level.framedurationseconds;
  waitframe();

  for(;;) {
    var6 = 0;
    var1 setclientomnvar("ui_veh_exit_button_holdtime", 0);

    while(var1 useButtonPressed()) {
      var6 += var5;

      if(var1 usinggamepad()) {
        var1 setclientomnvar("ui_veh_exit_button_holdtime", var6 / 0.3);
      }

      if(var1 usinggamepad() && var6 > 0.3 || istrue(var2) || !var1 usinggamepad()) {
        var1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
        return 1;
      }

      wait var5;
    }

    waitframe();
  }
}

function enter_mine_drone_right(var0, var1, var2) {
  var0 = get_vehicle_interaction_point(var2, "mine_drone_left");
  var0 makeunusable();
  var0.being_used = 1;
  enter_mine_drone(var0, var1, var2, "mine_drone_right");
}

function enter_mine_drone_left(var0, var1, var2) {
  var0 = get_vehicle_interaction_point(var2, "mine_drone_right");
  var0 makeunusable();
  var0.being_used = 1;
  enter_mine_drone(var0, var1, var2, "mine_drone_left");
}

function enter_mine_drone(var0, var1, var2, var3) {
  level notify("player_used_vehicle_mine_drone");
  var1 notify("enter_mine_drone");
  var1.outofrangefunc = &mine_drone_out_of_range;
  var1.disable_map_tablet = 1;
  var1 setplayerangles(var2.angles);
  show_fake_player(var1, var1, var2);
  exit_seat_but_stay_on_seat(var1);
  record_seat(var1, var3);
  var1 scripts\common\utility::allow_weapon(0);
  remove_from_players_cannot_see_vehicle_icon_list(var1, var2, var1);
  update_vehicle_objective_visibility(var1, var2);
  var1 animscriptexitvehicle();
  thread unlink_and_travel_with_vehicle(var1, var1);
  var1 thread scripts\cp\drone\scout_drone::deploy_scout_detonate_drone(var1);
  var1.drone scripts\cp_mp\outofrange::setupoutofrangewatcher(var1.drone, undefined, var2, "tag_origin", 2560000, 5760000);
  thread drone_killed_due_to_out_of_range_monitor(var1.drone, var1.drone);
}

function show_fake_player(var0, var1) {
  if(var0.current_vehicle_seat == "right_back_seat") {
    var1.fake_back_right_passenger show();
    return;
  }

  if(var0.current_vehicle_seat == "left_back_seat") {
    var1.fake_back_left_passenger show();
    return;
  }
}

function mine_drone_out_of_range(var0) {
  var1 = 10;

  if(!isDefined(var0.next_mine_drone_out_of_range_vo_time)) {
    var0.next_mine_drone_out_of_range_vo_time = 0;
  }

  var2 = gettime();

  if(var2 > var0.next_mine_drone_out_of_range_vo_time) {
    var0.next_mine_drone_out_of_range_vo_time = var2 + var1 * 1000;
    var0 thread scripts\cp\cp_vo::try_to_play_vo("dx_cps_ovl_vehicle_out_of_range_10", "cp_comment_vo", "highest", 10, 0, 0, 1, 100);
    return;
  }
}

function unlink_and_travel_with_vehicle(var0, var1) {
  var0 endon("exit_mine_drone");
  var0 endon("exiting_drone");
  var0 waittill("drone_exists");
  var0 unlink();
  var0 playerhide();
  var2 = var0.origin;
  var3 = var0.origin;

  for(;;) {
    var2 = get_player_seat_org(var0, var1);

    if(var2 != var3) {
      var0 setOrigin(var2);
      var3 = var2;
    }

    waitframe();
  }
}

function get_player_seat_org(var0, var1) {
  switch (var0.current_vehicle_seat) {
    case "mine_drone_left":
      return var1 gettagorigin("tag_seat_2");
    case "mine_drone_right":
      return var1 gettagorigin("tag_seat_3");
  }
}

function drone_killed_due_to_out_of_range_monitor(var0, var1) {
  var0 waittill("death");
  var1 notify("exit_mine_drone_right");
  var1 notify("exit_mine_drone_left");
}

function exit_mine_drone(var0, var1, var2, var3) {
  var1 notify("exit_mine_drone");

  if(isDefined(var1.drone)) {
    var1.drone dodamage(var1.drone.fake_health + 100, var1.drone.origin);
  }

  var1.outofrangefunc = undefined;
  level notify("vision_set_change_request", undefined, var1, 0.05, "static");
  var1 setclientomnvar("ui_out_of_bounds_countdown", 0);
  var1 scripts\common\utility::allow_weapon(1);
  enable_vehicle_interaction(var2, "mine_drone_right");
  enable_vehicle_interaction(var2, "mine_drone_left");
  add_to_players_cannot_see_vehicle_icon_list(var1, var2, var1);
  update_vehicle_objective_visibility(var1, var2);
  var2.fake_back_right_passenger hide();
  var2.fake_back_left_passenger hide();
  var1 playershow();
  var1.disable_map_tablet = undefined;

  if(var3 == "last_stand") {
    var1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var1, 1);
    exit_vehicle(var1, var2, var1.previous_vehicle_seat);
    return;
  }

  var1 animscriptentervehicle();
  return_to_previous_seat(var1, var2);
}

function enter_missile_defense_right(var0, var1, var2) {
  var0 = get_vehicle_interaction_point(var2, "missile_defense_left");
  var0 makeunusable();
  var0.being_used = 1;
  enter_missile_defense(var0, var1, var2, "missile_defense_right");
}

function enter_missile_defense_left(var0, var1, var2) {
  var0 = get_vehicle_interaction_point(var2, "missile_defense_right");
  var0 makeunusable();
  var0.being_used = 1;
  enter_missile_defense(var0, var1, var2, "missile_defense_left");
}

function enter_missile_defense(var0, var1, var2, var3) {
  var1 notify("enter_missile_defense");
  var1.disable_map_tablet = 1;
  var1.target_circle_fov = 35;
  var1.target_circle_radius = 20;
  exit_seat_but_stay_on_seat(var1);
  record_seat(var1, var3);
  var1 setclientomnvar("ui_veh_vehicle", -1);
  var1 setclientomnvar("ui_overwatch_view", 2);
  var1 setclientomnvar("ui_missile_lock", 0);
  enter_missile_defense_view(var1, var1, var2);
  mark_vehicle_as_friendly_target_group(var1, var1, var2);
  give_missile_defense_weapons(var1, var1);
  see_icon_on_cruise_missiles(var1, var1);
  see_icon_on_interceptor_missiles(var1, var1);
  thread enter_missile_defense_control(var1, var1);
  thread enter_missile_defense_vision_set(var1);
}

function enter_missile_defense_control(var0, var1) {
  var0 endon("disconnect");
  var0 endon("exit_missile_defense");
  thread missile_defense_lock_on_cruise_missile_think(var0, var0);
  thread missile_defense_fire_interceptor_missiles(var0, var0);
  thread missile_defense_camera_focus_think(var0, var0);
}

function missile_defense_camera_focus_think(var0, var1) {
  var0 endon("disconnect");
  var0 endon("exit_missile_defense");
  var1 endon("death ");
  var0 notifyonplayercommand("reset_missile_defense_camera", "+weapnext");

  for(;;) {
    var0 waittill("reset_missile_defense_camera");
    var0 setplayerangles(vectortoangles(var1.origin - var1.reaper.missile_defense_camera_anchor.origin));
  }
}

function missile_defense_fire_interceptor_missiles(var0, var1) {
  var0 endon("disconnect");
  var0 endon("exit_missile_defense");
  var1 endon("death ");
  var0 notifyonplayercommand("fire_interceptor_missile", "+attack");

  for(;;) {
    var0 waittill("fire_interceptor_missile");
    var2 = get_locked_on_cruise_missile_to_intercept();

    if(isDefined(var2)) {
      fire_interceptor_missile_toward(var2, var0, var1);
    }
  }
}

function get_locked_on_cruise_missile_to_intercept() {
  if(!isDefined(level.locked_on_cruise_missiles)) {
    return undefined;
  }

  var0 = [];

  foreach(var2 in level.locked_on_cruise_missiles) {
    if(!isDefined(var2)) {
      continue;
    }

    if(istrue(var2.being_intercepted)) {
      continue;
    }

    var0 = var2;
  }

  return sortbydistance(var0, level.player_humvee.origin)[0];
}

function fire_interceptor_missile_toward(var0, var1, var2) {
  var3 = 3;
  var0.being_intercepted = 1;
  var4 = anglestoleft(var1 getplayerangles());
  var5 = var2.reaper.missile_defense_camera_anchor.origin + var4 * var3;
  var6 = magicbullet("interceptor_missile_cp", var5, var0.origin);
  var6.target_anchor = make_interceptor_missile_target_anchor(var6);
  var6 missile_settargetEnt(var6.target_anchor);
  var6 missile_setflightmodedirect();
  var6 setscriptablepartstate("thruster", "on", 0);
  set_interceptor_missile_target(var6, var0);
  thread hit_target_entity_monitor(var6);
  thread get_away_from_target_entity_monitor(var6);

  if(!isDefined(level.interceptor_missiles)) {
    level.interceptor_missiles = [];
  }

  level.interceptor_missiles[level.interceptor_missiles.size] = var6;
  var0.interceptor_missile = var6;
  put_objective_icon_on_interceptor_missile(var6);
  thread interceptor_missile_death_monitor(var6, var6, var6.interceptor_missile_objective_id);
  update_missile_lock_hud_for_missile_defense_player();
}

function put_objective_icon_on_interceptor_missile(var0) {
  var1 = scripts\cp\cp_objectives::requestworldid("interceptor_missile_entity_number_" + var0 getentitynumber(), 22);
  objective_state(var1, "invisible");
  objective_icon(var1, "hud_callsign_bg");
  objective_onentity(var1, var0);
  objective_setzoffset(var1, 0);
  objective_removeallfrommask(var1);
  objective_setplayintro(var1, 0);
  objective_setplayoutro(var1, 0);
  objective_setbackground(var1, 1);
  objective_setshowdistance(var1, 1);
  objective_setshowprogress(var1, 1);
  objective_setfadedisabled(var1, 1);
  var0.interceptor_missile_objective_id = var1;
  make_visible_to_missile_defense_player(var1);
}

function get_away_from_target_entity_monitor(var0) {
  var0 endon("death");
  thread start_chasing_target_entity_think(var0);
  var0 waittill("start_chasing_target_entity");
  var1 = distancesquared(var0.origin, var0.target_entity.origin);

  for(;;) {
    waitframe();

    if(isDefined(var0.target_entity) && isDefined(var0.target_entity.origin)) {
      var2 = distancesquared(var0.origin, var0.target_entity.origin);

      if(var2 < var1) {
        var1 = var2;
      } else {
        interceptor_missile_explodes_with_target(var0);
        return;
      }
    }
  }
}

function start_chasing_target_entity_think(var0) {
  var0 endon("death");

  for(;;) {
    if(isDefined(var0.target_entity) && isDefined(var0.target_entity.angles)) {
      var1 = anglesToForward(var0.angles);
      var2 = anglesToForward(var0.target_entity.angles);

      if(vectordot(var2, var1) > 0) {
        var0 notify("start_chasing_target_entity");
        return;
      }
    }

    waitframe();
  }
}

function hit_target_entity_monitor(var0) {
  var0 endon("death");

  for(;;) {
    if(isDefined(var0.target_entity) && isDefined(var0.target_entity.origin)) {
      if(distancesquared(var0.origin, var0.target_entity.origin) <= 22500) {
        interceptor_missile_explodes_with_target(var0);
      }
    }

    waitframe();
  }
}

function interceptor_missile_explodes_with_target(var0) {
  playFX(scripts\engine\utility::getfx("interceptor_hit_air_exp"), var0.target_entity.origin);
  playsoundatpos(var0.target_entity.origin, "iw8_cruise_missile_exp");
  var0.target_entity delete();
  var0 delete();
}

function interceptor_missile_death_monitor(var0, var1, var2) {
  var0 waittill("death");
  level.interceptor_missiles = scripts\engine\utility::array_remove(level.interceptor_missiles, var0);
  scripts\cp\cp_objectives::freeworldid("interceptor_missile_entity_number_" + var2);
  objective_delete(var1);
}

function make_interceptor_missile_target_anchor(var0) {
  var1 = spawn("script_model", var0.origin);
  var1 setModel("tag_origin");
  thread missile_anchor_clean_up_think(var1, var1);
  return var1;
}

function missile_anchor_clean_up_think(var0, var1) {
  var0 endon("death");
  var1 waittill("death");
  var0 delete();
}

function missile_defense_lock_on_cruise_missile_think(var0, var1) {
  var0 endon("disconnect");
  var0 endon("exit_missile_defense");
  var1 endon("death");

  for(;;) {
    if(isDefined(level.cruise_missiles)) {
      foreach(var3 in level.cruise_missiles) {
        if(var0 worldpointinreticle_circle(var3.origin, var0.target_circle_fov, var0.target_circle_radius)) {
          var3.lock_on_progress += 0.05;
        }

        if(var3.lock_on_progress >= 0.5) {
          mark_cruise_missile_as_locked_on(var3, var0, var1);
        }
      }
    }

    waitframe();
  }
}

function mark_cruise_missile_as_locked_on(var0, var1, var2) {
  if(!isDefined(level.locked_on_cruise_missiles)) {
    level.locked_on_cruise_missiles = [];
  }

  if(!scripts\engine\utility::array_contains(level.locked_on_cruise_missiles, var0)) {
    objective_icon(var0.cruise_missile_objective_id, "hud_callsign_bg_rd_full");
    var2.reaper.missile_defense_camera_anchor playsoundtoplayer("breach_warning_beep_05", var1);
    level.locked_on_cruise_missiles = scripts\engine\utility::array_add(level.locked_on_cruise_missiles, var0);
    var1 setclientomnvar("ui_missile_lock", 1);
    return;
  }
}

function enter_missile_defense_vision_set(var0) {
  var0 endon("disconnect");
  var0 endon("exit_missile_defense");
  overwatch_screen_transition(var0);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color_glitch", var0, 0.25);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color", var0, 0);
}

function give_missile_defense_weapons(var0) {
  var0 scripts\cp\utility::_giveweapon("ac130_105mm_cp");
  var0 scripts\cp\cp_weapons::_switchtoweaponimmediate("ac130_105mm_cp");
  var0 scripts\common\utility::allow_weapon_switch(0);
  var0.pre_missile_defense_weapon = var0 getcurrentweapon();
}

function enter_missile_defense_view(var0, var1) {
  var0 playerlinkweaponviewtodelta(var1.reaper.missile_defense_camera_anchor, "tag_player", 1, 180, 180, 90, 80, 0);
  var0 playerlinkedsetviewznear(0);
  var2 = anglesToForward(var1.angles);
  var2 *= (1, 1, 0);
  var0 setplayerangles(vectortoangles(var2));
}

function exit_missile_defense(var0, var1, var2, var3) {
  var1 notify("exit_missile_defense");
  thread exit_missile_defense_vision_set(var1);
  var1 setclientomnvar("ui_overwatch_view", 0);
  var1 setclientomnvar("ui_veh_vehicle", 10);
  enable_vehicle_interaction(var2, "missile_defense_left");
  enable_vehicle_interaction(var2, "missile_defense_right");
  var1.disable_map_tablet = undefined;
  exit_missile_defense_view(var1, var1);
  unmark_vehicle_as_friendly_target_group(var1, var1);
  remove_missile_defense_weapons(var1, var1);
  clear_icon_on_cruise_missiles(var1, var1);
  clear_icon_on_interceptor_missiles(var1, var1);

  if(var3 == "last_stand") {
    var1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var1, 1);
    exit_vehicle(var1, var2, var1.previous_vehicle_seat);
    return;
  }

  var1 animscriptentervehicle();
  return_to_previous_seat(var1, var2);
}

function clear_icon_on_cruise_missiles(var0) {
  if(isDefined(level.cruise_missiles)) {
    foreach(var2 in level.cruise_missiles) {
      objective_removeclientfrommask(var2.cruise_missile_objective_id, var0);
    }

    return;
  }
}

function clear_icon_on_interceptor_missiles(var0) {
  if(isDefined(level.interceptor_missiles)) {
    foreach(var2 in level.interceptor_missiles) {
      if(isDefined(var2)) {
        objective_removeclientfrommask(var2.interceptor_missile_objective_id, var0);
      }
    }

    return;
  }
}

function remove_missile_defense_weapons(var0) {
  var0 scripts\cp\cp_weapons::_takeweapon("ac130_105mm_cp");
  var0 scripts\common\utility::allow_weapon_switch(1);
  var0 switchtoweaponimmediate(var0.pre_missile_defense_weapon);
}

function exit_missile_defense_view(var0) {
  var0 cameraunlink();
}

function exit_missile_defense_vision_set(var0) {
  var0 endon("disconnect");
  var0 endon("enter_missile_defense");
  overwatch_screen_transition(var0);
  level notify("vision_set_change_request", undefined, var0, 0, "ac130_color");
  waitframe();
  level notify("vision_set_change_request", undefined, var0, 0, "ac130_color_glitch");
}

function enter_reaper_right(var0, var1, var2) {
  enter_reaper(var0, var1, var2, "overwatch_right");
  disable_vehicle_interaction(var2, "overwatch_left");
}

function enter_reaper_left(var0, var1, var2) {
  enter_reaper(var0, var1, var2, "overwatch_left");
  disable_vehicle_interaction(var2, "overwatch_right");
}

function enter_reaper(var0, var1, var2, var3) {
  var1 notify("enter_overwatch");
  var1.disable_map_tablet = 1;
  exit_seat_but_stay_on_seat(var1);
  record_seat(var1, var3);
  var1 setclientomnvar("ui_veh_vehicle", -1);
  var1 setclientomnvar("ui_overwatch_view", 1);
  show_ied_zone_to_player(var1, var1);
  update_enemy_visualization_for_entering_reaper(var1, var1);
  delete_non_overwatch_ied_marker_vfx_for_player(var1, var1);
  enter_reaper_view(var1, var1, var2);
  make_camera_point(var1, var1, var2);
  mark_vehicle_as_friendly_target_group(var1, var1, var2);
  give_reaper_weapons(var1, var1);
  thread enter_reaper_control(var1, var1);
  thread enter_overwatch_vision_set(var1);
  thread target_in_red_circle_think(var1, var1);
  thread reaper_radar_control(var1, var1);
}

function see_icon_on_cruise_missiles(var0) {
  if(isDefined(level.cruise_missiles)) {
    foreach(var2 in level.cruise_missiles) {
      objective_addclienttomask(var2.cruise_missile_objective_id, var0);
    }

    return;
  }
}

function see_icon_on_interceptor_missiles(var0) {
  if(isDefined(level.interceptor_missiles)) {
    foreach(var2 in level.interceptor_missiles) {
      objective_addclienttomask(var2.interceptor_missile_objective_id, var0);
    }

    return;
  }
}

function play_cloud_vfx(var0, var1) {
  playfxontagforclients(scripts\engine\utility::getfx("reaper_clouds"), var1.reaper.missile_defense_camera_anchor, "tag_player", var0);
}

function enter_reaper_control(var0, var1) {
  var0 endon("disconnect");
  var0 endon("exit_overwatch");
  thread reaper_camera_zoom_think(var0, var0);
  thread reaper_camera_reset_think(var0, var0);
  thread reaper_fire_missile_think(var0, var0);
}

function reaper_fire_missile_think(var0, var1) {
  var0 endon("disconnect");
  var0 endon("exit_overwatch");
  var1 endon("death");

  if(ref_12a4d()) {
    ref_12a4c(var0);
  }

  var0 notifyonplayercommand("reaper_fire_missile", "+attack");
  var2 = 2;
  var0 setclientomnvar("ui_killstreak_weapon_2_ammo", var2);

  for(;;) {
    var0 waittill("reaper_fire_missile");
    var3 = fire_reaper_missile(var0, var1);
    var2 -= 1;
    var0 setclientomnvar("ui_killstreak_weapon_2_ammo", var2);

    if(var2 == 0) {
      reaper_waitforweaponreloadtime(var0, var0);
      var2 = 2;
      var0 setclientomnvar("ui_killstreak_weapon_2_ammo", var2);
    }
  }
}

function fire_reaper_missile(var0, var1) {
  var2 = 3;
  var3 = make_reaper_missile_target_ent(var0, var1);
  var4 = anglestoleft(var0 getplayerangles());
  var5 = var1.reaper.missile_defense_camera_anchor.origin + var4 * var2;
  var6 = magicbullet("overwatch_missile_cp", var5, var3.origin, var0);
  var6 missile_settargetEnt(var3);
  var6 missile_setflightmodedirect();
  var6 setscriptablepartstate("thruster", "on", 0);
  thread clean_up_monitor(var3, var3);
  return var6;
}

function reaper_waitforweaponreloadtime(var0) {
  var1 = 4;
  level.ref_12a4b = gettime() + int(var1 * 1000);
  var0 setclientomnvar("ui_ac130_40mm_reloadtime", level.ref_12a4b);

  for(;;) {
    wait 0.05;
    var1 -= 0.05;

    if(var1 <= 0) {
      break;
    }
  }
}

function ref_12a4d() {
  return isDefined(level.ref_12a4b) && level.ref_12a4b > gettime();
}

function ref_12a4c(var0) {
  var1 = gettime();
  var2 = level.ref_12a4b - var1;
  var3 = var2 / 1000;
  var0 setclientomnvar("ui_ac130_40mm_reloadtime", level.ref_12a4b);
  wait var3;
}

function clean_up_monitor(var0, var1) {
  var0 endon("death");
  var1 waittill("death");
  var0 delete();
}

function make_reaper_missile_target_ent(var0, var1) {
  var2 = get_reaper_player_look_at_ground_pos(var0, var1);
  var3 = spawn("script_model", var2);
  var3 setModel("tag_origin");
  thread ref_123fc(var3, var3);
  put_objective_icon_on_reaper_missile_target_ent(var3, var0);
  thread follow_player_look_at(var3, var3, var0);
  return var3;
}

function ref_123fc(var0, var1) {
  var0 endon("death");
  waitframe();
  playfxontagforclients(level._effect["reaper_missile_marker"], var0, "tag_origin", var1);
}

function put_objective_icon_on_reaper_missile_target_ent(var0, var1) {
  var2 = scripts\cp\cp_objectives::requestworldid("reaper_missile_target_ent" + var0 getentitynumber(), 22);
  objective_state(var2, "invisible");
  objective_icon(var2, "hud_overwatch_missile_target");
  objective_onentity(var2, var0);
  objective_setzoffset(var2, 0);
  objective_removeallfrommask(var2);
  objective_setplayintro(var2, 0);
  objective_setplayoutro(var2, 0);
  objective_setbackground(var2, 1);
  objective_setshowdistance(var2, 0);
  objective_setshowprogress(var2, 1);
  objective_setfadedisabled(var2, 1);
  objective_addclienttomask(var2, var1);
  thread reaper_missile_target_ent_objective_clean_up_think(var0, var0, var2);
}

function reaper_missile_target_ent_objective_clean_up_think(var0, var1, var2) {
  var0 waittill("death");
  scripts\cp\cp_objectives::freeworldid("reaper_missile_target_ent" + var2);
  objective_delete(var1);
}

function follow_player_look_at(var0, var1, var2) {
  var0 endon("death");
  var1 endon("disconnect");
  var1 endon("last_stand");
  var1 endon("exit_overwatch");

  for(;;) {
    waitframe();
    var0.origin = get_reaper_player_look_at_ground_pos(var1, var2);
  }
}

function reaper_radar_control(var0, var1) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("exit_overwatch");
  var0 notifyonplayercommand("overwatch_radar_pin", "+speed_throw");

  for(;;) {
    var0 waittill("overwatch_radar_pin");
    var0.overwatch_camera_point playsoundtoplayer("reaper_scan_target", var0);
    var2 = get_reaper_player_look_at_ground_pos(var0, var1);
    waitframe();
    thread show_unidentified_ied_within_target_circle(level, var0);
    thread show_ai_within_target_circle(level, var0);
    wait 1;
  }
}

function get_reaper_player_look_at_ground_pos(var0, var1) {
  var2 = anglesToForward(var0 getplayerangles());
  var3 = var1.reaper.scanning_camera_anchor.origin + var2 * 50;
  var4 = var1.reaper.scanning_camera_anchor.origin + var2 * 30000;
  var5 = scripts\engine\trace::ray_trace_detail(var3, var4, var1.reaper);
  var6 = var5["position"];
  return var6;
}

function show_unidentified_ied_within_target_circle(var0, var1) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("exit_overwatch");
  var2 = [];

  foreach(var4 in level.unidentified_ieds) {
    if(istrue(var4.in_reaper_target_circle)) {
      var2 = var4;
    }
  }

  var6 = sortbydistance(var2, var1);

  foreach(var8 in var6) {
    var0.overwatch_camera_point playsoundtoplayer("breach_warning_beep_05", var0);
    mark_ied_as_identified(var0, var8);
    wait randomfloatrange(0.05, 0.1);
  }
}

function show_ai_within_target_circle(var0, var1) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("exit_overwatch");
  var2 = [];

  foreach(var4 in level.agentarray) {
    if(!isDefined(var4)) {
      continue;
    }

    if(!isalive(var4)) {
      continue;
    }

    if(istrue(var4.marked_by_overwatch_scan)) {
      continue;
    }

    if(var4.team == "allies") {
      continue;
    }

    if(istrue(var4.in_reaper_target_circle)) {
      var2 = var4;
    }
  }

  var6 = sortbydistance(var2, var1);

  foreach(var4 in var6) {
    var0.overwatch_camera_point playsoundtoplayer("breach_warning_beep_05", var0);
    var4.marked_by_overwatch_scan = 1;
    add_ai_to_marked_enemy_ai_list(var4);
    outline_enemy_ai_for_overwatch(var4, var0);

    if(istrue(var4.is_critical_ai_target)) {
      add_ai_to_marked_critical_enemy_ai_list(var4);
      put_target_marker_on_critical_enemy_ai(var4, var0);
      make_critical_target_icon_on_ai(var4);

      foreach(var9 in level.players) {
        if(var9 == var0) {
          continue;
        }

        show_critical_target_icon_to_player(var4, var9);
      }
    }

    wait randomfloatrange(0.05, 0.1);
  }
}

function reaper_get_target_in_circle_omnvar_value(var0) {
  if(player_in_intercept_mode(var0)) {
    return intercept_mode_get_target_in_circle_omnvar_value(var0);
  }

  return scanning_mode_get_target_in_circle_omnvar_value(var0);
}

function player_in_intercept_mode(var0) {
  return var0.current_reaper_camera_zoom_level == 3;
}

function intercept_mode_get_target_in_circle_omnvar_value(var0) {
  foreach(var2 in level.unidentified_ieds) {
    var2.in_reaper_target_circle = undefined;
  }

  foreach(var5 in level.agentarray) {
    var5.in_reaper_target_circle = undefined;
  }

  return false;
}

function scanning_mode_get_target_in_circle_omnvar_value(var0) {
  var1 = 0;

  foreach(var3 in level.unidentified_ieds) {
    if(var0 worldpointinreticle_circle(var3.origin, var0.target_circle_fov, var0.target_circle_radius)) {
      var3.in_reaper_target_circle = 1;
      var1 += 1;
      continue;
    }

    var3.in_reaper_target_circle = undefined;
  }

  foreach(var6 in level.agentarray) {
    if(!isDefined(var6)) {
      var6.in_reaper_target_circle = undefined;
      continue;
    }

    if(!isalive(var6)) {
      var6.in_reaper_target_circle = undefined;
      continue;
    }

    if(istrue(var6.marked_by_overwatch_scan)) {
      var6.in_reaper_target_circle = undefined;
      continue;
    }

    if(istrue(var6.team == "allies")) {
      var6.in_reaper_target_circle = undefined;
      continue;
    }

    if(var0 worldpointinreticle_circle(var6.origin, var0.target_circle_fov, var0.target_circle_radius)) {
      var6.in_reaper_target_circle = 1;
      var1 += 1;
    }
  }

  var1 = min(var1, 7) / 7 * 0.4;
  return var1;
}

function reaper_camera_zoom_think(var0, var1) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("exit_overwatch");
  var1 endon("death ");
  var0 notifyonplayercommand("reaper_camera_zoom_in", "+actionslot 1");
  var0 notifyonplayercommand("reaper_camera_zoom_out", "+actionslot 2");
  set_current_reaper_camera_zoom_level(var0, 2, var1);

  for(;;) {
    var2 = var0 scripts\engine\utility::ref_143ad("reaper_camera_zoom_in", "reaper_camera_zoom_out");

    if(var2 == "reaper_camera_zoom_in") {
      adjust_reaper_camera_zoom_level(var0, -1, var1);
    } else if(var2 == "reaper_camera_zoom_out") {
      adjust_reaper_camera_zoom_level(var0, 1, var1);
    }

    waitframe();
  }
}

function reaper_camera_reset_think(var0, var1) {
  var0 endon("disconnect");
  var0 endon("exit_overwatch");
  var1 endon("death");
  var0 notifyonplayercommand("reset_overwatch_camera", "+weapnext");

  for(;;) {
    var0 waittill("reset_overwatch_camera");
    var0 setplayerangles(vectortoangles(var1.origin - var1.reaper.scanning_camera_anchor.origin));
  }
}

function adjust_reaper_camera_zoom_level(var0, var1, var2) {
  var3 = int(clamp(var0.current_reaper_camera_zoom_level + var1, 1, 2));
  set_current_reaper_camera_zoom_level(var0, var3, var2);
}

function set_current_reaper_camera_zoom_level(var0, var1, var2) {
  if(isDefined(var0.current_reaper_camera_zoom_level) && var0.current_reaper_camera_zoom_level == var1) {
    return;
  }

  var3 = var0.current_reaper_camera_zoom_level;
  var0.current_reaper_camera_zoom_level = var1;
  switch_to_proper_zoom_weapon(var0);
  adjust_target_circle_fov_and_radius(var0);
}

function switch_to_proper_zoom_weapon(var0) {
  var1 = get_proper_zoom_weapon(var0);
  var0 scripts\cp\cp_weapons::_switchtoweaponimmediate(var1);
}

function adjust_target_circle_fov_and_radius(var0) {
  switch (var0.current_reaper_camera_zoom_level) {
    case 1:
      var0.target_circle_fov = 10;
      var0.target_circle_radius = 150;
      return;
    case 2:
      var0.target_circle_fov = 22;
      var0.target_circle_radius = 150;
      return;
    case 3:
      var0.target_circle_fov = 35;
      var0.target_circle_radius = 20;
      return;
  }
}

function get_proper_zoom_weapon(var0) {
  switch (var0.current_reaper_camera_zoom_level) {
    case 1:
      return "ac130_25mm_cp";
    case 2:
      return "ac130_40mm_cp";
    case 3:
      return "ac130_105mm_cp";
  }
}

function mark_vehicle_as_friendly_target_group(var0, var1) {
  var0.humvee_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", var0, var1, var0);

  if(isDefined(level.friendly_convoy)) {
    foreach(var3 in level.friendly_convoy) {
      if(!isDefined(var3)) {
        continue;
      }

      if(var3 == var1) {
        continue;
      }

      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var3, var0.humvee_marker_group_id);
    }

    return;
  }
}

function unmark_vehicle_as_friendly_target_group(var0) {
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var0.humvee_marker_group_id);
}

function make_camera_point(var0, var1) {
  var2 = spawn("script_model", var1.reaper.scanning_camera_anchor.origin);
  var2 setModel("tag_origin");
  var2.angles = var1.reaper.scanning_camera_anchor.angles;
  var2 linkTo(var1.reaper.scanning_camera_anchor);
  var0.overwatch_camera_point = var2;
}

function enter_reaper_view(var0, var1) {
  var0 playerlinkweaponviewtodelta(var1.reaper.scanning_camera_anchor, "tag_player", 1, 45, 45, 30, 30, 0);
  var0 playerlinkedsetviewznear(0);
  var0 setplayerangles(vectortoangles(var1.origin - var1.reaper.scanning_camera_anchor.origin));
}

function give_reaper_weapons(var0) {
  var0 scripts\cp\utility::_giveweapon("ac130_105mm_cp");
  var0 scripts\cp\utility::_giveweapon("ac130_40mm_cp");
  var0 scripts\cp\utility::_giveweapon("ac130_25mm_cp");
  var0 scripts\common\utility::allow_weapon_switch(0);
  var0.pre_reaper_weapon = var0 getcurrentweapon();
}

function exit_reaper(var0, var1, var2, var3) {
  var1 notify("exit_overwatch");
  thread exit_overwatch_vision_set(var1);
  var1 setclientomnvar("ui_overwatch_view", 0);
  var1 setclientomnvar("ui_veh_vehicle", 10);
  hide_ied_zone_from_player(var1, var1);
  update_enemy_visualization_for_exiting_reaper(var1, var1);
  hide_ai_marker_vfx_to_player(var1, var1);
  enable_vehicle_interaction(var2, "overwatch_right");
  enable_vehicle_interaction(var2, "overwatch_left");
  var1.disable_map_tablet = undefined;
  exit_reaper_view(var1, var1);
  delete_camera_point(var1, var1);
  unmark_vehicle_as_friendly_target_group(var1, var1);
  remove_reaper_weapons(var1, var1);
  unset_player_zoom_setting(var1, var1);

  if(var3 == "last_stand" || var3 == "force_player_exit_vehicle") {
    var1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var1, 1);
    exit_vehicle(var1, var2, var1.previous_vehicle_seat);
    return;
  }

  return_to_previous_seat(var1, var2);
}

function unset_player_zoom_setting(var0) {
  var0.current_reaper_camera_zoom_level = undefined;
}

function delete_camera_point(var0) {
  var0.overwatch_camera_point delete();
}

function exit_reaper_view(var0) {
  var0 cameraunlink();
}

function remove_reaper_weapons(var0) {
  var0 scripts\cp\cp_weapons::_takeweapon("ac130_105mm_cp");
  var0 scripts\cp\cp_weapons::_takeweapon("ac130_40mm_cp");
  var0 scripts\cp\cp_weapons::_takeweapon("ac130_25mm_cp");
  var0 scripts\common\utility::allow_weapon_switch(1);
  var0 switchtoweaponimmediate(var0.pre_reaper_weapon);
}

function put_target_marker_on_critical_enemy_ai(var0, var1) {
  if(isDefined(var1.overwatch_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var0, var1.overwatch_target_marker_group_id);
  } else {
    var1.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("ieddronetarget", var1, var0, var1);
  }

  var0.target_marker_group_id = var1.overwatch_target_marker_group_id;
}

function add_ai_to_marked_enemy_ai_list(var0) {
  if(scripts\engine\utility::array_contains(level.marked_enemy_ai, var0)) {
    return;
  }

  level.marked_enemy_ai = scripts\engine\utility::array_add(level.marked_enemy_ai, var0);
  thread remove_from_marked_enemy_ai_list_on_death(var0);
}

function remove_from_marked_enemy_ai_list_on_death(var0) {
  var0 waittill("death");
  level.marked_enemy_ai = scripts\engine\utility::array_remove(level.marked_enemy_ai, var0);
}

function add_ai_to_marked_critical_enemy_ai_list(var0) {
  if(scripts\engine\utility::array_contains(level.marked_critical_enemy_ai, var0)) {
    return;
  }

  level.marked_critical_enemy_ai = scripts\engine\utility::array_add(level.marked_critical_enemy_ai, var0);
  thread remove_from_marked_critical_enemy_ai_list_on_death(var0);
}

function remove_from_marked_critical_enemy_ai_list_on_death(var0) {
  var0 waittill("death");
  level.marked_critical_enemy_ai = scripts\engine\utility::array_remove(level.marked_critical_enemy_ai, var0);
}

function make_critical_target_icon_on_ai(var0) {
  if(has_critical_target_icon(var0)) {
    return;
  }

  var1 = scripts\cp\cp_objectives::requestworldid("enemy_AI_critical_target_ID_" + var0 getentitynumber(), 22);
  objective_state(var1, "invisible");
  objective_icon(var1, "icon_faction_head_enemy");
  objective_onentity(var1, var0);
  objective_setzoffset(var1, 90);
  objective_removeallfrommask(var1);
  objective_setplayintro(var1, 0);
  objective_setplayoutro(var1, 0);
  objective_setbackground(var1, 1);
  objective_setshowdistance(var1, 0);
  objective_setshowprogress(var1, 0);
  objective_setfadedisabled(var1, 1);
  var0.critical_target_icon_objective_id = var1;
  thread delete_critical_target_icon_on_death(var0, var0, var0 getentitynumber());
}

function has_critical_target_icon(var0) {
  return isDefined(var0.critical_target_icon_objective_id);
}

function delete_critical_target_icon_on_death(var0, var1, var2) {
  var0 waittill("death");
  scripts\cp\cp_objectives::freeworldid("enemy_AI_critical_target_ID_" + var1);
  objective_delete(var2);
  var0.critical_target_icon_objective_id = undefined;
}

function show_critical_target_icon_to_player(var0, var1) {
  if(has_critical_target_icon(var0)) {
    objective_addclienttomask(var0.critical_target_icon_objective_id, var1);
    return;
  }
}

function hide_critical_target_icon_to_player(var0, var1) {
  if(has_critical_target_icon(var0)) {
    objective_removeclientfrommask(var0.critical_target_icon_objective_id, var1);
    return;
  }
}

function update_enemy_visualization_for_entering_reaper(var0) {
  foreach(var2 in level.marked_enemy_ai) {
    outline_enemy_ai_for_overwatch(var2, var0);
  }

  foreach(var2 in level.marked_critical_enemy_ai) {
    hide_critical_target_icon_to_player(var2, var0);

    if(isDefined(var0.overwatch_target_marker_group_id)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var2, var0.overwatch_target_marker_group_id);
    } else {
      var0.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("ieddronetarget", var0, var2, var0);
    }

    var2.target_marker_group_id = var0.overwatch_target_marker_group_id;
  }
}

function update_enemy_visualization_for_exiting_reaper(var0) {
  foreach(var2 in level.marked_enemy_ai) {
    remove_enemy_ai_outline_for_overwatch(var2, var0);
  }

  foreach(var2 in level.marked_critical_enemy_ai) {
    make_critical_target_icon_on_ai(var2);
    show_critical_target_icon_to_player(var2, var0);
  }

  if(isDefined(var0.overwatch_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var0.overwatch_target_marker_group_id);
    var0.overwatch_target_marker_group_id = undefined;
    return;
  }
}

function outline_enemy_ai_for_overwatch(var0, var1) {
  var0 hudoutlineenableforclient(var1, "overwatch_target_outline");
}

function remove_enemy_ai_outline_for_overwatch(var0, var1) {
  var0 hudoutlinedisableforclient(var1);
}

function enter_overwatch(var0, var1, var2) {
  var1 notify("enter_overwatch");
  var1.disable_map_tablet = 1;
  exit_seat_but_stay_on_seat(var1);
  record_seat(var1, "overwatch");
  var1 scripts\common\utility::allow_weapon(0);
  var1 setclientomnvar("ui_veh_vehicle", -1);
  var1 setclientomnvar("ui_overwatch_view", 1);
  show_ied_zone_to_player(var1, var1);
  remove_from_players_cannot_see_vehicle_icon_list(var1, var2, var1);
  update_vehicle_objective_visibility(var1, var2);
  delete_non_overwatch_ied_marker_vfx_for_player(var1, var1);
  show_ai_marker_vfx_to_player(var1, var1);
  thread enter_overwatch_vision_set(var1);
  thread enter_overwatch_control(var1, var1);
  thread target_in_red_circle_think(var1, var1);
  thread move_cursor_near_identified_ied(var1);
  thread overwatch_radar_control(var1, var1);
  thread enable_overwatch_model();
}

function exit_overwatch(var0, var1, var2, var3) {
  var1 notify("exit_overwatch");
  thread exit_overwatch_vision_set(var1);
  var1 scripts\common\utility::allow_weapon(1);
  var1 setclientomnvar("ui_overwatch_view", 0);
  var1 setclientomnvar("ui_veh_vehicle", 10);
  hide_ied_zone_from_player(var1, var1);
  add_to_players_cannot_see_vehicle_icon_list(var1, var2, var1);
  update_vehicle_objective_visibility(var1, var2);
  hide_ai_marker_vfx_to_player(var1, var1);
  exit_overwatch_control(var1, var2);
  enable_vehicle_interaction(var2, "overwatch");
  thread disable_overwatch_model();
  var1.disable_map_tablet = undefined;

  if(var3 == "last_stand") {
    var1.stay_on_seat_when_exit_seat = 0;
    exit_seat(var1, 1);
    exit_vehicle(var1, var2, var1.previous_vehicle_seat);
    return;
  }

  return_to_previous_seat(var1, var2);
}

function put_icon_on_vehicle(var0) {
  var1 = scripts\cp\cp_objectives::requestworldid("vehicle_icon", 20);
  objective_setplayintro(var1, 0);
  objective_setbackground(var1, 1);
  objective_state(var1, "invisible");
  objective_icon(var1, "cp_tac_hud_icon_vehicle");
  objective_setlabel(var1, "");
  objective_onentity(var1, var0);
  objective_addalltomask(var1);
  var0.objective_id = var1;

  if(getdvarint("scr_disable_vehicle_icon", 0) != 0) {
    objective_removeallfrommask(var0.objective_id);
  }

  thread icon_clean_up_think(var0);
}

function icon_clean_up_think(var0) {
  var0 waittill("death");
  scripts\cp\cp_objectives::freeworldid("vehicle_icon");
}

function enter_overwatch_control(var0, var1) {
  var0 endon("disconnect");
  var0 endon("exit_overwatch");
  var2 = spawn("script_model", get_camera_spawn_point(var1));
  var2 setModel("tag_origin");
  var2.angles = vectortoangles((0, 0, -1));
  var2.camera_height = var2.origin[2];
  var2.camera_min_height = var2.camera_height - get_overwatch_camera_zoom_max_delta();
  var2.camera_max_height = var2.camera_height + get_overwatch_camera_zoom_max_delta();
  thread clean_up_overwatch_camera_point(var2, var2, var0);
  var0.overwatch_camera_point = var2;
  var0 cameralinkTo(var2, "tag_origin");
  thread camera_zoom_think(var0, var0);
  thread camera_movement_think(var0, var0);
  thread camera_reset_think(var0, var0);
  thread camera_min_height_think(var0, var0);
  thread overwatch_radar_control(var0, var0);
}

function get_overwatch_camera_zoom_max_delta() {
  if(isDefined(level.overwatch_camera_zoom_max_delta)) {
    return level.overwatch_camera_zoom_max_delta;
  }

  return 2000;
}

function target_in_red_circle_think(var0, var1) {
  var0 endon("disconnect");
  var0 endon("exit_overwatch");
  var0 setclientomnvar("ui_targets_in_circle", 0);

  for(;;) {
    var2 = [[var1]](var0);
    var0 setclientomnvar("ui_targets_in_circle", var2);
    waitframe();
  }
}

function overwatch_get_target_in_circle_omnvar_value(var0) {
  var1 = 0;
  var2 = get_unidentidied_ieds_within_scan_range(var0, var0.overwatch_camera_point.camera_ground_point);
  var3 = squared(600);

  foreach(var5 in var2) {
    var1 += 1 - distance2dsquared(var5.origin, var0.overwatch_camera_point.camera_ground_point) / var3;
  }

  foreach(var8 in level.agentarray) {
    if(!isDefined(var8)) {
      continue;
    }

    if(!isalive(var8)) {
      continue;
    }

    if(istrue(var8.marked_by_overwatch_scan)) {
      continue;
    }

    var9 = distance2dsquared(var8.origin, var0.overwatch_camera_point.camera_ground_point);

    if(var9 <= var3) {
      var1 += 1 - var9 / var3;
    }
  }

  var1 = min(var1, 7) / 7 * 0.4;
  return var1;
}

function overwatch_radar_control(var0, var1) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("exit_overwatch");
  var0.false_positive_dots_bank = [];
  var0.next_false_positive_bank_index = 0;
  var0 notifyonplayercommand("overwatch_radar_pin", "+goStand");

  for(;;) {
    var0 waittill("overwatch_radar_pin");
    playFX(level._effect["IED_radar_ping"], var0.overwatch_camera_point.camera_ground_point, undefined, undefined, var0);
    show_unidentified_ied_within_scan_range(var0, var0.overwatch_camera_point.camera_ground_point);
    thread show_ai_within_scan_range(level, var0);
    wait 1;
  }
}

function show_false_positive_dots(var0, var1, var2) {
  var3 = get_false_positive_dots_within_scan_range(var1, var0);
  var4 = [];

  if(additional_false_positive_dots_needed(var3)) {
    var5 = get_additional_num_false_positive_dots_needed(var3);
    var4 = make_false_positive_dots(var0, var1, var5);
  }

  foreach(var7 in var3) {
    thread show_false_positive_dot(level, var0, var1);
  }

  foreach(var7 in var4) {
    thread show_false_positive_dot(level, var0, var1);
  }
}

function show_unidentified_ied_within_scan_range(var0, var1) {
  var2 = get_unidentidied_ieds_within_scan_range(var0, var1);

  foreach(var4 in var2) {
    thread show_ied(level, var0, var1);
  }
}

function show_ai_within_scan_range(var0, var1) {
  var2 = int(30);
  var3 = 400;
  var4 = var3 * 0.05;

  for(var5 = 1; var5 <= var2; var5++) {
    var6 = min(600, var4 * 1.5 * var5);

    foreach(var8 in level.agentarray) {
      if(!isDefined(var8)) {
        continue;
      }

      if(!isalive(var8)) {
        continue;
      }

      if(istrue(var8.marked_by_overwatch_scan)) {
        continue;
      }

      if(distance2dsquared(var8.origin, var1) <= var6 * var6) {
        var0.overwatch_camera_point playsoundtoplayer("breach_warning_beep_05", var0);
        var8 hudoutlineenable("outlinefill_nodepth_orange");
        var8.marked_by_overwatch_scan = 1;
        show_enemy_ai_to_overwatch_player(var8, var0);
      }
    }

    waitframe();
  }
}

function show_enemy_ai_to_overwatch_player(var0, var1) {
  if(isDefined(var1.enemy_ai_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var0, var1.enemy_ai_target_marker_group_id);
  } else {
    var1.enemy_ai_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("ieddronetarget", var1, var0, var1);
  }

  var0.target_marker_group_id = var1.overwatch_target_marker_group_id;
}

function hide_ai_marker_vfx_to_player(var0) {
  if(isDefined(var0.enemy_ai_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var0.enemy_ai_target_marker_group_id);
    var0.enemy_ai_target_marker_group_id = undefined;
    return;
  }
}

function show_ai_marker_vfx_to_player(var0) {
  foreach(var2 in level.agentarray) {
    if(!isDefined(var2)) {
      continue;
    }

    if(!isalive(var2)) {
      continue;
    }

    if(istrue(var2.marked_by_overwatch_scan)) {
      show_enemy_ai_to_overwatch_player(var2, var0);
    }
  }
}

function additional_false_positive_dots_needed(var0) {
  return var0.size < 5;
}

function make_false_positive_dots(var0, var1, var2) {
  var3 = [];
  var4 = get_random_value_in_segment(var2, 360);
  var5 = get_random_value_in_segment(var2, 600);

  for(var6 = 0; var6 < var2; var6++) {
    var7 = (0, var4[var6], 0);
    var8 = anglesToForward(var7);
    var9 = var5[var6];
    var10 = var0.overwatch_camera_point.origin;
    var11 = var1 + var8 * var9;
    var10 = (var11[0], var11[1], var10[2]);
    var11 = scripts\engine\trace::ray_trace_detail(var10, var11 + (0, 0, -5000))["position"] + (0, 0, 5);
    var3 = var11;
    put_into_player_false_positive_bank(var0, var11);
  }

  return var3;
}

function put_into_player_false_positive_bank(var0, var1) {
  var0.false_positive_dots_bank[var0.next_false_positive_bank_index] = var1;
  var0.next_false_positive_bank_index++;

  if(var0.next_false_positive_bank_index >= 200) {
    var0.next_false_positive_bank_index = 0;
    return;
  }
}

function get_additional_num_false_positive_dots_needed(var0) {
  var1 = get_num_of_segments();
  return var1 - var0.size;
}

function get_false_positive_dots_within_scan_range(var0, var1) {
  var2 = [];

  foreach(var4 in var1.false_positive_dots_bank) {
    if(distance2dsquared(var4, var0) <= 360000) {
      var2 = var4;
    }
  }

  return var2;
}

function get_unidentidied_ieds_within_scan_range(var0, var1) {
  var2 = [];

  foreach(var4 in level.unidentified_ieds) {
    if(distance2dsquared(var4.origin, var1) <= 360000) {
      var2 = var4;
    }
  }

  return var2;
}

function show_ied(var0, var1, var2) {
  var3 = distance(var1, var2.origin);
  var4 = 400;
  var5 = var3 / var4;
  var6 = int(var5 * 20);
  var5 = var6 * 0.05;
  wait max(0.05, var5 - 0.55);

  if(isDefined(var0.overwatch_camera_point)) {
    var0.overwatch_camera_point playsoundtoplayer("breach_warning_beep_05", var0);
  }

  mark_ied_as_identified(var0, var2);
}

function show_false_positive_dot(var0, var1, var2) {
  var3 = distance(var1, var2);
  var4 = 400;
  var5 = var3 / var4;
  var6 = int(var5 * 20);
  var5 = var6 * 0.05;
  wait max(0.05, var5 - 0.5);
  playFX(level._effect["IED_false_positive"], var2, (0, 0, 1), (1, 0, 0), var0);
}

function get_random_value_in_segment(var0, var1) {
  var2 = [];
  var3 = var1 / var0;

  for(var4 = 0; var4 < var0; var4++) {
    var2 = randomfloatrange(var4 * var3, (var4 + 1) * var3);
  }

  for(var5 = 0; var5 < 5; var5++) {
    var2 = scripts\engine\utility::array_randomize(var2);
  }

  return var2;
}

function get_num_of_segments() {
  return randomintrange(5, 11);
}

function get_ai_highlight_hudoutline(var0) {
  return "outlinefill_nodepth_red";
}

function mark_enemy_as_identified(var0, var1) {
  var0.highlighted_enemies = scripts\engine\utility::array_remove(var0.highlighted_enemies, var1);
  var1.marked_by_overwatch = 1;
  var1 hudoutlineenable(get_ai_highlight_hudoutline(var1));
}

function mark_ied_as_identified(var0, var1) {
  if(!is_ied_identified(var1) && isDefined(var1)) {
    level notify("IED_marked");
    remove_from_unidentified_ieds_list(var1);
    mark_ied_controller_as_identified(var1);
    add_to_identified_ieds_list(var1);
    show_identified_ied_to_overwatch(var1, var0);
    show_identified_ied_to_non_overwatch(var1, var0);
    set_ied_scanned_flag_from_ied_controller(var1);
    return;
  }
}

function mark_ied_controller_as_identified(var0) {
  var1 = var0.ied_controller;
  var1.identified = 1;

  if(isDefined(var1.unidentified_zone_vfxs)) {
    foreach(var3 in var1.unidentified_zone_vfxs) {
      if(isDefined(var3)) {
        var3 delete();
      }
    }

    return;
  }
}

function camera_movement_think(var0, var1) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("exit_overwatch");
  var1 endon("death ");

  for(;;) {
    var2 = var0 getnormalizedmovement();
    var3 = var2[0];
    var4 = var2[1];

    if(player_moving_camera(var3, var4)) {
      var0 notify("start_moving_camera");
      var5 = (var3 * get_camera_dist_per_frame(var0), var4 * get_camera_dist_per_frame(var0) * -1, 0);
      var6 = var0.overwatch_camera_point.origin + var5;
      var6 = (var6[0], var6[1], var0.overwatch_camera_point.camera_height);
      var0.overwatch_camera_point.origin = var6;
    }

    waitframe();
  }
}

function get_camera_dist_per_frame(var0) {
  var1 = var0.overwatch_camera_point.camera_max_height - var0.overwatch_camera_point.camera_min_height;
  var2 = var0.overwatch_camera_point.camera_height - var0.overwatch_camera_point.camera_min_height;
  var3 = var2 / var1 * 90;
  var4 = 10 + var3;
  return var4;
}

function camera_zoom_think(var0, var1) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("exit_overwatch");
  var1 endon("death ");

  for(;;) {
    if(var0 attackButtonPressed()) {
      var0 notify("start_moving_camera");
      var0.overwatch_camera_point.camera_height = max(var0.overwatch_camera_point.camera_min_height, var0.overwatch_camera_point.camera_height - 160);
      var0.overwatch_camera_point.origin = (var0.overwatch_camera_point.origin[0], var0.overwatch_camera_point.origin[1], var0.overwatch_camera_point.camera_height);
    }

    if(var0 adsButtonPressed()) {
      var0 notify("start_moving_camera");
      var0.overwatch_camera_point.camera_height = min(var0.overwatch_camera_point.camera_max_height, var0.overwatch_camera_point.camera_height + 160);
      var0.overwatch_camera_point.origin = (var0.overwatch_camera_point.origin[0], var0.overwatch_camera_point.origin[1], var0.overwatch_camera_point.camera_height);
    }

    waitframe();
  }
}

function camera_min_height_think(var0, var1) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("exit_overwatch");
  var1 endon("death ");

  for(;;) {
    var2 = scripts\engine\trace::ray_trace_detail(var0.overwatch_camera_point.origin + (0, 0, -5), var0.overwatch_camera_point.origin + (0, 0, -50000));
    var3 = var2["position"];
    var0.overwatch_camera_point.camera_ground_point = var3;
    var4 = var3[2] + 500;
    var0.overwatch_camera_point.camera_min_height = var4;

    if(var0.overwatch_camera_point.origin[2] < var4) {
      var0.overwatch_camera_point.origin = (var0.overwatch_camera_point.origin[0], var0.overwatch_camera_point.origin[1], var4);
    }

    waitframe();
  }
}

function clean_up_overwatch_camera_point(var0, var1, var2) {
  var3 = scripts\engine\utility::waittill_any_ents_return(var1, "exit_overwatch", var1, "disconnect", var1, "last_stand", var2, "death");
  var0 delete();
}

function player_moving_camera(var0, var1) {
  if(abs(var0) != 0) {
    return true;
  }

  if(abs(var1) != 0) {
    return true;
  }

  return false;
}

function camera_reset_think(var0, var1) {
  var0 endon("disconnect");
  var0 endon("exit_overwatch");
  var1 endon("death ");
  var0 notifyonplayercommand("reset_overwatch_camera", "+weapnext");

  for(;;) {
    thread lock_camera_on_vehicle_until_moving_camera(var0, var0);
    var0 waittill("reset_overwatch_camera");
  }
}

function lock_camera_on_vehicle_until_moving_camera(var0, var1) {
  var0 endon("disconnect");
  var0 endon("exit_overwatch");
  var0 endon("start_moving_camera");
  var1 endon("death");

  for(;;) {
    var2 = get_camera_reset_point(var0, var1);
    var0.overwatch_camera_point.origin = var2;
    waitframe();
  }
}

function get_camera_spawn_point(var0) {
  return var0 gettagorigin("tag_origin") + (0, 0, get_camera_control_up_offset());
}

function get_camera_control_up_offset() {
  if(isDefined(level.overwatch_control_up_offset)) {
    return level.overwatch_control_up_offset;
  }

  return 2550;
}

function get_camera_reset_point(var0, var1) {
  var2 = var1 gettagorigin("tag_origin");
  return (var2[0], var2[1], var0.overwatch_camera_point.camera_height);
}

function exit_overwatch_control(var0, var1) {
  var0 cameraunlink();
}

function enter_overwatch_vision_set(var0) {
  var0 endon("disconnect");
  var0 endon("exit_overwatch");
  overwatch_screen_transition(var0);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color_glitch", var0, 0.25);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color", var0, 0);
}

function exit_overwatch_vision_set(var0) {
  var0 endon("disconnect");
  var0 endon("enter_overwatch");
  overwatch_screen_transition(var0);
  level notify("vision_set_change_request", undefined, var0, 0, "ac130_color");
  waitframe();
  level notify("vision_set_change_request", undefined, var0, 0, "ac130_color_glitch");
}

function enable_overwatch_model() {
  if(isDefined(level.uavrig)) {
    level.uavrig show();
    return;
  }

  var0 = getEntArray("minimap_corner", "targetname");

  if(var0.size) {
    var1 = var0[0].origin;
    var2 = var0[1].origin;
    var3 = (0, 0, 0);
    var3 = var2 - var1;
    var3 = (var3[0] / 2, var3[1] / 2, var3[2] / 2) + var1;
    level.uavrotationorigin = var3;
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

function rotateuavrig(var0, var1, var2) {
  if(isDefined(var2)) {
    self endon(var2);
  }

  if(!isDefined(var0)) {
    var0 = 60;
  }

  if(!isDefined(var1)) {
    var1 = -360;
  }

  for(;;) {
    self rotateYaw(var1, var0);
    wait var0;
  }
}

function disable_vehicle_interaction(var0, var1) {
  var2 = get_vehicle_interaction_point(var0, var1);
  var2 makeunusable();
}

function enable_vehicle_interaction(var0, var1) {
  var2 = get_vehicle_interaction_point(var0, var1);
  var2 makeusable();
  var2.being_used = 0;
}

function enter_seat(var0, var1, var2) {
  record_seat(var0, var2);
  var0.exit_vehicle_when_exit_seat = 1;
  var0.stay_on_seat_when_exit_seat = 0;
  play_seat_animation(var0, var1, var2);
  enter_seat_omnvar(var0, var0, var2);
}

function play_seat_animation(var0, var1, var2) {
  var3 = "viewhands_base_iw8";
  var4 = get_seat_tag_name(var2);
  var5 = var1 gettagorigin(var4);
  var6 = var1 gettagangles(var4);
  var0.player_rig = spawn("script_model", var5);
  var0.player_rig.angles = var6;
  var0.player_rig linkTo(var1, var4);
  var0.player_rig setModel(var3);
  var0.player_rig hide();
  var0 setstance("stand");
  var0 animscriptentervehicle();
  var0 setplayerangles(var0.player_rig.angles);
  var0 playerlinktodelta(var0.player_rig, "tag_player", 0, 120, 120, 120, 35, 1);
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

function get_seat_tag_name(var0) {
  var1 = "tag_seat_0";

  switch (var0) {
    case "driver":
      var1 = "tag_seat_0";
      break;
    case "passenger":
      var1 = "tag_seat_1";
      break;
    case "left_back_seat":
      var1 = "tag_seat_2";
      break;
    case "right_back_seat":
      var1 = "tag_seat_3";
      break;
  }

  return var1;
}

function enter_seat_omnvar(var0, var1) {
  for(var2 = 0; var2 <= var0.vehicle_riding_on.players_as_passenger.size - 1; var2++) {
    var3 = var0.vehicle_riding_on.players_as_passenger[var2];
    var4 = var3 getentitynumber() + 1;
    var1 = var3.current_vehicle_seat;
    thread enter_seat_omnvar_internal(var3, var3, var4);
  }
}

function enter_seat_omnvar_internal(var0, var1, var2) {
  var3 = get_seat_omnvar_name(var2);

  foreach(var5 in level.players) {
    if(isDefined(var5.vehicle_riding_on) && var5.vehicle_riding_on == var0.vehicle_riding_on) {
      var6 = var5.vehicle_riding_on;
      var5 setclientomnvar(var3, var1 - 1);

      if(isDefined(var6.fake_health) && isDefined(var6.max_fake_health)) {
        var7 = int(clamp(var6.fake_health / var6.max_fake_health * 100, 0, 100));
        var5 setclientomnvar("ui_veh_health_percent", int(var7));

        if(var7 < 1 && var7 > 0) {
          var5 setclientomnvar("ui_veh_show_health", 1);
        } else {
          var5 setclientomnvar("ui_veh_show_health", 0);
        }
      } else {
        var5 setclientomnvar("ui_veh_show_health", 0);
      }
    }
  }
}

function get_seat_omnvar_name(var0) {
  var1 = "ui_veh_occupant_0";

  switch (var0) {
    case "driver":
      var1 = "ui_veh_occupant_0";
      break;
    case "overwatch":
    case "passenger":
      var1 = "ui_veh_occupant_1";
      break;
    case "mine_drone_left":
    case "missile_defense_left":
    case "overwatch_left":
    case "left_back_seat":
      var1 = "ui_veh_occupant_2";
      break;
    case "mine_drone_right":
    case "missile_defense_right":
    case "overwatch_right":
    case "right_back_seat":
      var1 = "ui_veh_occupant_3";
      break;
    case "grenadier":
    case "gunner":
      var1 = "ui_veh_occupant_4";
      break;
  }

  return var1;
}

function watch_for_host_migration() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");

    foreach(var1 in level.players) {
      var1 setclientomnvar("ui_hide_minimap", 1);
      var1 scripts\cp\utility::init_vehicle_omnvars();

      if(isDefined(var1.vehicle_riding_on.players_as_passenger)) {
        enter_seat_omnvar(var1);
        continue;
      }

      var1 setclientomnvar("ui_veh_vehicle", -1);
    }
  }
}

function exit_seat_omnvar(var0, var1, var2) {
  var3 = var0 getentitynumber();
  var0 setclientomnvar("ui_veh_vehicle", -1);
  var4 = get_seat_omnvar_name(var1);

  foreach(var0 in level.players) {
    if(isDefined(var0.vehicle_riding_on) && var0.vehicle_riding_on == var2) {
      var0 setclientomnvar(var4, -1);
    }
  }
}

function delay_relax_view_arc(var0, var1) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("player_exit_vehicle");
  waitframe();
  var0 playerlinktodelta(var0.player_rig, "tag_player", 0, 120, 120, 120, 120, 1);
}

function exit_seat(var0, var1) {
  if(istrue(var1) && !istrue(var0.stay_on_seat_when_exit_seat)) {
    technical_stopanimatingplayer(var0);
    var0 unlink();
    return;
  }
}

function exit_seat_but_stay_in_vehicle(var0, var1) {
  var0.exit_vehicle_when_exit_seat = 0;
  var0 notify("exit_" + var0.current_vehicle_seat);
  exit_seat_omnvar(var0, var0, var0.current_vehicle_seat, var1);
}

function exit_seat_but_stay_on_seat(var0) {
  var0.exit_vehicle_when_exit_seat = 0;
  var0.stay_on_seat_when_exit_seat = 1;
  var0 notify("exit_" + var0.current_vehicle_seat);
}

function record_seat(var0, var1) {
  var0.previous_vehicle_seat = var0.current_vehicle_seat;
  var0.current_vehicle_seat = var1;
}

function return_to_previous_seat(var0, var1) {
  var2 = get_vehicle_interaction_point(var1, var0.previous_vehicle_seat);
  var2 notify("trigger", var0);
  enter_seat_omnvar(var0, var0, var0.previous_vehicle_seat);
}

function force_player_to_stand(var0) {
  var0 endon("disconnect");
  var0 allowstand(1);
  var0 allowprone(0);
  var0 allowcrouch(0);
  wait 0.5;
  var0 allowprone(1);
  var0 allowcrouch(1);
}

function try_exit_vehicle(var0, var1, var2) {
  if(istrue(var0.exit_vehicle_when_exit_seat)) {
    exit_vehicle(var0, var1, var2);
    return;
  }
}

function enter_vehicle(var0, var1) {
  level notify("players_entered_vehicle");
  var0 notify("player_enter_vehicle");
  var0 setclientomnvar("ui_veh_vehicle", 10);
  var0.vehicle_riding_on = var1;
  var0 disableoffhandprimaryweapons();
  var0 disableoffhandsecondaryweapons();
  var0 allowsprint(0);
  var0 allowsupersprint(0);
  var0 scripts\cp\cp_kidnapper::setimmunetokidnapper(1);
  add_to_players_as_passenger_list(var1, var0);
  add_to_players_cannot_see_vehicle_icon_list(var1, var0);
  update_vehicle_objective_visibility(var1);
  ref_12bec(var0, var1);
  update_driver_interaction_hint(var1);
}

function exit_vehicle(var0, var1, var2) {
  var0 notify("player_exit_vehicle");
  exit_seat_omnvar(var0, var0, var2, var1);
  var0.vehicle_riding_on = undefined;
  var0 scripts\cp\cp_kidnapper::setimmunetokidnapper(0);
  remove_from_players_as_passenger_list(var1, var0);
  remove_from_players_cannot_see_vehicle_icon_list(var1, var0);
  update_vehicle_objective_visibility(var1);
  var0.current_vehicle_seat = undefined;
  var3 = get_exit_vehicle_teleport_to_loc(var0, var1, var2);
  var0 setOrigin(var3, 1);
  var0 setworldupreference(undefined);
  var0 enableoffhandprimaryweapons();
  var0 enableoffhandsecondaryweapons();
  var0 allowsprint(1);
  var0 allowsupersprint(1);
  thread force_player_to_stand(var0);
  race_set_next_checkpoint(var0, var0);
  update_driver_interaction_hint(var1);

  if(should_enable_seat_when_exit_vehicle(var1, var2)) {
    enable_vehicle_interaction(var1, var2);
    return;
  }
}

function ref_12bec(var0, var1) {
  if(isDefined(var1.ref_128c0)) {
    var0.ref_128c1 = [];
    var2 = var0 getweaponslistprimaries();
    var3 = var0 getcurrentweapon();
    var4 = scripts\engine\utility::array_contains(var1.ref_128c0, var3.basename);

    foreach(var6 in var2) {
      if(isDefined(var6.basename) && scripts\engine\utility::array_contains(var1.ref_128c0, var6.basename)) {
        var0.ref_128c1[var0.ref_128c1.size] = var6;
        var0 takeweapon(var6);
      }
    }

    if(istrue(var4)) {
      var0 switchtoweapon(var0 getweaponslistprimaries()[0]);
      return;
    }

    return;
  }
}

function race_set_next_checkpoint(var0) {
  var1 = 0;

  if(isDefined(var0.ref_128c1)) {
    foreach(var3 in var0.ref_128c1) {
      var0 giveweapon(var3);

      if(issubstr(var3.basename, "riotshield")) {
        var1 = 1;
      }
    }

    var0.ref_128c1 = undefined;
  }

  if(istrue(var1)) {
    var0 scripts\cp\cp_weapon::riotshieldonweaponchange();
    return;
  }
}

function update_vehicle_objective_visibility(var0) {
  if(getdvarint("scr_disable_vehicle_icon", 0) != 0) {
    return;
  }

  if(!isDefined(var0.objective_id)) {
    return;
  }

  foreach(var2 in level.players) {
    if(scripts\engine\utility::array_contains(var0.players_cannot_see_vehicle_icon, var2)) {
      objective_removeclientfrommask(var0.objective_id, var2);
      continue;
    }

    objective_addclienttomask(var0.objective_id, var2);
  }

  objective_showtoplayersinmask(var0.objective_id);
}

function should_enable_seat_when_exit_vehicle(var0, var1) {
  return true;
}

function get_exit_vehicle_teleport_to_loc(var0, var1, var2) {
  var3 = create_seat_name_array(var2);
  var4 = 0;
  var2 = var3[var4];
  var5 = get_exit_base_interaction_point(var0, var1, var2);
  var6 = get_exit_direction_vector(var0, var1, var2);
  var7 = vectorNormalize(var6);
  var7 *= -5;
  var8 = var5.origin + var6;
  var9 = scripts\engine\trace::capsule_trace(var5.origin + var7, var8, 6, 80, undefined, var1);
  var10 = 1;

  if(distance2dsquared(var9["position"], var8) < 225) {
    if(abs(var9["position"][2] - var8[2]) < 25) {
      var10 = 0;
    }

    if(!ispointonnavmesh(var9["position"])) {
      var10 = 0;
    }
  }

  while(var10 && var4 < var3.size) {
    var2 = var3[var4];
    var5 = get_exit_base_interaction_point(var0, var1, var2);

    if(isDefined(var5)) {
      var6 = get_exit_direction_vector(var0, var1, var2);
      var7 = vectorNormalize(var6);
      var7 *= -5;
      var8 = var5.origin + var6;
      var9 = scripts\engine\trace::capsule_trace(var5.origin + var7, var8, 6, 80, undefined, var1);

      if(distance2dsquared(var9["position"], var8) < 225) {
        if(abs(var9["position"][2] - var8[2]) < 25) {
          var10 = 0;
        }

        if(!ispointonnavmesh(var9["position"])) {
          var10 = 0;
        }
      }
    }

    if(var10) {
      var4++;
    }

    waitframe();
  }

  if(var4 >= var3.size) {
    var8 = var1.origin + (0, 0, 100);
  }

  var11 = scripts\engine\trace::capsule_trace(var8 + (0, 0, 0), var8 + (0, 0, -256), 6, 80)["position"];
  return var11;
}

function create_seat_name_array(var0) {
  switch (var0) {
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

function get_exit_base_interaction_point(var0, var1, var2) {
  switch (var2) {
    case "driver":
      return get_vehicle_interaction_point(var1, "driver");
    case "passenger":
      return get_vehicle_interaction_point(var1, "passenger");
    case "left_back_seat":
      return get_vehicle_interaction_point(var1, "left_back_seat");
    case "right_back_seat":
      return get_vehicle_interaction_point(var1, "right_back_seat");
  }
}

function get_exit_direction_vector(var0, var1, var2) {
  var3 = anglestoright(var1.angles);
  var4 = var3 * -1;

  switch (var2) {
    case "left_back_seat":
    case "driver":
      return (var4 * 50);
    case "right_back_seat":
    case "passenger":
      return (var3 * 50);
  }
}

function get_vehicle_interaction_point(var0, var1) {
  return var0.vehicle_interactions[var1];
}

function make_vehicle_seat(var0, var1, var2, var3) {
  var4 = var0 gettagorigin("tag_origin");
  var5 = anglesToForward(var0.angles);
  var6 = anglestoright(var0.angles);
  var7 = anglestoup(var0.angles);
  var8 = var4 + var5 * var1 + var6 * var2 + var7 * var3;
  var9 = spawn("script_model", var8);
  var9 setModel("tag_origin");
  var9.angles = var0.angles;
  var9.vehicle = var0;
  var9 linkTo(var0);
  thread clean_up_on_vehicle_death(var9, var9);
  return var9;
}

function init_vehicle(var0, var1) {
  var0.ied_triggering_tag_to_repair_tag_mapping = var1.ied_triggering_tag_to_repair_tag_mapping;
  var0.repair_interaction_list = [];
  var0.players_as_passenger = [];
  var0.players_cannot_see_vehicle_icon = [];
  var0.disabled = 0;
  var0.script_badplace = 1;
  var0.classname_mp = var1.classname_mp;
  var0.slow_tread_vfx_trigger_speed = var1.slow_tread_vfx_trigger_speed;
  var0.fast_tread_vfx_trigger_speed = var1.fast_tread_vfx_trigger_speed;
  var0.tread_vfx_tags = var1.tread_vfx_tags;
  var0.ref_128c0 = var1.ref_128c0;
}

function vehicle_damage_monitor(var0, var1) {
  var0 endon("death");
  var0 setCanDamage(1);
  var0.health = 999999;
  var0.max_fake_health = var1.fake_health;
  var0.fake_health = var1.fake_health;
  var0.trigger_damage_state_health = int(var0.fake_health * var1.show_damage_state_health_ratio);
  var0.showing_damage_state = 0;
  var0.disabled_due_to_damage = 0;

  for(;;) {
    var0 waittill("damage", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
    var0.health = 999999;

    if(is_friendly_fire(var3, var11)) {
      thread melee_to_nudge_car(var0, var0, var5);
      continue;
    }

    if(isDefined(var2)) {
      if(isDefined(var11)) {
        var2 = adjust_damage_to_vehicle(var2, var11, var0);
      }

      var0.fake_health -= var2;
      var12 = int(clamp(var0.fake_health / var1.fake_health * 100, 0, 100));

      foreach(var14 in level.players) {
        if(isDefined(var14.vehicle_riding_on) && var14.vehicle_riding_on == var0) {
          var14 setclientomnvar("ui_veh_health_percent", int(var12));
          var14 setclientomnvar("ui_veh_show_health", 1);
        }
      }

      if(var0.fake_health < 0 && !istrue(var0.disabled_due_to_damage)) {
        disabling_vehicle_due_to_damage(var0);
      } else if(var0.fake_health < var0.trigger_damage_state_health) {
        show_vehicle_damage_state(var0);
      }
    }
  }
}

function adjust_damage_to_vehicle(var0, var1, var2) {
  if(isDefined(var1.basename) && (var1.basename == "juliet_missile_cp" || var1.basename == "rpg_missile_cp" || var1.basename == "cruise_missile_warhead_cp")) {
    return (var2.fake_health + 100);
  }

  return var0;
}

function is_friendly_fire(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isPlayer(var0)) {
    return true;
  }

  if(isDefined(var0.owner) && isPlayer(var0.owner)) {
    return true;
  }

  if(isDefined(var1) && isDefined(var1.basename) && var1.basename == "overwatch_missile_cp") {
    return true;
  }

  return false;
}

function melee_to_nudge_car(var0, var1, var2) {
  if(isDefined(var2) && var2 == "MOD_MELEE" && var0.players_as_passenger.size == 0) {
    var3 = (var1 + var0.origin) / 2 - (0, 0, 40);
    physicsexplosionsphere(var3, 3, 2, 4);
    return;
  }
}

function show_vehicle_damage_state(var0) {
  if(istrue(var0.showing_damage_state)) {
    return;
  }

  var0.showing_damage_state = 1;
  var1 = get_vehicle_interaction_point(var0, "hood_repair");
  thread play_vfx_on_repair_part(var1, var0, "tag_grill", "vehicle_hood_damage_smoke", var1);
}

function disabling_vehicle_due_to_damage(var0) {
  var0.disabled_due_to_damage = 1;
  var0.disabled = 1;
  update_driver_interaction_hint(var0);
  level notify("vehicle_needs_repair");
  var1 = get_vehicle_interaction_point(var0, "hood_repair");
  put_icon_on_vehicle_repair_point(var0, var1);
  set_repair_omnvars("hood_repair", 1);
  thread play_vfx_on_repair_part(var1, var0, "tag_light_front_right_2", "vehicle_hood_damage_smoke", var1);
  thread play_vfx_on_repair_part(var1, var0, "tag_light_front_left_2", "vehicle_hood_damage_smoke", var1);
  force_driver_out_of_vehicle(var0);
  show_vehicle_damage_state(var0);
  enable_vehicle_interaction(var0, "hood_repair");
  var1 = get_vehicle_interaction_point(var0, "hood_repair");
  add_to_vehicle_repair_interaction_list(var0, var1);
}

function set_up_vehicle_interactions(var0, var1) {
  var2 = var0.angles;
  var3 = anglesToForward(var2);
  var4 = anglestoright(var2);
  var5 = anglestoup(var2);
  var6 = var0 gettagorigin("tag_origin");
  var0.vehicle_interactions = [];

  foreach(var11, var8 in var1.interaction_setups_array) {
    var9 = var6 + var3 * var8.front_offset_from_tag_origin + var4 * var8.right_offset_from_tag_origin + var5 * var8.up_offset_from_tag_origin;
    var10 = spawn("script_model", var9);
    var10 setModel("tag_origin");
    var10 linkTo(var0);
    var8 = get_vehicle_interaction_info(var11);
    var10 setHintString(var8.hint_string);
    var10 setCursorHint("HINT_BUTTON");
    var10 sethintdisplayrange(var8.display_range);
    var10 sethintdisplayfov(var8.display_fov);
    var10 setuserange(var8.use_range);
    var10 setusefov(var8.use_fov);
    var10 sethintonobstruction("hide");
    var10 setuseholdduration(var8.use_hold_duration);
    thread use_think(var10, var11, var10, var0, var8.try_use_func, var8.start_use_func, var8.exit_use_func, var8.exit_button);
    var0.vehicle_interactions[var11] = var10;
  }
}

function set_up_ied_triggering_tags(var0, var1) {
  var0.ied_triggering_tags = var1.ied_triggering_tags;
}

function use_think(var0, var1, var2, var3, var4, var5, var6, var7) {
  var2 endon("death");
  var8 = "exit_" + var0;

  if(istrue(var7)) {
    var1 makeusable();
  }

  var1.being_used = 0;

  for(;;) {
    var1 waittill("trigger", var9);

    if(isDefined(var3) && ![[var3]](var2, var9)) {
      continue;
    }

    if(isDefined(var6)) {
      var9 notifyonplayercommand(var8, var6);
    }

    var1 makeunusable();
    var1.being_used = 1;
    var1 thread[[var4]](var1, var9, var2);

    if(isDefined(var6)) {
      var10 = var9 scripts\engine\utility::waittill_any_ents_return(var9, "disconnect", var9, var8, var1, "interaction_point_disabled", var9, "last_stand", var9, "force_player_exit_vehicle", var9, "force_player_exit_seat");
    } else {
      var10 = var9 scripts\engine\utility::waittill_any_ents_return(var9, "disconnect", var1, "interaction_point_disabled", var9, "last_stand", var9, "repair_failed", var9, "force_player_exit_vehicle", var9, "force_player_exit_seat");
    }

    if(isDefined(var5)) {
      var1 thread[[var5]](var1, var9, var2, var10);
    }
  }
}

function register_vehicle_interaction_info(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = spawnStruct();
  var12.hint_string = var1;
  var12.try_use_func = var2;
  var12.start_use_func = var3;
  var12.exit_use_func = var4;
  var12.exit_button = var5;
  var12.display_range = var6;
  var12.display_fov = var7;
  var12.use_range = var8;
  var12.use_fov = var9;
  var12.use_hold_duration = var10;
  var12.available_on_start = var11;
  level.vehicle_interaction_info[var0] = var12;
}

function get_vehicle_interaction_info(var0) {
  return level.vehicle_interaction_info[var0];
}

function assign_vehicle_interaction(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var5.front_offset_from_tag_origin = var1;
  var5.right_offset_from_tag_origin = var2;
  var5.up_offset_from_tag_origin = var3;
  var4 = var5;
  return var4;
}

function debug_interaction_point(var0) {
  for(;;) {
    waitframe();
  }
}

function add_additional_parts(var0, var1) {
  if(isDefined(var1.add_additional_parts_func)) {
    level thread[[var1.add_additional_parts_func]](var0);
    return;
  }
}

function set_up_fake_character_models(var0) {
  var0.fake_back_right_passenger = make_fake_character_model(var0, "tag_seat_3", 1);
  var0.fake_back_left_passenger = make_fake_character_model(var0, "tag_seat_2", 1);
}

#using_animtree("script_model");

function make_fake_character_model(var0, var1, var2, var3) {
  var4 = var0 gettagorigin(var1);
  var5 = spawn("script_model", var4, 0, 1);
  var5 setModel("fullbody_hero_price_urban");
  var5.angles = var0.angles;
  var5 useanimtree(#animtree);

  if(isDefined(var3)) {
    var5 linkTo(var0, var1, var3, (0, 0, 0));
  } else {
    var5 linkTo(var0, var1);
  }

  thread fake_driver_anim_loop(var5);
  thread clean_up_on_vehicle_death(var5, var5);

  if(istrue(var2)) {
    var5 hide();
  }

  return var5;
}

function clean_up_on_vehicle_death(var0, var1) {
  var0 endon("death");
  var1 waittill("death");
  var0 delete();
}

#using_animtree("");

function fake_driver_anim_loop(var0) {
  var0 endon("death");
  var1 = 17.5;
  wait randomfloatrange(0.5, 3.5);

  for(;;) {
    var0 scriptmodelplayanim(%mp_infil_lbravo_a_pilot);
    wait var1;
  }
}

function overwatch_screen_transition(var0) {
  if(!isDefined(var0.overwatch_transition_screen)) {
    var0.overwatch_transition_screen = newclienthudelem(var0);
    var0.overwatch_transition_screen.x = 0;
    var0.overwatch_transition_screen.y = 0;
    var0.overwatch_transition_screen setshader("black", 640, 480);
    var0.overwatch_transition_screen.alignx = "left";
    var0.overwatch_transition_screen.aligny = "top";
    var0.overwatch_transition_screen.sort = 1;
    var0.overwatch_transition_screen.horzalign = "fullscreen";
    var0.overwatch_transition_screen.vertalign = "fullscreen";
    var0.overwatch_transition_screen.foreground = 1;
  }

  var0.overwatch_transition_screen.alpha = 1;
  var0.overwatch_transition_screen fadeovertime(0.25);
  var0.overwatch_transition_screen.alpha = 0;
}

function set_up_ieds() {
  level.unidentified_ieds = [];
  level.identified_ieds = [];

  if(!ied_enabled()) {
    return;
  }

  var0 = scripts\engine\utility::getStructArray("IED_controller", "script_noteworthy");

  foreach(var2 in var0) {
    spawn_ied_zone(var2);
    waitframe();
  }
}

function spawn_ied_zone(var0) {
  if(!should_spawn_ied_zone(var0)) {
    return;
  }

  var0.identified = 0;
  var1 = get_num_of_ied_to_spawn(var0);

  if(isDefined(var0.target)) {
    var2 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  } else {
    var2 = [];
  }

  if(var2.size > 0) {
    for(var3 = 0; var3 < 5; var3++) {
      var2 = scripts\engine\utility::array_randomize(var2);
    }

    for(var4 = 0; var4 < var2; var4++) {
      spawn_ied(var2[var4], var1);
    }
  } else if(var2.size == 0 && var2 > 0) {
    if(!isDefined(level.ied_unique_names)) {
      level.ied_unique_names = 0;
    }

    var5 = "IED_auto_group_" + level.ied_unique_names;
    var1.target = var5;
    level.ied_unique_names++;
    var6 = 256;

    if(isDefined(var1.radius)) {
      var6 = var1.radius;
    }

    if(var6 < 20) {
      var6 = 20;
    }

    var7 = var6 * 0.1;

    for(var3 = 0; var3 < var2; var3++) {
      var8 = randomfloatrange(var7, var6);
      var9 = randomfloatrange(var7, var6);

      if(scripts\engine\utility::cointoss()) {
        var8 *= -1;
      }

      if(scripts\engine\utility::cointoss()) {
        var9 *= -1;
      }

      var10 = (var8, var9, 0);
      var11 = spawnStruct();
      var11.origin = var1.origin + var10;
      var11.origin = scripts\engine\utility::drop_to_ground(var11.origin);

      if(isDefined(var1.script_label) && var1.script_label != "") {
        var11.script_parameters = var1.script_label;
        var11.angles = (0, randomfloat(360), 0);
        var11.origin += (0, 0, 2);
      } else {
        var11.script_parameters = "bomb_homemade_jug_01";
        var11.angles = (randomfloat(360), randomfloat(360), randomfloat(360));
      }

      var11.targetname = var5;
      spawn_ied(var11, var1);
    }
  }

  thread ied_controller_activation_monitor(var1);
}

function should_spawn_ied_zone(var0) {
  var1 = 1;

  if(getdvarfloat("scr_ied_spawn_chance", 0) != 0) {
    var1 = getdvarfloat("scr_ied_spawn_chance");
  }

  return randomfloat(1) < var1;
}

function get_num_of_ied_to_spawn(var0) {
  if(isDefined(var0.script_parameters)) {
    return int(var0.script_parameters);
  }

  return scripts\engine\utility::getStructArray(var0.target, "targetname").size;
}

function spawn_ied(var0, var1) {
  var2 = spawn("script_model", var0.origin);
  var2 setModel(var0.script_parameters);
  var2.angles = scripts\engine\utility::ter_op(isDefined(var0.angles), var0.angles, (0, 0, 0));
  var2.target = var0.target;
  var2.ied_controller = var1;
  var2.active = 0;
  var3 = anglestoup(var2.angles);
  var2.center_point = var2.origin + var3 * 10;
  add_to_unidentified_ieds_list(var2);
  thread ied_damage_monitor(var2);
  thread ied_trigger_monitor(var2);
}

function ied_damage_monitor(var0) {
  var0 endon("IED_exploded");
  var0 setCanDamage(1);
  var0.health = 999999;

  for(;;) {
    var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);
    var0.health = 999999;

    if(isDefined(var2) && isPlayer(var2) || isDefined(var2.owner) && isPlayer(var2.owner) || isDefined(var10) && var10.basename == "overwatch_missile_cp") {
      ied_explodes(var0);
    }
  }
}

function ied_controller_activation_monitor(var0) {
  for(;;) {
    if(!isDefined(scripts\engine\utility::getclosest(var0.origin, level.players, 1024))) {
      deactivate_linked_ied_spawners(var0);
    } else {
      activate_linked_ied_spawners(var0);
    }

    wait 0.25;
  }
}

function deactivate_linked_ied_spawners(var0) {
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");

  for(var2 = 0; var2 < var1.size; var2++) {
    if(isDefined(var1[var2].ied_controller) && istrue(var1[var2].active)) {
      var1[var2] notify("IED_trigger_monitor");
      var1[var2].active = 0;
    }
  }
}

function activate_linked_ied_spawners(var0) {
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");

  for(var2 = 0; var2 < var1.size; var2++) {
    if(isDefined(var1[var2].ied_controller) && !istrue(var1[var2].active)) {
      var1[var2].active = 1;
      thread ied_trigger_monitor(var1[var2]);
    }
  }
}

function ied_trigger_monitor(var0) {
  var0 notify("IED_trigger_monitor");
  var0 endon("IED_trigger_monitor");
  var0 endon("IED_exploded");

  for(;;) {
    if(ied_should_explode(var0)) {
      ied_explodes(var0);
    }

    wait 0.1;
  }
}

function ied_should_explode(var0) {
  if(ied_triggered_by_players(var0)) {
    return true;
  }

  if(ied_triggered_by_vehicles(var0)) {
    return true;
  }

  return false;
}

function ied_explodes(var0, var1) {
  earthquake(0.5, 1.2, var0.origin, 400);
  playFX(level._effect["IED_explosion"], var0.origin);
  playsoundatpos(var0.origin, "frag_grenade_expl_trans");

  if(isDefined(var0.overwatch_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var0, var0 getentitynumber(), var0.overwatch_target_marker_group_id);
  }

  remove_from_unidentified_ieds_list(var0);
  remove_from_identified_ieds_list(var0);
  remove_ied_marker_vfx(var0);
  mark_ied_controller_as_identified(var0);
  thread delay_respawn_ied_zone(level);
  damage_nearby_players(var0, 100, 6400);
  damage_nearby_map_vehicles(var0, 9216);
  damage_nearby_vehicles(var0, 1600);
  send_notify_from_ied_controller(var0);
  delete_ied_marker_vfx_to_non_overwatch(var0);
  do_level_specific_callback(var0);
  var0 delete();
  var0 notify("IED_exploded");
}

function remove_from_target_marker_group(var0) {
  if(isDefined(var0.target_marker_group_id_list)) {
    foreach(var2 in var0.target_marker_group_id_list) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var0, var2);
    }

    return;
  }
}

function do_level_specific_callback(var0) {
  if(isDefined(level.ied_explosion_action_func)) {
    level thread[[level.ied_explosion_action_func]](var0);
    return;
  }
}

function delete_ied_marker_vfx_to_non_overwatch(var0) {
  if(!isDefined(var0.ied_marker_vfxs_non_overwatch)) {
    return;
  }

  foreach(var2 in var0.ied_marker_vfxs_non_overwatch) {
    if(isDefined(var2)) {
      var2 delete();
    }
  }
}

function send_notify_from_ied_controller(var0) {
  var1 = var0.ied_controller;

  if(isDefined(var1.groupname)) {
    level notify(var1.groupname);
    return;
  }
}

function set_ied_scanned_flag_from_ied_controller(var0) {
  var1 = var0.ied_controller;

  if(isDefined(var1.script_side)) {
    if(!scripts\engine\utility::flag_exist(var1.script_side)) {
      scripts\engine\utility::flag_init(var1.script_side);
    }

    scripts\engine\utility::flag_set(var1.script_side);
    return;
  }
}

function ied_triggered_by_vehicles(var0) {
  for(var1 = 0; var1 < level.vehicle_travel_array.size; var1++) {
    if(isDefined(level.vehicle_travel_array[var1].under_vehicle_trigger) && var0 istouching(level.vehicle_travel_array[var1].under_vehicle_trigger)) {
      return 1;
    }
  }

  if(isDefined(level.ied_triggered_by_friendly_convoy_func)) {
    return [[level.ied_triggered_by_friendly_convoy_func]](var0);
  }

  return 0;
}

function ied_triggered_by_players(var0) {
  for(var1 = 0; var1 < level.players.size; var1++) {
    if(istrue(level.players[var1].b_in_vehicle)) {
      continue;
    }

    if(isDefined(level.player_is_terrorist_func) && [[level.player_is_terrorist_func]](level.players[var1])) {
      continue;
    }

    if(distancesquared(level.players[var1].origin, var0.center_point) < 1600) {
      return true;
    }
  }

  return false;
}

function add_to_vehicle_travel_array(var0) {
  if(!isDefined(level.vehicle_travel_array)) {
    level.vehicle_travel_array = [];
  }

  level.vehicle_travel_array = scripts\engine\utility::array_add(level.vehicle_travel_array, var0);
}

function damage_nearby_players(var0, var1, var2) {
  foreach(var4 in level.players) {
    if(distancesquared(var4.origin, var0.origin) < var2) {
      var4 dodamage(var1, var0.origin);
    }
  }
}

function damage_nearby_map_vehicles(var0, var1) {
  if(!isDefined(level.veh_map_ieddamage)) {
    level.veh_map_ieddamage = getcompleteweaponname("at_mine_ap_mp");
  }

  var0.team = "axis";

  foreach(var3 in level.technicals) {
    if(!isent(var3)) {
      continue;
    }

    if(distancesquared(var3.origin, var0.origin) < var1) {
      var3 dodamage(800, var0.origin, var0, var0, "MOD_SUICIDE", level.veh_map_ieddamage);
    }
  }
}

function damage_nearby_vehicles(var0, var1) {
  var2 = get_nearby_vehicles(var0, var1);

  foreach(var4 in var2) {
    var5 = var4.vehicle;
    var6 = var4.ied_triggering_tag;
    var7 = get_repair_interaction_point_name(var6);
    var8 = get_vehicle_interaction_point(var5, var7);
    try_enable_repair_interaction(var5, var6, var0.origin, var7, var8);
  }
}

function try_enable_repair_interaction(var0, var1, var2, var3, var4) {
  if(!scripts\engine\utility::array_contains(var0.repair_interaction_list, var4)) {
    thread do_damage_to_all_players_as_passenger(level, var2);
    enable_vehicle_interaction(var0, var3);
    var5 = var0.ied_triggering_tag_to_repair_tag_mapping[var1];
    var4.repair_tag = var5;
    add_to_vehicle_repair_interaction_list(var0, var4, var5);
    put_icon_on_vehicle_repair_point(var0, var4);
    thread play_vfx_on_repair_part(var4, var0, var5, get_fire_damage_vfx(var5), var4);
    var0.disabled = 1;
    update_driver_interaction_hint(var0);
    level notify("vehicle_needs_repair");
    force_driver_out_of_vehicle(var0);
    return;
  }
}

function update_driver_interaction_hint(var0) {
  var1 = get_vehicle_interaction_point(var0, "driver");
  var1 setHintString(prophidetime(var0));
}

function prophidetime(var0) {
  if(istrue(var0.disabled)) {
    return &"CP_VEHICLE_TRAVEL/REPAIR_FIRST";
  }

  if(isDefined(level.reduce_accuracy_while_stunned)) {
    return [[level.reduce_accuracy_while_stunned]](var0);
  }

  return &"CP_VEHICLE_TRAVEL/DRIVER";
}

function get_fire_damage_vfx(var0) {
  if(issubstr(var0, "left")) {
    return "vehicle_tire_damage_smoke_left";
  }

  return "vehicle_tire_damage_smoke_right";
}

function force_driver_out_of_vehicle(var0) {
  var1 = get_vehicle_interaction_point(var0, "driver");
  var1 notify("interaction_point_disabled");
}

function do_damage_to_all_players_as_passenger(var0, var1) {
  waitframe();

  foreach(var3 in var1) {
    if(isDefined(var3) && !scripts\cp\cp_laststand::player_in_laststand(var3)) {
      var3 dodamage(20, var0);
    }
  }
}

function get_repair_interaction_point_name(var0) {
  switch (var0) {
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

function add_to_vehicle_repair_interaction_list(var0, var1, var2) {
  if(!scripts\engine\utility::array_contains(var0.repair_interaction_list, var1)) {
    var0.repair_interaction_list = scripts\engine\utility::array_add(var0.repair_interaction_list, var1);

    if(isDefined(var2)) {
      set_repair_omnvars(var2, 1);
      return;
    }

    return;
  }
}

function remove_from_vehicle_repair_interaction_list(var0, var1, var2) {
  if(scripts\engine\utility::array_contains(var0.repair_interaction_list, var1)) {
    var0.repair_interaction_list = scripts\engine\utility::array_remove(var0.repair_interaction_list, var1);

    if(isDefined(var2)) {
      set_repair_omnvars(var2, 0);
      return;
    }

    return;
  }
}

function set_repair_omnvars(var0, var1) {
  var2 = "cp_vehicle_damage_1";

  switch (var0) {
    case "tag_wheel_center_front_left":
      var2 = "cp_vehicle_damage_1";
      break;
    case "tag_wheel_center_front_right":
      var2 = "cp_vehicle_damage_2";
      break;
    case "tag_wheel_center_back_left":
      var2 = "cp_vehicle_damage_3";
      break;
    case "tag_wheel_center_back_right":
      var2 = "cp_vehicle_damage_4";
      break;
    case "hood_repair":
      var2 = "cp_vehicle_damage_5";
      break;
  }

  if(istrue(var1)) {
    var3 = 1;
  } else {
    var3 = 0;
  }

  foreach(var5 in level.players) {
    var5 setclientomnvar(var3, var3);
  }
}

function all_repairs_are_done(var0) {
  if(var0.repair_interaction_list.size == 0) {
    return true;
  } else if(var0.repair_interaction_list.size == 1) {
    if(!var0.disabled_due_to_damage && var0.repair_interaction_list[0] == var0.vehicle_interactions["hood_repair"]) {
      return true;
    }
  }

  return false;
}

function add_to_players_as_passenger_list(var0, var1) {
  var1.b_in_vehicle = 1;

  if(!scripts\engine\utility::array_contains(var0.players_as_passenger, var1)) {
    var0.players_as_passenger = scripts\engine\utility::array_add(var0.players_as_passenger, var1);
    return;
  }
}

function remove_from_players_as_passenger_list(var0, var1) {
  var1.b_in_vehicle = 0;

  if(scripts\engine\utility::array_contains(var0.players_as_passenger, var1)) {
    var0.players_as_passenger = scripts\engine\utility::array_remove(var0.players_as_passenger, var1);
    return;
  }
}

function add_to_players_cannot_see_vehicle_icon_list(var0, var1) {
  if(!scripts\engine\utility::array_contains(var0.players_cannot_see_vehicle_icon, var1)) {
    var0.players_cannot_see_vehicle_icon = scripts\engine\utility::array_add(var0.players_cannot_see_vehicle_icon, var1);
    return;
  }
}

function remove_from_players_cannot_see_vehicle_icon_list(var0, var1) {
  if(scripts\engine\utility::array_contains(var0.players_cannot_see_vehicle_icon, var1)) {
    var0.players_cannot_see_vehicle_icon = scripts\engine\utility::array_remove(var0.players_cannot_see_vehicle_icon, var1);
    return;
  }
}

function player_in_vehicle(var0, var1) {
  return scripts\engine\utility::array_contains(var1.players_as_passenger, var0);
}

function get_nearby_vehicles(var0, var1) {
  var2 = [];

  foreach(var4 in level.vehicle_travel_array) {
    if(isDefined(var4.ied_triggering_tags)) {
      foreach(var6 in var4.ied_triggering_tags) {
        if(distancesquared(var4 gettagorigin(var6), var0.origin) < var1 && !scripts\engine\utility::array_contains(var2, var4)) {
          var7 = spawnStruct();
          var7.vehicle = var4;
          var7.ied_triggering_tag = var6;
          var2 = scripts\engine\utility::array_add(var2, var7);
        }
      }
    }
  }

  return var2;
}

function play_vfx_on_repair_part(var0, var1, var2, var3, var4) {
  var5 = var0 gettagorigin(var1);
  var6 = spawn("script_model", var5);
  var6 setModel("tag_origin");
  var6.angles = vectortoangles(var4);
  var6 linkTo(var0);
  wait 0.1;
  playFXOnTag(level._effect[var2], var6, "tag_origin");
  scripts\engine\utility::waittill_any_ents(var0, "death", var3, "interaction_point_disabled");
  stopFXOnTag(level._effect[var2], var6, "tag_origin");
  var6 delete();
}

function put_icon_on_vehicle_repair_point(var0, var1) {
  var2 = scripts\cp\cp_objectives::requestworldid("repair_icon", 21);
  objective_setplayintro(var2, 0);
  objective_setbackground(var2, 1);
  objective_state(var2, "invisible");
  objective_icon(var2, "cp_tac_hud_icon_repair");
  objective_setlabel(var2, "");
  objective_onentity(var2, var1);
  objective_addalltomask(var2);
  var1.objective_id = var2;
  thread repair_icon_clean_up_think(var1, var0, var1);
}

function repair_icon_clean_up_think(var0, var1, var2) {
  scripts\engine\utility::waittill_any_ents(var0, "death", var1, "interaction_point_disabled");
  objective_delete(var2);
  scripts\cp\cp_objectives::freeworldid("repair_icon");
}

function delay_respawn_ied_zone(var0) {
  level endon("game_ended");
  var1 = var0.ied_controller;
  wait randomfloatrange(600, 900);

  for(;;) {
    if(can_respawn_ied_zone(var1)) {
      spawn_ied_zone(var1);
      return;
    }

    wait 15;
  }
}

function can_respawn_ied_zone(var0) {
  foreach(var2 in level.players) {
    if(distance2dsquared(var2.origin, var0.origin) < 250000) {
      return false;
    }

    if(isDefined(var2.overwatch_camera_point) && distance2dsquared(var2.overwatch_camera_point.origin, var0.origin) < 1000000) {
      return false;
    }
  }

  return true;
}

function remove_ied_marker_vfx(var0) {
  if(isDefined(var0.marker_vfx)) {
    var0.marker_vfx delete();
  }

  if(isDefined(var0.mine_drone_marker_vfx)) {
    var0.mine_drone_marker_vfx delete();
    return;
  }
}

function show_ied_zone_to_player(var0) {
  if(!ied_enabled()) {
    return;
  }

  show_identified_ieds_to_overwatch(var0);
}

function ied_enabled() {
  return getdvarint("scr_enable_ied", 0) != 0;
}

function show_identified_ieds_to_overwatch(var0) {
  if(!isDefined(level.identified_ieds)) {
    return;
  }

  level.identified_ieds = scripts\engine\utility::array_removeundefined(level.identified_ieds);

  if(level.identified_ieds.size > 0) {
    var0.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("ieddronetarget", var0, level.identified_ieds, var0);
    return;
  }
}

function show_identified_ied_to_overwatch(var0, var1) {
  if(isDefined(var0) && isDefined(var0.origin)) {
    if(isDefined(var1.overwatch_target_marker_group_id)) {
      handle_identified_ied_to_overwatch_max(var1);
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var0, var1.overwatch_target_marker_group_id);
      update_target_marker_group_id_on_ied(var0, var1.overwatch_target_marker_group_id);
    } else {
      var1.overwatch_target_marker_group_id = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("ieddronetarget", var1, var0, var1);
    }

    var0.overwatch_target_marker_group_id = var1.overwatch_target_marker_group_id;
    return;
  }
}

function update_target_marker_group_id_on_ied(var0, var1) {
  if(!isDefined(var0.target_marker_group_id_list)) {
    var0.target_marker_group_id_list = [];
  }

  if(!scripts\engine\utility::array_contains(var0.target_marker_group_id_list, var1)) {
    var0.target_marker_group_id_list = scripts\engine\utility::array_add(var0.target_marker_group_id_list, var1);
    return;
  }
}

function move_cursor_near_identified_ied(var0) {
  level endon("game_ended");
  var0 endon("exit_overwatch");
  var0 endon("disconnect");
  var1 = 100;
  var2 = var1 * var1;
  var3 = 1500;
  var4 = var3 * var3;
  var5 = var0.overwatch_target_marker_group_id;
  var6 = undefined;

  if(isDefined(var5)) {
    var6 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var5);
  }

  for(;;) {
    jumpiffalse(!isDefined(var5) || !isDefined(var6)) LOC_0000006d;
    var5 = var0.overwatch_target_marker_group_id;

    if(isDefined(var5)) {
      var6 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var5);
    }

    wait 0.1;
  }

  for(;;) {
    var7 = var0.overwatch_camera_point.origin;
    wait 0.1;
    var8 = var0.overwatch_camera_point.origin;

    if(distance2dsquared(var7, var8) > var2) {
      for(var9 = 0; var9 < level.identified_ieds.size; var9++) {
        if(distance2dsquared(level.identified_ieds[var9].origin, var8) < var4) {
          var10 = level.identified_ieds[var9] getentitynumber();

          if(!isDefined(var6.markedents[var10])) {
            handle_identified_ied_to_overwatch_max(var0);
            scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(level.identified_ieds[var9], var5);
          }
        }
      }
    }
  }
}

function handle_identified_ied_to_overwatch_max(var0) {
  var1 = var0.overwatch_target_marker_group_id;

  if(isDefined(var1)) {
    var2 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var1);

    if(var2.markedents.size > 18) {
      var3 = var0.overwatch_camera_point.origin;
      hide_farthest_targetmarker_for_player(var3, var1, level.identified_ieds);
      return;
    }

    return;
  }
}

function hide_farthest_targetmarker_for_player(var0, var1, var2) {
  var3 = scripts\cp_mp\targetmarkergroups::gettargetmarkergroup(var1);
  var4 = sortbydistance(var2, var0);
  var5 = 1;

  for(var6 = var4.size - 1; var6 > 0; var6--) {
    if(!var5) {
      break;
    }

    if(isent(var4[var6])) {
      var7 = var4[var6] getentitynumber();

      if(isDefined(var3.markedents[var7])) {
        scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var4[var6], var1);
        var5 = 0;
      }
    }
  }
}

function show_identified_ied_to_non_overwatch(var0, var1) {
  if(isDefined(var0) && isDefined(var0.origin)) {
    var0 hudoutlineenable("outlinefill_depth_red");
    return;
  }
}

function show_non_overwatch_ied_marker_vfx_to_player(var0, var1) {
  if(!isDefined(var1.ied_marker_vfxs_non_overwatch)) {
    var1.ied_marker_vfxs_non_overwatch = [];
  }

  var2 = spawnfxforclient(level._effect["IED_marker_to_non_overwatch"], var0.origin, var1);
  triggerfx(var2);
  var1.ied_marker_vfxs_non_overwatch[var1.ied_marker_vfxs_non_overwatch.size] = var2;
  var0.ied_marker_vfxs_non_overwatch[var0.ied_marker_vfxs_non_overwatch.size] = var2;
}

function delete_non_overwatch_ied_marker_vfx_for_player(var0) {
  if(!isDefined(var0.ied_marker_vfxs_non_overwatch)) {
    return;
  }

  foreach(var2 in var0.ied_marker_vfxs_non_overwatch) {
    if(isDefined(var2)) {
      var2 delete();
    }
  }
}

function show_all_non_overwatch_ied_marker_vfx_to_player(var0) {
  foreach(var2 in level.identified_ieds) {
    show_non_overwatch_ied_marker_vfx_to_player(var2, var0);
  }
}

function hide_ied_zone_from_player(var0) {
  if(isDefined(var0.overwatch_target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var0.overwatch_target_marker_group_id);
    var0.overwatch_target_marker_group_id = undefined;
    return;
  }
}

function add_to_unidentified_ieds_list(var0) {
  if(!scripts\engine\utility::array_contains(level.unidentified_ieds, var0)) {
    level.unidentified_ieds = scripts\engine\utility::array_add(level.unidentified_ieds, var0);
    return;
  }
}

function remove_from_unidentified_ieds_list(var0) {
  level.unidentified_ieds = scripts\engine\utility::array_remove(level.unidentified_ieds, var0);
}

function add_to_identified_ieds_list(var0) {
  if(!scripts\engine\utility::array_contains(level.identified_ieds, var0)) {
    level.identified_ieds = scripts\engine\utility::array_add(level.identified_ieds, var0);
    return;
  }
}

function is_ied_identified(var0) {
  return scripts\engine\utility::array_contains(level.identified_ieds, var0);
}

function remove_from_identified_ieds_list(var0) {
  level.identified_ieds = scripts\engine\utility::array_remove(level.identified_ieds, var0);
}

function hostage_near_vehicle_monitor() {
  level endon("game_ended");
  level endon("stop_hostage_vehicle_monitor");

  for(;;) {
    level waittill("player_picked_up_hostage", var0);

    while(!isDefined(level.vehicle_travel_array)) {
      wait 1;
    }

    thread carried_hostage_near_vehicle_monitor(var0);
  }
}

function carried_hostage_near_vehicle_monitor(var0) {
  var0 endon("disconnect");
  var0 endon("hostage_dropped_by_me");
  var0 endon("dropped_hostage");

  for(;;) {
    var1 = get_closest_vehicle_within_range(var0, 200);

    if(isDefined(var1)) {
      if(has_hostage_on_board(var1)) {
        var0.hostage_drop_override_data = undefined;
        var0.hostagecarried.overridehintstring = undefined;
      } else {
        var2 = get_closest_vehicle_door_available(var0, var1);
        var3 = var1 gettagorigin("tag_origin");
        var4 = var1.angles;
        var5 = anglesToForward(var4);
        var6 = anglestoright(var4);
        var7 = anglestoup(var4);
        var8 = var3 + var5 * -92 + var6 * 0 + var7 * 50;
        var9 = distance(var0.origin, var8) < 100;

        if(var9) {
          var0.hostage_drop_override_data = make_hostage_drop_override_data(var1, var2, var0);
          var0.hostagecarried.overridehintstring = "enter_vehicle_with_hostage";
        } else {
          var0.hostage_drop_override_data = undefined;
          var0.hostagecarried.overridehintstring = undefined;
        }
      }
    } else {
      var0.hostage_drop_override_data = undefined;
    }

    waitframe();
  }
}

function get_closest_vehicle_door_available(var0, var1) {
  var2 = ["driver", "passenger", "left_back_seat", "right_back_seat"];
  var3 = [];

  foreach(var5 in var2) {
    var6 = get_vehicle_interaction_point(var1, var5);

    if(istrue(var6.being_used)) {
      continue;
    }

    var3 = var6;
  }

  if(var3.size > 0) {
    return scripts\engine\utility::getclosest(var0.origin, var3);
  }

  return undefined;
}

function get_closest_vehicle_within_range(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 100;
  }

  var2 = scripts\engine\utility::getclosest(var0.origin, level.vehicle_travel_array, var1);
  return var2;
}

function make_hostage_drop_override_data(var0, var1, var2) {
  var3 = 0;
  var4 = 0;
  var5 = -60;
  var6 = anglesToForward(var0.angles);
  var7 = anglestoup(var0.angles);
  var8 = anglestoright(var0.angles);
  var9 = spawnStruct();
  var9.vehicle = var0;
  var9.vehicle_door_interaction = var1;
  var9.player = var2;
  var9.position = var0 gettagorigin("tag_origin") + var6 * var5 + var7 * var3 + var8 * var4;
  var9.waittime = 0.05;
  var9.forcepos = 1;
  var9.preventuse = 0;
  var9.call_back_func = &hostage_drop_call_back_func;
  return var9;
}

function hostage_drop_call_back_func(var0, var1) {
  var2 = var1.vehicle_door_interaction;
  var3 = var1.player;
  var4 = var1.vehicle;
  var3 scripts\cp\utility::hint_prompt("enter_vehicle_with_hostage", 0);
  var0 makeunusable();
  var0.angles = (var0.angles[0], var4.angles[1] + 180, var0.angles[2]);
  var0 linkTo(var4);

  if(isDefined(var0.waypoint)) {
    objective_delete(var0.waypoint);
  }

  var4.hostage = var0;
  var0.carried_by_vehicle = 1;
  var0 notify("placed_into_player_vehicle");
  wait 2;
  enable_vehicle_interaction(var4, "retrieve_hostage");
}

function has_hostage_on_board(var0) {
  return isDefined(var0.hostage);
}

function tread_vfx_think(var0) {
  if(!tread_vfx_set_up(var0)) {
    return;
  }

  foreach(var2 in var0.tread_vfx_tags) {
    thread play_tread_vfx_think(var0, var0);
  }
}

function play_tread_vfx_think(var0, var1) {
  var0 endon("death");

  for(;;) {
    var2 = get_speed_type(var0);

    if(should_play_tread_vfx(var2)) {
      var3 = get_tread_vfx(var0, var1, var2);

      if(isDefined(var3)) {
        play_new_tread_vfx(var0, var1, var3);
      }
    }

    wait 0.1;
  }
}

function get_tread_vfx(var0, var1, var2) {
  var3 = var0 gettagorigin(var1);
  var4 = scripts\engine\trace::ray_trace(var3 + (0, 0, 20), var3 + (0, 0, -50), var0, undefined, 1);

  if(var4["fraction"] == 1) {
    return undefined;
  }

  var5 = spawnStruct();
  var6 = filter_surface_type(var4["surfacetype"], var2, var0);
  var5.surface_speed_index = var6 + "_" + var2;
  var5.contact_pos = var4["position"];
  return var5;
}

function filter_surface_type(var0, var1, var2) {
  var3 = var0 + "_" + var1;
  var4 = var2 scripts\common\vehicle_code::get_vehicle_classname();

  if(isDefined(level.vehicle.templates.surface_effects[var4][var3])) {
    return var0;
  }

  return "default";
}

function should_play_tread_vfx(var0) {
  if(var0 == "stop") {
    return false;
  }

  return true;
}

function get_speed_type(var0, var1) {
  var2 = var0.slow_tread_vfx_trigger_speed;
  var3 = var0.fast_tread_vfx_trigger_speed;
  var1 = var0 vehicle_getspeed();

  if(var1 < var2) {
    return "stop";
  }

  if(var1 >= var2 && var1 < var3) {
    return "slow";
  }

  return "fast";
}

function play_new_tread_vfx(var0, var1, var2) {
  var3 = var0 vehicle_getvelocity();
  var4 = var0 scripts\common\vehicle_code::get_vehicle_classname();
  var5 = var0 gettagorigin(var1);
  playFX(level.vehicle.templates.surface_effects[var4][var2.surface_speed_index], var2.contact_pos, var3);
}

function tread_vfx_set_up(var0) {
  var1 = var0 scripts\common\vehicle_code::get_vehicle_classname();
  return isDefined(level.vehicle.templates.surface_effects[var1]);
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

function ref_13b9f(var0) {
  var0 playsoundonmovingent("scn_cp_repair_tire_enter_foley");
}

function ref_13b9d(var0) {
  var0 playsoundonmovingent("scn_cp_repair_tire_air_start");
}

function ref_13b9e(var0) {
  var0 playsoundonmovingent("scn_cp_repair_tire_air_stop");
}

function ref_13ba0(var0) {
  var0 playsoundonmovingent("scn_cp_repair_tire_exit_foley");
}

function ref_12c30(var0) {
  var0 playsoundonmovingent("scn_cp_repair_engine_enter_foley");
}

function ref_12c31(var0) {
  var0 playsoundonmovingent("scn_cp_repair_engine_exit_foley");
}

function ref_12c2e(var0) {
  var0 playsoundonmovingent("scn_cp_repair_engine_fixing_long");
}

function ref_12c2f(var0) {
  var0 playsoundonmovingent("scn_cp_repair_engine_fixing_short");
}

function do_vehicle_repair_animation(var0, var1, var2) {
  var3 = var1.origin;
  var4 = var1.angles;
  var5 = get_tag_anim_offset(var2, var0);
  var6 = getgroundposition(var5.animorg, 2, 100, 24);
  var7 = var5.animang;
  var8 = spawn("script_model", var6);
  var8.origin = var6;
  var8.angles = var7;
  var1 setOrigin(var6, 1);
  var1 setplayerangles(var7);
  var1 setstance("stand");
  var1 disableweapons();
  var1 forceusehinton(&"CP_VEHICLE_TRAVEL/REPAIR");
  spawn_can(var1);
  thread do_vehicle_repair_animation_actual(var1, var0, var1);
  var9 = wait_for_repair_done(var0, var1, var8);
  remove_can(var1);
  waitframe();
  var1 stoploopsound("scn_cp_repair_tire_air_lp");
  var8 delete();
  scripts\cp\cp_destruction::remove_player_rig(var1);
  var1 forceusehintoff();
  var1 setplayerangles(var4);
  var1 setstance("stand");
  var1 cameradefault();
  var1 enableweapons();
  var1 setOrigin(var3, 1);

  if(istrue(var9)) {
    return true;
  }

  return false;
}

function do_vehicle_repair_animation_actual(var0, var1, var2) {
  var1 endon("disconnect");
  var1 endon("repair_failed");
  var3 = getanimlength(%sdr_cp_tirefix_start);
  var4 = getanimlength(%sdr_cp_tirefix_loop);
  var5 = getanimlength(%sdr_cp_tirefix_end);
  var6 = var3 - 0.1;
  var7 = var4 - 0.1;
  var1 thread scripts\cp\cp_destruction::create_player_rig(var1, "veh_repair_plyr");
  var1 cameraset("camera_custom_orbit_2");
  var2 thread scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, "tire_repair_start");
  wait var6;
  var2 thread scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, "tire_repair_loop");
  var1 playLoopSound("scn_cp_repair_tire_air_lp");
  wait var7 / 10;

  if(!scripts\cp\cp_laststand::player_in_laststand(var1)) {
    var2 thread scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, "tire_repair_stop");
    wait 1;
    var1.can hide();
    wait var5 - 1;
    return;
  }
}

function do_hood_repair_animation_actual(var0, var1, var2) {
  var1 endon("disconnect");
  var1 endon("repair_failed");
  var3 = getanimlength(%cp_scripted_fixdecho_enter);
  var4 = getanimlength(%cp_scripted_fixdecho_idle);
  var5 = getanimlength(%cp_scripted_fixdecho_exit);
  var6 = var3;
  var7 = var4;
  var1 thread scripts\cp\cp_destruction::create_player_rig(var1, "veh_repair_plyr");
  var1 cameraset("camera_custom_orbit_1");
  var2 thread scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, "repair_grill_start");
  wait var6;
  var2 thread scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, "repair_grill");
  wait var7;

  if(!scripts\cp\cp_laststand::player_in_laststand(var1)) {
    var2 thread scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, "repair_grill_stop");
    wait var5;
    return;
  }
}

function do_hood_repair_animation(var0, var1, var2, var3) {
  var4 = var1.origin;
  var5 = var1.angles;
  var6 = get_tag_anim_offset(var2, var0);
  var7 = var0 gettagorigin("tag_origin_animate");
  var8 = spawn("script_model", var7);
  var8.angles = var0 gettagangles("tag_origin_animate");
  var1 setstance("stand");
  var1 disableweapons();
  var1 forceusehinton(&"CP_VEHICLE_TRAVEL/REPAIR");
  thread do_hood_repair_animation_actual(var1, var0, var1);
  var9 = wait_for_hood_repair_done(var0, var1, var8);
  var8 delete();
  scripts\cp\cp_destruction::remove_player_rig(var1);
  var1 forceusehintoff();
  var1 setplayerangles(var5);
  var1 setstance("stand");
  var1 cameradefault();
  var1 enableweapons();
  var1 setOrigin(var4, 0);
  return var9;
}

function get_tag_anim_offset(var0, var1) {
  var2 = var1 gettagorigin(var0);
  var3 = var1 gettagangles(var0);
  var4 = spawnStruct();
  var4.origin = var2;
  var4.angles = var3;
  var4.animorg = var2;
  var4.animang = var3;

  switch (var0) {
    case "tag_wheel_center_back_left":
    case "tag_wheel_center_front_left":
      var4.animang = var3 + (0, 180, 0);
      return var4;
    case "tag_wheel_center_back_right":
    case "tag_wheel_center_front_right":
      return var4;
    case "tag_grill":
      var4.animang = var3 + (0, 180, 0);
      return var4;
  }
}

function spawn_can(var0) {
  var1 = spawn("script_model", var0 gettagorigin("tag_accessory_left"));
  var1 setModel("automotive_fix_a_can_01");
  var1.angles = var0 gettagangles("tag_accessory_left");
  var1 linkTo(var0, "tag_accessory_left");
  var0.can = var1;
}

function remove_can(var0) {
  if(isDefined(var0.can)) {
    var0.can delete();
    return;
  }
}

function wait_for_repair_done(var0, var1, var2) {
  var3 = getanimlength(%sdr_cp_tirefix_start);
  var4 = getanimlength(%sdr_cp_tirefix_loop);
  var5 = getanimlength(%sdr_cp_tirefix_end);
  var6 = var3 - 0.1;
  var7 = var4 / 10 - 0.25;
  var8 = var5 - 0.1;
  var9 = var6 + var7 + var8;
  var10 = var0 scripts\cp\utility::player_lua_progressbar(var1, var9 * 1000, undefined, 12);

  if(!istrue(var10)) {
    var1 notify("repair_failed");
  }

  var1 stoploopsound("scn_cp_repair_tire_air_lp");
  return var10;
}

function wait_for_hood_repair_done(var0, var1, var2) {
  var3 = getanimlength(%cp_scripted_fixdecho_enter);
  var4 = getanimlength(%cp_scripted_fixdecho_idle);
  var5 = getanimlength(%cp_scripted_fixdecho_exit);
  var6 = var3;
  var7 = var4;
  var8 = var5;
  var9 = var6 + var7 + var8;
  var10 = var0 scripts\cp\utility::player_lua_progressbar(var1, var9 * 1000, undefined, 12);

  if(!istrue(var10)) {
    var1 notify("repair_failed");
  }

  return var10;
}

function do_hood_repair_anims(var0, var1, var2) {
  var1 endon("repair_failed");
  var2 thread scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, "repair_grill");
}

function fire_cruise_missile_toward(var0, var1) {
  var2 = make_cruise_missile_target_ent(var0, var1);
  var3 = make_cruise_missile(var0, var2);
  put_objective_icon_on_cruise_missile(var3, var3);
  add_to_cruise_missile_list(var3, var3);
  thread keep_following_target_while_remain_height(var2, var2, var1);
  thread cruise_missile_target_ent_clean_up(var2, var2);
  thread cruise_missile_reach_target_ent_monitor(var3, var3, var2);
  thread death_monitor(var3, var3, var3.cruise_missile_objective_id);
}

function cruise_missile_reach_target_ent_monitor(var0, var1, var2) {
  var2 endon("death");
  var0 endon("death");

  for(;;) {
    if(distancesquared(var0.origin, var1.origin) < 250000) {
      break;
    }

    var3 = anglesToForward(var0.angles);
    var4 = vectorNormalize(var1.origin - var0.origin);

    if(vectordot(var3, var4) < 0) {
      break;
    }

    waitframe();
  }

  thread fire_warhead_toward_target(level, var0);
}

function fire_warhead_toward_target(var0, var1) {
  var1 endon("death");
  var0 setscriptablepartstate("wing_trails", "off");
  var0 setscriptablepartstate("main_thruster", "off", 0);
  playFXOnTag(scripts\engine\utility::getfx("cruise_missile_pod_break"), var0, "tag_missile");
  var0 notify("stop_cruise_missile_death_monitor");
  var2 = var0.cruise_missile_objective_id;
  var3 = var0 getentitynumber();
  waitframe();
  var4 = make_cruise_missile_warhead_target_ent(var0);
  var5 = make_cruise_missile_warhead(var0, var4);
  var5.cruise_missile_objective_id = var2;
  put_objective_icon_on_warhead(var5, var2);
  level.cruise_missiles = scripts\engine\utility::array_remove(level.cruise_missiles, var0);

  if(isDefined(level.locked_on_cruise_missiles)) {
    level.locked_on_cruise_missiles = scripts\engine\utility::array_remove(level.locked_on_cruise_missiles, var0);
    update_missile_lock_hud_for_missile_defense_player();
  }

  if(isDefined(var0.interceptor_missile)) {
    set_interceptor_missile_target(var0.interceptor_missile, var5);
  }

  var0 delete();
  thread delay_target_cruise_missile_target(var5, var5, var4);
  thread death_monitor(var5, var5, var2);
}

function update_missile_lock_hud_for_missile_defense_player() {
  var0 = 0;

  foreach(var2 in level.locked_on_cruise_missiles) {
    if(!isDefined(var2)) {
      continue;
    }

    if(istrue(var2.being_intercepted)) {
      continue;
    }

    var0++;
  }

  if(var0 == 0) {
    var4 = get_missile_defense_player();

    if(isDefined(var4)) {
      var4 setclientomnvar("ui_missile_lock", 0);
      return;
    }

    return;
  }
}

function get_missile_defense_player() {
  foreach(var1 in level.players) {
    if(isDefined(var1.current_vehicle_seat) && (var1.current_vehicle_seat == "missile_defense_right" || var1.current_vehicle_seat == "missile_defense_left")) {
      return var1;
    }
  }

  return undefined;
}

function set_interceptor_missile_target(var0, var1) {
  var0.target_anchor.origin = var1.origin;
  var0.target_anchor linkTo(var1);
  var0.target_entity = var1;
}

function put_objective_icon_on_warhead(var0, var1) {
  objective_onentity(var1, var0);
  objective_setzoffset(var1, 0);
}

function delay_target_cruise_missile_target(var0, var1, var2) {
  var0 endon("death");
  wait 0.25;

  if(isDefined(var2)) {
    var0 missile_settargetEnt(var2);
  }

  var1 delete();
}

function add_to_cruise_missile_list(var0) {
  if(!isDefined(level.cruise_missiles)) {
    level.cruise_missiles = [];
  }

  level.cruise_missiles[level.cruise_missiles.size] = var0;
}

function death_monitor(var0, var1, var2) {
  var0 endon("stop_cruise_missile_death_monitor");
  var0 waittill("death");
  level.cruise_missiles = scripts\engine\utility::array_remove(level.cruise_missiles, var0);

  if(isDefined(level.locked_on_cruise_missiles)) {
    level.locked_on_cruise_missiles = scripts\engine\utility::array_remove(level.locked_on_cruise_missiles, var0);
    update_missile_lock_hud_for_missile_defense_player();
  }

  scripts\cp\cp_objectives::freeworldid("cruise_missile_entity_number_" + var2);
  objective_delete(var1);
}

function put_objective_icon_on_cruise_missile(var0) {
  var1 = scripts\cp\cp_objectives::requestworldid("cruise_missile_entity_number_" + var0 getentitynumber(), 22);
  objective_state(var1, "invisible");
  objective_icon(var1, "hud_callsign_bg_rd");
  objective_onentity(var1, var0);
  objective_setzoffset(var1, 0);
  objective_removeallfrommask(var1);
  objective_setplayintro(var1, 0);
  objective_setplayoutro(var1, 0);
  objective_setbackground(var1, 1);
  objective_setshowdistance(var1, 1);
  objective_setshowprogress(var1, 1);
  objective_setfadedisabled(var1, 1);
  var0.cruise_missile_objective_id = var1;
  make_visible_to_missile_defense_player(var1);
}

function make_visible_to_missile_defense_player(var0) {
  foreach(var2 in level.players) {
    if(isDefined(var2.current_vehicle_seat) && (var2.current_vehicle_seat == "missile_defense_right" || var2.current_vehicle_seat == "missile_defense_left")) {
      objective_addclienttomask(var0, var2);
    }
  }
}

function cruise_missile_target_ent_clean_up(var0, var1) {
  var0 endon("death");
  var1 waittill("death");
  var0 delete();
}

function keep_following_target_while_remain_height(var0, var1, var2) {
  var1 endon("death");
  var2 endon("death");
  var3 = var0.origin[2];

  for(;;) {
    var4 = var2.origin - var1.origin;
    var4 *= (1, 1, 0);
    var4 = vectorNormalize(var4);
    var5 = var1.origin + var4 * 7500;
    var5 = (var5[0], var5[1], var3);
    var0.origin = var5;
    waitframe();
  }
}

function make_cruise_missile(var0, var1) {
  var2 = magicbullet("cruise_missile_cp", var0, var1.origin);
  var2 missile_settargetEnt(var1);
  var2 missile_setflightmodedirect();
  var2 setscriptablepartstate("main_thruster", "on", 0);
  var2 setscriptablepartstate("wing_trails", "on");
  var2.lock_on_progress = 0;
  return var2;
}

function make_cruise_missile_warhead(var0, var1) {
  var2 = magicbullet("cruise_missile_warhead_cp", var0 gettagorigin("tag_missile"), var1.origin);
  var2 missile_settargetEnt(var1);
  var2 missile_setflightmodedirect();
  var2 setscriptablepartstate("sub_thruster", "on", 0);
  var2.lock_on_progress = 0;
  level.cruise_missiles = scripts\engine\utility::array_add(level.cruise_missiles, var2);

  if(isDefined(level.locked_on_cruise_missiles) && scripts\engine\utility::array_contains(level.locked_on_cruise_missiles, var0)) {
    level.locked_on_cruise_missiles = scripts\engine\utility::array_add(level.locked_on_cruise_missiles, var2);
  }

  return var2;
}

function make_cruise_missile_target_ent(var0, var1) {
  var2 = var0[2];
  var3 = var1.origin - var0;
  var3 *= (1, 1, 0);
  var3 = vectorNormalize(var3);
  var4 = var1.origin + var3 * 7500;
  var4 = (var4[0], var4[1], var2);
  var5 = spawn("script_model", var4);
  var5 setModel("tag_origin");
  return var5;
}

function make_cruise_missile_warhead_target_ent(var0) {
  var1 = anglesToForward(var0.angles);
  var2 = var0.origin + var1 * 10000;
  var3 = spawn("script_model", var2);
  var3 setModel("tag_origin");
  return var3;
}

function make_reaper_drone(var0) {
  var1 = anglestoright(var0.angles);
  var2 = var0.origin + var1 * 10000 + (0, 0, 10000);
  var3 = spawn("script_model", var2);
  var3 setModel("veh8_mil_air_mquebec9");
  var3.angles = var0.angles;
  thread clean_up_on_vehicle_death(var3, var3);
  thread keep_circling_around_vehicle(var3, var0);
  var3.missile_defense_camera_anchor = create_missile_defense_camera_anchor(var0, var3);
  var3.scanning_camera_anchor = create_scanning_camera_anchor(var0, var3);
  var0.reaper = var3;
  return var3;
}

function keep_circling_around_vehicle(var0, var1) {
  var2 = spawn("script_model", var0.origin);
  var2 setModel("tag_player");
  var1 linkTo(var2, "tag_player");
  thread keep_rotating(var2);
  thread keep_following_vehicle(var2, var2);
  thread clean_up_on_vehicle_death(var2, var2);
}

function keep_rotating(var0) {
  var0 endon("death");

  for(;;) {
    var0 rotateYaw(360, 180);
    wait 180;
  }
}

function keep_following_vehicle(var0, var1) {
  var0 endon("death");
  wait 2;

  for(;;) {
    var2 = (var1.origin[0], var1.origin[1], var0.origin[2]);
    var3 = distance2d(var0.origin, var2);
    var4 = var3 / get_rotation_anchor_move_speed(var3);

    if(var3 <= 10) {
      waitframe();
      continue;
    }

    if(var3 <= 100) {
      var0 moveTo(var2, var4, 0, var4);
      waitframe();
      continue;
    }

    var0 moveTo(var2, var4);
    var0 scripts\engine\utility::ref_143b9(var4, "movedone");
  }
}

function get_rotation_anchor_move_speed(var0) {
  if(var0 <= 150) {
    return 500;
  }

  return 1000;
}

function create_missile_defense_camera_anchor(var0, var1) {
  var2 = anglesToForward(var1.angles);
  var3 = spawn("script_model", var1.origin + var2 * 170 + (0, 0, -140));
  var3 setModel("tag_player");
  var3.angles = vectortoangles((0, 0, -1));
  var3 linkTo(var1);
  thread clean_up_on_vehicle_death(var3, var3);
  return var3;
}

function create_scanning_camera_anchor(var0, var1) {
  var2 = anglesToForward(var1.angles);
  var3 = spawn("script_model", var1.origin + var2 * 0 + (0, 0, -140));
  var3 setModel("tag_player");
  var3.angles = vectortoangles(var0.origin - var3.origin);
  var3 linkTo(var1);
  thread clean_up_on_vehicle_death(var3, var3);
  thread keep_focus_on_vehicle(var3, var3);
  return var3;
}

function keep_focus_on_vehicle(var0, var1) {
  var0 endon("death");
  var1 endon("death");

  for(;;) {
    var0.angles = vectortoangles(var1.origin - var0.origin);
    waitframe();
  }
}

function get_humvee_info(var0) {
  var1 = spawnStruct();
  var1.model = "veh8_civ_lnd_decho_rebel_2";
  var1.vehicle_gdt = "decho_physics_cp";
  var1.add_additional_parts_func = &humvee_add_additional_parts_func;
  var1.ied_triggering_tags = ["tag_wheel_back_left", "tag_wheel_front_left", "tag_wheel_back_right", "tag_wheel_front_right"];
  var1.fake_health = 750;
  var1.show_damage_state_health_ratio = 0.3;
  var1.classname_mp = "cp_decho_rebel";
  var1.slow_tread_vfx_trigger_speed = 1;
  var1.fast_tread_vfx_trigger_speed = 20;
  var1.tread_vfx_tags = ["tag_wheel_back_right", "tag_wheel_back_left", "tag_wheel_front_right", "tag_wheel_front_left"];
  var1.ref_128c0 = ["iw8_me_riotshield_mp"];
  var2 = [];
  GscBinSkip0(0x2e, "tag_wheel_back_left", "tag_wheel_center_back_left");
}

function humvee_add_additional_parts_func(var0) {
  add_gunner_turret(var0);
}

function add_gunner_turret(var0) {
  var1 = spawnturret("misc_turret", var0 gettagorigin("tag_turret"), "tur_gun_decho_cp", 0);
  var1.angles = var0.angles;
  var1.team = "allies";
  var1 linkTo(var0);
  var1 setModel("veh8_civ_lnd_decho_rebel_mg_no_hatch");
  var1 setmode("sentry_offline");
  var1 setsentryowner(undefined);
  var1 makeunusable();
  var1 setdefaultdroppitch(0);
  var1 setturretmodechangewait(1);
  var0.gunner_turret = var1;
  var0.gunner_weapon = "tur_gun_decho_cp";
  thread clean_up_on_vehicle_death(var1, var1);
}

function get_friendly_hvi_vehicle_info(var0) {
  var1 = spawnStruct();
  var1.model = "veh8_civ_lnd_decho_rebel_2";
  var1.vehicle_gdt = "decho_physics_cp";
  var1.add_additional_parts_func = &friendly_hvi_vehicle_add_additional_parts_func;
  var1.ied_triggering_tags = ["tag_wheel_back_left", "tag_wheel_front_left", "tag_wheel_back_right", "tag_wheel_front_right"];
  var1.fake_health = 5000;
  var1.show_damage_state_health_ratio = 0.3;
  var1.classname_mp = "cp_decho_rebel";
  var1.slow_tread_vfx_trigger_speed = 1;
  var1.fast_tread_vfx_trigger_speed = 20;
  var1.tread_vfx_tags = ["tag_wheel_back_right", "tag_wheel_back_left", "tag_wheel_front_right", "tag_wheel_front_left"];
  var1.ref_128c0 = ["iw8_me_riotshield_mp"];
  var2 = [];
  GscBinSkip0(0x2e, "tag_wheel_back_left", "tag_wheel_center_back_left");
}

function friendly_hvi_vehicle_add_additional_parts_func(var0) {
  add_gunner_turret(var0);
}

function add_grenadier_anchor(var0) {
  var1 = -15;
  var2 = 0;
  var3 = 50;
  var4 = var0.angles;
  var5 = anglesToForward(var4);
  var6 = anglestoright(var4);
  var7 = anglestoup(var4);
  var8 = var0 gettagorigin("tag_origin");
  var9 = var8 + var5 * var1 + var6 * var2 + var7 * var3;
  var10 = spawn("script_model", var9);
  var10 setModel("tag_origin");
  var10 linkTo(var0);
  thread clean_up_on_vehicle_death(var10, var10);
  var0.grenadier_anchor = var10;
  var0.grenadier_weapon = "iw8_la_mike32_mp";
}

function remove_from_overwatch_target_group(var0) {
  if(isDefined(var0.target_marker_group_id)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var0, var0 getentitynumber(), var0.target_marker_group_id);
    return;
  }
}

function debug_setup_warp_jeep_to_players() {}

function debug_warp_jeep_to_player(var0) {
  var0 endon("disconnect");

  for(;;) {
    var0 waittill("warpjeeptome");

    if(self vehicle_isphysveh()) {
      var1 = getclosestpointonnavmesh(var0.origin);
      var1 += (0, 0, 50);
      var2 = (0, self.angles[1], 0);
      self vehicle_teleport(var1, var2);
    }

    wait 0.05;
  }
}

function ref_14222(var0) {
  var0 endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var1);
    update_driver_interaction_hint(var0);
  }
}

function ref_14223(var0) {
  var0 endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("player_disconnect");
    update_driver_interaction_hint(var0);
  }
}