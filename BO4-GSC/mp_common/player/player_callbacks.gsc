/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\player\player_callbacks.gsc
*************************************************/

#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic_ui;
#include scripts\mp_common\player\player_damage;

#namespace player;

callback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind) {
  hit = 1;

  if(level.teambased && !self util::isenemyteam(eattacker.team)) {
    if(level.friendlyfire == 0) {
      hit = 0;
    }
  }

  self finishmeleehit(eattacker, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind);
}

function_74b6d714(attacker, effectname, var_894859a2, durationoverride, weapon) {
  var_20df3f41 = function_1115bceb(effectname);

  if(isDefined(durationoverride) && durationoverride > 0) {
    duration = durationoverride;
  } else {
    duration = undefined;
  }

  attackerishittingteammate = isplayer(attacker) && self util::isenemyplayer(attacker) == 0 && self != attacker;
  attackerishittingself = isplayer(attacker) && self == attacker;

  if(attackerishittingself && weapon.var_50d2316b) {
    return;
  }

  if(attackerishittingteammate && !function_1727a023(0, attacker)) {
    return;
  }

  self status_effect::status_effect_apply(var_20df3f41, weapon, attacker, undefined, duration, var_894859a2);
}

callback_playershielddamageblocked(damage) {
  previous_shield_damage = self.shielddamageblocked;
  self.shielddamageblocked += damage;

  if(self.shielddamageblocked % 200 < previous_shield_damage % 200) {
    score_event = "shield_blocked_damage";
    scoreevents::processscoreevent(score_event, self, undefined, self.currentweapon);
  }
}

callback_playermigrated() {
  println("<dev string:x38>" + self.name + "<dev string:x42>" + gettime());

  if(isDefined(self.connected) && self.connected) {
    self globallogic_ui::updateobjectivetext();
  }

  level.hostmigrationreturnedplayercount++;

  if(level.hostmigrationreturnedplayercount >= level.players.size * 2 / 3) {
    println("<dev string:x61>");
    level notify(#"hostmigration_enoughplayers");
  }
}

callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(level.var_97c6ee7c)) {
    [[level.var_97c6ee7c]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
  }
}