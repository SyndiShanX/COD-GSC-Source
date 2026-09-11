/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gestures_mp.gsc
***********************************************/

function init_mp() {
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&scripts\cp_mp\gestures::watchradialgestureactivation);
}