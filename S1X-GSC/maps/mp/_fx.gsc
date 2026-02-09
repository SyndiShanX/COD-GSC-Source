/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_fx.gsc
***************************************************/

#include common_scripts\utility;
#include common_scripts\_fx;
#include common_scripts\_createfx;
#include maps\mp\_utility;
#include maps\mp\_createfx;

script_print_fx() {
  if((!isDefined(self.script_fxid)) || (!isDefined(self.script_fxcommand)) || (!isDefined(self.script_delay))) {
    println("Effect at origin ", self.origin, " doesn't have script_fxid/script_fxcommand/script_delay");
    self delete();
    return;
  }

  if(isDefined(self.target)) {
    org = getent(self.target).origin;
  } else {
    org = "undefined";
  }

  if(self.script_fxcommand == "OneShotfx") {
    println("maps\mp\_fx::OneShotfx(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");
  }

  if(self.script_fxcommand == "loopfx") {
    println("maps\mp\_fx::LoopFx(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");
  }

  if(self.script_fxcommand == "loopsound") {
    println("maps\mp\_fx::LoopSound(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");
  }
}

GrenadeExplosionfx(pos) {
  playFX(level._effect["mechanical explosion"], pos);
  earthquake(0.15, 0.5, pos, 250);
}

soundfx(fxId, fxPos, endonNotify) {
  org = spawn("script_origin", (0, 0, 0));
  org.origin = fxPos;
  org playLoopSound(fxId);
  if(isDefined(endonNotify)) {
    org thread soundfxDelete(endonNotify);
  }
}

soundfxDelete(endonNotify) {
  level waittill(endonNotify);
  self delete();
}

blendDelete(blend) {
  self waittill("death");
  blend delete();
}