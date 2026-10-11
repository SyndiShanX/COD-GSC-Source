/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_22e5ad6fd19f0770.gsc
*************************************************/

#using script_3b78d23dad7ec5be;
#using script_405d05c89e998922;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace zombie_base_knockdown;

function function_976734974e28596e() {
  callback::get_template(self.animsetname) callback::add("on_zombie_ai_damaged", &on_damaged);
  callback::get_template(self.animsetname) callback::add("on_is_crawling_changed", &on_is_crawling_changed);
}

function init_knockdown() {
  self.knockdowndamagethreshold = self.health * 0.01;
}

function private on_damaged(params) {
  if(isexplosivedamagemod(params.smeansofdeath) && (!isDefined(params.einflictor) || !istrue(params.einflictor.prevent_knockdown)) && !function_aa75c57142022473(params.sweapon)) {
    if(params.idamage > self.knockdowndamagethreshold) {
      if(!function_e67a89537ae7d4b7()) {
        knockdown_ai(params.vpoint);
      }
    }
  }

  return params.idamage;
}

function private on_is_crawling_changed(params) {
  val::set("is_crawling", "disallow_knockdown", namespace_9e6ef02d993a7eba::is_crawling());
}

function private function_aa75c57142022473(weapon_object) {
  if(isDefined(weapon_object) && isDefined(weapon_object.basename) && isDefined(level.var_c16493593d07b88f) && array_contains(level.var_c16493593d07b88f, weapon_object.basename)) {
    return true;
  }

  return false;
}