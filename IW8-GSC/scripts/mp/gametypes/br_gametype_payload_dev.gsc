/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_payload_dev.gsc
************************************************************/

function ref_12e0a(var_0) {
  if(var_0.size == 0) {
    return;
  }

  var_1 = var_0[0];
  var_2 = scripts\mp\gamelogic::gethostplayer();

  if(var_1 == "switchSides") {
    scripts\mp\gametypes\br_gametype_payload::ontimelimit();
    return;
  }
}