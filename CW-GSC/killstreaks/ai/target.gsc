/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\ai\target.gsc
***********************************************/

#using scripts\core_common\targetting_delay;
#using scripts\core_common\util_shared;
#namespace ai_target;

function function_d15dd929(radius, origin) {
  result = function_9cc082d2(origin + (0, 0, 100), 200);

  if(isDefined(result) && isDefined(result[#"materialflags"]) && result[#"materialflags"] & 2) {
    return false;
  }

  return true;
}

function is_target_valid(target) {
  if(!isDefined(target)) {
    return false;
  }

  if(!isalive(target)) {
    return false;
  }

  if(isPlayer(target) && target.sessionstate == "spectator") {
    return false;
  }

  if(isPlayer(target) && target.sessionstate == "intermission") {
    return false;
  }

  if(is_true(level.intermission)) {
    return false;
  }

  if(is_true(target.ignoreme)) {
    return false;
  }

  if(target isnotarget()) {
    return false;
  }

  if(issentient(target) && self function_ce6d3545(target)) {
    return false;
  }

  if(!util::function_fbce7263(self.team, target.team)) {
    return false;
  }

  if(isPlayer(target)) {
    if(target isplayerswimming()) {
      return false;
    }

    waterdepth = target depthofplayerinwater();

    if(waterdepth > 2) {
      return false;
    }

    radius = self getpathfindingradius();

    if(!function_d15dd929(radius, target.origin)) {
      return false;
    }
  }

  if(target depthinwater() >= 10) {
    return false;
  }

  return true;
}

function get_targets() {
  targets = [];
  targets = arraycombine(getplayers(), getactorarray(), 0, 0);
  valid_targets = [];

  foreach(target in targets) {
    if(!is_target_valid(target)) {
      continue;
    }

    if(!isDefined(valid_targets)) {
      valid_targets = [];
    } else if(!isarray(valid_targets)) {
      valid_targets = array(valid_targets);
    }

    valid_targets[valid_targets.size] = target;
  }

  return valid_targets;
}

function function_84235351(attack_origin, var_edc20efd) {
  targets = self get_targets();
  var_e0c224a4 = var_edc20efd * var_edc20efd;
  least_hunted = undefined;
  closest_target_dist_squared = undefined;

  foreach(target in targets) {
    if(!isDefined(target.hunted_by)) {
      target.hunted_by = 0;
    }

    attackedrecently = 0;

    if(issentient(target)) {
      attackedrecently = target attackedrecently(self, 3);

      if(is_true(attackedrecently)) {
        return target;
      }
    }

    if(self function_ce6d3545(target)) {
      continue;
    }

    if(isPlayer(target) && target isgrappling()) {
      continue;
    }

    if(!isDefined(getclosestpointonnavmesh(target.origin, 200, 1.2 * self getpathfindingradius()))) {
      continue;
    }

    dist_squared = distancesquared(attack_origin, target.origin);
    var_e294ac7d = isPlayer(target) ? target function_d730727f() : 1;
    var_97f7ad10 = var_e0c224a4 * var_e294ac7d;

    if(dist_squared > var_97f7ad10) {
      continue;
    }

    if(!self is_target_valid(least_hunted)) {
      least_hunted = target;
    }

    if(target.hunted_by <= least_hunted.hunted_by && (!isDefined(closest_target_dist_squared) || dist_squared < closest_target_dist_squared)) {
      least_hunted = target;
      closest_target_dist_squared = dist_squared;
    }
  }

  if(!self is_target_valid(least_hunted)) {
    return undefined;
  }

  least_hunted.hunted_by += 1;
  return least_hunted;
}

function function_a13468f5(attack_origin, var_edc20efd) {
  targets = self get_targets();
  valid_targets = [];
  var_e0c224a4 = var_edc20efd * var_edc20efd;

  foreach(target in targets) {
    dist_squared = distancesquared(attack_origin, target.origin);

    if(dist_squared > var_e0c224a4) {
      continue;
    }

    if(self function_ce6d3545(target)) {
      continue;
    }

    if(self is_target_valid(target)) {
      valid_targets[valid_targets.size] = target;
    }
  }

  if(valid_targets.size) {
    return valid_targets[0];
  }

  return undefined;
}