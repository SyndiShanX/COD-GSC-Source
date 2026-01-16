/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_lighting.gsc
********************************/

light_init() {
  if(!isdefined(level._light)) {
    level._light = spawnstruct();
    light_setup_global_dvars();
    light_setup_common_dof_presets();
    light_setup_common_dof_viewmodel_presets();
    light_setup_common_flickerlight_presets();
    light_setup_pulse_presets();
    light_message_init();
    thread init_scriptable_primary_lights();
  }

  thread setup_emissive_modifiers();
}

init_scriptable_primary_lights() {
  level.scriptable_primary_light_override = 0;
  level.scr_prim_light = undefined;
  wait 0.05;
}

execute_scriptable_primary_light(var_0) {
  var_1 = level.scr_prim_lght[var_0];
  var_1.state = 0;
  var_1.trans_time[0] = 0;
  thread execute_primary_light_setkey_internal(0, var_1);

  for (var_4 = 1; var_4 < var_1.trans_time.size; var_4++)
    maps\_utility::delaythread(var_1.time[var_4], ::execute_primary_light_setkey_internal, var_4, var_1);
}

scriptable_primary_light_think(var_0, var_1) {
  var_2 = getdvarint("scr_prim_edit_lights");
  var_3 = getdvarint("scr_prim_light_state");
  var_4 = getdvarint("scr_prim_light_num");
  var_5 = var_0.intensity["curr"];

  while (var_0.active) {
    var_6 = var_0.pos["curr"];
    var_7 = var_0.dir["curr"];
    var_8 = vectornormalize(anglestoforward(var_0.dir["curr"]));
    var_9 = var_0.pos["curr"];
    var_10 = var_0.intensity["curr"];
    var_11 = var_0.color["curr"];
    var_12 = var_0.innercone["curr"];
    var_13 = var_0.outercone["curr"];
    var_14 = var_0.radius["curr"];
    var_15 = var_0.light_number;

    if(isdefined(var_0.attach_ent)) {
      var_19 = var_0.attach_tag.origin;
      var_20 = vectornormalize(anglestoforward(var_0.attach_tag.angles));
      var_21 = vectornormalize(anglestoup(var_0.attach_tag.angles));
      var_22 = vectornormalize(anglestoright(var_0.attach_tag.angles));
      var_23 = vectornormalize(var_20 * var_8[0] + var_21 * var_8[2] - var_22 * var_8[1]);
      var_24 = var_20 * var_6[0] + var_21 * var_6[2] - var_22 * var_6[1];
      var_0.primary_light unlink();
      var_0.primary_light.angles = vectortoangles(var_23);
      var_0.primary_light.origin = var_19 + var_24;

      if(isdefined(var_0.coi_ent)) {
        var_25 = var_0.coi_ent gettagorigin(var_0.coi_bone);
        var_0.primary_light.angles = vectortoangles(vectornormalize(var_25 - var_0.primary_light.origin));
      }

      if(isdefined(var_0.coi_pos))
        var_0.primary_light.angles = vectortoangles(vectornormalize(var_0.coi_pos - var_0.primary_light.origin));

      var_0.primary_light linkto(var_0.attach_tag);
    } else {
      var_0.primary_light.angles = var_7;

      if(isdefined(var_0.coi_ent)) {
        var_25 = var_0.coi_ent gettagorigin(var_0.coi_bone);
        var_0.primary_light.angles = vectortoangles(vectornormalize(var_25 - var_0.primary_light.origin));
      }

      if(isdefined(var_0.coi_pos))
        var_0.primary_light.angles = vectortoangles(vectornormalize(var_0.coi_pos - var_0.primary_light.origin));

      var_0.primary_light.origin = var_6;
    }

    var_0.primary_light setlightintensity(var_10);
    var_0.primary_light setlightcolor(var_11);
    var_0.primary_light setlightfovrange(var_13, var_12);
    var_0.primary_light setlightradius(var_14);
    wait 0.05;
  }
}

execute_primary_light_setkey_internal(var_0, var_1) {
  var_2 = var_1.trans_time[var_0] * 20.0;
  var_3 = var_0 - 1;

  for (var_4 = 0; var_4 < var_2; var_4++) {
    var_5 = float(var_4) / var_2;
    var_6 = 1.0 - var_5;
    var_1.pos["curr"] = var_1.pos[var_0] * var_5 + var_1.pos[var_3] * var_6;
    var_1.dir["curr"] = var_1.dir[var_0] * var_5 + var_1.dir[var_3] * var_6;
    var_1.intensity["curr"] = var_1.intensity[var_0] * var_5 + var_1.intensity[var_3] * var_6;
    var_1.color["curr"] = var_1.color[var_0] * var_5 + var_1.color[var_3] * var_6;
    var_1.innercone["curr"] = var_1.innercone[var_0] * var_5 + var_1.innercone[var_3] * var_6;
    var_1.outercone["curr"] = var_1.outercone[var_0] * var_5 + var_1.outercone[var_3] * var_6;
    var_1.radius["curr"] = var_1.radius[var_0] * var_5 + var_1.radius[var_3] * var_6;
    wait 0.05;
  }

  var_1.pos["curr"] = var_1.pos[var_0];
  var_1.dir["curr"] = var_1.dir[var_0];
  var_1.intensity["curr"] = var_1.intensity[var_0];
  var_1.color["curr"] = var_1.color[var_0];
  var_1.innercone["curr"] = var_1.innercone[var_0];
  var_1.outercone["curr"] = var_1.outercone[var_0];
  var_1.radius["curr"] = var_1.radius[var_0];
  var_1.state = var_0;
}

stop_scriptable_primary_light(var_0) {
  var_1 = level.scr_prim_lght[var_0];
  var_1.active = 0;

  if(isdefined(var_1.attach_ent)) {
    if(isdefined(var_1.primary_light))
      var_1.primary_light unlink();
  }
}

setup_scriptable_primary_light(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isdefined(var_3))
    var_3 = (0, 0, 0);

  if(!isdefined(var_2))
    var_2 = (0, 0, 0);

  if(!isdefined(var_4))
    var_4 = 5000;

  if(!isdefined(var_5))
    var_5 = (1, 1, 1);

  if(!isdefined(var_6))
    var_6 = 60;

  if(!isdefined(var_7))
    var_7 = 120;

  if(!isdefined(var_10))
    var_10 = 50;

  var_11 = spawnstruct();
  var_11.light_number = var_1;
  var_11.time[0] = 0;
  var_11.dir[0] = var_3;
  var_11.pos[0] = var_2;
  var_11.active = 1;
  var_11.color[0] = var_5;
  var_11.innercone[0] = var_6;
  var_11.outercone[0] = var_7;
  var_11.radius[0] = var_10;
  var_11.intensity[0] = var_4;
  var_11.trans_time[0] = 0;
  var_11.dir["curr"] = var_3;
  var_11.pos["curr"] = var_2;
  var_11.color["curr"] = var_5;
  var_11.innercone["curr"] = var_6;
  var_11.outercone["curr"] = var_7;
  var_11.radius["curr"] = var_10;
  var_11.intensity["curr"] = 0.1;
  var_11.state = -1;
  var_11.primary_light = getent(var_0, "targetname");
  var_11.attach_ent = undefined;
  var_11.attach_bone = undefined;
  var_12 = undefined;

  if(isstring(var_8)) {
    if(isstring(var_8)) {
      var_12 = getent(var_8, "targetname");
      var_11.attach_ent = var_12;
    }
  } else
    var_12 = var_8;

  if(isdefined(var_12)) {
    var_11.attach_ent = var_12;

    if(!isdefined(var_11.attach_ent))
      var_11.attach_ent = undefined;

    if(isdefined(var_9) && isdefined(var_11.attach_ent))
      var_11.attach_bone = var_9;
    else
      var_11.attach_bone = undefined;

    var_11.attach_tag = common_scripts\utility::spawn_tag_origin();

    if(isdefined(var_9)) {
      var_11.attach_tag.origin = var_12 gettagorigin(var_9);
      var_11.attach_tag linkto(var_12, var_9, (0, 0, 0), (0, 0, 0));
    } else {
      var_11.attach_tag.origin = var_12.origin;
      var_11.attach_tag linkto(var_12);
    }

    var_13 = var_11.attach_tag.origin;
    var_14 = vectornormalize(anglestoforward(var_11.attach_tag.angles));
    var_15 = vectornormalize(anglestoup(var_11.attach_tag.angles));
    var_16 = vectornormalize(anglestoright(var_11.attach_tag.angles));
    var_17 = vectornormalize(var_14 * var_3[0] + var_15 * var_3[2] - var_16 * var_3[1]);
    var_18 = var_14 * var_2[0] + var_15 * var_2[2] - var_16 * var_2[1];
    var_11.primary_light.angles = vectortoangles(var_17);
    var_11.primary_light.origin = var_13 + var_18;

    if(!isdefined(var_11.primary_light.linkedtotag)) {
      var_11.primary_light.linkedtotag = 1;
      var_11.primary_light enablelinkto();
    }

    var_11.primary_light linkto(var_11.attach_tag);
  } else {
    var_11.attach_ent = undefined;
    var_11.attach_bone = undefined;
  }

  var_19 = 0;

  if(isdefined(level.scr_prim_lght))
    var_19 = level.scr_prim_lght.size;

  var_11.id = var_19;
  level.scr_prim_lght[var_19] = var_11;
  thread scriptable_primary_light_think(var_11, var_11.id);
  return var_11.id;
}

scriptable_primary_light_centerofinterest(var_0, var_1, var_2, var_3) {
  var_4 = level.scr_prim_lght[var_0];

  if(isdefined(var_2)) {
    var_1 = undefined;

    if(!isdefined(var_3))
      var_3 = "tag_origin";
  } else if(!isdefined(var_1))
    var_1 = (0, 0, 0);

  level.scr_prim_lght[var_0].coi_bone = var_3;
  level.scr_prim_lght[var_0].coi_pos = var_1;
  level.scr_prim_lght[var_0].coi_ent = var_2;
}

scriptable_primary_light_setstate_color(var_0, var_1, var_2, var_3) {
  scriptable_primary_light_setstate(var_0, var_1, undefined, undefined, undefined, var_2, undefined, undefined, undefined, var_3);
}

scriptable_primary_light_setstate_pos(var_0, var_1, var_2, var_3) {
  scriptable_primary_light_setstate(var_0, var_1, var_2, undefined, undefined, undefined, undefined, undefined, undefined, var_3);
}

scriptable_primary_light_setstate_dir(var_0, var_1, var_2, var_3) {
  scriptable_primary_light_setstate(var_0, var_1, undefined, var_2, undefined, undefined, undefined, undefined, undefined, var_3);
}

scriptable_primary_light_setstate_intensity(var_0, var_1, var_2, var_3) {
  scriptable_primary_light_setstate(var_0, var_1, undefined, var_2, undefined, undefined, undefined, undefined, undefined, var_3);
}

scriptable_primary_light_setstate_cone(var_0, var_1, var_2, var_3, var_4) {
  scriptable_primary_light_setstate(var_0, var_1, undefined, undefined, undefined, var_2, var_3, undefined, undefined, var_4);
}

scriptable_primary_light_setstate_radius(var_0, var_1, var_2, var_3) {
  scriptable_primary_light_setstate(var_0, var_1, undefined, undefined, undefined, undefined, undefined, undefined, var_2, var_3);
}

scriptable_primary_light_setstate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = level.scr_prim_lght[var_0];
  var_11 = var_10.time.size;

  if(!isdefined(var_3))
    var_3 = var_10.dir[var_11 - 1];

  if(!isdefined(var_2))
    var_2 = var_10.pos[var_11 - 1];

  if(!isdefined(var_4))
    var_4 = var_10.intensity[var_11 - 1];

  if(!isdefined(var_5))
    var_5 = var_10.color[var_11 - 1];

  if(!isdefined(var_6))
    var_6 = var_10.innercone[var_11 - 1];

  if(!isdefined(var_7))
    var_7 = var_10.outercone[var_11 - 1];

  if(!isdefined(var_8))
    var_8 = var_10.radius[var_11 - 1];

  var_10.time[var_11] = var_1;
  var_10.pos[var_11] = var_2;
  var_10.dir[var_11] = var_3;
  var_10.intensity[var_11] = var_4;
  var_10.color[var_11] = var_5;
  var_10.innercone[var_11] = var_6;
  var_10.outercone[var_11] = var_7;
  var_10.radius[var_11] = var_8;
  var_10.trans_time[var_11] = var_9;
}

model_animation_light(var_0) {
  var_1 = var_0["targetname"];
  var_2 = var_0["anim_tree_name"];
  var_3 = var_0["anim_name"];
  var_4 = var_0["anim_tag"];
  var_5 = var_0["link_tag"];
  var_6 = var_0["link_origin_offset"];
  var_7 = var_0["link_angles_offset"];
  var_8 = var_0["fxids"];
  var_9 = var_0["min_delay"];
  var_10 = var_0["max_delay"];
  var_11 = var_0["ender"];

  if(!isdefined(var_9))
    var_9 = 0.1;

  if(!isdefined(var_10))
    var_10 = 1.0;

  if(!isdefined(var_6))
    var_6 = (0, 0, 0);

  if(!isdefined(var_7))
    var_7 = (0, 0, 0);

  self endon("death");

  if(isdefined(var_11))
    level endon(var_11);

  var_12 = getentarray(var_1, "targetname");

  foreach(var_14 in var_12) {
    if(!isdefined(var_14.target)) {
      continue;
    }
    var_14.animname = var_2;
    var_14 maps\_anim::setanimtree();
    var_14 thread maps\_anim::anim_loop_solo(var_14, var_3, var_4);
    var_15 = getent(var_14.target, "targetname");
    var_16 = common_scripts\utility::spawn_tag_origin();
    var_16 linkto(var_14, var_5, var_6, var_7);
    var_15 thread maps\_utility::manual_linkto(var_16);

    if(isdefined(var_8)) {
      foreach(var_18 in var_8)
      playfxontag(level._effect[var_18], var_14, var_5);
    }

    wait(randomfloatrange(var_9, var_10));
  }
}

light_setup_global_dvars() {
  if(isusinghdr()) {
    setsaveddvar("r_veil", 1);
    setsaveddvar("r_veilStrength", 0.087);
    setsaveddvar("r_tonemap", 2);
    setsaveddvar("r_tonemapBlack", 0.0);
    setsaveddvar("r_tonemapCrossover", 1.0);
    setsaveddvar("r_tonemapHighlightRange", 16.0);
    setsaveddvar("r_tonemapDarkEv", 2.84);
    setsaveddvar("r_tonemapMidEv", 7.823);
    setsaveddvar("r_tonemapLightEv", 12.81);
    setsaveddvar("r_tonemapDarkExposureAdjust", -3.17);
    setsaveddvar("r_tonemapMidExposureAdjust", -0.0651);
    setsaveddvar("r_tonemapLightExposureAdjust", 1.47);
    setsaveddvar("r_tonemapMinExposureAdjust", -3.17);
    setsaveddvar("r_tonemapMaxExposureAdjust", 2.3);

    if(level.ps4)
      setsaveddvar("r_tonemapShoulder", 0.4);
    else
      setsaveddvar("r_tonemapShoulder", 0.94);

    setsaveddvar("r_tonemapToe", 0.0);
    setsaveddvar("r_tonemapWhite", 512);
    setsaveddvar("r_tonemapAdaptSpeed", 0.02);
    setsaveddvar("r_tonemapLockAutoExposureAdjust", 0);
    setsaveddvar("r_tonemapAutoExposureAdjust", 0.0);
    setsaveddvar("r_tonemapExposure", -10.0);
    setsaveddvar("r_tonemapMaxExposure", -10.0);
  }

  if(isusingssao()) {
    setsaveddvar("r_ssaoPower", 12.0);
    setsaveddvar("r_ssaoStrength", 0.45);
    setsaveddvar("r_ssaominstrengthdepth", 25.0);
    setsaveddvar("r_ssaomaxstrengthdepth", 40.0);
  }

  set_r_hbaodvars();
}

screen_effect_base(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = newclienthudelem(level.player);
  var_8.x = 0;
  var_8.y = 0;
  var_8.splatter = 1;
  var_8.alignx = "left";
  var_8.aligny = "top";
  var_8.sort = 1;
  var_8.foreground = 0;
  var_8.horzalign = "fullscreen";
  var_8.vertalign = "fullscreen";
  var_8.alpha = var_4;
  var_8 thread cleanup_overlay();

  if(isdefined(var_5))
    var_8.x = var_5;

  if(isdefined(var_6))
    var_8.y = var_6;

  if(isdefined(var_7))
    var_8.sort = var_7;

  if(isarray(var_1)) {
    foreach(var_10 in var_1)
    var_8 setshader(var_10, 640, 480);
  } else
    var_8 setshader(var_1, 640, 480);

  if(var_0 > 0) {
    var_8.alpha = 0;
    var_12 = 1;

    if(isdefined(var_2))
      var_12 = var_2;

    var_13 = 1;

    if(isdefined(var_3))
      var_13 = var_3;

    var_14 = 1;

    if(isdefined(var_4))
      var_14 = clamp(var_4, 0.0, 1.0);

    var_15 = 0.05;

    if(var_12 > 0) {
      var_16 = 0;
      var_17 = var_14 / (var_12 / var_15);

      while (var_16 < var_14) {
        var_8.alpha = var_16;
        var_16 = var_16 + var_17;
        wait(var_15);
      }
    }

    var_8.alpha = var_14;
    wait(var_0 - (var_12 + var_13));

    if(var_13 > 0) {
      var_16 = var_14;
      var_18 = var_14 / (var_13 / var_15);

      while (var_16 > 0) {
        var_8.alpha = var_16;
        var_16 = var_16 - var_18;
        wait(var_15);
      }
    }

    var_8.alpha = 0;
    var_8 destroy();
  }

  level.overlay = var_8;
  return level.overlay;
}

cleanup_overlay() {
  level waittill("end_screen_effect");
  self destroy();
}

blood_splatter_simple() {}

dirt_splatter_simple() {
  var_0 = newclienthudelem(level.player);
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("fullscreen_dirt_bottom", 640, 480);
  var_0 setshader("fullscreen_dirt_bottom_b", 640, 480);
  var_0 setshader("fullscreen_dirt_left", 640, 480);
  var_0 setshader("fullscreen_dirt_right", 640, 480);
  var_0.splatter = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0 fadeovertime(3);
  var_0.alpha = 0;
}

bob_mask(var_0) {
  self endon("stop_mask_bob");
  var_1 = 0;
  var_2 = level.player getplayerangles();
  var_3 = 0;
  var_4 = 0;
  var_5 = var_0.y;
  var_6 = var_0.x;
  var_7 = 0.05;

  for (;;) {
    if(isdefined(var_0)) {
      var_8 = level.player getplayerangles();
      var_9 = level.player getvelocity();
      var_10 = var_9[2];
      var_9 = var_9 - var_9 * (0, 0, 1);
      var_11 = length(var_9);
      var_12 = level.player getstance();
      var_13 = clamp(var_11, 0, 280) / 280;
      var_14 = 0.1 + var_13 * 0.25;
      var_15 = 0.1 + var_13 * 0.25;
      var_16 = 1.0;

      if(var_12 == "crouch")
        var_16 = 0.75;

      if(var_12 == "prone")
        var_16 = 0.4;

      if(var_12 == "stand")
        var_16 = 1.0;

      var_17 = 5.0;
      var_18 = 0.9;
      var_19 = level.player playerads();
      var_20 = var_17 * (1.0 - var_19) + var_18 * var_19;
      var_20 = var_20 * (1 + var_13 * 2);
      var_21 = 5;
      var_22 = var_21 * var_14 * var_16;
      var_23 = var_21 * var_15 * var_16;
      var_1 = var_1 + var_7 * 1000.0 * var_20;
      var_24 = 57.2958;
      var_25 = sin(var_1 * 0.001 * var_24);
      var_26 = sin(var_1 * 0.0007 * var_24);
      var_27 = angleclamp180(var_8[1] - var_2[1]);
      var_27 = clamp(var_27, -10, 10);
      var_28 = var_27 / 10 * var_21 * (1 - var_14);
      var_29 = var_28 - var_4;
      var_4 = var_4 + clamp(var_29, -1.0, 1.0);
      var_30 = clamp(var_10, -200, 200) / 200 * var_21 * (1 - var_15);
      var_31 = var_30 - var_3;
      var_3 = var_3 + clamp(var_31, -0.6, 0.6);
      var_0 moveovertime(0.05);
      var_0.x = var_6 + clamp(var_25 * var_22 + var_4 - var_21, 0 - 2 * var_21, 0);
      var_0.y = var_5 + clamp(var_26 * var_23 + var_3 - var_21, 0 - 2 * var_21, 0);
      var_2 = var_8;
    }

    wait(var_7);
  }
}

gasmask_on_player(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_0))
    var_0 = 1;

  if(!isdefined(var_1))
    var_1 = 0;

  if(!isdefined(var_2))
    var_2 = 1;

  if(!isdefined(var_3))
    var_3 = 0.25;

  if(var_0)
    maps\_hud_util::fade_out(var_1);

  self.gasmask_hud_elem = newclienthudelem(self);
  self.gasmask_hud_elem.x = 0;
  self.gasmask_hud_elem.y = 0;
  self.gasmask_hud_elem.horzalign = "fullscreen";
  self.gasmask_hud_elem.vertalign = "fullscreen";
  self.gasmask_hud_elem.foreground = 0;
  self.gasmask_hud_elem.sort = -1;
  self.gasmask_hud_elem setshader("gasmask_overlay_delta2_top", 650, 138);
  self.gasmask_hud_elem.alpha = 1.0;
  self.gasmask_hud_elem1 = newclienthudelem(self);
  self.gasmask_hud_elem1.x = 0;
  self.gasmask_hud_elem1.y = 352;
  self.gasmask_hud_elem1.horzalign = "fullscreen";
  self.gasmask_hud_elem1.vertalign = "fullscreen";
  self.gasmask_hud_elem1.foreground = 0;
  self.gasmask_hud_elem1.sort = -1;
  self.gasmask_hud_elem1 setshader("gasmask_overlay_delta2_bottom", 650, 138);
  self.gasmask_hud_elem1.alpha = 1.0;
  level.player maps\_utility::delaythread(1.0, ::gasmask_breathing);
  thread bob_mask(self.gasmask_hud_elem);
  thread bob_mask(self.gasmask_hud_elem1);

  if(var_0) {
    wait(var_3);
    maps\_hud_util::fade_in(var_2);
  }
}

gasmask_off_player() {
  maps\_hud_util::fade_out(0.25);
  self notify("stop_mask_bob");

  if(isdefined(self.gasmask_hud_elem)) {
    self.gasmask_hud_elem destroy();
    self.gasmask_hud_elem = undefined;
  }

  if(isdefined(self.gasmask_hud_elem1)) {
    self.gasmask_hud_elem1 destroy();
    self.gasmask_hud_elem1 = undefined;
  }

  level.player notify("stop_breathing");
  wait 0.25;
  maps\_hud_util::fade_in(1.5);
}

gasmask_breathing() {
  var_0 = 1.0;
  self endon("stop_breathing");

  for (;;) {
    maps\_utility::play_sound_on_entity("breathing_gasmask");
    wait(var_0);
  }
}

gasmask_on_npc() {
  self.gasmask = spawn("script_model", (0, 0, 0));
  self.gasmask setmodel("prop_sas_gasmask");
  self.gasmask linkto(self, "tag_eye", (-4, 0, 2), (120, 0, 0));
}

gasmask_off_npc() {
  if(isdefined(self.gasmask))
    self.gasmask delete();
}

light_setup_common_flickerlight_presets() {
  create_flickerlight_preset("fire", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 8);
  create_flickerlight_preset("blue_fire", (0.445098, 0.62451, 0.972549), (0.05, 0.150451, 0.307843), 0.005, 0.2, 8);
  create_flickerlight_preset("white_fire", (0.972549, 0.972549, 0.972549), (0.2, 0.2, 0.2), 0.005, 0.2, 8);
  create_flickerlight_preset("white_fire_dim", (0.972549, 0.972549, 0.972549), (0.2, 0.2, 0.2), 0.005, 0.2, 0.5);
  create_flickerlight_preset("street_light", (0.972549, 0.972549, 0.972549), (0.572549, 0.572549, 0.572549), 0.005, 0.2, 8);
  create_flickerlight_preset("pulse", (0, 0, 0), (255, 107, 107), 0.2, 1, 8);
  create_flickerlight_preset("lightbulb", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 6);
  create_flickerlight_preset("fluorescent", (0.972549, 0.62451, 0.345098), (0.2, 0.146275, 0.0878432), 0.005, 0.2, 7);
  create_flickerlight_preset("static_screen", (0.63, 0.72, 0.92), (0.4, 0.43, 0.48), 0.005, 0.2, 7);
  create_flickerlight_preset("sfb_fire", (1, 0.65, 0.8), (0.4, 0.24, 0.3), 0.005, 0.2, 8);
}

create_flickerlight_motion_preset(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(level._light.flicker_motion_presets))
    level._light.flicker_motion_presets = [];

  var_6 = spawnstruct();
  var_6.color = var_1;
  var_6.intensity = var_2;
  var_6.maxmove = var_3;
  var_6.mindelay = var_4;
  var_6.maxdelay = var_5;
  level._light.flicker_motion_presets[var_0] = var_6;
}

get_flickerlight_motion_preset(var_0) {
  if(isdefined(level._light.flicker_motion_presets) && isdefined(level._light.flicker_motion_presets[var_0]))
    return level._light.flicker_motion_presets[var_0];

  return undefined;
}

play_flickerlight_motion_preset(var_0, var_1) {
  var_2 = getentarray(var_1, "targetname");

  if(!isdefined(var_2) || var_2.size <= 0) {
    return;
  }
  var_3 = get_flickerlight_motion_preset(var_0);

  if(!isdefined(var_3)) {
    return;
  }
  foreach(var_5 in var_2) {
    var_5 setlightintensity(var_3.intensity);
    var_5.islightflickering = 1;
    var_5.islightflickerpaused = 0;
    var_5 thread dyn_motion_flickerlight(var_3.color, var_3.intensity, var_3.maxmove, var_3.mindelay, var_3.maxdelay);
  }

  return var_2;
}

create_flickerlight_preset(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(level._light.flicker_presets))
    level._light.flicker_presets = [];

  var_6 = spawnstruct();
  var_6.color0 = var_1;
  var_6.color1 = var_2;
  var_6.mindelay = var_3;
  var_6.maxdelay = var_4;
  var_6.intensity = var_5;
  level._light.flicker_presets[var_0] = var_6;
}

get_flickerlight_preset(var_0) {
  if(isdefined(level._light.flicker_presets) && isdefined(level._light.flicker_presets[var_0]))
    return level._light.flicker_presets[var_0];

  return undefined;
}

play_flickerlight_preset(var_0, var_1, var_2) {
  var_3 = getent(var_1, "targetname");

  if(!isdefined(var_3)) {
    return;
  }
  var_4 = get_flickerlight_preset(var_0);

  if(!isdefined(var_4)) {
    return;
  }
  if(isdefined(var_2)) {
    if(var_2 < 0)
      var_2 = 0;

    var_4.intensity = var_2;
  }

  var_3 setlightintensity(var_4.intensity);
  var_3.islightflickering = 1;
  var_3.islightflickerpaused = 0;
  var_3 thread dyn_flickerlight(var_4.color0, var_4.color1, var_4.mindelay, var_4.maxdelay);
  return var_3;
}

stop_flickerlight(var_0, var_1, var_2) {
  var_3 = getent(var_1, "targetname");

  if(!isdefined(var_3)) {
    return;
  }
  if(!isdefined(var_3.islightflickering)) {
    return;
  }
  if(isdefined(var_2)) {
    if(var_2 < 0)
      var_2 = 0;
  }

  var_3 setlightintensity(var_2);
  var_3 notify("kill_flicker");
  var_3.islightflickering = undefined;
}

pause_flickerlight(var_0, var_1) {
  var_2 = getent(var_1, "targetname");

  if(!isdefined(var_2)) {
    return;
  }
  if(!isdefined(var_2.islightflickering)) {
    return;
  }
  var_2.islightflickerpaused = 1;
}

unpause_flickerlight(var_0, var_1) {
  var_2 = getent(var_1, "targetname");

  if(!isdefined(var_2)) {
    return;
  }
  if(!isdefined(var_2.islightflickering)) {
    return;
  }
  var_2.islightflickerpaused = 0;
}

dyn_flickerlight(var_0, var_1, var_2, var_3) {
  self endon("kill_flicker");
  var_4 = var_0;
  var_5 = 0.0;

  for (;;) {
    if(self.islightflickerpaused) {
      wait 0.05;
      continue;
    }

    var_6 = var_4;
    var_4 = var_0 + (var_1 - var_0) * randomfloat(1.0);

    if(var_2 != var_3)
      var_5 = var_5 + randomfloatrange(var_2, var_3);
    else
      var_5 = var_5 + var_2;

    if(var_5 == 0)
      var_5 = var_5 + 0.0000001;

    for (var_7 = (var_6 - var_4) * (1 / var_5); var_5 > 0 && !self.islightflickerpaused; var_5 = var_5 - 0.05) {
      self setlightcolor(var_4 + var_7 * var_5);
      wait 0.05;
    }
  }
}

dyn_motion_flickerlight(var_0, var_1, var_2, var_3, var_4) {
  self endon("kill_flicker");
  self setlightcolor(var_0);
  self setlightintensity(var_1);
  thread fire_flicker();
  var_5 = self.origin;
  var_6 = var_2;
  var_7 = var_2;
  var_8 = var_2;
  var_9 = var_3;
  var_10 = var_4;

  for (;;) {
    var_11 = randomfloatrange(var_9, var_10);
    var_12 = var_6 * randomfloatrange(0.1, 1);
    var_13 = var_7 * randomfloatrange(0.1, 1);
    var_14 = var_8 * randomfloatrange(0.1, 1);
    var_15 = var_5 + (var_12, var_13, var_14);
    self moveto(var_15, var_11);
    wait(var_11);

    while (self.islightflickerpaused)
      wait 0.05;
  }
}

fire_flicker() {
  var_0 = self getlightintensity();
  self endon("kill_flicker");
  var_1 = var_0;

  for (;;) {
    var_2 = randomfloatrange(var_0 * 0.5, var_0 * 1.2);
    var_3 = randomfloatrange(0.2, 1.0);
    var_3 = var_3 * 0.75;

    while (self.islightflickerpaused)
      wait 0.05;

    for (var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2 * (var_4 / var_3) + var_1 * ((var_3 - var_4) / var_3);
      self setlightintensity(var_5);
      wait 0.05;
    }

    var_1 = var_2;
  }
}

create_light_object(var_0, var_1) {
  var_2 = spawnstruct();
  var_3 = getentarray(var_0, "script_noteworthy");
  var_2.lightents = [];
  var_2.modelents = [];

  foreach(var_5 in var_3) {
    if(var_5.classname == "script_model")
      var_2.modelents[var_2.modelents.size] = var_5;

    if(var_5.classname == "light_spot")
      var_2.lightents[var_2.lightents.size] = var_5;
  }

  var_2.fxid = var_1;
  return var_2;
}

light_object_set_intensity(var_0, var_1, var_2) {
  foreach(var_4 in self.lightents) {
    var_4 setlightintensity(var_0);
    var_4 setlightcolor(var_1);
  }

  if(var_2 && !isdefined(self.was_on)) {
    common_scripts\_exploder::exploder(self.fxid);

    foreach(var_7 in self.modelents)
    var_7 show();

    self.was_on = 1;
  } else if(isdefined(self.was_on) && !var_2) {
    maps\_utility::stop_exploder(self.fxid);

    foreach(var_7 in self.modelents)
    var_7 hide();

    self.was_on = undefined;
  }
}

flickering_light(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("kill_flicker");
  var_7 = 0;
  var_8 = 0.0;

  for (;;) {
    var_9 = var_7;
    var_7 = randomfloat(1.0);

    if(var_5 != var_6)
      var_8 = var_8 + randomfloatrange(var_5, var_6);
    else
      var_8 = var_8 + var_6;

    if(var_8 == 0)
      var_8 = var_8 + 0.0000001;

    for (var_10 = (var_7 - var_9) / var_8; var_8 > 0; var_8 = var_8 - 0.05) {
      var_11 = var_7 - var_8 * var_10;
      var_12 = vectorlerp(var_1, var_3, var_11);
      var_13 = maps\_utility::linear_interpolate(var_11, var_2, var_4);
      var_14 = var_11 > 0.5;
      var_0 light_object_set_intensity(var_13, var_12, var_14);
      wait 0.05;
    }
  }
}

perlin_flickering_light(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 2;
  var_6 = 3;
  var_7 = 5;

  for (;;) {
    var_8 = clamp(perlinnoise2d(gettime() * 0.001 * var_5, 0, var_6, 2, var_7), 0, 1);
    var_9 = vectorlerp(var_1, var_3, var_8);
    var_10 = maps\_utility::linear_interpolate(var_8, var_2, var_4);
    var_11 = var_8 > 0.5;
    var_0 light_object_set_intensity(var_10, var_9, var_11);
    wait 0.05;
  }
}

lerp_spot_intensity(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");

  if(level.currentgen && isdefined(var_3) == 0) {
    return;
  }
  var_4 = var_3 getlightintensity();
  var_3.endintensity = var_2;
  var_5 = 0;

  while (var_5 < var_1) {
    var_6 = var_4 + (var_2 - var_4) * (var_5 / var_1);
    var_5 = var_5 + 0.05;
    var_3 setlightintensity(var_6);
    wait 0.05;
  }

  var_3 setlightintensity(var_2);
}

lerp_spot_intensity_array(var_0, var_1, var_2) {
  var_3 = getentarray(var_0, "targetname");

  foreach(var_5 in var_3) {
    var_6 = var_5 getlightintensity();
    var_5.endintensity = var_2;
    var_7 = 0;

    while (var_7 < var_1) {
      var_8 = var_6 + (var_2 - var_6) * (var_7 / var_1);
      var_7 = var_7 + 0.05;
      var_5 setlightintensity(var_8);
      wait 0.05;
    }

    var_5 setlightintensity(var_2);
  }
}

lerp_spot_radius(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");

  if(level.currentgen && isdefined(var_3) == 0) {
    return;
  }
  var_4 = var_3 getlightradius();
  var_3.endradius = var_2;
  var_5 = 0;

  while (var_5 < var_1) {
    var_6 = var_4 + (var_2 - var_4) * (var_5 / var_1);
    var_5 = var_5 + 0.05;
    var_3 setlightradius(var_6);
    wait 0.05;
  }

  var_3 setlightradius(var_2);
}

set_spot_intensity(var_0, var_1) {
  var_2 = getent(var_0, "targetname");

  if(level.currentgen && isdefined(var_2) == 0) {
    return;
  }
  var_2 setlightintensity(var_1);
}

lerp_spot_color(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");

  if(level.currentgen && isdefined(var_3) == 0) {
    return;
  }
  var_4 = var_3 getlightcolor();
  var_3.endcolor = var_2;
  var_5 = 0;

  while (var_5 < var_1) {
    var_6 = var_4 + (var_2 - var_4) * (var_5 / var_1);
    var_5 = var_5 + 0.05;
    var_3 setlightcolor(var_6);
    wait 0.05;
  }

  var_3 setlightcolor(var_2);
}

set_spot_color(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2 setlightcolor(var_1);
}

light_setup_pulse_presets() {
  create_pulselight_preset("red", 0.1, 0.1, 10000, (1, 0.2, 0.2), 2);
  create_pulselight_preset("red2", 0.1, 0.1, 68200000, (1, 0.2, 0.2), 2);
  create_pulselight_preset("yellow", 0.1, 0.1, 68200000, (1, 0.7, 0.2), 2);
  create_pulselight_preset("white", 0.1, 0.1, 68200000, (1, 1, 1), 2);
  create_pulselight_preset("turbine_pulse", 0.1, 0.1, 10000, (0.9, 0.9, 1), 2);
}

create_pulselight_preset(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(level._light.pulse_presets))
    level._light.pulse_presets = [];

  var_6 = spawnstruct();
  var_6.transition_on = var_1;
  var_6.transition_off = var_2;
  var_6.intensity = var_3;
  var_6.color01 = var_4;
  var_6.num = var_5;
  level._light.pulse_presets[var_0] = var_6;
}

get_pulselight_preset(var_0) {
  if(isdefined(level._light.pulse_presets) && isdefined(level._light.pulse_presets[var_0]))
    return level._light.pulse_presets[var_0];

  return undefined;
}

play_pulse_preset(var_0, var_1, var_2, var_3) {
  var_4 = var_0 + var_1 + "_pulse";
  level notify(var_4);
  level endon(var_4);
  var_5 = getent(var_1, "targetname");

  if(!isdefined(var_5)) {
    return;
  }
  var_6 = get_pulselight_preset(var_0);

  if(!isdefined(var_6)) {
    return;
  }
  if(isdefined(var_2)) {
    if(var_2 < 0)
      var_2 = 0;

    var_6.intensity = var_2;
  }

  var_5 setlightintensity(var_6.intensity);
  var_5 setlightcolor(var_6.color01);
  var_7 = var_6.num;
  var_8 = var_5 getlightintensity();
  var_9 = 0.05;
  var_10 = var_8;
  var_11 = var_6.transition_on;
  var_12 = var_6.transition_off;
  var_13 = (var_8 - var_9) / (var_11 / 0.05);
  var_14 = (var_8 - var_9) / (var_12 / 0.05);
  var_15 = var_6.num;

  for (;;) {
    var_16 = 1;
    var_17 = 0;

    while (var_17 < var_12) {
      var_10 = var_10 - var_14;
      var_10 = clamp(var_10, 0, 1000000000);
      var_5 setlightintensity(var_10);
      var_17 = var_17 + 0.05;
      wait 0.05;
    }

    if(isdefined(var_3))
      maps\_utility::stop_exploder(var_3);

    wait 0.8;
    var_17 = 0;

    while (var_17 < var_11) {
      var_10 = var_10 + var_13;
      var_10 = clamp(var_10, 0, 1000000000);
      var_5 setlightintensity(var_10);
      var_17 = var_17 + 0.05;
      wait 0.05;
    }

    if(isdefined(var_3))
      common_scripts\_exploder::exploder(var_3);

    wait 0.1;

    while (var_16 < var_15) {
      var_17 = 0;

      while (var_17 < var_12) {
        var_10 = var_10 - var_14;
        var_10 = clamp(var_10, 0, 300000);
        var_5 setlightintensity(var_10);
        var_17 = var_17 + 0.05;
        wait 0.05;
      }

      wait 0.1;
      var_17 = 0;

      while (var_17 < var_11) {
        var_10 = var_10 + var_13;
        var_10 = clamp(var_10, 0, 300000);
        var_5 setlightintensity(var_10);
        var_17 = var_17 + 0.05;
        wait 0.05;
      }

      wait 0.1;
      var_16 = var_16 + 1;
    }
  }

  return var_5;
}

model_flicker_preset(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  self endon("death");

  if(isdefined(var_10))
    level endon(var_10);

  var_13 = getentarray(var_0, "script_noteworthy");

  if(!isdefined(var_13)) {
    return;
  }
  var_14 = [];
  var_15 = [];

  foreach(var_17 in var_13) {
    if(var_17.classname == "script_model")
      var_15[var_15.size] = var_17;

    if(var_17.classname == "light_spot" || var_17.classname == "light_omni") {
      var_14[var_14.size] = var_17;
      var_18 = var_2;

      if(var_3 > var_2)
        var_18 = randomfloatrange(var_2, var_3);

      var_17 setlightintensity(var_18);
    }
  }

  var_20 = 0;
  var_21 = undefined;
  var_22 = undefined;
  var_23 = undefined;
  var_24 = undefined;
  var_25 = undefined;
  var_26 = 1;

  if(isarray(var_11)) {
    var_21 = var_11["on"];
    var_22 = var_11["off"];
    var_23 = var_11["loop"];
    var_25 = var_11["vol_env"];

    if(isstring(var_23))
      var_24 = "model_flicker_preset_" + soundscripts\_snd::snd_new_guid();
  }

  var_27 = 0;

  if(isdefined(var_4))
    common_scripts\_exploder::exploder(var_4);

  while (var_27 < var_1 || var_1 == 0) {
    var_28 = undefined;

    if(isdefined(var_12))
      var_29 = var_12;
    else
      var_29 = 0.05;

    var_30 = 0.0;

    if(isdefined(var_6) && isdefined(var_7))
      var_31 = randomfloatrange(var_6, var_7);
    else
      var_31 = randomfloatrange(0.1, 0.8);

    if(isdefined(var_8) && isdefined(var_9))
      var_32 = randomfloatrange(var_8, var_9);
    else
      var_32 = randomfloatrange(0.1, 0.8);

    foreach(var_34 in var_14) {
      if(var_20) {
        if(isstring(var_24))
          level notify(var_24);

        if(isdefined(var_22))
          var_34 soundscripts\_snd_playsound::snd_play_linked(var_22, undefined, undefined, undefined, var_26);

        var_20 = 0;
      }
    }

    if(isdefined(var_5))
      maps\_utility::stop_exploder(var_5);

    foreach(var_37 in var_15)
    var_37 hide();

    foreach(var_40 in var_14) {
      var_28 = var_40 getlightintensity();
      var_40 setlightintensity(var_29);
    }

    wait(var_32);

    foreach(var_34 in var_14) {
      var_18 = var_2;

      if(var_3 > var_2)
        var_18 = randomfloatrange(var_2, var_3);

      var_34 setlightintensity(var_18);

      if(isdefined(var_21) && !var_20) {
        if(isarray(var_25))
          var_26 = soundscripts\_snd::snd_map(var_18, var_25);

        if(isdefined(var_21))
          var_34 soundscripts\_snd_playsound::snd_play_linked(var_21, undefined, undefined, undefined, var_26);

        if(isdefined(var_23))
          var_34 soundscripts\_snd_playsound::snd_play_loop_linked(var_23, var_24, 0.0, 0.1, var_26);

        var_20 = 1;
      }
    }

    if(isdefined(var_5))
      common_scripts\_exploder::exploder(var_5);

    foreach(var_37 in var_15)
    var_37 show();

    foreach(var_40 in var_14)
    var_40 setlightintensity(var_28);

    wait(var_31);

    if(var_1 != 0)
      var_27++;
  }
}

light_setup_common_dof_presets() {
  create_dof_preset("default", 1, 1, 4.5, 500, 500, 0.05, 0.5);
  create_dof_preset("viewmodel_blur", 1, 1, 4.5, 500, 500, 0.05, 0.5);
  create_dof_preset("close_none_viewmodel_blur", 1, 50, 4, 1000, 7000, 0.05, 0.5);
  create_dof_preset("river", 1, 104, 4.5, 500, 500, 1.8, 0.5);
  create_dof_preset("medium_none_viewmodel_blur", 1, 500, 10, 1000, 7000, 0.05, 0.5);
}

create_dof_preset(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isdefined(level._light.dof_presets))
    level._light.dof_presets = [];

  var_8 = [];
  var_8["nearStart"] = var_1;
  var_8["nearEnd"] = var_2;
  var_8["nearBlur"] = var_3;
  var_8["farStart"] = var_4;
  var_8["farEnd"] = var_5;
  var_8["farBlur"] = var_6;
  var_8["bias"] = var_7;
  level._light.dof_presets[var_0] = var_8;
}

light_get_dof_preset(var_0) {
  if(isdefined(level._light.dof_presets) && isdefined(level._light.dof_presets[var_0]))
    return level._light.dof_presets[var_0];
}

blend_dof_presets(var_0, var_1, var_2) {
  if(isdefined(level._light.dof_presets)) {
    var_3 = light_get_dof_preset(var_0);
    var_4 = light_get_dof_preset(var_1);

    if(isdefined(var_3) && isdefined(var_4))
      maps\_art::dof_enable_script(var_4["nearStart"], var_4["nearEnd"], var_4["nearBlur"], var_4["farStart"], var_4["farEnd"], var_4["farBlur"], var_2, var_4["bias"]);
    else {

    }
  }
}

light_setup_common_dof_viewmodel_presets() {
  create_dof_viewmodel_preset("default", 2, 8);
  create_dof_viewmodel_preset("viewmodel_blur", 10, 90);
  create_dof_viewmodel_preset("max", 2, 128);
}

create_dof_viewmodel_preset(var_0, var_1, var_2) {
  if(!isdefined(level._light.dof_viewmodel_presets))
    level._light.dof_viewmodel_presets = [];

  var_3["start"] = var_1;
  var_3["end"] = var_2;
  level.player.viewmodel_dof_start = var_3["start"];
  level.player.viewmodel_dof_end = var_3["end"];
  level._light.dof_viewmodel_presets[var_0] = var_3;
}

light_get_dof_viewmodel_preset(var_0) {
  if(isdefined(level._light.dof_viewmodel_presets) && isdefined(level._light.dof_viewmodel_presets[var_0]))
    return level._light.dof_viewmodel_presets[var_0];
}

blend_dof_viewmodel_presets(var_0, var_1, var_2) {
  if(isdefined(level._light.dof_viewmodel_presets)) {
    var_3 = light_get_dof_viewmodel_preset(var_0);
    var_4 = light_get_dof_viewmodel_preset(var_1);

    if(isdefined(var_3) && isdefined(var_4))
      blend_viewmodel_dof(var_3, var_4, var_2);
    else {

    }
  }
}

blend_viewmodel_dof(var_0, var_1, var_2) {
  if(var_2 > 0) {
    var_3 = (var_1["start"] - var_0["start"]) * 0.05 / var_2;
    var_4 = (var_1["end"] - var_0["end"]) * 0.05 / var_2;
    thread lerp_viewmodel_dof(var_1, var_3, var_4);
  } else {
    level.player.viewmodel_dof_start = var_1["start"];
    level.player.viewmodel_dof_end = var_1["end"];
  }
}

lerp_viewmodel_dof(var_0, var_1, var_2) {
  level notify("lerp_viewmodel_dof");
  level endon("lerp_viewmodel_dof");
  var_3 = 0;
  var_4 = 0;

  while (!var_3 || !var_4) {
    if(!var_3) {
      level.player.viewmodel_dof_start = level.player.viewmodel_dof_start + var_1;

      if(var_1 > 0 && level.player.viewmodel_dof_start > var_0["start"] || var_1 < 0 && level.player.viewmodel_dof_start < var_0["start"]) {
        level.player.viewmodel_dof_start = var_0["start"];
        var_3 = 1;
      }
    }

    if(!var_4) {
      level.player.viewmodel_dof_end = level.player.viewmodel_dof_end + var_2;

      if(var_2 > 0 && level.player.viewmodel_dof_end > var_0["end"] || var_2 < 0 && level.player.viewmodel_dof_end < var_0["end"]) {
        level.player.viewmodel_dof_end = var_0["end"];
        var_4 = 1;
      }
    }

    level.player setviewmodeldepthoffield(level.player.viewmodel_dof_start, level.player.viewmodel_dof_end);
    wait 0.05;
  }
}

light_message_init() {
  level._light.messages = [];
}

light_debug_dvar_init() {}

light_register_message(var_0, var_1) {
  level._light.messages[var_0] = var_1;
}

light_message(var_0, var_1, var_2, var_3) {
  if(isdefined(level._light.messages[var_0])) {
    if(isdefined(var_3))
      thread[[level._light.messages[var_0]]](var_1, var_2, var_3);
    else if(isdefined(var_2))
      thread[[level._light.messages[var_0]]](var_1, var_2);
    else if(isdefined(var_1))
      thread[[level._light.messages[var_0]]](var_1);
    else
      thread[[level._light.messages[var_0]]]();
  }
}

lerp_light_fov_range(var_0, var_1, var_2, var_3, var_4) {
  for (var_5 = 0; var_5 <= var_4; var_5 = var_5 + 0.05) {
    var_6 = var_5 / var_4;
    self setlightfovrange(maps\_utility::linear_interpolate(var_6, var_0, var_2), maps\_utility::linear_interpolate(var_6, var_1, var_3));
    waitframe();
  }
}

setup_emissive_modifiers() {
  var_0 = getentarray("emissive_intensity_0", "targetname");

  foreach(var_2 in var_0)
  var_2 setmaterialscriptparam(0.0, 0.0);

  var_4 = getentarray("emissive_intensity_25", "targetname");

  foreach(var_2 in var_4)
  var_2 setmaterialscriptparam(0.25, 0.0);

  var_7 = getentarray("emissive_intensity_50", "targetname");

  foreach(var_2 in var_7)
  var_2 setmaterialscriptparam(0.5, 0.0);

  var_10 = getentarray("emissive_intensity_75", "targetname");

  foreach(var_2 in var_10)
  var_2 setmaterialscriptparam(0.75, 0.0);

  var_13 = getentarray("emissive_intensity_100", "targetname");

  foreach(var_2 in var_13)
  var_2 setmaterialscriptparam(1.0, 0.0);

  var_16 = getentarray("emissive_intensity", "targetname");

  foreach(var_2 in var_16) {
    var_18 = float(var_2.script_noteworthy) * 0.01;
    var_2 setmaterialscriptparam(var_18, 0.0);
  }
}

set_r_hbaodvars() {
  if(!level.pc) {
    return;
  }
  switch (level.script) {
    case "killhouse":
    case "jeepride":
    case "coup":
    case "cargoship":
    case "airlift":
    case "armada":
      setsaveddvar("r_hbaoStrengthScale", 0.2);
      break;
    case "village_defend":
    case "village_assault":
    case "sniperescape":
    case "scoutsniper":
    case "launchfacility_b":
    case "launchfacility_a":
    case "icbm":
    case "hunted":
    case "bog_b":
    case "bog_a":
    case "blackout":
    case "ambush":
    case "airplane":
    case "aftermath":
    case "ac130":
      setsaveddvar("r_hbaoStrengthScale", 0.2);
      break;
    default:
      break;
  }
}