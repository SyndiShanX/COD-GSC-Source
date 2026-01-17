/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\grapple.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace grapple;

function autoexec __init__sytem__() {
  system::register("grapple", &__init__, &__main__, undefined);
}

function __init__() {
  callback::on_spawned(&watch_for_grapple);
}

function __main__() {
  grapple_targets = getEntArray("grapple_target", "targetname");
  foreach(target in grapple_targets) {
    target.grapple_type = 1;
    target setgrapplabletype(target.grapple_type);
  }
}

function translate_notify_1(from_notify, to_notify) {
  self endon("disconnect");
  self endon("death");
  self endon("spawned_player");
  while(isDefined(self)) {
    self waittill(from_notify, param1, param2, param3);
    self notify(to_notify, from_notify, param1, param2, param3);
  }
}

function watch_for_grapple() {
  self endon("disconnect");
  self endon("death");
  self endon("spawned_player");
  self endon("killreplaygunmonitor");
  self thread translate_notify_1("weapon_switch_started", "grapple_weapon_change");
  self thread translate_notify_1("weapon_change_complete", "grapple_weapon_change");
  while(true) {
    self waittill("grapple_weapon_change", event, weapon);
    if(isDefined(weapon.grappleweapon) && weapon.grappleweapon) {
      self thread watch_lockon(weapon);
    } else {
      self notify("grapple_unwield");
    }
  }
}

function watch_lockon(weapon) {
  self endon("disconnect");
  self endon("death");
  self endon("spawned_player");
  self endon("grapple_unwield");
  self notify("watch_lockon");
  self endon("watch_lockon");
  self thread watch_lockon_angles(weapon);
  self thread clear_lockon_after_grapple(weapon);
  self.use_expensive_targeting = 1;
  while(true) {
    wait(0.05);
    if(!self isgrappling()) {
      target = self get_a_target(weapon);
      if(!self isgrappling() && !target === self.lockonentity) {
        self weaponlocknoclearance(!target === self.dummy_target);
        self.lockonentity = target;
        wait(0.1);
      }
    }
  }
}

function clear_lockon_after_grapple(weapon) {
  self endon("disconnect");
  self endon("death");
  self endon("spawned_player");
  self endon("grapple_unwield");
  self notify("clear_lockon_after_grapple");
  self endon("clear_lockon_after_grapple");
  while(true) {
    self util::waittill_any("grapple_pulled", "grapple_landed");
    if(isDefined(self.lockonentity)) {
      self.lockonentity = undefined;
      self.use_expensive_targeting = 1;
    }
  }
}

function watch_lockon_angles(weapon) {
  self endon("disconnect");
  self endon("death");
  self endon("spawned_player");
  self endon("grapple_unwield");
  self notify("watch_lockon_angles");
  self endon("watch_lockon_angles");
  while(true) {
    wait(0.05);
    if(!self isgrappling()) {
      if(isDefined(self.lockonentity)) {
        if(self.lockonentity === self.dummy_target) {
          self weaponlocktargettooclose(0);
        } else {
          testorigin = get_target_lock_on_origin(self.lockonentity);
          if(!self inside_screen_angles(testorigin, weapon, 0)) {
            self weaponlocktargettooclose(1);
          } else {
            self weaponlocktargettooclose(0);
          }
        }
      }
    }
  }
}

function place_dummy_target(origin, forward, weapon) {
  if(!isDefined(self.dummy_target)) {
    self.dummy_target = spawn("script_origin", origin);
  }
  self.dummy_target setgrapplabletype(3);
  start = origin;
  distance = weapon.lockonmaxrange * 0.9;
  if(isDefined(level.grapple_notarget_distance)) {
    distance = level.grapple_notarget_distance;
  }
  end = origin + (forward * distance);
  if(!self isgrappling()) {
    self.dummy_target.origin = self trace(start, end, self.dummy_target);
  }
  minrange_sq = weapon.lockonminrange * weapon.lockonminrange;
  if(distancesquared(self.dummy_target.origin, origin) < minrange_sq) {
    return undefined;
  }
  return self.dummy_target;
}

function get_a_target(weapon) {
  origin = self getEye();
  forward = self getweaponforwarddir();
  targets = getgrappletargetarray();
  if(!isDefined(targets)) {
    return undefined;
  }
  if(!isDefined(weapon.lockonscreenradius) || weapon.lockonscreenradius < 1) {
    return undefined;
  }
  validtargets = [];
  should_wait = 0;
  should_wait_limit = 2;
  if(isDefined(self.use_expensive_targeting) && self.use_expensive_targeting) {
    should_wait_limit = 4;
    self.use_expensive_targeting = 0;
  }
  for(i = 0; i < targets.size; i++) {
    if(should_wait >= should_wait_limit) {
      wait(0.05);
      origin = self getweaponmuzzlepoint();
      forward = self getweaponforwarddir();
      should_wait = 0;
    }
    testtarget = targets[i];
    if(!is_valid_target(testtarget)) {
      continue;
    }
    testorigin = get_target_lock_on_origin(testtarget);
    test_range = distance(origin, testorigin);
    if(test_range > weapon.lockonmaxrange || test_range < weapon.lockonminrange) {
      continue;
    }
    normal = vectornormalize(testorigin - origin);
    dot = vectordot(forward, normal);
    if(0 > dot) {
      continue;
    }
    if(!self inside_screen_angles(testorigin, weapon, !testtarget === self.lockonentity)) {
      continue;
    }
    cansee = self can_see(testtarget, testorigin, origin, forward, 30);
    should_wait++;
    if(cansee) {
      validtargets[validtargets.size] = testtarget;
    }
  }
  best = pick_a_target_from(validtargets, origin, forward, weapon.lockonminrange, weapon.lockonmaxrange);
  if(isDefined(level.grapple_notarget_enabled) && level.grapple_notarget_enabled) {
    if(!isDefined(best) || best === self.dummy_target) {
      best = place_dummy_target(origin, forward, weapon);
    }
  }
  return best;
}

function get_target_type_score(target) {
  if(!isDefined(target)) {
    return 0;
  }
  if(target === self.dummy_target) {
    return 0;
  }
  if(target.grapple_type === 1) {
    return 1;
  }
  if(target.grapple_type === 2) {
    return 0.985;
  }
  if(!isDefined(target.grapple_type)) {
    return 0.9;
  }
  if(target.grapple_type === 3) {
    return 0.75;
  }
  return 0;
}

function get_target_score(target, origin, forward, min_range, max_range) {
  if(!isDefined(target)) {
    return -1;
  }
  if(target === self.dummy_target) {
    return 0;
  }
  if(is_valid_target(target)) {
    testorigin = get_target_lock_on_origin(target);
    normal = vectornormalize(testorigin - origin);
    dot = vectordot(forward, normal);
    targetdistance = distance(self.origin, testorigin);
    distance_score = 1 - (targetdistance - min_range) / (max_range - min_range);
    type_score = get_target_type_score(target);
    return (type_score * pow(dot, 0.85)) * pow(distance_score, 0.15);
  }
  return -1;
}

function pick_a_target_from(targets, origin, forward, min_range, max_range) {
  if(!isDefined(targets)) {
    return undefined;
  }
  besttarget = undefined;
  bestscore = undefined;
  for(i = 0; i < targets.size; i++) {
    target = targets[i];
    if(is_valid_target(target)) {
      score = get_target_score(target, origin, forward, min_range, max_range);
      if(!isDefined(besttarget) || !isDefined(bestscore)) {
        besttarget = target;
        bestscore = score;
        continue;
      }
      if(score > bestscore) {
        besttarget = target;
        bestscore = score;
      }
    }
  }
  return besttarget;
}

function trace(from, to, target) {
  trace = bulletTrace(from, to, 0, self, 1, 0, target);
  return trace["position"];
}

function can_see(target, target_origin, player_origin, player_forward, distance) {
  start = player_origin + (player_forward * distance);
  end = target_origin - (player_forward * distance);
  collided = self trace(start, end, target);
  if(distance2dsquared(end, collided) > 9) {
    if(getdvarint("")) {
      line(start, collided, (0, 0, 1), 1, 0, 50);
      line(collided, end, (1, 0, 0), 1, 0, 50);
    }
    return false;
  }
  if(getdvarint("")) {
    line(start, end, (0, 1, 0), 1, 0, 30);
  }
  return true;
}

function is_valid_target(ent) {
  if(isDefined(ent) && isDefined(level.grapple_valid_target_check)) {
    if(![
        [level.grapple_valid_target_check]
      ](ent)) {
      return 0;
    }
  }
  return isDefined(ent) && (isalive(ent) || !issentient(ent));
}

function inside_screen_angles(testorigin, weapon, newtarget) {
  hang = weapon.lockonlossanglehorizontal;
  if(newtarget) {
    hang = weapon.lockonanglehorizontal;
  }
  vang = weapon.lockonlossanglevertical;
  if(newtarget) {
    vang = weapon.lockonanglevertical;
  }
  angles = self gettargetscreenangles(testorigin);
  return abs(angles[0]) < hang && abs(angles[1]) < vang;
}

function inside_screen_crosshair_radius(testorigin, weapon) {
  radius = weapon.lockonscreenradius;
  return self inside_screen_radius(testorigin, radius);
}

function inside_screen_lockon_radius(targetorigin) {
  radius = self getlockonradius();
  return self inside_screen_radius(targetorigin, radius);
}

function inside_screen_radius(targetorigin, radius) {
  return target_originisincircle(targetorigin, self, 65, radius);
}

function get_target_lock_on_origin(target) {
  return self getlockonorigin(target);
}