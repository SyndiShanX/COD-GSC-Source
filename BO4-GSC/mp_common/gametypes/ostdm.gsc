/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ostdm.gsc
***********************************************/

#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\os;
#include scripts\mp_common\gametypes\tdm;

#namespace ostdm;

event_handler[gametype_init] main(eventstruct) {
  tdm::main();
  os::turn_back_time("tdm");
  globallogic_audio::set_leader_gametype_dialog("osStartTdm", "", "gameBoost", "gameBoost");
}