/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\at_mine.gsc
***********************************************/

function at_mine_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_at_mine", 1);
  var_0.radius = 100;
  var_0.triggercallback = &at_mine_vehicle_trigger;
}

function at_mine_use(var_0) {
  self endon("disconnect");
  var_0 endon("death");

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    var_0.hasruggedeqp = 1;
  }

  var_0 scripts\cp_mp\ent_manager::registerspawn(2, &deletemine);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  thread at_mine_watch_game_end();
  var_1 = spawnStruct();
  var_1.throwspeedforward = 100;
  var_1.throwspeedup = -50;
  var_1.castdivisions = 3;
  var_1.castmaxtime = 0.5;
  var_1.castdetail = 1;
  var_1.plantmaxtime = 0.5;
  var_1.plantmaxroll = 15;
  var_1.plantmindistbeloweye = 12;
  var_1.plantmaxdistbelowownerfeet = 20;
  var_1.plantmindisteyetofeet = 45;
  var_1.plantnormalcos = 0.342;
  var_0 setscriptablepartstate("visibility", "show", 0);
  var_2 = spawnStruct();
  var_2.endonstring = "mine_destroyed";
  var_2.ref_133CA = 1;
  var_0 thread scripts\mp\movers::handle_moving_platform_touch(var_2);
  var_0 waittill("missile_stuck", var_3);

  if(isDefined(var_3)) {
    if(isent(var_3) && tugofwar_tank(var_3)) {
      var_0.origin += (0, 0, 1.6);
      var_2.ref_123B4 = 1;
      var_0 method_87bb(1);
    }

    var_0 linkTo(var_3);
  }

  thread at_mine_plant(var_0);
}

function tugofwar_tank(var_0) {
  if(isDefined(level.ref_145F1)) {
    foreach(var_2 in level.ref_145F1.ref_13C8D) {
      if(var_2 == var_0) {
        return true;
      }

      if(isDefined(var_2.wz_tease) && var_2.wz_tease == var_0) {
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

function at_mine_plant(var_0) {
  var_0 endon("mine_destroyed");
  var_0 endon("death");
  var_0 setotherent(self);
  var_0 setentityowner(self);
  var_0 missilethermal();
  var_0 missileoutline();
  var_0 setnodeploy(1);
  var_0 setscriptablepartstate("plant", "active", 0);
  self setscriptablepartstate("equipATMineFXView", "plant", 0);
  scripts\mp\weapons::onequipmentplanted(var_0, "equip_at_mine", &at_mine_delete);
  thread scripts\mp\weapons::monitordisownedequipment(self, var_0);
  var_0 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_0.owner, 1);
  var_0 thread scripts\mp\weapons::minedamagemonitor();
  thread at_mine_watch_detonate();
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&at_mine_empapplied);
  at_mine_update_danger_zone(var_0);
  wait 0.75;

  if(istrue(var_0.ref_13BFF)) {
    thread carriable_detonate_propane();
  }

  wait 0.75;
  var_0 thread scripts\mp\equipment_interact::remoteinteractsetup(&at_mine_explode_from_player_trigger, 1, 1);
  var_0 setscriptablepartstate("arm", "active", 0);
  thread at_mine_watch_trigger();
  var_0 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  thread scripts\mp\weapons::outlineequipmentforowner(var_0);
  var_0.headiconid = var_0 scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
}

function at_mine_explode_from_player_trigger(var_0) {
  thread at_mine_delete(5);

  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  self setentityowner(var_0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "fromPlayer", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
}

function at_mine_explode_from_vehicle_trigger(var_0) {
  var_0 dodamage(200, self.origin, self.owner, self, "MOD_EXPLOSIVE", getcompleteweaponname("at_mine_mp"));
  var_1 = var_0 scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, getcompleteweaponname("at_mine_mp"), self, "MOD_EXPLOSIVE");
  thread at_mine_explode_from_vehicle_trigger_internal();
  waitframe();

  if(isDefined(var_0)) {
    var_0 scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(var_1);
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

function at_mine_explode_from_notify(var_0) {
  thread at_mine_delete(5);
  self setentityowner(var_0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromDamage", 0);
}

function at_mine_destroy(var_0) {
  thread at_mine_delete(5);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

function at_mine_delete(var_0) {
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

  var_1 = self getlinkedchildren();

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3) && isDefined(var_3.equipmentref) && var_3.equipmentref == "equip_claymore" && !istrue(var_3.exploding)) {
        var_3 thread scripts\mp\equipment\claymore::claymore_destroy();
      }
    }
  }

  if(isDefined(var_0)) {
    wait var_0;
  }

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

function carriable_detonate_propane() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.carriable_watch_for_physics_collison = (0, 0, 0);
  var_0 = 0.2;

  for(;;) {
    var_1 = self.origin;
    wait var_0;
    self.carriable_watch_for_physics_collison = 1 / var_0 * (self.origin - var_1);
  }
}

function trial_ui_set_combo_bar_combo(var_0) {
  return isDefined(var_0) && isDefined(var_0.carriable_watch_for_physics_collison) && length2dsquared(var_0.carriable_watch_for_physics_collison) > 0.01;
}

function at_mine_watch_trigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  for(;;) {
    self waittill("trigger_grenade", var_0);

    foreach(var_2 in var_0) {
      if(var_2.classname == "script_vehicle") {
        if(var_2 scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_isfriendlytomine(self)) {
          continue;
        }

        if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(var_2, self)) {
          continue;
        }

        scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(var_2, self);
        break;
      }

      if(var_2.classname == "agent" || var_2.classname == "player") {
        if(!isPlayer(var_2) && !isagent(var_2)) {
          continue;
        }

        if(isDefined(var_2.vehicle)) {
          continue;
        }

        if(!scripts\mp\utility\player::isreallyalive(var_2)) {
          continue;
        }

        if(var_2 scripts\mp\gametypes\br_public::ref_125EC()) {
          continue;
        }

        thread at_mine_player_trigger(var_2);
        break;
      }
    }
  }
}

function at_mine_player_trigger(var_0) {
  self endon("mine_destroyed");
  self endon("death");
  self notify("mine_triggered");
  self.triggeredbyplayer = 1;
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  var_1 = scripts\mp\utility\weapon::_launchgrenade("at_mine_ap_mp", self.origin, (0, 0, 0), 100, 1);
  var_1 linkTo(self);
  thread at_mine_cleanup_danger_icon_ent(var_1);
  var_1.weapon_object = getcompleteweaponname("at_mine_ap_mp");
  self.dangericonent = var_1;
  scripts\mp\weapons::explosivetrigger(var_0, 0.1);
  thread at_mine_watch_flight();
}

function at_mine_vehicle_trigger(var_0, var_1) {
  var_1 endon("mine_destroyed");
  var_1 endon("death");
  var_1.owner endon("disconnect");
  var_1 notify("mine_triggered");
  var_1 scripts\mp\weapons::makeexplosiveunusuabletag();
  var_1 setscriptablepartstate("arm", "neutral", 0);
  var_1 setscriptablepartstate("trigger", "active", 0);
  wait 0.2;
  thread at_mine_explode_from_vehicle_trigger(var_1);
}

function at_mine_watch_flight_mover(var_0) {
  self endon("death");
  self.grenade scripts\engine\utility::ref_143BA(var_0, "death", "mine_destroyed");

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
  var_0 = 0.8;

  if(var_0 > 0) {
    var_1 = (0, 0, 1);
    var_2 = self.origin + var_1 * 64;
    var_3 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
    var_4 = scripts\mp\utility\equipment::get_mine_ignore_list();
    var_5 = self.origin;
    var_6 = var_2;
    var_7 = physics_raycast(var_5, var_6, var_3, var_4, 0, "physicsquery_closest", 1);

    if(isDefined(var_7) && var_7.size > 0) {
      var_8 = vectordot(var_7[0]["position"] - var_5, var_1);
      var_8 = max(0, var_8 - 1);
      var_0 = 0;
      var_2 = self.origin;

      if(var_8 > 0) {
        var_0 = var_8 / 64 * 0.8;
        var_2 = self.origin + var_1 * var_8;
      }
    }

    if(trial_ui_set_combo_bar_combo(self)) {
      var_2 += self.carriable_watch_for_physics_collison * var_0;
    }

    if(var_0 > 0) {
      var_9 = var_0;
      var_10 = var_9 * 0.81;

      if(trial_ui_set_combo_bar_combo(self)) {
        var_10 *= 0.25;
      }

      var_9 -= var_10;
      var_11 = 0;

      if(var_9 > 0) {
        var_11 = var_9 * 0;
      }

      var_12 = spawn("script_model", self.origin);
      var_12.angles = vectortoangles(anglesToForward(self.angles) * (1, 1, 0));
      var_12 setModel("tag_origin");
      self.mover = var_12;
      var_12.grenade = self;
      self linkTo(var_12, "tag_origin", (0, 0, 0), (0, 0, 0));
      var_12 moveTo(var_2, var_0, var_11, var_10);
      thread at_mine_watch_flight_mover(var_12);
      thread at_mine_watch_flight_effects(var_0);
      childthread scripts\mp\utility\equipment::ref_14444();
      scripts\engine\utility::ref_143B9(var_0, "collision_with_platform");
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

function at_mine_empapplied(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 notify("destroyed_equipment");
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  if(isPlayer(var_1)) {
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("");
  }

  thread at_mine_destroy();
}

function at_mine_watch_detonate() {
  self endon("death");
  self waittill("detonateExplosive", var_0);

  if(isDefined(var_0)) {
    thread at_mine_explode_from_notify(var_0);
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
  level scripts\engine\utility::ref_143A5("game_ended", "bro_shot_start");
  thread at_mine_destroy();
}

function at_mine_damage_vehicle_manually(var_0) {
  var_0 dodamage(200, self.origin, self.owner, self, "MOD_EXPLOSIVE", getcompleteweaponname("at_mine_mp"));
  var_1 = var_0 scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, getcompleteweaponname("at_mine_mp"), self, "MOD_EXPLOSIVE");
  waitframe();

  if(isDefined(var_0)) {
    var_0 scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(var_1);
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
      } else if(var_9 == "crouch" || self issprintsliding()) {
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

function at_mine_onownerchanged(var_0) {
  self setscriptablepartstate("hacked", "active", 0);
  at_mine_update_danger_zone();
  thread scripts\mp\weapons::monitordisownedequipment(self.owner, self);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
}