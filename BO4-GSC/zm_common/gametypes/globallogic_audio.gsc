/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_audio.gsc
*****************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\gametypes\globallogic_utils;
#include scripts\zm_common\util;

#namespace globallogic_audio;

autoexec __init__system__() {
  system::register(#"globallogic_audio", &__init__, undefined, undefined);
}

__init__() {}