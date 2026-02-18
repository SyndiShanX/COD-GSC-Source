/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\osdm.gsc
***********************************************/

#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\mp_common\gametypes\dm;
#using scripts\mp_common\gametypes\os;
#namespace osdm;

function event_handler[gametype_init] main(eventstruct) {
  dm::main();
  os::turn_back_time("dm");
  globallogic_audio::set_leader_gametype_dialog("osStartFfa", "", "gameBoost", "gameBoost");
}