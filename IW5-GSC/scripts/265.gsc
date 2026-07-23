/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\265.gsc
**************************************/

main(var_0) {
  var_1 = getEntArray("painter_setup", "targetname");

  if(!var_1.size) {
    return;
  }
  if(!getdvarint("painter")) {
    common_scripts\utility::array_thread(var_1, ::painter_clean_me);
    return;
  }

  painter_initvars(var_0);
  var_2 = [];
  var_3 = get_painter_groups(var_1);

  foreach(var_5 in var_3) {}
  setup_painter_group(var_5);

  thread painter_init();
  common_scripts\utility::array_thread(level.spam_model_group, ::default_undefined);
  level.stop_load = 1;
  level waittill("forever");
}

painter_clean_me() {
  if(isDefined(self.target)) {
    var_0 = getEnt(self.target, "targetname");
    var_0 delete();
  }

  self delete();
}

default_undefined() {
  if(!isDefined(self.bposedstyle)) {
    self.bposedstyle = 0;
  }
  if(!isDefined(self.borienttoplayeryrot)) {
    self.borienttoplayeryrot = 0;
  }
  if(!isDefined(self.btreeorient)) {
    self.btreeorient = 0;
  }
  if(!isDefined(self.bfacade)) {
    self.bfacade = 0;
  }
  if(!isDefined(self.density)) {
    self.density = 32;
  }
  if(!isDefined(self.radius)) {
    self.radius = 84;
  }
  if(!isDefined(self.maxdist)) {
    self.maxdist = 1000;
  }
  if(!isDefined(self.angleoffset)) {
    self.angleoffset = [];
  }
}

setup_painter_group(var_0) {
  var_1 = 100000001;
  var_2 = var_0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  foreach(var_12 in var_0) {
    var_10 = get_angle_offset(var_12);
    var_7 = get_height_offset(var_12);
    var_13 = isDefined(var_12.script_parameters) && var_12.script_parameters == "use_prefab_model";

    if(isDefined(var_12.radius)) {
      var_5 = var_12.radius;
    }
    if(isDefined(var_12.script_painter_treeorient) && var_12.script_painter_treeorient) {
      var_3 = 1;
    }
    if(isDefined(var_12.script_painter_maxdist) && var_12.script_painter_maxdist) {
      var_6 = var_12.script_painter_maxdist;
    }
    if(isDefined(var_12.script_painter_facade) && var_12.script_painter_facade) {
      var_4 = 1;
    }
    foreach(var_15 in var_2) {
      if(var_12 == var_15) {
        continue;
      }
      var_16 = distance(var_12.origin, var_15.origin);

      if(var_16 < var_1) {
        var_1 = var_16;
      }
    }

    if(var_1 == 100000001) {
      var_1 = undefined;
    }
    add_spammodel(var_12.script_paintergroup, var_12.model, var_3, var_4, var_1, var_5, var_6, var_7, var_8, var_9, var_10, var_13);
  }
}

get_angle_offset(var_0) {
  if(!isDefined(var_0.target)) {
    return undefined;
  }
  var_1 = getEnt(var_0.target, "targetname");
  return var_1.angles - var_0.angles;
}

get_height_offset(var_0) {
  if(!isDefined(var_0.target)) {
    return undefined;
  }
  var_1 = getEnt(var_0.target, "targetname");
  var_2 = var_1.origin[2] - var_0.origin[2];
  var_1 delete();
  return var_2;
}

get_painter_groups(var_0) {
  var_1 = [];
  var_2 = "";

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.script_paintergroup)) {
      var_4.script_paintergroup = var_4.model;
    }
    var_2 = var_4.script_paintergroup;
    level.painter_startgroup = var_2;

    if(!isDefined(var_1[var_2]) || !var_1[var_2].size) {
      var_1[var_2] = [];
    }
    var_1[var_2][var_1[var_2].size] = var_4;
  }

  return var_1;
}

painter_initvars(var_0) {
  level._clearalltextafterhudelem = 0;
  level.bposedstyle = 0;
  level.borienttoplayeryrot = 0;
  level.spam_density_scale = 16;
  level.spaming_models = 0;
  level.spam_model_group = [];
  level.spamed_models = [];
  level.spam_models_flowrate = 0.1;
  level.spam_model_radius = 31;
  level.spam_maxdist = 1000;
  level.previewmodels = [];
  level.spam_models_iscustomrotation = 0;
  level.spam_models_iscustomheight = 0;
  level.spam_models_customheight = 0;
  level.spam_model_circlescale_lasttime = 0;
  level.spam_model_circlescale_accumtime = 0;
  level.paintadd = ::add_spammodel;
  level.timelimitoverride = 1;
  thread hack_start(var_0);
  thread hud_init();
}

hack_start(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "painter";
  }
  precachemenu(var_0);
  common_scripts\utility::flag_init("user_alive");

  while(!isDefined(get_player())) {
    wait 0.05;
  }
  level.painter_player = get_player();
  wait 0.05;
  var_1 = "team_marinesopfor";
  var_2 = "autoassign";
  level.painter_player notify("menuresponse", var_1, var_2);
  wait 0.05;
  var_1 = "changeclass_offline";
  var_2 = "offline_class1_mp, 0";
  level.painter_player notify("menuresponse", var_1, var_2);
  level.painter_player openpopupmenu(var_0);
  wait 0.05;
  level.painter_player closepopupmenu();
  common_scripts\utility::flag_set("user_alive");
}

painter_init() {
  common_scripts\utility::array_call(getEntArray("script_model", "classname"), ::delete);
  setcurrentgroup(level.painter_startgroup);
  level.painter_startgroup = undefined;
  playerinit();
}

hud_update_placed_model_count() {
  level.hud_controler["helppm"].description setvalue(level.spamed_models.size);
  var_0 = 256;

  if(level.spamed_models.size < var_0) {
    level.hud_controler["helppm"].description.color = (1, 1, 1);
    return;
  }

  var_1 = 1;
  var_2 = 1 - (level.spamed_models.size - var_0) / var_0;
  var_3 = var_2;
  level.hud_controler["helppm"].description.color = (var_1, var_2, var_3);
}

hud_init() {
  common_scripts\utility::flag_init("user_hud_active");
  common_scripts\utility::flag_wait("user_alive");
  var_0 = 7;

  if(is_mp()) {
    var_0 = 7;
  }
  var_1 = [];
  var_2 = 15;
  var_3 = int(var_0 / 2);
  var_4 = 240 + var_3 * var_2;
  var_5 = 0.5 / var_3;
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
    var_1[var_7].x = 20;
    var_1[var_7].y = var_4;
    var_1[var_7] _settext(".");

    if(var_7 == var_3) {
      var_5 = var_5 * -1;
    }
    var_6 = var_6 + var_5;
    var_4 = var_4 - var_2;
  }

  level.spam_group_hudelems = var_1;
  var_8 = _newhudelem();
  var_8.location = 0;
  var_8.alignx = "center";
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
  controler_hud_add("helppm", 1, "^5Placed Models: ", undefined, level.spamed_models.size);
  controler_hud_add("helpdensity", 2, "^5Spacing: ", undefined, level.spam_density_scale);
  controler_hud_add("helpradius", 3, "^5Radius: ", undefined, level.spam_model_radius);
  controler_hud_add("helpxy", 6, "^4X / ^3Y: ", undefined, level.spam_model_radius);
  controler_hud_add("helpab", 7, "^2A / ^1B^7: ", " - ");
  controler_hud_add("helplsrs", 8, "^8L^7 / R Stick: ", " - ");
  controler_hud_add("helplbrb", 9, "^8L^7 / R Shoulder: ", " - ");
  controler_hud_add("helpdpu", 10, "^8DPad U / ^7D: ", " - ");
  controler_hud_add("helpdpl", 11, "^8DPad L / ^7R: ", " - ");
  controler_hud_add("helpF", 17, "^8F: ^7( dump ) ^3map_source/" + level.script + "_modeldump.map", "");
  hint_buttons_main();
  common_scripts\utility::flag_set("user_hud_active");
}

hint_buttons_main() {
  controler_hud_update_text("helpxy", "^4Select Set Up ^7 / ^3Down");
  controler_hud_update_text("helpab", "^2Spacing Down ^7 / ^1up ");
  controler_hud_update_text("helplsrs", "^8Radius Down ^7 / Up");
  controler_hud_update_text("helplbrb", "^8Remove ^7 / Place");
  controler_hud_update_text("helpdpl", "^8zOffset Clear ^7 / Set");
  controler_hud_update_text("helpdpu", "^8Rotation Clear ^7 / Set");
}

hint_buttons_zoffset() {
  controler_hud_update_text("helpxy", "^4 - ^7 / ^3 - ");
  controler_hud_update_text("helpab", "^2Height Down ^7 / ^1Up ");
  controler_hud_update_text("helplsrs", "^8 - ^7 / - ");
  controler_hud_update_text("helplbrb", "^8 - ^7 / - ");
  controler_hud_update_text("helpdpl", "^8 - ^7 / Set");
  controler_hud_update_text("helpdpu", "^8 - ^7 / - ");
  controler_hud_update_text("helpF", " - ");
}

hint_buttons_rotation() {
  controler_hud_update_text("helpxy", "^4 - ^7 / ^3 - ");
  controler_hud_update_text("helpab", "^2RotateOther Up ^7 / ^1Down ");
  controler_hud_update_text("helplsrs", "^8 - ^7 / - ");
  controler_hud_update_text("helplbrb", "^8 - ^7 / - ");
  controler_hud_update_text("helpdpl", "^8 - ^7 / - ");
  controler_hud_update_text("helpdpu", "^8Set ^7 / - ");
  controler_hud_update_text("helpF", " - ");
}

setcurrentgroup(var_0) {
  common_scripts\utility::flag_wait("user_hud_active");
  level.spam_model_current_group = var_0;
  var_1 = getarraykeys(level.spam_model_group);
  var_2 = 0;
  var_3 = int(level.spam_group_hudelems.size / 2);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_1[var_4] == var_0) {
      var_2 = var_4;
      break;
    }
  }

  level.spam_group_hudelems[var_3] _settext(var_1[var_2]);

  for(var_4 = 1; var_4 < level.spam_group_hudelems.size - var_3; var_4++) {
    if(var_2 - var_4 < 0) {
      level.spam_group_hudelems[var_3 + var_4] _settext(".");
      continue;
    }

    level.spam_group_hudelems[var_3 + var_4] _settext(var_1[var_2 - var_4]);
  }

  for(var_4 = 1; var_4 < level.spam_group_hudelems.size - var_3; var_4++) {
    if(var_2 + var_4 > var_1.size - 1) {
      level.spam_group_hudelems[var_3 - var_4] _settext(".");
      continue;
    }

    level.spam_group_hudelems[var_3 - var_4] _settext(var_1[var_2 + var_4]);
  }

  var_0 = getcurrent_groupstruct();
  level.borienttoplayeryrot = var_0.borienttoplayeryrot;
  level.bposedstyle = var_0.bposedstyle;
  level.spam_maxdist = var_0.maxdist;
  level.spam_model_radius = var_0.radius;
  level.hud_controler["helpradius"].description setvalue(level.spam_model_radius);
  level.spam_density_scale = var_0.density;
  level.hud_controler["helpdensity"].description setvalue(level.spam_density_scale);
}

setgroup_up() {
  var_0 = undefined;
  var_1 = getarraykeys(level.spam_model_group);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level.spam_model_current_group) {
      var_0 = var_2 + 1;
      break;
    }
  }

  if(var_0 == var_1.size) {
    return;
  }
  setcurrentgroup(var_1[var_0]);

  while(level.painter_player buttonPressed("BUTTON_Y")) {
    wait 0.05;
  }
}

setgroup_down() {
  var_0 = undefined;
  var_1 = getarraykeys(level.spam_model_group);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level.spam_model_current_group) {
      var_0 = var_2 - 1;
      break;
    }
  }

  if(var_0 < 0) {
    return;
  }
  setcurrentgroup(var_1[var_0]);

  while(level.painter_player buttonPressed("BUTTON_X")) {
    wait 0.05;
  }
}

add_spammodel(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(level.spam_model_group[var_0])) {
    var_12 = spawnStruct();
    level.spam_model_group[var_0] = var_12;
    level.spam_model_group[var_0].models = [];
  }

  if(!isDefined(var_10)) {
    var_10 = (0, 0, 0);
  }
  level.spam_model_group[var_0].bfacade = var_3;
  level.spam_model_group[var_0].btreeorient = var_2;
  level.spam_model_group[var_0].density = var_4;
  level.spam_model_group[var_0].radius = var_5;
  level.spam_model_group[var_0].maxdist = var_6;
  level.spam_model_group[var_0].bposedstyle = var_8;
  level.spam_model_group[var_0].borienttoplayeryrot = var_9;

  if(!isDefined(level.spam_model_group[var_0].angleoffset)) {
    level.spam_model_group[var_0].angleoffset = [];
  }
  level.spam_model_group[var_0].angleoffset[var_1] = var_10;

  if(!isDefined(level.spam_model_group[var_0].heightoffset)) {
    level.spam_model_group[var_0].heightoffset = [];
  }
  level.spam_model_group[var_0].heightoffset[var_1] = var_7;

  if(!isDefined(level.spam_model_group[var_0].modelusesprefab)) {
    level.spam_model_group[var_0].modelusesprefab = [];
  }
  level.spam_model_group[var_0].modelusesprefab[var_1] = var_11;
  level.spam_model_group[var_0].models[level.spam_model_group[var_0].models.size] = var_1;
}

playerinit() {
  level.painter_max = 700;
  level.painter_player takeallweapons();
  common_scripts\utility::flag_wait("user_hud_active");

  for(;;) {
    var_0 = player_view_trace();
    draw_placement_circle(var_0);

    if(level.painter_player buttonPressed("f")) {
      dump_models();
    }
    if(level.painter_player buttonPressed("DPAD_UP")) {
      customrotation_mode(var_0, "DPAD_UP");
    } else if(level.painter_player buttonPressed("DPAD_DOWN")) {
      customrotation_mode_off();
    } else if(level.painter_player buttonPressed("DPAD_RIGHT")) {
      customheight_mode(var_0, "DPAD_RIGHT");
    } else if(level.painter_player buttonPressed("DPAD_LEFT")) {
      customheight_mode_off();
    } else if(level.painter_player buttonPressed("BUTTON_X")) {
      setgroup_down();
    } else if(level.painter_player buttonPressed("BUTTON_Y")) {
      setgroup_up();
    } else if(level.painter_player buttonPressed("BUTTON_LSTICK")) {
      spam_model_circlescale(var_0, -1);
    } else if(level.painter_player buttonPressed("BUTTON_RSTICK")) {
      spam_model_circlescale(var_0, 1);
    } else if(level.painter_player buttonPressed("BUTTON_A")) {
      spam_model_densityscale(var_0, -1);
    } else if(level.painter_player buttonPressed("BUTTON_B")) {
      spam_model_densityscale(var_0, 1);
    } else {
      if(level.painter_player buttonPressed("BUTTON_LSHLDR")) {
        spam_model_erase(var_0);
      }
      if(level.painter_player buttonPressed("BUTTON_RSHLDR")) {
        thread spam_model_place(var_0);
      }
    }

    level notify("clear_previews");
    wait 0.05;
    hud_update_placed_model_count();
  }
}

customheight_mode_off() {
  level.spam_models_iscustomheight = 0;
  hint_buttons_main();
}

customheight_mode(var_0, var_1) {
  if(var_0["fraction"] == 1) {
    return;
  }
  while(level.painter_player buttonPressed(var_1)) {
    wait 0.05;
  }
  level.spam_models_iscustomheight = 1;
  hint_buttons_zoffset();
  var_2 = [];
  var_2 = spam_models_atcircle(var_0, 0, 1);
  var_3 = 2;
  var_4 = 1;
  var_5 = var_0["position"];

  while(!level.painter_player buttonPressed(var_1)) {
    var_6 = level.spam_models_customheight;

    if(level.painter_player buttonPressed("BUTTON_A")) {
      var_4 = -1;
    } else if(level.painter_player buttonPressed("BUTTON_B")) {
      var_4 = 1;
    } else {
      var_4 = 0;
    }
    var_6 = var_6 + var_4 * var_3;

    if(var_6 == 0) {
      var_6 = var_6 + var_4 * var_3;
    }
    level.spam_models_customheight = var_6;
    common_scripts\utility::array_thread(var_2, ::customheight_mode_offsetmodels, var_0);
    draw_placement_circle(var_0, (1, 1, 1));
    wait 0.05;
  }

  common_scripts\utility::array_thread(var_2, ::deleteme);
  hint_buttons_main();

  while(level.painter_player buttonPressed(var_1)) {
    wait 0.05;
  }
}

customheight_mode_offsetmodels(var_0) {
  self.origin = self.orgorg + var_0["normal"] * level.spam_models_customheight;
}

customrotation_mode_off() {
  level.spam_models_iscustomrotation = 0;
  hint_buttons_main();
}

customrotation_mode(var_0, var_1) {
  if(var_0["fraction"] == 1) {
    return;
  }
  while(level.painter_player buttonPressed(var_1)) {
    wait 0.05;
  }
  hint_buttons_rotation();
  level.spam_models_iscustomrotation = 1;
  level.spam_models_customrotation = level.painter_player getplayerangles();
  var_2 = [];
  var_2 = spam_models_atcircle(var_0, 1, 1);
  var_3 = 0;
  var_4 = 1;
  var_5 = 0;

  while(!level.painter_player buttonPressed(var_1)) {
    var_5 = 0;

    if(level.painter_player buttonPressed("BUTTON_A")) {
      var_5 = -1;
    } else if(level.painter_player buttonPressed("BUTTON_B")) {
      var_5 = 1;
    }
    var_3 = var_3 + var_5 * var_4;

    if(var_3 > 360) {
      var_3 = 1;
    }
    if(var_3 < 0) {
      var_3 = 359;
    }
    draw_placement_circle(var_0, (0, 0, 1));
    level.spam_models_customrotation = level.painter_player getplayerangles();
    level.spam_models_customrotation = level.spam_models_customrotation + (0, 0, var_3);

    for(var_6 = 0; var_6 < var_2.size; var_6++) {
      var_2[var_6].angles = level.spam_models_customrotation;
    }
    wait 0.05;
  }

  hint_buttons_main();

  while(level.painter_player buttonPressed(var_1)) {
    wait 0.05;
  }
  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_2[var_6] thread deleteme();
  }
}

deleteme() {
  self delete();
}

spam_model_clearcondition() {
  self endon("death");
  level waittill("clear_previews");
  level.previewmodels = common_scripts\utility::array_remove(level.previewmodels, self);
  self delete();
}

crosshair_fadetopoint() {
  level notify("crosshair_fadetopoint");
  level endon("crosshair_fadetopoint");
  wait 2;
  level.crosshair_value.alpha = 0;
  level.crosshair.alpha = 1;
}

spam_model_circlescale(var_0, var_1) {
  if(gettime() - level.spam_model_circlescale_lasttime > 60) {
    level.spam_model_circlescale_accumtime = 0;
  }
  level.spam_model_circlescale_accumtime = level.spam_model_circlescale_accumtime + 0.05;

  if(level.spam_model_circlescale_accumtime < 0.5) {
    var_2 = 2;
  } else {
    var_2 = level.spam_model_circlescale_accumtime / 0.3;
  }
  var_3 = level.spam_model_radius;
  var_3 = var_3 + var_1 * var_2;

  if(var_3 > 0) {
    level.spam_model_radius = var_3;
  }
  level.hud_controler["helpradius"].description setvalue(level.spam_model_radius);
  level.spam_model_circlescale_lasttime = gettime();
}

spam_model_densityscale(var_0, var_1) {
  var_2 = 2;
  var_3 = level.spam_density_scale;
  var_3 = var_3 + var_1 * var_2;

  if(var_3 > 0) {
    level.spam_density_scale = var_3;
  }
  level.crosshair_value.alpha = 1;
  level.crosshair.alpha = 0;
  level.crosshair_value setvalue(level.spam_density_scale);
  level.hud_controler["helpdensity"].description setvalue(level.spam_density_scale);
  thread crosshair_fadetopoint();
}

draw_placement_circle(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 1, 0);
  }
  if(var_0["fraction"] == 1) {
    return;
  }
  var_2 = vectortoangles(var_0["normal"]);
  var_3 = var_0["position"];
  var_4 = level.spam_model_radius;
  plot_circle(var_3, var_4, var_2, var_1, 40, level.spam_model_radius);

  if(level.spam_models_iscustomrotation) {
    draw_axis(var_3, level.spam_models_customrotation);
  }
  if(level.spam_models_iscustomheight) {
    common_scripts\utility::draw_arrow(var_3, var_3 + var_0["normal"] * level.spam_models_customheight, (1, 1, 1));
  }
}

player_view_trace() {
  var_0 = level.spam_maxdist;
  var_1 = level.painter_player getEye();
  return bulletTrace(var_1, var_1 + anglesToForward(level.painter_player getplayerangles()) * var_0, 0, self);
}

orienttoplayeryrot() {
  self addyaw(level.painter_player getplayerangles()[1] - common_scripts\utility::flat_angle(self.angles)[1]);
}

getcurrent_groupstruct() {
  return level.spam_model_group[level.spam_model_current_group];
}

orient_model() {
  var_0 = getcurrent_groupstruct();

  if(level.spam_models_iscustomrotation) {
    self.angles = level.spam_models_customrotation;
    return;
  }

  if(level.bposedstyle) {
    self.angles = level.painter_player getplayerangles();
  }
  if(level.borienttoplayeryrot) {
    orienttoplayeryrot();
  }
  if(var_0.btreeorient) {
    self.angles = common_scripts\utility::flat_angle(self.angles);
  }
  if(!level.borienttoplayeryrot && !level.bposedstyle) {
    self addyaw(randomint(360));
  }
  if(var_0.bfacade) {
    self.angles = common_scripts\utility::flat_angle(vectortoangles(self.origin - level.painter_player getEye()));
    self addyaw(90);
  }

  self addroll(var_0.angleoffset[self.model][0]);
  self addpitch(var_0.angleoffset[self.model][1]);
  self addyaw(var_0.angleoffset[self.model][2]);
}

spam_model_place(var_0) {
  if(level.spaming_models) {
    return;
  }
  if(var_0["fraction"] == 1 && !level.bposedstyle) {
    return;
  }
  level.spaming_models = 1;
  var_1 = spam_models_atcircle(var_0, 1);
  level.spamed_models = common_scripts\utility::array_combine(level.spamed_models, var_1);
  level.spaming_models = 0;
}

getrandom_spammodel() {
  var_0 = level.spam_model_group[level.spam_model_current_group].models;
  return var_0[randomint(var_0.size)];
}

spam_models_atcircle(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  var_3 = [];
  var_4 = level.spam_density_scale;
  var_5 = level.spam_model_radius;
  var_6 = int(var_5 / var_4) * 2;
  var_7 = 0;
  var_8 = var_0["position"];
  var_9 = vectortoangles(var_0["normal"]);

  if(var_1) {
    var_9 = var_9 + (0, randomfloat(360), 0);
  }
  var_10 = vectorNormalize(anglestoright(var_9));
  var_11 = vectorNormalize(anglestoup(var_9));
  var_12 = var_8;
  var_12 = var_12 - var_10 * var_5;
  var_12 = var_12 - var_11 * var_5;
  var_12 = var_12 + var_10 * var_4;
  var_12 = var_12 + var_11 * var_4;
  var_13 = var_12;

  if(var_6 == 0 || level.bposedstyle) {
    if(!var_2) {
      if(is_too_dense(var_8)) {
        return var_3;
      }
    }

    if(!var_2) {
      if(level.spamed_models.size + var_3.size > level.painter_max) {
        return var_3;
      }
    }

    var_14 = getrandom_spammodel();
    var_3[0] = spam_modelattrace(var_0, var_14);
    var_3[0] orient_model();
    return var_3;
  }

  var_15 = [];

  for(var_16 = var_7; var_16 < var_6; var_16++) {
    for(var_17 = var_7; var_17 < var_6; var_17++) {
      if(!var_2) {
        if(level.spamed_models.size + var_3.size > level.painter_max) {
          return var_3;
        }
      }

      var_13 = var_12;
      var_13 = var_13 + var_10 * var_16 * var_4;
      var_13 = var_13 + var_11 * var_17 * var_4;

      if(distance(var_13, var_8) > var_5) {
        continue;
      }
      var_15 = contour_point(var_13, var_9, level.spam_model_radius);

      if(var_15["fraction"] == 1) {
        continue;
      }
      if(is_too_dense(var_15["position"])) {
        continue;
      }
      var_14 = getrandom_spammodel();
      var_18 = spam_modelattrace(var_15, var_14);
      var_18 orient_model();
      var_3[var_3.size] = var_18;
    }
  }

  return var_3;
}

is_too_dense(var_0) {
  for(var_1 = level.spamed_models.size - 1; var_1 >= 0; var_1--) {
    if(distance(level.spamed_models[var_1].orgorg, var_0) < level.spam_density_scale - 1) {
      return 1;
    }
  }

  return 0;
}

get_player() {
  return getEntArray("player", "classname")[0];
}

spam_modelattrace(var_0, var_1) {
  var_2 = spawn("script_model", level.painter_player.origin);
  var_2 setModel(var_1);
  var_2 notsolid();
  var_2.origin = var_0["position"];
  var_2.angles = vectortoangles(var_0["normal"]);
  var_2 addpitch(90);
  var_2.orgorg = var_2.origin;
  var_3 = getcurrent_groupstruct();

  if(level.spam_models_iscustomheight) {
    var_2.origin = var_2.origin + var_0["normal"] * level.spam_models_customheight;
  }
  var_3 = getcurrent_groupstruct();

  if(isDefined(var_3.heightoffset[var_1])) {
    var_2.origin = var_2.origin + var_0["normal"] * var_3.heightoffset[var_1];
  }
  if(isDefined(var_3.modelusesprefab[var_1])) {
    var_2.modelusesprefab = var_3.modelusesprefab[var_1];
  }
  return var_2;
}

contour_point(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = anglesToForward(var_1);
  var_5 = var_0 + var_4 * var_3;
  var_6 = var_0 + var_4 * -1 * var_3;
  return bulletTrace(var_5, var_6, 0, level.painter_player);
}

plot_circle(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    var_3 = (0, 1, 0);
  }
  if(!isDefined(var_4)) {
    var_4 = 16;
  }
  var_6 = var_4 / 2;
  var_7 = 360 / var_4;
  var_4++;
  var_8 = [];
  var_9 = 0;
  var_8 = [];
  var_9 = 0.0;

  for(var_10 = 0; var_10 < var_4; var_10++) {
    var_11 = var_0 + anglestoup(var_2 + (0, 0, var_9)) * var_1;
    var_12 = contour_point(var_11, var_2, level.spam_model_radius);

    if(var_12["fraction"] != 1) {
      var_8[var_8.size] = var_12["position"];
    }
    var_9 = var_9 + var_7;
  }

  common_scripts\utility::plot_points(var_8, var_3[0], var_3[1], var_3[2]);
  var_8 = [];
}

spam_model_erase(var_0) {
  var_1 = var_0["position"];
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < level.spamed_models.size; var_4++) {
    if(distance(level.spamed_models[var_4].orgorg, var_1) > level.spam_model_radius) {
      var_2[var_2.size] = level.spamed_models[var_4];
      continue;
    }

    var_3[var_3.size] = level.spamed_models[var_4];
  }

  level.spamed_models = var_2;

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_3[var_4] delete();
  }
}

dump_models() {}

draw_axis(var_0, var_1) {
  var_2 = 32;
  var_3 = var_2 * anglesToForward(var_1);
  var_4 = var_2 * anglestoright(var_1);
  var_5 = var_2 * anglestoup(var_1);
}

_newhudelem() {
  if(!isDefined(level.scripted_elems)) {
    level.scripted_elems = [];
  }
  var_0 = newhudelem();
  level.scripted_elems[level.scripted_elems.size] = var_0;
  return var_0;
}

_settext(var_0) {
  self.realtext = var_0;
  self settext("_");
  thread _clearalltextafterhudelem();
  var_1 = 0;

  foreach(var_3 in level.scripted_elems) {
    if(isDefined(var_3.realtext)) {
      var_1 = var_1 + var_3.realtext.size;
      var_3 settext(var_3.realtext);
    }
  }
}

controler_hud_add(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 520;

  if(is_mp()) {
    var_5 = 630;
  }
  var_6 = 120;
  var_7 = 18;
  var_8 = 0.8;
  var_9 = 20;
  var_10 = 1.4;

  if(!isDefined(var_2)) {
    var_2 = "";
  }
  if(!isDefined(level.hud_controler) || !isDefined(level.hud_controler[var_0])) {
    level.hud_controler[var_0] = _newhudelem();
    var_11 = _newhudelem();
  } else {
    var_11 = level.hud_controler[var_0].description;
  }
  level.hud_controler[var_0].location = 0;
  level.hud_controler[var_0].alignx = "right";
  level.hud_controler[var_0].aligny = "middle";
  level.hud_controler[var_0].foreground = 1;
  level.hud_controler[var_0].fontscale = 1.5;
  level.hud_controler[var_0].sort = 20;
  level.hud_controler[var_0].alpha = var_8;
  level.hud_controler[var_0].x = var_5 + var_9;
  level.hud_controler[var_0].y = var_6 + var_1 * var_7;
  level.hud_controler[var_0] _settext(var_2);
  level.hud_controler[var_0].base_button_text = var_2;
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
  level.hud_controler[var_0].description = var_11;
}

controler_hud_update_text(var_0, var_1) {
  if(is_mp()) {
    level.hud_controler[var_0] _settext(level.hud_controler[var_0].base_button_text + var_1);
    level.hud_controler[var_0].description _settext("");
  } else {
    level.hud_controler[var_0].description _settext(var_1);
  }
}

controler_hud_update_button(var_0, var_1) {
  level.hud_controler[var_0] _settext(var_1);
}

_clearalltextafterhudelem() {
  if(level._clearalltextafterhudelem) {
    return;
  }
  level._clearalltextafterhudelem = 1;
  self clearalltextafterhudelem();
  wait 0.05;
  level._clearalltextafterhudelem = 0;
}

is_mp() {
  return issubstr(level.script, "mp_");
}