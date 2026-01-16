/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_claw_grenade.csc
*******************************************/

main() {
  level._effect["claw_red_light"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_red_os");
  level._effect["claw_green_light"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_grn_os");
}

spawned(localclientnum) {
  player = getlocalplayer(localclientnum);
  self.fxtagname = "tag_origin";
}

loop_local_sound(localclientnum, alias, interval, fx, fx2) {
  self endon("entityshutdown");
  fxtoplay = fx;
  fusetime = 4.0;

  while(true) {
    self playsound(localclientnum, alias);
    playfxontag(localclientnum, fxtoplay, self, self.fxtagname);
    wait(interval);
    fusetime = fusetime - interval;
    interval = interval / 1.1;

    if(interval < 0.1)
      interval = 0.1;

    if(fusetime < 1.0 && fxtoplay == fx)
      fxtoplay = fx2;
  }
}