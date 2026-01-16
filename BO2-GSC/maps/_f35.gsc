/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_f35.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

_get_f35_death_model_array() {
  a_models = array("veh_t6_air_fa38_dead_cockpit", "veh_t6_air_fa38_dead_engine", "veh_t6_air_fa38_dead_wing_l", "veh_t6_air_fa38_dead_wing_r");
  return a_models;
}

_get_f35_death_model_tag_array() {
  a_model_tags = array("tag_dead_cockpit", "tag_dead_engine", "tag_dead_left_wing", "tag_dead_right_wing");
  return a_model_tags;
}

_get_f35_death_model_fx_tag_array() {
  a_fx_tags = array("tag_fx_dead_cockpit", "tag_fx_dead_engine", "tag_fx_dead_left_wing", "tag_fx_dead_right_wing");
  return a_fx_tags;
}

precache_extra_models() {
  a_models = _get_f35_death_model_array();

  for(i = 0; i < a_models.size; i++) {
    str_model = a_models[i];
    precachemodel(str_model);
  }
}

set_deathmodel(v_point, v_dir) {
  a_models = _get_f35_death_model_array();
  a_model_tags = _get_f35_death_model_tag_array();
  a_fx_tags = _get_f35_death_model_fx_tag_array();
  str_deathmodel = self.deathmodel;

  if(isDefined(self.deathmodel)) {
    str_deathmodel = self.deathmodel;
    self setmodel(str_deathmodel);
    self playsound("evt_f35_explo");
    playsoundatposition("evt_debris_flythrough", self.origin);
  }

  deathmodel_pieces = [];

  for(i = 0; i < a_models.size; i++) {
    str_model = a_models[i];
    str_model_tag = a_model_tags[i];
    str_fx_tag = a_fx_tags[i];
    b_is_model_in_memory = isassetloaded("xmodel", str_model);
    assert(b_is_model_in_memory, str_model + " xmodel is not loaded in memory. Include vehicle_f35 in your level CSV!");
    deathmodel_pieces[i] = spawn("script_model", self gettagorigin(str_model_tag));
    deathmodel_pieces[i].angles = self gettagangles(str_model_tag);
    deathmodel_pieces[i] setmodel(str_model);
    deathmodel_pieces[i] linkto(self, str_model_tag);
  }

  if(isDefined(deathmodel_pieces) && deathmodel_pieces.size > 0) {
    deathmodel_pieces = get_array_of_closest(v_point, deathmodel_pieces);
    num_pieces = 1;

    if(isDefined(self.last_damage_mod)) {
      if(self.last_damage_mod == "MOD_PROJECTILE" || self.last_damage_mod == "MOD_EXPLOSIVE")
        num_pieces = randomintrange(2, deathmodel_pieces.size);
    }

    for(i = 0; i < num_pieces; i++) {
      vel_dir = vectornormalize(self.velocity);
      deathmodel_pieces[i] unlink();
      deathmodel_pieces[i] movegravity(vel_dir * 1000, 5);
      deathmodel_pieces[i] rotate_dead_piece();
      deathmodel_pieces[i] thread delete_deathmodel_piece();
      deathmodel_pieces[i].b_launched = 1;
    }
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