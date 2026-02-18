/**********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\globallogic\globallogic_player.gsc
**********************************************************/

#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#namespace globallogic_player;

function function_c5343206(eattacker, einflictor, idamage, smeansofdeath, weapon, shitloc) {
  if(!isPlayer(eattacker)) {
    return;
  }

  if(!isDefined(self.attackerdamage)) {
    return;
  }

  assert(isarray(self.attackerdata));
  time = gettime();

  if(self.attackerdata.size == 0) {
    self.firsttimedamaged = time;

    if(isstruct(self.var_fcfb50c6) && !self issprinting() && !self isinvehicle()) {
      self.var_14e48fb5 = structcopy(self.var_fcfb50c6);
      self.var_14e48fb5.var_c4fff679 = self getorigin();
    }
  }

  attackerclientid = eattacker.clientid;

  if(!isDefined(attackerclientid)) {
    return;
  }

  if(self.attackerdata.size == 0 || !isDefined(self.attackerdamage[attackerclientid])) {
    self.attackerdamage[attackerclientid] = {
      #damage: 0, #time: time
    };
    self.attackers[self.attackers.size] = eattacker;
    self.attackerdata[attackerclientid] = 0;
  }

  var_ca60c93e = self.attackerdamage[attackerclientid];

  if(isDefined(self.var_ea1458aa)) {
    if(!isDefined(self.var_ea1458aa.attackerdamage)) {
      self.var_ea1458aa.attackerdamage = [];
    }

    if(!isDefined(self.var_ea1458aa.attackerdamage[attackerclientid])) {
      self.var_ea1458aa.attackerdamage[attackerclientid] = spawnStruct();
    }

    var_d72bd991 = self.var_ea1458aa.attackerdamage[attackerclientid];
    var_d72bd991.meansofdeath = smeansofdeath;
    var_d72bd991.idflags = self.idflags;
    var_d72bd991.isads = eattacker playerads();
    var_d72bd991.class_num = eattacker.class_num;
    var_d72bd991.var_121392a1 = isDefined(eattacker.var_121392a1) ? arraycopy(eattacker.var_121392a1) : undefined;
    var_d72bd991.ismantling = eattacker ismantling();
    var_d72bd991.isjumping = !eattacker isonground() && !eattacker isonladder() && !eattacker isplayerswimming();
    var_d72bd991.var_bd77a1eb = (isDefined(eattacker.var_6f3f5189) ? eattacker.var_6f3f5189 : 0) + 2500 >= time;
    var_d72bd991.var_e8072c8d = eattacker issprinting() || (isDefined(eattacker.challenge_sprint_end) ? eattacker.challenge_sprint_end : 0) + 2000 > time;
    var_d72bd991.var_14f058c7 = isDefined(eattacker.lastreloadtime) && eattacker.lastreloadtime + 5000 >= time;
    var_d72bd991.var_8e35fb71 = function_ce33e204(eattacker);
    var_d72bd991.var_5745c480 = function_5af0c53c(eattacker);
    var_d72bd991.var_54433d4b = eattacker.scavenged === 1;
    var_d72bd991.sensordarts = isDefined(eattacker.sensor_darts) ? arraycopy(eattacker.sensor_darts) : undefined;
    var_d72bd991.var_85997af0 = distance2dsquared(self.origin, eattacker.origin);
    var_d72bd991.var_53611a9c = eattacker function_d210981e(self.origin);
    var_d72bd991.var_9a5c07a = self.ispulsed === 1;
    var_d72bd991.var_79eb9a59 = self.var_5379bee8;
    var_d72bd991.var_2acdce3e = isDefined(self.var_121392a1) ? arraycopy(self.var_121392a1) : undefined;
    var_d72bd991.var_b535f1ea = self.lastconcussedby;
    var_d72bd991.var_f91a4dd6 = self.recentkillcountsameweapon;

    if(eattacker hastalent(#"talent_teamlink") && !(var_d72bd991.var_53611a9c === 1) && level.teambased) {
      var_d72bd991.var_ec93e5f2 = function_43084f6c(self);
    }

    if(eattacker hastalent(#"talent_ghost") && !(var_d72bd991.var_8e35fb71 === 1)) {
      var_d72bd991.var_efc9cf4d = function_eddea888(eattacker);
    }

    var_98a6bdf5 = eattacker.var_ea1458aa;

    if(isDefined(var_98a6bdf5)) {
      var_46a82df0 = isDefined(var_98a6bdf5.var_a440c10) && var_98a6bdf5.var_a440c10 + 3000 > time;
      var_d72bd991.var_46a82df0 = var_46a82df0;
      var_d72bd991.var_69b66e8e = var_46a82df0 && var_98a6bdf5.var_55a37dc7 === 1 && (isDefined(var_ca60c93e.lastdamagetime) ? var_ca60c93e.lastdamagetime : 0) + 10000 > var_98a6bdf5.var_a440c10;

      if(isDefined(var_98a6bdf5.attackerdamage)) {
        var_8bc6e971 = var_98a6bdf5.attackerdamage[self.clientid];

        if(isDefined(var_8bc6e971)) {
          if(isDefined(var_8bc6e971.var_a74d2db8) && var_8bc6e971.var_a74d2db8 + 2500 > time) {
            var_d72bd991.var_d7bd6f9b = 1;
          }
        }
      }
    }
  }

  var_ca60c93e.damage += idamage;
  var_ca60c93e.einflictor = einflictor;
  var_ca60c93e.weapon = weapon;
  var_ca60c93e.lastdamagetime = time;
  var_ca60c93e.meansofdeath = smeansofdeath;
  var_ca60c93e.hitloc = shitloc;

  if(isarray(self.attackersthisspawn)) {
    self.attackersthisspawn[attackerclientid] = eattacker;
  }

  var_ca60c93e.lasttimedamaged = time;

  if(weapons::is_primary_weapon(weapon)) {
    self.attackerdata[attackerclientid] = 1;
  }
}

function function_43084f6c(player) {
  if(level.teambased) {
    otherteam = util::getotherteam(player.team);

    foreach(var_f53fe24c in getplayers(otherteam)) {
      if(var_f53fe24c function_d210981e(player.origin)) {
        return true;
      }
    }
  } else {
    enemies = getplayers();
    playereye = player geteyeapprox();

    foreach(enemy in enemies) {
      if(enemy == player) {
        continue;
      }

      if(enemy function_d210981e(player.origin)) {
        if(!isDefined(player.var_c676db5f)) {
          player.var_c676db5f = [];
        }

        if(!isDefined(player.var_c676db5f[player getentitynumber()])) {
          player.var_c676db5f[player getentitynumber()] = spawnStruct();
        }

        if((isDefined(player.var_c676db5f[player getentitynumber()].var_c719b74c) ? player.var_c676db5f[player getentitynumber()].var_c719b74c : 0) < gettime()) {
          player.var_c676db5f[player getentitynumber()].var_c719b74c = gettime() + 750;
          enemyeye = enemy geteyeapprox();
          player.var_c676db5f[player getentitynumber()].cansee = sighttracepassed(playereye, enemyeye, 0, player);
        }

        if(isDefined(player.var_c676db5f[player getentitynumber()].cansee) ? player.var_c676db5f[player getentitynumber()].cansee : 0) {
          return true;
        }
      }
    }
  }

  return false;
}

function function_9f942458(var_6ba44c6, var_fbbdf63c) {
  if(!isPlayer(var_fbbdf63c)) {
    return false;
  }

  if(!isDefined(var_fbbdf63c.sensor_darts)) {
    return false;
  }

  foreach(sensor in var_fbbdf63c.sensor_darts) {
    if(!isDefined(sensor)) {
      continue;
    }

    if(distancesquared(var_6ba44c6.origin, sensor.origin) < sqr((sessionmodeiswarzonegame() ? 2400 : 800) + 50)) {
      return true;
    }
  }

  return false;
}

function function_eddea888(player) {
  if(!isDefined(player.team)) {
    return false;
  }

  if(level.teambased) {
    otherteam = util::getotherteam(player.team);

    foreach(attacking_player in getplayers(otherteam)) {
      if(function_9f942458(player, attacking_player)) {
        return true;
      }
    }
  } else {
    enemies = getplayers();

    foreach(enemy in enemies) {
      if(enemy == player) {
        continue;
      }

      if(function_9f942458(player, enemy)) {
        return true;
      }
    }
  }

  return false;
}

function function_ce33e204(player) {
  if(!isDefined(level.activeuavs) || level.activeuavs.size == 0 || isDefined(level.forceradar) && level.forceradar == 1) {
    return false;
  }

  foreach(team in level.teams) {
    if(team == player.team) {
      continue;
    }

    if(isDefined(level.activeuavs[team]) && level.activeuavs[team] > 0) {
      return true;
    }
  }

  return false;
}

function private function_5af0c53c(player) {
  if(!isDefined(level.activecounteruavs) || level.activecounteruavs.size == 0) {
    return false;
  }

  if(level.teambased) {
    otherteam = util::getotherteam(player.team);

    if(isDefined(level.activecounteruavs[otherteam]) && level.activecounteruavs[otherteam] > 0) {
      return true;
    }
  } else {
    enemies = getplayers();

    foreach(enemy in enemies) {
      if(enemy == player) {
        continue;
      }

      if(!isDefined(enemy.entnum)) {
        enemy.entnum = enemy getentitynumber();
      }

      if(isDefined(level.activecounteruavs[enemy.entnum]) && level.activecounteruavs[enemy.entnum] > 0) {
        return true;
      }
    }
  }

  return false;
}

function function_9843a46c(eattacker, einflictor, idamage, smeansofdeath, weapon, shitloc) {
  self function_c5343206(eattacker, einflictor, idamage, smeansofdeath, weapon, shitloc);

  if(!isDefined(einflictor)) {
    return;
  }

  if(!isDefined(einflictor.owner)) {
    return;
  }

  if(isDefined(eattacker) && eattacker == einflictor.owner) {
    return;
  }

  self function_c5343206(einflictor.owner, einflictor, idamage, smeansofdeath, weapon, shitloc);
}

function trackattackerdamage(eattacker, idamage, smeansofdeath, weapon, shitloc) {
  if(!isDefined(eattacker)) {
    return;
  }

  if(!isPlayer(eattacker)) {
    return;
  }

  if(!isDefined(self.attackerdamage)) {
    return;
  }

  assert(isarray(self.attackerdata));
  now = gettime();

  if(self.attackerdata.size == 0) {
    self.firsttimedamaged = now;
  }

  attackerclientid = eattacker.clientid;

  if(self.attackerdata.size == 0 || !isDefined(self.attackerdamage[attackerclientid])) {
    self.attackerdamage[attackerclientid] = {
      #damage: 0, #time: now
    };
    self.attackers[self.attackers.size] = eattacker;
    self.attackerdata[attackerclientid] = 0;
  }

  if(isarray(self.attackersthisspawn)) {
    self.attackersthisspawn[attackerclientid] = eattacker;
  }

  var_ca60c93e = self.attackerdamage[attackerclientid];
  var_ca60c93e.damage += idamage;
  var_ca60c93e.meansofdeath = smeansofdeath;
  var_ca60c93e.weapon = weapon;
  var_ca60c93e.shitloc = shitloc;
  var_ca60c93e.lasttimedamaged = now;

  if(weapons::is_primary_weapon(weapon)) {
    self.attackerdata[attackerclientid] = 1;
  }

  if(isarray(eattacker.var_93866180) && isDefined(self.clientid)) {
    if(!isDefined(eattacker.var_93866180[self.clientid])) {
      eattacker.var_93866180[self.clientid] = {};
    }

    eattacker.var_93866180[self.clientid].var_3891afee = now;
  }
}

function allowedassistweapon(weapon) {
  if(isDefined(level.var_aadc08f8)) {
    return [[level.var_aadc08f8]](weapon);
  }

  return 0;
}

function giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon, shitloc) {
  if(is_true(level.var_724cf71)) {
    function_9843a46c(eattacker, einflictor, idamage, smeansofdeath, weapon, shitloc);
    return;
  }

  if(!allowedassistweapon(weapon)) {
    return;
  }

  self trackattackerdamage(eattacker, idamage, smeansofdeath, weapon, shitloc);

  if(!isDefined(einflictor)) {
    return;
  }

  if(!isDefined(einflictor.owner)) {
    return;
  }

  if(!isDefined(einflictor.ownergetsassist)) {
    return;
  }

  if(!einflictor.ownergetsassist) {
    return;
  }

  if(isDefined(eattacker) && eattacker == einflictor.owner) {
    return;
  }

  self trackattackerdamage(einflictor.owner, idamage, smeansofdeath, weapon, shitloc);
}

function function_efd02c1d(einflictor) {
  if(!isDefined(self.var_6ef09a14)) {
    return;
  }

  if(isPlayer(einflictor)) {
    return;
  }

  if(!isDefined(einflictor)) {
    return;
  }

  if(!isPlayer(einflictor.owner)) {
    return;
  }

  entnum = einflictor getentitynumber();

  if(!isDefined(self.var_6ef09a14[entnum])) {
    self.var_6ef09a14[entnum] = spawnStruct();
    self.var_6ef09a14[entnum].owner = einflictor.owner;
    self.var_6ef09a14[entnum].vehicletype = einflictor.vehicletype;
  }
}

function figureoutattacker(eattacker) {
  if(isDefined(eattacker)) {
    if(isai(eattacker) && isDefined(eattacker.script_owner)) {
      team = self.team;

      if(isai(self) && isDefined(self.team)) {
        team = self.team;
      }

      if(util::function_fbce7263(eattacker.script_owner.team, team)) {
        eattacker = eattacker.script_owner;
      }
    }

    if(eattacker.classname === "script_vehicle" && isDefined(eattacker.owner) && !issentient(eattacker)) {
      eattacker = eattacker.owner;
    } else if(eattacker.classname === "auto_turret" && isDefined(eattacker.owner)) {
      eattacker = eattacker.owner;
    }

    if(isDefined(eattacker.remote_owner)) {
      eattacker = eattacker.remote_owner;
    }
  }

  return eattacker;
}

function function_38527849() {
  if(level.numlives || level.numteamlives) {
    if(level.numlives && !self.pers[# "lives"]) {
      return false;
    } else if(!level.numlives && level.numteamlives && game.lives[self.team] <= 0) {
      return false;
    }
  }

  return true;
}