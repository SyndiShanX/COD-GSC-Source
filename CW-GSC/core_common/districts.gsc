/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\districts.gsc
***********************************************/

#using script_1fa63e6c62e170a3;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace districts;

function private autoexec __init__system__() {
  system::register("cp_districts_system", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("world", "district_bitfield", 1, 20, "int");
  namespace_aff1f617::function_41e5864f();
}

function function_a7d79fcb(names, exclusive = 0) {
  if(!isDefined(names)) {
    names = [];
  } else if(!isarray(names)) {
    names = array(names);
  }

  var_8f63b4bd = level.var_59cd6d34.var_cd7d2e9f;

  if(exclusive) {
    var_8f63b4bd = 0;
  }

  foreach(name in names) {
    bit = function_da432d39(name);

    if(bit >= 0) {
      var_8f63b4bd |= 1 << bit;
    }
  }

  level function_1e34097d(var_8f63b4bd);
}

function function_930f8c81(names, exclusive = 0) {
  if(!isDefined(names)) {
    names = [];
  } else if(!isarray(names)) {
    names = array(names);
  }

  var_8f63b4bd = level.var_59cd6d34.var_cd7d2e9f;

  if(exclusive) {
    var_8f63b4bd = 1048575;
  }

  foreach(name in names) {
    bit = function_da432d39(name);

    if(bit >= 0) {
      mask = ~(1 << bit);
      var_8f63b4bd &= mask;
    }
  }

  level function_1e34097d(var_8f63b4bd);
}

function private function_da432d39(name) {
  index = level.var_59cd6d34.var_2844be06[name];

  if(isDefined(index)) {
    return index;
  }

  return -1;
}

function private function_1e34097d(var_8f63b4bd) {
  assert(var_8f63b4bd < 1048576);
  level.var_59cd6d34.var_cd7d2e9f = var_8f63b4bd;
  level clientfield::set("district_bitfield", level.var_59cd6d34.var_cd7d2e9f);
}