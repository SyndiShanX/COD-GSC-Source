/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\globallogic\globallogic_score.gsc
*********************************************************/

#include scripts\core_common\activecamo_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\contracts_shared;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\rank_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;

#namespace globallogic_score;

autoexec __init__system__() {
  system::register(#"globallogic_score", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&init);
  callback::on_spawned(&playerspawn);

  setdvar(#"logscoreevents", 0);
  setdvar(#"dumpscoreevents", 0);
  thread function_bb9f3842();

}

init() {
  level.var_e0582de1 = [];
  registerscoreeventcallback("playerKilled", &function_f7f7b14e);
  level.capturedobjectivefunction = &function_eced93f5;
}

playerspawn() {
  self.var_60a9eae7 = 0;
  self.var_a6b00192 = 0;
  self.var_7fff4605 = 0;
  self callback::on_weapon_change(&on_weapon_change);
  self callback::on_weapon_fired(&on_weapon_fired);
  self callback::on_grenade_fired(&on_grenade_fired);
}

private on_weapon_change(params) {
  self.var_a6b00192 = 0;
  self.var_7fff4605 = 0;
}

private on_weapon_fired(params) {
  self function_5aa55c0a(params.weapon);
}

private function_f0d51d49(projectile, weapon) {
  self endon(#"disconnect");
  level endon(#"game_ended");
  scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);

  if(!isDefined(scoreevents.var_aa14d757)) {
    return;
  }

  var_2a7ea9a6 = projectile waittilltimeout(10, #"death");

  if(var_2a7ea9a6._notify != "timeout") {
    scoreevents::processscoreevent(scoreevents.var_aa14d757, self, undefined, weapon);
  }
}

private on_grenade_fired(params) {
  weapon = params.weapon;

  if(!isDefined(weapon) || !isDefined(weapon.var_2e4a8800)) {
    return;
  }

  self function_5aa55c0a(weapon);
  self thread function_f0d51d49(params.projectile, weapon);
}

function_5aa55c0a(weapon) {
  if(isDefined(weapon) && isDefined(weapon.var_2e4a8800)) {
    scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
  }

  if(!isDefined(scoreevents)) {
    return;
  }

  if(isDefined(scoreevents.var_7ecee77b)) {
    scoreevents::processscoreevent(scoreevents.var_7ecee77b, self, undefined, weapon);
  }
}

inctotalkills(team) {
  if(level.teambased && isDefined(level.teams[team])) {
    game.totalkillsteam[team]++;
  }

  game.totalkills++;
}

givekillstats(smeansofdeath, weapon, evictim) {
  if(isDefined(level.scoreevents_givekillstats)) {
    [[level.scoreevents_givekillstats]](smeansofdeath, weapon, evictim);
  }
}

function_e93cd1bb(event, var_ba01256c, weapon, attacker, victim, var_586a3b24) {
  if(!isDefined(var_ba01256c)) {
    return 0;
  }

  if(!isDefined(attacker.var_19f577f)) {
    attacker.var_19f577f = [];
  }

  attacker.var_19f577f[event] = (isDefined(attacker.var_19f577f[event]) ? attacker.var_19f577f[event] : 0) + 1;

  if(isDefined(var_586a3b24) && var_586a3b24) {
    scoreevents::processscoreevent(event, attacker, victim, weapon);
  }
}

function_969ea48d(var_ba01256c, weapon) {
  if(!isDefined(var_ba01256c)) {
    return false;
  }

  scoreevents = function_3cbc4c6c(var_ba01256c.var_2e4a8800);

  if(!isDefined(scoreevents) || !isDefined(scoreevents.var_1253685d)) {
    return false;
  }

  scoreevents::processscoreevent(scoreevents.var_1253685d, self, undefined, weapon);

  if(rank::function_ca5d4a8(scoreevents.var_1253685d)) {
    function_e93cd1bb(scoreevents.var_1253685d, var_ba01256c, weapon, self, undefined, 0);
  }

  return true;
}

function_52ca9649(event) {
  if(!isDefined(level.scoreinfo[event])) {
    println("<dev string:x38>" + event);
    return 0;
  }

  if(!isDefined(self.var_19f577f)) {
    self.var_19f577f = [];
  }

  if(!isDefined(self.var_19f577f[event]) || self.var_19f577f[event] <= 0) {
    return;
  }

  eventindex = level.scoreinfo[event][#"row"];
  self luinotifyevent(#"end_sustaining_action", 1, eventindex);
  self.var_19f577f[event]--;
}

function_fc47f2ff(var_ba01256c, weapon) {
  if(!isDefined(var_ba01256c)) {
    return 0;
  }

  scoreevents = function_3cbc4c6c(var_ba01256c.var_2e4a8800);

  if(!isDefined(scoreevents) || !isDefined(scoreevents.var_1253685d)) {
    return 0;
  }

  function_52ca9649(scoreevents.var_1253685d);
}

processassist(killedplayer, damagedone, weapon, assist_level = undefined, time = gettime(), meansofdeath = "MOD_UNKNOWN") {
  waitframe(1);
  util::waittillslowprocessallowed();

  if(!isDefined(self) || !isDefined(killedplayer) || !isplayer(self) || !isplayer(killedplayer) || !isDefined(weapon)) {
    return;
  }

  if(isarray(level.specweapons)) {
    foreach(var_25f92d1d in level.specweapons) {
      self function_b78294bf(killedplayer, var_25f92d1d.weapon, weapon, var_25f92d1d, time, meansofdeath);
    }
  }

  self function_b78294bf(killedplayer, weapon, weapon, undefined, time, meansofdeath);

  if(isDefined(level.scoreevents_processassist)) {
    self[[level.scoreevents_processassist]](killedplayer, damagedone, weapon, assist_level);
  }
}

private function_b78294bf(victim, weapon, attackerweapon, var_67660cb2, time, meansofdeath) {
  scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);

  if((isDefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0) && isDefined(scoreevents) && isDefined(scoreevents.var_a6bfdc5f)) {
    if(isDefined(var_67660cb2)) {
      if(!isDefined(var_67660cb2.var_37850de1) || ![
          [var_67660cb2.var_37850de1]
        ](self, victim, weapon, attackerweapon)) {
        return;
      }
    }

    self function_662aaa65(weapon);
    self.multikills[weapon.name].objectivekills++;

    if(isDefined(scoreevents) && isDefined(scoreevents.var_a6bfdc5f)) {
      scoreevents::processscoreevent(scoreevents.var_a6bfdc5f, self, victim, weapon);
    }
  } else {
    if(isDefined(var_67660cb2)) {
      if(!isDefined(var_67660cb2.kill_callback) || ![
          [var_67660cb2.kill_callback]
        ](self, victim, weapon, attackerweapon, meansofdeath)) {
        return;
      }
    }

    if(isDefined(scoreevents) && isDefined(scoreevents.var_170b3630)) {
      scoreevents::processscoreevent(scoreevents.var_170b3630, self, victim, weapon);
    }
  }

  self function_8279d8bf(weapon, scoreevents);
}

function_5829abe3(attacker, weapon, var_651b6171) {
  if(!isDefined(self) || !isDefined(var_651b6171) || !isDefined(attacker) || !isplayer(attacker)) {
    return;
  }

  if(!isDefined(weapon)) {
    weapon = level.weaponnone;
  }

  attacker challenges::function_24db0c33(weapon, var_651b6171);

  if(isDefined(level.iskillstreakweapon)) {
    if([
        [level.iskillstreakweapon]
      ](weapon) || isDefined(weapon.statname) && [
        [level.iskillstreakweapon]
      ](getweapon(weapon.statname))) {
      weaponiskillstreak = 1;
    }

    if([
        [level.iskillstreakweapon]
      ](var_651b6171)) {
      destroyedkillstreak = 1;
    }
  }

  var_3c727edf = function_3cbc4c6c(var_651b6171.var_2e4a8800);

  if((!(isDefined(weaponiskillstreak) && weaponiskillstreak) || isDefined(destroyedkillstreak) && destroyedkillstreak) && isDefined(var_3c727edf) && isDefined(var_3c727edf.var_3143c814) && util::function_fbce7263(attacker.team, self.team)) {
    scoreevents::processscoreevent(var_3c727edf.var_3143c814, attacker, self, var_651b6171);
    attacker stats::function_dad108fa(#"stats_destructions", 1);
  }

  if(var_651b6171.issignatureweapon) {
    attacker activecamo::function_896ac347(weapon, #"showstopper", 1);
  }

  scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);

  if(isDefined(scoreevents) && isDefined(scoreevents.var_84eddb70)) {
    scoreevents::processscoreevent(scoreevents.var_84eddb70, attacker, self, weapon);
  }
}

function_a890cac2(attacker, owningteam, weapon, scoreevents, objectiveobj, var_1bbdd8b0) {
  attacker function_662aaa65(weapon);
  attacker.multikills[weapon.name].objectivekills++;

  if(level.teambased && isDefined(owningteam) && attacker.team == owningteam) {
    if(isDefined(level.specweapons) && isDefined(level.specweapons[weapon.name]) && isDefined(level.specweapons[weapon.name].var_826b85e7)) {
      [
        [level.specweapons[weapon.name].var_826b85e7]
      ](attacker, self, weapon, objectiveobj);
    }

    if(isDefined(scoreevents) && isDefined(scoreevents.var_867de225)) {
      scoreevents::processscoreevent(scoreevents.var_867de225, attacker, self, weapon);
    }

    if((isDefined(attacker.multikills[weapon.name].objectivekills) ? attacker.multikills[weapon.name].objectivekills : 0) > 2 && (isDefined(objectiveobj.var_4e02c9bd) ? objectiveobj.var_4e02c9bd : 0) < gettime()) {
      enemies = attacker getenemiesinradius(objectiveobj.origin, var_1bbdd8b0);

      if(enemies.size == 0) {
        objectiveobj.var_4e02c9bd = gettime() + 4000;
        attacker.multikills[weapon.name].var_d6089e48 = 1;
      }
    }
  }

  if(isDefined(scoreevents) && isDefined(scoreevents.var_8600aca4)) {
    scoreevents::processscoreevent(scoreevents.var_8600aca4, attacker, self, weapon);
  }
}

function_7d830bc(einflictor, attacker, weapon, objectiveobj, var_1bbdd8b0, owningteam, objectivetrigger) {
  attacker endon(#"disconnect", #"death");
  level endon(#"game_ended");
  self notify("38c4e69a4b1b634c");
  self endon("38c4e69a4b1b634c");

  if(!isplayer(attacker) || !isplayer(self) || !isDefined(weapon) || !isDefined(objectiveobj) || !isDefined(objectivetrigger) || !isDefined(var_1bbdd8b0)) {
    return false;
  }

  if(!self istouching(objectivetrigger, (var_1bbdd8b0, var_1bbdd8b0, 100))) {
    if(!isDefined(einflictor) || einflictor != attacker || !attacker istouching(objectivetrigger, (var_1bbdd8b0, var_1bbdd8b0, 100))) {
      return false;
    }
  }

  self.var_60a9eae7 = 1;
  attacker.var_f46a73a1 = weapon;
  attacker.var_60f43bac = gettime();
  attacker.var_e3d30669 = objectiveobj;
  scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
  self function_a890cac2(attacker, owningteam, weapon, scoreevents, objectiveobj, var_1bbdd8b0);

  if(isarray(level.specweapons)) {
    foreach(var_25f92d1d in level.specweapons) {
      if(!isDefined(var_25f92d1d.var_37850de1) || ![
          [var_25f92d1d.var_37850de1]
        ](attacker, self, var_25f92d1d.weapon, weapon)) {
        continue;
      }

      var_bbe53115 = function_3cbc4c6c(var_25f92d1d.weapon.var_2e4a8800);
      self function_a890cac2(attacker, owningteam, var_25f92d1d.weapon, var_bbe53115, objectiveobj, var_1bbdd8b0);
    }
  }

  return true;
}

private function_eced93f5(objective, var_c217216c) {
  if(!isDefined(objective) || !isDefined(var_c217216c) || !isDefined(self) || !isDefined(self.var_f46a73a1) || !isDefined(self.var_60f43bac) || !isDefined(self.var_e3d30669)) {
    return;
  }

  if(var_c217216c - self.var_60f43bac > int(20 * 1000) || objective != self.var_e3d30669) {
    return;
  }

  if(isarray(level.specweapons)) {
    foreach(specialweapon in level.specweapons) {
      if(isDefined(specialweapon.var_d20c7012)) {
        [
          [specialweapon.var_d20c7012]
        ](self, self.var_f46a73a1, self.var_60f43bac, self.var_e3d30669, specialweapon.weapon);
      }
    }
  }

  scoreevents = function_3cbc4c6c(self.var_f46a73a1.var_2e4a8800);

  if(isDefined(scoreevents) && isDefined(scoreevents.var_1d0ab0f4)) {
    scoreevents::processscoreevent(scoreevents.var_1d0ab0f4, self, undefined, self.var_f46a73a1);
  }
}

registerscoreeventcallback(callback, func) {
  if(!isDefined(level.scoreeventcallbacks)) {
    level.scoreeventcallbacks = [];
  }

  if(!isDefined(level.scoreeventcallbacks[callback])) {
    level.scoreeventcallbacks[callback] = [];
  }

  level.scoreeventcallbacks[callback][level.scoreeventcallbacks[callback].size] = func;
}

function_3cbc4c6c(scriptbundle) {
  if(!isDefined(scriptbundle)) {
    return;
  }

  if(!isDefined(level.var_e0582de1[scriptbundle])) {
    level.var_e0582de1[scriptbundle] = getscriptbundle(scriptbundle);
  }

  return level.var_e0582de1[scriptbundle];
}

function_24d66e59(inflictor, meansofdeath, victim, attacker, weapon, var_bd10969, time) {
  if(!isDefined(var_bd10969) || !isarray(var_bd10969)) {
    return;
  }

  waitframe(1);
  util::waittillslowprocessallowed();

  if(!isDefined(victim)) {
    return;
  }

  foreach(effect in var_bd10969) {
    if(!isDefined(effect) || !isDefined(effect.var_4b22e697) || victim == effect.var_4b22e697) {
      continue;
    }

    scoreevents = function_3cbc4c6c(effect.var_2e4a8800);

    if(!isDefined(scoreevents)) {
      continue;
    }

    if((isDefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0) && (isDefined(scoreevents.var_a6bfdc5f) || isDefined(scoreevents.var_8600aca4))) {
      attacker function_662aaa65(effect);
      attacker.multikills[effect.name].objectivekills++;

      if(isDefined(effect.var_4b22e697) && isplayer(effect.var_4b22e697) && attacker != effect.var_4b22e697) {
        if(isDefined(scoreevents.var_a6bfdc5f)) {
          scoreevents::processscoreevent(scoreevents.var_a6bfdc5f, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
        }
      } else if(isDefined(scoreevents.var_8600aca4)) {
        scoreevents::processscoreevent(scoreevents.var_8600aca4, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
      }
    } else if(isDefined(effect.var_4b22e697) && isplayer(effect.var_4b22e697) && attacker != effect.var_4b22e697 && attacker util::isenemyplayer(effect.var_4b22e697) == 0) {
      baseweapon = weapons::getbaseweapon(weapon);

      if(isDefined(scoreevents.var_2eaed769) && (isDefined(baseweapon.issignatureweapon) && baseweapon.issignatureweapon || isDefined(baseweapon.var_76ce72e8) && baseweapon.var_76ce72e8)) {
        scoreevents::processscoreevent(scoreevents.var_2eaed769, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
      } else if(isDefined(scoreevents.var_170b3630)) {
        scoreevents::processscoreevent(scoreevents.var_170b3630, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
      }
    }

    if(attacker == effect.var_4b22e697) {
      if(isDefined(level.var_f19c99e1) && isDefined(level.var_f19c99e1[effect.name]) && isDefined(level.var_f19c99e1[effect.name].kill_callback)) {
        if(![
            [level.var_f19c99e1[effect.name].kill_callback]
          ](self, victim, effect.var_3d1ed4bd, weapon, meansofdeath)) {
          return;
        }
      }

      updatemultikill(inflictor, meansofdeath, victim, attacker, scoreevents, effect.var_3d1ed4bd, weapon, effect, time);
    }
  }
}

function_f7f7b14e(data) {
  inflictor = data.einflictor;
  victim = data.victim;
  attacker = data.attacker;
  meansofdeath = data.smeansofdeath;

  if(!isplayer(attacker)) {
    return;
  }

  time = data.time;

  if(!isDefined(time)) {
    time = gettime();
  }

  weapon = level.weaponnone;

  if(isDefined(data.weapon)) {
    weapon = data.weapon;
  }

  if(isarray(level.specweapons)) {
    foreach(var_25f92d1d in level.specweapons) {
      if(isDefined(var_25f92d1d.kill_callback)) {
        specweapon = var_25f92d1d.weapon;
        var_b6f366b = function_3cbc4c6c(specweapon.var_2e4a8800);
        attacker updatemultikill(inflictor, meansofdeath, victim, attacker, var_b6f366b, specweapon, weapon, specweapon, time);
      }
    }
  }

  attacker thread function_24d66e59(inflictor, meansofdeath, victim, attacker, weapon, data.var_bd10969, time);

  if(isDefined(data.victimweapon)) {
    var_3d2a11cf = function_3cbc4c6c(data.victimweapon.var_2e4a8800);

    if(data.victimweapon.issignatureweapon) {
      attacker activecamo::function_896ac347(weapon, #"showstopper", 1);
    }
  }

  if(!isDefined(var_3d2a11cf) && isDefined(victim.heroability) && isDefined(victim.heroabilityactivatetime) && victim.heroabilityactivatetime + 700 > time) {
    var_3d2a11cf = function_3cbc4c6c(victim.heroability.var_2e4a8800);
    attacker activecamo::function_896ac347(weapon, #"showstopper", 1);
  }

  if(isDefined(weapon) && isDefined(level.iskillstreakweapon)) {
    if([
        [level.iskillstreakweapon]
      ](weapon) || isDefined(weapon.statname) && [
        [level.iskillstreakweapon]
      ](getweapon(weapon.statname))) {
      weaponiskillstreak = 1;
    }
  }

  if(isDefined(var_3d2a11cf) && isDefined(var_3d2a11cf.var_3143c814) && !(isDefined(weaponiskillstreak) && weaponiskillstreak) && isDefined(attacker) && isDefined(victim) && util::function_fbce7263(attacker.team, victim.team)) {
    scoreevents::processscoreevent(var_3d2a11cf.var_3143c814, attacker, victim, weapon);
    victim.var_ad1472a2 = 1;
    attacker stats::function_dad108fa(#"stats_shutdowns", 1);
    attacker contracts::increment_contract(#"contract_mp_shutdown");
  }

  baseweapon = weapons::getbaseweapon(weapon);
  attacker updatemultikill(inflictor, meansofdeath, victim, attacker, function_3cbc4c6c(weapon.var_2e4a8800), weapon, weapon, baseweapon, time);
}

private function_d68ae402(inflictor, meansofdeath, victim, attacker, scoreevents, weapon, var_f801f37e, time) {
  level endon(#"game_ended");
  var_ac4c1 = var_f801f37e.name;
  attacker notify(var_ac4c1 + "MultiKillScore");
  attacker endon(var_ac4c1 + "MultiKillScore", #"disconnect");

  if(inflictor.var_a6b00192 >= 3 && !(isDefined(inflictor.var_7fff4605) ? inflictor.var_7fff4605 : 0)) {
    if(isDefined(scoreevents) && isDefined(scoreevents.var_db750037)) {
      scoreevents::processscoreevent(scoreevents.var_db750037, attacker, undefined, weapon);
    }

    inflictor.var_7fff4605 = 1;
  }

  if(var_ac4c1 == #"frag_grenade" || var_ac4c1 == #"eq_molotov" || var_ac4c1 == #"hatchet") {
    attacker contracts::increment_contract(#"hash_3ffc3d28289d21bb");

    if(var_ac4c1 == #"eq_molotov") {
      attacker contracts::increment_contract(#"contract_mp_molotov_kill");
    }
  }

  if(!isDefined(attacker.multikills) || !isDefined(attacker.multikills[var_ac4c1])) {
    return;
  }

  waitresult = attacker waittilltimeout(4, #"death", #"team_changed");

  if(var_ac4c1 == #"frag_grenade" || var_ac4c1 == #"eq_molotov" || var_ac4c1 == #"hatchet") {
    if(attacker.multikills[var_ac4c1].kills >= 2) {
      if(!isDefined(attacker.pers[#"hash_52e978325c91fe24"])) {
        attacker.pers[#"hash_52e978325c91fe24"] = 0;
      }

      attacker.pers[#"hash_52e978325c91fe24"]++;

      if(attacker.pers[#"hash_52e978325c91fe24"] % 2 == 0) {
        attacker stats::function_dad108fa(#"hash_52e978325c91fe24", 1);
      }
    }
  }

  if(var_ac4c1 == #"frag_grenade") {
    if(attacker.multikills[var_ac4c1].kills >= 2) {
      attacker contracts::increment_contract(#"hash_6696408f54c6ada7");
    }
  }

  if(var_ac4c1 == #"eq_molotov") {
    if(attacker.multikills[var_ac4c1].kills >= 2) {
      attacker contracts::increment_contract(#"hash_4a7d49c14e026e91");
    }
  }

  if(isDefined(scoreevents)) {
    switch (isDefined(attacker.multikills[var_ac4c1].kills) ? attacker.multikills[var_ac4c1].kills : 0) {
      case 0:
      case 1:
        break;
      case 2:
        if(isDefined(scoreevents.var_d58bd0e9)) {
          scoreevents::processscoreevent(scoreevents.var_d58bd0e9, attacker, victim, weapon);
        }

        break;
      case 3:
        if(isDefined(scoreevents.var_6643c0a0)) {
          scoreevents::processscoreevent(scoreevents.var_6643c0a0, attacker, victim, weapon);
        }

        break;
      case 4:
        if(isDefined(scoreevents.var_16abf654)) {
          scoreevents::processscoreevent(scoreevents.var_16abf654, attacker, victim, weapon);
        }

        break;
      case 5:
        if(isDefined(scoreevents.var_1b8b6771)) {
          scoreevents::processscoreevent(scoreevents.var_1b8b6771, attacker, victim, weapon);
        }

        break;
      default:
        if(attacker.multikills[var_ac4c1].kills > 5 && isDefined(scoreevents.var_67b4a761)) {
          scoreevents::processscoreevent(scoreevents.var_67b4a761, attacker, victim, weapon);
        }

        break;
    }

    if((isDefined(attacker.multikills[var_ac4c1].kills) ? attacker.multikills[var_ac4c1].kills : 0) >= 2) {
      attacker specialistmedalachievement(weapon, scoreevents);
    }
  }

  attacker.multikills[var_ac4c1].kills = 0;

  switch (isDefined(attacker.multikills[var_ac4c1].objectivekills) ? attacker.multikills[var_ac4c1].objectivekills : 0) {
    case 0:
    case 1:
    case 2:
      break;
    default:
      if(attacker.multikills[var_ac4c1].objectivekills > 2) {
        if(isDefined(scoreevents) && isDefined(scoreevents.var_3655354)) {
          scoreevents::processscoreevent(scoreevents.var_3655354, attacker, undefined, weapon);
        }

        if(isDefined(attacker.multikills[var_ac4c1].var_d6089e48) ? attacker.multikills[var_ac4c1].var_d6089e48 : 0) {
          if(isDefined(scoreevents) && isDefined(scoreevents.var_7b590f90)) {
            scoreevents::processscoreevent(scoreevents.var_7b590f90, attacker, undefined, weapon);
            attacker.multikills[var_ac4c1].var_d6089e48 = 0;
          }

          if(isarray(level.specweapons)) {
            foreach(var_25f92d1d in level.specweapons) {
              if(isDefined(var_25f92d1d.var_34f2424e)) {
                [
                  [var_25f92d1d.var_34f2424e]
                ](attacker, time, weapon, var_25f92d1d.weapon);
              }
            }
          }
        }
      }

      break;
  }

  attacker.multikills[var_ac4c1].objectivekills = 0;
}

private updatemultikill(inflictor, meansofdeath, victim, attacker, scoreevents, weapon, attackerweapon, var_f801f37e, time) {
  self function_662aaa65(var_f801f37e);

  if(!isDefined(inflictor)) {
    inflictor = attacker;
  }

  if(isDefined(level.specweapons) && isDefined(level.specweapons[var_f801f37e.name]) && isDefined(level.specweapons[var_f801f37e.name].kill_callback)) {
    if(![
        [level.specweapons[var_f801f37e.name].kill_callback]
      ](self, victim, weapon, attackerweapon, meansofdeath)) {
      return;
    }
  }

  if(isarray(level.specweapons)) {
    foreach(var_25f92d1d in level.specweapons) {
      if(isDefined(var_25f92d1d.var_90e3cfd7)) {
        [
          [var_25f92d1d.var_90e3cfd7]
        ](attacker, time, weapon, var_25f92d1d.weapon, isDefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0);
      }
    }
  }

  if(isDefined(scoreevents) && isDefined(scoreevents.var_2ecceeab) && (!(isDefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0) || !isDefined(scoreevents.var_8600aca4))) {
    scoreevents::processscoreevent(scoreevents.var_2ecceeab, attacker, victim, weapon);
  }

  attacker function_8279d8bf(weapon, scoreevents);

  if(isDefined(scoreevents) && isDefined(scoreevents.var_2892e164) || isDefined(level.specweapons) && isDefined(level.specweapons[var_f801f37e.name]) && isDefined(level.specweapons[var_f801f37e.name].var_ec2a6a4c)) {
    if(level.teambased && isDefined(victim) && isDefined(victim.damagedplayers)) {
      foreach(entitydamaged in victim.damagedplayers) {
        if(!isDefined(entitydamaged.entity) || entitydamaged.entity == attacker || attacker util::isenemyplayer(entitydamaged.entity) || !isDefined(entitydamaged.time)) {
          continue;
        }

        if(time - entitydamaged.time < 1000) {
          if(isDefined(level.specweapons) && isDefined(level.specweapons[var_f801f37e.name]) && isDefined(level.specweapons[var_f801f37e.name].var_ec2a6a4c)) {
            [
              [level.specweapons[var_f801f37e.name].var_ec2a6a4c]
            ](attacker, victim, entitydamaged.entity, time, weapon, level.specweapons[var_f801f37e.name].weapon);
          }

          if(isDefined(scoreevents) && isDefined(scoreevents.var_2892e164)) {
            scoreevents::processscoreevent(scoreevents.var_2892e164, attacker, victim, weapon);
          }
        }
      }
    }
  }

  self.multikills[var_f801f37e.name].kills++;

  if(!isDefined(inflictor.var_a6b00192)) {
    inflictor.var_a6b00192 = 0;
  }

  inflictor.var_a6b00192++;
  self thread function_d68ae402(inflictor, meansofdeath, victim, self, scoreevents, weapon, var_f801f37e, time);
}

specialistmedalachievement(weapon, scoreevents) {
  if(!sessionmodeismultiplayergame() || !level.rankedmatch || level.disablestattracking || !isDefined(self) || !isplayer(self) || !isDefined(weapon)) {
    return;
  }

  if(!isDefined(scoreevents)) {
    scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
  }

  var_e716a62e = 0;
  baseweapon = weapons::getbaseweapon(weapon);

  if(isDefined(baseweapon.issignatureweapon) && baseweapon.issignatureweapon) {
    var_e716a62e += self stats::get_stat_global(#"stats_battle_shield_x2_multikill_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_war_machine_x2_multikill_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_tak5_multikill_x2_multikill_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_purifier_x2_multikill_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_attack_dog_x2_multikill_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_tempest_x2_multikill_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_vision_pulse_x2_multikill_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_gravity_slam_multikill_x2");
    var_e716a62e += self stats::get_stat_global(#"stats_annihilator_x2_multikill_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_deployable_cover_x2_multikill_summary");

    if(var_e716a62e >= 10) {
      self giveachievement("mp_trophy_special_issue_weaponry");
    }

    return;
  }

  if(isDefined(baseweapon.var_76ce72e8) && baseweapon.var_76ce72e8 && isDefined(scoreevents) && isDefined(scoreevents.var_fcd2ff3a) && scoreevents.var_fcd2ff3a) {
    var_e716a62e += self stats::get_stat_global(#"stats_swat_grenade_multikill_x2_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_cluster_semtex_multikill_x2_summary");
    var_e716a62e += self stats::get_stat_global(#"hash_3427f2d4181d570");
    var_e716a62e += self stats::get_stat_global(#"stats_radiation_field_multikill_x2_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_tripwire_ied_multikill_x2_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_seeker_shock_mine_paralyzed_headshot");
    var_e716a62e += self stats::get_stat_global(#"stats_sensor_dart_multikill_x2_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_grapple_gun_multikill_x2_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_spawn_beacon_multikill_x2_summary");
    var_e716a62e += self stats::get_stat_global(#"stats_concertina_wire_multikill_x2_summary");

    if(var_e716a62e >= 10) {
      self giveachievement("mp_trophy_special_issue_equipment");
    }
  }
}

function_8279d8bf(weapon, scoreevents) {
  if(sessionmodeiswarzonegame()) {
    return;
  }

  equipment = self loadout::function_18a77b37("primarygrenade");
  ability = self loadout::function_18a77b37("specialgrenade");
  baseweapon = weapons::getbaseweapon(weapon);

  if(isDefined(ability) && baseweapon.issignatureweapon === 1) {
    self function_be7a08a8(ability, 1);
    return;
  }

  if(isDefined(equipment) && isDefined(scoreevents) && baseweapon.var_76ce72e8 === 1 && scoreevents.var_fcd2ff3a === 1) {
    self function_be7a08a8(equipment, 1);
  }
}

function_662aaa65(var_f801f37e) {
  if(!isDefined(self.multikills)) {
    self.multikills = [];
  }

  if(isDefined(var_f801f37e) && !isDefined(self.multikills[var_f801f37e.name])) {
    struct = spawnStruct();
    struct.kills = 0;
    struct.objectivekills = 0;
    self.multikills[var_f801f37e.name] = struct;
  }
}

function_1f9441d7(weapon) {
  if(!isDefined(level.specweapons)) {
    level.specweapons = [];
  }

  if(!isDefined(level.specweapons[weapon.name])) {
    level.specweapons[weapon.name] = spawnStruct();
  }

  if(!isDefined(level.specweapons[weapon.name].weapon)) {
    level.specweapons[weapon.name].weapon = weapon;
  }
}

register_kill_callback(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].kill_callback = callback;
}

function_a458dbe1(status_effect_name, callback) {
  if(!isDefined(level.var_f19c99e1)) {
    level.var_f19c99e1 = [];
  }

  if(!isDefined(level.var_f19c99e1[status_effect_name])) {
    level.var_f19c99e1[status_effect_name] = spawnStruct();
  }

  level.var_f19c99e1[status_effect_name].kill_callback = callback;
}

function_86f90713(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_37850de1 = callback;
}

function_82fb1afa(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_d20c7012 = callback;
}

function_2b2c09db(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_ec2a6a4c = callback;
}

function_5b0c227a(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_34f2424e = callback;
}

function_b150f9ac(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_826b85e7 = callback;
}

function_c1e9b86b(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_90e3cfd7 = callback;
}

function_d3ca3608(eventname) {
  assert(isDefined(eventname));

  if(!isDefined(level.scoreinfo[eventname]) || !isDefined(self) || !isplayer(self)) {
    return;
  }

  if(getdvarint(#"logscoreevents", 0) > 0) {
    if(!isDefined(level.var_10cd7193)) {
      level.var_10cd7193 = [];
    }

    eventstr = ishash(eventname) ? function_9e72a96(eventname) : eventname;

    if(!isDefined(level.var_10cd7193)) {
      level.var_10cd7193 = [];
    } else if(!isarray(level.var_10cd7193)) {
      level.var_10cd7193 = array(level.var_10cd7193);
    }

    level.var_10cd7193[level.var_10cd7193.size] = eventstr;
  }

    eventindex = level.scoreinfo[eventname][#"row"];
}

function_61254438(weapon) {
  var_8725a10d = function_3cbc4c6c(weapon.var_2e4a8800);

  if(!isDefined(var_8725a10d) || !isDefined(var_8725a10d.var_14d1d5a1)) {
    return;
  }

  self function_d3ca3608(var_8725a10d.var_14d1d5a1);
}

allow_old_indexs(var_8d498080) {
  var_8725a10d = function_3cbc4c6c(var_8d498080.var_2e4a8800);

  if(!isDefined(var_8725a10d) || !isDefined(var_8725a10d.var_14d1d5a1)) {
    return;
  }

  self function_d3ca3608(var_8725a10d.var_14d1d5a1);
}

function_bb9f3842() {
  level endon(#"game_ended");

  if(!isDefined(level.var_10cd7193)) {
    level.var_10cd7193 = [];
  }

  while(true) {
    if(getdvarint(#"dumpscoreevents", 0) > 0) {
      var_594354f3 = [];

      foreach(scoreevent in level.var_10cd7193) {
        if(!isDefined(var_594354f3[scoreevent])) {
          var_594354f3[scoreevent] = 0;
        }

        var_594354f3[scoreevent]++;
      }

      println("<dev string:x74>");

      foreach(var_d975dd49 in getarraykeys(var_594354f3)) {
        count = var_594354f3[var_d975dd49];
        println(var_d975dd49 + "<dev string:xc9>" + (isDefined(count) ? "<dev string:xce>" + count : "<dev string:xce>"));
      }

      println("<dev string:xd1>");
      setdvar(#"dumpscoreevents", 0);
    }

    waitframe(1);
  }
}

