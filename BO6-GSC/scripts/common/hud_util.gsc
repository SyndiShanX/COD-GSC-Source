/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\hud_util.gsc
***************************************/

#namespace hud_util;

function create_client_overlay(shader_name, start_alpha, player) {
  if(isDefined(player)) {
    overlay = newclienthudelem(player);
  } else {
    overlay = newhudelem();
  }

  overlay.x = 0;
  overlay.y = 0;
  overlay setshader(shader_name, 640, 480);
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = start_alpha;
  overlay.foreground = 1;
  return overlay;
}

function fade_in(time, shader) {
  if(level.missionfailed) {
    return;
  }

  if(!isDefined(time)) {
    time = 0.3;
  }

  overlay = get_optional_overlay(shader);

  if(time > 0) {
    overlay fadeovertime(time);
  }

  overlay.alpha = 0;

  if(time > 0) {
    wait time;
  }
}

function get_optional_overlay(shader) {
  if(!isDefined(shader)) {
    shader = "black";
  }

  return get_overlay(shader);
}

function fade_out(time, shader) {
  if(!isDefined(time)) {
    time = 0.3;
  }

  overlay = get_optional_overlay(shader);

  if(time > 0) {
    overlay fadeovertime(time);
  }

  overlay.alpha = 1;

  if(time > 0) {
    wait time;
  }
}

function get_overlay(shader) {
  if(isPlayer(self)) {
    guy = self;
  } else {
    guy = level.player;
  }

  if(!isDefined(guy.overlay)) {
    guy.overlay = [];
  }

  if(!isDefined(guy.overlay[shader])) {
    guy.overlay[shader] = create_client_overlay(shader, 0, guy);
  }

  guy.overlay[shader].sort = 0;
  guy.overlay[shader].foreground = 1;
  return guy.overlay[shader];
}