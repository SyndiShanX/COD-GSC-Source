/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42806.gsc
**************************************/

getgroundslamminheight() {
  return 120;
}

getgroundslammaxheight() {
  return 380;
}

getgroundslammindamage() {
  return 50;
}

getgroundslammaxdamage() {
  return 110;
}

getgroundslamminradius() {
  return 75;
}

getgroundslammaxradius() {
  return 125;
}

init() {
  level._effect["exo_slam_kneeslide_fx"] = loadfx("vfx/code/slam_jetpack_kneeslide");
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread monitorgroundslam();
    var_0 thread monitorgroundslamhitplayer();
  }
}

monitorgroundslam() {
  self endon("disconnect");
  var_0 = 10;
  var_1 = 4;
  var_2 = (1, 0, 0);
  var_3 = (0, 1, 0);
  var_4 = (0, 0, 1);
  var_5 = 16;

  for(;;) {
    self waittill("ground_slam", var_6);

    if(isDefined(level.groundslam) && self[[level.groundslam]](var_6)) {
      continue;
    }
    var_7 = getdvarfloat("ground_slam_min_height", getgroundslamminheight());
    var_8 = getdvarfloat("ground_slam_max_height", getgroundslammaxheight());
    var_9 = getdvarfloat("ground_slam_min_damage", getgroundslammindamage());
    var_10 = getdvarfloat("ground_slam_max_damage", getgroundslammaxdamage());
    var_11 = getdvarfloat("ground_slam_min_radius", getgroundslamminradius());
    var_12 = getdvarfloat("ground_slam_max_radius", getgroundslammaxradius());

    if(var_6 < var_7) {
      continue;
    }
    var_13 = (var_6 - var_7) / (var_8 - var_7);
    var_13 = clamp(var_13, 0.0, 1.0);
    var_14 = (var_12 - var_11) * var_13 + var_11;
    var_15 = var_14 + 60;
    var_16 = var_15 * var_15;
    self radiusdamage(self.origin, var_14, var_10, var_9, self, "MOD_TRIGGER_HURT", "boost_slam_mp");

    if(maps\mp\_utility::_hasperk("specialty_exo_slamboots")) {
      playFXOnTag(level._effect["exo_slam_kneeslide_fx"], self, "j_knee_ri");
      physicsexplosionsphere(self.origin, var_14, 20, 1);

      foreach(var_18 in level.players) {
        if(maps\mp\_utility::isreallyalive(var_18) && var_18 != self && (!level.teambased || var_18.team != self.team) && !var_18 maps\mp\_utility::isusingremote()) {
          if(distancesquared(self.origin, var_18.origin) < var_16) {
            var_18 shellshock("concussion_grenade_mp", 1.5);
            maps\mp\gametypes\_missions::processchallenge("ch_perk_overcharge");
          }
        }
      }
    } else {
      physicsexplosionsphere(self.origin, var_14, 20, 0.9);
    }

    if(getdvarint("ground_slam_debug")) {
      thread draw_circle_for_time(self.origin, var_14 + var_5, (0, 1, 0), 0, 16, var_0);
      var_20 = 100;
      var_21 = (var_20 - var_9) * var_14 / (var_10 - var_9);
      thread draw_circle_for_time(self.origin, var_21 + var_5, (1, 0, 0), 0, 16, var_0);

      foreach(var_18 in level.players) {}
    }
  }
}

draw_circle_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_5 / 0.05;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    maps\mp\bots\_bots_util::bot_draw_circle(var_0, var_1, var_2, var_3, var_4);
    wait 0.05;
  }
}

monitorgroundslamhitplayer() {
  self endon("disconnect");

  for(;;) {
    self waittill("ground_slam_hit_player", var_0);

    if(isDefined(level.groundslamhitplayer) && self[[level.groundslamhitplayer]](var_0)) {
      continue;
    }
    var_0 dodamage(var_0.health, self.origin, self, self, "MOD_CRUSH", "boost_slam_mp");
  }
}

exo_power_cooldown(var_0) {
  var_1 = int(var_0 * 1000);
  self setclientomnvar("ui_exo_cooldown_time", var_1);
  wait(var_0);
  self setclientomnvar("ui_exo_cooldown_time", 0);
  self playlocalsound("exo_power_recharged");
}