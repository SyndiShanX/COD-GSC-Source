/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_turret.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using_animtree("mp_autoturret");
#namespace autoturret;

function autoexec __init__sytem__() {
  system::register("autoturret", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("vehicle", "auto_turret_open", 1, 1, "int", &turret_open, 0, 0);
  clientfield::register("scriptmover", "auto_turret_init", 1, 1, "int", &turret_init_anim, 0, 0);
  clientfield::register("scriptmover", "auto_turret_close", 1, 1, "int", &turret_close_anim, 0, 0);
  visionset_mgr::register_visionset_info("turret_visionset", 1, 16, undefined, "mp_vehicles_turret");
}

function turret_init_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!newval) {
    return;
  }
  self useanimtree($mp_autoturret);
  self setanimrestart( % mp_autoturret::o_turret_sentry_close, 1, 0, 1);
  self setanimtime( % mp_autoturret::o_turret_sentry_close, 1);
}

function turret_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!newval) {
    return;
  }
  self useanimtree($mp_autoturret);
  self setanimrestart( % mp_autoturret::o_turret_sentry_deploy, 1, 0, 1);
}

function turret_close_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!newval) {
    return;
  }
  self useanimtree($mp_autoturret);
  self setanimrestart( % mp_autoturret::o_turret_sentry_close, 1, 0, 1);
}