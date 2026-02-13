/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1826.gsc
*************************************************/

is_destroyed() {
  return self _meth_8883();
}

close_all_doors() {
  var_0 = _func_03C0(undefined, undefined, undefined, undefined, "door");

  foreach(var_2 in var_0) {
    if(!var_2 _meth_8728() && !var_2 is_destroyed()) {
      var_2 _meth_873D();
    }
  }
}