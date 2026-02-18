/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_f38dc50f0e82277.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace doa_banner;

function init() {
  clientfield::register("world", "banner_event", 1, 6, "int");
  clientfield::register("world", "banner_eventplayer", 1, 6, "int");
}

function function_7a0e5387(event = 63) {
  level clientfield::set("banner_event", 0);
  util::wait_network_frame();
  level clientfield::set("banner_event", event);
}