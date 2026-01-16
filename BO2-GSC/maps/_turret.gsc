/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_turret.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_drones;

autoexec _init_turrets() {
  level._turrets = spawnstruct();
  a_turrets = getentarray("misc_turret", "classname");

  foreach(e_turret in a_turrets)
  e_turret thread _auto_init_misc_turret();
}

_auto_init_misc_turret() {
  waittill_asset_loaded("xmodel", self.model);

  if(isDefined(self.targetname)) {
    nd_turret = getnode(self.targetname, "target");

    if(isDefined(nd_turret)) {
      nd_turret.turret = self;
      self.node = nd_turret;
      self thread _turret_node_think();
    }

    if(self has_spawnflag(1))
      self enable_turret();
  }
}

get_turret_weapon_name(n_index) {
  if(isDefined(self.classname) && self.classname == "script_vehicle")
    str_weapon = self seatgetweapon(n_index);
  else
    str_weapon = self.weaponinfo;

  return str_weapon;
}

get_turret_parent(n_index) {
  return _get_turret_data(n_index).e_parent;
}

laser_death_watcher() {
  self notify("laser_death_thread_stop");
  self endon("laser_death_thread_stop");
  self waittill("death");
  self laseroff();
}

enable_turret_laser(b_enable, n_index) {
  if(b_enable) {
    _get_turret_data(n_index).has_laser = 1;
    self laseron();
    self thread laser_death_watcher();
  } else {
    _get_turret_data(n_index).has_laser = undefined;
    self laseroff();
    self notify("laser_death_thread_stop");
  }
}

watch_for_flash() {
  self endon("watch_for_flash_and_stun");
  self endon("death");

  while(true) {
    self waittill("flashbang", pct_dist, pct_angle, attacker, team);
    self notify("damage", 1, attacker, undefined, undefined, undefined, undefined, undefined, undefined, "flash_grenade_sp");
  }
}

watch_for_flash_and_stun(n_index) {
  self notify("watch_for_flash_and_stun_end");
  self endon("watch_for_flash_and_stun");
  self endon("death");
  self thread watch_for_flash();

  while(true) {
    self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weaponname);

    if(isDefined(weaponname) && (weaponname == "concussion_grenade_sp" || weaponname == "concussion_grenade_80s_sp" || weaponname == "flash_grenade_sp" || weaponname == "flash_grenade_80s_sp")) {
      if(isDefined(self.stunned)) {
        continue;
      }
      self.stunned = 1;
      stop_turret(n_index, 1);
      wait(randomfloatrange(5, 7));
      self.stunned = undefined;
    }
  }
}

emp_watcher(n_index) {
  self notify("emp_thread_stop");
  self endon("emp_thread_stop");
  self endon("death");

  while(true) {
    self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weaponname);

    if(isDefined(weaponname) && weaponname == "emp_grenade_sp") {
      if(isDefined(self.emped)) {
        continue;
      }
      self.emped = 1;

      if(isDefined(_get_turret_data(n_index).has_laser))
        self laseroff();

      stop_turret(n_index, 1);
      wait(randomfloatrange(5, 7));
      self.emped = undefined;

      if(isDefined(_get_turret_data(n_index).has_laser))
        self laseron();
    }
  }
}

enable_turret_emp(b_enable, n_index) {
  if(b_enable) {
    _get_turret_data(n_index).can_emp = 1;
    self thread emp_watcher(n_index);
    self.takedamage = 1;
  } else {
    _get_turret_data(n_index).can_emp = undefined;
    self notify("emp_thread_stop");
  }
}

set_turret_team(str_team, n_index) {
  _get_turret_data(n_index).str_team = str_team;
  self setturretteam(str_team);
}

get_turret_team(n_index) {
  str_team = undefined;
  s_turret = _get_turret_data(n_index);

  if(isDefined(self.classname) && self.classname == "script_vehicle") {
    str_team = self.vteam;

    if(!isDefined(s_turret.str_team))
      s_turret.str_team = str_team;
  } else {
    ai_user = get_turret_user(n_index);

    if(isDefined(ai_user)) {
      str_team = ai_user getteam();

      if(!isDefined(s_turret.str_team))
        s_turret.str_team = str_team;
    } else
      str_team = s_turret.str_team;
  }

  return str_team;
}

is_turret_enabled(n_index) {
  return _get_turret_data(n_index).is_enabled;
}

does_turret_need_user(n_index) {
  if(isDefined(self.classname) && self.classname == "script_vehicle")
    return isDefined(_get_turret_data(n_index).b_needs_user) && _get_turret_data(n_index).b_needs_user;
  else
    return isDefined(self.node);
}

does_turret_have_user(n_index) {
  return isDefined(get_turret_user(n_index));
}

get_turret_user(n_index) {
  ai_current_user = undefined;

  if(isDefined(self.classname) && self.classname == "script_vehicle") {
    s_turret = _get_turret_data(n_index);

    if(isDefined(s_turret)) {
      if(isDefined(s_turret.ai_user)) {
        if(isalive(s_turret.ai_user))
          ai_current_user = _get_turret_data(n_index).ai_user;
      }
    }
  } else if(does_turret_need_user()) {
    e_user = self getturretowner();

    if(isplayer(e_user))
      ai_current_user = e_user;
    else {
      e_user = _get_turret_data(n_index).ai_user;

      if(isalive(e_user))
        ai_current_user = e_user;
    }
  }

  return ai_current_user;
}

_set_turret_user(ai_user, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.ai_user = ai_user;

  if(isDefined(self.classname) && self.classname == "script_vehicle")
    s_turret notify("turretownerchange");
}

_set_turret_needs_user(n_index, b_needs_user) {
  s_turret = _get_turret_data(n_index);

  if(b_needs_user) {
    s_turret.b_needs_user = 1;
    self thread watch_for_flash_and_stun(n_index);
  } else {
    self notify("watch_for_flash_and_stun_end");
    s_turret.b_needs_user = 0;
  }
}

set_turret_target_ent_array(a_ents, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.priority_target_array = a_ents;
}

add_turret_priority_target(ent_or_ent_array, n_index) {
  s_turret = _get_turret_data(n_index);

  if(!isarray(ent_or_ent_array)) {
    a_new_targets = [];
    a_new_targets[0] = ent_or_ent_array;
  } else
    a_new_targets = ent_or_ent_array;

  if(isDefined(s_turret.priority_target_array))
    a_new_targets = arraycombine(s_turret.priority_target_array, a_new_targets, 1, 0);

  s_turret.priority_target_array = a_new_targets;
}

clear_turret_target_ent_array(n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.priority_target_array = undefined;
}

set_turret_ignore_ent_array(a_ents, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.a_ignore_target_array = a_ents;
}

clear_turret_ignore_ent_array(n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.a_ignore_target_array = undefined;
}

use_turret(e_turret, b_stay_on, n_index) {
  assert(isalive(self), "Dead user passed into use_turret.");
  e_turret _use_turret(self, b_stay_on, n_index, 0);
}

use_turret_teleport(e_turret, b_stay_on, n_index) {
  assert(isalive(self), "Dead user passed into use_turret_teleport.");
  e_turret _use_turret(self, b_stay_on, n_index, 1);
}

_use_turret(ai_user, b_stay_on, n_index, b_teleport) {
  ai_user endon("death");
  ai_user endon("stop_use_turret");
  self endon("turret_disabled" + _index(n_index));

  if(isDefined(self.classname) && self.classname == "script_vehicle")
    return false;
  else {
    assert(isDefined(self.node), "Turret does not have node at " + self.origin);
    ai_user._turret_stay_on = is_true(b_stay_on);
    self setturretignoregoals(ai_user._turret_stay_on);
    ai_current_user = self getturretowner();

    if(!isDefined(ai_current_user) || ai_current_user != ai_user) {
      if(!is_turret_current_user(ai_user, n_index))
        _wait_for_current_user_to_finish(n_index);

      if(is_true(b_stay_on))
        setenablenode(self.node, 1);

      _set_turret_user(ai_user, n_index);

      if(!is_turret_enabled(n_index))
        self thread _disable_turret_when_user_is_done(ai_user);

      enable_turret(n_index);

      if(b_teleport)
        ai_user forceteleport(self.node.origin, self.node.angles);
      else
        ai_user force_goal(self.node, 16);

      set_turret_team(ai_user getteam(), n_index);
      self setmode("manual_ai");
      ai_user.a.disablelongdeath = 1;
      self notify("user_using_turret" + _index(n_index));

      if(ai_user._turret_stay_on || does_turret_have_target()) {
        ai_user useturret(self);
        self waittill("turretownerchange");
      }
    }
  }
}

_disable_turret_when_user_is_done(ai_user, n_index) {
  self endon("death");
  self endon("turret_disabled" + _index(n_index));
  ai_user waittill_any("death", "stop_use_turret");
  disable_turret(n_index);
}

_wait_for_current_user_to_finish(n_index) {
  self endon("death");

  while(isalive(get_turret_user(n_index)))
    wait 0.05;
}

is_turret_current_user(e_user, n_index) {
  e_current_user = get_turret_user(n_index);

  if(isalive(e_current_user) && e_current_user == e_user)
    return true;

  return false;
}

is_current_user(ai_user, n_index) {
  ai_current_user = get_turret_user(n_index);
  return isalive(ai_current_user) && ai_user == ai_current_user;
}

_animscripts_init(ai_user) {
  self show();
  _init_animations(ai_user);
  enable_turret();
}

stop_use_turret() {
  if(isDefined(self.classname) && self.classname == "script_vehicle") {
  } else {
    e_turret = self getturret();

    if(isDefined(e_turret)) {
      if(isplayer(self))
        self stopusingturret();
      else if(isalive(self))
        self stopuseturret();

      e_turret _set_turret_user(undefined);
    }

    self._turret_stay_on = undefined;
  }

  self notify("stop_use_turret");
}

set_turret_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_burst_fire_min = n_fire_min;
  s_turret.n_burst_fire_max = n_fire_max;
  s_turret.n_burst_wait_min = n_wait_min;
  s_turret.n_burst_wait_max = n_wait_max;
}

set_turret_on_target_angle(n_angle, n_index) {
  s_turret = _get_turret_data(n_index);

  if(!isDefined(n_angle)) {
    if(s_turret.str_guidance_type != "none")
      n_angle = 10;
    else
      n_angle = 2;
  }

  if(n_index > 0)
    self setontargetangle(n_angle, n_index - 1);
  else
    self setontargetangle(n_angle);
}

set_turret_target(e_target, v_offset, n_index) {
  s_turret = _get_turret_data(n_index);

  if(!isDefined(v_offset))
    v_offset = _get_default_target_offset(e_target, n_index);

  if(!(isDefined(self.classname) && self.classname == "script_vehicle")) {
    if(isDefined(s_turret.ai_user))
      self setmode("manual_ai");
    else
      self setmode("manual");
  }

  if(!isDefined(n_index) || n_index == 0)
    self settargetentity(e_target, v_offset);
  else
    self settargetentity(e_target, v_offset, n_index - 1);

  s_turret.e_target = e_target;
  s_turret.v_offset = v_offset;
}

_get_default_target_offset(e_target, n_index) {
  s_turret = _get_turret_data(n_index);

  if(s_turret.str_weapon_type == "bullet") {
    if(isDefined(e_target)) {
      if(isplayer(e_target))
        z_offset = randomintrange(40, 50);
      else if(!isDefined(e_target.type) && !isDefined("human") || isDefined(e_target.type) && isDefined("human") && e_target.type == "human")
        z_offset = randomintrange(20, 60);

      if(isDefined(e_target.z_target_offset_override)) {
        if(!isDefined(z_offset))
          z_offset = 0;

        z_offset = z_offset + e_target.z_target_offset_override;
      }
    }
  }

  if(!isDefined(z_offset))
    z_offset = 0;

  v_offset = (0, 0, z_offset);
  return v_offset;
}

get_turret_target(n_index) {
  return _get_turret_data(n_index).e_target;
}

is_turret_target(e_target, n_index) {
  e_current_target = get_turret_target(n_index);

  if(isDefined(e_current_target))
    return e_current_target == e_target;

  return false;
}

clear_turret_target(n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret ent_flag_clear("turret manual");
  s_turret.e_next_target = undefined;
  s_turret.e_target = undefined;

  if(isDefined(self.classname) && self.classname == "script_vehicle") {
    if(!isDefined(n_index) || n_index == 0)
      self clearturrettarget();
    else
      self cleargunnertarget(n_index - 1);
  } else
    self cleartargetentity();
}

set_turret_target_flags(n_flags, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_target_flags = n_flags;
}

_has_target_flags(n_flags, n_index) {
  n_current_flags = _get_turret_data(n_index).n_target_flags;
  return (n_current_flags & n_flags) == n_flags;
}

set_turret_max_target_distance(n_distance, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_max_target_distance = n_distance;
}

fire_turret(n_index) {
  s_turret = _get_turret_data(n_index);

  if(isDefined(self.classname) && self.classname == "script_vehicle") {
    assert(isDefined(n_index) && n_index >= 0, "Invalid index specified to fire vehicle turret.");

    if(n_index == 0) {
      if(isDefined(s_turret.e_target))
        self fireweapon(s_turret.e_target);
      else
        self fireweapon();
    } else {
      if(isDefined(s_turret.e_target))
        self setgunnertargetent(s_turret.e_target, s_turret.v_offset, n_index - 1);

      self firegunnerweapon(n_index - 1);
    }
  } else
    self shootturret();

  s_turret.n_last_fire_time = gettime();
}

stop_turret(n_index, b_clear_target) {
  if(!isDefined(b_clear_target))
    b_clear_target = 0;

  s_turret = _get_turret_data(n_index);
  s_turret.e_next_target = undefined;
  s_turret.e_target = undefined;
  s_turret ent_flag_clear("turret manual");

  if(b_clear_target)
    clear_turret_target(n_index);

  self notify("_stop_turret" + _index(n_index));
}

fire_turret_for_time(n_time, n_index) {
  assert(isDefined(n_time), "n_time is a required parameter for _turet::fire_turret_for_time.");
  self endon("death");
  self endon("drone_death");
  self endon("_stop_turret" + _index(n_index));
  self endon("turret_disabled" + _index(n_index));
  self notify("_fire_turret_for_time" + _index(n_index));
  self endon("_fire_turret_for_time" + _index(n_index));
  b_fire_forever = 0;

  if(n_time < 0)
    b_fire_forever = 1;
  else {
    n_fire_time = weaponfiretime(get_turret_weapon_name(n_index));
    assert(n_time >= n_fire_time, "Fire time (" + n_time + ") must be greater than the weapon's fire time. weapon fire time = " + n_fire_time);

  }

  while(n_time > 0 || b_fire_forever) {
    n_burst_time = _burst_fire(n_time, n_index);

    if(!b_fire_forever)
      n_time = n_time - n_burst_time;
  }
}

shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once) {
  assert(isDefined(e_target), "Undefined target passed to shoot_turret_at_target().");
  self endon("drone_death");
  self endon("death");
  s_turret = _get_turret_data(n_index);
  s_turret ent_flag_set("turret manual");
  _shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once);
  s_turret ent_flag_clear("turret manual");
}

_shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once) {
  self endon("drone_death");
  self endon("death");
  self endon("_stop_turret" + _index(n_index));
  self notify("_shoot_turret_at_target" + _index(n_index));
  self endon("_shoot_turret_at_target" + _index(n_index));

  if(n_time == -1)
    e_target endon("death");

  if(!isDefined(b_just_once))
    b_just_once = 0;

  set_turret_target(e_target, v_offset, n_index);
  _waittill_turret_on_target(e_target, n_index);

  if(b_just_once)
    fire_turret(n_index);
  else
    fire_turret_for_time(n_time, n_index);
}

_waittill_turret_on_target(e_target, n_index) {
  do {
    wait 0.5;

    if(!isDefined(n_index) || n_index == 0) {
      self waittill("turret_on_target");
      continue;
    }

    self waittill("gunner_turret_on_target");
  }
  while(isDefined(e_target) && !can_turret_hit_target(e_target, n_index));
}

shoot_turret_at_target_once(e_target, v_offset, n_index) {
  shoot_turret_at_target(e_target, 0, v_offset, n_index, 1);
}

enable_turret(n_index, b_user_required, v_offset) {
  if(!is_turret_enabled(n_index)) {
    if(isDefined(self.ai_node_user))
      _set_turret_user(self.ai_node_user);

    _get_turret_data(n_index).is_enabled = 1;
    self thread _turret_think(n_index, v_offset);
    self notify("turret_enabled" + _index(n_index));

    if(isDefined(b_user_required) && !b_user_required)
      _set_turret_needs_user(n_index, 0);
  }
}

disable_turret(n_index) {
  if(is_turret_enabled(n_index)) {
    _drop_turret(n_index);
    clear_turret_target(n_index);
    _get_turret_data(n_index).is_enabled = 0;
    self notify("turret_disabled" + _index(n_index));
  }
}

pause_turret(time, n_index) {
  s_turret = _get_turret_data(n_index);

  if(time > 0)
    time = time * 1000;

  if(isDefined(s_turret.pause))
    s_turret.pause_time = s_turret.pause_time + time;
  else {
    s_turret.pause = 1;
    s_turret.pause_time = time;
    stop_turret(n_index);
  }
}

unpause_turret(n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.pause = undefined;
}

_turret_think(n_index, v_offset) {
  no_target_start_time = 0;
  self endon("death");
  self endon("turret_disabled" + _index(n_index));
  self notify("_turret_think" + _index(n_index));
  self endon("_turret_think" + _index(n_index));

  self thread _debug_turret_think(n_index);

  self thread _turret_user_think(n_index);

  if(!(isDefined(self.classname) && self.classname == "script_vehicle"))
    self thread _turret_new_user_think(n_index);

  s_turret = _get_turret_data(n_index);

  if(isDefined(s_turret.has_laser))
    self laseron();

  while(true) {
    s_turret ent_flag_waitopen("turret manual");
    n_time_now = gettime();

    if(self _check_for_paused(n_index) || isDefined(self.emped) || isDefined(self.stunned)) {
      wait 1.5;
      continue;
    }

    a_potential_targets = _get_potential_targets(n_index);

    if(!isDefined(s_turret.e_target) || s_turret.e_target.health < 0 || !isinarray(a_potential_targets, s_turret.e_target) || s_turret _did_turret_lose_target(n_time_now))
      stop_turret(n_index);

    s_turret.e_next_target = _get_best_target_from_potential(a_potential_targets, n_index);

    if(isDefined(s_turret.e_next_target)) {
      s_turret.b_target_out_of_range = undefined;
      s_turret.n_time_lose_sight = undefined;
      no_target_start_time = 0;

      if(!is_turret_target(s_turret.e_next_target, n_index) && _user_check(n_index))
        self thread _shoot_turret_at_target(s_turret.e_next_target, -2, v_offset, n_index);
    } else {
      if(no_target_start_time == 0)
        no_target_start_time = n_time_now;

      target_wait_time = (n_time_now - no_target_start_time) / 1000.0;

      if(isDefined(s_turret.occupy_no_target_time))
        occupy_time = s_turret.occupy_no_target_time;
      else
        occupy_time = 3600;

      if(target_wait_time >= occupy_time)
        _drop_turret(n_index);
    }

    wait 1.5;
  }
}

_did_turret_lose_target(n_time_now) {
  if(isDefined(self.b_target_out_of_range) && self.b_target_out_of_range)
    return true;
  else if(isDefined(self.n_time_lose_sight))
    return n_time_now - self.n_time_lose_sight > 3000;

  return false;
}

_turret_user_think(n_index) {
  self endon("death");
  self endon("turret_disabled" + _index(n_index));
  self endon("_turret_think" + _index(n_index));
  s_turret = _get_turret_data(n_index);

  while(true) {
    waittill_any_ents(self, "turretownerchange", s_turret, "turretownerchange", s_turret.ai_user, "death");

    if(!_user_check(n_index)) {
      stop_turret(n_index, 1);
      _clear_animations(n_index);
    }
  }
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

    wait 0.05;
  }

  return false;
}

_drop_turret(n_index) {
  ai_user = get_turret_user(n_index);

  if(isalive(ai_user) && !is_true(ai_user._turret_stay_on)) {
    player = get_players()[0];

    if(ai_user == player) {
      return;
    }
    if(!(isDefined(self.classname) && self.classname == "script_vehicle"))
      ai_user stopuseturret();
  }
}

_turret_new_user_think(n_index) {
  self endon("death");
  self endon("_turret_think" + _index(n_index));
  self endon("turret_disabled" + _index(n_index));
  s_turret = _get_turret_data(n_index);

  while(does_turret_need_user(n_index)) {
    wait 3;

    if(does_turret_have_target(n_index)) {
      ai_user = get_turret_user(n_index);

      if(isDefined(ai_user))
        ai_user thread use_turret(self, n_index);
      else if(has_spawnflag(2)) {
        str_team = get_turret_team(n_index);

        if(isDefined(self.classname) && self.classname == "script_vehicle") {
        } else {
          a_users = getaiarray(str_team);

          if(a_users.size > 0) {
            a_users = array_removedead(a_users);
            ai_closest = getclosest(self.origin, a_users);

            if(isDefined(self.radius)) {
              if(distancesquared(ai_closest.origin, self.origin) < self.radius * self.radius)
                ai_user = ai_closest;
            } else
              ai_user = ai_closest;
          }
        }

        if(isalive(ai_user))
          ai_user thread use_turret(self, n_index);
      }
    }
  }
}

does_turret_have_target(n_index) {
  return isDefined(_get_turret_data(n_index).e_next_target);
}

_turret_node_think(n_index) {
  self endon("death");

  while(true) {
    wait 0.05;

    if(isDefined(self.node)) {
      b_enable_node = is_turret_enabled(n_index) && does_turret_have_target(n_index);
      setenablenode(self.node, b_enable_node);
    }
  }
}

_stop_turret_when_user_changes(n_index) {
  self endon("death");
  s_turret = _get_turret_data(n_index);
  waittill_any_ents(self, "turretownerchange", s_turret, "turretownerchange", s_turret.ai_user, "death");
  stop_turret(n_index, 1);
  _clear_animations(n_index);
}

_user_check(n_index) {
  s_turret = _get_turret_data(n_index);
  ai_user = s_turret.ai_user;
  b_needs_user = does_turret_need_user(n_index);
  b_has_user = 0;

  if(isDefined(self.classname) && self.classname == "script_vehicle")
    b_has_user = isalive(s_turret.ai_user);
  else {
    e_user = self getturretowner();
    b_has_user = isDefined(e_user);

    if(b_has_user) {
      if(!isDefined(ai_user) || ai_user.health <= 0)
        b_has_user = 0;
    }
  }

  return !b_needs_user || b_has_user;
}

_get_user_target(n_index) {
  if(!(isDefined(self.classname) && self.classname == "script_vehicle")) {
    ai_user = self getturretowner();

    if(isDefined(ai_user))
      return ai_user.enemy;
  }
}

_debug_turret_think(n_index) {
  self endon("death");
  self endon("_turret_think" + _index(n_index));
  self endon("turret_disabled" + _index(n_index));
  s_turret = _get_turret_data(n_index);
  v_color = (0, 0, 1);

  while(true) {
    if(!getdvarint(#"_id_E62BCA4B")) {
      wait 0.2;
      continue;
    }

    has_target = isDefined(get_turret_target(n_index));

    if(does_turret_need_user(n_index) && !does_turret_have_user(n_index) || !has_target)
      v_color = (1, 1, 0);
    else
      v_color = (0, 1, 0);

    str_team = get_turret_team(n_index);

    if(!isDefined(str_team))
      str_team = "no team";

    str_target = "target > ";
    e_target = s_turret.e_next_target;

    if(isDefined(e_target)) {
      if(isai(e_target))
        str_target = str_target + "ai";
      else if(isplayer(e_target))
        str_target = str_target + "player";
      else if(isDefined(e_target.classname) && e_target.classname == "script_vehicle")
        str_target = str_target + "vehicle";
      else if(isDefined(e_target.targetname) && e_target.targetname == "drone")
        str_target = str_target + "drone";
      else if(isDefined(e_target.classname))
        str_target = str_target + e_target.classname;
    } else
      str_target = str_target + "none";

    str_debug = self getentnum() + ":" + str_team + ":" + str_target;
    record3dtext(str_debug, self.origin, v_color, "Script", self);
    wait 0.05;
  }

}

create_turret(position, angles, team, weaponinfo, turret_model, offset) {
  if(!isDefined(angles))
    angles = (0, 0, 0);

  origin = position;

  if(isDefined(offset))
    origin = origin + offset;

  e_turret = spawnturret("misc_turret", origin, weaponinfo);
  e_turret setmodel(turret_model);
  e_turret.angles = angles;
  e_turret.weaponinfo = weaponinfo;
  e_turret setdefaultdroppitch(0);
  e_turret set_turret_team(team);
  e_turret enable_turret();
  return e_turret;
}

_get_turret_data(n_index) {
  s_turret = undefined;

  if(isDefined(self.classname) && self.classname == "script_vehicle") {
    if(isDefined(self.a_turrets) && isDefined(self.a_turrets[n_index]))
      s_turret = self.a_turrets[n_index];
  } else
    s_turret = self._turret;

  if(!isDefined(s_turret))
    s_turret = _init_turret(n_index);

  return s_turret;
}

_init_turret(n_index) {
  if(!isDefined(n_index))
    n_index = 0;

  self endon("death");
  str_weapon = get_turret_weapon_name(n_index);

  if(!isDefined(str_weapon)) {
    assertmsg("Cannot initialize turret. No weapon info.");

    return;
  }

  waittill_asset_loaded("xmodel", self.model);

  if(isDefined(self.classname) && self.classname == "script_vehicle")
    s_turret = _init_vehicle_turret(n_index);
  else {
    n_index = 0;
    s_turret = _init_misc_turret();
  }

  s_turret.str_weapon = str_weapon;
  _update_turret_arcs(n_index);
  s_turret.is_enabled = 0;
  s_turret.e_parent = self;
  s_turret.e_target = undefined;
  s_turret.b_ignore_line_of_sight = 0;
  s_turret.v_offset = (0, 0, 0);
  s_turret.n_burst_fire_time = 0;
  s_turret.n_max_target_distance = undefined;
  s_turret.str_weapon_type = "bullet";
  s_turret.str_guidance_type = "none";
  str_weapon = self get_turret_weapon_name(n_index);

  if(isDefined(str_weapon)) {
    weapon_type = weapontype(str_weapon);

    if(isDefined(weapon_type))
      s_turret.str_weapon_type = weapon_type;

    s_turret.str_guidance_type = weaponguidedmissiletype(str_weapon);
  }

  set_turret_on_target_angle(undefined, n_index);
  s_turret.n_target_flags = 3;
  set_turret_best_target_func_from_weapon_type(n_index);
  s_turret ent_flag_init("turret manual");
  return s_turret;
}

_update_turret_arcs(n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.rightarc = weaponrightarc(s_turret.str_weapon);
  s_turret.leftarc = weaponleftarc(s_turret.str_weapon);
  s_turret.toparc = weapontoparc(s_turret.str_weapon);
  s_turret.bottomarc = weaponbottomarc(s_turret.str_weapon);
}

set_turret_best_target_func_from_weapon_type(n_index) {
  switch (_get_turret_data(n_index).str_weapon_type) {
    case "bullet":
      set_turret_best_target_func(::_get_best_target_bullet, n_index);
      break;
    case "gas":
      set_turret_best_target_func(::_get_best_target_gas, n_index);
      break;
    case "grenade":
      set_turret_best_target_func(::_get_best_target_grenade, n_index);
      break;
    case "projectile":
      set_turret_best_target_func(::_get_best_target_projectile, n_index);
      break;
    default:

      assertmsg("unsupported turret weapon type.");

  }
}

set_turret_best_target_func(func_get_best_target, n_index) {
  _get_turret_data(n_index).func_get_best_target = func_get_best_target;
}

#using_animtree("turret");

_init_misc_turret() {
  self useanimtree(#animtree);
  _init_animations();
  s_turret = spawnstruct();

  if(isDefined(self.script_team))
    s_turret.str_team = self.script_team;

  s_turret.n_rest_angle_pitch = 0;
  s_turret.n_rest_angle_yaw = 0;
  s_turret.str_tag_flash = "tag_flash";

  if(isDefined(self gettagorigin("tag_barrel")))
    s_turret.str_tag_pivot = "tag_barrel";
  else if(isDefined(self gettagorigin("mg01")))
    s_turret.str_tag_pivot = "mg01";
  else if(isDefined(self gettagorigin("tag_dummy")))
    s_turret.str_tag_pivot = "tag_dummy";
  else {
    assertmsg("No pivot tag found for turret.");

  }

  self._turret = s_turret;
  return s_turret;
}

_init_vehicle_turret(n_index) {
  assert(isDefined(n_index) && n_index >= 0, "Invalid index specified to initialize vehicle turret.");
  s_turret = spawnstruct();
  v_angles = self getseatfiringangles(n_index);

  if(isDefined(v_angles)) {
    s_turret.n_rest_angle_pitch = angleclamp180(v_angles[0] - self.angles[0]);
    s_turret.n_rest_angle_yaw = angleclamp180(v_angles[1] - self.angles[1]);
  }

  switch (n_index) {
    case 0:
      s_turret.str_tag_flash = "tag_flash";
      s_turret.str_tag_pivot = "tag_barrel";
      break;
    case 1:
      s_turret.str_tag_flash = "tag_flash_gunner1";
      s_turret.str_tag_pivot = "tag_gunner_barrel1";
      break;
    case 2:
      s_turret.str_tag_flash = "tag_flash_gunner2";
      s_turret.str_tag_pivot = "tag_gunner_barrel2";
      break;
    case 3:
      s_turret.str_tag_flash = "tag_flash_gunner3";
      s_turret.str_tag_pivot = "tag_gunner_barrel3";
      break;
    case 4:
      s_turret.str_tag_flash = "tag_flash_gunner4";
      s_turret.str_tag_pivot = "tag_gunner_barrel4";
      break;
  }

  if(self.vehicleclass == "helicopter")
    s_turret.e_trace_ignore = self;

  if(!isDefined(self.a_turrets))
    self.a_turrets = [];

  self.a_turrets[n_index] = s_turret;

  if(n_index > 0) {
    tag_origin = self gettagorigin(_get_gunner_tag_for_turret_index(n_index));

    if(isDefined(tag_origin))
      _set_turret_needs_user(n_index, 1);
  }

  return s_turret;
}

_burst_fire(n_max_time, n_index) {
  self endon("terminate_all_turrets_firing");

  if(n_max_time < 0)
    n_max_time = 9999;

  s_turret = _get_turret_data(n_index);
  n_burst_time = _get_burst_fire_time(n_index);
  n_burst_wait = _get_burst_wait_time(n_index);

  if(!isDefined(n_burst_time) || n_burst_time > n_max_time)
    n_burst_time = n_max_time;

  if(s_turret.n_burst_fire_time >= n_burst_time) {
    s_turret.n_burst_fire_time = 0;
    n_time_since_last_shot = (gettime() - s_turret.n_last_fire_time) / 1000;

    if(n_time_since_last_shot < n_burst_wait)
      wait(n_burst_wait - n_time_since_last_shot);
  } else
    n_burst_time = n_burst_time - s_turret.n_burst_fire_time;

  self thread _animate_fire_for_time(n_burst_time, n_index);
  n_fire_time = weaponfiretime(get_turret_weapon_name(n_index));
  n_total_time = 0;

  while(n_total_time < n_burst_time) {
    fire_turret(n_index);
    n_total_time = n_total_time + n_fire_time;
    s_turret.n_burst_fire_time = s_turret.n_burst_fire_time + n_fire_time;
    wait(n_fire_time);
  }

  if(n_burst_wait > 0)
    wait(n_burst_wait);

  return n_burst_time + n_burst_wait;
}

_animate_fire_for_time(n_time, n_index) {
  _animate_fire(n_index);
  self waittill_any_or_timeout(n_time, "death", "drone_death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index));

  if(isDefined(self))
    _animate_idle(n_index);
}

_get_burst_fire_time(n_index) {
  s_turret = _get_turret_data(n_index);
  n_time = undefined;

  if(isDefined(s_turret.n_burst_fire_min) && isDefined(s_turret.n_burst_fire_max)) {
    if(s_turret.n_burst_fire_min == s_turret.n_burst_fire_max)
      n_time = s_turret.n_burst_fire_min;
    else
      n_time = randomfloatrange(s_turret.n_burst_fire_min, s_turret.n_burst_fire_max);
  } else if(isDefined(s_turret.n_burst_fire_max))
    n_time = randomfloatrange(0, s_turret.n_burst_fire_max);

  return n_time;
}

_get_burst_wait_time(n_index) {
  s_turret = _get_turret_data(n_index);
  n_time = 0;

  if(isDefined(s_turret.n_burst_wait_min) && isDefined(s_turret.n_burst_wait_max)) {
    if(s_turret.n_burst_wait_min == s_turret.n_burst_wait_max)
      n_time = s_turret.n_burst_wait_min;
    else
      n_time = randomfloatrange(s_turret.n_burst_wait_min, s_turret.n_burst_wait_max);
  } else if(isDefined(s_turret.n_burst_wait_max))
    n_time = randomfloatrange(0, s_turret.n_burst_wait_max);

  return n_time;
}

_index(n_index) {
  if(isDefined(n_index))
    return string(n_index);
  else
    return "";
}

_get_potential_targets(n_index) {
  s_turret = self _get_turret_data(n_index);
  a_priority_targets = self _get_any_priority_targets(n_index);

  if(isDefined(a_priority_targets) && a_priority_targets.size > 0)
    return a_priority_targets;

  a_potential_targets = [];

  if(isDefined(s_turret.e_target))
    a_potential_targets[a_potential_targets.size] = s_turret.e_target;

  str_team = get_turret_team(n_index);

  if(isDefined(str_team)) {
    str_opposite_team = "allies";

    if(str_team == "allies")
      str_opposite_team = "axis";

    if(_has_target_flags(1, n_index)) {
      a_ai_targets = getaiarray(str_opposite_team);
      a_potential_targets = arraycombine(a_potential_targets, a_ai_targets, 1, 0);
    }

    if(_has_target_flags(2, n_index)) {
      a_player_targets = get_players(str_opposite_team);
      a_potential_targets = arraycombine(a_potential_targets, a_player_targets, 1, 0);
    }

    if(_has_target_flags(4, n_index)) {
      a_drone_targets = maps\_drones::drones_get_array(str_opposite_team);
      a_potential_targets = arraycombine(a_potential_targets, a_drone_targets, 1, 0);
    }

    if(_has_target_flags(8, n_index)) {
      a_vehicle_targets = getvehiclearray(str_opposite_team);
      a_potential_targets = arraycombine(a_potential_targets, a_vehicle_targets, 1, 0);
    }

    a_valid_targets = [];

    for(i = 0; i < a_potential_targets.size; i++) {
      e_target = a_potential_targets[i];
      ignore_target = 0;
      assert(isDefined(e_target), "Undefined potential turret target.");

      if(is_true(e_target.ignoreme) || e_target.health <= 0)
        ignore_target = 1;
      else if(issentient(e_target) && (e_target isnotarget() || e_target is_dead_sentient()))
        ignore_target = 1;
      else if(_is_target_within_range(e_target, s_turret) == 0)
        ignore_target = 1;

      if(!ignore_target)
        a_valid_targets[a_valid_targets.size] = e_target;
    }

    a_potential_targets = a_valid_targets;
  }

  a_targets = a_potential_targets;

  if(isDefined(s_turret) && isDefined(s_turret.a_ignore_target_array)) {
    while(true) {
      found_bad_target = 0;
      a_targets = a_potential_targets;

      for(i = 0; i < a_targets.size; i++) {
        e_target = a_targets[i];
        found_bad_target = 0;

        for(j = 0; j < s_turret.a_ignore_target_array.size; j++) {
          if(e_target == s_turret.a_ignore_target_array[j]) {
            arrayremovevalue(a_potential_targets, e_target);
            found_bad_target = 1;
            break;
          }
        }
      }

      if(!found_bad_target) {
        break;
      }
    }
  }

  return a_potential_targets;
}

_is_target_within_range(e_target, s_turret) {
  if(isDefined(s_turret.n_max_target_distance) && s_turret.n_max_target_distance > 0) {
    n_dist = distance(e_target.origin, self.origin);

    if(n_dist > s_turret.n_max_target_distance)
      return false;
  }

  return true;
}

_get_any_priority_targets(n_index) {
  a_targets = undefined;
  s_turret = _get_turret_data(n_index);

  if(isDefined(s_turret.priority_target_array)) {
    while(true) {
      found_bad_target = 0;
      a_targets = s_turret.priority_target_array;

      for(i = 0; i < a_targets.size; i++) {
        e_target = a_targets[i];
        bad_index = undefined;

        if(!isDefined(e_target))
          bad_index = i;
        else if(!isalive(e_target))
          bad_index = i;
        else if(e_target.health <= 0)
          bad_index = i;
        else if(issentient(e_target) && e_target is_dead_sentient())
          bad_index = i;

        if(isDefined(bad_index)) {
          s_turret.priority_target_array = a_targets;
          arrayremovevalue(s_turret.priority_target_array, e_target);
          found_bad_target = 1;
          break;
        }
      }

      if(!found_bad_target) {
        return s_turret.priority_target_array;
        break;
      } else if(s_turret.priority_target_array.size <= 0) {
        s_turret.priority_target_array = undefined;
        self notify("target_array_destroyed");
        break;
      }
    }
  }

  return a_targets;
}

_get_best_target_from_potential(a_potential_targets, n_index) {
  s_turret = _get_turret_data(n_index);
  return [[s_turret.func_get_best_target]](a_potential_targets, n_index);
}

_get_best_target_bullet(a_potential_targets, n_index) {
  e_best_target = undefined;

  while(!isDefined(e_best_target) && a_potential_targets.size > 0) {
    e_closest_target = getclosest(self.origin, a_potential_targets);

    if(self can_turret_hit_target(e_closest_target, n_index))
      e_best_target = e_closest_target;
    else
      arrayremovevalue(a_potential_targets, e_closest_target);
  }

  return e_best_target;
}

_get_best_target_gas(a_potential_targets, n_index) {
  return _get_best_target_bullet(a_potential_targets, n_index);
}

_get_best_target_grenade(a_potential_targets, n_index) {
  return _get_best_target_bullet(a_potential_targets, n_index);
}

_get_best_target_projectile(a_potential_targets, n_index) {
  return _get_best_target_bullet(a_potential_targets, n_index);
}

can_turret_hit_target(e_target, n_index) {
  s_turret = _get_turret_data(n_index);
  v_offset = _get_default_target_offset(e_target, n_index);
  b_current_target = is_turret_target(e_target, n_index);
  b_target_in_view = is_target_in_turret_view(e_target.origin + v_offset, n_index);
  b_trace_passed = 1;

  if(b_target_in_view) {
    if(!s_turret.b_ignore_line_of_sight)
      b_trace_passed = turret_trace_test(e_target, v_offset, n_index);

    if(b_current_target && !b_trace_passed && !isDefined(s_turret.n_time_lose_sight))
      s_turret.n_time_lose_sight = gettime();
  } else if(b_current_target)
    s_turret.b_target_out_of_range = 1;

  return b_target_in_view && b_trace_passed;
}

is_target_in_turret_view(v_target, n_index) {
  _update_turret_arcs(n_index);

  s_turret = _get_turret_data(n_index);
  v_pivot_pos = self gettagorigin(s_turret.str_tag_pivot);
  v_angles_to_target = vectortoangles(v_target - v_pivot_pos);
  n_rest_angle_pitch = s_turret.n_rest_angle_pitch + self.angles[0];
  n_rest_angle_yaw = s_turret.n_rest_angle_yaw + self.angles[1];
  n_ang_pitch = angleclamp180(v_angles_to_target[0] - n_rest_angle_pitch);
  n_ang_yaw = angleclamp180(v_angles_to_target[1] - n_rest_angle_yaw);
  b_out_of_range = 0;

  if(n_ang_pitch > 0) {
    if(n_ang_pitch > s_turret.bottomarc)
      b_out_of_range = 1;
  } else if(abs(n_ang_pitch) > s_turret.toparc)
    b_out_of_range = 1;

  if(n_ang_yaw > 0) {
    if(n_ang_yaw > s_turret.leftarc)
      b_out_of_range = 1;
  } else if(abs(n_ang_yaw) > s_turret.rightarc)
    b_out_of_range = 1;

  return !b_out_of_range;
}

turret_trace_test(e_target, v_offset, n_index) {
  if(!isDefined(v_offset))
    v_offset = (0, 0, 0);

  if(isDefined(self.good_old_style_turret_tracing)) {
    s_turret = _get_turret_data(n_index);
    v_start_org = self gettagorigin(s_turret.str_tag_pivot);

    if(e_target sightconetrace(v_start_org, self) > 0.2) {
      v_target = e_target.origin + v_offset;
      v_start_org = v_start_org + vectornormalize(v_target - v_start_org) * 15;
      a_trace = bullettrace(v_start_org, v_target, 1, s_turret.e_trace_ignore, 1, 1, e_target);

      if(a_trace["fraction"] > 0.6)
        return true;
    }

    return false;
  }

  s_turret = _get_turret_data(n_index);
  v_start_org = self gettagorigin(s_turret.str_tag_pivot);
  v_target = e_target.origin + v_offset;

  if(distancesquared(v_start_org, v_target) < 10000)
    return true;

  v_dir_to_target = vectornormalize(v_target - v_start_org);
  v_start_org = v_start_org + v_dir_to_target * 15;
  v_target = v_target - v_dir_to_target * 75;

  if(sighttracepassed(v_start_org, v_target, 0, self)) {
    a_trace = bullettrace(v_start_org, v_target, 1, s_turret.e_trace_ignore, 1, 1, e_target);

    if(a_trace["fraction"] > 0.6)
      return true;
  }

  return false;
}

set_turret_ignore_line_of_sight(b_ignore, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.b_ignore_line_of_sight = b_ignore;
}

set_turret_occupy_no_target_time(time, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.occupy_no_target_time = time;
}

_vehicle_turret_set_user(ai_user, str_tag) {
  turret_id = _get_turret_index_for_tag(str_tag);

  if(isDefined(turret_id))
    self _set_turret_user(ai_user, turret_id);
}

_vehicle_turret_clear_user(ai_user, str_tag) {
  turret_id = _get_turret_index_for_tag(str_tag);

  if(isDefined(turret_id))
    self _set_turret_user(undefined, turret_id);
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

      assertmsg("unsupported turret index for getting gunner tag.");

  }
}

_get_turret_index_for_tag(str_tag) {
  switch (str_tag) {
    case "tag_gunner1":
      return 1;
    case "tag_gunner2":
      return 2;
    case "tag_gunner3":
      return 3;
    case "tag_gunner4":
      return 4;
  }
}

_init_animations(ai_user, n_index) {
  if(isDefined(self.classname) && self.classname == "script_vehicle") {
  } else if(isDefined(ai_user) && ai_user.desired_anim_pose == "stand") {
    self setanimknoblimitedrestart( % saw_gunner_idle_mg);
    self setanimknoblimitedrestart( % saw_gunner_firing_mg_add);
  } else {
    self setanimknoblimitedrestart( % saw_gunner_lowwall_idle_mg);
    self setanimknoblimitedrestart( % saw_gunner_lowwall_firing_mg);
  }
}

_animate_idle(n_index) {
  if(isDefined(self.classname) && self.classname == "script_vehicle") {
  } else if(_user_check(n_index)) {
    self setanim( % additive_idle, 1, 0.1);
    self setanim( % additive_fire, 0, 0.1);
  }
}

_animate_fire(n_index) {
  if(isDefined(self.classname) && self.classname == "script_vehicle") {
  } else if(_user_check(n_index)) {
    self setanim( % additive_idle, 0, 0.1);
    self setanim( % additive_fire, 1, 0.1);
  }
}

_clear_animations(n_index) {
  if(isDefined(self.classname) && self.classname == "script_vehicle") {
  } else {
    self setanim( % additive_idle, 0, 0.1);
    self setanim( % additive_fire, 0, 0.1);
  }
}