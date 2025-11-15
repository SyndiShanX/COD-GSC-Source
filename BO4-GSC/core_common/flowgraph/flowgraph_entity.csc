/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\flowgraph\flowgraph_entity.csc
******************************************************/

#include scripts\core_common\util_shared;

#namespace flowgraph_entity;

isentitydefinedfunc(e_entity) {
  return isDefined(e_entity);
}

getentityorigin(e_entity) {
  return e_entity.origin;
}

getentityangles(e_entity) {
  return e_entity.angles;
}

lerpshaderconstantovertime(x, e_entity, i_script_vector, f_start_x, f_start_y, f_start_z, f_start_w, f_end_x, f_end_y, f_end_z, f_end_w, f_time) {
  e_entity endon(#"death");
  e_entity util::waittill_dobj(self.owner.localclientnum);

  if(!isDefined(e_entity)) {
    return;
  }

  if(!isDefined(f_start_x)) {
    f_start_x = 0;
  }

  if(!isDefined(f_start_y)) {
    f_start_y = 0;
  }

  if(!isDefined(f_start_z)) {
    f_start_z = 0;
  }

  if(!isDefined(f_start_w)) {
    f_start_w = 0;
  }

  if(!isDefined(f_end_x)) {
    f_end_x = 0;
  }

  if(!isDefined(f_end_y)) {
    f_end_y = 0;
  }

  if(!isDefined(f_end_z)) {
    f_end_z = 0;
  }

  if(!isDefined(f_end_w)) {
    f_end_w = 0;
  }

  s_timer = util::new_timer(self.owner.localclientnum);

  do {
    util::server_wait(self.owner.localclientnum, 0.11);
    n_current_time = s_timer util::get_time_in_seconds();
    n_lerp_val = n_current_time / f_time;
    n_delta_val_x = lerpfloat(f_start_x, f_end_x, n_lerp_val);
    n_delta_val_y = lerpfloat(f_start_y, f_end_y, n_lerp_val);
    n_delta_val_z = lerpfloat(f_start_z, f_end_z, n_lerp_val);
    n_delta_val_w = lerpfloat(f_start_w, f_end_w, n_lerp_val);
    e_entity mapshaderconstant(self.owner.localclientnum, 0, "scriptVector" + i_script_vector, n_delta_val_x, n_delta_val_y, n_delta_val_z, n_delta_val_w);
  }
  while(n_current_time < f_time);
}

function_fd19ef53(e_entity, str_field) {
  return e_entity.(str_field);
}

function_7e40ae2d(x, e_entity, str_field, var_value) {
  e_entity.(str_field) = var_value;
  return true;
}