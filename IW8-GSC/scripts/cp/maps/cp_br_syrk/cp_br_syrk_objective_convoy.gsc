/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_br_syrk\cp_br_syrk_objective_convoy.gsc
**********************************************************************/

function spawn_convoy_and_drive() {
  wait 0.1;
  get_proto_convoy_event();

  if(scripts\cp\cp_objectives_events::is_event_active(level.convoy_proto_event)) {
    return;
  }

  wait 0.05;
  level thread scripts\cp\cp_objectives_events::try_start_event(level.convoy_proto_event, "scripts/cp/maps/cp_br_syrk/cp_br_syrk_objectives_events2.csv", level.convoy_proto_index);
}

function objective_convoy_init(var0) {
  wait 0.05;
}

function objective_convoy_start(var0) {
  var1 = 0;

  if(!isDefined(level.wait_for_repeating_event) || !isDefined(level.wait_for_repeating_event[var0.ref].min_wait_between_repeat)) {
    var1 = 600;
  } else {
    var1 = level.wait_for_repeating_event[var0.ref].min_wait_between_repeat;
  }

  var1 = 99999;
  var2 = undefined;

  foreach(var4 in level.globalobjectives) {
    if(var4.objname == "objective_heli_down_start") {
      var2 = var4;
      break;
    }
  }

  if(getdvarint("scr_convoy_roam", 0) != 0) {
    set_proto_values(var0, var1);
    return;
  }

  var6 = "small";
  var7 = level scripts\cp\cp_convoy_manager::spawn_convoy_from_type("convoy1", var6, "helidown2", var2, var1, "objective_convoy_2");
  var7 endon("event_convoy_delete");
  var7 thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(0);
  var7 thread scripts\cp\cp_convoy_manager::allow_stealing_from_player_car(0);
  var7 thread scripts\cp\cp_convoy_manager::set_hide_icon_on_pickup_target(0);
  var7 thread scripts\cp\cp_convoy_manager::toggle_vo_on_hvt_pickup(1);
  var7 thread scripts\cp\cp_convoy_manager::toggle_vo_on_convoy_death(1);
  var7 thread scripts\cp\cp_convoy_manager::toggle_vo_on_nearby_convoy(1);
  var7 thread scripts\cp\cp_convoy_manager::toggle_vo_on_hvt_rescued(1);
  var7 thread scripts\cp\cp_convoy_manager::allow_recruiting_nearby_soldiers(1);
  var7 thread scripts\cp\cp_convoy_manager::allow_recruiting_juggernauts(1);
  var7 thread scripts\cp\cp_convoy_manager::set_recruiting_amount(8);
  var7 thread scripts\cp\cp_convoy_manager::set_recruiting_time_btwn(3);
  var7 thread scripts\cp\cp_convoy_manager::set_center_compromises(1);
  var7 thread scripts\cp\cp_convoy_manager::set_can_compromise_before_1st_target(1);
  var7 thread scripts\cp\cp_convoy_manager::allow_routing_to_backup_vehicles(0);
  var7 thread scripts\cp\cp_convoy_manager::allow_routing_to_backup_support_vehicles(1);
  var7 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(0);
  var7 thread scripts\cp\cp_convoy_manager::set_despawn_distance(7000);
  thread waittill_morales_ends_delete_trucks();
  wait var1 - 1;
}

function set_proto_values(var0, var1) {
  if(getdvarint("scr_convoy_roam", 0) == 0) {
    return;
  }

  var2 = get_far_away_startpath();
  var3 = get_proto_convoy_type();
  var4 = level.convoy_proto_event;
  var5 = level scripts\cp\cp_convoy_manager::spawn_convoy_from_type("convoy1", var3, var2, var0, var1, var4);
  var5 thread scripts\cp\cp_convoy_manager::set_objective_struct(var0);
  var5 thread scripts\cp\cp_convoy_manager::show_objective_icon(0);
  thread first_intro_text();
  wait 6;
  var5 thread scripts\cp\cp_convoy_manager::set_roaming(1);
  var5 thread scripts\cp\cp_convoy_manager::set_unload_at_target(0);
  var5 thread scripts\cp\cp_convoy_manager::set_healthdrain_on_lowhealth(10);
  var5 thread scripts\cp\cp_convoy_manager::set_attach_objective_icon(1, 220);
  var5 thread scripts\cp\cp_convoy_manager::show_health_on_objective_icon(1);

  if(var3 == "small-roaming") {
    var5 thread scripts\cp\cp_convoy_manager::attach_smuggler_loot("barrel", 4, 5);
    var5 thread scripts\cp\cp_convoy_manager::keep_smuggler_loot_on_death("barrel", 1, 1);
  } else if(var3 == "medium-roaming") {
    var5 thread scripts\cp\cp_convoy_manager::attach_smuggler_loot("barrel", 7, 7);
    var5 thread scripts\cp\cp_convoy_manager::keep_smuggler_loot_on_death("barrel", 2, 3);
  }

  var9 = var5 scripts\cp\cp_convoy_manager::get_smuggler_loot_amount(1);
  var10 = scripts\cp\cp_convoy_manager_code::get_nitrate_label(var9);
  var5 thread scripts\cp\cp_convoy_manager::set_objective_icon_label(var10);
  var5 thread scripts\cp\cp_convoy_manager::show_objective_icon(1);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_convoy_update_10", "allies", 1);
  var5 waittill("convoy_center_death");
  var5 scripts\engine\utility::ref_143b9(25, "convoy_all_loot_taken");
  var5 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var5 thread scripts\cp\cp_convoy_manager::set_despawn_distance(7000);
  thread reset_convoy_soon();
  thread convoy_end_this_event(level, var5);
}

function convoy_end_this_event(var0, var1) {
  var0 waittill("fully_removed");
  level scripts\cp\cp_objectives_events::stop_event(var1);
}

function get_far_away_startpath() {
  var0 = scripts\engine\utility::getStruct("convoy_start_helidown2", "targetname");
  var1 = scripts\engine\utility::getStruct("convoy_start_airport1", "targetname");
  var2 = scripts\engine\utility::getStruct("convoy_start_dam1", "targetname");
  var3 = scripts\engine\utility::getStruct("convoy_start_shipping1", "targetname");
  var4 = [];
  GscBinSkip0(0x2e, var4.size, var0);
}

function first_intro_text() {
  if(!isDefined(level.convoy_proto_text)) {
    level.convoy_proto_text = 1;
  } else {
    return;
  }

  wait 6;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/CONVOY_ROAMING");
}

function reset_convoy_soon() {
  wait 1;
  thread spawn_convoy_and_drive();
}

function get_proto_convoy_type() {
  if(!isDefined(level.convoy_proto_type)) {
    level.convoy_proto_type = 1;
  }

  if(level.convoy_proto_type == 1) {
    level.convoy_proto_type = 2;
    return "small-roaming";
  }

  if(level.convoy_proto_type == 2) {
    level.convoy_proto_type = 1;
    return "medium-roaming";
  }
}

function get_proto_convoy_event() {
  if(!isDefined(level.convoy_proto_event)) {
    level.convoy_proto_event = "objective_convoy_1";
    level.convoy_proto_index = "2";
  }

  if(level.convoy_proto_event == "objective_convoy_1") {
    level.convoy_proto_event = "objective_convoy_2";
    level.convoy_proto_index = "3";
    return;
  }

  if(level.convoy_proto_event == "objective_convoy_2") {
    level.convoy_proto_event = "objective_convoy_1";
    level.convoy_proto_index = "2";
    return;
  }
}

function convoy_go_to_helidown_location() {
  wait 1;

  if(getdvarint("scr_convoy_roam", 0) != 0) {
    return;
  }

  var0 = (6885.69, -8717.95, 440);
  var1 = (6897.75, -11041.2, 440);
  var2 = (6889.89, -12625.3, 440);
  var3 = [];
  var4 = set_convoy_path_from_helidown();
  var5 = (0, 0, 0);

  if(var4 == "helidown2") {
    var5 = (-10619.5, 14275, 511.782);
  } else if(var4 == "helidown3") {
    var3 = var0;
    var3 = var1;
    var3 = var2;
    var5 = (8948.84, -13110.5, 440);
  }

  level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_convoy_lookahead_dist(-200);
  wait 0.05;
  level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_convoy_target(var5, var3);
  level.all_convoys["convoy1"] waittill("convoy_arrived_at_dest");
  level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_unload_at_target(1);
  thread convoy_attempt_pickup();
}

function convoy_attempt_pickup() {
  level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_convoy_target("event_heli_downed_pilot");

  if(level.event_heli_type == "escort") {
    level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_recruiting_distance(8000);
    level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_recruiting_time_until(25);
    level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_recruited_goal_distance(2000);
    level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_soldier_pickup_to_origin(1);
  } else {
    level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_recruiting_distance(4000);
    level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_recruiting_time_until(12);
    level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_recruited_goal_distance(1000);
    level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::set_soldier_pickup_to_origin(0);
  }

  level.all_convoys["convoy1"] waittill("convoy_hvtent_set");
  var0 = level.all_convoys["convoy1"] scripts\cp\cp_convoy_manager::get_convoy_targeted_hvt();
  GscBinSkip4(0x6e, var0);
}

function set_convoy_path_from_helidown() {
  var0 = undefined;

  if(isDefined(level.last_helidown_loc)) {
    var1 = level.last_helidown_loc;
    var2 = var1.script_noteworthy;

    if(var2 == "loc_2") {
      var0 = "helidown2";
    } else if(var2 == "loc_3") {
      var0 = "helidown3";
    }
  } else if(getdvarint("scr_helidown_loc") > 0) {
    var3 = getdvarint("scr_helidown_loc");

    if(var3 == 2) {
      var0 = "helidown2";
    } else if(var3 == 3) {
      var0 = "helidown3";
    }
  } else if(getDvar("scr_escort_loc", "") != "") {
    var3 = getDvar("scr_escort_loc");
    var4 = strtok(var3, "_");
    var3 = var4[0];

    if(var3 == "2") {
      var0 = "helidown2";
    } else if(var3 == "3") {
      var0 = "helidown3";
    }
  }

  return var0;
}

function convoy_set_can_pickup_hvt() {
  if(!isDefined(self.tracking_time_to_pickup)) {
    self.tracking_time_to_pickup = 1;
  } else {
    return;
  }

  if(level.event_heli_type != "escort") {
    GscBinSkip4(0x35, "harness");
  }

  GscBinSkip4(0x35, "escort");
}

function convoy_set_helidown_pickup_hvt(var0) {
  if(var0 == "harness") {
    if(!isDefined(self.carried)) {
      level waittill("player_picked_up_hostage");
    }
  } else if(var0 == "escort") {
    if(!isDefined(self.followingplayer)) {
      self waittill("vip_used");
    }
  }

  wait 5;
  level thread scripts\cp\cp_convoy_manager::allow_picking_up_hvts(1);
  level thread scripts\cp\cp_convoy_manager::allow_stealing_from_player_car(1);
}

function convoy_send_out_after_hvt_onboard() {
  self waittill("convoy_exiting_after_pickup");
  thread scripts\cp\cp_convoy_manager::set_convoy_lookahead_dist(-1000);
  wait 0.05;
  var0 = (-4909.5, -9203.03, 576);
  thread scripts\cp\cp_convoy_manager::set_convoy_target(var0);
}

function waittill_morales_ends_delete_trucks() {
  level endon("game_ended");
  wait 10;
  level waittill("stop_helidown_event");
  level.all_convoys["convoy1"] scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  level.all_convoys["convoy1"] thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
  level thread scripts\cp\cp_objectives_events::stop_event("objective_convoy_2");
}