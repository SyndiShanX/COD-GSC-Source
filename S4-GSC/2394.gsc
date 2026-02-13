/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2394.gsc
*************************************************/

_id_60B3() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game_utility", "getTimeSinceGameStart", ::_id_60B2);
}

_id_60B2() {
  return gettime() - level._id_E72D;
}