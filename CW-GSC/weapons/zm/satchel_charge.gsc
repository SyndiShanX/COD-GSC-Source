/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\zm\satchel_charge.gsc
***********************************************/

#using script_4dc6a9b234b838e1;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\satchel_charge;
#using scripts\zm_common\zm_weapons;
#namespace satchel_charge;

function private autoexec __init__system__() {
  system::register(#"satchel_charge", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
  namespace_cc411409::preinit();
  callback::add_callback(#"on_ai_killed", &function_7c8d1738);
  zm_weapons::function_404c3ad5(getweapon(#"satchel_charge"), &function_558ac85a);
}

function function_558ac85a(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
  if(isentity(surfacetype) && isPlayer(vsurfacenormal) && self.zm_ai_category === # "normal") {
    self.var_8efbca7e = surfacetype.origin;
  }
}

function function_7c8d1738(params) {
  if(params.weapon.name === # "satchel_charge" && isPlayer(params.eattacker) && self.zm_ai_category === # "normal" && isvec(self.var_8efbca7e)) {
    self namespace_cc411409::ragdoll_launch(self.var_8efbca7e, 2);
    self thread function_3fb4ce3b();
  }
}

function function_3fb4ce3b() {
  util::wait_network_frame();

  if(isDefined(self)) {
    self zombie_utility::gib_random_parts();
  }
}