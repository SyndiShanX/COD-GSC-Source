/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2707.gsc
*************************************************/

_id_60B6() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("game_utility", "getTimeSinceGameStart", ::_id_60B5);
}

_id_60B5() {
  return _id_07EE::_id_6DE4(gettime());
}