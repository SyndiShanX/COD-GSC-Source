/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\hostmigration.gsc
***********************************************/

hostmigration_waitlongdurationwithpause(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_96940E34BDCDA3B55AEC9C583A5ABDDC", "_encstr_88A41A9B8FFFDC1DBA88B1854B25CAC3F89F353FB4339A1B7FFF7BB8"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_96940E34BDCDA3B55AEC9C583A5ABDDC", "_encstr_88A41A9B8FFFDC1DBA88B1854B25CAC3F89F353FB4339A1B7FFF7BB8")]](var_0);
  else
    wait(var_0);
}

hostmigration_waittillnotifyortimeoutpause(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_96940E34BDCDA3B55AEC9C583A5ABDDC", "_encstr_B1BA1DD3A7AAFBAB631250B01F2BE054F88496E1DF9A5D3833CD7799A32E27"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_96940E34BDCDA3B55AEC9C583A5ABDDC", "_encstr_B1BA1DD3A7AAFBAB631250B01F2BE054F88496E1DF9A5D3833CD7799A32E27")]](var_0, var_1);
  else
    scripts\engine\utility::_id_143B9(var_1, var_0);
}