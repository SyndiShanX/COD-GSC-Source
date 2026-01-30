/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_stock.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

stock_think() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  while(true) {
    has_stock = false;

    attachment_list = GetWeaponAttachments(self GetCurrentWeapon());

    if(isDefined(attachment_list)) {
      foreach(attachment in attachment_list) {
        if(attachment == "stock") {
          has_stock = true;
          break;
        }
      }
    }

    if(!has_stock) {
      if(self HasPerk("specialty_stalker", true)) {
        self unsetPerk("specialty_stalker", true);
      }

      wait(0.05);
      continue;
    }

    if(!self HasPerk("specialty_stalker", true)) {
      self setPerk("specialty_stalker", true, false);
    }

    wait(0.05);
  }
}