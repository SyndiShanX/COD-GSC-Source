/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\emp_debuff_mp.gsc
***********************************************/

#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\utility;
#using scripts\mp\emp_debuff_mp;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\perk;
#namespace emp_debuff_mp;

function emp_debuff_init() {
  registersharedfunc("emp", "getPlayerEMPImmune", &getplayerempimmune);
  registersharedfunc("emp", "setPlayerEMPImmune", &setplayerempimmune);
  registersharedfunc("emp", "onPlayerEMPed", &onplayeremped);
  registersharedfunc("emp", "onVehicleEMPed", &onvehicleemped);
}

function getplayerempimmune() {
  return _hasperk("specialty_empimmune");
}

function setplayerempimmune(isimmune) {
  if(isimmune) {
    giveperk("specialty_empimmune");
    return;
  }

  removeperk("specialty_empimmune");
}

function onplayeremped(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, attacker))) {
    attacker thread scripts\mp\killstreaks\killstreaks::givescoreforempedplayer();
  }
}

function onvehicleemped(data) {
  attacker = data.attacker;

  if(isDefined(self.turrets) && self.turrets.size > 0) {
    scripts\mp\emp_debuff_mp::function_a3a4d32a799e95d5(data);
  }

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker scripts\mp\killstreaks\killstreaks::givescoreforempedvehicle();
    return;
  }

  if(scripts\cp_mp\vehicles\vehicle::isbossvehicle()) {
    attacker scripts\mp\killstreaks\killstreaks::givescoreforempedvehicle();
  }
}

function function_a3a4d32a799e95d5(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker scripts\mp\killstreaks\killstreaks::function_7d84b8c1b826b7ea();
  }
}