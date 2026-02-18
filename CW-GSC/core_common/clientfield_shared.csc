/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\clientfield_shared.csc
***********************************************/

#namespace clientfield;

function register(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
  registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

function function_5b7d846d(str_name, var_91c404f, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
  function_c750339b("worlduimodel", str_name, var_91c404f, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

function register_clientuimodel(str_name, var_91c404f, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
  function_c750339b("clientuimodel", str_name, var_91c404f, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

function register_luielem(str_name, menu_name, var_483e93f7, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
  function_e231bfd4(str_name, menu_name, var_483e93f7, path, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

function register_bgcache(poolname, var_b693fec6, uniqueid, version, func_callback, b_host, b_callback_for_zero_when_new) {
  function_3ff577e6(poolname, var_b693fec6, uniqueid, version, func_callback, b_host, b_callback_for_zero_when_new);
}

function function_d89771ec(var_b693fec6, uniqueid, var_91c404f, path, version, func_callback, b_host, b_callback_for_zero_when_new) {
  function_bac6598a("worlduimodel", var_b693fec6, uniqueid, var_91c404f, path, version, func_callback, b_host, b_callback_for_zero_when_new);
}

function function_91cd7763(var_b693fec6, uniqueid, var_91c404f, path, version, func_callback, b_host, b_callback_for_zero_when_new) {
  function_bac6598a("clientuimodel", var_b693fec6, uniqueid, var_91c404f, path, version, func_callback, b_host, b_callback_for_zero_when_new);
}

function function_b63c5dfe(var_b693fec6, uniqueid, menu_name, var_483e93f7, path, version, func_callback, b_host, b_callback_for_zero_when_new) {
  function_9a992427(var_b693fec6, uniqueid, menu_name, var_483e93f7, path, version, func_callback, b_host, b_callback_for_zero_when_new);
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

function function_f7ae6994(unique_name, str_field_name) {
  return codegetuimodelclientfield(self, "luielement." + unique_name + "." + str_field_name);
}