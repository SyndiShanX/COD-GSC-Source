/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\introscreen.gsc
**************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\endmission;
#using scripts\sp\hud_util;
#namespace introscreen;

function init_introscreen() {
  utility::flag_init("-\xb9G'o\xdc\xc6'ee\xe6\xebc\xed\xdapc\x95\xa3Y");
}

function main() {
  precacheshader("\x8a-\v\xa1\xbd");

  setdevdvarifuninitialized(@ "introscreen", "<dev string:x24>");

  setomnvar("\xc0\xdd\xad\x024\xa9\xb4o\x92`\x12\x14", 0);
  thread main_thread();
}

function main_thread() {
  utility::flag_wait("v8\xdf\xed\x16\x1e~\xb5\xb7\xef\xd0M");
  devskip = 0;

  devskip = getDvar(@ "introscreen") == "<dev string:x29>";

  thread quick_fadeup();

  if(!utility_sp::is_default_start() || devskip) {
    utility::delaythread(0.05, &utility::flag_set, "-\xb9G'o\xdc\xc6'ee\xe6\xebc\xed\xdapc\x95\xa3Y");
    return;
  }

  if(!utility::flag("\a^\x87\xd8p[\x8d\xd1\xec\xb1\xa8)g\xb77L0U")) {
    utility::delaythread(1, &introscreen);
  }
}

function level_has_chyron() {
  mapinfo = function_cbe75068ad1ba418();
  return isDefined(mapinfo) && isDefined(mapinfo.var_b8f552ec8d5efe44) && mapinfo.var_b8f552ec8d5efe44 != &"";
}

function quick_fadeup() {
  level.introscreen_bg = hud_util::create_client_overlay("\x8a-\v\xa1\xbd", 1);
  wait 0.2;
  level.introscreen_bg.alpha = 0;
  level.introscreen_bg destroy();
}

function introscreen(no_bg, bg_time) {
  if(utility::flag_exist("8\xd5 \x19\x87\xc1G\xc7\xa9\xe5\xa3\x97\x8aA\x9eID\xff\x1d|\xf7\xda")) {
    utility::flag_wait("8\xd5 \x19\x87\xc1G\xc7\xa9\xe5\xa3\x97\x8aA\x9eID\xff\x1d|\xf7\xda");
  }

  index = endmission::getlevelindex(level.mapinfoname);

  if(!isDefined(index)) {
    return;
  }

  index += 1;
  setomnvar("]\xb4\xbe\xd8\xa1\xe5\x93\xf6\xcd}l\xacg\x95\xd8}K7F\xacx", index);
  setomnvar("\xc0\xdd\xad\x024\xa9\xb4o\x92`\x12\x14", 1);
  setomnvar("\x92\x83\b|/\xf9\x9f\xd6\xbc\xb2^\xee]\n\x95\xb5", 1);
  wait 6;
  setomnvar("\x92\x83\b|/\xf9\x9f\xd6\xbc\xb2^\xee]\n\x95\xb5", 0);
  setomnvar("\xc0\xdd\xad\x024\xa9\xb4o\x92`\x12\x14", 0);
  utility::flag_set("-\xb9G'o\xdc\xc6'ee\xe6\xebc\xed\xdapc\x95\xa3Y");
}