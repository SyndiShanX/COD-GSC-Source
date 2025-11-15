/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3593.gsc
************************/

tripmine_used(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  scripts\mp\utility::printgameaction("trip mine spawn", param_00.triggerportableradarping);
  param_00 thread func_127D9();
  thread scripts\mp\weapons::monitordisownedgrenade(self, param_00);
  param_00 waittill("missile_stuck", var_01);
  param_00 setotherent(self);
  param_00 give_player_tickets(1);
  if(scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
    param_00.hasruggedeqp = 1;
  }

  param_00.var_ABC7 = func_127EB(param_00);
  param_00 thread scripts\mp\weapons::minedeletetrigger(param_00.var_ABC7);
  param_00.var_ABC9 = func_127EC(param_00);
  param_00 thread scripts\mp\weapons::minedeletetrigger(param_00.var_ABC9);
  scripts\mp\weapons::onlethalequipmentplanted(param_00, "power_tripMine");
  thread scripts\mp\weapons::monitordisownedequipment(self, param_00);
  param_00 thread scripts\mp\weapons::minedamagemonitor();
  param_00 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", param_00.triggerportableradarping);
  param_00 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  param_00 thread func_127DC();
  param_00 thread func_127D8();
  param_00 thread func_127D1();
  param_00 thread scripts\mp\perks\_perk_equipmentping::runequipmentping();
  param_00 setscriptablepartstate("plant", "active", 0);
  param_00 missilethermal();
  param_00 missileoutline();
  thread scripts\mp\weapons::outlineequipmentforowner(param_00, self);
}

func_127EB(param_00) {
  var_01 = param_00 gettagorigin("tag_laser");
  var_02 = param_00.angles;
  var_03 = spawn("trigger_rotatable_radius", var_01, 0, 3, 210);
  var_03.angles = var_02;
  var_03 enablelinkto();
  var_03 linkto(param_00);
  var_03 hide();
  return var_03;
}

func_127EC(param_00) {
  var_01 = spawn("trigger_rotatable_radius", param_00.origin, 0, 32, 32);
  var_01.angles = param_00.angles;
  var_01 enablelinkto();
  var_01 linkto(param_00);
  var_01 hide();
  return var_01;
}

func_127D1() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  wait(2);
  self setscriptablepartstate("arm", "active", 0);
  thread func_127F3();
  thread func_127F4();
  thread tripmine_watchlethaltriggerbeammanual();
  thread func_127F7();
}

func_127DC() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  level endon("game_ended");
  var_00 = self.triggerportableradarping;
  self waittill("detonateExplosive", var_01);
  if(isDefined(var_01)) {
    if(var_01 != var_00) {
      var_00 thread scripts\mp\utility::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);
    }

    thread func_127DB(var_01);
    return;
  }

  thread func_127DB(var_00);
}

func_127D8() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self waittill("emp_damage", var_00, var_01, var_02, var_03, var_04);
  if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_00))) {
    var_00 notify("destroyed_equipment");
    var_00 scripts\mp\killstreaks\_killstreaks::_meth_83A0();
    if(isDefined(var_03) && var_03 == "emp_grenade_mp") {
      var_00 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  var_05 = "";
  if(scripts\mp\utility::istrue(self.hasruggedeqp)) {
    var_05 = "hitequip";
  }

  if(isplayer(var_00)) {
    var_00 scripts\mp\damagefeedback::updatedamagefeedback(var_05);
  }

  thread func_127D7();
}

func_127D9() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  level scripts\engine\utility::waittill_any_3("game_ended", "bro_shot_start");
  thread func_127D7();
}

func_127DB(param_00) {
  thread func_127D6(0.1);
  self setentityowner(param_00);
  self _meth_8593();
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
}

func_127D7(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  thread func_127D6(param_00 + 0.1);
  wait(param_00);
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

func_127E7(param_00) {
  var_01 = spawn("script_model", self gettagorigin("tag_laser"));
  var_01.angles = self.angles;
  var_01.planted = self.planted;
  var_01 setotherent(self.triggerportableradarping);
  var_01 setentityowner(self.triggerportableradarping);
  var_01 setModel("trip_mine_wm_projectile");
  var_01.triggerportableradarping = self.triggerportableradarping;
  var_01.team = self.team;
  var_01.weapon_name = "trip_mine_mp";
  var_01.power = "power_tripMine";
  var_01.killcament = self;
  thread func_127D7(0.2);
  self setscriptablepartstate("launch", "active", 0);
  var_01 setscriptablepartstate("trail", "active", 0);
  var_01 moveto(param_00, 0.2, 0.1);
  wait(0.2);
  var_02 = undefined;
  if(isDefined(var_01.triggerportableradarping)) {
    var_02 = 0.1;
    var_01 setscriptablepartstate("explode", "active", 0);
  } else {
    var_02 = 0.1;
    var_01 setscriptablepartstate("destroy", "active", 0);
  }

  wait(var_02);
  var_01 delete();
}

func_127F3() {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_00 = func_127D2();
  for(;;) {
    var_01 = self gettagorigin("tag_laser");
    var_02 = var_01 + anglesToForward(self gettagangles("tag_laser")) * 210;
    var_03 = physics_raycast(var_01, var_02, var_00, self, 0, "physicsquery_closest");
    if(isDefined(var_03) && var_03.size > 0) {
      var_02 = var_03[0]["position"];
    }

    self.var_2A3F = var_01;
    self.var_2A3A = var_02;
    self.var_2A3C = distance(var_01, var_02);
    self setscriptablebeamlength(self.var_2A3C);
    scripts\engine\utility::waitframe();
  }
}

func_127F4() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_00 = self.var_ABC7;
  var_01 = func_127D2();
  while(isDefined(var_00)) {
    var_00 waittill("trigger", var_02);
    if(tripmine_testlethaltriggerbeam(var_00, var_01, var_02)) {
      return;
    }
  }
}

tripmine_watchlethaltriggerbeammanual() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_00 = self.var_ABC7;
  var_01 = func_127D2();
  while(isDefined(var_00)) {
    var_02 = level.var_69D6;
    var_03 = self.origin;
    var_04 = anglestoup(self.angles);
    foreach(var_06 in var_02) {
      if(!isDefined(var_06)) {
        continue;
      }

      var_07 = var_06.origin - var_03;
      if(lengthsquared(var_07) > -3036) {
        continue;
      }

      if(vectordot(var_07, var_04) < 0) {
        continue;
      }

      if(tripmine_testlethaltriggerbeam(var_00, var_01, var_06)) {
        return;
      }
    }

    wait(0.1);
  }
}

tripmine_testlethaltriggerbeam(param_00, param_01, param_02) {
  if(!func_127E4(param_02, 1)) {
    return 0;
  }

  var_03 = param_02.origin;
  var_04 = param_02.origin;
  var_05 = 16;
  if(isplayer(param_02) || isagent(param_02)) {
    var_03 = param_02 gettagorigin("j_helmet");
  } else if(isDefined(param_02.streakname) && param_02.streakname == "venom") {
    var_03 = param_02.origin + (0, 0, 15);
  } else if(isDefined(param_02.streakname) && param_02.streakname == "minijackal") {
    var_04 = param_02.origin - (0, 0, 60);
    var_03 = param_02.origin + (0, 0, 24);
    var_05 = 30;
  } else if(isDefined(param_02.streakname) && param_02.streakname == "ball_drone_backup") {
    var_04 = param_02.origin - (0, 0, 12);
    var_03 = param_02.origin + (0, 0, 12);
    var_05 = 20;
  } else if(param_02 scripts\mp\equipment\exploding_drone::isexplodingdrone()) {
    var_04 = param_02.origin - (0, 0, 12);
    var_03 = param_02.origin + (0, 0, 12);
    var_05 = 14;
  }

  var_06 = self.var_2A3F;
  var_07 = self.var_2A3A;
  var_08 = scripts\engine\utility::closestdistancebetweensegments(var_04, var_03, var_06, var_07);
  if(!isDefined(var_08)) {
    return 0;
  }

  var_09 = var_08[0];
  var_0A = var_08[1];
  var_0B = var_08[2];
  var_0C = var_0A[2] > var_03[2];
  var_0D = var_0A[2] < var_04[2];
  if(var_0C || var_0D || var_0B > var_05) {
    return 0;
  }

  thread func_127E8(param_02, var_0A);
  return 1;
}

func_127F7() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  var_00 = self.var_ABC9;
  var_01 = func_127D2();
  while(isDefined(var_00)) {
    var_00 waittill("trigger", var_02);
    if(!func_127E4(var_02, 0)) {
      continue;
    }

    var_03 = var_02.origin;
    if(isplayer(var_02) || isagent(var_02)) {
      var_03 = var_02 getEye();
    }

    var_04 = physics_raycast(self.origin, var_02 getEye(), var_01, self, 0, "physicsquery_closest");
    if(isDefined(var_04) && var_04.size > 0) {
      continue;
    }

    var_05 = self.var_2A3F;
    var_06 = self.var_2A3A;
    var_07 = var_05 + var_06 - var_05 * 0.2;
    thread func_127E8(var_02, var_07);
    break;
  }
}

func_127E8(param_00, param_01) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self notify("mine_triggered");
  scripts\mp\utility::printgameaction("trip mine triggered", self.triggerportableradarping);
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  scripts\mp\weapons::explosivetrigger(param_00, 0.3, "tripMine");
  thread func_127E7(param_01);
}

func_127E4(param_00, param_01) {
  var_02 = param_00;
  if(!isDefined(param_00)) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(param_00)) {
    return 0;
  }

  if(isplayer(param_00) || isagent(param_00)) {
    if(scripts\mp\utility::func_9F72(param_00)) {
      return 0;
    }

    if(scripts\mp\utility::func_9F22(param_00)) {
      var_02 = param_00.triggerportableradarping;
    }

    if(!scripts\mp\utility::isreallyalive(param_00)) {
      return 0;
    }

    if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_02))) {
      return 0;
    }

    if(!param_01 && lengthsquared(param_00 getentityvelocity()) < 0.0001) {
      return 0;
    }
  } else {
    if(isDefined(param_00.streakname)) {
      var_02 = param_00.triggerportableradarping;
      if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_02))) {
        return 0;
      }

      if(param_00.streakname == "venom" || param_00.streakname == "minijackal") {
        if(!param_01 && lengthsquared(param_00 getentityvelocity()) < 0.0001) {
          return 0;
        }

        return 1;
      } else if(param_00.streakname == "ball_drone_backup") {
        return 1;
      }
    } else if(param_00 scripts\mp\equipment\exploding_drone::isexplodingdrone()) {
      var_02 = param_00.triggerportableradarping;
      if(!scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_02))) {
        return 0;
      }

      return 1;
    }

    return 0;
  }

  return 1;
}

func_127D6(param_00) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self.exploding = 1;
  var_01 = self.triggerportableradarping;
  if(isDefined(self.triggerportableradarping)) {
    var_01.plantedlethalequip = scripts\engine\utility::array_remove(var_01.plantedlethalequip, self);
    var_01 notify("trip_mine_update", 0);
  }

  wait(param_00);
  self delete();
}

func_127D2() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_water", "physicscontents_sky", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_item", "physicscontents_missileclip"]);
}