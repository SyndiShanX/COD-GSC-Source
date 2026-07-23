/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\264.gsc
**************************************/

#using_animtree("generic_human");

main(var_0) {
  if(!getdvarint("noder")) {
    return;
  }
  level.drone_paths = [];
  level.scr_anim["generic"]["node_cover_left"][0] = % cornercrl_reloada;
  level.scr_anim["generic"]["node_cover_left"][1] = % cornercrl_look_fast;
  level.scr_anim["generic"]["node_cover_left"][2] = % corner_standl_grenade_b;
  level.scr_anim["generic"]["node_cover_left"][3] = % corner_standl_flinch;
  level.scr_anim["generic"]["node_cover_left"][4] = % corner_standl_look_idle;
  level.scr_anim["generic"]["node_cover_left"][5] = % corner_standl_look_2_alert;
  level.scr_anim["generic"]["node_cover_right"][0] = % cornercrr_reloada;
  level.scr_anim["generic"]["node_cover_right"][1] = % corner_standr_grenade_b;
  level.scr_anim["generic"]["node_cover_right"][2] = % corner_standr_flinch;
  level.scr_anim["generic"]["node_cover_right"][3] = % corner_standr_look_idle;
  level.scr_anim["generic"]["node_cover_right"][4] = % corner_standr_look_2_alert;
  level.scr_anim["generic"]["node_cover_crouch"][0] = % covercrouch_hide_idle;
  level.scr_anim["generic"]["node_cover_crouch"][1] = % covercrouch_twitch_1;
  level.scr_anim["generic"]["node_cover_crouch"][2] = % covercrouch_hide_2_aim;
  level.scr_anim["generic"]["node_cover_crouch"][3] = % covercrouch_hide_2_aim;
  level.scr_anim["generic"]["node_cover_crouch"][4] = % covercrouch_hide_2_aim;
  level.scr_anim["generic"]["node_cover_crouch"][5] = % covercrouch_hide_look;
  level.scr_anim["generic"]["node_cover_crouch_window"][0] = % covercrouch_hide_idle;
  level.scr_anim["generic"]["node_cover_crouch_window"][1] = % covercrouch_twitch_1;
  level.scr_anim["generic"]["node_cover_crouch_window"][2] = % covercrouch_hide_2_aim;
  level.scr_anim["generic"]["node_cover_crouch_window"][3] = % covercrouch_hide_2_aim;
  level.scr_anim["generic"]["node_cover_crouch_window"][4] = % covercrouch_hide_2_aim;
  level.scr_anim["generic"]["node_cover_crouch_window"][5] = % covercrouch_hide_look;
  level.scr_anim["generic"]["node_cover_prone"][0] = % crouch_2_prone_firing;
  level.scr_anim["generic"]["node_cover_prone"][1] = % prone_2_crouch;
  level.scr_anim["generic"]["node_cover_prone"][2] = % prone_reload;
  level.scr_anim["generic"]["node_cover_stand"][0] = % coverstand_reloada;
  level.scr_anim["generic"]["node_concealment_crouch"][0] = % covercrouch_hide_idle;
  level.scr_anim["generic"]["node_concealment_crouch"][1] = % covercrouch_twitch_1;
  level.scr_anim["generic"]["node_concealment_crouch"][2] = % covercrouch_hide_2_aim;
  level.scr_anim["generic"]["node_concealment_crouch"][3] = % covercrouch_hide_2_aim;
  level.scr_anim["generic"]["node_concealment_crouch"][4] = % covercrouch_hide_2_aim;
  level.scr_anim["generic"]["node_concealment_crouch"][5] = % covercrouch_hide_look;
  level.scr_anim["generic"]["node_concealment_prone"][0] = % crouch_2_prone_firing;
  level.scr_anim["generic"]["node_concealment_prone"][1] = % prone_2_crouch;
  level.scr_anim["generic"]["node_concealment_prone"][2] = % prone_reload;
  level.scr_anim["generic"]["node_concealment_stand"][0] = % coverstand_reloada;
  level.node_offset = [];
  level.node_offset["node_cover_left"] = (0, 90, 0);
  level.node_offset["node_cover_right"] = (0, -90, 0);
  level.node_offset["node_pathnode"] = (0, 0, 0);
  level.node_offset["node_cover_crouch"] = (0, 0, 0);
  level.node_offset["node_cover_crouch_window"] = (0, 0, 0);
  level.node_offset["node_cover_prone"] = (0, 0, 0);
  level.node_offset["node_cover_stand"] = (0, 0, 0);
  level.node_offset["node_concealment_crouch"] = (0, 0, 0);
  level.node_offset["node_concealment_prone"] = (0, 0, 0);
  level.node_offset["node_concealment_stand"] = (0, 0, 0);
  level.noder_node_delete = 0;
  level.dronestruct = [];
  var_1 = getspawnerarray();
  level.dummyguy_index_max = 0;
  level.dummyguy = [];

  if(var_1.size) {
    var_2 = var_1[0];
    var_2 maps\_spawner::dronespawner_init();

    for(var_3 = 0; var_3 < 20; var_3++) {
      level.dummyguy[var_3] = maps\_spawner::spawner_dronespawn(var_2);
      level.dummyguy[var_3] notsolid();
      level.dummyguy[var_3] hide();
      level.dummyguy[var_3].dontdonotetracks = 1;
      level.dummyguy[var_3].dummyguyindex = var_3;
      level.dummynode[var_3] = spawn("script_origin", (0, 0, 0));
      level.dummynode[var_3].dummynode = 1;
      level.dummyguy_index_max++;
    }
  }

  level.dummyguy_index = 0;
  maps\_anim::init();
  var_4 = getEntArray();

  foreach(var_6 in var_4) {
    if(isDefined(var_6.classname) && var_6.classname == "player" || isDefined(var_6.dontdonotetracks) || isDefined(var_6.dummynode)) {
      continue;
    }
    if(isDefined(var_6)) {
      var_6 delete();
    }
  }

  var_4 = undefined;
  level.place_node_radius = 64;
  level.place_node_group = [];
  level.painter_startgroup = "node_pathnode";
  level.placed_nodes = [];
  level.noder_heightoffset = (0, 0, 32);
  level.wall_look = 0;
  level.node_grid = 256;
  level.coliding_node = undefined;
  level.node_select_locked = 0;
  level.node_animation_preview = 1;
  add_node_type("node_pathnode", undefined);
  add_node_type("node_cover_crouch");
  add_node_type("node_cover_crouch_window");
  add_node_type("node_cover_left", -1);
  add_node_type("node_cover_right", 1);
  add_node_type("node_cover_prone");
  add_node_type("node_cover_stand");
  add_node_type("node_concealment_crouch");
  add_node_type("node_concealment_prone");
  add_node_type("node_concealment_stand");
  thread hack_start();
  thread hud_init();
  thread noder_init();
  common_scripts\utility::flag_wait("user_hud_active");
  thread draw_selected_node_name();
  thread manage_nearnodes();
  level.drone_paths = [];
  var_8 = getallnodes();

  if(var_8.size) {
    level.player setOrigin(maps\_utility::getclosest(level.player.origin, var_8).origin);
  }
  for(;;) {
    wait 0.05;
    level.player_view_trace = player_view_trace();
    place_node_place(1);
  }
}

hack_start() {
  common_scripts\utility::flag_init("user_alive");

  while(!isDefined(get_mp_player())) {
    wait 0.05;
  }
  wait 0.05;
  level.noder_player = get_mp_player();
  level.noder_player takeallweapons();
  level.noder_player allowcrouch(0);
  level.noder_player allowjump(0);
  level.noder_player allowprone(0);
  common_scripts\utility::flag_set("user_alive");
}

noder_init() {
  level.preview_node = spawn("script_model", (0, 0, 0));
  precachemodel("node_preview");
  level.preview_node setModel("node_preview");
  level.preview_node notsolid();
  level.selector_model = spawn("script_model", (0, 0, 0));
  level.selector_model setModel("node_select");
  level.selector_model notsolid();
  level.selector_model hide();
  level.selected_node = undefined;
  setcurrentgroup(level.painter_startgroup);
  level.painter_startgroup = undefined;
  playerinit();
}

hud_update_placed_model_count() {
  level.hud_noder["helppm"].description setvalue(level.placed_nodes.size);
  var_0 = 256;

  if(level.placed_nodes.size < var_0) {
    level.hud_noder["helppm"].description.color = (1, 1, 1);
    return;
  }

  var_1 = 1;
  var_2 = 1 - (level.placed_nodes.size - var_0) / var_0;
  var_3 = var_2;
  level.hud_noder["helppm"].description.color = (var_1, var_2, var_3);
}

controler_hud_add(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 520;
  var_6 = 120;
  var_7 = 18;
  var_8 = 0.8;
  var_9 = 20;
  var_10 = 1.4;

  if(!isDefined(level.hud_noder) || !isDefined(level.hud_noder[var_0])) {
    level.hud_noder[var_0] = _newhudelem();
    var_11 = _newhudelem();
  } else {
    var_11 = level.hud_noder[var_0].description;
  }
  level.hud_noder[var_0].location = 0;
  level.hud_noder[var_0].alignx = "right";
  level.hud_noder[var_0].aligny = "middle";
  level.hud_noder[var_0].foreground = 1;
  level.hud_noder[var_0].fontscale = 1.5;
  level.hud_noder[var_0].sort = 20;
  level.hud_noder[var_0].alpha = var_8;
  level.hud_noder[var_0].x = var_5 + var_9;
  level.hud_noder[var_0].y = var_6 + var_1 * var_7;
  level.hud_noder[var_0] _settext(var_2);
  var_11.location = 0;
  var_11.alignx = "left";
  var_11.aligny = "middle";
  var_11.foreground = 1;
  var_11.fontscale = var_10;
  var_11.sort = 20;
  var_11.alpha = var_8;
  var_11.x = var_5 + var_9;
  var_11.y = var_6 + var_1 * var_7;

  if(isDefined(var_4)) {
    var_11 setvalue(var_4);
  }
  if(isDefined(var_3)) {
    var_11 _settext(var_3);
  }
  level.hud_noder[var_0].description = var_11;
}

hud_init() {
  common_scripts\utility::flag_init("user_hud_active");
  common_scripts\utility::flag_wait("user_alive");
  var_0 = 17;
  var_1 = [];
  var_2 = 15;
  var_3 = int(var_0 / 2);
  var_4 = 240 + var_3 * var_2;
  var_5 = 0.7 / var_3;
  var_6 = var_5;

  for(var_7 = 0; var_7 < var_0; var_7++) {
    var_1[var_7] = _newhudelem();
    var_1[var_7].location = 0;
    var_1[var_7].alignx = "left";
    var_1[var_7].aligny = "middle";
    var_1[var_7].foreground = 1;
    var_1[var_7].fontscale = 2;
    var_1[var_7].sort = 20;

    if(var_7 == var_3) {
      var_1[var_7].alpha = 1;
    } else {
      var_1[var_7].alpha = var_6;
    }
    var_1[var_7].x = 0;
    var_1[var_7].y = var_4;
    var_1[var_7] _settext(".");

    if(var_7 == var_3) {
      var_5 = var_5 * -1;
    }
    var_6 = var_6 + var_5;
    var_4 = var_4 - var_2;
  }

  level.group_hudelems = var_1;
  var_8 = _newhudelem();
  var_8.location = 0;
  var_8.alignx = "left";
  var_8.aligny = "bottom";
  var_8.foreground = 1;
  var_8.fontscale = 2;
  var_8.sort = 20;
  var_8.alpha = 1;
  var_8.x = 320;
  var_8.y = 244;
  var_8 _settext(".");
  level.crosshair = var_8;
  var_8 = _newhudelem();
  var_8.location = 0;
  var_8.alignx = "center";
  var_8.aligny = "bottom";
  var_8.foreground = 1;
  var_8.fontscale = 2;
  var_8.sort = 20;
  var_8.alpha = 0;
  var_8.x = 320;
  var_8.y = 244;
  var_8 setvalue(0);
  level.crosshair_value = var_8;
  var_9 = _newhudelem();
  var_9.location = 0;
  var_9.alignx = "center";
  var_9.aligny = "bottom";
  var_9.foreground = 1;
  var_9.fontscale = 2;
  var_9.sort = 20;
  var_9.alpha = 1;
  var_9.x = 320;
  var_9.y = 300;
  var_9 _settext("");
  level.selection_lock_indicator = var_9;
  var_10 = _newhudelem();
  var_10.location = 0;
  var_10.alignx = "center";
  var_10.aligny = "bottom";
  var_10.foreground = 1;
  var_10.fontscale = 2;
  var_10.sort = 20;
  var_10.alpha = 1;
  var_10.x = 320;
  var_10.y = 300;
  var_10 _settext("");
  level.node_animation_preview_indicator = var_10;
  var_11 = 550;
  var_12 = 120;
  var_13 = 18;
  var_14 = 1;
  var_15 = 0.8;
  var_16 = 20;
  var_17 = 1.4;
  controler_hud_add("helppm", 1, "^5Placed Nodes: ", undefined, level.placed_nodes.size);
  controler_hud_add("gridsize", 2, "^5Grid Size: ", undefined, level.node_grid);
  controler_hud_add("helpxy", 6, "^4X/^3Y: ", undefined, level.place_node_radius);
  controler_hud_add("helpab", 7, "^2A/^1B^7: ", "-");
  controler_hud_add("helplsrs", 8, "^8L^7/R Stick: ", "-");
  controler_hud_add("helplbrb", 9, "^8L^7/R Shoulder: ", "-");
  controler_hud_add("helpdpu", 10, "^8DPad U/^7D: ", "-");
  controler_hud_add("helpdpl", 11, "^8DPad L/^7R: ", "-");
  controler_hud_add("helpF", 17, "^8W: ", "-");
  level.hud_noder["helpF"].x = var_11 - 450;
  level.hud_noder["helpF"].description.x = var_11 - 450;
  hint_buttons_main();
  common_scripts\utility::flag_set("user_hud_active");
}

controler_hud_update_text(var_0, var_1) {
  level.hud_noder[var_0].description _settext(var_1);
}

controler_hud_update_button(var_0, var_1) {
  level.hud_noder[var_0] _settext(var_1);
}

setcurrentgroup(var_0) {
  common_scripts\utility::flag_wait("user_hud_active");
  level.place_node_current_group = var_0;
  var_1 = getarraykeys(level.place_node_group);
  var_2 = 0;
  var_3 = int(level.group_hudelems.size / 2);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_1[var_4] == var_0) {
      var_2 = var_4;
      break;
    }
  }

  for(var_4 = 0; var_4 < level.group_hudelems.size; var_4++) {
    level.group_hudelems[var_4] clearalltextafterhudelem();
  }
  level.group_hudelems[var_3] _settext("^3" + gettext_nonode(var_1[var_2]));

  for(var_4 = 1; var_4 < level.group_hudelems.size - var_3; var_4++) {
    if(var_2 - var_4 < 0) {
      level.group_hudelems[var_3 + var_4] _settext("-- --");
      continue;
    }

    level.group_hudelems[var_3 + var_4] _settext(gettext_nonode(var_1[var_2 - var_4]));
  }

  for(var_4 = 1; var_4 < level.group_hudelems.size - var_3; var_4++) {
    if(var_2 + var_4 > var_1.size - 1) {
      level.group_hudelems[var_3 - var_4] _settext("-- --");
      continue;
    }

    level.group_hudelems[var_3 - var_4] _settext(gettext_nonode(var_1[var_2 + var_4]));
  }

  var_0 = getcurrent_groupstruct();
  level.node_grid = var_0.grid_size;
  hud_update_gridsize();
}

setgroup_up() {
  var_0 = undefined;
  var_1 = getarraykeys(level.place_node_group);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level.place_node_current_group) {
      var_0 = var_2 + 1;
      break;
    }
  }

  if(var_0 == var_1.size) {
    var_0 = 0;
  }
  setcurrentgroup(var_1[var_0]);
}

setgroup_down() {
  var_0 = undefined;
  var_1 = getarraykeys(level.place_node_group);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level.place_node_current_group) {
      var_0 = var_2 - 1;
      break;
    }
  }

  if(var_0 < 0) {
    var_0 = var_1.size - 1;
  }
  setcurrentgroup(var_1[var_0]);
}

add_node_type(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  precachemodel(var_0);

  if(!isDefined(level.place_node_group[var_0])) {
    var_3 = spawnStruct();
    var_3.wall_snap_direction = var_1;
    var_3.grid_size = var_2;
    level.place_node_group[var_0] = var_3;
  }

  level.place_node_group[var_0].model = var_0;
}

playerinit() {
  level.noder_max = 950;
  common_scripts\utility::flag_wait("user_hud_active");
  level.noder_player takeallweapons();
  level.button_modifier_func = [];
  level.button_func = [];
  level.noder_player thread button_monitor();
  level.noder_player thread button_modifier();
  set_button_funcs_main();
  add_button_modifier_func(::set_button_funcs_quick_select, ::set_button_funcs_quick_select_release, "BUTTON_LSTICK");
}

button_modifier() {
  for(;;) {
    foreach(var_2, var_1 in level.button_modifier_func) {
      if(self buttonPressed(var_2)) {
        [[level.button_modifier_func[var_2]]]();

        while(self buttonPressed(var_2)) {
          wait 0.05;
        }
        [[level.button_modifier_release_func[var_2]]]();
        wait 0.05;
      }
    }

    wait 0.05;
  }
}

button_monitor() {
  for(;;) {
    foreach(var_2, var_1 in level.button_func) {
      if(self buttonPressed(var_2)) {
        [[level.button_func[var_2]]]();

        if(!level.button_func_isflow[var_2]) {
          while(self buttonPressed(var_2)) {
            wait 0.05;
          }
        }

        break;
      }
    }

    wait 0.05;
  }
}

add_button_func(var_0, var_1, var_2) {
  var_3 = [];
  level.button_func[var_2] = var_0;
  level.button_func_isflow[var_2] = var_1;
}

add_button_modifier_func(var_0, var_1, var_2) {
  level.button_modifier_func[var_2] = var_0;
  level.button_modifier_release_func[var_2] = var_1;
}

deleteme() {
  self delete();
}

getcurrent_groupstruct() {
  return level.place_node_group[level.place_node_current_group];
}

get_wall_offset(var_0) {
  var_1 = level.player_view_trace;
  var_2 = var_1["position"];
  var_3 = 16 * vectorNormalize(var_1["normal"]);
  var_4 = var_2 + var_3;
  var_5 = find_corner_snap(var_4, var_0);

  if(isDefined(var_5)) {
    var_4 = var_5;
  }
  return groundpos_loc(var_4) + level.noder_heightoffset;
}

find_corner_snap(var_0, var_1) {
  var_2 = getcurrent_groupstruct();
  var_3 = var_2.wall_snap_direction;

  if(var_3 == 0) {
    return;
  }
  var_4 = var_0;
  var_5 = var_4;
  var_6 = 32;
  var_7 = 16 * var_3 * vectorNormalize(anglestoright(var_1));

  for(var_8 = 1; var_8 < 15; var_8++) {
    var_4 = var_5;
    var_0 = var_4;
    var_9 = var_8 * var_6 * var_3 * vectorNormalize(anglestoright(var_1));
    var_10 = bullettrace_but_not_nodes(var_0, var_0 + var_9, 0);
    var_0 = var_0 + var_10["fraction"] * var_9;

    if(var_10["fraction"] < 1) {
      continue;
    } else {}

    var_4 = var_0;
    var_11 = 32 * vectorNormalize(anglesToForward(var_1));
    var_10 = bullettrace_but_not_nodes(var_0, var_0 + var_11, 0);
    var_12 = var_10["fraction"];

    if(var_10["fraction"] == 1) {
      var_12 = 0.51;
    }
    var_0 = var_0 + var_12 * var_11;

    if(var_10["fraction"] < var_12) {
      continue;
    } else {}

    var_4 = var_0;
    var_13 = var_9 * -1 - var_7;
    var_10 = bullettrace_but_not_nodes(var_0, var_0 + var_13, 0);
    var_0 = var_0 + var_10["fraction"] * var_13;

    if(var_10["fraction"] > 0.99) {
      continue;
    } else {}

    var_14 = var_0;
    var_15 = var_14 + var_7 * -1 + var_11 * var_12 * -1;
    var_16 = var_15 + var_7 * 0.9;
    var_10 = bullettrace_but_not_nodes(var_16, var_16 + var_11 * 0.5, 0);

    if(var_10["fraction"] < 1) {
      var_15 = var_10["position"] - var_11 * 0.5 + var_7 * -0.9;
    }
    return var_15;
  }

  return undefined;
}

place_node_place(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  var_1 = level.player_view_trace;
  var_2 = common_scripts\utility::flat_angle(level.player getplayerangles());
  var_3 = var_1["position"] + level.noder_heightoffset;

  if(var_1["fraction"] == 1 || level.placed_nodes.size > level.noder_max) {
    level.preview_node hide();
    return;
  }

  if(is_player_looking_at_a_wall()) {
    level.preview_node dontinterpolate();
    var_2 = vectortoangles(-1 * var_1["normal"]);
    var_3 = get_wall_offset(var_2);
  } else if(level.node_grid) {
    level.preview_node dontinterpolate();
    var_3 = get_snapped_origin(var_3);
    draw_grid(var_3, var_0);
    var_2 = (0, 0, 0);
  }

  if(node_is_invalid(var_3)) {
    level.preview_node hide();
    select_coliding_node();
    return;
  } else if(node_is_touching(var_3)) {
    select_coliding_node();
  } else {
    unselect_node();
    level.preview_node show();
  }

  draw_lines_to_connectible_nodes(var_3);
  place_node_here(var_3, var_2, var_0);
}

place_node_here(var_0, var_1, var_2) {
  var_3 = getcurrent_groupstruct();

  if(var_2) {
    var_4 = level.preview_node;
    var_4.origin = var_0;
  } else {
    var_4 = spawn("script_model", var_0);
  }
  var_4 notsolid();

  if(!var_2) {
    var_4 setModel(var_3.model);
  }
  var_4.angles = var_1;

  if(var_3.model == "node_pathnode") {
    var_4.angles = (0, 0, 0);
  }
  if(!var_2) {
    place_new_dummy_guy_and_animate_at_node(var_4);
    level.placed_nodes[level.placed_nodes.size] = var_4;
  }

  hud_update_placed_model_count();
}

place_node_place_at_feet() {
  var_0 = common_scripts\utility::flat_angle(level.noder_player getplayerangles());
  var_1 = groundpos_loc(level.noder_player.origin + (0, 0, 16)) + level.noder_heightoffset;

  if(node_is_invalid(var_1)) {
    return;
  }
  place_node_here(var_1, var_0, 0);
  hud_update_placed_model_count();
}

get_mp_player() {
  return getEntArray("player", "classname")[0];
}

place_node_erase() {
  var_0 = undefined;

  if(isDefined(level.selected_node)) {
    var_0 = level.selected_node;
  }
  if(isDefined(level.player_view_trace["entity"])) {
    var_0 = level.player_view_trace["entity"];

    if(!issubstr(var_0.model, "node_")) {
      var_0 = undefined;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  level.near_nodes = common_scripts\utility::array_remove(level.near_nodes, var_0);
  level.placed_nodes = common_scripts\utility::array_remove(level.placed_nodes, var_0);

  if(isDefined(var_0.has_dummy_guy)) {
    var_0.has_dummy_guy hide();
    var_0.has_dummy_guy.is_hidden = 1;
  }

  var_0 delete();
  level.noder_node_delete = 1;
  hud_update_placed_model_count();
}

dump_nodes() {}

player_view_trace() {
  var_0 = 2000;
  var_1 = level.noder_player getEye();
  return bulletTrace(var_1, var_1 + anglesToForward(level.noder_player getplayerangles()) * var_0, 0, level.preview_node);
}

is_player_looking_at_a_wall() {
  if(!isDefined(level.player_view_trace["normal"])) {
    return 0;
  }
  if(traces_hitting_node(level.player_view_trace)) {
    return 0;
  }
  var_0 = vectortoangles(level.player_view_trace["normal"]);
  var_1 = common_scripts\utility::flat_angle(var_0);

  if(vectordot(anglesToForward(var_1), anglesToForward(var_0)) == 1) {
    return 1;
  } else {
    return 0;
  }
}

gettext_nonode(var_0) {
  var_1 = "";

  for(var_2 = 5; var_2 < var_0.size; var_2++) {
    var_1 = var_1 + var_0[var_2];
  }
  return var_1;
}

bullettrace_but_not_nodes(var_0, var_1, var_2, var_3) {
  var_4 = bulletTrace(var_0, var_1, var_2, var_3);

  if(traces_hitting_node(var_4)) {
    var_4 = bulletTrace(var_0, var_1, var_2, var_4["entity"]);
  }
  return var_4;
}

traces_hitting_node(var_0) {
  return isDefined(var_0["entity"]) && isDefined(var_0["entity"].model) && issubstr(var_0["entity"].model, "node_");
}

groundpos_loc(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = -100000;
  }
  return bullettrace_but_not_nodes(var_0, var_0 + (0, 0, var_1), 0, self)["position"];
}

get_snapped_origin(var_0) {
  var_1 = level.node_grid;
  var_2 = snap_number_to_nearest_grid(var_0[0], var_1);
  var_3 = snap_number_to_nearest_grid(var_0[1], var_1);
  return groundpos_loc((var_2, var_3, var_0[2] + 32)) + level.noder_heightoffset;
}

snap_number_to_nearest_grid(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_3 = int(var_2);
  var_4 = var_2 - var_3;

  if(var_4 < -0.5) {
    var_3--;
  } else if(var_4 > 0.5) {
    var_3++;
  }
  return var_3 * var_1;
}

draw_grid(var_0, var_1) {
  var_2 = 1;
  var_3 = (0, 1, 0);
  var_0 = groundpos_loc(var_0);
  var_4 = var_0 + (0, 0, level.node_grid);

  for(var_5 = var_2 * -1; var_5 < var_2 + 1; var_5++) {
    for(var_6 = var_2 * -1; var_6 < var_2 + 1; var_6++) {
      if(var_5 != var_2) {}

      if(var_6 != var_2) {}
    }
  }
}

groundpos_line(var_0, var_1, var_2, var_3) {
  var_4 = level.node_grid * -2;
  var_0 = groundpos_loc(var_0, var_4);
  var_1 = groundpos_loc(var_1, var_4);
}

node_is_invalid(var_0) {
  var_1 = 0;
  var_2 = 68;
  var_3 = undefined;

  foreach(var_5 in level.placed_nodes) {
    var_6 = distance(var_0, var_5.origin);

    if(var_6 < 32) {
      var_1++;

      if(var_6 < 0.05) {
        var_1 = 6;
      }
      if(var_6 < var_2) {
        var_3 = var_5;
      }
    }
  }

  if(!isDefined(var_3)) {
    return 0;
  }
  level.coliding_node = var_3;

  if(var_1 >= 2) {
    return 1;
  }
  return 0;
}

node_is_touching(var_0) {
  foreach(var_2 in level.placed_nodes) {
    if(distance(var_0, var_2.origin) < 32) {
      level.coliding_node = var_2;
      return 1;
    }
  }

  return 0;
}

hud_update_gridsize() {
  var_0 = "^7";

  if(level.node_grid != 0) {
    var_0 = "^1";
  }
  level.hud_noder["gridsize"].description _settext(var_0 + level.node_grid);
}

grid_up() {
  if(!level.node_grid) {
    level.node_grid = 64;
  }
  level.node_grid = level.node_grid * 2;

  if(level.node_grid > 256) {
    level.node_grid = 256;
  }
  hud_update_gridsize();
}

grid_down() {
  if(!level.node_grid) {
    return;
  }
  level.node_grid = level.node_grid * 0.5;

  if(level.node_grid < 64) {
    level.node_grid = 0;
  }
  hud_update_gridsize();
}

grid_toggle() {
  if(level.node_grid == 256) {
    level.node_grid = 0;
  } else {
    level.node_grid = 256;
  }
  hud_update_gridsize();
}

select_traced_node(var_0) {
  select_node(var_0["entity"]);
}

select_node(var_0) {
  if(level.node_select_locked && isDefined(level.selected_node)) {
    return;
  }
  place_new_dummy_guy_and_animate_at_node(var_0);
  level.selector_model dontinterpolate();
  level.selector_model.origin = var_0.origin;
  level.selector_model.angles = var_0.angles;
  level.selector_model show();
  level.selected_node = var_0;
}

place_new_dummy_guy_and_animate_at_node(var_0) {
  if(!level.dummyguy.size || isDefined(var_0.has_dummy_guy) || !node_has_animations(var_0)) {
    return;
  }
  var_1 = fifo_dummyguy();

  if(isDefined(var_1.lastnode)) {
    var_1.lastnode.has_dummy_guy = undefined;
  }
  var_1 thread animate_dummyguy_at_node(var_0);
}

select_coliding_node() {
  select_node(level.coliding_node);
}

unselect_node() {
  if(level.node_select_locked && isDefined(level.selected_node)) {
    return;
  }
  level.selector_model hide();
  level.selected_node = undefined;
}

draw_selected_node_name() {
  for(;;) {
    if(!isDefined(level.selected_node)) {
      wait 0.05;
      continue;
    }

    var_0 = level.selected_node.model;
    var_1 = anglestoright(level.player getplayerangles()) * var_0.size * -3;
    thread maps\_utility::debug_message(var_0, level.selected_node.origin + var_1, 0.05);
    wait 0.05;
  }
}

toggle_select_lock() {
  if(level.node_select_locked) {
    level.selection_lock_indicator _settext("");
    level.node_select_locked = 0;
  } else {
    level.selection_lock_indicator _settext("^1Selection Lock On");
    level.node_select_locked = 1;
  }
}

set_button_funcs_main() {
  clear_all_button_funcs();
  add_button_func(::dump_nodes, 0, "w");
  add_button_func(::place_node_erase, 0, "BUTTON_LSHLDR");
  add_button_func(::place_node_place, 0, "BUTTON_RSHLDR");
  add_button_func(::place_node_place_at_feet, 0, "BUTTON_RSTICK");
  add_button_func(::setgroup_down, 0, "BUTTON_X");
  add_button_func(::setgroup_up, 0, "BUTTON_Y");
  add_button_func(::setgroup_down, 0, "DPAD_UP");
  add_button_func(::setgroup_up, 0, "DPAD_DOWN");
  add_button_func(::grid_toggle, 0, "BUTTON_A");
  add_button_func(::toggle_animation_preview, 0, "BUTTON_B");
}

clear_all_button_funcs() {
  level.button_func = [];
  level.button_func_isflow = [];
}

set_button_funcs_quickselect() {
  clear_all_button_funcs();
  add_button_func(::dump_nodes, 0, "w");
  add_button_func(::select_node_cover_left, 0, "BUTTON_LSHLDR");
  add_button_func(::select_node_cover_right, 0, "BUTTON_RSHLDR");
  add_button_func(::select_node_pathnode, 0, "BUTTON_LTRIG");
  add_button_func(::select_node_pathnode, 0, "BUTTON_RTRIG");
  add_button_func(::select_node_pathnode, 0, "BUTTON_RSTICK");
  add_button_func(::select_node_cover_crouch_window, 0, "BUTTON_X");
  add_button_func(::select_node_cover_prone, 0, "BUTTON_Y");
  add_button_func(::select_node_concealment_stand, 0, "DPAD_UP");
  add_button_func(::select_node_concealment_prone, 0, "DPAD_DOWN");
  add_button_func(::select_node_concealment_crouch, 0, "DPAD_RGIHT");
  add_button_func(::select_node_cover_stand, 0, "BUTTON_A");
  add_button_func(::select_node_cover_crouch, 0, "BUTTON_B");
}

hint_buttons_quick_modifier() {
  controler_hud_update_text("helpxy", "^4Cover Crouch Window ^7/ ^3Prone");
  controler_hud_update_text("helpab", "^2Cover Stand ^7/ ^1Crouch");
  controler_hud_update_text("helplsrs", "^8 - ^7/ Pathnode");
  controler_hud_update_text("helplbrb", "^8Cover Left ^7/ Right");
  controler_hud_update_text("helpdpl", "^8Conceal - ^7/ Crouch");
  controler_hud_update_text("helpdpu", "^8Conceal Stand ^7/ Prone");
}

hint_buttons_main() {
  controler_hud_update_text("helpxy", "^4Node Type Up ^7/ ^3Down");
  controler_hud_update_text("helpab", "^2Toggle Grid ^7/ ^1Anim Preview ");
  controler_hud_update_text("helplsrs", "^8Quick Pick ^7/ Place at Player");
  controler_hud_update_text("helplbrb", "^8Remove ^7/ Place");
  controler_hud_update_text("helpdpl", "^8- ^7/ -");
  controler_hud_update_text("helpdpu", "^8Node Type Up ^7/ Down");
  var_0 = "( dump ) ^3map_source / xenon_export/" + level.script + "_nodedump.map";
  controler_hud_update_text("helpF", var_0);
}

select_node_cover_crouch() {
  setcurrentgroup("node_cover_crouch");
}

select_node_pathnode() {
  setcurrentgroup("node_pathnode");
}

select_node_cover_crouch_window() {
  setcurrentgroup("node_cover_crouch_window");
}

select_node_cover_prone() {
  setcurrentgroup("node_cover_prone");
}

select_node_cover_stand() {
  setcurrentgroup("node_cover_stand");
}

select_node_concealment_crouch() {
  setcurrentgroup("node_concealment_crouch");
}

select_node_concealment_prone() {
  setcurrentgroup("node_concealment_prone");
}

select_node_concealment_stand() {
  setcurrentgroup("node_concealment_stand");
}

select_node_cover_left() {
  setcurrentgroup("node_cover_left");
}

select_node_cover_right() {
  setcurrentgroup("node_cover_right");
}

set_button_funcs_quick_select() {
  clear_all_button_funcs();
  set_button_funcs_quickselect();
  hint_buttons_quick_modifier();
}

set_button_funcs_quick_select_release() {
  set_button_funcs_main();
  hint_buttons_main();
}

_newhudelem() {
  if(!isDefined(level.noder_elems)) {
    level.noder_elems = [];
  }
  var_0 = newhudelem();
  level.noder_elems[level.noder_elems.size] = var_0;
  return var_0;
}

_settext(var_0) {
  self.realtext = var_0;

  foreach(var_2 in level.noder_elems) {
    if(isDefined(var_2.realtext)) {
      var_2 settext(var_2.realtext);
    }
  }
}

animate_dummyguy_at_node(var_0) {
  var_1 = var_0.origin + (0, 0, -32);
  var_2 = var_0.angles + level.node_offset[var_0.model];
  var_0.has_dummy_guy = self;
  self.lastnode = var_0;
  level.dummynode[self.dummyguyindex] notify("stop_loop");
  level.dummynode[self.dummyguyindex].origin = var_1;
  level.dummynode[self.dummyguyindex].angles = var_2;
  level.dummynode[self.dummyguyindex] dontinterpolate();
  self dontinterpolate();
  self show();
  self.is_hidden = 0;
  level.dummynode[self.dummyguyindex] maps\_anim::anim_generic_loop(self, var_0.model);
}

fifo_dummyguy() {
  level.dummyguy_index++;

  if(level.dummyguy_index == level.dummyguy_index_max) {
    level.dummyguy_index = 0;
  }
  var_0 = level.dummyguy[level.dummyguy_index];
  return var_0;
}

node_has_animations(var_0) {
  if(isDefined(level.scr_anim["generic"][var_0.model])) {
    return 1;
  }
  return 0;
}

toggle_animation_preview() {
  if(level.node_animation_preview) {
    level.node_animation_preview_indicator _settext("^1Anim Preview Off");
    level.node_animation_preview = 0;
    hide_all_dummyguys();
  } else {
    level.node_animation_preview_indicator _settext("");
    level.node_animation_preview = 1;
    show_all_dummyguys();
  }
}

hide_all_dummyguys() {
  foreach(var_1 in level.dummyguy) {
    if(!isDefined(var_1.is_hidden) || !var_1.is_hidden) {
      var_1 hide();
    }
  }
}

show_all_dummyguys() {
  foreach(var_1 in level.dummyguy) {
    if(!isDefined(var_1.is_hidden) || !var_1.is_hidden) {
      var_1 show();
    }
  }
}

draw_lines_to_connectible_nodes(var_0) {
  foreach(var_2 in level.near_nodes) {
    if(!isDefined(var_2.classname)) {
      continue;
    }
  }
}

manage_nearnodes() {
  level endon("dump_nodes");
  level.near_nodes = [];
  var_0 = getallnodes();
  var_1 = 0;
  var_2 = 1000;
  var_3 = [];
  level.nearnodes_time = 0;
  wait 0.05;

  for(;;) {
    var_4 = var_0;

    foreach(var_6 in level.placed_nodes) {}
    var_4[var_4.size] = var_6;

    var_8 = level.placed_nodes.size;

    foreach(var_6 in var_4) {
      var_3[var_3.size] = var_6;
      var_1++;

      if(level.placed_nodes.size != var_8) {
        var_3 = [];
        var_1 = 0;
        break;
      }

      if(var_1 > var_2) {
        var_10 = [];

        foreach(var_12 in level.near_nodes) {
          if(distancesquared((level.preview_node.origin[0], level.preview_node.origin[1], 0), (var_12.origin[0], var_12.origin[1], 0)) <= 65536) {
            var_10[var_10.size] = var_12;
          }
        }

        var_14 = [];

        foreach(var_16 in var_3) {
          if(distancesquared((level.preview_node.origin[0], level.preview_node.origin[1], 0), (var_16.origin[0], var_16.origin[1], 0)) <= 65536) {
            var_14[var_14.size] = var_16;
          }
        }

        level.near_nodes = maps\_utility::array_merge(var_14, var_10);
        var_3 = [];
        var_1 = 0;
        wait 0.05;
        waittillframeend;
      }

      if(level.noder_node_delete) {
        level.noder_node_delete = 0;
        var_3 = [];
        var_1 = 0;
        break;
      }
    }

    wait 0.05;
  }
}