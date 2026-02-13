/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1896.gsc
*************************************************/

_id_80E3() {
  scripts\engine\utility::_id_5C11("weapons_free");
  scripts\engine\utility::_id_5C24("strike_init_done");
  var_0 = getEntArray("trigger_spawn", "targetname");
  scripts\engine\utility::_id_1BE2(var_0, ::_id_D831);
  var_0 = getEntArray("trigger_kill_floodspawner", "targetname");
  scripts\engine\utility::_id_1BE2(var_0, ::_id_8D24);
}

_id_D831() {
  level endon("game_ended");
  self notify("setup_trigger_spawn");
  self endon("setup_trigger_spawn");
  self endon("death");
  scripts\engine\utility::_id_5473("spawning_complete");
  scripts\engine\utility::_id_5473("spawning_paused");
  _id_4597();
  wait 1;

  if(!istrue(self._id_4D7C)) {
    self delete();
  }
}

_id_4597() {
  self endon("death");
  self notify("default_trigger_loop");
  self endon("default_trigger_loop");
  self._id_E34D = undefined;
  self._id_7344 = 0;

  if(isDefined(self.target)) {
    self._id_E34D = scripts\engine\utility::getstructarray(self.target, "targetname");
  }

  var_0 = [];
  var_1 = undefined;

  if(isDefined(self._id_E34D)) {
    foreach(var_3 in self._id_E34D) {
      if(!isDefined(var_3._id_CD99)) {
        continue;
      }
      if(var_3._id_CD99 == "extra") {
        var_0[var_0.size] = var_3;
      }
    }

    var_1 = self._id_E34D;
  }

  scripts\engine\utility::_id_5470("spawning_complete");

  for(;;) {
    self waittill("trigger", var_5);

    if(_id_0743::_id_874F()) {
      wait 1;
      continue;
    }

    if(!var_5 scripts\cp\utility::_id_8708()) {
      continue;
    }
    if(getdvarint("#x333cf5e65255e8870", 0) == 1) {
      break;
    }

    level thread _id_AA68(self, var_5);

    if(!isDefined(var_1)) {
      self notify("spawnpoints_not_found");
      return;
    }

    if(scripts\engine\utility::_id_5472("spawning_paused") && scripts\engine\utility::_id_546E("spawning_paused")) {
      scripts\engine\utility::_id_547B("spawning_paused");
    }

    switch (level.players.size) {
      case 1:
        var_1 = scripts\engine\utility::_id_1BBF(var_1, var_0);
        break;
      case 2:
        var_0 = scripts\engine\utility::array_randomize(var_0);
        var_0 = [var_0[0], var_0[1]];
        var_1 = scripts\engine\utility::array_combine(var_1, var_0);
        break;
      default:
        break;
    }

    var_6 = 0;

    foreach(var_3 in var_1) {
      var_8 = _id_0D80(var_3);

      if(!isDefined(var_8)) {
        continue;
      }
      var_8 thread _id_A688(self, var_8);
      var_3._id_904F = gettime();
      var_8._id_8D8E = gettime() + 10000;

      if(isDefined(level._id_53C9) && !istrue(level._id_49F9)) {
        var_8 thread[[level._id_53C9]]("soldier");
      }

      var_8 thread _id_C684(var_3);
      var_6++;

      if(var_6 % 4 == 0) {
        wait 0.05;
      }
    }

    break;
  }
}

_id_A688(var_0, var_1) {
  var_0 endon("death");
  var_0._id_7344++;
  var_1 waittill("death");
  var_0._id_7344--;

  if(var_0._id_7344 <= 0) {
    var_0 scripts\engine\utility::_id_5474("spawning_complete");
  }
}

_id_C684(var_0) {
  level endon("game_ended");
  var_0 endon("done_spawning");

  if(!isDefined(var_0._id_011A)) {
    return;
  }
  var_0._id_011A = int(var_0._id_011A);
  self endon("game_ended");
  self waittill("death");

  if(isDefined(var_0._id_011A) && var_0._id_011A > 0) {
    var_0._id_011A--;
    _id_107B8(var_0);
    thread _id_CE53(var_0);
  }
}

_id_107B8(var_0) {
  if(isDefined(var_0._id_CEB7)) {
    var_0._id_CEB7 = int(var_0._id_CEB7);
    wait(var_0._id_CEB7);
  } else
    wait 0.1;
}

_id_AA68(var_0, var_1) {
  if(isDefined(var_0._id_CD99)) {
    level notify("trigger_" + var_0._id_CD99);
  }

  if(isDefined(var_0._id_CD62) && isDefined(level._id_F5F9[var_0._id_CD62])) {
    level thread[[level._id_F5F9[var_0._id_CD62]]](var_0, var_1);
  }

  if(isDefined(var_0._id_CD45)) {
    if(!scripts\engine\utility::_id_5C0C(var_0._id_CD45)) {
      scripts\engine\utility::_id_5C11(var_0._id_CD45);
    }

    scripts\engine\utility::_id_5C1B(var_0._id_CD45);
  }
}

_id_E127(var_0, var_1) {
  var_2 = ["s4_ar_stango44"];
  var_3 = ["s4_ar_stango44"];
  var_4 = ["s4_ar_stango44"];
  var_5 = ["s4_ar_stango44"];
  var_6 = ["s4_ar_stango44"];
  var_7 = undefined;

  if(!isDefined(var_0._id_039B)) {
    var_0._id_039B = "soldier";
  }

  var_8 = undefined;
  var_9 = undefined;

  if(!isDefined(var_1)) {
    switch (var_0._id_039B) {
      case "rpg":
        var_1 = scripts\engine\utility::random(var_6);
        var_8 = ::_id_D1B9;
        break;
      case "shotgun":
        var_1 = scripts\engine\utility::random(var_4);
        var_9 = ::_id_7BBB;
        break;
      case "sniper":
        var_1 = scripts\engine\utility::random(var_3);
        var_8 = ::_id_D1BB;
        break;
      case "lmg":
        var_1 = scripts\engine\utility::random(var_5);
        var_8 = ::_id_D1BB;
        break;
      default:
        var_1 = scripts\engine\utility::random(var_2);
    }
  }

  var_1 = scripts\cp\cp_weapon::_id_6980(var_1);
  var_7 = _id_E12B(var_0, var_1);

  if(isDefined(var_7)) {
    var_7._id_E342 = var_0;
    var_7._id_E2EF = var_8;
    var_7._id_3AAF = var_9;
  }

  return var_7;
}

_id_E12B(var_0, var_1) {
  var_2 = "axis";

  if(isDefined(level._id_121D)) {
    if(isDefined(level._id_121D["soldier"])) {
      var_2 = level._id_121D["soldier"];
    }
  }

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_3 = (0, var_0.angles[1], 0);
  var_4 = var_0.origin;
  var_5 = undefined;
  var_6 = 0;
  var_7 = "actor_enemy_cp_alq_desert_ar";

  if(var_0._id_039B == "juggernaut") {
    var_7 = "actor_enemy_cp_rus_juggernaut";
  }

  for(;;) {
    var_5 = _id_07F7::_id_E32A(var_7, var_4, var_3);

    if(isDefined(var_5)) {
      break;
    }

    var_6++;

    if(var_6 > 2) {
      return undefined;
    }

    wait 0.05;
    continue;
  }

  var_5._id_E342 = var_0;
  return var_5;
}

_id_7059(var_0) {
  self endon("death");
  self endon("dontfight");
  self._id_A991 = self._id_0201;
  self._id_0201 = 48;
  _id_06BD::_id_23F3("combat");
  var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  self _meth_8326(_func_02AB(var_1.origin));
  scripts\engine\utility::waittill_any_2("goal_reached", "goal");

  if(getdvarint("#x3c894dfd14e8c530a") == 1) {
    _id_06FD::_id_5494();
  } else {
    _id_5494();
  }
}

_id_D1C2(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0._id_722E)) {
    self._id_722E = var_0._id_722E;
  }

  if(isDefined(var_1._id_CD7D)) {
    self._id_722E = var_1._id_CD7D;
  }

  if(isDefined(self._id_04B9) && self._id_04B9 == "juggernaut") {
    return;
  }
  self.health = 125;
  self.maxhealth = 125;
  self._id_A994 = 125;
  self._id_0201 = 4096;
  self._id_A991 = self._id_0201;
  self._id_E342 = var_1;
  self._id_03D6 = scripts\cp\cp_weapon::buildweapon("s4_pi_mike1911", [], "none", "none", -1);
  scripts\common\utility::_id_82BA(self._id_034C);
  scripts\common\utility::_id_82BA(self._id_03D6);
  thread _id_46A1();

  if(isDefined(self._id_E2EF)) {
    self thread[[self._id_E2EF]]();
  }

  if(istrue(level._id_FE0C)) {
    self._id_A468 = gettime();
    var_2 = randomintrange(1, 7);
    self._id_ADF1 = "generic_pain_enemy_" + var_2;
    self._id_440C = "generic_death_enemy_" + var_2;
  }
}

_id_46A1() {
  self endon("death");
  wait 0.1;
  self._id_0188 = 0;
  self._id_0DDF._id_4AC4 = 1;
}

_id_D1B8() {
  _id_06BD::_id_23F3("patrol");
  self._id_A991 = self._id_0201;
  self._id_0201 = 48;
  self._id_0229 = 1;
  self._id_CF4A = 1;
  thread _id_575F();
  thread _id_0743::_id_58F8();
  self._id_E7B2 = 1;
}

_id_D1B9() {
  self endon("death");
  wait 0.5;
  self._id_0201 = 300;
  self._id_A991 = self._id_0201;
  self._id_037B = 100;
  self._id_001D = 2;
}

_id_D1BB() {
  self endon("death");
  self._id_A50F = 1;
  wait 0.5;
  self._id_0201 = 250;
  self._id_A991 = self._id_0201;
}

_id_EE83(var_0) {
  self endon("death");
  self endon("alerted");
  var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");

  for(;;) {
    self _meth_8326(_func_02AB(var_1.origin));
    scripts\engine\utility::waittill_any_2("goal_reached", "goal");

    if(isDefined(var_1.target)) {
      var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
      var_1 = var_2;
      continue;
    }

    break;
  }
}

_id_6D08(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_2 = [var_2];
  } else {
    var_2 = [];
  }

  foreach(var_4 in var_1) {
    if(istrue(var_4._id_3D06)) {
      var_5 = 999;
    } else if(istrue(var_4._id_73B8)) {
      var_5 = 500;
    } else {
      var_5 = 99;
    }

    var_6 = scripts\engine\utility::_id_6369(var_0.origin, _id_06FE::_id_6882("soldier_agent"), var_2, 5, 512);

    if(var_6.size >= 1) {
      var_5 = var_5 * (100 * var_6.size);
    }

    var_5 = clamp(var_5, 0, 999);
    var_4._id_AF4E = int(var_5);
  }

  var_8 = scripts\cp\utility::_id_BEF7(var_1);

  foreach(var_4 in var_8) {
    var_4._id_AF4E = 0;
  }

  return var_8[0];
}

_id_D4E3(var_0, var_1) {
  level endon("game_ended");
  var_2 = 0.5 * var_1;
  var_0._id_3D06 = 1;
  wait(var_2);
  var_0._id_3D06 = undefined;
  var_0._id_73B8 = 1;
  wait(var_2);
  var_0._id_73B8 = undefined;
}

_id_AF0F(var_0, var_1) {
  self endon("death");
  self endon("alerted");
  var_2 = scripts\engine\utility::getstructarray("soldier_patrol", "script_noteworthy");
  var_3 = scripts\engine\utility::_id_6369(var_0.origin, scripts\engine\utility::getstructarray("soldier_patrol", "script_noteworthy"), [var_0], 15);

  if(var_3.size < 1) {
    var_2 = scripts\engine\utility::getstructarray(var_0._id_0481, "targetname");
    var_3 = scripts\engine\utility::_id_6369(var_0.origin, scripts\engine\utility::getstructarray(var_0._id_0481, "targetname"), [var_0], 15);
  }

  var_4 = scripts\engine\utility::_id_6969(var_0.origin, var_3, 256);

  if(isDefined(var_4)) {
    var_5 = var_4;
  } else {
    var_5 = _id_6D08(self, var_3);
  }

  for(;;) {
    var_5 thread _id_D4E3(var_5, 99);
    self _meth_8326(_func_02AB(var_5.origin));
    scripts\engine\utility::_id_108A8(15, "goal_reached", "goal");

    if(scripts\engine\utility::cointoss()) {
      wait(randomfloatrange(2.5, 5));
    }

    if(isDefined(var_5.target)) {
      var_6 = scripts\engine\utility::getstructarray(var_5.target, "targetname")[0];

      if(isDefined(var_6)) {
        var_5 = var_6;
        continue;
      } else if(istrue(var_1)) {
        break;
      }
    } else if(istrue(var_1)) {
      break;
    }

    var_5 = _id_6D08(self, var_3, var_5);
  }
}

_id_575F() {
  self notify("exit_patrol_mode");
  self endon("exit_patrol_mode");
  self endon("death");
  self endon("alerted");

  if(scripts\engine\utility::_id_5C0C("infil_complete")) {
    scripts\engine\utility::_id_5C24("infil_complete");
  }

  thread _id_10A36();
  thread _id_10A6F();
  thread _id_E006();
  scripts\engine\utility::_id_10888(self, "damage", level, "grenade_explosion", self, "alerted_by_soldier");

  if(getdvarint("#x3c894dfd14e8c530a") == 1) {
    _id_06FD::_id_5494();
  } else {
    _id_5494();
  }

  wait 2.4;
  _id_1423("heard damage");
}

_id_10A36() {
  self endon("death");
  self endon("alerted");
  var_0 = "";
  var_1 = 0;
  var_2 = scripts\engine\utility::_id_1088C(self, "bulletwhizby", self, "door_bashopen");

  if(var_2 == "bulletwhizby") {
    var_0 = "shots heard";
    var_1 = 0;
  } else if(var_2 == "door_bashopen") {
    var_0 = "door heard";
    var_1 = 0;
  }

  if(_id_F602(5.1, undefined, var_2, var_1)) {
    if(getdvarint("#x3c894dfd14e8c530a") == 1) {
      _id_06FD::_id_5494();
    } else {
      _id_5494();
    }

    wait 2.4;
    _id_1423(var_0);
  } else
    thread _id_10A36();
}

_id_10A6F() {
  self endon("death");
  self endon("alerted");

  for(;;) {
    level waittill("weapon_fired", var_0, var_1, var_2);
    var_3 = 0;

    foreach(var_5 in var_1._id_0070) {
      if(issubstr(var_5, "silencer")) {
        var_3 = 1;
      }
    }

    if(var_3) {
      continue;
    }
    break;
  }

  if(_id_F602(2.6, undefined, "weapon_fired", 1)) {
    if(getdvarint("#x3c894dfd14e8c530a") == 1) {
      _id_06FD::_id_5494();
    } else {
      _id_5494();
    }

    wait 2.4;
    _id_1423("shots heard");
  }
}

_id_F602(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::_id_5C0C("weapons_free") && scripts\engine\utility::_id_5C00("weapons_free")) {
    return 0;
  }

  self endon("alerted");

  if(!isDefined(level._id_86D4)) {
    return 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.25;
  }

  if(!istrue(self._id_74D2)) {
    self._id_74D2 = 1;
    wait 0.05;
    var_4 = _func_0353(self);
    _func_0355(var_4, "cp_stealth_icon_sus_sv");
    _func_035B(var_4, 1);
    _func_035A(var_4, 29000);
    _func_0359(var_4, 425);
    _func_035D(var_4, 25);
    self._id_1427 = var_4;
    thread _id_F06B(10);
    thread _id_F069(var_4);
    var_5 = undefined;

    if(!istrue(var_3)) {
      wait(var_1);

      if(var_2 == "can_see") {
        foreach(var_7 in level.players) {
          if(_id_7CF9(self, var_7)) {
            var_5 = "can_see";
            thread _id_F05D(var_7);
          }

          wait 0.05;
        }
      } else
        var_5 = "default";

      if(isDefined(var_5) && var_5 != "can_see") {
        var_5 = scripts\engine\utility::_id_108AC(var_0, var_2, "can_see", "death", "near_me", "damage", "hear_turret");
      }
    }

    if(isDefined(var_5) && (var_5 == var_2 || var_5 == "can_see" || var_5 == "near_me") || istrue(var_3)) {
      thread _id_F06A(var_0, 2, "cp_stealth_icon_seen");
      return 1;
    } else {
      thread _id_489B(self._id_1427, 0.01);
      return 0;
    }
  }

  return 0;
}

_id_F06B(var_0) {
  self endon("icon_deleted");
  self endon("icon_cancel_delete");
  self endon("alerted");
  self endon("death");

  if(istrue(self._id_74D2) || isDefined(self._id_1427) && self._id_1427 == 0) {
    if(isalive(self)) {
      var_1 = var_0;
      var_2 = 0;

      while(var_1 > 0) {
        var_1--;
        var_2 = !var_2;

        if(var_2 == 1) {
          _func_0355(self._id_1427, "cp_stealth_icon_seen");
        } else {
          _func_0355(self._id_1427, "cp_stealth_icon_sus_sv");
        }

        wait 0.05;
        wait 0.05;
      }

      if(scripts\engine\utility::_id_5C0C("weapons_free") && scripts\engine\utility::_id_5C00("weapons_free")) {
        _func_0355(self._id_1427, "cp_stealth_icon_notify");
      } else if(scripts\engine\utility::_id_5C0C("weapons_free") && !scripts\engine\utility::_id_5C00("weapons_free")) {
        _func_0355(self._id_1427, "cp_stealth_icon_sus_sv");
      }
    }
  }
}

_id_F06A(var_0, var_1, var_2) {
  self endon("icon_deleted");
  self endon("alerted");
  self endon("death");
  var_3 = 1;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(istrue(self._id_74D2) || isDefined(self._id_1427) && self._id_1427 == 0) {
      if(isalive(self)) {
        self notify("icon_cancel_delete");
        _func_0355(self._id_1427, var_2);
        thread _id_489B(self._id_1427, var_0 * 5.5);
      }
    }

    wait 0.05;
  }
}

_id_489B(var_0, var_1) {
  self notify("icon_cancel_delete");
  self endon("icon_deleted");
  scripts\engine\utility::_id_108A8(var_1, "death", "alerted");
  wait 0.5;
  thread _id_489C(var_0);
}

_id_489C(var_0) {
  self notify("icon_cancel_delete");
  self endon("icon_deleted");
  self endon("icon_cancel_delete");

  if(istrue(self._id_74D2) && istrue(self._id_1427) && istrue(var_0)) {
    self._id_74D2 = 0;
    _func_0354(var_0);
    var_0 = undefined;
    self notify("icon_deleted");
  } else if(istrue(self._id_74D2)) {
    self._id_74D2 = 0;
    _func_0354(var_0);
    var_0 = undefined;
    self notify("icon_deleted");
  }
}

_id_F069(var_0) {
  self endon("icon_deleted");
  self waittill("death");
  self notify("icon_cancel_delete");
  var_1 = 0.45;

  if(scripts\engine\utility::_id_5C0C("weapons_free") && scripts\engine\utility::_id_5C00("weapons_free")) {
    var_1 = var_1 * 5.5;
  }

  wait(var_1);

  if(isDefined(var_0)) {
    self._id_74D2 = 0;
    _func_0354(var_0);
    var_0 = undefined;
    self notify("icon_deleted");
  }
}

_id_F05D(var_0) {
  if(!scripts\engine\utility::_id_5C0C("weapons_free")) {
    return;
  }
  self notify("new_last_triggered");
  self endon("new_last_triggered");
  var_1 = undefined;

  for(;;) {
    if(!scripts\engine\utility::_id_5C00("weapons_free")) {
      var_1 = var_0;
    } else {
      level._id_445B = var_1;
      return;
    }

    wait 0.1;
  }
}

_id_5494() {
  self notify("enter_combat");
  self._id_CF4A = 0;
  self._id_0229 = 0;

  if(isDefined(self._id_8920)) {
    self _meth_81AD();
  }

  if(isDefined(self._id_E342._id_CD76)) {
    var_0 = getent(self._id_E342._id_CD76, "script_noteworthy");

    if(!isDefined(var_0)) {
      var_0 = getent(self._id_E342._id_CD76, "targetname");
    }

    if(isDefined(var_0)) {
      self _meth_8328(var_0);
    }
  }

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp\utility::_id_8708()) {
      continue;
    }
    self _meth_812E(var_2);
  }

  if(isDefined(self._id_A991)) {
    self._id_0201 = self._id_A991;
  } else {
    self._id_0201 = 4096;
  }

  _id_06BD::_id_23F3("combat");

  if(isDefined(self._id_3AAF)) {
    self thread[[self._id_3AAF]]();
  }

  thread _id_F063();
}

_id_F063() {
  if(istrue(level._id_FE0C) && _func_0205("dx_cbc_ru1_command_attack")) {
    if(randomint(100) > 50) {
      self playSound("dx_cbc_ru1_command_attack");
    }

    self._id_A468 = gettime() + randomintrange(1000, 3000);
    thread _id_F064();
  }
}

_id_F064() {
  self notify("temp_sound_watcher");
  self endon("temp_sound_watcher");
  self endon("death");
  var_0 = 5;
  var_1 = 25;

  if(istrue(self._id_7BDD)) {
    var_0 = 3;
    var_1 = 5;
  }

  for(;;) {
    wait(randomintrange(var_0, var_1));
    var_2 = scripts\engine\utility::random(["dx_cbc_ru1_command_attack", "dx_cbc_ru1_contactclock_" + randomintrange(1, 13), "dx_cbc_ru1_inform_suppressed"]);

    if(_func_0205(var_2)) {
      self playSound(var_2);
    }
  }
}

_id_E006() {
  level endon("game_ended");
  self notify("soldier_player_listener");
  self endon("soldier_player_listener");
  self endon("alerted");
  self endon("death");
  self endon("exit_stealth");
  _id_E007();

  if(getdvarint("#x3c894dfd14e8c530a") == 1) {
    _id_06FD::_id_5494();
  } else {
    _id_5494();
  }

  wait 6.96;
  _id_1423("near player");
}

_id_E007() {
  level endon("game_ended");
  self notify("soldier_player_listener_checker");
  self endon("soldier_player_listener_checker");
  self endon("alerted");
  self endon("death");
  self endon("exit_stealth");

  for(;;) {
    foreach(var_1 in level.players) {
      if(_id_8996(self, var_1)) {
        self notify("near_me");

        if(getdvarint("#x3c894dfd14e8c530a") == 1) {
          _id_06FD::_id_5494();
        } else {
          _id_5494();
        }

        wait 0.05;

        if(_id_F602(2.6, undefined, "near_me", 1)) {
          wait 2.4;
          _id_1423("near player");
        }
      } else if(_id_7CF9(self, var_1)) {
        self notify("can_see");
        wait 0.05;
        var_2 = scripts\engine\utility::_id_4B8C(self.origin, var_1.origin);
        var_3 = var_2 / 160000;

        if(var_3 < 0.9) {
          var_3 = 0.9;
        }

        if(_id_F602(2.6, var_3, "can_see")) {
          if(isDefined(self._id_1427)) {
            thread _id_F06A(2.6, 2, "cp_stealth_icon_seen");
          }

          if(getdvarint("#x3c894dfd14e8c530a") == 1) {
            _id_06FD::_id_5494();
          } else {
            _id_5494();
          }

          wait 2.4;
          _id_1423("see player");
        }
      }

      wait 0.05;
    }

    wait 0.1;
  }
}

_id_8996(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(istrue(var_1.ignoreme)) {
    return 0;
  }

  var_2 = isPlayer(var_1);
  var_3 = distance(var_1.origin, var_0.origin);
  var_4 = istrue(var_0._id_42EC);

  if(var_1 getstance() == "crouch") {
    if(var_3 > 35) {
      return 0;
    }
  } else if(var_3 > 96)
    return 0;

  var_5 = _func_0202(var_0 getEye(), var_1 getEye(), 0, var_0, var_4);

  if(!var_5) {
    return 0;
  }

  var_6 = scripts\engine\trace::_id_3F70(1);

  if(!scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), var_0, var_6)) {
    return 0;
  }

  return 1;
}

_id_7CF9(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(istrue(var_1.ignoreme)) {
    return 0;
  }

  var_2 = isPlayer(var_1);
  var_3 = distance(var_1.origin, var_0.origin);
  var_4 = istrue(var_0._id_42EC);
  var_5 = 1;
  var_6 = var_1 getvelocity();
  var_7 = length(var_6);

  if(var_7 < 128) {
    var_5 = 0.75;
  } else if(var_7 < 200 || var_2 && var_1._id_AFAA["stealth_velocity_override"]) {
    var_5 = 1;
  } else {
    var_5 = 1.25;
  }

  if(var_3 > 1500 * var_5) {
    return 0;
  }

  var_8 = var_0 _meth_8067(var_1);

  if(var_8) {
    var_9 = cos(75);
    var_10 = scripts\engine\utility::_id_10E76(var_0 getEye(), var_0 getplayerangles(1), var_1.origin + (0, 0, 40), var_9);

    if(!var_10) {
      return 0;
    }

    var_11 = _func_0202(var_0 getEye(), var_1 getEye(), 0, var_0, var_4);

    if(!var_11) {
      return 0;
    }

    var_12 = scripts\engine\trace::_id_3F70(1);

    if(!scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), var_0, var_12)) {
      return 0;
    }

    var_13 = scripts\engine\math::_id_645E(var_0.origin, anglesToForward(var_0.angles), var_1.origin);
    var_5 = 1;

    if(var_13 >= 0.573576) {
      var_5 = var_5 - 0.34;
    }

    if(var_4) {
      var_5 = var_5 - 0.34;
    }

    var_14 = var_1 getstance();

    if(var_3 <= int(350 / var_5)) {
      if(var_14 == "prone") {
        return 0;
      }

      return 1;
    } else if(var_3 <= int(500 / var_5)) {
      if(var_14 == "prone") {
        return 0;
      }

      return 1;
    } else if(var_3 <= int(950 / var_5)) {
      if(var_14 == "prone" || var_14 == "crouch") {
        return 0;
      }

      return 1;
    }
  }

  return 0;
}

_id_1423(var_0) {
  wait 0.1;
  thread _id_F06A(2.6, 2, "cp_stealth_icon_notify");

  if(scripts\engine\utility::_id_5C0C("weapons_free") && !scripts\engine\utility::_id_5C00("weapons_free")) {
    scripts\engine\utility::_id_5C1B("weapons_free");
    level notify("stop_weapon_fire_monitor");
  }

  var_1 = _id_06FE::_id_68A1("axis");
  var_2 = 16386304;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4) || var_4 == self) {
      continue;
    }
    if(!isDefined(var_4._id_1210) || isDefined(var_4._id_1210) && var_4._id_1210 != "soldier_agent") {
      continue;
    }
    if(distance2dsquared(self.origin, var_4.origin) > var_2) {
      continue;
    }
    if(getdvarint("#x3c894dfd14e8c530a") == 1) {
      var_4 _id_06FD::_id_5494();
    } else {
      var_4 _id_5494();
    }

    var_4 notify("alerted");
  }

  thread _id_1424(var_0);
}

_id_1424(var_0) {
  wait 0.1;

  foreach(var_2 in level.players) {
    var_3 = " ";

    if(isDefined(level._id_445B)) {
      var_3 = level._id_445B.name;
    }

    var_2 iprintlnbold("^2 " + var_3 + "^3 Alerted the Guards! : " + var_0);
    wait 0.05;
  }
}

_id_1A47(var_0) {
  var_1 = _id_06FE::_id_68A1("axis");
  var_2 = var_0 * var_0;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4) || var_4 == self) {
      continue;
    }
    if(!isDefined(var_4._id_1210) || isDefined(var_4._id_1210) && var_4._id_1210 != "soldier_agent") {
      continue;
    }
    var_5 = distance2dsquared(self.origin, var_4.origin);

    if(var_5 > var_2) {
      continue;
    }
    return 1;
  }

  return 0;
}

_id_7F80() {
  var_0 = getEntArray("trigger_fallback", "targetname");
  scripts\engine\utility::_id_1BE2(var_0, ::_id_D7B4);
}

_id_D7B4() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    [[level._id_5964]](self, var_0);
    break;
  }

  wait 1;
  self delete();
}

_id_5962(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  var_2 = scripts\engine\utility::_id_6969(self.origin, var_1);
  self._id_0201 = 128;
  self _meth_8326(_func_02AB(var_2.origin));
  scripts\engine\utility::waittill_any_2("goal", "goal_reached");
  self._id_0201 = 1500;
}

_id_CE53(var_0) {
  if(_id_0743::_id_874F()) {
    return undefined;
  }

  if(!_func_0107(var_0)) {
    var_1 = _id_0D80(var_0);

    if(isDefined(var_1)) {
      var_1 thread _id_C684(var_0);
    }

    return var_1;
  }

  var_2 = [];
  var_3 = [];
  var_4 = 0;
  var_5 = var_0;

  foreach(var_7 in var_0) {
    if(!isDefined(var_7._id_CD99)) {
      continue;
    }
    if(var_7._id_CD99 == "extra") {
      var_3[var_3.size] = var_7;
    }
  }

  switch (level.players.size) {
    case 1:
      var_0 = scripts\engine\utility::_id_1BBF(var_0, var_3);
      break;
    case 2:
      var_3 = scripts\engine\utility::array_randomize(var_3);
      var_3 = [var_3[0]];

      if(var_3.size == 2) {
        var_3 = [var_3[0], var_3[1]];
      } else if(var_3.size > 2) {
        var_3 = [var_3[0], var_3[1], var_3[2]];
      }

      var_0 = scripts\engine\utility::array_combine(var_0, var_3);
      break;
    default:
  }

  foreach(var_7 in var_0) {
    var_1 = _id_0D80(var_7);

    if(!isDefined(var_1)) {
      continue;
    }
    var_1 thread _id_C684(var_7);
    var_2[var_2.size] = var_1;
    var_4++;

    if(var_4 % 4 == 0) {
      wait 0.05;
    }
  }

  if(var_2.size) {
    return var_2;
  } else {
    return undefined;
  }
}

_id_0D80(var_0, var_1, var_2, var_3) {
  if(getdvarint("#x3c894dfd14e8c530a") == 1) {
    if(!isDefined(level._id_7A3F)) {
      return undefined;
    }
  }

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_4 = var_0 _id_0743::_id_E0AE();

  if(isDefined(var_4)) {
    var_0 notify("spawn_success", var_0);
    level notify("spawned_group_soldier", var_4);
    thread _id_0743::_id_C9A8(undefined, var_4, var_0, undefined, undefined, 1, undefined);
    return var_4;
  }
}

_id_4459(var_0) {
  var_0 endon("death");
  var_0._id_A546 = 1;
  wait 3;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_0, var_0, "MOD_SUICIDE");
}

_id_445A(var_0) {
  var_0._id_A546 = 1;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_0, var_0, "MOD_SUICIDE");
}

_id_66E2() {
  var_0 = ["soldier", "soldier", "soldier", "juggernaut", "armored", "armored", "armored", "armored_helmet", "armored_helmet"];
  return var_0;
}

_id_C222(var_0, var_1) {
  if(!isDefined(level._id_F5F9)) {
    level._id_F5F9 = [];
  }

  level._id_F5F9[var_0] = var_1;
}

_id_CA14(var_0, var_1, var_2) {
  if(isDefined(level._id_F5F9[var_0])) {
    level thread[[level._id_F5F9[var_0]]](var_1, var_2);
  }
}

_id_6307(var_0) {
  var_1 = [];
  var_2 = _id_06FE::_id_68A1("axis");

  foreach(var_4 in var_2) {
    if(!var_4.isactive) {
      continue;
    }
    if(!isDefined(var_4._id_722E)) {
      continue;
    }
    if(var_4._id_722E != var_0) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_7BBC() {
  self endon("death");
  var_0 = randomintrange(25, 60);
  var_1 = randomintrange(10, 15);
  _id_7BBB(var_0, var_1);
}

_id_7BBB(var_0, var_1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  while(!_id_DAAA()) {
    wait 1;
  }

  self._id_7BDD = 1;
  self._id_A50F = 1;
  self._id_0201 = 500;
  thread _id_C175(var_1);

  for(;;) {
    if(!isDefined(self._id_0192)) {
      wait 0.5;
      self._id_7BDD = 0;
      continue;
    }

    self._id_7BDD = 1;
    self _meth_8323(self._id_0192, 3);
    wait 3;
  }
}

_id_DAAA() {
  var_0 = 0;
  var_1 = _id_06FE::_id_68A1("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_7BDD)) {
      var_0++;
    }
  }

  if(var_0 >= level.players.size) {
    return 0;
  }

  return 1;
}

_id_C175(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  for(;;) {
    if(self._id_0201 < 250) {
      self._id_0201 = 250;
    } else {
      self._id_0201 = self._id_0201 - 100;

      if(self._id_0201 < 50) {
        self._id_0201 = 50;
      }
    }

    wait(var_0);
  }
}

_id_10715(var_0) {
  for(;;) {
    var_1 = _id_6307(var_0);

    if(!var_1.size) {
      break;
    }

    wait 1;
  }

  level._id_1674 = 0;
}

#using_animtree("script_model");

_id_4BF3(var_0, var_1) {
  if(istrue(var_1._id_84EF)) {
    return;
  }
  var_1._id_84EF = 1;
  var_2 = ["sdr_com_inter_rdoor_tac_ex_cqb_a", "sdr_com_inter_rdoor_tac_ex_cqb_b", "sdr_com_inter_rdoor_tac_ex_cqb_c"];
  var_1._id_A988 = var_1.angles;

  foreach(var_5, var_4 in var_0) {
    var_4 thread _id_4E13(var_4, var_2, var_1, var_5);
  }

  var_1._id_18AF = "ai_spawn_door";
  var_1 useanimtree(#animtree);
  var_1 thread _id_06C6::_id_1845(var_1, "sdr_com_inter_rdoor_tac_ex_cqb_door");
  var_1 playSound("wood_door_kick");
  var_6 = var_0[var_0.size - 1] _id_0009::_id_1C7D("animscripted", var_2[var_0.size - 1]);
  var_7 = var_0[var_0.size - 1] _id_0009::_id_1C6E("animscripted", var_6);
  wait(_func_0079(var_7) + 3);
  var_1._id_84EF = 0;
}

_id_4E13(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0._id_0229 = 1;
  var_0._id_CF4A = 1;
  _id_0AED::_id_18CA(var_1[var_3], var_2);
  var_0._id_0229 = 0;
  var_0._id_CF4A = 0;
  var_0 _id_0AED::_id_18C1();
}

_id_8D24() {
  var_0 = scripts\engine\utility::getstructarray(self.target, "targetname");

  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::_id_8708()) {
      continue;
    }
    foreach(var_3 in var_0) {
      var_3._id_011A = 0;
    }

    break;
  }

  wait 1;
  self delete();
}

_id_63FA() {
  var_0 = 1073741824;
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(_id_073B::_id_B4EF(var_3)) {
      continue;
    }
    var_4 = distancesquared(self.origin, var_3.origin);

    if(var_3 scripts\cp_mp\utility\player_utility::_isalive() && var_4 < var_0) {
      var_1 = var_3;
      var_0 = var_4;
    }
  }

  return var_1;
}