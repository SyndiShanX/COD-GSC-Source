/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\serverfield_shared.csc
***********************************************/

#namespace serverfield;

register(str_name, n_version, n_bits, str_type) {
  serverfieldregister(str_name, n_version, n_bits, str_type);
}

set(str_field_name, n_value) {
  serverfieldsetval(self, str_field_name, n_value);
}

get(field_name) {
  return serverfieldgetvalue(self, field_name);
}