/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_opticsthermal.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

opticsthermal_think() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  if(IsAgent(self)) {
    return;
  }

  ads_frac = 0.65;

  self.opticsThermalEnabled = false;
  self.orbitalThermalMode = false;

  while(true) {
    has_opticsthermal = false;

    attachment_list = GetWeaponAttachments(self GetCurrentWeapon());

    if(isDefined(attachment_list)) {
      foreach(attachment in attachment_list) {
        if(isSubStr(attachment, "opticsthermal")) {
          has_opticsthermal = true;
          break;
        }
      }
    }

    disable_opticsthermal = !has_opticsthermal;
    disable_opticsthermal |= (has_opticsthermal && (self PlayerAds() < ads_frac));
    disable_opticsthermal |= (self IsUsingTurret());
    disable_opticsthermal |= (self.orbitalThermalMode);

    if(disable_opticsthermal) {
      opticsthermal_blur_off(self);
    } else {
      opticsthermal_blur(self, 0.05);
    }

    wait(0.05);
  }
}

opticsthermal_blur(player, duration) {
  if(player.opticsThermalEnabled) {
    return;
  }

  player EnablePhysicalDepthOfFieldScripting(3);
  player SetPhysicalDepthOfField(70, 0, 40, 80);
  player.opticsThermalEnabled = true;
}

opticsthermal_blur_off(player) {
  if(!player.opticsThermalEnabled) {
    return;
  }

  player DisablePhysicalDepthOfFieldScripting();
  player.opticsThermalEnabled = false;
}