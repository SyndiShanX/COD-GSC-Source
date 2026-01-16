/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_traps.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_thundergun;
#using scripts\zm\zm_temple_triggers;
#namespace zm_temple_traps;

function init_temple_traps() {
  level thread spear_trap_init();
  level thread waterfall_trap_init();
  level thread init_maze_trap();
}

function trigger_wait_for_power() {
  self sethintstring(&"ZOMBIE_NEED_POWER");
  self setcursorhint("HINT_NOICON");
  self.in_use = 0;
  level flag::wait_till("power_on");
}

function spear_trap_init() {
  speartraps = getentarray("spear_trap", "targetname");
  for (i = 0; i < speartraps.size; i++) {
    speartrap = speartraps[i];
    speartrap.clip = getent(speartrap.target, "targetname");
    speartrap.clip notsolid();
    speartrap.clip connectpaths();
    speartrap.enable_flag = speartrap.script_noteworthy;
    speartrap thread spear_trap_think();
  }
}

function spear_trap_think() {
  if(isdefined(self.enable_flag) && !level flag::get(self.enable_flag)) {
    level flag::wait_till(self.enable_flag);
  }
  while (true) {
    self waittill("trigger", who);
    if(!isdefined(who) || !isplayer(who) || who.sessionstate == "spectator") {
      continue;
    }
    for (i = 0; i < 3; i++) {
      wait(0.4);
      self thread sprear_trap_activate_spears(i, who);
      wait(2);
    }
  }
}

function sprear_trap_activate_spears(audio_counter, player) {
  self spear_trap_damage_all_characters(audio_counter, player);
  self thread spear_activate(0);
}

function spear_trap_damage_all_characters(audio_counter, player) {
  wait(0.1);
  characters = arraycombine(getplayers(), getaispeciesarray("axis"), 1, 1);
  for (i = 0; i < characters.size; i++) {
    char = characters[i];
    if(self spear_trap_is_character_touching(char)) {
      self thread spear_damage_character(char);
      continue;
    }
    if(isplayer(char) && audio_counter == 0 && randomintrange(0, 101) <= 10) {
      if(isdefined(player) && player == char) {
        char thread delayed_spikes_close_vox();
      }
    }
  }
}

function delayed_spikes_close_vox() {
  self notify("playing_spikes_close_vox");
  self endon("death");
  self endon("playing_spikes_close_vox");
  wait(0.5);
  if(isdefined(self) && (!isdefined(self.spear_trap_slow) || (isdefined(self.spear_trap_slow) && self.spear_trap_slow == 0))) {
    self thread zm_audio::create_and_play_dialog("general", "spikes_close");
  }
}

function spear_damage_character(char) {
  char thread spear_trap_slow();
}

function spear_trap_slow() {
  self endon("death");
  if(isdefined(self.spear_trap_slow) && self.spear_trap_slow) {
    return;
  }
  self.spear_trap_slow = 1;
  if(isplayer(self)) {
    if(zombie_utility::is_player_valid(self)) {
      self thread zm_audio::create_and_play_dialog("general", "spikes_damage");
      self thread _fake_red();
      self dodamage(5, self.origin);
      playsoundatposition("evt_spear_butt", self.origin);
      self playrumbleonentity("pistol_fire");
    }
    self setvelocity((0, 0, 0));
    self setmovespeedscale(0.2);
    wait(1);
    self setmovespeedscale(1);
    wait(0.5);
  } else if(!(isdefined(self.missinglegs) && self.missinglegs)) {
    self _zombie_spear_trap_damage_wait();
  }
  self.spear_trap_slow = 0;
}

function spear_choke() {
  level._num_ai_released = 0;
  while (true) {
    wait(0.05);
    level._num_ai_released = 0;
  }
}

function _zombie_spear_trap_damage_wait() {
  self endon("death");
  if(!isdefined(level._spear_choke)) {
    level._spear_choke = 1;
    level thread spear_choke();
  }
  endtime = gettime() + randomintrange(800, 1200);
  while (endtime > gettime()) {
    if(isdefined(self.missinglegs) && self.missinglegs) {
      break;
    }
    wait(0.05);
  }
  while (level._num_ai_released > 2) {
    println("");
    wait(0.05);
  }
  self stopanimscripted(0.5);
  level._num_ai_released++;
}

function _fake_red() {
  prompt = newclienthudelem(self);
  prompt.alignx = "left";
  prompt.x = 0;
  prompt.y = 0;
  prompt.alignx = "left";
  prompt.aligny = "top";
  prompt.horzalign = "fullscreen";
  prompt.vertalign = "fullscreen";
  fadetime = 1;
  prompt.color = vectorscale((1, 0, 0), 0.2);
  prompt.alpha = 0.7;
  prompt fadeovertime(fadetime);
  prompt.alpha = 0;
  prompt.shader = "white";
  prompt setshader("white", 640, 480);
  wait(fadetime);
  prompt destroy();
}

function spear_trap_is_character_touching(char) {
  return self istouching(char);
}

function spear_activate(delay) {
  wait(delay);
  if(isdefined(self.clip)) {
    self.clip solid();
    self.clip clientfield::set("spiketrap", 1);
  }
  wait(2);
  if(isdefined(self.clip)) {
    self.clip notsolid();
    self.clip clientfield::set("spiketrap", 0);
  }
  wait(0.2);
}

function spear_kill(magnitude) {
  self startragdoll();
  self launchragdoll(vectorscale((0, 0, 1), 50));
  util::wait_network_frame();
  self.a.gib_ref = "head";
  self dodamage(self.health + 666, self.origin);
}

function temple_trap_move_switch() {
  trap_switch = undefined;
  for (i = 0; i < self.trap_switches.size; i++) {
    trap_switch = self.trap_switches[i];
    trap_switch movey(-5, 0.75);
  }
  if(isdefined(trap_switch)) {
    trap_switch playloopsound("zmb_pressure_plate_loop");
    trap_switch waittill("movedone");
    trap_switch stoploopsound();
    trap_switch playsound("zmb_pressure_plate_lock");
  }
  self notify("switch_activated");
  self waittill("trap_ready");
  for (i = 0; i < self.trap_switches.size; i++) {
    trap_switch = self.trap_switches[i];
    trap_switch movey(5, 0.75);
    trap_switch playloopsound("zmb_pressure_plate_loop");
    trap_switch waittill("movedone");
    trap_switch stoploopsound();
    trap_switch playsound("zmb_pressure_plate_lock");
  }
}

function waterfall_trap_init() {
  usetriggers = getentarray("waterfall_trap", "targetname");
  for (i = 0; i < usetriggers.size; i++) {
    trapstruct = spawnstruct();
    trapstruct.usetrigger = usetriggers[i];
    trapstruct.usetrigger sethintstring(&"ZOMBIE_NEED_POWER");
    trapstruct.usetrigger setcursorhint("HINT_NOICON");
    trapstruct.trap_switches = [];
    trapstruct.trap_damage = [];
    trapstruct.trap_shake = [];
    trapstruct.water_drop_trigs = [];
    trapstruct.var_41f396e4 = [];
    targetents = getentarray(trapstruct.usetrigger.target, "targetname");
    targetstructs = struct::get_array(trapstruct.usetrigger.target, "targetname");
    targets = arraycombine(targetents, targetstructs, 1, 1);
    for (j = 0; j < targets.size; j++) {
      if(!isdefined(targets[j].script_noteworthy)) {
        continue;
      }
      switch (targets[j].script_noteworthy) {
        case "trap_switch": {
          trapstruct.trap_switches[trapstruct.trap_switches.size] = targets[j];
          break;
        }
        case "trap_damage": {
          trapstruct.trap_damage[trapstruct.trap_damage.size] = targets[j];
          break;
        }
        case "trap_shake": {
          trapstruct.trap_shake[trapstruct.trap_shake.size] = targets[j];
          break;
        }
        case "water_drop_trigger": {
          targets[j] triggerenable(0);
          trapstruct.water_drop_trigs[trapstruct.water_drop_trigs.size] = targets[j];
          break;
        }
        case "water_trap_trigger": {
          targets[j] triggerenable(0);
          trapstruct.var_41f396e4[trapstruct.var_41f396e4.size] = targets[j];
          break;
        }
      }
    }
    trapstruct.enable_flag = trapstruct.usetrigger.script_noteworthy;
    trapstruct waterfall_trap_think();
  }
}

function waterfall_trap_think() {
  while (true) {
    self notify("trap_ready");
    self.usetrigger sethintstring(&"ZM_TEMPLE_USE_WATER_TRAP");
    self.usetrigger waittill("trigger", who);
    if(zombie_utility::is_player_valid(who) && !who zm_utility::in_revive_trigger()) {
      who.used_waterfall = 1;
      self thread temple_trap_move_switch();
      self waittill("switch_activated");
      self.usetrigger sethintstring("");
      waterfall_trap_on();
      wait(0.5);
      who.used_waterfall = 0;
      array::thread_all(self.trap_damage, & waterfall_trap_damage);
      activetime = 5.5;
      array::thread_all(self.var_41f396e4, & waterfall_screen_fx, activetime);
      self thread waterfall_screen_shake(activetime);
      wait(activetime);
      self notify("trap_off");
      self.usetrigger sethintstring(&"ZM_TEMPLE_WATER_TRAP_COOL");
      array::thread_all(self.var_41f396e4, & function_a6e2b85f);
      waterfall_trap_off();
      array::notify_all(self.trap_damage, "trap_off");
      wait(30);
    }
  }
}

function function_a6e2b85f() {
  self triggerenable(0);
  self notify("waterfall_trap_off");
}

function waterfall_screen_fx(activetime) {
  self.water_drop_time = 5;
  self.waterdrops = 1;
  self.watersheeting = 1;
  wait(1.5);
  self.watersheetingtime = activetime - 1.5;
  self thread function_b68fdf22();
}

function function_b68fdf22() {
  self endon("waterfall_trap_off");
  self triggerenable(1);
  while (true) {
    self waittill("trigger", who);
    if(isplayer(who)) {
      self thread function_5e706bd9(who);
    }
  }
}

function function_5e706bd9(player) {
  player endon("disconnect");
  self thread zm_temple_triggers::water_drop_trig_entered(player);
  while (isdefined(player) && player istouching(self) && self istriggerenabled()) {
    wait(0.05);
  }
  self thread zm_temple_triggers::water_drop_trig_exit(player);
}

function waterfall_screen_shake(activetime) {
  wait(1);
  for (i = 0; i < self.trap_shake.size; i++) {
    waterfall_screen_shake_single(activetime, self.trap_shake[i].origin);
  }
}

function waterfall_screen_shake_single(activetime, origin) {
  remainingtime = 1;
  if(activetime > 6) {
    remainingtime = activetime - 6;
  }
  while (remainingtime > 0) {
    earthquake(0.14, activetime, origin, 400);
    wait(1);
    remainingtime = remainingtime - 1;
  }
}

function waterfall_trap_on() {
  soundstruct = struct::get("waterfall_trap_origin", "targetname");
  if(isdefined(soundstruct)) {
    playsoundatposition("evt_waterfall_trap", soundstruct.origin);
  }
  level notify("waterfall");
  level clientfield::set("waterfall_trap", 1);
  exploder::exploder("fxexp_21");
  exploder::stop_exploder("fxexp_20");
}

function waterfall_trap_off() {
  exploder::exploder("fxexp_20");
  exploder::stop_exploder("fxexp_21");
}

function waterfall_trap_damage() {
  self endon("trap_off");
  fwd = anglestoforward(self.angles);
  zombies_knocked_down = [];
  while (true) {
    self waittill("trigger", who);
    if(isplayer(who)) {
      if(isdefined(self.script_string) && self.script_string == "hurt_player") {
        who dodamage(20, self.origin);
        wait(1);
      } else {
        who thread waterfall_trap_player(fwd, 5.45);
      }
    }
    if(isdefined(who.animname) && who.animname == "monkey_zombie") {
      who thread waterfall_trap_monkey(randomintrange(30, 80), fwd);
    } else if(!ent_in_array(who, zombies_knocked_down)) {
      zombies_knocked_down[zombies_knocked_down.size] = who;
      util::wait_network_frame();
      who thread zombie_waterfall_knockdown(self);
    }
  }
}

function waterfall_trap_player(fwd, time) {
  wait(1);
  vel = self getvelocity();
  self setvelocity(vel + (fwd * 60));
  self playrumbleonentity("slide_rumble");
}

function waterfall_trap_monkey(magnitude, dir) {
  wait(1);
  self startragdoll();
  self launchragdoll(dir * magnitude);
  util::wait_network_frame();
  self dodamage(self.health + 666, self.origin);
}

function ent_in_array(ent, _array) {
  for (i = 0; i < _array.size; i++) {
    if(_array[i] == ent) {
      return true;
    }
  }
  return false;
}

function init_maze_trap() {
  level.mazecells = [];
  level.mazefloors = [];
  level.mazewalls = [];
  level.mazepath = [];
  level.startcells = [];
  level.pathplayers = [];
  level.pathactive = 0;
  mazeclip = getent("maze_path_clip", "targetname");
  if(isdefined(mazeclip)) {
    mazeclip delete();
  }
  init_maze_paths();
  mazetriggers = getentarray("maze_trigger", "targetname");
  for (i = 0; i < mazetriggers.size; i++) {
    mazetrigger = mazetriggers[i];
    mazetrigger.pathcount = 0;
    triggernum = mazetrigger.script_int;
    if(!isdefined(triggernum)) {
      continue;
    }
    _add_maze_cell(triggernum);
    level.mazecells[triggernum - 1].trigger = mazetrigger;
    if(isdefined(mazetrigger.script_string)) {
      startcell = mazetrigger.script_string == "start";
      if(startcell) {
        level.startcells[level.startcells.size] = level.mazecells[triggernum - 1];
      }
    }
  }
  mazefloors = getentarray("maze_floor", "targetname");
  for (i = 0; i < mazefloors.size; i++) {
    mazefloor = mazefloors[i];
    floornum = mazefloor.script_int;
    if(!isdefined(floornum)) {
      continue;
    }
    mazefloor init_maze_mover(16, 0.25, 0.5, 0, "evt_maze_floor_up", "evt_maze_floor_up", 0);
    level.mazecells[floornum - 1].floor = mazefloor;
    level.mazefloors[level.mazefloors.size] = mazefloor;
  }
  mazewalls = getentarray("maze_door", "targetname");
  for (i = 0; i < mazewalls.size; i++) {
    mazewall = mazewalls[i];
    wallnum = mazewall.script_int;
    if(!isdefined(wallnum)) {
      continue;
    }
    mazewall init_maze_mover(-128, 0.25, 1, 1, "evt_maze_wall_down", "evt_maze_wall_up", 1);
    mazewall notsolid();
    mazewall connectpaths();
    mazewall.script_fxid = level._effect["maze_wall_impact"];
    mazewall.var_f88b106c = level._effect["maze_wall_raise"];
    mazewall.fx_active_offset = vectorscale((0, 0, -1), 60);
    mazewall.adjacentcells = [];
    adjacent_cell_nums = [];
    adjacent_cell_nums[0] = wallnum % 100;
    adjacent_cell_nums[1] = int((wallnum - (wallnum % 100)) / 100);
    for (j = 0; j < adjacent_cell_nums.size; j++) {
      cell_num = adjacent_cell_nums[j];
      if(cell_num == 0) {
        continue;
      }
      mazecell = level.mazecells[cell_num - 1];
      mazecell.walls[mazecell.walls.size] = mazewall;
      mazewall.adjacentcells[mazewall.adjacentcells.size] = mazecell;
    }
    level.mazewalls[level.mazewalls.size] = mazewall;
  }
  maze_show_starts();
  array::thread_all(level.mazecells, & maze_cell_watch);
}

function init_maze_paths() {
  level.mazepathcounter = 0;
  level.mazepaths = [];
  add_maze_path(array(5, 4, 3));
  add_maze_path(array(5, 4, 1, 0, 3));
  add_maze_path(array(5, 4, 7, 6, 3));
  add_maze_path(array(5, 4, 3, 6, 9, 12));
  add_maze_path(array(5, 4, 7, 10, 11, 14, 13, 12));
  add_maze_path(array(5, 4, 1, 0, 3, 6, 9, 12));
  add_maze_path(array(5, 4, 7, 8), 1);
  add_maze_path(array(5, 4, 1, 0, 3, 6, 7, 8), 1);
  add_maze_path(array(3, 4, 7, 10, 13, 12));
  add_maze_path(array(3, 4, 5, 8, 7, 6, 9, 12));
  add_maze_path(array(3, 4, 1, 2, 5, 8, 11, 10, 9, 12));
  add_maze_path(array(3, 4, 5));
  add_maze_path(array(3, 4, 7, 6, 9, 10, 11, 8, 5));
  add_maze_path(array(3, 4, 1, 2, 5));
  add_maze_path(array(3, 4, 7, 6), 1);
  add_maze_path(array(3, 4, 1, 2, 5, 8, 7, 6), 1);
  add_maze_path(array(12, 9, 6, 3));
  add_maze_path(array(12, 9, 10, 7, 4, 3));
  add_maze_path(array(12, 9, 10, 13, 14, 11, 8, 5, 4, 3));
  add_maze_path(array(12, 9, 6, 3, 4, 5));
  add_maze_path(array(12, 9, 10, 11, 8, 7, 4, 5));
  add_maze_path(array(12, 9, 6, 3, 0, 1, 2, 5));
  add_maze_path(array(12, 9, 10, 13), 1);
  add_maze_path(array(12, 9, 6, 7, 10, 13), 1);
}

function add_maze_path(path, loopback = 0) {
  s = spawnstruct();
  s.path = path;
  s.loopback = loopback;
  level.mazepaths[level.mazepaths.size] = s;
}

function init_maze_mover(movedist, moveuptime, movedowntime, blockspaths, moveupsound, movedownsound, cliponly) {
  self.isactive = 0;
  self.activecount = 0;
  self.ismoving = 0;
  self.movedist = movedist;
  self.activeheight = self.origin[2] + movedist;
  self.moveuptime = moveuptime;
  self.movedowntime = movedowntime;
  self.pathblocker = blockspaths;
  self.alwaysactive = 0;
  self.moveupsound = moveupsound;
  self.movedownsound = movedownsound;
  self.startangles = self.angles;
  self.cliponly = cliponly;
  if(isdefined(self.script_string) && self.script_string == "always_active") {
    maze_mover_active(1);
    self.alwaysactive = 1;
  }
}

function _add_maze_cell(cell_index) {
  for (i = level.mazecells.size; i < cell_index; i++) {
    level.mazecells[i] = spawnstruct();
    level.mazecells[i] _init_maze_cell();
  }
}

function _init_maze_cell() {
  self.trigger = undefined;
  self.floor = undefined;
  self.walls = [];
}

function maze_mover_active(active) {
  if(self.alwaysactive) {
    return;
  }
  if(active) {
    self.activecount++;
  } else {
    self.activecount = int(max(0, self.activecount - 1));
  }
  active = self.activecount > 0;
  if(self.isactive == active) {
    return;
  }
  if(active && isdefined(self.moveupsound)) {
    self playsound(self.moveupsound);
  }
  if(!active && isdefined(self.movedownsound)) {
    self playsound(self.movedownsound);
  }
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
  self notify("stop_maze_mover");
  self.isactive = active;
  if(self.cliponly) {
    if(active) {
      self solid();
      self disconnectpaths();
      self clientfield::set("mazewall", 1);
    } else {
      self notsolid();
      self connectpaths();
      self clientfield::set("mazewall", 0);
    }
  } else {
    self thread _maze_mover_move(goalpos, movetime);
  }
}

function _maze_mover_move(goal, time) {
  self endon("stop_maze_mover");
  self.ismoving = 1;
  if(time == 0) {
    time = 0.01;
  }
  self moveto(goal, time);
  self waittill("movedone");
  self.ismoving = 0;
  if(self.isactive) {
    _maze_mover_play_fx(self.script_fxid, self.fx_active_offset);
  } else {
    _maze_mover_play_fx(self.var_f88b106c, self.var_2f5c5654);
  }
  if(self.pathblocker) {
    if(self.isactive) {
      self disconnectpaths();
    } else {
      self connectpaths();
    }
  }
}

function _maze_mover_play_fx(fx_name, offset) {
  if(isdefined(fx_name)) {
    vfwd = anglestoforward(self.angles);
    org = self.origin;
    if(isdefined(offset)) {
      org = org + offset;
    }
    playfx(fx_name, org, vfwd, (0, 0, 1));
  }
}

function maze_cell_watch() {
  level endon("fake_death");
  while (true) {
    self.trigger waittill("trigger", who);
    if(self.trigger.pathcount > 0) {
      if(isplayer(who)) {
        if(who is_player_maze_slow()) {
          continue;
        }
        if(who.sessionstate == "spectator") {
          continue;
        }
        self thread maze_cell_player_enter(who);
      } else if(isdefined(who.animname) && who.animname == "zombie") {
        self.trigger thread zombie_normal_trigger_exit(who);
      }
    } else {
      if(isplayer(who)) {
        if(who is_player_on_path()) {
          continue;
        }
        if(who.sessionstate == "spectator") {
          continue;
        }
        self.trigger thread watch_slow_trigger_exit(who);
      } else if(isdefined(who.animname) && who.animname == "zombie") {
        self.trigger thread zombie_slow_trigger_exit(who);
      }
    }
  }
}

function zombie_mud_move_slow() {
  self.var_5526feb3 = self.zombie_move_speed;
  switch (self.zombie_move_speed) {
    case "run": {
      self zombie_utility::set_zombie_run_cycle("walk");
      break;
    }
    case "sprint": {
      self zombie_utility::set_zombie_run_cycle("run");
      break;
    }
  }
}

function zombie_mud_move_normal() {
  self zombie_utility::set_zombie_run_cycle(self.var_5526feb3);
}

function zombie_slow_trigger_exit(zombie) {
  zombie endon("death");
  if(isdefined(zombie.mud_triggers)) {
    if(is_in_array(zombie.mud_triggers, self)) {
      return;
    }
  } else {
    zombie.mud_triggers = [];
  }
  if(!zombie zombie_on_mud()) {
    zombie zombie_mud_move_slow();
  }
  zombie.mud_triggers[zombie.mud_triggers.size] = self;
  while (self.pathcount == 0 && zombie istouching(self)) {
    wait(0.1);
  }
  arrayremovevalue(zombie.mud_triggers, self);
  if(!zombie zombie_on_mud() && !zombie zombie_on_path()) {
    zombie zombie_mud_move_normal();
  }
}

function is_in_array(array, item) {
  foreach(index in array) {
    if(index == item) {
      return true;
    }
  }
  return false;
}

function zombie_on_path() {
  return isdefined(self.path_triggers) && self.path_triggers.size > 0;
}

function zombie_on_mud() {
  return isdefined(self.mud_triggers) && self.mud_triggers.size > 0;
}

function zombie_normal_trigger_exit(zombie) {
  zombie endon("death");
  if(isdefined(zombie.path_triggers)) {
    if(is_in_array(zombie.path_triggers, self)) {
      return;
    }
  } else {
    zombie.path_triggers = [];
  }
  if(!zombie zombie_on_path()) {
    zombie zombie_mud_move_normal();
  }
  zombie.path_triggers[zombie.path_triggers.size] = self;
  while (self.pathcount != 0 && zombie istouching(self)) {
    wait(0.1);
  }
  arrayremovevalue(zombie.path_triggers, self);
}

function is_player_on_path() {
  return isdefined(self.mazepathcells) && self.mazepathcells.size > 0;
}

function is_player_maze_slow() {
  return isdefined(self.mazeslowtrigger) && self.mazeslowtrigger.size > 0;
}

function maze_cell_player_enter(player) {
  if(isdefined(player.mazepathcells)) {
    if(is_in_array(player.mazepathcells, self)) {
      return;
    }
  } else {
    player.mazepathcells = [];
  }
  if(!is_in_array(level.pathplayers, player)) {
    level.pathplayers[level.pathplayers.size] = player;
  }
  player.mazepathcells[player.mazepathcells.size] = self;
  if(!level.pathactive) {
    self maze_start_path();
  }
  on_maze_cell_enter();
  self path_trigger_wait(player);
  isplayervalid = isdefined(player);
  if(isplayervalid) {
    arrayremovevalue(player.mazepathcells, self);
  }
  if(!isplayervalid || !player is_player_on_path()) {
    level.pathplayers = array::remove_undefined(level.pathplayers);
    if(isplayervalid) {
      arrayremovevalue(level.pathplayers, player);
    }
    if(level.pathplayers.size == 0) {
      maze_end_path();
    }
  }
  on_maze_cell_exit();
}

function path_trigger_wait(player) {
  player endon("disconnect");
  player endon("fake_death");
  player endon("death");
  level endon("maze_timer_end");
  while (self.trigger.pathcount != 0 && player istouching(self.trigger) && player.sessionstate != "spectator") {
    wait(0.1);
  }
}

function on_maze_cell_enter() {
  current = self;
  previous = current cell_get_previous();
  next = current cell_get_next();
  raise_floor(previous);
  raise_floor(current);
  raise_floor(next);
  activate_walls(previous);
  activate_walls(current);
  activate_walls(next);
}

function on_maze_cell_exit() {
  current = self;
  previous = current cell_get_previous();
  next = current cell_get_next();
  lower_floor(previous);
  lower_floor(current);
  lower_floor(next);
  lower_walls(previous);
  lower_walls(current);
  lower_walls(next);
}

function watch_slow_trigger_exit(player) {
  player endon("death");
  player endon("fake_death");
  player endon("disconnect");
  player allowjump(0);
  if(isdefined(player.mazeslowtrigger)) {
    if(is_in_array(player.mazeslowtrigger, self)) {
      return;
    }
  } else {
    player.mazeslowtrigger = [];
  }
  if(!player is_player_maze_slow()) {
    player allowsprint(0);
    player allowprone(0);
    player allowslide(0);
    player setmovespeedscale(0.35);
  }
  player.mazeslowtrigger[player.mazeslowtrigger.size] = self;
  while (self.pathcount == 0 && player istouching(self)) {
    wait(0.1);
  }
  arrayremovevalue(player.mazeslowtrigger, self);
  if(!player is_player_maze_slow()) {
    player allowjump(1);
    player allowsprint(1);
    player allowprone(1);
    player allowslide(1);
    player setmovespeedscale(1);
  }
}

function lower_walls(cell) {
  if(!isdefined(cell)) {
    return;
  }
  for (i = 0; i < cell.walls.size; i++) {
    wall = cell.walls[i];
    wall thread maze_mover_active(0);
  }
}

function activate_walls(cell) {
  if(!isdefined(cell)) {
    return;
  }
  previous = cell cell_get_previous();
  next = cell cell_get_next();
  previoussharedwall = maze_cells_get_shared_wall(previous, cell);
  nextsharedwall = maze_cells_get_shared_wall(cell, next);
  for (i = 0; i < cell.walls.size; i++) {
    wall = cell.walls[i];
    activatewall = 1;
    if(isdefined(previoussharedwall) && wall == previoussharedwall || (isdefined(nextsharedwall) && wall == nextsharedwall) || (!isdefined(previous) && wall.adjacentcells.size == 1) || (!isdefined(next) && wall.adjacentcells.size == 1)) {
      activatewall = 0;
    }
    wall thread maze_mover_active(activatewall);
  }
}

function raise_floor(mazecell) {
  if(isdefined(mazecell)) {
    mazecell.trigger.pathcount++;
    mazecell.floor thread maze_mover_active(1);
    level thread delete_cell_corpses(mazecell);
  }
}

function delete_cell_corpses(mazecell) {
  bodies = getcorpsearray();
  for (i = 0; i < bodies.size; i++) {
    if(!isdefined(bodies[i])) {
      continue;
    }
    if(bodies[i] istouching(mazecell.trigger) || bodies[i] istouching(mazecell.floor)) {
      bodies[i] thread delete_corpse();
      util::wait_network_frame();
    }
  }
}

function delete_corpse() {
  self endon("death");
  playfx(level._effect["animscript_gib_fx"], self.origin);
  if(isdefined(self)) {
    self delete();
  }
}

function lower_floor(mazecell) {
  if(isdefined(mazecell)) {
    mazecell.trigger.pathcount--;
    mazecell.floor thread maze_mover_active(0);
  }
}

function maze_cells_get_shared_wall(a, b) {
  if(!isdefined(a) || !isdefined(b)) {
    return undefined;
  }
  for (i = 0; i < a.walls.size; i++) {
    for (j = 0; j < b.walls.size; j++) {
      if(a.walls[i] == b.walls[j]) {
        return a.walls[i];
      }
    }
  }
  return undefined;
}

function maze_show_starts() {
  for (i = 0; i < level.startcells.size; i++) {
    raise_floor(level.startcells[i]);
  }
}

function maze_start_path() {
  level.pathactive = 1;
  for (i = 0; i < level.startcells.size; i++) {
    lower_floor(level.startcells[i]);
  }
  self maze_generate_path();
  level thread maze_path_timer(10);
}

function maze_end_path() {
  level notify("maze_path_end");
  level.pathactive = 0;
  level thread maze_show_starts_delayed();
}

function maze_show_starts_delayed() {
  level endon("maze_all_safe");
  wait(3);
  maze_show_starts();
}

function maze_path_timer(time) {
  level endon("maze_path_end");
  level endon("maze_all_safe");
  vibratetime = 3;
  wait(time - vibratetime);
  level thread maze_vibrate_floor_stop();
  level thread maze_vibrate_active_floors(vibratetime);
  wait(vibratetime);
  level notify("maze_timer_end");
  level thread repath_zombies_in_maze();
}

function repath_zombies_in_maze() {
  util::wait_network_frame();
  zombies = getaiteamarray(level.zombie_team);
  for (i = 0; i < zombies.size; i++) {
    zombie = zombies[i];
    if(!isdefined(zombie)) {
      continue;
    }
    if(!isdefined(zombie.animname) || zombie.animname == "monkey_zombie") {
      continue;
    }
    if(zombie zombie_on_path() || zombie zombie_on_mud()) {
      zombie notify("stop_find_flesh");
      zombie notify("zombie_acquire_enemy");
      util::wait_network_frame();
      zombie.ai_state = "find_flesh";
    }
  }
}

function maze_vibrate_active_floors(time) {
  level endon("maze_path_end");
  level endon("maze_all_safe");
  endtime = gettime() + (time * 1000);
  while (endtime > gettime()) {
    for (i = 0; i < level.mazecells.size; i++) {
      cell = level.mazecells[i];
      if(cell.floor.isactive) {
        cell thread maze_vibrate_floor((endtime - gettime()) / 1000);
        players = getplayers();
        for (w = 0; w < players.size; w++) {
          if(players[w] istouching(cell.trigger)) {
            cell.trigger thread trigger::function_d1278be0(players[w], & temple_maze_player_vibrate_on, & temple_maze_player_vibrate_off);
          }
        }
      }
    }
    wait(0.1);
  }
}

function temple_maze_player_vibrate_on(player, endon_condition) {
  if(isdefined(endon_condition)) {
    player endon(endon_condition);
  }
  player clientfield::set_to_player("floorrumble", 1);
  util::wait_network_frame();
  self thread temple_inactive_floor_rumble_cancel(player);
}

function temple_maze_player_vibrate_off(player) {
  player endon("frc");
  player clientfield::set_to_player("floorrumble", 0);
  player notify("frc");
}

function temple_inactive_floor_rumble_cancel(ent_player) {
  ent_player endon("frc");
  floor_piece = undefined;
  maze_floor_array = getentarray("maze_floor", "targetname");
  for (i = 0; i < maze_floor_array.size; i++) {
    if(maze_floor_array[i].script_int == self.script_int) {
      floor_piece = maze_floor_array[i];
    }
  }
  while (isdefined(floor_piece) && floor_piece.isactive == 1) {
    wait(0.05);
  }
  if(isdefined(ent_player)) {
    ent_player clientfield::set_to_player("floorrumble", 0);
  }
  ent_player notify("frc");
}

function maze_vibrate_floor(time) {
  if(isdefined(self.isvibrating) && self.isvibrating) {
    return;
  }
  self.floor playsound("evt_maze_floor_collapse");
  self.isvibrating = 1;
  dir = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0);
  self.floor vibrate(dir, 0.75, 0.3, time);
  wait(time);
  self.isvibrating = 0;
}

function maze_vibrate_floor_stop() {
  level util::waittill_any("maze_path_end", "maze_timer_end", "maze_all_safe");
  for (i = 0; i < level.mazecells.size; i++) {
    cell = level.mazecells[i];
    if(isdefined(cell.isvibrating) && cell.isvibrating) {
      cell.floor vibrate((0, 0, 1), 1, 1, 0.05);
      cell.floor rotateto(cell.floor.startangles, 0.1);
      cell.floor stopsounds();
    }
  }
}

function maze_generate_path() {
  level.mazepath = [];
  for (i = 0; i < level.mazecells.size; i++) {
    level.mazecells[i].pathindex = -1;
  }
  path_index = self pick_random_path_index();
  path = level.mazepaths[path_index].path;
  level.mazepathlaststart = path[0];
  level.mazepathlastend = path[path.size - 1];
  for (i = 0; i < path.size; i++) {
    level.mazepath[i] = level.mazecells[path[i]];
    level.mazepath[i].pathindex = i;
  }
  level.mazepathcounter++;
}

function pick_random_path_index() {
  startindex = 0;
  for (i = 0; i < level.mazecells.size; i++) {
    if(level.mazecells[i] == self) {
      startindex = i;
      break;
    }
  }
  path_indexes = [];
  for (i = 0; i < level.mazepaths.size; i++) {
    path_indexes[i] = i;
  }
  path_indexes = array::randomize(path_indexes);
  returnindex = -1;
  for (i = 0; i < path_indexes.size; i++) {
    index = path_indexes[i];
    path = level.mazepaths[index].path;
    if(level.mazepaths[index].loopback) {
      if(level.mazepathcounter < 3) {
        continue;
      }
      if(randomfloat(100) > 40) {
        continue;
      }
    }
    if(isdefined(level.mazepathlaststart) && isdefined(level.mazepathlastend)) {
      if(level.mazepathlaststart == path[0] && level.mazepathlastend == (path[path.size - 1])) {
        continue;
      }
    }
    if(startindex == path[0]) {
      returnindex = index;
      break;
    }
  }
  return returnindex;
}

function cell_get_next() {
  index = self.pathindex;
  if(index < (level.mazepath.size - 1)) {
    return level.mazepath[index + 1];
  }
  return undefined;
}

function cell_get_previous() {
  index = self.pathindex;
  if(index > 0) {
    return level.mazepath[index - 1];
  }
  return undefined;
}

function zombie_waterfall_knockdown(entity) {
  self endon("death");
  self.lander_knockdown = 1;
  wait(1.25);
  self zombie_utility::setup_zombie_knockdown(entity);
}

function override_thundergun_damage_func(player, gib) {
  dmg_point = struct::get("waterfall_dmg_point", "script_noteworthy");
  self.thundergun_handle_pain_notetracks = & handle_knockdown_pain_notetracks;
  self dodamage(1, dmg_point.origin);
  self animcustom( & zm_weap_thundergun::playthundergunpainanim);
}

function handle_knockdown_pain_notetracks(note) {}