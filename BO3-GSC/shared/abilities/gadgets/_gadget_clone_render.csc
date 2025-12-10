/*************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_clone_render.csc
*************************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\system_shared;
#namespace _gadget_clone_render;

function autoexec __init__sytem__() {
  system::register("gadget_clone_render", &__init__, undefined, undefined);
}

function __init__() {
  duplicate_render::set_dr_filter_framebuffer("clone_ally", 90, "clone_ally_on", "clone_damage", 0, "mc/ability_clone_ally", 0);
  duplicate_render::set_dr_filter_framebuffer("clone_enemy", 90, "clone_enemy_on", "clone_damage", 0, "mc/ability_clone_enemy", 0);
  duplicate_render::set_dr_filter_framebuffer("clone_damage_ally", 90, "clone_ally_on,clone_damage", undefined, 0, "mc/ability_clone_ally_damage", 0);
  duplicate_render::set_dr_filter_framebuffer("clone_damage_enemy", 90, "clone_enemy_on,clone_damage", undefined, 0, "mc/ability_clone_enemy_damage", 0);
}

#namespace gadget_clone_render;

function transition_shader(localclientnum) {
  self endon("entityshutdown");
  self endon("clone_shader_off");
  rampinshader = 0;
  while(rampinshader < 1) {
    if(isDefined(self)) {
      self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, rampinshader, 0, 0.04);
    }
    rampinshader = rampinshader + 0.04;
    wait(0.016);
  }
}