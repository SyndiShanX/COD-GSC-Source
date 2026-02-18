/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_36007695115089d9.gsc
***********************************************/

#using script_1304295570304027;
#using script_5495f0bb06045dc7;
#using script_b9a55edd207e4ca;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace namespace_cf48051e;

function private autoexec __init__system__() {
  system::register(#"hash_112a74f076cda31", &function_62730899, undefined, undefined, #"territory");
}

function event_handler[gametype_init] main(eventstruct) {
  namespace_2938acdc::init();
  namespace_5c32f369::init();
  level.onstartgametype = &on_start_game_type;
  level.var_61d4f517 = 0;
}

function on_start_game_type() {
  namespace_17baa64d::on_start_game_type();
  namespace_5c32f369::onstartgametype();
}

function private function_62730899() {
  if(isDefined(level.territory) && level.territory.name != "zoo") {
    namespace_2938acdc::function_4212369d();
  }
}