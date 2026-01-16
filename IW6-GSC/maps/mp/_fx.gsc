/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_fx.gsc
*****************************************************/

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

  if(isDefined(self.target))
    org = getent(self.target).origin;
  else
    org = "undefined";

  if(self.script_fxcommand == "OneShotfx")
    println("maps\mp\_fx::OneShotfx(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");

  if(self.script_fxcommand == "loopfx")
    println("maps\mp\_fx::LoopFx(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");

  if(self.script_fxcommand == "loopsound")
    println("maps\mp\_fx::LoopSound(\"" + self.script_fxid + "\", " + self.origin + ", " + self.script_delay + ", " + org + ");");
}

GrenadeExplosionfx(pos) {
  playFX(level._effect["mechanical explosion"], pos);
  earthquake(0.15, 0.5, pos, 250);
}

soundfx(fxId, fxPos, endonNotify) {
  org = spawn("script_origin", (0, 0, 0));
  org.origin = fxPos;
  org playLoopSound(fxId);
  if(isDefined(endonNotify))
    org thread soundfxDelete(endonNotify);
}

soundfxDelete(endonNotify) {
  level waittill(endonNotify);
  self delete();
}

func_glass_handler() {
  funcglass_indexies = [];
  funcglass_decals = [];
  temp_decals = getEntArray("vfx_custom_glass", "targetname");
  foreach(decal in temp_decals) {
    if(isDefined(decal.script_noteworthy)) {
      attached_glass = GetGlass(decal.script_noteworthy);
      if(isDefined(attached_glass)) {
        funcglass_decals[attached_glass] = decal;
        funcglass_indexies[funcglass_indexies.size] = attached_glass;
      }
    }
  }
  funcglass_alive_count = funcglass_indexies.size;
  funcglass_count = funcglass_indexies.size;

  max_iterations = 5;
  current_index = 0;
  while(funcglass_alive_count != 0) {
    max_index = current_index + max_iterations - 1;
    if(max_index > funcglass_count)
      max_index = funcglass_count;
    if(current_index == funcglass_count)
      current_index = 0;
    for(; current_index < max_index; current_index++) {
      glass_index = funcglass_indexies[current_index];
      decal = funcglass_decals[glass_index];

      if(isDefined(decal)) {
        if(IsGlassDestroyed(glass_index)) {
          decal delete();
          funcglass_alive_count--;
          funcglass_decals[glass_index] = undefined;
        }
      }
    }
    wait(.05);
  }
}

blendDelete(blend) {
  self waittill("death");
  blend delete();
}