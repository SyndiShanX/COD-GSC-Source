/***************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_cart_station_functions.gsc
***************************************************************/

set_all_doors_locked() {
  foreach(var_01 in level.valid_island_cart_destinations) {
    set_station_closed(var_01);
  }
}

set_station_leaving(param_00) {
  level thread set_cart_station_state(param_00, 0, "closed", "closed");
  wait(1.25);
  level thread set_cart_station_state(param_00, 0, "closed", "opened");
}

set_station_ready(param_00) {
  level thread set_cart_station_state(param_00, 1, "opened", "closed");
  level thread activate_station_spawners(param_00, 1);
}

set_station_closed(param_00) {
  level thread set_cart_station_state(param_00, 0, "closed", "closed");
  level thread activate_station_spawners(param_00, 0);
}

activate_station_spawners(param_00, param_01) {
  foreach(var_03 in level.zmb_isl_conditional_cart_spawns.var_905E[param_00]) {
    var_03.is_zombies_spawner_script_disabled = !param_01;
  }
}

set_station_arriving(param_00) {
  level thread set_cart_station_state(param_00, 0, "closed", "opened");
}

set_cart_station_state(param_00, param_01, param_02, param_03) {
  var_04 = get_all_carts_with(param_00);
  var_05 = [param_02, param_03];
  foreach(var_07 in var_04) {
    for(var_08 = 0; var_08 < var_05.size; var_08++) {
      switch (var_05[var_08]) {
        case "closed":
          var_07 thread set_doors_closed(var_08);
          break;

        case "opened":
          var_07 thread set_doors_opened(var_08);
          break;
      }
    }
  }
}

set_doors_closed(param_00) {
  self.zmb_mine_cart_path_blocker[param_00] saved_actionslotdata();
  self.zmb_mine_cart_path_blocker[param_00] solid();
  var_01 = "s2_zom_mine_cart_gate_close";
  if(lib_0547::func_5565(self.zmb_mine_cart_gates[param_00].prevstate, 0)) {
    return;
  }

  self.zmb_mine_cart_gates[param_00].prevstate = 0;
  self.zmb_mine_cart_gates[param_00] scriptmodelplayanim("s2_zom_mine_cart_gate_close", "gate_anim");
  self.zmb_mine_cart_gates[param_00] lib_0378::func_8D74("mine_cart_gate_closing");
  wait(getanimlength(%s2_zom_mine_cart_gate_close));
  self.zmb_mine_cart_gates[param_00] scriptmodelplayanim("s2_zom_mine_cart_gate_close_idle", "gate_anim");
}

set_doors_opened(param_00) {
  self.zmb_mine_cart_path_blocker[param_00] connectpaths();
  self.zmb_mine_cart_path_blocker[param_00] notsolid();
  var_01 = "s2_zom_mine_cart_gate_open";
  if(lib_0547::func_5565(self.zmb_mine_cart_gates[param_00].prevstate, 1)) {
    return;
  }

  self.zmb_mine_cart_gates[param_00].prevstate = 1;
  self.zmb_mine_cart_gates[param_00] scriptmodelplayanim("s2_zom_mine_cart_gate_open", "gate_anim");
  self.zmb_mine_cart_gates[param_00] lib_0378::func_8D74("mine_cart_gate_opening");
  wait(getanimlength(%s2_zom_mine_cart_gate_close));
  self.zmb_mine_cart_gates[param_00] scriptmodelplayanim("s2_zom_mine_cart_gate_open_idle", "gate_anim");
}

get_all_carts_with(param_00) {
  var_01 = [];
  foreach(var_03 in level.island_cart_structs) {
    if(lib_0547::func_5565(var_03.var_819A, param_00)) {
      var_01 = common_scripts\utility::func_F6F(var_01, var_03);
    }
  }

  return var_01;
}

set_transport_light_states(param_00, param_01, param_02, param_03) {
  foreach(var_05 in level.transport_light_indicators) {
    if(lib_0547::func_5565(var_05.transport_flag, param_00)) {
      var_05 set_transport_light_state(param_01);
    }

    if(lib_0547::func_5565(var_05.transport_flag, param_02)) {
      var_05 set_transport_light_state(param_03);
    }
  }
}

set_transport_light_state(param_00) {
  self notify("new_state");
  self endon("new_state");
  switch (param_00) {
    case "off":
      self.light_model setModel("zmb_light_cage_standalone_01");
      break;

    case "deactivated":
      self.light_model setModel("zmb_light_cage_standalone_red_01");
      break;

    case "arriving":
      self.light_model childthread func_17BC("green");
      break;

    case "ready":
      self.light_model setModel("zmb_light_cage_standalone_green_01");
      break;
  }
}

func_17BC(param_00) {
  for(;;) {
    self setModel("zmb_light_cage_standalone_01");
    wait(0.75);
    self setModel("zmb_light_cage_standalone_" + param_00 + "_01");
    wait(0.75);
  }
}