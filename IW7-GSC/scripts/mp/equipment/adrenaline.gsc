/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\adrenaline.gsc
***********************************************/

init() {}

useadrenaline() {
  self endon("disconnect");
  self endon("removeAdrenaline");
  self notify("adrenaline_used");
  self notify("force_regeneration");
  self playlocalsound("mp_adrenaline_on");
  self playsoundtoteam("mp_adrenaline_on_npc", "axis", self);
  self playsoundtoteam("mp_adrenaline_on_npc", "allies", self);
  self playlocalsound("mp_adrenaline_pulse");
  if(self.health < self.maxhealth) {
    scripts\mp\missions::func_D991("ch_tactical_adrenaline");
  } else {
    self.usedadrenalineatfullhp = 1;
    thread func_40E0();
  }

  self.var_8BC2 = 1;
  scripts\mp\utility::giveperk("specialty_adrenaline");
  thread func_E0C4();
  thread func_E0C6();
  thread func_E0C3();
  thread func_13A85();
  var_00 = scripts\mp\powerloot::func_7FC1("power_adrenaline", 5);
  scripts\mp\powers::func_4575(var_00, "power_adrenaline_update", "removeAdrenaline");
  thread removeadrenaline();
}

removeadrenaline(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "";
  }

  if(isDefined(self.var_8BC2) && self.var_8BC2) {
    self notify("removeAdrenaline");
    self.var_8BC2 = 0;
    scripts\mp\utility::removeperk("specialty_adrenaline");
    self setscriptablepartstate("adrenaline", "neutral", 0);
    self setscriptablepartstate("adrenalineHeal", "neutral", 0);
    if(param_00 != "death") {
      self playlocalsound("mp_adrenaline_off");
    }
  }
}

func_E0C4() {
  self endon("disconnect");
  self endon("removeAdrenaline");
  self notify("removeAdrenalineOnDeath");
  self endon("removeAdrenalineOnDeath");
  self waittill("death");
  thread removeadrenaline("death");
}

func_E0C6() {
  self endon("disconnect");
  self endon("removeAdrenaline");
  self notify("removeAdrenalineOnGameEnd");
  self endon("removeAdrenalineOnGameEnd");
  level waittill("game_ended");
  thread removeadrenaline();
}

func_E0C3() {
  self endon("disconnect");
  self endon("removeAdrenaline");
  self notify("removeAdrenalineOnCancel");
  self endon("removeAdrenalineOnCancel");
  self waittill("cancelAdrenaline");
  thread removeadrenaline();
}

func_40E0() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("cleanupAdrenalineMissionTracking");
  self endon("cleanupAdrenalineMissionTracking");
  self waittill("death");
  self.usedadrenalineatfullhp = undefined;
}

func_7EF5() {
  return 4;
}

func_13A85() {
  self endon("disconnect");
  self endon("removeAdrenaline");
  self setscriptablepartstate("adrenaline", "active", 0);
  self setscriptablepartstate("adrenalineHeal", "active", 0);
}