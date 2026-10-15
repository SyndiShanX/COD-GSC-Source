/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\killstreaks\ultimate_turret.csc
*****************************************************/

#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\weapons\deployable;

#namespace ultimate_turret;

autoexec __init__system__() {
  system::register("ultimate_turret_wz", &__init__, undefined, undefined);
}

__init__() {
  deployable::register_deployable(getweapon("ultimate_turret"), 1);
}