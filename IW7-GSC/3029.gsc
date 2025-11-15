/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3029.gsc
***************************************/

func_D139() {
  self.func_B154 = 999999;
  func_0BDC::func_137DB();
  thread func_D186();
  func_0BDC::func_137D9();
  thread func_D188();
}

func_D186() {
  level.player getrankinfoxpamt();
  func_F481();
  self.func_B154 = scripts\sp\gameskill::func_7A59();
  self.health = 9999999;
  thread func_11AB3();
  self.func_2875 = 0;
  self.func_A8A4 = -99999;
  self.func_9C28 = 0;
  self.func_3820 = 1;
  thread func_D142();
  thread func_D13C();
  thread func_D136();
}

func_D188() {
  if(isDefined(self.func_4B23))
    self stoploopsound(self.func_4B23);

  if(isDefined(self.func_4B22))
    self stoploopsound(self.func_4B22);

  level.player _meth_80A1();
}

func_D13C() {
  self endon("player_exit_jackal");
  self endon("script_death");

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    if(_isgodmode(self.owner)) {
      continue;
    }
    if(isDefined(self._meth_843F) && self._meth_843F) {
      continue;
    }
    if(isDefined(var_1.classname) && var_1.classname == "misc_turret") {
      if(isDefined(var_1.type) && var_1.type != "cap_turret_missile_barrage") {
        if(isDefined(var_1.func_4D1E) && isDefined(var_1.func_4D1E.func_B428))
          var_00 = var_1.func_4D1E.func_B428;
      }
    }

    thread func_D13B(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    switch (var_04) {
      case "MOD_EXPLOSIVE_BULLET":
      case "MOD_RIFLE_BULLET":
      case "MOD_PISTOL_BULLET":
        thread func_D12F(var_00, var_02, var_03);
        break;
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
        break;
      case "MOD_PROJECTILE":
        thread func_D12F(var_00, var_02, var_03);
        break;
      case "MOD_IMPACT":
      case "MOD_PROJECTILE_SPLASH":
        thread func_D12F(var_00, var_02, var_03);
        break;
      case "MOD_EXPLOSIVE":
        thread func_D14E(var_00, var_02, var_03);
        var_00 = clamp(var_00, 0, 2000);
        break;
      default:
    }

    self.health = 999999;
    thread func_4CF3();
    thread func_D13E();

    if(self.func_9C28) {
      self.func_B154 = 1;
      continue;
    }

    if(self.func_B154 - var_00 > 0) {
      self.func_B154 = self.func_B154 - var_00;
      continue;
    }

    if(!func_12864() && !getdvarint("scr_jackalDemigod") && !func_D07A(var_02, var_04, var_09, var_01)) {
      if(isDefined(var_01) && var_01 == self) {
        continue;
      }
      self notify("script_death", var_04);
      return;
    }
  }
}

func_D136() {
  self endon("player_exit_jackal");
  self endon("script_death");
  var_00 = 50;
  var_01 = 2.8;
  var_02 = 200;
  var_03 = 2500;
  var_04 = spawnStruct();
  var_4.func_7567 = 2.0;
  var_4.func_7568 = 0;
  var_05 = 0;
  var_06 = 3;

  for(;;) {
    self waittill("spaceship_collision", var_07, var_08, var_09, var_10, var_11, var_12);

    if(isDefined(var_12) && isDefined(var_12.script_parameters) && var_12.script_parameters == "jackal_silent_collision") {
      continue;
    }
    if(_isgodmode(self.owner)) {
      continue;
    }
    if(level.func_241D) {
      var_13 = 1000;
      var_14 = 720;
    } else {
      var_13 = 1000;
      var_14 = 650;
    }

    var_15 = (var_13 + var_14) * 0.5;

    if(var_08 > 50) {
      var_16 = level.player getnormalizedmovement();
      var_17 = scripts\sp\math::func_C097(-1, 1, var_16[0]);
      var_18 = scripts\sp\math::func_6A8E(var_13, var_14, var_17);
    } else
      var_18 = var_15;

    var_18 = var_18 * level.func_A056.func_EBAD;
    var_19 = scripts\sp\math::func_C097(var_00, var_18, var_08);
    var_20 = scripts\sp\math::func_C097(0.1, 0.8, var_07);
    var_21 = scripts\sp\math::func_C097(0.1, 0.95, var_11);
    var_21 = scripts\sp\math::func_6A8E(0.6, 1.0, var_21);
    var_22 = var_19 * var_20 * var_20 * var_21;
    var_22 = var_22 * level.func_A48E.func_D3BC;

    if(scripts\sp\utility::func_D15B("hull"))
      var_22 = var_22 * 0.33;

    var_22 = clamp(var_22, 0, 1);
    var_04 thread func_D135(var_22);

    if(scripts\engine\utility::flag("flag_player_on_runway")) {
      continue;
    }
    if(var_22 > 0) {
      if(isDefined(var_12) && isDefined(var_12.vehicletype)) {
        if(var_12.vehicletype == "jackal_un" || var_12.vehicletype == "jackal_ca") {
          var_23 = 5000;
          var_24 = vectordot(anglesToForward(level.func_D127.angles), anglesToForward(var_12.angles));
          var_24 = scripts\sp\math::func_C097(-1, 1, var_24);
          var_24 = scripts\sp\math::func_6A8E(2, 1, var_24);
          var_22 = var_24;

          if(var_22 > 0.99)
            var_22 = 0.99;

          var_25 = scripts\sp\math::func_6A8E(0, var_23, var_22);

          if(isDefined(var_12.script_team) && var_12.script_team == "axis")
            var_12 getrandomarmkillstreak(var_25, level.func_D127.origin, level.func_D127, undefined, "MOD_IMPACT", "spaceship_cannon_projectile");
        }
      }

      var_26 = scripts\sp\math::func_6A8E(var_02, var_03, var_22);
      level.func_D127 getrandomarmkillstreak(var_26, var_10, undefined, undefined, "MOD_IMPACT");

      if(var_22 == 1) {
        if(!getdvarint("scr_jackalDemigod")) {
          self.func_4384 = 1;
          self notify("script_death", "MOD_IMPACT");
        }
      }
    }
  }
}

func_D135(var_00, var_01) {
  var_02 = 0.2;
  var_03 = 0.45;
  var_04 = 0.6;
  var_05 = 1.6;
  var_06 = 0.5;
  var_07 = 1.5;
  var_08 = 0.8;
  var_09 = 1.2;
  var_10 = scripts\sp\math::func_C097(0.3, 1, var_00);
  var_11 = scripts\sp\math::func_6A8E(var_02, var_03, var_00);
  var_12 = scripts\sp\math::func_6A8E(var_04, var_05, var_00);
  var_13 = scripts\sp\math::func_6A8E(var_06, var_07, var_10);
  var_14 = scripts\sp\math::func_6A8E(var_08, var_09, var_10);
  earthquake(var_11, var_12, level.func_D127.origin, 5000);

  if(var_00 > 0.5)
    level.player playrumbleonentity("grenade_rumbe");
  else if(var_00 > 0.25)
    level.player playrumbleonentity("damage_heavy");
  else
    level.player playrumbleonentity("damage_light");
}

func_D07A(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02) || var_02 == "spaceship_scripted_locked_enemy_bullets" || var_02 == "spaceship_homing_missile")
    return 0;

  if(func_0BDC::func_7B9E() < 25)
    return 0;

  if(!isDefined(var_00))
    return 0;

  var_04 = vectordot(anglesToForward(self.angles), var_00 * -1);

  if(var_04 > 0.83)
    return 0;
  else
    return 1;
}

func_4CF3() {
  self notify("damage_flash_mini_screen");
  self endon("damage_flash_mini_screen");
  setomnvar("ui_jackal_low_health", 1);
  wait 1.0;
  setomnvar("ui_jackal_low_health", 0);
}

func_D142() {
  self endon("player_exit_jackal");
  self waittill("script_death", var_00);
  self.func_5F6F = 1;

  if(isDefined(level.func_D127.func_432D))
    level.func_D127.func_432D ghostattack(0, 0.5);

  if(!isDefined(self.func_A56F) || !self.func_A56F) {
    func_0BDC::func_D16C(level.func_D127.origin, 0, 0, 0);
    func_0BDC::func_D165(level.func_D127.origin, 0, 0, 0);
  }

  func_0BDC::func_A149();
  func_0BDC::func_A14A();
  func_0BDC::func_A14E();
  func_0BDC::func_A151();
  func_0BDC::func_A153();
  func_0BDC::func_A156();
  func_D143();
  func_0B60::func_F32E();
  _missionfailed();
}

func_D143() {
  setomnvar("ui_jackal_deathquote", 1);
  self.func_4E04 = 0.2;
  thread func_D167();
  thread func_D196();
  func_D184(self.func_4E04);
  func_D141(self.func_4E04);
  self notify("death");
  var_00 = 0.2;
  scripts\sp\hud_util::func_6AA3(var_00, "black");
  wait(var_00);
}

func_D167() {
  self endon("death_fadeout");
  var_00 = func_79FF();
  var_00 fadeovertime(0.15);
  var_0.alpha = 0.9;
}

func_D196() {
  self endon("death_fadeout");
  wait 0.3;
  _setsaveddvar("spaceshipcollisionEventThreshold", 0);
  self waittill("spaceship_collision", var_00, var_01, var_02, var_03, var_04, var_05);
  self.func_4E04 = 0.3;
  self notify("stop_slowdeath");
}

func_D184(var_00) {
  self endon("stop_slowdeath");
  self endon("death_fadeout");
  earthquake(0.3, 1.0, level.func_D127.origin, 10000);
  level.player playSound("jackal_slow_death_plr_init");
  level.player _meth_8329("deathsdoor", "deathsdoor", "reverb");
  level.player setsoundsubmix("deaths_door_sp");
  level.func_D127 playrumbleonentity("damage_heavy");
  scripts\sp\utility::func_75C4("cockpit_dying_flames", "tag_body");
  func_0BDC::func_A080((randomfloatrange(-60, -3), randomfloatrange(-20, 20), randomfloatrange(-300, 300)), 0.3, "death");
  var_01 = getdvarint("bg_gravity");
  func_0BDC::func_A078((0, 0, -0.25 * var_01), 1, "death");
  thread func_D140();
  var_02 = func_7929();
  level.player _meth_8489("body", var_2[0], 0.2, var_2[1]);
  var_03 = getanimlength(var_2[0]) - var_2[2];
  var_03 = max(var_03, 0);
  visionsetnaked("jackal_dying", var_03);
  wait(var_03);
}

#using_animtree("jackal");

func_7929() {
  var_00 = [
    [ % jackal_pilot_strike_death, % jackal_vehicle_strike_death, 1],
    [ % heist_mons_attack_plr_flight_failtoeject, % heist_mons_attack_jackal_flight_failtoeject, 3.5],
    [ % jackal_pilot_assault_death, % jackal_vehicle_assault_death, 1],
    [ % jackal_pilot_assault_death01, % jackal_vehicle_assault_death01, 3.5],
    [ % jackal_pilot_assault_death02, % jackal_vehicle_assault_death02, 3],
    [ % jackal_pilot_assault_death03, % jackal_vehicle_assault_death03, 1],
    [ % jackal_pilot_assault_death04, % jackal_vehicle_assault_death04, 1]
  ];
  return scripts\engine\utility::random(var_00);
}

func_D141(var_00) {
  self notify("death_fadeout");
  scripts\sp\utility::func_75C4("cockpit_death_explo_huge", "tag_body");
  earthquake(0.55, 2, level.func_D127.origin, 15000);
  level.player stopsounds();
  level.func_D127 playSound("jackal_slow_death_plr");
  level.func_D127 stoploopsound();
  var_01 = func_79FF();
  visionsetnaked("jackal_death", var_00);
  var_01 fadeovertime(var_00);
  var_1.alpha = 0.0;
  wait(var_00);
}

func_D140() {
  self endon("stop_cockpit_explo");
  var_00 = randomintrange(2, 5);

  while(var_00 > 0) {
    func_D13F();
    var_0--;
    wait(randomfloatrange(0.2, 0.5));
  }
}

func_D13F(var_00) {
  if(!isDefined(var_00))
    var_00 = scripts\engine\utility::random([6, 8, 9, 3, 4]);

  if(var_00 < 10)
    var_01 = "0";
  else
    var_01 = "";

  var_00 = "tag_cockpit_damage_fx_" + var_01 + var_00;
  earthquake(randomfloatrange(0.25, 0.3), 0.6, level.func_D127.origin, 15000);
  scripts\sp\utility::func_75C4("cockpit_death_explo", var_00);
  thread func_D52F("jackal_death_plr_explo_int", var_00);
}

func_D13A() {
  var_00 = randomint(100) < 20;
  var_01 = randomint(100) < 40;

  if(var_00)
    var_02 = "_lrg";
  else if(var_01)
    var_02 = "_med";
  else
    var_02 = "";

  var_03 = randomintrange(1, 10);

  if(var_03 < 10)
    var_04 = "0";
  else
    var_04 = "";

  var_03 = "tag_cockpit_damage_fx_" + var_04 + var_03;
  scripts\sp\utility::func_75C4("cockpit_damage_sparks" + var_02, var_03);
  thread func_D52F("jackal_damage_cockpit_spark" + var_02, var_03);
}

func_D52F(var_00, var_01) {
  var_02 = scripts\engine\utility::spawn_script_origin();
  var_02 linkto(self, var_01, (0, 0, 0), (0, 0, 0));
  var_02 playSound(var_00);
  var_02 waittill("sounddone");
  var_02 delete();
}

func_D13B(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  self notify("jackal_damage_indicator");
  self endon("jackal_damage_indicator");

  if(level.player scripts\sp\utility::func_65DB("disable_jackal_damage_vision_distortion")) {
    return;
  }
  if(!isDefined(self.damage_pulse_time)) {
    self.damage_distortion_hold_time = 0;
    self.damage_distortion_fade_time = 0;
  }

  var_10 = 300;
  var_11 = clamp(var_00 / var_10, 0.4, 1);
  var_12 = self.func_B154 - var_00;

  if(var_12 <= 1 || self.func_9C28) {
    var_13 = "jackal_damage2";
    var_14 = 1.25;
  } else if(var_12 / scripts\sp\gameskill::func_7A59() < 0.5) {
    var_13 = "jackal_damage1";
    var_14 = 0.8;
  } else {
    var_13 = "jackal_damage";
    var_14 = 0.5;
  }

  self.damage_distortion_fade_time = self.damage_distortion_fade_time + var_14;
  self.damage_distortion_hold_time = 0.05;
  self.damage_distortion_fade_time = clamp(self.damage_distortion_fade_time, 0, 1.5);
  visionsetnaked(var_13, 0);

  while(self.damage_distortion_hold_time > 0) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }
    self.damage_distortion_hold_time = self.damage_distortion_hold_time - 0.05;
  }

  visionsetnaked("", self.damage_distortion_fade_time);
}

func_1284F() {
  self endon("cancel_try_cockpit_damage_vo");
  wait 0.3;
  var_00 = gettime();

  if(var_00 - self.func_A8A4 > 10000) {
    func_0BDC::func_A112("jackal_hud_cautiondamage", 0.3);
    self.func_A8A4 = var_00;
  }
}

func_12864() {
  if(self.func_3820) {
    self.func_9C28 = 1;
    self notify("stop_damage_caution_screen_flash");
    self.func_B154 = 1;
    level.player notify("jackal_near_death");
    self notify("cancel_try_cockpit_damage_vo");
    thread func_0BDC::func_A112("jackal_hud_warningcritical", 2, 2, 0.1);
    self.func_3820 = 0;
    thread func_A204();
    return 1;
  }

  if(self.func_9C28)
    return 1;

  return 0;
}

func_A204() {
  self endon("script_death");
  wait(level.func_A48E.func_D3BD / 1000);
  self.func_9C28 = 0;
  self notify("stop_player_invul");
  thread func_A205();
}

func_A205() {
  self endon("script_death");

  for(;;) {
    var_00 = float(self.func_B154) / float(scripts\sp\gameskill::func_7A59());

    if(var_00 >= 1.0) {
      break;
    }
    wait 0.05;
  }

  self.func_3820 = 1;
}

func_D13E() {
  self notify("damage_recover");
  self endon("damage_recover");
  self endon("script_death");

  if(isDefined(self.func_5763) && self.func_5763)
    var_00 = level.func_A48E.func_D3BF / 1000;
  else
    var_00 = level.func_A48E.func_D3C0 / 1000;

  wait(var_00);

  while(self.func_B154 < scripts\sp\gameskill::func_7A59()) {
    self.func_B154 = self.func_B154 + level.func_A48E.func_D3BB;

    if(self.func_B154 > scripts\sp\gameskill::func_7A59())
      self.func_B154 = scripts\sp\gameskill::func_7A59();

    scripts\engine\utility::waitframe();
  }
}

func_6AF0() {
  self endon("script_death");
  thread func_8CB1();
  level.player notifyonplayercommand("dpad_up", "+actionslot 1");
  level.player notifyonplayercommand("dpad_down", "+actionslot 2");
  level.player notifyonplayercommand("dpad_left", "+actionslot 3");

  for(;;) {
    var_00 = level.player scripts\engine\utility::waittill_any_return("dpad_up", "dpad_down", "dpad_left");

    if(var_00 == "dpad_up") {
      self.func_B154 = clamp(self.func_B154 + 200, 0, scripts\sp\gameskill::func_7A59());
      continue;
    }

    if(var_00 == "dpad_down") {
      self.func_B154 = clamp(self.func_B154 - 200, 0, scripts\sp\gameskill::func_7A59());
      continue;
    }

    if(var_00 == "dpad_left") {
      func_0BDC::func_A10C("incoming_missile");
      func_0BDC::func_A262("jackal_missile_incoming");
      scripts\engine\utility::delaythread(2.0, func_0BDC::func_A10A);
      scripts\engine\utility::delaythread(2.0, func_0BDC::func_1100E);
    }
  }
}

func_F481() {
  self.func_B154 = scripts\sp\gameskill::func_7A59();
}

func_8CB1() {
  self endon("script_death");
  var_00 = -1;

  for(;;) {
    if(self.func_B154 != var_00) {
      var_00 = self.func_B154;
      iprintlnbold("HP: " + var_00);
    }

    wait 0.05;
  }
}

func_11AB3() {
  self endon("script_death");
  self endon("player_exit_jackal");
  var_00 = func_79FF();
  var_01 = 0;
  self.func_5763 = 0;
  var_02 = 0;
  var_03 = -99999;
  var_04 = func_7857();
  var_05 = 0.4;
  var_06 = 1;

  for(;;) {
    var_07 = float(self.func_B154) / float(scripts\sp\gameskill::func_7A59());
    var_08 = clamp(1 - var_07, 0, 1);
    level.player.func_2875 = var_08 * 0.2;

    if(!var_01 && var_07 <= 0.5 && self.func_B154 > 1 && !self.func_5763) {
      func_0BDC::func_A261("jackal_damaged_alarm");
      level.player setsoundsubmix("jackal_damage", 0.5);
      func_0BDC::func_A10B("damage_alarm");
      level.player thread func_A13A(3, 0.8);
      thread func_1284F();
      var_01 = 1;
    } else if(var_01 && var_07 > 0.5) {
      func_0BDC::func_1100D("jackal_damaged_alarm");
      level.player clearsoundsubmix();
      func_0BDC::func_A10B("default");
      var_01 = 0;
    } else if(var_01 && (self.func_B154 <= 1 || self.func_5763)) {
      func_0BDC::func_1100D("jackal_damaged_alarm");
      var_01 = 0;
    }

    if(self.func_B154 <= 1 && !self.func_5763) {
      func_0BDC::func_A261("jackal_severe_damaged_alarm");
      level.player setsoundsubmix("jackal_damage", 1);
      func_0BDC::func_A10B("damage_alarm");
      level.player thread func_A13A(3, 0.8);
      self.func_5763 = 1;
    } else if(self.func_5763 && var_07 > 0.5) {
      func_0BDC::func_1100D("jackal_severe_damaged_alarm");
      level.player clearsoundsubmix();
      func_0BDC::func_A10B("default");
      setomnvar("ui_jackal_critical_health", 0);
      self.func_5763 = 0;
    }

    if(isDefined(self.func_728F))
      var_06 = self.func_728F;
    else
      var_06 = min(var_07, var_06);

    if(var_06 < var_05) {
      var_09 = scripts\sp\math::func_C097(0, var_05, var_06);
      var_10 = scripts\sp\math::func_6A8E(0.1, 1, var_09);
      var_11 = (gettime() - var_03) / 1000;
      var_12 = var_04 * var_10;

      if(var_11 > var_12) {
        thread func_D13A();
        var_03 = gettime();
        var_04 = func_7857();
      }

      var_06 = var_06 + 0.004;
    }

    if(var_08 <= 0.2) {
      if(var_02 != 0.2) {
        var_02 = 0;
        var_00 fadeovertime(0.15);
        var_0.alpha = var_02;
        self notify("stop_flashing_red");
      }
    } else if(var_08 <= 0.3) {
      if(var_02 != 0.25) {
        var_02 = 0.25;
        thread func_DAEA(0.25, 0.25, 0.2);
      }
    } else if(var_08 <= 0.5) {
      if(var_02 != 0.5) {
        var_02 = 0.5;
        thread func_DAEA(0.25, 0.5, 0.4);
      }
    } else if(var_08 <= 0.7) {
      if(var_02 != 0.65) {
        var_02 = 0.65;
        thread func_DAEA(0.2, 0.65, 0.5);
      }
    } else if(var_08 <= 0.9) {
      if(var_02 != 0.8) {
        var_02 = 0.8;
        thread func_DAEA(0.15, 0.8, 0.6);
      }
    } else if(var_08 > 0.9) {
      if(var_02 != 1.0) {
        var_02 = 1.0;
        thread func_DAEA(0.1, 1.0, 0.8);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_A2B3(var_00) {
  if(!var_00)
    level.func_D127.func_728F = undefined;
  else {
    var_00 = clamp(var_00, 0, 1);
    level.func_D127.func_728F = 1 - var_00;
  }
}

func_7857() {
  return randomfloatrange(1, 4);
}

func_DAEA(var_00, var_01, var_02) {
  self notify("pulse_health_overlay");
  self endon("pulse_health_overlay");
  self endon("player_exit_jackal");
  self endon("stop_flashing_red");
  self endon("script_death");
  var_03 = func_79FF();

  if(!isDefined(var_00))
    var_00 = 0.1;

  if(!isDefined(var_01))
    var_01 = 1.0;

  if(!isDefined(var_02))
    var_02 = 0.5;

  var_04 = var_00 * 2.0;
  var_05 = var_00;

  for(;;) {
    var_03 fadeovertime(var_00);
    var_3.alpha = var_01;
    wait(var_00 + var_05);
    var_03 fadeovertime(var_04);
    var_3.alpha = var_02;
    wait(var_04);
  }
}

func_A13A(var_00, var_01) {
  if(scripts\sp\utility::func_65DB("player_no_auto_blur")) {
    return;
  }
  self notify("blurview_stop");
  self endon("blurview_stop");
  self setblurforplayer(var_00, 0);
  wait 0.05;
  self setblurforplayer(0, var_01);
}

func_79FF() {
  if(!isDefined(self.func_8CAE)) {
    self.func_8CAE = scripts\sp\hud_util::func_48B7("hud_jackal_overlay_damage", 0, level.player);
    self.func_8CAE.func_B3D2 = 1;
  }

  return self.func_8CAE;
}

func_D12F(var_00, var_01, var_02) {
  if(self.func_9C28)
    var_00 = var_00 * 1.5;

  var_03 = scripts\sp\math::func_C097(0, 300, var_00);
  var_04 = scripts\sp\math::func_6A8E(0.15, 0.39, var_03);
  earthquake(var_04, 0.4, level.func_D127.origin, 50000);

  if(var_03 > 0.6)
    level.player playrumbleonentity("damage_heavy");
  else if(var_03 > 0.3)
    level.player playrumbleonentity("damage_light");

  var_05 = scripts\sp\math::func_6A8E(1.3, 2.0, var_03);
  thread func_0BDC::func_D527("jackal_bullet_impact_player", var_02, undefined, var_05, self);
  func_4CFF(var_03, var_01, var_02, 1, "bullet_impact");
}

func_D130(var_00, var_01, var_02) {
  var_03 = scripts\engine\utility::spawn_tag_origin();
  var_04 = var_01 - level.func_D127.origin;
  var_05 = vectornormalize(var_04);
  var_06 = rotatevectorinverted(var_05, level.func_D127.angles);
  var_07 = var_6[0];
  var_08 = var_6[1] * -1;
  var_09 = var_6[2];
  var_07 = scripts\sp\math::func_C097(-1, 1, var_07);
  var_07 = var_07 * var_07;
  var_07 = var_07 * 0.6;
  var_10 = vectornormalize((var_07, var_08, var_09));
  var_11 = level.func_D127 gettagangles("j_mainroot_ship");
  var_12 = level.func_D127 gettagorigin("tag_camera");
  var_13 = var_10[0] * 55;
  var_14 = var_10[1] * 25;
  var_15 = var_10[2] * 25;
  var_16 = (var_13, var_14, var_15);
  var_03 func_0BDC::func_A25B(0, "tag_camera", var_16, (0, 0, 0));
  wait 0.5;
  var_03 delete();
}

func_D14E(var_00, var_01, var_02) {
  var_03 = scripts\sp\math::func_C097(100, 1000, var_00);
  var_04 = scripts\sp\math::func_6A8E(0.01, 0.4, var_03);
  earthquake(var_04, 0.75, level.func_D127.origin, 50000);

  if(var_03 > 0.6)
    level.player playrumbleonentity("damage_heavy");
  else if(var_03 > 0.3)
    level.player playrumbleonentity("damage_light");

  var_05 = scripts\sp\math::func_6A8E(0.3, 1.5, var_03);
  thread func_0BDC::func_D527("explosive_impact_player_jackal", var_02, undefined, var_05);
  var_01 = vectornormalize(level.func_D127.origin - var_02);

  if(scripts\sp\utility::func_93A6())
    thread func_4D00(var_03, var_01, var_02, 2);
  else
    func_4CFF(var_03, var_01, var_02, 2);
}

func_88DB() {
  if(!isDefined(level.func_10147)) {
    return;
  }
  while(!isDefined(level.func_D127))
    wait 0.05;

  var_00 = 0;
  var_01 = 0;
  var_02 = newhudelem();
  var_2.x = var_00;
  var_2.y = var_01;
  var_2.alignx = "left";
  var_2.aligny = "top";
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_02 give_zap_perk("Jackal Health: ");
  var_03 = newhudelem();
  var_3.x = var_00 + 60;
  var_3.y = var_01 + 2;
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_03 setshader("white", 104, 8);
  var_04 = newhudelem();
  var_4.x = var_00 + 62;
  var_4.y = var_01 + 2;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_04 setshader("black", 100, 8);

  for(;;) {
    wait 0.05;

    if(!isDefined(level.func_D127)) {
      var_02 destroy();
      var_03 destroy();
      var_04 destroy();
      return;
    }

    var_05 = level.func_D127;
    var_06 = 0;

    if(isDefined(var_5.func_B154))
      var_06 = var_5.func_B154 / scripts\sp\gameskill::func_7A59();

    var_04 setshader("black", int(var_06 * 100), 8);
  }
}

func_B81C(var_00) {
  var_01 = distance(var_00, level.func_D127.origin);
  var_02 = 1 - scripts\sp\math::func_C097(100, 30000, var_01);
  var_03 = scripts\sp\math::func_6A8E(0.01, 0.4, var_02);
  earthquake(var_03, 0.75, level.func_D127.origin, 50000);

  if(var_02 > 0.6)
    level.player playrumbleonentity("damage_heavy");
  else if(var_02 > 0.3)
    level.player playrumbleonentity("damage_light");

  var_04 = vectornormalize(level.func_D127.origin - var_00);
  var_02 = 1 - scripts\sp\math::func_C097(300, 10000, var_01);
  func_4CFF(var_02, var_04, var_00, 2);
}

func_4D00(var_00, var_01, var_02, var_03, var_04) {
  if(level.func_D127.func_10A0D) {
    return;
  }
  level.func_D127.func_10A0D = 1;
  var_03 = 1.5;
  var_00 = clamp(var_00, 0.1, 1);
  var_05 = 120;
  var_06 = (70, 40, 200);

  if(scripts\engine\utility::cointoss())
    var_06 = var_06 * -1;

  earthquake(var_00, 0.75, level.func_D127.origin, 50000);
  func_0BDC::func_A079(var_02, var_05 * var_00, 0.05 * var_03, var_03, var_04);
  func_0BDC::func_A07E(var_06 * var_00, var_00 / 2, var_00 / 2, var_04);
  wait(var_00);
  var_06 = var_06 * -1;
  func_0BDC::func_A07E(var_06 * var_00, var_00 / 2, var_00 / 2, var_04);
  wait(var_00);
  level.func_D127.func_10A0D = 0;
  earthquake(var_00 / 2, 0.25, level.func_D127.origin, 50000);
}

func_4CFF(var_00, var_01, var_02, var_03, var_04) {
  if(scripts\sp\utility::func_93A6()) {
    if(level.func_D127.func_10A0D) {
      return;
    }
    var_05 = 10;
    var_06 = 1;
    var_00 = clamp(var_00, 0, 1);
    var_07 = scripts\sp\math::func_6A8E(0.01, 75 * level.func_A056.func_EBAD, var_00);
    var_08 = vectortoangles(var_01);
    var_08 = anglesToForward(var_08) * -1;
    var_08 = var_08 * var_06;
    func_0BDC::func_A079(var_02, var_05 * var_00, 0.05 * var_03, var_03, var_04);
    func_0BDC::func_A07E(var_08 * var_00, 0.2 * var_03, var_03, var_04);
  } else {
    var_00 = clamp(var_00, 0, 1);
    var_07 = scripts\sp\math::func_6A8E(0.01, 75 * level.func_A056.func_EBAD, var_00);
    func_0BDC::func_A079(var_02, var_07, 0.05 * var_03, var_03, var_04);
    var_09 = rotatevectorinverted(var_01, level.func_D127.angles);
    var_07 = scripts\sp\math::func_6A8E(0, 6, var_00);
    var_10 = var_9[0] * var_07;
    var_11 = var_9[1] * var_07;
    var_12 = var_9[1] * var_07 * -1;
    var_13 = (var_10, var_11, var_12);
    var_07 = scripts\sp\math::func_6A8E(0, 5, var_00);
    var_10 = var_9[0] * var_07 * -1;
    var_11 = var_9[1] * var_07;
    var_12 = var_9[1] * var_07 * -1;
    var_14 = (var_10, var_11, var_12);
    func_0BDC::func_A07E(var_13, 0.2 * var_03, var_03, var_04);
    func_0BDC::func_A081(var_14, 0.2 * var_03, var_03 * 0.3, var_04);
  }
}

func_3A02(var_00, var_01, var_02, var_03, var_04, var_05) {
  func_0BDC::func_A079(var_00, var_01, var_04, var_05);
  func_0BDC::func_A301(var_02, var_04, "cap_death");
  func_0BDC::func_D165(var_00, var_03, 1, var_04);
  wait(var_04);
  func_0BDC::func_A301(1, var_05, "cap_death");
  func_0BDC::func_D165(var_00, 0, 1, var_05);
}

func_4086() {
  thread func_4087();
}

func_4087() {
  var_00 = 0.3;
  var_01 = func_79FF();
  var_01 fadeovertime(var_00);
  var_1.alpha = 0.0;
  wait(var_00);
  var_01 destroy();
}