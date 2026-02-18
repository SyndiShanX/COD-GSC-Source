/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\clientfield_shared.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;
#namespace clientfield;

function register(str_pool_name, str_name, n_version, n_bits, str_type) {
  registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type);
}

function function_5b7d846d(str_name, n_version, n_bits, str_type) {
  registerclientfield("worlduimodel", str_name, n_version, n_bits, str_type);
}

function register_clientuimodel(str_name, n_version, n_bits, str_type, var_59f69872) {
  registerclientfield("clientuimodel", str_name, n_version, n_bits, str_type, var_59f69872);
}

function register_luielem(menu_name, var_483e93f7, field_name, n_version, n_bits, str_type, var_59f69872) {
  registerclientfield("clientuimodel", "luielement." + menu_name + "." + (isDefined(var_483e93f7) ? "" + var_483e93f7 : "") + field_name, n_version, n_bits, str_type, var_59f69872);
}

function register_bgcache(poolname, var_b693fec6, uniqueid, version) {
  function_3ff577e6(poolname, var_b693fec6, uniqueid, version);
}

function function_d89771ec(var_b693fec6, uniqueid, version) {
  function_3ff577e6("worlduimodel", var_b693fec6, uniqueid, version);
}

function function_91cd7763(var_b693fec6, uniqueid, version, var_59f69872) {
  function_3ff577e6("clientuimodel", var_b693fec6, uniqueid, version, var_59f69872);
}

function function_b63c5dfe(var_b693fec6, menu_name, var_483e93f7, field_name, version, var_59f69872) {
  function_3ff577e6("clientuimodel", var_b693fec6, "luielement." + menu_name + "." + (isDefined(var_483e93f7) ? "" + var_483e93f7 : "") + field_name, version, var_59f69872);
}

function set(str_field_name, n_value) {
  self thread _set(str_field_name, n_value);
}

function _set(str_field_name, n_value) {
  if(!isDefined(str_field_name)) {
    assertmsg("<dev string:x38>");
    return;
  }

  if(!level flag::get(#"finalizeinit")) {
    var_17b7891d = "1be1d21ba1b21218" + str_field_name;
    self notify(var_17b7891d);
    self endon(var_17b7891d);
    self endon(#"death");
    level flag::wait_till(#"finalizeinit");
  }

  if(self == level) {
    codesetworldclientfield(str_field_name, n_value);
    return;
  }

  codesetclientfield(self, str_field_name, n_value);
}

function is_registered(field_name) {
  if(self == level) {
    return function_6de43d39(field_name);
  }

  var_24d738a9 = function_cf197fb7(self);

  if(var_24d738a9 == -1) {
    return 0;
  }

  return function_bda9951d(var_24d738a9, field_name);
}

function can_set(str_field_name, n_value) {
  return function_26b3a620();
}

function set_to_player(str_field_name, n_value) {
  assert(isPlayer(self), "<dev string:x78>");

  if(isPlayer(self)) {
    codesetplayerstateclientfield(self, str_field_name, n_value);
  }
}

function function_ec6130f9(str_field_name) {
  return function_3424020a(str_field_name);
}

function set_player_uimodel(str_field_name, n_value) {
  codesetuimodelclientfield(self, str_field_name, n_value);
}

function function_40aa8832(str_field_name) {
  return function_fcaed52(str_field_name);
}

function function_9bf78ef8(menu_name, var_483e93f7, str_field_name, n_value) {
  codesetuimodelclientfield(self, "luielement." + menu_name + "." + (isDefined(var_483e93f7) ? "" + var_483e93f7 : "") + str_field_name, n_value);
}

function function_bb878fc3(menu_name, var_483e93f7, str_field_name) {
  codeincrementuimodelclientfield(self, "luielement." + menu_name + "." + (isDefined(var_483e93f7) ? "" + var_483e93f7 : "") + str_field_name);
}

function get_player_uimodel(str_field_name) {
  return codegetuimodelclientfield(self, str_field_name);
}

function function_f7ae6994(menu_name, var_483e93f7, str_field_name) {
  return codegetuimodelclientfield(self, "luielement." + menu_name + "." + (isDefined(var_483e93f7) ? "" + var_483e93f7 : "") + str_field_name);
}

function set_world_uimodel(str_field_name, n_value) {
  codesetworlduimodelfield(str_field_name, n_value);
}

function function_1bea0e72(str_field_name) {
  return function_a02eca40(str_field_name);
}

function get_world_uimodel(str_field_name) {
  return codegetworlduimodelfield(str_field_name);
}

function increment_world_uimodel(str_field_name) {
  return codeincrementworlduimodelfield(str_field_name);
}

function increment(str_field_name, n_increment_count) {
  self thread _increment(str_field_name, n_increment_count);
}

function private _increment(str_field_name, n_increment_count = 1) {
  if(self != level) {
    self endon(#"death", #"disconnect");
    waittillframeend();
  }

  for(i = 0; i < n_increment_count; i++) {
    if(self == level) {
      codeincrementworldclientfield(str_field_name);
      continue;
    }

    assert(isDefined(level.var_58bc5d04));

    if(isDefined(self.birthtime) && self.birthtime >= level.var_58bc5d04) {
      util::wait_network_frame();
    }

    if(self.birthtime === gettime()) {
      util::wait_network_frame();
    }

    if(isDefined(self)) {
      if(self.birthtime === gettime()) {
        continue;
      }

      codeincrementclientfield(self, str_field_name);
    }
  }
}

function increment_uimodel(str_field_name, n_increment_count = 1) {
  if(self == level) {
    foreach(player in level.players) {
      for(i = 0; i < n_increment_count; i++) {
        codeincrementuimodelclientfield(player, str_field_name);
      }
    }

    return;
  }

  for(i = 0; i < n_increment_count; i++) {
    codeincrementuimodelclientfield(self, str_field_name);
  }
}

function increment_to_player(str_field_name, n_increment_count = 1) {
  for(i = 0; i < n_increment_count; i++) {
    codeincrementplayerstateclientfield(self, str_field_name);
  }
}

function get(str_field_name) {
  if(self == level) {
    return codegetworldclientfield(str_field_name);
  }

  return codegetclientfield(self, str_field_name);
}

function get_to_player(field_name) {
  return codegetplayerstateclientfield(self, field_name);
}