/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_players.csc
*****************************************/

#include clientscripts\mp\_utility;
#include clientscripts\_filter;

pulseSingleBullet(localClientNum) {
  lastPlayer = GetLocalPlayer(localClientNum);
  lastAmmoCount = 0;
  while(1) {
    wait 0.05;
    waitforallclients();
    player = GetLocalPlayer(localClientNum);
    if(isDefined(player) && isDefined(player.type) && (player.type == "player")) {
      newAmmoCount = GetTotalAmmo(localClientNum, "m1911_mp");
      if(newAmmoCount >= 0) {
        if(!IsSplitscreen() && isDefined(lastPlayer) && (lastPlayer == player) && (newAmmoCount > lastAmmoCount)) {
          AnimateUI(localClientNum, "ammo_counter", "last_bullet", "pulse", 0);
        }
        lastPlayer = player;
        lastAmmoCount = newAmmoCount;
      }
    } else {
      lastAmmoCount = 0;
      lastPlayer = undefined;
    }
  }
}
on_connect(localclientnum) {
  thread clientscripts\mp\_acousticsensor::init(localclientnum);
  WaitForClient(localclientnum);
  ui3dsetwindow(0, 0, 0, 1, 1);
  player = GetLocalPlayer(localClientNum);
  assert(isDefined(player));
  thread clientscripts\mp\_ambient::ceiling_fans_init(localclientnum);
  thread clientscripts\mp\_ambient::clocks_init(localclientnum);
  thread clientscripts\mp\_ambient::spin_anemometers(localclientnum);
  thread clientscripts\mp\_rotating_object::init(localclientnum);
  thread clientscripts\mp\_destructible::destructible_init(localClientNum);
  thread pulseSingleBullet(localClientNum);
  init_filter_infrared(player);
  init_filter_scope(player);
  init_filter_tvguided(player);
  if(isDefined(level.infraredVisionset)) {
    player SetInfraredVisionset(level.infraredVisionset);
  }
  if(isDefined(level.onPlayerConnect)) {
    level thread[[level.onPlayerConnect]](localclientnum);
  }
}
dtp_effects() {
  self endon("entityshutdown");
  while(true) {
    self waittill("dtp_land", localClientNum);
    localPlayer = GetLocalPlayer(localClientNum);
    if(!IsSplitscreen() && isDefined(localPlayer) && localPlayer == self) {
      if(isDefined(level.isWinter) && level.isWinter) {
        AnimateUI(localClientNum, "fullscreen_snow", "dirt", "in", 0);
      }
      else {
        AnimateUI(localClientNum, "fullscreen_dirt", "dirt", "in", 0);
      }
    }
  }
}