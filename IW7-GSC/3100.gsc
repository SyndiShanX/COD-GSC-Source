/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3100.gsc
***************************************/

init() {
  if(!isDefined(level.func_A056.func_19FB))
    level.func_A056.func_19FB = ["spaceship_cannon_projectile", "spaceship_cleaver_projectile", "spaceship_anvil_projectile", "spaceship_30mm_projectile", "spaceship_30mm_growler", "spaceship_30mm_slow", "spaceship_cannon_projectile_weapupgrade", "spaceship_cleaver_projectile_weapupgrade", "spaceship_anvil_projectile_weapupgrade", "spaceship_30mm_projectile_weapupgrade", "spaceship_30mm_growler_weapupgrade", "spaceship_30mm_slow_weapupgrade", "spaceship_ai_30mm_projectile", "spaceship_forward_missile", "spaceship_homing_missile", "magic_spaceship_30mm_projectile", "magic_spaceship_20mm_bullet", "iw7_steeldragon"];

  self.func_4CF6 = [];
  self.health = 53800;
  self.func_4D30 = 0;
  thread damage_monitor();
  thread func_4387();
  thread death_monitor();
  thread func_6170();
}

func_D96C(var_00) {
  if(!isDefined(self.bt)) {
    return;
  }
  self endon("death");
  self notify("pilot_remembers_attack");
  wait(randomfloatrange(0.2, 0.65));
  self.var_3135.attackerdata.func_24D3 = 1;
  self.var_3135.attackerdata.attacker = level.func_D127;
  self.var_3135.attackerdata.func_2535 = gettime();
  thread func_72F9();
}

func_72F9() {
  self notify("pilot_remembers_attack");
  self endon("pilot_remembers_attack");
  self endon("death");
  wait 4;
  self.var_3135.attackerdata.func_24D3 = 0;
  self.var_3135.attackerdata.attacker = undefined;
}

func_FF27() {
  if(self.func_9B4C || self.func_9CB8)
    return 0;

  if(isDefined(self._meth_843F) && self._meth_843F)
    return 0;

  if(isDefined(self.func_51E6) && self.func_51E6)
    return 0;

  return 1;
}

func_88C4() {
  self _meth_8555(0);
  wait 5.0;

  for(;;) {
    if(_ispointonnavmesh3d(self.origin, self)) {
      self _meth_8555(1);
      return;
    }

    wait 0.1;
  }
}

func_4387() {
  self endon("death");
  var_00 = 50;
  var_01 = 300;
  var_02 = 200;
  var_03 = 4000;
  var_04 = 0;
  var_05 = 3;
  var_06 = 0;
  self.func_438E = -1000;
  self.func_438C = (0, 0, 0);

  for(;;) {
    self waittill("spaceship_collision", var_07, var_08, var_09, var_10, var_11, var_12);

    if(self.func_438E < 0 || gettime() > self.func_438E + 1000) {
      self.func_438E = gettime();
      self.func_438C = self.origin;
      continue;
    } else if(gettime() < self.func_438E + 500) {
      continue;
    }
    var_13 = distance(self.func_438C, self.origin) / (gettime() - self.func_438E) * 1000;
    self.func_438E = gettime();
    self.func_438C = self.origin;

    if(var_13 < 150.0) {
      self notify("jackal_stuck_on_geo");

      if(func_FF27()) {
        self notify("death");
        return;
      } else
        func_88C4();
    }

    wait 0.5;
  }
}

damage_monitor() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    self.func_4B43 = var_01;
    var_10 = func_24DC(var_01);

    if(!var_10 && isDefined(level.func_D127) && var_01 == level.func_D127)
      thread func_D96C(var_04);

    var_11 = func_9D1C(var_09);
    var_12 = 0;

    if(isDefined(self._meth_843F) && self._meth_843F)
      var_12 = 1;

    var_13 = 0;

    if(isDefined(self.func_51E6) && self.func_51E6)
      var_13 = 1;

    if(!var_10 && var_11 && !var_12) {
      thread func_4CF9(var_03, var_01);

      if(var_13)
        self.health = 53800;
    } else
      self.health = 53800;

    if(self.health < 50000) {
      self notify("death", var_01, var_04, var_09);
      self _meth_81D0();
    }

    thread func_4D1B();
  }
}

func_DFE7() {}

func_4D1B() {
  if(isDefined(self._meth_843F) && self._meth_843F) {
    return;
  }
  if(isDefined(self.func_51E6) && self.func_51E6) {
    return;
  }
  self notify("new_regen");
  self endon("new_regen");
  self endon("death");
  wait 3;

  while(self.health < 53800) {
    self.health = self.health + 5;

    if(self.health > 1500 && self.func_4D30) {
      self.func_4D30 = 0;
      self notify("stop_damaged_fx");
    }

    wait 0.1;
  }

  if(self.health > 53800)
    self.health = 53800;
}

func_24DC(var_00) {
  if(isDefined(var_00) && isDefined(var_0.script_team) && isDefined(self.script_team) && var_0.script_team == self.script_team)
    return 1;

  return 0;
}

func_9D1C(var_00) {
  if(!isDefined(var_00))
    return 0;

  foreach(var_02 in level.func_A056.func_19FB) {
    if(var_02 == var_00)
      return 1;
  }

  return 0;
}

func_4CF9(var_00, var_01) {
  var_02 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_00;
  var_2.angles = self.angles;
  var_02 linkto(self, "j_mainroot_ship");
  playFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_damage_med_linger"), var_02, "tag_origin");
  func_0BDC::func_13675(randomfloatrange(2, 4));

  if(isDefined(var_02))
    var_02 thread func_10FF8();
}

func_4D34(var_00, var_01) {
  scripts\sp\utility::func_75C4("fighter_spaceship_damaged", "j_mainroot_ship");
  scripts\engine\utility::waittill_either("death", "stop_damaged_fx");

  if(isDefined(self))
    scripts\sp\utility::func_75F8("fighter_spaceship_damaged", "j_mainroot_ship");
}

#using_animtree("jackal");

death_monitor() {
  self endon("terminate_ai_threads");
  func_4E11();
  self waittill("death", var_00, var_01, var_02);
  func_0BDC::func_1983();

  if(!isDefined(self)) {
    return;
  }
  var_03 = self.spaceship_vel;
  var_04 = rotatevectorinverted(var_03, self.angles);
  var_05 = var_4[0];

  if(isDefined(self.func_862D))
    var_06 = self.func_862D;
  else
    var_06 = undefined;

  if(isDefined(self.func_90D1))
    var_07 = 1;
  else
    var_07 = 0;

  if(isDefined(self.func_3D4F))
    var_08 = 1;
  else
    var_08 = 0;

  if(isDefined(self.func_4B43) && isDefined(level.func_D127) && self.func_4B43 == level.func_D127) {
    var_08 = 0;
    level.func_A056.func_63A3++;
    var_09 = 1;
  } else
    var_09 = 0;

  scripts\sp\utility::func_65E1("is_dying");
  thread func_646F();

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.func_700B)) {
    func_A1DA();

    if(isDefined(self))
      self delete();

    return;
  }

  var_10 = spawn("script_model", self.origin);
  var_10.angles = self.angles;
  var_10 glinton(#animtree);
  var_10 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_10 setModel(self.model);
  var_11 = self.script_team;

  if(var_09) {
    func_56FF(var_10.origin, 5000, 39000, 0.24, 0.7);
    _playworldsound("jackal_deathspin_by_plr_init", var_10.origin);
    level.player playrumbleonentity("damage_light");
  }

  if(func_FF6C(var_06, var_02, var_05)) {
    var_12 = [ % jackal_death_01, % jackal_death_02, % jackal_death_03, % jackal_death_04];
    level.func_A8D7++;

    if(level.func_A8D7 >= var_12.size)
      level.func_A8D7 = 0;

    var_13 = var_12[level.func_A8D7];

    if(isDefined(self.func_72B1))
      var_13 = self.func_72B1;

    var_14 = func_7819();
    var_10 give_attacker_kill_rewards( % jackal_state_anims_ai);
    var_10 give_attacker_kill_rewards( % jackal_ca_vehicle_strike_state_idle);
    var_10 thread func_4E6C();
    var_10 give_attacker_kill_rewards( % jackal_death_overlay);
    var_10 give_attacker_kill_rewards(var_13);

    if(isDefined(self.func_93D2)) {
      foreach(var_16 in self.func_93D2) {
        if(isDefined(var_16))
          var_16.func_114F9 = var_10;
      }
    }

    var_10.func_C0A4 = 1;
    var_18 = func_7B23(var_10);
    func_5164();
    var_06 = func_4E16(var_10, randomfloatrange(1.0, 2.0), var_18, self);
    stopFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_dying"), var_10, "j_mainroot_ship");
  } else
    func_5164();

  var_19 = var_10 gettagangles("j_mainroot_ship");
  var_20 = var_10 gettagorigin("j_mainroot_ship");

  if(isDefined(var_06) && isDefined(var_6["normal"])) {
    var_21 = vectortoangles(var_6["normal"]);
    playFX(scripts\engine\utility::getfx("fighter_spaceship_explosion_ground"), var_20, anglesToForward(var_21), anglestoup(var_21));
  } else {
    var_22 = func_3E80(var_11, var_08, var_07, var_05);
    playFX(scripts\engine\utility::getfx(var_22), var_20, anglesToForward(var_19), anglestoup(var_19));
  }

  if(var_09) {
    func_56FF(var_10.origin, 16000, 39000, 0.45, 1.1);

    if(!isDefined(self.func_C045))
      _playworldsound("jackal_death_by_plr", var_20);

    level.player playrumbleonentity("damage_heavy");
  }

  if(!isDefined(self.func_C045))
    thread scripts\engine\utility::play_sound_in_space(func_0BDC::func_7A5B("jackal_explode"), var_20);

  if(scripts\engine\utility::player_is_in_jackal())
    thread func_107D8(var_20);

  var_10 delete();

  if(isDefined(self))
    self delete();
}

func_7819() {
  if(self.spaceship_mode == "fly")
    var_00 = "_fly";
  else
    var_00 = "_hover";

  if(level.func_241D)
    var_01 = "";
  else
    var_01 = "_space";

  return level.func_A065[self.script_team + var_00 + var_01];
}

func_5164() {
  level.func_A056.func_1630 = scripts\engine\utility::array_remove(level.func_A056.func_1630, self);

  if(isDefined(self))
    self delete();
}

func_FF6C(var_00, var_01, var_02) {
  if(isDefined(var_00))
    return 0;

  if(isDefined(self.func_9930) && self.func_9930)
    return 0;

  if(isDefined(self.func_90D1) && self.func_90D1)
    return 0;

  if(isDefined(self.func_72B1))
    return 1;

  if(isDefined(var_01) && var_01 == "spaceship_cannon_projectile")
    return 0;

  if(func_119DE(var_02))
    return 0;

  return 1;
}

func_3E80(var_00, var_01, var_02, var_03) {
  if(var_01)
    return var_00 + "_spaceship_explosion_cheap";

  if(level.func_241D)
    var_04 = "";
  else
    var_04 = "_space";

  var_05 = var_00 + "_spaceship_explosion" + var_04;
  var_06 = var_00 + "_spaceship_explosion_hov" + var_04;

  if(func_119DE(var_03))
    return var_06;

  if(var_02)
    return var_06;

  return var_05;
}

func_119DE(var_00) {
  if(var_00 < 150)
    return 1;

  return 0;
}

func_7B23(var_00) {
  var_01 = var_0.origin;
  wait 0.05;
  var_02 = distance(var_01, var_0.origin);
  return var_02;
}

func_4E11() {
  if(!scripts\sp\utility::func_65DF("is_dying"))
    scripts\sp\utility::func_65E0("is_dying");

  if(!isDefined(level.func_A8D7))
    level.func_A8D7 = 0;
}

func_646F() {
  self endon("entitydeleted");

  for(var_00 = 0; var_00 < 5; var_0++) {
    self notify("death");
    wait 0.05;
  }
}

func_4E6C() {
  playFX(scripts\engine\utility::getfx("fighter_spaceship_dying_init"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  playFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_dying"), self, "J_mainroot_ship");
  var_00 = func_0BDC::func_7A5B("jackal_dying_loop");
  self playLoopSound(var_00);
}

func_4E16(var_00, var_01, var_02, var_03) {
  var_00 endon("entitydeleted");
  var_00 unlink();
  var_04 = undefined;

  while(var_01 > 0) {
    var_0.origin = var_0.origin + anglesToForward(var_0.angles) * var_02;
    var_04 = var_00 func_C0A2(var_02, var_03);

    if(isDefined(var_04))
      var_01 = 0;

    var_01 = var_01 - 0.05;
    wait 0.05;
  }

  return var_04;
}

func_C0A2(var_00, var_01) {
  var_02 = self gettagorigin("j_mainroot_ship");
  var_03 = self gettagangles("j_mainroot_ship");
  var_04 = var_02;
  var_05 = var_02 + anglesToForward(var_03) * (var_00 * 0.1);
  var_06 = scripts\engine\trace::capsule_trace(var_04, var_05, 150, 300, var_03, [self, var_01], undefined, 1);

  if(var_6["fraction"] < 1)
    return var_06;
}

func_C0A3(var_00) {}

func_6170() {
  self endon("terminate_ai_threads");
  self endon("death");
  self endon("entitydeleted");
  var_00 = 5;
  var_01 = 11;
  var_02 = 700;

  for(;;) {
    self waittill("emp", var_03, var_04, var_05);
    self.func_4B43 = var_05;
    var_06 = var_02 * var_03;
    var_07 = scripts\sp\math::func_6A8E(var_00, var_01, var_03);
    func_0BDC::func_19A0(1);
    var_08 = self.spaceship_mode;

    if(isDefined(self.fx.func_13D7E) && self.fx.func_13D7E) {
      var_09 = 1;
      func_0BDC::func_A167();
    } else
      var_09 = 0;

    func_0BDC::func_6B4C("none", 1);
    func_0BDC::func_105D9();
    self.func_615D.func_619D = 1;

    if(isDefined(self.script_team) && isDefined(var_5.script_team) && self.script_team == var_5.script_team) {} else {
      thread func_6174(var_06, var_04, var_03);
      thread func_614C(var_03);
    }

    wait(var_07);
    self.func_615D.func_619D = 0;

    if(self.func_AEDF.func_AEEA)
      func_0BDC::func_105D6();

    self notify("emp_complete");
    func_0BDC::func_19A0(0);
    func_0BDC::func_6B4C(var_08, 1);
    self unlink();

    if(var_09)
      func_0BDC::func_A19F();
  }
}

func_614C(var_00) {
  var_01 = 2;
  var_02 = 0.5;
  var_03 = scripts\sp\math::func_6A8E(var_02, var_01, var_00);
  thread func_0BDC::func_D527("jackal_enemy_emp", self.origin, var_03);
}

func_6174(var_00, var_01, var_02) {
  self endon("emp_complete");
  self endon("death");
  self endon("entitydeleted");
  var_03 = self.origin;
  wait 0.05;
  var_04 = self.origin - var_03;
  var_05 = 0.8;
  var_06 = func_7D20(var_02);
  var_07 = 0;
  var_08 = 400;
  var_09 = 3;
  var_10 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, var_10);
  self linkto(var_10);

  for(;;) {
    wait 0.05;
    var_07 = var_07 - var_09;

    if(var_07 > var_08)
      var_07 = var_08;

    var_11 = var_01 * var_00;
    var_12 = var_04 + var_11 + (0, 0, var_07);
    var_10 func_6175(var_06);
    var_10.origin = var_10.origin + var_12;
    var_13 = func_C0A2(length(var_12));

    if(isDefined(var_13)) {
      break;
    }
    var_00 = var_00 * var_05;

    if(var_00 < 0)
      var_00 = 0;
  }

  var_10 delete();
  self.func_4074 = scripts\engine\utility::array_remove(self.func_4074, var_10);
  func_0BDC::func_A066(var_13);
}

func_7D20(var_00) {
  var_01 = scripts\sp\math::func_6A8E(4, 13, var_00);
  var_02 = (randomfloatrange(0.1, 1), randomfloatrange(0.1, 1), randomfloatrange(0.1, 1));
  return vectornormalize(var_02) * var_01;
}

func_6175(var_00) {
  self.angles = _combineangles(self.angles, var_00);
}

func_10FF8() {
  stopFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_damage_med_linger"), self, "tag_origin");
  wait 6;

  if(isDefined(self))
    self delete();
}

func_56FF(var_00, var_01, var_02, var_03, var_04) {
  var_05 = distance(var_00, level.func_D127.origin);
  var_06 = scripts\sp\math::func_C097(var_01, var_02, var_05);
  var_07 = scripts\sp\math::func_6A8E(var_03, 0.02, var_06);
  var_08 = scripts\sp\math::func_6A8E(var_04, 0.3, var_06);
  earthquake(var_07, 0.9, level.func_D127.origin, 8000);
}

func_107D8(var_00) {
  var_01 = 5;
  var_02 = 15000;
  var_03 = 3400;

  while(var_01 > 0) {
    if(isDefined(level.func_D127))
      var_04 = distance(level.func_D127.origin, var_00);
    else
      break;

    if(var_04 < var_03) {
      func_D0DB(var_00);
      break;
    } else if(var_04 > var_02) {
      break;
    }
    var_01 = var_01 - 0.05;
    wait 0.05;
  }
}

func_D0DB(var_00) {
  var_01 = "jackal_debris_impact";
  var_02 = 2;

  if(scripts\engine\utility::player_is_in_jackal())
    playFXOnTag(scripts\engine\utility::getfx("jackal_debris_impact"), level.player _meth_8473(), "j_mainroot_ship");

  level.player playrumbleonentity("steady_rumble");
  earthquake(0.33, var_02, level.player.origin, 5000);
  _playworldsound(var_01, var_00);
  wait(var_02);
  level.player stoprumble("steady_rumble");
}

func_A1DA() {
  self notify("crashing");
  var_00 = scripts\engine\utility::getstructarray("jackal_death_node", "targetname");
  func_0BDC::func_19AE("dont_shoot");
  self.func_4E15 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self linkto(self.func_4E15);
  thread func_700C();
  thread func_A340(180);
  func_BC89(var_00);
  playFXOnTag(level._effect["fighter_spaceship_explosion_ground"], self, "tag_origin");
  self.func_4E15 delete();
}

func_A340(var_00) {
  self endon("reached_flyoff_position");
  var_01 = randomfloatrange(0.5, 1.5);

  for(;;) {
    self.func_4E15 rotateyaw(90, 1);
    wait(var_01);

    if(var_01 - 0.1 > 0.5)
      var_01 = var_01 - 0.1;
  }
}

func_BC89(var_00) {
  var_01 = func_7A56(var_00);
  var_02 = randomfloatrange(1.5, 3);
  self.func_4E15 moveto(var_1.origin, var_02, var_02 * 0.9);
  wait(var_02);
  self notify("reached_flyoff_position");
  var_1.inuse = undefined;
  playFX(level._effect["fighter_spaceship_explosion_ground"], var_1.origin);
}

func_7A56(var_00) {
  var_00 = sortbydistance(var_00, self.origin);

  foreach(var_02 in var_00) {
    if(!isDefined(var_2.inuse)) {
      var_2.inuse = 1;
      return var_02;
    }
  }

  return var_0[0];
}

func_700C() {
  playFXOnTag(level._effect["fighter_spaceship_dying"], self, "tag_origin");
  playFXOnTag(level._effect["fighter_spaceship_explosion_hov"], self, "tag_origin");
  playFXOnTag(level._effect["fighter_spaceship_damage_med_hov_trail"], self, "tag_origin");
}

func_7A58() {
  return (self.health - 50000) / (self.maxhealth - 50000);
}