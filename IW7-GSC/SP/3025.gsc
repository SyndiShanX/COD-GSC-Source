/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3025.gsc
**************************************/

_id_68B4() {
  var_0 = spawnStruct();
  var_0._id_68B6 = [];
  var_0.running = 0;
  var_0._id_54F1 = 1;
  return var_0;
}

_id_686B() {
  _id_0BDC::_id_A1AA("enemy_lockon", ::_id_6827, ::_id_6826, ::_id_6828);
  _id_0BDC::_id_A1AA("enemy_missileVolley", ::_id_682B, ::_id_6829, ::_id_682C);
  _id_0BDC::_id_A1AA("enemy_hoverheat_missiles", ::_id_6823, ::_id_6822, ::_id_6824);
  _id_0BDC::_id_A1AA("ai_ambient_missileVolley", ::_id_67E9, ::_id_67E8, ::_id_67EA);
  _id_0BDC::_id_A1AA("enemy_strafeAttack", ::_id_6831, ::_id_682F, ::_id_6832);
}

_id_686A() {
  level._id_D127 endon("player_exit_jackal");
  _id_686B();
  _id_0BDC::_id_137DA();

  for(;;) {
    foreach(var_2, var_1 in level._id_A056._id_68B3._id_68B6) {
      if(level._id_A056._id_68B3 _id_6809(var_1) && [[var_1._id_10974]](var_1)) {
        level._id_A056._id_68B3 _id_6882(var_1, var_2);
        level._id_A056._id_68B3 thread _id_680D(var_1);
        _id_680A();
      }

      wait 0.05;
    }
  }
}

_id_6882(var_0, var_1) {
  self.running = 1;
  self._id_00C8 = var_1;
  var_0.running = 1;
  var_0._id_680B = 0;
  self[[var_0.main]](var_0);
  var_0 notify("event_complete");
  var_0._id_680B = 1;
  var_0.running = 0;
  self._id_00C8 = "";
  self.running = 0;
}

_id_680D(var_0) {
  var_0.cooling_down = 1;
  self[[var_0._id_4623]](var_0);
  var_0.cooling_down = 0;
}

_id_680A() {
  wait(randomfloatrange(1, 4));
}

_id_6809(var_0) {
  if(self._id_54F1) {
    return 0;
  }

  if(scripts\engine\utility::flag("jackal_missile_drone_active")) {
    return 0;
  }

  if(var_0._id_54F1) {
    return 0;
  }

  if(var_0.cooling_down) {
    return 0;
  }

  return 1;
}

_id_5F9C(var_0) {
  while(!level.player buttonPressed("DPAD_DOWN")) {
    wait 0.05;
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 _id_0BDC::_id_A36A();
    }
  }

  _id_0BDC::_id_A1A9(0);
  _id_0BDC::_id_A1AD("enemy_missileVolley");
  _id_6889();
}

_id_6889() {
  while(!isDefined(level._id_D127._id_93D2) || level._id_D127._id_93D2.size == 0) {
    wait 0.05;
  }

  wait 3;
  _id_0BDC::_id_A1AA("save_salter", ::_id_6887, ::_id_6886, ::_id_6888);
}

_id_6887(var_0) {
  var_0._id_10A45 = "salter_dogandpony_path";
  var_1 = getcsplineid(var_0._id_10A45);
  return 1;
}

_id_688E(var_0) {
  var_1 = 300;
  var_2 = getcsplineid(var_0._id_10A45);
  var_3 = getEnt("salter_dogandpony", "targetname");
  level._id_EA99 = _id_688C(var_3, var_1);
  level._id_EA99 _id_0BDC::_id_1998();
  level._id_EA99 thread _id_0BDC::_id_A1EF(var_2);
  level._id_EA99 thread _id_0C1B::_id_6EAC();
  wait 1.2;
  var_4 = getEnt("salter_enemy_dogandpony", "targetname");
  var_0.enemy = _id_688C(var_4, var_1);
  var_0.enemy thread _id_0BDC::_id_A1EF(var_2);
  wait 0.2;
  var_0.enemy makeentitysentient("axis", 0);
  level._id_EA99 _id_0BDC::_id_105DB("jackal", undefined, "ally_jackal", "ally_jackal");
  var_0.enemy thread _id_0BDC::_id_105DB("ace", "JACKAL_ACE_SKELTER", "jackal", "enemy_jackal", 1);
  level._id_EA99 _id_0BDC::_id_1998();
  var_0.enemy _id_0C1C::init();
  var_5 = -5000;
}

_id_688C(var_0, var_1) {
  var_2 = var_0 scripts\sp\utility::_id_10808();
  var_2.ignoreme = 1;
  var_2 _id_0BDC::_id_19AB(var_1);
  var_2 _id_0BDC::_id_F43D("fake");
  return var_2;
}

_id_6886(var_0) {
  _id_688E(var_0);
  var_0.enemy _id_0BDC::_id_A36D();
  level._id_EA99 _id_0BDC::_id_A36D();
  var_0.enemy thread _id_6892();
  var_0.enemy thread _id_688D();
  var_0.enemy thread _id_688B();
  level._id_EA99 thread _id_688A();

  while(isalive(var_0.enemy)) {
    wait 0.05;
  }

  level notify("salter_saved");
  level._id_EA99 _id_0BDC::_id_A36A();
}

_id_6892() {
  self endon("death");

  for(;;) {
    _id_0BDC::_id_19AE("lead_burst");
    self waittill("stop soundjackal_gatling_fire");
    wait 0.05;
    _id_0BDC::_id_19AE("dont_shoot");
    wait(randomfloatrange(0.3, 0.7));
  }
}

_id_688D() {
  self endon("death");

  if(!isDefined(level._id_EA99._id_93D2)) {
    level._id_EA99._id_93D2 = [];
  }

  for(;;) {
    _id_0B76::_id_1945(level._id_EA99, ["tag_flash_right", "tag_flash_left"], randomintrange(1, 3));

    while(level._id_EA99._id_93D2.size > 0) {
      wait 0.05;
    }

    wait(randomfloatrange(2, 4));
  }
}

_id_688B() {
  self endon("death");

  for(;;) {
    while(!self._id_AEDF._id_2A93 && !level.player buttonPressed("button_lstick")) {
      wait 0.05;
    }

    _id_0BDC::_id_1991();
  }
}

_id_688A() {
  self endon("death");

  for(;;) {
    while(!isDefined(self._id_93D2) || self._id_93D2.size == 0) {
      wait 0.05;
    }

    _id_0BDC::_id_1991();
  }
}

_id_6890() {
  level endon("salter_saved");
  level endon("event_missile_out");
  _id_11685("Salter", "shit - i got one on me!");
  _id_11685("Reyes", "countermeasures!");
  _id_11685("Salter", "Runnin low");
  _id_11685("Reyes", "on my way, hang in there");
  _id_11685("Salter", "i got thisguy doesnt know who hes doggin with");
  _id_11685("Reyes", "easy salt, easy");
  _id_11685("slater", "Reyes, where are you?");
  _id_11685("Reyes", "easy salt, easy");
  _id_11685("slater", "Im getting boxed in, Raider, throttle up");
  _id_11685("Reyes", "patience is a virtue");
  _id_11685("slater", "Im gonna kill you");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
}

_id_688F(var_0) {
  while(!isDefined(var_0._id_93D2) || var_0._id_93D2.size == 0) {
    wait 0.05;
  }

  level notify("event_missile_out");
  _id_11685("reyes", "got a shot- fox out!");
}

_id_6891() {
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  _id_11685("Reyes", "splash one - he's down");
  _id_11685("slater", "good kill.Took you long enough");
  _id_11685("Reyes", "saved your ass, dont gimme shit");
}

_id_6888(var_0) {
  _id_0BDC::_id_A1AD("save_salter");
}

_id_11685(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_545A)) {
    level._id_545A = [];
  }

  var_3 = 0;

  for(;;) {
    if(!isDefined(level._id_545A[var_3])) {
      break;
    }

    var_3++;
  }

  var_4 = "^3";

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_2 = max(1, var_2);
  level._id_545A[var_3] = 1;
  var_5 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_5.location = 0;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.alpha = 0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 1;
  var_5.x = 40;
  var_5.y = 260 + var_3 * 18;
  var_5.label = " " + var_4 + "< " + var_0 + " > ^7" + var_1;
  var_5.color = (1, 1, 1);
  wait(var_2);
  var_6 = 10.0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 0;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_5.color = (1, 1, 0 / (var_6 - var_7));
    wait 0.05;
  }

  wait 0.25;
  var_5 destroy();
  level._id_545A[var_3] = undefined;
}

_id_67E9(var_0) {
  if(level._id_A056._id_191E.size == 0 || level._id_A056._id_1914.size == 0) {
    return 0;
  }

  if(!isDefined(var_0._id_A419) || var_0._id_A419.size == 0) {
    var_0._id_A419 = level._id_A056._id_1630;
  }

  var_1 = anglesToForward(level._id_D127.angles);
  var_2 = -1;
  var_3 = 10;

  foreach(var_5 in var_0._id_A419) {
    var_2++;

    if(var_2 > var_3) {
      return 0;
    }

    if(!isDefined(var_5) || !isalive(var_5)) {
      var_0._id_A419 = scripts\engine\utility::array_remove(var_0._id_A419, var_5);
      continue;
    }

    if(!var_5 _id_0BDC::_id_3819()) {
      continue;
    }
    if(var_5 _id_0BDC::_id_9C06()) {
      continue;
    }
    if(var_5._id_AEDF._id_2A93) {
      continue;
    }
    if(isDefined(var_5._id_93D2) && var_5._id_93D2.size > 0) {
      continue;
    }
    var_6 = anglesToForward(var_5.angles);
    var_7 = var_5.origin + var_6 * 9000;
    var_8 = var_7 - level._id_D127.origin;
    var_9 = vectordot(vectorNormalize(var_8), var_1);

    if(var_9 < 0.9) {
      var_0._id_A419 = scripts\engine\utility::array_remove(var_0._id_A419, var_5);
      continue;
    }

    var_10 = length(var_8);

    if(var_10 > 150000 || var_10 < 15000) {
      var_0._id_A419 = scripts\engine\utility::array_remove(var_0._id_A419, var_5);
      continue;
    }

    var_0._id_1152A = var_5;
    break;
  }

  if(!isDefined(var_0._id_1152A)) {
    return 0;
  }

  wait 0.05;

  if(!isDefined(var_0._id_1152A)) {
    var_0._id_A419 = scripts\engine\utility::array_remove(var_0._id_A419, var_0._id_1152A);
    return 0;
  }

  if(var_0._id_1152A.script_team == "allies") {
    var_12 = level._id_A056._id_191E;
  } else {
    var_12 = level._id_A056._id_1914;
  }

  foreach(var_5 in var_12) {
    if(!isDefined(var_5) || !isalive(var_5)) {
      continue;
    }
    if(!var_5 _id_0BDC::_id_3819()) {
      continue;
    }
    var_8 = var_0._id_1152A.origin - var_5.origin;
    var_10 = length(var_8);

    if(var_10 > 20000 || var_10 < 5000) {
      continue;
    }
    var_6 = anglesToForward(var_5.angles);
    var_14 = vectordot(vectorNormalize(var_8), var_6);

    if(var_14 < 0.1) {
      continue;
    }
    var_0._id_2522 = var_5;
    break;
  }

  if(!isDefined(var_0._id_2522)) {
    var_0._id_A419 = scripts\engine\utility::array_remove(var_0._id_A419, var_0._id_1152A);
    return 0;
  }

  return 1;
}

_id_67E8(var_0) {
  var_0._id_2522 _id_0B76::_id_1945(var_0._id_1152A, ["tag_flash_right", "tag_flash_left"], randomintrange(1, 3));
}

_id_11078(var_0, var_1) {
  wait 5;
  var_0 notify("stop_line");
  var_1 notify("stop_line");
}

_id_67EA(var_0) {
  var_0._id_1152A = undefined;
  var_0._id_2522 = undefined;
  wait(randomfloatrange(0.5, 2));
}

_id_6823(var_0) {
  if(_id_F0C6(2)) {
    return 0;
  }

  if(level._id_90E2._id_1112E == 0) {
    return 0;
  }

  var_1 = anglesToForward(level._id_D127.angles);
  var_0._id_A419 = scripts\engine\utility::array_removeundefined(level._id_A056._id_933B);

  if(var_0._id_A419.size == 0) {
    return 0;
  }

  foreach(var_3 in var_0._id_A419) {
    if(!var_3 _id_6825(var_1)) {
      continue;
    }
    var_0.enemy = var_3;
    var_0._id_907F = 1;
    return 1;
  }

  return 0;
}

_id_6825(var_0) {
  if(!_id_0BDC::_id_9C06()) {
    return 0;
  }

  if(isDefined(self._blackboard._id_90EB) && gettime() - self._blackboard._id_90EB < 2000) {
    return 0;
  }

  if(!level.player scripts\sp\utility::_id_65DB("jackal_enemy_homing_missile_allowed_hyperaggressive")) {
    return 0;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = self.origin - level._id_D127.origin;
  var_3 = length(var_2);

  if(var_3 > 25000 || var_3 < 500) {
    return 0;
  }

  var_4 = vectordot(vectorNormalize(level._id_D127.origin - self.origin), var_1);

  if(var_4 < 0.7) {
    return 0;
  }

  var_4 = vectordot(vectorNormalize(var_2), var_0);

  if(var_4 < 0.85) {
    return 0;
  }

  return 1;
}

_id_6822(var_0) {
  if(var_0._id_907F) {
    var_0 _id_686E(["tag_flash_right", "tag_flash_left"], randomintrange(2, 4));
  }

  var_0.enemy._blackboard._id_90EB = gettime();
}

_id_6824(var_0) {
  var_0.enemy = undefined;
  wait(randomfloatrange(0.0, 2.0));
  var_0._id_A8E9 = gettime();
}

_id_682B(var_0) {
  return _id_682A(var_0, 1);
}

_id_682D(var_0) {
  return _id_682A(var_0, 0);
}

_id_682A(var_0, var_1) {
  if(_id_F0C6(3)) {
    return 0;
  }

  if(!level.player scripts\sp\utility::_id_65DB("jackal_enemy_homing_missile_allowed")) {
    return 0;
  }

  if(_id_D30D()) {
    return 0;
  }

  var_2 = anglesToForward(level._id_D127.angles);

  if(!isDefined(var_0._id_A419) || var_0._id_A419.size == 0) {
    var_0._id_A419 = level._id_A056._id_1630;
  }

  var_3 = -1;
  var_4 = 5;

  foreach(var_6 in var_0._id_A419) {
    var_3++;

    if(var_3 > var_4) {
      return 0;
    }

    if(!var_6 _id_682E(var_2, var_1)) {
      var_0._id_A419 = scripts\engine\utility::array_remove(var_0._id_A419, var_6);
      continue;
    }

    var_0.enemy = var_6;
    return 1;
  }

  return 0;
}

_id_682E(var_0, var_1) {
  if(!isDefined(self) || !isalive(self) || self.script_team != "axis") {
    return 0;
  }

  if(!_id_0BDC::_id_3819()) {
    return 0;
  }

  var_2 = anglesToForward(self.angles);
  var_3 = self.origin + var_2 * 9000;
  var_4 = var_3 - level._id_D127.origin;
  var_5 = vectordot(vectorNormalize(var_4), var_0);

  if(var_1) {
    var_6 = 0.97;
  } else {
    var_6 = 0.8;
  }

  if(var_5 < var_6) {
    return 0;
  }

  var_7 = length(var_4);

  if(var_7 > 35000 || var_7 < 10000) {
    return 0;
  }

  if(var_1) {
    var_8 = vectordot(vectorNormalize(level._id_D127.origin - self.origin), var_2);

    if(var_8 < -0.1) {
      return 0;
    }
  }

  return 1;
}

_id_6829(var_0) {
  var_0 _id_686E(["tag_flash_right", "tag_flash_left"], 3);
  var_0 _id_64DF();
}

_id_682C(var_0) {
  var_0.enemy = undefined;
  wait(randomfloatrange(15, 40));
}

_id_686E(var_0, var_1, var_2) {
  self.enemy endon("death");

  if(!isDefined(self._id_B8A4)) {
    self._id_B8A4 = [];
  }

  self.enemy _id_0B76::_id_A278();

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(var_2) {
    var_3 = 1;
    var_4 = 3000;
  } else {
    wait 0.5;
    var_3 = undefined;
    var_4 = 300;
  }

  self._id_6DA7 = 1;
  var_5 = 0;

  while(var_1 > 0) {
    if(var_5 == var_0.size) {
      var_5 = 0;
    }

    var_6 = var_0[var_5];
    var_5++;

    if(isDefined(self.enemy) && !self._id_680B) {
      var_7 = self.enemy thread _id_0B76::_id_1992(var_6, level._id_D127, undefined, var_3, var_4);
      var_7._id_438D = self.enemy;
      self._id_B8A4 = scripts\engine\utility::array_add(self._id_B8A4, var_7);

      if(!var_2) {
        var_7 _id_0B76::_id_A279();
      } else {
        var_7 linkTo(self.enemy);
        var_7 thread _id_0B76::_id_B804();
      }
    } else
      break;

    var_1--;
    wait 0.3;
  }

  self._id_6DA7 = 0;
}

_id_6831(var_0) {
  if(_id_F0C6(3)) {
    return 0;
  }

  if(level._id_D127.spaceship_boosting) {
    return 0;
  }

  if(level._id_D127._id_93D2.size > 0) {
    return 0;
  }

  if(scripts\sp\utility::_id_7B9D() < 0.5) {
    return 0;
  }

  if(isDefined(level._id_D127._id_4BC7)) {
    return 0;
  }

  if(!_id_647A(var_0)) {
    return 0;
  }

  _id_6521(var_0);

  if(!isDefined(var_0.enemy)) {
    return 0;
  }

  return 1;
}

_id_682F(var_0) {
  level thread _id_6835(var_0.enemy, var_0._id_6516, var_0._id_6458);
  var_0.enemy = undefined;
}

_id_6835(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  var_0 endon("stop_strafeattack");
  var_3 = spawnVehicle("veh_mil_air_un_jackal_02", "player_sled", "jackal_un", level._id_D127.origin, level._id_D127.angles);
  var_3 hide();
  var_3 notsolid();
  var_3 makeentitysentient("allies", 0);
  var_3 linkTo(var_0, "j_mainroot_ship", (8000, 0, 0), (0, 0, 0));
  var_4 = scripts\engine\utility::spawn_script_origin();
  var_0.ignoreme = 1;
  var_0 _id_0BDC::_id_19A2();
  var_0 _id_0BDC::_id_199B();
  var_0 _id_0BDC::_id_19B0("fly");
  var_0 vehicle_teleport(var_1, level._id_D127.angles);
  var_0 linkTo(level._id_D127);
  var_0 notsolid();
  var_0 scripts\engine\utility::delaycall(3, ::solid);
  var_0 thread _id_6834();
  var_0 thread _id_6836(var_3, var_4);
  var_0 thread _id_6830(var_3, var_4);
  wait 0.15;
  var_0 unlink();
  var_0 _meth_8455(var_2, 0);

  for(;;) {
    var_5 = distance(var_0.origin, var_2);

    if(var_5 < 8000) {
      break;
    }

    wait 0.05;
  }

  var_0.bt._id_3F28 = var_0 _id_0A0D::_id_7E02(50000, 3000);

  if(isDefined(var_0.bt._id_3F28)) {
    var_0 _id_0A0D::_id_6CAB(undefined, "spline");
  }

  var_0 notify("stop_strafeattack");
}

_id_6830(var_0, var_1) {
  scripts\engine\utility::waittill_any("death", "damage", "stop_strafeattack");

  if(isDefined(self)) {
    self.ignoreme = 0;
    _id_0BDC::_id_198A();
    _id_0BDC::_id_19AB();
    _id_0BDC::_id_1986();
    _id_0BDC::_id_1980();
    scripts\engine\utility::delaythread(1, _id_0BDC::_id_19B0, "none");
    scripts\engine\utility::delaythread(5, _id_0BDC::_id_198D);
    _id_0BDC::_id_19AE("shoot_at_will");
    self notify("stop_strafeattack");
    self notify("near_goal");
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_1 delete();
}

_id_6836(var_0, var_1) {
  self endon("stop_strafeattack");
  self endon("death");
  _id_0BDC::_id_19AE("shoot_forever");
  _id_0BDC::_id_1980(scripts\sp\utility::_id_7B9D(), 1);
  _id_0BDC::_id_19B5(level._id_D127);
  _id_6833(var_1);
  _id_0BDC::_id_19B5(var_0);
  wait(randomfloatrange(1.0, 1.2));
  _id_0BDC::_id_198A();
  var_0 delete();
  _id_0BDC::_id_19AE("shoot_at_will");
  _id_0BDC::_id_1980();
}

_id_6833(var_0) {
  self endon("stop_strafeattack");
  self endon("death");
  var_1 = 150;
  var_2 = -200;
  var_3 = 8;

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(_id_0B76::_id_7A60(self.origin) > 0) {
      break;
    }

    if(var_3 == 0) {
      break;
    }

    var_4 = vectorNormalize(self.origin - level._id_D127.origin);
    var_0.origin = level._id_D127.origin + var_4 * var_2;
    var_0 playSound("enemy_lockon_bullet_impacts");
    thread scripts\engine\utility::play_sound_in_space("enemy_lockon_whizby", var_0.origin);

    if(scripts\sp\utility::_id_7B9D() > 0.6) {
      level._id_D127 dodamage(50, self.origin, self, self, "MOD_PROJECTILE", "spaceship_scripted_locked_enemy_bullets");
    }

    wait 0.1;
    var_3--;
  }
}

_id_6832(var_0) {
  var_1 = randomfloatrange(2, 10);

  for(var_2 = 0; var_1 > 0; var_1 = var_1 - 0.05) {
    if(level._id_D127.spaceship_mode == "hover") {
      var_2 = var_2 + 0.05;
    } else {
      var_2 = 0;
    }

    if(var_2 > 3) {
      break;
    }

    wait 0.05;
  }
}

_id_6834() {
  self endon("stop_strafeattack");
  self endon("death");
  var_0 = randomintrange(0, 100);
  var_1 = _id_7CB3(var_0);
  _id_0BDC::_id_19AB(var_1, 3500);
  wait 0.5;

  for(;;) {
    var_1 = _id_7CB3(var_0);
    _id_0BDC::_id_19AB(var_1, 380);
    wait 0.5;
  }
}

_id_7CB3(var_0) {
  var_1 = _id_0BDC::_id_7B9E() + 200 + var_0;
  return clamp(var_1, 400, 1000);
}

_id_6521(var_0) {
  var_1 = undefined;
  level._id_A056._id_1630 = scripts\engine\utility::array_removeundefined(level._id_A056._id_1630);

  foreach(var_3 in level._id_A056._id_191E) {
    if(!var_3 _id_6508()) {
      continue;
    }
    var_0.enemy = var_3;
    break;
  }
}

_id_6522(var_0) {
  var_1 = 2;
  var_2 = 17.6 * level._id_D127.spaceship_vel * var_1;
  var_3 = level._id_D127.origin + var_2;
  var_0._id_D238 = var_3;
}

_id_6508() {
  if(!isDefined(self._blackboard)) {
    return 0;
  }

  if(!_id_0BDC::_id_3819()) {
    return 0;
  }

  if(_id_0BDC::_id_9BCF()) {
    return 0;
  }

  if(_id_0BDC::_id_9C06()) {
    return 0;
  }

  if(self._id_9B4C) {
    return 0;
  }

  var_0 = self.origin - level._id_D127.origin;
  var_1 = length(var_0);
  var_2 = vectorNormalize(var_0);
  var_3 = vectordot(anglesToForward(level._id_D127.angles), var_2);

  if(var_3 > -0.0) {
    return 0;
  }

  if(var_1 > 50000) {
    return 0;
  }

  return 1;
}

_id_647A(var_0) {
  var_1 = 400;
  var_2 = -200;
  var_3 = _id_0BDC::_id_7B9C();
  var_4 = scripts\sp\math::_id_C097(var_2, var_1, var_3);
  var_5 = scripts\sp\math::_id_6A8E(-5000, -2000, var_4);
  var_6 = scripts\sp\math::_id_6A8E(16000, 26000, var_4);
  var_5 = var_5 + randomintrange(-1000, 0);
  var_7 = (0, 0, 300);
  var_8 = (0, randomfloatrange(-15, 15), 0);
  var_9 = rotatevector(anglesToForward(level._id_D127.angles), level._id_D127.spaceship_rotvel * 0.3);
  var_10 = rotatevector(var_9, var_8);
  var_11 = var_9 * (1000 + 3 * var_3);
  var_12 = level._id_D127.origin + var_10 * var_5 + var_11 + var_7;
  var_13 = level._id_D127.origin + var_9 * var_6 + var_11;

  if(!navtrace3d(var_12, var_13)) {
    return 0;
  }

  var_0._id_6516 = var_12;
  var_0._id_6458 = var_13;
  return 1;
}

_id_6826(var_0) {
  _id_0BDC::_id_A162();
  var_0 _id_64D4();
  var_0 _id_64AE();
  var_0 _id_64C4(1);
  var_0 thread _id_64B6();
  var_0 waittill("enemy_lock_broke");
  var_0 _id_64C4(0);
  var_0 _id_64A2();
  _id_0BDC::_id_A162(0);
}

_id_6828(var_0) {
  var_0.enemy = undefined;
  var_1 = gettime();
  var_2 = (var_1 - var_0._id_10D4B) / 1000;
  var_3 = randomfloatrange(5, 15);
  var_4 = randomfloatrange(65, 75);
  var_5 = 0;
  var_6 = 18;
  var_7 = scripts\sp\math::_id_C097(var_5, var_6, var_2);
  var_8 = scripts\sp\math::_id_6A8E(var_3, var_4, var_7);
  wait(var_8);
}

_id_6827(var_0) {
  if(_id_F0C6(4)) {
    return 0;
  }

  if(level._id_D127.spaceship_mode != "fly") {
    return 0;
  }

  if(level._id_D127.spaceship_boosting) {
    return 0;
  }

  if(level._id_D127._id_93D2.size > 0) {
    return 0;
  }

  if(scripts\sp\utility::_id_7B9D() < 0.4) {
    return 0;
  }

  if(_id_0BDC::_id_7B9C() < 300) {
    return 0;
  }

  if(length(level._id_D127.spaceship_rotvel) > 60) {
    return 0;
  }

  if(isDefined(level._id_D127._id_4BC7) && level._id_D127._id_4BC8 > 0) {
    return 0;
  }

  var_0.enemy = _id_64C1();

  if(!isDefined(var_0.enemy)) {
    return 0;
  }

  return 1;
}

_id_64C1() {
  var_0 = undefined;
  level._id_A056._id_1630 = scripts\engine\utility::array_removeundefined(level._id_A056._id_1630);

  foreach(var_2 in level._id_A056._id_191E) {
    if(var_2 _id_6507()) {
      var_0 = var_2;
      break;
    }
  }

  if(!isDefined(var_0)) {
    return undefined;
  }

  return var_0;
}

_id_6507() {
  if(!isDefined(self._blackboard)) {
    return 0;
  }

  if(!_id_0BDC::_id_3819()) {
    return 0;
  }

  if(_id_0BDC::_id_9BCF()) {
    return 0;
  }

  if(_id_0BDC::_id_9C06()) {
    return 0;
  }

  var_0 = self.origin - level._id_D127.origin;
  var_1 = length(var_0);
  var_2 = vectorNormalize(var_0);
  var_3 = vectordot(anglesToForward(level._id_D127.angles), var_2);

  if(var_3 > -0.45) {
    return 0;
  }

  if(var_1 > 30000) {
    return 0;
  }

  var_4 = self.origin - level._id_D127.origin;
  var_2 = vectorNormalize(var_4);
  var_3 = vectordot(anglesToForward(self.angles), var_2);

  if(var_3 < 0.0) {
    return 0;
  }

  return 1;
}

_id_64D4() {
  self._id_138F4 = scripts\engine\utility::spawn_script_origin();
  self._id_323B = scripts\engine\utility::spawn_tag_origin();
  self._id_3240 = scripts\engine\utility::spawn_tag_origin();
  self._id_13D10 = scripts\engine\utility::spawn_tag_origin();
  self._id_C4B9 = 0;
  self._id_B842 = 0;
  self._id_D080 = 400;
  self._id_A8CC = -9999999;
  self._id_20F5 = 0;
  self._id_647D = 0.0;
  self._id_B8A4 = [];
  self._id_138F4 linkTo(level._id_D127, "tag_origin", (0, 0, 0), (0, 0, 0));
  thread _id_64A1();
}

_id_64A1() {
  self endon("enemy_lock_broke");

  while(!self._id_20F5) {
    self._id_10D4B = gettime();
    wait 0.05;
  }
}

_id_64B6() {
  thread _id_64A8();
  thread _id_64B0();
  thread _id_64AD();
  thread _id_64AC();
}

_id_64A8() {
  self._id_FEAE = 0;
  var_0 = [];

  if(scripts\sp\utility::_id_93A6()) {
    var_0["min"] = 40;
    var_0["max"] = 50;
  } else {
    var_0["min"] = 19;
    var_0["max"] = 25;
  }

  wait(randomfloatrange(0.1, 1.3));

  for(;;) {
    _id_64D5(randomfloatrange(0.2, 1.2));

    if(self._id_B83E) {
      while(self._id_B83E) {
        wait 0.05;
      }

      _id_64D5(randomfloatrange(0.5, 1.2));
    }

    if(!_id_64AF() || self._id_680B) {
      return;
    }
    _id_64B8(randomintrange(var_0["min"], var_0["max"]));
  }
}

_id_64B0() {
  self._id_B83E = 0;

  while(!self._id_20F5) {
    wait 0.05;
  }

  _id_64D5(randomfloatrange(2, 10));

  for(;;) {
    level._id_D127._id_6E9C._id_B88A = 1;
    self._id_B83E = 1;

    if(self._id_FEAE) {
      while(self._id_FEAE) {
        wait 0.05;
      }

      wait(randomfloatrange(0.3, 1.2));
    }

    if(self._id_680B) {
      return;
    }
    if(!_id_64AF() || self._id_680B) {
      break;
    }

    thread _id_686E(["tag_flash_right", "tag_flash_left"], 3, 1);
    thread _id_6868();
    _id_64DF();
    level._id_D127._id_6E9C._id_B88A = 0;
    self._id_B83E = 0;
    self notify("missile_volley_complete");
    self._id_B842++;

    if(!_id_64AF() || self._id_680B) {
      break;
    }

    _id_64D5(randomfloatrange(7, 14));
  }
}

_id_64AD() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0.25;
  var_3 = 0;
  var_4 = 0;
  var_5 = (0, 0, 0);
  var_6 = (0, 0, 0);
  var_7 = (0, 0, 0);
  var_8 = (0, 0, 0);
  var_9 = _id_0B76::_id_A26F();
  var_9._id_12AFD._id_CA26 = 0.15;
  var_9._id_12AFD._id_CA25 = 0.2;
  var_9._id_12AFD._id_B144 = 0.45;
  var_9._id_B0EF._id_CA26 = 0.15;
  var_9._id_B0EF._id_CA25 = 0.2;
  var_9._id_B0EF._id_B144 = 0.45;
  var_10 = 0.0;
  var_11 = 0.0;
  var_12 = 0.09;
  var_13 = 0.9;
  var_14 = 0;
  var_15 = 0.3;
  self._id_C4BB = var_13;
  _id_64DC(1);
  var_16 = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0);
  var_16 = vectorNormalize(var_16);
  var_16 = var_16 * var_13;
  var_0 = var_16[0];
  var_1 = var_16[1];
  var_17 = var_0;
  var_18 = var_1;
  var_19 = spawnStruct();
  var_19._id_6AE5 = 0.8;
  var_19._id_ABAC = var_19._id_6AE5;
  var_19._id_C3D1 = 0.0;
  var_19._id_12B24 = 1.0;
  var_20 = spawnStruct();
  var_20.x = [0, 0, 0, 0];
  var_20.y = [0, 0, 0, 0];
  var_21 = spawnStruct();
  var_21._id_C099 = 0;
  var_21._id_ABA8 = 0;

  for(;;) {
    level.player waittill("on_player_update");

    if(!_id_64AF()) {
      return;
    }
    var_22 = level.player _meth_814B();
    var_6 = scripts\sp\math::_id_AB6F(var_6, var_22, 0.05);
    var_23 = length(var_22);
    var_24 = level._id_D127.spaceship_rotvel;
    var_19 _id_64DB(self._id_20F5, self._id_647D);
    self._id_D080 = var_19._id_D060;
    self._id_D07F = var_19._id_D05F;

    if(self._id_20F5) {
      var_25 = scripts\sp\math::_id_6A8E(0.73, 0.84, var_23);
      var_26 = scripts\sp\math::_id_C097(0.5, 1.0, var_19._id_ABAC);
      var_27 = scripts\sp\math::_id_6A8E(4.5, 7.5, var_26);
    } else {
      if(var_19._id_ABAC < 0.1) {
        _id_64DC(0);
        self._id_20F5 = 1;
        thread _id_64D2();
      }

      var_25 = scripts\sp\math::_id_6A8E(0.77, 0.84, var_23);
      var_26 = scripts\sp\math::_id_C097(0.3, 1.0, var_19._id_ABAC);
      var_27 = scripts\sp\math::_id_6A8E(1.5, 10.0, var_26);
    }

    var_27 = var_27 * level._id_A48E._id_A409;
    var_0 = var_0 * var_25;
    var_1 = var_1 * var_25;
    var_7 = (var_6 - var_5) * var_27;
    var_28 = scripts\sp\math::_id_C097(300, 400, self._id_D080);
    var_29 = 1 - scripts\sp\math::_id_C097(300, 600, self._id_D080);
    var_30 = var_7[1] * -1 * abs(var_22[1]) * var_28;
    var_31 = var_7[0] * abs(var_22[0]) * var_28;
    var_32 = -0.003 * var_24[1] * var_29;
    var_33 = 0.003 * var_24[0] * var_29;
    var_34 = var_32 + var_30;
    var_35 = var_33 + var_31;
    var_0 = var_0 + var_34;
    var_1 = var_1 + var_35;
    var_17 = scripts\sp\math::_id_AB6F(var_17, var_0, var_12);
    var_18 = scripts\sp\math::_id_AB6F(var_18, var_1, var_12);
    var_9 _id_0B76::_id_B7E6();
    var_10 = scripts\sp\math::_id_AB6F(var_10, var_9._id_B0EF._id_4D94["val"], 0.02);
    var_11 = scripts\sp\math::_id_AB6F(var_11, var_9._id_12AFD._id_4D94["val"], 0.02);
    var_36 = scripts\sp\math::_id_C097(0, 300, self._id_D080);
    var_37 = scripts\sp\math::_id_6A8E(0, 0.06, var_36);

    if(level._id_D127.spaceship_boosting) {
      var_37 = var_37 + 0.04;
    }

    var_38 = randomfloatrange(-1, 1) * var_37;
    var_39 = randomfloatrange(-1, 1) * var_37;
    var_40 = var_17 + var_10 + var_38 * var_37;
    var_41 = var_18 + var_11 + var_39 * var_37;
    var_21 _id_64DA(self._id_D080);
    self._id_45E2 = var_21._id_45E2;
    setomnvar("ui_jackal_enemy_lockon_x1", var_40 * 750 * (1 - self._id_45E2 * 0.5));
    setomnvar("ui_jackal_enemy_lockon_y1", var_41 * 370 * (1 - self._id_45E2 * 0.5));
    setomnvar("ui_jackal_enemy_lockon_rot_x", var_41 * self._id_45E2 * 25);
    setomnvar("ui_jackal_enemy_lockon_rot_y", var_40 * self._id_45E2 * 55);
    setomnvar("ui_jackal_enemy_lockon_ui_scale", var_19._id_12B24);
    setomnvar("ui_jackal_enemy_lockon_ui_alpha", var_19._id_12B19);
    var_42 = scripts\sp\math::_id_6A8E(0.2, 1.0, self._id_45E2);
    self._id_C4BB = length((var_17, var_18, 0));

    if(self._id_C4BB < var_42) {
      var_14 = var_14 + 0.05;

      if(var_14 == var_15 && !self._id_C4B9) {
        self._id_C4B9 = 1;
      }
    } else {
      var_14 = var_14 - 0.05;

      if(self._id_C4B9) {
        self._id_C4B9 = 0;
      }
    }

    var_14 = clamp(var_14, 0, var_15);
    _id_11A95(var_17, var_18, var_19._id_ABAC);
    var_43 = scripts\sp\math::_id_C097(200, 400, self._id_D080);
    var_43 = scripts\sp\math::_id_6A8E(1.7, 1.2, var_43);

    if(self._id_C4BB > var_43) {
      break;
    }

    if(self._id_20F5) {
      var_44 = 0.9999;
    } else {
      var_44 = 0.95;
    }

    if(var_19._id_ABAC > var_44) {
      break;
    }

    var_5 = var_6;
  }

  self notify("enemy_lock_broke");
}

_id_64D2() {
  var_0 = 0.007;
  var_1 = 14;
  var_2 = var_0 * (var_1 / 20);

  while(self._id_647D < var_0) {
    self._id_647D = self._id_647D + var_2;
    wait 0.05;
  }

  self._id_647D = var_0;
}

_id_6868() {
  self endon("missile_volley_complete");
  var_0 = 0;
  var_0 = _id_6866();
  self._id_B8A4 = scripts\engine\utility::array_removeundefined(self._id_B8A4);

  if(!_id_64AF()) {
    foreach(var_2 in self._id_B8A4) {
      var_2 _id_6867();
    }

    return;
  }

  if(var_0) {
    _id_6864();
  } else {
    _id_6865();
  }

  while(self._id_6DA7 || self._id_B8A4.size > 0) {
    foreach(var_2 in self._id_B8A4) {
      if(isDefined(var_2) && isDefined(var_2._id_898B)) {
        continue;
      }
      if(!isDefined(var_2)) {
        continue;
      }
      var_2 unlink();
      var_2._id_898B = 1;

      if(var_0) {
        var_2 _id_6869();
      } else {
        var_2 _id_6862();
      }

      wait 0.3;
    }

    wait 0.05;
  }
}

_id_6869() {
  self endon("death");

  if(level._id_D127._id_6E9C._id_12B86.size > 0) {
    self._id_6E8B = scripts\engine\utility::random(level._id_D127._id_6E9C._id_12B86);
    level._id_D127._id_6E9C._id_12B86 = scripts\engine\utility::array_remove(level._id_D127._id_6E9C._id_12B86, self._id_6E8B);
    self._id_B464 = 1500;
    self._id_6E9B = 1;
    self playSound("enemy_lockon_missile_flyby");

    for(;;) {
      if(!isDefined(self._id_6E8B)) {
        break;
      }

      var_0 = self._id_6E8B.origin - self.origin;
      var_1 = length(var_0);

      if(var_1 < self._id_B464) {
        break;
      }

      var_2 = vectorNormalize(var_0);
      self.angles = vectortoangles(var_2);
      self.origin = self.origin + var_2 * self._id_B464;
      wait 0.05;
    }

    self._id_72CA = 1;
    self._id_50D5 = undefined;
  } else
    _id_6867();
}

_id_6867() {
  self._id_50D5 = undefined;
  self delete();
}

_id_6862() {
  self._id_50D5 = undefined;
  self delete();
  var_0 = randomfloatrange(-200, 200);
  var_1 = level._id_D127.origin + anglesToForward(level._id_D127.angles) * -500 + anglesToForward(level._id_D127.angles) * var_0;
  level._id_D127 _id_0B76::_id_54DE(5000, var_1, self.enemy, "spaceship_homing_missile");
  level._id_D127 notify("missile_hit");
  thread _id_0B76::_id_12869(var_1);
  thread _id_0BDC::_id_D527("jackal_missile_explosion_plr", var_1);
}

_id_6866() {
  var_0 = 2.0;
  var_1 = 0;
  var_2 = 0;
  var_3 = var_0 / 3;
  var_4 = spawnStruct();
  var_4.state = 0;

  while(var_1 <= var_0) {
    if(!_id_64AF()) {
      break;
    }

    if(gettime() - level._id_D127._id_6E9C._id_A989 < 1300) {
      if(gettime() - level._id_D127._id_6E9C._id_A989 > 400) {
        var_2 = 1;
      }
    }

    var_4 _id_6863(var_1, var_3);
    var_5 = scripts\sp\math::_id_C097(-100, 300, self._id_D080);
    var_6 = scripts\sp\math::_id_6A8E(0.25, 0.05, var_5);
    var_1 = var_1 + var_6;
    wait 0.05;
  }

  return var_2;
}

_id_64DF() {
  while(isDefined(self) && self._id_B8A4.size > 0) {
    self._id_B8A4 = scripts\engine\utility::array_removeundefined(self._id_B8A4);
    wait 0.05;
  }
}

_id_64DA(var_0) {
  var_1 = scripts\sp\math::_id_C097(0, 350, var_0);
  self._id_C099 = scripts\sp\math::_id_6A8E(1, 0, var_1);
  self._id_ABA8 = scripts\sp\math::_id_AB6F(self._id_ABA8, self._id_C099, 0.1);
  self._id_45E2 = self._id_ABA8;
}

_id_64DB(var_0, var_1) {
  self._id_D05F = level.player getnormalizedmovement();
  var_2 = level._id_D127.spaceship_vel;
  var_3 = rotatevectorinverted(var_2, level._id_D127.angles);
  self._id_D060 = var_3[0];
  var_4 = self._id_D060 - self._id_C3D1;
  var_5 = var_4 / 3000;
  self._id_6AE5 = self._id_6AE5 + var_5;

  if(level._id_D127.spaceship_boosting) {
    if(var_0) {
      var_6 = 0.01 * level._id_A48E._id_A408;
    } else {
      var_6 = 0.03 * level._id_A48E._id_A40A;
    }
  } else if(var_0)
    var_6 = 0.0;
  else {
    var_6 = -0.02;
  }

  self._id_6AE5 = self._id_6AE5 + var_6;
  var_7 = scripts\sp\math::_id_C097(0, 250, self._id_D060);

  if(var_0) {
    var_8 = scripts\sp\math::_id_6A8E(-0.05, var_1, var_7);
  } else {
    var_8 = scripts\sp\math::_id_6A8E(-0.01, 0, var_7);
  }

  self._id_6AE5 = self._id_6AE5 + var_8;
  var_9 = scripts\sp\math::_id_C097(0, 1, self._id_D05F[0]);
  var_10 = scripts\sp\math::_id_6A8E(-0.01, 0, var_9);
  self._id_6AE5 = self._id_6AE5 + var_10;
  self._id_6AE5 = clamp(self._id_6AE5, 0, 1);
  self._id_ABAC = scripts\sp\math::_id_AB6F(self._id_ABAC, self._id_6AE5, 0.12);
  self._id_12B24 = scripts\sp\math::_id_6A8E(0, 0.72, self._id_ABAC);
  self._id_12B19 = scripts\sp\math::_id_6A8E(1, 0.35, self._id_ABAC);
  self._id_C3D1 = self._id_D060;
}

_id_64C4(var_0) {
  if(var_0) {
    self._id_138F4 playLoopSound("enemy_lockon_following");
    setomnvar("ui_jackal_enemy_lockon_active", 1);
    thread _id_64CF();
    thread _id_64C2();
  } else {
    self._id_138F4 stoploopsound("enemy_lockon_following");
    setomnvar("ui_jackal_enemy_lockon_active", 0);
    level.player playSound("enemy_lockon_break");
    _id_0BDC::_id_A112("jackal_hud_enemylock_broken", 1.5);
  }
}

_id_64CF() {
  self endon("enemy_lock_broke");
  level._id_D127 endon("player_exit_jackal");
  level._id_D127 endon("script_death");
  _id_0BDC::_id_A112("jackal_hud_enemylock_detected", 0.5);

  if(isDefined(self._id_20F5)) {
    while(!self._id_20F5) {
      wait 0.05;
    }
  }

  var_0 = 4;
  _id_0BDC::_id_A112("jackal_hud_enemylock", 0.5);

  for(;;) {
    wait(var_0);
    _id_0BDC::_id_A112("jackal_hud_locklock", 0.1);
  }
}

_id_64DD(var_0) {
  if(var_0) {
    setomnvar("ui_jackal_enemy_lockon_on_target", 1);
  } else {
    setomnvar("ui_jackal_enemy_lockon_on_target", 0);
  }
}

_id_64DC(var_0) {
  if(var_0) {
    setomnvar("ui_jackal_enemy_lockon_aquiring", 1);
    level.player playSound("enemy_lockon_acquiring");
  } else {
    setomnvar("ui_jackal_enemy_lockon_aquiring", 0);
    level.player playSound("enemy_lockon_acquired");
  }
}

_id_6863(var_0, var_1) {
  if(self.state < 2) {
    self.state = 2;
    setomnvar("ui_jackal_enemy_lockon_missile", self.state);
    level.player playSound("enemy_lockon_hud_missile_1");
  } else if(var_0 > var_1 && self.state < 3) {
    self.state = 3;
    setomnvar("ui_jackal_enemy_lockon_missile", self.state);
    level.player playSound("enemy_lockon_hud_missile_2");
  } else if(var_0 > 2 * var_1 && self.state < 4) {
    self.state = 4;
    setomnvar("ui_jackal_enemy_lockon_missile", self.state);
    level.player playSound("enemy_lockon_hud_missile_3");
  }
}

_id_6864() {
  setomnvar("ui_jackal_enemy_lockon_missile", 0);
  level.player playSound("enemy_lockon_hud_flared");
}

_id_6865() {
  setomnvar("ui_jackal_enemy_lockon_missile", -1);
}

_id_64AC() {
  self endon("enemy_lock_broke");

  while(isDefined(self.enemy) && isalive(self.enemy)) {
    wait 0.05;
  }

  self notify("enemy_lock_broke");
}

_id_64C2() {
  self endon("enemy_lock_broke");
  self.enemy endon("death");

  while(!self._id_20F5) {
    wait 0.05;
  }

  wait 2;
  var_0 = 0;
  thread _id_64A0();

  for(;;) {
    if(scripts\engine\utility::flag("jackal_flare_hint")) {
      self._id_A8CC = gettime();
      var_0 = 2;
    }

    if(!scripts\engine\utility::flag("jackal_lose_lock_hint") && !scripts\engine\utility::flag("jackal_flare_hint")) {
      if(!level._id_D127.spaceship_boosting && gettime() - self._id_A8CC > var_0 * 1000) {
        scripts\engine\utility::flag_set("jackal_lose_lock_hint");
        scripts\sp\utility::_id_56BA("jackal_lose_lock");
      }
    }

    if(level._id_D127.spaceship_boosting) {
      scripts\engine\utility::flag_clear("jackal_lose_lock_hint");
      self._id_A8CC = gettime();
      var_0 = 2;
    }

    wait 0.05;
  }
}

_id_64E0() {
  while(self._id_B83E || self._id_FEAE) {
    wait 0.05;
  }
}

_id_64AE() {
  var_0 = anglesToForward(level._id_D127.angles);
  var_1 = level._id_D127.origin + var_0 * -2000;
  self.enemy _id_0BDC::_id_19A2();
  self.enemy _id_0BDC::_id_19AE("dont_shoot");
  self.enemy _id_0BDC::_id_19B5(level._id_D127);
  self.enemy vehicle_teleport(var_1, level._id_D127.angles);
  self.enemy linkTo(self._id_323B, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.enemy.ignoreme = 1;

  if(isDefined(self.enemy._blackboard) && self.enemy._blackboard._id_C97C) {
    self.enemy._id_13902 = 1;
    self.enemy _id_0BDC::_id_1990(0);
  } else
    self.enemy._id_13902 = 0;
}

_id_64A2() {
  setomnvar("ui_jackal_enemy_lockon_isfiring", 0);
  setomnvar("ui_jackal_enemy_lockon_missile", 0);
  self._id_B8A4 = scripts\engine\utility::array_removeundefined(self._id_B8A4);

  foreach(var_1 in self._id_B8A4) {
    var_1 _id_6867();
  }

  self._id_680B = 1;
  level._id_D127._id_6E9C._id_B88A = 0;
  scripts\engine\utility::flag_clear("jackal_lose_lock_hint");

  if(isDefined(self.enemy)) {
    self.enemy thread _id_64D0();
  }

  self._id_323B delete();
  self._id_3240 delete();
  self._id_13D10 delete();
  self._id_138F4 delete();
}

_id_64D0() {
  self endon("death");
  _id_0BDC::_id_19AE("shoot_forever");
  self unlink();
  var_0 = vectortoangles(level._id_D127.origin - self.origin);
  self vehicle_teleport(self.origin, var_0);
  var_1 = distance(self.origin, level._id_D127.origin);

  if(ispointonnavmesh3d(self.origin) && _id_0BDC::_id_7B9E() < 150 && var_1 < 10000) {
    thread _id_0BDC::_id_A1EC(self.origin, 0);
    _id_0BDC::_id_19B0("hover");
    _id_0BDC::_id_19B2("face enemy");
    _id_0BDC::_id_19B5(level._id_D127);
    _id_0BDC::_id_1980(level._id_A48E._id_A40B, 1);
    _id_0BDC::_id_A36B();
    wait(randomfloatrange(4, 6));
    _id_0BDC::_id_19B0("none");
    _id_0BDC::_id_1989();
    _id_0BDC::_id_198A();
    _id_0BDC::_id_1980();
    _id_0BDC::_id_A368();
  }

  _id_0BDC::_id_19AE("shoot_at_will");
  _id_0BDC::_id_198A();
  self.ignoreme = 0;
  _id_0BDC::_id_1986();

  if(self._id_13902) {
    _id_0BDC::_id_1990(1);
  }

  self._id_13902 = undefined;
}

_id_64AF() {
  if(isDefined(self.enemy) && isalive(self.enemy)) {
    return 1;
  } else {
    return 0;
  }
}

_id_64B8(var_0) {
  var_1 = 150;

  if(scripts\sp\utility::_id_93A6()) {
    var_2 = 45;
  } else {
    var_2 = 150;
  }

  self._id_323B playLoopSound("jackal_gatling_fire_at_plr");
  self._id_FEAE = 1;

  while(var_0 > 0) {
    if(!_id_64AF() || self._id_680B) {
      return;
    }
    playFXOnTag(scripts\engine\utility::getfx("fake_follow_jackal_tracer"), self._id_323B, "tag_origin");
    setomnvar("ui_jackal_enemy_lockon_isfiring", 1);

    if(self._id_C4B9) {
      var_3 = vectorNormalize(self._id_323B.origin - level._id_D127.origin);
      var_4 = level._id_D127.origin + var_3 * var_1;
      self._id_13D10 playSound("enemy_lockon_bullet_impacts");
      level._id_D127 dodamage(var_2, var_4, self.enemy, self.enemy, "MOD_PROJECTILE", "spaceship_scripted_locked_enemy_bullets");
    } else
      self._id_13D10 playSound("enemy_lockon_whizby");

    var_0--;
    wait 0.1;
  }

  if(self._id_680B) {
    return;
  }
  self._id_FEAE = 0;
  setomnvar("ui_jackal_enemy_lockon_isfiring", 0);
  self._id_323B stoploopsound();
}

_id_64D5(var_0) {
  var_1 = 4;

  while(var_0 > 0) {
    var_2 = 0.05;
    var_3 = scripts\sp\math::_id_C097(0, 300, self._id_D080);
    var_4 = scripts\sp\math::_id_6A8E(var_1, 1, var_3);
    var_0 = var_0 - var_2 * var_4;
    wait 0.05;
  }
}

_id_64A0() {
  self.enemy endon("death");
  self endon("enemy_lock_broke");
  scripts\engine\utility::flag_wait("jackal_lose_lock_hint");
  level._id_D127 thread scripts\anim\battlechatter_ai::_id_181C("maneuver", undefined, self.enemy, 0.5);
}

_id_11A95(var_0, var_1, var_2, var_3) {
  var_4 = -1000;
  var_5 = -2000;
  var_6 = 2500;
  var_7 = 2500;
  var_8 = 1;
  var_9 = 25000;
  var_10 = 500;
  var_11 = scripts\sp\math::_id_6A8E(var_4, var_5, var_2);
  var_12 = scripts\sp\math::_id_6A8E(var_9, var_10, self._id_45E2);
  var_11 = var_11 * (1 - self._id_45E2 * 0.5);
  var_13 = 0.35;
  var_14 = (self._id_45E2 * 25 * var_1, self._id_45E2 * 55 * var_0, 0);
  var_14 = var_14 * var_13;
  var_15 = level._id_D127.spaceship_rotvel;
  var_16 = level._id_D127 gettagorigin("tag_camera");
  var_17 = level.player getplayerangles();
  var_18 = anglesToForward(var_17);
  var_19 = anglestoright(level._id_D127.angles);
  var_20 = anglestoup(level._id_D127.angles);
  var_21 = rotatevector(var_18 * var_12, var_14);
  self._id_3240.origin = var_16 + var_21;
  var_22 = rotatevector((var_18 * var_11 + var_19 * var_6 * var_0 + var_20 * var_7 * var_1 * -1) * var_8, var_14);
  self._id_323B.origin = var_16 + var_22;
  var_23 = vectorNormalize(self._id_3240.origin - self._id_323B.origin);
  self._id_323B.angles = axistoangles(var_23, var_19, var_20);
  self._id_13D10.origin = self._id_323B.origin + var_11 * var_23 * -1;
  self._id_13D10.angles = self._id_323B.angles;
}

_id_64AA() {
  self endon("death");
  self endon("stop_lockon");
  var_0 = self.origin;
  wait 0.05;

  for(;;) {
    var_1 = self gettagorigin("j_mainroot_ship");
    var_2 = self gettagangles("j_mainroot_ship");
    var_3 = var_1 - var_0;
    var_4 = vectorNormalize(var_1 - var_0);
    var_5 = length(var_3);
    var_6 = _id_64AB(var_0, var_4, var_5);

    if(isDefined(var_6)) {
      break;
    }

    var_0 = var_1;
    wait 0.05;
  }

  _id_0BDC::_id_A066(var_6);
}

_id_64AB(var_0, var_1, var_2) {
  var_3 = var_0 + var_1 * (var_2 * 0.12);
  var_4 = scripts\common\trace::capsule_trace(var_0, var_3, 150, 300, self.angles, self, undefined, 1);

  if(var_4["fraction"] < 1) {
    return var_4;
  }
}

_id_F0C6(var_0) {
  if(level._id_D127._id_58B5 || gettime() - level._id_A056._id_A976 < var_0 * 1000) {
    return 1;
  } else {
    return 0;
  }
}

_id_D30D() {
  var_0 = level.player _meth_848A();
  var_1 = level.player adsButtonPressed();

  if(var_1 && isDefined(var_0) && isDefined(var_0[0]) && var_0[1] > 0.1) {
    return 1;
  } else {
    return 0;
  }
}