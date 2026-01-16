/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_explosive_bolt.csc
*********************************************/

main() {
  level._effect["crossbow_enemy_light"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_red_os");
  level._effect["crossbow_friendly_light"] = loadfx("weapon/crossbow/fx_trail_crossbow_blink_grn_os");
  PrintLn("crossbow_enemy_light :" + level._effect["crossbow_enemy_light"]);
  PrintLn("crossbow_friendly_light :" + level._effect["crossbow_friendly_light"]);
}

spawned(localClientNum, play_sound, bool_monkey_bolt) {
  PrintLn("explosive bolt spawned");
  player = GetLocalPlayer(localClientNum);
  enemy = false;
  self.fxTagName = "tag_origin";
  if(!isDefined(bool_monkey_bolt)) {
    bool_monkey_bolt = false;
  }
  if(self.team != player.team) {
    enemy = true;
  }
  if(enemy && bool_monkey_bolt == false) {
    if(play_sound) {
      self thread loop_local_sound(localClientNum, "wpn_crossbow_alert", 0.3, level._effect["crossbow_enemy_light"]);
    } else {
      PlayFXOnTag(localClientNum, level._effect["crossbow_enemy_light"], self, self.fxTagName);
    }
  } else if(bool_monkey_bolt == true) {
    if(play_sound) {
      self thread loop_local_sound(localClientNum, "wpn_crossbow_alert", 0.3, level._effect["crossbow_enemy_light"]);
    } else {
      PlayFXOnTag(localClientNum, level._effect["crossbow_enemy_light"], self, self.fxTagName);
    }
  } else {
    if(play_sound) {
      self thread loop_local_sound(localClientNum, "wpn_crossbow_alert", 0.3, level._effect["crossbow_friendly_light"]);
    } else {
      PlayFXOnTag(localClientNum, level._effect["crossbow_friendly_light"], self, self.fxTagName);
    }
  }
}

loop_local_sound(localClientNum, alias, interval, fx) {
  self endon("entityshutdown");
  while(1) {
    self PlaySound(localClientNum, alias);
    PlayFXOnTag(localClientNum, fx, self, self.fxTagName);
    wait(interval);
    interval = (interval / 1.2);
    if(interval < .1) {
      interval = .1;
    }
  }
}