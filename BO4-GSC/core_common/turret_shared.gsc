/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\turret_shared.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicleriders_shared;

#namespace turret;

autoexec __init__system__() {
  system::register(#"turret", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int");
  level._turrets = spawnStruct();
}

get_weapon(n_index = 0) {
  if(!isalive(self)) {
    return level.weaponnone;
  }

  w_weapon = self seatgetweapon(n_index);
  return w_weapon;
}

get_parent(n_index) {
  return _get_turret_data(n_index).e_parent;
}

laser_death_watcher() {
  self notify(#"laser_death_thread_stop");
  self endon(#"laser_death_thread_stop");
  self waittill(#"death");

  if(isDefined(self)) {
    self laseroff();
  }
}

enable_laser(b_enable, n_index) {
  if(b_enable) {
    _get_turret_data(n_index).has_laser = 1;
    self laseron();
    self thread laser_death_watcher();
    return;
  }

  _get_turret_data(n_index).has_laser = undefined;
  self laseroff();
  self notify(#"laser_death_thread_stop");
}

watch_for_flash() {
  self endon(#"watch_for_flash_and_stun", #"death");

  while(true) {
    waitresult = self waittill(#"flashbang");
    self notify(#"damage", {
      #amount: 1, 
      #attacker: waitresult.attacker, 
      #weapon: "flash_grenade"
    });
  }
}

watch_for_flash_and_stun(n_index) {
  self notify(#"watch_for_flash_and_stun_end");
  self endon(#"watch_for_flash_and_stun", #"death");
  self thread watch_for_flash();

  while(true) {
    waitresult = self waittill(#"damage");

    if(waitresult.weapon.dostun) {
      if(isDefined(self.stunned)) {
        continue;
      }

      self.stunned = 1;
      stop(n_index, 1);
      wait randomfloatrange(5, 7);
      self.stunned = undefined;
    }
  }
}

emp_watcher(n_index) {
  self notify(#"emp_thread_stop");
  self endon(#"emp_thread_stop", #"death");

  while(true) {
    waitresult = self waittill(#"damage");

    if(waitresult.weapon.isemp) {
      if(isDefined(self.emped)) {
        continue;
      }

      self.emped = 1;

      if(isDefined(_get_turret_data(n_index).has_laser)) {
        self laseroff();
      }

      stop(n_index, 1);
      wait randomfloatrange(5, 7);
      self.emped = undefined;

      if(isDefined(_get_turret_data(n_index).has_laser)) {
        self laseron();
      }
    }
  }
}

enable_emp(b_enable, n_index) {
  if(b_enable) {
    _get_turret_data(n_index).can_emp = 1;
    self thread emp_watcher(n_index);
    return;
  }

  _get_turret_data(n_index).can_emp = undefined;
  self notify(#"emp_thread_stop");
}

set_team(str_team, n_index) {
  _get_turret_data(n_index).str_team = str_team;
  self.team = str_team;
}

get_team(n_index) {
  str_team = undefined;
  s_turret = _get_turret_data(n_index);
  str_team = self.team;

  if(!isDefined(s_turret.str_team)) {
    s_turret.str_team = str_team;
  }

  return str_team;
}

is_turret_enabled(n_index) {
  return _get_turret_data(n_index).is_enabled;
}

does_need_user(n_index) {
  return isDefined(_get_turret_data(n_index).b_needs_user) && _get_turret_data(n_index).b_needs_user;
}

does_have_user(n_index) {
  return isalive(get_user(n_index));
}

get_user(n_index) {
  return self getseatoccupant(n_index);
}

_set_turret_needs_user(n_index, b_needs_user) {
  s_turret = _get_turret_data(n_index);

  if(b_needs_user) {
    s_turret.b_needs_user = 1;
    self thread watch_for_flash_and_stun(n_index);
    return;
  }

  self notify(#"watch_for_flash_and_stun_end");
  s_turret.b_needs_user = 0;
}

_wait_for_current_user_to_finish(n_index) {
  self endon(#"death");

  while(isalive(get_user(n_index))) {
    waitframe(1);
  }
}

is_current_user(ai_user, n_index) {
  ai_current_user = get_user(n_index);
  return isalive(ai_current_user) && ai_user == ai_current_user;
}

set_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_burst_fire_min = n_fire_min;
  s_turret.n_burst_fire_max = n_fire_max;
  s_turret.n_burst_wait_min = n_wait_min;
  s_turret.n_burst_wait_max = n_wait_max;
}

set_torso_targetting(n_index, n_torso_targetting_offset = -12) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_torso_targetting_offset = n_torso_targetting_offset;
}

set_target_leading(n_index, n_target_leading_factor = 0.1) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_target_leading_factor = n_target_leading_factor;
}

set_on_target_angle(n_angle, n_index) {
  s_turret = _get_turret_data(n_index);

  if(!isDefined(n_angle)) {
    if(s_turret.str_guidance_type != "none") {
      n_angle = 10;
      return;
    }

    n_angle = 2;
  }
}

set_target(e_target, v_offset, n_index) {
  self endon(#"death");
  s_turret = _get_turret_data(n_index);

  if(!isDefined(v_offset)) {
    v_offset = _get_default_target_offset(e_target, n_index);
  }

  if(!isDefined(n_index) || n_index == 0) {
    self turretsettarget(0, e_target, v_offset);
  } else {
    self turretsettarget(n_index, e_target, v_offset);
  }

  s_turret.e_target = e_target;
  s_turret.e_last_target = e_target;
  s_turret.v_offset = v_offset;
}

_get_default_target_offset(e_target, n_index) {
  s_turret = _get_turret_data(n_index);

  if(s_turret.str_weapon_type == "bullet") {
    if(isDefined(e_target)) {
      if(isplayer(e_target)) {
        z_offset = randomintrange(40, 50);
      } else if(e_target.type === "human") {
        z_offset = randomintrange(20, 60);
      } else if(e_target.type === "robot") {
        z_offset = randomintrange(40, 60);
      } else if(issentient(self) && issentient(e_target)) {
        z_offset = isDefined(s_turret.n_torso_targetting_offset) ? s_turret.n_torso_targetting_offset : isvehicle(e_target) ? 0 : 0;
      }

      if(isDefined(e_target.z_target_offset_override)) {
        if(!isDefined(z_offset)) {
          z_offset = 0;
        }

        z_offset += e_target.z_target_offset_override;
      }
    }
  }

  if(!isDefined(z_offset)) {
    z_offset = 0;
  }

  v_offset = (0, 0, z_offset);

  if((isDefined(s_turret.n_target_leading_factor) ? s_turret.n_target_leading_factor : 0) != 0 && isDefined(e_target) && issentient(self) && issentient(e_target) && !isvehicle(e_target)) {
    velocity = e_target getvelocity();
    v_offset += velocity * s_turret.n_target_leading_factor;
  }

  return v_offset;
}

get_target(n_index) {
  if(isDefined(_get_turret_data(n_index).e_target) && isDefined(_get_turret_data(n_index).e_target.ignoreme) && _get_turret_data(n_index).e_target.ignoreme) {
    clear_target(n_index);
  }

  return _get_turret_data(n_index).e_target;
}

is_target(e_target, n_index) {
  e_current_target = get_target(n_index);

  if(isDefined(e_current_target)) {
    return (e_current_target == e_target);
  }

  return false;
}

clear_target(n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret flag::clear("turret manual");
  s_turret.e_next_target = undefined;
  s_turret.e_target = undefined;

  if(!isDefined(n_index) || n_index == 0) {
    self turretcleartarget(0);
    return;
  }

  self turretcleartarget(n_index);
}

set_min_target_distance_squared(n_distance_squared, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_min_target_distance_squared = n_distance_squared;
}

fire(n_index) {
  s_turret = _get_turret_data(n_index);
  assert(isDefined(n_index) && n_index >= 0, "<dev string:x38>");

  if(n_index == 0) {
    self fireweapon(0, s_turret.e_target);
  } else {
    ai_current_user = get_user(n_index);

    if(isDefined(ai_current_user) && isDefined(ai_current_user.is_disabled) && ai_current_user.is_disabled) {
      return;
    }

    if(isDefined(s_turret.e_target)) {
      self turretsettarget(n_index, s_turret.e_target, s_turret.v_offset);
    }

    self fireweapon(n_index, s_turret.e_target, s_turret.v_offset, s_turret.e_parent);
  }

  s_turret.n_last_fire_time = gettime();
}

stop(n_index, b_clear_target = 0) {
  s_turret = _get_turret_data(n_index);
  s_turret.e_next_target = undefined;
  s_turret.e_target = undefined;
  s_turret flag::clear("turret manual");

  if(b_clear_target) {
    clear_target(n_index);
  }

  self notify("_stop_turret" + _index(n_index));
}

fire_for_time(n_time, n_index = 0) {
  assert(isDefined(n_time), "<dev string:x6a>");
  self endon(#"death", #"drone_death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index));
  self notify("_fire_turret_for_time" + _index(n_index));
  self endon("_fire_turret_for_time" + _index(n_index));
  b_fire_forever = 0;

  if(n_time < 0) {
    b_fire_forever = 1;
  } else {
    w_weapon = get_weapon(n_index);
    assert(n_time >= w_weapon.firetime, "<dev string:xa6>" + n_time + "<dev string:xb4>" + w_weapon.firetime);

  }

  while(n_time > 0 || b_fire_forever) {
    n_burst_time = _burst_fire(n_time, n_index);

    if(!b_fire_forever) {
      n_time -= n_burst_time;
    }
  }
}

shoot_at_target(e_target, n_time, v_offset, n_index, b_just_once) {
  assert(isDefined(e_target), "<dev string:xf9>");
  self endon(#"drone_death", #"death");
  s_turret = _get_turret_data(n_index);
  s_turret flag::set("turret manual");
  _shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once);
  s_turret flag::clear("turret manual");
}

_shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once) {
  self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index));
  self notify("_shoot_turret_at_target" + _index(n_index));
  self endon("_shoot_turret_at_target" + _index(n_index));

  if(n_time == -1) {
    e_target endon(#"death");
  }

  if(!isDefined(b_just_once)) {
    b_just_once = 0;
  }

  set_target(e_target, v_offset, n_index);

  if(!isDefined(self.aim_only_no_shooting)) {
    _waittill_turret_on_target(e_target, n_index);

    if(b_just_once) {
      fire(n_index);
      return;
    }

    fire_for_time(n_time, n_index);
  }
}

_waittill_turret_on_target(e_target, n_index) {
  do {
    wait isDefined(self.waittill_turret_on_target_delay) ? self.waittill_turret_on_target_delay : 0.5;

    if(!isDefined(n_index) || n_index == 0) {
      self waittill(#"turret_on_target");
      continue;
    }

    self waittill(#"gunner_turret_on_target");
  }
  while(isDefined(e_target) && !can_hit_target(e_target, n_index));
}

shoot_at_target_once(e_target, v_offset, n_index) {
  shoot_at_target(e_target, 0, v_offset, n_index, 1);
}

enable(n_index, b_user_required, v_offset) {
  if(isalive(self) && !is_turret_enabled(n_index)) {
    _get_turret_data(n_index).is_enabled = 1;
    self thread _turret_think(n_index, v_offset);
    self notify("turret_enabled" + _index(n_index));

    if(isDefined(b_user_required) && !b_user_required) {
      _set_turret_needs_user(n_index, 0);
      return;
    }

    _set_turret_needs_user(n_index, 1);
  }
}

enable_auto_use(b_enable = 1) {
  self.script_auto_use = b_enable;
}

disable_ai_getoff(n_index, b_disable = 1) {
  _get_turret_data(n_index).disable_ai_getoff = b_disable;
}

disable(n_index) {
  if(is_turret_enabled(n_index)) {
    _drop_turret(n_index);
    clear_target(n_index);
    _get_turret_data(n_index).is_enabled = 0;
    self notify("turret_disabled" + _index(n_index));
  }
}

pause(time, n_index) {
  s_turret = _get_turret_data(n_index);

  if(time > 0) {
    time = int(time * 1000);
  }

  if(isDefined(s_turret.pause)) {
    s_turret.pause_time += time;
    return;
  }

  s_turret.pause = 1;
  s_turret.pause_time = time;
  stop(n_index);
}

unpause(n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.pause = undefined;
}

_turret_think(n_index, v_offset) {
  turret_think_time = max(1.5, get_weapon(n_index).firetime);
  no_target_start_time = 0;
  self endon(#"death", "turret_disabled" + _index(n_index));
  self notify("_turret_think" + _index(n_index));
  self endon("_turret_think" + _index(n_index));

  self thread _debug_turret_think(n_index);

  self thread _turret_health_monitor(n_index);
  s_turret = _get_turret_data(n_index);

  if(isDefined(s_turret.has_laser)) {
    self laseron();
  }

  while(true) {
    s_turret flag::wait_till_clear("turret manual");
    n_time_now = gettime();

    if(self _check_for_paused(n_index) || isDefined(self.emped) || isDefined(self.stunned)) {
      wait turret_think_time;
      continue;
    }

    if(!isDefined(s_turret.e_target) || s_turret.e_target.health < 0) {
      stop(n_index);
    }

    e_original_next_target = s_turret.e_next_target;
    s_turret.e_next_target = _get_best_target(n_index);

    if(isDefined(s_turret.e_next_target)) {
      no_target_start_time = 0;

      if(_user_check(n_index)) {
        self thread _shoot_turret_at_target(s_turret.e_next_target, turret_think_time, v_offset, n_index);

        if(s_turret.e_next_target !== e_original_next_target) {
          self notify(#"has_new_target", {
            #target: s_turret.e_next_target
          });
        }
      }
    } else {
      if(!isDefined(self.do_not_clear_targets_during_think) || !self.do_not_clear_targets_during_think) {
        clear_target(n_index);
      }

      if(no_target_start_time == 0) {
        no_target_start_time = n_time_now;
      }

      target_wait_time = n_time_now - no_target_start_time;

      if(isDefined(s_turret.occupy_no_target_time)) {
        occupy_time = s_turret.occupy_no_target_time;
      } else {
        occupy_time = 3600;
      }

      if(!(isDefined(s_turret.disable_ai_getoff) && s_turret.disable_ai_getoff)) {
        bwasplayertarget = isDefined(s_turret.e_last_target) && s_turret.e_last_target.health > 0 && isplayer(s_turret.e_last_target);

        if(bwasplayertarget) {
          occupy_time /= 4;
        }
      } else {
        bwasplayertarget = 0;
      }

      if(target_wait_time >= occupy_time) {
        _drop_turret(n_index, !bwasplayertarget);
      }
    }

    if(!(isDefined(s_turret.disable_ai_getoff) && s_turret.disable_ai_getoff) && _has_nearby_player_enemy(n_index, self)) {
      _drop_turret(n_index, 0);
    }

    wait turret_think_time;
  }
}

_turret_health_monitor(n_index) {
  self endon(#"death");
  waitframe(1);
  _turret_health_monitor_loop(n_index);
  self disable(n_index);
}

_turret_health_monitor_loop(n_index) {
  self endon(#"death", "turret_disabled" + _index(n_index));

  while(true) {
    waitresult = self waittill(#"broken");

    if(waitresult.type === "turret_destroyed_" + n_index) {
      return;
    }
  }
}

_has_nearby_player_enemy(index, turret) {
  has_nearby_enemy = 0;
  time = gettime();
  ai_user = turret get_user(index);

  if(!isDefined(ai_user)) {
    return has_nearby_enemy;
  }

  if(!isDefined(turret.next_nearby_enemy_time)) {
    turret.next_nearby_enemy_time = time;
  }

  if(time >= turret.next_nearby_enemy_time) {
    players = getplayers();

    foreach(player in players) {
      if(!util::function_fbce7263(turret.team, player.team)) {
        continue;
      }

      if(abs(ai_user.origin[2] - player.origin[2]) <= 60 && distance2dsquared(ai_user.origin, player.origin) <= 300 * 300) {
        has_nearby_enemy = 1;
        break;
      }
    }

    turret.next_nearby_enemy_time = time + 1000;
  }

  return has_nearby_enemy;
}

_listen_for_damage_on_actor(ai_user, n_index) {
  self endon(#"death");
  ai_user endon(#"death");
  self endon("turret_disabled" + _index(n_index), "_turret_think" + _index(n_index), #"exit_vehicle");

  while(true) {
    waitresult = ai_user waittill(#"damage");
    s_turret = _get_turret_data(n_index);

    if(isDefined(s_turret)) {
      if(!isDefined(s_turret.e_next_target) && !isDefined(s_turret.e_target)) {
        s_turret.e_last_target = waitresult.attacker;
      }
    }
  }
}

_waittill_user_change(n_index) {
  ai_user = self getseatoccupant(n_index);

  if(isalive(ai_user)) {
    if(isactor(ai_user)) {
      ai_user endon(#"death");
    } else if(util::function_8e89351(ai_user)) {
      self notify("turret_disabled" + _index(n_index));
    }
  }

  self util::waittill_either("exit_vehicle", "enter_vehicle");
}

_check_for_paused(n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.pause_start_time = gettime();

  while(isDefined(s_turret.pause)) {
    if(s_turret.pause_time > 0) {
      time = gettime();
      paused_time = time - s_turret.pause_start_time;

      if(paused_time > s_turret.pause_time) {
        s_turret.pause = undefined;
        return true;
      }
    }

    waitframe(1);
  }

  return false;
}

_drop_turret(n_index, bexitifautomatedonly) {
  ai_user = get_user(n_index);

  if(isalive(ai_user) && !isbot(ai_user) && !isplayer(ai_user) && (isDefined(ai_user.turret_auto_use) && ai_user.turret_auto_use || !(isDefined(bexitifautomatedonly) && bexitifautomatedonly))) {
    vehicle::get_out(self, ai_user, "gunner1");
  }
}

does_have_target(n_index) {
  return isDefined(_get_turret_data(n_index).e_next_target);
}

_user_check(n_index) {
  s_turret = _get_turret_data(n_index);

  if(does_need_user(n_index)) {
    b_has_user = does_have_user(n_index);
    return b_has_user;
  }

  return 1;
}

_debug_turret_think(n_index) {
  self endon(#"death", "<dev string:x129>" + _index(n_index), "<dev string:x139>" + _index(n_index));
  s_turret = _get_turret_data(n_index);
  v_color = (0, 0, 1);

  while(true) {
    if(!getdvarint(#"g_debugturrets", 0)) {
      wait 0.2;
      continue;
    }

    has_target = isDefined(get_target(n_index));

    if(does_need_user(n_index) && !does_have_user(n_index) || !has_target) {
      v_color = (1, 1, 0);
    } else {
      v_color = (0, 1, 0);
    }

    str_team = get_team(n_index);

    if(!isDefined(str_team)) {
      str_team = "<dev string:x14b>";
    }

    str_target = "<dev string:x155>";
    e_target = s_turret.e_next_target;

    if(isDefined(e_target)) {
      if(isactor(e_target)) {
        str_target += "<dev string:x161>";
      } else if(isplayer(e_target)) {
        str_target += "<dev string:x166>";
      } else if(isvehicle(e_target)) {
        str_target += "<dev string:x16f>";
      } else if(isDefined(e_target.targetname) && e_target.targetname == "<dev string:x179>") {
        str_target += "<dev string:x179>";
      } else if(isDefined(e_target.classname)) {
        str_target += e_target.classname;
      }
    } else {
      str_target += "<dev string:x181>";
    }

    str_debug = self getentnum() + "<dev string:x188>" + str_team + "<dev string:x188>" + str_target;
    record3dtext(str_debug, self.origin, v_color, "<dev string:x18c>", self);
    waitframe(1);
  }
}

_get_turret_data(n_index) {
  s_turret = undefined;

  if(isvehicle(self)) {
    if(isDefined(self.a_turrets) && isDefined(self.a_turrets[n_index])) {
      s_turret = self.a_turrets[n_index];
    }
  } else {
    s_turret = self._turret;
  }

  if(!isDefined(s_turret)) {
    s_turret = _init_turret(n_index);
  }

  return s_turret;
}

has_turret(n_index) {
  if(isDefined(self.a_turrets) && isDefined(self.a_turrets[n_index])) {
    return true;
  }

  return false;
}

_update_turret_arcs(n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.rightarc = s_turret.w_weapon.rightarc;
  s_turret.leftarc = s_turret.w_weapon.leftarc;
  s_turret.toparc = s_turret.w_weapon.toparc;
  s_turret.bottomarc = s_turret.w_weapon.bottomarc;
}

_init_turret(n_index = 0) {
  self endon(#"death");
  w_weapon = get_weapon(n_index);

  if(w_weapon.name == #"none") {
    assertmsg("<dev string:x195>");
    return;
  }

  util::waittill_asset_loaded("xmodel", self.model);
  s_turret = _init_vehicle_turret(n_index);
  s_turret.w_weapon = w_weapon;
  _update_turret_arcs(n_index);
  s_turret.is_enabled = 0;
  s_turret.e_parent = self;
  s_turret.e_target = undefined;
  s_turret.b_ignore_line_of_sight = 0;
  s_turret.v_offset = (0, 0, 0);
  s_turret.n_burst_fire_time = 0;
  s_turret.str_weapon_type = w_weapon.type;
  s_turret.str_guidance_type = w_weapon.guidedmissiletype;
  set_on_target_angle(undefined, n_index);
  s_turret flag::init("turret manual");
  return s_turret;
}

_init_vehicle_turret(n_index) {
  assert(isDefined(n_index) && n_index >= 0, "<dev string:x1c1>");
  s_turret = spawnStruct();

  switch (n_index) {
    case 0:
      s_turret.str_tag_flash = "tag_flash";
      s_turret.str_tag_pivot = "tag_barrel";
      break;
    case 1:
      s_turret.str_tag_flash = "tag_gunner_flash1";
      s_turret.str_tag_pivot = "tag_gunner_barrel1";
      break;
    case 2:
      s_turret.str_tag_flash = "tag_gunner_flash2";
      s_turret.str_tag_pivot = "tag_gunner_barrel2";
      break;
    case 3:
      s_turret.str_tag_flash = "tag_gunner_flash3";
      s_turret.str_tag_pivot = "tag_gunner_barrel3";
      break;
    case 4:
      s_turret.str_tag_flash = "tag_gunner_flash4";
      s_turret.str_tag_pivot = "tag_gunner_barrel4";
      break;
  }

  if(self.vehicleclass === "helicopter") {
    s_turret.e_trace_ignore = self;
  }

  if(!isDefined(self.a_turrets)) {
    self.a_turrets = [];
  }

  self.a_turrets[n_index] = s_turret;

  if(n_index > 0) {
    tag_origin = self gettagorigin(_get_gunner_tag_for_turret_index(n_index));

    if(isDefined(tag_origin)) {
      _set_turret_needs_user(n_index, 1);
    }
  }

  return s_turret;
}

_burst_fire(n_max_time, n_index) {
  self endon(#"terminate_all_turrets_firing");

  if(n_max_time < 0) {
    n_max_time = 9999;
  }

  s_turret = _get_turret_data(n_index);
  n_burst_time = _get_burst_fire_time(n_index);
  n_burst_wait = _get_burst_wait_time(n_index);

  if(!isDefined(n_burst_time) || n_burst_time > n_max_time) {
    n_burst_time = n_max_time;
  }

  if(s_turret.n_burst_fire_time >= n_burst_time) {
    s_turret.n_burst_fire_time = 0;
    n_time_since_last_shot = float(gettime() - s_turret.n_last_fire_time) / 1000;

    if(n_time_since_last_shot < n_burst_wait) {
      wait n_burst_wait - n_time_since_last_shot;
    }
  } else {
    n_burst_time -= s_turret.n_burst_fire_time;
  }

  w_weapon = get_weapon(n_index);
  n_fire_time = w_weapon.firetime;
  n_total_time = 0;

  while(n_total_time < n_burst_time) {
    fire(n_index);
    n_total_time += n_fire_time;
    s_turret.n_burst_fire_time += n_fire_time;
    wait n_fire_time;
  }

  if(n_burst_wait > 0) {
    wait n_burst_wait;
  }

  return n_burst_time + n_burst_wait;
}

_get_burst_fire_time(n_index) {
  s_turret = _get_turret_data(n_index);
  n_time = undefined;

  if(isDefined(s_turret.n_burst_fire_min) && isDefined(s_turret.n_burst_fire_max)) {
    if(s_turret.n_burst_fire_min == s_turret.n_burst_fire_max) {
      n_time = s_turret.n_burst_fire_min;
    } else {
      n_time = randomfloatrange(s_turret.n_burst_fire_min, s_turret.n_burst_fire_max);
    }
  } else if(isDefined(s_turret.n_burst_fire_max)) {
    n_time = randomfloatrange(0, s_turret.n_burst_fire_max);
  }

  return n_time;
}

_get_burst_wait_time(n_index) {
  s_turret = _get_turret_data(n_index);
  n_time = 0;

  if(isDefined(s_turret.n_burst_wait_min) && isDefined(s_turret.n_burst_wait_max)) {
    if(s_turret.n_burst_wait_min == s_turret.n_burst_wait_max) {
      n_time = s_turret.n_burst_wait_min;
    } else {
      n_time = randomfloatrange(s_turret.n_burst_wait_min, s_turret.n_burst_wait_max);
    }
  } else if(isDefined(s_turret.n_burst_wait_max)) {
    n_time = randomfloatrange(0, s_turret.n_burst_wait_max);
  }

  return n_time;
}

_index(n_index) {
  return isDefined(n_index) ? "" + n_index : "";
}

_get_best_target(n_index) {
  e_best_target = undefined;
  self util::make_sentient();

  switch (n_index) {
    case 0:
      e_best_target = self.enemy;
      break;
    case 1:
      e_best_target = self.gunner1enemy;
      break;
    case 2:
      e_best_target = self.gunner2enemy;
      break;
    case 3:
      e_best_target = self.gunner3enemy;
      break;
    case 4:
      e_best_target = self.gunner4enemy;
      break;
  }

  return e_best_target;
}

can_hit_target(e_target, n_index) {
  s_turret = _get_turret_data(n_index);
  v_offset = _get_default_target_offset(e_target, n_index);
  b_current_target = is_target(e_target, n_index);

  if(isDefined(e_target) && isDefined(e_target.ignoreme) && e_target.ignoreme) {
    return 0;
  }

  b_trace_passed = 1;

  if(!s_turret.b_ignore_line_of_sight) {
    b_trace_passed = trace_test(e_target, v_offset - (0, 0, isDefined(s_turret.n_torso_targetting_offset) ? s_turret.n_torso_targetting_offset : isvehicle(e_target) ? 0 : 0), n_index);
  }

  if(b_current_target && !b_trace_passed && !isDefined(s_turret.n_time_lose_sight)) {
    s_turret.n_time_lose_sight = gettime();
  }

  return b_trace_passed;
}

trace_test(e_target, v_offset = (0, 0, 0), n_index) {
  if(isDefined(self.good_old_style_turret_tracing)) {
    s_turret = _get_turret_data(n_index);
    v_start_org = self gettagorigin(s_turret.str_tag_pivot);

    if(e_target sightconetrace(v_start_org, self) > 0.2) {
      v_target = e_target.origin + v_offset;
      v_start_org += vectornormalize(v_target - v_start_org) * 50;
      a_trace = bulletTrace(v_start_org, v_target, 1, s_turret.e_trace_ignore, 0, 1);

      if(a_trace[#"fraction"] > 0.6) {
        return true;
      }
    }

    return false;
  }

  s_turret = _get_turret_data(n_index);
  v_start_org = self gettagorigin(s_turret.str_tag_pivot);
  v_target = e_target.origin + v_offset;

  if((sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) && isplayer(e_target)) {
    v_target = e_target getshootatpos();
  }

  if(distancesquared(v_start_org, v_target) < 10000) {
    return true;
  }

  v_dir_to_target = vectornormalize(v_target - v_start_org);
  v_start_org += v_dir_to_target * 50;
  v_target -= v_dir_to_target * 75;

  if(sighttracepassed(v_start_org, v_target, 0, self, e_target)) {
    return true;
  }

  return false;
}

set_ignore_line_of_sight(b_ignore, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.b_ignore_line_of_sight = b_ignore;
}

set_occupy_no_target_time(time, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.occupy_no_target_time = time;
}

toggle_lensflare(bool) {
  self clientfield::set("toggle_lensflare", bool);
}

track_lens_flare() {
  self endon(#"death");
  self notify(#"disable_lens_flare");
  self endon(#"disable_lens_flare");

  while(true) {
    e_target = self turretgettarget(0);

    if(self.turretontarget && isDefined(e_target) && isplayer(e_target)) {
      if(isDefined(self gettagorigin("TAG_LASER"))) {
        e_target util::waittill_player_looking_at(self gettagorigin("TAG_LASER"), 90);

        if(isDefined(e_target)) {
          self toggle_lensflare(1);
          e_target util::waittill_player_not_looking_at(self gettagorigin("TAG_LASER"));
        }

        self toggle_lensflare(0);
      }
    }

    wait 0.5;
  }
}

_get_gunner_tag_for_turret_index(n_index) {
  switch (n_index) {
    case 1:
      return "tag_gunner1";
    case 2:
      return "tag_gunner2";
    case 3:
      return "tag_gunner3";
    case 4:
      return "tag_gunner4";
    default:
      assertmsg("<dev string:x1f9>");
      break;
  }
}