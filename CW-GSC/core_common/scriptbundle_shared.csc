/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\scriptbundle_shared.csc
***********************************************/

#namespace scriptbundle;
class cscriptbundleobjectbase {
  var _e_array;
  var _n_clientnum;
  var _o_scene;
  var _s;

  function error(condition, str_msg) {
    if(condition) {
      if([[_o_scene]] - > is_testing()) {
        scriptbundle::error_on_screen(str_msg);
      } else {
        assertmsg([[_o_scene]] - > get_type() + "<dev string:x59>" + function_9e72a96(_o_scene._str_name) + "<dev string:x5e>" + (isDefined("<dev string:x69>") ? "<dev string:x65>" + "<dev string:x69>" : isDefined(_s.name) ? "<dev string:x65>" + _s.name : "<dev string:x65>") + "<dev string:x74>" + str_msg);
      }

      thread[[_o_scene]] - > on_error();
      return true;
    }

    return false;
  }

  function get_ent(localclientnum) {
    return _e_array[localclientnum];
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

  function log(str_msg) {
    println([[_o_scene]] - > get_type() + "<dev string:x59>" + function_9e72a96(_o_scene._str_name) + "<dev string:x5e>" + (isDefined("<dev string:x69>") ? "<dev string:x65>" + "<dev string:x69>" : isDefined(_s.name) ? "<dev string:x65>" + _s.name : "<dev string:x65>") + "<dev string:x74>" + str_msg);
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
        assertmsg(_s.type + "<dev string:x59>" + function_9e72a96(_str_name) + "<dev string:x7a>" + str_msg);
      }

      thread on_error();
      return true;
    }

    return false;
  }

  function get_vm() {
    return _s.vmtype;
  }

  function get_type() {
    return _s.type;
  }

  function add_object(o_object) {
    if(!isDefined(_a_objects)) {
      _a_objects = [];
    } else if(!isarray(_a_objects)) {
      _a_objects = array(_a_objects);
    }

    _a_objects[_a_objects.size] = o_object;
  }

  function on_error(e) {}

  function is_testing() {
    return _testing;
  }

  function remove_object(o_object) {
    arrayremovevalue(_a_objects, o_object);
  }

  function init(str_name, s, b_testing) {
    _s = s;
    _str_name = str_name;
    _testing = b_testing;
  }

  function get_objects() {
    return _s.objects;
  }

  function log(str_msg) {
    println(_s.type + "<dev string:x59>" + _str_name + "<dev string:x7a>" + str_msg);
  }
}

function error_on_screen(str_msg) {
  if(str_msg != "") {
    errormsg(str_msg);
  }
}