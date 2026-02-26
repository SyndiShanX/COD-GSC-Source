/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_79b2f8ff99dd484.csc
***********************************************/

#using scripts\core_common\lui_shared;
#namespace encodedradio_usebar;
class class_ba33e0c1: cluielem {
  function open(localclientnum) {
    cluielem::open(localclientnum);
  }

  function function_4aa46834(localclientnum, value) {
    set_data(localclientnum, "activatorCount", value);
  }

  function register_clientside() {
    cluielem::register_clientside("EncodedRadio_UseBar");
  }

  function setup_clientfields(var_ec85b709, var_193163f7) {
    cluielem::setup_clientfields("EncodedRadio_UseBar");
    cluielem::add_clientfield("_state", 1, 1, "int");
    cluielem::add_clientfield("progressFrac", 1, 10, "float", var_ec85b709);
    cluielem::add_clientfield("activatorCount", 1, 3, "int", var_193163f7);
  }

  function set_state(localclientnum, state_name) {
    if(#"defaultstate" == state_name) {
      set_data(localclientnum, "_state", 0);
      return;
    }

    if(#"hash_5fba3d476e0b33f8" == state_name) {
      set_data(localclientnum, "_state", 1);
      return;
    }

    assertmsg("<dev string:x38>");
  }

  function function_f0df5702(localclientnum, value) {
    set_data(localclientnum, "progressFrac", value);
  }

  function function_fa582112(localclientnum) {
    cluielem::function_fa582112(localclientnum);
    set_state(localclientnum, #"defaultstate");
    set_data(localclientnum, "progressFrac", 0);
    set_data(localclientnum, "activatorCount", 0);
  }
}

function register(var_ec85b709, var_193163f7) {
  elem = new class_ba33e0c1();
  [[elem]] - > setup_clientfields(var_ec85b709, var_193163f7);

  if(!isDefined(level.var_ae746e8f)) {
    level.var_ae746e8f = associativearray();
  }

  if(!isDefined(level.var_ae746e8f[#"encodedradio_usebar"])) {
    level.var_ae746e8f[#"encodedradio_usebar"] = [];
  }

  if(!isDefined(level.var_ae746e8f[#"encodedradio_usebar"])) {
    level.var_ae746e8f[#"encodedradio_usebar"] = [];
  } else if(!isarray(level.var_ae746e8f[#"encodedradio_usebar"])) {
    level.var_ae746e8f[#"encodedradio_usebar"] = array(level.var_ae746e8f[#"encodedradio_usebar"]);
  }

  level.var_ae746e8f[#"encodedradio_usebar"][level.var_ae746e8f[#"encodedradio_usebar"].size] = elem;
}

function register_clientside() {
  elem = new class_ba33e0c1();
  [[elem]] - > register_clientside();
  return elem;
}

function open(player) {
  [[self]] - > open(player);
}

function close(player) {
  [[self]] - > close(player);
}

function is_open(localclientnum) {
  return [[self]] - > is_open(localclientnum);
}

function set_state(localclientnum, state_name) {
  [[self]] - > set_state(localclientnum, state_name);
}

function function_f0df5702(localclientnum, value) {
  [[self]] - > function_f0df5702(localclientnum, value);
}

function function_4aa46834(localclientnum, value) {
  [[self]] - > function_4aa46834(localclientnum, value);
}