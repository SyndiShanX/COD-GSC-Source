/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7989767905e8a3ec.gsc
*************************************************/

#using scripts\common\devgui;
#using scripts\engine\utility;
#using scripts\mp\hud_message;
#namespace ob_splashes;

function init() {
  splashlist = function_58629fa086464ceb(level.gamemodebundle.splashlist);

  if(isDefined(splashlist)) {
    scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");

    foreach(splash in splashlist.splash_list) {
      splashname = getxhashsourcename(splash.ref);

      if(string_starts_with(splashname, "<dev string:x33>") || string_starts_with(splashname, "<dev string:x3a>")) {
        scripts\common\devgui::function_b23a59dfb4ca49a1(splashname, "<dev string:x44>" + splashname + "<dev string:x4f>" + level.gamemodebundle.splashlist, &function_652ce4b2c3591175);
      }
    }

    scripts\common\devgui::function_fe953f000498048f();
  }

  splashlist = function_58629fa086464ceb("<dev string:x54>");
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x6a>");

  foreach(splash in splashlist.splash_list) {
    splashname = getxhashsourcename(splash.ref);
    scripts\common\devgui::function_b23a59dfb4ca49a1(splashname, "<dev string:x44>" + splashname + "<dev string:x4f>" + "<dev string:x54>", &function_652ce4b2c3591175);
  }

  scripts\common\devgui::function_fe953f000498048f();
}

function private function_58629fa086464ceb(var_c1c3e6a4f162ab45) {
  if(!isDefined(var_c1c3e6a4f162ab45)) {
    return undefined;
  }

  if(isxhashasset(var_c1c3e6a4f162ab45)) {
    splashlist = getscriptbundle(var_c1c3e6a4f162ab45);
  } else {
    splashlist = getscriptbundle(hashcat(%"hash_7ac5a0b15c7d50e5", var_c1c3e6a4f162ab45));
  }

  return splashlist;
}

function private function_652ce4b2c3591175(params) {
  splashref = params[0];
  splashlist = params[1];

  if(!isDefined(splashref) || !isDefined(splashlist)) {
    return;
  }

  foreach(player in level.players) {
    if(isDefined(player)) {
      player scripts\mp\hud_message::function_51614e8fce37b07f(splashref, splashlist);
    }
  }
}

# /