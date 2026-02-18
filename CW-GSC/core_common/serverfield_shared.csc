/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\serverfield_shared.csc
***********************************************/

#namespace serverfield;

function register(str_name, n_version, n_bits, str_type) {
  serverfieldregister(str_name, n_version, n_bits, str_type);
}

function set(str_field_name, n_value) {
  serverfieldsetval(self, str_field_name, n_value);
}

function get(field_name) {
  return serverfieldgetvalue(self, field_name);
}