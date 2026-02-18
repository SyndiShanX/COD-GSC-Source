/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\smokegrenade.gsc
***********************************************/

#using script_396f7d71538c9677;
#using scripts\core_common\battlechatter;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\util_shared;
#namespace smokegrenade;

function init_shared() {
  level.willypetedamageradius = 300;
  level.willypetedamageheight = 128;
  level.smokegrenadeduration = 8;
  level.smokegrenadedissipation = 4;
  level.smokegrenadetotaltime = level.smokegrenadeduration + level.smokegrenadedissipation;
  level.fx_smokegrenade_single = "smoke_center";
  level.smoke_grenade_triggers = [];
  clientfield::register("allplayers", "inenemysmoke", 14000, 1, "int");
  clientfield::register("allplayers", "insmoke", 16000, 2, "int");
  clientfield::register("allplayers", "foggerpostfx", 9000, 1, "int");
  clientfield::register("scriptmover", "smoke_state", 16000, 1, "int");
  globallogic_score::register_kill_callback(getweapon(#"willy_pete"), &function_aff603b2);
}

function function_79d42bea(weapon) {
  if(!isDefined(weapon.customsettings)) {
    return 128;
  }

  var_b0b958b3 = getscriptbundle(weapon.customsettings);
  return isDefined(var_b0b958b3.var_40dfefd1) ? var_b0b958b3.var_40dfefd1 : 128;
}

function function_36d48dce(weapon) {
  if(!isDefined(weapon.customsettings)) {
    return 128;
  }

  var_b0b958b3 = getscriptbundle(weapon.customsettings);
  return isDefined(var_b0b958b3.var_9e166547) ? var_b0b958b3.var_9e166547 : function_79d42bea(weapon);
}

function function_f199623f(weapon) {
  if(!isDefined(weapon.customsettings)) {
    return level.smokegrenadeduration;
  }

  var_b0b958b3 = getscriptbundle(weapon.customsettings);
  return isDefined(var_b0b958b3.smokegrenadeduration) ? var_b0b958b3.smokegrenadeduration : level.smokegrenadeduration;
}

function function_184e15d2(weapon) {
  if(!isDefined(weapon.customsettings)) {
    return level.smokegrenadedissipation;
  }

  var_b0b958b3 = getscriptbundle(weapon.customsettings);
  return isDefined(var_b0b958b3.smokegrenadedissipation) ? var_b0b958b3.smokegrenadedissipation : level.smokegrenadedissipation;
}

function watchsmokegrenadedetonation(owner, statweapon, smokeweapon, duration, totaltime) {
  self endon(#"trophy_destroyed");

  if(isPlayer(owner)) {
    owner stats::function_e24eec31(statweapon, #"used", 1);
  }

  waitresult = self waittill(#"explode", #"death");

  if(waitresult._notify != "explode") {
    return;
  }

  onefoot = (0, 0, 12);
  startpos = waitresult.position + onefoot;
  smokedetonate(owner, statweapon, smokeweapon, waitresult.position, function_79d42bea(smokeweapon), totaltime, duration);
  damageeffectarea(owner, startpos, smokeweapon.explosionradius, level.willypetedamageheight);
}

function smokedetonate(owner, statweapon, smokeweapon, position, radius, effectlifetime, smokeblockduration) {
  dir_up = (0, 0, 1);

  if(!isDefined(effectlifetime)) {
    effectlifetime = 10;
  }

  ent = spawn("script_model", position);

  if(isDefined(owner)) {
    ent setteam(owner.team);

    if(isPlayer(owner)) {
      ent setowner(owner);
    }
  }

  if(ent function_c7b93adf(smokeweapon)) {
    ent smokeblocksight(radius);
  }

  ent thread spawnsmokegrenadetrigger(smokeweapon, smokeblockduration, owner);
  now = gettime();

  if(sessionmodeiscampaigngame()) {
    if(isDefined(owner)) {
      owner.smokegrenadetime = now;
      owner.smokegrenadeposition = position;
    }
  } else if(level.var_5712bc1c === 1) {
    if(isDefined(owner)) {
      if(!isDefined(owner.var_e0e2e070)) {
        owner.var_e0e2e070 = [];
      }

      var_d6b53fbd = now - 14000;

      foreach(key, var_96138b54 in owner.var_e0e2e070) {
        if(!isstruct(var_96138b54)) {
          continue;
        }

        if(var_96138b54.var_6f327e4a < var_d6b53fbd) {
          owner.var_e0e2e070[key] = # "stale";
        }
      }

      arrayremovevalue(owner.var_e0e2e070, #"stale");
      var_86142949 = {
        #var_6f327e4a: now, #position: position
      };

      if(!isDefined(owner.var_e0e2e070)) {
        owner.var_e0e2e070 = [];
      } else if(!isarray(owner.var_e0e2e070)) {
        owner.var_e0e2e070 = array(owner.var_e0e2e070);
      }

      owner.var_e0e2e070[owner.var_e0e2e070.size] = var_86142949;
    }
  }

  thread playsmokesound(position, smokeblockduration, statweapon.projsmokestartsound, statweapon.projsmokeendsound, statweapon.projsmokeloopsound);

  if(sessionmodeiscampaigngame() && self.var_3791d005 !== 0) {
    badplace_cylinder("", effectlifetime * 0.666, position, radius, radius, "axis");
  }

  return ent;
}

function damageeffectarea(owner, position, radius, height) {
  effectarea = spawn("trigger_radius", position, 0, radius, height);

  if(isDefined(level.dogsonflashdogs)) {
    owner thread[[level.dogsonflashdogs]](effectarea);
  }

  effectarea delete();
}

function smokeblocksight(radius) {
  fxblocksight(self, radius);

  if(getdvarint(#"scr_smokegrenade_debug", 0)) {
    self thread function_f02a8a0b(radius);
  }
}

function function_f02a8a0b(radius) {
  self endon(#"death");

  while(true) {
    sphere(self.origin, radius, (1, 0, 0), 0.25, 0, 20, 15);
    wait 0.75;
  }
}

function function_c7b93adf(weapon) {
  if(!isDefined(weapon.customsettings)) {
    return 1;
  }

  var_b0b958b3 = getscriptbundle(weapon.customsettings);
  return is_true(var_b0b958b3.var_afa9a0c4);
}

function waitanddelete(time) {
  self ghost();
  self endon(#"death");
  wait time;
  self delete();
}

function spawnsmokegrenadetrigger(smokeweapon, duration, owner) {
  team = self.team;
  radius = function_79d42bea(smokeweapon);
  trigger = spawn("trigger_radius", self.origin, 0, radius, radius);
  trigger.owner = owner;
  trigger.smokeweapon = smokeweapon;
  self.smoketrigger = trigger;

  if(isDefined(owner.team)) {
    trigger setteamfortrigger(owner.team);
    trigger.team = owner.team;
  }

  if(!isDefined(level.smoke_grenade_triggers)) {
    level.smoke_grenade_triggers = [];
  } else if(!isarray(level.smoke_grenade_triggers)) {
    level.smoke_grenade_triggers = array(level.smoke_grenade_triggers);
  }

  level.smoke_grenade_triggers[level.smoke_grenade_triggers.size] = trigger;

  if(function_579815a1(smokeweapon)) {
    thread function_8b6ddd71(self, smokeweapon);
  }

  self waittilltimeout(duration, #"death");
  arrayremovevalue(level.smoke_grenade_triggers, trigger);

  if(isDefined(self)) {
    self thread waitanddelete(1);
  }

  if(isDefined(trigger)) {
    trigger delete();
  }
}

function private function_aff603b2(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(!isDefined(weapon) || !isDefined(attackerweapon)) {
    return false;
  }

  smoketrigger = attackerweapon function_367ce00e();

  if(isDefined(smoketrigger)) {
    if(weapon === smoketrigger.owner) {
      if(isDefined(meansofdeath) && meansofdeath !== level.weaponsigblade) {
        if(!isDefined(smoketrigger.var_25db02aa)) {
          smoketrigger.kills = (isDefined(smoketrigger.kills) ? smoketrigger.kills : 0) + 1;
          var_9194a036 = battlechatter::mpdialog_value("muteSmokeSuccessLineCount", 0);

          if(smoketrigger.kills == (isDefined(var_9194a036) ? var_9194a036 : 3)) {
            weapon battlechatter::play_gadget_success(getweapon(#"willy_pete"), undefined, attackerweapon, undefined);
            smoketrigger.var_25db02aa = 1;
          }
        }
      }

      weapon stats::function_e24eec31(meansofdeath, #"hash_dd38fe3b56f0644", 1);
      weapon contracts::increment_contract(#"hash_6477d3e8a879d241");
      weapon stats::function_dad108fa(#"hash_3c5a82d06549abcc", 1);
      weapon stats::function_dad108fa(#"hash_2b2887daddeb75a7", 1);
      weaponclass = util::getweaponclass(meansofdeath);

      if(isDefined(level.var_91dfce3b)) {
        if(weaponclass === # "weapon_smg") {
          weapon[[level.var_91dfce3b]]();
        }
      }

      return true;
    } else if(isPlayer(smoketrigger.owner) && isalive(smoketrigger.owner) && util::function_fbce7263(smoketrigger.owner.team, attackerweapon.team)) {
      if(level.teambased) {
        scoreevents::processscoreevent(#"smoke_assist", smoketrigger.owner, undefined, getweapon(#"willy_pete"));

        if(isDefined(level.var_b7bc3c75.var_e2298731)) {
          smoketrigger.owner[[level.var_b7bc3c75.var_e2298731]]();
        }
      }
    }
  }

  return false;
}

function function_367ce00e(skiptrigger) {
  foreach(trigger in level.smoke_grenade_triggers) {
    if(self istouching(trigger)) {
      if(isDefined(skiptrigger)) {
        if(skiptrigger != trigger) {
          return trigger;
        }

        continue;
      }

      return trigger;
    }
  }

  return undefined;
}

function function_4cc4db89(team, skiptrigger) {
  foreach(trigger in level.smoke_grenade_triggers) {
    if(!trigger util::isenemyteam(team) && self istouching(trigger)) {
      if(isDefined(skiptrigger)) {
        if(skiptrigger != trigger) {
          return trigger;
        }

        continue;
      }

      return trigger;
    }
  }

  return undefined;
}

function function_65fc89ee(weapon) {
  foreach(trigger in level.smoke_grenade_triggers) {
    if(self istouching(trigger)) {
      var_125b3ffe = sqr(function_36d48dce(trigger.smokeweapon));
      headorigin = isDefined(self gettagorigin("j_head")) ? self gettagorigin("j_head") : self.origin;
      distsq = distance2dsquared(trigger.origin, headorigin);

      if(distsq < var_125b3ffe) {
        return true;
      }
    }
  }

  return false;
}

function function_50ef4b12(weapon) {
  if(getweapon(#"eq_smoke") == weapon.rootweapon) {
    return true;
  }

  if(getweapon(#"willy_pete") == weapon.rootweapon) {
    return true;
  }

  if(getweapon(#"hash_615e6c73989c85b4") == weapon.rootweapon) {
    return true;
  }

  if(getweapon(#"hash_7a88daffaea7a9cf") == weapon.rootweapon) {
    return true;
  }

  if(getweapon(#"spectre_grenade") == weapon.rootweapon) {
    return true;
  }

  if(getweapon(#"hash_34fa23e332e34886") == weapon.rootweapon) {
    return true;
  }

  return false;
}

function private function_579815a1(weapon) {
  if(!isDefined(weapon.customsettings)) {
    return false;
  }

  var_e6fbac16 = getscriptbundle(weapon.customsettings);

  if(var_e6fbac16.var_8ceb6ac8 === 1) {
    return true;
  }

  if(var_e6fbac16.var_6942aad6 === 1) {
    return true;
  }

  return false;
}

function function_87d0a127(grenadeent, smokeweapon) {
  if(!isDefined(smokeweapon.smoketrigger)) {
    return;
  }

  grenadeteam = smokeweapon.team;
  owner = smokeweapon.smoketrigger.owner;

  while(true) {
    waitresult = smokeweapon waittilltimeout(0.15, #"death");

    if(isDefined(owner)) {
      if(isDefined(smokeweapon.smoketrigger) && owner istouching(smokeweapon.smoketrigger) && waitresult._notify == # "timeout") {
        owner clientfield::set("inenemysmoke", 1);
      } else {
        owner clientfield::set("inenemysmoke", 0);
      }
    }

    if(!isDefined(owner) || !isDefined(smokeweapon) || waitresult._notify != "timeout") {
      break;
    }
  }
}

function function_8b6ddd71(grenadeent, smokeweapon) {
  if(!isDefined(grenadeent.smoketrigger)) {
    return;
  }

  grenadeteam = grenadeent.team;

  while(true) {
    waitresult = grenadeent waittilltimeout(0.15, #"death");

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      curval = player clientfield::get("insmoke");

      if(waitresult._notify == # "timeout" && player function_65fc89ee(smokeweapon)) {
        if(game.state == # "playing") {
          player clientfield::set("foggerpostfx", 1);
        }
      } else {
        player clientfield::set("foggerpostfx", 0);
      }

      if(isDefined(grenadeent.smoketrigger) && player istouching(grenadeent.smoketrigger) && waitresult._notify == # "timeout") {
        if(player util::isenemyteam(grenadeteam)) {
          player clientfield::set("insmoke", curval | 1);
        } else {
          player clientfield::set("insmoke", curval | 2);
        }

        continue;
      }

      if(player util::isenemyteam(grenadeteam)) {
        mask = 1;
      } else {
        mask = 2;
      }

      if(curval &mask) {
        trig = undefined;

        if(isDefined(grenadeent)) {
          trig = player function_4cc4db89(grenadeteam, grenadeent.smoketrigger);
        }

        if(!isDefined(trig)) {
          player clientfield::set("insmoke", curval &~mask);
        }
      }
    }

    if(!isDefined(grenadeent) || waitresult._notify != "timeout" || !isDefined(grenadeent.smoketrigger) && grenadeent.item === getweapon(#"spectre_grenade")) {
      break;
    }
  }
}

function event_handler[grenade_fire] function_debb0d4e(eventstruct) {
  weapon = eventstruct.weapon;

  if(!function_50ef4b12(weapon)) {
    return;
  }

  if(weapon.rootweapon == getweapon(#"eq_smoke")) {
    weapon_smoke = getweapon(#"eq_smoke");
  } else if(weapon.rootweapon == getweapon(#"hash_34fa23e332e34886")) {
    weapon_smoke = getweapon(#"hash_34fa23e332e34886");
  } else if(weapon.rootweapon == getweapon(#"spectre_grenade")) {
    weapon_smoke = getweapon(#"spectre_grenade");
  } else {
    weapon_smoke = getweapon(#"willy_pete");
  }

  duration = function_f199623f(weapon_smoke);
  totaltime = duration + function_184e15d2(weapon_smoke);
  grenade = eventstruct.projectile;

  if(grenade util::ishacked()) {
    return;
  }

  grenade thread watchsmokegrenadedetonation(self, weapon_smoke, weapon_smoke, duration, totaltime);
  waitresult = grenade waittill(#"stationary", #"death");

  if(waitresult._notify == "stationary") {
    playFX(#"hash_4ca8a1df731cf6a1", grenade.origin, (0, 0, 1), (1, 0, 0));
  }
}

function playsmokesound(position, duration, startsound, stopsound, loopsound) {
  smokesound = spawn("script_origin", (0, 0, 1));

  if(isDefined(smokesound)) {
    smokesound endon(#"death");
    smokesound.origin = position;

    if(isDefined(startsound)) {
      smokesound playSound(startsound);
    }

    if(isDefined(loopsound)) {
      smokesound playLoopSound(loopsound);
    }

    if(duration > 0.5) {
      wait duration - 0.5;
    }

    if(isDefined(stopsound)) {
      thread sound::play_in_space(stopsound, position);
    }

    smokesound stoploopsound(0.5);
    wait 0.5;
    smokesound delete();
  }
}