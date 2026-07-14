/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_554830d27078277d.gsc
*****************************************************/

#using script_5a4a5d9ba343ff8f;
#namespace effect_charm;

function charm(durations, attacker, end_callback, element_type, setmaxhealth = 1) {
  if(!istrue(self.aisettings.var_52aeae4ce0fe943b)) {
    return 0;
  }

  if(status_effects::function_49f84c53a7f39086("Kz21\xc7")) {
    return 0;
  }

  assert(isDefined(attacker.team));
  charm_effect = status_effects::function_1c3c4f0aa9a6109a("Kz21\xc7", durations, undefined, &start_charm, &end_charm, element_type);
  charm_effect.original_team = self.team;
  charm_effect.attacker = attacker;
  charm_effect.new_team = attacker.team;
  charm_effect.end_callback = end_callback;
  charm_effect.setmaxhealth = setmaxhealth;
  return status_effects::start_effect(charm_effect);
}

function private start_charm(effect) {
  if(effect.setmaxhealth) {
    self.health = self.maxhealth;
  }

  self.allowpain = 0;
  self.team = effect.new_team;
  self clearpath();
}

function private end_charm(effect) {
  self.allowpain = 1;
  self.team = effect.original_team;
  self clearpath();

  if(isDefined(effect.end_callback)) {
    self[[effect.end_callback]]();
  }
}