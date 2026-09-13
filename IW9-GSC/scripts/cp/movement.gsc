/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\movement.gsc
***********************************************/

_id_36D589DC5C4191F6(override, delay) {
  if(isDefined(delay))
    wait(delay);

  if(isDefined(level._id_B11DB2283DBD7ED3)) {
    if(isDefined(override) && isstring(override))
      self[[level._id_B11DB2283DBD7ED3]](override);
    else {
      _id_227C8676D5E5B0C4 = getdvarint("dvar_A6DC81E1FDDE75FF", 0);

      switch (_id_227C8676D5E5B0C4) {
        case 1:
          self[[level._id_B11DB2283DBD7ED3]]("cqb");
          break;
        case 2:
          self[[level._id_B11DB2283DBD7ED3]]("creep");
          break;
        default:
          self[[level._id_B11DB2283DBD7ED3]]("default");
          break;
      }
    }
  } else {}
}

player_movement_state(state) {
  if(!isDefined(state))
    state = "default";

  movespeedscaler = 1;

  switch (state) {
    case "creep":
      movespeedscaler = 0.6;
      movespeed = 90;
      break;
    case "cqb":
      suit = "iw9_cqb_cp";
      movespeedscaler = 0.8;
      movespeed = 120;
      break;
    case "default":
      suit = "iw9_defaultsuit_cp";
      movespeedscaler = 1;
      movespeed = 150;
      break;
    default:
      suit = "iw9_defaultsuit_cp";
      movespeedscaler = 1;
      movespeed = 150;
  }

  self.movementstate = state;
  self.movespeedscaler = movespeedscaler;
  self[[level.move_speed_scale]]();
  player_speed_set(movespeed, 0.5);
}

player_speed_percent(_id_477C1209E5432ABE, time) {
  _id_216AA8D841F7C224 = int(getDvar("g_speed"));

  if(!isDefined(self.g_speed))
    self.g_speed = _id_216AA8D841F7C224;

  _id_AF03A5AC7D47D6CD = int(self.g_speed * _id_477C1209E5432ABE * 0.01);
  player_speed_set(_id_AF03A5AC7D47D6CD, time);
}

player_speed_set(speed, time) {
  _id_216AA8D841F7C224 = int(getDvar("g_speed"));

  if(!isDefined(self.g_speed))
    self.g_speed = _id_216AA8D841F7C224;

  _id_6A4AD94DB7F006E2 = ::movespeed_get_func;
  set_func = ::movespeed_set_func;

  if(!isDefined(speed))
    speed = 150;

  scale = speed / 190;
  thread player_speed_proc(scale, time, _id_6A4AD94DB7F006E2, set_func, "blend_movespeedscale", undefined);
}

player_bob_scale_set(scale, time) {
  _id_6A4AD94DB7F006E2 = ::g_bob_scale_get_func;
  set_func = ::g_bob_scale_set_func;
  thread player_speed_proc(scale, time, _id_6A4AD94DB7F006E2, set_func, "player_bob_scale_set");
}

blend_movespeedscale(scale, time, _id_7148C1A6F25491F8) {
  player = self;

  if(!isPlayer(player))
    player = self;

  if(!isDefined(player.movespeedscale))
    player.movespeedscale = 1.0;

  _id_6A4AD94DB7F006E2 = ::movespeed_get_func;
  set_func = ::movespeed_set_func;
  player thread player_speed_proc(scale, time, _id_6A4AD94DB7F006E2, set_func, "blend_movespeedscale", _id_7148C1A6F25491F8);
}

blend_movespeedscale_percent(_id_477C1209E5432ABE, time, _id_7148C1A6F25491F8) {
  player = self;

  if(!isPlayer(player))
    player = self;

  if(!isDefined(player.movespeedscale))
    player.movespeedscale = 1.0;

  _id_0C943DD9D8F55B20 = _id_477C1209E5432ABE * 0.01;
  player blend_movespeedscale(_id_0C943DD9D8F55B20, time, _id_7148C1A6F25491F8);
}

player_speed_proc(speed, time, _id_6A4AD94DB7F006E2, set_func, ender, _id_7148C1A6F25491F8) {
  self notify(ender);
  self endon(ender);
  _id_216AA8D841F7C224 = [[_id_6A4AD94DB7F006E2]](_id_7148C1A6F25491F8);
  _id_AF03A5AC7D47D6CD = speed;

  if(isDefined(time) && time > 0) {
    range = _id_AF03A5AC7D47D6CD - _id_216AA8D841F7C224;
    interval = 0.05;
    _id_92FEDD11192AD154 = time / interval;
    fraction = range / _id_92FEDD11192AD154;

    while(abs(_id_AF03A5AC7D47D6CD - _id_216AA8D841F7C224) > abs(fraction * 1.1)) {
      _id_216AA8D841F7C224 = _id_216AA8D841F7C224 + fraction;
      [[set_func]](_id_216AA8D841F7C224, _id_7148C1A6F25491F8);
      wait(interval);
    }
  }

  [[set_func]](_id_AF03A5AC7D47D6CD, _id_7148C1A6F25491F8);
}

player_speed_default(time) {
  if(!isDefined(self.g_speed)) {
    return;
  }
  player_speed_set(self.g_speed, time);
  waittillframeend;
  self.g_speed = undefined;
}

blend_movespeedscale_default(time, _id_7148C1A6F25491F8) {
  player = self;

  if(!isPlayer(player))
    player = self;

  if(!isDefined(player.movespeedscale)) {
    return;
  }
  player blend_movespeedscale(1.0, time, _id_7148C1A6F25491F8);
  player.movespeedscale = undefined;
}

g_speed_get_func(_id_DDD80F5D1DA23C60) {
  return int(getDvar("g_speed"));
}

g_speed_set_func(_id_AF03A5AC7D47D6CD, _id_DDD80F5D1DA23C60) {
  setDvar("g_speed", int(_id_AF03A5AC7D47D6CD));
}

g_bob_scale_get_func(_id_DDD80F5D1DA23C60) {}

g_bob_scale_set_func(_id_0C943DD9D8F55B20, _id_DDD80F5D1DA23C60) {}

movespeed_get_func(_id_7148C1A6F25491F8) {
  if(!isDefined(_id_7148C1A6F25491F8))
    _id_7148C1A6F25491F8 = "default";

  if(!isDefined(self.movespeedscales) || !isDefined(self.movespeedscales[_id_7148C1A6F25491F8]))
    return 1;

  return self.movespeedscales[_id_7148C1A6F25491F8];
}

movespeed_set_func(scale, _id_7148C1A6F25491F8) {
  _id_91180BE623F6B59B = 1.0;

  if(!isDefined(_id_7148C1A6F25491F8))
    _id_7148C1A6F25491F8 = "default";

  self.movespeedscales[_id_7148C1A6F25491F8] = scale;

  foreach(key, scale in self.movespeedscales) {
    if(scale == 1)
      self.movespeedscales = scripts\engine\utility::array_remove_key(self.movespeedscales, key);

    _id_91180BE623F6B59B = _id_91180BE623F6B59B * scale;
  }

  self.movespeedscale = _id_91180BE623F6B59B;
  self setmovespeedscale(self.movespeedscale);
}