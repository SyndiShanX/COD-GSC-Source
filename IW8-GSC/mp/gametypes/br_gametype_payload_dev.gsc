/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_payload_dev.gsc
****************************************************/

_id_12E0A(var_0) {
  if(var_0.size == 0) {
    return;
  }
  var_1 = var_0[0];
  var_2 = scripts\mp\gamelogic::gethostplayer();

  if(var_1 == "_encstr_B29E0C332BFF6D48541B93F155FA")
    _encstr_8C912D2646BB4B9BE447FA10B347B193926F1DAB1AA20728DA6B7148DF2D89E17BD21D20725ADB888F3FB01ADF6B81::ontimelimit();
}