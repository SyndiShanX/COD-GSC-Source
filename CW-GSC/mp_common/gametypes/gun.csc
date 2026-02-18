/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\gun.csc
***********************************************/

#using scripts\core_common\audio_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace gun;

function autoexec ignore_systems() {
  if(util::get_game_type() === # "gun_rambo") {
    system::ignore(#"killstreaks");
  }
}

function event_handler[gametype_init] main(eventstruct) {
  level.isgungame = 1;
  setDvar(#"hash_137c8b2b96ac6c72", 0.2);
  setDvar(#"compassradarpingfadetime", 0.75);

  if(util::get_game_type() === # "gun_rambo") {
    function_11e3e877(#"surface_enter", #"hash_8d0717b4d7850b6");
    function_11e3e877(#"hash_6be5853fe57d01b0", #"hash_8d0717b4d7850b6");
    function_11e3e877(#"hash_6251d9bc015e4542", #"hash_8d0717b4d7850b6");
    function_11e3e877(#"hash_6a2ccf46147cb7d8", #"hash_8d0717b4d7850b6");
    level.var_87c6c648 = 1;
    setsoundcontext("ltm", "gungame");
  }
}