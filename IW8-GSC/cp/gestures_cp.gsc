/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\gestures_cp.gsc
***********************************************/

init_cp() {
  scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback(scripts\cp_mp\gestures::watchradialgestureactivation);
}