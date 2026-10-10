/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\supers\super_stimpistol.gsc
*****************************************************/

#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\laststand;
#using scripts\mp\pmc_missions;
#using scripts\mp\supers;
#using scripts\mp\supers\super_stimpistol;
#using scripts\mp\teamrevive;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#namespace super_stimpistol;

function function_c916427f116f1206() {
  level.var_b5f053a7ff75210e = getdvarint(@ "hash_660a6d69270c9d7c", 1);
  level.var_7ddbbb03da35cba6 = getdvarint(@ "hash_3a7a4bf29f0f6e78", 0);
  level.var_d6a1a4d7b320f72b = getdvarint(@ "hash_bd6ad02d326bbffc", 1);
  level.var_73a59765d6944026 = getdvarint(@ "hash_9f96b49415b4afab", 0);
}

function function_76ca0b3d8b2555ca(weaponobj) {
  if(!isDefined(weaponobj)) {
    return false;
  }

  return weaponobj.basename == "iw9_pi_stimpistol_mp";
}

function function_a377d33613e0c83() {}

function function_c61ee6d60763e771() {
  return level.var_b5f053a7ff75210e || level.var_7ddbbb03da35cba6;
}

function function_31afe9d7b373900f() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  superinfo = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::setsuperisinuse(1);
  scripts\mp\supers::setsuperisactive(1);
  scripts\mp\supers::function_a4496878854ae85b(superinfo.staticdata.useweapon, undefined, 100);
  scripts\mp\gametypes\br_pickups::resetsuper();
}

function function_807b3b0a3b4128f9() {
  if(isDefined(self.var_b24e609023ce8208)) {
    self.var_b24e609023ce8208 = undefined;
  }

  if(isDefined(self.var_98d31d9ce04b2b81)) {
    self.var_98d31d9ce04b2b81 = undefined;
  }
}

function function_a35fff2ff233592a() {
  currentsuper = scripts\mp\supers::getcurrentsuper();

  if(!isDefined(currentsuper)) {
    return false;
  }

  if(currentsuper.staticdata.ref != "super_stimpistol") {
    return false;
  }

  superammo = function_3889d69492a93008();

  if(superammo > 0 || issuperready()) {
    return true;
  }

  return false;
}

function private super_stimpistol_watchhits() {
  self notify("super_stimPistol_watchHits");
  self endon("super_stimPistol_watchHits");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("bullet_first_impact", var_9d7ca6252f103a3b, hitent, hitentpart, surfacenormal, surfacetype, weapon, bulletdir, impactpos, hitloc);

    if(isDefined(hitent) && function_76ca0b3d8b2555ca(weapon)) {
      thread function_8a99cebbc265563e(hitent, impactpos, weapon);
    }
  }
}

function private function_ce78face7e6da5de(var_de6d964ca3fb3603) {
  return isDefined(var_de6d964ca3fb3603) && isDefined(var_de6d964ca3fb3603.var_ff06b80996e03e04);
}

function private function_40bcb765cc81e05f(var_de6d964ca3fb3603) {
  return isDefined(var_de6d964ca3fb3603) && isDefined(var_de6d964ca3fb3603.var_516a933930eb2c27);
}

function private super_stimpistol_tagentashit(var_df0969d1fc3f7545) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("super_stimPistol_tagEntAsHit");
  self endon("super_stimPistol_tagEntAsHit");

  if(!isDefined(self.var_2e5de68612c3de1b)) {
    self.var_2e5de68612c3de1b = var_df0969d1fc3f7545;
  }

  if(isDefined(self.var_65a2b57b2b474c00) && !istrue(self.var_65a2b57b2b474c00.inuse)) {
    self.var_65a2b57b2b474c00.inuse = 1;
  }

  wait 3;

  while(scripts\mp\utility\player::getbeingrevivedinternal()) {
    wait 0.1;
  }

  self.var_2e5de68612c3de1b = undefined;
}

function private function_b66f1712709e29e1(hittarget, typeint) {
  if(!isDefined(hittarget)) {
    return;
  }

  if(!isPlayer(hittarget) || !isbot(hittarget)) {
    return;
  }

  if(!istrue(hittarget.inlaststand) && !istrue(hittarget.liveragdoll)) {
    return;
  }

  if(typeint == 1) {
    scripts\cp_mp\damagefeedback::updatehitmarker("standard", 0, 0, 0, "hitlaststand_stimpistol", self getentitynumber());
    return;
  }

  if(typeint == 2) {
    scripts\cp_mp\damagefeedback::updatehitmarker("standard", 0, 0, 0, "hitcyber_stimpistol", self getentitynumber());
    return;
  }

  scripts\cp_mp\damagefeedback::updatehitmarker("standard", 0, 0, 0, undefined, self getentitynumber());
}

function function_f0d1c9c39359efff() {
  return isDefined(self.var_2e5de68612c3de1b);
}

function function_4bdcd177675c91ba(revivee) {
  var_de6d964ca3fb3603 = spawnStruct();
  var_de6d964ca3fb3603.reviver = self;
  var_de6d964ca3fb3603.revivee = ter_op(isDefined(revivee), revivee, undefined);
  var_de6d964ca3fb3603.var_ff06b80996e03e04 = revivee scripts\mp\teamrevive::function_15933e1583288208();
  var_de6d964ca3fb3603.var_516a933930eb2c27 = ter_op(isDefined(revivee.var_65a2b57b2b474c00), revivee.var_65a2b57b2b474c00, undefined);
  var_de6d964ca3fb3603.laststandrevivetimervalue = function_44c1a12f54ec6a4f();
  var_de6d964ca3fb3603.var_5c9e2171f24a94d8 = function_fa06085052105f5c();
  return var_de6d964ca3fb3603;
}

function function_22044a9973aa399c(shootingplayer, shotplayer) {
  newweapon = makeweapon("iw9_pi_stimpistol_mp");
  shootingplayer function_8a99cebbc265563e(shotplayer, shotplayer.origin, newweapon);
}

function private function_8a99cebbc265563e(hitent, impactpos, weapon) {
  level endon("game_ended");

  if(isDefined(hitent)) {
    hitent endon("death_or_disconnect");
  }

  if(!istrue(function_76ca0b3d8b2555ca(weapon))) {
    return 0;
  }

  if(!isDefined(hitent)) {
    return 0;
  }

  if(!istrue(isPlayer(hitent) || isagent(hitent))) {
    return 0;
  }

  if(!isDefined(hitent.team)) {
    return 0;
  }

  if(!istrue(level.var_b5f053a7ff75210e || level.var_7ddbbb03da35cba6)) {
    if(hitent.team != self.team) {
      return 0;
    }
  }

  hitent thread super_stimpistol_tagentashit(self);
  var_de6d964ca3fb3603 = function_4bdcd177675c91ba(hitent);

  if(istrue(level.var_d6a1a4d7b320f72b)) {
    if(isDefined(var_de6d964ca3fb3603.revivee) && function_40bcb765cc81e05f(var_de6d964ca3fb3603) && isinlaststand(var_de6d964ca3fb3603.revivee)) {
      scripts\mp\supers\super_stimpistol::function_466eb9801a8f5a59(var_de6d964ca3fb3603);
      scripts\cp_mp\challenges::function_d997435895422ecc("super_stimpistol", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"hit"));
      function_b66f1712709e29e1(hitent, 1);
      return;
    }
  }

  if(istrue(level.var_73a59765d6944026)) {
    if(hitent.team != self.team && !istrue(level.var_7ddbbb03da35cba6)) {
      return 0;
    }

    if(function_ce78face7e6da5de(var_de6d964ca3fb3603)) {
      scripts\mp\supers\super_stimpistol::function_ada94a4d4deecf34(var_de6d964ca3fb3603);
      scripts\cp_mp\challenges::function_d997435895422ecc("super_stimpistol", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"hit"));
      function_b66f1712709e29e1(hitent, 2);
    }

    thread super_stimpistol_startcyberrevive_retrythread(hitent);
  }
}

function function_466eb9801a8f5a59(var_de6d964ca3fb3603) {
  var_de6d964ca3fb3603.revivee playsoundtoplayer("weap_stimpistol_plr_hit_revive", var_de6d964ca3fb3603.revivee);
  var_de6d964ca3fb3603.var_516a933930eb2c27.var_2efb40714a6e9468 = 1;

  if(istrue(level.var_b5f053a7ff75210e)) {
    var_de6d964ca3fb3603.var_516a933930eb2c27.skipteamchecks = 1;
  }

  var_de6d964ca3fb3603.reviver.var_383e041e3e341315 = 1;
  var_de6d964ca3fb3603.var_516a933930eb2c27 notify("trigger", var_de6d964ca3fb3603.reviver);

  if(isDefined(var_de6d964ca3fb3603.revivee) && var_de6d964ca3fb3603.revivee.team == var_de6d964ca3fb3603.reviver.team) {
    namespace_a850435086c88de3::doonactionscoreevent(1, "superStimHeal");
  }

  scripts\mp\pmc_missions::function_c0a3853f9497fad3(var_de6d964ca3fb3603);
}

function function_ada94a4d4deecf34(var_de6d964ca3fb3603) {
  var_de6d964ca3fb3603.revivee playsoundtoplayer("weap_stimpistol_plr_hit_revive", var_de6d964ca3fb3603.revivee);
  var_de6d964ca3fb3603.var_ff06b80996e03e04.var_2efb40714a6e9468 = 1;
  var_de6d964ca3fb3603.var_ff06b80996e03e04.var_70814aa80e0d3d1 = 1;
  var_de6d964ca3fb3603.var_ff06b80996e03e04.useweapon = undefined;
  var_de6d964ca3fb3603.var_ff06b80996e03e04.remoterevive = 1;

  if(istrue(level.var_7ddbbb03da35cba6)) {
    var_de6d964ca3fb3603.var_ff06b80996e03e04.var_c0ee3288dbec12c6 = 1;
  }

  scripts\mp\teamrevive::function_301c4ec489f9bd39(var_de6d964ca3fb3603.var_ff06b80996e03e04, scripts\mp\teamrevive::function_692cdf5f87a8667b(), undefined, var_de6d964ca3fb3603.reviver, undefined, undefined);

  if(isDefined(var_de6d964ca3fb3603.revivee) && var_de6d964ca3fb3603.revivee.team == var_de6d964ca3fb3603.reviver.team) {
    namespace_a850435086c88de3::doonactionscoreevent(1, "superStimHeal");
  }
}

function private super_stimpistol_startcyberrevive_retrythread(hitent) {
  hitent notify("super_stimPistol_startCyberRevive_retryThread");
  hitent endon("super_stimPistol_startCyberRevive_retryThread");
  hitent endon("last_stand_start");
  hitent endon("death_or_disconnect");
  var_de6d964ca3fb3603 = function_4bdcd177675c91ba(hitent);
  retrycount = 0;

  while(!function_ce78face7e6da5de(var_de6d964ca3fb3603) && istrue(hitent.liveragdoll) && scripts\mp\utility\game::isteamreviveenabled()) {
    retrycount++;
    wait 1;
    hitent scripts\mp\supers\super_stimpistol::super_stimpistol_tagentashit(self);

    if(function_ce78face7e6da5de(var_de6d964ca3fb3603)) {
      scripts\mp\supers\super_stimpistol::function_ada94a4d4deecf34(var_de6d964ca3fb3603);
      scripts\cp_mp\challenges::function_d997435895422ecc("super_stimpistol", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"hit"));
      break;
    }

    if(retrycount >= 5) {
      break;
    }
  }
}

function private function_fa06085052105f5c() {
  out = ter_op(isDefined(level.teamrevivetime), level.teamrevivetime, 5);
  return ter_op(isDefined(out), out, undefined);
}

function private function_44c1a12f54ec6a4f() {
  out = scripts\mp\laststand::getdefaultlaststandrevivetimervalue();
  return ter_op(isDefined(out), out, undefined);
}

function function_321c7891711e583f() {
  thread super_stimpistol_watchhits();
  function_ad32396bd89936bb(0);
  scripts\cp_mp\challenges::function_d997435895422ecc("super_stimpistol", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  return true;
}

function function_f5037ba4a5399b63(fromdeath) {
  self notify("super_stimPistol_watchHits");
  function_ad32396bd89936bb(1);
  self.var_bf5b10918f8418a1 = undefined;
}

function function_9db6a100a4046d0c() {
  scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
}

function function_3f29f7ceb8c0ec6d() {
  self.var_b24e609023ce8208 = undefined;
  self.var_98d31d9ce04b2b81 = undefined;
  scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
}

function function_ad32396bd89936bb(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    self enableweaponpickup();
    return;
  }

  self disableweaponpickup();
}

function function_d44b1fe27ee0494f() {
  waittime = 10;
  thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim("iw9_vm_ges_stimpistol_dart_remove", waittime);
}

function function_b13d8e46564cdfda(triggerint) {
  if(triggerint == 1) {
    thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim("<dev string:x1c>", 10);
    return;
  }

  if(triggerint == 2) {
    thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim("<dev string:x38>", 10);
    return;
  }

  if(triggerint == 3) {
    thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim("<dev string:x60>", 10);
  }
}

# /