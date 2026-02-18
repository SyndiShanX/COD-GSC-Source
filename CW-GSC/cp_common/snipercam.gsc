/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\snipercam.gsc
***********************************************/

#using script_27ef3076a14eb66a;
#using script_35ae72be7b4fec10;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\hint_tutorial;
#namespace snipercam;

function private autoexec __init__system__() {
  system::register("snipercam", &function_f64316de, undefined, undefined, undefined);
}

function set_enabled(enabled, on_damage = 0, var_895878e1 = 3) {
  assert(isactor(self));

  if(is_true(enabled)) {
    self.var_ca3bd64e = var_895878e1;
    self.var_fa99a047 = on_damage;
    self thread function_b5597fc3();
    return;
  }

  aiutility::removeaioverridedamagecallback(self, &function_4ad903f4);
}

function function_5d276f5b(var_895878e1, victim) {
  player = getplayers()[0];
  victim.var_ca3bd64e = var_895878e1;
  victim thread function_856a28c3(0, player);
}

function private function_f64316de() {
  clientfield::register("actor", "start_snipercam", 1, 2, "int");
  clientfield::register("actor", "stop_snipercam", 1, 1, "int");
}

function private function_b5597fc3() {
  waitframe(1);
  aiutility::addaioverridedamagecallback(self, &function_4ad903f4);
}

function private function_4ad903f4(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  if(is_true(var_fd90b0bb.isbulletweapon) && (isPlayer(idamage) || isPlayer(eattacker))) {
    if(!isDefined(weapon) || weapon === "MOD_RIFLE_BULLET" || weapon === "MOD_PISTOL_BULLET") {
      mindist = 800;
      attacker = idamage;

      if(!isPlayer(attacker)) {
        attacker = eattacker;
      }

      if(isDefined(self.var_8a3fb9e2)) {
        mindist = self.var_8a3fb9e2;
      }

      if(distancesquared(self.origin, attacker.origin) > sqr(mindist)) {
        if(self.var_fa99a047 || !self.var_fa99a047 && self.health - idflags <= 0) {
          var_afe2c3af = !is_true(self.var_fa99a047);
          self set_enabled(0);
          self thread function_856a28c3(var_afe2c3af, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
          return 0;
        }
      }
    }
  }

  return idflags;
}

function private function_856a28c3(var_afe2c3af, einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  assert(isPlayer(boneindex) || isPlayer(psoffsettime));
  self notify(#"hash_ae39942308147bf");

  if(shitloc) {
    self.var_4a438c2b = 1;
    util::magic_bullet_shield(self);
  }

  self setentitypaused(1);

  if(isPlayer(boneindex)) {
    player = boneindex;
  } else {
    player = psoffsettime;
  }

  player flag::set("snipercam");
  namespace_61e6d095::function_28027c42(#"sniper_cam");
  player val::set(#"snipercam", "freezecontrols", 1);
  player val::set(#"snipercam", "takedamage", 0);
  player val::set(#"snipercam", "show_weapon_hud", 0);
  player val::set(#"snipercam", "show_hit_marker", 0);
  player val::set(#"snipercam", "show_compass", 0);
  player val::set(#"snipercam", "show_crosshair", 0);
  hint_tutorial::function_57a24ab5(0);
  parms = function_83d35e98(player, player getEye(), player getplayerangles(), self, self.var_ca3bd64e);
  player.var_35ee6252 = undefined;
  setslowmotion(1, 0.5, 0);
  self clientfield::set("start_snipercam", self.var_ca3bd64e);
  var_b487436a = 1.3 * 0.1;
  wait parms.var_684cf08c;
  setslowmotion(0.5, 1, 0.5);
  self setentitypaused(0);
  player ghost();
  self notify(#"hash_3d799b8c342663fa");
  self clientfield::set("start_snipercam", 0);

  if(shitloc) {
    util::stop_magic_bullet_shield(self);
    self.var_4a438c2b = 0;
    self.diequietly = 1;
    self setnormalhealth(1);
    self kill(player.origin, player, player, modelindex);
  }

  wait parms.var_6051349d;
  self clientfield::set("stop_snipercam", 1);
  wait 0.1;
  self notify(#"hash_377b8997737880e7");
  hint_tutorial::function_57a24ab5(1);
  player val::reset_all(#"snipercam");
  player show();
  self clientfield::set("stop_snipercam", 0);
  player flag::clear("snipercam");
  namespace_61e6d095::function_4279fd02(#"sniper_cam");
}