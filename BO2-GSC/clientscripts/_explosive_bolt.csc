/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_explosive_bolt.csc
*********************************************/

main() {
  level._effect["crossbow_enemy_light"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_red_os");
  level._effect["crossbow_friendly_light"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_grn_os");

  println("crossbow_enemy_light :" + level._effect["crossbow_enemy_light"]);
  println("crossbow_friendly_light :" + level._effect["crossbow_friendly_light"]);
}

spawned(localclientnum, play_sound, bool_monkey_bolt) {
  println("explosive bolt spawned");

  player = getlocalplayer(localclientnum);
  enemy = 0;
  self.fxtagname = "tag_origin";

  if(!isDefined(bool_monkey_bolt))
    bool_monkey_bolt = 0;

  if(self.team != player.team)
    enemy = 1;

  if(enemy && bool_monkey_bolt == 0) {
    if(play_sound)
      self thread loop_local_sound(localclientnum, "wpn_crossbow_alert", 0.3, level._effect["crossbow_enemy_light"]);
    else
      playfxontag(localclientnum, level._effect["crossbow_enemy_light"], self, self.fxtagname);
  } else if(bool_monkey_bolt == 1) {
    if(play_sound)
      self thread loop_local_sound(localclientnum, "wpn_crossbow_alert", 0.3, level._effect["crossbow_enemy_light"]);
    else
      playfxontag(localclientnum, level._effect["crossbow_enemy_light"], self, self.fxtagname);
  } else if(play_sound)
    self thread loop_local_sound(localclientnum, "wpn_crossbow_alert", 0.3, level._effect["crossbow_friendly_light"]);
  else
    playfxontag(localclientnum, level._effect["crossbow_friendly_light"], self, self.fxtagname);
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