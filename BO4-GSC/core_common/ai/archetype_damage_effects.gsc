/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_damage_effects.gsc
*******************************************************/

#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;

#namespace archetype_damage_effects;

autoexec main() {
  clientfield::register("actor", "arch_actor_fire_fx", 1, 2, "int");
  clientfield::register("actor", "arch_actor_char", 1, 2, "int");
  callback::on_actor_damage(&onactordamagecallback);
  callback::on_actor_killed(&onactorkilledcallback);
}

onactordamagecallback(params) {
  onactordamage(params);
}

onactorkilledcallback(params) {
  onactorkilled();
}

private function_6fedb40d() {
  self endon(#"death");

  if(isDefined(self.var_73c36602) && self.var_73c36602) {
    return;
  }

  self clientfield::set("arch_actor_fire_fx", 1);
  self.var_73c36602 = 1;
  wait isDefined(self.var_ab2486b4 / 1000) ? self.var_ab2486b4 / 1000 : 3;
  self clientfield::set("arch_actor_fire_fx", 0);
  self.var_73c36602 = 0;
}

private function_6eb1fbde() {
  if(self.var_40543c03 === "fire") {
    self thread function_6fedb40d();
  }
}

onactordamage(params) {
  self.var_40543c03 = undefined;
  self.var_ab2486b4 = 0;

  if(isDefined(params.weapon) && isDefined(params.weapon.var_8456d4d)) {
    var_8d93b9c8 = aiutility::function_e2010f4c(self, getscriptbundle(params.weapon.var_8456d4d));

    if(isDefined(var_8d93b9c8)) {
      self.var_40543c03 = var_8d93b9c8.effecttype;

      if(!isDefined(var_8d93b9c8.var_4badc00f) || !var_8d93b9c8.var_4badc00f) {
        self.var_ab2486b4 = var_8d93b9c8.duration * 1000;
      }
    }

    self function_6eb1fbde();
  }
}

onactorkilled() {
  if(isDefined(self.damagemod)) {
    if(self.damagemod == "MOD_BURNED") {
      if(isDefined(self.damageweapon) && isDefined(self.damageweapon.specialpain) && self.damageweapon.specialpain == 0) {
        self clientfield::set("arch_actor_fire_fx", 2);
      }
    }
  }
}