/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\replay_gun.gsc
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
#namespace replay_gun;

function autoexec __init__sytem__() {
  system::register("replay_gun", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_spawned( & watch_for_replay_gun);
}

function watch_for_replay_gun() {
  self endon("disconnect");
  self endon("death");
  self endon("spawned_player");
  self endon("killreplaygunmonitor");
  while (true) {
    self waittill("weapon_change_complete", weapon);
    self weaponlockfree();
    if(isdefined(weapon.usespivottargeting) && weapon.usespivottargeting) {
      self thread watch_lockon(weapon);
    }
  }
}

function watch_lockon(weapon) {
  self endon("disconnect");
  self endon("death");
  self endon("spawned_player");
  self endon("weapon_change_complete");
  while (true) {
    wait(0.05);
    if(!isdefined(self.lockonentity)) {
      ads = self playerads() == 1;
      if(ads) {
        target = self get_a_target(weapon);
        if(is_valid_target(target)) {
          self weaponlockfree();
          self.lockonentity = target;
        }
      }
    }
  }
}

function get_a_target(weapon) {
  origin = self getweaponmuzzlepoint();
  forward = self getweaponforwarddir();
  targets = self get_potential_targets();
  if(!isdefined(targets)) {
    return undefined;
  }
  if(!isdefined(weapon.lockonscreenradius) || weapon.lockonscreenradius < 1) {
    return undefined;
  }
  validtargets = [];
  should_wait = 0;
  for (i = 0; i < targets.size; i++) {
    if(should_wait) {
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
    if(!self inside_screen_crosshair_radius(testorigin, weapon)) {
      continue;
    }
    cansee = self can_see_projected_crosshair(testtarget, testorigin, origin, forward, test_range);
    should_wait = 1;
    if(cansee) {
      validtargets[validtargets.size] = testtarget;
    }
  }
  return pick_a_target_from(validtargets);
}

function get_potential_targets() {
  str_opposite_team = "axis";
  if(self.team == "axis") {
    str_opposite_team = "allies";
  }
  potentialtargets = [];
  aitargets = getaiteamarray(str_opposite_team);
  if(aitargets.size > 0) {
    potentialtargets = arraycombine(potentialtargets, aitargets, 1, 0);
  }
  playertargets = self getenemies();
  if(playertargets.size > 0) {
    potentialtargets = arraycombine(potentialtargets, playertargets, 1, 0);
  }
  if(potentialtargets.size == 0) {
    return undefined;
  }
  return potentialtargets;
}

function pick_a_target_from(targets) {
  if(!isdefined(targets)) {
    return undefined;
  }
  besttarget = undefined;
  besttargetdistancesquared = undefined;
  for (i = 0; i < targets.size; i++) {
    target = targets[i];
    if(is_valid_target(target)) {
      targetdistancesquared = distancesquared(self.origin, target.origin);
      if(!isdefined(besttarget) || !isdefined(besttargetdistancesquared)) {
        besttarget = target;
        besttargetdistancesquared = targetdistancesquared;
        continue;
      }
      if(targetdistancesquared < besttargetdistancesquared) {
        besttarget = target;
        besttargetdistancesquared = targetdistancesquared;
      }
    }
  }
  return besttarget;
}

function trace(from, to) {
  return bullettrace(from, to, 0, self)["position"];
}

function can_see_projected_crosshair(target, target_origin, player_origin, player_forward, distance) {
  crosshair = player_origin + (player_forward * distance);
  collided = target trace(target_origin, crosshair);
  if(distance2dsquared(crosshair, collided) > 9) {
    return false;
  }
  collided = self trace(player_origin, crosshair);
  if(distance2dsquared(crosshair, collided) > 9) {
    return false;
  }
  return true;
}

function is_valid_target(ent) {
  return isdefined(ent) && isalive(ent);
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
  return self getreplaygunlockonorigin(target);
}