/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2638.gsc
*************************************************/

_id_831B() {
  setDvar("#x37ee6f641b2f5ab8f", 1300);
  setDvar("#x32b60c67f16ea9eee", 16000);
  scripts\mp\killstreaks\killstreaks::_id_C26A("intel", _id_09B7::_id_F78C);
  game["dialog"]["intel_loop"] = "mp_glob_kill_bchr_inlo";
  game["dialog"]["intel_time"] = "mp_glob_kill_bchr_into";
}