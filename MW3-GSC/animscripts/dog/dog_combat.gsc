/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_combat.gsc
******************************************/

main() {
  self endon("killanimscript");

  if(!isalive(self.enemy)) {
    _id_3B28();
  } else {
    if(isPlayer(self.enemy)) {
      _id_3B1B();
      return;
    }

    _id_3B25();
  }
}

_id_3B02() {
  self endon("pvd_melee_interrupted");

  if(!isDefined(self.meleeingplayer._id_1EC3)) {
    return;
  }
  var_0 = self.meleeingplayer._id_1EC3;

  if(isDefined(var_0._id_3B04)) {
    return;
  }
  var_0._id_3B04 = 1;

  if(maps\_utility::_id_25DA(self.meleeingplayer)) {
    _id_3B05(self.meleeingplayer, self);
    return;
  }

  self.meleeingplayer._id_0ECC = 1;
  self.meleeingplayer setCanDamage(1);
  playFXOnTag(level._effect["dog_bite_blood"], var_0, "tag_torso");
  wait 1;

  if(!isDefined(self) || !isDefined(self.meleeingplayer)) {
    return;
  }
  var_1 = _id_3B57();
  self.meleeingplayer enablehealthshield(0);

  if(!isalive(self.meleeingplayer)) {
    return;
  }
  self.meleeingplayer _id_3B07(self);
  self.meleeingplayer shellshock("default", 5);
  waittillframeend;
  setDvar("ui_deadquote", "");
  thread _id_3B08(self.meleeingplayer, var_1);
}

#using_animtree("dog");

_id_3B05(var_0, var_1) {
  var_0._id_3B06 = 1;
  var_2 = _id_3B56();
  self setflaggedanimknobrestart("meleeanim", %german_shepherd_player_getoff, 1, 0.1, var_2);
  var_0._id_1EC3 notify("pvd_melee_interrupted");
  var_0._id_1EC3 notify("pvd_melee_done");
  var_0._id_1EC3 _id_3B4D(var_0);

  if(!maps\_utility::_id_25DA(var_0)) {
    var_0 _id_3B07(var_1);
  }
}

_id_3B07(var_0) {
  if(maps\_utility::_id_1A5C()) {
    self enabledeathshield(0);
  }
  self disableinvulnerability();

  if(isalive(var_0)) {
    self kill(self.origin, var_0);
  } else {
    self kill(self.origin);
  }
}

_id_3B08(var_0, var_1) {
  if(maps\_utility::_id_0A36()) {
    return;
  }
  wait 1.5;
  thread _id_3B09(var_0);
  var_2 = newclienthudelem(var_0);
  var_2.x = 0;
  var_2.y = 50;

  if(var_1) {
    var_2 setshader("hud_hyena_melee", 96, 96);
  } else {
    var_2 setshader("hud_dog_melee", 96, 96);
  }
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "center";
  var_2.vertalign = "middle";
  var_2.foreground = 1;
  var_2.alpha = 0;
  var_2 fadeovertime(1);
  var_2.alpha = 1;
}

_id_3B09(var_0) {
  var_1 = var_0 maps\_hud_util::createserverclientfontstring("default", 1.75);
  var_1.color = (1, 1, 1);
  var_1 settext(level._id_3B0A);
  var_1.x = 0;
  var_1.y = -30;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.foreground = 1;
  var_1.alpha = 0;
  var_1 fadeovertime(1);
  var_1.alpha = 1;
}

_id_3B0B() {
  self clearanim(%root, 0.1);
  var_0 = % german_shepherd_attack_player_miss_b;

  if(isDefined(self.enemy)) {
    var_1 = anglesToForward((0, self.desiredangle, 0));
    var_2 = vectornormalize(self.enemy.origin - self.origin);
    var_3 = self.enemy.origin - (self.origin + var_1 * 40);

    if(vectordot(var_2, var_1) > 0.707 || vectordot(var_3, var_1) > 0) {
      thread animscripts\dog\dog_stop::_id_3B01("normal");
    } else {
      self._id_3B0C = 1;
      thread _id_3B0D();

      if(var_2[0] * var_1[1] - var_2[1] * var_1[0] > 0) {
        var_0 = % german_shepherd_attack_player_miss_turnr;
      } else {
        var_0 = % german_shepherd_attack_player_miss_turnl;
      }
    }
  }

  self setflaggedanimrestart("miss_anim", var_0, 1, 0, 1);
  var_4 = getanimlength(var_0);
  animscripts\notetracks::_id_0D4F(var_4 - 0.1, "miss_anim");
  self notify("stop tracking");
}

_id_3B0D() {
  self endon("killanimscript");
  wait 0.6;
  self orientmode("face enemy");
}

_id_3B0E(var_0) {
  var_0 endon("death");
  var_0 allowads(0);
  wait 0.75;
  var_0 allowads(1);
}

_id_3B0F() {
  if(isDefined(self.meleeingplayer)) {
    if(isDefined(self.meleeingplayer._id_3B10) && self.meleeingplayer._id_3B10) {
      self.meleeingplayer notify("force_out_of_uav");
    }
    if(self.meleeingplayer islinked()) {
      return undefined;
    }
    if(self.meleeingplayer ismantling()) {
      return undefined;
    }
    if(self.meleeingplayer.laststand && self.meleeingplayer.ignoreme) {
      return undefined;
    }
  }

  if(isDefined(self.enemy)) {
    if(distance2d(self.origin, self.enemy.origin) < 32) {
      return self melee();
    }
  }

  return self melee(anglesToForward(self.angles));
}

_id_3B11(var_0) {
  switch (var_0) {
    case "dog_melee":
      var_1 = _id_3B0F();

      if(isDefined(var_1)) {
        if(isPlayer(var_1)) {
          if(getdvarint("survival_chaos") != 1) {
            var_1 shellshock("dog_bite", 1);
            thread _id_3B0E(var_1);
          }
        }
      } else {
        _id_3B0B();
        return 1;
      }

      break;
    case "stop_tracking":
      self orientmode("face current");
      break;
  }
}

_id_3B12() {
  var_0 = self.meleeingplayer getnormalhealth();

  if(var_0 == 0) {
    return 0;
  }
  if(var_0 < 0.25) {
    self.meleeingplayer setnormalhealth(var_0 + 0.25);
    return 1;
  }

  return 0;
}

_id_3B13() {
  var_0 = self.meleeingplayer getnormalhealth();

  if(var_0 > 0.25) {
    self.meleeingplayer setnormalhealth(var_0 - 0.25);
  } else {
    self.meleeingplayer setnormalhealth(0.01);
  }
}

_id_3B14(var_0) {
  switch (var_0) {
    case "dog_melee":
      var_1 = _id_3B12();
      var_2 = _id_3B0F();

      if(isDefined(var_2) && isPlayer(var_2) && isalive(self.meleeingplayer)) {
        if(var_1) {
          _id_3B13();
        }
        self._id_3B0C = undefined;
        self.meleeingplayer._id_1EC3 = _id_3B45(self);

        if(self.meleeingplayer._id_1EC3 _id_3B4A(self)) {
          self setCanDamage(0);
        }
      } else {
        if(var_1) {
          _id_3B13();
        }
        _id_3B0B();
        return 1;
      }

      break;
    case "dog_early":
      self notify("dog_early_notetrack");
      var_3 = 0.45 + 0.8 * level._id_3AFB[level._id_3AFA];
      var_3 = var_3 * _id_3B56();
      level._id_3AFA++;

      if(level._id_3AFA >= level._id_3AFB.size) {
        level._id_3AFA = 0;
        level._id_3AFB = maps\_utility::_id_0B53(level._id_3AFB);
      }

      self setflaggedanimlimited("meleeanim", %german_shepherd_attack_player, 1, 0.2, var_3);
      self setflaggedanimlimited("meleeanim", %german_shepherd_attack_player_late, 1, 0.2, var_3);
      self.meleeingplayer._id_1EC3 _id_3B52(var_3);
      break;
    case "dog_lunge":
      thread _id_3B16();
      var_3 = _id_3B56();
      self setflaggedanim("meleeanim", %german_shepherd_attack_player, 1, 0.2, var_3);
      self.meleeingplayer._id_1EC3 _id_3B53(var_3);
      break;
    case "dogbite_damage":
      thread _id_3B02();
      break;
    case "stop_tracking":
      self orientmode("face current");
      break;
  }
}

_id_3B15(var_0) {
  switch (var_0) {
    case "dogbite_damage":
      thread _id_3B02();
      break;
  }
}

_id_3B16() {
  wait 0.1;
  thread _id_3B31();
  wait 0.05;
  self._id_3B17 = gettime();
}

_id_3B18() {
  self._id_3B19 = 0;
  self._id_3B1A = 0;
}

_id_3B1B() {
  self.meleeingplayer = self.enemy;

  if(!isDefined(self.meleeingplayer._id_3B1C)) {
    self.meleeingplayer _id_3B18();
  }
  var_0 = 30;
  var_1 = self.meleeattackdist + var_0;

  for(;;) {
    if(!isalive(self.enemy)) {
      break;
    }

    if(!isPlayer(self.enemy)) {
      break;
    }

    if(maps\_utility::_id_1A43(self.enemy)) {
      _id_3B28();
      continue;
    }

    if(isDefined(self.meleeingplayer.syncedmeleetarget) && self.meleeingplayer.syncedmeleetarget != self || isDefined(self.meleeingplayer._id_1EC3) && isDefined(self.meleeingplayer._id_1EC3._id_3B1D)) {
      if(_id_3B2C(var_1)) {
        break;
      } else {
        _id_3B28();
        continue;
      }
    }

    if(_id_3B22()) {
      _id_3B28();
      continue;
    }

    self orientmode("face enemy");
    self animmode("zonly_physics");
    self.safetochangescript = 0;
    _id_3B2D();
    self clearanim(%root, 0.1);
    self clearpitchorient();
    self.meleeingplayer _id_3B24(500);

    if(_id_3B20()) {
      self.meleeingplayer._id_3B19 = gettime();
      self.meleeingplayer._id_3B1A++;
      self setflaggedanimrestart("meleeanim", %german_shepherd_run_attack_b, 1, 0.2, 1);
      animscripts\shared::_id_0C51("meleeanim", ::_id_3B11);
    } else {
      thread _id_3B37();
      self.meleeingplayer._id_3B1E = 1;
      self.meleeingplayer.laststand = 0;
      self.meleeingplayer._id_1A98 = undefined;
      thread _id_3B1F();
      self setflaggedanimrestart("meleeanim", %german_shepherd_attack_player, 1, 0.2, 1);
      self setflaggedanimrestart("meleeanim", %german_shepherd_attack_player_late, 1, 0, 1);
      self setanimlimited(%attack_player, 1, 0, 1);
      self setanimlimited(%attack_player_late, 0.01, 0, 1);
      animscripts\shared::_id_0C51("meleeanim", ::_id_3B14);
      self notify("dog_no_longer_melee_able");
      self setCanDamage(1);
      self unlink();
    }

    self.safetochangescript = 1;
    wait 0.05;

    if(_id_3B2C(var_1)) {
      break;
    }
  }

  self.safetochangescript = 1;
  self animmode("none");
}

_id_3B1F() {
  self waittill("death");
  self.meleeingplayer._id_3B1E = undefined;
}

_id_3B20() {
  if(isDefined(self.meleeingplayer._id_3B21)) {
    return 1;
  }
  if(getdvarint("survival_chaos") == 1) {
    return 1;
  }
  if(maps\_utility::_id_1A43(self.meleeingplayer)) {
    return 1;
  }
  if(isDefined(self.meleeingplayer._id_27A3)) {
    return 1;
  }
  if(gettime() - self.meleeingplayer._id_3B19 > 8000) {
    self.meleeingplayer._id_3B1A = 0;
  }
  return self.meleeingplayer._id_3B1A < self.meleeingplayer._id_20F2._id_2303 && self.meleeingplayer.health > 25;
}

_id_3B22() {
  return isDefined(self.enemy._id_3B23) && gettime() < self.enemy._id_3B23;
}

_id_3B24(var_0) {
  self._id_3B23 = gettime() + var_0;
}

_id_3B25() {
  if(!isalive(self.enemy)) {
    return;
  }
  self.enemy notify("dog_attacks_ai");

  if(isDefined(self.enemy.syncedmeleetarget) || _id_3B22() || !isai(self.enemy)) {
    _id_3B28();
  } else {
    self.enemy _id_3B24(500);
    self.safetochangescript = 0;
    self animmode("zonly_physics");
    self.pushable = 0;
    self clearpitchorient();
    self._id_3B26 = !isDefined(self.enemy._id_0D04) && (isDefined(self.enemy.a._id_0D69) || isDefined(self._id_1035) || randomint(100) > 50);
    var_0 = [];
    var_1[0] = % root;
    var_1[1] = % german_shepherd_attack_ai_01_start_a;
    var_1[2] = % german_shepherd_attack_ai_02_idle_a;

    if(self._id_3B26) {
      var_1[3] = % german_shepherd_attack_ai_03_pushed_a;
      var_1[4] = % german_shepherd_attack_ai_04_middle_a;
      var_1[5] = % german_shepherd_attack_ai_05_kill_a;
      var_2 = 5;
    } else {
      var_1[3] = % german_shepherd_attack_ai_03_shot_a;
      var_2 = 3;
    }

    var_3 = vectortoangles(self.origin - self.enemy.origin);
    var_3 = (0, var_3[1], 0);
    self._id_3B27 = self.enemy;
    self setCanDamage(0);
    self clearanim(var_1[0], 0.1);
    self animrelative("meleeanim", self.enemy.origin, var_3, var_1[1]);
    animscripts\shared::_id_0C51("meleeanim", ::_id_3B2B);
    self setCanDamage(1);
    self animmode("zonly_physics");

    for(var_4 = 1; var_4 < var_2; var_4++) {
      self clearanim(var_1[var_4], 0);

      if(!_id_3B2A()) {
        break;
      }

      if(!self._id_3B26 && var_4 + 1 == var_2) {
        self.health = 1;
      }
      self setflaggedanimrestart("meleeanim", var_1[var_4 + 1], 1, 0, 1);
      animscripts\shared::_id_0C51("meleeanim");
    }

    self unlink();

    if(!self._id_3B26) {
      self kill();
      return;
    }

    self.pushable = 1;
    self.safetochangescript = 1;
    self._id_0D68 = 0;
  }
}

_id_3B28() {
  self orientmode("face enemy");
  self clearanim(%root, 0.1);
  self animmode("zonly_physics");
  var_0 = [];
  var_0[0] = % german_shepherd_attackidle_b;
  var_0[1] = % german_shepherd_attackidle_bark;
  var_0[2] = % german_shepherd_attackidle_growl;
  var_1 = common_scripts\utility::random(var_0);
  thread _id_3B29();
  self setflaggedanimrestart("combat_idle", var_1, 1, 0.2, 1);
  animscripts\shared::_id_0C51("combat_idle");
  self notify("combatIdleEnd");
}

_id_3B29() {
  self endon("killanimscript");
  self endon("combatIdleEnd");

  for(;;) {
    wait 0.1;
    var_0 = getEntArray("player", "classname");

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1];

      if(!isDefined(var_2.syncedmeleetarget) || var_2.syncedmeleetarget == self) {
        continue;
      }
      var_3 = var_2.origin - self.origin;

      if(var_3[2] * var_3[2] > 6400) {
        continue;
      }
      var_3 = (var_3[0], var_3[1], 0);
      var_4 = length(var_3);

      if(var_4 < 1) {
        var_3 = anglesToForward(self.angles);
      }
      if(var_4 < 30) {
        var_3 = var_3 * (3 / var_4);
        self safeteleport(self.origin - var_3, (0, 30, 0));
      }
    }
  }
}

_id_3B2A() {
  return isDefined(self.enemy) && isDefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self;
}

_id_3B2B(var_0) {
  if(var_0 != "ai_attack_start") {
    return 0;
  }
  if(!isDefined(self.enemy)) {
    return 1;
  }
  if(self.enemy != self._id_3B27) {
    return 1;
  }
  if(isDefined(self.enemy.syncedmeleetarget)) {
    return 1;
  }
  self._id_0D68 = 1;
  self.enemy.syncedmeleetarget = self;
  self.enemy animcustom(::_id_3B3C);
}

_id_3B2C(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;
  }
  var_1 = distancesquared(self.origin, self.enemy.origin);
  return var_1 > var_0 * var_0;
}

_id_3B2D() {
  if(_id_3B57()) {
    level._id_3B0A = &"NEW_HYENA_DEATH_DO_NOTHING_ALT";
    level._id_1939 = "@NEW_HYENA_DEATH_DO_NOTHING_ALT";
  } else {
    level._id_3B0A = &"NEW_DOG_DEATH_DO_NOTHING_ALT";
    level._id_1939 = "@NEW_DOG_DEATH_DO_NOTHING_ALT";
  }

  level._id_3B2E = "nothing";
  var_0 = distance(self.origin, self.enemy.origin);

  if(var_0 > self.meleeattackdist) {
    var_1 = self.enemy.origin - self.origin;
    var_2 = (var_0 - self.meleeattackdist) / var_0;
    var_1 = (var_1[0] * var_2, var_1[1] * var_2, var_1[2] * var_2);
    thread _id_3B2F(var_1);
  }
}

_id_3B2F(var_0) {
  self endon("death");
  self endon("killanimscript");
  var_1 = 5;
  var_2 = (var_0[0] / var_1, var_0[1] / var_1, var_0[2] / var_1);

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self teleport(self.origin + var_2);
    wait 0.05;
  }
}

_id_3B30() {
  return isalive(self.meleeingplayer) && self.meleeingplayer meleeButtonPressed();
}

_id_3B31() {
  var_0 = self.meleeingplayer._id_20F2._id_22FE / 1000 / _id_3B56();
  level endon("clearing_dog_hint");

  if(isDefined(self.meleeingplayer._id_3B32)) {
    self.meleeingplayer._id_3B32 maps\_hud_util::destroyelem();
  }
  self.meleeingplayer._id_3B32 = self.meleeingplayer maps\_hud_util::createserverclientfontstring("default", 3);
  self.meleeingplayer._id_3B32.color = (1, 1, 1);
  self.meleeingplayer._id_3B32 settext(&"SCRIPT_PLATFORM_DOG_HINT");
  self.meleeingplayer._id_3B32.x = 0;
  self.meleeingplayer._id_3B32.y = 20;
  self.meleeingplayer._id_3B32.alignx = "center";
  self.meleeingplayer._id_3B32.aligny = "middle";
  self.meleeingplayer._id_3B32.horzalign = "center";
  self.meleeingplayer._id_3B32.vertalign = "middle";
  self.meleeingplayer._id_3B32.foreground = 1;
  self.meleeingplayer._id_3B32.alpha = 1;
  self.meleeingplayer._id_3B32.hidewhendead = 1;
  self.meleeingplayer._id_3B32.sort = -1;
  self.meleeingplayer._id_3B32 endon("death");
  wait(var_0);
  thread _id_3B33();
}

_id_3B33() {
  level notify("clearing_dog_hint");

  if(isDefined(self) && isDefined(self.meleeingplayer._id_3B32)) {
    var_0 = self.meleeingplayer._id_3B32;

    if(isDefined(self.meleeingplayer._id_1EC3._id_3B34) && self.meleeingplayer._id_1EC3._id_3B34) {
      var_1 = 0.5;
      var_0 changefontscaleovertime(var_1);
      var_0.fontscale = var_0.fontscale * 1.5;
      var_0.glowcolor = (0.3, 0.6, 0.3);
      var_0.glowalpha = 1;
      var_0 fadeovertime(var_1);
      var_0.color = (0, 0, 0);
      var_0.alpha = 0;
      wait(var_1);
      var_0 maps\_hud_util::destroyelem();
    } else {
      var_0 maps\_hud_util::destroyelem();
    }
  }
}

_id_3B35() {
  wait 0.7;

  if(isDefined(self)) {
    self unlink();
  }
}

_id_3B36() {
  self endon("death");
  wait 1.5;

  if(isDefined(self)) {
    self setCanDamage(1);
  }
}

_id_3B37() {
  self endon("killanimscript");
  self endon("dog_no_longer_melee_able");
  var_0 = 0;
  var_1 = self.meleeingplayer._id_20F2._id_22FE / _id_3B56();
  self waittill("dog_early_notetrack");

  while(_id_3B30()) {
    wait 0.05;
  }
  var_2 = 0;

  for(;;) {
    if(!var_0) {
      if(_id_3B30()) {
        var_0 = 1;

        if(isDefined(self._id_3B17) && isalive(self.meleeingplayer)) {
          if(gettime() - self._id_3B17 <= var_1) {
            self.meleeingplayer _id_3B3B(var_2);
            self.meleeingplayer._id_1EC3._id_3B34 = 1;
            self notify("melee_stop");
            self setflaggedanimknobrestart("dog_death_anim", %german_shepherd_player_neck_snap, 1, 0.2, 1);
            thread _id_3B36();
            self setCanDamage(0);
            self waittillmatch("dog_death_anim", "dog_death");
            thread common_scripts\utility::play_sound_in_space("dog_neckbreak", self getEye());
            self setCanDamage(1);
            self.a._id_0D55 = 1;
            self._id_3B38 = 1;
            var_3 = self.meleeingplayer.origin - self.origin;
            var_3 = (var_3[0], var_3[1], 0);
            maps\_utility::_id_1E05(self.origin, "melee", 50);
            thread _id_3B35();
            self kill(self getEye() - var_3, self.meleeingplayer);
            self notify("killanimscript");
          } else {
            self.meleeingplayer _id_3B3B(var_2);
            self.meleeingplayer._id_1EC3 _id_3B55();
            self setanimlimited(%attack_player, 0.01, 0.2, 1);
            self setanimlimited(%attack_player_late, 1, 0.2, 1);

            if(_id_3B57()) {
              level._id_3B0A = &"NEW_HYENA_DEATH_TOO_LATE_ALT";
              level._id_1939 = "@NEW_HYENA_DEATH_TOO_LATE_ALT";
            } else {
              level._id_3B0A = &"NEW_DOG_DEATH_TOO_LATE_ALT";
              level._id_1939 = "@NEW_DOG_DEATH_TOO_LATE_ALT";
            }

            level._id_3B2E = "late";
          }

          return;
        }

        var_2 = 1;

        if(self.meleeingplayer _id_3B39()) {
          if(_id_3B57()) {
            level._id_3B0A = &"NEW_HYENA_DEATH_TOO_SOON_ALT";
            level._id_1939 = "@NEW_HYENA_DEATH_TOO_SOON_ALT";
          } else {
            level._id_3B0A = &"NEW_DOG_DEATH_TOO_SOON_ALT";
            level._id_1939 = "@NEW_DOG_DEATH_TOO_SOON_ALT";
          }

          level._id_3B2E = "soon";
          var_4 = _id_3B56();
          self setflaggedanimknobrestart("meleeanim", %german_shepherd_player_neck_miss, 1, 0.2, var_4);
          self.meleeingplayer._id_1EC3 _id_3B54(var_4);
          return;
        }
      }
    } else if(!_id_3B30()) {
      var_0 = 0;
    }
    wait 0.05;
  }
}

_id_3B39() {
  if(self.gameskill == 3) {
    return 1;
  }
  if(isDefined(self._id_3B3A) && self._id_3B3A) {
    return 1;
  }
  return 0;
}

_id_3B3B(var_0) {
  if(!var_0) {
    return;
  }
  if(level.gameskill > 1 && !isDefined(self._id_3B3A)) {
    self._id_3B3A = 1;
  }
}

#using_animtree("generic_human");

_id_3B3C() {
  self endon("killanimscript");
  self endon("death");
  self endon("end_melee_struggle");
  self endon("end_melee_all");

  if(!isDefined(self.syncedmeleetarget)) {
    return;
  }
  self orientmode("face point", self.syncedmeleetarget.origin, 1);
  self animmode("gravity");
  self.a._id_0D26 = "stand";
  self.a._id_0D19 = "none";

  if(animscripts\utility::_id_0C95()) {
    animscripts\shared::_id_0C9B(self.primaryweapon, "right");
  }
  var_0 = [];
  var_0[0] = % root;
  var_0[1] = % ai_attacked_german_shepherd_01_start_a;
  var_0[2] = % ai_attacked_german_shepherd_02_idle_a;

  if(self.syncedmeleetarget._id_3B26) {
    var_0[3] = % ai_attacked_german_shepherd_03_push_a;
    var_0[4] = % ai_attacked_german_shepherd_04_middle_a;
    var_0[5] = % ai_attacked_german_shepherd_05_death_a;
    var_1 = 5;
  } else {
    var_0[3] = % ai_attacked_german_shepherd_03_shoot_a;
    var_1 = 3;
  }

  self._id_3B3D = 0;
  thread _id_3B3E();
  self clearanim(var_0[0], 0.1);
  self setflaggedanimrestart("aianim", var_0[1], 1, 0.1, 1);
  wait 0.15;
  self.syncedmeleetarget linkto(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  self waittillmatch("aianim", "end");
  self._id_3B3D = 1;

  while(self._id_3B3D < var_1) {
    self clearanim(var_0[self._id_3B3D], 0);
    self._id_3B3D++;

    if(var_1 == 3 && self._id_3B3D == 3) {
      _id_3B24(getanimlength(var_0[self._id_3B3D]) * 1000 - 1000);
    }
    self setflaggedanimrestart("aianim", var_0[self._id_3B3D], 1, 0, 1);
    animscripts\shared::_id_0C51("aianim");

    if(!isDefined(self.syncedmeleetarget) || !isalive(self.syncedmeleetarget)) {
      if(self._id_3B3D == 3 && var_1 == 5) {
        var_0[4] = % ai_attacked_german_shepherd_04_getup_a;
        var_1 = 4;
      }
    }

    if(self._id_3B3D == 5) {
      if(!isDefined(self._id_0D04)) {
        self.a._id_0D55 = 1;
        animscripts\shared::_id_0D73();
        self kill();
      }
    }
  }

  _id_3B3F();
}

_id_3B3E() {
  self endon("killanimscript");
  self endon("death");
  self endon("end_melee_all");
  var_0 = [];
  var_0[1] = % ai_attacked_german_shepherd_02_getup_a;
  var_0[2] = % ai_attacked_german_shepherd_02_getup_a;

  if(self.syncedmeleetarget._id_3B26) {
    var_0[4] = % ai_attacked_german_shepherd_04_getup_a;
  }
  for(;;) {
    if(!isDefined(self.syncedmeleetarget) || !isalive(self.syncedmeleetarget)) {
      break;
    }

    wait 0.1;
  }

  if(self._id_3B3D > 0) {
    if(!isDefined(var_0[self._id_3B3D])) {
      return;
    }
    self clearanim(%melee_dog, 0.1);
    self setflaggedanimrestart("getupanim", var_0[self._id_3B3D], 1, 0.1, 1);
    animscripts\shared::_id_0C51("getupanim");
  }

  _id_3B3F();
}

_id_3B3F() {
  self orientmode("face default");
  self.syncedmeleetarget = undefined;
  self._id_3B3D = undefined;
  self.allowpain = 1;
  _id_3B24(1000);
  self notify("end_melee_all");
}

#using_animtree("player_3rd_person");

_id_3B40(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1[[var_0._id_1C9B]]();
  var_1 useanimtree(#animtree);
  return var_1;
}

_id_3B41(var_0) {
  self endon("death");
  var_1 = getanimlength(%player_3rd_dog_knockdown);
  self setanim(%player_3rd_dog_knockdown, 1, 0, var_0);
}

_id_3B42() {
  self setanimknobrestart(%player_3rd_dog_knockdown_neck_snap, 1, 0, 1);
}

_id_3B43() {
  self setanimknobrestart(%player_3rd_dog_knockdown_saved, 1, 0, 1);
}

_id_3B44() {
  self setanimknobrestart(%player_3rd_dog_knockdown_laststand, 1, 0, 1);
}

#using_animtree("player");

_id_3B45(var_0) {
  var_1 = spawn("script_model", var_0.meleeingplayer.origin);
  var_1.angles = var_0.meleeingplayer.angles;
  var_1 setModel(level._id_1F5D);
  var_1 useanimtree(#animtree);
  var_1 hide();
  return var_1;
}

_id_3B46(var_0) {
  switch (var_0) {
    case "allow_player_save":
      if(isDefined(self._id_3B47)) {
        wait 1;
        self._id_3B47 setCanDamage(1);
      }

      break;
    case "blood_pool":
      if(!isDefined(self._id_3B47.meleeingplayer)) {
        break;
      }

      if(maps\_utility::_id_25DA(self._id_3B47.meleeingplayer)) {
        break;
      }

      var_1 = self gettagorigin("tag_torso");
      var_2 = self gettagangles("tag_torso");
      var_3 = anglesToForward(var_2);
      var_4 = anglestoup(var_2);
      var_5 = anglestoright(var_2);
      var_1 = var_1 + var_3 * -8.5 + var_4 * 5 + var_5 * 0;
      playFX(level._effect["deathfx_bloodpool"], var_1, var_3, var_4);
      break;
  }
}

_id_3B48(var_0) {
  self endon("pvd_melee_interrupted");
  var_1 = var_0.meleeingplayer;
  self._id_3B47 = var_0;
  thread _id_3B49(var_1);
  self setflaggedanimrestart("viewanim", %player_view_dog_knockdown);
  self setflaggedanimrestart("viewanim", %player_view_dog_knockdown_late);
  self setanimlimited(%knockdown, 1, 0, 1);
  self setanimlimited(%knockdown_late, 0.01, 0, 1);
  animscripts\shared::_id_0C51("viewanim", ::_id_3B46);
  self dontinterpolate();
  self._id_3B47 = undefined;
  _id_3B4D(var_1);
  self notify("pvd_melee_done");
}

_id_3B49(var_0) {
  self endon("pvd_melee_done");
  self._id_3B47 common_scripts\utility::waittill_any("death", "pain", "melee_stop");

  if(!isDefined(var_0._id_0ECC) && isalive(var_0)) {
    self notify("pvd_melee_interrupted");
    self._id_3B47 notify("pvd_melee_interrupted");
    _id_3B4D(var_0);
  }
}

_id_3B4A(var_0) {
  if(isDefined(self._id_3B1D)) {
    return 0;
  }
  var_1 = var_0.meleeingplayer;

  if(isDefined(var_1) && isDefined(var_1._id_1A96)) {
    var_1 notify("sentry_placement_canceled");
  }
  var_1 notify("dog_attacks_player");
  self._id_3B1D = 1;

  if(isalive(var_1)) {
    var_1 hidehud();
  }
  var_1 setstance("stand");
  var_1.syncedmeleetarget = var_0;
  var_1._id_1EC3 _id_3B51(var_1);
  var_2 = var_0.origin - var_1.origin;
  self.angles = vectortoangles(var_2);
  self.angles = (0, self.angles[1], 0);
  self._id_103B = self.angles;
  var_3 = var_1.origin;
  var_4 = var_1 getdroptofloorposition(var_1.origin);

  if(isDefined(var_4)) {
    self.origin = var_4;
  } else {
    self.origin = var_1.origin;
  }
  thread _id_3B48(var_0);
  self dontinterpolate();
  var_1 playerlinktoabsolute(self, "tag_player");
  var_0 linkto(self, "tag_sync", (0, 0, 0), (0, 0, 0));
  var_5 = self gettagangles("tag_sync");
  var_0 orientmode("face angle", var_5[1]);
  var_0 orientmode("face default");
  var_1 allowstand(1);
  var_1 allowlean(0);
  var_1 allowcrouch(0);
  var_1 allowprone(0);
  var_1 freezecontrols(1);
  var_1 setCanDamage(0);
  return 1;
}

_id_3B4B(var_0) {
  wait 0.5;
  var_0 playSound("saved_from_dog");
}

_id_3B4C() {
  self endon("death");
  self showviewmodel();
  self enableweapons();
}

_id_3B4D(var_0) {
  var_0 showhud();

  if(isalive(var_0)) {
    self clearanim(%player_view_dog_knockdown, 0.1);

    if(isDefined(self._id_3B34)) {
      self setflaggedanimrestart("viewanim", %player_view_dog_knockdown_neck_snap, 1, 0.2, 1);

      if(isDefined(self._id_3B4E)) {
        self._id_3B4E _id_3B42();
      }
    } else if(isDefined(var_0._id_3B06)) {
      self setflaggedanimknobrestart("viewanim", %player_view_dog_knockdown_laststand, 1, 0.1, 1);

      if(isDefined(self._id_3B4E)) {
        self._id_3B4E _id_3B44();
      }
    } else {
      thread _id_3B4B(var_0);
      self setflaggedanimrestart("viewanim", %player_view_dog_knockdown_saved);

      if(isDefined(self._id_3B4E)) {
        self._id_3B4E _id_3B43();
      }
    }

    if(!isDefined(var_0._id_3B06)) {
      var_0 maps\_utility::delaythread(2.5, ::_id_3B4C);
      animscripts\shared::_id_0C51("viewanim");
      var_0 notify("player_saved_from_dog");
    } else {
      animscripts\shared::_id_0C51("viewanim");
      var_0 notify("deathshield", 1000000, self._id_3B47);
      var_0 showviewmodel();
    }

    _id_3B4F(var_0);
  } else {
    setsaveddvar("compass", 0);
  }
  var_0.syncedmeleetarget = undefined;
  var_0._id_3B06 = undefined;
  _id_3B50(var_0);
}

_id_3B4F(var_0) {
  var_0 show();
  var_0 unlink();
  var_0 setorigin(self.origin);
  var_0 setplayerangles(self._id_103B);
  var_0 setCanDamage(1);
  var_1 = var_0._id_1EC3;

  if(isDefined(var_1)) {
    if(isDefined(var_1._id_3B4E)) {
      var_1._id_3B4E delete();
    }
    var_1 delete();
    var_0._id_1EC3 = undefined;
  }
}

_id_3B50(var_0) {
  var_0 allowlean(1);
  var_0 allowcrouch(1);
  var_0 allowprone(1);
  var_0 freezecontrols(0);
  var_0._id_3B1E = undefined;
}

_id_3B51(var_0) {
  self showonclient(var_0);

  if(maps\_utility::_id_12C1()) {
    var_1 = _id_3B40(var_0);
    var_1 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_1 thread _id_3B41(1);
    self._id_3B4E = var_1;

    if(level.player == var_0 && isDefined(level._id_1337)) {
      var_0 hideonclient(level._id_1337);
      var_1 hideonclient(level.player);
    } else {
      var_0 hideonclient(level.player);
      var_1 hideonclient(level._id_1337);
    }
  }

  var_0 hideviewmodel();
  var_0 disableweapons();
}

_id_3B52(var_0) {
  self setflaggedanimlimited("viewanim", %player_view_dog_knockdown, 1, 0.2, var_0);
  self setflaggedanimlimited("viewanim", %player_view_dog_knockdown_late, 1, 0.2, var_0);

  if(isDefined(self._id_3B4E)) {
    self._id_3B4E _id_3B41(var_0);
  }
}

_id_3B53(var_0) {
  self setflaggedanimlimited("viewanim", %player_view_dog_knockdown, 1, 0.2, var_0);
  self setflaggedanimlimited("viewanim", %player_view_dog_knockdown_late, 1, 0.2, var_0);

  if(isDefined(self._id_3B4E)) {
    self._id_3B4E _id_3B41(var_0);
  }
}

_id_3B54(var_0) {
  self setflaggedanimknobrestart("viewanim", %player_view_dog_knockdown_neck_miss, 1, 0.2, var_0);
}

_id_3B55() {
  self setanimlimited(%knockdown, 0.01, 0.2, 1);
  self setanimlimited(%knockdown_late, 1, 0.2, 1);
}

_id_3B56() {
  return 1;
}

_id_3B57() {
  if(issubstr(self.classname, "hyena")) {
    return 1;
  }
  return 0;
}