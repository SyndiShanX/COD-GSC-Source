/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_jammer_shared.gsc
******************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damage;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\weapons\weaponobjects;

#namespace jammer;

init_shared() {
  if(!isDefined(level.var_578f7c6d)) {
    level.var_578f7c6d = spawnStruct();
  }

  if(!isDefined(level.var_578f7c6d.weapontypeoverrides)) {
    level.var_578f7c6d.weapontypeoverrides = [];
  }

  level.var_578f7c6d.weapon = getweapon(#"eq_emp_grenade");
  level.var_578f7c6d.customsettings = getscriptbundle(level.var_578f7c6d.weapon.customsettings);
  weaponobjects::function_e6400478(#"eq_emp_grenade", &function_1a50ce7b, 1);
  registerclientfields();
  setupcallbacks();
}

setupcallbacks() {
  level.var_a5dacbea = &function_4e7e56a8;
  level.var_5d492b75 = &function_1c430dad;
  level.var_7b151daa = &function_7b151daa;
  level.var_86e3d17a = &function_86e3d17a;
  level.var_fc1bbaef = &function_fc1bbaef;
  level.var_1794f85f = &function_2572e9cc;
  level.var_48c30195 = &function_48c30195;
  callback::on_spawned(&onplayerspawned);
  callback::on_player_killed_with_params(&on_player_killed);
  callback::on_finalize_initialization(&function_1c601b99);
}

private registerclientfields() {
  clientfield::register("scriptmover", "isJammed", 9000, 1, "int");
  clientfield::register("missile", "isJammed", 9000, 1, "int");
  clientfield::register("vehicle", "isJammed", 9000, 1, "int");
  clientfield::register("toplayer", "isJammed", 9000, 1, "int");
  clientfield::register("missile", "jammer_active", 9000, 1, "int");
  clientfield::register("toplayer", "jammedvehpostfx", 9000, 1, "int");
}

private function_1a50ce7b(watcher) {
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.deleteonplayerspawn = 0;
  watcher.enemydestroy = 1;
  watcher.onspawn = &function_7d81a4ff;
  watcher.ondestroyed = &function_b2e496fa;
  watcher.ontimeout = &function_b2e496fa;
  watcher.ondetonatecallback = &function_51a743f8;
}

function_48c30195(entity, shouldignore) {
  if(isDefined(entity)) {
    entity.ignoreemp = shouldignore;
  }
}

function_86e3d17a() {
  return level.var_578f7c6d.customsettings.var_3bd9b483;
}

register(entity, var_448f97f2) {
  entity.var_123aec6c = var_448f97f2;
}

function_4e7e56a8(weapon, callbackfunction) {
  level.var_578f7c6d.weapontypeoverrides[weapon.name] = callbackfunction;
}

function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](level.var_578f7c6d.weapon, &function_bff5c062);
  }
}

function_fc1bbaef(entity) {
  thread function_d88f3e48(entity);
}

function_bff5c062(jammer, attackingplayer) {
  jammer.team = attackingplayer.team;
  jammer setteam(attackingplayer.team);
  jammer.owner = attackingplayer;
  jammer thread function_6a973411();
}

on_player_killed(params) {
  if(!isDefined(params.eattacker)) {
    return;
  }

  if(!(isDefined(self.isjammed) ? self.isjammed : 0)) {
    return;
  }

  if(!isDefined(self.var_fe1ebada)) {
    return;
  }

  if(self.var_fe1ebada == params.eattacker) {
    scoreevents::processscoreevent(#"disruptor_kill", self.var_fe1ebada, undefined, level.var_578f7c6d.weapon);
    params.eattacker function_be7a08a8(level.var_578f7c6d.weapon, 1);
    return;
  }

  if(isDefined(self.var_fe1ebada.team) && isDefined(params.eattacker.team) && self.var_fe1ebada.team == params.eattacker.team) {
    scoreevents::processscoreevent(#"disruptor_assist", self.var_fe1ebada, undefined, level.var_578f7c6d.weapon);
  }
}

onplayerspawned() {
  self.isjammed = 0;
}

private function_7d81a4ff(watcher, player) {
  if(!isDefined(self.var_88d76fba)) {
    self.var_88d76fba = [];
  }

  self.owner = player;
  self.weapon = level.var_578f7c6d.weapon;
  self setweapon(level.var_578f7c6d.weapon);
  self setteam(player getteam());
  self.team = player getteam();
  self clientfield::set("enemyequip", 1);
  thread function_3a3a2ea9(self);
  waitresult = self function_5f86757d();

  if(!isDefined(player) || !isDefined(waitresult)) {
    return;
  }

  if(waitresult._notify == #"explode" && isDefined(waitresult.position)) {
    self thread function_87c540c0(self, waitresult.position, player);
  }
}

private function_2572e9cc(attackingplayer, var_fb5e3b16) {
  scoreevents::processscoreevent(var_fb5e3b16, attackingplayer, undefined, level.var_578f7c6d.weapon);
}

private function_87c540c0(jammer, origin, attackingplayer) {
  entities = getentitiesinradius(origin, level.var_578f7c6d.weapon.explosionradius);
  var_545dd758 = 0;
  var_480b4b92 = 0;

  foreach(entity in entities) {
    if(!function_b16c8865(entity, attackingplayer)) {
      if(!var_480b4b92 && isplayer(entity) && entity hastalent(#"talent_resistance") && util::function_fbce7263(entity.team, attackingplayer.team)) {
        attackingplayer damagefeedback::update(undefined, undefined, "resistance", level.var_578f7c6d.weapon);
        var_480b4b92 = 1;
      }

      continue;
    }

    if(isplayer(entity)) {
      thread function_b8c5ab9c(jammer, entity, attackingplayer);
      continue;
    }

    var_decc08e9 = thread function_e27c41b4(jammer, entity, attackingplayer);

    if(var_decc08e9 === 1) {
      var_545dd758++;
    }
  }

  if(var_545dd758 >= 2) {
    scoreevents::processscoreevent(#"hash_208b61a32a38340e", attackingplayer, undefined, level.var_578f7c6d.weapon);
  }
}

private function_e27c41b4(jammer, entity, attackingplayer) {
  entity endon(#"death");

  if(!isDefined(entity)) {
    return false;
  }

  if(isalive(entity) && isvehicle(entity) && isDefined(level.is_staircase_up)) {
    function_1c430dad(entity, 1);
    function_58f8bf08(jammer, attackingplayer, undefined);
    entity thread[[level.is_staircase_up]](attackingplayer, jammer);
    return true;
  }

  if(isalive(entity) && isactor(entity)) {
    function_1c430dad(entity, 1);
    function_58f8bf08(jammer, attackingplayer, undefined);
    entity callback::callback(#"hash_7140c3848cbefaa1", {
      #attackingplayer: attackingplayer, 
      #jammer: jammer
    });
    return true;
  }

  weapon = isDefined(entity.identifier_weapon) ? entity.identifier_weapon : entity.weapon;

  if(!isDefined(weapon)) {
    return false;
  }

  if(isDefined(level.var_578f7c6d.weapontypeoverrides[weapon.name])) {
    function_1c430dad(entity, 1);
    function_58f8bf08(jammer, attackingplayer, undefined);
    function_2e6238c0(weapon, entity.owner);
    thread[[level.var_578f7c6d.weapontypeoverrides[weapon.name]]](entity, attackingplayer);
    return true;
  }

  thread function_ca8a005e(jammer, entity, attackingplayer);
  return true;
}

private function_b8c5ab9c(jammer, player, attackingplayer) {
  player notify(#"hash_4f2e183cc0ec68bd");
  player endon(#"death", #"hash_4f2e183cc0ec68bd");
  player clientfield::set_to_player("isJammed", 1);
  player.isjammed = 1;
  player.var_fe1ebada = attackingplayer;
  player setempjammed(1);
  scoreevents::processscoreevent(#"disrupted_enemy", attackingplayer, undefined, level.var_578f7c6d.weapon);
  function_58f8bf08(jammer, attackingplayer, player);
  wait level.var_578f7c6d.customsettings.var_f29418f1;

  if(!isDefined(player)) {
    return;
  }

  function_d88f3e48(player);
}

private function_ca8a005e(jammer, gadget, attackingplayer) {
  gadget endon(#"death");

  if(!isDefined(gadget.weapon)) {
    return;
  }

  if(!gadget.weapon.var_8032088a) {
    return;
  }

  function_1c430dad(gadget, 1);
  function_2e6238c0(gadget.weapon, gadget.owner);

  if(isDefined(gadget.weapon.var_775d2aad) && gadget.weapon.var_775d2aad) {
    thread function_4a82368f(gadget, gadget.owner);
  }

  wait gadget.weapon.var_416021d8;

  if(!isDefined(attackingplayer)) {
    return;
  }

  if(!isDefined(gadget)) {
    return;
  }

  gadget dodamage(1000, gadget.origin, attackingplayer, jammer, undefined, "MOD_GRENADE_SPLASH", 0, level.var_578f7c6d.weapon);
  function_58f8bf08(jammer, attackingplayer, undefined);
}

function_4a82368f(entity, owner) {
  assert(isDefined(owner));

  if(isplayer(owner)) {
    owner clientfield::set_to_player("jammedvehpostfx", 1);
  }

  entity waittill(#"death", #"remote_weapon_end", #"hash_2476803a0d5fa572");

  if(!isDefined(owner)) {
    return;
  }

  if(isplayer(owner)) {
    owner clientfield::set_to_player("jammedvehpostfx", 0);
  }
}

function_1c430dad(entity, isjammed) {
  if(!isplayer(entity) && !isactor(entity)) {
    entity clientfield::set("isJammed", isjammed);
  }

  entity.isjammed = isjammed;
  entity.emped = isjammed;
}

private function_d88f3e48(entity) {
  if(!isDefined(entity)) {
    return;
  }

  if(isplayer(entity)) {
    entity clientfield::set_to_player("isJammed", 0);
    entity setempjammed(0);
  }

  function_1c430dad(entity, 0);

  if(isDefined(entity.weapon) && !isplayer(entity) && isDefined(entity.owner)) {
    function_2eb0a933(entity.weapon, entity.owner);
  }
}

function_6a973411() {
  util::wait_network_frame();
  self clientfield::set("jammer_active", 0);
  util::wait_network_frame();
  self clientfield::set("jammer_active", 1);
}

function_cc908239(entity) {
  if(isDefined(entity.owner)) {
    return entity.owner;
  }

  return undefined;
}

function_51a743f8(attacker, weapon, target) {
  self delete();
}

function_b2e496fa(watcher) {
  self delete();
}

private function_b16c8865(entity, attackingplayer) {
  if(self == entity) {
    return false;
  }

  if(!isplayer(entity) && (!isDefined(entity.model) || entity.model == #"")) {
    return false;
  }

  if(isactor(entity) && !(isDefined(entity.var_8f61d7f4) && entity.var_8f61d7f4)) {
    return false;
  }

  if(isDefined(entity.team) && !util::function_fbce7263(entity.team, attackingplayer.team)) {
    return false;
  }

  if(isplayer(entity) && entity hastalent(#"talent_resistance")) {
    return false;
  }

  if(isDefined(entity.ignoreemp) ? entity.ignoreemp : 0) {
    return false;
  }

  return true;
}

private function_7b151daa(player) {
  return isDefined(player.isjammed) && player.isjammed;
}

function_5f86757d() {
  level endon(#"game_ended");
  waitresult = self waittill(#"explode", #"death");

  if(!isDefined(self)) {
    return waitresult;
  }

  self clientfield::set("enemyequip", 0);
  return waitresult;
}

private function_3a3a2ea9(jammer) {
  jammer endon(#"death");
  waitresult = jammer waittilltimeout(2, #"hash_754a0aedf9f00e8d");

  if(!isDefined(jammer)) {
    return;
  }

  jammer playSound(#"hash_7ed67b248bc52c02");
  playFXOnTag(#"hash_5a695126234cbb41", jammer, "tag_origin");
}

private function_58f8bf08(jammer, attackingplayer, victim) {
  if(damagefeedback::dodamagefeedback(level.var_578f7c6d.weapon, attackingplayer)) {
    attackingplayer thread damagefeedback::update("MOD_UNKNOWN", jammer, undefined, level.var_578f7c6d.weapon, victim, 0, undefined, 0, 0, 1);
  }
}

function_2e6238c0(weapon, owner) {
  if(!isDefined(weapon) || !isDefined(owner)) {
    return;
  }

  taacomdialog = undefined;
  leaderdialog = undefined;

  switch (weapon.name) {
    case #"tank_robot":
    case #"inventory_tank_robot":
    case #"ai_tank_marker":
      taacomdialog = "aiTankJammedStart";
      leaderdialog = "aiTankJammedStart";
      break;
    case #"ultimate_turret":
    case #"inventory_ultimate_turret":
      taacomdialog = "ultTurretJammedStart";
      leaderdialog = "ultTurretJammedStart";
      break;
    case #"ability_smart_cover":
    case #"gadget_smart_cover":
      taacomdialog = "smartCoverJammedStart";
      break;
  }

  if(isDefined(leaderdialog) && isDefined(owner)) {
    if(isDefined(level.var_57e2bc08)) {
      if(level.teambased) {
        thread[[level.var_57e2bc08]](leaderdialog, owner.team, owner);
      }
    }
  }

  if(isDefined(taacomdialog) && isDefined(owner)) {
    owner thread killstreaks::play_taacom_dialog(taacomdialog);
  }
}

function_2eb0a933(weapon, owner) {
  if(!isDefined(weapon) || !isDefined(owner)) {
    return;
  }

  taacomdialog = undefined;
  leaderdialog = undefined;

  switch (weapon.name) {
    case #"tank_robot":
    case #"inventory_tank_robot":
    case #"ai_tank_marker":
      taacomdialog = "aiTankJammedEnd";
      leaderdialog = "aiTankJammedEnd";
      break;
    case #"ultimate_turret":
    case #"inventory_ultimate_turret":
      taacomdialog = "ultTurretJammedEnd";
      leaderdialog = "ultTurretJammedEnd";
      break;
    case #"ability_smart_cover":
    case #"gadget_smart_cover":
      taacomdialog = "smartCoverJammedEnd";
      break;
  }

  if(isDefined(leaderdialog) && isDefined(owner)) {
    if(isDefined(level.var_57e2bc08)) {
      if(level.teambased) {
        thread[[level.var_57e2bc08]](leaderdialog, owner.team, owner);
      }
    }
  }

  if(isDefined(taacomdialog) && isDefined(owner)) {
    owner thread killstreaks::play_taacom_dialog(taacomdialog);
  }
}