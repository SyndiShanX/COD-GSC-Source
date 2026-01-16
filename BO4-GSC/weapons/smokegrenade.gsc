/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\smokegrenade.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\sound_shared;
#include scripts\core_common\util_shared;

#namespace smokegrenade;

init_shared() {
  level.willypetedamageradius = 300;
  level.willypetedamageheight = 128;
  level.smokegrenadeduration = 8;
  level.smokegrenadedissipation = 4;
  level.smokegrenadetotaltime = level.smokegrenadeduration + level.smokegrenadedissipation;
  level.fx_smokegrenade_single = "smoke_center";
  level.smoke_grenade_triggers = [];
  clientfield::register("allplayers", "inenemysmoke", 14000, 1, "int");
  clientfield::register("allplayers", "insmoke", 16000, 2, "int");
  clientfield::register("scriptmover", "smoke_state", 16000, 1, "int");
  globallogic_score::register_kill_callback(getweapon(#"eq_smoke"), &function_b4a975f1);
}

function_79d42bea(weapon) {
  if(!isDefined(weapon.customsettings)) {
    return 128;
  }

  var_b0b958b3 = getscriptbundle(weapon.customsettings);
  return isDefined(var_b0b958b3.var_40dfefd1) ? var_b0b958b3.var_40dfefd1 : 128;
}

function_f199623f(weapon) {
  if(!isDefined(weapon.customsettings)) {
    return level.smokegrenadeduration;
  }

  var_b0b958b3 = getscriptbundle(weapon.customsettings);
  return isDefined(var_b0b958b3.smokegrenadeduration) ? var_b0b958b3.smokegrenadeduration : level.smokegrenadeduration;
}

function_184e15d2(weapon) {
  if(!isDefined(weapon.customsettings)) {
    return level.smokegrenadedissipation;
  }

  var_b0b958b3 = getscriptbundle(weapon.customsettings);
  return isDefined(var_b0b958b3.smokegrenadedissipation) ? var_b0b958b3.smokegrenadedissipation : level.smokegrenadedissipation;
}

watchsmokegrenadedetonation(owner, statweapon, smokeweapon, duration, totaltime) {
  self endon(#"trophy_destroyed");

  if(isplayer(owner)) {
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

smokedetonate(owner, statweapon, smokeweapon, position, radius, effectlifetime, smokeblockduration) {
  dir_up = (0, 0, 1);

  if(!isDefined(effectlifetime)) {
    effectlifetime = 10;
  }

  ent = spawntimedfx(smokeweapon, position, dir_up, int(effectlifetime));

  if(isDefined(owner)) {
    ent setteam(owner.team);

    if(isplayer(owner)) {
      ent setowner(owner);
    }
  }

  ent thread smokeblocksight(smokeweapon, radius);
  ent thread spawnsmokegrenadetrigger(smokeweapon, smokeblockduration, owner);

  if(isDefined(owner)) {
    owner.smokegrenadetime = gettime();
    owner.smokegrenadeposition = position;
  }

  thread playsmokesound(position, smokeblockduration, statweapon.projsmokestartsound, statweapon.projsmokeendsound, statweapon.projsmokeloopsound);
  return ent;
}

damageeffectarea(owner, position, radius, height) {
  effectarea = spawn("trigger_radius", position, 0, radius, height);

  if(isDefined(level.dogsonflashdogs)) {
    owner thread[[level.dogsonflashdogs]](effectarea);
  }

  effectarea delete();
}

smokeblocksight(smokeweapon, radius) {
  self endon(#"death");
  smokeradius = function_79d42bea(smokeweapon);

  while(true) {
    fxblocksight(self, radius);

    if(getdvarint(#"scr_smokegrenade_debug", 0)) {
      sphere(self.origin, smokeradius, (1, 0, 0), 0.25, 0, 10, 15);
    }

      wait 0.75;
  }
}

waitanddelete(time) {
  self ghost();
  self endon(#"death");
  wait time;
  self delete();
}

spawnsmokegrenadetrigger(smokeweapon, duration, owner) {
  team = self.team;
  radius = function_79d42bea(smokeweapon);
  trigger = spawn("trigger_radius", self.origin, 0, radius, radius);
  trigger.owner = owner;
  self.smoketrigger = trigger;
  anchor = spawn("script_model", self.origin);

  if(isDefined(owner)) {
    anchor setowner(owner);
    anchor setteam(owner.team);
  }

  anchor setModel(#"tag_origin");
  self.anchor = anchor;

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

  if(isDefined(anchor)) {
    anchor thread waitanddelete(1);
    self.anchor = undefined;
  }

  if(isDefined(trigger)) {
    trigger delete();
  }
}

function_b4a975f1(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(!isDefined(attacker) || !isDefined(victim)) {
    return false;
  }

  smoketrigger = victim function_367ce00e();

  if(isDefined(smoketrigger)) {
    if(attacker === smoketrigger.owner) {
      if(isDefined(attackerweapon) && attackerweapon !== level.weaponsigblade) {
        if(isDefined(level.playgadgetsuccess) && !isDefined(smoketrigger.var_25db02aa)) {
          smoketrigger.kills = (isDefined(smoketrigger.kills) ? smoketrigger.kills : 0) + 1;

          if(isDefined(level.var_ac6052e9)) {
            var_9194a036 = [
              [level.var_ac6052e9]
            ]("muteSmokeSuccessLineCount", 0);
          }

          if(smoketrigger.kills == (isDefined(var_9194a036) ? var_9194a036 : 3)) {
            attacker[[level.playgadgetsuccess]](getweapon(#"eq_smoke"), undefined, victim, undefined);
            smoketrigger.var_25db02aa = 1;
          }
        }
      }

      return true;
    } else if(isDefined(smoketrigger.owner) && isplayer(smoketrigger.owner) && isalive(smoketrigger.owner) && util::function_fbce7263(smoketrigger.owner.team, victim.team)) {
      if(level.teambased) {
        scoreevents::processscoreevent(#"smoke_assist", smoketrigger.owner, undefined, getweapon(#"eq_smoke"));
      }
    }
  }

  return false;
}

function_367ce00e(skiptrigger) {
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

function_4cc4db89(team, skiptrigger) {
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

function_50ef4b12(weapon) {
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

  return false;
}

private function_579815a1(weapon) {
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

function_87d0a127(grenadeent, smokeweapon) {
  if(!isDefined(grenadeent.smoketrigger)) {
    return;
  }

  grenadeteam = grenadeent.team;
  owner = grenadeent.smoketrigger.owner;

  while(true) {
    waitresult = grenadeent waittilltimeout(0.25, #"death");

    if(isDefined(owner)) {
      if(isDefined(grenadeent) && isDefined(grenadeent.smoketrigger) && owner istouching(grenadeent.smoketrigger) && waitresult._notify == #"timeout") {
        owner clientfield::set("inenemysmoke", 1);
      } else {
        owner clientfield::set("inenemysmoke", 0);
      }
    }

    if(!isDefined(owner) || !isDefined(grenadeent) || waitresult._notify != "timeout") {
      break;
    }
  }
}

function_8b6ddd71(grenadeent, smokeweapon) {
  if(!isDefined(grenadeent.smoketrigger)) {
    return;
  }

  grenadeteam = grenadeent.team;

  while(true) {
    waitresult = grenadeent waittilltimeout(0.25, #"death");

    foreach(player in level.players) {
      curval = player clientfield::get("insmoke");

      if(isDefined(grenadeent) && isDefined(grenadeent.smoketrigger) && player istouching(grenadeent.smoketrigger) && waitresult._notify == #"timeout") {
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

      if(curval&mask) {
        trig = undefined;

        if(isDefined(grenadeent)) {
          trig = function_4cc4db89(grenadeteam, grenadeent.smoketrigger);
        }

        if(!isDefined(trig)) {
          player clientfield::set("insmoke", curval&~mask);
        }
      }
    }

    if(!isDefined(grenadeent) || waitresult._notify != "timeout" || !isDefined(grenadeent.smoketrigger) && grenadeent.item === getweapon(#"spectre_grenade")) {
      break;
    }
  }
}

event_handler[grenade_fire] function_debb0d4e(eventstruct) {
  weapon = eventstruct.weapon;

  if(!function_50ef4b12(weapon)) {
    return;
  }

  if(weapon.rootweapon == getweapon(#"eq_smoke")) {
    weapon_smoke = getweapon(#"eq_smoke");
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
}

playsmokesound(position, duration, startsound, stopsound, loopsound) {
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