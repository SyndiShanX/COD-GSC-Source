/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\movement.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace movement;

function function_36d589dc5c4191f6(override, delay) {
  if(isDefined(delay)) {
    wait delay;
  }

  if(isDefined(level.var_b11db2283dbd7ed3)) {
    if(isDefined(override) && isstring(override)) {
      self[[level.var_b11db2283dbd7ed3]](override);
    } else {
      movement_dvar = getdvarint(@ "hash_a6dc81e1fdde75ff", 0);

      switch (movement_dvar) {
        case 1:
          self[[level.var_b11db2283dbd7ed3]]("cqb");
          break;
        case 2:
          self[[level.var_b11db2283dbd7ed3]]("creep");
          break;
        default:
          self[[level.var_b11db2283dbd7ed3]]("default");
          break;
      }
    }

    return;
  }

  if(getdvarint(@ "hash_a6dc81e1fdde75ff", 0) != 0) {
    iprintln("<dev string:x1c>");
  }
}

function player_movement_state(state) {
  assertex(isPlayer(self), " self is not a player. Please call this function only on a Player entity. ");

  if(!isDefined(state)) {
    state = "default";
  }

  movespeedscaler = 1;

  switch (state) {
    case #"hash_a25aba0197cd06fa":
      movespeedscaler = 0.6;
      movespeed = 90;
      break;
    case #"hash_1a53266c17b7d481":
      suit = "iw9_cqb_cp";
      movespeedscaler = 0.8;
      movespeed = 120;
      break;
    case #"hash_7038dec66d8275be":
      suit = "iw9_defaultsuit_cp";
      movespeedscaler = 1;
      movespeed = 150;
      break;
    default:
      assertmsg("movement state <" + state + "> is not a valid type.please use <creep> <cqb> or <default>");
      suit = "iw9_defaultsuit_cp";
      movespeedscaler = 1;
      movespeed = 150;
      break;
  }

  self.movementstate = state;
  self.movespeedscaler = movespeedscaler;
  self[[level.move_speed_scale]]();
  player_speed_set(movespeed, 0.5);
}

function player_speed_percent(percent, time) {
  currspeed = int(getDvar(@ "g_speed"));

  if(!isDefined(self.g_speed)) {
    self.g_speed = currspeed;
  }

  goalspeed = int(self.g_speed * percent * 0.01);
  player_speed_set(goalspeed, time);
}

function player_speed_set(speed, time) {
  currspeed = int(getDvar(@ "g_speed"));

  if(!isDefined(self.g_speed)) {
    self.g_speed = currspeed;
  }

  get_func = &movespeed_get_func;
  set_func = &movespeed_set_func;

  if(!isDefined(speed)) {
    speed = 150;
  }

  scale = speed / 190;
  thread player_speed_proc(scale, time, get_func, set_func, "blend_movespeedscale", undefined);
}

function player_bob_scale_set(scale, time) {
  get_func = &g_bob_scale_get_func;
  set_func = &g_bob_scale_set_func;
  thread player_speed_proc(scale, time, get_func, set_func, "player_bob_scale_set");
}

function blend_movespeedscale(scale, time, channel) {
  player = self;

  if(!isPlayer(player)) {
    player = self;
  }

  if(!isDefined(player.movespeedscale)) {
    player.movespeedscale = 1;
  }

  get_func = &movespeed_get_func;
  set_func = &movespeed_set_func;
  player thread player_speed_proc(scale, time, get_func, set_func, "blend_movespeedscale", channel);
}

function blend_movespeedscale_percent(percent, time, channel) {
  player = self;

  if(!isPlayer(player)) {
    player = self;
  }

  if(!isDefined(player.movespeedscale)) {
    player.movespeedscale = 1;
  }

  goalscale = percent * 0.01;
  player blend_movespeedscale(goalscale, time, channel);
}

function player_speed_proc(speed, time, get_func, set_func, ender, channel) {
  self notify(ender);
  self endon(ender);
  currspeed = [[get_func]](channel);
  goalspeed = speed;

  if(isDefined(time) && time > 0) {
    range = goalspeed - currspeed;
    interval = 0.05;
    numcycles = time / interval;
    fraction = range / numcycles;

    while(abs(goalspeed - currspeed) > abs(fraction * 1.1)) {
      currspeed += fraction;
      [[set_func]](currspeed, channel);
      wait interval;
    }
  }

  [[set_func]](goalspeed, channel);
}

function player_speed_default(time) {
  if(!isDefined(self.g_speed)) {
    return;
  }

  player_speed_set(self.g_speed, time);
  waittillframeend();
  self.g_speed = undefined;
}

function blend_movespeedscale_default(time, channel) {
  player = self;

  if(!isPlayer(player)) {
    player = self;
  }

  if(!isDefined(player.movespeedscale)) {
    return;
  }

  player blend_movespeedscale(1, time, channel);
  player.movespeedscale = undefined;
}

function g_speed_get_func(null) {
  return int(getDvar(@ "g_speed"));
}

function g_speed_set_func(goalspeed, null) {
  setDvar(@ "g_speed", int(goalspeed));
}

function g_bob_scale_get_func(null) {}

function g_bob_scale_set_func(goalscale, null) {}

function movespeed_get_func(channel) {
  if(!isDefined(channel)) {
    channel = "default";
  }

  if(!isDefined(self.movespeedscales) || !isDefined(self.movespeedscales[channel])) {
    return 1;
  }

  return self.movespeedscales[channel];
}

function movespeed_set_func(scale, channel) {
  finalscale = 1;

  if(!isDefined(channel)) {
    channel = "default";
  }

  self.movespeedscales[channel] = scale;

  foreach(scale in self.movespeedscales) {
    if(scale == 1) {
      self.movespeedscales = array_remove_key(self.movespeedscales, key);
    }

    finalscale *= scale;
  }

  self.movespeedscale = finalscale;
  self setmovespeedscale(self.movespeedscale);
}