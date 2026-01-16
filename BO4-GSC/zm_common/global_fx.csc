/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\global_fx.csc
***********************************************/

#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace global_fx;

autoexec __init__system__() {
  system::register(#"global_fx", &__init__, &main, undefined);
}

__init__() {}

main() {
  check_for_wind_override();
}

check_for_wind_override() {
  if(isDefined(level.custom_wind_callback)) {
    level thread[[level.custom_wind_callback]]();
  }
}