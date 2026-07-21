/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gestures_mp.gsc
***********************************************/

init_mp() {
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(scripts\cp_mp\gestures::watchradialgestureactivation);
}