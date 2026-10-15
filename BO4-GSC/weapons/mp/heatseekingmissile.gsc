/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\heatseekingmissile.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\weapons\heatseekingmissile;

#namespace heatseekingmissile;

autoexec __init__system__() {
  system::register(#"heatseekingmissile", &__init__, undefined, undefined);
}

__init__() {
  level.lockoncloserange = 330;
  level.lockoncloseradiusscaler = 3;
  init_shared();
}