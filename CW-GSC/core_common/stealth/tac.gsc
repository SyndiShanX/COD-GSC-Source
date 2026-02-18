/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\stealth\tac.gsc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\smart_object;
#namespace namespace_206491b4;

function function_24b5e32(pos) {
  pos = goal_origin(pos);

  if(isDefined(self.smart_object)) {
    return self.smart_object smart_object::get_goal().angles;
  }

  if(is_true(self.limitstealthturning)) {
    return vectortoangles(pos - self.origin);
  }

  lookdir = findopenlookdir(pos);

  if(isDefined(lookdir)) {
    return vectortoangles(lookdir);
  }
}

function findopenlookdir(from, radius = 256, mindist = 96) {
  from = goal_origin(from);
  space = ai::t_cylinder(from, radius, 128);
  tacpoints = isDefined(tacticalquery("stealth_open_view_space", from, space)) ? tacticalquery("stealth_open_view_space", from, space) : [];
  mindistsq = sqr(mindist);

  foreach(tac in tacpoints) {
    if(distancesquared(from, tac.origin) > mindistsq) {
      dir = tac.origin - from;
      return vectornormalize((dir[0], dir[1], 0));
    }
  }
}

function findclosestnonlospointwithinradius(center, radius, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius) {
  cylinder = ai::t_cylinder(center, radius, 128);
  return function_a4b83b6a("stealth_closest_non_los_space", cylinder, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius);
}

function findclosestnonlospointwithinvolume(vol, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius) {
  return function_a4b83b6a("stealth_closest_non_los_space", vol, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius);
}

function findclosestlospointwithinradius(center, radius, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius) {
  cylinder = ai::t_cylinder(center, radius, 128);
  return function_a4b83b6a("stealth_closest_los_space", cylinder, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius);
}

function findclosestlospointwithinvolume(vol, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius) {
  return function_a4b83b6a("stealth_closest_los_space", vol, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius);
}

function private function_a4b83b6a(tacquery, space, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius) {
  tacpoints = isDefined(tacticalquery(tacquery, space.origin, space, var_72cc3c18, var_465a4fd5)) ? tacticalquery(tacquery, space.origin, space, var_72cc3c18, var_465a4fd5) : [];

  if(isDefined(ignorepoints)) {
    assert(isDefined(ignoreradius));
    var_dfdc1e6f = sqr(ignoreradius);
    var_fdba779a = [];

    foreach(tac in tacpoints) {
      ignored = 0;

      foreach(point in ignorepoints) {
        if(distancesquared(point.origin, tac.origin) < var_dfdc1e6f) {
          ignored = 1;
          break;
        }
      }

      if(!ignored) {
        var_fdba779a[var_fdba779a.size] = tac;
      }
    }

    tacpoints = var_fdba779a;
  }

  if(tacpoints.size > 0) {
    return tacpoints[0].origin;
  }

  return var_465a4fd5;
}

function private goal_origin(goal) {
  if(isvec(goal)) {
    return goal;
  }

  return goal.origin;
}