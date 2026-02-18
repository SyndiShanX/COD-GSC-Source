/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\chopper_gunner.gsc
***********************************************/

#using script_72d96920f15049b8;
#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\util;
#namespace chopper_gunner;

function private autoexec __init__system__() {
  system::register(#"chopper_gunner", &preinit, undefined, &function_3675de8b, #"killstreaks");
}

function private preinit() {
  profilestart();
  player::function_cf3aa03d(&function_d45a1f8d, 1);
  level.var_2d4792e7 = &function_5160bb1e;
  namespace_e8c18978::preinit("killstreak_chopper_gunner");
  profilestop();
}

function private function_3675de8b() {
  namespace_e8c18978::function_3675de8b();
}

function private function_5160bb1e(killstreaktype) {
  player = self;
  player endon(#"disconnect");
  level endon(#"game_ended");
  assert(!isDefined(level.chopper_gunner));
  var_d6940e18 = namespace_e8c18978::function_5160bb1e(killstreaktype);

  if(var_d6940e18 && isbot(player)) {
    player thread function_25d9a09f(level.chopper_gunner);
  }

  util::function_a3f7de13(21, player.team, player getentitynumber(), level.killstreaks[# "chopper_gunner"].uiname);
  return var_d6940e18;
}

function function_d45a1f8d(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isDefined(level.chopper_gunner) || !isDefined(shitloc.owner) || !isDefined(psoffsettime) || !isDefined(deathanimduration)) {
    return;
  }

  if(shitloc.owner == psoffsettime && deathanimduration == getweapon(#"hash_1734871fef9c0549")) {
    level.chopper_gunner namespace_e8c18978::function_631f02c5();
  }
}

function function_25d9a09f(vehicle) {
  vehicle endon(#"hash_6668be249f2eab45", #"death");
  self endon(#"disconnect");
  waitframe(1);

  while(self isremotecontrolling()) {
    enemy = undefined;
    enemies = self teams::getenemyplayers();
    enemies = array::randomize(enemies);

    foreach(potentialenemy in enemies) {
      if(isalive(potentialenemy)) {
        enemy = potentialenemy;
        break;
      }
    }

    if(isDefined(enemy)) {
      vectorfromenemy = vectornormalize(((vehicle.origin - enemy.origin)[0], (vehicle.origin - enemy.origin)[1], 0));
      vehicle turretsettarget(0, enemy);
      vehicle waittilltimeout(1, #"turret_on_target");
      vehicle vehicle_ai::fire_for_time(2 + randomfloat(0.8), 0, enemy);
      vehicle vehicle_ai::fire_for_rounds(1, 1, enemy);
      vehicle turretcleartarget(0);
      vehicle turretsettargetangles(0, (15, 0, 0));

      if(isDefined(enemy)) {
        wait 2 + randomfloat(0.5);
      }
    }

    wait 0.1;
  }
}