/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5ebb184428fa24ca.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\damage;
#namespace namespace_40ededfb94637443;

function private autoexec __init__system__() {
  system::register(#"hash_ffcb29c8a69d46af", #"ww_raygun", &pre_main, undefined);
}

function private pre_main() {
  utility::registersharedfunc("ww_raygun", "init", &init);
}

function private init() {
  level thread function_7094e41874b50667();
}

function private function_7094e41874b50667() {
  if(!isDefined(level.var_664eba510919348e)) {
    level.var_664eba510919348e = [];
  }

  level.var_664eba510919348e["jup_pi_raygun"] = &function_f2ce93122d83a204;

  if(!isDefined(level.var_58ffe6a7ac9f8fd4)) {
    level.var_58ffe6a7ac9f8fd4 = [];
  }

  level.var_58ffe6a7ac9f8fd4["jup_pi_raygun" + "_mp"] = getdvarint(@ "hash_cb0f8a3f509d0e3c", 0);
}

function private function_f2ce93122d83a204(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_be4285b26ed99ab1) {
  if(getdvarint(@ "hash_b846de437d41a8ef", 1)) {
    if(smeansofdeath == "MOD_PROJECTILE_SPLASH") {
      var_673ae434262aaa44 = victim == eattacker;
      splash_scalar = 1;

      if(getdvarint(@ "hash_4b9a04cf1bb4c1f2", 0)) {
        damagetoownerscalar = var_673ae434262aaa44 ? 0.75 : 1;
        splash_scalar = idamage / 1500 * damagetoownerscalar;
      }

      idamage = var_673ae434262aaa44 ? getdvarint(@ "hash_dbaf380170608765", 50) : getdvarint(@ "hash_7baa22b2c2382c66", 150);
      idamage = int(idamage * splash_scalar);
    } else if(smeansofdeath == "MOD_PROJECTILE") {
      idamage = getdvarint(@ "hash_90703bd9bb1c3416", 200);
    }

    if(getdvarint(@ "hash_4b22b44288d88f32", 0)) {
      idamage = damage::function_49f3d4de0e352093(einflictor, eattacker, victim, objweapon, smeansofdeath, idamage, var_be4285b26ed99ab1, shitloc);
    }

    scalar = armor::function_3768b225bd3bcf44();

    if(scalar > 1) {
      idamage /= scalar;
      idamage = int(ceil(idamage));
    }
  }

  return idamage;
}