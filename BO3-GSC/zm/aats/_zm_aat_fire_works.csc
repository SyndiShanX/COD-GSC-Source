/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\aats\_zm_aat_fire_works.csc
*************************************************/

#using scripts\shared\aat_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace zm_aat_fire_works;

function autoexec __init__sytem__() {
  system::register("zm_aat_fire_works", & __init__, undefined, undefined);
}

function __init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }
  aat::register("zm_aat_fire_works", "zmui_zm_aat_fire_works", "t7_icon_zm_aat_fire_works");
  clientfield::register("scriptmover", "zm_aat_fire_works", 1, 1, "int", & zm_aat_fire_works_summon, 0, 0);
  level._effect["zm_aat_fire_works"] = "zombie/fx_aat_fireworks_zmb";
}

function zm_aat_fire_works_summon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.aat_fire_works_fx = playFX(localclientnum, "zombie/fx_aat_fireworks_zmb", self.origin, anglesToForward(self.angles));
    playSound(localclientnum, "wpn_aat_firework_explo", self.origin);
    if(isdemoplaying()) {
      self thread kill_fx_on_demo_jump(localclientnum);
    }
  } else if(isDefined(self.aat_fire_works_fx)) {
    self notify("kill_fx_on_demo_jump");
    stopfx(localclientnum, self.aat_fire_works_fx);
    self.aat_fire_works_fx = undefined;
  }
}

function kill_fx_on_demo_jump(localclientnum) {
  self notify("kill_fx_on_demo_jump");
  self endon("kill_fx_on_demo_jump");
  level waittill("demo_jump");
  if(isDefined(self.aat_fire_works_fx)) {
    stopfx(localclientnum, self.aat_fire_works_fx);
    self.aat_fire_works_fx = undefined;
  }
}