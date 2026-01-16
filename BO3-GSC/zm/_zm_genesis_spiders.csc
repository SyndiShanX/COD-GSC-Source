/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_genesis_spiders.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm;
#namespace zm_ai_spiders;

function autoexec __init__sytem__() {
  system::register("zm_ai_spiders", & __init__, & __main__, undefined);
}

function __init__() {
  level._effect["spider_round"] = "dlc2/island/fx_spider_round_tell";
  level._effect["spider_web_grenade_stuck"] = "dlc2/island/fx_web_grenade_tell";
  level._effect["spider_web_bgb_tear"] = "dlc2/island/fx_web_bgb_tearing";
  level._effect["spider_web_bgb_tear_complete"] = "dlc2/island/fx_web_bgb_reveal";
  level._effect["spider_web_perk_machine_tear"] = "dlc2/island/fx_web_perk_machine_tearing";
  level._effect["spider_web_perk_machine_tear_complete"] = "dlc2/island/fx_web_perk_machine_reveal";
  level._effect["spider_web_doorbuy_tear"] = "dlc2/island/fx_web_barrier_tearing";
  level._effect["spider_web_doorbuy_tear_complete"] = "dlc2/island/fx_web_barrier_reveal";
  level._effect["spider_web_tear_explosive"] = "dlc2/island/fx_web_impact_rocket";
  register_clientfields();
  vehicle::add_vehicletype_callback("spider", & function_7c1ef59b);
  visionset_mgr::register_visionset_info("zm_isl_parasite_spider_visionset", 9000, 16, undefined, "zm_isl_parasite_spider");
}

function __main__() {}

function register_clientfields() {
  clientfield::register("toplayer", "spider_round_fx", 9000, 1, "counter", & spider_round_fx, 0, 0);
  clientfield::register("toplayer", "spider_round_ring_fx", 9000, 1, "counter", & spider_round_ring_fx, 0, 0);
  clientfield::register("toplayer", "spider_end_of_round_reset", 9000, 1, "counter", & spider_end_of_round_reset, 0, 0);
}

function function_7c1ef59b(localclientnum) {
  self.str_tag_tesla_death_fx = "J_SpineUpper";
  self.str_tag_tesla_shock_eyes_fx = "J_SpineUpper";
}

function spider_round_fx(n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, b_demo_jump) {
  self endon("disconnect");
  setworldfogactivebank(n_local_client, 8);
  if(isspectating(n_local_client)) {
    return;
  }
  self.var_d5173f21 = playfxoncamera(n_local_client, level._effect["spider_round"]);
  playsound(0, "zmb_spider_round_webup", (0, 0, 0));
  wait(0.016);
  self thread postfx::playpostfxbundle("pstfx_parasite_spider");
  wait(3.5);
  deletefx(n_local_client, self.var_d5173f21);
}

function spider_end_of_round_reset(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    setworldfogactivebank(localclientnum, 1);
  }
}

function spider_round_ring_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("disconnect");
  if(isspectating(localclientnum)) {
    return;
  }
  self thread postfx::playpostfxbundle("pstfx_ring_loop");
  wait(1.5);
  self postfx::exitpostfxbundle();
}