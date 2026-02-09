/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_low_grav.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\util_shared;
#namespace zm_castle_low_grav;

function main() {
  register_clientfields();
  level.var_51541120 = [];
  level._effect["low_grav_player_jump"] = "dlc1/castle/fx_plyr_115_liquid_trail";
  level._effect["low_grav_screen_fx"] = "dlc1/castle/fx_plyr_screen_115_liquid";
  level._effect["wall_dust"] = "dlc1/castle/fx_zombie_spawn_wallrun_castle";
  level thread function_554db684();
}

function register_clientfields() {
  clientfield::register("scriptmover", "low_grav_powerup_triggered", 5000, 1, "counter", &function_69e96b4d, 0, 0);
  clientfield::register("scriptmover", "zombie_wall_dust", 5000, 1, "counter", &wall_dust, 0, 0);
  clientfield::register("toplayer", "player_postfx", 5000, 1, "int", &function_df81c23d, 0, 0);
  clientfield::register("toplayer", "player_screen_fx", 5000, 1, "int", &player_screen_fx, 0, 1);
  clientfield::register("scriptmover", "undercroft_emissives", 5000, 1, "int", &function_9a8a19ab, 0, 0);
  clientfield::register("scriptmover", "undercroft_wall_panel_shutdown", 5000, 1, "counter", &function_a3279a5, 0, 0);
  clientfield::register("scriptmover", "floor_panel_emissives_glow", 5000, 1, "int", &function_23861dfe, 0, 0);
}

function function_554db684() {
  setDvar("wallrun_enabled", 1);
  setDvar("doublejump_enabled", 1);
  setDvar("playerEnergy_enabled", 1);
  setDvar("bg_lowGravity", 300);
  setDvar("wallRun_maxTimeMs_zm", 10000);
  setDvar("playerEnergy_maxReserve_zm", 200);
  setDvar("wallRun_peakTest_zm", 0);
}

function function_69e96b4d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playSound(0, "zmb_cha_ching", self.origin);
}

function wall_dust(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(localclientnum, level._effect["wall_dust"], self.origin);
}

function player_screen_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(level.var_51541120[localclientnum])) {
      deletefx(localclientnum, level.var_51541120[localclientnum], 1);
    }
    level.var_51541120[localclientnum] = playfxoncamera(localclientnum, level._effect["low_grav_screen_fx"]);
  } else if(isDefined(level.var_51541120[localclientnum])) {
    deletefx(localclientnum, level.var_51541120[localclientnum], 1);
  }
}

function function_df81c23d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    setpbgactivebank(localclientnum, 2);
    self thread postfx::playpostfxbundle("pstfx_115_castle_loop");
  } else {
    setpbgactivebank(localclientnum, 1);
    self thread postfx::exitpostfxbundle();
  }
}

function function_9a8a19ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self notify("hash_67a9e087");
  self endon("hash_67a9e087");
  if(newval == 1) {
    n_start_time = gettime();
    n_end_time = n_start_time + (1 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_end_time);
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
      wait(0.01);
    }
  } else {
    n_start_time = gettime();
    n_end_time = n_start_time + (2 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_end_time);
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
      wait(0.01);
    }
  }
}

function function_a3279a5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self notify("hash_67a9e087");
  self endon("hash_67a9e087");
  n_start_time = gettime();
  n_end_time = n_start_time + (1 * 1000);
  b_is_updating = 1;
  while(b_is_updating) {
    n_time = gettime();
    if(n_time >= n_end_time) {
      n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_end_time);
      b_is_updating = 0;
    } else {
      n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
    wait(0.01);
  }
}

function function_23861dfe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self notify("hash_67a9e087");
  self endon("hash_67a9e087");
  if(newval == 1) {
    n_start_time = gettime();
    n_end_time = n_start_time + (1 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = mapfloat(n_start_time, n_end_time, 0.3, 1, n_end_time);
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 0.3, 1, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
      wait(0.01);
    }
  } else {
    n_start_time = gettime();
    n_end_time = n_start_time + (2 * 1000);
    b_is_updating = 1;
    while(b_is_updating) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0.3, n_end_time);
        b_is_updating = 0;
      } else {
        n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0.3, n_time);
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
      wait(0.01);
    }
  }
}

function function_a81107fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  if(newval) {
    fxobj = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    fxobj thread function_10dcbf51(localclientnum, fxobj);
  }
}

function private function_10dcbf51(localclientnum, fxobj) {
  fxobj playSound(localclientnum, "evt_ai_explode");
  wait(1);
  fxobj delete();
}