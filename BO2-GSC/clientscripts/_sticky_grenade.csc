/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_sticky_grenade.csc
*********************************************/

#include clientscripts\_utility;

main() {
  level._effect["grenade_enemy_light"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_red_os");
  level._effect["grenade_friendly_light"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_grn_os");
}

spawned(localclientnum, play_sound) {
  self endon("entityshutdown");
  player = getlocalplayer(localclientnum);
  enemy = 0;
  self.fxtagname = "tag_fx";

  if(self.team != player.team)
    enemy = 1;

  if(enemy) {
    if(play_sound)
      self thread loop_local_sound(localclientnum, "wpn_semtex_alert", 0.3, level._effect["grenade_enemy_light"]);
    else
      playfxontag(localclientnum, level._effect["grenade_enemy_light"], self, self.fxtagname);
  } else if(play_sound)
    self thread loop_local_sound(localclientnum, "wpn_semtex_alert", 0.3, level._effect["grenade_friendly_light"]);
  else
    playfxontag(localclientnum, level._effect["grenade_friendly_light"], self, self.fxtagname);
}

loop_local_sound(localclientnum, alias, interval, fx) {
  self endon("entityshutdown");

  while(true) {
    self playsound(localclientnum, alias);
    playfxontag(localclientnum, fx, self, self.fxtagname);
    wait(interval);
    interval = interval / 1.2;

    if(interval < 0.1)
      interval = 0.1;
  }
}