/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_traps.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using_animtree("generic");
#namespace zm_zod_traps;

function autoexec __init__sytem__() {
  system::register("zm_zod_traps", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "trap_chain_state", 1, 2, "int", & update_chain_anims, 0, 0);
  clientfield::register("scriptmover", "trap_chain_location", 1, 2, "int", & location_func, 0, 0);
}

function update_chain_anims(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_str_areaname = [];
  a_str_areaname[0] = "theater";
  a_str_areaname[1] = "slums";
  a_str_areaname[2] = "canals";
  a_str_areaname[3] = "pap";
  int_location = self clientfield::get("trap_chain_location");
  str_areaname = a_str_areaname[int_location];
  a_mdl_chain_active = getEntArray(localclientnum, "fxanim_chain_trap", "targetname");
  a_mdl_chain_active = array::filter(a_mdl_chain_active, 0, & filter_areaname, str_areaname);
  if(a_mdl_chain_active.size > 0) {
    array::thread_all(a_mdl_chain_active, & update_active_chain_anims, localclientnum, oldval, newval, bnewent, binitialsnap, fieldname);
  }
}

function location_func(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function filter_areaname(e_entity, str_areaname) {
  if(e_entity.script_noteworthy !== str_areaname) {
    return false;
  }
  return true;
}

function update_active_chain_anims(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("update_active_chain_anims");
  self endon("update_active_chain_anims");
  mdl_chains_active = self;
  mdl_chains_active util::waittill_dobj(localclientnum);
  switch (newval) {
    case 0: {
      self thread scene_play("p7_fxanim_zm_zod_chain_trap_symbol_off_bundle", self);
      break;
    }
    case 1: {
      mdl_chains_active show();
      scene::stop("p7_fxanim_zm_zod_chain_trap_symbol_off_bundle");
      self thread scene_play("p7_fxanim_zm_zod_chain_trap_symbol_on_bundle", self);
      break;
    }
    case 2: {
      self scene::stop();
      mdl_chains_active thread function_a89bd6f9();
      break;
    }
    case 3: {
      while(isDefined(self.trap_active)) {
        wait(0.01);
      }
      self thread scene_play("p7_fxanim_zm_zod_chain_trap_symbol_off_bundle", self);
      break;
    }
  }
}

function scene_play(scene, var_165d49f6) {
  self notify("scene_play");
  self endon("scene_play");
  self scene::stop();
  self function_6221b6b9(scene, var_165d49f6);
  self scene::stop();
}

function function_6221b6b9(scene, var_165d49f6) {
  level endon("demo_jump");
  self scene::play(scene, var_165d49f6);
}

function function_a89bd6f9() {
  self.trap_active = 1;
  self stopallloopsounds();
  self playSound(0, "evt_chaintrap_start");
  self playLoopSound("evt_chaintrap_loop", 0.5);
  scene::stop("p7_fxanim_zm_zod_chain_trap_symbol_on_bundle");
  function_3f7430db();
  scene::play(self.var_b33065b0, self);
  self thread scene::play(self.var_68a0b25, self);
  n_start_time = getanimlength(self.var_b33065b0);
  var_b13eaf00 = getanimlength(self.var_aec39a66);
  n_time = 15;
  wait(n_time);
  scene::stop(self.var_68a0b25);
  scene::play(self.var_aec39a66, self);
  self thread scene::play("p7_fxanim_zm_zod_chain_trap_symbol_off_bundle", self);
  self stopallloopsounds(0.5);
  self playLoopSound("evt_chaintrap_idle");
  self.trap_active = undefined;
}

function function_3f7430db() {
  switch (self.script_noteworthy) {
    case "pap": {
      self.var_b33065b0 = "p7_fxanim_zm_zod_chain_trap_pap_start_bundle";
      self.var_68a0b25 = "p7_fxanim_zm_zod_chain_trap_pap_on_bundle";
      self.var_aec39a66 = "p7_fxanim_zm_zod_chain_trap_pap_end_bundle";
      break;
    }
    case "canals": {
      self.var_b33065b0 = "p7_fxanim_zm_zod_chain_trap_canal_start_bundle";
      self.var_68a0b25 = "p7_fxanim_zm_zod_chain_trap_canal_on_bundle";
      self.var_aec39a66 = "p7_fxanim_zm_zod_chain_trap_canal_end_bundle";
      break;
    }
    case "slums": {
      self.var_b33065b0 = "p7_fxanim_zm_zod_chain_trap_waterfront_start_bundle";
      self.var_68a0b25 = "p7_fxanim_zm_zod_chain_trap_waterfront_on_bundle";
      self.var_aec39a66 = "p7_fxanim_zm_zod_chain_trap_waterfront_end_bundle";
      break;
    }
    case "theater":
    default: {
      self.var_b33065b0 = "p7_fxanim_zm_zod_chain_trap_footlight_start_bundle";
      self.var_68a0b25 = "p7_fxanim_zm_zod_chain_trap_footlight_on_bundle";
      self.var_aec39a66 = "p7_fxanim_zm_zod_chain_trap_footlight_end_bundle";
      break;
    }
  }
}