/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\scriptbundle_shared.gsc
*************************************************/

#using scripts\shared\lui_shared;
#using scripts\shared\util_shared;

class cscriptbundleobjectbase {
  var _e;
  var _o_bundle;
  var _s;

  constructor() {}

  destructor() {}

  function get_ent() {
    return _e;
  }

  function warning(condition, str_msg) {
    if(condition) {
      str_msg = ((("[ " + ([[_o_bundle]] - > get_name())) + " ] ") + (isDefined(_s.name) ? "" + _s.name : (isDefined("no name") ? "" + "no name" : "")) + ": ") + str_msg;
      scriptbundle::warning_on_screen(str_msg);
      return true;
    }
    return false;
  }

  function error(condition, str_msg) {
    if(condition) {
      str_msg = ((("[ " + ([[_o_bundle]] - > get_name())) + " ] ") + (isDefined(_s.name) ? "" + _s.name : (isDefined("no name") ? "" + "no name" : "")) + ": ") + str_msg;
      if([[_o_bundle]] - > is_testing()) {
        scriptbundle::error_on_screen(str_msg);
      } else {
        assertmsg(str_msg);
      }
      thread[[_o_bundle]] - > on_error();
      return true;
    }
    return false;
  }

  function log(str_msg) {
    println((((([[_o_bundle]] - > get_type()) + "") + ([[_o_bundle]] - > get_name()) + "") + (isDefined(_s.name) ? "" + _s.name : (isDefined("") ? "" + "" : "")) + "") + str_msg);
  }

  function init(s_objdef, o_bundle, e_ent) {
    _s = s_objdef;
    _o_bundle = o_bundle;
    _e = e_ent;
  }
}

class cscriptbundlebase {
  var _testing;
  var _str_name;
  var _s;
  var _a_objects;

  constructor() {
    _a_objects = [];
    _testing = 0;
  }

  destructor() {}

  function warning(condition, str_msg) {
    if(condition) {
      if(_testing) {
        scriptbundle::warning_on_screen((("[ " + _str_name) + " ]: ") + str_msg);
      }
      return true;
    }
    return false;
  }

  function error(condition, str_msg) {
    if(condition) {
      if(_testing) {
        scriptbundle::error_on_screen(str_msg);
      } else {
        assertmsg((((_s.type + "") + _str_name) + "") + str_msg);
      }
      thread[[self]] - > on_error();
      return true;
    }
    return false;
  }

  function log(str_msg) {
    println((((_s.type + "") + _str_name) + "") + str_msg);
  }

  function remove_object(o_object) {
    arrayremovevalue(_a_objects, o_object);
  }

  function add_object(o_object) {
    if(!isDefined(_a_objects)) {
      _a_objects = [];
    } else if(!isarray(_a_objects)) {
      _a_objects = array(_a_objects);
    }
    _a_objects[_a_objects.size] = o_object;
  }

  function is_testing() {
    return _testing;
  }

  function get_objects() {
    return _s.objects;
  }

  function get_vm() {
    return _s.vmtype;
  }

  function get_name() {
    return _str_name;
  }

  function get_type() {
    return _s.type;
  }

  function init(str_name, s, b_testing) {
    _s = s;
    _str_name = str_name;
    _testing = b_testing;
  }

  function on_error(e) {}
}

#namespace scriptbundle;

function error_on_screen(str_msg) {
  if(str_msg != "") {
    if(!isDefined(level.scene_error_hud)) {
      level.scene_error_hud = level.players[0] openluimenu("HudElementText");
      level.players[0] setluimenudata(level.scene_error_hud, "alignment", 2);
      level.players[0] setluimenudata(level.scene_error_hud, "x", 0);
      level.players[0] setluimenudata(level.scene_error_hud, "y", 10);
      level.players[0] setluimenudata(level.scene_error_hud, "width", 1280);
      level.players[0] lui::set_color(level.scene_error_hud, (1, 0, 0));
    }
    level.players[0] setluimenudata(level.scene_error_hud, "text", str_msg);
    self thread _destroy_error_on_screen();
  }
}

function _destroy_error_on_screen() {
  level notify("_destroy_error_on_screen");
  level endon("_destroy_error_on_screen");
  self util::waittill_notify_or_timeout("stopped", 5);
  level.players[0] closeluimenu(level.scene_error_hud);
  level.scene_error_hud = undefined;
}

function warning_on_screen(str_msg) {
  if(str_msg != "") {
    if(!isDefined(level.scene_warning_hud)) {
      level.scene_warning_hud = level.players[0] openluimenu("");
      level.players[0] setluimenudata(level.scene_warning_hud, "", 2);
      level.players[0] setluimenudata(level.scene_warning_hud, "", 0);
      level.players[0] setluimenudata(level.scene_warning_hud, "", 1060);
      level.players[0] setluimenudata(level.scene_warning_hud, "", 1280);
      level.players[0] lui::set_color(level.scene_warning_hud, (1, 1, 0));
    }
    level.players[0] setluimenudata(level.scene_warning_hud, "", str_msg);
    self thread _destroy_warning_on_screen();
  }
}

function _destroy_warning_on_screen() {
  level notify("_destroy_warning_on_screen");
  level endon("_destroy_warning_on_screen");
  self util::waittill_notify_or_timeout("stopped", 10);
  level.players[0] closeluimenu(level.scene_warning_hud);
  level.scene_warning_hud = undefined;
}