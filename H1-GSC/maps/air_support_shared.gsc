/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\air_support_shared.gsc
***************************************/

air_support_precache() {
  precachemodel("wpn_h1_airsupport_marker");
  precachemodel("wpn_h1_airsupport_marker_selected");
  level._effect["airsupport_marker_vfx"] = loadfx("vfx\props\air_support_marker_glow");
  setdvar("use_new_air_support", "true");
}

#using_animtree("script_model");

air_support_create_arrow_ent() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setmodel("wpn_h1_airsupport_marker");
  var_0 useanimtree(#animtree);
  var_0 setanim( % h1_wpn_spl_airsupport_target_idle);
  var_0.offset = 4;
  playfxontag(level._effect["airsupport_marker_vfx"], var_0, "tag_fx");
  return var_0;
}

air_support_create_selection_ent(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setmodel("wpn_h1_airsupport_marker_selected");
  var_2 useanimtree(#animtree);
  var_2 setanim( % h1_wpn_spl_airsupport_target_selected);
  var_2.angles = var_1;
  return var_2;
}

air_support_update_arrow_coords(var_0, var_1) {
  var_2 = 15000;
  var_3 = [];
  var_3[0] = spawnstruct();
  var_3[0].offsetup = 0;
  var_3[0].offsetright = 0;
  var_3[0].weight = 4;
  var_3[1] = spawnstruct();
  var_3[1].offsetup = 0;
  var_3[1].offsetright = 15;
  var_3[1].weight = 1;
  var_3[2] = spawnstruct();
  var_3[2].offsetup = 0;
  var_3[2].offsetright = -15;
  var_3[2].weight = 1;
  var_3[3] = spawnstruct();
  var_3[3].offsetup = 10;
  var_3[3].offsetright = 10;
  var_3[3].weight = 2;
  var_3[4] = spawnstruct();
  var_3[4].offsetup = -10;
  var_3[4].offsetright = 10;
  var_3[4].weight = 2;
  var_3[5] = spawnstruct();
  var_3[5].offsetup = -10;
  var_3[5].offsetright = -10;
  var_3[5].weight = 2;
  var_3[6] = spawnstruct();
  var_3[6].offsetup = 10;
  var_3[6].offsetright = -10;
  var_3[6].weight = 2;
  var_4 = 0;

  for (;;) {
    wait 0.05;
    var_5 = level.player getplayerangles();
    var_6 = anglestoforward(var_5);
    var_7 = anglestoup(var_5);
    var_8 = anglestoright(var_5);
    var_9 = level.player geteye();
    var_10 = getdvar(var_1) == "1";
    var_11 = (0, 0, 0);

    for (var_12 = 0; var_12 < var_3.size; var_12++) {
      var_13 = var_9 + var_7 * var_3[var_12].offsetup + var_8 * var_3[var_12].offsetright;

      if(var_12 == 0)
        var_11 = var_13;

      var_3[var_12].trace = bullettrace(var_13, var_13 + var_6 * var_2, 0, var_0);

      if(var_10)
        thread common_scripts\utility::draw_line_for_time(var_13, var_3[var_12].trace["position"], 1, 1, 1, 0.05);
    }

    var_14 = [];
    var_15 = 0;

    for (var_12 = 0; var_12 < var_3.size; var_12++) {
      if(var_3[var_12].trace["fraction"] == 1) {
        continue;
      }
      var_16 = var_14.size;
      var_14[var_16] = spawnstruct();
      var_14[var_16].position = var_3[var_12].trace["position"];
      var_14[var_16].normal = var_3[var_12].trace["normal"];
      var_14[var_16].weight = var_3[var_12].weight;
      var_15 = var_15 + var_14[var_16].normal[2];

      if(var_10)
        thread common_scripts\utility::draw_line_for_time(var_9, var_14[var_16].position, 0, 1, 0, 0.05);
    }

    if(var_14.size == 0) {
      var_14[0] = spawnstruct();
      var_14[0].position = var_3[0].trace["position"];
      var_14[0].normal = var_3[0].trace["normal"];
      var_14[0].weight = var_3[0].weight;
      var_15 = var_14[0].normal[2];
    }

    var_15 = var_15 / var_14.size;
    var_17 = air_support_average_coords(var_14);
    var_18 = 0.5;
    var_19 = 0;

    if(var_15 > var_18)
      var_20 = air_support_find_best_floor(var_14);
    else if(var_15 < 0.0 - var_18)
      var_20 = air_support_find_best_ceiling(var_14);
    else {
      var_19 = 1;
      var_20 = air_support_average_normals(var_14);
    }

    var_21 = var_11 + var_6 * var_2;
    var_22 = bullettrace(var_11, var_21, 0, var_0);

    for (var_23 = distance(var_22["position"], var_17 * 1.5); var_23 > distance(var_22["position"], var_17); var_22 = bullettrace(var_24, var_21, 0, var_0)) {
      var_3[0].trace = var_22;
      var_24 = var_22["position"] + var_6 * 10;
      var_23 = distance(var_22["position"], var_17);
    }

    var_17 = var_3[0].trace["position"];

    if(var_10)
      thread common_scripts\utility::draw_line_for_time(var_9, var_17, 1, 0, 0, 0.05);

    thread air_support_draw_arrow(var_0, var_17, var_20, var_8, var_4, var_19);

    if(var_10)
      maps\_debug::drawarrow(var_0.origin, var_0.angles);

    var_4 = 0.2;
  }
}

air_support_average_coords(var_0) {
  var_1 = (0, 0, 0);
  var_2 = 0;

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_1 = var_1 + var_0[var_3].position * var_0[var_3].weight;
    var_2 = var_2 + var_0[var_3].weight;
  }

  if(var_2 > 0)
    var_1 = var_1 / var_2;

  return var_1;
}

air_support_average_normals(var_0) {
  var_1 = (0, 0, 0);
  var_2 = 0;

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_1 = var_1 + var_0[var_3].normal * var_0[var_3].weight;
    var_2 = var_2 + var_0[var_3].weight;
  }

  if(var_2 > 0)
    var_1 = var_1 / var_2;

  return var_1;
}

air_support_find_best_floor(var_0) {
  var_1 = var_0[0].normal;

  for (var_2 = 1; var_2 < var_0.size; var_2++) {
    if(var_0[var_2].normal[2] > var_1[2])
      var_1 = var_0[var_2].normal;
  }

  return var_1;
}

air_support_find_best_ceiling(var_0) {
  var_1 = var_0[0].normal;

  for (var_2 = 1; var_2 < var_0.size; var_2++) {
    if(var_0[var_2].normal[2] < var_1[2])
      var_1 = var_0[var_2].normal;
  }

  return var_1;
}

air_support_draw_arrow(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 = var_1 + maps\_utility::vector_multiply(var_2, var_0.offset);
  var_0.origin = var_1;

  if(var_5) {
    var_6 = (0, 0, 1);
    var_7 = vectornormalize(vectorcross(var_2, var_6));
    var_8 = axistoangles(var_2, var_7, var_6);
  } else {
    var_6 = common_scripts\utility::ter_op(var_2[2] > 0, var_2, -1 * var_2);
    var_7 = -1 * var_3;
    var_9 = vectornormalize(vectorcross(var_6, var_7));
    var_8 = axistoangles(var_9, var_7, var_6);
  }

  if(!var_5)
    var_8 = var_8 - (90, 0, 0) * common_scripts\utility::sign(var_2[2]);

  if(var_4 > 0)
    var_0 rotateto(var_8, var_4);
  else
    var_0.angles = var_8;
}