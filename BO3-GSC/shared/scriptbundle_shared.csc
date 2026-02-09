/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\scriptbundle_shared.csc
*************************************************/

#using scripts\shared\util_shared;

class cscriptbundleobjectbase {
  var _e_array;
  var _o_bundle;
  var _s;
  var _n_clientnum;

  constructor() {}

  destructor() {}

  function get_ent(localclientnum) {
    return _e_array[localclientnum];
  }

  function error(condition, str_msg) {
    if(condition) {
      if([[_o_bundle]] - > is_testing()) {
        scriptbundle::error_on_screen(str_msg);
      } else {
        assertmsg((((([[_o_bundle]] - > get_type()) + "") + ([[_o_bundle]] - > get_name()) + "") + (isDefined(_s.name) ? "" + _s.name : (isDefined("") ? "" + "" : "")) + "") + str_msg);
      }
      thread[[_o_bundle]] - > on_error();
      return true;
    }
    return false;
  }

  function log(str_msg) {
    println((((([[_o_bundle]] - > get_type()) + "") + ([[_o_bundle]] - > get_name()) + "") + (isDefined(_s.name) ? "" + _s.name : (isDefined("") ? "" + "" : "")) + "") + str_msg);
  }

  function init(s_objdef, o_bundle, e_ent, localclientnum) {
    _s = s_objdef;
    _o_bundle = o_bundle;
    if(isDefined(e_ent)) {
      assert(!isDefined(localclientnum) || e_ent.localclientnum == localclientnum, "");
      _n_clientnum = e_ent.localclientnum;
      _e_array[_n_clientnum] = e_ent;
    } else {
      _e_array = [];
      if(isDefined(localclientnum)) {
        _n_clientnum = localclientnum;
      }
    }
  }
}

class cscriptbundlebase {
  var _testing;
  var _s;
  var _str_name;
  var _a_objects;

  constructor() {
    _a_objects = [];
    _testing = 0;
  }

  destructor() {}

  function error(condition, str_msg) {
    if(condition) {
      if(_testing) {} else {
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
      level.scene_error_hud = createluimenu(0, "HudElementText");
      setluimenudata(0, level.scene_error_hud, "alignment", 1);
      setluimenudata(0, level.scene_error_hud, "x", 0);
      setluimenudata(0, level.scene_error_hud, "y", 10);
      setluimenudata(0, level.scene_error_hud, "width", 1920);
      openluimenu(0, level.scene_error_hud);
    }
    setluimenudata(0, level.scene_error_hud, "text", str_msg);
    self thread _destroy_error_on_screen();
  }
}

function _destroy_error_on_screen() {
  level notify("_destroy_error_on_screen");
  level endon("_destroy_error_on_screen");
  self util::waittill_notify_or_timeout("stopped", 5);
  closeluimenu(0, level.scene_error_hud);
  level.scene_error_hud = undefined;
}