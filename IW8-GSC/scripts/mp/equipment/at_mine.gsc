/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\at_mine.gsc
***********************************************/

function at_mine_init() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_at_mine", 1);
  var0.radius = 100;
  var0.triggercallback = &at_mine_vehicle_trigger;
}

function at_mine_use(var0) {
  self endon("disconnect");
  var0 endon("death");

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    var0.hasruggedeqp = 1;
  }

  var0 scripts\cp_mp\ent_manager::registerspawn(2, &deletemine);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var0);
  thread at_mine_watch_game_end();
  var1 = spawnStruct();
  var1.throwspeedforward = 100;
  var1.throwspeedup = -50;
  var1.castdivisions = 3;
  var1.castmaxtime = 0.5;
  var1.castdetail = 1;
  var1.plantmaxtime = 0.5;
  var1.plantmaxroll = 15;
  var1.plantmindistbeloweye = 12;
  var1.plantmaxdistbelowownerfeet = 20;
  var1.plantmindisteyetofeet = 45;
  var1.plantnormalcos = 0.342;
  var0 setscriptablepartstate("visibility", "show", 0);
  var2 = spawnStruct();
  var2.endonstring = "mine_destroyed";
  var2.ref_133ca = 1;
  var0 thread scripts\mp\movers::handle_moving_platform_touch(var2);
  var0 waittill("missile_stuck", var3);

  if(isDefined(var3)) {
    if(isent(var3) && tugofwar_tank(var3)) {
      var0.origin += (0, 0, 1.6);
      var2.ref_123b4 = 1;
      var0 method_87bb(1);
    }

    var0 linkTo(var3);
  }

  thread at_mine_plant(var0);
}

function tugofwar_tank(var0) {
  if(isDefined(level.ref_145f1)) {
    foreach(var2 in level.ref_145f1.ref_13c8d) {
      if(var2 == var0) {
        return true;
      }

      if(isDefined(var2.wz_tease) && var2.wz_tease == var0) {
        return true;
      }
    }
  }

  return false;
}

function at_mine_update_danger_zone() {
  if(istrue(level.iscacprimaryweapongroup)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(self.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

function at_mine_plant(var0) {
  var0 endon("mine_destroyed");
  var0 endon("death");
  var0 setotherent(self);
  var0 setentityowner(self);
  var0 missilethermal();
  var0 missileoutline();
  var0 setnodeploy(1);
  var0 setscriptablepartstate("plant", "active", 0);
  self setscriptablepartstate("equipATMineFXView", "plant", 0);
  scripts\mp\weapons::onequipmentplanted(var0, "equip_at_mine", &at_mine_delete);
  thread scripts\mp\weapons::monitordisownedequipment(self, var0);
  var0 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var0.owner, 1);
  var0 thread scripts\mp\weapons::minedamagemonitor();
  thread at_mine_watch_detonate();
  var0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&at_mine_empapplied);
  at_mine_update_danger_zone(var0);
  wait 0.75;

  if(istrue(var0.ref_13bff)) {
    thread carriable_detonate_propane();
  }

  wait 0.75;
  var0 thread scripts\mp\equipment_interact::remoteinteractsetup(&at_mine_explode_from_player_trigger, 1, 1);
  var0 setscriptablepartstate("arm", "active", 0);
  thread at_mine_watch_trigger();
  var0 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  thread scripts\mp\weapons::outlineequipmentforowner(var0);
  var0.headiconid = var0 scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
}

function at_mine_explode_from_player_trigger(var0) {
  thread at_mine_delete(5);

  if(!isDefined(var0)) {
    var0 = self.owner;
  }

  self setentityowner(var0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "fromPlayer", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
}

function at_mine_explode_from_vehicle_trigger(var0) {
  var0 dodamage(200, self.origin, self.owner, self, "MOD_EXPLOSIVE", getcompleteweaponname("at_mine_mp"));
  var1 = var0 scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, getcompleteweaponname("at_mine_mp"), self, "MOD_EXPLOSIVE");
  thread at_mine_explode_from_vehicle_trigger_internal();
  waitframe();

  if(isDefined(var0)) {
    var0 scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(var1);
    return;
  }
}

function at_mine_explode_from_vehicle_trigger_internal() {
  thread at_mine_delete(5);
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromVehicle", 0);
}

function at_mine_explode_from_notify(var0) {
  thread at_mine_delete(5);
  self setentityowner(var0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromDamage", 0);
}

function at_mine_destroy(var0) {
  thread at_mine_delete(5);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

function at_mine_delete(var0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setscriptablepartstate("hack_usable", "off");
  self setCanDamage(0);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  if(isDefined(self.owner)) {
    self.owner scripts\mp\weapons::removeequip(self);
  }

  if(isDefined(self.dangericonent)) {
    self.dangericonent delete();
  }

  var1 = self getlinkedchildren();

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      if(isDefined(var3) && isDefined(var3.equipmentref) && var3.equipmentref == "equip_claymore" && !istrue(var3.exploding)) {
        var3 thread scripts\mp\equipment\claymore::claymore_destroy();
      }
    }
  }

  if(isDefined(var0)) {
    wait var0;
  }

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

function carriable_detonate_propane() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.carriable_watch_for_physics_collison = (0, 0, 0);
  var0 = 0.2;

  for(;;) {
    var1 = self.origin;
    wait var0;
    self.carriable_watch_for_physics_collison = 1 / var0 * (self.origin - var1);
  }
}

function trial_ui_set_combo_bar_combo(var0) {
  return isDefined(var0) && isDefined(var0.carriable_watch_for_physics_collison) && length2dsquared(var0.carriable_watch_for_physics_collison) > 0.01;
}

function at_mine_watch_trigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  for(;;) {
    self waittill("trigger_grenade", var0);

    foreach(var2 in var0) {
      if(var2.classname == "script_vehicle") {
        if(var2 scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_isfriendlytomine(self)) {
          continue;
        }

        if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(var2, self)) {
          continue;
        }

        scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(var2, self);
        break;
      }

      if(var2.classname == "agent" || var2.classname == "player") {
        if(!isPlayer(var2) && !isagent(var2)) {
          continue;
        }

        if(isDefined(var2.vehicle)) {
          continue;
        }

        if(!scripts\mp\utility\player::isreallyalive(var2)) {
          continue;
        }

        if(var2 scripts\mp\gametypes\br_public::ref_125ec()) {
          continue;
        }

        thread at_mine_player_trigger(var2);
        break;
      }
    }
  }
}

function at_mine_player_trigger(var0) {
  self endon("mine_destroyed");
  self endon("death");
  self notify("mine_triggered");
  self.triggeredbyplayer = 1;
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  var1 = scripts\mp\utility\weapon::_launchgrenade("at_mine_ap_mp", self.origin, (0, 0, 0), 100, 1);
  var1 linkTo(self);
  thread at_mine_cleanup_danger_icon_ent(var1);
  var1.weapon_object = getcompleteweaponname("at_mine_ap_mp");
  self.dangericonent = var1;
  scripts\mp\weapons::explosivetrigger(var0, 0.1);
  thread at_mine_watch_flight();
}

function at_mine_vehicle_trigger(var0, var1) {
  var1 endon("mine_destroyed");
  var1 endon("death");
  var1.owner endon("disconnect");
  var1 notify("mine_triggered");
  var1 scripts\mp\weapons::makeexplosiveunusuabletag();
  var1 setscriptablepartstate("arm", "neutral", 0);
  var1 setscriptablepartstate("trigger", "active", 0);
  wait 0.2;
  thread at_mine_explode_from_vehicle_trigger(var1);
}

function at_mine_watch_flight_mover(var0) {
  self endon("death");
  self.grenade scripts\engine\utility::ref_143ba(var0, "death", "mine_destroyed");

  if(isDefined(self.grenade)) {
    self moveTo(self.origin, 0.05, 0, 0);
  }

  while(isDefined(self.grenade)) {
    waitframe();
  }

  self delete();
}

function deletemine() {
  at_mine_delete(0);
}

function at_mine_watch_flight() {
  self endon("mine_destroyed");
  self endon("death");
  var0 = 0.8;

  if(var0 > 0) {
    var1 = (0, 0, 1);
    var2 = self.origin + var1 * 64;
    var3 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
    var4 = scripts\mp\utility\equipment::get_mine_ignore_list();
    var5 = self.origin;
    var6 = var2;
    var7 = physics_raycast(var5, var6, var3, var4, 0, "physicsquery_closest", 1);

    if(isDefined(var7) && var7.size > 0) {
      var8 = vectordot(var7[0]["position"] - var5, var1);
      var8 = max(0, var8 - 1);
      var0 = 0;
      var2 = self.origin;

      if(var8 > 0) {
        var0 = var8 / 64 * 0.8;
        var2 = self.origin + var1 * var8;
      }
    }

    if(trial_ui_set_combo_bar_combo(self)) {
      var2 += self.carriable_watch_for_physics_collison * var0;
    }

    if(var0 > 0) {
      var9 = var0;
      var10 = var9 * 0.81;

      if(trial_ui_set_combo_bar_combo(self)) {
        var10 *= 0.25;
      }

      var9 -= var10;
      var11 = 0;

      if(var9 > 0) {
        var11 = var9 * 0;
      }

      var12 = spawn("script_model", self.origin);
      var12.angles = vectortoangles(anglesToForward(self.angles) * (1, 1, 0));
      var12 setModel("tag_origin");
      self.mover = var12;
      var12.grenade = self;
      self linkTo(var12, "tag_origin", (0, 0, 0), (0, 0, 0));
      var12 moveTo(var2, var0, var11, var10);
      thread at_mine_watch_flight_mover(var12);
      thread at_mine_watch_flight_effects(var0);
      childthread scripts\mp\utility\equipment::ref_14444();
      scripts\engine\utility::ref_143b9(var0, "collision_with_platform");
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

function at_mine_empapplied(var0) {
  var1 = var0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1))) {
    var1 notify("destroyed_equipment");
    var1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  if(isPlayer(var1)) {
    var1 scripts\mp\damagefeedback::updatedamagefeedback("");
  }

  thread at_mine_destroy();
}

function at_mine_watch_detonate() {
  self endon("death");
  self waittill("detonateExplosive", var0);

  if(isDefined(var0)) {
    thread at_mine_explode_from_notify(var0);
    return;
  }

  if(isDefined(self.owner)) {
    thread at_mine_explode_from_notify(self.owner);
    return;
  }

  thread at_mine_destroy();
}

function at_mine_watch_game_end() {
  self endon("mine_destroyed");
  self endon("death");
  level scripts\engine\utility::ref_143a5("game_ended", "bro_shot_start");
  thread at_mine_destroy();
}

function at_mine_damage_vehicle_manually(var0) {
  var0 dodamage(200, self.origin, self.owner, self, "MOD_EXPLOSIVE", getcompleteweaponname("at_mine_mp"));
  var1 = var0 scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, getcompleteweaponname("at_mine_mp"), self, "MOD_EXPLOSIVE");
  waitframe();

  if(isDefined(var0)) {
    var0 scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(var1);
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
      } else if(var9 == "crouch" || self issprintsliding()) {
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

function at_mine_onownerchanged(var0) {
  self setscriptablepartstate("hacked", "active", 0);
  at_mine_update_danger_zone();
  thread scripts\mp\weapons::monitordisownedequipment(self.owner, self);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
}