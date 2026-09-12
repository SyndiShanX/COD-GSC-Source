/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_crib.gsc
*********************************************/

init() {
  precacheshellshock("frag_grenade_mp");
  radial_button_definitions();
  radial_init();
  view_path_setup();
  player_init();
}

radial_button_definitions() {
  newradialbuttongroup("main", "player_view1_start", "player_view1_end");
  var_00 = newradialbutton("main", "Primary Weapon", "radial_weapons_primary", ::action_weapons_primary);
  var_01 = newradialbutton("main", "Secondary Weapon", "radial_weapons_secondary", ::action_weapons_secondary);
  var_02 = newradialbutton("main", "Gears", "radial_gears", ::action_gears);
  var_03 = newradialbutton("main", "Kill Streaks", "radial_killstreaks", ::action_killstreak);
  var_04 = newradialbutton("main", "Leaderboards", "radial_leaderboards", ::action_leaderboards);
  newradialbuttongroup("gears", "player_view2_start", "player_view2_end");
  newradialbuttongroup("weapons_primary", "player_view3_start", "player_view3_end");
  newradialbuttongroup("weapons_secondary", "player_view3_start", "player_view3_end");
  newradialbuttongroup("killstreak", "player_view4_start", "player_view4_end");
  newradialbuttongroup("leaderboards", "player_view5_start", "player_view5_end");
}

radial_init() {
  foreach(var_01 in level.radial_button_group) {
    sort_buttons_by_angle(var_01);
    for(var_02 = 0; var_02 < var_01.size; var_02++) {
      if(isDefined(var_01[var_02 + 1])) {
        var_03 = getmidangle(var_01[var_02].pos_angle, var_01[var_02 + 1].pos_angle);
        var_01[var_02].end_angle = var_03;
        var_01[var_02 + 1].start_angle = var_03;
        continue;
      }

      var_03 = getmidangle(var_01[var_02].pos_angle, var_01[0].pos_angle) + 180;
      if(var_03 > 360) {
        var_03 = var_03 - 360;
      }

      var_01[var_02].end_angle = var_03;
      var_01[0].start_angle = var_03;
    }
  }

  thread updateselectedbutton();
  thread watchselectbuttonpress();
  thread watchbackbuttonpress();
  thread debug_toggle();
}

debug_toggle() {
  level endon("game_ended");
  level.crib_debug = 1;
  for(;;) {
    if(!isDefined(level.observer)) {
      wait 0.05;
      continue;
    }

    var_00 = 1;
    while(!level.observer buttonpresseddevonly("BUTTON_Y")) {
      wait 0.05;
    }

    level.observer playSound("mouse_click");
    if(var_00) {
      level.crib_debug = level.crib_debug * -1;
      var_00 = 0;
    }

    while(level.observer buttonpresseddevonly("BUTTON_Y")) {
      wait 0.05;
    }
  }
}

player_init() {
  level thread onplayerconnect();
  level thread return_hud();
}

return_hud() {
  level waittill("game_ended");
  setDvar("2562", 1);
}

onplayerconnect() {
  level waittill("connected", var_00);
  var_00 thread readyplayer();
  var_00 waittill("spawned_player");
  wait(1);
  var_00 takeallweapons();
  setDvar("2562", 0);
  if(!isDefined(var_00)) {
    return;
  } else {
    level.observer = var_00;
  }

  var_00 thread get_right_stick_angle();
  zoom_to_radial_menu("main");
}

readyplayer() {
  self endon("disconnect");
  var_00 = "autoassign";
  while(!isDefined(self.pers["team"])) {
    wait 0.05;
  }

  self notify("menuresponse", game["menu_team"], var_00);
  wait(0.5);
  var_01 = getarraykeys(level.classmap);
  var_02 = [];
  for(var_03 = 0; var_03 < var_01.size; var_03++) {
    if(!issubstr(var_01[var_03], "custom")) {
      var_02[var_02.size] = var_01[var_03];
    }
  }

  for(;;) {
    var_04 = var_02[0];
    self notify("menuresponse", "changeclass", var_04);
    self waittill("spawned_player");
    wait(0.1);
  }
}

get_right_stick_angle() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    var_00 = self getnormalizedmovement();
    var_01 = vectortoangles(var_00);
    level.rs_angle = int(var_01[1]);
    wait 0.05;
  }
}

newradialbuttongroup(param_00, param_01, param_02) {
  if(isDefined(level.radial_button_group) && level.radial_button_group.size) {}

  var_03 = getEnt(param_02, "targetname");
  var_04 = vectorNormalize(anglesToForward(var_03.angles)) * 40;
  level.radial_button_group[param_00] = [];
  level.radial_button_group_info[param_00]["view_start"] = param_01;
  level.radial_button_group_info[param_00]["view_pos"] = var_03.origin + var_04;
  level.radial_button_group_info[param_00]["player_view_pos"] = var_03.origin;
  level.radial_button_group_info[param_00]["view_angles"] = var_03.angles;
}

newradialbutton(param_00, param_01, param_02, param_03) {
  var_04 = getEnt(param_02, "targetname");
  var_05 = getradialanglefroment(param_00, var_04);
  var_06 = spawnStruct();
  var_06.pos = var_04.origin;
  var_06.label = param_01;
  var_06.font_size = 1;
  var_06.font_color = (0.5, 0.5, 1);
  var_06.pos_angle = var_05;
  var_06.action_func = param_03;
  var_06.radius_pos = 8;
  level.radial_button_group[param_00][level.radial_button_group[param_00].size] = var_06;
  return var_06;
}

updateselectedbutton() {
  level endon("game_ended");
  for(;;) {
    if(!isDefined(level.radial_button_current_group)) {
      wait 0.05;
      continue;
    }

    var_00 = level.active_button;
    foreach(var_02 in level.radial_button_group[level.radial_button_current_group]) {
      if(isinrange(var_02.start_angle, var_02.end_angle)) {
        level.active_button = var_02;
        continue;
      }

      var_02.font_color = (0.5, 0.5, 1);
    }

    if(isDefined(level.active_button)) {
      level.active_button.font_color = (1, 1, 0.5);
      if(isDefined(var_00) && var_00 != level.active_button) {
        level.observer playSound("mouse_over");
      }
    }

    wait 0.05;
  }
}

watchselectbuttonpress() {
  level endon("game_ended");
  for(;;) {
    if(!isDefined(level.observer)) {
      wait 0.05;
      continue;
    }

    var_00 = 1;
    while(!level.observer buttonpresseddevonly("BUTTON_A")) {
      wait 0.05;
    }

    level.observer playSound("mouse_click");
    if(isDefined(level.active_button) && var_00) {
      level.active_button notify("select_button_pressed");
      [[level.active_button.action_func]]();
      var_00 = 0;
    }

    while(level.observer buttonpresseddevonly("BUTTON_A")) {
      wait 0.05;
    }
  }
}

watchbackbuttonpress() {
  level endon("game_ended");
  for(;;) {
    if(!isDefined(level.observer)) {
      wait 0.05;
      continue;
    }

    var_00 = 1;
    while(!level.observer buttonpresseddevonly("BUTTON_X")) {
      wait 0.05;
    }

    level.observer playSound("mouse_click");
    if(var_00) {
      action_back();
      var_00 = 0;
    }

    while(level.observer buttonpresseddevonly("BUTTON_X")) {
      wait 0.05;
    }
  }
}

sort_buttons_by_angle(param_00) {
  for(var_01 = 0; var_01 < param_00.size - 1; var_01++) {
    for(var_02 = 0; var_02 < param_00.size - 1 - var_01; var_02++) {
      if(param_00[var_02 + 1].pos_angle < param_00[var_02].pos_angle) {
        button_switch(param_00[var_02], param_00[var_02 + 1]);
      }
    }
  }
}

button_switch(param_00, param_01) {
  var_02 = param_00.pos;
  var_03 = param_00.label;
  var_04 = param_00.pos_angle;
  var_05 = param_00.action_func;
  var_06 = param_00.radius_pos;
  param_00.pos = param_01.pos;
  param_00.label = param_01.label;
  param_00.pos_angle = param_01.pos_angle;
  param_00.action_func = param_01.action_func;
  param_00.radius_pos = param_01.radius_pos;
  param_01.pos = var_02;
  param_01.label = var_03;
  param_01.pos_angle = var_04;
  param_01.action_func = var_05;
  param_01.radius_pos = var_06;
}

draw_radial_buttons(param_00) {
  foreach(var_02 in level.radial_button_group[param_00]) {
    var_02 thread draw_radial_button(param_00);
  }
}

draw_radial_button(param_00) {
  level endon("game_ended");
  self endon("remove_button");
  var_01 = level.radial_button_group_info[param_00]["view_pos"];
  var_02 = var_01 + radial_angle_to_vector(self.pos_angle, 4);
  for(;;) {
    var_03 = (1, 0, 0);
    if(isinrange(self.start_angle, self.end_angle)) {
      var_03 = (1, 1, 0);
    }

    if(isDefined(level.crib_debug) && level.crib_debug > 0) {
      var_04 = var_01 + radial_angle_to_vector(level.rs_angle, 2);
    }

    wait 0.05;
  }
}

zoom_to_radial_menu(param_00, param_01) {
  level.active_button = undefined;
  if(isDefined(level.radial_button_current_group) && level.radial_button_current_group != "") {
    level.radial_button_previous_group = level.radial_button_current_group;
  } else {
    level.radial_button_previous_group = "main";
    level.radial_button_current_group = "main";
  }

  foreach(var_03 in level.radial_button_group[level.radial_button_previous_group]) {
    var_03 notify("remove_button");
  }

  if(isDefined(param_01) && param_01) {
    level.observer go_path_by_targetname_reverse(level.radial_button_group_info[level.radial_button_previous_group]["view_start"], param_00);
  } else {
    level.observer go_path_by_targetname(level.radial_button_group_info[param_00]["view_start"]);
  }

  level thread draw_radial_buttons(param_00);
  level.radial_button_current_group = param_00;
}

getradialanglefroment(param_00, param_01) {
  var_02 = level.radial_button_group_info[param_00]["view_angles"];
  var_03 = level.radial_button_group_info[param_00]["view_pos"];
  var_03 = var_03 + vectorNormalize(anglesToForward(var_02)) * 40;
  var_04 = anglesToForward(var_02);
  var_05 = vectorNormalize(anglestoup(var_02));
  var_06 = param_01.angles;
  var_07 = param_01.origin;
  var_08 = vectorNormalize(vectorfromlinetopoint(var_03, var_03 + var_04, var_07));
  var_09 = acos(vectordot(var_08, var_05));
  if(vectordot(anglestoright(var_02), var_08) < 0) {
    var_09 = 360 - var_09;
  }

  return var_09;
}

radial_angle_to_vector(param_00, param_01) {
  var_02 = (270 - param_00, 0, 0);
  var_03 = anglesToForward(var_02);
  var_04 = vectorNormalize(var_03);
  var_05 = var_04 * param_01;
  return var_05;
}

getmidangle(param_00, param_01) {
  var_02 = param_00 + param_01 + 720 / 2 - 360;
  return var_02;
}

isinrange(param_00, param_01) {
  var_02 = level.rs_angle > param_00 && level.rs_angle < 360;
  var_03 = level.rs_angle > 0 && level.rs_angle < param_01;
  if(param_00 > param_01) {
    var_04 = var_02 || var_03;
  } else {
    var_04 = level.rs_angle > param_01 && level.rs_angle < var_02;
  }

  return var_04;
}

action_back() {
  if(isDefined(level.radial_button_current_group) && level.radial_button_current_group != "main") {
    zoom_to_radial_menu("main", 1);
    return;
  }
}

action_weapons_primary() {
  iprintlnbold("action_weapons_primary");
  zoom_to_radial_menu("weapons_primary");
}

action_weapons_secondary() {
  iprintlnbold("action_weapons_secondary");
  zoom_to_radial_menu("weapons_secondary");
}

action_gears() {
  iprintlnbold("action_gears");
  zoom_to_radial_menu("gears");
}

action_killstreak() {
  iprintlnbold("action_killstreak");
  zoom_to_radial_menu("killstreak");
}

action_leaderboards() {
  iprintlnbold("action_leaderboards");
  zoom_to_radial_menu("leaderboards");
}

view_path_setup() {
  level.view_paths = [];
  build_path_by_targetname("player_view1_start");
  build_path_by_targetname("player_view2_start");
  build_path_by_targetname("player_view3_start");
  build_path_by_targetname("player_view4_start");
  build_path_by_targetname("player_view5_start");
}

build_path_by_targetname(param_00) {
  level.view_paths[param_00] = [];
  var_01 = getEnt(param_00, "targetname");
  level.view_paths[param_00][level.view_paths[param_00].size] = var_01;
  while(isDefined(var_01) && isDefined(var_01.target)) {
    var_02 = getEnt(var_01.target, "targetname");
    level.view_paths[param_00][level.view_paths[param_00].size] = var_02;
    var_01 = var_02;
  }
}

go_path_by_targetname(param_00) {
  if(!isDefined(level.dummy_mover)) {
    var_01 = level.view_paths[param_00][0];
    level.dummy_mover = spawn("script_model", var_01.origin);
    level.dummy_mover.angles = var_01.angles;
    self setOrigin(level.dummy_mover.origin - (0, 0, 65));
    self linkTo(level.dummy_mover);
    wait 0.05;
    self setplayerangles(level.dummy_mover.angles);
    thread force_player_angles();
  }

  var_02 = 1;
  var_03 = abs(distance(level.dummy_mover.origin, level.view_paths[param_00][level.view_paths[param_00].size - 1].origin));
  var_02 = var_02 * var_03 / 1200;
  var_02 = max(var_02, 0.1);
  var_04 = var_02;
  if(!1) {
    var_04 = var_04 * var_02 * level.view_paths[param_00].size + 1;
  }

  thread blur_sine(3, var_04);
  foreach(var_07, var_06 in level.view_paths[param_00]) {
    if(1) {
      if(var_07 != level.view_paths[param_00].size - 1) {
        continue;
      }
    }

    level.dummy_mover moveTo(var_06.origin, var_02, var_02 * 0.5, 0);
    level.dummy_mover rotateTo(var_06.angles, var_02, var_02 * 0.5, 0);
    wait(var_02);
  }
}

go_path_by_targetname_reverse(param_00, param_01) {
  var_02 = 1;
  var_03 = abs(distance(level.dummy_mover.origin, level.radial_button_group_info[param_01]["player_view_pos"]));
  var_02 = var_02 * var_03 / 1200;
  var_02 = max(var_02, 0.1);
  var_04 = var_02;
  if(!1) {
    var_04 = var_04 * var_02 * level.view_paths[param_00].size + 1;
  }

  thread blur_sine(3, var_04);
  if(!1) {
    for(var_05 = level.view_paths[param_00].size - 1; var_05 >= 0; var_05--) {
      var_06 = level.view_paths[param_00][var_05];
      level.dummy_mover moveTo(var_06.origin, var_02);
      level.dummy_mover rotateTo(var_06.angles, var_02);
      wait(var_02);
    }
  }

  thread blur_sine(3, var_02);
  var_07 = level.radial_button_group_info[param_01]["player_view_pos"];
  var_08 = level.radial_button_group_info[param_01]["view_angles"];
  level.dummy_mover moveTo(var_07, var_02, var_02 * 0.5, 0);
  level.dummy_mover rotateTo(var_08, var_02, var_02 * 0.5, 0);
  wait(var_02);
}

travel_view_fx(param_00) {
  self setblurforplayer(20, param_00 + 0.2 / 2);
  self setblurforplayer(0, param_00 + 0.2 / 2);
  self shellshock("frag_grenade_mp", param_00 + 0.2);
}

blur_sine(param_00, param_01) {
  var_02 = int(param_01 / 0.05);
  for(var_03 = 0; var_03 < var_02; var_03++) {
    var_04 = var_03 / var_02;
    var_05 = sin(180 * var_04);
    var_06 = param_00 * var_05;
    setDvar("797", var_06);
    wait 0.05;
  }

  setDvar("797", 0);
}

force_player_angles() {
  level endon("game_ended");
  self endon("disconnect");
  level.dummy_mover endon("remove_dummy");
  for(;;) {
    self setplayerangles(level.dummy_mover.angles);
    wait 0.05;
  }
}