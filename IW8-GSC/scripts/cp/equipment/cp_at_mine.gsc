/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_at_mine.gsc
***********************************************/

function at_mine_use(var0) {
  self endon("death");
  self endon("disconnect");
  var0 endon("death");
  var0.set_car_collision = self.name;
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var0);
  thread at_mine_watch_game_end();
  var0 setscriptablepartstate("visibility", "show", 0);
  var0 waittill("missile_stuck", var1);

  if(isDefined(var1)) {
    var0 linkTo(var1);
  }

  thread at_mine_plant(var0);
}

function at_mine_plant(var0) {
  var0 endon("mine_destroyed");
  var0 endon("death");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  if(isPlayer(self)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "use_atmine");
    var0 setotherent(self);
    var0 setentityowner(self);
  }

  var0 missilethermal();
  var0 missileoutline();
  var0 setnodeploy(1);
  var0 setscriptablepartstate("plant", "active", 0);
  var0 enableplayermarks("equipment");

  if(isPlayer(self)) {
    self setscriptablepartstate("equipATMineFXView", "plant", 0);
    scripts\cp\cp_weapon::onlethalequipmentplanted(var0, "equip_at_mine", 1);
    thread scripts\cp\cp_weapon::monitordisownedequipment(self, var0);
  } else {
    level thread scripts\cp\cp_weapon::bankingoverlimitwillendot(var0);
  }

  var0 thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1);
  var0 thread scripts\cp\cp_weapon::minedamagemonitor();
  thread at_mine_watch_detonate();
  thread at_mine_watch_emp();
  thread remotedefusesetup();
  thread remotedetonatethink();
  wait 1;
  var1 = at_mine_create_player_trigger(var0);
  var0.playertrigger = var1;
  var0 thread scripts\cp\cp_weapon::minedeletetrigger(var1);
  thread at_mine_watch_player_trigger(var0);
  thread at_mine_watch_vehicle_trigger();
}

function at_mine_explode_from_player_trigger(var0) {
  thread at_mine_delete(1);

  if(isDefined(var0)) {
    self setentityowner(var0);
    self clearscriptabledamageowner();
  }

  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "fromPlayer", 0);
}

function at_mine_explode_from_vehicle_trigger(var0) {
  if(isDefined(var0)) {
    thread at_mine_damage_manually(self.owner, var0);
  }

  thread at_mine_delete(1);
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromVehicle", 0);
}

function at_mine_explode_from_notify(var0) {
  thread at_mine_delete(1);
  self setentityowner(var0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromDamage", 0);
}

function at_mine_destroy(var0) {
  thread at_mine_delete(1);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

function at_mine_delete(var0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self.exploding = 1;
  var1 = self.owner;

  if(isDefined(self.owner) && isDefined(var1.plantedlethalequip)) {
    var1.plantedlethalequip = scripts\engine\utility::array_remove(var1.plantedlethalequip, self);
  }

  if(isDefined(self.dangericonent)) {
    self.dangericonent delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  if(isDefined(var0)) {
    wait var0;
  }

  level notify("grenade_exploded_during_stealth", self.origin, "at_mine_mp", self.set_car_collision);
  self delete();
}

function at_mine_create_player_trigger() {
  var0 = spawn("trigger_rotatable_radius", self.origin, 0, 100, 50);
  var0.angles = self.angles;
  var0 enablelinkTo();
  var0 linkTo(self);
  var0 hide();
  var0.mine = self;
  return var0;
}

function at_mine_watch_player_trigger(var0) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  var1 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);

  for(;;) {
    var0 waittill("trigger", var2);

    if(!isDefined(var2)) {
      continue;
    }

    if(!isPlayer(var2) && !isagent(var2)) {
      continue;
    }

    if(isDefined(var2.vehicle)) {
      continue;
    }

    if(!var2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var2))) {
      continue;
    }

    thread at_mine_player_trigger(var2);
  }
}

function at_mine_player_trigger(var0) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  self.triggeredbyplayer = 1;
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  var1 = scripts\cp\utility::_launchgrenade("at_mine_ap_mp", self.origin, (0, 0, 0), 100, 1);
  var1 linkTo(self);
  thread at_mine_cleanup_danger_icon_ent(var1);
  var1.weapon_object = getcompleteweaponname("at_mine_ap_mp");
  self.dangericonent = var1;
  scripts\cp\cp_weapon::explosivetrigger(var0, 0.1);
  thread at_mine_watch_flight();
}

function at_mine_watch_vehicle_trigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  var0 = [(0, 0, 0), (60, 0, 0), (-60, 0, 0)];
  var1 = 75;
  var2 = var1 * var1;
  var3 = 30;
  var4 = [(0, 0, 0), (22, 0, 0), (-22, 0, 0)];
  var5 = 96;
  var6 = var5 * var5;
  var7 = 15;

  for(;;) {
    var8 = getactivebradleys();

    if(isDefined(var8)) {
      foreach(var10 in var8) {
        if(!isDefined(var10)) {
          continue;
        }

        if(level.teambased) {
          if(var10.team == self.owner.team) {
            continue;
          }
        } else if(isDefined(var10.owner) && var10.owner == self.owner) {
          continue;
        }

        var11 = anglestoaxis(var10.angles);

        foreach(var13 in var0) {
          var14 = var10.origin;
          var14 += var11["right"] * var13[0];
          var14 += var11["forward"] * var13[1];
          var14 += var11["up"] * var13[2];
          var15 = self.origin - var14;
          var16 = vectordot(var15, var11["up"]);

          if(abs(var16) > var3) {
            continue;
          }

          var17 = var15 - var11["up"] * var16;

          if(lengthsquared(var17) > var2) {
            continue;
          }

          thread at_mine_vehicle_trigger(var10);
          return;
        }
      }
    }

    var20 = level.assaultdrones;

    if(isDefined(var20)) {
      foreach(var22 in var20) {
        if(!isDefined(var22)) {
          continue;
        }

        if(!isDefined(var22.streakname) || var22.streakname != "pac_sentry") {
          continue;
        }

        if(isDefined(var22.owner) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var22.owner, self.owner))) {
          continue;
        }

        var11 = anglestoaxis(var22.angles);

        foreach(var13 in var4) {
          var24 = var22.origin;
          var24 += var11["right"] * var13[0];
          var24 += var11["forward"] * var13[1];
          var24 += var11["up"] * var13[2];
          var15 = self.origin - var24;
          var16 = vectordot(var15, var11["up"]);

          if(abs(var16) > var7) {
            continue;
          }

          var17 = var15 - var11["up"] * var16;

          if(lengthsquared(var17) > var6) {
            continue;
          }

          thread at_mine_vehicle_trigger(var22);
          return;
        }
      }
    }

    waitframe();
  }
}

function getactivebradleys() {
  var0 = [];

  foreach(var2 in level.vehicle.instances) {
    foreach(var4 in var2) {
      var0 = var4;
    }
  }

  if(isDefined(level.bradley)) {
    var0 = scripts\engine\utility::array_combine(var0, level.bradley.activevehicles["total"]);
  }

  if(var0.size == 0) {
    return undefined;
  }

  return var0;
}

function at_mine_vehicle_trigger(var0) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  wait 0.2;
  thread at_mine_explode_from_vehicle_trigger(var0);
}

function at_mine_watch_flight_mover(var0) {
  self endon("death");
  self.grenade scripts\engine\utility::ref_143ba(var0, "death", "mine_destroyed");

  if(isDefined(self.grenade)) {
    self moveTo(self.origin, 0.05, 0, 0);
  }

  wait 2;
  self delete();
}

function at_mine_watch_flight() {
  self endon("mine_destroyed");
  self endon("death");
  var0 = 0.7;

  if(var0 > 0) {
    var1 = (0, 0, 1);
    var2 = self.origin + var1 * 64;
    var3 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
    var4 = self.origin;
    var5 = var2;
    var6 = physics_raycast(var4, var5, var3, self, 0, "physicsquery_closest", 1);

    if(isDefined(var6) && var6.size > 0) {
      var7 = vectordot(var6[0]["position"] - var4, var1);
      var7 = max(0, var7 - 1);
      var0 = 0;
      var2 = self.origin;

      if(var7 > 0) {
        var0 = var7 / 64 * 0.7;
        var2 = self.origin + var1 * var7;
      }
    }

    if(var0 > 0) {
      var8 = var0;
      var9 = var8 * 0.93;
      var8 -= var9;
      var10 = 0;

      if(var8 > 0) {
        var10 = var8 * 0;
      }

      var11 = spawn("script_model", self.origin);
      var11.angles = vectortoangles(anglesToForward(self.angles) * (1, 1, 0));
      var11 setModel("tag_origin");
      self.mover = var11;
      var11.grenade = self;
      self linkTo(var11, "tag_origin", (0, 0, 0), (0, 0, 0));
      var11 moveTo(var2, var0, var10, var9);
      thread at_mine_watch_flight_mover(var11);
      thread at_mine_watch_flight_effects(var0);
      wait var0;
      thread at_mine_explode_from_player_trigger();
      return;
    }

    return;
  }
}

function at_mine_watch_flight_effects(var0) {
  self endon("mine_destroyed");
  self endon("death");
  self setscriptablepartstate("launch", "active", 0);
}

function at_mine_watch_emp() {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    self waittill("emp_applied", var0);
    var1 = var0.attacker;

    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1))) {
      var1 notify("destroyed_equipment");

      if(isPlayer(var1)) {
        var1 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
      }

      thread at_mine_destroy();
    }
  }
}

function at_mine_watch_detonate() {
  self endon("death");
  self.owner endon("disconnect");
  var0 = self.owner;
  self waittill("detonateExplosive", var1);

  if(isDefined(var1)) {
    thread at_mine_explode_from_notify(var1);
    return;
  }

  thread at_mine_explode_from_notify(var0);
}

function at_mine_watch_game_end() {
  self endon("mine_destroyed");
  self endon("death");
  level scripts\engine\utility::ref_143a5("game_ended", "bro_shot_start");
  thread at_mine_destroy();
}

function at_mine_damage_manually(var0, var1) {
  var1 endon("death");
  var2 = getcompleteweaponname("at_mine_mp");
  waitframe();
  var3 = 200;

  if(isDefined(var1.mine_damage_override)) {
    var3 = var1.mine_damage_override;
  }

  if(isDefined(var0) && isDefined(self)) {
    var1 dodamage(var3, self.origin, var0, self, "MOD_EXPLOSIVE", var2);
    var1 notify("damage", var3, self.origin, var0, self, "MOD_EXPLOSIVE", var2);
    return;
  }
}

function at_mine_modified_damage(var0, var1, var2, var3, var4) {
  if(!isDefined(var1)) {
    return var4;
  }

  if(var3 != "MOD_EXPLOSIVE") {
    return var4;
  }

  if(!isDefined(var2)) {
    return var4;
  }

  if(nullweapon(var2)) {
    return var4;
  }

  if(var2.basename != "at_mine_mp" && var2.basename != "at_mine_ap_mp") {
    return var4;
  }

  var5 = anglestoup(var1.angles);
  var6 = var1.origin - self getEye();
  var7 = vectordot(var6, var5);

  if(var7 > 46) {
    return 0;
  }

  var6 = self.origin - var1.origin;
  var8 = vectordot(var6, var5);

  if(var8 > 46) {
    return 0;
  }

  if(var2.basename == "at_mine_ap_mp" || istrue(var1.triggeredbyplayer)) {
    if(var7 >= 0) {
      var9 = var0 getstance();

      if(var9 == "prone") {
        var4 = int(min(var4, 35));
      } else if(var9 == "crouch") {
        var4 = int(min(var4, 55));
      }
    }
  }

  return var4;
}

function at_mine_cleanup_danger_icon_ent(var0) {
  var0 endon("death");
  self waittill("death");
  var0 delete();
}

function remotedetonatethink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("remote_detonate", var0);
    thread at_mine_explode_from_player_trigger(var0);
  }
}

function remotedefusesetup() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var0 = &"PERKS/REMOTE_DEFUSE_HINT";
  var1 = 0;
  self.useobj = scripts\cp\utility::createhintobject(self.origin + anglestoup(self.angles) * 7, "HINT_BUTTON", undefined, var0, var1, undefined, "show", 250, 160, 200, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(var3 in level.players) {
    self.useobj disableplayeruse(var3);
  }

  thread defusethink();
  thread defuseusemonitoring();

  for(;;) {
    self waittill("defused", var3);

    if(isPlayer(var3)) {
      thread at_mine_explode_from_player_trigger(var3);
    }
  }
}

function defuseusemonitoring() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    wait 0.1;

    foreach(var1 in level.players) {
      if(var1.team == self.team || !var1 scripts\cp\utility::_hasperk("specialty_remote_defuse")) {
        self.useobj disableplayeruse(var1);
        continue;
      }

      self.useobj enableplayeruse(var1);
    }
  }
}

function defusethink() {
  self endon("restarting_physics");
  var0 = self.useobj;
  var1 = undefined;
  jumpiffalse(istrue(level.gameended) && !isDefined(var0)) LOC_00000022;
  return;
}