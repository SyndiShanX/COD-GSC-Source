/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\stealth.gsc
*************************************************/

#using scripts\cp\gametypes\_save;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\stealth_actor;
#using scripts\shared\stealth_aware;
#using scripts\shared\stealth_debug;
#using scripts\shared\stealth_level;
#using scripts\shared\stealth_player;
#using scripts\shared\stealth_vehicle;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace stealth;

function autoexec __init__sytem__() {
  system::register("stealth", & __init__, undefined, undefined);
}

function __init__() {
  init_client_field_callback_funcs();
  stealth_debug::init();
}

function init_client_field_callback_funcs() {
  clientfield::register("toplayer", "stealth_sighting", 1, 2, "int");
  clientfield::register("toplayer", "stealth_alerted", 1, 1, "int");
}

function init() {
  level agent_init();
  function_26f24c93(0);
}

function reset() {
  assert(isdefined(self));
  if(!isdefined(self.stealth)) {
    return;
  }
  if(isdefined(self.stealth.agents)) {
    foreach(agent in self.stealth.agents) {
      if(!isdefined(agent)) {
        continue;
      }
      if(agent == self) {
        continue;
      }
      agent function_e8434f94();
    }
  }
  self function_e8434f94();
}

function stop() {
  assert(isdefined(self));
  if(!isdefined(self.stealth)) {
    return;
  }
  self notify("stop_stealth");
  if(isdefined(self.stealth.agents)) {
    foreach(agent in self.stealth.agents) {
      if(!isdefined(agent)) {
        continue;
      }
      if(agent == self) {
        continue;
      }
      agent notify("stop_stealth");
      agent agent_stop();
    }
  }
  self agent_stop();
  self.stealth = undefined;
}

function register_agent(object) {
  if(isdefined(level.stealth)) {
    if(!isdefined(level.stealth.agents)) {
      level.stealth.agents = [];
    }
    i = 0;
    for (;;) {
      if(!isdefined(level.stealth.agents[i])) {
        level.stealth.agents[i] = object;
        return;
      }
      if(level.stealth.agents[i] == object) {
        return;
      }
      i++;
    }
  }
}

function agent_init() {
  object = self;
  if(!isdefined(object) || isdefined(object.stealth)) {
    return false;
  }
  if(isplayer(object)) {
    object stealth_player::init();
  } else {
    if(isactor(object)) {
      object stealth_actor::init();
    } else {
      if(isvehicle(object)) {
        object stealth_vehicle::init();
      } else if(object == level) {
        object stealth_level::init();
      }
    }
  }
  register_agent(object);
}

function agent_stop() {
  object = self;
  if(!isdefined(object)) {
    return 0;
  }
  if(isplayer(object)) {
    return object stealth_player::stop();
  }
  if(isactor(object)) {
    return object stealth_actor::stop();
  }
  if(isvehicle(object)) {
    return object stealth_vehicle::stop();
  }
  if(object == level) {
    return object stealth_level::stop();
  }
  return 0;
}

function function_e8434f94() {
  object = self;
  if(!isdefined(object)) {
    return 0;
  }
  if(isplayer(object)) {
    return object stealth_player::reset();
  }
  if(isactor(object)) {
    return object stealth_actor::reset();
  }
  if(isvehicle(object)) {
    return object stealth_vehicle::reset();
  }
  if(object == level) {
    return object stealth_level::reset();
  }
  return 0;
}

function is_enemy(entity) {
  if(!isdefined(entity)) {
    return 0;
  }
  if(!isdefined(entity.team)) {
    return 0;
  }
  return entity.team != self.team;
}

function enemy_team() {
  assert(isdefined(self.team));
  switch (self.team) {
    case "allies": {
      return "axis";
    }
    case "axis": {
      return "allies";
    }
  }
  return "allies";
}

function can_see(entity) {
  if(isactor(self)) {
    return self cansee(entity);
  }
  return sighttracepassed(self.origin + vectorscale((0, 0, 1), 30), entity.origin + vectorscale((0, 0, 1), 30), 0, undefined);
}

function awareness_delta(str_awarenessa, str_awarenessb) {
  return level.stealth.awareness_index[str_awarenessa] - level.stealth.awareness_index[str_awarenessb];
}

function level_wait_notify(waitfor) {
  self notify("level_wait_notify_" + waitfor);
  self endon("level_wait_notify_" + waitfor);
  if(isplayer(self)) {
    self endon("disconnect");
  } else {
    self endon("death");
  }
  self endon("stop_stealth");
  level waittill(waitfor);
  self notify(waitfor);
}

function weapon_can_be_reloaded() {
  assert(isplayer(self));
  w_weapon = self getcurrentweapon();
  i_clip = self getweaponammoclip(w_weapon);
  i_stock = self getweaponammostock(w_weapon);
  return i_clip < w_weapon.clipsize && i_stock > 0;
}

function get_closest_enemy_in_view(distance, fov) {
  level.stealth.enemies[self.team] = array::remove_dead(level.stealth.enemies[self.team]);
  enemies = arraysort(level.stealth.enemies[self.team], self.origin, 20, distance);
  cosfov = cos(fov);
  eyepos = self.origin;
  eyeangles = self.angles;
  if(isplayer(self)) {
    eyepos = self geteye();
    eyeangles = self getplayerangles();
  } else if(isactor(self)) {
    eyepos = self gettagorigin("TAG_EYE");
    eyeangles = self gettagangles("TAG_EYE");
  }
  foreach(enemy in enemies) {
    if(util::within_fov(eyepos, eyeangles, enemy.origin + vectorscale((0, 0, 1), 30), cosfov)) {
      return enemy;
    }
  }
}

function get_closest_player(v_origin, maxdist) {
  playerlist = getplayers();
  playerlist = arraysortclosest(playerlist, v_origin, 1, 0, maxdist);
  if(isdefined(playerlist) && playerlist.size > 0 && isalive(playerlist[0])) {
    return playerlist[0];
  }
}

function awareness_color(str_awareness) {
  if(!isdefined(level.stealth)) {
    level.stealth = spawnstruct();
  }
  if(!isdefined(level.stealth.awareness_color)) {
    level.stealth.awareness_color = [];
    level.stealth.awareness_color["unaware"] = vectorscale((1, 1, 1), 0.5);
    level.stealth.awareness_color["low_alert"] = (1, 1, 0);
    level.stealth.awareness_color["high_alert"] = (1, 0.5, 0);
    level.stealth.awareness_color["combat"] = (1, 0, 0);
  }
  return level.stealth.awareness_color[str_awareness];
}

function function_437e9eec(entity) {
  if(!isdefined(entity)) {
    return 0;
  }
  if(!isdefined(entity._o_scene)) {
    return 0;
  }
  if(!isdefined(entity._o_scene._str_state)) {
    return 0;
  }
  return entity._o_scene._str_state == "play";
}

function function_76c2ffe4(state) {
  level.stealth.var_bc3590e4 = 1;
  function_e0319e51(state);
}

function function_862e861f(fade_time) {
  level.stealth.var_bc3590e4 = 0;
  level.stealth.music_state = "none";
  stealth_music_stop(fade_time);
}

function stealth_music_stop(fade_time) {
  if(isdefined(level.stealth.music_ent)) {
    foreach(ent in level.stealth.music_ent) {
      ent stoploopsound(fade_time);
    }
  }
}

function function_8bb61d8e(str_awareness, var_414c0762) {
  if(!isdefined(level.stealth)) {
    level.stealth = spawnstruct();
  }
  if(!isdefined(level.stealth.music)) {
    level.stealth.music = [];
  }
  level.stealth.music[str_awareness] = var_414c0762;
}

function function_e0319e51(str_awareness) {}

function function_f8aaae39(delay) {
  if(!isdefined(level.stealth.music_ent)) {
    if(!isdefined(level.stealth.music_ent)) {
      level.stealth.music_ent = [];
    }
    level.stealth.music_ent["unaware"] = spawn("script_origin", (0, 0, 0));
    level.stealth.music_ent["low_alert"] = spawn("script_origin", (0, 0, 0));
    level.stealth.music_ent["high_alert"] = spawn("script_origin", (0, 0, 0));
    level.stealth.music_ent["combat"] = spawn("script_origin", (0, 0, 0));
  }
  state = level.stealth.music_state;
  wait(delay);
  if(state == level.stealth.music_state) {
    foreach(key, ent in level.stealth.music_ent) {
      if(state == key && isdefined(level.stealth.music[key])) {
        ent playloopsound(level.stealth.music[key], 1);
        continue;
      }
      ent stoploopsound(3);
    }
  }
}

function function_26f24c93(b_enabled) {
  if(isdefined(level.stealth)) {
    level.stealth.vo_callouts = b_enabled;
  } else if(isdefined(b_enabled) && b_enabled) {
    assert(0, "");
  }
}

function function_9aa26b41() {
  level thread function_762607ad();
}

function private function_762607ad() {
  level notify("hash_762607ad");
  level endon("hash_762607ad");
  level endon("save_restore");
  level endon("stop_stealth");
  secondswaited = 0;
  while (secondswaited < 10) {
    var_62de14e3 = level stealth_level::enabled() && (level flag::get("stealth_alert") || level flag::get("stealth_combat") || level flag::get("stealth_discovered"));
    if(!var_62de14e3) {
      enemies = getaiteamarray("axis");
      for (i = 0; i < enemies.size && !var_62de14e3; i++) {
        enemy = enemies[i];
        if(!isdefined(enemy) || isalive(enemy)) {
          continue;
        }
        if(!enemy stealth_aware::enabled()) {
          continue;
        }
        foreach(player in level.activeplayers) {
          if(enemy getstealthsightvalue(player) > 0) {
            var_62de14e3 = 1;
          }
        }
      }
    }
    if(!var_62de14e3) {
      var_62de14e3 = !function_fd413bf3();
    }
    if(var_62de14e3) {
      wait(1);
      secondswaited++;
      continue;
    } else {
      savegame::function_fb150717();
      return;
    }
  }
}

function private function_fd413bf3() {
  if(!savegame::function_147f4ca3()) {
    return false;
  }
  ai_enemies = getaiteamarray("axis");
  foreach(enemy in ai_enemies) {
    if(!enemy function_d0a01dc8()) {
      return false;
    }
  }
  return true;
}

function private function_d0a01dc8() {
  playerproximity = self savegame::function_2808d83d();
  if(playerproximity > 1000 || playerproximity < 0) {
    return true;
  }
  if(playerproximity < 500) {
    return false;
  }
  if(isactor(self) && self function_ed8df2f()) {
    return false;
  }
  return true;
}

function private function_ed8df2f() {
  foreach(player in level.activeplayers) {
    if(self cansee(player)) {
      return true;
    }
  }
  return false;
}