/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\clientfield_shared.csc
***********************************************/

#namespace clientfield;

register(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
  registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

register_luielem(unique_name, field_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
  registerclientfield("clientuimodel", "luielement." + unique_name + "." + field_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

register_bgcache(poolname, var_b693fec6, uniqueid, version, func_callback, b_host, b_callback_for_zero_when_new) {
  function_3ff577e6(poolname, var_b693fec6, uniqueid, version, func_callback, b_host, b_callback_for_zero_when_new);
}

get(field_name) {
  if(self == level) {
    return codegetworldclientfield(field_name);
  }

  return codegetclientfield(self, field_name);
}

get_to_player(field_name) {
  return codegetplayerstateclientfield(self, field_name);
}

get_player_uimodel(field_name) {
  return codegetuimodelclientfield(self, field_name);
}

function_f7ae6994(unique_name, str_field_name) {
  return codegetuimodelclientfield(self, "luielement." + unique_name + "." + str_field_name);
}