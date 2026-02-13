/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1995.gsc
*************************************************/

_id_5181() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "getPlayerEMPImmune", ::_id_6C4B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "setPlayerEMPImmune", ::_id_D660);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "onPlayerEMPed", ::_id_AB66);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "onVehicleEMPed", ::_id_ABD6);
}

_id_6C4B() {
  return scripts\mp\utility\perk::_hasperk("specialty_empimmune");
}

_id_D660(var_0) {
  if(var_0) {
    scripts\mp\utility\perk::_id_6FC2("specialty_empimmune");
  } else {
    scripts\mp\utility\perk::removeperk("specialty_empimmune");
  }
}

_id_AB66(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self, var_1))) {
    var_1 thread scripts\mp\killstreaks\killstreaks::_id_6FE8();
  }
}

_id_ABD6(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1))) {
    var_1 scripts\mp\killstreaks\killstreaks::_id_6FE9();
  }
}