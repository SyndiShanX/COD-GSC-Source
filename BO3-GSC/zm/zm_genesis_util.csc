/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_util.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_utility;
#namespace zm_genesis_util;

function autoexec __init__sytem__() {
  system::register("zm_genesis_util", &__init__, &__main__, undefined);
}

function __init__() {
  n_bits = getminbitcountfornum(8);
  clientfield::register("toplayer", "player_rumble_and_shake", 15000, n_bits, "int", &player_rumble_and_shake, 0, 0);
  n_bits = getminbitcountfornum(4);
  clientfield::register("scriptmover", "emit_smoke", 15000, n_bits, "int", &emit_smoke, 0, 0);
  n_bits = getminbitcountfornum(4);
  clientfield::register("scriptmover", "fire_trap", 15000, n_bits, "int", &fire_trap, 0, 0);
  clientfield::register("actor", "fire_trap_ignite_enemy", 15000, 1, "int", &fire_trap_ignite_enemy, 0, 0);
  clientfield::register("scriptmover", "rq_gateworm_magic", 15000, 1, "int", &rq_gateworm_magic, 0, 0);
  clientfield::register("scriptmover", "rq_gateworm_dissolve_finish", 15000, 1, "int", &rq_gateworm_dissolve_finish, 0, 0);
  clientfield::register("scriptmover", "rq_rune_glow", 15000, 1, "int", &rq_rune_glow, 0, 0);
  registerclientfield("world", "gen_rune_electricity", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
  registerclientfield("world", "gen_rune_fire", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
  registerclientfield("world", "gen_rune_light", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
  registerclientfield("world", "gen_rune_shadow", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
  clientfield::register("clientuimodel", "zmInventory.widget_rune_parts", 15000, 1, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.player_rune_quest", 15000, 1, "int", undefined, 0, 0);
}

function __main__() {}

function player_rumble_and_shake(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("disconnect");
  switch (newval) {
    case 5: {
      self thread player_continuous_rumble(localclientnum, 1);
      break;
    }
    case 6: {
      self notify("stop_rumble_and_shake");
      self earthquake(0.6, 1.5, self.origin, 100);
      self playrumbleonentity(localclientnum, "artillery_rumble");
      break;
    }
    case 4: {
      self earthquake(0.6, 1.5, self.origin, 100);
      self playrumbleonentity(localclientnum, "artillery_rumble");
      break;
    }
    case 3: {
      self earthquake(0.3, 1.5, self.origin, 100);
      self playrumbleonentity(localclientnum, "shotgun_fire");
      break;
    }
    case 2: {
      self earthquake(0.1, 1, self.origin, 100);
      self playrumbleonentity(localclientnum, "damage_light");
      break;
    }
    case 1: {
      self playrumbleonentity(localclientnum, "reload_large");
      break;
    }
    case 7: {
      self thread player_continuous_rumble(localclientnum, 3, 0);
      break;
    }
    case 0: {
      self notify("stop_rumble_and_shake");
      break;
    }
    default: {
      self notify("stop_rumble_and_shake");
      break;
    }
  }
}

function player_continuous_rumble(localclientnum, n_rumble_level, var_10ba4a4c = 1) {
  self notify("stop_rumble_and_shake");
  self endon("disconnect");
  self endon("stop_rumble_and_shake");
  start_time = gettime();
  while((gettime() - start_time) < 120000) {
    if(isDefined(self) && self islocalplayer() && isDefined(self)) {
      switch (n_rumble_level) {
        case 1: {
          if(var_10ba4a4c) {
            self earthquake(0.2, 1, self.origin, 100);
          }
          self playrumbleonentity(localclientnum, "reload_small");
          wait(0.05);
          break;
        }
        case 2: {
          if(var_10ba4a4c) {
            self earthquake(0.3, 1, self.origin, 100);
          }
          self playrumbleonentity(localclientnum, "damage_light");
          break;
        }
        case 3: {
          if(var_10ba4a4c) {
            self earthquake(0.3, 1, self.origin, 100);
          }
          self playrumbleonentity(localclientnum, "artillery_rumble");
          break;
        }
      }
    }
    wait(0.1);
  }
}

function emit_smoke(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1: {
      self.var_c9da3e70 = playFX(localclientnum, level._effect["smoke_standard"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
      break;
    }
    case 2: {
      self.var_c9da3e70 = playFX(localclientnum, level._effect["smoke_wall"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
      break;
    }
    case 3: {
      self.var_c9da3e70 = playFX(localclientnum, level._effect["smoke_geyser"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
      break;
    }
    case 0: {
      self notify("hash_b9956414");
      if(isDefined(self.var_c9da3e70)) {
        deletefx(localclientnum, self.var_c9da3e70, 0);
      }
      break;
    }
    default: {
      assert(0, "");
      break;
    }
  }
}

function function_ed6c6bcf(localclientnum, str_fx_name, var_bec640ba) {
  self endon("hash_b9956414");
  v_forward = anglesToForward(self.angles);
  v_up = anglestoup(self.angles);
  while(true) {
    self.var_c9da3e70 = playFX(localclientnum, level._effect[str_fx_name], self.origin, v_forward, v_up);
    wait(var_bec640ba + randomfloatrange(0, 0.3));
  }
}

function fire_trap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  switch (newval) {
    case 0: {
      self function_379d49e8(localclientnum);
      break;
    }
    case 1: {
      self.var_39d354b5 = playFXOnTag(localclientnum, level._effect["fire_ground_spotfire"], self, "tag_origin");
      break;
    }
    case 2: {
      self thread function_379d49e8(localclientnum, 1);
      self.var_39d354b5 = playFXOnTag(localclientnum, level._effect["fire_ground_spotfire_smoke"], self, "tag_origin");
      break;
    }
    case 3: {
      self function_379d49e8(localclientnum);
      self.var_39d354b5 = playFXOnTag(localclientnum, level._effect["fire_moving_fire_trap"], self, "tag_origin");
      break;
    }
  }
}

function function_379d49e8(localclientnum, n_delay = 0) {
  self endon("entityshutdown");
  wait(n_delay);
  if(isDefined(self.var_39d354b5)) {
    deletefx(localclientnum, self.var_39d354b5, 0);
  }
}

function fire_trap_ignite_enemy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFXOnTag(localclientnum, level._effect["fire_ignite_zombie"], self, "J_SpineUpper");
  }
}

function function_267f859f(localclientnum, fx_id = undefined, b_on = 1, var_afcc5d76 = 0, str_tag = "tag_origin") {
  if(!isDefined(self.vfx_ref)) {
    self.vfx_ref = [];
  }
  if(b_on) {
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(self.vfx_ref[localclientnum])) {
      stopfx(localclientnum, self.vfx_ref[localclientnum]);
    }
    if(var_afcc5d76) {
      self.vfx_ref[localclientnum] = playFXOnTag(localclientnum, fx_id, self, str_tag);
    } else {
      self.vfx_ref[localclientnum] = playFX(localclientnum, fx_id, self.origin, self.angles);
    }
  } else if(isDefined(self.vfx_ref[localclientnum])) {
    stopfx(localclientnum, self.vfx_ref[localclientnum]);
    self.vfx_ref[localclientnum] = undefined;
  }
}

function rq_gateworm_magic(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_7bd93049 = playFXOnTag(localclientnum, level._effect["rq_gateworm_dissolve"], self, "tag_origin");
    self thread rq_gateworm_dissolve(localclientnum, "scriptVector2");
  } else {
    if(isDefined(self.var_7bd93049)) {
      killfx(localclientnum, self.var_1ac96e93);
    }
    playFXOnTag(localclientnum, level._effect["rq_gateworm_magic_explo"], self, "j_head_1");
  }
}

function rq_gateworm_dissolve(localclientnum, var_9304bb31) {
  self endon("entityshutdown");
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
    self mapshaderconstant(localclientnum, 0, var_9304bb31, n_shader_value, 0, 0);
    wait(0.01);
  }
}

function rq_gateworm_dissolve_finish(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread rq_gateworm_dissolve(localclientnum, "scriptVector0");
}

function rq_rune_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_fc9c3ea1 = playFXOnTag(localclientnum, level._effect["rq_rune_glow"], self, "tag_origin");
    self playSound(0, "zmb_main_searchparty_rune_appear");
    if(!isDefined(self.var_a20d5c5c)) {
      self.var_a20d5c5c = self playLoopSound("zmb_main_searchparty_rune_lp", 1);
    }
  } else {
    if(isDefined(self.n_fx)) {
      killfx(localclientnum, self.var_fc9c3ea1);
    }
    if(isDefined(self.var_a20d5c5c)) {
      self stoploopsound(self.var_a20d5c5c);
      self.var_a20d5c5c = undefined;
    }
  }
}