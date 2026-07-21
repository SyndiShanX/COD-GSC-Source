/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\create_cover_nodes.gsc
***********************************************/

create_cover_node_init() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  initialize_path_node_placement();
  scripts\engine\utility::flag_init("_encstr_86D30C891C2460E0A29BABB5E73A");
}

initialize_path_node_placement() {
  var_0 = spawnStruct();
  var_0.trace_contents = scripts\engine\trace::create_solid_ai_contents(1);
  var_0.all_node_positions = [];
  var_0.map_ent_index = 1;
  level.path_node_debug_info = var_0;
  reset_path_node_placement();
  return level.path_node_debug_info;
}

reset_path_node_placement_for_radius() {
  var_0 = reset_path_node_placement();
  var_0.x_magnitude = 32;
  var_0.y_magnitude = 32;
  var_0.max_x = 20;
  var_0.max_y = 20;
  level.path_node_debug_info = var_0;
  return level.path_node_debug_info;
}

reset_path_node_placement_for_lookat() {
  var_0 = reset_path_node_placement();
  var_0.debug_boxes = 1;
  var_0.node_creation_traces = 32;
  var_0.delayed_creation_calls = 0;
  var_0.create_node_throttle = 500;
  level.path_node_debug_info = var_0;
  return level.path_node_debug_info;
}

reset_path_node_placement_for_box_creation() {
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

reset_path_node_placement() {
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
  var_0.use_bsp_nodes = getdvarint("_encstr_B89412CD6C9CBE5D37CAF5313707BEE6DE8CCADC", 1);
  var_0.debug_boxes = getdvarint("_encstr_ABF40FBF683B273A65375341A877F2A5A3", 0);
  var_0.edge_placement = 1;
  var_0.file_path = level.script + "_encstr_9A1B12FA6EB19CD2073AD738C2D11A9B71DA2C38";
  var_0.node_creation_traces = 16;
  var_0.node_creation_trace_index = 0;
  var_0.node_creation_trace_dist = 365;
  var_0.node_creation_angle_frac = 360 / var_0.node_creation_traces;
  var_0.aa_status = "_encstr_ABEF08334893239FF89C";
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
  var_0.use_trace_data = getdvarint("_encstr_B2D114AFC0FB1EEB4F5E1BC0FB40B9EEFFF04FC0DBE1", 0);
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
  var_0.create_exposed_node = getdvarint("_encstr_96C819CFDF3607D7B327F1FB57D1DF3BE998C3B0044F15AA21AB83", 0);
  var_0.should_create_exposed_node = 1;
  level.path_node_debug_info = var_0;
  level.increase_y = var_0;
  level.num_fails = 0;
  return level.path_node_debug_info;
}

debugdata() {
  return level.path_node_debug_info;
}

run_single_grid_point_test(var_0) {
  level notify("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_996B14774302383678C52DF0292A70B928DB38F5ADD6");
  reset_path_node_placement_for_box_creation();
  var_1 = debugdata();
  var_1.player = var_0;
  open_and_write_to_paths_map();
  var_0 notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_97410B23BD6B976233901AF2F8");
  var_0 notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_B4C60AD707B2BDC0E6CE1309");

  for(;;) {
    var_0 waittill("_encstr_AB19049D0FC0");
    var_1 thread delay_node_creation_from_single_point();
  }
}

place_path_node_from_lookat(var_0) {
  level notify("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_996B14774302383678C52DF0292A70B928DB38F5ADD6");
  reset_path_node_placement_for_lookat();
  var_1 = debugdata();
  var_1.player = var_0;
  open_and_write_to_paths_map();
  var_0 notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_97410B23BD6B976233901AF2F8");
  var_0 notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_B4C60AD707B2BDC0E6CE1309");

  for(;;) {
    var_0 waittill("_encstr_AB19049D0FC0");
    var_1 childthread show_running_tool_message();
    delay_node_creation_from_look_at();
    var_1 notify("_encstr_9B9815B329B8DAB776D82A93C0C09FD970E34B3B9B5027");
  }
}

delay_node_creation_from_single_point() {
  var_0 = debugdata();
  var_1 = var_0.player;
  open_and_write_to_paths_map();
  var_0.starting_pos = var_1.origin;
  var_2 = anglesToForward(var_1 getplayerangles());
  var_3 = create_node_trace(var_0.player getEye(), var_0.player getEye() + var_2 * 10000);

  if(isDefined(var_3["_encstr_BD260953AA97E3F014279D"]) && isDefined(var_3["_encstr_A53009A25003666B9818C6"]) && var_3["_encstr_A53009A25003666B9818C6"] < 1) {
    var_4 = scripts\engine\utility::drop_to_ground(var_3["_encstr_BD260953AA97E3F014279D"] + -1 * (var_2 * 32), 96, -300) + (0, 0, 16);
    var_0.x = var_4[0];
    var_0.y = var_4[1];
    var_0.z = var_4[2];
    var_0.origin = var_4;
    var_0.grid_origin = var_4;

    if(validate_grid_pos()) {
      var_0.node_type = "_encstr_85940E5A366D1AE01B616F7B2013AB93";
      var_0.total_grid_points++;
      var_0.angles = (0, 0, 0);
      write_struct_to_map();
      var_0.classname = "_encstr_81D70DCDED23B2F556E183DB9BB28C";
      create_and_validate_node_from_single_grid_point();
    }
  }
}

delay_node_creation_from_look_at() {
  var_0 = debugdata();
  var_1 = var_0.player;
  open_and_write_to_paths_map();
  var_0.starting_pos = var_1.origin;
  var_2 = anglesToForward(var_1 getplayerangles());
  var_3 = create_node_trace(var_0.player getEye(), var_0.player getEye() + var_2 * 10000);

  if(isDefined(var_3["_encstr_BD260953AA97E3F014279D"]) && isDefined(var_3["_encstr_A53009A25003666B9818C6"]) && var_3["_encstr_A53009A25003666B9818C6"] < 1) {
    var_4 = scripts\engine\utility::drop_to_ground(var_3["_encstr_BD260953AA97E3F014279D"] + -1 * (var_2 * 32), 24, -300) + (0, 0, 16);
    var_0.x = var_4[0];
    var_0.y = var_4[1];
    var_0.z = var_4[2];
    var_0.origin = var_4;
    var_0.grid_origin = var_4;

    if(validate_grid_pos()) {
      var_0.angles = (0, 0, 0);
      var_0.classname = "_encstr_81D70DCDED23B2F556E183DB9BB28C";
      create_cover_nodes_from_grid_point();
    }
  }
}

place_path_nodes_within_box(var_0) {
  level notify("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_996B14774302383678C52DF0292A70B928DB38F5ADD6");
  var_1 = debugdata();
  var_1.player = var_0;
  var_0 notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_97410B23BD6B976233901AF2F8");
  var_0 notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_B4C60AD707B2BDC0E6CE1309");
  reset_path_node_placement_for_box_creation();
  var_1 childthread create_and_update_box();

  for(;;) {
    var_0 waittill("_encstr_AB19049D0FC0");
    var_1.x = 0;
    var_1.y = 0;
    var_1.z = 0;
    var_1.increase_x = 1;
    var_1.increase_y = 1;
    var_1.increase_z = 1;
    var_1.x_done = 0;
    var_1.y_done = 0;
    var_1.z_done = 0;
    var_1.max_x = int(var_1.box_x / var_1.x_magnitude / 2 + 1);
    var_1.max_y = int(var_1.box_y / var_1.y_magnitude / 2 + 1);
    var_1.max_z = int(var_1.box_z / var_1.z_magnitude / 2 + 1);
    var_1.box_disabled = 1;
    open_and_write_to_paths_map();
    var_1.starting_pos = var_1.box_center;
    var_1 childthread show_running_tool_message();
    var_1.start_time = gettime();
    create_cover_nodes_within_volume();
    var_1.end_time = gettime();
    var_1.total_time = (var_1.end_time - var_1.start_time) / 1000;
    var_1 notify("_encstr_9B9815B329B8DAB776D82A93C0C09FD970E34B3B9B5027");
    var_1.box_disabled = 0;
  }
}

create_and_update_box() {
  var_0 = debugdata();
  var_0.player notifyonplayercommand("_encstr_87070365F7", "_encstr_AF5C0E59B08DA32D7B7337D8ED3A1098");
  var_0.player notifyonplayercommand("_encstr_9767056D0FBFA8", "_encstr_9A5C0E7471AFC0EA624018717863626F");
  var_0.player notifyonplayercommand("_encstr_8253060E2B5FE330", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
  var_0.player notifyonplayercommand("_encstr_B607038BAA", "_encstr_9B0D065699E485D9");
  var_0.player notifyonplayercommand("_encstr_960703D0C0", "_encstr_8E5F0795E6AD7BAD2B");
  var_0.player notifyonplayercommand("_encstr_994C023A", "_encstr_B44609DFE707CF394E1651");
  var_0.player notifyonplayercommand("_encstr_A5AD056A019C63", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  var_0.player notifyonplayercommand("_encstr_B271129F8B88E48941BBF3B3E77612542B31D2A7", "_encstr_A6380E5AB0C61D4BED7337D87B8E0866");
  var_0.player notifyonplayercommand("_encstr_914310F1938A19B1F911CA89275B9BD34776", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  var_0 childthread create_box();

  for(;;) {
    var_1 = var_0.player scripts\engine\utility::waittill_any_in_array_return(["_encstr_87070365F7", "_encstr_994C023A", "_encstr_9767056D0FBFA8", "_encstr_A5AD056A019C63", "_encstr_B607038BAA", "_encstr_960703D0C0", "_encstr_8253060E2B5FE330", "_encstr_B271129F8B88E48941BBF3B3E77612542B31D2A7", "_encstr_914310F1938A19B1F911CA89275B9BD34776"]);

    if(var_0.box_disabled) {
      wait 1;
      continue;
    }

    switch (var_1) {
      case "_encstr_8253060E2B5FE330":
        while(var_0.player buttonPressed("_encstr_A6270B22288288FA4929A309A8")) {
          var_0.box_y = var_0.box_y + var_0.y_magnitude;
          wait 0.1;
        }

        break;
      case "_encstr_914310F1938A19B1F911CA89275B9BD34776":
      case "_encstr_B271129F8B88E48941BBF3B3E77612542B31D2A7":
      case "_encstr_A5AD056A019C63":
        var_0.box_y = int(max(var_0.box_y - var_0.y_magnitude, var_0.box_y_min));
        wait 0.1;
        break;
      case "_encstr_994C023A":
        if(var_0.freeze_location)
          var_0.freeze_location = 0;
        else
          var_0.freeze_location = 1;

        break;
      case "_encstr_87070365F7":
        while(var_0.player buttonPressed("_encstr_9AB208E598CF456F83D9")) {
          var_0.box_x = var_0.box_x + var_0.x_magnitude;
          wait 0.1;
        }

        break;
      case "_encstr_9767056D0FBFA8":
        while(var_0.player buttonPressed("_encstr_9AD00ABF8733F0E735B997EB")) {
          var_0.box_x = int(max(var_0.box_x - var_0.x_magnitude, var_0.box_x_min));
          wait 0.1;
        }

        break;
      case "_encstr_B607038BAA":
        while(var_0.player buttonPressed("_encstr_B4EF0EAB0BB5D9D7E16612AA7C092471")) {
          var_0.box_z = var_0.box_z + var_0.z_magnitude;
          wait 0.1;
        }

        break;
      case "_encstr_960703D0C0":
        while(var_0.player buttonPressed("_encstr_BE700E48AAA2A8F472F598A642C42294")) {
          var_0.box_z = int(max(var_0.box_z - var_0.z_magnitude, var_0.box_z_min));
          wait 0.1;
        }

        break;
      default:
        break;
    }
  }
}

show_running_tool_message() {
  self endon("_encstr_9B9815B329B8DAB776D82A93C0C09FD970E34B3B9B5027");
  var_0 = 0;

  for(;;) {
    var_1 = 500;
    var_2 = "_encstr_A52F20350867FE04C3E0198644C7B3659F8AA8DF893FF53D01EFE4DA779B1B1D4040" + var_0;
    waitframe();
    var_0 = var_0 + 0.05;
  }
}

create_box() {
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

    if(getdvarint("_encstr_A3C10D376CC9F536CDEB31DBF0D71E", 0) != 0) {
      var_0.box_x = getdvarint("_encstr_A3C10D376CC9F536CDEB31DBF0D71E", 0);
      var_7 = "_encstr_8419040B1D10" + var_0.box_x;
    } else
      var_7 = "_encstr_8419040B1D10" + var_0.box_x;

    var_6 = var_6 + 25;

    if(getdvarint("_encstr_8FC10DBB0F58195F6E36C21AFA50EF", 0) != 0) {
      var_0.box_x = getdvarint("_encstr_8FC10DBB0F58195F6E36C21AFA50EF", 0);
      var_7 = "_encstr_881904951D10" + var_0.box_y;
    } else
      var_7 = "_encstr_881904951D10" + var_0.box_y;

    var_6 = var_6 + 25;

    if(getdvarint("_encstr_A1C10D9E4BE3C6F7EAC95030D3899D", 0) != 0) {
      var_0.box_x = getdvarint("_encstr_A1C10D9E4BE3C6F7EAC95030D3899D", 0);
      var_7 = "_encstr_B21904B47408" + var_0.box_z;
    } else
      var_7 = "_encstr_B21904B47408" + var_0.box_z;

    var_6 = var_6 + 25;
    var_7 = "_encstr_A7AD1298F6C658475AED378089B7D8D656238E10" + var_0.freeze_location;
    var_6 = var_6 + 25;

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

place_path_nodes_within_radius(var_0) {
  level notify("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_996B14774302383678C52DF0292A70B928DB38F5ADD6");
  var_1 = debugdata();
  var_1.player = var_0;
  var_0 notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_97410B23BD6B976233901AF2F8");
  var_0 notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_B4C60AD707B2BDC0E6CE1309");

  for(;;) {
    reset_path_node_placement_for_radius();
    var_0 waittill("_encstr_AB19049D0FC0");
    open_and_write_to_paths_map();
    var_1.starting_pos = var_0.origin;
    create_cover_nodes_from_grid_points();
  }
}

place_path_nodes(var_0) {
  level notify("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = debugdata();
  var_1.player = var_0;
  var_1.starting_pos = var_0.origin;
  reset_path_node_placement();
  open_and_write_to_paths_map();
  var_1.aa_status = "_encstr_A3B1098265A3431C4073E7";
  var_1 childthread show_running_tool_message();
  create_cover_nodes_from_grid_points();
  var_1 notify("_encstr_9B9815B329B8DAB776D82A93C0C09FD970E34B3B9B5027");
  close_map_write();
}

clean_up_nodes() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_996B14774302383678C52DF0292A70B928DB38F5ADD6");
  var_0 = debugdata();
  reset_path_node_placement();
  open_and_write_to_paths_map();
  var_0.aa_status = "_encstr_A3B1098265A3431C4073E7";
  var_0.use_bsp_nodes = 0;
  var_0.file_path = level.script + "_encstr_92C218D76E8D275A1CE8EB0E0B8E0DE6FA1BB12B169BC56B2C83";
  var_0 childthread show_running_tool_message();
  var_1 = getallnodes();
  var_2 = var_1;

  if(getdvarint("_encstr_91DF134661CE494FD7B7FE385521ABF7230F729908", 1) && isDefined(level.path_node_table) && tableexists(level.path_node_table)) {
    var_3 = level.path_node_table;
    var_4 = 0;

    for(;;) {
      var_5 = tablelookupbyrow(var_3, var_4, 0);

      if(var_5 == "_encstr_B40101") {
        break;
      }

      var_6 = strtok(tablelookupbyrow(var_3, var_4, 2), "_encstr_974C0246");
      var_7 = (float(var_6[0]), float(var_6[1]), float(var_6[2]));
      var_8 = strtok(tablelookupbyrow(var_3, var_4, 3), "_encstr_974C0246");
      var_9 = (float(var_8[0]), float(var_8[1]), float(var_8[2]));
      var_10 = 16;
      var_11 = getdvarint("_encstr_A62B1C8AE6BDA90388D8E7B37940F7E27B1016C55DC3F2777358FB2730DB");

      if(var_11 != 0)
        var_10 = var_11;

      var_12 = var_10 * var_10;
      var_0.origin = var_7;
      var_0.angles = var_9;
      var_13 = strtok(tablelookupbyrow(var_3, var_4, 4), "_encstr_974C0246");
      var_13 = (float(var_13[0]), float(var_13[1]), float(var_13[2]));
      var_14 = strtok(tablelookupbyrow(var_3, var_4, 5), "_encstr_974C0246");
      var_14 = (float(var_14[0]), float(var_14[1]), float(var_14[2]));
      var_0 translate_position_with_offset_data(var_13, var_14);
      var_15 = getgroundposition(var_0.origin, 1);
      var_0.origin = var_15;

      if(isDefined(var_5)) {
        if(node_passes_nav_and_geo_validation()) {
          var_0.origin = var_7;
          var_0.angles = var_9;
          var_0.node_type = var_5;
          write_struct_to_map();
        }
      }

      var_4++;
    }
  } else {
    var_16 = 0;

    while(var_2.size > 1) {
      var_17 = var_2[0];
      var_2 = scripts\engine\utility::array_remove_index(var_2, 0, 0);
      var_15 = getgroundposition(var_17.origin, 16);
      var_0.origin = var_15;
      var_0.angles = var_17.angles;

      if(node_passes_nav_and_geo_validation(1)) {
        if(isDefined(var_17.type)) {
          switch (var_17.type) {
            case "_encstr_A7760B6710A315533959DF17AD":
              var_0.node_type = "_encstr_8DF110C807DC190F9A7DA4251271A1C10683";
              write_struct_to_map();
              break;
            case "_encstr_86A30C90489C3F32B21DA9AF0178":
              var_0.node_type = "_encstr_838E11806DF27B46CB1F28B843DF3BBB2A5405";
              write_struct_to_map();
              break;
            case "_encstr_87AB0D4BD7B857DB077503DA9B8EEB":
              var_0.node_type = "_encstr_AFB91285F0387DE1BED7DB6F1548EAA2B81B7E8C";
              write_struct_to_map();
              break;
            case "_encstr_8E2508511EE07BE6B246":
              var_0.node_type = "_encstr_81D70DCDED23B2F556E183DB9BB28C";
              write_struct_to_map();
              break;
            case "_encstr_AD5E0FA21E83DBE6AC2304D0E4DB5DD843":
              var_0.node_type = "_encstr_93460F52DBA34A1AF0CFD1FE3A32CB2E6B";
              write_struct_to_map();
              break;
            case "_encstr_854714E37F10FF63BFDD9B32636643E641DB764CE7F0":
              var_0.node_type = "_encstr_9A661945EFE95369416A64FBBBE791E38F27BB983FFBDBCDB315CF";
              write_struct_to_map();
              break;
            default:
              break;
          }
        }

        var_18 = [];
        var_19 = getnodesinradius(var_0.origin, 16, 0, 32);
        var_2 = scripts\engine\utility::array_remove_array(var_2, var_19);
      }

      var_16++;

      if(var_16 % 100)
        waitframe();
    }
  }

  var_0 notify("_encstr_9B9815B329B8DAB776D82A93C0C09FD970E34B3B9B5027");
  close_map_write();
  reset_path_node_placement();
}

translate_position_with_offset_data(var_0, var_1) {
  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = (0, 0, 0);

  if(isDefined(self.angles))
    var_3 = self.angles;
  else
    var_3 = (0, 0, 0);

  var_4 = self.origin;
  var_5 = anglesToForward(var_3);
  self.origin = var_0 + rotatevector(var_4, var_2);
  var_6 = vectortoangles(rotatevector(var_5, var_2));
  self.angles = var_6;
}

node_passes_nav_and_geo_validation(var_0) {
  var_1 = debugdata();

  if(distancesquared(getclosestpointonnavmesh(var_1.origin), var_1.origin) >= 1024)
    return 0;
  else if(!can_spawn_capsule_trace(var_1.origin))
    return 0;
  else if(!istrue(var_0)) {
    var_2 = getnodesinradius(var_1.origin, 16, 0, 64);

    if(var_2.size < 1) {
      return 1;
      return;
    }

    return 0;
    return;
  } else
    return 1;
}

remove_similar_nodes(var_0) {
  level notify("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_8CCA11B8212B8A0740FA79B40A17A00713BD68");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_996B14774302383678C52DF0292A70B928DB38F5ADD6");
  var_1 = 100;
  var_2 = getdvarint("_encstr_A62B1C8AE6BDA90388D8E7B37940F7E27B1016C55DC3F2777358FB2730DB");

  if(var_2 != 0)
    var_1 = var_2;

  var_3 = var_1 * var_1;
  var_4 = debugdata();
  var_4.player = var_0;
  reset_path_node_placement();
  open_and_write_to_paths_map();
  var_4.aa_status = "_encstr_A3B1098265A3431C4073E7";
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
        } else
          var_5[var_6] = undefined;
      } else
        var_5[var_6] = undefined;
    }
  }

  level thread close_map_write();
}

similar_nodes_nearby() {
  var_0 = debugdata();
  var_1 = 100;
  var_2 = var_1 * var_1;

  if(var_0.use_bsp_nodes) {
    var_3 = getallnodes();

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = var_3[var_4];

      if(isDefined(var_5)) {
        if(var_0.origin == var_5.origin)
          return 0;

        var_6 = distancesquared(var_5.origin, var_0.origin);

        if(var_6 <= var_2) {
          if(var_5.angles == var_0.angles)
            return 0;
        }
      }
    }
  }

  var_3 = level.path_node_debug_info.all_node_positions;

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(isDefined(var_5)) {
      if(var_0.origin == var_5.origin)
        return 0;

      var_6 = distancesquared(var_0.origin, var_5.origin);

      if(var_6 <= var_2) {
        if(var_5.angles == var_0.angles)
          return 0;
      }
    }
  }

  return 1;
}

get_node_type_from_type(var_0) {
  switch (var_0.type) {
    case "_encstr_87AB0D4BD7B857DB077503DA9B8EEB":
      return "_encstr_AFB91285F0387DE1BED7DB6F1548EAA2B81B7E8C";
    case "_encstr_A7760B6710A315533959DF17AD":
      return "_encstr_8DF110C807DC190F9A7DA4251271A1C10683";
    case "_encstr_86A30C90489C3F32B21DA9AF0178":
      return "_encstr_838E11806DF27B46CB1F28B843DF3BBB2A5405";
    case "_encstr_AFFF0C6E8FE899DDE6174B068510":
      return "_encstr_B1B0116DDFB780082F6A5B21A307D6C00E26F1";
    case "_encstr_82C00E35AA83E5C0460DB1D95FFA303D":
      return "_encstr_81D70DCDED23B2F556E183DB9BB28C";
  }

  return undefined;
}

get_raw_or_devraw_subdir() {
  return "_encstr_8419044EB0BB";
}

get_gamemode_subdir() {
  return "_encstr_850703B7D9";
}

close_map_write() {
  var_0 = debugdata();

  if(scripts\engine\utility::flag("_encstr_86D30C891C2460E0A29BABB5E73A")) {
    scripts\engine\utility::flag_clear("_encstr_86D30C891C2460E0A29BABB5E73A");
    var_1 = var_0.file_path;
    var_2 = get_raw_or_devraw_subdir();
    var_3 = get_gamemode_subdir();
    var_4 = "_encstr_9A230D97B5B007FA6EB7D54E362B79" + var_1;
    var_5 = 1;
    scripts\engine\utility:: fileprint_launcher_end_file( var_4, var_5 );
      level notify("_encstr_996B14774302383678C52DF0292A70B928DB38F5ADD6");
  }

  if(getdvarint("_encstr_B2D114AFC0FB1EEB4F5E1BC0FB40B9EEFFF04FC0DBE1", 0))
    level thread debug_node_array(var_0.all_node_positions);
}

create_cover_nodes_within_volume() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = debugdata();
  var_0.aa_status = "_encstr_B8F41E48730F9BD3C706DCD8E3375B6B3249B8A0AAA7AF2B8723D345F10FCD0F";
  var_0.grid_points_found = 1;
  var_0.increase_y = 1;

  while(var_0.grid_points_found) {
    var_0.num_fails = 0;

    for(var_1 = 0; var_1 < var_0.origin_max_dirs; var_1++) {
      var_0.origin_counter = var_1;
      get_next_volume_origin();

      if(vol_validate_grid_pos()) {
        var_0.angles = (0, 0, 0);
        var_0.node_type = "_encstr_85940E5A366D1AE01B616F7B2013AB93";
        var_0.origin = var_0.grid_origin;
        var_0.classname = "_encstr_81D70DCDED23B2F556E183DB9BB28C";
        vol_create_cover_nodes_from_grid_point();
      }
    }

    create_grid_point_in_volume();
  }

  iprintlnbold("_encstr_A692177E9277C901B7F689784A4F614587256F511D5B3179CE" + var_0.all_node_positions.size + "_encstr_B6180A101A3959C2A3563271");
}

vol_create_cover_nodes_from_grid_point() {
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
      var_0.node_type = "_encstr_81D70DCDED23B2F556E183DB9BB28C";
      run_path_node_removal();
    }
  }
}

create_cover_nodes_from_grid_points() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_91A01295CD8C7D9DE4A546BE8D27592C8EA5F6B9");
  var_0 = debugdata();
  var_0.aa_status = "_encstr_B8F41E48730F9BD3C706DCD8E3375B6B3249B8A0AAA7AF2B8723D345F10FCD0F";
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
          var_0.classname = "_encstr_81D70DCDED23B2F556E183DB9BB28C";
          create_cover_nodes_from_grid_point();
        }
      }
    }
  }

  iprintlnbold("_encstr_A692177E9277C901B7F689784A4F614587256F511D5B3179CE" + var_0.all_node_positions.size + "_encstr_B6180A101A3959C2A3563271");
}

create_grid_point_in_volume() {
  var_0 = debugdata();

  if(var_0.increase_x)
    vol_increase_x_coordinate();
  else if(var_0.increase_y) {
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
    level notify("_encstr_91A01295CD8C7D9DE4A546BE8D27592C8EA5F6B9");
  }
}

create_grid_point() {
  var_0 = debugdata();
  var_1 = 0;

  if(!increase_y_coordinate()) {
    var_1++;

    if(increase_x_coordinate())
      var_0.y = 1;
    else
      var_1++;
  }

  if(var_1 >= 2) {
    var_0.grid_points_found = 0;
    level notify("_encstr_91A01295CD8C7D9DE4A546BE8D27592C8EA5F6B9");
  }
}

create_grid_point_new() {
  var_0 = debugdata();

  if(var_0.dir_fails >= var_0.max_dir_fails) {
    var_0.grid_points_found = 0;
    level notify("_encstr_91A01295CD8C7D9DE4A546BE8D27592C8EA5F6B9");
  } else {
    var_1 = 0;

    if(isDefined(var_0.max_y)) {
      if(var_0.y > var_0.max_y)
        var_1++;
    }

    if(isDefined(var_0.max_x)) {
      if(var_0.x > var_0.max_x)
        var_1++;
    }

    if(var_1 >= 2) {
      var_0.grid_points_found = 0;
      level notify("_encstr_91A01295CD8C7D9DE4A546BE8D27592C8EA5F6B9");
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
}

increase_y_coordinate_new() {
  var_0 = debugdata();

  if(isDefined(var_0.max_y)) {
    if(var_0.y < var_0.max_y) {
      var_0.y++;
      return 1;
    } else
      return 0;
  } else {
    var_0.y++;
    return 1;
  }
}

increase_x_coordinate_new() {
  var_0 = debugdata();

  if(isDefined(var_0.max_x)) {
    if(var_0.x < var_0.max_x) {
      var_0.x++;
      return 1;
    } else
      return 0;
  } else {
    var_0.x++;
    return 1;
  }
}

increase_x_coordinate() {
  var_0 = debugdata();

  if(var_0.x_dir_fails <= var_0.max_dir_fails) {
    if(isDefined(var_0.max_x)) {
      if(var_0.x < var_0.max_x) {
        var_0.x++;
        return 1;
      } else
        return 0;
    } else {
      var_0.x++;
      return 1;
    }
  } else
    return 0;
}

vol_increase_x_coordinate() {
  var_0 = debugdata();

  if(isDefined(var_0.max_x)) {
    if(var_0.x < var_0.max_x) {
      var_0.x++;
      return 1;
    } else {
      var_0.increase_x = 0;
      var_0.x_done = 1;
      return 0;
    }
  } else {
    var_0.x++;
    return 1;
  }
}

increase_y_coordinate() {
  var_0 = debugdata();

  if(var_0.y_dir_fails <= var_0.max_dir_fails) {
    if(isDefined(var_0.max_y)) {
      if(var_0.y < var_0.max_y) {
        var_0.y++;
        return 1;
      } else
        return 0;
    } else {
      var_0.y++;
      return 1;
    }
  } else
    return 0;
}

vol_increase_y_coordinate() {
  var_0 = debugdata();

  if(isDefined(var_0.max_y)) {
    if(var_0.y < var_0.max_y) {
      var_0.y++;
      return 1;
    } else {
      var_0.increase_y = 0;
      var_0.y_done = 1;
      return 0;
    }
  } else {
    var_0.y++;
    return 1;
  }
}

vol_increase_z_coordinate() {
  var_0 = debugdata();

  if(isDefined(var_0.max_z)) {
    if(var_0.z < var_0.max_z) {
      var_0.z++;
      return 1;
    } else {
      var_0.z_done = 1;
      return 0;
    }
  } else {
    var_0.z++;
    return 1;
  }
}

get_next_origin() {
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
        var_0.grid_origin = var_1 + (-1 * (var_2 * var_0.x_magnitude), var_3 * var_0.y_magnitude, var_4 * var_0.z_magnitude);
        break;
      case 2:
        var_0.grid_origin = var_1 + (-1 * (var_2 * var_0.x_magnitude), -1 * (var_3 * var_0.y_magnitude), var_4 * var_0.z_magnitude);
        break;
      case 3:
        var_0.grid_origin = var_1 + (-1 * (var_2 * var_0.x_magnitude), var_3 * var_0.y_magnitude, -1 * (var_4 * var_0.z_magnitude));
        break;
      case 4:
        var_0.grid_origin = var_1 + (-1 * (var_2 * var_0.x_magnitude), -1 * (var_3 * var_0.y_magnitude), -1 * (var_4 * var_0.z_magnitude));
        break;
      case 5:
        var_0.grid_origin = var_1 + (var_2 * var_0.x_magnitude, -1 * (var_3 * var_0.y_magnitude), var_4 * var_0.z_magnitude);
        break;
      case 6:
        var_0.grid_origin = var_1 + (var_2 * var_0.x_magnitude, -1 * (var_3 * var_0.y_magnitude), -1 * (var_4 * var_0.z_magnitude));
        break;
      case 7:
        var_0.grid_origin = var_1 + (var_2 * var_0.x_magnitude, var_3 * var_0.y_magnitude, -1 * (var_4 * var_0.z_magnitude));
        break;
    }
  }
}

get_next_volume_origin() {
  var_0 = debugdata();
  var_1 = var_0.starting_pos;
  var_2 = var_0.x;
  var_3 = var_0.y;
  var_4 = var_0.z;
  var_5 = var_0.box_angles;
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = anglestoup(var_5);
  var_9 = var_6 * (var_2 * var_0.x_magnitude);
  var_10 = var_7 * (var_3 * var_0.y_magnitude);
  var_11 = var_8 * (var_4 * var_0.z_magnitude);

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

vol_validate_grid_pos() {
  var_0 = debugdata();
  var_1 = getclosestpointonnavmesh(var_0.grid_origin);

  if(distancesquared(var_1, var_0.grid_origin) <= var_0.max_nav_offset) {
    var_0.grid_origin = scripts\engine\utility::drop_to_ground(var_1, 96, -300);
    var_0.origin = var_0.grid_origin + (0, 0, 16);
    var_0.last_x = var_0.x;
    var_0.last_y = var_0.y;
    return 1;
  } else
    return 0;
}

validate_grid_pos() {
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
  } else {
    var_0.dir_fails++;

    if(var_0.last_x != var_0.x)
      var_0.x_dir_fails++;

    if(var_0.last_y != var_0.y)
      var_0.y_dir_fails++;

    return 0;
  }
}

create_cover_nodes_from_single_grid_point() {
  var_0 = debugdata();
  var_0.should_create_exposed_node = 1;

  for(var_1 = 0; var_1 <= var_0.node_creation_traces; var_1++) {
    var_0.node_creation_trace_index = var_1;
    create_and_validate_node_from_single_grid_point();
  }
}

create_cover_nodes_from_grid_point() {
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
      var_0.node_type = "_encstr_81D70DCDED23B2F556E183DB9BB28C";
      run_path_node_removal();
    }
  }
}

vol_create_and_validate_node() {
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

  if(isDefined(var_9["_encstr_BD260953AA97E3F014279D"]) && isDefined(var_9["_encstr_A53009A25003666B9818C6"]) && var_9["_encstr_A53009A25003666B9818C6"] < 1) {
    var_0.should_create_exposed_node = 0;

    if(isDefined(var_9["_encstr_820E07FAE8780B3A4C"])) {
      var_10 = vectordot(var_9["_encstr_820E07FAE8780B3A4C"], (0, 0, 1));
      var_0.origin = var_9["_encstr_BD260953AA97E3F014279D"];
      var_0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var_9["_encstr_820E07FAE8780B3A4C"])[1]), 0);

      if(-0.1 > var_10 || var_10 > 0.1)
        return;
    }

    var_11 = getclosestpointonnavmesh(var_9["_encstr_BD260953AA97E3F014279D"]);

    if(distancesquared(var_9["_encstr_BD260953AA97E3F014279D"], var_11) <= var_0.max_nav_offset) {
      var_0.should_create_exposed_node = 0;
      var_0.origin = scripts\engine\utility::drop_to_ground(var_11, 96, -300) + (0, 0, 16);
      var_0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var_9["_encstr_820E07FAE8780B3A4C"])[1]), 0);
      reposition_cover_node();
    }
  }
}

create_and_validate_node_from_single_grid_point() {
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

  if(isDefined(var_9["_encstr_820E07FAE8780B3A4C"])) {
    var_10 = vectordot(var_9["_encstr_820E07FAE8780B3A4C"], (0, 0, 1));

    if(-0.1 > var_10 || var_10 > 0.1)
      return;
  }

  var_11 = getclosestpointonnavmesh(var_9["_encstr_BD260953AA97E3F014279D"]);

  if(distancesquared(var_9["_encstr_BD260953AA97E3F014279D"], var_11) <= var_0.max_nav_offset) {
    var_0.should_create_exposed_node = 0;
    var_0.node_type = "_encstr_85940E5A366D1AE01B616F7B2013AB93";
    var_0.origin = scripts\engine\utility::drop_to_ground(var_11, 12, -300) + (0, 0, 16);
    var_0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var_9["_encstr_820E07FAE8780B3A4C"])[1]), 0);
    write_struct_to_map();
    var_0.total_grid_points++;
    reposition_cover_node();
  } else {
    var_0.node_type = "_encstr_85940E5A366D1AE01B616F7B2013AB93";
    var_0.angles = (0, 0, 0);
    var_0.origin = var_9["_encstr_BD260953AA97E3F014279D"];
    write_struct_to_map();
  }
}

create_and_validate_node() {
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

  if(isDefined(var_9["_encstr_BD260953AA97E3F014279D"]) && isDefined(var_9["_encstr_A53009A25003666B9818C6"]) && var_9["_encstr_A53009A25003666B9818C6"] < 1) {
    var_0.should_create_exposed_node = 0;

    if(isDefined(var_9["_encstr_820E07FAE8780B3A4C"])) {
      var_10 = vectordot(var_9["_encstr_820E07FAE8780B3A4C"], (0, 0, 1));

      if(-0.1 > var_10 || var_10 > 0.1)
        return;
    }

    var_11 = getclosestpointonnavmesh(var_9["_encstr_BD260953AA97E3F014279D"]);

    if(distancesquared(var_9["_encstr_BD260953AA97E3F014279D"], var_11) <= var_0.max_nav_offset) {
      var_0.origin = scripts\engine\utility::drop_to_ground(var_11, 12, -300) + (0, 0, 16);
      var_0.angles = (0, scripts\engine\math::wrap(0, 359, 180 + vectortoangles(var_9["_encstr_820E07FAE8780B3A4C"])[1]), 0);
      reposition_cover_node();
    }
  }
}

create_node_trace(var_0, var_1, var_2) {
  var_3 = debugdata();
  attempt_throttle();
  var_3.traces_count++;
  var_4 = scripts\engine\trace::ray_trace(var_0, var_1, level.players, var_3.trace_contents);

  if(var_3.save_trace_data) {
    if(isDefined(var_4["_encstr_BD260953AA97E3F014279D"])) {
      if(!isDefined(var_2))
        var_2 = (1, 1, 1);

      var_3.temp_trace_data[var_3.temp_trace_data.size] = var_4["_encstr_BD260953AA97E3F014279D"];
      var_3.temp_trace_data_colors[var_3.temp_trace_data_colors.size] = var_2;
      var_3.temp_trace_data[var_3.temp_trace_data.size] = var_1;
      var_3.temp_trace_data_colors[var_3.temp_trace_data_colors.size] = (0, 0, 0);
    }
  }

  return scripts\engine\trace::ray_trace(var_0, var_1, level.players, var_3.trace_contents);
}

debug_node_array(var_0) {
  level notify("_encstr_BE1F114C85966857092578391D6F8FCBAEAB2F");
  level endon("_encstr_BE1F114C85966857092578391D6F8FCBAEAB2F");
  var_1 = debugdata();

  for(;;) {
    level waittill("_encstr_87BC12F369881A5B20B9BB83810BBFD7F02D8D6F");

    if(isDefined(var_1.trace_data[getdvarint("_encstr_818C1232954CD576EBDC3693B407E8EBDCB78C59", 0)])) {
      var_2 = var_1.trace_data[getdvarint("_encstr_818C1232954CD576EBDC3693B407E8EBDCB78C59", 0)];

      foreach(var_6, var_4 in var_2) {
        var_5 = var_1.trace_data_colors[getdvarint("_encstr_818C1232954CD576EBDC3693B407E8EBDCB78C59", 0)][var_6];
        level thread draw_line_until_endons(var_4, var_5[0], var_5[1], var_5[2], ["_encstr_87BC12F369881A5B20B9BB83810BBFD7F02D8D6F"]);

        if(var_6 % 100)
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
  level notify("_encstr_8649166DED9AF8C6DF334088BA2FF640B345F5BF9E05E805");
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

  if(getdvarint("_encstr_B2D114AFC0FB1EEB4F5E1BC0FB40B9EEFFF04FC0DBE1", 0)) {
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
      var_16 = var_1 + var_15 * (var_13 * 32);

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

            if(position_near_other_nodes(var_20["_encstr_BD260953AA97E3F014279D"])) {
              var_8 = scripts\engine\utility::array_remove(var_8, var_15);
              break;
            }

            if(var_15 == var_4) {
              if(!var_0.found_left_edge && var_0.edge_placement) {
                if(edge_point_valid(var_19, var_15, var_5)) {
                  var_0.found_left_edge = 1;
                  var_9 = scripts\engine\utility::drop_to_ground(var_20["_encstr_BD260953AA97E3F014279D"], 12, -300);
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                } else {
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                }
              }
            } else if(!var_0.found_right_edge && var_0.edge_placement) {
              if(edge_point_valid(var_19, var_15, var_5)) {
                var_0.found_right_edge = 1;
                var_10 = scripts\engine\utility::drop_to_ground(var_20["_encstr_BD260953AA97E3F014279D"], 12, -300);
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

      var_21 = create_node_trace(var_17["_encstr_BD260953AA97E3F014279D"] + var_7 * 28, var_17["_encstr_BD260953AA97E3F014279D"] + var_5 * var_0.valid_forward_dist + var_7 * 28, (1, 0, 1));

      if(!var_0.found_up_edge && !trace_result_hits_surface(var_21) && !position_near_other_nodes(var_21["_encstr_BD260953AA97E3F014279D"]) && up_point_valid(var_17["_encstr_BD260953AA97E3F014279D"] + -1 * var_5, [var_4, var_3], var_5, var_7)) {
        var_0.found_up_edge = 1;
        var_0.should_create_exposed_node = 0;
        var_11 = scripts\engine\utility::drop_to_ground(var_17["_encstr_BD260953AA97E3F014279D"], 12, -300);
      }
    }
  }

  level notify("_encstr_ACD81966A5B92D37432B19F52756077B375A8E4BDBCD7DDCB78C95");

  if(isDefined(var_9) && var_0.found_left_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_9 + var_6 * 17 + -1 * (var_4 * 16), 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_0.origin = var_22;
      var_16 = var_22 + var_7 * 24;
      var_20 = create_node_trace(var_16, var_16 + var_5 * var_0.valid_forward_dist, (1, 1, 0));

      if(trace_result_hits_surface(var_20))
        var_0.node_type = "_encstr_8DF110C807DC190F9A7DA4251271A1C10683";
      else
        var_0.node_type = "_encstr_AFB91285F0387DE1BED7DB6F1548EAA2B81B7E8C";

      run_path_node_removal();
    }
  }

  if(isDefined(var_10) && var_0.found_right_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_10 + var_6 * 17 + -1 * (var_3 * 16), 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_0.origin = var_22;
      var_16 = var_22 + var_7 * 24;
      var_20 = create_node_trace(var_16, var_16 + var_5 * 64, (1, 1, 0));

      if(trace_result_hits_surface(var_20))
        var_0.node_type = "_encstr_838E11806DF27B46CB1F28B843DF3BBB2A5405";
      else
        var_0.node_type = "_encstr_AFB91285F0387DE1BED7DB6F1548EAA2B81B7E8C";

      run_path_node_removal();
    }
  }

  if(isDefined(var_11) && var_0.found_up_edge && !var_0.found_right_edge && !var_0.found_left_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_11 + var_6 * 17, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_0.origin = var_22;
      var_0.node_type = "_encstr_AFB91285F0387DE1BED7DB6F1548EAA2B81B7E8C";
      run_path_node_removal();
    }
  }

  var_0.save_trace_data = 0;
}

simple_reposition_node() {
  if(!similar_nodes_nearby()) {
    return;
  }
  level notify("_encstr_8649166DED9AF8C6DF334088BA2FF640B345F5BF9E05E805");
  var_0 = debugdata();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = anglestoright(var_2);
  var_4 = anglestoleft(var_2);
  var_5 = anglesToForward(var_2);
  var_6 = -1 * anglesToForward(var_2);
  var_7 = anglestoup(var_2);

  if(scripts\engine\utility::is_equal(var_0.node_type, "_encstr_8DF110C807DC190F9A7DA4251271A1C10683"))
    var_8 = [var_4];
  else
    var_8 = [var_3];

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
  var_12 = var_0.valid_forward_dist;

  for(var_13 = 0; var_13 < 4; var_13++) {
    if(var_8.size < 1) {
      break;
    }

    for(var_14 = 0; var_14 < var_8.size; var_14++) {
      var_15 = var_8[var_14];
      var_16 = var_1 + var_15 * (var_13 * 32);

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

            if(var_15 == var_4) {
              if(!var_0.found_left_edge && var_0.edge_placement) {
                if(edge_point_valid(var_19, var_15, var_5)) {
                  var_0.found_left_edge = 1;
                  var_9 = scripts\engine\utility::drop_to_ground(var_20["_encstr_BD260953AA97E3F014279D"], 12, -300);
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                } else {
                  var_8 = scripts\engine\utility::array_remove(var_8, var_15);
                  break;
                }
              }
            } else if(!var_0.found_right_edge && var_0.edge_placement) {
              if(edge_point_valid(var_19, var_15, var_5)) {
                var_0.found_right_edge = 1;
                var_10 = scripts\engine\utility::drop_to_ground(var_20["_encstr_BD260953AA97E3F014279D"], 12, -300);
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

      var_21 = create_node_trace(var_17["_encstr_BD260953AA97E3F014279D"] + var_7 * 28, var_17["_encstr_BD260953AA97E3F014279D"] + var_5 * var_0.valid_forward_dist + var_7 * 28, (1, 0, 1));

      if(!var_0.found_up_edge && !trace_result_hits_surface(var_21) && up_point_valid(var_17["_encstr_BD260953AA97E3F014279D"] + -1 * var_5, [var_4, var_3], var_5, var_7)) {
        var_0.found_up_edge = 1;
        var_0.should_create_exposed_node = 0;
        var_11 = scripts\engine\utility::drop_to_ground(var_17["_encstr_BD260953AA97E3F014279D"], 12, -300);
      }
    }
  }

  level notify("_encstr_ACD81966A5B92D37432B19F52756077B375A8E4BDBCD7DDCB78C95");

  if(isDefined(var_9) && var_0.found_left_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_9 + var_6 * 17 + -1 * (var_4 * 16), 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_0.origin = var_22;
      var_16 = var_22 + var_7 * 24;
      var_20 = create_node_trace(var_16, var_16 + var_5 * var_0.valid_forward_dist, (1, 1, 0));

      if(trace_result_hits_surface(var_20))
        var_0.node_type = "_encstr_8DF110C807DC190F9A7DA4251271A1C10683";
      else
        var_0.node_type = "_encstr_AFB91285F0387DE1BED7DB6F1548EAA2B81B7E8C";

      run_path_node_removal();
    }
  }

  if(isDefined(var_10) && var_0.found_right_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_10 + var_6 * 17 + -1 * (var_3 * 16), 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_0.origin = var_22;
      var_16 = var_22 + var_7 * 24;
      var_20 = create_node_trace(var_16, var_16 + var_5 * 64, (1, 1, 0));

      if(trace_result_hits_surface(var_20))
        var_0.node_type = "_encstr_838E11806DF27B46CB1F28B843DF3BBB2A5405";
      else
        var_0.node_type = "_encstr_AFB91285F0387DE1BED7DB6F1548EAA2B81B7E8C";

      run_path_node_removal();
    }
  }

  if(isDefined(var_11) && var_0.found_up_edge && !var_0.found_right_edge && !var_0.found_left_edge) {
    var_22 = scripts\engine\utility::drop_to_ground(var_11 + var_6 * 17, 16, -300) + (0, 0, 16);

    if(can_spawn_capsule_trace(var_22) && !trace_for_stairs()) {
      var_0.origin = var_22;
      var_0.node_type = "_encstr_AFB91285F0387DE1BED7DB6F1548EAA2B81B7E8C";
      run_path_node_removal();
    }
  }

  var_0.save_trace_data = 0;
}

find_final_position(var_0) {}

trace_for_stairs() {
  return 0;
}

edge_point_valid(var_0, var_1, var_2) {
  var_3 = debugdata();

  for(var_4 = 32; var_4 > 0; var_4--) {
    var_5 = var_0 + -1 * var_1 * var_4;

    if(!can_spawn_capsule_trace(var_5)) {
      break;
    }

    var_6 = create_node_trace(var_5, var_5 + var_2 * 24, (0, 1, 0));

    if(trace_result_hits_surface(var_6))
      var_3.wall_units++;
  }

  if(var_3.wall_units >= var_3.wall_units_required) {
    for(var_7 = 32; var_7 > 0; var_7--) {
      var_5 = var_0 + var_1 * var_7;

      if(!can_spawn_capsule_trace(var_5))
        return 0;

      var_6 = create_node_trace(var_5, var_5 + var_2 * var_3.valid_forward_dist, (0, 1, 0));

      if(trace_result_hits_surface(var_6))
        return 0;
    }

    return 1;
  } else
    return 0;
}

up_point_valid(var_0, var_1, var_2, var_3) {
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
      } else
        continue;
    }
  }

  var_5 = var_1;
  var_4.wall_units = 0;

  for(var_7 = 32; var_7 > 0; var_7--) {
    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_8 = var_5[var_6];
      var_9 = var_0 + var_8 * var_7 + var_3 * 28;
      var_10 = create_node_trace(var_9, var_9 + var_2 * var_4.valid_forward_dist, (0, 1, 0));

      if(trace_result_hits_surface(var_10))
        continue;
      else
        var_4.wall_units++;
    }
  }

  if(var_4.wall_units >= var_4.wall_units_required)
    return 1;
  else
    return 0;
}

attempt_throttle() {
  var_0 = debugdata();
  var_0.throttle_counter++;

  if(var_0.throttle_counter >= var_0.create_node_throttle) {
    var_0.throttle_counter = 0;
    waitframe();
  }
}

trace_result_hits_surface(var_0, var_1) {
  var_2 = debugdata();

  if(isDefined(var_0["_encstr_BD260953AA97E3F014279D"]) && isDefined(var_0["_encstr_A53009A25003666B9818C6"]) && var_0["_encstr_A53009A25003666B9818C6"] < 1 && var_0["_encstr_A53009A25003666B9818C6"] > 0) {
    if(isDefined(var_1)) {
      if(isDefined(var_0["_encstr_820E07FAE8780B3A4C"])) {
        if(var_1 == var_0["_encstr_820E07FAE8780B3A4C"])
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
  var_0 = debugdata();

  if(!scripts\engine\utility::flag("_encstr_86D30C891C2460E0A29BABB5E73A")) {
    scripts\engine\utility::flag_set("_encstr_86D30C891C2460E0A29BABB5E73A");
    var_0.aa_status = "_encstr_831E144F01F552AE805E357D11B8FB8955BF2FF7F327";
    scripts\engine\utility:: fileprint_launcher_start_file();
      var_1 = "_encstr_844C0242";
    var_2 = 0;
    scripts\engine\utility:: fileprint_launcher( "_encstr_ADE909A3CF5D33A0AECFD7" );
      scripts\engine\utility:: fileprint_launcher( var_1 + "_encstr_AB8A0812887DEF539819" + var_2 );
      scripts\engine\utility:: fileprint_launcher( "_encstr_884C02BD" );
      scripts\engine\utility:: fileprint_launcher( var_1 + "_encstr_8FBF192E613997CA80FD495DF35246D2DC98A352290E0B8648D502" );
      scripts\engine\utility:: fileprint_launcher( "_encstr_8A4C025F" );
  }
}

draw_closest_wall_points(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_A582196F4EBB0BDFE9E82F5788C3CC313F6FF5E5A0C1C22190D047");
  level endon("_encstr_A582196F4EBB0BDFE9E82F5788C3CC313F6FF5E5A0C1C22190D047");
  var_0 endon("_encstr_AB19049D0FC0");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = debugdata();

  for(;;) {
    var_0 notify("_encstr_9AE711B8BF5B89C9E9CBBF31E50131F0BE5728");
    var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_1, undefined, 50);

    foreach(var_5 in var_3) {}

    wait 1;
  }
}

run_path_node_removal() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4461547676B970D4E0E2753B9FA6EB0BF0B980302F366");
  var_0 = debugdata();

  if(!position_near_other_nodes(var_0.origin)) {
    var_1 = spawnStruct();
    var_1.angles = var_0.angles;
    var_1.origin = var_0.origin;
    var_0.all_node_positions[var_0.all_node_positions.size] = var_1;

    if(getdvarint("_encstr_B2D114AFC0FB1EEB4F5E1BC0FB40B9EEFFF04FC0DBE1", 0)) {
      var_0.trace_data[var_0.map_ent_index] = var_0.temp_trace_data;
      var_0.trace_data_colors[var_0.map_ent_index] = var_0.temp_trace_data_colors;
    }

    var_0.should_create_exposed_node = 0;
    write_struct_to_map();

    if(istrue(var_0.debug_boxes))
      return;
  }
}

position_near_other_nodes(var_0) {
  var_1 = debugdata();
  var_1.density_cap_count = 0;

  if(var_1.use_bsp_nodes) {
    var_2 = getallnodes();

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];

      if(var_4.origin == var_0)
        return 1;

      var_5 = distancesquared(var_0, var_4.origin);

      if(var_5 <= 576)
        return 1;
    }
  }

  var_6 = var_1.all_node_positions;

  for(var_3 = 0; var_3 < var_6.size; var_3++) {
    var_7 = var_6[var_3];

    if(var_7.origin == var_0)
      return 1;

    var_5 = distancesquared(var_0, var_7.origin);

    if(var_5 <= 256)
      return 1;

    if(var_5 <= var_1.density_radius) {
      var_1.density_cap_count++;

      if(var_1.density_cap_count >= var_1.density_cap)
        return 1;
    }
  }

  return 0;
}

write_struct_to_map() {
  var_0 = debugdata();
  var_1 = "_encstr_844C0242";
  scripts\engine\utility:: fileprint_launcher( "_encstr_AB8A0812887DEF539819" + var_0.map_ent_index );
    scripts\engine\utility:: fileprint_launcher( "_encstr_884C02BD" );
    scripts\engine\utility:: fileprint_launcher( var_1 + "_encstr_82BD0BA13D9AA05C624345499A" + var_0.origin[0] + "_encstr_974C0246" + var_0.origin[1] + "_encstr_974C0246" + var_0.origin[2] + "_encstr_814C02E9" );

    if(isDefined(var_0.node_type))
      scripts\engine\utility:: fileprint_launcher( var_1 + "_encstr_B8640E5EB9B0B1FB7E1D3F07638E96AA" + var_0.node_type + "_encstr_814C02E9" );
      else
        scripts\engine\utility:: fileprint_launcher( var_1 + "_encstr_A3C91E7E3169E7BAF0AD19ED43829622802892B21EB6A7B368BD2FE46B88CB7A" );

        if(isDefined(var_0.angles))
          scripts\engine\utility:: fileprint_launcher( var_1 + "_encstr_B43E0B9631687FD2BDEF8A7AB5" + var_0.angles[0] + "_encstr_974C0246" + var_0.angles[1] + "_encstr_974C0246" + var_0.angles[2] + "_encstr_814C02E9" );
          else
            scripts\engine\utility:: fileprint_launcher( var_1 + "_encstr_ACD8112285B9ECC62B9B880222030281020C44" );

            scripts\engine\utility:: fileprint_launcher( "_encstr_8A4C025F" );
            var_0.map_ent_index++;
}

draw_line_until_endons(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_AD75063D571AE108");
  var_5 = debugdata();

  if(isDefined(var_4)) {
    if(isarray(var_4)) {
      foreach(var_7 in var_4)
      self endon(var_7);
    } else
      self endon(var_4);
  }

  for(;;)
    waitframe();
}

addentrytodevgui(var_0) {
  level thread addentrytodevgui_internal(var_0);
}

addentrytodevgui_internal(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5;
  var_1 = "_encstr_B40101";
  var_2 = strtok(var_0, "_encstr_874C029E");
  var_3 = "_encstr_974C0246";
  var_4 = 0;

  foreach(var_6 in var_2) {
    var_7 = strtok(var_6, "_encstr_974C0246");
    var_8 = 1;
    var_9 = var_7.size;

    foreach(var_11 in var_7) {
      if(var_8 < var_9)
        var_1 = var_1 + var_11 + var_3;
      else
        var_1 = var_1 + var_11;

      var_8++;
    }

    var_4++;

    if(var_4 < var_2.size)
      var_1 = var_1 + "_encstr_874C029E";
  }
}

can_spawn_capsule_trace(var_0) {
  return scripts\engine\trace::capsule_trace_passed(var_0 + (0, 0, 32), var_0, 16, 32);
}