/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_crib.gsc
**************************************/

init() {
  _precacheshellshock("frag_grenade_mp");
  radial_button_definitions();
  radial_init();
  view_path_setup();
  player_init();
}

radial_button_definitions() {
  newradialbuttongroup("main", "player_view1_start", "player_view1_end");
  var_0 = newradialbutton("main", "Primary Weapon", "radial_weapons_primary", ::_id_0880);
  var_1 = newradialbutton("main", "Secondary Weapon", "radial_weapons_secondary", ::_id_0881);
  var_2 = newradialbutton("main", "Gears", "radial_gears", ::_id_0876);
  var_3 = newradialbutton("main", "Kill Streaks", "radial_killstreaks", ::_id_0877);
  var_4 = newradialbutton("main", "Leaderboards", "radial_leaderboards", ::_id_0878);
  newradialbuttongroup("gears", "player_view2_start", "player_view2_end");
  newradialbuttongroup("weapons_primary", "player_view3_start", "player_view3_end");
  newradialbuttongroup("weapons_secondary", "player_view3_start", "player_view3_end");
  newradialbuttongroup("killstreak", "player_view4_start", "player_view4_end");
  newradialbuttongroup("leaderboards", "player_view5_start", "player_view5_end");
}

radial_init() {
  foreach(var_1 in level.radial_button_group) {
    sort_buttons_by_angle(var_1);

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(isDefined(var_1[var_2 + 1])) {
        var_3 = getmidangle(var_1[var_2].pos_angle, var_1[var_2 + 1].pos_angle);
        var_1[var_2].end_angle = var_3;
        var_1[var_2 + 1].start_angle = var_3;
        continue;
      }

      var_3 = getmidangle(var_1[var_2].pos_angle, var_1[0].pos_angle) + 180;

      if(var_3 > 360) {
        var_3 = var_3 - 360;
      }

      var_1[var_2].end_angle = var_3;
      var_1[0].start_angle = var_3;
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
      waitframe();
      continue;
    }

    var_0 = 1;

    while(!level.observer buttonPressed("BUTTON_Y")) {
      waitframe();
    }

    level.observer playSound("mouse_click");

    if(var_0) {
      level.crib_debug = level.crib_debug * -1;
      var_0 = 0;
    }

    while(level.observer buttonPressed("BUTTON_Y")) {
      waitframe();
    }
  }
}

player_init() {
  level thread onplayerconnect();
  level thread return_hud();
}

return_hud() {
  level waittill("game_ended");
  setDvar("cg_draw2D", 1);
}

onplayerconnect() {
  level waittill("connected", var_0);
  var_0 thread readyplayer();
  var_0 waittill("spawned_player");
  wait 1;
  var_0 takeallweapons();
  setDvar("cg_draw2D", 0);

  if(!isDefined(var_0)) {
    return;
  } else {
    level.observer = var_0;
  }

  var_0 thread get_right_stick_angle();
  zoom_to_radial_menu("main");
}

readyplayer() {
  self endon("disconnect");
  var_0 = "autoassign";

  while(!isDefined(self.pers["team"])) {
    waitframe();
  }

  self notify("menuresponse", game["menu_team"], var_0);
  wait 0.5;
  var_1 = getarraykeys(level.classmap);
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(!issubstr(var_1[var_3], "custom")) {
      var_2[var_2.size] = var_1[var_3];
    }
  }

  for(;;) {
    var_4 = var_2[0];
    self notify("menuresponse", "changeclass", var_4);
    self waittill("spawned_player");
    wait 0.1;
  }
}

get_right_stick_angle() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    var_0 = self getnormalizedmovement();
    var_1 = vectortoangles(var_0);
    level.rs_angle = int(var_1[1]);
    waitframe();
  }
}

newradialbuttongroup(var_0, var_1, var_2) {
  if(isDefined(level.radial_button_group) && level.radial_button_group.size) {}

  var_3 = _getEnt(var_2, "targetname");
  var_4 = vectorNormalize(anglesToForward(var_3.angles)) * 40;
  level.radial_button_group[var_0] = [];
  level.radial_button_group_info[var_0]["view_start"] = var_1;
  level.radial_button_group_info[var_0]["view_pos"] = var_3.origin + var_4;
  level.radial_button_group_info[var_0]["player_view_pos"] = var_3.origin;
  level.radial_button_group_info[var_0]["view_angles"] = var_3.angles;
}

newradialbutton(var_0, var_1, var_2, var_3) {
  var_4 = _getEnt(var_2, "targetname");
  var_5 = getradialanglefroment(var_0, var_4);
  var_6 = spawnStruct();
  var_6.pos = var_4.origin;
  var_6.label = var_1;
  var_6.font_size = 1;
  var_6.font_color = (0.5, 0.5, 1);
  var_6.pos_angle = var_5;
  var_6._id_0875 = var_3;
  var_6.radius_pos = 8;
  level.radial_button_group[var_0][level.radial_button_group[var_0].size] = var_6;
  return var_6;
}

updateselectedbutton() {
  level endon("game_ended");

  for(;;) {
    if(!isDefined(level.radial_button_current_group)) {
      waitframe();
      continue;
    }

    var_0 = level._id_08BF;

    foreach(var_2 in level.radial_button_group[level.radial_button_current_group]) {
      if(isinrange(var_2.start_angle, var_2.end_angle)) {
        level._id_08BF = var_2;
        continue;
      }

      var_2.font_color = (0.5, 0.5, 1);
    }

    if(isDefined(level._id_08BF)) {
      level._id_08BF.font_color = (1, 1, 0.5);

      if(isDefined(var_0) && var_0 != level._id_08BF) {
        level.observer playSound("mouse_over");
      }
    }

    waitframe();
  }
}

watchselectbuttonpress() {
  level endon("game_ended");

  for(;;) {
    if(!isDefined(level.observer)) {
      waitframe();
      continue;
    }

    var_0 = 1;

    while(!level.observer buttonPressed("BUTTON_A")) {
      waitframe();
    }

    level.observer playSound("mouse_click");

    if(isDefined(level._id_08BF) && var_0) {
      level._id_08BF notify("select_button_pressed");
      [[level._id_08BF._id_0875]]();
      var_0 = 0;
    }

    while(level.observer buttonPressed("BUTTON_A")) {
      waitframe();
    }
  }
}

watchbackbuttonpress() {
  level endon("game_ended");

  for(;;) {
    if(!isDefined(level.observer)) {
      waitframe();
      continue;
    }

    var_0 = 1;

    while(!level.observer buttonPressed("BUTTON_X")) {
      waitframe();
    }

    level.observer playSound("mouse_click");

    if(var_0) {
      _id_0874();
      var_0 = 0;
    }

    while(level.observer buttonPressed("BUTTON_X")) {
      waitframe();
    }
  }
}

sort_buttons_by_angle(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    for(var_2 = 0; var_2 < var_0.size - 1 - var_1; var_2++) {
      if(var_0[var_2 + 1].pos_angle < var_0[var_2].pos_angle) {
        button_switch(var_0[var_2], var_0[var_2 + 1]);
      }
    }
  }
}

button_switch(var_0, var_1) {
  var_2 = var_0.pos;
  var_3 = var_0.label;
  var_4 = var_0.pos_angle;
  var_5 = var_0._id_0875;
  var_6 = var_0.radius_pos;
  var_0.pos = var_1.pos;
  var_0.label = var_1.label;
  var_0.pos_angle = var_1.pos_angle;
  var_0._id_0875 = var_1._id_0875;
  var_0.radius_pos = var_1.radius_pos;
  var_1.pos = var_2;
  var_1.label = var_3;
  var_1.pos_angle = var_4;
  var_1._id_0875 = var_5;
  var_1.radius_pos = var_6;
}

draw_radial_buttons(var_0) {
  foreach(var_2 in level.radial_button_group[var_0]) {
    var_2 thread draw_radial_button(var_0);
  }
}

draw_radial_button(var_0) {
  level endon("game_ended");
  self endon("remove_button");
  var_1 = level.radial_button_group_info[var_0]["view_pos"];
  var_2 = var_1 + radial_angle_to_vector(self.pos_angle, 4);

  for(;;) {
    var_3 = (1, 0, 0);

    if(isinrange(self.start_angle, self.end_angle)) {
      var_3 = (1, 1, 0);
    }

    if(isDefined(level.crib_debug) && level.crib_debug > 0) {
      var_4 = var_1 + radial_angle_to_vector(level.rs_angle, 2);
    }

    waitframe();
  }
}

zoom_to_radial_menu(var_0, var_1) {
  level._id_08BF = undefined;

  if(isDefined(level.radial_button_current_group) && level.radial_button_current_group != "") {
    level.radial_button_previous_group = level.radial_button_current_group;
  } else {
    level.radial_button_previous_group = "main";
    level.radial_button_current_group = "main";
  }

  foreach(var_3 in level.radial_button_group[level.radial_button_previous_group]) {
    var_3 notify("remove_button");
  }

  if(isDefined(var_1) && var_1) {
    level.observer go_path_by_targetname_reverse(level.radial_button_group_info[level.radial_button_previous_group]["view_start"], var_0);
  } else {
    level.observer go_path_by_targetname(level.radial_button_group_info[var_0]["view_start"]);
  }

  level thread draw_radial_buttons(var_0);
  level.radial_button_current_group = var_0;
}

getradialanglefroment(var_0, var_1) {
  var_2 = level.radial_button_group_info[var_0]["view_angles"];
  var_3 = level.radial_button_group_info[var_0]["view_pos"];
  var_3 = var_3 + vectorNormalize(anglesToForward(var_2)) * 40;
  var_4 = anglesToForward(var_2);
  var_5 = vectorNormalize(anglestoup(var_2));
  var_6 = var_1.angles;
  var_7 = var_1.origin;
  var_8 = vectorNormalize(_vectorfromlinetopoint(var_3, var_3 + var_4, var_7));
  var_9 = _acos(vectordot(var_8, var_5));

  if(vectordot(anglestoright(var_2), var_8) < 0) {
    var_9 = 360 - var_9;
  }

  return var_9;
}

radial_angle_to_vector(var_0, var_1) {
  var_2 = (270 - var_0, 0, 0);
  var_3 = anglesToForward(var_2);
  var_4 = vectorNormalize(var_3);
  var_5 = var_4 * var_1;
  return var_5;
}

getmidangle(var_0, var_1) {
  var_2 = (var_0 + var_1 + 720) / 2 - 360;
  return var_2;
}

isinrange(var_0, var_1) {
  var_2 = level.rs_angle > var_0 && level.rs_angle < 360;
  var_3 = level.rs_angle > 0 && level.rs_angle < var_1;

  if(var_0 > var_1) {
    var_4 = var_2 || var_3;
  } else {
    var_4 = level.rs_angle > var_0 && level.rs_angle < var_1;
  }

  return var_4;
}

_id_0874() {
  if(isDefined(level.radial_button_current_group) && level.radial_button_current_group != "main") {
    zoom_to_radial_menu("main", 1);
  } else {
    return;
  }
}

_id_0880() {
  _iprintlnbold("action_weapons_primary");
  zoom_to_radial_menu("weapons_primary");
}

_id_0881() {
  _iprintlnbold("action_weapons_secondary");
  zoom_to_radial_menu("weapons_secondary");
}

_id_0876() {
  _iprintlnbold("action_gears");
  zoom_to_radial_menu("gears");
}

_id_0877() {
  _iprintlnbold("action_killstreak");
  zoom_to_radial_menu("killstreak");
}

_id_0878() {
  _iprintlnbold("action_leaderboards");
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

build_path_by_targetname(var_0) {
  level.view_paths[var_0] = [];
  var_1 = _getEnt(var_0, "targetname");

  for(level.view_paths[var_0][level.view_paths[var_0].size] = var_1; isDefined(var_1) && isDefined(var_1.target); var_1 = var_2) {
    var_2 = _getEnt(var_1.target, "targetname");
    level.view_paths[var_0][level.view_paths[var_0].size] = var_2;
  }
}

go_path_by_targetname(var_0) {
  if(!isDefined(level.dummy_mover)) {
    var_1 = level.view_paths[var_0][0];
    level.dummy_mover = spawn("script_model", var_1.origin);
    level.dummy_mover.angles = var_1.angles;
    self setOrigin(level.dummy_mover.origin - (0, 0, 65));
    self linkTo(level.dummy_mover);
    waitframe();
    self setplayerangles(level.dummy_mover.angles);
    thread force_player_angles();
  }

  var_2 = 1;
  var_3 = _abs(distance(level.dummy_mover.origin, level.view_paths[var_0][level.view_paths[var_0].size - 1].origin));
  var_2 = var_2 * (var_3 / 1200);
  var_2 = max(var_2, 0.1);
  var_4 = var_2;

  if(!1) {
    var_4 = var_4 * (var_2 * (level.view_paths[var_0].size + 1));
  }

  thread blur_sine(3, var_4);

  foreach(var_7, var_6 in level.view_paths[var_0]) {
    if(1) {
      if(var_7 != level.view_paths[var_0].size - 1) {
        continue;
      }
    }

    level.dummy_mover moveTo(var_6.origin, var_2, var_2 * 0.5, 0);
    level.dummy_mover rotateTo(var_6.angles, var_2, var_2 * 0.5, 0);
    wait(var_2);
  }
}

go_path_by_targetname_reverse(var_0, var_1) {
  var_2 = 1;
  var_3 = _abs(distance(level.dummy_mover.origin, level.radial_button_group_info[var_1]["player_view_pos"]));
  var_2 = var_2 * (var_3 / 1200);
  var_2 = max(var_2, 0.1);
  var_4 = var_2;

  if(!1) {
    var_4 = var_4 * (var_2 * (level.view_paths[var_0].size + 1));
  }

  thread blur_sine(3, var_4);

  if(!1) {
    for(var_5 = level.view_paths[var_0].size - 1; var_5 >= 0; var_5--) {
      var_6 = level.view_paths[var_0][var_5];
      level.dummy_mover moveTo(var_6.origin, var_2);
      level.dummy_mover rotateTo(var_6.angles, var_2);
      wait(var_2);
    }
  }

  thread blur_sine(3, var_2);
  var_7 = level.radial_button_group_info[var_1]["player_view_pos"];
  var_8 = level.radial_button_group_info[var_1]["view_angles"];
  level.dummy_mover moveTo(var_7, var_2, var_2 * 0.5, 0);
  level.dummy_mover rotateTo(var_8, var_2, var_2 * 0.5, 0);
  wait(var_2);
}

travel_view_fx(var_0) {
  self setblurforplayer(20, (var_0 + 0.2) / 2);
  self setblurforplayer(0, (var_0 + 0.2) / 2);
  self shellshock("frag_grenade_mp", var_0 + 0.2);
}

blur_sine(var_0, var_1) {
  var_2 = int(var_1 / 0.05);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_3 / var_2;
    var_5 = _sin(180 * var_4);
    var_6 = var_0 * var_5;
    setDvar("r_blur", var_6);
    waitframe();
  }

  setDvar("r_blur", 0);
}

force_player_angles() {
  level endon("game_ended");
  self endon("disconnect");
  level.dummy_mover endon("remove_dummy");

  for(;;) {
    self setplayerangles(level.dummy_mover.angles);
    waitframe();
  }
}