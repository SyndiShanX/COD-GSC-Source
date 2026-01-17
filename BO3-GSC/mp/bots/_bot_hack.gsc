/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\bots\_bot_hack.gsc
*************************************************/

#namespace bot_hack;

function hack_tank_get_goal_origin(tank) {
  nodes = getnodesinradiussorted(tank.origin, 256, 0, 64, "Path");
  foreach(node in nodes) {
    dir = vectornormalize(node.origin - tank.origin);
    dir = vectorscale(dir, 32);
    goal = tank.origin + dir;
    if(self findpath(self.origin, goal, 0)) {
      return goal;
    }
  }
  return undefined;
}

function hack_has_goal(tank) {
  goal = self getgoal("hack");
  if(isDefined(goal)) {
    if(distancesquared(goal, tank.origin) < 16384) {
      return true;
    }
  }
  return false;
}

function hack_at_goal() {
  if(self atgoal("hack")) {
    return true;
  }
  goal = self getgoal("hack");
  if(isDefined(goal)) {
    tanks = getEntArray("talon", "targetname");
    tanks = arraysort(tanks, self.origin);
    foreach(tank in tanks) {
      if(distancesquared(goal, tank.origin) < 16384) {
        if(isDefined(tank.trigger) && self istouching(tank.trigger)) {
          return true;
        }
      }
    }
  }
  return false;
}

function hack_goal_pregame(tanks) {
  foreach(tank in tanks) {
    if(isDefined(tank.owner)) {
      continue;
    }
    if(isDefined(tank.team) && tank.team == self.team) {
      continue;
    }
    goal = self hack_tank_get_goal_origin(tank);
    if(isDefined(goal)) {
      if(self addgoal(goal, 24, 2, "hack")) {
        self.goal_flag = tank;
        return;
      }
    }
  }
}

function hack_think() {
  if(hack_at_goal()) {
    self setstance("crouch");
    wait(0.25);
    self addgoal(self.origin, 24, 4, "hack");
    self pressusebutton(level.drone_hack_time + 1);
    wait(level.drone_hack_time + 1);
    self setstance("stand");
    self cancelgoal("hack");
  }
  tanks = getEntArray("talon", "targetname");
  tanks = arraysort(tanks, self.origin);
  if(!(isDefined(level.drones_spawned) && level.drones_spawned)) {
    self hack_goal_pregame(tanks);
  } else {
    foreach(tank in tanks) {
      if(isDefined(tank.owner) && tank.owner == self) {
        continue;
      }
      if(!isDefined(tank.owner)) {
        if(self hack_has_goal(tank)) {
          return;
        }
        goal = self hack_tank_get_goal_origin(tank);
        if(isDefined(goal)) {
          self addgoal(goal, 24, 2, "hack");
          return;
        }
      }
      if(tank.isstunned && distancesquared(self.origin, tank.origin) < 262144) {
        goal = self hack_tank_get_goal_origin(tank);
        if(isDefined(goal)) {
          self addgoal(goal, 24, 3, "hack");
          return;
        }
      }
    }
    foreach(tank in tanks) {
      if(isDefined(tank.owner) && tank.owner == self) {
        continue;
      }
      if(tank.isstunned) {
        continue;
      }
      if(self throwgrenade(getweapon("emp_grenade"), tank.origin)) {
        self waittill("grenade_fire");
        goal = self hack_tank_get_goal_origin(tank);
        if(isDefined(goal)) {
          self addgoal(goal, 24, 3, "hack");
          wait(0.5);
          return;
        }
      }
    }
  }
}