/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\helicopter.gsc
***********************************************/

#include scripts\core_common\challenges_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\helicopter_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\mp_common\challenges;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\player\player_utils;

#namespace helicopter;

autoexec __init__system__() {
  system::register(#"helicopter", &__init__, undefined, #"killstreaks");
}

__init__() {
  level.var_34f03cda = &function_34f03cda;
  level.var_4d5e1035 = &function_4d5e1035;
  level.var_6af968ce = &function_6af968ce;
  init_shared("killstreak_helicopter_comlink");
  player::function_cf3aa03d(&function_d45a1f8d, 0);
}

function_6af968ce(attacker, weapon, mod) {
  if(isDefined(attacker) && isplayer(attacker)) {
    if(!isDefined(self.owner) || self.owner util::isenemyplayer(attacker)) {
      attacker battlechatter::function_dd6a6012(self.killstreaktype, weapon);
      self killstreaks::function_73566ec7(attacker, weapon, self.owner);
      challenges::destroyedhelicopter(attacker, weapon, mod, 0);
      attacker challenges::addflyswatterstat(weapon, self);
      attacker stats::function_e24eec31(weapon, #"hash_3f3d8a93c372c67d", 1);
    }
  }

  if(self.leaving !== 1) {
    self killstreaks::play_destroyed_dialog_on_owner(self.killstreaktype, self.killstreak_id);
  }
}

function_34f03cda(hardpointtype) {
  if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
    self challenges::calledincomlinkchopper();
  }
}

function_4d5e1035(attacker, weapon, type, weapon_damage, event, playercontrolled, hardpointtype) {
  if(weapon_damage > 0) {
    self challenges::trackassists(attacker, weapon_damage, 0);
  }

  if(isDefined(event)) {
    if(isDefined(self.owner) && self.owner util::isenemyplayer(attacker)) {
      challenges::destroyedhelicopter(attacker, weapon, type, 0);
      challenges::destroyedaircraft(attacker, weapon, playercontrolled, 1);
      scoreevents::processscoreevent(event, attacker, self.owner, weapon);
      attacker challenges::addflyswatterstat(weapon, self);

      if(playercontrolled == 1) {
        attacker challenges::destroyedplayercontrolledaircraft();
      }

      if(hardpointtype == "helicopter_player_gunner") {
        attacker stats::function_e24eec31(weapon, #"destroyed_controlled_killstreak", 1);
      }
    }
  }
}

function_d45a1f8d(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isDefined(einflictor) || !isDefined(einflictor.owner) || !isDefined(attacker) || !isDefined(weapon)) {
    return;
  }

  if(einflictor.owner == attacker && weapon == getweapon(#"cobra_20mm_comlink") && (isDefined(einflictor.lastkillvo) ? einflictor.lastkillvo : 0) < gettime()) {
    einflictor killstreaks::play_pilot_dialog_on_owner("kill", "helicopter_comlink", einflictor.killstreak_id);
    einflictor.lastkillvo = gettime() + 5000;
  }
}