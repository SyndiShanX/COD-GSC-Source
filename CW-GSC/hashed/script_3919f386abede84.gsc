/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3919f386abede84.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;

#namespace windows;
class class_e500a966: cdoor {
  var m_s_bundle;
  var m_str_type;
  var var_a2f96f78;

  constructor() {
    m_str_type = "window";
  }

  function init(var_82b05767, s_instance) {
    m_s_bundle = var_82b05767;
    var_a2f96f78 = s_instance;
    s_instance.c_door = doors::setup_door_info(m_s_bundle, s_instance, self);
  }
}

function private autoexec __init__system__() {
  system::register(#"windows", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  if(!isDefined(level.a_s_windows)) {
    level.a_s_windows = [];
  }
}

function init_window() {
  if(isDefined(self.scriptbundlename)) {
    var_82b05767 = getscriptbundle(self.scriptbundlename);
  }

  var_9bff4cd8 = new class_e500a966();
  var_9bff4cd8 = [[var_9bff4cd8]] - > init(var_82b05767, self);
  return var_9bff4cd8;
}

function private postinit() {
  level flag::wait_till("radiant_gameobjects_initialized");
  level.a_s_windows = struct::get_array("scriptbundle_windows", "classname");

  foreach(s_instance in level.a_s_windows) {
    c_door = s_instance init_window();

    if(isDefined(c_door)) {
      s_instance.c_door = c_door;
    }
  }

  foreach(s_instance in level.a_s_windows) {
    if(isDefined(s_instance.linkname)) {
      var_d5700a96 = struct::get_array(s_instance.linkname, "linkto");

      if(isDefined(var_d5700a96[0])) {
        s_instance.c_door.var_d1c4f848 = var_d5700a96[0];
        var_d5700a96[0].c_door.var_d1c4f848 = s_instance;
      }
    }
  }
}

function open(str_value, str_key) {
  self doors::open(str_value, str_key);
}

function close(str_value, str_key) {
  self doors::close(str_value, str_key);
}

function lock(str_value, str_key = "targetname", b_do_close = 1) {
  self doors::lock(str_value, str_key, b_do_close);
}

function unlock(str_value, str_key = "targetname", b_do_open = 1) {
  self doors::unlock(str_value, str_key, b_do_open);
}

function function_d216984f(str_value, str_key = "targetname") {
  a_s_windows = [];

  if(isDefined(str_value)) {
    a_structs = struct::get_array(str_value, str_key);

    foreach(struct in a_structs) {
      if(isinarray(level.a_s_windows, struct)) {
        array::add(a_s_windows, struct, 0);
      }
    }
  } else {
    a_s_windows = level.a_s_windows;
  }

  return a_s_windows;
}