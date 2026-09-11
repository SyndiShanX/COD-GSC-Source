/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\juggernaut\juggernaut.gsc
*************************************************/

function juggernaut(var0) {
  self endon("asm_terminated");
  self endon("death");

  if(isDefined(self.subclass) && self.subclass == "juggernaut" || isDefined(self.agent_type) && self.agent_type == "juggernaut") {
    GscBinSkip4(0x35);
  }
}

function initanimspeedthresholds_juggernaut(var0) {
  if(hasanimspeedthresholdstring(var0)) {
    return;
  }

  anim.juggernautspeedthreholdsinitialized = 1;
  animspeedthresholdsexist(var0, "walk", 40);
  animspeedthresholdsexist(var0, "jog", 113);
  animspeedthresholdsexist(var0, "run", 170);
}

function juggernaut_isspecialweapon() {
  return self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_EXPLOSIVE" || self.damagemod == "MOD_GRENADE_SPLASH" || self.damagemod == "MOD_PROJECTILE_SPLASH" || self.damageweapon.classname == "sniper" || self.damageweapon.classname == "pistol" && self.damageweapon.basename != "iw8_pi_decho" && self.damagemod != "MOD_MELEE";
}

function juggernaut_watch_pain() {
  for(;;) {
    self waittill("pain");
    self.juggernautpaintime = gettime();
  }
}

function juggernaut_pain() {
  GscBinSkip4(0x35);
}

function juggernaut_damage() {
  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(juggernaut_isspecialweapon()) {
      continue;
    }

    if(self.damageweapon.basename == "iw8_pi_decho") {
      if(var7 == "j_head" || var7 == "j_neck" || var7 == "j_helmet") {
        var10 = 70;
      } else {
        var10 = 40;
      }
    } else {
      var10 = 40;
    }

    if(var0 < var10) {
      var10 = abs(var0 - 5);
    }

    self.health += int(var10);

    if(istrue(self.damage_parts_enabled)) {
      apply_juggernaut_part_damage(self.damagelocation, var0);
    }
  }
}

function init_juggernaut_damage_states() {
  scripts\engine\utility::flag_wait("scriptables_ready");

  if(!scripts\engine\utility::is_equal(self.model, "body_opforce_juggernaut_basebody")) {
    return;
  }

  self.damage_parts_enabled = 1;
  self setscriptablepartstate("base", "pristine");
  create_juggernaut_damagedata("left_arm", 100, ["left_arm_upper", "left_arm_lower", "left_hand"]);
  create_juggernaut_damagedata("right_arm", 100, ["right_arm_upper", "right_arm_lower", "right_hand"]);
}

function create_juggernaut_damagedata(var0, var1, var2) {
  var3 = spawnStruct();
  var3.health = var1;
  var3.is_part_swapped = 0;

  if(!isDefined(self.damagedata)) {
    self.damagedata = [];
  }

  self.damagedata[var0] = var3;

  if(!isDefined(self.damagedatalookup)) {
    self.damagedatalookup = [];
  }

  foreach(var5 in var2) {
    self.damagedatalookup[var5] = var0;
  }
}

function apply_juggernaut_part_damage(var0, var1) {
  if(!isDefined(self.damagedatalookup[var0])) {
    return;
  }

  var2 = self.damagedatalookup[var0];
  var3 = self.damagedata[var2];
  var3.health -= var1;

  if(var3.health <= 0 && !istrue(var3.is_part_swapped)) {
    self setscriptablepartstate(var2, "dmg", 1);
    var3.is_part_swapped = 1;
    return;
  }
}

function enable_casual_killer() {
  if(isDefined(self.combatmode)) {
    self.ck_combatmode = self.combatmode;
  }

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

  if(isDefined(self.a)) {
    self.a.disablelongdeath = 1;
  }

  var0 = weaponclass(self.weapon);
  initanimspeedthresholds_juggernaut("juggernaut");
  scripts\asm\shared\utility::setbasearchetype("juggernaut");
  var1 = "casual_killer";

  if(var0 == "mg") {
    var1 = "casual_killer_lmg";
  }

  scripts\asm\shared\utility::setoverridearchetype("casual_killer", var1, 1);
  thread casual_killer_targeting();

  if(var0 == "mg" || var0 == "rifle" || var0 == "smg") {
    thread casual_killer_sweep();
  }

  if(var0 == "rifle" || var0 == "smg") {
    self.shootstyleoverride = "full";
  }

  thread casual_killer_enemy_reaction();
}

function disable_casual_killer() {
  if(!istrue(self.leavecasualkiller)) {
    thread disable_casual_killer_internal();
    return;
  }
}

function disable_casual_killer_internal() {
  if(!isDefined(level.casualkillernewenemyreaction) || gettime() > level.casualkillernewenemyreaction) {
    self.newenemyreactiontime = gettime() + 3000;
    self.newenemyreaction = 1;
    self.forcenewenemyreaction = 1;
  }

  self.leavecasualkiller = 1;
  self clearentitytarget();
  self.favoriteenemy = undefined;
  self.gunposeoverride = undefined;

  if(isDefined(self.pathgoalpos)) {
    self setbtgoalpos(2, self getposonpath(64));
  }

  scripts\engine\utility::waittill_any("leaveCasualKiller", "death");

  if(!isalive(self) || !isDefined(self)) {
    return;
  }

  self.cautiousnavigation = 0;
  self.dontmeleeme = 0;
  self.grenadeammo = self.ck_grenadeammo;

  if(istrue(self.ck_aggressivemode)) {
    self.aggressivemode = 1;
  }

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

  if(isDefined(self.ck_target)) {
    self.ck_target delete();
  }

  if(isDefined(self.a)) {
    self.a.disablelongdeath = 0;
  }

  self allowedstances("stand", "crouch", "prone");

  if(isDefined(self.ck_combatmode)) {
    self.combatmode = self.ck_combatmode;
    self.ck_combatmode = undefined;
    return;
  }

  self.combatmode = "cover";
}

function casual_killer_damage_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(scripts\engine\utility::is_equal(var1, level.player)) {
    self notify("ck_player_attacked_me");
    return;
  }
}

function casual_killer_enemy_reaction() {
  self endon("leaveCasualKiller");
  self endon("death");

  if(!isDefined(self.damage_functions)) {
    self.damage_functions = [];
  }

  self.damage_functions[self.damage_functions.size] = &casual_killer_damage_func;
  self waittill("ck_player_attacked_me");
  self.favoriteenemy = undefined;
  self clearentitytarget();
  self setthreatbiasgroup("axis");
}

function casual_killer_targeting() {
  self endon("leaveCasualKiller");
  self endon("death");
  wait 1;
  self.ck_target = spawn("script_origin", self.origin);
  thread scripts\engine\utility::delete_on_death(self.ck_target);
  var0 = undefined;
  var1 = 0;
  var2 = undefined;
  var3 = undefined;

  for(;;) {
    waitframe();

    if(!isDefined(self) || !isalive(self) || istrue(self.leavecasualkiller)) {
      return;
    }

    self.gunposeoverride = "disable";
    var4 = anglesToForward(self.angles);
    var5 = scripts\asm\shared\utility::getshootfrompos();

    if(var1) {
      if(!isalive(var0)) {
        var2 = gettime();
        self setentitytarget(self.ck_target);
        self forcethreatupdate();
        var1 = 0;
        var3 = undefined;
      } else {
        self.ck_target.origin = var0.origin;
      }
    }

    var6 = int(gettime() / 50);

    if(self getentitynumber() % 4 != var6 % 4) {
      if(isDefined(var2) && var2 + 3000 > gettime()) {
        var7 = self.ck_target.origin - self.origin;

        if(length(var7) > 100) {
          var7 = vectorNormalize(var7);
          var8 = abs(angleclamp180(acos(clamp(vectordot(var4, var7), -1, 1))));

          if(var8 > 30 && gettime() < var2 + 1500) {
            continue;
          }

          if(var8 < 90) {
            continue;
          }
        }
      }

      var2 = undefined;

      if(!isDefined(var3) || gettime() > var3 + 3000) {
        self clearentitytarget();
        self forcethreatupdate();

        if(isalive(self.enemy)) {
          if(var1 && self.enemy == var0) {
            var9 = self.enemy;
            var10 = self.enemy.origin - self.origin;
            var10 = vectorNormalize(var10);
            var11 = clamp(vectordot(var4, var10), -1, 1);
            var12 = abs(angleclamp180(acos(var11)));

            if(var12 > 70) {
              var13 = self getsecondarytargets();

              if(isDefined(var13)) {
                foreach(var15 in var13) {
                  var7 = var15.origin - self.origin;
                  var7 = vectorNormalize(var7);
                  var8 = abs(angleclamp180(acos(clamp(vectordot(var4, var7), -1, 1))));

                  if(var8 < var12) {
                    var12 = var8;
                    var9 = var15;
                  }
                }

                if(var9 != self.enemy) {
                  if(issentient(var9)) {
                    self.favoriteenemy = var9;
                    self forcethreatupdate();
                    self.favoriteenemy = undefined;
                    var3 = gettime();
                  }
                }
              }
            }
          }

          var1 = isalive(self.enemy);

          if(var1) {
            var0 = self.enemy;
          } else {
            var0 = undefined;
          }

          continue;
        }

        self setentitytarget(self.ck_target);
        self forcethreatupdate();

        if(isDefined(var2) && var2 + 7000 > gettime()) {
          if(vectordot(var4, self.ck_target.origin - var5) > 0) {
            continue;
          }
        }

        self.ck_target.origin = self.origin + (0, 0, 40) + var4 * 400;
      }
    }
  }
}

function casual_killer_sweep() {
  self endon("leaveCasualKiller");
  self endon("death");
  var0 = 100;
  var1 = 1000;
  var2 = 20;
  var3 = -1;
  var4 = [40, 50, 60];
  var5 = [20, 25, 30];
  var6 = 0;
  var7 = 0;
  var8 = scripts\engine\utility::random(var4);
  var9 = scripts\engine\utility::random(var5);
  var10 = 0;
  var11 = undefined;
  var12 = undefined;

  foreach(var14 in var5) {
    if(var14 > var6) {
      var6 = var14;
    }
  }

  while(isalive(self) && isDefined(self)) {
    waitframe();
    self.leftaimlimit = 90;
    self.rightaimlimit = -90;
    self.aimyawspeed = 180;
    var16 = anglesToForward(self.angles);
    var17 = scripts\asm\shared\utility::getshootfrompos();

    if(isDefined(self.enemy)) {
      if(!isDefined(self.pathgoalpos) || self.lookaheaddist > self aigetdesiredspeed()) {
        var11 = self.enemy getshootatpos();
      }
    }

    var18 = scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "aim") || scripts\asm\asm::asm_currentstatehasflag(self.asm.trackasm, "notetrackAim");

    if(var18) {
      var18 = isDefined(var11);
    }

    var19 = scripts\asm\asm::asm_getcurrentstate(self.asmname);

    if(var19 == "exposed_arrival" || var19 == "exposed_reload") {
      var18 = 0;
    }

    if(var18) {
      var20 = self getposonpath(self aigetdesiredspeed());
      var21 = var11 - var20;
      var21 = (var21[0], var21[1], 0);
      var22 = vectorNormalize(var21);
      var23 = self.leftaimlimit;

      if(!istrue(var12)) {
        var23 = max(0, self.leftaimlimit - 20);
      }

      var24 = abs(angleclamp180(acos(clamp(vectordot(var22, var16), -1, 1))));

      if(var24 >= var23) {
        var11 = undefined;
        var10 = 0;
        var18 = 0;
      }
    }

    if(!istrue(var18)) {
      scripts\common\utility::lookatentity(undefined);
      scripts\common\utility::lookatpos(var17 + var16 * 200);
      self.casualkillershootpos = var17 + var16 * 200;
      var2 = 20 * var3;
      var3 *= -1;
      var10 = 0;
      self.dontevershoot = 1;
      var12 = 0;
      continue;
    }

    var12 = 1;
    self.dontevershoot = 0;

    if(isDefined(var11)) {
      scripts\common\utility::lookatpos(var11);
    } else {
      scripts\common\utility::lookatentity(undefined);
      scripts\common\utility::lookatpos(undefined);
    }

    var21 = var11 - var17;
    var25 = length(var21);
    var22 = vectorNormalize(var21);
    var24 = abs(angleclamp180(acos(clamp(vectordot(var16, var22), -1, 1))));
    var26 = axistoangles(var22, anglestoright(self.angles), anglestoup(self.angles));
    var27 = var26[1];

    if(istrue(self.leavecasualkiller)) {
      if(var2 > 0) {
        var2 -= min(var2, var8 * level.framedurationseconds);
        var3 = -1;
      } else if(var2 < 0) {
        var2 += min(var2 * -1, var8 * level.framedurationseconds);
        var3 = 1;
      }
    } else if(var24 + var6 < abs(self.leftaimlimit) && var24 + var6 < abs(self.rightaimlimit) && var25 > var0 && (var25 < var1 || isDefined(self.enemy) && self.enemy == level.player)) {
      if(gettime() > var7) {
        var28 = level.framedurationseconds * var8 * var3;
        var2 += var28;

        if(scripts\engine\utility::sign(var2) == scripts\engine\utility::sign(var3) && abs(var2) > var9) {
          var3 *= -1;
          var8 = scripts\engine\utility::random(var4);
          var9 = scripts\engine\utility::random(var5);
          var7 = gettime() + 350;
        }
      }

      var27 += var2;
    }

    var29 = axistoangles(var22, anglestoright(self.angles), anglestoup(self.angles));
    var29 = (var29[0], var27, var29[2]);
    var22 = anglesToForward(var29);
    self.casualkillershootpos = var22 * var25 + var17;

    if(istrue(self.leavecasualkiller) && var2 == 0) {
      return;
    }
  }
}