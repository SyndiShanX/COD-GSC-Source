/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_venomx_quest.gsc
**************************************************************/

venomx_init() {
  venomxquestregistration();
  initvenomxquestflags();
  level thread init_door_ent_model_update();
  level thread display_maze_hints_on_crt();
  level thread show_unsolved_mazes_on_crt();
  level thread init_tv_model_lines();
  level thread init_containment_pad_stuff();
}

init_door_ent_model_update() {
  var_0 = getent("fuse_box_door", "script_noteworthy");
  var_0 setModel("cp_final_ship_hallway_control_box_door");
}

init_containment_pad_stuff() {
  level.zomb_goal_containment_struct = scripts\engine\utility::getstruct("zomb_goal_containment", "script_noteworthy");
  level.containmentpadtop = getent("pad_top", "script_noteworthy");
  level.openpositioncontainmenttop = (939.5, 5620, 264);
  level.closedpositioncontainmenttop = level.containmentpadtop.origin;
  level.containmentpadbottom = getent("pad_bottom", "script_noteworthy");
  level.closedpositioncontainmentbottom = level.containmentpadbottom.origin;
  level.openpositioncontainmentbottom = (939.5, 5620, -8);
  level.timeperiodmodel = getent("timeperiod_model", "script_noteworthy");
  wait(10);
  level thread unblock_venomx_pad();
}

unblock_venomx_pad() {
  level.containmentpadtop moveto(level.openpositioncontainmenttop, 0.2);
  level.containmentpadbottom moveto(level.openpositioncontainmentbottom, 0.2);
  var_0 = getent("venomx_pad_blocker", "script_noteworthy");
  var_0 notsolid();
  var_0 connectpaths();
  scripts\engine\utility::play_sound_in_space("zmb_containment_pod_open", level.zomb_goal_containment_struct.origin);
  level.zombie_trap = getent("zombie_trap", "script_noteworthy");
  level.zombie_trap hide();
}

block_venomx_pad() {
  level.containmentpadtop moveto(level.closedpositioncontainmenttop, 0.2);
  level.containmentpadbottom moveto(level.closedpositioncontainmentbottom, 0.2);
  var_0 = getent("venomx_pad_blocker", "script_noteworthy");
  var_0 solid();
  var_0 disconnectpaths();
  scripts\engine\utility::play_sound_in_space("zmb_containment_pod_close", level.zomb_goal_containment_struct.origin);
  level.zombie_trap show();
}

movemodelwithdpad(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self notifyonplayercommand("pad_up", "+actionslot 1");
  self notifyonplayercommand("pad_down", "+actionslot 2");
  self notifyonplayercommand("pad_left", "+actionslot 3");
  self notifyonplayercommand("pad_right", "+actionslot 4");
  var_2 = "";
  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_return("pad_up", "pad_down", "pad_left", "pad_right");
    if(!isDefined(var_2)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    switch (var_2) {
      case "pad_up":
        var_0 moveto(level.openpositioncontainmenttop, 0.2);
        break;

      case "pad_down":
        var_1 moveto(level.openpositioncontainmentbottom, 0.2);
        break;

      case "pad_left":
        var_0 moveto(level.closedpositioncontainmenttop, 0.2);
        break;

      case "pad_right":
        var_1 moveto(level.closedpositioncontainmentbottom, 0.2);
        break;

      default:
        wait(1);
        break;
    }
  }
}

init_tv_model_lines() {
  wait(5);
  var_0 = [];
  var_1 = [(1574, 5393, 157.5), (1574, 5372.5, 157.5), (1570.5, 5393, 137.5), (1570.5, 5372.5, 137.5), (1362, 5372, 157.5), (1362, 5392.5, 157.5), (1365.5, 5372, 137.5), (1365.5, 5392.5, 137.5), (408.174, 5408.47, 184.5), (393.678, 5393.97, 184.5), (405.699, 5410.94, 164.5), (391.203, 5396.45, 164.5), (511.5, 4249.5, 288.5), (532, 4249.5, 288.5), (511.5, 4246, 268.5), (532, 4246, 268.5)];
  var_2 = [(0, 0, 0), (0, 0, 0), (12, 0, 0), (12, 0, 0), (0, 180, 0), (0, 180, 0), (12, 180, 0), (12, 180, 0), (0, 315, 0), (0, 315, 0), (12, 315, 0), (12, 315, 0), (0, 90, 0), (0, 90, 0), (12, 90, 0), (12, 90, 0)];
  for(var_3 = 0; var_3 < 16; var_3++) {
    var_4 = spawn("script_model", var_1[var_3]);
    var_4 setModel("tag_origin_venomx_puzzle");
    var_4.angles = var_2[var_3];
    var_4 setscriptablepartstate("solved_grid", "neutral");
    level.array_of_small_crt_script_models[var_3] = var_4;
  }
}

init_timer_texture() {
  wait(10);
  level.timertexturearr = getEntArray("venomx_timer", "script_noteworthy");
  setomnvar("zombie_venomxTimer", 666);
  foreach(var_1 in level.timertexturearr) {
    switch (var_1.name) {
      case "venomx_timer_01":
        var_1.origin = (865.5, 5620, 201);
        var_1.angles = (0, 270, 90);
        setomnvar("zm_ui_venomx_timer_ent_0", var_1);
        break;

      case "venomx_timer_02":
        var_1.origin = (939.5, 5694, 201);
        var_1.angles = (0, 180, 90);
        setomnvar("zm_ui_venomx_timer_ent_1", var_1);
        break;

      case "venomx_timer_03":
        var_1.origin = (939.5, 5546, 201);
        var_1.angles = (0, 0, 90);
        setomnvar("zm_ui_venomx_timer_ent_2", var_1);
        break;

      case "venomx_timer_04":
        var_1.origin = (1013.5, 5620, 201);
        var_1.angles = (0, 90, 90);
        setomnvar("zm_ui_venomx_timer_ent_3", var_1);
        break;
    }
  }
}

move_venomx_locker_door(var_0) {
  var_1 = getent("venomx_locker_door", "script_noteworthy");
  if(var_0) {
    var_1 rotateto((0, 105, 0), 0.1);
    return;
  }

  var_1 rotateto((0, 315, 0), 0.1);
}

setup_wire_models() {
  level.number_of_wires = reroll_number_of_wires();
  level.wire_active_fx = spawnfx(level._effect["vfx_venmox_spark"], (812, 4730, 175));
  setup_wires(level.number_of_wires);
}

setup_wires(var_0) {
  level.wire_models = [];
  var_1 = scripts\engine\utility::getstructarray("wire_puzzle_model", "script_noteworthy");
  var_2 = ["red", "blue", "green", "black", "white", "yellow"];
  var_3 = ["cp_final_control_box_button_01_red", "cp_final_control_box_button_01_black", "cp_final_control_box_button_01_blue", "cp_final_control_box_button_01_green", "cp_final_control_box_button_01_white", "cp_final_control_box_button_01_yellow"];
  var_4 = [(813.5, 4734.1, 165.9), (813.5, 4734.1, 160.9), (813.5, 4734.1, 156.9), (813.5, 4734.1, 152.9), (813.5, 4734.1, 148.9), (813.5, 4734.1, 144.9)];
  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = scripts\engine\utility::random(var_1);
    level.wire_models[var_5] = var_6;
    switch (var_6.name) {
      case "wire_puzzle_6":
      case "wire_puzzle_5":
      case "wire_puzzle_4":
      case "wire_puzzle_3":
      case "wire_puzzle_2":
      case "wire_puzzle_1":
        break;
    }

    level.wire_models[var_5].wire_num = var_5 + 1;
    var_7 = spawn("script_model", var_4[var_5]);
    var_8 = scripts\engine\utility::random(var_3);
    var_7 setModel(var_8);
    var_7.angles = (0, 180, 0);
    var_9 = strtok(var_8, "_");
    level.wire_models[var_5].model = var_7;
    level.wire_models[var_5].color = var_9[6];
    var_1 = scripts\engine\utility::array_remove(var_1, var_6);
  }
}

setup_maze_models() {
  level.unsolved_struct_positions_array = scripts\engine\utility::getstructarray("unsolved_grid_start", "script_noteworthy");
  foreach(var_1 in level.unsolved_struct_positions_array) {
    var_2 = strtok(var_1.name, "_");
    var_1.x_coord = int(var_2[3]);
    var_1.y_coord = int(var_2[4]);
  }

  level.test_model = spawn("script_model", level.unsolved_struct_positions_array[1].origin + (-1, 0, 0));
  level.test_model.mod_name = "maze1";
  level.test_model.angles = (340.8, 269.6, -0.00136747);
  level.test_model setModel("tag_origin_venomx_puzzle");
  level.test_model setscriptablepartstate("maze_puzzle", "neutral");
  level.unsolved_struct_positions_array_2 = scripts\engine\utility::getstructarray("unsolved_grid_start_2", "script_noteworthy");
  foreach(var_5 in level.unsolved_struct_positions_array_2) {
    var_2 = strtok(var_5.name, "_");
    var_5.x_coord = int(var_2[3]);
    var_5.y_coord = int(var_2[4]);
  }

  level.test_model_2 = spawn("script_model", level.unsolved_struct_positions_array_2[1].origin + (-1, 0, 0));
  level.test_model_2.mod_name = "maze2";
  level.test_model_2.angles = (340.8, 269.6, -0.00136747);
  level.test_model_2 setModel("tag_origin_venomx_puzzle");
  level.test_model_2 setscriptablepartstate("maze_puzzle", "neutral");
}

start_maze_instance(var_0) {
  level.test_model = spawn("script_model", level.unsolved_struct_positions_array[1].origin + (-1, 0, 0));
  level.test_model.mod_name = "maze1";
  level.test_model.angles = (340.099, 270.085, 0.00674522);
  level.test_model setModel("tag_origin_venomx_puzzle");
  level.test_model setscriptablepartstate("maze_puzzle", "neutral");
  level.test_model_2 = spawn("script_model", level.unsolved_struct_positions_array_2[1].origin + (-1, 0, 0));
  level.test_model_2.mod_name = "maze2";
  level.test_model_2.angles = (340.8, 269.6, -0.00136747);
  level.test_model_2 setModel("tag_origin_venomx_puzzle");
  level.test_model_2 setscriptablepartstate("maze_puzzle", "neutral");
  level.test_model.newmodelsspawned = 1;
  level.test_model.othermodel = level.test_model_2;
  level.test_model_2.newmodelsspawned = 1;
  level.test_model_2.othermodel = level.test_model;
  level.maze_completed["maze1"] = 0;
  level.maze_completed["maze2"] = 0;
  createmaze(level.test_model, level.test_model_2, var_0);
}

start_maze_instance_on_model(var_0, var_1, var_2) {
  var_3 = undefined;
  if(var_2.name == "unsolved_console_venomx") {
    var_3 = spawn("script_model", level.unsolved_struct_positions_array[1].origin + (-1, 0, 0));
    var_3.mod_name = "maze1";
    var_3.angles = (340.8, 269.6, -0.00136747);
    var_3 setModel("tag_origin_venomx_puzzle");
    var_3 setscriptablepartstate("maze_puzzle", "neutral");
    level.test_model = var_3;
    level.test_model_2.othermodel = level.test_model;
  } else {
    var_3 = spawn("script_model", level.unsolved_struct_positions_array_2[1].origin + (-1, 0, 0));
    var_3.mod_name = "maze2";
    var_3.angles = (340.8, 269.6, -0.00136747);
    var_3 setModel("tag_origin_venomx_puzzle");
    var_3 setscriptablepartstate("maze_puzzle", "neutral");
    level.test_model_2 = var_3;
    level.test_model.othermodel = level.test_model_2;
  }

  var_3.newmodelsspawned = var_1.newmodelsspawned;
  var_1 delete();
  if(var_3.mod_name == "maze1") {
    var_3.othermodel = level.test_model_2;
    var_3.othermodel.newmodelsspawned = level.test_model_2.newmodelsspawned;
  } else {
    var_3.othermodel = level.test_model;
    var_3.othermodel.newmodelsspawned = level.test_model.newmodelsspawned;
  }

  createmazeonmodel(var_3, var_0, var_2);
}

createmazeonmodel(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    var_4 thread control_puzzle_cursor(var_0);
  }

  if(!isDefined(level.maze_attributes)) {
    level.maze_attributes = [];
  }

  level.random_maze_roll = [];
  level.maze_attributes[var_0.mod_name] = spawnStruct();
  level.maze_attributes[var_0.mod_name].maze = [];
  for(var_6 = 0; var_6 < 6; var_6++) {
    for(var_7 = 0; var_7 < 6; var_7++) {
      foreach(var_0A, var_9 in level.maze_attributes) {
        if(var_0A == var_0.mod_name) {
          var_9.maze[var_6][var_7] = spawnStruct();
          var_9.maze[var_6][var_7].wall_directions = [];
          var_9.maze[var_6][var_7].visited = 0;
        }
      }
    }
  }

  var_0 setscriptablepartstate("maze_puzzle", "cursor");
  foreach(var_0E, var_0C in level.array_of_small_crt_script_models) {
    var_0D = var_0E;
    if(var_0D > 10) {
      var_0D = randomintrange(0, 11);
    }

    var_0C setscriptablepartstate("solved_grid", "solved_puzzle_" + var_0D);
  }

  if(!isDefined(level.mazerollsarray)) {
    level.mazerollsarray = [];
  }

  foreach(var_0E, var_10 in level.maze_attributes) {
    if(var_0E == var_0.mod_name) {
      level.random_maze_roll[var_0E] = random_maze_roll();
      level thread store_wall_directions(var_10, level.random_maze_roll[var_0E]);
    }
  }

  level thread choose_start_end_mazepos(var_0, level.random_maze_roll[var_0.mod_name]);
  var_2 setscriptablepartstate("unsolved_grid", "unsolved_maze_" + level.random_maze_roll[var_0.mod_name]);
}

disable_scriptables_for_mazes(var_0) {
  if(var_0.mod_name == "maze1") {
    level.test_model setscriptablepartstate("maze_puzzle", "neutral");
    level.unsolved_crt_model setscriptablepartstate("unsolved_grid", "neutral");
    return;
  }

  level.test_model_2 setscriptablepartstate("maze_puzzle", "neutral");
  level.unsolved_crt_model_2 setscriptablepartstate("unsolved_grid", "neutral");
}

disable_solved_grids() {
  foreach(var_1 in level.array_of_small_crt_script_models) {
    var_1 setscriptablepartstate("solved_grid", "neutral");
  }
}

return_position_x_y(var_0, var_1, var_2) {
  if(var_2.mod_name == "maze1") {
    foreach(var_4 in level.unsolved_struct_positions_array) {
      if(var_4.x_coord == var_0 && var_4.y_coord == var_1) {
        return var_4.origin;
      }
    }

    return;
  }

  foreach(var_7 in level.unsolved_struct_positions_array_2) {
    if(var_7.x_coord == var_0 && var_7.y_coord == var_1) {
      return var_7.origin;
    }
  }
}

input_cursor(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("one_cursor_thread_for_" + var_0.mod_name + "_for_" + self.name);
  self endon("one_cursor_thread_for_" + var_0.mod_name + "_for_" + self.name);
  self endon("end_thread_for_" + var_0.mod_name);
  level endon("end_locking_threads_on_the_player_for_venomx_cursor");
  self notifyonplayercommand("venomxmove_up", "+actionslot 1");
  self notifyonplayercommand("venomxmove_down", "+actionslot 2");
  self notifyonplayercommand("venomxmove_left", "+actionslot 3");
  self notifyonplayercommand("venomxmove_right", "+actionslot 4");
  var_2 = "";
  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_return("venomxmove_up", "venomxmove_down", "venomxmove_left", "venomxmove_right");
    if(distance2dsquared(var_0.origin, self.origin) > 8100) {
      var_0 hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!self worldpointinreticle_circle(var_0.origin, 100, 90)) {
      var_0 hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(var_2)) {
      var_0 hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(level.trapped_zombie) || !isDefined(var_0)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!scripts\engine\utility::istrue(level.masterpcinteraction.triggeredsuser)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(isDefined(level.maze_completed)) {
      if(scripts\engine\utility::istrue(level.maze_completed[var_0.mod_name])) {
        scripts\engine\utility::waitframe();
        continue;
      }
    }

    if(scripts\engine\utility::istrue(level.failed_puzzle)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_0 hudoutlineenableforclient(self, 3, 1, 0);
    thread run_disable_player_actions_logic();
    self playlocalsound("cp_final_venom_quest_move_red_square");
    switch (var_2) {
      case "venomxmove_up":
        runmazeinstanceforpoint(level.maze_attributes[var_0.mod_name].maze, var_0.xcoord - 1, var_0.ycoord, "up", var_0, self, var_1);
        wait(1);
        break;

      case "venomxmove_down":
        runmazeinstanceforpoint(level.maze_attributes[var_0.mod_name].maze, var_0.xcoord + 1, var_0.ycoord, "down", var_0, self, var_1);
        wait(1);
        break;

      case "venomxmove_left":
        runmazeinstanceforpoint(level.maze_attributes[var_0.mod_name].maze, var_0.xcoord, var_0.ycoord - 1, "left", var_0, self, var_1);
        wait(1);
        break;

      case "venomxmove_right":
        runmazeinstanceforpoint(level.maze_attributes[var_0.mod_name].maze, var_0.xcoord, var_0.ycoord + 1, "right", var_0, self, var_1);
        wait(1);
        break;

      default:
        wait(1);
        break;
    }

    self._phone_exit_move = undefined;
    self._phone_exit_damage = undefined;
    self notify("phonebooth_end");
    self notify("moved_cursor");
  }
}

input_cursor_maze2(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("one_cursor_thread_for_" + var_0.mod_name + "_for_" + self.name);
  self endon("one_cursor_thread_for_" + var_0.mod_name + "_for_" + self.name);
  self endon("end_thread_for_" + var_0.mod_name);
  level endon("end_locking_threads_on_the_player_for_venomx_cursor");
  self notifyonplayercommand("venomxmove_up", "+actionslot 1");
  self notifyonplayercommand("venomxmove_down", "+actionslot 2");
  self notifyonplayercommand("venomxmove_left", "+actionslot 3");
  self notifyonplayercommand("venomxmove_right", "+actionslot 4");
  var_2 = "";
  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_return("venomxmove_up", "venomxmove_down", "venomxmove_left", "venomxmove_right");
    if(distance2dsquared(var_0.origin, self.origin) > 8100) {
      var_0 hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!self worldpointinreticle_circle(var_0.origin, 100, 90)) {
      var_0 hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(var_2)) {
      var_0 hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(level.trapped_zombie) || !isDefined(var_0)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!scripts\engine\utility::istrue(level.masterpcinteraction.triggeredsuser)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(isDefined(level.maze_completed)) {
      if(scripts\engine\utility::istrue(level.maze_completed[var_0.mod_name])) {
        scripts\engine\utility::waitframe();
        continue;
      }
    }

    if(scripts\engine\utility::istrue(level.failed_puzzle)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_0 hudoutlineenableforclient(self, 3, 1, 0);
    thread run_disable_player_actions_logic();
    self playlocalsound("cp_final_venom_quest_move_red_square");
    switch (var_2) {
      case "venomxmove_up":
        runmazeinstanceforpoint(level.maze_attributes[var_0.mod_name].maze, var_0.xcoord - 1, var_0.ycoord, "up", var_0, self, var_1);
        wait(1);
        break;

      case "venomxmove_down":
        runmazeinstanceforpoint(level.maze_attributes[var_0.mod_name].maze, var_0.xcoord + 1, var_0.ycoord, "down", var_0, self, var_1);
        wait(1);
        break;

      case "venomxmove_left":
        runmazeinstanceforpoint(level.maze_attributes[var_0.mod_name].maze, var_0.xcoord, var_0.ycoord - 1, "left", var_0, self, var_1);
        wait(1);
        break;

      case "venomxmove_right":
        runmazeinstanceforpoint(level.maze_attributes[var_0.mod_name].maze, var_0.xcoord, var_0.ycoord + 1, "right", var_0, self, var_1);
        wait(1);
        break;

      default:
        wait(1);
        break;
    }

    self._phone_exit_move = undefined;
    self._phone_exit_damage = undefined;
    self notify("phonebooth_end");
    self notify("moved_cursor");
  }
}

run_disable_player_actions_logic() {
  self endon("disconnect");
  self notify("one_cursor_thread_only_for" + self.name);
  self endon("one_cursor_thread_only_for" + self.name);
  var_0 = self;
  var_0.attemptingpuzzle = 1;
  var_0 thread phone_exit_move();
  var_0 thread phone_exit_damage();
  var_0 notifyonplayercommand("exit_phonebooth", "+stance");
  var_0 notifyonplayercommand("exit_phonebooth", "+goStand");
  var_0 notifyonplayercommand("exit_phonebooth", "+melee_zoom");
  var_0 notifyonplayercommand("exit_phonebooth", "+breath_sprint");
  var_0 notifyonplayercommand("exit_phonebooth", "+frag");
  var_0 notifyonplayercommand("exit_phonebooth", "+smoke");
  scripts\engine\utility::waittill_any_ents(var_0, "exit_phonebooth", level, "end_locking_threads_on_the_player_for_venomx_cursor");
  wait(0.05);
  var_0.attemptingpuzzle = undefined;
}

phone_exit_move() {
  self endon("phonebooth_end");
  self endon("disconnect");
  level endon("end_locking_threads_on_the_player_for_venomx_cursor");
  var_0 = 0;
  for(;;) {
    var_1 = self getnormalizedmovement();
    if(var_1[0] != 0 || var_1[1] != 0) {
      var_0++;
      if(var_0 == 1) {
        self._phone_exit_move = 1;
        self notify("exit_phonebooth");
      }
    } else {
      var_0 = 0;
    }

    wait(0.1);
  }
}

phone_exit_damage() {
  self endon("disconect");
  self endon("phonebooth_end");
  level endon("end_locking_threads_on_the_player_for_venomx_cursor");
  self waittill("damage");
  self._phone_exit_damage = 1;
  self notify("exit_phonebooth");
}

player_clock_tick_sfx(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_1 playLoopSound("quest_rewind_clock_tick_long");
  level waittill("containment_timer_sfx_done");
  var_1 stoploopsound();
  var_1 delete();
}

timer_progress(var_0, var_1, var_2, var_3) {
  var_4 = level.puzzles_duration;
  if(getdvar("scr_puzzles_timer", "") != "") {
    var_4 = 500000;
  }

  if(level.players.size < 2) {
    var_4 = 300000;
  }

  setomnvar("zombie_venomxTimer", int(var_4 / 1000));
  wait(1);
  level thread player_clock_tick_sfx(var_2);
  while(gettime() <= var_0 + var_4) {
    if(!scripts\engine\utility::flag("completepuzzles_step4")) {
      if(scripts\engine\utility::istrue(level.failed_puzzle)) {
        break;
      }

      if(!scripts\engine\utility::istrue(var_1.stop_triggering_zombies)) {
        break;
      }

      if(!isDefined(level.trapped_zombie)) {
        break;
      }

      if(isDefined(level.maze_completed)) {
        if(scripts\engine\utility::istrue(level.maze_completed["maze1"]) && scripts\engine\utility::istrue(level.maze_completed["maze2"])) {
          break;
        }
      }
    }

    setomnvar("zombie_venomxTimer", int(var_4 + var_0 - gettime() / 1000));
    wait(1);
  }

  level notify("containment_timer_sfx_done");
  level notify("end_locking_threads_on_the_player_for_venomx_cursor");
  wait(1);
  level thread unblock_venomx_pad();
  setomnvar("zombie_venomxTimer", 0);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_3);
  if(isDefined(level.masterpcinteraction)) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(level.masterpcinteraction);
  }

  var_1.stop_triggering_zombies = 0;
  if(isDefined(level.trapped_zombie) && level.trapped_zombie scripts\cp\utility::is_zombie_agent()) {
    level.trapped_zombie.precacheleaderboards = 0;
    level.trapped_zombie.dont_cleanup = 0;
    level.trapped_zombie.desired_dance_angles = (0, 0, 0);
    level.trapped_zombie.dont_scriptkill = 0;
    level.trapped_zombie.dontmutilate = 0;
    level.trapped_zombie.full_gib = 1;
    level.trapped_zombie.nocorpse = 1;
    level.trapped_zombie.scripted_mode = 0;
    playFX(level._effect["vfx_venmox_spark_expl"], level.trapped_zombie.origin);
    level.trapped_zombie dodamage(level.trapped_zombie.health + 100000, level.trapped_zombie.origin, var_2, var_2);
  }

  level.no_zombie_trapped = 1;
  if(isDefined(level.masterpcinteraction)) {
    level.masterpcinteraction.triggeredsuser = 0;
    level.masterpcinteraction.triggeredsuser_ent = undefined;
  }

  if(isDefined(level.puzzles_solved) && level.puzzles_solved == 4) {
    return;
  }

  if(isDefined(level.maze_completed)) {
    if(scripts\engine\utility::istrue(level.maze_completed["maze1"])) {
      level.maze_completed["maze1"] = 0;
    }

    if(scripts\engine\utility::istrue(level.maze_completed["maze2"])) {
      level.maze_completed["maze2"] = 0;
    }
  }

  level.test_model.newmodelsspawned = 1;
  level.test_model_2.newmodelsspawned = 1;
  level.puzzles_solved = 0;
  var_2 thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_detainment_kill", "final_comment_vo", "highest", 999, 1, 0, 1, 100);
  level thread delay_containment_for_a_wave(var_2);
}

delay_containment_for_a_wave(var_0) {
  level thread disable_scriptables_for_mazes(level.test_model);
  level thread disable_scriptables_for_mazes(level.test_model_2);
  level thread disable_solved_grids();
  var_1 = getrandomnavpoints(var_0.origin, 200, 5);
  level thread start_fake_spawn_sequence(var_0, scripts\engine\utility::random(var_1));
  level.disable_containment = 1;
  level waittill("spawn_wave_done");
  level.disable_containment = 0;
  level.failed_puzzle = 0;
}

update_player_monitor_wires(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  level endon("end_wire_threads");
  self notify("one_player_monitor_thread_for_" + self.name + var_0.name);
  self endon("one_player_monitor_thread_for_" + self.name + var_0.name);
  for(;;) {
    scripts\engine\utility::waitframe();
    if(scripts\engine\utility::istrue(self.iscarrying)) {
      continue;
    }

    if(distancesquared(self.origin, var_0.origin) > 8100) {
      continue;
    }

    if(!scripts\engine\utility::istrue(level.electric_phantom_completed)) {
      continue;
    }

    update_wires_state_for_player(self, var_0);
  }
}

move_fuse_box_door(var_0) {
  var_1 = getent("fuse_box_door", "script_noteworthy");
  var_2 = "";
  if(var_0) {
    var_2 = "zmb_venx_fuse_box_open";
    var_1 rotateto((0, 57.6995, 0), 0.1);
  } else {
    var_2 = "zmb_venx_fuse_box_close";
    var_1 rotateto((0, 180, 0), 0.1);
  }

  playsoundatpos(var_1.origin, var_2);
}

update_wires_state_for_player(var_0, var_1) {
  var_0 endon("disconnect");
  level endon("end_wire_threads");
  var_0 notify("one_wirestate_thread_for_" + var_0.name + var_1.name);
  var_0 endon("one_wirestate_thread_for_" + var_0.name + var_1.name);
  if(!var_0 worldpointinreticle_circle(var_1.model.origin, 25, 90)) {
    var_1.model hudoutlinedisableforclient(var_0);
    scripts\engine\utility::waitframe();
    return;
  }

  level thread show_hint_for_time(2, var_0, var_1);
  var_1.model hudoutlineenableforclient(var_0, 3, 1, 0);
}

show_hint_for_time(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 notify("end_thread_instance");
  var_1 endon("end_thread_instance");
  level endon("end_wire_threads");
}

watch_for_input_entered_on_button(var_0) {
  self endon("disconnect");
  level endon("end_wire_threads");
  self notify("one_wireinput_thread_for_" + self.name + var_0.name);
  self endon("one_wireinput_thread_for_" + self.name + var_0.name);
  self notifyonplayercommand("select_button", "+usereload");
  self notifyonplayercommand("select_button", "+activate");
  var_1 = "";
  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_return("select_button");
    if(distance2dsquared(var_0.origin, self.origin) > 8100) {
      var_0.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!self worldpointinreticle_circle(var_0.model.origin, 25, 90)) {
      var_0.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(scripts\engine\utility::istrue(level.wire_struct_disabled)) {
      thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_fusebox_disabled_fail", "final_comment_vo", "highest", 999, 1, 0, 1, 100);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isDefined(var_1)) {
      var_0.model hudoutlinedisableforclient(self);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!scripts\engine\utility::istrue(level.electric_phantom_completed)) {
      thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_fusebox_disabled", "final_comment_vo", "highest", 999, 1, 0, 1, 100);
      scripts\engine\utility::waitframe();
      continue;
    }

    var_0.model hudoutlineenableforclient(self, 3, 1, 0);
    if(var_1 == "select_button") {
      thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_fusebox_interact", "final_comment_vo", "highest", 999, 1, 0, 1, 100);
      if(validate_wire_logic(var_0)) {
        self playlocalsound("zmb_item_pickup");
        var_0.model hudoutlinedisableforclient(self);
        level.unlocked_zombie_containment_device = 1;
        level.wire_struct_disabled = undefined;
        thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_fusebox_success", "final_comment_vo", "highest", 999, 1, 0, 1, 100);
        playsoundatpos(var_0.origin, "zmb_venx_success");
        scripts\engine\utility::flag_set("disablesecurity_step3");
        continue;
      }

      if(randomint(100) > 50) {
        thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_safe_input_fail", "final_comment_vo", "highest", 999, 1, 0, 1, 100);
      } else {
        thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_fusebox_fail", "final_comment_vo", "highest", 999, 1, 0, 1, 100);
      }

      playsoundatpos(var_0.model.origin, "mpq_fail_buzzer");
      var_2 = getrandomnavpoints((255, 4960, 120), 500, 5);
      level thread start_fake_spawn_sequence(self, scripts\engine\utility::random(var_2));
      wait(2);
      level.wire_struct_disabled = 1;
      level thread enable_wire_struct_next_wave();
    }
  }
}

wire_color_count_func(var_0) {
  var_1 = 0;
  foreach(var_3 in level.wire_models) {
    if(var_3.color == var_0) {
      var_1++;
    }
  }

  return var_1;
}

validate_wire_logic(var_0) {
  switch (level.number_of_wires) {
    case 3:
      if(wire_color_count_func("black") == 0) {
        if(var_0.wire_num == 3) {
          return 1;
        } else {
          return 0;
        }
      } else if(level.wire_models[level.wire_models.size - 1].color == "green") {
        if(var_0.wire_num == 1) {
          return 1;
        } else {
          return 0;
        }
      } else if(wire_color_count_func("red") > 1) {
        var_1 = level.wire_models[0];
        for(var_2 = level.wire_models.size - 1; var_2 >= 0; var_2--) {
          if(level.wire_models[var_2].color == "red") {
            var_1 = level.wire_models[var_2];
            break;
          }
        }

        if(var_1 == var_0) {
          return 1;
        } else {
          return 0;
        }
      } else if(var_0.wire_num == 2) {
        return 1;
      } else {
        return 0;
      }
      break;

    case 4:
      if(wire_color_count_func("yellow") > 1 && level.specialwavescompleted >= 2) {
        var_1 = level.wire_models[0];
        for(var_2 = level.wire_models.size - 1; var_2 >= 0; var_2--) {
          if(level.wire_models[var_2].color == "yellow") {
            var_1 = level.wire_models[var_2];
            break;
          }
        }

        if(var_1 == var_0) {
          return 1;
        } else {
          return 0;
        }
      } else {
        var_3 = level.wire_models[level.wire_models.size - 1];
        if(var_3.color == "white" && wire_color_count_func("blue") == 0) {
          if(var_0.wire_num == 1) {
            return 1;
          } else {
            return 0;
          }
        } else if(wire_color_count_func("black") > 1) {
          if(var_0.wire_num == level.number_of_wires) {
            return 1;
          } else {
            return 0;
          }
        } else if(var_0.wire_num == 3) {
          return 1;
        } else {
          return 0;
        }
      }
      break;

    case 5:
      if(level.wave_num <= 3) {
        if(var_0.wire_num == 1) {
          return 1;
        } else {
          return 0;
        }
      } else if(wire_color_count_func("white") == 1 && wire_color_count_func("blue") > 1) {
        if(var_0.wire_num == 2) {
          return 1;
        } else {
          return 0;
        }
      } else if(wire_color_count_func("red") == 0 && level.wave_num % 2 == 0 && level.specialwavescompleted < 4) {
        if(var_0.wire_num == level.number_of_wires) {
          return 1;
        } else {
          return 0;
        }
      } else if(var_0.wire_num == 1) {
        return 1;
      } else {
        return 0;
      }
      break;

    case 6:
      if(wire_color_count_func("yellow") != 0) {
        if(var_0.wire_num == 3) {
          return 1;
        } else {
          return 0;
        }
      } else if(wire_color_count_func("black") == 1 && wire_color_count_func("white") > 1) {
        if(var_0.wire_num == 4) {
          return 1;
        } else {
          return 0;
        }
      } else if(level.specialwavescompleted >= 1 && wire_color_count_func("red") > 1) {
        if(var_0.wire_num == 5) {
          return 1;
        } else {
          return 0;
        }
      } else if(var_0.wire_num == level.number_of_wires) {
        return 1;
      } else {
        return 0;
      }
      break;

    default:
      break;
  }
}

enable_wire_struct_next_wave() {
  level thread move_fuse_box_door(0);
  foreach(var_1 in level.wire_models) {
    var_1.model delete();
  }

  if(isDefined(level.wire_active_fx)) {
    level.wire_active_fx delete();
  }

  level.wire_models = [];
  level notify("end_wire_threads");
  level waittill("spawn_wave_done");
  level thread move_fuse_box_door(1);
  setup_wire_models();
  foreach(var_4 in level.players) {
    foreach(var_1 in level.wire_models) {
      var_4 thread update_player_monitor_wires(var_1);
      var_4 thread watch_for_input_entered_on_button(var_1);
    }
  }

  level.wire_struct_disabled = undefined;
}

setup_backstory_interaction(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_0A = spawnStruct();
  var_0A.script_noteworthy = "backstory_interaction";
  var_0A.origin = (-213.9, 5640, 95.6);
  var_0A.angles = (0, 288.9, 0);
  var_0A.name = "backstory_interaction";
  var_0A.hint_func = var_4;
  var_0A.spend_type = var_2;
  var_0A.tutorial = var_3;
  var_0A.activation_func = var_5;
  var_0A.enabled = 1;
  var_0A.disable_guided_interactions = 0;
  var_0A.script_parameters = "default";
  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_0A.cost = var_6;
  var_0A.requires_power = 0;
  var_0A.powered_on = 1;
  var_0A.init_func = var_8;
  var_0A.can_use_override_func = var_9;
  level.interactions[var_1] = var_0A;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0A);
}

init_venomx_models_interactions() {
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "containment_interaction", undefined, undefined, ::containmentinteractionhintfunc, ::containmentinteractionusefunc, 0, 1, ::blank);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "master_pc_interaction", undefined, undefined, ::master_pcinteractionhintfunc, ::master_pcinteractionusefunc, 0, 1, ::blank);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "timeperiod_interaction", undefined, undefined, ::timeperiodinteractionhintfunc, ::timeperiodinteractionusefunc, 0, 1, ::blank);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "morsecode_interaction", undefined, undefined, ::morsecodeinteractionhintfunc, ::morsecodeinteractionusefunc, 0, 1, ::blank);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "key_interaction", undefined, undefined, ::keyinteractionhintfunc, ::keyinteractionusefunc, 0, 1, ::blank);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "dot_interaction", undefined, undefined, ::dotinteractionhintfunc, ::dotinteractionusefunc, 0, 1, ::blank);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "dash_interaction", undefined, undefined, ::dashinteractionhintfunc, ::dashinteractionusefunc, 0, 1, ::blank);
  level thread setup_backstory_interaction(1, "backstory_interaction", undefined, undefined, ::backstoryinteractionhintfunc, ::backstoryinteractionusefunc, 0, 0, ::blank);
  level thread setup_wire_models();
  level thread init_timer_texture();
  if(!isDefined(level.alphabets)) {
    level.alphabets = [];
    level.alphabets["a"] = level.alphabets.size;
    level.alphabets["b"] = level.alphabets.size;
    level.alphabets["c"] = level.alphabets.size;
    level.alphabets["d"] = level.alphabets.size;
    level.alphabets["e"] = level.alphabets.size;
    level.alphabets["f"] = level.alphabets.size;
    level.alphabets["g"] = level.alphabets.size;
    level.alphabets["h"] = level.alphabets.size;
    level.alphabets["i"] = level.alphabets.size;
    level.alphabets["j"] = level.alphabets.size;
    level.alphabets["k"] = level.alphabets.size;
    level.alphabets["l"] = level.alphabets.size;
    level.alphabets["m"] = level.alphabets.size;
    level.alphabets["n"] = level.alphabets.size;
    level.alphabets["o"] = level.alphabets.size;
    level.alphabets["p"] = level.alphabets.size;
    level.alphabets["q"] = level.alphabets.size;
    level.alphabets["r"] = level.alphabets.size;
    level.alphabets["s"] = level.alphabets.size;
    level.alphabets["t"] = level.alphabets.size;
    level.alphabets["u"] = level.alphabets.size;
    level.alphabets["v"] = level.alphabets.size;
    level.alphabets["w"] = level.alphabets.size;
    level.alphabets["x"] = level.alphabets.size;
    level.alphabets["y"] = level.alphabets.size;
    level.alphabets["z"] = level.alphabets.size;
  }

  if(!isDefined(level.alphabets_capped)) {
    level.alphabets_capped = [];
    level.alphabets_capped["A"] = level.alphabets_capped.size;
    level.alphabets_capped["B"] = level.alphabets_capped.size;
    level.alphabets_capped["C"] = level.alphabets_capped.size;
    level.alphabets_capped["D"] = level.alphabets_capped.size;
    level.alphabets_capped["E"] = level.alphabets_capped.size;
    level.alphabets_capped["F"] = level.alphabets_capped.size;
    level.alphabets_capped["G"] = level.alphabets_capped.size;
    level.alphabets_capped["H"] = level.alphabets_capped.size;
    level.alphabets_capped["I"] = level.alphabets_capped.size;
    level.alphabets_capped["J"] = level.alphabets_capped.size;
    level.alphabets_capped["K"] = level.alphabets_capped.size;
    level.alphabets_capped["L"] = level.alphabets_capped.size;
    level.alphabets_capped["M"] = level.alphabets_capped.size;
    level.alphabets_capped["N"] = level.alphabets_capped.size;
    level.alphabets_capped["O"] = level.alphabets_capped.size;
    level.alphabets_capped["P"] = level.alphabets_capped.size;
    level.alphabets_capped["Q"] = level.alphabets_capped.size;
    level.alphabets_capped["R"] = level.alphabets_capped.size;
    level.alphabets_capped["S"] = level.alphabets_capped.size;
    level.alphabets_capped["T"] = level.alphabets_capped.size;
    level.alphabets_capped["U"] = level.alphabets_capped.size;
    level.alphabets_capped["V"] = level.alphabets_capped.size;
    level.alphabets_capped["W"] = level.alphabets_capped.size;
    level.alphabets_capped["X"] = level.alphabets_capped.size;
    level.alphabets_capped["Y"] = level.alphabets_capped.size;
    level.alphabets_capped["Z"] = level.alphabets_capped.size;
  }

  level.specialwavescompleted = 0;
  level.chosen_number_for_morse_code = 30;
  level.splcharbounties = ["fifteen", "eighteen", "twenty", "twentyfive", "thirty"];
  level.chosennumtext = scripts\engine\utility::random(level.splcharbounties);
  level.splcharbounties = scripts\engine\utility::array_remove(level.splcharbounties, level.chosennumtext);
  level.chosennumtextpap2 = scripts\engine\utility::random(level.splcharbounties);
  switch (level.chosennumtext) {
    case "fifteen":
      level.chosen_number_for_morse_code = 15;
      break;

    case "eighteen":
      level.chosen_number_for_morse_code = 18;
      break;

    case "twenty":
      level.chosen_number_for_morse_code = 20;
      break;

    case "twentyfive":
      level.chosen_number_for_morse_code = 25;
      break;

    case "thirty":
      level.chosen_number_for_morse_code = 30;
      break;
  }

  switch (level.chosennumtextpap2) {
    case "fifteen":
      level.chosen_number_for_morse_code_pap2 = 15;
      break;

    case "eighteen":
      level.chosen_number_for_morse_code_pap2 = 18;
      break;

    case "twenty":
      level.chosen_number_for_morse_code_pap2 = 20;
      break;

    case "twentyfive":
      level.chosen_number_for_morse_code_pap2 = 25;
      break;

    case "thirty":
      level.chosen_number_for_morse_code_pap2 = 30;
      break;
  }

  level.splcharagents = ["cryptids", "special.zombies"];
  level.splchosenagent = level.splcharagents[0];
  level.splcharagents = scripts\engine\utility::array_remove(level.splcharagents, level.splchosenagent);
  level.splchosenagentpap2 = scripts\engine\utility::random(level.splcharagents);
  var_0 = get_chars_of_word_with_spaces_between_letters(level.chosennumtext);
  var_0 = changearraytoword(var_0);
  var_1 = get_chars_of_word_with_spaces_between_letters(level.chosennumtextpap2);
  var_1 = changearraytoword(var_1);
  var_2 = get_chars_of_word_with_spaces_between_letters(level.splchosenagent);
  var_2 = changearraytoword(var_2);
  var_3 = get_chars_of_word_with_spaces_between_letters(level.splchosenagentpap2);
  var_3 = changearraytoword(var_3);
  level.mission_intel_array = ["i,n,t,e,l,o,n,e.z,o,n,e,o,f,a,c,t,i,o,n.p,o,r,t,a,l.", "i,n,t,e,l,t,w,o.o,n,e,j,o,e.a,t,f,r,o,n,t,l,i,n,e.", "i,n,t,e,l,t,h,r,e,e.t,h,e.n,u,m,b,e,r,s.m,e,a,n.e,v,e,r,y,t,h,i,n,g."];
  level.morsecodemessagesarray = ["k,i,l,l.o,v,e,r." + var_0 + "." + var_2, "k,i,l,l.o,v,e,r." + var_1 + "." + var_3 + ".a,n,d." + var_1 + "." + "h,i,d,d,e,n,f,i,g,u,r,e,s."];
  level.morsecodekeysarray = ["cross", "archer"];
  level.morsecodekeypap1 = scripts\engine\utility::random(level.morsecodekeysarray);
  level.morsecodekeysarray = scripts\engine\utility::array_remove(level.morsecodekeysarray, level.morsecodekeypap1);
  level.morsecodekeypap2 = scripts\engine\utility::random(level.morsecodekeysarray);
  level.morsedashmodel = getent("dot_button", "script_noteworthy");
  level.morsedotmodel = getent("dash_button", "script_noteworthy");
  level.zombie_venomx_containment_trigger = getent("zombie_containment_volume", "targetname");
  level.zombie_venomx_containment_trigger thread watch_for_containment_trigger();
  level.hidden_figures_volume = getent("hidden_figures_volume", "script_noteworthy");
  if(!isDefined(level.hidden_figures)) {
    level.hidden_figures = [];
  }

  level.hidden_figures[0] = spawnStruct();
  level.hidden_figures[0].origin = (3764, 6940, 227);
  level.hidden_figures[0].powered_on = 0;
  level.hidden_figures[0].requires_power = 0;
  level.hidden_figures[0].name = "hidden_figure_objects";
  level.hidden_figures[0].script_noteworthy = "fig_1";
  level.hidden_figures[0].script_parameters = "default";
  level.hidden_figures[0].var_336 = "interaction";
  var_4 = scripts\engine\utility::getstructarray("fig_1", "script_noteworthy");
  level.hidden_figures[1] = spawnStruct();
  level.hidden_figures[1].origin = (3764, 6940, 227);
  level.hidden_figures[1].powered_on = 0;
  level.hidden_figures[1].requires_power = 0;
  level.hidden_figures[1].name = "hidden_figure_objects";
  level.hidden_figures[1].script_noteworthy = "fig_2";
  level.hidden_figures[1].script_parameters = "default";
  level.hidden_figures[1].var_336 = "interaction";
  var_4 = scripts\engine\utility::getstructarray("fig_2", "script_noteworthy");
  level.hidden_figures[2] = spawnStruct();
  level.hidden_figures[2].origin = (3764, 6940, 227);
  level.hidden_figures[2].powered_on = 0;
  level.hidden_figures[2].requires_power = 0;
  level.hidden_figures[2].name = "hidden_figure_objects";
  level.hidden_figures[2].script_noteworthy = "fig_3";
  level.hidden_figures[2].script_parameters = "default";
  level.hidden_figures[2].var_336 = "interaction";
  var_4 = scripts\engine\utility::getstructarray("fig_3", "script_noteworthy");
  level.hidden_figures[3] = spawnStruct();
  level.hidden_figures[3].origin = (3764, 6940, 227);
  level.hidden_figures[3].powered_on = 0;
  level.hidden_figures[3].requires_power = 0;
  level.hidden_figures[3].name = "hidden_figure_objects";
  level.hidden_figures[3].script_noteworthy = "fig_4";
  level.hidden_figures[3].script_parameters = "default";
  level.hidden_figures[3].var_336 = "interaction";
  var_4 = scripts\engine\utility::getstructarray("fig_4", "script_noteworthy");
  foreach(var_6 in level.hidden_figures) {
    var_6.groupname = "locOverride";
    var_6.playeroffset = [];
    setup_hidden_figure_models(var_6, var_6.script_noteworthy);
  }
}

get_chars_of_word_with_spaces_between_letters(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_2] = var_0[var_2] + ",";
  }

  return var_1;
}

keyconversiontomorse(var_0) {
  convertwordintomorse(var_0, 1);
}

watch_for_containment_trigger() {
  for(;;) {
    self waittill("trigger", var_0);
    if(isplayer(var_0) && var_0 scripts\cp\utility::is_valid_player()) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(scripts\engine\utility::istrue(self.stop_triggering_zombies)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(scripts\engine\utility::istrue(level.disable_containment)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(var_0 scripts\cp\utility::is_zombie_agent()) {
      level.trapped_zombie = var_0;
      scripts\engine\utility::waitframe();
    }
  }
}

watch_for_zombie_death_containment(var_0) {
  self waittill("death");
  self.scripted_mode = 0;
  self.precacheleaderboards = 0;
  self.bhasdiscofever = 0;
  self.dontmutilate = 0;
  self.full_gib = 1;
  self.nocorpse = 1;
  self.dont_cleanup = 0;
  self.dont_scriptkill = 0;
  self.scripted_mode = 0;
  var_0.stop_triggering_zombies = 0;
  level.no_zombie_trapped = 1;
  level.trapped_zombie = undefined;
}

containmentinteractionusefunc(var_0, var_1) {
  var_1 endon("disconnect");
  if(scripts\engine\utility::flag_exist("disablesecurity_step3") && !scripts\engine\utility::flag("disablesecurity_step3")) {
    return;
  }

  if(scripts\engine\utility::istrue(level.disable_containment)) {
    var_1 playlocalsound("perk_machine_deny");
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(isDefined(level.trapped_zombie) && level.trapped_zombie istouching(level.zombie_venomx_containment_trigger)) {
    earthquake(0.45, 3, var_0.origin, 750);
    level.zombie_venomx_containment_trigger.stop_triggering_zombies = 1;
    level.trapped_zombie.scripted_mode = 1;
    level.trapped_zombie.precacheleaderboards = 1;
    level.trapped_zombie.dont_cleanup = 1;
    level.trapped_zombie.dont_scriptkill = 1;
    level.trapped_zombie.desired_dance_angles = (0, 0, 0);
    level.trapped_zombie.dontmutilate = 1;
    level.trapped_zombie give_mp_super_weapon(level.zomb_goal_containment_struct.origin);
    var_2 = level.trapped_zombie scripts\engine\utility::waittill_any_return("goal", "goal_reached", "death");
    if(var_2 == "death") {
      playsoundatpos(var_0.origin, "mpq_fail_buzzer");
      wait(3);
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
      return;
    }

    playFX(level._effect["temp_circuit_fx"], level.trapped_zombie.origin);
    level thread block_venomx_pad();
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_detainment_capture", "final_comment_vo", "highest", 999, 1, 0, 1, 100);
    level.trapped_zombie thread watch_for_zombie_death_containment(level.zombie_venomx_containment_trigger);
    var_3 = gettime();
    level thread timer_progress(var_3, level.zombie_venomx_containment_trigger, var_1, var_0);
    return;
  }

  playsoundatpos(var_0.origin, "mpq_fail_buzzer");
  wait(3);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

containmentinteractionhintfunc(var_0, var_1) {
  if(scripts\engine\utility::flag("disablesecurity_step3")) {
    return &"CP_FINAL_CONTAINMENT_CHAMBER";
  }

  return "";
}

master_pcinteractionusefunc(var_0, var_1) {
  var_1 endon("disconnect");
  level.masterpcinteraction = var_0;
  if(!isDefined(var_1.samcrossvoarr)) {
    var_1.samcrossvoarr = ["final_cross_log_1", "final_cross_log_2", "final_cross_log_3"];
  }

  var_1.chosensamcrossvo = scripts\engine\utility::random(var_1.samcrossvoarr);
  if(scripts\engine\utility::flag("completepuzzles_step4")) {
    if(var_1.samcrossvoarr.size > 0) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(var_1.chosensamcrossvo, "final_backstory_vo", "highest", 999, 1, 0, 1, 100);
      return;
    }

    return;
  }

  if(scripts\engine\utility::istrue(level.zombie_venomx_containment_trigger.stop_triggering_zombies) && !scripts\engine\utility::istrue(level.masterpcinteraction.triggeredsuser)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(level.masterpcinteraction);
    var_1 playlocalsound("cp_final_venom_quest_turn_on_console");
    playFX(level._effect["temp_circuit_fx"], var_0.origin);
    level thread start_maze_instance(var_1);
    level.masterpcinteraction.triggeredsuser = 1;
    level.masterpcinteraction.triggeredsuser_ent = var_1;
    return;
  }
}

master_pcinteractionhintfunc(var_0, var_1) {
  if(scripts\engine\utility::flag("disablesecurity_step3") && !scripts\engine\utility::flag("completepuzzles_step4")) {
    return &"CP_FINAL_SUPER_USER";
  }

  return "";
}

watch_for_player_laststand(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 waittill("last_stand");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

watch_for_player_disconnect(var_0, var_1) {
  var_0 waittill("disconnect");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

start_timing_sequence(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("death");
  level endon("game_ended");
  var_3 = 0;
  while(gettime() <= var_2 + -15536) {
    if(var_1.hidden_figures_hit >= level.chosen_number_for_morse_code_pap2) {
      foreach(var_5 in level.players) {
        var_5 playlocalsound("zmb_item_pickup");
      }

      foreach(var_8 in var_1.personalents) {
        if(isDefined(var_8.model) && var_8.model == "tag_origin_hidden_figure_final") {
          var_8 setscriptablepartstate("figure_effect", "neutral");
          scripts\engine\utility::waitframe();
          var_8 setscriptablepartstate("figure_effect", "death");
        }
      }

      break;
    }

    if(!scripts\engine\utility::istrue(var_3)) {
      if(ispointinvolume(var_1.origin, level.hidden_figures_volume)) {
        var_3 = 1;
        var_1 thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(var_1);
      }
    }

    wait(1);
  }

  var_1.triggeredtimequest = 0;
  level notify("end_timing_sequence");
}

delay_enable_linked_interaction(var_0, var_1) {
  var_1 endon("disconnect");
  level waittill("spawn_wave_done");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

timeperiodinteractionusefunc(var_0, var_1) {
  var_1 endon("disconnect");
  if(!isDefined(var_0.time_periods)) {
    var_0.time_periods = [1950, 1980, 1970, 1990];
    var_0.pointer = 0;
  }

  var_2 = var_0.time_periods[var_0.pointer];
  var_0.pointer++;
  if(var_0.pointer == var_0.time_periods.size - 1) {
    var_0.pointer = 0;
  }

  level thread changetimeperiodmodel(var_2);
  if(var_2 == 1950) {
    if(scripts\engine\utility::istrue(var_1.canattempthiddenfigureschallenge)) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
      var_1.hidden_figures_hit = 0;
      level.hidden_figures_killed = 0;
      var_1.triggeredtimequest = 1;
      var_3 = gettime();
      level thread watch_for_player_disconnect(var_1, var_0);
      level thread watch_for_player_laststand(var_1, var_0);
      level thread start_timing_sequence(var_0, var_1, var_3);
      level thread delay_enable_linked_interaction(var_0, var_1);
      level waittill("end_timing_sequence");
      return;
    }

    return;
  }

  if(var_3 == 1970) {
    level notify("70s_activated");
  }
}

changetimeperiodmodel(var_0) {
  switch (var_0) {
    case 1950:
      level.timeperiodmodel setModel("cp_final_console_standing_timeperiod_50s");
      break;

    case 1980:
      level.timeperiodmodel setModel("cp_final_console_standing_timeperiod_80s");
      break;

    case 1970:
      level.timeperiodmodel setModel("cp_final_console_standing_timeperiod_70s");
      break;

    case 1990:
      level.timeperiodmodel setModel("cp_final_console_standing_timeperiod_90s");
      break;
  }
}

timeperiodinteractionhintfunc(var_0, var_1) {
  return "";
}

morsecodeinteractionusefunc(var_0, var_1) {
  if(!scripts\engine\utility::flag("completepuzzles_step4")) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(!isDefined(level.morsecodecomponent)) {
    var_2 = spawn("script_model", (609, 4388.5, 88));
    var_2 setModel("tag_origin_morse_code");
    var_2.angles = (0, 180, 0);
    level.morsecodecomponent = var_2;
  }

  level.morsecodecomponent setscriptablepartstate("morse_code", "off");
  if(!scripts\engine\utility::istrue(level.completed_venomx_pap1_challenges)) {
    level thread keyconversiontomorse(level.chosennumtext);
    var_1 thread venomx_morse_code(level.morsecodemessagesarray, level.morsecodekeypap1, var_0);
    return;
  }

  level thread keyconversiontomorse(level.chosennumtextpap2);
  var_1 thread venomx_morse_code(level.morsecodemessagesarray, level.morsecodekeypap2, var_0);
}

morsecodeinteractionhintfunc(var_0, var_1) {
  var_1 endon("disconnect");
  return "";
}

keyinteractionusefunc(var_0, var_1) {
  var_1 endon("disconnect");
  if(!scripts\engine\utility::flag("completepuzzles_step4")) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(!isDefined(level.keycodecomponent)) {
    var_2 = spawn("script_model", (-232.5, 4294, 224));
    var_2 setModel("tag_origin_morse_code");
    var_2.angles = (0, 90, 0);
    level.keycodecomponent = var_2;
  }

  if(!scripts\engine\utility::istrue(level.completed_venomx_pap1_challenges)) {
    level thread keyconversiontomorse(level.chosennumtext);
    level convertwordintomorse(level.morsecodekeypap1, 0, level.keycodecomponent);
  } else if(!scripts\engine\utility::istrue(level.completed_venomx_pap2_challenges)) {
    level thread keyconversiontomorse(level.chosennumtextpap2);
    if(randomint(100) > 80) {
      level convertwordintomorse(scripts\engine\utility::random(level.mission_intel_array), 0, level.keycodecomponent);
    } else {
      level convertwordintomorse(level.morsecodekeypap2, 0, level.keycodecomponent);
    }
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

keyinteractionhintfunc(var_0, var_1) {
  return "";
}

dotinteractionusefunc(var_0, var_1) {
  var_1 endon("disconnect");
  if(!scripts\engine\utility::flag("completepuzzles_step4")) {
    return;
  }

  if(!isDefined(level.dotinteraction)) {
    level.dotinteraction = var_0;
  }

  scripts\cp\utility::playsoundinspace("payphone_plr_morse_dot", var_0.origin);
  if(!isDefined(level.inputkeyword)) {
    level.inputkeyword = "";
  }

  level.inputkeyword = level.inputkeyword + ".";
  if(!scripts\engine\utility::istrue(level.completedpap2morsecode)) {
    if(!scripts\engine\utility::istrue(var_0.entered_key)) {
      if(isDefined(level.convertedword)) {
        if(level.convertedword == level.inputkeyword) {
          foreach(var_3 in level.players) {
            var_3 playlocalsound("zmb_item_pickup");
            var_3 thread spawnthreadsforvenomxchallenges(var_3);
          }

          level.inputkeyword = "";
          var_0.entered_key = 1;
          level.dashinteraction.entered_key = 1;
        }
      }
    }

    level thread clearinputafterwaveend(var_0);
  }
}

clearinputafterwaveend(var_0) {
  level notify("one_thread_for_clearInput");
  level endon("one_thread_for_clearInput");
  level waittill("spawn_wave_done");
  level.inputkeyword = "";
  playsoundatpos(var_0.origin, "mpq_fail_buzzer");
}

dotinteractionhintfunc(var_0, var_1) {
  return "";
}

dashinteractionusefunc(var_0, var_1) {
  var_1 endon("disconnect");
  if(!scripts\engine\utility::flag("completepuzzles_step4")) {
    return;
  }

  if(!isDefined(level.dashinteraction)) {
    level.dashinteraction = var_0;
  }

  scripts\cp\utility::playsoundinspace("payphone_plr_morse_dash", var_0.origin);
  if(!isDefined(level.inputkeyword)) {
    level.inputkeyword = "";
  }

  level.inputkeyword = level.inputkeyword + "-";
  if(!scripts\engine\utility::istrue(level.completedpap2morsecode)) {
    if(!scripts\engine\utility::istrue(var_0.entered_key)) {
      if(isDefined(level.convertedword)) {
        if(level.convertedword == level.inputkeyword) {
          foreach(var_3 in level.players) {
            var_3 playlocalsound("zmb_item_pickup");
            var_3 thread spawnthreadsforvenomxchallenges(var_3);
          }

          level.inputkeyword = "";
          var_0.entered_key = 1;
          level.dotinteraction.entered_key = 1;
        }
      }
    }

    level thread clearinputafterwaveend(var_0);
  }
}

dashinteractionhintfunc(var_0, var_1) {
  return "";
}

backstoryinteractionusefunc(var_0, var_1) {
  var_1 endon("disconnect");
  level.backstoryinteraction = var_0;
  if(!isDefined(var_1.backstoryvoarr)) {
    var_1.backstoryvoarr = ["crew1_quest", "crew3_quest", "crew4_quest", "final_crew_shen_log_1", "final_crew_shen_log_2", "final_crew_shen_log_3", "final_crew_shen_log_4", "final_crew_adamson_log_1", "final_crew_adamson_log_2", "final_crew_adamson_log_3", "final_crew_adamson_log_4"];
  }

  var_1.chosenbackstoryvo = scripts\engine\utility::random(var_1.backstoryvoarr);
  if(scripts\engine\utility::flag("disable_evil_neil")) {
    if(var_1.backstoryvoarr.size <= 0) {
      var_1.backstoryvoarr = ["crew1_quest", "crew3_quest", "crew4_quest", "final_crew_shen_log_1", "final_crew_shen_log_2", "final_crew_shen_log_3", "final_crew_shen_log_4", "final_crew_adamson_log_1", "final_crew_adamson_log_2", "final_crew_adamson_log_3", "final_crew_adamson_log_4"];
      var_1.chosenbackstoryvo = scripts\engine\utility::random(var_1.backstoryvoarr);
    }

    var_2 = "";
    switch (var_1.chosenbackstoryvo) {
      case "final_crew_shen_log_1":
        var_2 = "final_n31l_log_shen_1";
        break;

      case "final_crew_shen_log_2":
        var_2 = "final_n31l_log_shen_2";
        break;

      case "final_crew_shen_log_3":
        var_2 = "final_n31l_log_shen_3";
        break;

      case "final_crew_shen_log_4":
        var_2 = "final_n31l_log_shen_4";
        break;

      case "final_crew_adamson_log_1":
        var_2 = "final_n31l_log_adamson_1";
        break;

      case "final_crew_adamson_log_2":
        var_2 = "final_n31l_log_adamson_2";
        break;

      case "final_crew_adamson_log_3":
        var_2 = "final_n31l_log_adamson_3";
        break;

      case "final_crew_adamson_log_4":
        var_2 = "final_n31l_log_adamson_4";
        break;
    }

    if(isDefined(var_2) && var_2 != "") {
      scripts\cp\maps\cp_final\cp_final_mpq::playneilvo(var_2);
      var_3 = scripts\cp\cp_vo::get_sound_length(var_2);
      wait(var_3);
    }

    var_1 thread scripts\cp\cp_vo::try_to_play_vo(var_1.chosenbackstoryvo, "final_backstory_vo", "highest", 999, 1, 0, 1, 100);
  }

  var_3 = scripts\cp\cp_vo::get_sound_length(var_1.chosenbackstoryvo);
  wait(var_3);
  scripts\cp\cp_vo::func_12BE3([var_1]);
}

backstoryinteractionhintfunc(var_0, var_1) {
  return "";
}

spawnthreadsforvenomxchallenges(var_0) {
  if(!scripts\engine\utility::istrue(level.completed_venomx_pap1_challenges)) {
    level.cryptidkillswithvenomx = 0;
    level thread venomx_charge_meter();
    var_0 thread runkillswatcherforcryptids();
    return;
  }

  setomnvar("zm_venomx_state", 1);
  setomnvar("zom_general_fill_percent_2", 0);
  foreach(var_2 in level.players) {
    var_2.hidden_figures_hit = 0;
    var_2 thread keyconversiontomorse(level.chosennumtextpap2);
  }

  level.hidden_figures_killed = 0;
  level.completedpap2morsecode = 1;
  var_0.canattempthiddenfigureschallenge = 1;
  level.cryptidkillswithvenomxpap2 = 0;
  var_0 thread runkillswatcherforcryptidspap2();
  level thread venomx_charge_meter();
}

runkillswatcherforcryptidspap2() {
  self endon("disconnected");
  for(;;) {
    if(level.cryptidkillswithvenomxpap2 >= level.chosen_number_for_morse_code_pap2 && isDefined(level.hidden_figures_killed) && level.hidden_figures_killed >= level.chosen_number_for_morse_code_pap2) {
      foreach(var_1 in level.players) {
        var_1 playlocalsound("part_pickup");
      }

      level.completed_venomx_pap2_challenges = 1;
      break;
    }

    wait(1);
  }
}

runkillswatcherforcryptids() {
  self endon("disconnected");
  for(;;) {
    if(level.cryptidkillswithvenomx >= level.chosen_number_for_morse_code) {
      level.completed_venomx_pap1_challenges = 1;
      level.inputkeyword = "";
      level.dashinteraction.entered_key = 0;
      level.dotinteraction.entered_key = 0;
      if(level.morsecodemessagesarray.size > 1) {
        level.morsecodemessagesarray = scripts\engine\utility::array_remove(level.morsecodemessagesarray, level.morsecodemessagesarray[0]);
      }

      foreach(var_1 in level.players) {
        var_1 thread keyconversiontomorse(level.chosennumtextpap2);
      }

      break;
    }

    wait(1);
  }
}

venomx_charge_meter() {
  level notify("only_one_thread_for_charge_meter");
  level endon("only_one_thread_for_charge_meter");
  for(;;) {
    var_0 = level scripts\engine\utility::waittill_any_return("venomx_kill", "venomx_pap1_kill");
    var_1 = 0;
    if(var_0 == "venomx_kill") {
      var_1 = level.cryptidkillswithvenomx / level.chosen_number_for_morse_code;
    } else if(var_0 == "venomx_pap1_kill") {
      if(isDefined(level.hidden_figures_killed)) {
        var_1 = level.cryptidkillswithvenomxpap2 + level.hidden_figures_killed / level.chosen_number_for_morse_code_pap2 * 2;
      } else {
        var_1 = level.cryptidkillswithvenomxpap2 / level.chosen_number_for_morse_code_pap2;
      }
    }

    if(var_1 >= 1) {
      setomnvar("zom_general_fill_percent_2", 1);
      continue;
    }

    setomnvar("zom_general_fill_percent_2", var_1);
  }
}

venomxquestregistration() {
  finalqueststepregistration("Venom Quest", 0, ::blank, ::restore_power_to_ship, ::complete_restore_power_to_ship, ::debug_restore_power_to_ship, 1, "Restore Power to the Ship");
  finalqueststepregistration("Venom Quest", 1, ::blank, ::electric_phantom, ::complete_electric_phantom, ::debug_electric_phantom, 1, "Drag a Rhino Into the Electric Trap");
  finalqueststepregistration("Venom Quest", 2, ::blank, ::disable_security_protocol, ::complete_disable_security_protocol, ::debug_disable_security_protocol, 1, "Disable Security Protocol");
  finalqueststepregistration("Venom Quest", 3, ::blank, ::interact_and_complete_puzzles, ::complete_interact_and_complete_puzzles, ::debug_interact_and_complete_puzzles, 1, "Interact and Complete All Puzzles");
}

initvenomxquestflags() {
  level.puzzles_duration = 180000;
  level.puzzles_solved = 0;
  level.electric_phantom_completed = 0;
  scripts\engine\utility::flag_init("restorepower_step1");
  scripts\engine\utility::flag_init("electricphantom_step2");
  scripts\engine\utility::flag_init("disablesecurity_step3");
  scripts\engine\utility::flag_init("completepuzzles_step4");
}

reroll_number_of_wires() {
  return randomintrange(3, 7);
}

blank() {}

restore_power_to_ship() {
  scripts\engine\utility::flag_wait("restorepower_step1");
}

complete_restore_power_to_ship() {}

debug_restore_power_to_ship() {}

electric_phantom() {
  scripts\engine\utility::flag_wait("electricphantom_step2");
}

complete_electric_phantom() {
  level thread move_fuse_box_door(1);
  triggerfx(level.wire_active_fx);
  level.electric_phantom_completed = 1;
}

debug_electric_phantom() {
  scripts\engine\utility::flag_set("electricphantom_step2");
}

disable_security_protocol() {
  scripts\engine\utility::flag_wait("disablesecurity_step3");
}

complete_disable_security_protocol() {
  move_fuse_box_door(0);
  foreach(var_1 in level.wire_models) {
    var_1.model delete();
  }

  if(isDefined(level.wire_active_fx)) {
    level.wire_active_fx delete();
  }

  level.wire_models = [];
  level notify("end_wire_threads");
}

debug_disable_security_protocol() {
  scripts\engine\utility::flag_set("disablesecurity_step3");
}

interact_and_complete_puzzles() {
  scripts\engine\utility::flag_wait("completepuzzles_step4");
}

complete_interact_and_complete_puzzles() {
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_safe_success", "zmb_comment_vo");
    var_1 thread keyconversiontomorse(level.chosennumtext);
  }

  move_venomx_locker_door(1);
  unblock_venomx_door();
  scripts\cp\utility::set_quest_icon(5);
  if(!isDefined(level.morsecodecomponent)) {
    var_3 = spawn("script_model", (609, 4388.5, 88));
    var_3 setModel("tag_origin_morse_code");
    var_3.angles = (0, 180, 0);
    level.morsecodecomponent = var_3;
    level.morsecodecomponent setscriptablepartstate("morse_code", "off");
  }

  if(!isDefined(level.keycodecomponent)) {
    var_3 = spawn("script_model", (-232.5, 4294, 224));
    var_3 setModel("tag_origin_morse_code");
    var_3.angles = (0, 90, 0);
    level.keycodecomponent = var_3;
    level.keycodecomponent setscriptablepartstate("morse_code", "off");
  }
}

debug_interact_and_complete_puzzles() {
  scripts\engine\utility::flag_set("completepuzzles_step4");
  level.puzzles_solved = 4;
}

venomx_weapon_logic_start(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_0.triggerportableradarping.basetriggercount)) {
    var_0.triggerportableradarping.basetriggercount = 0;
  }

  if(issubstr(var_0.weapon_name, "pap1")) {
    var_0.triggerportableradarping thread explode_venomx_projectile_early(var_0, 2);
    var_0.triggerportableradarping thread venomx_pap1_effects(var_0);
    return;
  }

  if(issubstr(var_0.weapon_name, "pap2")) {
    var_0.triggerportableradarping thread explode_venomx_projectile_early(var_0, 3);
    var_0.triggerportableradarping thread venomx_pap2_effects(var_0);
    return;
  }

  var_0.triggerportableradarping thread explode_venomx_projectile_early(var_0, 1);
  var_0.triggerportableradarping thread deal_venomx_projectile_damage(var_0, 1);
}

explode_venomx_projectile_early(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("one_instance_of_explode_early_" + self.name);
  self endon("one_instance_of_explode_early_" + self.name);
  var_2 = self;
  for(;;) {
    scripts\engine\utility::waittill_any_3("detonate_venomx_projectile_early", "detonate_pap1venomx_projectile_early", "detonate_pap2venomx_projectile_early");
    if(!isDefined(var_0.origin) || !isDefined(var_0.angles)) {
      return;
    }

    var_3 = var_0.origin;
    var_4 = var_0.angles;
    var_0 detonate(self);
    break;
  }

  self notify("delete_older_overlapping_threads");
  switch (var_1) {
    case 1:
      var_5 = gettime();
      var_6 = spawn("trigger_radius", var_3, 0, 400, 64);
      self.basetriggercount++;
      var_6.name = "venomx_triggered_early" + self.basetriggercount;
      var_6 thread deal_venomx_damage_to_enemies(var_2, var_5);
      var_6 thread delete_venomx_trigger_after_time(var_2, var_5);
      break;

    case 2:
      level thread slow_mo_sphere(var_2, var_3, 128, 4, 1, var_4);
      thread remove_frozen_effects_on_disconnect(1);
      var_5 = gettime();
      thread delete_venomxpap_effects_after_time(var_5, 4);
      break;

    case 3:
      level thread slow_mo_sphere(var_2, var_3, 175, 7, 2, var_4);
      thread remove_frozen_effects_on_disconnect(2);
      var_5 = gettime();
      thread delete_venomxpap_effects_after_time(var_5, 7);
      break;
  }
}

deal_venomx_projectile_damage(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  self endon("delete_older_overlapping_threads");
  var_2 = var_0.angles;
  var_3 = var_0.origin;
  var_4 = 200;
  if(var_1 == 1) {
    var_4 = 200;
  }

  var_0 scripts\engine\utility::waittill_any_3("missile_stuck", "death");
  if(!isDefined(var_0.origin)) {
    return;
  }

  var_5 = var_0.origin;
  while(isDefined(var_0.origin)) {
    var_5 = var_0.origin;
    scripts\engine\utility::waitframe();
  }

  var_6 = gettime();
  var_7 = spawn("trigger_radius", var_5, 0, var_4, 64);
  self.basetriggercount++;
  var_7.name = "venomx_triggered_afterT" + self.basetriggercount;
  var_7 thread deal_venomx_damage_to_enemies(self, var_6);
  var_7 thread delete_venomx_trigger_after_time(self, var_6);
}

deal_venomx_damage_to_enemies(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  self endon("death");
  var_0 notify("one_instance_of_deal_damage_" + self.name);
  var_0 endon("one_instance_of_deal_damage_" + self.name);
  while(gettime() <= var_1 + 5000) {
    self waittill("trigger", var_2);
    if(!isDefined(var_2)) {
      continue;
    }

    if(isplayer(var_2)) {
      continue;
    }

    if(!isDefined(var_2.agent_type)) {
      continue;
    }

    if(!var_2 scripts\cp\utility::is_zombie_agent() && var_2.agent_type != "alien_goon") {
      continue;
    }

    if(isDefined(var_0)) {
      if(var_2 scripts\cp\utility::agentisinstakillimmune()) {
        var_2.flame_damage_time = gettime() + 200;
        var_2 dodamage(10, var_2.origin, var_0, var_0, "MOD_RIFLE_BULLET", "iw7_venomx_zm");
      } else {
        var_2.flame_damage_time = gettime() + 200;
        var_2 dodamage(30, var_2.origin, var_0, var_0, "MOD_RIFLE_BULLET", "iw7_venomx_zm");
      }

      continue;
    }

    var_2.flame_damage_time = gettime() + 200;
    var_2 thread scripts\cp\utility::damage_over_time(var_2, undefined, 5000, 2500, undefined, "iw7_venomx_zm", undefined, "iw7_venomx_zm");
  }
}

delete_venomx_trigger_after_time(var_0, var_1) {
  var_0 endon("death");
  self endon("death");
  var_0 notify("delete_venomx_trigger_after_time" + self.name);
  var_0 endon("delete_venomx_trigger_after_time" + self.name);
  while(gettime() <= var_1 + 5000) {
    scripts\engine\utility::waitframe();
  }

  foreach(var_3 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    if(isalive(var_3)) {
      var_3.flame_damage_time = undefined;
    }
  }

  self delete();
}

venomx_pap1_effects(var_0) {
  self endon("delete_older_overlapping_threads");
  self endon("disconnect");
  var_1 = self;
  var_0 scripts\engine\utility::waittill_any_3("missile_stuck", "detonateExplosive");
  var_2 = var_0.origin;
  var_3 = var_0.angles;
  while(isDefined(var_0.origin)) {
    var_2 = var_0.origin;
    var_3 = var_0.angles;
    scripts\engine\utility::waitframe();
  }

  level thread slow_mo_sphere(var_1, var_2, 128, 4, 1, var_3);
  thread remove_frozen_effects_on_disconnect(1);
  var_4 = gettime();
  thread delete_venomxpap_effects_after_time(var_4, 4);
}

venomx_pap2_effects(var_0) {
  self endon("delete_older_overlapping_threads");
  self endon("disconnect");
  var_1 = self;
  var_0 scripts\engine\utility::waittill_any_3("missile_stuck", "detonateExplosive");
  var_2 = var_0.origin;
  var_3 = var_0.angles;
  while(isDefined(var_0.origin)) {
    var_2 = var_0.origin;
    var_3 = var_0.angles;
    scripts\engine\utility::waitframe();
  }

  level thread slow_mo_sphere(var_1, var_2, 175, 7, 2, var_3);
  thread remove_frozen_effects_on_disconnect(2);
  var_4 = gettime();
  thread delete_venomxpap_effects_after_time(var_4, 7);
}

remove_frozen_effects_on_disconnect(var_0) {
  self notify("one_thread_of_removal_for_" + self.name);
  self endon("one_thread_of_removal_for_" + self.name);
  scripts\engine\utility::waittill_any_3("disconnect", "death");
  if(isDefined(self.sacred_grounds)) {
    foreach(var_2 in self.sacred_grounds) {
      var_2 delete();
    }
  }

  if(var_0 == 1) {
    self.slow_mo_active = 0;
  } else {
    self.slow_mo_active_pap2 = 0;
  }

  level.frozenzombiefunc = scripts\cp\zombies\zombie_scriptable_states::freeze_zombie;
  level.thawzombiefunc = scripts\cp\zombies\zombie_scriptable_states::unfreeze_zombie;
}

delete_venomxpap_effects_after_time(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  while(gettime() <= var_0 + var_1 * 1000) {
    scripts\engine\utility::waitframe();
  }

  level.frozenzombiefunc = scripts\cp\zombies\zombie_scriptable_states::freeze_zombie;
  level.thawzombiefunc = scripts\cp\zombies\zombie_scriptable_states::unfreeze_zombie;
}

slow_mo_sphere(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("disconnect");
  if(!isDefined(self.sacred_ground)) {
    self.sacred_grounds = [];
  }

  if(var_4 == 1) {
    self.slow_mo_active = 1;
  } else {
    self.slow_mo_active_pap2 = 1;
  }

  level.frozenzombiefunc = ::custom_slow_time_func;
  level.thawzombiefunc = ::custom_unslow_func;
  var_6 = (0, 0, 180);
  var_7 = spawn("trigger_rotatable_radius", var_1, 0, var_2, 256);
  self.sacred_grounds[self.sacred_grounds.size] = var_7;
  if(var_4 == 1) {
    playFX(level._effect["pap1_slowtime"], var_1 + (0, 0, 5), anglesToForward(var_5), anglestoup(var_5 + (-90, 0, 0)));
  } else {
    playFX(level._effect["pap2_slowtime"], var_1 + (0, 0, 5), anglesToForward(var_5), anglestoup(var_5 + (-90, 0, 0)));
  }

  self.zombie_list = [];
  var_7 thread apply_slow_mo_on_trigger(var_0, var_4);
  wait(var_3);
  if(var_4 == 1) {
    self.slow_mo_active = 0;
  } else {
    self.slow_mo_active_pap2 = 0;
  }

  if(isDefined(var_7)) {
    var_7 delete();
  }

  level.frozenzombiefunc = scripts\cp\zombies\zombie_scriptable_states::freeze_zombie;
  level.thawzombiefunc = scripts\cp\zombies\zombie_scriptable_states::unfreeze_zombie;
  var_8 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_0A in var_8) {
    if(issubstr(var_0A.agent_type, "alien")) {
      var_0A.moveratescale = 0.9;
      var_0A.var_C081 = 1;
      var_0A.traverseratescale = 1;
    } else {
      var_0A scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoAttack");
    }

    var_0A.activated_venomx_sphere = 0;
    var_0A.noturnanims = 0;
    var_0A.isfrozen = undefined;
    var_0A notify("unslow_zombie");
  }
}

custom_unslow_func(var_0) {
  var_0 endon("death");
  if(!isalive(var_0)) {
    return;
  }

  var_0.precacheleaderboards = 0;
  var_0.nocorpse = undefined;
  var_0.full_gib = undefined;
  var_0.noturnanims = undefined;
}

custom_slow_time_func(var_0) {
  var_0 endon("death");
  var_0.isfrozen = 1;
  var_0.precacheleaderboards = 1;
  var_0.nocorpse = 1;
  var_0.full_gib = 1;
  var_0.noturnanims = 1;
  var_0 waittill("unslow_zombie");
  var_0.isfrozen = undefined;
}

apply_slow_mo_on_trigger(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 istouching(self)) {
        if(!scripts\engine\utility::istrue(var_3.inside_slow_sphere)) {}

        var_3.inside_slow_sphere = 1;
        continue;
      }

      if(scripts\engine\utility::istrue(var_3.inside_slow_sphere)) {}

      var_3.inside_slow_sphere = 0;
    }

    var_5 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    level.zombie_list = var_5;
    foreach(var_7 in level.zombie_list) {
      if(!isDefined(var_7)) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(var_7 scripts\cp\utility::agentisfnfimmune()) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(scripts\engine\utility::istrue(var_7.dot_triggerd)) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(var_7 istouching(self)) {
        if(!scripts\engine\utility::istrue(var_7.dot_triggered)) {
          if(isDefined(var_7)) {
            if(isDefined(var_7.agent_type) && issubstr(var_7.agent_type, "alien")) {
              if(var_7.agent_type == "alien_rhino") {
                if(var_1 == 1) {
                  var_7 thread scripts\cp\utility::damage_over_time(var_7, var_0, 7, var_7.health / 3, "MOD_EXPLOSIVE", "iw7_venomx_zm_pap1");
                } else {
                  var_7 thread scripts\cp\utility::damage_over_time(var_7, var_0, 3, var_7.health + 10000, "MOD_EXPLOSIVE", "iw7_venomx_zm_pap2");
                }
              }

              if(var_7.agent_type == "alien_phantom") {
                if(var_1 == 1) {
                  var_7 thread scripts\cp\utility::damage_over_time(var_7, var_0, 7, var_7.health / 2, "MOD_EXPLOSIVE", "iw7_venomx_zm_pap1");
                } else {
                  var_7 thread scripts\cp\utility::damage_over_time(var_7, var_0, 3, var_7.health + 10000, "MOD_EXPLOSIVE", "iw7_venomx_zm_pap2");
                }
              } else if(var_1 == 1) {
                var_7 thread scripts\cp\utility::damage_over_time(var_7, var_0, 7, var_7.health + 10000, "MOD_EXPLOSIVE", "iw7_venomx_zm_pap1");
              } else {
                var_7 thread scripts\cp\utility::damage_over_time(var_7, var_0, 3, var_7.health + 10000, "MOD_EXPLOSIVE", "iw7_venomx_zm_pap2");
              }

              var_7.moveratescale = 0.2;
              var_7.var_C081 = 0.1;
              var_7.traverseratescale = 0.1;
            } else if(var_1 == 1) {
              var_7 thread scripts\cp\utility::damage_over_time(var_7, var_0, 7, var_7.health + 10000, "MOD_EXPLOSIVE", "iw7_venomx_zm_pap1");
            } else {
              var_7 thread scripts\cp\utility::damage_over_time(var_7, var_0, 3, var_7.health + 10000, "MOD_EXPLOSIVE", "iw7_venomx_zm_pap2");
            }
          }
        }

        var_7 scripts\mp\agents\_scriptedagents::setstatelocked(1, "DoAttack");
        var_7.activated_venomx_sphere = 1;
        var_7.noturnanims = 1;
        var_7.isfrozen = 1;
        var_7.dot_triggered = 1;
        continue;
      }

      if(isDefined(var_7)) {
        if(isDefined(var_7.agent_type) && !issubstr(var_7.agent_type, "alien")) {
          var_7 scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoAttack");
          var_7.activated_venomx_sphere = 0;
          var_7.noturnanims = 0;
          var_7.isfrozen = undefined;
          var_7 notify("unslow_zombie");
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

finalqueststepregistration(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.var_13F4D[var_0])) {
    level.var_13F4D[var_0] = [];
  }

  if(!isDefined(level.var_13F4C[var_0])) {
    level.var_13F4C[var_0] = -1;
  }

  var_8 = spawnStruct();
  var_8.init_func = var_2;
  var_8.var_DB5D = var_3;
  var_8.var_446D = var_4;
  var_8.var_4EB1 = var_5;
  var_8.step_description = var_7;
  level.var_13F4D[var_0][var_1] = var_8;
}

spawn_egg_interaction_for_players(var_0) {
  level endon("delete_this_eggthread");
  var_1 = spawnStruct();
  var_1.script_noteworthy = "venomx_egg";
  var_1.origin = scripts\engine\utility::drop_to_ground(var_0 + (0, 0, 10), 0, -200);
  var_1.angles = (0, 0, 0);
  var_1.requires_power = 0;
  var_1.powered_on = 1;
  var_1.script_parameters = "default";
  var_1.name = "venomx_egg";
  var_1.spend_type = undefined;
  var_1.cost = 0;
  var_1.model = spawn("script_model", var_1.origin + (0, 0, 35));
  var_1.model setModel("weapon_zmb_venomx_egg_static");
  var_1.model.angles = (180, 0, 0);
  var_1.hint_func = ::venomx_pickup_hint_func;
  var_1.activation_func = ::venomx_add_ammo;
  var_1.enabled = 1;
  var_1.disable_guided_interactions = 1;
  level.interactions[var_1.name] = var_1;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  var_2 = gettime();
  var_1.model thread deletemodelaftertimeout(var_1, var_2);
  var_1.model thread spinegg();
}

spinegg() {
  self endon("death");
  wait(0.25);
  playFXOnTag(level._effect["vfx_eggsac_glow"], self, "tag_origin");
  for(;;) {
    self rotateyaw(36, 0.1);
    wait(0.1);
  }
}

deletemodelaftertimeout(var_0, var_1) {
  self endon("death");
  while(gettime() <= var_1 + 20000) {
    scripts\engine\utility::waitframe();
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level notify("delete_this_eggthread");
  var_0.model delete();
}

venomx_pickup_hint_func(var_0, var_1) {
  var_2 = 0;
  var_3 = var_1 getweaponslistall();
  foreach(var_5 in var_3) {
    if(issubstr(var_5, "venomx")) {
      var_2 = 1;
      break;
    }
  }

  if(scripts\engine\utility::istrue(var_2)) {
    return &"CP_FINAL_VENOMX_AMMO";
  }

  return "";
}

cangive_ammo(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0;
  var_2 = self getweaponammoclip(var_1);
  var_3 = weaponclipsize(var_1);
  var_4 = weaponmaxammo(var_1);
  var_5 = self getweaponammostock(var_1);
  if(var_5 < var_4 || var_2 < var_3) {
    return 1;
  }

  return 0;
}

give_ammo_to_player_through_egg(var_0) {
  if(!scripts\cp\utility::is_valid_player()) {
    return;
  }

  var_1 = 0;
  var_2 = undefined;
  var_3 = self getweaponslistall();
  foreach(var_5 in var_3) {
    if(issubstr(var_5, "venomx")) {
      var_1 = 1;
      var_2 = var_5;
      break;
    }
  }

  if(!var_1) {
    self playlocalsound("perk_machine_deny");
    return;
  }

  var_7 = weaponclipsize(var_2);
  adjust_clip_ammo_from_stock(self, var_2, "right", var_7, 0);
  self playlocalsound("weap_ammo_pickup");
}

adjust_clip_ammo_from_stock(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\engine\utility::istrue(var_4)) {
    var_5 = weaponmaxammo(var_1);
    var_6 = var_0 getweaponammostock(var_1);
    var_7 = var_5 - var_6;
    var_8 = scripts\engine\utility::ter_op(var_7 >= var_3, var_6 + var_3, var_5);
    var_0 setweaponammostock(var_1, var_8);
  }

  var_9 = var_0 getweaponammoclip(var_1, var_2);
  var_0A = var_3 - var_9;
  var_0B = min(var_9 + var_0A, var_3);
  var_0 setweaponammoclip(var_1, int(var_0B), var_2);
}

venomx_add_ammo(var_0, var_1) {
  var_2 = undefined;
  var_3 = var_1 getweaponslistall();
  foreach(var_5 in var_3) {
    if(issubstr(var_5, "venomx")) {
      var_2 = var_5;
      break;
    }
  }

  if(var_1 cangive_ammo(var_2)) {
    var_1 give_ammo_to_player_through_egg(var_2);
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
    scripts\engine\utility::waitframe();
    playFX(level._effect["vfx_eggsac_pup"], var_0.model.origin);
    var_0.model delete();
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    return;
  }

  var_1 scripts\cp\utility::setlowermessage("max_ammo", &"COOP_GAME_PLAY_AMMO_MAX", 3);
  var_1 playlocalsound("perk_machine_deny");
}

questdevguientries(var_0, var_1, var_2, var_3) {}

is_this_position_safe(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 < 0 || var_1 >= 6) {
    return 0;
  }

  if(var_2 < 0 || var_2 >= 6) {
    return 0;
  }

  if(scripts\engine\utility::array_contains(var_0[var_4.xcoord][var_4.ycoord].wall_directions, var_3)) {
    return 0;
  }

  return 1;
}

runmazeinstanceforpoint(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(is_this_position_safe(var_0, var_1, var_2, var_3, var_4)) {
    var_0[var_1][var_2].visited = 1;
    if(var_1 == level.maze_attributes[var_4.mod_name].endpoint_x && var_2 == level.maze_attributes[var_4.mod_name].endpoint_y) {
      var_5 thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_puzzle_success", "final_comment_vo");
      level.puzzles_solved++;
      if(var_4.newmodelsspawned == 3 && var_4.othermodel.newmodelsspawned == 1) {
        level.maze_completed[var_4.mod_name] = 1;
      } else if(var_4.newmodelsspawned == 2 && var_4.othermodel.newmodelsspawned == 2) {
        level.maze_completed[var_4.mod_name] = 1;
      } else if(var_4.newmodelsspawned == 1 && var_4.othermodel.newmodelsspawned == 3) {
        level.maze_completed[var_4.mod_name] = 1;
      }

      if(level.puzzles_solved >= 4) {
        level.maze_completed["maze1"] = 1;
        level.maze_completed["maze2"] = 1;
        level thread disable_solved_grids();
        foreach(var_8 in level.players) {
          var_8 playlocalsound("zmb_item_pickup");
        }

        scripts\engine\utility::flag_set("completepuzzles_step4");
        level thread disable_scriptables_for_mazes(var_4);
        var_4.xcoord = var_1;
        var_4.ycoord = var_2;
        var_0A = return_position_x_y(var_1, var_2, var_4);
        var_4 moveto(var_0A, 0.1);
        var_5 thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_puzzle_all_complete", "final_comment_vo");
        var_5 notify("end_thread_for_" + var_4.mod_name);
      } else if(!scripts\engine\utility::istrue(level.maze_completed[var_4.mod_name])) {
        var_4.newmodelsspawned++;
        level thread disable_scriptables_for_mazes(var_4);
        level thread start_maze_instance_on_model(var_5, var_4, var_6);
      } else {
        level thread disable_scriptables_for_mazes(var_4);
      }
    }

    var_4.xcoord = var_1;
    var_4.ycoord = var_2;
    var_0A = return_position_x_y(var_1, var_2, var_4);
    var_4 moveto(var_0A, 0.1);
    return;
  }

  var_5 thread scripts\cp\cp_vo::try_to_play_vo("quest_venx_puzzle_fail", "final_comment_vo");
  level.test_model.newmodelsspawned = 1;
  level.test_model_2.newmodelsspawned = 1;
  level.maze_completed["maze1"] = 0;
  level.maze_completed["maze2"] = 0;
  playFX(level._effect["temp_circuit_fx"], var_4.origin);
  var_5 playlocalsound("cp_final_venom_quest_fail_maze");
  var_5 playrumbleonentity("damage_light");
  level.failed_puzzle = 1;
  level.puzzles_solved = 0;
}

show_unsolved_mazes_on_crt() {
  wait(15);
  level.unsolved_crt_model = getent("unsolved_console_venomx", "script_noteworthy");
  level.unsolved_crt_model setscriptablepartstate("unsolved_grid", "neutral");
  level.unsolved_crt_model_2 = getent("unsolved_console_venomx_2", "script_noteworthy");
  level.unsolved_crt_model_2 setscriptablepartstate("unsolved_grid", "neutral");
  level thread setup_maze_models();
}

display_maze_hints_on_crt() {
  wait(10);
  foreach(var_1 in level.array_of_small_crt_script_models) {
    var_1 setscriptablepartstate("solved_grid", "neutral");
  }
}

random_maze_roll() {
  for(;;) {
    var_0 = randomintrange(0, 11);
    if(level.mazerollsarray.size >= 11) {
      level.mazerollsarray = [];
    }

    if(!scripts\engine\utility::array_contains(level.mazerollsarray, var_0)) {
      level.mazerollsarray[level.mazerollsarray.size] = var_0;
      return var_0;
    } else {
      scripts\engine\utility::waitframe();
      continue;
    }
  }
}

choose_start_end_mazepos(var_0, var_1) {
  level.maze_attributes[var_0.mod_name].endpoint_x = 0;
  level.maze_attributes[var_0.mod_name].endpoint_y = 0;
  var_0.xcoord = 0;
  var_0.ycoord = 0;
  switch (var_1) {
    case 0:
      var_0.xcoord = 4;
      var_0.ycoord = 4;
      level.maze_attributes[var_0.mod_name].endpoint_x = 2;
      level.maze_attributes[var_0.mod_name].endpoint_y = 2;
      break;

    case 1:
      var_0.xcoord = 3;
      var_0.ycoord = 2;
      level.maze_attributes[var_0.mod_name].endpoint_x = 4;
      level.maze_attributes[var_0.mod_name].endpoint_y = 1;
      break;

    case 2:
      var_0.xcoord = 3;
      var_0.ycoord = 4;
      level.maze_attributes[var_0.mod_name].endpoint_x = 2;
      level.maze_attributes[var_0.mod_name].endpoint_y = 1;
      break;

    case 3:
      var_0.xcoord = 3;
      var_0.ycoord = 1;
      level.maze_attributes[var_0.mod_name].endpoint_x = 1;
      level.maze_attributes[var_0.mod_name].endpoint_y = 2;
      break;

    case 4:
      var_0.xcoord = 3;
      var_0.ycoord = 1;
      level.maze_attributes[var_0.mod_name].endpoint_x = 0;
      level.maze_attributes[var_0.mod_name].endpoint_y = 4;
      break;

    case 5:
      var_0.xcoord = 1;
      var_0.ycoord = 1;
      level.maze_attributes[var_0.mod_name].endpoint_x = 4;
      level.maze_attributes[var_0.mod_name].endpoint_y = 3;
      break;

    case 6:
      var_0.xcoord = 4;
      var_0.ycoord = 5;
      level.maze_attributes[var_0.mod_name].endpoint_x = 3;
      level.maze_attributes[var_0.mod_name].endpoint_y = 3;
      break;

    case 7:
      var_0.xcoord = 1;
      var_0.ycoord = 4;
      level.maze_attributes[var_0.mod_name].endpoint_x = 5;
      level.maze_attributes[var_0.mod_name].endpoint_y = 0;
      break;

    case 8:
      var_0.xcoord = 2;
      var_0.ycoord = 0;
      level.maze_attributes[var_0.mod_name].endpoint_x = 2;
      level.maze_attributes[var_0.mod_name].endpoint_y = 3;
      break;

    case 9:
      var_0.xcoord = 1;
      var_0.ycoord = 2;
      level.maze_attributes[var_0.mod_name].endpoint_x = 5;
      level.maze_attributes[var_0.mod_name].endpoint_y = 3;
      break;

    case 10:
      var_0.xcoord = 1;
      var_0.ycoord = 2;
      level.maze_attributes[var_0.mod_name].endpoint_x = 4;
      level.maze_attributes[var_0.mod_name].endpoint_y = 4;
      break;

    case 11:
      var_0.xcoord = 0;
      var_0.ycoord = 1;
      level.maze_attributes[var_0.mod_name].endpoint_x = 5;
      level.maze_attributes[var_0.mod_name].endpoint_y = 3;
      break;

    case 12:
      var_0.xcoord = 0;
      var_0.ycoord = 5;
      level.maze_attributes[var_0.mod_name].endpoint_x = 3;
      level.maze_attributes[var_0.mod_name].endpoint_y = 4;
      break;

    case 13:
      var_0.xcoord = 0;
      var_0.ycoord = 4;
      level.maze_attributes[var_0.mod_name].endpoint_x = 4;
      level.maze_attributes[var_0.mod_name].endpoint_y = 2;
      break;

    case 14:
      var_0.xcoord = 0;
      var_0.ycoord = 5;
      level.maze_attributes[var_0.mod_name].endpoint_x = 4;
      level.maze_attributes[var_0.mod_name].endpoint_y = 0;
      break;

    case 15:
      var_0.xcoord = 2;
      var_0.ycoord = 0;
      level.maze_attributes[var_0.mod_name].endpoint_x = 2;
      level.maze_attributes[var_0.mod_name].endpoint_y = 3;
      break;

    default:
      break;
  }

  var_0.origin = return_position_x_y(var_0.xcoord, var_0.ycoord, var_0);
}

store_wall_directions(var_0, var_1) {
  switch (var_1) {
    case 0:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["right", "left"];
      var_0.maze[2][0].wall_directions = ["left"];
      var_0.maze[3][0].wall_directions = ["right", "left"];
      var_0.maze[4][0].wall_directions = ["left"];
      var_0.maze[5][0].wall_directions = ["down", "left"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "left", "down"];
      var_0.maze[2][1].wall_directions = ["down", "up"];
      var_0.maze[3][1].wall_directions = ["up", "left", "down"];
      var_0.maze[4][1].wall_directions = ["up"];
      var_0.maze[5][1].wall_directions = ["down"];
      var_0.maze[0][2].wall_directions = ["up", "down"];
      var_0.maze[1][2].wall_directions = ["up", "down"];
      var_0.maze[2][2].wall_directions = ["up", "down"];
      var_0.maze[3][2].wall_directions = ["up", "down"];
      var_0.maze[4][2].wall_directions = ["up", "right"];
      var_0.maze[5][2].wall_directions = ["down"];
      var_0.maze[0][3].wall_directions = ["up", "down"];
      var_0.maze[1][3].wall_directions = ["up", "down"];
      var_0.maze[2][3].wall_directions = ["up"];
      var_0.maze[3][3].wall_directions = ["right", "down"];
      var_0.maze[4][3].wall_directions = ["up", "left"];
      var_0.maze[5][3].wall_directions = ["down"];
      var_0.maze[0][4].wall_directions = ["up", "down"];
      var_0.maze[1][4].wall_directions = ["up", "down"];
      var_0.maze[2][4].wall_directions = ["down", "up", "right"];
      var_0.maze[3][4].wall_directions = ["up", "left"];
      var_0.maze[4][4].wall_directions = ["down", "right"];
      var_0.maze[5][4].wall_directions = ["down", "up"];
      var_0.maze[0][5].wall_directions = ["up", "right", "down"];
      var_0.maze[1][5].wall_directions = ["right", "up"];
      var_0.maze[2][5].wall_directions = ["right", "left"];
      var_0.maze[3][5].wall_directions = ["right", "down"];
      var_0.maze[4][5].wall_directions = ["left", "right", "up"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 1:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["right", "left"];
      var_0.maze[2][0].wall_directions = ["right", "left"];
      var_0.maze[3][0].wall_directions = ["right", "left"];
      var_0.maze[4][0].wall_directions = ["left"];
      var_0.maze[5][0].wall_directions = ["down", "left"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "left"];
      var_0.maze[2][1].wall_directions = ["down", "left"];
      var_0.maze[3][1].wall_directions = ["up", "down", "left"];
      var_0.maze[4][1].wall_directions = ["up", "down"];
      var_0.maze[5][1].wall_directions = ["up", "down"];
      var_0.maze[0][2].wall_directions = ["up", "right"];
      var_0.maze[1][2].wall_directions = ["down", "right"];
      var_0.maze[2][2].wall_directions = ["up", "down"];
      var_0.maze[3][2].wall_directions = ["up", "down"];
      var_0.maze[4][2].wall_directions = ["up", "down"];
      var_0.maze[5][2].wall_directions = ["up", "down"];
      var_0.maze[0][3].wall_directions = ["up", "right", "left"];
      var_0.maze[1][3].wall_directions = ["down", "left"];
      var_0.maze[2][3].wall_directions = ["up"];
      var_0.maze[3][3].wall_directions = ["right", "down"];
      var_0.maze[4][3].wall_directions = ["up", "down"];
      var_0.maze[5][3].wall_directions = ["down", "up"];
      var_0.maze[0][4].wall_directions = ["up", "down", "left"];
      var_0.maze[1][4].wall_directions = ["up", "right"];
      var_0.maze[2][4].wall_directions = ["down", "right"];
      var_0.maze[3][4].wall_directions = ["up", "left"];
      var_0.maze[4][4].wall_directions = ["right", "down"];
      var_0.maze[5][4].wall_directions = ["down", "up"];
      var_0.maze[0][5].wall_directions = ["up", "right"];
      var_0.maze[1][5].wall_directions = ["right", "left"];
      var_0.maze[2][5].wall_directions = ["right", "left"];
      var_0.maze[3][5].wall_directions = ["right", "down"];
      var_0.maze[4][5].wall_directions = ["up", "right", "left"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 2:
      var_0.maze[0][0].wall_directions = ["up", "left", "down"];
      var_0.maze[1][0].wall_directions = ["up", "left"];
      var_0.maze[2][0].wall_directions = ["left"];
      var_0.maze[3][0].wall_directions = ["left"];
      var_0.maze[4][0].wall_directions = ["left", "right"];
      var_0.maze[5][0].wall_directions = ["down", "left", "right"];
      var_0.maze[0][1].wall_directions = ["up"];
      var_0.maze[1][1].wall_directions = ["right"];
      var_0.maze[2][1].wall_directions = ["down"];
      var_0.maze[3][1].wall_directions = ["up", "right", "down"];
      var_0.maze[4][1].wall_directions = ["up", "left"];
      var_0.maze[5][1].wall_directions = ["down", "left"];
      var_0.maze[0][2].wall_directions = ["up", "right"];
      var_0.maze[1][2].wall_directions = ["left", "down", "right"];
      var_0.maze[2][2].wall_directions = ["up", "right"];
      var_0.maze[3][2].wall_directions = ["left", "right"];
      var_0.maze[4][2].wall_directions = ["down", "right"];
      var_0.maze[5][2].wall_directions = ["down", "up"];
      var_0.maze[0][3].wall_directions = ["up", "left"];
      var_0.maze[1][3].wall_directions = ["left", "down", "right"];
      var_0.maze[2][3].wall_directions = ["up", "left"];
      var_0.maze[3][3].wall_directions = ["right", "left"];
      var_0.maze[4][3].wall_directions = ["down", "left"];
      var_0.maze[5][3].wall_directions = ["down", "up"];
      var_0.maze[0][4].wall_directions = ["up", "down"];
      var_0.maze[1][4].wall_directions = ["up", "left", "right"];
      var_0.maze[2][4].wall_directions = ["down"];
      var_0.maze[3][4].wall_directions = ["up", "left", "down"];
      var_0.maze[4][4].wall_directions = ["down", "up"];
      var_0.maze[5][4].wall_directions = ["down", "up"];
      var_0.maze[0][5].wall_directions = ["up", "right"];
      var_0.maze[1][5].wall_directions = ["right", "left"];
      var_0.maze[2][5].wall_directions = ["right", "down"];
      var_0.maze[3][5].wall_directions = ["right", "up"];
      var_0.maze[4][5].wall_directions = ["right"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 3:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["right", "left"];
      var_0.maze[2][0].wall_directions = ["right", "left"];
      var_0.maze[3][0].wall_directions = ["down", "left", "right"];
      var_0.maze[4][0].wall_directions = ["left", "up"];
      var_0.maze[5][0].wall_directions = ["down", "left"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "left"];
      var_0.maze[2][1].wall_directions = ["down", "left"];
      var_0.maze[3][1].wall_directions = ["up", "right", "left"];
      var_0.maze[4][1].wall_directions = ["down"];
      var_0.maze[5][1].wall_directions = ["up", "down", "right"];
      var_0.maze[0][2].wall_directions = ["up", "down"];
      var_0.maze[1][2].wall_directions = ["down", "up"];
      var_0.maze[2][2].wall_directions = ["up", "right"];
      var_0.maze[3][2].wall_directions = ["left", "down"];
      var_0.maze[4][2].wall_directions = ["up", "right"];
      var_0.maze[5][2].wall_directions = ["left", "down"];
      var_0.maze[0][3].wall_directions = ["up", "down"];
      var_0.maze[1][3].wall_directions = ["down", "up"];
      var_0.maze[2][3].wall_directions = ["up", "left"];
      var_0.maze[3][3].wall_directions = ["right", "down"];
      var_0.maze[4][3].wall_directions = ["up", "left"];
      var_0.maze[5][3].wall_directions = ["down"];
      var_0.maze[0][4].wall_directions = ["up", "right"];
      var_0.maze[1][4].wall_directions = ["down", "right"];
      var_0.maze[2][4].wall_directions = ["down", "up"];
      var_0.maze[3][4].wall_directions = ["up", "left"];
      var_0.maze[4][4].wall_directions = ["right", "down"];
      var_0.maze[5][4].wall_directions = ["down", "up"];
      var_0.maze[0][5].wall_directions = ["up", "right", "left"];
      var_0.maze[1][5].wall_directions = ["right", "left"];
      var_0.maze[2][5].wall_directions = ["right"];
      var_0.maze[3][5].wall_directions = ["right", "down"];
      var_0.maze[4][5].wall_directions = ["up", "right", "left"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 4:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["right", "left"];
      var_0.maze[2][0].wall_directions = ["left", "right", "down"];
      var_0.maze[3][0].wall_directions = ["right", "left", "up"];
      var_0.maze[4][0].wall_directions = ["left", "down"];
      var_0.maze[5][0].wall_directions = ["down", "left", "up"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "left"];
      var_0.maze[2][1].wall_directions = ["left", "right"];
      var_0.maze[3][1].wall_directions = ["left", "down"];
      var_0.maze[4][1].wall_directions = ["up", "right"];
      var_0.maze[5][1].wall_directions = ["down"];
      var_0.maze[0][2].wall_directions = ["up", "down"];
      var_0.maze[1][2].wall_directions = ["up", "right"];
      var_0.maze[2][2].wall_directions = ["left", "down"];
      var_0.maze[3][2].wall_directions = ["up", "down"];
      var_0.maze[4][2].wall_directions = ["up", "left"];
      var_0.maze[5][2].wall_directions = ["down", "right"];
      var_0.maze[0][3].wall_directions = ["up", "down"];
      var_0.maze[1][3].wall_directions = ["up", "left"];
      var_0.maze[2][3].wall_directions = ["down", "right"];
      var_0.maze[3][3].wall_directions = ["right", "up"];
      var_0.maze[4][3].wall_directions = ["down", "right"];
      var_0.maze[5][3].wall_directions = ["up", "left", "down"];
      var_0.maze[0][4].wall_directions = ["up", "down"];
      var_0.maze[1][4].wall_directions = ["up", "right"];
      var_0.maze[2][4].wall_directions = ["down", "left"];
      var_0.maze[3][4].wall_directions = ["up", "left", "right"];
      var_0.maze[4][4].wall_directions = ["left"];
      var_0.maze[5][4].wall_directions = ["down"];
      var_0.maze[0][5].wall_directions = ["up", "right"];
      var_0.maze[1][5].wall_directions = ["right", "left"];
      var_0.maze[2][5].wall_directions = ["right"];
      var_0.maze[3][5].wall_directions = ["right", "left"];
      var_0.maze[4][5].wall_directions = ["down", "right"];
      var_0.maze[5][5].wall_directions = ["down", "right", "up"];
      break;

    case 5:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["right", "left"];
      var_0.maze[2][0].wall_directions = ["right", "left"];
      var_0.maze[3][0].wall_directions = ["right", "left"];
      var_0.maze[4][0].wall_directions = ["right", "left"];
      var_0.maze[5][0].wall_directions = ["down", "left"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "left"];
      var_0.maze[2][1].wall_directions = ["down", "left"];
      var_0.maze[3][1].wall_directions = ["up", "left"];
      var_0.maze[4][1].wall_directions = ["left", "down"];
      var_0.maze[5][1].wall_directions = ["up", "down", "right"];
      var_0.maze[0][2].wall_directions = ["up"];
      var_0.maze[1][2].wall_directions = ["down", "right"];
      var_0.maze[2][2].wall_directions = ["up", "right"];
      var_0.maze[3][2].wall_directions = ["right", "down"];
      var_0.maze[4][2].wall_directions = ["up", "right"];
      var_0.maze[5][2].wall_directions = ["left", "down"];
      var_0.maze[0][3].wall_directions = ["up", "down"];
      var_0.maze[1][3].wall_directions = ["down", "left", "up"];
      var_0.maze[2][3].wall_directions = ["up", "left", "right"];
      var_0.maze[3][3].wall_directions = ["right", "left"];
      var_0.maze[4][3].wall_directions = ["left", "down"];
      var_0.maze[5][3].wall_directions = ["down", "up"];
      var_0.maze[0][4].wall_directions = ["up", "down"];
      var_0.maze[1][4].wall_directions = ["up"];
      var_0.maze[2][4].wall_directions = ["left", "right"];
      var_0.maze[3][4].wall_directions = ["down", "left"];
      var_0.maze[4][4].wall_directions = ["up", "down"];
      var_0.maze[5][4].wall_directions = ["down", "up"];
      var_0.maze[0][5].wall_directions = ["up", "right"];
      var_0.maze[1][5].wall_directions = ["right", "down"];
      var_0.maze[2][5].wall_directions = ["right", "left", "up"];
      var_0.maze[3][5].wall_directions = ["right", "down"];
      var_0.maze[4][5].wall_directions = ["up", "right"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 6:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["down", "left"];
      var_0.maze[2][0].wall_directions = ["left", "up"];
      var_0.maze[3][0].wall_directions = ["right", "left"];
      var_0.maze[4][0].wall_directions = ["left", "right"];
      var_0.maze[5][0].wall_directions = ["down", "left"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "right", "down"];
      var_0.maze[2][1].wall_directions = ["up", "right", "down"];
      var_0.maze[3][1].wall_directions = ["up", "left", "down"];
      var_0.maze[4][1].wall_directions = ["up", "left"];
      var_0.maze[5][1].wall_directions = ["down", "right"];
      var_0.maze[0][2].wall_directions = ["up"];
      var_0.maze[1][2].wall_directions = ["left", "right"];
      var_0.maze[2][2].wall_directions = ["left"];
      var_0.maze[3][2].wall_directions = ["down"];
      var_0.maze[4][2].wall_directions = ["up", "down"];
      var_0.maze[5][2].wall_directions = ["down", "up", "left"];
      var_0.maze[0][3].wall_directions = ["up"];
      var_0.maze[1][3].wall_directions = ["left", "down", "right"];
      var_0.maze[2][3].wall_directions = ["up", "down"];
      var_0.maze[3][3].wall_directions = ["right", "down", "up"];
      var_0.maze[4][3].wall_directions = ["up", "down"];
      var_0.maze[5][3].wall_directions = ["down", "up"];
      var_0.maze[0][4].wall_directions = ["up", "down"];
      var_0.maze[1][4].wall_directions = ["up", "left"];
      var_0.maze[2][4].wall_directions = ["down", "right"];
      var_0.maze[3][4].wall_directions = ["up", "left"];
      var_0.maze[4][4].wall_directions = ["down", "right"];
      var_0.maze[5][4].wall_directions = ["down", "up"];
      var_0.maze[0][5].wall_directions = ["up", "right", "down"];
      var_0.maze[1][5].wall_directions = ["right", "up"];
      var_0.maze[2][5].wall_directions = ["right", "left"];
      var_0.maze[3][5].wall_directions = ["right"];
      var_0.maze[4][5].wall_directions = ["left", "right"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 7:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["down", "left"];
      var_0.maze[2][0].wall_directions = ["up", "left"];
      var_0.maze[3][0].wall_directions = ["right", "left"];
      var_0.maze[4][0].wall_directions = ["left", "right"];
      var_0.maze[5][0].wall_directions = ["down", "left"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "down"];
      var_0.maze[2][1].wall_directions = ["up", "right"];
      var_0.maze[3][1].wall_directions = ["left", "right"];
      var_0.maze[4][1].wall_directions = ["left", "down"];
      var_0.maze[5][1].wall_directions = ["up", "down"];
      var_0.maze[0][2].wall_directions = ["up", "down"];
      var_0.maze[1][2].wall_directions = ["up", "right"];
      var_0.maze[2][2].wall_directions = ["left", "right"];
      var_0.maze[3][2].wall_directions = ["left", "right"];
      var_0.maze[4][2].wall_directions = ["right", "down"];
      var_0.maze[5][2].wall_directions = ["up", "down"];
      var_0.maze[0][3].wall_directions = ["up", "down"];
      var_0.maze[1][3].wall_directions = ["up", "left"];
      var_0.maze[2][3].wall_directions = ["left", "down"];
      var_0.maze[3][3].wall_directions = ["up", "left"];
      var_0.maze[4][3].wall_directions = ["left", "down"];
      var_0.maze[5][3].wall_directions = ["down", "up"];
      var_0.maze[0][4].wall_directions = ["up", "down"];
      var_0.maze[1][4].wall_directions = ["up", "right", "down"];
      var_0.maze[2][4].wall_directions = ["down", "up"];
      var_0.maze[3][4].wall_directions = ["up", "down"];
      var_0.maze[4][4].wall_directions = ["right", "up"];
      var_0.maze[5][4].wall_directions = ["down", "right"];
      var_0.maze[0][5].wall_directions = ["up", "right"];
      var_0.maze[1][5].wall_directions = ["right", "left", "down"];
      var_0.maze[2][5].wall_directions = ["right", "up"];
      var_0.maze[3][5].wall_directions = ["right"];
      var_0.maze[4][5].wall_directions = ["right", "left"];
      var_0.maze[5][5].wall_directions = ["down", "right", "left"];
      break;

    case 8:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["right", "left"];
      var_0.maze[2][0].wall_directions = ["left"];
      var_0.maze[3][0].wall_directions = ["down", "left", "right"];
      var_0.maze[4][0].wall_directions = ["left", "up"];
      var_0.maze[5][0].wall_directions = ["down", "left"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "left", "down"];
      var_0.maze[2][1].wall_directions = ["up", "right"];
      var_0.maze[3][1].wall_directions = ["right", "left"];
      var_0.maze[4][1].wall_directions = ["right", "down"];
      var_0.maze[5][1].wall_directions = ["up", "down"];
      var_0.maze[0][2].wall_directions = ["up", "down"];
      var_0.maze[1][2].wall_directions = ["up"];
      var_0.maze[2][2].wall_directions = ["left", "right"];
      var_0.maze[3][2].wall_directions = ["left", "down"];
      var_0.maze[4][2].wall_directions = ["up", "left"];
      var_0.maze[5][2].wall_directions = ["right", "down"];
      var_0.maze[0][3].wall_directions = ["up", "down"];
      var_0.maze[1][3].wall_directions = ["down", "up"];
      var_0.maze[2][3].wall_directions = ["up", "left", "right"];
      var_0.maze[3][3].wall_directions = ["down"];
      var_0.maze[4][3].wall_directions = ["up", "down", "right"];
      var_0.maze[5][3].wall_directions = ["down", "left", "up"];
      var_0.maze[0][4].wall_directions = ["up", "down"];
      var_0.maze[1][4].wall_directions = ["up", "right"];
      var_0.maze[2][4].wall_directions = ["down", "left"];
      var_0.maze[3][4].wall_directions = ["up", "right"];
      var_0.maze[4][4].wall_directions = ["right", "left"];
      var_0.maze[5][4].wall_directions = ["down"];
      var_0.maze[0][5].wall_directions = ["up", "right"];
      var_0.maze[1][5].wall_directions = ["right", "left"];
      var_0.maze[2][5].wall_directions = ["right", "down"];
      var_0.maze[3][5].wall_directions = ["right", "up", "left"];
      var_0.maze[4][5].wall_directions = ["right", "left"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 9:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["right", "left"];
      var_0.maze[2][0].wall_directions = ["right", "left"];
      var_0.maze[3][0].wall_directions = ["right", "left"];
      var_0.maze[4][0].wall_directions = ["left", "right", "down"];
      var_0.maze[5][0].wall_directions = ["down", "left", "up"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "left"];
      var_0.maze[2][1].wall_directions = ["right", "left"];
      var_0.maze[3][1].wall_directions = ["right", "left"];
      var_0.maze[4][1].wall_directions = ["left", "down"];
      var_0.maze[5][1].wall_directions = ["up", "down"];
      var_0.maze[0][2].wall_directions = ["up"];
      var_0.maze[1][2].wall_directions = ["down", "right"];
      var_0.maze[2][2].wall_directions = ["up", "left"];
      var_0.maze[3][2].wall_directions = ["left", "down"];
      var_0.maze[4][2].wall_directions = ["up", "right"];
      var_0.maze[5][2].wall_directions = ["right", "down"];
      var_0.maze[0][3].wall_directions = ["up", "down"];
      var_0.maze[1][3].wall_directions = ["up", "left"];
      var_0.maze[2][3].wall_directions = ["right", "down"];
      var_0.maze[3][3].wall_directions = ["up", "right"];
      var_0.maze[4][3].wall_directions = ["left", "down"];
      var_0.maze[5][3].wall_directions = ["down", "up", "left"];
      var_0.maze[0][4].wall_directions = ["up", "down"];
      var_0.maze[1][4].wall_directions = ["up", "down"];
      var_0.maze[2][4].wall_directions = ["up", "left"];
      var_0.maze[3][4].wall_directions = ["right", "left", "down"];
      var_0.maze[4][4].wall_directions = ["right", "up"];
      var_0.maze[5][4].wall_directions = ["down"];
      var_0.maze[0][5].wall_directions = ["up", "right"];
      var_0.maze[1][5].wall_directions = ["right", "down"];
      var_0.maze[2][5].wall_directions = ["right", "up"];
      var_0.maze[3][5].wall_directions = ["right", "left"];
      var_0.maze[4][5].wall_directions = ["right", "left"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 10:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["down", "left"];
      var_0.maze[2][0].wall_directions = ["left", "up", "right"];
      var_0.maze[3][0].wall_directions = ["left"];
      var_0.maze[4][0].wall_directions = ["left"];
      var_0.maze[5][0].wall_directions = ["down", "left", "right"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "right"];
      var_0.maze[2][1].wall_directions = ["down", "left"];
      var_0.maze[3][1].wall_directions = ["up", "right", "down"];
      var_0.maze[4][1].wall_directions = ["up", "right"];
      var_0.maze[5][1].wall_directions = ["down", "left"];
      var_0.maze[0][2].wall_directions = ["up", "right"];
      var_0.maze[1][2].wall_directions = ["left", "down"];
      var_0.maze[2][2].wall_directions = ["up", "right"];
      var_0.maze[3][2].wall_directions = ["left", "right"];
      var_0.maze[4][2].wall_directions = ["left", "down"];
      var_0.maze[5][2].wall_directions = ["down", "up"];
      var_0.maze[0][3].wall_directions = ["up", "left"];
      var_0.maze[1][3].wall_directions = ["right", "down"];
      var_0.maze[2][3].wall_directions = ["up", "left"];
      var_0.maze[3][3].wall_directions = ["right", "down", "left"];
      var_0.maze[4][3].wall_directions = ["up", "right"];
      var_0.maze[5][3].wall_directions = ["down"];
      var_0.maze[0][4].wall_directions = ["up", "down"];
      var_0.maze[1][4].wall_directions = ["up", "left"];
      var_0.maze[2][4].wall_directions = ["right"];
      var_0.maze[3][4].wall_directions = ["right", "left"];
      var_0.maze[4][4].wall_directions = ["down", "left"];
      var_0.maze[5][4].wall_directions = ["down", "up"];
      var_0.maze[0][5].wall_directions = ["up", "right", "down"];
      var_0.maze[1][5].wall_directions = ["right", "up"];
      var_0.maze[2][5].wall_directions = ["right", "left"];
      var_0.maze[3][5].wall_directions = ["right", "down", "left"];
      var_0.maze[4][5].wall_directions = ["right", "up"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 11:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["down", "left"];
      var_0.maze[2][0].wall_directions = ["right", "left", "up"];
      var_0.maze[3][0].wall_directions = ["right", "left"];
      var_0.maze[4][0].wall_directions = ["left"];
      var_0.maze[5][0].wall_directions = ["down", "left", "right"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "right"];
      var_0.maze[2][1].wall_directions = ["right", "left"];
      var_0.maze[3][1].wall_directions = ["down", "left"];
      var_0.maze[4][1].wall_directions = ["up"];
      var_0.maze[5][1].wall_directions = ["left", "down"];
      var_0.maze[0][2].wall_directions = ["up", "right"];
      var_0.maze[1][2].wall_directions = ["down", "right", "left"];
      var_0.maze[2][2].wall_directions = ["up", "left"];
      var_0.maze[3][2].wall_directions = ["right", "down"];
      var_0.maze[4][2].wall_directions = ["up", "down", "right"];
      var_0.maze[5][2].wall_directions = ["up", "down"];
      var_0.maze[0][3].wall_directions = ["up", "left"];
      var_0.maze[1][3].wall_directions = ["down", "left", "right"];
      var_0.maze[2][3].wall_directions = ["up", "right"];
      var_0.maze[3][3].wall_directions = ["right", "left"];
      var_0.maze[4][3].wall_directions = ["right", "left"];
      var_0.maze[5][3].wall_directions = ["down"];
      var_0.maze[0][4].wall_directions = ["up", "down"];
      var_0.maze[1][4].wall_directions = ["up", "left"];
      var_0.maze[2][4].wall_directions = ["down", "left"];
      var_0.maze[3][4].wall_directions = ["up", "left"];
      var_0.maze[4][4].wall_directions = ["left"];
      var_0.maze[5][4].wall_directions = ["down"];
      var_0.maze[0][5].wall_directions = ["up", "right"];
      var_0.maze[1][5].wall_directions = ["right", "down"];
      var_0.maze[2][5].wall_directions = ["right", "up"];
      var_0.maze[3][5].wall_directions = ["right"];
      var_0.maze[4][5].wall_directions = ["right"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 12:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["right", "left"];
      var_0.maze[2][0].wall_directions = ["right", "left"];
      var_0.maze[3][0].wall_directions = ["right", "left"];
      var_0.maze[4][0].wall_directions = ["right", "left"];
      var_0.maze[5][0].wall_directions = ["down", "left", "right"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "left"];
      var_0.maze[2][1].wall_directions = ["left", "right"];
      var_0.maze[3][1].wall_directions = ["left", "down"];
      var_0.maze[4][1].wall_directions = ["up", "left"];
      var_0.maze[5][1].wall_directions = ["down", "left"];
      var_0.maze[0][2].wall_directions = ["up", "right"];
      var_0.maze[1][2].wall_directions = ["right", "down"];
      var_0.maze[2][2].wall_directions = ["up", "left"];
      var_0.maze[3][2].wall_directions = ["right", "down"];
      var_0.maze[4][2].wall_directions = ["up", "down"];
      var_0.maze[5][2].wall_directions = ["down", "up"];
      var_0.maze[0][3].wall_directions = ["up", "left"];
      var_0.maze[1][3].wall_directions = ["left", "right"];
      var_0.maze[2][3].wall_directions = ["down"];
      var_0.maze[3][3].wall_directions = ["left", "up"];
      var_0.maze[4][3].wall_directions = ["down", "right"];
      var_0.maze[5][3].wall_directions = ["down", "up"];
      var_0.maze[0][4].wall_directions = ["up"];
      var_0.maze[1][4].wall_directions = ["left", "down"];
      var_0.maze[2][4].wall_directions = ["down", "up", "right"];
      var_0.maze[3][4].wall_directions = ["down", "up", "right"];
      var_0.maze[4][4].wall_directions = ["down", "up", "left"];
      var_0.maze[5][4].wall_directions = ["down", "up"];
      var_0.maze[0][5].wall_directions = ["up", "right", "down"];
      var_0.maze[1][5].wall_directions = ["right", "up"];
      var_0.maze[2][5].wall_directions = ["right", "left"];
      var_0.maze[3][5].wall_directions = ["right", "left"];
      var_0.maze[4][5].wall_directions = ["right"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 13:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["right", "left"];
      var_0.maze[2][0].wall_directions = ["right", "left"];
      var_0.maze[3][0].wall_directions = ["right", "left"];
      var_0.maze[4][0].wall_directions = ["right", "left"];
      var_0.maze[5][0].wall_directions = ["down", "left"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "left"];
      var_0.maze[2][1].wall_directions = ["down", "left"];
      var_0.maze[3][1].wall_directions = ["up", "right", "left"];
      var_0.maze[4][1].wall_directions = ["left", "down"];
      var_0.maze[5][1].wall_directions = ["up", "down"];
      var_0.maze[0][2].wall_directions = ["up"];
      var_0.maze[1][2].wall_directions = ["down", "right"];
      var_0.maze[2][2].wall_directions = ["up", "right"];
      var_0.maze[3][2].wall_directions = ["left", "down"];
      var_0.maze[4][2].wall_directions = ["up", "right"];
      var_0.maze[5][2].wall_directions = ["right", "down"];
      var_0.maze[0][3].wall_directions = ["up", "right"];
      var_0.maze[1][3].wall_directions = ["down", "left"];
      var_0.maze[2][3].wall_directions = ["up", "left"];
      var_0.maze[3][3].wall_directions = ["down"];
      var_0.maze[4][3].wall_directions = ["up", "left"];
      var_0.maze[5][3].wall_directions = ["down", "left"];
      var_0.maze[0][4].wall_directions = ["up", "down", "left"];
      var_0.maze[1][4].wall_directions = ["up", "down"];
      var_0.maze[2][4].wall_directions = ["down", "up"];
      var_0.maze[3][4].wall_directions = ["up", "right", "down"];
      var_0.maze[4][4].wall_directions = ["up", "right", "down"];
      var_0.maze[5][4].wall_directions = ["down", "up"];
      var_0.maze[0][5].wall_directions = ["up", "right"];
      var_0.maze[1][5].wall_directions = ["right", "down"];
      var_0.maze[2][5].wall_directions = ["right", "up"];
      var_0.maze[3][5].wall_directions = ["right", "left"];
      var_0.maze[4][5].wall_directions = ["right", "left"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    case 14:
      var_0.maze[0][0].wall_directions = ["up", "left", "right"];
      var_0.maze[1][0].wall_directions = ["right", "left"];
      var_0.maze[2][0].wall_directions = ["right", "left"];
      var_0.maze[3][0].wall_directions = ["left"];
      var_0.maze[4][0].wall_directions = ["left"];
      var_0.maze[5][0].wall_directions = ["down", "left"];
      var_0.maze[0][1].wall_directions = ["up", "left"];
      var_0.maze[1][1].wall_directions = ["right", "left"];
      var_0.maze[2][1].wall_directions = ["down", "left"];
      var_0.maze[3][1].wall_directions = ["up", "down"];
      var_0.maze[4][1].wall_directions = ["up", "down"];
      var_0.maze[5][1].wall_directions = ["up", "down"];
      var_0.maze[0][2].wall_directions = ["up"];
      var_0.maze[1][2].wall_directions = ["left", "down"];
      var_0.maze[2][2].wall_directions = ["up", "down"];
      var_0.maze[3][2].wall_directions = ["up", "down", "right"];
      var_0.maze[4][2].wall_directions = ["up", "down"];
      var_0.maze[5][2].wall_directions = ["up", "down"];
      var_0.maze[0][3].wall_directions = ["up", "down", "right"];
      var_0.maze[1][3].wall_directions = ["up", "down"];
      var_0.maze[2][3].wall_directions = ["up", "right"];
      var_0.maze[3][3].wall_directions = ["right", "left"];
      var_0.maze[4][3].wall_directions = ["right", "down"];
      var_0.maze[5][3].wall_directions = ["up", "down"];
      var_0.maze[0][4].wall_directions = ["up", "left"];
      var_0.maze[1][4].wall_directions = ["right", "down"];
      var_0.maze[2][4].wall_directions = ["up", "left"];
      var_0.maze[3][4].wall_directions = ["down", "left", "right"];
      var_0.maze[4][4].wall_directions = ["up", "left"];
      var_0.maze[5][4].wall_directions = ["down", "right"];
      var_0.maze[0][5].wall_directions = ["up", "right"];
      var_0.maze[1][5].wall_directions = ["right", "left"];
      var_0.maze[2][5].wall_directions = ["right", "down"];
      var_0.maze[3][5].wall_directions = ["right", "up", "left"];
      var_0.maze[4][5].wall_directions = ["right"];
      var_0.maze[5][5].wall_directions = ["down", "right", "left"];
      break;

    case 15:
      var_0.maze[0][0].wall_directions = ["up", "left"];
      var_0.maze[1][0].wall_directions = ["right", "left"];
      var_0.maze[2][0].wall_directions = ["left"];
      var_0.maze[3][0].wall_directions = ["down", "left", "right"];
      var_0.maze[4][0].wall_directions = ["left", "up"];
      var_0.maze[5][0].wall_directions = ["down", "left"];
      var_0.maze[0][1].wall_directions = ["up", "down"];
      var_0.maze[1][1].wall_directions = ["up", "left", "down"];
      var_0.maze[2][1].wall_directions = ["up", "right"];
      var_0.maze[3][1].wall_directions = ["right", "left"];
      var_0.maze[4][1].wall_directions = ["right", "down"];
      var_0.maze[5][1].wall_directions = ["up", "down"];
      var_0.maze[0][2].wall_directions = ["up", "down"];
      var_0.maze[1][2].wall_directions = ["up"];
      var_0.maze[2][2].wall_directions = ["left", "right"];
      var_0.maze[3][2].wall_directions = ["left", "down"];
      var_0.maze[4][2].wall_directions = ["up", "left"];
      var_0.maze[5][2].wall_directions = ["right", "down"];
      var_0.maze[0][3].wall_directions = ["up", "down"];
      var_0.maze[1][3].wall_directions = ["down", "up"];
      var_0.maze[2][3].wall_directions = ["up", "left", "right"];
      var_0.maze[3][3].wall_directions = ["down"];
      var_0.maze[4][3].wall_directions = ["up", "down", "right"];
      var_0.maze[5][3].wall_directions = ["down", "left", "up"];
      var_0.maze[0][4].wall_directions = ["up", "down"];
      var_0.maze[1][4].wall_directions = ["up", "right"];
      var_0.maze[2][4].wall_directions = ["down", "left"];
      var_0.maze[3][4].wall_directions = ["up", "right"];
      var_0.maze[4][4].wall_directions = ["right", "left"];
      var_0.maze[5][4].wall_directions = ["down"];
      var_0.maze[0][5].wall_directions = ["up", "right"];
      var_0.maze[1][5].wall_directions = ["right", "left"];
      var_0.maze[2][5].wall_directions = ["right", "down"];
      var_0.maze[3][5].wall_directions = ["right", "up", "left"];
      var_0.maze[4][5].wall_directions = ["right", "left"];
      var_0.maze[5][5].wall_directions = ["down", "right"];
      break;

    default:
      break;
  }
}

createmaze(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    var_4 thread control_puzzle_cursor(var_0);
    var_4 thread control_puzzle_cursor(var_1);
  }

  level.maze_attributes = [];
  level.random_maze_roll = [];
  level.maze_attributes[var_0.mod_name] = spawnStruct();
  level.maze_attributes[var_0.mod_name].maze = [];
  level.maze_attributes[var_1.mod_name] = spawnStruct();
  level.maze_attributes[var_1.mod_name].maze = [];
  for(var_6 = 0; var_6 < 6; var_6++) {
    for(var_7 = 0; var_7 < 6; var_7++) {
      foreach(var_9 in level.maze_attributes) {
        var_9.maze[var_6][var_7] = spawnStruct();
        var_9.maze[var_6][var_7].wall_directions = [];
        var_9.maze[var_6][var_7].visited = 0;
      }
    }
  }

  var_0 setscriptablepartstate("maze_puzzle", "cursor");
  var_1 setscriptablepartstate("maze_puzzle", "cursor");
  foreach(var_0E, var_0C in level.array_of_small_crt_script_models) {
    var_0D = var_0E;
    if(var_0D > 10) {
      var_0D = randomintrange(0, 11);
    }

    var_0C setscriptablepartstate("solved_grid", "solved_puzzle_" + var_0D);
  }

  if(!isDefined(level.mazerollsarray)) {
    level.mazerollsarray = [];
  }

  foreach(var_0E, var_10 in level.maze_attributes) {
    level.random_maze_roll[var_0E] = random_maze_roll();
    level thread store_wall_directions(var_10, level.random_maze_roll[var_0E]);
  }

  level thread choose_start_end_mazepos(var_0, level.random_maze_roll["maze1"]);
  level.unsolved_crt_model setscriptablepartstate("unsolved_grid", "unsolved_maze_" + level.random_maze_roll["maze1"]);
  level thread choose_start_end_mazepos(var_1, level.random_maze_roll["maze2"]);
  level.unsolved_crt_model_2 setscriptablepartstate("unsolved_grid", "unsolved_maze_" + level.random_maze_roll["maze2"]);
}

player_disconnect_during_maze(var_0) {
  var_0 notify("end_disconnect_thread" + var_0.name);
  var_0 endon("end_disconnect_thread" + var_0.name);
  level endon("end_locking_threads_on_the_player_for_venomx_cursor");
  var_0 waittill("disconnect");
  level.test_model.newmodelsspawned = 1;
  level.test_model_2.newmodelsspawned = 1;
  level.maze_completed["maze1"] = 0;
  level.maze_completed["maze2"] = 0;
  level.failed_puzzle = 1;
  level.puzzles_solved = 0;
}

control_puzzle_cursor(var_0) {
  level thread player_disconnect_during_maze(self);
  if(var_0.mod_name == "maze2") {
    thread input_cursor_maze2(var_0, level.unsolved_crt_model_2);
    return;
  }

  thread input_cursor(var_0, level.unsolved_crt_model);
}

get_chars_of_word_as_array(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_2] = var_0[var_2];
  }

  return var_1;
}

solvecipher(var_0, var_1, var_2) {
  level.ciphered_word = cipher(level.morse_phrase, var_0, 1);
  level.decipheredword = cipher(level.ciphered_word, var_0, 0);
  level.ciphered_word = changearraytoword(level.ciphered_word);
  level.decipheredword = changearraytoword(level.decipheredword);
  level convertwordintomorse(level.ciphered_word, 0, level.morsecodecomponent);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
}

convertwordintomorse(var_0, var_1, var_2) {
  if(var_1) {
    level.convertedword = "";
  }

  var_3 = get_chars_of_word_as_array(var_0);
  var_4 = undefined;
  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    if(var_5 + 1 == var_3.size) {
      var_4 = getsubstr(var_0, var_5);
    } else {
      var_4 = getsubstr(var_0, var_5, var_5 + 1);
    }

    switch (var_4) {
      case "0":
        for(var_6 = 0; var_6 < 5; var_6++) {
          play_morse_dash(var_1, var_2);
        }
        break;

      case "1":
        play_morse_dot(var_1, var_2);
        for(var_6 = 0; var_6 < 4; var_6++) {
          play_morse_dash(var_1, var_2);
        }
        break;

      case "2":
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dot(var_1, var_2);
        }

        for(var_6 = 0; var_6 < 3; var_6++) {
          play_morse_dash(var_1, var_2);
        }
        break;

      case "3":
        for(var_6 = 0; var_6 < 3; var_6++) {
          play_morse_dot(var_1, var_2);
        }

        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dash(var_1, var_2);
        }
        break;

      case "4":
        for(var_6 = 0; var_6 < 4; var_6++) {
          play_morse_dot(var_1, var_2);
        }

        play_morse_dash(var_1, var_2);
        break;

      case "5":
        for(var_6 = 0; var_6 < 5; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case "6":
        play_morse_dash(var_1, var_2);
        for(var_6 = 0; var_6 < 4; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case "7":
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dash(var_1, var_2);
        }

        for(var_6 = 0; var_6 < 3; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case "8":
        for(var_6 = 0; var_6 < 3; var_6++) {
          play_morse_dash(var_1, var_2);
        }

        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case "9":
        for(var_6 = 0; var_6 < 4; var_6++) {
          play_morse_dash(var_1, var_2);
        }

        play_morse_dot(var_1, var_2);
        break;

      case "A":
      case "a":
        play_morse_dot(var_1, var_2);
        for(var_6 = 0; var_6 < 1; var_6++) {
          play_morse_dash(var_1, var_2);
        }
        break;

      case "B":
      case "b":
        play_morse_dash(var_1, var_2);
        for(var_6 = 0; var_6 < 3; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case "C":
      case "c":
        play_morse_dash(var_1, var_2);
        for(var_6 = 0; var_6 < 1; var_6++) {
          play_morse_dot(var_1, var_2);
        }

        for(var_6 = 0; var_6 < 1; var_6++) {
          play_morse_dash(var_1, var_2);
        }

        for(var_6 = 0; var_6 < 1; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case "D":
      case "d":
        play_morse_dash(var_1, var_2);
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case "E":
      case "e":
        play_morse_dot(var_1, var_2);
        break;

      case "F":
      case "f":
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dot(var_1, var_2);
        }

        play_morse_dash(var_1, var_2);
        play_morse_dot(var_1, var_2);
        break;

      case "G":
      case "g":
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dash(var_1, var_2);
        }

        play_morse_dot(var_1, var_2);
        break;

      case "H":
      case "h":
        for(var_6 = 0; var_6 < 4; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case "I":
      case "i":
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case "J":
      case "j":
        play_morse_dot(var_1, var_2);
        for(var_6 = 0; var_6 < 3; var_6++) {
          play_morse_dash(var_1, var_2);
        }
        break;

      case "K":
      case "k":
        play_morse_dash(var_1, var_2);
        play_morse_dot(var_1, var_2);
        play_morse_dash(var_1, var_2);
        break;

      case "L":
      case "l":
        play_morse_dot(var_1, var_2);
        play_morse_dash(var_1, var_2);
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case "M":
      case "m":
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dash(var_1, var_2);
        }
        break;

      case "N":
      case "n":
        play_morse_dash(var_1, var_2);
        play_morse_dot(var_1, var_2);
        break;

      case "O":
      case "o":
        for(var_6 = 0; var_6 < 3; var_6++) {
          play_morse_dash(var_1, var_2);
        }
        break;

      case "P":
      case "p":
        play_morse_dot(var_1, var_2);
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dash(var_1, var_2);
        }

        play_morse_dot(var_1, var_2);
        break;

      case "Q":
      case "q":
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dash(var_1, var_2);
        }

        play_morse_dot(var_1, var_2);
        play_morse_dash(var_1, var_2);
        break;

      case "R":
      case "r":
        play_morse_dot(var_1, var_2);
        play_morse_dash(var_1, var_2);
        play_morse_dot(var_1, var_2);
        break;

      case "S":
      case "s":
        for(var_6 = 0; var_6 < 3; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case "T":
      case "t":
        play_morse_dash(var_1, var_2);
        break;

      case "U":
      case "u":
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dot(var_1, var_2);
        }

        play_morse_dash(var_1, var_2);
        break;

      case "V":
      case "v":
        for(var_6 = 0; var_6 < 3; var_6++) {
          play_morse_dot(var_1, var_2);
        }

        play_morse_dash(var_1, var_2);
        break;

      case "W":
      case "w":
        play_morse_dot(var_1, var_2);
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dash(var_1, var_2);
        }
        break;

      case "X":
      case "x":
        play_morse_dash(var_1, var_2);
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dot(var_1, var_2);
        }

        play_morse_dash(var_1, var_2);
        break;

      case "Y":
      case "y":
        play_morse_dash(var_1, var_2);
        play_morse_dot(var_1, var_2);
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dash(var_1, var_2);
        }
        break;

      case "Z":
      case "z":
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dash(var_1, var_2);
        }

        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case ".":
        wait(1.5);
        break;

      case ",":
        wait(1);
        break;

      case "?":
        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dot(var_1, var_2);
        }

        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dash(var_1, var_2);
        }

        for(var_6 = 0; var_6 < 2; var_6++) {
          play_morse_dot(var_1, var_2);
        }
        break;

      case " ":
        wait(1);
        break;

      default:
        break;
    }
  }

  if(!var_1) {
    var_2 setscriptablepartstate("morse_code", "off");
  }
}

venomx_morse_code(var_0, var_1, var_2) {
  var_0 = scripts\engine\utility::array_randomize(var_0);
  level.morse_phrase = var_0[0];
  level thread solvecipher(var_1, self, var_2);
}

turn_model_on_off(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1)) {
    var_0 setscriptablepartstate("morse_code", "off");
    wait(0.3);
    var_0 setscriptablepartstate("morse_code", "off");
    return;
  }

  var_0 setscriptablepartstate("morse_code", "off");
  wait(0.5);
  var_0 setscriptablepartstate("morse_code", "off");
}

play_morse_dot(var_0, var_1) {
  if(!var_0) {
    level thread turn_model_on_off(var_1, 1);
    scripts\cp\utility::playsoundinspace("payphone_plr_morse_dot", var_1.origin);
    wait(0.3);
    var_1 setscriptablepartstate("morse_code", "off");
    return;
  }

  level.convertedword = level.convertedword + ".";
}

play_morse_dash(var_0, var_1) {
  if(!var_0) {
    level thread turn_model_on_off(var_1, 0);
    scripts\cp\utility::playsoundinspace("payphone_plr_morse_dash", var_1.origin);
    wait(0.5);
    var_1 setscriptablepartstate("morse_code", "off");
    return;
  }

  level.convertedword = level.convertedword + "-";
}

unblock_venomx_door() {
  var_0 = getent("venomx_door_blocker", "script_noteworthy");
  var_0 notsolid();
  var_0 connectpaths();
}

choose_number_of_goons() {
  var_0 = 1;
  if(isDefined(level.players.size) && level.players.size > 0) {
    switch (level.players.size) {
      case 1:
        var_0 = 1;
        break;

      case 2:
        var_0 = 1;
        break;

      case 3:
        var_0 = 2;
        break;

      case 4:
        var_0 = 2;
        break;

      default:
        var_0 = 1;
        break;
    }

    return var_0;
  }
}

start_fake_spawn_sequence(var_0, var_1) {
  level endon("game_ended");
  var_2 = choose_number_of_goons();
  var_3 = var_2;
  level.goons_alive = var_3;
  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_0 thread watch_for_disconnected_player_during_spawn();
  var_9 = getrandomnavpoints(var_1, 128, var_3);
  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(var_3);
  wait(2);
  var_0A = skeleton_spawner(var_9, var_0);
  while(level.goons_alive > 0) {
    wait(0.1);
  }

  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(var_3);
  return 1;
}

watch_for_disconnected_player_during_spawn() {
  self waittill("disconnect");
  level.goons_alive = 0;
}

get_rand_point(var_0, var_1) {
  var_1 endon("disconnect");
  while(![[level.active_volume_check]](var_0)) {
    var_0 = getrandomnavpoint(var_0, 128);
    scripts\engine\utility::waitframe();
  }

  return var_0;
}

skeleton_spawner(var_0, var_1) {
  var_1 endon("disconnect");
  var_2 = [];
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3] = get_rand_point(var_0[var_3], var_1);
    var_4 = spawn_skeleton_solo(var_0[var_3], var_1);
    if(isDefined(var_4)) {
      var_4 thread skeleton_death_watcher();
      var_2[var_2.size] = var_4;
      var_4 thread set_skeleton_attributes();
      wait(1);
      continue;
    }

    level.goons_alive--;
  }

  return var_2;
}

skeleton_death_watcher() {
  level endon("game_ended");
  self waittill("death");
  level.goons_alive--;
}

spawn_skeleton_solo(var_0, var_1) {
  var_1 endon("disconnect");
  var_0 = scripts\engine\utility::drop_to_ground(var_0, 30, -100);
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.script_parameters = "ground_spawn_no_boards";
  var_2.script_animation = "spawn_ground";
  var_3 = 4;
  var_4 = 2.7;
  for(var_5 = 0; var_5 < var_3; var_5++) {
    thread scripts\cp\utility::playsoundinspace("zombie_spawn_lightning", var_0);
    var_6 = level._effect["goon_spawn_bolt"];
    playFX(var_6, var_0);
    playFX(level._effect["drone_ground_spawn"], var_0, (0, 0, 1));
    playrumbleonposition("grenade_rumble", var_0);
    earthquake(0.3, 0.2, var_0, 500);
    var_7 = var_2 scripts\cp\zombies\cp_final_spawning::spawn_brute_wave_enemy("alien_phantom");
    if(isDefined(var_7)) {
      return var_7;
    }

    wait(var_4);
  }

  return undefined;
}

set_skeleton_attributes() {
  level endon("game_ended");
  self endon("death");
  self.dont_cleanup = 1;
  self.synctransients = "sprint";
  if(!scripts\engine\utility::istrue(self.aj_goon)) {
    self.aj_goon = 1;
  }

  self.health = scripts\cp\zombies\cp_final_spawning::calculatezombiehealth("alien_phantom");
  self.maxhealth = scripts\cp\zombies\cp_final_spawning::calculatezombiehealth("alien_phantom");
}

init_fig1() {
  level.special_mode_activation_funcs["fig_1"] = ::showhiddenfigurestoplayer;
  level.normal_mode_activation_funcs["fig_1"] = ::showhiddenfigurestoplayer;
  var_0 = scripts\engine\utility::getstructarray("fig_1", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_hidden_figure_models(var_2, "fig_1");
  }
}

init_fig2() {
  level.special_mode_activation_funcs["fig_2"] = ::showhiddenfigurestoplayer;
  level.normal_mode_activation_funcs["fig_2"] = ::showhiddenfigurestoplayer;
  var_0 = scripts\engine\utility::getstructarray("fig_2", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_hidden_figure_models(var_2, "fig_2");
  }
}

init_fig3() {
  level.special_mode_activation_funcs["fig_3"] = ::showhiddenfigurestoplayer;
  level.normal_mode_activation_funcs["fig_3"] = ::showhiddenfigurestoplayer;
  var_0 = scripts\engine\utility::getstructarray("fig_3", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_hidden_figure_models(var_2, "fig_3");
  }
}

init_fig4() {
  level.special_mode_activation_funcs["fig_4"] = ::showhiddenfigurestoplayer;
  level.normal_mode_activation_funcs["fig_4"] = ::showhiddenfigurestoplayer;
  var_0 = scripts\engine\utility::getstructarray("fig_4", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_hidden_figure_models(var_2, "fig_4");
  }
}

fig_hint(var_0, var_1) {
  return "";
}

fig_func(var_0, var_1) {}

activatefiguredamage(var_0, var_1, var_2) {
  level notify(var_0.script_noteworthy + "_" + var_1.name);
  level endon(var_0.script_noteworthy + "_" + var_1.name);
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  level endon("end_hidden_figures_sequence_for_" + var_1.name);
  var_2 endon("p_ent_reset");
  if(!isDefined(var_2)) {
    return;
  }

  var_2.health = 99999999;
  var_2.maxhealth = 99999999;
  var_2 setCanDamage(1);
  var_2 endon("end_thread_for_" + var_2.model);
  for(;;) {
    var_2 waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C);
    if(!isplayer(var_4)) {
      continue;
    }

    if(var_4 != var_1) {
      continue;
    }

    if(!var_4 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.got_hit_by_player)) {
      var_2 setscriptablepartstate("figure_effect", "death");
      var_4 thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(var_4);
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!ispointinvolume(var_4.origin, level.hidden_figures_volume)) {
      var_4 playlocalsound("perk_machine_deny");
      continue;
    }

    var_2 setscriptablepartstate("figure_effect", "death");
    var_2.health = 9999999;
    var_2.maxhealth = 9999999;
    playsoundatpos(var_2.origin, "town_kill_black_ghost_success");
    var_2.got_hit_by_player = 1;
    if(isDefined(var_4.hidden_figures_hit)) {
      var_4.hidden_figures_hit++;
      if(var_4.hidden_figures_hit >= 4) {
        var_4 thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(var_4);
      }
    }

    if(isDefined(level.hidden_figures_killed)) {
      if(level.hidden_figures_killed >= level.chosen_number_for_morse_code_pap2) {
        level.hidden_figures_killed = level.chosen_number_for_morse_code_pap2;
      } else {
        level thread scripts\cp\utility::add_to_notify_queue("venomx_pap1_kill", var_2, var_2.origin, var_0C);
        level.hidden_figures_killed++;
      }
    }

    var_2 notify("end_thread_for_" + var_2.model);
    scripts\engine\utility::waitframe();
  }
}

showhiddenfigurestoplayer(var_0, var_1, var_2, var_3) {
  var_3 notify("one_instance_of_" + var_1.script_noteworthy + "_for_" + var_3.name);
  var_3 endon("one_instance_of_" + var_1.script_noteworthy + "_for_" + var_3.name);
  var_3 endon("death");
  var_3 endon("disconnect");
  level endon("game_ended");
  level endon("end_hidden_figures_sequence_for_" + var_3.name);
  if(!isDefined(var_3.vo_prefix)) {
    return;
  }

  if(!isDefined(var_1.script_noteworthy)) {
    return;
  }

  if(!scripts\engine\utility::istrue(var_3.triggeredtimequest)) {
    return;
  }

  var_4 = 2;
  var_5 = 100000;
  var_6 = [];
  var_7 = gettime();
  var_0.got_hit_by_player = 0;
  if(!isDefined(var_3.hidden_figures_hit)) {
    var_3.hidden_figures_hit = 0;
  }

  if(!isDefined(level.hidden_figures_killed)) {
    level.hidden_figures_killed = 0;
  }

  thread activatefiguredamage(var_1, var_3, var_0);
  var_0 showtoplayer(var_3);
  for(;;) {
    if(!scripts\engine\utility::istrue(var_3.triggeredtimequest)) {
      break;
    }

    var_8 = randomintrange(-200, 200);
    var_9 = randomintrange(-200, 200);
    var_0A = randomintrange(90, 200);
    var_3.figure_one_offset = (var_8, var_9, var_0A);
    var_0B = randomintrange(-200, 200);
    var_0C = randomintrange(-200, 200);
    var_0D = randomintrange(90, 200);
    var_3.figure_two_offset = (var_0B, var_0C, var_0D);
    var_0E = randomintrange(-200, 200);
    var_0F = randomintrange(-200, 200);
    var_10 = randomintrange(90, 200);
    var_3.figure_three_offset = (var_0E, var_0F, var_10);
    var_11 = randomintrange(-200, 200);
    var_12 = randomintrange(-200, 200);
    var_13 = randomintrange(90, 200);
    var_3.figure_four_offset = (var_11, var_12, var_13);
    switch (var_1.script_noteworthy) {
      case "fig_1":
        var_1.playeroffset[var_3.name] = var_3.origin + var_3.figure_one_offset;
        var_0 setModel("tag_origin_hidden_figure_final");
        var_0 setscriptablepartstate("figure_effect", "active");
        var_0.origin = var_3.origin + var_3.figure_one_offset;
        break;

      case "fig_2":
        var_1.playeroffset[var_3.name] = var_3.origin + var_3.figure_two_offset;
        var_0 setModel("tag_origin_hidden_figure_final");
        var_0 setscriptablepartstate("figure_effect", "active");
        var_0.origin = var_3.origin + var_3.figure_two_offset;
        break;

      case "fig_3":
        var_1.playeroffset[var_3.name] = var_3.origin + var_3.figure_three_offset;
        var_0 setModel("tag_origin_hidden_figure_final");
        var_0 setscriptablepartstate("figure_effect", "active");
        var_0.origin = var_3.origin + var_3.figure_three_offset;
        break;

      case "fig_4":
        var_1.playeroffset[var_3.name] = var_3.origin + var_3.figure_four_offset;
        var_0 setModel("tag_origin_hidden_figure_final");
        var_0 setscriptablepartstate("figure_effect", "active");
        var_0.origin = var_3.origin + var_3.figure_four_offset;
        break;
    }

    if(int(distance(var_0.origin, var_3.origin)) <= 120) {
      if(var_3 func_843B()) {
        if(randomint(100) > 50) {
          var_3 dodamage(int(var_3.health / 4), var_3.origin);
        }
      } else {
        var_3 dodamage(int(var_3.health / 4), var_3.origin);
      }
    }

    var_0.angles = vectortoangles(var_3.origin - var_0.origin);
    var_1.model = var_0;
    wait(var_4);
  }

  var_0 setscriptablepartstate("figure_effect", "neutral");
  scripts\engine\utility::waitframe();
  var_0 setscriptablepartstate("figure_effect", "death");
  level notify("end_hidden_figures_sequence_for_" + var_3.name);
}

setup_hidden_figure_models(var_0, var_1) {
  scripts\cp\maps\cp_final\cp_final::addtopersonalinteractionlist(var_0);
  switch (var_1) {
    case "fig_4":
    case "fig_3":
    case "fig_2":
    case "fig_1":
      break;
  }
}

modfunc(var_0, var_1) {
  return var_0 % var_1 + var_1 % var_1;
}

isalphabet(var_0) {
  foreach(var_3, var_2 in level.alphabets) {
    if(var_0 == var_3) {
      return 1;
    }
  }

  return 0;
}

cipher(var_0, var_1, var_2) {
  var_3 = var_1.size;
  var_4 = var_0.size;
  var_5 = 0;
  var_6 = [];
  for(var_7 = 0; var_7 < var_4; var_7++) {
    if(isalphabet(var_0[var_7])) {
      var_8 = var_7 - var_5 % var_3;
      var_9 = var_1[var_8];
      if(!var_2) {
        var_9 = -1 * derivenumberfromletter(var_9);
      } else {
        var_9 = derivenumberfromletter(var_9);
      }

      var_0A = modfunc(derivenumberfromletter(var_0[var_7]) + var_9, 26);
      var_6[var_7] = deriveletterfromnumber(var_0A);
      continue;
    }

    var_6[var_7] = var_0[var_7];
    var_5++;
  }

  return var_6;
}

derivenumberfromletter(var_0) {
  foreach(var_3, var_2 in level.alphabets) {
    if(var_0 == var_3) {
      return var_2;
    }
  }

  foreach(var_6, var_5 in level.alphabets_capped) {
    if(var_0 == var_6) {
      return var_5;
    }
  }
}

deriveletterfromnumber(var_0) {
  foreach(var_3, var_2 in level.alphabets) {
    if(var_2 == var_0) {
      return var_3;
    }
  }

  foreach(var_6, var_5 in level.alphabets_capped) {
    if(var_5 == var_0) {
      return var_6;
    }
  }
}

changearraytoword(var_0) {
  var_1 = "";
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isDefined(var_0[var_2])) {
      continue;
    }

    var_1 = var_1 + var_0[var_2];
  }

  return var_1;
}