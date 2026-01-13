/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2680.gsc
************************/

frontend_camera_setup(var_0, var_1) {
  level.camera_anchor = spawn("script_model", var_0);
  level.camera_anchor setModel("tag_origin");
  level.camera_anchor.angles = var_1;
}

camera_move_helper(var_0, var_1, var_2) {
  level.playerviewowner predictstreampos(var_0.origin);
  var_3 = distance(level.camera_anchor.origin, var_0.origin);
  var_4 = var_3 / var_1;
  if(var_4 < 0.05) {
    var_4 = 0.05;
  }

  var_5 = 0;
  if(var_2) {
    var_5 = var_4 * 0.1;
  }

  level.camera_anchor.move_target = var_0;
  level.camera_anchor moveto(var_0.origin, var_4, var_5, var_5);
  level.camera_anchor rotateto(var_0.angles, var_4, var_5, var_5);
  wait(var_4);
}

frontend_camera_move(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  self endon("disconnect");
  if(isDefined(level.camera_anchor.move_target)) {
    level.camera_anchor.origin = level.camera_anchor.move_target.origin;
    level.camera_anchor.angles = level.camera_anchor.move_target.angles;
  }

  level notify("camera_move");
  level endon("camera_move");
  if(!isDefined(var_1)) {
    var_1 = 900;
  }

  var_5 = var_0;
  if(var_2) {
    level.camera_anchor.origin = var_5.origin;
    level.camera_anchor.angles = var_5.angles;
  } else {
    camera_move_helper(var_5, var_1, var_3);
  }

  while(isDefined(var_5.target)) {
    if(!isDefined(var_5.target)) {
      return;
    }

    var_5 = getent(var_5.target, "targetname");
    camera_move_helper(var_5, var_1, var_3);
  }

  level.camera_anchor.move_target = undefined;
  if(isDefined(var_4)) {
    self thread[[var_4]]();
  }
}

frontend_camera_teleport(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self endon("disconnect");
  level notify("camera_teleport");
  level endon("camera_teleport");
  level.playerviewowner predictstreampos(var_0.origin);
  level.transition_interrupted = 1;
  frontendscenecamerafade(0, var_3);
  wait(var_3 + 0.05);
  frontendscenecamerafov(var_1, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var_0.origin;
  level.camera_anchor.angles = var_0.angles;
  level.camera_anchor.move_target = undefined;
  if(isDefined(var_2)) {
    frontendscenecameracinematic(var_2);
  }

  wait(0.1);
  if(isDefined(var_5)) {
    [[var_5]]();
  }

  frontendscenecamerafade(1, var_4);
  level.transition_interrupted = 0;
}

frontend_camera_watcher(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self cameralinkto(level.camera_anchor, "tag_origin");
  level.active_section = frontendscenegetactivesection();
  [[var_0]](level.active_section);
  scripts\engine\utility::waitframe();
  for(;;) {
    var_1 = frontendscenegetactivesection();
    if(var_1.name == level.active_section.name && var_1.index == level.active_section.index) {
      scripts\engine\utility::waitframe();
      continue;
    }

    level.active_section = var_1;
    [[var_0]](var_1);
  }
}