/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_484637acebd73e87.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\weapons\lightning_chain;
#using scripts\cp_mp\weapons\ww_dg2;
#using scripts\engine\utility;
#namespace namespace_53b51ef230f6a8e6;

function private autoexec __init__system__() {
  system::register(#"hash_43d22da7ddb364f2", #"ww_dg2", &pre_main, undefined);
}

function private pre_main() {
  utility::registersharedfunc("ww_dg2", "init", &init);
}

function private init() {
  level.var_b8d710fc87c905a1 = lightning_chain::create_lightning_chain_params(5, 300, 0, 0.5, 3);
  level callback::add("player_damaged", &function_a4df91bf8f36fac7);

  if(!isDefined(level.var_664eba510919348e)) {
    level.var_664eba510919348e = [];
  }

  level.var_664eba510919348e["jup_ar_dg2"] = &function_ac6cb661c14270d6;

  if(!isDefined(level.var_58ffe6a7ac9f8fd4)) {
    level.var_58ffe6a7ac9f8fd4 = [];
  }

  level.var_58ffe6a7ac9f8fd4["jup_ar_dg2_mp"] = getdvarint(@ "hash_54a53dc8a3b446ec", 12);
}

function private function_a4df91bf8f36fac7(params) {
  if(params.objweapon.basename != "jup_ar_dg2_mp") {
    return;
  }

  if(!isPlayer(params.eattacker)) {
    return;
  }

  if(!isDefined(params.einflictor)) {
    return;
  }

  if(!(params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH")) {
    return;
  }

  if(params.eattacker == params.victim) {
    return;
  }

  if(istrue(params.einflictor.var_d52b09a011a12b2a)) {
    return;
  } else {
    params.einflictor.var_d52b09a011a12b2a = 1;
  }

  params.eattacker.tesla_enemies_hit = 1;
  params.eattacker.tesla_enemies = undefined;
  params.eattacker.tesla_arc_count = 0;
  params.eattacker.tesla_firing = 1;
  var_b8d710fc87c905a1 = level.var_b8d710fc87c905a1;
  var_b8d710fc87c905a1.weapon = params.objweapon;
  var_b8d710fc87c905a1.player = params.eattacker;
  var_b8d710fc87c905a1.inflictor = params.einflictor;
  var_b8d710fc87c905a1.should_gib_head = 0;
  var_b8d710fc87c905a1.var_cc8643dde5979643 = params.eattacker namespace_2b1145f62aa835b8::function_af5127390d3221e9(params.objweapon);
  var_b8d710fc87c905a1.lc_id = string(params.eattacker getentitynumber()) + string(gettime());
  var_b8d710fc87c905a1.smeansofdeath = params.smeansofdeath;
  var_b8d710fc87c905a1.victim = self;
  thread lightning_chain::arc_damage(self, params.eattacker, var_b8d710fc87c905a1);
}

function private function_ac6cb661c14270d6(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_be4285b26ed99ab1) {
  if(getdvarint(@ "hash_ee9f7b717cacdf88", 1)) {
    modified_damage = 0;

    if(smeansofdeath == "MOD_PROJECTILE_SPLASH") {
      idamage = getdvarint(@ "hash_af4bee84556fa7c8", 100);
      modified_damage = 1;
    } else if(smeansofdeath == "MOD_PROJECTILE") {
      idamage = getdvarint(@ "hash_d6ccc58be41893f3", 125);
      modified_damage = 1;
    }

    if(getdvarint(@ "hash_81fb55760c8c99aa", 0)) {
      total_health = victim.health + victim.armorhealth;
      string = victim.name + "<dev string:x1c>";
      string += "<dev string:x21>" + total_health + "<dev string:x1c>";
      string += "<dev string:x32>" + idamage + "<dev string:x1c>";
      string += "<dev string:x43>" + total_health - idamage + "<dev string:x1c>";
      string += "<dev string:x54>" + smeansofdeath + "<dev string:x1c>";
      println(string);
    }

    if(modified_damage) {
      scalar = armor::function_3768b225bd3bcf44();

      if(scalar > 1) {
        idamage /= scalar;
        idamage = int(ceil(idamage));
      }
    }
  }

  return idamage;
}