/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\introscreen.gsc
***********************************************/

#using script_575fda2758b0a36e;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\hud_util;
#using scripts\sp\utility;
#namespace introscreen;

function init_introscreen() {
  flag_init("introscreen_complete");
}

function main() {
  precacheshader("black");

  setdevdvarifuninitialized(@ "introscreen", "<dev string:x1c>");

  setomnvar("ui_chyron_on", 0);
  thread main_thread();
}

function main_thread() {
  flag_wait("start_is_set");
  devskip = 0;

  devskip = getDvar(@ "introscreen") == "<dev string:x1e>";

  thread quick_fadeup();

  if(!is_default_start() || devskip) {
    delaythread(0.05, &flag_set, "introscreen_complete");
    return;
  }

  if(!flag("introscreen_custom")) {
    delaythread(1, &introscreen);
  }
}

function level_has_chyron() {
  mapinfo = function_f1e2d555fd823e99();
  return isDefined(mapinfo) && isDefined(mapinfo.var_589e062e2afaa7b8) && mapinfo.var_589e062e2afaa7b8 != &"";
}

function quick_fadeup() {
  level.introscreen_bg = create_client_overlay("black", 1);
  wait 0.2;
  level.introscreen_bg.alpha = 0;
  level.introscreen_bg destroy();
}

function introscreen(no_bg, bg_time) {
  if(flag_exist("introscreen_start_wait")) {
    flag_wait("introscreen_start_wait");
  }

  index = namespace_d6cca25f4b0ab62::getlevelindex(level.script);

  if(!isDefined(index)) {
    return;
  }

  index += 1;
  setomnvar("ui_chyron_level_index", index);
  setomnvar("ui_chyron_on", 1);
  setomnvar("ui_hide_dpad_hud", 1);
  wait 6;
  setomnvar("ui_hide_dpad_hud", 0);
  setomnvar("ui_chyron_on", 0);
  flag_set("introscreen_complete");
}