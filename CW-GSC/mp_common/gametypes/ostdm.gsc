/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ostdm.gsc
***********************************************/

#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\mp_common\gametypes\os;
#using scripts\mp_common\gametypes\tdm;
#namespace ostdm;

function event_handler[gametype_init] main(eventstruct) {
  tdm::main();
  os::turn_back_time("tdm");
  globallogic_audio::set_leader_gametype_dialog("osStartTdm", "", "gameBoost", "gameBoost");
}