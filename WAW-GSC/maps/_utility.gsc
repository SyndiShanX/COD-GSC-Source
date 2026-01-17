/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_utility.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility_code;

set_vision_set(visionset, transition_time) {
  if(init_vision_set(visionset)) {
    return;
  }
  if(!isDefined(transition_time))
    transition_time = 1;
  visionSetNaked(visionset, transition_time);
}

set_nvg_vision(visionset, transition_time) {
  if(!isDefined(transition_time))
    transition_time = 1;
  visionSetNight(visionset, transition_time);
}

sun_light_fade(startSunColor, endSunColor, fTime) {
  fTime = int(fTime * 20);
  increment = [];
  for(i = 0; i < 3; i++)
    increment[i] = (startSunColor[i] - endSunColor[i]) / fTime;
  newSunColor = [];
  for(i = 0; i < fTime; i++) {
    wait(0.05);
    for(j = 0; j < 3; j++)
      newSunColor[j] = startSunColor[j] - (increment[j] * i);
    setSunLight(newSunColor[0], newSunColor[1], newSunColor[2]);
  }
  setSunLight(endSunColor[0], endSunColor[1], endSunColor[2]);
}

ent_flag_wait(msg) {
  self endon("death");
  while(!self.ent_flag[msg])
    self waittill(msg);
}

ent_flag_wait_either(flag1, flag2) {
  self endon("death");
  for(;;) {
    if(ent_flag(flag1))
      return;
    if(ent_flag(flag2)) {
      return;
    }
    self waittill_either(flag1, flag2);
  }
}

ent_flag_wait_or_timeout(flagname, timer) {
  self endon("death");
  start_time = gettime();
  for(;;) {
    if(self.ent_flag[flagname]) {
      break;
    }
    if(gettime() >= start_time + timer * 1000) {
      break;
    }
    self ent_wait_for_flag_or_time_elapses(flagname, timer);
  }
}

ent_flag_waitopen(msg) {
  self endon("death");
  while(self.ent_flag[msg])
    self waittill(msg);
}

ent_flag_assert(msg) {
  assertEx(!self ent_flag(msg), "Flag " + msg + " set too soon on entity at position " + self.origin);
}

ent_flag_init(message) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }
  if(!isDefined(level.first_frame))
    assertEx(!isDefined(self.ent_flag[message]), "Attempt to reinitialize existing message: " + message + " on entity at position " + self.origin);
  self.ent_flag[message] = false;
  self.ent_flags_lock[message] = false;
}

ent_flag_set_delayed(message, delay) {
  wait(delay);
  self ent_flag_set(message);
}

ent_flag_set(message) {
  assertEx(isDefined(self), "Attempt to set a flag on entity that is not defined");
  assertEx(isDefined(self.ent_flag[message]), "Attempt to set a flag before calling flag_init: " + message + " on entity at position " + self.origin);
  assert(self.ent_flag[message] == self.ent_flags_lock[message]);
  self.ent_flags_lock[message] = true;
  self.ent_flag[message] = true;
  self notify(message);
}

ent_flag_clear(message) {
  assertEx(isDefined(self), "Attempt to clear a flag on entity that is not defined");
  assertEx(isDefined(self.ent_flag[message]), "Attempt to set a flag before calling flag_init: " + message + " on entity at position " + self.origin);
  assert(self.ent_flag[message] == self.ent_flags_lock[message]);
  self.ent_flags_lock[message] = false;
  if(self.ent_flag[message]) {
    self.ent_flag[message] = false;
    self notify(message);
  }
}

ent_flag_clear_delayed(message, delay) {
  wait(delay);
  self ent_flag_clear(message);
}

ent_flag(message) {
  assertEx(isalive(self), "Attempt to check a flag on entity that is not alive or removed");
  assertEx(isDefined(message), "Tried to check flag but the flag was not defined.");
  assertEx(isDefined(self.ent_flag[message]), "Tried to check flag " + message + " but the flag was not initialized, on entity at position " + self.origin);
  if(!self.ent_flag[message])
    return false;
  return true;
}

ent_flag_init_ai_standards() {
  message_array = [];
  message_array[message_array.size] = "goal";
  message_array[message_array.size] = "damage";
  for(i = 0; i < message_array.size; i++) {
    self ent_flag_init(message_array[i]);
    self thread ent_flag_wait_ai_standards(message_array[i]);
  }
}

ent_flag_wait_ai_standards(message) {
  self endon("death");
  self waittill(message);
  self.ent_flag[message] = true;
}

flag_wait_either(flag1, flag2) {
  for(;;) {
    if(flag(flag1))
      return;
    if(flag(flag2)) {
      return;
    }
    level waittill_either(flag1, flag2);
  }
}

flag_wait_any(flag1, flag2, flag3, flag4) {
  array = [];
  if(isDefined(flag4)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
  } else if(isDefined(flag3)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
  } else if(isDefined(flag2)) {
    flag_wait_either(flag1, flag2);
    return;
  } else {
    assertmsg("flag_wait_any() needs at least 2 flags passed to it");
    return;
  }
  for(;;) {
    for(i = 0; i < array.size; i++) {
      if(flag(array[i]))
        return;
    }
    level waittill_any(flag1, flag2, flag3, flag4);
  }
}

flag_wait_all(flag1, flag2, flag3, flag4) {
  if(isDefined(flag1))
    flag_wait(flag1);
  if(isDefined(flag2))
    flag_wait(flag2);
  if(isDefined(flag3))
    flag_wait(flag3);
  if(isDefined(flag4))
    flag_wait(flag4);
}

flag_wait_or_timeout(flagname, timer) {
  start_time = gettime();
  for(;;) {
    if(level.flag[flagname]) {
      break;
    }
    if(gettime() >= start_time + timer * 1000) {
      break;
    }
    wait_for_flag_or_time_elapses(flagname, timer);
  }
}

flag_waitopen_or_timeout(flagname, timer) {
  start_time = gettime();
  for(;;) {
    if(!level.flag[flagname]) {
      break;
    }
    if(gettime() >= start_time + timer * 1000) {
      break;
    }
    wait_for_flag_or_time_elapses(flagname, timer);
  }
}

flag_trigger_init(message, trigger, continuous) {
  flag_init(message);
  if(!isDefined(continuous))
    continuous = false;
  assert(isSubStr(trigger.classname, "trigger"));
  trigger thread _flag_wait_trigger(message, continuous);
  return trigger;
}

flag_triggers_init(message, triggers, all) {
  flag_init(message);
  if(!isDefined(all))
    all = false;
  for(index = 0; index < triggers.size; index++) {
    assert(isSubStr(triggers[index].classname, "trigger"));
    triggers[index] thread _flag_wait_trigger(message, false);
  }
  return triggers;
}

flag_assert(msg) {
  assertEx(!flag(msg), "Flag " + msg + " set too soon!");
}

flag_set_delayed(message, delay) {
  wait(delay);
  flag_set(message);
}

flag_clear_delayed(message, delay) {
  wait(delay);
  flag_clear(message);
}

_flag_wait_trigger(message, continuous) {
  self endon("death");
  for(;;) {
    self waittill("trigger", other);
    flag_set(message);
    if(!continuous) {
      return;
    }
    while(other isTouching(self))
      wait(0.05);
    flag_clear(message);
  }
}

level_end_save() {
  if(level.missionfailed) {
    return;
  }
  if(flag("game_saving")) {
    return;
  }
  players = get_players();
  if(!IsAlive(players[0])) {
    return;
  }
  flag_set("game_saving");
  imagename = "levelshots / autosave / autosave_" + level.script + "end";
  saveGame("levelend", &"AUTOSAVE_AUTOSAVE", imagename, true);
  flag_clear("game_saving");
}

autosave_by_name(name) {
  thread autosave_by_name_thread(name);
}

autosave_by_name_thread(name, timeout) {
  if(!isDefined(level.curAutoSave)) {
    level.curAutoSave = 1;
  }
  imageName = "levelshots / autosave / autosave_" + level.script + level.curAutoSave;
  result = level maps\_autosave::try_auto_save(level.curAutoSave, "autosave", imagename, timeout);
  if(isDefined(result) && result) {
    level.curAutoSave++;
  }
}

autosave_or_timeout(name, timeout) {
  thread autosave_by_name_thread(name, timeout);
}

error(message) {
  println("^c * ERROR * ", message);
  wait 0.05;
  if(GetDebugDvar("debug") != "1")
    assertmsg("This is a forced error - attach the log file");
}

array_levelthread(array, process, var1, var2, var3) {
  keys = getArrayKeys(array);
  if(isDefined(var3)) {
    for(i = 0; i < keys.size; i++)
      thread[[process]](array[keys[i]], var1, var2, var3);
    return;
  }
  if(isDefined(var2)) {
    for(i = 0; i < keys.size; i++)
      thread[[process]](array[keys[i]], var1, var2);
    return;
  }
  if(isDefined(var1)) {
    for(i = 0; i < keys.size; i++)
      thread[[process]](array[keys[i]], var1);
    return;
  }
  for(i = 0; i < keys.size; i++)
    thread[[process]](array[keys[i]]);
}

debug_message(message, origin, duration) {
  if(!isDefined(duration))
    duration = 5;
  for(time = 0; time < (duration * 20); time++) {
    print3d((origin + (0, 0, 45)), message, (0.48, 9.4, 0.76), 0.85);
    wait 0.05;
  }
}

debug_message_clear(message, origin, duration, extraEndon) {
  if(isDefined(extraEndon)) {
    level notify(message + extraEndon);
    level endon(message + extraEndon);
  } else {
    level notify(message);
    level endon(message);
  }
  if(!isDefined(duration))
    duration = 5;
  for(time = 0; time < (duration * 20); time++) {
    print3d((origin + (0, 0, 45)), message, (0.48, 9.4, 0.76), 0.85);
    wait 0.05;
  }
}

chain_off(chain) {
  trigs = getEntArray("trigger_friendlychain", "classname");
  for(i = 0; i < trigs.size; i++)
    if((isDefined(trigs[i].script_chain)) && (trigs[i].script_chain == chain)) {
      if(isDefined(trigs[i].oldorigin))
        trigs[i].origin = trigs[i].oldorigin;
      else
        trigs[i].oldorigin = trigs[i].origin;
      trigs[i].origin = trigs[i].origin + (0, 0, -5000);
    }
}

chain_on(chain) {
  trigs = getEntArray("trigger_friendlychain", "classname");
  for(i = 0; i < trigs.size; i++)
    if((isDefined(trigs[i].script_chain)) && (trigs[i].script_chain == chain)) {
      if(isDefined(trigs[i].oldorigin))
        trigs[i].origin = trigs[i].oldorigin;
    }
}

precache(model) {
  ent = spawn("script_model", (0, 0, 0));
  ent.origin = level.player getorigin();
  ent setModel(model);
  ent delete();
}

add_to_array(array, ent) {
  if(!isDefined(ent))
    return array;
  if(!isDefined(array))
    array[0] = ent;
  else
    array[array.size] = ent;
  return array;
}

closerFunc(dist1, dist2) {
  return dist1 >= dist2;
}

fartherFunc(dist1, dist2) {
  return dist1 <= dist2;
}

getClosest(org, array, dist) {
  return compareSizes(org, array, dist, ::closerFunc);
}

getClosestFx(org, fxarray, dist) {
  return compareSizesFx(org, fxarray, dist, ::closerFunc);
}

getFarthest(org, array, dist) {
  return compareSizes(org, array, dist, ::fartherFunc);
}

compareSizesFx(org, array, dist, compareFunc) {
  if(!array.size)
    return undefined;
  if(isDefined(dist)) {
    struct = undefined;
    keys = getArrayKeys(array);
    for(i = 0; i < keys.size; i++) {
      newdist = distance(array[keys[i]].v["origin"], org);
      if([[compareFunc]](newDist, dist))
        continue;
      dist = newdist;
      struct = array[keys[i]];
    }
    return struct;
  }
  keys = getArrayKeys(array);
  struct = array[keys[0]];
  dist = distance(struct.v["origin"], org);
  for(i = 1; i < keys.size; i++) {
    newdist = distance(array[keys[i]].v["origin"], org);
    if([
        [compareFunc]
      ](newDist, dist))
      continue;
    dist = newdist;
    struct = array[keys[i]];
  }
  return struct;
}

compareSizes(org, array, dist, compareFunc) {
  if(!array.size)
    return undefined;
  if(isDefined(dist)) {
    ent = undefined;
    keys = GetArrayKeys(array);
    for(i = 0; i < keys.size; i++) {
      newdist = distance(array[keys[i]].origin, org);
      if([[compareFunc]](newDist, dist))
        continue;
      dist = newdist;
      ent = array[keys[i]];
    }
    return ent;
  }
  keys = GetArrayKeys(array);
  ent = array[keys[0]];
  dist = Distance(ent.origin, org);
  for(i = 1; i < keys.size; i++) {
    newdist = distance(array[keys[i]].origin, org);
    if([
        [compareFunc]
      ](newDist, dist))
      continue;
    dist = newdist;
    ent = array[keys[i]];
  }
  return ent;
}

get_closest_point(origin, points, maxDist) {
  assert(points.size);
  closestPoint = points[0];
  dist = Distance(origin, closestPoint);
  for(index = 0; index < points.size; index++) {
    testDist = distance(origin, points[index]);
    if(testDist >= dist) {
      continue;
    }
    dist = testDist;
    closestPoint = points[index];
  }
  if(!isDefined(maxDist) || dist <= maxDist)
    return closestPoint;
  return undefined;
}

get_within_range(org, array, dist) {
  guys = [];
  for(i = 0; i < array.size; i++) {
    if(distance(array[i].origin, org) <= dist)
      guys[guys.size] = array[i];
  }
  return guys;
}

get_outside_range(org, array, dist) {
  guys = [];
  for(i = 0; i < array.size; i++) {
    if(distance(array[i].origin, org) > dist)
      guys[guys.size] = array[i];
  }
  return guys;
}

get_closest_living(org, array, dist) {
  if(!isDefined(dist))
    dist = 9999999;
  if(array.size < 1)
    return;
  ent = undefined;
  for(i = 0; i < array.size; i++) {
    if(!isalive(array[i]))
      continue;
    newdist = distance(array[i].origin, org);
    if(newdist >= dist)
      continue;
    dist = newdist;
    ent = array[i];
  }
  return ent;
}

get_highest_dot(start, end, array) {
  if(!array.size) {
    return;
  }
  ent = undefined;
  angles = VectorToAngles(end - start);
  dotforward = anglesToForward(angles);
  dot = -1;
  for(i = 0; i < array.size; i++) {
    angles = vectorToAngles(array[i].origin - start);
    forward = anglesToForward(angles);
    newdot = VectorDot(dotforward, forward);
    if(newdot < dot)
      continue;
    dot = newdot;
    ent = array[i];
  }
  return ent;
}

get_closest_index(org, array, dist) {
  if(!isDefined(dist))
    dist = 9999999;
  if(array.size < 1)
    return;
  index = undefined;
  for(i = 0; i < array.size; i++) {
    newdist = distance(array[i].origin, org);
    if(newdist >= dist)
      continue;
    dist = newdist;
    index = i;
  }
  return index;
}

get_farthest(org, array) {
  if(array.size < 1) {
    return;
  }
  dist = Distance(array[0].origin, org);
  ent = array[0];
  for(i = 1; i < array.size; i++) {
    newdist = Distance(array[i].origin, org);
    if(newdist <= dist) {
      continue;
    }
    dist = newdist;
    ent = array[i];
  }
  return ent;
}

get_closest_exclude(org, ents, excluders) {
  if(!isDefined(ents))
    return undefined;
  range = 0;
  if(isDefined(excluders) && excluders.size) {
    exclude = [];
    for(i = 0; i < ents.size; i++)
      exclude[i] = false;
    for(i = 0; i < ents.size; i++)
      for(p = 0; p < excluders.size; p++)
        if(ents[i] == excluders[p])
          exclude[i] = true;
    found_unexcluded = false;
    for(i = 0; i < ents.size; i++)
      if((!exclude[i]) && (isDefined(ents[i]))) {
        found_unexcluded = true;
        range = distance(org, ents[i].origin);
        ent = i;
        i = ents.size + 1;
      }
    if(!found_unexcluded)
      return (undefined);
  } else {
    for(i = 0; i < ents.size; i++)
      if(isDefined(ents[i])) {
        range = distance(org, ents[0].origin);
        ent = i;
        i = ents.size + 1;
      }
  }
  ent = undefined;
  for(i = 0; i < ents.size; i++)
    if(isDefined(ents[i])) {
      exclude = false;
      if(isDefined(excluders)) {
        for(p = 0; p < excluders.size; p++)
          if(ents[i] == excluders[p])
            exclude = true;
      }
      if(!exclude) {
        newrange = distance(org, ents[i].origin);
        if(newrange <= range) {
          range = newrange;
          ent = i;
        }
      }
    }
  if(isDefined(ent))
    return ents[ent];
  else
    return undefined;
}

get_closest_ai(org, team) {
  if(isDefined(team))
    ents = GetAiArray(team);
  else
    ents = GetAiArray();
  if(ents.size == 0)
    return undefined;
  return getClosest(org, ents);
}

get_array_of_closest(org, array, excluders, max, maxdist) {
  if(!isDefined(max))
    max = array.size;
  if(!isDefined(excluders))
    excluders = [];
  maxdists2rd = undefined;
  if(isDefined(maxdist))
    maxdists2rd = maxdist * maxdist;
  dist = [];
  index = [];
  for(i = 0; i < array.size; i++) {
    excluded = false;
    for(p = 0; p < excluders.size; p++) {
      if(array[i] != excluders[p])
        continue;
      excluded = true;
      break;
    }
    if(excluded) {
      continue;
    }
    length = distancesquared(org, array[i].origin);
    if(isDefined(maxdists2rd) && maxdists2rd < length) {
      continue;
    }
    dist[dist.size] = length;
    index[index.size] = i;
  }
  for(;;) {
    change = false;
    for(i = 0; i < dist.size - 1; i++) {
      if(dist[i] <= dist[i + 1])
        continue;
      change = true;
      temp = dist[i];
      dist[i] = dist[i + 1];
      dist[i + 1] = temp;
      temp = index[i];
      index[i] = index[i + 1];
      index[i + 1] = temp;
    }
    if(!change) {
      break;
    }
  }
  newArray = [];
  if(max > dist.size)
    max = dist.size;
  for(i = 0; i < max; i++)
    newArray[i] = array[index[i]];
  return newArray;
}

get_closest_ai_exclude(org, team, excluders) {
  if(isDefined(team))
    ents = GetAiArray(team);
  else
    ents = GetAiArray();
  if(ents.size == 0)
    return undefined;
  return get_closest_exclude(org, ents, excluders);
}

stop_magic_bullet_shield() {
  self notify("stop_magic_bullet_shield");
  assertex(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield, "Tried to stop magic bullet shield on a guy without magic bulletshield");
  if(self.health > self.mbs_oldhealth) {
    self.health = self.mbs_oldhealth;
  }
  self.a.nextStandingHitDying = self.mbs_anim_nextStandingHitDying;
  self.attackerAccuracy = 1;
  self.mbs_oldhealth = undefined;
  self.mbs_anim_nextStandingHitDying = undefined;
  self.magic_bullet_shield = undefined;
  self BloodImpact(true);
  self notify("internal_stop_magic_bullet_shield");
}

magic_bullet_death_detection() {
  self endon("internal_stop_magic_bullet_shield");
  export = self.export;
  self waittill("death");
}

magic_bullet_shield(health, time, oldhealth, maxhealth_modifier, no_death_detection) {
  if(IsAI(self)) {
    assertex(isalive(self), "Tried to do magic_bullet_shield on a dead or undefined guy.");
    assertex(!self.delayedDeath, "Tried to do magic_bullet_shield on a guy about to die.");
  }
  self endon("internal_stop_magic_bullet_shield");
  assertex(!isDefined(self.magic_bullet_shield), "Can't call magic bullet shield on a character twice. Use make_hero and remove_heroes_from_array so that you don't end up with shielded guys in your logic.");
  if(!isDefined(maxhealth_modifier))
    maxhealth_modifier = 1;
  if(!isDefined(oldhealth))
    oldhealth = self.health;
  self.mbs_oldhealth = oldhealth;
  if(IsAI(self)) {
    self.mbs_anim_nextStandingHitDying = self.a.nextStandingHitDying;
    self.attackerAccuracy = 0;
    self.a.disableLongDeath = true;
    self.a.nextStandingHitDying = false;
  }
  if(!isDefined(no_death_detection))
    thread magic_bullet_death_detection();
  else
    assertex(no_death_detection, "no_death_detection must be undefined or true");
  self.magic_bullet_shield = true;
  if(!isDefined(time))
    time = 0;
  if(!isDefined(health))
    health = 100000000;
  assertex(health >= 5000, "MagicBulletShield shouldnt be set with low health amounts like < 5000");
  self BloodImpact(false);
  while(1) {
    self.health = health;
    self.maxhealth = (self.health * maxhealth_modifier);
    oldHealth = self.health;
    self waittill("pain");
    if(oldHealth == self.health) {
      continue;
    }
    assertex(self.health > 1000, "Magic bullet shield guy got impossibly low health");
    if(time > 0)
      self thread ignore_me_timer(time);
    self thread turret_ignore_me_timer(5);
  }
}

disable_long_death() {
  assertex(isalive(self), "Tried to disable long death on a non living thing");
  self.a.disableLongDeath = true;
}

enable_long_death() {
  assertex(isalive(self), "Tried to enable long death on a non living thing");
  self.a.disableLongDeath = false;
}

deletable_magic_bullet_shield(health, time, oldhealth, maxhealth_modifier) {
  magic_bullet_shield(health, time, oldhealth, maxhealth_modifier, true);
}

get_ignoreme() {
  return self.ignoreme;
}

set_ignoreme(val) {
  assertex(IsSentient(self), "Non ai tried to set ignoreme");
  self.ignoreme = val;
}

set_ignoreall(val) {
  assertEx(isSentient(self), "Non ai tried to set ignoraell");
  self.ignoreall = val;
}

get_pacifist() {
  return self.pacifist;
}

set_pacifist(val) {
  assertex(IsSentient(self), "Non ai tried to set pacifist");
  self.pacifist = val;
}

ignore_me_timer(time) {
  if(!isDefined(self.ignore_me_timer_prev_value))
    self.ignore_me_timer_prev_value = self.ignoreme;
  ai = GetAiArray("axis");
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!IsAlive(guy.enemy))
      continue;
    if(guy.enemy != self)
      continue;
    guy notify("enemy");
  }
  self endon("death");
  self endon("pain");
  self.a.disablePain = true;
  self.ignoreme = true;
  wait(time);
  self.a.disablePain = false;
  self.ignoreme = self.ignore_me_timer_prev_value;
  self.ignore_me_timer_prev_value = undefined;
}

turret_ignore_me_timer(time) {
  self endon("death");
  self endon("pain");
  self.turretInvulnerability = true;
  wait time;
  self.turretInvulnerability = false;
}

array_randomize(array) {
  for(i = 0; i < array.size; i++) {
    j = RandomInt(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
  return array;
}

array_reverse(array) {
  array2 = [];
  for(i = array.size - 1; i >= 0; i--)
    array2[array2.size] = array[i];
  return array2;
}

exploder_damage() {
  if(isDefined(self.v["delay"]))
    delay = self.v["delay"];
  else
    delay = 0;
  if(isDefined(self.v["damage_radius"]))
    radius = self.v["damage_radius"];
  else
    radius = 128;
  damage = self.v["damage"];
  origin = self.v["origin"];
  wait(delay);
  RadiusDamage(origin, radius, damage, damage);
}

exploder(num) {
  [[level.exploderFunction]](num);
}

exploder_before_load(num) {
  waittillframeend;
  waittillframeend;
  activate_exploder(num);
}

exploder_after_load(num) {
  activate_exploder(num);
}

activate_exploder_on_clients(num) {
  if(!isDefined(level._exploder_ids[num])) {
    return;
  }
  if(!isDefined(level._client_exploders[num])) {
    level._client_exploders[num] = 1;
  }
  if(!isDefined(level._client_exploder_ids[num])) {
    level._client_exploder_ids[num] = 1;
  }
  ActivateClientExploder(level._exploder_ids[num]);
}

delete_exploder_on_clients(num) {
  if(!isDefined(level._exploder_ids[num])) {
    return;
  }
  if(!isDefined(level._client_exploders[num])) {
    return;
  }
  level._client_exploders[num] = undefined;
  level._client_exploder_ids[num] = undefined;
  DeactivateClientExploder(level._exploder_ids[num]);
}

activate_exploder(num) {
  num = int(num);
  client_send = true;
  prof_begin("activate_exploder");
  for(i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    if(!isDefined(ent)) {
      continue;
    }
    if(ent.v["type"] != "exploder") {
      continue;
    }
    if(!isDefined(ent.v["exploder"])) {
      continue;
    }
    if(ent.v["exploder"] != num) {
      continue;
    }
    if(isDefined(ent.v["exploder_server"])) {
      client_send = false;
    }
    ent activate_individual_exploder();
  }
  if(level.clientScripts) {
    if(!level.createFX_enabled && client_send == true) {
      activate_exploder_on_clients(num);
    }
  }
  prof_end("activate_exploder");
}

stop_exploder(num) {
  num = int(num);
  if(level.clientScripts) {
    if(!level.createFX_enabled) {
      delete_exploder_on_clients(num);
    }
  }
  for(i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    if(!isDefined(ent)) {
      continue;
    }
    if(ent.v["type"] != "exploder") {
      continue;
    }
    if(!isDefined(ent.v["exploder"])) {
      continue;
    }
    if(ent.v["exploder"] != num) {
      continue;
    }
    if(!isDefined(ent.looper)) {
      continue;
    }
    ent.looper delete();
  }
}

activate_individual_exploder() {
  if(level.createFX_enabled || !level.clientScripts || !isDefined(level._exploder_ids[int(self.v["exploder"])]) || isDefined(self.exploder_server)) {
    println("Exploder " + self.v["exploder"] + " created on server.");
    if(isDefined(self.v["firefx"]))
      self thread fire_effect();
    if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX")
      self thread cannon_effect();
    else
    if(isDefined(self.v["soundalias"]))
      self thread sound_effect();
    if(isDefined(self.v["earthquake"]))
      self thread exploder_earthquake();
    if(isDefined(self.v["rumble"]))
      self thread exploder_rumble();
  }
  if(isDefined(self.v["trailfx"])) {
    self thread trail_effect();
  }
  if(isDefined(self.v["damage"]))
    self thread exploder_damage();
  if(self.v["exploder_type"] == "exploder")
    self thread brush_show();
  else
  if((self.v["exploder_type"] == "exploderchunk") || (self.v["exploder_type"] == "exploderchunk visible"))
    self thread brush_throw();
  else
    self thread brush_delete();
}

loop_sound_Delete(ender, ent) {
  ent endon("death");
  self waittill(ender);
  ent Delete();
}

loop_fx_sound(alias, origin, ender, timeout) {
  org = spawn("script_origin", (0, 0, 0));
  if(isDefined(ender)) {
    thread loop_sound_Delete(ender, org);
    self endon(ender);
  }
  org.origin = origin;
  org playLoopSound(alias);
  if(!isDefined(timeout)) {
    return;
  }
  wait(timeout);
}

brush_Delete() {
  num = self.v["exploder"];
  if(isDefined(self.v["delay"]))
    wait(self.v["delay"]);
  else
    wait(.05);
  if(!isDefined(self.model)) {
    return;
  }
  assert(isDefined(self.model));
  if(self.model.spawnflags & 1)
    self.model ConnectPaths();
  if(level.createFX_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
    self.model Hide();
    self.model NotSolid();
    wait(3);
    self.exploded = undefined;
    self.model Show();
    self.model Solid();
    return;
  }
  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX")
    self.v["exploder"] = undefined;
  waittillframeend;
  self.model Delete();
}

brush_Show() {
  if(isDefined(self.v["delay"]))
    wait(self.v["delay"]);
  assert(isDefined(self.model));
  self.model Show();
  self.model Solid();
  if(self.model.spawnflags & 1) {
    if(!isDefined(self.model.disconnect_paths))
      self.model ConnectPaths();
    else
      self.model DisconnectPaths();
  }
  if(level.createFX_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
    wait(3);
    self.exploded = undefined;
    self.model Hide();
    self.model NotSolid();
  }
}

brush_throw() {
  if(isDefined(self.v["delay"]))
    wait(self.v["delay"]);
  ent = undefined;
  if(isDefined(self.v["target"]))
    ent = getent(self.v["target"], "targetname");
  if(!isDefined(ent)) {
    ent = GetStruct(self.v["target"], "targetname");
    if(!isDefined(ent)) {
      self.model Delete();
      return;
    }
  }
  self.model Show();
  startorg = self.v["origin"];
  startang = self.v["angles"];
  org = ent.origin;
  temp_vec = (org - self.v["origin"]);
  x = temp_vec[0];
  y = temp_vec[1];
  z = temp_vec[2];
  physics = isDefined(self.v["physics"]);
  if(physics) {
    target = undefined;
    if(isDefined(ent.target))
      target = getent(ent.target, "targetname");
    if(!isDefined(target)) {
      contact_point = startorg;
      throw_vec = ent.origin;
    } else {
      contact_point = ent.origin;
      throw_vec = vector_multiply(target.origin - ent.origin, self.v["physics"]);
    }
    self.model physicslaunch(contact_point, throw_vec);
    return;
  } else {
    self.model RotateVelocity((x, y, z), 12);
    self.model moveGravity((x, y, z), 12);
  }
  if(level.createFX_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
    wait(3);
    self.exploded = undefined;
    self.v["origin"] = startorg;
    self.v["angles"] = startang;
    self.model Hide();
    return;
  }
  self.v["exploder"] = undefined;
  wait(6);
  self.model Delete();
}

flood_spawn(spawners) {
  maps\_spawner::flood_spawner_scripted(spawners);
}

vector_multiply(vec, dif) {
  vec = (vec[0] * dif, vec[1] * dif, vec[2] * dif);
  return vec;
}

set_ambient(track) {
  level.ambient = track;
  if((isDefined(level.ambient_track)) && (isDefined(level.ambient_track[track]))) {
    ambientPlay(level.ambient_track[track], 2);
    println("playing ambient track ", track);
  }
}

random(array) {
  return array[randomint(array.size)];
}

get_friendly_chain_node(chainstring) {
  chain = undefined;
  trigger = getEntArray("trigger_friendlychain", "classname");
  for(i = 0; i < trigger.size; i++) {
    if((isDefined(trigger[i].script_chain)) && (trigger[i].script_chain == chainstring)) {
      chain = trigger[i];
      break;
    }
  }
  if(!isDefined(chain)) {
    maps\_utility::error("Tried to get chain " + chainstring + " which does not exist with script_chain on a trigger.");
    return undefined;
  }
  node = GetNode(chain.target, "targetname");
  return node;
}

shock_onpain() {
  self endon("death");
  self endon("disconnect");
  if(GetDvar("blurpain") == "") {
    SetDvar("blurpain", "on");
  }
  while(1) {
    oldhealth = self.health;
    self waittill("damage", damage, attacker, direction_vec, point, mod);
    if(isDefined(level.shock_onpain) && !level.shock_onpain) {
      continue;
    }
    if(isDefined(self.shock_onpain) && !self.shock_onpain) {
      continue;
    }
    if(self.health < 1) {
      continue;
    }
    if(mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH") {
      continue;
    } else if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_EXPLOSIVE") {
      self shock_onexplosion(damage);
    } else {
      if(GetDvar("blurpain") == "on") {
        self ShellShock("pain", 0.5);
      }
    }
  }
}

shock_onexplosion(damage) {
  time = 0;
  multiplier = self.maxhealth / 100;
  scaled_damage = damage * multiplier;
  if(scaled_damage >= 90) {
    time = 4;
  } else if(scaled_damage >= 50) {
    time = 3;
  } else if(scaled_damage >= 25) {
    time = 2;
  } else if(scaled_damage > 10) {
    time = 1;
  }
  if(time) {
    self ShellShock("explosion", time);
  }
}

shock_ondeath() {
  self waittill("death");
  if(isDefined(level.shock_ondeath) && !level.shock_ondeath) {
    return;
  }
  if(isDefined(self.shock_ondeath) && !self.shock_ondeath) {
    return;
  }
  if(isDefined(self.specialDeath)) {
    return;
  }
  if(getdvar("r_texturebits") == "16") {
    return;
  }
}

delete_on_death(ent) {
  ent endon("death");
  self waittill("death");
  if(isDefined(ent))
    ent delete();
}

delete_on_death_wait_sound(ent, sounddone) {
  ent endon("death");
  self waittill("death");
  if(isDefined(ent)) {
    if(ent iswaitingonsound())
      ent waittill(sounddone);
    ent Delete();
  }
}

is_dead_sentient() {
  return isSentient(self) && !isalive(self);
}

play_sound_on_tag(alias, tag, ends_on_death) {
  if(is_dead_sentient()) {
    return;
  }
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");
  thread delete_on_death_wait_sound(org, "sounddone");
  if(isDefined(tag))
    org LinkTo(self, tag, (0, 0, 0), (0, 0, 0));
  else {
    org.origin = self.origin;
    org.angles = self.angles;
    org LinkTo(self);
  }
  org playSound(alias, "sounddone");
  if(isDefined(ends_on_death)) {
    assertex(ends_on_death, "ends_on_death must be true or undefined");
    wait_for_sounddone_or_death(org);
    if(is_dead_sentient())
      org StopSounds();
    wait(0.05);
  } else {
    org waittill("sounddone");
  }
  org Delete();
}

play_sound_on_tag_endon_death(alias, tag) {
  play_sound_on_tag(alias, tag, true);
}

play_sound_on_entity(alias) {
  play_sound_on_tag(alias);
}

play_loop_sound_on_tag(alias, tag, bStopSoundOnDeath) {
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");
  if(!isDefined(bStopSoundOnDeath))
    bStopSoundOnDeath = true;
  if(bStopSoundOnDeath)
    thread delete_on_death(org);
  if(isDefined(tag))
    org LinkTo(self, tag, (0, 0, 0), (0, 0, 0));
  else {
    org.origin = self.origin;
    org.angles = self.angles;
    org LinkTo(self);
  }
  org playLoopSound(alias);
  self waittill("stop sound" + alias);
  org StopLoopSound(alias);
  org Delete();
}

stop_loop_sound_on_entity(alias) {
  self notify("stop sound" + alias);
}

play_loop_sound_on_entity(alias, offset) {
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");
  thread delete_on_death(org);
  if(isDefined(offset)) {
    org.origin = self.origin + offset;
    org.angles = self.angles;
    org LinkTo(self);
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org LinkTo(self);
  }
  org playLoopSound(alias);
  self waittill("stop sound" + alias);
  org StopLoopSound(alias);
  org Delete();
}

play_sound_in_space(alias, origin, master) {
  org = spawn("script_origin", (0, 0, 1));
  if(!isDefined(origin))
    origin = self.origin;
  org.origin = origin;
  if(isDefined(master) && master)
    org PlaySoundAsMaster(alias, "sounddone");
  else
    org playSound(alias, "sounddone");
  org waittill("sounddone");
  if(isDefined(org)) {
    org Delete();
  }
}

lookat(ent, timer) {
  if(!isDefined(timer))
    timer = 10000;
  self animscripts\shared::lookatentity(ent, timer, "alert");
}

save_friendlies() {
  ai = GetAiArray("allies");
  game_characters = 0;
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_friendname)) {
      continue;
    }
    game["character" + game_characters] = ai[i] codescripts\character::save();
    game_characters++;
  }
  game["total characters"] = game_characters;
}

spawn_failed(spawn) {
  if(!IsAlive(spawn))
    return true;
  if(!isDefined(spawn.finished_spawning))
    spawn waittill("finished spawning");
  if(IsAlive(spawn))
    return false;
  return true;
}

spawn_setcharacter(data) {
  codescripts\character::precache(data);
  self waittill("spawned", spawn);
  if(maps\_utility::spawn_failed(spawn)) {
    return;
  }
  println("Size is ", data["attach"].size);
  spawn codescripts\character::new();
  spawn codescripts\character::load(data);
}

key_hint_print(message, binding) {
  iprintlnbold(message, binding["key1"]);
}

view_tag(tag) {
  self endon("death");
}

assign_animtree(animname) {
  if(isDefined(animname))
    self.animname = animname;
  assertEx(isDefined(level.scr_animtree[self.animname]), "There is no level.scr_animtree for animname " + self.animname);
  self UseAnimTree(level.scr_animtree[self.animname]);
}

assign_model() {
  assertEx(isDefined(level.scr_model[self.animname]), "There is no level.scr_model for animname " + self.animname);
  self setModel(level.scr_model[self.animname]);
}

spawn_anim_model(animname, origin) {
  if(!isDefined(origin))
    origin = (0, 0, 0);
  model = spawn("script_model", origin);
  model.animname = animname;
  model assign_animtree();
  model assign_model();
  return model;
}

trigger_wait(strName, strKey) {
  eTrigger = GetEnt(strName, strKey);
  if(!isDefined(eTrigger)) {
    assertmsg("trigger not found: " + strName + " key: " + strKey);
    return;
  }
  eTrigger waittill("trigger", eOther);
  level notify(strName, eOther);
  return eOther;
}

trigger_wait_targetname(strName) {
  eTrigger = getent(strName, "targetname");
  if(!isDefined(eTrigger)) {
    assertmsg("trigger not found: " + strName + " targetname ");
    return;
  }
  eTrigger waittill("trigger", eOther);
  level notify(strName, eOther);
  return eOther;
}

set_flag_on_trigger(eTrigger, strFlag) {
  if(!level.flag[strFlag]) {
    eTrigger waittill("trigger", eOther);
    flag_set(strFlag);
    return eOther;
  }
}

set_flag_on_targetname_trigger(msg) {
  assert(isDefined(level.flag[msg]));
  if(flag(msg)) {
    return;
  }
  trigger = GetEnt(msg, "targetname");
  trigger waittill("trigger");
  flag_set(msg);
}

is_in_array(aeCollection, eFindee) {
  for(i = 0; i < aeCollection.size; i++) {
    if(aeCollection[i] == eFindee)
      return (true);
  }
  return (false);
}

waittill_dead(guys, num, timeoutLength) {
  allAlive = true;
  for(i = 0; i < guys.size; i++) {
    if(isalive(guys[i]))
      continue;
    allAlive = false;
    break;
  }
  assertex(allAlive, "Waittill_Dead was called with dead or removed AI in the array, meaning it will never pass.");
  if(!allAlive) {
    newArray = [];
    for(i = 0; i < guys.size; i++) {
      if(isalive(guys[i]))
        newArray[newArray.size] = guys[i];
    }
    guys = newArray;
  }
  ent = spawnStruct();
  if(isDefined(timeoutLength)) {
    ent endon("thread_timed_out");
    ent thread waittill_dead_timeout(timeoutLength);
  }
  ent.count = guys.size;
  if(isDefined(num) && num < ent.count)
    ent.count = num;
  array_thread(guys, ::waittill_dead_thread, ent);
  while(ent.count > 0)
    ent waittill("waittill_dead guy died");
}

waittill_dead_or_dying(guys, num, timeoutLength) {
  newArray = [];
  for(i = 0; i < guys.size; i++) {
    if(isalive(guys[i]) && !guys[i].ignoreForFixedNodeSafeCheck)
      newArray[newArray.size] = guys[i];
  }
  guys = newArray;
  ent = spawnStruct();
  if(isDefined(timeoutLength)) {
    ent endon("thread_timed_out");
    ent thread waittill_dead_timeout(timeoutLength);
  }
  ent.count = guys.size;
  if(isDefined(num) && num < ent.count)
    ent.count = num;
  array_thread(guys, ::waittill_dead_or_dying_thread, ent);
  while(ent.count > 0)
    ent waittill("waittill_dead_guy_dead_or_dying");
}

waittill_dead_thread(ent) {
  self waittill("death");
  ent.count--;
  ent notify("waittill_dead guy died");
}

waittill_dead_or_dying_thread(ent) {
  self waittill_either("death", "pain_death");
  ent.count--;
  ent notify("waittill_dead_guy_dead_or_dying");
}

waittill_dead_timeout(timeoutLength) {
  wait(timeoutLength);
  self notify("thread_timed_out");
}

waittill_aigroupcleared(aigroup) {
  while(level._ai_group[aigroup].spawnercount || level._ai_group[aigroup].aicount)
    wait(0.25);
}

waittill_aigroupcount(aigroup, count) {
  while(level._ai_group[aigroup].spawnercount + level._ai_group[aigroup].aicount > count)
    wait(0.25);
}

get_ai_group_count(aigroup) {
  return (level._ai_group[aigroup].spawnercount + level._ai_group[aigroup].aicount);
}

get_ai_group_sentient_count(aigroup) {
  return (level._ai_group[aigroup].aicount);
}

get_ai_group_ai(aigroup) {
  aiSet = [];
  for(index = 0; index < level._ai_group[aigroup].ai.size; index++) {
    if(!isAlive(level._ai_group[aigroup].ai[index])) {
      continue;
    }
    aiSet[aiSet.size] = level._ai_group[aigroup].ai[index];
  }
  return (aiSet);
}

get_living_ai(name, type) {
  array = get_living_ai_array(name, type);
  if(array.size > 1) {
    assertMsg("get_living_ai used for more than one living ai of type " + type + " called " + name + ".");
    return undefined;
  }
  return array[0];
}

get_living_ai_array(name, type) {
  ai = getaiarray("allies");
  ai = array_combine(ai, getaiarray("axis"));
  array = [];
  for(i = 0; i < ai.size; i++) {
    switch (type) {
      case "targetname": {
        if(isDefined(ai[i].targetname) && ai[i].targetname == name)
          array[array.size] = ai[i];
      }
      break;
      case "script_noteworthy": {
        if(isDefined(ai[i].script_noteworthy) && ai[i].script_noteworthy == name)
          array[array.size] = ai[i];
      }
      break;
      case "classname": {
        if(isDefined(ai[i].classname) && ai[i].classname == name)
          array[array.size] = ai[i];
      }
      break;
    }
  }
  return array;
}

get_living_aispecies(name, type, breed) {
  array = get_living_ai_array(name, type, breed);
  if(array.size > 1) {
    assertMsg("get_living_aispecies used for more than one living ai of type " + type + " called " + name + ".");
    return undefined;
  }
  return array[0];
}

get_living_aispecies_array(name, type, breed) {
  if(!isDefined(breed))
    breed = "all";
  ai = getaispeciesarray("allies", breed);
  ai = array_combine(ai, getaispeciesarray("axis", breed));
  array = [];
  for(i = 0; i < ai.size; i++) {
    switch (type) {
      case "targetname": {
        if(isDefined(ai[i].targetname) && ai[i].targetname == name)
          array[array.size] = ai[i];
      }
      break;
      case "script_noteworthy": {
        if(isDefined(ai[i].script_noteworthy) && ai[i].script_noteworthy == name)
          array[array.size] = ai[i];
      }
      break;
    }
  }
  return array;
}

gather_delay_proc(msg, delay) {
  if(isDefined(level.gather_delay[msg])) {
    if(level.gather_delay[msg]) {
      wait(0.05);
      if(IsAlive(self))
        self notify("gather_delay_finished" + msg + delay);
      return;
    }
    level waittill(msg);
    if(IsAlive(self))
      self notify("gather_delay_finished" + msg + delay);
    return;
  }
  level.gather_delay[msg] = false;
  wait(delay);
  level.gather_delay[msg] = true;
  level notify(msg);
  if(IsAlive(self))
    self notify("gather_delay_finished" + msg + delay);
}

gather_delay(msg, delay) {
  thread gather_delay_proc(msg, delay);
  self waittill("gather_delay_finished" + msg + delay);
}

set_environment(env) {
  animscripts\utility::setEnv(env);
}

death_waiter(notifyString) {
  self waittill("death");
  level notify(notifyString);
}

getchar(num) {
  if(num == 0)
    return "0";
  if(num == 1)
    return "1";
  if(num == 2)
    return "2";
  if(num == 3)
    return "3";
  if(num == 4)
    return "4";
  if(num == 5)
    return "5";
  if(num == 6)
    return "6";
  if(num == 7)
    return "7";
  if(num == 8)
    return "8";
  if(num == 9)
    return "9";
}

waittill_either(msg1, msg2) {
  self endon(msg1);
  self waittill(msg2);
}

getlinks_array(array, linkMap) {
  ents = [];
  for(j = 0; j < array.size; j++) {
    node = array[j];
    script_linkname = node.script_linkname;
    if(!isDefined(script_linkname))
      continue;
    if(!isDefined(linkMap[script_linkname]))
      continue;
    ents[ents.size] = node;
  }
  return ents;
}

array_merge_links(array1, array2) {
  if(!array1.size)
    return array2;
  if(!array2.size)
    return array1;
  linkMap = [];
  for(i = 0; i < array1.size; i++) {
    node = array1[i];
    linkMap[node.script_linkname] = true;
  }
  for(i = 0; i < array2.size; i++) {
    node = array2[i];
    if(isDefined(linkMap[node.script_linkname]))
      continue;
    linkMap[node.script_linkname] = true;
    array1[array1.size] = node;
  }
  return array1;
}

array_combine(array1, array2) {
  if(!array1.size)
    return array2;
  array3 = [];
  keys = getarraykeys(array1);
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    array3[array3.size] = array1[key];
  }
  keys = getarraykeys(array2);
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    array3[array3.size] = array2[key];
  }
  return array3;
}

array_merge(array1, array2) {
  if(array1.size == 0)
    return array2;
  if(array2.size == 0)
    return array1;
  newarray = array1;
  for(i = 0; i < array2.size; i++) {
    foundmatch = false;
    for(j = 0; j < array1.size; j++)
      if(array2[i] == array1[j]) {
        foundmatch = true;
        break;
      }
    if(foundmatch)
      continue;
    else
      newarray[newarray.size] = array2[i];
  }
  return newarray;
}

array_exclude(array, arrayExclude) {
  newarray = array;
  for(i = 0; i < arrayExclude.size; i++) {
    if(is_in_array(array, arrayExclude[i]))
      newarray = array_remove(newarray, arrayExclude[i]);
  }
  return newarray;
}

flat_angle(angle) {
  rangle = (0, angle[1], 0);
  return rangle;
}

flat_origin(org) {
  rorg = (org[0], org[1], 0);
  return rorg;
}

plot_points(plotpoints, r, g, b, timer) {
  lastpoint = plotpoints[0];
  if(!isDefined(r))
    r = 1;
  if(!isDefined(g))
    g = 1;
  if(!isDefined(b))
    b = 1;
  if(!isDefined(timer))
    timer = 0.05;
  for(i = 1; i < plotpoints.size; i++) {
    thread draw_line_for_time(lastpoint, plotpoints[i], r, g, b, timer);
    lastpoint = plotpoints[i];
  }
}

draw_line_for_time(org1, org2, r, g, b, timer) {
  timer = gettime() + (timer * 1000);
  while(GetTime() < timer) {
    line(org1, org2, (r, g, b), 1);
    wait .05;
  }
}

draw_line_to_ent_for_time(org1, ent, r, g, b, timer) {
  timer = gettime() + (timer * 1000);
  while(GetTime() < timer) {
    line(org1, ent.origin, (r, g, b), 1);
    wait .05;
  }
}

draw_line_from_ent_for_time(ent, org, r, g, b, timer) {
  draw_line_to_ent_for_time(org, ent, r, g, b, timer);
}

draw_line_from_ent_to_ent_for_time(ent1, ent2, r, g, b, timer) {
  ent1 endon("death");
  ent2 endon("death");
  timer = gettime() + (timer * 1000);
  while(gettime() < timer) {
    line(ent1.origin, ent2.origin, (r, g, b), 1);
    wait .05;
  }
}

draw_line_from_ent_to_ent_until_notify(ent1, ent2, r, g, b, notifyEnt, notifyString) {
  assert(isDefined(notifyEnt));
  assert(isDefined(notifyString));
  ent1 endon("death");
  ent2 endon("death");
  notifyEnt endon(notifyString);
  while(1) {
    line(ent1.origin, ent2.origin, (r, g, b), 0.05);
    wait .05;
  }
}

draw_line_until_notify(org1, org2, r, g, b, notifyEnt, notifyString) {
  assert(isDefined(notifyEnt));
  assert(isDefined(notifyString));
  notifyEnt endon(notifyString);
  while(1) {
    draw_line_for_time(org1, org2, r, g, b, 0.05);
  }
}

draw_arrow_time(start, end, color, duration) {
  level endon("newpath");
  pts = [];
  angles = VectorToAngles(start - end);
  right = AnglesToRight(angles);
  forward = anglesToForward(angles);
  up = AnglesToUp(angles);
  dist = Distance(start, end);
  arrow = [];
  range = 0.1;
  arrow[0] = start;
  arrow[1] = start + vectorScale(right, dist * (range)) + vectorScale(forward, dist * -0.1);
  arrow[2] = end;
  arrow[3] = start + vectorScale(right, dist * (-1 * range)) + vectorScale(forward, dist * -0.1);
  arrow[4] = start;
  arrow[5] = start + vectorScale(up, dist * (range)) + vectorScale(forward, dist * -0.1);
  arrow[6] = end;
  arrow[7] = start + vectorScale(up, dist * (-1 * range)) + vectorScale(forward, dist * -0.1);
  arrow[8] = start;
  r = color[0];
  g = color[1];
  b = color[2];
  plot_points(arrow, r, g, b, duration);
}

draw_arrow(start, end, color) {
  level endon("newpath");
  pts = [];
  angles = VectorToAngles(start - end);
  right = AnglesToRight(angles);
  forward = anglesToForward(angles);
  dist = Distance(start, end);
  arrow = [];
  range = 0.05;
  arrow[0] = start;
  arrow[1] = start + vectorScale(right, dist * (range)) + vectorScale(forward, dist * -0.2);
  arrow[2] = end;
  arrow[3] = start + vectorScale(right, dist * (-1 * range)) + vectorScale(forward, dist * -0.2);
  for(p = 0; p < 4; p++) {
    nextpoint = p + 1;
    if(nextpoint >= 4)
      nextpoint = 0;
    line(arrow[p], arrow[nextpoint], color, 1.0);
  }
}

clear_enemy_passthrough() {
  self notify("enemy");
  self ClearEnemy();
}

battlechatter_off(team) {
  if(!isDefined(level.battlechatter)) {
    level.battlechatter = [];
    level.battlechatter["axis"] = true;
    level.battlechatter["allies"] = true;
    level.battlechatter["neutral"] = true;
  }
  if(isDefined(team)) {
    level.battlechatter[team] = false;
    soldiers = GetAiArray(team);
  } else {
    level.battlechatter["axis"] = false;
    level.battlechatter["allies"] = false;
    level.battlechatter["neutral"] = false;
    soldiers = GetAiArray();
  }
  if(!isDefined(anim.chatInitialized) || !anim.chatInitialized) {
    return;
  }
  for(index = 0; index < soldiers.size; index++) {
    if(!isDefined(team) || soldiers[index].team == team)
      soldiers[index].battlechatter = false;
  }
  had_to_wait = false;
  for(index = 0; index < soldiers.size; index++) {
    soldier = soldiers[index];
    if(!IsAlive(soldier)) {
      continue;
    }
    if(!soldier.chatInitialized) {
      continue;
    }
    if(!soldier.isSpeaking) {
      continue;
    }
    soldier wait_until_done_speaking();
    had_to_wait = true;
  }
  if(had_to_wait) {
    wait(1.5);
  }
  if(isDefined(team)) {
    level notify(team + " done speaking");
  } else {
    level notify("done speaking");
  }
}

battlechatter_on(team) {
  thread battlechatter_on_thread(team);
}

battlechatter_on_thread(team) {
  if(!isDefined(level.battlechatter) && !isDefined(team)) {
    level.battlechatter = [];
    level.battlechatter["axis"] = true;
    level.battlechatter["allies"] = true;
    level.battlechatter["neutral"] = true;
  } else if(!isDefined(level.battlechatter) && isDefined(team)) {
    level.battlechatter = [];
    level.battlechatter["axis"] = false;
    level.battlechatter["allies"] = false;
    level.battlechatter["neutral"] = false;
    level.battlechatter[team] = true;
  }
  if(!anim.chatInitialized) {
    return;
  }
  wait(1.5);
  if(isDefined(team)) {
    level.battlechatter[team] = true;
    soldiers = GetAiArray(team);
  } else {
    level.battlechatter["axis"] = true;
    level.battlechatter["allies"] = true;
    level.battlechatter["neutral"] = true;
    soldiers = GetAiArray();
  }
  for(index = 0; index < soldiers.size; index++)
    soldiers[index] set_battlechatter(true);
}

set_battlechatter(state) {
  if(!anim.chatInitialized) {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  if(state) {
    if(isDefined(self.script_bcdialog) && !self.script_bcdialog)
      self.battlechatter = false;
    else
      self.battlechatter = true;
  } else {
    self.battlechatter = false;
    while(isDefined(self.isSpeaking) && self.isSpeaking)
      wait(.05);
  }
}

set_friendly_chain_wrapper(node) {
  self SetFriendlyChain(node);
  level notify("newFriendlyChain", node.script_noteworthy);
}

get_obj_origin(msg) {
  objOrigins = getEntArray("objective", "targetname");
  for(i = 0; i < objOrigins.size; i++) {
    if(objOrigins[i].script_noteworthy == msg)
      return objOrigins[i].origin;
  }
}

get_obj_event(msg) {
  objEvents = getEntArray("objective_event", "targetname");
  for(i = 0; i < objEvents.size; i++) {
    if(objEvents[i].script_noteworthy == msg)
      return objEvents[i];
  }
}

waittill_objective_event() {
  waittill_objective_event_proc(true);
}

waittill_objective_event_notrigger() {
  waittill_objective_event_proc(false);
}

flood_begin() {
  self notify("flood_begin");
}

debugorigin() {
  self notify("Debug origin");
  self endon("Debug origin");
  self endon("death");
  for(;;) {
    forward = anglesToForward(self.angles);
    forwardFar = vectorScale(forward, 30);
    forwardClose = vectorScale(forward, 20);
    right = AnglesToRight(self.angles);
    left = vectorScale(right, -10);
    right = vectorScale(right, 10);
    line(self.origin, self.origin + forwardFar, (0.9, 0.7, 0.6), 0.9);
    line(self.origin + forwardFar, self.origin + forwardClose + right, (0.9, 0.7, 0.6), 0.9);
    line(self.origin + forwardFar, self.origin + forwardClose + left, (0.9, 0.7, 0.6), 0.9);
    wait(0.05);
  }
}

get_links() {
  return Strtok(self.script_linkTo, " ");
}

get_linked_ents() {
  array = [];
  if(isDefined(self.script_linkto)) {
    linknames = get_links();
    for(i = 0; i < linknames.size; i++) {
      ent = getent(linknames[i], "script_linkname");
      if(isDefined(ent)) {
        array[array.size] = ent;
      }
    }
  }
  return array;
}

get_linked_structs() {
  array = [];
  if(isDefined(self.script_linkto)) {
    linknames = get_links();
    for(i = 0; i < linknames.size; i++) {
      ent = getstruct(linknames[i], "script_linkname");
      if(isDefined(ent)) {
        array[array.size] = ent;
      }
    }
  }
  return array;
}

get_last_ent_in_chain(sEntityType) {
  ePathpoint = self;
  while(isDefined(ePathpoint.target)) {
    wait(0.05);
    if(isDefined(ePathpoint.target)) {
      switch (sEntityType) {
        case "vehiclenode":
          ePathpoint = getvehiclenode(ePathpoint.target, "targetname");
          break;
        case "pathnode":
          ePathpoint = getnode(ePathpoint.target, "targetname");
          break;
        case "ent":
          ePathpoint = getent(ePathpoint.target, "targetname");
          break;
        default:
          assertmsg("sEntityType needs to be 'vehiclenode', 'pathnode' or 'ent'");
      }
    } else
      break;
  }
  ePathend = ePathpoint;
  return ePathend;
}

timeout(timeout) {
  self endon("death");
  wait(timeout);
  self notify("timeout");
}

set_forcegoal() {
  if(isDefined(self.set_forcedgoal)) {
    return;
  }
  self.oldfightdist = self.pathenemyfightdist;
  self.oldmaxdist = self.pathenemylookahead;
  self.oldmaxsight = self.maxsightdistsqrd;
  self.pathenemyfightdist = 8;
  self.pathenemylookahead = 8;
  self.maxsightdistsqrd = 1;
  self.set_forcedgoal = true;
}

unset_forcegoal() {
  if(!isDefined(self.set_forcedgoal)) {
    return;
  }
  self.pathenemyfightdist = self.oldfightdist;
  self.pathenemylookahead = self.oldmaxdist;
  self.maxsightdistsqrd = self.oldmaxsight;
  self.set_forcedgoal = undefined;
}

array_add(array, ent) {
  array[array.size] = ent;
  return array;
}

array_removeDead_keepkeys(array) {
  newArray = [];
  keys = getarraykeys(array);
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    if(!isalive(array[key]))
      continue;
    newArray[key] = array[key];
  }
  return newArray;
}

array_removeDead(array) {
  newArray = [];
  for(i = 0; i < array.size; i++) {
    if(!isalive(array[i]))
      continue;
    newArray[newArray.size] = array[i];
  }
  return newArray;
}

array_removeUndefined(array) {
  newArray = [];
  for(i = 0; i < array.size; i++) {
    if(!isDefined(array[i]))
      continue;
    newArray[newArray.size] = array[i];
  }
  return newArray;
}

array_insert(array, object, index) {
  if(index == array.size) {
    temp = array;
    temp[temp.size] = object;
    return temp;
  }
  temp = [];
  offset = 0;
  for(i = 0; i < array.size; i++) {
    if(i == index) {
      temp[i] = object;
      offset = 1;
    }
    temp[i + offset] = array[i];
  }
  return temp;
}

array_remove(ents, remover, keepArrayKeys) {
  newents = [];
  keys = getArrayKeys(ents);
  if(isDefined(keepArrayKeys)) {
    for(i = keys.size - 1; i >= 0; i--) {
      if(ents[keys[i]] != remover)
        newents[keys[i]] = ents[keys[i]];
    }
    return newents;
  }
  for(i = keys.size - 1; i >= 0; i--) {
    if(ents[keys[i]] != remover)
      newents[newents.size] = ents[keys[i]];
  }
  return newents;
}

array_remove_nokeys(ents, remover) {
  newents = [];
  for(i = 0; i < ents.size; i++)
    if(ents[i] != remover)
      newents[newents.size] = ents[i];
  return newents;
}

array_remove_index(array, index) {
  newArray = [];
  keys = getArrayKeys(array);
  for(i = (keys.size - 1); i >= 0; i--) {
    if(keys[i] != index)
      newArray[newArray.size] = array[keys[i]];
  }
  return newArray;
}

array_notify(ents, notifier) {
  for(i = 0; i < ents.size; i++)
    ents[i] notify(notifier);
}

array_check_for_dupes(array, single) {
  for(i = 0; i < array.size; i++) {
    if(array[i] == single) {
      return false;
    }
  }
  return true;
}

array_swap(array, index1, index2) {
  assertEx(index1 < array.size, "index1 to swap out of range");
  assertEx(index2 < array.size, "index2 to swap out of range");
  temp = array[index1];
  array[index1] = array[index2];
  array[index2] = temp;
}

getstruct(name, type) {
  assertEx(isDefined(level.struct_class_names), "Tried to getstruct before the structs were init");
  array = level.struct_class_names[type][name];
  if(!isDefined(array)) {
    return undefined;
  }
  if(array.size > 1) {
    assertMsg("getstruct used for more than one struct of type " + type + " called " + name + ".");
    return undefined;
  }
  return array[0];
}

struct_arrayspawn() {
  struct = spawnStruct();
  struct.array = [];
  struct.lastindex = 0;
  return struct;
}

structarray_add(struct, object) {
  assert(!isDefined(object.struct_array_index));
  struct.array[struct.lastindex] = object;
  object.struct_array_index = struct.lastindex;
  struct.lastindex++;
}

structarray_remove(struct, object) {
  structarray_swaptolast(struct, object);
  struct.array[struct.lastindex - 1] = undefined;
  struct.lastindex--;
}

structarray_swaptolast(struct, object) {
  struct structarray_swap(struct.array[struct.lastindex - 1], object);
}

structarray_shuffle(struct, shuffle) {
  for(i = 0; i < shuffle; i++)
    struct structarray_swap(struct.array[i], struct.array[randomint(struct.lastindex)]);
}

set_ambient_alias(ambient, alias) {
  level.ambient_modifier[ambient] = alias;
  if(level.ambient == ambient)
    maps\_ambient::activateAmbient(ambient);
}

get_use_key() {
  if(level.console) {
    return " + usereload";
  } else {
    return " + activate";
  }
}

custom_battlechatter(string) {
  excluders = [];
  excluders[0] = self;
  buddy = get_closest_ai_exclude(self.origin, self.team, excluders);
  if(isDefined(buddy) && Distance(buddy.origin, self.origin) > 384)
    buddy = undefined;
  self animscripts\battlechatter_ai::beginCustomEvent();
  tokens = Strtok(string, "_");
  if(!tokens.size) {
    return;
  }
  if(tokens[0] == "move") {
    if(tokens.size > 1)
      modifier = tokens[1];
    else
      modifier = "generic";
    self animscripts\battlechatter_ai::addGenericAliasEx("order", "move", modifier);
  } else if(tokens[0] == "infantry") {
    self animscripts\battlechatter_ai::addGenericAliasEx("threat", "infantry", tokens[1]);
    if(tokens.size > 2 && tokens[2] != "inbound")
      self animscripts\battlechatter_ai::addGenericAliasEx("direction", "relative", tokens[2]);
    else if(tokens.size > 2)
      self animscripts\battlechatter_ai::addGenericAliasEx("direction", "inbound", tokens[3]);
  } else if(tokens[0] == "vehicle") {
    self animscripts\battlechatter_ai::addGenericAliasEx("threat", "vehicle", tokens[1]);
    if(tokens.size > 2 && tokens[2] != "inbound")
      self animscripts\battlechatter_ai::addGenericAliasEx("direction", "relative", tokens[2]);
    else if(tokens.size > 2)
      self animscripts\battlechatter_ai::addGenericAliasEx("direction", "inbound", tokens[3]);
  }
  self animscripts\battlechatter_ai::endCustomEvent(2000);
}

force_custom_battlechatter(string, targetAI) {
  tokens = Strtok(string, "_");
  soundAliases = [];
  if(!tokens.size) {
    return;
  }
  if(isDefined(targetAI) && (isDefined(targetAI.bcName) || isDefined(targetAI.bcRank))) {
    if(isDefined(targetAI.bcName))
      nameAlias = self buildBCAlias("name", targetAI.bcName);
    else
      nameAlias = self buildBCAlias("rank", targetAI.bcRank);
    if(SoundExists(nameAlias))
      soundAliases[soundAliases.size] = nameAlias;
  }
  if(tokens[0] == "move") {
    if(tokens.size > 1)
      modifier = tokens[1];
    else
      modifier = "generic";
    soundAliases[soundAliases.size] = self buildBCAlias("order", "move", modifier);
  } else if(tokens[0] == "infantry") {
    soundAliases[soundAliases.size] = self buildBCAlias("threat", "infantry", tokens[1]);
    if(tokens.size > 2 && tokens[2] != "inbound")
      soundAliases[soundAliases.size] = self buildBCAlias("direction", "relative", tokens[2]);
    else if(tokens.size > 2)
      soundAliases[soundAliases.size] = self buildBCAlias("direction", "inbound", tokens[3]);
  } else if(tokens[0] == "vehicle") {
    soundAliases[soundAliases.size] = self buildBCAlias("threat", "vehicle", tokens[1]);
    if(tokens.size > 2 && tokens[2] != "inbound")
      soundAliases[soundAliases.size] = self buildBCAlias("direction", "relative", tokens[2]);
    else if(tokens.size > 2)
      soundAliases[soundAliases.size] = self buildBCAlias("direction", "inbound", tokens[3]);
  } else if(tokens[0] == "order") {
    if(tokens.size > 1)
      modifier = tokens[1];
    else
      modifier = "generic";
    soundAliases[soundAliases.size] = self buildBCAlias("order", "action", modifier);
  } else if(tokens[0] == "cover") {
    if(tokens.size > 1)
      modifier = tokens[1];
    else
      modifier = "generic";
    soundAliases[soundAliases.size] = self buildBCAlias("order", "cover", modifier);
  }
  for(index = 0; index < soundAliases.size; index++) {
    self playSound(soundAliases[index], soundAliases[index], true);
    self waittill(soundAliases[index]);
  }
}

buildBCAlias(action, type, modifier) {
  if(isDefined(modifier))
    return (self.countryID + "_" + self.npcID + "_" + action + "_" + type + "_" + modifier);
  else
    return (self.countryID + "_" + self.npcID + "_" + action + "_" + type);
}

get_stop_watch(time, othertime) {
  watch = NewHudElem();
  if(level.console) {
    watch.x = 68;
    watch.y = 35;
  } else {
    watch.x = 58;
    watch.y = 95;
  }
  watch.alignx = "center";
  watch.aligny = "middle";
  watch.horzAlign = "left";
  watch.vertAlign = "middle";
  if(isDefined(othertime))
    timer = othertime;
  else
    timer = level.explosiveplanttime;
  watch setClock(timer, time, "hudStopwatch", 64, 64);
  return watch;
}

objective_is_active(msg) {
  active = false;
  for(i = 0; i < level.active_objective.size; i++) {
    if(level.active_objective[i] != msg)
      continue;
    active = true;
    break;
  }
  return (active);
}

objective_is_inactive(msg) {
  inactive = false;
  for(i = 0; i < level.inactive_objective.size; i++) {
    if(level.inactive_objective[i] != msg)
      continue;
    inactive = true;
    break;
  }
  return (inactive);
}

set_objective_inactive(msg) {
  array = [];
  for(i = 0; i < level.active_objective.size; i++) {
    if(level.active_objective[i] == msg)
      continue;
    array[array.size] = level.active_objective[i];
  }
  level.active_objective = array;
  exists = false;
  for(i = 0; i < level.inactive_objective.size; i++) {
    if(level.inactive_objective[i] != msg)
      continue;
    exists = true;
  }
  if(!exists)
    level.inactive_objective[level.inactive_objective.size] = msg;
  for(i = 0; i < level.active_objective.size; i++) {
    for(p = 0; p < level.inactive_objective.size; p++)
      assertEx(level.active_objective[i] != level.inactive_objective[p], "Objective is both inactive and active");
  }
}

set_objective_active(msg) {
  array = [];
  for(i = 0; i < level.inactive_objective.size; i++) {
    if(level.inactive_objective[i] == msg)
      continue;
    array[array.size] = level.inactive_objective[i];
  }
  level.inactive_objective = array;
  exists = false;
  for(i = 0; i < level.active_objective.size; i++) {
    if(level.active_objective[i] != msg)
      continue;
    exists = true;
  }
  if(!exists)
    level.active_objective[level.active_objective.size] = msg;
  for(i = 0; i < level.active_objective.size; i++) {
    for(p = 0; p < level.inactive_objective.size; p++)
      assertEx(level.active_objective[i] != level.inactive_objective[p], "Objective is both inactive and active");
  }
}

missionFailedWrapper() {
  if(level.missionfailed) {
    return;
  }
  if(isDefined(level.nextmission)) {
    return;
  }
  level.missionfailed = true;
  flag_set("missionfailed");
  if(getdvar("failure_disabled") == "1") {
    return;
  }
  MissionFailed();
}

nextmission() {
  maps\_endmission::_nextmission();
}

script_delay() {
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
    return true;
  } else
  if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    wait(RandomFloatrange(self.script_delay_min, self.script_delay_max));
    return true;
  }
  return false;
}

script_wait(called_from_spawner) {
  if(!isDefined(called_from_spawner)) {
    called_from_spawner = false;
  }
  coop_scalar = 1;
  if(called_from_spawner) {
    players = get_players();
    if(players.size == 2) {
      coop_scalar = 0.7;
    } else if(players.size == 3) {
      coop_scalar = 0.4;
    } else if(players.size == 4) {
      coop_scalar = 0.1;
    }
  }
  startTime = GetTime();
  if(isDefined(self.script_wait)) {
    wait(self.script_wait * coop_scalar);
    if(isDefined(self.script_wait_add))
      self.script_wait += self.script_wait_add;
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    wait(RandomFloatrange(self.script_wait_min, self.script_wait_max) * coop_scalar);
    if(isDefined(self.script_wait_add)) {
      self.script_wait_min += self.script_wait_add;
      self.script_wait_max += self.script_wait_add;
    }
  }
  return (GetTime() - startTime);
}

guy_enter_vehicle(guy, vehicle) {
  maps\_vehicle_aianim::guy_enter(guy, vehicle);
}

guy_array_enter_vehicle(guy, vehicle) {
  maps\_vehicle_aianim::guy_array_enter(guy, vehicle);
}

guy_runtovehicle_load(guy, vehicle) {
  maps\_vehicle_aianim::guy_runtovehicle(guy, vehicle);
}

get_force_color_guys(team, color) {
  ai = GetAiArray(team);
  guys = [];
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!isDefined(guy.script_forceColor)) {
      continue;
    }
    if(guy.script_forceColor != color)
      continue;
    guys[guys.size] = guy;
  }
  return guys;
}

get_all_force_color_friendlies() {
  ai = GetAiArray("allies");
  guys = [];
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!isDefined(guy.script_forceColor))
      continue;
    guys[guys.size] = guy;
  }
  return guys;
}

enable_ai_color() {
  if(isDefined(self.script_forceColor))
    return;
  if(!isDefined(self.old_forceColor)) {
    return;
  }
  set_force_color(self.old_forcecolor);
  self.old_forceColor = undefined;
}

disable_ai_color() {
  if(isDefined(self.new_force_color_being_set)) {
    self endon("death");
    self waittill("done_setting_new_color");
  }
  self clearFixedNodeSafeVolume();
  if(!isDefined(self.script_forceColor)) {
    return;
  }
  assertEx(!isDefined(self.old_forcecolor), "Tried to disable forcecolor on a guy that somehow had a old_forcecolor already. Investigate!!!");
  self.old_forceColor = self.script_forceColor;
  level.arrays_of_colorForced_ai[self.team][self.script_forcecolor] = array_remove(level.arrays_of_colorForced_ai[self.team][self.script_forcecolor], self);
  maps\_colors::left_color_node();
  self.script_forceColor = undefined;
  self.currentColorCode = undefined;
  update_debug_friendlycolor(self.ai_number);
}

clear_force_color() {
  disable_ai_color();
}

check_force_color(_color) {
  color = level.colorCheckList[tolower(_color)];
  if(isDefined(self.script_forcecolor) && color == self.script_forcecolor)
    return true;
  else
    return false;
}

get_force_color() {
  color = self.script_forceColor;
  return color;
}

shortenColor(color) {
  assertEx(isDefined(level.colorCheckList[tolower(color)]), "Tried to set force color on an undefined color: " + color);
  return level.colorCheckList[tolower(color)];
}

set_force_color(_color) {
  color = shortenColor(_color);
  assertEx(maps\_colors::colorIsLegit(color), "Tried to set force color on an undefined color: " + color);
  if(!isAI(self)) {
    set_force_color_spawner(color);
    return;
  }
  assertEx(isalive(self), "Tried to set force color on a dead / undefined entity.");
  if(self.team == "allies") {
    self.fixedNode = true;
    self.fixedNodeSafeRadius = 64;
    self.pathEnemyFightDist = 0;
    self.pathEnemyLookAhead = 0;
  }
  self.script_color_axis = undefined;
  self.script_color_allies = undefined;
  self.old_forcecolor = undefined;
  if(isDefined(self.script_forcecolor)) {
    level.arrays_of_colorForced_ai[self.team][self.script_forcecolor] = array_remove(level.arrays_of_colorForced_ai[self.team][self.script_forcecolor], self);
  }
  self.script_forceColor = color;
  level.arrays_of_colorForced_ai[self.team][self.script_forceColor] = array_add(level.arrays_of_colorForced_ai[self.team][self.script_forceColor], self);
  thread new_color_being_set(color);
}

set_force_color_spawner(color) {
  self.script_forceColor = color;
  self.old_forceColor = undefined;
}

issue_color_orders(color_team, team) {
  colorCodes = Strtok(color_team, " ");
  colors = [];
  colorCodesByColorIndex = [];
  for(i = 0; i < colorCodes.size; i++) {
    color = undefined;
    if(issubstr(colorCodes[i], "r"))
      color = "r";
    else
    if(issubstr(colorCodes[i], "b"))
      color = "b";
    else
    if(issubstr(colorCodes[i], "y"))
      color = "y";
    else
    if(issubstr(colorCodes[i], "c"))
      color = "c";
    else
    if(issubstr(colorCodes[i], "g"))
      color = "g";
    else
    if(issubstr(colorCodes[i], "p"))
      color = "p";
    else
    if(issubstr(colorCodes[i], "o"))
      color = "o";
    else
      assertEx(0, "Trigger at origin " + self getorigin() + " had strange color index " + colorCodes[i]);
    colorCodesByColorIndex[color] = colorCodes[i];
    colors[colors.size] = color;
  }
  assert(colors.size == colorCodes.size);
  for(i = 0; i < colorCodes.size; i++) {
    level.arrays_of_colorCoded_spawners[team][colorCodes[i]] = array_removeUndefined(level.arrays_of_colorCoded_spawners[team][colorCodes[i]]);
    assertex(isDefined(level.arrays_of_colorCoded_spawners[team][colorCodes[i]]), "Trigger refer to a color# that does not exist in any node for this team.");
    for(p = 0; p < level.arrays_of_colorCoded_spawners[team][colorCodes[i]].size; p++)
      level.arrays_of_colorCoded_spawners[team][colorCodes[i]][p].currentColorCode = colorCodes[i];
  }
  for(i = 0; i < colors.size; i++) {
    level.arrays_of_colorForced_ai[team][colors[i]] = array_removeDead(level.arrays_of_colorForced_ai[team][colors[i]]);
    level.currentColorForced[team][colors[i]] = colorCodesByColorIndex[colors[i]];
  }
  for(i = 0; i < colorCodes.size; i++) {
    ai_array = [];
    ai_array = maps\_colors::issue_leave_node_order_to_ai_and_get_ai(colorCodes[i], colors[i], team);
    maps\_colors::issue_color_order_to_ai(colorCodes[i], colors[i], team, ai_array);
  }
}

flashRumbleLoop(duration) {
  goalTime = GetTime() + duration * 1000;
  while(GetTime() < goalTime) {
    self PlayRumbleOnEntity("damage_heavy");
    wait(0.05);
  }
}

flashMonitor() {
  self endon("death");
  for(;;) {
    self waittill("flashbang", percent_distance, percent_angle, attacker, team);
    if("1" == GetDvar("noflash")) {
      continue;
    }
    frac = (percent_distance - 0.75) / (1 - 0.75);
    if(frac > percent_angle)
      percent_angle = frac;
    if(percent_angle < 0.5) {
      percent_angle = 0.5;
    } else if(percent_angle > 0.8) {
      percent_angle = 1;
    }
    minamountdist = 0.2;
    if(percent_distance > 1 - minamountdist)
      percent_distance = 1.0;
    else
      percent_distance = percent_distance / (1 - minamountdist);
    if(team == "axis")
      seconds = percent_distance * percent_angle * 6.0;
    else
      seconds = percent_distance * percent_angle * 3.0;
    if(seconds < 0.25) {
      continue;
    }
    if(isDefined(self.maxflashedseconds) && seconds > self.maxflashedseconds)
      seconds = self.maxflashedseconds;
    self.flashingTeam = team;
    self notify("flashed");
    self.flashendtime = gettime() + seconds * 1000;
    self shellshock("flashbang", seconds);
    flag_set("player_flashed");
    thread unflash_flag(seconds);
    if(seconds > 2)
      thread flashRumbleLoop(0.75);
    else
      thread flashRumbleLoop(0.25);
    if(team != "allies")
      self thread flashNearbyAllies(seconds, team);
  }
}

flashNearbyAllies(baseDuration, team) {
  wait .05;
  allies = getaiarray("allies");
  for(i = 0; i < allies.size; i++) {
    if(distanceSquared(allies[i].origin, self.origin) < 350 * 350) {
      duration = baseDuration + randomfloatrange(-1000, 1500);
      if(duration > 4.5)
        duration = 4.5;
      else if(duration < 0.25) {
        continue;
      }
      newendtime = gettime() + duration * 1000;
      if(!isDefined(allies[i].flashendtime) || allies[i].flashendtime < newendtime) {
        allies[i].flashingTeam = team;
        allies[i] setFlashBanged(true, duration);
      }
    }
  }
}

pauseEffect() {}

restartEffect() {}

createLoopEffect(fxid) {
  ent = maps\_createfx::createEffect("loopfx", fxid);
  ent.v["delay"] = 0.5;
  return ent;
}

createOneshotEffect(fxid) {
  ent = maps\_createfx::createEffect("oneshotfx", fxid);
  ent.v["delay"] = -15;
  return ent;
}

reportExploderIds() {
  if(!isDefined(level._exploder_ids)) {
    return;
  }
  keys = GetArrayKeys(level._exploder_ids);
  println("Server Exploder dictionary : ");
  for(i = 0; i < keys.size; i++) {
    println(keys[i] + " : " + level._exploder_ids[keys[i]]);
  }
}

getExploderId(ent) {
  if(!isDefined(level._exploder_ids)) {
    level._exploder_ids = [];
    level._exploder_id = 1;
  }
  if(!isDefined(level._exploder_ids[ent.v["exploder"]])) {
    level._exploder_ids[ent.v["exploder"]] = level._exploder_id;
    level._exploder_id++;
  }
  return level._exploder_ids[ent.v["exploder"]];
}

createExploder(fxid) {
  ent = maps\_createfx::createEffect("exploder", fxid);
  ent.v["delay"] = 0;
  ent.v["exploder_type"] = "normal";
  return ent;
}

getfxarraybyID(fxid) {
  array = [];
  for(i = 0; i < level.createFXent.size; i++) {
    if(level.createFXent[i].v["fxid"] == fxid)
      array[array.size] = level.createFXent[i];
  }
  return array;
}

ignoreAllEnemies(qTrue) {
  self notify("ignoreAllEnemies_threaded");
  self endon("ignoreAllEnemies_threaded");
  if(qTrue) {
    self.old_threat_bias_group = self GetThreatBiasGroup();
    num = undefined;
    num = self GetEntNum();
    println("entity: " + num + "ignoreAllEnemies TRUE");
    println("entity: " + num + " threatbiasgroup is " + self.old_threat_bias_group);
    CreateThreatBiasGroup("ignore_everybody");
    println("entity: " + num + "ignoreAllEnemies TRUE");
    println("entity: " + num + " SetThreatBiasGroup( ignore_everybody )");
    self SetThreatBiasGroup("ignore_everybody");
    teams = [];
    teams["axis"] = "allies";
    teams["allies"] = "axis";
    assertex(self.team != "neutral", "Why are you making a guy have team neutral? And also, why is he doing anim_reach?");
    ai = getaiarray(teams[self.team]);
    groups = [];
    for(i = 0; i < ai.size; i++)
      groups[ai[i] getthreatbiasgroup()] = true;
    keys = GetArrayKeys(groups);
    for(i = 0; i < keys.size; i++) {
      println("entity: " + num + "ignoreAllEnemies TRUE");
      println("entity: " + num + " setthreatbias( " + keys[i] + ", ignore_everybody, 0 )");
      setthreatbias(keys[i], "ignore_everybody", 0);
    }
  } else {
    num = undefined;
    assertex(isDefined(self.old_threat_bias_group), "You can't use ignoreAllEnemies( false ) on an AI that has never ran ignoreAllEnemies( true )");
    num = self GetEntNum();
    println("entity: " + num + "ignoreAllEnemies FALSE");
    println("entity: " + num + " self.old_threat_bias_group is " + self.old_threat_bias_group);
    if(self.old_threat_bias_group != "") {
      println("entity: " + num + "ignoreAllEnemies FALSE");
      println("entity: " + num + " SetThreatBiasGroup( " + self.old_threat_bias_group + " )");
      self SetThreatBiasGroup(self.old_threat_bias_group);
    }
    self.old_threat_bias_group = undefined;
  }
}

vehicle_detachfrompath() {
  maps\_vehicle::vehicle_pathDetach();
}

vehicle_resumepath() {
  thread maps\_vehicle::vehicle_resumepathvehicle();
}

vehicle_land() {
  maps\_vehicle::vehicle_landvehicle();
}

vehicle_liftoff(height) {
  maps\_vehicle::vehicle_liftoffvehicle(height);
}

vehicle_dynamicpath(node, bwaitforstart) {
  maps\_vehicle::vehicle_paths(node, bwaitforstart);
}

groundpos(origin) {
  return bulletTrace(origin, (origin + (0, 0, -100000)), 0, self)["position"];
}

playergroundpos(origin) {
  return playerphysicstrace(origin, (origin + (0, 0, -100000)));
}

change_player_health_packets(num) {
  level.player_health_packets += num;
  level notify("update_health_packets");
  if(level.player_health_packets >= 3)
    level.player_health_packets = 3;
}

getvehiclespawner(targetname) {
  spawner = getent(targetname + "_vehiclespawner", "targetname");
  return spawner;
}

getvehiclespawnerarray(targetname) {
  spawner = getEntArray(targetname + "_vehiclespawner", "targetname");
  return spawner;
}

player_fudge_moveto(dest, moverate) {
  if(!isDefined(moverate)) {
    moverate = 200;
  }
  org = spawn("script_origin", self.origin);
  org.origin = self.origin;
  self LinkTo(org);
  dist = Distance(self.origin, dest);
  movetime = dist / moverate;
  org MoveTo(dest, dist / moverate, .05, .05);
  wait(movetime);
  self UnLink();
  org Delete();
}

add_start(msg, func, loc_string) {
  assertex(!isDefined(level._loadStarted), "Can't create starts after _load");
  if(!isDefined(level.start_functions))
    level.start_functions = [];
  msg = tolower(msg);
  level.start_functions[msg] = func;
  if(isDefined(loc_string)) {
    precachestring(loc_string);
    level.start_loc_string[msg] = loc_string;
  } else {
    level.start_loc_string[msg] = &"MISSING_LOC_STRING";
  }
}

default_start(func) {
  level.default_start = func;
}

linetime(start, end, color, timer) {
  thread linetime_proc(start, end, color, timer);
}

within_fov(start_origin, start_angles, end_origin, fov) {
  normal = VectorNormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = VectorDot(forward, normal);
  return dot >= fov;
}

waitSpread(start, end) {
  if(!isDefined(end)) {
    end = start;
    start = 0;
  }
  assertEx(isDefined(start) && isDefined(end), "Waitspread was called without defining amount of time");
  wait(randomfloatrange(start, end));
  if(1) {
    return;
  }
  personal_wait_index = undefined;
  if(!isDefined(level.active_wait_spread)) {
    level.active_wait_spread = true;
    level.wait_spreaders = 0;
    personal_wait_index = level.wait_spreaders;
    level.wait_spreaders++;
    thread waitSpread_code(start, end);
  } else {
    personal_wait_index = level.wait_spreaders;
    level.wait_spreaders++;
    waittillframeend;
  }
  waittillframeend;
  wait(level.wait_spreader_allotment[personal_wait_index]);
}

wait_for_buffer_time_to_pass(last_queue_time, buffer_time) {
  timer = buffer_time * 1000 - (gettime() - last_queue_time);
  timer *= 0.001;
  if(timer > 0) {
    wait(timer);
  }
}

dialogue_queue(msg) {
  self maps\_anim::anim_single_queue(self, msg);
}

radio_dialogue(msg) {
  players = get_players();
  assertEX(isDefined(level.scr_radio[msg]), "Tried to play radio dialogue " + msg + " that did not exist! Add it to level.scr_radio");
  if(!isDefined(level.player_radio_emitter)) {
    ent = spawn("script_origin", (0, 0, 0));
    ent linkto(players[0], "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = ent;
  }
  level.player_radio_emitter play_sound_on_tag(level.scr_radio[msg], undefined, true);
}

radio_dialogue_stop() {
  if(!isDefined(level.player_radio_emitter))
    return;
  level.player_radio_emitter delete();
}

radio_dialogue_queue(msg) {
  level function_stack(::radio_dialogue, msg);
}

hint_create(text, background, backgroundAlpha) {
  struct = spawnStruct();
  if(isDefined(background) && background == true)
    struct.bg = NewHudElem();
  struct.elm = NewHudElem();
  struct hint_position_internal(backgroundAlpha);
  struct.elm SetText(text);
  return struct;
}

hint_Delete() {
  self notify("death");
  if(isDefined(self.elm))
    self.elm Destroy();
  if(isDefined(self.bg))
    self.bg Destroy();
}

hint_position_internal(bgAlpha) {
  if(level.console)
    self.elm.fontScale = 2;
  else
    self.elm.fontScale = 1.6;
  self.elm.x = 0;
  self.elm.y = -40;
  self.elm.alignX = "center";
  self.elm.alignY = "bottom";
  self.elm.horzAlign = "center";
  self.elm.vertAlign = "middle";
  self.elm.sort = 1;
  self.elm.alpha = 0.8;
  if(!isDefined(self.bg)) {
    return;
  }
  self.bg.x = 0;
  self.bg.y = -40;
  self.bg.alignX = "center";
  self.bg.alignY = "middle";
  self.bg.horzAlign = "center";
  self.bg.vertAlign = "middle";
  self.bg.sort = -1;
  if(level.console)
    self.bg SetShader("popmenu_bg", 650, 52);
  else
    self.bg SetShader("popmenu_bg", 650, 42);
  if(!isDefined(bgAlpha))
    bgAlpha = 0.5;
  self.bg.alpha = bgAlpha;
}

string(num) {
  return ("" + num);
}

ignoreEachOther(group1, group2) {
  assertex(ThreatBiasGroupExists(group1), "Tried to make threatbias group " + group1 + " ignore " + group2 + " but " + group1 + " does not exist!");
  assertex(ThreatBiasGroupExists(group2), "Tried to make threatbias group " + group2 + " ignore " + group1 + " but " + group2 + " does not exist!");
  SetIgnoreMeGroup(group1, group2);
  SetIgnoreMeGroup(group2, group1);
}

add_global_spawn_function(team, function, param1, param2, param3) {
  assertEx(isDefined(level.spawn_funcs), "Tried to add_global_spawn_function before calling _load");
  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  level.spawn_funcs[team][level.spawn_funcs[team].size] = func;
}

remove_global_spawn_function(team, function) {
  assertEx(isDefined(level.spawn_funcs), "Tried to remove_global_spawn_function before calling _load");
  array = [];
  for(i = 0; i < level.spawn_funcs[team].size; i++) {
    if(level.spawn_funcs[team][i]["function"] != function) {
      array[array.size] = level.spawn_funcs[team][i];
    }
  }
  assertEx(level.spawn_funcs[team].size != array.size, "Tried to remove a function from level.spawn_funcs, but that function didn't exist!");
  level.spawn_funcs[team] = array;
}

add_spawn_function(function, param1, param2, param3, param4) {
  assertEx(!isalive(self), "Tried to add_spawn_function to a living guy.");
  assertEx(isDefined(self.spawn_functions), "Tried to add_spawn_function before calling _load");
  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  self.spawn_functions[self.spawn_functions.size] = func;
}

array_Delete(array) {
  for(i = 0; i < array.size; i++) {
    array[i] delete();
  }
}

PlayerUnlimitedAmmoThread() {
  while(1) {
    wait(5);
    if(getdvar("UnlimitedAmmoOff") == "1") {
      continue;
    }
    players = get_players();
    for(q = 0; q < players.size; q++) {
      currentWeapon = players[q] GetCurrentWeapon();
      if(currentWeapon == "none") {
        continue;
      }
      currentAmmo = players[q] GetFractionMaxAmmo(currentWeapon);
      if(currentAmmo < 0.2) {
        players[q] GiveMaxAmmo(currentWeapon);
      }
    }
  }
}

ignore_triggers(timer) {
  self endon("death");
  self.ignoreTriggers = true;
  if(isDefined(timer)) {
    wait(timer);
  } else {
    wait(0.5);
  }
  self.ignoreTriggers = false;
}

delayThread(timer, func, param1, param2, param3, param4) {
  thread delayThread_proc(func, timer, param1, param2, param3, param4);
}

activate_trigger_with_targetname(msg) {
  trigger = getent(msg, "targetname");
  trigger activate_trigger();
}

activate_trigger_with_noteworthy(msg) {
  trigger = getent(msg, "script_noteworthy");
  trigger activate_trigger();
}

disable_trigger_with_targetname(msg) {
  trigger = getent(msg, "targetname");
  trigger trigger_off();
}

disable_trigger_with_noteworthy(msg) {
  trigger = getent(msg, "script_noteworthy");
  trigger trigger_off();
}

enable_trigger_with_targetname(msg) {
  trigger = getent(msg, "targetname");
  trigger trigger_on();
}

enable_trigger_with_noteworthy(msg) {
  trigger = getent(msg, "script_noteworthy");
  trigger trigger_on();
}

is_hero() {
  return isDefined(level.hero_list[get_ai_number()]);
}

get_ai_number() {
  if(!isDefined(self.ai_number)) {
    set_ai_number();
  }
  return self.ai_number;
}

set_ai_number() {
  self.ai_number = level.ai_number;
  level.ai_number++;
}

make_hero() {
  level.hero_list[self.ai_number] = true;
}

unmake_hero() {
  level.hero_list[self.ai_number] = undefined;
}

get_heroes() {
  array = [];
  ai = GetAiArray("allies");
  for(i = 0; i < ai.size; i++) {
    if(ai[i] is_hero())
      array[array.size] = ai[i];
  }
  return array;
}

set_team_pacifist(team, val) {
  ai = GetAiArray(team);
  for(i = 0; i < ai.size; i++) {
    ai[i].pacifist = val;
  }
}

replace_on_death() {
  maps\_colors::colorNode_replace_on_death();
}

spawn_reinforcement(classname, color) {
  maps\_colors::colorNode_spawn_reinforcement(classname, color);
}

clear_promotion_order() {
  level.current_color_order = [];
}

set_promotion_order(deadguy, replacer) {
  if(!isDefined(level.current_color_order)) {
    level.current_color_order = [];
  }
  deadguy = shortenColor(deadguy);
  replacer = shortenColor(replacer);
  level.current_color_order[deadguy] = replacer;
  if(!isDefined(level.current_color_order[replacer]))
    set_empty_promotion_order(replacer);
}

set_empty_promotion_order(deadguy) {
  if(!isDefined(level.current_color_order)) {
    level.current_color_order = [];
  }
  level.current_color_order[deadguy] = "none";
}

remove_dead_from_array(array) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    if(!isalive(array[i]))
      continue;
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

remove_heroes_from_array(array) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    if(array[i] is_hero())
      continue;
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

remove_all_animnamed_guys_from_array(array) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    if(isDefined(array[i].animname))
      continue;
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

remove_color_from_array(array, color) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    guy = array[i];
    if(!isDefined(guy.script_forceColor))
      continue;
    if(guy.script_forceColor == color)
      continue;
    newarray[newarray.size] = guy;
  }
  return newarray;
}

remove_noteworthy_from_array(array, noteworthy) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    guy = array[i];
    if(!isDefined(guy.script_noteworthy))
      continue;
    if(guy.script_noteworthy == noteworthy)
      continue;
    newarray[newarray.size] = guy;
  }
  return newarray;
}

get_closest_colored_friendly(color, origin) {
  allies = get_force_color_guys("allies", color);
  allies = remove_heroes_from_array(allies);
  if(!isDefined(origin)) {
    players = get_players();
    friendly_origin = players[0].origin;
  } else {
    friendly_origin = origin;
  }
  return getclosest(friendly_origin, allies);
}

remove_without_classname(array, classname) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    if(!issubstr(array[i].classname, classname))
      continue;
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

remove_without_model(array, model) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    if(!issubstr(array[i].model, model))
      continue;
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

get_closest_colored_friendly_with_classname(color, classname, origin) {
  allies = get_force_color_guys("allies", color);
  allies = remove_heroes_from_array(allies);
  if(!isDefined(origin)) {
    players = get_players();
    friendly_origin = players[0].origin;
  } else {
    friendly_origin = origin;
  }
  allies = remove_without_classname(allies, classname);
  return getclosest(friendly_origin, allies);
}

promote_nearest_friendly(colorFrom, colorTo) {
  for(;;) {
    friendly = get_closest_colored_friendly(colorFrom);
    if(!IsAlive(friendly)) {
      wait(1);
      continue;
    }
    friendly set_force_color(colorTo);
    return;
  }
}

instantly_promote_nearest_friendly(colorFrom, colorTo) {
  for(;;) {
    friendly = get_closest_colored_friendly(colorFrom);
    if(!IsAlive(friendly)) {
      assertex(0, "Instant promotion from " + colorFrom + " to " + colorTo + " failed!");
      return;
    }
    friendly set_force_color(colorTo);
    return;
  }
}

instantly_promote_nearest_friendly_with_classname(colorFrom, colorTo, classname) {
  for(;;) {
    friendly = get_closest_colored_friendly_with_classname(colorFrom, classname);
    if(!IsAlive(friendly)) {
      assertex(0, "Instant promotion from " + colorFrom + " to " + colorTo + " failed!");
      return;
    }
    friendly set_force_color(colorTo);
    return;
  }
}

promote_nearest_friendly_with_classname(colorFrom, colorTo, classname) {
  for(;;) {
    friendly = get_closest_colored_friendly_with_classname(colorFrom, classname);
    if(!isalive(friendly)) {
      wait(1);
      continue;
    }
    friendly set_force_color(colorTo);
    return;
  }
}

instantly_set_color_from_array_with_classname(array, color, classname) {
  foundGuy = false;
  newArray = [];
  for(i = 0; i < array.size; i++) {
    guy = array[i];
    if(foundGuy || !isSubstr(guy.classname, classname)) {
      newArray[newArray.size] = guy;
      continue;
    }
    foundGuy = true;
    guy set_force_color(color);
  }
  return newArray;
}

instantly_set_color_from_array(array, color) {
  foundGuy = false;
  newArray = [];
  for(i = 0; i < array.size; i++) {
    guy = array[i];
    if(foundGuy) {
      newArray[newArray.size] = guy;
      continue;
    }
    foundGuy = true;
    guy set_force_color(color);
  }
  return newArray;
}

wait_for_script_noteworthy_trigger(msg) {
  wait_for_trigger(msg, "script_noteworthy");
}

wait_for_targetname_trigger(msg) {
  wait_for_trigger(msg, "targetname");
}

wait_for_flag_or_timeout(msg, timer) {
  if(flag(msg)) {
    return;
  }
  ent = spawnStruct();
  ent thread ent_waits_for_level_notify(msg);
  ent thread ent_times_out(timer);
  ent waittill("done");
}

wait_for_trigger_or_timeout(timer) {
  ent = spawnStruct();
  ent thread ent_waits_for_trigger(self);
  ent thread ent_times_out(timer);
  ent waittill("done");
}

wait_for_either_trigger(msg1, msg2) {
  ent = spawnStruct();
  array = [];
  array = array_combine(array, getEntArray(msg1, "targetname"));
  array = array_combine(array, getEntArray(msg2, "targetname"));
  for(i = 0; i < array.size; i++) {
    ent thread ent_waits_for_trigger(array[i]);
  }
  ent waittill("done");
}

dronespawn(spawner) {
  drone = maps\_spawner::spawner_dronespawn(spawner);
  assert(isDefined(drone));
  return drone;
}

makerealai(drone) {
  return maps\_spawner::spawner_makerealai(drone);
}

get_trigger_flag() {
  if(isDefined(self.script_flag)) {
    return self.script_flag;
  }
  if(isDefined(self.script_noteworthy)) {
    return self.script_noteworthy;
  }
  assertex(0, "Flag trigger at " + self.origin + " has no script_flag set.");
}

isSpawner() {
  spawners = GetSpawnerArray();
  for(i = 0; i < spawners.size; i++) {
    if(spawners[i] == self)
      return true;
  }
  return false;
}

set_default_pathenemy_settings() {
  if(self.team == "allies") {
    self.pathEnemyLookAhead = 350;
    self.pathEnemyFightDist = 350;
    return;
  }
  if(self.team == "axis") {
    self.pathEnemyLookAhead = 350;
    self.pathEnemyFightDist = 350;
    return;
  }
}

cqb_walk(on_or_off) {
  if(on_or_off == "on") {
    self enable_cqbwalk();
  } else {
    assert(on_or_off == "off");
    self disable_cqbwalk();
  }
}

enable_cqbwalk() {
  self.cqbwalking = true;
  level thread animscripts\cqb::findCQBPointsOfInterest();
  self thread animscripts\cqb::CQBDebug();
}

disable_cqbwalk() {
  self.cqbwalking = false;
  self.cqb_point_of_interest = undefined;
  self notify("end_cqb_debug");
}

cqb_aim(the_target) {
  if(!isDefined(the_target)) {
    self.cqb_target = undefined;
  } else {
    self.cqb_target = the_target;
    if(!isDefined(the_target.origin))
      assertmsg("target passed into cqb_aim does not have an origin!");
  }
}

set_force_cover(val) {
  assertex(val == "hide" || val == "none" || val == "show", "invalid force cover set on guy");
  assertex(IsAlive(self), "Tried to set force cover on a dead guy");
  self.a.forced_cover = val;
}

waittill_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait(timer);
}

do_in_order(func1, param1, func2, param2) {
  if(isDefined(param1))
    [[func1]](param1);
  else
    [[func1]]();
  if(isDefined(param2))
    [[func2]](param2);
  else
    [[func2]]();
}

scrub() {
  self maps\_spawner::scrub_guy();
}

send_notify(msg) {
  self notify(msg);
}

deleteEnt(ent) {
  ent Delete();
}

getfx(fx) {
  assertEx(isDefined(level._effect[fx]), "Fx " + fx + " is not defined in level._effect.");
  return level._effect[fx];
}

getanim(anime) {
  assertex(isDefined(self.animname), "Called getanim on a guy with no animname");
  assertEx(isDefined(level.scr_anim[self.animname][anime]), "Called getanim on an inexistent anim");
  return level.scr_anim[self.animname][anime];
}

getanim_from_animname(anime, animname) {
  assertEx(isDefined(animname), "Must supply an animname");
  assertEx(isDefined(level.scr_anim[animname][anime]), "Called getanim on an inexistent anim");
  return level.scr_anim[animname][anime];
}

getanim_generic(anime) {
  assertEx(isDefined(level.scr_anim["generic"][anime]), "Called getanim_generic on an inexistent anim");
  return level.scr_anim["generic"][anime];
}

add_hint_string(name, string, optionalFunc) {
  assertex(isDefined(level.trigger_hint_string), "Tried to add a hint string before _load was called.");
  assertex(isDefined(name), "Set a name for the hint string. This should be the same as the script_hint on the trigger_hint.");
  assertex(isDefined(string), "Set a string for the hint string. This is the string you want to appear when the trigger is hit.");
  level.trigger_hint_string[name] = string;
  precachestring(string);
  if(isDefined(optionalFunc)) {
    level.trigger_hint_func[name] = optionalFunc;
  }
}

fire_radius(origin, radius) {
  if(level.createFX_enabled) {
    return;
  }
  trigger = spawn("trigger_radius", origin, 0, radius, 48);
  for(;;) {
    trigger waittill("trigger", other);
    assertex(IsPlayer(other), "Tried to burn a non player in a fire");
    other DoDamage(5, origin);
  }
}

clearThreatBias(group1, group2) {
  SetThreatBias(group1, group2, 0);
  SetThreatBias(group2, group1, 0);
}

scr_println(msg) {
  println(msg);
}

ThrowGrenadeAtPlayerASAP() {
  players = get_players();
  if(players.size > 0) {
    best_target = undefined;
    closest_dist = 99999999;
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i])) {
        dist = DistanceSquared(self.origin, players[i].origin);
        if(dist < closest_dist) {
          best_target = players[i];
          closest_dist = dist;
        }
      }
    }
    if(isDefined(best_target)) {
      animscripts\combat_utility::ThrowGrenadeAtPlayerASAP_combat_utility(best_target);
    }
  }
}

sg_precachemodel(model) {
  script_gen_dump_addline("precachemodel( \"" + model + "\" );", "xmodel_" + model);
}

sg_precacheitem(item) {
  script_gen_dump_addline("precacheitem( \"" + item + "\" );", "item_" + item);
}

sg_precachemenu(menu) {
  script_gen_dump_addline("precachemenu( \"" + menu + "\" );", "menu_" + menu);
}

sg_precacherumble(rumble) {
  script_gen_dump_addline("precacherumble( \"" + rumble + "\" );", "rumble_" + rumble);
}

sg_precacheshader(shader) {
  script_gen_dump_addline("precacheshader( \"" + shader + "\" );", "shader_" + shader);
}

sg_precacheshellshock(shock) {
  script_gen_dump_addline("precacheshellshock( \"" + shock + "\" );", "shock_" + shock);
}

sg_precachestring(string) {
  script_gen_dump_addline("precachestring( \"" + string + "\" );", "string_" + string);
}

sg_precacheturret(turret) {
  script_gen_dump_addline("precacheturret( \"" + turret + "\" );", "turret_" + turret);
}

sg_precachevehicle(vehicle) {
  script_gen_dump_addline("precachevehicle( \"" + vehicle + "\" );", "vehicle_" + vehicle);
}

sg_getanim(animation) {
  return level.sg_anim[animation];
}

sg_getanimtree(animtree) {
  return level.sg_animtree[animtree];
}

sg_precacheanim(animation, animtree) {
  if(!isDefined(animtree))
    animtree = "generic_human";
  sg_csv_addtype("xanim", animation);
  if(!isDefined(level.sg_precacheanims))
    level.sg_precacheanims = [];
  if(!isDefined(level.sg_precacheanims[animtree]))
    level.sg_precacheanims[animtree] = [];
  level.sg_precacheanims[animtree][animation] = true;
}

sg_getfx(fx) {
  return level.sg_effect[fx];
}

sg_precachefx(fx) {
  script_gen_dump_addline("level.sg_effect[ \"" + fx + "\" ] = loadfx( \"" + fx + "\" );", "fx_" + fx);
}

sg_wait_dump() {
  flag_wait("scriptgen_done");
}

sg_standard_includes() {
  sg_csv_addtype("ignore", "code_post_gfx");
  sg_csv_addtype("ignore", "common");
  sg_csv_addtype("col_map_sp", "maps/" + tolower(getdvar("mapname")) + ".d3dbsp");
  sg_csv_addtype("gfx_map", "maps/" + tolower(getdvar("mapname")) + ".d3dbsp");
  sg_csv_addtype("rawfile", "maps/" + tolower(getdvar("mapname")) + ".gsc");
  sg_csv_addtype("rawfile", "maps / scriptgen/" + tolower(getdvar("mapname")) + "_scriptgen.gsc");
  sg_csv_soundadd("us_battlechatter", "all_sp");
  sg_csv_soundadd("ab_battlechatter", "all_sp");
  sg_csv_soundadd("voiceovers", "all_sp");
  sg_csv_soundadd("common", "all_sp");
  sg_csv_soundadd("generic", "all_sp");
  sg_csv_soundadd("requests", "all_sp");
}

sg_csv_soundadd(type, loadspec) {
  script_gen_dump_addline("nowrite Sound CSV entry: " + type, "sound_" + type + ", " + tolower(getdvar("mapname")) + ", " + loadspec);
}

sg_csv_addtype(type, string) {
  script_gen_dump_addline("nowrite CSV entry: " + type + ", " + string, type + "_" + string);
}

array_combine_keys(array1, array2) {
  if(!array1.size)
    return array2;
  keys = getarraykeys(array2);
  for(i = 0; i < keys.size; i++)
    array1[keys[i]] = array2[keys[i]];
  return array1;
}

set_ignoreSuppression(val) {
  self.ignoreSuppression = val;
}

set_goalradius(radius) {
  self.goalradius = radius;
}

try_forever_spawn() {
  export = self.export;
  for(;;) {
    assertEx(isDefined(self), "Spawner with export " +
      export +" was deleted.");
    guy = self dospawn();
    if(spawn_failed(guy)) {
      wait(1);
      continue;
    }
    return guy;
  }
}

set_allowdeath(val) {
  self.allowdeath = val;
}

set_run_anim(anime, alwaysRunForward) {
  assertEx(isDefined(anime), "Tried to set run anim but didn't specify which animation to ues");
  assertEx(isDefined(self.animname), "Tried to set run anim on a guy that had no anim name");
  assertEx(isDefined(level.scr_anim[self.animname][anime]), "Tried to set run anim but the anim was not defined in the maps _anim file");
  if(isDefined(alwaysRunForward))
    self.alwaysRunForward = alwaysRunForward;
  else
    self.alwaysRunForward = true;
  self.a.combatrunanim = level.scr_anim[self.animname][anime];
  self.run_noncombatanim = self.a.combatrunanim;
  self.walk_combatanim = self.a.combatrunanim;
  self.walk_noncombatanim = self.a.combatrunanim;
  self.preCombatRunEnabled = false;
}

set_generic_run_anim(anime, alwaysRunForward) {
  assertEx(isDefined(anime), "Tried to set generic run anim but didn't specify which animation to ues");
  assertEx(isDefined(level.scr_anim["generic"][anime]), "Tried to set generic run anim but the anim was not defined in the maps _anim file");
  if(isDefined(alwaysRunForward)) {
    if(alwaysRunForward)
      self.alwaysRunForward = alwaysRunForward;
    else
      self.alwaysRunForward = undefined;
  } else
    self.alwaysRunForward = true;
  self.a.combatrunanim = level.scr_anim["generic"][anime];
  self.run_noncombatanim = self.a.combatrunanim;
  self.walk_combatanim = self.a.combatrunanim;
  self.walk_noncombatanim = self.a.combatrunanim;
  self.preCombatRunEnabled = false;
}

clear_run_anim() {
  self.alwaysRunForward = undefined;
  self.a.combatrunanim = undefined;
  self.run_noncombatanim = undefined;
  self.walk_combatanim = undefined;
  self.walk_noncombatanim = undefined;
  self.preCombatRunEnabled = true;
}

debugvar(msg, timer) {
  if(getdvar(msg) == "") {
    setdvar(msg, timer);
  }
  return getdvarfloat(msg);
}

physicsjolt_proximity(outer_radius, inner_radius, force) {
  self endon("death");
  self endon("stop_physicsjolt");
  if(!isDefined(outer_radius) || !isDefined(inner_radius) || !isDefined(force)) {
    outer_radius = 400;
    inner_radius = 256;
    force = (0, 0, 0.075);
  }
  fade_distance = outer_radius * outer_radius;
  fade_speed = 3;
  base_force = force;
  while(true) {
    wait 0.1;
    force = base_force;
    if(self.classname == "script_vehicle") {
      speed = self getspeedMPH();
      if(speed < fade_speed) {
        scale = speed / fade_speed;
        force = vector_multiply(base_force, scale);
      }
    }
    dist = distancesquared(self.origin, level.player.origin);
    scale = fade_distance / dist;
    if(scale > 1)
      scale = 1;
    force = vector_multiply(force, scale);
    total_force = force[0] + force[1] + force[2];
  }
}

set_goal_entity(ent) {
  self setGoalEntity(ent);
}

activate_trigger() {
  assertEx(!isDefined(self.trigger_off), "Tried to activate trigger that is OFF( either from trigger_off or from flags set on it through shift - G menu");
  if(isDefined(self.script_color_allies)) {
    self.activated_color_trigger = true;
    maps\_colors::activate_color_trigger("allies");
  }
  if(isDefined(self.script_color_axis)) {
    self.activated_color_trigger = true;
    maps\_colors::activate_color_trigger("axis");
  }
  self notify("trigger");
  if(self.classname != "trigger_friendlychain") {
    return;
  }
  node = getnode(self.target, "targetname");
  assertEx(isDefined(node), "Trigger_friendlychain at " + self.origin + " doesn't target a node");
  level.player setfriendlychain(node);
}

self_delete() {
  self delete();
}

remove_noColor_from_array(ai) {
  newarray = [];
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(guy has_color())
      newarray[newarray.size] = guy;
  }
  return newarray;
}

has_color() {
  if(self.team == "axis") {
    return isDefined(self.script_color_axis) || isDefined(self.script_forceColor);
  }
  return isDefined(self.script_color_allies) || isDefined(self.script_forceColor);
}

clear_colors() {
  clear_team_colors("axis");
  clear_team_colors("allies");
}

clear_team_colors(team) {
  level.currentColorForced[team]["r"] = undefined;
  level.currentColorForced[team]["b"] = undefined;
  level.currentColorForced[team]["c"] = undefined;
  level.currentColorForced[team]["y"] = undefined;
  level.currentColorForced[team]["p"] = undefined;
  level.currentColorForced[team]["o"] = undefined;
  level.currentColorForced[team]["g"] = undefined;
}

get_script_palette() {
  rgb = [];
  rgb["r"] = (1, 0, 0);
  rgb["o"] = (1, 0.5, 0);
  rgb["y"] = (1, 1, 0);
  rgb["g"] = (0, 1, 0);
  rgb["c"] = (0, 1, 1);
  rgb["b"] = (0, 0, 1);
  rgb["p"] = (1, 0, 1);
  return rgb;
}

notify_delay(sNotifyString, fDelay) {
  assert(isDefined(self));
  assert(isDefined(sNotifyString));
  assert(isDefined(fDelay));
  assert(fDelay > 0);
  self endon("death");
  wait fDelay;
  if(!isDefined(self))
    return;
  self notify(sNotifyString);
}

gun_remove() {
  self animscripts\shared::placeWeaponOn(self.weapon, "none");
}

gun_switchto(weaponName, whichHand) {
  self animscripts\shared::placeWeaponOn(weaponName, whichHand);
}

gun_recall() {
  self animscripts\shared::placeWeaponOn(self.weapon, "right");
}

lerp_player_view_to_tag(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc) {
  if(IsPlayer(self)) {
    self endon("disconnect");
  }
  lerp_player_view_to_tag_internal(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, false);
}

lerp_player_view_to_tag_and_hit_geo(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc) {
  if(IsPlayer(self)) {
    self endon("disconnect");
  }
  lerp_player_view_to_tag_internal(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, true);
}

lerp_player_view_to_position(origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(IsPlayer(self)) {
    self endon("disconnect");
  }
  linker = spawn("script_origin", (0, 0, 0));
  linker.origin = self.origin;
  linker.angles = self getplayerangles();
  if(isDefined(hit_geo)) {
    self playerlinkto(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);
  } else if(isDefined(right_arc)) {
    self playerlinkto(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc);
  } else if(isDefined(fraction)) {
    self playerlinkto(linker, "", fraction);
  } else {
    self playerlinkto(linker);
  }
  linker moveto(origin, lerptime, lerptime * 0.25);
  linker rotateto(angles, lerptime, lerptime * 0.25);
  linker waittill("movedone");
  linker delete();
}

lerp_player_view_to_tag_oldstyle(tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc) {
  lerp_player_view_to_tag_oldstyle_internal(tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, false);
}

lerp_player_view_to_position_oldstyle(origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(IsPlayer(self)) {
    self endon("disconnect");
  }
  linker = spawn("script_origin", (0, 0, 0));
  linker.origin = get_player_feet_from_view();
  linker.angles = level.player getplayerangles();
  if(isDefined(hit_geo)) {
    self playerlinktodelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);
  } else
  if(isDefined(right_arc)) {
    self playerlinktodelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc);
  } else
  if(isDefined(fraction)) {
    self playerlinktodelta(linker, "", fraction);
  } else {
    self playerlinktodelta(linker);
  }
  linker moveto(origin, lerptime, lerptime * 0.25);
  linker rotateto(angles, lerptime, lerptime * 0.25);
  linker waittill("movedone");
  linker delete();
}

lerp_player_view_to_moving_position_oldstyle(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(IsPlayer(self)) {
    self endon("disconnect");
  }
  linker = spawn("script_origin", (0, 0, 0));
  linker.origin = self.origin;
  linker.angles = self getplayerangles();
  if(isDefined(hit_geo)) {
    self playerlinktodelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);
  } else
  if(isDefined(right_arc)) {
    self playerlinktodelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc);
  } else
  if(isDefined(fraction)) {
    self playerlinktodelta(linker, "", fraction);
  } else {
    self playerlinktodelta(linker);
  }
  max_count = lerptime / 0.0167;
  count = 0;
  while(count < max_count) {
    origin = ent gettagorigin(tag);
    angles = ent gettagangles(tag);
    linker moveto(origin, 0.0167 * (max_count - count));
    linker rotateto(angles, 0.0167 * (max_count - count));
    wait(0.0167);
    count++;
  }
  linker delete();
}

timer(time) {
  wait(time);
}

waittill_either_function(func1, parm1, func2, parm2) {
  ent = spawnStruct();
  thread waittill_either_function_internal(ent, func1, parm1);
  thread waittill_either_function_internal(ent, func2, parm2);
  ent waittill("done");
}

waittill_msg(msg) {
  if(IsPlayer(self)) {
    self endon("disconnect");
  }
  self waittill(msg);
}

display_hint(hint) {
  if(getdvar("chaplincheat") == "1") {
    return;
  }
  if(isDefined(level.trigger_hint_func[hint])) {
    if([
        [level.trigger_hint_func[hint]]
      ]()) {
      return;
    }
    HintPrint(level.trigger_hint_string[hint], level.trigger_hint_func[hint]);
  } else {
    HintPrint(level.trigger_hint_string[hint]);
  }
}

getGenericAnim(anime) {
  assertex(isDefined(level.scr_anim["generic"][anime]), "Generic anim " + anime + " was not defined in your _anim file.");
  return level.scr_anim["generic"][anime];
}

enable_careful() {
  assertex(isai(self), "Tried to make an ai careful but it wasn't called on an AI");
  self.script_careful = true;
}

disable_careful() {
  assertex(isai(self), "Tried to unmake an ai careful but it wasn't called on an AI");
  self.script_careful = false;
  self notify("stop_being_careful");
}

clear_dvar(msg) {
  setdvar(msg, "");
}

mission(name) {
  return level.script == name;
}

set_fixednode_true() {
  self.fixednode = true;
}

set_fixednode_false() {
  self.fixednode = true;
}

spawn_ai() {
  if(isDefined(self.script_forcespawn))
    return self stalingradspawn();
  return self dospawn();
}

function_stack(func, param1, param2, param3, param4) {
  self endon("death");
  localentity = spawnStruct();
  localentity thread function_stack_proc(self, func, param1, param2, param3, param4);
  localentity waittill_either("function_done", "death");
}

geo_off() {
  if(isDefined(self.geo_off)) {
    return;
  }
  self.realorigin = self getorigin();
  self moveto(self.realorigin + (0, 0, -10000), .2);
  self.geo_off = true;
}

geo_on() {
  if(!isDefined(self.geo_off)) {
    return;
  }
  self moveto(self.realorigin, .2);
  self waittill("movedone");
  self.geo_off = undefined;
}

set_blur(magnitude, time) {
  self setblur(magnitude, time);
}

set_goal_node(node) {
  self.last_set_goalnode = node;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(node);
}

set_goal_pos(origin) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = origin;
  self.last_set_goalent = undefined;
  self setgoalpos(origin);
}

set_goal_ent(target) {
  set_goal_pos(target.origin);
  self.last_set_goalent = target;
}

objective_complete(obj) {
  objective_state(obj, "done");
  level notify("objective_complete" + obj);
}

run_thread_on_targetname(msg, func, param1, param2, param3) {
  array = getEntArray(msg, "targetname");
  array_thread(array, func, param1, param2, param3);
}

run_thread_on_noteworthy(msg, func, param1, param2, param3) {
  array = getEntArray(msg, "script_noteworthy");
  array_thread(array, func, param1, param2, param3);
}

handsignal(xanim, ender, waiter) {
  if(isDefined(ender))
    level endon(ender);
  if(isDefined(waiter))
    level waittill(waiter);
  switch (xanim) {
    case "go":
      self setanimrestart(getGenericAnim("signal_go"), 1, 0, 1.1);
      break;
    case "onme":
      self maps\_anim::anim_generic(self, "signal_onme");
      break;
    case "stop":
      self setanimrestart(getGenericAnim("signal_stop"), 1, 0, 1.1);
      break;
    case "moveup":
      self setanimrestart(getGenericAnim("signal_moveup"), 1, 0, 1.1);
      break;
  }
}

get_guy_with_script_noteworthy_from_spawner(script_noteworthy) {
  spawner = getEntArray(script_noteworthy, "script_noteworthy");
  assertex(spawner.size == 1, "Tried to get guy from spawner but there were zero or multiple spawners");
  guys = array_spawn(spawner);
  return guys[0];
}

get_guy_with_targetname_from_spawner(targetname) {
  spawner = getEntArray(targetname, "targetname");
  assertex(spawner.size == 1, "Tried to get guy from spawner but there were zero or multiple spawners");
  guys = array_spawn(spawner);
  return guys[0];
}

get_guys_with_targetname_from_spawner(targetname) {
  spawners = getEntArray(targetname, "targetname");
  assertex(spawners.size > 0, "Tried to get guy from spawner but there were zero spawners");
  return array_spawn(spawners);
}

array_spawn(spawners) {
  guys = [];
  for(i = 0; i < spawners.size; i++) {
    spawner = spawners[i];
    spawner.count = 1;
    guy = spawner spawn_ai();
    spawn_failed(guy);
    assertEx(isalive(guy), "Guy with export " + spawner.export+" failed to spawn.");
    guys[guys.size] = guy;
  }
  assertex(guys.size == spawners.size, "Didnt spawn correct number of guys");
  return guys;
}

add_dialogue_line(name, msg) {
  if(getdvarint("loc_warnings")) {
    return;
  }
  if(!isDefined(level.dialogue_huds)) {
    level.dialogue_huds = [];
  }
  for(index = 0;; index++) {
    if(!isDefined(level.dialogue_huds[index])) {
      break;
    }
  }
  level.dialogue_huds[index] = true;
  hudelem = maps\_hud_util::createFontString("default", 1.5);
  hudelem.location = 0;
  hudelem.alignX = "left";
  hudelem.alignY = "top";
  hudelem.foreground = 1;
  hudelem.sort = 20;
  hudelem.alpha = 0;
  hudelem fadeOverTime(0.5);
  hudelem.alpha = 1;
  hudelem.x = 40;
  hudelem.y = 260 + index * 18;
  hudelem.label = "<" + name + "> " + msg;
  hudelem.color = (1, 1, 0);
  wait(2);
  timer = 2 * 20;
  hudelem fadeOverTime(6);
  hudelem.alpha = 0;
  for(i = 0; i < timer; i++) {
    hudelem.color = (1, 1, 1 / (timer - i));
    wait(0.05);
  }
  wait(4);
  hudelem destroy();
  level.dialogue_huds[index] = undefined;
}

alphabetize(array) {
  if(array.size <= 1)
    return array;
  count = 0;
  for(;;) {
    changed = false;
    for(i = 0; i < array.size - 1; i++) {
      if(is_later_in_alphabet(array[i], array[i + 1])) {
        val = array[i];
        array[i] = array[i + 1];
        array[i + 1] = val;
        changed = true;
        count++;
        if(count >= 10) {
          count = 0;
          wait(0.05);
        }
      }
    }
    if(!changed)
      return array;
  }
  return array;
}

set_grenadeammo(count) {
  self.grenadeammo = count;
}

get_player_feet_from_view() {
  tagorigin = self.origin;
  upvec = anglestoup(self getplayerangles());
  height = self GetPlayerViewHeight();
  player_eye = tagorigin + (0, 0, height);
  player_eye_fake = tagorigin + vector_multiply(upvec, height);
  diff_vec = player_eye - player_eye_fake;
  fake_origin = tagorigin + diff_vec;
  return fake_origin;
}

set_baseaccuracy(val) {
  self.baseaccuracy = val;
}

set_console_status() {
  if(getdebugdvar("replay_debug") == "1")
    println("File: _utility.gsc. Function: set_console_status()\n");
  if(!isDefined(level.Console))
    level.Console = getdvar("consoleGame") == "true";
  else
    assertex(level.Console == (getdvar("consoleGame") == "true"), "Level.console got set incorrectly.");
  if(!isDefined(level.Consolexenon))
    level.xenon = getdvar("xenonGame") == "true";
  else
    assertex(level.xenon == (getdvar("xenonGame") == "true"), "Level.xenon got set incorrectly.");
  if(getdebugdvar("replay_debug") == "1")
    println("File: _utility.gsc. Function: set_console_status() - COMPLETE\n");
}

autosave_now(optional_useless_string, suppress_print) {
  return maps\_autosave::autosave_game_now(suppress_print);
}

set_generic_deathanim(deathanim) {
  self.deathanim = getgenericanim(deathanim);
}

set_deathanim(deathanim) {
  self.deathanim = getanim(deathanim);
}

clear_deathanim() {
  self.deathanim = undefined;
}

hunted_style_door_open(soundalias) {
  wait(1.75);
  if(isDefined(soundalias))
    self playSound(soundalias);
  else
    self playSound("door_wood_slow_open");
  self rotateto(self.angles + (0, 70, 0), 2, .5, 0);
  self connectpaths();
  self waittill("rotatedone");
  self rotateto(self.angles + (0, 40, 0), 2, 0, 2);
}

palm_style_door_open(soundalias) {
  wait(1.35);
  if(isDefined(soundalias))
    self playSound(soundalias);
  else
    self playSound("door_wood_slow_open");
  self rotateto(self.angles + (0, 70, 0), 2, .5, 0);
  self connectpaths();
  self waittill("rotatedone");
  self rotateto(self.angles + (0, 40, 0), 2, 0, 2);
}

lerp_fov_overtime(time, destfov) {
  basefov = getdvarfloat("cg_fov");
  incs = int(time / .05);
  incfov = (destfov - basefov) / incs;
  currentfov = basefov;
  for(i = 0; i < incs; i++) {
    currentfov += incfov;
    setsaveddvar("cg_fov", currentfov);
    wait .05;
  }
  setsaveddvar("cg_fov", destfov);
}

putGunAway() {
  animscripts\shared::placeWeaponOn(self.weapon, "none");
  self.weapon = "none";
}

apply_fog() {
  maps\_load::set_fog_progress(0);
}

apply_end_fog() {
  maps\_load::set_fog_progress(1);
}

anim_stopanimscripted() {
  self stopanimscripted();
  self notify("single anim", "end");
  self notify("looping anim", "end");
}

disable_pain() {
  assertex(isalive(self), "Tried to disable pain on a non ai");
  self.a.disablePain = true;
}

enable_pain() {
  assertex(isalive(self), "Tried to enable pain on a non ai");
  self.a.disablePain = false;
}

_delete() {
  self delete();
}

disable_oneshotfx_with_noteworthy(noteworthy) {
  assertex(isDefined(level._global_fx_ents[noteworthy]), "No _global_fx ents have noteworthy " + noteworthy);
  keys = getarraykeys(level._global_fx_ents[noteworthy]);
  for(i = 0; i < keys.size; i++) {
    level._global_fx_ents[noteworthy][keys[i]].looper delete();
    level._global_fx_ents[noteworthy][keys[i]] = undefined;
  }
}

_setLightIntensity(val) {
  self setLightIntensity(val);
}

_linkto(targ, tag, org, angles) {
  if(isDefined(angles)) {
    self linkto(targ, tag, org, angles);
    return;
  }
  if(isDefined(org)) {
    self linkto(targ, tag, org);
    return;
  }
  if(isDefined(tag)) {
    self linkto(targ, tag);
    return;
  }
  self linkto(targ);
}

array_wait(array, msg, timeout) {
  keys = getarraykeys(array);
  structs = [];
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
  }
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    structs[key] = spawnStruct();
    structs[key]._array_wait = true;
    structs[key] thread array_waitlogic1(array[key], msg, timeout);
  }
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    if(isDefined(array[key]) && structs[key]._array_wait)
      structs[key] waittill("_array_wait");
  }
}

die() {
  self dodamage(self.health + 150, (0, 0, 0));
}

getmodel(str) {
  assertex(isDefined(level.scr_model[str]), "Tried to getmodel on model " + str + " but level.scr_model[ " + str + " was not defined.");
  return level.scr_model[str];
}

isADS(player) {
  return (player playerADS() > 0.5);
}

enable_auto_adjust_threatbias(player) {
  level.auto_adjust_threatbias = true;
  if(level.gameskill >= 2) {
    player.threatbias = int(maps\_gameskill::get_locked_difficulty_val("threatbias", 1));
    return;
  }
  level.auto_adjust_difficulty_frac = getdvarint("autodifficulty_frac");
  current_frac = level.auto_adjust_difficulty_frac * 0.01;
  players = get_players();
  level.coop_player_threatbias_scalar = maps\_gameskill::getCoopValue("coopFriendlyThreatBiasScalar", players.size);
  if(!isDefined(level.coop_player_threatbias_scalar)) {
    level.coop_player_threatbias_scalar = 1;
  }
  player.threatbias = int(maps\_gameskill::get_blended_difficulty("threatbias", current_frac) * level.coop_player_threatbias_scalar);
}

disable_auto_adjust_threatbias() {
  level.auto_adjust_threatbias = false;
}

disable_replace_on_death() {
  self.replace_on_death = undefined;
  self notify("_disable_reinforcement");
}

waittill_player_lookat(dot, timer, dot_only) {
  if(!isDefined(dot))
    dot = 0.92;
  if(!isDefined(timer))
    timer = 0;
  base_time = int(timer * 20);
  count = base_time;
  self endon("death");
  ai_guy = isai(self);
  org = undefined;
  for(;;) {
    if(ai_guy)
      org = self getEye();
    else
      org = self.origin;
    if(player_looking_at(org, dot, dot_only)) {
      count--;
      if(count <= 0)
        return true;
    } else {
      count = base_time;
    }
    wait(0.1);
  }
}

waittill_player_lookat_for_time(timer, dot, dot_only) {
  assertex(isDefined(timer), "Tried to do waittill_player_lookat_for_time with no time parm.");
  waittill_player_lookat(dot, timer, dot_only);
}

player_looking_at(start, dot, dot_only) {
  end = level.player getEye();
  angles = vectorToAngles(start - end);
  forward = anglesToForward(angles);
  player_angles = level.player getplayerangles();
  player_forward = anglesToForward(player_angles);
  new_dot = vectordot(forward, player_forward);
  if(new_dot < dot) {
    return false;
  }
  if(isDefined(dot_only)) {
    assertex(dot_only, "dot_only must be true or undefined");
    return true;
  }
  trace = bulletTrace(start, end, false, undefined);
  return trace["fraction"] == 1;
}

add_wait(func, parm1, parm2, parm3) {
  ent = spawnStruct();
  ent.caller = self;
  ent.func = func;
  ent.parms = [];
  if(isDefined(parm1)) {
    ent.parms[ent.parms.size] = parm1;
  }
  if(isDefined(parm2)) {
    ent.parms[ent.parms.size] = parm2;
  }
  if(isDefined(parm3)) {
    ent.parms[ent.parms.size] = parm3;
  }
  level.wait_any_func_array[level.wait_any_func_array.size] = ent;
}

add_func(func, parm1, parm2, parm3) {
  ent = spawnStruct();
  ent.caller = self;
  ent.func = func;
  ent.parms = [];
  if(isDefined(parm1)) {
    ent.parms[ent.parms.size] = parm1;
  }
  if(isDefined(parm2)) {
    ent.parms[ent.parms.size] = parm2;
  }
  if(isDefined(parm3)) {
    ent.parms[ent.parms.size] = parm3;
  }
  level.run_func_after_wait_array[level.run_func_after_wait_array.size] = ent;
}

add_endon(name) {
  ent = spawnStruct();
  ent.caller = self;
  ent.ender = name;
  level.do_wait_endons_array[level.do_wait_endons_array.size] = ent;
}

do_wait_any() {
  assertex(isDefined(level.wait_any_func_array), "Tried to do a do_wait without addings funcs first");
  assertex(level.wait_any_func_array.size > 0, "Tried to do a do_wait without addings funcs first");
  do_wait(level.wait_any_func_array.size - 1);
}

do_wait(count_to_reach) {
  if(!isDefined(count_to_reach))
    count_to_reach = 0;
  assertex(isDefined(level.wait_any_func_array), "Tried to do a do_wait without addings funcs first");
  ent = spawnStruct();
  array = level.wait_any_func_array;
  endons = level.do_wait_endons_array;
  after_array = level.run_func_after_wait_array;
  level.wait_any_func_array = [];
  level.run_func_after_wait_array = [];
  level.do_wait_endons_array = [];
  ent.count = array.size;
  ent array_levelthread(array, ::waittill_func_ends, endons);
  for(;;) {
    if(ent.count <= count_to_reach) {
      break;
    }
    ent waittill("func_ended");
  }
  ent notify("all_funcs_ended");
  array_levelthread(after_array, ::exec_func, []);
}

is_default_start() {
  return level.start_point == "default";
}

_Earthquake(scale, duration, source, radius) {
  Earthquake(scale, duration, source, radius);
}

waterfx(endflag) {
  if(isDefined(endflag)) {
    flag_assert(endflag);
    level endon(endflag);
  }
  for(;;) {
    wait(randomfloatrange(0.15, 0.3));
    start = self.origin + (0, 0, 150);
    end = self.origin - (0, 0, 150);
    trace = bulletTrace(start, end, false, undefined);
    if(trace["surfacetype"] != "water") {
      continue;
    }
    fx = "water_movement";
    if(self == level.player) {
      if(distance(level.player getvelocity(), (0, 0, 0)) < 5) {
        fx = "water_stop";
      }
    } else
    if(isDefined(level._effect["water_" + self.a.movement])) {
      fx = "water_" + self.a.movement;
    }
    playFX(getfx(fx), trace["position"], trace["normal"]);
  }
}

mix_up(sound) {
  timer = 3 * 20;
  for(i = 0; i < timer; i++) {
    self SetSoundBlend(sound, sound + "_off", (timer - i) / timer);
    wait(0.05);
  }
}

mix_down(sound) {
  timer = 3 * 20;
  for(i = 0; i < timer; i++) {
    self SetSoundBlend(sound, sound + "_off", i / timer);
    wait(0.05);
  }
}

manual_linkto(entity, offset) {
  entity endon("death");
  self endon("death");
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }
  for(;;) {
    self.origin = entity.origin + offset;
    self.angles = entity.angles;
    wait(0.05);
  }
}

make_array(index1, index2, index3, index4, index5) {
  assertex(isDefined(index1), "Need to define index 1 at least");
  array = [];
  array[array.size] = index1;
  if(isDefined(index2)) {
    array[array.size] = index2;
  }
  if(isDefined(index3)) {
    array[array.size] = index3;
  }
  if(isDefined(index4)) {
    array[array.size] = index4;
  }
  if(isDefined(index5)) {
    array[array.size] = index5;
  }
  return array;
}

fail_on_friendly_fire() {
  if(!isDefined(level.friendlyfire_friendly_kill_points)) {
    level.friendlyfire_friendly_kill_points = level.friendlyfire["friend_kill_points"];
  }
  level.friendlyfire["friend_kill_points"] = -60000;
}

normal_friendly_fire_penalty() {
  if(!isDefined(level.friendlyfire_friendly_kill_points)) {
    return;
  }
  level.friendlyfire["friend_kill_points"] = level.friendlyfire_friendly_kill_points;
}

getPlayerClaymores() {
  heldweapons = level.player getweaponslist();
  stored_ammo = [];
  for(i = 0; i < heldweapons.size; i++) {
    weapon = heldweapons[i];
    stored_ammo[weapon] = level.player getWeaponAmmoClip(weapon);
  }
  claymoreCount = 0;
  if(isDefined(stored_ammo["claymore"]) && stored_ammo["claymore"] > 0) {
    claymoreCount = stored_ammo["claymore"];
  }
  return claymoreCount;
}

getPlayerC4() {
  heldweapons = level.player getweaponslist();
  stored_ammo = [];
  for(i = 0; i < heldweapons.size; i++) {
    weapon = heldweapons[i];
    stored_ammo[weapon] = level.player getWeaponAmmoClip(weapon);
  }
  c4Count = 0;
  if(isDefined(stored_ammo["c4"]) && stored_ammo["c4"] > 0) {
    c4Count = stored_ammo["c4"];
  }
  return c4Count;
}

_wait(timer) {
  wait(timer);
}

_setsaveddvar(var, val) {
  setsaveddvar(var, val);
}

giveachievement_wrapper(achievement, all_players) {
  if(achievement == "") {
    return;
  }
  if(isCoopEPD()) {
    return;
  }
  if(!(maps\_cheat::is_cheating()) && !(flag("has_cheated"))) {
    if(isDefined(all_players) && all_players) {
      players = get_players();
      for(i = 0; i < players.size; i++) {
        players[i] GiveAchievement(achievement);
      }
    } else {
      if(!IsPlayer(self)) {
        println("^1self needs to be a player for _utility::giveachievement_wrapper()");
        return;
      }
      self GiveAchievement(achievement);
    }
  }
}

delete_on_not_defined() {
  for(;;) {
    if(!isDefined(self))
      return;
    wait(0.05);
  }
}

slowmo_start() {
  flag_set("disable_slowmo_cheat");
}

slowmo_end() {
  maps\_cheat::slowmo_system_defaults();
  flag_clear("disable_slowmo_cheat");
}

slowmo_setspeed_slow(speed) {
  if(!maps\_cheat::slowmo_check_system()) {
    return;
  }
  level.slowmo.speed_slow = speed;
}

slowmo_setspeed_norm(speed) {
  if(!maps\_cheat::slowmo_check_system()) {
    return;
  }
  level.slowmo.speed_norm = speed;
}

slowmo_setlerptime_in(time) {
  if(!maps\_cheat::slowmo_check_system()) {
    return;
  }
  level.slowmo.lerp_time_in = time;
}

slowmo_setlerptime_out(time) {
  if(!maps\_cheat::slowmo_check_system()) {
    return;
  }
  level.slowmo.lerp_time_out = time;
}

slowmo_lerp_in() {
  if(!flag("disable_slowmo_cheat")) {
    return;
  }
  level.slowmo thread maps\_cheat::gamespeed_set(level.slowmo.speed_slow, level.slowmo.speed_current, level.slowmo.lerp_time_in);
}

slowmo_lerp_out() {
  if(!flag("disable_slowmo_cheat")) {
    return;
  }
  level.slowmo thread maps\_cheat::gamespeed_reset();
}

add_earthquake(name, mag, duration, radius) {
  level.earthquake[name]["magnitude"] = mag;
  level.earthquake[name]["duration"] = duration;
  level.earthquake[name]["radius"] = radius;
}

arcademode_assignpoints(amountDvar, player) {
  if(getdvar("arcademode") != "1")
    return;
  thread maps\_arcademode::arcademode_assignpoints_toplayer(amountDvar, player);
}

arcadeMode() {
  if(getdebugdvar("replay_debug") == "1")
    println("File: _utility.gsc. Function: arcadeMode()\n");
  isArcadeMode = getdvar("arcademode") == "1";
  if(getdebugdvar("replay_debug") == "1")
    println("File: _utility.gsc. Function: arcadeMode() - COMPLETE\n");
  return isArcadeMode;
}

coopGame() {
  return ((getdvar("systemlink") == "1") || (getdvar("onlinegame") == "1") || IsSplitScreen());
}

#using_animtree("generic_human");

collectible_corpse_spawn(origin_target, enemy_char_model_function) {
  orig = GetStruct(origin_target, "targetname");
  if(!isDefined(orig)) {
    ASSERTMSG("collectible_corpse: couldn't GetStruct: '" + origin_target + "'");
  }
  orig.origin = groundpos(orig.origin);
  corpse = spawn("script_model", orig.origin);
  corpse.angles = orig.angles;
  corpse[[enemy_char_model_function]]();
  corpse Detach(corpse.gearModel);
  corpse UseAnimTree(#animtree);
  corpse.animname = "collectible";
  corpse.targetname = "collectible_corpse";
  corpse thread maps\_anim::anim_loop_solo(corpse, "collectible_loop", undefined, "stop_collectible_loop", orig);
  level waittill("stop_collectible_loop");
  corpse notify("stop_collectible_loop");
  wait(0.1);
  corpse Delete();
}

MusicPlayWrapper(song, timescale, overrideCheat) {
  level.last_song = song;
  if(!arcadeMode()) {
    if(!isDefined(timescale))
      timescale = true;
    if(!isDefined(overrideCheat))
      overrideCheat = false;
    MusicPlay(song, timescale, overrideCheat);
  }
}

player_is_near_live_grenade() {
  grenades = getEntArray("grenade", "classname");
  for(i = 0; i < grenades.size; i++) {
    grenade = grenades[i];
    players = get_players();
    for(j = 0; j < players.size; j++) {
      if(DistanceSquared(grenade.origin, players[j].origin) < 250 * 250) {
        maps\_autosave::auto_save_print("autosave failed: live grenade too close to player " + j);
        return true;
      }
    }
  }
  return false;
}

player_died_recently() {
  return getdvarint("player_died_recently") > 0;
}

lerp_dvar_value(dvar, value, time) {
  steps = time * 20;
  curr_value = GetDvarFloat(dvar);
  diff = (curr_value - value) / steps;
  for(i = 0; i < steps; i++) {
    curr_value = curr_value - diff;
    SetSavedDvar(dvar, curr_value);
    wait(0.05);
  }
  SetSavedDvar(dvar, value);
}

set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist) {
  if(!IsSplitScreen()) {
    return;
  }
  if(!isDefined(start_dist) && !isDefined(halfway_dist) && !isDefined(halfway_height) && !isDefined(base_height) && !isDefined(red) && !isDefined(green) && !isDefined(blue)) {
    level thread default_fog_print();
  }
  if(!isDefined(start_dist)) {
    start_dist = 0;
  }
  if(!isDefined(halfway_dist)) {
    halfway_dist = 200;
  }
  if(!isDefined(base_height)) {
    base_height = -2000;
  }
  if(!isDefined(red)) {
    red = 1;
  }
  if(!isDefined(green)) {
    green = 1;
  }
  if(!isDefined(blue)) {
    blue = 0;
  }
  if(!isDefined(trans_time)) {
    trans_time = 0;
  }
  if(!isDefined(cull_dist)) {
    cull_dist = 2000;
  }
  halfway_height = base_height + 2000;
  level.splitscreen_fog = true;
  SetVolFog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, 0);
  SetCullDist(cull_dist);
}

default_fog_print() {
  wait_for_first_player();
  iprintlnbold("^3USING DEFAULT FOG SETTINGS FOR SPLITSCREEN");
  wait(8);
  iprintlnbold("^3USING DEFAULT FOG SETTINGS FOR SPLITSCREEN");
  wait(8);
  iprintlnbold("^3USING DEFAULT FOG SETTINGS FOR SPLITSCREEN");
}

share_screen(player, toggle, instant) {
  if(!IsSplitscreen()) {
    return;
  }
  time = 1;
  if(isDefined(instant) && instant) {
    time = 0.1;
  }
  toggle = !toggle;
  SplitViewAllowed(player GetEntityNumber(), toggle, time);
}

get_players() {
  players = GetPlayers();
  return players;
}

get_host() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] GetEntityNumber() == 0) {
      return players[i];
    }
  }
}

is_coop() {
  players = get_players();
  if(players.size > 1) {
    return true;
  }
  return false;
}

any_player_IsTouching(ent) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(IsAlive(players[i]) && players[i] IsTouching(ent)) {
      return true;
    }
  }
  return false;
}

get_player_touching(ent) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(IsAlive(players[i]) && players[i] IsTouching(ent)) {
      return players[i];
    }
  }
  return undefined;
}

get_closest_player(org) {
  players = get_players();
  return GetClosest(org, players);
}

add_player_spawnpoint(spawnpoint) {
  if(!isDefined(level.player_spawnpoints)) {
    clear_player_spawnpoints();
  }
  level.player_spawnpoints[level.player_spawnpoints.size] = spawnpoint;
}

clear_player_spawnpoints() {
  level.player_spawnpoints = [];
}

set_player_spawnpoints(spawnpoints) {
  level.player_spawnpoints = spawnpoints;
}

freezecontrols_all(toggle, delay) {
  if(isDefined(delay)) {
    wait(delay);
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] FreezeControls(toggle);
  }
}

get_random_player() {
  players = get_players();
  players = array_randomize(players);
  return players[0];
}

set_all_players_blur(amount, time) {
  wait_for_first_player();
  flag_wait("all_players_connected");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] SetBlur(amount, time);
  }
}

set_all_players_double_vision(amount, time) {
  wait_for_first_player();
  flag_wait("all_players_connected");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] SetDoubleVision(amount, time);
  }
}

set_all_players_shock(shellshock_file, time) {
  wait_for_first_player();
  flag_wait("all_players_connected");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] Shellshock(shellshock_file, time);
  }
}

set_all_players_visionset(vision_file, time) {
  wait_for_first_player();
  flag_wait("all_players_connected");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] VisionSetNaked(vision_file, time);
  }
}

hide_all_player_models() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] Hide();
  }
}

show_all_player_models() {
  flag_wait("all_players_connected");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] Show();
  }
}

player_flag_wait(msg) {
  while(!self.flag[msg]) {
    self waittill(msg);
  }
}

player_flag_wait_either(flag1, flag2) {
  for(;;) {
    if(flag(flag1)) {
      return;
    }
    if(flag(flag2)) {
      return;
    }
    self waittill_either(flag1, flag2);
  }
}

player_flag_waitopen(msg) {
  while(self.flag[msg]) {
    self waittill(msg);
  }
}

player_flag_init(message, trigger) {
  if(!isDefined(self.flag)) {
    self.flag = [];
    self.flags_lock = [];
  }
  assertex(!isDefined(self.flag[message]), "Attempt to reinitialize existing message: " + message);
  self.flag[message] = false;
  self.flags_lock[message] = false;
}

player_flag_set_delayed(message, delay) {
  wait(delay);
  player_flag_set(message);
}

player_flag_set(message) {
  assertex(isDefined(self.flag[message]), "Attempt to set a flag before calling flag_init: " + message);
  assert(self.flag[message] == self.flags_lock[message]);
  self.flags_lock[message] = true;
  self.flag[message] = true;
  self notify(message);
}

player_flag_clear(message) {
  assertex(isDefined(self.flag[message]), "Attempt to set a flag before calling flag_init: " + message);
  assert(self.flag[message] == self.flags_lock[message]);
  self.flags_lock[message] = false;
  self.flag[message] = false;
  self notify(message);
}

player_flag(message) {
  assertex(isDefined(message), "Tried to check flag but the flag was not defined.");
  if(!self.flag[message]) {
    return false;
  }
  return true;
}

wait_for_first_player() {
  players = get_players();
  if(!isDefined(players) || players.size == 0) {
    level waittill("first_player_ready");
  }
}

wait_for_all_players() {
  flag_wait("all_players_connected");
}

findBoxCenter(mins, maxs) {
  center = (0, 0, 0);
  center = maxs - mins;
  center = (center[0] / 2, center[1] / 2, center[2] / 2) + mins;
  return center;
}

expandMins(mins, point) {
  if(mins[0] > point[0]) {
    mins = (point[0], mins[1], mins[2]);
  }
  if(mins[1] > point[1]) {
    mins = (mins[0], point[1], mins[2]);
  }
  if(mins[2] > point[2]) {
    mins = (mins[0], mins[1], point[2]);
  }
  return mins;
}

expandMaxs(maxs, point) {
  if(maxs[0] < point[0]) {
    maxs = (point[0], maxs[1], maxs[2]);
  }
  if(maxs[1] < point[1]) {
    maxs = (maxs[0], point[1], maxs[2]);
  }
  if(maxs[2] < point[2]) {
    maxs = (maxs[0], maxs[1], point[2]);
  }
  return maxs;
}

getAIarrayTouchingVolume(sTeamName, sVolumeName, eVolume) {
  if(!isDefined(eVolume)) {
    eVolume = getent(sVolumeName, "targetname");
    assertEx(isDefined(eVolume), sVolumeName + " does not exist");
  }
  if(sTeamName == "all") {
    aTeam = getaiarray();
  } else {
    aTeam = getaiarray(sTeamName);
  }
  aGuysTouchingVolume = [];
  for(i = 0; i < aTeam.size; i++) {
    if(aTeam[i] isTouching(eVolume)) {
      aGuysTouchingVolume[aGuysTouchingVolume.size] = aTeam[i];
    }
  }
  return aGuysTouchingVolume;
}

registerClientSys(sSysName) {
  if(!isDefined(level._clientSys)) {
    level._clientSys = [];
  }
  if(level._clientSys.size >= 32) {
    error("Max num client systems exceeded.");
    return;
  }
  if(isDefined(level._clientSys[sSysName])) {
    error("Attempt to re-register client system : " + sSysName);
    return;
  } else {
    level._clientSys[sSysName] = spawnStruct();
    level._clientSys[sSysName].sysID = ClientSysRegister(sSysName);
    println("registered client system " + sSysName + " to id " + level._clientSys[sSysName].sysID);
  }
}

setClientSysState(sSysName, sSysState, player) {
  if(!isDefined(level._clientSys)) {
    error("setClientSysState called before registration of any systems.");
    return;
  }
  if(!isDefined(level._clientSys[sSysName])) {
    error("setClientSysState called on unregistered system " + sSysName);
    return;
  }
  if(isDefined(player)) {
    player ClientSysSetState(level._clientSys[sSysName].sysID, sSysState);
  } else {
    ClientSysSetState(level._clientSys[sSysName].sysID, sSysState);
    level._clientSys[sSysName].sysState = sSysState;
    println("set client system " + sSysName + "(" + level._clientSys[sSysName].sysID + ")" + " to " + sSysState);
  }
}

getClientSysState(sSysName) {
  if(!isDefined(level._clientSys)) {
    error("Cannot getClientSysState before registering any client systems.");
    return "";
  }
  if(!isDefined(level._clientSys[sSysName])) {
    error("Client system " + sSysName + " cannot return state, as it is unregistered.");
    return "";
  }
  if(isDefined(level._clientSys[sSysName].sysState)) {
    return level._clientSys[sSysName].sysState;
  }
  return "";
}

russian_diary_event(outcome) {
  outcome = ToLower(outcome);
  switch (outcome) {
    case "good":
      level clientNotify("pcg");
      break;
    case "evil":
      level clientNotify("pce");
      break;
    default:
      assertmsg("Unknown russian diary outcome: '" + outcome + "'");
      break;
  }
}

wait_network_frame() {
  snapshot_ids = getsnapshotindexarray();
  acked = undefined;
  while(!isDefined(acked)) {
    level waittill("snapacknowledged");
    acked = snapshotacknowledged(snapshot_ids);
  }
}

clientNotify(event) {
  if(level.clientscripts) {
    maps\_utility::setClientSysState("levelNotify", event);
  }
}

ok_to_spawn(max_wait_seconds) {
  if(isDefined(max_wait_seconds)) {
    timer = GetTime() + max_wait_seconds * 1000;
    while(GetTime() < timer && !OkTospawn()) {
      wait(0.05);
    }
  } else {
    while(!OkTospawn()) {
      wait(0.05);
    }
  }
}

set_breadcrumbs(starts) {
  ASSERTEX(starts.size == 4, "set_breadcrumbs: there aren't 4 player start spots!");
  if(!isDefined(level._player_breadcrumbs)) {
    maps\_callbackglobal::Player_BreadCrumb_Reset((0, 0, 0));
  }
  for(i = 0; i < 4; i++) {
    for(j = 0; j < 4; j++) {
      level._player_breadcrumbs[i][j].pos = starts[j].origin;
      if(isDefined(starts[j].angles)) {
        level._player_breadcrumbs[i][j].ang = starts[j].angles;
      } else {
        level._player_breadcrumbs[i][j].ang = (0, 0, 0);
      }
    }
  }
}

set_breadcrumbs_player_positions() {
  if(!isDefined(level._player_breadcrumbs)) {
    maps\_callbackglobal::Player_BreadCrumb_Reset((0, 0, 0));
  }
  players = get_players();
  for(i = 0; i < players.size; i++) {
    level._player_breadcrumbs[i][0].pos = players[i].origin;
    level._player_breadcrumbs[i][0].ang = players[i].angles;
  }
}

trigger_coop_warp(trigger) {
  if(!isDefined(trigger.target)) {
    AssertMsg("warp_trigger at " + trigger.origin + " does not target anything, the .target is undefined");
    return;
  }
  structs = getstructarray(trigger.target, "targetname");
  structs = array_randomize(structs);
  if(isDefined(trigger.script_linkto)) {
    for(i = 0; i < structs.size; i++) {
      structs[i].script_linkto = trigger.script_linkto;
    }
  }
  if(!isDefined(structs) || structs.size == 0) {
    AssertMsg("warp_trigger at " + trigger.origin + " does not target any structs");
    return;
  }
  requiredStructs = 8;
  if(structs.size < requiredStructs) {
    ASSERTMSG("warp_trigger at " + trigger.origin + " only targets " + structs.size + " structs.You should target at least " + requiredStructs + ", in case some spots are invalid when warping occurs.");
    return;
  }
  safe_trigger = GetEnt(trigger.target, "targetname");
  if(!isDefined(safe_trigger)) {
    AssertMsg("warp_trigger at " + trigger.origin + " does not target a safe trigger");
    return;
  }
  trigger waittill("trigger", toucher);
  if(!isDefined(trigger.touchedby)) {
    trigger.touchedby = toucher;
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] == toucher || players[i] IsTouching(safe_trigger)) {
        continue;
      }
      players[i] thread warp_player_start(0.2);
      players[i].warp_start = true;
    }
    println("Deleting warp trigger.");
    trigger delete();
    wait(1);
    all_ai = GetAiArray();
    players = get_players();
    avoid_ents = array_combine(all_ai, players);
    for(i = 0; i < players.size; i++) {
      if(!isDefined(players[i].warp_start) || players[i].warp_start == false) {
        players[i].warp_start = undefined;
        continue;
      }
      warp_struct = undefined;
      for(q = 0; q < structs.size; q++) {
        if(warp_spot_is_safe(structs[q], avoid_ents)) {
          warp_struct = structs[q];
          warp_struct.used = true;
          break;
        }
      }
      if(isDefined(warp_struct)) {
        players[i].no_warp = undefined;
        players[i] thread warp_player_end();
        players[i] thread coop_warp_player(warp_struct);
      } else {
        players[i].no_warp = true;
      }
    }
    retries = 30;
    while(retries) {
      players = get_players();
      for(i = 0; i < players.size; i++) {
        if(!isDefined(players[i].no_warp) || players[i] IsTouching(safe_trigger)) {
          players[i].no_warp = undefined;
          continue;
        }
        if(retries == 1)
          avoid_ents = [];
        warp_struct = undefined;
        for(q = 0; q < structs.size; q++) {
          if(warp_spot_is_safe(structs[q], avoid_ents)) {
            warp_struct = structs[q];
            warp_struct.used = true;
            break;
          }
        }
        if(isDefined(warp_struct)) {
          players[i].no_warp = undefined;
          players[i] thread warp_player_end();
          players[i] thread coop_warp_player(warp_struct);
        } else {
          players[i].no_warp = true;
        }
      }
      dudes_needing_warps = players.size;
      for(i = 0; i < players.size; i++) {
        if(!isDefined(players[i].no_warp)) {
          dudes_needing_warps--;
        }
      }
      if(dudes_needing_warps == 0) {
        return;
      }
      wait 2;
      retries--;
    }
    players = get_players();
    for(i = 0; i < players.size; i++) {
      assert(!isDefined(players[i].no_warp));
    }
  }
}

coop_warp_player(struct) {
  pos = playergroundpos(struct.origin);
  if(isDefined(level._effect["warp_fx"])) {
    playFX(level._effect["warp_fx"], pos + (0, 0, 72));
  }
  mg42s = getEntArray("misc_mg42", "classname");
  turrets = getEntArray("misc_turret", "classname");
  turrets = array_combine(mg42s, turrets);
  for(i = 0; i < turrets.size; i++) {
    ent = turrets[i] getturretowner();
    if(isDefined(ent)) {
      if(ent == self) {
        ent useby(self);
        self stopusingturret();
        break;
      }
    }
  }
  self SetOrigin(pos);
  self SetPlayerAngles(struct.angles);
  if(isDefined(struct.script_linkto)) {
    trigger = GetEnt(struct.script_linkto, "script_linkname");
    if(!isDefined(trigger)) {
      return;
    }
    if(isDefined(trigger.script_start_dist)) {
      self SetVolFog(trigger.script_start_dist, trigger.script_halfway_dist,
        trigger.script_halfway_height, trigger.script_base_height,
        trigger.script_color[0], trigger.script_color[1], trigger.script_color[2],
        trigger.script_transition_time);
      if(isDefined(trigger.script_vision) && isDefined(trigger.script_vision_time)) {
        self VisionSetNaked(trigger.script_vision, trigger.script_vision_time);
      }
    }
  }
}

warp_player_start(fade_time) {
  if(!isDefined(self.warp_text)) {
    self EnableInvulnerability();
    self DisableWeapons();
    hudString = &"GAME_COOP_WARP_PLAYER_HINT";
    if(GetDvarInt("splitscreen") && !GetDvarInt("hidef"))
      fontScale = 2.5;
    else
      fontScale = 1.75;
    self.warp_text = newClientHudElem(self);
    self.warp_text.y = 100;
    self.warp_text.alignX = "center";
    self.warp_text.horzAlign = "center";
    self.warp_text.vertAlign = "top";
    self.warp_text.foreground = true;
    self.warp_text.fontScale = fontScale;
    self.warp_text.sort = 1;
    self.warp_text.hidewheninmenu = true;
    self.warp_text SetText(hudString);
    self.warp_text.alpha = 0;
    self.warp_text FadeOverTime(fade_time);
    self.warp_text.alpha = 1;
    self.warp_bg = newClientHudElem(self);
    self.warp_bg.x = 0;
    self.warp_bg.y = 0;
    self.warp_bg.horzAlign = "fullscreen";
    self.warp_bg.vertAlign = "fullscreen";
    self.warp_bg.foreground = true;
    self.warp_bg.sort = 1;
    self.warp_bg.hidewheninmenu = true;
    self.warp_bg SetShader("black", 640, 480);
    self.warp_bg.alpha = 0;
    self.warp_bg FadeOverTime(fade_time);
    self.warp_bg.alpha = 1;
  }
}

warp_player_end() {
  self EnableWeapons();
  if(isDefined(self.warp_text)) {
    self.warp_text FadeOverTime(0.5);
    self.warp_text.alpha = 0;
    self.warp_bg FadeOverTime(0.5);
    self.warp_bg.alpha = 0;
    wait(0.5);
    self.warp_text Destroy();
    self.warp_bg Destroy();
    wait(3);
  }
  self DisableInvulnerability();
  self notify("coop_warp_complete");
}

warp_spot_is_safe(struct, avoid_ents) {
  if(isDefined(struct.used) && struct.used) {
    return false;
  }
  dist = 40;
  for(i = 0; i < avoid_ents.size; i++) {
    if(DistanceSquared(avoid_ents[i].origin, struct.origin) < dist * dist) {
      return false;
    }
  }
  return true;
}

warp_a_player(warp_point) {
  self thread warp_player_start(0.2);
  wait 0.2;
  self coop_warp_player(warp_point);
  self thread warp_player_end();
}

debug_warp_point() {
  while(1) {
    print3d(self.origin, "+", (0.0, 1.0, 0.0), 1);
    print3d(groundpos(self.origin), "+", (1.0, 0.0, 0.0), 1);
    print3d(playergroundpos(self.origin), "+", (0.0, 0.0, 1.0), 1);
    wait(0.05);
  }
}

spread_array_thread(entities, process, var1, var2, var3) {
  keys = getArrayKeys(entities);
  if(isDefined(var3)) {
    for(i = 0; i < keys.size; i++) {
      entities[keys[i]] thread[[process]](var1, var2, var3);
      wait_network_frame();
    }
    return;
  }
  if(isDefined(var2)) {
    for(i = 0; i < keys.size; i++) {
      entities[keys[i]] thread[[process]](var1, var2);
      wait_network_frame();
    }
    return;
  }
  if(isDefined(var1)) {
    for(i = 0; i < keys.size; i++) {
      entities[keys[i]] thread[[process]](var1);
      wait_network_frame();
    }
    return;
  }
  for(i = 0; i < keys.size; i++) {
    entities[keys[i]] thread[[process]]();
    wait_network_frame();
  }
}