/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_avenger.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

_get_avenger_death_model_array() {
  a_models = array("veh_t6_drone_avenger_dead_nose", "veh_t6_drone_avenger_dead_wing_r", "veh_t6_drone_avenger_dead_wing_l", "veh_t6_drone_avenger_dead_tail_r", "veh_t6_drone_avenger_dead_tail_l");
  return a_models;
}

_get_avenger_death_model_2x_array() {
  a_models = array("veh_t6_drone_avenger_dead_nose_x2", "veh_t6_drone_avenger_dead_wing_r_x2", "veh_t6_drone_avenger_dead_wing_l_x2", "veh_t6_drone_avenger_dead_tail_r_x2", "veh_t6_drone_avenger_dead_tail_l_x2");
  return a_models;
}

_get_avenger_death_model_tag_array() {
  a_model_tags = array("tag_dead_body_front", "tag_dead_wing_right", "tag_dead_wing_left", "tag_dead_tail_right", "tag_dead_tail_left");
  return a_model_tags;
}

_get_avenger_death_model_fx_tag_array() {
  a_fx_tags = array("tag_fx_dead_body_front", "tag_fx_dead_wing_right", "tag_fx_dead_wing_left", "tag_fx_dead_tail_right", "tag_fx_dead_tail_left");
  return a_fx_tags;
}

precache_extra_models(is_2x) {
  if(!isDefined(is_2x))
    is_2x = 0;

  if(is_2x)
    a_models = _get_avenger_death_model_2x_array();
  else
    a_models = _get_avenger_death_model_array();

  for(i = 0; i < a_models.size; i++) {
    str_model = a_models[i];
    precachemodel(str_model);
  }

  self._vehicle_load_fx = ::precache_crash_fx;
}

precache_crash_fx() {
  if(!isDefined(self.fx_crash_effects))
    self.fx_crash_effects = [];

  self.fx_crash_effects["fire_trail_lg"] = loadfx("trail/fx_trail_drone_piece_damage_smoke");
}

set_deathmodel(v_point, v_dir) {
  a_models = _get_avenger_death_model_array();
  a_model_tags = _get_avenger_death_model_tag_array();
  a_fx_tags = _get_avenger_death_model_fx_tag_array();
  str_deathmodel = self.deathmodel;

  if(isDefined(self.deathmodel)) {
    str_deathmodel = self.deathmodel;
    self setmodel(str_deathmodel);

    if(isDefined(self.fx_crash_effects) && isDefined(self.fx_crash_effects["fire_trail_lg"]))
      playfxontag(self.fx_crash_effects["fire_trail_lg"], self, "tag_origin");

    self playsound("evt_avenger_explo");
    self playsound("evt_drone_explo_close");
    playsoundatposition("evt_debris_flythrough", self.origin);
  }

  deathmodel_pieces = [];

  for(i = 0; i < a_models.size; i++) {
    str_model = a_models[i];
    str_model_tag = a_model_tags[i];
    str_fx_tag = a_fx_tags[i];
    deathmodel_pieces[i] = spawn("script_model", self gettagorigin(str_model_tag));
    deathmodel_pieces[i].angles = self gettagangles(str_model_tag);
    deathmodel_pieces[i] setmodel(str_model);
    deathmodel_pieces[i] linkto(self, str_model_tag);
    deathmodel_pieces[i] thread delete_deathmodel_piece();
  }

  if(isDefined(deathmodel_pieces)) {
    deathmodel_pieces = get_array_of_closest(v_point, deathmodel_pieces);
    num_pieces = 1;

    if(isDefined(self.last_damage_mod)) {
      if(self.last_damage_mod == "MOD_PROJECTILE" || self.last_damage_mod == "MOD_EXPLOSIVE")
        num_pieces = randomintrange(2, deathmodel_pieces.size);
    }

    for(i = 0; i < num_pieces; i++) {
      vel_dir = vectornormalize(self gettagorigin(str_model_tag) - self.origin);
      vel_dir = vel_dir + vectornormalize(self.velocity);
      deathmodel_pieces[i] unlink();
      deathmodel_pieces[i] movegravity(vel_dir * 2500 + vectorscale((0, 0, 1), 100.0), 5);
      deathmodel_pieces[i] thread rotate_dead_piece();
      deathmodel_pieces[i].b_launched = 1;
      playfxontag(self.fx_crash_effects["fire_trail_lg"], deathmodel_pieces[i], "tag_origin");
    }
  }
}

update_objective_model() {
  self endon("death");
  self thread clear_objective_model_on_death();

  while(true) {
    self waittill("missileLockTurret_locked");

    if(!isDefined(self) || self.health <= 0) {
      return;
    }
    level.f35_lockon_target = self;
    self setclientflag(15);
    self waittill("missileLockTurret_cleared");
    level.f35_lockon_target = undefined;
    self clearclientflag(15);
  }
}

update_damage_states() {
  self endon("death");
  is_damaged = 0;

  while(!is_damaged) {
    self waittill("damage");

    if(self.health <= self.maxhealth * 0.5) {
      playfxontag(self.fx_crash_effects["fire_trail_lg"], self, "tag_origin");
      is_damaged = 1;
    }
  }
}

clear_objective_model_on_death() {
  self waittill("death");

  if(isDefined(self)) {
    self clearclientflag(15);

    if(isDefined(level.f35_lockon_target) && level.f35_lockon_target == self)
      level.f35_lockon_target = undefined;
  }
}

rotate_dead_piece() {
  self endon("death");
  torque = (0, randomintrange(-90, 90), randomintrange(90, 720));

  if(randomint(100) < 50)
    torque = (torque[0], torque[1], torque[2] * -1);

  ang_vel = (0, 0, 0);

  while(isDefined(self)) {
    ang_vel = ang_vel + torque * 0.05;

    if(ang_vel[2] < 500 * -1)
      ang_vel = (ang_vel[0], ang_vel[1], 500 * -1);
    else if(ang_vel[2] > 500)
      ang_vel = (ang_vel[0], ang_vel[1], 500);

    self.angles = self.angles + ang_vel * 0.05;
    wait 0.05;
  }
}

delete_deathmodel_piece() {
  wait 5;
  self delete();
}