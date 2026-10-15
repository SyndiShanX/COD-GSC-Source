/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\ballistic_knife.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\weapons\ballistic_knife;
#include scripts\weapons\weaponobjects;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_player;

#namespace ballistic_knife;

autoexec __init__system__() {
  system::register(#"ballistic_knife", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}