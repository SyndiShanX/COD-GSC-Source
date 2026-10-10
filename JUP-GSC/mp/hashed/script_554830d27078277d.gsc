/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_554830d27078277d.gsc
*************************************************/

#using script_5a4a5d9ba343ff8f;
#using scripts\engine\utility;
#namespace namespace_eacada4b289f07a0;

function charm(durations, attacker, end_callback) {
  if(!istrue(self.aisettings.var_d9f86989ad15047e)) {
    return 0;
  }

  if(function_8ce7894f1a52fb77("charm")) {
    return 0;
  }

  assert(isDefined(attacker.team));
  var_ff12966079a5dc0 = function_108973a907c11ca7("charm", durations, undefined, &function_c32337ecb8f9a0d7, &end_charm);
  var_ff12966079a5dc0.original_team = self.team;
  var_ff12966079a5dc0.attacker = attacker;
  var_ff12966079a5dc0.new_team = attacker.team;
  var_ff12966079a5dc0.end_callback = end_callback;
  return start_effect(var_ff12966079a5dc0);
}

function private function_c32337ecb8f9a0d7(effect) {
  self.health = self.maxhealth;
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