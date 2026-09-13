/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gestures_mp.gsc
***********************************************/

init_mp() {
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(scripts\cp_mp\gestures::watchradialgestureactivation);
  scripts\common\notetrack::_id_011F8C6D6F5BA948();
}