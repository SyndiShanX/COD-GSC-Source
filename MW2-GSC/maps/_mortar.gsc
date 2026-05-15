/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_mortar.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {}

hurtgen_style() {
  mortars = getEntArray("mortar", "targetname");
  lastmortar = -1;

  for(i = 0; i < mortars.size; i++) {
    mortars[i] setup_mortar_terrain();
  }
  if(!(isDefined(level.mortar))) {
    error("level.mortar not defined. define in level script");
  }

  level waittill("start_mortars");

  while(1) {
    wait(1 + (randomfloat(2)));

    r = randomint(mortars.size);

    for(i = 0; i < mortars.size; i++) {
      c = (i + r) % mortars.size;

      d = distance(level.player getorigin(), mortars[c].origin);
      d2 = undefined;
      if(isDefined(level.foley)) {
        d2 = distance(level.foley.origin, mortars[c].origin);
      } else {
        d2 = 360;
      }
      if((d < 1600) && (d > 400) && (d2 > 350) && (c != lastmortar)) {
        mortars[c] activate_mortar(400, 300, 25, undefined, undefined, undefined, false);
        lastmortar = c;
        if(d < 500) {
          maps\_shellshock::main(4);
        }

        break;
      }
    }
  }
}

railyard_style(fRandomtime, iMaxRange, iMinRange, iBlastRadius, iDamageMax, iDamageMin, fQuakepower, iQuaketime, iQuakeradius, targetsUsed, seedtime) {
  if(!isDefined(fRandomtime)) {
    fRandomtime = 7;
  }
  if(!isDefined(iMaxRange)) {
    iMaxRange = 2200;
  }
  if(!isDefined(iMinRange)) {
    iMinRange = 300;
  }

  if(!isDefined(level.iStopBarrage)) {
    level.iStopBarrage = 0;
  }

  if(!isDefined(targetsUsed)) {
    targetsUsed = 0;
  }

  mortars = getEntArray("mortar", "targetname");
  lastmortar = -1;

  for(i = 0; i < mortars.size; i++) {
    if(isDefined(mortars[i].target) && (targetsUsed == 0)) {
      mortars[i] setup_mortar_terrain();
    }
  }
  if(!(isDefined(level.mortar))) {
    error("level.mortar not defined. define in level script");
  }

  if(isDefined(level.mortar_notify)) {
    level waittill(level.mortar_notify);
  }

  for(;;) {
    if(level.iStopBarrage != 0) {
      wait 1;
    }
    while(level.iStopBarrage == 0) {
      if(isDefined(seedtime)) {
        wait(seedtime + (randomfloat(fRandomtime) + randomfloat(fRandomtime)));
      } else {
        wait(randomfloat(fRandomtime) + randomfloat(fRandomtime));
      }

      r = randomint(mortars.size);

      for(i = 0; i < mortars.size; i++) {
        c = (i + r) % mortars.size;

        d = distance(level.player getorigin(), mortars[c].origin);
        if((d < iMaxRange) && (d > iMinRange) && (c != lastmortar)) {
          mortars[c] activate_mortar(iBlastRadius, iDamageMax, iDamageMin, fQuakepower, iQuaketime, iQuakeradius, false);
          lastmortar = c;
          break;
        }
      }
    }
  }

}

script_mortargroup_style() {
  mortars = [];
  mortartrigs = [];
  level.mortars = [];
  models = getEntArray("script_model", "classname");
  for(i = 0; i < models.size; i++) {
    if(isDefined(models[i].script_mortargroup)) {}
    if(!isDefined(level.mortars[models[i].script_mortargroup])) {
      level.mortars[models[i].script_mortargroup] = [];
    }

    mortar = spawnStruct();
    mortar.origin = models[i].origin;
    mortar.angles = models[i].angles;
    if(isDefined(models[i].targetname)) {
      mortar.targetname = models[i].targetname;
    }
    if(isDefined(models[i].target)) {
      mortar.target = models[i].target;
    }
    level.mortars[models[i].script_mortargroup]
      [level.mortars[models[i].script_mortargroup].size] = mortar;
    models[i] delete();
  }
  for(i = 0; i < mortars.size; i++) {
    mortars[i] hide();

    mortars[i].has_terrain = false;
  }
  if(!(isDefined(level.mortar))) {
    level.mortar = loadfx("explosions/artilleryExp_dirt_brown");
  }

  triggers = array_combine(getEntArray("trigger_multiple", "classname"), getEntArray("trigger_radius", "classname"));
  for(i = 0; i < triggers.size; i++) {
    if(isDefined(triggers[i].script_mortargroup)) {}
    if(!isDefined(level.mortars[triggers[i].script_mortargroup])) {
      level.mortars[triggers[i].script_mortargroup] = [];
    }
    mortartrigs[mortartrigs.size] = triggers[i];
  }
  for(i = 0; i < mortartrigs.size; i++) {
    mortartrigs[i].mortargroup = 0;
    mortartrigs[i] thread script_mortargroup_mortar_group();
  }

  lasttrig = undefined;
  while(1) {
    level waittill("mortarzone", mortartrig);
    if(isDefined(lasttrig)) {
      lasttrig notify("wait again");
    }
    level.mortarzone = mortartrig.script_mortargroup;
    mortartrig thread script_mortargroup_mortarzone();
    lasttrig = mortartrig;
  }
}

script_mortargroup_mortarzone() {
  lastblast = [];
  timer = gettime();
  timed = false;
  if(isDefined(self.script_timer)) {
    level notify("timed barrage");
    timer = gettime() + self.script_timer * 1000;
    timed = true;
  }
  if(isDefined(self.script_radius)) {
    mortar_radius = self.script_radius;
  } else {
    mortar_radius = 0;
  }

  if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    customdelay = true;
  } else {
    customdelay = false;
  }

  count = 0;
  nonbarragesize = 2;
  barragesize = 4;
  barraging = false;

  while((level.mortars[self.script_mortargroup].size > 0 && (level.mortarzone == self.script_mortargroup)) || timed) {
    if(customdelay) {
      wait(randomfloat(self.script_delay_max - self.script_delay_min) + self.script_delay_min);
    } else if(barraging) {
      if(count < barragesize) {
        wait(randomfloat(.5));
        count++;
      } else {
        count = 0;
        barragesize = 2 + randomint(4);
        barraging = false;
        continue;
      }
    } else {
      if(count < nonbarragesize) {
        delay = randomFloat(2) + 1;
        wait(delay);
        count++;
      } else {
        count = 0;
        barraging = true;
        nonbarragesize = randomint(2) + 3;
        continue;
      }
    }
    mortarsinfront = [];
    pick = randomint(level.mortars[self.script_mortargroup].size);
    if(randomint(100) < 75) {
      playerforward = anglesToForward(level.player.angles);
      points = [];
      for(i = 0; i < level.mortars[self.script_mortargroup].size; i++) {
        if(mortar_radius > 0 && distance(level.player.origin, level.mortars[self.script_mortargroup][i].origin) > mortar_radius) {
          continue;
        }
        if(is_lastblast(level.mortars[self.script_mortargroup][i], lastblast)) {
          continue;
        }
        normalvec = vectornormalize(level.mortars[self.script_mortargroup][i].origin - level.player.origin);
        if(vectordot(playerforward, normalvec) > 0.3) {
          points[points.size] = i;
        }
      }
      if(points.size > 0) {
        pick = points[randomint(points.size)];
      }
    }
    if(lastblast.size > 3) {
      lastblast = [];
    }
    lastblast[lastblast.size] = level.mortars[self.script_mortargroup][pick];
    level.mortars[self.script_mortargroup][pick] thread script_mortargroup_domortar();

    if(timed && gettime() > timer) {
      if(isDefined(self.target)) {
        target = getent(self.target, "targetname");
        if(isDefined(target)) {
          target notify("trigger");
          level notify("timed barrage finished");
        }
      }
      break;
    }
  }
}

is_lastblast(mortar, lastblast) {
  for(i = 0; i < lastblast.size; i++) {
    if(mortar == lastblast[i]) {
      return true;
    }
    return false;
  }
}

script_mortargroup_domortar() {
  if(isDefined(self.targetname) && isDefined(level.mortarthread[self.targetname])) {
    level thread[[level.mortarthread[self.targetname]]](self);
  } else {
    self thread activate_mortar(undefined, undefined, undefined, undefined, undefined, undefined, true);
  }
  self waittill("mortar");
  if(isDefined(self.target)) {
    targ = getent(self.target, "targetname");
    if(isDefined(targ)) {
      targ notify("trigger");
    }
  }
}

script_mortargroup_mortar_group() {
  while(1) {
    self waittill("trigger");
    if(isDefined(level.mortarzone) && level.mortarzone == self.script_mortargroup) {
      continue;
    }
    level notify("mortarzone", self);
    self waittill("wait again");
  }
}

trigger_targeted() {
  level.mortartrigger = getEntArray("mortartrigger", "targetname");
  level.mortars = getEntArray("script_origin", "classname");

  for(i = 0; i < level.mortars.size; i++) {
    if(isDefined(level.mortars[i].script_mortargroup)) {
      level.mortars[i] setup_mortar_terrain();
    }
  }

  level.lastmortar = -1;

  if(!(isDefined(level.mortar))) {
    error("level.mortar not defined. define in level script");
  }

  for(i = 0; i < level.mortartrigger.size; i++) {
    thread trigger_targeted_mortars(i);
  }
}

trigger_targeted_mortars(num) {
  targeted_mortars = getEntArray(level.mortartrigger[num].target, "targetname");

  while(1) {
    if(level.player istouching(level.mortartrigger[num])) {
      r = randomint(targeted_mortars.size);
      while(r == level.lastmortar) {
        r = randomint(targeted_mortars.size);
        wait .1;
      }
      targeted_mortars[r] activate_mortar(undefined, undefined, undefined, undefined, undefined, undefined, false);
      level.lastmortar = r;
    }
    wait(randomfloat(3) + randomfloat(4));
  }
}

bunker_style_mortar() {
  mortar_bunker_array = [];
  ents = undefined;
  groupNum = [];
  structs = getStructArray("mortar_bunker", "targetname");
  trigs = getEntArray("mortar_bunker", "targetname");
  if((isDefined(trigs)) && (trigs.size > 0)) {
    ents = array_merge(structs, trigs);
  } else {
    ents = structs;
  }
  assert(isDefined(ents));
  assert(ents.size > 0);
  for(i = 0; i < ents.size; i++) {
    if(!isDefined(ents[i].script_mortargroup)) {
      continue;
    }
    index = -1;
    groupNumber = int(ents[i].script_mortargroup);
    for(p = 0; p < mortar_bunker_array.size; p++) {
      if(groupNumber != groupNum[p]) {
        continue;
      }
      index = p;
      break;
    }

    if(index == -1) {
      mortar_bunker_array[mortar_bunker_array.size] = [];
      groupNum[groupNum.size] = groupNumber;
      index = mortar_bunker_array.size - 1;
    }

    mortar_bunker_array[index][mortar_bunker_array[index].size] = ents[i];
  }

  for(i = 0; i < mortar_bunker_array.size; i++) {
    thread bunker_style_mortar_think(mortar_bunker_array[i], structs);
  }

  wait 0.05;

  array_thread(getEntArray("mortar_on", "targetname"), ::bunker_style_mortar_trigger, "on");
  array_thread(getEntArray("mortar_off", "targetname"), ::bunker_style_mortar_trigger, "off");
}

bunker_style_mortar_think(mortar_bunker_array, structs) {
  min = undefined;
  max = undefined;
  if(isDefined(level.mortarMinInterval)) {
    min = level.mortarMinInterval;
  } else {
    min = 4;
  }
  if(isDefined(level.mortarMaxInterval)) {
    max = level.mortarMaxInterval;
  } else {
    max = 6;
  }
  groupNum = int(mortar_bunker_array[0].script_mortargroup);

  for(;;) {
    level waittill("start_mortars " + groupNum);
    thread bunker_style_mortar_activate(mortar_bunker_array, min, max, groupNum, structs);
  }
}

bunker_style_mortar_activate(mortar_bunker_array, min, max, groupNum, structs) {
  level endon("start_mortars " + groupNum);
  level endon("stop_mortars " + groupNum);
  while(true) {
    wait(0.05);
    sound_org = getclosest(level.player.origin, structs);
    if(!isDefined(level.mortarNoIncomingSound)) {
      play_sound_in_space("mortar_incoming_bunker", sound_org.origin);
    }
    sound_org = getclosest(level.player.origin, structs);

    thread play_sound_in_space("exp_artillery_underground", sound_org.origin);
    array_thread(mortar_bunker_array, ::bunker_style_mortar_explode);
    if(!isDefined(level.mortarNoQuake)) {
      if(cointoss()) {
        earthquake(0.20, 1.5, sound_org.origin, 1250);
      } else {
        earthquake(0.35, 2.75, sound_org.origin, 1250);
      }
    }
    level notify("mortar_hit");
    wait(randomfloatrange(min, max));
    mortar_bunker_array = remove_undefined_from_array(mortar_bunker_array);
  }
}

bunker_style_mortar_explode(min, max) {
  if(!isDefined(self)) {
    return;
  }

  if((isDefined(level.mortarWithinFOV)) && (self mortar_within_player_fov(level.mortarWithinFOV) == false)) {
    return;
  }

  if(isDefined(level.mortar_min_dist)) {
    min_dist = level.mortar_min_dist;
  } else {
    min_dist = 1024;
  }

  min_dist_squared = min_dist * min_dist;
  distSquared = distancesquared(level.player.origin, self.origin);
  if(distSquared > min_dist_squared) {
    return;
  }

  if((isDefined(self.classname)) && (self.classname == "trigger_radius")) {
    if((!level.player istouching(self)) && (distance(level.player.origin, self.origin) < level.mortarDamageTriggerDist)) {
      RadiusDamage(self.origin, self.radius, 500, 500);
      self delete();
      return;
    }
  } else {
    playFX(level._effect["mortar"][self.script_fxid], self.origin);
    if(distSquared < 262144) {
      thread play_sound_in_space("emt_single_ceiling_debris", self.origin);
    }
  }
}

bog_style_mortar() {
  groups = [];
  groupNum = [];
  structs = getStructArray("mortar", "targetname");
  assert(isDefined(structs));
  assert(structs.size > 0);
  for(i = 0; i < structs.size; i++) {
    if(!isDefined(structs[i].script_mortargroup)) {
      continue;
    }
    index = -1;
    groupNumber = int(structs[i].script_mortargroup);
    for(p = 0; p < groups.size; p++) {
      if(groupNumber != groupNum[p]) {
        continue;
      }
      index = p;
      break;
    }

    if(index == -1) {
      groups[groups.size] = [];
      groupNum[groupNum.size] = groupNumber;
      index = groups.size - 1;
    }

    groups[index][groups[index].size] = structs[i];
  }

  for(i = 0; i < groups.size; i++) {
    thread bog_style_mortar_think(groups[i]);
  }

  wait 0.05;

  array_thread(getEntArray("mortar_on", "targetname"), ::bog_style_mortar_trigger, "on");
  array_thread(getEntArray("mortar_off", "targetname"), ::bog_style_mortar_trigger, "off");
}

bog_style_mortar_think(mortars, groupNum) {
  min = undefined;
  max = undefined;
  if(isDefined(level.mortarMinInterval)) {
    min = level.mortarMinInterval;
  } else {
    min = 0.5;
  }
  if(isDefined(level.mortarMaxInterval)) {
    max = level.mortarMaxInterval;
  } else {
    max = 3;
  }
  groupNum = int(mortars[0].script_mortargroup);
  for(;;) {
    level waittill("start_mortars " + groupNum);
    level thread bog_style_mortar_activate(mortars, groupNum, min, max);
  }
}

bog_style_mortar_activate(mortars, groupNum, min, max) {
  level endon("start_mortars " + groupNum);
  level endon("stop_mortars " + groupNum);

  if(isDefined(level.mortar_min_dist)) {
    min_dist = level.mortar_min_dist;
  } else {
    min_dist = 300;
  }

  mortarDistanceTrigger = spawn("trigger_radius", (0, 0, 0), 0, min_dist, 256);
  thread bog_style_mortar_cleanup(mortarDistanceTrigger, groupNum);

  for(;;) {
    for(;;) {
      wait 0.05;
      rand = randomint(mortars.size);
      if(isDefined(mortars[rand].cooldown)) {
        continue;
      }
      d = distance(level.player.origin, mortars[rand].origin);
      if(d < min_dist) {
        continue;
      }

      if((isDefined(level.mortarExcluders)) && (level.mortarExcluders.size > 0)) {
        mortarDistanceTrigger.origin = mortars[rand].origin;
        if(mortars_too_close(level.mortarExcluders, mortarDistanceTrigger)) {
          continue;
        }
      }

      if(!isDefined(level.noMaxMortarDist) && (d > 1000)) {
        continue;
      }
      if((isDefined(level.mortar_max_dist)) && (d > level.mortar_max_dist)) {
        continue;
      }
      if((isDefined(level.mortarWithinFOV)) && (mortars[rand] mortar_within_player_fov(level.mortarWithinFOV) == false)) {
        continue;
      }
      break;
    }
    if((isDefined(level.noMortars)) && (level.noMortars == true)) {
      return;
    }
    mortars[rand] thread bog_style_mortar_explode();

    wait(min + randomfloat(max - min));
  }
}

bog_style_mortar_cleanup(mortarDistanceTrigger, groupNum) {
  level waittill("stop_mortars " + groupNum);
  mortarDistanceTrigger delete();
}

mortars_too_close(mortarExcluders, mortarDistanceTrigger) {
  foreach(guy in level.mortarExcluders) {
    if(!isalive(guy)) {
      continue;
    }
    if(!isDefined(guy)) {
      continue;
    }
    if(guy istouching(mortarDistanceTrigger)) {
      return true;
    }
  }

  return false;
}

mortar_within_player_fov(fov) {
  playerEye = level.player getEye();
  playerMortarFovOffset = (0, 0, 0);
  if(isDefined(level.playerMortarFovOffset)) {
    playerMortarFovOffset = level.playerMortarFovOffset;
  }

  bInFOV = within_fov(playerEye, level.player getPlayerAngles() + playerMortarFovOffset, self.origin, fov);
  return bInFOV;
}

bog_style_mortar_explode(instant, customExploSound) {
  if(!isDefined(level.mortarDamageRadius)) {
    level.mortarDamageRadius = 250;
  }
  if(!isDefined(instant)) {
    instant = false;
  }

  self thread bog_style_mortar_cooldown();
  if(!instant) {
    self play_sound_in_space(level.scr_sound["mortar"]["incomming"]);
  }
  if(isDefined(customExploSound)) {
    self thread play_sound_in_space(customExploSound);
  } else {
    self thread play_sound_in_space(level.scr_sound["mortar"][self.script_fxid]);
  }

  setplayerignoreradiusdamage(true);
  radiusDamage(self.origin, level.mortarDamageRadius, 150, 50);
  setplayerignoreradiusdamage(false);
  playFX(level._effect["mortar"][self.script_fxid], self.origin);

  if(isDefined(level.alwaysquake)) {
    earthquake(0.3, 1, level.player.origin, 2000);
  }

  if(getdvarint("bog_camerashake") > 0) {
    if((level.player getCurrentWeapon() == "dragunov") && (level.player playerADS() > 0.8)) {
      return;
    }
    earthquake(0.25, 0.75, self.origin, 1250);
  }
}

bog_style_mortar_cooldown() {
  self.cooldown = true;
  wait(3 + randomfloat(2));
  self.cooldown = undefined;
}

bog_style_mortar_trigger(value) {
  assert(isDefined(self.script_mortargroup));

  self waittill("trigger");

  if(value == "on") {
    bog_style_mortar_on(self.script_mortargroup);
  } else if(value == "off") {
    bog_style_mortar_off(self.script_mortargroup);
  }
}

bog_style_mortar_on(groupNum) {
  level notify("start_mortars " + groupNum);
}

bog_style_mortar_off(groupNum) {
  level notify("stop_mortars " + groupNum);
}

bunker_style_mortar_on(groupNum) {
  if(!isDefined(level.mortarDamageTriggerDist)) {
    level.mortarDamageTriggerDist = 512;
  }
  if(!isDefined(level.mortarWithinFOV)) {
    level.mortarWithinFOV = cos(35);
  }

  level notify("start_mortars " + groupNum);
}

bunker_style_mortar_off(groupNum) {
  level waittill("mortar_hit");
  level notify("stop_mortars " + groupNum);
}

bunker_style_mortar_off_nowait(groupNum) {
  level notify("stop_mortars " + groupNum);
}

bunker_style_mortar_trigger(value) {
  assert(isDefined(self.script_mortargroup));

  self waittill("trigger");

  if(value == "on") {
    bunker_style_mortar_on(self.script_mortargroup);
  } else if(value == "off") {
    bunker_style_mortar_off(self.script_mortargroup);
  }
}

burnville_style_mortar() {
  level endon("stop falling mortars");
  setup_mortar_terrain();

  wait(randomfloat(0.5) + randomfloat(0.5));

  while(1) {
    if(distance(level.player getorigin(), self.origin) < 600) {
      activate_mortar(undefined, undefined, undefined, undefined, undefined, undefined, false);
      break;
    }
    wait(1);
  }

  wait(7 + randomfloat(20));

  while(1) {
    if((distance(level.player getorigin(), self.origin) < 1200) && (distance(level.player getorigin(), self.origin) > 400)) {
      activate_mortar(undefined, undefined, undefined, undefined, undefined, undefined, false);

      wait(3 + randomfloat(14));
    }

    wait(1);
  }
}

setup_mortar_terrain() {
  self.has_terrain = false;
  if(isDefined(self.target)) {
    self.terrain = getEntArray(self.target, "targetname");
    self.has_terrain = true;
  } else {
    println("z:mortar entity has no target: ", self.origin);
  }

  if(!isDefined(self.terrain)) {
    println("z:mortar entity has target, but target doesnt exist: ", self.origin);
  }

  if(isDefined(self.script_hidden)) {
    if(isDefined(self.script_hidden)) {
      self.hidden_terrain = getent(self.script_hidden, "targetname");
    } else if((isDefined(self.terrain)) && (isDefined(self.terrain[0].target))) {
      self.hidden_terrain = getent(self.terrain[0].target, "targetname");
    }

    if(isDefined(self.hidden_terrain)) {
      self.hidden_terrain hide();
    }
  } else if(isDefined(self.has_terrain)) {
    if((isDefined(self.terrain)) && (isDefined(self.terrain[0].target))) {
      self.hidden_terrain = getent(self.terrain[0].target, "targetname");
    }

    if(isDefined(self.hidden_terrain)) {
      self.hidden_terrain hide();
    }
  }
}

activate_mortar(range, max_damage, min_damage, fQuakepower, iQuaketime, iQuakeradius, bIsstruct) {
  incoming_sound(undefined, bIsstruct);

  level notify("mortar");
  self notify("mortar");

  if(!isDefined(range)) {
    range = 256;
  }
  if(!isDefined(max_damage)) {
    max_damage = 400;
  }
  if(!isDefined(min_damage)) {
    min_damage = 25;
  }

  radiusDamage(self.origin, range, max_damage, min_damage);

  if((isDefined(self.has_terrain) && self.has_terrain == true) && (isDefined(self.terrain))) {
    for(i = 0; i < self.terrain.size; i++) {
      if(isDefined(self.terrain[i])) {
        self.terrain[i] delete();
      }
    }
  }

  if(isDefined(self.hidden_terrain)) {
    self.hidden_terrain show();
  }
  self.has_terrain = false;

  mortar_boom(self.origin, fQuakepower, iQuaketime, iQuakeradius, undefined, bIsstruct);
}

mortar_boom(origin, fPower, iTime, iRadius, effect, bIsstruct) {
  if(!isDefined(fPower)) {
    fPower = 0.15;
  }
  if(!isDefined(iTime)) {
    iTime = 2;
  }
  if(!isDefined(iRadius)) {
    iRadius = 850;
  }

  thread mortar_sound(bIsstruct);

  if(isDefined(effect)) {
    playFX(effect, origin);
  } else {
    playFX(level.mortar, origin);
  }

  earthquake(fPower, iTime, origin, iRadius);

  if(level.script != "burnville") {
    return;
  }
  if(isDefined(level.playerMortar)) {
    return;
  }
  if(distance(level.player.origin, origin) > 300) {
    return;
  }
  if(level.script == "carchase" || level.script == "breakout") {
    return;
  }
  level.playerMortar = true;
  level notify("shell shock player", iTime * 4);
  maps\_shellshock::main(iTime * 4);
}

mortar_sound(bIsstruct) {
  if(!isDefined(level.mortar_last_sound)) {
    level.mortar_last_sound = -1;
  }

  soundnum = randomint(3) + 1;
  while(soundnum == level.mortar_last_sound) {
    soundnum = randomint(3) + 1;
  }

  level.mortar_last_sound = soundnum;

  if(!bIsstruct) {
    self playSound("mortar_explosion" + soundnum);
  } else {
    play_sound_in_space("mortar_explosion" + soundnum, self.origin);
  }
}

incoming_sound(soundnum, bIsstruct) {
  currenttime = gettime();
  if(!isDefined(level.lastmortarincomingtime)) {
    level.lastmortarincomingtime = currenttime;
  } else if((currenttime - level.lastmortarincomingtime) < 1000) {
    wait 1;
    return;
  } else {
    level.lastmortarincomingtime = currenttime;
  }

  if(!isDefined(soundnum)) {
    soundnum = randomint(3) + 1;
  }

  if(soundnum == 1) {
    if(bIsstruct) {
      thread play_sound_in_space("mortar_incoming1", self.origin);
    } else {
      self playSound("mortar_incoming1");
    }
    wait(1.07 - 0.25);
  } else
  if(soundnum == 2) {
    if(bIsstruct) {
      thread play_sound_in_space("mortar_incoming2", self.origin);
    } else {
      self playSound("mortar_incoming2");
    }
    wait(0.67 - 0.25);
  } else {
    if(bIsstruct) {
      thread play_sound_in_space("mortar_incoming3", self.origin);
    } else {
      self playSound("mortar_incoming3");
    }
    wait(1.55 - 0.25);
  }
}

generic_style_init() {
  level._explosion_iMaxRange = [];
  level._explosion_iMinRange = [];
  level._explosion_iBlastRadius = [];
  level._explosion_iDamageMax = [];
  level._explosion_iDamageMin = [];
  level._explosion_fQuakePower = [];
  level._explosion_iQuakeTime = [];
  level._explosion_iQuakeRadius = [];
}

generic_style_setradius(strExplosion, iMinRange, iMaxRange) {
  level._explosion_iMinRange[strExplosion] = iMinRange;
  level._explosion_iMaxRange[strExplosion] = iMaxRange;
}

generic_style_setdamage(strExplosion, iBlastRadius, iDamageMin, iDamageMax) {
  level._explosion_iBlastRadius[strExplosion] = iBlastRadius;
  level._explosion_iDamageMin[strExplosion] = iDamageMin;
  level._explosion_iDamageMax[strExplosion] = iDamageMax;
}

generic_style_setquake(strExplosion, fQuakePower, iQuakeTime, iQuakeRadius) {
  level._explosion_fQuakePower[strExplosion] = fQuakePower;
  level._explosion_iQuakeTime[strExplosion] = iQuakeTime;
  level._explosion_iQuakeRadius[strExplosion] = iQuakeRadius;
}
generic_style(strExplosion, fDelay, iBarrageSize, fBarrageDelay, iMinRange, iMaxRange, bTargetsUsed) {
  assertex((isDefined(strExplosion) && (strExplosion != "")), "strExplosion not passed. pass in level script");
  assertex((isDefined(level._effect) && isDefined(level._effect[strExplosion])), "level._effect[strMortars] not defined. define in level script");

  iLastExplosion = -1;
  iMaxRangeLocal = iMaxRange;
  iMinRangeLocal = iMinRange;

  generic_style_setradius(strExplosion, 300, 2200);

  if(!isDefined(fDelay)) {
    fDelay = 7;
  }

  if(!isDefined(iBarrageSize)) {
    iBarrageSize = 1;
  }

  if(!isDefined(fBarrageDelay)) {
    fBarrageDelay = 0;
  }

  if(!isDefined(bTargetsUsed)) {
    bTargetsUsed = false;
  }

  if(isDefined(level.explosion_stopNotify) && isDefined(level.explosion_stopNotify[strExplosion])) {
    level endon(level.explosion_stopNotify[strExplosion]);
  }

  if(!isDefined(level.bStopBarrage) || !isDefined(level.bStopBarrage[strExplosion])) {
    level.bStopBarrage[strExplosion] = false;
  }

  aeExplosions = getEntArray(strExplosion, "targetname");

  for(i = 0; i < aeExplosions.size; i++) {
    if(isDefined(aeExplosions[i].target) && (!bTargetsUsed)) {
      aeExplosions[i] setup_mortar_terrain();
    }
  }

  if(isDefined(level.explosion_startNotify) && isDefined(level.explosion_startNotify[strExplosion])) {
    level waittill(level.explosion_startNotify[strExplosion]);
  }

  while(true) {
    while(!level.bStopBarrage[strExplosion]) {
      for(j = 0; j < iBarrageSize; j++) {
        if(!isDefined(iMaxRange)) {
          iMaxRangeLocal = level._explosion_iMaxRange[strExplosion];
        }
        if(!isDefined(iMinRange)) {
          iMinRangeLocal = level._explosion_iMinRange[strExplosion];
        }

        iRand = randomint(aeExplosions.size);
        for(i = 0; i < aeExplosions.size; i++) {
          iCur = (i + iRand) % aeExplosions.size;
          fDist = distance(level.player getorigin(), aeExplosions[iCur].origin);
          if((fDist < iMaxRangeLocal) && (fDist > iMinRangeLocal) && (iCur != iLastExplosion)) {} {
            aeExplosions[iCur].iMinRange = iMinRangeLocal;
            aeExplosions[iCur] explosion_activate(strExplosion);
            iLastExplosion = iCur;
            break;
          }
        }
        iLastExplosion = -1;
        if(isDefined(level.explosion_delay) && isDefined(level.explosion_delay[strExplosion])) {
          wait(level.explosion_delay[strExplosion]);
        } else {
          wait(randomfloat(fDelay) + randomFloat(fDelay));
        }
      }
      if(isDefined(level.explosion_barrage_delay) && isDefined(level.explosion_barrage_delay[strExplosion])) {
        wait(level.explosion_barrage_delay[strExplosion]);
      } else {
        wait(randomfloat(fBarrageDelay) + randomFloat(fBarrageDelay));
      }
    }
    wait(0.05);
  }
}

explosion_activate(strExplosion, iBlastRadius, iDamageMin, iDamageMax, fQuakePower, iQuakeTime, iQuakeRadius) {
  generic_style_setdamage(strExplosion, 256, 25, 400);
  generic_style_setquake(strExplosion, 0.15, 2, 850);

  if(!isDefined(iBlastRadius)) {
    iBlastRadius = level._explosion_iBlastRadius[strExplosion];
  }
  if(!isDefined(iDamageMin)) {
    iDamageMin = level._explosion_iDamageMin[strExplosion];
  }
  if(!isDefined(iDamageMax)) {
    iDamageMax = level._explosion_iDamageMax[strExplosion];
  }

  if(!isDefined(fQuakePower)) {
    fQuakePower = level._explosion_fQuakePower[strExplosion];
  }
  if(!isDefined(iQuakeTime)) {
    iQuakeTime = level._explosion_iQuakeTime[strExplosion];
  }
  if(!isDefined(iQuakeRadius)) {
    iQuakeRadius = level._explosion_iQuakeRadius[strExplosion];
  }

  explosion_incoming(strExplosion);

  level notify("explosion", strExplosion);

  bDoDamage = true;
  fPreDist = undefined;
  eLocation = self;
  if(isDefined(self.iMinRange) && distance(level.player.origin, self.origin) < self.iMinRange) {
    aeExplosions = getEntArray(strExplosion, "targetname");
    for(iCur = 0; iCur < aeExplosions.size; iCur++) {
      fDist = distance(level.player getorigin(), aeExplosions[iCur].origin);
      if(fDist > self.iMinRange) {
        if(!isDefined(fPreDist) || fDist < fPreDist) {
          fPreDist = fDist;
          eLocation = aeExplosions[iCur];
        }
      }
    }
    if(!isDefined(fPreDist)) {
      bDoDamage = false;
    }
  }

  if(bDoDamage) {
    radiusDamage(eLocation.origin, iBlastRadius, iDamageMax, iDamageMin);
  }

  if((isDefined(eLocation.has_terrain) && eLocation.has_terrain == true) && (isDefined(eLocation.terrain))) {
    for(i = 0; i < eLocation.terrain.size; i++) {
      if(isDefined(eLocation.terrain[i])) {
        eLocation.terrain[i] delete();
      }
    }
  }

  if(isDefined(eLocation.hidden_terrain)) {
    eLocation.hidden_terrain show();
  }
  eLocation.has_terrain = false;

  eLocation explosion_boom(strExplosion, fQuakePower, iQuakeTime, iQuakeRadius);
}

explosion_boom(strExplosion, fPower, iTime, iRadius) {
  if(!isDefined(fPower)) {
    fPower = 0.15;
  }
  if(!isDefined(iTime)) {
    iTime = 2;
  }
  if(!isDefined(iRadius)) {
    iRadius = 850;
  }

  explosion_sound(strExplosion);

  explosion_origin = self.origin;

  playFX(level._effect[strExplosion], explosion_origin);
  earthquake(fPower, iTime, explosion_origin, iRadius);

  if(distance(level.player.origin, explosion_origin) > 300) {
    return;
  }
  if(level.script == "carchase" || level.script == "breakout") {
    return;
  }
  level.playerMortar = true;
  level notify("shell shock player", iTime * 4);
  maps\_shellshock::main(iTime * 4);
}

explosion_sound(strExplosion) {
  if(!isDefined(level._explosion_last_sound)) {
    level._explosion_last_sound = 0;
  }

  soundnum = randomint(3) + 1;
  while(soundnum == level._explosion_last_sound) {
    soundnum = randomint(3) + 1;
  }

  level._explosion_last_sound = soundnum;

  if(level._effectType[strExplosion] == "mortar") {
    switch (soundnum) {
      case 1:
        self playSound("mortar_explosion1");
        break;
      case 2:
        self playSound("mortar_explosion2");
        break;
      case 3:
        self playSound("mortar_explosion3");
        break;
    }
  } else if(level._effectType[strExplosion] == "artillery") {
    switch (soundnum) {
      case 1:
        self playSound("mortar_explosion4");
        break;
      case 2:
        self playSound("mortar_explosion5");
        break;
      case 3:
        self playSound("mortar_explosion1");
        break;
    }
  } else if(level._effectType[strExplosion] == "bomb") {
    switch (soundnum) {
      case 1:
        self playSound("mortar_explosion1");
        break;
      case 2:
        self playSound("mortar_explosion4");
        break;
      case 3:
        self playSound("mortar_explosion5");
        break;
    }
  }
}

explosion_incoming(strExplosion, soundnum) {
  if(!isDefined(level._explosion_last_incoming)) {
    level._explosion_last_incoming = -1;
  }

  soundnum = randomint(4) + 1;
  while(soundnum == level._explosion_last_incoming) {
    soundnum = randomint(4) + 1;
  }

  level._explosion_last_incoming = soundnum;

  if(level._effectType[strExplosion] == "mortar") {
    switch (soundnum) {
      case 1:
        self playSound("mortar_incoming1");
        wait(1.07 - 0.25);
        break;
      case 2:
        self playSound("mortar_incoming2");
        wait(0.67 - 0.25);
        break;
      case 3:
        self playSound("mortar_incoming3");
        wait(1.55 - 0.25);
        break;
      default:
        wait(1.75);
        break;
    }
  } else if(level._effectType[strExplosion] == "artillery") {
    switch (soundnum) {
      case 1:
        self playSound("mortar_incoming4");
        wait(1.07 - 0.25);
        break;
      case 2:
        self playSound("mortar_incoming4_new");
        wait(0.67 - 0.25);
        break;
      case 3:
        self playSound("mortar_incoming1_new");
        wait(1.55 - 0.25);
        break;
      default:
        wait(1.75);
        break;
    }
  } else if(level._effectType[strExplosion] == "bomb") {
    switch (soundnum) {
      case 1:
        self playSound("mortar_incoming2_new");
        wait(1.75);
        break;
      case 2:
        self playSound("mortar_incoming3_new");
        wait(1.75);
        break;
      case 3:
        self playSound("mortar_incoming4_new");
        wait(1.75);
        break;
      default:
        wait(1.75);
        break;
    }
  }
}