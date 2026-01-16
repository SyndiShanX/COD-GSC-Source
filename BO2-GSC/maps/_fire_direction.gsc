/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_fire_direction.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_quadrotor;
#include maps\_vehicle;
#include maps\_fire_direction;

common_precache() {
  precachestring(&"SCRIPT_FIRE_DIRECTION_CONFIRM");
  precachestring(&"hud_update_visor_text");
}

precache() {
  level.str_fire_direction_weapon = "quadrotor_glove_sp";
  precacheitem("quadrotor_glove_sp");
  common_precache();
  init_fire_direction_vars();

  if(!isDefined(level._fire_direction.a_weapons["quadrotor_glove_sp"])) {
    s_data = spawnstruct();
    s_data.a_shooters = [];
    s_data.fire_func = ::quadrotors_find_player_target;
    s_data.valid_target_func = ::_is_target_area_valid;
    s_data.time_last_used = 0;
    s_data.str_hint = & "SCRIPT_FIRE_DIRECTION";
    s_data.notify_grid_on = "grid_shader_on";
    s_data.notify_grid_off = "grid_shader_off";
    level._fire_direction.a_weapons["quadrotor_glove_sp"] = s_data;
  }

  precachestring(level._fire_direction.a_weapons["quadrotor_glove_sp"].str_hint);
}

claw_precache() {
  level.str_fire_direction_weapon = "claw_glove_sp";
  precacheitem("claw_glove_sp");
  common_precache();
  init_fire_direction_vars();

  if(!isDefined(level._fire_direction.a_weapons["claw_glove_sp"])) {
    s_data = spawnstruct();
    s_data.a_shooters = [];
    s_data.fire_func = undefined;
    s_data.valid_target_func = ::_is_target_area_valid;
    s_data.time_last_used = 0;
    s_data.str_hint = & "SCRIPT_FIRE_DIRECTION_CLAW";
    s_data.notify_grid_on = "grid_shader_on";
    s_data.notify_grid_off = "grid_shader_off";
    level._fire_direction.a_weapons["claw_glove_sp"] = s_data;
  }

  precachestring(level._fire_direction.a_weapons["claw_glove_sp"].str_hint);
}

rod_precache() {
  precacheitem("god_rod_glove_sp");
  precacheitem("god_rod_sp");
  level._effect["rod_impact"] = loadfx("maps/haiti/fx_haiti_godrod_wave");
  init_fire_direction_vars();

  if(!isDefined(level._fire_direction.a_weapons["god_rod_glove_sp"])) {
    s_data = spawnstruct();
    s_data.a_shooters = [];
    s_data.fire_func = ::_rod_fire;
    s_data.valid_target_func = ::_rod_is_target_area_valid;
    s_data.time_last_used = 0;
    s_data.a_e_rod_victims = [];
    s_data.notify_grid_on = "grid_shader_on_god_rod";
    s_data.notify_grid_off = "grid_shader_off_god_rod";

    if(isDefined(level.wiiu))
      s_data.str_hint = & "SCRIPT_GOD_ROD_WIIU";
    else
      s_data.str_hint = & "SCRIPT_GOD_ROD";

    level._fire_direction.a_weapons["god_rod_glove_sp"] = s_data;
  }

  precachestring(level._fire_direction.a_weapons["god_rod_glove_sp"].str_hint);
}

init_fire_direction_vars() {
  if(!isDefined(level._fire_direction)) {
    level._fire_direction = spawnstruct();
    level._fire_direction.active = 0;
    level._fire_direction.hint_active = 0;
    level._fire_direction.a_weapons = [];
    flag_init("_fire_direction_kill");
    flag_init("fire_direction_shader_on");
    flag_init("fire_direction_target_confirmed");
    flag_init("fire_direction_disabled");
  }
}

get_default_fire_direction_weapon() {
  a_str_keys = getarraykeys(level._fire_direction.a_weapons);
  return a_str_keys[0];
}

init_fire_direction(str_weapon) {
  assert(isplayer(self), "fire_direction feature can only be enabled on players!");

  if(!isDefined(str_weapon))
    str_weapon = get_default_fire_direction_weapon();

  switch (str_weapon) {
    case "claw_glove_sp":
    case "quadrotor_glove_sp":
      self setactionslot(1, "weapon", str_weapon);
      break;
    case "god_rod_glove_sp":
      self giveweapon(str_weapon);
      self setactionslot(4, "weapon", str_weapon);
      break;
  }

  if(!isDefined(level._fire_direction.m_aimpoint)) {
    level._fire_direction.m_aimpoint = spawn("script_model", (0, 0, 0));
    level._fire_direction.m_aimpoint setmodel("tag_origin");
    level._fire_direction.m_aimpoint setclientflag(10);
    self thread _handle_shader();
  }

  if(!level._fire_direction.active) {
    level._fire_direction.active = 1;
    self thread _switch_to_weapon();
  }

  self thread _hint_text(str_weapon);
}

add_fire_direction_shooter(e_shooter, str_weapon) {
  assert(isDefined(e_shooter), "e_shooter is a required parameter for add_fire_direction_shooter function");

  if(!isDefined(str_weapon))
    str_weapon = get_default_fire_direction_weapon();

  level.player giveweapon(str_weapon);
  weapon_info = level._fire_direction.a_weapons[str_weapon];

  if(weapon_info.a_shooters.size > 0)
    weapon_info.a_shooters = array_removedead(weapon_info.a_shooters);

  weapon_info.a_shooters[weapon_info.a_shooters.size] = e_shooter;
  e_shooter thread _fire_direction_shooter_death(str_weapon);
}

_fire_direction_shooter_death(str_weapon) {
  self waittill("death");
  a_shooters = get_fire_direction_shooters(str_weapon);

  if(a_shooters.size == 0)
    level.player thread _take_weapon(str_weapon, 1);
}

get_fire_direction_shooters(str_weapon) {
  if(!isDefined(str_weapon))
    str_weapon = get_default_fire_direction_weapon();

  if(isDefined(level._fire_direction.a_weapons) && isDefined(level._fire_direction.a_weapons[str_weapon])) {
    weapon_info = level._fire_direction.a_weapons[str_weapon];

    if(weapon_info.a_shooters.size > 0)
      weapon_info.a_shooters = array_removedead(weapon_info.a_shooters);

    return weapon_info.a_shooters;
  }

  return [];
}

add_fire_direction_func(fire_direction_func, str_weapon) {
  assert(isDefined(level._fire_direction), "fire_direction is not set up. Run maps_fire_direction::init before add_fire_direction_func!");

  if(!isDefined(str_weapon))
    str_weapon = get_default_fire_direction_weapon();

  assert(isDefined(level._fire_direction.a_weapons[str_weapon]), "fire_direction is not set up for this weapon! Make sure to use the correct precache call");
  level._fire_direction.a_weapons[str_weapon].fire_func = fire_direction_func;
}

_fire_direction_enable(b_shouldhint) {
  if(!isDefined(b_shouldhint))
    b_shouldhint = 0;

  assert(isplayer(self), "_fire_direction_enable can only be called on players!");
  a_str_weapon_keys = getarraykeys(level._fire_direction.a_weapons);

  foreach(str_weapon in a_str_weapon_keys) {
    self giveweapon(str_weapon);

    if(flag("fire_direction_disabled"))
      flag_clear("fire_direction_disabled");
  }

  if(b_shouldhint == 1)
    self thread _hint_text(str_weapon);
}

_fire_direction_disable() {
  assert(isplayer(self), "_fire_direction_disable can only be called on players!");
  flag_set("fire_direction_disabled");

  if(level._fire_direction.hint_active)
    screen_message_delete();

  a_str_weapon_keys = getarraykeys(level._fire_direction.a_weapons);

  foreach(str_weapon in a_str_weapon_keys)
  self takeweapon(str_weapon);

  level notify("fire_direction_stop_hint");
}

_fire_direction_remove_hint() {
  if(level._fire_direction.hint_active)
    screen_message_delete();

  level notify("fire_direction_stop_hint");
}

is_fire_direction_active() {
  return isDefined(level._fire_direction) && level._fire_direction.active;
}

_fire_direction_kill() {
  assert(isplayer(self), "_fire_direction_kill can only be called on players!");
  flag_set("fire_direction_disabled");

  if(maps\_fire_direction::is_fire_direction_active()) {
    flag_clear("fire_direction_shader_on");

    if(isDefined(level._fire_direction.a_weapons["god_rod_glove_sp"]))
      screen_message_create(&"SCRIPT_GOD_ROD_OFFLINE", undefined, undefined, undefined, 3);

    a_keys = getarraykeys(level._fire_direction.a_weapons);

    foreach(key in a_keys)
    clientnotify(level._fire_direction.a_weapons[key].notify_grid_off);

    self switchtoweapon(level.str_weapon_last);
    level.player _fire_direction_remove_weapons();
    _fire_direction_cleanup();
    level._fire_direction.active = 0;
  }
}

_fire_direction_cleanup() {
  screen_message_delete();
  flag_delete("_fire_direction_kill");
  flag_delete("fire_direction_disabled");
  flag_delete("fire_direction_shader_on");
  flag_delete("fire_direction_target_confirmed");

  if(isDefined(level._fire_direction.m_aimpoint))
    level._fire_direction.m_aimpoint delete();

  a_str_keys = getarraykeys(level._fire_direction.a_weapons);

  foreach(str_key in a_str_keys)
  level._fire_direction.a_weapons[str_key] = undefined;

  level._fire_direction.a_weapons = undefined;
  level._fire_direction.current_weapon = undefined;
}

_fire_direction_remove_weapons() {
  assert(isplayer(self), "_fire_direction_kill can only be called on players!");
  level notify("_fire_direction_kill");
  a_str_weapon_keys = getarraykeys(level._fire_direction.a_weapons);

  foreach(str_weapon in a_str_weapon_keys)
  self takeweapon(str_weapon);
}

is_fire_direction_weapon(str_weapon) {
  a_str_weapon_keys = getarraykeys(level._fire_direction.a_weapons);

  foreach(str_weapon_key in a_str_weapon_keys) {
    if(str_weapon == str_weapon_key)
      return true;
  }

  return false;
}

_switch_to_weapon() {
  level endon("_fire_direction_kill");
  level.str_weapon_last = self getcurrentweapon();
  self thread _montitor_loadout();

  while(isalive(self)) {
    for(str_weapon_current = self getcurrentweapon(); str_weapon_current == "none"; str_weapon_current = self getcurrentweapon())
      wait 1;

    if(is_fire_direction_weapon(str_weapon_current)) {
      level._fire_direction.current_weapon = str_weapon_current;
      flag_set("fire_direction_shader_on");
      v_aim_pos = _get_aim_position();

      if(isDefined(v_aim_pos))
        level._fire_direction.m_aimpoint.origin = v_aim_pos;

      b_pressed_attack = self attackbuttonpressed();

      if(b_pressed_attack) {
        weapon_info = level._fire_direction.a_weapons[str_weapon_current];
        b_using_valid_area = [
          [weapon_info.valid_target_func]
        ]();

        if(isDefined(v_aim_pos) && b_using_valid_area)
          flag_set("fire_direction_target_confirmed");

        self thread[[weapon_info.fire_func]]();
        level notify("fire_direction_stop_weapon");
        weapon_info.time_last_used = gettime();
        flag_clear("fire_direction_shader_on");
        level._fire_direction.current_weapon = "";
        self _take_weapon(str_weapon_current);
        screen_message_delete();
        wait 0.05;
        level.player thread cooldown_weapon(str_weapon_current);
      }
    } else if(flag("fire_direction_shader_on")) {
      level.str_weapon_last = str_weapon_current;
      flag_clear("fire_direction_shader_on");
      level notify("fire_direction_stop_weapon");
    }

    wait 0.05;
  }
}

cooldown_weapon(str_weapon_current) {
  flag_clear("fire_direction_target_confirmed");

  if(str_weapon_current == "god_rod_glove_sp")
    wait 15;
  else
    wait 4;

  if(!flag("fire_direction_disabled")) {
    if(str_weapon_current == "god_rod_glove_sp" || level._fire_direction.a_weapons[str_weapon_current].a_shooters.size > 0) {
      self giveweapon(str_weapon_current);
      self playsound("uin_perk_ready");
    }
  }
}

_montitor_loadout() {
  level endon("_fire_direction_kill");

  while(true) {
    self waittill("weapon_change_complete");

    if(self getcurrentweapon() != "quadrotor_glove_sp" && self getcurrentweapon() != "claw_glove_sp" && self getcurrentweapon() != "god_rod_glove_sp" && self getcurrentweapon() != "data_glove_claw_sp")
      level.str_weapon_last = self getcurrentweapon();
  }
}

_take_weapon(str_weapon_disable, b_immediate) {
  if(!isDefined(b_immediate))
    b_immediate = 0;

  level endon("_fire_direction_kill");

  if(level.str_weapon_last == "quadrotor_glove_sp" || level.str_weapon_last == "claw_glove_sp" || level.str_weapon_last == "god_rod_glove_sp" || level.str_weapon_last == "data_glove_claw_sp")
    wait 0.5;
  else {
    self switchtoweapon(level.str_weapon_last);

    if(!b_immediate)
      self waittill("weapon_change_complete");
  }

  self takeweapon(str_weapon_disable);
}

_get_aim_position() {
  v_eye_pos = level.player geteye();

  if(level.wiiu)
    v_player_eye = level.player getgunangles();
  else
    v_player_eye = level.player getplayerangles();

  v_player_eye = vectornormalize(anglestoforward(v_player_eye));
  v_trace_to_point = v_eye_pos + v_player_eye * 4000;
  a_trace = bullettrace(v_eye_pos, v_trace_to_point, 0, level.player);
  return a_trace["position"];
}

_is_target_area_valid() {
  b_is_valid_area = 1;
  return b_is_valid_area;
}

_handle_shader() {
  level endon("_fire_direction_kill");

  while(true) {
    flag_wait("fire_direction_shader_on");
    str_notify_grid_on = level._fire_direction.a_weapons[level._fire_direction.current_weapon].notify_grid_on;
    str_notify_grid_off = level._fire_direction.a_weapons[level._fire_direction.current_weapon].notify_grid_off;
    clientnotify(str_notify_grid_on);
    flag_waitopen("fire_direction_shader_on");
    clientnotify(str_notify_grid_off);
  }
}

_hint_text(str_weapon) {
  level endon("_fire_direction_kill");
  n_hints = 0;

  while(true) {
    level._fire_direction.hint_active = 1;

    if(n_hints == 0) {
      screen_message_create(level._fire_direction.a_weapons[str_weapon].str_hint, undefined, undefined, undefined, 6);
      n_hints++;
    }

    flag_wait("fire_direction_shader_on");

    if(n_hints == 1)
      level thread screen_message_create(&"SCRIPT_FIRE_DIRECTION_CONFIRM", undefined, undefined, undefined, 6);

    level waittill_either("fire_direction_stop_weapon", "fire_direction_stop_hint");
    screen_message_delete();

    if(flag("fire_direction_target_confirmed")) {
      break;
    }

    level._fire_direction.hint_active = 0;

    if(n_hints < 1)
      wait 4;
    else
      wait 1;
  }
}

quadrotors_find_player_target() {
  v_shoot_pos = _get_aim_position();

  if(isDefined(v_shoot_pos)) {
    a_enemies = get_within_range(v_shoot_pos, getaiarray("axis"), 196);

    iprintln("enemies within range = " + a_enemies.size);

    a_shooters = get_fire_direction_shooters(level.player getcurrentweapon());

    foreach(e_shooter in a_shooters) {
      if(isDefined(e_shooter) && isalive(e_shooter))
        e_shooter thread _quadrotor_attacks_player_target(v_shoot_pos, a_enemies);
    }
  }
}

_quadrotor_attacks_player_target(v_shoot_pos, a_enemies) {
  self endon("death");
  self.goalpos = v_shoot_pos;
  v_shoot_pos = _get_aim_position();

  if(a_enemies.size > 0) {
    e_enemy = undefined;
    e_enemy = random(a_enemies);

    foreach(temp_enemy in a_enemies)
    self thread _quadrotors_register_player_kills(temp_enemy);
  }

  if(isDefined(e_enemy)) {
    self vehsetentitytarget(e_enemy);
    self setturrettargetent(e_enemy);
    self.goalpos = e_enemy.origin;
  } else {
    self setturrettargetvec(v_shoot_pos);
    self.goalpos = v_shoot_pos;
  }

  self notify("near_goal");
  self.quadrotor_doing_fire_direction = 1;
  self thread _quadrotor_update_enemy(v_shoot_pos, 7, e_enemy);
  self maps\_quadrotor::quadrotor_fire_for_time(7);
  self.quadrotor_doing_fire_direction = undefined;
  self notify("fire_time_complete");
  self clearturrettarget();
  self vehclearentitytarget();
}

_quadrotor_update_enemy(v_shoot_pos, firetime, e_enemy) {
  self endon("death");

  while(firetime > 0) {
    check_time = randomfloatrange(0.1, 1.0);
    firetime = firetime - check_time;
    wait(check_time);

    if(!isDefined(e_enemy) || !isalive(e_enemy)) {
      a_enemies = get_within_range(v_shoot_pos, getaiarray("axis"), 246);

      if(a_enemies.size == 0)
        a_enemies = get_within_range(v_shoot_pos, getaiarray("axis"), 392);

      if(a_enemies.size > 0) {
        e_enemy = random(a_enemies);

        if(isDefined(e_enemy)) {
          self vehsetentitytarget(e_enemy);
          self setturrettargetent(e_enemy);
        }
      }
    }
  }
}

_quadrotors_register_player_kills(e_enemy) {
  self endon("fire_time_complete");
  e_enemy waittill("death", attacker);

  if(isDefined(attacker) && attacker == self)
    level.player inc_general_stat("kills");
}

_rod_is_target_area_valid() {
  if(distance2dsquared(level._fire_direction.m_aimpoint.origin, level.player.origin) >= 16000000)
    return false;

  return true;
}

_rod_fire() {
  v_impact_origin = level._fire_direction.m_aimpoint.origin;
  s_trace = bullettrace(v_impact_origin + vectorscale((0, 0, 1), 10000.0), v_impact_origin, 0, undefined);
  badplace_cylinder("rod", 7, s_trace["position"] - vectorscale((0, 0, 1), 750.0), 512, 1500, "allies");
  wait 5;
  level.player thread _rod_impact();
  magicbullet("god_rod_sp", v_impact_origin + vectorscale((0, 0, 1), 10000.0), v_impact_origin, level.player);
}

_rod_add_entities_in_range(e_source, a_e_check) {
  weaponinfo = level._fire_direction.a_weapons["god_rod_glove_sp"];

  foreach(e_check in a_e_check) {
    if(!isDefined(e_check.health)) {
      continue;
    }
    if(e_check.origin[2] < e_source.origin[2] - 750) {
      continue;
    }
    n_dist_sq = distance2dsquared(e_source.origin, e_check.origin);

    if(n_dist_sq < 262144) {
      e_check.n_dist_sq = n_dist_sq;
      weaponinfo.a_e_rod_victims[weaponinfo.a_e_rod_victims.size] = e_check;
    }
  }
}

_rod_impact() {
  self waittill("missile_fire", missile);
  missile waittill("death");

  if(!isDefined(missile)) {
    return;
  }
  v_to_player = missile.origin - level.player.origin;
  v_to_player = (v_to_player[0], v_to_player[1], 0);
  v_to_player = vectornormalize(v_to_player);
  playfx(level._effect["rod_impact"], missile.origin, v_to_player);
  weaponinfo = level._fire_direction.a_weapons["god_rod_glove_sp"];
  weaponinfo.a_e_rod_victims = [];
  a_e_check = getaiarray();
  a_e_check[a_e_check.size] = level.player;
  _rod_add_entities_in_range(missile, a_e_check);
  _rod_add_entities_in_range(missile, getentarray("script_vehicle", "classname"));
  _rod_add_entities_in_range(missile, getentarray("script_model", "classname"));

  foreach(e_victim in weaponinfo.a_e_rod_victims) {
    n_rod_damage = (262144 - e_victim.n_dist_sq) / 262144 * 1690 + 10;

    if(isai(e_victim) && (isDefined(e_victim.isbigdog) && e_victim.isbigdog) && e_victim.n_dist_sq <= 65536) {
      e_victim dodamage(e_victim.health, missile.origin, level.player, undefined, "explosive", "none", "god_rod_sp");
      continue;
    }

    e_victim dodamage(int(n_rod_damage), missile.origin, level.player, undefined, "explosive", "none", "god_rod_sp");
  }

  weaponinfo.a_e_rod_victims = [];
}