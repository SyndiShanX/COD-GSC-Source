/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_utility.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility_code;

array_levelthread(array, process, var1, var2, var3, var4) {
  keys = getArrayKeys(array);
  if(isDefined(var4)) {
    for(i = 0; i < keys.size; i++) {
      thread[[process]](array[keys[i]], var1, var2, var3, var4);
    }
    return;
  }
  if(isDefined(var3)) {
    for(i = 0; i < keys.size; i++) {
      thread[[process]](array[keys[i]], var1, var2, var3);
    }
    return;
  }
  if(isDefined(var2)) {
    for(i = 0; i < keys.size; i++) {
      thread[[process]](array[keys[i]], var1, var2);
    }
    return;
  }
  if(isDefined(var1)) {
    for(i = 0; i < keys.size; i++) {
      thread[[process]](array[keys[i]], var1);
    }
    return;
  }
  for(i = 0; i < keys.size; i++) {
    thread[[process]](array[keys[i]]);
  }
}

set_vision_set(visionset, transition_time) {
  if(init_vision_set(visionset)) {
    return;
  }
  if(!isDefined(transition_time)) {
    transition_time = 1;
  }
  visionSetNaked(visionset, transition_time);
}

ent_flag_wait(msg) {
  self endon("death");
  while(!self.ent_flag[msg]) {
    self waittill(msg);
  }
}

ent_flag_wait_either(flag1, flag2) {
  self endon("death");
  for(;;) {
    if(ent_flag(flag1)) {
      return;
    }
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
  while(self.ent_flag[msg]) {
    self waittill(msg);
  }
}

ent_flag_init(message, val) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }
  if(!isDefined(level.first_frame)) {
    assertEx(!isDefined(self.ent_flag[message]), "Attempt to reinitialize existing flag '" + message + "' on entity.");
  }
  if(is_true(val)) {
    self.ent_flag[message] = true;
  } else {
    self.ent_flag[message] = false;
  }
}

ent_flag_set_delayed(message, delay) {
  wait(delay);
  self ent_flag_set(message);
}

ent_flag_set(message) {
  self.ent_flag[message] = true;
  self notify(message);
}

ent_flag_toggle(message) {
  if(self ent_flag(message)) {
    self ent_flag_clear(message);
  } else {
    self ent_flag_set(message);
  }
}

ent_flag_clear(message) {
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
  AssertEx(isDefined(message), "Tried to check flag but the flag was not defined.");
  AssertEx(isDefined(self.ent_flag[message]), "Tried to check entity flag '" + message + "', but the flag was not initialized.");
  if(!self.ent_flag[message]) {
    return false;
  }
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
    if(flag(flag1)) {
      return;
    }
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
      if(flag(array[i])) {
        return;
      }
    }
    level waittill_any(flag1, flag2, flag3, flag4);
  }
}

flag_wait_all(flag1, flag2, flag3, flag4) {
  if(isDefined(flag1)) {
    flag_wait(flag1);
  }
  if(isDefined(flag2)) {
    flag_wait(flag2);
  }
  if(isDefined(flag3)) {
    flag_wait(flag3);
  }
  if(isDefined(flag4)) {
    flag_wait(flag4);
  }
}

flag_wait_on(flagname) {
  while(!level flag_exists(flagname)) {
    wait 0.05;
  }
  flag_wait(flagname);
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
  if(!isDefined(continuous)) {
    continuous = false;
  }
  assert(isSubStr(trigger.classname, "trigger"));
  trigger thread _flag_wait_trigger(message, continuous);
  return trigger;
}

flag_triggers_init(message, triggers, all) {
  flag_init(message);
  if(!isDefined(all)) {
    all = false;
  }
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
    while(other isTouching(self)) {
      wait(0.05);
    }
    flag_clear(message);
  }
}

wait_endon(waitTime, endOnString, endonString2, endonString3) {
  self endon(endOnString);
  if(isDefined(endonString2))
    self endon(endonString2);
  if(isDefined(endonString3))
    self endon(endonString3);
  wait(waitTime);
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

error(message) {
  println("^c * ERROR * ", message);
  wait 0.05;
}

error2(message) {
  println("^c * ERROR * ", message);
  wait 0.05;
}

debug_message(message, origin, duration) {
  if(!isDefined(duration)) {
    duration = 5;
  }
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
  if(!isDefined(duration)) {
    duration = 5;
  }
  for(time = 0; time < (duration * 20); time++) {
    print3d((origin + (0, 0, 45)), message, (0.48, 9.4, 0.76), 0.85);
    wait 0.05;
  }
}

precache(model) {
  ent = spawn("script_model", (0, 0, 0));
  ent.origin = get_players()[0] getorigin();
  ent setModel(model);
  ent delete();
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

getFarthest(org, array, dist) {
  return compareSizes(org, array, dist, ::fartherFunc);
}

compareSizesFx(org, array, dist, compareFunc) {
  if(!array.size) {
    return undefined;
  }
  if(isDefined(dist)) {
    struct = undefined;
    keys = getArrayKeys(array);
    for(i = 0; i < keys.size; i++) {
      newdist = distance(array[keys[i]].v["origin"], org);
      if([[compareFunc]](newDist, dist)) {
        continue;
      }
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
      ](newDist, dist)) {
      continue;
    }
    dist = newdist;
    struct = array[keys[i]];
  }
  return struct;
}

compareSizes(org, array, dist, compareFunc) {
  if(!array.size) {
    return undefined;
  }
  if(isDefined(dist)) {
    ent = undefined;
    keys = GetArrayKeys(array);
    for(i = 0; i < keys.size; i++) {
      newdist = distance(array[keys[i]].origin, org);
      if([[compareFunc]](newDist, dist)) {
        continue;
      }
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
      ](newDist, dist)) {
      continue;
    }
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
  if(!isDefined(maxDist) || dist <= maxDist) {
    return closestPoint;
  }
  return undefined;
}

get_within_range(org, array, dist) {
  guys = [];
  for(i = 0; i < array.size; i++) {
    if(distance(array[i].origin, org) <= dist) {
      guys[guys.size] = array[i];
    }
  }
  return guys;
}

get_outside_range(org, array, dist) {
  guys = [];
  for(i = 0; i < array.size; i++) {
    if(distance(array[i].origin, org) > dist) {
      guys[guys.size] = array[i];
    }
  }
  return guys;
}

get_closest_living(org, array, dist) {
  if(!isDefined(dist)) {
    dist = 9999999;
  }
  if(array.size < 1) {
    return;
  }
  ent = undefined;
  for(i = 0; i < array.size; i++) {
    if(!isalive(array[i])) {
      continue;
    }
    newdist = distance(array[i].origin, org);
    if(newdist >= dist) {
      continue;
    }
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
    if(newdot < dot) {
      continue;
    }
    dot = newdot;
    ent = array[i];
  }
  return ent;
}

get_closest_index(org, array, dist) {
  if(!isDefined(dist)) {
    dist = 9999999;
  }
  if(array.size < 1) {
    return;
  }
  index = undefined;
  for(i = 0; i < array.size; i++) {
    newdist = distance(array[i].origin, org);
    if(newdist >= dist) {
      continue;
    }
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
  if(!isDefined(ents)) {
    return undefined;
  }
  range = 0;
  if(isDefined(excluders) && excluders.size) {
    exclude = [];
    for(i = 0; i < ents.size; i++) {
      exclude[i] = false;
    }
    for(i = 0; i < ents.size; i++) {
      for(p = 0; p < excluders.size; p++) {
        if(ents[i] == excluders[p]) {
          exclude[i] = true;
        }
      }
    }
    found_unexcluded = false;
    for(i = 0; i < ents.size; i++) {
      if((!exclude[i]) && (isDefined(ents[i]))) {
        found_unexcluded = true;
        range = distance(org, ents[i].origin);
        ent = i;
        i = ents.size + 1;
      }
    }
    if(!found_unexcluded) {
      return (undefined);
    }
  } else {
    for(i = 0; i < ents.size; i++) {
      if(isDefined(ents[i])) {
        range = distance(org, ents[0].origin);
        ent = i;
        i = ents.size + 1;
      }
    }
  }
  ent = undefined;
  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i])) {
      exclude = false;
      if(isDefined(excluders)) {
        for(p = 0; p < excluders.size; p++) {
          if(ents[i] == excluders[p]) {
            exclude = true;
          }
        }
      }
      if(!exclude) {
        newrange = distance(org, ents[i].origin);
        if(newrange <= range) {
          range = newrange;
          ent = i;
        }
      }
    }
  }
  if(isDefined(ent)) {
    return ents[ent];
  } else {
    return undefined;
  }
}

get_closest_ai(org, team) {
  if(isDefined(team)) {
    ents = GetAiArray(team);
  } else {
    ents = GetAiArray();
  }
  if(ents.size == 0) {
    return undefined;
  }
  return getClosest(org, ents);
}

get_array_of_closest(org, array, excluders, max, maxdist) {
  if(!isDefined(max)) {
    max = array.size;
  }
  if(!isDefined(excluders)) {
    excluders = [];
  }
  maxdists2rd = undefined;
  if(isDefined(maxdist)) {
    maxdists2rd = maxdist * maxdist;
  }
  dist = [];
  index = [];
  for(i = 0; i < array.size; i++) {
    excluded = false;
    for(p = 0; p < excluders.size; p++) {
      if(array[i] != excluders[p]) {
        continue;
      }
      excluded = true;
      break;
    }
    if(excluded) {
      continue;
    }
    if(!isDefined(array[i])) {
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
      if(dist[i] <= dist[i + 1]) {
        continue;
      }
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
  if(max > dist.size) {
    max = dist.size;
  }
  for(i = 0; i < max; i++) {
    newArray[i] = array[index[i]];
  }
  return newArray;
}

get_array_of_farthest(org, array, excluders, max) {
  sorted_array = get_array_of_closest(org, array, excluders, max);
  sorted_array = array_reverse(sorted_array);
  return (sorted_array);
}

get_closest_ai_exclude(org, team, excluders) {
  if(isDefined(team)) {
    ents = GetAiArray(team);
  } else {
    ents = GetAiArray();
  }
  if(ents.size == 0) {
    return undefined;
  }
  return get_closest_exclude(org, ents, excluders);
}

stop_magic_bullet_shield() {
  if(IsAI(self)) {
    self BloodImpact("normal");
  }
  self.attackerAccuracy = 1;
  self notify("stop_magic_bullet_shield");
  self.magic_bullet_shield = undefined;
  self._mbs = undefined;
}

magic_bullet_shield() {
  if(!is_true(self.magic_bullet_shield)) {
    if(IsAI(self) || IsPlayer(self)) {
      self.magic_bullet_shield = true;
      if(!isDefined(self._mbs)) {
        self._mbs = spawnStruct();
      }
      if(IsAI(self)) {
        AssertEx(IsAlive(self), "Tried to do magic_bullet_shield on a dead or undefined guy.");
        self._mbs.last_pain_time = 0;
        self._mbs.ignore_time = 5;
        self._mbs.turret_ignore_time = 5;
        self BloodImpact("hero");
      }
      self.attackerAccuracy = 0.1;
    } else {
      if(self is_vehicle()) {
        AssertMsg("Use veh_magic_bullet_shield for vehicles.");
      } else {
        AssertMsg("magic_bullet_shield does not support entity of classname '" + self.classname + "'.");
      }
    }
  }
}

debug_magic_bullet_shield_death(guy) {
  targetname = "none";
  if(isDefined(guy.targetname)) {
    targetname = guy.targetname;
  }
  guy endon("stop_magic_bullet_shield");
  guy waittill("death");
  AssertEx(!isDefined(guy), "Guy died with magic bullet shield on with targetname: " + targetname);
}

disable_long_death() {
  assertex(isalive(self), "Tried to disable long death on a non living thing");
  self.a.disableLongDeath = true;
}

enable_long_death() {
  assertex(isalive(self), "Tried to enable long death on a non living thing");
  self.a.disableLongDeath = false;
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

ignore_me_timer(time, endon_msg) {
  self notify("ignore_me_timer");
  self.ignore_me_timer_old = self get_ignoreme();
  if(!self.ignore_me_timer_old) {
    ai = GetAiArray("axis");
    for(i = 0; i < ai.size; i++) {
      guy = ai[i];
      if(IsAlive(guy.enemy) && guy.enemy == self) {
        guy notify("enemy");
      }
    }
  }
  self endon("death");
  self endon("ignore_me_timer");
  self set_ignoreme(true);
  waittill_any_or_timeout(time, endon_msg);
  self set_ignoreme(self.ignore_me_timer_old);
}

turret_ignore_me_timer(time) {
  self endon("death");
  self endon("pain");
  self.turretInvulnerability = true;
  wait time;
  self.turretInvulnerability = false;
}

exploder_damage() {
  if(isDefined(self.v["delay"])) {
    delay = self.v["delay"];
  } else {
    delay = 0;
  }
  if(isDefined(self.v["damage_radius"])) {
    radius = self.v["damage_radius"];
  } else {
    radius = 128;
  }
  damage = self.v["damage"];
  origin = self.v["origin"];
  wait(delay);
  self.model RadiusDamage(origin, radius, damage, damage / 3);
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
  level notify("exploder" + self.v["exploder"]);
  if(level.createFX_enabled || !level.clientScripts || !isDefined(level._exploder_ids[int(self.v["exploder"])]) || isDefined(self.v["exploder_server"])) {
    if(isDefined(self.v["firefx"])) {
      self thread fire_effect();
    }
    if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX") {
      self thread cannon_effect();
    } else if(isDefined(self.v["soundalias"])) {
      self thread sound_effect();
    }
    if(isDefined(self.v["earthquake"])) {
      self thread exploder_earthquake();
    }
    if(isDefined(self.v["rumble"])) {
      self thread exploder_rumble();
    }
  }
  if(isDefined(self.v["trailfx"])) {
    self thread trail_effect();
  }
  if(isDefined(self.v["damage"])) {
    self thread exploder_damage();
  }
  if(self.v["exploder_type"] == "exploder") {
    self thread brush_show();
  } else if((self.v["exploder_type"] == "exploderchunk") || (self.v["exploder_type"] == "exploderchunk visible")) {
    self thread brush_throw();
  } else {
    self thread brush_delete();
  }
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

brush_delete() {
  num = self.v["exploder"];
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  } else {
    wait(.05);
  }
  if(!isDefined(self.model)) {
    return;
  }
  assert(isDefined(self.model));
  if(self.model has_spawnflag(level.SPAWNFLAG_MODEL_DYNAMIC_PATH)) {
    self.model ConnectPaths();
  }
  if(level.createFX_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
    self.model hide();
    self.model NotSolid();
    wait(3);
    self.exploded = undefined;
    self.model Show();
    self.model Solid();
    return;
  }
  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX") {
    self.v["exploder"] = undefined;
  }
  waittillframeend;
  self.model Delete();
}

brush_Show() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }
  assert(isDefined(self.model));
  self.model Show();
  self.model Solid();
  if(self.model has_spawnflag(level.SPAWNFLAG_MODEL_DYNAMIC_PATH)) {
    if(!isDefined(self.model.disconnect_paths)) {
      self.model ConnectPaths();
    } else {
      self.model DisconnectPaths();
    }
  }
  if(level.createFX_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
    wait(3);
    self.exploded = undefined;
    self.model hide();
    self.model NotSolid();
  }
}

brush_throw() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }
  ent = undefined;
  if(isDefined(self.v["target"])) {
    ent = getEnt(self.v["target"], "targetname");
  }
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
    if(isDefined(ent.target)) {
      target = getEnt(ent.target, "targetname");
    }
    if(!isDefined(target)) {
      contact_point = startorg;
      throw_vec = ent.origin;
    } else {
      contact_point = ent.origin;
      throw_vec = vector_scale(target.origin - ent.origin, self.v["physics"]);
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
    self.model hide();
    return;
  }
  self.v["exploder"] = undefined;
  wait(6);
  self.model Delete();
}

shock_onpain() {
  self endon("death");
  self endon("disconnect");
  if(getDvar(#"blurpain") == "") {
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
      if(getDvar(#"blurpain") == "on") {
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
  if(getDvar(#"r_texturebits") == "16") {
    return;
  }
}

delete_on_death(ent) {
  ent endon("death");
  self waittill("death");
  if(isDefined(ent)) {
    ent delete();
  }
}

delete_on_death_wait_sound(ent, sounddone) {
  ent endon("death");
  self waittill("death");
  if(isDefined(ent)) {
    if(ent iswaitingonsound()) {
      ent waittill(sounddone);
    }
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
  if(isDefined(tag)) {
    org LinkTo(self, tag, (0, 0, 0), (0, 0, 0));
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org LinkTo(self);
  }
  org playSound(alias, "sounddone");
  if(isDefined(ends_on_death)) {
    assertex(ends_on_death, "ends_on_death must be true or undefined");
    wait_for_sounddone_or_death(org);
    if(is_dead_sentient()) {
      org StopSounds();
    }
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
  if(!isDefined(bStopSoundOnDeath)) {
    bStopSoundOnDeath = true;
  }
  if(bStopSoundOnDeath) {
    thread delete_on_death(org);
  }
  if(isDefined(tag)) {
    org LinkTo(self, tag, (0, 0, 0), (0, 0, 0));
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org LinkTo(self);
  }
  org playLoopSound(alias);
  self waittill("stop sound" + alias);
  org stopLoopSound(alias);
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
  org stopLoopSound(0.1);
  org Delete();
}

play_sound_in_space(alias, origin, master) {
  org = spawn("script_origin", (0, 0, 1));
  if(!isDefined(origin)) {
    origin = self.origin;
  }
  org.origin = origin;
  if(isDefined(master) && master) {
    org PlaySoundAsMaster(alias, "sounddone");
  } else {
    org playSound(alias, "sounddone");
  }
  org waittill("sounddone");
  if(isDefined(org)) {
    org Delete();
  }
}

spawn_failed(spawn) {
  if(isDefined(spawn) && IsAlive(spawn)) {
    if(!isDefined(spawn.finished_spawning)) {
      spawn waittill("finished spawning");
    }
    waittillframeend;
    if(IsAlive(spawn)) {
      return false;
    }
  }
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

assign_animtree(animname) {
  if(isDefined(animname)) {
    self.animname = animname;
  }
  assertEx(isDefined(level.scr_animtree[self.animname]), "There is no level.scr_animtree for animname " + self.animname);
  animtree = level.scr_animtree[self.animname];
  self UseAnimTree(animtree);
}

assign_model(animname) {
  if(!isDefined(animname)) {
    animname = self.animname;
  }
  assertEx(isDefined(level.scr_model[animname]), "There is no level.scr_model for animname " + animname);
  self setModel(level.scr_model[animname]);
}

spawn_anim_model(animname, origin, angles, is_simple_prop) {
  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }
  model = spawn("script_model", origin);
  model assign_model(animname);
  model init_anim_model(animname, is_simple_prop);
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }
  model.angles = angles;
  return model;
}

init_anim_model(animname, is_simple_prop) {
  if(!isDefined(animname)) {
    animname = self.animname;
  }
  AssertEx(isDefined(animname), "Trying to init anim model with no animname.");
  self.animname = animname;
  if(is_true(is_simple_prop)) {
    if(!isDefined(self.anim_link)) {
      self.anim_link = spawn("script_model", self.origin);
      self.anim_link setModel("tag_origin_animate");
      level thread delete_anim_link_on_death(self, self.anim_link);
    }
    self.anim_link.animname = animname;
    self.anim_link assign_animtree();
    self Unlink();
    self.anim_link.angles = self.angles;
    self.anim_link.origin = self.origin;
    self LinkTo(self.anim_link, "origin_animate_jnt");
  } else {
    self assign_animtree();
  }
}

delete_anim_link_on_death(ent, anim_link) {
  anim_link endon("death");
  ent waittill("death");
  anim_link Delete();
}

triggerOff() {
  if(!isDefined(self.realOrigin)) {
    self.realOrigin = self.origin;
  }
  if(self.origin == self.realorigin) {
    self.origin += (0, 0, -10000);
  }
}

triggerOn() {
  if(isDefined(self.realOrigin)) {
    self.origin = self.realOrigin;
  }
}

trigger_use(strName, strKey, ent) {
  if(!isDefined(strKey)) {
    strKey = "targetname";
  }
  if(!isDefined(ent)) {
    ent = get_players()[0];
  }
  eTrigger = getEnt(strName, strKey);
  if(!isDefined(eTrigger)) {
    assertmsg("trigger not found: " + strName + " key: " + strKey);
    return;
  }
  eTrigger UseBy(ent);
  level notify(strName, ent);
  return eTrigger;
}

set_flag_on_notify(notifyStr, strFlag) {
  if(!level.flag[strFlag]) {
    self waittill(notifyStr);
    flag_set(strFlag);
  }
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
  trigger = getEnt(msg, "targetname");
  trigger waittill("trigger");
  flag_set(msg);
}

waittill_dead(guys, num, timeoutLength) {
  allAlive = true;
  for(i = 0; i < guys.size; i++) {
    if(isalive(guys[i])) {
      continue;
    }
    allAlive = false;
    break;
  }
  assertex(allAlive, "Waittill_Dead was called with dead or removed AI in the array, meaning it will never pass.");
  if(!allAlive) {
    newArray = [];
    for(i = 0; i < guys.size; i++) {
      if(isalive(guys[i])) {
        newArray[newArray.size] = guys[i];
      }
    }
    guys = newArray;
  }
  ent = spawnStruct();
  if(isDefined(timeoutLength)) {
    ent endon("thread_timed_out");
    ent thread waittill_dead_timeout(timeoutLength);
  }
  ent.count = guys.size;
  if(isDefined(num) && num < ent.count) {
    ent.count = num;
  }
  array_thread(guys, ::waittill_dead_thread, ent);
  while(ent.count > 0) {
    ent waittill("waittill_dead guy died");
  }
}

waittill_dead_or_dying(guys, num, timeoutLength) {
  newArray = [];
  for(i = 0; i < guys.size; i++) {
    if(isalive(guys[i]) && !guys[i].ignoreForFixedNodeSafeCheck) {
      newArray[newArray.size] = guys[i];
    }
  }
  guys = newArray;
  ent = spawnStruct();
  if(isDefined(timeoutLength)) {
    ent endon("thread_timed_out");
    ent thread waittill_dead_timeout(timeoutLength);
  }
  ent.count = guys.size;
  if(isDefined(num) && num < ent.count) {
    ent.count = num;
  }
  array_thread(guys, ::waittill_dead_or_dying_thread, ent);
  while(ent.count > 0) {
    ent waittill("waittill_dead_guy_dead_or_dying");
  }
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

set_ai_group_cleared_count(aigroup, count) {
  maps\_spawner::aigroup_init(aigroup);
  level._ai_group[aigroup].cleared_count = count;
}

waittill_ai_group_cleared(aigroup) {
  AssertEx(isDefined(level._ai_group[aigroup]), "The aigroup " + aigroup + " does not exist");
  flag_wait(aigroup + "_cleared");
}

waittill_ai_group_count(aigroup, count) {
  while(level._ai_group[aigroup].spawnercount + level._ai_group[aigroup].aicount > count) {
    wait(0.25);
  }
}

waittill_ai_group_ai_count(aigroup, count) {
  while(level._ai_group[aigroup].aicount > count) {
    wait(0.25);
  }
}

waittill_ai_group_spawner_count(aigroup, count) {
  while(level._ai_group[aigroup].spawnercount > count) {
    wait(0.25);
  }
}

waittill_ai_group_amount_killed(aigroup, amount_killed) {
  while(level._ai_group[aigroup].killed_count < amount_killed) {
    wait(0.25);
  }
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

get_ai(name, type) {
  array = get_ai_array(name, type);
  if(array.size > 1) {
    assertMsg("get_ai used for more than one living ai of type " + type + " called " + name + ".");
    return undefined;
  }
  return array[0];
}

get_ai_array(name, type) {
  ai = GetAIArray();
  if(!isDefined(type)) {
    type = "script_noteworthy";
  }
  array = [];
  for(i = 0; i < ai.size; i++) {
    switch (type) {
      case "targetname":
        if(isDefined(ai[i].targetname) && ai[i].targetname == name) {
          array[array.size] = ai[i];
        }
        break;
      case "script_noteworthy":
        if(isDefined(ai[i].script_noteworthy) && ai[i].script_noteworthy == name) {
          array[array.size] = ai[i];
        }
        break;
      case "classname":
        if(isDefined(ai[i].classname) && ai[i].classname == name) {
          array[array.size] = ai[i];
        }
        break;
    }
  }
  return array;
}

get_aispecies(name, type, breed) {
  array = get_ai_array(name, type, breed);
  if(array.size > 1) {
    assertMsg("get_aispecies used for more than one living ai of type " + type + " called " + name + ".");
    return undefined;
  }
  return array[0];
}

get_aispecies_array(name, type, breed) {
  if(!isDefined(breed)) {
    breed = "all";
  }
  ai = getaispeciesarray("allies", breed);
  ai = array_combine(ai, getaispeciesarray("axis", breed));
  array = [];
  for(i = 0; i < ai.size; i++) {
    switch (type) {
      case "targetname":
        if(isDefined(ai[i].targetname) && ai[i].targetname == name) {
          array[array.size] = ai[i];
        }
        break;
      case "script_noteworthy":
        if(isDefined(ai[i].script_noteworthy) && ai[i].script_noteworthy == name) {
          array[array.size] = ai[i];
        }
        break;
    }
  }
  return array;
}

set_environment(env) {
  animscripts\utility::setEnv(env);
}

getchar(num) {
  if(num == 0) {
    return "0";
  }
  if(num == 1) {
    return "1";
  }
  if(num == 2) {
    return "2";
  }
  if(num == 3) {
    return "3";
  }
  if(num == 4) {
    return "4";
  }
  if(num == 5) {
    return "5";
  }
  if(num == 6) {
    return "6";
  }
  if(num == 7) {
    return "7";
  }
  if(num == 8) {
    return "8";
  }
  if(num == 9) {
    return "9";
  }
}

waittill_either(msg1, msg2) {
  self endon(msg1);
  self waittill(msg2);
}

array_merge_links(array1, array2) {
  if(!array1.size) {
    return array2;
  }
  if(!array2.size) {
    return array1;
  }
  linkMap = [];
  for(i = 0; i < array1.size; i++) {
    node = array1[i];
    linkMap[node.script_linkname] = true;
  }
  for(i = 0; i < array2.size; i++) {
    node = array2[i];
    if(isDefined(linkMap[node.script_linkname])) {
      continue;
    }
    linkMap[node.script_linkname] = true;
    array1[array1.size] = node;
  }
  return array1;
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
  if(!isDefined(r)) {
    r = 1;
  }
  if(!isDefined(g)) {
    g = 1;
  }
  if(!isDefined(b)) {
    b = 1;
  }
  if(!isDefined(timer)) {
    timer = 0.05;
  }
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

draw_point(org, scale, color, timer) {
  timer = gettime() + (timer * 1000);
  range = 10 * scale;
  rt = (range, 0, 0);
  ot = (0, range, 0);
  up = (0, 0, range);
  v1_1 = org + rt;
  v2_1 = org + ot;
  v3_1 = org + up;
  v1_2 = org - rt;
  v2_2 = org - ot;
  v3_2 = org - up;
  while(GetTime() < timer) {
    line(v1_1, v1_2, color, 1);
    line(v2_1, v2_2, color, 1);
    line(v3_1, v3_2, color, 1);
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
  arrow[1] = start + vector_scale(right, dist * (range)) + vector_scale(forward, dist * -0.1);
  arrow[2] = end;
  arrow[3] = start + vector_scale(right, dist * (-1 * range)) + vector_scale(forward, dist * -0.1);
  arrow[4] = start;
  arrow[5] = start + vector_scale(up, dist * (range)) + vector_scale(forward, dist * -0.1);
  arrow[6] = end;
  arrow[7] = start + vector_scale(up, dist * (-1 * range)) + vector_scale(forward, dist * -0.1);
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
  arrow[1] = start + vector_scale(right, dist * (range)) + vector_scale(forward, dist * -0.2);
  arrow[2] = end;
  arrow[3] = start + vector_scale(right, dist * (-1 * range)) + vector_scale(forward, dist * -0.2);
  for(p = 0; p < 4; p++) {
    nextpoint = p + 1;
    if(nextpoint >= 4) {
      nextpoint = 0;
    }
    line(arrow[p], arrow[nextpoint], color, 1.0);
  }
}

battlechatter_off(team) {
  maps\_dds::dds_disable(team);
  return;
}

battlechatter_on(team) {
  maps\_dds::dds_enable(team);
  return;
}

dds_set_player_character_name(hero_name) {
  if(!IsPlayer(self)) {
    PrintLn("dds 'dds_set_player_character_name' function was not called on a player. No changes made.");
    return;
  }
  switch (hero_name) {
    case "mason":
    case "hudson":
    case "reznov":
      level.dds.player_character_name = GetSubStr(hero_name, 0, 3);
      PrintLn("dds setting player name to '" + level.dds.player_character_name + "'");
      break;
    default:
      printLn("dds: '" + hero_name + "' not a valid player name; setting to 'mason' (mas)");
      level.dds.player_character_name = "mas";
      break;
  }
  self.dds_characterID = level.dds.player_character_name;
}

dds_exclude_this_ai() {
  if(IsAI(self) && IsAlive(self)) {
    self.dds_characterID = undefined;
  } else {
    PrintLn("Tried to mark an entity for DDS removal that was not an AI or not alive.");
  }
}

debugorigin() {
  self notify("Debug origin");
  self endon("Debug origin");
  self endon("death");
  for(;;) {
    forward = anglesToForward(self.angles);
    forwardFar = vector_scale(forward, 30);
    forwardClose = vector_scale(forward, 20);
    right = AnglesToRight(self.angles);
    left = vector_scale(right, -10);
    right = vector_scale(right, 10);
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
      ent = getEnt(linknames[i], "script_linkname");
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
          ePathpoint = getEnt(ePathpoint.target, "targetname");
          break;
        default:
          assertmsg("sEntityType needs to be 'vehiclenode', 'pathnode' or 'ent'");
      }
    } else {
      break;
    }
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

array_removeDead_keepkeys(array) {
  newArray = [];
  keys = getarraykeys(array);
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    if(!isalive(array[key])) {
      continue;
    }
    newArray[key] = array[key];
  }
  return newArray;
}

array_removeDead(array) {
  newArray = [];
  if(!isDefined(array)) {
    return undefined;
  }
  for(i = 0; i < array.size; i++) {
    if(!isalive(array[i]) || (isDefined(array[i].isacorpse) && array[i].isacorpse)) {
      continue;
    }
    newArray[newArray.size] = array[i];
  }
  return newArray;
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
  for(i = 0; i < shuffle; i++) {
    struct structarray_swap(struct.array[i], struct.array[randomInt(struct.lastindex)]);
  }
}

custom_battlechatter(string) {
  excluders = [];
  excluders[0] = self;
  buddy = get_closest_ai_exclude(self.origin, self.team, excluders);
  if(isDefined(buddy) && Distance(buddy.origin, self.origin) > 384) {
    buddy = undefined;
  }
  self animscripts\battlechatter_ai::beginCustomEvent();
  tokens = Strtok(string, "_");
  if(!tokens.size) {
    return;
  }
  if(tokens[0] == "move") {
    if(tokens.size > 1) {
      modifier = tokens[1];
    } else {
      modifier = "generic";
    }
    self animscripts\battlechatter_ai::addGenericAliasEx("order", "move", modifier);
  } else if(tokens[0] == "infantry") {
    self animscripts\battlechatter_ai::addGenericAliasEx("threat", "infantry", tokens[1]);
    if(tokens.size > 2 && tokens[2] != "inbound") {
      self animscripts\battlechatter_ai::addGenericAliasEx("direction", "relative", tokens[2]);
    } else if(tokens.size > 2) {
      self animscripts\battlechatter_ai::addGenericAliasEx("direction", "inbound", tokens[3]);
    }
  } else if(tokens[0] == "vehicle") {
    self animscripts\battlechatter_ai::addGenericAliasEx("threat", "vehicle", tokens[1]);
    if(tokens.size > 2 && tokens[2] != "inbound") {
      self animscripts\battlechatter_ai::addGenericAliasEx("direction", "relative", tokens[2]);
    } else if(tokens.size > 2) {
      self animscripts\battlechatter_ai::addGenericAliasEx("direction", "inbound", tokens[3]);
    }
  }
  self animscripts\battlechatter_ai::endCustomEvent(2000);
}

buildbcalias(action, type, modifier) {
  if(isDefined(modifier)) {
    return (self.countryID + "_" + self.npcID + "_" + action + "_" + type + "_" + modifier);
  } else {
    return (self.countryID + "_" + self.npcID + "_" + action + "_" + type);
  }
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
  if(isDefined(othertime)) {
    timer = othertime;
  } else {
    timer = level.explosiveplanttime;
  }
  watch setClock(timer, time, "hudStopwatch", 64, 64);
  return watch;
}

missionfailedwrapper(fail_hint, shader, iWidth, iHeight, fDelay, x, y) {
  if(level.missionfailed) {
    return;
  }
  if(isDefined(level.nextmission)) {
    return;
  }
  if(getDvar(#"failure_disabled") == "1") {
    return;
  }
  screen_message_delete();
  if(isDefined(fail_hint)) {
    SetDvar("ui_deadquote", fail_hint);
  }
  if(isDefined(shader)) {
    get_players()[0] thread maps\_load_common::special_death_indicator_hudelement(shader, iWidth, iHeight, fDelay, x, y);
  }
  level.missionfailed = true;
  flag_set("missionfailed");
  MissionFailed();
}

nextmission() {
  maps\_endmission::_nextmission();
}

prefetchnext() {
  maps\_endmission::prefetch_next();
}

script_delay() {
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
    return true;
  } else if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
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
    if(isDefined(self.script_wait_add)) {
      self.script_wait += self.script_wait_add;
    }
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    wait(RandomFloatrange(self.script_wait_min, self.script_wait_max) * coop_scalar);
    if(isDefined(self.script_wait_add)) {
      self.script_wait_min += self.script_wait_add;
      self.script_wait_max += self.script_wait_add;
    }
  }
  return (GetTime() - startTime);
}

enter_vehicle(vehicle, tag) {
  self maps\_vehicle_aianim::vehicle_enter(vehicle, tag);
}

guy_array_enter_vehicle(guy, vehicle) {
  maps\_vehicle_aianim::guy_array_enter(guy, vehicle);
}

run_to_vehicle_load(vehicle, bGodDriver, seat_tag) {
  self maps\_vehicle_aianim::run_to_vehicle(vehicle, bGodDriver, seat_tag);
}

vehicle_unload(delay) {
  self maps\_vehicle::do_unload(delay);
}

vehicle_override_anim(action, tag, animation) {
  self maps\_vehicle_aianim::override_anim(action, tag, animation);
}

set_wait_for_players(seat_tag, player_array) {
  vehicleanim = level.vehicle_aianims[self.vehicletype];
  for(i = 0; i < vehicleanim.size; i++) {
    if(vehicleanim[i].sittag == seat_tag) {
      vehicleanim[i].wait_for_player = [];
      for(j = 0; j < player_array.size; j++) {
        vehicleanim[i].wait_for_player[j] = player_array[j];
      }
      break;
    }
  }
}

set_wait_for_notify(seat_tag, custom_notify) {
  vehicleanim = level.vehicle_aianims[self.vehicletype];
  for(i = 0; i < vehicleanim.size; i++) {
    if(vehicleanim[i].sittag == seat_tag) {
      vehicleanim[i].wait_for_notify = custom_notify;
      break;
    }
  }
}

is_on_vehicle(vehicle) {
  if(!isDefined(self.viewlockedentity)) {
    return false;
  } else if(self.viewlockedentity == vehicle) {
    return true;
  }
  if(!isDefined(self.groundentity)) {
    return false;
  } else if(self.groundentity == vehicle) {
    return true;
  }
  return false;
}

get_force_color_guys(team, color) {
  ai = GetAiArray(team);
  guys = [];
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!isDefined(guy.script_forceColor)) {
      continue;
    }
    if(guy.script_forceColor != color) {
      continue;
    }
    guys[guys.size] = guy;
  }
  return guys;
}

get_all_force_color_friendlies() {
  ai = GetAiArray("allies");
  guys = [];
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!isDefined(guy.script_forceColor)) {
      continue;
    }
    guys[guys.size] = guy;
  }
  return guys;
}

enable_ai_color() {
  if(isDefined(self.script_forceColor)) {
    return;
  }
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
}

clear_force_color() {
  disable_ai_color();
}

check_force_color(_color) {
  color = level.colorCheckList[tolower(_color)];
  if(isDefined(self.script_forcecolor) && color == self.script_forcecolor) {
    return true;
  } else {
    return false;
  }
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
    if(issubstr(colorCodes[i], "r")) {
      color = "r";
    } else if(issubstr(colorCodes[i], "b")) {
      color = "b";
    } else if(issubstr(colorCodes[i], "y")) {
      color = "y";
    } else if(issubstr(colorCodes[i], "c")) {
      color = "c";
    } else if(issubstr(colorCodes[i], "g")) {
      color = "g";
    } else if(issubstr(colorCodes[i], "p")) {
      color = "p";
    } else if(issubstr(colorCodes[i], "o")) {
      color = "o";
    } else {
      assertEx(0, "Trigger at origin " + self getorigin() + " had strange color index " + colorCodes[i]);
    }
    colorCodesByColorIndex[color] = colorCodes[i];
    colors[colors.size] = color;
  }
  assert(colors.size == colorCodes.size);
  for(i = 0; i < colorCodes.size; i++) {
    level.arrays_of_colorCoded_spawners[team][colorCodes[i]] = array_removeUndefined(level.arrays_of_colorCoded_spawners[team][colorCodes[i]]);
    assertex(isDefined(level.arrays_of_colorCoded_spawners[team][colorCodes[i]]), "Trigger refer to a color# that does not exist in any node for this team.");
    for(p = 0; p < level.arrays_of_colorCoded_spawners[team][colorCodes[i]].size; p++) {
      level.arrays_of_colorCoded_spawners[team][colorCodes[i]][p].currentColorCode = colorCodes[i];
    }
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

disable_replace_on_death() {
  self.replace_on_death = undefined;
  self notify("_disable_reinforcement");
}

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

getvehiclespawner(targetname) {
  spawner = getEnt(targetname + "_vehiclespawner", "targetname");
  return spawner;
}

getvehiclespawnerarray(targetname) {
  spawner = getEntArray(targetname + "_vehiclespawner", "targetname");
  return spawner;
}

player_fudge_moveTo(dest, moverate) {
  if(!isDefined(moverate)) {
    moverate = 200;
  }
  org = spawn("script_origin", self.origin);
  org.angles = self.angles;
  self LinkTo(org);
  dist = Distance(self.origin, dest);
  movetime = dist / moverate;
  org moveTo(dest, dist / moverate, .05, .05);
  wait(movetime);
  self UnLink();
  org Delete();
}

add_start(msg, func, loc_string) {
  assertex(!isDefined(level._loadStarted), "Can't create starts after _load");
  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
  }
  msg = tolower(msg);
  level.start_functions[msg] = func;
  if(isDefined(loc_string)) {
    precachestring(loc_string);
    level.start_loc_string[msg] = loc_string;
  } else {
    level.start_loc_string[msg] = &"MISSING_LOC_STRING";
  }
}

default_start(func, bSplash) {
  level.default_start = func;
}

start_teleport_players(start_name, coop_sort) {
  players = get_players();
  if(isDefined(coop_sort) && coop_sort) {
    starts = get_sorted_starts(start_name);
  } else {
    starts = getstructarray(start_name, "targetname");
  }
  assertex(starts.size >= players.size, "Need more start positions for players!");
  for(i = 0; i < players.size; i++) {
    players[i] setOrigin(starts[i].origin);
    if(isDefined(starts[i].angles)) {
      players[i] setPlayerAngles(starts[i].angles);
    }
  }
  set_breadcrumbs(starts);
}

get_sorted_starts(start_name) {
  player_starts = getstructarray(start_name, "targetname");
  for(i = 0; i < player_starts.size; i++) {
    for(j = i; j < player_starts.size; j++) {
      assertex(isDefined(player_starts[j].script_int), "start at: " + player_starts[j].origin + " must have a script_int set for coop spawning");
      assertex(isDefined(player_starts[i].script_int), "start at: " + player_starts[i].origin + " must have a script_int set for coop spawning");
      if(player_starts[j].script_int < player_starts[i].script_int) {
        temp = player_starts[i];
        player_starts[i] = player_starts[j];
        player_starts[j] = temp;
      }
    }
  }
  return player_starts;
}

start_teleport_ai(start_name, ai_names) {
  friendly_ai = get_ai_array(ai_names, "script_noteworthy");
  ai_starts = getstructarray(start_name + "_ai", "targetname");
  assertex(ai_starts.size >= friendly_ai.size, "Need more start positions for ai!");
  for(i = 0; i < friendly_ai.size; i++) {
    start_i = 0;
    if(isDefined(friendly_ai[i].script_int)) {
      for(j = 0; j < ai_starts.size; j++) {
        if(isDefined(ai_starts[j].script_int)) {
          if(ai_starts[j].script_int == friendly_ai[i].script_int) {
            start_i = j;
            break;
          }
        }
      }
    }
    friendly_ai[i] start_teleport_single_ai(ai_starts[start_i]);
    ai_starts = array_remove(ai_starts, ai_starts[start_i]);
  }
}

start_teleport_single_ai(ai_start) {
  if(isDefined(ai_start.angles)) {
    self forceteleport(ai_start.origin, ai_start.angles);
  } else {
    self forceteleport(ai_start.origin);
  }
  if(isDefined(ai_start.target)) {
    node = GetNode(ai_start.target, "targetname");
    if(isDefined(node)) {
      self SetGoalNode(node);
      return;
    }
  }
  self SetGoalPos(ai_start.origin);
}

start_teleport(start_name, ai_names, coop_sort) {
  if(isDefined(ai_names)) {
    start_teleport_ai(start_name, ai_names);
  }
  start_teleport_players(start_name, coop_sort);
}

within_fov(start_origin, start_angles, end_origin, fov) {
  normal = VectorNormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = VectorDot(forward, normal);
  return dot >= fov;
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

hint_position_internal(bgAlpha) {
  if(level.console) {
    self.elm.fontScale = 2;
  } else {
    self.elm.fontScale = 1.6;
  }
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
  if(level.console) {
    self.bg SetShader("popmenu_bg", 650, 52);
  } else {
    self.bg SetShader("popmenu_bg", 650, 42);
  }
  if(!isDefined(bgAlpha)) {
    bgAlpha = 0.5;
  }
  self.bg.alpha = bgAlpha;
}

string(num) {
  return ("" + num);
}

clear_threatbias(group1, group2) {
  SetThreatBias(group1, group2, 0);
  SetThreatBias(group2, group1, 0);
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
  AssertEx(!isDefined(level._loadStarted) || !IsAlive(self), "Tried to add_spawn_function to a living guy.");
  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  if(!isDefined(self.spawn_funcs)) {
    self.spawn_funcs = [];
  }
  self.spawn_funcs[self.spawn_funcs.size] = func;
}

add_spawn_function_veh(veh_targetname, function, param1, param2, param3, param4) {
  assertEx(isDefined(level.vehicleSpawners), "Tried to add_spawn_function_veh before vehicle spawners were inited");
  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  func_count_added = 0;
  for(i = 0; func_count_added < level.vehicleSpawners.size; i++) {
    if(!isDefined(level.vehicleSpawners[i])) {
      continue;
    } else {
      for(j = 0; j < level.vehicleSpawners[i].size; j++) {
        if(isDefined(level.vehicleSpawners[i][j].targetname) && level.vehicleSpawners[i][j].targetname == veh_targetname + "_vehiclespawner") {
          if(!isDefined(level.vehicleSpawners[i][j].spawn_funcs)) {
            level.vehicleSpawners[i][j].spawn_funcs = [];
          }
          level.vehicleSpawners[i][j].spawn_funcs[level.vehicleSpawners[i][j].spawn_funcs.size] = func;
        }
      }
      func_count_added++;
    }
  }
}

add_spawn_function_veh_by_type(veh_type, function, param1, param2, param3, param4) {
  assertEx(isDefined(level.vehicleSpawners), "Tried to add_spawn_function_veh_by_type before vehicle spawners were inited");
  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  func_count_added = 0;
  for(i = 0; func_count_added < level.vehicleSpawners.size; i++) {
    if(!isDefined(level.vehicleSpawners[i])) {
      continue;
    } else {
      for(j = 0; j < level.vehicleSpawners[i].size; j++) {
        if(isDefined(level.vehicleSpawners[i][j].vehicletype) && level.vehicleSpawners[i][j].vehicletype == veh_type) {
          if(!isDefined(level.vehicleSpawners[i][j].spawn_funcs)) {
            level.vehicleSpawners[i][j].spawn_funcs = [];
          }
          level.vehicleSpawners[i][j].spawn_funcs[level.vehicleSpawners[i][j].spawn_funcs.size] = func;
        }
      }
      func_count_added++;
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
  trigger = getEnt(msg, "targetname");
  trigger activate_trigger();
}

activate_trigger_with_noteworthy(msg) {
  trigger = getEnt(msg, "script_noteworthy");
  trigger activate_trigger();
}

disable_trigger_with_targetname(msg) {
  trigger = getEnt(msg, "targetname");
  trigger trigger_off();
}

disable_trigger_with_noteworthy(msg) {
  trigger = getEnt(msg, "script_noteworthy");
  trigger trigger_off();
}

enable_trigger_with_targetname(msg) {
  trigger = getEnt(msg, "targetname");
  trigger trigger_on();
}

enable_trigger_with_noteworthy(msg) {
  trigger = getEnt(msg, "script_noteworthy");
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
  self magic_bullet_shield();
  level.hero_list[self.ai_number] = self;
  self.ikpriority = 5;
  self thread unmake_hero_on_death();
}

unmake_hero_on_death() {
  self waittill("death");
  level.hero_list[self.ai_number] = undefined;
}

unmake_hero() {
  self thread stop_magic_bullet_shield();
  level.hero_list[self.ai_number] = undefined;
  self.ikpriority = 0;
}

get_heroes() {
  return level.hero_list;
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
  if(!isDefined(level.current_color_order[replacer])) {
    set_empty_promotion_order(replacer);
  }
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
    if(!isalive(array[i])) {
      continue;
    }
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

remove_heroes_from_array(array) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    if(array[i] is_hero()) {
      continue;
    }
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

remove_all_animnamed_guys_from_array(array) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    if(isDefined(array[i].animname)) {
      continue;
    }
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

remove_color_from_array(array, color) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    guy = array[i];
    if(!isDefined(guy.script_forceColor)) {
      continue;
    }
    if(guy.script_forceColor == color) {
      continue;
    }
    newarray[newarray.size] = guy;
  }
  return newarray;
}

remove_noteworthy_from_array(array, noteworthy) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    guy = array[i];
    if(isDefined(guy.script_noteworthy) && guy.script_noteworthy == noteworthy) {
      continue;
    }
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
    if(!issubstr(array[i].classname, classname)) {
      continue;
    }
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

remove_without_model(array, model) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    if(!issubstr(array[i].model, model)) {
      continue;
    }
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

make_real_ai(drone) {
  return maps\_spawner::spawner_make_real_ai(drone);
}

get_trigger_flag(flag_name_override) {
  if(isDefined(flag_name_override)) {
    return flag_name_override;
  }
  if(isDefined(self.script_flag)) {
    return self.script_flag;
  }
  if(isDefined(self.script_noteworthy)) {
    return self.script_noteworthy;
  }
  assertex(0, "Flag trigger at " + self.origin + " has no script_flag set.");
}

is_spawner() {
  return (is_true(self.is_spawner));
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

enable_heat() {
  self thread call_overloaded_func("animscripts\anims_table", "setup_heat_anim_array");
}

disable_heat() {
  self thread call_overloaded_func("animscripts\anims_table", "reset_heat_anim_array");
}

enable_cqbwalk() {
  self.cqbwalking = true;
  level thread call_overloaded_func("animscripts\cqb", "findCQBPointsOfInterest");
  self thread call_overloaded_func("animscripts\anims_table", "setup_cqb_anim_array");
}

disable_cqbwalk() {
  if(!isDefined(self) && (!IsAlive(self))) {
    return;
  }
  self.cqbwalking = false;
  self.sprint = false;
  self.cqb_point_of_interest = undefined;
  self thread call_overloaded_func("animscripts\anims_table", "reset_cqb_anim_array");
}

enable_cqbsprint() {
  if(!(self animscripts\utility::isCQBWalking()))
    self enable_cqbwalk();
  self.sprint = true;
}

disable_cqbsprint() {
  self.sprint = false;
}

cqb_aim(the_target) {
  if(!isDefined(the_target)) {
    self.cqb_target = undefined;
  } else {
    self.cqb_target = the_target;
    if(!isDefined(the_target.origin)) {
      assertmsg("target passed into cqb_aim does not have an origin!");
    }
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

waittill_any_or_timeout(timer, string1, string2, string3, string4, string5) {
  assert(isDefined(string1));
  self endon(string1);
  if(isDefined(string2)) {
    self endon(string2);
  }
  if(isDefined(string3)) {
    self endon(string3);
  }
  if(isDefined(string4)) {
    self endon(string4);
  }
  if(isDefined(string5)) {
    self endon(string5);
  }
  wait(timer);
}

scrub_guy() {
  self SetThreatBiasGroup(self.team);
  self.script_accuracy = 1;
  self.perfectAim = false;
  set_default_pathenemy_settings();
  maps\_gameskill::grenadeAwareness();
  self clear_force_color();
  maps\_spawner::set_default_covering_fire();
  self.interval = 96;
  self.disableArrivals = undefined;
  self.ignoreme = false;
  self.threatbias = 0;
  self.pacifist = false;
  self.pacifistWait = 20;
  self.IgnoreRandomBulletDamage = false;
  self.playerPushable = true;
  self.precombatrunEnabled = true;
  self.accuracystationarymod = 1;
  self.allowdeath = false;
  self.anglelerprate = 540;
  self.badplaceawareness = 0.75;
  self.chainfallback = 0;
  self.dontavoidplayer = 0;
  self.drawoncompass = 1;
  self.activatecrosshair = true;
  self.dropweapon = 1;
  self.goalradius = level.default_goalradius;
  self.goalheight = level.default_goalheight;
  self.ignoresuppression = 0;
  self PushPlayer(false);
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    stop_magic_bullet_shield();
  }
  self disable_replace_on_death();
  self.maxsightdistsqrd = 8192 * 8192;
  if(WeaponClass(self.weapon) == "gas") {
    self.maxSightDistSqrd = 1024 * 1024;
  }
  self.script_forceGrenade = 0;
  self.walkdist = 16;
  self unmake_hero();
  self.pushable = true;
  call_overloaded_func("animscripts\init", "set_anim_playback_rate");
  self.fixednode = self.team == "allies";
  if(isDefined(self.script_grenades)) {
    self.grenadeAmmo = self.script_grenades;
  } else {
    self.grenadeAmmo = 3;
  }
}

send_notify(msg) {
  self notify(msg);
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

ThrowGrenadeAtPlayerASAP() {
  players = get_players();
  if(players.size > 0) {
    best_target = undefined;
    closest_dist = 99999999;
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i])) {
        dist = distanceSquared(self.origin, players[i].origin);
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

is_ai_in_revive() {
  assertEX(IsAI(self), "Can only call this function on an AI character");
  if(IsAlive(self)) {
    return animscripts\revive::isReviverOrBleeder();
  }
}

disable_ai_revive() {
  Assert(isDefined(level.reviveFeature), "level.reviveFeature is not defined, call this function after maps\_load::main().");
  level.reviveFeature = false;
}

enable_ai_revive() {
  Assert(isDefined(level.reviveFeature), "level.reviveFeature is not defined, call this function after maps\_load::main().");
  Assert((level.reviveFeature == false), "Revive Feature is already enabled.");
  level.reviveFeature = true;
}

disable_ai_bleeder() {
  assertEX(IsAI(self), "Can only call this function on an AI character");
  assertEX(isDefined(self.a.canBleed), "Can only call this function on an AI character");
  self.a.canBleed = false;
}

enable_ai_bleeder() {
  assertEX(IsAI(self), "Can only call this function on an AI character");
  assertEX(isDefined(self.a.canBleed), "Can only call this function on an AI character");
  self.a.canBleed = true;
}

disable_ai_reviver() {
  assertEX(IsAI(self), "Can only call this function on an AI character");
  assertEX(isDefined(self.a.canRevive), "Can only call this function on an AI character");
  self.a.canRevive = false;
}

enable_ai_reviver() {
  assertEX(IsAI(self), "Can only call this function on an AI character");
  assertEX(isDefined(self.a.canRevive), "Can only call this function on an AI character");
  self.a.canRevive = true;
}

switch_weapon_ASAP() {
  assertEX(IsAI(self), "Can only call this function on an AI character");
  if(IsAlive(self) && !self.a.weapon_switch_ASAP)
    self.a.weapon_switch_ASAP = true;
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
  if(!isDefined(animtree)) {
    animtree = "generic_human";
  }
  sg_csv_addtype("xanim", animation);
  if(!isDefined(level.sg_precacheanims)) {
    level.sg_precacheanims = [];
  }
  if(!isDefined(level.sg_precacheanims[animtree])) {
    level.sg_precacheanims[animtree] = [];
  }
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
  sg_csv_addtype("col_map_sp", "maps/" + tolower(getDvar(#"mapname")) + ".d3dbsp");
  sg_csv_addtype("gfx_map", "maps/" + tolower(getDvar(#"mapname")) + ".d3dbsp");
  sg_csv_addtype("rawfile", "maps/" + tolower(getDvar(#"mapname")) + ".gsc");
  sg_csv_addtype("rawfile", "maps / scriptgen/" + tolower(getDvar(#"mapname")) + "_scriptgen.gsc");
  sg_csv_soundadd("us_battlechatter", "all_sp");
  sg_csv_soundadd("ab_battlechatter", "all_sp");
  sg_csv_soundadd("voiceovers", "all_sp");
  sg_csv_soundadd("common", "all_sp");
  sg_csv_soundadd("generic", "all_sp");
  sg_csv_soundadd("requests", "all_sp");
}

sg_csv_soundadd(type, loadspec) {
  script_gen_dump_addline("nowrite Sound CSV entry: " + type, "sound_" + type + ", " + tolower(getDvar(#"mapname")) + ", " + loadspec);
}

sg_csv_addtype(type, string) {
  script_gen_dump_addline("nowrite CSV entry: " + type + ", " + string, type + "_" + string);
}

array_combine_keys(array1, array2) {
  if(!array1.size) {
    return array2;
  }
  keys = getarraykeys(array2);
  for(i = 0; i < keys.size; i++) {
    array1[keys[i]] = array2[keys[i]];
  }
  return array1;
}

set_ignoreSuppression(val) {
  self.ignoreSuppression = val;
}

set_goalradius(radius) {
  self.goalradius = radius;
}

set_allowdeath(val) {
  self.allowdeath = val;
}

set_run_anim(anime, alwaysRunForward) {
  assertEx(isDefined(anime), "Tried to set run anim but didn't specify which animation to ues");
  assertEx(isDefined(self.animname), "Tried to set run anim on a guy that had no anim name");
  assertEx(isDefined(level.scr_anim[self.animname][anime]), "Tried to set run anim but the anim was not defined in the maps _anim file");
  if(isDefined(alwaysRunForward)) {
    self.alwaysRunForward = alwaysRunForward;
  } else {
    self.alwaysRunForward = true;
  }
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
    if(alwaysRunForward) {
      self.alwaysRunForward = alwaysRunForward;
    } else {
      self.alwaysRunForward = undefined;
    }
  } else {
    self.alwaysRunForward = true;
  }
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
        force = vector_scale(base_force, scale);
      }
    }
    dist = distancesquared(self.origin, get_players()[0].origin);
    scale = fade_distance / dist;
    if(scale > 1) {
      scale = 1;
    }
    force = vector_scale(force, scale);
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
}

self_delete() {
  if(isDefined(self)) {
    self delete();
  }
}

remove_noColor_from_array(ai) {
  newarray = [];
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(guy has_color()) {
      newarray[newarray.size] = guy;
    }
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
  self endon("death");
  if(fDelay > 0) {
    wait fDelay;
  }
  if(!isDefined(self)) {
    return;
  }
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

custom_ai_weapon_loadout(primary, secondary, sidearm) {
  self animscripts\shared::detachAllWeaponModels();
  if(isDefined(self.primaryweapon) && self.primaryweapon != "") {
    self animscripts\shared::detachWeapon(self.primaryweapon);
  }
  if(isDefined(self.secondaryweapon) && self.secondaryweapon != "") {
    self animscripts\shared::detachWeapon(self.secondaryweapon);
  }
  if(isDefined(self.sideArm) && self.sideArm != "") {
    self animscripts\shared::detachWeapon(self.sideArm);
  }
  self.primaryweapon = "";
  self.secondaryweapon = "";
  self.sidearm = "";
  if(isDefined(primary)) {
    if(GetWeaponModel(primary) != "") {
      self.primaryweapon = primary;
      self call_overloaded_func("animscripts\init", "initWeapon", self.primaryweapon);
      self animscripts\shared::placeWeaponOn(self.primaryweapon, "right");
    } else {
      assertex(false, "custom_ai_weapon_loadout: primary weapon " + primary + " is not in a csv or isn't precached");
    }
  }
  if(isDefined(secondary)) {
    if(GetWeaponModel(secondary) != "") {
      self.secondaryweapon = secondary;
      self call_overloaded_func("animscripts\init", "initWeapon", self.secondaryweapon);
      self animscripts\shared::placeWeaponOn(self.secondaryweapon, "back");
    } else {
      assertex(false, "custom_ai_weapon_loadout: secondary weapon " + secondary + " is not in a csv or isn't precached");
    }
  }
  if(isDefined(sidearm)) {
    if(GetWeaponModel(sidearm) != "") {
      self.sidearm = sidearm;
      self call_overloaded_func("animscripts\init", "initWeapon", self.sidearm);
    } else {
      assertex(false, "custom_ai_weapon_loadout: sidearm weapon " + sidearm + " is not in a csv or isn't precached");
    }
  }
  self.weapon = self.primaryweapon;
  self animscripts\weaponList::RefillClip();
  self.isSniper = animscripts\combat_utility::isSniperRifle(self.weapon);
}

lerp_player_view_to_tag(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc) {
  if(IsPlayer(self)) {
    self endon("disconnect");
  }
  lerp_player_view_to_tag_internal(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, undefined);
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
  linker moveTo(origin, lerptime, lerptime * 0.25);
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
  linker.angles = self getplayerangles();
  if(isDefined(hit_geo)) {
    self playerlinktodelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);
  } else if(isDefined(right_arc)) {
    self playerlinktodelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc);
  } else if(isDefined(fraction)) {
    self playerlinktodelta(linker, "", fraction);
  } else {
    self playerlinktodelta(linker);
  }
  linker moveTo(origin, lerptime, lerptime * 0.25);
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
  } else if(isDefined(right_arc)) {
    self playerlinktodelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc);
  } else if(isDefined(fraction)) {
    self playerlinktodelta(linker, "", fraction);
  } else {
    self playerlinktodelta(linker);
  }
  max_count = lerptime / 0.0167;
  count = 0;
  while(count < max_count) {
    origin = ent gettagorigin(tag);
    angles = ent gettagangles(tag);
    linker moveTo(origin, 0.0167 * (max_count - count));
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
  if(getDvar(#"chaplincheat") == "1") {
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

set_fixednode_true() {
  self.fixednode = true;
}

set_fixednode_false() {
  self.fixednode = true;
}

spawn_ai() {
  ai = undefined;
  if(isDefined(self.lastSpawnTime) && self.lastSpawnTime >= GetTime()) {
    wait(0.05);
  }
  no_enemy_info = is_true(self.script_noenemyinfo);
  if(isDefined(self.script_forcespawn)) {
    ai = self Stalingradspawn(no_enemy_info);
  } else {
    ai = self Dospawn(no_enemy_info);
  }
  if(isDefined(ai)) {
    self.lastSpawnTime = GetTime();
  }
  return ai;
}

kill_spawnernum(number) {
  spawners = GetSpawnerArray();
  for(i = 0; i < spawners.size; i++) {
    if(!isDefined(spawners[i].script_killspawner)) {
      continue;
    }
    if(number != spawners[i].script_killspawner) {
      continue;
    }
    spawners[i] Delete();
  }
}

function_stack(func, param1, param2, param3, param4) {
  self endon("death");
  localentity = spawnStruct();
  localentity thread function_stack_proc(self, func, param1, param2, param3, param4);
  localentity waittill_either("function_done", "death");
}

set_goal_node(node) {
  self.last_set_goalnode = node;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self SetGoalNode(node);
}

set_goal_pos(origin) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = origin;
  self.last_set_goalent = undefined;
  self SetGoalPos(origin);
}

set_goal_ent(target) {
  set_goal_pos(target.origin);
  self.last_set_goalent = target;
}

run_thread_on_targetname(msg, func, param1, param2, param3) {
  array = getEntArray(msg, "targetname");
  array_thread(array, func, param1, param2, param3);
}

run_thread_on_noteworthy(msg, func, param1, param2, param3) {
  array = getEntArray(msg, "script_noteworthy");
  array_thread(array, func, param1, param2, param3);
}

handsignal(action, end_on, wait_till) {
  if(isDefined(end_on)) {
    level endon(end_on);
  }
  if(isDefined(wait_till)) {
    level waittill(wait_till);
  }
  switch (action) {
    case "go":
      self maps\_anim::anim_generic(self, "signal_go");
      break;
    case "onme":
      self maps\_anim::anim_generic(self, "signal_onme");
      break;
    case "stop":
      self maps\_anim::anim_generic(self, "signal_stop");
      break;
    case "moveup":
      self maps\_anim::anim_generic(self, "signal_moveup");
      break;
    case "moveout":
      self maps\_anim::anim_generic(self, "signal_moveout");
      break;
  }
}

add_dialogue_line(name, msg, blocking) {}
add_dialogue_line_internal(name, msg) {
  if(GetDvarInt(#"loc_warnings")) {
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
  if(array.size <= 1) {
    return array;
  }
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
    if(!changed) {
      return array;
    }
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
  player_eye_fake = tagorigin + vector_scale(upvec, height);
  diff_vec = player_eye - player_eye_fake;
  fake_origin = tagorigin + diff_vec;
  return fake_origin;
}

set_console_status() {
  if(!isDefined(level.Console)) {
    level.Console = getDvar(#"consoleGame") == "true";
  } else {
    assertex(level.Console == (getDvar(#"consoleGame") == "true"), "Level.console got set incorrectly.");
  }
  if(!isDefined(level.Consolexenon)) {
    level.xenon = getDvar(#"xenonGame") == "true";
  } else {
    assertex(level.xenon == (getDvar(#"xenonGame") == "true"), "Level.xenon got set incorrectly.");
  }
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

lerp_fov_overtime(time, destfov, use_camera_tween) {
  level endon("stop_lerping_thread");
  if(!isDefined(use_camera_tween)) {
    basefov = GetDvarFloat(#"cg_fov");
    incs = int(time / .05);
    incfov = (destfov - basefov) / incs;
    currentfov = basefov;
    if(incfov == 0) {
      return;
    }
    for(i = 0; i < incs; i++) {
      currentfov += incfov;
      self setClientDvar("cg_fov", currentfov);
      wait .05;
    }
    self setClientDvar("cg_fov", destfov);
  } else {
    self StartCameraTween(time);
    self setClientDvar("cg_fov", destfov);
  }
}

apply_fog() {
  maps\_load_common::set_fog_progress(0);
}

apply_end_fog() {
  maps\_load_common::set_fog_progress(1);
}

anim_stopanimscripted(blend_time) {
  anim_ent = get_anim_ent();
  anim_ent StopAnimScripted(blend_time);
  anim_ent notify("single anim", "end");
  anim_ent notify("looping anim", "end");
  if(isDefined(anim_ent.anim_loop_ender)) {
    anim_ent notify(anim_ent.anim_loop_ender);
  }
  anim_ent notify("_anim_stopped");
}

get_anim_ent() {
  if(isDefined(self.anim_link)) {
    self.anim_link.animname = self.animname;
    return self.anim_link;
  }
  return self;
}

enable_additive_pain(enable_regular_pain_on_low_health) {
  AssertEx(IsAI(self), "Enable_additive_pain should be called on AI only.");
  self thread call_overloaded_func("animscripts\pain", "additive_pain_think", enable_regular_pain_on_low_health);
}

disable_pain() {
  assertex(isalive(self), "Tried to disable pain on a non ai");
  self.a.disablePain = true;
  self.allowPain = false;
}

enable_pain() {
  assertex(isalive(self), "Tried to enable pain on a non ai");
  self.a.disablePain = false;
  self.allowPain = true;
}

disable_react() {
  assertex(isalive(self), "Tried to disable react on a non ai");
  self.a.disableReact = true;
  self.allowReact = false;
}

enable_react() {
  assertex(isalive(self), "Tried to enable react on a non ai");
  self.a.disableReact = false;
  self.allowReact = true;
}

enable_rambo() {
  if(isDefined(level.norambo)) {
    level.norambo = undefined;
  }
}

disable_rambo() {
  level.norambo = 1;
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
  level.auto_adjust_difficulty_frac = GetDvarInt(#"autodifficulty_frac");
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

waittill_player_looking_at(origin, dot, do_trace) {
  while(!is_player_looking_at(origin, dot, do_trace)) {
    wait .05;
  }
}

is_player_looking_at(origin, dot, do_trace) {
  AssertEx(IsPlayer(self), "player_looking_at must be called on a player.");
  if(!isDefined(dot)) {
    dot = .7;
  }
  if(!isDefined(do_trace)) {
    do_trace = true;
  }
  eye = self get_eye();
  delta_vec = anglesToForward(VectorToAngles(origin - eye));
  view_vec = anglesToForward(self GetPlayerAngles());
  new_dot = VectorDot(delta_vec, view_vec);
  if(new_dot >= dot) {
    if(do_trace) {
      return BulletTracePassed(origin, eye, false, undefined);
    } else {
      return true;
    }
  }
  return false;
}

look_at(origin_or_ent, tween, force, tag, offset) {
  if(is_true(force)) {
    self FreezeControls(true);
  }
  if(isDefined(tween)) {
    self StartCameraTween(tween);
  }
  self notify("look_at_begin");
  origin = origin_or_ent;
  if(!IsVec(origin_or_ent)) {
    ent = origin_or_ent;
    if(isDefined(tag)) {
      origin = ent GetTagOrigin(tag);
    } else if(IsAI(origin_or_ent) && !isDefined(offset)) {
      origin = ent get_eye();
    } else {
      origin = ent.origin;
    }
  }
  if(isDefined(offset)) {
    origin = origin + offset;
  }
  player_org = self get_eye();
  vec_to_pt = origin - player_org;
  self SetPlayerAngles(VectorToAngles(vec_to_pt));
  wait tween;
  if(is_true(force)) {
    self FreezeControls(false);
  }
  self notify("look_at_end");
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

do_wait_any() {
  assertex(isDefined(level.wait_any_func_array), "Tried to do a do_wait without addings funcs first");
  assertex(level.wait_any_func_array.size > 0, "Tried to do a do_wait without addings funcs first");
  do_wait(level.wait_any_func_array.size - 1);
}

do_wait(count_to_reach) {
  if(!isDefined(count_to_reach)) {
    count_to_reach = 0;
  }
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
    } else if(isDefined(level._effect["water_" + self.a.movement])) {
      fx = "water_" + self.a.movement;
    }
    playFX(getfx(fx), trace["position"], trace["normal"]);
  }
}

fail_on_friendly_fire() {
  if(!isDefined(level.friendlyfire_friendly_kill_points)) {
    level.friendlyfire_friendly_kill_points = level.friendlyfire["friend_kill_points"];
  }
  level.friendlyfire["friend_kill_points"] = -60000;
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

arcademode_assignpoints(amountDvar, player) {
  if(getDvar(#"arcademode") != "1") {
    return;
  }
}

arcadeMode() {
  isArcadeMode = getDvar(#"arcademode") == "1";
  if(getDvar(#"zombiemode") == "1") {
    isArcadeMode = false;
  }
  return isArcadeMode;
}

coopGame() {
  return ((getDvar(#"systemlink") == "1") || (getDvar(#"onlinegame") == "1") || IsSplitScreen());
}

player_is_near_live_grenade() {
  grenades = getEntArray("grenade", "classname");
  for(i = 0; i < grenades.size; i++) {
    grenade = grenades[i];
    players = get_players();
    for(j = 0; j < players.size; j++) {
      if(distanceSquared(grenade.origin, players[j].origin) < 250 * 250) {
        return true;
      }
    }
  }
  return false;
}

player_died_recently() {
  return GetDvarInt(#"player_died_recently") > 0;
}

set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist) {
  if(!IsSplitScreen()) {
    return;
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
  SplitViewAllowed(player getEntityNumber(), toggle, time);
}

get_players(t) {
  if(isDefined(t)) {
    return (GetPlayers(t));
  } else {
    return (GetPlayers());
  }
}

get_host() {
  players = get_players("all");
  for(i = 0; i < players.size; i++) {
    if(players[i] getEntityNumber() == 0) {
      return players[i];
    }
  }
}

is_coop() {
  players = get_players("all");
  if(players.size > 1) {
    return true;
  }
  return false;
}

any_player_IsTouching(ent, t) {
  players = [];
  if(isDefined(t)) {
    players = get_players(t);
  } else {
    players = get_players();
  }
  for(i = 0; i < players.size; i++) {
    if(IsAlive(players[i]) && players[i] IsTouching(ent)) {
      return true;
    }
  }
  return false;
}

get_player_touching(ent, t) {
  players = [];
  if(isDefined(t)) {
    players = get_players(t);
  } else {
    players = get_players();
  }
  for(i = 0; i < players.size; i++) {
    if(IsAlive(players[i]) && players[i] IsTouching(ent)) {
      return players[i];
    }
  }
  return undefined;
}

get_closest_player(org, t) {
  players = [];
  if(isDefined(t)) {
    players = get_players(t);
  } else {
    players = get_players();
  }
  return GetClosest(org, players);
}

clear_player_spawnpoints() {
  level.player_spawnpoints = [];
}

freezecontrols_all(toggle, delay) {
  if(isDefined(delay)) {
    wait(delay);
  }
  players = get_players("all");
  for(i = 0; i < players.size; i++) {
    players[i] FreezeControls(toggle);
  }
}

set_all_players_blur(amount, time) {
  wait_for_first_player();
  flag_wait("all_players_connected");
  players = get_players("all");
  for(i = 0; i < players.size; i++) {
    players[i] SetBlur(amount, time);
  }
}

set_all_players_double_vision(amount, time) {
  wait_for_first_player();
  flag_wait("all_players_connected");
  players = get_players("all");
  for(i = 0; i < players.size; i++) {
    players[i] SetDoubleVision(amount, time);
  }
}

set_all_players_shock(shellshock_file, time) {
  wait_for_first_player();
  flag_wait("all_players_connected");
  players = get_players("all");
  for(i = 0; i < players.size; i++) {
    players[i] Shellshock(shellshock_file, time);
  }
}

set_all_players_visionset(vision_file, time) {
  wait_for_first_player();
  flag_wait("all_players_connected");
  players = get_players("all");
  for(i = 0; i < players.size; i++) {
    players[i] visionSetNaked(vision_file, time);
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
}

player_flag_set_delayed(message, delay) {
  wait(delay);
  player_flag_set(message);
}

player_flag_set(message) {
  self.flag[message] = true;
  self notify(message);
}

player_flag_clear(message) {
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
  players = get_players("all");
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

get_ai_touching_volume(team, volume_name, volume) {
  if(!isDefined(volume)) {
    volume = getEnt(volume_name, "targetname");
    assertEx(isDefined(volume), volume_name + " does not exist");
  }
  guys = getaiarray(team);
  guys_touching_volume = [];
  for(i = 0; i < guys.size; i++) {
    if(guys[i] isTouching(volume)) {
      guys_touching_volume[guys_touching_volume.size] = guys[i];
    }
  }
  return guys_touching_volume;
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
  }
}

wait_network_frame() {
  if(NumRemoteClients()) {
    snapshot_ids = getsnapshotindexarray();
    acked = undefined;
    while(!isDefined(acked)) {
      level waittill("snapacknowledged");
      acked = snapshotacknowledged(snapshot_ids);
    }
  } else {
    wait(0.1);
  }
}

clientNotify(event) {
  if(level.clientscripts) {
    if(IsPlayer(self)) {
      maps\_utility::setClientSysState("levelNotify", event, self);
    } else {
      maps\_utility::setClientSysState("levelNotify", event);
    }
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
  if(!isDefined(level._player_breadcrumbs)) {
    maps\_callbackglobal::Player_BreadCrumb_Reset((0, 0, 0));
  }
  for(i = 0; i < starts.size; i++) {
    for(j = 0; j < starts.size; j++) {
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

simple_floodspawn(name, spawn_func, spawn_func_2) {
  spawners = getEntArray(name, "targetname");
  assertex(spawners.size, "no spawners with targetname " + name + " found!");
  if(isDefined(spawn_func)) {
    for(i = 0; i < spawners.size; i++) {
      spawners[i] add_spawn_function(spawn_func);
    }
  }
  if(isDefined(spawn_func_2)) {
    for(i = 0; i < spawners.size; i++) {
      spawners[i] add_spawn_function(spawn_func_2);
    }
  }
  for(i = 0; i < spawners.size; i++) {
    if(i % 2) {
      wait_network_frame();
    }
    spawners[i] thread maps\_spawner::flood_spawner_init();
    spawners[i] thread maps\_spawner::flood_spawner_think();
  }
}

simple_spawn(name_or_spawners, spawn_func, param1, param2, param3, param4, param5) {
  spawners = [];
  if(IsString(name_or_spawners)) {
    spawners = getEntArray(name_or_spawners, "targetname");
    AssertEx(spawners.size, "no spawners with targetname " + name_or_spawners + " found!");
  } else {
    if(IsArray(name_or_spawners)) {
      spawners = name_or_spawners;
    } else {
      spawners[0] = name_or_spawners;
    }
  }
  ai_array = [];
  for(i = 0; i < spawners.size; i++) {
    spawners[i].spawning = true;
    if(i % 2) {
      wait_network_frame();
    }
    ai = spawners[i] spawn_ai();
    if(!spawn_failed(ai)) {
      if(isDefined(spawn_func)) {
        single_thread(ai, spawn_func, param1, param2, param3, param4, param5);
      }
      ai_array = add_to_array(ai_array, ai);
    }
    spawners[i].spawning = undefined;
  }
  return ai_array;
}

simple_spawn_single(name_or_spawner, spawn_func, param1, param2, param3, param4, param5) {
  if(IsString(name_or_spawner)) {
    spawner = getEnt(name_or_spawner, "targetname");
    AssertEx(isDefined(spawner), "no spawner with targetname " + name_or_spawner + " found!");
  } else if(IsArray(name_or_spawner)) {
    AssertMsg("simple_spawn_single cannot be used on an array of spawners.use simple_spawn instead.");
  }
  ai = simple_spawn(name_or_spawner, spawn_func, param1, param2, param3, param4, param5);
  AssertEx(ai.size <= 1, "simple_spawn called from simple_spawn_single somehow spawned more than one guy!");
  if(ai.size) {
    return ai[0];
  }
}

CanSpawnThink() {
  level.canSpawnInOneFrame = 3;
  for(;;) {
    level.canSpawnCount = 0;
    wait_network_frame();
  }
}

Canspawn() {
  if(!isDefined(level.canSpawnInOneFrame)) {
    thread CanSpawnThink();
  }
  return true;
}

SpawnThrottleEnableThread() {
  level notify("spawn_throttle_enable_thread_ender");
  level endon("spawn_throttle_enable_thread_ender");
  if(isDefined(level.flag["all_players_connected"])) {
    flag_wait("all_players_connected");
    level.spawnThrottleEnable = true;
  }
}

SpawnThrottleEnable() {
  if(!isDefined(level.spawnThrottleEnable) || (isDefined(level.spawnThrottleEnable) && level.spawnThrottleEnable == false)) {
    level.spawnThrottleEnable = false;
    thread SpawnThrottleEnableThread();
  }
  return level.spawnThrottleEnable;
}

Dospawn(no_enemy_info, targetname) {
  if(SpawnThrottleEnable()) {
    while(!Canspawn()) {
      wait_network_frame();
    }
  }
  if(isDefined(level.canSpawnCount)) {
    level.canSpawnCount += 1;
  }
  if(!isDefined(no_enemy_info)) {
    return self CodeSpawnerspawn();
  } else if(!isDefined(targetname)) {
    return self CodeSpawnerspawn(no_enemy_info);
  } else {
    return self CodeSpawnerspawn(no_enemy_info, targetname);
  }
}

Stalingradspawn(no_enemy_info, targetname) {
  if(SpawnThrottleEnable()) {
    while(!Canspawn()) {
      wait_network_frame();
    }
  }
  if(isDefined(level.canSpawnCount)) {
    level.canSpawnCount += 1;
  }
  if(!isDefined(no_enemy_info)) {
    return self CodeSpawnerForcespawn();
  } else if(!isDefined(targetname)) {
    return self CodeSpawnerForcespawn(no_enemy_info);
  } else {
    return self CodeSpawnerForcespawn(no_enemy_info, targetname);
  }
}

spawn(classname, origin, flags, radius, height, destructibledef) {
  if(SpawnThrottleEnable()) {
    while(!Canspawn()) {
      wait_network_frame();
    }
  }
  if(isDefined(level.canSpawnCount)) {
    level.canSpawnCount += 1;
  }
  if(isDefined(destructibledef)) {
    return Codespawn(classname, origin, flags, radius, height, destructibledef);
  } else if(isDefined(height)) {
    return Codespawn(classname, origin, flags, radius, height);
  } else if(isDefined(radius)) {
    return Codespawn(classname, origin, flags, radius);
  } else if(isDefined(flags)) {
    return Codespawn(classname, origin, flags);
  } else {
    return Codespawn(classname, origin);
  }
}

SpawnVehicle(modelname, targetname, vehicletype, origin, angles, destructibledef) {
  if(SpawnThrottleEnable()) {
    while(!Canspawn()) {
      wait_network_frame();
    }
  }
  if(isDefined(level.canSpawnCount)) {
    level.canSpawnCount += 1;
  }
  assert(isDefined(targetname));
  assert(isDefined(vehicletype));
  assert(isDefined(origin));
  assert(isDefined(angles));
  if(isDefined(destructibledef)) {
    return CodeSpawnVehicle(modelname, targetname, vehicletype, origin, angles, destructibledef);
  } else {
    return CodeSpawnVehicle(modelname, targetname, vehicletype, origin, angles);
  }
}

SpawnTurret(classname, origin, weaponinfoname) {
  if(SpawnThrottleEnable()) {
    while(!Canspawn()) {
      wait_network_frame();
    }
  }
  if(isDefined(level.canSpawnCount)) {
    level.canSpawnCount += 1;
  }
  return CodeSpawnTurret(classname, origin, weaponinfoname);
}

PlayLoopedFX(effectid, repeat, position, cull, forward, up) {
  if(SpawnThrottleEnable()) {
    while(!Canspawn()) {
      wait_network_frame();
    }
  }
  if(isDefined(level.canSpawnCount)) {
    level.canSpawnCount += 1;
  }
  if(isDefined(up)) {
    return CodePlayLoopedFX(effectid, repeat, position, cull, forward, up);
  } else if(isDefined(forward)) {
    return CodePlayLoopedFX(effectid, repeat, position, cull, forward);
  } else if(isDefined(cull)) {
    return CodePlayLoopedFX(effectid, repeat, position, cull);
  } else {
    return CodePlayLoopedFX(effectid, repeat, position);
  }
}

SpawnFx(effect, position, forward, up) {
  if(SpawnThrottleEnable()) {
    while(!Canspawn()) {
      wait_network_frame();
    }
  }
  if(isDefined(level.canSpawnCount)) {
    level.canSpawnCount += 1;
  }
  if(isDefined(up)) {
    return CodeSpawnFx(effect, position, forward, up);
  } else if(isDefined(forward)) {
    return CodeSpawnFx(effect, position, forward);
  } else {
    return CodeSpawnFx(effect, position);
  }
}

spawn_model(model_name, origin, angles) {
  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }
  model = spawn("script_model", origin);
  model setModel(model_name);
  if(isDefined(angles)) {
    model.angles = angles;
  }
  return model;
}

is_plane() {
  if(self.vehicleclass == "plane") {
    return true;
  }
  return false;
}

is_boat() {
  if(self.vehicleclass == "boat") {
    return true;
  }
  return false;
}

is_helicopter() {
  if(self.vehicleclass == "helicopter") {
    return true;
  }
  return false;
}

is_tank() {
  if(self.vehicleclass == "tank") {
    return true;
  }
  return false;
}

is_artillery() {
  if(self.vehicleclass == "artillery") {
    return true;
  }
  return false;
}

is_4wheel() {
  if(self.vehicleclass == "4 wheel") {
    return true;
  }
  return false;
}

is_vehicle() {
  return (isDefined(self.classname) && (self.classname == "script_vehicle"));
}

go_path(path_start) {
  self maps\_vehicle::getonpath(path_start);
  self maps\_vehicle::gopath();
}

disable_driver_turret() {
  self notify("stop_turret_shoot");
}

enable_driver_turret() {
  self notify("stop_turret_shoot");
  self thread maps\_vehicle::turret_attack_think();
}

set_switch_node(src_node, dst_node) {
  assert(isDefined(src_node));
  assert(isDefined(dst_node));
  self.bSwitchingNodes = true;
  self.dst_node = dst_node;
  self SetSwitchNode(src_node, dst_node);
}

create_billboard() {
  level.billboardBlack = newHudElem();
  level.billboardBlack.x = 268;
  level.billboardBlack.y = 20;
  level.billboardBlack.horzAlign = "fullscreen";
  level.billboardBlack.vertAlign = "fullscreen";
  level.billboardBlack.sort = 0;
  level.billboardBlack.alpha = .3;
  level.billboardBlack setShader("black", 120, 55);
  level.billboardWhite = newHudElem();
  level.billboardWhite.x = 270;
  level.billboardWhite.y = 22;
  level.billboardWhite.horzAlign = "fullscreen";
  level.billboardWhite.vertAlign = "fullscreen";
  level.billboardWhite.sort = 1;
  level.billboardWhite.alpha = .3;
  level.billboardWhite setShader("white", 116, 50);
  level.billboardName = NewHudElem();
  level.billboardName.alignX = "left";
  level.billboardName.x = 260;
  level.billboardName.y = 25;
  level.billboardName.sort = 2;
  level.billboardName.fontscale = 1.0;
  level.billboardName.color = (0, 0, 0);
  level.billboardType = NewHudElem();
  level.billboardType.alignX = "left";
  level.billboardType.x = 260;
  level.billboardType.y = 40;
  level.billboardType.sort = 2;
  level.billboardType.fontscale = 1.0;
  level.billboardType.color = (0, 0, 0);
  level.billboardSize = NewHudElem();
  level.billboardSize.alignX = "left";
  level.billboardSize.x = 260;
  level.billboardSize.y = 55;
  level.billboardSize.sort = 2;
  level.billboardSize.fontscale = 1.0;
  level.billboardSize.color = (0, 0, 0);
  level.billboardName setText("Name: ");
  level.billboardType setText("Type:");
  level.billboardSize setText("Size:");
}

destroy_billboard() {
  assertEx(isDefined(level.billboardName), "No billboard is created call create_billboard");
  level.billboardBlack destroy();
  level.billboardWhite destroy();
  level.billboardName destroy();
  level.billboardType destroy();
  level.billboardSize destroy();
}

update_billboard(event_name, event_type, event_size, event_state, disable_fade) {
  assertEx(isDefined(level.billboardName), "No billboard is created call create_billboard");
  if(!isDefined(event_name)) {
    event_name = "undefined";
  }
  if(!isDefined(event_type)) {
    event_type = "undefined";
  }
  if(!isDefined(event_size)) {
    event_size = "undefined";
  }
  color = "black";
  for(i = 0; i < 10; i++) {
    if(color == "black") {
      level.billboardName.color = (1, 0, 0);
      level.billboardType.color = (1, 0, 0);
      level.billboardSize.color = (1, 0, 0);
      color = "red";
    } else {
      level.billboardName.color = (0, 0, 0);
      level.billboardType.color = (0, 0, 0);
      level.billboardSize.color = (0, 0, 0);
      color = "black";
    }
    wait(0.1);
  }
  level.billboardBlack.alpha = 1;
  level.billboardWhite.alpha = 1;
  if(isDefined(event_state)) {
    level.billboardName setText("Name: " + event_name + " (" + event_state + ")");
  } else {
    level.billboardName setText("Name: " + event_name);
  }
  level.billboardType setText("Type: " + event_type);
  level.billboardSize setText("Size: " + event_size);
  wait(3);
  if(isDefined(disable_fade) && disable_fade) {
    return;
  }
  deltaT = 0.7 / 60;
  for(i = 0; i < 60; i++) {
    level.billboardBlack.alpha -= deltaT;
    level.billboardWhite.alpha -= deltaT;
    wait(0.05);
  }
}

heli_toggle_main_rotor_fx(alternate) {
  if(alternate) {
    self SetClientFlag(0);
  } else {
    self ClearClientFlag(0);
  }
}

veh_toggle_tread_fx(on) {
  if(!on) {
    self SetClientFlag(6);
  } else {
    self ClearClientFlag(6);
  }
}

veh_toggle_exhaust_fx(on) {
  if(!on) {
    self SetClientFlag(8);
  } else {
    self ClearClientFlag(8);
  }
}

veh_toggle_lights(on) {
  if(on) {
    self SetClientFlag(10);
  } else {
    self ClearClientFlag(10);
  }
}

heli_toggle_rotor_fx(on) {
  if(!on) {
    self SetClientFlag(1);
  } else {
    self ClearClientFlag(1);
  }
}

vehicle_toggle_sounds(on) {
  if(!on) {
    self SetClientFlag(2);
  } else {
    self ClearClientFlag(2);
  }
}

spawn_manager_set_global_active_count(cnt) {
  AssertEx(cnt <= 32, "Max number of Active AI at a given time cant be more than 32");
  level.spawn_manager_max_ai = cnt;
}

sm_use_trig_when_complete(spawn_manager_targetname, trig_name, trig_key, once_only) {
  self thread sm_use_trig_when_complete_internal(spawn_manager_targetname, trig_name, trig_key, once_only);
}

sm_use_trig_when_complete_internal(spawn_manager_targetname, trig_name, trig_key, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getEnt(trig_name, trig_key);
    AssertEX(isDefined(trigger), "The trigger " + trig_key + " / " + trig_name + " does not exist.");
    trigger endon("trigger");
  }
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    flag_wait("sm_" + spawn_manager_targetname + "_complete");
    trigger_use(trig_name, trig_key);
  } else {
    AssertMsg("sm_use_trig_when_complete: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

sm_use_trig_when_cleared(spawn_manager_targetname, trig_name, trig_key, once_only) {
  self thread sm_use_trig_when_cleared_internal(spawn_manager_targetname, trig_name, trig_key, once_only);
}

sm_use_trig_when_cleared_internal(spawn_manager_targetname, trig_name, trig_key, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getEnt(trig_name, trig_key);
    AssertEX(isDefined(trigger), "The trigger " + trig_key + " / " + trig_name + " does not exist.");
    trigger endon("trigger");
  }
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    flag_wait("sm_" + spawn_manager_targetname + "_cleared");
    trigger_use(trig_name, trig_key);
  } else {
    AssertMsg("sm_use_trig_when_cleared: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

sm_use_trig_when_enabled(spawn_manager_targetname, trig_name, trig_key, once_only) {
  self thread sm_use_trig_when_enabled_internal(spawn_manager_targetname, trig_name, trig_key, once_only);
}

sm_use_trig_when_enabled_internal(spawn_manager_targetname, trig_name, trig_key, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getEnt(trig_name, trig_key);
    AssertEX(isDefined(trigger), "The trigger " + trig_key + " / " + trig_name + " does not exist.");
    trigger endon("trigger");
  }
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    flag_wait("sm_" + spawn_manager_targetname + "_enabled");
    trigger_use(trig_name, trig_key);
  } else {
    AssertMsg("sm_use_trig_when_cleared: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

sm_run_func_when_complete(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  self thread sm_run_func_when_complete_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5);
}

sm_run_func_when_complete_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  AssertEx(isDefined(process), "sm_run_func_when_complete: the function is not defined");
  AssertEx(level flag_exists("sm_" + spawn_manager_targetname + "_enabled"), "sm_run_func_when_complete: Spawn manager '" + spawn_manager_targetname + "' not found.");
  waittill_spawn_manager_complete(spawn_manager_targetname);
  single_func(ent, process, var1, var2, var3, var4, var5);
}

sm_run_func_when_cleared(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  self thread sm_run_func_when_cleared_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5);
}

sm_run_func_when_cleared_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  AssertEx(isDefined(process), "sm_run_func_when_cleared: the function is not defined");
  AssertEx(level flag_exists("sm_" + spawn_manager_targetname + "_enabled"), "sm_run_func_when_cleared: Spawn manager '" + spawn_manager_targetname + "' not found.");
  waittill_spawn_manager_cleared(spawn_manager_targetname);
  single_func(ent, process, var1, var2, var3, var4, var5);
}

sm_run_func_when_enabled(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  self thread sm_run_func_when_enabled_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5);
}

sm_run_func_when_enabled_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  AssertEx(isDefined(process), "sm_run_func_when_enabled: the function is not defined");
  AssertEx(level flag_exists("sm_" + spawn_manager_targetname + "_enabled"), "sm_run_func_when_enabled: Spawn manager '" + spawn_manager_targetname + "' not found.");
  waittill_spawn_manager_enabled(spawn_manager_targetname);
  single_func(ent, process, var1, var2, var3, var4, var5);
}

spawn_manager_enable(spawn_manager_targetname, no_assert) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    for(i = 0; i < level.spawn_managers.size; i++) {
      if(level.spawn_managers[i].sm_id == spawn_manager_targetname) {
        level.spawn_managers[i] notify("enable");
        return;
      }
    }
  } else if(!is_true(no_assert)) {
    AssertMsg("spawn_manager_enable: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

spawn_manager_disable(spawn_manager_targetname, no_assert) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    for(i = 0; i < level.spawn_managers.size; i++) {
      if(level.spawn_managers[i].sm_id == spawn_manager_targetname) {
        level.spawn_managers[i] notify("disable");
        return;
      }
    }
  } else if(!is_true(no_assert)) {
    AssertMsg("spawn_manager_disable: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

spawn_manager_kill(spawn_manager_targetname, no_assert) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    for(i = 0; i < level.spawn_managers.size; i++) {
      if(level.spawn_managers[i].sm_id == spawn_manager_targetname) {
        level.spawn_managers[i] notify("kill");
        return;
      }
    }
  } else if(!is_true(no_assert)) {
    AssertMsg("spawn_manager_kill: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

is_spawn_manager_enabled(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(flag("sm_" + spawn_manager_targetname + "_enabled")) {
      return true;
    }
    return false;
  } else {
    AssertMsg("is_spawn_manager_enabled: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

is_spawn_manager_complete(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(flag("sm_" + spawn_manager_targetname + "_complete")) {
      return true;
    }
    return false;
  } else {
    AssertMsg("is_spawn_manager_complete: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

is_spawn_manager_cleared(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(flag("sm_" + spawn_manager_targetname + "_cleared")) {
      return true;
    }
    return false;
  } else {
    AssertMsg("is_spawn_manager_cleared: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

is_spawn_manager_killed(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(flag("sm_" + spawn_manager_targetname + "_killed")) {
      return true;
    }
    return false;
  } else {
    AssertMsg("is_spawn_manager_killed: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

waittill_spawn_manager_cleared(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    flag_wait("sm_" + spawn_manager_targetname + "_cleared");
  } else {
    AssertMsg("waittill_spawn_manager_cleared: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

waittill_spawn_manager_ai_remaining(spawn_manager_targetname, count_to_reach) {
  AssertEX(isDefined(count_to_reach), "# of AI remaining not specified in _utility::waittill_spawn_manager_ai_remaining()");
  AssertEX(count_to_reach, "# of AI remaining specified in _utility::waittill_spawn_manager_ai_remaining() is 0, use waittill_spawn_manager_cleared");
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    flag_wait("sm_" + spawn_manager_targetname + "_complete");
  } else {
    AssertMsg("waittill_spawn_manager_ai_remaining: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
  if(flag("sm_" + spawn_manager_targetname + "_cleared")) {
    return;
  }
  spawn_manager = maps\_spawn_manager::get_spawn_manager_array(spawn_manager_targetname);
  AssertEx(spawn_manager.size, "Somehow the spawn manager doesnt exist, but related flag existed before.");
  AssertEx((spawn_manager.size == 1), "Found two spawn managers with same targetname.");
  while((isDefined(spawn_manager[0])) && (spawn_manager[0].activeAI.size > count_to_reach)) {
    wait(0.1);
  }
}

waittill_spawn_manager_complete(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    flag_wait("sm_" + spawn_manager_targetname + "_complete");
  } else {
    AssertMsg("waittill_spawn_manager_complete: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

waittill_spawn_manager_enabled(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    flag_wait("sm_" + spawn_manager_targetname + "_enabled");
  } else {
    AssertMsg("waittill_spawn_manager_enabled: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
}

waittill_spawn_manager_spawned_count(spawn_manager_targetname, count) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    flag_wait("sm_" + spawn_manager_targetname + "_enabled");
  } else {
    AssertMsg("waittill_spawn_manager_spawned_count: Spawn manager '" + spawn_manager_targetname + "' not found.");
  }
  spawn_manager = maps\_spawn_manager::get_spawn_manager_array(spawn_manager_targetname);
  AssertEx(spawn_manager.size, "Somehow the spawn manager doesnt exist, but related flag existed before.");
  AssertEx((spawn_manager.size == 1), "Found two spawn managers with same targetname.");
  Assert(spawn_manager[0].count > count, "waittill_spawn_manager_spawned_count : Count should be less than total count on the spawn manager.");
  original_count = spawn_manager[0].count;
  while(1) {
    if(isDefined(spawn_manager[0].spawnCount) && (spawn_manager[0].spawnCount < count) && !is_spawn_manager_killed(spawn_manager_targetname)) {
      wait(0.5);
    } else {
      break;
    }
  }
  return;
}

contextual_melee(melee_name, which_set) {
  self maps\_contextual_melee::main(melee_name, which_set);
}

add_meatshield_target(meatshield, scripted) {
  maps\_meatshield::add_target(meatshield, scripted);
}

add_meatshield_angle_limits(guy, leftarc, rightarc) {
  maps\_meatshield::add_angle_limits(guy, leftarc, rightarc);
}

veh_magic_bullet_shield(on) {
  assertex(!IsAI(self), "This is for vehicles, please use magic_bullet_shield for AI.");
  assertex(!IsPlayer(self), "This is for vehicles, please use magic_bullet_shield for players.");
  if(!on) {
    self maps\_vehicle::godoff();
  } else {
    self maps\_vehicle::godon();
  }
}

OnFirstPlayerConnect_Callback(func) {
  maps\_callbackglobal::AddCallback("on_first_player_connect", func);
}

OnFirstPlayerConnect_CallbackRemove(func) {
  maps\_callbackglobal::RemoveCallback("on_first_player_connect", func);
}

OnPlayerConnect_Callback(func) {
  maps\_callbackglobal::AddCallback("on_player_connect", func);
}

OnPlayerConnect_CallbackRemove(func) {
  maps\_callbackglobal::RemoveCallback("on_player_connect", func);
}

OnPlayerDisconnect_Callback(func) {
  maps\_callbackglobal::AddCallback("on_player_disconnect", func);
}

OnPlayerDisconnect_CallbackRemove(func) {
  maps\_callbackglobal::RemoveCallback("on_player_disconnect", func);
}

OnPlayerDamage_Callback(func) {
  maps\_callbackglobal::AddCallback("on_player_damage", func);
}

OnPlayerDamage_CallbackRemove(func) {
  maps\_callbackglobal::RemoveCallback("on_player_damage", func);
}

OnPlayerLastStand_Callback(func) {
  maps\_callbackglobal::AddCallback("on_player_last_stand", func);
}

OnPlayerLastStand_CallbackRemove(func) {
  maps\_callbackglobal::RemoveCallback("on_player_last_stand", func);
}

OnPlayerKilled_Callback(func) {
  maps\_callbackglobal::AddCallback("on_player_killed", func);
}

OnPlayerKilled_CallbackRemove(func) {
  maps\_callbackglobal::RemoveCallback("on_player_killed", func);
}

OnActorDamage_Callback(func) {
  maps\_callbackglobal::AddCallback("on_actor_damage", func);
}

OnActorDamage_CallbackRemove(func) {
  maps\_callbackglobal::RemoveCallback("on_actor_damage", func);
}

OnActorKilled_Callback(func) {
  maps\_callbackglobal::AddCallback("on_actor_killed", func);
}

OnActorKilled_CallbackRemove(func) {
  maps\_callbackglobal::RemoveCallback("on_actor_killed", func);
}

OnVehicleDamage_Callback(func) {
  maps\_callbackglobal::AddCallback("on_vehicle_damage", func);
}

OnVehicleDamage_CallbackRemove(func) {
  maps\_callbackglobal::RemoveCallback("on_vehicle_damage", func);
}

OnSaveRestored_Callback(func) {
  maps\_callbackglobal::AddCallback("on_save_restored", func);
}

OnSaveRestored_CallbackRemove(func) {
  maps\_callbackglobal::RemoveCallback("on_save_restored", func);
}

aim_at_target(target, duration) {
  self endon("death");
  self endon("stop_aim_at_target");
  assert(isDefined(target));
  if(!isDefined(target)) {
    return;
  }
  self SetEntityTarget(target);
  self.a.allow_shooting = false;
  if(isDefined(duration) && duration > 0) {
    elapsed = 0;
    while(elapsed < duration) {
      elapsed += 0.05;
      wait(0.05);
    }
    stop_aim_at_target();
  }
}

stop_aim_at_target() {
  self ClearEntityTarget();
  self.a.allow_shooting = true;
  self notify("stop_aim_at_target");
}

shoot_at_target(target, tag, fireDelay, duration) {
  self endon("death");
  self endon("stop_shoot_at_target");
  assert(isDefined(target));
  if(!isDefined(target)) {
    return;
  }
  if(isDefined(tag) && tag != "" && tag != "tag_eye" && tag != "tag_head") {
    self SetEntityTarget(target, 1, tag);
  } else {
    self SetEntityTarget(target);
  }
  self animscripts\weaponList::RefillClip();
  if(isDefined(fireDelay) && fireDelay > 0) {
    self.a.allow_shooting = false;
    wait(fireDelay);
  }
  self.a.allow_shooting = true;
  self.cansee_override = true;
  self call_overloaded_func("animscripts\shoot_behavior", "setShootEnt", target);
  self waittill("shoot");
  if(isDefined(duration)) {
    if(duration > 0) {
      elapsed = 0;
      while(elapsed < duration) {
        elapsed += 0.05;
        wait(0.05);
      }
    } else if(duration == -1) {
      target waittill("death");
    }
  }
  stop_shoot_at_target();
}

shoot_at_target_untill_dead(target, tag, fireDelay) {
  shoot_at_target(target, tag, fireDelay, -1);
}

stop_shoot_at_target() {
  self ClearEntityTarget();
  self.cansee_override = false;
  self notify("stop_shoot_at_target");
}

add_trigger_to_ent(ent) {
  if(!isDefined(ent._triggers)) {
    ent._triggers = [];
  }
  ent._triggers[self getEntityNumber()] = 1;
}

remove_trigger_from_ent(ent) {
  if(!isDefined(ent._triggers))
    return;
  if(!isDefined(ent._triggers[self getEntityNumber()]))
    return;
  ent._triggers[self getEntityNumber()] = 0;
}

ent_already_in_trigger(trig) {
  if(!isDefined(self._triggers))
    return false;
  if(!isDefined(self._triggers[trig getEntityNumber()]))
    return false;
  if(!self._triggers[trig getEntityNumber()])
    return false;
  return true;
}

trigger_thread(ent, on_enter_payload, on_exit_payload) {
  ent endon("entityshutdown");
  ent endon("death");
  if(ent ent_already_in_trigger(self))
    return;
  self add_trigger_to_ent(ent);
  endon_condition = "leave_trigger_" + self getEntityNumber();
  if(isDefined(on_enter_payload)) {
    self thread[[on_enter_payload]](ent, endon_condition);
  }
  while(isDefined(ent) && ent IsTouching(self)) {
    wait(0.01);
  }
  ent notify(endon_condition);
  if(isDefined(ent) && isDefined(on_exit_payload)) {
    self thread[[on_exit_payload]](ent);
  }
  if(isDefined(ent)) {
    self remove_trigger_from_ent(ent);
  }
}

set_swimming_depth_of_field(toggle, set_values, near_start, near_end, far_start, far_end, near_blur, far_blur) {
  AssertEx(isDefined(toggle), "toggle must be set to true or false");
  if(toggle) {
    level._swimming.toggle_depth_of_field = true;
    if(isDefined(set_values) && set_values) {
      AssertEx(isDefined(near_start), "Depth of Field value near_start undefined");
      AssertEx(isDefined(near_end), "Depth of Field value near_end undefined");
      AssertEx(isDefined(far_start), "Depth of Field value far_start undefined");
      AssertEx(isDefined(far_end), "Depth of Field value far_end undefined");
      AssertEx(isDefined(near_blur), "Depth of Field value near_blur undefined");
      AssertEx(isDefined(far_blur), "Depth of Field value far_blur undefined");
      AssertEx(near_start < near_end, "Depth of Field value near_start must be < near_end");
      AssertEx(far_start < far_end, "Depth of Field value far_start must be < far_end");
      level._swimming.dof_near_start = near_start;
      level._swimming.dof_near_end = near_end;
      level._swimming.dof_far_start = far_start;
      level._swimming.dof_far_end = far_end;
      level._swimming.dof_near_blur = near_blur;
      level._swimming.dof_far_blur = far_blur;
    }
  } else if(!toggle) {
    level._swimming.toggle_depth_of_field = false;
  }
}

disable_swimming() {
  self maps\_swimming::disable();
}

enable_swimming() {
  self maps\_swimming::enable();
}

hide_swimming_arms() {
  self ClientNotify("_swimming:hide_arms");
}

show_swimming_arms() {
  self ClientNotify("_swimming:show_arms");
}

delete_ents(mask, origin, radius) {
  ents = entsearch(mask, origin, radius);
  for(i = 0; i < ents.size; i++) {
    ents[i] delete();
  }
}

set_drop_weapon(weapon_name) {
  AssertEx(isDefined(weapon_name) && IsString(weapon_name), "_utility::set_drop_weapon: Invalid weapon name!");
  self.script_dropweapon = weapon_name;
}

take_and_giveback_weapons(mynotify, no_autoswitch) {
  take_weapons();
  self waittill(mynotify);
  give_weapons(no_autoswitch);
}

take_weapons() {
  self.curweapon = self GetCurrentWeapon();
  self.weapons_list = self GetWeaponsList();
  self.offhand = self GetCurrentOffhand();
  weapon_list_modified = [];
  for(i = 0; i < self.weapons_list.size; i++) {
    if(!is_weapon_attachment(self.weapons_list[i]))
      weapon_list_modified[weapon_list_modified.size] = self.weapons_list[i];
  }
  self.weapons_list = weapon_list_modified;
  if(is_weapon_attachment(self.curweapon)) {
    self.curweapon = get_baseweapon_for_attachment(self.curweapon);
  }
  self.weapons_info = [];
  for(i = 0; i < self.weapons_list.size; i++) {
    self.weapons_info[i] = spawnStruct();
    if(isDefined(self.offhand) && self.weapons_list[i] == self.offhand) {
      self.weapons_info[i]._ammo = 0;
      self.weapons_info[i]._stock = self GetWeaponAmmoStock(self.weapons_list[i]);
    } else {
      self.weapons_info[i]._ammo = self GetWeaponAmmoClip(self.weapons_list[i]);
      self.weapons_info[i]._stock = self GetWeaponAmmoStock(self.weapons_list[i]);
      self.weapons_info[i]._renderOptions = self GetWeaponRenderOptions(self.weapons_list[i]);
    }
  }
  self TakeAllWeapons();
}

give_weapons(no_autoswitch) {
  for(i = 0; i < self.weapons_list.size; i++) {
    if(isDefined(self.weapons_info[i]._renderOptions)) {
      self GiveWeapon(self.weapons_list[i], 0, self.weapons_info[i]._renderOptions);
    } else {
      self GiveWeapon(self.weapons_list[i]);
    }
    self SetWeaponAmmoClip(self.weapons_list[i], self.weapons_info[i]._ammo);
    self SetWeaponAmmoStock(self.weapons_list[i], self.weapons_info[i]._stock);
  }
  self.weapons_info = undefined;
  if(isDefined(self.curweapon) && self.curweapon != "none" && !isDefined(no_autoswitch)) {
    self SwitchToWeapon(self.curweapon);
  }
}

is_weapon_attachment(weapon_name) {
  weapon_pieces = StrTok(weapon_name, "_");
  if(weapon_pieces[0] == "ft" || weapon_pieces[0] == "mk" || weapon_pieces[0] == "gl") {
    return true;
  }
  return false;
}

get_baseweapon_for_attachment(weapon_name) {
  Assert(is_weapon_attachment(weapon_name));
  weapon_pieces = StrTok(weapon_name, "_");
  attachment = weapon_pieces[0];
  Assert(weapon_pieces[0] == "ft" || weapon_pieces[0] == "mk" || weapon_pieces[0] == "gl" || weapon_pieces[0] == "db");
  weapon = weapon_pieces[1];
  Assert(weapon_pieces[1] != "ft" && weapon_pieces[1] != "mk" && weapon_pieces[1] != "gl" && weapon_pieces[1] != "db");
  for(i = 0; i < self.weapons_list.size; i++) {
    if(IsSubStr(self.weapons_list[i], weapon) && IsSubStr(self.weapons_list[i], attachment))
      return self.weapons_list[i];
  }
  return self.weapons_list[0];
}

set_near_plane(val) {
  self setClientDvar("r_znear", val);
}

reset_near_plane() {
  self setClientDvar("r_znear", 4);
}

average_origin(ent_array) {
  AssertEx(IsArray(ent_array), "_utility::average_position passed a non-array");
  AssertEx(ent_array.size > 0, "_utility::average_position passed a size zero array");
  if(IsVec(ent_array[0])) {
    return (average_origin_internal(ent_array));
  }
  org_array = [];
  for(i = 0; i < ent_array.size; i++) {
    org_array[i] = ent_array[i].origin;
  }
  return (average_origin_internal(org_array));
}

average_origin_internal(org_array) {
  if(org_array.size == 1) {
    return org_array[0];
  }
  pos = (0, 0, 0);
  for(i = 0; i < org_array.size; i++) {
    pos += org_array[i];
  }
  avg_pos = pos / org_array.size;
  return avg_pos;
}

screen_message_create(string_message_1, string_message_2, string_message_3) {
  if(isDefined(level.missionfailed) && level.missionfailed)
    return;
  if(GetDvarInt("hud_missionFailed") == 1)
    return;
  if(!isDefined(level._screen_message_1)) {
    level._screen_message_1 = NewHudElem();
    level._screen_message_1.elemType = "font";
    level._screen_message_1.font = "objective";
    level._screen_message_1.fontscale = 1.8;
    level._screen_message_1.horzAlign = "center";
    level._screen_message_1.vertAlign = "middle";
    level._screen_message_1.alignX = "center";
    level._screen_message_1.alignY = "middle";
    level._screen_message_1.y = -60;
    level._screen_message_1.sort = 2;
    level._screen_message_1.color = (1, 1, 1);
    level._screen_message_1.alpha = 0.70;
    level._screen_message_1.hidewheninmenu = true;
  }
  level._screen_message_1 SetText(string_message_1);
  if(isDefined(string_message_2)) {
    if(!isDefined(level._screen_message_2)) {
      level._screen_message_2 = NewHudElem();
      level._screen_message_2.elemType = "font";
      level._screen_message_2.font = "objective";
      level._screen_message_2.fontscale = 1.8;
      level._screen_message_2.horzAlign = "center";
      level._screen_message_2.vertAlign = "middle";
      level._screen_message_2.alignX = "center";
      level._screen_message_2.alignY = "middle";
      level._screen_message_2.y = -33;
      level._screen_message_2.sort = 2;
      level._screen_message_2.color = (1, 1, 1);
      level._screen_message_2.alpha = 0.70;
      level._screen_message_2.hidewheninmenu = true;
    }
    level._screen_message_2 SetText(string_message_2);
  } else if(isDefined(level._screen_message_2)) {
    level._screen_message_2 Destroy();
  }
  if(isDefined(string_message_3)) {
    if(!isDefined(level._screen_message_3)) {
      level._screen_message_3 = NewHudElem();
      level._screen_message_3.elemType = "font";
      level._screen_message_3.font = "objective";
      level._screen_message_3.fontscale = 1.8;
      level._screen_message_3.horzAlign = "center";
      level._screen_message_3.vertAlign = "middle";
      level._screen_message_3.alignX = "center";
      level._screen_message_3.alignY = "middle";
      level._screen_message_3.y = -6;
      level._screen_message_3.sort = 2;
      level._screen_message_3.color = (1, 1, 1);
      level._screen_message_3.alpha = 0.70;
      level._screen_message_3.hidewheninmenu = true;
    }
    level._screen_message_3 SetText(string_message_3);
  } else if(isDefined(level._screen_message_3)) {
    level._screen_message_3 Destroy();
  }
}

screen_message_delete() {
  if(isDefined(level._screen_message_1)) {
    level._screen_message_1 Destroy();
  }
  if(isDefined(level._screen_message_2)) {
    level._screen_message_2 Destroy();
  }
  if(isDefined(level._screen_message_3)) {
    level._screen_message_3 Destroy();
  }
}

get_eye() {
  if(IsPlayer(self)) {
    linked_ent = self GetLinkedEnt();
    if(isDefined(linked_ent) && (GetDvarInt(#"cg_cameraUseTagCamera") > 0)) {
      camera = linked_ent GetTagOrigin("tag_camera");
      if(isDefined(camera)) {
        return camera;
      }
    }
  }
  pos = self getEye();
  return pos;
}

vehicle_node_wait(strName, strKey) {
  if(!isDefined(strKey)) {
    strKey = "targetname";
  }
  nodes = GetVehicleNodeArray(strName, strKey);
  AssertEX(isDefined(nodes) && nodes.size > 0, "_utility::vehicle_node_wait - vehicle node not found: " + strName + " key: " + strKey);
  ent = spawnStruct();
  array_thread(nodes, common_scripts\utility::trigger_wait_think, ent);
  ent waittill("trigger", eOther, node_hit);
  level notify(strName, eOther);
  if(isDefined(node_hit)) {
    node_hit.who = eother;
    return node_hit;
  } else {
    return eOther;
  }
}

timescale_tween(start, end, time, delay, step_time) {
  DEFAULT_STEP_TIME = .1;
  if(!isDefined(step_time)) {
    step_time = DEFAULT_STEP_TIME;
  }
  num_steps = time / step_time;
  time_scale_range = end - start;
  time_scale_step = 0;
  if(num_steps > 0) {
    time_scale_step = abs(time_scale_range) / num_steps;
  }
  if(isDefined(delay)) {
    wait delay;
  }
  level notify("timescale_tween");
  level endon("timescale_tween");
  time_scale = start;
  SetTimeScale(time_scale);
  while(time_scale != end) {
    wait(step_time);
    if(time_scale_range > 0) {
      time_scale = min(time_scale + time_scale_step, end);
    } else if(time_scale_range < 0) {
      time_scale = max(time_scale - time_scale_step, end);
    }
    SetTimeScale(time_scale);
  }
}

player_seek(delayed) {
  self endon("death");
  self.ignoresuppression = 1;
  if(isDefined(self.target) || isDefined(self.script_spawner_targets)) {
    self waittill("goal");
  }
  while(1) {
    if(isDefined(delayed)) {
      wait(RandomIntRange(6, 12));
    } else {
      wait(0.05);
    }
    if(self.goalradius > 100) {
      self.goalradius = self.goalradius - 100;
    }
    self.pathenemyFightdist = self.goalradius;
    closest_player = get_closest_player(self.origin);
    self SetGoalEntity(closest_player);
    self animscripts\combat_utility::FindCoverNearSelf();
  }
}

set_spawner_targets(spawner_targets) {
  self thread maps\_spawner::go_to_spawner_target(StrTok(spawner_targets, " "));
}

ragdoll_death() {
  self animscripts\utility::do_ragdoll_death();
}

is_destructible() {
  if(!isDefined(self.script_noteworthy)) {
    return false;
  }
  switch (self.script_noteworthy) {
    case "explodable_barrel":
      return true;
  }
  return false;
}

register_overloaded_func(filename, funcname, func) {
  if(!isDefined(level._overloaded_funcs)) {
    level._overloaded_funcs = [];
  }
  if(!isDefined(level._overloaded_funcs[filename])) {
    level._overloaded_funcs[filename] = [];
  }
  if(isDefined(level._overloaded_funcs[filename][funcname])) {
    error("Tried to call register_overloaded_func() on a previously registered filename['" + filename + "']/funcname['" + funcname + "'] combination.");
    return;
  }
  level._overloaded_funcs[filename][funcname] = func;
}

call_overloaded_func(filename, funcname, var1, var2, var3, var4, var5) {
  if(!isDefined(level._overloaded_funcs)) {
    if(getDvar(#"zombiemode") == "1") {
      println("call_overloaded_func: no overloaded_funcs registered.");
    } else {
      assertex(false, "call_overloaded_func: no overloaded_funcs registered.");
    }
    return false;
  }
  if(!isDefined(level._overloaded_funcs[filename])) {
    if(getDvar(#"zombiemode") == "1") {
      println("call_overloaded_func: no overloaded_funcs registered for filename: '" + filename + "'.");
    } else {
      assertex(false, "call_overloaded_func: no overloaded_funcs registered for filename: '" + filename + "'.");
    }
    return false;
  }
  if(!isDefined(level._overloaded_funcs[filename][funcname])) {
    if(getDvar(#"zombiemode") == "1") {
      println("call_overloaded_func: no overloaded_func registered for filename['" + filename + "']/funcname['" + funcname + "'] combination.");
    } else {
      assertex(false, "call_overloaded_func: no overloaded_func registered for filename['" + filename + "']/funcname['" + funcname + "'] combination.");
    }
    return false;
  }
  if(isDefined(var5)) {
    return self[[level._overloaded_funcs[filename][funcname]]](var1, var2, var3, var4, var5);
  }
  if(isDefined(var4)) {
    return self[[level._overloaded_funcs[filename][funcname]]](var1, var2, var3, var4);
  }
  if(isDefined(var3)) {
    return self[[level._overloaded_funcs[filename][funcname]]](var1, var2, var3);
  }
  if(isDefined(var2)) {
    return self[[level._overloaded_funcs[filename][funcname]]](var1, var2);
  }
  if(isDefined(var1)) {
    return self[[level._overloaded_funcs[filename][funcname]]](var1);
  }
  return self[[level._overloaded_funcs[filename][funcname]]]();
}

get_overloaded_func(filename, funcname) {
  if(!isDefined(level._overloaded_funcs)) {
    if(getDvar(#"zombiemode") == "1") {
      println("get_overloaded_func: no overloaded_funcs registered.");
    } else {
      assertex(false, "get_overloaded_func: no overloaded_funcs registered.");
    }
    return false;
  }
  if(!isDefined(level._overloaded_funcs[filename])) {
    if(getDvar(#"zombiemode") == "1") {
      println("get_overloaded_func: no overloaded_funcs registered for filename: '" + filename + "'.");
    } else {
      assertex(false, "get_overloaded_func: no overloaded_funcs registered for filename: '" + filename + "'.");
    }
    return false;
  }
  if(!isDefined(level._overloaded_funcs[filename][funcname])) {
    if(getDvar(#"zombiemode") == "1") {
      println("get_overloaded_func: no overloaded_func registered for filename['" + filename + "']/funcname['" + funcname + "'] combination.");
    } else {
      assertex(false, "get_overloaded_func: no overloaded_func registered for filename['" + filename + "']/funcname['" + funcname + "'] combination.");
    }
    return false;
  }
  return level._overloaded_funcs[filename][funcname];
}

waittill_not_moving() {
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  prevorigin = self.origin;
  while(1) {
    wait .15;
    if(self.origin == prevorigin) {
      break;
    }
    prevorigin = self.origin;
  }
}

turn_off_friendly_player_look() {
  level._dont_look_at_player = true;
}

turn_on_friendly_player_look() {
  level._dont_look_at_player = false;
}

force_goal(node_or_org, radius, shoot, end_on, keep_colors) {
  self endon("death");
  goalradius = self.goalradius;
  if(isDefined(radius)) {
    self.goalradius = radius;
  }
  color_enabled = false;
  if(!is_true(keep_colors)) {
    if(isDefined(get_force_color())) {
      color_enabled = true;
      self disable_ai_color();
    }
  }
  allowpain = self.allowpain;
  allowreact = self.allowreact;
  ignoreall = self.ignoreall;
  ignoreme = self.ignoreme;
  dontshootwhilemoving = self.dontshootwhilemoving;
  ignoresuppression = self.ignoresuppression;
  suppressionthreshold = self.suppressionthreshold;
  nododgemove = self.nododgemove;
  grenadeawareness = self.grenadeawareness;
  pathenemylookahead = self.pathenemylookahead;
  pathenemyfightdist = self.pathenemyfightdist;
  meleeattackdist = self.meleeattackdist;
  fixednodesaferadius = self.fixednodesaferadius;
  if(is_false(shoot)) {
    self set_ignoreall(true);
  }
  self.dontshootwhilemoving = undefined;
  self.pathenemyfightdist = 0;
  self.pathenemylookahead = 0;
  self.ignoresuppression = true;
  self.suppressionthreshold = 1;
  self.nododgemove = true;
  self.grenadeawareness = 0;
  self.meleeattackdist = 0;
  self.fixednodesaferadius = 0;
  if(getDvar(#"zombiemode") != "1") {
    self set_ignoreme(true);
    self disable_react();
    self disable_pain();
  }
  self PushPlayer(true);
  if(isDefined(node_or_org)) {
    if(IsVec(node_or_org)) {
      self set_goal_pos(node_or_org);
    } else {
      self set_goal_node(node_or_org);
    }
  }
  if(isDefined(end_on)) {
    self waittill(end_on);
  } else {
    self waittill("goal");
  }
  if(color_enabled) {
    enable_ai_color();
  }
  self PushPlayer(false);
  if(getDvar(#"zombiemode") == "1") {
    if(isDefined(radius)) {
      self.goalradius = goalradius;
    }
  } else {
    self.goalradius = goalradius;
    self set_ignoreall(ignoreall);
    self set_ignoreme(ignoreme);
    if(allowpain) {
      self enable_pain();
    }
    if(allowreact) {
      self enable_react();
    }
  }
  self.ignoresuppression = ignoresuppression;
  self.suppressionthreshold = suppressionthreshold;
  self.nododgemove = nododgemove;
  self.dontshootwhilemoving = dontshootwhilemoving;
  self.grenadeawareness = grenadeawareness;
  self.pathenemylookahead = pathenemylookahead;
  self.pathenemyfightdist = pathenemyfightdist;
  self.meleeattackdist = meleeattackdist;
  self.fixednodesaferadius = fixednodesaferadius;
}

restore_ik_headtracking_limits() {
  SetSavedDvar("ik_pitch_limit_thresh", 10);
  SetSavedDvar("ik_pitch_limit_max", 60);
  SetSavedDvar("ik_roll_limit_thresh", 30);
  SetSavedDvar("ik_roll_limit_max", 100);
  SetSavedDvar("ik_yaw_limit_thresh", 10);
  SetSavedDvar("ik_yaw_limit_max", 90);
}

relax_ik_headtracking_limits() {
  SetSavedDvar("ik_pitch_limit_thresh", 110);
  SetSavedDvar("ik_pitch_limit_max", 120);
  SetSavedDvar("ik_roll_limit_thresh", 90);
  SetSavedDvar("ik_roll_limit_max", 100);
  SetSavedDvar("ik_yaw_limit_thresh", 80);
  SetSavedDvar("ik_yaw_limit_max", 90);
}

do_notetracks(flag) {
  self animscripts\shared::DoNoteTracks(flag);
}

rumble_delay(delay, rumble) {
  wait delay;
  self playRumbleOnEntity(rumble);
}

enable_random_weapon_drops() {
  level.rw_enabled = true;
}

disable_random_weapon_drops() {
  level.rw_enabled = false;
}

enable_random_alt_weapon_drops() {
  level.rw_attachments_allowed = true;
}

disable_random_alt_weapon_drops() {
  level.rw_attachments_allowed = false;
}

set_random_alt_weapon_drops(attachment_abbreviation, on_or_off) {
  AssertEX(isDefined(attachment_abbreviation), "set_random_alt_weapon_drops called without passing in an attachment type");
  AssertEX(isDefined(on_or_off), "set_random_alt_weapon_drops called without telling the function whether it is on or off");
  switch (attachment_abbreviation) {
    case "ft":
      level.rw_ft_allowed = on_or_off;
      break;
    case "gl":
      level.rw_gl_allowed = on_or_off;
      break;
    case "mk":
      level.rw_mk_allowed = on_or_off;
      break;
    default:
      AssertEX(false, "Weapon of type: " + attachment_abbreviation + " is not a valid attachment abbreviation.");
      break;
  }
}

button_held_think(which_button) {
  self endon("disconnect");
  if(!isDefined(self._holding_button)) {
    self._holding_button = [];
  }
  self._holding_button[which_button] = false;
  time_started = 0;
  use_time = GetDvarInt("g_useholdtime");
  while(1) {
    if(self._holding_button[which_button]) {
      if(!self[[level._button_funcs[which_button]]]()) {
        self._holding_button[which_button] = false;
      }
    } else {
      if(self[[level._button_funcs[which_button]]]()) {
        if(time_started == 0) {
          time_started = GetTime();
        }
        if((GetTime() - time_started) > use_time) {
          self._holding_button[which_button] = true;
        }
      } else {
        if(time_started != 0) {
          time_started = 0;
        }
      }
    }
    wait(0.05);
  }
}

use_button_held() {
  init_button_wrappers();
  if(!isDefined(self._use_button_think_threaded)) {
    self thread button_held_think(level.BUTTON_USE);
    self._use_button_think_threaded = true;
  }
  return self._holding_button[level.BUTTON_USE];
}

ads_button_held() {
  init_button_wrappers();
  if(!isDefined(self._ads_button_think_threaded)) {
    self thread button_held_think(level.BUTTON_ADS);
    self._ads_button_think_threaded = true;
  }
  return self._holding_button[level.BUTTON_ADS];
}

attack_button_held() {
  init_button_wrappers();
  if(!isDefined(self._attack_button_think_threaded)) {
    self thread button_held_think(level.BUTTON_ATTACK);
    self._attack_button_think_threaded = true;
  }
  return self._holding_button[level.BUTTON_ATTACK];
}

use_button_pressed() {
  return (self UseButtonPressed());
}

ads_button_pressed() {
  return (self AdsButtonPressed());
}

attack_button_pressed() {
  return (self AttackButtonPressed());
}

init_button_wrappers() {
  if(!isDefined(level._button_funcs)) {
    level.BUTTON_USE = 0;
    level.BUTTON_ADS = 1;
    level.BUTTON_ATTACK = 2;
    level._button_funcs[level.BUTTON_USE] = ::use_button_pressed;
    level._button_funcs[level.BUTTON_ADS] = ::ads_button_pressed;
    level._button_funcs[level.BUTTON_ATTACK] = ::attack_button_pressed;
  }
}

play_movie_on_surface(movie_name, is_looping, is_in_memory, start_on_notify, notify_when_done, notify_offset) {
  level endon("stop_movie");
  if(!isDefined(level.flag["movie_loaded"])) {
    flag_init("movie_loaded");
  }
  if(!isDefined(is_looping)) {
    is_looping = false;
  }
  if(!isDefined(is_in_memory)) {
    is_in_memory = true;
  }
  if(!isDefined(notify_offset) || notify_offset < .3) {
    notify_offset = .3;
  }
  level thread load_movie(movie_name, is_looping, is_in_memory, isDefined(start_on_notify));
  if(isDefined(start_on_notify)) {
    level waittill(start_on_notify);
  }
  playsoundatposition(movie_name + "_movie", (0, 0, 0));
  flag_wait("movie_loaded");
  Pause3DCinematic(false);
  waittill_movie_done(notify_when_done, notify_offset, is_looping);
  flag_clear("movie_loaded");
}

start_movie_scene() {
  level notify("kill_scene_subs_thread");
  level._scene_subs = [];
}

add_scene_line(scene_line, time, duration) {
  if(!isDefined(level._scene_subs)) {
    level._scene_subs = [];
  }
  sl = spawnStruct();
  sl.line = scene_line;
  sl.time = time;
  sl.duration = duration;
  for(i = 0; i < level._scene_subs.size; i++) {
    if(time < level._scene_subs[i].time) {
      PrintLn("** ERROR:Cannot add an earlier line after a later one.Times must always increase.");
      return;
    }
  }
  level._scene_subs[level._scene_subs.size] = sl;
}

sub_fade(alpha, duration) {
  self notify("kill_fade");
  self endon("kill_fade");
  if(alpha == 1) {
    self.alpha = 0;
  }
  self fadeOverTime(duration);
  self.alpha = alpha;
  wait(duration);
}

do_scene_sub(sub_string, duration) {
  if(!GetDvarInt(#"cg_subtitles"))
    return;
  if(!isDefined(level.vo_hud)) {
    level.vo_hud = NewHudElem();
    level.vo_hud.fontscale = 2;
    level.vo_hud.horzAlign = "center";
    level.vo_hud.vertAlign = "middle";
    level.vo_hud.alignX = "center";
    level.vo_hud.alignY = "middle";
    level.vo_hud.y = 180;
    level.vo_hud.sort = 0;
  }
  fade_duration = 0.2;
  level.vo_hud thread sub_fade(1, fade_duration);
  old_scale = level.vo_hud.fontscale;
  level.vo_hud.fontscale = 1.5;
  old_sort = level.vo_hud.sort;
  level.vo_hud.sort = 1;
  level.vo_hud SetText(sub_string);
  wait(duration - fade_duration);
  level.vo_hud sub_fade(0, fade_duration);
  level.vo_hud SetText("");
  level.vo_hud.sort = old_sort;
  level.vo_hud.fontscale = old_scale;
}

playback_scene_subs() {
  if(!isDefined(level._scene_subs)) {
    return;
  }
  level notify("kill_scene_subs_thread");
  level endon("kill_scene_subs_thread");
  scene_start = GetTime();
  for(i = 0; i < level._scene_subs.size; i++) {
    level._scene_subs[i].time = scene_start + (level._scene_subs[i].time * 1000);
  }
  for(i = 0; i < level._scene_subs.size; i++) {
    while(GetTime() < level._scene_subs[i].time) {
      wait(0.05);
    }
    do_scene_sub(level._scene_subs[i].line, level._scene_subs[i].duration);
  }
  level._scene_subs = undefined;
}

play_movie(movie_name, is_looping, is_in_memory, start_on_notify, use_fullscreen_trans, notify_when_done, notify_offset, snapshot) {
  level endon("stop_movie");
  if(!isDefined(level.flag["movie_loaded"])) {
    flag_init("movie_loaded");
  }
  if(!isDefined(level.flag["movie_failed"])) {
    flag_init("movie_failed");
  }
  if(!isDefined(is_looping)) {
    is_looping = false;
  }
  if(!isDefined(is_in_memory)) {
    is_in_memory = true;
  }
  if(!isDefined(notify_offset) || notify_offset < .3) {
    notify_offset = .3;
  }
  if(!isDefined(snapshot)) {
    snapshot = 0;
  }
  fullscreen_trans_in = "none";
  fullscreen_trans_out = "none";
  if(is_true(use_fullscreen_trans)) {
    fullscreen_trans_in = "white";
    fullscreen_trans_out = "white";
    if(isDefined(level.movie_trans_in)) {
      fullscreen_trans_in = level.movie_trans_in;
    }
    if(isDefined(level.movie_trans_out)) {
      fullscreen_trans_out = level.movie_trans_out;
    }
  }
  level thread load_movie(movie_name, is_looping, is_in_memory, isDefined(start_on_notify));
  if(isDefined(start_on_notify)) {
    level waittill(start_on_notify);
  }
  level thread playback_scene_subs();
  level thread handle_movie_dvars();
  vision_set = movie_fade_in(movie_name, fullscreen_trans_in);
  hud = start_movie(movie_name, fullscreen_trans_in);
  if(flag("movie_failed")) {
    if(isDefined(notify_when_done)) {
      wait .05;
      level notify(notify_when_done);
      if(isDefined(notify_offset)) {
        wait notify_offset;
      }
    }
  } else {
    waittill_movie_done(notify_when_done, notify_offset, is_looping);
  }
  clientNotify("pmo");
  flag_clear("movie_loaded");
  flag_clear("movie_failed");
  level.movie_trans_in = undefined;
  level.movie_trans_out = undefined;
  if(isDefined(hud)) {
    hud Destroy();
  }
  level thread movie_fade_out(movie_name, vision_set, fullscreen_trans_out);
  level waittill_notify_or_timeout("cine_notify", 1);
}

handle_movie_dvars() {
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    players[i]._hud_dvars = [];
    players[i]._hud_dvars["cl_scoreDraw"] = Int(getDvar("cl_scoreDraw"));
    players[i]._hud_dvars["compass"] = Int(getDvar("compass"));
    players[i]._hud_dvars["hud_showstance"] = Int(getDvar("hud_showstance"));
    players[i]._hud_dvars["actionSlotsHide"] = Int(getDvar("actionSlotsHide"));
    players[i]._hud_dvars["ammoCounterHide"] = Int(getDvar("ammoCounterHide"));
    players[i]._hud_dvars["cg_cursorHints"] = Int(getDvar("cg_cursorHints"));
    players[i]._hud_dvars["hud_showobjectives"] = Int(getDvar("hud_showobjectives"));
    players[i]._hud_dvars["cg_drawFriendlyNames"] = Int(getDvar("cg_drawfriendlynames"));
    players[i] SetClientDvars("cl_scoreDraw", 0, "compass", 0, "hud_showstance", 0, "actionSlotsHide", 1, "ammoCounterHide", 1, "cg_cursorHints", 0, "hud_showobjectives", 0, "cg_drawfriendlynames", 0);
  }
  flag_wait("movie_loaded");
  waittill_either("movie_loaded", "stop_movie");
  PrintLn("play_movie: resetting play movie dvars.");
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    keys = GetArrayKeys(players[i]._hud_dvars);
    players[i] SetClientDvars(keys[0], players[i]._hud_dvars[keys[0]], keys[1], players[i]._hud_dvars[keys[1]], keys[2], players[i]._hud_dvars[keys[2]], keys[3], players[i]._hud_dvars[keys[3]], keys[4], players[i]._hud_dvars[keys[4]], keys[5], players[i]._hud_dvars[keys[5]], keys[6], players[i]._hud_dvars[keys[6]], keys[7], players[i]._hud_dvars[keys[7]]);
  }
}

load_movie(movie_name, is_looping, is_in_memory, paused) {
  level endon("stop_movie");
  Start3DCinematic(movie_name, is_looping, is_in_memory);
  level thread load_movie_failsafe();
  level waittill("cine_notify", num);
  if(num == -1) {
    flag_set("movie_failed");
  } else if(is_true(paused)) {
    Pause3DCinematic(true);
  }
  flag_set("movie_loaded");
}

load_movie_failsafe() {
  level endon("cine_notify");
  wait 10;
  Stop3DCinematic();
  level notify("cine_notify", -1);
}

start_movie(movie_name, fullscreen_trans) {
  flag_wait("movie_loaded");
  hud = undefined;
  if(!isDefined(level.fullscreen_cin_hud)) {
    hud = create_movie_hud(fullscreen_trans);
  }
  if(!flag("movie_failed")) {
    PlaySoundAtPosition(movie_name + "_movie", (0, 0, 0));
    Pause3DCinematic(false);
  }
  return hud;
}

stop_movie() {
  level endon("movie_loaded");
  level notify("stop_movie");
  Stop3DCinematic();
  flag_clear("movie_loaded");
}

create_movie_hud(fullscreen_trans) {
  movie_hud = NewHudElem();
  movie_hud.x = 0;
  movie_hud.y = 0;
  movie_hud.horzAlign = "fullscreen";
  movie_hud.vertAlign = "fullscreen";
  movie_hud.foreground = false;
  movie_hud.sort = 0;
  movie_hud.alpha = 1;
  if(!is_true(level.flag["movie_failed"])) {
    movie_hud SetShader("cinematic", 640, 480);
  } else {
    if(fullscreen_trans == "black") {
      movie_hud SetShader("black", 640, 480);
    } else {
      movie_hud SetShader("white", 640, 480);
    }
  }
  movie_hud thread destroy_when_movie_is_stopped();
  return movie_hud;
}

destroy_when_movie_is_stopped() {
  level endon("movie_loaded");
  level waittill("stop_movie");
  if(isDefined(self)) {
    self Destroy();
  }
}

movie_fade_in(movie_name, fullscreen_trans) {
  level endon("stop_movie");
  current_vision_set = "";
  if(fullscreen_trans != "none") {
    fade_hud = NewHudElem();
    PlaySoundAtPosition(movie_name + "_fade_in", (0, 0, 0));
    FADE_IN = .5;
    if(isDefined(level.movie_fade_in_time)) {
      FADE_IN = level.movie_fade_in_time;
    }
    switch (fullscreen_trans) {
      case "white": {
        current_vision_set = get_players()[0] getvisionSetNaked();
        visionSetNaked("int_frontend_char_trans", FADE_IN);
        break;
      }
      case "whitehud": {
        fade_hud.x = 0;
        fade_hud.y = 0;
        fade_hud.horzAlign = "fullscreen";
        fade_hud.vertAlign = "fullscreen";
        fade_hud.foreground = false;
        fade_hud.sort = 0;
        fade_hud.alpha = 0;
        fade_hud SetShader("white", 640, 480);
        fade_hud FadeOverTime(FADE_IN);
        fade_hud.alpha = 1;
        break;
      }
      case "black": {
        fade_hud.x = 0;
        fade_hud.y = 0;
        fade_hud.horzAlign = "fullscreen";
        fade_hud.vertAlign = "fullscreen";
        fade_hud.foreground = false;
        fade_hud.sort = 0;
        fade_hud.alpha = 0;
        fade_hud SetShader("black", 640, 480);
        fade_hud FadeOverTime(FADE_IN);
        fade_hud.alpha = 1;
        break;
      }
    }
    wait FADE_IN;
    fade_hud Destroy();
  }
  return current_vision_set;
}

movie_fade_out(movie_name, vision_set, fullscreen_trans) {
  level endon("stop_movie");
  if(fullscreen_trans != "none") {
    fade_hud = NewHudElem();
    PlaySoundAtPosition(movie_name + "_fade_out", (0, 0, 0));
    FADE_OUT = .5;
    if(isDefined(level.movie_fade_out_time)) {
      FADE_OUT = level.movie_fade_out_time;
    }
    switch (fullscreen_trans) {
      case "white": {
        current_vision_set = get_players()[0] getvisionSetNaked();
        if(current_vision_set != "int_frontend_char_trans") {
          vision_set = current_vision_set;
        }
        visionSetNaked("int_frontend_char_trans", 0);
        wait .1;
        visionSetNaked(vision_set, FADE_OUT);
        break;
      }
      case "whitehud": {
        fade_hud.x = 0;
        fade_hud.y = 0;
        fade_hud.horzAlign = "fullscreen";
        fade_hud.vertAlign = "fullscreen";
        fade_hud.foreground = false;
        fade_hud.sort = 0;
        fade_hud.alpha = 1;
        fade_hud SetShader("white", 640, 480);
        fade_hud FadeOverTime(FADE_OUT);
        fade_hud.alpha = 0;
        break;
      }
      case "black": {
        fade_hud.x = 0;
        fade_hud.y = 0;
        fade_hud.horzAlign = "fullscreen";
        fade_hud.vertAlign = "fullscreen";
        fade_hud.foreground = false;
        fade_hud.sort = 0;
        fade_hud.alpha = 1;
        fade_hud SetShader("black", 640, 480);
        fade_hud FadeOverTime(FADE_OUT);
        fade_hud.alpha = 0;
        current_vision_set = get_players()[0] getvisionSetNaked();
        if(current_vision_set == "int_frontend_char_trans") {
          visionSetNaked(vision_set, 0);
        }
        break;
      }
    }
    wait FADE_OUT;
    fade_hud Destroy();
  }
}

waittill_movie_done(notify_when_done, notify_offset, is_looping) {
  level endon("stop_movie");
  cutoff_time = 0.2;
  if(is_true(is_looping)) {
    level waittill("stop_movie");
  }
  timeleft = GetCinematicTimeRemaining();
  PrintLn(timeleft);
  counter = 0;
  while((timeleft < 0.05) && counter < 100) {
    wait 0.05;
    counter++;
    timeleft = GetCinematicTimeRemaining();
    PrintLn(timeleft);
  }
  oldtimeleft = GetCinematicTimeRemaining();
  AssertEx(counter < 100, "Error: Bink movie never started playing even 5 seconds after calling waittill_movie_done");
  if((counter >= 100) && isDefined(notify_when_done)) {
    level notify(notify_when_done);
  }
  while(timeleft >= cutoff_time) {
    if(isDefined(notify_when_done) && (timeleft <= notify_offset)) {
      level notify(notify_when_done);
    }
    wait 0.05;
    timeleft = GetCinematicTimeRemaining();
    PrintLn(timeleft);
    if(timeleft < oldtimeleft) {
      oldtimeleft = timeleft;
    } else {
      timeleft -= 0.05;
    }
  }
  if(isDefined(notify_when_done)) {
    level notify(notify_when_done);
  }
}

wont_disable_player_firing() {
  if(!isDefined(self)) {
    return;
  }
  self.NoFriendlyfire = true;
  self.ignoreforfriendlyfire = 1;
}

allow_divetoprone(allowed) {
  if(!isDefined(allowed)) {
    return;
  }
  SetDvar("dtp", allowed);
}

waittill_player_shoots(weapon_type, ender) {
  if(isDefined(ender)) {
    self endon(ender);
  }
  if(!isDefined(weapon_type)) {
    weapon_type = "any";
  }
  while(1) {
    self waittill("weapon_fired");
    gun = self GetCurrentWeapon();
    if(weapon_type == "any") {
      return gun;
    } else if(weapon_type == "silenced") {
      if(IsSubStr(gun, "silencer")) {
        return gun;
      }
    } else {
      if(!IsSubStr(gun, "silencer")) {
        return gun;
      }
    }
    continue;
  }
}