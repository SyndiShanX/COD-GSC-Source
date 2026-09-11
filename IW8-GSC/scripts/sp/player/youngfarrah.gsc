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

  if(level.player ispcplayer()) {
    setsaveddvar("OMNONNMOTP", "0.1 400 0.75 1000");
  } else {
    setsaveddvar("OMNONNMOTP", "0.1 400 3.25 1000");
  }

  scripts\engine\sp\utility::add_hint_string("ads", &"HOMETOWN/ADS", &player_fullads);
}

function setplayerviewmodel(var0, var1, var2) {
  if(isDefined(var0)) {
    level.player setviewmodel(var0);
  }

  if(isDefined(var1)) {}

  if(isDefined(var2)) {
    level.player setshadowmodel(var2);
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
  setsaveddvar("NKTRSSTMRQ", 0, 0);
  setsaveddvar("LSOPQMRPNR", 0.092, 0);
  setsaveddvar("MLTTMLTKOR", 0.01, 0);
  wait 0.05;
  baseraidalblur(0.15);
}

function baseraidalblur(var0) {
  thread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", 0.75, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0.002, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.01, var0);
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
    var0 = level.player playerads();
    var1 = scripts\engine\math::factor_value(1.35, 1.3, var0);
    setsaveddvar("MNPNORMOMP", var1);
    wait 0.05;
  }
}

function weapcoltfireblur() {
  self notify("stopYoungFarrahPistLogic");
  self endon("stopYoungFarrahPistLogic");

  for(;;) {
    self waittill("weapon_fired", var0);

    if(getweaponbasename(var0) == "iw8_pi_cpapa_farah_sp_a") {
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
  var0 = anglesToForward(self getplayerangles()) * -1;
  var0 *= 22;

  while(length(var0) > 0.02) {
    self pushplayervector(var0, 0);
    var0 *= 0.65;
    wait 0.05;
  }

  wait 0.05;
  self pushplayervector((0, 0, 0), 0);
}

function createnoisedata() {
  var0 = spawnStruct();
  var0.mag = 0.35;
  var0.lerped = (0, 0, 0);
  var0.data = [];
  var0.data["x"] = [];
  var0.data["x"]["old"] = 0;
  var0.data["x"]["period"] = 0;
  var0.data["x"]["target"] = 0;
  var0.data["x"]["val"] = 0;
  var0.data["x"]["time"] = 0;
  var0.data["y"] = [];
  var0.data["y"]["old"] = 0;
  var0.data["y"]["period"] = 0;
  var0.data["y"]["target"] = 0;
  var0.data["y"]["val"] = 0;
  var0.data["y"]["time"] = 0;
  return var0;
}

function noise(var0, var1, var2) {
  self.period_min = var0;
  self.period_max = var1;
  axisnoise("x");
  axisnoise("y");
  self.lerped = scripts\engine\math::lerp(self.lerped, (self.data["x"]["val"], self.data["y"]["val"], 0), var2);
}

function axisnoise(var0) {
  if(self.data[var0]["time"] >= self.data[var0]["period"]) {
    self.data[var0]["period"] = randomfloatrange(self.period_min, self.period_max);
    self.data[var0]["old"] = self.data[var0]["target"];
    self.data[var0]["time"] = 0;
    self.data[var0]["target"] = randomfloatrange(self.mag * -1, self.mag);
  }

  var1 = scripts\engine\math::normalize_value(0, self.data[var0]["period"], self.data[var0]["time"]);
  var1 = scripts\engine\math::normalized_float_smoth_in_out(var1);
  self.data[var0]["val"] = self.data[var0]["old"] * (1 - var1) + self.data[var0]["target"] * var1;
  self.data[var0]["time"] = self.data[var0]["time"] + 0.05;
}

function youngfarrahbreathlogic() {
  thread youngfarrahfatigue();
  self enableplayerbreathsystem(0);
  var0 = scripts\engine\utility::spawn_script_origin(level.player.origin, level.player.angles);
  var0 linkTo(level.player);
  var0 scalevolume(0, 0);
  var0.current_breath_blur = 0;
  self.breaths = var0;
  var1 = spawnStruct();
  var1.player_relative_offset = (0, 0, 0);
  var1.player_relative_offset_accel = (0, 0, 0);
  thread breathviewoffsetslogic();
  var2 = 0.7;
  var3 = 0.1;
  wait 0.05;
  var4 = 1.1;
  var5 = 0.95;
  var6 = [];
  GscBinSkip0(0x2e, "sprint", [], var1);
}

function youngfarrahfatigue() {
  self.stamina = 200;
  self.fatigue = 20;

  for(;;) {
    if(is_using_stamina()) {
      self.stamina -= 1;
      self.fatigue -= 1;
      self.stamina = max(self.stamina, 0);
      var0 = scripts\engine\math::normalize_value(0, 200, self.stamina);
    } else {
      var1 = 1;
      self.stamina += var1 * 0.4;
      self.stamina = min(self.stamina, 200);
      var0 = scripts\engine\math::normalize_value(0, 200, self.stamina);
      var2 = scripts\engine\math::factor_value(0.0001, 0.8, var0);
      self.fatigue += var1 * var2;
    }

    self.fatigue = clamp(self.fatigue, 0, 20);
    var3 = scripts\engine\math::normalize_value(0, 20, self.fatigue);
    var4 = 0.5;

    for(var5 = 1;; var5 = max(var5, 0)) {
      if(var3 >= var5) {
        var3 = var5;
        break;
      }

      var5 -= var4;
    }

    self.stepped_stamina = var3;
    waitframe();
  }
}

function breathviewoffsetslogic() {
  var0 = 0.02;
  var1 = 0.8;
  var2 = (0, 0, 0);
  var3 = (0, 0, 0);
  var4 = (0, 0, 0);

  for(;;) {
    self.player_relative_offset += self.player_relative_offset_accel;
    var5 = self.player_relative_offset;
    var6 = (0, self.player_relative_offset[1] * 0.8, self.player_relative_offset[0] * -1.3);
    var7 = (0, 0, self.player_relative_offset[0] * -1);
    var2 = scripts\engine\math::lerp(var2, var5, var0);
    var3 = scripts\engine\math::lerp(var3, var6, var0);
    var4 = scripts\engine\math::lerp(var4, var7, var1);
    var8 = level.player playerads();
    var9 = scripts\engine\math::factor_value(-2, -1.6, var8);
    var10 = scripts\engine\math::factor_value(5.2, 4.64, var8);
    var11 = scripts\engine\math::factor_value(0.6, 0.24, var8);
    var12 = 1 - level.player playermount();
    var9 *= var12;
    var10 *= var12;
    var11 *= var12;
    level.player.viewblender["viewAng"].channels["viewBreaths"] = var2 * var9;
    level.player.viewblender["viewPos"].channels["viewBreaths"] = var3 * var10;
    level.player.viewblender["weapPos"].channels["viewBreaths"] = var4 * var11;
    self.player_relative_offset *= 0.8;
    wait 0.05;
  }
}

function breath_fade_delay(var0, var1, var2) {
  wait var2;
  self fadeovertime(var0);
  self.alpha = var1;
}

function breathviewoffsets_accellcycle(var0, var1) {
  self notify("new_groundref_breath_cycle");
  self endon("new_groundref_breath_cycle");
  var2 = 2;
  var3 = 1;
  var4 = 1;

  if(self.player_relative_offset[0] != 0) {
    if(self.player_relative_offset[0] > 0 && var0[0] > 0 || self.player_relative_offset[0] < 0 && var0[0] < 0) {
      var4 = get_scale_for_axis(self.player_relative_offset[0], var2);
    } else {
      var4 = get_scale_for_axis(self.player_relative_offset[0], var2, 1);
    }
  }

  var5 = scripts\engine\math::normalize_value(0, 9, abs(var0[0] - self.player_relative_offset[0]));
  var5 = scripts\engine\math::factor_value(1, 2, var5);
  var0 = (var0[0] * var4, var0[1], var0[2]);
  var0 *= 0.05;
  var6 = 1 / var1;
  var0 *= var6;
  breathviewoffsets_accell(var0, var1 * 0.55);
  breathviewoffsets_accell((0, 0, 0), var1 * 0.85);
}

function get_scale_for_axis(var0, var1, var2) {
  if(isDefined(var2) && var2) {
    return scripts\engine\math::factor_value(1, 1.5, scripts\engine\math::normalize_value(0, var1, abs(var0)));
  }

  return 1 - scripts\engine\math::normalize_value(0, var1, abs(var0));
}

function breathviewoffsets_accell(var0, var1) {
  var2 = self.player_relative_offset_accel;
  var3 = var0 - var2;
  var4 = 0.05;
  var5 = int(var1 / var4);

  if(var5 > 0) {
    var6 = var3 / var5;

    while(var5) {
      var2 += var6;
      self.player_relative_offset_accel = var2;
      wait var4;
      var5--;
    }
  }

  self.player_relative_offset_accel = var0;
}

function pulse_blur(var0, var1, var2) {
  if(isDefined(var2)) {
    wait var2;
  }

  self notify("new_breath_blur_lerp");
  self endon("new_breath_blur_lerp");
  lerp_blur(0, var0, var1);
  lerp_blur(var0, 0, var1);
}

function lerp_blur(var0, var1, var2) {
  var3 = var0;
  var4 = var1 - var0;
  var5 = 0.05;
  var6 = int(var2 / var5);

  if(var6 > 0) {
    var7 = var4 / var6;

    while(var6) {
      var3 += var7;
      set_blur_safe(var3);
      wait var5;
      var6--;
    }
  }

  set_blur_safe(var1);
}

function set_blur_safe(var0) {
  if(var0 < 0.05) {
    var0 = 0;
  }

  if(var0 == 0 && self.current_breath_blur == 0) {
    return;
  }

  level.player setblurforplayer(var0, 0.1);
  self.current_breath_blur = var0;
}

function is_using_stamina() {
  return self issprinting();
}

function scale_youngfarrah_firetime(var0) {
  level.player.fireholdtime = 0.55 * var0;
}

function youngfarrah_pistol_reaction(var0, var1) {
  thread youngfarrah_pistol_reaction_proc(level.player, var0);
}

function youngfarrah_pistol_reaction_proc(var0, var1) {
  self notify("newPistolReaction");
  self endon("newPistolReaction");
  self waittill("farrahFire");

  if(!isDefined(var1)) {
    var1 = 0.1;
  }

  if(isDefined(self.effortvoice)) {
    self.effortvoice scripts\engine\utility::delaycall(var1, &playsound, var0);
    return;
  }
}