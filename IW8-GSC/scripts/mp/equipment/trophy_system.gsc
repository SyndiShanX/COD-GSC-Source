/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\trophy_system.gsc
**************************************************/

function trophy_init() {
  var_0 = spawnStruct();
  var_0.tags = [];
  var_0.tags[0] = "tag_barrel_1";
  var_0.tags[1] = "tag_barrel_2";
  var_0.tags[3] = "tag_barrel_3";
  var_0.timeout = getdvarfloat("scr_trophy_timeoutOverride", 45);
  level.trophy = var_0;
}

function trophy_set(var_0, var_1) {
  trophy_clearstored();
  trophy_populatestored();
}

function trophy_onsuperset() {}

function trophy_unset(var_0, var_1) {
  trophy_clearstored();
}

function trophy_used(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  scripts\mp\utility\print::printgameaction("trophy spawned", self);
  var_0 scripts\cp_mp\ent_manager::registerspawn(2, &sweeptrophy);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  thread trophy_hideandshowaftertime();
  thread ref_13DDC(var_0);
  var_0 waittill("missile_stuck", var_1);
  var_0 setotherent(self);
  var_0 setnodeploy(1);
  var_0.issuper = isDefined(self.super) && self.super.staticdata.weapon == "trophy_mp";
  var_0.superid = level.superglobals.staticsuperdata["super_trophy"].id;
  var_0.usedcount = 0;
  var_0.laststandweapondelay = self;
  var_2 = scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");

  if(var_2) {
    var_0.hasruggedeqp = 1;
  }

  if(!istrue(var_0.issuper)) {
    var_0.ammo = trophy_removestored();

    if(!isDefined(var_0.ammo)) {
      var_0.ammo = 3;
    }

    var_0 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  } else {
    var_0.ammo = 3;
  }

  scripts\mp\weapons::onequipmentplanted(var_0, "equip_trophy", &trophy_shutdownanddestroy);
  thread scripts\mp\weapons::monitordisownedequipment(self, var_0);
  var_0 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  var_0.explosion = trophy_createexplosion(var_0);
  var_3 = scripts\engine\utility::ter_op(var_2, 200, 100);
  var_4 = "hitequip";
  var_0 thread scripts\mp\damage::monitordamage(var_3, var_4, &trophy_handlefataldamage, &trophy_handledamage, 0);
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&trophy_applyempcallback);
  var_0 setscriptablepartstate("visibility", "show", 0);
  thread trophy_deploy();
}

function ref_13DDC(var_0) {
  self endon("death");
  self endon("missile_stuck");
  var_0 endon("disconnect");
  var_1 = scripts\engine\utility::ref_143B9(2, "touching_platform");

  if(var_1 == "timeout") {
    return;
  }

  var_2 = undefined;
  var_3 = tablesort(self.origin, 500, 500);
  GscBinSkip0(0x2e, var_3.size, self);
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

function trophy_deploy() {
  self endon("death");
  self setscriptablepartstate("effects", "activeLand");

  if(level.gametype == "br") {
    self.ignoreme = 1;
  }

  wait 0.1;
  thread ref_13DD5();
  wait 0.2;
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  thread trophy_watchprotection(45, 105625, &ref_13DDA, &trophy_protectionsuccessful);
  thread ref_13DDD();
  thread scripts\mp\equipment_interact::remoteinteractsetup(&trophy_remote_destroy, 1, 1);
  thread scripts\mp\perks\perk_equipmentping::runequipmentping();
}

function ref_13DD5() {
  self endon("death");
  self setscriptablepartstate("effects", "activeDeployStart");
  wait trophy_getdeployanimtime();
  self setscriptablepartstate("effects", "activeDeployEnd");
}

function trophy_hideandshowaftertime() {
  self endon("death");
  self endon("missile_stuck");
  var_0 = getdvarfloat("scr_trophy_proj_hide_duration", 0);
  self setscriptablepartstate("visibility", "hide", 0);
  wait var_0;
  self setscriptablepartstate("visibility", "show", 0);
}

function trophy_remote_destroy(var_0) {
  trophy_destroy(1);
}

function sweeptrophy() {
  thread trophy_delete(undefined, 0);
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

function trophy_destroy(var_0, var_1) {
  thread trophy_delete(var_0, 0.1, var_1);
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

function trophy_shutdownanddestroy(var_0, var_1) {
  thread trophy_delete(var_0, 2.6, var_1);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);
  wait 2.5;

  if(isDefined(self)) {
    self setscriptablepartstate("effects", "activeDestroyEnd", 0);
    return;
  }
}

function trophy_delete(var_0, var_1, var_2) {
  self notify("death");
  self setscriptablepartstate("hack_usable", "off");
  self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_trophy", self.usedcount, var_0, var_2);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var_2));
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(!istrue(self.issuper)) {
    self makeunusable();
    scripts\mp\weapons::makeexplosiveunusuabletag();
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.owner)) {
    self.owner notify("trophy_update", 0);
    self.owner scripts\mp\weapons::removeequip(self);
  }

  if(isDefined(var_1)) {
    wait var_1;
  }

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

function trophy_watchprotection(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isDefined(level.grenades)) {
    level.grenades = [];
  }

  if(!isDefined(level.missiles)) {
    level.missiles = [];
  }

  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  if(!isDefined(level.ref_123A9)) {
    level.ref_123A9 = [];
  }

  var_4 = trophy_castcontents();

  while([[var_2]]()) {
    var_5 = trophy_castorigin(var_0);
    var_6 = [];
    var_6 = level.grenades;
    var_6 = level.missiles;
    var_6 = level.mines;
    var_6 = level.projectilekillstreaks;
    var_6 = level.ref_123A9;
    var_7 = scripts\engine\utility::array_combine_multiple(var_6);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }

      if(istrue(var_9.exploding)) {
        continue;
      }

      if(trophy_checkignorelist(var_9)) {
        continue;
      }

      var_10 = var_9.owner;

      if(!isDefined(var_10) && isDefined(var_9.weapon_name) && weaponclass(var_9.weapon_name) == "grenade") {
        var_10 = getmissileowner(var_9);
      }

      var_11 = 1;

      if(var_11) {
        var_12 = self.owner;

        if(scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          var_12 = self;
        }

        if(isDefined(var_10) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_12, var_10))) {
          continue;
        }

        if(var_12 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(var_12.ref_13DF6) && isDefined(var_10.team) && var_12.ref_13DF6 == var_10.team) {
          continue;
        }
      } else if(var_9 == self) {
        continue;
      }

      if(distancesquared(var_9.origin, self.origin) > trophy_modifiedprotectiondistsqr(var_9, var_1)) {
        continue;
      }

      var_13 = physics_raycast(var_5, var_9.origin, var_4, [self, var_9], 0, "physicsquery_closest");

      if(isDefined(var_13) && var_13.size > 0) {
        continue;
      }

      self[[var_3]](var_9);
    }

    waitframe();
  }
}

function ref_13DDA() {
  return isDefined(self.owner);
}

function trophy_protectionsuccessful(var_0) {
  self.owner scripts\mp\killstreaks\killstreaks::givescorefortrophyblocks();
  self.owner thread scripts\mp\gamelogic::threadedsetweaponstatbyname("trophy_mp", 1, "hits");
  self.owner scripts\mp\utility\stats::incpersstat("trophySystemHits", 1);
  self.owner scripts\mp\supers::hide_plunderboxes("super_trophy");
  self.usedcount++;
  var_1 = var_0.origin;
  ref_119CE(var_0);
  ref_13DD6(var_0);
  var_2 = trophy_getbesttag(var_1);
  var_3 = trophy_getpartbytag(var_2);
  self setscriptablepartstate(var_3, "active", 0);
  var_4 = vectortoangles(self gettagorigin(var_2) - var_1);
  var_5 = combineangles(var_4, (-90, 0, 0));
  thread trophy_explode(self.explosion, var_1);
  self.ammo--;

  if(self.ammo <= 0) {
    thread trophy_shutdownanddestroy(undefined, 0);
    return;
  }
}

function ref_13DD6(var_0) {
  var_0 setCanDamage(0);
  var_0.exploding = 1;
  var_0 stopsounds();
  scripts\cp\vehicles\vehicle_compass_cp::ondestroyedbytrophy();
  trophy_notifytrophytargetowner(var_0, "trophy_mp", self.owner);
  ref_13DDB(var_0, var_0.owner, self.owner);

  if(!var_0 scripts\mp\equipment::ondestroyedbytrophy()) {
    if(isDefined(var_0.streakname) && var_0.streakname == "cruise_predator") {
      var_0 notify("trophy_blocked");
      return;
    }

    var_0 delete();
    return;
  }
}

function ref_13DDB(var_0, var_1, var_2) {
  if(!isDefined(var_0.equipmentref) || var_0.equipmentref != "equip_snapshot_grenade") {
    return;
  }

  if(!isDefined(var_0.owner) || !isDefined(self.owner)) {
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(var_1)) {
    return;
  }

  var_3 = var_2;
  var_4 = var_1.origin;
  var_5 = scripts\mp\equipment\snapshot_grenade::ref_13436(var_3, var_4);
  scripts\mp\equipment\snapshot_grenade::ref_13435(var_1, var_2, var_5);
}

function ref_13DDD() {
  self endon("death");
  ref_13DDE();
  thread trophy_shutdownanddestroy(undefined, 0);
}

function ref_13DDE() {
  level endon("game_ended");
  var_0 = level.trophy.timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
}

function trophy_handledamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_4;
  var_5 = scripts\mp\damage::handlemeleedamage(var_2, var_3, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_2, var_3, var_5);
  scripts\mp\weapons::equipmenthit(self.owner, var_1, var_2, var_3);
  return var_5;
}

function trophy_handlefataldamage(var_0) {
  var_1 = var_0.attacker;
  trophy_givepointsfordeath(var_1);
  thread trophy_destroy(var_1, 1);
}

function trophy_applyempcallback(var_0) {
  trophy_givepointsfordeath(var_0.victim, var_0.attacker);
  thread trophy_shutdownanddestroy(var_0.victim, var_0.attacker);
}

function trophy_pickup() {
  if(self.owner scripts\mp\equipment::hasequipment("equip_trophy")) {
    trophy_addstored(self.owner, self.ammo);
    return;
  }
}

function trophy_createexplosion(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.killcament = var_0;
  var_1.owner = var_0.owner;
  var_1.team = var_0.team;
  var_1.equipmentref = var_0.equipmentref;
  var_1.weapon_name = var_0.weapon_name;
  var_1 setotherent(var_1.owner);
  var_1 setentityowner(var_1.owner);
  var_1 setModel("trophy_system_mp_explode");
  var_1.explode1available = 1;
  thread trophy_cleanuponparentdeath(var_1, var_0);
  return var_1;
}

function trophy_explode(var_0, var_1) {
  self dontinterpolate();
  self.origin = var_0;
  self.angles = var_1;

  if(self.explode1available) {
    self setscriptablepartstate("explode1", "activeDirectional", 0);
    self.explode1available = 0;
    return;
  }

  self setscriptablepartstate("explode2", "activeDirectional", 0);
  self.explode1available = 1;
}

function trophy_castorigin(var_0) {
  return self.origin + anglestoup(self.angles) * var_0;
}

function trophy_castcontents() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
}

function trophy_modifiedprotectiondistsqr(var_0, var_1) {
  if(isDefined(var_0.weapon_name) && isDefined(var_0.owner)) {
    switch (var_0.weapon_name) {
      case "switch_blade_child_mp":
      case "jackal_cannon_mp":
      case "drone_hive_projectile_mp":
        if(147456 > var_1) {
          var_1 = 147456;
        }

        break;
      case "pop_rocket_proj_mp":
      case "iw8_la_gromeoks_mp":
      case "iw8_la_juliet_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_kgolf_mp":
      case "iw8_la_gromeo_mp":
      case "iw8_la_mike32_mp":
      case "iw8_la_t9launcher_mp":
      case "iw8_la_t9freefire_mp":
      case "iw8_la_t9standard_mp":
        if(105625 > var_1) {
          var_1 = 105625;
        }

        break;
    }
  }

  if(var_0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unset_bullet_shields() && isDefined(var_0.owner)) {
    if(202500 > var_1) {
      var_1 = 202500;
    }
  }

  return var_1;
}

function trophy_checkignorelist(var_0) {
  var_1 = var_0.weapon_name;

  if(!isDefined(var_1) && isDefined(var_0.weapon_object)) {
    var_1 = var_0.weapon_object.basename;
  }

  if(isDefined(var_1)) {
    if(scripts\mp\utility\weapon::iskillstreakweapon(var_1) && var_1 != "cruise_proj_mp" && var_1 != "apache_proj_mp") {
      return true;
    }

    if(scripts\mp\utility\weapon::isaxeweapon(var_1)) {
      return true;
    }

    switch (var_1) {
      case "trophy_mp":
        if(scripts\mp\weapons::isplantedequipment(var_0)) {
          return true;
        }

        break;
      case "tac_cover_mp":
      case "iw8_fulton_bag_mp":
      case "tac_insert_trigger":
      case "supply_box_mp":
      case "snapshot_grenade_danger_mp":
      case "uplinkball_tracking_mp":
      case "geiger_counter_mp":
      case "offhand_spotter_scope_mp":
      case "hb_sensor_mp":
      case "throwingknife_drill_mp":
      case "throwingknife_electric_mp":
      case "throwingknife_fire_mp":
      case "throwingknife_mp":
      case "lighttank_mp":
      case "micro_turret_mp":
      case "pop_rocket_mp":
      case "at_mine_ap_mp":
        return true;
      case "jammer_br":
      case "kiosk_drop_marker_mp":
      case "advanced_supply_drop_marker_mp":
      case "armor_box_mp":
      case "decon_station_mp":
      case "slinger_br":
      case "support_box_mp":
        if(scripts\mp\utility\game::unset_relic_grounded()) {
          return true;
        }

        break;
    }
  }

  return false;
}

function trophy_notifytrophytargetowner(var_0, var_1, var_2) {
  if(!isDefined(var_0.owner) || !isPlayer(var_0.owner)) {
    return;
  }

  var_0.owner thread scripts\mp\damagefeedback::updatedamagefeedback("hittrophysystem");

  if(isDefined(var_0.weapon_name)) {
    switch (var_0.weapon_name) {
      case "switch_blade_child_mp":
      case "jackal_cannon_mp":
      case "drone_hive_projectile_mp":
        var_0.owner notify("destroyed_by_trophy", var_2, var_1, var_0.weapon_name, var_0.origin, var_0.angles);
        break;
    }

    return;
  }
}

function trophy_getbesttag(var_0) {
  var_1 = level.trophy.tags;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = self gettagangles(var_5);
    var_8 = anglesToForward(var_7);
    var_9 = vectordot(vectorNormalize(var_0 - var_6), var_8);

    if(var_10 == 0 || var_9 > var_2) {
      var_2 = var_9;
      var_3 = var_5;
    }
  }

  return var_3;
}

function trophy_getpartbytag(var_0) {
  var_1 = level.trophy.tags;

  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return ("barrel" + var_4 + 1);
    }
  }

  return undefined;
}

function trophy_givepointsfordeath(var_0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment");
    var_0 thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    return;
  }
}

#using_animtree("scriptables");

function trophy_getdeployanimtime() {
  return getanimlength(%wm_trophy_system_deploy_landing);
}

function trophy_givedamagefeedback(var_0) {
  var_1 = "";

  if(istrue(self.hasruggedeqp)) {
    var_1 = "hitequip";
  }

  if(isPlayer(var_0)) {
    var_0 scripts\mp\damagefeedback::updatedamagefeedback(var_1);
    return;
  }
}

function trophy_addstored(var_0) {
  if(!isDefined(self.trophies)) {
    self.trophies = [];
  }

  if(self.trophies.size < trophy_maxstored()) {
    if(!isDefined(var_0)) {
      var_0 = 3;
    }

    self.trophies[self.trophies.size] = var_0;
    return;
  }
}

function trophy_removestored() {
  if(isDefined(self.trophies) && self.trophies.size > 0) {
    var_0 = self.trophies[self.trophies.size - 1];
    self.trophies[self.trophies.size - 1] = undefined;
    return var_0;
  }

  return undefined;
}

function trophy_clearstored() {
  self.trophies = undefined;
}

function trophy_populatestored() {
  var_0 = scripts\mp\equipment::getequipmentmaxammo("equip_trophy");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    trophy_addstored();
  }
}

function trophy_maxstored() {
  return scripts\mp\equipment::getequipmentmaxammo("equip_trophy");
}

function trophy_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
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

function trophy_cleanuponparentdeath(var_0, var_1) {
  self endon("death");
  var_0 waittill("death");
  wait var_1;
  self delete();
}

function ref_119CE(var_0) {
  if(!isDefined(var_0) || !isPlayer(var_0.owner)) {
    return;
  }

  if(!isDefined(self.laststandweapondelay)) {
    return;
  }

  getentitylessscriptablearray("dlog_event_trophy_successful", ["deploying_player", self.laststandweapondelay, "grenade_owner", var_0.owner, "negated_target", var_0.weapon_name]);
}