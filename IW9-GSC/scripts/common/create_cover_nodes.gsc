/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\create_cover_nodes.gsc
*************************************************/

create_cover_node_init() {
  level endon("game_ended");
  initialize_path_node_placement();
  scripts\engine\utility::flag_init("file_opened");
}

initialize_path_node_placement() {
  struct = spawnStruct();
  struct.trace_contents = scripts\engine\trace::create_solid_ai_contents(1);
  struct.all_node_positions = [];
  struct.map_ent_index = 1;
  level.path_node_debug_info = struct;
  reset_path_node_placement();
  return level.path_node_debug_info;
}

reset_path_node_placement_for_radius() {
  struct = reset_path_node_placement();
  struct.x_magnitude = 32;
  struct.y_magnitude = 32;
  struct.max_x = 20;
  struct.max_y = 20;
  level.path_node_debug_info = struct;
  return level.path_node_debug_info;
}

reset_path_node_placement_for_lookat() {
  struct = reset_path_node_placement();
  struct.debug_boxes = 1;
  struct.node_creation_traces = 32;
  struct.delayed_creation_calls = 0;
  struct.create_node_throttle = 500;
  level.path_node_debug_info = struct;
  return level.path_node_debug_info;
}

reset_path_node_placement_for_box_creation() {
  struct = reset_path_node_placement();
  struct.debug_boxes = 1;
  struct.debug_boxes_max_count = 50;
  struct.debug_boxes_count = 0;
  struct.valid_forward_dist = 64;
  struct.x_magnitude = 256;
  struct.y_magnitude = 256;
  struct.z_magnitude = 128;
  struct.max_nav_offset = 4096;
  struct.create_node_throttle = 5000;
  struct.max_x = undefined;
  struct.max_y = undefined;
  struct.max_z = undefined;
  level.path_node_debug_info = struct;
  return level.path_node_debug_info;
}

reset_path_node_placement() {
  struct = level.path_node_debug_info;
  struct.total_grid_points = 0;
  struct.start_time = gettime();
  struct.end_time = gettime();
  struct.total_time = gettime();
  struct.box_x = 1024;
  struct.box_y = 1024;
  struct.box_z = 512;
  struct.box_x_min = 512;
  struct.box_y_min = 512;
  struct.box_z_min = 128;
  struct.increase_x = 1;
  struct.increase_y = 1;
  struct.increase_z = 1;
  struct.box_center = (0, 0, 0);
  struct.box_angles = (0, 0, 0);
  struct.freeze_location = 0;
  struct.box_disabled = 0;
  struct.x_done = 0;
  struct.y_done = 0;
  struct.z_done = 0;
  struct.auto_write_to_map = 1;
  struct.use_bsp_nodes = getdvarint("dvar_6DFA92B12C1B37B6", 1);
  struct.debug_boxes = getdvarint("dvar_621E43977DAE92FF", 0);
  struct.edge_placement = 1;
  struct.file_path = level.script + "_script_paths.map";
  struct.node_creation_traces = 16;
  struct.node_creation_trace_index = 0;
  struct.node_creation_trace_dist = 365;
  struct.node_creation_angle_frac = 360 / struct.node_creation_traces;
  struct.aa_status = "waiting";
  struct.create_node_throttle = 5000;
  struct.throttle_counter = 0;
  struct.traces_count = 0;
  struct.x_magnitude = 256;
  struct.y_magnitude = 256;
  struct.z_magnitude = 64;
  struct.max_nav_offset = 16384;
  struct.valid_forward_dist = 64;
  struct.current_forward_dist = undefined;
  struct.x = 1;
  struct.y = 1;
  struct.z = 1;
  struct.max_x = undefined;
  struct.max_y = undefined;
  struct.last_x = 1;
  struct.last_y = 1;
  struct.x_dir_fails = 0;
  struct.y_dir_fails = 0;
  struct.dir_fails = 0;
  struct.max_dir_fails = 500;
  struct.total_z_planes = 5;
  struct.origin_counter = 0;
  struct.origin_max_dirs = 8;
  struct.dir_valid[0] = 1;
  struct.dir_valid[1] = 1;
  struct.dir_valid[2] = 1;
  struct.dir_valid[3] = 1;
  struct.dir_valid[4] = 1;
  struct.dir_valid[5] = 1;
  struct.dir_valid[6] = 1;
  struct.dir_valid[7] = 1;
  struct.grid_points_found = 1;
  struct.wall_units = 0;
  struct.wall_units_required = 32;
  struct.found_left_edge = 0;
  struct.found_right_edge = 0;
  struct.found_up_edge = 0;
  struct.found_exposed_pos = 0;
  struct.use_trace_data = getdvarint("dvar_7B41CE964C40BC15", 0);
  struct.save_trace_data = 0;
  struct.temp_trace_data = [];
  struct.temp_trace_data_colors = [];
  struct.trace_data = [];
  struct.trace_data_colors = [];
  struct.grid_origin = (0, 0, 0);
  struct.density_radius = 64;
  struct.density_cap = 4;
  struct.density_cap_count = 0;
  struct.found_valid_node_pos = 0;
  struct.create_exposed_node = getdvarint("dvar_F42B414F3A439BF6", 0);
  struct.should_create_exposed_node = 1;
  level.path_node_debug_info = struct;
  level.increase_y = struct;
  level.num_fails = 0;
  return level.path_node_debug_info;
}

debugdata() {
  return level.path_node_debug_info;
}

run_single_grid_point_test(player) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  player endon("disconnect");
  level endon("stop_creating_nodes");
  reset_path_node_placement_for_box_creation();
  data = debugdata();
  data.player = player;
  open_and_write_to_paths_map();
  player notifyonplayercommand("use", "+usereload");
  player notifyonplayercommand("use", "+activate");

  for(;;) {
    player waittill("use");
    data thread delay_node_creation_from_single_point();
  }
}

place_path_node_from_lookat(player) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  player endon("disconnect");
  level endon("stop_creating_nodes");
  reset_path_node_placement_for_lookat();
  data = debugdata();
  data.player = player;
  open_and_write_to_paths_map();
  player notifyonplayercommand("use", "+usereload");
  player notifyonplayercommand("use", "+activate");

  for(;;) {
    player waittill("use");
    data childthread show_running_tool_message();
    delay_node_creation_from_look_at();
    data notify("stop_showing_message");
  }
}

delay_node_creation_from_single_point() {
  data = debugdata();
  player = data.player;
  open_and_write_to_paths_map();
  data.starting_pos = player.origin;
  _id_70222FBC47330166 = anglesToForward(player getplayerangles());
  result = create_node_trace(data.player getEye(), data.player getEye() + _id_70222FBC47330166 * 10000);

  if(isDefined(result["position"]) && isDefined(result["fraction"]) && result["fraction"] < 1) {
    _id_55A01E81BDA4CC0C = scripts\engine\utility::drop_to_ground(result["position"] + -1 * (_id_70222FBC47330166 * 32), 96, -300) + (0, 0, 16);
    data.x = _id_55A01E81BDA4CC0C[0];
    data.y = _id_55A01E81BDA4CC0C[1];
    data.z = _id_55A01E81BDA4CC0C[2];
    data.origin = _id_55A01E81BDA4CC0C;
    data.grid_origin = _id_55A01E81BDA4CC0C;

    if(validate_grid_pos()) {
      data.node_type = "script_struct";
      data.total_grid_points++;
      data.angles = (0, 0, 0);
      write_struct_to_map();
      data.classname = "node_exposed";
      create_and_validate_node_from_single_grid_point();
    }
  }
}

delay_node_creation_from_look_at() {
  data = debugdata();
  player = data.player;
  open_and_write_to_paths_map();
  data.starting_pos = player.origin;
  _id_70222FBC47330166 = anglesToForward(player getplayerangles());
  result = create_node_trace(data.player getEye(), data.player getEye() + _id_70222FBC47330166 * 10000);

  if(isDefined(result["position"]) && isDefined(result["fraction"]) && result["fraction"] < 1) {
    _id_55A01E81BDA4CC0C = scripts\engine\utility::drop_to_ground(result["position"] + -1 * (_id_70222FBC47330166 * 32), 24, -300) + (0, 0, 16);
    data.x = _id_55A01E81BDA4CC0C[0];
    data.y = _id_55A01E81BDA4CC0C[1];
    data.z = _id_55A01E81BDA4CC0C[2];
    data.origin = _id_55A01E81BDA4CC0C;
    data.grid_origin = _id_55A01E81BDA4CC0C;

    if(validate_grid_pos()) {
      data.angles = (0, 0, 0);
      data.classname = "node_exposed";
      create_cover_nodes_from_grid_point();
    }
  }
}

place_path_nodes_within_box(player) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  player endon("disconnect");
  level endon("stop_creating_nodes");
  data = debugdata();
  data.player = player;
  player notifyonplayercommand("use", "+usereload");
  player notifyonplayercommand("use", "+activate");
  reset_path_node_placement_for_box_creation();
  data childthread create_and_update_box();

  for(;;) {
    player waittill("use");
    data.x = 0;
    data.y = 0;
    data.z = 0;
    data.increase_x = 1;
    data.increase_y = 1;
    data.increase_z = 1;
    data.x_done = 0;
    data.y_done = 0;
    data.z_done = 0;
    data.max_x = int(data.box_x / data.x_magnitude / 2 + 1);
    data.max_y = int(data.box_y / data.y_magnitude / 2 + 1);
    data.max_z = int(data.box_z / data.z_magnitude / 2 + 1);
    data.box_disabled = 1;
    open_and_write_to_paths_map();
    data.starting_pos = data.box_center;
    data childthread show_running_tool_message();
    data.start_time = gettime();
    create_cover_nodes_within_volume();
    data.end_time = gettime();
    data.total_time = (data.end_time - data.start_time) / 1000;
    data notify("stop_showing_message");
    data.box_disabled = 0;
  }
}

create_and_update_box() {
  data = debugdata();
  data.player notifyonplayercommand("up", "+actionslot 1");
  data.player notifyonplayercommand("down", "+actionslot 2");
  data.player notifyonplayercommand("right", "+actionslot 4");
  data.player notifyonplayercommand("rb", "+frag");
  data.player notifyonplayercommand("lb", "+smoke");
  data.player notifyonplayercommand("a", "+gostand");
  data.player notifyonplayercommand("left", "+actionslot 3");
  data.player notifyonplayercommand("dpad_left_release", "-actionslot 3");
  data.player notifyonplayercommand("dpad_left_press", "+actionslot 3");
  data childthread create_box();

  for(;;) {
    result = data.player scripts\engine\utility::waittill_any_in_array_return(["up", "a", "down", "left", "rb", "lb", "right", "dpad_left_release", "dpad_left_press"]);

    if(data.box_disabled) {
      wait 1;
      continue;
    }

    switch (result) {
      case "right":
        while(data.player buttonPressed("DPAD_RIGHT")) {
          data.box_y = data.box_y + data.y_magnitude;
          wait 0.1;
        }

        break;
      case "dpad_left_press":
      case "dpad_left_release":
      case "left":
        data.box_y = int(max(data.box_y - data.y_magnitude, data.box_y_min));
        wait 0.1;
        break;
      case "a":
        if(data.freeze_location)
          data.freeze_location = 0;
        else
          data.freeze_location = 1;

        break;
      case "up":
        while(data.player buttonPressed("DPAD_UP")) {
          data.box_x = data.box_x + data.x_magnitude;
          wait 0.1;
        }

        break;
      case "down":
        while(data.player buttonPressed("DPAD_DOWN")) {
          data.box_x = int(max(data.box_x - data.x_magnitude, data.box_x_min));
          wait 0.1;
        }

        break;
      case "rb":
        while(data.player buttonPressed("BUTTON_RSHLDR")) {
          data.box_z = data.box_z + data.z_magnitude;
          wait 0.1;
        }

        break;
      case "lb":
        while(data.player buttonPressed("BUTTON_LSHLDR")) {
          data.box_z = int(max(data.box_z - data.z_magnitude, data.box_z_min));
          wait 0.1;
        }

        break;
      default:
        break;
    }
  }
}

show_running_tool_message() {
  self endon("stop_showing_message");
  timer = 0;

  for(;;) {
    _id_254DDB6B0EDE6C93 = 500;
    msg = "Creating Nodes | Time Elapsed: " + timer;
    waitframe();
    timer = timer + 0.05;
  }
}

create_box() {
  data = debugdata();
  player = data.player;
  _id_A53E70F6D949BABD = player.origin + anglesToForward(player.angles) * 500;
  box_angles = player.angles;
  last_pos = _id_A53E70F6D949BABD;
  last_angles = box_angles;

  for(;;) {
    if(data.box_disabled) {
      wait 1;
      continue;
    }

    _id_254DDB6B0EDE6C93 = 150;

    if(getdvarint("dvar_B6E86AF00EB83738", 0) != 0) {
      data.box_x = getdvarint("dvar_B6E86AF00EB83738", 0);
      msg = "X: " + data.box_x;
    } else
      msg = "X: " + data.box_x;

    _id_254DDB6B0EDE6C93 = _id_254DDB6B0EDE6C93 + 25;

    if(getdvarint("dvar_B6E86BF00EB8396B", 0) != 0) {
      data.box_x = getdvarint("dvar_B6E86BF00EB8396B", 0);
      msg = "Y: " + data.box_y;
    } else
      msg = "Y: " + data.box_y;

    _id_254DDB6B0EDE6C93 = _id_254DDB6B0EDE6C93 + 25;

    if(getdvarint("dvar_B6E86CF00EB83B9E", 0) != 0) {
      data.box_x = getdvarint("dvar_B6E86CF00EB83B9E", 0);
      msg = "Z: " + data.box_z;
    } else
      msg = "Z: " + data.box_z;

    _id_254DDB6B0EDE6C93 = _id_254DDB6B0EDE6C93 + 25;
    msg = "Location Locked: " + data.freeze_location;
    _id_254DDB6B0EDE6C93 = _id_254DDB6B0EDE6C93 + 25;

    if(data.freeze_location) {
      _id_A53E70F6D949BABD = last_pos;
      box_angles = last_angles;
    } else {
      _id_A53E70F6D949BABD = player.origin + anglesToForward(player.angles) * 500;
      box_angles = player.angles;
    }

    last_pos = _id_A53E70F6D949BABD;
    last_angles = box_angles;
    data.box_center = _id_A53E70F6D949BABD;
    data.box_angles = box_angles;
    waitframe();
  }
}

place_path_nodes_within_radius(player) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  player endon("disconnect");
  level endon("stop_creating_nodes");
  data = debugdata();
  data.player = player;
  player notifyonplayercommand("use", "+usereload");
  player notifyonplayercommand("use", "+activate");

  for(;;) {
    reset_path_node_placement_for_radius();
    player waittill("use");
    open_and_write_to_paths_map();
    data.starting_pos = player.origin;
    create_cover_nodes_from_grid_points();
  }
}

place_path_nodes(player) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  player endon("disconnect");
  data = debugdata();
  data.player = player;
  data.starting_pos = player.origin;
  reset_path_node_placement();
  open_and_write_to_paths_map();
  data.aa_status = "starting";
  data childthread show_running_tool_message();
  create_cover_nodes_from_grid_points();
  data notify("stop_showing_message");
  close_map_write();
}

clean_up_nodes() {
  level endon("game_ended");
  level endon("stop_creating_nodes");
  data = debugdata();
  reset_path_node_placement();
  open_and_write_to_paths_map();
  data.aa_status = "starting";
  data.use_bsp_nodes = 0;
  data.file_path = level.script + "_script_paths_clean.map";
  data childthread show_running_tool_message();
  _id_73E40D6BBC1A5A97 = getallnodes();
  _id_C6736586AE30F7EA = _id_73E40D6BBC1A5A97;

  if(getdvarint("dvar_B2A482FBFCA2360C", 1) && isDefined(level.path_node_table) && tableexists(level.path_node_table)) {
    table = level.path_node_table;
    _id_CB89110314447B2F = 0;

    for(;;) {
      classname = tablelookupbyrow(table, _id_CB89110314447B2F, 0);

      if(classname == "") {
        break;
      }

      _id_B238811858DD87E6 = strtok(tablelookupbyrow(table, _id_CB89110314447B2F, 2), " ");
      _id_CA5534A90F13A4D4 = (float(_id_B238811858DD87E6[0]), float(_id_B238811858DD87E6[1]), float(_id_B238811858DD87E6[2]));
      _id_9E1A87F6DE056C9C = strtok(tablelookupbyrow(table, _id_CB89110314447B2F, 3), " ");
      _id_9CFE111EA9DF5B56 = (float(_id_9E1A87F6DE056C9C[0]), float(_id_9E1A87F6DE056C9C[1]), float(_id_9E1A87F6DE056C9C[2]));
      dist = 16;
      _id_310053492C44C60E = getdvarint("dvar_C1200BC122DD1EE0");

      if(_id_310053492C44C60E != 0)
        dist = _id_310053492C44C60E;

      _id_ABD9EE4725B96FC2 = dist * dist;
      data.origin = _id_CA5534A90F13A4D4;
      data.angles = _id_9CFE111EA9DF5B56;
      origin_offset = strtok(tablelookupbyrow(table, _id_CB89110314447B2F, 4), " ");
      origin_offset = (float(origin_offset[0]), float(origin_offset[1]), float(origin_offset[2]));
      angles_offset = strtok(tablelookupbyrow(table, _id_CB89110314447B2F, 5), " ");
      angles_offset = (float(angles_offset[0]), float(angles_offset[1]), float(angles_offset[2]));
      data translate_position_with_offset_data(origin_offset, angles_offset);
      _id_55A01E81BDA4CC0C = getgroundposition(data.origin, 1);
      data.origin = _id_55A01E81BDA4CC0C;

      if(isDefined(classname)) {
        if(node_passes_nav_and_geo_validation()) {
          data.origin = _id_CA5534A90F13A4D4;
          data.angles = _id_9CFE111EA9DF5B56;
          data.node_type = classname;
          write_struct_to_map();
        }
      }

      _id_CB89110314447B2F++;
    }
  } else {
    _id_75014D7F84CEEA72 = 0;

    while(_id_C6736586AE30F7EA.size > 1) {
      node = _id_C6736586AE30F7EA[0];
      _id_C6736586AE30F7EA = scripts\engine\utility::array_remove_index(_id_C6736586AE30F7EA, 0, 0);
      _id_55A01E81BDA4CC0C = getgroundposition(node.origin, 16);
      data.origin = _id_55A01E81BDA4CC0C;
      data.angles = node.angles;

      if(node_passes_nav_and_geo_validation(1)) {
        if(isDefined(node.type)) {
          switch (node.type) {
            case "Cover Left":
              data.node_type = "node_cover_left";
              write_struct_to_map();
              break;
            case "Cover Right":
              data.node_type = "node_cover_right";
              write_struct_to_map();
              break;
            case "Cover Crouch":
              data.node_type = "node_cover_crouch";
              write_struct_to_map();
              break;
            case "Exposed":
              data.node_type = "node_exposed";
              write_struct_to_map();
              break;
            case "Exposed Crouch":
              data.node_type = "exposed_crouch";
              write_struct_to_map();
              break;
            case "Cover Crouch Window":
              data.node_type = "node_cover_crouch_window";
              write_struct_to_map();
              break;
            default:
              break;
          }
        }

        _id_B217F6D03CCC3F2E = [];
        _id_C12A580CEB39E9F8 = getnodesinradius(data.origin, 16, 0, 32);
        _id_C6736586AE30F7EA = scripts\engine\utility::array_remove_array(_id_C6736586AE30F7EA, _id_C12A580CEB39E9F8);
      }

      _id_75014D7F84CEEA72++;

      if(_id_75014D7F84CEEA72 % 100)
        waitframe();
    }
  }

  data notify("stop_showing_message");
  close_map_write();
  reset_path_node_placement();
}

translate_position_with_offset_data(_id_A1306EE53C20150F, _id_E3C2F7A7F3D4CCE6) {
  if(isDefined(_id_E3C2F7A7F3D4CCE6))
    _id_82B752B102F67A72 = _id_E3C2F7A7F3D4CCE6;
  else
    _id_82B752B102F67A72 = (0, 0, 0);

  if(isDefined(self.angles))
    _id_8DD49492E28FCABB = self.angles;
  else
    _id_8DD49492E28FCABB = (0, 0, 0);

  _id_B0FDD17853C7B165 = self.origin;
  _id_C6335BC5BCF52780 = anglesToForward(_id_8DD49492E28FCABB);
  self.origin = _id_A1306EE53C20150F + rotatevector(_id_B0FDD17853C7B165, _id_82B752B102F67A72);
  _id_D241032D837036A4 = vectortoangles(rotatevector(_id_C6335BC5BCF52780, _id_82B752B102F67A72));
  self.angles = _id_D241032D837036A4;
}

node_passes_nav_and_geo_validation(_id_1325C007EAAC8163) {
  data = debugdata();

  if(distancesquared(getclosestpointonnavmesh(data.origin), data.origin) >= 1024)
    return 0;
  else if(!can_spawn_capsule_trace(data.origin))
    return 0;
  else if(!istrue(_id_1325C007EAAC8163)) {
    _id_C12A580CEB39E9F8 = getnodesinradius(data.origin, 16, 0, 64);

    if(_id_C12A580CEB39E9F8.size < 1) {
      return 1;
      return;
    }

    return 0;
    return;
  } else
    return 1;
}

remove_similar_nodes(player) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  player endon("disconnect");
  level endon("stop_creating_nodes");
  dist = 100;
  _id_310053492C44C60E = getdvarint("dvar_C1200BC122DD1EE0");

  if(_id_310053492C44C60E != 0)
    dist = _id_310053492C44C60E;

  _id_ABD9EE4725B96FC2 = dist * dist;
  data = debugdata();
  data.player = player;
  reset_path_node_placement();
  open_and_write_to_paths_map();
  data.aa_status = "starting";
  _id_73E40D6BBC1A5A97 = getallnodes();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_73E40D6BBC1A5A97.size; _id_AC0E594AC96AA3A8++) {
    _id_A4DCCDD15E860A7E = _id_73E40D6BBC1A5A97[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_A4DCCDD15E860A7E)) {
      _id_91CA07907A589301 = 0;

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_73E40D6BBC1A5A97.size; _id_AC0E5C4AC96AAA41++) {
        _id_87448CC476173066 = _id_73E40D6BBC1A5A97[_id_AC0E5C4AC96AAA41];

        if(!isDefined(_id_87448CC476173066)) {
          continue;
        }
        if(_id_87448CC476173066.origin == _id_A4DCCDD15E860A7E.origin) {
          continue;
        }
        position = _id_A4DCCDD15E860A7E.origin;
        _id_45F9A855D9BAAA6B = distancesquared(position, _id_87448CC476173066.origin);

        if(_id_45F9A855D9BAAA6B <= _id_ABD9EE4725B96FC2) {
          if(_id_A4DCCDD15E860A7E.type == _id_87448CC476173066.type) {
            if(_id_A4DCCDD15E860A7E.angles == _id_87448CC476173066.angles) {
              _id_91CA07907A589301 = 1;
              break;
            }
          }
        }
      }

      if(!_id_91CA07907A589301) {
        data.node_type = get_node_type_from_type(_id_A4DCCDD15E860A7E);

        if(isDefined(data.node_type)) {
          data.origin = _id_A4DCCDD15E860A7E.origin;
          data.angles = _id_A4DCCDD15E860A7E.angles;
          write_struct_to_map();
        } else
          _id_73E40D6BBC1A5A97[_id_AC0E594AC96AA3A8] = undefined;
      } else
        _id_73E40D6BBC1A5A97[_id_AC0E594AC96AA3A8] = undefined;
    }
  }

  level thread close_map_write();
}

similar_nodes_nearby() {
  data = debugdata();
  dist = 100;
  _id_ABD9EE4725B96FC2 = dist * dist;

  if(data.use_bsp_nodes) {
    _id_73E40D6BBC1A5A97 = getallnodes();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_73E40D6BBC1A5A97.size; _id_AC0E594AC96AA3A8++) {
      _id_A4DCCDD15E860A7E = _id_73E40D6BBC1A5A97[_id_AC0E594AC96AA3A8];

      if(isDefined(_id_A4DCCDD15E860A7E)) {
        if(data.origin == _id_A4DCCDD15E860A7E.origin)
          return 0;

        _id_45F9A855D9BAAA6B = distancesquared(_id_A4DCCDD15E860A7E.origin, data.origin);

        if(_id_45F9A855D9BAAA6B <= _id_ABD9EE4725B96FC2) {
          if(_id_A4DCCDD15E860A7E.angles == data.angles)
            return 0;
        }
      }
    }
  }

  _id_73E40D6BBC1A5A97 = level.path_node_debug_info.all_node_positions;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_73E40D6BBC1A5A97.size; _id_AC0E594AC96AA3A8++) {
    _id_A4DCCDD15E860A7E = _id_73E40D6BBC1A5A97[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_A4DCCDD15E860A7E)) {
      if(data.origin == _id_A4DCCDD15E860A7E.origin)
        return 0;

      _id_45F9A855D9BAAA6B = distancesquared(data.origin, _id_A4DCCDD15E860A7E.origin);

      if(_id_45F9A855D9BAAA6B <= _id_ABD9EE4725B96FC2) {
        if(_id_A4DCCDD15E860A7E.angles == data.angles)
          return 0;
      }
    }
  }

  return 1;
}

get_node_type_from_type(node) {
  switch (node.type) {
    case "Cover Crouch":
      return "node_cover_crouch";
    case "Cover Left":
      return "node_cover_left";
    case "Cover Right":
      return "node_cover_right";
    case "Cover Stand":
      return "node_cover_stand";
    case "Cover Exposed":
      return "node_exposed";
  }

  return undefined;
}

get_raw_or_devraw_subdir() {
  return "raw";
}

get_gamemode_subdir() {
  return "cp";
}

close_map_write() {
  data = debugdata();

  if(scripts\engine\utility::flag("file_opened")) {
    scripts\engine\utility::flag_clear("file_opened");
    _id_608A7AA6A524529D = data.file_path;
    _id_51CE59302DC1069D = get_raw_or_devraw_subdir();
    _id_E47CF6F2FC269250 = get_gamemode_subdir();
    _id_89BB38B8C97A2660 = "/map_source/" + _id_608A7AA6A524529D;
    _id_AE8D497AE110B85C = 1;
    scripts\engine\utility:: fileprint_launcher_end_file( _id_89BB38B8C97A2660, _id_AE8D497AE110B85C );
      level notify("stop_creating_nodes");
  }

  if(getdvarint("dvar_7B41CE964C40BC15", 0))
    level thread debug_node_array(data.all_node_positions);
}

create_cover_nodes_within_volume() {
  level endon("game_ended");
  data = debugdata();
  data.aa_status = "creating_cover_node_positions";
  data.grid_points_found = 1;
  data.increase_y = 1;

  while(data.grid_points_found) {
    data.num_fails = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < data.origin_max_dirs; _id_AC0E594AC96AA3A8++) {
      data.origin_counter = _id_AC0E594AC96AA3A8;
      get_next_volume_origin();

      if(vol_validate_grid_pos()) {
        data.angles = (0, 0, 0);
        data.node_type = "script_struct";
        data.origin = data.grid_origin;
        data.classname = "node_exposed";
        vol_create_cover_nodes_from_grid_point();
      }
    }

    create_grid_point_in_volume();
  }

  iprintlnbold("Create Node Completed " + data.all_node_positions.size + " Created.");
}

vol_create_cover_nodes_from_grid_point() {
  data = debugdata();
  data.should_create_exposed_node = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= data.node_creation_traces; _id_AC0E594AC96AA3A8++) {
    data.node_creation_trace_index = _id_AC0E594AC96AA3A8;
    vol_create_and_validate_node();
  }

  if(istrue(data.create_exposed_node) && istrue(data.should_create_exposed_node)) {
    _id_056DCF8813D0329E = scripts\engine\utility::drop_to_ground(data.grid_origin, 16, -300) + (0, 0, 16);
    data.origin = _id_056DCF8813D0329E;

    if(can_spawn_capsule_trace(_id_056DCF8813D0329E) && !trace_for_stairs()) {
      data.angles = (0, 0, 0);

      if(!similar_nodes_nearby()) {
        return;
      }
      data.node_type = "node_exposed";
      run_path_node_removal();
    }
  }
}

create_cover_nodes_from_grid_points() {
  level endon("game_ended");
  level endon("end_grid_creation");
  data = debugdata();
  data.aa_status = "creating_cover_node_positions";
  data.grid_points_found = 1;
  data.increase_y = 1;

  while(data.grid_points_found) {
    data.num_fails = 0;
    create_grid_point();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < data.origin_max_dirs; _id_AC0E594AC96AA3A8++) {
      data.origin_counter = _id_AC0E594AC96AA3A8;

      for(z = 0; z < data.total_z_planes; z++) {
        data.z = z;
        get_next_origin();

        if(validate_grid_pos()) {
          data.angles = (0, 0, 0);
          data.classname = "node_exposed";
          create_cover_nodes_from_grid_point();
        }
      }
    }
  }

  iprintlnbold("Create Node Completed " + data.all_node_positions.size + " Created.");
}

create_grid_point_in_volume() {
  data = debugdata();

  if(data.increase_x)
    vol_increase_x_coordinate();
  else if(data.increase_y) {
    data.increase_x = 1;
    data.x = 0;
    vol_increase_y_coordinate();
  } else {
    data.increase_x = 1;
    data.increase_y = 1;
    data.x = 0;
    data.y = 0;
    vol_increase_z_coordinate();
  }

  if(data.x_done && data.y_done && data.z_done) {
    data.grid_points_found = 0;
    level notify("end_grid_creation");
  }
}

create_grid_point() {
  data = debugdata();
  num_fails = 0;

  if(!increase_y_coordinate()) {
    num_fails++;

    if(increase_x_coordinate())
      data.y = 1;
    else
      num_fails++;
  }

  if(num_fails >= 2) {
    data.grid_points_found = 0;
    level notify("end_grid_creation");
  }
}

create_grid_point_new() {
  data = debugdata();

  if(data.dir_fails >= data.max_dir_fails) {
    data.grid_points_found = 0;
    level notify("end_grid_creation");
  } else {
    num_fails = 0;

    if(isDefined(data.max_y)) {
      if(data.y > data.max_y)
        num_fails++;
    }

    if(isDefined(data.max_x)) {
      if(data.x > data.max_x)
        num_fails++;
    }

    if(num_fails >= 2) {
      data.grid_points_found = 0;
      level notify("end_grid_creation");
      return;
    }

    if(data.increase_y) {
      increase_y_coordinate_new();
      data.increase_y = 0;
      return;
    }

    increase_x_coordinate_new();
    data.increase_y = 1;
  }
}

increase_y_coordinate_new() {
  data = debugdata();

  if(isDefined(data.max_y)) {
    if(data.y < data.max_y) {
      data.y++;
      return 1;
    } else
      return 0;
  } else {
    data.y++;
    return 1;
  }
}

increase_x_coordinate_new() {
  data = debugdata();

  if(isDefined(data.max_x)) {
    if(data.x < data.max_x) {
      data.x++;
      return 1;
    } else
      return 0;
  } else {
    data.x++;
    return 1;
  }
}

increase_x_coordinate() {
  data = debugdata();

  if(data.x_dir_fails <= data.max_dir_fails) {
    if(isDefined(data.max_x)) {
      if(data.x < data.max_x) {
        data.x++;
        return 1;
      } else
        return 0;
    } else {
      data.x++;
      return 1;
    }
  } else
    return 0;
}

vol_increase_x_coordinate() {
  data = debugdata();

  if(isDefined(data.max_x)) {
    if(data.x < data.max_x) {
      data.x++;
      return 1;
    } else {
      data.increase_x = 0;
      data.x_done = 1;
      return 0;
    }
  } else {
    data.x++;
    return 1;
  }
}

increase_y_coordinate() {
  data = debugdata();

  if(data.y_dir_fails <= data.max_dir_fails) {
    if(isDefined(data.max_y)) {
      if(data.y < data.max_y) {
        data.y++;
        return 1;
      } else
        return 0;
    } else {
      data.y++;
      return 1;
    }
  } else
    return 0;
}

vol_increase_y_coordinate() {
  data = debugdata();

  if(isDefined(data.max_y)) {
    if(data.y < data.max_y) {
      data.y++;
      return 1;
    } else {
      data.increase_y = 0;
      data.y_done = 1;
      return 0;
    }
  } else {
    data.y++;
    return 1;
  }
}

vol_increase_z_coordinate() {
  data = debugdata();

  if(isDefined(data.max_z)) {
    if(data.z < data.max_z) {
      data.z++;
      return 1;
    } else {
      data.z_done = 1;
      return 0;
    }
  } else {
    data.z++;
    return 1;
  }
}

get_next_origin() {
  data = debugdata();
  starting_pos = data.starting_pos;
  x = data.x;
  y = data.y;
  z = data.z;

  if(data.dir_valid[data.origin_counter]) {
    switch (data.origin_counter) {
      case 0:
        data.grid_origin = starting_pos + (x * data.x_magnitude, y * data.y_magnitude, z * data.z_magnitude);
        break;
      case 1:
        data.grid_origin = starting_pos + (-1 * (x * data.x_magnitude), y * data.y_magnitude, z * data.z_magnitude);
        break;
      case 2:
        data.grid_origin = starting_pos + (-1 * (x * data.x_magnitude), -1 * (y * data.y_magnitude), z * data.z_magnitude);
        break;
      case 3:
        data.grid_origin = starting_pos + (-1 * (x * data.x_magnitude), y * data.y_magnitude, -1 * (z * data.z_magnitude));
        break;
      case 4:
        data.grid_origin = starting_pos + (-1 * (x * data.x_magnitude), -1 * (y * data.y_magnitude), -1 * (z * data.z_magnitude));
        break;
      case 5:
        data.grid_origin = starting_pos + (x * data.x_magnitude, -1 * (y * data.y_magnitude), z * data.z_magnitude);
        break;
      case 6:
        data.grid_origin = starting_pos + (x * data.x_magnitude, -1 * (y * data.y_magnitude), -1 * (z * data.z_magnitude));
        break;
      case 7:
        data.grid_origin = starting_pos + (x * data.x_magnitude, y * data.y_magnitude, -1 * (z * data.z_magnitude));
        break;
    }
  }
}

get_next_volume_origin() {
  data = debugdata();
  starting_pos = data.starting_pos;
  x = data.x;
  y = data.y;
  z = data.z;
  angles = data.box_angles;
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);
  _id_0E1F34EAF8AD4FD3 = forward * (x * data.x_magnitude);
  _id_331B7261E935F914 = right * (y * data.y_magnitude);
  _id_58A450B65FA15EB1 = up * (z * data.z_magnitude);

  switch (data.origin_counter) {
    case 0:
      data.grid_origin = starting_pos + _id_0E1F34EAF8AD4FD3 + _id_331B7261E935F914 + _id_58A450B65FA15EB1;
      break;
    case 1:
      data.grid_origin = starting_pos + -1 * _id_0E1F34EAF8AD4FD3 + _id_331B7261E935F914 + _id_58A450B65FA15EB1;
      break;
    case 2:
      data.grid_origin = starting_pos + -1 * _id_0E1F34EAF8AD4FD3 + -1 * _id_331B7261E935F914 + _id_58A450B65FA15EB1;
      break;
    case 3:
      data.grid_origin = starting_pos + -1 * _id_0E1F34EAF8AD4FD3 + _id_331B7261E935F914 + -1 * _id_58A450B65FA15EB1;
      break;
    case 4:
      data.grid_origin = starting_pos + -1 * _id_0E1F34EAF8AD4FD3 + -1 * _id_331B7261E935F914 + -1 * _id_58A450B65FA15EB1;
      break;
    case 5:
      data.grid_origin = starting_pos + _id_0E1F34EAF8AD4FD3 + -1 * _id_331B7261E935F914 + _id_58A450B65FA15EB1;
      break;
    case 6:
      data.grid_origin = starting_pos + _id_0E1F34EAF8AD4FD3 + -1 * _id_331B7261E935F914 + -1 * _id_58A450B65FA15EB1;
      break;
    case 7:
      data.grid_origin = starting_pos + _id_0E1F34EAF8AD4FD3 + _id_331B7261E935F914 + -1 * _id_58A450B65FA15EB1;
      break;
  }
}

vol_validate_grid_pos() {
  data = debugdata();
  _id_2984A3A7B3C051A7 = getclosestpointonnavmesh(data.grid_origin);

  if(distancesquared(_id_2984A3A7B3C051A7, data.grid_origin) <= data.max_nav_offset) {
    data.grid_origin = scripts\engine\utility::drop_to_ground(_id_2984A3A7B3C051A7, 96, -300);
    data.origin = data.grid_origin + (0, 0, 16);
    data.last_x = data.x;
    data.last_y = data.y;
    return 1;
  } else
    return 0;
}

validate_grid_pos() {
  data = debugdata();
  _id_2984A3A7B3C051A7 = getclosestpointonnavmesh(data.grid_origin);

  if(distancesquared(_id_2984A3A7B3C051A7, data.grid_origin) <= data.max_nav_offset) {
    data.grid_origin = scripts\engine\utility::drop_to_ground(_id_2984A3A7B3C051A7, 96, -300) + (0, 0, 16);
    data.origin = data.grid_origin;
    data.last_x = data.x;
    data.last_y = data.y;
    data.x_dir_fails = 0;
    data.y_dir_fails = 0;
    return 1;
  } else {
    data.dir_fails++;

    if(data.last_x != data.x)
      data.x_dir_fails++;

    if(data.last_y != data.y)
      data.y_dir_fails++;

    return 0;
  }
}

create_cover_nodes_from_single_grid_point() {
  data = debugdata();
  data.should_create_exposed_node = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= data.node_creation_traces; _id_AC0E594AC96AA3A8++) {
    data.node_creation_trace_index = _id_AC0E594AC96AA3A8;
    create_and_validate_node_from_single_grid_point();
  }
}

create_cover_nodes_from_grid_point() {
  data = debugdata();
  data.should_create_exposed_node = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= data.node_creation_traces; _id_AC0E594AC96AA3A8++) {
    data.node_creation_trace_index = _id_AC0E594AC96AA3A8;
    create_and_validate_node();
  }

  if(istrue(data.create_exposed_node) && istrue(data.should_create_exposed_node)) {
    _id_056DCF8813D0329E = scripts\engine\utility::drop_to_ground(data.grid_origin, 16, -300) + (0, 0, 16);
    data.origin = _id_056DCF8813D0329E;

    if(can_spawn_capsule_trace(_id_056DCF8813D0329E) && !trace_for_stairs()) {
      data.angles = (0, 0, 0);

      if(!similar_nodes_nearby()) {
        return;
      }
      data.node_type = "node_exposed";
      run_path_node_removal();
    }
  }
}

vol_create_and_validate_node() {
  data = debugdata();
  pos = data.grid_origin;
  angle = data.node_creation_angle_frac * data.node_creation_trace_index;
  _id_8A9F895755FD607E = cos(angle) * data.node_creation_trace_dist;
  _id_D867033AB311670B = sin(angle) * data.node_creation_trace_dist;
  x = pos[0] + _id_8A9F895755FD607E;
  y = pos[1] + _id_D867033AB311670B;
  z = pos[2];
  _id_55A01E81BDA4CC0C = (x, y, z);
  result = create_node_trace(pos, _id_55A01E81BDA4CC0C);

  if(isDefined(result["position"]) && isDefined(result["fraction"]) && result["fraction"] < 1) {
    data.should_create_exposed_node = 0;

    if(isDefined(result["normal"])) {
      _id_89E70A63B116955B = vectordot(result["normal"], (0, 0, 1));
      data.origin = result["position"];
      data.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(result["normal"])[1]), 0);

      if(-0.1 > _id_89E70A63B116955B || _id_89E70A63B116955B > 0.1)
        return;
    }

    _id_57FFE95645139612 = getclosestpointonnavmesh(result["position"]);

    if(distancesquared(result["position"], _id_57FFE95645139612) <= data.max_nav_offset) {
      data.should_create_exposed_node = 0;
      data.origin = scripts\engine\utility::drop_to_ground(_id_57FFE95645139612, 96, -300) + (0, 0, 16);
      data.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(result["normal"])[1]), 0);
      reposition_cover_node();
    }
  }
}

create_and_validate_node_from_single_grid_point() {
  data = debugdata();
  pos = data.grid_origin;
  angle = data.node_creation_angle_frac * data.node_creation_trace_index;
  _id_8A9F895755FD607E = cos(angle) * data.node_creation_trace_dist;
  _id_D867033AB311670B = sin(angle) * data.node_creation_trace_dist;
  x = pos[0] + _id_8A9F895755FD607E;
  y = pos[1] + _id_D867033AB311670B;
  z = pos[2];
  _id_55A01E81BDA4CC0C = (x, y, z);
  result = create_node_trace(pos, _id_55A01E81BDA4CC0C);

  if(isDefined(result["normal"])) {
    _id_89E70A63B116955B = vectordot(result["normal"], (0, 0, 1));

    if(-0.1 > _id_89E70A63B116955B || _id_89E70A63B116955B > 0.1)
      return;
  }

  _id_57FFE95645139612 = getclosestpointonnavmesh(result["position"]);

  if(distancesquared(result["position"], _id_57FFE95645139612) <= data.max_nav_offset) {
    data.should_create_exposed_node = 0;
    data.node_type = "script_struct";
    data.origin = scripts\engine\utility::drop_to_ground(_id_57FFE95645139612, 12, -300) + (0, 0, 16);
    data.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(result["normal"])[1]), 0);
    write_struct_to_map();
    data.total_grid_points++;
    reposition_cover_node();
  } else {
    data.node_type = "script_struct";
    data.angles = (0, 0, 0);
    data.origin = result["position"];
    write_struct_to_map();
  }
}

create_and_validate_node() {
  data = debugdata();
  pos = data.grid_origin;
  angle = data.node_creation_angle_frac * data.node_creation_trace_index;
  _id_8A9F895755FD607E = cos(angle) * data.node_creation_trace_dist;
  _id_D867033AB311670B = sin(angle) * data.node_creation_trace_dist;
  x = pos[0] + _id_8A9F895755FD607E;
  y = pos[1] + _id_D867033AB311670B;
  z = pos[2];
  _id_55A01E81BDA4CC0C = (x, y, z);
  result = create_node_trace(pos, _id_55A01E81BDA4CC0C);

  if(isDefined(result["position"]) && isDefined(result["fraction"]) && result["fraction"] < 1) {
    data.should_create_exposed_node = 0;

    if(isDefined(result["normal"])) {
      _id_89E70A63B116955B = vectordot(result["normal"], (0, 0, 1));

      if(-0.1 > _id_89E70A63B116955B || _id_89E70A63B116955B > 0.1)
        return;
    }

    _id_57FFE95645139612 = getclosestpointonnavmesh(result["position"]);

    if(distancesquared(result["position"], _id_57FFE95645139612) <= data.max_nav_offset) {
      data.origin = scripts\engine\utility::drop_to_ground(_id_57FFE95645139612, 12, -300) + (0, 0, 16);
      data.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(result["normal"])[1]), 0);
      reposition_cover_node();
    }
  }
}

create_node_trace(_id_D5685B7BAEE6505E, end_pos, _id_68103E2CA154153C) {
  data = debugdata();
  attempt_throttle();
  data.traces_count++;
  result = scripts\engine\trace::ray_trace(_id_D5685B7BAEE6505E, end_pos, level.players, data.trace_contents);

  if(data.save_trace_data) {
    if(isDefined(result["position"])) {
      if(!isDefined(_id_68103E2CA154153C))
        _id_68103E2CA154153C = (1, 1, 1);

      data.temp_trace_data[data.temp_trace_data.size] = result["position"];
      data.temp_trace_data_colors[data.temp_trace_data_colors.size] = _id_68103E2CA154153C;
      data.temp_trace_data[data.temp_trace_data.size] = end_pos;
      data.temp_trace_data_colors[data.temp_trace_data_colors.size] = (0, 0, 0);
    }
  }

  return scripts\engine\trace::ray_trace(_id_D5685B7BAEE6505E, end_pos, level.players, data.trace_contents);
}

debug_node_array(_id_FFB54732E70D0F73) {
  level notify("debug_node_array");
  level endon("debug_node_array");
  data = debugdata();

  for(;;) {
    level waittill("start_array_debug");

    if(isDefined(data.trace_data[getdvarint("dvar_D11A371F8F8DEC6E", 0)])) {
      trace_data = data.trace_data[getdvarint("dvar_D11A371F8F8DEC6E", 0)];

      foreach(_id_5A488C6BAE780ACF, item in trace_data) {
        color = data.trace_data_colors[getdvarint("dvar_D11A371F8F8DEC6E", 0)][_id_5A488C6BAE780ACF];
        level thread draw_line_until_endons(item, color[0], color[1], color[2], ["start_array_debug"]);

        if(_id_5A488C6BAE780ACF % 100)
          waitframe();
      }

      waitframe();
    }
  }
}

reposition_cover_node() {
  if(!similar_nodes_nearby()) {
    return;
  }
  level notify("reposition_cover_node");
  data = debugdata();
  starting_pos = data.origin;
  angles = data.angles;
  right = anglestoright(angles);
  left = anglestoleft(angles);
  forward = anglesToForward(angles);
  _id_7AE510CEC9CB4A40 = -1 * anglesToForward(angles);
  up = anglestoup(angles);
  _id_AED353BF3E91AE8E = [left, right];
  _id_7A196A18DB422FE4 = undefined;
  _id_0C2F92D971762713 = undefined;
  _id_F3633612B199E548 = undefined;
  data.found_left_edge = 0;
  data.found_right_edge = 0;
  data.found_up_edge = 0;
  data.found_exposed_pos = 0;
  data.wall_units = 0;
  data.temp_trace_data = [];
  data.found_valid_node_pos = 0;
  data.temp_trace_data_colors = [];

  if(getdvarint("dvar_7B41CE964C40BC15", 0)) {
    data.save_trace_data = 1;
    data.temp_trace_data[data.temp_trace_data.size] = starting_pos;
    data.temp_trace_data_colors[data.temp_trace_data_colors.size] = (1, 1, 1);
  }

  _id_9C68692868DCDD78 = data.valid_forward_dist;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    if(_id_AED353BF3E91AE8E.size < 1) {
      break;
    }

    for(z = 0; z < _id_AED353BF3E91AE8E.size; z++) {
      dir = _id_AED353BF3E91AE8E[z];
      _id_55A01E81BDA4CC0C = starting_pos + dir * (_id_AC0E594AC96AA3A8 * 32);

      if(!can_spawn_capsule_trace(_id_55A01E81BDA4CC0C)) {
        _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
        continue;
      }

      _id_8E77863E6E721A87 = create_node_trace(_id_55A01E81BDA4CC0C, _id_55A01E81BDA4CC0C + forward * _id_9C68692868DCDD78, (0, 1, 1));

      if(!trace_result_hits_surface(_id_8E77863E6E721A87)) {
        data.found_valid_node_pos = 0;

        for(_id_AC0E5C4AC96AAA41 = 1; _id_AC0E5C4AC96AAA41 < 32; _id_AC0E5C4AC96AAA41++) {
          _id_6F9764E576F43D0C = _id_55A01E81BDA4CC0C + -1 * dir * _id_AC0E5C4AC96AAA41;

          if(!can_spawn_capsule_trace(_id_6F9764E576F43D0C)) {
            _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
            continue;
          }

          result = create_node_trace(_id_6F9764E576F43D0C, _id_6F9764E576F43D0C + forward * 24, (0, 1, 1));

          if(trace_result_hits_surface(result)) {
            data.found_valid_node_pos = 1;
            data.should_create_exposed_node = 0;

            if(position_near_other_nodes(result["position"])) {
              _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
              break;
            }

            if(dir == left) {
              if(!data.found_left_edge && data.edge_placement) {
                if(edge_point_valid(_id_6F9764E576F43D0C, dir, forward)) {
                  data.found_left_edge = 1;
                  _id_7A196A18DB422FE4 = scripts\engine\utility::drop_to_ground(result["position"], 12, -300);
                  _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
                  break;
                } else {
                  _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
                  break;
                }
              }
            } else if(!data.found_right_edge && data.edge_placement) {
              if(edge_point_valid(_id_6F9764E576F43D0C, dir, forward)) {
                data.found_right_edge = 1;
                _id_0C2F92D971762713 = scripts\engine\utility::drop_to_ground(result["position"], 12, -300);
                _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
                continue;
              }

              _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
              break;
            }
          }
        }

        continue;
      }

      _id_7AD835478EBA0660 = create_node_trace(_id_8E77863E6E721A87["position"] + up * 28, _id_8E77863E6E721A87["position"] + forward * data.valid_forward_dist + up * 28, (1, 0, 1));

      if(!data.found_up_edge && !trace_result_hits_surface(_id_7AD835478EBA0660) && !position_near_other_nodes(_id_7AD835478EBA0660["position"]) && up_point_valid(_id_8E77863E6E721A87["position"] + -1 * forward, [left, right], forward, up)) {
        data.found_up_edge = 1;
        data.should_create_exposed_node = 0;
        _id_F3633612B199E548 = scripts\engine\utility::drop_to_ground(_id_8E77863E6E721A87["position"], 12, -300);
      }
    }
  }

  level notify("finished_reposition_node");

  if(isDefined(_id_7A196A18DB422FE4) && data.found_left_edge) {
    _id_056DCF8813D0329E = scripts\engine\utility::drop_to_ground(_id_7A196A18DB422FE4 + _id_7AE510CEC9CB4A40 * 17 + -1 * (left * 16), 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(_id_056DCF8813D0329E) && !trace_for_stairs()) {
      data.origin = _id_056DCF8813D0329E;
      _id_55A01E81BDA4CC0C = _id_056DCF8813D0329E + up * 24;
      result = create_node_trace(_id_55A01E81BDA4CC0C, _id_55A01E81BDA4CC0C + forward * data.valid_forward_dist, (1, 1, 0));

      if(trace_result_hits_surface(result))
        data.node_type = "node_cover_left";
      else
        data.node_type = "node_cover_crouch";

      run_path_node_removal();
    }
  }

  if(isDefined(_id_0C2F92D971762713) && data.found_right_edge) {
    _id_056DCF8813D0329E = scripts\engine\utility::drop_to_ground(_id_0C2F92D971762713 + _id_7AE510CEC9CB4A40 * 17 + -1 * (right * 16), 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(_id_056DCF8813D0329E) && !trace_for_stairs()) {
      data.origin = _id_056DCF8813D0329E;
      _id_55A01E81BDA4CC0C = _id_056DCF8813D0329E + up * 24;
      result = create_node_trace(_id_55A01E81BDA4CC0C, _id_55A01E81BDA4CC0C + forward * 64, (1, 1, 0));

      if(trace_result_hits_surface(result))
        data.node_type = "node_cover_right";
      else
        data.node_type = "node_cover_crouch";

      run_path_node_removal();
    }
  }

  if(isDefined(_id_F3633612B199E548) && data.found_up_edge && !data.found_right_edge && !data.found_left_edge) {
    _id_056DCF8813D0329E = scripts\engine\utility::drop_to_ground(_id_F3633612B199E548 + _id_7AE510CEC9CB4A40 * 17, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(_id_056DCF8813D0329E) && !trace_for_stairs()) {
      data.origin = _id_056DCF8813D0329E;
      data.node_type = "node_cover_crouch";
      run_path_node_removal();
    }
  }

  data.save_trace_data = 0;
}

simple_reposition_node() {
  if(!similar_nodes_nearby()) {
    return;
  }
  level notify("reposition_cover_node");
  data = debugdata();
  starting_pos = data.origin;
  angles = data.angles;
  right = anglestoright(angles);
  left = anglestoleft(angles);
  forward = anglesToForward(angles);
  _id_7AE510CEC9CB4A40 = -1 * anglesToForward(angles);
  up = anglestoup(angles);

  if(scripts\engine\utility::is_equal(data.node_type, "node_cover_left"))
    _id_AED353BF3E91AE8E = [left];
  else
    _id_AED353BF3E91AE8E = [right];

  _id_7A196A18DB422FE4 = undefined;
  _id_0C2F92D971762713 = undefined;
  _id_F3633612B199E548 = undefined;
  data.found_left_edge = 0;
  data.found_right_edge = 0;
  data.found_up_edge = 0;
  data.found_exposed_pos = 0;
  data.wall_units = 0;
  data.temp_trace_data = [];
  data.found_valid_node_pos = 0;
  data.temp_trace_data_colors = [];
  _id_9C68692868DCDD78 = data.valid_forward_dist;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    if(_id_AED353BF3E91AE8E.size < 1) {
      break;
    }

    for(z = 0; z < _id_AED353BF3E91AE8E.size; z++) {
      dir = _id_AED353BF3E91AE8E[z];
      _id_55A01E81BDA4CC0C = starting_pos + dir * (_id_AC0E594AC96AA3A8 * 32);

      if(!can_spawn_capsule_trace(_id_55A01E81BDA4CC0C)) {
        _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
        continue;
      }

      _id_8E77863E6E721A87 = create_node_trace(_id_55A01E81BDA4CC0C, _id_55A01E81BDA4CC0C + forward * _id_9C68692868DCDD78, (0, 1, 1));

      if(!trace_result_hits_surface(_id_8E77863E6E721A87)) {
        data.found_valid_node_pos = 0;

        for(_id_AC0E5C4AC96AAA41 = 1; _id_AC0E5C4AC96AAA41 < 32; _id_AC0E5C4AC96AAA41++) {
          _id_6F9764E576F43D0C = _id_55A01E81BDA4CC0C + -1 * dir * _id_AC0E5C4AC96AAA41;

          if(!can_spawn_capsule_trace(_id_6F9764E576F43D0C)) {
            _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
            continue;
          }

          result = create_node_trace(_id_6F9764E576F43D0C, _id_6F9764E576F43D0C + forward * 24, (0, 1, 1));

          if(trace_result_hits_surface(result)) {
            data.found_valid_node_pos = 1;
            data.should_create_exposed_node = 0;

            if(dir == left) {
              if(!data.found_left_edge && data.edge_placement) {
                if(edge_point_valid(_id_6F9764E576F43D0C, dir, forward)) {
                  data.found_left_edge = 1;
                  _id_7A196A18DB422FE4 = scripts\engine\utility::drop_to_ground(result["position"], 12, -300);
                  _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
                  break;
                } else {
                  _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
                  break;
                }
              }
            } else if(!data.found_right_edge && data.edge_placement) {
              if(edge_point_valid(_id_6F9764E576F43D0C, dir, forward)) {
                data.found_right_edge = 1;
                _id_0C2F92D971762713 = scripts\engine\utility::drop_to_ground(result["position"], 12, -300);
                _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
                continue;
              }

              _id_AED353BF3E91AE8E = scripts\engine\utility::array_remove(_id_AED353BF3E91AE8E, dir);
              break;
            }
          }
        }

        continue;
      }

      _id_7AD835478EBA0660 = create_node_trace(_id_8E77863E6E721A87["position"] + up * 28, _id_8E77863E6E721A87["position"] + forward * data.valid_forward_dist + up * 28, (1, 0, 1));

      if(!data.found_up_edge && !trace_result_hits_surface(_id_7AD835478EBA0660) && up_point_valid(_id_8E77863E6E721A87["position"] + -1 * forward, [left, right], forward, up)) {
        data.found_up_edge = 1;
        data.should_create_exposed_node = 0;
        _id_F3633612B199E548 = scripts\engine\utility::drop_to_ground(_id_8E77863E6E721A87["position"], 12, -300);
      }
    }
  }

  level notify("finished_reposition_node");

  if(isDefined(_id_7A196A18DB422FE4) && data.found_left_edge) {
    _id_056DCF8813D0329E = scripts\engine\utility::drop_to_ground(_id_7A196A18DB422FE4 + _id_7AE510CEC9CB4A40 * 17 + -1 * (left * 16), 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(_id_056DCF8813D0329E) && !trace_for_stairs()) {
      data.origin = _id_056DCF8813D0329E;
      _id_55A01E81BDA4CC0C = _id_056DCF8813D0329E + up * 24;
      result = create_node_trace(_id_55A01E81BDA4CC0C, _id_55A01E81BDA4CC0C + forward * data.valid_forward_dist, (1, 1, 0));

      if(trace_result_hits_surface(result))
        data.node_type = "node_cover_left";
      else
        data.node_type = "node_cover_crouch";

      run_path_node_removal();
    }
  }

  if(isDefined(_id_0C2F92D971762713) && data.found_right_edge) {
    _id_056DCF8813D0329E = scripts\engine\utility::drop_to_ground(_id_0C2F92D971762713 + _id_7AE510CEC9CB4A40 * 17 + -1 * (right * 16), 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(_id_056DCF8813D0329E) && !trace_for_stairs()) {
      data.origin = _id_056DCF8813D0329E;
      _id_55A01E81BDA4CC0C = _id_056DCF8813D0329E + up * 24;
      result = create_node_trace(_id_55A01E81BDA4CC0C, _id_55A01E81BDA4CC0C + forward * 64, (1, 1, 0));

      if(trace_result_hits_surface(result))
        data.node_type = "node_cover_right";
      else
        data.node_type = "node_cover_crouch";

      run_path_node_removal();
    }
  }

  if(isDefined(_id_F3633612B199E548) && data.found_up_edge && !data.found_right_edge && !data.found_left_edge) {
    _id_056DCF8813D0329E = scripts\engine\utility::drop_to_ground(_id_F3633612B199E548 + _id_7AE510CEC9CB4A40 * 17, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(_id_056DCF8813D0329E) && !trace_for_stairs()) {
      data.origin = _id_056DCF8813D0329E;
      data.node_type = "node_cover_crouch";
      run_path_node_removal();
    }
  }

  data.save_trace_data = 0;
}

find_final_position(pos) {}

trace_for_stairs() {
  return 0;
}

edge_point_valid(starting_pos, dir, forward) {
  data = debugdata();

  for(_id_AC0E594AC96AA3A8 = 32; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    _id_55A01E81BDA4CC0C = starting_pos + -1 * dir * _id_AC0E594AC96AA3A8;

    if(!can_spawn_capsule_trace(_id_55A01E81BDA4CC0C)) {
      break;
    }

    result = create_node_trace(_id_55A01E81BDA4CC0C, _id_55A01E81BDA4CC0C + forward * 24, (0, 1, 0));

    if(trace_result_hits_surface(result))
      data.wall_units++;
  }

  if(data.wall_units >= data.wall_units_required) {
    for(_id_AC0E5C4AC96AAA41 = 32; _id_AC0E5C4AC96AAA41 > 0; _id_AC0E5C4AC96AAA41--) {
      _id_55A01E81BDA4CC0C = starting_pos + dir * _id_AC0E5C4AC96AAA41;

      if(!can_spawn_capsule_trace(_id_55A01E81BDA4CC0C))
        return 0;

      result = create_node_trace(_id_55A01E81BDA4CC0C, _id_55A01E81BDA4CC0C + forward * data.valid_forward_dist, (0, 1, 0));

      if(trace_result_hits_surface(result))
        return 0;
    }

    return 1;
  } else
    return 0;
}

up_point_valid(starting_pos, _id_451B85725D725AC9, forward, up) {
  data = debugdata();
  _id_8E4D6CA7020FE22F = _id_451B85725D725AC9;

  for(_id_AC0E594AC96AA3A8 = 32; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_8E4D6CA7020FE22F.size; _id_AC0E5C4AC96AAA41++) {
      dir = _id_8E4D6CA7020FE22F[_id_AC0E5C4AC96AAA41];
      _id_55A01E81BDA4CC0C = starting_pos + -1 * dir * _id_AC0E594AC96AA3A8;
      result = create_node_trace(_id_55A01E81BDA4CC0C, _id_55A01E81BDA4CC0C + forward * 24, (0, 1, 0));

      if(!trace_result_hits_surface(result)) {
        data.wall_units++;

        if(data.wall_units >= data.wall_units_required) {
          break;
        }
      } else
        continue;
    }
  }

  _id_8E4D6CA7020FE22F = _id_451B85725D725AC9;
  data.wall_units = 0;

  for(_id_AC0E5C4AC96AAA41 = 32; _id_AC0E5C4AC96AAA41 > 0; _id_AC0E5C4AC96AAA41--) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8E4D6CA7020FE22F.size; _id_AC0E594AC96AA3A8++) {
      dir = _id_8E4D6CA7020FE22F[_id_AC0E594AC96AA3A8];
      _id_55A01E81BDA4CC0C = starting_pos + dir * _id_AC0E5C4AC96AAA41 + up * 28;
      result = create_node_trace(_id_55A01E81BDA4CC0C, _id_55A01E81BDA4CC0C + forward * data.valid_forward_dist, (0, 1, 0));

      if(trace_result_hits_surface(result))
        continue;
      else
        data.wall_units++;
    }
  }

  if(data.wall_units >= data.wall_units_required)
    return 1;
  else
    return 0;
}

attempt_throttle() {
  data = debugdata();
  data.throttle_counter++;

  if(data.throttle_counter >= data.create_node_throttle) {
    data.throttle_counter = 0;
    waitframe();
  }
}

trace_result_hits_surface(result, normal) {
  data = debugdata();

  if(isDefined(result["position"]) && isDefined(result["fraction"]) && result["fraction"] < 1 && result["fraction"] > 0) {
    if(isDefined(normal)) {
      if(isDefined(result["normal"])) {
        if(normal == result["normal"])
          return 1;
        else
          return 0;
      } else
        return 1;
    } else
      return 1;
  } else
    return 0;
}

open_and_write_to_paths_map() {
  data = debugdata();

  if(!scripts\engine\utility::flag("file_opened")) {
    scripts\engine\utility::flag_set("file_opened");
    data.aa_status = "adding_nodes_to_map";
    scripts\engine\utility:: fileprint_launcher_start_file();
      _id_E9B07E032ACA08A8 = "\t";
    _id_0834FE48575F4906 = 0;
    scripts\engine\utility:: fileprint_launcher( "iwmap 11" );
      scripts\engine\utility:: fileprint_launcher( _id_E9B07E032ACA08A8 + "entity " + _id_0834FE48575F4906 );
      scripts\engine\utility:: fileprint_launcher( "{" );
      scripts\engine\utility:: fileprint_launcher( _id_E9B07E032ACA08A8 + "\"classname\" \"worldspawn\"" );
      scripts\engine\utility:: fileprint_launcher( "}" );
  }
}

draw_closest_wall_points(player, _id_055F75D9F16D814F) {
  level endon("game_ended");
  level notify("draw_closest_wall_points");
  level endon("draw_closest_wall_points");
  player endon("use");
  player endon("disconnect");
  data = debugdata();

  for(;;) {
    player notify("reset_wall_lines");
    _id_0E36349C92F91E09 = scripts\engine\utility::get_array_of_closest(player.origin, _id_055F75D9F16D814F, undefined, 50);

    foreach(item in _id_0E36349C92F91E09) {}

    wait 1;
  }
}

run_path_node_removal() {
  level endon("game_ended");
  level endon("get_nav_start_points");
  data = debugdata();

  if(!position_near_other_nodes(data.origin)) {
    struct = spawnStruct();
    struct.angles = data.angles;
    struct.origin = data.origin;
    data.all_node_positions[data.all_node_positions.size] = struct;

    if(getdvarint("dvar_7B41CE964C40BC15", 0)) {
      data.trace_data[data.map_ent_index] = data.temp_trace_data;
      data.trace_data_colors[data.map_ent_index] = data.temp_trace_data_colors;
    }

    data.should_create_exposed_node = 0;
    write_struct_to_map();

    if(istrue(data.debug_boxes))
      return;
  }
}

position_near_other_nodes(position) {
  data = debugdata();
  data.density_cap_count = 0;

  if(data.use_bsp_nodes) {
    _id_C6736586AE30F7EA = getallnodes();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C6736586AE30F7EA.size; _id_AC0E594AC96AA3A8++) {
      _id_87448CC476173066 = _id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8];

      if(_id_87448CC476173066.origin == position)
        return 1;

      _id_45F9A855D9BAAA6B = distancesquared(position, _id_87448CC476173066.origin);

      if(_id_45F9A855D9BAAA6B <= 576)
        return 1;
    }
  }

  _id_6D906809844C7CB1 = data.all_node_positions;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6D906809844C7CB1.size; _id_AC0E594AC96AA3A8++) {
    _id_E93ABDCF64B7D8EF = _id_6D906809844C7CB1[_id_AC0E594AC96AA3A8];

    if(_id_E93ABDCF64B7D8EF.origin == position)
      return 1;

    _id_45F9A855D9BAAA6B = distancesquared(position, _id_E93ABDCF64B7D8EF.origin);

    if(_id_45F9A855D9BAAA6B <= 256)
      return 1;

    if(_id_45F9A855D9BAAA6B <= data.density_radius) {
      data.density_cap_count++;

      if(data.density_cap_count >= data.density_cap)
        return 1;
    }
  }

  return 0;
}

write_struct_to_map() {
  data = debugdata();
  _id_E9B07E032ACA08A8 = "\t";
  scripts\engine\utility:: fileprint_launcher( "entity " + data.map_ent_index );
    scripts\engine\utility:: fileprint_launcher( "{" );
    scripts\engine\utility:: fileprint_launcher( _id_E9B07E032ACA08A8 + "\"origin\" \"" + data.origin[0] + " " + data.origin[1] + " " + data.origin[2] + "\"" );

    if(isDefined(data.node_type))
      scripts\engine\utility:: fileprint_launcher( _id_E9B07E032ACA08A8 + "\"classname\" \"" + data.node_type + "\"" );
      else
        scripts\engine\utility:: fileprint_launcher( _id_E9B07E032ACA08A8 + "\"classname\" \"node_cover_left\"" );

        if(isDefined(data.angles))
          scripts\engine\utility:: fileprint_launcher( _id_E9B07E032ACA08A8 + "\"angles\" \"" + data.angles[0] + " " + data.angles[1] + " " + data.angles[2] + "\"" );
          else
            scripts\engine\utility:: fileprint_launcher( _id_E9B07E032ACA08A8 + "\"angles\" \"0 0 0\"" );

            scripts\engine\utility:: fileprint_launcher( "}" );
            data.map_ent_index++;
}

draw_line_until_endons(_id_6C12713F33727294, r, g, b, _id_0618807E8CD83EF8) {
  self endon("death");
  data = debugdata();

  if(isDefined(_id_0618807E8CD83EF8)) {
    if(isarray(_id_0618807E8CD83EF8)) {
      foreach(_id_AAE9816CBF26FA0E in _id_0618807E8CD83EF8)
      self endon(_id_AAE9816CBF26FA0E);
    } else
      self endon(_id_0618807E8CD83EF8);
  }

  for(;;)
    waitframe();
}

addentrytodevgui(_id_10D8148F3496F8DE) {
  level thread addentrytodevgui_internal(_id_10D8148F3496F8DE);
}

addentrytodevgui_internal(_id_10D8148F3496F8DE) {
  level endon("game_ended");
  wait 5;
  _id_94899EE0671E1C5D = "";
  _id_F077ADF688122C36 = strtok(_id_10D8148F3496F8DE, "/");
  space = " ";
  _id_295AB3A52EFB020F = 0;

  foreach(_id_E97377032A878881 in _id_F077ADF688122C36) {
    _id_AF9C9DF381F94999 = strtok(_id_E97377032A878881, " ");
    count = 1;
    _id_A61C75B156FC1EE0 = _id_AF9C9DF381F94999.size;

    foreach(_id_1A598A8191BCB170 in _id_AF9C9DF381F94999) {
      if(count < _id_A61C75B156FC1EE0)
        _id_94899EE0671E1C5D = _id_94899EE0671E1C5D + _id_1A598A8191BCB170 + space;
      else
        _id_94899EE0671E1C5D = _id_94899EE0671E1C5D + _id_1A598A8191BCB170;

      count++;
    }

    _id_295AB3A52EFB020F++;

    if(_id_295AB3A52EFB020F < _id_F077ADF688122C36.size)
      _id_94899EE0671E1C5D = _id_94899EE0671E1C5D + "/";
  }
}

can_spawn_capsule_trace(pos) {
  return scripts\engine\trace::capsule_trace_passed(pos + (0, 0, 32), pos, 16, 32);
}