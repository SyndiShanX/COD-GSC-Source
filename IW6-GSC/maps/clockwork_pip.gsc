/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\clockwork_pip.gsc
*****************************************************/

pip_init() {
  level.pip = level.player newpip();
  level.pip.enable = 0;
}

pip_enable(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = getdvarint("widescreen", 1);
  var_11 = 0.75;

  if(!isDefined(var_5) || !isDefined(var_6) || !isDefined(var_7) || !isDefined(var_8)) {
    var_5 = common_scripts\utility::ter_op(var_10, 545, 530);
    var_6 = common_scripts\utility::ter_op(var_10, 15, 30);
    var_7 = 165;
    var_8 = 101;
  }

  if(!isDefined(var_9))
    var_9 = "ac130_enhanced";

  level.pip.opened_width = var_7;
  level.pip.opened_height = var_8;
  level.pip.closed_width = 16;
  level.pip.closed_height = 101;
  level.pip.opened_x = var_5;
  level.pip.opened_y = var_6;
  level.pip.closed_x = level.pip.opened_x + level.pip.opened_width * 0.5 - level.pip.closed_width * 0.5;
  level.pip.closed_y = level.pip.opened_y;
  level.pip.border_thickness = 2;
  level.pip.enableshadows = 0;
  level.pip.tag = "tag_origin";
  level.pip.x = level.pip.closed_x;
  level.pip.y = level.pip.closed_y;
  level.pip.width = level.pip.closed_width;
  level.pip.height = level.pip.closed_height;
  level.pip.visionsetnight = var_9;
  level.pip.visionsetnaked = var_9;
  level.pip.activevisionset = "night";
  var_12 = level.pip.closed_x;
  var_13 = level.pip.closed_y;
  level.pip.borders["top_left"] = new_l_pip_corner(var_12, var_13, "top_left");
  level.pip.borders["top_right"] = new_l_pip_corner(var_12, var_13, "top_right");
  level.pip.borders["bottom_left"] = new_l_pip_corner(var_12, var_13, "bottom_left");
  level.pip.borders["bottom_right"] = new_l_pip_corner(var_12, var_13, "bottom_right");
  level thread pip_static();
  level thread pip_open();
  level thread pip_border();
  level thread pip_static_lines();
  pip_set_entity(var_0, var_1, var_2, var_3, var_4);
}

pip_set_entity(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.pip.entity)) {
    if(!isDefined(var_0))
      level.pip notify("stop_interference");

    level.pip.entity delete();
    level.pip.entity = undefined;
  }

  if(isDefined(var_0))
    level thread pip_interference();

  var_5 = undefined;

  if(isDefined(var_0)) {
    if(issentient(var_0)) {
      if(!isDefined(var_2)) {
        var_6 = get_world_relative_offset(var_0.origin, var_0.angles, (12, 0, 0));
        var_7 = var_0 getEye();
        var_5 = spawn("script_model", (var_6[0], var_6[1], var_7[2]));
        var_5 setModel("tag_origin");
        var_5.angles = var_0.angles;
        var_5 linkto(var_0, "j_neck");
      } else {
        var_8 = (-14, -14, 63);
        var_6 = get_world_relative_offset(var_0.origin, var_0.angles, var_8);
        var_5 = spawn("script_model", var_6);
        var_5 setModel("tag_origin");
        var_5.angles = var_0.angles + (0, 6.8, 0);
        var_5 linkto(var_0, "j_neck");
      }
    } else {
      if(isDefined(var_3)) {
        var_6 = var_0.origin + var_3;
        var_5 = spawn("script_model", var_6);
      } else
        var_5 = spawn("script_model", var_0.origin);

      var_5 setModel("tag_origin");
      var_5.angles = var_0.angles;
      var_5 linkto(var_0);
    }
  }

  level.pip.enable = 1;
  level.pip.freecamera = 1;

  if(isDefined(var_5)) {
    level.pip.entity = var_5;

    if(isDefined(var_1))
      level.pip.tag = var_1;
    else
      level.pip.tag = "tag_origin";
  } else
    level.pip.origin = level.player.origin + (0, 0, 60);

  level.pip.fov = common_scripts\utility::ter_op(isDefined(var_4), var_4, 50);
}

pip_static() {
  if(!isDefined(level.pip.static_overlay))
    var_0 = newhudelem();
  else
    var_0 = level.pip.static_overlay;

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
    var_0 = randomintrange(10, int(level.pip.height - 25));
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

  while(isDefined(level.pip) && isDefined(level.pip.static_overlay)) {
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

  foreach(var_3, var_2 in level.pip.borders)
  var_2 thread pip_open_l_corner(var_3, var_0);

  wait(var_0 + 0.05);
  level.pip.width = level.pip.opened_width;
  level.pip.height = level.pip.opened_height;
  level.pip.x = level.pip.opened_x;
  level.pip.y = level.pip.opened_y;
  level.pip.enable = 1;
  wait 0.8;
  level notify("pip_in");
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
    self.vertical.x = level.pip.opened_x - level.pip.border_thickness;
    self.horizontal moveovertime(var_1);
    self.horizontal.x = level.pip.opened_x - level.pip.border_thickness;
  } else {
    self.vertical moveovertime(var_1);
    self.vertical.x = level.pip.opened_x + level.pip.opened_width;
    self.horizontal moveovertime(var_1);
    self.horizontal.x = level.pip.opened_x + level.pip.opened_width;
  }
}

pip_disable() {
  level.pip notify("stop_interference");

  if(isDefined(level.pip.static_overlay))
    level.pip.static_overlay.alpha = 1;

  wait 0.5;
  var_0 = 0.25;
  level.pip.enableshadows = 1;

  if(isDefined(level.pip.static_overlay)) {
    level.pip.static_overlay fadeovertime(var_0);
    level.pip.static_overlay.alpha = 1;
  }

  wait(var_0);
  level.pip.enable = 0;

  if(isDefined(level.pip.linked_ent))
    level.pip.linked_ent delete();

  var_0 = 0.1;

  foreach(var_3, var_2 in level.pip.borders)
  var_2 thread pip_close_l_corner(var_3, var_0);

  if(isDefined(level.pip.static_overlay))
    level.pip.static_overlay scaleovertime(var_0, level.pip.closed_width, level.pip.closed_height);

  wait(var_0 + 0.05);
  level.pip.width = level.pip.closed_width;
  level.pip.height = level.pip.closed_height;
  level.pip.x = level.pip.closed_x;
  level.pip.y = level.pip.closed_y;

  if(isDefined(level.pip.borders))
    common_scripts\utility::array_thread(level.pip.borders, ::pip_remove_l_corners);

  if(isDefined(level.pip.static_overlay))
    level.pip.static_overlay destroy();

  if(isDefined(level.pip_display_name))
    level.pip_display_name destroy();

  if(isDefined(level.pip_timer))
    level.pip_timer destroy();

  if(isDefined(level.pip.border))
    level.pip.border destroy();

  if(isDefined(level.pip.line_a))
    level.pip.line_a destroy();

  if(isDefined(level.pip.entity)) {
    level.pip.entity delete();
    level.pip.entity = undefined;
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