/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\load_shared.csc
*************************************************/

#using scripts\shared\_explode;
#using scripts\shared\blood;
#using scripts\shared\drown;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\fx_shared;
#using scripts\shared\player_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\water_surface;
#using scripts\shared\weapons\_empgrenade;
#using scripts\shared\weapons_shared;
#namespace load;

function autoexec __init__sytem__() {
  system::register("load", &__init__, undefined, undefined);
}

function __init__() {
  level thread first_frame();
  init_push_out_threshold();
}

function first_frame() {
  level.first_frame = 1;
  wait(0.05);
  level.first_frame = undefined;
}

function init_push_out_threshold() {
  push_out_threshold = getdvarfloat("tu16_physicsPushOutThreshold", -1);
  if(push_out_threshold != -1) {
    setdvar("tu16_physicsPushOutThreshold", 20);
  }
}

function art_review() {
  if(getdvarstring("art_review") == "") {
    setdvar("art_review", "0");
  }
  if(getdvarstring("art_review") == "1") {
    level waittill("forever");
  }
}