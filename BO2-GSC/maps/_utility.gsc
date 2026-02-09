/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_utility.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility_code;
#include maps\_autosave;
#include codescripts\character;
#include maps\_utility;
#include maps\_spawner;
#include animscripts\utility;
#include maps\_dds;
#include maps\_load_common;
#include maps\_endmission;
#include maps\_vehicle_aianim;
#include maps\_vehicle;
#include maps\_colors;
#include maps\_createfx;
#include maps\_skipto;
#include animscripts\anims_table;
#include animscripts\cqb;
#include animscripts\anims_table_cqb;
#include maps\ai_subclass\_subclass_elite;
#include animscripts\combat_utility;
#include animscripts\shared;
#include animscripts\init;
#include animscripts\weaponlist;
#include maps\_names;
#include maps\_friendlyfire;
#include maps\_debug;
#include maps\_anim;
#include animscripts\pain;
#include maps\_gameskill;
#include maps\_cheat;
#include maps\_callbackglobal;
#include maps\_spawn_manager;
#include animscripts\shoot_behavior;
#include maps\_destructible;

ent_flag_wait(msg) {
  self endon("death");

  while(!self.ent_flag[msg])
    self waittill(msg);
}

init_leaderboards() {
  lb_string = "LB_SP_CAMPAIGN LB_SP_ANGOLA LB_SP_MYANMAR LB_SP_AFGHANISTAN LB_SP_NICARAGUA LB_SP_PAKISTAN LB_SP_KARMA LB_SP_PANAMA LB_SP_YEMEN LB_SP_BLACKOUT LB_SP_LA LB_SP_HAITI LB_SP_WAR_SINGAPORE LB_SP_WAR_SOCOTRA LB_SP_WAR_AFGHANISTAN LB_SP_WAR_PAKISTAN LB_SP_WAR_DRONE";
  precacheleaderboards(lb_string);
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

  while(self.ent_flag[msg])
    self waittill(msg);
}

ent_flag_init(message, val) {
  if(!isDefined(self.ent_flag)) {
    self.ent_flag = [];
    self.ent_flags_lock = [];
  }

  if(!isDefined(level.first_frame))
    assert(!isDefined(self.ent_flag[message]), "Attempt to reinitialize existing flag '" + message + "' on entity.");

  if(is_true(val)) {
    self.ent_flag[message] = 1;

    self.ent_flags_lock[message] = 1;
  } else {
    self.ent_flag[message] = 0;

    self.ent_flags_lock[message] = 0;
  }
}

ent_flag_exist(message) {
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag[message]))
    return true;

  return false;
}

ent_flag_set(message) {
  assert(isDefined(self), "Attempt to set a flag on entity that is not defined");
  assert(isDefined(self.ent_flag[message]), "Attempt to set a flag before calling flag_init: '" + message + "'.");
  assert(self.ent_flag[message] == self.ent_flags_lock[message]);
  self.ent_flags_lock[message] = 1;

  self.ent_flag[message] = 1;
  self notify(message);
}

ent_flag_toggle(message) {
  if(self ent_flag(message))
    self ent_flag_clear(message);
  else
    self ent_flag_set(message);
}

ent_flag_clear(message) {
  assert(isDefined(self), "Attempt to clear a flag on entity that is not defined");
  assert(isDefined(self.ent_flag[message]), "Attempt to set a flag before calling flag_init: '" + message + "'.");
  assert(self.ent_flag[message] == self.ent_flags_lock[message]);
  self.ent_flags_lock[message] = 0;

  if(self.ent_flag[message]) {
    self.ent_flag[message] = 0;
    self notify(message);
  }
}

ent_flag(message) {
  assert(isDefined(message), "Tried to check flag but the flag was not defined.");
  assert(isDefined(self.ent_flag[message]), "Tried to check entity flag '" + message + "', but the flag was not initialized.");

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
  self.ent_flag[message] = 1;
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

flag_wait_array(a_flags) {
  for(i = 0; i < a_flags.size; i++) {
    str_flag = a_flags[i];

    if(!flag(str_flag)) {
      flag_wait(str_flag);
      i = -1;
    }
  }
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

autosave_by_name(name) {
  thread autosave_by_name_thread(name);
}

autosave_by_name_thread(name) {
  if(!isDefined(level.curautosave))
    level.curautosave = 1;

  imagename = "levelshots / autosave / autosave_" + level.script + level.curautosave;
  result = level maps\_autosave::try_auto_save(level.curautosave, imagename);

  if(isDefined(result) && result)
    level.curautosave++;
}

error(message) {
  println("^c * ERROR * ", message);
  wait 0.05;

  if(getdebugdvar("debug") != "1")
    assertmsg(message);
}

debug_message(message, origin, duration) {
  if(!isDefined(duration))
    duration = 5;

  for(time = 0; time < duration * 20; time++) {
    print3d(origin + vectorscale((0, 0, 1), 45.0), message, (0.48, 9.4, 0.76), 0.85);
    wait 0.05;
  }
}

debug_message_clear(message, origin, duration, extraendon) {
  if(isDefined(extraendon)) {
    level notify(message + extraendon);
    level endon(message + extraendon);
  } else {
    level notify(message);
    level endon(message);
  }

  if(!isDefined(duration))
    duration = 5;

  for(time = 0; time < duration * 20; time++) {
    print3d(origin + vectorscale((0, 0, 1), 45.0), message, (0.48, 9.4, 0.76), 0.85);
    wait 0.05;
  }
}

debugline(a, b, color) {
  for(i = 0; i < 600; i++) {
    line(a, b, color);
    wait 0.05;
  }
}

debugorigin() {
  self notify("Debug origin");
  self endon("Debug origin");
  self endon("death");

  for(;;) {
    forward = anglesToForward(self.angles);
    forwardfar = vectorscale(forward, 30);
    forwardclose = vectorscale(forward, 20);
    right = anglestoright(self.angles);
    left = vectorscale(right, -10);
    right = vectorscale(right, 10);
    line(self.origin, self.origin + forwardfar, (0.9, 0.7, 0.6), 0.9);
    line(self.origin + forwardfar, self.origin + forwardclose + right, (0.9, 0.7, 0.6), 0.9);
    line(self.origin + forwardfar, self.origin + forwardclose + left, (0.9, 0.7, 0.6), 0.9);
    wait 0.05;
  }
}

precache(model) {
  ent = spawn("script_model", (0, 0, 0));
  ent.origin = get_players()[0] getorigin();
  ent setModel(model);
  ent delete();
}

closerfunc(dist1, dist2) {
  return dist1 >= dist2;
}

fartherfunc(dist1, dist2) {
  return dist1 <= dist2;
}

getclosest(org, array, dist) {
  return comparesizes(org, array, dist, ::closerfunc);
}

getfarthest(org, array, dist) {
  return comparesizes(org, array, dist, ::fartherfunc);
}

comparesizesfx(org, array, dist, comparefunc) {
  if(!array.size)
    return undefined;

  if(isDefined(dist)) {
    struct = undefined;
    keys = getarraykeys(array);

    for(i = 0; i < keys.size; i++) {
      newdist = distance(array[keys[i]].v["origin"], org);

      if([[comparefunc]](newdist, dist)) {
        continue;
      }
      dist = newdist;
      struct = array[keys[i]];
    }

    return struct;
  }

  keys = getarraykeys(array);
  struct = array[keys[0]];
  dist = distance(struct.v["origin"], org);

  for(i = 1; i < keys.size; i++) {
    newdist = distance(array[keys[i]].v["origin"], org);

    if([[comparefunc]](newdist, dist)) {
      continue;
    }
    dist = newdist;
    struct = array[keys[i]];
  }

  return struct;
}

comparesizes(org, array, dist, comparefunc) {
  if(!array.size)
    return undefined;

  if(isDefined(dist)) {
    distsqr = dist * dist;
    ent = undefined;
    keys = getarraykeys(array);

    for(i = 0; i < keys.size; i++) {
      newdistsqr = distancesquared(array[keys[i]].origin, org);

      if([[comparefunc]](newdistsqr, distsqr)) {
        continue;
      }
      distsqr = newdistsqr;
      ent = array[keys[i]];
    }

    return ent;
  }

  keys = getarraykeys(array);
  ent = array[keys[0]];
  distsqr = distancesquared(ent.origin, org);

  for(i = 1; i < keys.size; i++) {
    newdistsqr = distancesquared(array[keys[i]].origin, org);

    if([[comparefunc]](newdistsqr, distsqr)) {
      continue;
    }
    distsqr = newdistsqr;
    ent = array[keys[i]];
  }

  return ent;
}

get_closest_point(origin, points, maxdist) {
  assert(points.size);

  if(isDefined(maxdist))
    maxdist = maxdist * maxdist;

  closestpoint = points[0];
  distsq = distancesquared(origin, closestpoint);

  for(index = 0; index < points.size; index++) {
    testdistsq = distancesquared(origin, points[index]);

    if(testdistsq >= distsq) {
      continue;
    }
    distsq = testdistsq;
    closestpoint = points[index];
  }

  if(!isDefined(maxdist) || distsq <= maxdist)
    return closestpoint;

  return undefined;
}

get_within_range(org, array, dist) {
  distsq = dist * dist;
  guys = [];

  for(i = 0; i < array.size; i++) {
    if(distancesquared(array[i].origin, org) <= distsq)
      guys[guys.size] = array[i];
  }

  return guys;
}

get_outside_range(org, array, dist) {
  distsq = dist * dist;
  guys = [];

  for(i = 0; i < array.size; i++) {
    if(distancesquared(array[i].origin, org) > distsq)
      guys[guys.size] = array[i];
  }

  return guys;
}

get_closest_living(org, array, dist) {
  if(!isDefined(dist))
    dist = 9999999;

  distsq = dist * dist;

  if(array.size < 1) {
    return;
  }
  ent = undefined;

  for(i = 0; i < array.size; i++) {
    if(!isalive(array[i])) {
      continue;
    }
    newdistsq = distancesquared(array[i].origin, org);

    if(newdistsq >= distsq) {
      continue;
    }
    distsq = newdistsq;
    ent = array[i];
  }

  return ent;
}

get_highest_dot(start, end, array) {
  if(!array.size) {
    return;
  }
  ent = undefined;
  angles = vectortoangles(end - start);
  dotforward = anglesToForward(angles);
  dot = -1;

  for(i = 0; i < array.size; i++) {
    angles = vectortoangles(array[i].origin - start);
    forward = anglesToForward(angles);
    newdot = vectordot(dotforward, forward);

    if(newdot < dot) {
      continue;
    }
    dot = newdot;
    ent = array[i];
  }

  return ent;
}

get_closest_index(org, array, dist) {
  if(!isDefined(dist))
    dist = 9999999;

  distsq = dist * dist;

  if(array.size < 1) {
    return;
  }
  index = undefined;

  for(i = 0; i < array.size; i++) {
    newdistsq = distancesquared(array[i].origin, org);

    if(newdistsq >= distsq) {
      continue;
    }
    distsq = newdistsq;
    index = i;
  }

  return index;
}

get_farthest(org, array) {
  if(array.size < 1) {
    return;
  }
  distsq = distancesquared(array[0].origin, org);
  ent = array[0];

  for(i = 1; i < array.size; i++) {
    newdistsq = distancesquared(array[i].origin, org);

    if(newdistsq <= distsq) {
      continue;
    }
    distsq = newdistsq;
    ent = array[i];
  }

  return ent;
}

get_closest_ai(org, team) {
  if(isDefined(team))
    ents = getaiarray(team);
  else
    ents = getaiarray();

  if(ents.size == 0)
    return undefined;

  return getclosest(org, ents);
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
    if(!isDefined(array[i])) {
      continue;
    }
    if(isinarray(excluders, array[i])) {
      continue;
    }
    if(isvec(array[i]))
      length = distancesquared(org, array[i]);
    else
      length = distancesquared(org, array[i].origin);

    if(isDefined(maxdists2rd) && maxdists2rd < length) {
      continue;
    }
    dist[dist.size] = length;
    index[index.size] = i;
  }

  for(;;) {
    change = 0;

    for(i = 0; i < dist.size - 1; i++) {
      if(dist[i] <= dist[i + 1]) {
        continue;
      }
      change = 1;
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

  newarray = [];

  if(max > dist.size)
    max = dist.size;

  for(i = 0; i < max; i++)
    newarray[i] = array[index[i]];

  return newarray;
}

get_array_of_farthest(org, array, excluders, max) {
  sorted_array = get_array_of_closest(org, array, excluders);

  if(isDefined(max)) {
    temp_array = [];

    for(i = 0; i < sorted_array.size; i++)
      temp_array[temp_array.size] = sorted_array[sorted_array.size - i];

    sorted_array = temp_array;
  }

  sorted_array = array_reverse(sorted_array);
  return sorted_array;
}

stop_magic_bullet_shield(ent) {
  if(!isDefined(ent))
    ent = self;

  if(isai(ent))
    ent bloodimpact("normal");

  ent.attackeraccuracy = 1;
  ent notify("stop_magic_bullet_shield");
  ent.magic_bullet_shield = undefined;
  ent._mbs = undefined;
}

magic_bullet_shield(ent) {
  if(!isDefined(ent))
    ent = self;

  if(!(isDefined(ent.magic_bullet_shield) && ent.magic_bullet_shield)) {
    if(isai(ent) || isPlayer(ent)) {
      ent.magic_bullet_shield = 1;

      if(!isPlayer(ent))
        level thread debug_magic_bullet_shield_death(ent);

      if(!isDefined(ent._mbs))
        ent._mbs = spawnStruct();

      if(isai(ent)) {
        assert(isalive(ent), "Tried to do magic_bullet_shield on a dead or undefined guy.");
        ent._mbs.last_pain_time = 0;
        ent._mbs.ignore_time = 2;
        ent._mbs.turret_ignore_time = 5;
        ent bloodimpact("hero");
      }

      ent.attackeraccuracy = 0.1;
    } else if(isDefined(ent.classname) && ent.classname == "script_vehicle")
      assertmsg("Use veh_magic_bullet_shield for vehicles.");
    else
      assertmsg("magic_bullet_shield does not support entity of classname '" + ent.classname + "'.");
  }
}

debug_magic_bullet_shield_death(guy) {
  targetname = "none";

  if(isDefined(guy.targetname))
    targetname = guy.targetname;

  guy endon("stop_magic_bullet_shield");
  guy waittill("death");
  assert(!isDefined(guy), "Guy died with magic bullet shield on with targetname: " + targetname);
}

disable_long_death() {
  assert(isalive(self), "Tried to disable long death on a non living thing");
  self.a.disablelongdeath = 1;
}

enable_long_death() {
  assert(isalive(self), "Tried to enable long death on a non living thing");
  self.a.disablelongdeath = 0;
}

get_ignoreme() {
  return self.ignoreme;
}

set_ignoreme(val) {
  assert(issentient(self), "Non ai tried to set ignoreme");
  self.ignoreme = val;
}

set_ignoreall(val) {
  assert(issentient(self), "Non ai tried to set ignoraell");
  self.ignoreall = val;
}

get_pacifist() {
  return self.pacifist;
}

set_pacifist(val) {
  assert(issentient(self), "Non ai tried to set pacifist");
  self.pacifist = val;
}

turret_ignore_me_timer(time) {
  self endon("death");
  self endon("pain");
  self.turretinvulnerability = 1;
  wait(time);
  self.turretinvulnerability = 0;
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
  self.model radiusdamage(origin, radius, damage, damage / 3);
}

exploder(num) {
  [[level.exploderfunction]](num);
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
  if(!isDefined(level._client_exploders[num]))
    level._client_exploders[num] = 1;

  if(!isDefined(level._client_exploder_ids[num]))
    level._client_exploder_ids[num] = 1;

  activateclientexploder(level._exploder_ids[num]);
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
  deactivateclientexploder(level._exploder_ids[num]);
}

activate_exploder(num) {
  num = int(num);
  level notify("exploder" + num);

  if(level.createfx_enabled) {
    for(i = 0; i < level.createfxent.size; i++) {
      ent = level.createfxent[i];

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
      if(isDefined(ent.v["exploder_server"]))
        client_send = 0;

      ent activate_individual_exploder(num);
    }

    return;
  }

  client_send = 1;

  if(isDefined(level.createfxexploders[num])) {
    for(i = 0; i < level.createfxexploders[num].size; i++) {
      if(client_send && isDefined(level.createfxexploders[num][i].v["exploder_server"]))
        client_send = 0;

      level.createfxexploders[num][i] activate_individual_exploder(num);
    }
  }

  if(level.clientscripts) {
    if(!level.createfx_enabled && client_send == 1)
      activate_exploder_on_clients(num);
  }
}

stop_exploder(num) {
  num = int(num);

  if(level.createfx_enabled) {
    for(i = 0; i < level.createfxent.size; i++) {
      ent = level.createfxent[i];

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

    return;
  }

  if(level.clientscripts) {
    if(!level.createfx_enabled)
      delete_exploder_on_clients(num);
  }

  if(isDefined(level.createfxexploders[num])) {
    for(i = 0; i < level.createfxexploders[num].size; i++) {
      if(!isDefined(level.createfxexploders[num][i].looper)) {
        continue;
      }
      level.createfxexploders[num][i].looper delete();
    }
  }
}

delete_exploder(n_num, n_high_num) {
  n_num = int(n_num);

  if(isDefined(n_high_num)) {
    n_high_num = int(n_high_num);

    if(n_high_num < n_num)
      assertmsg("delete_exploder: The high number parameter needs to be larger than the first number");
  } else
    n_high_num = n_num;

  for(n_exploder = n_num; n_exploder <= n_high_num; n_exploder++) {
    if(isDefined(level.createfxexploders[n_exploder])) {
      if(level.clientscripts)
        delete_exploder_on_clients(n_exploder);

      for(i = 0; i < level.createfxexploders[n_exploder].size; i++) {
        if(isDefined(level.createfxexploders[n_exploder][i].looper))
          level.createfxexploders[n_exploder][i].looper delete();

        level.createfxexploders[n_exploder][i].v = [];
        level.createfxexploders[n_exploder][i] = undefined;
      }

      level.createfxexploders[n_exploder] = undefined;
      level._exploder_ids[n_exploder] = undefined;
    }
  }
}

activate_individual_exploder(num) {
  if(level.createfx_enabled || !level.clientscripts || !isDefined(level._exploder_ids[num]) || isDefined(self.v["exploder_server"])) {
    println("Exploder " + num + " created on server.");

    if(isDefined(self.v["firefx"]))
      self thread fire_effect();

    if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX")
      self thread cannon_effect();
    else if(isDefined(self.v["soundalias"]))
      self thread sound_effect();

    if(isDefined(self.v["earthquake"]))
      self thread exploder_earthquake();

    if(isDefined(self.v["rumble"]))
      self thread exploder_rumble();
  }

  if(isDefined(self.v["trailfx"]))
    self thread trail_effect();

  if(isDefined(self.v["damage"]))
    self thread exploder_damage();

  if(self.v["exploder_type"] == "exploder")
    self thread brush_show();
  else if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible")
    self thread brush_throw();
  else
    self thread brush_delete();
}

does_exploder_exist(n_exploder) {
  if(isDefined(level.createfxexploders) && isDefined(level.createfxexploders[n_exploder]))
    return true;

  return false;
}

loop_sound_delete(ender, ent) {
  ent endon("death");
  self waittill(ender);
  ent delete();
}

loop_fx_sound(alias, origin, ender, timeout) {
  org = spawn("script_origin", (0, 0, 0));

  if(isDefined(ender)) {
    thread loop_sound_delete(ender, org);
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

  if(isDefined(self.v["delay"]))
    wait(self.v["delay"]);
  else
    wait 0.05;

  if(!isDefined(self.model)) {
    return;
  }
  assert(isDefined(self.model));

  if(self.model has_spawnflag(1))
    self.model connectpaths();

  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX")
    self.v["exploder"] = undefined;

  waittillframeend;
  self.model delete();
}

brush_show() {
  if(isDefined(self.v["delay"]))
    wait(self.v["delay"]);

  assert(isDefined(self.model));
  self.model show();
  self.model solid();

  if(self.model has_spawnflag(1)) {
    if(!isDefined(self.model.disconnect_paths))
      self.model connectpaths();
    else
      self.model disconnectpaths();
  }
}

brush_throw() {
  if(isDefined(self.v["delay"]))
    wait(self.v["delay"]);

  ent = undefined;

  if(isDefined(self.v["target"]))
    ent = getent(self.v["target"], "targetname");

  if(!isDefined(ent)) {
    ent = getstruct(self.v["target"], "targetname");

    if(!isDefined(ent)) {
      self.model delete();
      return;
    }
  }

  self.model show();
  startorg = self.v["origin"];
  startang = self.v["angles"];
  org = ent.origin;
  temp_vec = org - self.v["origin"];
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
      throw_vec = vectorscale(target.origin - ent.origin, self.v["physics"]);
    }

    self.model physicslaunch(contact_point, throw_vec);
    return;
  } else {
    self.model rotatevelocity((x, y, z), 12);
    self.model movegravity((x, y, z), 12);
  }

  self.v["exploder"] = undefined;
  wait 6;
  self.model delete();
}

shock_onpain() {
  self endon("death");
  self endon("disconnect");

  if(getDvar(#"blurpain") == "")
    setDvar("blurpain", "on");

  while(true) {
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
    if(mod == "MOD_PROJECTILE")
      continue;
    else if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH")
      self shock_onexplosion(damage);
    else if(getDvar(#"blurpain") == "on")
      self shellshock("pain", 0.5);
  }
}

shock_onexplosion(damage) {
  time = 0;
  multiplier = self.maxhealth / 100;
  scaled_damage = damage * multiplier;

  if(scaled_damage >= 90)
    time = 4;
  else if(scaled_damage >= 50)
    time = 3;
  else if(scaled_damage >= 25)
    time = 2;
  else if(scaled_damage > 10)
    time = 1;

  if(time)
    self shellshock("explosion", time);
}

shock_ondeath() {
  self waittill("death");

  if(isDefined(level.shock_ondeath) && !level.shock_ondeath) {
    return;
  }
  if(isDefined(self.shock_ondeath) && !self.shock_ondeath) {
    return;
  }
  if(isDefined(self.specialdeath)) {
    return;
  }
  if(getDvar(#"_id_DD991B79") == "16")
    return;
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

    ent delete();
  }
}

is_dead_sentient() {
  if(issentient(self) && !isalive(self))
    return true;
  else
    return false;
}

is_alive_sentient() {
  if(isalive(self) && issentient(self))
    return true;
  else
    return false;
}

is_alive(ent) {
  return !is_corpse(ent) && isalive(ent);
}

is_corpse(veh) {
  if(isDefined(veh)) {
    if(is_true(veh.isacorpse))
      return true;
    else if(isDefined(veh.classname) && veh.classname == "script_vehicle_corpse")
      return true;
  }

  return false;
}

play_sound_on_tag(alias, tag, ends_on_death) {
  if(is_dead_sentient()) {
    return;
  }
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");
  thread delete_on_death_wait_sound(org, "sounddone");

  if(isDefined(tag))
    org linkto(self, tag, (0, 0, 0), (0, 0, 0));
  else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto(self);
  }

  org playSound(alias, "sounddone");

  if(isDefined(ends_on_death)) {
    assert(ends_on_death, "ends_on_death must be true or undefined");
    wait_for_sounddone_or_death(org);

    if(is_dead_sentient())
      org stopsounds();

    wait 0.05;
  } else
    org waittill("sounddone");

  org delete();
}

play_sound_on_tag_endon_death(alias, tag) {
  play_sound_on_tag(alias, tag, 1);
}

play_sound_on_entity(alias) {
  play_sound_on_tag(alias);
}

play_loop_sound_on_tag(alias, tag, bstopsoundondeath) {
  org = spawn("script_origin", (0, 0, 0));
  org endon("death");

  if(!isDefined(bstopsoundondeath))
    bstopsoundondeath = 1;

  if(bstopsoundondeath)
    thread delete_on_death(org);

  if(isDefined(tag))
    org linkto(self, tag, (0, 0, 0), (0, 0, 0));
  else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto(self);
  }

  org playLoopSound(alias);
  self waittill("stop sound" + alias);
  org stoploopsound(alias);
  org delete();
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
    org linkto(self);
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto(self);
  }

  org playLoopSound(alias);
  self waittill("stop sound" + alias);
  org stoploopsound(0.1);
  org delete();
}

play_sound_in_space(alias, origin, master) {
  org = spawn("script_origin", (0, 0, 1));

  if(!isDefined(origin))
    origin = self.origin;

  org.origin = origin;

  if(isDefined(master) && master)
    org playsoundasmaster(alias, "sounddone");
  else
    org playSound(alias, "sounddone");

  org waittill("sounddone");

  if(isDefined(org))
    org delete();
}

spawn_failed(spawn) {
  if(isalive(spawn)) {
    if(!isDefined(spawn.finished_spawning))
      spawn waittill("finished spawning");

    waittillframeend;

    if(isalive(spawn))
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
  println("Size is ", data["attach"].size);

  spawn codescripts\character::new();
  spawn codescripts\character::load(data);
}

assign_animtree(animname, animtree_override) {
  animtree = animtree_override;

  if(!isDefined(animtree)) {
    if(isDefined(animname))
      self.animname = animname;

    assert(isDefined(level.scr_animtree[self.animname]), "There is no level.scr_animtree for animname " + self.animname);
    animtree = level.scr_animtree[self.animname];
  }

  self useanimtree(animtree);
}

assign_model(str_animname) {
  if(!isDefined(str_animname))
    str_animname = self.animname;

  assert(isDefined(level.scr_model[str_animname]), "There is no level.scr_model for animname " + str_animname);
  self setModel(level.scr_model[str_animname]);
}

spawn_anim_model(str_animname, origin, angles, is_simple_prop) {
  if(!isDefined(origin))
    origin = (0, 0, 0);

  if(!isDefined(angles))
    angles = (0, 0, 0);

  model = spawn("script_model", origin);
  model.angles = angles;
  model assign_model(str_animname);
  model init_anim_model(str_animname, is_simple_prop);
  return model;
}

init_anim_model(animname, is_simple_prop, animtree_override) {
  if(!isDefined(is_simple_prop))
    is_simple_prop = 0;

  if(!isDefined(animname))
    animname = self.animname;

  assert(isDefined(animname), "Trying to init anim model with no animname.");
  self.animname = animname;

  if(is_simple_prop) {
    if(!isDefined(self.anim_link)) {
      self.anim_link = spawn("script_model", self.origin);
      self.anim_link setModel("tag_origin_animate");
      level thread delete_anim_link_on_death(self, self.anim_link);
    }

    self.anim_link.animname = animname;
    self.anim_link assign_animtree(animname, animtree_override);
    self unlink();
    self.anim_link.angles = self.angles;
    self.anim_link.origin = self.origin;
    self linkto(self.anim_link, "origin_animate_jnt");
  } else
    self assign_animtree(self.animname, animtree_override);
}

delete_anim_link_on_death(ent, anim_link) {
  anim_link endon("death");
  ent waittill("death");
  anim_link delete();
}

triggeroff() {
  if(!isDefined(self.realorigin))
    self.realorigin = self.origin;

  if(self.origin == self.realorigin)
    self.origin = self.origin + vectorscale((0, 0, -1), 10000.0);
}

triggeron() {
  if(isDefined(self.realorigin))
    self.origin = self.realorigin;
}

set_flag_on_notify(notifystr, strflag) {
  if(notifystr != "death")
    self endon("death");

  if(!level.flag[strflag]) {
    self waittill(notifystr);
    flag_set(strflag);
  }
}

set_flag_on_trigger(etrigger, strflag) {
  if(!level.flag[strflag]) {
    etrigger waittill("trigger", eother);
    flag_set(strflag);
    return eother;
  }
}

set_flag_on_targetname_trigger(msg) {
  assert(isDefined(level.flag[msg]));

  if(flag(msg)) {
    return;
  }
  trigger = getent(msg, "targetname");
  trigger waittill("trigger");
  flag_set(msg);
}

waittill_dead(guys, num, timeoutlength) {
  allalive = 1;

  for(i = 0; i < guys.size; i++) {
    if(isalive(guys[i])) {
      continue;
    }
    allalive = 0;
    break;
  }

  assert(allalive, "Waittill_Dead was called with dead or removed AI in the array, meaning it will never pass.");

  if(!allalive) {
    newarray = [];

    for(i = 0; i < guys.size; i++) {
      if(isalive(guys[i]))
        newarray[newarray.size] = guys[i];
    }

    guys = newarray;
  }

  ent = spawnStruct();

  if(isDefined(timeoutlength)) {
    ent endon("thread_timed_out");
    ent thread waittill_dead_timeout(timeoutlength);
  }

  ent.count = guys.size;

  if(isDefined(num) && num < ent.count)
    ent.count = num;

  array_thread(guys, ::waittill_dead_thread, ent);

  while(ent.count > 0)
    ent waittill("waittill_dead guy died");
}

waittill_dead_or_dying(guys, num, timeoutlength) {
  newarray = [];

  for(i = 0; i < guys.size; i++) {
    if(isalive(guys[i]) && !guys[i].ignoreforfixednodesafecheck)
      newarray[newarray.size] = guys[i];
  }

  guys = newarray;
  ent = spawnStruct();

  if(isDefined(timeoutlength)) {
    ent endon("thread_timed_out");
    ent thread waittill_dead_timeout(timeoutlength);
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

waittill_dead_timeout(timeoutlength) {
  wait(timeoutlength);
  self notify("thread_timed_out");
}

set_ai_group_cleared_count(aigroup, count) {
  maps\_spawner::aigroup_init(aigroup);
  level._ai_group[aigroup].cleared_count = count;
}

waittill_ai_group_cleared(aigroup) {
  assert(isDefined(level._ai_group[aigroup]), "The aigroup " + aigroup + " does not exist");
  flag_wait(aigroup + "_cleared");
}

waittill_ai_group_count(aigroup, count) {
  while(get_ai_group_spawner_count(aigroup) + level._ai_group[aigroup].aicount > count)
    level._ai_group[aigroup] waittill("update_aigroup");
}

waittill_ai_group_ai_count(aigroup, count) {
  while(level._ai_group[aigroup].aicount > count)
    level._ai_group[aigroup] waittill("update_aigroup");
}

waittill_ai_group_spawner_count(aigroup, count) {
  while(get_ai_group_spawner_count(aigroup) > count)
    level._ai_group[aigroup] waittill("update_aigroup");
}

waittill_ai_group_amount_killed(aigroup, amount_killed) {
  while(level._ai_group[aigroup].killed_count < amount_killed)
    level._ai_group[aigroup] waittill("update_aigroup");
}

get_ai_group_count(aigroup) {
  return get_ai_group_spawner_count(aigroup) + level._ai_group[aigroup].aicount;
}

get_ai_group_sentient_count(aigroup) {
  return level._ai_group[aigroup].aicount;
}

get_ai_group_spawner_count(aigroup) {
  n_count = 0;

  foreach(sp in level._ai_group[aigroup].spawners) {
    if(isDefined(sp))
      n_count = n_count + sp.count;
  }

  return n_count;
}

get_ai_group_ai(aigroup) {
  aiset = [];

  for(index = 0; index < level._ai_group[aigroup].ai.size; index++) {
    if(!isalive(level._ai_group[aigroup].ai[index])) {
      continue;
    }
    aiset[aiset.size] = level._ai_group[aigroup].ai[index];
  }

  return aiset;
}

get_ai(name, type) {
  array = get_ai_array(name, type);

  if(array.size > 1) {
    assertmsg("get_ai used for more than one living ai of type " + type + " called " + name + ".");
    return undefined;
  }

  return array[0];
}

get_ai_array(name, type) {
  if(!isDefined(type))
    type = "script_noteworthy";

  ai = getaiarray();
  array = [];

  for(i = 0; i < ai.size; i++) {
    switch (type) {
      case "targetname":
        if(isDefined(ai[i].targetname) && ai[i].targetname == name)
          array[array.size] = ai[i];

        break;
      case "script_noteworthy":
        if(isDefined(ai[i].script_noteworthy) && ai[i].script_noteworthy == name)
          array[array.size] = ai[i];

        break;
      case "classname":
        if(isDefined(ai[i].classname) && ai[i].classname == name)
          array[array.size] = ai[i];

        break;
      case "script_string":
        if(isDefined(ai[i].script_string) && ai[i].script_string == name)
          array[array.size] = ai[i];

        break;
    }
  }

  return array;
}

set_environment(env) {
  animscripts\utility::setenv(env);
}

waittill_either(msg1, msg2) {
  self endon(msg1);
  self waittill(msg2);
}

flat_angle(angle) {
  rangle = (0, angle[1], 0);
  return rangle;
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
  timer = gettime() + timer * 1000;

  while(gettime() < timer) {
    line(org1, org2, (r, g, b), 1);
    recordline(org1, org2, (1, 1, 1), "Script");
    wait 0.05;
  }
}

draw_point(org, scale, color, timer) {
  timer = gettime() + timer * 1000;
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

  while(gettime() < timer) {
    line(v1_1, v1_2, color, 1);
    line(v2_1, v2_2, color, 1);
    line(v3_1, v3_2, color, 1);
    wait 0.05;
  }
}

draw_line_to_ent_for_time(org1, ent, r, g, b, timer) {
  timer = gettime() + timer * 1000;

  while(gettime() < timer) {
    line(org1, ent.origin, (r, g, b), 1);
    wait 0.05;
  }
}

draw_line_from_ent_for_time(ent, org, r, g, b, timer) {
  draw_line_to_ent_for_time(org, ent, r, g, b, timer);
}

draw_line_from_ent_to_ent_for_time(ent1, ent2, r, g, b, timer) {
  ent1 endon("death");
  ent2 endon("death");
  timer = gettime() + timer * 1000;

  while(gettime() < timer) {
    line(ent1.origin, ent2.origin, (r, g, b), 1);
    wait 0.05;
  }
}

draw_line_from_ent_to_ent_until_notify(ent1, ent2, r, g, b, notifyent, notifystring) {
  assert(isDefined(notifyent));
  assert(isDefined(notifystring));
  ent1 endon("death");
  ent2 endon("death");
  notifyent endon(notifystring);

  while(true) {
    line(ent1.origin, ent2.origin, (r, g, b), 0.05);
    wait 0.05;
  }
}

draw_line_until_notify(org1, org2, r, g, b, notifyent, notifystring) {
  assert(isDefined(notifyent));
  assert(isDefined(notifystring));
  notifyent endon(notifystring);

  while(true)
    draw_line_for_time(org1, org2, r, g, b, 0.05);
}

draw_arrow_time(start, end, color, duration) {
  level endon("newpath");
  pts = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  dist = distance(start, end);
  arrow = [];
  arrow[0] = start;
  arrow[1] = start + vectorscale(right, dist * 0.1) + vectorscale(forward, dist * -0.1);
  arrow[2] = end;
  arrow[3] = start + vectorscale(right, dist * (-1 * 0.1)) + vectorscale(forward, dist * -0.1);
  arrow[4] = start;
  arrow[5] = start + vectorscale(up, dist * 0.1) + vectorscale(forward, dist * -0.1);
  arrow[6] = end;
  arrow[7] = start + vectorscale(up, dist * (-1 * 0.1)) + vectorscale(forward, dist * -0.1);
  arrow[8] = start;
  r = color[0];
  g = color[1];
  b = color[2];
  plot_points(arrow, r, g, b, duration);
}

draw_arrow(start, end, color) {
  level endon("newpath");
  pts = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  dist = distance(start, end);
  arrow = [];
  arrow[0] = start;
  arrow[1] = start + vectorscale(right, dist * 0.05) + vectorscale(forward, dist * -0.2);
  arrow[2] = end;
  arrow[3] = start + vectorscale(right, dist * (-1 * 0.05)) + vectorscale(forward, dist * -0.2);

  for(p = 0; p < 4; p++) {
    nextpoint = p + 1;

    if(nextpoint >= 4)
      nextpoint = 0;

    line(arrow[p], arrow[nextpoint], color, 1.0);
  }
}

battlechatter_off(team) {
  maps\_dds::dds_disable(team);
}

battlechatter_on(team) {
  maps\_dds::dds_enable(team);
}

dds_set_player_character_name(hero_name) {
  if(!isPlayer(self)) {
    println("dds 'dds_set_player_character_name' function was not called on a player. No changes made.");

    return;
  }

  switch (hero_name) {
    case "hudson":
    case "mason":
    case "reznov":
      level.dds.player_character_name = getsubstr(hero_name, 0, 3);

      println("dds setting player name to '" + level.dds.player_character_name + "'");

      break;
    default:

      println("dds: '" + hero_name + "' not a valid player name; setting to 'mason' (mas)");

      level.dds.player_character_name = "mas";
      break;
  }

  self.dds_characterid = level.dds.player_character_name;
}

dds_exclude_this_ai() {
  if(isai(self) && isalive(self))
    self.dds_characterid = undefined;
  else {
    println("Tried to mark an entity for DDS removal that was not an AI or not alive.");
  }
}

get_links() {
  return strtok(self.script_linkto, " ");
}

get_linked_ents() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = get_links();

    for(i = 0; i < linknames.size; i++) {
      ent = getent(linknames[i], "script_linkname");

      if(isDefined(ent))
        array[array.size] = ent;
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

      if(isDefined(ent))
        array[array.size] = ent;
    }
  }

  return array;
}

get_last_ent_in_chain(sentitytype) {
  epathpoint = self;

  while(isDefined(epathpoint.target)) {
    wait 0.05;

    if(isDefined(epathpoint.target)) {
      switch (sentitytype) {
        case "vehiclenode":
          epathpoint = getvehiclenode(epathpoint.target, "targetname");
          break;
        case "pathnode":
          epathpoint = getnode(epathpoint.target, "targetname");
          break;
        case "ent":
          epathpoint = getent(epathpoint.target, "targetname");
          break;
        default:
          assertmsg("sEntityType needs to be 'vehiclenode', 'pathnode' or 'ent'");
      }
    } else
      break;
  }

  epathend = epathpoint;
  return epathend;
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
  self.set_forcedgoal = 1;
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

array_removedead(array) {
  newarray = [];

  if(!isDefined(array))
    return undefined;

  for(i = 0; i < array.size; i++) {
    if(!isalive(array[i]) || isDefined(array[i].isacorpse) && array[i].isacorpse) {
      continue;
    }
    newarray[newarray.size] = array[i];
  }

  return newarray;
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

missionfailedwrapper(fail_hint, shader, iwidth, iheight, fdelay, x, y, b_count_as_death) {
  if(!isDefined(b_count_as_death))
    b_count_as_death = 1;

  if(level.missionfailed) {
    return;
  }
  if(isDefined(level.nextmission)) {
    return;
  }
  if(getDvar(#"_id_C7029A24") == "1") {
    return;
  }
  screen_message_delete();

  if(isDefined(fail_hint))
    setDvar("ui_deadquote", fail_hint);

  if(isDefined(shader))
    get_players()[0] thread maps\_load_common::special_death_indicator_hudelement(shader, iwidth, iheight, fdelay, x, y);

  level.missionfailed = 1;
  flag_set("missionfailed");

  if(b_count_as_death)
    get_players()[0] inc_general_stat("deaths");

  missionfailed();
}

missionfailedwrapper_nodeath(fail_hint, shader, iwidth, iheight, fdelay, x, y) {
  missionfailedwrapper(fail_hint, shader, iwidth, iheight, fdelay, x, y, 0);
}

nextmission() {
  maps\_endmission::_nextmission();
}

script_flag_wait() {
  if(isDefined(self.script_flag_wait)) {
    self flag_wait(self.script_flag_wait);
    return true;
  }

  return false;
}

script_delay() {
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
    return true;
  } else if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    wait(randomfloatrange(self.script_delay_min, self.script_delay_max));
    return true;
  }

  return false;
}

script_wait(called_from_spawner) {
  if(!isDefined(called_from_spawner))
    called_from_spawner = 0;

  coop_scalar = 1;

  if(called_from_spawner) {
    players = get_players();

    if(players.size == 2)
      coop_scalar = 0.7;
    else if(players.size == 3)
      coop_scalar = 0.4;
    else if(players.size == 4)
      coop_scalar = 0.1;
  }

  starttime = gettime();

  if(isDefined(self.script_wait)) {
    wait(self.script_wait * coop_scalar);

    if(isDefined(self.script_wait_add))
      self.script_wait = self.script_wait + self.script_wait_add;
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    wait(randomfloatrange(self.script_wait_min, self.script_wait_max) * coop_scalar);

    if(isDefined(self.script_wait_add)) {
      self.script_wait_min = self.script_wait_min + self.script_wait_add;
      self.script_wait_max = self.script_wait_max + self.script_wait_add;
    }
  }

  return gettime() - starttime;
}

enter_vehicle(vehicle, tag) {
  self maps\_vehicle_aianim::vehicle_enter(vehicle, tag);
}

guy_array_enter_vehicle(guy, vehicle) {
  maps\_vehicle_aianim::guy_array_enter(guy, vehicle);
}

run_to_vehicle_load(vehicle, bgoddriver, seat_tag) {
  self maps\_vehicle_aianim::run_to_vehicle(vehicle, bgoddriver, seat_tag);
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

      for(j = 0; j < player_array.size; j++)
        vehicleanim[i].wait_for_player[j] = player_array[j];

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
  if(!isDefined(self.viewlockedentity))
    return false;
  else if(self.viewlockedentity == vehicle)
    return true;

  if(!isDefined(self.groundentity))
    return false;
  else if(self.groundentity == vehicle)
    return true;

  return false;
}

get_force_color_guys(team, color) {
  ai = getaiarray(team);
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
  ai = getaiarray("allies");
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

enable_ai_color() {
  if(isDefined(self.script_forcecolor)) {
    return;
  }
  if(!isDefined(self.old_forcecolor)) {
    return;
  }
  set_force_color(self.old_forcecolor);
  self.old_forcecolor = undefined;
}

disable_ai_color(stop_being_careful) {
  if(isDefined(self.new_force_color_being_set)) {
    self endon("death");
    self waittill("done_setting_new_color");
  }

  if(isDefined(stop_being_careful) && stop_being_careful) {
    self notify("stop_going_to_node");
    self notify("stop_being_careful");
  }

  self clearfixednodesafevolume();

  if(!isDefined(self.script_forcecolor)) {
    return;
  }
  assert(!isDefined(self.old_forcecolor), "Tried to disable forcecolor on a guy that somehow had a old_forcecolor already. Investigate!!!");
  self.old_forcecolor = self.script_forcecolor;
  arrayremovevalue(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);
  maps\_colors::left_color_node();
  self.script_forcecolor = undefined;
  self.currentcolorcode = undefined;

  update_debug_friendlycolor(self.ai_number);
}

clear_force_color() {
  disable_ai_color();
}

check_force_color(_color) {
  color = level.colorchecklist[tolower(_color)];

  if(isDefined(self.script_forcecolor) && color == self.script_forcecolor)
    return true;
  else
    return false;
}

get_force_color() {
  color = self.script_forcecolor;
  return color;
}

shortencolor(color) {
  assert(isDefined(level.colorchecklist[tolower(color)]), "Tried to set force color on an undefined color: " + color);
  return level.colorchecklist[tolower(color)];
}

set_force_color(_color) {
  color = shortencolor(_color);
  assert(maps\_colors::colorislegit(color), "Tried to set force color on an undefined color: " + color);

  if(!isai(self)) {
    set_force_color_spawner(color);
    return;
  }

  assert(isalive(self), "Tried to set force color on a dead / undefined entity.");

  if(self.team == "allies") {
    self.fixednode = 1;
    self.fixednodesaferadius = 64;
    self.pathenemyfightdist = 0;
    self.pathenemylookahead = 0;
  }

  self.script_color_axis = undefined;
  self.script_color_allies = undefined;
  self.old_forcecolor = undefined;

  if(isDefined(self.script_forcecolor))
    arrayremovevalue(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);

  self.script_forcecolor = color;
  level.arrays_of_colorforced_ai[self.team][self.script_forcecolor][level.arrays_of_colorforced_ai[self.team][self.script_forcecolor].size] = self;
  thread new_color_being_set(color);
}

set_force_color_spawner(color) {
  self.script_forcecolor = color;
  self.old_forcecolor = undefined;
}

disable_replace_on_death() {
  self.replace_on_death = undefined;
  self notify("_disable_reinforcement");
}

createloopeffect(fxid) {
  ent = maps\_createfx::createeffect("loopfx", fxid);
  ent.v["delay"] = 0.5;
  return ent;
}

createoneshoteffect(fxid) {
  ent = maps\_createfx::createeffect("oneshotfx", fxid);
  ent.v["delay"] = -15;
  return ent;
}

reportexploderids() {
  if(!isDefined(level._exploder_ids)) {
    return;
  }
  keys = getarraykeys(level._exploder_ids);

  println("Server Exploder dictionary : ");

  for(i = 0; i < keys.size; i++)
    println(keys[i] + " : " + level._exploder_ids[keys[i]]);
}

getexploderid(ent) {
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

createexploder(fxid) {
  ent = maps\_createfx::createeffect("exploder", fxid);
  ent.v["delay"] = 0;
  ent.v["exploder"] = 1;
  ent.v["exploder_type"] = "normal";
  return ent;
}

vehicle_detachfrompath() {
  maps\_vehicle::vehicle_pathdetach();
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

add_skipto(msg, func, loc_string, optional_func) {
  maps\_skipto::add_skipto_assert();
  msg = tolower(msg);
  array = maps\_skipto::add_skipto_construct(msg, func, loc_string, optional_func);

  if(!isDefined(func))
    assert(isDefined(func), "add_skipto() called with no func parameter..");

  level.skipto_functions[level.skipto_functions.size] = array;
  level.skipto_arrays[msg] = array;
}

set_skipto_cleanup_func(func) {
  level.func_skipto_cleanup = func;
}

default_skipto(skipto) {
  level.default_skipto = skipto;
}

skipto_teleport(skipto_name, friendly_ai, coop_sort) {
  skipto_teleport_ai(skipto_name, friendly_ai);
  skipto_teleport_players(skipto_name, coop_sort);
}

skipto_teleport_ai(skipto_name, friendly_ai) {
  if(!isDefined(friendly_ai)) {
    if(isDefined(level.heroes))
      friendly_ai = level.heroes;
    else
      friendly_ai = getaiarray("allies");
  }

  if(isstring(friendly_ai))
    friendly_ai = get_ai_array(friendly_ai, "script_noteworthy");

  if(!isarray(friendly_ai))
    friendly_ai = array(friendly_ai);

  a_skipto_structs = getstructarray(skipto_name + "_ai", "targetname");

  if(!a_skipto_structs.size) {
    return;
  }
  assert(a_skipto_structs.size >= friendly_ai.size, "Need more start positions for ai for " + skipto_name + "!Tried to teleport " + friendly_ai.size + " AI to only " + a_skipto_structs.size + " structs");

  for(i = 0; i < friendly_ai.size; i++) {
    start_i = 0;

    if(isDefined(friendly_ai[i].script_int)) {
      for(j = 0; j < a_skipto_structs.size; j++) {
        if(isDefined(a_skipto_structs[j].script_int)) {
          if(a_skipto_structs[j].script_int == friendly_ai[i].script_int) {
            start_i = j;
            break;
          }
        }
      }
    }

    friendly_ai[i] skipto_teleport_single_ai(a_skipto_structs[start_i]);
    arrayremovevalue(a_skipto_structs, a_skipto_structs[start_i]);
  }
}

skipto_teleport_single_ai(ai_skipto_spot) {
  if(isDefined(ai_skipto_spot.angles))
    self forceteleport(ai_skipto_spot.origin, ai_skipto_spot.angles);
  else
    self forceteleport(ai_skipto_spot.origin);

  if(isDefined(ai_skipto_spot.target)) {
    node = getnode(ai_skipto_spot.target, "targetname");

    if(isDefined(node)) {
      self setgoalnode(node);
      return;
    }
  }

  self setgoalpos(ai_skipto_spot.origin);
}

skipto_teleport_players(skipto_name, coop_sort) {
  wait_for_first_player();
  players = get_players();

  if(isDefined(coop_sort) && coop_sort)
    skipto_spots = get_sorted_skipto_spots(skipto_name);
  else
    skipto_spots = getstructarray(skipto_name, "targetname");

  assert(skipto_spots.size >= players.size, "Need more skipto positions for players!");

  for(i = 0; i < players.size; i++) {
    players[i] setorigin(skipto_spots[i].origin);

    if(isDefined(skipto_spots[i].angles))
      players[i] setplayerangles(skipto_spots[i].angles);
  }

  set_breadcrumbs(skipto_spots);
}

get_sorted_skipto_spots(skipto_name) {
  player_skipto_spots = getstructarray(skipto_name, "targetname");

  for(i = 0; i < player_skipto_spots.size; i++) {
    for(j = i; j < player_skipto_spots.size; j++) {
      assert(isDefined(player_skipto_spots[j].script_int), "player skipto struct at: " + player_skipto_spots[j].origin + " must have a script_int set for coop spawning");
      assert(isDefined(player_skipto_spots[i].script_int), "player skipto struct at: " + player_skipto_spots[i].origin + " must have a script_int set for coop spawning");

      if(player_skipto_spots[j].script_int < player_skipto_spots[i].script_int) {
        temp = player_skipto_spots[i];
        player_skipto_spots[i] = player_skipto_spots[j];
        player_skipto_spots[j] = temp;
      }
    }
  }

  return player_skipto_spots;
}

within_fov(start_origin, start_angles, end_origin, fov) {
  normal = vectornormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = vectordot(forward, normal);
  return dot >= fov;
}

wait_for_buffer_time_to_pass(last_queue_time, buffer_time) {
  timer = buffer_time * 1000 - (gettime() - last_queue_time);
  timer = timer * 0.001;

  if(timer > 0)
    wait(timer);
}

string(val) {
  if(isDefined(val))
    return "" + val;
  else
    return "";
}

clear_threatbias(group1, group2) {
  setthreatbias(group1, group2, 0);
  setthreatbias(group2, group1, 0);
}

add_global_spawn_function(team, function, param1, param2, param3) {
  assert(isDefined(level.spawn_funcs), "Tried to add_global_spawn_function before calling _load");
  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  level.spawn_funcs[team][level.spawn_funcs[team].size] = func;
}

add_global_drone_spawn_function(team, function, param1, param2, param3) {
  if(!isDefined(level.spawn_funcs_drones))
    level.spawn_funcs_drones = [];

  if(!isDefined(level.spawn_funcs_drones["axis"]))
    level.spawn_funcs_drones["axis"] = [];

  if(!isDefined(level.spawn_funcs_drones["allies"]))
    level.spawn_funcs_drones["allies"] = [];

  if(!isDefined(level.spawn_funcs_drones["neutral"]))
    level.spawn_funcs_drones["neutral"] = [];

  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  level.spawn_funcs_drones[team][level.spawn_funcs_drones[team].size] = func;
}

remove_global_spawn_function(team, function) {
  assert(isDefined(level.spawn_funcs), "Tried to remove_global_spawn_function before calling _load");
  array = [];

  for(i = 0; i < level.spawn_funcs[team].size; i++) {
    if(level.spawn_funcs[team][i]["function"] != function)
      array[array.size] = level.spawn_funcs[team][i];
  }

  assert(level.spawn_funcs[team].size != array.size, "Tried to remove a function from level.spawn_funcs, but that function didn't exist!");
  level.spawn_funcs[team] = array;
}

add_spawn_function(function, param1, param2, param3, param4, param5) {
  assert(!isDefined(level._loadstarted) || !isalive(self), "Tried to add_spawn_function to a living guy.");
  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  func["param5"] = param5;

  if(!isDefined(self.spawn_funcs))
    self.spawn_funcs = [];

  self.spawn_funcs[self.spawn_funcs.size] = func;
}

add_spawn_function_veh(veh_targetname, function, param1, param2, param3, param4) {
  if(!isDefined(level.vehicle_targetname_array[veh_targetname])) {
    println("Tried to add_spawn_function_veh to vehicle spawners named *" + veh_targetname + "* but none were found");

    return;
  }

  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;

  foreach(n_spawn_group, a_spawners in level.vehicle_spawners) {
    foreach(spawner in a_spawners) {
      if(isDefined(spawner.targetname) && spawner.targetname == veh_targetname + "_vehiclespawner") {
        if(!isDefined(spawner.spawn_funcs))
          spawner.spawn_funcs = [];

        spawner.spawn_funcs[spawner.spawn_funcs.size] = func;
      }
    }
  }
}

add_spawn_function_veh_by_type(veh_type, function, param1, param2, param3, param4) {
  assert(isDefined(level.vehicle_spawners), "Tried to add_spawn_function_veh_by_type before vehicle spawners were inited");
  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;

  foreach(n_spawn_group, a_spawners in level.vehicle_spawners) {
    foreach(spawner in a_spawners) {
      if(isDefined(spawner.vehicletype) && spawner.vehicletype == veh_type) {
        if(!isDefined(spawner.spawn_funcs))
          spawner.spawn_funcs = [];

        spawner.spawn_funcs[spawner.spawn_funcs.size] = func;
      }
    }
  }
}

get_vehicle_spawner_array(str_value, str_key) {
  if(!isDefined(str_key))
    str_key = "targetname";

  assert(isDefined(str_value), "Missing <str_value> argument to get_vehicle_spawner_array()");

  if(str_key == "targetname")
    str_value = str_value + "_vehiclespawner";

  a_spawners = get_struct_array(str_value, str_key);
  return a_spawners;
}

get_vehicle_spawner(str_value, str_key) {
  if(!isDefined(str_key))
    str_key = "targetname";

  assert(isDefined(str_value), "Missing <str_value> argument to get_vehicle_spawner()");

  if(str_key == "targetname")
    str_value = str_value + "_vehiclespawner";

  a_spawners = get_struct_array(str_value, str_key);
  assert(a_spawners.size < 2, "More than one vehicle spawner found with kvp '" + str_key + "/" + str_value);
  return a_spawners[0];
}

get_vehicle_array(str_value, str_key) {
  if(!isDefined(str_key))
    str_key = "targetname";

  a_all_vehicles = getvehiclearray();

  if(isDefined(str_value)) {
    a_veh = [];

    foreach(veh in a_all_vehicles) {
      switch (str_key) {
        case "targetname":
          if(!isDefined(veh.targetname) && !isDefined(str_value) || isDefined(veh.targetname) && isDefined(str_value) && veh.targetname == str_value)
            a_veh[a_veh.size] = veh;

          break;
        case "script_noteworthy":
          if(!isDefined(veh.script_noteworthy) && !isDefined(str_value) || isDefined(veh.script_noteworthy) && isDefined(str_value) && veh.script_noteworthy == str_value)
            a_veh[a_veh.size] = veh;

          break;
        case "script_string":
          if(!isDefined(veh.script_string) && !isDefined(str_value) || isDefined(veh.script_string) && isDefined(str_value) && veh.script_string == str_value)
            a_veh[a_veh.size] = veh;

          break;
        case "model":
          if(!isDefined(veh.model) && !isDefined(str_value) || isDefined(veh.model) && isDefined(str_value) && veh.model == str_value)
            a_veh[a_veh.size] = veh;

          break;
      }
    }

    return a_veh;
  }

  return a_all_vehicles;
}

ignore_triggers(timer) {
  self endon("death");
  self.ignoretriggers = 1;

  if(isDefined(timer))
    wait(timer);
  else
    wait 0.5;

  self.ignoretriggers = 0;
}

is_hero() {
  return isDefined(level.hero_list[get_ai_number()]);
}

get_ai_number() {
  if(!isDefined(self.ai_number))
    set_ai_number();

  return self.ai_number;
}

set_ai_number() {
  if(!isDefined(level.ai_number))
    level.ai_number = 0;

  self.ai_number = level.ai_number;
  level.ai_number++;
}

make_hero(ent) {
  if(!isDefined(ent))
    ent = self;

  if(!isDefined(level.hero_list[ent.ai_number])) {
    ent magic_bullet_shield();
    level.hero_list[ent.ai_number] = ent;
    ent thread unmake_hero_on_death();
  }
}

unmake_hero_on_death() {
  self waittill("death");
  level.hero_list[self.ai_number] = undefined;
}

unmake_hero(ent) {
  if(!isDefined(ent))
    ent = self;

  ent stop_magic_bullet_shield();
  level.hero_list[ent.ai_number] = undefined;
  ent.ikpriority = 0;
}

get_heroes() {
  return level.hero_list;
}

replace_on_death() {
  maps\_colors::colornode_replace_on_death();
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

    if(isDefined(guy.script_noteworthy) && guy.script_noteworthy == noteworthy) {
      continue;
    }
    newarray[newarray.size] = guy;
  }

  return newarray;
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

wait_for_either_trigger(str_targetname1, str_targetname2) {
  ent = spawnStruct();
  array = [];
  array = arraycombine(array, getEntArray(str_targetname1, "targetname"), 1, 0);
  array = arraycombine(array, getEntArray(str_targetname2, "targetname"), 1, 0);

  for(i = 0; i < array.size; i++)
    ent thread ent_waits_for_trigger(array[i]);

  ent waittill("done", t_hit);
  return t_hit;
}

get_trigger_flag(flag_name_override) {
  if(isDefined(flag_name_override))
    return flag_name_override;

  if(isDefined(self.script_flag))
    return self.script_flag;

  if(isDefined(self.script_noteworthy))
    return self.script_noteworthy;

  assert(0, "Flag trigger at " + self.origin + " has no script_flag set.");
}

is_spawner(ent) {
  b_spawner = 0;

  if(isDefined(ent.classname) && ent.classname == "script_vehicle")
    b_spawner = ent has_spawnflag(2);
  else
    b_spawner = isspawner(ent);

  return b_spawner;
}

set_default_pathenemy_settings() {
  self.pathenemylookahead = 192;
  self.pathenemyfightdist = 192;
}

enable_heat() {
  self thread animscripts\anims_table::setup_heat_anim_array();
}

disable_heat() {
  self thread animscripts\anims_table::reset_heat_anim_array();
}

enable_cqb() {
  if(self animscripts\utility::aihasonlypistol()) {
    return;
  }
  self.cqb = 1;
  level thread animscripts\cqb::findcqbpointsofinterest();
  self thread animscripts\anims_table_cqb::setup_cqb_anim_array();

  self thread animscripts\cqb::cqbdebug();
}

disable_cqb() {
  if(!isDefined(self) && !isalive(self)) {
    return;
  }
  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol")) {
    self.cqb = 0;
    self.cqb_point_of_interest = undefined;
    self thread animscripts\anims_table_cqb::reset_cqb_anim_array();

    self notify("end_cqb_debug");
  }
}

set_cqb_run_anim(runanim, walkanim, sprintanim) {
  self thread animscripts\anims_table_cqb::set_cqb_run_anim(runanim, walkanim, sprintanim);
}

clear_cqb_run_anim() {
  self thread animscripts\anims_table_cqb::clear_cqb_run_anim();
}

change_movemode(movemode) {
  self notify("change_movemode", movemode);

  if(!isDefined(movemode))
    movemode = "run";

  if(isDefined(self.elite) && self.elite && self.subclass == "elite")
    self maps\ai_subclass\_subclass_elite::disable_elite();

  if(issubstr(movemode, "cqb"))
    enable_cqb();
  else
    disable_cqb();

  switch (movemode) {
    case "cqb":
    case "cqb_run":
    case "run":
      self.sprint = 0;
      self.walk = 0;
      break;
    case "cqb_walk":
    case "walk":
      self.sprint = 0;
      self.walk = 1;
      break;
    case "cqb_sprint":
    case "sprint":
      self.sprint = 1;
      self.walk = 0;
      break;
    case "default":
      assertmsg("Unsupported move mode.");
  }
}

reset_movemode() {
  disable_cqb();

  if(isDefined(self.elite) && self.elite)
    maps\ai_subclass\_subclass_elite::enable_elite();

  self.sprint = 0;
  self.walk = 0;
}

disable_tactical_walk() {
  assert(isai(self), "Tried to disable_tactical_walk but it wasn't called on an AI");
  self.old_maxfaceenemydist = self.maxfaceenemydist;
  self.maxfaceenemydist = 0;
}

enable_tactical_walk() {
  assert(isai(self), "Tried to enable_tactical_walk but it wasn't called on an AI");

  if(isDefined(self.old_maxfaceenemydist))
    self.maxfaceenemydist = self.old_maxfaceenemydist;
  else
    self.maxfaceenemydist = anim.moveglobals.code_face_enemy_dist;
}

cqb_aim(the_target) {
  if(!isDefined(the_target))
    self.cqb_target = undefined;
  else {
    self.cqb_target = the_target;

    if(!isDefined(the_target.origin))
      assertmsg("target passed into cqb_aim does not have an origin!");
  }
}

waittill_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait(timer);
}

waittill_any_or_timeout(timer, string1, string2, string3, string4, string5) {
  assert(isDefined(string1));
  self endon(string1);

  if(isDefined(string2))
    self endon(string2);

  if(isDefined(string3))
    self endon(string3);

  if(isDefined(string4))
    self endon(string4);

  if(isDefined(string5))
    self endon(string5);

  wait(timer);
}

getfx(fx) {
  assert(isDefined(level._effect[fx]), "Fx " + fx + " is not defined in level._effect.");
  return level._effect[fx];
}

play_fx(str_fx, v_origin, v_angles, time_to_delete_or_notify, b_link_to_self, str_tag, b_no_cull) {
  if((!isDefined(time_to_delete_or_notify) || !isstring(time_to_delete_or_notify) && time_to_delete_or_notify == -1) && (isDefined(b_link_to_self) && b_link_to_self) && isDefined(str_tag)) {
    playFXOnTag(getfx(str_fx), self, str_tag);
    return self;
  } else {
    m_fx = spawn_model("tag_origin", v_origin, v_angles);

    if(isDefined(b_link_to_self) && b_link_to_self) {
      if(isDefined(str_tag))
        m_fx linkto(self, str_tag, (0, 0, 0), (0, 0, 0));
      else
        m_fx linkto(self);
    }

    if(isDefined(b_no_cull) && b_no_cull)
      m_fx setforcenocull();

    playFXOnTag(getfx(str_fx), m_fx, "tag_origin");
    m_fx thread _play_fx_delete(self, time_to_delete_or_notify);
    return m_fx;
  }
}

_play_fx_delete(ent, time_to_delete_or_notify) {
  if(!isDefined(time_to_delete_or_notify))
    time_to_delete_or_notify = -1;

  if(isstring(time_to_delete_or_notify))
    ent waittill_either("death", time_to_delete_or_notify);
  else if(time_to_delete_or_notify > 0)
    ent waittill_notify_or_timeout("death", time_to_delete_or_notify);
  else
    ent waittill("death");

  if(isDefined(self))
    self delete();
}

getanim(anime) {
  assert(isDefined(self.animname), "Called getanim on a guy with no animname");
  assert(isDefined(level.scr_anim[self.animname][anime]), "Called getanim on an inexistent anim.Animname:" + self.animname + ".Animname:" + anime);
  return level.scr_anim[self.animname][anime];
}

getanim_from_animname(anime, animname) {
  assert(isDefined(animname), "Must supply an animname");
  assert(isDefined(level.scr_anim[animname][anime]), "Called getanim on an inexistent anim");
  return level.scr_anim[animname][anime];
}

getanim_generic(anime) {
  assert(isDefined(level.scr_anim["generic"][anime]), "Called getanim_generic on an inexistent anim");
  return level.scr_anim["generic"][anime];
}

add_hint_string(name, string, optionalfunc) {
  assert(isDefined(level.trigger_hint_string), "Tried to add a hint string before _load was called.");
  assert(isDefined(name), "Set a name for the hint string. This should be the same as the script_hint on the trigger_hint.");
  assert(isDefined(string), "Set a string for the hint string. This is the string you want to appear when the trigger is hit.");
  level.trigger_hint_string[name] = string;
  precachestring(string);

  if(isDefined(optionalfunc))
    level.trigger_hint_func[name] = optionalfunc;
}

throwgrenadeatenemyasap(atenemy) {
  if(isDefined(atenemy) && atenemy && isDefined(self.enemy))
    animscripts\combat_utility::throwgrenadeatenemyasap_combat_utility(self.enemy);
  else if(!isDefined(atenemy))
    animscripts\combat_utility::throwgrenadeatenemyasap_combat_utility();
}

switch_weapon_asap() {
  assert(isai(self), "Can only call this function on an AI character");

  if(isalive(self) && !self.a.weapon_switch_asap)
    self.a.weapon_switch_asap = 1;
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

  level.sg_precacheanims[animtree][animation] = 1;
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

set_ignoresuppression(val) {
  self.ignoresuppression = val;
}

set_goalradius(radius) {
  self.goalradius = radius;
}

set_allowdeath(val) {
  self.allowdeath = val;
}

set_run_anim(anime, alwaysrunforward) {
  assert(isDefined(anime), "Tried to set run anim but didn't specify which animation to ues");
  assert(isDefined(self.animname), "Tried to set run anim on a guy that had no anim name");
  assert(isDefined(level.scr_anim[self.animname][anime]), "Tried to set run anim but the anim was not defined in the maps _anim file");

  if(isDefined(alwaysrunforward))
    self.alwaysrunforward = alwaysrunforward;
  else
    self.alwaysrunforward = 1;

  self.a.combatrunanim = level.scr_anim[self.animname][anime];
  self.run_noncombatanim = self.a.combatrunanim;
  self.walk_combatanim = self.a.combatrunanim;
  self.walk_noncombatanim = self.a.combatrunanim;
  self.precombatrunenabled = 0;
}

set_generic_run_anim(anime, alwaysrunforward) {
  assert(isDefined(anime), "Tried to set generic run anim but didn't specify which animation to ues");
  assert(isDefined(level.scr_anim["generic"][anime]), "Tried to set generic run anim but the anim was not defined in the maps _anim file");

  if(isDefined(alwaysrunforward)) {
    if(alwaysrunforward)
      self.alwaysrunforward = alwaysrunforward;
    else
      self.alwaysrunforward = undefined;
  } else
    self.alwaysrunforward = 1;

  self.a.combatrunanim = level.scr_anim["generic"][anime];
  self.run_noncombatanim = self.a.combatrunanim;
  self.walk_combatanim = self.a.combatrunanim;
  self.walk_noncombatanim = self.a.combatrunanim;
  self.precombatrunenabled = 0;
}

clear_run_anim() {
  self.alwaysrunforward = undefined;
  self.a.combatrunanim = undefined;
  self.run_noncombatanim = undefined;
  self.walk_combatanim = undefined;
  self.walk_noncombatanim = undefined;
  self.precombatrunenabled = 1;
}

physicsjolt_proximity(outer_radius, inner_radius, force) {
  self endon("death");
  self endon("stop_physicsjolt");

  if(!isDefined(outer_radius) || !isDefined(inner_radius) || !isDefined(force)) {
    outer_radius = 400;
    inner_radius = 256;
    force = vectorscale((0, 0, 1), 0.075);
  }

  fade_distance = outer_radius * outer_radius;
  base_force = force;

  while(true) {
    wait 0.1;
    force = base_force;

    if(self.classname == "script_vehicle") {
      speed = self getspeedmph();

      if(speed < 3) {
        scale = speed / 3;
        force = vectorscale(base_force, scale);
      }
    }

    dist = distancesquared(self.origin, get_players()[0].origin);
    scale = fade_distance / dist;

    if(scale > 1)
      scale = 1;

    force = vectorscale(force, scale);
    total_force = force[0] + force[1] + force[2];
  }
}

activate_trigger() {
  assert(!isDefined(self.trigger_off), "Tried to activate trigger that is OFF( either from trigger_off or from flags set on it through shift - G menu");

  if(isDefined(self.script_color_allies)) {
    self.activated_color_trigger = 1;
    maps\_colors::activate_color_trigger("allies");
  }

  if(isDefined(self.script_color_axis)) {
    self.activated_color_trigger = 1;
    maps\_colors::activate_color_trigger("axis");
  }

  self notify("trigger");
}

self_delete() {
  if(isDefined(self))
    self delete();
}

has_color() {
  if(self.team == "axis")
    return isDefined(self.script_color_axis) || isDefined(self.script_forcecolor);

  return isDefined(self.script_color_allies) || isDefined(self.script_forcecolor);
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

notify_delay(snotifystring, fdelay) {
  assert(isDefined(self));
  assert(isDefined(snotifystring));
  assert(isDefined(fdelay));
  self endon("death");

  if(fdelay > 0)
    wait(fdelay);

  if(!isDefined(self)) {
    return;
  }
  self notify(snotifystring);
}

notify_delay_with_ender(snotifystring, fdelay, ender) {
  if(isDefined(ender))
    level endon(ender);

  assert(isDefined(self));
  assert(isDefined(snotifystring));
  assert(isDefined(fdelay));
  self endon("death");

  if(fdelay > 0)
    wait(fdelay);

  if(!isDefined(self)) {
    return;
  }
  self notify(snotifystring);
}

gun_remove() {
  self animscripts\shared::placeweaponon(self.weapon, "none");
}

gun_switchto(weaponname, whichhand) {
  self animscripts\shared::placeweaponon(weaponname, whichhand);
}

gun_recall() {
  self animscripts\shared::placeweaponon(self.primaryweapon, "right");
}

custom_ai_weapon_loadout(primary, secondary, sidearm) {
  self animscripts\shared::detachallweaponmodels();

  if(isDefined(self.primaryweapon) && self.primaryweapon != "")
    self animscripts\shared::detachweapon(self.primaryweapon);

  if(isDefined(self.secondaryweapon) && self.secondaryweapon != "")
    self animscripts\shared::detachweapon(self.secondaryweapon);

  if(isDefined(self.sidearm) && self.sidearm != "")
    self animscripts\shared::detachweapon(self.sidearm);

  self setprimaryweapon("");
  self setsecondaryweapon("");
  self.sidearm = "";

  if(isDefined(primary)) {
    if(getweaponmodel(primary) != "") {
      self setprimaryweapon(primary);
      self animscripts\init::initweapon(self.primaryweapon);
      self animscripts\shared::placeweaponon(self.primaryweapon, "right");
    } else
      assert(0, "custom_ai_weapon_loadout: primary weapon " + primary + " is not in a csv or isn't precached");
  }

  if(isDefined(secondary)) {
    if(getweaponmodel(secondary) != "") {
      self setsecondaryweapon(secondary);
      self animscripts\init::initweapon(self.secondaryweapon);
      self animscripts\shared::placeweaponon(self.secondaryweapon, "back");
    } else
      assert(0, "custom_ai_weapon_loadout: secondary weapon " + secondary + " is not in a csv or isn't precached");
  }

  if(isDefined(sidearm)) {
    if(getweaponmodel(sidearm) != "") {
      self.sidearm = sidearm;
      self animscripts\init::initweapon(self.sidearm);
    } else
      assert(0, "custom_ai_weapon_loadout: sidearm weapon " + sidearm + " is not in a csv or isn't precached");
  }

  self setcurrentweapon(self.primaryweapon);
  self animscripts\weaponlist::refillclip();
  self.issniper = animscripts\combat_utility::issniperrifle(self.weapon);
}

lerp_player_view_to_tag(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc) {
  if(isPlayer(self))
    self endon("disconnect");

  lerp_player_view_to_tag_internal(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, undefined);
}

lerp_player_view_to_tag_and_hit_geo(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc) {
  if(isPlayer(self))
    self endon("disconnect");

  lerp_player_view_to_tag_internal(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, 1);
}

lerp_player_view_to_position(origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(isPlayer(self))
    self endon("disconnect");

  linker = spawn("script_origin", (0, 0, 0));
  linker.origin = self.origin;
  linker.angles = self getplayerangles();

  if(isDefined(hit_geo))
    self playerlinkto(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);
  else if(isDefined(right_arc))
    self playerlinkto(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc);
  else if(isDefined(fraction))
    self playerlinkto(linker, "", fraction);
  else
    self playerlinkto(linker);

  linker moveto(origin, lerptime, lerptime * 0.25);
  linker rotateto(angles, lerptime, lerptime * 0.25);
  linker waittill("movedone");
  linker delete();
}

lerp_player_view_to_tag_oldstyle(tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc) {
  lerp_player_view_to_tag_oldstyle_internal(tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, 0);
}

lerp_player_view_to_position_oldstyle(origin, angles, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(isPlayer(self))
    self endon("disconnect");

  linker = spawn("script_origin", (0, 0, 0));
  linker.origin = get_player_feet_from_view();
  linker.angles = self getplayerangles();

  if(isDefined(hit_geo))
    self playerlinktodelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);
  else if(isDefined(right_arc))
    self playerlinktodelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc);
  else if(isDefined(fraction))
    self playerlinktodelta(linker, "", fraction);
  else
    self playerlinktodelta(linker);

  linker moveto(origin, lerptime, lerptime * 0.25);
  linker rotateto(angles, lerptime, lerptime * 0.25);
  linker waittill("movedone");
  linker delete();
}

lerp_player_view_to_moving_position_oldstyle(ent, tag, lerptime, fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo) {
  if(isPlayer(self))
    self endon("disconnect");

  linker = spawn("script_origin", (0, 0, 0));
  linker.origin = self.origin;
  linker.angles = self getplayerangles();

  if(isDefined(hit_geo))
    self playerlinktodelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc, hit_geo);
  else if(isDefined(right_arc))
    self playerlinktodelta(linker, "", fraction, right_arc, left_arc, top_arc, bottom_arc);
  else if(isDefined(fraction))
    self playerlinktodelta(linker, "", fraction);
  else
    self playerlinktodelta(linker);

  max_count = lerptime / 0.0167;

  for(count = 0; count < max_count; count++) {
    origin = ent gettagorigin(tag);
    angles = ent gettagangles(tag);
    linker moveto(origin, 0.0167 * (max_count - count));
    linker rotateto(angles, 0.0167 * (max_count - count));
    wait 0.0167;
  }

  linker delete();
}

waittill_either_function(func1, parm1, func2, parm2) {
  ent = spawnStruct();
  thread waittill_either_function_internal(ent, func1, parm1);
  thread waittill_either_function_internal(ent, func2, parm2);
  ent waittill("done");
}

waittill_msg(msg) {
  if(isPlayer(self))
    self endon("disconnect");

  self waittill(msg);
}

display_hint(hint) {
  if(getDvar(#"_id_39165C89") == "1") {
    return;
  }
  if(isDefined(level.trigger_hint_func[hint])) {
    if([[level.trigger_hint_func[hint]]]()) {
      return;
    }
    hintprint(level.trigger_hint_string[hint], level.trigger_hint_func[hint]);
  } else
    hintprint(level.trigger_hint_string[hint]);
}

enable_careful() {
  assert(isai(self), "Tried to make an ai careful but it wasn't called on an AI");
  self.script_careful = 1;
}

disable_careful() {
  assert(isai(self), "Tried to unmake an ai careful but it wasn't called on an AI");
  self.script_careful = 0;
  self notify("stop_being_careful");
}

set_fixednode(b_toggle) {
  assert(isDefined(b_toggle), "Missing parameter: must set fixednode to true or false");
  self.fixednode = b_toggle;
}

spawn_ai(bforcespawn, str_targetname) {
  ai = undefined;

  if(isDefined(self.lastspawntime) && self.lastspawntime >= gettime())
    wait 0.05;

  no_enemy_info = isDefined(self.script_noenemyinfo) && self.script_noenemyinfo;
  no_threat_update_on_first_frame = isDefined(self.script_no_threat_on_spawn) && self.script_no_threat_on_spawn;
  delete_on_count_zero = isDefined(self.script_delete_on_zero) && self.script_delete_on_zero;

  if(has_spawnflag(16) || isDefined(self.script_forcespawn) || isDefined(bforcespawn) && bforcespawn)
    ai = self stalingradspawn(no_enemy_info, str_targetname, no_threat_update_on_first_frame);
  else
    ai = self dospawn(no_enemy_info, str_targetname, no_threat_update_on_first_frame);

  if(isDefined(ai))
    self.lastspawntime = gettime();

  if(delete_on_count_zero && self.count <= 0)
    self delete();

  if(!spawn_failed(ai))
    return ai;
}

#using_animtree("generic_human");

spawn_drone(b_make_fake_ai, str_targetname, b_spawn_collision, do_ragdoll_death, b_auto_delete_on_death) {
  if(!isDefined(b_make_fake_ai))
    b_make_fake_ai = 0;

  if(!isDefined(b_spawn_collision))
    b_spawn_collision = 0;

  if(!isDefined(do_ragdoll_death))
    do_ragdoll_death = 0;

  if(!isDefined(b_auto_delete_on_death))
    b_auto_delete_on_death = 0;

  assert(isDefined(self.classname), "No classname set for drone");
  m_drone = spawn("script_model", self.origin);
  m_drone getdronemodel(self.classname);
  m_drone.angles = self.angles;
  m_drone.is_drone = 1;

  if(!(isDefined(self.nofakeai) && self.nofakeai) && b_make_fake_ai) {
    m_drone makefakeai();
    m_drone.takedamage = 1;
    m_drone.dr_ai_classname = self.classname;

    if(m_drone.team == "allies") {
      if(isDefined(self.script_friendname) && self.script_friendname == "NONE")
        m_drone.name = "";
      else if(isDefined(self.script_friendname))
        m_drone.name = self.script_friendname;
      else
        m_drone maps\_names::get_name();

      if(isDefined(m_drone.name))
        m_drone setlookattext(m_drone.name, &"");
    }

    level thread maps\_friendlyfire::friendly_fire_think(m_drone);
  }

  if(b_spawn_collision) {
    m_drone.drone_collision = spawn_model("drone_collision", m_drone.origin);
    m_drone.drone_collision linkto(m_drone);
  }

  if(isDefined(self.script_health))
    m_drone.health = self.script_health;

  m_drone.do_ragdoll_death = do_ragdoll_death;
  m_drone thread _drone_death(b_auto_delete_on_death);
  m_drone useanimtree(#animtree);

  if(isDefined(str_targetname))
    m_drone.targetname = str_targetname;
  else if(isDefined(self.targetname))
    m_drone.targetname = self.targetname + "_drone";

  if(isDefined(level.spawn_funcs_drones)) {
    foreach(func in level.spawn_funcs_drones[m_drone.team])
    single_thread(m_drone, func["function"], func["param1"], func["param2"], func["param3"]);
  }

  m_drone thread _debug_drone();

  return m_drone;
}

autoexec debug_drones_thread() {
  if(!isDefined(level.debug_drone_count))
    level.debug_drone_count = 0;

  while(true) {
    if(getdvarintdefault("ai_showCount", 0))
      _set_debug_drone_count(level.debug_drone_count);
    else
      _destroy_debug_drones_count_hud();

    wait 0.2;
  }
}

private _create_debug_drones_count_hud() {
  if(!isDefined(level.hud_debug_drone_count)) {
    level.hud_debug_drone_count_label = maps\_debug::new_hud("drone_count_label", "drones ", 645, 190, 0.8);
    level.hud_debug_drone_count_label.font = "smallfixed";
    level.hud_debug_drone_count = maps\_debug::new_hud("drone_count", "", 620, 190, 0.8);
    level.hud_debug_drone_count.font = "smallfixed";
    level.hud_debug_drone_count.horzalign = "right";
    level.hud_debug_drone_count.alignx = "right";
    level.hud_debug_drone_count.x = -50;
  }
}

private _destroy_debug_drones_count_hud() {
  if(isDefined(level.hud_debug_drone_count_label))
    level.hud_debug_drone_count_label destroy();

  if(isDefined(level.hud_debug_drone_count))
    level.hud_debug_drone_count destroy();
}

private _set_debug_drone_count(n_count) {
  _create_debug_drones_count_hud();
  level.hud_debug_drone_count setvalue(n_count);
}

private _debug_drone() {
  if(!isDefined(level.debug_drone_count))
    level.debug_drone_count = 0;

  level.debug_drone_count++;

  while(isDefined(self))
    self waittill("death");

  level.debug_drone_count--;
}

private _drone_death(b_auto_delete_on_death) {
  self waittill("death");

  if(isDefined(self)) {
    self notify("drone_corpse");
    self.is_drone_corpse = 1;
    self setCanDamage(0);

    if(isDefined(self.drone_collision))
      self.drone_collision delete();

    self setlookattext("", &"");

    if(isDefined(self.do_ragdoll_death) && self.do_ragdoll_death) {
      self unlink();
      self startragdoll();
    }

    if(b_auto_delete_on_death)
      self thread auto_delete();
  }
}

auto_delete(e_ref) {
  self endon("death");
  self notify("auto_deleting");
  self endon("auto_deleting");

  while(isDefined(self)) {
    if(!(isDefined(self.b_dont_auto_delete) && self.b_dont_auto_delete)) {
      if(distancesquared(level.player.origin, self.origin) >= 250000) {
        n_now = gettime();
        n_seconds_alive = isDefined(self.birthtime) ? (n_now - self.birthtime) / 1000 : 10;

        if(n_seconds_alive > 10) {
          v_eye = level.player getEye();
          v_to_self = vectornormalize(self.origin - v_eye);
          n_dot_ref = -1;

          if(isDefined(e_ref)) {
            v_player_to_ref = vectornormalize(e_ref.origin - v_eye);
            n_dot_ref = vectordot(v_to_self, v_player_to_ref);
          }

          v_player_forward = anglesToForward(level.player getplayerangles());
          n_dot_player = vectordot(v_to_self, v_player_forward);

          if(n_dot_player < 0.3 && n_dot_ref < 0.3) {
            if(self sightconetrace(v_eye, level.player) < 0.1) {
              if(isDefined(self.classname) && self.classname == "script_vehicle") {
                self.delete_on_death = 1;
                self notify("death");

                if(!isalive(self))
                  self delete();
              } else
                self delete();
            }
          }
        }
      }
    }

    wait(randomfloatrange(0.2, 1));
  }
}

kill_spawnernum(number) {
  spawners = getspawnerarray();

  for(i = 0; i < spawners.size; i++) {
    if(!isDefined(spawners[i].script_killspawner)) {
      continue;
    }
    if(number != spawners[i].script_killspawner) {
      continue;
    }
    spawners[i] delete();
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
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = target;
}

set_maxvisibledist(dist) {
  self.maxvisibledist = dist;
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
  if(isDefined(end_on))
    level endon(end_on);

  if(isDefined(wait_till))
    level waittill(wait_till);

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

set_grenadeammo(count) {
  self.grenadeammo = count;
}

get_player_feet_from_view() {
  tagorigin = self.origin;
  upvec = anglestoup(self getplayerangles());
  height = self getplayerviewheight();
  player_eye = tagorigin + (0, 0, height);
  player_eye_fake = tagorigin + vectorscale(upvec, height);
  diff_vec = player_eye - player_eye_fake;
  fake_origin = tagorigin + diff_vec;
  return fake_origin;
}

set_console_status() {
  if(!isDefined(level.console))
    level.console = getDvar(#"_id_D1AF4972") == "true";
  else
    assert(level.console == (getDvar(#"_id_D1AF4972") == "true"), "Level.console got set incorrectly.");

  if(!isDefined(level.consolexenon))
    level.xenon = getDvar(#"xenonGame") == "true";
  else
    assert(level.xenon == (getDvar(#"xenonGame") == "true"), "Level.xenon got set incorrectly.");
}

autosave_now(optional_useless_string, suppress_print) {
  return maps\_autosave::autosave_game_now(suppress_print);
}

set_deathanim(deathanim) {
  self.deathanim = getanim(deathanim);
}

clear_deathanim() {
  self.deathanim = undefined;
}

lerp_fov_overtime(time, destfov, use_camera_tween) {
  level notify("lerp_fov_overtime");
  level endon("lerp_fov_overtime");
  basefov = getdvarfloat(#"cg_fov");
  destfov = float(destfov);

  if(basefov == destfov) {
    return;
  }
  iprintln("!lerp fov: " + destfov + ", " + time);

  if(!isDefined(use_camera_tween)) {
    incs = int(time / 0.05);
    incfov = (destfov - basefov) / incs;
    currentfov = basefov;

    if(incfov == 0) {
      return;
    }
    for(i = 0; i < incs; i++) {
      currentfov = currentfov + incfov;
      self setclientdvar("cg_fov", currentfov);
      wait 0.05;
    }

    self setclientdvar("cg_fov", destfov);
  } else {
    self startcameratween(time);
    self setclientdvar("cg_fov", destfov);
  }
}

anim_stopanimscripted(n_blend_time) {
  anim_ent = get_anim_ent();
  anim_ent stopanimscripted(n_blend_time);
  anim_ent notify("single anim", "end");
  anim_ent notify("looping anim", "end");
  anim_ent maps\_anim::_stop_anim_threads();
  anim_ent notify("_anim_stopped");
}

anim_stopscene(n_blend_time) {
  anim_ent = get_anim_ent();
  anim_ent stopanimscripted(n_blend_time);
  anim_ent notify("single anim", "end");
  anim_ent notify("looping anim", "end");
  anim_ent maps\_anim::_stop_anim_threads();
  anim_ent notify("_scene_stopped");
}

get_anim_ent() {
  if(isDefined(self.anim_link)) {
    self.anim_link.animname = self.animname;
    return self.anim_link;
  }

  return self;
}

enable_additive_pain(enable_regular_pain_on_low_health) {
  assert(isai(self), "Enable_additive_pain should be called on AI only.");
  self thread animscripts\pain::additive_pain_think(enable_regular_pain_on_low_health);
}

disable_pain() {
  assert(isalive(self), "Tried to disable pain on a non ai");
  self.a.disablepain = 1;
  self.allowpain = 0;
}

enable_pain() {
  assert(isalive(self), "Tried to enable pain on a non ai");
  self.a.disablepain = 0;
  self.allowpain = 1;
}

disable_react() {
  assert(isalive(self), "Tried to disable react on a non ai");
  self.a.disablereact = 1;
  self.allowreact = 0;
}

enable_react() {
  assert(isalive(self), "Tried to enable react on a non ai");
  self.a.disablereact = 0;
  self.allowreact = 1;
}

enable_rambo() {
  if(isDefined(level.norambo))
    level.norambo = undefined;
}

disable_rambo() {
  level.norambo = 1;
}

die() {
  self dodamage(self.health + 150, (0, 0, 0));
}

is_ads() {
  return self playerads() > 0.5;
}

enable_auto_adjust_threatbias(player) {
  level.auto_adjust_threatbias = 1;
  players = get_players();
  level.coop_player_threatbias_scalar = maps\_gameskill::getcoopvalue("coopFriendlyThreatBiasScalar", players.size);

  if(!isDefined(level.coop_player_threatbias_scalar))
    level.coop_player_threatbias_scalar = 1;

  player.threatbias = int(maps\_gameskill::get_locked_difficulty_val("threatbias", 1) * level.coop_player_threatbias_scalar);
}

disable_auto_adjust_threatbias() {
  level.auto_adjust_threatbias = 0;
}

waittill_player_looking_at(origin, arc_angle_degrees, do_trace, e_ignore) {
  if(!isDefined(arc_angle_degrees))
    arc_angle_degrees = 90;

  arc_angle_degrees = absangleclamp360(arc_angle_degrees);
  dot = cos(arc_angle_degrees * 0.5);

  while(!is_player_looking_at(origin, dot, do_trace, e_ignore))
    wait 0.05;
}

waittill_player_not_looking_at(origin, dot, do_trace) {
  while(is_player_looking_at(origin, dot, do_trace))
    wait 0.05;
}

is_player_looking_at(origin, dot, do_trace, ignore_ent) {
  assert(isPlayer(self), "player_looking_at must be called on a player.");

  if(!isDefined(dot))
    dot = 0.7;

  if(!isDefined(do_trace))
    do_trace = 1;

  eye = self get_eye();
  delta_vec = anglesToForward(vectortoangles(origin - eye));
  view_vec = anglesToForward(self getplayerangles());
  new_dot = vectordot(delta_vec, view_vec);

  if(new_dot >= dot) {
    if(do_trace)
      return bullettracepassed(origin, eye, 0, ignore_ent);
    else
      return 1;
  }

  return 0;
}

look_at(origin_or_ent, tween, force, tag, offset) {
  if(is_true(force))
    self freezecontrols(1);

  if(isDefined(tween))
    self startcameratween(tween);

  self notify("look_at_begin");
  origin = origin_or_ent;

  if(!isvec(origin_or_ent)) {
    ent = origin_or_ent;

    if(isDefined(tag)) {
      origin = ent gettagorigin(tag);
      assert(isDefined(origin), "No tag '" + tag + "' to look at.");
    } else if(isai(origin_or_ent) && !isDefined(offset))
      origin = ent get_eye();
    else
      origin = ent.origin;
  }

  if(isDefined(offset))
    origin = origin + offset;

  player_org = self get_eye();
  vec_to_pt = origin - player_org;
  self setplayerangles(vectortoangles(vec_to_pt));

  if(isDefined(tween))
    wait(tween);

  if(is_true(force))
    self freezecontrols(0);

  self notify("look_at_end");
}

add_wait(func, parm1, parm2, parm3) {
  ent = spawnStruct();
  ent.caller = self;
  ent.func = func;
  ent.parms = [];

  if(isDefined(parm1))
    ent.parms[ent.parms.size] = parm1;

  if(isDefined(parm2))
    ent.parms[ent.parms.size] = parm2;

  if(isDefined(parm3))
    ent.parms[ent.parms.size] = parm3;

  level.wait_any_func_array[level.wait_any_func_array.size] = ent;
}

do_wait_any() {
  assert(isDefined(level.wait_any_func_array), "Tried to do a do_wait without addings funcs first");
  assert(level.wait_any_func_array.size > 0, "Tried to do a do_wait without addings funcs first");
  do_wait(level.wait_any_func_array.size - 1);
}

do_wait(count_to_reach) {
  if(!isDefined(count_to_reach))
    count_to_reach = 0;

  assert(isDefined(level.wait_any_func_array), "Tried to do a do_wait without addings funcs first");
  ent = spawnStruct();
  array = level.wait_any_func_array;
  endons = level.do_wait_endons_array;
  after_array = level.run_func_after_wait_array;
  level.wait_any_func_array = [];
  level.run_func_after_wait_array = [];
  level.do_wait_endons_array = [];
  ent.count = array.size;
  ent array_ent_thread(array, ::waittill_func_ends, endons);

  for(;;) {
    if(ent.count <= count_to_reach) {
      break;
    }

    ent waittill("func_ended");
  }

  ent notify("all_funcs_ended");
  array_ent_thread(after_array, ::exec_func, []);
}

fail_on_friendly_fire() {
  if(!isDefined(level.friendlyfire_friendly_kill_points))
    level.friendlyfire_friendly_kill_points = level.friendlyfire["friend_kill_points"];

  level.friendlyfire["friend_kill_points"] = -60000;
}

giveachievement_wrapper(achievement, all_players) {
  if(achievement == "") {
    return;
  }
  if(iscoopepd()) {
    return;
  }
  if(!maps\_cheat::is_cheating() && !flag("has_cheated")) {
    if(isDefined(all_players) && all_players) {
      players = get_players();

      for(i = 0; i < players.size; i++)
        players[i] giveachievement(achievement);
    } else {
      if(!isPlayer(self)) {
        println("^1self needs to be a player for _utility::giveachievement_wrapper()");

        return;
      }

      self giveachievement(achievement);
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

coopgame() {
  return sessionmodeissystemlink() || (sessionmodeisonlinegame() || issplitscreen());
}

player_is_near_live_grenade() {
  grenades = getEntArray("grenade", "classname");

  for(i = 0; i < grenades.size; i++) {
    grenade = grenades[i];
    players = get_players();

    for(j = 0; j < players.size; j++) {
      if(distancesquared(grenade.origin, players[j].origin) < 62500) {
        maps\_autosave::auto_save_print("autosave failed: live grenade too close to player " + j);

        return true;
      }
    }
  }

  return false;
}

player_died_recently() {
  return getdvarint(#"_id_B93E75EC") > 0;
}

set_splitscreen_fog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, trans_time, cull_dist) {
  if(!issplitscreen()) {
    return;
  }
  if(!isDefined(start_dist) && !isDefined(halfway_dist) && !isDefined(halfway_height) && !isDefined(base_height) && !isDefined(red) && !isDefined(green) && !isDefined(blue))
    level thread default_fog_print();

  if(!isDefined(start_dist))
    start_dist = 0;

  if(!isDefined(halfway_dist))
    halfway_dist = 200;

  if(!isDefined(base_height))
    base_height = -2000;

  if(!isDefined(red))
    red = 1;

  if(!isDefined(green))
    green = 1;

  if(!isDefined(blue))
    blue = 0;

  if(!isDefined(trans_time))
    trans_time = 0;

  if(!isDefined(cull_dist))
    cull_dist = 2000;

  halfway_height = base_height + 2000;
  level.splitscreen_fog = 1;
  setvolfog(start_dist, halfway_dist, halfway_height, base_height, red, green, blue, 0);
  setculldist(cull_dist);
}

default_fog_print() {
  wait_for_first_player();

  iprintlnbold("^3USING DEFAULT FOG SETTINGS FOR SPLITSCREEN");
  wait 8;
  iprintlnbold("^3USING DEFAULT FOG SETTINGS FOR SPLITSCREEN");
  wait 8;
  iprintlnbold("^3USING DEFAULT FOG SETTINGS FOR SPLITSCREEN");
}

get_host() {
  players = get_players("all");

  for(i = 0; i < players.size; i++) {
    if(players[i] getentitynumber() == 0)
      return players[i];
  }
}

any_player_istouching(ent, t) {
  players = [];

  if(isDefined(t))
    players = get_players(t);
  else
    players = get_players();

  for(i = 0; i < players.size; i++) {
    if(isalive(players[i]) && players[i] istouching(ent))
      return true;
  }

  return false;
}

waittill_player_touches(ent) {
  self endon("death");

  while(!self istouching(ent))
    wait 0.05;
}

waittill_player_leaves(ent) {
  self endon("death");

  while(self istouching(ent))
    wait 0.05;
}

get_closest_player(org, t) {
  players = [];

  if(isDefined(t))
    players = get_players(t);
  else
    players = get_players();

  return getclosest(org, players);
}

freezecontrols_all(toggle, delay) {
  if(isDefined(delay))
    wait(delay);

  players = get_players("all");

  for(i = 0; i < players.size; i++)
    players[i] freezecontrols(toggle);
}

player_flag_wait(msg) {
  while(!self.flag[msg])
    self waittill(msg);
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
  while(self.flag[msg])
    self waittill(msg);
}

player_flag_init(message, trigger) {
  if(!isDefined(self.flag)) {
    self.flag = [];
    self.flags_lock = [];
  }

  assert(!isDefined(self.flag[message]), "Attempt to reinitialize existing message: " + message);
  self.flag[message] = 0;

  self.flags_lock[message] = 0;
}

player_flag_set(message) {
  assert(isDefined(self.flag[message]), "Attempt to set a flag before calling flag_init: " + message);
  assert(self.flag[message] == self.flags_lock[message]);
  self.flags_lock[message] = 1;

  self.flag[message] = 1;
  self notify(message);
}

player_flag_clear(message) {
  assert(isDefined(self.flag[message]), "Attempt to set a flag before calling flag_init: " + message);
  assert(self.flag[message] == self.flags_lock[message]);
  self.flags_lock[message] = 0;

  self.flag[message] = 0;
  self notify(message);
}

player_flag(message) {
  assert(isDefined(message), "Tried to check flag but the flag was not defined.");

  if(!self.flag[message])
    return false;

  return true;
}

wait_for_first_player() {
  players = get_players("all");

  if(!isDefined(players) || players.size == 0)
    level waittill("first_player_ready");
}

wait_for_all_players() {
  flag_wait("all_players_connected");
}

findboxcenter(mins, maxs) {
  center = (0, 0, 0);
  center = maxs - mins;
  center = (center[0] / 2, center[1] / 2, center[2] / 2) + mins;
  return center;
}

expandmins(mins, point) {
  if(mins[0] > point[0])
    mins = (point[0], mins[1], mins[2]);

  if(mins[1] > point[1])
    mins = (mins[0], point[1], mins[2]);

  if(mins[2] > point[2])
    mins = (mins[0], mins[1], point[2]);

  return mins;
}

expandmaxs(maxs, point) {
  if(maxs[0] < point[0])
    maxs = (point[0], maxs[1], maxs[2]);

  if(maxs[1] < point[1])
    maxs = (maxs[0], point[1], maxs[2]);

  if(maxs[2] < point[2])
    maxs = (maxs[0], maxs[1], point[2]);

  return maxs;
}

get_ai_touching_volume(team, volume_name, volume) {
  if(!isDefined(volume)) {
    volume = getent(volume_name, "targetname");
    assert(isDefined(volume), volume_name + " does not exist");
  }

  guys = getaiarray(team);
  guys_touching_volume = [];

  for(i = 0; i < guys.size; i++) {
    if(guys[i] istouching(volume))
      guys_touching_volume[guys_touching_volume.size] = guys[i];
  }

  return guys_touching_volume;
}

get_ai_touching(str_team, str_species) {
  if(!isDefined(str_team))
    str_team = "all";

  if(!isDefined(str_species))
    str_species = "all";

  ai_potential = getaispeciesarray(str_team, str_species);
  a_ai_touching = [];

  foreach(ai in ai_potential) {
    if(ai istouching(self))
      a_ai_touching[a_ai_touching.size] = ai;
  }

  return a_ai_touching;
}

registerclientsys(ssysname) {
  if(!isDefined(level._clientsys))
    level._clientsys = [];

  if(level._clientsys.size >= 32) {
    error("Max num client systems exceeded.");

    return;
  }

  if(isDefined(level._clientsys[ssysname])) {
    error("Attempt to re-register client system : " + ssysname);

    return;
  } else {
    level._clientsys[ssysname] = spawnStruct();
    level._clientsys[ssysname].sysid = clientsysregister(ssysname);

    println("registered client system " + ssysname + " to id " + level._clientsys[ssysname].sysid);
  }
}

setclientsysstate(ssysname, ssysstate, player) {
  if(!isDefined(level._clientsys)) {
    error("setClientSysState called before registration of any systems.");

    return;
  }

  if(!isDefined(level._clientsys[ssysname])) {
    error("setClientSysState called on unregistered system " + ssysname);

    return;
  }

  if(isDefined(player))
    player clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
  else {
    clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
    level._clientsys[ssysname].sysstate = ssysstate;

    println("set client system " + ssysname + "(" + level._clientsys[ssysname].sysid + ")" + " to " + ssysstate);
  }
}

wait_network_frame() {
  if(numremoteclients()) {
    snapshot_ids = getsnapshotindexarray();

    for(acked = undefined; !isDefined(acked); acked = snapshotacknowledged(snapshot_ids))
      level waittill("snapacknowledged");
  } else
    wait 0.1;
}

clientnotify(event) {
  if(level.clientscripts) {
    if(isPlayer(self))
      maps\_utility::setclientsysstate("levelNotify", event, self);
    else
      maps\_utility::setclientsysstate("levelNotify", event);
  }
}

ok_to_spawn(max_wait_seconds) {
  if(isDefined(max_wait_seconds)) {
    timer = gettime() + max_wait_seconds * 1000;

    while(gettime() < timer && !oktospawn())
      wait 0.05;
  } else {
    while(!oktospawn())
      wait 0.05;
  }
}

set_breadcrumbs(starts) {
  if(!isDefined(level._player_breadcrumbs))
    maps\_callbackglobal::player_breadcrumb_reset((0, 0, 0));

  for(i = 0; i < starts.size; i++) {
    for(j = 0; j < starts.size; j++) {
      level._player_breadcrumbs[i][j].pos = starts[j].origin;

      if(isDefined(starts[j].angles)) {
        level._player_breadcrumbs[i][j].ang = starts[j].angles;
        continue;
      }

      level._player_breadcrumbs[i][j].ang = (0, 0, 0);
    }
  }
}

set_breadcrumbs_player_positions() {
  if(!isDefined(level._player_breadcrumbs))
    maps\_callbackglobal::player_breadcrumb_reset((0, 0, 0));

  players = get_players();

  for(i = 0; i < players.size; i++) {
    level._player_breadcrumbs[i][0].pos = players[i].origin;
    level._player_breadcrumbs[i][0].ang = players[i].angles;
  }
}

spread_array_thread(entities, process, var1, var2, var3) {
  keys = getarraykeys(entities);

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
  assert(spawners.size, "no spawners with targetname " + name + " found!");

  if(isDefined(spawn_func)) {
    for(i = 0; i < spawners.size; i++)
      spawners[i] add_spawn_function(spawn_func);
  }

  if(isDefined(spawn_func_2)) {
    for(i = 0; i < spawners.size; i++)
      spawners[i] add_spawn_function(spawn_func_2);
  }

  for(i = 0; i < spawners.size; i++) {
    if(i % 2)
      wait_network_frame();

    spawners[i] thread maps\_spawner::flood_spawner_init();
    spawners[i] thread maps\_spawner::flood_spawner_think();
  }
}

simple_spawn(name_or_spawners, spawn_func, param1, param2, param3, param4, param5, bforce) {
  spawners = [];

  if(isstring(name_or_spawners)) {
    spawners = getEntArray(name_or_spawners, "targetname");
    assert(spawners.size, "no spawners with targetname " + name_or_spawners + " found!");
  } else if(isarray(name_or_spawners))
    spawners = name_or_spawners;
  else
    spawners[0] = name_or_spawners;

  ai_array = [];

  for(i = 0; i < spawners.size; i++) {
    while(isDefined(spawners[i].spawning) && spawners[i].spawning)
      wait_network_frame();

    spawners[i].spawning = 1;

    if(i % 2)
      wait_network_frame();

    if(isDefined(spawners[i].script_drone) && spawners[i].script_drone)
      ai = spawners[i] spawn_drone();
    else
      ai = spawners[i] spawn_ai(bforce);

    spawners[i].spawning = undefined;

    if(!isDefined(ai) || !isalive(ai)) {
      continue;
    }
    if(isDefined(spawn_func))
      single_thread(ai, spawn_func, param1, param2, param3, param4, param5);

    ai_array[ai_array.size] = ai;
  }

  return ai_array;
}

simple_spawn_single(name_or_spawner, spawn_func, param1, param2, param3, param4, param5, bforce) {
  if(isstring(name_or_spawner)) {
    spawner = getent(name_or_spawner, "targetname");
    assert(isDefined(spawner), "no spawner with targetname " + name_or_spawner + " found!");
  } else if(isarray(name_or_spawner))
    assertmsg("simple_spawn_single cannot be used on an array of spawners.use simple_spawn instead.");

  ai = simple_spawn(name_or_spawner, spawn_func, param1, param2, param3, param4, param5, bforce);
  assert(ai.size <= 1, "simple_spawn called from simple_spawn_single somehow spawned more than one guy!");

  if(ai.size)
    return ai[0];
}

canspawnthink() {
  level.canspawninoneframe = 3;

  for(;;) {
    level.canspawncount = 0;
    wait_network_frame();
  }
}

canspawn() {
  if(!isDefined(level.canspawninoneframe))
    thread canspawnthink();

  return true;
}

spawnthrottleenablethread() {
  level notify("spawn_throttle_enable_thread_ender");
  level endon("spawn_throttle_enable_thread_ender");

  if(isDefined(level.flag["all_players_connected"])) {
    flag_wait("all_players_connected");
    level.spawnthrottleenable = 1;
  }
}

spawnthrottleenable() {
  if(!isDefined(level.spawnthrottleenable) || isDefined(level.spawnthrottleenable) && level.spawnthrottleenable == 0) {
    level.spawnthrottleenable = 0;
    thread spawnthrottleenablethread();
  }

  return level.spawnthrottleenable;
}

dospawn(noenemyinfo, targetname, nothreatupdate) {
  if(spawnthrottleenable()) {
    while(!canspawn())
      wait_network_frame();
  }

  if(isDefined(level.canspawncount))
    level.canspawncount = level.canspawncount + 1;

  if(!isDefined(noenemyinfo))
    noenemyinfo = 0;

  if(!isDefined(nothreatupdate))
    nothreatupdate = 0;

  return self codespawnerspawn(noenemyinfo, targetname, nothreatupdate);
}

stalingradspawn(noenemyinfo, targetname, nothreatupdate) {
  if(spawnthrottleenable()) {
    while(!canspawn())
      wait_network_frame();
  }

  if(isDefined(level.canspawncount))
    level.canspawncount = level.canspawncount + 1;

  if(!isDefined(noenemyinfo))
    noenemyinfo = 0;

  if(!isDefined(nothreatupdate))
    nothreatupdate = 0;

  return self codespawnerforcespawn(noenemyinfo, targetname, nothreatupdate);
}

spawn(classname, origin, flags, radius, height, destructibledef) {
  if(spawnthrottleenable()) {
    while(!canspawn())
      wait_network_frame();
  }

  if(isDefined(level.canspawncount))
    level.canspawncount = level.canspawncount + 1;

  if(isDefined(destructibledef))
    return codespawn(classname, origin, flags, radius, height, destructibledef);
  else if(isDefined(height))
    return codespawn(classname, origin, flags, radius, height);
  else if(isDefined(radius))
    return codespawn(classname, origin, flags, radius);
  else if(isDefined(flags))
    return codespawn(classname, origin, flags);
  else
    return codespawn(classname, origin);
}

spawnvehicle(modelname, targetname, vehicletype, origin, angles, destructibledef) {
  if(spawnthrottleenable()) {
    while(!canspawn())
      wait_network_frame();
  }

  if(isDefined(level.canspawncount))
    level.canspawncount = level.canspawncount + 1;

  assert(isDefined(targetname));
  assert(isDefined(vehicletype));
  assert(isDefined(origin));
  assert(isDefined(angles));

  if(isDefined(destructibledef))
    return codespawnvehicle(modelname, targetname, vehicletype, origin, angles, destructibledef);
  else
    return codespawnvehicle(modelname, targetname, vehicletype, origin, angles);
}

spawnturret(classname, origin, weaponinfoname) {
  if(spawnthrottleenable()) {
    while(!canspawn())
      wait_network_frame();
  }

  if(isDefined(level.canspawncount))
    level.canspawncount = level.canspawncount + 1;

  return codespawnturret(classname, origin, weaponinfoname);
}

playloopedfx(effectid, repeat, position, cull, forward, up, primlightfrac, lightoriginoffs) {
  if(spawnthrottleenable()) {
    while(!canspawn())
      wait_network_frame();
  }

  if(isDefined(level.canspawncount))
    level.canspawncount = level.canspawncount + 1;

  if(isDefined(lightoriginoffs))
    return codeplayloopedfx(effectid, repeat, position, cull, forward, up, primlightfrac, lightoriginoffs);
  else if(isDefined(primlightfrac))
    return codeplayloopedfx(effectid, repeat, position, cull, forward, up, primlightfrac);
  else if(isDefined(up))
    return codeplayloopedfx(effectid, repeat, position, cull, forward, up);
  else if(isDefined(forward))
    return codeplayloopedfx(effectid, repeat, position, cull, forward);
  else if(isDefined(cull))
    return codeplayloopedfx(effectid, repeat, position, cull);
  else
    return codeplayloopedfx(effectid, repeat, position);
}

spawnfx(effect, position, forward, up, primlightfrac, lightoriginoffs) {
  if(spawnthrottleenable()) {
    while(!canspawn())
      wait_network_frame();
  }

  if(isDefined(level.canspawncount))
    level.canspawncount = level.canspawncount + 1;

  if(isDefined(lightoriginoffs))
    return codespawnfx(effect, position, forward, up, primlightfrac, lightoriginoffs);
  else if(isDefined(primlightfrac))
    return codespawnfx(effect, position, forward, up, primlightfrac);
  else if(isDefined(up))
    return codespawnfx(effect, position, forward, up);
  else if(isDefined(forward))
    return codespawnfx(effect, position, forward);
  else
    return codespawnfx(effect, position);
}

spawn_model(model_name, origin, angles, n_spawnflags) {
  if(!isDefined(n_spawnflags))
    n_spawnflags = 0;

  if(!isDefined(origin))
    origin = (0, 0, 0);

  model = spawn("script_model", origin, n_spawnflags);
  model setModel(model_name);

  if(isDefined(angles))
    model.angles = angles;

  return model;
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
  self thread maps\_vehicle::turret_shoot();
}

set_switch_node(src_node, dst_node) {
  assert(isDefined(src_node));
  assert(isDefined(dst_node));
  self.bswitchingnodes = 1;
  self.dst_node = dst_node;
  self setswitchnode(src_node, dst_node);
}

veh_toggle_tread_fx(on) {
  if(!on)
    self setclientflag(6);
  else
    self clearclientflag(6);
}

veh_toggle_exhaust_fx(on) {
  if(!on)
    self setclientflag(8);
  else
    self clearclientflag(8);
}

veh_toggle_lights(on) {
  if(on)
    self setclientflag(10);
  else
    self clearclientflag(10);
}

vehicle_toggle_sounds(on) {
  if(!on)
    self setclientflag(2);
  else
    self clearclientflag(2);
}

spawn_manager_set_global_active_count(cnt) {
  assert(cnt <= 32, "Max number of Active AI at a given time cant be more than 32");
  level.spawn_manager_max_ai = cnt;
}

sm_use_trig_when_complete(spawn_manager_targetname, trig_name, trig_key, once_only) {
  self thread sm_use_trig_when_complete_internal(spawn_manager_targetname, trig_name, trig_key, once_only);
}

sm_use_trig_when_complete_internal(spawn_manager_targetname, trig_name, trig_key, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getent(trig_name, trig_key);
    assert(isDefined(trigger), "The trigger " + trig_key + " / " + trig_name + " does not exist.");
    trigger endon("trigger");
  }

  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    flag_wait("sm_" + spawn_manager_targetname + "_complete");
    trigger_use(trig_name, trig_key);
  } else
    assertmsg("sm_use_trig_when_complete: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

sm_use_trig_when_cleared(spawn_manager_targetname, trig_name, trig_key, once_only) {
  self thread sm_use_trig_when_cleared_internal(spawn_manager_targetname, trig_name, trig_key, once_only);
}

sm_use_trig_when_cleared_internal(spawn_manager_targetname, trig_name, trig_key, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getent(trig_name, trig_key);
    assert(isDefined(trigger), "The trigger " + trig_key + " / " + trig_name + " does not exist.");
    trigger endon("trigger");
  }

  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    flag_wait("sm_" + spawn_manager_targetname + "_cleared");
    trigger_use(trig_name, trig_key);
  } else
    assertmsg("sm_use_trig_when_cleared: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

sm_use_trig_when_enabled(spawn_manager_targetname, trig_name, trig_key, once_only) {
  self thread sm_use_trig_when_enabled_internal(spawn_manager_targetname, trig_name, trig_key, once_only);
}

sm_use_trig_when_enabled_internal(spawn_manager_targetname, trig_name, trig_key, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getent(trig_name, trig_key);
    assert(isDefined(trigger), "The trigger " + trig_key + " / " + trig_name + " does not exist.");
    trigger endon("trigger");
  }

  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    flag_wait("sm_" + spawn_manager_targetname + "_enabled");
    trigger_use(trig_name, trig_key);
  } else
    assertmsg("sm_use_trig_when_cleared: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

sm_run_func_when_complete(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  self thread sm_run_func_when_complete_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5);
}

sm_run_func_when_complete_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  assert(isDefined(process), "sm_run_func_when_complete: the function is not defined");
  assert(level flag_exists("sm_" + spawn_manager_targetname + "_enabled"), "sm_run_func_when_complete: Spawn manager '" + spawn_manager_targetname + "' not found.");
  waittill_spawn_manager_complete(spawn_manager_targetname);
  single_func(ent, process, var1, var2, var3, var4, var5);
}

sm_run_func_when_cleared(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  self thread sm_run_func_when_cleared_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5);
}

sm_run_func_when_cleared_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  assert(isDefined(process), "sm_run_func_when_cleared: the function is not defined");
  assert(level flag_exists("sm_" + spawn_manager_targetname + "_enabled"), "sm_run_func_when_cleared: Spawn manager '" + spawn_manager_targetname + "' not found.");
  waittill_spawn_manager_cleared(spawn_manager_targetname);
  single_func(ent, process, var1, var2, var3, var4, var5);
}

sm_run_func_when_enabled(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  self thread sm_run_func_when_enabled_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5);
}

sm_run_func_when_enabled_internal(spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5) {
  assert(isDefined(process), "sm_run_func_when_enabled: the function is not defined");
  assert(level flag_exists("sm_" + spawn_manager_targetname + "_enabled"), "sm_run_func_when_enabled: Spawn manager '" + spawn_manager_targetname + "' not found.");
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
  } else if(!is_true(no_assert))
    assertmsg("spawn_manager_enable: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

spawn_manager_disable(spawn_manager_targetname, no_assert) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    for(i = 0; i < level.spawn_managers.size; i++) {
      if(level.spawn_managers[i].sm_id == spawn_manager_targetname) {
        level.spawn_managers[i] notify("disable");
        return;
      }
    }
  } else if(!is_true(no_assert))
    assertmsg("spawn_manager_disable: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

spawn_manager_kill(spawn_manager_targetname, no_assert) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    for(i = 0; i < level.spawn_managers.size; i++) {
      if(level.spawn_managers[i].sm_id == spawn_manager_targetname) {
        level.spawn_managers[i] notify("kill");
        return;
      }
    }
  } else if(!is_true(no_assert))
    assertmsg("spawn_manager_kill: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

is_spawn_manager_enabled(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(flag("sm_" + spawn_manager_targetname + "_enabled"))
      return true;

    return false;
  } else
    assertmsg("is_spawn_manager_enabled: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

is_spawn_manager_complete(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(flag("sm_" + spawn_manager_targetname + "_complete"))
      return true;

    return false;
  } else
    assertmsg("is_spawn_manager_complete: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

is_spawn_manager_cleared(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(flag("sm_" + spawn_manager_targetname + "_cleared"))
      return true;

    return false;
  } else
    assertmsg("is_spawn_manager_cleared: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

is_spawn_manager_killed(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled")) {
    if(flag("sm_" + spawn_manager_targetname + "_killed"))
      return true;

    return false;
  } else
    assertmsg("is_spawn_manager_killed: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

waittill_spawn_manager_cleared(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled"))
    flag_wait("sm_" + spawn_manager_targetname + "_cleared");
  else
    assertmsg("waittill_spawn_manager_cleared: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

waittill_spawn_manager_ai_remaining(spawn_manager_targetname, count_to_reach) {
  assert(isDefined(count_to_reach), "# of AI remaining not specified in _utility::waittill_spawn_manager_ai_remaining()");
  assert(count_to_reach, "# of AI remaining specified in _utility::waittill_spawn_manager_ai_remaining() is 0, use waittill_spawn_manager_cleared");

  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled"))
    flag_wait("sm_" + spawn_manager_targetname + "_complete");
  else
    assertmsg("waittill_spawn_manager_ai_remaining: Spawn manager '" + spawn_manager_targetname + "' not found.");

  if(flag("sm_" + spawn_manager_targetname + "_cleared")) {
    return;
  }
  spawn_manager = maps\_spawn_manager::get_spawn_manager_array(spawn_manager_targetname);
  assert(spawn_manager.size, "Somehow the spawn manager doesnt exist, but related flag existed before.");
  assert(spawn_manager.size == 1, "Found two spawn managers with same targetname.");

  while(isDefined(spawn_manager[0]) && spawn_manager[0].activeai.size > count_to_reach)
    wait 0.1;
}

waittill_spawn_manager_complete(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled"))
    flag_wait("sm_" + spawn_manager_targetname + "_complete");
  else
    assertmsg("waittill_spawn_manager_complete: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

waittill_spawn_manager_enabled(spawn_manager_targetname) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled"))
    flag_wait("sm_" + spawn_manager_targetname + "_enabled");
  else
    assertmsg("waittill_spawn_manager_enabled: Spawn manager '" + spawn_manager_targetname + "' not found.");
}

waittill_spawn_manager_spawned_count(spawn_manager_targetname, count) {
  if(level flag_exists("sm_" + spawn_manager_targetname + "_enabled"))
    flag_wait("sm_" + spawn_manager_targetname + "_enabled");
  else
    assertmsg("waittill_spawn_manager_spawned_count: Spawn manager '" + spawn_manager_targetname + "' not found.");

  spawn_manager = maps\_spawn_manager::get_spawn_manager_array(spawn_manager_targetname);
  assert(spawn_manager.size, "Somehow the spawn manager doesnt exist, but related flag existed before.");
  assert(spawn_manager.size == 1, "Found two spawn managers with same targetname.");
  assert(spawn_manager[0].count > count, "waittill_spawn_manager_spawned_count : Count should be less than total count on the spawn manager.");
  original_count = spawn_manager[0].count;

  while(true) {
    if(isDefined(spawn_manager[0].spawncount) && spawn_manager[0].spawncount < count && !is_spawn_manager_killed(spawn_manager_targetname))
      wait 0.5;
    else
      break;
  }
}

get_ai_from_spawn_manager(spawn_manager_targetname, no_assert) {
  if(!isDefined(no_assert))
    no_assert = 0;

  sm = getent(spawn_manager_targetname, "targetname");

  if(!isDefined(sm)) {
    for(i = 0; i < level.spawn_managers.size; i++) {
      if(level.spawn_managers[i].sm_id == spawn_manager_targetname) {
        sm = level.spawn_managers[i];
        break;
      }
    }
  }

  if(!no_assert)
    assert(isDefined(sm), "Spawn manager: " + spawn_manager_targetname + " does not exist.");

  if(!isDefined(sm))
    return [];

  a_spawners = getEntArray(sm.target, "targetname");
  a_ai = [];

  foreach(spawner in a_spawners) {
    a_guys = getEntArray(spawner.targetname + "_ai", "targetname");

    if(a_guys.size > 0)
      a_ai = arraycombine(a_ai, a_guys, 1, 0);
  }

  return a_ai;
}

veh_magic_bullet_shield(on) {
  if(!isDefined(on))
    on = 1;

  assert(!isai(self), "This is for vehicles, please use magic_bullet_shield for AI.");
  assert(!isPlayer(self), "This is for vehicles, please use magic_bullet_shield for players.");
  self.magic_bullet_shield = on ? 1 : undefined;
}

onfirstplayerconnect_callback(func) {
  maps\_callbackglobal::addcallback("on_first_player_connect", func);
}

onfirstplayerconnect_callbackremove(func) {
  maps\_callbackglobal::removecallback("on_first_player_connect", func);
}

onplayerconnect_callback(func) {
  maps\_callbackglobal::addcallback("on_player_connect", func);
}

onplayerconnect_callbackremove(func) {
  maps\_callbackglobal::removecallback("on_player_connect", func);
}

onplayerdisconnect_callback(func) {
  maps\_callbackglobal::addcallback("on_player_disconnect", func);
}

onplayerdisconnect_callbackremove(func) {
  maps\_callbackglobal::removecallback("on_player_disconnect", func);
}

onplayerdamage_callback(func) {
  maps\_callbackglobal::addcallback("on_player_damage", func);
}

onplayerdamage_callbackremove(func) {
  maps\_callbackglobal::removecallback("on_player_damage", func);
}

onplayerlaststand_callback(func) {
  maps\_callbackglobal::addcallback("on_player_last_stand", func);
}

onplayerlaststand_callbackremove(func) {
  maps\_callbackglobal::removecallback("on_player_last_stand", func);
}

onplayerkilled_callback(func) {
  maps\_callbackglobal::addcallback("on_player_killed", func);
}

onplayerkilled_callbackremove(func) {
  maps\_callbackglobal::removecallback("on_player_killed", func);
}

onactordamage_callback(func) {
  maps\_callbackglobal::addcallback("on_actor_damage", func);
}

onactordamage_callbackremove(func) {
  maps\_callbackglobal::removecallback("on_actor_damage", func);
}

onactorkilled_callback(func) {
  maps\_callbackglobal::addcallback("on_actor_killed", func);
}

onactorkilled_callbackremove(func) {
  maps\_callbackglobal::removecallback("on_actor_killed", func);
}

onvehicledamage_callback(func) {
  maps\_callbackglobal::addcallback("on_vehicle_damage", func);
}

onvehicledamage_callbackremove(func) {
  maps\_callbackglobal::removecallback("on_vehicle_damage", func);
}

onsaverestored_callback(func) {
  maps\_callbackglobal::addcallback("on_save_restored", func);
}

onsaverestored_callbackremove(func) {
  maps\_callbackglobal::removecallback("on_save_restored", func);
}

aim_at_target(target, duration) {
  self endon("death");
  self endon("stop_aim_at_target");
  assert(isDefined(target));

  if(!isDefined(target)) {
    return;
  }
  self setentitytarget(target);
  self.a.allow_shooting = 0;

  if(isDefined(duration) && duration > 0) {
    elapsed = 0;

    while(elapsed < duration) {
      elapsed = elapsed + 0.05;
      wait 0.05;
    }

    stop_aim_at_target();
  }
}

stop_aim_at_target() {
  self clearentitytarget();
  self.a.allow_shooting = 1;
  self notify("stop_aim_at_target");
}

shoot_at_target(target, tag, firedelay, duration) {
  self endon("death");
  self endon("stop_shoot_at_target");
  assert(isDefined(target), "shoot_at_target was passed an undefined target");

  if(!isDefined(target) || (!isDefined(duration) && !isDefined(-1) || isDefined(duration) && isDefined(-1) && duration == -1) && target.health <= 0) {
    return;
  }
  if(isDefined(tag) && tag != "" && tag != "tag_eye" && tag != "tag_head")
    self setentitytarget(target, 1, tag);
  else
    self setentitytarget(target);

  self animscripts\weaponlist::refillclip();

  if(isDefined(firedelay) && firedelay > 0) {
    self.a.allow_shooting = 0;
    wait(firedelay);
  }

  self.a.allow_shooting = 1;
  self.cansee_override = 1;
  self animscripts\shoot_behavior::setshootent(target);
  self waittill("shoot");

  if(isDefined(duration)) {
    if(duration > 0) {
      elapsed = 0;

      while(elapsed < duration) {
        elapsed = elapsed + 0.05;
        wait 0.05;
      }
    } else if(duration == -1)
      target waittill("death");
  }

  stop_shoot_at_target();
}

shoot_at_target_untill_dead(target, tag, firedelay) {
  shoot_at_target(target, tag, firedelay, -1);
}

shoot_and_kill(e_enemy, n_fire_delay) {
  self endon("death");
  self.old_perfectaim = self.perfectaim;
  self.perfectaim = 1;
  self shoot_at_target(e_enemy, "J_head", n_fire_delay, -1);
  self.perfectaim = self.old_perfectaim;
  self.old_pefectaim = undefined;
  self notify("enemy_killed");
}

stop_shoot_at_target() {
  self clearentitytarget();
  self.cansee_override = 0;
  self notify("stop_shoot_at_target");
}

add_trigger_to_ent(ent) {
  if(!isDefined(ent._triggers))
    ent._triggers = [];

  ent._triggers[self getentitynumber()] = 1;
}

remove_trigger_from_ent(ent) {
  if(!isDefined(ent._triggers)) {
    return;
  }
  if(!isDefined(ent._triggers[self getentitynumber()])) {
    return;
  }
  ent._triggers[self getentitynumber()] = 0;
}

ent_already_in_trigger(trig) {
  if(!isDefined(self._triggers))
    return false;

  if(!isDefined(self._triggers[trig getentitynumber()]))
    return false;

  if(!self._triggers[trig getentitynumber()])
    return false;

  return true;
}

trigger_thread(ent, on_enter_payload, on_exit_payload) {
  ent endon("entityshutdown");
  ent endon("death");

  if(ent ent_already_in_trigger(self)) {
    return;
  }
  self add_trigger_to_ent(ent);
  endon_condition = "leave_trigger_" + self getentitynumber();

  if(isDefined(on_enter_payload))
    self thread[[on_enter_payload]](ent, endon_condition);

  while(isDefined(ent) && ent istouching(self))
    wait 0.01;

  ent notify(endon_condition);

  if(isDefined(ent) && isDefined(on_exit_payload))
    self thread[[on_exit_payload]](ent);

  if(isDefined(ent))
    self remove_trigger_from_ent(ent);
}

delete_ents(mask, origin, radius) {
  ents = entsearch(mask, origin, radius);

  for(i = 0; i < ents.size; i++)
    ents[i] delete();
}

set_drop_weapon(weapon_name) {
  assert(isDefined(weapon_name) && isstring(weapon_name), "_utility::set_drop_weapon: Invalid weapon name!");
  self.script_dropweapon = weapon_name;
}

take_and_giveback_weapons(mynotify, no_autoswitch) {
  take_weapons();
  self waittill(mynotify);
  give_weapons(no_autoswitch);
}

take_weapons() {
  self.curweapon = self getcurrentweapon();
  self.weapons_list = self getweaponslist();
  self.offhand = self getcurrentoffhand();
  weapon_list_modified = [];

  for(i = 0; i < self.weapons_list.size; i++) {
    if(!is_weapon_attachment(self.weapons_list[i]))
      weapon_list_modified[weapon_list_modified.size] = self.weapons_list[i];
  }

  self.weapons_list = weapon_list_modified;

  if(is_weapon_attachment(self.curweapon))
    self.curweapon = get_baseweapon_for_attachment(self.curweapon);

  self.weapons_info = [];

  for(i = 0; i < self.weapons_list.size; i++) {
    self.weapons_info[i] = spawnStruct();

    if(isDefined(self.offhand) && self.weapons_list[i] == self.offhand) {
      self.weapons_info[i]._ammo = 0;
      self.weapons_info[i]._stock = self getweaponammostock(self.weapons_list[i]);
      continue;
    }

    self.weapons_info[i]._ammo = self getweaponammoclip(self.weapons_list[i]);
    self.weapons_info[i]._stock = self getweaponammostock(self.weapons_list[i]);
    self.weapons_info[i]._renderoptions = self getweaponrenderoptions(self.weapons_list[i]);
  }

  self takeallweapons();
}

give_weapons(no_autoswitch) {
  if(!isDefined(self.weapons_list)) {
    return;
  }
  for(i = 0; i < self.weapons_list.size; i++) {
    if(isDefined(self.weapons_info[i]._renderoptions))
      self giveweapon(self.weapons_list[i], 0, self.weapons_info[i]._renderoptions);
    else
      self giveweapon(self.weapons_list[i]);

    self setweaponammoclip(self.weapons_list[i], self.weapons_info[i]._ammo);
    self setweaponammostock(self.weapons_list[i], self.weapons_info[i]._stock);
  }

  self.weapons_info = undefined;

  if(isDefined(self.curweapon) && !isDefined(no_autoswitch)) {
    if(self.curweapon != "none")
      self switchtoweapon(self.curweapon);
    else {
      str_primary = "";

      foreach(str_weapon in self.weapons_list) {
        if(weaponinventorytype(str_weapon) == "primary") {
          str_primary = str_weapon;

          if(weaponclass(str_weapon) != "pistol") {
            break;
          }
        }
      }

      if(str_primary != "")
        self switchtoweapon(str_primary);
    }
  }
}

is_weapon_attachment(weapon_name) {
  weapon_pieces = strtok(weapon_name, "_");

  if(weapon_pieces[0] == "ft" || weapon_pieces[0] == "mk" || weapon_pieces[0] == "gl")
    return true;

  return false;
}

get_baseweapon_for_attachment(weapon_name) {
  assert(is_weapon_attachment(weapon_name));
  weapon_pieces = strtok(weapon_name, "_");
  attachment = weapon_pieces[0];
  assert(weapon_pieces[0] == "ft" || weapon_pieces[0] == "mk" || weapon_pieces[0] == "gl" || weapon_pieces[0] == "db");
  weapon = weapon_pieces[1];
  assert(weapon_pieces[1] != "ft" && weapon_pieces[1] != "mk" && weapon_pieces[1] != "gl" && weapon_pieces[1] != "db");

  for(i = 0; i < self.weapons_list.size; i++) {
    if(issubstr(self.weapons_list[i], weapon) && issubstr(self.weapons_list[i], attachment))
      return self.weapons_list[i];
  }

  return self.weapons_list[0];
}

screen_message_create(string_message_1, string_message_2, string_message_3, n_offset_y, n_time) {
  level notify("screen_message_create");
  level endon("screen_message_create");

  if(isDefined(level.missionfailed) && level.missionfailed) {
    return;
  }
  if(getdvarint(#"_id_5193604C") == 1) {
    return;
  }
  if(!isDefined(n_offset_y))
    n_offset_y = 0;

  if(!isDefined(level._screen_message_1)) {
    level._screen_message_1 = newhudelem();
    level._screen_message_1.elemtype = "font";
    level._screen_message_1.font = "objective";
    level._screen_message_1.fontscale = 1.8;
    level._screen_message_1.horzalign = "center";
    level._screen_message_1.vertalign = "middle";
    level._screen_message_1.alignx = "center";
    level._screen_message_1.aligny = "middle";
    level._screen_message_1.y = -60 + n_offset_y;
    level._screen_message_1.sort = 2;
    level._screen_message_1.color = (1, 1, 1);
    level._screen_message_1.alpha = 1;
    level._screen_message_1.hidewheninmenu = 1;
  }

  level._screen_message_1 settext(string_message_1);

  if(isDefined(string_message_2)) {
    if(!isDefined(level._screen_message_2)) {
      level._screen_message_2 = newhudelem();
      level._screen_message_2.elemtype = "font";
      level._screen_message_2.font = "objective";
      level._screen_message_2.fontscale = 1.8;
      level._screen_message_2.horzalign = "center";
      level._screen_message_2.vertalign = "middle";
      level._screen_message_2.alignx = "center";
      level._screen_message_2.aligny = "middle";
      level._screen_message_2.y = -33 + n_offset_y;
      level._screen_message_2.sort = 2;
      level._screen_message_2.color = (1, 1, 1);
      level._screen_message_2.alpha = 1;
      level._screen_message_2.hidewheninmenu = 1;
    }

    level._screen_message_2 settext(string_message_2);
  } else if(isDefined(level._screen_message_2))
    level._screen_message_2 destroy();

  if(isDefined(string_message_3)) {
    if(!isDefined(level._screen_message_3)) {
      level._screen_message_3 = newhudelem();
      level._screen_message_3.elemtype = "font";
      level._screen_message_3.font = "objective";
      level._screen_message_3.fontscale = 1.8;
      level._screen_message_3.horzalign = "center";
      level._screen_message_3.vertalign = "middle";
      level._screen_message_3.alignx = "center";
      level._screen_message_3.aligny = "middle";
      level._screen_message_3.y = -6 + n_offset_y;
      level._screen_message_3.sort = 2;
      level._screen_message_3.color = (1, 1, 1);
      level._screen_message_3.alpha = 1;
      level._screen_message_3.hidewheninmenu = 1;
    }

    level._screen_message_3 settext(string_message_3);
  } else if(isDefined(level._screen_message_3))
    level._screen_message_3 destroy();

  if(isDefined(n_time) && n_time > 0) {
    wait(n_time);
    screen_message_delete();
  }
}

screen_message_delete(delay) {
  if(isDefined(delay))
    wait(delay);

  if(isDefined(level._screen_message_1))
    level._screen_message_1 destroy();

  if(isDefined(level._screen_message_2))
    level._screen_message_2 destroy();

  if(isDefined(level._screen_message_3))
    level._screen_message_3 destroy();
}

get_eye() {
  if(isPlayer(self)) {
    linked_ent = self getlinkedent();

    if(isDefined(linked_ent) && getdvarint(#"_id_5AEFD7E9") > 0) {
      camera = linked_ent gettagorigin("tag_camera");

      if(isDefined(camera))
        return camera;
    }
  }

  pos = self getEye();
  return pos;
}

vehicle_node_wait(strname, strkey) {
  if(!isDefined(strkey))
    strkey = "targetname";

  nodes = getvehiclenodearray(strname, strkey);
  assert(isDefined(nodes) && nodes.size > 0, "_utility::vehicle_node_wait - vehicle node not found: " + strname + " key: " + strkey);
  ent = spawnStruct();
  array_thread(nodes, common_scripts\utility::_trigger_wait_think, ent);
  ent waittill("trigger", eother, node_hit);
  level notify(strname, eother);

  if(isDefined(node_hit)) {
    node_hit.who = eother;
    return node_hit;
  } else
    return eother;
}

timescale_tween(start, end, time, delay, step_time) {
  if(!isDefined(delay))
    delay = 0.0;

  if(!isDefined(step_time))
    step_time = 0.1;

  if(!isDefined(start))
    start = gettimescale();

  num_steps = time / step_time;
  time_scale_range = end - start;
  time_scale_step = 0;

  if(num_steps > 0)
    time_scale_step = abs(time_scale_range) / num_steps;

  if(delay > 0.0)
    wait(delay);

  level notify("timescale_tween");
  level endon("timescale_tween");
  time_scale = start;
  settimescale(time_scale);

  while(time_scale != end) {
    wait(step_time);

    if(time_scale_range > 0)
      time_scale = min(time_scale + time_scale_step, end);
    else if(time_scale_range < 0)
      time_scale = max(time_scale - time_scale_step, end);

    settimescale(time_scale);
  }
}

depth_of_field_tween(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur, n_time, n_step_time) {
  self notify("depth_of_field_tween");
  self endon("depth_of_field_tween");

  if(!isDefined(n_step_time))
    n_step_time = 0.05;

  n_steps = n_time / n_step_time;

  if(n_steps > 0) {
    n_near_start_current = self getdepthoffield_nearstart();
    n_near_end_current = self getdepthoffield_nearend();
    n_far_start_current = self getdepthoffield_farstart();
    n_far_end_current = self getdepthoffield_farend();
    n_near_blur_current = self getdepthoffield_nearblur();
    n_far_blur_current = self getdepthoffield_farblur();
    n_far_start_current = max(n_far_start_current, n_near_end_current);
    n_near_start_step = 0;
    n_near_end_step = 0;
    n_far_start_step = 0;
    n_far_end_step = 0;
    n_near_blur_step = 0;
    n_far_blur_step = 0;
    n_near_start_step = (n_near_start - n_near_start_current) / n_steps;
    n_near_end_step = (n_near_end - n_near_end_current) / n_steps;
    n_far_start_step = (n_far_start - n_far_start_current) / n_steps;
    n_far_end_step = (n_far_end - n_far_end_current) / n_steps;
    n_near_blur_step = (n_near_blur - n_near_blur_current) / n_steps;
    n_far_blur_step = (n_far_blur - n_far_blur_current) / n_steps;

    for(i = 0; i < n_steps; i++) {
      n_near_start_current = n_near_start_current + n_near_start_step;
      n_near_end_current = n_near_end_current + n_near_end_step;
      n_far_start_current = n_far_start_current + n_far_start_step;
      n_far_end_current = n_far_end_current + n_far_end_step;
      n_near_blur_current = n_near_blur_current + n_near_blur_step;
      n_far_blur_current = n_far_blur_current + n_far_blur_step;
      n_near_blur_current = max(n_near_blur_current, 4);

      if(n_far_blur_current < 0)
        n_far_blur_current = 0;

      self setdepthoffield(n_near_start_current, n_near_end_current, n_far_start_current, n_far_end_current, n_near_blur_current, n_far_blur_current);
      wait(n_step_time);
    }

    n_near_blur = max(n_near_blur, 4);
    self setdepthoffield(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur);
  }
}

depth_of_field_off(n_time) {
  n_time = isDefined(n_time) ? n_time * 1000 : 0;
  n_near_start_current = self getdepthoffield_nearstart();
  n_near_end_current = self getdepthoffield_nearend();
  n_far_start_current = self getdepthoffield_farstart();
  n_far_end_current = self getdepthoffield_farend();
  n_near_blur_current = self getdepthoffield_nearblur();
  n_far_blur_current = self getdepthoffield_farblur();
  n_start_time = gettime();

  do {
    wait 0.05;
    n_time_delta = gettime() - n_start_time;
    n_time_frac = n_time > 0 ? n_time_delta / n_time : 1;
    n_near_start = lerpfloat(n_near_start_current, 1, n_time_frac);
    n_near_end = lerpfloat(n_near_end_current, 0, n_time_frac);
    n_far_start = lerpfloat(n_far_start_current, 1, n_time_frac);
    n_far_end = lerpfloat(n_far_end_current, 0, n_time_frac);
    n_near_blur = lerpfloat(n_near_blur_current, 6, n_time_frac);
    n_far_blur = lerpfloat(n_far_blur_current, 4, n_time_frac);
    self setdepthoffield(n_near_start, n_near_end, n_far_start, n_far_end, n_near_blur, n_far_blur);
  }
  while(n_time_delta < n_time);
}

player_seek(delayed) {
  self endon("death");
  self.ignoresuppression = 1;

  if(isDefined(self.target) || isDefined(self.script_spawner_targets))
    self waittill("goal");

  while(true) {
    if(isDefined(delayed))
      wait(randomintrange(6, 12));
    else
      wait 0.05;

    if(self.goalradius > 100)
      self.goalradius = self.goalradius - 100;

    self.pathenemyfightdist = self.goalradius;
    closest_player = get_closest_player(self.origin);
    self setgoalentity(closest_player);
    self animscripts\combat_utility::lookforbettercover();
  }
}

set_spawner_targets(spawner_targets) {
  self thread maps\_spawner::go_to_spawner_target(strtok(spawner_targets, " "));
}

ragdoll_death() {
  self animscripts\utility::do_ragdoll_death();
}

is_destructible() {
  if(!isDefined(self.script_noteworthy))
    return false;

  switch (self.script_noteworthy) {
    case "explodable_barrel":
      return true;
  }

  return false;
}

waittill_not_moving() {
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");

  if(self.classname == "grenade")
    self waittill("stationary");
  else {
    for(prevorigin = self.origin; 1; prevorigin = self.origin) {
      wait 0.15;

      if(self.origin == prevorigin) {
        break;
      }
    }
  }
}

turn_off_friendly_player_look() {
  level._dont_look_at_player = 1;
}

turn_on_friendly_player_look() {
  level._dont_look_at_player = 0;
}

force_goal(node_or_org, radius, shoot, end_on, keep_colors) {
  if(!isDefined(shoot))
    shoot = 1;

  if(!isDefined(keep_colors))
    keep_colors = 0;

  self endon("death");
  goalradius = self.goalradius;

  if(isDefined(radius))
    self.goalradius = radius;

  color_enabled = 0;

  if(!keep_colors) {
    if(isDefined(get_force_color())) {
      color_enabled = 1;
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

  if(!shoot)
    self set_ignoreall(1);

  self.dontshootwhilemoving = undefined;
  self.pathenemyfightdist = 0;
  self.pathenemylookahead = 0;
  self.ignoresuppression = 1;
  self.suppressionthreshold = 1;
  self.nododgemove = 1;
  self.grenadeawareness = 0;
  self.meleeattackdist = 0;
  self.fixednodesaferadius = 0;
  self set_ignoreme(1);
  self disable_react();
  self disable_pain();
  self pushplayer(1);

  if(self.bulletsinclip == 0)
    self.bulletsinclip = 15;

  if(isDefined(node_or_org)) {
    if(isvec(node_or_org))
      self set_goal_pos(node_or_org);
    else
      self set_goal_node(node_or_org);
  }

  if(isDefined(end_on))
    self waittill(end_on);
  else
    self waittill("goal");

  if(color_enabled)
    enable_ai_color();

  self pushplayer(0);
  self.goalradius = goalradius;
  self set_ignoreall(ignoreall);
  self set_ignoreme(ignoreme);

  if(allowpain)
    self enable_pain();

  if(allowreact)
    self enable_react();

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
  setsaveddvar("ik_pitch_limit_thresh", 10);
  setsaveddvar("ik_pitch_limit_max", 60);
  setsaveddvar("ik_roll_limit_thresh", 30);
  setsaveddvar("ik_roll_limit_max", 100);
  setsaveddvar("ik_yaw_limit_thresh", 10);
  setsaveddvar("ik_yaw_limit_max", 90);
}

relax_ik_headtracking_limits() {
  setsaveddvar("ik_pitch_limit_thresh", 110);
  setsaveddvar("ik_pitch_limit_max", 120);
  setsaveddvar("ik_roll_limit_thresh", 90);
  setsaveddvar("ik_roll_limit_max", 100);
  setsaveddvar("ik_yaw_limit_thresh", 80);
  setsaveddvar("ik_yaw_limit_max", 90);
}

button_held_think(which_button) {
  self endon("disconnect");

  if(!isDefined(self._holding_button))
    self._holding_button = [];

  self._holding_button[which_button] = 0;
  time_started = 0;

  while(true) {
    if(self._holding_button[which_button]) {
      if(!self[[level._button_funcs[which_button]]]())
        self._holding_button[which_button] = 0;
    } else if(self[[level._button_funcs[which_button]]]()) {
      if(time_started == 0)
        time_started = gettime();

      if(gettime() - time_started > 250)
        self._holding_button[which_button] = 1;
    } else if(time_started != 0)
      time_started = 0;

    wait 0.05;
  }
}

use_button_held() {
  init_button_wrappers();

  if(!isDefined(self._use_button_think_threaded)) {
    self thread button_held_think(level.button_use);
    self._use_button_think_threaded = 1;
  }

  return self._holding_button[level.button_use];
}

ads_button_held() {
  init_button_wrappers();

  if(!isDefined(self._ads_button_think_threaded)) {
    self thread button_held_think(level.button_ads);
    self._ads_button_think_threaded = 1;
  }

  return self._holding_button[level.button_ads];
}

attack_button_held() {
  init_button_wrappers();

  if(!isDefined(self._attack_button_think_threaded)) {
    self thread button_held_think(level.button_attack);
    self._attack_button_think_threaded = 1;
  }

  return self._holding_button[level.button_attack];
}

use_button_pressed() {
  assert(isPlayer(self), "Must call use_button_pressed() on a player.");
  return self usebuttonpressed();
}

ads_button_pressed() {
  assert(isPlayer(self), "Must call ads_button_pressed() on a player.");
  return self adsbuttonpressed();
}

attack_button_pressed() {
  assert(isPlayer(self), "Must call attack_button_pressed() on a player.");
  return self attackbuttonpressed();
}

waittill_use_button_pressed() {
  while(!self use_button_pressed())
    wait 0.05;
}

waittill_attack_button_pressed() {
  while(!self attack_button_pressed())
    wait 0.05;
}

waittill_ads_button_pressed() {
  while(!self ads_button_pressed())
    wait 0.05;
}

init_button_wrappers() {
  if(!isDefined(level._button_funcs)) {
    level.button_use = 0;
    level.button_ads = 1;
    level.button_attack = 2;
    level._button_funcs[level.button_use] = ::use_button_pressed;
    level._button_funcs[level.button_ads] = ::ads_button_pressed;
    level._button_funcs[level.button_attack] = ::attack_button_pressed;
  }
}

play_movie_on_surface_async(movie_name, is_looping, is_in_memory, start_on_notify, notify_when_done, notify_offset, seamless) {
  if(!isDefined(is_looping))
    is_looping = 0;

  if(!isDefined(is_in_memory))
    is_in_memory = 1;

  if(!isDefined(notify_offset))
    notify_offset = 0.3;

  if(!isDefined(seamless))
    seamless = 0;

  if(notify_offset < 0.3)
    notify_offset = 0.3;

  cin_id = level load_movie_async(movie_name, is_looping, is_in_memory, isDefined(start_on_notify), seamless);
  level thread play_movie_on_surface_thread(cin_id, movie_name, start_on_notify, notify_when_done, notify_offset);
  return cin_id;
}

play_movie_on_surface_thread(cin_id, movie_name, start_on_notify, notify_when_done, notify_offset) {
  if(isDefined(start_on_notify))
    level waittill(start_on_notify);

  while(iscinematicpreloading(cin_id))
    wait 0.05;

  playsoundatposition("evt_" + movie_name + "_movie", (0, 0, 0));

  println("pausing " + movie_name + ": on surface");

  pause3dcinematic(cin_id, 0);
  waittill_movie_done(cin_id, notify_when_done, notify_offset);
}

play_movie_on_surface(movie_name, is_looping, is_in_memory, start_on_notify, notify_when_done, notify_offset) {
  cin_id = play_movie_on_surface_async(movie_name, is_looping, is_in_memory, start_on_notify, notify_when_done, notify_offset);

  while(iscinematicinprogress(cin_id))
    wait 0.05;
}

start_movie_scene() {
  level notify("kill_scene_subs_thread");
  level._scene_subs = [];
}

add_scene_line(scene_line, time, duration) {
  if(!isDefined(level._scene_subs))
    level._scene_subs = [];

  sl = spawnStruct();
  sl.line = scene_line;
  sl.time = time;
  sl.duration = duration;

  for(i = 0; i < level._scene_subs.size; i++) {
    if(time < level._scene_subs[i].time) {
      println("*** ERROR:Cannot add an earlier line after a later one.Times must always increase.");

      return;
    }
  }

  level._scene_subs[level._scene_subs.size] = sl;
}

sub_fade(alpha, duration) {
  self notify("kill_fade");
  self endon("kill_fade");

  if(alpha == 1)
    self.alpha = 0;

  self fadeovertime(duration);
  self.alpha = alpha;
  wait(duration);
}

do_scene_sub(sub_string, duration) {
  if(!getlocalprofileint("cg_subtitles")) {
    return;
  }
  if(!isDefined(level.vo_hud)) {
    level.vo_hud = newhudelem();
    level.vo_hud.fontscale = 2;
    level.vo_hud.horzalign = "center";
    level.vo_hud.vertalign = "middle";
    level.vo_hud.alignx = "center";
    level.vo_hud.aligny = "middle";
    level.vo_hud.y = 180;
    level.vo_hud.sort = 0;
  }

  level.vo_hud thread sub_fade(1, 0.2);
  old_scale = level.vo_hud.fontscale;
  level.vo_hud.fontscale = 1.5;
  old_sort = level.vo_hud.sort;
  level.vo_hud.sort = 1;
  level.vo_hud settext(sub_string);
  wait(duration - 0.2);
  level.vo_hud sub_fade(0, 0.2);
  level.vo_hud settext("");
  level.vo_hud.sort = old_sort;
  level.vo_hud.fontscale = old_scale;
}

playback_scene_subs() {
  if(!isDefined(level._scene_subs)) {
    return;
  }
  level notify("kill_scene_subs_thread");
  level endon("kill_scene_subs_thread");
  scene_start = gettime();

  for(i = 0; i < level._scene_subs.size; i++)
    level._scene_subs[i].time = scene_start + level._scene_subs[i].time * 1000;

  for(i = 0; i < level._scene_subs.size; i++) {
    while(gettime() < level._scene_subs[i].time)
      wait 0.05;

    do_scene_sub(level._scene_subs[i].line, level._scene_subs[i].duration);
  }

  level._scene_subs = undefined;
}

play_movie_async(movie_name, is_looping, is_in_memory, start_on_notify, use_fullscreen_trans, notify_when_done, notify_offset, seamless, foreground, check_for_webm, letterbox) {
  if(!isDefined(is_looping))
    is_looping = 0;

  if(!isDefined(is_in_memory))
    is_in_memory = 1;

  if(!isDefined(seamless))
    seamless = 0;

  if(!isDefined(foreground))
    foreground = 1;

  if(!isDefined(check_for_webm))
    check_for_webm = 0;

  if(!isDefined(letterbox))
    letterbox = 1;

  if(!isDefined(notify_offset) || notify_offset < 0.3)
    notify_offset = 0.3;

  fullscreen_trans_in = "none";
  fullscreen_trans_out = "none";

  if(is_true(use_fullscreen_trans)) {
    fullscreen_trans_in = "white";
    fullscreen_trans_out = "white";

    if(isDefined(level.movie_trans_in))
      fullscreen_trans_in = level.movie_trans_in;

    if(isDefined(level.movie_trans_out))
      fullscreen_trans_out = level.movie_trans_out;
  }

  cin_id = level load_movie_async(movie_name, is_looping, is_in_memory, isDefined(start_on_notify), seamless);
  level thread play_movie_async_thread(cin_id, movie_name, start_on_notify, notify_when_done, notify_offset, fullscreen_trans_in, fullscreen_trans_out, foreground, check_for_webm, letterbox);
  return cin_id;
}

play_movie_async_thread(cin_id, movie_name, start_on_notify, notify_when_done, notify_offset, fullscreen_trans_in, fullscreen_trans_out, foreground, check_for_webm, letterbox) {
  if(!isDefined(foreground))
    foreground = 1;

  if(!isDefined(check_for_webm))
    check_for_webm = 0;

  if(isDefined(start_on_notify))
    level waittill(start_on_notify);

  level thread playback_scene_subs();
  level thread handle_movie_dvars(cin_id);
  vision_set = movie_fade_in(movie_name, fullscreen_trans_in);
  hud = start_movie(cin_id, movie_name, fullscreen_trans_in, foreground, check_for_webm, letterbox);
  level notify("movie_started");
  waittill_movie_done(cin_id, notify_when_done, notify_offset);
  clientnotify("pmo");
  level.movie_trans_in = undefined;
  level.movie_trans_out = undefined;
  level movie_fade_out(movie_name, vision_set, fullscreen_trans_out);
}

play_movie(movie_name, is_looping, is_in_memory, start_on_notify, use_fullscreen_trans, notify_when_done, notify_offset, check_for_webm) {
  if(!isDefined(check_for_webm))
    check_for_webm = 0;

  cin_id = play_movie_async(movie_name, is_looping, is_in_memory, start_on_notify, use_fullscreen_trans, notify_when_done, notify_offset, check_for_webm);

  while(iscinematicinprogress(cin_id))
    wait 0.05;
}

handle_movie_dvars(cin_id) {
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    players[i]._hud_dvars = [];
    players[i]._hud_dvars["cl_scoreDraw"] = int(getDvar(#"_id_2CED2C3D"));
    players[i]._hud_dvars["compass"] = int(getDvar(#"compass"));
    players[i]._hud_dvars["hud_showstance"] = int(getDvar(#"_id_723A8A44"));
    players[i]._hud_dvars["actionSlotsHide"] = int(getDvar(#"actionSlotsHide"));
    players[i]._hud_dvars["ammoCounterHide"] = int(getDvar(#"ammoCounterHide"));
    players[i]._hud_dvars["cg_cursorHints"] = int(getDvar(#"cg_cursorHints"));
    players[i]._hud_dvars["hud_showobjectives"] = int(getDvar(#"_id_1F233594"));
    players[i]._hud_dvars["cg_drawFriendlyNames"] = int(getDvar(#"cg_drawFriendlyNames"));
    players[i] setclientdvars("cl_scoreDraw", 0, "compass", 0, "hud_showstance", 0, "actionSlotsHide", 1, "ammoCounterHide", 1, "cg_cursorHints", 0, "hud_showobjectives", 0, "cg_drawfriendlynames", 0);
  }

  while(iscinematicinprogress(cin_id))
    wait 0.05;

  println("play_movie: resetting play movie dvars.");

  players = getplayers();

  for(i = 0; i < players.size; i++) {
    keys = getarraykeys(players[i]._hud_dvars);
    players[i] setclientdvars(keys[0], players[i]._hud_dvars[keys[0]], keys[1], players[i]._hud_dvars[keys[1]], keys[2], players[i]._hud_dvars[keys[2]], keys[3], players[i]._hud_dvars[keys[3]], keys[4], players[i]._hud_dvars[keys[4]], keys[5], players[i]._hud_dvars[keys[5]], keys[6], players[i]._hud_dvars[keys[6]], keys[7], players[i]._hud_dvars[keys[7]]);
  }
}

load_movie_async(movie_name, is_looping, is_in_memory, paused, seamless) {
  cin_id = start3dcinematic(movie_name, is_looping, is_in_memory, 0, 0, seamless);

  if(is_true(paused)) {
    println("pausing " + movie_name + ": start notify defined");

    pause3dcinematic(cin_id, 1);
  }

  return cin_id;
}

start_movie(cin_id, movie_name, fullscreen_trans, foreground, check_for_webm, letterbox) {
  if(!isDefined(foreground))
    foreground = 1;

  if(!isDefined(check_for_webm))
    check_for_webm = 0;

  level.fullscreen_hud_destroy_after_id = cin_id;

  while(iscinematicpreloading(cin_id))
    wait 0.05;

  if(!isDefined(level.fullscreen_cin_hud))
    level.fullscreen_cin_hud = create_movie_hud(cin_id, fullscreen_trans, foreground, check_for_webm, letterbox);

  playsoundatposition(movie_name + "_movie", (0, 0, 0));
  pause3dcinematic(cin_id, 0);
  return level.fullscreen_cin_hud;
}

create_movie_hud(cin_id, fullscreen_trans, foreground, check_for_webm, letterbox) {
  movie_hud = newhudelem();
  movie_hud.x = 0;
  movie_hud.y = 0;
  movie_hud.horzalign = "fullscreen";
  movie_hud.vertalign = "fullscreen";
  movie_hud.foreground = foreground;
  movie_hud.sort = 1;
  movie_hud.alpha = 1;
  otherhud = undefined;
  height = 480;

  if(letterbox) {
    otherhud = newhudelem();
    otherhud.x = 0;
    otherhud.y = 0;
    otherhud.horzalign = "fullscreen";
    otherhud.vertalign = "fullscreen";
    otherhud.foreground = foreground;
    otherhud.sort = 0;
    otherhud.alpha = 1;
    otherhud setshader("black", 640, 480);
  }

  setDvar("r_loadingScreen", 1);

  if(letterbox && !level.console) {
    height = int(480 * getdvarfloat(#"r_aspectRatioWindow") * 0.5625);
    movie_hud.y = (480 - height) / 2;
  } else if(letterbox && getdvarint(#"wideScreen") != 1) {
    movie_hud.y = 60;
    height = 360;
  }

  movie_hud setshader("cinematic2d", 640, height);

  if(check_for_webm) {
    while(iscinematicpreloading(cin_id))
      wait 0.05;

    if(isDefined(level.iscinematicwebm) && level.iscinematicwebm && !level.wiiu)
      movie_hud setshader("webm_720p", 640, height);
  }

  movie_hud thread destroy_when_movie_is_stopped(otherhud);
  return movie_hud;
}

destroy_when_movie_is_stopped(otherhudtodestroy) {
  if(isDefined(self)) {
    while(iscinematicinprogress(level.fullscreen_hud_destroy_after_id))
      wait 0.05;

    setDvar("r_loadingScreen", 0);

    println("destroy hud for movie id " + level.fullscreen_hud_destroy_after_id);

    self destroy();

    if(isDefined(otherhudtodestroy))
      otherhudtodestroy destroy();

    level.fullscreen_hud_destroy_after_id = undefined;
  }
}

movie_fade_in(movie_name, fullscreen_trans) {
  current_vision_set = "";

  if(fullscreen_trans != "none") {
    fade_hud = newhudelem();
    playsoundatposition(movie_name + "_fade_in", (0, 0, 0));
    fade_in = 0.5;

    if(isDefined(level.movie_fade_in_time))
      fade_in = level.movie_fade_in_time;

    switch (fullscreen_trans) {
      case "white":
        current_vision_set = get_players()[0] getvisionsetnaked();
        visionsetnaked("int_frontend_char_trans", fade_in);
        break;
      case "whitehud":
        fade_hud.x = 0;
        fade_hud.y = 0;
        fade_hud.horzalign = "fullscreen";
        fade_hud.vertalign = "fullscreen";
        fade_hud.foreground = 0;
        fade_hud.sort = 0;
        fade_hud.alpha = 0;
        fade_hud setshader("white", 640, 480);
        fade_hud fadeovertime(fade_in);
        fade_hud.alpha = 1;
        break;
      case "black":
        fade_hud.x = 0;
        fade_hud.horzalign = "fullscreen";
        fade_hud.vertalign = "fullscreen";
        fade_hud.foreground = 0;
        fade_hud.sort = 0;
        fade_hud.alpha = 0;
        fade_hud setshader("black", 640, 480);
        fade_hud fadeovertime(fade_in);
        fade_hud.alpha = 1;
        break;
    }

    wait(fade_in);
    fade_hud destroy();
  }

  return current_vision_set;
}

movie_fade_out(movie_name, vision_set, fullscreen_trans) {
  if(fullscreen_trans != "none") {
    fade_hud = newhudelem();
    playsoundatposition(movie_name + "_fade_out", (0, 0, 0));
    fade_out = 0.5;

    if(isDefined(level.movie_fade_out_time))
      fade_out = level.movie_fade_out_time;

    switch (fullscreen_trans) {
      case "white":
        current_vision_set = get_players()[0] getvisionsetnaked();

        if(current_vision_set != "int_frontend_char_trans")
          vision_set = current_vision_set;

        visionsetnaked("int_frontend_char_trans", 0);
        wait 0.1;
        visionsetnaked(vision_set, fade_out);
        break;
      case "whitehud":
        fade_hud.x = 0;
        fade_hud.y = 0;
        fade_hud.horzalign = "fullscreen";
        fade_hud.vertalign = "fullscreen";
        fade_hud.foreground = 0;
        fade_hud.sort = 0;
        fade_hud.alpha = 1;
        fade_hud setshader("white", 640, 480);
        fade_hud fadeovertime(fade_out);
        fade_hud.alpha = 0;
        break;
      case "black":
        fade_hud.x = 0;
        fade_hud.y = 0;
        fade_hud.horzalign = "fullscreen";
        fade_hud.vertalign = "fullscreen";
        fade_hud.foreground = 0;
        fade_hud.sort = 0;
        fade_hud.alpha = 1;
        fade_hud setshader("black", 640, 480);
        fade_hud fadeovertime(fade_out);
        fade_hud.alpha = 0;
        current_vision_set = get_players()[0] getvisionsetnaked();

        if(current_vision_set == "int_frontend_char_trans")
          visionsetnaked(vision_set, 0);

        break;
    }

    wait(fade_out);
    fade_hud destroy();
  }
}

waittill_movie_done(cin_id, notify_when_done, notify_offset) {
  if(isDefined(notify_when_done)) {
    while(iscinematicpreloading(cin_id))
      wait 0.05;

    while(getcinematictimeremaining(cin_id) > notify_offset)
      wait 0.05;

    level notify(notify_when_done);
  }

  while(iscinematicinprogress(cin_id))
    wait 0.05;
}

allow_divetoprone(allowed) {
  if(!isDefined(allowed)) {
    return;
  }
  setDvar("dtp", allowed);
}

waittill_player_shoots(weapon_type, ender) {
  if(isDefined(ender))
    self endon(ender);

  if(!isDefined(weapon_type))
    weapon_type = "any";

  while(true) {
    self waittill("weapon_fired");
    gun = self getcurrentweapon();

    if(weapon_type == "any")
      return gun;
    else if(weapon_type == "silenced") {
      if(issubstr(gun, "silencer"))
        return gun;
    } else if(!issubstr(gun, "silencer"))
      return gun;

    continue;
  }
}

idle_at_cover(toggle) {
  assert(isai(self), "idle_at_cover should only be called on AI entity.");
  assert(isDefined(toggle), "Incorrect use of idle_at_cover");

  if(toggle == 1)
    self.a.coveridleonly = 1;
  else if(toggle == 0)
    self.a.coveridleonly = 0;
  else
    assertmsg("Incorrect use of idle_at_cover");
}

bloody_death(str_body_part_tag, n_delay_max) {
  self endon("death");
  assert(isDefined(level._effect["flesh_hit"]), "Define level._effect['flesh_hit'] in " + level.script + "_fx.gsc");

  if(!isDefined(self)) {
    return;
  }
  if(!self is_alive_sentient()) {
    return;
  }
  if(isDefined(self.bloody_death) && self.bloody_death) {
    return;
  }
  self.bloody_death = 1;

  if(isDefined(n_delay_max))
    wait(randomfloat(n_delay_max));

  if(!isDefined(str_body_part_tag)) {
    a_tags = [];
    a_tags[0] = "j_hip_le";
    a_tags[1] = "j_hip_ri";
    a_tags[2] = "j_head";
    a_tags[3] = "j_spine4";
    a_tags[4] = "j_elbow_le";
    a_tags[5] = "j_elbow_ri";
    a_tags[6] = "j_clavicle_le";
    a_tags[7] = "j_clavicle_ri";
  } else {
    a_tags = [];

    switch (str_body_part_tag) {
      case "head":
        a_tags[0] = "j_head";
        break;
      case "body":
        a_tags[0] = "j_spine4";
        break;
      case "neck":
        a_tags[0] = "j_neck";
        break;
      default:
        assertmsg(str_body_part_tag + " is not a valid tag for bloody_death! Valid types are head, body or neck");
        a_tags[0] = "j_head";
        break;
    }
  }

  for(i = 0; i < 2; i++) {
    if(is_mature()) {
      n_wait_min = i * 0.1;
      n_wait_max = (i + 1) * 0.1;
      self delay_thread(randomfloatrange(n_wait_min, n_wait_max), ::bloody_death_fx, random(a_tags), level._effect["flesh_hit"]);
    }
  }

  wait(0.1 * 2);

  if(self is_alive_sentient())
    self dodamage(self.health + 150, self.origin);
}

bloody_death_fx(str_tag, str_fx_name) {
  assert(isDefined(str_tag), "str_tag is a required parameter for bloody_death_fx");

  if(!isDefined(str_fx_name))
    str_fx_name = level._effect["flesh_hit"];

  playFXOnTag(str_fx_name, self, str_tag);
}

clientnotify_delay(msg, time) {
  if(isDefined(time))
    wait(time);

  clientnotify(msg);
}

fake_physics_launch(v_target_pos, n_force, n_rotate_angle, str_rotate_type) {
  assert(isDefined(v_target_pos), "v_target_pos is a required parameter for fake_physics_launch");

  if(!isDefined(n_force))
    n_force = 1000;

  v_start_pos = self.origin;
  n_gravity = abs(getdvarint(#"bg_gravity")) * -1;
  n_dist = distance(v_start_pos, v_target_pos);
  n_time = n_dist / n_force;
  v_delta = v_target_pos - v_start_pos;
  n_drop_from_gravity = 0.5 * n_gravity * (n_time * n_time);
  v_launch = (v_delta[0] / n_time, v_delta[1] / n_time, (v_delta[2] - n_drop_from_gravity) / n_time);
  self movegravity(v_launch, n_time);

  if(isDefined(n_rotate_angle)) {
    if(!isDefined(str_rotate_type))
      str_rotate_type = "pitch";

    switch (str_rotate_type) {
      case "roll":
        self rotateroll(n_rotate_angle, n_time);
        break;
      case "pitch":
        self rotatepitch(n_rotate_angle, n_time);
        break;
      case "yaw":
        self rotateyaw(n_rotate_angle, n_time);
        break;
      default:
        assertmsg(str_rotate_type + " is not a valid rotation type for fake_physics_launch");
        break;
    }
  }

  return n_time;
}

explosion_launch(v_point, n_radius, n_force_min, n_force_max, n_launch_angle_min, n_launch_angle_max, b_use_drones) {
  assert(isDefined(v_point), "v_point is a required argument for explosion_launch");
  assert(isDefined(n_radius), "n_radius is a required argument for explosion_launch");

  if(!isDefined(n_force_min))
    n_force_min = 50;

  if(!isDefined(n_force_max))
    n_force_max = 150;

  if(!isDefined(n_launch_angle_min))
    n_launch_angle_min = 25;

  if(!isDefined(n_launch_angle_max))
    n_launch_angle_max = 45;

  if(!isDefined(b_use_drones))
    b_use_drones = 0;

  a_guys = getaispeciesarray("all", "all");

  if(b_use_drones) {
    a_drones = getEntArray("drone", "targetname");
    a_guys = arraycombine(a_drones, a_guys, 1, 0);
  }

  n_radius_squared = n_radius * n_radius;

  for(i = 0; i < a_guys.size; i++) {
    if(!isDefined(a_guys[i])) {
      continue;
    }
    if(a_guys[i].health < 0) {
      continue;
    }
    if(a_guys[i] is_hero()) {
      continue;
    }
    n_dist_squared = distancesquared(a_guys[i].origin, v_point);

    if(n_dist_squared < n_radius_squared) {
      v_launch_direction = a_guys[i].origin - v_point;
      v_launch_direction = vectornormalize(v_launch_direction);
      v_normalized = (v_launch_direction[0], v_launch_direction[1], 0);
      n_scale = linear_map(n_dist_squared, 0, n_radius_squared, n_force_min, n_force_max);
      n_angle = linear_map(n_dist_squared, 0, n_radius_squared, n_launch_angle_min, n_launch_angle_max);
      v_normalized = v_normalized * n_scale;
      v_final = (v_normalized[0], v_normalized[1], n_angle);
      a_guys[i] anim_stopanimscripted();
      a_guys[i].force_gib = 1;

      if(isai(a_guys[i])) {
        a_guys[i] thread _launch_ai(v_final);
        continue;
      }

      a_guys[i] thread _launch_drone(v_final);
    }
  }
}

_launch_ai(v_physics_launch) {
  self ragdoll_death();
  self launchragdoll(v_physics_launch);
}

_launch_drone(v_physics_launch) {
  self dodamage(self.health + 100, v_physics_launch);
  wait_network_frame();

  if(isDefined(self) && isDefined(self.ragdoll_start_time))
    self launchragdoll(v_physics_launch);
}

rumble_loop(n_count, n_delay, str_rumble_type) {
  self notify("_rumble_loop_stop");
  self endon("_rumble_loop_stop");
  assert(isDefined(n_count), "n_delay missing from rumble_loop");
  assert(isPlayer(self), "rumble_loop can only be used on players");

  if(isDefined(n_delay) && n_delay <= 0)
    assertmsg("n_delay cannot be a zero or negative value in rumble_loop");

  if(!isDefined(n_delay))
    n_delay = 0.5;

  if(!isDefined(str_rumble_type))
    str_rumble_type = "damage_heavy";

  b_loop_forever = n_count < 0;
  n_times_played = 0;

  while(n_times_played < n_count || b_loop_forever) {
    self playrumbleonentity(str_rumble_type);
    n_times_played++;
    wait(n_delay);
  }
}

rumble_loop_stop() {
  self notify("_rumble_loop_stop");
}

is_looking_at(ent_or_org, n_dot_range, do_trace, v_offset) {
  if(!isDefined(n_dot_range))
    n_dot_range = 0.67;

  if(!isDefined(do_trace))
    do_trace = 0;

  assert(isDefined(ent_or_org), "ent_or_org is required parameter for is_facing function");
  v_point = isvec(ent_or_org) ? ent_or_org : ent_or_org.origin;

  if(isvec(v_offset))
    v_point = v_point + v_offset;

  b_can_see = 0;
  b_use_tag_eye = 0;

  if(isPlayer(self) || isai(self))
    b_use_tag_eye = 1;

  n_dot = self get_dot_direction(v_point, 0, 1, "forward", b_use_tag_eye);

  if(n_dot > n_dot_range) {
    if(do_trace) {
      v_eye = self get_eye();
      b_can_see = sighttracepassed(v_eye, v_point, 0, ent_or_org);
    } else
      b_can_see = 1;
  }

  return b_can_see;
}

is_behind(v_point, n_dot_range) {
  assert(isDefined(v_point), "v_point is a required parameter for is_behind");

  if(!isDefined(n_dot_range))
    n_dot_range = 0;

  b_is_behind = 0;
  n_dot = self get_dot_forward(v_point);

  if(n_dot < n_dot_range)
    b_is_behind = 1;

  return b_is_behind;
}

dot_to_fov(n_dot) {
  assert(isDefined(n_dot), "n_dot is a required parameter for dot_to_fov");
  n_fov = acos(n_dot) * 2;
  return n_fov;
}

fov_to_dot(n_fov) {
  assert(isDefined(n_fov), "n_fov is required for fov_to_dot");
  n_dot = cos(n_fov * 0.5);
  return n_dot;
}

get_ent(str_value, str_key, b_assert_if_missing) {
  assert(isDefined(str_value), "str_value is a required parameter for get_ent");

  if(!isDefined(b_assert_if_missing))
    b_assert_if_missing = 0;

  a_found = get_ent_array(str_value, str_key);

  if(b_assert_if_missing && a_found.size == 0)
    assertmsg("get_ent found no entities with " + str_key + " " + str_value + "!");

  assert(a_found.size <= 1, "get_ent returned more than one entity with " + string(str_key) + " " + str_value + "!");
  return a_found[0];
}

get_ent_array(str_value, str_key, b_assert_if_missing) {
  if(!isDefined(str_key))
    str_key = "targetname";

  assert(isDefined(str_value), "str_value is a required parameter for get_ent_array");

  if(isDefined(str_key) && (str_key != "targetname" && str_key != "script_noteworthy" && str_key != "classname"))
    assertmsg(str_key + " is not a key supported by get_ent_array!");

  if(!isDefined(b_assert_if_missing))
    b_assert_if_missing = 0;

  a_ents = getEntArray(str_value, str_key);

  if(a_ents.size == 0 && b_assert_if_missing)
    assertmsg("get_ent_array found no ents with " + str_key + " " + str_value + "!");

  return a_ents;
}

get_struct(str_value, str_key, b_assert_if_missing) {
  assert(isDefined(str_value), "str_value is a required parameter for get_struct");

  if(!isDefined(str_key))
    str_key = "targetname";

  if(!isDefined(b_assert_if_missing))
    b_assert_if_missing = 0;

  a_found = get_struct_array(str_value, str_key);

  if(b_assert_if_missing && a_found.size == 0)
    assertmsg("get_struct found no struct with " + str_key + " " + str_value + "!");

  assert(a_found.size <= 1, "get_struct found " + a_found.size + " structs with " + str_key + " " + str_value + "!");
  return a_found[0];
}

get_struct_array(str_value, str_key, b_assert_if_missing) {
  if(!isDefined(str_key))
    str_key = "targetname";

  if(!isDefined(b_assert_if_missing))
    b_assert_if_missing = 0;

  assert(isDefined(str_value), "str_value is required parameter for get_struct_array");
  a_found = getstructarray(str_value, str_key);

  if(a_found.size == 0 && b_assert_if_missing)
    assertmsg("get_struct_array found no structs with " + str_key + " " + str_value + "!");

  return a_found;
}

add_flag_function(str_flag_name, func_after_flag, param_1, param_2, param_3, param_4, param_5) {
  assert(isDefined(str_flag_name), "str_flag_name is a required parameter for add_flag_function");
  assert(isDefined(func_after_flag), "func_after_flag is a required parameter for add_flag_function");
  self thread _flag_wait_then_func(str_flag_name, func_after_flag, param_1, param_2, param_3, param_4, param_5);
}

_flag_wait_then_func(str_flag_name, func_after_flag, param_1, param_2, param_3, param_4, param_5) {
  if(!isDefined(level.flag[str_flag_name]))
    flag_init(str_flag_name);

  flag_wait(str_flag_name);
  single_func(self, func_after_flag, param_1, param_2, param_3, param_4, param_5);
}

is_point_inside_volume(v_point, e_volume) {
  assert(isDefined(v_point), "v_point is missing in is_point_inside_volume");
  assert(isDefined(e_volume), "e_volume is missing in is_point_inside_volume");
  e_origin = spawn("script_origin", v_point);
  is_inside_volume = e_origin istouching(e_volume);
  e_origin delete();
  return is_inside_volume;
}

add_spawn_function_group(str_value, str_key, func_spawn, param_1, param_2, param_3, param_4, param_5) {
  if(!isDefined(str_key))
    str_key = "targetname";

  assert(isDefined(str_value), "str_value is a required parameter for add_spawn_function_group");
  assert(isDefined(func_spawn), "func_spawn is a required parameter for add_spawn_function_group");
  a_spawners = [];

  if(str_key == "targetname" || str_key == "script_noteworthy" || str_key == "classname")
    a_spawners = getspawnerarray(str_value, str_key);
  else if(str_key == "script_string") {
    a_all_spawners = getspawnerarray();

    foreach(sp in a_all_spawners) {
      if(!isDefined(sp.script_string) && !isDefined(str_value) || isDefined(sp.script_string) && isDefined(str_value) && sp.script_string == str_value) {
        a_spawners[a_spawners.size] = sp;
        break;
      }
    }
  } else
    assertmsg("add_spawn_function_group doesn't support " + str_key + ".");

  array_func(a_spawners, ::add_spawn_function, func_spawn, param_1, param_2, param_3, param_4, param_5);
}

add_spawn_function_ai_group(str_aigroup, func_spawn, param_1, param_2, param_3, param_4, param_5) {
  assert(isDefined(str_aigroup), "str_aigroup is a required parameter for add_spawn_function_ai_group");
  assert(isDefined(func_spawn), "func_spawn is a required parameter for add_spawn_function_ai_group");
  a_spawners = getspawnerarray();

  foreach(e_spawner in a_spawners) {
    if(isDefined(e_spawner.script_aigroup) && e_spawner.script_aigroup == str_aigroup)
      e_spawner add_spawn_function(func_spawn, param_1, param_2, param_3, param_4, param_5);
  }
}

add_trigger_function(trigger, func, param_1, param_2, param_3, param_4, param_5, param_6) {
  level thread _do_trigger_function(trigger, func, param_1, param_2, param_3, param_4, param_5, param_6);
}

_do_trigger_function(trigger, func, param_1, param_2, param_3, param_4, param_5, param_6) {
  if(isstring(trigger))
    trigger_wait(trigger);
  else {
    trigger endon("death");
    trigger trigger_wait();
  }

  single_thread(level, func, param_1, param_2, param_3, param_4, param_5, param_6);
}

get_dot_direction(v_point, b_ignore_z, b_normalize, str_direction, b_use_eye) {
  assert(isDefined(v_point), "v_point is a required parameter for get_dot");

  if(!isDefined(b_ignore_z))
    b_ignore_z = 0;

  if(!isDefined(b_normalize))
    b_normalize = 1;

  if(!isDefined(str_direction))
    str_direction = "forward";

  if(!isDefined(b_use_eye)) {
    b_use_eye = 0;

    if(isPlayer(self))
      b_use_eye = 1;
  }

  v_angles = self.angles;
  v_origin = self.origin;

  if(b_use_eye)
    v_origin = self get_eye();

  if(isPlayer(self)) {
    v_angles = self getplayerangles();

    if(level.wiiu)
      v_angles = self getgunangles();
  }

  if(b_ignore_z) {
    v_angles = (v_angles[0], v_angles[1], 0);
    v_point = (v_point[0], v_point[1], 0);
    v_origin = (v_origin[0], v_origin[1], 0);
  }

  switch (str_direction) {
    case "forward":
      v_direction = anglesToForward(v_angles);
      break;
    case "backward":
      v_direction = anglesToForward(v_angles) * -1;
      break;
    case "right":
      v_direction = anglestoright(v_angles);
      break;
    case "left":
      v_direction = anglestoright(v_angles) * -1;
      break;
    case "up":
      v_direction = anglestoup(v_angles);
      break;
    case "down":
      v_direction = anglestoup(v_angles) * -1;
      break;
    default:
      assertmsg(str_direction + " is not a valid str_direction for get_dot!");
      v_direction = anglesToForward(v_angles);
      break;
  }

  v_to_point = v_point - v_origin;

  if(b_normalize)
    v_to_point = vectornormalize(v_to_point);

  n_dot = vectordot(v_direction, v_to_point);
  return n_dot;
}

get_dot_from_eye(v_point, b_ignore_z, b_normalize, str_direction) {
  assert(isDefined(v_point), "v_point is a required parameter for get_dot_forward");
  assert(isPlayer(self) || isai(self), "get_dot_from_eye was used on a " + self.classname + ". Valid ents are players and AI, since they have tag_eye.");
  n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, str_direction, 1);
  return n_dot;
}

get_dot_forward(v_point, b_ignore_z, b_normalize) {
  assert(isDefined(v_point), "v_point is a required parameter for get_dot_forward");
  n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "forward");
  return n_dot;
}

get_dot_up(v_point, b_ignore_z, b_normalize) {
  assert(isDefined(v_point), "v_point is a required parameter for get_dot_up");
  n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "up");
  return n_dot;
}

get_dot_right(v_point, b_ignore_z, b_normalize) {
  assert(isDefined(v_point), "v_point is a required parameter for get_dot_right");
  n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "right");
  return n_dot;
}

player_wakes_up(b_remove_weapons, str_return_weapons_notify) {
  assert(isPlayer(self), "player_wakes_up can only be used on players!");

  if(!isDefined(level.flag["player_awake"]))
    flag_init("player_awake");

  if(!isDefined(b_remove_weapons))
    b_remove_weapons = 1;

  e_temp = spawn("script_origin", self.origin);
  e_temp.angles = self getplayerangles();
  self playerlinktodelta(e_temp, undefined, 0, 45, 45, 45, 45);
  self setstance("prone");
  self allowstand(0);
  self allowsprint(0);
  self allowjump(0);
  self allowads(!b_remove_weapons);
  self setplayerviewratescale(30);
  self hide_hud();

  if(b_remove_weapons)
    self thread _player_wakes_up_remove_weapons(str_return_weapons_notify);

  self shellshock("death", 12);
  self screen_fade_out(0);
  wait 0.2;
  self playrumbleonentity("damage_light");
  wait 0.4;
  self playrumbleonentity("damage_light");
  wait 0.4;
  self screen_fade_to_alpha_with_blur(0.35, 2, 3);
  wait 3.5;
  self screen_fade_to_alpha_with_blur(1, 2.5, 6);
  self playrumbleonentity("damage_light");
  wait 0.5;
  self screen_fade_to_alpha_with_blur(0.2, 2.5, 1.5);
  wait 2;
  self screen_fade_to_alpha_with_blur(1, 1, 6);
  wait 1;
  self setplayerviewratescale(80);
  self screen_fade_to_alpha_with_blur(0.2, 5, 1);
  self allowstand(1);
  self allowsprint(1);
  self allowjump(1);
  self allowads(1);
  self resetplayerviewratescale();
  self notify("_give_back_weapons");
  self show_hud();
  flag_set("player_awake");
  self unlink();
  e_temp delete();
  self screen_fade_to_alpha_with_blur(0, 6, 0);
}

_player_wakes_up_remove_weapons(str_return_weapons_notify) {
  level endon("player_awake");

  if(!isDefined(str_return_weapons_notify))
    str_return_weapons_notify = "_give_back_weapons";

  while(self getcurrentweapon() == "none")
    wait 0.05;

  self thread take_and_giveback_weapons(str_return_weapons_notify);
}

screen_fade_out(n_time, str_shader, b_foreground, b_force) {
  if(!isDefined(b_foreground))
    b_foreground = 0;

  if(!isDefined(b_force))
    b_force = 0;

  level notify("_screen_fade");
  level endon("_screen_fade");

  if(!level flag_exists("screen_fade_in_end")) {
    flag_init("screen_fade_out_start");
    flag_init("screen_fade_out_end");
    flag_init("screen_fade_in_start");
    flag_init("screen_fade_in_end");
  }

  flag_clear("screen_fade_in_end");

  if(!b_force) {
    if(flag("screen_fade_out_end"))
      return;
  }

  if(!isDefined(n_time))
    n_time = 2;

  hud = get_fade_hud(str_shader);
  hud.alpha = 0;
  hud.foreground = b_foreground;

  if(isDefined(n_time) && n_time > 0) {
    hud fadeovertime(n_time);
    hud.alpha = 1;
    flag_set("screen_fade_out_start");
    wait(n_time);
  } else
    hud.alpha = 1;

  flag_clear("screen_fade_out_start");
  flag_set("screen_fade_out_end");
}

screen_fade_in(n_time, str_shader, b_foreground, b_force) {
  if(!isDefined(b_foreground))
    b_foreground = 0;

  if(!isDefined(b_force))
    b_force = 0;

  level notify("_screen_fade");
  level endon("_screen_fade");

  if(!level flag_exists("screen_fade_in_end")) {
    flag_init("screen_fade_out_start");
    flag_init("screen_fade_out_end");
    flag_init("screen_fade_in_start");
    flag_init("screen_fade_in_end");
  }

  flag_clear("screen_fade_out_end");

  if(!b_force) {
    if(flag("screen_fade_in_end"))
      return;
  }

  if(!isDefined(n_time))
    n_time = 2;

  hud = get_fade_hud(str_shader);
  hud.alpha = 1;
  hud.foreground = b_foreground;

  if(n_time > 0) {
    hud fadeovertime(n_time);
    hud.alpha = 0;
    flag_set("screen_fade_in_start");
    wait(n_time);
  }

  if(isDefined(level.fade_hud))
    level.fade_hud destroy();

  flag_clear("screen_fade_in_start");
  flag_set("screen_fade_in_end");
}

screen_fade_to_alpha_with_blur(n_alpha, n_fade_time, n_blur, str_shader) {
  assert(isDefined(n_alpha), "Must specify an alpha value for screen_fade_to_alpha_with_blur.");
  assert(isPlayer(self), "screen_fade_to_alpha_with_blur can only be called on players!");
  level notify("_screen_fade");
  level endon("_screen_fade");
  hud_fade = get_fade_hud(str_shader);
  hud_fade fadeovertime(n_fade_time);
  hud_fade.alpha = n_alpha;

  if(isDefined(n_blur) && n_blur >= 0)
    self setblur(n_blur, n_fade_time);

  wait(n_fade_time);
}

screen_fade_to_alpha(n_alpha, n_fade_time, str_shader) {
  screen_fade_to_alpha_with_blur(n_fade_time, n_alpha, 0, str_shader);
}

get_fade_hud(str_shader) {
  if(!isDefined(str_shader))
    str_shader = "black";

  if(!isDefined(level.fade_hud)) {
    level.fade_hud = newhudelem();
    level.fade_hud.x = 0;
    level.fade_hud.y = 0;
    level.fade_hud.horzalign = "fullscreen";
    level.fade_hud.vertalign = "fullscreen";
    level.fade_hud.sort = 0;
    level.fade_hud.alpha = 0;
  }

  level.fade_hud setshader(str_shader, 640, 480);
  return level.fade_hud;
}

get_triggers(type1, type2, type3, type4, type5, type6, type7, type8, type9) {
  if(!isDefined(type1)) {
    type1 = "trigger_damage";
    type2 = "trigger_hurt";
    type3 = "trigger_lookat";
    type4 = "trigger_once";
    type5 = "trigger_radius";
    type6 = "trigger_use";
    type7 = "trigger_use_touch";
    type8 = "trigger_box";
    type9 = "trigger_multiple";
  }

  assert(_is_valid_trigger_type(type1));
  trigs = getEntArray(type1, "classname");

  if(isDefined(type2)) {
    assert(_is_valid_trigger_type(type2));
    trigs = arraycombine(trigs, getEntArray(type2, "classname"), 1, 0);
  }

  if(isDefined(type3)) {
    assert(_is_valid_trigger_type(type3));
    trigs = arraycombine(trigs, getEntArray(type3, "classname"), 1, 0);
  }

  if(isDefined(type4)) {
    assert(_is_valid_trigger_type(type4));
    trigs = arraycombine(trigs, getEntArray(type4, "classname"), 1, 0);
  }

  if(isDefined(type5)) {
    assert(_is_valid_trigger_type(type5));
    trigs = arraycombine(trigs, getEntArray(type5, "classname"), 1, 0);
  }

  if(isDefined(type6)) {
    assert(_is_valid_trigger_type(type6));
    trigs = arraycombine(trigs, getEntArray(type6, "classname"), 1, 0);
  }

  if(isDefined(type7)) {
    assert(_is_valid_trigger_type(type7));
    trigs = arraycombine(trigs, getEntArray(type7, "classname"), 1, 0);
  }

  if(isDefined(type8)) {
    assert(_is_valid_trigger_type(type8));
    trigs = arraycombine(trigs, getEntArray(type8, "classname"), 1, 0);
  }

  if(isDefined(type9)) {
    assert(_is_valid_trigger_type(type9));
    trigs = arraycombine(trigs, getEntArray(type9, "classname"), 1, 0);
  }

  return trigs;
}

_is_valid_trigger_type(type) {
  if(type == "trigger_damage")
    return true;

  if(type == "trigger_hurt")
    return true;

  if(type == "trigger_lookat")
    return true;

  if(type == "trigger_once")
    return true;

  if(type == "trigger_radius")
    return true;

  if(type == "trigger_use")
    return true;

  if(type == "trigger_use")
    return true;

  if(type == "trigger_use_touch")
    return true;

  if(type == "trigger_box")
    return true;

  if(type == "trigger_multiple")
    return true;

  return false;
}

get_player_stat(stat_name) {
  if(!isPlayer(self)) {
    println("ERROR: Tried to get player stat " + stat_name + "on a non-player entity!");

    return undefined;
  }

  return self getsessstat("PlayerSessionStats", stat_name);
}

set_player_stat(stat_name, value) {
  if(!isPlayer(self)) {
    println("ERROR: Tried to set player stat " + stat_name + "on a non-player entity!");

    return undefined;
  }

  self setsessstat("PlayerSessionStats", stat_name, value);
}

waitforstats() {
  flag_wait("all_players_connected");
  players = get_players();

  while(true) {
    all_stats_fetched = 1;

    for(i = 0; i < players.size; i++) {
      if(!players[i] hasdstats())
        all_stats_fetched = 0;
    }

    if(all_stats_fetched) {
      return;
    }
    println("Stats not fetched yet!");

    wait 0.05;
  }
}

init_hero(name, func_init, arg1, arg2, arg3, arg4, arg5) {
  if(!isDefined(level.heroes))
    level.heroes = [];

  name = tolower(name);
  ai_hero = getent(name + "_ai", "targetname");

  if(!isalive(ai_hero)) {
    spawner = getent(name, "targetname");

    if(!(isDefined(spawner.spawning) && spawner.spawning)) {
      spawner.count++;
      ai_hero = simple_spawn_single(spawner);
      spawner notify("hero_spawned", ai_hero);
    } else
      spawner waittill("hero_spawned", ai_hero);
  }

  ai_hero.animname = name;

  if(isDefined(ai_hero.script_friendname)) {
    if(ai_hero.script_friendname == "none")
      ai_hero.name = "";
    else
      ai_hero.name = ai_hero.script_friendname;
  } else
    ai_hero.name = name;

  ai_hero make_hero();

  if(isDefined(func_init))
    single_thread(ai_hero, func_init, arg1, arg2, arg3, arg4, arg5);

  level.heroes = add_to_array(level.heroes, ai_hero, 0);
  return ai_hero;
}

init_heroes(a_hero_names, func, arg1, arg2, arg3, arg4, arg5) {
  a_heroes = [];

  foreach(str_hero in a_hero_names)
  a_heroes[a_heroes.size] = init_hero(str_hero, func, arg1, arg2, arg3, arg4, arg5);

  return a_heroes;
}

getdvarfloatdefault(dvarname, defaultvalue) {
  value = getDvar(dvarname);

  if(value != "")
    return float(value);

  return defaultvalue;
}

getdvarintdefault(dvarname, defaultvalue) {
  value = getDvar(dvarname);

  if(value != "")
    return int(value);

  return defaultvalue;
}

weapondamagetrace(from, to, startradius, ignore) {
  midpos = undefined;
  diff = to - from;

  if(lengthsquared(diff) < startradius * startradius)
    midpos = to;

  dir = vectornormalize(diff);
  midpos = from + (dir[0] * startradius, dir[1] * startradius, dir[2] * startradius);
  trace = bulletTrace(midpos, to, 0, ignore);

  if(getdvarint(#"_id_0A1C40B1") != 0) {
    if(trace["fraction"] == 1)
      thread debugline(midpos, to, (1, 1, 1));
    else {
      thread debugline(midpos, trace["position"], (1, 0.9, 0.8));
      thread debugline(trace["position"], to, (1, 0.4, 0.3));
    }
  }

  return trace;
}

closestpointonline(point, linestart, lineend) {
  linemagsqrd = lengthsquared(lineend - linestart);
  t = ((point[0] - linestart[0]) * (lineend[0] - linestart[0]) + (point[1] - linestart[1]) * (lineend[1] - linestart[1]) + (point[2] - linestart[2]) * (lineend[2] - linestart[2])) / linemagsqrd;

  if(t < 0.0)
    return linestart;
  else if(t > 1.0)
    return lineend;

  start_x = linestart[0] + t * (lineend[0] - linestart[0]);
  start_y = linestart[1] + t * (lineend[1] - linestart[1]);
  start_z = linestart[2] + t * (lineend[2] - linestart[2]);
  return (start_x, start_y, start_z);
}

get2dyaw(start, end) {
  vector = (end[0] - start[0], end[1] - start[1], 0);
  return vectoangles(vector);
}

vectoangles(vector) {
  yaw = 0;
  vecx = vector[0];
  vecy = vector[1];

  if(vecx == 0 && vecy == 0)
    return 0;

  if(vecy < 0.001 && vecy > -0.001)
    vecy = 0.001;

  yaw = atan(vecx / vecy);

  if(vecy < 0)
    yaw = yaw + 180;

  return 90 - yaw;
}

wait_endon(waittime, endonstring, endonstring2, endonstring3) {
  self endon(endonstring);

  if(isDefined(endonstring2))
    self endon(endonstring2);

  if(isDefined(endonstring3))
    self endon(endonstring3);

  wait(waittime);
}

waittillnotmoving() {
  if(self.classname == "grenade")
    self waittill("stationary");
  else {
    for(prevorigin = self.origin; 1; prevorigin = self.origin) {
      wait 0.15;

      if(self.origin == prevorigin) {
        break;
      }
    }
  }
}

playsoundinspace(alias, origin, master) {
  if(!isDefined(master))
    master = 0;

  if(!isDefined(origin))
    origin = self.origin;

  org = spawn("script_origin", (0, 0, 1));
  org.origin = origin;

  if(master)
    org playsoundasmaster(alias);
  else
    org playSound(alias);

  wait 10.0;
  org delete();
}

sort_by_distance(a_ents, v_origin) {
  return maps\_utility_code::mergesort(a_ents, ::_sort_by_distance_compare_func, v_origin);
}

_sort_by_distance_compare_func(e1, e2, origin) {
  dist1 = distancesquared(e1.origin, origin);
  dist2 = distancesquared(e2.origin, origin);
  return dist1 > dist2;
}

sort_by_script_int(a_ents, b_lowest_first) {
  if(!isDefined(b_lowest_first))
    b_lowest_first = 0;

  return maps\_utility_code::mergesort(a_ents, ::_sort_by_script_int_compare_func, b_lowest_first);
}

_sort_by_script_int_compare_func(e1, e2, b_lowest_first) {
  if(b_lowest_first)
    return e1.script_int < e2.script_int;
  else
    return e1.script_int > e2.script_int;
}

set_battlechatter(state) {
  if(self.type == "dog") {
    return;
  }
  if(state)
    self.bsc_squelched = 1;
  else {
    if(isDefined(self.isspeaking) && self.isspeaking)
      self wait_until_done_speaking();

    self.bsc_squelched = 0;
  }
}

playsmokesound(position, duration, startsound, stopsound, loopsound) {
  smokesound = spawn("script_origin", (0, 0, 1));
  smokesound.origin = position;
  smokesound playSound(startsound);
  smokesound playLoopSound(loopsound);

  if(duration > 0.5)
    wait(duration - 0.5);

  thread playsoundinspace(stopsound, position);
  smokesound stoploopsound(0.5);
  wait 0.5;
  smokesound delete();
}

freeze_player_controls(boolean) {
  assert(isDefined(boolean), "'freeze_player_controls()' has not been passed an argument properly.");

  if(boolean && isalive(self))
    self freezecontrols(boolean);
  else if(!boolean && isalive(self) && !level.gameended)
    self freezecontrols(boolean);
}

iskillstreaksenabled() {
  return isDefined(level.killstreaksenabled) && level.killstreaksenabled;
}

iskillstreaksstreakcountsenabled() {
  return !isDefined(level.killstreakscountsdisabled) || !level.killstreakscountsdisabled;
}

get_story_stat(str_stat_name) {
  if(level.script == "frontend")
    return self getdstat("PlayerCareerStats", "storypoints", str_stat_name);
  else
    return self getsessstat("storypoints", str_stat_name);
}

set_story_stat(str_stat_name, b_event_state) {
  if(level.script == "frontend")
    return self setdstat("PlayerCareerStats", "storypoints", str_stat_name, b_event_state);
  else
    return self setsessstat("storypoints", str_stat_name, b_event_state);
}

get_temp_stat(n_temp_stat) {
  return self getsessstat("PlayerTempStats", "stat", "TEMPSTAT_" + n_temp_stat);
}

set_temp_stat(n_temp_stat, n_val) {
  self setsessstat("PlayerTempStats", "stat", "TEMPSTAT_" + n_temp_stat, n_val);
}

get_general_stat(str_stat_name) {
  return self getsessstat("PlayerSessionStats", str_stat_name);
}

inc_general_stat(str_stat_name) {
  self addsessstat("PlayerSessionStats", str_stat_name, 1);
}

hide_hud(force) {
  if(!isDefined(force))
    force = 0;

  if(force) {
    self setclientdvars("cg_drawfriendlynames", 0);
    self setclientuivisibilityflag("hud_visible", 0);
    setsaveddvar("ammoCounterHide", 1);
    self._hide_hud_count = 1;
    return;
  }

  if(!isDefined(self._hide_hud_count)) {
    self._hide_hud_count = 0;
    self setclientdvars("cg_drawfriendlynames", 0);
    self setclientuivisibilityflag("hud_visible", 0);
    setsaveddvar("ammoCounterHide", 1);
  }

  self._hide_hud_count++;
}

show_hud(force) {
  if(!isDefined(force))
    force = 0;

  if(force) {
    self setclientdvars("cg_drawfriendlynames", 1);
    self setclientuivisibilityflag("hud_visible", 1);
    setsaveddvar("ammoCounterHide", 0);
    self._hide_hud_count = undefined;
    return;
  }

  if(isDefined(self._hide_hud_count)) {
    self._hide_hud_count--;

    if(self._hide_hud_count == 0) {
      self setclientdvars("cg_drawfriendlynames", 1);
      self setclientuivisibilityflag("hud_visible", 1);
      setsaveddvar("ammoCounterHide", 0);
      self._hide_hud_count = undefined;
    }
  }
}

collected_all() {
  if(hascollectible(1) && hascollectible(2) && hascollectible(3))
    return true;
  else
    return false;
}

load_gump(str_gump) {
  if(!level flag_exists(str_gump))
    level flag_init(str_gump);

  if(!(!isDefined(level.gump) && !isDefined(str_gump) || isDefined(level.gump) && isDefined(str_gump) && level.gump == str_gump)) {
    flush_gump(str_gump);
    level.gump = str_gump;
    loadgump(str_gump);
    level waittill("gump_loaded");
    level notify("loaded_gump", str_gump);
    level flag_set(str_gump);
  } else
    flag_wait(str_gump);

  maps\_autosave::allow_save();
}

flush_gump(str_gump_loading) {
  str_gump_to_dump = level.gump;

  if(isDefined(str_gump_loading))
    level.gump = str_gump_loading;

  if(isDefined(str_gump_to_dump)) {
    maps\_autosave::block_save();
    level notify("flushing_" + str_gump_to_dump);
    flag_clear(str_gump_to_dump);
    waittillframeend;
    waittillframeend;

    if(!isDefined(str_gump_loading))
      level.gump = undefined;

    flushgump();
    level waittill("gump_flushed");
  }
}

add_gump_function(str_gump, func) {
  if(!isDefined(level._gump_functions))
    level._gump_functions = [];

  if(!isDefined(level._gump_functions[str_gump]))
    level._gump_functions[str_gump] = [];

  level._gump_functions[str_gump][level._gump_functions[str_gump].size] = func;
}

waittill_player_has_brute_force_perk() {
  while(!self hasperk("specialty_brutestrength"))
    wait 0.05;
}

waittill_player_has_intruder_perk() {
  while(!self hasperk("specialty_intruder"))
    wait 0.05;
}

waittill_player_has_lock_breaker_perk() {
  while(!self hasperk("specialty_trespasser"))
    wait 0.05;
}

waittill_textures_loaded() {
  while(!aretexturesloaded())
    wait 0.05;

  level.texture_wait_was_called = 1;
}

waittill_asset_loaded(str_type, str_name) {
  while(!isassetloaded(str_type, str_name))
    level waittill("gump_loaded");
}

new_timer() {
  s_timer = spawnStruct();
  s_timer.n_time_created = gettime();
  return s_timer;
}

get_time() {
  t_now = gettime();
  return t_now - self.n_time_created;
}

get_time_in_seconds() {
  return get_time() / 1000;
}

timer_wait(n_wait) {
  wait(n_wait);
  return get_time_in_seconds();
}

lerp_dvar(str_dvar, n_val, n_lerp_time, b_saved_dvar, b_client_dvar) {
  n_start_val = getdvarfloat(str_dvar);
  s_timer = new_timer();

  do {
    n_time_delta = s_timer timer_wait(0.05);
    n_curr_val = lerpfloat(n_start_val, n_val, n_time_delta / n_lerp_time);

    if(isDefined(b_saved_dvar) && b_saved_dvar) {
      setsaveddvar(str_dvar, n_curr_val);
      continue;
    }

    if(isDefined(b_client_dvar) && b_client_dvar) {
      self setclientdvar(str_dvar, n_curr_val);
      continue;
    }

    setDvar(str_dvar, n_curr_val);
  }
  while(n_time_delta < n_lerp_time);
}

get_level_era() {
  str_era = tablelookup("sp/levelLookup.csv", 1, level.script, 3);
  return str_era;
}

ishardpointsenabled() {
  return isDefined(level.hardpointsenabled) && level.hardpointsenabled;
}

flag_wait_on(flagname) {
  while(!level flag_exists(flagname))
    wait 0.05;

  flag_wait(flagname);
}

set_screen_fade_timer(delay) {
  assert(isDefined(delay), "You must specify a delay to change the fade screen's fadeTimer.");
  level.fade_screen.fadetimer = delay;
}

waittill_dialog_finished() {
  self endon("death");

  if(isDefined(self.istalking) && self.istalking || isDefined(self.is_about_to_talk) && self.is_about_to_talk)
    self waittill_any("done speaking", "cancel speaking", "kill_pending_dialog");
}

waittill_dialog_finished_array(a_ents, str_line) {
  if(a_ents.size > 0) {
    for(i = 0; i < a_ents.size; i++) {
      ent = a_ents[i];

      if(isalive(ent) && (isDefined(ent.is_about_to_talk) && ent.is_about_to_talk)) {
        ent waittill_dialog_finished();
        waittillframeend;
        i = -1;
      }
    }
  }
}

ammo_refill_trigger() {
  self sethintstring(&"SCRIPT_AMMO_REFILL");
  self setcursorhint("HINT_NOICON");

  while(true) {
    self waittill("trigger", e_player);
    e_player player_disable_weapons();
    wait 2;
    a_str_weapons = e_player getweaponslist();

    foreach(str_weapon in a_str_weapons) {
      e_player givemaxammo(str_weapon);
      e_player setweaponammoclip(str_weapon, weaponclipsize(str_weapon));
    }

    e_player player_enable_weapons();
  }
}

player_enable_weapons() {
  if(!isPlayer(self)) {
    println("ERROR: Tried to enable weapons on a non-player entity!");

    return undefined;
  }

  if(isDefined(self.b_weapons_disabled) && self.b_weapons_disabled)
    self.b_weapons_disabled = undefined;

  luinotifyevent(&"hud_expand_ammo", 0);
  self enableweapons();
}

player_disable_weapons(notify_event) {
  if(!isPlayer(self)) {
    println("ERROR: Tried to disable weapons on a non-player entity!");

    return undefined;
  }

  self.b_weapons_disabled = 1;
  self disableweapons();
  luinotifyevent(&"hud_shrink_ammo", 0);
}

player_walk_speed_adjustment(e_rubber_band_to, str_endon, n_dist_min, n_dist_max, n_speed_scale_min, n_speed_scale_max) {
  if(!isDefined(n_speed_scale_min))
    n_speed_scale_min = 0;

  if(!isDefined(n_speed_scale_max))
    n_speed_scale_max = 1;

  assert(isPlayer(self), "player_walk_speed_adjustment() must be called on a player");
  assert(isDefined(e_rubber_band_to), "e_rubber_band_to is a required argument for player_walk_speed_adjustment()");
  assert(isDefined(n_dist_min), "n_dist_min is a required argument for player_walk_speed_adjustment()");
  assert(isDefined(n_dist_max), "n_dist_max is a required argument for player_walk_speed_adjustment()");
  level endon(str_endon);
  n_dist_min_sq = n_dist_min * n_dist_min;
  n_dist_max_sq = n_dist_max * n_dist_max;
  self.n_speed_scale_min = n_speed_scale_min;
  self.n_speed_scale_max = n_speed_scale_max;
  self thread _player_walk_speed_reset(str_endon);

  while(true) {
    n_dist_sq = distance2dsquared(self.origin, e_rubber_band_to.origin);
    n_speed_scale = linear_map(n_dist_sq, n_dist_min_sq, n_dist_max_sq, self.n_speed_scale_min, self.n_speed_scale_max);
    self setmovespeedscale(n_speed_scale);
    wait 0.05;
  }
}

_player_walk_speed_reset(str_endon) {
  level waittill(str_endon);
  self setmovespeedscale(1);
  self.n_speed_scale_min = undefined;
  self.n_speed_scale_max = undefined;
}

set_lighting_pair(str_targetname_target, str_targetname_source, e_actor, e_source) {
  if(!isDefined(e_actor))
    e_actor = getent(str_targetname_target, "targetname");

  if(!isDefined(e_source))
    e_source = getent(str_targetname_source, "targetname");

  assert(isDefined(e_actor), "Undefined entity for creating lighting pair");
  assert(isDefined(e_source), "Undefined lighting source for lighting pair");
  e_source setclientflag(15);
  wait 0.05;
  e_actor setclientflag(7);
}

clear_lighting_pair(str_targetname, e_actor) {
  if(!isDefined(e_actor))
    e_actor = getent(str_targetname, "targetname");

  e_actor clearclientflag(7);
}

get_normalized_movement(do_ignore_config, do_ignore_inversion) {
  if(!isDefined(do_ignore_config))
    do_ignore_config = 0;

  if(!isDefined(do_ignore_inversion))
    do_ignore_inversion = 0;

  a_movement = [];
  v_movement = self getnormalizedmovement();
  a_movement[0] = v_movement[0];
  a_movement[1] = v_movement[1];

  if(!level.console) {
    if(!level.player gamepadusedlast())
      return a_movement;
  }

  if(do_ignore_config) {
    switch (getlocalprofileint("gpad_sticksConfig")) {
      case 1:
        v_movement = self getnormalizedcameramovement();
        a_movement[0] = v_movement[0];
        a_movement[1] = v_movement[1];

        if(do_ignore_inversion && getlocalprofileint("input_invertPitch") == 1)
          a_movement[0] = a_movement[0] * -1;

        break;
      case 2:
        a_movement[1] = self getnormalizedcameramovement()[1];
        break;
      case 3:
        a_movement[0] = self getnormalizedcameramovement()[0];

        if(do_ignore_inversion && getlocalprofileint("input_invertPitch") == 1)
          a_movement[0] = a_movement[0] * -1;

        break;
      case 0:
      default:
        break;
    }
  }

  return a_movement;
}

get_normalized_camera_movement(do_ignore_config, do_ignore_inversion) {
  if(!isDefined(do_ignore_config))
    do_ignore_config = 0;

  if(!isDefined(do_ignore_inversion))
    do_ignore_inversion = 0;

  a_camera_movement = [];
  v_camera_movement = self getnormalizedcameramovement();
  a_camera_movement[0] = v_camera_movement[0];
  a_camera_movement[1] = v_camera_movement[1];

  if(!level.console) {
    if(!level.player gamepadusedlast()) {
      if(do_ignore_inversion) {
        if(getdvarfloat(#"m_pitch") < 0)
          a_camera_movement[0] = a_camera_movement[0] * -1;
      }

      return a_camera_movement;
    }
  }

  if(do_ignore_inversion && getlocalprofileint("input_invertPitch") == 1)
    a_camera_movement[0] = a_camera_movement[0] * -1;

  if(do_ignore_config) {
    switch (getlocalprofileint("gpad_sticksConfig")) {
      case 1:
        v_camera_movement = self getnormalizedmovement();
        a_camera_movement[0] = v_camera_movement[0];
        a_camera_movement[1] = v_camera_movement[1];
        break;
      case 2:
        a_camera_movement[1] = self getnormalizedmovement()[1];
        break;
      case 3:
        a_camera_movement[0] = self getnormalizedmovement()[0];
        break;
      case 0:
      default:
        break;
    }
  }

  return a_camera_movement;
}

get_normalized_dpad_movement() {
  a_dpad_movement = [];

  if(self buttonpressed("DPAD_UP"))
    a_dpad_movement[0] = 1;
  else if(self buttonpressed("DPAD_DOWN"))
    a_dpad_movement[0] = -1;
  else
    a_dpad_movement[0] = 0;

  if(self buttonpressed("DPAD_RIGHT"))
    a_dpad_movement[1] = 1;
  else if(self buttonpressed("DPAD_LEFT"))
    a_dpad_movement[1] = -1;
  else
    a_dpad_movement[1] = 0;

  return a_dpad_movement;
}

model_convert_areas() {
  level._struct_models = [];
  a_vol_areas = getEntArray("model_convert", "targetname");

  foreach(vol_area in a_vol_areas)
  model_convert_area(vol_area);
}

model_convert_area(area) {
  if(isstring(area)) {
    e_area = getent(area, "script_noteworthy");
    str_area = area;
  } else {
    e_area = area;

    if(isDefined(e_area.script_noteworthy))
      str_area = e_area.script_noteworthy;
    else
      str_area = "general";
  }

  if(!isDefined(level._struct_models[str_area]))
    level._struct_models[str_area] = [];

  a_m_converts = getEntArray("script_model", "classname");

  foreach(m_convert in a_m_converts) {
    if(_model_is_exempt(m_convert) || !m_convert istouching(e_area)) {
      continue;
    }
    s_model = spawnStruct();
    m_convert model_convert_copy_kvps(s_model);
    m_convert delete();
    level._struct_models[str_area][level._struct_models[str_area].size] = s_model;
  }
}

model_convert(str_value, str_key) {
  str_area = "general";

  if(!isDefined(level._struct_models))
    level._struct_models = [];

  if(!isDefined(level._struct_models[str_area]))
    level._struct_models[str_area] = [];

  a_m_converts = getEntArray(str_value, str_key);

  foreach(m_convert in a_m_converts) {
    if(_model_is_exempt(m_convert)) {
      continue;
    }
    s_model = spawnStruct();
    m_convert model_convert_copy_kvps(s_model);
    m_convert delete();
    level._struct_models[str_area][level._struct_models[str_area].size] = s_model;
  }
}

model_restore_area(str_area) {
  if(!isDefined(str_area))
    str_area = "general";

  assert(isDefined(level._struct_models[str_area]), "The area specified does not exist.It was either not converted or already restored.");

  foreach(s_model in level._struct_models[str_area]) {
    if(isDefined(s_model)) {
      m_restore = spawn("script_model", s_model.origin, s_model.spawnflags_copy, undefined, undefined, s_model.destructibledef);
      s_model model_convert_copy_kvps(m_restore);
      s_model structdelete();
    }
  }

  level._struct_models[str_area] = undefined;
}

model_restore(str_value, str_key) {
  str_area = "general";

  if(str_key == "targetname") {
    foreach(s_model in level._struct_models[str_area]) {
      if(isDefined(s_model) && isDefined(s_model.targetname) && s_model.targetname == str_value) {
        m_restore = spawn("script_model", s_model.origin, s_model.spawnflags_copy, undefined, undefined, s_model.destructibledef);
        s_model model_convert_copy_kvps(m_restore);
        s_model structdelete();
      }
    }
  } else if(str_key == "target") {
    foreach(s_model in level._struct_models[str_area]) {
      if(isDefined(s_model) && isDefined(s_model.target) && s_model.target == str_value) {
        m_restore = spawn("script_model", s_model.origin, s_model.spawnflags_copy, undefined, undefined, s_model.destructibledef);
        s_model model_convert_copy_kvps(m_restore);
        s_model structdelete();
      }
    }
  } else if(str_key == "script_noteworthy") {
    foreach(s_model in level._struct_models[str_area]) {
      if(isDefined(s_model) && isDefined(s_model.script_noteworthy) && s_model.script_noteworthy == str_value) {
        m_restore = spawn("script_model", s_model.origin, s_model.spawnflags_copy, undefined, undefined, s_model.destructibledef);
        s_model model_convert_copy_kvps(m_restore);
        s_model structdelete();
      }
    }
  }
}

model_convert_copy_kvps(target) {
  if(isDefined(self.angles))
    target.angles = self.angles;

  if(isDefined(self.destructibledef)) {
    target.destructibledef = self.destructibledef;

    if(issubstr(target.destructibledef, "barrel")) {
      target.target = self.target;

      if(!isDefined(self.classname))
        target thread maps\_destructible::destructible_barrel_death_think();
    }
  }

  if(isDefined(self.origin))
    target.origin = self.origin;

  if(isDefined(self.model))
    target.model_name = self.model;

  if(isDefined(self.hidden)) {
    if(self.hidden)
      target hide();
  } else if(self ishidden())
    target.hidden = 1;
  else
    target.hidden = 0;

  if(isDefined(self.model_name)) {
    if(isDefined(target.classname) && target.classname == "script_model")
      target setModel(self.model_name);
  }

  if(isDefined(self.script_float))
    target.script_float = self.script_float;

  if(isDefined(self.script_int))
    target.script_int = self.script_int;

  if(isDefined(self.script_noteworthy))
    target.script_noteworthy = self.script_noteworthy;

  if(isDefined(self.script_string))
    target.script_string = self.script_string;

  if(isDefined(self.spawnflags))
    target.spawnflags_copy = self.spawnflags;

  if(isDefined(self.targetname))
    target.targetname = self.targetname;
}

model_delete_area(area) {
  if(isstring(area))
    e_area = getent(area, "script_noteworthy");

  i = 0;
  a_m_converts = getEntArray("script_model", "classname");

  foreach(m_convert in a_m_converts) {
    if(_model_is_exempt(m_convert) || !m_convert istouching(e_area)) {
      continue;
    }
    if(isDefined(m_convert.destructibledef)) {
      if(issubstr(m_convert.destructibledef, "barrel")) {
        if(isDefined(m_convert.target)) {
          m_clip = getent(m_convert.target, "targetname");

          if(isDefined(m_clip))
            m_clip delete();
        }
      }
    }

    m_convert delete();
    i++;

    if(i % 5)
      wait 0.05;
  }
}

_model_is_exempt(m_convert) {
  if(!isDefined(m_convert) || isDefined(m_convert.script_convert) && !m_convert.script_convert)
    return true;

  if(isDefined(m_convert.script_noteworthy)) {
    switch (m_convert.script_noteworthy) {
      case "fxanim":
        return true;
    }
  }

  if(isDefined(m_convert.script_exploder) || isDefined(m_convert.script_prefab_exploder))
    return true;

  if(isDefined(m_convert.targetname)) {
    switch (m_convert.targetname) {
      case "collectible":
      case "sys_ammo_cache":
      case "sys_weapon_cache":
      case "trigger_ammo_refill":
        return true;
    }
  }

  return false;
}