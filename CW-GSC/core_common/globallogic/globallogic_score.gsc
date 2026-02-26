/*********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\globallogic\globallogic_score.gsc
*********************************************************/

#using script_7f6cd71c43c45c57;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\weapon_utils;
#namespace globallogic_score;

function private autoexec __init__system__() {
  system::register(#"globallogic_score", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
  callback::on_spawned(&playerspawn);

  setDvar(#"logscoreevents", 0);
  setDvar(#"dumpscoreevents", 0);
  thread function_bb9f3842();
}

function init() {
  level.var_e0582de1 = [];
  scoreevents::registerscoreeventcallback("playerKilled", &function_f7f7b14e);
  scoreevents::function_9677601b("playerKilled", &function_1a0fa609);
  level.capturedobjectivefunction = &function_eced93f5;
}

function playerspawn() {
  self.var_60a9eae7 = 0;
  self.var_a6b00192 = 0;
  self.var_7fff4605 = 0;
  self callback::on_weapon_change(&on_weapon_change);
  self callback::on_weapon_fired(&on_weapon_fired);
  self callback::on_grenade_fired(&on_grenade_fired);
}

function private on_weapon_change(params) {
  self.var_a6b00192 = 0;
  self.var_7fff4605 = 0;
}

function private on_weapon_fired(params) {
  self function_5aa55c0a(params.weapon);
}

function private function_f0d51d49(projectile, weapon) {
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

function private on_grenade_fired(params) {
  weapon = params.weapon;

  if(!isDefined(weapon.var_2e4a8800)) {
    return;
  }

  self function_5aa55c0a(weapon);
  self thread function_f0d51d49(params.projectile, weapon);
}

function function_5aa55c0a(weapon) {
  if(isDefined(weapon.var_2e4a8800)) {
    scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
  }

  if(!isDefined(scoreevents)) {
    return;
  }

  if(isDefined(scoreevents.var_7ecee77b)) {
    scoreevents::processscoreevent(scoreevents.var_7ecee77b, self, undefined, weapon);
  }
}

function inctotalkills(team) {
  if(level.teambased && isDefined(level.teams[team])) {
    game.totalkillsteam[team]++;
  }

  game.totalkills++;
}

function givekillstats(smeansofdeath, weapon, evictim) {
  if(isDefined(level.scoreevents_givekillstats)) {
    [[level.scoreevents_givekillstats]](smeansofdeath, weapon, evictim);
  }
}

function function_969ea48d(var_ba01256c, weapon) {
  if(!isDefined(var_ba01256c)) {
    return;
  }

  scoreevents = function_3cbc4c6c(var_ba01256c.var_2e4a8800);

  if(!isDefined(scoreevents.var_1253685d)) {
    return;
  }

  scoreevents::processscoreevent(scoreevents.var_1253685d, self, undefined, weapon);
}

function processassist(killedplayer, damagedone, weapon, assist_level = undefined, time = gettime(), meansofdeath = "MOD_UNKNOWN") {
  waitframe(1);
  util::waittillslowprocessallowed();

  if(!isPlayer(self) || !isPlayer(killedplayer) || !isDefined(weapon)) {
    return;
  }

  if(isarray(level.specweapons)) {
    foreach(var_25f92d1d in level.specweapons) {
      if(var_25f92d1d.var_358571b4 !== 1) {
        self function_b78294bf(killedplayer, var_25f92d1d.weapon, weapon, var_25f92d1d, time, meansofdeath);
      }
    }
  }

  self function_b78294bf(killedplayer, weapon, weapon, undefined, time, meansofdeath);

  if(isDefined(level.scoreevents_processassist)) {
    self[[level.scoreevents_processassist]](killedplayer, damagedone, weapon, assist_level);
  }
}

function private function_b78294bf(victim, weapon, attackerweapon, var_67660cb2, time, meansofdeath) {
  scoreevents = function_3cbc4c6c(attackerweapon.var_2e4a8800);

  if((isDefined(weapon.var_60a9eae7) ? weapon.var_60a9eae7 : 0) && isDefined(scoreevents.var_a6bfdc5f)) {
    if(isDefined(time)) {
      if(!isDefined(time.var_37850de1) || ![[time.var_37850de1]](self, weapon, attackerweapon, var_67660cb2)) {
        return;
      }
    }

    self function_662aaa65(attackerweapon);
    self.multikills[attackerweapon.name].objectivekills++;

    if(isDefined(scoreevents.var_a6bfdc5f)) {
      scoreevents::processscoreevent(scoreevents.var_a6bfdc5f, self, weapon, attackerweapon);
    }
  } else {
    if(isDefined(time)) {
      if(!isDefined(time.kill_callback) || ![[time.kill_callback]](self, weapon, attackerweapon, var_67660cb2, meansofdeath)) {
        return;
      }
    }

    if(isDefined(scoreevents.var_170b3630)) {
      scoreevents::processscoreevent(scoreevents.var_170b3630, self, weapon, attackerweapon);
    }
  }

  function_bac4b0de(scoreevents, attackerweapon);
}

function function_5829abe3(attacker, weapon, var_651b6171) {
  if(!isDefined(self) || !isDefined(var_651b6171) || !isPlayer(attacker)) {
    return;
  }

  if(!isDefined(weapon)) {
    weapon = level.weaponnone;
  }

  attacker challenges::function_24db0c33(weapon, var_651b6171);

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    if(isPlayer(attacker)) {
      attacker stats::function_a431be09(weapon);
    }
  }

  if(isDefined(level.iskillstreakweapon)) {
    if([[level.iskillstreakweapon]](weapon) || isDefined(weapon.statname) && [[level.iskillstreakweapon]](getweapon(weapon.statname))) {
      weaponiskillstreak = 1;
    }

    if([[level.iskillstreakweapon]](var_651b6171)) {
      destroyedkillstreak = 1;
    }
  }

  var_3c727edf = function_3cbc4c6c(var_651b6171.var_2e4a8800);

  if((var_651b6171.var_62c1bfaa === 1 || !is_true(weaponiskillstreak) || is_true(destroyedkillstreak)) && isDefined(var_3c727edf.var_3143c814) && util::function_fbce7263(attacker.team, self.team)) {
    scoreevents::processscoreevent(var_3c727edf.var_3143c814, attacker, self, var_651b6171);
    attacker stats::function_dad108fa(#"stats_destructions", 1);
  }

  if(var_651b6171.issignatureweapon) {
    attacker activecamo::function_896ac347(weapon, #"showstopper", 1);
  }

  scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);

  if(isDefined(scoreevents.var_84eddb70)) {
    scoreevents::processscoreevent(scoreevents.var_84eddb70, attacker, self, weapon);
  }
}

function function_a890cac2(attacker, owningteam, weapon, scoreevents, objectiveobj) {
  attacker function_662aaa65(weapon);
  attacker.multikills[weapon.name].objectivekills++;

  if(level.teambased && isDefined(owningteam) && attacker.team == owningteam) {
    if(isDefined(level.specweapons[weapon.name].var_826b85e7)) {
      [[level.specweapons[weapon.name].var_826b85e7]](attacker, self, weapon, objectiveobj);
    }

    if(isDefined(scoreevents.var_867de225)) {
      scoreevents::processscoreevent(scoreevents.var_867de225, attacker, self, weapon);
    }

    if((isDefined(attacker.multikills[weapon.name].objectivekills) ? attacker.multikills[weapon.name].objectivekills : 0) > 2 && (isDefined(objectiveobj.var_4e02c9bd) ? objectiveobj.var_4e02c9bd : 0) < gettime()) {
      enemies = attacker getenemies();
      var_f6612539 = 0;

      foreach(enemy in enemies) {
        if(enemy istouching(objectiveobj)) {
          var_f6612539 = 1;
          break;
        }
      }

      if(!var_f6612539) {
        objectiveobj.var_4e02c9bd = gettime() + 4000;
        attacker.multikills[weapon.name].var_d6089e48 = 1;
      }
    }
  }

  if(isDefined(scoreevents.var_8600aca4)) {
    scoreevents::processscoreevent(scoreevents.var_8600aca4, attacker, self, weapon);
  }
}

function function_2e33e275(einflictor, attacker, weapon, var_5b1d28ec) {
  if(!isPlayer(attacker) || !isPlayer(self) || !isDefined(weapon) || !isDefined(var_5b1d28ec)) {
    return false;
  }

  if(!self istouching(var_5b1d28ec)) {
    if(!isDefined(einflictor) || einflictor != attacker || !attacker istouching(var_5b1d28ec)) {
      return false;
    }
  }

  return true;
}

function function_7d830bc(einflictor, attacker, weapon, var_5b1d28ec, owningteam) {
  attacker endon(#"disconnect", #"death");
  level endon(#"game_ended");
  self notify("1a696f65f272be70");
  self endon("1a696f65f272be70");
  self.var_60a9eae7 = 1;
  attacker.var_f46a73a1 = weapon;
  attacker.var_60f43bac = gettime();
  attacker.var_e3d30669 = var_5b1d28ec;
  scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
  self function_a890cac2(attacker, owningteam, weapon, scoreevents, var_5b1d28ec);

  if(isarray(level.specweapons)) {
    foreach(var_25f92d1d in level.specweapons) {
      if(!isDefined(var_25f92d1d.var_37850de1) || ![[var_25f92d1d.var_37850de1]](attacker, self, var_25f92d1d.weapon, weapon)) {
        continue;
      }

      var_bbe53115 = function_3cbc4c6c(var_25f92d1d.weapon.var_2e4a8800);
      self function_a890cac2(attacker, owningteam, var_25f92d1d.weapon, var_bbe53115, var_5b1d28ec);
    }
  }
}

function private function_eced93f5(objective, var_c217216c) {
  if(!isDefined(objective) || !isDefined(var_c217216c) || !isDefined(self.var_f46a73a1) || !isDefined(self.var_60f43bac) || !isDefined(self.var_e3d30669)) {
    return;
  }

  if(var_c217216c - self.var_60f43bac > int(20 * 1000) || objective != self.var_e3d30669) {
    return;
  }

  if(isarray(level.specweapons)) {
    foreach(specialweapon in level.specweapons) {
      if(isDefined(specialweapon.var_d20c7012)) {
        [[specialweapon.var_d20c7012]](self, self.var_f46a73a1, self.var_60f43bac, self.var_e3d30669, specialweapon.weapon);
      }
    }
  }

  scoreevents = function_3cbc4c6c(self.var_f46a73a1.var_2e4a8800);

  if(isDefined(scoreevents.var_1d0ab0f4)) {
    scoreevents::processscoreevent(scoreevents.var_1d0ab0f4, self, undefined, self.var_f46a73a1);
  }
}

function function_3cbc4c6c(scriptbundle) {
  if(!isDefined(scriptbundle)) {
    return;
  }

  if(!isDefined(level.var_e0582de1[scriptbundle])) {
    level.var_e0582de1[scriptbundle] = getscriptbundle(scriptbundle);
  }

  return level.var_e0582de1[scriptbundle];
}

function function_24d66e59(inflictor, meansofdeath, victim, attacker, weapon, var_bd10969, time, data) {
  if(!isDefined(var_bd10969) || !isarray(var_bd10969)) {
    return;
  }

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

    var_183358be = 0;

    if((isDefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0) && (isDefined(scoreevents.var_a6bfdc5f) || isDefined(scoreevents.var_8600aca4))) {
      attacker function_662aaa65(effect);
      attacker.multikills[effect.name].objectivekills++;

      if(isDefined(effect.var_4b22e697) && isPlayer(effect.var_4b22e697) && attacker != effect.var_4b22e697) {
        if(isDefined(scoreevents.var_a6bfdc5f)) {
          scoreevents::processscoreevent(scoreevents.var_a6bfdc5f, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
        }

        var_183358be = 1;
      } else if(isDefined(scoreevents.var_8600aca4)) {
        scoreevents::processscoreevent(scoreevents.var_8600aca4, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
      }
    } else if(isDefined(effect.var_4b22e697) && isPlayer(effect.var_4b22e697) && attacker != effect.var_4b22e697 && attacker util::isenemyplayer(effect.var_4b22e697) == 0) {
      baseweapon = weapons::getbaseweapon(weapon);

      if(isDefined(scoreevents.var_2eaed769) && (is_true(baseweapon.issignatureweapon) || is_true(baseweapon.var_76ce72e8))) {
        scoreevents::processscoreevent(scoreevents.var_2eaed769, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
      } else if(isDefined(scoreevents.var_170b3630)) {
        scoreevents::processscoreevent(scoreevents.var_170b3630, effect.var_4b22e697, victim, effect.var_3d1ed4bd);

        switch (scoreevents.var_170b3630) {
          case # "hash_24b1201b633590c4":
          case # "hash_55c0e2f8f8f4f342":
            if(isDefined(level.var_b7bc3c75.var_e2298731)) {
              effect.var_4b22e697[[level.var_b7bc3c75.var_e2298731]]();
            }

            break;
        }
      }

      if(isDefined(level.var_f19c99e1[effect.name].var_f3f9124b) && isPlayer(effect.var_4b22e697)) {
        effect.var_4b22e697[[level.var_f19c99e1[effect.name].var_f3f9124b]](self, victim, effect.var_3d1ed4bd, weapon, meansofdeath, effect.var_b5bddaea);
      }

      var_183358be = 1;
    }

    if(var_183358be) {
      effect.var_4b22e697 function_bac4b0de(scoreevents, effect.var_3d1ed4bd);
    }

    if(attacker == effect.var_4b22e697) {
      if(isDefined(level.var_f19c99e1[effect.name].kill_callback)) {
        if(![[level.var_f19c99e1[effect.name].kill_callback]](self, victim, effect.var_3d1ed4bd, weapon, meansofdeath, effect.var_b5bddaea)) {
          return;
        }
      }

      updatemultikill(inflictor, meansofdeath, victim, attacker, scoreevents, effect.var_3d1ed4bd, weapon, effect, time, data);
    }
  }
}

function function_f7f7b14e(data) {
  profilestart();
  inflictor = data.einflictor;
  victim = data.victim;
  attacker = data.attacker;
  meansofdeath = data.smeansofdeath;

  if(!isPlayer(attacker)) {
    profilestop();
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
      if(isDefined(var_25f92d1d.kill_callback) && var_25f92d1d.var_358571b4 !== 1) {
        specweapon = var_25f92d1d.weapon;
        var_b6f366b = function_3cbc4c6c(specweapon.var_2e4a8800);
        attacker updatemultikill(inflictor, meansofdeath, victim, attacker, var_b6f366b, specweapon, weapon, specweapon, time, data);
      }
    }
  }

  attacker function_24d66e59(inflictor, meansofdeath, victim, attacker, weapon, data.var_bd10969, time, data);

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
    if([[level.iskillstreakweapon]](weapon) || isDefined(weapon.statname) && [[level.iskillstreakweapon]](getweapon(weapon.statname))) {
      weaponiskillstreak = 1;
    }
  }

  if(isDefined(var_3d2a11cf.var_3143c814) && !is_true(weaponiskillstreak) && isDefined(attacker) && isDefined(victim) && util::function_fbce7263(attacker.team, victim.team)) {
    scoreevents::processscoreevent(var_3d2a11cf.var_3143c814, attacker, victim, weapon);
    victim.var_ad1472a2 = 1;
    attacker stats::function_dad108fa(#"stats_shutdowns", 1);
    attacker contracts::increment_contract(#"contract_mp_shutdown");
  }

  baseweapon = weapons::getbaseweapon(weapon);
  attacker updatemultikill(inflictor, meansofdeath, victim, attacker, function_3cbc4c6c(weapon.var_2e4a8800), weapon, weapon, baseweapon, time, data);

  if(weapons::ismeleemod(meansofdeath)) {
    scoreevents::function_2a2e1723(#"melee_kill", attacker, self, weapon);
    data.var_7b4d33ac = 1;
  }

  function_706caaf3(meansofdeath, attacker, victim, weapon);
  profilestop();
}

function function_706caaf3(meansofdeath, var_38e70910, victim, weapon) {
  if(meansofdeath == "MOD_EXECUTION") {
    scoreevents::processscoreevent(#"hash_21b62e7a039a069f", var_38e70910, victim);
    var_38e70910 contracts::increment_contract(#"hash_ba2b17c3904e2d6");
    var_38e70910 challenges::function_38ad2427(#"hash_7397ba07e9e0325d", 1);
    var_38e70910 stats::function_dad108fa(#"hash_723bd70b9a80a581", 1);
    var_38e70910 stats::function_dad108fa(#"hash_1a31e9546b33c22d", 1);
    var_38e70910 stats::function_dad108fa(#"hash_26ab65b8fbfeab28", 1);
    var_38e70910 stats::function_dad108fa(#"hash_52b5cb629bbde814", 1);

    if(isDefined(weapon) && weapon != level.weaponnone) {
      var_38e70910 stats::function_e24eec31(weapon, #"hash_21b62e7a039a069f", 1);

      if(!isDefined(var_38e70910.pers[#"hash_33dcd1468cbdb9c2"])) {
        var_38e70910.pers[#"hash_33dcd1468cbdb9c2"] = 0;
      }

      var_38e70910.pers[#"hash_33dcd1468cbdb9c2"]++;

      if(var_38e70910.pers[#"hash_33dcd1468cbdb9c2"] == 2) {
        var_38e70910 stats::function_d0de7686(#"hash_2dc09a051d45038d", 1, #"hash_653135ec012bf674");
      }
    }
  }
}

function private function_1a0fa609(data) {
  attacker = data.attacker;

  if(!isPlayer(attacker)) {
    return;
  }

  if(data.var_7b4d33ac !== 1) {
    victim = data.victim;
    weapon = isDefined(data.weapon) ? data.weapon : level.weaponnone;
    scoreevents::processscoreevent(#"ekia", attacker, victim, weapon);
    data.var_7b4d33ac = 1;
  }
}

function private function_d68ae402(inflictor, meansofdeath, victim, attacker, scoreevents, weapon, var_f801f37e, time) {
  level endon(#"game_ended");
  var_ac4c1 = var_f801f37e.name;
  attacker notify(var_ac4c1 + "MultiKillScore");
  attacker endon(var_ac4c1 + "MultiKillScore", #"disconnect");

  if(meansofdeath.var_a6b00192 >= 3 && !(isDefined(meansofdeath.var_7fff4605) ? meansofdeath.var_7fff4605 : 0)) {
    if(isDefined(scoreevents.var_db750037)) {
      scoreevents::processscoreevent(scoreevents.var_db750037, attacker, undefined, weapon);
    }

    meansofdeath.var_7fff4605 = 1;
  }

  if(!isDefined(attacker.multikills[var_ac4c1])) {
    return;
  }

  if(attacker.multikills[var_ac4c1].kills % 2 == 0) {
    attacker contracts::player_contract_event(#"double_kill", var_ac4c1);
  }

  waitresult = attacker waittilltimeout(4, #"death", #"team_changed");

  if(attacker.multikills[var_ac4c1].kills >= 2) {
    if(var_ac4c1 == # "frag_grenade" || var_ac4c1 == # "eq_molotov" || var_ac4c1 == # "hatchet") {
      if(!isDefined(attacker.pers[#"hash_52e978325c91fe24"])) {
        attacker.pers[#"hash_52e978325c91fe24"] = 0;
      }

      attacker.pers[#"hash_52e978325c91fe24"]++;

      if(attacker.pers[#"hash_52e978325c91fe24"] % 2 == 0) {
        attacker stats::function_dad108fa(#"hash_52e978325c91fe24", 1);
      }
    } else if(var_ac4c1 == # "nightingale") {
      attacker contracts::increment_contract(#"hash_7ce05509f5b3e35");
    }
  }

  attacker function_84088ec3(var_f801f37e);

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
  }

  attacker.multikills[var_ac4c1].kills = 0;

  switch (isDefined(attacker.multikills[var_ac4c1].objectivekills) ? attacker.multikills[var_ac4c1].objectivekills : 0) {
    case 0:
    case 1:
    case 2:
      break;
    default:
      if(attacker.multikills[var_ac4c1].objectivekills > 2) {
        if(isDefined(scoreevents.var_3655354)) {
          scoreevents::processscoreevent(scoreevents.var_3655354, attacker, undefined, weapon);
        }

        if(isDefined(attacker.multikills[var_ac4c1].var_d6089e48) ? attacker.multikills[var_ac4c1].var_d6089e48 : 0) {
          if(isDefined(scoreevents.var_7b590f90)) {
            scoreevents::processscoreevent(scoreevents.var_7b590f90, attacker, undefined, weapon);
            attacker.multikills[var_ac4c1].var_d6089e48 = 0;
          }

          if(isarray(level.specweapons)) {
            foreach(var_25f92d1d in level.specweapons) {
              if(isDefined(var_25f92d1d.var_34f2424e)) {
                [[var_25f92d1d.var_34f2424e]](attacker, time, weapon, var_25f92d1d.weapon);
              }
            }
          }
        }
      }

      break;
  }

  attacker.multikills[var_ac4c1].objectivekills = 0;
}

function private updatemultikill(inflictor, meansofdeath, victim, attacker, scoreevents, weapon, attackerweapon, var_f801f37e, time, data) {
  self function_662aaa65(var_f801f37e);

  if(!isDefined(inflictor)) {
    inflictor = attacker;
  }

  var_25f92d1d = level.specweapons[var_f801f37e.name];

  if(isDefined(var_25f92d1d.kill_callback)) {
    if(![[level.specweapons[var_f801f37e.name].kill_callback]](self, victim, weapon, attackerweapon, meansofdeath)) {
      return;
    }

    if(isDefined(var_25f92d1d.var_90e3cfd7)) {
      params = {
        #attacker: attacker, #attackerweapon: attackerweapon, #meansofdeath: meansofdeath
      };
      [[var_25f92d1d.var_90e3cfd7]](params);
    }
  }

  if(isDefined(scoreevents.var_2ecceeab) && (!(isDefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0) || !isDefined(scoreevents.var_8600aca4))) {
    scoreevents::function_2a2e1723(scoreevents.var_2ecceeab, attacker, victim, attackerweapon);
    data.var_7b4d33ac = scoreevents.var_6913f911 === 1;
  }

  self function_1f664cea(scoreevents, weapon, victim);

  if(isDefined(scoreevents.var_2892e164) || isDefined(var_25f92d1d.var_ec2a6a4c)) {
    if(level.teambased && isDefined(victim.damagedplayers)) {
      foreach(entitydamaged in victim.damagedplayers) {
        if(!isDefined(entitydamaged.entity) || entitydamaged.entity == attacker || attacker util::isenemyplayer(entitydamaged.entity) || !isDefined(entitydamaged.time)) {
          continue;
        }

        if(time - entitydamaged.time < 1000) {
          if(isDefined(var_25f92d1d.var_ec2a6a4c)) {
            [[var_25f92d1d.var_ec2a6a4c]](attacker, victim, entitydamaged.entity, time, weapon, var_25f92d1d.weapon);
          }

          if(isDefined(scoreevents.var_2892e164)) {
            scoreevents::processscoreevent(scoreevents.var_2892e164, attacker, victim, weapon);
          }
        }
      }
    }
  }

  self.multikills[var_f801f37e.name].kills++;

  if(isDefined(scoreevents.var_d58bd0e9) && self.multikills[var_f801f37e.name].kills > 1) {
    scoreevents::function_644d867a(self, time, scoreevents.var_d58bd0e9 + "_nostat");
  }

  if(!isDefined(inflictor.var_a6b00192)) {
    inflictor.var_a6b00192 = 0;
  }

  inflictor.var_a6b00192++;
  self thread function_d68ae402(inflictor, meansofdeath, victim, self, scoreevents, weapon, var_f801f37e, time);
}

function function_1f664cea(scoreevents, weapon, victim) {
  if(scoreevents.var_4f57d8be === 1 && (sessionmodeismultiplayergame() || sessionmodeiswarzonegame())) {
    var_ccec6846 = isDefined(scoreevents.var_c2dbdf39) ? scoreevents.var_c2dbdf39 : "kills";
    statweapon = stats::function_a2261724(weapon);
    loadout_slot_index = self loadout::function_8435f729(statweapon);

    if(loadout_slot_index === "primarygrenade" || loadout_slot_index === "secondarygrenade" || loadout_slot_index === "specialgrenade") {
      weaponname = stats::function_3f64434(statweapon);
      self stats::function_622feb0d(weaponname, var_ccec6846, 1);
      self stats::function_6fb0b113(weaponname, #"best_" + var_ccec6846);
      return;
    }

    if(isDefined(level.iskillstreakweapon) && [[level.iskillstreakweapon]](statweapon) && isDefined(level.get_killstreak_for_weapon_for_stats)) {
      killstreak = [[level.get_killstreak_for_weapon_for_stats]](statweapon);
      self stats::function_8fb23f94(killstreak, var_ccec6846, 1);
      self stats::function_b04e7184(killstreak, #"best_" + var_ccec6846);
      victim stats::function_8fb23f94(killstreak, #"deaths", 1);
      return;
    }

    self stats::function_561716e6(statweapon.name, var_ccec6846, 1);
    self stats::function_80099ca1(statweapon.name, #"best_" + var_ccec6846);
  }
}

function function_bac4b0de(scoreevents, weapon) {
  if(scoreevents.var_4f57d8be === 1 && (sessionmodeismultiplayergame() || sessionmodeiswarzonegame())) {
    var_601e335c = isDefined(scoreevents.var_f23a2b7c) ? scoreevents.var_f23a2b7c : "assists";
    statweapon = stats::function_a2261724(weapon);
    loadout_slot_index = self loadout::function_8435f729(statweapon);

    if(loadout_slot_index === "primarygrenade" || loadout_slot_index === "secondarygrenade" || loadout_slot_index === "specialgrenade") {
      weaponname = stats::function_3f64434(statweapon);
      self stats::function_622feb0d(weaponname, var_601e335c, 1);
      self stats::function_6fb0b113(weaponname, #"best_" + var_601e335c);
      return;
    }

    if(isDefined(level.iskillstreakweapon) && [[level.iskillstreakweapon]](statweapon) && isDefined(level.get_killstreak_for_weapon_for_stats)) {
      killstreak = [[level.get_killstreak_for_weapon_for_stats]](statweapon);
      self stats::function_8fb23f94(killstreak, var_601e335c, 1);
      self stats::function_b04e7184(killstreak, #"best_" + var_601e335c);
      return;
    }

    self stats::function_561716e6(statweapon.name, var_601e335c, 1);
    self stats::function_80099ca1(statweapon.name, #"best_" + var_601e335c);
  }
}

function function_84088ec3(var_f801f37e) {
  if((sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) && self.multikills[var_f801f37e.name].kills >= 2) {
    if(isweapon(var_f801f37e) && isDefined(level.iskillstreakweapon) && [[level.iskillstreakweapon]](var_f801f37e) && isDefined(level.get_killstreak_for_weapon_for_stats)) {
      killstreak = [[level.get_killstreak_for_weapon_for_stats]](var_f801f37e);
      self stats::function_8fb23f94(killstreak, #"hash_7bf29fa438d54aad", 1);
      return;
    }

    switch (var_f801f37e.name) {
      case # "gadget_supplypod":
      case # "nightingale":
      case # "frag_grenade":
      case # "land_mine":
      case # "gadget_jammer":
      case # "tear_gas":
      case # "eq_molotov":
      case # "satchel_charge":
        self stats::function_622feb0d(var_f801f37e.name, #"hash_7bf29fa438d54aad", 1);
        break;
      case # "special_grenadelauncher_t9":
        self stats::function_561716e6(var_f801f37e.name, #"multi_kills", 1);
        break;
      default:
        break;
    }
  }
}

function function_662aaa65(var_f801f37e) {
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

function function_1f9441d7(weapon) {
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

function register_kill_callback(weapon, callback, var_358571b4) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].kill_callback = callback;
  level.specweapons[weapon.name].var_358571b4 = var_358571b4;
}

function function_a458dbe1(status_effect_name, callback) {
  if(!isDefined(level.var_f19c99e1)) {
    level.var_f19c99e1 = [];
  }

  if(!isDefined(level.var_f19c99e1[status_effect_name])) {
    level.var_f19c99e1[status_effect_name] = spawnStruct();
  }

  level.var_f19c99e1[status_effect_name].kill_callback = callback;
}

function function_69c6cfcc(status_effect_name, callback) {
  if(!isDefined(level.var_f19c99e1)) {
    level.var_f19c99e1 = [];
  }

  if(!isDefined(level.var_f19c99e1[status_effect_name])) {
    level.var_f19c99e1[status_effect_name] = spawnStruct();
  }

  level.var_f19c99e1[status_effect_name].var_f3f9124b = callback;
}

function function_86f90713(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_37850de1 = callback;
}

function function_82fb1afa(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_d20c7012 = callback;
}

function function_2b2c09db(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_ec2a6a4c = callback;
}

function function_5b0c227a(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_34f2424e = callback;
}

function function_b150f9ac(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_826b85e7 = callback;
}

function function_c1e9b86b(weapon, callback) {
  function_1f9441d7(weapon);
  level.specweapons[weapon.name].var_90e3cfd7 = callback;
}

function function_d3ca3608(eventname) {
  assert(isDefined(eventname));

  if(!isDefined(level.scoreinfo[eventname]) || !isDefined(self) || !isPlayer(self)) {
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

function function_61254438(weapon) {
  var_8725a10d = function_3cbc4c6c(weapon.var_2e4a8800);

  if(!isDefined(var_8725a10d.var_14d1d5a1)) {
    return;
  }

  self function_d3ca3608(var_8725a10d.var_14d1d5a1);
}

function allow_old_indexs(var_8d498080) {
  var_8725a10d = function_3cbc4c6c(var_8d498080.var_2e4a8800);

  if(!isDefined(var_8725a10d.var_14d1d5a1)) {
    return;
  }

  self function_d3ca3608(var_8725a10d.var_14d1d5a1);
}

function function_bb9f3842() {
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

      println("<dev string:x38>");

      foreach(var_d975dd49 in getarraykeys(var_594354f3)) {
        count = var_594354f3[var_d975dd49];
        println(var_d975dd49 + "<dev string:x8e>" + (isDefined(count) ? "<dev string:x94>" + count : "<dev string:x94>"));
      }

      println("<dev string:x98>");
      setDvar(#"dumpscoreevents", 0);
    }

    waitframe(1);
  }
}