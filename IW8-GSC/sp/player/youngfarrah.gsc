/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player\youngfarrah.gsc
***********************************************/

youngfarrahprecache() {
  precachesuit("iw8_kid");
  precachesuit("iw8_kid_slow_sprint");
}

youngfarrahsetup() {
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
  level.player thread prone_speedup();
  level.player scripts\sp\player::remove_all_armor();
  level.player scripts\sp\player::set_player_max_health(1);
  setsaveddvar("MSRSPQNQKP", 2);
  setsaveddvar("MNPNORMOMP", 1.35);
  setsaveddvar("NTMRNPKSPM", 0.665);
  setsaveddvar("MLTSTQKLOQ", 0.012);
  setsaveddvar("MSLNOOKPTO", 600);
  setsaveddvar("MKKMRQLKT", 20);
  setsaveddvar("QLLLONQRS", 0);
  setsaveddvar("LKQLKNRLQ", 0);
  level.player modifybasefov(75, 0.05);
  baseraidalblur(0);

  if(level.player ispcplayer())
    setsaveddvar("OMNONNMOTP", "0.1 400 0.75 1000");
  else
    setsaveddvar("OMNONNMOTP", "0.1 400 3.25 1000");

  scripts\engine\sp\utility::add_hint_string("ads", &"HOMETOWN/ADS", ::player_fullads);
}

setplayerviewmodel(var_0, var_1, var_2) {
  if(isDefined(var_0))
    level.player setviewmodel(var_0);

  if(isDefined(var_1)) {}

  if(isDefined(var_2))
    level.player setshadowmodel(var_2);
}

prone_speedup() {
  for(;;) {
    if(self getstance() == "prone") {
      level.player scripts\engine\sp\utility::blend_movespeedscale(0.9, 0, "yfarrah_movement");

      while(self getstance() == "prone")
        waitframe();

      level.player scripts\engine\sp\utility::blend_movespeedscale(0.45, 0, "yfarrah_movement");
    }

    waitframe();
  }
}

weapfireradialblur() {
  setsaveddvar("NKTRSSTMRQ", 0.0, 0);
  setsaveddvar("LSOPQMRPNR", 0.092, 0);
  setsaveddvar("MLTTMLTKOR", 0.01, 0);
  wait 0.05;
  baseraidalblur(0.15);
}

baseraidalblur(var_0) {
  thread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", 0.75, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0.002, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.01, var_0);
}

player_fullads() {
  return level.player playerads() == 1;
}

takeyoungfarrahpistol() {
  self notify("stopYoungFarrahPistLogic");
  self takeweapon("iw8_pi_cpapa_farah_sp");
  self giveweapon("iw8_gunless_farrah");
  self switchtoweapon("iw8_gunless_farrah");
  scripts\common\utility::allow_melee(1, "farrah_pistol");
}

adsviewbobhack() {
  self endon("stopYoungFarrahPistLogic");

  for(;;) {
    var_0 = level.player playerads();
    var_1 = scripts\engine\math::factor_value(1.35, 1.3, var_0);
    setsaveddvar("MNPNORMOMP", var_1);
    wait 0.05;
  }
}

weapcoltfireblur() {
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

weapfireblureffect() {
  thread weaponfirepush();
  thread weapfireradialblur();
  earthquake(0.3, 0.3, self.origin, 5000);
}

weaponfirepush() {
  var_0 = anglesToForward(self getplayerangles()) * -1;
  var_0 = var_0 * 22;

  while(length(var_0) > 0.02) {
    self pushplayervector(var_0, 0);
    var_0 = var_0 * 0.65;
    wait 0.05;
  }

  wait 0.05;
  self pushplayervector((0, 0, 0), 0);
}

createnoisedata() {
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

noise(var_0, var_1, var_2) {
  self.period_min = var_0;
  self.period_max = var_1;
  axisnoise("x");
  axisnoise("y");
  self.lerped = scripts\engine\math::lerp(self.lerped, (self.data["x"]["val"], self.data["y"]["val"], 0), var_2);
}

axisnoise(var_0) {
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

youngfarrahbreathlogic() {
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
  var_1 thread breathviewoffsetslogic();
  var_2 = 0.7;
  var_3 = 0.1;
  wait 0.05;
  var_4 = 1.1;
  var_5 = 0.95;
  var_6 = [];
  var_6["sprint"] = [];
  var_6["sprint"]["min_vol"] = 0.6;
  var_6["sprint"]["max_vol"] = 1.2;
  var_6["sprint"]["inhale"] = [];
  var_6["sprint"]["inhale"]["alias_base"] = "plr_yfarrah_breath_sprint_inh_0";
  var_6["sprint"]["inhale"]["alias_num"] = 0;
  var_6["sprint"]["exhale"] = [];
  var_6["sprint"]["exhale"]["alias_base"] = "plr_yfarrah_breath_sprint_exh_0";
  var_6["sprint"]["exhale"]["alias_num"] = 0;
  var_6["run"] = [];
  var_6["run"]["min_vol"] = 0.5;
  var_6["run"]["max_vol"] = 1.1;
  var_6["run"]["inhale"] = [];
  var_6["run"]["inhale"]["alias_base"] = "plr_yfarrah_breath_run_inh_0";
  var_6["run"]["inhale"]["alias_num"] = 0;
  var_6["run"]["exhale"] = [];
  var_6["run"]["exhale"]["alias_base"] = "plr_yfarrah_breath_run_exh_0";
  var_6["run"]["exhale"]["alias_num"] = 0;
  var_7 = "inhale";
  var_8 = 0.3;
  var_9 = 0.1;

  for(;;) {
    while(isDefined(self.adsbreathhold) && self.adsbreathhold) {
      var_7 = "exhale";
      wait 0.05;
    }

    var_10 = self.stepped_stamina;

    if(var_10 < 1 && is_using_stamina() || var_10 == 0)
      var_11 = "sprint";
    else
      var_11 = "run";

    var_12 = var_6[var_11][var_7]["alias_base"] + var_6[var_11][var_7]["alias_num"];
    var_6[var_11][var_7]["alias_num"]++;

    if(var_6[var_11][var_7]["alias_num"] > 9)
      var_6[var_11][var_7]["alias_num"] = 0;

    var_13 = lookupsoundlength(var_12) / 1000 + 0.1;

    if(is_using_stamina())
      var_13 = var_13 * 0.7;

    var_14 = scripts\engine\math::factor_value(0.55, 1, self.stepped_stamina);
    var_15 = scripts\engine\math::factor_value(var_6[var_11]["max_vol"], var_6[var_11]["min_vol"], var_14);
    var_16 = scripts\engine\math::factor_value(var_4, var_5, var_14);
    var_15 = var_15 * 0.25;
    var_0 scripts\engine\utility::delaycall(var_8, ::scalepitch, var_16, 0);
    var_0 scripts\engine\utility::delaycall(var_8, ::scalevolume, var_15, 0);
    var_0 scripts\engine\utility::delaycall(var_8, ::playsound, var_12);
    var_0.currentvol = var_15;
    var_17 = scripts\engine\math::normalized_float_smooth_out(var_10);

    if(var_7 == "inhale") {
      var_18 = -4.5;
      var_19 = scripts\engine\math::factor_value(var_2, 0, var_17);
    } else {
      var_18 = 4.5;
      var_19 = scripts\engine\math::factor_value(var_3, 0, var_17);
    }

    var_20 = scripts\engine\math::factor_value(1, 0.1, var_14);
    var_1 thread breathviewoffsets_accellcycle((var_18, randomfloatrange(-0.9, 0.9), 0) * var_20, var_13);
    wait(var_13);

    if(var_7 == "inhale") {
      var_7 = "exhale";
      continue;
    }

    var_7 = "inhale";
  }
}

youngfarrahfatigue() {
  self.stamina = 200;
  self.fatigue = 20;

  for(;;) {
    if(is_using_stamina()) {
      self.stamina = self.stamina - 1;
      self.fatigue = self.fatigue - 1;
      self.stamina = max(self.stamina, 0);
      var_0 = scripts\engine\math::normalize_value(0, 200, self.stamina);
    } else {
      var_1 = 1;
      self.stamina = self.stamina + var_1 * 0.4;
      self.stamina = min(self.stamina, 200);
      var_0 = scripts\engine\math::normalize_value(0, 200, self.stamina);
      var_2 = scripts\engine\math::factor_value(0.0001, 0.8, var_0);
      self.fatigue = self.fatigue + var_1 * var_2;
    }

    self.fatigue = clamp(self.fatigue, 0, 20);
    var_3 = scripts\engine\math::normalize_value(0, 20, self.fatigue);
    var_4 = 0.5;
    var_5 = 1;

    for(;;) {
      if(var_3 >= var_5) {
        var_3 = var_5;
        break;
      }

      var_5 = var_5 - var_4;
      var_5 = max(var_5, 0);
    }

    self.stepped_stamina = var_3;
    waitframe();
  }
}

breathviewoffsetslogic() {
  var_0 = 0.02;
  var_1 = 0.8;
  var_2 = (0, 0, 0);
  var_3 = (0, 0, 0);
  var_4 = (0, 0, 0);

  for(;;) {
    self.player_relative_offset = self.player_relative_offset + self.player_relative_offset_accel;
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
    var_9 = var_9 * var_12;
    var_10 = var_10 * var_12;
    var_11 = var_11 * var_12;
    level.player.viewblender["viewAng"].channels["viewBreaths"] = var_2 * var_9;
    level.player.viewblender["viewPos"].channels["viewBreaths"] = var_3 * var_10;
    level.player.viewblender["weapPos"].channels["viewBreaths"] = var_4 * var_11;
    self.player_relative_offset = self.player_relative_offset * 0.8;
    wait 0.05;
  }
}

breath_fade_delay(var_0, var_1, var_2) {
  wait(var_2);
  self fadeovertime(var_0);
  self.alpha = var_1;
}

breathviewoffsets_accellcycle(var_0, var_1) {
  self notify("new_groundref_breath_cycle");
  self endon("new_groundref_breath_cycle");
  var_2 = 2;
  var_3 = 1;
  var_4 = 1;

  if(self.player_relative_offset[0] != 0) {
    if(self.player_relative_offset[0] > 0 && var_0[0] > 0 || self.player_relative_offset[0] < 0 && var_0[0] < 0)
      var_4 = get_scale_for_axis(self.player_relative_offset[0], var_2);
    else
      var_4 = get_scale_for_axis(self.player_relative_offset[0], var_2, 1);
  }

  var_5 = scripts\engine\math::normalize_value(0, 9.0, abs(var_0[0] - self.player_relative_offset[0]));
  var_5 = scripts\engine\math::factor_value(1, 2, var_5);
  var_0 = (var_0[0] * var_4, var_0[1], var_0[2]);
  var_0 = var_0 * 0.05;
  var_6 = 1 / var_1;
  var_0 = var_0 * var_6;
  breathviewoffsets_accell(var_0, var_1 * 0.55);
  breathviewoffsets_accell((0, 0, 0), var_1 * 0.85);
}

get_scale_for_axis(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2)
    return scripts\engine\math::factor_value(1, 1.5, scripts\engine\math::normalize_value(0, var_1, abs(var_0)));
  else
    return 1 - scripts\engine\math::normalize_value(0, var_1, abs(var_0));
}

breathviewoffsets_accell(var_0, var_1) {
  var_2 = self.player_relative_offset_accel;
  var_3 = var_0 - var_2;
  var_4 = 0.05;
  var_5 = int(var_1 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_2 = var_2 + var_6;
      self.player_relative_offset_accel = var_2;
      wait(var_4);
    }
  }

  self.player_relative_offset_accel = var_0;
}

pulse_blur(var_0, var_1, var_2) {
  if(isDefined(var_2))
    wait(var_2);

  self notify("new_breath_blur_lerp");
  self endon("new_breath_blur_lerp");
  lerp_blur(0, var_0, var_1);
  lerp_blur(var_0, 0, var_1);
}

lerp_blur(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = var_1 - var_0;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  if(var_6 > 0) {
    for(var_7 = var_4 / var_6; var_6; var_6--) {
      var_3 = var_3 + var_7;
      set_blur_safe(var_3);
      wait(var_5);
    }
  }

  set_blur_safe(var_1);
}

set_blur_safe(var_0) {
  if(var_0 < 0.05)
    var_0 = 0;

  if(var_0 == 0 && self.current_breath_blur == 0) {
    return;
  }
  level.player setblurforplayer(var_0, 0.1);
  self.current_breath_blur = var_0;
}

is_using_stamina() {
  return self issprinting();
}

scale_youngfarrah_firetime(var_0) {
  level.player.fireholdtime = 0.55 * var_0;
}

youngfarrah_pistol_reaction(var_0, var_1) {
  level.player thread youngfarrah_pistol_reaction_proc(var_0, var_1);
}

youngfarrah_pistol_reaction_proc(var_0, var_1) {
  self notify("newPistolReaction");
  self endon("newPistolReaction");
  self waittill("farrahFire");

  if(!isDefined(var_1))
    var_1 = 0.1;

  if(isDefined(self.effortvoice))
    self.effortvoice scripts\engine\utility::delaycall(var_1, ::playsound, var_0);
}