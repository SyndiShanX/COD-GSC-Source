/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\anim\death.gsc
***********************************************/

#using scripts\anim\combat_utility;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace death;

function init_deathfx() {
  add_fx("deathfx_bloodpool_generic", "vfx/iw8/char/blood/vfx_deathfx_bloodpool_01.vfx");
}

function main() {
  self endon("killanimscript");
  self waittill("hellfreezesover");
}

function doimmediateragdolldeath() {
  assertmsg("use the new one in asm/shared/death.gsc");
}

function play_blood_pool(note, flagname) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.skipbloodpool)) {
    assertex(self.skipbloodpool, "Setting must be either true or undefined");
    return;
  }

  tagpos = self gettagorigin("j_SpineUpper");
  tagangles = self gettagangles("j_SpineUpper");
  forward = anglesToForward(tagangles);
  up = anglestoup(tagangles);
  right = anglestoright(tagangles);
  tagpos = tagpos + forward * -8.5 + up * 5 + right * 0;
  trace = scripts\engine\trace::_bullet_trace(tagpos + (0, 0, 30), tagpos - (0, 0, 100), 0, undefined);

  if(trace["normal"][2] > 0.9) {
    playFX(level._effect["deathfx_bloodpool_generic"], tagpos);
  }
}