/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\war.gsc
***********************************************/

#using script_4acb48c9cb82bb51;
#namespace war;

function event_handler[gametype_init] main(eventstruct) {
  namespace_d03f485e::function_dc5b7ee6();
  level.onstartgametype = &onstartgametype;
}

function onstartgametype() {
  namespace_d03f485e::function_1804ad1c();
}