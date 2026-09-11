/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\trophy_system.gsc
**************************************************/

function trophy_init() {
  var0 = spawnStruct();
  var0.tags = [];
  var0.tags[0] = "tag_barrel_1";
  var0.tags[1] = "tag_barrel_2";
  var0.tags[3] = "tag_barrel_3";
  var0.timeout = getdvarfloat("scr_trophy_timeoutOverride", 45);
  level.trophy = var0;
}

function trophy_set(var0, var1) {
  trophy_clearstored();
  trophy_populatestored();
}

function trophy_onsuperset() {}

function trophy_unset(var0, var1) {
  trophy_clearstored();
}

function trophy_used(var0) {
  var0 endon("death");
  self endon("disconnect");
  scripts\mp\utility\print::printgameaction("trophy spawned", self);
  var0 scripts\cp_mp\ent_manager::registerspawn(2, &sweeptrophy);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var0);
  thread trophy_hideandshowaftertime();
  thread ref_13ddc(var0);
  var0 waittill("missile_stuck", var1);
  var0 setotherent(self);
  var0 setnodeploy(1);
  var0.issuper = isDefined(self.super) && self.super.staticdata.weapon == "trophy_mp";
  var0.superid = level.superglobals.staticsuperdata["super_trophy"].id;
  var0.usedcount = 0;
  var0.laststandweapondelay = self;
  var2 = scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");

  if(var2) {
    var0.hasruggedeqp = 1;
  }

  if(!istrue(var0.issuper)) {
    var0.ammo = trophy_removestored();

    if(!isDefined(var0.ammo)) {
      var0.ammo = 3;
    }

    var0 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  } else {
    var0.ammo = 3;
  }

  scripts\mp\weapons::onequipmentplanted(var0, "equip_trophy", &trophy_shutdownanddestroy);
  thread scripts\mp\weapons::monitordisownedequipment(self, var0);
  var0 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  var0.explosion = trophy_createexplosion(var0);
  var3 = scripts\engine\utility::ter_op(var2, 200, 100);
  var4 = "hitequip";
  var0 thread scripts\mp\damage::monitordamage(var3, var4, &trophy_handlefataldamage, &trophy_handledamage, 0);
  var0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&trophy_applyempcallback);
  var0 setscriptablepartstate("visibility", "show", 0);
  thread trophy_deploy();
}

function ref_13ddc(var0) {
  self endon("death");
  self endon("missile_stuck");
  var0 endon("disconnect");
  var1 = scripts\engine\utility::ref_143b9(2, "touching_platform");

  if(var1 == "timeout") {
    return;
  }

  var2 = undefined;
  var3 = tablesort(self.origin, 500, 500);
  GscBinSkip0(0x2e, var3.size, self);
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

function trophy_deploy() {
  self endon("death");
  self setscriptablepartstate("effects", "activeLand");

  if(level.gametype == "br") {
    self.ignoreme = 1;
  }

  wait 0.1;
  thread ref_13dd5();
  wait 0.2;
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  thread trophy_watchprotection(45, 105625, &ref_13dda, &trophy_protectionsuccessful);
  thread ref_13ddd();
  thread scripts\mp\equipment_interact::remoteinteractsetup(&trophy_remote_destroy, 1, 1);
  thread scripts\mp\perks\perk_equipmentping::runequipmentping();
}

function ref_13dd5() {
  self endon("death");
  self setscriptablepartstate("effects", "activeDeployStart");
  wait trophy_getdeployanimtime();
  self setscriptablepartstate("effects", "activeDeployEnd");
}

function trophy_hideandshowaftertime() {
  self endon("death");
  self endon("missile_stuck");
  var0 = getdvarfloat("scr_trophy_proj_hide_duration", 0);
  self setscriptablepartstate("visibility", "hide", 0);
  wait var0;
  self setscriptablepartstate("visibility", "show", 0);
}

function trophy_remote_destroy(var0) {
  trophy_destroy(1);
}

function sweeptrophy() {
  thread trophy_delete(undefined, 0);
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

function trophy_destroy(var0, var1) {
  thread trophy_delete(var0, 0.1, var1);
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

function trophy_shutdownanddestroy(var0, var1) {
  thread trophy_delete(var0, 2.6, var1);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);
  wait 2.5;

  if(isDefined(self)) {
    self setscriptablepartstate("effects", "activeDestroyEnd", 0);
    return;
  }
}

function trophy_delete(var0, var1, var2) {
  self notify("death");
  self setscriptablepartstate("hack_usable", "off");
  self.owner scripts\cp\vehicles\vehicle_compass_cp::ref_12032("super_trophy", self.usedcount, var0, var2);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var2));
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

  if(isDefined(var1)) {
    wait var1;
  }

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

function trophy_watchprotection(var0, var1, var2, var3) {
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

  if(!isDefined(level.ref_123a9)) {
    level.ref_123a9 = [];
  }

  var4 = trophy_castcontents();

  while([[var2]]()) {
    var5 = trophy_castorigin(var0);
    var6 = [];
    var6 = level.grenades;
    var6 = level.missiles;
    var6 = level.mines;
    var6 = level.projectilekillstreaks;
    var6 = level.ref_123a9;
    var7 = scripts\engine\utility::array_combine_multiple(var6);

    foreach(var9 in var7) {
      if(!isDefined(var9)) {
        continue;
      }

      if(istrue(var9.exploding)) {
        continue;
      }

      if(trophy_checkignorelist(var9)) {
        continue;
      }

      var10 = var9.owner;

      if(!isDefined(var10) && isDefined(var9.weapon_name) && weaponclass(var9.weapon_name) == "grenade") {
        var10 = getmissileowner(var9);
      }

      var11 = 1;

      if(var11) {
        var12 = self.owner;

        if(scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          var12 = self;
        }

        if(isDefined(var10) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var12, var10))) {
          continue;
        }

        if(var12 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(var12.ref_13df6) && isDefined(var10.team) && var12.ref_13df6 == var10.team) {
          continue;
        }
      } else if(var9 == self) {
        continue;
      }

      if(distancesquared(var9.origin, self.origin) > trophy_modifiedprotectiondistsqr(var9, var1)) {
        continue;
      }

      var13 = physics_raycast(var5, var9.origin, var4, [self, var9], 0, "physicsquery_closest");

      if(isDefined(var13) && var13.size > 0) {
        continue;
      }

      self[[var3]](var9);
    }

    waitframe();
  }
}

function ref_13dda() {
  return isDefined(self.owner);
}

function trophy_protectionsuccessful(var0) {
  self.owner scripts\mp\killstreaks\killstreaks::givescorefortrophyblocks();
  self.owner thread scripts\mp\gamelogic::threadedsetweaponstatbyname("trophy_mp", 1, "hits");
  self.owner scripts\mp\utility\stats::incpersstat("trophySystemHits", 1);
  self.owner scripts\mp\supers::hide_plunderboxes("super_trophy");
  self.usedcount++;
  var1 = var0.origin;
  ref_119ce(var0);
  ref_13dd6(var0);
  var2 = trophy_getbesttag(var1);
  var3 = trophy_getpartbytag(var2);
  self setscriptablepartstate(var3, "active", 0);
  var4 = vectortoangles(self gettagorigin(var2) - var1);
  var5 = combineangles(var4, (-90, 0, 0));
  thread trophy_explode(self.explosion, var1);
  self.ammo--;

  if(self.ammo <= 0) {
    thread trophy_shutdownanddestroy(undefined, 0);
    return;
  }
}

function ref_13dd6(var0) {
  var0 setCanDamage(0);
  var0.exploding = 1;
  var0 stopsounds();
  scripts\cp\vehicles\vehicle_compass_cp::ondestroyedbytrophy();
  trophy_notifytrophytargetowner(var0, "trophy_mp", self.owner);
  ref_13ddb(var0, var0.owner, self.owner);

  if(!var0 scripts\mp\equipment::ondestroyedbytrophy()) {
    if(isDefined(var0.streakname) && var0.streakname == "cruise_predator") {
      var0 notify("trophy_blocked");
      return;
    }

    var0 delete();
    return;
  }
}

function ref_13ddb(var0, var1, var2) {
  if(!isDefined(var0.equipmentref) || var0.equipmentref != "equip_snapshot_grenade") {
    return;
  }

  if(!isDefined(var0.owner) || !isDefined(self.owner)) {
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(var1)) {
    return;
  }

  var3 = var2;
  var4 = var1.origin;
  var5 = scripts\mp\equipment\snapshot_grenade::ref_13436(var3, var4);
  scripts\mp\equipment\snapshot_grenade::ref_13435(var1, var2, var5);
}

function ref_13ddd() {
  self endon("death");
  ref_13dde();
  thread trophy_shutdownanddestroy(undefined, 0);
}

function ref_13dde() {
  level endon("game_ended");
  var0 = level.trophy.timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);
}

function trophy_handledamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var4;
  var5 = scripts\mp\damage::handlemeleedamage(var2, var3, var5);
  var5 = scripts\mp\damage::handleapdamage(var2, var3, var5);
  scripts\mp\weapons::equipmenthit(self.owner, var1, var2, var3);
  return var5;
}

function trophy_handlefataldamage(var0) {
  var1 = var0.attacker;
  trophy_givepointsfordeath(var1);
  thread trophy_destroy(var1, 1);
}

function trophy_applyempcallback(var0) {
  trophy_givepointsfordeath(var0.victim, var0.attacker);
  thread trophy_shutdownanddestroy(var0.victim, var0.attacker);
}

function trophy_pickup() {
  if(self.owner scripts\mp\equipment::hasequipment("equip_trophy")) {
    trophy_addstored(self.owner, self.ammo);
    return;
  }
}

function trophy_createexplosion(var0) {
  var1 = spawn("script_model", var0.origin);
  var1.killcament = var0;
  var1.owner = var0.owner;
  var1.team = var0.team;
  var1.equipmentref = var0.equipmentref;
  var1.weapon_name = var0.weapon_name;
  var1 setotherent(var1.owner);
  var1 setentityowner(var1.owner);
  var1 setModel("trophy_system_mp_explode");
  var1.explode1available = 1;
  thread trophy_cleanuponparentdeath(var1, var0);
  return var1;
}

function trophy_explode(var0, var1) {
  self dontinterpolate();
  self.origin = var0;
  self.angles = var1;

  if(self.explode1available) {
    self setscriptablepartstate("explode1", "activeDirectional", 0);
    self.explode1available = 0;
    return;
  }

  self setscriptablepartstate("explode2", "activeDirectional", 0);
  self.explode1available = 1;
}

function trophy_castorigin(var0) {
  return self.origin + anglestoup(self.angles) * var0;
}

function trophy_castcontents() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
}

function trophy_modifiedprotectiondistsqr(var0, var1) {
  if(isDefined(var0.weapon_name) && isDefined(var0.owner)) {
    switch (var0.weapon_name) {
      case "switch_blade_child_mp":
      case "jackal_cannon_mp":
      case "drone_hive_projectile_mp":
        if(147456 > var1) {
          var1 = 147456;
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
        if(105625 > var1) {
          var1 = 105625;
        }

        break;
    }
  }

  if(var0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unset_bullet_shields() && isDefined(var0.owner)) {
    if(202500 > var1) {
      var1 = 202500;
    }
  }

  return var1;
}

function trophy_checkignorelist(var0) {
  var1 = var0.weapon_name;

  if(!isDefined(var1) && isDefined(var0.weapon_object)) {
    var1 = var0.weapon_object.basename;
  }

  if(isDefined(var1)) {
    if(scripts\mp\utility\weapon::iskillstreakweapon(var1) && var1 != "cruise_proj_mp" && var1 != "apache_proj_mp") {
      return true;
    }

    if(scripts\mp\utility\weapon::isaxeweapon(var1)) {
      return true;
    }

    switch (var1) {
      case "trophy_mp":
        if(scripts\mp\weapons::isplantedequipment(var0)) {
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

function trophy_notifytrophytargetowner(var0, var1, var2) {
  if(!isDefined(var0.owner) || !isPlayer(var0.owner)) {
    return;
  }

  var0.owner thread scripts\mp\damagefeedback::updatedamagefeedback("hittrophysystem");

  if(isDefined(var0.weapon_name)) {
    switch (var0.weapon_name) {
      case "switch_blade_child_mp":
      case "jackal_cannon_mp":
      case "drone_hive_projectile_mp":
        var0.owner notify("destroyed_by_trophy", var2, var1, var0.weapon_name, var0.origin, var0.angles);
        break;
    }

    return;
  }
}

function trophy_getbesttag(var0) {
  var1 = level.trophy.tags;
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var1) {
    var6 = self gettagorigin(var5);
    var7 = self gettagangles(var5);
    var8 = anglesToForward(var7);
    var9 = vectordot(vectorNormalize(var0 - var6), var8);

    if(var10 == 0 || var9 > var2) {
      var2 = var9;
      var3 = var5;
    }
  }

  return var3;
}

function trophy_getpartbytag(var0) {
  var1 = level.trophy.tags;

  foreach(var3 in var1) {
    if(var3 == var0) {
      return ("barrel" + var4 + 1);
    }
  }

  return undefined;
}

function trophy_givepointsfordeath(var0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var0))) {
    var0 notify("destroyed_equipment");
    var0 thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment");
    var0 thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    return;
  }
}

#using_animtree("scriptables");

function trophy_getdeployanimtime() {
  return getanimlength(%wm_trophy_system_deploy_landing);
}

function trophy_givedamagefeedback(var0) {
  var1 = "";

  if(istrue(self.hasruggedeqp)) {
    var1 = "hitequip";
  }

  if(isPlayer(var0)) {
    var0 scripts\mp\damagefeedback::updatedamagefeedback(var1);
    return;
  }
}

function trophy_addstored(var0) {
  if(!isDefined(self.trophies)) {
    self.trophies = [];
  }

  if(self.trophies.size < trophy_maxstored()) {
    if(!isDefined(var0)) {
      var0 = 3;
    }

    self.trophies[self.trophies.size] = var0;
    return;
  }
}

function trophy_removestored() {
  if(isDefined(self.trophies) && self.trophies.size > 0) {
    var0 = self.trophies[self.trophies.size - 1];
    self.trophies[self.trophies.size - 1] = undefined;
    return var0;
  }

  return undefined;
}

function trophy_clearstored() {
  self.trophies = undefined;
}

function trophy_populatestored() {
  var0 = scripts\mp\equipment::getequipmentmaxammo("equip_trophy");

  for(var1 = 0; var1 < var0; var1++) {
    trophy_addstored();
  }
}

function trophy_maxstored() {
  return scripts\mp\equipment::getequipmentmaxammo("equip_trophy");
}

function trophy_modifieddamage(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    return [var3, var4];
  }

  if(var3 == 0) {
    return [var3, var4];
  }

  var5 = undefined;

  if(level.hardcoremode) {
    switch (var2) {
      case "super_trophy_mp":
      case "player_trophy_system_mp":
      case "trophy_mp":
        var5 = 20;
        break;
    }
  }

  var6 = var4;

  if(isDefined(var5)) {
    var6 = var5 - var3;
  }

  var6 = min(var6, var4);
  return [var3, var4];
}

function trophy_cleanuponparentdeath(var0, var1) {
  self endon("death");
  var0 waittill("death");
  wait var1;
  self delete();
}

function ref_119ce(var0) {
  if(!isDefined(var0) || !isPlayer(var0.owner)) {
    return;
  }

  if(!isDefined(self.laststandweapondelay)) {
    return;
  }

  getentitylessscriptablearray("dlog_event_trophy_successful", ["deploying_player", self.laststandweapondelay, "grenade_owner", var0.owner, "negated_target", var0.weapon_name]);
}