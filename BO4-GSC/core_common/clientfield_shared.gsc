/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\clientfield_shared.gsc
***********************************************/

#include scripts\core_common\util_shared;

#namespace clientfield;

register(str_pool_name, str_name, n_version, n_bits, str_type) {
  registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type);
}

register_clientuimodel(str_name, n_version, n_bits, str_type, var_59f69872) {
  registerclientfield("clientuimodel", str_name, n_version, n_bits, str_type, var_59f69872);
}

register_luielem(unique_name, field_name, n_version, n_bits, str_type, var_59f69872) {
  registerclientfield("clientuimodel", "luielement." + unique_name + "." + field_name, n_version, n_bits, str_type, var_59f69872);
}

register_bgcache(poolname, var_b693fec6, uniqueid, version, var_59f69872) {
  function_3ff577e6(poolname, var_b693fec6, uniqueid, version, var_59f69872);
}

set(str_field_name, n_value) {
  if(!isDefined(str_field_name)) {
    assertmsg("<dev string:x38>");
    return;
  }

  if(self == level) {
    codesetworldclientfield(str_field_name, n_value);
    return;
  }

  codesetclientfield(self, str_field_name, n_value);
}

can_set(str_field_name, n_value) {
  return function_26b3a620();
}

set_to_player(str_field_name, n_value) {
  assert(isplayer(self), "<dev string:x77>");

  if(isplayer(self)) {
    codesetplayerstateclientfield(self, str_field_name, n_value);
  }
}

set_player_uimodel(str_field_name, n_value) {
  codesetuimodelclientfield(self, str_field_name, n_value);
}

function_9bf78ef8(unique_name, str_field_name, n_value) {
  codesetuimodelclientfield(self, "luielement." + unique_name + "." + str_field_name, n_value);
}

function_bb878fc3(unique_name, str_field_name) {
  codeincrementuimodelclientfield(self, "luielement." + unique_name + "." + str_field_name);
}

get_player_uimodel(str_field_name) {
  return codegetuimodelclientfield(self, str_field_name);
}

function_f7ae6994(unique_name, str_field_name) {
  return codegetuimodelclientfield(self, "luielement." + unique_name + "." + str_field_name);
}

set_world_uimodel(str_field_name, n_value) {
  codesetworlduimodelfield(str_field_name, n_value);
}

get_world_uimodel(str_field_name) {
  return codegetworlduimodelfield(str_field_name);
}

increment_world_uimodel(str_field_name) {
  return codeincrementworlduimodelfield(str_field_name);
}

increment(str_field_name, n_increment_count) {
  self thread _increment(str_field_name, n_increment_count);
}

private _increment(str_field_name, n_increment_count = 1) {
  if(self != level) {
    self endon(#"death");
  }

  for(i = 0; i < n_increment_count; i++) {
    if(self == level) {
      codeincrementworldclientfield(str_field_name);
      continue;
    }

    waittillframeend();

    if(isDefined(self.birthtime) && self.birthtime >= level.var_58bc5d04) {
      util::wait_network_frame();
    }

    codeincrementclientfield(self, str_field_name);
  }
}

increment_uimodel(str_field_name, n_increment_count = 1) {
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

increment_to_player(str_field_name, n_increment_count = 1) {
  for(i = 0; i < n_increment_count; i++) {
    codeincrementplayerstateclientfield(self, str_field_name);
  }
}

get(str_field_name) {
  if(self == level) {
    return codegetworldclientfield(str_field_name);
  }

  return codegetclientfield(self, str_field_name);
}

get_to_player(field_name) {
  return codegetplayerstateclientfield(self, field_name);
}