/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_afghanstinger.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

autoexec init() {
  level._effect["_afghanstinger_trail"] = loadfx("weapon/rocket/fx_stinger_afgh_trail");
  level._effect["_afghanstinger_impact"] = loadfx("weapon/rocket/fx_stinger_afgh_trail_impact");
  level._afghanstinger_detonate_function = undefined;
  flag_init("detonation_hint_show");
}

_afghanstinger_fire_watcher() {
  self endon("death");

  while(true) {
    self waittill("missile_fire", e_missile, str_weapon);

    if(str_weapon == "afghanstinger_sp") {
      if(!flag("detonation_hint_show"))
        e_missile thread mid_air_detonation_hint();

      self _afghanstinger_missile_think(e_missile);
    }
  }
}

mid_air_detonation_hint() {
  n_index = 0;
  screen_message_create(&"SCRIPT_AFGHANSTINGER_DETONATE_HINT");
  self waittill("death");
  screen_message_delete();
  n_index++;

  if(n_index > 1)
    flag_set("detonation_hint_show");
}

_afghanstinger_missile_think(e_missile) {
  self thread _afghanstinger_airburst_button_check(e_missile);
  self thread _afghanstinger_impact_check(e_missile);
  level waittill("as_rocket_exploded", v_explode_point);
  self thread _afghanstinger_fireballs_think(v_explode_point);
}

_afghanstinger_airburst_button_check(e_missile) {
  level endon("as_rocket_exploded");
  e_missile endon("death");
  wait 0.05;

  do {
    while(self attackbuttonpressed())
      wait 0.05;

    while(!self attackbuttonpressed())
      wait 0.05;

    radiusdamage(e_missile.origin, 500, 800, 500, self, "MOD_EXPLOSIVE", "afghanstinger_sp");
    flag_set("detonation_hint_show");

    if(isDefined(level._afghanstinger_detonate_function))
      e_missile thread[[level._afghanstinger_detonate_function]]();
  }
  while(self getcurrentweapon() != "afghanstinger_sp");

  v_explode_point = e_missile.origin;
  e_missile resetmissiledetonationtime(0);
  level notify("as_rocket_exploded", v_explode_point);
}

_afghanstinger_impact_check(e_missile) {
  level endon("as_rocket_exploded");
  self waittill("projectile_impact", e_ent, v_explode_point, n_radius, str_name, n_impact);
  level notify("as_rocket_exploded", v_explode_point);
}

_afghanstinger_fireballs_think(v_explode_point) {
  v_end_pos = v_explode_point - vectorscale((0, 0, 1), 8000.0);
  a_ground_trace = bullettrace(v_explode_point, v_end_pos, 0, self);

  if(a_ground_trace["position"] == v_end_pos)
    return false;

  a_enemies = get_within_range(a_ground_trace["position"], getaiarray("axis"), 256);
  a_enemies = array_randomize(a_enemies);

  for(i = 0; i < 5; i++) {
    n_z_offset = randomintrange(-64, 64);

    if(i < a_enemies.size && !isDefined(a_enemies[i].ridingvehicle)) {
      v_guy_origin = a_enemies[i].origin;
      v_start = (v_guy_origin[0], v_guy_origin[1], v_explode_point[2] + n_z_offset);
    } else {
      v_fireball_offset = (randomintrange(-256, 256), randomintrange(-256, 256), n_z_offset);
      v_start = v_explode_point + v_fireball_offset;
    }

    self thread _fireball_drop(v_start);
  }
}

_fireball_drop(v_start) {
  m_fireball = spawn_model("tag_origin", v_start, (0, 0, 0));
  playfxontag(level._effect["_afghanstinger_trail"], m_fireball, "tag_origin");
  v_end_pos = v_start - vectorscale((0, 0, 1), 8000.0);
  a_ground_trace = bullettrace(v_start, v_end_pos, 0, m_fireball);
  n_fall_dist = length(a_ground_trace["position"] - v_start);
  n_fall_time = n_fall_dist / 900;

  if(n_fall_time > 0) {
    n_accel_time = 2;

    if(n_accel_time > n_fall_time)
      n_accel_time = n_fall_time;

    m_fireball moveto(a_ground_trace["position"], n_fall_time, n_accel_time);
    m_fireball waittill("movedone");
  }

  v_final_pos = m_fireball.origin;
  playfx(level._effect["_afghanstinger_impact"], v_final_pos, (1, 0, 0), (0, 0, 1));
  radiusdamage(v_final_pos, 200, 200, 100, self, "MOD_PROJECTILE", "afghanstinger_sp");
  m_fireball delete();
  self thread _fireball_do_damage(v_final_pos);
}

_fireball_do_damage(v_spot) {
  a_enemies = get_within_range(v_spot, getaiarray("axis"), 64);

  foreach(ai_enemy in a_enemies) {
    if(!isDefined(ai_enemy.ridingvehicle))
      ai_enemy dodamage(ai_enemy.health + 10, v_spot, self);
  }
}