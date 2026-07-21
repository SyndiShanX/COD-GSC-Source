/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\juggernaut\juggernaut.gsc
***********************************************/

juggernaut(var_0) {
  self endon("asm_terminated");
  self endon("death");

  if(isDefined(self.subclass) && self.subclass == "juggernaut" || isDefined(self.agent_type) && self.agent_type == "juggernaut") {
    childthread juggernaut_pain();
    childthread juggernaut_damage();
    var_1 = 0;

    if(!var_1 && scripts\common\utility::iscp())
      childthread init_juggernaut_damage_states();
  }
}

initanimspeedthresholds_juggernaut(var_0) {
  if(hasanimspeedthresholdstring(var_0)) {
    return;
  }
  anim.juggernautspeedthreholdsinitialized = 1;
  animspeedthresholdsexist(var_0, "walk", 40);
  animspeedthresholdsexist(var_0, "jog", 113);
  animspeedthresholdsexist(var_0, "run", 170);
}

juggernaut_isspecialweapon() {
  return self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_EXPLOSIVE" || self.damagemod == "MOD_GRENADE_SPLASH" || self.damagemod == "MOD_PROJECTILE_SPLASH" || (self.damageweapon.classname == "sniper" || self.damageweapon.classname == "pistol" && self.damageweapon.basename != "iw8_pi_decho" && self.damagemod != "MOD_MELEE");
}

juggernaut_watch_pain() {
  for(;;) {
    self waittill("pain");
    self.juggernautpaintime = gettime();
  }
}

juggernaut_pain() {
  childthread juggernaut_watch_pain();

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(self.health > 0 && var_0 >= self.minpaindamage) {
      if(soundexists("generic_pain_enemy_1"))
        self playSound("generic_pain_enemy_1");

      self asmevalpaintransition(self.asmname);
      var_10 = self.minpaindamage;
      self.minpaindamage = var_10 * 3;
      wait 5;
      self.minpaindamage = var_10;
    }
  }
}

juggernaut_damage() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(juggernaut_isspecialweapon()) {
      continue;
    }
    if(self.damageweapon.basename == "iw8_pi_decho") {
      if(var_7 == "j_head" || var_7 == "j_neck" || var_7 == "j_helmet")
        var_10 = 70;
      else
        var_10 = 40;
    } else
      var_10 = 40;

    if(var_0 < var_10)
      var_10 = abs(var_0 - 5);

    self.health = self.health + int(var_10);

    if(istrue(self.damage_parts_enabled))
      apply_juggernaut_part_damage(self.damagelocation, var_0);
  }
}

init_juggernaut_damage_states() {
  scripts\engine\utility::flag_wait("scriptables_ready");

  if(!scripts\engine\utility::is_equal(self.model, "body_opforce_juggernaut_basebody")) {
    return;
  }
  self.damage_parts_enabled = 1;
  self setscriptablepartstate("base", "pristine");
  create_juggernaut_damagedata("left_arm", 100, ["left_arm_upper", "left_arm_lower", "left_hand"]);
  create_juggernaut_damagedata("right_arm", 100, ["right_arm_upper", "right_arm_lower", "right_hand"]);
}

create_juggernaut_damagedata(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.health = var_1;
  var_3.is_part_swapped = 0;

  if(!isDefined(self.damagedata))
    self.damagedata = [];

  self.damagedata[var_0] = var_3;

  if(!isDefined(self.damagedatalookup))
    self.damagedatalookup = [];

  foreach(var_5 in var_2)
  self.damagedatalookup[var_5] = var_0;
}

apply_juggernaut_part_damage(var_0, var_1) {
  if(!isDefined(self.damagedatalookup[var_0])) {
    return;
  }
  var_2 = self.damagedatalookup[var_0];
  var_3 = self.damagedata[var_2];
  var_3.health = var_3.health - var_1;

  if(var_3.health <= 0 && !istrue(var_3.is_part_swapped)) {
    self setscriptablepartstate(var_2, "dmg", 1);
    var_3.is_part_swapped = 1;
  }
}

enable_casual_killer() {
  if(isDefined(self.combatmode))
    self.ck_combatmode = self.combatmode;

  self.combatmode = "no_cover";
  self allowedstances("stand");
  self.cautiousnavigation = 1;
  self.dontmeleeme = 1;
  self.dontmelee = 1;
  self.ck_grenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  self.ck_aggressivemode = istrue(self.aggressivemode);
  self.aggressivemode = 1;
  self.ignoresuppression = 1;
  scripts\engine\utility::set_movement_speed(50);
  self.turnrate = 0.1;
  self.allowstrafe = 0;
  self.disablepistol = 1;
  self.dontsyncmelee = 1;
  self.disablebulletwhizbyreaction = 1;
  self.neversprintforvariation = 1;
  self.disablerunngun = 1;
  self.casualkiller = 1;
  self.ignoreburstdelay = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self.pathenemyfightdist = 0;

  if(isDefined(self.a))
    self.a.disablelongdeath = 1;

  var_0 = weaponclass(self.weapon);
  initanimspeedthresholds_juggernaut("juggernaut");
  scripts\asm\shared\utility::setbasearchetype("juggernaut");
  var_1 = "casual_killer";

  if(var_0 == "mg")
    var_1 = "casual_killer_lmg";

  scripts\asm\shared\utility::setoverridearchetype("casual_killer", var_1, 1);
  thread casual_killer_targeting();

  if(var_0 == "mg" || var_0 == "rifle" || var_0 == "smg")
    thread casual_killer_sweep();

  if(var_0 == "rifle" || var_0 == "smg")
    self.shootstyleoverride = "full";

  thread casual_killer_enemy_reaction();
}

disable_casual_killer() {
  if(!istrue(self.leavecasualkiller))
    thread disable_casual_killer_internal();
}

disable_casual_killer_internal() {
  if(!isDefined(level.casualkillernewenemyreaction) || gettime() > level.casualkillernewenemyreaction) {
    self.newenemyreactiontime = gettime() + 3000;
    self.newenemyreaction = 1;
    self.forcenewenemyreaction = 1;
  }

  self.leavecasualkiller = 1;
  self clearentitytarget();
  self.favoriteenemy = undefined;
  self.gunposeoverride = undefined;

  if(isDefined(self.pathgoalpos))
    self setbtgoalpos(2, self getposonpath(64));

  scripts\engine\utility::waittill_any("leaveCasualKiller", "death");

  if(!isalive(self) || !isDefined(self)) {
    return;
  }
  self.cautiousnavigation = 0;
  self.dontmeleeme = 0;
  self.grenadeammo = self.ck_grenadeammo;

  if(istrue(self.ck_aggressivemode))
    self.aggressivemode = 1;

  scripts\common\utility::lookatentity(undefined);
  scripts\common\utility::lookatpos(undefined);
  self.ignoresuppression = 0;
  self.dontmelee = 0;
  self.turnrate = 0.3;
  scripts\common\utility::clear_movement_speed();
  self.disablepistol = 0;
  self.allowstrafe = 1;
  self.dontsyncmelee = undefined;
  self.disablebulletwhizbyreaction = undefined;
  self.neversprintforvariation = undefined;
  self.disablerunngun = 0;
  self.casualkiller = undefined;
  self.casualkillershootpos = undefined;
  self.pathenemyfightdist = 192;
  self.dontevershoot = 0;
  self.shootstyleoverride = undefined;
  self.ignoreburstdelay = undefined;
  self.dontgiveuponsuppression = undefined;
  self.forcesuppressai = undefined;
  self.gunposeoverride = undefined;
  self.aimyawspeed = 0;
  self clearbtgoal(2);

  if(isDefined(self.ck_target))
    self.ck_target delete();

  if(isDefined(self.a))
    self.a.disablelongdeath = 0;

  self allowedstances("stand", "crouch", "prone");

  if(isDefined(self.ck_combatmode)) {
    self.combatmode = self.ck_combatmode;
    self.ck_combatmode = undefined;
  } else
    self.combatmode = "cover";
}

casual_killer_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\engine\utility::is_equal(var_1, level.player))
    self notify("ck_player_attacked_me");
}

casual_killer_enemy_reaction() {
  self endon("leaveCasualKiller");
  self endon("death");

  if(!isDefined(self.damage_functions))
    self.damage_functions = [];

  self.damage_functions[self.damage_functions.size] = ::casual_killer_damage_func;
  self waittill("ck_player_attacked_me");
  self.favoriteenemy = undefined;
  self clearentitytarget();
  self setthreatbiasgroup("axis");
}

casual_killer_targeting() {
  self endon("leaveCasualKiller");
  self endon("death");
  wait 1;
  self.ck_target = spawn("script_origin", self.origin);
  thread scripts\engine\utility::delete_on_death(self.ck_target);
  var_0 = undefined;
  var_1 = 0;
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    waitframe();

    if(!isDefined(self) || !isalive(self) || istrue(self.leavecasualkiller)) {
      return;
    }
    self.gunposeoverride = "disable";
    var_4 = anglesToForward(self.angles);
    var_5 = scripts\asm\shared\utility::getshootfrompos();

    if(var_1) {
      if(!isalive(var_0)) {
        var_2 = gettime();
        self setentitytarget(self.ck_target);
        self forcethreatupdate();
        var_1 = 0;
        var_3 = undefined;
      } else
        self.ck_target.origin = var_0.origin;
    }

    var_6 = int(gettime() / 50);

    if(self getentitynumber() % 4 != var_6 % 4) {
      if(isDefined(var_2) && var_2 + 3000 > gettime()) {
        var_7 = self.ck_target.origin - self.origin;

        if(length(var_7) > 100) {
          var_7 = vectorNormalize(var_7);
          var_8 = abs(angleclamp180(acos(clamp(vectordot(var_4, var_7), -1.0, 1.0))));

          if(var_8 > 30 && gettime() < var_2 + 1500) {
            continue;
          }
          if(var_8 < 90)
            continue;
        }
      }

      var_2 = undefined;

      if(!isDefined(var_3) || gettime() > var_3 + 3000) {
        self clearentitytarget();
        self forcethreatupdate();

        if(isalive(self.enemy)) {
          if(var_1 && self.enemy == var_0) {
            var_9 = self.enemy;
            var_10 = self.enemy.origin - self.origin;
            var_10 = vectorNormalize(var_10);
            var_11 = clamp(vectordot(var_4, var_10), -1.0, 1.0);
            var_12 = abs(angleclamp180(acos(var_11)));

            if(var_12 > 70) {
              var_13 = self getsecondarytargets();

              if(isDefined(var_13)) {
                foreach(var_15 in var_13) {
                  var_7 = var_15.origin - self.origin;
                  var_7 = vectorNormalize(var_7);
                  var_8 = abs(angleclamp180(acos(clamp(vectordot(var_4, var_7), -1.0, 1.0))));

                  if(var_8 < var_12) {
                    var_12 = var_8;
                    var_9 = var_15;
                  }
                }

                if(var_9 != self.enemy) {
                  if(issentient(var_9)) {
                    self.favoriteenemy = var_9;
                    self forcethreatupdate();
                    self.favoriteenemy = undefined;
                    var_3 = gettime();
                  }
                }
              }
            }
          }

          var_1 = isalive(self.enemy);

          if(var_1)
            var_0 = self.enemy;
          else
            var_0 = undefined;

          continue;
        } else {
          self setentitytarget(self.ck_target);
          self forcethreatupdate();

          if(isDefined(var_2) && var_2 + 7000 > gettime()) {
            if(vectordot(var_4, self.ck_target.origin - var_5) > 0)
              continue;
          }

          self.ck_target.origin = self.origin + (0, 0, 40) + var_4 * 400;
        }
      }
    }
  }
}

casual_killer_sweep() {
  self endon("leaveCasualKiller");
  self endon("death");
  var_0 = 100;
  var_1 = 1000;
  var_2 = 20;
  var_3 = -1;
  var_4 = [40, 50, 60];
  var_5 = [20, 25, 30];
  var_6 = 0;
  var_7 = 0;
  var_8 = scripts\engine\utility::random(var_4);
  var_9 = scripts\engine\utility::random(var_5);
  var_10 = 0;
  var_11 = undefined;
  var_12 = undefined;

  foreach(var_14 in var_5) {
    if(var_14 > var_6)
      var_6 = var_14;
  }

  while(isalive(self) && isDefined(self)) {
    waitframe();
    self.leftaimlimit = 90;
    self.rightaimlimit = -90;
    self.aimyawspeed = 180;
    var_16 = anglesToForward(self.angles);
    var_17 = scripts\asm\shared\utility::getshootfrompos();

    if(isDefined(self.enemy)) {
      if(!isDefined(self.pathgoalpos) || self.lookaheaddist > self aigetdesiredspeed())
        var_11 = self.enemy getshootatpos();
    }

    var_18 = scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "aim") || scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "notetrackAim");

    if(var_18)
      var_18 = isDefined(var_11);

    var_19 = scripts\asm\asm::asm_getcurrentstate(self.asmname);

    if(var_19 == "exposed_arrival" || var_19 == "exposed_reload")
      var_18 = 0;

    if(var_18) {
      var_20 = self getposonpath(self aigetdesiredspeed());
      var_21 = var_11 - var_20;
      var_21 = (var_21[0], var_21[1], 0);
      var_22 = vectorNormalize(var_21);
      var_23 = self.leftaimlimit;

      if(!istrue(var_12))
        var_23 = max(0, self.leftaimlimit - 20);

      var_24 = abs(angleclamp180(acos(clamp(vectordot(var_22, var_16), -1.0, 1.0))));

      if(var_24 >= var_23) {
        var_11 = undefined;
        var_10 = 0;
        var_18 = 0;
      }
    }

    if(!istrue(var_18)) {
      scripts\common\utility::lookatentity(undefined);
      scripts\common\utility::lookatpos(var_17 + var_16 * 200);
      self.casualkillershootpos = var_17 + var_16 * 200;
      var_2 = 20 * var_3;
      var_3 = var_3 * -1;
      var_10 = 0;
      self.dontevershoot = 1;
      var_12 = 0;
      continue;
    }

    var_12 = 1;
    self.dontevershoot = 0;

    if(isDefined(var_11))
      scripts\common\utility::lookatpos(var_11);
    else {
      scripts\common\utility::lookatentity(undefined);
      scripts\common\utility::lookatpos(undefined);
    }

    var_21 = var_11 - var_17;
    var_25 = length(var_21);
    var_22 = vectorNormalize(var_21);
    var_24 = abs(angleclamp180(acos(clamp(vectordot(var_16, var_22), -1.0, 1.0))));
    var_26 = axistoangles(var_22, anglestoright(self.angles), anglestoup(self.angles));
    var_27 = var_26[1];

    if(istrue(self.leavecasualkiller)) {
      if(var_2 > 0) {
        var_2 = var_2 - min(var_2, var_8 * level.framedurationseconds);
        var_3 = -1;
      } else if(var_2 < 0) {
        var_2 = var_2 + min(var_2 * -1, var_8 * level.framedurationseconds);
        var_3 = 1;
      }
    } else if(var_24 + var_6 < abs(self.leftaimlimit) && var_24 + var_6 < abs(self.rightaimlimit) && var_25 > var_0 && (var_25 < var_1 || isDefined(self.enemy) && self.enemy == level.player)) {
      if(gettime() > var_7) {
        var_28 = level.framedurationseconds * var_8 * var_3;
        var_2 = var_2 + var_28;

        if(scripts\engine\utility::sign(var_2) == scripts\engine\utility::sign(var_3) && abs(var_2) > var_9) {
          var_3 = var_3 * -1;
          var_8 = scripts\engine\utility::random(var_4);
          var_9 = scripts\engine\utility::random(var_5);
          var_7 = gettime() + 350;
        }
      }

      var_27 = var_27 + var_2;
    }

    var_29 = axistoangles(var_22, anglestoright(self.angles), anglestoup(self.angles));
    var_29 = (var_29[0], var_27, var_29[2]);
    var_22 = anglesToForward(var_29);
    self.casualkillershootpos = var_22 * var_25 + var_17;

    if(istrue(self.leavecasualkiller) && var_2 == 0)
      return;
  }
}