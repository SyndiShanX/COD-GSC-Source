/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3010.gsc
************************/

main(param_00, param_01, param_02) {
  scripts\sp\vehicle_build::func_31C5(param_01, param_00, undefined, param_02);
  scripts\sp\vehicle_build::func_31A6(::init_location);
  scripts\sp\vehicle_build::func_31A3(90000);
  scripts\sp\vehicle_build::func_319F();
}

init_location() {
  self.var_55A4 = 1;
  self _meth_8184();
}