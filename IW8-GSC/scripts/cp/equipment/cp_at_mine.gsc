/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_at_mine.gsc
***********************************************/

function at_mine_use(var_0) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("death");
  var_0.set_car_collision = self.name;
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  thread at_mine_watch_game_end();
  var_0 setscriptablepartstate("visibility", "show", 0);
  var_0 waittill("missile_stuck", var_1);

  if(isDefined(var_1)) {
    var_0 linkTo(var_1);
  }

  thread at_mine_plant(var_0);
}

function at_mine_plant(var_0) {
  var_0 endon("mine_destroyed");
  var_0 endon("death");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  if(isPlayer(self)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "use_atmine");
    var_0 setotherent(self);
    var_0 setentityowner(self);
  }

  var_0 missilethermal();
  var_0 missileoutline();
  var_0 setnodeploy(1);
  var_0 setscriptablepartstate("plant", "active", 0);
  var_0 enableplayermarks("equipment");

  if(isPlayer(self)) {
    self setscriptablepartstate("equipATMineFXView", "plant", 0);
    scripts\cp\cp_weapon::onlethalequipmentplanted(var_0, "equip_at_mine", 1);
    thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  } else {
    level thread scripts\cp\cp_weapon::bankingoverlimitwillendot(var_0);
  }

  var_0 thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1);
  var_0 thread scripts\cp\cp_weapon::minedamagemonitor();
  thread at_mine_watch_detonate();
  thread at_mine_watch_emp();
  thread remotedefusesetup();
  thread remotedetonatethink();
  wait 1;
  var_1 = at_mine_create_player_trigger(var_0);
  var_0.playertrigger = var_1;
  var_0 thread scripts\cp\cp_weapon::minedeletetrigger(var_1);
  thread at_mine_watch_player_trigger(var_0);
  thread at_mine_watch_vehicle_trigger();
}

function at_mine_explode_from_player_trigger(var_0) {
  thread at_mine_delete(1);

  if(isDefined(var_0)) {
    self setentityowner(var_0);
    self clearscriptabledamageowner();
  }

  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "fromPlayer", 0);
}

function at_mine_explode_from_vehicle_trigger(var_0) {
  if(isDefined(var_0)) {
    thread at_mine_damage_manually(self.owner, var_0);
  }

  thread at_mine_delete(1);
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromVehicle", 0);
}

function at_mine_explode_from_notify(var_0) {
  thread at_mine_delete(1);
  self setentityowner(var_0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromDamage", 0);
}

function at_mine_destroy(var_0) {
  thread at_mine_delete(1);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

function at_mine_delete(var_0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner) && isDefined(var_1.plantedlethalequip)) {
    var_1.plantedlethalequip = scripts\engine\utility::array_remove(var_1.plantedlethalequip, self);
  }

  if(isDefined(self.dangericonent)) {
    self.dangericonent delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  if(isDefined(var_0)) {
    wait var_0;
  }

  level notify("grenade_exploded_during_stealth", self.origin, "at_mine_mp", self.set_car_collision);
  self delete();
}

function at_mine_create_player_trigger() {
  var_0 = spawn("trigger_rotatable_radius", self.origin, 0, 100, 50);
  var_0.angles = self.angles;
  var_0 enablelinkTo();
  var_0 linkTo(self);
  var_0 hide();
  var_0.mine = self;
  return var_0;
}

function at_mine_watch_player_trigger(var_0) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  var_1 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(!isDefined(var_2)) {
      continue;
    }

    if(!isPlayer(var_2) && !isagent(var_2)) {
      continue;
    }

    if(isDefined(var_2.vehicle)) {
      continue;
    }

    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_2))) {
      continue;
    }

    thread at_mine_player_trigger(var_2);
  }
}

function at_mine_player_trigger(var_0) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  self.triggeredbyplayer = 1;
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  var_1 = scripts\cp\utility::_launchgrenade("at_mine_ap_mp", self.origin, (0, 0, 0), 100, 1);
  var_1 linkTo(self);
  thread at_mine_cleanup_danger_icon_ent(var_1);
  var_1.weapon_object = getcompleteweaponname("at_mine_ap_mp");
  self.dangericonent = var_1;
  scripts\cp\cp_weapon::explosivetrigger(var_0, 0.1);
  thread at_mine_watch_flight();
}

function at_mine_watch_vehicle_trigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  var_0 = [(0, 0, 0), (60, 0, 0), (-60, 0, 0)];
  var_1 = 75;
  var_2 = var_1 * var_1;
  var_3 = 30;
  var_4 = [(0, 0, 0), (22, 0, 0), (-22, 0, 0)];
  var_5 = 96;
  var_6 = var_5 * var_5;
  var_7 = 15;

  for(;;) {
    var_8 = getactivebradleys();

    if(isDefined(var_8)) {
      foreach(var_10 in var_8) {
        if(!isDefined(var_10)) {
          continue;
        }

        if(level.teambased) {
          if(var_10.team == self.owner.team) {
            continue;
          }
        } else if(isDefined(var_10.owner) && var_10.owner == self.owner) {
          continue;
        }

        var_11 = anglestoaxis(var_10.angles);

        foreach(var_13 in var_0) {
          var_14 = var_10.origin;
          var_14 += var_11["right"] * var_13[0];
          var_14 += var_11["forward"] * var_13[1];
          var_14 += var_11["up"] * var_13[2];
          var_15 = self.origin - var_14;
          var_16 = vectordot(var_15, var_11["up"]);

          if(abs(var_16) > var_3) {
            continue;
          }

          var_17 = var_15 - var_11["up"] * var_16;

          if(lengthsquared(var_17) > var_2) {
            continue;
          }

          thread at_mine_vehicle_trigger(var_10);
          return;
        }
      }
    }

    var_20 = level.assaultdrones;

    if(isDefined(var_20)) {
      foreach(var_22 in var_20) {
        if(!isDefined(var_22)) {
          continue;
        }

        if(!isDefined(var_22.streakname) || var_22.streakname != "pac_sentry") {
          continue;
        }

        if(isDefined(var_22.owner) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_22.owner, self.owner))) {
          continue;
        }

        var_11 = anglestoaxis(var_22.angles);

        foreach(var_13 in var_4) {
          var_24 = var_22.origin;
          var_24 += var_11["right"] * var_13[0];
          var_24 += var_11["forward"] * var_13[1];
          var_24 += var_11["up"] * var_13[2];
          var_15 = self.origin - var_24;
          var_16 = vectordot(var_15, var_11["up"]);

          if(abs(var_16) > var_7) {
            continue;
          }

          var_17 = var_15 - var_11["up"] * var_16;

          if(lengthsquared(var_17) > var_6) {
            continue;
          }

          thread at_mine_vehicle_trigger(var_22);
          return;
        }
      }
    }

    waitframe();
  }
}

function getactivebradleys() {
  var_0 = [];

  foreach(var_2 in level.vehicle.instances) {
    foreach(var_4 in var_2) {
      var_0 = var_4;
    }
  }

  if(isDefined(level.bradley)) {
    var_0 = scripts\engine\utility::array_combine(var_0, level.bradley.activevehicles["total"]);
  }

  if(var_0.size == 0) {
    return undefined;
  }

  return var_0;
}

function at_mine_vehicle_trigger(var_0) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  wait 0.2;
  thread at_mine_explode_from_vehicle_trigger(var_0);
}

function at_mine_watch_flight_mover(var_0) {
  self endon("death");
  self.grenade scripts\engine\utility::ref_143BA(var_0, "death", "mine_destroyed");

  if(isDefined(self.grenade)) {
    self moveTo(self.origin, 0.05, 0, 0);
  }

  wait 2;
  self delete();
}

function at_mine_watch_flight() {
  self endon("mine_destroyed");
  self endon("death");
  var_0 = 0.7;

  if(var_0 > 0) {
    var_1 = (0, 0, 1);
    var_2 = self.origin + var_1 * 64;
    var_3 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
    var_4 = self.origin;
    var_5 = var_2;
    var_6 = physics_raycast(var_4, var_5, var_3, self, 0, "physicsquery_closest", 1);

    if(isDefined(var_6) && var_6.size > 0) {
      var_7 = vectordot(var_6[0]["position"] - var_4, var_1);
      var_7 = max(0, var_7 - 1);
      var_0 = 0;
      var_2 = self.origin;

      if(var_7 > 0) {
        var_0 = var_7 / 64 * 0.7;
        var_2 = self.origin + var_1 * var_7;
      }
    }

    if(var_0 > 0) {
      var_8 = var_0;
      var_9 = var_8 * 0.93;
      var_8 -= var_9;
      var_10 = 0;

      if(var_8 > 0) {
        var_10 = var_8 * 0;
      }

      var_11 = spawn("script_model", self.origin);
      var_11.angles = vectortoangles(anglesToForward(self.angles) * (1, 1, 0));
      var_11 setModel("tag_origin");
      self.mover = var_11;
      var_11.grenade = self;
      self linkTo(var_11, "tag_origin", (0, 0, 0), (0, 0, 0));
      var_11 moveTo(var_2, var_0, var_10, var_9);
      thread at_mine_watch_flight_mover(var_11);
      thread at_mine_watch_flight_effects(var_0);
      wait var_0;
      thread at_mine_explode_from_player_trigger();
      return;
    }

    return;
  }
}

function at_mine_watch_flight_effects(var_0) {
  self endon("mine_destroyed");
  self endon("death");
  self setscriptablepartstate("launch", "active", 0);
}

function at_mine_watch_emp() {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    self waittill("emp_applied", var_0);
    var_1 = var_0.attacker;

    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
      var_1 notify("destroyed_equipment");

      if(isPlayer(var_1)) {
        var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
      }

      thread at_mine_destroy();
    }
  }
}

function at_mine_watch_detonate() {
  self endon("death");
  self.owner endon("disconnect");
  var_0 = self.owner;
  self waittill("detonateExplosive", var_1);

  if(isDefined(var_1)) {
    thread at_mine_explode_from_notify(var_1);
    return;
  }

  thread at_mine_explode_from_notify(var_0);
}

function at_mine_watch_game_end() {
  self endon("mine_destroyed");
  self endon("death");
  level scripts\engine\utility::ref_143A5("game_ended", "bro_shot_start");
  thread at_mine_destroy();
}

function at_mine_damage_manually(var_0, var_1) {
  var_1 endon("death");
  var_2 = getcompleteweaponname("at_mine_mp");
  waitframe();
  var_3 = 200;

  if(isDefined(var_1.mine_damage_override)) {
    var_3 = var_1.mine_damage_override;
  }

  if(isDefined(var_0) && isDefined(self)) {
    var_1 dodamage(var_3, self.origin, var_0, self, "MOD_EXPLOSIVE", var_2);
    var_1 notify("damage", var_3, self.origin, var_0, self, "MOD_EXPLOSIVE", var_2);
    return;
  }
}

function at_mine_modified_damage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    return var_4;
  }

  if(var_3 != "MOD_EXPLOSIVE") {
    return var_4;
  }

  if(!isDefined(var_2)) {
    return var_4;
  }

  if(nullweapon(var_2)) {
    return var_4;
  }

  if(var_2.basename != "at_mine_mp" && var_2.basename != "at_mine_ap_mp") {
    return var_4;
  }

  var_5 = anglestoup(var_1.angles);
  var_6 = var_1.origin - self getEye();
  var_7 = vectordot(var_6, var_5);

  if(var_7 > 46) {
    return 0;
  }

  var_6 = self.origin - var_1.origin;
  var_8 = vectordot(var_6, var_5);

  if(var_8 > 46) {
    return 0;
  }

  if(var_2.basename == "at_mine_ap_mp" || istrue(var_1.triggeredbyplayer)) {
    if(var_7 >= 0) {
      var_9 = var_0 getstance();

      if(var_9 == "prone") {
        var_4 = int(min(var_4, 35));
      } else if(var_9 == "crouch") {
        var_4 = int(min(var_4, 55));
      }
    }
  }

  return var_4;
}

function at_mine_cleanup_danger_icon_ent(var_0) {
  var_0 endon("death");
  self waittill("death");
  var_0 delete();
}

function remotedetonatethink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("remote_detonate", var_0);
    thread at_mine_explode_from_player_trigger(var_0);
  }
}

function remotedefusesetup() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var_0 = &"PERKS/REMOTE_DEFUSE_HINT";
  var_1 = 0;
  self.useobj = scripts\cp\utility::createhintobject(self.origin + anglestoup(self.angles) * 7, "HINT_BUTTON", undefined, var_0, var_1, undefined, "show", 250, 160, 200, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(var_3 in level.players) {
    self.useobj disableplayeruse(var_3);
  }

  thread defusethink();
  thread defuseusemonitoring();

  for(;;) {
    self waittill("defused", var_3);

    if(isPlayer(var_3)) {
      thread at_mine_explode_from_player_trigger(var_3);
    }
  }
}

function defuseusemonitoring() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    wait 0.1;

    foreach(var_1 in level.players) {
      if(var_1.team == self.team || !var_1 scripts\cp\utility::_hasperk("specialty_remote_defuse")) {
        self.useobj disableplayeruse(var_1);
        continue;
      }

      self.useobj enableplayeruse(var_1);
    }
  }
}

function defusethink() {
  self endon("restarting_physics");
  var_0 = self.useobj;
  var_1 = undefined;
  jumpiffalse(istrue(level.gameended) && !isDefined(var_0)) LOC_00000022;
  return;
}