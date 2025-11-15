/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_deadshot.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_perks;
#namespace zm_perk_deadshot;

function autoexec __init__sytem__() {
  system::register("zm_perk_deadshot", & __init__, undefined, undefined);
}

function __init__() {
  enable_deadshot_perk_for_level();
}

function enable_deadshot_perk_for_level() {
  zm_perks::register_perk_clientfields("specialty_deadshot", & deadshot_client_field_func, & deadshot_code_callback_func);
  zm_perks::register_perk_effects("specialty_deadshot", "deadshot_light");
  zm_perks::register_perk_init_thread("specialty_deadshot", & init_deadshot);
}

function init_deadshot() {
  if(isDefined(level.enable_magic) && level.enable_magic) {
    level._effect["deadshot_light"] = "_t6/misc/fx_zombie_cola_dtap_on";
  }
}

function deadshot_client_field_func() {
  clientfield::register("toplayer", "deadshot_perk", 1, 1, "int", & player_deadshot_perk_handler, 0, 1);
  clientfield::register("clientuimodel", "hudItems.perks.dead_shot", 1, 2, "int", undefined, 0, 1);
}

function deadshot_code_callback_func() {}

function player_deadshot_perk_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer() || isspectating(localclientnum, 0) || (isDefined(level.localplayers[localclientnum]) && self getentitynumber() != level.localplayers[localclientnum] getentitynumber())) {
    return;
  }
  if(newval) {
    self usealternateaimparams();
  } else {
    self clearalternateaimparams();
  }
}