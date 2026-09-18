/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_cart.gsc
*********************************************/

transport_trigger_manager(param_00, param_01, param_02, param_03) {
  common_scripts\utility::func_3C9F(param_03);
  update_trigger_hints(param_01, param_02);
  var_04 = 0;
  var_05 = undefined;
  level.zmb_mine_cart_is_locked = 0;
  level thread watch_for_transport_requests(param_01, param_02);
  for(;;) {
    var_06 = next_transport_request();
    switch (var_06.var_7D18) {
      case "purchase":
        execute_station_leave(param_01, param_02, var_05, var_06.player);
        if(isDefined(var_05)) {
          var_05 = undefined;
        }
        break;

      case "call":
        execute_station_leave(param_01, param_02, var_06.var_819A);
        break;

      case "lockdown":
        if(isDefined(var_06.var_819A)) {
          execute_station_leave(param_01, param_02, var_06.var_819A);
        }

        level.zmb_mine_cart_is_locked = 1;
        foreach(var_08 in level.valid_island_cart_destinations) {
          maps / mp / mp_zombie_island_cart_station_functions::set_transport_light_states(var_08, "deactivated");
        }

        if(isDefined(var_06.script_flag_lock)) {
          var_05 = var_06.script_flag_lock;
        }

        update_trigger_hints(param_01, param_02, &"ZOMBIE_ISLAND_TRANSPORT_DISABLED");
        break;

      case "unlock":
        level.zmb_mine_cart_is_locked = 0;
        maps / mp / mp_zombie_island_cart_station_functions::set_transport_light_states(level.zmb_transport_system["current_station"], "ready");
        update_trigger_hints(param_01, param_02);
        break;
    }
  }
}

make_a_transport_request(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnStruct();
  var_05.player = param_00;
  var_05.var_9D65 = param_01;
  var_05.var_7D18 = param_02;
  var_05.var_819A = param_03;
  var_05.script_flag_lock = param_04;
  level.zmb_mine_cart_transport_requests = common_scripts\utility::func_F6F(level.zmb_mine_cart_transport_requests, var_05);
  level notify("new_transport_request", var_05);
}

wait_for_cart_finished_with_mid_route() {
  level.zmb_island_artillery_sled common_scripts\utility::func_379C("zmb_island_cart_path_mid_complete");
}

get_transport_finishes_flag() {
  return "transport complete";
}

main() {
  precacherumble("damage_heavy");
  level.zmb_mine_cart_transport_requests = [];
  common_scripts\utility::flag_init("any_minecart_used");
  common_scripts\utility::flag_init("transport complete");
  common_scripts\utility::flag_init("flag_exposed_secret_entrance");
  common_scripts\utility::flag_init("flag_found_pommel_door");
  lib_0557::func_4BC9("flag_found_pommel_door", undefined, undefined, 1);
  level.valid_island_cart_destinations = ["start_zone", "mining_corner", "sub_pens_1_zone"];
  level.island_cart_structs = common_scripts\utility::func_46B7("mine_cart_struct", "targetname");
  level.zmb_island_artillery_sled = undefined;
  initialize_pomel_exits();
  level thread run_upgrade_machine_pickups();
  foreach(var_01 in level.island_cart_structs) {
    var_01 init_cart_flags();
    var_01 initialize_this_cart();
  }

  var_03 = common_scripts\utility::func_46B7("mine_cart_lever", "targetname");
  foreach(var_05 in var_03) {
    var_05 initialize_lever();
    var_05 thread run_lever();
  }

  level thread handle_pomel_detor();
  level thread handle_pomel_exit();
  var_07 = "flag_aa_guns_powered_on";
  level.zmb_transport_system = [];
  level thread transport_trigger_manager(level.island_cart_structs, level.zmb_transport_activation_triggers, level.zmb_transport_call_triggers, var_07);
  initialize_first_location("mining_corner", var_07);
  level thread override_notetracks_for_cart();
}

override_notetracks_for_cart() {
  while(!isDefined(level.var_67D4)) {
    wait 0.05;
  }

  level.var_67D4["fadetoblack_"] = ::func_67AA;
  level.var_67D4["fadefromblack_"] = ::func_67A9;
}

func_67AA(param_00, param_01, param_02) {
  thread animscripts / notetracks_common::func_67AD(param_00, param_01, 1, players_have_abandoned_minecart_ride(param_02));
}

func_67A9(param_00, param_01, param_02) {
  thread animscripts / notetracks_common::func_67AD(param_00, param_01, 0, players_have_abandoned_minecart_ride(param_02));
}

players_have_abandoned_minecart_ride(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(!common_scripts\utility::func_562E(var_03.abandonedcarride)) {
      var_01 = common_scripts\utility::func_F6F(var_01, var_03);
    }
  }

  return var_01;
}

get_initial_dir() {
  var_00 = "left";
  switch (self.var_819A) {
    case "start_zone":
      var_00 = "left";
      break;

    case "mining_corner":
      var_00 = "left";
      break;

    case "sub_pens_1_zone":
      var_00 = "right";
      break;
  }

  return var_00;
}

initialize_sled_junction(param_00, param_01, param_02) {
  if(!isDefined(level.zmb_island_cart_junctions)) {
    level.zmb_island_cart_junctions = [];
  }

  level.zmb_island_cart_junctions[param_00 + param_01] = common_scripts\utility::func_46B5(param_02, "script_noteworthy");
  level.zmb_island_cart_junctions[param_01 + param_00] = common_scripts\utility::func_46B5(param_02, "script_noteworthy");
}

initialize_first_location(param_00, param_01) {
  var_02 = maps / mp / mp_zombie_island_cart_station_functions::get_all_carts_with(param_00);
  foreach(var_04 in level.island_cart_structs) {
    var_04.mine_cart_model hide();
  }

  level.zmb_island_artillery_sled = var_02[0].mine_cart_model;
  level.zmb_island_artillery_sled.dontdeleterevivespot = 1;
  level.zmb_island_artillery_sled show();
  level.zmb_island_artillery_sled common_scripts\utility::func_3799("zmb_island_cart_path_start_complete");
  level.zmb_island_artillery_sled common_scripts\utility::func_3799("zmb_island_cart_path_mid_complete");
  level.zmb_island_artillery_sled common_scripts\utility::func_3799("zmb_island_cart_path_end_complete");
  level thread set_first_location_ready(param_00, param_01);
}

set_first_location_ready(param_00, param_01) {
  set_trigger_hints(level.zmb_transport_activation_triggers, level.zmb_transport_call_triggers, &"ZOMBIES_REQUIRES_POWER", &"ZOMBIE_ISLAND_POWER_OBERLAND");
  common_scripts\utility::func_3C9F(param_01);
  maps / mp / mp_zombie_island_cart_station_functions::set_station_ready(param_00);
  maps / mp / mp_zombie_island_cart_station_functions::set_transport_light_states(param_00, "ready");
  level.zmb_transport_system["current_station"] = param_00;
  set_triggers(level.zmb_transport_activation_triggers, level.zmb_transport_call_triggers);
}

set_player_arrival_offset(param_00, param_01, param_02, param_03, param_04) {
  var_05 = vectorNormalize(anglestoright(self.angles));
  var_06 = vectorNormalize(anglesToForward(self.angles));
  var_07 = vectorNormalize(anglestoup(self.angles));
  var_08 = [];
  var_09 = [];
  switch (param_01) {
    case "front":
      var_09 = self.player_offsets_front;
      break;

    case "back":
      var_09 = self.player_offsets_back;
      break;
  }

  foreach(var_0B in var_09) {
    var_0C = var_05 * var_0B[0];
    var_0D = var_06 * var_0B[1];
    var_0E = var_07 * var_0B[2];
    var_08 = common_scripts\utility::func_F6F(var_08, self.origin + var_0C + var_0D + var_0E);
  }

  foreach(var_11 in param_00) {
    var_12 = undefined;
    var_13 = 99999999;
    foreach(var_15 in var_08) {
      var_16 = distance(var_15, var_11.origin);
      if(var_16 < var_13) {
        var_12 = var_15;
        var_13 = var_16;
      }
    }

    var_11 unlink();
    var_11 setOrigin(var_12);
    var_11 playerlinkTo(self);
    var_11 setplayerangles(param_02);
    var_11.haspommelflushed = 1;
    if(!common_scripts\utility::func_562E(var_11.oncartride)) {
      var_11 thread attach_to_cart(param_03, param_04, lib_0547::func_429D(var_11));
    }

    var_08 = common_scripts\utility::func_F93(var_08, var_12);
  }
}

run_upgrade_machine_pickups() {
  var_00 = common_scripts\utility::func_46B7("zmb_pap_fuse_pickup", "targetname");
  level.zmb_pap_fuse_pickups = var_00;
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.target, "targetname");
    foreach(var_05 in var_03) {
      switch (var_05.script_noteworthy) {
        case "zmb_pap_fuse_pickup_trigger":
          var_02.zmb_pap_fuse_pickup_trigger = var_05;
          break;

        case "zmb_pap_fuse_pickup_model":
          var_02.zmb_pap_fuse_pickup_model = var_05;
          break;
      }
    }

    var_02 thread give_upgrade_fuse();
  }
}

give_upgrade_fuse() {
  self.zmb_pap_fuse_pickup_trigger setHintString(&"ZOMBIE_ISLAND_GRAB_PAP_POWER");
  self.zmb_pap_fuse_pickup_trigger waittill("trigger", var_00);
  var_00 thread lib_0367::func_8E3C("papcircuitpickup");
  self.zmb_pap_fuse_pickup_trigger delete();
  self.zmb_pap_fuse_pickup_model delete();
  maps / mp / mp_zombie_island_ee_pack_a_punch_unlock::add_player_fuse_count();
}

run_cart_depart(param_00, param_01, param_02) {
  foreach(var_04 in level.island_cart_structs) {
    if(var_04.var_819A != param_00) {
      continue;
    }

    var_04 thread leave_station(param_01, param_02);
  }
}

leave_station(param_00, param_01) {
  var_02 = undefined;
  for(var_03 = 0; var_03 < 2; var_03++) {
    if(var_03 == 0) {
      if(isDefined(param_00)) {
        var_02 = get_random_destination([get_dest_by_flag(param_00)]);
        if(isDefined(var_02)) {
          break;
        }
      } else {
        var_02 = get_random_destination([self.possible_dests[self.forced_index]]);
        if(isDefined(var_02)) {
          break;
        }
      }
    }

    if(var_03 == 1) {
      var_02 = get_random_destination(self.possible_dests);
      if(isDefined(var_02)) {
        break;
      }
    }
  }

  if(isDefined(var_02)) {
    thread do_cart_path(var_02, isDefined(param_00));
    attach_players_to_transport(self, var_02, param_01);
    return;
  }

  common_scripts\utility::flag_set("transport complete");
}

attach_players_to_transport(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < level.players.size; var_03++) {
    var_04 = isDefined(param_02) && level.players[var_03] == param_02;
    if(level.players[var_03] istouching(self.zmb_island_cart_touch_detection)) {
      level.players[var_03] thread attach_to_cart(self, param_01, var_03);
      level.players[var_03] thread zmb_events_report_player_on_cart();
      continue;
    }

    if(level.players[var_03] istouching(self.secondary_player_cart_volume) || var_04) {
      level.zmb_island_artillery_sled set_player_arrival_offset([level.players[var_03]], get_player_offset_for(param_00), level.players[var_03].angles, param_00, param_01);
      level.players[var_03] thread attach_to_cart(self, param_01, var_03);
      level.players[var_03] thread zmb_events_report_player_on_cart();
    }
  }
}

zmb_events_report_player_on_cart() {
  var_00 = self;
  if(isDefined(level.zmb_events_player_rode_minecart)) {
    var_00 thread[[level.zmb_events_player_rode_minecart]]();
  }
}

handle_pomel_exit() {
  var_00 = getEnt("pomel_room_exit_whirlpool", "targetname");
  var_00 setHintString(&"ZOMBIE_ISLAND_POMEL_EXIT");
  var_01 = common_scripts\utility::func_46B7("pomel_exit_launcher", "targetname");
  var_00 thread disable_on_usable_touching();
  for(;;) {
    var_00 waittill("trigger", var_02);
    if(common_scripts\utility::func_562E(var_02.isflushing) || assassin_worshipers_alive()) {
      continue;
    }

    var_02.isflushing = 1;
    var_02 thread run_pomel_exit(var_01);
  }
}

disable_on_usable_touching() {
  for(;;) {
    var_00 = 0;
    var_01 = getEntArray("baby_statue_spawn", "targetname");
    foreach(var_03 in var_01) {
      if(distance2d(var_03.origin, self.origin) < 70 && self.origin[2] < var_03.origin[2] + 64) {
        var_00 = 1;
      }
    }

    if(var_00) {
      common_scripts\utility::func_9D9F();
    } else {
      common_scripts\utility::func_9DA3();
    }

    wait(0.125);
  }
}

assassin_worshipers_alive() {
  var_00 = lib_0547::func_408F();
  foreach(var_02 in var_00) {
    if(common_scripts\utility::func_562E(var_02.assassin_prayer)) {
      return 1;
    }
  }

  return 0;
}

run_pomel_exit(param_00) {
  lib_0378::func_8D74("pagen_room_flush_begin");
  level thread common_scripts\_exploder::func_88E(216, [self]);
  wait(0.4);
  pomel_launch(common_scripts\utility::random(param_00));
  self.isflushing = 0;
  respawn_pommel_room_zombies_if_player_vacant();
}

respawn_pommel_room_zombies_if_player_vacant() {
  if(!maps / mp / zombies / zombie_assassin_spawner_logic::everyone_in_pommel_room(1, 1)) {
    var_00 = lib_0547::func_408F();
    foreach(var_02 in var_00) {
      if(var_02 maps / mp / mp_zombie_island::agent_is_in_secret_room(1)) {
        if(!common_scripts\utility::func_562E(var_02.wasteleported)) {
          var_02 lib_056D::func_5A86();
        }
      }
    }
  }
}

pomel_launch(param_00) {
  var_01 = 195;
  var_02 = distance(param_00.vec_point_1, param_00.vec_point_2) / var_01;
  var_03 = vectorNormalize(param_00.vec_point_2 - param_00.vec_point_1);
  thread animscripts / notetracks_common::func_30B4(var_02 / 2);
  wait(var_02 / 2);
  wait 0.05;
  self setOrigin(param_00.vec_point_1);
  var_04 = spawn("script_model", self.origin);
  var_04 moveTo(param_00.vec_point_2, var_02);
  self setplayerangles(vectortoangles(param_00.vec_point_2 - param_00.vec_point_1));
  self playerlinkTo(var_04);
  maps / mp / mp_zombie_island_fog_zones::set_should_restore_fog_vision_isolated_room();
  thread animscripts / notetracks_common::do_fade_from_black(var_02 / 2);
  wait(var_02);
  lib_0378::func_8D74("pagen_room_flush_end");
  self unlink();
  self setvelocity(var_01 * var_03);
}

initialize_pomel_exits() {
  var_00 = common_scripts\utility::func_46B7("pomel_exit_launcher", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.target, "targetname");
    foreach(var_05 in var_03) {
      switch (var_05.script_noteworthy) {
        case "pomel_point_1":
          var_02.vec_point_1 = var_05.origin;
          break;

        case "pomel_point_2":
          var_02.vec_point_2 = var_05.origin;
          break;
      }
    }
  }
}

handle_pomel_detor() {
  var_00 = common_scripts\utility::func_46B7("zmb_island_secret_rock_exit_struct", "targetname");
  foreach(var_02 in var_00) {
    common_scripts\utility::flag_init(var_02.var_819A + "_bomb_placed");
    if(!common_scripts\utility::func_3C83(var_02.var_819A + "_bomb_detonated")) {
      common_scripts\utility::flag_init(var_02.var_819A + "_bomb_detonated");
    }

    var_03 = common_scripts\utility::func_44BE(var_02.target, "targetname");
    var_02.rock_blockers = [];
    foreach(var_05 in var_03) {
      switch (var_05.script_noteworthy) {
        case "rock_blockers":
          var_02.rock_blockers = common_scripts\utility::func_F6F(var_02.rock_blockers, var_05);
          break;

        case "zmb_secret_tunnel_bomb_place":
          var_02.bomb_placement = var_05;
          break;

        case "zmb_secret_exit_trigger":
          var_02.bomb_trigger = var_05;
          break;
      }
    }

    var_07 = common_scripts\utility::func_46B5("island_secret_tunnel_debris", "targetname");
    var_03 = common_scripts\utility::func_44BE(var_07.target, "targetname");
    var_02.wall_pieces = [];
    foreach(var_05 in var_03) {
      switch (var_05.script_noteworthy) {
        case "pomel_wall":
          var_02.wall_pieces = common_scripts\utility::func_F6F(var_02.wall_pieces, var_05);
          break;
      }
    }

    var_02 thread run_pomel_door_explosion();
  }
}

run_pomel_door_explosion() {
  thread wait_for_bomber_explosion();
  common_scripts\utility::func_3C9F(self.var_819A + "_bomb_detonated");
  level thread common_scripts\_exploder::func_88E(220);
  common_scripts\utility::flag_set("flag_exposed_secret_entrance");
  set_bomb_exploded();
  var_00 = spawnStruct();
  var_00.unlink_spawns = common_scripts\utility::func_46B7("zmb_isolated_room_spawns", "targetname");
  for(;;) {
    self.bomb_trigger waittill("trigger", var_01);
    if(common_scripts\utility::func_562E(level.zmb_island_pommel_detor_blocked)) {
      continue;
    }

    if(!common_scripts\utility::func_3C77("flag_found_pommel_door")) {
      maps\mp\_utility::func_2CED(1.4, ::common_scripts\utility::flag_set, "flag_found_pommel_door");
    }

    level thread try_to_snag_players_from_cart(var_00);
  }
}

try_to_snag_players_from_cart(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < 3; var_02++) {
    foreach(var_04 in level.players) {
      if(common_scripts\utility::func_562E(var_04.oncartride) && !common_scripts\utility::func_562E(var_04.isenteringpommelroom) && var_04 useButtonPressed() || var_01) {
        var_04 thread handle_pomel_room_enter(param_00);
      }
    }

    wait 0.05;
  }
}

handle_pomel_room_enter(param_00) {
  self endon("disconnect");
  self.abandonedcarride = 1;
  self.isenteringpommelroom = 1;
  self notify("enter_pomel");
  var_01 = common_scripts\utility::func_46B5("zmb_island_secret_teleport_gravity_struct", "targetname");
  var_02 = 335;
  var_03 = distance(self.origin, var_01.origin) / var_02;
  var_04 = vectorNormalize(self.origin - var_01.origin);
  thread animscripts / notetracks_common::func_30B4(var_03 / 2);
  var_05 = spawn("script_model", self.origin);
  var_05 moveTo(var_01.origin, var_03);
  var_05.angles = self.angles;
  self setplayerangles(vectortoangles(var_01.origin - self.origin));
  self playerlinkTo(var_05);
  var_05 rotateTo(vectortoangles(var_01.origin - var_05.origin), var_03 / 1.1);
  wait(var_03 / 2);
  thread animscripts / notetracks_common::do_fade_from_black(var_03 / 2);
  self setplayerangles((self.angles[0], self.angles[1] + 180, self.angles[2]));
  thread cancel_screen_fade();
  set_has_left_cart(param_00, 0);
  wait(var_03);
  self unlink();
  self.isenteringpommelroom = 0;
  childthread killzombiesonisland();
}

killzombiesonisland() {
  wait(0.25);
  if(maps / mp / zombies / zombie_assassin_spawner_logic::everyone_in_pommel_room(0, 1)) {
    var_00 = lib_0547::func_408F();
    foreach(var_02 in var_00) {
      if(!lib_055A::func_AC29(var_02, "isolated_room_zone") && !lib_055A::func_AC29(var_02, "isolated_room_entry_zone")) {
        var_02 lib_056D::func_5A86();
      }
    }
  }
}

cancel_screen_fade() {
  self endon("death");
  self endon("disconnect");
  self waittill("do_fade_to_black");
  self notify("do_fade_to_black");
  wait 0.05;
  if(isDefined(self.var_6772)) {
    self.var_6772 destroy();
  }
}

wait_for_bomber_explosion() {
  var_00 = 256;
  var_01 = 999;
  var_02 = common_scripts\utility::func_46B5("zmb_island_secret_rock_exit_struct", "targetname");
  while(var_01 > var_00) {
    level waittill("objective_zombie_exploder_detonation", var_03);
    var_01 = distance(var_03, var_02.origin);
  }

  common_scripts\utility::flag_set(self.var_819A + "_bomb_detonated");
}

set_bomb_exploded(param_00) {
  if(isDefined(param_00)) {
    param_00 delete();
  }

  foreach(var_02 in self.wall_pieces) {
    var_02 delete();
  }
}

set_bomb_placed() {
  var_00 = spawn("script_model", self.bomb_placement.origin);
  var_00 setModel("zom_bomb");
  var_00 setCanDamage(1);
  return var_00;
}

wait_for_bomb_placement() {
  self.bomb_trigger waittill("trigger", var_00);
  common_scripts\utility::flag_set(self.var_819A + "_bomb_placed");
}

wait_for_bomb_detonate(param_00) {
  param_00 waittill("damage");
  common_scripts\utility::flag_set(self.var_819A + "_bomb_detonated");
}

initialize_lever() {
  var_00 = common_scripts\utility::func_44BE(self.target, "targetname");
  foreach(var_02 in var_00) {
    switch (var_02.script_noteworthy) {
      case "mine_cart_lever_trig":
        self.lever_trig = var_02;
        break;

      case "zmi_mine_cart_switch":
        self.lever_model = var_02;
        break;
    }
  }

  self.lever_model set_level_model(self.var_819A);
  connect_to_transport();
}

set_level_model(param_00) {
  self hidepart("breach_trench");
  self hidepart("subpen_breach");
  self hidepart("trench_subpen");
  switch (param_00) {
    case "start_zone":
      self showpart("trench_subpen");
      break;

    case "mining_corner":
      self showpart("subpen_breach");
      break;

    case "sub_pens_1_zone":
      self showpart("breach_trench");
      break;
  }
}

connect_to_transport() {
  foreach(var_01 in level.island_cart_structs) {
    if(self.var_819A == var_01.var_819A) {
      self.mytransport = var_01;
    }
  }
}

run_lever() {
  var_00 = get_initial_dir();
  self.mytransport.forced_index++;
  self.lever_trig setHintString(&"ZOMBIE_ISLAND_TRANSPORT_TOGGLE");
  for(;;) {
    self.lever_model toggle_lever(var_00);
    self.mytransport toggle_destination();
    var_00 = common_scripts\utility::func_98E7(var_00 == "left", "right", "left");
    self.lever_trig common_scripts\utility::func_9DA3();
    self.lever_trig waittill("trigger", var_01);
    self.lever_trig common_scripts\utility::func_9D9F();
  }
}

toggle_lever(param_00) {
  var_01 = [];
  var_01["s2_zom_minecart_switch_pos1_2_pos2"] = % s2_zom_minecart_switch_pos1_2_pos2;
  var_01["s2_zom_minecart_switch_pos2_2_pos1"] = % s2_zom_minecart_switch_pos2_2_pos1;
  var_01["s2_zom_minecart_switch_pos1_idle"] = % s2_zom_minecart_switch_pos1_idle;
  var_01["s2_zom_minecart_switch_pos2_idle"] = % s2_zom_minecart_switch_pos2_idle;
  var_02 = "";
  var_03 = "";
  switch (param_00) {
    case "left":
      var_02 = "s2_zom_minecart_switch_pos2_2_pos1";
      var_03 = "s2_zom_minecart_switch_pos1_idle";
      break;

    case "right":
      var_02 = "s2_zom_minecart_switch_pos1_2_pos2";
      var_03 = "s2_zom_minecart_switch_pos2_idle";
      break;
  }

  self scriptmodelplayanim(var_02);
  lib_0378::func_8D74("mine_cart_lever");
  wait(getanimlength(var_01[var_02]));
  self scriptmodelplayanim(var_03);
}

do_spider() {
  var_00 = getEnt(self.target, "targetname");
  var_01 = getEnt(var_00.target, "targetname");
  var_02 = getEnt(var_01.target, "targetname");
  var_03 = getEnt(var_02.target, "targetname");
  var_04 = [var_00, var_02];
  var_01 linktosynchronizedparent(var_00);
  var_02 linktosynchronizedparent(var_01);
  var_03 linktosynchronizedparent(var_02);
  if(isDefined(var_03.target)) {
    var_05 = getEnt(var_03.target, "targetname");
    var_05 linktosynchronizedparent(var_03);
  }

  wait(randomfloat(3));
  for(;;) {
    var_06 = common_scripts\utility::random(var_04);
    var_06 rotateroll(30, 0.25);
    wait(0.3);
    var_06 rotateroll(-30, 0.25);
    wait(0.3);
  }
}

toggle_destination() {
  self.forced_index++;
  if(self.forced_index >= self.possible_dests.size) {
    self.forced_index = 0;
  }
}

spawn_a_mine_cart(param_00, param_01) {
  var_02 = spawnhelicopter(param_00, param_01, "ger_bomber_stuka_hub", "zmi_mine_cart_01");
  return var_02;
}

wait_for_tranport_request() {
  self waittill("new_transport_request", var_00);
  return var_00;
}

execute_next_transport_request() {
  var_00 = level.zmb_mine_cart_transport_requests[0];
  return var_00;
}

update_trigger_hints(param_00, param_01, param_02, param_03) {
  set_triggers(param_00, param_01, level.zmb_transport_system["current_station"]);
  set_trigger_hints(param_00, param_01, param_02, param_03);
}

disable_transport_triggers(param_00, param_01) {
  set_triggers(param_00, param_01);
}

execute_station_leave(param_00, param_01, param_02, param_03) {
  if(common_scripts\utility::func_562E(level.zmb_mine_cart_is_locked)) {
    return;
  }

  if(lib_0547::func_5565(param_02, level.zmb_transport_system["current_station"])) {
    return;
  }

  level.zmb_mine_cart_is_locked = 1;
  if(isDefined(level.mine_cart_notification)) {
    level notify(level.mine_cart_notification);
  }

  disable_transport_triggers(param_00, param_01);
  run_cart_depart(level.zmb_transport_system["current_station"], param_02, param_03);
  wait_for_transport_done();
  update_trigger_hints(param_00, param_01, &"ZOMBIE_ISLAND_TRANSPORT_DISABLED");
  wait(7.5);
  maps / mp / mp_zombie_island_cart_station_functions::set_transport_light_states(param_02, "deactivated", level.zmb_transport_system["current_station"], "ready");
  update_trigger_hints(param_00, param_01);
  level.zmb_mine_cart_is_locked = 0;
}

next_transport_request() {
  if(level.zmb_mine_cart_transport_requests.size == 0) {
    var_00 = wait_for_tranport_request();
  } else {
    var_00 = execute_next_transport_request();
  }

  level.zmb_mine_cart_transport_requests = common_scripts\utility::func_F93(level.zmb_mine_cart_transport_requests, var_00);
  return var_00;
}

wait_for_transport_done() {
  common_scripts\utility::func_3C9F("transport complete");
  common_scripts\utility::func_3C7B("transport complete");
}

set_trigger_hints(param_00, param_01, param_02, param_03) {
  foreach(var_05 in common_scripts\utility::func_F73(param_00, param_01)) {
    if(isDefined(param_02)) {
      var_05 setHintString(param_02);
    } else if(common_scripts\utility::func_562E(level.free_cart_rides)) {
      var_05 setHintString(var_05.transporthintfree);
    } else {
      var_05 setHintString(var_05.transporthint);
    }

    if(isDefined(param_03)) {
      var_05 setsecondaryhintstring(param_03);
      continue;
    }

    var_05 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
  }
}

set_triggers(param_00, param_01, param_02) {
  foreach(var_04 in param_00) {
    if(!isDefined(param_02)) {
      var_04 common_scripts\utility::func_9D9F();
      continue;
    }

    if(lib_0547::func_5565(var_04.var_819A, param_02)) {
      var_04 common_scripts\utility::func_9DA3();
      continue;
    }

    var_04 common_scripts\utility::func_9D9F();
  }

  foreach(var_04 in param_01) {
    if(!isDefined(param_02)) {
      var_04 common_scripts\utility::func_9D9F();
      continue;
    }

    if(!isDefined(param_02) || lib_0547::func_5565(var_04.var_819A, param_02)) {
      var_04 common_scripts\utility::func_9D9F();
      continue;
    }

    var_04 common_scripts\utility::func_9DA3();
  }
}

get_trigger_for_station(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_00) {
    if(lib_0547::func_5565(var_04.var_819A, param_01)) {
      var_02 = common_scripts\utility::func_F6F(var_02, var_04);
    }
  }

  return var_02;
}

watch_for_transport_requests(param_00, param_01) {
  common_scripts\utility::array_thread(param_00, ::watch_for_interact, 1);
  common_scripts\utility::array_thread(param_01, ::watch_for_interact, 0);
  for(;;) {
    level waittill("transport_trigger_interact", var_02, var_03, var_04);
    if(common_scripts\utility::func_562E(level.zmb_mine_cart_is_locked)) {
      continue;
    }

    if(var_04 && !var_02 transport_purchase_successful(var_03)) {
      continue;
    } else {
      make_a_transport_request(var_02, var_03, common_scripts\utility::func_98E7(var_04, "purchase", "call"), var_03.var_819A);
    }
  }
}

watch_for_interact(param_00) {
  if(common_scripts\utility::func_562E(param_00)) {
    self.var_267B = 250;
  }

  for(;;) {
    self waittill("trigger", var_01);
    level notify("transport_trigger_interact", var_01, self, param_00);
  }
}

transport_purchase_successful(param_00) {
  if(common_scripts\utility::func_562E(level.free_cart_rides)) {
    return 1;
  }

  if(!maps / mp / gametypes / zombies::func_11C2(param_00.var_267B)) {
    thread lib_054E::func_695("needmoney");
    return 0;
  }

  return 1;
}

initialize_this_cart() {
  self.unlink_spawns = [];
  self.preview_models = [];
  self.mine_cart_start = getvehiclenode(self.target, "targetname");
  var_00 = common_scripts\utility::func_44BE(self.target, "targetname");
  self.zmb_mine_cart_gate_left_near = [];
  self.zmb_mine_cart_gate_right_near = [];
  self.zmb_mine_cart_gate_left_far = [];
  self.zmb_mine_cart_gate_right_far = [];
  self.zmb_mine_cart_gate_left_dest = [];
  self.zmb_mine_cart_gate_right_dest = [];
  self.zmb_mine_cart_path_blocker = [];
  self.transport_system_offsets_front = [];
  self.transport_system_offsets_back = [];
  self.var_ABFE = [];
  self.zmb_transport_zombie_waiting_points = [];
  self.info_trigs = [];
  foreach(var_02 in var_00) {
    switch (var_02.script_noteworthy) {
      case "secondary_player_cart_volume":
        self.secondary_player_cart_volume = var_02;
        break;

      case "scripted_node":
        self.var_830E = var_02;
        break;

      case "indicator_light":
        self.indicator_light = var_02;
        add_a_transport_indicator_light(self.indicator_light, self.var_819A);
        break;

      case "arrival_angles":
        self.arrival_angles = var_02;
        break;

      case "zombie_spawner":
        self.var_ABFE = common_scripts\utility::func_F6F(self.var_ABFE, var_02);
        break;

      case "transport_system_offsets_front":
        self.transport_system_offsets_front = common_scripts\utility::func_F6F(self.transport_system_offsets_front, var_02);
        break;

      case "transport_system_offsets_back":
        self.transport_system_offsets_back = common_scripts\utility::func_F6F(self.transport_system_offsets_back, var_02);
        break;

      case "zmb_transport_zombie_waiting_point":
        self.zmb_transport_zombie_waiting_points = common_scripts\utility::func_F6F(self.zmb_transport_zombie_waiting_points, var_02);
        break;

      case "zmb_mine_cart_gate":
        self.zmb_mine_cart_gates[var_02.var_8140] = var_02;
        self.zmb_mine_cart_gates[var_02.var_8140].prevstate = 0;
        break;

      case "zmb_cart_path_blocker":
        self.zmb_mine_cart_path_blocker[var_02.var_8140] = var_02;
        break;

      case "mine_cart_model_struct":
        self.mine_cart_model_struct = var_02;
        break;

      case "mine_cart_model_extension_struct":
        self.mine_cart_model_extension_struct = var_02;
        break;

      case "mine_cart_trigger":
        self.var_9D65 = var_02;
        self.var_9D65 common_scripts\utility::func_9D9F();
        self.var_9D65.transporthint = &"ZOMBIE_ISLAND_ACTIVATE_CART";
        self.var_9D65.transporthintfree = &"ZOMBIE_ISLAND_ACTIVATE_CART_FREE";
        break;

      case "zmi_mine_cart_info_trig":
        self.info_trigs = common_scripts\utility::func_F6F(self.info_trigs, var_02);
        var_02.transporthint = &"ZOMBIE_ISLAND_SUMMON_CART";
        var_02.transporthintfree = &"ZOMBIE_ISLAND_SUMMON_CART";
        break;

      case "third_person_preview":
        self.preview_models = common_scripts\utility::func_F6F(self.preview_models, var_02);
        break;

      case "mine_cart_unlink_spawn":
        self.unlink_spawns = common_scripts\utility::func_F6F(self.unlink_spawns, var_02);
        break;

      case "zmb_island_dropoff_z_height":
        self.zmb_island_dropoff_z_height = var_02;
        break;

      case "zmb_island_cart_touch_detection":
        self.zmb_island_cart_touch_detection = var_02;
        break;
    }
  }

  self.player_offsets_front = [];
  foreach(var_05 in self.transport_system_offsets_front) {
    var_06 = var_05.origin[0] - self.mine_cart_model_struct.origin[0];
    var_07 = var_05.origin[1] - self.mine_cart_model_struct.origin[1];
    var_08 = var_05.origin[2] - self.mine_cart_model_struct.origin[2];
    self.player_offsets_front = common_scripts\utility::func_F6F(self.player_offsets_front, (var_06, var_07, var_08));
  }

  self.player_offsets_back = [];
  foreach(var_05 in self.transport_system_offsets_back) {
    var_06 = var_05.origin[0] - self.mine_cart_model_struct.origin[0];
    var_07 = var_05.origin[1] - self.mine_cart_model_struct.origin[1];
    var_08 = var_05.origin[2] - self.mine_cart_model_struct.origin[2];
    self.player_offsets_back = common_scripts\utility::func_F6F(self.player_offsets_back, (var_06, var_07, var_08));
  }

  self.var_9D65.var_819A = self.var_819A;
  foreach(var_0D in self.info_trigs) {
    var_0D.var_819A = self.var_819A;
  }

  if(!isDefined(level.zmb_transport_activation_triggers)) {
    level.zmb_transport_activation_triggers = [];
  }

  if(!isDefined(level.zmb_transport_call_triggers)) {
    level.zmb_transport_call_triggers = [];
  }

  level.zmb_transport_activation_triggers = common_scripts\utility::func_F6F(level.zmb_transport_activation_triggers, self.var_9D65);
  level.zmb_transport_call_triggers = common_scripts\utility::func_F73(level.zmb_transport_call_triggers, self.info_trigs);
  initialize_my_door();
  var_0F = self.mine_cart_model_struct.origin;
  var_10 = self.mine_cart_model_struct.angles;
  if(!isDefined(var_10)) {
    var_10 = (0, 0, 0);
  }

  self.mine_cart_model = spawn("script_model", var_0F);
  self.mine_cart_model setModel("zmi_mine_cart_01");
  self.mine_cart_model.angles = var_10;
  self.mine_cart_model.player_offsets_front = self.player_offsets_front;
  self.mine_cart_model.player_offsets_back = self.player_offsets_back;
  thread activate_after(self.var_819A);
  initialize_possible_destinations();
  self.forced_index = 0;
}

add_a_transport_indicator_light(param_00, param_01) {
  if(!isDefined(level.transport_light_indicators)) {
    level.transport_light_indicators = [];
  }

  var_02 = spawnStruct();
  var_02.light_model = param_00;
  var_02.transport_flag = param_01;
  level.transport_light_indicators = common_scripts\utility::func_F6F(level.transport_light_indicators, var_02);
}

initialize_my_door() {
  if(!isDefined(self.zmb_mine_cart_gate_left_near)) {}
}

initialize_possible_destinations() {
  self.possible_dests = [];
  foreach(var_01 in level.island_cart_structs) {
    if(var_01 != self && common_scripts\utility::func_F79(level.valid_island_cart_destinations, var_01.var_819A)) {
      self.possible_dests = common_scripts\utility::func_F6F(self.possible_dests, var_01);
    }
  }
}

get_dest_by_flag(param_00) {
  foreach(var_02 in self.possible_dests) {
    if(lib_0547::func_5565(var_02.var_819A, param_00)) {
      return var_02;
    }
  }
}

attach_to_cart(param_00, param_01, param_02) {
  if(self getcurrentprimaryweapon() == "stone_baby_zm") {
    self method_8113(1);
  }

  self setstance("crouch");
  self method_8112(0);
  self playerlinkTo(level.zmb_island_artillery_sled);
  self.oncartride = 1;
  self.ignoreme = 1;
  common_scripts\utility::flag_set("any_minecart_used");
  self endon("enter_pomel");
  param_00 waittill("transport complete");
  set_has_left_cart(param_01, param_02);
}

set_has_left_cart(param_00, param_01) {
  self method_8112(1);
  self setstance("stand");
  if(self getcurrentprimaryweapon() == "stone_baby_zm") {
    self method_8113(0);
  }

  self.ignoreme = 0;
  self.oncartride = 0;
  self unlink();
  if(isDefined(param_00.zmb_island_dropoff_z_height)) {
    self setOrigin((self.origin[0], self.origin[1], param_00.zmb_island_dropoff_z_height.origin[2] + 1));
    return;
  }

  self setOrigin(param_00.unlink_spawns[param_01].origin);
}

do_cart_path(param_00, param_01) {
  var_02 = (0, 0, 24);
  var_03 = (0, 0, 0);
  maps / mp / mp_zombie_island_cart_station_functions::set_station_leaving(self.var_819A);
  maps / mp / mp_zombie_island_cart_station_functions::set_transport_light_states(self.var_819A, "deactivated", param_00.var_819A, "arriving");
  if(common_scripts\utility::func_562E(param_01)) {
    maps / mp / mp_zombie_island_cart_station_functions::set_station_arriving(param_00.var_819A);
  }

  wait(0.95);
  level.zmb_island_artillery_sled thread set_cart_path(self, param_00, param_01);
  wait(1.75);
  maps / mp / mp_zombie_island_cart_station_functions::set_station_closed(self.var_819A);
  level.zmb_island_artillery_sled common_scripts\utility::func_379C("zmb_island_cart_path_start_complete");
  level.zmb_island_artillery_sled common_scripts\utility::func_379C("zmb_island_cart_path_mid_complete");
  if(!param_01) {
    var_04 = 0;
    foreach(var_06 in level.players) {
      if(!isalive(var_06)) {
        continue;
      }

      if(common_scripts\utility::func_562E(var_06.var_5728)) {
        continue;
      }

      if(!common_scripts\utility::func_562E(var_06.oncartride)) {
        continue;
      }

      var_04++;
    }

    if(var_04 == level.players.size) {
      param_00 move_zombies_to_destination();
    }
  }

  maps / mp / mp_zombie_island_cart_station_functions::set_station_arriving(param_00.var_819A);
  level.zmb_island_artillery_sled common_scripts\utility::func_379C("zmb_island_cart_path_end_complete");
  maps / mp / mp_zombie_island_cart_station_functions::set_station_ready(param_00.var_819A);
  level.zmb_transport_system["current_station"] = param_00.var_819A;
  common_scripts\utility::flag_set("transport complete");
  self notify("transport complete");
  level.zmb_island_artillery_sled notify("arrived at " + param_00.var_819A);
  maps / mp / mp_zombie_island_cart_station_functions::set_transport_light_states(self.var_819A, "deactivated", param_00.var_819A, "deactivated");
  respawn_pommel_room_zombies_if_player_vacant();
}

move_zombies_to_destination() {
  var_00 = lib_0547::func_408F();
  var_01 = 3 + randomint(self.zmb_transport_zombie_waiting_points.size);
  var_02 = 0;
  foreach(var_04 in self.zmb_transport_zombie_waiting_points) {
    if(var_01 <= 0) {
      return;
    }

    if(var_02 >= var_00.size) {
      return;
    }

    if(!isDefined(var_00[var_02])) {
      continue;
    }

    if(!lib_0547::func_5565(var_00[var_02].var_A4B, "zombie_generic")) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_00[var_02].var_2FDA)) {
      continue;
    }

    if(lib_0547::func_5565(var_00[var_02].var_BA4, "traverse")) {
      continue;
    }

    var_01--;
    var_00[var_02] setOrigin(getclosestpointonnavmesh(var_04.origin, var_00[var_02]));
    var_00[var_02].wasteleported = 1;
    var_00[var_02] thread maps / mp / zquests / casual / island_ee_util::func_ABE1("transport complete");
    if(!var_00[var_02] lib_0547::func_4B2C()) {
      var_00[var_02] lib_0547::func_84CB();
    }

    var_02++;
  }
}

init_cart_flags() {
  common_scripts\utility::func_3799("zmb_island_cart_path_start_complete");
  common_scripts\utility::func_3799("zmb_island_cart_path_mid_complete");
  common_scripts\utility::func_3799("zmb_island_cart_path_end_complete");
}

clear_cart_flags() {
  common_scripts\utility::func_3796("zmb_island_cart_path_start_complete");
  common_scripts\utility::func_3796("zmb_island_cart_path_mid_complete");
  common_scripts\utility::func_3796("zmb_island_cart_path_end_complete");
}

set_cart_path(param_00, param_01, param_02) {
  clear_cart_flags();
  var_03 = get_cart_path_full(param_00, param_01);
  var_04 = [];
  var_04[0] = "zmb_island_cart_path_start_complete";
  var_04[1] = "zmb_island_cart_path_mid_complete";
  var_04[2] = "zmb_island_cart_path_end_complete";
  var_05 = 0;
  var_06 = [0.55, 0.4, 0.65];
  var_07 = [];
  thread start_screenshake();
  foreach(var_09 in var_03) {
    if(!isDefined(var_09.var_830E.angles)) {
      var_0A = (0, 0, 0);
    } else {
      var_0A = var_09.var_830E.angles;
    }

    var_07 = getlinkedplayers();
    self.ridingplayers = var_07;
    if(var_05 == 1 && isDefined(var_07) && var_07.size > 0) {
      if(common_scripts\utility::func_562E(level.ignore_cart_touching_check)) {
        var_07 = level.players;
        self.ridingplayers = var_07;
        maps / mp / gametypes / zombies::func_7E57();
        waitforplayersrevived();
        wait(1.5);
      }
    }

    if(var_05 == 1 && common_scripts\utility::func_562E(param_02) && isDefined(var_07) && var_07.size == 0) {
      wait(3);
      common_scripts\utility::func_379A(var_04[var_05]);
      var_05++;
      continue;
    }

    thread animscripts / notetracks_common::func_831D(var_09.path_anim, var_09.var_830E.origin, var_0A, "island_cart", var_07);
    var_0B = common_scripts\utility::func_46B5(param_00.var_819A + "_start_angles", "targetname");
    var_0C = common_scripts\utility::func_46B5(param_01.var_819A + "_end_angles", "targetname");
    if(var_05 == 1) {
      thread set_player_arrival_offset(var_07, get_player_offset_for(param_00), var_0B.angles, param_00, param_01);
      thread spawn_mine_transport_bombers(param_00.var_819A, param_01.var_819A);
    }

    if(var_05 == 2) {
      thread set_player_arrival_offset(var_07, "front", param_01.arrival_angles.angles);
    }

    var_0D = var_09.path_anim_length;
    if(var_05 == 2 && common_scripts\utility::func_562E(param_02)) {
      level thread do_cart_zombie_spawns(param_01.var_ABFE, var_0D / 2);
    }

    lib_0378::func_8D74("mine_cart_transportation", var_05);
    wait(var_0D);
    self notify("island_cart", "end");
    if(isDefined(var_07) && var_07.size > 0 && var_05 == 0) {
      self notify("cart_start_leave_done");
    }

    common_scripts\utility::func_379A(var_04[var_05]);
    var_05++;
  }

  foreach(var_10 in level.players) {
    var_10.abandonedcarride = 0;
  }

  stop_screenshake();
  if(!common_scripts\utility::func_562E(param_02)) {
    level thread do_cart_zombie_spawns(param_01.var_ABFE, 0);
  }

  foreach(var_10 in var_07) {
    if(isDefined(var_10.var_6772)) {
      var_10.var_6772 destroy();
    }
  }
}

waitforplayersrevived() {
  var_00 = 0;
  while(!var_00) {
    var_00 = 1;
    foreach(var_02 in level.players) {
      if(common_scripts\utility::func_562E(var_02.var_5378)) {
        var_00 = 0;
        break;
      }
    }

    wait 0.05;
  }
}

start_screenshake() {
  self endon("stop_screen_shaking");
  wait(0.75);
  self.screenshakeenabled = 1;
  while(self.screenshakeenabled) {
    self show();
    wait(0.35 + randomfloat(0.55));
    earthquake(0.225, 0.85, self.origin, 96);
    if(isDefined(self.ridingplayers)) {
      foreach(var_01 in self.ridingplayers) {
        if(common_scripts\utility::func_562E(var_01.abandonedcarride)) {
          continue;
        }

        var_01 playRumbleOnEntity("damage_heavy");
      }
    }
  }
}

stop_screenshake() {
  self.screenshakeenabled = 0;
  self notify("stop_screen_shaking");
}

get_player_offset_for(param_00) {
  var_01 = "front";
  switch (param_00.var_819A) {
    case "start_zone":
      var_01 = "back";
      break;

    case "mining_corner":
      var_01 = "front";
      break;

    case "sub_pens_1_zone":
      var_01 = "back";
      break;
  }

  return var_01;
}

do_cart_zombie_spawns(param_00, param_01) {
  var_02 = [];
  var_02[0] = 0;
  var_02[1] = 0;
  var_02[2] = 1;
  var_02[3] = 3;
  var_02[4] = 4;
  var_02[5] = 5;
  var_03 = common_scripts\utility::random(var_02);
  var_04 = 0;
  if(var_03 == 0) {
    return;
  }

  if(!isDefined(level.last_minecart_punishment)) {
    level.last_minecart_punishment = -1;
  }

  if(level.last_minecart_punishment >= level.var_A980) {
    return;
  }

  level.last_minecart_punishment = level.var_A980;
  wait(param_01);
  while(var_03 > 0) {
    var_03--;
    var_04 = common_scripts\utility::func_98E7(var_04 == param_00.size, 0, var_04 + 1);
    var_05 = lib_054D::func_90BA("zombie_generic", param_00[var_04], "zombie_transport_punish", 0, 0, 1);
    var_05.var_6941 = 1;
    var_05.ispassiveexempt = 1;
    var_05.isobjectiveexemptfromfog = 1;
    wait(0.25);
  }
}

spawn_mine_transport_bombers(param_00, param_01) {
  wait 0.05;
  var_02 = 95;
  if(!isDefined(level.last_minecart_bmb_punishment)) {
    level.last_minecart_bmb_punishment = -1;
  }

  if(level.last_minecart_bmb_punishment >= level.var_A980) {
    return;
  }

  level.last_minecart_bmb_punishment = level.var_A980;
  var_03 = common_scripts\utility::func_46B7(param_00 + "_mine_spawners", "targetname");
  var_04 = common_scripts\utility::func_46B7(param_01 + "_mine_spawners", "targetname");
  var_05 = common_scripts\utility::func_F73(var_03, var_04);
  var_06 = 0;
  for(var_07 = 0; var_07 < var_05.size; var_07++) {
    if(var_06 || randomint(100) < var_02) {
      var_02 = var_02 * 0.85;
      var_08 = spawn_a_mine_cart_bomber(param_00, var_05[var_07]);
    }
  }

  if(isDefined(level.minecart_bmb_set)) {
    var_09 = 5;
    if(randomint(100) <= level.minecart_bmb_set / var_09 * 100) {
      var_0A = common_scripts\utility::func_46B5("mining_pagan_mine_spawner", "targetname");
      var_0B = spawn_a_mine_cart_bomber(param_00, var_0A);
      if(isDefined(var_0B)) {
        var_0B.var_297D = ::pagan_bomber_custom_movemode;
        var_0B.var_1927 = common_scripts\utility::func_46B5(var_0A.target, "targetname");
      }
    }
  } else {
    level.minecart_bmb_set = 0;
  }

  level.minecart_bmb_set++;
}

spawn_a_mine_cart_bomber(param_00, param_01) {
  var_02 = lib_054D::func_90BA("zombie_exploder", param_01, "tunnel bombers", 0, 1, 1);
  if(!isDefined(var_02)) {
    return undefined;
  }

  var_02.isminecartbomber = 1;
  var_02.ispassiveexempt = 1;
  var_02.isobjectiveexemptfromfog = 1;
  var_02 thread remove_passive_behavior();
  var_02.var_1927 = common_scripts\utility::func_46B5(param_00 + "_mine_spawners_dest", "targetname");
  var_02 thread make_mine_tunnel_zombie(self, param_00);
  var_02.maxhealth = 1000;
  var_02.health = 1000;
  return var_02;
}

remove_passive_behavior() {
  self endon("death");
  wait 0.05;
  while(!common_scripts\utility::func_3798("zombie_passive")) {
    wait 0.05;
  }

  lib_053C::func_4F7F("player close");
}

pagan_bomber_custom_movemode() {
  return "walk";
}

make_mine_tunnel_zombie(param_00, param_01) {
  self endon("death");
  childthread cleanup_cart_bmb(param_00);
  lib_0547::func_84CB();
  while(distance(self.origin, level.zmb_island_artillery_sled.origin) > 92) {
    wait 0.05;
  }

  lib_0563::func_AB99(level.player, level.player, 1000, undefined, "MOD_BULLET", "m1911_zm", self.origin, (0, 0, 0), "tag_origin", 0, "tag_weapon");
}

cleanup_cart_bmb(param_00) {
  param_00 waittill("cart_start_leave_done");
  self suicide();
}

getlinkedplayers() {
  var_00 = self getlinkedchildren();
  var_01 = [];
  foreach(var_03 in var_00) {
    if(!isPlayer(var_03)) {
      var_01 = common_scripts\utility::func_F6F(var_01, var_03);
    }
  }

  var_00 = common_scripts\utility::func_F94(var_00, var_01);
  return var_00;
}

get_cart_path_full(param_00, param_01) {
  var_02 = [];
  var_02["zmb_cart_move_01"] = % zmb_cart_move_01;
  var_02["zmb_cart_move_02"] = % zmb_cart_move_02;
  var_02["zmb_cart_move_03"] = % zmb_cart_move_03;
  var_02["zmb_cart_move_04"] = % zmb_cart_move_04;
  var_02["zmb_cart_move_05"] = % zmb_cart_move_05;
  var_02["zmb_cart_move_06"] = % zmb_cart_move_06;
  var_02["zmb_cart_entrance_01_arrive"] = % zmb_cart_entrance_01_arrive;
  var_02["zmb_cart_entrance_01_leave"] = % zmb_cart_entrance_01_leave;
  var_02["zmb_cart_entrance_02_arrive"] = % zmb_cart_entrance_02_arrive;
  var_02["zmb_cart_entrance_02_leave"] = % zmb_cart_entrance_02_leave;
  var_02["zmb_cart_entrance_03_arrive"] = % zmb_cart_entrance_03_arrive;
  var_02["zmb_cart_entrance_03_leave"] = % zmb_cart_entrance_03_leave;
  var_03 = [];
  var_03["start_zonemining_corner"] = "zmb_cart_move_02";
  var_03["mining_cornerstart_zone"] = "zmb_cart_move_01";
  var_03["mining_cornersub_pens_1_zone"] = "zmb_cart_move_03";
  var_03["sub_pens_1_zonemining_corner"] = "zmb_cart_move_04";
  var_03["sub_pens_1_zonestart_zone"] = "zmb_cart_move_05";
  var_03["start_zonesub_pens_1_zone"] = "zmb_cart_move_06";
  var_04 = param_00.var_830E;
  var_05 = param_01.var_830E;
  var_06 = [];
  var_07 = get_num_for_location(param_00);
  var_08 = "zmb_cart_entrance_0" + var_07 + "_leave";
  var_09 = getanimlength(var_02[var_08]);
  var_0A = var_03[param_00.var_819A + param_01.var_819A];
  var_0B = getanimlength(var_02[var_0A]);
  var_07 = get_num_for_location(param_01);
  var_0C = "zmb_cart_entrance_0" + var_07 + "_arrive";
  var_0D = getanimlength(var_02[var_0C]);
  var_06[0] = spawnStruct();
  var_06[0].path_anim = var_08;
  var_06[0].path_anim_length = var_09;
  var_06[0].var_830E = param_00.var_830E;
  var_06[1] = spawnStruct();
  var_06[1].path_anim = var_0A;
  var_06[1].path_anim_length = var_0B;
  var_06[1].var_830E = common_scripts\utility::func_46B5("cart_roundabout_scripted_node", "targetname");
  var_06[2] = spawnStruct();
  var_06[2].path_anim = var_0C;
  var_06[2].path_anim_length = var_0D;
  var_06[2].var_830E = param_01.var_830E;
  return var_06;
}

get_num_for_location(param_00) {
  var_01 = 1;
  switch (param_00.var_819A) {
    case "start_zone":
      var_01 = 1;
      break;

    case "mining_corner":
      var_01 = 2;
      break;

    case "sub_pens_1_zone":
      var_01 = 3;
      break;
  }

  return var_01;
}

set_all_players_on_cart_facing_path_start(param_00) {
  var_01 = vectortoangles(param_00[1].origin - param_00[0].origin);
  foreach(var_03 in level.players) {
    if(!common_scripts\utility::func_562E(var_03.oncartride)) {
      continue;
    }

    var_03 setplayerangles(var_01);
  }
}

get_cart_path_from(param_00) {
  var_01 = [];
  var_01[0] = param_00;
  while(isDefined(var_01[var_01.size - 1].target)) {
    var_02 = common_scripts\utility::func_46B5(var_01[var_01.size - 1].target, "targetname");
    var_01 = common_scripts\utility::func_F6F(var_01, var_02);
  }

  return var_01;
}

get_random_destination(param_00) {
  param_00 = common_scripts\utility::array_randomize(param_00);
  var_01 = ["secret_room_zone", "pack_a_punch_opened", "pack_a_punch_exit"];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    if(common_scripts\utility::func_562E(param_00[var_02].cart_activated) && !common_scripts\utility::func_F79(var_01, param_00[var_02].var_819A)) {
      return param_00[var_02];
    }
  }

  return undefined;
}

activate_after(param_00) {
  wait 0.05;
  self.cart_activated = 0;
  common_scripts\utility::func_3C9F(param_00);
  self.cart_activated = 1;
  wait(0.5);
}