/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\osdm.gsc
***********************************************/

#include scripts\mp_common\gametypes\dm;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\os;

#namespace osdm;

event_handler[gametype_init] main(eventstruct) {
  dm::main();
  os::turn_back_time("dm");
  globallogic_audio::set_leader_gametype_dialog("osStartFfa", "", "gameBoost", "gameBoost");
}