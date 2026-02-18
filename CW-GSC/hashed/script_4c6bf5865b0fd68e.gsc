/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4c6bf5865b0fd68e.gsc
***********************************************/

#using script_4dc6a9b234b838e1;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace namespace_5a359049;

function private autoexec __init__system__() {
  system::register(#"hash_695bd4a240716800", &preinit, &postinit, undefined, #"zm_weapons");
}

function private preinit() {
  level.var_1b5a1f0d = &zm_utility::is_point_inside_enabled_zone;
  level.var_3da1a113 = # "hash_733eecf99198ecb9";
  level.weaponzmcymbalmonkey = getweapon(#"cymbal_monkey");
  zm_loadout::register_lethal_grenade_for_level(#"cymbal_monkey");
  zm_weapons::function_404c3ad5(level.weaponzmcymbalmonkey, &function_c1c47eb6);
  callback::add_callback(#"on_ai_killed", &function_c58f9108);
  namespace_cc411409::preinit();
}

function private postinit() {
  if(!cymbal_monkey_exists()) {
    return;
  }

  if(is_true(level.legacy_cymbal_monkey)) {
    level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
    return;
  }

  level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
}

function cymbal_monkey_exists() {
  return level.weaponzmcymbalmonkey != level.weaponnone;
}

function function_c1c47eb6(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
  if(isentity(surfacetype) && isPlayer(vsurfacenormal) && self.zm_ai_category === # "normal") {
    self.var_9a4dd099 = surfacetype.origin;
  }
}

function function_c58f9108(params) {
  if(params.weapon.name === # "cymbal_monkey" && isPlayer(params.eattacker) && self.zm_ai_category === # "normal" && isvec(self.var_9a4dd099)) {
    self namespace_cc411409::ragdoll_launch(self.var_9a4dd099, 2);
    self thread function_3fb4ce3b();
  }
}

function function_3fb4ce3b() {
  util::wait_network_frame();

  if(isDefined(self)) {
    self zombie_utility::gib_random_parts();
  }
}