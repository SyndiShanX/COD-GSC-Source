/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_fastheal.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_hostmigration;
#include maps\mp\perks\_perkfunctions;

CONST_EXO_REGEN_DURATION = 10;

watchFastHealUsage() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  if(!isDefined(level.fastHealSettings)) {
    FastHealInit();
  }

  while(1) {
    self waittill("grenade_fire", grenade, weapname);
    if(weapname == "fast_heal_mp") {
      if(!IsAlive(self)) {
        grenade delete();
        return;
      }

      thread tryUseFastHeal();
    }
  }
}

FastHealInit() {
  self.fastHealSettings = spawnStruct();
}

tryUseFastHeal() {
  if(!isDefined(self.fastHealSettings)) {
    FastHealInit();
  }

  ResetFastHeal();
  thread StartFastHeal();
  thread MonitorPlayerDeath();

  return true;
}

StartFastHeal() {
  self endon("ClearFastHeal");
  self endon("death");

  self playLocalSound("earn_superbonus");

  self.fastHealSettings.overlay = NewClientHudElem(self);
  self.fastHealSettings.overlay.x = 0;
  self.fastHealSettings.overlay.y = 0;
  self.fastHealSettings.overlay.horzAlign = "fullscreen";
  self.fastHealSettings.overlay.vertAlign = "fullscreen";
  self.fastHealSettings.overlay SetShader("exo_hud_cloak_overlay", 640, 480);
  self.fastHealSettings.overlay.archive = true;
  self.fastHealSettings.overlay.alpha = 1.0;

  self.IsFastHeal = true;
  self.ignoreRegenDelay = true;

  self.healthRegenLevel = .99;
  self notify("damage");

  wait CONST_EXO_REGEN_DURATION;

  self.healthRegenLevel = undefined;

  self.IsFastHeal = false;

  if(isDefined(self.fastHealSettings.overlay)) {
    self.fastHealSettings.overlay Destroy();
  }

  self notify("EndFastHeal");
}

ResetFastHeal() {
  if(isDefined(self.IsFastHeal) && self.IsFastHeal == true) {
    if(isDefined(self.fastHealSettings.overlay)) {
      self.fastHealSettings.overlay Destroy();
    }

    self.healthRegenLevel = undefined;
    self notify("ClearFastHeal");
  }
}

MonitorPlayerDeath() {
  self endon("EndFastHeal");

  self waittill("death");

  self.healthRegenLevel = undefined;
  self.IsFastHeal = false;

  if(isDefined(self.fastHealSettings.overlay)) {
    self.fastHealSettings.overlay Destroy();
  }
}

PrintHealthToScreen() {
  self endon("EndFastHeal");
  self endon("death");

  while(true) {
    IPrintLnBold(self.health);
    wait 1;
  }
}