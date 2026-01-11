/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2680.gsc
************************/

frontend_camera_setup(param_00, param_01) {
  level.camera_anchor = spawn("script_model", param_00);
  level.camera_anchor setModel("tag_origin");
  level.camera_anchor.angles = param_01;
}

camera_move_helper(param_00, param_01, param_02) {
  level.playerviewowner predictstreampos(param_00.origin);
  var_03 = distance(level.camera_anchor.origin, param_00.origin);
  var_04 = var_03 / param_01;
  if(var_04 < 0.05) {
    var_04 = 0.05;
  }

  var_05 = 0;
  if(param_02) {
    var_05 = var_04 * 0.1;
  }

  level.camera_anchor.move_target = param_00;
  level.camera_anchor moveto(param_00.origin, var_04, var_05, var_05);
  level.camera_anchor rotateto(param_00.angles, var_04, var_05, var_05);
  wait(var_04);
}

frontend_camera_move(param_00, param_01, param_02, param_03, param_04) {
  level endon("game_ended");
  self endon("disconnect");
  if(isDefined(level.camera_anchor.move_target)) {
    level.camera_anchor.origin = level.camera_anchor.move_target.origin;
    level.camera_anchor.angles = level.camera_anchor.move_target.angles;
  }

  level notify("camera_move");
  level endon("camera_move");
  if(!isDefined(param_01)) {
    param_01 = 900;
  }

  var_05 = param_00;
  if(param_02) {
    level.camera_anchor.origin = var_05.origin;
    level.camera_anchor.angles = var_05.angles;
  } else {
    camera_move_helper(var_05, param_01, param_03);
  }

  while(isDefined(var_05.target)) {
    if(!isDefined(var_05.target)) {
      return;
    }

    var_05 = getent(var_05.target, "targetname");
    camera_move_helper(var_05, param_01, param_03);
  }

  level.camera_anchor.move_target = undefined;
  if(isDefined(param_04)) {
    self thread[[param_04]]();
  }
}

frontend_camera_teleport(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("camera_teleport");
  level endon("camera_teleport");
  level.playerviewowner predictstreampos(param_00.origin);
  level.transition_interrupted = 1;
  frontendscenecamerafade(0, param_03);
  wait(param_03 + 0.05);
  frontendscenecamerafov(param_01, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = param_00.origin;
  level.camera_anchor.angles = param_00.angles;
  level.camera_anchor.move_target = undefined;
  if(isDefined(param_02)) {
    frontendscenecameracinematic(param_02);
  }

  wait(0.1);
  if(isDefined(param_05)) {
    [[param_05]]();
  }

  frontendscenecamerafade(1, param_04);
  level.transition_interrupted = 0;
}

frontend_camera_watcher(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self cameralinkto(level.camera_anchor, "tag_origin");
  level.active_section = frontendscenegetactivesection();
  [[param_00]](level.active_section);
  scripts\engine\utility::waitframe();
  for(;;) {
    var_01 = frontendscenegetactivesection();
    if(var_01.name == level.active_section.name && var_01.index == level.active_section.index) {
      scripts\engine\utility::waitframe();
      continue;
    }

    level.active_section = var_01;
    [[param_00]](var_01);
  }
}