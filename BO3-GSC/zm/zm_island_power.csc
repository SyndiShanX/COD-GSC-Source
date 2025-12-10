/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_power.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weapons;
#namespace zm_island_power;

function init() {
  clientfield::register("scriptmover", "bucket_fx", 9000, 1, "int", &bucket_fx, 0, 0);
  clientfield::register("world", "power_switch_1_fx", 9000, 1, "int", &power_switch_1_fx, 0, 0);
  clientfield::register("world", "power_switch_2_fx", 9000, 1, "int", &power_switch_2_fx, 0, 0);
  clientfield::register("world", "penstock_fx_anim", 9000, 1, "int", &function_8816d2aa, 0, 0);
  clientfield::register("scriptmover", "power_plant_glow", 9000, 1, "int", &power_plant_glow, 0, 0);
}

function bucket_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.fx_id)) {
    deletefx(localclientnum, self.fx_id);
    self.fx_id = undefined;
  }
  if(newval == 1) {
    self.fx_id = playFXOnTag(localclientnum, level._effect["bucket_fx"], self, "tag_origin");
  }
}

function power_switch_1_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_s_fx = struct::get_array("power_switch_1_fx", "targetname");
  foreach(s_fx in a_s_fx) {
    if(isDefined(s_fx.a_fx_id)) {
      a_keys = getarraykeys(s_fx.a_fx_id);
      if(isinarray(a_keys, localclientnum)) {
        deletefx(localclientnum, s_fx.a_fx_id[localclientnum], 0);
      }
    }
  }
  if(newval == 1) {
    var_92ee343f = getent(localclientnum, "power_wires_lab_a", "targetname");
    var_92ee343f thread function_5ae9f178(localclientnum, 0);
    foreach(s_fx in a_s_fx) {
      if(!isDefined(s_fx.a_fx_id)) {
        s_fx.a_fx_id = [];
      }
      s_fx.a_fx_id[localclientnum] = playFX(localclientnum, level._effect["tower_light_red"], s_fx.origin);
    }
  } else {
    var_92ee343f = getent(localclientnum, "power_wires_lab_a", "targetname");
    var_92ee343f thread function_5ae9f178(localclientnum, 1);
    foreach(s_fx in a_s_fx) {
      if(!isDefined(s_fx.a_fx_id)) {
        s_fx.a_fx_id = [];
      }
      s_fx.a_fx_id[localclientnum] = playFX(localclientnum, level._effect["tower_light_green"], s_fx.origin);
    }
  }
}

function power_switch_2_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_s_fx = struct::get_array("power_switch_2_fx", "targetname");
  foreach(s_fx in a_s_fx) {
    if(isDefined(s_fx.a_fx_id)) {
      a_keys = getarraykeys(s_fx.a_fx_id);
      if(isinarray(a_keys, localclientnum)) {
        deletefx(localclientnum, s_fx.a_fx_id[localclientnum], 0);
      }
    }
  }
  if(newval == 1) {
    var_92ee343f = getent(localclientnum, "power_wires_lab_b", "targetname");
    var_92ee343f thread function_5ae9f178(localclientnum, 0);
    foreach(s_fx in a_s_fx) {
      if(!isDefined(s_fx.a_fx_id)) {
        s_fx.a_fx_id = [];
      }
      s_fx.a_fx_id[localclientnum] = playFX(localclientnum, level._effect["tower_light_red"], s_fx.origin);
    }
  } else {
    var_92ee343f = getent(localclientnum, "power_wires_lab_b", "targetname");
    var_92ee343f thread function_5ae9f178(localclientnum, 1);
    foreach(s_fx in a_s_fx) {
      if(!isDefined(s_fx.a_fx_id)) {
        s_fx.a_fx_id = [];
      }
      s_fx.a_fx_id[localclientnum] = playFX(localclientnum, level._effect["tower_light_green"], s_fx.origin);
    }
  }
}

function function_5ae9f178(localclientnum, b_on = 1) {
  self endon("entityshutdown");
  self notify("hash_67a9e087");
  self endon("hash_67a9e087");
  n_start_time = gettime();
  n_end_time = n_start_time + (2 * 1000);
  b_is_updating = 1;
  if(isDefined(b_on) && b_on) {
    n_max = 1;
    n_min = 0;
  } else {
    n_max = 0;
    n_min = 1;
  }
  while(b_is_updating) {
    n_time = gettime();
    if(n_time >= n_end_time) {
      n_shader_value = mapfloat(n_start_time, n_end_time, n_min, n_max, n_end_time);
      b_is_updating = 0;
    } else {
      n_shader_value = mapfloat(n_start_time, n_end_time, n_min, n_max, n_time);
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
    wait(0.01);
  }
}

function function_8816d2aa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    scene::init("p7_fxanim_zm_island_penstock_vent_stuck_bundle");
  } else {
    scene::play("p7_fxanim_zm_island_penstock_vent_stuck_bundle");
  }
}

function power_plant_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread function_a88bde9b(localclientnum, 1);
  } else {
    self thread function_a88bde9b(localclientnum, 0);
  }
}

function function_a88bde9b(localclientnum, b_on = 1) {
  self endon("entityshutdown");
  self notify("hash_67a9e087");
  self endon("hash_67a9e087");
  n_start_time = gettime();
  n_end_time = n_start_time + (2 * 1000);
  b_is_updating = 1;
  if(isDefined(b_on) && b_on) {
    n_max = 1;
    n_min = 0;
  } else {
    n_max = 0;
    n_min = 1;
  }
  while(b_is_updating) {
    n_time = gettime();
    if(n_time >= n_end_time) {
      n_shader_value = mapfloat(n_start_time, n_end_time, n_min, n_max, n_end_time);
      b_is_updating = 0;
    } else {
      n_shader_value = mapfloat(n_start_time, n_end_time, n_min, n_max, n_time);
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
    wait(0.01);
  }
}