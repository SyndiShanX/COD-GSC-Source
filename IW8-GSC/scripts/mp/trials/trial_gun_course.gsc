/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_gun_course.gsc
**************************************************/

function init() {}

function x1ops3() {
  for(;;) {
    self waittill("power_used equip_adrenaline");

    if(istrue(self.being_revived)) {
      continue;
    }

    thread useadrenaline();
    wait 0.1;
  }
}

function useadrenaline() {
  self endon("disconnect");
  self endon("removeAdrenaline");
  self.adrenalinepoweractive = 1;
  self notify("force_regeneration");
  self refreshsprinttime();
  GscBinSkip4(0x35);
}

function removeadrenaline() {
  if(istrue(self.adrenalinepoweractive)) {
    self notify("removeAdrenaline");
    self.adrenalinepoweractive = undefined;
    return;
  }
}

function gethealthperframe() {
  return 8;
}

function adrenaline_removeonplayernotifies() {
  scripts\engine\utility::ref_143a5("death", "healed");
  thread removeadrenaline();
}

function adrenaline_removeondamage() {
  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(level.gametype == "br" && (var4 == "MOD_TRIGGER_HURT" || var4 == "MOD_UNKNOWN")) {
      continue;
    }

    thread removeadrenaline();
    return;
  }
}

function adrenaline_removeongameend() {
  level waittill("game_ended");
  thread removeadrenaline();
}