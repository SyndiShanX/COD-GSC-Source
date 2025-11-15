/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\clientfield_shared.csc
*************************************************/

#namespace clientfield;

function register(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
  registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

function get(field_name) {
  if(self == level) {
    return codegetworldclientfield(field_name);
  }
  return codegetclientfield(self, field_name);
}

function get_to_player(field_name) {
  return codegetplayerstateclientfield(self, field_name);
}

function get_player_uimodel(field_name) {
  return codegetuimodelclientfield(self, field_name);
}