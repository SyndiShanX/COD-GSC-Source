/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\turret_shared.gsc
***********************************************/

#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicleriders_shared;
#namespace turret;

function private autoexec __init__system__() {
  system::register(#"turret", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int");
  level._turrets = spawnStruct();
  registerbehaviorscriptfunctions();
}

function private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_2c6be6cd));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4da9c87ccb6a9163", &function_2c6be6cd);
  assert(isscriptfunctionptr(&function_90e78f70));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_38b92465454460ba", &function_90e78f70);
  assert(isscriptfunctionptr(&function_38388863));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_400342bceb3fa64e", &function_38388863);
  assert(isscriptfunctionptr(&function_3628f3da));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2eef1e8d94fa0609", &function_3628f3da);
}

function private function_2c6be6cd(entity) {
  return entity flag::get(#"turret_pilot");
}

function private function_90e78f70(entity) {
  return entity flag::get(#"hash_79f73bc0bf703a5d");
}

function private function_38388863(entity) {
  return isDefined(entity.var_2df45b5d);
}

function private function_3628f3da(entity) {
  entity.var_2df45b5d = undefined;
}

function private function_d72fcb0a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  if(isDefined(self.var_72f4d1b7)) {
    level.var_d7e2833c = self.var_72f4d1b7 > 1;
    modelindex = int(self.var_72f4d1b7 * modelindex);

    if(modelindex < 1) {
      modelindex = 1;
    }
  }

  return modelindex;
}

function get_weapon(n_index = 0) {
  if(!isalive(self)) {
    return level.weaponnone;
  }

  w_weapon = self seatgetweapon(n_index);
  return w_weapon;
}

function get_parent(n_index) {
  return _get_turret_data(n_index).e_parent;
}

function laser_death_watcher() {
  self notify(#"laser_death_thread_stop");
  self endon(#"laser_death_thread_stop");
  self waittill(#"death");

  if(isDefined(self)) {
    self laseroff();
  }
}

function enable_laser(b_enable, n_index) {
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

function emp_watcher(n_index) {
  self notify(#"emp_thread_stop");
  self endon(#"emp_thread_stop", #"death");

  while(true) {
    waitresult = self waittill(#"damage");

    if(waitresult.weapon.isemp) {
      if(is_true(self.emped)) {
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

function enable_emp(b_enable, n_index) {
  if(b_enable) {
    _get_turret_data(n_index).can_emp = 1;
    self thread emp_watcher(n_index);
    return;
  }

  _get_turret_data(n_index).can_emp = undefined;
  self notify(#"emp_thread_stop");
}

function set_team(str_team, n_index) {
  _get_turret_data(n_index).str_team = str_team;
  self.team = str_team;
}

function get_team(n_index) {
  str_team = undefined;
  s_turret = _get_turret_data(n_index);
  str_team = self.team;

  if(!isDefined(s_turret.str_team)) {
    s_turret.str_team = str_team;
  }

  return str_team;
}

function is_turret_enabled(n_index) {
  return _get_turret_data(n_index).is_enabled;
}

function does_need_user(n_index) {
  return is_true(_get_turret_data(n_index).b_needs_user);
}

function does_have_user(n_index) {
  return isalive(get_user(n_index));
}

function get_user(n_index) {
  return self getseatoccupant(n_index);
}

function _set_turret_needs_user(n_index, b_needs_user) {
  s_turret = _get_turret_data(n_index);
  s_turret.b_needs_user = b_needs_user;
}

function is_current_user(ai_user, n_index) {
  ai_current_user = get_user(n_index);
  return isalive(ai_current_user) && ai_user == ai_current_user;
}

function set_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_burst_fire_min = n_fire_min;
  s_turret.n_burst_fire_max = n_fire_max;
  s_turret.n_burst_wait_min = n_wait_min;
  s_turret.n_burst_wait_max = n_wait_max;
}

function set_torso_targetting(n_index, n_torso_targetting_offset = -12) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_torso_targetting_offset = n_torso_targetting_offset;
}

function set_target_leading(n_index, n_target_leading_factor = 0.1) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_target_leading_factor = n_target_leading_factor;
}

function set_on_target_angle(n_angle, n_index = 0) {
  self turretsetontargettolerance(n_index, n_angle);
}

function set_target(target, v_offset, n_index = 0, var_6bfa76e = 0, var_d55528ca = 0) {
  self endon(#"death");

  if(!isDefined(target)) {
    clear_target(n_index);
    return 0;
  }

  if(!isentity(target) && !isvec(target) || is_true(target.ignoreme)) {
    return 0;
  }

  s_turret = _get_turret_data(n_index);

  if(!isDefined(v_offset)) {
    v_offset = _get_default_target_offset(target, n_index);
  }

  s_turret.last_target = s_turret.target;
  s_turret.e_next_target = target;
  s_turret.target = target;
  s_turret.v_offset = v_offset;
  s_turret.var_f351ad56 = var_6bfa76e;
  s_turret.var_d55528ca = var_d55528ca;
  self turretsettarget(n_index, target, v_offset);
  return function_12269140(target, n_index);
}

function private _get_default_target_offset(e_target, n_index) {
  s_turret = _get_turret_data(n_index);

  if(s_turret.str_weapon_type == "bullet") {
    if(isDefined(e_target)) {
      if(isPlayer(e_target)) {
        z_offset = 0;
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

function get_target(n_index) {
  s_turret = _get_turret_data(n_index);
  return s_turret.target;
}

function is_target(target, n_index) {
  current_target = get_target(n_index);

  if(isDefined(current_target) && (isentity(target) && isentity(current_target) || isvec(target) && isvec(current_target))) {
    return (current_target == target);
  }

  return false;
}

function clear_target(n_index = 0) {
  s_turret = _get_turret_data(n_index);
  s_turret.e_next_target = undefined;
  s_turret.target = undefined;
  s_turret.var_50fbd548 = undefined;
  s_turret.var_d55528ca = 0;
  s_turret.var_f351ad56 = 0;
  self turretcleartarget(n_index);
}

function function_49c3b892(e_target, n_index = 0) {
  s_turret = _get_turret_data(n_index);
  s_turret.favoriteenemy = e_target;
}

function get_favorite_enemy(n_index = 0) {
  s_turret = _get_turret_data(n_index);
  return s_turret.favoriteenemy;
}

function function_41c79ce4(b_enable, n_index = 0) {
  s_turret = _get_turret_data(n_index);
  s_turret.perfectaim = b_enable;
}

function set_min_target_distance_squared(n_distance_squared, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_min_target_distance_squared = n_distance_squared;
}

function function_9c04d437(var_6a56e517, n_index = 0) {
  s_turret = _get_turret_data(n_index);
  s_turret flag::set("turret manual");

  if(is_true(var_6a56e517)) {
    self notify("turret manual" + _index(n_index));
  }
}

function function_21827343(n_index = 0) {
  s_turret = _get_turret_data(n_index);
  s_turret flag::clear("turret manual");
}

function function_3e5395(n_seconds, n_index = 0) {
  s_turret = _get_turret_data(n_index);
  s_turret.var_b52bbdba = n_seconds;
}

function function_30a9811a(n_scale, n_index = 0) {
  assert(isDefined(n_scale) && n_scale > 0, "<dev string:x38>");
  s_turret = _get_turret_data(n_index);
  s_turret.var_72f4d1b7 = n_scale;
}

function fire(n_index) {
  s_turret = _get_turret_data(n_index);
  assert(isDefined(n_index) && n_index >= 0, "<dev string:x83>");
  e_target = isentity(s_turret.target) ? s_turret.target : undefined;
  self.forcefire = is_true(s_turret.var_d55528ca);
  self.var_742d1a8f = is_true(s_turret.var_2890139c);

  if(n_index == 0) {
    self fireweapon(0, e_target);
  } else {
    ai_current_user = get_user(n_index);

    if(isDefined(ai_current_user) && is_true(ai_current_user.is_disabled)) {
      return;
    }

    if(isDefined(e_target)) {
      self turretsettarget(n_index, e_target, s_turret.v_offset);
    }

    self fireweapon(n_index, e_target, s_turret.v_offset, s_turret.e_parent);
  }

  s_turret.n_last_fire_time = gettime();
}

function fire_for_time(n_time, n_index = 0, var_7cd5e5c = "unused") {
  self endon(var_7cd5e5c, #"terminate_all_turrets_firing", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), "turret manual" + _index(n_index));
  var_17b7891d = "6de34da8e1cbdba" + _index(n_index);
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  s_turret = _get_turret_data(n_index);
  w_weapon = get_weapon(n_index);
  n_fire_time = w_weapon.firetime;
  n_shots = 0;
  var_23ec945b = floor(abs(n_time / n_fire_time));

  while(n_shots < var_23ec945b) {
    if(n_time > 0) {
      n_shots++;
    }

    self fire(n_index);
    wait n_fire_time;
  }
}

function stop(n_index, b_clear_target = 0) {
  s_turret = _get_turret_data(n_index);
  s_turret.e_next_target = undefined;
  s_turret.target = undefined;
  function_21827343(n_index);

  if(b_clear_target) {
    clear_target(n_index);
  }

  self notify("_stop_turret" + _index(n_index));
  function_14223170(n_index);
}

function get_in(ai_actor, n_index = 0) {
  if(isalive(ai_actor) && !is_true(ai_actor islinkedto(self))) {
    s_turret = _get_turret_data(n_index);
    self usevehicle(ai_actor, n_index);
    ai_actor flag::set(#"turret_pilot");

    if(is_true(s_turret.var_7394b9dc)) {
      ai_actor.allowpain = 0;
      ai_actor.blockingpain = 1;
    }

    if(!is_true(ai_actor islinkedto(self))) {
      ai_actor linkto(self);
      println("<dev string:xb6>" + n_index + "<dev string:xf8>" + self.model + "<dev string:x104>");
    }

    self enable(n_index, 1);
    ai_actor.s_turret = s_turret;
    ai_actor.var_72f4d1b7 = s_turret.var_72f4d1b7;
    ai_actor.var_41adb97 = undefined;
    aiutility::addaioverridedamagecallback(ai_actor, &function_d72fcb0a);
    self thread handle_rider_death(ai_actor, n_index);
    self thread function_2c718f9e(ai_actor, n_index);
    self thread function_738effc8(ai_actor, n_index);
  }
}

function private function_2c718f9e(ai_actor, n_index) {
  self endon(#"death", "turret_disabled" + _index(n_index));
  ai_actor endon(#"death");
  s_turret = _get_turret_data(n_index);

  while(true) {
    ai_actor waittill(#"pain");

    if(is_true(s_turret.var_7394b9dc) || is_true(s_turret.var_aa100948)) {
      continue;
    }

    s_turret.e_last_target = s_turret.target;
    s_turret.var_aa100948 = 1;
    var_d8c89de3 = 1.5;
    stop(n_index, 1);
    pause(-1, n_index);
    self turretsettargetangles(n_index, (0, 0, 0));
    waitframe(2);

    if(isDefined(s_turret.var_bf6d793d) && isDefined(s_turret.var_bf6d793d.var_81610bb0)) {
      for(i = 0; i < 10; i++) {
        if(isDefined(s_turret.var_bf6d793d.var_81610bb0[i])) {
          var_1e713ee7 = s_turret.var_bf6d793d.var_81610bb0[i].xanim;

          if(isDefined(var_1e713ee7)) {
            anim_time = ai_actor getanimtime(var_1e713ee7);

            if(anim_time > 0) {
              var_73a9738e = getanimlength(var_1e713ee7);
              var_d8c89de3 = (1 - anim_time) * var_73a9738e;
              break;
            }
          }
        }
      }
    }

    wait var_d8c89de3;
    s_turret.var_aa100948 = 0;
    unpause(n_index);
    set_target(s_turret.e_last_target);
  }
}

function private function_738effc8(ai_actor, n_index) {
  self endon(#"death");
  ai_actor endon(#"death");
  ai_actor waittill(#"goal_changed");

  if(getdvarint(#"hash_47a40f04e7c48117", 0)) {
    return;
  }

  self _drop_turret(n_index);
}

function get_out(ai_actor, n_index = 0) {
  if(ai_actor islinkedto(self)) {
    self usevehicle(ai_actor, n_index);

    if(isalive(ai_actor)) {
      ai_actor flag::clear(#"turret_pilot");
      ai_actor.s_turret = undefined;
      ai_actor.var_72f4d1b7 = undefined;
      ai_actor.blockingpain = 0;
      ai_actor.allowpain = 1;
      ai_actor.ignoreme = 0;
      aiutility::releaseclaimnode(ai_actor);
      aiutility::choosebestcovernodeasap(ai_actor);

      if(isDefined(ai_actor.aioverridedamage)) {
        aiutility::removeaioverridedamagecallback(ai_actor, &function_d72fcb0a);
      }

      var_3b228fdf = isDefined(ai_actor.node) && ai_actor.node.type == "Turret";
      var_3b228fdf |= isDefined(ai_actor.covernode) && ai_actor.covernode.type == "Turret";

      if(var_3b228fdf) {
        ai_actor.var_41adb97 = gettime() + 4000;
        ai_actor setgoal(ai_actor.origin, 0, ai_actor.goalradius);
      }
    }

    self disable(n_index);
    self notify(#"exit_turret");
    ai_actor notify(#"exit_turret");
  }
}

function handle_rider_death(ai_rider, n_index = 0) {
  self endon(#"death", "turret_disabled" + _index(n_index));
  ai_rider waittill(#"death");

  if(ai_rider flag::get(#"turret_pilot")) {
    ai_rider flag::clear(#"turret_pilot");
    ai_rider flag::set(#"hash_79f73bc0bf703a5d");
  }

  self get_out(ai_rider, n_index);
  self disable(n_index);
}

function function_1bc8c31c(target, v_offset, n_index = 0, b_just_once = 0) {
  assert(isDefined(target), "<dev string:x11a>");
  function_9c04d437(1, n_index);
  self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), #"terminate_all_turrets_firing", #"exit_vehicle", "turret manual" + _index(n_index));
  function_14223170(n_index);
  _shoot_turret_at_target(target, v_offset, n_index, b_just_once);
  function_21827343(n_index);
}

function function_aecc6bed(var_502298b8, n_shots, n_index = 0, var_c3e16ce = undefined, var_702f0a7e = undefined) {
  assert(isarray(var_502298b8), "<dev string:x14b>");
  assert(n_shots > 0, "<dev string:x180>");
  var_17b7891d = "1a325e0f6397cbea" + _index(n_index);
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  function_9c04d437(1, n_index);
  self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), #"terminate_all_turrets_firing", #"exit_vehicle", "turret manual" + _index(n_index));
  w_weapon = get_weapon(n_index);
  n_fire_time = isDefined(var_c3e16ce) ? var_c3e16ce : w_weapon.firetime;
  function_14223170(n_index);

  foreach(point in var_502298b8) {
    v_origin = isvec(point) ? point : point.origin;

    if(!set_target(v_origin, undefined, n_index)) {
      continue;
    }

    function_259e1449(n_index);

    for(shots = 0; shots < n_shots; shots++) {
      fire(n_index);
      wait n_fire_time;
    }

    if(isDefined(var_702f0a7e)) {
      wait var_702f0a7e;
    }
  }

  function_21827343(n_index);
}

function function_d1ba6eb6(v_start, v_end, n_index = 0) {
  assert(isDefined(v_start) && isDefined(v_end), "<dev string:x1b8>");
  var_17b7891d = "286c7a50de00885f" + _index(n_index);
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  function_9c04d437(1, n_index);
  self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), #"terminate_all_turrets_firing", #"exit_vehicle", "turret manual" + _index(n_index));
  w_weapon = get_weapon(n_index);
  n_fire_time = w_weapon.firetime;
  function_14223170(n_index);

  if(set_target(v_start, undefined, n_index)) {
    function_259e1449(n_index);
    set_target(v_end, undefined, n_index);
    fire_for_time(-1, n_index, function_a8d258ca(n_index));
  }

  function_21827343(n_index);
}

function private _shoot_turret_at_target(target, v_offset, n_index, b_just_once) {
  if(isentity(target)) {
    target endon(#"death");
  }

  self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), #"terminate_all_turrets_firing", #"exit_vehicle", "turret manual" + _index(n_index));

  if(!isDefined(b_just_once)) {
    b_just_once = 0;
  }

  s_turret = _get_turret_data(n_index);

  if(s_turret.n_burst_time < s_turret.n_burst_fire_time) {
    return;
  } else {
    n_time_since_last_shot = float(gettime() - s_turret.n_last_fire_time) / 1000;

    if(n_time_since_last_shot < s_turret.n_burst_wait) {
      wait s_turret.n_burst_wait - n_time_since_last_shot;
    }
  }

  var_17b7891d = "19fef14e1a613d08" + _index(n_index);
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  if(is_true(s_turret.var_cd8600bd) && !can_hit_target(target, n_index)) {
    return;
  }

  set_target(target, v_offset, n_index, s_turret.var_f351ad56, 0);

  if(!isDefined(self.aim_only_no_shooting)) {
    function_259e1449(n_index);

    if(b_just_once) {
      fire(n_index);
      return;
    }

    var_e7a43ab0 = !is_true(s_turret.var_cd8600bd) || can_hit_target(target, n_index);

    if(var_e7a43ab0) {
      self thread _burst_fire(n_index);
    }

    while(s_turret.n_burst_time < s_turret.n_burst_fire_time) {
      while(can_hit_target(target, n_index)) {
        set_target(target, v_offset, n_index, s_turret.var_f351ad56, 0);
        s_turret.var_50fbd548 = target.origin;
        wait s_turret.var_b52bbdba;
      }

      if(isDefined(s_turret.var_50fbd548)) {
        set_target(s_turret.var_50fbd548, v_offset, n_index, 0, 1);
      } else {
        clear_target(n_index);
        angles = self function_bc2f1cb8(n_index);
        self turretsettargetangles(n_index, angles);
      }

      wait s_turret.var_b52bbdba;
    }
  }
}

function private function_a8d258ca(n_index) {
  if(!isDefined(n_index) || n_index == 0) {
    return "turret_on_target";
  }

  return "gunner_turret_on_target";
}

function function_259e1449(n_index) {
  wait isDefined(self.waittill_turret_on_target_delay) ? self.waittill_turret_on_target_delay : float(function_60d95f53()) / 1000;
  self waittill(function_a8d258ca(n_index));
}

function function_38841344(e_target, n_index) {
  do {
    function_259e1449(n_index);
  }
  while(isDefined(e_target) && !can_hit_target(e_target, n_index));
}

function enable(n_index, b_user_required, v_offset) {
  if(isalive(self) && !is_turret_enabled(n_index)) {
    _get_turret_data(n_index).is_enabled = 1;
    _set_turret_needs_user(n_index, is_true(b_user_required));
    self thread _turret_think(n_index, v_offset);
    self notify("turret_enabled" + _index(n_index));
  }
}

function enable_auto_use(b_enable = 1) {
  self.script_auto_use = b_enable;
}

function disable_ai_getoff(n_index, b_disable = 1) {
  _get_turret_data(n_index).disable_ai_getoff = b_disable;
}

function disable(n_index) {
  if(is_turret_enabled(n_index)) {
    s_turret = _get_turret_data(n_index);
    s_turret.is_enabled = 0;
    s_turret.var_aa100948 = 0;
    function_14223170(n_index);
    clear_target(n_index);
    unpause(n_index);
    self turretsettargetangles(n_index, (0, 0, 0));
    self notify("turret_disabled" + _index(n_index));
  }
}

function pause(time, n_index) {
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

function unpause(n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.pause = undefined;
  self notify("_turret_unpaused" + _index(n_index));
}

function function_12269140(target, n_index = 0) {
  s_turret = _get_turret_data(n_index);
  v_pos = isDefined(target.origin) ? target.origin : target;

  if(!isDefined(s_turret.var_bf6d793d)) {
    return true;
  }

  var_8ee48240 = cos(s_turret.var_bf6d793d.aimyawanglel);
  v_angles = isDefined(s_turret.node) ? s_turret.node.angles : self.angles;
  v_to_enemy = vectornormalize(v_pos - self.origin);
  dot = vectordot(v_to_enemy, anglesToForward(v_angles));
  return dot >= var_8ee48240;
}

function _turret_think(n_index, v_offset) {
  turret_think_time = max(1.5, get_weapon(n_index).firetime);
  no_target_start_time = 0;
  self endon(#"death", "turret_disabled" + _index(n_index));
  var_17b7891d = "39918986e1a7d45f" + _index(n_index);
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  self thread _debug_turret_think(n_index);

  self thread _turret_health_monitor(n_index);
  s_turret = _get_turret_data(n_index);

  if(isDefined(s_turret.has_laser)) {
    self laseron();
  }

  while(true) {
    s_turret flag::wait_till_clear("turret manual");
    n_time_now = gettime();

    if(self _check_for_paused(n_index) || is_true(self.emped) || is_true(self.stunned)) {
      self waittilltimeout(turret_think_time, "_turret_unpaused" + _index(n_index));
      continue;
    }

    target = s_turret.target;

    if(!isDefined(target) || isentity(target) && !isalive(target)) {
      stop(n_index);
    }

    if(is_true(s_turret.var_73446dab)) {
      self thread function_1358b930(n_index);
    }

    e_original_next_target = s_turret.e_next_target;

    if(!is_true(s_turret.var_f351ad56) || isactor(s_turret.target) && !isalive(s_turret.target)) {
      s_turret.e_next_target = _get_best_target(n_index);
    }

    if(isDefined(s_turret.e_next_target)) {
      no_target_start_time = 0;

      if(_user_check(n_index)) {
        self thread _shoot_turret_at_target(s_turret.e_next_target, v_offset, n_index);

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

      if(!is_true(s_turret.disable_ai_getoff)) {
        bwasplayertarget = isDefined(s_turret.e_last_target) && isPlayer(s_turret.e_last_target) && isalive(s_turret.e_last_target);

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

    wait turret_think_time;
  }
}

function _turret_health_monitor(n_index) {
  self endon(#"death");
  waitframe(1);
  _turret_health_monitor_loop(n_index);
  self disable(n_index);
}

function _turret_health_monitor_loop(n_index) {
  self endon(#"death", "turret_disabled" + _index(n_index));

  while(true) {
    waitresult = self waittill(#"broken");

    if(waitresult.type === "turret_destroyed_" + n_index) {
      return;
    }
  }
}

function function_1358b930(n_index) {
  self endon(#"death", "turret_disabled" + _index(n_index), "_turret_think" + _index(n_index), #"exit_vehicle");
  var_17b7891d = "7c695ce9fd51af1d" + _index(n_index);
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  ai_user = self get_user(n_index);

  if(!isDefined(ai_user)) {
    return;
  }

  if(getdvarint(#"hash_47a40f04e7c48117", 0)) {
    return;
  }

  s_turret = _get_turret_data(n_index);
  var_8bcad4e7 = 0;
  var_f72902ad = undefined;
  var_324bed9c = 0.173648;

  if(isDefined(s_turret.var_bf6d793d)) {
    var_324bed9c = cos(s_turret.var_bf6d793d.aimyawanglel);
  }

  while(!isDefined(var_f72902ad)) {
    time = gettime();

    if(time - var_8bcad4e7 > 500) {
      var_8bcad4e7 = time;
      players = getplayers();

      foreach(player in players) {
        if(!util::function_fbce7263(self.team, player.team)) {
          continue;
        }

        if(abs(ai_user.origin[2] - player.origin[2]) <= 60 && distance2dsquared(ai_user.origin, player.origin) <= sqr(300)) {
          var_f72902ad = player;
          break;
        }

        if(ai_user cansee(player) || is_target(player, n_index)) {
          toenemy = vectornormalize(player.origin - ai_user.origin);
          dot = vectordot(toenemy, anglesToForward(s_turret.node.angles));

          if(dot < var_324bed9c) {
            var_f72902ad = player;
            break;
          }
        }
      }
    }

    waitframe(1);
  }

  ai_user = get_user(n_index);
  ai_user.var_2df45b5d = var_f72902ad;
  self thread _drop_turret(n_index, 0);
}

function _listen_for_damage_on_actor(ai_user, n_index) {
  self endon(#"death");
  ai_user endon(#"death");
  self endon("turret_disabled" + _index(n_index), "_turret_think" + _index(n_index), #"exit_vehicle");

  while(true) {
    waitresult = ai_user waittill(#"damage");
    s_turret = _get_turret_data(n_index);

    if(isDefined(s_turret)) {
      if(!isDefined(s_turret.e_next_target) && !isDefined(s_turret.target)) {
        s_turret.e_last_target = waitresult.attacker;
      }
    }
  }
}

function _waittill_user_change(n_index) {
  ai_user = self getseatoccupant(n_index);

  if(isalive(ai_user)) {
    if(isactor(ai_user)) {
      ai_user endon(#"death");
    } else if(util::function_8e89351(ai_user)) {
      self notify("turret_disabled" + _index(n_index));
    }
  }

  self waittill(#"exit_vehicle", #"enter_vehicle");
}

function _check_for_paused(n_index) {
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
    } else {
      return true;
    }

    waitframe(1);
  }

  return false;
}

function _drop_turret(n_index, bexitifautomatedonly) {
  ai_user = get_user(n_index);

  if(isalive(ai_user) && !isbot(ai_user) && !isPlayer(ai_user) && (is_true(ai_user.turret_auto_use) || !is_true(bexitifautomatedonly))) {
    if(!isDefined(ai_user.vehicle) && ai_user islinkedto(self)) {
      self get_out(ai_user, n_index);
      return;
    }

    vehicle::get_out(self, ai_user, "gunner1");
  }
}

function does_have_target(n_index) {
  return isDefined(_get_turret_data(n_index).e_next_target);
}

function _user_check(n_index) {
  s_turret = _get_turret_data(n_index);

  if(does_need_user(n_index)) {
    b_has_user = does_have_user(n_index);
    return b_has_user;
  }

  return 1;
}

function function_2a4a311(n_index) {
  var_17b7891d = "907c70077bef476" + _index(n_index);
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  self endon(#"death");
  s_turret = _get_turret_data(n_index);

  if(!isDefined(s_turret.node)) {
    return;
  }

  var_f449d788 = sqr(s_turret.var_43ce86ed);

  while(true) {
    s_notify = self waittill(#"hash_4ecf2bd2fb1d75d9");
    ai_actor = s_notify.entity;

    if(isalive(ai_actor) && !ai_actor flag::get(#"turret_pilot")) {
      if(ai_actor.isarriving) {
        while(isalive(ai_actor) && ai_actor.isarriving) {
          waitframe(1);
        }

        get_in(ai_actor, n_index);
        continue;
      }

      if(distance2dsquared(ai_actor.origin, s_turret.node.origin) <= var_f449d788) {
        if(isDefined(ai_actor.var_41adb97) && gettime() < ai_actor.var_41adb97) {
          continue;
        }

        get_in(ai_actor, n_index);
      }
    }
  }
}

function _debug_turret_think(n_index) {
  self endon(#"death", "<dev string:x1ef>" + _index(n_index), "<dev string:x200>" + _index(n_index));
  s_turret = _get_turret_data(n_index);
  var_34c31abc = (1, 1, 0);
  n_spacing = (0, 0, -7);

  while(true) {
    if(!getdvarint(#"g_debugturrets", 0)) {
      wait 0.2;
      continue;
    }

    var_83570f5f = [];
    var_83570f5f[var_83570f5f.size] = "<dev string:x213>" + self getentnum();
    str_target = "<dev string:x227>";
    target = s_turret.target;

    if(isDefined(target)) {
      if(isvec(target)) {
        str_target += "<dev string:x234>" + target;
      } else if(isactor(target)) {
        str_target += "<dev string:x23c>" + target getentnum();
      } else if(isPlayer(target)) {
        str_target += "<dev string:x243>" + target getentnum();
      } else if(isvehicle(target)) {
        str_target += "<dev string:x24e>" + target getentnum();
      } else if(isDefined(target.targetname) && target.targetname == "<dev string:x25a>") {
        str_target += "<dev string:x25a>";
      } else if(isDefined(target.classname)) {
        str_target += target.classname;
      }
    } else {
      str_target += "<dev string:x263>";
    }

    var_83570f5f[var_83570f5f.size] = str_target;
    var_3be47a2d = "<dev string:x26b>";

    if(isDefined(s_turret.pause)) {
      var_3be47a2d += "<dev string:x277>";
    } else if(s_turret.n_burst_time < s_turret.n_burst_fire_time) {
      var_3be47a2d += "<dev string:x281>" + s_turret.n_burst_fire_time - s_turret.n_burst_time;
    } else {
      var_3be47a2d += "<dev string:x28a>";
    }

    var_83570f5f[var_83570f5f.size] = var_3be47a2d;
    var_c88d0be9 = "<dev string:x296>";

    if(isDefined(s_turret.var_50fbd548) && isvec(s_turret.target) && s_turret.target == s_turret.var_50fbd548) {
      var_c88d0be9 += "<dev string:x2a5>";
    } else if(s_turret flag::get(#"turret manual")) {
      var_c88d0be9 += "<dev string:x2bb>";
    } else {
      var_c88d0be9 += "<dev string:x2ca>";
    }

    var_83570f5f[var_83570f5f.size] = var_c88d0be9;
    var_83570f5f[var_83570f5f.size] = "<dev string:x2db>" + (isDefined(s_turret.favoriteenemy) ? "<dev string:x2f0>" + s_turret.favoriteenemy getentnum() : "<dev string:x263>");
    var_83570f5f[var_83570f5f.size] = "<dev string:x2fb>" + is_true(s_turret.var_cd8600bd);
    var_83570f5f[var_83570f5f.size] = "<dev string:x314>" + is_true(s_turret.b_ignore_line_of_sight);
    var_83570f5f[var_83570f5f.size] = "<dev string:x325>" + is_true(s_turret.var_f351ad56);
    var_83570f5f[var_83570f5f.size] = "<dev string:x339>" + is_true(s_turret.perfectaim);
    var_83570f5f[var_83570f5f.size] = "<dev string:x34b>" + is_true(s_turret.var_d55528ca);
    var_83570f5f[var_83570f5f.size] = "<dev string:x35c>" + is_true(s_turret.var_2890139c);

    if(s_turret.n_last_fire_time == gettime()) {
      var_83570f5f[var_83570f5f.size] = "<dev string:x378>";
    }

    for(i = 0; i < var_83570f5f.size; i++) {
      record3dtext(var_83570f5f[i], self.origin + n_spacing * i, var_34c31abc, "<dev string:x38c>", self);
    }

    if(isDefined(s_turret.target)) {
      v_end = isvec(s_turret.target) ? s_turret.target : s_turret.target.origin;
      v_start = isDefined(self gettagorigin(s_turret.str_tag_flash)) ? self gettagorigin(s_turret.str_tag_flash) : self.origin;
      v_color = function_12269140(v_end, n_index) ? (0, 1, 0) : (1, 0, 0);
      line(v_start, v_end, v_color);
    }

    waitframe(1);
  }
}

function _get_turret_data(n_index = 0) {
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

function has_turret(n_index) {
  if(isDefined(self.a_turrets) && isDefined(self.a_turrets[n_index])) {
    return true;
  }

  return false;
}

function _update_turret_arcs(n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.rightarc = s_turret.w_weapon.rightarc;
  s_turret.leftarc = s_turret.w_weapon.leftarc;
  s_turret.toparc = s_turret.w_weapon.toparc;
  s_turret.bottomarc = s_turret.w_weapon.bottomarc;
}

function _init_turret(n_index = 0) {
  self endon(#"death");
  w_weapon = get_weapon(n_index);

  if(w_weapon.name == # "none") {
    assertmsg("<dev string:x396>");
    return;
  }

  util::waittill_asset_loaded("xmodel", self.model);
  s_turret = _init_vehicle_turret(n_index);
  s_turret.w_weapon = w_weapon;
  _update_turret_arcs(n_index);
  s_turret.is_enabled = 0;
  s_turret.target = undefined;
  s_turret.e_parent = self;
  s_turret.var_73446dab = 1;
  s_turret.var_cd8600bd = 0;
  s_turret.var_30e97b22 = 0;
  s_turret.var_d55528ca = 0;
  s_turret.var_7394b9dc = 0;
  s_turret.b_ignore_line_of_sight = 0;
  s_turret.var_2890139c = 0;
  s_turret.var_aa100948 = 0;
  s_turret.var_f351ad56 = 0;
  s_turret.v_offset = (0, 0, 0);
  s_turret.var_50fbd548 = undefined;
  s_turret.n_burst_fire_time = 0;
  s_turret.n_burst_time = 0;
  s_turret.n_burst_wait = 0;
  s_turret.n_index = n_index;
  s_turret.n_last_fire_time = 0;
  s_turret.var_43ce86ed = 36;
  s_turret.var_b52bbdba = 1;
  s_turret.var_72f4d1b7 = 0.5;
  s_turret.str_weapon_type = w_weapon.type;
  s_turret.str_guidance_type = w_weapon.guidedmissiletype;

  if(isDefined(self.target)) {
    s_turret.node = getnode(self.target, "targetname");
  }

  if(isDefined(w_weapon.aiturretanims)) {
    s_turret.var_bf6d793d = getscriptbundle(w_weapon.aiturretanims);
  }

  set_on_target_angle(1, n_index);
  s_turret flag::init("turret manual");
  self thread function_2a4a311(n_index);
  return s_turret;
}

function _init_vehicle_turret(n_index) {
  assert(isDefined(n_index) && n_index >= 0, "<dev string:x3c3>");
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

function function_14223170(n_index = 0) {
  s_turret = _get_turret_data(n_index);
  s_turret.n_burst_time = 0;
  s_turret.n_burst_fire_time = 0;
  s_turret.n_burst_wait = 0;
}

function _burst_fire(n_index) {
  self endon(#"drone_death", #"death", "_stop_turret" + _index(n_index), "turret_disabled" + _index(n_index), #"terminate_all_turrets_firing", #"exit_vehicle", "turret manual" + _index(n_index));
  s_turret = _get_turret_data(n_index);
  s_turret.n_burst_time = 0;
  s_turret.n_burst_fire_time = _get_burst_fire_time(n_index);
  s_turret.n_burst_wait = _get_burst_wait_time(n_index);
  w_weapon = get_weapon(n_index);
  var_a2524721 = 0;
  n_fire_time = w_weapon.firetime < 0 ? 0.016 : w_weapon.firetime;
  n_shots = ceil(s_turret.n_burst_fire_time / n_fire_time);

  for(i = 0; i < n_shots; i++) {
    s_turret.n_burst_time += n_fire_time;
    var_a2524721 = s_turret.n_burst_time >= s_turret.n_burst_fire_time;
    fire(n_index);
    wait n_fire_time;
  }

  if(var_a2524721) {
    wait s_turret.n_burst_wait;
  }
}

function _get_burst_fire_time(n_index) {
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

function _get_burst_wait_time(n_index) {
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

function _index(n_index) {
  return isDefined(n_index) ? "" + n_index : "";
}

function _get_best_target(n_index) {
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

  s_turret = _get_turret_data(n_index);

  if(is_true(s_turret.var_30e97b22) && isDefined(self.enemy)) {
    e_best_target = self.enemy;
  }

  if(issentient(self)) {
    self.favoriteenemy = undefined;
    self.perfectaim = is_true(s_turret.perfectaim);

    if(isDefined(s_turret.favoriteenemy) && issentient(s_turret.favoriteenemy)) {
      self.favoriteenemy = s_turret.favoriteenemy;
      e_best_target = s_turret.favoriteenemy;
    }
  }

  return e_best_target;
}

function can_hit_target(e_target, n_index) {
  s_turret = _get_turret_data(n_index);
  v_offset = _get_default_target_offset(e_target, n_index);
  b_current_target = is_target(e_target, n_index);

  if(isDefined(e_target) && is_true(e_target.ignoreme)) {
    return 0;
  }

  b_trace_passed = 1;

  if(!s_turret.b_ignore_line_of_sight) {
    if(issentient(e_target) && (!isDefined(v_offset) || v_offset === (0, 0, 0))) {
      v_offset = e_target geteyeapprox() - e_target.origin;
    }

    b_trace_passed = trace_test(e_target, v_offset - (0, 0, isDefined(s_turret.n_torso_targetting_offset) ? s_turret.n_torso_targetting_offset : isvehicle(e_target) ? 0 : 0), n_index);
  }

  if(b_current_target && !b_trace_passed && !isDefined(s_turret.n_time_lose_sight)) {
    s_turret.n_time_lose_sight = gettime();
  }

  return b_trace_passed;
}

function trace_test(e_target, v_offset = (0, 0, 0), n_index) {
  if(isDefined(self.good_old_style_turret_tracing)) {
    s_turret = _get_turret_data(n_index);
    v_start_org = self gettagorigin(s_turret.str_tag_pivot);

    if(e_target sightconetrace(v_start_org, self) > 0.2) {
      v_target = e_target.origin + v_offset;
      v_start_org += vectornormalize(v_target - v_start_org) * 50;
      a_trace = bulletTrace(v_start_org, v_target, 1, s_turret.e_trace_ignore, 0, 1);

      if(a_trace[# "fraction"] > 0.6) {
        return true;
      }
    }

    return false;
  }

  s_turret = _get_turret_data(n_index);
  v_start_org = self gettagorigin(s_turret.str_tag_pivot);
  v_target = (isvec(e_target) ? e_target : e_target.origin) + v_offset;

  if((sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) && isPlayer(e_target)) {
    v_target = e_target getshootatpos();
  }

  if(distancesquared(v_start_org, v_target) < 10000) {
    return true;
  }

  v_dir_to_target = vectornormalize(v_target - v_start_org);
  v_start_org += v_dir_to_target * 50;

  if(sighttracepassed(v_start_org, v_target, 0, self, e_target)) {
    return true;
  }

  return false;
}

function function_3a7e640f(b_ignore, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.var_7394b9dc = b_ignore;
}

function set_ignore_line_of_sight(b_ignore, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.b_ignore_line_of_sight = b_ignore;
}

function function_8bbe7822(b_ignore, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.var_2890139c = b_ignore;
}

function function_bb42e3e2(var_7994b8bf, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.var_30e97b22 = var_7994b8bf;
}

function function_f5e3e1de(b_enabled, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.var_cd8600bd = b_enabled;
}

function function_69546b4e(b_allow, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.var_73446dab = b_allow;
}

function set_occupy_no_target_time(time, n_index) {
  s_turret = _get_turret_data(n_index);
  s_turret.occupy_no_target_time = time;
}

function toggle_lensflare(bool) {
  self clientfield::set("toggle_lensflare", bool);
}

function track_lens_flare() {
  self endon(#"death");
  self notify(#"disable_lens_flare");
  self endon(#"disable_lens_flare");

  while(true) {
    e_target = self turretgettarget(0);

    if(self.turretontarget && isDefined(e_target) && isPlayer(e_target)) {
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

function _get_gunner_tag_for_turret_index(n_index) {
  switch (n_index) {
    case 0:
      return "tag_driver";
    case 1:
      return "tag_gunner1";
    case 2:
      return "tag_gunner2";
    case 3:
      return "tag_gunner3";
    case 4:
      return "tag_gunner4";
    default:
      assertmsg("<dev string:x3fc>");
      break;
  }
}