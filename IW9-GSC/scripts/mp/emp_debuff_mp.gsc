/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\emp_debuff_mp.gsc
***********************************************/

emp_debuff_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "getPlayerEMPImmune", ::getplayerempimmune);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "setPlayerEMPImmune", ::setplayerempimmune);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "onPlayerEMPed", ::onplayeremped);
  scripts\cp_mp\utility\script_utility::registersharedfunc("emp", "onVehicleEMPed", ::onvehicleemped);
}

getplayerempimmune() {
  return scripts\mp\utility\perk::_hasperk("specialty_empimmune");
}

setplayerempimmune(_id_780166328E815D00) {
  if(_id_780166328E815D00)
    scripts\mp\utility\perk::giveperk("specialty_empimmune");
  else
    scripts\mp\utility\perk::removeperk("specialty_empimmune");
}

onplayeremped(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, attacker)))
    attacker thread scripts\mp\killstreaks\killstreaks::givescoreforempedplayer();
}

onvehicleemped(data) {
  attacker = data.attacker;

  if(isDefined(self.turrets) && self.turrets.size > 0)
    _id_A3A4D32A799E95D5(data);

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)))
    attacker scripts\mp\killstreaks\killstreaks::givescoreforempedvehicle();
  else if(scripts\cp_mp\vehicles\vehicle::_id_62CCFB7EA15A4520())
    attacker scripts\mp\killstreaks\killstreaks::givescoreforempedvehicle();
}

_id_A3A4D32A799E95D5(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)))
    attacker scripts\mp\killstreaks\killstreaks::_id_7D84B8C1B826B7EA();
}