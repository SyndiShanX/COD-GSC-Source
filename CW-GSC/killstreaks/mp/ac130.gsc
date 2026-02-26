/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\ac130.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\killstreaks\ac130_shared;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\util;
#namespace ac130_mp;

function private autoexec __init__system__() {
  system::register(#"ac130", &preinit, undefined, &function_3675de8b, #"killstreaks");
}

function private preinit() {
  profilestart();
  player::function_cf3aa03d(&function_d45a1f8d, 1);
  level.var_f987766c = &spawnac130;
  ac130_shared::preinit("killstreak_ac130");
  profilestop();
}

function private function_3675de8b() {
  ac130_shared::function_3675de8b();
}

function private spawnac130(killstreaktype) {
  player = self;
  player endon(#"disconnect");
  level endon(#"game_ended");
  assert(!isDefined(level.ac130));
  var_b0b764aa = ac130_shared::spawnac130(killstreaktype);

  if(var_b0b764aa && isbot(player)) {
    level.ac130 thread ac130_shared::function_a514a080(player);
  }

  util::function_a3f7de13(21, player.team, player getentitynumber(), level.killstreaks[#"ac130"].uiname);
  return var_b0b764aa;
}

function function_d45a1f8d(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isDefined(shitloc) || !isDefined(shitloc.owner) || !isDefined(psoffsettime) || self.team === psoffsettime.team || !isDefined(deathanimduration)) {
    return;
  }

  if(shitloc.owner == psoffsettime && deathanimduration.statname == "ac130") {
    if(deathanimduration == getweapon(#"hash_17df39d53492b0bf")) {
      var_f9e67747 = 0;
    } else if(deathanimduration == getweapon(#"hash_7b24d0d0d2823bca")) {
      var_f9e67747 = 1;
    } else {
      var_f9e67747 = 2;
    }

    if(isDefined(level.ac130)) {
      level.ac130 ac130_shared::function_631f02c5(var_f9e67747);
    }
  }
}

function function_6b26dd0c(player) {
  self endon(#"death", #"ac130_shutdown");
  player endon(#"disconnect");
  wait 2;
  player thread ac130_shared::function_8721028e(player, 0, 1);
}