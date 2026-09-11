/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_payload_dev.gsc
************************************************************/

function ref_12e0a(var0) {
  if(var0.size == 0) {
    return;
  }

  var1 = var0[0];
  var2 = scripts\mp\gamelogic::gethostplayer();

  if(var1 == "switchSides") {
    scripts\mp\gametypes\br_gametype_payload::ontimelimit();
    return;
  }
}