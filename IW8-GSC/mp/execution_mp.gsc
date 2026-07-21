/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\execution_mp.gsc
***********************************************/

execution_mp_init() {
  if(!scripts\mp\utility\game::runleanthreadmode())
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(scripts\cp_mp\execution::execution_blockladders);
}