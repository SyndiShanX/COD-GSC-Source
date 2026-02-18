/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1d0c00a6b81556a2.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#namespace namespace_543dc48f;

function private autoexec __init__system__() {
  system::register(#"hash_2e174447c1bc5bd6", &preinit, undefined, undefined, #"zm_weapons");
}

function private preinit() {
  level.var_5714f442 = 25;
  level.var_a77fcfbe = &function_dafd9cd;
  callback::on_connect(&on_connect);
}

function private on_connect() {
  callback::function_d8abfc3d(#"hash_4b807b1167b4a811", &function_c5b14b2f);
}

function private function_c5b14b2f() {
  callback::function_d8abfc3d(#"done_healing", &function_afade0d0);
  self.var_f7500d42 = self.health;
  self.ignore_health_regen_delay = 1;
}

function private function_afade0d0() {
  callback::function_52ac9652(#"done_healing", &function_afade0d0);

  if(isDefined(self.var_f7500d42)) {
    self.var_c2b7641c = self.health - self.var_f7500d42;
    self notify(#"hash_18e59631bf777496", {
      #heal_amount: self.var_c2b7641c
    });
  }

  self.ignore_health_regen_delay = 0;
}

function function_dafd9cd(attacker, damage) {
  if(gettime() < self.heal.var_a1cac2f1) {
    return false;
  }

  if(!is_true(self.heal.var_f0f1ff36) && damage < getdvarfloat(#"hash_3671f84e911fb747", isDefined(level.var_5714f442) ? level.var_5714f442 : 0)) {
    return false;
  }

  if(isDefined(level.deathcircle) && level.deathcircle === attacker) {
    return false;
  }

  return true;
}