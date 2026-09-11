/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\emp_debuff_mp.gsc
***********************************************/

function emp_debuff_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "getPlayerEMPImmune", &getplayerempimmune);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "setPlayerEMPImmune", &setplayerempimmune);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "onPlayerEMPed", &onplayeremped);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "onVehicleEMPed", &onvehicleemped);
}

function getplayerempimmune() {
  return scripts\mp\utility\perk::_hasperk("specialty_empimmune");
}

function setplayerempimmune(var0) {
  if(var0) {
    scripts\mp\utility\perk::giveperk("specialty_empimmune");
    return;
  }

  scripts\mp\utility\perk::removeperk("specialty_empimmune");
}

function onplayeremped(var0) {
  var1 = var0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, var1))) {
    var1 thread scripts\mp\killstreaks\killstreaks::givescoreforempedplayer();
    return;
  }
}

function onvehicleemped(var0) {
  var1 = var0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1))) {
    var1 scripts\mp\killstreaks\killstreaks::givescoreforempedvehicle();
    return;
  }
}