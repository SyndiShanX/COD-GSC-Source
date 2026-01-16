/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_ee.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\postfx_shared;
#namespace zm_castle_ee;

function main() {
  register_clientfields();
  duplicate_render::set_dr_filter_framebuffer("zod_ghost", 90, "zod_ghost", undefined, 0, "mc/hud_zod_ghost", 0);
  level._effect["plunger_charge_1p"] = "dlc1/zmb_weapon/fx_ee_plunger_trail_1p";
  level._effect["plunger_charge_3p"] = "dlc1/zmb_weapon/fx_ee_plunger_trail_3p";
}

function register_clientfields() {
  n_bits = getminbitcountfornum(4);
  clientfield::register("toplayer", "player_ee_cs_circle", 5000, n_bits, "int", & function_2a1f20f9, 0, 0);
  clientfield::register("actor", "ghost_actor", 1, 1, "int", & ghost_actor, 0, 0);
  clientfield::register("scriptmover", "channeling_stone_glow", 5000, 2, "int", & channeling_stone_glow, 0, 0);
  clientfield::register("world", "flip_skybox", 5000, 1, "int", & flip_skybox, 0, 0);
  clientfield::register("scriptmover", "pod_monitor_enable", 5000, 1, "int", & function_3c1114e8, 0, 0);
  clientfield::register("world", "sndDeathRayToMoon", 5000, 1, "int", & snddeathraytomoon, 0, 0);
  clientfield::register("toplayer", "outro_lighting_banks", 5000, 1, "int", & outro_lighting_banks, 0, 0);
  clientfield::register("toplayer", "moon_explosion_bank", 5000, 1, "int", & moon_explosion_bank, 0, 0);
}

function ghost_actor(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self duplicate_render::set_dr_flag("zod_ghost", newval);
  self duplicate_render::update_dr_filters(localclientnum);
}

function function_2a1f20f9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle("pstfx_arrow_demongate");
    playsound(0, "zmb_ee_resurrect_enter_circle", (0, 0, 0));
  } else {
    if(newval == 2) {
      self thread postfx::playpostfxbundle("pstfx_arrow_rune");
      playsound(0, "zmb_ee_resurrect_enter_circle", (0, 0, 0));
    } else {
      if(newval == 3) {
        self thread postfx::playpostfxbundle("pstfx_arrow_elemental");
        playsound(0, "zmb_ee_resurrect_enter_circle", (0, 0, 0));
      } else {
        if(newval == 4) {
          self thread postfx::playpostfxbundle("pstfx_arrow_wolf");
          playsound(0, "zmb_ee_resurrect_enter_circle", (0, 0, 0));
        } else {
          self thread postfx::stoppostfxbundle();
          playsound(0, "zmb_ee_resurrect_leave_circle", (0, 0, 0));
        }
      }
    }
  }
}

function channeling_stone_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self notify("hash_a1e4f5f1");
  self endon("hash_a1e4f5f1");
  if(newval == 1) {
    n_start_time = gettime();
    var_b1382f05 = n_start_time + (0.85 * 1000);
    var_c8a6e70a = 0;
    var_2be3abbd = 1;
    n_shader_value = 0;
    while (true) {
      n_time = gettime();
      if(n_time >= var_b1382f05) {
        n_start_time = gettime();
        var_b1382f05 = n_start_time + (0.85 * 1000);
        var_c8a6e70a = n_shader_value;
        var_2be3abbd = (var_2be3abbd == 1 ? 0 : 1);
      }
      n_shader_value = mapfloat(n_start_time, var_b1382f05, var_c8a6e70a, var_2be3abbd, n_time);
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
      wait(0.01);
    }
  } else {
    if(newval == 2) {
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0);
    } else {
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0);
    }
  }
}

function function_3c1114e8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, newval, 0);
}

function flip_skybox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    setdvar("r_skyTransition", 1);
  }
}

function snddeathraytomoon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playsound(0, "zmb_ee_rocketcrash_ray_start", (-271, 2196, 1338));
    wait(0.05);
    playsound(0, "zmb_ee_rocketcrash_ray_start", (552, 2201, 1344));
  } else {
    playsound(0, "zmb_ee_rocketcrash_ray_end", (-271, 2196, 1348));
    wait(0.05);
    playsound(0, "zmb_ee_rocketcrash_ray_end", (552, 2201, 1344));
  }
}

function outro_lighting_banks(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    setpbgactivebank(localclientnum, 2);
    setexposureactivebank(localclientnum, 2);
  } else {
    setpbgactivebank(localclientnum, 1);
    setexposureactivebank(localclientnum, 1);
  }
}

function moon_explosion_bank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    setexposureactivebank(localclientnum, 4);
  } else {
    setexposureactivebank(localclientnum, 1);
  }
}