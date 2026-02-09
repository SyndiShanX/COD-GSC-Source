/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_cairo_ramses.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_load;
#using scripts\cp\_util;
#using scripts\cp\cp_mi_cairo_ramses_fx;
#using scripts\cp\cp_mi_cairo_ramses_patch_c;
#using scripts\cp\cp_mi_cairo_ramses_sound;
#using scripts\cp\cp_mi_cairo_ramses_utility;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_quadtank;
#namespace cp_mi_cairo_ramses;

function main() {
  util::set_streamer_hint_function(&force_streamer, 3);
  init_clientfields();
  cp_mi_cairo_ramses_fx::main();
  cp_mi_cairo_ramses_sound::main();
  callback::on_localclient_connect(&on_player_spawned);
  load::main();
  util::waitforclient(0);
  level.var_7ab81734 = findstaticmodelindexarray("station_shells");
  level thread set_foley_context();
  namespace_98e946e1::function_7403e82b();
}

function on_player_spawned(localclientnum) {
  player = getlocalplayer(localclientnum);
  filter::init_filter_ev_interference(player);
}

function init_clientfields() {
  clientfield::register("world", "hide_station_miscmodels", 1, 1, "int", &show_hide_staiton_props, 0, 0);
  clientfield::register("world", "turn_on_rotating_fxanim_fans", 1, 1, "int", &turn_on_rotating_fxanim_fans, 0, 0);
  clientfield::register("world", "turn_on_rotating_fxanim_lights", 1, 1, "int", &turn_on_rotating_fxanim_lights, 0, 0);
  clientfield::register("world", "delete_fxanim_fans", 1, 1, "int", &delete_fxanim_fans, 0, 0);
  clientfield::register("toplayer", "nasser_interview_extra_cam", 1, 1, "int", &function_6aab1d81, 0, 0);
  clientfield::register("world", "ramses_station_lamps", 1, 1, "int", &ramses_station_lamps, 0, 0);
  clientfield::register("toplayer", "rap_blood_on_player", 1, 1, "counter", &player_rap_blood_postfx, 0, 0);
  clientfield::register("world", "staging_area_intro", 1, 1, "int", &staging_area_intro, 0, 0);
  clientfield::register("toplayer", "filter_ev_interference_toggle", 1, 1, "int", &filter_ev_interference_toggle, 0, 0);
}

function force_streamer(n_zone) {
  switch (n_zone) {
    case 1: {
      break;
    }
    case 2: {
      forcestreamxmodel("c_ega_soldier_3_pincushion_fb");
      break;
    }
    case 3: {
      forcestreambundle("p_ramses_lift_wing_blockage");
      loadsiegeanim("p7_fxanim_cp_ramses_medical_tarp_cover_s3_sanim");
      loadsiegeanim("p7_fxanim_gp_drone_hunter_swarm_large_sanim");
      break;
    }
    default: {
      break;
    }
  }
}

function turn_on_rotating_fxanim_fans(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!scene::is_playing("p7_fxanim_gp_fan_digital_small_bundle")) {
    level thread scene::play("p7_fxanim_gp_fan_digital_small_bundle");
  }
}

function turn_on_rotating_fxanim_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!scene::is_playing("p7_fxanim_gp_light_emergency_military_01_bundle")) {
    level thread scene::play("p7_fxanim_gp_light_emergency_military_01_bundle");
  }
}

function delete_fxanim_fans(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(scene::is_active("p7_fxanim_gp_fan_digital_small_bundle")) {
    level thread scene::stop("p7_fxanim_gp_fan_digital_small_bundle", 1);
  }
}

function staging_area_intro(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    level scene::init("p7_fxanim_cp_ramses_tarp_gust_01_bundle");
  } else {
    level thread scene::play("p7_fxanim_cp_ramses_tarp_gust_01_bundle");
  }
}

function ramses_station_lamps(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self scene::play("ramses_station_lamps", "targetname");
  }
}

function attach_camera_to_train(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    s_org = struct::get("train_extra_cam", "targetname");
    self.e_extracam = spawn(localclientnum, s_org.origin, "script_origin");
    self.e_extracam.angles = s_org.angles;
    self.e_extracam linkto(self);
    level.e_train_extra_cam = self.e_extracam;
  } else if(isDefined(self.e_extracam)) {
    self.e_extracam delete();
  }
}

function intro_reflection_extracam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    assert(isDefined(level.e_train_extra_cam), "");
    level.e_train_extra_cam setextracam(0);
    setDvar("r_extracam_custom_aspectratio", 0.769);
  } else {
    setDvar("r_extracam_custom_aspectratio", -1);
    if(isDefined(level.e_train_extra_cam)) {
      level.e_train_extra_cam delete();
    }
  }
}

function function_6aab1d81(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_extra_cam = getent(localclientnum, "interview_extra_cam", "targetname");
  if(newval == 1) {
    if(isDefined(e_extra_cam)) {
      e_extra_cam setextracam(0);
    }
  } else if(isDefined(e_extra_cam)) {
    e_extra_cam clearextracam();
  }
}

function player_rap_blood_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setsoundcontext("foley", "normal");
  if(newval == 1) {
    if(!util::is_gib_restricted_build()) {
      self thread postfx::playpostfxbundle("pstfx_blood_spatter");
    }
  }
}

function show_hide_staiton_props(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  assert(isDefined(level.var_7ab81734), "");
  if(newval == 1) {
    foreach(i, model in level.var_7ab81734) {
      hidestaticmodel(model);
      if((i % 25) == 0) {
        wait(0.016);
      }
    }
  } else {
    foreach(i, model in level.var_7ab81734) {
      unhidestaticmodel(model);
      if((i % 10) == 0) {
        wait(0.016);
      }
    }
  }
}

function filter_ev_interference_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    filter::disable_filter_ev_interference(self, 0);
  } else {
    filter::enable_filter_ev_interference(self, 0);
    filter::set_filter_ev_interference_amount(self, 0, 1);
  }
}

function set_foley_context() {}