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
  var0 = spawnStruct();
  var0.trace_contents = scripts\engine\trace::create_solid_ai_contents(1);
  var0.all_node_positions = [];
  var0.map_ent_index = 1;
  level.path_node_debug_info = var0;
  reset_path_node_placement();
  return level.path_node_debug_info;
}

function reset_path_node_placement_for_radius() {
  var0 = reset_path_node_placement();
  var0.x_magnitude = 32;
  var0.y_magnitude = 32;
  var0.max_x = 20;
  var0.max_y = 20;
  level.path_node_debug_info = var0;
  return level.path_node_debug_info;
}

function reset_path_node_placement_for_lookat() {
  var0 = reset_path_node_placement();
  var0.debug_boxes = 1;
  var0.node_creation_traces = 32;
  var0.delayed_creation_calls = 0;
  var0.create_node_throttle = 500;
  level.path_node_debug_info = var0;
  return level.path_node_debug_info;
}

function reset_path_node_placement_for_box_creation() {
  var0 = reset_path_node_placement();
  var0.debug_boxes = 1;
  var0.debug_boxes_max_count = 50;
  var0.debug_boxes_count = 0;
  var0.valid_forward_dist = 64;
  var0.x_magnitude = 256;
  var0.y_magnitude = 256;
  var0.z_magnitude = 128;
  var0.max_nav_offset = 4096;
  var0.create_node_throttle = 5000;
  var0.max_x = undefined;
  var0.max_y = undefined;
  var0.max_z = undefined;
  level.path_node_debug_info = var0;
  return level.path_node_debug_info;
}

function reset_path_node_placement() {
  var0 = level.path_node_debug_info;
  var0.total_grid_points = 0;
  var0.start_time = gettime();
  var0.end_time = gettime();
  var0.total_time = gettime();
  var0.box_x = 1024;
  var0.box_y = 1024;
  var0.box_z = 512;
  var0.box_x_min = 512;
  var0.box_y_min = 512;
  var0.box_z_min = 128;
  var0.increase_x = 1;
  var0.increase_y = 1;
  var0.increase_z = 1;
  var0.box_center = (0, 0, 0);
  var0.box_angles = (0, 0, 0);
  var0.freeze_location = 0;
  var0.box_disabled = 0;
  var0.x_done = 0;
  var0.y_done = 0;
  var0.z_done = 0;
  var0.auto_write_to_map = 1;
  var0.use_bsp_nodes = getdvarint("scr_use_bsp_nodes", 1);
  var0.debug_boxes = getdvarint("scr_draw_nodes", 0);
  var0.edge_placement = 1;
  var0.file_path = level.script + "_script_paths.map";
  var0.node_creation_traces = 16;
  var0.node_creation_trace_index = 0;
  var0.node_creation_trace_dist = 365;
  var0.node_creation_angle_frac = 360 / var0.node_creation_traces;
  var0.aa_status = "waiting";
  var0.create_node_throttle = 5000;
  var0.throttle_counter = 0;
  var0.traces_count = 0;
  var0.x_magnitude = 256;
  var0.y_magnitude = 256;
  var0.z_magnitude = 64;
  var0.max_nav_offset = 16384;
  var0.valid_forward_dist = 64;
  var0.current_forward_dist = undefined;
  var0.x = 1;
  var0.y = 1;
  var0.z = 1;
  var0.max_x = undefined;
  var0.max_y = undefined;
  var0.last_x = 1;
  var0.last_y = 1;
  var0.x_dir_fails = 0;
  var0.y_dir_fails = 0;
  var0.dir_fails = 0;
  var0.max_dir_fails = 500;
  var0.total_z_planes = 5;
  var0.origin_counter = 0;
  var0.origin_max_dirs = 8;
  var0.dir_valid[0] = 1;
  var0.dir_valid[1] = 1;
  var0.dir_valid[2] = 1;
  var0.dir_valid[3] = 1;
  var0.dir_valid[4] = 1;
  var0.dir_valid[5] = 1;
  var0.dir_valid[6] = 1;
  var0.dir_valid[7] = 1;
  var0.grid_points_found = 1;
  var0.wall_units = 0;
  var0.wall_units_required = 32;
  var0.found_left_edge = 0;
  var0.found_right_edge = 0;
  var0.found_up_edge = 0;
  var0.found_exposed_pos = 0;
  var0.use_trace_data = getdvarint("scr_save_trace_data", 0);
  var0.save_trace_data = 0;
  var0.temp_trace_data = [];
  var0.temp_trace_data_colors = [];
  var0.trace_data = [];
  var0.trace_data_colors = [];
  var0.grid_origin = (0, 0, 0);
  var0.density_radius = 64;
  var0.density_cap = 4;
  var0.density_cap_count = 0;
  var0.found_valid_node_pos = 0;
  var0.create_exposed_node = getdvarint("scr_create_exposed_nodes", 0);
  var0.should_create_exposed_node = 1;
  level.path_node_debug_info = var0;
  level.increase_y = var0;
  level.num_fails = 0;
  return level.path_node_debug_info;
}

function debugdata() {
  return level.path_node_debug_info;
}

function run_single_grid_point_test(var0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var0 endon("disconnect");
  level endon("stop_creating_nodes");
  reset_path_node_placement_for_box_creation();
  var1 = debugdata();
  var1.player = var0;
  open_and_write_to_paths_map();
  var0 notifyonplayercommand("use", "+usereload");
  var0 notifyonplayercommand("use", "+activate");

  for(;;) {
    var0 waittill("use");
    thread delay_node_creation_from_single_point();
  }
}

function place_path_node_from_lookat(var0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var0 endon("disconnect");
  level endon("stop_creating_nodes");
  reset_path_node_placement_for_lookat();
  var1 = debugdata();
  var1.player = var0;
  open_and_write_to_paths_map();
  var0 notifyonplayercommand("use", "+usereload");
  var0 notifyonplayercommand("use", "+activate");
  var0 waittill("use");
  GscBinSkip4(0x6e, var1);
}

function delay_node_creation_from_single_point() {
  var0 = debugdata();
  var1 = var0.player;
  open_and_write_to_paths_map();
  var0.starting_pos = var1.origin;
  var2 = anglesToForward(var1 getplayerangles());
  var3 = create_node_trace(var0.player getEye(), var0.player getEye() + var2 * 10000);

  if(isDefined(var3["position"]) && isDefined(var3["fraction"]) && var3["fraction"] < 1) {
    var4 = scripts\engine\utility::drop_to_ground(var3["position"] + -1 * var2 * 32, 96, -300) + (0, 0, 16);
    var0.x = var4[0];
    var0.y = var4[1];
    var0.z = var4[2];
    var0.origin = var4;
    var0.grid_origin = var4;

    if(validate_grid_pos()) {
      var0.node_type = "script_struct";
      var0.total_grid_points++;
      var0.angles = (0, 0, 0);
      write_struct_to_map();
      var0.classname = "node_exposed";
      create_and_validate_node_from_single_grid_point();
      return;
    }

    return;
  }
}

function delay_node_creation_from_look_at() {
  var0 = debugdata();
  var1 = var0.player;
  open_and_write_to_paths_map();
  var0.starting_pos = var1.origin;
  var2 = anglesToForward(var1 getplayerangles());
  var3 = create_node_trace(var0.player getEye(), var0.player getEye() + var2 * 10000);

  if(isDefined(var3["position"]) && isDefined(var3["fraction"]) && var3["fraction"] < 1) {
    var4 = scripts\engine\utility::drop_to_ground(var3["position"] + -1 * var2 * 32, 24, -300) + (0, 0, 16);
    var0.x = var4[0];
    var0.y = var4[1];
    var0.z = var4[2];
    var0.origin = var4;
    var0.grid_origin = var4;

    if(validate_grid_pos()) {
      var0.angles = (0, 0, 0);
      var0.classname = "node_exposed";
      create_cover_nodes_from_grid_point();
      return;
    }

    return;
  }
}

function place_path_nodes_within_box(var0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var0 endon("disconnect");
  level endon("stop_creating_nodes");
  var1 = debugdata();
  var1.player = var0;
  var0 notifyonplayercommand("use", "+usereload");
  var0 notifyonplayercommand("use", "+activate");
  reset_path_node_placement_for_box_creation();
  GscBinSkip4(0x6e, var1);
}

function create_and_update_box() {
  var0 = debugdata();
  var0.player notifyonplayercommand("up", "+actionslot 1");
  var0.player notifyonplayercommand("down", "+actionslot 2");
  var0.player notifyonplayercommand("right", "+actionslot 4");
  var0.player notifyonplayercommand("rb", "+frag");
  var0.player notifyonplayercommand("lb", "+smoke");
  var0.player notifyonplayercommand("a", "+gostand");
  var0.player notifyonplayercommand("left", "+actionslot 3");
  var0.player notifyonplayercommand("dpad_left_release", "-actionslot 3");
  var0.player notifyonplayercommand("dpad_left_press", "+actionslot 3");
  GscBinSkip4(0x6e, var0);
}

function show_running_tool_message() {
  self endon("stop_showing_message");
  var0 = 0;

  for(;;) {
    var1 = 500;
    var2 = "Creating Nodes | Time Elapsed: " + var0;
    waitframe();
    var0 += 0.05;
  }
}

function create_box() {
  var0 = debugdata();
  var1 = var0.player;
  var2 = var1.origin + anglesToForward(var1.angles) * 500;
  var3 = var1.angles;
  var4 = var2;
  var5 = var3;

  for(;;) {
    if(var0.box_disabled) {
      wait 1;
      continue;
    }

    var6 = 150;

    if(getdvarint("scr_cs_box_x", 0) != 0) {
      var0.box_x = getdvarint("scr_cs_box_x", 0);
      var7 = "X: " + var0.box_x;
    } else {
      var7 = "X: " + var0.box_x;
    }

    var6 += 25;

    if(getdvarint("scr_cs_box_y", 0) != 0) {
      var0.box_x = getdvarint("scr_cs_box_y", 0);
      var7 = "Y: " + var0.box_y;
    } else {
      var7 = "Y: " + var0.box_y;
    }

    var6 += 25;

    if(getdvarint("scr_cs_box_z", 0) != 0) {
      var0.box_x = getdvarint("scr_cs_box_z", 0);
      var7 = "Z: " + var0.box_z;
    } else {
      var7 = "Z: " + var0.box_z;
    }

    var6 += 25;
    var7 = "Location Locked: " + var0.freeze_location;
    var6 += 25;

    if(var0.freeze_location) {
      var2 = var4;
      var3 = var5;
    } else {
      var2 = var1.origin + anglesToForward(var1.angles) * 500;
      var3 = var1.angles;
    }

    var4 = var2;
    var5 = var3;
    var0.box_center = var2;
    var0.box_angles = var3;
    waitframe();
  }
}

function place_path_nodes_within_radius(var0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var0 endon("disconnect");
  level endon("stop_creating_nodes");
  var1 = debugdata();
  var1.player = var0;
  var0 notifyonplayercommand("use", "+usereload");
  var0 notifyonplayercommand("use", "+activate");

  for(;;) {
    reset_path_node_placement_for_radius();
    var0 waittill("use");
    open_and_write_to_paths_map();
    var1.starting_pos = var0.origin;
    create_cover_nodes_from_grid_points();
  }
}

function place_path_nodes(var0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var0 endon("disconnect");
  var1 = debugdata();
  var1.player = var0;
  var1.starting_pos = var0.origin;
  reset_path_node_placement();
  open_and_write_to_paths_map();
  var1.aa_status = "starting";
  GscBinSkip4(0x6e, var1);
}

function clean_up_nodes() {
  level endon("game_ended");
  level endon("stop_creating_nodes");
  var0 = debugdata();
  reset_path_node_placement();
  open_and_write_to_paths_map();
  var0.aa_status = "starting";
  var0.use_bsp_nodes = 0;
  var0.file_path = level.script + "_script_paths_clean.map";
  GscBinSkip4(0x6e, var0);
}

function translate_position_with_offset_data(var0, var1) {
  if(isDefined(var1)) {
    var2 = var1;
  } else {
    var2 = (0, 0, 0);
  }

  if(isDefined(self.angles)) {
    var3 = self.angles;
  } else {
    var3 = (0, 0, 0);
  }

  var4 = self.origin;
  var5 = anglesToForward(var3);
  self.origin = var2 + rotatevector(var4, var3);
  var6 = vectortoangles(rotatevector(var5, var3));
  self.angles = var6;
}

function node_passes_nav_and_geo_validation(var0) {
  var1 = debugdata();

  if(distancesquared(getclosestpointonnavmesh(var1.origin), var1.origin) >= 1024) {
    return 0;
  }

  if(!can_spawn_capsule_trace(var1.origin)) {
    return 0;
  }

  if(!istrue(var0)) {
    var2 = getnodesinradius(var1.origin, 16, 0, 64);

    if(var2.size < 1) {
      return 1;
    }

    return 0;
  }

  return 1;
}

function remove_similar_nodes(var0) {
  level notify("place_path_nodes");
  level endon("place_path_nodes");
  level endon("game_ended");
  var0 endon("disconnect");
  level endon("stop_creating_nodes");
  var1 = 100;
  var2 = getdvarint("scr_cover_node_clean_radius");

  if(var2 != 0) {
    var1 = var2;
  }

  var3 = var1 * var1;
  var4 = debugdata();
  var4.player = var0;
  reset_path_node_placement();
  open_and_write_to_paths_map();
  var4.aa_status = "starting";
  var5 = getallnodes();

  for(var6 = 0; var6 < var5.size; var6++) {
    var7 = var5[var6];

    if(isDefined(var7)) {
      var8 = 0;

      for(var9 = 0; var9 < var5.size; var9++) {
        var10 = var5[var9];

        if(!isDefined(var10)) {
          continue;
        }

        if(var10.origin == var7.origin) {
          continue;
        }

        var11 = var7.origin;
        var12 = distancesquared(var11, var10.origin);

        if(var12 <= var3) {
          if(var7.type == var10.type) {
            if(var7.angles == var10.angles) {
              var8 = 1;
              break;
            }
          }
        }
      }

      if(!var8) {
        var4.node_type = get_node_type_from_type(var7);

        if(isDefined(var4.node_type)) {
          var4.origin = var7.origin;
          var4.angles = var7.angles;
          write_struct_to_map();
        } else {
          var5[var6] = undefined;
        }
      } else {
        var5[var6] = undefined;
      }
    }
  }

  thread close_map_write();
}

function similar_nodes_nearby() {
  var0 = debugdata();
  var1 = 100;
  var2 = var1 * var1;

  if(var0.use_bsp_nodes) {
    var3 = getallnodes();

    for(var4 = 0; var4 < var3.size; var4++) {
      var5 = var3[var4];

      if(isDefined(var5)) {
        if(var0.origin == var5.origin) {
          return false;
        }

        var6 = distancesquared(var5.origin, var0.origin);

        if(var6 <= var2) {
          if(var5.angles == var0.angles) {
            return false;
          }
        }
      }
    }
  }

  var3 = level.path_node_debug_info.all_node_positions;

  for(var4 = 0; var4 < var3.size; var4++) {
    var5 = var3[var4];

    if(isDefined(var5)) {
      if(var0.origin == var5.origin) {
        return false;
      }

      var6 = distancesquared(var0.origin, var5.origin);

      if(var6 <= var2) {
        if(var5.angles == var0.angles) {
          return false;
        }
      }
    }
  }

  return true;
}

function get_node_type_from_type(var0) {
  switch (var0.type) {
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
  var0 = debugdata();

  if(scripts\engine\utility::flag("file_opened")) {
    scripts\engine\utility::flag_clear("file_opened");
    var1 = var0.file_path;
    var2 = get_raw_or_devraw_subdir();
    var3 = get_gamemode_subdir();
    var4 = "/map_source/" + var1;
    var5 = 1;
    scripts\engine\utility:: fileprint_launcher_end_file( var4, var5 );
      level notify("stop_creating_nodes");
  }

  if(getdvarint("scr_save_trace_data", 0)) {
    thread debug_node_array(level);
    return;
  }
}

function create_cover_nodes_within_volume() {
  level endon("game_ended");
  var0 = debugdata();
  var0.aa_status = "creating_cover_node_positions";
  var0.grid_points_found = 1;
  var0.increase_y = 1;

  while(var0.grid_points_found) {
    var0.num_fails = 0;

    for(var1 = 0; var1 < var0.origin_max_dirs; var1++) {
      var0.origin_counter = var1;
      get_next_volume_origin();

      if(vol_validate_grid_pos()) {
        var0.angles = (0, 0, 0);
        var0.node_type = "script_struct";
        var0.origin = var0.grid_origin;
        var0.classname = "node_exposed";
        vol_create_cover_nodes_from_grid_point();
      }
    }

    create_grid_point_in_volume();
  }

  iprintlnbold("Create Node Completed " + var0.all_node_positions.size + " Created.");
}

function vol_create_cover_nodes_from_grid_point() {
  var0 = debugdata();
  var0.should_create_exposed_node = 1;

  for(var1 = 0; var1 <= var0.node_creation_traces; var1++) {
    var0.node_creation_trace_index = var1;
    vol_create_and_validate_node();
  }

  if(istrue(var0.create_exposed_node) && istrue(var0.should_create_exposed_node)) {
    var2 = scripts\engine\utility::drop_to_ground(var0.grid_origin, 16, -300) + (0, 0, 16);
    var0.origin = var2;

    if(can_spawn_capsule_trace(var2) && !trace_for_stairs()) {
      var0.angles = (0, 0, 0);

      if(!similar_nodes_nearby()) {
        return;
      }

      var0.node_type = "node_exposed";
      run_path_node_removal();
      return;
    }

    return;
  }
}

function create_cover_nodes_from_grid_points() {
  level endon("game_ended");
  level endon("end_grid_creation");
  var0 = debugdata();
  var0.aa_status = "creating_cover_node_positions";
  var0.grid_points_found = 1;
  var0.increase_y = 1;

  while(var0.grid_points_found) {
    var0.num_fails = 0;
    create_grid_point();

    for(var1 = 0; var1 < var0.origin_max_dirs; var1++) {
      var0.origin_counter = var1;

      for(var2 = 0; var2 < var0.total_z_planes; var2++) {
        var0.z = var2;
        get_next_origin();

        if(validate_grid_pos()) {
          var0.angles = (0, 0, 0);
          var0.classname = "node_exposed";
          create_cover_nodes_from_grid_point();
        }
      }
    }
  }

  iprintlnbold("Create Node Completed " + var0.all_node_positions.size + " Created.");
}

function create_grid_point_in_volume() {
  var0 = debugdata();

  if(var0.increase_x) {
    vol_increase_x_coordinate();
  } else if(var0.increase_y) {
    var0.increase_x = 1;
    var0.x = 0;
    vol_increase_y_coordinate();
  } else {
    var0.increase_x = 1;
    var0.increase_y = 1;
    var0.x = 0;
    var0.y = 0;
    vol_increase_z_coordinate();
  }

  if(var0.x_done && var0.y_done && var0.z_done) {
    var0.grid_points_found = 0;
    level notify("end_grid_creation");
    return;
  }
}

function create_grid_point() {
  var0 = debugdata();
  var1 = 0;

  if(!increase_y_coordinate()) {
    var1++;

    if(increase_x_coordinate()) {
      var0.y = 1;
    } else {
      var1++;
    }
  }

  if(var1 >= 2) {
    var0.grid_points_found = 0;
    level notify("end_grid_creation");
    return;
  }
}

function create_grid_point_new() {
  var0 = debugdata();

  if(var0.dir_fails >= var0.max_dir_fails) {
    var0.grid_points_found = 0;
    level notify("end_grid_creation");
    return;
  }

  var1 = 0;

  if(isDefined(var0.max_y)) {
    if(var0.y > var0.max_y) {
      var1++;
    }
  }

  if(isDefined(var0.max_x)) {
    if(var0.x > var0.max_x) {
      var1++;
    }
  }

  if(var1 >= 2) {
    var0.grid_points_found = 0;
    level notify("end_grid_creation");
    return;
  }

  if(var0.increase_y) {
    increase_y_coordinate_new();
    var0.increase_y = 0;
    return;
  }

  increase_x_coordinate_new();
  var0.increase_y = 1;
}

function increase_y_coordinate_new() {
  var0 = debugdata();

  if(isDefined(var0.max_y)) {
    if(var0.y < var0.max_y) {
      var0.y++;
      return 1;
    }

    return 0;
  }

  var0.y++;
  return 1;
}

function increase_x_coordinate_new() {
  var0 = debugdata();

  if(isDefined(var0.max_x)) {
    if(var0.x < var0.max_x) {
      var0.x++;
      return 1;
    }

    return 0;
  }

  var0.x++;
  return 1;
}

function increase_x_coordinate() {
  var0 = debugdata();

  if(var0.x_dir_fails <= var0.max_dir_fails) {
    if(isDefined(var0.max_x)) {
      if(var0.x < var0.max_x) {
        var0.x++;
        return 1;
      }

      return 0;
    }

    var0.x++;
    return 1;
  }

  return 0;
}

function vol_increase_x_coordinate() {
  var0 = debugdata();

  if(isDefined(var0.max_x)) {
    if(var0.x < var0.max_x) {
      var0.x++;
      return 1;
    }

    var0.increase_x = 0;
    var0.x_done = 1;
    return 0;
  }

  var0.x++;
  return 1;
}

function increase_y_coordinate() {
  var0 = debugdata();

  if(var0.y_dir_fails <= var0.max_dir_fails) {
    if(isDefined(var0.max_y)) {
      if(var0.y < var0.max_y) {
        var0.y++;
        return 1;
      }

      return 0;
    }

    var0.y++;
    return 1;
  }

  return 0;
}

function vol_increase_y_coordinate() {
  var0 = debugdata();

  if(isDefined(var0.max_y)) {
    if(var0.y < var0.max_y) {
      var0.y++;
      return 1;
    }

    var0.increase_y = 0;
    var0.y_done = 1;
    return 0;
  }

  var0.y++;
  return 1;
}

function vol_increase_z_coordinate() {
  var0 = debugdata();

  if(isDefined(var0.max_z)) {
    if(var0.z < var0.max_z) {
      var0.z++;
      return 1;
    }

    var0.z_done = 1;
    return 0;
  }

  var0.z++;
  return 1;
}

function get_next_origin() {
  var0 = debugdata();
  var1 = var0.starting_pos;
  var2 = var0.x;
  var3 = var0.y;
  var4 = var0.z;

  if(var0.dir_valid[var0.origin_counter]) {
    switch (var0.origin_counter) {
      case 0:
        var0.grid_origin = var1 + (var2 * var0.x_magnitude, var3 * var0.y_magnitude, var4 * var0.z_magnitude);
        break;
      case 1:
        var0.grid_origin = var1 + (-1 * var2 * var0.x_magnitude, var3 * var0.y_magnitude, var4 * var0.z_magnitude);
        break;
      case 2:
        var0.grid_origin = var1 + (-1 * var2 * var0.x_magnitude, -1 * var3 * var0.y_magnitude, var4 * var0.z_magnitude);
        break;
      case 3:
        var0.grid_origin = var1 + (-1 * var2 * var0.x_magnitude, var3 * var0.y_magnitude, -1 * var4 * var0.z_magnitude);
        break;
      case 4:
        var0.grid_origin = var1 + (-1 * var2 * var0.x_magnitude, -1 * var3 * var0.y_magnitude, -1 * var4 * var0.z_magnitude);
        break;
      case 5:
        var0.grid_origin = var1 + (var2 * var0.x_magnitude, -1 * var3 * var0.y_magnitude, var4 * var0.z_magnitude);
        break;
      case 6:
        var0.grid_origin = var1 + (var2 * var0.x_magnitude, -1 * var3 * var0.y_magnitude, -1 * var4 * var0.z_magnitude);
        break;
      case 7:
        var0.grid_origin = var1 + (var2 * var0.x_magnitude, var3 * var0.y_magnitude, -1 * var4 * var0.z_magnitude);
        break;
    }

    return;
  }
}

function get_next_volume_origin() {
  var0 = debugdata();
  var1 = var0.starting_pos;
  var2 = var0.x;
  var3 = var0.y;
  var4 = var0.z;
  var5 = var0.box_angles;
  var6 = anglesToForward(var5);
  var7 = anglestoright(var5);
  var8 = anglestoup(var5);
  var9 = var6 * var2 * var0.x_magnitude;
  var10 = var7 * var3 * var0.y_magnitude;
  var11 = var8 * var4 * var0.z_magnitude;

  switch (var0.origin_counter) {
    case 0:
      var0.grid_origin = var1 + var9 + var10 + var11;
      break;
    case 1:
      var0.grid_origin = var1 + -1 * var9 + var10 + var11;
      break;
    case 2:
      var0.grid_origin = var1 + -1 * var9 + -1 * var10 + var11;
      break;
    case 3:
      var0.grid_origin = var1 + -1 * var9 + var10 + -1 * var11;
      break;
    case 4:
      var0.grid_origin = var1 + -1 * var9 + -1 * var10 + -1 * var11;
      break;
    case 5:
      var0.grid_origin = var1 + var9 + -1 * var10 + var11;
      break;
    case 6:
      var0.grid_origin = var1 + var9 + -1 * var10 + -1 * var11;
      break;
    case 7:
      var0.grid_origin = var1 + var9 + var10 + -1 * var11;
      break;
  }
}

function vol_validate_grid_pos() {
  var0 = debugdata();
  var1 = getclosestpointonnavmesh(var0.grid_origin);

  if(distancesquared(var1, var0.grid_origin) <= var0.max_nav_offset) {
    var0.grid_origin = scripts\engine\utility::drop_to_ground(var1, 96, -300);
    var0.origin = var0.grid_origin + (0, 0, 16);
    var0.last_x = var0.x;
    var0.last_y = var0.y;
    return 1;
  }

  return 0;
}

function validate_grid_pos() {
  var0 = debugdata();
  var1 = getclosestpointonnavmesh(var0.grid_origin);

  if(distancesquared(var1, var0.grid_origin) <= var0.max_nav_offset) {
    var0.grid_origin = scripts\engine\utility::drop_to_ground(var1, 96, -300) + (0, 0, 16);
    var0.origin = var0.grid_origin;
    var0.last_x = var0.x;
    var0.last_y = var0.y;
    var0.x_dir_fails = 0;
    var0.y_dir_fails = 0;
    return 1;
  }

  var0.dir_fails++;

  if(var0.last_x != var0.x) {
    var0.x_dir_fails++;
  }

  if(var0.last_y != var0.y) {
    var0.y_dir_fails++;
  }

  return 0;
}

function create_cover_nodes_from_single_grid_point() {
  var0 = debugdata();
  var0.should_create_exposed_node = 1;

  for(var1 = 0; var1 <= var0.node_creation_traces; var1++) {
    var0.node_creation_trace_index = var1;
    create_and_validate_node_from_single_grid_point();
  }
}

function create_cover_nodes_from_grid_point() {
  var0 = debugdata();
  var0.should_create_exposed_node = 1;

  for(var1 = 0; var1 <= var0.node_creation_traces; var1++) {
    var0.node_creation_trace_index = var1;
    create_and_validate_node();
  }

  if(istrue(var0.create_exposed_node) && istrue(var0.should_create_exposed_node)) {
    var2 = scripts\engine\utility::drop_to_ground(var0.grid_origin, 16, -300) + (0, 0, 16);
    var0.origin = var2;

    if(can_spawn_capsule_trace(var2) && !trace_for_stairs()) {
      var0.angles = (0, 0, 0);

      if(!similar_nodes_nearby()) {
        return;
      }

      var0.node_type = "node_exposed";
      run_path_node_removal();
      return;
    }

    return;
  }
}

function vol_create_and_validate_node() {
  var0 = debugdata();
  var1 = var0.grid_origin;
  var2 = var0.node_creation_angle_frac * var0.node_creation_trace_index;
  var3 = cos(var2) * var0.node_creation_trace_dist;
  var4 = sin(var2) * var0.node_creation_trace_dist;
  var5 = var1[0] + var3;
  var6 = var1[1] + var4;
  var7 = var1[2];
  var8 = (var5, var6, var7);
  var9 = create_node_trace(var1, var8);

  if(isDefined(var9["position"]) && isDefined(var9["fraction"]) && var9["fraction"] < 1) {
    var0.should_create_exposed_node = 0;

    if(isDefined(var9["normal"])) {
      var10 = vectordot(var9["normal"], (0, 0, 1));
      var0.origin = var9["position"];
      var0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var9["normal"])[1]), 0);

      if(-0.1 > var10 || var10 > 0.1) {
        return;
      }
    }

    var11 = getclosestpointonnavmesh(var9["position"]);

    if(distancesquared(var9["position"], var11) <= var0.max_nav_offset) {
      var0.should_create_exposed_node = 0;
      var0.origin = scripts\engine\utility::drop_to_ground(var11, 96, -300) + (0, 0, 16);
      var0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var9["normal"])[1]), 0);
      reposition_cover_node();
      return;
    }

    return;
  }
}

function create_and_validate_node_from_single_grid_point() {
  var0 = debugdata();
  var1 = var0.grid_origin;
  var2 = var0.node_creation_angle_frac * var0.node_creation_trace_index;
  var3 = cos(var2) * var0.node_creation_trace_dist;
  var4 = sin(var2) * var0.node_creation_trace_dist;
  var5 = var1[0] + var3;
  var6 = var1[1] + var4;
  var7 = var1[2];
  var8 = (var5, var6, var7);
  var9 = create_node_trace(var1, var8);

  if(isDefined(var9["normal"])) {
    var10 = vectordot(var9["normal"], (0, 0, 1));

    if(-0.1 > var10 || var10 > 0.1) {
      return;
    }
  }

  var11 = getclosestpointonnavmesh(var9["position"]);

  if(distancesquared(var9["position"], var11) <= var0.max_nav_offset) {
    var0.should_create_exposed_node = 0;
    var0.node_type = "script_struct";
    var0.origin = scripts\engine\utility::drop_to_ground(var11, 12, -300) + (0, 0, 16);
    var0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var9["normal"])[1]), 0);
    write_struct_to_map();
    var0.total_grid_points++;
    reposition_cover_node();
    return;
  }

  var0.node_type = "script_struct";
  var0.angles = (0, 0, 0);
  var0.origin = var9["position"];
  write_struct_to_map();
}

function create_and_validate_node() {
  var0 = debugdata();
  var1 = var0.grid_origin;
  var2 = var0.node_creation_angle_frac * var0.node_creation_trace_index;
  var3 = cos(var2) * var0.node_creation_trace_dist;
  var4 = sin(var2) * var0.node_creation_trace_dist;
  var5 = var1[0] + var3;
  var6 = var1[1] + var4;
  var7 = var1[2];
  var8 = (var5, var6, var7);
  var9 = create_node_trace(var1, var8);

  if(isDefined(var9["position"]) && isDefined(var9["fraction"]) && var9["fraction"] < 1) {
    var0.should_create_exposed_node = 0;

    if(isDefined(var9["normal"])) {
      var10 = vectordot(var9["normal"], (0, 0, 1));

      if(-0.1 > var10 || var10 > 0.1) {
        return;
      }
    }

    var11 = getclosestpointonnavmesh(var9["position"]);

    if(distancesquared(var9["position"], var11) <= var0.max_nav_offset) {
      var0.origin = scripts\engine\utility::drop_to_ground(var11, 12, -300) + (0, 0, 16);
      var0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var9["normal"])[1]), 0);
      reposition_cover_node();
      return;
    }

    return;
  }
}

function create_node_trace(var0, var1, var2) {
  var3 = debugdata();
  attempt_throttle();
  var3.traces_count++;
  var4 = scripts\engine\trace::ray_trace(var0, var1, level.players, var3.trace_contents);

  if(var3.save_trace_data) {
    if(isDefined(var4["position"])) {
      if(!isDefined(var2)) {
        var2 = (1, 1, 1);
      }

      var3.temp_trace_data[var3.temp_trace_data.size] = var4["position"];
      var3.temp_trace_data_colors[var3.temp_trace_data_colors.size] = var2;
      var3.temp_trace_data[var3.temp_trace_data.size] = var1;
      var3.temp_trace_data_colors[var3.temp_trace_data_colors.size] = (0, 0, 0);
    }
  }

  return scripts\engine\trace::ray_trace(var0, var1, level.players, var3.trace_contents);
}

function debug_node_array(var0) {
  level notify("debug_node_array");
  level endon("debug_node_array");
  var1 = debugdata();

  for(;;) {
    level waittill("start_array_debug");

    if(isDefined(var1.trace_data[getdvarint("debug_script_node", 0)])) {
      var2 = var1.trace_data[getdvarint("debug_script_node", 0)];

      foreach(var4 in var2) {
        var5 = var1.trace_data_colors[getdvarint("debug_script_node", 0)][var6];
        thread draw_line_until_endons(level, var4, var5[0], var5[1], var5[2]);

        if(var6 % 100) {
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
  var0 = debugdata();
  var1 = var0.origin;
  var2 = var0.angles;
  var3 = anglestoright(var2);
  var4 = anglestoleft(var2);
  var5 = anglesToForward(var2);
  var6 = -1 * anglesToForward(var2);
  var7 = anglestoup(var2);
  var8 = [var4, var3];
  var9 = undefined;
  var10 = undefined;
  var11 = undefined;
  var0.found_left_edge = 0;
  var0.found_right_edge = 0;
  var0.found_up_edge = 0;
  var0.found_exposed_pos = 0;
  var0.wall_units = 0;
  var0.temp_trace_data = [];
  var0.found_valid_node_pos = 0;
  var0.temp_trace_data_colors = [];

  if(getdvarint("scr_save_trace_data", 0)) {
    var0.save_trace_data = 1;
    var0.temp_trace_data[var0.temp_trace_data.size] = var1;
    var0.temp_trace_data_colors[var0.temp_trace_data_colors.size] = (1, 1, 1);
  }

  var12 = var0.valid_forward_dist;

  for(var13 = 0; var13 < 4; var13++) {
    if(var8.size < 1) {
      break;
    }

    for(var14 = 0; var14 < var8.size; var14++) {
      var15 = var8[var14];
      var16 = var1 + var15 * var13 * 32;

      if(!can_spawn_capsule_trace(var16)) {
        var8 = scripts\engine\utility::array_remove(var8, var15);
        continue;
      }

      var17 = create_node_trace(var16, var16 + var5 * var12, (0, 1, 1));

      if(!trace_result_hits_surface(var17)) {
        var0.found_valid_node_pos = 0;

        for(var18 = 1; var18 < 32; var18++) {
          var19 = var16 + -1 * var15 * var18;

          if(!can_spawn_capsule_trace(var19)) {
            var8 = scripts\engine\utility::array_remove(var8, var15);
            continue;
          }

          var20 = create_node_trace(var19, var19 + var5 * 24, (0, 1, 1));

          if(trace_result_hits_surface(var20)) {
            var0.found_valid_node_pos = 1;
            var0.should_create_exposed_node = 0;

            if(position_near_other_nodes(var20["position"])) {
              var8 = scripts\engine\utility::array_remove(var8, var15);
              break;
            }

            if(var15 == var4) {
              if(!var0.found_left_edge && var0.edge_placement) {
                if(edge_point_valid(var19, var15, var5)) {
                  var0.found_left_edge = 1;
                  var9 = scripts\engine\utility::drop_to_ground(var20["position"], 12, -300);
                  var8 = scripts\engine\utility::array_remove(var8, var15);
                  break;
                } else {
                  var8 = scripts\engine\utility::array_remove(var8, var15);
                  break;
                }
              }

              continue;
            }

            if(!var0.found_right_edge && var0.edge_placement) {
              if(edge_point_valid(var19, var15, var5)) {
                var0.found_right_edge = 1;
                var10 = scripts\engine\utility::drop_to_ground(var20["position"], 12, -300);
                var8 = scripts\engine\utility::array_remove(var8, var15);
                continue;
              }

              var8 = scripts\engine\utility::array_remove(var8, var15);
              break;
            }
          }
        }

        continue;
      }

      var21 = create_node_trace(var17["position"] + var7 * 28, var17["position"] + var5 * var0.valid_forward_dist + var7 * 28, (1, 0, 1));

      if(!var0.found_up_edge && !trace_result_hits_surface(var21) && !position_near_other_nodes(var21["position"]) && up_point_valid(var17["position"] + -1 * var5, [var4, var3], var5, var7)) {
        var0.found_up_edge = 1;
        var0.should_create_exposed_node = 0;
        var11 = scripts\engine\utility::drop_to_ground(var17["position"], 12, -300);
      }
    }
  }

  level notify("finished_reposition_node");

  if(isDefined(var9) && var0.found_left_edge) {
    var22 = scripts\engine\utility::drop_to_ground(var9 + var6 * 17 + -1 * var4 * 16, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var22) && !trace_for_stairs()) {
      var0.origin = var22;
      var16 = var22 + var7 * 24;
      var20 = create_node_trace(var16, var16 + var5 * var0.valid_forward_dist, (1, 1, 0));

      if(trace_result_hits_surface(var20)) {
        var0.node_type = "node_cover_left";
      } else {
        var0.node_type = "node_cover_crouch";
      }

      run_path_node_removal();
    }
  }

  if(isDefined(var10) && var0.found_right_edge) {
    var22 = scripts\engine\utility::drop_to_ground(var10 + var6 * 17 + -1 * var3 * 16, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var22) && !trace_for_stairs()) {
      var0.origin = var22;
      var16 = var22 + var7 * 24;
      var20 = create_node_trace(var16, var16 + var5 * 64, (1, 1, 0));

      if(trace_result_hits_surface(var20)) {
        var0.node_type = "node_cover_right";
      } else {
        var0.node_type = "node_cover_crouch";
      }

      run_path_node_removal();
    }
  }

  if(isDefined(var11) && var0.found_up_edge && !var0.found_right_edge && !var0.found_left_edge) {
    var22 = scripts\engine\utility::drop_to_ground(var11 + var6 * 17, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var22) && !trace_for_stairs()) {
      var0.origin = var22;
      var0.node_type = "node_cover_crouch";
      run_path_node_removal();
    }
  }

  var0.save_trace_data = 0;
}

function simple_reposition_node() {
  if(!similar_nodes_nearby()) {
    return;
  }

  level notify("reposition_cover_node");
  var0 = debugdata();
  var1 = var0.origin;
  var2 = var0.angles;
  var3 = anglestoright(var2);
  var4 = anglestoleft(var2);
  var5 = anglesToForward(var2);
  var6 = -1 * anglesToForward(var2);
  var7 = anglestoup(var2);

  if(scripts\engine\utility::is_equal(var0.node_type, "node_cover_left")) {
    var8 = [var4];
  } else {
    var8 = [var4];
  }

  var9 = undefined;
  var10 = undefined;
  var11 = undefined;
  var1.found_left_edge = 0;
  var1.found_right_edge = 0;
  var1.found_up_edge = 0;
  var1.found_exposed_pos = 0;
  var1.wall_units = 0;
  var1.temp_trace_data = [];
  var1.found_valid_node_pos = 0;
  var1.temp_trace_data_colors = [];
  var12 = var1.valid_forward_dist;

  for(var13 = 0; var13 < 4; var13++) {
    if(var8.size < 1) {
      break;
    }

    for(var14 = 0; var14 < var8.size; var14++) {
      var15 = var8[var14];
      var16 = var2 + var15 * var13 * 32;

      if(!can_spawn_capsule_trace(var16)) {
        var8 = scripts\engine\utility::array_remove(var8, var15);
        continue;
      }

      var17 = create_node_trace(var16, var16 + var6 * var12, (0, 1, 1));

      if(!trace_result_hits_surface(var17)) {
        var1.found_valid_node_pos = 0;

        for(var18 = 1; var18 < 32; var18++) {
          var19 = var16 + -1 * var15 * var18;

          if(!can_spawn_capsule_trace(var19)) {
            var8 = scripts\engine\utility::array_remove(var8, var15);
            continue;
          }

          var20 = create_node_trace(var19, var19 + var6 * 24, (0, 1, 1));

          if(trace_result_hits_surface(var20)) {
            var1.found_valid_node_pos = 1;
            var1.should_create_exposed_node = 0;

            if(var15 == var5) {
              if(!var1.found_left_edge && var1.edge_placement) {
                if(edge_point_valid(var19, var15, var6)) {
                  var1.found_left_edge = 1;
                  var9 = scripts\engine\utility::drop_to_ground(var20["position"], 12, -300);
                  var8 = scripts\engine\utility::array_remove(var8, var15);
                  break;
                } else {
                  var8 = scripts\engine\utility::array_remove(var8, var15);
                  break;
                }
              }

              continue;
            }

            if(!var1.found_right_edge && var1.edge_placement) {
              if(edge_point_valid(var19, var15, var6)) {
                var1.found_right_edge = 1;
                var10 = scripts\engine\utility::drop_to_ground(var20["position"], 12, -300);
                var8 = scripts\engine\utility::array_remove(var8, var15);
                continue;
              }

              var8 = scripts\engine\utility::array_remove(var8, var15);
              break;
            }
          }
        }

        continue;
      }

      var21 = create_node_trace(var17["position"] + var8 * 28, var17["position"] + var6 * var1.valid_forward_dist + var8 * 28, (1, 0, 1));

      if(!var1.found_up_edge && !trace_result_hits_surface(var21) && up_point_valid(var17["position"] + -1 * var6, [var5, var4], var6, var8)) {
        var1.found_up_edge = 1;
        var1.should_create_exposed_node = 0;
        var11 = scripts\engine\utility::drop_to_ground(var17["position"], 12, -300);
      }
    }
  }

  level notify("finished_reposition_node");

  if(isDefined(var9) && var1.found_left_edge) {
    var22 = scripts\engine\utility::drop_to_ground(var9 + var7 * 17 + -1 * var5 * 16, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var22) && !trace_for_stairs()) {
      var1.origin = var22;
      var16 = var22 + var8 * 24;
      var20 = create_node_trace(var16, var16 + var6 * var1.valid_forward_dist, (1, 1, 0));

      if(trace_result_hits_surface(var20)) {
        var1.node_type = "node_cover_left";
      } else {
        var1.node_type = "node_cover_crouch";
      }

      run_path_node_removal();
    }
  }

  if(isDefined(var10) && var1.found_right_edge) {
    var22 = scripts\engine\utility::drop_to_ground(var10 + var7 * 17 + -1 * var4 * 16, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var22) && !trace_for_stairs()) {
      var1.origin = var22;
      var16 = var22 + var8 * 24;
      var20 = create_node_trace(var16, var16 + var6 * 64, (1, 1, 0));

      if(trace_result_hits_surface(var20)) {
        var1.node_type = "node_cover_right";
      } else {
        var1.node_type = "node_cover_crouch";
      }

      run_path_node_removal();
    }
  }

  if(isDefined(var11) && var1.found_up_edge && !var1.found_right_edge && !var1.found_left_edge) {
    var22 = scripts\engine\utility::drop_to_ground(var11 + var7 * 17, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var22) && !trace_for_stairs()) {
      var1.origin = var22;
      var1.node_type = "node_cover_crouch";
      run_path_node_removal();
    }
  }

  var1.save_trace_data = 0;
}

function find_final_position(var0) {}

function trace_for_stairs() {
  return false;
}

function edge_point_valid(var0, var1, var2) {
  var3 = debugdata();

  for(var4 = 32; var4 > 0; var4--) {
    var5 = var0 + -1 * var1 * var4;

    if(!can_spawn_capsule_trace(var5)) {
      break;
    }

    var6 = create_node_trace(var5, var5 + var2 * 24, (0, 1, 0));

    if(trace_result_hits_surface(var6)) {
      var3.wall_units++;
    }
  }

  if(var3.wall_units >= var3.wall_units_required) {
    for(var7 = 32; var7 > 0; var7--) {
      var5 = var0 + var1 * var7;

      if(!can_spawn_capsule_trace(var5)) {
        return 0;
      }

      var6 = create_node_trace(var5, var5 + var2 * var3.valid_forward_dist, (0, 1, 0));

      if(trace_result_hits_surface(var6)) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

function up_point_valid(var0, var1, var2, var3) {
  var4 = debugdata();
  var5 = var1;

  for(var6 = 32; var6 > 0; var6--) {
    for(var7 = 0; var7 < var5.size; var7++) {
      var8 = var5[var7];
      var9 = var0 + -1 * var8 * var6;
      var10 = create_node_trace(var9, var9 + var2 * 24, (0, 1, 0));

      if(!trace_result_hits_surface(var10)) {
        var4.wall_units++;

        if(var4.wall_units >= var4.wall_units_required) {
          break;
        }

        continue;
      }
    }
  }

  var5 = var1;
  var4.wall_units = 0;

  for(var7 = 32; var7 > 0; var7--) {
    for(var6 = 0; var6 < var5.size; var6++) {
      var8 = var5[var6];
      var9 = var0 + var8 * var7 + var3 * 28;
      var10 = create_node_trace(var9, var9 + var2 * var4.valid_forward_dist, (0, 1, 0));

      if(trace_result_hits_surface(var10)) {
        continue;
      }

      var4.wall_units++;
    }
  }

  if(var4.wall_units >= var4.wall_units_required) {
    return 1;
  }

  return 0;
}

function attempt_throttle() {
  var0 = debugdata();
  var0.throttle_counter++;

  if(var0.throttle_counter >= var0.create_node_throttle) {
    var0.throttle_counter = 0;
    waitframe();
    return;
  }
}

function trace_result_hits_surface(var0, var1) {
  var2 = debugdata();

  if(isDefined(var0["position"]) && isDefined(var0["fraction"]) && var0["fraction"] < 1 && var0["fraction"] > 0) {
    if(isDefined(var1)) {
      if(isDefined(var0["normal"])) {
        if(var1 == var0["normal"]) {
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
  var0 = debugdata();

  if(!scripts\engine\utility::flag("file_opened")) {
    scripts\engine\utility::flag_set("file_opened");
    var0.aa_status = "adding_nodes_to_map";
    scripts\engine\utility:: fileprint_launcher_start_file();
      var1 = "\t";
    var2 = 0;
    scripts\engine\utility:: fileprint_launcher( "iwmap 11" );
      scripts\engine\utility:: fileprint_launcher( var1 + "entity " + var2 );
      scripts\engine\utility:: fileprint_launcher( "{" );
      scripts\engine\utility:: fileprint_launcher( var1 + "\"classname\" \"worldspawn\"" );
      scripts\engine\utility:: fileprint_launcher( "}" );
      return;
  }
}

function draw_closest_wall_points(var0, var1) {
  level endon("game_ended");
  level notify("draw_closest_wall_points");
  level endon("draw_closest_wall_points");
  var0 endon("use");
  var0 endon("disconnect");
  var2 = debugdata();

  for(;;) {
    var0 notify("reset_wall_lines");
    var3 = scripts\engine\utility::get_array_of_closest(var0.origin, var1, undefined, 50);

    foreach(var5 in var3) {}

    wait 1;
  }
}

function run_path_node_removal() {
  level endon("game_ended");
  level endon("get_nav_start_points");
  var0 = debugdata();

  if(!position_near_other_nodes(var0.origin)) {
    var1 = spawnStruct();
    var1.angles = var0.angles;
    var1.origin = var0.origin;
    var0.all_node_positions[var0.all_node_positions.size] = var1;

    if(getdvarint("scr_save_trace_data", 0)) {
      var0.trace_data[var0.map_ent_index] = var0.temp_trace_data;
      var0.trace_data_colors[var0.map_ent_index] = var0.temp_trace_data_colors;
    }

    var0.should_create_exposed_node = 0;
    write_struct_to_map();

    if(istrue(var0.debug_boxes)) {
      return;
    }

    return;
  }
}

function position_near_other_nodes(var0) {
  var1 = debugdata();
  var1.density_cap_count = 0;

  if(var1.use_bsp_nodes) {
    var2 = getallnodes();

    for(var3 = 0; var3 < var2.size; var3++) {
      var4 = var2[var3];

      if(var4.origin == var0) {
        return true;
      }

      var5 = distancesquared(var0, var4.origin);

      if(var5 <= 576) {
        return true;
      }
    }
  }

  var6 = var1.all_node_positions;

  for(var3 = 0; var3 < var6.size; var3++) {
    var7 = var6[var3];

    if(var7.origin == var0) {
      return true;
    }

    var5 = distancesquared(var0, var7.origin);

    if(var5 <= 256) {
      return true;
    }

    if(var5 <= var1.density_radius) {
      var1.density_cap_count++;

      if(var1.density_cap_count >= var1.density_cap) {
        return true;
      }
    }
  }

  return false;
}

function write_struct_to_map() {
  var0 = debugdata();
  var1 = "\t";
  scripts\engine\utility:: fileprint_launcher( "entity " + var0.map_ent_index );
    scripts\engine\utility:: fileprint_launcher( "{" );
    scripts\engine\utility:: fileprint_launcher( var1 + "\"origin\" \"" + var0.origin[ 0 ] + " " + var0.origin[ 1 ] + " " + var0.origin[ 2 ] + "\"" );

    if(isDefined(var0.node_type)) {
      scripts\engine\utility:: fileprint_launcher( var1 + "\"classname\" \"" + var0.node_type + "\"" );
    }
  else {
    scripts\engine\utility:: fileprint_launcher( var1 + "\"classname\" \"node_cover_left\"" );
  }

  if(isDefined(var0.angles)) {
    scripts\engine\utility:: fileprint_launcher( var1 + "\"angles\" \"" + var0.angles[ 0 ] + " " + var0.angles[ 1 ] + " " + var0.angles[ 2 ] + "\"" );
  } else {
    scripts\engine\utility:: fileprint_launcher( var1 + "\"angles\" \"0 0 0\"" );
  }

  scripts\engine\utility:: fileprint_launcher( "}" );
    var0.map_ent_index++;
}

function draw_line_until_endons(var0, var1, var2, var3, var4) {
  self endon("death");
  var5 = debugdata();

  if(isDefined(var4)) {
    if(isarray(var4)) {
      foreach(var7 in var4) {
        self endon(var7);
      }
    } else {
      self endon(var4);
    }
  }

  for(;;) {
    waitframe();
  }
}

function addentrytodevgui(var0) {
  thread addentrytodevgui_internal(level);
}

function addentrytodevgui_internal(var0) {
  level endon("game_ended");
  wait 5;
  var1 = "";
  var2 = strtok(var0, "/");
  var3 = " ";
  var4 = 0;

  foreach(var6 in var2) {
    var7 = strtok(var6, " ");
    var8 = 1;
    var9 = var7.size;

    foreach(var11 in var7) {
      if(var8 < var9) {
        var1 = var1 + var11 + var3;
      } else {
        var1 += var11;
      }

      var8++;
    }

    var4++;

    if(var4 < var2.size) {
      var1 += "/";
    }
  }
}

function can_spawn_capsule_trace(var0) {
  return scripts\engine\trace::capsule_trace_passed(var0 + (0, 0, 32), var0, 16, 32);
}