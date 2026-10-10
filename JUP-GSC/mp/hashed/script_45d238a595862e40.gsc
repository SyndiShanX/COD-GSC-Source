/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_45d238a595862e40.gsc
*************************************************/

#namespace namespace_68d062fad885eeb3;

function function_2fce2f81588a2462() {
  if(!isDefined(level.var_bf8aa3f39f981625)) {
    level.var_bf8aa3f39f981625 = [];
  }

  level.var_bf8aa3f39f981625[level.var_bf8aa3f39f981625.size] = &function_56bc2530b5374d3e;
}

function function_56bc2530b5374d3e() {
  assert(isai(self));
  assert(isDefined(self.damage_functions));
  self.damage_functions[self.damage_functions.size] = &function_4142a252055b545a;
}

function private function_4142a252055b545a(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon) {
  if(!isalive(self)) {
    return;
  }

  if(juggernaut_isspecialweapon()) {
    return;
  }

  if(self.damageweapon.basename == "iw8_pi_decho") {
    if(partname == "j_head" || partname == "j_neck" || partname == "j_helmet") {
      heal_amount = 70;
    } else {
      heal_amount = 40;
    }
  } else {
    heal_amount = 40;
  }

  if(damage < heal_amount) {
    heal_amount = max(0, damage - 5);
  }

  self.health += int(heal_amount);
}

function private juggernaut_isspecialweapon() {
  return self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_EXPLOSIVE" || self.damagemod == "MOD_GRENADE_SPLASH" || self.damagemod == "MOD_PROJECTILE_SPLASH" || self.damageweapon.classname == "sniper" || self.damageweapon.classname == "pistol" && self.damageweapon.basename != "iw8_pi_decho" && self.damagemod != "MOD_MELEE";
}