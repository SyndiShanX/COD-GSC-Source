/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\create_cover_nodes.gsc
*************************************************/

function create_cover_node_init() {
  level endon("game_ended");
  initialize_path_node_placement();
  scripts\engine\utility::flag_init("file_opened");
}

function initialize_path_node_placement() {
  var_0 = spawnStruct();
  var_0.trace_contents = scripts\engine\trace::create_solid_ai_contents(1);
  var_0.all_node_positions = [];
  var_0.map_ent_index = 1;
  level.path_node_debug_info = var_0;
  reset_path_node_placement();
  return level.path_node_debug_info;
}

function reset_path_node_placement_for_radius() {
  var_0 = reset_path_node_placement();
  var_0.x_magnitude = 32;
  var_0.y_magnitude = 32;
  var_0.max_x = 20;
  var_0.max_y = 20;
  level.path_node_debug_info = var_0;
  return level.path_node_debug_info;
}

function reset_path_node_placement_for_lookat() {
  var_0 = reset_path_node_placement();
  var_0.debug_boxes = 1;
  var_0.node_creation_traces = 32;
  var_0.delayed_creation_calls = 0;
  var_0.create_node_throttle = 500;
  level.path_node_debug_info = var_0;
  return level.path_node_debug_info;
}

function reset_path_node_placement_for_box_creation() {
  var_0 = reset_path_node_placement();
  var_0.debug_boxes = 1;
  var_0.debug_boxes_max_count = 50;
  var_0.debug_boxes_count = 0;
  var_0.valid_forward_dist = 64;
  var_0.x_magnitude = 256;
  var_0.y_magnitude = 256;
  var_0.z_magnitude = 128;
  var_0.max_nav_offset = 4096;
  var_0.create_node_throttle = 5000;
  var_0.max_x = undefined;
  var_0.max_y = undefined;
  var_0.max_z = undefined;
  level.path_node_debug_info = var_0;
  return level.path_node_debug_info;
}

function reset_path_node_placement() {
  var_0 = level.path_node_debug_info;
  var_0.total_grid_points = 0;
  var_0.start_time = gettime();
  var_0.end_time = gettime();
  var_0.total_time = gettime();
  var_0.box_x = 1024;
  var_0.box_y = 1024;
  var_0.box_z = 512;
  var_0.box_x_min = 512;
  var_0.box_y_min = 512;
  var_0.box_z_min = 128;
  var_0.increase_x = 1;
  var_0.increase_y = 1;
  var_0.increase_z = 1;
  var_0.box_center = (0, 0, 0);
  var_0.box_angles = (0, 0, 0);
  var_0.freeze_location = 0;
  var_0.box_disabled = 0;
  var_0.x_done = 0;
  var_0.y_done = 0;
  var_0.z_done = 0;
  var_0.auto_write_to_map = 1;
  var_0.use_bsp_nodes = getdvarint("scr_use_bsp_nodes", 1);
  var_0.debug_boxes = getdvarint("scr_draw_nodes", 0);
  var_0.edge_placement = 1;
  var_0.file_path = level.script + "_script_paths.map";
  var_0.node_creation_traces = 16;
  var_0.node_creation_trace_index = 0;
  var_0.node_creation_trace_dist = 365;
  var_0.node_creation_angle_frac = 360 / var_0.node_creation_traces;
  var_0.aa_status = "waiting";
  var_0.create_node_throttle = 5000;
  var_0.throttle_counter = 0;
  var_0.traces_count = 0;
  var_0.x_magnitude = 256;
  var_0.y_magnitude = 256;
  var_0.z_magnitude = 64;
  var_0.max_nav_offset = 16384;
  var_0.valid_forward_dist = 64;
  var_0.current_forward_dist = undefined;
  var_0.x = 1;
  var_0.y = 1;
  var_0.z = 1;
  var_0.max_x = undefined;
  var_0.max_y = undefined;
  var_0.last_x = 1;
  var_0.last_y = 1;
  var_0.x_dir_fails = 0;
  var_0.y_dir_fails = 0;
  var_0.dir_fails = 0;
  var_0.max_dir_fails = 500;
  var_0.total_z_planes = 5;
  var_0.origin_counter = 0;
  var_0.origin_max_dirs = 8;
  var_0.dir_valid[0] = 1;
  var_0.dir_valid[1] = 1;
  var_0.dir_valid[2] = 1;
  var_0.dir_valid[3] = 1;
  var_0.dir_valid[4] = 1;
  var_0.dir_valid[5] = 1;
  var_0.dir_valid[6] = 1;
  var_0.dir_valid[7] = 1;
  var_0.grid_points_found = 1;
  var_0.wall_units = 0;
  var_0.wall_units_required = 32;
  var_0.found_left_edge = 0;
  var_0.found_right_edge = 0;
  var_0.found_up_edge = 0;
  var_0.found_exposed_pos = 0;
  var_0.use_trace_data = getdvarint("scr_save_trace_data", 0);
  var_0.save_trace_data = 0;
  var_0.temp_trace_data = [];
  var_0.temp_trace_data_colors = [];
  var_0.trace_data = [];
  var_0.trace_data_colors = [];
  var_0.grid_origin = (0, 0, 0);
  var_0.density_radius = 64;
  var_0.density_cap = 4;
  var_0.density_cap_count = 0;
  var_0.found_valid_node_pos = 0;
  var_0.create_exposed_node = getdvarint("scr_create_exposed_nodes", 0);
  var_0.should_create_exposed_node = 1;
  level.path_node_debug_info = var_0;
  level.increase_y = var_0;
  level.num_fails = 0;
  return level.path_node_debug_info;
}

function debugdata() {
  return level.path_node_debug_info;
}

function run_single_grid_point_test(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  level endon("stop_creating_nodes");
  reset_path_node_placement_for_box_creation();
  var_1 = debugdata();
  var_1.player = var_0;
  open_and_write_to_paths_map();
  var_0 notifyonplayercommand("use", "+usereload");
  var_0 notifyonplayercommand("use", "+activate");

  for(;;) {
    var_0 waittill("use");
    thread delay_node_creation_from_single_point();
  }
}

function place_path_node_from_lookat(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  level endon("stop_creating_nodes");
  reset_path_node_placement_for_lookat();
  var_1 = debugdata();
  var_1.player = var_0;
  open_and_write_to_paths_map();
  var_0 notifyonplayercommand("use", "+usereload");
  var_0 notifyonplayercommand("use", "+activate");
  var_0 waittill("use");
  GscBinSkip4(0x6e, var_1);
}

function delay_node_creation_from_single_point() {
  var_0 = debugdata();
  var_1 = var_0.player;
  open_and_write_to_paths_map();
  var_0.starting_pos = var_1.origin;
  var_2 = anglesToForward(var_1 getplayerangles());
  var_3 = create_node_trace(var_0.player getEye(), var_0.player getEye() + var_2 * 10000);

  if(isDefined(var_3["position"]) && isDefined(var_3["fraction"]) && var_3["fraction"] < 1) {
    var_4 = scripts\engine\utility::drop_to_ground(var_3["position"] + -1 * var_2 * 32, 96, -300) + (0, 0, 16);
    var_0.x = var_4[0];
    var_0.y = var_4[1];
    var_0.z = var_4[2];
    var_0.origin = var_4;
    var_0.grid_origin = var_4;

    if(validate_grid_pos()) {
      var_0.node_type = "script_struct";
      var_0.total_grid_points++;
      var_0.angles = (0, 0, 0);
      write_struct_to_map();
      var_0.classname = "node_exposed";
      create_and_validate_node_from_single_grid_point();
      return;
    }

    return;
  }
}

function delay_node_creation_from_look_at() {
  var_0 = debugdata();
  var_1 = var_0.player;
  open_and_write_to_paths_map();
  var_0.starting_pos = var_1.origin;
  var_2 = anglesToForward(var_1 getplayerangles());
  var_3 = create_node_trace(var_0.player getEye(), var_0.player getEye() + var_2 * 10000);

  if(isDefined(var_3["position"]) && isDefined(var_3["fraction"]) && var_3["fraction"] < 1) {
    var_4 = scripts\engine\utility::drop_to_ground(var_3["position"] + -1 * var_2 * 32, 24, -300) + (0, 0, 16);
    var_0.x = var_4[0];
    var_0.y = var_4[1];
    var_0.z = var_4[2];
    var_0.origin = var_4;
    var_0.grid_origin = var_4;

    if(validate_grid_pos()) {
      var_0.angles = (0, 0, 0);
      var_0.classname = "node_exposed";
      create_cover_nodes_from_grid_point();
      return;
    }

    return;
  }
}

function place_path_nodes_within_box(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  level endon("stop_creating_nodes");
  var_1 = debugdata();
  var_1.player = var_0;
  var_0 notifyonplayercommand("use", "+usereload");
  var_0 notifyonplayercommand("use", "+activate");
  reset_path_node_placement_for_box_creation();
  GscBinSkip4(0x6e, var_1);
}

function create_and_update_box() {
  var_0 = debugdata();
  var_0.player notifyonplayercommand("up", "+actionslot 1");
  var_0.player notifyonplayercommand("down", "+actionslot 2");
  var_0.player notifyonplayercommand("right", "+actionslot 4");
  var_0.player notifyonplayercommand("rb", "+frag");
  var_0.player notifyonplayercommand("lb", "+smoke");
  var_0.player notifyonplayercommand("a", "+gostand");
  var_0.player notifyonplayercommand("left", "+actionslot 3");
  var_0.player notifyonplayercommand("dpad_left_release", "-actionslot 3");
  var_0.player notifyonplayercommand("dpad_left_press", "+actionslot 3");
  GscBinSkip4(0x6e, var_0);
}

function show_running_tool_message() {
  self endon("stop_showing_message");
  var_0 = 0;

  for(;;) {
    var_1 = 500;
    var_2 = "Creating Nodes | Time Elapsed: " + var_0;
    waitframe();
    var_0 += 0.05;
  }
}

function create_box() {
  var_0 = debugdata();
  var_1 = var_0.player;
  var_2 = var_1.origin + anglesToForward(var_1.angles) * 500;
  var_3 = var_1.angles;
  var_4 = var_2;
  var_5 = var_3;

  for(;;) {
    if(var_0.box_disabled) {
      wait 1;
      continue;
    }

    var_6 = 150;

    if(getdvarint("scr_cs_box_x", 0) != 0) {
      var_0.box_x = getdvarint("scr_cs_box_x", 0);
      var_7 = "X: " + var_0.box_x;
    } else {
      var_7 = "X: " + var_0.box_x;
    }

    var_6 += 25;

    if(getdvarint("scr_cs_box_y", 0) != 0) {
      var_0.box_x = getdvarint("scr_cs_box_y", 0);
      var_7 = "Y: " + var_0.box_y;
    } else {
      var_7 = "Y: " + var_0.box_y;
    }

    var_6 += 25;

    if(getdvarint("scr_cs_box_z", 0) != 0) {
      var_0.box_x = getdvarint("scr_cs_box_z", 0);
      var_7 = "Z: " + var_0.box_z;
    } else {
      var_7 = "Z: " + var_0.box_z;
    }

    var_6 += 25;
    var_7 = "Location Locked: " + var_0.freeze_location;
    var_6 += 25;

    if(var_0.freeze_location) {
      var_2 = var_4;
      var_3 = var_5;
    } else {
      var_2 = var_1.origin + anglesToForward(var_1.angles) * 500;
      var_3 = var_1.angles;
    }

    var_4 = var_2;
    var_5 = var_3;
    var_0.box_center = var_2;
    var_0.box_angles = var_3;
    waitframe();
  }
}

function place_path_nodes_within_radius(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  level endon("stop_creating_nodes");
  var_1 = debugdata();
  var_1.player = var_0;
  var_0 notifyonplayercommand("use", "+usereload");
  var_0 notifyonplayercommand("use", "+activate");

  for(;;) {
    reset_path_node_placement_for_radius();
    var_0 waittill("use");
    open_and_write_to_paths_map();
    var_1.starting_pos = var_0.origin;
    create_cover_nodes_from_grid_points();
  }
}

function place_path_nodes(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = debugdata();
  var_1.player = var_0;
  var_1.starting_pos = var_0.origin;
  reset_path_node_placement();
  open_and_write_to_paths_map();
  var_1.aa_status = "starting";
  GscBinSkip4(0x6e, var_1);
}

function clean_up_nodes() {
  level endon("game_ended");
  level endon("stop_creating_nodes");
  var_0 = debugdata();
  reset_path_node_placement();
  open_and_write_to_paths_map();
  var_0.aa_status = "starting";
  var_0.use_bsp_nodes = 0;
  var_0.file_path = level.script + "_script_paths_clean.map";
  GscBinSkip4(0x6e, var_0);
}

function translate_position_with_offset_data(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = (0, 0, 0);
  }

  if(isDefined(self.angles)) {
    var_3 = self.angles;
  } else {
    var_3 = (0, 0, 0);
  }

  var_4 = self.origin;
  var_5 = anglesToForward(var_3);
  self.origin = var_2 + rotatevector(var_4, var_3);
  var_6 = vectortoangles(rotatevector(var_5, var_3));
  self.angles = var_6;
}

function node_passes_nav_and_geo_validation(var_0) {
  var_1 = debugdata();

  if(distancesquared(getclosestpointonnavmesh(var_1.origin), var_1.origin) >= 1024) {
    return 0;
  }

  if(!can_spawn_capsule_trace(var_1.origin)) {
    return 0;
  }

  if(!istrue(var_0)) {
    var_2 = getnodesinradius(var_1.origin, 16, 0, 64);

    if(var_2.size < 1) {
      return 1;
    }

    return 0;
  }

  return 1;
}

function remove_similar_nodes(var_0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var_0 endon("disconnect");
  level endon("stop_creating_nodes");
  var_1 = 100;
  var_2 = getdvarint("scr_cover_node_clean_radius");

  if(var_2 != 0) {
    var_1 = var_2;
  }

  var_3 = var_1 * var_1;
  var_4 = debugdata();
  var_4.player = var_0;
  reset_path_node_placement();
  open_and_write_to_paths_map();
  var_4.aa_status = "starting";
  var_5 = getallnodes();

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6];

    if(isDefined(var_7)) {
      var_8 = 0;

      for(var_9 = 0; var_9 < var_5.size; var_9++) {
        var_10 = var_5[var_9];

        if(!isDefined(var_10)) {
          continue;
        }

        if(var_10.origin == var_7.origin) {
          continue;
        }

        var_11 = var_7.origin;
        var_12 = distancesquared(var_11, var_10.origin);

        if(var_12 <= var_3) {
          if(var_7.type == var_10.type) {
            if(var_7.angles == var_10.angles) {
              var_8 = 1;
              break;
            }
          }
        }
      }

      if(!var_8) {
        var_4.node_type = get_node_type_from_type(var_7);

        if(isDefined(var_4.node_type)) {
          var_4.origin = var_7.origin;
          var_4.angles = var_7.angles;
          write_struct_to_map();
        } else {
          var_5[var_6] = undefined;
        }
      } else {
        var_5[var_6] = undefined;
      }
    }
  }

  thread close_map_write();
}

function similar_nodes_nearby() {
  var_0 = debugdata();
  var_1 = 100;
  var_2 = var_1 * var_1;

  if(var_0.use_bsp_nodes) {
    var_3 = getallnodes();

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = var_3[var_4];

      if(isDefined(var_5)) {
        if(var_0.origin == var_5.origin) {
          return false;
        }

        var_6 = distancesquared(var_5.origin, var_0.origin);

        if(var_6 <= var_2) {
          if(var_5.angles == var_0.angles) {
            return false;
          }
        }
      }
    }
  }

  var_3 = level.path_node_debug_info.all_node_positions;

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(isDefined(var_5)) {
      if(var_0.origin == var_5.origin) {
        return false;
      }

      var_6 = distancesquared(var_0.origin, var_5.origin);

      if(var_6 <= var_2) {
        if(var_5.angles == var_0.angles) {
          return false;
        }
      }
    }
  }

  return true;
}

function get_node_type_from_type(var_0) {
  switch (var_0.type) {
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

function get_raw_or_devraw_subdir() {
  return "raw";
}

function get_gamemode_subdir() {
  return "cp";
}

function close_map_write() {
  var_0 = debugdata();

  if(scripts\engine\utility::flag("file_opened")) {
    scripts\engine\utility::flag_clear("file_opened");
    var_1 = var_0.file_path;
    var_2 = get_raw_or_devraw_subdir();
    var_3 = get_gamemode_subdir();
    var_4 = "/map_source/" + var_1;
    var_5 = 1;
    scripts\engine\utility:: fileprint_launcher_end_file( var_4, var_5 );
      level notify("stop_creating_nodes");
  }

  if(getdvarint("scr_save_trace_data", 0)) {
    thread debug_node_array(level);
    return;
  }
}

function create_cover_nodes_within_volume() {
  level endon("game_ended");
  var_0 = debugdata();
  var_0.aa_status = "creating_cover_node_positions";
  var_0.grid_points_found = 1;
  var_0.increase_y = 1;

  while(var_0.grid_points_found) {
    var_0.num_fails = 0;

    for(var_1 = 0; var_1 < var_0.origin_max_dirs; var_1++) {
      var_0.origin_counter = var_1;
      get_next_volume_origin();

      if(vol_validate_grid_pos()) {
        var_0.angles = (0, 0, 0);
        var_0.node_type = "script_struct";
        var_0.origin = var_0.grid_origin;
        var_0.classname = "node_exposed";
        vol_create_cover_nodes_from_grid_point();
      }
    }

    create_grid_point_in_volume();
  }

  iprintlnbold("Create Node Completed " + var_0.all_node_positions.size + " Created.");
}

function vol_create_cover_nodes_from_grid_point() {
  var_0 = debugdata();
  var_0.should_create_exposed_node = 1;

  for(var_1 = 0; var_1 <= var_0.node_creation_traces; var_1++) {
    var_0.node_creation_trace_index = var_1;
    vol_create_and_validate_node();
  }

  if(istrue(var_0.create_exposed_node) && istrue(var_0.should_create_exposed_node)) {
    var_2 = scripts\engine\utility::drop_to_ground(var_0.grid_origin, 16, -300) + (0, 0, 16);
    var_0.origin = var_2;

    if(can_spawn_capsule_trace(var_2) && !trace_for_stairs()) {
      var_0.angles = (0, 0, 0);

      if(!similar_nodes_nearby()) {
        return;
      }

      var_0.node_type = "node_exposed";
      run_path_node_removal();
      return;
    }

    return;
  }
}

function create_cover_nodes_from_grid_points() {
  level endon("game_ended");
  level endon("end_grid_creation");
  var_0 = debugdata();
  var_0.aa_status = "creating_cover_node_positions";
  var_0.grid_points_found = 1;
  var_0.increase_y = 1;

  while(var_0.grid_points_found) {
    var_0.num_fails = 0;
    create_grid_point();

    for(var_1 = 0; var_1 < var_0.origin_max_dirs; var_1++) {
      var_0.origin_counter = var_1;

      for(var_2 = 0; var_2 < var_0.total_z_planes; var_2++) {
        var_0.z = var_2;
        get_next_origin();

        if(validate_grid_pos()) {
          var_0.angles = (0, 0, 0);
          var_0.classname = "node_exposed";
          create_cover_nodes_from_grid_point();
        }
      }
    }
  }

  iprintlnbold("Create Node Completed " + var_0.all_node_positions.size + " Created.");
}

function create_grid_point_in_volume() {
  var_0 = debugdata();

  if(var_0.increase_x) {
    vol_increase_x_coordinate();
  } else if(var_0.increase_y) {
    var_0.increase_x = 1;
    var_0.x = 0;
    vol_increase_y_coordinate();
  } else {
    var_0.increase_x = 1;
    var_0.increase_y = 1;
    var_0.x = 0;
    var_0.y = 0;
    vol_increase_z_coordinate();
  }

  if(var_0.x_done && var_0.y_done && var_0.z_done) {
    var_0.grid_points_found = 0;
    level notify("end_grid_creation");
    return;
  }
}

function create_grid_point() {
  var_0 = debugdata();
  var_1 = 0;

  if(!increase_y_coordinate()) {
    var_1++;

    if(increase_x_coordinate()) {
      var_0.y = 1;
    } else {
      var_1++;
    }
  }

  if(var_1 >= 2) {
    var_0.grid_points_found = 0;
    level notify("end_grid_creation");
    return;
  }
}

function create_grid_point_new() {
  var_0 = debugdata();

  if(var_0.dir_fails >= var_0.max_dir_fails) {
    var_0.grid_points_found = 0;
    level notify("end_grid_creation");
    return;
  }

  var_1 = 0;

  if(isDefined(var_0.max_y)) {
    if(var_0.y > var_0.max_y) {
      var_1++;
    }
  }

  if(isDefined(var_0.max_x)) {
    if(var_0.x > var_0.max_x) {
      var_1++;
    }
  }

  if(var_1 >= 2) {
    var_0.grid_points_found = 0;
    level notify("end_grid_creation");
    return;
  }

  if(var_0.increase_y) {
    increase_y_coordinate_new();
    var_0.increase_y = 0;
    return;
  }

  increase_x_coordinate_new();
  var_0.increase_y = 1;
}

function increase_y_coordinate_new() {
  var_0 = debugdata();

  if(isDefined(var_0.max_y)) {
    if(var_0.y < var_0.max_y) {
      var_0.y++;
      return 1;
    }

    return 0;
  }

  var_0.y++;
  return 1;
}

function increase_x_coordinate_new() {
  var_0 = debugdata();

  if(isDefined(var_0.max_x)) {
    if(var_0.x < var_0.max_x) {
      var_0.x++;
      return 1;
    }

    return 0;
  }

  var_0.x++;
  return 1;
}

function increase_x_coordinate() {
  var_0 = debugdata();

  if(var_0.x_dir_fails <= var_0.max_dir_fails) {
    if(isDefined(var_0.max_x)) {
      if(var_0.x < var_0.max_x) {
        var_0.x++;
        return 1;
      }

      return 0;
    }

    var_0.x++;
    return 1;
  }

  return 0;
}

function vol_increase_x_coordinate() {
  var_0 = debugdata();

  if(isDefined(var_0.max_x)) {
    if(var_0.x < var_0.max_x) {
      var_0.x++;
      return 1;
    }

    var_0.increase_x = 0;
    var_0.x_done = 1;
    return 0;
  }

  var_0.x++;
  return 1;
}

function increase_y_coordinate() {
  var_0 = debugdata();

  if(var_0.y_dir_fails <= var_0.max_dir_fails) {
    if(isDefined(var_0.max_y)) {
      if(var_0.y < var_0.max_y) {
        var_0.y++;
        return 1;
      }

      return 0;
    }

    var_0.y++;
    return 1;
  }

  return 0;
}

function vol_increase_y_coordinate() {
  var_0 = debugdata();

  if(isDefined(var_0.max_y)) {
    if(var_0.y < var_0.max_y) {
      var_0.y++;
      return 1;
    }

    var_0.increase_y = 0;
    var_0.y_done = 1;
    return 0;
  }

  var_0.y++;
  return 1;
}

function vol_increase_z_coordinate() {
  var_0 = debugdata();

  if(isDefined(var_0.max_z)) {
    if(var_0.z < var_0.max_z) {
      var_0.z++;
      return 1;
    }

    var_0.z_done = 1;
    return 0;
  }

  var_0.z++;
  return 1;
}

function get_next_origin() {
  var_0 = debugdata();
  var_1 = var_0.starting_pos;
  var_2 = var_0.x;
  var_3 = var_0.y;
  var_4 = var_0.z;

  if(var_0.dir_valid[var_0.origin_counter]) {
    switch (var_0.origin_counter) {
      case 0:
        var_0.grid_origin = var_1 + (var_2 * var_0.x_magnitude, var_3 * var_0.y_magnitude, var_4 * var_0.z_magnitude);
        break;
      case 1:
        var_0.grid_origin = var_1 + (-1 * var_2 * var_0.x_magnitude, var_3 * var_0.y_magnitude, var_4 * var_0.z_magnitude);
        break;
      case 2:
        var_0.grid_origin = var_1 + (-1 * var_2 * var_0.x_magnitude, -1 * var_3 * var_0.y_magnitude, var_4 * var_0.z_magnitude);
        break;
      case 3:
        var_0.grid_origin = var_1 + (-1 * var_2 * var_0.x_magnitude, var_3 * var_0.y_magnitude, -1 * var_4 * var_0.z_magnitude);
        break;
      case 4:
        var_0.grid_origin = var_1 + (-1 * var_2 * var_0.x_magnitude, -1 * var_3 * var_0.y_magnitude, -1 * var_4 * var_0.z_magnitude);
        break;
      case 5:
        var_0.grid_origin = var_1 + (var_2 * var_0.x_magnitude, -1 * var_3 * var_0.y_magnitude, var_4 * var_0.z_magnitude);
        break;
      case 6:
        var_0.grid_origin = var_1 + (var_2 * var_0.x_magnitude, -1 * var_3 * var_0.y_magnitude, -1 * var_4 * var_0.z_magnitude);
        break;
      case 7:
        var_0.grid_origin = var_1 + (var_2 * var_0.x_magnitude, var_3 * var_0.y_magnitude, -1 * var_4 * var_0.z_magnitude);
        break;
    }

    return;
  }
}

function get_next_volume_origin() {
  var_0 = debugdata();
  var_1 = var_0.starting_pos;
  var_2 = var_0.x;
  var_3 = var_0.y;
  var_4 = var_0.z;
  var_5 = var_0.box_angles;
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = anglestoup(var_5);
  var_9 = var_6 * var_2 * var_0.x_magnitude;
  var_10 = var_7 * var_3 * var_0.y_magnitude;
  var_11 = var_8 * var_4 * var_0.z_magnitude;

  switch (var_0.origin_counter) {
    case 0:
      var_0.grid_origin = var_1 + var_9 + var_10 + var_11;
      break;
    case 1:
      var_0.grid_origin = var_1 + -1 * var_9 + var_10 + var_11;
      break;
    case 2:
      var_0.grid_origin = var_1 + -1 * var_9 + -1 * var_10 + var_11;
      break;
    case 3:
      var_0.grid_origin = var_1 + -1 * var_9 + var_10 + -1 * var_11;
      break;
    case 4:
      var_0.grid_origin = var_1 + -1 * var_9 + -1 * var_10 + -1 * var_11;
      break;
    case 5:
      var_0.grid_origin = var_1 + var_9 + -1 * var_10 + var_11;
      break;
    case 6:
      var_0.grid_origin = var_1 + var_9 + -1 * var_10 + -1 * var_11;
      break;
    case 7:
      var_0.grid_origin = var_1 + var_9 + var_10 + -1 * var_11;
      break;
  }
}

function vol_validate_grid_pos() {
  var_0 = debugdata();
  var_1 = getclosestpointonnavmesh(var_0.grid_origin);

  if(distancesquared(var_1, var_0.grid_origin) <= var_0.max_nav_offset) {
    var_0.grid_origin = scripts\engine\utility::drop_to_ground(var_1, 96, -300);
    var_0.origin = var_0.grid_origin + (0, 0, 16);
    var_0.last_x = var_0.x;
    var_0.last_y = var_0.y;
    return 1;
  }

  return 0;
}

function validate_grid_pos() {
  var_0 = debugdata();
  var_1 = getclosestpointonnavmesh(var_0.grid_origin);

  if(distancesquared(var_1, var_0.grid_origin) <= var_0.max_nav_offset) {
    var_0.grid_origin = scripts\engine\utility::drop_to_ground(var_1, 96, -300) + (0, 0, 16);
    var_0.origin = var_0.grid_origin;
    var_0.last_x = var_0.x;
    var_0.last_y = var_0.y;
    var_0.x_dir_fails = 0;
    var_0.y_dir_fails = 0;
    return 1;
  }

  var_0.dir_fails++;

  if(var_0.last_x != var_0.x) {
    var_0.x_dir_fails++;
  }

  if(var_0.last_y != var_0.y) {
    var_0.y_dir_fails++;
  }

  return 0;
}

function create_cover_nodes_from_single_grid_point() {
  var_0 = debugdata();
  var_0.should_create_exposed_node = 1;

  for(var_1 = 0; var_1 <= var_0.node_creation_traces; var_1++) {
    var_0.node_creation_trace_index = var_1;
    create_and_validate_node_from_single_grid_point();
  }
}

function create_cover_nodes_from_grid_point() {
  var_0 = debugdata();
  var_0.should_create_exposed_node = 1;

  for(var_1 = 0; var_1 <= var_0.node_creation_traces; var_1++) {
    var_0.node_creation_trace_index = var_1;
    create_and_validate_node();
  }

  if(istrue(var_0.create_exposed_node) && istrue(var_0.should_create_exposed_node)) {
    var_2 = scripts\engine\utility::drop_to_ground(var_0.grid_origin, 16, -300) + (0, 0, 16);
    var_0.origin = var_2;

    if(can_spawn_capsule_trace(var_2) && !trace_for_stairs()) {
      var_0.angles = (0, 0, 0);

      if(!similar_nodes_nearby()) {
        return;
      }

      var_0.node_type = "node_exposed";
      run_path_node_removal();
      return;
    }

    return;
  }
}

function vol_create_and_validate_node() {
  var_0 = debugdata();
  var_1 = var_0.grid_origin;
  var_2 = var_0.node_creation_angle_frac * var_0.node_creation_trace_index;
  var_3 = cos(var_2) * var_0.node_creation_trace_dist;
  var_4 = sin(var_2) * var_0.node_creation_trace_dist;
  var_5 = var_1[0] + var_3;
  var_6 = var_1[1] + var_4;
  var_7 = var_1[2];
  var_8 = (var_5, var_6, var_7);
  var_9 = create_node_trace(var_1, var_8);

  if(isDefined(var_9["position"]) && isDefined(var_9["fraction"]) && var_9["fraction"] < 1) {
    var_0.should_create_exposed_node = 0;

    if(isDefined(var_9["normal"])) {
      var_10 = vectordot(var_9["normal"], (0, 0, 1));
      var_0.origin = var_9["position"];
      var_0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var_9["normal"])[1]), 0);

      if(-0.1 > var_10 || var_10 > 0.1) {
        return;
      }
    }

    var_11 = getclosestpointonnavmesh(var_9["position"]);

    if(distancesquared(var_9["position"], var_11) <= var_0.max_nav_offset) {
      var_0.should_create_exposed_node = 0;
      var_0.origin = scripts\engine\utility::drop_to_ground(var_11, 96, -300) + (0, 0, 16);
      var_0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var_9["normal"])[1]), 0);
      reposition_cover_node();
      return;
    }

    return;
  }
}

function create_and_validate_node_from_single_grid_point() {
  var_0 = debugdata();
  var_1 = var_0.grid_origin;
  var_2 = var_0.node_creation_angle_frac * var_0.node_creation_trace_index;
  var_3 = cos(var_2) * var_0.node_creation_trace_dist;
  var_4 = sin(var_2) * var_0.node_creation_trace_dist;
  var_5 = var_1[0] + var_3;
  var_6 = var_1[1] + var_4;
  var_7 = var_1[2];
  var_8 = (var_5, var_6, var_7);
  var_9 = create_node_trace(var_1, var_8);

  if(isDefined(var_9["normal"])) {
    var_10 = vectordot(var_9["normal"], (0, 0, 1));

    if(-0.1 > var_10 || var_10 > 0.1) {
      return;
    }
  }

  var_11 = getclosestpointonnavmesh(var_9["position"]);

  if(distancesquared(var_9["position"], var_11) <= var_0.max_nav_offset) {
    var_0.should_create_exposed_node = 0;
    var_0.node_type = "script_struct";
    var_0.origin = scripts\engine\utility::drop_to_ground(var_11, 12, -300) + (0, 0, 16);
    var_0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var_9["normal"])[1]), 0);
    write_struct_to_map();
    var_0.total_grid_points++;
    reposition_cover_node();
    return;
  }

  var_0.node_type = "script_struct";
  var_0.angles = (0, 0, 0);
  var_0.origin = var_9["position"];
  write_struct_to_map();
}

function create_and_validate_node() {
  var_0 = debugdata();
  var_1 = var_0.grid_origin;
  var_2 = var_0.node_creation_angle_frac * var_0.node_creation_trace_index;
  var_3 = cos(var_2) * var_0.node_creation_trace_dist;
  var_4 = sin(var_2) * var_0.node_creation_trace_dist;
  var_5 = var_1[0] + var_3;
  var_6 = var_1[1] + var_4;
  var_7 = var_1[2];
  var_8 = (var_5, var_6, var_7);
  var_9 = create_node_trace(var_1, var_8);

  if(isDefined(var_9["position"]) && isDefined(var_9["fraction"]) && var_9["fraction"] < 1) {
    var_0.should_create_exposed_node = 0;

    if(isDefined(var_9["normal"])) {
      var_10 = vectordot(var_9["normal"], (0, 0, 1));

      if(-0.1 > var_10 || var_10 > 0.1) {
        return;
      }
    }

    var_11 = getclosestpointonnavmesh(var_9["position"]);

    if(distancesquared(var_9["position"], var_11) <= var_0.max_nav_offset) {
      var_0.origin = scripts\engine\utility::drop_to_ground(var_11, 12, -300) + (0, 0, 16);
      var_0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var_9["normal"])[1]), 0);
      reposition_cover_node();
      return;
    }

    return;
  }
}

function create_node_trace(var_0, var_1, var_2) {
  var_3 = debugdata();
  attempt_throttle();
  var_3.traces_count++;
  var_4 = scripts\engine\trace::ray_trace(var_0, var_1, level.players, var_3.trace_contents);

  if(var_3.save_trace_data) {
    if(isDefined(var_4["position"])) {
      if(!isDefined(var_2)) {
        var_2 = (1, 1, 1);
      }

      var_3.temp_trace_data[var_3.temp_trace_data.size] = var_4["position"];
      var_3.temp_trace_data_colors[var_3.temp_trace_data_colors.size] = var_2;
      var_3.temp_trace_data[var_3.temp_trace_data.size] = var_1;
      var_3.temp_trace_data_colors[var_3.temp_trace_data_colors.size] = (0, 0, 0);
    }
  }

  return scripts\engine\trace::ray_trace(var_0, var_1, level.players, var_3.trace_contents);
}

function debug_node_array(var_0) {
  level notify("debug_node_array");
  level endon("debug_node_array");
  var_1 = debugdata();

  for(;;) {
    level waittill("start_array_debug");

    if(isDefined(var_1.trace_data[getdvarint("debug_script_node", 0)])) {
      var_2 = var_1.trace_data[getdvarint("debug_script_node", 0)];

      foreach(var_4 in var_2) {
        var_5 = var_1.trace_data_colors[getdvarint("debug_script_node", 0)][var_6];
        thread draw_line_until_endons(level, var_4, var_5[0], var_5[1], var_5[2]);

        if(var_6 % 100) {
          waitframe();
        }
      }

      waitframe();
    }
  }
}

function reposition_cover_node() {
  if(!similar_nodes_nearby()) {
    return;
  }

  level notify("reposition_cover_node");
  var_0 = debugdata();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = anglestoright(var_2);
  var_4 = anglestoleft(var_2);
  var_5 = anglesToForward(var_2);
  var_6 = -1 * anglesToForward(var_2);
  var_7 = anglestoup(var_2);
  var_8 = [var_4, var_3];
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_0.found_left_edge = 0;
  var_0.found_right_edge = 0;
  var_0.found_up_edge = 0;
  var_0.found_exposed_pos = 0;
  var_0.wall_units = 0;
  var_0.temp_trace_data = [];
  var_0.found_valid_node_pos = 0;
  var_0.temp_trace_data_colors = [];

  if(getdvarint("scr_save_trace_data", 0)) {
    var_0.save_trace_data = 1;
    var_0.temp_trace_data[var_0.temp_trace_data.size] = var_1;
    var_0.temp_trace_data_colors[var_0.temp_trace_data_colors.size] = (1, 1, 1);
  }

  var_12 = var_0.valid_forward_dist;

  for(var_13 = 0; var_13 < 4; var_13++) {
    if(var_8.size < 1) {
      break;
    }

    for(var_14 = 0; var_14 < var_8.size; var_14++) {
      var_15 = var_8[var_14];
      var_16 = var_1 + var_15 * var_13 * 32;

      if(!can_spawn_capsule_trace(var_16)) {
        var_8 = scripts\engine\utility::array_remove(var_8, var_15);
        continue;
      }

      var_17 = create_node_trace(var_16, var_16 + var_5 * var_12, (0, 1, 1));

      if(!trace_result_hits_surface(var_17)) {
        var_0.found_valid_node_pos = 0;

        for(var_18 = 1; var_18 < 32; var_18++) {
          var_19 = var_16 + -1 * var_15 * var_18;

          if(!can_spawn_capsule_trace(var_19)) {
            var_8 = scripts\engine\utility::array_remove(var_8, var_15);
            continue;
          }

          var_20 = create_node_trace(var_19, var_19 + var_5 * 24, (0, 1, 1));

          if(trace_result_hits_surface(var_20)) {
            var_0.found_valid_node_pos = 1;
            var_0.should_create_exposed_node = 0;

            if(position_near_other_nodes(var_20["position"])) {
              var_8 = scripts\engine\utility::array_remove(var_8, var_15);
              break;
            }

            if(var_15 == var_4) {
              if(!var_0.found_left_edge && var_0.edge_placement) {
                if(edge_point_valid(var_19, var_15, var_5)) {
                  var_0.found_left_edge = 1;
                  var_9 = scripts\engine\utility::drop_to_ground(var_20["position"], 12, -300);
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                } else {
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                }
              }

              continue;
            }

            if(!var_0.found_right_edge && var_0.edge_placement) {
              if(edge_point_valid(var_19, var_15, var_5)) {
                var_0.found_right_edge = 1;
                var_10 = scripts\engine\utility::drop_to_ground(var_20["position"], 12, -300);
                var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                continue;
              }

              var_8 = scripts\engine\utility::array_remove(var_8, var_15);
              break;
            }
          }
        }

        continue;
      }

      var_21 = create_node_trace(var_17["position"] + var_7 * 28, var_17["position"] + var_5 * var_0.valid_forward_dist + var_7 * 28, (1, 0, 1));

      if(!var_0.found_up_edge && !trace_result_hits_surface(var_21) && !position_near_other_nodes(var_21["position"]) && up_point_valid(var_17["position"] + -1 * var_5, [var_4, var_3], var_5, var_7)) {
        var_0.found_up_edge = 1;
        var_0.should_create_exposed_node = 0;
        var_11 = scripts\engine\utility::drop_to_ground(var_17["position"], 12, -300);
      }
    }
  }

  level notify("finished_reposition_node");

  if(isDefined(var_9) && var_0.found_left_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_9 + var_6 * 17 + -1 * var_4 * 16, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_0.origin = var_22;
      var_16 = var_22 + var_7 * 24;
      var_20 = create_node_trace(var_16, var_16 + var_5 * var_0.valid_forward_dist, (1, 1, 0));

      if(trace_result_hits_surface(var_20)) {
        var_0.node_type = "node_cover_left";
      } else {
        var_0.node_type = "node_cover_crouch";
      }

      run_path_node_removal();
    }
  }

  if(isDefined(var_10) && var_0.found_right_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_10 + var_6 * 17 + -1 * var_3 * 16, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_0.origin = var_22;
      var_16 = var_22 + var_7 * 24;
      var_20 = create_node_trace(var_16, var_16 + var_5 * 64, (1, 1, 0));

      if(trace_result_hits_surface(var_20)) {
        var_0.node_type = "node_cover_right";
      } else {
        var_0.node_type = "node_cover_crouch";
      }

      run_path_node_removal();
    }
  }

  if(isDefined(var_11) && var_0.found_up_edge && !var_0.found_right_edge && !var_0.found_left_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_11 + var_6 * 17, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_0.origin = var_22;
      var_0.node_type = "node_cover_crouch";
      run_path_node_removal();
    }
  }

  var_0.save_trace_data = 0;
}

function simple_reposition_node() {
  if(!similar_nodes_nearby()) {
    return;
  }

  level notify("reposition_cover_node");
  var_0 = debugdata();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = anglestoright(var_2);
  var_4 = anglestoleft(var_2);
  var_5 = anglesToForward(var_2);
  var_6 = -1 * anglesToForward(var_2);
  var_7 = anglestoup(var_2);

  if(scripts\engine\utility::is_equal(var_0.node_type, "node_cover_left")) {
    var_8 = [var_4];
  } else {
    var_8 = [var_4];
  }

  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_1.found_left_edge = 0;
  var_1.found_right_edge = 0;
  var_1.found_up_edge = 0;
  var_1.found_exposed_pos = 0;
  var_1.wall_units = 0;
  var_1.temp_trace_data = [];
  var_1.found_valid_node_pos = 0;
  var_1.temp_trace_data_colors = [];
  var_12 = var_1.valid_forward_dist;

  for(var_13 = 0; var_13 < 4; var_13++) {
    if(var_8.size < 1) {
      break;
    }

    for(var_14 = 0; var_14 < var_8.size; var_14++) {
      var_15 = var_8[var_14];
      var_16 = var_2 + var_15 * var_13 * 32;

      if(!can_spawn_capsule_trace(var_16)) {
        var_8 = scripts\engine\utility::array_remove(var_8, var_15);
        continue;
      }

      var_17 = create_node_trace(var_16, var_16 + var_6 * var_12, (0, 1, 1));

      if(!trace_result_hits_surface(var_17)) {
        var_1.found_valid_node_pos = 0;

        for(var_18 = 1; var_18 < 32; var_18++) {
          var_19 = var_16 + -1 * var_15 * var_18;

          if(!can_spawn_capsule_trace(var_19)) {
            var_8 = scripts\engine\utility::array_remove(var_8, var_15);
            continue;
          }

          var_20 = create_node_trace(var_19, var_19 + var_6 * 24, (0, 1, 1));

          if(trace_result_hits_surface(var_20)) {
            var_1.found_valid_node_pos = 1;
            var_1.should_create_exposed_node = 0;

            if(var_15 == var_5) {
              if(!var_1.found_left_edge && var_1.edge_placement) {
                if(edge_point_valid(var_19, var_15, var_6)) {
                  var_1.found_left_edge = 1;
                  var_9 = scripts\engine\utility::drop_to_ground(var_20["position"], 12, -300);
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                } else {
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                }
              }

              continue;
            }

            if(!var_1.found_right_edge && var_1.edge_placement) {
              if(edge_point_valid(var_19, var_15, var_6)) {
                var_1.found_right_edge = 1;
                var_10 = scripts\engine\utility::drop_to_ground(var_20["position"], 12, -300);
                var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                continue;
              }

              var_8 = scripts\engine\utility::array_remove(var_8, var_15);
              break;
            }
          }
        }

        continue;
      }

      var_21 = create_node_trace(var_17["position"] + var_8 * 28, var_17["position"] + var_6 * var_1.valid_forward_dist + var_8 * 28, (1, 0, 1));

      if(!var_1.found_up_edge && !trace_result_hits_surface(var_21) && up_point_valid(var_17["position"] + -1 * var_6, [var_5, var_4], var_6, var_8)) {
        var_1.found_up_edge = 1;
        var_1.should_create_exposed_node = 0;
        var_11 = scripts\engine\utility::drop_to_ground(var_17["position"], 12, -300);
      }
    }
  }

  level notify("finished_reposition_node");

  if(isDefined(var_9) && var_1.found_left_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_9 + var_7 * 17 + -1 * var_5 * 16, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_1.origin = var_22;
      var_16 = var_22 + var_8 * 24;
      var_20 = create_node_trace(var_16, var_16 + var_6 * var_1.valid_forward_dist, (1, 1, 0));

      if(trace_result_hits_surface(var_20)) {
        var_1.node_type = "node_cover_left";
      } else {
        var_1.node_type = "node_cover_crouch";
      }

      run_path_node_removal();
    }
  }

  if(isDefined(var_10) && var_1.found_right_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_10 + var_7 * 17 + -1 * var_4 * 16, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_1.origin = var_22;
      var_16 = var_22 + var_8 * 24;
      var_20 = create_node_trace(var_16, var_16 + var_6 * 64, (1, 1, 0));

      if(trace_result_hits_surface(var_20)) {
        var_1.node_type = "node_cover_right";
      } else {
        var_1.node_type = "node_cover_crouch";
      }

      run_path_node_removal();
    }
  }

  if(isDefined(var_11) && var_1.found_up_edge && !var_1.found_right_edge && !var_1.found_left_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_11 + var_7 * 17, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_1.origin = var_22;
      var_1.node_type = "node_cover_crouch";
      run_path_node_removal();
    }
  }

  var_1.save_trace_data = 0;
}

function find_final_position(var_0) {}

function trace_for_stairs() {
  return false;
}

function edge_point_valid(var_0, var_1, var_2) {
  var_3 = debugdata();

  for(var_4 = 32; var_4 > 0; var_4--) {
    var_5 = var_0 + -1 * var_1 * var_4;

    if(!can_spawn_capsule_trace(var_5)) {
      break;
    }

    var_6 = create_node_trace(var_5, var_5 + var_2 * 24, (0, 1, 0));

    if(trace_result_hits_surface(var_6)) {
      var_3.wall_units++;
    }
  }

  if(var_3.wall_units >= var_3.wall_units_required) {
    for(var_7 = 32; var_7 > 0; var_7--) {
      var_5 = var_0 + var_1 * var_7;

      if(!can_spawn_capsule_trace(var_5)) {
        return 0;
      }

      var_6 = create_node_trace(var_5, var_5 + var_2 * var_3.valid_forward_dist, (0, 1, 0));

      if(trace_result_hits_surface(var_6)) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

function up_point_valid(var_0, var_1, var_2, var_3) {
  var_4 = debugdata();
  var_5 = var_1;

  for(var_6 = 32; var_6 > 0; var_6--) {
    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      var_8 = var_5[var_7];
      var_9 = var_0 + -1 * var_8 * var_6;
      var_10 = create_node_trace(var_9, var_9 + var_2 * 24, (0, 1, 0));

      if(!trace_result_hits_surface(var_10)) {
        var_4.wall_units++;

        if(var_4.wall_units >= var_4.wall_units_required) {
          break;
        }

        continue;
      }
    }
  }

  var_5 = var_1;
  var_4.wall_units = 0;

  for(var_7 = 32; var_7 > 0; var_7--) {
    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_8 = var_5[var_6];
      var_9 = var_0 + var_8 * var_7 + var_3 * 28;
      var_10 = create_node_trace(var_9, var_9 + var_2 * var_4.valid_forward_dist, (0, 1, 0));

      if(trace_result_hits_surface(var_10)) {
        continue;
      }

      var_4.wall_units++;
    }
  }

  if(var_4.wall_units >= var_4.wall_units_required) {
    return 1;
  }

  return 0;
}

function attempt_throttle() {
  var_0 = debugdata();
  var_0.throttle_counter++;

  if(var_0.throttle_counter >= var_0.create_node_throttle) {
    var_0.throttle_counter = 0;
    waitframe();
    return;
  }
}

function trace_result_hits_surface(var_0, var_1) {
  var_2 = debugdata();

  if(isDefined(var_0["position"]) && isDefined(var_0["fraction"]) && var_0["fraction"] < 1 && var_0["fraction"] > 0) {
    if(isDefined(var_1)) {
      if(isDefined(var_0["normal"])) {
        if(var_1 == var_0["normal"]) {
          return 1;
        }

        return 0;
      }

      return 1;
    }

    return 1;
  }

  return 0;
}

function open_and_write_to_paths_map() {
  var_0 = debugdata();

  if(!scripts\engine\utility::flag("file_opened")) {
    scripts\engine\utility::flag_set("file_opened");
    var_0.aa_status = "adding_nodes_to_map";
    scripts\engine\utility:: fileprint_launcher_start_file();
      var_1 = "\t";
    var_2 = 0;
    scripts\engine\utility:: fileprint_launcher( "iwmap 11" );
      scripts\engine\utility:: fileprint_launcher( var_1 + "entity " + var_2 );
      scripts\engine\utility:: fileprint_launcher( "{" );
      scripts\engine\utility:: fileprint_launcher( var_1 + "\"classname\" \"worldspawn\"" );
      scripts\engine\utility:: fileprint_launcher( "}" );
      return;
  }
}

function draw_closest_wall_points(var_0, var_1) {
  level endon("game_ended");
  level notify("draw_closest_wall_points");
  level endon("draw_closest_wall_points");
  var_0 endon("use");
  var_0 endon("disconnect");
  var_2 = debugdata();

  for(;;) {
    var_0 notify("reset_wall_lines");
    var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_1, undefined, 50);

    foreach(var_5 in var_3) {}

    wait 1;
  }
}

function run_path_node_removal() {
  level endon("game_ended");
  level endon("get_nav_start_points");
  var_0 = debugdata();

  if(!position_near_other_nodes(var_0.origin)) {
    var_1 = spawnStruct();
    var_1.angles = var_0.angles;
    var_1.origin = var_0.origin;
    var_0.all_node_positions[var_0.all_node_positions.size] = var_1;

    if(getdvarint("scr_save_trace_data", 0)) {
      var_0.trace_data[var_0.map_ent_index] = var_0.temp_trace_data;
      var_0.trace_data_colors[var_0.map_ent_index] = var_0.temp_trace_data_colors;
    }

    var_0.should_create_exposed_node = 0;
    write_struct_to_map();

    if(istrue(var_0.debug_boxes)) {
      return;
    }

    return;
  }
}

function position_near_other_nodes(var_0) {
  var_1 = debugdata();
  var_1.density_cap_count = 0;

  if(var_1.use_bsp_nodes) {
    var_2 = getallnodes();

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];

      if(var_4.origin == var_0) {
        return true;
      }

      var_5 = distancesquared(var_0, var_4.origin);

      if(var_5 <= 576) {
        return true;
      }
    }
  }

  var_6 = var_1.all_node_positions;

  for(var_3 = 0; var_3 < var_6.size; var_3++) {
    var_7 = var_6[var_3];

    if(var_7.origin == var_0) {
      return true;
    }

    var_5 = distancesquared(var_0, var_7.origin);

    if(var_5 <= 256) {
      return true;
    }

    if(var_5 <= var_1.density_radius) {
      var_1.density_cap_count++;

      if(var_1.density_cap_count >= var_1.density_cap) {
        return true;
      }
    }
  }

  return false;
}

function write_struct_to_map() {
  var_0 = debugdata();
  var_1 = "\t";
  scripts\engine\utility:: fileprint_launcher( "entity " + var_0.map_ent_index );
    scripts\engine\utility:: fileprint_launcher( "{" );
    scripts\engine\utility:: fileprint_launcher( var_1 + "\"origin\" \"" + var_0.origin[ 0 ] + " " + var_0.origin[ 1 ] + " " + var_0.origin[ 2 ] + "\"" );

    if(isDefined(var_0.node_type)) {
      scripts\engine\utility:: fileprint_launcher( var_1 + "\"classname\" \"" + var_0.node_type + "\"" );
    }
  else {
    scripts\engine\utility:: fileprint_launcher( var_1 + "\"classname\" \"node_cover_left\"" );
  }

  if(isDefined(var_0.angles)) {
    scripts\engine\utility:: fileprint_launcher( var_1 + "\"angles\" \"" + var_0.angles[ 0 ] + " " + var_0.angles[ 1 ] + " " + var_0.angles[ 2 ] + "\"" );
  } else {
    scripts\engine\utility:: fileprint_launcher( var_1 + "\"angles\" \"0 0 0\"" );
  }

  scripts\engine\utility:: fileprint_launcher( "}" );
    var_0.map_ent_index++;
}

function draw_line_until_endons(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = debugdata();

  if(isDefined(var_4)) {
    if(isarray(var_4)) {
      foreach(var_7 in var_4) {
        self endon(var_7);
      }
    } else {
      self endon(var_4);
    }
  }

  for(;;) {
    waitframe();
  }
}

function addentrytodevgui(var_0) {
  thread addentrytodevgui_internal(level);
}

function addentrytodevgui_internal(var_0) {
  level endon("game_ended");
  wait 5;
  var_1 = "";
  var_2 = strtok(var_0, "/");
  var_3 = " ";
  var_4 = 0;

  foreach(var_6 in var_2) {
    var_7 = strtok(var_6, " ");
    var_8 = 1;
    var_9 = var_7.size;

    foreach(var_11 in var_7) {
      if(var_8 < var_9) {
        var_1 = var_1 + var_11 + var_3;
      } else {
        var_1 += var_11;
      }

      var_8++;
    }

    var_4++;

    if(var_4 < var_2.size) {
      var_1 += "/";
    }
  }
}

function can_spawn_capsule_trace(var_0) {
  return scripts\engine\trace::capsule_trace_passed(var_0 + (0, 0, 32), var_0, 16, 32);
}