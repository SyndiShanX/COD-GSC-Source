/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player\youngfarrah.gsc
***********************************************/

function youngfarrahprecache() {
  precachesuit("iw8_kid");
  precachesuit("iw8_kid_slow_sprint");
}

function youngfarrahsetup() {
  setplayerviewmodel("viewhands_farrah", undefined, "viewmodel_farah_child_shadowcaster");
  level.player enableweapons();
  level.player setsuit("iw8_kid");
  level.player takeallweapons();
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweapon("iw8_gunless_farrah");
  scripts\sp\player::disable_player_weapon_info();
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  level.player scripts\common\utility::allow_weapon_pickup(0);
  level.player disableoffhandweapons();
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.45, 0, "yfarrah_movement");
  thread prone_speedup();
  level.player scripts\sp\player::remove_all_armor();
  level.player scripts\sp\player::set_player_max_health(1);
  setsaveddvar("player_meleeDamageMultiplier", 2);
  setsaveddvar("player_viewmodelMoveAnimScale", 1.35);
  setsaveddvar("bg_sprintLoopTimeScale", 0.665);
  setsaveddvar("bg_viewBobAmplitudeSprinting", 0.012);
  setsaveddvar("bg_viewBobTransTime", 600);
  setsaveddvar("mount_side_min_height", 20);
  setsaveddvar("mount_tuning_shapecast_cylinder_additional_height", 0);
  setsaveddvar("mount_indicator_inworld", 0);
  level.player modifybasefov(75, 0.05);
  baseraidalblur(0);

  if(level.player ispcplayer()) {
    setsaveddvar("r_zPlanes", "0.1 400 0.75 1000");
  } else {
    setsaveddvar("r_zPlanes", "0.1 400 3.25 1000");
  }

  scripts\engine\sp\utility::add_hint_string("ads", &"HOMETOWN/ADS", &player_fullads);
}

function setplayerviewmodel(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level.player setviewmodel(var_0);
  }

  if(isDefined(var_1)) {}

  if(isDefined(var_2)) {
    level.player setshadowmodel(var_2);
    return;
  }
}

function prone_speedup() {
  for(;;) {
    if(self getstance() == "prone") {
      level.player scripts\engine\sp\utility::blend_movespeedscale(0.9, 0, "yfarrah_movement");

      while(self getstance() == "prone") {
        waitframe();
      }

      level.player scripts\engine\sp\utility::blend_movespeedscale(0.45, 0, "yfarrah_movement");
    }

    waitframe();
  }
}

function weapfireradialblur() {
  setsaveddvar("r_mbRadialOverrideRadius", 0, 0);
  setsaveddvar("r_mbRadialOverrideStrength", 0.092, 0);
  setsaveddvar("r_mbRadialOverrideDistortion", 0.01, 0);
  wait 0.05;
  baseraidalblur(0.15);
}

function baseraidalblur(var_0) {
  thread scripts\engine\sp\utility::lerp_saveddvar("r_mbRadialOverrideRadius", 0.75, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("r_mbRadialOverrideStrength", 0.002, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("r_mbRadialOverrideDistortion", 0.01, var_0);
}

function player_fullads() {
  return level.player playerads() == 1;
}

function takeyoungfarrahpistol() {
  self notify("stopYoungFarrahPistLogic");
  self takeweapon("iw8_pi_cpapa_farah_sp");
  self giveweapon("iw8_gunless_farrah");
  self switchtoweapon("iw8_gunless_farrah");
  scripts\common\utility::allow_melee(1, "farrah_pistol");
}

function adsviewbobhack() {
  self endon("stopYoungFarrahPistLogic");

  for(;;) {
    var_0 = level.player playerads();
    var_1 = scripts\engine\math::factor_value(1.35, 1.3, var_0);
    setsaveddvar("player_viewmodelMoveAnimScale", var_1);
    wait 0.05;
  }
}

function weapcoltfireblur() {
  self notify("stopYoungFarrahPistLogic");
  self endon("stopYoungFarrahPistLogic");

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(getweaponbasename(var_0) == "iw8_pi_cpapa_farah_sp_a") {
      level notify("player_fired_gun");
      weapfireblureffect();
    }
  }
}

function weapfireblureffect() {
  thread weaponfirepush();
  thread weapfireradialblur();
  earthquake(0.3, 0.3, self.origin, 5000);
}

function weaponfirepush() {
  var_0 = anglesToForward(self getplayerangles()) * -1;
  var_0 *= 22;

  while(length(var_0) > 0.02) {
    self pushplayervector(var_0, 0);
    var_0 *= 0.65;
    wait 0.05;
  }

  wait 0.05;
  self pushplayervector((0, 0, 0), 0);
}

function createnoisedata() {
  var_0 = spawnStruct();
  var_0.mag = 0.35;
  var_0.lerped = (0, 0, 0);
  var_0.data = [];
  var_0.data["x"] = [];
  var_0.data["x"]["old"] = 0;
  var_0.data["x"]["period"] = 0;
  var_0.data["x"]["target"] = 0;
  var_0.data["x"]["val"] = 0;
  var_0.data["x"]["time"] = 0;
  var_0.data["y"] = [];
  var_0.data["y"]["old"] = 0;
  var_0.data["y"]["period"] = 0;
  var_0.data["y"]["target"] = 0;
  var_0.data["y"]["val"] = 0;
  var_0.data["y"]["time"] = 0;
  return var_0;
}

function noise(var_0, var_1, var_2) {
  self.period_min = var_0;
  self.period_max = var_1;
  axisnoise("x");
  axisnoise("y");
  self.lerped = scripts\engine\math::lerp(self.lerped, (self.data["x"]["val"], self.data["y"]["val"], 0), var_2);
}

function axisnoise(var_0) {
  if(self.data[var_0]["time"] >= self.data[var_0]["period"]) {
    self.data[var_0]["period"] = randomfloatrange(self.period_min, self.period_max);
    self.data[var_0]["old"] = self.data[var_0]["target"];
    self.data[var_0]["time"] = 0;
    self.data[var_0]["target"] = randomfloatrange(self.mag * -1, self.mag);
  }

  var_1 = scripts\engine\math::normalize_value(0, self.data[var_0]["period"], self.data[var_0]["time"]);
  var_1 = scripts\engine\math::normalized_float_smoth_in_out(var_1);
  self.data[var_0]["val"] = self.data[var_0]["old"] * (1 - var_1) + self.data[var_0]["target"] * var_1;
  self.data[var_0]["time"] = self.data[var_0]["time"] + 0.05;
}

function youngfarrahbreathlogic() {
  thread youngfarrahfatigue();
  self enableplayerbreathsystem(0);
  var_0 = scripts\engine\utility::spawn_script_origin(level.player.origin, level.player.angles);
  var_0 linkTo(level.player);
  var_0 scalevolume(0, 0);
  var_0.current_breath_blur = 0;
  self.breaths = var_0;
  var_1 = spawnStruct();
  var_1.player_relative_offset = (0, 0, 0);
  var_1.player_relative_offset_accel = (0, 0, 0);
  thread breathviewoffsetslogic();
  var_2 = 0.7;
  var_3 = 0.1;
  wait 0.05;
  var_4 = 1.1;
  var_5 = 0.95;
  var_6 = [];
  GscBinSkip0(0x2e, "sprint", [], var_1);
}

function youngfarrahfatigue() {
  self.stamina = 200;
  self.fatigue = 20;

  for(;;) {
    if(is_using_stamina()) {
      self.stamina -= 1;
      self.fatigue -= 1;
      self.stamina = max(self.stamina, 0);
      var_0 = scripts\engine\math::normalize_value(0, 200, self.stamina);
    } else {
      var_1 = 1;
      self.stamina += var_1 * 0.4;
      self.stamina = min(self.stamina, 200);
      var_0 = scripts\engine\math::normalize_value(0, 200, self.stamina);
      var_2 = scripts\engine\math::factor_value(0.0001, 0.8, var_0);
      self.fatigue += var_1 * var_2;
    }

    self.fatigue = clamp(self.fatigue, 0, 20);
    var_3 = scripts\engine\math::normalize_value(0, 20, self.fatigue);
    var_4 = 0.5;

    for(var_5 = 1;; var_5 = max(var_5, 0)) {
      if(var_3 >= var_5) {
        var_3 = var_5;
        break;
      }

      var_5 -= var_4;
    }

    self.stepped_stamina = var_3;
    waitframe();
  }
}

function breathviewoffsetslogic() {
  var_0 = 0.02;
  var_1 = 0.8;
  var_2 = (0, 0, 0);
  var_3 = (0, 0, 0);
  var_4 = (0, 0, 0);

  for(;;) {
    self.player_relative_offset += self.player_relative_offset_accel;
    var_5 = self.player_relative_offset;
    var_6 = (0, self.player_relative_offset[1] * 0.8, self.player_relative_offset[0] * -1.3);
    var_7 = (0, 0, self.player_relative_offset[0] * -1);
    var_2 = scripts\engine\math::lerp(var_2, var_5, var_0);
    var_3 = scripts\engine\math::lerp(var_3, var_6, var_0);
    var_4 = scripts\engine\math::lerp(var_4, var_7, var_1);
    var_8 = level.player playerads();
    var_9 = scripts\engine\math::factor_value(-2, -1.6, var_8);
    var_10 = scripts\engine\math::factor_value(5.2, 4.64, var_8);
    var_11 = scripts\engine\math::factor_value(0.6, 0.24, var_8);
    var_12 = 1 - level.player playermount();
    var_9 *= var_12;
    var_10 *= var_12;
    var_11 *= var_12;
    level.player.viewblender["viewAng"].channels["viewBreaths"] = var_2 * var_9;
    level.player.viewblender["viewPos"].channels["viewBreaths"] = var_3 * var_10;
    level.player.viewblender["weapPos"].channels["viewBreaths"] = var_4 * var_11;
    self.player_relative_offset *= 0.8;
    wait 0.05;
  }
}

function breath_fade_delay(var_0, var_1, var_2) {
  wait var_2;
  self fadeovertime(var_0);
  self.alpha = var_1;
}

function breathviewoffsets_accellcycle(var_0, var_1) {
  self notify("new_groundref_BREATH_cycle");
  self endon("new_groundref_BREATH_cycle");
  var_2 = 2;
  var_3 = 1;
  var_4 = 1;

  if(self.player_relative_offset[0] != 0) {
    if(self.player_relative_offset[0] > 0 && var_0[0] > 0 || self.player_relative_offset[0] < 0 && var_0[0] < 0) {
      var_4 = get_scale_for_axis(self.player_relative_offset[0], var_2);
    } else {
      var_4 = get_scale_for_axis(self.player_relative_offset[0], var_2, 1);
    }
  }

  var_5 = scripts\engine\math::normalize_value(0, 9, abs(var_0[0] - self.player_relative_offset[0]));
  var_5 = scripts\engine\math::factor_value(1, 2, var_5);
  var_0 = (var_0[0] * var_4, var_0[1], var_0[2]);
  var_0 *= 0.05;
  var_6 = 1 / var_1;
  var_0 *= var_6;
  breathviewoffsets_accell(var_0, var_1 * 0.55);
  breathviewoffsets_accell((0, 0, 0), var_1 * 0.85);
}

function get_scale_for_axis(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    return scripts\engine\math::factor_value(1, 1.5, scripts\engine\math::normalize_value(0, var_1, abs(var_0)));
  }

  return 1 - scripts\engine\math::normalize_value(0, var_1, abs(var_0));
}

function breathviewoffsets_accell(var_0, var_1) {
  var_2 = self.player_relative_offset_accel;
  var_3 = var_0 - var_2;
  var_4 = 0.05;
  var_5 = int(var_1 / var_4);

  if(var_5 > 0) {
    var_6 = var_3 / var_5;

    while(var_5) {
      var_2 += var_6;
      self.player_relative_offset_accel = var_2;
      wait var_4;
      var_5--;
    }
  }

  self.player_relative_offset_accel = var_0;
}

function pulse_blur(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    wait var_2;
  }

  self notify("new_breath_blur_lerp");
  self endon("new_breath_blur_lerp");
  lerp_blur(0, var_0, var_1);
  lerp_blur(var_0, 0, var_1);
}

function lerp_blur(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = var_1 - var_0;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  if(var_6 > 0) {
    var_7 = var_4 / var_6;

    while(var_6) {
      var_3 += var_7;
      set_blur_safe(var_3);
      wait var_5;
      var_6--;
    }
  }

  set_blur_safe(var_1);
}

function set_blur_safe(var_0) {
  if(var_0 < 0.05) {
    var_0 = 0;
  }

  if(var_0 == 0 && self.current_breath_blur == 0) {
    return;
  }

  level.player setblurforplayer(var_0, 0.1);
  self.current_breath_blur = var_0;
}

function is_using_stamina() {
  return self issprinting();
}

function scale_youngfarrah_firetime(var_0) {
  level.player.fireholdtime = 0.55 * var_0;
}

function youngfarrah_pistol_reaction(var_0, var_1) {
  thread youngfarrah_pistol_reaction_proc(level.player, var_0);
}

function youngfarrah_pistol_reaction_proc(var_0, var_1) {
  self notify("newPistolReaction");
  self endon("newPistolReaction");
  self waittill("farrahFire");

  if(!isDefined(var_1)) {
    var_1 = 0.1;
  }

  if(isDefined(self.effortvoice)) {
    self.effortvoice scripts\engine\utility::delaycall(var_1, &playsound, var_0);
    return;
  }
}