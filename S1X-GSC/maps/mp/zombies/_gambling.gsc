/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_gambling.gsc
*****************************************/

init() {
  level._effect["plinko_fraggrenade_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_fraggrenade_trail");
  level._effect["plinko_contactgrenade_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_contactgrenade_trail");
  level._effect["plinko_dnagrenade_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_dnagrenade_trail");
  level._effect["plinko_explosive_drone_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_explosive_drone_trail");
  level._effect["plinko_distract_drone_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_distract_drone_trail");
  level._effect["plinko_teleportgrenade_trail"] = loadfx("vfx/gameplay/mp/zombie/dlc_teleportgrenade_trail");
  level._effect["plinko_distract_drone_socket"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_distract_drone_socket");
  level._effect["plinko_dna_grenade_socket"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_dna_grenade_socket");
  level._effect["plinko_explosive_drone_socket"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_explosive_drone_socket");
  level._effect["plinko_grenade_break"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_grenade_removal");
  level._effect["plinko_credits_100"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_100");
  level._effect["plinko_credits_200"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_200");
  level._effect["plinko_credits_300"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_300");
  level._effect["plinko_credits_400"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_400");
  level._effect["plinko_credits_500"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_500");
  level._effect["plinko_credits_750"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_750");
  level._effect["plinko_credits_1000"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_score_1000");
  level._effect["plinko_light_green"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_light_green");
  level._effect["plinko_light_red"] = loadfx("vfx/gameplay/mp/zombie/dlc_plinko_light_red");
  var_0 = common_scripts\utility::getstructarray("plinko", "targetname");
  common_scripts\utility::array_thread(var_0, ::plinko_init);
  level.zmbteleportgrenadestuckcustom = ::plink_do_grenade_in_all_hoppers_test;
}

reward(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_3 = strtok(var_0, ";");

  foreach(var_5 in var_3) {
    var_6 = strtok(var_5, " ");
    var_7 = var_6[0];
    var_8 = var_6[1];

    switch (var_7) {
      case "cash":
        var_9 = int(var_8);

        if(isDefined(var_1)) {
          var_1 maps\mp\gametypes\zombies::givepointsforevent("gambling", var_9, 1);
          var_1 thread playerplinkoplaypayoutvo(var_9);
          var_1 playlocalsound("interact_credit_machine");

          if(isDefined(var_2)) {
            var_10 = common_scripts\utility::getfx("plinko_credits_" + var_9);
            playFX(var_10, var_2.origin + self.fx_dir * 3, self.fx_dir);
          }
        }

        break;
      case "pickup":
        if(isDefined(level.pickup[var_8]) && isDefined(level.pickup[var_8]["func"])) {
          level thread[[level.pickup[var_8]["func"]]](var_1);
        }

        break;
      case "sq":
        common_scripts\utility::flag_set("sq_plinko_" + var_8, var_1);
        plinko_reset_chute_location();
        break;
      default:
        break;
    }
  }
}

plinko_init() {
  var_0 = getEntArray(self.target, "targetname");
  var_1 = common_scripts\utility::getstructarray(self.target, "targetname");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);
  self.activetokencount = 0;
  self.tokens = [];
  self.starts = [];
  self.grenade_hoppers = [];
  self.gates = [];
  self.force_open = 0;
  self.sq_grenade_in_hopper_count = 0;

  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.fx_dir = anglesToForward(self.angles);
  level thread discoverplinkologic(self);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4.script_noteworthy)) {
      continue;
    }
    switch (var_4.script_noteworthy) {
      case "token":
        var_4.inuse = 0;
        var_4 hide();
        self.tokens[self.tokens.size] = var_4;
        break;
      case "start":
        self.starts[self.starts.size] = var_4;
        break;
      case "trigger":
        self.trigger = var_4;
        break;
      case "grenade_hopper":
        self.grenade_hoppers[self.grenade_hoppers.size] = var_4;
        break;
      case "gate_left":
        plinko_init_gate(var_4);
        self.gate_left = var_4;
        break;
      case "gate_right":
        plinko_init_gate(var_4);
        self.gate_right = var_4;
        break;
      case "gate_top":
        plinko_init_gate(var_4);
        self.gate_top = var_4;
        break;
      case "gate_bottom":
        plinko_init_gate(var_4);
        self.gate_bottom = var_4;
        break;
      case "chute":
        self.chute = var_4;
        break;
      case "sq_goal":
        thread plinko_sq_goal(var_4);
        break;
      case "sq_geo":
        thread plinko_sq_geo(var_4);
        break;
      default:
        break;
    }
  }

  if(isDefined(self.chute)) {
    plinko_init_chute(self.chute);
  }

  plinko_run();
}

plinko_init_chute(var_0) {
  var_0.default_location = spawnStruct();
  var_0.default_location.origin = var_0.origin;
  var_0.default_location.starts = self.starts;
  var_0.current_location = var_0.default_location;
  var_0.locations = common_scripts\utility::getstructarray(var_0.target, "targetname");

  foreach(var_2 in var_0.locations) {
    var_2.starts = common_scripts\utility::getstructarray(var_2.target, "targetname");
  }

  var_0.locations[var_0.locations.size] = var_0.default_location;
  plinko_reset_chute_location();
}

plinko_chute_at_defualt_location() {
  return self.chute.default_location == self.chute.current_location;
}

plinko_reset_chute_location() {
  plinko_set_chute_location(self.chute.default_location);
}

plinko_set_chute_location(var_0) {
  self.chute.origin = var_0.origin;
  self.starts = var_0.starts;
  self.chute.current_location = var_0;

  if(plinko_chute_at_defualt_location()) {
    self notify("chute_at_default");
  } else {
    self notify("chute_not_at_default");
  }
}

plinko_sq_grenade_helper() {
  common_scripts\utility::flag_wait("sq_plinko");
  var_0 = [];
  var_1 = [["sq_frag", "npc_exo_launcher_grenade", "plinko_fraggrenade_trail", "tag_fx", (3, 0, -7), (0, 0, 0)], ["sq_explosive_drone", "npc_drone_explosive_main", "plinko_explosive_drone_socket", "TAG_BEACON", (2, 0, -6), (350, 0, 0)], ["sq_distraction_drone", "dlc_distraction_drone_01_scaled_open", "plinko_distract_drone_socket", "tag_weapon", (0, 0, -8), (43, 284, -69)], ["sq_dna_grenade", "npc_exo_launcher_grenade", "plinko_dna_grenade_socket", "tag_fx", (3, 0, -7), (0, 0, 0)]];
  var_2 = (-124.5, 860, 1135);
  var_3 = (0, 180, 0);

  foreach(var_5 in var_1) {
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_8 = var_5[2];
    var_9 = var_5[3];
    var_10 = var_5[4];
    var_11 = var_5[5];
    var_12 = var_2 + rotatevector(var_10, var_3);
    var_13 = spawn("script_model", var_12);
    var_13 setModel(var_7);
    var_13.angles = var_3 + var_11;
    var_13 hide();
    var_13.type = var_6;
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_8), var_13, var_9);
    var_0[var_0.size] = var_13;
  }

  var_0 = common_scripts\utility::array_randomize(var_0);
  var_15 = undefined;

  for(;;) {
    if(plinko_chute_at_defualt_location()) {
      self waittill("chute_not_at_default");
    }

    plinko_sq_grenade_cylce(var_0);

    if(isDefined(self.sq_visible_grenade)) {
      self.sq_visible_grenade hide();
      self.sq_visible_grenade = undefined;
    }
  }
}

plinko_sq_grenade_cylce(var_0) {
  self endon("chute_at_default");

  for(;;) {
    foreach(var_2 in var_0) {
      if(isDefined(self.sq_visible_grenade)) {
        self.sq_visible_grenade hide();
      }

      self.sq_visible_grenade = var_2;
      self.sq_visible_grenade show();
      wait 3;

      while(self.sq_grenade_in_hopper_count) {
        waitframe();
      }
    }
  }
}

plinko_init_gate(var_0) {
  if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1) {
    var_0 connectpaths();
  }

  var_0.activateexplosivedrone = 1;
  var_0.close_origin = var_0.origin;
  var_1 = common_scripts\utility::getstructarray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_noteworthy)) {
      var_3.script_noteworthy = "open";
    }

    switch (var_3.script_noteworthy) {
      case "open":
        var_0.open_origin = var_3.origin;
        break;
      case "close":
        var_0.origin = var_3.origin;
        var_0.close_origin = var_3.origin;
        break;
      default:
        break;
    }
  }

  var_5 = var_0.open_origin - var_0.close_origin;
  var_0.move_dist = length(var_5);
  var_0.move_dir = vectornormalize(var_5);
  self.gates[self.gates.size] = var_0;
}

plinko_run() {
  self.grenade_round_hopper_count = 0;
  self.pattern_complete_count = [];

  if(isDefined(self.gates.size)) {
    thread plinko_gates_update_pattern();
  }

  if(self.grenade_hoppers.size) {
    thread plinko_run_hopper();
  }

  if(isDefined(self.trigger)) {
    thread plinko_run_use_trigger();
  }

  thread plinko_sq_grenade_helper();
}

plinko_move_gate(var_0, var_1, var_2) {
  var_3 = var_0.close_origin + var_0.move_dir * var_1;

  if(var_3 != var_0.origin) {
    var_0 moveto(var_3, var_2);
  }
}

plinko_move_gates(var_0, var_1, var_2, var_3, var_4) {
  self notify("gates_moved");
  [var_6, var_7, var_8, var_9] = plinko_calculate_gate_offsets(var_0, var_1, var_2, var_3);
  plinko_move_gate(self.gate_left, var_6, var_4);
  plinko_move_gate(self.gate_right, var_7, var_4);
  plinko_move_gate(self.gate_top, var_8, var_4);
  plinko_move_gate(self.gate_bottom, var_9, var_4);
  thread maps\mp\mp_zombie_ark_aud::gate_moving(var_4, var_6);
  wait(var_4);
  thread maps\mp\mp_zombie_ark_aud::gate_stopped();
}

plinko_calculate_gate_offsets(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;

  if(var_0 < 0) {
    var_8 = self.gate_left.move_dist * abs(var_0) + var_2 / 2;
    var_4 = min(var_8, self.gate_left.move_dist);
    var_5 = -1 * var_4 + var_2;
  } else {
    var_9 = self.gate_right.move_dist * var_0 + var_2 / 2;
    var_5 = min(var_9, self.gate_right.move_dist);
    var_4 = -1 * var_5 + var_2;
  }

  if(var_1 < 0) {
    var_10 = self.gate_bottom.move_dist * abs(var_1) + var_3 / 2;
    var_7 = min(var_10, self.gate_bottom.move_dist);
    var_6 = -1 * var_7 + var_3;
  } else {
    var_11 = self.gate_top.move_dist * var_1 + var_3 / 2;
    var_6 = min(var_11, self.gate_top.move_dist);
    var_7 = -1 * var_6 + var_3;
  }

  return [var_4, var_5, var_6, var_7];
}

plinko_gates_get_current_loc() {
  var_0 = distance(self.gate_right.origin, self.gate_right.open_origin);
  var_1 = 1.0 - var_0 / self.gate_right.move_dist;
  var_2 = distance(self.gate_left.origin, self.gate_left.open_origin);
  var_3 = var_2 / self.gate_left.move_dist - 1.0;
  var_4 = (var_1 + var_3) / 2;
  var_5 = distance(self.gate_top.origin, self.gate_top.open_origin);
  var_6 = 1.0 - var_5 / self.gate_top.move_dist;
  var_7 = distance(self.gate_bottom.origin, self.gate_bottom.open_origin);
  var_8 = var_7 / self.gate_bottom.move_dist - 1.0;
  var_9 = (var_6 + var_8) / 2;
  return [var_4, var_9];
}

plinko_gates_get_center() {
  var_0 = (self.gate_right.origin + self.gate_left.origin) / 2;
  var_1 = (self.gate_top.origin[2] + self.gate_bottom.origin[2]) / 2;
  var_0 = (var_0[0], var_0[1], var_1);
  return var_0;
}

plinko_gates_pattern_close_when_looked_at(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 1;
  var_7 = 0.999;
  var_8 = plinko_gates_get_center();

  for(;;) {
    var_9 = 0;

    foreach(var_11 in level.players) {
      var_12 = anglesToForward(var_11 getangles());
      var_13 = vectornormalize(var_8 - var_11 getvieworigin());
      var_14 = vectordot(var_12, var_13);

      if(var_14 > var_7) {
        var_9 = 1;
        break;
      }
    }

    if(var_9 && var_6) {
      [var_17, var_18] = plinko_gates_get_current_loc();
      plinko_move_gates(var_17, var_18, 0, 0, var_5);
      var_6 = 0;
    } else if(!var_9 && !var_6) {
      plinko_move_gates(var_0, var_1, var_2, var_3, var_4);
      var_6 = 1;
    }

    waitframe();
  }
}

plinko_gates_update_pattern() {
  self notify("new_pattern");
  self endon("new_pattern");
  var_0 = self.gate_left.move_dist + self.gate_right.move_dist;
  var_1 = self.gate_top.move_dist + self.gate_bottom.move_dist;
  var_2 = min(var_0, var_1);

  if(self.force_open) {
    self.force_open = 0;
    [var_4, var_5] = plinko_gates_get_current_loc();
    plinko_move_gates(var_4, var_5, var_0, var_1, 0.2);
    wait 3;
  }

  [var_4, var_5] = plinko_gates_get_current_loc();
  plinko_move_gates(var_4, var_5, 0, 0, 0.1);
  wait 0.1;
  plinko_move_gates(0, 0, 0, 0, 0.2);
  wait 1.0;
  var_7 = self.pattern_complete_count[self.grenade_round_hopper_count];

  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  if(self.grenade_round_hopper_count == 0) {
    if(var_7 == 0) {
      plinko_move_gates(0, 0, var_2, var_2, 1);
    } else if(var_7 == 1) {
      var_8 = common_scripts\utility::random([-1, -0.5, 0.5, 1]);
      plinko_move_gates(var_8, 0, var_2, var_2, 1);
    } else if(var_7 == 2) {
      var_9 = common_scripts\utility::random([-1, 0, 1]);
      plinko_move_gates(0, var_9, var_2 * 0.8, var_2 * 0.8, 1);
    } else if(var_7 == 3) {
      var_8 = common_scripts\utility::random([-1, -0.5, 0.5, 1]);
      var_9 = common_scripts\utility::random([-1, 0, 1]);
      plinko_move_gates(var_8, var_9, var_2 * 0.6, var_2 * 0.6, 1);
    } else if(var_7 == 4) {
      var_8 = randomfloatrange(-1.0, 1.0);
      var_9 = randomfloatrange(-1.0, 1.0);
      plinko_move_gates(var_8, var_9, var_2 * 0.5, var_2 * 0.5, 1);
    } else {
      var_8 = randomfloatrange(-1.0, 1.0);
      var_9 = randomfloatrange(-1.0, 1.0);
      plinko_move_gates(var_8, var_9, var_2 * 0.4, var_2 * 0.4, 1);
    }
  } else if(self.grenade_round_hopper_count == 1) {
    var_10 = 1.5;
    var_11 = 0.5;

    if(var_7 == 0) {
      var_10 = 3.5;
      var_11 = 1;
    }

    if(var_7 == 1) {
      var_10 = 3.0;
      var_11 = 1;
    } else if(var_7 == 2) {
      var_10 = 2.5;
      var_11 = 1;
    } else if(var_7 == 3) {
      var_10 = 2.0;
      var_11 = 0.75;
    } else if(var_7 == 4) {
      var_10 = 1.75;
      var_11 = 0.75;
    }

    var_12 = randomintrange(0, 2) * 2 - 1;
    plinko_move_gates(var_12, 0, var_2 * var_11, var_2 * var_11, var_10 / 2);

    for(;;) {
      var_12 = var_12 * -1;
      plinko_move_gates(var_12, 0, var_2 * var_11, var_2 * var_11, var_10);
    }
  } else if(self.grenade_round_hopper_count == 2) {
    var_10 = 1.5;
    var_13 = 0.0;
    var_11 = 0.5;

    if(var_7 == 0) {
      var_10 = 3.5;
      var_13 = 0.75;
      var_11 = 1;
    } else if(var_7 == 1) {
      var_10 = 3.0;
      var_13 = 0.5;
      var_11 = 0.9;
    } else if(var_7 == 2) {
      var_10 = 2.5;
      var_13 = 0.5;
      var_11 = 0.8;
    } else if(var_7 == 3) {
      var_10 = 2.0;
      var_13 = 0.5;
      var_11 = 0.7;
    } else if(var_7 == 4) {
      var_10 = 1.5;
      var_13 = 0.25;
      var_11 = 0.7;
    }

    var_12 = randomintrange(0, 2) * 2 - 1;

    for(;;) {
      plinko_move_gates(var_12, 0, var_2 * var_11, var_2 * var_11, 0.2);
      wait(var_13);
      plinko_move_gates(var_12 * -1, 0, var_2 / 4, var_2 / 4, 2);
      wait(var_13);
      var_12 = var_12 * -1;
    }
  } else if(self.grenade_round_hopper_count == 3) {
    var_14 = 0.4;
    var_15 = 0.0;
    var_11 = 0.3;

    if(var_7 == 0) {
      var_14 = 1.0;
      var_15 = 1.0;
      var_11 = 0.7;
    } else if(var_7 == 1) {
      var_14 = 0.8;
      var_15 = 1.0;
      var_11 = 0.7;
    } else if(var_7 == 2) {
      var_14 = 0.7;
      var_15 = 0.8;
      var_11 = 0.6;
    } else if(var_7 == 3) {
      var_14 = 0.6;
      var_15 = 0.6;
      var_11 = 0.5;
    } else if(var_7 == 4) {
      var_14 = 0.5;
      var_15 = 0.4;
      var_11 = 0.4;
    }

    var_12 = randomintrange(0, 2) * 2 - 1;
    var_16 = randomintrange(0, 2) * 2 - 1;
    plinko_move_gates(0, var_16, var_2 * var_11, var_2 * var_11, 0.5 * var_14);

    for(;;) {
      plinko_move_gates(var_12, var_16 * -1, var_2 * var_11, var_2 * var_11, 2 * var_14);
      wait(0.5 * var_15);
      plinko_move_gates(0, var_16, var_2 * var_11, var_2 * var_11, 2 * var_14);
      plinko_move_gates(var_12 * -1, var_16 * -1, var_2 * var_11, var_2 * var_11, 2 * var_14);
      wait(0.5 * var_15);
      plinko_move_gates(0, var_16, var_2 * var_11, var_2 * var_11, 2 * var_14);
    }
  } else {
    var_14 = 0.2;
    var_15 = 0.0;
    var_11 = 0.3;

    if(var_7 == 0) {
      var_14 = 1.0;
      var_15 = 1.0;
      var_11 = 1.0;
    } else if(var_7 == 1) {
      var_14 = 0.75;
      var_15 = 0.75;
      var_11 = 0.8;
    } else if(var_7 == 2) {
      var_14 = 0.5;
      var_15 = 0.5;
      var_11 = 0.6;
    } else if(var_7 == 3) {
      var_14 = 0.35;
      var_15 = 0.35;
      var_11 = 0.5;
    } else if(var_7 == 4) {
      var_14 = 0.25;
      var_15 = 0.25;
      var_11 = 0.4;
    }

    for(;;) {
      var_17 = max(var_2 * 0.2, randomfloatrange(0, var_2) * var_11);
      var_18 = max(var_2 * 0.2, randomfloatrange(0, var_2) * var_11);
      var_19 = randomfloatrange(-1, 1);
      var_20 = randomfloatrange(-1, 1);
      var_21 = randomfloatrange(0.5, 1.0) * var_14;
      var_13 = randomfloatrange(0.25, 1.0) * var_15;
      plinko_move_gates(var_19, var_20, var_17, var_18, var_21);
      wait(var_13);
    }
  }
}

plinko_reset_grenade_round_hopper_count() {
  for(;;) {
    level waittill("zombie_wave_ended");

    for(var_0 = 0; var_0 < self.grenade_round_hopper_count; var_0++) {
      if(!isDefined(self.pattern_complete_count[var_0])) {
        self.pattern_complete_count[var_0] = 0;
      }

      self.pattern_complete_count[var_0] = int(min(self.pattern_complete_count[var_0] + 1, 5));
    }

    self.grenade_round_hopper_count = 0;
    plinko_gates_update_pattern();
  }
}

plinko_run_hopper() {
  thread plinko_reset_grenade_round_hopper_count();
  thread plinko_grenade_watch();
}

plinko_grenade_watch() {
  foreach(var_1 in level.players) {
    thread plinko_player_grenade_watch(var_1);
  }

  for(;;) {
    level waittill("connected", var_1);
    thread plinko_player_grenade_watch(var_1);
    thread plinko_player_missile_watch(var_1);
  }
}

plinko_player_missile_watch(var_0) {
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("missile_fire", var_1, var_2);
    thread plinko_grenade_in_hopper_watch(var_1, var_2, var_0);
  }
}

plinko_player_grenade_watch(var_0) {
  var_0 endon("disconnect");
  var_0.plinkousecount = 0;

  for(;;) {
    var_0 waittill("grenade_fire", var_1, var_2);

    if(isDefined(var_2) && var_2 == "repulsor_zombie_mp") {
      continue;
    }
    thread plinko_grenade_in_hopper_watch(var_1, var_2, var_0);
  }
}

plinko_grenade_in_hopper_watch(var_0, var_1, var_2) {
  var_0 endon("death");

  for(;;) {
    if(plinko_do_grenade_in_hopper_test(var_0, var_1, var_2)) {
      return;
    }
    waitframe();
  }
}

plink_do_grenade_in_all_hoppers_test(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstructarray("plinko", "targetname");

  foreach(var_5 in var_3) {
    if(var_5 plinko_do_grenade_in_hopper_test(var_0, var_1, var_2)) {
      return 1;
    }
  }

  return 0;
}

plinko_do_grenade_in_hopper_test(var_0, var_1, var_2) {
  foreach(var_4 in self.grenade_hoppers) {
    if(ispointinvolume(var_0.origin, var_4)) {
      thread plinko_grenade_in_hopper(var_0, var_1, var_2, var_4);
      return 1;
    }
  }

  return 0;
}

plinko_sq_grenade_hopper_count() {
  self.sq_grenade_in_hopper_count++;
  wait 0.45;
  self.sq_grenade_in_hopper_count--;
}

plinko_grenade_in_hopper(var_0, var_1, var_2, var_3) {
  thread maps\mp\mp_zombie_ark_aud::grenade_in_hopper();
  var_1 = getweaponbasename(var_1);

  if(!plinko_chute_at_defualt_location()) {
    switch (var_1) {
      case "contact_grenade_throw_zombies_mp":
      case "contact_grenade_zombies_mp":
      case "frag_grenade_throw_zombies_mp":
      case "frag_grenade_zombies_mp":
        if(isDefined(self.sq_visible_grenade)) {
          thread plinko_sq_grenade_hopper_count();
          var_1 = self.sq_visible_grenade.type;
        }

        break;
      default:
        break;
    }
  }

  var_4 = 1;

  switch (var_1) {
    case "sq_frag":
    case "frag_grenade_throw_zombies_mp":
    case "frag_grenade_zombies_mp":
      thread plinko_frag_grenade_in_hopper(var_0, var_1, var_2, var_3);
      break;
    case "contact_grenade_throw_zombies_mp":
    case "contact_grenade_zombies_mp":
      thread plinko_contact_grenade_in_hopper(var_0, var_1, var_2, var_3);
      break;
    case "sq_explosive_drone":
    case "explosive_drone_throw_zombie_mp":
    case "explosive_drone_zombie_mp":
      if(plinko_ent_linked_to_gates(var_0)) {
        var_4 = 0;
      } else {
        thread plinko_explosive_drone_in_hopper(var_0, var_1, var_2, var_3);
      }

      break;
    case "sq_distraction_drone":
    case "distraction_drone_throw_zombie_mp":
    case "distraction_drone_zombie_mp":
      thread plinko_distraction_drone_in_hopper(var_0, var_1, var_2, var_3);
      break;
    case "sq_dna_grenade":
    case "dna_aoe_grenade_zombie_mp":
    case "dna_aoe_grenade_throw_zombie_mp":
      thread plinko_aoe_grenade_in_hopper(var_0, var_1, var_2, var_3);
      break;
    case "teleport_throw_zombies_mp":
    case "teleport_zombies_mp":
      thread plinko_teleport_grenade_in_hopper(var_0, var_1, var_2, var_3);
      break;
    case "iw5_mahemzm_mp":
    case "iw5_exocrossbowzm_mp":
      if(isDefined(self.pattern_complete_count[self.grenade_round_hopper_count]) && self.pattern_complete_count[self.grenade_round_hopper_count] > 0) {
        self.pattern_complete_count[self.grenade_round_hopper_count]--;
      }

      plinko_gates_update_pattern();
      var_4 = 0;
      break;
    default:
      var_4 = 0;
      break;
  }

  if(var_4) {
    self.grenade_round_hopper_count++;
    plinko_gates_update_pattern();
  }
}

plinko_grenade_destroy(var_0) {
  playFX(common_scripts\utility::getfx("plinko_grenade_break"), var_0.origin, self.fx_dir);
  playsoundatpos(var_0.origin, "plinko_grenade_destroyed");
  var_0 delete();
}

plinko_grenade_fx_play(var_0, var_1, var_2) {
  var_0.fx_name = var_1;
  var_0.fx_tag = var_2;
  playFXOnTag(common_scripts\utility::getfx(var_1), var_0, var_2);
}

plinko_grenade_fx_stop(var_0) {
  stopFXOnTag(common_scripts\utility::getfx(var_0.fx_name), var_0, var_0.fx_tag);
}

plinko_frag_grenade_in_hopper(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0.origin);
  var_0 delete();
  waitframe();
  var_5 = "npc_exo_launcher_grenade";
  var_4 setModel(var_5);
  var_4.angles = (0, -90, 0);
  plinko_grenade_fx_play(var_4, "plinko_fraggrenade_trail", "tag_fx");
  var_4.object_offset = (0, 0, 2);
  wait 0.4;
  plinko_run_grenade(var_4, var_2);
  wait 1;
  plinko_grenade_destroy(var_4);
}

plinko_contact_grenade_in_hopper(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0.origin);
  var_0 delete();
  waitframe();
  var_5 = "npc_exo_launcher_grenade";
  var_4 setModel(var_5);
  var_4.angles = (0, -90, 0);
  plinko_grenade_fx_play(var_4, "plinko_contactgrenade_trail", "tag_fx");
  var_4.object_offset = (0, 0, 2);
  wait 0.4;
  plinko_run_grenade(var_4, var_2);
  wait 1;
  plinko_grenade_destroy(var_4);
}

plinko_explosive_drone_in_hopper(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0.origin);
  var_0 delete();
  waitframe();
  var_5 = "npc_drone_explosive_main";
  var_4 setModel(var_5);
  var_4.angles = (0, 90, -90);
  plinko_grenade_fx_play(var_4, "plinko_explosive_drone_trail", "TAG_BEACON");
  var_4.object_type = "explosive_drone";
  var_4.object_offset = (2, 0, 2);
  var_4.socketed = 0;
  var_4.socketed_fx_name = "plinko_explosive_drone_socket";
  var_4.socketed_fx_tag = "TAG_BEACON";
  wait 0.4;
  plinko_run_grenade(var_4, var_2);
  wait 1;

  if(!var_4.socketed) {
    plinko_grenade_destroy(var_4);
  }
}

plinko_distraction_drone_in_hopper(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0.origin);
  var_0 delete();
  waitframe();
  var_5 = "dlc_distraction_drone_01_scaled_closed";
  var_4 setModel(var_5);
  var_4.angles = (45, -90, 90);
  plinko_grenade_fx_play(var_4, "plinko_distract_drone_trail", "tag_weapon");
  var_4.object_type = "distraction_drone";
  var_4.object_offset = (0, 0, 2);
  var_4.socketed = 0;
  var_4.socketed_fx_name = "plinko_distract_drone_socket";
  var_4.socketed_fx_tag = "tag_origin";
  wait 0.4;
  plinko_run_grenade(var_4, var_2);

  if(!var_4.socketed) {
    wait 1;
    plinko_grenade_destroy(var_4);
  } else {
    var_4 setModel("dlc_distraction_drone_01_scaled_open");
    thread plinko_distraction_drone_spin(var_4);
  }
}

plinko_distraction_drone_spin(var_0) {
  var_0 endon("death");
  var_0 thread audio_distraction_drone_sound();
  var_1 = (720, 0, 0);

  for(;;) {
    var_0 rotatevelocity(var_1, 600);
    wait 600;
  }
}

plinko_ent_linked_to_gates(var_0) {
  var_1 = var_0 getlinkedparent();

  if(isDefined(var_1)) {
    foreach(var_3 in self.gates) {
      if(var_3 == var_1) {
        return 1;
      }
    }
  }

  return 0;
}

audio_distraction_drone_sound() {
  self playLoopSound("plinko_dist_gren_spin_lp");
}

plinko_aoe_grenade_in_hopper(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0.origin);
  var_0 notify("dud_explode");
  var_0 delete();
  waitframe();
  var_5 = "npc_exo_launcher_grenade";
  var_4 setModel(var_5);
  var_4.angles = (0, -90, 0);
  plinko_grenade_fx_play(var_4, "plinko_dnagrenade_trail", "tag_fx");
  var_4.object_type = "aoe_grenade";
  var_4.object_offset = (2, 0, 0);
  var_4.socketed = 0;
  var_4.socketed_fx_name = "plinko_dna_grenade_socket";
  var_4.socketed_fx_tag = "tag_fx";
  wait 0.4;
  plinko_run_grenade(var_4, var_2);
  var_4 thread audio_aoe_grenade_socketed();
  wait 1;

  if(!var_4.socketed) {
    plinko_grenade_destroy(var_4);
  }
}

audio_aoe_grenade_socketed() {
  self playLoopSound("plinko_aoe_lp");
}

plinko_teleport_grenade_in_hopper(var_0, var_1, var_2, var_3) {
  if(common_scripts\utility::flag("sq_plinko")) {
    if(isDefined(self.chute) && self.chute.locations.size) {
      self.chute.locations = common_scripts\utility::array_randomize(self.chute.locations);

      foreach(var_5 in self.chute.locations) {
        if(var_5 == self.chute.current_location) {
          continue;
        }
        plinko_set_chute_location(var_5);
        playsoundatpos(self.origin, "plinko_chute_teleport");
        break;
      }
    }
  }

  var_7 = spawn("script_model", var_0.origin);
  var_0 delete();
  waitframe();
  var_8 = "dlc3_teleport_grenade_01";
  var_7 setModel(var_8);
  var_7.angles = (0, -90, 0);
  plinko_grenade_fx_play(var_7, "plinko_teleportgrenade_trail", "tag_fx");
  var_7.object_offset = (0, 0, 3);
  wait 0.4;
  plinko_run_grenade(var_7, var_2);
  wait 1;
  plinko_grenade_destroy(var_7);
}

plinko_run_use_trigger() {
  var_0 = 300;
  var_1 = 3;

  for(;;) {
    self.trigger setcursorhint("HINT_NOICON");
    self.trigger sethintstring("Activate Plinko");
    self.trigger setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(var_0));
    self.trigger waittill("trigger", var_2);
    var_3 = plinko_get_available_token();

    if(!isDefined(var_3)) {
      continue;
    }
    if(!var_2 maps\mp\gametypes\zombies::attempttobuy(var_0)) {
      continue;
    }
    self.trigger sethintstring("");
    self.trigger setsecondaryhintstring("");
    thread plinko_run_token(var_3, var_2);
    plinko_use_wait();
  }
}

plinko_use_wait() {
  var_0 = 0.2;
  var_1 = gettime();
  var_2 = plinko_get_available_token();

  if(!isDefined(var_2)) {
    self waittill("token_available");
  }

  var_3 = (gettime() - var_1) / 1000;

  if(var_3 < var_0) {
    wait(var_0 - var_3);
  }
}

plinko_run_grenade(var_0, var_1) {
  var_2 = common_scripts\utility::random(self.starts);
  var_0.origin = var_2.origin;
  var_0.angles = var_0.angles + var_2.angles;
  waitframe();
  plinko_run_move(var_2, var_0, var_1);
}

plinko_run_token(var_0, var_1) {
  var_0.inuse = 1;
  var_0 show();
  var_2 = common_scripts\utility::random(self.starts);
  var_0 dontinterpolate();
  var_0.origin = var_2.origin;
  wait 1;
  plinko_run_move(var_2, var_0, var_1);
  wait 1;
  var_0.inuse = 0;
  var_0 hide();
  self notify("token_available");
}

plinko_give_achievement(var_0) {
  if(isDefined(var_0) && var_0.plinkousecount == 30) {
    var_0 maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_PLINKO");
  }
}

plinko_run_move(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_2.plinkousecount++;
    plinko_give_achievement(var_2);
  }

  var_3 = (0, 0, -800);

  if(!isDefined(var_1.object_offset)) {
    var_1.object_offset = (0, 0, 0);
  }

  if(isDefined(var_0.angles)) {
    var_1.object_offset = rotatevector(var_1.object_offset, var_0.angles);
    var_1.angles = var_1.angles + var_0.angles;
  }

  if(!isDefined(var_1.object_type)) {
    var_1.object_type = "default";
  }

  var_4 = 0;

  for(;;) {
    var_5 = plinko_new_link(var_0);
    var_6 = plinko_next_link(var_5, var_1.object_type);

    if(!isDefined(var_6)) {
      break;
    }

    var_7 = var_6.node;
    var_8 = plinko_object_type_can_socket(var_1.object_type) && plinko_origin_type(var_7) == "socket";
    var_9 = var_1.origin;
    var_10 = var_7.origin;

    if(var_8) {
      var_1.socketed = 1;
      var_7.socket_object = var_1;
      var_10 = var_10 + var_1.object_offset * (1, 1, 0);
    } else {
      var_10 = var_10 + var_1.object_offset;
    }

    var_11 = distance2d(var_9, var_10);
    var_12 = abs(var_9[2] - var_10[2]);
    var_13 = 0.2;

    if(var_11 > 0) {
      var_13 = var_13 + 0.2;
    }

    if(var_12 > 40) {
      var_13 = var_13 + 0.1;
    }

    var_13 = ceil(var_13 / 0.05) * 0.05;
    var_14 = trajectorycalculateinitialvelocity(var_9, var_10, var_3, var_13);
    var_1 movegravity(var_14, var_13);
    wait(var_13 + 0.05);

    if(!isDefined(var_1)) {
      break;
    }

    var_4++;
    thread maps\mp\zombies\_zombies_audio::plinko_clink(var_1, var_4);

    for(var_15 = var_6.parent_link; isDefined(var_15); var_15 = var_15.parent_link) {
      var_16 = var_15.node.socket_object;

      if(isDefined(var_16)) {
        plinko_grenade_destroy(var_16);
      }
    }

    if(var_8) {
      if(isDefined(var_1.socketed_fx_name)) {
        plinko_grenade_fx_stop(var_1);
        plinko_grenade_fx_play(var_1, var_1.socketed_fx_name, var_1.socketed_fx_tag);
      }

      break;
    }

    plinko_give_reward(var_7, var_2, var_1);
    var_0 = var_7;
  }

  if(isDefined(var_1)) {
    playsoundatpos(var_1.origin, "plinko_socketed");
  }
}

plinko_object_type_can_socket(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "aoe_grenade":
    case "distraction_drone":
    case "explosive_drone":
      return 1;
    default:
      return 0;
  }
}

plinko_give_reward(var_0, var_1, var_2) {
  reward(var_0.script_noteworthy, var_1, var_2);
}

plinko_new_link(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.node = var_0;
  var_2.parent_link = var_1;
  return var_2;
}

plinko_next_link(var_0, var_1) {
  var_2 = plinko_next_links(var_0, var_1);

  if(!var_2.size) {
    return undefined;
  }

  var_3 = common_scripts\utility::random(var_2);
  return var_3;
}

plinko_next_links(var_0, var_1) {
  var_2 = [];
  var_3 = var_0.node;
  var_4 = var_3 get_linked_structs();

  foreach(var_6 in var_4) {
    if(plinko_origin_type(var_6) == "socket" && (isDefined(var_6.socket_object) || !plinko_object_type_can_socket(var_1))) {
      var_7 = var_6 get_linked_structs();

      if(isDefined(var_6.socket_object)) {
        var_8 = var_6.socket_object.object_type + "_with_socket";
      } else {
        var_8 = "without_socket";
      }

      foreach(var_10 in var_7) {
        var_11 = var_10.script_parameters;

        if(var_11 == var_8) {
          var_12 = plinko_new_link(var_10, plinko_new_link(var_6, var_0));
          var_2 = common_scripts\utility::array_combine(plinko_next_links(var_12, var_1), var_2);
        }
      }

      continue;
    }

    var_2[var_2.size] = plinko_new_link(var_6, var_0);
  }

  return var_2;
}

plinko_origin_type(var_0) {
  if(!isDefined(var_0.script_parameters)) {
    return "default";
  }

  return var_0.script_parameters;
}

plinko_get_available_token() {
  foreach(var_1 in self.tokens) {
    if(!var_1.inuse) {
      return var_1;
    }
  }

  return undefined;
}

get_linked_structs() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = common_scripts\utility::get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = common_scripts\utility::getstruct(var_1[var_2], "script_linkname");

      if(isDefined(var_3)) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  return var_0;
}

plinko_sq_goal(var_0) {
  var_1 = "sq_plinko_" + var_0.script_parameters;
  thread plinko_sq_goal_fx(var_0);
  common_scripts\utility::flag_wait("sq_plinko");
  return;
}

plinko_sq_goal_fx(var_0) {
  var_1 = undefined;
  var_2 = "sq_plinko_" + var_0.script_parameters;

  for(;;) {
    if(common_scripts\utility::flag("sq_plinko")) {
      var_3 = "plinko_light_red";

      if(common_scripts\utility::flag(var_2)) {
        var_3 = "plinko_light_green";
      }

      if(!isDefined(var_1) || var_1.name != var_3) {
        if(isDefined(var_1)) {
          var_1 delete();
        }

        var_1 = spawnfx(common_scripts\utility::getfx(var_3), var_0.origin);
        var_1.name = var_3;
        triggerfx(var_1);
      }
    } else if(isDefined(var_1)) {
      wait 3;
      var_1 delete();
    }

    level common_scripts\utility::waittill_any(var_2, "sq_plinko");
  }
}

plinko_sq_geo(var_0) {
  var_1 = var_0.origin;
  var_2 = common_scripts\utility::getstruct(var_0.target, "targetname").origin;
  var_0.origin = var_2;
  common_scripts\utility::flag_wait("sq_plinko");
  var_0 moveto(var_1, 1.0);
  common_scripts\utility::flag_waitopen("sq_plinko");
  var_0 moveto(var_2, 1.0);
}

discoverplinkologic(var_0) {
  level notify("discoverPlinkoLogic");
  level endon("discoverPlinkoLogic");
  var_1 = 90000;
  var_2 = 0.7;

  while(!isDefined(level.players) || level.players.size == 0) {
    waitframe();
  }

  foreach(var_4 in level.players) {
    var_4.plinkodiscovered = undefined;
  }

  var_6 = 0;
  var_7 = maps\mp\zombies\_zombies_zone_manager::ispointinanyzonereturn(var_0.origin);

  while(var_6 < level.players.size) {
    foreach(var_4 in level.players) {
      if(maps\mp\zombies\_util::is_true(var_4.plinkodiscovered)) {
        continue;
      }
      if(!maps\mp\zombies\_zombies_zone_manager::playerisinzone(var_4, var_7)) {
        continue;
      }
      var_9 = distance2dsquared(var_4.origin, var_0.origin);

      if(var_9 > var_1) {
        continue;
      }
      var_10 = anglesToForward(var_4 getangles());
      var_11 = vectornormalize(var_0.origin - var_4.origin);
      var_12 = vectordot(var_10, var_11);

      if(var_12 >= var_2) {
        var_13 = 0;

        if(isDefined(level.zmbfindgamblecustomvo)) {
          var_13 = [
            }
            [level.zmbfindgamblecustomvo]](var_4, var_0);
        else {
          var_13 = var_4 playerplinkovosee();
        }

        if(var_13) {
          var_4.plinkodiscovered = 1;
          var_6++;
          wait 15;
          break;
        }
      }
    }

    wait 0.1;
  }

  foreach(var_4 in level.players) {
    var_4.plinkodiscovered = undefined;
  }
}

playerplinkovosee() {
  return maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "plinko_see");
}

playerplinkoplaypayoutvo(var_0) {
  self endon("disconnect");
  wait 1;

  if(var_0 <= 200) {
    playerplinkovopayoutsmall();
  } else if(var_0 >= 750) {
    playerplinkovopayoutlarge();
  } else {
    playerplinkovopayoutmedium();
  }
}

playerplinkovopayoutsmall() {
  maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "plinko_small");
}

playerplinkovopayoutmedium() {
  maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "plinko_med");
}

playerplinkovopayoutlarge() {
  maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "plinko_lrg");
}