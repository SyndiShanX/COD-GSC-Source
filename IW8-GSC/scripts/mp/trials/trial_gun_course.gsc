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
  scripts\engine\utility::ref_143A5("death", "healed");
  thread removeadrenaline();
}

function adrenaline_removeondamage() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(level.gametype == "br" && (var_4 == "MOD_TRIGGER_HURT" || var_4 == "MOD_UNKNOWN")) {
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