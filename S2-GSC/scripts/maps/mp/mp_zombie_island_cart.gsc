/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_cart.gsc
*****************************************************/

transport_trigger_manager(var_0, var_1, var_2, var_3) {
  common_scripts\utility::_id_3C9F(var_3);
  update_trigger_hints(var_1, var_2);
  var_4 = 0;
  var_5 = undefined;
  level.zmb_mine_cart_is_locked = 0;
  level thread watch_for_transport_requests(var_1, var_2);

  for(;;) {
    var_6 = next_transport_request();

    switch (var_6._id_7D18) {
      case "purchase":
        execute_station_leave(var_1, var_2, var_5, var_6.player);

        if(isDefined(var_5)) {
          var_5 = undefined;
        }

        break;
      case "call":
        execute_station_leave(var_1, var_2, var_6.getnegotiationnextnode);
        break;
      case "lockdown":
        if(isDefined(var_6.getnegotiationnextnode)) {
          execute_station_leave(var_1, var_2, var_6.getnegotiationnextnode);
        }

        level.zmb_mine_cart_is_locked = 1;

        foreach(var_8 in level.valid_island_cart_destinations) {
          maps\mp\mp_zombie_island_cart_station_functions::set_transport_light_states(var_8, "deactivated");
        }

        if(isDefined(var_6.script_flag_lock)) {
          var_5 = var_6.script_flag_lock;
        }

        update_trigger_hints(var_1, var_2, &"ZOMBIE_ISLAND_TRANSPORT_DISABLED");
        break;
      case "unlock":
        level.zmb_mine_cart_is_locked = 0;
        maps\mp\mp_zombie_island_cart_station_functions::set_transport_light_states(level.zmb_transport_system["current_station"], "ready");
        update_trigger_hints(var_1, var_2);
        break;
    }
  }
}

make_a_transport_request(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.player = var_0;
  var_5._id_9D65 = var_1;
  var_5._id_7D18 = var_2;
  var_5.getnegotiationnextnode = var_3;
  var_5.script_flag_lock = var_4;
  level.zmb_mine_cart_transport_requests = common_scripts\utility::_id_0F6F(level.zmb_mine_cart_transport_requests, var_5);
  level notify("new_transport_request", var_5);
}

wait_for_cart_finished_with_mid_route() {
  level.zmb_island_artillery_sled common_scripts\utility::_id_379C("zmb_island_cart_path_mid_complete");
}

get_transport_finishes_flag() {
  return "transport complete";
}

main() {
  _precacherumble("damage_heavy");
  level.zmb_mine_cart_transport_requests = [];
  common_scripts\utility::flag_init("any_minecart_used");
  common_scripts\utility::flag_init("transport complete");
  common_scripts\utility::flag_init("flag_exposed_secret_entrance");
  common_scripts\utility::flag_init("flag_found_pommel_door");
  _id_0557::_id_4BC9("flag_found_pommel_door", undefined, undefined, 1);
  level.valid_island_cart_destinations = ["start_zone", "mining_corner", "sub_pens_1_zone"];
  level.island_cart_structs = common_scripts\utility::_id_46B7("mine_cart_struct", "targetname");
  level.zmb_island_artillery_sled = undefined;
  initialize_pomel_exits();
  level thread run_upgrade_machine_pickups();

  foreach(var_1 in level.island_cart_structs) {
    var_1 init_cart_flags();
    var_1 initialize_this_cart();
  }

  var_3 = common_scripts\utility::_id_46B7("mine_cart_lever", "targetname");

  foreach(var_5 in var_3) {
    var_5 initialize_lever();
    var_5 thread run_lever();
  }

  level thread handle_pomel_detor();
  level thread handle_pomel_exit();
  var_7 = "flag_aa_guns_powered_on";
  level.zmb_transport_system = [];
  level thread transport_trigger_manager(level.island_cart_structs, level.zmb_transport_activation_triggers, level.zmb_transport_call_triggers, var_7);
  initialize_first_location("mining_corner", var_7);
  level thread override_notetracks_for_cart();
}

override_notetracks_for_cart() {
  while(!isDefined(anim._id_67D4)) {
    waitframe();
  }

  anim._id_67D4["fadetoblack_"] = ::_id_67AA;
  anim._id_67D4["fadefromblack_"] = ::_id_67A9;
}

_id_67AA(var_0, var_1, var_2) {
  thread animscripts\notetracks_common::_id_67AD(var_0, var_1, 1, players_have_abandoned_minecart_ride(var_2));
}

_id_67A9(var_0, var_1, var_2) {
  thread animscripts\notetracks_common::_id_67AD(var_0, var_1, 0, players_have_abandoned_minecart_ride(var_2));
}

players_have_abandoned_minecart_ride(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!common_scripts\utility::_id_562E(var_3.abandonedcarride)) {
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
    }
  }

  return var_1;
}

get_initial_dir() {
  var_0 = "left";

  switch (self.getnegotiationnextnode) {
    case "start_zone":
      var_0 = "left";
      break;
    case "mining_corner":
      var_0 = "left";
      break;
    case "sub_pens_1_zone":
      var_0 = "right";
      break;
  }

  return var_0;
}

initialize_sled_junction(var_0, var_1, var_2) {
  if(!isDefined(level.zmb_island_cart_junctions)) {
    level.zmb_island_cart_junctions = [];
  }

  level.zmb_island_cart_junctions[var_0 + var_1] = common_scripts\utility::_id_46B5(var_2, "script_noteworthy");
  level.zmb_island_cart_junctions[var_1 + var_0] = common_scripts\utility::_id_46B5(var_2, "script_noteworthy");
}

initialize_first_location(var_0, var_1) {
  var_2 = maps\mp\mp_zombie_island_cart_station_functions::get_all_carts_with(var_0);

  foreach(var_4 in level.island_cart_structs) {
    var_4.mine_cart_model hide();
  }

  level.zmb_island_artillery_sled = var_2[0].mine_cart_model;
  level.zmb_island_artillery_sled.dontdeleterevivespot = 1;
  level.zmb_island_artillery_sled show();
  level.zmb_island_artillery_sled common_scripts\utility::_id_3799("zmb_island_cart_path_start_complete");
  level.zmb_island_artillery_sled common_scripts\utility::_id_3799("zmb_island_cart_path_mid_complete");
  level.zmb_island_artillery_sled common_scripts\utility::_id_3799("zmb_island_cart_path_end_complete");
  level thread set_first_location_ready(var_0, var_1);
}

set_first_location_ready(var_0, var_1) {
  set_trigger_hints(level.zmb_transport_activation_triggers, level.zmb_transport_call_triggers, &"ZOMBIES_REQUIRES_POWER", &"ZOMBIE_ISLAND_POWER_OBERLAND");
  common_scripts\utility::_id_3C9F(var_1);
  maps\mp\mp_zombie_island_cart_station_functions::set_station_ready(var_0);
  maps\mp\mp_zombie_island_cart_station_functions::set_transport_light_states(var_0, "ready");
  level.zmb_transport_system["current_station"] = var_0;
  set_triggers(level.zmb_transport_activation_triggers, level.zmb_transport_call_triggers);
}

set_player_arrival_offset(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vectorNormalize(anglestoright(self.angles));
  var_6 = vectorNormalize(anglesToForward(self.angles));
  var_7 = vectorNormalize(anglestoup(self.angles));
  var_8 = [];
  var_9 = [];

  switch (var_1) {
    case "front":
      var_9 = self.player_offsets_front;
      break;
    case "back":
      var_9 = self.player_offsets_back;
      break;
  }

  foreach(var_11 in var_9) {
    var_12 = var_5 * var_11[0];
    var_13 = var_6 * var_11[1];
    var_14 = var_7 * var_11[2];
    var_8 = common_scripts\utility::_id_0F6F(var_8, self.origin + (var_12 + var_13 + var_14));
  }

  foreach(var_17 in var_0) {
    var_18 = undefined;
    var_19 = 99999999;

    foreach(var_21 in var_8) {
      var_22 = distance(var_21, var_17.origin);

      if(var_22 < var_19) {
        var_18 = var_21;
        var_19 = var_22;
      }
    }

    var_17 unlink();
    var_17 setOrigin(var_18);
    var_17 playerlinkTo(self);
    var_17 setplayerangles(var_2);
    var_17.haspommelflushed = 1;

    if(!common_scripts\utility::_id_562E(var_17.oncartride)) {
      var_17 thread attach_to_cart(var_3, var_4, _id_0547::_id_429D(var_17));
    }

    var_8 = common_scripts\utility::_id_0F93(var_8, var_18);
  }
}

run_upgrade_machine_pickups() {
  var_0 = common_scripts\utility::_id_46B7("zmb_pap_fuse_pickup", "targetname");
  level.zmb_pap_fuse_pickups = var_0;

  foreach(var_7, var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "zmb_pap_fuse_pickup_trigger":
          var_2.zmb_pap_fuse_pickup_trigger = var_5;
          break;
        case "zmb_pap_fuse_pickup_model":
          var_2.zmb_pap_fuse_pickup_model = var_5;
          break;
      }
    }

    var_2 thread give_upgrade_fuse();
  }
}

give_upgrade_fuse() {
  self.zmb_pap_fuse_pickup_trigger setHintString(&"ZOMBIE_ISLAND_GRAB_PAP_POWER");
  self.zmb_pap_fuse_pickup_trigger waittill("trigger", var_0);
  var_0 thread _id_0367::_id_8E3C("papcircuitpickup");
  self.zmb_pap_fuse_pickup_trigger delete();
  self.zmb_pap_fuse_pickup_model delete();
  maps\mp\mp_zombie_island_ee_pack_a_punch_unlock::add_player_fuse_count();
}

run_cart_depart(var_0, var_1, var_2) {
  foreach(var_4 in level.island_cart_structs) {
    if(var_4.getnegotiationnextnode != var_0) {
      continue;
    }
    var_4 thread leave_station(var_1, var_2);
  }
}

leave_station(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < 2; var_3++) {
    if(var_3 == 0) {
      if(isDefined(var_0)) {
        var_2 = get_random_destination([get_dest_by_flag(var_0)]);

        if(isDefined(var_2)) {
          break;
        }
      } else {
        var_2 = get_random_destination([self.possible_dests[self.forced_index]]);

        if(isDefined(var_2)) {
          break;
        }
      }
    }

    if(var_3 == 1) {
      var_2 = get_random_destination(self.possible_dests);

      if(isDefined(var_2)) {
        break;
      }
    }
  }

  if(isDefined(var_2)) {
    thread do_cart_path(var_2, isDefined(var_0));
    attach_players_to_transport(self, var_2, var_1);
  } else
    common_scripts\utility::flag_set("transport complete");
}

attach_players_to_transport(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = isDefined(var_2) && level.players[var_3] == var_2;

    if(level.players[var_3] istouching(self.zmb_island_cart_touch_detection)) {
      level.players[var_3] thread attach_to_cart(self, var_1, var_3);
      level.players[var_3] thread zmb_events_report_player_on_cart();
      continue;
    }

    if(level.players[var_3] istouching(self.secondary_player_cart_volume) || var_4) {
      level.zmb_island_artillery_sled set_player_arrival_offset([level.players[var_3]], get_player_offset_for(var_0), level.players[var_3].angles, var_0, var_1);
      level.players[var_3] thread attach_to_cart(self, var_1, var_3);
      level.players[var_3] thread zmb_events_report_player_on_cart();
    }
  }
}

zmb_events_report_player_on_cart() {
  var_0 = self;

  if(isDefined(level.zmb_events_player_rode_minecart)) {
    var_0 thread[[level.zmb_events_player_rode_minecart]]();
  }
}

handle_pomel_exit() {
  var_0 = _getEnt("pomel_room_exit_whirlpool", "targetname");
  var_0 setHintString(&"ZOMBIE_ISLAND_POMEL_EXIT");
  var_1 = common_scripts\utility::_id_46B7("pomel_exit_launcher", "targetname");
  var_0 thread disable_on_usable_touching();

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(common_scripts\utility::_id_562E(var_2.isflushing) || assassin_worshipers_alive()) {
      continue;
    }
    var_2.isflushing = 1;
    var_2 thread run_pomel_exit(var_1);
  }
}

disable_on_usable_touching() {
  for(;;) {
    var_0 = 0;
    var_1 = getEntArray("baby_statue_spawn", "targetname");

    foreach(var_3 in var_1) {
      if(_distance2d(var_3.origin, self.origin) < 70 && self.origin[2] < var_3.origin[2] + 64) {
        var_0 = 1;
      }
    }

    if(var_0) {
      common_scripts\utility::_id_9D9F();
    } else {
      common_scripts\utility::_id_9DA3();
    }

    wait 0.125;
  }
}

assassin_worshipers_alive() {
  var_0 = _id_0547::_id_408F();

  foreach(var_2 in var_0) {
    if(common_scripts\utility::_id_562E(var_2.assassin_prayer)) {
      return 1;
    }
  }

  return 0;
}

run_pomel_exit(var_0) {
  _id_0378::_id_8D74("pagen_room_flush_begin");
  level thread common_scripts\_exploder::_id_088E(216, [self]);
  wait 0.4;
  pomel_launch(common_scripts\utility::random(var_0));
  self.isflushing = 0;
  respawn_pommel_room_zombies_if_player_vacant();
}

respawn_pommel_room_zombies_if_player_vacant() {
  if(!maps\mp\zombies\zombie_assassin_spawner_logic::everyone_in_pommel_room(1, 1)) {
    var_0 = _id_0547::_id_408F();

    foreach(var_2 in var_0) {
      if(var_2 maps\mp\mp_zombie_island::agent_is_in_secret_room(1)) {
        if(!common_scripts\utility::_id_562E(var_2.wasteleported)) {
          var_2 _id_056D::_id_5A86();
        }
      }
    }
  }
}

pomel_launch(var_0) {
  var_1 = 195;
  var_2 = distance(var_0.vec_point_1, var_0.vec_point_2) / var_1;
  var_3 = vectorNormalize(var_0.vec_point_2 - var_0.vec_point_1);
  thread animscripts\notetracks_common::_id_30B4(var_2 / 2);
  wait(var_2 / 2);
  waitframe();
  self setOrigin(var_0.vec_point_1);
  var_4 = spawn("script_model", self.origin);
  var_4 moveTo(var_0.vec_point_2, var_2);
  self setplayerangles(vectortoangles(var_0.vec_point_2 - var_0.vec_point_1));
  self playerlinkTo(var_4);
  maps\mp\mp_zombie_island_fog_zones::set_should_restore_fog_vision_isolated_room();
  thread animscripts\notetracks_common::do_fade_from_black(var_2 / 2);
  wait(var_2);
  _id_0378::_id_8D74("pagen_room_flush_end");
  self unlink();
  self setvelocity(var_1 * var_3);
}

initialize_pomel_exits() {
  var_0 = common_scripts\utility::_id_46B7("pomel_exit_launcher", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "pomel_point_1":
          var_2.vec_point_1 = var_5.origin;
          break;
        case "pomel_point_2":
          var_2.vec_point_2 = var_5.origin;
          break;
      }
    }
  }
}

handle_pomel_detor() {
  var_0 = common_scripts\utility::_id_46B7("zmb_island_secret_rock_exit_struct", "targetname");

  foreach(var_2 in var_0) {
    common_scripts\utility::flag_init(var_2.getnegotiationnextnode + "_bomb_placed");

    if(!common_scripts\utility::_id_3C83(var_2.getnegotiationnextnode + "_bomb_detonated")) {
      common_scripts\utility::flag_init(var_2.getnegotiationnextnode + "_bomb_detonated");
    }

    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");
    var_2.rock_blockers = [];

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "rock_blockers":
          var_2.rock_blockers = common_scripts\utility::_id_0F6F(var_2.rock_blockers, var_5);
          break;
        case "zmb_secret_tunnel_bomb_place":
          var_2.bomb_placement = var_5;
          break;
        case "zmb_secret_exit_trigger":
          var_2.bomb_trigger = var_5;
          break;
      }
    }

    var_7 = common_scripts\utility::_id_46B5("island_secret_tunnel_debris", "targetname");
    var_3 = common_scripts\utility::_id_44BE(var_7.target, "targetname");
    var_2.wall_pieces = [];

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "pomel_wall":
          var_2.wall_pieces = common_scripts\utility::_id_0F6F(var_2.wall_pieces, var_5);
          break;
      }
    }

    var_2 thread run_pomel_door_explosion();
  }
}

run_pomel_door_explosion() {
  thread wait_for_bomber_explosion();
  common_scripts\utility::_id_3C9F(self.getnegotiationnextnode + "_bomb_detonated");
  level thread common_scripts\_exploder::_id_088E(220);
  common_scripts\utility::flag_set("flag_exposed_secret_entrance");
  set_bomb_exploded();
  var_0 = spawnStruct();
  var_0.unlink_spawns = common_scripts\utility::_id_46B7("zmb_isolated_room_spawns", "targetname");

  for(;;) {
    self.bomb_trigger waittill("trigger", var_1);

    if(common_scripts\utility::_id_562E(level.zmb_island_pommel_detor_blocked)) {
      continue;
    }
    if(!common_scripts\utility::_id_3C77("flag_found_pommel_door")) {
      maps\mp\_utility::_id_2CED(1.4, common_scripts\utility::flag_set, "flag_found_pommel_door");
    }

    level thread try_to_snag_players_from_cart(var_0);
  }
}

try_to_snag_players_from_cart(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < 3; var_2++) {
    foreach(var_4 in level.players) {
      if(common_scripts\utility::_id_562E(var_4.oncartride) && !common_scripts\utility::_id_562E(var_4.isenteringpommelroom) && (var_4 useButtonPressed() || var_1)) {
        var_4 thread handle_pomel_room_enter(var_0);
      }
    }

    waitframe();
  }
}

handle_pomel_room_enter(var_0) {
  self endon("disconnect");
  self.abandonedcarride = 1;
  self.isenteringpommelroom = 1;
  self notify("enter_pomel");
  var_1 = common_scripts\utility::_id_46B5("zmb_island_secret_teleport_gravity_struct", "targetname");
  var_2 = 335;
  var_3 = distance(self.origin, var_1.origin) / var_2;
  var_4 = vectorNormalize(self.origin - var_1.origin);
  thread animscripts\notetracks_common::_id_30B4(var_3 / 2);
  var_5 = spawn("script_model", self.origin);
  var_5 moveTo(var_1.origin, var_3);
  var_5.angles = self.angles;
  self setplayerangles(vectortoangles(var_1.origin - self.origin));
  self playerlinkTo(var_5);
  var_5 rotateTo(vectortoangles(var_1.origin - var_5.origin), var_3 / 1.1);
  wait(var_3 / 2);
  thread animscripts\notetracks_common::do_fade_from_black(var_3 / 2);
  self setplayerangles((self.angles[0], self.angles[1] + 180, self.angles[2]));
  thread cancel_screen_fade();
  set_has_left_cart(var_0, 0);
  wait(var_3);
  self unlink();
  self.isenteringpommelroom = 0;
  childthread killzombiesonisland();
}

killzombiesonisland() {
  wait 0.25;

  if(maps\mp\zombies\zombie_assassin_spawner_logic::everyone_in_pommel_room(0, 1)) {
    var_0 = _id_0547::_id_408F();

    foreach(var_2 in var_0) {
      if(!_id_055A::_id_AC29(var_2, "isolated_room_zone") && !_id_055A::_id_AC29(var_2, "isolated_room_entry_zone")) {
        var_2 _id_056D::_id_5A86();
      }
    }
  }
}

cancel_screen_fade() {
  self endon("death");
  self endon("disconnect");
  self waittill("do_fade_to_black");
  self notify("do_fade_to_black");
  waitframe();

  if(isDefined(self._id_6772)) {
    self._id_6772 destroy();
  }
}

wait_for_bomber_explosion() {
  var_0 = 256;
  var_1 = 999;

  for(var_2 = common_scripts\utility::_id_46B5("zmb_island_secret_rock_exit_struct", "targetname"); var_1 > var_0; var_1 = distance(var_3, var_2.origin)) {
    level waittill("objective_zombie_exploder_detonation", var_3);
  }

  common_scripts\utility::flag_set(self.getnegotiationnextnode + "_bomb_detonated");
}

set_bomb_exploded(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  }

  foreach(var_2 in self.wall_pieces) {
    var_2 delete();
  }
}

set_bomb_placed() {
  var_0 = spawn("script_model", self.bomb_placement.origin);
  var_0 setModel("zom_bomb");
  var_0 setCanDamage(1);
  return var_0;
}

wait_for_bomb_placement() {
  self.bomb_trigger waittill("trigger", var_0);
  common_scripts\utility::flag_set(self.getnegotiationnextnode + "_bomb_placed");
}

wait_for_bomb_detonate(var_0) {
  var_0 waittill("damage");
  common_scripts\utility::flag_set(self.getnegotiationnextnode + "_bomb_detonated");
}

initialize_lever() {
  var_0 = common_scripts\utility::_id_44BE(self.target, "targetname");

  foreach(var_2 in var_0) {
    switch (var_2._id_0165) {
      case "mine_cart_lever_trig":
        self.lever_trig = var_2;
        break;
      case "zmi_mine_cart_switch":
        self.lever_model = var_2;
        break;
    }
  }

  self.lever_model set_level_model(self.getnegotiationnextnode);
  connect_to_transport();
}

set_level_model(var_0) {
  self hidepart("breach_trench");
  self hidepart("subpen_breach");
  self hidepart("trench_subpen");

  switch (var_0) {
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
  foreach(var_1 in level.island_cart_structs) {
    if(self.getnegotiationnextnode == var_1.getnegotiationnextnode) {
      self.mytransport = var_1;
    }
  }
}

run_lever() {
  var_0 = get_initial_dir();
  self.mytransport.forced_index++;
  self.lever_trig setHintString(&"ZOMBIE_ISLAND_TRANSPORT_TOGGLE");

  for(;;) {
    self.lever_model toggle_lever(var_0);
    self.mytransport toggle_destination();
    var_0 = common_scripts\utility::_id_98E7(var_0 == "left", "right", "left");
    self.lever_trig common_scripts\utility::_id_9DA3();
    self.lever_trig waittill("trigger", var_1);
    self.lever_trig common_scripts\utility::_id_9D9F();
  }
}

#using_animtree("animated_props_zombies_DLC1");

toggle_lever(var_0) {
  var_1 = [];
  var_1["s2_zom_minecart_switch_pos1_2_pos2"] = % s2_zom_minecart_switch_pos1_2_pos2;
  var_1["s2_zom_minecart_switch_pos2_2_pos1"] = % s2_zom_minecart_switch_pos2_2_pos1;
  var_1["s2_zom_minecart_switch_pos1_idle"] = % s2_zom_minecart_switch_pos1_idle;
  var_1["s2_zom_minecart_switch_pos2_idle"] = % s2_zom_minecart_switch_pos2_idle;
  var_2 = "";
  var_3 = "";

  switch (var_0) {
    case "left":
      var_2 = "s2_zom_minecart_switch_pos2_2_pos1";
      var_3 = "s2_zom_minecart_switch_pos1_idle";
      break;
    case "right":
      var_2 = "s2_zom_minecart_switch_pos1_2_pos2";
      var_3 = "s2_zom_minecart_switch_pos2_idle";
      break;
  }

  self scriptmodelplayanim(var_2);
  _id_0378::_id_8D74("mine_cart_lever");
  wait(_getanimlength(var_1[var_2]));
  self scriptmodelplayanim(var_3);
}

do_spider() {
  var_0 = _getEnt(self.target, "targetname");
  var_1 = _getEnt(var_0.target, "targetname");
  var_2 = _getEnt(var_1.target, "targetname");
  var_3 = _getEnt(var_2.target, "targetname");
  var_4 = [var_0, var_2];
  var_1 linktosynchronizedparent(var_0);
  var_2 linktosynchronizedparent(var_1);
  var_3 linktosynchronizedparent(var_2);

  if(isDefined(var_3.target)) {
    var_5 = _getEnt(var_3.target, "targetname");
    var_5 linktosynchronizedparent(var_3);
  }

  wait(_randomfloat(3));

  for(;;) {
    var_6 = common_scripts\utility::random(var_4);
    var_6 rotateroll(30, 0.25);
    wait 0.3;
    var_6 rotateroll(-30, 0.25);
    wait 0.3;
  }
}

toggle_destination() {
  self.forced_index++;

  if(self.forced_index >= self.possible_dests.size) {
    self.forced_index = 0;
  }
}

spawn_a_mine_cart(var_0, var_1) {
  var_2 = _func_2CD(var_0, var_1, "ger_bomber_stuka_hub", "zmi_mine_cart_01");
  return var_2;
}

wait_for_tranport_request() {
  self waittill("new_transport_request", var_0);
  return var_0;
}

execute_next_transport_request() {
  var_0 = level.zmb_mine_cart_transport_requests[0];
  return var_0;
}

update_trigger_hints(var_0, var_1, var_2, var_3) {
  set_triggers(var_0, var_1, level.zmb_transport_system["current_station"]);
  set_trigger_hints(var_0, var_1, var_2, var_3);
}

disable_transport_triggers(var_0, var_1) {
  set_triggers(var_0, var_1);
}

execute_station_leave(var_0, var_1, var_2, var_3) {
  if(common_scripts\utility::_id_562E(level.zmb_mine_cart_is_locked)) {
    return;
  }
  if(_id_0547::_id_5565(var_2, level.zmb_transport_system["current_station"])) {
    return;
  }
  level.zmb_mine_cart_is_locked = 1;

  if(isDefined(level.mine_cart_notification)) {
    level notify(level.mine_cart_notification);
  }

  disable_transport_triggers(var_0, var_1);
  run_cart_depart(level.zmb_transport_system["current_station"], var_2, var_3);
  wait_for_transport_done();
  update_trigger_hints(var_0, var_1, &"ZOMBIE_ISLAND_TRANSPORT_DISABLED");
  wait 7.5;
  maps\mp\mp_zombie_island_cart_station_functions::set_transport_light_states(var_2, "deactivated", level.zmb_transport_system["current_station"], "ready");
  update_trigger_hints(var_0, var_1);
  level.zmb_mine_cart_is_locked = 0;
}

next_transport_request() {
  if(level.zmb_mine_cart_transport_requests.size == 0) {
    var_0 = wait_for_tranport_request();
  } else {
    var_0 = execute_next_transport_request();
  }

  level.zmb_mine_cart_transport_requests = common_scripts\utility::_id_0F93(level.zmb_mine_cart_transport_requests, var_0);
  return var_0;
}

wait_for_transport_done() {
  common_scripts\utility::_id_3C9F("transport complete");
  common_scripts\utility::_id_3C7B("transport complete");
}

set_trigger_hints(var_0, var_1, var_2, var_3) {
  foreach(var_5 in common_scripts\utility::_id_0F73(var_0, var_1)) {
    if(isDefined(var_2)) {
      var_5 setHintString(var_2);
    } else if(common_scripts\utility::_id_562E(level.free_cart_rides)) {
      var_5 setHintString(var_5.transporthintfree);
    } else {
      var_5 setHintString(var_5.transporthint);
    }

    if(isDefined(var_3)) {
      var_5 setsecondaryhintstring(var_3);
      continue;
    }

    var_5 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
  }
}

set_triggers(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(!isDefined(var_2)) {
      var_4 common_scripts\utility::_id_9D9F();
      continue;
    }

    if(_id_0547::_id_5565(var_4.getnegotiationnextnode, var_2)) {
      var_4 common_scripts\utility::_id_9DA3();
      continue;
    }

    var_4 common_scripts\utility::_id_9D9F();
  }

  foreach(var_4 in var_1) {
    if(!isDefined(var_2)) {
      var_4 common_scripts\utility::_id_9D9F();
      continue;
    }

    if(!isDefined(var_2) || _id_0547::_id_5565(var_4.getnegotiationnextnode, var_2)) {
      var_4 common_scripts\utility::_id_9D9F();
      continue;
    }

    var_4 common_scripts\utility::_id_9DA3();
  }
}

get_trigger_for_station(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(_id_0547::_id_5565(var_4.getnegotiationnextnode, var_1)) {
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
    }
  }

  return var_2;
}

watch_for_transport_requests(var_0, var_1) {
  common_scripts\utility::_id_0FB2(var_0, ::watch_for_interact, 1);
  common_scripts\utility::_id_0FB2(var_1, ::watch_for_interact, 0);

  for(;;) {
    level waittill("transport_trigger_interact", var_2, var_3, var_4);

    if(common_scripts\utility::_id_562E(level.zmb_mine_cart_is_locked)) {
      continue;
    }
    if(var_4 && !var_2 transport_purchase_successful(var_3)) {
      continue;
    } else {
      make_a_transport_request(var_2, var_3, common_scripts\utility::_id_98E7(var_4, "purchase", "call"), var_3.getnegotiationnextnode);
    }
  }
}

watch_for_interact(var_0) {
  if(common_scripts\utility::_id_562E(var_0)) {
    self._id_267B = 250;
  }

  for(;;) {
    self waittill("trigger", var_1);
    level notify("transport_trigger_interact", var_1, self, var_0);
  }
}

transport_purchase_successful(var_0) {
  if(common_scripts\utility::_id_562E(level.free_cart_rides)) {
    return 1;
  }

  if(!maps\mp\gametypes\zombies::_id_11C2(var_0._id_267B)) {
    thread _id_054E::_id_0695("needmoney");
    return 0;
  } else
    return 1;
}

initialize_this_cart() {
  self.unlink_spawns = [];
  self.preview_models = [];
  self.mine_cart_start = _getvehiclenode(self.target, "targetname");
  var_0 = common_scripts\utility::_id_44BE(self.target, "targetname");
  self.zmb_mine_cart_gate_left_near = [];
  self.zmb_mine_cart_gate_right_near = [];
  self.zmb_mine_cart_gate_left_far = [];
  self.zmb_mine_cart_gate_right_far = [];
  self.zmb_mine_cart_gate_left_dest = [];
  self.zmb_mine_cart_gate_right_dest = [];
  self.zmb_mine_cart_path_blocker = [];
  self.transport_system_offsets_front = [];
  self.transport_system_offsets_back = [];
  self._id_ABFE = [];
  self.zmb_transport_zombie_waiting_points = [];
  self.info_trigs = [];

  foreach(var_2 in var_0) {
    switch (var_2._id_0165) {
      case "secondary_player_cart_volume":
        self.secondary_player_cart_volume = var_2;
        break;
      case "scripted_node":
        self.setviewkickscale = var_2;
        break;
      case "indicator_light":
        self.indicator_light = var_2;
        add_a_transport_indicator_light(self.indicator_light, self.getnegotiationnextnode);
        break;
      case "arrival_angles":
        self.arrival_angles = var_2;
        break;
      case "zombie_spawner":
        self._id_ABFE = common_scripts\utility::_id_0F6F(self._id_ABFE, var_2);
        break;
      case "transport_system_offsets_front":
        self.transport_system_offsets_front = common_scripts\utility::_id_0F6F(self.transport_system_offsets_front, var_2);
        break;
      case "transport_system_offsets_back":
        self.transport_system_offsets_back = common_scripts\utility::_id_0F6F(self.transport_system_offsets_back, var_2);
        break;
      case "zmb_transport_zombie_waiting_point":
        self.zmb_transport_zombie_waiting_points = common_scripts\utility::_id_0F6F(self.zmb_transport_zombie_waiting_points, var_2);
        break;
      case "zmb_mine_cart_gate":
        self.zmb_mine_cart_gates[var_2.setanimknobrestart] = var_2;
        self.zmb_mine_cart_gates[var_2.setanimknobrestart].prevstate = 0;
        break;
      case "zmb_cart_path_blocker":
        self.zmb_mine_cart_path_blocker[var_2.setanimknobrestart] = var_2;
        break;
      case "mine_cart_model_struct":
        self.mine_cart_model_struct = var_2;
        break;
      case "mine_cart_model_extension_struct":
        self.mine_cart_model_extension_struct = var_2;
        break;
      case "mine_cart_trigger":
        self._id_9D65 = var_2;
        self._id_9D65 common_scripts\utility::_id_9D9F();
        self._id_9D65.transporthint = &"ZOMBIE_ISLAND_ACTIVATE_CART";
        self._id_9D65.transporthintfree = &"ZOMBIE_ISLAND_ACTIVATE_CART_FREE";
        break;
      case "zmi_mine_cart_info_trig":
        self.info_trigs = common_scripts\utility::_id_0F6F(self.info_trigs, var_2);
        var_2.transporthint = &"ZOMBIE_ISLAND_SUMMON_CART";
        var_2.transporthintfree = &"ZOMBIE_ISLAND_SUMMON_CART";
        break;
      case "third_person_preview":
        self.preview_models = common_scripts\utility::_id_0F6F(self.preview_models, var_2);
        break;
      case "mine_cart_unlink_spawn":
        self.unlink_spawns = common_scripts\utility::_id_0F6F(self.unlink_spawns, var_2);
        break;
      case "zmb_island_dropoff_z_height":
        self.zmb_island_dropoff_z_height = var_2;
        break;
      case "zmb_island_cart_touch_detection":
        self.zmb_island_cart_touch_detection = var_2;
        break;
    }
  }

  self.player_offsets_front = [];

  foreach(var_5 in self.transport_system_offsets_front) {
    var_6 = var_5.origin[0] - self.mine_cart_model_struct.origin[0];
    var_7 = var_5.origin[1] - self.mine_cart_model_struct.origin[1];
    var_8 = var_5.origin[2] - self.mine_cart_model_struct.origin[2];
    self.player_offsets_front = common_scripts\utility::_id_0F6F(self.player_offsets_front, (var_6, var_7, var_8));
  }

  self.player_offsets_back = [];

  foreach(var_5 in self.transport_system_offsets_back) {
    var_6 = var_5.origin[0] - self.mine_cart_model_struct.origin[0];
    var_7 = var_5.origin[1] - self.mine_cart_model_struct.origin[1];
    var_8 = var_5.origin[2] - self.mine_cart_model_struct.origin[2];
    self.player_offsets_back = common_scripts\utility::_id_0F6F(self.player_offsets_back, (var_6, var_7, var_8));
  }

  self._id_9D65.getnegotiationnextnode = self.getnegotiationnextnode;

  foreach(var_13 in self.info_trigs) {
    var_13.getnegotiationnextnode = self.getnegotiationnextnode;
  }

  if(!isDefined(level.zmb_transport_activation_triggers)) {
    level.zmb_transport_activation_triggers = [];
  }

  if(!isDefined(level.zmb_transport_call_triggers)) {
    level.zmb_transport_call_triggers = [];
  }

  level.zmb_transport_activation_triggers = common_scripts\utility::_id_0F6F(level.zmb_transport_activation_triggers, self._id_9D65);
  level.zmb_transport_call_triggers = common_scripts\utility::_id_0F73(level.zmb_transport_call_triggers, self.info_trigs);
  initialize_my_door();
  var_15 = self.mine_cart_model_struct.origin;
  var_16 = self.mine_cart_model_struct.angles;

  if(!isDefined(var_16)) {
    var_16 = (0, 0, 0);
  }

  self.mine_cart_model = spawn("script_model", var_15);
  self.mine_cart_model setModel("zmi_mine_cart_01");
  self.mine_cart_model.angles = var_16;
  self.mine_cart_model.player_offsets_front = self.player_offsets_front;
  self.mine_cart_model.player_offsets_back = self.player_offsets_back;
  thread activate_after(self.getnegotiationnextnode);
  initialize_possible_destinations();
  self.forced_index = 0;
}

add_a_transport_indicator_light(var_0, var_1) {
  if(!isDefined(level.transport_light_indicators)) {
    level.transport_light_indicators = [];
  }

  var_2 = spawnStruct();
  var_2.light_model = var_0;
  var_2.transport_flag = var_1;
  level.transport_light_indicators = common_scripts\utility::_id_0F6F(level.transport_light_indicators, var_2);
}

initialize_my_door() {
  if(!isDefined(self.zmb_mine_cart_gate_left_near)) {
    return;
  }
}

initialize_possible_destinations() {
  self.possible_dests = [];

  foreach(var_1 in level.island_cart_structs) {
    if(var_1 != self && common_scripts\utility::_id_0F79(level.valid_island_cart_destinations, var_1.getnegotiationnextnode)) {
      self.possible_dests = common_scripts\utility::_id_0F6F(self.possible_dests, var_1);
    }
  }
}

get_dest_by_flag(var_0) {
  foreach(var_2 in self.possible_dests) {
    if(_id_0547::_id_5565(var_2.getnegotiationnextnode, var_0)) {
      return var_2;
    }
  }
}

attach_to_cart(var_0, var_1, var_2) {
  if(self getcurrentprimaryweapon() == "stone_baby_zm") {
    self allowcrouch(1);
  }

  self setstance("crouch");
  self allowstand(0);
  self playerlinkTo(level.zmb_island_artillery_sled);
  self.oncartride = 1;
  self._id_00CE = 1;
  common_scripts\utility::flag_set("any_minecart_used");
  self endon("enter_pomel");
  var_0 waittill("transport complete");
  set_has_left_cart(var_1, var_2);
}

set_has_left_cart(var_0, var_1) {
  self allowstand(1);
  self setstance("stand");

  if(self getcurrentprimaryweapon() == "stone_baby_zm") {
    self allowcrouch(0);
  }

  self._id_00CE = 0;
  self.oncartride = 0;
  self unlink();

  if(isDefined(var_0.zmb_island_dropoff_z_height)) {
    self setOrigin((self.origin[0], self.origin[1], var_0.zmb_island_dropoff_z_height.origin[2] + 1));
  } else {
    self setOrigin(var_0.unlink_spawns[var_1].origin);
  }
}

do_cart_path(var_0, var_1) {
  var_2 = (0, 0, 24);
  var_3 = (0, 0, 0);
  maps\mp\mp_zombie_island_cart_station_functions::set_station_leaving(self.getnegotiationnextnode);
  maps\mp\mp_zombie_island_cart_station_functions::set_transport_light_states(self.getnegotiationnextnode, "deactivated", var_0.getnegotiationnextnode, "arriving");

  if(common_scripts\utility::_id_562E(var_1)) {
    maps\mp\mp_zombie_island_cart_station_functions::set_station_arriving(var_0.getnegotiationnextnode);
  }

  wait 0.95;
  level.zmb_island_artillery_sled thread set_cart_path(self, var_0, var_1);
  wait 1.75;
  maps\mp\mp_zombie_island_cart_station_functions::set_station_closed(self.getnegotiationnextnode);
  level.zmb_island_artillery_sled common_scripts\utility::_id_379C("zmb_island_cart_path_start_complete");
  level.zmb_island_artillery_sled common_scripts\utility::_id_379C("zmb_island_cart_path_mid_complete");

  if(!var_1) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(!isalive(var_6)) {
        continue;
      }
      if(common_scripts\utility::_id_562E(var_6._id_5728)) {
        continue;
      }
      if(!common_scripts\utility::_id_562E(var_6.oncartride)) {
        continue;
      }
      var_4++;
    }

    if(var_4 == level.players.size) {
      var_0 move_zombies_to_destination();
    }
  }

  maps\mp\mp_zombie_island_cart_station_functions::set_station_arriving(var_0.getnegotiationnextnode);
  level.zmb_island_artillery_sled common_scripts\utility::_id_379C("zmb_island_cart_path_end_complete");
  maps\mp\mp_zombie_island_cart_station_functions::set_station_ready(var_0.getnegotiationnextnode);
  level.zmb_transport_system["current_station"] = var_0.getnegotiationnextnode;
  common_scripts\utility::flag_set("transport complete");
  self notify("transport complete");
  level.zmb_island_artillery_sled notify("arrived at " + var_0.getnegotiationnextnode);
  maps\mp\mp_zombie_island_cart_station_functions::set_transport_light_states(self.getnegotiationnextnode, "deactivated", var_0.getnegotiationnextnode, "deactivated");
  respawn_pommel_room_zombies_if_player_vacant();
}

move_zombies_to_destination() {
  var_0 = _id_0547::_id_408F();
  var_1 = 3 + randomint(self.zmb_transport_zombie_waiting_points.size);
  var_2 = 0;

  foreach(var_4 in self.zmb_transport_zombie_waiting_points) {
    if(var_1 <= 0) {
      return;
    }
    if(var_2 >= var_0.size) {
      return;
    }
    if(!isDefined(var_0[var_2])) {
      continue;
    }
    if(!_id_0547::_id_5565(var_0[var_2]._id_0A4B, "zombie_generic")) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_0[var_2]._id_2FDA)) {
      continue;
    }
    if(_id_0547::_id_5565(var_0[var_2]._id_0BA4, "traverse")) {
      continue;
    }
    var_1--;
    var_0[var_2] setOrigin(_func_2E1(var_4.origin, var_0[var_2]));
    var_0[var_2].wasteleported = 1;
    var_0[var_2] thread maps\mp\zquests\casual\island_ee_util::_id_ABE1("transport complete");

    if(!var_0[var_2] _id_0547::_id_4B2C()) {
      var_0[var_2] _id_0547::disableoffhandsecondaryweapons();
    }

    var_2++;
  }
}

init_cart_flags() {
  common_scripts\utility::_id_3799("zmb_island_cart_path_start_complete");
  common_scripts\utility::_id_3799("zmb_island_cart_path_mid_complete");
  common_scripts\utility::_id_3799("zmb_island_cart_path_end_complete");
}

clear_cart_flags() {
  common_scripts\utility::_id_3796("zmb_island_cart_path_start_complete");
  common_scripts\utility::_id_3796("zmb_island_cart_path_mid_complete");
  common_scripts\utility::_id_3796("zmb_island_cart_path_end_complete");
}

set_cart_path(var_0, var_1, var_2) {
  clear_cart_flags();
  var_3 = get_cart_path_full(var_0, var_1);
  var_4 = [];
  var_4[0] = "zmb_island_cart_path_start_complete";
  var_4[1] = "zmb_island_cart_path_mid_complete";
  var_4[2] = "zmb_island_cart_path_end_complete";
  var_5 = 0;
  var_6 = [0.55, 0.4, 0.65];
  var_7 = [];
  thread start_screenshake();

  foreach(var_9 in var_3) {
    if(!isDefined(var_9.setviewkickscale.angles)) {
      var_10 = (0, 0, 0);
    } else {
      var_10 = var_9.setviewkickscale.angles;
    }

    var_7 = getlinkedplayers();
    self.ridingplayers = var_7;

    if(var_5 == 1 && isDefined(var_7) && var_7.size > 0) {
      if(common_scripts\utility::_id_562E(level.ignore_cart_touching_check)) {
        var_7 = level.players;
        self.ridingplayers = var_7;
        maps\mp\gametypes\zombies::_id_7E57();
        waitforplayersrevived();
        wait 1.5;
      }
    }

    if(var_5 == 1 && common_scripts\utility::_id_562E(var_2) && isDefined(var_7) && var_7.size == 0) {
      wait 3;
      common_scripts\utility::_id_379A(var_4[var_5]);
      var_5++;
      continue;
    }

    thread animscripts\notetracks_common::switchtooffhand(var_9.path_anim, var_9.setviewkickscale.origin, var_10, "island_cart", var_7);
    var_11 = common_scripts\utility::_id_46B5(var_0.getnegotiationnextnode + "_start_angles", "targetname");
    var_12 = common_scripts\utility::_id_46B5(var_1.getnegotiationnextnode + "_end_angles", "targetname");

    if(var_5 == 1) {
      thread set_player_arrival_offset(var_7, get_player_offset_for(var_0), var_11.angles, var_0, var_1);
      thread spawn_mine_transport_bombers(var_0.getnegotiationnextnode, var_1.getnegotiationnextnode);
    }

    if(var_5 == 2) {
      thread set_player_arrival_offset(var_7, "front", var_1.arrival_angles.angles);
    }

    var_13 = var_9.path_anim_length;

    if(var_5 == 2 && common_scripts\utility::_id_562E(var_2)) {
      level thread do_cart_zombie_spawns(var_1._id_ABFE, var_13 / 2);
    }

    _id_0378::_id_8D74("mine_cart_transportation", var_5);
    wait(var_13);
    self notify("island_cart", "end");

    if(isDefined(var_7) && var_7.size > 0 && var_5 == 0) {
      self notify("cart_start_leave_done");
    }

    common_scripts\utility::_id_379A(var_4[var_5]);
    var_5++;
  }

  foreach(var_16 in level.players) {
    var_16.abandonedcarride = 0;
  }

  stop_screenshake();

  if(!common_scripts\utility::_id_562E(var_2)) {
    level thread do_cart_zombie_spawns(var_1._id_ABFE, 0);
  }

  foreach(var_16 in var_7) {
    if(isDefined(var_16._id_6772)) {
      var_16._id_6772 destroy();
    }
  }
}

waitforplayersrevived() {
  var_0 = 0;

  while(!var_0) {
    var_0 = 1;

    foreach(var_2 in level.players) {
      if(common_scripts\utility::_id_562E(var_2.inlaststand)) {
        var_0 = 0;
        break;
      }
    }

    waitframe();
  }
}

start_screenshake() {
  self endon("stop_screen_shaking");
  wait 0.75;
  self.screenshakeenabled = 1;

  while(self.screenshakeenabled) {
    self show();
    wait(0.35 + _randomfloat(0.55));
    _earthquake(0.225, 0.85, self.origin, 96);

    if(isDefined(self.ridingplayers)) {
      foreach(var_1 in self.ridingplayers) {
        if(common_scripts\utility::_id_562E(var_1.abandonedcarride)) {
          continue;
        }
        var_1 playRumbleOnEntity("damage_heavy");
      }
    }
  }
}

stop_screenshake() {
  self.screenshakeenabled = 0;
  self notify("stop_screen_shaking");
}

get_player_offset_for(var_0) {
  var_1 = "front";

  switch (var_0.getnegotiationnextnode) {
    case "start_zone":
      var_1 = "back";
      break;
    case "mining_corner":
      var_1 = "front";
      break;
    case "sub_pens_1_zone":
      var_1 = "back";
      break;
  }

  return var_1;
}

do_cart_zombie_spawns(var_0, var_1) {
  var_2 = [];
  var_2[0] = 0;
  var_2[1] = 0;
  var_2[2] = 1;
  var_2[3] = 3;
  var_2[4] = 4;
  var_2[5] = 5;
  var_3 = common_scripts\utility::random(var_2);
  var_4 = 0;

  if(var_3 == 0) {
    return;
  }
  if(!isDefined(level.last_minecart_punishment)) {
    level.last_minecart_punishment = -1;
  }

  if(level.last_minecart_punishment >= level._id_A980) {
    return;
  }
  level.last_minecart_punishment = level._id_A980;
  wait(var_1);

  while(var_3 > 0) {
    var_3--;
    var_4 = common_scripts\utility::_id_98E7(var_4 == var_0.size, 0, var_4 + 1);
    var_5 = _id_054D::_id_90BA("zombie_generic", var_0[var_4], "zombie_transport_punish", 0, 0, 1);
    var_5._id_6941 = 1;
    var_5.ispassiveexempt = 1;
    var_5.isobjectiveexemptfromfog = 1;
    wait 0.25;
  }
}

spawn_mine_transport_bombers(var_0, var_1) {
  waitframe();
  var_2 = 95;

  if(!isDefined(level.last_minecart_bmb_punishment)) {
    level.last_minecart_bmb_punishment = -1;
  }

  if(level.last_minecart_bmb_punishment >= level._id_A980) {
    return;
  }
  level.last_minecart_bmb_punishment = level._id_A980;
  var_3 = common_scripts\utility::_id_46B7(var_0 + "_mine_spawners", "targetname");
  var_4 = common_scripts\utility::_id_46B7(var_1 + "_mine_spawners", "targetname");
  var_5 = common_scripts\utility::_id_0F73(var_3, var_4);
  var_6 = 0;

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    if(var_6 || randomint(100) < var_2) {
      var_2 = var_2 * 0.85;
      var_8 = spawn_a_mine_cart_bomber(var_0, var_5[var_7]);
    }
  }

  if(isDefined(level.minecart_bmb_set)) {
    var_9 = 5;

    if(randomint(100) <= level.minecart_bmb_set / var_9 * 100) {
      var_10 = common_scripts\utility::_id_46B5("mining_pagan_mine_spawner", "targetname");
      var_11 = spawn_a_mine_cart_bomber(var_0, var_10);

      if(isDefined(var_11)) {
        var_11._id_297D = ::pagan_bomber_custom_movemode;
        var_11._id_1927 = common_scripts\utility::_id_46B5(var_10.target, "targetname");
      }
    }
  } else
    level.minecart_bmb_set = 0;

  level.minecart_bmb_set++;
}

spawn_a_mine_cart_bomber(var_0, var_1) {
  var_2 = _id_054D::_id_90BA("zombie_exploder", var_1, "tunnel bombers", 0, 1, 1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_2.isminecartbomber = 1;
  var_2.ispassiveexempt = 1;
  var_2.isobjectiveexemptfromfog = 1;
  var_2 thread remove_passive_behavior();
  var_2._id_1927 = common_scripts\utility::_id_46B5(var_0 + "_mine_spawners_dest", "targetname");
  var_2 thread make_mine_tunnel_zombie(self, var_0);
  var_2.maxhealth = 1000;
  var_2.health = 1000;
  return var_2;
}

remove_passive_behavior() {
  self endon("death");
  waitframe();

  while(!common_scripts\utility::_id_3798("zombie_passive")) {
    waitframe();
  }

  _id_053C::_id_4F7F("player close");
}

pagan_bomber_custom_movemode() {
  return "walk";
}

make_mine_tunnel_zombie(var_0, var_1) {
  self endon("death");
  childthread cleanup_cart_bmb(var_0);
  _id_0547::disableoffhandsecondaryweapons();

  while(distance(self.origin, level.zmb_island_artillery_sled.origin) > 92) {
    waitframe();
  }

  _id_0563::_id_AB99(level.player, level.player, 1000, undefined, "MOD_BULLET", "m1911_zm", self.origin, (0, 0, 0), "tag_origin", 0, "tag_weapon");
}

cleanup_cart_bmb(var_0) {
  var_0 waittill("cart_start_leave_done");
  self suicide();
}

getlinkedplayers() {
  var_0 = self getlinkedchildren();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isPlayer(var_3)) {
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
    }
  }

  var_0 = common_scripts\utility::_id_0F94(var_0, var_1);
  return var_0;
}

get_cart_path_full(var_0, var_1) {
  var_2 = [];
  var_2["zmb_cart_move_01"] = % zmb_cart_move_01;
  var_2["zmb_cart_move_02"] = % zmb_cart_move_02;
  var_2["zmb_cart_move_03"] = % zmb_cart_move_03;
  var_2["zmb_cart_move_04"] = % zmb_cart_move_04;
  var_2["zmb_cart_move_05"] = % zmb_cart_move_05;
  var_2["zmb_cart_move_06"] = % zmb_cart_move_06;
  var_2["zmb_cart_entrance_01_arrive"] = % zmb_cart_entrance_01_arrive;
  var_2["zmb_cart_entrance_01_leave"] = % zmb_cart_entrance_01_leave;
  var_2["zmb_cart_entrance_02_arrive"] = % zmb_cart_entrance_02_arrive;
  var_2["zmb_cart_entrance_02_leave"] = % zmb_cart_entrance_02_leave;
  var_2["zmb_cart_entrance_03_arrive"] = % zmb_cart_entrance_03_arrive;
  var_2["zmb_cart_entrance_03_leave"] = % zmb_cart_entrance_03_leave;
  var_3 = [];
  var_3["start_zonemining_corner"] = "zmb_cart_move_02";
  var_3["mining_cornerstart_zone"] = "zmb_cart_move_01";
  var_3["mining_cornersub_pens_1_zone"] = "zmb_cart_move_03";
  var_3["sub_pens_1_zonemining_corner"] = "zmb_cart_move_04";
  var_3["sub_pens_1_zonestart_zone"] = "zmb_cart_move_05";
  var_3["start_zonesub_pens_1_zone"] = "zmb_cart_move_06";
  var_4 = var_0.setviewkickscale;
  var_5 = var_1.setviewkickscale;
  var_6 = [];
  var_7 = get_num_for_location(var_0);
  var_8 = "zmb_cart_entrance_0" + var_7 + "_leave";
  var_9 = _getanimlength(var_2[var_8]);
  var_10 = var_3[var_0.getnegotiationnextnode + var_1.getnegotiationnextnode];
  var_11 = _getanimlength(var_2[var_10]);
  var_7 = get_num_for_location(var_1);
  var_12 = "zmb_cart_entrance_0" + var_7 + "_arrive";
  var_13 = _getanimlength(var_2[var_12]);
  var_6[0] = spawnStruct();
  var_6[0].path_anim = var_8;
  var_6[0].path_anim_length = var_9;
  var_6[0].setviewkickscale = var_0.setviewkickscale;
  var_6[1] = spawnStruct();
  var_6[1].path_anim = var_10;
  var_6[1].path_anim_length = var_11;
  var_6[1].setviewkickscale = common_scripts\utility::_id_46B5("cart_roundabout_scripted_node", "targetname");
  var_6[2] = spawnStruct();
  var_6[2].path_anim = var_12;
  var_6[2].path_anim_length = var_13;
  var_6[2].setviewkickscale = var_1.setviewkickscale;
  return var_6;
}

get_num_for_location(var_0) {
  var_1 = 1;

  switch (var_0.getnegotiationnextnode) {
    case "start_zone":
      var_1 = 1;
      break;
    case "mining_corner":
      var_1 = 2;
      break;
    case "sub_pens_1_zone":
      var_1 = 3;
      break;
  }

  return var_1;
}

set_all_players_on_cart_facing_path_start(var_0) {
  var_1 = vectortoangles(var_0[1].origin - var_0[0].origin);

  foreach(var_3 in level.players) {
    if(!common_scripts\utility::_id_562E(var_3.oncartride)) {
      continue;
    }
    var_3 setplayerangles(var_1);
  }
}

get_cart_path_from(var_0) {
  var_1 = [];

  for(var_1[0] = var_0; isDefined(var_1[var_1.size - 1].target); var_1 = common_scripts\utility::_id_0F6F(var_1, var_2)) {
    var_2 = common_scripts\utility::_id_46B5(var_1[var_1.size - 1].target, "targetname");
  }

  return var_1;
}

get_random_destination(var_0) {
  var_0 = common_scripts\utility::array_randomize(var_0);
  var_1 = ["secret_room_zone", "pack_a_punch_opened", "pack_a_punch_exit"];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(common_scripts\utility::_id_562E(var_0[var_2].cart_activated) && !common_scripts\utility::_id_0F79(var_1, var_0[var_2].getnegotiationnextnode)) {
      return var_0[var_2];
    }
  }

  return undefined;
}

activate_after(var_0) {
  waitframe();
  self.cart_activated = 0;
  common_scripts\utility::_id_3C9F(var_0);
  self.cart_activated = 1;
  wait 0.5;
}