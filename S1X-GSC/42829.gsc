/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42829.gsc
**************************************/

init() {
  level.riot_shield_names = [];
  level.riot_shield_names[level.riot_shield_names.size] = "riotshield_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot0_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot1_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot2_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldt6loot3_mp";
  level.riot_shield_names[level.riot_shield_names.size] = "iw5_riotshieldjugg_mp";
  precacheanims();
  level.riot_shield_collision = getent("riot_shield_collision", "targetname");
  level._effect["riot_shield_shock_fx"] = loadfx("vfx/explosion/riotshield_stun");
  level._effect["riot_shield_deploy_smoke"] = loadfx("vfx/smoke/riotshield_deploy_smoke");
  level._effect["riot_shield_deploy_lights"] = loadfx("vfx/lights/riotshield_deploy_lights");
}

precacheanims() {
  precachempanim("npc_deployable_riotshield_stand_deploy");
  precachempanim("npc_deployable_riotshield_stand_destroyed");
  precachempanim("npc_deployable_riotshield_stand_shot");
  precachempanim("npc_deployable_riotshield_stand_shot_back");
  precachempanim("npc_deployable_riotshield_stand_melee_front");
  precachempanim("npc_deployable_riotshield_stand_melee_back");
}

hasriotshield() {
  return isDefined(self.frontshieldmodel) || isDefined(self.backshieldmodel);
}

hasriotshieldequipped() {
  return isDefined(self.frontshieldmodel);
}

weaponisriotshield(var_0) {
  if(!isDefined(level.riot_shield_names)) {
    return 0;
  }

  var_1 = getweaponbasename(var_0);

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  foreach(var_3 in level.riot_shield_names) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

weaponisshockplantriotshield(var_0) {
  if(!weaponisriotshield(var_0)) {
    return 0;
  }

  return issubstr(var_0, "shockplant");
}

getotherriotshieldname(var_0) {
  var_1 = 0;
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(weaponisriotshield(var_4)) {
      if(var_4 == var_0 && !var_1) {
        var_1 = 1;
        continue;
      }

      return var_4;
    }
  }

  return undefined;
}

updatefrontandbackshields(var_0) {
  self.frontshieldmodel = undefined;
  self.backshieldmodel = undefined;

  if(!isDefined(var_0)) {
    var_0 = self getcurrentprimaryweapon();
  }

  if(weaponisriotshield(var_0)) {
    self.frontshieldmodel = getweaponmodel(var_0);
  }

  var_1 = getotherriotshieldname(var_0);

  if(isDefined(var_1)) {
    self.backshieldmodel = getweaponmodel(var_1);
  }

  self refreshshieldmodels(var_0);
}

riotshield_clear() {
  self.frontshieldmodel = undefined;
  self.backshieldmodel = undefined;
}

entisstucktoshield() {
  if(!self islinked()) {
    return 0;
  }

  var_0 = self getlinkedtagname();

  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "tag_shield_back":
    case "tag_weapon_left":
    case "tag_inhand":
      return 1;
  }

  return 0;
}

watchriotshielduse() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  thread trackriotshield();

  for(;;) {
    self waittill("raise_riotshield");
    thread startriotshielddeploy();
  }
}

riotshield_watch_for_change_weapon() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");
  var_0 = undefined;
  self waittill("weapon_change", var_0);
  self notify("riotshield_change_weapon", var_0);
}

riotshield_watch_for_start_change_weapon() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");
  var_0 = undefined;

  for(;;) {
    self waittill("weapon_switch_started", var_0);

    if(self isonladder()) {
      thread riotshield_watch_for_ladder_early_exit();
      break;
    }

    if(isDefined(self.frontshieldmodel) && isDefined(self.backshieldmodel)) {
      wait 0.5;
      break;
    }
  }

  self notify("riotshield_change_weapon", var_0);
}

riotshield_watch_for_ladder_early_exit() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("weapon_change");

  while(self isonladder()) {
    waitframe();
  }

  self notify("riotshield_change_weapon", self getcurrentprimaryweapon());
}

riotshield_watch_for_exo_shield_pullback() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");
  var_0 = undefined;
  var_1 = maps\mp\_exo_shield::get_exo_shield_weapon();
  self waittillmatch("grenade_pullback", var_1);

  while(!isDefined(self.exo_shield_on) || !self.exo_shield_on) {
    waitframe();
  }

  self notify("riotshield_change_weapon", var_1);
}

riotshield_watch_for_exo_shield_release() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");

  if(!isDefined(self.exo_shield_on) || !self.exo_shield_on) {
    return;
  }
  var_0 = undefined;
  var_1 = maps\mp\_exo_shield::get_exo_shield_weapon();
  self waittillmatch("battery_discharge_end", var_1);

  while(isDefined(self.exo_shield_on) && self.exo_shield_on) {
    waitframe();
  }

  self notify("riotshield_change_weapon", self getcurrentweapon());
}

watchriotshieldloadout() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("track_riot_shield");
  self waittill("applyLoadout");
  updatefrontandbackshields(self getcurrentweapon());
}

trackriotshield() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("track_riot_shield");
  self endon("track_riot_shield");
  updatefrontandbackshields(self.currentweaponatspawn);
  thread watchriotshieldloadout();
  self.lastnonshieldweapon = "none";

  for(;;) {
    thread watchriotshieldpickup();
    var_0 = self getcurrentweapon();

    if(isDefined(self.exo_shield_on) && self.exo_shield_on) {
      var_0 = maps\mp\_exo_shield::get_exo_shield_weapon();
    }

    thread riotshield_watch_for_change_weapon();
    thread riotshield_watch_for_start_change_weapon();
    thread riotshield_watch_for_exo_shield_pullback();
    thread riotshield_watch_for_exo_shield_release();
    self waittill("riotshield_change_weapon", var_1);

    if(weaponisriotshield(var_1)) {
      if(hasriotshield()) {
        if(isDefined(self.riotshieldtakeweapon)) {
          self takeweapon(self.riotshieldtakeweapon);
          self.riotshieldtakeweapon = undefined;
        }
      }

      if(isvalidnonshieldweapon(var_0)) {
        self.lastnonshieldweapon = var_0;
      }
    }

    updateriotshieldattachfornewweapon(var_1);
  }
}

updateriotshieldattachfornewweapon(var_0) {
  if(self ismantling() && var_0 == "none") {
    return;
  }
  updatefrontandbackshields(var_0);
}

watchriotshieldpickup() {
  self endon("death");
  self endon("disconnect");
  self endon("track_riot_shield");
  self notify("watch_riotshield_pickup");
  self endon("watch_riotshield_pickup");
  self waittill("pickup_riotshield");
  self endon("weapon_change");
  wait 0.5;
  updateriotshieldattachfornewweapon(self getcurrentweapon());
}

isvalidnonshieldweapon(var_0) {
  if(maps\mp\_utility::iskillstreakweapon(var_0)) {
    return 0;
  }

  if(var_0 == "none") {
    return 0;
  }

  if(maps\mp\gametypes\_class::isvalidequipment(var_0, 1) || maps\mp\gametypes\_class::isvalidequipment(var_0, 0)) {
    return 0;
  }

  if(weaponisriotshield(var_0)) {
    return 0;
  }

  if(weaponclass(var_0) == "ball") {
    return 0;
  }

  return 1;
}

startriotshielddeploy() {
  thread watchriotshielddeploy();
}

handleriotshieldshockplant() {
  var_0 = self.riotshieldentity;
  var_1 = 10;
  var_2 = 50;
  var_3 = 150;
  var_4 = var_3 * var_3;
  var_5 = self.riotshieldentity.origin + (0, 0, -25);
  self radiusdamage(var_5, var_3, var_2, var_1, self, "MOD_EXPLOSIVE");
  playFX(level._effect["riot_shield_shock_fx"], var_5, anglesToForward(self.riotshieldentity.angles + (-90, 0, 0)));

  foreach(var_7 in level.players) {
    if(maps\mp\_utility::isreallyalive(var_7) && !isalliedsentient(var_7, self)) {
      if(distancesquared(var_5, var_7.origin) < var_4) {
        var_7 shellshock("concussion_grenade_mp", 1);
      }
    }
  }
}

watchriotshielddeploy() {
  self endon("death");
  self endon("disconnect");
  self notify("start_riotshield_deploy");
  self endon("start_riotshield_deploy");
  self waittill("startdeploy_riotshield");
  self playSound("wpn_riot_shield_plant_mech");
  self waittill("deploy_riotshield", var_0);

  if(isDefined(self.riotshieldentity)) {
    self.riotshieldentity thread damagethendestroyriotshield();
    waitframe();
  }

  var_1 = self getcurrentweapon();
  self setweaponmodelvariant(var_1, 0);
  var_2 = weaponisshockplantriotshield(var_1);
  self playSound("wpn_riot_shield_plant_punch");

  if(var_2) {
    self playSound("wpn_riot_shield_blast_punch");
  }

  var_3 = 0;

  if(var_0) {
    var_4 = self canplaceriotshield();

    if(var_4["result"] && riotshielddistancetest(var_4["origin"])) {
      var_5 = 28;
      var_6 = spawnriotshieldcover(var_4["origin"] + (0, 0, var_5), var_4["angles"]);
      var_7 = spawnriotshieldcollision(var_4["origin"] + (0, 0, var_5), var_4["angles"], var_6);
      var_8 = deployriotshield(self, var_6);
      var_9 = self getweaponslistprimaries();
      self.riotshieldretrievetrigger = var_8;
      self.riotshieldentity = var_6;
      self.riotshieldcollisionentity = var_7;

      if(var_2) {
        thread handleriotshieldshockplant();
      } else {
        playFXOnTag(common_scripts\utility::getfx("riot_shield_deploy_smoke"), var_6, "tag_weapon");
      }

      var_6 scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_deploy");
      thread spawnshieldlights(var_6);
      var_10 = 0;

      if(self.lastnonshieldweapon != "none" && self hasweapon(self.lastnonshieldweapon)) {
        self switchtoweaponimmediate(self.lastnonshieldweapon);
      } else if(var_9.size > 0) {
        self switchtoweaponimmediate(var_9[0]);
      } else {
        var_10 = 1;
      }

      if(!self hasweapon("iw5_combatknife_mp")) {
        self giveweapon("iw5_combatknife_mp");
        self.riotshieldtakeweapon = "iw5_combatknife_mp";
      }

      if(var_10) {
        self switchtoweaponimmediate("iw5_combatknife_mp");
      }

      var_11 = spawnStruct();
      var_11.deathoverridecallback = ::damagethendestroyriotshield;
      var_6 thread maps\mp\_movers::handle_moving_platforms(var_11);
      thread watchdeployedriotshieldents();
      thread deleteshieldontriggerdeath(self.riotshieldretrievetrigger);
      thread deleteshieldontriggerpickup(self.riotshieldretrievetrigger, self.riotshieldentity);
      thread deleteshieldonplayerdeathordisconnect(var_6);

      if(isDefined(var_4["entity"])) {
        thread deleteshieldongrounddelete(var_4["entity"]);
      }

      self.riotshieldentity thread watchdeployedriotshielddamage();
      level notify("riotshield_planted", self);
    } else {
      var_3 = 1;
      var_12 = weaponclipsize(var_1);
      self setweaponammoclip(var_1, var_12);
    }
  } else {
    var_3 = 1;
  }

  if(var_3) {
    self setriotshieldfailhint();
  }
}

spawnshieldlights(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  wait 0.6;
  playFXOnTag(common_scripts\utility::getfx("riot_shield_deploy_lights"), var_0, "tag_weapon");
}

riotshielddistancetest(var_0) {
  var_1 = getdvarfloat("riotshield_deploy_limit_radius");
  var_1 = var_1 * var_1;

  foreach(var_3 in level.players) {
    if(isDefined(var_3.riotshieldentity)) {
      var_4 = distancesquared(var_3.riotshieldentity.origin, var_0);

      if(var_1 > var_4) {
        return 0;
      }
    }
  }

  return 1;
}

spawnriotshieldcover(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.targetname = "riotshield_mp";
  var_2.angles = var_1;
  var_3 = undefined;
  var_4 = self getcurrentprimaryweapon();

  if(weaponisriotshield(var_4)) {
    var_3 = getweaponmodel(var_4);
  }

  if(!isDefined(var_3)) {
    var_3 = "npc_deployable_riot_shield_base";
  }

  var_2 setModel(var_3);
  var_2.owner = self;
  var_2.team = self.team;
  return var_2;
}

spawnriotshieldcollision(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0, 1);
  var_3.targetname = "riotshield_coll_mp";
  var_3.angles = var_1;
  var_3 setModel("tag_origin");
  var_3.owner = self;
  var_3.team = self.team;
  var_3 clonebrushmodeltoscriptmodel(level.riot_shield_collision);
  var_3 disconnectpaths();
  var_3 sethighjumpresetallowed(0);
  return var_3;
}

watchdeployedriotshieldents() {
  self waittill("destroy_riotshield");

  if(isDefined(self.riotshieldretrievetrigger)) {
    self.riotshieldretrievetrigger delete();
  }

  if(isDefined(self.riotshieldcollisionentity)) {
    self.riotshieldcollisionentity connectpaths();
    self.riotshieldcollisionentity delete();
  }

  if(isDefined(self.riotshieldentity)) {
    self.riotshieldentity delete();
  }
}

deleteshieldontriggerpickup(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 waittill("trigger", var_2);
  handlepickupdeployedriotshields(var_2, var_1);
  self notify("destroy_riotshield");
}

deleteshieldontriggerdeath(var_0) {
  level endon("game_ended");
  var_0 waittill("death");
  self notify("destroy_riotshield");
}

deleteshieldonplayerdeathordisconnect(var_0) {
  var_0 endon("death");
  var_0 endon("damageThenDestroyRiotshield");
  common_scripts\utility::waittill_any("death", "disconnect", "remove_planted_weapons");
  var_0 thread damagethendestroyriotshield();
}

deleteshieldongrounddelete(var_0) {
  level endon("game_ended");
  var_0 common_scripts\utility::waittill_any("death", "hidingLightingState");
  self notify("destroy_riotshield");
}

watchdeployedriotshielddamage() {
  self endon("death");
  var_0 = getdvarint("riotshield_deployed_health");
  self.damagetaken = 0;
  var_1 = 0;

  for(;;) {
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(!isDefined(var_3)) {
      continue;
    }
    if(isplayer(var_3)) {
      if(level.teambased && var_3.team == self.owner.team && var_3 != self.owner) {
        continue;
      }
    }

    var_12 = 0;
    var_13 = 0;

    if(maps\mp\_utility::ismeleemod(var_6)) {
      var_12 = 1;
      var_2 = var_2 * getdvarfloat("riotshield_melee_damage_scale");
    } else if(var_6 == "MOD_PISTOL_BULLET" || var_6 == "MOD_RIFLE_BULLET") {
      var_13 = 1;
      var_2 = var_2 * getdvarfloat("riotshield_bullet_damage_scale");
    } else if(var_6 == "MOD_GRENADE" || var_6 == "MOD_GRENADE_SPLASH" || var_6 == "MOD_EXPLOSIVE" || var_6 == "MOD_EXPLOSIVE_SPLASH" || var_6 == "MOD_PROJECTILE" || var_6 == "MOD_PROJECTILE_SPLASH") {
      var_2 = var_2 * getdvarfloat("riotshield_explosive_damage_scale");
    } else if(var_6 == "MOD_IMPACT") {
      var_2 = var_2 * getdvarfloat("riotshield_projectile_damage_scale");
    } else if(var_6 == "MOD_CRUSH") {
      var_2 = var_0;
    }

    self.damagetaken = self.damagetaken + var_2;

    if(self.damagetaken >= var_0) {
      thread damagethendestroyriotshield(var_3, var_11);
      break;
    } else if((var_12 || var_13) && gettime() >= var_1) {
      var_1 = gettime() + 500;
      var_14 = 0;
      var_15 = anglesToForward(self.angles);

      if(vectordot(var_4, var_15) > 0) {
        var_14 = 1;
      }

      if(var_12) {
        if(var_14) {
          self scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_melee_back");
        } else {
          self scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_melee_front");
        }
      } else if(var_14) {
        self scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_shot_back");
      } else {
        self scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_shot");
      }
    }
  }
}

damagethendestroyriotshield(var_0, var_1) {
  self notify("damageThenDestroyRiotshield");
  self endon("death");

  if(isDefined(self.owner.riotshieldretrievetrigger)) {
    self.owner.riotshieldretrievetrigger delete();
  }

  if(isDefined(self.owner.riotshieldcollisionentity)) {
    self.owner.riotshieldcollisionentity connectpaths();
    self.owner.riotshieldcollisionentity delete();
  }

  self.owner.riotshieldentity = undefined;
  self notsolid();
  self scriptmodelplayanimdeltamotion("npc_deployable_riotshield_stand_destroyed");
  wait(getdvarfloat("riotshield_destroyed_cleanup_time"));
  self delete();
}

watchriotshieldstuckentitydeath(var_0, var_1) {
  var_0 endon("death");
  common_scripts\utility::waittill_any("damageThenDestroyRiotshield", "death", "disconnect", "weapon_change", "deploy_riotshield");
  var_0 detonate(var_1);
}