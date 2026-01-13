/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3873.gsc
************************/

main() {
  lib_0F23::main();
}

func_F5B6(var_0, var_1, var_2) {
  if(var_0) {
    if(isDefined(var_1) && isDefined(var_2)) {
      level thread lib_0F27::func_10ED8(var_1, var_2);
    }

    level thread lib_0F26::func_117D3(1);
    foreach(var_4 in level.players) {
      var_4 thread lib_0F24::main();
      var_4 thread lib_0F25::func_11408();
      var_4 thread lib_0F24::func_1DD3();
    }

    return;
  }

  level thread lib_0F27::func_10EDA();
  level thread lib_0F26::func_117D3(0);
  foreach(var_4 in level.players) {
    var_4 thread lib_0F25::func_11407();
    var_4 thread lib_0F24::func_1DD2();
  }
}