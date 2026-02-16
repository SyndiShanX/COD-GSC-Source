/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_trackrounds.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

trackrounds_think() {
  if(getDvar("mapname") == getDvar("virtualLobbyMap")) {
    return;
  }

  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  self.trackrounds = spawnStruct();
  self.trackrounds.has_paint_pro = false;
  self.trackrounds.has_trackrounds = false;

  if(self _hasPerk("specialty_paint_pro")) {
    self.trackrounds.has_paint_pro = true;
  }

  weapon = self GetCurrentWeapon();
  self toggle_has_trackrounds(weapon);

  while(true) {
    self waittill("weapon_change", weapon);

    if(weapon == "none") {
      wait 0.4;
      weapon = self GetCurrentWeapon();
      if(weapon == "none") {
        return;
      }
    }

    self toggle_has_trackrounds(weapon);

    wait 0.05;
  }
}

toggle_has_trackrounds(weapon)

{
  attachments = undefined;

  if(isDefined(weapon)) {
    attachments = GetWeaponAttachments(weapon);
  }

  if(isDefined(attachments)) {
    foreach(attachment in attachments) {
      if(attachment == "trackrounds") {
        self.trackrounds.has_trackrounds = true;
        self givePerk("specialty_paint_pro", false, false);
        return;
      }
    }

    self.trackrounds.has_trackrounds = false;

    if(!self.trackrounds.has_paint_pro) {
      self _unsetPerk("specialty_paint_pro");
    }

    return;
  }
}

set_painted_trackrounds(attacker)

{
  if(isPlayer(self)) {
    if(isDefined(self.painted_tracked) && self.painted_tracked) {
      return;
    }

    self.painted_tracked = true;

    self thread trackrounds_mark_till_death();
  }
}

trackrounds_death() {
  self endon("disconnect");
  level endon("game_ended");

  self waittill("death");

  self.painted_tracked = false;
}

trackrounds_mark_till_death() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  self thread trackrounds_death();

  while(true) {
    wait 0.1;

    if(self HasPerk("specialty_radararrow", true)) {
      continue;
    }

    if(self HasPerk("specialty_radarblip", true)) {
      continue;
    }

    self SetPerk("specialty_radarblip", true, false);
  }
}