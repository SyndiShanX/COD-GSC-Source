/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\ai\patrol.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\entityheadicons_shared;
#include scripts\killstreaks\ai\escort;
#include scripts\killstreaks\ai\state;
#include scripts\killstreaks\ai\target;

#namespace ai_patrol;

init() {
  ai_state::function_e9b061a8(0, &function_42ed4af0, &update_patrol, &function_97a138d5, &update_enemy, &function_4af1ff64, &function_a78474f2);
}

function_7d8be726(patrol_radius, var_edc20efd, var_d73e0c6e, marker_fx, marker_objective, var_861daf20, var_a85cb855, var_52e43a03, var_544ae93d, var_7d9560c1) {
  assert(isDefined(self.ai));
  self.ai.patrol = {
    #state: 2, 
    #patrol_radius: patrol_radius, 
    #var_edc20efd: var_edc20efd, 
    #var_d73e0c6e: var_d73e0c6e, 
    #marker_fx: marker_fx, 
    #marker_objective: marker_objective, 
    #var_861daf20: var_861daf20, 
    #var_a85cb855: var_a85cb855, 
    #var_52e43a03: var_52e43a03, 
    #var_544ae93d: var_544ae93d, 
    #var_7d9560c1: var_7d9560c1
  };
}

function_d091ff45(bundle) {
  function_7d8be726(bundle.var_a562774d, bundle.var_c9cb1de0, bundle.var_dabf2484, bundle.var_91b6778, bundle.objective, bundle.var_e5ca8662, bundle.var_ee982290, bundle.var_2725e0d9, bundle.var_4b395366, bundle.var_4ac4f036);
}

function_42ed4af0() {
  self.ai.patrol.var_81f76ce3 = gettime();
  self.goalradius = self.ai.patrol.patrol_radius;
  self function_d4c687c9();
  self.ai.patrol.state = 2;

  if(isDefined(self.script_owner)) {
    self function_325c6829(self.script_owner.origin);
    return;
  }

  self function_325c6829(self.origin);
}

function_97a138d5() {
  self function_3ec67269();
}

function_4af1ff64() {
  if(self function_63b383f3()) {
    return self.ai.patrol.var_edc20efd;
  }

  return self.ai.patrol.var_d73e0c6e;
}

function_a78474f2() {
  if(self function_63b383f3()) {
    return self.ai.patrol.var_9033671b;
  }

  return self.origin;
}

function_63b383f3() {
  if(self.ai.patrol.state == 1) {
    return true;
  }

  return false;
}

function_6f09c87() {
  if(self.ai.patrol.state == 1 || self.ai.patrol.state == 2) {
    return true;
  }

  return false;
}

private function_72f5ecf2(current_point, points) {
  new_points = [];
  var_ef358bee = self.ai.patrol.var_a85cb855 * self.ai.patrol.var_a85cb855;

  foreach(point in points) {
    dist2 = distancesquared(current_point, point.origin);

    if(dist2 < var_ef358bee) {
      continue;
    }

    new_points[new_points.size] = point;
  }

  return new_points;
}

function_cd106dcf(left, right) {
  return left.dot > right.dot;
}

private function_12270700(origin, angles, points) {
  foreach(point in points) {
    point.dot = vectordot(self.var_ffa7c9d, vectornormalize(point.origin - origin));
  }

  return array::merge_sort(points, &function_cd106dcf);
}

function_6155a7ca(var_9033671b) {
  var_d9910e8a = undefined;

  if(isDefined(self.script_owner) && isalive(self.script_owner)) {
    var_d9910e8a = ai::t_cylinder(self.script_owner.origin, 200, self.ai.patrol.var_52e43a03);
  } else {
    var_d9910e8a = ai::t_cylinder(var_9033671b, 200, self.ai.patrol.var_52e43a03);
  }

  var_cd26c30e = ai_target::function_a13468f5(var_9033671b, self.ai.patrol.patrol_radius * 1.5);
  tacpoints = undefined;

  if(isDefined(var_cd26c30e) && isDefined(self.ai.patrol.var_7d9560c1)) {
    closesttacpoint = getclosesttacpoint(var_cd26c30e.origin);

    if(isDefined(closesttacpoint)) {
      cylinder = ai::t_cylinder(closesttacpoint.origin, 150, self.ai.patrol.var_52e43a03);
      tacpoints = tacticalquery(self.ai.patrol.var_7d9560c1, cylinder, self, var_cd26c30e, var_d9910e8a);

      if(isDefined(tacpoints) && tacpoints.size) {
        self.ai.patrol.var_cd26c30e = var_cd26c30e;
      }
    }
  }

  if(!isDefined(tacpoints) || tacpoints.size == 0) {
    cylinder = ai::t_cylinder(var_9033671b, self.ai.patrol.patrol_radius, self.ai.patrol.var_52e43a03);
    tacpoints = tacticalquery(self.ai.patrol.var_544ae93d, cylinder, self, var_d9910e8a);
  }

  if(isDefined(tacpoints) && tacpoints.size) {
    tacpoints = function_72f5ecf2(self.origin, tacpoints);

    if(!isDefined(var_cd26c30e) && isDefined(tacpoints) && tacpoints.size) {
      tacpoints = function_12270700(self.origin, self.angles, tacpoints);
    }
  }

  if(!isDefined(tacpoints) || tacpoints.size == 0) {
    return undefined;
  }

  return tacpoints;
}

function_94d884e4(var_9033671b) {
  if(!isDefined(self.var_ffa7c9d)) {
    self.var_ffa7c9d = anglesToForward(self.angles);
  }

  tacpoints = self function_6155a7ca(var_9033671b);

  if(isDefined(tacpoints) && tacpoints.size > 0) {
    tacpoints = ai_escort::function_cb4925e3(tacpoints);

    if(isDefined(tacpoints) && tacpoints.size > 0) {
      self.var_36299b51 = tacpoints;
      newpos = getclosestpointonnavmesh(tacpoints[0].origin, self.goalradius, self.ai.patrol.var_861daf20);

      if(isDefined(newpos)) {
        self.var_ffa7c9d = vectornormalize(newpos - self.origin);
        return newpos;
      }
    }
  }

  return undefined;
}

private is_debugging(dvar) {
  if(getdvarint(dvar, 0)) {
    return 1;
  }

  return 0;
}

  function function_38d931e7() {
    goalinfo = self function_4794d6a3();

    if(!isDefined(goalinfo.var_9e404264) || goalinfo.var_9e404264) {
      return true;
    }

    return false;
  }

function_6b33bfb8(radius) {
  if(self function_38d931e7()) {
    return true;
  }

  goalinfo = self function_4794d6a3();

  if(isDefined(goalinfo.overridegoalpos)) {
    var_fca0ef39 = radius;
    var_1ba37935 = var_fca0ef39 * var_fca0ef39;

    if(distancesquared(goalinfo.overridegoalpos, self.origin) <= var_1ba37935) {
      return true;
    }
  }

  return false;
}

update_patrol() {
  if(!self function_6f09c87()) {
    return;
  }

  if(isDefined(self.isarriving) && self.isarriving) {
    return;
  }

  assert(isDefined(self.ai.patrol.var_9033671b));
  goalinfo = self function_4794d6a3();

  if(self.ai.patrol.state == 2) {
    self.goalradius = 150;

    if(!isDefined(goalinfo.overridegoalpos)) {
      newpos = getclosestpointonnavmesh(self.ai.patrol.var_9033671b, self.goalradius, self.ai.patrol.var_861daf20);

      if(isDefined(newpos)) {
        self.ai.patrol.var_81f76ce3 = gettime() + randomintrange(3000, 4500);
        self function_a57c34b7(newpos);
      }
    }

    var_1fc6a9ae = function_6b33bfb8(self.goalradius);

    if(var_1fc6a9ae) {
      self.ai.patrol.var_81f76ce3 = gettime() + randomintrange(2000, 3500);
      self.goalradius = self.ai.patrol.patrol_radius;
      self.ai.patrol.state = 1;
    }
  } else if(self.ai.patrol.state == 1) {
    var_1d1d42ba = 0;
    var_1fc6a9ae = function_6b33bfb8(20);
    var_cd26c30e = ai_target::function_a13468f5(self.ai.patrol.var_9033671b, self.ai.patrol.patrol_radius * 1.5);
    var_43c8852a = 0;

    if(isDefined(var_cd26c30e)) {
      if(!isDefined(self.ai.patrol.var_cd26c30e) || self.ai.patrol.var_cd26c30e != var_cd26c30e) {
        var_43c8852a = 1;
      }
    }

    if(!isDefined(goalinfo.overridegoalpos) || var_43c8852a) {
      var_1d1d42ba = 1;
    } else if(var_1fc6a9ae) {
      if(gettime() >= self.ai.patrol.var_81f76ce3) {
        var_1d1d42ba = 1;
      }
    }

    if(var_1d1d42ba) {
      newpos = self function_94d884e4(self.ai.patrol.var_9033671b);

      if(isDefined(newpos)) {
        self function_a57c34b7(newpos);
      }
    }
  }

  recordcircle(self.ai.patrol.var_9033671b, self.ai.patrol.patrol_radius, (0, 0, 1), "<dev string:x38>");
  recordcircle(self.ai.patrol.var_9033671b, self.ai.patrol.var_edc20efd, (1, 0, 0), "<dev string:x38>");

}

update_enemy() {
  if(isDefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy) {
    self.ai.patrol.state = 0;
    return;
  }

  if(self.ai.patrol.state == 0) {
    self.ai.patrol.state = 2;
  }
}

private function_9a61e8fb(origin) {
  if(isDefined(self.ai.patrol.marker_objective)) {
    owner = self.script_owner;

    if(isDefined(owner)) {
      self.var_e2aca908 = spawn("script_model", origin);

      if(isDefined(self.var_e2aca908)) {
        self.var_e2aca908.origin = origin;
        self.var_e2aca908 entityheadicons::setentityheadicon(owner.team, owner, self.ai.patrol.marker_objective);
        headiconobjectiveid = self.var_e2aca908.entityheadobjectives[self.var_e2aca908.entityheadobjectives.size - 1];
        objective_setinvisibletoall(headiconobjectiveid);
        objective_setvisibletoplayer(headiconobjectiveid, owner);
      }
    }
  }
}

private function_732c2878() {
  if(isDefined(self.var_e2aca908)) {
    self.var_e2aca908 delete();
  }
}

private function_8d4eba95(origin) {
  if(isDefined(self.script_owner) && isDefined(self.ai.patrol.marker_fx)) {
    self.var_74e8fd19 = spawnfx(self.ai.patrol.marker_fx, origin + (0, 0, 3), (0, 0, 1), (1, 0, 0));
    self.var_74e8fd19.team = self.team;
    triggerfx(self.var_74e8fd19);
    self.var_74e8fd19 setinvisibletoall();
    self.var_74e8fd19 setvisibletoplayer(self.script_owner);
    self.script_owner playsoundtoplayer(#"uin_mp_combat_bot_guard", self.script_owner);
  }
}

private function_698793f6() {
  if(isDefined(self.var_74e8fd19)) {
    self.var_74e8fd19 delete();
    self.var_74e8fd19 = undefined;
  }
}

private function_f037571d(origin) {
  self endon(#"death");
  self function_8d4eba95(origin);
  self function_9a61e8fb(origin);
  waitframe(1);
  self thread function_7c779aaf();
}

private function_3ec67269() {
  self function_698793f6();
  self function_732c2878();
}

private function_7c779aaf() {
  self notify(#"hash_5824b020cde66d5");
  self endon(#"hash_5824b020cde66d5");
  fx_marker = self.var_74e8fd19;
  hud_marker = self.var_e2aca908;
  self waittill(#"death", #"state_changed");

  if(isDefined(self)) {
    self function_3ec67269();
    return;
  }

  if(isDefined(fx_marker)) {
    fx_marker delete();
  }

  if(isDefined(hud_marker)) {
    hud_marker delete();
  }
}

function_325c6829(origin) {
  assert(isDefined(self.ai.patrol));
  self.ai.patrol.var_9033671b = origin;
  self function_3ec67269();
  self thread function_f037571d(origin);
}