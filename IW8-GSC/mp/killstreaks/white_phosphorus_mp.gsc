/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\white_phosphorus_mp.gsc
**************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", scripts\cp_mp\killstreaks\white_phosphorus::tryusewpfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656", ::white_phosphorus_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB", ::white_phosphorus_getmapselectpoint);
}

white_phosphorus_startmapselectsequence(var_0, var_1, var_2, var_3) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence(var_0, var_1, var_2);
}

white_phosphorus_getmapselectpoint(var_0, var_1, var_2) {
  return scripts\mp\killstreaks\mapselect::getselectmappoint(var_0, var_1, var_2);
}