/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\debug_menu.gsc
***********************************************/

#namespace debug_menu;

function set_hudelem(text, x, y, scale, alpha, sort, debug_hudelem) {
  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  if(!isDefined(sort)) {
    sort = 20;
  }

  if(isDefined(level.player) && !isDefined(debug_hudelem)) {
    hud = newdebughudelem(level.player);
  } else {
    hud = newdebughudelem();
    hud.debug_hudelem = 1;
  }

  hud.location = 0;
  hud.alignx = "<dev string:x38>";
  hud.aligny = "<dev string:x40>";
  hud.foreground = 1;
  hud.fontscale = scale;
  hud.sort = sort;
  hud.alpha = alpha;
  hud.x = x;
  hud.y = y;
  hud.og_scale = scale;

  if(isDefined(text)) {
    hud settext(text);
  }

  return hud;
}

function new_hud(hud_name, msg, x, y, scale) {
  if(!isDefined(level.hud_array)) {
    level.hud_array = [];
  }

  if(!isDefined(level.hud_array[hud_name])) {
    level.hud_array[hud_name] = [];
  }

  hud = set_hudelem(msg, x, y, scale);
  level.hud_array[hud_name][level.hud_array[hud_name].size] = hud;
  return hud;
}

function function_7cafeca(hud_name) {
  if(!isDefined(level.hud_array[hud_name])) {
    return;
  }

  huds = level.hud_array[hud_name];

  for(i = 0; i < huds.size; i++) {
    function_2a064f4f(huds[i]);
  }

  level.hud_array[hud_name] = undefined;
}

function function_2a064f4f(hud) {
  if(isDefined(hud)) {
    hud destroy();
  }
}