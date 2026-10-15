/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\demo_shared.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\filter_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace demo;

autoexec __init__system__() {
  system::register(#"demo", &__init__, undefined, undefined);
}

__init__() {
  if(!isdemoplaying()) {
    return;
  }
}