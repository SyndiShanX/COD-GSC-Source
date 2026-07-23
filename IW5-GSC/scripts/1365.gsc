/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1365.gsc
**************************************/

init_overheat() {
  precacheshader("hud_temperature_gauge");
}

overheat_enable(var_0) {
  if(isDefined(self.overheat)) {
    return;
  }
  self.overheat = spawnStruct();
  self.overheat.turret_heat_status = 1;
  self.overheat.overheated = 0;
  self.overheat.turret_heat_max = 114;
  self.overheat.turret_heat_rate = 1.0;
  self.overheat.turret_cool_rate = 1.0;
  self.overheat.overheat_time = 2.0;
  self.overheat.overheat_flash_time = 0.2;
  self.overheat.overheat_flash_time_increment = 0.1;
  self.overheat.gun_usage_delay_after_overheat = 2.0;
  thread create_hud();
  thread status_meter_update(var_0);
}

overheat_disable() {
  self notify("disable_overheat");
  level.savehere = undefined;
  waittillframeend;

  if(isDefined(self.overheat.overheat_bg)) {
    self.overheat.overheat_bg destroy();
  }
  if(isDefined(self.overheat.overheat_status)) {
    self.overheat.overheat_status destroy();
  }
  self.overheat = undefined;
}

status_meter_update(var_0) {
  self endon("disable_overheat");

  for(;;) {
    if(self.overheat.turret_heat_status >= self.overheat.turret_heat_max) {
      wait 0.05;
      continue;
    }

    if(self attackButtonPressed() && !self.overheat.overheated) {
      self.overheat.turret_heat_status = self.overheat.turret_heat_status + self.overheat.turret_heat_rate;
    } else {
      self.overheat.turret_heat_status = self.overheat.turret_heat_status - self.overheat.turret_cool_rate;
    }
    self.overheat.turret_heat_status = clamp(self.overheat.turret_heat_status, 1, self.overheat.turret_heat_max);
    update_overheat_meter();
    thread overheated(var_0);
    wait 0.05;
  }
}

update_overheat_meter() {
  self.overheat.overheat_status scaleovertime(0.05, 10, int(self.overheat.turret_heat_status));
  thread overheat_setcolor(self.overheat.turret_heat_status, 0.05);
}

create_hud() {
  self endon("disable_overheat");
  var_0 = 0;

  if(maps\_utility::is_coop()) {
    var_0 = 70;
  }
  var_1 = -10;
  var_2 = -152 + var_0;

  if(!isDefined(self.overheat.overheat_bg)) {
    self.overheat.overheat_bg = newclienthudelem(self);
    self.overheat.overheat_bg.alignx = "right";
    self.overheat.overheat_bg.aligny = "bottom";
    self.overheat.overheat_bg.horzalign = "right";
    self.overheat.overheat_bg.vertalign = "bottom";
    self.overheat.overheat_bg.x = 2;
    self.overheat.overheat_bg.y = -120 + var_0;
    self.overheat.overheat_bg setshader("hud_temperature_gauge", 35, 150);
    self.overheat.overheat_bg.sort = 4;
  }

  if(!isDefined(self.overheat.overheat_status)) {
    self.overheat.overheat_status = newclienthudelem(self);
    self.overheat.overheat_status.alignx = "right";
    self.overheat.overheat_status.aligny = "bottom";
    self.overheat.overheat_status.horzalign = "right";
    self.overheat.overheat_status.vertalign = "bottom";
    self.overheat.overheat_status.x = var_1;
    self.overheat.overheat_status.y = var_2;
    self.overheat.overheat_status setshader("white", 10, 1);
    self.overheat.overheat_status.color = (1, 0.9, 0);
    self.overheat.overheat_status.alpha = 1;
    self.overheat.overheat_status.sort = 1;
  }
}

overheated(var_0) {
  self endon("disable_overheat");

  if(self.overheat.turret_heat_status < self.overheat.turret_heat_max) {
    return;
  }
  if(self.overheat.overheated) {
    return;
  }
  self.overheat.overheated = 1;
  level.savehere = 0;
  thread maps\_utility::play_sound_on_entity("smokegrenade_explode_default");
  self.overheat.turret_heat_status = self.overheat.turret_heat_max;

  if(isDefined(var_0.mgturret)) {
    var_0.mgturret[0] turretfiredisable();
  }
  var_1 = gettime();
  var_2 = self.overheat.overheat_flash_time;

  for(;;) {
    self.overheat.overheat_status fadeovertime(var_2);
    self.overheat.overheat_status.alpha = 0.2;
    wait(var_2);
    self.overheat.overheat_status fadeovertime(var_2);
    self.overheat.overheat_status.alpha = 1.0;
    wait(var_2);
    var_2 = var_2 + self.overheat.overheat_flash_time_increment;

    if(gettime() - var_1 >= self.overheat.overheat_time * 1000) {
      break;
    }
  }

  self.overheat.overheat_status.alpha = 1.0;
  self.overheat.turret_heat_status = self.overheat.turret_heat_status - self.overheat.turret_cool_rate;
  wait(self.overheat.gun_usage_delay_after_overheat);

  if(isDefined(var_0.mgturret)) {
    var_0.mgturret[0] turretfireenable();
  }
  level.savehere = undefined;
  self.overheat.overheated = 0;
}

overheat_setcolor(var_0, var_1) {
  self endon("disable_overheat");
  var_2 = [];
  var_2[0] = 1.0;
  var_2[1] = 0.9;
  var_2[2] = 0.0;
  var_3 = [];
  var_3[0] = 1.0;
  var_3[1] = 0.5;
  var_3[2] = 0.0;
  var_4 = [];
  var_4[0] = 0.9;
  var_4[1] = 0.16;
  var_4[2] = 0.0;
  var_5 = [];
  var_5[0] = var_2[0];
  var_5[1] = var_2[1];
  var_5[2] = var_2[2];
  var_6 = 0;
  var_7 = self.overheat.turret_heat_max / 2;
  var_8 = self.overheat.turret_heat_max;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;

  if(var_0 > var_6 && var_0 <= var_7) {
    var_9 = int(var_0 * (100 / var_7));

    for(var_12 = 0; var_12 < var_5.size; var_12++) {
      var_10 = var_3[var_12] - var_2[var_12];
      var_11 = var_10 / 100;
      var_5[var_12] = var_2[var_12] + var_11 * var_9;
    }
  } else if(var_0 > var_7 && var_0 <= var_8) {
    var_9 = int((var_0 - var_7) * (100 / (var_8 - var_7)));

    for(var_12 = 0; var_12 < var_5.size; var_12++) {
      var_10 = var_4[var_12] - var_3[var_12];
      var_11 = var_10 / 100;
      var_5[var_12] = var_3[var_12] + var_11 * var_9;
    }
  }

  if(isDefined(var_1)) {
    self.overheat.overheat_status fadeovertime(var_1);
  }
  if(isDefined(self.overheat.overheat_status.color)) {
    self.overheat.overheat_status.color = (var_5[0], var_5[1], var_5[2]);
  }
}