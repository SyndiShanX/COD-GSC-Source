/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_transformer.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_altbody_beast;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using_animtree("generic");
#namespace zm_zod_transformer;

function autoexec __init__sytem__() {
  system::register("zm_zod_transformer", undefined, &__main__, undefined);
}

function __main__() {
  n_bits = getminbitcountfornum(16);
  clientfield::register("scriptmover", "transformer_light_switch", 1, n_bits, "int");
  level thread init_transformers();
}

function init_transformers() {
  level flag::wait_till("all_players_spawned");
  level flag::wait_till("zones_initialized");
  var_38d937f = getEntArray("use_elec_switch", "targetname");
  foreach(var_b46b59df in var_38d937f) {
    var_677edb82 = getent(var_b46b59df.target, "targetname");
    var_677edb82 thread transformer_think(var_b46b59df);
    wait(0.05);
  }
}

function transformer_think(var_b46b59df) {
  assert(isDefined(self.script_int), "" + self.origin);
  n_power_index = self.script_int;
  self thread zm_altbody_beast::watch_lightning_damage(var_b46b59df);
  self clientfield::set("bminteract", 2);
  level flag::wait_till("power_on" + n_power_index);
  self thread scene::play("p7_fxanim_zm_zod_power_box_bundle", self);
  self clientfield::set("transformer_light_switch", n_power_index);
  self playSound("zmb_bm_interaction_machine_start");
  self playLoopSound("zmb_bm_interaction_machine_loop", 2);
  self clientfield::set("bminteract", 0);
}