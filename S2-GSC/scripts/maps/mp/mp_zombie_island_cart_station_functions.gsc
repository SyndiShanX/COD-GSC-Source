/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_cart_station_functions.gsc
***********************************************************************/

set_all_doors_locked() {
  foreach(var_1 in level.valid_island_cart_destinations)
  set_station_closed(var_1);
}

set_station_leaving(var_0) {
  level thread set_cart_station_state(var_0, 0, "closed", "closed");
  wait 1.25;
  level thread set_cart_station_state(var_0, 0, "closed", "opened");
}

set_station_ready(var_0) {
  level thread set_cart_station_state(var_0, 1, "opened", "closed");
  level thread activate_station_spawners(var_0, 1);
}

set_station_closed(var_0) {
  level thread set_cart_station_state(var_0, 0, "closed", "closed");
  level thread activate_station_spawners(var_0, 0);
}

activate_station_spawners(var_0, var_1) {
  foreach(var_3 in level.zmb_isl_conditional_cart_spawns._id_905E[var_0])
  var_3.is_zombies_spawner_script_disabled = !var_1;
}

set_station_arriving(var_0) {
  level thread set_cart_station_state(var_0, 0, "closed", "opened");
}

set_cart_station_state(var_0, var_1, var_2, var_3) {
  var_4 = get_all_carts_with(var_0);
  var_5 = [var_2, var_3];

  foreach(var_7 in var_4) {
    for(var_8 = 0; var_8 < var_5.size; var_8++) {
      switch (var_5[var_8]) {
        case "closed":
          var_7 thread set_doors_closed(var_8);
          break;
        case "opened":
          var_7 thread set_doors_opened(var_8);
          break;
      }
    }
  }
}

#using_animtree("animated_props_zombies_DLC1");

set_doors_closed(var_0) {
  self.zmb_mine_cart_path_blocker[var_0] _meth_805F();
  self.zmb_mine_cart_path_blocker[var_0] _meth_82C1();
  var_1 = "s2_zom_mine_cart_gate_close";

  if(_id_0547::_id_5565(self.zmb_mine_cart_gates[var_0].prevstate, 0)) {
    return;
  }
  self.zmb_mine_cart_gates[var_0].prevstate = 0;
  self.zmb_mine_cart_gates[var_0] _meth_8276("s2_zom_mine_cart_gate_close", "gate_anim");
  self.zmb_mine_cart_gates[var_0] _id_0378::_id_8D74("mine_cart_gate_closing");
  wait(_func_065(%s2_zom_mine_cart_gate_close));
  self.zmb_mine_cart_gates[var_0] _meth_8276("s2_zom_mine_cart_gate_close_idle", "gate_anim");
}

set_doors_opened(var_0) {
  self.zmb_mine_cart_path_blocker[var_0] _meth_8060();
  self.zmb_mine_cart_path_blocker[var_0] _meth_82C2();
  var_1 = "s2_zom_mine_cart_gate_open";

  if(_id_0547::_id_5565(self.zmb_mine_cart_gates[var_0].prevstate, 1)) {
    return;
  }
  self.zmb_mine_cart_gates[var_0].prevstate = 1;
  self.zmb_mine_cart_gates[var_0] _meth_8276("s2_zom_mine_cart_gate_open", "gate_anim");
  self.zmb_mine_cart_gates[var_0] _id_0378::_id_8D74("mine_cart_gate_opening");
  wait(_func_065(%s2_zom_mine_cart_gate_close));
  self.zmb_mine_cart_gates[var_0] _meth_8276("s2_zom_mine_cart_gate_open_idle", "gate_anim");
}

get_all_carts_with(var_0) {
  var_1 = [];

  foreach(var_3 in level.island_cart_structs) {
    if(_id_0547::_id_5565(var_3._id_819A, var_0))
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
  }

  return var_1;
}

set_transport_light_states(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.transport_light_indicators) {
    if(_id_0547::_id_5565(var_5.transport_flag, var_0))
      var_5 set_transport_light_state(var_1);

    if(_id_0547::_id_5565(var_5.transport_flag, var_2))
      var_5 set_transport_light_state(var_3);
  }
}

set_transport_light_state(var_0) {
  self notify("new_state");
  self endon("new_state");

  switch (var_0) {
    case "off":
      self.light_model setModel("zmb_light_cage_standalone_01");
      break;
    case "deactivated":
      self.light_model setModel("zmb_light_cage_standalone_red_01");
      break;
    case "arriving":
      self.light_model childthread _id_17BC("green");
      break;
    case "ready":
      self.light_model setModel("zmb_light_cage_standalone_green_01");
      break;
  }
}

_id_17BC(var_0) {
  for(;;) {
    self setModel("zmb_light_cage_standalone_01");
    wait 0.75;
    self setModel("zmb_light_cage_standalone_" + var_0 + "_01");
    wait 0.75;
  }
}