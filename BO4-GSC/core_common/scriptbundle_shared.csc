/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\scriptbundle_shared.csc
***********************************************/

#namespace scriptbundle;

class cscriptbundleobjectbase {
  var _e_array;
  var _n_clientnum;
  var _o_scene;
  var _s;

  function get_ent(localclientnum) {
    return _e_array[localclientnum];
  }

  function error(condition, str_msg) {
    if(condition) {
      if([
          [_o_scene]
        ] - > is_testing()) {
        scriptbundle::error_on_screen(str_msg);
      } else {
        assertmsg([
          [_o_scene]
        ] - > get_type() + "<dev string:x58>" + function_9e72a96(_o_scene._str_name) + "<dev string:x5c>" + (isDefined("<dev string:x65>") ? "<dev string:x62>" + "<dev string:x65>" : isDefined(_s.name) ? "<dev string:x62>" + _s.name : "<dev string:x62>") + "<dev string:x6f>" + str_msg);
      }

      thread[[_o_scene]] - > on_error();
      return true;
    }

    return false;
  }

  function log(str_msg) {
    println([[_o_scene]] - > get_type() + "<dev string:x58>" + function_9e72a96(_o_scene._str_name) + "<dev string:x5c>" + (isDefined("<dev string:x65>") ? "<dev string:x62>" + "<dev string:x65>" : isDefined(_s.name) ? "<dev string:x62>" + _s.name : "<dev string:x62>") + "<dev string:x6f>" + str_msg);
  }

  function init(s_objdef, o_bundle, e_ent, localclientnum) {
    _s = s_objdef;
    _o_scene = o_bundle;

    if(isDefined(e_ent)) {
      assert(!isDefined(localclientnum) || e_ent.localclientnum == localclientnum, "<dev string:x38>");
      _n_clientnum = e_ent.localclientnum;
      _e_array[_n_clientnum] = e_ent;
      return;
    }

    _e_array = [];

    if(isDefined(localclientnum)) {
      _n_clientnum = localclientnum;
    }
  }

}

class cscriptbundlebase {
  var _a_objects;
  var _s;
  var _str_name;
  var _testing;

  constructor() {
    _a_objects = [];
    _testing = 0;
  }

  function error(condition, str_msg) {
    if(condition) {
      if(_testing) {} else {
        assertmsg(_s.type + "<dev string:x58>" + function_9e72a96(_str_name) + "<dev string:x74>" + str_msg);
      }

      thread on_error();
      return true;
    }

    return false;
  }

  function log(str_msg) {
    println(_s.type + "<dev string:x58>" + _str_name + "<dev string:x74>" + str_msg);
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

error_on_screen(str_msg) {
  if(str_msg != "") {
    if(!isDefined(level.scene_error_hud)) {
      level.scene_error_hud = createluimenu(0, "HudElementText");
      setluimenudata(0, level.scene_error_hud, #"alignment", 1);
      setluimenudata(0, level.scene_error_hud, #"x", 0);
      setluimenudata(0, level.scene_error_hud, #"y", 10);
      setluimenudata(0, level.scene_error_hud, #"width", 1920);
      openluimenu(0, level.scene_error_hud);
    }

    setluimenudata(0, level.scene_error_hud, #"text", str_msg);
    self thread _destroy_error_on_screen();
  }
}

_destroy_error_on_screen() {
  level notify(#"_destroy_error_on_screen");
  level endon(#"_destroy_error_on_screen");
  self waittilltimeout(5, #"stopped");
  closeluimenu(0, level.scene_error_hud);
  level.scene_error_hud = undefined;
}