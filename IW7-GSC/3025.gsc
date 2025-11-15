/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3025.gsc
***************************************/

func_68B4() {
  var_00 = spawnStruct();
  var_0.func_68B6 = [];
  var_0.running = 0;
  var_0.func_54F1 = 1;
  return var_00;
}

func_686B() {
  func_0BDC::func_A1AA("enemy_lockon", ::func_6827, ::func_6826, ::func_6828);
  func_0BDC::func_A1AA("enemy_missileVolley", ::func_682B, ::func_6829, ::func_682C);
  func_0BDC::func_A1AA("enemy_hoverheat_missiles", ::func_6823, ::func_6822, ::func_6824);
  func_0BDC::func_A1AA("ai_ambient_missileVolley", ::func_67E9, ::func_67E8, ::func_67EA);
  func_0BDC::func_A1AA("enemy_strafeAttack", ::func_6831, ::func_682F, ::func_6832);
}

func_686A() {
  level.func_D127 endon("player_exit_jackal");
  func_686B();
  func_0BDC::func_137DA();

  for(;;) {
    foreach(var_02, var_01 in level.func_A056.func_68B3.func_68B6) {
      if(level.func_A056.func_68B3 func_6809(var_01) && [
          [var_1.func_10974]
        ](var_01)) {
        level.func_A056.func_68B3 func_6882(var_01, var_02);
        level.func_A056.func_68B3 thread func_680D(var_01);
        func_680A();
      }

      wait 0.05;
    }
  }
}

func_6882(var_00, var_01) {
  self.running = 1;
  self.func_00C8 = var_01;
  var_0.running = 1;
  var_0.func_680B = 0;
  self[[var_0.main]](var_00);
  var_00 notify("event_complete");
  var_0.func_680B = 1;
  var_0.running = 0;
  self.func_00C8 = "";
  self.running = 0;
}

func_680D(var_00) {
  var_0.cooling_down = 1;
  self[[var_0.func_4623]](var_00);
  var_0.cooling_down = 0;
}

func_680A() {
  wait(randomfloatrange(1, 4));
}

func_6809(var_00) {
  if(self.func_54F1)
    return 0;

  if(scripts\engine\utility::flag("jackal_missile_drone_active"))
    return 0;

  if(var_0.func_54F1)
    return 0;

  if(var_0.cooling_down)
    return 0;

  return 1;
}

func_5F9C(var_00) {
  while(!level.player buttonpressed("DPAD_DOWN"))
    wait 0.05;

  foreach(var_02 in var_00) {
    if(isDefined(var_02))
      var_02 func_0BDC::func_A36A();
  }

  func_0BDC::func_A1A9(0);
  func_0BDC::func_A1AD("enemy_missileVolley");
  func_6889();
}

func_6889() {
  while(!isDefined(level.func_D127.func_93D2) || level.func_D127.func_93D2.size == 0)
    wait 0.05;

  wait 3;
  func_0BDC::func_A1AA("save_salter", ::func_6887, ::func_6886, ::func_6888);
}

func_6887(var_00) {
  var_0.func_10A45 = "salter_dogandpony_path";
  var_01 = _getcsplineid(var_0.func_10A45);
  return 1;
}

func_688E(var_00) {
  var_01 = 300;
  var_02 = _getcsplineid(var_0.func_10A45);
  var_03 = getent("salter_dogandpony", "targetname");
  level.func_EA99 = func_688C(var_03, var_01);
  level.func_EA99 func_0BDC::func_1998();
  level.func_EA99 thread func_0BDC::func_A1EF(var_02);
  level.func_EA99 thread func_0C1B::func_6EAC();
  wait 1.2;
  var_04 = getent("salter_enemy_dogandpony", "targetname");
  var_0.enemy = func_688C(var_04, var_01);
  var_0.enemy thread func_0BDC::func_A1EF(var_02);
  wait 0.2;
  var_0.enemy makeentitysentient("axis", 0);
  level.func_EA99 func_0BDC::func_105DB("jackal", undefined, "ally_jackal", "ally_jackal");
  var_0.enemy thread func_0BDC::func_105DB("ace", "JACKAL_ACE_SKELTER", "jackal", "enemy_jackal", 1);
  level.func_EA99 func_0BDC::func_1998();
  var_0.enemy func_0C1C::init();
  var_05 = -5000;
}

func_688C(var_00, var_01) {
  var_02 = var_00 scripts\sp\utility::func_10808();
  var_2.ignoreme = 1;
  var_02 func_0BDC::func_19AB(var_01);
  var_02 func_0BDC::func_F43D("fake");
  return var_02;
}

func_6886(var_00) {
  func_688E(var_00);
  var_0.enemy func_0BDC::func_A36D();
  level.func_EA99 func_0BDC::func_A36D();
  var_0.enemy thread func_6892();
  var_0.enemy thread func_688D();
  var_0.enemy thread func_688B();
  level.func_EA99 thread func_688A();

  while(isalive(var_0.enemy))
    wait 0.05;

  level notify("salter_saved");
  level.func_EA99 func_0BDC::func_A36A();
}

func_6892() {
  self endon("death");

  for(;;) {
    func_0BDC::func_19AE("lead_burst");
    self waittill("stop soundjackal_gatling_fire");
    wait 0.05;
    func_0BDC::func_19AE("dont_shoot");
    wait(randomfloatrange(0.3, 0.7));
  }
}

func_688D() {
  self endon("death");

  if(!isDefined(level.func_EA99.func_93D2))
    level.func_EA99.func_93D2 = [];

  for(;;) {
    func_0B76::func_1945(level.func_EA99, ["tag_flash_right", "tag_flash_left"], randomintrange(1, 3));

    while(level.func_EA99.func_93D2.size > 0)
      wait 0.05;

    wait(randomfloatrange(2, 4));
  }
}

func_688B() {
  self endon("death");

  for(;;) {
    while(!self.func_AEDF.func_2A93 && !level.player buttonpressed("button_lstick"))
      wait 0.05;

    func_0BDC::func_1991();
  }
}

func_688A() {
  self endon("death");

  for(;;) {
    while(!isDefined(self.func_93D2) || self.func_93D2.size == 0)
      wait 0.05;

    func_0BDC::func_1991();
  }
}

func_6890() {
  level endon("salter_saved");
  level endon("event_missile_out");
  func_11685("Salter", "shit - i got one on me!");
  func_11685("Reyes", "countermeasures!");
  func_11685("Salter", "Runnin low");
  func_11685("Reyes", "on my way, hang in there");
  func_11685("Salter", "i got thisguy doesnt know who hes doggin with");
  func_11685("Reyes", "easy salt, easy");
  func_11685("slater", "Reyes, where are you?");
  func_11685("Reyes", "easy salt, easy");
  func_11685("slater", "Im getting boxed in, Raider, throttle up");
  func_11685("Reyes", "patience is a virtue");
  func_11685("slater", "Im gonna kill you");
  scripts\sp\utility::func_28D7();
  scripts\sp\utility::func_CF8B();
}

func_688F(var_00) {
  while(!isDefined(var_0.func_93D2) || var_0.func_93D2.size == 0)
    wait 0.05;

  level notify("event_missile_out");
  func_11685("reyes", "got a shot- fox out!");
}

func_6891() {
  scripts\sp\utility::func_28D8();
  scripts\sp\utility::func_CF8D();
  func_11685("Reyes", "splash one - he's down");
  func_11685("slater", "good kill.Took you long enough");
  func_11685("Reyes", "saved your ass, dont gimme shit");
}

func_6888(var_00) {
  func_0BDC::func_A1AD("save_salter");
}

func_11685(var_00, var_01, var_02) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level.func_545A))
    level.func_545A = [];

  var_03 = 0;

  for(;;) {
    if(!isDefined(level.func_545A[var_03])) {
      break;
    }
    var_3++;
  }

  var_04 = "^3";

  if(!isDefined(var_02))
    var_02 = 1;

  var_02 = max(1, var_02);
  level.func_545A[var_03] = 1;
  var_05 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_5.location = 0;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.alpha = 0;
  var_05 fadeovertime(0.5);
  var_5.alpha = 1;
  var_5.x = 40;
  var_5.y = 260 + var_03 * 18;
  var_5.label = " " + var_04 + "< " + var_00 + " > ^7" + var_01;
  var_5.color = (1, 1, 1);
  wait(var_02);
  var_06 = 10.0;
  var_05 fadeovertime(0.5);
  var_5.alpha = 0;

  for(var_07 = 0; var_07 < var_06; var_7++) {
    var_5.color = (1, 1, 0 / (var_06 - var_07));
    wait 0.05;
  }

  wait 0.25;
  var_05 destroy();
  level.func_545A[var_03] = undefined;
}

func_67E9(var_00) {
  if(level.func_A056.func_191E.size == 0 || level.func_A056.func_1914.size == 0)
    return 0;

  if(!isDefined(var_0.func_A419) || var_0.func_A419.size == 0)
    var_0.func_A419 = level.func_A056.func_1630;

  var_01 = anglesToForward(level.func_D127.angles);
  var_02 = -1;
  var_03 = 10;

  foreach(var_05 in var_0.func_A419) {
    var_2++;

    if(var_02 > var_03)
      return 0;

    if(!isDefined(var_05) || !isalive(var_05)) {
      var_0.func_A419 = scripts\engine\utility::array_remove(var_0.func_A419, var_05);
      continue;
    }

    if(!var_05 func_0BDC::func_3819()) {
      continue;
    }
    if(var_05 func_0BDC::func_9C06()) {
      continue;
    }
    if(var_5.func_AEDF.func_2A93) {
      continue;
    }
    if(isDefined(var_5.func_93D2) && var_5.func_93D2.size > 0) {
      continue;
    }
    var_06 = anglesToForward(var_5.angles);
    var_07 = var_5.origin + var_06 * 9000;
    var_08 = var_07 - level.func_D127.origin;
    var_09 = vectordot(vectornormalize(var_08), var_01);

    if(var_09 < 0.9) {
      var_0.func_A419 = scripts\engine\utility::array_remove(var_0.func_A419, var_05);
      continue;
    }

    var_10 = length(var_08);

    if(var_10 > 150000 || var_10 < 15000) {
      var_0.func_A419 = scripts\engine\utility::array_remove(var_0.func_A419, var_05);
      continue;
    }

    var_0.func_1152A = var_05;
    break;
  }

  if(!isDefined(var_0.func_1152A))
    return 0;

  wait 0.05;

  if(!isDefined(var_0.func_1152A)) {
    var_0.func_A419 = scripts\engine\utility::array_remove(var_0.func_A419, var_0.func_1152A);
    return 0;
  }

  if(var_0.func_1152A.script_team == "allies")
    var_12 = level.func_A056.func_191E;
  else
    var_12 = level.func_A056.func_1914;

  foreach(var_05 in var_12) {
    if(!isDefined(var_05) || !isalive(var_05)) {
      continue;
    }
    if(!var_05 func_0BDC::func_3819()) {
      continue;
    }
    var_08 = var_0.func_1152A.origin - var_5.origin;
    var_10 = length(var_08);

    if(var_10 > 20000 || var_10 < 5000) {
      continue;
    }
    var_06 = anglesToForward(var_5.angles);
    var_14 = vectordot(vectornormalize(var_08), var_06);

    if(var_14 < 0.1) {
      continue;
    }
    var_0.func_2522 = var_05;
    break;
  }

  if(!isDefined(var_0.func_2522)) {
    var_0.func_A419 = scripts\engine\utility::array_remove(var_0.func_A419, var_0.func_1152A);
    return 0;
  }

  return 1;
}

func_67E8(var_00) {
  var_0.func_2522 func_0B76::func_1945(var_0.func_1152A, ["tag_flash_right", "tag_flash_left"], randomintrange(1, 3));
}

func_11078(var_00, var_01) {
  wait 5;
  var_00 notify("stop_line");
  var_01 notify("stop_line");
}

func_67EA(var_00) {
  var_0.func_1152A = undefined;
  var_0.func_2522 = undefined;
  wait(randomfloatrange(0.5, 2));
}

func_6823(var_00) {
  if(func_F0C6(2))
    return 0;

  if(level.func_90E2.func_1112E == 0)
    return 0;

  var_01 = anglesToForward(level.func_D127.angles);
  var_0.func_A419 = scripts\engine\utility::array_removeundefined(level.func_A056.func_933B);

  if(var_0.func_A419.size == 0)
    return 0;

  foreach(var_03 in var_0.func_A419) {
    if(!var_03 func_6825(var_01)) {
      continue;
    }
    var_0.enemy = var_03;
    var_0.func_907F = 1;
    return 1;
  }

  return 0;
}

func_6825(var_00) {
  if(!func_0BDC::func_9C06())
    return 0;

  if(isDefined(self.var_1198.func_90EB) && gettime() - self.var_1198.func_90EB < 2000)
    return 0;

  if(!level.player scripts\sp\utility::func_65DB("jackal_enemy_homing_missile_allowed_hyperaggressive"))
    return 0;

  var_01 = anglesToForward(self.angles);
  var_02 = self.origin - level.func_D127.origin;
  var_03 = length(var_02);

  if(var_03 > 25000 || var_03 < 500)
    return 0;

  var_04 = vectordot(vectornormalize(level.func_D127.origin - self.origin), var_01);

  if(var_04 < 0.7)
    return 0;

  var_04 = vectordot(vectornormalize(var_02), var_00);

  if(var_04 < 0.85)
    return 0;

  return 1;
}

func_6822(var_00) {
  if(var_0.func_907F)
    var_00 func_686E(["tag_flash_right", "tag_flash_left"], randomintrange(2, 4));

  var_0.enemy.var_1198.func_90EB = gettime();
}

func_6824(var_00) {
  var_0.enemy = undefined;
  wait(randomfloatrange(0.0, 2.0));
  var_0.func_A8E9 = gettime();
}

func_682B(var_00) {
  return func_682A(var_00, 1);
}

func_682D(var_00) {
  return func_682A(var_00, 0);
}

func_682A(var_00, var_01) {
  if(func_F0C6(3))
    return 0;

  if(!level.player scripts\sp\utility::func_65DB("jackal_enemy_homing_missile_allowed"))
    return 0;

  if(func_D30D())
    return 0;

  var_02 = anglesToForward(level.func_D127.angles);

  if(!isDefined(var_0.func_A419) || var_0.func_A419.size == 0)
    var_0.func_A419 = level.func_A056.func_1630;

  var_03 = -1;
  var_04 = 5;

  foreach(var_06 in var_0.func_A419) {
    var_3++;

    if(var_03 > var_04)
      return 0;

    if(!var_06 func_682E(var_02, var_01)) {
      var_0.func_A419 = scripts\engine\utility::array_remove(var_0.func_A419, var_06);
      continue;
    }

    var_0.enemy = var_06;
    return 1;
  }

  return 0;
}

func_682E(var_00, var_01) {
  if(!isDefined(self) || !isalive(self) || self.script_team != "axis")
    return 0;

  if(!func_0BDC::func_3819())
    return 0;

  var_02 = anglesToForward(self.angles);
  var_03 = self.origin + var_02 * 9000;
  var_04 = var_03 - level.func_D127.origin;
  var_05 = vectordot(vectornormalize(var_04), var_00);

  if(var_01)
    var_06 = 0.97;
  else
    var_06 = 0.8;

  if(var_05 < var_06)
    return 0;

  var_07 = length(var_04);

  if(var_07 > 35000 || var_07 < 10000)
    return 0;

  if(var_01) {
    var_08 = vectordot(vectornormalize(level.func_D127.origin - self.origin), var_02);

    if(var_08 < -0.1)
      return 0;
  }

  return 1;
}

func_6829(var_00) {
  var_00 func_686E(["tag_flash_right", "tag_flash_left"], 3);
  var_00 func_64DF();
}

func_682C(var_00) {
  var_0.enemy = undefined;
  wait(randomfloatrange(15, 40));
}

func_686E(var_00, var_01, var_02) {
  self.enemy endon("death");

  if(!isDefined(self.func_B8A4))
    self.func_B8A4 = [];

  self.enemy func_0B76::func_A278();

  if(!isDefined(var_02))
    var_02 = 0;

  if(var_02) {
    var_03 = 1;
    var_04 = 3000;
  } else {
    wait 0.5;
    var_03 = undefined;
    var_04 = 300;
  }

  self.func_6DA7 = 1;
  var_05 = 0;

  while(var_01 > 0) {
    if(var_05 == var_0.size)
      var_05 = 0;

    var_06 = var_0[var_05];
    var_5++;

    if(isDefined(self.enemy) && !self.func_680B) {
      var_07 = self.enemy thread func_0B76::func_1992(var_06, level.func_D127, undefined, var_03, var_04);
      var_7.func_438D = self.enemy;
      self.func_B8A4 = scripts\engine\utility::array_add(self.func_B8A4, var_07);

      if(!var_02)
        var_07 func_0B76::func_A279();
      else {
        var_07 linkto(self.enemy);
        var_07 thread func_0B76::func_B804();
      }
    } else
      break;

    var_1--;
    wait 0.3;
  }

  self.func_6DA7 = 0;
}

func_6831(var_00) {
  if(func_F0C6(3))
    return 0;

  if(level.func_D127.spaceship_boosting)
    return 0;

  if(level.func_D127.func_93D2.size > 0)
    return 0;

  if(scripts\sp\utility::func_7B9D() < 0.5)
    return 0;

  if(isDefined(level.func_D127.func_4BC7))
    return 0;

  if(!func_647A(var_00))
    return 0;

  func_6521(var_00);

  if(!isDefined(var_0.enemy))
    return 0;

  return 1;
}

func_682F(var_00) {
  level thread func_6835(var_0.enemy, var_0.func_6516, var_0.func_6458);
  var_0.enemy = undefined;
}

func_6835(var_00, var_01, var_02) {
  if(!isDefined(var_00)) {
    return;
  }
  var_00 endon("death");
  var_00 endon("stop_strafeattack");
  var_03 = spawnvehicle("veh_mil_air_un_jackal_02", "player_sled", "jackal_un", level.func_D127.origin, level.func_D127.angles);
  var_03 hide();
  var_03 notsolid();
  var_03 makeentitysentient("allies", 0);
  var_03 linkto(var_00, "j_mainroot_ship", (8000, 0, 0), (0, 0, 0));
  var_04 = scripts\engine\utility::spawn_script_origin();
  var_0.ignoreme = 1;
  var_00 func_0BDC::func_19A2();
  var_00 func_0BDC::func_199B();
  var_00 func_0BDC::func_19B0("fly");
  var_00 vehicle_teleport(var_01, level.func_D127.angles);
  var_00 linkto(level.func_D127);
  var_00 notsolid();
  var_00 scripts\engine\utility::delaycall(3, ::solid);
  var_00 thread func_6834();
  var_00 thread func_6836(var_03, var_04);
  var_00 thread func_6830(var_03, var_04);
  wait 0.15;
  var_00 unlink();
  var_00 _meth_8455(var_02, 0);

  for(;;) {
    var_05 = distance(var_0.origin, var_02);

    if(var_05 < 8000) {
      break;
    }
    wait 0.05;
  }

  var_0.var_3135.func_3F28 = var_00 func_0A0D::func_7E02(50000, 3000);

  if(isDefined(var_0.var_3135.func_3F28))
    var_00 func_0A0D::func_6CAB(undefined, "spline");

  var_00 notify("stop_strafeattack");
}

func_6830(var_00, var_01) {
  scripts\engine\utility::waittill_any("death", "damage", "stop_strafeattack");

  if(isDefined(self)) {
    self.ignoreme = 0;
    func_0BDC::func_198A();
    func_0BDC::func_19AB();
    func_0BDC::func_1986();
    func_0BDC::func_1980();
    scripts\engine\utility::delaythread(1, func_0BDC::func_19B0, "none");
    scripts\engine\utility::delaythread(5, func_0BDC::func_198D);
    func_0BDC::func_19AE("shoot_at_will");
    self notify("stop_strafeattack");
    self notify("near_goal");
  }

  if(isDefined(var_00))
    var_00 delete();

  var_01 delete();
}

func_6836(var_00, var_01) {
  self endon("stop_strafeattack");
  self endon("death");
  func_0BDC::func_19AE("shoot_forever");
  func_0BDC::func_1980(scripts\sp\utility::func_7B9D(), 1);
  func_0BDC::func_19B5(level.func_D127);
  func_6833(var_01);
  func_0BDC::func_19B5(var_00);
  wait(randomfloatrange(1.0, 1.2));
  func_0BDC::func_198A();
  var_00 delete();
  func_0BDC::func_19AE("shoot_at_will");
  func_0BDC::func_1980();
}

func_6833(var_00) {
  self endon("stop_strafeattack");
  self endon("death");
  var_01 = 150;
  var_02 = -200;
  var_03 = 8;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }
    if(func_0B76::func_7A60(self.origin) > 0) {
      break;
    }
    if(var_03 == 0) {
      break;
    }
    var_04 = vectornormalize(self.origin - level.func_D127.origin);
    var_0.origin = level.func_D127.origin + var_04 * var_02;
    var_00 playSound("enemy_lockon_bullet_impacts");
    thread scripts\engine\utility::play_sound_in_space("enemy_lockon_whizby", var_0.origin);

    if(scripts\sp\utility::func_7B9D() > 0.6)
      level.func_D127 getrandomarmkillstreak(50, self.origin, self, self, "MOD_PROJECTILE", "spaceship_scripted_locked_enemy_bullets");

    wait 0.1;
    var_3--;
  }
}

func_6832(var_00) {
  var_01 = randomfloatrange(2, 10);

  for(var_02 = 0; var_01 > 0; var_01 = var_01 - 0.05) {
    if(level.func_D127.spaceship_mode == "hover")
      var_02 = var_02 + 0.05;
    else
      var_02 = 0;

    if(var_02 > 3) {
      break;
    }
    wait 0.05;
  }
}

func_6834() {
  self endon("stop_strafeattack");
  self endon("death");
  var_00 = randomintrange(0, 100);
  var_01 = func_7CB3(var_00);
  func_0BDC::func_19AB(var_01, 3500);
  wait 0.5;

  for(;;) {
    var_01 = func_7CB3(var_00);
    func_0BDC::func_19AB(var_01, 380);
    wait 0.5;
  }
}

func_7CB3(var_00) {
  var_01 = func_0BDC::func_7B9E() + 200 + var_00;
  return clamp(var_01, 400, 1000);
}

func_6521(var_00) {
  var_01 = undefined;
  level.func_A056.func_1630 = scripts\engine\utility::array_removeundefined(level.func_A056.func_1630);

  foreach(var_03 in level.func_A056.func_191E) {
    if(!var_03 func_6508()) {
      continue;
    }
    var_0.enemy = var_03;
    break;
  }
}

func_6522(var_00) {
  var_01 = 2;
  var_02 = 17.6 * level.func_D127.spaceship_vel * var_01;
  var_03 = level.func_D127.origin + var_02;
  var_0.func_D238 = var_03;
}

func_6508() {
  if(!isDefined(self.var_1198))
    return 0;

  if(!func_0BDC::func_3819())
    return 0;

  if(func_0BDC::func_9BCF())
    return 0;

  if(func_0BDC::func_9C06())
    return 0;

  if(self.func_9B4C)
    return 0;

  var_00 = self.origin - level.func_D127.origin;
  var_01 = length(var_00);
  var_02 = vectornormalize(var_00);
  var_03 = vectordot(anglesToForward(level.func_D127.angles), var_02);

  if(var_03 > -0.0)
    return 0;

  if(var_01 > 50000)
    return 0;

  return 1;
}

func_647A(var_00) {
  var_01 = 400;
  var_02 = -200;
  var_03 = func_0BDC::func_7B9C();
  var_04 = scripts\sp\math::func_C097(var_02, var_01, var_03);
  var_05 = scripts\sp\math::func_6A8E(-5000, -2000, var_04);
  var_06 = scripts\sp\math::func_6A8E(16000, 26000, var_04);
  var_05 = var_05 + randomintrange(-1000, 0);
  var_07 = (0, 0, 300);
  var_08 = (0, randomfloatrange(-15, 15), 0);
  var_09 = rotatevector(anglesToForward(level.func_D127.angles), level.func_D127.spaceship_rotvel * 0.3);
  var_10 = rotatevector(var_09, var_08);
  var_11 = var_09 * (1000 + 3 * var_03);
  var_12 = level.func_D127.origin + var_10 * var_05 + var_11 + var_07;
  var_13 = level.func_D127.origin + var_09 * var_06 + var_11;

  if(!_navtrace3d(var_12, var_13))
    return 0;

  var_0.func_6516 = var_12;
  var_0.func_6458 = var_13;
  return 1;
}

func_6826(var_00) {
  func_0BDC::func_A162();
  var_00 func_64D4();
  var_00 func_64AE();
  var_00 func_64C4(1);
  var_00 thread func_64B6();
  var_00 waittill("enemy_lock_broke");
  var_00 func_64C4(0);
  var_00 func_64A2();
  func_0BDC::func_A162(0);
}

func_6828(var_00) {
  var_0.enemy = undefined;
  var_01 = gettime();
  var_02 = (var_01 - var_0.func_10D4B) / 1000;
  var_03 = randomfloatrange(5, 15);
  var_04 = randomfloatrange(65, 75);
  var_05 = 0;
  var_06 = 18;
  var_07 = scripts\sp\math::func_C097(var_05, var_06, var_02);
  var_08 = scripts\sp\math::func_6A8E(var_03, var_04, var_07);
  wait(var_08);
}

func_6827(var_00) {
  if(func_F0C6(4))
    return 0;

  if(level.func_D127.spaceship_mode != "fly")
    return 0;

  if(level.func_D127.spaceship_boosting)
    return 0;

  if(level.func_D127.func_93D2.size > 0)
    return 0;

  if(scripts\sp\utility::func_7B9D() < 0.4)
    return 0;

  if(func_0BDC::func_7B9C() < 300)
    return 0;

  if(length(level.func_D127.spaceship_rotvel) > 60)
    return 0;

  if(isDefined(level.func_D127.func_4BC7) && level.func_D127.func_4BC8 > 0)
    return 0;

  var_0.enemy = func_64C1();

  if(!isDefined(var_0.enemy))
    return 0;

  return 1;
}

func_64C1() {
  var_00 = undefined;
  level.func_A056.func_1630 = scripts\engine\utility::array_removeundefined(level.func_A056.func_1630);

  foreach(var_02 in level.func_A056.func_191E) {
    if(var_02 func_6507()) {
      var_00 = var_02;
      break;
    }
  }

  if(!isDefined(var_00))
    return undefined;

  return var_00;
}

func_6507() {
  if(!isDefined(self.var_1198))
    return 0;

  if(!func_0BDC::func_3819())
    return 0;

  if(func_0BDC::func_9BCF())
    return 0;

  if(func_0BDC::func_9C06())
    return 0;

  var_00 = self.origin - level.func_D127.origin;
  var_01 = length(var_00);
  var_02 = vectornormalize(var_00);
  var_03 = vectordot(anglesToForward(level.func_D127.angles), var_02);

  if(var_03 > -0.45)
    return 0;

  if(var_01 > 30000)
    return 0;

  var_04 = self.origin - level.func_D127.origin;
  var_02 = vectornormalize(var_04);
  var_03 = vectordot(anglesToForward(self.angles), var_02);

  if(var_03 < 0.0)
    return 0;

  return 1;
}

func_64D4() {
  self.func_138F4 = scripts\engine\utility::spawn_script_origin();
  self.func_323B = scripts\engine\utility::spawn_tag_origin();
  self.func_3240 = scripts\engine\utility::spawn_tag_origin();
  self.func_13D10 = scripts\engine\utility::spawn_tag_origin();
  self.func_C4B9 = 0;
  self.func_B842 = 0;
  self.func_D080 = 400;
  self.func_A8CC = -9999999;
  self.func_20F5 = 0;
  self.func_647D = 0.0;
  self.func_B8A4 = [];
  self.func_138F4 linkto(level.func_D127, "tag_origin", (0, 0, 0), (0, 0, 0));
  thread func_64A1();
}

func_64A1() {
  self endon("enemy_lock_broke");

  while(!self.func_20F5) {
    self.func_10D4B = gettime();
    wait 0.05;
  }
}

func_64B6() {
  thread func_64A8();
  thread func_64B0();
  thread func_64AD();
  thread func_64AC();
}

func_64A8() {
  self.func_FEAE = 0;
  var_00 = [];

  if(scripts\sp\utility::func_93A6()) {
    var_0["min"] = 40;
    var_0["max"] = 50;
  } else {
    var_0["min"] = 19;
    var_0["max"] = 25;
  }

  wait(randomfloatrange(0.1, 1.3));

  for(;;) {
    func_64D5(randomfloatrange(0.2, 1.2));

    if(self.func_B83E) {
      while(self.func_B83E)
        wait 0.05;

      func_64D5(randomfloatrange(0.5, 1.2));
    }

    if(!func_64AF() || self.func_680B) {
      return;
    }
    func_64B8(randomintrange(var_0["min"], var_0["max"]));
  }
}

func_64B0() {
  self.func_B83E = 0;

  while(!self.func_20F5)
    wait 0.05;

  func_64D5(randomfloatrange(2, 10));

  for(;;) {
    level.func_D127.func_6E9C.func_B88A = 1;
    self.func_B83E = 1;

    if(self.func_FEAE) {
      while(self.func_FEAE)
        wait 0.05;

      wait(randomfloatrange(0.3, 1.2));
    }

    if(self.func_680B) {
      return;
    }
    if(!func_64AF() || self.func_680B) {
      break;
    }
    thread func_686E(["tag_flash_right", "tag_flash_left"], 3, 1);
    thread func_6868();
    func_64DF();
    level.func_D127.func_6E9C.func_B88A = 0;
    self.func_B83E = 0;
    self notify("missile_volley_complete");
    self.func_B842++;

    if(!func_64AF() || self.func_680B) {
      break;
    }
    func_64D5(randomfloatrange(7, 14));
  }
}

func_64AD() {
  var_00 = 0;
  var_01 = 0;
  var_02 = 0.25;
  var_03 = 0;
  var_04 = 0;
  var_05 = (0, 0, 0);
  var_06 = (0, 0, 0);
  var_07 = (0, 0, 0);
  var_08 = (0, 0, 0);
  var_09 = func_0B76::func_A26F();
  var_9.func_12AFD.func_CA26 = 0.15;
  var_9.func_12AFD.func_CA25 = 0.2;
  var_9.func_12AFD.func_B144 = 0.45;
  var_9.func_B0EF.func_CA26 = 0.15;
  var_9.func_B0EF.func_CA25 = 0.2;
  var_9.func_B0EF.func_B144 = 0.45;
  var_10 = 0.0;
  var_11 = 0.0;
  var_12 = 0.09;
  var_13 = 0.9;
  var_14 = 0;
  var_15 = 0.3;
  self.func_C4BB = var_13;
  func_64DC(1);
  var_16 = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0);
  var_16 = vectornormalize(var_16);
  var_16 = var_16 * var_13;
  var_00 = var_16[0];
  var_01 = var_16[1];
  var_17 = var_00;
  var_18 = var_01;
  var_19 = spawnStruct();
  var_19.func_6AE5 = 0.8;
  var_19.func_ABAC = var_19.func_6AE5;
  var_19.func_C3D1 = 0.0;
  var_19.func_12B24 = 1.0;
  var_20 = spawnStruct();
  var_20.x = [0, 0, 0, 0];
  var_20.y = [0, 0, 0, 0];
  var_21 = spawnStruct();
  var_21.func_C099 = 0;
  var_21.func_ABA8 = 0;

  for(;;) {
    level.player waittill("on_player_update");

    if(!func_64AF()) {
      return;
    }
    var_22 = level.player getsplashtablename();
    var_06 = scripts\sp\math::func_AB6F(var_06, var_22, 0.05);
    var_23 = length(var_22);
    var_24 = level.func_D127.spaceship_rotvel;
    var_19 func_64DB(self.func_20F5, self.func_647D);
    self.func_D080 = var_19.func_D060;
    self.func_D07F = var_19.func_D05F;

    if(self.func_20F5) {
      var_25 = scripts\sp\math::func_6A8E(0.73, 0.84, var_23);
      var_26 = scripts\sp\math::func_C097(0.5, 1.0, var_19.func_ABAC);
      var_27 = scripts\sp\math::func_6A8E(4.5, 7.5, var_26);
    } else {
      if(var_19.func_ABAC < 0.1) {
        func_64DC(0);
        self.func_20F5 = 1;
        thread func_64D2();
      }

      var_25 = scripts\sp\math::func_6A8E(0.77, 0.84, var_23);
      var_26 = scripts\sp\math::func_C097(0.3, 1.0, var_19.func_ABAC);
      var_27 = scripts\sp\math::func_6A8E(1.5, 10.0, var_26);
    }

    var_27 = var_27 * level.func_A48E.func_A409;
    var_00 = var_00 * var_25;
    var_01 = var_01 * var_25;
    var_07 = (var_06 - var_05) * var_27;
    var_28 = scripts\sp\math::func_C097(300, 400, self.func_D080);
    var_29 = 1 - scripts\sp\math::func_C097(300, 600, self.func_D080);
    var_30 = var_7[1] * -1 * abs(var_22[1]) * var_28;
    var_31 = var_7[0] * abs(var_22[0]) * var_28;
    var_32 = -0.003 * var_24[1] * var_29;
    var_33 = 0.003 * var_24[0] * var_29;
    var_34 = var_32 + var_30;
    var_35 = var_33 + var_31;
    var_00 = var_00 + var_34;
    var_01 = var_01 + var_35;
    var_17 = scripts\sp\math::func_AB6F(var_17, var_00, var_12);
    var_18 = scripts\sp\math::func_AB6F(var_18, var_01, var_12);
    var_09 func_0B76::func_B7E6();
    var_10 = scripts\sp\math::func_AB6F(var_10, var_9.func_B0EF.func_4D94["val"], 0.02);
    var_11 = scripts\sp\math::func_AB6F(var_11, var_9.func_12AFD.func_4D94["val"], 0.02);
    var_36 = scripts\sp\math::func_C097(0, 300, self.func_D080);
    var_37 = scripts\sp\math::func_6A8E(0, 0.06, var_36);

    if(level.func_D127.spaceship_boosting)
      var_37 = var_37 + 0.04;

    var_38 = randomfloatrange(-1, 1) * var_37;
    var_39 = randomfloatrange(-1, 1) * var_37;
    var_40 = var_17 + var_10 + var_38 * var_37;
    var_41 = var_18 + var_11 + var_39 * var_37;
    var_21 func_64DA(self.func_D080);
    self.func_45E2 = var_21.func_45E2;
    setomnvar("ui_jackal_enemy_lockon_x1", var_40 * 750 * (1 - self.func_45E2 * 0.5));
    setomnvar("ui_jackal_enemy_lockon_y1", var_41 * 370 * (1 - self.func_45E2 * 0.5));
    setomnvar("ui_jackal_enemy_lockon_rot_x", var_41 * self.func_45E2 * 25);
    setomnvar("ui_jackal_enemy_lockon_rot_y", var_40 * self.func_45E2 * 55);
    setomnvar("ui_jackal_enemy_lockon_ui_scale", var_19.func_12B24);
    setomnvar("ui_jackal_enemy_lockon_ui_alpha", var_19.func_12B19);
    var_42 = scripts\sp\math::func_6A8E(0.2, 1.0, self.func_45E2);
    self.func_C4BB = length((var_17, var_18, 0));

    if(self.func_C4BB < var_42) {
      var_14 = var_14 + 0.05;

      if(var_14 == var_15 && !self.func_C4B9)
        self.func_C4B9 = 1;
    } else {
      var_14 = var_14 - 0.05;

      if(self.func_C4B9)
        self.func_C4B9 = 0;
    }

    var_14 = clamp(var_14, 0, var_15);
    func_11A95(var_17, var_18, var_19.func_ABAC);
    var_43 = scripts\sp\math::func_C097(200, 400, self.func_D080);
    var_43 = scripts\sp\math::func_6A8E(1.7, 1.2, var_43);

    if(self.func_C4BB > var_43) {
      break;
    }
    if(self.func_20F5)
      var_44 = 0.9999;
    else
      var_44 = 0.95;

    if(var_19.func_ABAC > var_44) {
      break;
    }
    var_05 = var_06;
  }

  self notify("enemy_lock_broke");
}

func_64D2() {
  var_00 = 0.007;
  var_01 = 14;
  var_02 = var_00 * (var_01 / 20);

  while(self.func_647D < var_00) {
    self.func_647D = self.func_647D + var_02;
    wait 0.05;
  }

  self.func_647D = var_00;
}

func_6868() {
  self endon("missile_volley_complete");
  var_00 = 0;
  var_00 = func_6866();
  self.func_B8A4 = scripts\engine\utility::array_removeundefined(self.func_B8A4);

  if(!func_64AF()) {
    foreach(var_02 in self.func_B8A4)
    var_02 func_6867();

    return;
  }

  if(var_00)
    func_6864();
  else
    func_6865();

  while(self.func_6DA7 || self.func_B8A4.size > 0) {
    foreach(var_02 in self.func_B8A4) {
      if(isDefined(var_02) && isDefined(var_2.func_898B)) {
        continue;
      }
      if(!isDefined(var_02)) {
        continue;
      }
      var_02 unlink();
      var_2.func_898B = 1;

      if(var_00)
        var_02 func_6869();
      else
        var_02 func_6862();

      wait 0.3;
    }

    wait 0.05;
  }
}

func_6869() {
  self endon("death");

  if(level.func_D127.func_6E9C.func_12B86.size > 0) {
    self.func_6E8B = scripts\engine\utility::random(level.func_D127.func_6E9C.func_12B86);
    level.func_D127.func_6E9C.func_12B86 = scripts\engine\utility::array_remove(level.func_D127.func_6E9C.func_12B86, self.func_6E8B);
    self.func_B464 = 1500;
    self.func_6E9B = 1;
    self playSound("enemy_lockon_missile_flyby");

    for(;;) {
      if(!isDefined(self.func_6E8B)) {
        break;
      }
      var_00 = self.func_6E8B.origin - self.origin;
      var_01 = length(var_00);

      if(var_01 < self.func_B464) {
        break;
      }
      var_02 = vectornormalize(var_00);
      self.angles = vectortoangles(var_02);
      self.origin = self.origin + var_02 * self.func_B464;
      wait 0.05;
    }

    self.func_72CA = 1;
    self.func_50D5 = undefined;
  } else
    func_6867();
}

func_6867() {
  self.func_50D5 = undefined;
  self delete();
}

func_6862() {
  self.func_50D5 = undefined;
  self delete();
  var_00 = randomfloatrange(-200, 200);
  var_01 = level.func_D127.origin + anglesToForward(level.func_D127.angles) * -500 + anglesToForward(level.func_D127.angles) * var_00;
  level.func_D127 func_0B76::func_54DE(5000, var_01, self.enemy, "spaceship_homing_missile");
  level.func_D127 notify("missile_hit");
  thread func_0B76::func_12869(var_01);
  thread func_0BDC::func_D527("jackal_missile_explosion_plr", var_01);
}

func_6866() {
  var_00 = 2.0;
  var_01 = 0;
  var_02 = 0;
  var_03 = var_00 / 3;
  var_04 = spawnStruct();
  var_4.state = 0;

  while(var_01 <= var_00) {
    if(!func_64AF()) {
      break;
    }
    if(gettime() - level.func_D127.func_6E9C.func_A989 < 1300) {
      if(gettime() - level.func_D127.func_6E9C.func_A989 > 400)
        var_02 = 1;
    }

    var_04 func_6863(var_01, var_03);
    var_05 = scripts\sp\math::func_C097(-100, 300, self.func_D080);
    var_06 = scripts\sp\math::func_6A8E(0.25, 0.05, var_05);
    var_01 = var_01 + var_06;
    wait 0.05;
  }

  return var_02;
}

func_64DF() {
  while(isDefined(self) && self.func_B8A4.size > 0) {
    self.func_B8A4 = scripts\engine\utility::array_removeundefined(self.func_B8A4);
    wait 0.05;
  }
}

func_64DA(var_00) {
  var_01 = scripts\sp\math::func_C097(0, 350, var_00);
  self.func_C099 = scripts\sp\math::func_6A8E(1, 0, var_01);
  self.func_ABA8 = scripts\sp\math::func_AB6F(self.func_ABA8, self.func_C099, 0.1);
  self.func_45E2 = self.func_ABA8;
}

func_64DB(var_00, var_01) {
  self.func_D05F = level.player getnormalizedmovement();
  var_02 = level.func_D127.spaceship_vel;
  var_03 = rotatevectorinverted(var_02, level.func_D127.angles);
  self.func_D060 = var_3[0];
  var_04 = self.func_D060 - self.func_C3D1;
  var_05 = var_04 / 3000;
  self.func_6AE5 = self.func_6AE5 + var_05;

  if(level.func_D127.spaceship_boosting) {
    if(var_00)
      var_06 = 0.01 * level.func_A48E.func_A408;
    else
      var_06 = 0.03 * level.func_A48E.func_A40A;
  } else if(var_00)
    var_06 = 0.0;
  else
    var_06 = -0.02;

  self.func_6AE5 = self.func_6AE5 + var_06;
  var_07 = scripts\sp\math::func_C097(0, 250, self.func_D060);

  if(var_00)
    var_08 = scripts\sp\math::func_6A8E(-0.05, var_01, var_07);
  else
    var_08 = scripts\sp\math::func_6A8E(-0.01, 0, var_07);

  self.func_6AE5 = self.func_6AE5 + var_08;
  var_09 = scripts\sp\math::func_C097(0, 1, self.func_D05F[0]);
  var_10 = scripts\sp\math::func_6A8E(-0.01, 0, var_09);
  self.func_6AE5 = self.func_6AE5 + var_10;
  self.func_6AE5 = clamp(self.func_6AE5, 0, 1);
  self.func_ABAC = scripts\sp\math::func_AB6F(self.func_ABAC, self.func_6AE5, 0.12);
  self.func_12B24 = scripts\sp\math::func_6A8E(0, 0.72, self.func_ABAC);
  self.func_12B19 = scripts\sp\math::func_6A8E(1, 0.35, self.func_ABAC);
  self.func_C3D1 = self.func_D060;
}

func_64C4(var_00) {
  if(var_00) {
    self.func_138F4 playLoopSound("enemy_lockon_following");
    setomnvar("ui_jackal_enemy_lockon_active", 1);
    thread func_64CF();
    thread func_64C2();
  } else {
    self.func_138F4 stoploopsound("enemy_lockon_following");
    setomnvar("ui_jackal_enemy_lockon_active", 0);
    level.player playSound("enemy_lockon_break");
    func_0BDC::func_A112("jackal_hud_enemylock_broken", 1.5);
  }
}

func_64CF() {
  self endon("enemy_lock_broke");
  level.func_D127 endon("player_exit_jackal");
  level.func_D127 endon("script_death");
  func_0BDC::func_A112("jackal_hud_enemylock_detected", 0.5);

  if(isDefined(self.func_20F5)) {
    while(!self.func_20F5)
      wait 0.05;
  }

  var_00 = 4;
  func_0BDC::func_A112("jackal_hud_enemylock", 0.5);

  for(;;) {
    wait(var_00);
    func_0BDC::func_A112("jackal_hud_locklock", 0.1);
  }
}

func_64DD(var_00) {
  if(var_00)
    setomnvar("ui_jackal_enemy_lockon_on_target", 1);
  else
    setomnvar("ui_jackal_enemy_lockon_on_target", 0);
}

func_64DC(var_00) {
  if(var_00) {
    setomnvar("ui_jackal_enemy_lockon_aquiring", 1);
    level.player playSound("enemy_lockon_acquiring");
  } else {
    setomnvar("ui_jackal_enemy_lockon_aquiring", 0);
    level.player playSound("enemy_lockon_acquired");
  }
}

func_6863(var_00, var_01) {
  if(self.state < 2) {
    self.state = 2;
    setomnvar("ui_jackal_enemy_lockon_missile", self.state);
    level.player playSound("enemy_lockon_hud_missile_1");
  } else if(var_00 > var_01 && self.state < 3) {
    self.state = 3;
    setomnvar("ui_jackal_enemy_lockon_missile", self.state);
    level.player playSound("enemy_lockon_hud_missile_2");
  } else if(var_00 > 2 * var_01 && self.state < 4) {
    self.state = 4;
    setomnvar("ui_jackal_enemy_lockon_missile", self.state);
    level.player playSound("enemy_lockon_hud_missile_3");
  }
}

func_6864() {
  setomnvar("ui_jackal_enemy_lockon_missile", 0);
  level.player playSound("enemy_lockon_hud_flared");
}

func_6865() {
  setomnvar("ui_jackal_enemy_lockon_missile", -1);
}

func_64AC() {
  self endon("enemy_lock_broke");

  while(isDefined(self.enemy) && isalive(self.enemy))
    wait 0.05;

  self notify("enemy_lock_broke");
}

func_64C2() {
  self endon("enemy_lock_broke");
  self.enemy endon("death");

  while(!self.func_20F5)
    wait 0.05;

  wait 2;
  var_00 = 0;
  thread func_64A0();

  for(;;) {
    if(scripts\engine\utility::flag("jackal_flare_hint")) {
      self.func_A8CC = gettime();
      var_00 = 2;
    }

    if(!scripts\engine\utility::flag("jackal_lose_lock_hint") && !scripts\engine\utility::flag("jackal_flare_hint")) {
      if(!level.func_D127.spaceship_boosting && gettime() - self.func_A8CC > var_00 * 1000) {
        scripts\engine\utility::flag_set("jackal_lose_lock_hint");
        scripts\sp\utility::func_56BA("jackal_lose_lock");
      }
    }

    if(level.func_D127.spaceship_boosting) {
      scripts\engine\utility::flag_clear("jackal_lose_lock_hint");
      self.func_A8CC = gettime();
      var_00 = 2;
    }

    wait 0.05;
  }
}

func_64E0() {
  while(self.func_B83E || self.func_FEAE)
    wait 0.05;
}

func_64AE() {
  var_00 = anglesToForward(level.func_D127.angles);
  var_01 = level.func_D127.origin + var_00 * -2000;
  self.enemy func_0BDC::func_19A2();
  self.enemy func_0BDC::func_19AE("dont_shoot");
  self.enemy func_0BDC::func_19B5(level.func_D127);
  self.enemy vehicle_teleport(var_01, level.func_D127.angles);
  self.enemy linkto(self.func_323B, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.enemy.ignoreme = 1;

  if(isDefined(self.enemy.var_1198) && self.enemy.var_1198.func_C97C) {
    self.enemy.func_13902 = 1;
    self.enemy func_0BDC::func_1990(0);
  } else
    self.enemy.func_13902 = 0;
}

func_64A2() {
  setomnvar("ui_jackal_enemy_lockon_isfiring", 0);
  setomnvar("ui_jackal_enemy_lockon_missile", 0);
  self.func_B8A4 = scripts\engine\utility::array_removeundefined(self.func_B8A4);

  foreach(var_01 in self.func_B8A4)
  var_01 func_6867();

  self.func_680B = 1;
  level.func_D127.func_6E9C.func_B88A = 0;
  scripts\engine\utility::flag_clear("jackal_lose_lock_hint");

  if(isDefined(self.enemy))
    self.enemy thread func_64D0();

  self.func_323B delete();
  self.func_3240 delete();
  self.func_13D10 delete();
  self.func_138F4 delete();
}

func_64D0() {
  self endon("death");
  func_0BDC::func_19AE("shoot_forever");
  self unlink();
  var_00 = vectortoangles(level.func_D127.origin - self.origin);
  self vehicle_teleport(self.origin, var_00);
  var_01 = distance(self.origin, level.func_D127.origin);

  if(_ispointonnavmesh3d(self.origin) && func_0BDC::func_7B9E() < 150 && var_01 < 10000) {
    thread func_0BDC::func_A1EC(self.origin, 0);
    func_0BDC::func_19B0("hover");
    func_0BDC::func_19B2("face enemy");
    func_0BDC::func_19B5(level.func_D127);
    func_0BDC::func_1980(level.func_A48E.func_A40B, 1);
    func_0BDC::func_A36B();
    wait(randomfloatrange(4, 6));
    func_0BDC::func_19B0("none");
    func_0BDC::func_1989();
    func_0BDC::func_198A();
    func_0BDC::func_1980();
    func_0BDC::func_A368();
  }

  func_0BDC::func_19AE("shoot_at_will");
  func_0BDC::func_198A();
  self.ignoreme = 0;
  func_0BDC::func_1986();

  if(self.func_13902)
    func_0BDC::func_1990(1);

  self.func_13902 = undefined;
}

func_64AF() {
  if(isDefined(self.enemy) && isalive(self.enemy))
    return 1;
  else
    return 0;
}

func_64B8(var_00) {
  var_01 = 150;

  if(scripts\sp\utility::func_93A6())
    var_02 = 45;
  else
    var_02 = 150;

  self.func_323B playLoopSound("jackal_gatling_fire_at_plr");
  self.func_FEAE = 1;

  while(var_00 > 0) {
    if(!func_64AF() || self.func_680B) {
      return;
    }
    playFXOnTag(scripts\engine\utility::getfx("fake_follow_jackal_tracer"), self.func_323B, "tag_origin");
    setomnvar("ui_jackal_enemy_lockon_isfiring", 1);

    if(self.func_C4B9) {
      var_03 = vectornormalize(self.func_323B.origin - level.func_D127.origin);
      var_04 = level.func_D127.origin + var_03 * var_01;
      self.func_13D10 playSound("enemy_lockon_bullet_impacts");
      level.func_D127 getrandomarmkillstreak(var_02, var_04, self.enemy, self.enemy, "MOD_PROJECTILE", "spaceship_scripted_locked_enemy_bullets");
    } else
      self.func_13D10 playSound("enemy_lockon_whizby");

    var_0--;
    wait 0.1;
  }

  if(self.func_680B) {
    return;
  }
  self.func_FEAE = 0;
  setomnvar("ui_jackal_enemy_lockon_isfiring", 0);
  self.func_323B stoploopsound();
}

func_64D5(var_00) {
  var_01 = 4;

  while(var_00 > 0) {
    var_02 = 0.05;
    var_03 = scripts\sp\math::func_C097(0, 300, self.func_D080);
    var_04 = scripts\sp\math::func_6A8E(var_01, 1, var_03);
    var_00 = var_00 - var_02 * var_04;
    wait 0.05;
  }
}

func_64A0() {
  self.enemy endon("death");
  self endon("enemy_lock_broke");
  scripts\engine\utility::flag_wait("jackal_lose_lock_hint");
  level.func_D127 thread scripts\anim\battlechatter_ai::func_181C("maneuver", undefined, self.enemy, 0.5);
}

func_11A95(var_00, var_01, var_02, var_03) {
  var_04 = -1000;
  var_05 = -2000;
  var_06 = 2500;
  var_07 = 2500;
  var_08 = 1;
  var_09 = 25000;
  var_10 = 500;
  var_11 = scripts\sp\math::func_6A8E(var_04, var_05, var_02);
  var_12 = scripts\sp\math::func_6A8E(var_09, var_10, self.func_45E2);
  var_11 = var_11 * (1 - self.func_45E2 * 0.5);
  var_13 = 0.35;
  var_14 = (self.func_45E2 * 25 * var_01, self.func_45E2 * 55 * var_00, 0);
  var_14 = var_14 * var_13;
  var_15 = level.func_D127.spaceship_rotvel;
  var_16 = level.func_D127 gettagorigin("tag_camera");
  var_17 = level.player getplayerangles();
  var_18 = anglesToForward(var_17);
  var_19 = anglestoright(level.func_D127.angles);
  var_20 = anglestoup(level.func_D127.angles);
  var_21 = rotatevector(var_18 * var_12, var_14);
  self.func_3240.origin = var_16 + var_21;
  var_22 = rotatevector((var_18 * var_11 + var_19 * var_06 * var_00 + var_20 * var_07 * var_01 * -1) * var_08, var_14);
  self.func_323B.origin = var_16 + var_22;
  var_23 = vectornormalize(self.func_3240.origin - self.func_323B.origin);
  self.func_323B.angles = _axistoangles(var_23, var_19, var_20);
  self.func_13D10.origin = self.func_323B.origin + var_11 * var_23 * -1;
  self.func_13D10.angles = self.func_323B.angles;
}

func_64AA() {
  self endon("death");
  self endon("stop_lockon");
  var_00 = self.origin;
  wait 0.05;

  for(;;) {
    var_01 = self gettagorigin("j_mainroot_ship");
    var_02 = self gettagangles("j_mainroot_ship");
    var_03 = var_01 - var_00;
    var_04 = vectornormalize(var_01 - var_00);
    var_05 = length(var_03);
    var_06 = func_64AB(var_00, var_04, var_05);

    if(isDefined(var_06)) {
      break;
    }
    var_00 = var_01;
    wait 0.05;
  }

  func_0BDC::func_A066(var_06);
}

func_64AB(var_00, var_01, var_02) {
  var_03 = var_00 + var_01 * (var_02 * 0.12);
  var_04 = scripts\engine\trace::capsule_trace(var_00, var_03, 150, 300, self.angles, self, undefined, 1);

  if(var_4["fraction"] < 1)
    return var_04;
}

func_F0C6(var_00) {
  if(level.func_D127.func_58B5 || gettime() - level.func_A056.func_A976 < var_00 * 1000)
    return 1;
  else
    return 0;
}

func_D30D() {
  var_00 = level.player _meth_848A();
  var_01 = level.player adsbuttonpressed();

  if(var_01 && isDefined(var_00) && isDefined(var_0[0]) && var_0[1] > 0.1)
    return 1;
  else
    return 0;
}