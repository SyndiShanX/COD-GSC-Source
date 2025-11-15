/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\mp\abilities.gsc
***********************************************/

#include scripts\abilities\ability_gadgets;
#include scripts\abilities\ability_player;
#include scripts\abilities\ability_power;
#include scripts\abilities\ability_util;
#include scripts\core_common\array_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;

#namespace abilities;

autoexec __init__system__() {
  system::register(#"abilities", &__init__, undefined, undefined);
}

__init__() {}