/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_4a70de683189a148.gsc
*****************************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\engine\hud_management;
#using scripts\engine\sp\objectives;
#using scripts\engine\utility;
#namespace objective_splash;

function private autoexec __init__system__() {
  system::register(#"objective_splash", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_cf9ecc67bb7fa823();
}

function private function_cf9ecc67bb7fa823() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) != 0) {
    return;
  }

  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  if(!isDefined(level.objectives_splash)) {
    level.objectives_splash = spawnStruct();
  }

  objectives::function_9e0b1a3890138a95(&show_splash);
  level.objectives_splash.widget = hud_management::function_a1a13273e72bfe46("\xffH\xde\xc57\xe7\xec\xb2\xbc\x9b\"\xbd\xf5t\xc0g9\xb4\xd6,IB\xfd%}k\x17 \xa7\xb9yV");
  ui::lui_registercallback("\xa0\xd6:x\xe6\x1b\xc7\x85\xbb\a\xb3\xb7\xf8\xc9j\xc8>>\x97`'\xf2\xdf\x89\xb3", &remove_splash);
  level.objectives_splash.var_4df8384ed65f6416 = [];
  level utility::flag_set("X\x1bo\xae\x06\x90l\xc0\x11\xbc\xa9{\xec)\x19\xabh7t\x9a\xb7Y\xb6\xd6\x90\x06e]");
}

function private open_splash(ref_str, title_ref, desc_ref, var_1006367e370af033, max_count = 0, current_count = 0, is_optional = 0, is_completed = 0, var_dca166fb7d45e3d9 = 0) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(!hud_management::function_48c98ea9a4f0da89("\x17\xb2D>l\x04\xbf\x8c\xba\xffh\x92=\xef\x98\x05")) {
    hud_management::function_35924dfcb78711f4("\x17\xb2D>l\x04\xbf\x8c\xba\xffh\x92=\xef\x98\x05", level.objectives_splash.widget);
  }

  var_93941bc757a86233 = [];
  var_fa52980bf613f95c = 0;

  if(isDefined(title_ref)) {
    var_fa52980bf613f95c = function_30e4f86dded0873(title_ref);
  }

  var_93941bc757a86233["G\xb4G\xc6V\xd7-7\x8cY\xc3"] = var_fa52980bf613f95c;
  var_b7569549b3c142f9 = 0;

  if(isDefined(desc_ref)) {
    var_b7569549b3c142f9 = function_30e4f86dded0873(desc_ref);
  }

  var_93941bc757a86233["\x8b\xca\x91\x19\x8f0\xa8\x8c\xc2t"] = var_b7569549b3c142f9;
  var_5191a92385cc6f73 = 0;

  if(isDefined(var_1006367e370af033)) {
    var_5191a92385cc6f73 = function_30e4f86dded0873(var_1006367e370af033);
  }

  level.player setclientomnvar("d\x9dk\x04\xf6>be\x9e\x15Z\xc8G'\xe1\x0fG\xcfm\xf6\xcct\xb4\x03\x8d\xb6\x89\xe1\x037\xb9\x1d\x81", var_5191a92385cc6f73);
  level.player setclientomnvar("@\xb2\xea\x01\xd6Xs\x0e\x0f\x80\xbb\xd1\xceP\x9b\x98\x9c\xb3\xe0D\xa2\xfe\xa8\x0e\xaff", max_count);
  level.player setclientomnvar("\xec\xcdJ\xa8&\xfe6e+\xde\x8e t\xf9\xc74\xd6\x06\xb5;\xe6\xbbM\xce\xdf\xa5r\xfe\x7f\xd9", current_count);
  level.player setclientomnvar("oL5\xcac\x1d\xb4vY\xebn\x1c\x8das\r\xaf-7}o\x0e\xa3K\xdenX\xd8", is_optional);
  level.player setclientomnvar("\xb4\xd0\x95\xf3Au\a.\x9a\xf1\xf5\xbe\xef?\x12\xcf&\x7f\xdb\x06=T1)r\xb56oY", is_completed);
  level.player setclientomnvar("\xac\x14\xde\xd7\x93\b\xbc\x81\xcd\xaa>\xb2\xfe\xa3c\x80{\xc9n\xfa\xa3m\xa56,\x11\x12\xd5\xb0\x99\x8d\x93\x1f_\x84\xb1\xf3\x81d\x04", var_dca166fb7d45e3d9);
  hud_management::function_b683400f784cb7dc("\x17\xb2D>l\x04\xbf\x8c\xba\xffh\x92=\xef\x98\x05", ref_str);
  hud_management::function_41ff479ac45608d6("\x17\xb2D>l\x04\xbf\x8c\xba\xffh\x92=\xef\x98\x05", var_93941bc757a86233, 1);
  thread function_5cfedf5c9d0769c5();
}

function show_splash(ref_str, title_ref, desc_ref, var_1006367e370af033, max_count = 0, current_count = 0, is_optional = 0, is_completed = 0, var_dca166fb7d45e3d9 = 0) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("X\x1bo\xae\x06\x90l\xc0\x11\xbc\xa9{\xec)\x19\xabh7t\x9a\xb7Y\xb6\xd6\x90\x06e]");
  assert(isDefined(ref_str));
  assert(isDefined(level.objectives_splash.widget), "<dev string:x24>");
  var_187be7d785080ca5 = ref_str;
  splash_title = title_ref;
  splash_desc = desc_ref;
  var_67915b9a802536c3 = var_1006367e370af033;
  splash_max_count = max_count;
  splash_count = current_count;
  splash_is_optional = is_optional;
  splash_is_completed = is_completed;
  var_18ec1f65c0c3070b = var_dca166fb7d45e3d9;

  if(hud_management::function_48c98ea9a4f0da89("\x17\xb2D>l\x04\xbf\x8c\xba\xffh\x92=\xef\x98\x05")) {
    next_splash = spawnStruct();
    next_splash.var_187be7d785080ca5 = ref_str;
    next_splash.splash_title = splash_title;
    next_splash.splash_desc = splash_desc;
    next_splash.var_67915b9a802536c3 = var_67915b9a802536c3;
    next_splash.splash_max_count = splash_max_count;
    next_splash.splash_count = splash_count;
    next_splash.splash_is_optional = splash_is_optional;
    next_splash.splash_is_completed = splash_is_completed;
    next_splash.var_18ec1f65c0c3070b = var_18ec1f65c0c3070b;
    level.objectives_splash.var_4df8384ed65f6416[level.objectives_splash.var_4df8384ed65f6416.size] = next_splash;
    return;
  }

  open_splash(var_187be7d785080ca5, splash_title, splash_desc, var_67915b9a802536c3, splash_max_count, splash_count, splash_is_optional, splash_is_completed, var_18ec1f65c0c3070b);
}

function function_5cfedf5c9d0769c5() {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x1e\xfd\xd1\xa2\a");
  objectives::function_6a716326b0952674();
}

function function_8575ca939054d8ce(count_value, count_max) {}

function function_4ade8c31e7621af0(state_str) {
  hud_management::function_d8d634ceece460("\x17\xb2D>l\x04\xbf\x8c\xba\xffh\x92=\xef\x98\x05", state_str);
}

function remove_splash(val) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(level.objectives_splash.var_4df8384ed65f6416.size > 0) {
    next_splash = level.objectives_splash.var_4df8384ed65f6416[0];
    thread open_splash(next_splash.var_187be7d785080ca5, next_splash.splash_title, next_splash.splash_desc, next_splash.var_67915b9a802536c3, next_splash.splash_max_count, next_splash.splash_count, next_splash.splash_is_optional, next_splash.splash_is_completed, next_splash.var_18ec1f65c0c3070b);
    self setclientomnvar("\xbd\xb1\xc6\xa1\xeb\x05$^L\xd0\xbb\xcb3[u\x88\xf9\xda$\xcc\x94\x1f\x82", !self getclientomnvar("\xbd\xb1\xc6\xa1\xeb\x05$^L\xd0\xbb\xcb3[u\x88\xf9\xda$\xcc\x94\x1f\x82"));
    level.objectives_splash.var_4df8384ed65f6416 = utility::array_remove_index(level.objectives_splash.var_4df8384ed65f6416, 0);
    return;
  }

  hud_management::scripted_widget_destroy("\x17\xb2D>l\x04\xbf\x8c\xba\xffh\x92=\xef\x98\x05");
}