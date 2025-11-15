/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\serverfield_shared.gsc
***********************************************/

#namespace serverfield;

register(str_name, n_version, n_bits, str_type, func_callback) {
  serverfieldregister(str_name, n_version, n_bits, str_type, func_callback);
}

get(field_name) {
  return serverfieldgetvalue(self, field_name);
}