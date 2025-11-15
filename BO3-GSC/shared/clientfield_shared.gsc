/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\clientfield_shared.gsc
*************************************************/

#namespace clientfield;

function register(str_pool_name, str_name, n_version, n_bits, str_type) {
  registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type);
}

function set(str_field_name, n_value) {
  if(self == level) {
    codesetworldclientfield(str_field_name, n_value);
  } else {
    codesetclientfield(self, str_field_name, n_value);
  }
}

function set_to_player(str_field_name, n_value) {
  codesetplayerstateclientfield(self, str_field_name, n_value);
}

function set_player_uimodel(str_field_name, n_value) {
  if(!isentity(self)) {
    return;
  }
  codesetuimodelclientfield(self, str_field_name, n_value);
}

function get_player_uimodel(str_field_name) {
  return codegetuimodelclientfield(self, str_field_name);
}

function increment(str_field_name, n_increment_count = 1) {
  for(i = 0; i < n_increment_count; i++) {
    if(self == level) {
      codeincrementworldclientfield(str_field_name);
      continue;
    }
    codeincrementclientfield(self, str_field_name);
  }
}

function increment_uimodel(str_field_name, n_increment_count = 1) {
  if(self == level) {
    foreach(player in level.players) {
      for(i = 0; i < n_increment_count; i++) {
        codeincrementuimodelclientfield(player, str_field_name);
      }
    }
  } else {
    for(i = 0; i < n_increment_count; i++) {
      codeincrementuimodelclientfield(self, str_field_name);
    }
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