/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_target_enhancer.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

target_enhancer_think() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  angle = 10;
  cos_angle = Cos(angle);
  ads_frac = 0.5;

  while(true) {
    has_target_enhancer = false;

    attachment_list = GetWeaponAttachments(self GetCurrentWeapon());

    if(isDefined(attachment_list)) {
      foreach(attachment in attachment_list) {
        if(attachment == "opticstargetenhancer") {
          has_target_enhancer = true;
          break;
        }
      }
    }

    while(has_target_enhancer && self PlayerAds() < ads_frac) {
      wait(0.05);
    }

    if(!has_target_enhancer) {
      wait(0.05);
      continue;
    }

    if(self IsUsingTurret()) {
      wait(0.05);
      continue;
    }

    if(isDefined(self.empOn) && self.empOn) {
      waitframe();
      continue;
    }

    childthread maps\mp\_threatdetection::detection_highlight_hud_effect(self, 0.05, true);

    wait(0.05);
  }
}