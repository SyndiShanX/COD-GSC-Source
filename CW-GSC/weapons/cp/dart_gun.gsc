/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\cp\dart_gun.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\cp_common\bb;
#namespace dart_gun;

function private autoexec __init__system__() {
  system::register("dart_gun", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_fb71a7c4 = getweapon("eq_dart_gun");
  callback::add_weapon_damage(level.var_fb71a7c4, &function_bc51baa3);
}

function private function_bc51baa3(eattacker, einflictor, weapon, meansofdeath, damage) {
  if(is_true(self.is_hero)) {
    return;
  }

  self notify(#"dart_gunned");

  if(isPlayer(damage)) {
    bb::function_cd497743("dart_gunned", damage);
  }

  self endon(#"death");

  if(isDefined(self.var_66f1a336)) {
    self thread[[self.var_66f1a336]]();
    return;
  }

  self startragdoll();
  wait 1;
  self kill();
}

function function_adcf633a(callback) {
  self.var_66f1a336 = callback;
}