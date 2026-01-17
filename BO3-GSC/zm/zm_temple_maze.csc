/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_maze.csc
*************************************************/

#namespace zm_temple_maze;

function maze_trap_move_wall(localclientnum, active) {
  if(!isDefined(self.wall)) {
    self set_maze_trap_wall(localclientnum);
  }
  wall = self.wall;
  if(isDefined(wall)) {
    wall thread maze_wall_init(localclientnum);
    wall thread move_maze_wall(active);
  }
}

function maze_wall_init(localclientnum) {
  if(!isDefined(self.init) || !self.init) {
    self init_maze_mover(-128, 0.25, 1, 1, "evt_maze_wall_down", "evt_maze_wall_up");
    self.script_fxid = level._effect["maze_wall_impact"];
    self.var_f88b106c = level._effect["maze_wall_raise"];
    self.fx_active_offset = vectorscale((0, 0, -1), 60);
    self.var_2f5c5654 = vectorscale((0, 0, 1), 75);
    self.init = 1;
    self.client_num = localclientnum;
  }
}

function init_maze_mover(movedist, moveuptime, movedowntime, blockspaths, moveupsound, movedownsound) {
  self.isactive = 0;
  self.activecount = 0;
  self.ismoving = 0;
  self.movedist = movedist;
  self.activeheight = self.origin[2] + movedist;
  self.moveuptime = moveuptime;
  self.movedowntime = movedowntime;
  self.pathblocker = 0;
  self.alwaysactive = 0;
  self.moveupsound = moveupsound;
  self.movedownsound = movedownsound;
  self.startangles = self.angles;
}

function move_maze_wall(active) {
  goalpos = (self.origin[0], self.origin[1], self.activeheight);
  if(!active) {
    goalpos = (goalpos[0], goalpos[1], goalpos[2] - self.movedist);
  }
  movetime = self.moveuptime;
  if(!active) {
    movetime = self.movedowntime;
  }
  if(self.ismoving) {
    currentz = self.origin[2];
    goalz = goalpos[2];
    ratio = (abs(goalz - currentz)) / abs(self.movedist);
    movetime = movetime * ratio;
  }
  self notify("stop_maze_mover", !active && isDefined(self.movedownsound), active && isDefined(self.moveupsound));
  self.isactive = active;
  self thread _maze_mover_move(goalpos, movetime);
}

function set_maze_trap_wall(localclientnum) {
  walls = getEntArray(localclientnum, "maze_trap_wall", "targetname");
  bestwall = undefined;
  bestdist = undefined;
  for(i = 0; i < walls.size; i++) {
    wall = walls[i];
    if(isDefined(wall.assigned)) {
      continue;
    }
    dist = distancesquared(self.origin, wall.origin);
    if(!isDefined(bestdist) || dist < bestdist) {
      bestdist = dist;
      bestwall = wall;
    }
  }
  self.wall = bestwall;
  if(isDefined(self.wall)) {
    self.wall.assigned = 1;
  }
}

function _maze_mover_move(goal, time) {
  self endon("stop_maze_mover");
  self.ismoving = 1;
  if(time == 0) {
    time = 0.01;
  }
  if(self.isactive === 0) {
    _maze_mover_play_fx(self.var_f88b106c, self.var_2f5c5654);
  }
  self moveto(goal, time);
  self waittill("movedone");
  self.ismoving = 0;
  if(self.isactive === 1) {
    _maze_mover_play_fx(self.script_fxid, self.fx_active_offset);
  }
}

function _maze_mover_play_fx(fx_name, offset) {
  if(isDefined(fx_name)) {
    vfwd = anglesToForward(self.angles);
    org = self.origin;
    if(isDefined(offset)) {
      org = org + offset;
    }
    playFX(self.client_num, fx_name, org, vfwd, (0, 0, 1));
  }
}