/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\_utility.gsc
***************************************************/

#include common_scripts\utility;
#include animscripts\utility;
#include maps\_utility_code;

set_HudOutline(sType, depth_enable) {
  num = undefined;

  AssertEx(isDefined(sType) && IsString(sType), "set_HudOutline() needs a string! Use 'friendly', 'enemy', 'objective', or 'neutral' ");
  AssertEx(isDefined(depth_enable), "set_HudOutline() needs to specify whether or not depth testing should be enabled");

  sType = ToLower(sType);
  array["friendly"] = 3;
  array["enemy"] = 4;
  array["objective"] = 5;
  array["neutral"] = 0;

  AssertEx(isDefined(array[sType]), "set_hudOutline() called with invalid type. Use 'friendly', 'enemy', 'objective', or 'neutral' ");

  num = array[sType];

  self HudOutlineEnable(num, depth_enable);
}

is_coop() {
  if(IsSplitScreen() || (GetDvar("coop") == "1")) {
    AssertEx(isDefined(level.player2), "In co-op mode but level.player2 is undefined. IsSplitScreen=" + IsSplitScreen() + " coop dvar=" + GetDvar("coop"));
    return true;
  }

  return false;
}

is_coop_online() {
  if(issplitscreen()) {
    return false;
  }

  if(!is_coop()) {
    return false;
  }

  return true;
}

is_player_down(player) {
  AssertEx(isDefined(player) && IsPlayer(player), "is_player_down() requires a valid player to test.");

  if(player ent_flag_exist("laststand_downed")) {
    return player ent_flag("laststand_downed");
  }

  if(isDefined(player.laststand)) {
    return player.laststand;
  }

  return !IsAlive(player);
}

is_player_down_and_out(player) {
  assertex(isDefined(player) && isplayer(player), "is_player_down_and_out() requires a valid player to test.");

  if(!isDefined(player.down_part2_proc_ran)) {
    return false;
  }

  return player.down_part2_proc_ran;
}

killing_will_down(player) {
  AssertEx(isDefined(player) && IsPlayer(player), "Invalid player.");

  if(laststand_enabled()) {
    AssertEx(isDefined(level.laststand_initialized) && isDefined(level.laststand_kill_will_down_func), "Laststand not initialized.");

    if(isDefined(level.laststand_kill_will_down_func)) {
      return player[[level.laststand_kill_will_down_func]]();
    }
  }

  return false;
}

is_survival() {
  return (is_specialop() && (GetDvarInt("so_survival") > 0));
}

laststand_enabled() {
  return isDefined(level.laststand_type) && level.laststand_type > 0;
}

is_specialop() {
  return GetDvarInt("specialops") >= 1;
}

convert_to_time_string(timer, show_tenths) {
  string = "";
  if(timer < 0) {
    string += "-";
  }

  timer = round_float(timer, 1, false);

  timer_clipped = timer * 100;
  timer_clipped = int(timer_clipped);
  timer_clipped = abs(timer_clipped);

  minutes = timer_clipped / 6000;
  minutes = int(minutes);
  string += minutes;

  seconds = timer_clipped / 100;
  seconds = int(seconds);
  seconds -= minutes * 60;
  if(seconds < 10) {
    string += ":0" + seconds;
  } else {
    string += ":" + seconds;
  }

  if(isDefined(show_tenths) && show_tenths) {
    tenths = timer_clipped;
    tenths -= minutes * 6000;
    tenths -= seconds * 100;
    tenths = int(tenths / 10);
    string += "." + tenths;
  }

  return string;
}

round_float(value, precision, down) {
  AssertEx(isDefined(value), "value must be defined.");
  AssertEx(isDefined(precision), "precision must be defined.");
  AssertEx(precision == int(precision), "precision must be an integer.");

  precision = int(precision);

  if(precision < 0 || precision > 4) {
    AssertMsg("Precision value must be an integer that is >= 0 and <= 4. This was passed in: " + precision);
    return value;
  }

  decimal_offset = 1;
  for(i = 1; i <= precision; i++) {
    decimal_offset *= 10;
  }

  value_clipped = value * decimal_offset;

  if(!isDefined(down) || down) {
    value_clipped = floor(value_clipped);
  } else {
    value_clipped = ceil(value_clipped);
  }

  value = value_clipped / decimal_offset;

  return value;
}

round_millisec_on_sec(value, precision, down) {
  value_seconds = value / 1000;

  value_seconds = round_float(value_seconds, precision, down);

  value = value_seconds * 1000;

  return int(value);
}

set_vision_set(visionset, transition_time) {
  if(init_vision_set(visionset)) {
    return;
  }

  if(!isDefined(transition_time)) {
    transition_time = 1;
  }

  VisionSetNaked(visionset, transition_time);
  SetDvar("vision_set_current", visionset);
}

set_vision_set_player(visionset, transition_time) {
  if(init_vision_set(visionset)) {
    return;
  }

  Assert(isDefined(self));
  Assert(level != self);

  if(!isDefined(transition_time)) {
    transition_time = 1;
  }
  self VisionSetNakedForPlayer(visionset, transition_time);
}

sun_light_fade(startSunColor, endSunColor, fTime) {
  fTime = Int(fTime * 20);

  increment = [];
  for(i = 0; i < 3; i++) {
    increment[i] = (startSunColor[i] - endSunColor[i]) / fTime;
  }

  newSunColor = [];
  for(i = 0; i < fTime; i++) {
    wait(0.05);
    for(j = 0; j < 3; j++) {
      newSunColor[j] = startSunColor[j] - (increment[j] * i);
    }
    SetSunLight(newSunColor[0], newSunColor[1], newSunColor[2]);
  }

  SetSunLight(endSunColor[0], endSunColor[1], endSunColor[2]);
}

ent_flag_wait(msg) {
  AssertEx((!IsSentient(self) && isDefined(self)) || IsAlive(self), "Attempt to check a flag on entity that is not alive or removed");

  while(isDefined(self) && !self.ent_flag[msg]) {
    self waittill(msg);
  }
}

ent_flag_wait_vehicle_node(msg) {
  AssertEx(isDefined(self), "Attempt to check a flag on node that is is not defined");

  while(isDefined(self) && !self.ent_flag[msg]) {
    self waittill(msg);
  }
}

ent_flag_wait_either(flag1, flag2) {
  AssertEx((!IsSentient(self) && isDefined(self)) || IsAlive(self), "Attempt to check a flag on entity that is not alive or removed");

  while(isDefined(self)) {
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
  AssertEx((!IsSentient(self) && isDefined(self)) || IsAlive(self), "Attempt to check a flag on entity that is not alive or removed");

  start_time = GetTime();
  while(isDefined(self)) {
    if(self.ent_flag[flagname]) {
      break;
    }

    if(GetTime() >= start_time + timer * 1000) {
      break;
    }

    self ent_wait_for_flag_or_time_elapses(flagname, timer);
  }
}

ent_flag_waitopen(msg) {
  AssertEx((!IsSentient(self) && isDefined(self)) || IsAlive(self), "Attempt to check a flag on entity that is not alive or removed");

  while(isDefined(self) && self.ent_flag[msg]) {
    self waittill(msg);
  }
}

ent_flag_assert(msg) {
  AssertEx(!self ent_flag(msg), "Flag " + msg + " set too soon on entity");
}

ent_flag_waitopen_either(flag1, flag2) {
  AssertEx((!IsSentient(self) && isDefined(self)) || IsAlive(self), "Attempt to check a flag on entity that is not alive or removed");

  while(isDefined(self)) {
    if(!ent_flag(flag1)) {
      return;
    }
    if(!ent_flag(flag2)) {
      return;
    }

    self waittill_either(flag1, flag2);
  }
}

ent_flag_init(message) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }

  if(isDefined(level.first_frame) && level.first_frame == -1) {
    AssertEx(!isDefined(self.ent_flag[message]), "Attempt to reinitialize existing message: " + message + " on entity.");
  }

  self.ent_flag[message] = false;

  self.ent_flags_lock[message] = false;
}

ent_flag_exist(message) {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag[message])) {
    return true;
  }
  return false;
}

ent_flag_set_delayed(message, delay) {
  self endon("death");

  wait(delay);
  self ent_flag_set(message);
}

ent_flag_set(message) {
  AssertEx(isDefined(self), "Attempt to set a flag on entity that is not defined");
  AssertEx(isDefined(self.ent_flag[message]), "Attempt to set a flag before calling flag_init: " + message + " on entity.");
  Assert(self.ent_flag[message] == self.ent_flags_lock[message]);
  self.ent_flags_lock[message] = true;

  self.ent_flag[message] = true;
  self notify(message);
}

ent_flag_clear(message, remove) {
  AssertEx(isDefined(self), "Attempt to clear a flag on entity that is not defined");
  AssertEx(isDefined(self.ent_flag[message]), "Attempt to set a flag before calling flag_init: " + message + " on entity.");
  Assert(self.ent_flag[message] == self.ent_flags_lock[message]);
  self.ent_flags_lock[message] = false;

  if(self.ent_flag[message]) {
    self.ent_flag[message] = false;
    self notify(message);
  }

  if(isDefined(remove) && remove) {
    self.ent_flag[message] = undefined;

    self.ent_flags_lock[message] = undefined;
  }
}

ent_flag_clear_delayed(message, delay) {
  wait(delay);
  self ent_flag_clear(message);
}

ent_flag(message) {
  AssertEx(isDefined(message), "Tried to check flag but the flag was not defined.");
  AssertEx(isDefined(self.ent_flag[message]), "Tried to check flag " + message + " but the flag was not initialized.");

  return self.ent_flag[message];
}

get_closest_to_player_view(array, player, use_eye, min_dot) {
  if(!array.size) {
    return;
  }

  if(!isDefined(player)) {
    player = level.player;
  }

  if(!isDefined(min_dot)) {
    min_dot = -1;
  }

  player_origin = player.origin;
  if(isDefined(use_eye) && use_eye) {
    player_origin = player getEye();
  }

  ent = undefined;

  player_angles = player GetPlayerAngles();
  player_forward = anglesToForward(player_angles);

  dot = -1;
  foreach(array_item in array) {
    angles = VectorToAngles(array_item.origin - player_origin);
    forward = anglesToForward(angles);

    newdot = VectorDot(player_forward, forward);
    if(newdot < dot) {
      continue;
    }
    if(newdot < min_dot) {
      continue;
    }
    dot = newdot;
    ent = array_item;
  }
  return ent;
}

get_closest_index_to_player_view(array, player, use_eye) {
  if(!array.size) {
    return;
  }

  if(!isDefined(player)) {
    player = level.player;
  }

  player_origin = player.origin;
  if(isDefined(use_eye) && use_eye) {
    player_origin = player getEye();
  }

  index = undefined;

  player_angles = player GetPlayerAngles();
  player_forward = anglesToForward(player_angles);

  dot = -1;
  for(i = 0; i < array.size; i++) {
    angles = VectorToAngles(array[i].origin - player_origin);
    forward = anglesToForward(angles);

    newdot = VectorDot(player_forward, forward);
    if(newdot < dot) {
      continue;
    }

    dot = newdot;
    index = i;
  }
  return index;
}

flag_trigger_init(message, trigger, continuous) {
  flag_init(message);

  if(!isDefined(continuous)) {
    continuous = false;
  }

  Assert(IsSubStr(trigger.classname, "trigger"));
  trigger thread _flag_wait_trigger(message, continuous);

  return trigger;
}

flag_triggers_init(message, triggers, all) {
  flag_init(message);

  if(!isDefined(all)) {
    all = false;
  }

  for(index = 0; index < triggers.size; index++) {
    Assert(IsSubStr(triggers[index].classname, "trigger"));
    triggers[index] thread _flag_wait_trigger(message, false);
  }

  return triggers;
}

flag_set_delayed(message, delay) {
  wait(delay);
  flag_set(message);
}

flag_clear_delayed(message, delay) {
  wait(delay);
  flag_clear(message);
}

level_end_save() {
  if(arcadeMode()) {
    return;
  }

  if(level.MissionFailed) {
    return;
  }

  if(flag("game_saving")) {
    return;
  }

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(!isAlive(player)) {
      return;
    }
  }

  flag_set("game_saving");

  imagename = "levelshots / autosave / autosave_" + level.script + "end";

  SaveGame("levelend", &"AUTOSAVE_AUTOSAVE", imagename, true, true);

  flag_clear("game_saving");
}

add_extra_autosave_check(name, func, msg) {
  level._extra_autosave_checks[name] = [];
  level._extra_autosave_checks[name]["func"] = func;
  level._extra_autosave_checks[name]["msg"] = msg;
}

remove_extra_autosave_check(name) {
  level._extra_autosave_checks[name] = undefined;
}

autosave_stealth() {
  thread autosave_by_name_thread("autosave_stealth", 8, true);
}

autosave_stealth_silent() {
  thread autosave_by_name_thread("autosave_stealth", 8, true, true);
}

autosave_tactical() {
  autosave_tactical_setup();
  thread autosave_tactical_proc();
}

autosave_by_name(name) {
  thread autosave_by_name_thread(name);
}

autosave_by_name_silent(name) {
  thread autosave_by_name_thread(name, undefined, undefined, true);
}

autosave_by_name_thread(name, timeout, doStealthChecks, suppress_hint) {
  if(!isDefined(level.curAutoSave)) {
    level.curAutoSave = 1;
  }

  imageName = "levelshots/autosave/autosave_" + level.script + level.curAutoSave;
  result = level maps\_autosave::tryAutoSave(level.curAutoSave, "autosave", imagename, timeout, doStealthChecks, suppress_hint);
  if(isDefined(result) && result) {
    level.curAutoSave++;
  }
}

autosave_or_timeout(name, timeout) {
  thread autosave_by_name_thread(name, timeout);
}

debug_message(message, origin, duration, entity) {
  if(!isDefined(duration)) {
    duration = 5;
  }

  if(isDefined(entity)) {
    entity endon("death");
    origin = entity.origin;
  }

  for(time = 0; time < (duration * 20); time++) {
    if(!isDefined(entity)) {
      Print3d((origin + (0, 0, 45)), message, (0.48, 9.4, 0.76), 0.85);
    } else {
      Print3d(entity.origin, message, (0.48, 9.4, 0.76), 0.85);
    }
    wait 0.05;
  }
}

debug_message_ai(message, duration) {
  self notify("debug_message_ai");
  self endon("debug_message_ai");
  self endon("death");

  if(!isDefined(duration)) {
    duration = 5;
  }

  for(time = 0; time < (duration * 20); time++) {
    Print3d((self.origin + (0, 0, 45)), message, (0.48, 9.4, 0.76), 0.85);
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
    Print3d((origin + (0, 0, 45)), message, (0.48, 9.4, 0.76), 0.85);
    wait 0.05;
  }
}

precache(model) {
  ent = spawn("script_model", (0, 0, 0));
  ent.origin = level.player GetOrigin();
  ent setModel(model);
  ent Delete();
}

closerFunc(dist1, dist2) {
  return dist1 >= dist2;
}

fartherFunc(dist1, dist2) {
  return dist1 <= dist2;
}

getClosestFx(org, fxarray, dist) {
  return compareSizesFx(org, fxarray, dist, ::closerFunc);
}

get_closest_point(origin, points, maxDist) {
  Assert(points.size);

  closestPoint = points[0];
  dist = Distance(origin, closestPoint);

  for(index = 0; index < points.size; index++) {
    testDist = Distance(origin, points[index]);
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

get_farthest_ent(org, array) {
  if(array.size < 1) {
    return;
  }

  dist = Distance(array[0] GetOrigin(), org);
  ent = array[0];
  for(i = 0; i < array.size; i++) {
    newdist = Distance(array[i] GetOrigin(), org);
    if(newdist < dist) {
      continue;
    }
    dist = newdist;
    ent = array[i];
  }
  return ent;
}

get_within_range(org, array, dist) {
  guys = [];
  for(i = 0; i < array.size; i++) {
    if(Distance(array[i].origin, org) <= dist) {
      guys[guys.size] = array[i];
    }
  }
  return guys;
}

get_outside_range(org, array, dist) {
  guys = [];
  for(i = 0; i < array.size; i++) {
    if(Distance(array[i].origin, org) > dist) {
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
    newdist = Distance(array[i].origin, org);
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

  foreach(member in array) {
    angles = VectorToAngles(member.origin - start);
    forward = anglesToForward(angles);

    newdot = VectorDot(dotforward, forward);
    if(newdot < dot) {
      continue;
    }
    dot = newdot;
    ent = member;
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
  foreach(i, ent in array) {
    newdist = Distance(ent.origin, org);
    if(newdist >= dist) {
      continue;
    }
    dist = newdist;
    index = i;
  }
  return index;
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
      for(p = 0; p < excluders.size; p++)
    }
    if(ents[i] == excluders[p]) {
      exclude[i] = true;
    }

    found_unexcluded = false;
    for(i = 0; i < ents.size; i++) {
      if((!exclude[i]) && (isDefined(ents[i]))) {}
      found_unexcluded = true;
      range = Distance(org, ents[i].origin);
      ent = i;
      i = ents.size + 1;
    }

    if(!found_unexcluded) {
      return (undefined);
    }
  } else {
    for(i = 0; i < ents.size; i++) {
      if(isDefined(ents[i])) {}
      range = Distance(org, ents[0].origin);
      ent = i;
      i = ents.size + 1;
    }
  }

  ent = undefined;

  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i])) {}
    exclude = false;
    if(isDefined(excluders)) {
      for(p = 0; p < excluders.size; p++) {
        if(ents[i] == excluders[p])
      }
      exclude = true;
    }

    if(!exclude) {
      newrange = Distance(org, ents[i].origin);
      if(newrange <= range) {
        range = newrange;
        ent = i;
      }
    }
  }

  if(isDefined(ent)) {
    return ents[ent];
  } else {
    return undefined;
  }
}

get_closest_player(org) {
  if(level.players.size == 1) {
    return level.player;
  }

  player = getClosest(org, level.players);
  return player;
}

get_closest_player_healthy(org) {
  if(level.players.size == 1) {
    return level.player;
  }

  healthyPlayers = get_players_healthy();

  player = getClosest(org, healthyPlayers);

  return player;
}

get_players_healthy() {
  healthy_players = [];
  foreach(player in level.players) {
    if(is_player_down(player)) {
      continue;
    }

    healthy_players[healthy_players.size] = player;
  }

  return healthy_players;
}

get_closest_ai(org, team, excluders) {
  if(isDefined(team)) {
    ents = GetAIArray(team);
  } else {
    ents = GetAIArray();
  }

  if(ents.size == 0) {
    return undefined;
  }

  if(isDefined(excluders)) {
    Assert(excluders.size > 0);
    ents = array_remove_array(ents, excluders);
  }

  return getClosest(org, ents);
}

get_closest_ai_exclude(org, team, excluders) {
  if(isDefined(team)) {
    ents = GetAIArray(team);
  } else {
    ents = GetAIArray();
  }

  if(ents.size == 0) {
    return undefined;
  }

  return get_closest_exclude(org, ents, excluders);
}

get_progress(start, end, org, dist) {
  if(!isDefined(dist)) {
    dist = Distance(start, end);
  }

  dist = max(0.01, dist);
  normal = vectorNormalize(end - start);
  vec = org - start;
  progress = vectorDot(vec, normal);
  progress = progress / dist;
  progress = clamp(progress, 0, 1);
  return progress;
}

can_see_origin(origin, test_characters) {
  AssertEx(isDefined(origin), "can_see_origin() requires a valid origin to be passed in.");
  AssertEx(IsPlayer(self) || IsAI(self), "can_see_origin() can only be called on a player or AI.");

  if(!isDefined(test_characters)) {
    test_characters = true;
  }

  if(!self point_in_fov(origin)) {
    return false;
  }

  if(!SightTracePassed(self getEye(), origin, test_characters, self)) {
    return false;
  }

  return true;
}

point_in_fov(origin) {
  forward = anglesToForward(self.angles);
  normalVec = VectorNormalize(origin - self.origin);

  dot = VectorDot(forward, normalVec);
  return dot > 0.766;
}

stop_magic_bullet_shield() {
  self notify("stop_magic_bullet_shield");
  AssertEx(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield, "Tried to stop magic bullet shield on a guy without magic bulletshield");

  if(IsAI(self)) {
    self.attackeraccuracy = 1;
  }

  self.magic_bullet_shield = undefined;
  self.damageShield = false;

  self notify("internal_stop_magic_bullet_shield");

  self.deletable_magic_bullet_shield = undefined;
}

magic_bullet_death_detection() {
  self endon("internal_stop_magic_bullet_shield");
  export = self.export;
  entnum = self GetEntNum();

  self waittill("death");
  if(isDefined(self)) {
    AssertEx(0, "Magic bullet shield guy with export(" +
    }
    export +") enuNum(" + entnum + ") died some how.");
  else {
    AssertEx(0, "Magic bullet shield guy with export(" +
    }
    export +") enuNum(" + entnum + ") died, most likely deleted from spawning guys.");

  export =
  export;
}

magic_bullet_shield(no_death_detection) {
  AssertEx(!IsPlayer(self), "magic_bullet_shield is only valid for AI. Use EnableInvulnerability, EnableDeathShield or EnableHealthShield for a player");

  if(IsAI(self)) {
    AssertEx(IsAlive(self), "Tried to do magic_bullet_shield on a dead or undefined guy.");
    AssertEx(!self.delayedDeath, "Tried to do magic_bullet_shield on a guy about to die.");
    AssertEx(!isDefined(self.Melee), "Trying to turn on magic_bullet_shield while melee in progress (might be about to die).");
  } else {
    self.health = 100000;
  }

  self endon("internal_stop_magic_bullet_shield");
  AssertEx(!isDefined(self.magic_bullet_shield), "Can't call magic bullet shield on a character twice. Use make_hero and remove_heroes_from_array so that you don't end up with shielded guys in your logic.");

  if(IsAI(self)) {
    self.attackeraccuracy = 0.1;
  }

  if(!isDefined(no_death_detection)) {
    thread magic_bullet_death_detection();
  } else {
    AssertEx(no_death_detection, "no_death_detection must be undefined or true");
    self.deletable_magic_bullet_shield = true;
  }

  self notify("magic_bullet_shield");
  self.magic_bullet_shield = true;
  self.damageShield = true;
  self.noragdoll = true;
}

disable_long_death() {
  AssertEx(IsAlive(self), "Tried to disable long death on a non living thing");
  self.a.disableLongDeath = true;
}

enable_long_death() {
  AssertEx(IsAlive(self), "Tried to enable long death on a non living thing");
  self.a.disableLongDeath = false;
}

enable_blood_pool() {
  self.skipBloodPool = undefined;
}

disable_blood_pool() {
  self.skipBloodPool = true;
}

deletable_magic_bullet_shield() {
  magic_bullet_shield(true);
}

get_ignoreme() {
  return self.ignoreme;
}

set_ignoreme(val) {
  AssertEx(IsSentient(self), "Non ai tried to set ignoreme");
  self.ignoreme = val;
}

set_ignoreall(val) {
  AssertEx(IsSentient(self), "Non ai tried to set ignoraell");
  self.ignoreall = val;
}

set_IgnoreSonicAoE(val) {
  AssertEx(IsSentient(self), "Non ai tried to set IgnoreSonicAoE");
  self.IgnoreSonicAoE = val;
}

set_favoriteenemy(enemy) {
  self.favoriteenemy = enemy;
}

get_pacifist() {
  return self.pacifist;
}

set_pacifist(val) {
  AssertEx(IsSentient(self), "Non ai tried to set pacifist");
  self.pacifist = val;
}

ignore_me_timer(time) {
  self notify("new_ignore_me_timer");
  self endon("new_ignore_me_timer");
  self endon("death");

  if(!isDefined(self.ignore_me_timer_prev_value)) {
    self.ignore_me_timer_prev_value = self.ignoreme;
  }

  ai = GetAIArray("bad_guys");

  foreach(guy in ai) {
    if(!isalive(guy.enemy)) {
      continue;
    }
    if(guy.enemy != self) {
      continue;
    }

    guy ClearEnemy();
  }

  self.ignoreme = true;
  wait(time);

  self.ignoreme = self.ignore_me_timer_prev_value;
  self.ignore_me_timer_prev_value = undefined;
}

delete_exploder(num) {
  common_scripts\_exploder::delete_exploder_proc(num);
}

hide_exploder_models(num) {
  common_scripts\_exploder::hide_exploder_models_proc(num);
}

show_exploder_models(num) {
  common_scripts\_exploder::show_exploder_models_proc(num);
}

stop_exploder(num) {
  common_scripts\_exploder::stop_exploder_proc(num);
}

get_exploder_array(msg) {
  return common_scripts\_exploder::get_exploder_array_proc(msg);
}

flood_spawn(spawners) {
  maps\_spawner::flood_spawner_scripted(spawners);
}

set_ambient(track, fade) {
  soundscripts\_audio_zone_manager::AZM_start_zone(track, fade);
}

force_crawling_death(angle, num_crawls, array, nofallanim) {
  if(!isDefined(num_crawls)) {
    num_crawls = 4;
  }

  self thread force_crawling_death_proc(angle, num_crawls, array, nofallanim);
}

#using_animtree("generic_human");
override_crawl_death_anims() {
  if(isDefined(self.a.custom_crawling_death_array)) {
    self.a.array["crawl"] = self.a.custom_crawling_death_array["crawl"];
    self.a.array["death"] = self.a.custom_crawling_death_array["death"];
    self.a.crawl_fx_rate = self.a.custom_crawling_death_array["blood_fx_rate"];
    if(isDefined(self.a.custom_crawling_death_array["blood_fx"])) {
      self.a.crawl_fx = self.a.custom_crawling_death_array["blood_fx"];
    }
  }

  self.a.array["stand_2_crawl"] = [];
  self.a.array["stand_2_crawl"][0] = % dying_stand_2_crawl_v3;

  if(isDefined(self.nofallanim)) {
    self.a.pose = "prone";
  }

  self OrientMode("face angle", self.a.force_crawl_angle);
  self.a.force_crawl_angle = undefined;
}

force_crawling_death_proc(angle, num_crawls, array, nofallanim) {
  self.forceLongDeath = true;
  self.a.force_num_crawls = num_crawls;
  self.noragdoll = true;
  self.nofallanim = nofallanim;

  self.a.custom_crawling_death_array = array;
  self.crawlingPainAnimOverrideFunc = ::override_crawl_death_anims;

  self.maxhealth = 100000;
  self.health = 100000;
  self enable_long_death();

  if(!isDefined(nofallanim) || nofallanim == false) {
    self.a.force_crawl_angle = angle + 181.02;
  } else {
    self.a.force_crawl_angle = angle;
    self thread animscripts\notetracks::noteTrackPoseCrawl();
  }
}

never_saw_it_coming() {
  self endon("death");
  while(1) {
    highJump = self IsHighJumping();

    if(highJump) {
      exododge = self waittill_any_return("exo_dodge", "player_boost_land", "disable_high_jump");
      if(!isDefined(exododge) || (exododge == "player_boost_land" || exododge == "disable_high_jump")) {
        continue;
      }
      if(!isDefined(self.never_saw_it_coming)) {
        self.never_saw_it_coming = true;
      }
      self waittill_any("player_boost_land", "disable_high_jump");
      waitframe;
      self.never_saw_it_coming = undefined;
    }
    waitframe;
  }
}

check_man_overboard() {
  if(GetDvar("mapname", "undefined") != "sanfran_b") {
    return;
  }
  if(!isDefined(level.player.man_overboard) || !level.player.man_overboard) {
    level.player.man_overboard = true;
  }

  wait(2.0);

  level.player.man_overboard = undefined;
}

monitor_genius_achievement(attacker, type, weapon) {
  if(type != "MOD_GRENADE") {
    attacker.genius_achievement = undefined;
    return;
  }

  if(!isDefined(attacker.genius_achievement)) {
    attacker.genius_achievement = 1;
  } else {
    attacker.genius_achievement++;
  }

  if(attacker.genius_achievement == 4) {
    giveachievement_wrapper("SMART_GRENADE_KILL");
  }

  wait(0.1);
  attacker.genius_achievement = undefined;
}

start_monitor_escape_artist() {
  add_global_spawn_function("axis", ::monitor_escape_artist);
  array_thread(GetAIArray("axis"), ::monitor_escape_artist);

  level.grenade_id = 0;
  level.player.escape_artist = [];
}

monitor_escape_artist() {
  while(1) {
    grenade = undefined;
    self waittill("grenade_fire", grenade, weaponname);
    grenade.unique_id = level.grenade_id;
    level.grenade_id++;
    grenade.owner = self.unique_id;
    grenade thread escape_artist_distance();
    grenade thread escape_artist();
  }
}

escape_artist_distance() {
  player = level.player;
  id = self.unique_id;
  while(isDefined(self)) {
    grenadeOffset = player.origin - self.origin;

    range = GetWeaponExplosionRadius("fraggrenade") + 23;

    rangeSq = squared(range);
    grenadeOffsetSq = LengthSquared(grenadeOffset);

    if(grenadeOffsetSq > rangeSq) {
      if(isDefined(player.escape_artist[self.unique_id])) {
        player.escape_artist[self.unique_id] = undefined;
      }
    } else {
      if(!isDefined(player.escape_artist[self.unique_id])) {
        if(isDefined(self.owner))
      }
      player.escape_artist[self.unique_id] = true;
    }
    waitframe;
  }
  if(isDefined(player.escape_artist[id])) {
    player.escape_artist[id] = undefined;
  }
}

escape_artist() {
  player = level.player;
  while(isDefined(self)) {
    if(isDefined(player.escape_artist[self.unique_id])) {
      msg = level.player waittill_any_timeout(4, "exo_dodge");
      if(isDefined(msg) && msg == "exo_dodge") {
        self thread check_grenade_dmg();
      }
    } else {
      waitframe;
    }
  }
}

check_grenade_dmg() {
  level.player endon("death");
  while(isDefined(self)) {
    msg = level.player waittill_dmg_timeout(1, "damage");

    if(isDefined(msg) && IsArray(msg)) {
      if(msg[5] == "MOD_GRENADE_SPLASH" && !isDefined(level.player.escape_artist_failure)) {
        if(msg[2].unique_id == self.owner && isDefined(level.player.escape_artist[self.unique_id]))
      }
      level.player.escape_artist_failure = true;
    } else {
      waitframe;
    }
  }

  if(!isDefined(level.player.escape_artist_failure)) {
    level.player escape_artist_success();
  } else {
    level.player.escape_artist_failure = undefined;
  }
}

escape_artist_success() {
  escapee = self GetLocalPlayerProfileData("ach_escapeArtist") + 1;
  if(escapee == 20) {
    giveachievement_wrapper("GRENADE_DODGE");
  }
  self SetLocalPlayerProfileData("ach_escapeArtist", escapee);
}

waittill_dmg_timeout(timeOut, string1) {
  if((!isDefined(string1) || string1 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    self childthread waittill_string_parms(string1, ent);
  }

  ent childthread _timeout(timeOut);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

shock_ondeath() {
  Assert(IsPlayer(self));

  PreCacheShellShock("default");
  self waittill("death");

  if(isDefined(self.specialDeath)) {
    return;
  }

  if(GetDvar("r_texturebits") == "16") {
    return;
  }
  self ShellShock("default", 3);
}

playerwatch_unresolved_collision() {
  self endon("death");
  self endon("stop_unresolved_collision_script");

  self reset_unresolved_collision_handler();
  self childthread playerwatch_unresolved_collision_count();

  while(1) {
    if(self.unresolved_collision) {
      self.unresolved_collision = false;
      if(self.unresolved_collision_count >= 20) {
        if(isDefined(self.handle_unresolved_collision)) {
          self[[self.handle_unresolved_collision]]();
        } else {
          self default_unresolved_collision_handler();
        }
      }
    } else {
      self reset_unresolved_collision_handler();
    }

    wait 0.05;
  }
}

playerwatch_unresolved_collision_count() {
  while(1) {
    self waittill("unresolved_collision");
    self.unresolved_collision = true;
    self.unresolved_collision_count++;
  }
}

reset_unresolved_collision_handler() {
  self.unresolved_collision = false;
  self.unresolved_collision_count = 0;
}

default_unresolved_collision_handler() {
  nodes = GetNodesInRadiusSorted(self.origin, 300, 0, 200, "Path");
  if(nodes.size) {
    self CancelMantle();
    self DontInterpolate();
    self SetOrigin(nodes[0].origin);
    self reset_unresolved_collision_handler();
  } else {
    PrintLn("^3Warning! killing player for unresolved_collision, could not find pathnode.");
    self kill();
  }
}

stop_playerwatch_unresolved_collision() {
  self notify("stop_unresolved_collision_script");
  self reset_unresolved_collision_handler();
}

delete_on_death_wait_sound(ent, sounddone) {
  ent endon("death");
  self waittill("death");
  if(isDefined(ent)) {
    if(ent IsWaitingOnSound()) {
      ent waittill(sounddone);
    }

    ent Delete();
  }
}

is_dead_sentient() {
  return IsSentient(self) && !isalive(self);
}

play_sound_on_tag(alias, tag, ends_on_death, op_notify_string, radio_dialog) {
  if(is_dead_sentient()) {
    return;
  }

  if(!SoundExists(alias)) {
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

  if(isDefined(level.player_radio_emitter) && (self == level.player_radio_emitter)) {
    PrintLn("**dialog alias playing radio: " + alias);
  }

  org playSound(alias, "sounddone");
  if(isDefined(ends_on_death)) {
    AssertEx(ends_on_death, "ends_on_death must be true or undefined");
    if(!isDefined(wait_for_sounddone_or_death(org))) {
      org StopSounds();
    }
    wait(0.05);
  } else {
    org waittill("sounddone");
  }
  if(isDefined(op_notify_string)) {
    self notify(op_notify_string);
  }
  org Delete();
}

play_sound_on_tag_endon_death(alias, tag) {
  play_sound_on_tag(alias, tag, true);
}

play_sound_on_entity(alias, op_notify_string) {
  AssertEx(!isSpawner(self), "Spawner tried to play a sound");

  play_sound_on_tag(alias, undefined, undefined, op_notify_string);
}

play_loop_sound_on_tag(alias, tag, bStopSoundOnDeath, bStopSoundOnRemoved) {
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");

  if(!isDefined(bStopSoundOnDeath)) {
    bStopSoundOnDeath = true;
  }
  if(bStopSoundOnDeath) {
    thread delete_on_death(org);
  }

  if(!isDefined(bStopSoundOnRemoved)) {
    bStopSoundOnRemoved = false;
  }
  if(bStopSoundOnRemoved) {
    thread delete_on_removed(org);
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
  org StopLoopSound(alias);
  org Delete();
}

delete_on_removed(ent) {
  ent endon("death");

  while(isDefined(self)) {
    wait 0.05;
  }

  if(isDefined(ent)) {
    ent Delete();
  }
}

save_friendlies() {
  ai = GetAIArray("allies");
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
  if(!isalive(spawn)) {
    return true;
  }
  if(!isDefined(spawn.finished_spawning)) {
    spawn waittill_either("finished spawning", "death");
  }

  if(IsAlive(spawn)) {
    return false;
  }

  return true;
}

spawn_setcharacter(data) {
  codescripts\character::precache(data);

  self waittill("spawned", spawn);
  if(maps\_utility::spawn_failed(spawn)) {
    return;
  }

  PrintLn("Size is ", data["attach"].size);
  spawn codescripts\character::new();
  spawn codescripts\character::load(data);
}

key_hint_print(message, binding) {
  IPrintLnBold(message, binding["key1"]);
}

view_tag(tag) {
  self endon("death");
  for(;;) {
    maps\_debug::drawTag(tag);
    wait(0.05);
  }
}

assign_animtree(animname) {
  if(isDefined(animname)) {
    self.animname = animname;
  }

  AssertEx(isDefined(level.scr_animtree[self.animname]), "There is no level.scr_animtree for animname " + self.animname);
  self UseAnimTree(level.scr_animtree[self.animname]);
}

assign_model() {
  AssertEx(isDefined(level.scr_model[self.animname]), "There is no level.scr_model for animname " + self.animname);

  if(IsArray(level.scr_model[self.animname])) {
    randIndex = RandomInt(level.scr_model[self.animname].size);
    self setModel(level.scr_model[self.animname][randIndex]);
  } else {
    self setModel(level.scr_model[self.animname]);
  }
}

spawn_anim_model(animname, origin, angles) {
  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }

  model = spawn("script_model", origin);
  model.animname = animname;
  model assign_animtree();
  model assign_model();
  if(isDefined(angles)) {
    model.angles = angles;
  }
  return model;
}

trigger_wait(strName, strKey) {
  eTrigger = GetEnt(strName, strKey);
  if(!isDefined(eTrigger)) {
    AssertMsg("trigger not found: " + strName + " key: " + strKey);
    return;
  }
  eTrigger waittill("trigger", eOther);
  level notify(strName, eOther);
  return eOther;
}

trigger_wait_targetname(strName) {
  return trigger_wait(strName, "targetname");
}

set_flag_on_dead(spawners, strFlag) {
  thread set_flag_on_func_wait_proc(spawners, strFlag, ::waittill_dead, "set_flag_on_dead");
}

set_flag_on_dead_or_dying(spawners, strFlag) {
  thread set_flag_on_func_wait_proc(spawners, strFlag, ::waittill_dead_or_dying, "set_flag_on_dead_or_dying");
}

set_flag_on_spawned(spawners, strFlag) {
  thread set_flag_on_func_wait_proc(spawners, strFlag, ::empty_func, "set_flag_on_spawned");
}

empty_func(var) {
  return;
}

set_flag_on_spawned_ai_proc(system, internal_flag) {
  self waittill("spawned", guy);
  if(maps\_utility::spawn_failed(guy)) {
    return;
  }

  system.ai[system.ai.size] = guy;

  self ent_flag_set(internal_flag);
}

set_flag_on_func_wait_proc(spawners, strFlag, waitfunc, internal_flag) {
  system = spawnStruct();
  system.ai = [];

  AssertEx(spawners.size, "spawners is empty");

  foreach(key, spawn in spawners) {
    spawn ent_flag_init(internal_flag);
  }

  array_thread(spawners, ::set_flag_on_spawned_ai_proc, system, internal_flag);

  foreach(key, spawn in spawners) {
    spawn ent_flag_wait(internal_flag);
  }

  [[waitfunc]](system.ai);
  flag_set(strFlag);
}

set_flag_on_trigger(eTrigger, strFlag) {
  if(!flag(strFlag)) {
    eTrigger waittill("trigger", eOther);
    flag_set(strFlag);
    return eOther;
  }
}

set_flag_on_targetname_trigger(msg) {
  Assert(isDefined(level.flag[msg]));
  if(flag(msg)) {
    return;
  }

  trigger = GetEnt(msg, "targetname");
  trigger waittill("trigger");
  flag_set(msg);
}

is_in_array(aeCollection, eFindee) {
  for(i = 0; i < aeCollection.size; i++) {
    if(aeCollection[i] == eFindee) {
      return (true);
    }
  }

  return (false);
}

waittill_dead(guys, num, timeoutLength) {
  allAlive = true;
  foreach(member in guys) {
    if(IsAlive(member)) {
      continue;
    }
    allAlive = false;
    break;
  }
  AssertEx(allAlive, "Waittill_Dead was called with dead or removed AI in the array, meaning it will never pass.");
  if(!allAlive) {
    newArray = [];
    foreach(member in guys) {
      if(IsAlive(member)) {
        newArray[newArray.size] = member;
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
  foreach(member in guys) {
    if(IsAlive(member) && !member.ignoreForFixedNodeSafeCheck) {
      newArray[newArray.size] = member;
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

waittill_aigroupcleared(aigroup) {
  while(level._ai_group[aigroup].spawnercount || level._ai_group[aigroup].aicount) {
    wait(0.25);
  }
}

waittill_aigroupcount(aigroup, count) {
  while(level._ai_group[aigroup].spawnercount + level._ai_group[aigroup].aicount > count) {
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

waittill_notetrack_or_damage(notetrack) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", notetrack);
}

get_living_ai(name, type) {
  array = get_living_ai_array(name, type);
  if(array.size > 1) {
    AssertMsg("get_living_ai used for more than one living ai of type " + type + " called " + name + ".");
    return undefined;
  }
  return array[0];
}

get_living_ai_array(name, type) {
  ai = GetAISpeciesArray("all", "all");

  array = [];
  foreach(actor in ai) {
    if(!IsAlive(actor)) {
      continue;
    }

    switch (type) {
      case "targetname": {
        if(isDefined(actor.targetname) && actor.targetname == name) {
          array[array.size] = actor;
        }
      }
      break;
      case "script_noteworthy": {
        if(isDefined(actor.script_noteworthy) && actor.script_noteworthy == name) {
          array[array.size] = actor;
        }
      }
      break;
    }
  }
  return array;
}

get_vehicle(name, type) {
  Assert(isDefined(name));
  Assert(isDefined(type));
  array = get_vehicle_array(name, type);
  if(!array.size) {
    return undefined;
  }

  AssertEx(array.size == 1, "tried to get_vehicle() on vehicles with key-pair: " + name + "," + type);
  return array[0];
}

get_vehicle_array(name, type) {
  array = getEntArray(name, type);
  vehicle = [];

  merge_array = [];

  foreach(object in array) {
    if(object.code_classname != "script_vehicle") {
      continue;
    }
    merge_array[0] = object;

    if(IsSpawner(object)) {
      if(isDefined(object.last_spawned_vehicle)) {
        merge_array[0] = object.last_spawned_vehicle;
        vehicle = array_merge(vehicle, merge_array);
      }
      continue;
    }
    vehicle = array_merge(vehicle, merge_array);
  }
  return vehicle;
}

get_living_aispecies(name, type, breed) {
  array = get_living_aispecies_array(name, type, breed);
  if(array.size > 1) {
    AssertMsg("get_living_aispecies used for more than one living ai of type " + type + " called " + name + ".");
    return undefined;
  }
  return array[0];
}

get_living_aispecies_array(name, type, breed) {
  if(!isDefined(breed)) {
    breed = "all";
  }

  ai = GetAISpeciesArray("allies", breed);
  ai = array_combine(ai, GetAISpeciesArray("axis", breed));

  array = [];
  for(i = 0; i < ai.size; i++) {
    switch (type) {
      case "targetname": {
        if(isDefined(ai[i].targetname) && ai[i].targetname == name) {
          array[array.size] = ai[i];
        }
      }
      break;
      case "script_noteworthy": {
        if(isDefined(ai[i].script_noteworthy) && ai[i].script_noteworthy == name) {
          array[array.size] = ai[i];
        }
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
      if(IsAlive(self)) {
        self notify("gather_delay_finished" + msg + delay);
      }
      return;
    }

    level waittill(msg);
    if(IsAlive(self)) {
      self notify("gather_delay_finished" + msg + delay);
    }
    return;
  }

  level.gather_delay[msg] = false;
  wait(delay);
  level.gather_delay[msg] = true;
  level notify(msg);
  if(IsAlive(self)) {
    self notify("gather_delay_finished" + msg + delay);
  }
}

gather_delay(msg, delay) {
  thread gather_delay_proc(msg, delay);
  self waittill("gather_delay_finished" + msg + delay);
}

death_waiter(notifyString) {
  self waittill("death");
  level notify(notifyString);
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

getlinks_array(array, linkMap) {
  ents = [];
  for(j = 0; j < array.size; j++) {
    node = array[j];
    script_linkname = node.script_linkname;
    if(!isDefined(script_linkname)) {
      continue;
    }
    if(!isDefined(linkMap[script_linkname])) {
      continue;
    }
    ents[ents.size] = node;
  }
  return ents;
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
    linkMap[node.script_linkName] = true;
  }

  for(i = 0; i < array2.size; i++) {
    node = array2[i];
    if(isDefined(linkMap[node.script_linkName])) {
      continue;
    }
    linkMap[node.script_linkName] = true;
    array1[array1.size] = node;
  }

  return array1;
}

array_merge(array1, array2) {
  if(array1.size == 0) {
    return array2;
  }
  if(array2.size == 0) {
    return array1;
  }
  newarray = array1;
  foreach(array2_ent in array2) {
    foundmatch = false;

    foreach(array1_ent in array1) {
      if(array1_ent == array2_ent) {
        foundmatch = true;
        break;
      }
    }
    if(foundmatch) {
      continue;
    } else {
      newarray[newarray.size] = array2_ent;
    }
  }
  return newarray;
}

array_exclude(array, arrayExclude) {
  newarray = array;
  for(i = 0; i < arrayExclude.size; i++) {
    if(is_in_array(array, arrayExclude[i])) {
      newarray = array_remove(newarray, arrayExclude[i]);
    }
  }

  return newarray;
}

array_compare(array1, array2) {
  if(array1.size != array2.size) {
    return false;
  }

  foreach(key, member in array1) {
    if(!isDefined(array2[key])) {
      return false;
    }

    member2 = array2[key];

    if(member2 != member) {
      return false;
    }
  }

  return true;
}

getLinkedVehicleNodes() {
  array = [];

  if(isDefined(self.script_linkTo)) {
    linknames = get_links();
    foreach(name in linknames) {
      entities = GetVehicleNodeArray(name, "script_linkname");
      array = array_combine(array, entities);
    }
  }

  return array;
}

draw_line(org1, org2, r, g, b) {
  while(1) {
    Line(org1, org2, (r, g, b), 1);
    wait .05;
  }

}

draw_line_to_ent_for_time(org1, ent, r, g, b, timer) {
  timer = GetTime() + (timer * 1000);
  while(GetTime() < timer) {
    Line(org1, ent.origin, (r, g, b), 1);
    wait .05;
    if(!isDefined(ent) || !isDefined(ent.origin)) {
      return;
    }
  }

}

draw_line_from_ent_for_time(ent, org, r, g, b, timer) {
  draw_line_to_ent_for_time(org, ent, r, g, b, timer);
}

draw_line_from_ent_to_ent_for_time(ent1, ent2, r, g, b, timer) {
  ent1 endon("death");
  ent2 endon("death");

  timer = GetTime() + (timer * 1000);
  while(GetTime() < timer) {
    Line(ent1.origin, ent2.origin, (r, g, b), 1);
    wait .05;
  }

}

draw_line_from_ent_to_ent_until_notify(ent1, ent2, r, g, b, notifyEnt, notifyString) {
  Assert(isDefined(notifyEnt));
  Assert(isDefined(notifyString));

  ent1 endon("death");
  ent2 endon("death");

  notifyEnt endon(notifyString);

  while(1) {
    Line(ent1.origin, ent2.origin, (r, g, b), 0.05);
    wait .05;
  }

}

draw_line_until_notify(org1, org2, r, g, b, notifyEnt, notifyString) {
  Assert(isDefined(notifyEnt));
  Assert(isDefined(notifyString));

  notifyEnt endon(notifyString);

  while(1) {
    draw_line_for_time(org1, org2, r, g, b, 0.05);
  }
}

draw_line_from_ent_to_vec_for_time(ent, vec, length, r, g, b, timer) {
  timer = GetTime() + (timer * 1000);
  vec *= length;
  while(GetTime() < timer) {
    Line(ent.origin, ent.origin + vec, (r, g, b), 1);
    wait .05;
    if(!isDefined(ent) || !isDefined(ent.origin)) {
      return;
    }
  }
}

draw_circle_until_notify(center, radius, r, g, b, notifyEnt, notifyString, optionalSides) {
  if(isDefined(optionalSides)) {
    circle_sides = optionalSides;
  } else {
    circle_sides = 16;
  }

  angleFrac = 360 / circle_sides;

  circlepoints = [];
  for(i = 0; i < circle_sides; i++) {
    angle = (angleFrac * i);
    xAdd = Cos(angle) * radius;
    yAdd = Sin(angle) * radius;
    x = center[0] + xAdd;
    y = center[1] + yAdd;
    z = center[2];
    circlepoints[circlepoints.size] = (x, y, z);
  }
  thread draw_circle_lines_until_notify(circlepoints, r, g, b, notifyEnt, notifyString);
}

draw_circle_for_time(center, radius, r, g, b, time) {
  circle_sides = 16;

  angleFrac = 360 / circle_sides;

  circlepoints = [];
  for(i = 0; i < circle_sides; i++) {
    angle = (angleFrac * i);
    xAdd = Cos(angle) * radius;
    yAdd = Sin(angle) * radius;
    x = center[0] + xAdd;
    y = center[1] + yAdd;
    z = center[2];
    circlepoints[circlepoints.size] = (x, y, z);
  }
  thread draw_circle_lines_for_time(circlepoints, r, g, b, time);
}

draw_circle_lines_for_time(circlepoints, r, g, b, time) {
  for(i = 0; i < circlepoints.size; i++) {
    start = circlepoints[i];
    if(i + 1 >= circlepoints.size) {
      end = circlepoints[0];
    } else {
      end = circlepoints[i + 1];
    }

    thread draw_line_for_time(start, end, r, g, b, time);
  }
}

draw_circle_lines_until_notify(circlepoints, r, g, b, notifyEnt, notifyString) {
  for(i = 0; i < circlepoints.size; i++) {
    start = circlepoints[i];
    if(i + 1 >= circlepoints.size) {
      end = circlepoints[0];
    } else {
      end = circlepoints[i + 1];
    }

    thread draw_line_until_notify(start, end, r, g, b, notifyEnt, notifyString);
  }
}

clear_enemy_passthrough() {
  self notify("enemy");
  self ClearEnemy();
}

battlechatter_off(team) {
  level notify("battlechatter_off_thread");

  maps\_dds::dds_disable(team);

  animscripts\battlechatter::bcs_setup_chatter_toggle_array();

  if(isDefined(team)) {
    set_battlechatter_variable(team, false);
    soldiers = GetAIArray(team);
  } else {
    foreach(team in anim.teams) {
      set_battlechatter_variable(team, false);
    }

    soldiers = GetAIArray();
  }

  if(!isDefined(anim.chatInitialized) || !anim.chatInitialized) {
    return;
  }

  for(index = 0; index < soldiers.size; index++) {
    soldiers[index].battlechatter = false;
  }

  for(index = 0; index < soldiers.size; index++) {
    soldier = soldiers[index];
    if(!isalive(soldier)) {
      continue;
    }

    if(!soldier.chatInitialized) {
      continue;
    }

    if(!soldier.isSpeaking) {
      continue;
    }

    soldier wait_until_done_speaking();
  }

  speakDiff = GetTime() - anim.lastTeamSpeakTime["allies"];

  if(speakDiff < 1500) {
    wait(speakDiff / 1000);
  }

  if(isDefined(team)) {
    level notify(team + " done speaking");
  } else {
    level notify("done speaking");
  }
}

battlechatter_on(team) {
  thread battlechatter_on_thread(team);

  maps\_dds::dds_enable(team);
}

battlechatter_on_thread(team) {
  level endon("battlechatter_off_thread");

  animscripts\battlechatter::bcs_setup_chatter_toggle_array();

  while(!isDefined(anim.chatInitialized)) {
    wait(0.05);
  }

  flag_set("battlechatter_on_thread_waiting");

  wait(1.5);

  flag_clear("battlechatter_on_thread_waiting");

  if(isDefined(team)) {
    set_battlechatter_variable(team, true);
    soldiers = GetAIArray(team);
  } else {
    foreach(team in anim.teams) {
      set_battlechatter_variable(team, true);
    }
    soldiers = GetAIArray();
  }

  for(index = 0; index < soldiers.size; index++) {
    soldiers[index] set_battlechatter(true);
  }
}

set_battlechatter(bEnable) {
  dds_exclude_this_ai(!bEnable);

  if(!isDefined(anim.chatInitialized) || !anim.chatInitialized) {
    return;
  }

  if(self.type == "dog") {
    return;
  }

  if(bEnable) {
    if(isDefined(self.script_bcdialog) && !self.script_bcdialog) {
      self.battlechatter = false;
    } else {
      self.battlechatter = true;
    }
  } else {
    self.battlechatter = false;

    if(isDefined(self.isSpeaking) && self.isSpeaking) {
      self waittill("done speaking");
    }
  }
}

set_team_bcvoice(team, newvoice) {
  if(!anim.chatInitialized) {
    return;
  }

  supported_voicetypes = GetArrayKeys(anim.countryIDs);
  in_supported_voicetypes = array_contains(supported_voicetypes, newvoice);
  assertEx(in_supported_voicetypes, "Tried to change ai's voice to " + newvoice + " but that voicetype is not supported!");

  if(!in_supported_voicetypes) {
    return;
  }

  allies = GetAIArray(team);
  foreach(ai in allies) {
    ai set_ai_bcvoice(newvoice);
    waitframe();
  }
}

set_ai_bcvoice(newvoice) {
  if(!anim.chatInitialized) {
    return;
  }

  supported_voicetypes = GetArrayKeys(anim.countryIDs);
  in_supported_voicetypes = array_contains(supported_voicetypes, newvoice);
  assertEx(in_supported_voicetypes, "Tried to change ai's voice to " + newvoice + " but that voicetype is not supported!");

  if(!in_supported_voicetypes) {
    return;
  }

  if(self.type == "dog") {
    return;
  }

  if(isDefined(self.isSpeaking) && self.isSpeaking) {
    self waittill("done speaking");
    wait(0.1);
  }

  self animscripts\battlechatter_ai::removeFromSystem();
  waittillframeend;
  self.voice = newvoice;
  self animscripts\battlechatter_ai::addToSystem();
}

flavorbursts_on(team) {
  thread set_flavorbursts_team_state(true, team);
}

flavorbursts_off(team) {
  thread set_flavorbursts_team_state(false, team);
}

set_flavorbursts_team_state(state, team) {
  if(!isDefined(team)) {
    team = "allies";
  }

  if(!anim.chatInitialized) {
    return;
  }

  wait(1.5);

  level.flavorbursts[team] = state;

  guys = [];
  guys = GetAIArray(team);

  array_thread(guys, ::set_flavorbursts, state);
}

set_flavorbursts(state) {
  self.flavorbursts = state;
}

friendlyfire_warnings_off() {
  ais = GetAiArray("allies");

  foreach(guy in ais) {
    if(IsAlive(guy)) {
      guy set_friendlyfire_warnings(false);
    }
  }

  level.friendlyfire_warnings = false;
}

friendlyfire_warnings_on() {
  ais = GetAiArray("allies");

  foreach(guy in ais) {
    if(IsAlive(guy)) {
      guy set_friendlyfire_warnings(true);
    }
  }

  level.friendlyfire_warnings = true;
}

set_friendlyfire_warnings(state) {
  if(state) {
    self.friendlyfire_warnings_disable = undefined;
  } else {
    self.friendlyfire_warnings_disable = true;
  }
}

dds_set_player_character_name(hero_name) {
  if(!IsPlayer(self)) {
    /#PrintLn( "dds 'dds_set_player_character_name' function was not called on a player. No changes made." );
    return;
  }

  switch (hero_name) {
    case "mason":
    case "hudson":
    case "reznov":
      level.dds.player_character_name = GetSubStr(hero_name, 0, 3);
      /#PrintLn( "dds setting player name to '" + level.dds.player_character_name + "'" );
      break;
    default:
      /#printLn( "dds: '" + hero_name + "' not a valid player name; setting to 'mason' (mas)" );
      level.dds.player_character_name = "mas";
      break;
  }
  self.dds_characterID = level.dds.player_character_name;
}

dds_exclude_this_ai(bExclude) {
  if(IsAI(self) && IsAlive(self)) {
    if(bExclude) {
      self.dds_disable = true;
    } else {
      self.dds_disable = false;
    }
  } else {
    /#PrintLn( "Tried to mark an entity for DDS removal that was not an AI or not alive." );
  }
}

get_obj_origin(msg) {
  objOrigins = getEntArray("objective", "targetname");
  for(i = 0; i < objOrigins.size; i++) {
    if(objOrigins[i].script_noteworthy == msg) {
      return objOrigins[i].origin;
    }
  }
}

get_obj_event(msg) {
  objEvents = getEntArray("objective_event", "targetname");
  for(i = 0; i < objEvents.size; i++) {
    if(objEvents[i].script_noteworthy == msg) {
      return objEvents[i];
    }
  }
}

waittill_objective_event() {
  waittill_objective_event_proc(true);
}

waittill_objective_event_notrigger() {
  waittill_objective_event_proc(false);
}

debugorigin() {
  self notify("Debug origin");
  self endon("Debug origin");
  self endon("death");
  for(;;) {
    forward = anglesToForward(self.angles);
    forwardFar = (forward * 30);
    forwardClose = (forward * 20);
    right = AnglesToRight(self.angles);
    left = (right * -10);
    right = (right * 10);
    Line(self.origin, self.origin + forwardFar, (0.9, 0.7, 0.6), 0.9);
    Line(self.origin + forwardFar, self.origin + forwardClose + right, (0.9, 0.7, 0.6), 0.9);
    Line(self.origin + forwardFar, self.origin + forwardClose + left, (0.9, 0.7, 0.6), 0.9);
    wait(0.05);
  }
}

get_linked_structs() {
  array = [];

  if(isDefined(self.script_linkTo)) {
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
          ePathpoint = GetVehicleNode(ePathpoint.target, "targetname");
          break;
        case "pathnode":
          ePathpoint = GetNode(ePathpoint.target, "targetname");
          break;
        case "ent":
          ePathpoint = GetEnt(ePathpoint.target, "targetname");
          break;
        case "struct":
          ePathpoint = getstruct(ePathpoint.target, "targetname");
          break;
        default:
          AssertMsg("sEntityType needs to be 'vehiclenode', 'pathnode', 'ent' or 'struct'");
      }
    } else {
      break;
    }
  }
  ePathend = ePathpoint;
  return ePathend;
}

player_seek(timeout) {
  goalent = spawn("script_origin", level.player.origin);
  goalent LinkTo(level.player);
  if(isDefined(timeout)) {
    self thread timeout(timeout);
  }
  self SetGoalEntity(goalent);
  if(!isDefined(self.oldgoalradius)) {
    self.oldgoalradius = self.goalradius;
  }
  self.goalradius = 300;
  self waittill_any("goal", "timeout");
  if(isDefined(self.oldgoalradius)) {
    self.goalradius = self.oldgoalradius;
    self.oldgoalradius = undefined;
  }
  goalent Delete();
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
  keys = GetArrayKeys(array);
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
  foreach(member in array) {
    if(!isalive(member)) {
      continue;
    }
    newArray[newArray.size] = member;
  }

  return newArray;
}

array_removeDead_or_dying(array) {
  newArray = [];
  foreach(member in array) {
    if(!isalive(member)) {
      continue;
    }
    if(member doingLongDeath()) {
      continue;
    }
    newArray[newArray.size] = member;
  }

  return newArray;
}

array_remove_nokeys(ents, remover) {
  newents = [];
  for(i = 0; i < ents.size; i++) {
    if(ents[i] != remover)
  }
  newents[newents.size] = ents[i];
  return newents;
}

array_remove_index(array, index) {
  for(i = 0; i < array.size - 1; i++) {
    if(i == index) {
      array[i] = array[i + 1];
      index++;
    }
  }
  array[array.size - 1] = undefined;
  return array;
}

array_notify(ents, notifier, match) {
  foreach(key, value in ents) {
    value notify(notifier, match);
  }
}

struct_arrayspawn() {
  struct = spawnStruct();
  struct.array = [];
  struct.lastindex = 0;
  return struct;
}

structarray_add(struct, object) {
  Assert(!isDefined(object.struct_array_index));
  struct.array[struct.lastindex] = object;
  object.struct_array_index = struct.lastindex;
  struct.lastindex++;
}

structarray_remove(struct, object) {
  structarray_swaptolast(struct, object);
  struct.array[struct.lastindex - 1] = undefined;
  struct.lastindex--;
}

structarray_remove_index(struct, index) {
  if(isDefined(struct.array[struct.lastindex - 1])) {
    struct.array[index] = struct.array[struct.lastindex - 1];
    struct.array[index].struct_array_index = index;

    struct.array[struct.lastindex - 1] = undefined;
    struct.lastindex = struct.array.size;
  } else {
    struct.array[index] = undefined;
    structarray_remove_undefined(struct);
  }
}

structarray_remove_undefined(struct) {
  newArray = [];
  foreach(object in struct.array) {
    if(!isDefined(object)) {
      continue;
    }
    newArray[newArray.size] = object;
  }
  struct.array = newArray;

  foreach(i, object in struct.array) {
    object.struct_array_index = i;
  }
  struct.lastindex = struct.array.size;
}

structarray_swaptolast(struct, object) {
  struct structarray_swap(struct.array[struct.lastindex - 1], object);
}

structarray_shuffle(struct, shuffle) {
  for(i = 0; i < shuffle; i++) {
    struct structarray_swap(struct.array[i], struct.array[RandomInt(struct.lastindex)]);
  }
}

get_use_key() {
  if(level.console) {
    return " + usereload";
  } else {
    return " + activate";
  }
}

custom_battlechatter(phrase) {
  return self animscripts\battlechatter_ai::custom_battlechatter_internal(phrase);
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
  watch SetClock(timer, time, "hudStopwatch", 64, 64);
  return watch;
}

objective_is_active(msg) {
  active = false;

  for(i = 0; i < level.active_objective.size; i++) {
    if(level.active_objective[i] != msg) {
      continue;
    }
    active = true;
    break;
  }
  return (active);
}

objective_is_inactive(msg) {
  inactive = false;

  for(i = 0; i < level.inactive_objective.size; i++) {
    if(level.inactive_objective[i] != msg) {
      continue;
    }
    inactive = true;
    break;
  }
  return (inactive);
}

set_objective_inactive(msg) {
  array = [];
  for(i = 0; i < level.active_objective.size; i++) {
    if(level.active_objective[i] == msg) {
      continue;
    }
    array[array.size] = level.active_objective[i];
  }
  level.active_objective = array;

  exists = false;
  for(i = 0; i < level.inactive_objective.size; i++) {
    if(level.inactive_objective[i] != msg) {
      continue;
    }
    exists = true;
  }
  if(!exists) {
    level.inactive_objective[level.inactive_objective.size] = msg;
  }

  for(i = 0; i < level.active_objective.size; i++) {
    for(p = 0; p < level.inactive_objective.size; p++) {
      AssertEx(level.active_objective[i] != level.inactive_objective[p], "Objective is both inactive and active");
    }
  }

}

set_objective_active(msg) {
  array = [];
  for(i = 0; i < level.inactive_objective.size; i++) {
    if(level.inactive_objective[i] == msg) {
      continue;
    }
    array[array.size] = level.inactive_objective[i];
  }
  level.inactive_objective = array;

  exists = false;
  for(i = 0; i < level.active_objective.size; i++) {
    if(level.active_objective[i] != msg) {
      continue;
    }
    exists = true;
  }
  if(!exists) {
    level.active_objective[level.active_objective.size] = msg;
  }

  for(i = 0; i < level.active_objective.size; i++) {
    for(p = 0; p < level.inactive_objective.size; p++) {
      AssertEx(level.active_objective[i] != level.inactive_objective[p], "Objective is both inactive and active");
    }
  }

}

missionFailedWrapper() {
  if(level.MissionFailed) {
    return;
  }

  if(isDefined(level.nextmission)) {
    return;
  }

  SetSavedDvar("ammoCounterHide", 1);

  level.MissionFailed = true;
  flag_set("missionfailed");

  if(arcadeMode()) {
    return;
  }

  if(GetDvar("failure_disabled") == "1") {
    return;
  }

  if(isDefined(level.mission_fail_func)) {
    thread[[level.mission_fail_func]]();
    return;
  }

  mission_recon(false);

  MissionFailed();
}

set_mission_failed_override(func) {
  AssertEx(isDefined(func), "function handler not defined in call to add_mission_failed_override()");
  AssertEx(!isDefined(level.mission_fail_func), "mission failed override already exists.");

  level.mission_fail_func = func;
}

script_delay() {
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
    return true;
  } else {
    if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {}
    wait(RandomFloatRange(self.script_delay_min, self.script_delay_max));
    return true;
  }

  return false;
}

script_wait() {
  startTime = GetTime();
  if(isDefined(self.script_wait)) {
    wait(self.script_wait);

    if(isDefined(self.script_wait_add)) {
      self.script_wait += self.script_wait_add;
    }
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    wait(RandomFloatRange(self.script_wait_min, self.script_wait_max));

    if(isDefined(self.script_wait_add)) {
      self.script_wait_min += self.script_wait_add;
      self.script_wait_max += self.script_wait_add;
    }
  }

  return (GetTime() - startTime);
}

guy_enter_vehicle(guy) {
  self maps\_vehicle_aianim::guy_enter(guy);
}

guy_runtovehicle_load(guy, vehicle) {
  maps\_vehicle_aianim::guy_runtovehicle(guy, vehicle);
}

get_force_color_guys(team, color) {
  ai = GetAIArray(team);
  guys = [];
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!isDefined(guy.script_forcecolor)) {
      continue;
    }

    if(guy.script_forcecolor != color) {
      continue;
    }
    guys[guys.size] = guy;
  }

  return guys;
}

get_all_force_color_friendlies() {
  ai = GetAIArray("allies");
  guys = [];
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!isDefined(guy.script_forcecolor)) {
      continue;
    }
    guys[guys.size] = guy;
  }

  return guys;
}

get_all_target_ents(target) {
  if(!isDefined(target)) {
    target = self.target;
  }

  AssertEx(isDefined(target), "Self had no target!");
  array = [];

  ents = getEntArray(target, "targetname");
  array = array_combine(array, ents);

  ents = GetNodeArray(target, "targetname");
  array = array_combine(array, ents);

  ents = getstructarray(target, "targetname");
  array = array_combine(array, ents);

  ents = GetVehicleNodeArray(target, "targetname");
  array = array_combine(array, ents);

  return array;
}

enable_ai_color() {
  if(isDefined(self.script_forcecolor)) {
    return;
  }
  if(!isDefined(self.old_forceColor)) {
    return;
  }

  set_force_color(self.old_forcecolor);
  self.old_forceColor = undefined;
}

enable_ai_color_dontmove() {
  self.dontColorMove = true;
  self enable_ai_color();
}

disable_ai_color() {
  if(isDefined(self.new_force_color_being_set)) {
    self endon("death");

    self waittill("done_setting_new_color");
  }

  self ClearFixedNodeSafeVolume();

  if(!isDefined(self.script_forcecolor)) {
    return;
  }

  AssertEx(!isDefined(self.old_forcecolor), "Tried to disable forcecolor on a guy that somehow had a old_forcecolor already. Investigate!!!");

  self.old_forceColor = self.script_forceColor;

  self maps\_colors::remove_AI_from_colors();

  update_debug_friendlycolor(self.unique_id);
}

clear_force_color() {
  disable_ai_color();
}

check_force_color(_color) {
  color = level.colorCheckList[ToLower(_color)];
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

set_force_color(_color) {
  color = self maps\_colors::add_AI_to_colors(_color);

  update_debug_friendlycolor(self.unique_id);
}

issue_color_orders(color_team, team) {
  maps\_colors::issue_color_orders_generic(color_team, team);
}

clear_color_order(order_color, team) {
  maps\_colors::clear_color_order_from_team(order_color, team);
}

clear_all_color_orders(team) {
  foreach(color in level.colorList) {
    maps\_colors::clear_color_order_from_team(color, team);
  }
}

replace_on_death() {
  self thread maps\_colors::colorNode_replace_on_death();
}

disable_replace_on_death() {
  self.replace_on_death = undefined;
  self notify("_disable_reinforcement");
}

stop_replace_on_death() {
  self notify("_disable_reinforcement");
}

stop_all_replace_on_death(team, color) {
  self thread maps\_colors::colorNode_stop_replace_on_death_group(team, color);
}

spawn_reinforcement(classname, color, replace, team) {
  if(!isDefined(team)) {
    team = "allies";
  }

  thread maps\_colors::colorNode_spawn_reinforcement(team, classname, color, replace);
}

clear_promotion_order() {
  maps\_colors::colorNode_clear_promotion_order();
}

set_promotion_order(deadguy, replacer) {
  maps\_colors::colorNode_set_promotion_order(deadguy, replacer);
}

set_empty_promotion_order(deadguy) {
  maps\_colors::colorNode_set_empty_promotion_order(deadguy);
}

has_color() {
  if(self maps\_colors::get_team() == "axis") {
    return isDefined(self.script_color_axis) || isDefined(self.script_forcecolor);
  }

  return isDefined(self.script_color_allies) || isDefined(self.script_forcecolor);
}

get_color_volume_from_trigger() {
  return self maps\_colors::get_color_volume_from_trigger_codes();
}

get_color_nodes_from_trigger() {
  return self maps\_colors::get_color_nodes_from_trigger_codes();
}

flashRumbleLoop(duration) {
  Assert(IsPlayer(self));

  goalTime = GetTime() + duration * 1000;

  while(GetTime() < goalTime) {
    self PlayRumbleOnEntity("damage_heavy");
    wait(0.05);
  }
}

flashMonitorEnableHealthShield(time) {
  self endon("death");
  self endon("flashed");

  wait 0.2;

  self EnableHealthShield(false);

  wait time + 2;

  self EnableHealthShield(true);
}

nineBangHandler(origin, percent_distance, percent_angle, attacker, team) {
  waits = [0.8, 0.7, 0.7, 0.6];
  banglens = [1.0, 0.8, 0.6, 0.6];
  foreach(i, banglen in banglens) {
    frac = (percent_distance - 0.85) / (1 - 0.85);
    if(frac > percent_angle) {
      percent_angle = frac;
    }

    if(percent_angle < 0.25) {
      percent_angle = 0.25;
    }

    minamountdist = 0.3;
    if(percent_distance > 1 - minamountdist) {
      percent_distance = 1.0;
    } else {
      percent_distance = percent_distance / (1 - minamountdist);
    }

    if(team != self.team) {
      seconds = percent_distance * percent_angle * 6.0;
    } else {
      seconds = percent_distance * percent_angle * 3.0;
    }

    if(seconds < 0.25) {
      continue;
    }

    seconds = banglen * seconds;
    if(isDefined(self.maxflashedseconds) && seconds > self.maxflashedseconds) {
      seconds = self.maxflashedseconds;
    }

    self.flashingTeam = team;
    self notify("flashed");
    self.flashendtime = GetTime() + seconds * 1000;
    self ShellShock("flashbang", seconds);

    flag_set("player_flashed");

    if(percent_distance * percent_angle > 0.5) {
      self thread flashMonitorEnableHealthShield(seconds);
    }
    wait waits[i];
  }
  thread unflash_flag(0.05);
}

flashMonitor() {
  Assert(IsPlayer(self));

  self endon("death");

  for(;;) {
    self waittill("flashbang", origin, percent_distance, percent_angle, attacker, team);

    if("1" == GetDvar("noflash")) {
      continue;
    }

    if(is_player_down(self)) {
      continue;
    }

    if(isDefined(self.threw_ninebang)) {
      player_range_percent = 1000 / 1250;
      om_player_range_percent = 1.0 - player_range_percent;
      self.threw_ninebang = undefined;

      if(percent_distance < om_player_range_percent) {
        continue;
      }
      percent_distance = (percent_distance - om_player_range_percent) / player_range_percent;
    }

    frac = (percent_distance - 0.85) / (1 - 0.85);
    if(frac > percent_angle) {
      percent_angle = frac;
    }

    if(percent_angle < 0.25) {
      percent_angle = 0.25;
    }

    minamountdist = 0.3;
    if(percent_distance > 1 - minamountdist) {
      percent_distance = 1.0;
    } else {
      percent_distance = percent_distance / (1 - minamountdist);
    }

    if(team != self.team) {
      seconds = percent_distance * percent_angle * 6.0;
    } else {
      seconds = percent_distance * percent_angle * 3.0;
    }

    if(seconds < 0.25) {
      continue;
    }

    if(isDefined(self.maxflashedseconds) && seconds > self.maxflashedseconds) {
      seconds = self.maxflashedseconds;
    }

    self.flashingTeam = team;
    self notify("flashed");
    self.flashendtime = GetTime() + seconds * 1000;
    self ShellShock("flashbang", seconds);
    self LightSetOverrideEnableForPlayer("flashed", 0.1);
    flag_set("player_flashed");
    thread unflash_flag(seconds);
    wait 0.1;
    self LightSetOverrideDisableForPlayer(seconds - 0.1);

    if(percent_distance * percent_angle > 0.5) {
      self thread flashMonitorEnableHealthShield(seconds);
    }

    if(seconds > 2) {
      thread flashRumbleLoop(0.75);
    } else {
      thread flashRumbleLoop(0.25);
    }

    if(team != "allies") {
      self thread flashNearbyAllies(seconds, team);
    }
  }
}

flashNearbyAllies(baseDuration, team) {
  Assert(IsPlayer(self));

  wait .05;

  allies = GetAIArray("allies");
  for(i = 0; i < allies.size; i++) {
    if(DistanceSquared(allies[i].origin, self.origin) < 350 * 350) {
      duration = baseDuration + RandomFloatRange(-1000, 1500);
      if(duration > 4.5) {
        duration = 4.5;
      } else if(duration < 0.25) {
        continue;
      }

      newendtime = GetTime() + duration * 1000;
      if(!isDefined(allies[i].flashendtime) || allies[i].flashendtime < newendtime) {
        allies[i].flashingTeam = team;
        allies[i] flashBangStart(duration);
      }
    }
  }
}

restartEffect() {
  self common_scripts\_createfx::restart_fx_looper();
}

pauseExploder(num) {
  num += "";

  if(isDefined(level.createFXexploders)) {
    exploders = level.createFXexploders[num];
    if(isDefined(exploders)) {
      foreach(ent in exploders) {
        ent pauseEffect();
      }
    }
  } else {
    foreach(fx in level.createFXent) {
      if(!isDefined(fx.v["exploder"])) {
        continue;
      }

      if(fx.v["exploder"] != num) {
        continue;
      }

      fx pauseEffect();
    }
  }
}

restartExploder(num) {
  num += "";
  if(isDefined(level.createFXexploders)) {
    exploders = level.createFXexploders[num];
    if(isDefined(exploders)) {
      foreach(ent in exploders) {
        ent restartEffect();
      }
    }
  } else {
    foreach(fx in level.createFXent) {
      if(!isDefined(fx.v["exploder"])) {
        continue;
      }

      if(fx.v["exploder"] != num) {
        continue;
      }

      fx restartEffect();
    }
  }
}

getfxarraybyID(fxid) {
  array = [];
  if(isDefined(level.createFXbyFXID)) {
    fxids = level.createFXbyFXID[fxid];
    if(isDefined(fxids)) {
      array = fxids;
    }
  } else {
    for(i = 0; i < level.createFXent.size; i++) {
      if(level.createFXent[i].v["fxid"] == fxid) {
        array[array.size] = level.createFXent[i];
      }
    }
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
    PrintLn("entity: " + num + "ignoreAllEnemies TRUE");
    PrintLn("entity: " + num + " threatbiasgroup is " + self.old_threat_bias_group);

    CreateThreatBiasGroup("ignore_everybody");

    PrintLn("entity: " + num + "ignoreAllEnemies TRUE");
    PrintLn("entity: " + num + " SetThreatBiasGroup( ignore_everybody )");

    self SetThreatBiasGroup("ignore_everybody");
    teams = [];
    teams["axis"] = "allies";
    teams["allies"] = "axis";

    AssertEx(self.team != "neutral", "Why are you making a guy have team neutral? And also, why is he doing anim_reach?");
    ai = GetAIArray(teams[self.team]);
    groups = [];
    for(i = 0; i < ai.size; i++) {
      groups[ai[i] GetThreatBiasGroup()] = true;
    }

    keys = GetArrayKeys(groups);
    for(i = 0; i < keys.size; i++) {
      PrintLn("entity: " + num + "ignoreAllEnemies TRUE");
      PrintLn("entity: " + num + " SetThreatBias( " + keys[i] + ", ignore_everybody, 0 )");

      SetThreatBias(keys[i], "ignore_everybody", 0);
    }

  } else {
    num = undefined;
    AssertEx(isDefined(self.old_threat_bias_group), "You can't use ignoreAllEnemies( false ) on an AI that has never ran ignoreAllEnemies( true )");

    num = self GetEntNum();
    PrintLn("entity: " + num + "ignoreAllEnemies FALSE");
    PrintLn("entity: " + num + " self.old_threat_bias_group is " + self.old_threat_bias_group);

    if(self.old_threat_bias_group != "") {
      PrintLn("entity: " + num + "ignoreAllEnemies FALSE");
      PrintLn("entity: " + num + " SetThreatBiasGroup( " + self.old_threat_bias_group + " )");

      self SetThreatBiasGroup(self.old_threat_bias_group);
    }
    self.old_threat_bias_group = undefined;
  }
}

vehicle_detachfrompath() {
  maps\_vehicle_code::vehicle_pathdetach();
}

vehicle_resumepath() {
  thread maps\_vehicle_code::vehicle_resumepathvehicle();
}

vehicle_land(neargoaldist) {
  maps\_vehicle_code::vehicle_landvehicle(neargoaldist);
}

vehicle_liftoff(height) {
  maps\_vehicle_code::vehicle_liftoffvehicle(height);
}

vehicle_dynamicpath(node, bwaitforstart) {
  maps\_vehicle::vehicle_paths(node, bwaitforstart);
}

groundpos(origin) {
  return bulletTrace(origin, (origin + (0, 0, -100000)), 0, self)["position"];
}

change_player_health_packets(num) {
  Assert(IsPlayer(self));

  self.player_health_packets += num;
  self notify("update_health_packets");

  if(self.player_health_packets >= 3) {
    self.player_health_packets = 3;
  }
}

getvehiclespawner(targetname) {
  spawners = getvehiclespawnerarray(targetname);
  Assert(spawners.size == 1);
  return spawners[0];
}

getvehiclespawnerarray(targetname) {
  return maps\_vehicle_code::_getvehiclespawnerarray(targetname);
}

describe_start(msg, func, loc_string, optional_func, transient, catchup_function) {
  add_start_assert();

  if(!isDefined(level.start_description)) {
    level.start_description = [];
  }

  AssertEx(!isDefined(level.start_description[msg]), "You are describing this start point more than once");
  level.start_description[msg] = add_start_construct(msg, func, loc_string, optional_func, [transient], catchup_function);
}

add_start(msg, func, loc_string, optional_func, optional_transients_to_load, catchup_function) {
  add_start_assert();

  msg = ToLower(msg);

  if(isDefined(optional_transients_to_load)) {
    if(optional_transients_to_load.size > 2) {
      AssertMsg("Start point: " + msg + " trying to load more than 2 transients, only using the first 2 in the array");

      temp_arr = [];
      temp_arr[0] = optional_transients_to_load[0];
      temp_arr[1] = optional_transients_to_load[1];
      optional_transients_to_load = temp_arr;
    }
    if(!isDefined(level.start_transients)) {
      level.start_transients = [];
    }
    foreach(trans in optional_transients_to_load) {
      if(!array_contains(level.start_transients, trans)) {
        level.start_transients[level.start_transients.size] = trans;
      }
    }
  }

  if(isDefined(level.start_description) && isDefined(level.start_description[msg])) {
    assert_msg = "This start is already described. you only need add_start( msg )";
    AssertEx(!isDefined(func), assert_msg);
    AssertEx(!isDefined(loc_string), assert_msg);
    AssertEx(!isDefined(optional_func), assert_msg);
    AssertEx(!isDefined(optional_transients_to_load), assert_msg);

    array = level.start_description[msg];
  } else {
    array = add_start_construct(msg, func, loc_string, optional_func, optional_transients_to_load, catchup_function);
  }

  if(!isDefined(func)) {
    if(!isDefined(level.start_description)) {
      AssertEx(isDefined(func), "add_start() called with no descriptions set and no func parameter..");
    } else if(!IsSubStr(msg, "no_game")) {
      if(!isDefined(level.start_description[msg])) {
        return;
      }
    }
  }

  level.start_functions[level.start_functions.size] = array;
  level.start_arrays[msg] = array;
}

set_start_transients(start_name, transients) {
  if(!isDefined(level.start_arrays)) {
    return;
  }
  if(!isDefined(level.start_arrays[start_name])) {
    return;
  }

  start_name = ToLower(start_name);

  if(transients.size > 2) {
    AssertMsg("Start point: " + start_name + " trying to load more than 2 transients, only using the first 2 in the array");

    temp_arr = [];
    temp_arr[0] = transients[0];
    temp_arr[1] = transients[1];
    transients = temp_arr;
  }
  if(!isDefined(level.start_transients)) {
    level.start_transients = [];
  }
  foreach(trans in transients) {
    if(!array_contains(level.start_transients, trans)) {
      level.start_transients[level.start_transients.size] = trans;
    }
  }

  level.start_arrays[start_name]["transients_to_load"] = transients;
}

is_no_game_start() {
  return IsSubStr(level.start_point, "no_game");
}

add_start_construct(msg, func, loc_string, optional_func, optional_transients_to_load, catchup_function) {
  if(isDefined(loc_string)) {
    PreCacheString(loc_string);
  }

  array = [];
  array["name"] = msg;
  array["start_func"] = func;
  array["start_loc_string"] = loc_string;
  array["logic_func"] = optional_func;
  array["transients_to_load"] = optional_transients_to_load;
  array["catchup_function"] = catchup_function;
  return array;
}

add_start_assert() {
  AssertEx(!isDefined(level._loadStarted), "Can't create starts after _load");
  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
  }
}

level_has_start_points() {
  return level.start_functions.size > 1;
}

set_default_start(start) {
  level.default_start_override = start;
}

default_start(func) {
  level.default_start = func;
}

linetime(start, end, color, timer) {
  thread linetime_proc(start, end, color, timer);
}

within_fov_2d(start_origin, start_angles, end_origin, fov) {
  normal = VectorNormalize((end_origin[0], end_origin[1], 0) - (start_origin[0], start_origin[1], 0));
  forward = anglesToForward((0, start_angles[1], 0));
  return VectorDot(forward, normal) >= fov;
}

get_dot(start_origin, start_angles, end_origin) {
  normal = VectorNormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = VectorDot(forward, normal);

  return dot;
}

within_fov_of_players(end_origin, fov) {
  bDestInFOV = undefined;
  for(i = 0; i < level.players.size; i++) {
    playerEye = level.players[i] getEye();
    bDestInFOV = within_fov(playerEye, level.players[i] GetPlayerAngles(), end_origin, fov);
    if(!bDestInFOV) {
      return false;
    }
  }
  return true;
}

wait_for_buffer_time_to_pass(last_queue_time, buffer_time) {
  timer = buffer_time * 1000 - (GetTime() - last_queue_time);
  timer *= 0.001;
  if(timer > 0) {
    wait(timer);
  }
}

bcs_scripted_dialogue_start() {
  anim.scriptedDialogueStartTime = GetTime();
}

dialogue_queue(msg) {
  squelch_type = GetSndAliasValue(msg, "squelchname");
  if(self == level || squelch_type != "") {
    radio_dialogue(msg, undefined, squelch_type);
    return;
  }

  bcs_scripted_dialogue_start();

  self maps\_anim::anim_single_queue(self, msg);
}

generic_dialogue_queue(msg, timeout) {
  bcs_scripted_dialogue_start();

  self maps\_anim::anim_generic_queue(self, msg, undefined, undefined, timeout);
}

radio_dialogue(msg, timeout, squelch_type) {
  if(!isDefined(level.player_radio_emitter)) {
    ent = spawn("script_origin", (0, 0, 0));
    ent LinkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = ent;
  }

  bcs_scripted_dialogue_start();

  if(!isDefined(timeout)) {
    return level.player_radio_emitter function_stack(::radio_dialogue_play, msg, squelch_type);
  } else {
    return level.player_radio_emitter function_stack_timeout(timeout, ::radio_dialogue_play, msg, squelch_type);
  }
}

radio_dialogue_play(msg, squelch_type) {
  if(!isDefined(squelch_type)) {
    squelch_type = "none";
  }
  level.player_radio_squelch_out_queued = false;
  if(squelch_type != "none" && isDefined(level.scr_radio["squelches"][squelch_type])) {
    self play_sound_on_tag(level.scr_radio["squelches"][squelch_type]["on"], undefined, true);
  }

  success = false;
  if(isDefined(level.scr_radio[msg])) {
    success = self play_sound_on_tag(level.scr_radio[msg], undefined, true);
  } else {
    success = self play_sound_on_tag(msg, undefined, true);
  }

  if(squelch_type != "none" && isDefined(level.scr_radio["squelches"][squelch_type])) {
    thread radio_try_squelch_out(squelch_type);
  }

  return success;
}

radio_dialogue_overlap(msg) {
  AssertEx(isDefined(level.scr_radio[msg]), "Tried to play radio dialogue " + msg + " that did not exist! Add it to level.scr_radio");
  AssertEx(isDefined(level.player_radio_emitter), "Tried to overlap dialogue but no radio dialogue was playing, use radio_dialogue.");

  if(!isDefined(level.player_radio_emitter_overlap)) {
    level.player_radio_emitter_overlap = [];
  }

  org = spawn("script_origin", (0, 0, 0));
  level.player_radio_emitter_overlap[level.player_radio_emitter_overlap.size] = org;
  org endon("death");

  thread delete_on_death_wait_sound(org, "sounddone");
  org.origin = level.player_radio_emitter.origin;
  org.angles = level.player_radio_emitter.angles;
  org LinkTo(level.player_radio_emitter);

  PrintLn("**dialog alias playing radio: " + level.scr_radio[msg]);
  org playSound(level.scr_radio[msg], "sounddone");
  if(!isDefined(wait_for_sounddone_or_death(org))) {
    org StopSounds();
  }
  wait(0.05);

  level.player_radio_emitter_overlap = array_remove(level.player_radio_emitter_overlap, org);
  org Delete();
}

radio_dialogue_stop() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }

  level.player_radio_emitter Delete();
}

radio_dialogue_overlap_stop() {
  if(!isDefined(level.player_radio_emitter_overlap)) {
    return;
  }

  Assert(IsArray(level.player_radio_emitter_overlap));

  foreach(ent in level.player_radio_emitter_overlap) {
    if(isDefined(ent)) {
      ent StopSounds();
      wait(0.05);
      ent Delete();
    }
  }

  level.player_radio_emitter_overlap = undefined;
}

radio_dialogue_clear_stack() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }
  level.player_radio_emitter function_stack_clear();
}

radio_dialogue_remove_from_stack(msg) {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }

  if(!isDefined(level.player_radio_emitter.function_stack)) {
    return;
  }

  newstack = [];
  is_remove_performed = false;

  orig_size = level.player_radio_emitter.function_stack.size;

  for(i = 0; i < orig_size; i++) {
    if((i == 0) && isDefined(level.player_radio_emitter.function_stack[0].function_stack_func_begun) && isDefined(level.player_radio_emitter.function_stack[0].function_stack_func_begun)) {
      newstack[newstack.size] = level.player_radio_emitter.function_stack[i];
    } else if(isDefined(level.player_radio_emitter.function_stack[i].param1) && (level.player_radio_emitter.function_stack[i].param1 == msg)) {
      level.player_radio_emitter.function_stack[i] notify("death");
      level.player_radio_emitter.function_stack[i] = undefined;
      is_remove_performed = true;
    } else {
      newstack[newstack.size] = level.player_radio_emitter.function_stack[i];
    }
  }

  if(is_remove_performed) {
    level.player_radio_emitter.function_stack = newstack;
  }
}

radio_dialogue_interupt(msg) {
  AssertEx(isDefined(level.scr_radio[msg]), "Tried to play radio dialogue " + msg + " that did not exist! Add it to level.scr_radio");

  if(!isDefined(level.player_radio_emitter)) {
    ent = spawn("script_origin", (0, 0, 0));
    ent LinkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = ent;
  }

  level.player_radio_emitter play_sound_on_tag(level.scr_radio[msg], undefined, true);
}

radio_dialogue_safe(msg) {
  return radio_dialogue(msg, .05);
}

smart_radio_dialogue(dialogue, timeout) {
  squelch_type = GetSndAliasValue(dialogue, "squelchname");
  add_to_radio(dialogue);

  radio_dialogue(dialogue, timeout, squelch_type);
}

smart_radio_dialogue_interrupt(dialogue) {
  add_to_radio(dialogue);
  radio_dialogue_stop();
  radio_dialogue_interupt(dialogue);
}

smart_radio_dialogue_overlap(dialogue) {
  add_to_radio(dialogue);
  radio_dialogue_overlap(dialogue);
}

smart_dialogue(dialogue) {
  self add_to_dialogue(dialogue);
  self dialogue_queue(dialogue);
}

smart_dialogue_generic(dialogue) {
  self add_to_dialogue_generic(dialogue);
  self generic_dialogue_queue(dialogue);
}

radio_try_squelch_out(squelch_type, time) {
  self endon("death");
  if(!isDefined(time)) {
    time = 0.1;
  }
  level.player_radio_squelch_out_queued = true;
  wait(time);
  if(isDefined(level.player_radio_emitter) && level.player_radio_squelch_out_queued == true) {
    level.player_radio_emitter function_stack(::play_sound_on_tag, level.scr_radio["squelches"][squelch_type]["off"], undefined, true);
  }
}

radio_dialogue_queue(msg, squelch_type) {
  radio_dialogue(msg, undefined, squelch_type);
}

hint_create(text, background, backgroundAlpha) {
  struct = spawnStruct();
  if(isDefined(background) && background == true) {
    struct.bg = NewHudElem();
  }
  struct.elm = NewHudElem();

  struct hint_position_internal(backgroundAlpha);

  struct.elm SetText(text);

  return struct;
}

hint_delete() {
  self notify("death");

  if(isDefined(self.elm)) {
    self.elm Destroy();
  }
  if(isDefined(self.bg)) {
    self.bg Destroy();
  }
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

is_string_a_number(string_val) {
  Assert(IsString(string_val));
  float_val = float(string_val);
  return string(float_val) == string_val;
}

ignoreEachOther(group1, group2) {
  AssertEx(ThreatBiasGroupExists(group1), "Tried to make threatbias group " + group1 + " ignore " + group2 + " but " + group1 + " does not exist!");
  AssertEx(ThreatBiasGroupExists(group2), "Tried to make threatbias group " + group2 + " ignore " + group1 + " but " + group2 + " does not exist!");
  SetIgnoreMeGroup(group1, group2);
  SetIgnoreMeGroup(group2, group1);
}

add_global_spawn_function(team, function, param1, param2, param3) {
  AssertEx(isDefined(level.spawn_funcs), "Tried to add_global_spawn_function before calling _load");

  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;

  level.spawn_funcs[team][level.spawn_funcs[team].size] = func;
}

remove_global_spawn_function(team, function) {
  AssertEx(isDefined(level.spawn_funcs), "Tried to remove_global_spawn_function before calling _load");

  array = [];
  for(i = 0; i < level.spawn_funcs[team].size; i++) {
    if(level.spawn_funcs[team][i]["function"] != function) {
      array[array.size] = level.spawn_funcs[team][i];
    }
  }

  level.spawn_funcs[team] = array;
}

exists_global_spawn_function(team, function) {
  if(!isDefined(level.spawn_funcs)) {
    return false;
  }

  for(i = 0; i < level.spawn_funcs[team].size; i++) {
    if(level.spawn_funcs[team][i]["function"] == function) {
      return true;
    }
  }

  return false;
}

remove_spawn_function(function) {
  AssertEx(!isalive(self), "Tried to remove_spawn_function to a living guy.");
  AssertEx(IsSpawner(self), "Tried to remove_spawn_function to something that isn't a spawner.");
  AssertEx(isDefined(self.spawn_functions), "Tried to remove_spawn_function before calling _load");

  new_spawn_functions = [];

  foreach(func_array in self.spawn_functions) {
    if(func_array["function"] == function) {
      continue;
    }

    new_spawn_functions[new_spawn_functions.size] = func_array;
  }

  self.spawn_functions = new_spawn_functions;
}

add_spawn_function(function, param1, param2, param3, param4, param5) {
  AssertEx(!isalive(self), "Tried to add_spawn_function to a living guy.");
  AssertEx(IsSpawner(self), "Tried to add_spawn_function to something that isn't a spawner.");
  AssertEx(isDefined(self.spawn_functions), "Tried to add_spawn_function before calling _load");

  foreach(func_array in self.spawn_functions) {
    if(func_array["function"] == function) {
      return;
    }
  }

  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  func["param5"] = param5;

  self.spawn_functions[self.spawn_functions.size] = func;
}

array_delete(array) {
  for(i = 0; i < array.size; i++) {
    array[i] Delete();
  }
}

array_kill(array) {
  for(i = 0; i < array.size; i++) {
    array[i] kill();
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

activate_trigger_with_targetname(msg) {
  trigger = GetEnt(msg, "targetname");
  trigger activate_trigger();
}

activate_trigger_with_noteworthy(msg) {
  trigger = GetEnt(msg, "script_noteworthy");
  trigger activate_trigger();
}

disable_trigger_with_targetname(msg) {
  trigger = GetEnt(msg, "targetname");
  trigger trigger_off();
}

disable_trigger_with_noteworthy(msg) {
  trigger = GetEnt(msg, "script_noteworthy");
  trigger trigger_off();
}

enable_trigger_with_targetname(msg) {
  trigger = GetEnt(msg, "targetname");
  trigger trigger_on();
}

enable_trigger_with_noteworthy(msg) {
  trigger = GetEnt(msg, "script_noteworthy");
  trigger trigger_on();
}

is_hero() {
  return isDefined(level.hero_list[get_ai_number()]);
}

get_ai_number() {
  if(!isDefined(self.unique_id)) {
    set_ai_number();
  }
  return self.unique_id;
}

set_ai_number() {
  self.unique_id = "ai" + level.ai_number;
  level.ai_number++;
}

make_hero() {
  level.hero_list[self.unique_id] = true;
}

unmake_hero() {
  level.hero_list[self.unique_id] = undefined;
}

get_heroes() {
  array = [];
  ai = GetAIArray("allies");
  for(i = 0; i < ai.size; i++) {
    if(ai[i] is_hero()) {
      array[array.size] = ai[i];
    }
  }
  return array;
}

set_team_pacifist(team, val) {
  ai = GetAIArray(team);
  for(i = 0; i < ai.size; i++) {
    ai[i].pacifist = val;
  }
}

remove_dead_from_array(array) {
  newarray = [];
  foreach(item in array) {
    if(!isalive(item)) {
      continue;
    }
    newarray[newarray.size] = item;
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

remove_color_from_array(array, color) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    guy = array[i];
    if(!isDefined(guy.script_forcecolor)) {
      continue;
    }
    if(guy.script_forcecolor == color) {
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
    if(!isDefined(guy.script_noteworthy)) {
      continue;
    }
    if(guy.script_noteworthy == noteworthy) {
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
    friendly_origin = level.player.origin;
  } else {
    friendly_origin = origin;
  }

  return getClosest(friendly_origin, allies);
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
    friendly_origin = level.player.origin;
  } else {
    friendly_origin = origin;
  }

  allies = remove_without_classname(allies, classname);

  return getClosest(friendly_origin, allies);
}

promote_nearest_friendly(colorFrom, colorTo) {
  for(;;) {
    friendly = get_closest_colored_friendly(colorFrom);
    if(!isalive(friendly)) {
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
    if(!isalive(friendly)) {
      AssertEx(0, "Instant promotion from " + colorFrom + " to " + colorTo + " failed!");
      return;
    }

    friendly set_force_color(colorTo);
    return;
  }
}

instantly_promote_nearest_friendly_with_classname(colorFrom, colorTo, classname) {
  for(;;) {
    friendly = get_closest_colored_friendly_with_classname(colorFrom, classname);
    if(!isalive(friendly)) {
      AssertEx(0, "Instant promotion from " + colorFrom + " to " + colorTo + " failed!");
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

riotshield_lock_orientation(yaw_angle) {
  self OrientMode("face angle", yaw_angle);
  self.lockOrientation = true;
}

riotshield_unlock_orientation() {
  self.lockOrientation = false;
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

  level endon(msg);
  wait timer;
}

wait_for_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait timer;
}

wait_for_trigger_or_timeout(timer) {
  self endon("trigger");
  wait timer;
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

dronespawn_bodyonly(spawner) {
  drone = maps\_spawner::spawner_dronespawn(spawner);
  Assert(isDefined(drone));

  return drone;
}

dronespawn(spawner) {
  if(!isDefined(spawner)) {
    spawner = self;
  }
  drone = maps\_spawner::spawner_dronespawn(spawner);
  Assert(isDefined(drone));

  AssertEx(isDefined(level.drone_spawn_func), "You need to put maps\_drone_civilian::init(); OR maps\_drone_ai::init(); in your level script! Use the civilian version if your drone is a civilian and the _ai version if it's a friendly or enemy.");
  drone[[level.drone_spawn_func]]();

  drone.spawn_funcs = spawner.spawn_functions;
  drone thread maps\_spawner::run_spawn_functions();

  drone.spawner = spawner;

  return drone;
}

swap_ai_to_drone(ai) {
  return maps\_spawner::spawner_swap_ai_to_drone(ai);
}

swap_drone_to_ai(drone) {
  return maps\_spawner::spawner_swap_drone_to_ai(drone);
}

get_trigger_flag() {
  if(isDefined(self.script_flag)) {
    return self.script_flag;
  }

  if(isDefined(self.script_noteworthy)) {
    return self.script_noteworthy;
  }

  AssertEx(0, "Flag trigger at " + self.origin + " has no script_flag set.");
}

set_default_pathenemy_settings() {
  self.pathenemylookahead = 192;
  self.pathenemyfightdist = 192;
}

cqb_walk(on_or_off) {
  if(on_or_off == "on") {
    self enable_cqbwalk();
  } else {
    Assert(on_or_off == "off");
    self disable_cqbwalk();
  }
}

enable_cqbwalk(autoEnabled) {
  if(self.type == "dog") {
    return;
  }

  if(!isDefined(autoEnabled)) {
    self.cqbEnabled = true;
  }

  self.cqbwalking = true;
  self.turnRate = 0.2;
  level thread animscripts\cqb::findCQBPointsOfInterest();

  self thread animscripts\cqb::CQBDebug();
}

disable_cqbwalk() {
  if(self.type == "dog") {
    return;
  }

  self.cqbwalking = undefined;
  self.cqbEnabled = undefined;
  self.turnRate = 0.3;
  self.cqb_point_of_interest = undefined;

  self notify("end_cqb_debug");
}

enable_readystand() {
  self.bUseReadyIdle = true;
}

disable_readystand() {
  self.bUseReadyIdle = undefined;
}

cqb_aim(the_target) {
  if(!isDefined(the_target)) {
    self.cqb_target = undefined;
  } else {
    self.cqb_target = the_target;

    if(!isDefined(the_target.origin)) {
      AssertMsg("target passed into cqb_aim does not have an origin!");
    }
  }
}

set_force_cover(val) {
  AssertEx(!isDefined(val) || val == false || val == true, "invalid force cover set on guy");
  AssertEx(IsAlive(self), "Tried to set force cover on a dead guy");
  if(isDefined(val) && val) {
    self.forceSuppression = true;
  } else {
    self.forceSuppression = undefined;
  }
}

do_in_order(func1, param1, func2, param2) {
  if(isDefined(param1)) {
    [[func1]](param1);
  } else {
    [[func1]]();
  }
  if(isDefined(param2)) {
    [[func2]](param2);
  } else {
    [[func2]]();
  }
}

send_notify(msg, optional_param) {
  if(isDefined(optional_param)) {
    self notify(msg, optional_param);
  } else {
    self notify(msg);
  }
}

waittill_match_or_timeout(msg, match, timer) {
  ent = spawnStruct();
  ent endon("complete");
  ent delayThread(timer, ::send_notify, "complete");

  self waittillmatch(msg, match);
}

deleteEnt(ent) {
  ent notify("deleted");
  ent Delete();
}

first_touch(ent) {
  if(!isDefined(self.touched)) {
    self.touched = [];
  }

  AssertEx(isDefined(ent), "Ent is not defined!");
  AssertEx(isDefined(ent.unique_id), "Ent has no unique_id");

  if(isDefined(self.touched[ent.unique_id])) {
    return false;
  }

  self.touched[ent.unique_id] = true;
  return true;
}

getanim(anime) {
  AssertEx(isDefined(self.animname), "Called getanim on a guy with no animname");
  AssertEx(isDefined(level.scr_anim[self.animname][anime]), "Called getanim on an inexistent anim");
  return level.scr_anim[self.animname][anime];
}

hasanim(anime) {
  AssertEx(isDefined(self.animname), "Called getanim on a guy with no animname");
  return isDefined(level.scr_anim[self.animname][anime]);
}

getanim_from_animname(anime, animname) {
  AssertEx(isDefined(animname), "Must supply an animname");
  AssertEx(isDefined(level.scr_anim[animname][anime]), "Called getanim on an inexistent anim");
  return level.scr_anim[animname][anime];
}

getanim_generic(anime) {
  AssertEx(isDefined(level.scr_anim["generic"][anime]), "Called getanim_generic on an inexistent anim");
  return level.scr_anim["generic"][anime];
}

add_hint_string(name, string, optionalFunc) {
  if(!isDefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
  }

  AssertEx(isDefined(name), "Set a name for the hint string. This should be the same as the script_hint on the trigger_hint.");
  AssertEx(isDefined(string), "Set a string for the hint string. This is the string you want to appear when the trigger is hit.");
  AssertEx(!isDefined(level.trigger_hint_string[name]), "Tried to redefine hint " + name);

  level.trigger_hint_string[name] = string;
  PreCacheString(string);
  if(isDefined(optionalFunc)) {
    level.trigger_hint_func[name] = optionalFunc;
  }
}

show_hint(struct) {
  AssertEx(isDefined(struct.string), "Need a localized string associated with the hint");
  thread ShowHintPrint_struct(struct);
}

hide_hint(struct) {
  struct.timeout = true;
}

fire_radius(origin, radius) {
  if(level.createFX_enabled) {
    return;
  }

  trigger = spawn("trigger_radius", origin, 0, radius, 48);

  for(;;) {
    trigger waittill("trigger", other);
    AssertEx(IsPlayer(other), "Tried to burn a non player in a fire");
    level.player DoDamage(5, origin);
  }
}

clearThreatBias(group1, group2) {
  SetThreatBias(group1, group2, 0);
  SetThreatBias(group2, group1, 0);
}

ThrowGrenadeAtPlayerASAP() {
  animscripts\combat_utility::ThrowGrenadeAtPlayerASAP_combat_utility();
}

array_combine_keys(array1, array2) {
  if(!array1.size) {
    return array2;
  }
  keys = GetArrayKeys(array2);
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

try_forever_spawn() {
  export = self.export;
  for(;;) {
    AssertEx(isDefined(self), "Spawner with export " +
      export +" was deleted.");
    guy = self Dospawn();
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
  AssertEx(isDefined(anime), "Tried to set run anim but didn't specify which animation to ues");
  AssertEx(isDefined(self.animname), "Tried to set run anim on a guy that had no anim name");
  AssertEx(isDefined(level.scr_anim[self.animname][anime]), "Tried to set run anim but the anim was not defined in the maps _anim file");

  if(isDefined(alwaysRunForward)) {
    self.alwaysRunForward = alwaysRunForward;
  } else {
    self.alwaysRunForward = true;
  }

  self disable_turnAnims();
  self.run_overrideanim = level.scr_anim[self.animname][anime];
  self.walk_overrideanim = self.run_overrideanim;
}

set_dog_walk_anim() {
  AssertEx(self.type == "dog");

  self.a.movement = "walk";
  self.disablearrivals = true;
  self.disableexits = true;
  self.script_nobark = 1;
}

set_combat_stand_animset(fire_anim, aim_straight, idle_anim, reload_anim) {
  self animscripts\animset::init_animset_custom_stand(fire_anim, aim_straight, idle_anim, reload_anim);
}

set_move_animset(move_mode, move_anim, sprint_anim) {
  AssertEx(isDefined(anim.archetypes["soldier"][move_mode]), "Default anim set is not defined");

  animset = self lookupAnimArray(move_mode);

  if(IsArray(move_anim)) {
    Assert(move_anim.size == 4);

    animset["straight"] = move_anim[0];

    animset["move_f"] = move_anim[0];
    animset["move_l"] = move_anim[1];
    animset["move_r"] = move_anim[2];
    animset["move_b"] = move_anim[3];
  } else {
    animset["straight"] = move_anim;
    animset["move_f"] = move_anim;
  }

  if(isDefined(sprint_anim)) {
    animset["sprint"] = sprint_anim;
  }

  self.customMoveAnimSet[move_mode] = animset;
}

set_generic_idle_anim(anime) {
  AssertEx(isDefined(anime), "Tried to set generic idle but didn't specify which animation to ues");
  AssertEx(isDefined(level.scr_anim["generic"][anime]), "Tried to set generic run anim but the anim was not defined in the maps _anim file");

  idleAnim = level.scr_anim["generic"][anime];

  if(IsArray(idleAnim)) {
    self.specialIdleAnim = idleAnim;
  } else {
    self.specialIdleAnim[0] = idleAnim;
  }
}

set_idle_anim(anime) {
  AssertEx(isDefined(self.animname), "No animname!");
  AssertEx(isDefined(anime), "Tried to set idle anim but didn't specify which animation to ues");
  AssertEx(isDefined(level.scr_anim[self.animname][anime]), "Tried to set generic run anim but the anim was not defined in the maps _anim file");

  idleAnim = level.scr_anim[self.animname][anime];

  if(IsArray(idleAnim)) {
    self.specialIdleAnim = idleAnim;
  } else {
    self.specialIdleAnim[0] = idleAnim;
  }
}

clear_generic_idle_anim() {
  self.specialIdleAnim = undefined;
  self notify("stop_specialidle");
}

set_generic_run_anim(anime, alwaysRunForward) {
  set_generic_run_anim_array(anime, undefined, alwaysRunForward);
}

clear_generic_run_anim() {
  self notify("movemode");
  self enable_turnAnims();
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
}

set_generic_run_anim_array(anime, weights, alwaysRunForward) {
  AssertEx(isDefined(anime), "Tried to set generic run anim but didn't specify which animation to ues");
  AssertEx(isDefined(level.scr_anim["generic"][anime]), "Tried to set generic run anim but the anim was not defined in the maps _anim file");
  AssertEx(!isDefined(weights) || isDefined(level.scr_anim["generic"][weights]), "weights needs to be a valid entry in level.scr_anim");

  AssertEx(!isDefined(weights) || isarray(level.scr_anim["generic"][weights]), "weights needs to be an array of animation weights (ascending order)");

  AssertEx(isarray(level.scr_anim["generic"][anime]) ||
    !isDefined(weights), "its not valid to pass in a weights param and not an array of anims to run");

  AssertEx(!isDefined(weights) || (level.scr_anim["generic"][weights].size == level.scr_anim["generic"][anime].size), "the weights array must equal the size of the anims array");

  self notify("movemode");

  if(!isDefined(alwaysRunForward) || alwaysRunForward) {
    self.alwaysRunForward = true;
  } else {
    self.alwaysRunForward = undefined;
  }

  self disable_turnAnims();
  self.run_overrideanim = level.scr_anim["generic"][anime];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(weights)) {
    self.run_override_weights = level.scr_anim["generic"][weights];
    self.walk_override_weights = self.run_override_weights;
  } else {
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
  }
}

set_run_anim_array(anime, weights, alwaysRunForward) {
  AssertEx(isDefined(anime), "Tried to set generic run anim but didn't specify which animation to ues");
  AssertEx(isDefined(self.animname), "Tried to set run anim on a guy that had no anim name");
  AssertEx(isDefined(level.scr_anim[self.animname][anime]), "Tried to set run anim but the anim was not defined in the maps _anim file");
  self notify("movemode");

  if(!isDefined(alwaysRunForward) || alwaysRunForward) {
    self.alwaysRunForward = true;
  } else {
    self.alwaysRunForward = undefined;
  }

  self disable_turnAnims();
  self.run_overrideanim = level.scr_anim[self.animname][anime];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(weights)) {
    self.run_override_weights = level.scr_anim[self.animname][weights];
    self.walk_override_weights = self.run_override_weights;
  } else {
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
  }
}

clear_run_anim() {
  self notify("clear_run_anim");
  self notify("movemode");

  if(self.type == "dog") {
    self.a.movement = "run";
    self.disablearrivals = false;
    self.disableexits = false;
    self.script_nobark = undefined;
    return;
  }

  if(!isDefined(self.casual_killer)) {
    self enable_turnAnims();
  }

  self.alwaysRunForward = undefined;
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;

  self.run_override_weights = undefined;
  self.walk_override_weights = undefined;
}

debugvar(msg, timer) {
  SetDvarIfUninitialized(msg, timer);
  return GetDvarFloat(msg);
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

    if(self.code_classname == "script_vehicle") {
      speed = self Vehicle_GetSpeed();
      if(speed < fade_speed) {
        scale = speed / fade_speed;
        force = (base_force * scale);
      }
    }

    dist = DistanceSquared(self.origin, level.player.origin);
    scale = fade_distance / dist;
    if(scale > 1) {
      scale = 1;
    }
    force = (force * scale);
    total_force = force[0] + force[1] + force[2];

    if(total_force > 0.025) {
      PhysicsJitter(self.origin, outer_radius, inner_radius, force[2], force[2] * 2.0);
    }
  }
}

set_goal_entity(ent) {
  self SetGoalEntity(ent);
}

activate_trigger(name, type, triggeringEnt) {
  if(!isDefined(name)) {
    self activate_trigger_process(triggeringEnt);
  } else {
    array_thread(getEntArray(name, type), ::activate_trigger_process, triggeringEnt);
  }
}

activate_trigger_process(triggeringEnt) {
  AssertEx(!isDefined(self.trigger_off), "Tried to activate trigger that is OFF( either from trigger_off or from flags set on it through shift - G menu");

  self notify("trigger", triggeringEnt);
}

self_delete() {
  self Delete();
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
  Assert(isDefined(self));
  Assert(isDefined(sNotifyString));
  Assert(isDefined(fDelay));

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
  if(IsAI(self)) {
    self animscripts\shared::placeWeaponOn(self.weapon, "none");
  } else {
    self detach_attachments_from_weapon_model(self.weapon);
    self Detach(GetWeaponModel(self.weapon), "tag_weapon_right");
  }
}

gun_recall() {
  if(IsAI(self)) {
    self animscripts\shared::placeWeaponOn(self.weapon, "right");
  } else {
    self Attach(GetWeaponModel(self.weapon), "tag_weapon_right");
    self update_weapon_tag_visibility(self.weapon);
  }
}

update_weapon_tag_visibility(weapon) {
  if(isDefined(weapon) && weapon != "none") {
    weapon_and_attachment_models_array = GetWeaponAndAttachmentModels(weapon);
    attachments = array_remove_index(weapon_and_attachment_models_array, 0);
    foreach(attachment in attachments) {
      self Attach(attachment["worldModel"], attachment["attachTag"]);
    }

    self HideWeaponTags(weapon);
  }
}

detach_attachments_from_weapon_model(weapon) {
  if(isDefined(weapon) && weapon != "none") {
    weapon_and_attachment_models_array = GetWeaponAndAttachmentModels(weapon);
    attachments = array_remove_index(weapon_and_attachment_models_array, 0);
    foreach(attachment in attachments) {
      self Detach(attachment["worldModel"], attachment["attachTag"], false);
    }
  }
}

attach_player_current_weapon_to_rig(rig) {
  weapon = level.player GetCurrentWeapon();

  weapon_and_attachment_models_array = GetWeaponAndAttachmentModels(weapon);

  weapon_viewmodel = weapon_and_attachment_models_array[0]["weapon"];

  attachments = array_remove_index(weapon_and_attachment_models_array, 0);

  rig Attach(weapon_viewmodel, "TAG_WEAPON_RIGHT", true);

  foreach(attachment in attachments) {
    rig Attach(attachment["attachment"], attachment["attachTag"]);
  }

  rig HideWeaponTags(weapon);
}

place_weapon_on(weapon, location) {
  Assert(IsAI(self));

  if(!AIHasWeapon(weapon)) {
    animscripts\init::initWeapon(weapon);
  }

  animscripts\shared::placeWeaponOn(weapon, location);
}

forceUseWeapon(newWeapon, targetSlot) {
  Assert(isDefined(newWeapon));
  Assert(newWeapon != "none");
  Assert(isDefined(targetSlot));
  AssertEx((targetSlot == "primary") || (targetSlot == "secondary") || (targetSlot == "sidearm"), "Target slot is either primary, secondary or sidearm.");

  if(!animscripts\init::isWeaponInitialized(newWeapon)) {
    animscripts\init::initWeapon(newWeapon);
  }

  hasWeapon = (self.weapon != "none");
  isCurrentSideArm = usingSidearm();
  isNewSideArm = (targetSlot == "sidearm");
  isNewSecondary = (targetSlot == "secondary");

  if(hasWeapon && (isCurrentSideArm != isNewSideArm)) {
    Assert(self.weapon != newWeapon);

    if(isCurrentSideArm) {
      holsterTarget = "none";
    } else if(isNewSecondary) {
      holsterTarget = "back";
    } else {
      holsterTarget = "chest";
    }
    animscripts\shared::placeWeaponOn(self.weapon, holsterTarget);

    self.lastWeapon = self.weapon;
  } else {
    self.lastWeapon = newWeapon;
  }

  animscripts\shared::placeWeaponOn(newWeapon, "right");

  if(isNewSideArm) {
    self.sideArm = newWeapon;
  } else if(isNewSecondary) {
    self.secondaryweapon = newWeapon;
  } else {
    self.primaryweapon = newWeapon;
  }

  self.weapon = newWeapon;
  self.bulletsinclip = WeaponClipSize(self.weapon);
  self notify("weapon_switch_done");
}

lerp_player_view_to_tag(player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc) {
  lerp_player_view_to_tag_internal(player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, false);
}

lerp_player_view_to_tag_and_hit_geo(player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc) {
  lerp_player_view_to_tag_internal(player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, true);
}

lerp_player_view_to_position(origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo, player) {
  player = get_player_from_self();

  linker = spawn("script_origin", (0, 0, 0));
  linker.origin = player.origin;
  linker.angles = player GetPlayerAngles();

  if(isDefined(hit_geo) && hit_geo) {
    player PlayerLinkTo(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);
  } else {
    if(isDefined(right_arc)) {}
    player PlayerLinkTo(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc);
  } else {
    if(isDefined(fraction)) {}
    player PlayerLinkTo(linker, "", fraction);
  } else {
    player PlayerLinkTo(linker);
  }

  linker MoveTo(origin, lerptime, lerptime * 0.25);
  linker RotateTo(angles, lerptime, lerptime * 0.25);
  wait(lerptime);
  linker Delete();
}

lerp_player_view_to_tag_oldstyle(player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc) {
  lerp_player_view_to_tag_oldstyle_internal(player, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, false);
}

lerp_player_view_to_position_oldstyle(origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  player = get_player_from_self();

  linker = spawn("script_origin", (0, 0, 0));
  linker.origin = player get_player_feet_from_view();
  linker.angles = player GetPlayerAngles();

  if(isDefined(hit_geo)) {
    player PlayerLinkToDelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);
  } else {
    if(isDefined(right_arc)) {}
    player PlayerLinkToDelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc);
  } else {
    if(isDefined(fraction)) {}
    player PlayerLinkToDelta(linker, "", fraction);
  } else {
    player PlayerLinkToDelta(linker);
  }

  linker MoveTo(origin, lerptime, lerptime * 0.25);
  linker RotateTo(angles, lerptime, lerptime * 0.25);
  wait(lerptime);
  linker Delete();
}

player_moves(dist) {
  org = level.player.origin;
  for(;;) {
    if(Distance(org, level.player.origin) > dist) {
      break;
    }
    wait(0.05);
  }
}

waittill_either_function(func1, parm1, func2, parm2) {
  ent = spawnStruct();
  thread waittill_either_function_internal(ent, func1, parm1);
  thread waittill_either_function_internal(ent, func2, parm2);
  ent waittill("done");
}

waittill_msg(msg) {
  self waittill(msg);
}

display_hint(hint, parm1, parm2, parm3, y_offset) {
  player = get_player_from_self();

  if(isDefined(level.trigger_hint_func[hint])) {
    if(player[[level.trigger_hint_func[hint]]]()) {
      return;
    }

    player thread HintPrint(level.trigger_hint_string[hint], level.trigger_hint_func[hint], parm1, parm2, parm3, undefined, undefined, y_offset);
  } else {
    player thread HintPrint(level.trigger_hint_string[hint], undefined, undefined, undefined, undefined, undefined, undefined, y_offset);
  }
}

HintDisplayHandler(hint, timeout, param1, param2, param3, y_offest) {
  HintDisplayHandlerSetup(hint);

  if(!isDefined(timeout)) {
    display_hint(hint, param1, param2, param3, y_offest);
  } else {
    display_hint_timeout(hint, timeout, param1, param2, param3, y_offest);
  }
}

HintDisplayMintimeHandler(hint, timeout, mintime, param1, param2, param3) {
  player = get_player_from_self();
  AssertEx(isDefined(level.trigger_hint_func[hint]), "Can't have a hint with a timeout if is has no break function, because hints without break functions display for a set period of time.");

  if(player[[level.trigger_hint_func[hint]]]()) {
    return;
  }

  HintDisplayHandlerSetup(hint);

  player thread HintPrint(level.trigger_hint_string[hint], level.trigger_hint_func[hint], param1, param2, param3, timeout, mintime);
}

add_control_based_hint_strings(name, defaultGamepadString, breakFunc, pcString, southpawString) {
  if(!isDefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
  }

  AssertEx(isDefined(name), "Set a name for the hint string. This should be the same as the script_hint on the trigger_hint.");
  AssertEx(isDefined(defaultGamepadString), "Set a string for the hint string. This is the string you want to appear when the trigger is hit.");
  AssertEx(!isDefined(level.trigger_hint_string[name]), "Tried to redefine hint " + name);

  level.trigger_hint_string[name] = defaultGamepadString;
  level.hint_list[name]["gamepad"] = defaultGamepadString;
  level.hint_list[name]["pc"] = pcString;
  level.hint_list[name]["southpaw"] = southpawString;

  PreCacheString(defaultGamepadString);

  if(isDefined(pcString)) {
    PreCacheString(pcString);
  }
  if(isDefined(southpawString)) {
    PreCacheString(southpawString);
  }

  if(isDefined(breakFunc)) {
    level.trigger_hint_func[name] = breakFunc;
  }

  AssertEx(isDefined(level.trigger_hint_string[name]), name + " is not a valid hint string.");
}

HandleTriggerHintInputTypeText() {
  if(!isDefined(level.hint_triggers)) {
    level.hint_triggers = [];
  }

  while(1) {
    level.hint_triggers = array_removeUndefined(level.hint_triggers);
    if(isDefined(level.hint_triggers) && isDefined(level.player)) {
      foreach(trigger in level.hint_triggers) {
        if(level.player is_player_gamepad_enabled()) {
          trigger SetHintString(trigger.gp_hint_text);
        } else {
          trigger SetHintString(trigger.pc_hint_text);
        }
      }
    }
    wait(0.1);
  }
}

AddHintTrigger(gamepadHintText, pcHintText) {
  AssertEx(isDefined(gamepadHintText), "gamepadHintText must be defined");
  AssertEx(isDefined(pcHintText), "pcHintText must be defined");

  if(!isDefined(level.hint_triggers)) {
    thread HandleTriggerHintInputTypeText();
    level.hint_triggers = [];
  }

  trigger_already_exists = false;

  foreach(trig in level.hint_triggers) {
    if(self == trig) {
      trig.gp_hint_text = gamepadHintText;
      trig.pc_hint_text = pcHintText;
      trigger_already_exists = true;
      break;
    }
  }

  if(!trigger_already_exists) {
    self.gp_hint_text = gamepadHintText;
    self.pc_hint_text = pcHintText;

    level.hint_triggers = array_add(level.hint_triggers, self);
  }
}

display_hint_timeout(hint, timeout, parm1, parm2, parm3, y_offset) {
  player = get_player_from_self();

  AssertEx(isDefined(level.trigger_hint_func[hint]), "Can't have a hint with a timeout if is has no break function, because hints without break functions display for a set period of time.");

  if(player[[level.trigger_hint_func[hint]]]()) {
    return;
  }

  player thread HintPrint(level.trigger_hint_string[hint], level.trigger_hint_func[hint], parm1, parm2, parm3, timeout, undefined, y_offset);
}

display_hint_timeout_mintime(hint, timeout, mintime, parm1, parm2, parm3) {
  player = get_player_from_self();
  AssertEx(isDefined(level.trigger_hint_func[hint]), "Can't have a hint with a timeout if is has no break function, because hints without break functions display for a set period of time.");

  if(player[[level.trigger_hint_func[hint]]]()) {
    return;
  }

  player thread HintPrint(level.trigger_hint_string[hint], level.trigger_hint_func[hint], parm1, parm2, parm3, timeout, mintime);
}

display_hint_stick(base_hint, pc_suffix, gamepad_suffix, gamepad_s_suffix, gamepad_ps3_suffix, gamepad_s_ps3_suffix, use_southpaw_for_legacy, parm1, parm2, parm3) {
  if(!isDefined(use_southpaw_for_legacy)) {
    use_southpaw_for_legacy = false;
  }

  cur_hint_string = hint_stick_get_updated(base_hint, pc_suffix, gamepad_suffix, gamepad_s_suffix, gamepad_ps3_suffix, gamepad_s_ps3_suffix, use_southpaw_for_legacy);
  thread display_hint(cur_hint_string, parm1, parm2, parm3);
  thread hint_stick_update(base_hint, pc_suffix, gamepad_suffix, gamepad_s_suffix, gamepad_ps3_suffix, gamepad_s_ps3_suffix, use_southpaw_for_legacy);
}

display_hint_stick_timeout(base_hint, timeout, pc_suffix, gamepad_suffix, gamepad_s_suffix, gamepad_ps3_suffix, gamepad_s_ps3_suffix, use_southpaw_for_legacy, parm1, parm2, parm3) {
  if(!isDefined(use_southpaw_for_legacy)) {
    use_southpaw_for_legacy = false;
  }

  cur_hint_string = hint_stick_get_updated(base_hint, pc_suffix, gamepad_suffix, gamepad_s_suffix, gamepad_ps3_suffix, gamepad_s_ps3_suffix, use_southpaw_for_legacy);
  thread display_hint_timeout(cur_hint_string, timeout, parm1, parm2, parm3);
  thread hint_stick_update(base_hint, pc_suffix, gamepad_suffix, gamepad_s_suffix, gamepad_ps3_suffix, gamepad_s_ps3_suffix, use_southpaw_for_legacy);
}

display_hint_stick_timeout_mintime(base_hint, timeout, mintime, pc_suffix, gamepad_suffix, gamepad_s_suffix, gamepad_ps3_suffix, gamepad_s_ps3_suffix, use_southpaw_for_legacy, parm1, parm2, parm3) {
  if(!isDefined(use_southpaw_for_legacy)) {
    use_southpaw_for_legacy = false;
  }

  cur_hint_string = hint_stick_get_updated(base_hint, pc_suffix, gamepad_suffix, gamepad_s_suffix, gamepad_ps3_suffix, gamepad_s_ps3_suffix, use_southpaw_for_legacy);
  thread display_hint_timeout_mintime(cur_hint_string, timeout, mintime, parm1, parm2, parm3);
  thread hint_stick_update(base_hint, pc_suffix, gamepad_suffix, gamepad_s_suffix, gamepad_ps3_suffix, gamepad_s_ps3_suffix, use_southpaw_for_legacy);
}

check_hint_condition(hint, parm1, parm2, parm3) {
  AssertEx(isDefined(level.trigger_hint_func[hint]), "Can't have a hint with a timeout if is has no break function, because hints without break functions display for a set period of time.");
  if(isDefined(parm3)) {
    return [[level.trigger_hint_func[hint]]](parm1, parm2, parm3);
  }
  if(isDefined(parm2)) {
    return [[level.trigger_hint_func[hint]]](parm1, parm2);
  }
  if(isDefined(parm1)) {
    return [[level.trigger_hint_func[hint]]](parm1);
  }
  return [[level.trigger_hint_func[hint]]]();
}

getGenericAnim(anime) {
  AssertEx(isDefined(level.scr_anim["generic"][anime]), "Generic anim " + anime + " was not defined in your _anim file.");
  return level.scr_anim["generic"][anime];
}

enable_careful() {
  AssertEx(IsAI(self), "Tried to make an ai careful but it wasn't called on an AI");
  self.script_careful = true;
}

disable_careful() {
  AssertEx(IsAI(self), "Tried to unmake an ai careful but it wasn't called on an AI");
  self.script_careful = false;
  self notify("stop_being_careful");
}

enable_sprint() {
  AssertEx(IsAI(self), "Tried to make an ai sprint but it wasn't called on an AI");
  self.sprint = true;
}

disable_sprint() {
  AssertEx(IsAI(self), "Tried to unmake an ai sprint but it wasn't called on an AI");
  self.sprint = undefined;
}

disable_bulletwhizbyreaction() {
  self.disableBulletWhizbyReaction = true;
}

enable_bulletwhizbyreaction() {
  self.disableBulletWhizbyReaction = undefined;
}

clear_dvar(msg) {
  SetDvar(msg, "");
}

set_fixednode_true() {
  self.fixednode = true;
}

set_fixednode_false() {
  self.fixednode = false;
}

spawn_ai(bForceSpawn, bMagicBulletShield) {
  if(isDefined(self.script_delay_spawn)) {
    self endon("death");
    wait(self.script_delay_spawn);
  }
  spawnedGuy = undefined;

  dontShareEnemyInfo = (isDefined(self.script_stealth) && flag("_stealth_enabled") && !flag("_stealth_spotted"));

  if((isDefined(self.script_forcespawn)) || (isDefined(bForceSpawn))) {
    if(!isDefined(self.script_drone)) {
      spawnedGuy = self Stalingradspawn(dontShareEnemyInfo);
    } else {
      spawnedGuy = dronespawn(self);
    }
  } else {
    if(!isDefined(self.script_drone)) {
      spawnedGuy = self Dospawn(dontShareEnemyInfo);
    } else {
      spawnedGuy = dronespawn(self);
    }
  }

  if(isDefined(bMagicBulletShield) && bMagicBulletShield && IsAlive(spawnedGuy)) {
    spawnedGuy magic_bullet_shield();
  }

  if(!isDefined(self.script_drone)) {
    spawn_failed(spawnedGuy);
  }

  if(isDefined(self.script_spawn_once)) {
    self Delete();
  }

  if(isDefined(spawnedGuy)) {
    spawnedGuy.spawner = self;
  }

  if(isDefined(spawnedGuy) && !isDefined(spawnedGuy.targetname)) {
    if(isDefined(self.targetname)) {
      spawnedGuy.targetname = self.targetname + "_AI";
    }
  }

  return spawnedGuy;
}

function_stack(func, param1, param2, param3, param4, param5) {
  localentity = spawnStruct();
  localentity thread function_stack_proc(self, func, param1, param2, param3, param4, param5);

  return self function_stack_wait_finish(localentity);
}

function_stack_timeout(timeout, func, param1, param2, param3, param4, param5) {
  localentity = spawnStruct();
  localentity thread function_stack_proc(self, func, param1, param2, param3, param4, param5);

  if(isDefined(localentity.function_stack_func_begun) || (localentity waittill_any_timeout(timeout, "function_stack_func_begun") != "timeout")) {
    return self function_stack_wait_finish(localentity);
  } else {
    localentity notify("death");
    return false;
  }
}

function_stack_clear() {
  newstack = [];
  if(isDefined(self.function_stack[0]) && isDefined(self.function_stack[0].function_stack_func_begun)) {
    newstack[0] = self.function_stack[0];
  }

  self.function_stack = undefined;
  self notify("clear_function_stack");

  waittillframeend;

  if(!newstack.size) {
    return;
  }

  if(!newstack[0].function_stack_func_begun) {
    return;
  }

  self.function_stack = newstack;
}

geo_off() {
  if(isDefined(self.geo_off)) {
    return;
  }

  self.realorigin = self GetOrigin();
  self MoveTo(self.realorigin + (0, 0, -10000), .2);

  self.geo_off = true;
}

geo_on() {
  if(!isDefined(self.geo_off)) {
    return;
  }

  self MoveTo(self.realorigin, .2);
  self waittill("movedone");
  self.geo_off = undefined;
}

disable_exits() {
  self.disableexits = true;
}

enable_exits() {
  self.disableexits = undefined;
}

disable_turnAnims() {
  self.noTurnAnims = true;
}

enable_turnAnims() {
  self.noTurnAnims = undefined;
}

disable_arrivals() {
  self.disablearrivals = true;
}

enable_arrivals() {
  self endon("death");

  waittillframeend;
  self.disablearrivals = undefined;
}

set_blur(magnitude, time) {
  SetBlur(magnitude, time);
}

set_goal_radius(radius) {
  self.goalradius = radius;
}

set_goal_node(node) {
  self.last_set_goalnode = node;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;

  self SetGoalNode(node);
}

set_goal_node_targetname(targetname) {
  Assert(isDefined(targetname));
  node = GetNode(targetname, "targetname");
  Assert(isDefined(node));

  self set_goal_node(node);
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

objective_complete(obj) {
  objective_recon(obj);

  Objective_State(obj, "done");
  level notify("objective_complete" + obj);
}

handsignal(xanim, waitAnimDone, ender, waiter) {
  returnImmediate = true;
  if(isDefined(waitAnimDone)) {
    returnImmediate = !waitAnimDone;
  }

  if(isDefined(ender)) {
    level endon(ender);
  }

  if(isDefined(waiter)) {
    level waittill(waiter);
  }

  animName = "signal_" + xanim;

  if(self.a.pose == "crouch") {
    animName = animName + "_crouch";
  } else if(self.script == "cover_right" || (self.script == "cover_multi" && self.cover.state == "right")) {
    animName = animName + "_coverR";
  } else if(self isCQBWalking()) {
    animName = animName + "_cqb";
  }

  if(returnImmediate) {
    self SetAnimRestart(getGenericAnim(animName), 1, 0, 1.1);
  } else {
    self maps\_anim::anim_generic(self, animName);
  }
}

array_spawn(spawners, bForceSpawn, skipIncorrectNumberAssert) {
  if(!isDefined(skipIncorrectNumberAssert)) {
    skipIncorrectNumberAssert = 0;
  }

  guys = [];
  foreach(spawner in spawners) {
    spawner.count = 1;

    if(GetSubStr(spawner.classname, 7, 10) == "veh") {
      guy = spawner spawn_vehicle();

      if(isDefined(spawner.export)) {
        AssertEx(IsAlive(guy), "Vehicle with export " + spawner.export+" failed to spawn.");
      } else {
        AssertEx(IsAlive(guy), "Vehicle at " + spawner.origin + " failed to spawn.");
      }

      if(isDefined(guy.target) && !isDefined(guy.script_moveoverride)) {
        guy thread maps\_vehicle::gopath();
      }
      guys[guys.size] = guy;
    } else {
      guy = spawner spawn_ai(bForceSpawn);

      if(!skipIncorrectNumberAssert) {
        AssertEx(IsAlive(guy), "Guy with export " + spawner.export+" failed to spawn.");
      }
      guys[guys.size] = guy;
    }
  }

  if(!skipIncorrectNumberAssert) {
    AssertEx(guys.size == spawners.size, "Didnt spawn correct number of guys");
  }

  return guys;
}

array_spawn_cg(spawners, bForceSpawn, skipIncorrectNumberAssert, spawnDelay) {
  if(!isDefined(skipIncorrectNumberAssert)) {
    skipIncorrectNumberAssert = 0;
  }

  guys = [];
  foreach(spawner in spawners) {
    spawner.count = 1;

    if(GetSubStr(spawner.classname, 7, 10) == "veh") {
      guy = spawner spawn_vehicle();

      if(isDefined(spawner.export)) {
        AssertEx(IsAlive(guy), "Vehicle with export " + spawner.export+" failed to spawn.");
      } else {
        AssertEx(IsAlive(guy), "Vehicle at " + spawner.origin + " failed to spawn.");
      }

      if(isDefined(guy.target) && !isDefined(guy.script_moveoverride)) {
        guy thread maps\_vehicle::gopath();
      }
      guys[guys.size] = guy;
    } else {
      guy = spawner spawn_ai(true);
      guys = array_add(guys, guy);
      if(isDefined(spawnDelay)) {
        wait spawnDelay;
      } else {
        waitframe();
      }
    }
  }

  if(!skipIncorrectNumberAssert) {
    AssertEx(guys.size == spawners.size, "Didnt spawn correct number of guys");
  }

  return guys;
}

array_spawn_targetname(targetname, forcespawn, skipIncorrectNumberAssert, deleteDronePool) {
  spawners = getEntArray(targetname, "targetname");
  if(isDefined(level.spawn_pool_enabled)) {
    struct_spawners = getstructarray(targetname, "targetname");
    if(isDefined(deleteDronePool) && deleteDronePool) {
      deletestructarray_ref(struct_spawners);
    }
    pool_spawners = maps\_spawner::get_pool_spawners_from_structarray(struct_spawners);
    spawners = array_combine(spawners, pool_spawners);
  }
  AssertEx(spawners.size, "Tried to spawn spawners with targetname " + targetname + " but there are no spawners");
  return array_spawn(spawners, forcespawn, skipIncorrectNumberAssert);
}

array_spawn_targetname_cg(targetname, forcespawn, spawnDelay, skipIncorrectNumberAssert, deleteDronePool) {
  spawners = getEntArray(targetname, "targetname");
  if(isDefined(level.spawn_pool_enabled)) {
    struct_spawners = getstructarray(targetname, "targetname");
    if(isDefined(deleteDronePool) && deleteDronePool) {
      deletestructarray_ref(struct_spawners);
    }
    pool_spawners = maps\_spawner::get_pool_spawners_from_structarray(struct_spawners);
    spawners = array_combine(spawners, pool_spawners);
  }
  AssertEx(spawners.size, "Tried to spawn spawners with targetname " + targetname + " but there are no spawners");
  return array_spawn_cg(spawners, forcespawn, skipIncorrectNumberAssert, spawnDelay);
}

array_spawn_noteworthy(noteworthy, forcespawn, skipIncorrectNumberAssert, deleteDronePool) {
  spawners = getEntArray(noteworthy, "script_noteworthy");
  if(isDefined(level.spawn_pool_enabled)) {
    struct_spawners = getstructarray(noteworthy, "script_noteworthy");
    if(isDefined(deleteDronePool) && deleteDronePool) {
      deletestructarray_ref(struct_spawners);
    }
    pool_spawners = maps\_spawner::get_pool_spawners_from_structarray(struct_spawners);
    spawners = array_combine(spawners, pool_spawners);
  }
  AssertEx(spawners.size, "Tried to spawn spawners with targetname " + noteworthy + " but there are no spawners");
  return array_spawn(spawners, forcespawn, skipIncorrectNumberAssert);
}

spawn_script_noteworthy(script_noteworthy, bForceSpawn) {
  spawner = GetEnt(script_noteworthy, "script_noteworthy");
  AssertEx(isDefined(spawner), "Spawner with script_noteworthy " + script_noteworthy + " does not exist.");

  guy = spawner spawn_ai(bForceSpawn);
  return guy;
}

spawn_targetname(targetname, bForceSpawn) {
  spawner = GetEnt(targetname, "targetname");
  AssertEx(isDefined(spawner), "Spawner with targetname " + targetname + " does not exist.");

  guy = spawner spawn_ai(bForceSpawn);
  return guy;
}

add_dialogue_line(name, msg, name_color) {
  if(GetDvarInt("loc_warnings", 0)) {
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
  color = "^3";

  if(isDefined(name_color)) {
    switch (name_color) {
      case "r":
      case "red":
        color = "^1";
        break;
      case "g":
      case "green":
        color = "^2";
        break;
      case "y":
      case "yellow":
        color = "^3";
        break;
      case "b":
      case "blue":
        color = "^4";
        break;
      case "c":
      case "cyan":
        color = "^5";
        break;
      case "p":
      case "purple":
        color = "^6";
        break;
      case "w":
      case "white":
        color = "^7";
        break;
      case "bl":
      case "black":
        color = "^8";
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
  hudelem FadeOverTime(0.5);
  hudelem.alpha = 1;
  hudelem.x = 40;
  hudelem.y = 260 + index * 18;
  hudelem.label = " " + color + "< " + name + " > ^7" + msg;
  hudelem.color = (1, 1, 1);

  wait(2);
  timer = 2 * 20;
  hudelem FadeOverTime(6);
  hudelem.alpha = 0;

  for(i = 0; i < timer; i++) {
    hudelem.color = (1, 1, 0 / (timer - i));
    wait(0.05);
  }
  wait(4);

  hudelem Destroy();

  level.dialogue_huds[index] = undefined;
}

destructible_disable_explosion() {
  self common_scripts\_destructible::disable_explosion();
}

destructible_force_explosion() {
  self common_scripts\_destructible::force_explosion();
}

set_grenadeammo(count) {
  self.grenadeammo = count;
}

get_player_feet_from_view() {
  Assert(IsPlayer(self));

  tagorigin = self.origin;
  upvec = AnglesToUp(self GetPlayerAngles());
  height = self GetPlayerViewHeight();

  player_eye = tagorigin + (0, 0, height);
  player_eye_fake = tagorigin + (upvec * height);

  diff_vec = player_eye - player_eye_fake;

  fake_origin = tagorigin + diff_vec;
  return fake_origin;
}

set_baseaccuracy(val) {
  self.baseaccuracy = val;
}

set_console_status() {
  if(!isDefined(level.Console)) {
    level.Console = GetDvar("consoleGame") == "true";
  } else {
    AssertEx(level.Console == (GetDvar("consoleGame") == "true"), "Level.console got set incorrectly.");
  }

  if(!isDefined(level.xenon)) {
    level.xenon = GetDvar("xenonGame") == "true";
  } else {
    AssertEx(level.xenon == (GetDvar("xenonGame") == "true"), "Level.xenon got set incorrectly.");
  }

  if(!isDefined(level.ps3)) {
    level.ps3 = GetDvar("ps3Game") == "true";
  } else {
    AssertEx(level.ps3 == (GetDvar("ps3Game") == "true"), "Level.ps3 got set incorrectly.");
  }

  if(!isDefined(level.wiiu)) {
    level.wiiu = GetDvar("wiiuGame") == "true";
  } else {
    AssertEx(level.wiiu == (GetDvar("wiiuGame") == "true"), "Level.wiiu got set incorrectly.");
  }

  if(!isDefined(level.pccg)) {
    level.pccg = GetDvar("pccgGame") == "true";
  } else {
    AssertEx(level.pccg == (GetDvar("pccgGame") == "true"), "Level.pccg got set incorrectly.");
  }

  if(!isDefined(level.xb3)) {
    level.xb3 = GetDvar("xb3Game") == "true";
  } else {
    AssertEx(level.xb3 == (GetDvar("xb3Game") == "true"), "Level.xb3 got set incorrectly.");
  }

  if(!isDefined(level.ps4)) {
    level.ps4 = GetDvar("ps4Game") == "true";
  } else {
    AssertEx(level.ps4 == (GetDvar("ps4Game") == "true"), "Level.ps4 got set incorrectly.");
  }

  if(!isDefined(level.pc)) {
    level.pc = !level.console && !level.pccg;
  } else {
    AssertEx(level.pc == (!level.console && !level.pccg), "Level.pc got set incorrectly.");
  }

  if(!isDefined(level.currentgen)) {
    level.currentgen = level.ps3 || level.pccg || level.xenon || level.wiiu;
  } else {
    AssertEx(level.currentgen == (level.ps3 || level.pccg || level.xenon || level.wiiu), "Level.currentgen got set incorrectly.");
  }

  if(!isDefined(level.nextgen)) {
    level.nextgen = level.pc || level.ps4 || level.xb3;
  } else {
    AssertEx(level.nextgen == (level.pc || level.ps4 || level.xb3), "Level.nextgen got set incorrectly.");
  }
}

is_gen4() {
  AssertEx(isDefined(level.nextgen), "is_gen4() called before set_console_status() has been run.");

  return level.nextgen;
}

autosave_now(suppress_print) {
  return maps\_autosave::_autosave_game_now(suppress_print);
}

autosave_now_silent() {
  return maps\_autosave::_autosave_game_now(true);
}

set_generic_deathanim(deathanim) {
  self.deathanim = getGenericAnim(deathanim);
}

set_deathanim(deathanim) {
  self.deathanim = getanim(deathanim);
}

clear_deathanim() {
  self.deathanim = undefined;
}

hunted_style_door_open(soundalias) {
  wait(1.75);

  if(isDefined(soundalias)) {
    self playSound(soundalias);
  } else {
    self playSound("door_wood_slow_open");
  }

  self RotateTo(self.angles + (0, 70, 0), 2, .5, 0);
  self ConnectPaths();
  self waittill("rotatedone");
  self RotateTo(self.angles + (0, 40, 0), 2, 0, 2);
}

palm_style_door_open(soundalias) {
  wait(1.35);

  if(isDefined(soundalias)) {
    self playSound(soundalias);
  } else {
    self playSound("door_wood_slow_open");
  }

  self RotateTo(self.angles + (0, 70, 0), 2, .5, 0);
  self ConnectPaths();
  self waittill("rotatedone");
  self RotateTo(self.angles + (0, 40, 0), 2, 0, 2);
}

lerp_fov_overtime(time, destfov) {
  foreach(player in level.players) {
    player LerpFOV(destfov, time);
  }
  wait time;
}

lerp_fovscale_overtime(time, destfovscale) {
  basefov = GetDvarFloat("cg_fovscale");
  incs = Int(time / .05);

  incfov = (destfovscale - basefov) / incs;
  currentfov = basefov;
  for(i = 0; i < incs; i++) {
    currentfov += incfov;
    SetSavedDvar("cg_fovscale", currentfov);
    wait .05;
  }

  SetSavedDvar("cg_fovscale", destfovscale);
}

putGunAway() {
  animscripts\shared::placeWeaponOn(self.weapon, "none");
  self.weapon = "none";
}

apply_fog() {
  maps\_art::set_fog_progress(0);
}

apply_end_fog() {
  maps\_art::set_fog_progress(1);
}

anim_stopanimscripted() {
  self StopAnimScripted();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
}

disable_pain() {
  AssertEx(IsAI(self), "Tried to disable pain on a non ai");
  self.a.disablePain = true;
  self.allowPain = false;
}

enable_pain() {
  AssertEx(IsAI(self), "Tried to enable pain on a non ai");
  self.a.disablePain = false;
  self.allowPain = true;
}

_delete() {
  self Delete();
}

_kill() {
  self Kill();
}

kill_wrapper() {
  if(isplayer(self)) {
    if(flag_exist("special_op_terminated") && flag("special_op_terminated")) {
      return false;
    }

    if(is_player_down(self)) {
      self disableinvulnerability();
    }
  }

  self EnableDeathShield(false);
  self kill();
  return true;
}

_setentitytarget(target) {
  self SetEntityTarget(target);
}

_ClearEntityTarget() {
  self ClearEntityTarget();
}

_unlink() {
  self Unlink();
}

disable_oneshotfx_with_noteworthy(noteworthy) {
  AssertEx(isDefined(level._global_fx_ents[noteworthy]), "No _global_fx ents have noteworthy " + noteworthy);
  keys = GetArrayKeys(level._global_fx_ents[noteworthy]);
  for(i = 0; i < keys.size; i++) {
    level._global_fx_ents[noteworthy][keys[i]].looper Delete();
    level._global_fx_ents[noteworthy][keys[i]] = undefined;
  }
}

_setLightIntensity(val) {
  self SetLightIntensity(val);
}

_linkto(targ, tag, org, angles) {
  if(isDefined(angles)) {
    self LinkTo(targ, tag, org, angles);
    return;
  }
  if(isDefined(org)) {
    self LinkTo(targ, tag, org);
    return;
  }
  if(isDefined(tag)) {
    self LinkTo(targ, tag);
    return;
  }
  self LinkTo(targ);
}

array_wait(array, msg, timeout) {
  keys = GetArrayKeys(array);
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
    if(isDefined(array[key]) && structs[key]._array_wait) {
      structs[key] waittill("_array_wait");
    }
  }
}

die() {
  self Kill((0, 0, 0));
}

getmodel(str) {
  AssertEx(isDefined(level.scr_model[str]), "Tried to getmodel on model " + str + " but level.scr_model[ " + str + " was not defined.");
  return level.scr_model[str];
}

isADS() {
  Assert(IsPlayer(self));
  return (self PlayerAds() > 0.5);
}

waittill_player_lookat(dot, timer, dot_only, timeout, ignore_ent, player) {
  if(!isDefined(player)) {
    player = level.player;
  }

  timeoutEnt = spawnStruct();
  if(isDefined(timeout)) {
    timeoutEnt thread notify_delay("timeout", timeout);
  }
  timeoutEnt endon("timeout");

  if(!isDefined(dot)) {
    dot = 0.92;
  }

  if(!isDefined(timer)) {
    timer = 0;
  }

  base_time = Int(timer * 20);
  count = base_time;
  self endon("death");
  ai_guy = IsAI(self);
  org = undefined;
  for(;;) {
    if(ai_guy) {
      org = self getEye();
    } else {
      org = self.origin;
    }

    if(player player_looking_at(org, dot, dot_only, ignore_ent)) {
      count--;
      if(count <= 0) {
        return true;
      }
    } else {
      count = base_time;
    }
    wait(0.05);
  }
}

waittill_player_lookat_for_time(timer, dot, dot_only, ignore_ent) {
  AssertEx(isDefined(timer), "Tried to do waittill_player_lookat_for_time with no time parm.");
  waittill_player_lookat(dot, timer, dot_only, undefined, ignore_ent);
}

player_looking_at(start, dot, dot_only, ignore_ent) {
  if(!isDefined(dot)) {
    dot = 0.8;
  }
  player = get_player_from_self();

  end = player getEye();

  angles = VectorToAngles(start - end);
  forward = anglesToForward(angles);
  player_angles = player GetPlayerAngles();
  player_forward = anglesToForward(player_angles);

  new_dot = VectorDot(forward, player_forward);
  if(new_dot < dot) {
    return false;
  }

  if(isDefined(dot_only)) {
    AssertEx(dot_only, "dot_only must be true or undefined");
    return true;
  }

  trace = bulletTrace(start, end, false, ignore_ent);
  return trace["fraction"] == 1;
}

either_player_looking_at(org, dot, dot_only, ignore_ent) {
  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] player_looking_at(org, dot, dot_only, ignore_ent)) {
      return true;
    }
  }
  return false;
}

player_can_see_ai(ai, latency) {
  currentTime = getTime();

  if(!isDefined(latency)) {
    latency = 0;
  }

  if(isDefined(ai.playerSeesMeTime) && ai.playerSeesMeTime + latency >= currentTime) {
    assert(isDefined(ai.playerSeesMe));
    return ai.playerSeesMe;
  }

  ai.playerSeesMeTime = currentTime;

  if(!within_fov(level.player.origin, level.player.angles, ai.origin, 0.766)) {
    ai.playerSeesMe = false;
    return false;
  }

  playerEye = level.player getEye();

  feetOrigin = ai.origin;
  if(SightTracePassed(playerEye, feetOrigin, true, level.player, ai)) {
    ai.playerSeesMe = true;
    return true;
  }

  eyeOrigin = ai getEye();
  if(SightTracePassed(playerEye, eyeOrigin, true, level.player, ai)) {
    ai.playerSeesMe = true;
    return true;
  }

  midOrigin = (eyeOrigin + feetOrigin) * 0.5;
  if(SightTracePassed(playerEye, midOrigin, true, level.player, ai)) {
    ai.playerSeesMe = true;
    return true;
  }

  ai.playerSeesMe = false;
  return false;
}

players_within_distance(fDist, org) {
  fDistSquared = fDist * fDist;
  for(i = 0; i < level.players.size; i++) {
    if(DistanceSquared(org, level.players[i].origin) < fDistSquared) {
      return true;
    }
  }
  return false;
}

AI_delete_when_out_of_sight(aAI_to_delete, fDist) {
  if(!isDefined(aAI_to_delete)) {
    return;
  }

  off_screen_dot = 0.75;
  if(IsSplitScreen()) {
    off_screen_dot = 0.65;
  }

  while(aAI_to_delete.size > 0) {
    wait(1);

    for(i = 0; i < aAI_to_delete.size; i++) {
      if((!isDefined(aAI_to_delete[i])) || (!isalive(aAI_to_delete[i]))) {
        aAI_to_delete = array_remove(aAI_to_delete, aAI_to_delete[i]);
        continue;
      }

      if(players_within_distance(fDist, aAI_to_delete[i].origin)) {
        continue;
      }
      if(either_player_looking_at(aAI_to_delete[i].origin + (0, 0, 48), off_screen_dot, true)) {
        continue;
      }

      if(isDefined(aAI_to_delete[i].magic_bullet_shield)) {
        aAI_to_delete[i] stop_magic_bullet_shield();
      }
      aAI_to_delete[i] Delete();
      aAI_to_delete = array_remove(aAI_to_delete, aAI_to_delete[i]);
    }
  }
}

add_wait(func, parm1, parm2, parm3) {
  thread add_wait_asserter();

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

add_abort(func, parm1, parm2, parm3) {
  thread add_wait_asserter();

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

  level.abort_wait_any_func_array[level.abort_wait_any_func_array.size] = ent;
}

add_func(func, parm1, parm2, parm3, parm4, parm5) {
  thread add_wait_asserter();

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
  if(isDefined(parm4)) {
    ent.parms[ent.parms.size] = parm4;
  }
  if(isDefined(parm5)) {
    ent.parms[ent.parms.size] = parm5;
  }

  level.run_func_after_wait_array[level.run_func_after_wait_array.size] = ent;
}

add_call(func, parm1, parm2, parm3, parm4, parm5) {
  thread add_wait_asserter();

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
  if(isDefined(parm4)) {
    ent.parms[ent.parms.size] = parm4;
  }
  if(isDefined(parm5)) {
    ent.parms[ent.parms.size] = parm5;
  }

  level.run_call_after_wait_array[level.run_call_after_wait_array.size] = ent;
}

add_noself_call(func, parm1, parm2, parm3, parm4, parm5) {
  thread add_wait_asserter();

  ent = spawnStruct();

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
  if(isDefined(parm4)) {
    ent.parms[ent.parms.size] = parm4;
  }
  if(isDefined(parm5)) {
    ent.parms[ent.parms.size] = parm5;
  }

  level.run_noself_call_after_wait_array[level.run_noself_call_after_wait_array.size] = ent;
}

add_endon(name) {
  thread add_wait_asserter();

  ent = spawnStruct();
  ent.caller = self;
  ent.ender = name;

  level.do_wait_endons_array[level.do_wait_endons_array.size] = ent;
}

do_wait_any() {
  AssertEx(isDefined(level.wait_any_func_array), "Tried to do a do_wait without addings funcs first");
  AssertEx(level.wait_any_func_array.size > 0, "Tried to do a do_wait without addings funcs first");
  do_wait(level.wait_any_func_array.size - 1);
}

do_wait(count_to_reach) {
  if(!isDefined(count_to_reach)) {
    count_to_reach = 0;
  }

  level notify("kill_add_wait_asserter");

  AssertEx(isDefined(level.wait_any_func_array), "Tried to do a do_wait without addings funcs first");
  ent = spawnStruct();
  array = level.wait_any_func_array;
  endons = level.do_wait_endons_array;
  after_array = level.run_func_after_wait_array;
  call_array = level.run_call_after_wait_array;
  nscall_array = level.run_noself_call_after_wait_array;
  abort_array = level.abort_wait_any_func_array;

  level.wait_any_func_array = [];
  level.run_func_after_wait_array = [];
  level.do_wait_endons_array = [];
  level.abort_wait_any_func_array = [];
  level.run_call_after_wait_array = [];
  level.run_noself_call_after_wait_array = [];

  ent.count = array.size;

  ent array_levelthread(array, ::waittill_func_ends, endons);
  ent thread do_abort(abort_array);

  ent endon("any_funcs_aborted");

  for(;;) {
    if(ent.count <= count_to_reach) {
      break;
    }
    ent waittill("func_ended");
  }
  ent notify("all_funcs_ended");

  array_levelthread(after_array, ::exec_func, []);
  array_levelthread(call_array, ::exec_call);
  array_levelthread(nscall_array, ::exec_call_noself);
}

do_funcs() {
  level notify("kill_add_wait_asserter");

  AssertEx(isDefined(level.wait_any_func_array), "Tried to do a do_wait without addings funcs first");
  ent = spawnStruct();

  AssertEx(!level.wait_any_func_array.size, "Don't use add_wait and do_funcs together.");
  AssertEx(!level.do_wait_endons_array.size, "Don't use add_endon and do_funcs together.");
  AssertEx(!level.run_call_after_wait_array.size, "Don't use add_call and do_funcs together.");
  AssertEx(!level.run_noself_call_after_wait_array.size, "Don't use add_call and do_funcs together.");
  AssertEx(!level.abort_wait_any_func_array.size, "Do_funcs doesn't support add_abort.");

  after_array = level.run_func_after_wait_array;

  level.run_func_after_wait_array = [];

  foreach(func_struct in after_array) {
    level exec_func(func_struct, []);
  }

  ent notify("all_funcs_ended");
}

is_default_start() {
  if(isDefined(level.forced_start_catchup) && level.forced_start_catchup == true) {
    return false;
  }

  if(isDefined(level.default_start_override) && level.default_start_override == level.start_point) {
    return true;
  }

  if(isDefined(level.default_start)) {
    return level.start_point == "default";
  }

  if(level_has_start_points()) {
    return level.start_point == level.start_functions[0]["name"];
  }

  return level.start_point == "default";
}

force_start_catchup() {
  level.forced_start_catchup = true;
}

is_first_start() {
  if(!level_has_start_points()) {
    return true;
  }

  return level.start_point == level.start_functions[0]["name"];
}

is_after_start(name) {
  hit_current_start = false;

  if(level.start_point == name) {
    return false;
  }

  for(i = 0; i < level.start_functions.size; i++) {
    if(level.start_functions[i]["name"] == name) {
      hit_current_start = true;
      continue;
    }
    if(level.start_functions[i]["name"] == level.start_point) {
      return hit_current_start;
    }
  }
}

_Earthquake(scale, duration, source, radius) {
  Earthquake(scale, duration, source, radius);
}

waterfx(endflag, soundalias) {
  self endon("death");

  play_sound = false;
  if(isDefined(soundalias)) {
    play_sound = true;
  }

  if(isDefined(endflag)) {
    flag_assert(endflag);
    level endon(endflag);
  }
  for(;;) {
    wait(RandomFloatRange(0.15, 0.3));
    start = self.origin + (0, 0, 150);
    end = self.origin - (0, 0, 150);
    trace = bulletTrace(start, end, false, undefined);
    if(!IsSubStr(trace["surfacetype"], "water")) {
      continue;
    }

    fx = "water_movement";

    if(IsPlayer(self)) {
      if(Distance(self GetVelocity(), (0, 0, 0)) < 5) {
        fx = "water_stop";
      }
    } else if(isDefined(level._effect["water_" + self.a.movement])) {
      fx = "water_" + self.a.movement;
    }

    water_fx = getfx(fx);
    start = trace["position"];

    angles = (0, self.angles[1], 0);
    forward = anglesToForward(angles);
    up = anglestoup(angles);
    playFX(water_fx, start, up, forward);

    if(fx != "water_stop" && play_sound) {
      thread play_sound_in_space(soundalias, start);
    }
  }
}

playerSnowFootsteps(endflag) {
  if(isDefined(endflag)) {
    flag_assert(endflag);
    level endon(endflag);
  }

  for(;;) {
    wait(RandomFloatRange(0.25, .5));
    start = self.origin + (0, 0, 0);
    end = self.origin - (0, 0, 5);
    trace = bulletTrace(start, end, false, undefined);
    forward = anglesToForward(self.angles);
    mydistance = Distance(self GetVelocity(), (0, 0, 0));
    if(isDefined(self.vehicle)) {
      continue;
    }
    if(trace["surfacetype"] != "snow") {
      continue;
    }
    if(mydistance <= 10) {
      continue;
    }
    fx = "snow_movement";

    if(Distance(self GetVelocity(), (0, 0, 0)) <= 154) {
      playFX(getfx("footstep_snow_small"), trace["position"], trace["normal"], forward);
    }
    if(Distance(self GetVelocity(), (0, 0, 0)) > 154) {
      playFX(getfx("footstep_snow"), trace["position"], trace["normal"], forward);
    }
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

nextmission() {
  mission_recon();

  maps\_endmission::_nextmission();
}

make_array(index1, index2, index3, index4, index5) {
  AssertEx(isDefined(index1), "Need to define index 1 at least");
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
  level.failOnFriendlyFire = true;
}

normal_friendly_fire_penalty() {
  level.failOnFriendlyFire = false;
}

getPlayerClaymores() {
  Assert(IsPlayer(self));

  heldweapons = self GetWeaponsListAll();
  stored_ammo = [];
  for(i = 0; i < heldweapons.size; i++) {
    weapon = heldweapons[i];
    stored_ammo[weapon] = self GetWeaponAmmoClip(weapon);
  }

  claymoreCount = 0;
  if(isDefined(stored_ammo["claymore"]) && stored_ammo["claymore"] > 0) {
    claymoreCount = stored_ammo["claymore"];
  }
  return claymoreCount;
}

_wait(timer) {
  wait(timer);
}

_waittillmatch(msg, match) {
  self waittillmatch(msg, match);
}

_setsaveddvar(var, val) {
  SetSavedDvar(var, val);
}

lerp_savedDvar(name, value, time) {
  curr = GetDvarFloat(name);

  level notify(name + "_lerp_savedDvar");
  level endon(name + "_lerp_savedDvar");

  range = value - curr;

  interval = .05;
  count = Int(time / interval);

  delta = range / count;

  while(count) {
    curr += delta;
    SetSavedDvar(name, curr);

    wait interval;
    count--;
  }

  SetSavedDvar(name, value);
}

lerp_savedDvar_cg_ng(name, cg_value, ng_value, time) {
  if(is_gen4()) {
    lerp_savedDvar(name, ng_value, time);
  } else {
    lerp_savedDvar(name, cg_value, time);
  }
}

giveachievement_wrapper(achievement) {
  if(is_demo()) {
    return;
  }

  foreach(player in level.players) {
    player GiveAchievement(achievement);
  }

  SetSPMatchData("achievements_completed", achievement, true);

  println("ACHIEVEMENT: " + achievement);
}

player_giveachievement_wrapper(achievement) {
  if(is_demo()) {
    return;
  }

  self GiveAchievement(achievement);

  println("ACHIEVEMENT: " + achievement);
}

add_jav_glow(optional_glow_delete_flag) {
  jav_glow = spawn("script_model", (0, 0, 0));
  jav_glow SetContents(0);
  jav_glow setModel("weapon_javelin_obj");

  jav_glow.origin = self.origin;
  jav_glow.angles = self.angles;

  self add_wait(::delete_on_not_defined);
  if(isDefined(optional_glow_delete_flag)) {
    flag_assert(optional_glow_delete_flag);
    add_wait(::flag_wait, optional_glow_delete_flag);
  }

  do_wait_any();

  jav_glow Delete();
}

add_c4_glow(optional_glow_delete_flag) {
  c4_glow = spawn("script_model", (0, 0, 0));
  c4_glow SetContents(0);
  c4_glow setModel("weapon_c4_obj");

  c4_glow.origin = self.origin;
  c4_glow.angles = self.angles;

  self add_wait(::delete_on_not_defined);
  if(isDefined(optional_glow_delete_flag)) {
    flag_assert(optional_glow_delete_flag);
    add_wait(::flag_wait, optional_glow_delete_flag);
  }

  do_wait_any();

  c4_glow Delete();
}

delete_on_not_defined() {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    wait(0.05);
  }
}

slowmo_start() {}

slowmo_end() {}

slowmo_setspeed_slow(speed) {
  level.slowmo.speed_slow = speed;
}

slowmo_setspeed_norm(speed) {
  level.slowmo.speed_norm = speed;
}

slowmo_setlerptime_in(time) {
  level.slowmo.lerp_time_in = time;
}

slowmo_setlerptime_out(time) {
  level.slowmo.lerp_time_out = time;
}

slowmo_lerp_in() {
  if(isDefined(level.no_slowmo) && level.no_slowmo) {
    return;
  }

  SetSlowMotion(level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in);
}

slowmo_lerp_out() {
  if(isDefined(level.no_slowmo) && level.no_slowmo) {
    return;
  }

  setslowmotion(level.slowmo.speed_slow, level.slowmo.speed_norm, level.slowmo.lerp_time_out);
}

add_earthquake(name, mag, duration, radius) {
  level.earthquake[name]["magnitude"] = mag;
  level.earthquake[name]["duration"] = duration;
  level.earthquake[name]["radius"] = radius;
}

arcadeMode() {
  return GetDvar("arcademode") == "1";
}

arcadeMode_stop_timer() {
  if(!isDefined(level.arcadeMode_hud_timer)) {
    return;
  }

  level notify("arcadeMode_remove_timer");
  level.arcademode_stoptime = GetTime();

  level.arcadeMode_hud_timer Destroy();
  level.arcadeMode_hud_timer = undefined;
}

MusicPlayWrapper(song, timescale, overrideCheat) {
  if(GetDvarInt("music_enable") == 0) {
    return;
  }

  AssertEx(isDefined(level._audio), "Cannot play music before _load::main ");
  level._audio.last_song = song;

  if(!isDefined(timescale)) {
    timescale = true;
  }
  if(!isDefined(overrideCheat)) {
    overrideCheat = false;
  }

  MusicStop(0);
  MusicPlay(song, 0, 1.0, true, overrideCheat);
}

music_loop(name, time, fade_time, timescale, overrideCheat) {
  if(GetDvarInt("music_enable") == 0) {
    return;
  }

  thread music_loop_internal(name, time, fade_time, timescale, overrideCheat);
}

music_loop_stealth(name, length, fade_time, timescale, overrideCheat) {
  if(GetDvarInt("music_enable") == 0) {
    return;
  }

  thread music_loop_internal(name, length, fade_time, timescale, overrideCheat, true);
}

music_play(name, fade_time, timescale, overrideCheat) {
  if(isDefined(fade_time) && fade_time > 0) {
    thread music_play_internal_stop_with_fade_then_call(name, fade_time, timescale, overrideCheat);
    return;
  }
  music_stop();

  MusicPlayWrapper(name, timescale, overrideCheat);
}

music_crossfade(name, crossfade_time, timescale, overrideCheat) {
  if(GetDvarInt("music_enable") == 0) {
    return;
  }

  AssertEx(isDefined(level._audio), "Cannot play music before _load::main ");

  if(!isDefined(timescale)) {
    timescale = true;
  }
  if(!isDefined(overrideCheat)) {
    overrideCheat = false;
  }

  if(isDefined(level._audio.last_song)) {
    MusicStop(crossfade_time, level._audio.last_song, overrideCheat);
  } else {
    iprintln("^3WARNING!script music_crossfade(): No previous song was played - no previous song to crossfade from - not fading out anything");
  }

  level._audio.last_song = name;

  musicplay(name, crossfade_time, timescale, false, overrideCheat);

  level endon("stop_music");

  wait(crossfade_time);
  level notify("done_crossfading");
}

music_stop(fade_time) {
  if(!isDefined(fade_time) || fade_time <= 0) {
    MusicStop();
  } else {
    MusicStop(fade_time);
  }
  level notify("stop_music");
}

player_is_near_live_grenade() {
  grenades = getEntArray("grenade", "classname");
  for(i = 0; i < grenades.size; i++) {
    grenade = grenades[i];
    if(grenade.model == "weapon_claymore") {
      continue;
    }

    for(playerIndex = 0; playerIndex < level.players.size; playerIndex++) {
      player = level.players[playerIndex];
      if(DistanceSquared(grenade.origin, player.origin) < (275 * 275)) {
        /# maps\_autosave::AutoSavePrint( "autosave failed: live grenade too close to player" );
        return true;
      }
    }
  }
  return false;
}

player_died_recently() {
  return GetDvarInt("player_died_recently", "0") > 0;
}

all_players_istouching(eVolume) {
  AssertEx(isDefined(eVolume), "eVolume parameter not defined");
  foreach(player in level.players) {
    if(!player IsTouching(eVolume)) {
      return false;
    }
  }
  return true;
}

any_players_istouching(eVolume) {
  AssertEx(isDefined(eVolume), "eVolume parameter not defined");
  foreach(player in level.players) {
    if(player IsTouching(eVolume)) {
      return true;
    }
  }
  return false;
}

getDifficulty() {
  Assert(isDefined(level.gameskill));
  if(level.gameskill < 1) {
    return "easy";
  }
  if(level.gameskill < 2) {
    return "medium";
  }
  if(level.gameskill < 3) {
    return "hard";
  }
  return "fu";
}

getAveragePlayerOrigin() {
  averageOrigin_x = 0;
  averageOrigin_y = 0;
  averageOrigin_z = 0;
  foreach(player in level.players) {
    averageOrigin_x += player.origin[0];
    averageOrigin_y += player.origin[1];
    averageOrigin_z += player.origin[2];
  }
  averageOrigin_x = averageOrigin_x / level.players.size;
  averageOrigin_y = averageOrigin_y / level.players.size;
  averageOrigin_z = averageOrigin_z / level.players.size;
  return (averageOrigin_x, averageOrigin_y, averageOrigin_z);
}

get_average_origin(array) {
  origin = (0, 0, 0);
  foreach(member in array) {
    origin += member.origin;
  }

  return origin * (1.0 / array.size);
}

generic_damage_think() {
  self.damage_functions = [];
  self endon("entitydeleted");
  self endon("stop_generic_damage_think");
  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName);
    foreach(func in self.damage_functions) {
      thread[[func]](damage, attacker, direction_vec, point, type, modelName, tagName);
    }
  }
}

add_damage_function(func) {
  self.damage_functions[self.damage_functions.size] = func;
}

remove_damage_function(damage_func) {
  new_array = [];
  foreach(func in self.damage_functions) {
    if(func == damage_func) {
      continue;
    }
    new_array[new_array.size] = func;
  }
  self.damage_functions = new_array;
}

giveXp(type, value) {
  AssertEx(isDefined(level.xp_enable) && level.xp_enable, "giveXp() called when xp is not enabled.");
  AssertEx(isDefined(level.xp_give_func), "giveXp() called when level.xp_give_func not defined.");

  if(isDefined(level.xp_enable) && level.xp_enable && isDefined(level.xp_give_func)) {
    self[[level.xp_give_func]](type, value);
  }
}

playLocalSoundWrapper(alias) {
  Assert(isDefined(alias));
  self PlayLocalSound(alias);
}

enablePlayerWeapons(bool) {
  AssertEx(isDefined(bool), "Need to pass either 'true' or 'false' to enable/disable weapons");
  if(level.players.size < 1) {
    return;
  }
  foreach(player in level.players) {
    if(bool == true) {
      player EnableWeapons();
    } else {
      player DisableWeapons();
    }
  }
}

teleport_players(aNodes) {
  player1node = undefined;
  player2node = undefined;
  eNode = undefined;
  foreach(node in aNodes) {
    if((isDefined(node.script_noteworthy)) && (node.script_noteworthy == "player1")) {
      player1node = node;
    } else if((isDefined(node.script_noteworthy)) && (node.script_noteworthy == "player2")) {
      player2node = node;
    } else {
      if(!isDefined(player1node)) {
        player1node = node;
      }
      if(!isDefined(player2node)) {
        player2node = node;
      }
    }
  }
  foreach(player in level.players) {
    if(player == level.player) {
      eNode = player1node;
    } else if(player == level.player2) {
      eNode = player2node;
    }
    player SetOrigin(eNode.origin);
    player SetPlayerAngles(eNode.angles);
  }
}

teleport_player(object) {
  level.player SetOrigin(object.origin);
  if(isDefined(object.angles)) {
    level.player SetPlayerAngles(object.angles);
  }
}

translate_local() {
  entities = [];
  if(isDefined(self.entities)) {
    entities = self.entities;
  }
  if(isDefined(self.entity)) {
    entities[entities.size] = self.entity;
  }

  AssertEx(entities.size > 0, "Tried to do translate_local without any entities");
  array_levelthread(entities, ::translate_local_on_ent);
}

open_up_fov(time, player_rig, tag, arcRight, arcLeft, arcTop, arcBottom) {
  level.player endon("stop_opening_fov");
  wait(time);
  level.player PlayerLinkToDelta(player_rig, tag, 1, arcRight, arcLeft, arcTop, arcBottom, true);
}

get_ai_touching_volume(sTeam, species, bGetDrones) {
  if(!isDefined(sTeam)) {
    sTeam = "all";
  }

  if(!isDefined(species)) {
    species = "all";
  }

  aTeam = GetAISpeciesArray(sTeam, species);

  aGuysTouchingVolume = [];
  foreach(guy in aTeam) {
    AssertEx(IsAlive(guy), "Got ai array yet got a dead guy!");
    if(guy IsTouching(self)) {
      aGuysTouchingVolume[aGuysTouchingVolume.size] = guy;
    }
  }

  return aGuysTouchingVolume;
}

get_drones_touching_volume(sTeam) {
  if(!isDefined(sTeam)) {
    sTeam = "all";
  }

  aDrones = [];
  if(sTeam == "all") {
    aDrones = array_merge(level.drones["allies"].array, level.drones["axis"].array);
    aDrones = array_merge(aDrones, level.drones["neutral"].array);
  } else {
    aDrones = level.drones[sTeam].array;
  }

  aDronesToReturn = [];
  foreach(drone in aDrones) {
    if(!isDefined(drone)) {
      continue;
    }
    if(drone IsTouching(self)) {
      aDronesToReturn[aDronesToReturn.size] = drone;
    }
  }
  return aDronesToReturn;
}

get_drones_with_targetname(sTargetname) {
  aDrones = array_merge(level.drones["allies"].array, level.drones["axis"].array);
  aDrones = array_merge(aDrones, level.drones["neutral"].array);
  aDronesToReturn = [];
  foreach(drone in aDrones) {
    if(!isDefined(drone)) {
      continue;
    }
    if((isDefined(drone.targetname)) && (drone.targetname == sTargetname)) {
      aDronesToReturn[aDronesToReturn.size] = drone;
    }
  }
  return aDronesToReturn;
}

get_other_player(player) {
  Assert(is_coop());
  Assert(isDefined(player) && isplayer(player));

  foreach(other_player in level.players) {
    if(player == other_player) {
      continue;
    }
    return other_player;
  }

  AssertMsg("get_other_player() tried to get other player but there is no other player.");
}

set_count(count) {
  AssertEx(isDefined(self), "Spawner wasn't defined!");
  AssertEx(!isalive(self), "Spawner was alive!");

  self.count = count;
}
follow_path(node, require_player_dist, arrived_at_node_func, start_moving_func) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");

  goal_type = undefined;

  if(!isDefined(node.classname)) {
    if(!isDefined(node.type)) {
      goal_type = "struct";
    } else {
      goal_type = "node";
    }
  } else {
    goal_type = "entity";
  }

  if(!isDefined(require_player_dist)) {
    require_player_dist = 300;
  }

  oldforcegoal = self.script_forcegoal;
  self.script_forcegoal = 1;

  self maps\_spawner::go_to_node(node, goal_type, arrived_at_node_func, require_player_dist, start_moving_func);

  self.script_forcegoal = oldforcegoal;
}

enable_dynamic_run_speed(pushdist, sprintdist, stopdist, jogdist, group, dontChangeMovePlaybackRate) {
  AssertEx(isDefined(level.scr_anim["generic"]["DRS_sprint"]), " - -- -- -- -- -- -- add this line: 'maps\_dynamic_run_speed::main();' AFTER maps\\\_load::main(); -- -- -- -- -- -- - ");
  if(!isDefined(pushdist)) {
    pushdist = 250;
  }

  if(!isDefined(sprintdist)) {
    sprintdist = 100;
  }

  if(!isDefined(stopdist)) {
    stopdist = pushdist * 2;
  }

  if(!isDefined(jogdist)) {
    jogdist = pushdist * 1.25;
  }
  if(!isDefined(dontChangeMovePlaybackRate)) {
    dontChangeMovePlaybackRate = false;
  }

  self.dontChangeMovePlaybackRate = dontChangeMovePlaybackRate;

  self thread dynamic_run_speed_proc(pushdist, sprintdist, stopdist, jogdist, group);
}

disable_dynamic_run_speed() {
  self notify("stop_dynamic_run_speed");
}

player_seek_enable() {
  self endon("death");
  self endon("stop_player_seek");
  g_radius = 1200;
  if(self has_shotgun()) {
    g_radius = 250;
  }

  newGoalRadius = Distance(self.origin, level.player.origin);
  for(;;) {
    wait 2;
    self.goalradius = newGoalRadius;
    player = get_closest_player(self.origin);
    self SetGoalEntity(player);
    newGoalRadius -= 175;
    if(newGoalRadius < g_radius) {
      newGoalRadius = g_radius;
      return;
    }
  }
}

player_seek_disable() {
  self notify("stop_player_seek");
}

waittill_entity_in_range_or_timeout(entity, range, timeout) {
  self endon("death");
  entity endon("death");
  if(!isDefined(timeout)) {
    timeout = 5;
  }
  timeout_time = GetTime() + (timeout * 1000);
  while(isDefined(entity)) {
    if(Distance(entity.origin, self.origin) <= range) {
      break;
    }
    if(GetTime() > timeout_time) {
      break;
    }
    wait .1;
  }
}

waittill_entity_in_range(entity, range) {
  self endon("death");
  entity endon("death");
  while(isDefined(entity)) {
    if(Distance(entity.origin, self.origin) <= range) {
      break;
    }
    wait .1;
  }
}

waittill_entity_out_of_range(entity, range) {
  self endon("death");
  entity endon("death");
  while(isDefined(entity)) {
    if(Distance(entity.origin, self.origin) > range) {
      break;
    }
    wait .1;
  }
}

has_shotgun() {
  self endon("death");
  if(!isDefined(self.weapon)) {
    return false;
  }

  if(WeaponClass(self.weapon) == "spread") {
    return true;
  }

  return false;
}

isPrimaryWeapon(weapName) {
  if(weapName == "none") {
    return false;
  }

  if(weaponInventoryType(weapName) != "primary") {
    return false;
  }

  switch (weaponClass(weapName)) {
    case "rifle":
    case "smg":
    case "mg":
    case "spread":
    case "pistol":
    case "rocketlauncher":
    case "sniper":
      return true;

    default:
      return false;
  }
}

player_has_thermal() {
  weapons = self GetWeaponsListAll();
  if(!isDefined(weapons)) {
    return false;
  }
  foreach(weapon in weapons) {
    if(IsSubStr(weapon, "thermal")) {
      return true;
    }
  }
  return false;
}

waittill_true_goal(origin, radius) {
  self endon("death");

  if(!isDefined(radius)) {
    radius = self.goalradius;
  }

  while(1) {
    self waittill("goal");
    if(Distance(self.origin, origin) < radius + 10) {
      break;
    }
  }
}

player_speed_percent(percent, time) {
  currspeed = Int(GetDvar("g_speed"));
  if(!isDefined(level.player.g_speed)) {
    level.player.g_speed = currspeed;
  }

  goalspeed = Int(level.player.g_speed * percent * .01);

  level.player player_speed_set(goalspeed, time);
}

blend_movespeedscale_percent(percent, time) {
  player = self;
  if(!isplayer(player)) {
    player = level.player;
  }

  if(!isDefined(player.movespeedscale)) {
    player.movespeedscale = 1.0;
  }

  goalscale = percent * .01;

  player blend_movespeedscale(goalscale, time);
}

player_speed_set(speed, time) {
  currspeed = Int(GetDvar("g_speed"));
  if(!isDefined(level.player.g_speed)) {
    level.player.g_speed = currspeed;
  }

  get_func = ::g_speed_get_func;
  set_func = ::g_speed_set_func;
  level.player thread player_speed_proc(speed, time, get_func, set_func, "player_speed_set");
}

player_bob_scale_set(scale, time) {
  get_func = ::g_bob_scale_get_func;
  set_func = ::g_bob_scale_set_func;
  level.player thread player_speed_proc(scale, time, get_func, set_func, "player_bob_scale_set");
}

blend_movespeedscale(scale, time) {
  player = self;
  if(!isplayer(player)) {
    player = level.player;
  }

  if(!isDefined(player.movespeedscale)) {
    player.movespeedscale = 1.0;
  }

  get_func = ::movespeed_get_func;
  set_func = ::movespeed_set_func;
  player thread player_speed_proc(scale, time, get_func, set_func, "blend_movespeedscale");
}

player_speed_proc(speed, time, get_func, set_func, ender) {
  self notify(ender);
  self endon(ender);

  currspeed = [[get_func]]();
  goalspeed = speed;

  if(isDefined(time)) {
    range = goalspeed - currspeed;
    interval = .05;
    numcycles = time / interval;
    fraction = range / numcycles;

    while(abs(goalspeed - currspeed) > abs(fraction * 1.1)) {
      currspeed += fraction;
      [[set_func]](currspeed);
      wait interval;
    }
  }

  [[set_func]](goalspeed);
}

player_speed_default(time) {
  if(!isDefined(level.player.g_speed)) {
    return;
  }

  level.player player_speed_set(level.player.g_speed, time);

  waittillframeend;
  level.player.g_speed = undefined;
}

blend_movespeedscale_default(time) {
  player = self;
  if(!isplayer(player)) {
    player = level.player;
  }

  if(!isDefined(player.movespeedscale)) {
    return;
  }

  player blend_movespeedscale(1.0, time);

  waittillframeend;
  player.movespeedscale = undefined;
}

teleport_ent(ent) {
  if(IsPlayer(self)) {
    self SetOrigin(ent.origin);
    self SetPlayerAngles(ent.angles);
  } else {
    self ForceTeleport(ent.origin, ent.angles);
  }
}

teleport_to_ent_tag(ent, tag) {
  position = ent GetTagOrigin(tag);
  angles = ent GetTagAngles(tag);
  self DontInterpolate();

  if(IsPlayer(self)) {
    self SetOrigin(position);
    self SetPlayerAngles(angles);
  } else if(IsAI(self)) {
    self ForceTeleport(position, angles);
  } else {
    self.origin = position;
    self.angles = angles;
  }
}

teleport_ai(eNode) {
  AssertEx(IsAI(self), "Function teleport_ai can only be called on an AI entity");
  AssertEx(isDefined(eNode), "Need to pass a node entity to function teleport_ai");
  self ForceTeleport(eNode.origin, eNode.angles);
  self SetGoalPos(self.origin);
  self SetGoalNode(eNode);
}

move_all_fx(vec) {
  foreach(fx in level.createFXent) {
    fx.v["origin"] += vec;
  }
}

IsSliding() {
  return isDefined(self.slideModel);
}

BeginSliding(velocity, allowedAcceleration, dampening) {
  Assert(IsPlayer(self));
  player = self;

  player thread play_sound_on_entity("foot_slide_plr_start");
  if(SoundExists("foot_slide_plr_loop")) {
    player thread play_loop_sound_on_tag("foot_slide_plr_loop");
  }

  override_link_method = isDefined(level.custom_linkto_slide);

  if(!isDefined(velocity)) {
    velocity = player GetVelocity() + (0, 0, -10);
  }
  if(!isDefined(allowedAcceleration)) {
    allowedAcceleration = 10;
  }
  if(!isDefined(dampening)) {
    if(isDefined(level.slide_dampening)) {
      dampening = level.slide_dampening;
    } else {
      dampening = .035;
    }
  }

  Assert(!isDefined(player.slideModel));

  slideModel = spawn("script_origin", player.origin);
  slideModel.angles = player.angles;
  player.slideModel = slideModel;

  slideModel MoveSlide((0, 0, 15), 15, velocity);

  if(override_link_method) {
    player PlayerLinkToBlend(slideModel, undefined, 1);
  } else {
    player PlayerLinkTo(slideModel);
  }

  player DisableWeapons();
  player AllowProne(false);
  player AllowCrouch(true);
  player AllowStand(false);

  player thread DoSlide(slideModel, allowedAcceleration, dampening);
}

EndSliding() {
  Assert(IsPlayer(self));
  player = self;

  Assert(isDefined(player.slideModel));

  player notify("stop sound" + "foot_slide_plr_loop");
  player thread play_sound_on_entity("foot_slide_plr_end");
  player Unlink();
  player SetVelocity(player.slidemodel.slideVelocity);
  player.slideModel Delete();
  player EnableWeapons();
  player AllowProne(true);
  player AllowCrouch(true);
  player AllowStand(true);

  player notify("stop_sliding");
}

spawn_vehicle() {
  vehicle = maps\_vehicle::vehicle_spawn(self);
  return vehicle;

  return maps\_vehicle::vehicle_spawn(self);
}

getEntWithFlag(flag) {
  trigger_classes = maps\_trigger::get_load_trigger_classes();

  triggers = [];

  foreach(class, _ in trigger_classes) {
    if(!IsSubStr(class, "flag")) {
      continue;
    }
    other_triggers = getEntArray(class, "classname");
    triggers = array_combine(triggers, other_triggers);
  }

  trigger_funcs = maps\_trigger::get_load_trigger_funcs();

  foreach(func, _ in trigger_funcs) {
    if(!IsSubStr(func, "flag")) {
      continue;
    }
    other_triggers = getEntArray(func, "targetname");
    triggers = array_combine(triggers, other_triggers);
  }

  found_trigger = undefined;

  foreach(trigger in triggers) {
    AssertEx(isDefined(trigger.script_flag), "Flag trigger at " + trigger.origin + " has no script_flag");

    if(trigger.script_flag == flag) {
      AssertEx(!isDefined(found_trigger), "Did getEntWithFlag on flag " + flag + " but found multiple entities with that flag");
      found_trigger = trigger;
    }
  }

  foreach(trigger in triggers) {
    if(trigger.script_flag == flag) {
      return trigger;
    }
  }
}

getEntArrayWithFlag(flag) {
  trigger_classes = maps\_trigger::get_load_trigger_classes();

  triggers = [];

  foreach(class, _ in trigger_classes) {
    if(!IsSubStr(class, "flag")) {
      continue;
    }
    other_triggers = getEntArray(class, "classname");
    triggers = array_combine(triggers, other_triggers);
  }

  trigger_funcs = maps\_trigger::get_load_trigger_funcs();

  foreach(func, _ in trigger_funcs) {
    if(!IsSubStr(func, "flag")) {
      continue;
    }
    other_triggers = getEntArray(func, "targetname");
    triggers = array_combine(triggers, other_triggers);
  }

  found_triggers = [];

  foreach(trigger in triggers) {
    AssertEx(isDefined(trigger.script_flag), "Flag trigger at " + trigger.origin + " has no script_flag");

    if(trigger.script_flag == flag) {
      found_triggers[found_triggers.size] = trigger;
    }
  }

  AssertEx(found_triggers.size, "Tried to find entity with flag " + flag + " but found none");
  if(1) return found_triggers;

  foreach(trigger in triggers) {
    if(trigger.script_flag == flag) {
      found_triggers[found_triggers.size] = trigger;
    }
  }
  return found_triggers;
}

set_z(vec, z) {
  return (vec[0], vec[1], z);
}

add_z(vec, zPlus) {
  return (vec[0], vec[1], vec[2] + zPlus);
}

set_y(vec, y) {
  return (vec[0], y, vec[2]);
}

set_x(vec, x) {
  return (x, vec[1], vec[2]);
}

player_using_missile() {
  weapon = self GetCurrentWeapon();

  if(!isDefined(weapon)) {
    return false;
  }

  if(IsSubStr(ToLower(weapon), "rpg")) {
    return true;
  }

  if(IsSubStr(ToLower(weapon), "stinger")) {
    return true;
  }

  if(IsSubStr(ToLower(weapon), "at4")) {
    return true;
  }

  if(IsSubStr(ToLower(weapon), "javelin")) {
    return true;
  }

  return false;
}

doingLongDeath() {
  Assert(IsAI(self));
  return isDefined(self.a.doingLongDeath);
}

get_rumble_ent(rumble, starting_rumble_val) {
  if(is_coop()) {
    PrintLn("^3Warning! Using get_rumble_ent will cause the same rumbles to apply to all of the coop players!");
  }

  player = get_player_from_self();
  if(!isDefined(rumble)) {
    rumble = "steady_rumble";
  }
  ent = spawn("script_origin", player getEye());
  if(!isDefined(starting_rumble_val) || !IsNumber(starting_rumble_val)) {
    ent.intensity = 1;
  } else {
    ent.intensity = starting_rumble_val;
  }
  ent thread update_rumble_intensity(player, rumble);
  return ent;
}

set_rumble_intensity(intensity) {
  AssertEx(intensity >= 0 && intensity <= 1, "Intensity must be between 0 and 1");
  self.intensity = intensity;
}

rumble_ramp_on(time) {
  thread rumble_ramp_to(1, time);
}

rumble_ramp_off(time) {
  thread rumble_ramp_to(0, time);
}

rumble_ramp_to(dest, time) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");

  frames = time * 20;
  dif = dest - self.intensity;
  slice = dif / frames;

  for(i = 0; i < frames; i++) {
    self.intensity += slice;
    wait(0.05);
  }
  self.intensity = dest;
}

get_player_from_self() {
  if(isDefined(self)) {
    if(!is_in_array(level.players, self)) {
      return level.player;
    } else {
      return self;
    }
  } else {
    return level.player;
  }
}

get_player_gameskill() {
  AssertEx(IsPlayer(self), "get_player_gameskill() can only be called on a player.");
  return Int(self GetPlayerSetting("gameskill"));
}

glow(model) {
  if(isDefined(self.non_glow_model)) {
    return;
  }

  self.non_glow_model = self.model;

  if(!isDefined(model)) {
    model = self.model + "_obj";
  }
  self setModel(model);
}

stopGlow(model) {
  if(!isDefined(self.non_glow_model)) {
    return;
  }

  self setModel(self.non_glow_model);
  self.non_glow_model = undefined;
}

array_delete_evenly(array, delete_size, set_size) {
  AssertEx(delete_size > 0, "Save size must be at least 1");
  AssertEx(set_size > 0, "Removal size must be at least 1");
  AssertEx(delete_size < set_size, "Save size must be less than removal size");
  removal = [];
  delete_size = set_size - delete_size;
  foreach(entry in array) {
    removal[removal.size] = entry;
    if(removal.size == set_size) {
      removal = array_randomize(removal);
      for(i = delete_size; i < removal.size; i++) {
        removal[i] Delete();
      }
      removal = [];
    }
  }

  new_array = [];
  foreach(entry in array) {
    if(!isDefined(entry)) {
      continue;
    }
    new_array[new_array.size] = entry;
  }

  return new_array;
}

waittill_in_range(origin, range, resolution) {
  if(!isDefined(resolution)) {
    resolution = 0.5;
  }
  self endon("death");
  while(isDefined(self)) {
    if(Distance(origin, self.origin) <= range) {
      break;
    }
    wait resolution;
  }
}

add_trace_fx(name) {
  ent = spawnStruct();
  ent thread add_trace_fx_proc(name);
  return ent;
}

traceFX_on_tag(fx_name, tag, trace_depth) {
  origin = self GetTagOrigin(tag);
  angles = self GetTagAngles(tag);
  traceFx(fx_name, origin, angles, trace_depth);
}

traceFx(fx_name, origin, angles, trace_depth) {
  AssertEx(isDefined(level.trace_fx[fx_name]), "No level.trace_fx with name " + fx_name);
  AssertEx(isDefined(level.trace_fx[fx_name]["default"]), "No default fx defined for " + fx_name);

  forward = anglesToForward(angles);
  trace = bulletTrace(origin, origin + forward * trace_depth, false, undefined);

  if(trace["fraction"] >= 1) {
    if(GetDvarInt("debug_tracefx")) {
      Line(origin, origin + forward * trace_depth, (1, 0, 0), 1, 0, 500);
    }

    return;
  }

  surface = trace["surfacetype"];
  if(!isDefined(level.trace_fx[fx_name][surface])) {
    surface = "default";
  }

  fx_info = level.trace_fx[fx_name][surface];

  if(isDefined(fx_info["fx"])) {
    playFX(fx_info["fx"], trace["position"], trace["normal"]);
  }

  if(isDefined(fx_info["fx_array"])) {
    foreach(fx in fx_info["fx_array"]) {
      playFX(fx, trace["position"], trace["normal"]);
    }
  }

  if(isDefined(fx_info["sound"])) {
    level thread play_sound_in_space(fx_info["sound"], trace["position"]);
  }

  if(isDefined(fx_info["rumble"])) {
    player = get_player_from_self();
    player PlayRumbleOnEntity(fx_info["rumble"]);
  }
}

disable_surprise() {
  self.newEnemyReactionDistSq = 0;
}

enable_surprise() {
  self.newEnemyReactionDistSq = squared(512);
}

enable_heat_behavior(shoot_while_moving) {
  self.heat = true;
  self.no_pistol_switch = true;
  self.useCombatScriptAtCover = true;

  if(!isDefined(shoot_while_moving) || !shoot_while_moving) {
    self.dontshootwhilemoving = true;
    self.maxfaceenemydist = 64;
    self.pathenemylookahead = 2048;
    self disable_surprise();
  }

  self.specialReloadAnimFunc = animscripts\animset::heat_reload_anim;

  self.customMoveAnimSet["run"] = self lookupAnimArray("heat_run");
}

disable_heat_behavior() {
  self.heat = undefined;
  self.no_pistol_switch = undefined;
  self.dontshootwhilemoving = undefined;
  self.useCombatScriptAtCover = false;
  self.maxfaceenemydist = 512;
  self.specialReloadAnimFunc = undefined;

  self.customMoveAnimSet = undefined;
}

getVehicleArray() {
  return Vehicle_GetArray();
}

hint(string, timeOut, zoffset) {
  if(!isDefined(zoffset)) {
    zoffset = 0;
  }

  hintfade = 0.5;

  level endon("clearing_hints");

  if(isDefined(level.hintElement)) {
    level.hintElement maps\_hud_util::destroyElem();
  }

  level.hintElement = maps\_hud_util::createFontString("default", 1.5);
  level.hintElement maps\_hud_util::setPoint("MIDDLE", undefined, 0, 30 + zoffset);
  level.hintElement.color = (1, 1, 1);
  level.hintElement SetText(string);
  level.hintElement.alpha = 0;
  level.hintElement FadeOverTime(0.5);
  level.hintElement.alpha = 1;
  wait(0.5);
  level.hintElement endon("death");

  if(isDefined(timeOut)) {
    wait(timeOut);
  } else {
    return;
  }

  level.hintElement FadeOverTime(hintfade);
  level.hintElement.alpha = 0;
  wait(hintfade);

  level.hintElement maps\_hud_util::destroyElem();
}

hint_fade() {
  hintfade = 1;
  if(isDefined(level.hintElement)) {
    level notify("clearing_hints");
    level.hintElement FadeOverTime(hintfade);
    level.hintElement.alpha = 0;
    wait(hintfade);
  }
}

kill_deathflag(theFlag, time, bNotVisible) {
  if(!isDefined(level.flag[theFlag])) {
    return;
  }

  if(!isDefined(time)) {
    time = 0;
  }

  foreach(deathTypes in level.deathFlags[theFlag]) {
    foreach(element in deathTypes) {
      if(IsAlive(element)) {
        element thread kill_deathflag_proc(time, bNotVisible);
      } else {
        element Delete();
      }
    }
  }
}

get_player_view_controller(model, tag, originoffset, turret) {
  if(!isDefined(turret)) {
    turret = "player_view_controller";
  }

  if(!isDefined(originoffset)) {
    originoffset = (0, 0, 0);
  }
  origin = model GetTagOrigin(tag);
  player_view_controller = SpawnTurret("misc_turret", origin, turret);
  player_view_controller.angles = model GetTagAngles(tag);
  player_view_controller setModel("tag_turret");
  player_view_controller LinkTo(model, tag, originoffset, (0, 0, 0));
  player_view_controller MakeUnusable();
  player_view_controller Hide();
  player_view_controller SetMode("manual");

  return player_view_controller;
}

create_blend(func, var1, var2, var3) {
  ent = spawnStruct();
  ent childthread process_blend(func, self, var1, var2, var3);
  return ent;
}

set_unstorable_weapon(weapon, unstorable) {
  assert(isDefined(weapon));

  if(isDefined(self.unstorable_weapons)) {
    self.unstorable_weapons = [];
  }

  if(!isDefined(unstorable) || unstorable) {
    self.unstorable_weapons[weapon] = true;
  } else {
    self.unstorable_weapons[weapon] = undefined;
  }
}

is_unstorable_weapon(weapon) {
  assert(isDefined(weapon));

  if(!isDefined(self.unstorable_weapons)) {
    return false;
  }

  return isDefined(self.unstorable_weapons[weapon]);
}

store_players_weapons(scene) {
  if(!isDefined(self.stored_weapons)) {
    self.stored_weapons = [];
  }
  if(!isDefined(self.unstorable_weapons)) {
    self.unstorable_weapons = [];
  }

  array = [];
  weapons = self GetWeaponsListAll();
  current_weapon = self GetCurrentWeapon();

  foreach(weapon in weapons) {
    if(isDefined(self.unstorable_weapons[weapon])) {
      continue;
    }

    array[weapon] = [];
    array[weapon]["clip_left"] = self GetWeaponAmmoClip(weapon, "left");
    array[weapon]["clip_right"] = self GetWeaponAmmoClip(weapon, "right");
    array[weapon]["stock"] = self GetWeaponAmmoStock(weapon);
  }

  if(!isDefined(scene)) {
    scene = "default";
  }

  self.stored_weapons[scene] = [];
  if(isDefined(self.unstorable_weapons[current_weapon])) {
    primary_weapons = self GetWeaponsListPrimaries();
    foreach(weapon in primary_weapons) {
      if(!isDefined(self.unstorable_weapons[weapon])) {
        current_weapon = weapon;
        break;
      }
    }
  }
  self.stored_weapons[scene]["current_weapon"] = current_weapon;
  self.stored_weapons[scene]["inventory"] = array;
}

restore_players_weapons(scene) {
  if(!isDefined(scene)) {
    scene = "default";
  }

  if(!isDefined(self.stored_weapons) || !isDefined(self.stored_weapons[scene])) {
    PrintLn("^3Warning! Tried to restore weapons for scene " + scene + " but they weren't stored");
    return;
  }

  self TakeAllWeapons();
  foreach(weapon, array in self.stored_weapons[scene]["inventory"]) {
    if(WeaponInventoryType(weapon) != "altmode") {
      self GiveWeapon(weapon);
    }

    self SetWeaponAmmoClip(weapon, array["clip_left"], "left");
    self SetWeaponAmmoClip(weapon, array["clip_right"], "right");
    self SetWeaponAmmoStock(weapon, array["stock"]);
  }

  current_weapon = self.stored_weapons[scene]["current_weapon"];
  if(current_weapon != "none") {
    self SwitchToWeapon(current_weapon);
  }
}

get_storable_weapons_list_all() {
  weapons = self GetWeaponsListAll();

  if(isDefined(self.unstorable_weapons)) {
    foreach(weapon in weapons) {
      if(isDefined(self.unstorable_weapons[weapon])) {
        weapons = array_remove(weapons, weapon);
      }
    }
  }

  return weapons;
}

get_storable_weapons_list_primaries() {
  primary_weapons = self GetWeaponsListPrimaries();

  if(isDefined(self.unstorable_weapons)) {
    foreach(weapon in primary_weapons) {
      if(isDefined(self.unstorable_weapons[weapon])) {
        primary_weapons = array_remove(primary_weapons, weapon);
      }
    }
  }

  return primary_weapons;
}

get_storable_current_weapon_primary() {
  primary_weapon = self GetCurrentPrimaryWeapon();

  if(isDefined(self.unstorable_weapons) && isDefined(self.unstorable_weapons[primary_weapon])) {
    primary_weapon = self get_first_storable_weapon();
  }

  return primary_weapon;
}

get_storable_current_weapon() {
  current_weapon = self GetCurrentWeapon();

  if(isDefined(self.unstorable_weapons) && isDefined(self.unstorable_weapons[current_weapon])) {
    current_weapon = self get_first_storable_weapon();
  }

  return current_weapon;
}

get_first_storable_weapon() {
  primaries = self get_storable_weapons_list_primaries();

  if(primaries.size > 0) {
    weapon = primaries[0];
  } else {
    weapon = "none";
  }

  return weapon;
}

hide_entity() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self Hide();
      break;
    case "script_brushmodel":
      self Hide();
      self NotSolid();
      if(self.spawnflags & 1) {
        self ConnectPaths();
      }
      break;
    case "trigger_radius":
    case "trigger_multiple":
    case "trigger_use":
    case "trigger_use_touch":
    case "trigger_multiple_flag_set":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_flag_looking":
      self trigger_off();
      break;
    default:
      AssertMsg("Unable to hide entity at " + self.origin + ". Need to define a method for handling entities of classname " + self.code_classname);
  }
}

show_entity() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self Show();
      break;
    case "script_brushmodel":
      self Show();
      self Solid();
      if(self.spawnflags & 1) {
        self DisconnectPaths();
      }
      break;
    case "trigger_radius":
    case "trigger_multiple":
    case "trigger_use":
    case "trigger_use_touch":
    case "trigger_multiple_flag_set":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_flag_looking":
      self trigger_on();
      break;
    default:
      AssertMsg("Unable to show entity at " + self.origin + ". Need to define a method for handling entities of classname " + self.code_classname);
  }
}

_rotateyaw(yaw_angle, time, acc_time, dec_time) {
  if(isDefined(dec_time)) {
    self RotateYaw(yaw_angle, time, acc_time, dec_time);
  } else {
    if(isDefined(acc_time))
  }
  self RotateYaw(yaw_angle, time, acc_time);
  else {
    self RotateYaw(yaw_angle, time);
  }
}

set_moveplaybackrate(rate, time, also_change_transitionrate) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isDefined(also_change_transitionrate) && also_change_transitionrate) {
    self thread set_movetransitionrate(rate, time);
  }

  if(!isDefined(self.moveplaybackrate_orig)) {
    self.moveplaybackrate_orig = self.moveplaybackrate;
  }

  if(isDefined(time)) {
    range = rate - self.moveplaybackrate;
    interval = .05;
    numcycles = time / interval;
    fraction = range / numcycles;

    while(abs(rate - self.moveplaybackrate) > abs(fraction * 1.1)) {
      self.moveplaybackrate += fraction;
      wait interval;
    }
  }

  self.moveplaybackrate = rate;
}

restore_moveplaybackrate(time, also_change_transitionrate) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isDefined(also_change_transitionrate) && also_change_transitionrate) {
    self thread restore_movetransitionrate(time);
  }

  self set_moveplaybackrate(self.moveplaybackrate_orig, time, false);

  self.moveplaybackrate_orig = undefined;
}

set_movetransitionrate(rate, time) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(!isDefined(self.movetransitionrate_orig)) {
    self.movetransitionrate_orig = self.movetransitionrate;
  }

  if(isDefined(time)) {
    range = rate - self.movetransitionrate;
    interval = .05;
    numcycles = time / interval;
    fraction = range / numcycles;

    while(abs(rate - self.movetransitionrate) > abs(fraction * 1.1)) {
      self.movetransitionrate += fraction;
      wait interval;
    }
  }

  self.movetransitionrate = rate;
}

restore_movetransitionrate(time) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  set_movetransitionrate(self.movetransitionrate_orig, time);

  self.movetransitionrate_orig = undefined;
}

array_spawn_function(array, func, param1, param2, param3, param4) {
  AssertEx(isDefined(array), "That isn't an array!");
  AssertEx(IsArray(array), "That isn't an array!");
  AssertEx(array.size, "That array is empty!");
  foreach(spawner in array) {
    AssertEx(IsSpawner(spawner), "This isn't a spawner!");
    spawner thread add_spawn_function(func, param1, param2, param3, param4);
  }
}

array_spawn_function_targetname(key, func, param1, param2, param3, param4) {
  array = getEntArray(key, "targetname");
  array_spawn_function(array, func, param1, param2, param3, param4);
}

array_spawn_function_noteworthy(key, func, param1, param2, param3, param4) {
  array = getEntArray(key, "script_noteworthy");
  array_spawn_function(array, func, param1, param2, param3, param4);
}

enable_dontevershoot() {
  self.dontEverShoot = true;
}

disable_dontevershoot() {
  self.dontEverShoot = undefined;
}

create_sunflare_setting(sunflare_name) {
  if(!isDefined(level.sunflare_settings)) {
    level.sunflare_settings = [];
  }
  ent = spawnStruct();
  ent.name = sunflare_name;

  level.sunflare_settings[sunflare_name] = ent;
  return ent;
}

create_vision_set_fog(fogset) {
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
  }
  ent = spawnStruct();
  ent.name = fogset;

  ent.skyFogIntensity = 0;
  ent.skyFogMinAngle = 0;
  ent.skyFogMaxAngle = 0;
  ent.heightFogEnabled = 0;
  ent.heightFogBaseHeight = 0;
  ent.heightFogHalfPlaneDistance = 1000;

  level.vision_set_fog[ToLower(fogset)] = ent;
  return ent;
}

get_vision_set_fog(fogset) {
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
  }

  ent = level.vision_set_fog[ToLower(fogset)];
  if(using_hdr_fog() && isDefined(ent) && isDefined(ent.HDROverride)) {
    ent = level.vision_set_fog[ToLower(ent.HDROverride)];
  }

  return ent;
}

create_fog(fogset) {
  if(!isDefined(level.fog_set)) {
    level.fog_set = [];
  }
  ent = spawnStruct();
  ent.name = fogset;

  level.fog_set[ToLower(fogset)] = ent;
  return ent;
}

get_fog(fogset) {
  if(!isDefined(level.fog_set)) {
    level.fog_set = [];
  }

  ent = level.fog_set[ToLower(fogset)];

  return ent;
}

init_self_fog_transition() {
  if(!isDefined(self.fog_transition_ent)) {
    self.fog_transition_ent = spawnStruct();
    self.fog_transition_ent.fogset = "";
    self.fog_transition_ent.time = 0;
  }
}

using_hdr_fog() {
  if(!isDefined(level.console)) {
    set_console_status();
  }
  AssertEx(isDefined(level.console) && isDefined(level.xb3) && isDefined(level.ps4), "Expected platform defines to be complete.");

  return is_gen4();
}

fog_set_changes(fog_set, transition_time) {
  if(!isPlayer(self)) {
    maps\_art::init_fog_transition();
  } else {
    init_self_fog_transition();
  }

  if(!isDefined(level.fog_set)) {
    level.fog_set = [];
  }

  ent = level.fog_set[ToLower(fog_set)];
  if(!isDefined(ent)) {
    AssertEx(isDefined(level.vision_set_fog), "Fog set:" + fog_set + " does not exist, use create_fog( " + fog_set + " ) or create_vision_set_fog( " + fog_set + " ); in your /createart/level_fog.gsc");
    ent = level.vision_set_fog[ToLower(fog_set)];
  }

  if(isDefined(ent) && isDefined(ent.HDROverride) && using_hdr_fog()) {
    if(isDefined(level.fog_set[ToLower(ent.HDROverride)])) {
      ent = level.fog_set[ToLower(ent.HDROverride)];
    } else if(isDefined(level.vision_set_fog)) {
      ent = level.vision_set_fog[ToLower(ent.HDROverride)];
    }
  }

  AssertEx(isDefined(ent), "Fog set:" + fog_set + " does not exist, use create_fog( " + fog_set + " ) or create_vision_set_fog( " + fog_set + " ); in your /createart/level_fog.gsc");

  if(!isDefined(transition_time)) {
    transition_time = ent.transitiontime;
  }
  AssertEx(isDefined(transition_time), "Fog set: " + fog_set + " does not have a transition_time defined and a time was not specified in the function call.");
  /$
  if(GetDvarInt("scr_art_tweak") != 0) {
    translateEntTosliders(ent);

    transition_time = 0;
  }
  $ /
    if(!isPlayer(self)) {
      set_fog_to_ent_values(ent, transition_time);

      level.fog_transition_ent.fogset = fog_set;
      level.fog_transition_ent.time = transition_time;
    }
  else {
    if(fog_set != "" && self.fog_transition_ent.fogset == fog_set && self.fog_transition_ent.time == transition_time) {
      return;
    }

    self set_fog_to_ent_values(ent, transition_time);

    self.fog_transition_ent.fogset = fog_set;
    self.fog_transition_ent.time = transition_time;
  }
}
/$
translateEntTosliders(ent) {
  ConvertLegacyFog(ent);
  SetDevDvar("scr_fog_exp_halfplane", ent.halfwayDist);
  SetDevDvar("scr_fog_nearplane", ent.startDist);
  SetDevDvar("scr_fog_color", (ent.red, ent.green, ent.blue));
  SetDevDvar("scr_fog_color_intensity", ent.HDRColorIntensity);
  SetDevDvar("scr_fog_max_opacity", ent.maxOpacity);
  SetDevDvar("scr_skyFogIntensity", ent.skyFogIntensity);
  SetDevDvar("scr_skyFogMinAngle", ent.skyFogMinAngle);
  SetDevDvar("scr_skyFogMaxAngle", ent.skyFogMaxAngle);
  SetDevDvar("scr_heightFogEnabled", ent.heightFogEnabled);
  SetDevDvar("scr_heightFogBaseHeight", ent.heightFogBaseHeight);
  SetDevDvar("scr_heightFogHalfPlaneDistance", ent.heightFogHalfPlaneDistance);

  if(isDefined(ent.sunFogEnabled) && ent.sunFogEnabled) {
    SetDevDvar("scr_sunFogEnabled", 1);
    SetDevDvar("scr_sunFogColor", (ent.sunRed, ent.sunGreen, ent.sunBlue));
    SetDevDvar("scr_sunFogColorIntensity", ent.HDRSunColorIntensity);
    SetDevDvar("scr_sunFogDir", ent.sunDir);
    SetDevDvar("scr_sunFogBeginFadeAngle", ent.sunBeginFadeAngle);
    SetDevDvar("scr_sunFogEndFadeAngle", ent.sunEndFadeAngle);
    SetDevDvar("scr_sunFogScale", ent.normalFogScale);
  } else {
    SetDevDvar("scr_sunFogEnabled", 0);
  }

  if(isDefined(ent.atmosFogEnabled)) {
    AssertEx(isDefined(ent.atmosFogSunFogColor));
    AssertEx(isDefined(ent.atmosFogHazeColor));
    AssertEx(isDefined(ent.atmosFogHazeStrength));
    AssertEx(isDefined(ent.atmosFogHazeSpread));
    AssertEx(isDefined(ent.atmosFogExtinctionStrength));
    AssertEx(isDefined(ent.atmosFogInScatterStrength));
    AssertEx(isDefined(ent.atmosFogHalfPlaneDistance));
    AssertEx(isDefined(ent.atmosFogStartDistance));
    AssertEx(isDefined(ent.atmosFogDistanceScale));
    AssertEx(isDefined(ent.atmosFogSkyDistance));
    AssertEx(isDefined(ent.atmosFogSkyAngularFalloffEnabled));
    AssertEx(isDefined(ent.atmosFogSkyFalloffStartAngle));
    AssertEx(isDefined(ent.atmosFogSkyFalloffAngleRange));
    AssertEx(isDefined(ent.atmosFogSunDirection));
    AssertEx(isDefined(ent.atmosFogHeightFogEnabled));
    AssertEx(isDefined(ent.atmosFogHeightFogBaseHeight));
    AssertEx(isDefined(ent.atmosFogHeightFogHalfPlaneDistance));

    SetDevDvar("scr_atmosFogEnabled", ent.atmosFogEnabled);
    SetDevDvar("scr_atmosFogSunFogColor", ent.atmosFogSunFogColor);
    SetDevDvar("scr_atmosFogHazeColor", ent.atmosFogHazeColor);
    SetDevDvar("scr_atmosFogHazeStrength", ent.atmosFogHazeStrength);
    SetDevDvar("scr_atmosFogHazeSpread", ent.atmosFogHazeSpread);
    SetDevDvar("scr_atmosFogExtinctionStrength", ent.atmosFogExtinctionStrength);
    SetDevDvar("scr_atmosFogInScatterStrength", ent.atmosFogInScatterStrength);
    SetDevDvar("scr_atmosFogHalfPlaneDistance", ent.atmosFogHalfPlaneDistance);
    SetDevDvar("scr_atmosFogStartDistance", ent.atmosFogStartDistance);
    SetDevDvar("scr_atmosFogDistanceScale", ent.atmosFogDistanceScale);
    SetDevDvar("scr_atmosFogSkyDistance", int(ent.atmosFogSkyDistance));
    SetDevDvar("scr_atmosFogSkyAngularFalloffEnabled", ent.atmosFogSkyAngularFalloffEnabled);
    SetDevDvar("scr_atmosFogSkyFalloffStartAngle", ent.atmosFogSkyFalloffStartAngle);
    SetDevDvar("scr_atmosFogSkyFalloffAngleRange", ent.atmosFogSkyFalloffAngleRange);
    SetDevDvar("scr_atmosFogSunDirection", ent.atmosFogSunDirection);
    SetDevDvar("scr_atmosFogHeightFogEnabled", ent.atmosFogHeightFogEnabled);
    SetDevDvar("scr_atmosFogHeightFogBaseHeight", ent.atmosFogHeightFogBaseHeight);
    SetDevDvar("scr_atmosFogHeightFogHalfPlaneDistance", ent.atmosFogHeightFogHalfPlaneDistance);
  } else {
    SetDevDvar("scr_atmosFogEnabled", false);
  }
}
$ /

  vision_set_fog_changes(vision_set, transition_time) {
    do_fog = vision_set_changes(vision_set, transition_time);
    if(do_fog) {
      if(level.currentgen && isDefined(get_vision_set_fog(vision_set + "_cg"))) {
        fog_set_changes(vision_set + "_cg", transition_time);
      } else if(isDefined(get_vision_set_fog(vision_set))) {
        fog_set_changes(vision_set, transition_time);
      } else {
        ClearFog(transition_time);
      }
    }
  }

init_self_visionset() {
  if(!isDefined(self.vision_set_transition_ent)) {
    self.vision_set_transition_ent = spawnStruct();
    self.vision_set_transition_ent.vision_set = "";
    self.vision_set_transition_ent.time = 0;
  }
}

vision_set_changes(vision_set, transition_time) {
  if(!IsPlayer(self)) {
    vision_set_initd = true;
    if(!isDefined(level.vision_set_transition_ent)) {
      level.vision_set_transition_ent = spawnStruct();
      level.vision_set_transition_ent.vision_set = "";
      level.vision_set_transition_ent.time = 0;
      vision_set_initd = false;
    }

    if(vision_set != "" && level.vision_set_transition_ent.vision_set == vision_set && level.vision_set_transition_ent.time == transition_time) {
      return false;
    }

    level.vision_set_transition_ent.vision_set = vision_set;
    level.vision_set_transition_ent.time = transition_time;

    if(vision_set_initd && (GetDvarInt("scr_art_tweak") != 0)) {
      transition_time = 0;
      VisionSetNaked(vision_set, transition_time);
      level.player openpopupmenu("dev_vision_exec");
      wait(0.05);
      level.player closepopupmenu();
    } else {
      VisionSetNaked(vision_set, transition_time);
    }

    level.lvl_visionset = vision_set;
    SetDvar("vision_set_current", vision_set);
  } else {
    self init_self_visionset();

    if(vision_set != "" && self.vision_set_transition_ent.vision_set == vision_set && self.vision_set_transition_ent.time == transition_time) {
      return false;
    }

    self.vision_set_transition_ent.vision_set = vision_set;
    self.vision_set_transition_ent.time = transition_time;

    self VisionSetNakedForPlayer(vision_set, transition_time);
  }

  return true;
}

enable_teamflashbangImmunity() {
  self thread enable_teamflashbangImmunity_proc();
}

enable_teamflashbangImmunity_proc() {
  self endon("death");

  while(1) {
    self.teamFlashbangImmunity = true;
    wait .05;
  }
}

disable_teamflashbangImmunity() {
  self.teamFlashbangImmunity = undefined;
}

_radiusdamage(origin, range, maxdamage, mindamage, attacker) {
  if(!isDefined(attacker)) {
    RadiusDamage(origin, range, maxdamage, mindamage);
  } else {
    RadiusDamage(origin, range, maxdamage, mindamage, attacker);
  }
}

mask_destructibles_in_volumes(volumes) {
  destructible_toy = getEntArray("destructible_toy", "targetname");
  destructible_vehicles = getEntArray("destructible_vehicle", "targetname");

  combined_destructibles = array_combine(destructible_toy, destructible_vehicles);

  foreach(volume in volumes) {
    volume.destructibles = [];
  }

  foreach(toy in combined_destructibles) {
    foreach(volume in volumes) {
      if(!volume IsTouching(toy)) {
        continue;
      }

      volume put_toy_in_volume(toy);
      break;
    }
  }
}

InteractiveKeypairs() {
  interactiveKeypairs = [];
  interactiveKeypairs[0] = ["interactive_birds", "targetname"];
  interactiveKeypairs[1] = ["interactive_vulture", "targetname"];
  interactiveKeypairs[2] = ["interactive_fish", "script_noteworthy"];
  return interactiveKeypairs;
}

mask_interactives_in_volumes(volumes) {
  interactiveKeypairs = InteractiveKeypairs();
  combinedInteractives = [];
  foreach(interactiveKeypair in interactiveKeypairs) {
    moreInteractives = getEntArray(interactiveKeypair[0], interactiveKeypair[1]);
    combinedInteractives = array_combine(combinedInteractives, moreInteractives);
  }
  foreach(ent in combinedInteractives) {
    if(isDefined(ent.script_noteworthy)) ent_type = ent.script_noteworthy;
    else ent_type = ent.targetname;
    AssertEx(isDefined(ent.interactive_type), ent_type + " entity does not have an interactive_type keypair.");
    AssertEx(isDefined(level._interactive), ent_type + " entity in map, but level._interactive is not defined.");
    AssertEx(isDefined(level._interactive[ent.interactive_type]), (ent_type + " entity in map, but level._interactive[" + ent.interactive_type + "] is not defined."));

    if(!isDefined(level._interactive[ent.interactive_type].saveToStructFn)) {
      continue;
    }
    foreach(volume in volumes) {
      if(!volume IsTouching(ent)) {
        continue;
      }
      if(!isDefined(volume.interactives)) {
        volume.interactives = [];
      }
      volume.interactives[volume.interactives.size] = ent[[level._interactive[ent.interactive_type].saveToStructFn]]();
    }
  }
}

activate_interactives_in_volume() {
  if(!isDefined(self.interactives)) {
    return;
  }

  foreach(stored_int in self.interactives) {
    stored_int[[level._interactive[stored_int.interactive_type].loadFromStructFn]]();
  }
  self.interactives = undefined;
}

delete_interactives_in_volumes(volumes) {
  mask_interactives_in_volumes(volumes);
  foreach(volume in volumes) {
    volume.interactives = undefined;
  }
}

mask_exploders_in_volume(volumes) {
  if(GetDvar("createfx") != "") {
    return;
  }

  ents = getEntArray("script_brushmodel", "classname");
  smodels = getEntArray("script_model", "classname");
  for(i = 0; i < smodels.size; i++) {
    ents[ents.size] = smodels[i];
  }

  foreach(volume in volumes) {
    foreach(ent in ents) {}
    if(isDefined(ent.script_prefab_exploder)) {
      ent.script_exploder = ent.script_prefab_exploder;
    }

    if(!isDefined(ent.script_exploder)) {
      continue;
    }

    if(!isDefined(ent.model)) {
      continue;
    }
    if(ent.code_classname != "script_model") {
      continue;
    }
    if(!ent IsTouching(volume)) {
      continue;
    }
    ent.masked_exploder = true;
  }
}

activate_exploders_in_volume() {
  test_org = spawn("script_origin", (0, 0, 0));

  foreach(EntFx in level.createfxent) {
    if(!isDefined(EntFx.v["masked_exploder"])) {
      continue;
    }
    test_org.origin = EntFx.v["origin"];
    test_org.angles = EntFx.v["angles"];

    if(!test_org IsTouching(self)) {
      continue;
    }
    model_name = EntFx.v["masked_exploder"];
    spawnflags = EntFx.v["masked_exploder_spawnflags"];
    disconnect_paths = EntFX.v["masked_exploder_script_disconnectpaths"];
    new_ent = spawn("script_model", (0, 0, 0), spawnflags);
    new_ent setModel(model_name);
    new_ent.origin = EntFx.v["origin"];
    new_ent.angles = EntFx.v["angles"];
    Entfx.v["masked_exploder"] = undefined;
    Entfx.v["masked_exploder_spawnflags"] = undefined;
    Entfx.v["masked_exploder_script_disconnectpaths"] = undefined;
    new_ent.disconnect_paths = disconnect_paths;
    new_ent.script_exploder = EntFx.v["exploder"];
    common_scripts\_exploder::setup_individual_exploder(new_ent);
    EntFX.model = new_ent;
  }
  test_org delete();
}

precache_destructible(destructible_type) {
  infoIndex = common_scripts\_destructible::destructible_getInfoIndex(destructible_type);

  if(infoIndex != -1) {
    return;
  }
  if(!isDefined(level.destructible_functions)) {
    level.destructible_functions = [];
  }

  struct = spawnStruct();
  struct.destructibleInfo = self common_scripts\_destructible::destructible_getType(destructible_type);
  struct thread common_scripts\_destructible::precache_destructibles();
  struct thread common_scripts\_destructible::add_destructible_fx();
}

delete_destructibles_in_volumes(volumes, dodelayed) {
  foreach(volume in volumes) {
    volume.destructibles = [];
  }
  names = ["destructible_toy", "destructible_vehicle"];
  incs = 0;

  if(!isDefined(dodelayed)) {
    dodelayed = false;
  }
  foreach(name in names) {
    destructible_toy = getEntArray(name, "targetname");
    foreach(toy in destructible_toy) {
      foreach(volume in volumes) {
        if(dodelayed) {
          incs++;
          incs %= 5;
          if(incs == 1) {
            wait 0.05;
          }
        }
        if(!volume IsTouching(toy)) {
          continue;
        }
        toy delete();
        break;
      }
    }
  }

}

delete_exploders_in_volumes(volumes, dodelayed) {
  ents = getEntArray("script_brushmodel", "classname");
  smodels = getEntArray("script_model", "classname");
  for(i = 0; i < smodels.size; i++) {
    ents[ents.size] = smodels[i];
  }

  delete_ents = [];

  test_org = spawn("script_origin", (0, 0, 0));

  incs = 0;
  if(!isDefined(dodelayed)) {
    dodelayed = false;
  }

  foreach(volume in volumes) {
    foreach(ent in ents) {}
    if(!isDefined(ent.script_exploder)) {
      continue;
    }
    test_org.origin = ent GetOrigin();
    if(!volume IsTouching(test_org)) {
      continue;
    }
    delete_ents[delete_ents.size] = ent;
  }

  array_delete(delete_ents);

  test_org Delete();
}

activate_destructibles_in_volume() {
  if(!isDefined(self.destructibles)) {
    return;
  }

  foreach(ent in self.destructibles) {
    toy = spawn("script_model", (0, 0, 0));

    toy setModel(ent.toy_model);
    toy.origin = ent.origin;
    toy.angles = ent.angles;
    toy.script_noteworthy = ent.script_noteworthy;
    toy.targetname = ent.targetname;
    toy.target = ent.target;
    toy.script_linkto = ent.script_linkto;
    toy.destructible_type = ent.destructible_type;
    toy.script_noflip = ent.script_noflip;

    toy common_scripts\_destructible::setup_destructibles(true);
  }

  self.destructibles = [];
}

setFlashbangImmunity(immune) {
  self.flashBangImmunity = immune;
}

flashBangGetTimeLeftSec() {
  Assert(isDefined(self));
  Assert(isDefined(self.flashEndTime));

  durationMs = self.flashEndTime - GetTime();
  if(durationMs < 0) {
    return 0;
  }

  return (durationMs * 0.001);
}

flashBangIsActive() {
  return (flashBangGetTimeLeftSec() > 0);
}

flashBangStart(duration) {
  Assert(isDefined(self));
  Assert(isDefined(duration));

  if(isDefined(self.flashBangImmunity) && self.flashbangImmunity) {
    return;
  }

  newFlashEndTime = GetTime() + (duration * 1000.0);

  if(isDefined(self.flashendtime)) {
    self.flashEndTime = max(self.flashendtime, newFlashEndTime);
  } else {
    self.flashendtime = newFlashEndTime;
  }

  self notify("flashed");
  self SetFlashBanged(true);
}

waittill_volume_dead() {
  for(;;) {
    ai = GetAISpeciesArray("axis", "all");

    found_guy = false;
    foreach(guy in ai) {
      if(!isalive(guy)) {
        continue;
      }
      if(guy IsTouching(self)) {
        found_guy = true;
        break;
      }

      wait(0.0125);
    }
    if(!found_guy) {
      aHostiles = self get_ai_touching_volume("axis");
      if(!aHostiles.size) {
        break;
      }
    }
    wait(0.05);
  }
}

waittill_volume_dead_or_dying() {
  ever_found_guy = false;
  for(;;) {
    ai = GetAISpeciesArray("axis", "all");

    found_guy = false;
    foreach(guy in ai) {
      if(!isalive(guy)) {
        continue;
      }
      if(guy IsTouching(self)) {
        if(guy doingLongDeath()) {
          continue;
        }

        found_guy = true;
        ever_found_guy = true;
        break;
      }

      wait(0.0125);
    }
    if(!found_guy) {
      aHostiles = self get_ai_touching_volume("axis");
      if(!aHostiles.size) {
        break;
      } else {
        ever_found_guy = true;
      }
    }
    wait(0.05);
  }
  return ever_found_guy;
}

waittill_volume_dead_then_set_flag(sFlag) {
  self waittill_volume_dead();
  flag_set(sFlag);
}

waittill_targetname_volume_dead_then_set_flag(targetname, msg) {
  volume = GetEnt(targetname, "targetname");
  AssertEx(isDefined(volume), "No volume for targetname " + targetname);
  volume waittill_volume_dead_then_set_flag(msg);
}

player_can_be_shot() {
  level.player ent_flag_clear("player_zero_attacker_accuracy");
  level.player.IgnoreRandomBulletDamage = false;
  level.player maps\_gameskill::update_player_attacker_accuracy();
}

player_cant_be_shot() {
  level.player ent_flag_set("player_zero_attacker_accuracy");
  level.player.attackeraccuracy = 0;
  level.player.IgnoreRandomBulletDamage = true;
}

set_player_attacker_accuracy(val) {
  player = get_player_from_self();
  player.gs.player_attacker_accuracy = val;
  player maps\_gameskill::update_player_attacker_accuracy();
}

array_index_by_parameters(old_array) {
  array = [];
  foreach(item in old_array) {
    array[item.script_parameters] = item;
  }
  return array;
}

array_index_by_classname(old_array) {
  array = [];
  foreach(item in old_array) {
    array[item.classname] = item;
  }
  return array;
}

array_index_by_script_index(array) {
  newarray = [];
  foreach(ent in array) {
    index = ent.script_index;
    if(isDefined(index)) {
      AssertEx(!isDefined(newarray[index]), "Multiple ents had the same script_index of " + index);

      newarray[index] = ent;
    }
  }

  return newarray;
}

add_target_pivot(ent) {
  if(isDefined(ent)) {
    self.pivot = ent;
  } else {
    AssertEx(isDefined(self.target), "Tried to add pivot to an entity but it has no target.");
    self.pivot = GetEnt(self.target, "targetname");
    AssertEx(isDefined(self.pivot), "Tried to add pivot but there was no pivot entity. Must be a script mover, like a script_origin not script_struct.");
  }

  self LinkTo(self.pivot);
}

flashBangStop() {
  self.flashendtime = undefined;
  self SetFlashBanged(false);
}

getent_or_struct(param1, param2) {
  ent = GetEnt(param1, param2);
  if(isDefined(ent)) {
    return ent;
  }
  return getstruct(param1, param2);
}

grenade_earthQuake() {
  self thread endOnDeath();
  self endon("end_explode");

  self waittill("explode", position);

  dirt_on_screen_from_position(position);
}

endOnDeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

dirt_on_screen_from_position(position) {
  PlayRumbleOnPosition("grenade_rumble", position);
  Earthquake(0.3, 0.5, position, 400);

  foreach(player in level.players) {
    if(Distance(position, player.origin) > 600) {
      continue;
    }

    if(player DamageConeTrace(position)) {
      player thread dirtEffect(position);
    }
  }
}

player_rides_shotgun_in_humvee(right, left, up, down) {
  return self player_rides_in_humvee("shotgun", level.player, right, left, up, down);
}

player_rides_in_humvee(seat, rider, right, left, up, down) {
  if(!isDefined(rider)) {
    rider = level.player;
  }
  assert(isplayer(rider));

  rider AllowCrouch(false);
  rider AllowProne(false);
  rider DisableWeapons();

  org = spawn_tag_origin();
  org LinkTo(self, "tag_passenger", player_rides_in_humvee_offset(seat), (0, 0, 0));
  org.player_dismount = spawn_tag_origin();
  org.player_dismount LinkTo(self, "tag_body", player_rides_humvee_offset_dismount(seat), (0, 0, 0));

  if(!isDefined(right)) {
    right = 90;
  }
  if(!isDefined(left)) {
    left = 90;
  }
  if(!isDefined(up)) {
    up = 40;
  }
  if(!isDefined(down)) {
    down = 40;
  }

  rider DisableWeapons();
  rider PlayerLinkTo(org, "tag_origin", 0.8, right, left, up, down);
  rider.humvee_org = org;

  return org;
}

player_rides_in_humvee_offset(seat) {
  switch (seat) {
    case "shotgun":
      return (-5, 10, -34);
    case "backleft":
      return (-45, 45, -34);
    case "backright":
      return (-45, 5, -34);
  }

  assertmsg("No offset for " + seat + " was available in player_rides_in_humvee_offset()");
}

player_rides_humvee_offset_dismount(seat) {
  switch (seat) {
    case "shotgun":
      return (-8, -90, -12.6);
    case "backleft":
      return (-58, 85, -12.6);
    case "backright":
      return (-58, -95, -12.6);
  }

  assertmsg("No offset for " + seat + " was available in player_rides_humvee_offset_dismount()");
}

player_leaves_humvee(skip_offset) {
  if(!isDefined(skip_offset)) {
    skip_offset = false;
  }

  org = self;
  rider = level.player;
  if(isplayer(self)) {
    rider = self;
    org = rider.humvee_org;
  }

  org Unlink();
  if(!skip_offset) {
    move_time = 0.6;
    org MoveTo(org.player_dismount.origin, move_time, move_time * 0.5, move_time * 0.5);
    wait(move_time);
  }

  rider Unlink();
  rider EnableWeapons();
  rider AllowCrouch(true);
  rider AllowProne(true);
  rider.humvee_org = undefined;

  org.player_dismount Delete();
  org Delete();
}

dirtEffect(position, attacker) {
  sides = screen_effect_sides(position);

  foreach(type, _ in sides) {
    self thread maps\_gameskill::grenade_dirt_on_screen(type);
  }
}

bloodsplateffect(position) {
  if(!isDefined(self.damageAttacker)) {
    return;
  }

  sides = screen_effect_sides(self.damageAttacker.origin);

  foreach(type, _ in sides) {
    self thread maps\_gameskill::blood_splat_on_screen(type);
  }
}

screen_effect_sides(position) {
  forwardVec = VectorNormalize(anglesToForward(self.angles));
  rightVec = VectorNormalize(AnglesToRight(self.angles));
  entVec = VectorNormalize(position - self.origin);

  fDot = VectorDot(entVec, forwardVec);
  rDot = VectorDot(entVec, rightVec);

  sides = [];
  curWeapon = self GetCurrentWeapon();
  if(fDot > 0 && fDot > 0.5 && WeaponType(curWeapon) != "riotshield") {
    sides["bottom"] = true;
  }

  if(abs(fDot) < 0.866) {
    if(rDot > 0) {
      sides["right"] = true;
    } else {
      sides["left"] = true;
    }
  }

  return sides;
}

pathrandompercent_set(value) {
  if(!isDefined(self.old_pathrandompercent)) {
    self.old_pathrandompercent = self.pathrandompercent;
  }
  self.pathrandompercent = value;
}

pathrandompercent_zero() {
  if(isDefined(self.old_pathrandompercent)) {
    return;
  }

  self.old_pathrandompercent = self.pathrandompercent;
  self.pathrandompercent = 0;
}

pathrandompercent_reset() {
  Assert(isDefined(self.old_pathrandompercent));

  self.pathrandompercent = self.old_pathrandompercent;
  self.old_pathrandompercent = undefined;
}

walkdist_zero() {
  if(isDefined(self.old_walkDistFacingMotion)) {
    return;
  }

  self.old_walkDist = self.walkDist;
  self.old_walkDistFacingMotion = self.walkDistFacingMotion;

  self.walkdist = 0;
  self.walkDistFacingMotion = 0;
}

walkdist_force_walk() {
  if(!isDefined(self.old_walkDistFacingMotion)) {
    self.old_walkDist = self.walkDist;
    self.old_walkDistFacingMotion = self.walkDistFacingMotion;
  }

  self.walkdist = 999999999;
  self.walkDistFacingMotion = 999999999;
}

is_walkdist_override() {
  return (isDefined(self.old_walkDistFacingMotion) || isDefined(self.old_walkDist));
}

walkdist_reset() {
  Assert(isDefined(self.old_walkDist));
  Assert(isDefined(self.old_walkDistFacingMotion));

  self.walkdist = self.old_walkDist;
  self.walkDistFacingMotion = self.old_walkDistFacingMotion;

  self.old_walkDist = undefined;
  self.old_walkDistFacingMotion = undefined;
}

enable_ignorerandombulletdamage_drone() {
  self thread ignorerandombulletdamage_drone_proc();
}

ignorerandombulletdamage_drone_proc() {
  AssertEx(!IsSentient(self), "AI tried to run enable_ignorerandombulletdamage_drone");

  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");

  self.IgnoreRandomBulletDamage = true;
  self.fakehealth = self.health;
  self.health = 1000000;

  while(1) {
    self waittill("damage", damage, attacker);

    if(!isplayer(attacker) && IsSentient(attacker)) {
      if(isDefined(attacker.enemy) && attacker.enemy != self) {
        continue;
      }
    }

    self.fakehealth -= damage;

    if(self.fakehealth <= 0) {
      break;
    }
  }

  self Kill();
}

set_brakes(num) {
  self.veh_brake = num;
}

disable_ignorerandombulletdamage_drone() {
  if(!isalive(self)) {
    return;
  }
  if(!isDefined(self.IgnoreRandomBulletDamage)) {
    return;
  }

  self notify("disable_ignorerandombulletdamage_drone");
  self.IgnoreRandomBulletDamage = undefined;
  self.health = self.fakehealth;
}

timeOutEnt(timeOut) {
  ent = spawnStruct();
  ent delayThread(timeOut, ::send_notify, "timeout");
  return ent;
}

delayThread(timer, func, param1, param2, param3, param4, param5, param6) {
  thread delayThread_proc(func, timer, param1, param2, param3, param4, param5, param6);
}

delayChildThread(timer, func, param1, param2, param3, param4, param5, param6) {
  childthread delaychildThread_proc(func, timer, param1, param2, param3, param4, param5, param6);
}

flagWaitThread(flag, func, param1, param2, param3, param4, param5, param6) {
  self endon("death");

  if(!IsArray(flag)) {
    flag = [flag, 0];
  }

  self thread flagWaitThread_proc(func, flag, param1, param2, param3, param4, param5, param6);
}

waittillThread(note, func, param1, param2, param3, param4, param5, param6) {
  self endon("death");

  if(!IsArray(note)) {
    note = [note, 0];
  }

  self thread waittillThread_proc(func, note, param1, param2, param3, param4, param5, param6);
}

enable_danger_react(duration) {
  duration *= 1000;

  Assert(IsAI(self));
  self.doDangerReact = true;
  self.dangerReactDuration = duration;
  self.neverSprintForVariation = undefined;
}

disable_danger_react() {
  Assert(IsAI(self));
  self.doDangerReact = false;
  self.neverSprintForVariation = true;
}

set_group_advance_to_enemy_parameters(interval, group_size) {
  level.advanceToEnemyInterval = interval;
  level.advanceToEnemyGroupMax = group_size;
}

reset_group_advance_to_enemy_timer(team) {
  Assert(isDefined(level.lastAdvanceToEnemyTime[team]));
  level.lastAdvanceToEnemyTime[team] = GetTime();
}

set_custom_gameskill_func(func) {
  Assert(isDefined(func));
  level.custom_gameskill_func = func;

  thread maps\_gameskill::resetSkill();
}

clear_custom_gameskill_func() {
  level.custom_gameskill_func = undefined;

  thread maps\_gameskill::resetSkill();
}

set_wind(weight, rate, variance) {
  Assert(isDefined(weight));
  Assert(isDefined(rate));
  maps\_animatedmodels::init_wind_if_uninitialized();
  if(isDefined(variance)) {
    level.wind.variance = variance;
  }
  level.wind.rate = rate;
  level.wind.weight = weight;
  level notify("windchange", "strong");
}

string_is_single_digit_integer(str) {
  if(str.size > 1) {
    return false;
  }

  arr = [];
  arr["0"] = true;
  arr["1"] = true;
  arr["2"] = true;
  arr["3"] = true;
  arr["4"] = true;
  arr["5"] = true;
  arr["6"] = true;
  arr["7"] = true;
  arr["8"] = true;
  arr["9"] = true;

  if(isDefined(arr[str])) {
    return true;
  }

  return false;
}

set_battlechatter_variable(team, val) {
  level.battlechatter[team] = val;
  update_battlechatter_hud();
}

objective_clearAdditionalPositions(objective_number) {
  for(i = 0; i < 8; i++) {
    objective_additionalposition(objective_number, i, (0, 0, 0));
  }
}

get_minutes_and_seconds(milliseconds) {
  time = [];
  time["minutes"] = 0;
  time["seconds"] = Int(milliseconds / 1000);

  while(time["seconds"] >= 60) {
    time["minutes"]++;
    time["seconds"] -= 60;
  }
  if(time["seconds"] < 10) {
    time["seconds"] = "0" + time["seconds"];
  }

  return time;
}

player_has_weapon(weap) {
  weaponList = level.player GetWeaponsListPrimaries();
  foreach(weapon in weaponList) {
    if(weapon == weap) {
      return true;
    }
  }
  return false;
}

obj(msg) {
  if(!isDefined(level.obj_array)) {
    level.obj_array = [];
  }

  if(!isDefined(level.obj_array[msg])) {
    level.obj_array[msg] = level.obj_array.size + 1;
  }

  return level.obj_array[msg];
}

obj_exists(msg) {
  return isDefined(level.obj_array) && isDefined(level.obj_array[msg]);
}

player_mount_vehicle(vehicle) {
  assert(isplayer(self));
  self MountVehicle(vehicle);
  self.drivingVehicle = vehicle;
}

player_dismount_vehicle() {
  assert(isplayer(self));
  self DismountVehicle();
  self.drivingVehicle = undefined;
}

graph_position(v, min_x, min_y, max_x, max_y) {
  rise = max_y - min_y;
  run = max_x - min_x;
  assertex(run != 0, "max and min x must be different, or you havent defined any graph space.");
  slope = rise / run;

  v -= max_x;

  v = slope * v;

  v += max_y;

  return v;
}

enable_achievement_harder_they_fall() {
  self.rappeller = true;
}

disable_achievement_harder_they_fall() {
  self.rappeller = undefined;
}

enable_achievement_harder_they_fall_guy(guy) {
  guy enable_achievement_harder_they_fall();
}

disable_achievement_harder_they_fall_guy(guy) {
  guy disable_achievement_harder_they_fall();
}

musicLength(alias) {
  time = TableLookup("sound/soundlength.csv", 0, alias, 1);

  if(!isDefined(time) || (time == "")) {
    assertmsg("No time stored in sound/soundlength.csv for " + alias + ".");
    return -1;
  }

  time = int(time);
  assertex(time > 0, "Music alias " + alias + " had zero time.");
  time *= 0.001;
  return time;
}

is_command_bound(cmd) {
  binding = GetKeyBinding(cmd);
  return binding["count"];
}

linear_interpolate(percentage, min_value, max_value) {
  assert(isDefined(percentage));
  assert(isDefined(min_value));
  assert(isDefined(max_value));

  max_adjustment = max_value - min_value;
  real_adjustment = percentage * max_adjustment;
  final_value = min_value + real_adjustment;

  return final_value;
}

define_loadout(levelname) {
  level.loadout = levelname;
}

template_level(levelname) {
  define_loadout(levelname);
  level.template_script = levelname;
}

template_so_level(levelname) {
  level.audio_stringtable_mapname = levelname;
}

fx_volume_pause_noteworthy(noteworthy, dodelayed) {
  thread fx_volume_pause_noteworthy_thread(noteworthy, dodelayed);
}

fx_volume_pause_noteworthy_thread(noteworthy, dodelayed) {
  volume = GetEnt(noteworthy, "script_noteworthy");
  volume notify("new_volume_command");
  volume endon("new_volume_command");
  wait 0.05;
  fx_volume_pause(volume, dodelayed);
}

fx_volume_pause(volume, dodelayed) {
  Assert(isDefined(volume));
  volume.fx_paused = true;
  if(!isDefined(dodelayed)) {
    dodelayed = false;
  }

  if(dodelayed) {
    array_thread_mod_delayed(volume.fx, ::pauseeffect);
  } else {
    array_thread(volume.fx, ::pauseeffect);
  }
}

array_thread_mod_delayed(array, threadname, mod) {
  inc = 0;
  if(!isDefined(mod)) {
    mod = 5;
  }

  send_array = [];
  foreach(object in array) {
    send_array[send_array.size] = object;
    inc++;
    inc %= mod;
    if(mod == 0) {
      array_thread(send_array, threadname);
      wait 0.05;
      send_array = [];
    }
  }
}

fx_volume_restart_noteworthy(noteworthy) {
  thread fx_volume_restart_noteworthy_thread(noteworthy);
}

fx_volume_restart_noteworthy_thread(noteworthy) {
  volume = GetEnt(noteworthy, "script_noteworthy");
  volume notify("new_volume_command");
  volume endon("new_volume_command");

  wait 0.05;
  if(!isDefined(volume.fx_paused)) {
    return;
  }
  volume.fx_paused = undefined;

  fx_volume_restart(volume);
}

fx_volume_restart(volume) {
  Assert(isDefined(volume));
  array_thread(volume.fx, ::restartEffect);
}

flag_count_increment(msg) {
  AssertEx(flag_exist(msg), "Attempt to increment flag before calling flag_init: " + msg);
  if(!isDefined(level.flag_count)) {
    level.flag_count = [];
  }
  if(!isDefined(level.flag_count[msg])) {
    level.flag_count[msg] = 1;
  } else {
    level.flag_count[msg]++;
  }
}

flag_count_decrement(msg) {
  AssertEx(flag_exist(msg), "Attempt to decrement flag before calling flag_init: " + msg);
  AssertEx(isDefined(level.flag_count) && isDefined(level.flag_count[msg]), "Can't decrement a flag that's never been set/incremented.");
  level.flag_count[msg]--;
  level.flag_count[msg] = int(max(0, level.flag_count[msg]));
  if(level.flag_count[msg]) {
    return;
  }
  flag_set(msg);
}

flag_count_set(msg, count) {
  AssertEx(count, "don't support setting to Zero");
  AssertEx(flag_exist(msg), "Attempt to set flag count before calling flag_init: " + msg);
  level.flag_count[msg] = count;
}

add_cleanup_ent(ent, groupname) {
  Assert(isDefined(ent));
  Assert(isDefined(groupname));

  if(!isDefined(level.cleanup_ents)) {
    level.cleanup_ents = [];
  }

  if(!isDefined(level.cleanup_ents[groupname])) {
    level.cleanup_ents[groupname] = [];
  }

  if(array_contains(level.cleanup_ents[groupname], ent)) {
    AssertMsg("add_cleanup_ent - this ent already added");
  }

  level.cleanup_ents[groupname][level.cleanup_ents[groupname].size] = ent;
}

cleanup_ents(groupname) {
  Assert(isDefined(level.cleanup_ents));
  Assert(isDefined(level.cleanup_ents[groupname]));

  array = level.cleanup_ents[groupname];
  array = array_removeUndefined(array);
  array_delete(array);

  level.cleanup_ents[groupname] = undefined;
}

cleanup_ents_removing_bullet_shield(groupname) {
  if(!isDefined(level.cleanup_ents)) {
    return;
  }
  if(!isDefined(level.cleanup_ents[groupname])) {
    return;
  }

  array = level.cleanup_ents[groupname];
  array = array_removeUndefined(array);

  foreach(obj in array) {
    if(!IsAI(obj)) {
      continue;
    }
    if(!IsAlive(obj)) {
      continue;
    }
    if(!isDefined(obj.magic_bullet_shield)) {
      continue;
    }
    if(!obj.magic_bullet_shield) {
      continue;
    }
    obj stop_magic_bullet_shield();
  }

  array_delete(array);

  level.cleanup_ents[groupname] = undefined;
}

add_trigger_function(function) {
  if(!isDefined(self.trigger_functions)) {
    self thread add_trigger_func_thread();
  }
  self.trigger_functions[self.trigger_functions.size] = function;
}

getallweapons() {
  array = [];
  entities = getEntArray();
  foreach(ent in entities) {
    if(!isDefined(ent.classname)) {
      continue;
    }
    if(IsSubStr(ent.classname, "weapon_")) {
      array[array.size] = ent;
    }
  }
  return array;
}

radio_add(dialog) {
  level.scr_radio[dialog] = dialog;
}

move_with_rate(origin, angles, moverate) {
  Assert(isDefined(origin));
  Assert(isDefined(angles));
  Assert(isDefined(moverate));

  self notify("newmove");
  self endon("newmove");

  if(!isDefined(moverate)) {
    moverate = 200;
  }

  dist = Distance(self.origin, origin);
  movetime = dist / moverate;
  movevec = VectorNormalize(origin - self.origin);

  self MoveTo(origin, movetime, 0, 0);
  self RotateTo(angles, movetime, 0, 0);
  wait movetime;

  if(!isDefined(self)) {
    return;
  }
  self.velocity = movevec * (dist / movetime);
}

flag_on_death(msg) {
  level endon(msg);
  self waittill("death");
  flag_set(msg);
}

enable_damagefeedback_hud() {
  level.damagefeedbackhud = true;
}

disable_damagefeedback_hud() {
  level.damagefeedbackhud = false;
}

is_damagefeedback_hud_enabled() {
  return (isDefined(level.damagefeedbackhud) && level.damagefeedbackhud);
}

enable_damagefeedback_snd() {
  level.damagefeedbacksnd = true;
}

disable_damagefeedback_snd() {
  level.damagefeedbacksnd = false;
}

is_damagefeedback_snd_enabled() {
  return (isDefined(level.damagefeedbacksnd) && level.damagefeedbacksnd);
}

add_damagefeedback() {
  assert(isDefined(self));
  self maps\_damagefeedback::monitorDamage();
}

remove_damagefeedback() {
  assert(isDefined(self));
  self maps\_damagefeedback::stopMonitorDamage();
}

is_demo() {
  if(GetDvar("e3demo") == "1") {
    return true;
  }

  return false;
}

deletestructarray(value, key, delay) {
  structs = getstructarray(value, key);
  deletestructarray_ref(structs, delay);
}

deletestruct_ref(struct) {
  if(!isDefined(struct)) {
    return;
  }

  value = struct.script_linkname;

  if(isDefined(value) &&
    isDefined(level.struct_class_names["script_linkname"]) &&
    isDefined(level.struct_class_names["script_linkname"][value])) {
    foreach(i, _struct in level.struct_class_names["script_linkname"][value]) {
      if(isDefined(_struct) && struct == _struct)
    }
    level.struct_class_names["script_linkname"][value][i] = undefined;

    if(level.struct_class_names["script_linkname"][value].size == 0) {
      level.struct_class_names["script_linkname"][value] = undefined;
    }
  }

  value = struct.script_noteworthy;

  if(isDefined(value) &&
    isDefined(level.struct_class_names["script_noteworthy"]) &&
    isDefined(level.struct_class_names["script_noteworthy"][value])) {
    foreach(i, _struct in level.struct_class_names["script_noteworthy"][value]) {
      if(isDefined(_struct) && struct == _struct)
    }
    level.struct_class_names["script_noteworthy"][value][i] = undefined;

    if(level.struct_class_names["script_noteworthy"][value].size == 0) {
      level.struct_class_names["script_noteworthy"][value] = undefined;
    }
  }

  value = struct.target;

  if(isDefined(value) &&
    isDefined(level.struct_class_names["target"]) &&
    isDefined(level.struct_class_names["target"][value])) {
    foreach(i, _struct in level.struct_class_names["target"][value]) {
      if(isDefined(_struct) && struct == _struct)
    }
    level.struct_class_names["target"][value][i] = undefined;

    if(level.struct_class_names["target"][value].size == 0) {
      level.struct_class_names["target"][value] = undefined;
    }
  }

  value = struct.targetname;

  if(isDefined(value) &&
    isDefined(level.struct_class_names["targetname"]) &&
    isDefined(level.struct_class_names["targetname"][value])) {
    foreach(i, _struct in level.struct_class_names["targetname"][value]) {
      if(isDefined(_struct) && struct == _struct)
    }
    level.struct_class_names["targetname"][value][i] = undefined;

    if(level.struct_class_names["targetname"][value].size == 0) {
      level.struct_class_names["targetname"][value] = undefined;
    }
  }

  if(isDefined(level.struct)) {
    foreach(i, _struct in level.struct)
  }
  if(struct == _struct) {
    level.struct[i] = undefined;
  }
}

deletestructarray_ref(structs, delay) {
  if(!isDefined(structs) || !IsArray(structs) || structs.size == 0) {
    return;
  }

  delay = ter_op(isDefined(delay), delay, 0);
  delay = ter_op(delay > 0, delay, 0);

  if(delay > 0) {
    foreach(struct in structs) {
      deletestruct_ref(struct);
      wait delay;
    }
  } else {
    foreach(struct in structs)
  }
  deletestruct_ref(struct);
}

getstruct_delete(value, key) {
  struct = getstruct(value, key);
  deletestruct_ref(struct);
  return struct;
}

getstructarray_delete(value, key, delay) {
  structs = getstructarray(value, key);
  deletestructarray_ref(structs, delay);
  return structs;
}

getent_or_struct_or_node(value, key) {
  Assert(isDefined(value));
  Assert(isDefined(key));

  ent = getent_or_struct(value, key);

  if(!isDefined(ent)) {
    ent = GetNode(value, key);
  }
  if(!isDefined(ent)) {
    ent = GetVehicleNode(value, key);
  }
  return ent;
}

setEntityHeadIcon(icon_shader, icon_width, icon_height, offset, reference_point_func) {
  assertex(isDefined(icon_shader), "setEntityHeadIcon() requires icon shader passed in.");

  if(isDefined(offset)) {
    self.entityHeadIconOffset = offset;
  } else {
    self.entityHeadIconOffset = (0, 0, 0);
  }

  if(isDefined(reference_point_func)) {
    self.entityHeadIconReferenceFunc = reference_point_func;
  }

  self notify("new_head_icon");

  headIcon = newhudelem();
  headIcon.archived = true;
  headIcon.alpha = .8;
  headIcon setShader(icon_shader, icon_width, icon_height);
  headIcon setWaypoint(false, false, false, true);
  self.entityHeadIcon = headIcon;
  self updateEntityHeadIconOrigin();

  self thread updateEntityHeadIcon();
  self thread destroyEntityHeadIconOnDeath();
}

removeEntityHeadIcon() {
  if(!isDefined(self.entityHeadIcon)) {
    return;
  }

  self.entityHeadIcon destroy();
}

updateEntityHeadIcon() {
  self endon("new_head_icon");
  self endon("death");

  pos = self.origin;
  while(1) {
    if(pos != self.origin) {
      self updateEntityHeadIconOrigin();
      pos = self.origin;
    }
    wait .05;
  }
}

updateEntityHeadIconOrigin() {
  if(isDefined(self.entityHeadIconReferenceFunc)) {
    entityHeadIconReference = self[[self.entityHeadIconReferenceFunc]]();

    if(isDefined(entityHeadIconReference)) {
      self.entityHeadIcon.x = self.entityHeadIconOffset[0] + entityHeadIconReference[0];
      self.entityHeadIcon.y = self.entityHeadIconOffset[1] + entityHeadIconReference[1];
      self.entityHeadIcon.z = self.entityHeadIconOffset[2] + entityHeadIconReference[2];

      return;
    }
  }

  self.entityHeadIcon.x = self.origin[0] + self.entityHeadIconOffset[0];
  self.entityHeadIcon.y = self.origin[1] + self.entityHeadIconOffset[1];
  self.entityHeadIcon.z = self.origin[2] + self.entityHeadIconOffset[2];
}

destroyEntityHeadIconOnDeath() {
  self endon("new_head_icon");
  self waittill("death");

  if(!isDefined(self.entityHeadIcon)) {
    return;
  }

  self.entityHeadIcon destroy();
}

WorldToLocalCoords(world_vec) {
  pos_to_vec_world = world_vec - self.origin;

  return (VectorDot(pos_to_vec_world, anglesToForward(self.angles)), -1.0 * VectorDot(pos_to_vec_world, AnglesToRight(self.angles)), VectorDot(pos_to_vec_world, AnglesToUp(self.angles)));
}

intro_screen_create(string1, string2, string3, string4, string5) {
  AssertEx(!isDefined(level.introScreen), "intro_screen_create called Twice, Make up your mind!");

  level.introScreen = spawnStruct();

  level.introScreen.completed_delay = 3;
  level.introScreen.fade_out_time = 1.5;
  level.introScreen.fade_in_time = undefined;

  if(isDefined(string4)) {
    level.introScreen.lines = [string1, string2, string3, string4];
  } else {
    level.introScreen.lines = [string1, string2, string3];
  }
  noself_array_call(level.introScreen.lines, ::PreCacheString);
}

intro_screen_custom_func(function) {
  AssertEx(isDefined(level.introScreen), "must call intro_screen_custom_func after intro_screen_create");
  level.introScreen.CustomFunc = function;
}

intro_screen_custom_timing(completed_delay, fade_out_time, fade_in_time) {
  AssertEx(isDefined(level.introScreen), "must call intro_screen_custom_timing after Intro_Screen_Create");
  level.introScreen.completed_delay = completed_delay;
  level.introScreen.fade_out_time = fade_out_time;
  level.introScreen.fade_in_time = fade_in_time;
}

set_npc_anims(archetypeName, run_anim, walk_anim, idle_anim_array, arrive_anim_array, exit_anim_array, arrivals_exits_trans_types, run_turn_anim_array, walk_turn_anim_array, stairs_anim_array) {
  Assert(IsAI(self));
  Assert(isDefined(archetypeName));

  if(isDefined(run_anim)) {
    self.run_overrideanim = run_anim;
  }
  if(isDefined(walk_anim)) {
    self.walk_overrideanim = walk_anim;
  }
  if(isDefined(idle_anim_array)) {
    self.specialIdleAnim = idle_anim_array;
  }

  self.animArchetype = archetypeName;
  archetype = [];

  if(isDefined(arrive_anim_array) && isDefined(exit_anim_array)) {
    AssertEx(isDefined(arrivals_exits_trans_types) && IsArray(arrivals_exits_trans_types), "Must define array of transition types to associate with");

    Assert(isDefined(arrive_anim_array[1]));
    Assert(isDefined(arrive_anim_array[2]));
    Assert(isDefined(arrive_anim_array[3]));
    Assert(isDefined(arrive_anim_array[4]));
    Assert(isDefined(arrive_anim_array[6]));
    Assert(isDefined(arrive_anim_array[7]));
    Assert(isDefined(arrive_anim_array[8]));
    Assert(isDefined(arrive_anim_array[9]));

    Assert(isDefined(exit_anim_array[1]));
    Assert(isDefined(exit_anim_array[2]));
    Assert(isDefined(exit_anim_array[3]));
    Assert(isDefined(exit_anim_array[4]));
    Assert(isDefined(exit_anim_array[6]));
    Assert(isDefined(exit_anim_array[7]));
    Assert(isDefined(exit_anim_array[8]));
    Assert(isDefined(exit_anim_array[9]));

    arrive_animset = [];
    foreach(transType in arrivals_exits_trans_types) {
      arrive_animset[transType] = arrive_anim_array;
    }
    archetype["cover_trans"] = arrive_animset;

    exit_animset = [];
    foreach(transType in arrivals_exits_trans_types) {
      exit_animset[transType] = exit_anim_array;
    }
    archetype["cover_exit"] = exit_animset;
  } else if(isDefined(arrive_anim_array) || isDefined(exit_anim_array)) {
    AssertMsg("Did you specify one and not the other ? (arrivals/exits) ");
  }

  if(isDefined(run_turn_anim_array)) {
    Assert(isDefined(run_turn_anim_array[0]));
    Assert(isDefined(run_turn_anim_array[1]));
    Assert(isDefined(run_turn_anim_array[2]));
    Assert(isDefined(run_turn_anim_array[3]));
    Assert(isDefined(run_turn_anim_array[5]));
    Assert(isDefined(run_turn_anim_array[6]));
    Assert(isDefined(run_turn_anim_array[7]));
    Assert(isDefined(run_turn_anim_array[8]));

    if(isDefined(walk_turn_anim_array)) {
      Assert(isDefined(walk_turn_anim_array[0]));
      Assert(isDefined(walk_turn_anim_array[1]));
      Assert(isDefined(walk_turn_anim_array[2]));
      Assert(isDefined(walk_turn_anim_array[3]));
      Assert(isDefined(walk_turn_anim_array[5]));
      Assert(isDefined(walk_turn_anim_array[6]));
      Assert(isDefined(walk_turn_anim_array[7]));
      Assert(isDefined(walk_turn_anim_array[8]));
    }

    archetype["run_turn"] = run_turn_anim_array;
    archetype["walk_turn"] = walk_turn_anim_array;
    self.noTurnAnims = undefined;
  } else if(isDefined(walk_turn_anim_array)) {
    AssertEx("Must specify run turns.");
  } else {
    self.noTurnAnims = true;
  }

  if(isDefined(stairs_anim_array)) {
    animset = [];

    animset["stairs_up"] = stairs_anim_array["stairs_up"];
    animset["stairs_down"] = stairs_anim_array["stairs_down"];
    animset["stairs_up_in"] = stairs_anim_array["stairs_up_in"];
    animset["stairs_down_in"] = stairs_anim_array["stairs_down_in"];
    animset["stairs_up_out"] = stairs_anim_array["stairs_up_out"];
    animset["stairs_down_out"] = stairs_anim_array["stairs_down_out"];

    archetype["walk"] = animset;
    archetype["run"] = animset;

    self.run_overrideanim_hasStairAnimArray = true;
  } else {
    self.run_overrideanim_hasStairAnimArray = undefined;
  }

  anim.archetypes[archetypeName] = archetype;
  animscripts\init_move_transitions::initTransDistAndAnglesForArchetype(archetypeName);
}

clear_npc_anims(archetypeName) {
  self.animArchetype = undefined;
  anim.archetypes[archetypeName] = undefined;
  self.run_overrideanim = undefined;
  self.run_overrideanim_hasStairAnimArray = undefined;
  self.walk_overrideanim = undefined;
  self.specialIdleAnim = undefined;
}

register_archetype(name, anims, calc_split_times) {
  animscripts\animset::RegisterArchetype(name, anims, calc_split_times);
}

archetype_exists(name) {
  return animscripts\animset::ArchetypeExists(name);
}

set_archetype(name) {
  assert(animscripts\animset::ArchetypeExists(name));
  self.animArchetype = name;
  self notify("move_loop_restart");

  if(name == "creepwalk") {
    self.sharpTurnLookaheadDist = 72;
  }
}

clear_archetype() {
  if(isDefined(self.animArchetype) && self.animArchetype == "creepwalk") {
    self.sharpTurnLookaheadDist = 30;
  }

  self.animArchetype = undefined;
  self notify("move_loop_restart");
}

shot_endangers_any_player(start, end) {
  foreach(player in level.players) {
    if(player shot_endangers_player(start, end)) {
      return true;
    }
  }
  return false;
}

TRACE_ENDANGERS_PLAYER_RADIUS = 60;
shot_endangers_player(start, end) {
  player_center = self GetPointInBounds(0, 0, 0);

  to_player = player_center - start;
  range_to_player = Length(to_player);
  min_angle = ASin(Clamp(TRACE_ENDANGERS_PLAYER_RADIUS / range_to_player, 0, 1));
  if(VectorDot(VectorNormalize(to_player), VectorNormalize(end - start)) > Cos(min_angle)) {
    return true;
  }

  return false;
}

transient_load(name) {
  LoadTransient(name);
  while(!IsTransientLoaded(name)) {
    wait(0.1);
  }

  flag_set(name + "_loaded");
}

transient_unload(name) {
  UnloadTransient(name);
  while(IsTransientLoaded(name)) {
    wait(0.1);
  }

  flag_clear(name + "_loaded");
}

transient_init(name) {
  AssertEx(!isDefined(level._loadStarted), "transient_init() must be set before _load::main()");
  flag_init(name + "_loaded");
}

transient_switch(prev, next) {
  if(flag(prev + "_loaded")) {
    transient_unload(prev);
  }

  if(!flag(next + "_loaded")) {
    transient_load(next);
  }
}

transient_unloadall_and_load(name) {
  UnloadAllTransients();
  transient_load(name);
}

deep_array_call(ents, process, args) {
  Assert(isDefined(ents));
  Assert(isDefined(process));

  if(!isDefined(args)) {
    foreach(ent in ents) {
      if(isDefined(ent))
    }
    if(IsArray(ent)) {
      deep_array_call(ent, process);
    } else {
      ent call[[process]]();
    }
    return;
  }

  Assert(IsArray(args));

  switch (args.size) {
    case 0:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_call(ent, process, args);
      } else {
        ent call[[process]]();
      }
      break;
    case 1:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_call(ent, process, args);
      } else {
        ent call[[process]](args[0]);
      }
      break;
    case 2:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_call(ent, process, args);
      } else {
        ent call[[process]](args[0], args[1]);
      }
      break;
    case 3:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_call(ent, process, args);
      } else {
        ent call[[process]](args[0], args[1], args[2]);
      }
      break;
    case 4:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_call(ent, process, args);
      } else {
        ent call[[process]](args[0], args[1], args[2], args[3]);
      }
      break;
    case 5:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_call(ent, process, args);
      } else {
        ent call[[process]](args[0], args[1], args[2], args[3], args[4]);
      }
      break;
  }
  return;
}

deep_array_thread(ents, process, args) {
  Assert(isDefined(ents));
  Assert(isDefined(process));

  if(!isDefined(args)) {
    foreach(ent in ents) {
      if(isDefined(ent))
    }
    if(IsArray(ent)) {
      deep_array_thread(ent, process, args);
    } else {
      ent thread[[process]]();
    }
    return;
  }

  Assert(IsArray(args));

  switch (args.size) {
    case 0:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_thread(ent, process, args);
      } else {
        ent thread[[process]]();
      }
      break;
    case 1:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_thread(ent, process, args);
      } else {
        ent thread[[process]](args[0]);
      }
      break;
    case 2:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_thread(ent, process, args);
      } else {
        ent thread[[process]](args[0], args[1]);
      }
      break;
    case 3:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_thread(ent, process, args);
      } else {
        ent thread[[process]](args[0], args[1], args[2]);
      }
      break;
    case 4:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_thread(ent, process, args);
      } else {
        ent thread[[process]](args[0], args[1], args[2], args[3]);
      }
      break;
    case 5:
      foreach(ent in ents) {
        if(isDefined(ent))
      }
      if(IsArray(ent)) {
        deep_array_thread(ent, process, args);
      } else {
        ent thread[[process]](args[0], args[1], args[2], args[3], args[4]);
      }
      break;
  }
  return;
}

setdvar_cg_ng(dvar_name, current_gen_val, next_gen_val) {
  if(!isDefined(level.console)) {
    set_console_status();
  }
  AssertEx(isDefined(level.console) && isDefined(level.xb3) && isDefined(level.ps4), "Expected platform defines to be complete.");

  if(is_gen4()) {
    setdvar(dvar_name, next_gen_val);
  } else {
    setdvar(dvar_name, current_gen_val);
  }
}

setsaveddvar_cg_ng(dvar_name, current_gen_val, next_gen_val) {
  if(!isDefined(level.console)) {
    set_console_status();
  }
  AssertEx(isDefined(level.console) && isDefined(level.xb3) && isDefined(level.ps4), "Expected platform defines to be complete.");

  if(is_gen4()) {
    setsaveddvar(dvar_name, next_gen_val);
  } else {
    setsaveddvar(dvar_name, current_gen_val);
  }
}

follow_path_and_animate(start_node, require_player_dist) {
  self endon("death");
  self endon("stop_path");

  self notify("stop_going_to_node");
  self notify("follow_path");
  self endon("follow_path");

  wait 0.1;

  node = start_node;

  getfunc = undefined;
  gotofunc = undefined;

  if(!isDefined(require_player_dist)) {
    require_player_dist = 300;
  }

  self.current_follow_path = node;

  node script_delay();

  while(isDefined(node)) {
    self.current_follow_path = node;

    if(isDefined(node.lookahead)) {
      break;
    }
    if(isDefined(level.struct_class_names["targetname"][node.targetname])) {
      gotofunc = ::follow_path_animate_set_struct;
    } else if(isDefined(node.classname)) {
      gotofunc = ::follow_path_animate_set_ent;
    } else {
      gotofunc = ::follow_path_animate_set_node;
    }

    if(isDefined(node.radius) && node.radius != 0) {
      self.goalradius = node.radius;
    }
    if(self.goalradius < 16) {
      self.goalradius = 16;
    }
    if(isDefined(node.height) && node.height != 0) {
      self.goalheight = node.height;
    }

    original_goalradius = self.goalradius;

    self childthread[[gotofunc]](node);

    if(isDefined(node.animation)) {
      node waittill(node.animation);
    } else {
      while(1) {}
      self waittill("goal");
      if(Distance(node.origin, self.origin) < (original_goalradius + 10) || self.team != "allies") {
        break;
      }
    }

    node notify("trigger", self);

    if(isDefined(node.script_flag_set)) {
      flag_set(node.script_flag_set);
    }

    if(isDefined(node.script_parameters)) {
      words = strtok(node.script_parameters, " ");
      for(i = 0; i < words.size; i++) {
        if(isDefined(level.custom_followpath_parameter_func)) {
          self[[level.custom_followpath_parameter_func]](words[i], node);
        }
        if(self.type == "dog") {} else {
          switch (words[i]) {
            case "enable_cqb":
              self enable_cqbwalk();
              break;
            case "disable_cqb":
              self disable_cqbwalk();
              break;
            case "deleteme":
              self delete();
              return;
          }
        }
      }
    }

    if(!isDefined(node.script_requires_player) && require_player_dist > 0 && self.team == "allies") {
      while(IsAlive(level.player)) {
        if(self follow_path_wait_for_player(node, require_player_dist)) {
          break;
        }
        if(isDefined(node.animation)) {
          self.goalradius = original_goalradius;
          self SetGoalPos(self.origin);
        }
        wait 0.05;
      }
    }

    if(!isDefined(node.target)) {
      break;
    }

    if(isDefined(node.script_flag_wait)) {
      flag_wait(node.script_flag_wait);
    }

    node script_delay();

    node = node get_target_ent();
  }

  self notify("path_end_reached");
}

follow_path_wait_for_player(node, dist) {
  if(Distance(level.player.origin, node.origin) < Distance(self.origin, node.origin)) {
    return true;
  }

  vec = undefined;

  vec = anglesToForward(self.angles);
  vec2 = VectorNormalize((level.player.origin - self.origin));

  if(isDefined(node.target)) {
    temp = get_target_ent(node.target);
    vec = VectorNormalize(temp.origin - node.origin);
  } else if(isDefined(node.angles)) {
    vec = anglesToForward(node.angles);
  } else {
    vec = anglesToForward(self.angles);
  }

  if(VectorDot(vec, vec2) > 0) {
    return true;
  }

  if(Distance(level.player.origin, self.origin) < dist) {
    return true;
  }

  return false;
}

follow_path_animate_set_node(node) {
  self notify("follow_path_new_goal");
  if(isDefined(node.animation)) {
    node maps\_anim::anim_generic_reach(self, node.animation);
    self notify("starting_anim", node.animation);
    if(isDefined(node.script_parameters) && issubstr(node.script_parameters, "gravity")) {
      node maps\_anim::anim_generic_gravity(self, node.animation);
    } else {
      node maps\_anim::anim_generic_run(self, node.animation);
    }
    self setGoalPos(self.origin);
  } else {
    self set_goal_node(node);
  }
}

follow_path_animate_set_ent(ent) {
  self notify("follow_path_new_goal");
  if(isDefined(ent.animation)) {
    ent maps\_anim::anim_generic_reach(self, ent.animation);
    self notify("starting_anim", ent.animation);
    if(isDefined(ent.script_parameters) && issubstr(ent.script_parameters, "gravity")) {
      ent maps\_anim::anim_generic_gravity(self, ent.animation);
    } else {
      ent maps\_anim::anim_generic_run(self, ent.animation);
    }
    self setGoalPos(self.origin);
  } else {
    self set_goal_ent(ent);
  }
}

follow_path_animate_set_struct(struct) {
  self notify("follow_path_new_goal");
  if(isDefined(struct.animation)) {
    struct maps\_anim::anim_generic_reach(self, struct.animation);
    self notify("starting_anim", struct.animation);
    self disable_exits();
    if(isDefined(struct.script_parameters) && issubstr(struct.script_parameters, "gravity")) {
      struct maps\_anim::anim_generic_gravity(self, struct.animation);
    } else {
      struct maps\_anim::anim_generic_run(self, struct.animation);
    }
    self delayThread(0.05, ::enable_exits);
    self setGoalPos(self.origin);
  } else {
    self set_goal_pos(struct.origin);
  }
}

post_load_precache(function) {
  if(!isDefined(level.post_load_funcs)) {
    level.post_load_funcs = [];
  }
  level.post_load_funcs = array_add(level.post_load_funcs, function);
}

game_is_current_gen() {
  if(level.xenon) {
    return true;
  }
  if(level.ps3) {
    return true;
  }

  return false;
}

LerpFov_Saved(fov_dest, time) {
  thread LerpFov_Saved_thread(fov_dest, time);
}

LerpFov_Saved_thread(fov_dest, time) {
  self notify("new_lerp_Fov_Saved");
  self endon("new_lerp_Fov_Saved");
  self LerpFOV(fov_dest, time);
  wait time;
  SetSavedDvar("cg_fov", fov_dest);
}

getDvarFloatDefault(dvarName, defaultValue) {
  value = getDvar(dvarName);
  if(value != "") {
    return float(value);
  }
  return defaultValue;
}

getDvarIntDefault(dvarName, defaultValue) {
  value = getDvar(dvarName);
  if(value != "") {
    return int(value);
  }
  return defaultValue;
}

ui_action_slot_force_active_on(slot) {
  dvarName = "ui_actionslot_" + slot + "_forceActive";
  SetDvar(dvarName, "on");
}

ui_action_slot_force_active_off(slot) {
  dvarName = "ui_actionslot_" + slot + "_forceActive";
  SetDvar(dvarName, "turn_off");
}

ui_action_slot_force_active_one_time(slot) {
  dvarName = "ui_actionslot_" + slot + "_forceActive";
  SetDvar(dvarName, "onetime");
}

HasTag(model, tag) {
  partCount = GetNumParts(model);
  for(i = 0; i < partCount; i++) {
    if(toLower(GetPartName(model, i)) == toLower(tag)) {
      return true;
    }
  }
  return false;
}

stylized_center_text(strings, time, glowcolor, type_speed) {
  if(!IsArray(strings)) {
    strings = [strings];
  }

  x = 320;
  y = 200;

  huds = [];
  foreach(i, str in strings) {
    temp_huds = maps\_introscreen::stylized_line(str, time, x, y + (i * 20), "center", glowcolor, type_speed);
    huds = array_combine(temp_huds, huds);
  }

  wait(time);
  maps\_introscreen::stylized_fadeout(huds, x, y, strings.size);
}

center_screen_text(lines) {
  thread maps\_introscreen::center_screen_lines(lines);
}

enable_s1_motionset(enabled) {
  if(!s1_motionset_avaliable()) {
    Print("S1 motionset unavaliable.");
    return;
  }

  if(isDefined(self.mech) && self.mech) {
    return;
  }

  if(!level.nextgen) {
    Print("S1 motionset features are only enabled for NG, and should never be called for CG levels.");
    return;
  }

  if(isDefined(enabled) && enabled) {
    if(!isDefined(self.animArchetype) || self.animArchetype == "soldier") {
      self.animArchetype = "s1_soldier";
    }
  } else {
    if(!isDefined(self.animArchetype) || self.animArchetype == "s1_soldier") {
      self.animArchetype = "soldier";
    }
  }
}

s1_motionset_avaliable() {
  if(level.nextgen) {
    return true;
  }
  return false;
}

ai_ignore_everything() {
  if(isDefined(self.script_drone)) {
    return;
  }

  if(isDefined(self._ignore_settings_old)) {
    self ai_unignore_everything();
  }

  self._ignore_settings_old = [];

  self.disableplayeradsloscheck = ai_save_ignore_setting(self.disableplayeradsloscheck, "disableplayeradsloscheck", true);
  self.ignoreall = ai_save_ignore_setting(self.ignoreall, "ignoreall", true);
  self.ignoreme = ai_save_ignore_setting(self.ignoreme, "ignoreme", true);
  self.grenadeAwareness = ai_save_ignore_setting(self.grenadeAwareness, "grenadeawareness", 0);
  self.badplaceawareness = ai_save_ignore_setting(self.badplaceawareness, "badplaceawareness", 0);
  self.ignoreexplosionevents = ai_save_ignore_setting(self.ignoreexplosionevents, "ignoreexplosionevents", true);
  self.ignorerandombulletdamage = ai_save_ignore_setting(self.ignorerandombulletdamage, "ignorerandombulletdamage", true);
  self.ignoresuppression = ai_save_ignore_setting(self.ignoresuppression, "ignoresuppression", true);
  self.dontavoidplayer = ai_save_ignore_setting(self.dontavoidplayer, "dontavoidplayer", true);
  self.newEnemyReactionDistSq = ai_save_ignore_setting(self.newEnemyReactionDistSq, "newEnemyReactionDistSq", 0);
  self.disableBulletWhizbyReaction = ai_save_ignore_setting(self.disableBulletWhizbyReaction, "disableBulletWhizbyReaction", true);
  self.disableFriendlyFireReaction = ai_save_ignore_setting(self.disableFriendlyFireReaction, "disableFriendlyFireReaction", true);
  self.dontMelee = ai_save_ignore_setting(self.dontMelee, "dontMelee", true);
  self.flashBangImmunity = ai_save_ignore_setting(self.flashBangImmunity, "flashBangImmunity", true);
  self.doDangerReact = ai_save_ignore_setting(self.doDangerReact, "doDangerReact", false);
  self.neverSprintForVariation = ai_save_ignore_setting(self.neverSprintForVariation, "neverSprintForVariation", true);
  self.a.disablePain = ai_save_ignore_setting(self.a.disablePain, "a.disablePain", true);
  self.allowPain = ai_save_ignore_setting(self.allowPain, "allowPain", false);
  self.fixednode = ai_save_ignore_setting(self.fixednode, "fixedNode", 1);
  self.script_forcegoal = ai_save_ignore_setting(self.script_forcegoal, "script_forcegoal", 1);
  self.goalradius = ai_save_ignore_setting(self.goalradius, "goalradius", 5);

  self disable_ai_color();
}

ai_unignore_everything(dont_restore_old) {
  if(isDefined(self.script_drone)) {
    return;
  }

  if(isDefined(dont_restore_old) && dont_restore_old) {
    if(isDefined(self._ignore_settings_old))
  }
  self._ignore_settings_old = undefined;

  self.disableplayeradsloscheck = ai_restore_ignore_setting("disableplayeradsloscheck", false);
  self.ignoreall = ai_restore_ignore_setting("ignoreall", false);
  self.ignoreme = ai_restore_ignore_setting("ignoreme", false);
  self.grenadeAwareness = ai_restore_ignore_setting("grenadeawareness", 1);
  self.badplaceAwareness = ai_restore_ignore_setting("badplaceawareness", 1);
  self.ignoreexplosionevents = ai_restore_ignore_setting("ignoreexplosionevents", false);
  self.ignorerandombulletdamage = ai_restore_ignore_setting("ignorerandombulletdamage", false);
  self.ignoresuppression = ai_restore_ignore_setting("ignoresuppression", false);
  self.dontavoidplayer = ai_restore_ignore_setting("dontavoidplayer", false);
  self.newEnemyReactionDistSq = ai_restore_ignore_setting("newEnemyReactionDistSq", 262144);
  self.disableBulletWhizbyReaction = ai_restore_ignore_setting("disableBulletWhizbyReaction", undefined);
  self.disableFriendlyFireReaction = ai_restore_ignore_setting("disableFriendlyFireReaction", undefined);
  self.dontMelee = ai_restore_ignore_setting("dontMelee", undefined);
  self.flashBangImmunity = ai_restore_ignore_setting("flashBangImmunity", undefined);
  self.doDangerReact = ai_restore_ignore_setting("doDangerReact", true);
  self.neverSprintForVariation = ai_restore_ignore_setting("neverSprintForVariation", undefined);
  self.a.disablePain = ai_restore_ignore_setting("a.disablePain", false);
  self.allowPain = ai_restore_ignore_setting("allowPain", true);
  self.fixednode = ai_restore_ignore_setting("fixedNode", 0);
  self.script_forcegoal = ai_restore_ignore_setting("script_forcegoal", 0);
  self.goalradius = ai_restore_ignore_setting("goalradius", 100);

  self enable_ai_color();

  self._ignore_settings_old = undefined;
}

attach_player_current_weapon_to_anim_tag(anim_tag) {
  weapon = level.player GetCurrentWeapon();

  weapon_and_attachment_models_array = GetWeaponAndAttachmentModels(weapon);

  weapon_viewmodel = weapon_and_attachment_models_array[0]["weapon"];

  attachments = array_remove_index(weapon_and_attachment_models_array, 0);

  self Attach(weapon_viewmodel, anim_tag, true);

  foreach(attachment in attachments) {
    self Attach(attachment["attachment"], attachment["attachTag"]);
  }

  self HideWeaponTags(weapon);
}

playerAllowAlternateMelee(enable, type) {
  self _playerAllow("altmelee", enable, type, ::_allowAlternateMelee, false);
}

_allowAlternateMelee(allow) {
  if(allow) {
    self EnableAlternateMelee();
  } else {
    self DisableAlternateMelee();
  }
}

playerAllowWeaponPickup(enable, type) {
  self _playerAllow("weaponPickup", enable, type, ::_allowWeaponPickup, false);
}

_allowWeaponPickup(allow) {
  if(allow) {
    self EnableWeaponPickup();
  } else {
    self DisableWeaponPickup();
  }
}

_playerAllow(ability, enable, type, enableFunc, funcIsBuiltin) {
  if(!isDefined(self.playerDisableAbilityTypes)) {
    self.playerDisableAbilityTypes = [];
  }

  if(!isDefined(self.playerDisableAbilityTypes[ability])) {
    self.playerDisableAbilityTypes[ability] = [];
  }

  if(!isDefined(type)) {
    type = "default";
  }

  if(enable) {
    self.playerDisableAbilityTypes[ability] = array_remove(self.playerDisableAbilityTypes[ability], type);
    if(!self.playerDisableAbilityTypes[ability].size) {
      if(!isDefined(funcIsBuiltin) || funcIsBuiltin) {
        self call[[enableFunc]](true);
      } else {
        self[[enableFunc]](true);
      }
    }
  } else {
    if(!isDefined(array_find(self.playerDisableAbilityTypes[ability], type))) {
      self.playerDisableAbilityTypes[ability] = array_add(self.playerDisableAbilityTypes[ability], type);
    }

    if(!isDefined(funcIsBuiltin) || funcIsBuiltin) {
      self call[[enableFunc]](false);
    } else {
      self[[enableFunc]](false);
    }
  }
}

pretend_to_be_dead() {
  if(!IsAlive(self)) {
    return;
  }

  self.pretending_to_be_dead = true;
  self SetThreatDetection("disable");
  self DisableAimAssist();
  self.ignoreme = true;
  self.IgnoreSonicAoE = true;
}

tff_sync_setup() {
  PreCacheShader("loading_animation");
  flag_init("tff_sync_complete");
  _tff_sync_triggers();
}

tff_sync(delay) {
  if(isDefined(delay)) {
    wait(delay);
  }

  if(AreTransientsBusy()) {
    flag_clear("tff_sync_complete");

    SyncTransients();
    while(AreTransientsBusy()) {
      wait(0.05);
    }

    flag_set("tff_sync_complete");
  }
}

tff_sync_notetrack(guy, delay) {
  tff_sync(delay);
}

logBreadcrumbDataSP() {
  level.player endon("death");

  while(1) {
    savedData = GetSPCheckpointData();
    lifeId = savedData[4];
    levelTime = GetTime();

    RecordBreadCrumbDataForPlayerSP(level.player, lifeId, levelTime);
    wait 2;
  }
}