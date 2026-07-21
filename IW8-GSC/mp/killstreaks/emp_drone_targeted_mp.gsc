/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\emp_drone_targeted_mp.gsc
****************************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AAD211CADA1C8839B79BCA1558E4D9953A5932", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB", ::emp_drone_targeted_getmapselectpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AAD211CADA1C8839B79BCA1558E4D9953A5932", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656", ::emp_drone_targeted_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AAD211CADA1C8839B79BCA1558E4D9953A5932", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56", ::emp_drone_targeted_monitordamage);
}

emp_drone_targeted_getmapselectpoint(var_0, var_1, var_2) {
  return scripts\mp\killstreaks\mapselect::getselectmappoint(var_0, var_1, var_2);
}

emp_drone_targeted_startmapselectsequence(var_0, var_1, var_2, var_3) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence(var_0, var_1, var_2, var_3);
}

emp_drone_targeted_monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  scripts\mp\damage::monitordamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}