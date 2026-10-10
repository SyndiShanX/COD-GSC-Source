/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\execution_mp.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\execution;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player_frame_update_aggregator;
#namespace execution_mp;

function execution_mp_init() {
  if(!scripts\mp\utility\game::runleanthreadmode()) {
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(&execution_blockladders);
  }
}