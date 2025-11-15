/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_gravityspikes.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_vortex;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace _zm_weap_gravityspikes;

function autoexec __init__sytem__() {
  system::register("zm_weap_gravityspikes", & __init__, undefined, undefined);
}

function __init__(localclientnum) {
  register_clientfields();
  level._effect["gravityspikes_destroy"] = "electric/fx_elec_burst_lg_z270_os";
  level._effect["gravityspikes_location"] = "dlc1/castle/fx_weapon_gravityspike_location_glow";
  level._effect["gravityspikes_slam"] = "dlc1/zmb_weapon/fx_wpn_spike_grnd_hit";
  level._effect["gravityspikes_slam_1p"] = "dlc1/zmb_weapon/fx_wpn_spike_grnd_hit_1p";
  level._effect["gravityspikes_trap_start"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_start";
  level._effect["gravityspikes_trap_loop"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_loop";
  level._effect["gravityspikes_trap_end"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_end";
  level._effect["gravity_trap_spike_spark"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_handle_sparks";
  level._effect["zombie_sparky"] = "electric/fx_ability_elec_surge_short_robot_optim";
  level._effect["zombie_spark_light"] = "light/fx_light_spark_chest_zombie_optim";
  level._effect["zombie_spark_trail"] = "dlc1/zmb_weapon/fx_wpn_spike_torso_trail";
  level._effect["gravity_spike_zombie_explode"] = "dlc1/castle/fx_tesla_trap_body_exp";
}

function register_clientfields() {
  clientfield::register("actor", "gravity_slam_down", 1, 1, "int", & gravity_slam_down, 0, 0);
  clientfield::register("scriptmover", "gravity_trap_fx", 1, 1, "int", & gravity_trap_fx, 0, 0);
  clientfield::register("scriptmover", "gravity_trap_spike_spark", 1, 1, "int", & gravity_trap_spike_spark, 0, 0);
  clientfield::register("scriptmover", "gravity_trap_destroy", 1, 1, "counter", & gravity_trap_destroy, 0, 0);
  clientfield::register("scriptmover", "gravity_trap_location", 1, 1, "int", & gravity_trap_location, 0, 0);
  clientfield::register("scriptmover", "gravity_slam_fx", 1, 1, "int", & gravity_slam_fx, 0, 0);
  clientfield::register("toplayer", "gravity_slam_player_fx", 1, 1, "counter", & gravity_slam_player_fx, 0, 0);
  clientfield::register("actor", "sparky_beam_fx", 1, 1, "int", & play_sparky_beam_fx, 0, 0);
  clientfield::register("actor", "sparky_zombie_fx", 1, 1, "int", & sparky_zombie_fx_cb, 0, 0);
  clientfield::register("actor", "sparky_zombie_trail_fx", 1, 1, "int", & sparky_zombie_trail_fx_cb, 0, 0);
  clientfield::register("toplayer", "gravity_trap_rumble", 1, 1, "int", & gravity_trap_rumble_callback, 0, 0);
  clientfield::register("actor", "ragdoll_impact_watch", 1, 1, "int", & ragdoll_impact_watch_start, 0, 0);
  clientfield::register("actor", "gravity_spike_zombie_explode_fx", 12000, 1, "counter", & gravity_spike_zombie_explode, 1, 0);
}

function gravity_slam_down(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self launchragdoll(vectorscale((0, 0, -1), 200));
  }
}

function gravity_slam_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(self.slam_fx)) {
      deletefx(localclientnum, self.slam_fx, 1);
    }
    playFXOnTag(localclientnum, level._effect["gravityspikes_slam"], self, "tag_origin");
  }
}

function gravity_slam_player_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playfxoncamera(localclientnum, level._effect["gravityspikes_slam_1p"]);
}

function gravity_trap_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.b_gravity_trap_fx = 1;
    if(!isDefined(level.a_mdl_gravity_traps)) {
      level.a_mdl_gravity_traps = [];
    }
    if(!isinarray(level.a_mdl_gravity_traps, self)) {
      if(!isDefined(level.a_mdl_gravity_traps)) {
        level.a_mdl_gravity_traps = [];
      } else if(!isarray(level.a_mdl_gravity_traps)) {
        level.a_mdl_gravity_traps = array(level.a_mdl_gravity_traps);
      }
      level.a_mdl_gravity_traps[level.a_mdl_gravity_traps.size] = self;
    }
    playFXOnTag(localclientnum, level._effect["gravityspikes_trap_start"], self, "tag_origin");
    wait(0.5);
    if(isDefined(self.b_gravity_trap_fx) && self.b_gravity_trap_fx) {
      self.n_gravity_trap_fx = playFXOnTag(localclientnum, level._effect["gravityspikes_trap_loop"], self, "tag_origin");
    }
  } else {
    self.b_gravity_trap_fx = undefined;
    if(isDefined(self.n_gravity_trap_fx)) {
      deletefx(localclientnum, self.n_gravity_trap_fx, 1);
      self.n_gravity_trap_fx = undefined;
    }
    arrayremovevalue(level.a_mdl_gravity_traps, self);
    playFXOnTag(localclientnum, level._effect["gravityspikes_trap_end"], self, "tag_origin");
  }
}

function gravity_trap_spike_spark(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.spark_fx_id = playFXOnTag(localclientnum, level._effect["gravity_trap_spike_spark"], self, "tag_origin");
  } else if(isDefined(self.spark_fx_id)) {
    deletefx(localclientnum, self.spark_fx_id, 1);
  }
}

function gravity_trap_location(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.fx_id_location = playFXOnTag(localclientnum, level._effect["gravityspikes_location"], self, "tag_origin");
  } else if(isDefined(self.fx_id_location)) {
    deletefx(localclientnum, self.fx_id_location, 1);
    self.fx_id_location = undefined;
  }
}

function gravity_trap_destroy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(localclientnum, level._effect["gravityspikes_destroy"], self.origin);
}

function ragdoll_impact_watch_start(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self thread ragdoll_impact_watch(localclientnum);
  }
}

function ragdoll_impact_watch(localclientnum) {
  self endon("entityshutdown");
  self.v_start_pos = self.origin;
  n_wait_time = 0.05;
  n_gib_speed = 20;
  v_prev_origin = self.origin;
  waitrealtime(n_wait_time);
  v_prev_vel = self.origin - v_prev_origin;
  n_prev_speed = length(v_prev_vel);
  v_prev_origin = self.origin;
  waitrealtime(n_wait_time);
  b_first_loop = 1;
  while(true) {
    v_vel = self.origin - v_prev_origin;
    n_speed = length(v_vel);
    if(n_speed < (n_prev_speed * 0.5) && n_speed <= n_gib_speed && !b_first_loop) {
      if(self.origin[2] > (self.v_start_pos[2] + 128)) {
        if(isDefined(level._effect["zombie_guts_explosion"]) && util::is_mature()) {
          playFX(localclientnum, level._effect["zombie_guts_explosion"], self.origin, anglesToForward(self.angles));
        }
        self hide();
      }
      break;
    }
    v_prev_origin = self.origin;
    n_prev_speed = n_speed;
    b_first_loop = 0;
    waitrealtime(n_wait_time);
  }
}

function gravity_trap_rumble_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread gravity_trap_rumble(localclientnum);
  } else {
    self notify("vortex_stop");
  }
}

function gravity_trap_rumble(localclientnum) {
  level endon("demo_jump");
  self endon("vortex_stop");
  self endon("death");
  while(isDefined(self)) {
    self playrumbleonentity(localclientnum, "zod_idgun_vortex_interior");
    wait(0.075);
  }
}

function play_sparky_beam_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    ai_zombie = self;
    a_sparky_tags = array("J_Spine4", "J_SpineUpper", "J_Spine1");
    str_tag = array::random(a_sparky_tags);
    if(isDefined(level.a_mdl_gravity_traps)) {
      mdl_gravity_trap = arraygetclosest(self.origin, level.a_mdl_gravity_traps);
    }
    if(isDefined(mdl_gravity_trap)) {
      self.e_sparky_beam = beamlaunch(localclientnum, mdl_gravity_trap, "tag_origin", ai_zombie, str_tag, "electric_arc_sm_tesla_beam_pap");
    }
  } else if(isDefined(self.e_sparky_beam)) {
    beamkill(localclientnum, self.e_sparky_beam);
  }
}

function sparky_zombie_fx_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(!isDefined(self.sparky_loop_snd)) {
      self.sparky_loop_snd = self playLoopSound("zmb_electrozomb_lp", 0.2);
    }
    self.n_sparky_fx = playFXOnTag(localclientnum, level._effect["zombie_sparky"], self, "J_SpineUpper");
    setfxignorepause(localclientnum, self.n_sparky_fx, 1);
    self.n_sparky_fx = playFXOnTag(localclientnum, level._effect["zombie_spark_light"], self, "J_SpineUpper");
    setfxignorepause(localclientnum, self.n_sparky_fx, 1);
  } else {
    if(isDefined(self.n_sparky_fx)) {
      deletefx(localclientnum, self.n_sparky_fx, 1);
    }
    self.n_sparky_fx = undefined;
  }
}

function sparky_zombie_trail_fx_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.n_trail_fx = playFXOnTag(localclientnum, level._effect["zombie_spark_trail"], self, "J_SpineUpper");
    setfxignorepause(localclientnum, self.n_trail_fx, 1);
  } else {
    if(isDefined(self.n_trail_fx)) {
      deletefx(localclientnum, self.n_trail_fx, 1);
    }
    self.n_trail_fx = undefined;
  }
}

function gravity_spike_zombie_explode(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  playFXOnTag(localclientnum, level._effect["gravity_spike_zombie_explode"], self, "j_spine4");
}