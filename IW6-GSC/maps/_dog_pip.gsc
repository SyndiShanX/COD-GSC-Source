/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_dog_pip.gsc
*****************************************************/

#using_animtree("generic_human");

pip_init() {
  level.scr_anim["generic"]["setup_pose"] = % casual_stand_idle;
  level.pip = level.player newpip();
  level.pip.enable = 0;
  precacheshader("ac130_overlay_pip_vignette");
  precacheshader("ac130_overlay_pip_static_a");
  precacheshader("ac130_overlay_pip_static_b");
  precacheshader("ac130_overlay_pip_static_c");
  precacheshader("overlay_grain");
  precacheshader("overlay_static");
}

dog_pip_init(var_0, var_1) {
  if(isDefined(self.controlling_dog) && self.controlling_dog) {
    return;
  }
  if(level.pip.enable) {
    return;
  }
  var_2 = var_0 common_scripts\utility::spawn_tag_origin();
  var_2 linkto(var_0, "tag_camera", (12, 0, 3), (0, 0, 0));
  level.pip.enable = 1;
  level.pip.freecamera = 1;
  level.pip.entity = var_2;
  level.pip.fov = common_scripts\utility::ter_op(isDefined(var_1), var_1, 50);
  var_3 = getdvarint("widescreen", 1);
  var_4 = 0.75;
  level.pip_ai_cam = var_0;
  level.pip.closed_width = 16;
  level.pip.opened_width = common_scripts\utility::ter_op(var_3, 220, 130);
  level.pip.closed_height = common_scripts\utility::ter_op(var_3, 135, int(floor(var_4 * level.pip.opened_width)));
  level.pip.opened_height = common_scripts\utility::ter_op(var_3, 135, int(floor(var_4 * level.pip.opened_width)));
  level.pip.opened_x = common_scripts\utility::ter_op(var_3, 490, 475);
  level.pip.opened_y = common_scripts\utility::ter_op(var_3, 15, 30);
  level.pip.closed_x = level.pip.opened_x + level.pip.opened_width * 0.5 - level.pip.closed_width * 0.5;
  level.pip.closed_y = level.pip.opened_y;
  level.pip.border_thickness = 2;
  level.pip.enableshadows = 0;
  level.pip.tag = "tag_origin";
  level.pip.x = level.pip.closed_x;
  level.pip.y = level.pip.closed_y;
  level.pip.width = level.pip.closed_width;
  level.pip.height = level.pip.closed_height;
  level.pip.visionsetnaked = "thermal";
  var_5 = level.pip.closed_x;
  var_6 = level.pip.closed_y;
  level.pip.borders["top_left"] = new_l_pip_corner(var_5, var_6, "top_left");
  level.pip.borders["top_right"] = new_l_pip_corner(var_5, var_6, "top_right");
  level.pip.borders["bottom_left"] = new_l_pip_corner(var_5, var_6, "bottom_left");
  level.pip.borders["bottom_right"] = new_l_pip_corner(var_5, var_6, "bottom_right");
  level thread pip_static();
  level thread pip_open();
  level thread pip_border();
  level thread pip_static_lines();
}

pip_toggle_ai_cam(var_0) {
  notifyoncommand("toggle_pip_cam", "+actionslot 4");

  for(;;) {
    foreach(var_2 in var_0) {
      level.player waittill("toggle_pip_cam");
      var_3 = spawn("script_model", var_2.origin);
      var_3 setModel("tag_origin");
      var_3.angles = var_2.angles;
      var_3 linkto(var_2, "j_head", (-13, -12, 64), (0, 0, 0));
      level.pip.entity = var_3;
      level.pip_ai_cam = var_2;
      wait 0.2;
    }
  }
}

pip_display_name() {
  level.pip_display_name = newhudelem();
  level.pip_display_name.alpha = 1;
  level.pip_display_name.x = level.pip.opened_x + 15;
  level.pip_display_name.y = level.pip.opened_y + 1;
  level.pip_display_name.hidewheninmenu = 0;
  level.pip_display_name.hidewhendead = 1;
  level.pip_display_name.fontscale = 1.5;
  level.pip_display_name.font = "objective";
  level.pip_display_name settext(level.pip_ai_cam.name);

  for(;;) {
    level.player waittill("toggle_pip_cam");
    wait 0.1;
    level.pip_display_name settext(level.pip_ai_cam.name);
  }
}

pip_display_timer() {
  level.pip_timer = level.player maps\_hud_util::createclienttimer("objective", 1.5);
  level.pip_timer.alpha = 1;
  level.pip_timer.x = level.pip.opened_x + 200;
  level.pip_timer.y = level.pip.opened_y + 82;
  level.pip_timer.hidewheninmenu = 0;
  level.pip_timer.hidewhendead = 1;
  level.pip_timer settenthstimerup(0.0);
}

pip_static() {
  var_0 = newhudelem();
  var_0.alpha = 1;
  var_0.sort = -50;
  var_0.x = level.pip.opened_x;
  var_0.y = level.pip.opened_y;
  var_0.hidewheninmenu = 0;
  var_0.hidewhendead = 1;
  var_0 setshader("overlay_static", level.pip.opened_width, level.pip.opened_height);
  level.pip.static_overlay = var_0;
}

pip_static_lines() {
  level.pip endon("stop_interference");
  level.pip.line_a = newhudelem();
  level.pip.line_a.alpha = 1;
  level.pip.line_a.sort = -50;
  level.pip.line_a.x = level.pip.opened_x;
  level.pip.line_a.y = level.pip.opened_y;
  level.pip.line_a.hidewheninmenu = 0;
  level.pip.line_a.hidewhendead = 1;
  var_0 = [];
  var_0[0] = "ac130_overlay_pip_static_a";
  var_0[1] = "ac130_overlay_pip_static_b";
  var_0[2] = "ac130_overlay_pip_static_c";
  var_0 = common_scripts\utility::array_randomize(var_0);
  level thread random_line_flicker();
  level thread random_line_placement();
  var_1 = 135;
  var_2 = randomfloatrange(0.1, 0.35);

  for(;;) {
    level.pip.line_a setshader(common_scripts\utility::random(var_0), level.pip.opened_width, int(var_1 * var_2));
    wait 0.05;
  }
}

random_line_flicker() {
  level.pip endon("stop_interference");

  for(;;) {
    var_0 = randomfloatrange(0.05, 0.08);
    var_1 = randomfloatrange(0.1, 0.8);
    level.pip.line_a fadeovertime(var_0);
    level.pip.line_a.alpha = var_1;
    wait(var_0);

    if(randomint(100) > 50) {
      var_0 = randomfloatrange(0.25, 0.4);
      level.pip.line_a fadeovertime(var_0);
      level.pip.line_a.alpha = 0;
      wait(var_0);
    }
  }
}

random_line_placement() {
  level.pip endon("stop_interference");

  for(;;) {
    var_0 = randomintrange(10, 110);
    level.pip.line_a.y = var_0;
    wait(randomfloatrange(0.05, 0.4));
  }
}

pip_border() {
  var_0 = newhudelem();
  var_0.alpha = 1;
  var_0.sort = -50;
  var_0.x = level.pip.opened_x;
  var_0.y = level.pip.opened_y;
  var_0.hidewheninmenu = 0;
  var_0.hidewhendead = 1;
  var_0 setshader("ac130_overlay_pip_vignette", level.pip.opened_width, level.pip.opened_height);
  level.pip.border = var_0;
}

pip_interference() {
  level.pip endon("stop_interference");

  for(;;) {
    var_0 = randomfloatrange(0.1, 1);
    var_1 = var_0 + randomfloatrange(0.1, 0.4);
    var_2 = randomfloatrange(0.1, 0.2);
    level.pip.static_overlay fadeovertime(var_0);
    level.pip.static_overlay.alpha = var_2;
    wait(var_1);
    var_0 = randomfloatrange(0.5, 0.75);
    var_1 = var_0 + randomfloatrange(0.5, 1.5);
    level.pip.static_overlay fadeovertime(var_0);
    level.pip.static_overlay.alpha = 0.3;
    wait(var_1);
  }
}

pip_open() {
  var_0 = 0.1;

  foreach(var_3, var_2 in level.pip.borders) {
    var_2 thread pip_open_l_corner(var_3, var_0);
  }

  wait(var_0 + 0.05);
  level.pip.width = level.pip.opened_width;
  level.pip.height = level.pip.opened_height;
  level.pip.x = level.pip.opened_x;
  level.pip.y = level.pip.opened_y;
  level.pip.enable = 1;
  wait 0.3;
  level notify("pip_in");
  level.pip.static_overlay fadeovertime(0.5);
  level.pip.static_overlay.alpha = 0.2;
  level thread pip_interference();
}

get_world_relative_offset(var_0, var_1, var_2) {
  var_3 = cos(var_1[1]);
  var_4 = sin(var_1[1]);
  var_5 = var_2[0] * var_3 - var_2[1] * var_4;
  var_6 = var_2[0] * var_4 + var_2[1] * var_3;
  var_5 = var_5 + var_0[0];
  var_6 = var_6 + var_0[1];
  return (var_5, var_6, var_0[2] + var_2[2]);
}

new_l_pip_corner(var_0, var_1, var_2) {
  var_3 = level.pip.closed_width;
  var_4 = level.pip.closed_height;
  var_5 = spawnStruct();
  var_6 = level.pip.border_thickness;
  var_7 = 16;

  if(var_2 == "top_left") {
    var_8 = "left";
    var_9 = "top";
    var_10 = "left";
    var_11 = "top";
    var_0 = var_0 - var_6;
    var_1 = var_1 - var_6;
  } else if(var_2 == "top_right") {
    var_8 = "left";
    var_9 = "top";
    var_10 = "right";
    var_11 = "top";
    var_0 = var_0 + var_3 + var_6 - 1;
    var_1 = var_1 - var_6;
  } else if(var_2 == "bottom_left") {
    var_8 = "left";
    var_9 = "bottom";
    var_10 = "left";
    var_11 = "bottom";
    var_0 = var_0 - var_6;
    var_1 = var_1 + var_4 + var_6;
  } else {
    var_8 = "left";
    var_9 = "bottom";
    var_10 = "right";
    var_11 = "bottom";
    var_0 = var_0 + var_3 + var_6 - 1;
    var_1 = var_1 + var_4 + var_6;
  }

  var_12 = newhudelem();
  var_12.alignx = var_8;
  var_12.aligny = var_9;
  var_12.x = var_0;
  var_12.y = var_1;
  var_12.hidewheninmenu = 0;
  var_12.hidewhendead = 1;
  var_12 setshader("white", var_6, var_7);
  var_5.vertical = var_12;
  var_12 = newhudelem();
  var_12.alignx = var_10;
  var_12.aligny = var_11;
  var_12.x = var_0;
  var_12.y = var_1;
  var_12.hidewheninmenu = 0;
  var_12.hidewhendead = 1;
  var_12 setshader("white", var_7, var_6);
  var_5.horizontal = var_12;
  return var_5;
}

pip_open_l_corner(var_0, var_1) {
  if(var_0 == "top_left" || var_0 == "bottom_left") {
    self.vertical moveovertime(var_1);
    self.vertical.x = level.pip.opened_x;
    self.horizontal moveovertime(var_1);
    self.horizontal.x = level.pip.opened_x;
  } else {
    self.vertical moveovertime(var_1);
    self.vertical.x = level.pip.opened_x + level.pip.opened_width;
    self.horizontal moveovertime(var_1);
    self.horizontal.x = level.pip.opened_x + level.pip.opened_width;
  }
}

dog_pip_close() {
  level.pip notify("stop_interference");
  level.pip.static_overlay.alpha = 1;
  var_0 = 0.2;
  level.pip.enableshadows = 1;
  level.pip.static_overlay fadeovertime(var_0);
  level.pip.static_overlay.alpha = 1;
  wait(var_0);

  if(isDefined(level.pip.linked_ent)) {
    level.pip.linked_ent delete();
  }

  var_0 = 0.1;

  foreach(var_3, var_2 in level.pip.borders) {
    var_2 thread pip_close_l_corner(var_3, var_0);
  }

  level.pip.static_overlay scaleovertime(var_0, level.pip.closed_width, level.pip.closed_height);
  wait(var_0 + 0.05);
  level.pip.width = level.pip.closed_width;
  level.pip.height = level.pip.closed_height;
  level.pip.x = level.pip.closed_x;
  level.pip.y = level.pip.closed_y;

  if(isDefined(level.pip.borders)) {
    common_scripts\utility::array_thread(level.pip.borders, ::pip_remove_l_corners);
  }

  level.pip.static_overlay destroy();

  if(isDefined(level.pip_display_name)) {
    level.pip_display_name destroy();
  }

  if(isDefined(level.pip_timer)) {
    level.pip_timer destroy();
  }

  if(isDefined(level.pip.border)) {
    level.pip.border destroy();
  }

  if(isDefined(level.pip.line_a)) {
    level.pip.line_a destroy();
  }

  level.pip.enable = 0;
}

pip_remove_l_corners() {
  self.vertical destroy();
  self.horizontal destroy();
}

pip_close_l_corner(var_0, var_1) {
  if(var_0 == "top_left" || var_0 == "bottom_left") {
    self.vertical moveovertime(var_1);
    self.vertical.x = level.pip.closed_x;
    self.horizontal moveovertime(var_1);
    self.horizontal.x = level.pip.closed_x;
  } else {
    self.vertical moveovertime(var_1);
    self.vertical.x = level.pip.closed_x + level.pip.closed_width;
    self.horizontal moveovertime(var_1);
    self.horizontal.x = level.pip.closed_x + level.pip.closed_width;
  }
}

print3d_on_ent(var_0) {}