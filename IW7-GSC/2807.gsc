/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2807.gsc
**************************************/

func_12813() {
  var_0 = spawnStruct();
  var_0.var_1141B = [];
  var_0.var_1141B[0] = "tag_sensor_1";
  var_0.var_1141B[1] = "tag_sensor_2";
  var_0.var_1141B[2] = "tag_sensor_3";
  level.var_12802 = var_0;
}

func_12820() {
  func_12806();
  func_1281A();
}

func_12825() {
  func_12806();
}

func_12827(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  scripts\mp\utility\game::printgameaction("trophy spawned", self);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  var_0 waittill("missile_stuck", var_1);
  var_0 setotherent(self);
  var_0 give_player_tickets(1);
  var_2 = scripts\mp\utility\game::_hasperk("specialty_rugged_eqp");

  if(var_2) {
    var_0.hasruggedeqp = 1;
  }

  var_0.var_1E2D = func_1281F();

  if(!isDefined(var_0.var_1E2D)) {
    var_0.var_1E2D = 2;
  }

  scripts\mp\weapons::ontacticalequipmentplanted(var_0, "power_trophy");
  thread scripts\mp\weapons::monitordisownedequipment(self, var_0);
  var_0 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  var_0.var_69DA = trophy_createexplosion(var_0);
  var_3 = scripts\engine\utility::ter_op(var_2, 200, 100);
  var_4 = scripts\engine\utility::ter_op(var_2, "hitequip", "");
  var_0 thread scripts\mp\damage::monitordamage(var_3, var_4, ::func_12812, ::func_12811, 0);
  var_0 thread trophy_destroyonemp();
  var_0 thread trophy_destroyongameend();
  var_0 thread func_1282B();
  var_0 missilethermal();
  var_0 missileoutline();
  var_0 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  var_0 thread scripts\mp\entityheadicons::setheadicon_factionimage(self, (0, 0, 38), 1.3);
  thread scripts\mp\weapons::outlineequipmentforowner(var_0, self);
  var_0 thread func_1280B();
  var_0 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
}

trophy_destroy() {
  thread trophy_delete(1.6);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);
  wait 1.5;
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

trophy_delete(var_0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  self makeunusable();
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner)) {
    var_1.plantedtacticalequip = scripts\engine\utility::array_remove(var_1.plantedtacticalequip, self);
    var_1 notify("trophy_update", 0);
  }

  wait(var_0);
  self delete();
}

func_1280B() {
  self endon("death");
  self setscriptablepartstate("effects", "activeDeployStart");
  wait 1.25;
  self setscriptablepartstate("effects", "activeDeployEnd");
}

func_1282B() {
  self endon("death");
  self.owner endon("disconnect");

  if(!isDefined(level.grenades)) {
    level.grenades = [];
  }

  if(!isDefined(level.missiles)) {
    level.missiles = [];
  }

  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  var_0 = func_12804();

  for(;;) {
    var_1 = func_12805();
    var_2 = [];
    var_2[0] = level.grenades;
    var_2[1] = level.missiles;
    var_2[2] = level.mines;
    var_3 = scripts\engine\utility::array_combine_multiple(var_2);

    foreach(var_5 in var_3) {
      if(!isDefined(var_5)) {
        continue;
      }
      if(scripts\mp\utility\game::istrue(var_5.exploding)) {
        continue;
      }
      if(trophy_checkignorelist(var_5)) {
        continue;
      }
      var_6 = var_5.owner;

      if(!isDefined(var_6) && isDefined(var_5.weapon_name) && weaponclass(var_5.weapon_name) == "grenade") {
        var_6 = getmissileowner(var_5);
      }

      if(isDefined(var_6) && !scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_6))) {
        continue;
      }
      if(distancesquared(var_5.origin, self.origin) > trophy_modifiedprotectiondistsqr(var_5, 65536)) {
        continue;
      }
      var_7 = physics_raycast(var_1, var_5.origin, var_0, [self, var_5], 0, "physicsquery_closest");

      if(isDefined(var_7) && var_7.size > 0) {
        continue;
      }
      func_1281E(var_5);
    }

    scripts\engine\utility::waitframe();
  }
}

func_1281E(var_0) {
  self.owner thread scripts\mp\utility\game::giveunifiedpoints("trophy_defense");
  self.owner scripts\mp\missions::func_D991("ch_tactical_trophy");
  self.owner thread scripts\mp\gamelogic::threadedsetweaponstatbyname("trophy_mp", 1, "hits");
  self.owner scripts\mp\damage::combatrecordtacticalstat("power_trophy");
  var_0 setCanDamage(0);
  var_0.exploding = 1;
  var_0 stopsounds();
  func_12821(var_0);
  func_12817(var_0, "trophy_mp", self.owner);
  var_1 = var_0.origin;
  var_2 = var_0.angles;

  if(scripts\mp\weapons::isplantedequipment(var_0)) {
    var_0 scripts\mp\weapons::deleteexplosive();
  } else if(var_0 scripts\mp\domeshield::isdomeshield()) {
    var_0 thread scripts\mp\domeshield::domeshield_delete();
  } else {
    var_0 delete();
  }

  var_3 = trophy_getbesttag(var_1);
  var_4 = trophy_getpartbytag(var_3);
  self setscriptablepartstate(var_4, "active", 0);
  self.var_69DA thread trophy_explode(var_1, var_2);
  self.var_1E2D--;

  if(self.var_1E2D <= 0) {
    thread trophy_destroy();
  }
}

func_12811(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_5 = scripts\mp\damage::handlemeleedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  scripts\mp\powers::equipmenthit(self.owner, var_0, var_1, var_2);
  return var_5;
}

func_12812(var_0, var_1, var_2, var_3, var_4) {
  trophy_givepointsfordeath(var_0);
  thread trophy_destroy();
}

trophy_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_damage", var_0, var_1);
  trophy_givepointsfordeath(var_0);
  trophy_givedamagefeedback(var_0);
  thread trophy_destroy();
}

trophy_destroyongameend() {
  self endon("death");
  self.owner endon("disconnect");
  level scripts\engine\utility::waittill_any("game_ended", "bro_shot_start");
  thread trophy_destroy();
}

func_12818() {
  if(self.owner scripts\mp\powers::hasequipment("power_trophy")) {
    self.owner func_12803(self.var_1E2D);
  }
}

trophy_createexplosion(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.killcament = var_0;
  var_1.owner = var_0.owner;
  var_1.team = var_0.team;
  var_1.power = var_0.power;
  var_1.weapon_name = var_0.weapon_name;
  var_1 setotherent(var_1.owner);
  var_1 setentityowner(var_1.owner);
  var_1 setModel("trophy_system_mp_explode");
  var_1.explode1available = 1;
  var_1.explode2available = 1;
  var_1 thread trophy_cleanuponparentdeath(var_0, 0.1);
  return var_1;
}

trophy_explode(var_0, var_1) {
  self dontinterpolate();
  self.origin = var_0;
  self.angles = var_1;

  if(self.explode1available) {
    self setscriptablepartstate("explode1", "active", 0);
    self.explode1available = 0;
  } else if(self.explode2available) {
    self setscriptablepartstate("explode2", "active", 0);
    self.explode1available = 0;
  }
}

func_12805() {
  return self.origin + anglestoup(self.angles) * 45;
}

func_12804() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
}

trophy_modifiedprotectiondistsqr(var_0, var_1) {
  if(isDefined(var_0.weapon_name) && isDefined(var_0.owner)) {
    switch (var_0.weapon_name) {
      case "jackal_cannon_mp":
      case "shockproj_mp":
      case "switch_blade_child_mp":
      case "thorproj_zoomed_mp":
      case "drone_hive_projectile_mp":
        if(147456 > var_1) {
          var_1 = 147456;
        }

        break;
      case "iw7_arclassic_mp":
      case "iw7_chargeshot_mp":
      case "iw7_lockon_mp":
      case "wristrocket_proj_mp":
        if(65536 > var_1) {
          var_1 = 65536;
        }

        break;
    }
  }

  return var_1;
}

trophy_checkignorelist(var_0) {
  if(isDefined(var_0.weapon_name)) {
    if(scripts\mp\utility\game::iskillstreakweapon(var_0.weapon_name)) {
      return 1;
    }

    if(scripts\mp\weapons::isaxeweapon(var_0.weapon_name)) {
      return 1;
    }

    switch (var_0.weapon_name) {
      case "domeshield_mp":
        if(scripts\mp\weapons::isplantedequipment(var_0)) {
          return 1;
        }

        break;
      case "trophy_mp":
        if(scripts\mp\weapons::isplantedequipment(var_0)) {
          return 1;
        }

        break;
      case "uplinkball_tracking_mp":
      case "blackholegun_indicator_mp":
      case "cluster_grenade_indicator_mp":
      case "micro_turret_mp":
      case "iw7_cheytac_mpr_projectile":
      case "iw7_blackholegun_mp":
      case "globproj_mp":
      case "transponder_mp":
      case "throwingknifeteleport_mp":
      case "throwingknife_mp":
      case "wristrocket_mp":
      case "throwingknifec4_mp":
        return 1;
    }
  }

  return 0;
}

func_12821(var_0) {
  if(getdvarint("showArchetypes", 0) > 0) {
    var_0 scripts\mp\powers::func_C179();
  }
}

func_12817(var_0, var_1, var_2) {
  if(!isDefined(var_0.owner) || !isPlayer(var_0.owner)) {
    return;
  }
  var_0.owner thread scripts\mp\damagefeedback::updatedamagefeedback("hiticontrophysystem");

  if(isDefined(var_0.weapon_name)) {
    switch (var_0.weapon_name) {
      case "jackal_cannon_mp":
      case "shockproj_mp":
      case "switch_blade_child_mp":
      case "thorproj_tracking_mp":
      case "thorproj_zoomed_mp":
      case "drone_hive_projectile_mp":
        var_0.owner notify("destroyed_by_trophy", var_2, var_1, var_0.weapon_name, var_0.origin, var_0.angles);
        break;
    }
  }
}

trophy_getbesttag(var_0) {
  var_1 = level.var_12802.var_1141B;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_10, var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = self gettagangles(var_5);
    var_8 = anglesToForward(var_7);
    var_9 = vectordot(vectornormalize(var_0 - var_6), var_8);

    if(var_10 == 0 || var_9 > var_2) {
      var_2 = var_9;
      var_3 = var_5;
    }
  }

  return var_3;
}

trophy_getpartbytag(var_0) {
  var_1 = level.var_12802.var_1141B;

  foreach(var_4, var_3 in var_1) {
    if(var_3 == var_0) {
      return "protect" + (var_4 + 1);
    }
  }

  return undefined;
}

trophy_givepointsfordeath(var_0) {
  if(scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    var_0 thread scripts\mp\utility\game::giveunifiedpoints("destroyed_equipment");
  }
}

trophy_givedamagefeedback(var_0) {
  var_1 = "";

  if(scripts\mp\utility\game::istrue(self.hasruggedeqp)) {
    var_1 = "hitequip";
  }

  if(isPlayer(var_0)) {
    var_0 scripts\mp\damagefeedback::updatedamagefeedback(var_1);
  }
}

func_12803(var_0) {
  if(!isDefined(self.trophies)) {
    self.trophies = [];
  }

  if(self.trophies.size < func_12814()) {
    if(!isDefined(var_0)) {
      var_0 = 2;
    }

    self.trophies[self.trophies.size] = var_0;
  }
}

func_1281F() {
  if(isDefined(self.trophies) && self.trophies.size > 0) {
    var_0 = self.trophies[self.trophies.size - 1];
    self.trophies[self.trophies.size - 1] = undefined;
    return var_0;
  }

  return undefined;
}

func_12806() {
  self.trophies = undefined;
}

func_1281A() {
  var_0 = scripts\mp\powers::func_D736("power_trophy");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    func_12803();
  }
}

func_12814() {
  return scripts\mp\powers::func_D736("power_trophy");
}

trophy_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    return [var_3, var_4];
  }

  if(var_3 == 0) {
    return [var_3, var_4];
  }

  var_5 = undefined;

  if(level.hardcoremode) {
    switch (var_2) {
      case "super_trophy_mp":
      case "player_trophy_system_mp":
      case "trophy_mp":
        var_5 = 20;
        break;
    }
  }

  var_6 = var_4;

  if(isDefined(var_5)) {
    var_6 = var_5 - var_3;
  }

  var_6 = min(var_6, var_4);
  return [var_3, var_4];
}

trophy_cleanuponparentdeath(var_0, var_1) {
  self endon("death");
  var_0 waittill("death");
  wait(var_1);
  self delete();
}