/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\killcam_shared.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace killcam;

autoexec __init__system__() {
  system::register(#"killcam", &__init__, undefined, undefined);
}

__init__() {}