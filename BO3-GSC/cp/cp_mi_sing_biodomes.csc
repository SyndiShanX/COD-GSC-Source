/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_biodomes.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_load;
#using scripts\cp\_squad_control;
#using scripts\cp\_util;
#using scripts\cp\cp_mi_sing_biodomes_fx;
#using scripts\cp\cp_mi_sing_biodomes_patch_c;
#using scripts\cp\cp_mi_sing_biodomes_sound;
#using scripts\shared\clientfield_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#namespace cp_mi_sing_biodomes;

function main() {
  clientfields_init();
  util::set_streamer_hint_function( & force_streamer, 2);
  cp_mi_sing_biodomes_fx::main();
  cp_mi_sing_biodomes_sound::main();
  load::main();
  util::waitforclient(0);
  namespace_8d32191f::function_7403e82b();
}

function clientfields_init() {
  clientfield::register("toplayer", "player_dust_fx", 1, 1, "int", & function_b33fd8cd, 0, 0);
  clientfield::register("toplayer", "player_waterfall_pstfx", 1, 1, "int", & player_waterfall_callback, 0, 0);
  clientfield::register("toplayer", "bullet_disconnect_pstfx", 1, 1, "int", & bullet_disconnect_callback, 0, 0);
  clientfield::register("toplayer", "zipline_speed_blur", 1, 1, "int", & function_424e31ac, 0, 0);
  clientfield::register("toplayer", "umbra_tome_markets2", 1, 1, "counter", & function_51e4599a, 0, 0);
  clientfield::register("scriptmover", "waiter_blood_shader", 1, 1, "int", & function_81199318, 0, 0);
  clientfield::register("world", "set_exposure_bank", 1, 1, "int", & function_1e832062, 0, 0);
  clientfield::register("world", "party_house_shutter", 1, 1, "int", & function_e49f0db0, 0, 0);
  clientfield::register("world", "party_house_destruction", 1, 1, "int", & function_f3caffbf, 0, 0);
  clientfield::register("world", "dome_glass_break", 1, 1, "int", & function_f386de49, 0, 0);
  clientfield::register("world", "warehouse_window_break", 1, 1, "int", & warehouse_window_break, 0, 0);
  clientfield::register("world", "control_room_window_break", 1, 1, "int", & control_room_window_break, 0, 0);
  clientfield::register("toplayer", "server_extra_cam", 1, 5, "int", & server_extra_cam, 0, 0);
  clientfield::register("toplayer", "server_interact_cam", 1, 3, "int", & server_interact_cam, 0, 0);
  clientfield::register("world", "cloud_mountain_crows", 1, 2, "int", & function_76ca6777, 0, 0);
  clientfield::register("world", "fighttothedome_exfil_rope", 1, 2, "int", & function_32baa33e, 0, 0);
  clientfield::register("world", "fighttothedome_exfil_rope_sim_player", 1, 1, "int", & function_d550bd06, 0, 0);
}

function player_bullet_transition(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 2: {
      self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_fade_in");
      playSound(0, "gdt_securitybreach_transition_in", (0, 0, 0));
      break;
    }
    case 3: {
      self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_fade_out");
      playSound(0, "gdt_securitybreach_transition_out", (0, 0, 0));
      break;
    }
    case 1: {
      self thread postfx::stoppostfxbundle();
      break;
    }
    case 4: {
      self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_white");
      break;
    }
  }
}

function function_51e4599a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  umbra_settometriggeronce(localclientnum, "markets2");
}

function player_waterfall_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function bullet_disconnect_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread postfx::playpostfxbundle("pstfx_dni_screen_futz");
  } else {
    self thread postfx::stoppostfxbundle();
  }
}

function function_424e31ac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    enablespeedblur(localclientnum, 0.07, 0.55, 0.9, 0, 100, 100);
  } else {
    disablespeedblur(localclientnum);
  }
}

function function_81199318(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  n_start_time = gettime();
  b_is_updating = 1;
  while(b_is_updating) {
    n_time = gettime();
    var_348e23ad = (n_time - n_start_time) / 1000;
    if(var_348e23ad >= 4) {
      var_348e23ad = 4;
      b_is_updating = 0;
    }
    var_cba49b4e = 0.9 * (var_348e23ad / 4);
    self mapshaderconstant(localclientnum, 0, "scriptVector0", var_cba49b4e, 0, 0);
    wait(0.01);
  }
}

function function_e49f0db0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level thread scene::play("p7_fxanim_cp_biodomes_roll_up_door_bundle");
  }
}

function function_f3caffbf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level thread scene::play("p7_fxanim_cp_biodomes_party_house_bundle");
    level thread scene::play("p7_fxanim_gp_lantern_paper_04_red_single_bundle");
    level thread scene::play("p7_fxanim_gp_lantern_paper_03_red_single_bundle");
  }
}

function function_f386de49(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level thread scene::play("p7_fxanim_cp_biodomes_rpg_dome_glass_bundle");
  }
}

function warehouse_window_break(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level thread scene::play("p7_fxanim_cp_biodomes_warehouse_glass_break_bundle");
  }
}

function control_room_window_break(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level thread scene::play("p7_fxanim_cp_biodomes_server_room_window_break_02_bundle");
  }
}

function function_76ca6777(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    level thread scene::init("p7_fxanim_cp_biodomes_crow_takeoff_bundle");
  } else if(newval == 2) {
    level thread scene::play("p7_fxanim_cp_biodomes_crow_takeoff_bundle");
  }
}

function function_32baa33e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    scene::add_scene_func("p7_fxanim_cp_biodomes_rope_sim_player_bundle", & function_1f0ba50, "init");
    level thread scene::init("p7_fxanim_cp_biodomes_rope_drop_player_bundle");
    level thread scene::init("p7_fxanim_cp_biodomes_rope_sim_player_bundle");
    wait(1);
    level thread scene::play("p7_fxanim_cp_biodomes_rope_drop_hendricks_bundle");
  } else if(newval == 2) {
    level thread scene::stop("p7_fxanim_cp_biodomes_rope_drop_hendricks_bundle", 1);
    level thread scene::play("p7_fxanim_cp_biodomes_rope_drop_player_bundle");
  }
}

function function_1f0ba50(a_ents) {
  a_ents["rope_sim_player"] hide();
}

function function_d550bd06(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    scene::add_scene_func("p7_fxanim_cp_biodomes_rope_sim_player_bundle", & function_be7ae167, "play");
    level thread scene::play("p7_fxanim_cp_biodomes_rope_sim_player_bundle");
  }
}

function function_be7ae167(a_ents) {
  a_ents["rope_sim_player"] show();
}

function server_extra_cam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_xcam1 = getent(localclientnum, "server_camera1", "targetname");
  e_xcam2 = getent(localclientnum, "server_camera2", "targetname");
  e_xcam3 = getent(localclientnum, "server_camera3", "targetname");
  e_xcam4 = getent(localclientnum, "server_camera4", "targetname");
  switch (newval) {
    case 0: {
      break;
    }
    case 1: {
      e_xcam2 setextracam(0);
      break;
    }
    case 2: {
      e_xcam1 setextracam(0);
      break;
    }
    case 3: {
      e_xcam3 setextracam(0);
      e_xcam3 rotateyaw(35, 2);
      break;
    }
    case 4: {
      e_xcam4 setextracam(0);
      break;
    }
    case 5: {
      e_xcam3 setextracam(0);
      e_xcam3 rotateyaw(-35, 2);
      break;
    }
  }
}

function server_interact_cam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function force_streamer(n_zone) {
  switch (n_zone) {
    case 1: {
      streamtexturelist("cp_mi_sing_biodomes");
      forcestreambundle("cin_bio_01_01_party_1st_drinks");
      forcestreambundle("cin_bio_01_01_party_1st_drinks_part2");
      forcestreambundle("p7_fxanim_cp_biodomes_party_house_drinks_bundle");
      forcestreambundle("p7_fxanim_cp_biodomes_roll_up_door_bundle");
      break;
    }
    case 2: {
      forcestreamxmodel("c_54i_supp_body");
      forcestreamxmodel("c_54i_supp_head1");
      break;
    }
  }
}

function function_1e832062(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    setexposureactivebank(localclientnum, 4);
  } else {
    setexposureactivebank(localclientnum, 1);
  }
}

function function_b33fd8cd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
    self.n_fx_id = playfxoncamera(localclientnum, level._effect["player_dust"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
  } else if(isDefined(self.n_fx_id)) {
    deletefx(localclientnum, self.n_fx_id, 1);
  }
}