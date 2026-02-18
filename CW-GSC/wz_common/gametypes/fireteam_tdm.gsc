/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\gametypes\fireteam_tdm.gsc
************************************************/

#using script_335d0650ed05d36d;
#using script_b9a55edd207e4ca;
#using scripts\core_common\death_circle;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace fireteam_tdm;

function private autoexec __init__system__() {
  system::register(#"hash_112a74f076cda31", &function_62730899, undefined, undefined, #"territory");
}

function event_handler[gametype_init] main(eventstruct) {
  namespace_2938acdc::init();
  spawning::addsupportedspawnpointtype("tdm");
  level.var_61d4f517 = 1;
}

function private function_62730899() {
  if(getdvarint(#"hash_2609d7ba41b379e3", 0)) {
    return;
  }

  if(isDefined(level.territory) && level.territory.name != "zoo") {
    namespace_2938acdc::function_4212369d();
  }
}