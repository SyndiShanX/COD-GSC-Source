/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42840.gsc
**************************************/

trackrounds_think() {
  if(getDvar("mapname") == getDvar("virtualLobbyMap")) {
    return;
  }
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.trackrounds = spawnStruct();
  self.trackrounds.has_paint_pro = 0;
  self.trackrounds.has_trackrounds = 0;

  if(maps\mp\_utility::_hasperk("specialty_paint_pro")) {
    self.trackrounds.has_paint_pro = 1;
  }

  var_0 = self getcurrentweapon();
  toggle_has_trackrounds(var_0);

  for(;;) {
    self waittill("weapon_change", var_0);

    if(var_0 == "none") {
      wait 0.4;
      var_0 = self getcurrentweapon();

      if(var_0 == "none") {
        return;
      }
    }

    toggle_has_trackrounds(var_0);
    wait 0.05;
  }
}

toggle_has_trackrounds(var_0) {
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_1 = getweaponattachments(var_0);
  }

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(var_3 == "trackrounds") {
        self.trackrounds.has_trackrounds = 1;
        maps\mp\_utility::giveperk("specialty_paint_pro", 0, 0);
        return;
      }
    }

    self.trackrounds.has_trackrounds = 0;

    if(!self.trackrounds.has_paint_pro) {
      maps\mp\_utility::_unsetperk("specialty_paint_pro");
    }

    return;
  }
}

set_painted_trackrounds(var_0) {
  if(isPlayer(self)) {
    if(isDefined(self.painted_tracked) && self.painted_tracked) {
      return;
    }
    self.painted_tracked = 1;
    thread trackrounds_mark_till_death();
  }
}

trackrounds_death() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self.painted_tracked = 0;
}

trackrounds_mark_till_death() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  thread trackrounds_death();

  for(;;) {
    wait 0.1;

    if(self hasperk("specialty_radararrow", 1)) {
      continue;
    }
    if(self hasperk("specialty_radarblip", 1)) {
      continue;
    }
    self setperk("specialty_radarblip", 1, 0);
  }
}