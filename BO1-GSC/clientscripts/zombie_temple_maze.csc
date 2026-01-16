/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_temple_maze.csc
************************************************/

#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\_zombiemode_weapons;

maze_trap_move_wall(localClientNum, active) {
  if(!isDefined(self.wall)) {
    self set_maze_trap_wall(localClientNum);
  }
  wall = self.wall;
  if(isDefined(wall)) {
    wall thread maze_wall_init(localClientNum);
    wall thread move_maze_wall(active);
  }
}

maze_wall_init(localClientNum) {
  if(!isDefined(self.init) || !self.init) {
    self init_maze_mover(-128, 0.25, 1.0, true, "evt_maze_wall_down", "evt_maze_wall_up");
    self.script_fxid = level._effect["maze_wall_impact"];
    self.script_fxid2 = level._effect["maze_wall_raise"];
    self.fx_active_offset = (0, 0, -60);
    self.fx_active2_offset = (0, 0, -60);
    self.init = true;
    self.client_num = localClientNum;
  }
}

init_maze_mover(moveDist, moveUpTime, moveDownTime, blocksPaths, moveUpSound, moveDownSound) {
  self.isActive = false;
  self.activeCount = 0;
  self.isMoving = false;
  self.moveDist = moveDist;
  self.activeHeight = self.origin[2] + moveDist;
  self.moveUpTime = moveUpTime;
  self.moveDownTime = moveDownTime;
  self.pathBlocker = false;
  self.alwaysActive = false;
  self.moveUpSound = moveUpSound;
  self.moveDownSound = moveDownSound;
  self.startAngles = self.angles;
}

move_maze_wall(active) {
  if(active && isDefined(self.moveUpSound)) {}
  if(!active && isDefined(self.moveDownSound)) {}
  goalPos = (self.origin[0], self.origin[1], self.activeHeight);
  if(!active) {
    goalPos = (goalPos[0], goalPos[1], goalPos[2] - self.moveDist);
  }
  moveTime = self.moveUpTime;
  if(!active) {
    moveTime = self.moveDownTime;
  }
  if(self.isMoving) {
    currentZ = self.origin[2];
    goalZ = goalPos[2];
    ratio = Abs(goalZ - currentZ) / Abs(self.moveDist);
    moveTime *= ratio;
  }
  self notify("stop_maze_mover");
  self.isActive = active;
  self thread _maze_mover_move(goalPos, moveTime);
}

set_maze_trap_wall(localClientNum) {
  walls = GetEntArray(localClientNum, "maze_trap_wall", "targetname");
  bestWall = undefined;
  bestDist = undefined;
  for(i = 0; i < walls.size; i++) {
    wall = walls[i];
    if(isDefined(wall.assigned)) {
      continue;
    }
    dist = distanceSquared(self.origin, wall.origin);
    if(!isDefined(bestDist) || dist < bestDist) {
      bestDist = dist;
      bestWall = wall;
    }
  }
  self.wall = bestWall;
  if(isDefined(self.wall)) {
    self.wall.assigned = true;
  }
}

_maze_mover_move(goal, time) {
  self endon("stop_maze_mover");
  self.isMoving = true;
  if(time == 0) {
    time = .01;
  }
  self moveTo(goal, time);
  self waittill("movedone");
  self.isMoving = false;
  if(self.isActive) {
    _maze_mover_play_fx(self.script_fxid, self.fx_active_offset);
  } else {
    _maze_mover_play_fx(self.script_fxid2, self.fx_active2_offset);
  }
}

_maze_mover_play_fx(fx_name, offset) {
  if(isDefined(fx_name)) {
    vFwd = AnglesToForward(self.angles);
    org = self.origin;
    if(isDefined(offset)) {
      org += offset;
    }
    PlayFX(self.client_num, fx_name, org, vFwd, (0, 0, 1));
  }
}