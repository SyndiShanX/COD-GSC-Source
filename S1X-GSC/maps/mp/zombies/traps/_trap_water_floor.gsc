/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\traps\_trap_water_floor.gsc
*******************************************************/

init() {
  thread maps\mp\zombies\_traps::trap_setup_custom_function("water_floor_trap", "active", ::begintrap);
  thread maps\mp\zombies\_traps::trap_setup_custom_hints("water_floor_trap", &"ZOMBIES_TRAP_READY", &"ZOMBIES_TRAP_COOLDOWN");
}

begintrap(var_0) {
  var_0 thread trapwaterfloorlogic();
  return 1;
}

trapwaterfloorlogic() {
  self notify("trapWaterFloorLogic");
  self endon("trapWaterFloorLogic");
  self endon("cooldown");
  activateclientexploder(57);
  thread trapwaterfloorcleanup();
  var_0 = trapgetwatervolume();
  var_1 = 0;

  for(;;) {
    if(var_1 >= 2) {
      waitframe();
      var_1 = 0;
      continue;
    }

    var_2 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

    foreach(var_4 in var_2) {
      if(var_4.team != level.enemyteam) {
        continue;
      }
      if(isDefined(var_4.watertrapcooldown) && gettime() < var_4.watertrapcooldown) {
        continue;
      }
      if(!isalive(var_4)) {
        continue;
      }
      if(maps\mp\zombies\_util::is_true(var_4.inpain) || maps\mp\zombies\_util::is_true(var_4.flungbywatertrap)) {
        continue;
      }
      if(isDefined(var_4.birthtime) && var_4.birthtime == gettime()) {
        continue;
      }
      if(var_4 maps\mp\zombies\_util::istrapresistant()) {
        continue;
      }
      if(ispointinvolume(var_4.origin, var_0)) {
        thread trapwaterlaunch(var_4, var_4.origin);
        var_1++;

        if(var_1 >= 2) {
          break;
        }
      }
    }

    if(var_1 >= 2) {
      waitframe();
      var_1 = 0;
      continue;
    }

    foreach(var_7 in level.players) {
      if(!isalive(var_7) || maps\mp\zombies\_util::isplayerinlaststand(var_7)) {
        continue;
      }
      if(isDefined(var_7.watertrapcooldown) && gettime() < var_7.watertrapcooldown) {
        continue;
      }
      if(ispointinvolume(var_7.origin, var_0)) {
        thread trapwaterlaunch(var_7, var_7.origin);

        if(var_1 >= 2) {
          break;
        }
      }
    }

    waitframe();
  }
}

trapwaterfloorcleanup() {
  self endon("trapWaterFloorLogic");
  self waittill("cooldown");
  stopclientexploder(57);

  foreach(var_1 in level.players) {
    var_1.watertrapcooldown = undefined;
  }
}

trapwaterlaunch(var_0, var_1) {
  playFX(common_scripts\utility::getfx("water_trap_jet"), var_1);
  playsoundatpos(var_1, "steam_burst_trap");
  var_2 = var_0 getvelocity();
  var_3 = var_0.origin;

  if(isPlayer(var_0)) {
    var_4 = (var_2[0], var_2[1], 700);
    var_0 setvelocity(var_4);
    earthquake(0.4, 1, var_3, 500, var_0);
    var_0.watertrapcooldown = gettime() + 3000;
  } else {
    if(var_0.agent_type == "zombie_generic") {
      playsoundatpos(var_0.origin, "zmb_gen_steam_burst_death");
    }

    var_0.watervelocity = (var_2[0], var_2[1], 800);
    var_5 = level.wavecounter * randomintrange(100, 120);
    var_0 dodamage(var_5, var_3 + (0, 0, -1), self.owner, undefined, "MOD_EXPLOSIVE", "zombie_water_trap_mp");

    if(isalive(var_0) && isscriptedagent(var_0) && !var_0 maps\mp\agents\_scripted_agent_anim_util::isstatelocked() && !var_0 maps\mp\agents\humanoid\_humanoid_util::iscrawling() && isDefined(var_0.agent_type) && var_0.agent_type != "zombie_dog" && var_0.agent_type != "ranged_elite_soldier" && var_0.agent_type != "ranged_elite_soldier_goliath") {
      level thread trapflingzombie(var_0);
    } else {
      var_0.watertrapcooldown = gettime() + 3000;
    }

    wait 0.1;
    physicsexplosionsphere(var_3, 60, 0, 10, 0);
  }
}

trapflingzombie(var_0) {
  var_0 endon("death");
  var_0.flungbywatertrap = 1;
  var_0 scragentsetanimmode("anim deltas");
  var_0 scragentsetanimscale(1, 1);
  var_0 scragentsetphysicsmode("no_gravity");
  var_0 scragentsetorientmode("face angle abs", var_0.angles);
  var_1 = "water_trap_victim";
  var_2 = var_0 getanimentrycount(var_1);
  var_3 = randomint(4);
  var_0 scragentsetscripted(1);
  var_0 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "WaterTrapAnim");
  var_0 maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_1, var_3, 1.0, "scripted_anim");
  var_0 scragentsetphysicsmode("gravity");
  var_0 scragentsetscripted(0);
  var_0 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "WaterTrapAnim");
  var_0.flungbywatertrap = undefined;
}

trapgetwatervolume() {
  var_0 = getEntArray(self.target, "targetname");
  var_1 = common_scripts\utility::getstructarray(self.target, "targetname");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4.script_noteworthy)) {
      continue;
    }
    if(var_4.script_noteworthy == "floor") {
      return var_4;
    }
  }
}