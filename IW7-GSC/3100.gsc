/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3100.gsc
**************************************/

init() {
  if(!isDefined(level.var_A056.var_19FB)) {
    level.var_A056.var_19FB = ["spaceship_cannon_projectile", "spaceship_cleaver_projectile", "spaceship_anvil_projectile", "spaceship_30mm_projectile", "spaceship_30mm_growler", "spaceship_30mm_slow", "spaceship_cannon_projectile_weapupgrade", "spaceship_cleaver_projectile_weapupgrade", "spaceship_anvil_projectile_weapupgrade", "spaceship_30mm_projectile_weapupgrade", "spaceship_30mm_growler_weapupgrade", "spaceship_30mm_slow_weapupgrade", "spaceship_ai_30mm_projectile", "spaceship_forward_missile", "spaceship_homing_missile", "magic_spaceship_30mm_projectile", "magic_spaceship_20mm_bullet", "iw7_steeldragon"];
  }

  self.var_4CF6 = [];
  self.health = 53800;
  self.var_4D30 = 0;
  thread damage_monitor();
  thread func_4387();
  thread death_monitor();
  thread func_6170();
}

func_D96C(var_0) {
  if(!isDefined(self.bt)) {
    return;
  }
  self endon("death");
  self notify("pilot_remembers_attack");
  wait(randomfloatrange(0.2, 0.65));
  self.bt.attackerdata.var_24D3 = 1;
  self.bt.attackerdata.attacker = level.var_D127;
  self.bt.attackerdata.var_2535 = gettime();
  thread func_72F9();
}

func_72F9() {
  self notify("pilot_remembers_attack");
  self endon("pilot_remembers_attack");
  self endon("death");
  wait 4;
  self.bt.attackerdata.var_24D3 = 0;
  self.bt.attackerdata.attacker = undefined;
}

func_FF27() {
  if(self.var_9B4C || self.var_9CB8) {
    return 0;
  }

  if(isDefined(self._meth_843F) && self._meth_843F) {
    return 0;
  }

  if(isDefined(self.var_51E6) && self.var_51E6) {
    return 0;
  }

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
  var_0 = 50;
  var_1 = 300;
  var_2 = 200;
  var_3 = 4000;
  var_4 = 0;
  var_5 = 3;
  var_6 = 0;
  self.var_438E = -1000;
  self.var_438C = (0, 0, 0);

  for(;;) {
    self waittill("spaceship_collision", var_7, var_8, var_9, var_10, var_11, var_12);

    if(self.var_438E < 0 || gettime() > self.var_438E + 1000) {
      self.var_438E = gettime();
      self.var_438C = self.origin;
      continue;
    } else if(gettime() < self.var_438E + 500) {
      continue;
    }
    var_13 = distance(self.var_438C, self.origin) / (gettime() - self.var_438E) * 1000;
    self.var_438E = gettime();
    self.var_438C = self.origin;

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
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self.var_4B43 = var_1;
    var_10 = func_24DC(var_1);

    if(!var_10 && isDefined(level.var_D127) && var_1 == level.var_D127) {
      thread func_D96C(var_4);
    }

    var_11 = func_9D1C(var_9);
    var_12 = 0;

    if(isDefined(self._meth_843F) && self._meth_843F) {
      var_12 = 1;
    }

    var_13 = 0;

    if(isDefined(self.var_51E6) && self.var_51E6) {
      var_13 = 1;
    }

    if(!var_10 && var_11 && !var_12) {
      thread func_4CF9(var_3, var_1);

      if(var_13) {
        self.health = 53800;
      }
    } else
      self.health = 53800;

    if(self.health < 50000) {
      self notify("death", var_1, var_4, var_9);
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
  if(isDefined(self.var_51E6) && self.var_51E6) {
    return;
  }
  self notify("new_regen");
  self endon("new_regen");
  self endon("death");
  wait 3;

  while(self.health < 53800) {
    self.health = self.health + 5;

    if(self.health > 1500 && self.var_4D30) {
      self.var_4D30 = 0;
      self notify("stop_damaged_fx");
    }

    wait 0.1;
  }

  if(self.health > 53800) {
    self.health = 53800;
  }
}

func_24DC(var_0) {
  if(isDefined(var_0) && isDefined(var_0.script_team) && isDefined(self.script_team) && var_0.script_team == self.script_team) {
    return 1;
  }

  return 0;
}

func_9D1C(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  foreach(var_2 in level.var_A056.var_19FB) {
    if(var_2 == var_0) {
      return 1;
    }
  }

  return 0;
}

func_4CF9(var_0, var_1) {
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_0;
  var_2.angles = self.angles;
  var_2 linkto(self, "j_mainroot_ship");
  playFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_damage_med_linger"), var_2, "tag_origin");
  func_0BDC::func_13675(randomfloatrange(2, 4));

  if(isDefined(var_2)) {
    var_2 thread func_10FF8();
  }
}

func_4D34(var_0, var_1) {
  scripts\sp\utility::func_75C4("fighter_spaceship_damaged", "j_mainroot_ship");
  scripts\engine\utility::waittill_either("death", "stop_damaged_fx");

  if(isDefined(self)) {
    scripts\sp\utility::func_75F8("fighter_spaceship_damaged", "j_mainroot_ship");
  }
}

#using_animtree("jackal");

death_monitor() {
  self endon("terminate_ai_threads");
  func_4E11();
  self waittill("death", var_0, var_1, var_2);
  func_0BDC::func_1983();

  if(!isDefined(self)) {
    return;
  }
  var_3 = self.spaceship_vel;
  var_4 = rotatevectorinverted(var_3, self.angles);
  var_5 = var_4[0];

  if(isDefined(self.var_862D)) {
    var_6 = self.var_862D;
  } else {
    var_6 = undefined;
  }

  if(isDefined(self.var_90D1)) {
    var_7 = 1;
  } else {
    var_7 = 0;
  }

  if(isDefined(self.var_3D4F)) {
    var_8 = 1;
  } else {
    var_8 = 0;
  }

  if(isDefined(self.var_4B43) && isDefined(level.var_D127) && self.var_4B43 == level.var_D127) {
    var_8 = 0;
    level.var_A056.var_63A3++;
    var_9 = 1;
  } else
    var_9 = 0;

  scripts\sp\utility::func_65E1("is_dying");
  thread func_646F();

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.var_700B)) {
    func_A1DA();

    if(isDefined(self)) {
      self delete();
    }

    return;
  }

  var_10 = spawn("script_model", self.origin);
  var_10.angles = self.angles;
  var_10 glinton(#animtree);
  var_10 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_10 setModel(self.model);
  var_11 = self.script_team;

  if(var_9) {
    func_56FF(var_10.origin, 5000, 39000, 0.24, 0.7);
    _playworldsound("jackal_deathspin_by_plr_init", var_10.origin);
    level.player playrumbleonentity("damage_light");
  }

  if(func_FF6C(var_6, var_2, var_5)) {
    var_12 = [ % jackal_death_01, % jackal_death_02, % jackal_death_03, % jackal_death_04];
    level.var_A8D7++;

    if(level.var_A8D7 >= var_12.size) {
      level.var_A8D7 = 0;
    }

    var_13 = var_12[level.var_A8D7];

    if(isDefined(self.var_72B1)) {
      var_13 = self.var_72B1;
    }

    var_14 = func_7819();
    var_10 give_attacker_kill_rewards( % jackal_state_anims_ai);
    var_10 give_attacker_kill_rewards( % jackal_ca_vehicle_strike_state_idle);
    var_10 thread func_4E6C();
    var_10 give_attacker_kill_rewards( % jackal_death_overlay);
    var_10 give_attacker_kill_rewards(var_13);

    if(isDefined(self.var_93D2)) {
      foreach(var_16 in self.var_93D2) {
        if(isDefined(var_16)) {
          var_16.var_114F9 = var_10;
        }
      }
    }

    var_10.var_C0A4 = 1;
    var_18 = func_7B23(var_10);
    func_5164();
    var_6 = func_4E16(var_10, randomfloatrange(1.0, 2.0), var_18, self);
    stopFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_dying"), var_10, "j_mainroot_ship");
  } else
    func_5164();

  var_19 = var_10 gettagangles("j_mainroot_ship");
  var_20 = var_10 gettagorigin("j_mainroot_ship");

  if(isDefined(var_6) && isDefined(var_6["normal"])) {
    var_21 = vectortoangles(var_6["normal"]);
    playFX(scripts\engine\utility::getfx("fighter_spaceship_explosion_ground"), var_20, anglesToForward(var_21), anglestoup(var_21));
  } else {
    var_22 = func_3E80(var_11, var_8, var_7, var_5);
    playFX(scripts\engine\utility::getfx(var_22), var_20, anglesToForward(var_19), anglestoup(var_19));
  }

  if(var_9) {
    func_56FF(var_10.origin, 16000, 39000, 0.45, 1.1);

    if(!isDefined(self.var_C045)) {
      _playworldsound("jackal_death_by_plr", var_20);
    }

    level.player playrumbleonentity("damage_heavy");
  }

  if(!isDefined(self.var_C045)) {
    thread scripts\engine\utility::play_sound_in_space(func_0BDC::func_7A5B("jackal_explode"), var_20);
  }

  if(scripts\engine\utility::player_is_in_jackal()) {
    thread func_107D8(var_20);
  }

  var_10 delete();

  if(isDefined(self)) {
    self delete();
  }
}

func_7819() {
  if(self.spaceship_mode == "fly") {
    var_0 = "_fly";
  } else {
    var_0 = "_hover";
  }

  if(level.var_241D) {
    var_1 = "";
  } else {
    var_1 = "_space";
  }

  return level.var_A065[self.script_team + var_0 + var_1];
}

func_5164() {
  level.var_A056.var_1630 = scripts\engine\utility::array_remove(level.var_A056.var_1630, self);

  if(isDefined(self)) {
    self delete();
  }
}

func_FF6C(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    return 0;
  }

  if(isDefined(self.var_9930) && self.var_9930) {
    return 0;
  }

  if(isDefined(self.var_90D1) && self.var_90D1) {
    return 0;
  }

  if(isDefined(self.var_72B1)) {
    return 1;
  }

  if(isDefined(var_1) && var_1 == "spaceship_cannon_projectile") {
    return 0;
  }

  if(func_119DE(var_2)) {
    return 0;
  }

  return 1;
}

func_3E80(var_0, var_1, var_2, var_3) {
  if(var_1) {
    return var_0 + "_spaceship_explosion_cheap";
  }

  if(level.var_241D) {
    var_4 = "";
  } else {
    var_4 = "_space";
  }

  var_5 = var_0 + "_spaceship_explosion" + var_4;
  var_6 = var_0 + "_spaceship_explosion_hov" + var_4;

  if(func_119DE(var_3)) {
    return var_6;
  }

  if(var_2) {
    return var_6;
  }

  return var_5;
}

func_119DE(var_0) {
  if(var_0 < 150) {
    return 1;
  }

  return 0;
}

func_7B23(var_0) {
  var_1 = var_0.origin;
  wait 0.05;
  var_2 = distance(var_1, var_0.origin);
  return var_2;
}

func_4E11() {
  if(!scripts\sp\utility::func_65DF("is_dying")) {
    scripts\sp\utility::func_65E0("is_dying");
  }

  if(!isDefined(level.var_A8D7)) {
    level.var_A8D7 = 0;
  }
}

func_646F() {
  self endon("entitydeleted");

  for(var_0 = 0; var_0 < 5; var_0++) {
    self notify("death");
    wait 0.05;
  }
}

func_4E6C() {
  playFX(scripts\engine\utility::getfx("fighter_spaceship_dying_init"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  playFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_dying"), self, "J_mainroot_ship");
  var_0 = func_0BDC::func_7A5B("jackal_dying_loop");
  self playLoopSound(var_0);
}

func_4E16(var_0, var_1, var_2, var_3) {
  var_0 endon("entitydeleted");
  var_0 unlink();
  var_4 = undefined;

  while(var_1 > 0) {
    var_0.origin = var_0.origin + anglesToForward(var_0.angles) * var_2;
    var_4 = var_0 func_C0A2(var_2, var_3);

    if(isDefined(var_4)) {
      var_1 = 0;
    }

    var_1 = var_1 - 0.05;
    wait 0.05;
  }

  return var_4;
}

func_C0A2(var_0, var_1) {
  var_2 = self gettagorigin("j_mainroot_ship");
  var_3 = self gettagangles("j_mainroot_ship");
  var_4 = var_2;
  var_5 = var_2 + anglesToForward(var_3) * (var_0 * 0.1);
  var_6 = scripts\engine\trace::capsule_trace(var_4, var_5, 150, 300, var_3, [self, var_1], undefined, 1);

  if(var_6["fraction"] < 1) {
    return var_6;
  }
}

func_C0A3(var_0) {}

func_6170() {
  self endon("terminate_ai_threads");
  self endon("death");
  self endon("entitydeleted");
  var_0 = 5;
  var_1 = 11;
  var_2 = 700;

  for(;;) {
    self waittill("emp", var_3, var_4, var_5);
    self.var_4B43 = var_5;
    var_6 = var_2 * var_3;
    var_7 = scripts\sp\math::func_6A8E(var_0, var_1, var_3);
    func_0BDC::func_19A0(1);
    var_8 = self.spaceship_mode;

    if(isDefined(self.fx.var_13D7E) && self.fx.var_13D7E) {
      var_9 = 1;
      func_0BDC::func_A167();
    } else
      var_9 = 0;

    func_0BDC::func_6B4C("none", 1);
    func_0BDC::func_105D9();
    self.var_615D.var_619D = 1;

    if(isDefined(self.script_team) && isDefined(var_5.script_team) && self.script_team == var_5.script_team) {} else {
      thread func_6174(var_6, var_4, var_3);
      thread func_614C(var_3);
    }

    wait(var_7);
    self.var_615D.var_619D = 0;

    if(self.var_AEDF.var_AEEA) {
      func_0BDC::func_105D6();
    }

    self notify("emp_complete");
    func_0BDC::func_19A0(0);
    func_0BDC::func_6B4C(var_8, 1);
    self unlink();

    if(var_9) {
      func_0BDC::func_A19F();
    }
  }
}

func_614C(var_0) {
  var_1 = 2;
  var_2 = 0.5;
  var_3 = scripts\sp\math::func_6A8E(var_2, var_1, var_0);
  thread func_0BDC::func_D527("jackal_enemy_emp", self.origin, var_3);
}

func_6174(var_0, var_1, var_2) {
  self endon("emp_complete");
  self endon("death");
  self endon("entitydeleted");
  var_3 = self.origin;
  wait 0.05;
  var_4 = self.origin - var_3;
  var_5 = 0.8;
  var_6 = func_7D20(var_2);
  var_7 = 0;
  var_8 = 400;
  var_9 = 3;
  var_10 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self.var_4074 = scripts\engine\utility::array_add(self.var_4074, var_10);
  self linkto(var_10);

  for(;;) {
    wait 0.05;
    var_7 = var_7 - var_9;

    if(var_7 > var_8) {
      var_7 = var_8;
    }

    var_11 = var_1 * var_0;
    var_12 = var_4 + var_11 + (0, 0, var_7);
    var_10 func_6175(var_6);
    var_10.origin = var_10.origin + var_12;
    var_13 = func_C0A2(length(var_12));

    if(isDefined(var_13)) {
      break;
    }
    var_0 = var_0 * var_5;

    if(var_0 < 0) {
      var_0 = 0;
    }
  }

  var_10 delete();
  self.var_4074 = scripts\engine\utility::array_remove(self.var_4074, var_10);
  func_0BDC::func_A066(var_13);
}

func_7D20(var_0) {
  var_1 = scripts\sp\math::func_6A8E(4, 13, var_0);
  var_2 = (randomfloatrange(0.1, 1), randomfloatrange(0.1, 1), randomfloatrange(0.1, 1));
  return vectornormalize(var_2) * var_1;
}

func_6175(var_0) {
  self.angles = _combineangles(self.angles, var_0);
}

func_10FF8() {
  stopFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_damage_med_linger"), self, "tag_origin");
  wait 6;

  if(isDefined(self)) {
    self delete();
  }
}

func_56FF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = distance(var_0, level.var_D127.origin);
  var_6 = scripts\sp\math::func_C097(var_1, var_2, var_5);
  var_7 = scripts\sp\math::func_6A8E(var_3, 0.02, var_6);
  var_8 = scripts\sp\math::func_6A8E(var_4, 0.3, var_6);
  earthquake(var_7, 0.9, level.var_D127.origin, 8000);
}

func_107D8(var_0) {
  var_1 = 5;
  var_2 = 15000;
  var_3 = 3400;

  while(var_1 > 0) {
    if(isDefined(level.var_D127)) {
      var_4 = distance(level.var_D127.origin, var_0);
    } else {
      break;
    }

    if(var_4 < var_3) {
      func_D0DB(var_0);
      break;
    } else if(var_4 > var_2) {
      break;
    }
    var_1 = var_1 - 0.05;
    wait 0.05;
  }
}

func_D0DB(var_0) {
  var_1 = "jackal_debris_impact";
  var_2 = 2;

  if(scripts\engine\utility::player_is_in_jackal()) {
    playFXOnTag(scripts\engine\utility::getfx("jackal_debris_impact"), level.player _meth_8473(), "j_mainroot_ship");
  }

  level.player playrumbleonentity("steady_rumble");
  earthquake(0.33, var_2, level.player.origin, 5000);
  _playworldsound(var_1, var_0);
  wait(var_2);
  level.player stoprumble("steady_rumble");
}

func_A1DA() {
  self notify("crashing");
  var_0 = scripts\engine\utility::getstructarray("jackal_death_node", "targetname");
  func_0BDC::func_19AE("dont_shoot");
  self.var_4E15 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self linkto(self.var_4E15);
  thread func_700C();
  thread func_A340(180);
  func_BC89(var_0);
  playFXOnTag(level._effect["fighter_spaceship_explosion_ground"], self, "tag_origin");
  self.var_4E15 delete();
}

func_A340(var_0) {
  self endon("reached_flyoff_position");
  var_1 = randomfloatrange(0.5, 1.5);

  for(;;) {
    self.var_4E15 rotateyaw(90, 1);
    wait(var_1);

    if(var_1 - 0.1 > 0.5) {
      var_1 = var_1 - 0.1;
    }
  }
}

func_BC89(var_0) {
  var_1 = func_7A56(var_0);
  var_2 = randomfloatrange(1.5, 3);
  self.var_4E15 moveto(var_1.origin, var_2, var_2 * 0.9);
  wait(var_2);
  self notify("reached_flyoff_position");
  var_1.inuse = undefined;
  playFX(level._effect["fighter_spaceship_explosion_ground"], var_1.origin);
}

func_7A56(var_0) {
  var_0 = sortbydistance(var_0, self.origin);

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.inuse)) {
      var_2.inuse = 1;
      return var_2;
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