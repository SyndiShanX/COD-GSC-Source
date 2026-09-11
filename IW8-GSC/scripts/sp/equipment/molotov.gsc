/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\molotov.gsc
***********************************************/

function precache(var_0) {
  precachemodel("burntbody_male");
  precachemodel("equip_molotov_pool_mp");
  level.g_effect["molotov_explosion"] = loadfx("vfx/iw8/core/molotov/vfx_molotov_explosion.vfx");
  level.g_effect["molotov_explosion_child"] = loadfx("vfx/iw8/core/molotov/vfx_molotov_explosion_child.vfx");
  level.g_effect["vfx_burn_lrg_high"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_high.vfx");
  level.g_effect["vfx_burn_lrg_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_low.vfx");
  level.g_effect["vfx_burn_med_high"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_high.vfx");
  level.g_effect["vfx_burn_med_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx");
  level.g_effect["vfx_burn_sml_high"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_high.vfx");
  level.g_effect["vfx_burn_sml_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx");
  level.g_effect["vfx_burn_sml_head_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx");
  level.molotovdata = spawnStruct();
  level.molotovdata.active = [];
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, &molotovfiremain);
}

function molotovfiremain(var_0) {
  jumpiffalse(isPlayer(self) || isai(self)) LOC_0000001a;
  var_1 = self;
  goto LOC_00000062;
}

function sortandreturnowner(var_0, var_1) {
  return sortbydistance(var_0, var_1.origin)[0];
}

function getlaunchangles(var_0) {
  var_1 = vectorNormalize(var_0 - self.origin);
  var_2 = vectortoangles(var_1);
  var_3 = (0, self.angles[1], 0);
  var_4 = var_3 + (45, 0, 0);
  return var_4;
}

function molotovexplode(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_0);
  var_5 setModel("offhand_wm_molotov_sp");
  var_6 = vectortoangles(var_1);
  var_7 = anglesToForward(var_6);
  var_8 = anglestoright(var_6);
  var_9 = anglestoup(var_6);
  var_5.angles = axistoangles(var_8, var_9, var_7);
  var_5.owner = var_4;
  var_10 = getlaunchangles(var_4, var_0);

  if(isDefined(var_3) && isDefined(var_3.classname) && var_3.classname == "worldspawn") {
    var_3 = undefined;
  }

  thread molotov_stuck(var_5, var_3, var_10, var_2);
}

function pool_damage_scriptables(var_0) {
  var_1 = self.pooldata.triggerradius * 3;

  foreach(var_3 in self.shareddata.scriptables) {
    var_4 = distance(var_3.origin, var_0);

    if(var_4 <= var_1) {
      if(var_3 getscriptableparthasstate("base", "script_ignite")) {
        var_3 setscriptablepartstate("base", "script_ignite", 1);
      }
    }
  }
}

function pool_damage_vehicles(var_0, var_1) {
  var_2 = self.pooldata.triggerradius * 5;

  foreach(var_4 in self.shareddata.vehicles) {
    var_5 = distance(var_4.origin, var_0);

    if(var_5 <= var_2) {
      if(var_4 isscriptable()) {
        thread molotovburnscriptablevehicle(var_4);
        continue;
      }

      thread molotovburnvehicle(var_4);
    }
  }
}

function molotovburnscriptablevehicle(var_0) {
  self endon("death");
  wait 1;
  var_1 = self getscriptablepartstate("body", 1);

  if(!isDefined(var_1)) {
    var_2 = ["flareup", "onfire"];

    foreach(var_4 in var_2) {
      if(self getscriptableparthasstate("body", var_4)) {
        self setscriptablepartstate("body", var_4, 1);
      }

      wait 0.5;
    }

    return;
  }
}

function molotovburnvehicle(var_0) {
  self endon("death");
  var_0 endon("molotov_pool_end");

  for(;;) {
    scripts\sp\utility::do_damage(75, self.origin, undefined, undefined, "MOD_FIRE");
    wait 0.5;
  }
}

function pool_damage_ai(var_0, var_1) {
  self.shareddata.ai = scripts\engine\utility::array_removeundefined(self.shareddata.ai);
  self.shareddata.ai = scripts\engine\utility::array_removedead_or_dying(self.shareddata.ai, 0);

  if(isDefined(var_1) && isPlayer(var_1)) {
    level.moloachievementvictims = 0;
  }

  foreach(var_3 in self.shareddata.ai) {
    var_4 = distance(var_3.origin, var_0);
    var_5 = 100;

    if(issameteam(var_3.team, var_1.team)) {
      var_6 = self.pooldata.aikillradius * 0.7;
      var_7 = self.pooldata.aidamageradius * 0.5;
    } else {
      var_6 = self.pooldata.aikillradius;
      var_7 = self.pooldata.aidamageradius;
    }

    if(var_4 <= var_6) {
      thread achievement_watcher(var_3, var_1);
      molotovburnenemy(var_3, 1, var_0, var_1);
      continue;
    }

    if(var_4 <= var_7) {
      thread achievement_watcher(var_3, var_1);
      molotovburnenemy(var_3, 0, var_0, var_1);
    }
  }
}

function issameteam(var_0, var_1) {
  return isDefined(var_0) && isDefined(var_1) && var_0 == var_1;
}

function molotovburnenemy(var_0, var_1, var_2, var_3) {
  var_0._blackboard.isburning = 1;
  var_0.burningtodeath = var_1;
  var_0.burningdirection = undefined;

  if(var_1) {
    if(istrue(var_0.flashlight)) {
      var_0 scripts\sp\nvg\nvg_ai::flashlight_off(0);
    }

    var_0 scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 scripts\sp\utility::do_damage(var_0.health + 9999, var_2, var_3, var_3, "MOD_FIRE", "molotov");
    var_4 = undefined;

    if(var_0 isscriptable()) {
      var_4 = var_0 getscriptablepartstate("burn_to_death_by_molotov", 1);
    }

    if(!isDefined(var_4)) {
      thread molotov_burn_sfx(var_0);
    }
  } else {
    var_5 = anglestoright(var_0.angles);
    var_6 = vectorNormalize(var_2 - var_0.origin);

    if(vectordot(var_5, var_6) > 0) {
      var_0.burningdirection = "right";
    } else {
      var_0.burningdirection = "left";
    }

    var_0 scripts\sp\utility::do_damage(1, var_2, var_3, var_3, "MOD_FIRE", "molotov");
    thread molotov_burn_sfx();
  }

  level thread scripts\sp\equipment\offhands::remove_blackboard_isburning(var_0);
}

function achievement_watcher(var_0, var_1) {
  if(!isai(self)) {
    return;
  }

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }

  if(!istrue(var_1.shareddata.thrownoffhand)) {
    return;
  }

  level.moloachievementvictims += 1;

  if(level.moloachievementvictims > 3) {
    level thread scripts\sp\utility::giveachievement_wrapper("ashes");
    return;
  }
}

function vector_empty(var_0) {
  return var_0 == (0, 0, 0);
}

function molotov_burn_sfx(var_0) {
  if(isDefined(var_0)) {
    var_1 = 1;
  } else {
    var_1 = 0.5;
  }

  if(!isDefined(self.burnsfxenabled)) {
    self.burnsfxenabled = 0;
  }

  if(!isDefined(self.burnsfx)) {
    var_2 = spawn("script_origin", self.origin);
    var_2 linkTo(self);
    self.burnsfx = var_2;
    wait 0.05;
  } else {
    var_2 = self.burnsfx;
  }

  if(isDefined(self) && self.burnsfxenabled == 0) {
    var_2 playLoopSound("weap_molotov_fire_enemy_burn");
    self.burnsfxenabled = 1;
    wait var_2;
    var_2 playSound("weap_molotov_fire_enemy_burn_end");
    wait 0.15;
    var_2 stoploopsound("weap_molotov_fire_enemy_burn");
    var_2 delete();

    if(isDefined(self)) {
      self.burnsfxenabled = 1;
      return;
    }

    return;
  }
}

function molotov_fire_sfx(var_0, var_1) {
  wait 0.1;
  var_2 = spawn("script_origin", var_0 + (0, 0, 15));
  var_2 playLoopSound("weap_molotov_fire_lp");
  wait var_1;
  thread scripts\engine\utility::play_sound_in_space("weap_molotov_fire_end", var_2.origin);
  var_2 scripts\engine\sp\utility::sound_fade_and_delete(1, 1);
}

function molotovviewmodelfiremanager() {
  var_0 = getcompleteweaponname("molotov");

  for(;;) {
    self waittill("grenade_pullback", var_1);

    if(var_1 == var_0) {
      self setscriptablepartstate("molotov", "molotov_fx_on");
      self waittill("offhand_end");
      self setscriptablepartstate("molotov", "molotov_fx_off");
    }
  }
}

function molotov_init() {
  molotov_init_cast_data();
  molotov_init_pool_data();
}

function molotov_init_cast_data() {
  var_0 = level.molotovdata;

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    level.molotovdata = var_0;
  }

  var_1 = var_0.castdata;

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_0.castdata = var_1;
  }

  var_1.distforward = [];
  var_1.distdown = [];
  var_1.distup = [];
  var_1.maxcasts = [];
  var_1.maxfails = [];
  var_1.maxents = [];
  var_1.firstforwarddist = [];
  var_1.firstforwardmindist = [];
  var_1.firstforwardmodanglesfunc = [];
  var_2 = 8;
  var_1.distforward[var_2] = undefined;
  var_1.distdown[var_2] = undefined;
  var_1.distup[var_2] = undefined;
  var_1.maxcasts[var_2] = undefined;
  var_1.maxfails[var_2] = undefined;
  var_1.maxents[var_2] = 1;
  var_2 = 16;
  var_1.distforward[var_2] = 50;
  var_1.distdown[var_2] = 50;
  var_1.distup[var_2] = 25;
  var_1.maxcasts[var_2] = 4;
  var_1.maxfails[var_2] = 3;
  var_1.maxents[var_2] = 1;
  var_1.distforwardwall[var_2] = 25;
  var_2 = 32;
  var_1.distforward[var_2] = 15;
  var_1.distdown[var_2] = 50;
  var_1.distup[var_2] = 25;
  var_1.maxcasts[var_2] = 17;
  var_1.maxfails[var_2] = 3;
  var_1.maxents[var_2] = 3;
  var_1.firstforwarddist[var_2] = 85;
  var_1.firstforwardmindist[var_2] = 8;
  var_1.distforwardwall[var_2] = 8;
  var_1.firstforwarddistwall[var_2] = 44;
}

function molotov_init_pool_data() {
  var_0 = level.molotovdata;

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    level.molotovdata = var_0;
  }

  var_1 = var_0.pooldata;

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_0.pooldata = var_1;
  }

  var_1.triggerradius = [];
  var_1.triggerheight = [];
  var_1.triggeroffset = [];
  var_1.startdelayms = [];
  var_2 = 8;
  var_1.triggerradius[var_2] = 30;
  var_1.triggerheight[var_2] = 55;
  var_1.aikillradius[var_2] = 80;
  var_1.aidamageradius[var_2] = 120;
  var_1.triggeroffset[var_2] = 15;
  var_1.startdelayms[var_2] = 0;
  var_1.dangerzoneradius[var_2] = 350;
  var_1.dangerzoneheight[var_2] = 128;
  var_2 = 16;
  var_1.triggerradius[var_2] = 30;
  var_1.triggerheight[var_2] = 55;
  var_1.aikillradius[var_2] = 55;
  var_1.aidamageradius[var_2] = 90;
  var_1.triggeroffset[var_2] = 15;
  var_1.startdelayms[var_2] = 100;
  var_2 = 32;
  var_1.triggerradius[var_2] = 10;
  var_1.triggerheight[var_2] = 55;
  var_1.aikillradius[var_2] = 50;
  var_1.aidamageradius[var_2] = 80;
  var_1.triggeroffset[var_2] = 15;
  var_1.startdelayms[var_2] = 100;
  molotov_init_pool_mask();
}

function molotov_init_pool_mask() {
  var_0 = level.molotovdata;

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    level.molotovdata = var_0;
  }

  var_1 = var_0.pooldata;

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_0.pooldata = var_1;
  }

  var_2 = [];
  GscBinSkip0(0x2e, 1, "flareUp");
}

function molotov_stuck(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = vectorNormalize(var_3);
  var_7 = anglestoup(var_0.angles);
  var_8 = anglestoright(var_2);

  if(abs(vectordot(var_6, var_7)) >= 0.9848) {
    var_5 = molotov_rebuild_angles_up_right(var_7, var_8);
  } else {
    var_5 = molotov_rebuild_angles_up_forward(var_7, var_6);
  }

  var_0.angles = var_5;
  var_0 notify("death");
  var_0 setscriptablepartstate("effects", "explode", 0);
  molotov_simulate_impact(var_0, var_0.origin, var_5, var_1, var_3, gettime(), var_4);
}

function molotovbadplace(var_0) {
  var_1 = createnavbadplacebybounds(var_0, (128, 128, 100), (0, 0, 0));

  if(level.dbgmolodrawhits) {
    var_2 = int(6250);
  }

  return var_1;
}

function molotov_simulate_impact(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = level.molotovdata.active.size;
  level.molotovdata.active[var_7] = spawnStruct();
  var_8 = var_0.owner;
  var_9 = anglestoup(var_2);
  var_10 = var_1 + var_9 * 1;
  var_11 = var_10 + var_9 * 25;
  var_12 = molotov_get_cast_contents();
  var_13 = getaiarray();
  var_13 = scripts\engine\utility::array_add(var_13, var_0);

  if(level.dbgmolodrawhits) {}

  var_14 = physics_raycast(var_10, var_11, var_12, var_13, 0, "physicsquery_closest", 1);

  if(isDefined(var_14) && var_14.size > 0) {
    var_11 = var_14[0]["position"] - var_9 * 1;
  }

  var_15 = var_11;
  var_16 = var_0;
  var_17 = molotov_get_next_burning_id();
  var_18 = 0;
  var_19 = 512;
  var_20 = vectordot(vectorNormalize(var_4), -1 * var_9);

  if(var_20 < 0.96593) {
    var_18 = 1;
    var_19 = 1024;
  }

  var_21 = molotov_create_shared_data(var_8, var_5, var_19, var_16, var_17, var_6);
  var_21.badplace = molotovbadplace(var_1);
  var_21.scriptables = moltovgetscriptables(var_1);
  var_21.vehicles = moltovgetvehicles(var_1);
  var_21.ai = moltovgetai(var_1);
  var_22 = 8;
  var_23 = molotov_get_cast_data(var_22);
  var_24 = molotov_get_pool_data(var_22);
  var_25 = molotov_create_branch(var_21, var_23, var_24, undefined, var_1, var_2, var_3);
  var_21.branches[var_21.branches.size] = var_25;
  var_26 = 25;
  var_27 = 65;
  var_28 = 115;
  var_29 = gettime() + var_24.startdelayms;
  var_22 = 16;
  var_23 = molotov_get_cast_data(var_22);
  var_24 = molotov_get_pool_data(var_22);
  var_30 = &molotov_branch_create_tendril_radial;

  if(var_18) {
    var_30 = &molotov_branch_create_forward_tendril_cone;
  }

  var_25 = molotov_create_branch(var_21, var_23, var_24, undefined, var_15, var_2, var_3, 0, var_29, var_30);
  var_21.branches[var_21.branches.size] = var_25;
  var_31 = anglesToForward(var_2);
  var_32 = anglestoright(var_2);
  var_33 = anglestoup(var_2);
  var_23 = molotov_get_cast_data(var_22);
  var_24 = molotov_get_pool_data(var_22);
  var_34 = var_31 * -1;
  var_35 = var_32 * -1;
  var_36 = var_33;
  var_37 = axistoangles(var_34, var_35, var_36);
  var_30 = &molotov_branch_create_tendril_radial;

  if(var_18) {
    var_30 = undefined;
  }

  var_25 = molotov_create_branch(var_21, var_23, var_24, undefined, var_15, var_37, var_3, 0, var_29, var_30);
  var_21.branches[var_21.branches.size] = var_25;
  var_23 = molotov_get_cast_data(var_22);
  var_24 = molotov_get_pool_data(var_22);
  var_34 = rotatepointaroundvector(var_33, var_31, var_27);
  var_35 = vectorNormalize(vectorcross(var_34, var_33));
  var_36 = vectorcross(var_35, var_31);
  var_37 = axistoangles(var_34, var_35, var_36);
  var_30 = &molotov_branch_create_tendril_radial;

  if(var_18) {
    var_30 = &molotov_branch_create_right_tendril_cone;
  }

  var_25 = molotov_create_branch(var_21, var_23, var_24, undefined, var_15, var_37, var_3, 0, var_29, var_30);
  var_21.branches[var_21.branches.size] = var_25;
  var_23 = molotov_get_cast_data(var_22);
  var_24 = molotov_get_pool_data(var_22);
  var_34 = rotatepointaroundvector(var_33, var_31, -1 * var_27);
  var_35 = vectorNormalize(vectorcross(var_34, var_33));
  var_36 = vectorcross(var_35, var_31);
  var_37 = axistoangles(var_34, var_35, var_36);
  var_30 = &molotov_branch_create_tendril_radial;

  if(var_18) {
    var_30 = &molotov_branch_create_left_tendril_cone;
  }

  var_25 = molotov_create_branch(var_21, var_23, var_24, undefined, var_15, var_37, var_3, 0, var_29, var_30);
  var_21.branches[var_21.branches.size] = var_25;
  var_23 = molotov_get_cast_data(var_22);
  var_24 = molotov_get_pool_data(var_22);
  var_34 = rotatepointaroundvector(var_33, var_31, var_28);
  var_35 = vectorNormalize(vectorcross(var_34, var_33));
  var_36 = vectorcross(var_35, var_31);
  var_37 = axistoangles(var_34, var_35, var_36);
  var_30 = &molotov_branch_create_tendril_radial;

  if(var_18) {
    var_30 = undefined;
  }

  var_25 = molotov_create_branch(var_21, var_23, var_24, undefined, var_15, var_37, var_3, 0, var_29, var_30);
  var_21.branches[var_21.branches.size] = var_25;
  var_23 = molotov_get_cast_data(var_22);
  var_24 = molotov_get_pool_data(var_22);
  var_34 = rotatepointaroundvector(var_33, var_31, -1 * var_28);
  var_35 = vectorNormalize(vectorcross(var_34, var_33));
  var_36 = vectorcross(var_35, var_31);
  var_37 = axistoangles(var_34, var_35, var_36);
  var_30 = &molotov_branch_create_tendril_radial;

  if(var_18) {
    var_30 = undefined;
  }

  var_25 = molotov_create_branch(var_21, var_23, var_24, undefined, var_15, var_37, var_3, 0, var_29, var_30);
  var_21.branches[var_21.branches.size] = var_25;
  molotov_shared_data_register_cast(var_21);

  foreach(var_25 in var_21.branches) {
    thread molotov_start_branch();
  }

  thread molotov_cleanup();
  var_21.initialized = 1;
  level.molotovdata.active[var_7] = var_21;
}

function moltovgetscriptables(var_0) {
  GscBinSkip1(0x45, 0, "scriptable_container_gas_tank_01");
}

function moltovgetvehicles(var_0) {
  var_1 = [];
  var_2 = getscriptablearray("scriptable", "code_classname");
  var_2 = scripts\engine\utility::array_combine(var_2, getEntArray("script_vehicle", "code_classname"));

  foreach(var_4 in var_2) {
    if(!isDefined(var_4.model) || !isstartstr(var_4.model, "veh8_")) {
      continue;
    }

    var_5 = distancesquared(var_4.origin, var_0);

    if(var_5 <= 65536) {
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  return var_1;
}

function moltovgetai(var_0) {
  var_1 = getaiarray();
  var_1 = scripts\engine\utility::array_removeundefined(var_1);
  var_1 = scripts\engine\utility::array_removedead_or_dying(var_1, 0);
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = distancesquared(var_4.origin, var_0);

    if(var_5 <= 65536) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

function molotov_cleanup() {
  self.burnsource scripts\engine\utility::waittill_notify_or_timeout("entitydeleted", 6.25);

  for(;;) {
    var_0 = 1;

    foreach(var_2 in self.branches) {
      if(!istrue(var_2.iscomplete)) {
        var_0 = 0;
        break;
      }

      if(!var_0) {
        break;
      }
    }

    if(var_0) {
      break;
    }

    waitframe();
  }

  destroynavobstacle(self.badplace);

  if(isDefined(self.burnsource)) {
    self.burnsource delete();
  }

  level.molotovdata.active = scripts\engine\utility::array_remove(level.molotovdata.active, self);
}

function molotov_create_shared_data(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.owner = var_0;
  var_6.team = var_0.team;
  var_6.impacttime = var_1;
  var_6.impactincidence = var_2;
  var_6.burnsource = var_3;
  var_6.burnid = var_4;
  var_6.branches = [];
  var_6.thrownoffhand = var_5;
  var_6.entstotal = 0;
  var_6.caststotal = 0;
  var_6.caststhisframe = 0;
  var_6.frametimestamp = gettime();
  var_6.castcontents = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var_6.castignore = getaiarray();
  var_6.castignore = scripts\engine\utility::array_add(var_6.castignore, level.player);
  return var_6;
}

function molotov_shared_data_register_cast() {
  self.caststotal++;
  self.caststhisframe++;
  self.frametimestamp = gettime();
}

function molotov_shared_data_register_ent() {
  self.entstotal++;
}

function molotov_shared_data_can_cast_this_frame() {
  if(self.frametimestamp < gettime()) {
    self.frametimestamp = gettime();
    self.caststhisframe = 0;
  }

  return self.caststhisframe < 3;
}

function molotov_shared_data_is_complete(var_0) {
  var_1 = 0;

  if(self.caststotal >= 60) {
    var_1 = 1;
  } else if(self.entstotal >= 20) {
    var_1 = 1;
  } else if(istrue(var_0)) {
    var_2 = 1;

    foreach(var_4 in self.branches) {
      if(!molotov_branch_is_complete(var_4, 1, 1)) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      var_1 = 1;
    }
  }

  if(var_1) {
    self.iscomplete = 1;
    self.branches = [];
  }

  return var_1;
}

function molotov_create_branch(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawnStruct();
  var_10.shareddata = var_0;
  var_10.castdata = var_1;
  var_10.pooldata = var_2;
  var_10.startingorigin = var_4;
  var_10.startingangles = var_5;
  var_10.startingstuckto = var_6;
  var_10.startingcasttype = var_7;
  var_10.oncompletedfunc = var_9;
  var_10.ents = [];
  var_10.branches = [];
  var_10.hitpositions = [];
  var_10.hittypes = [];
  var_10.casts = 0;
  var_10.castfails = 0;
  var_10.preventstarttime = var_8;
  return var_10;
}

function molotov_start_branch() {
  if(!isDefined(self.preventstarttime)) {
    self.preventstarttime = gettime();
  }

  if(!isDefined(self.startingcasttype)) {
    if(!molotov_shared_data_is_complete(self.shareddata)) {
      var_0 = molotov_branch_create_pool(self.startingorigin, self.startingangles, self.shareddata.impactincidence, self.startingstuckto);
      thread molotov_pool_start();
      pool_damage_scriptables(var_0.origin);
      pool_damage_vehicles(var_0.origin, var_0);
      pool_damage_ai(var_0.origin, self.shareddata.owner);
      self.iscomplete = 1;
      molotov_shared_data_is_complete(self.shareddata, 1);
      return;
    }

    return;
  }

  self.caststart = self.startingorigin;
  self.castend = undefined;
  self.castangles = self.startingangles;
  self.castdir = undefined;
  self.casttype = self.startingcasttype;
  self.startingorigin = undefined;
  self.startingangles = undefined;
  self.startingcasttype = undefined;

  for(;;) {
    if(molotov_shared_data_is_complete(self.shareddata)) {
      break;
    }

    if(molotov_branch_is_complete(undefined, 1)) {
      break;
    }

    if(!molotov_shared_data_can_cast_this_frame(self.shareddata)) {
      waitframe();
      continue;
    }

    if(self.casttype == 0) {
      var_1 = self.castdata.firstforwardmodanglesfunc;

      if(isDefined(var_1)) {
        self.castangles = [[var_1]](self.castangles);
        self.castdata.firstforwardmodanglesfunc = undefined;
        self.castdata.iswallcast = undefined;
      }
    }

    if(!isDefined(self.iswallcast)) {
      var_2 = vectordot(anglestoup(self.castangles), (0, 0, 1));
      self.iswallcast = var_2 > -0.81915 && var_2 <= 0.5;

      if(isDefined(self.castdata.firstforwarddist)) {
        if(self.iswallcast && isDefined(self.castdata.firstforwarddistwall)) {
          self.castdata.firstforwarddist = self.castdata.firstforwarddistwall;
          self.castdata.firstforwarddistwall = undefined;
        } else {
          self.castdata.firstforwarddistwall = undefined;
        }
      }
    }

    self.castdir = molotov_get_cast_dir(self.castangles, self.casttype);
    self.castend = self.caststart + self.castdir * molotov_get_cast_dist(self.casttype, self.castdata, self.iswallcast);
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;

    if(level.dbgmolodrawhits) {}

    var_8 = physics_raycast(self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var_8) && var_8.size > 0) {
      var_3 = 1;
      var_4 = var_8[0]["position"];
      var_5 = var_8[0]["normal"];
      var_6 = var_8[0]["entity"];
    }

    switch (self.casttype) {
      case 0:
        if(istrue(var_3)) {
          molotov_branch_register_cast(self.casttype, 0, var_4);
          var_9 = 1;

          if(isDefined(self.castdata.firstforwarddist)) {
            var_10 = var_4 - self.caststart;
            var_11 = vectordot(var_10, self.castdir);
            self.castdata.firstforwarddist -= var_11;

            if(self.castdata.firstforwarddist > self.castdata.firstforwardmindist) {
              var_9 = 0;
            } else {
              self.castdata.firstforwarddist = undefined;
            }
          }

          var_7 = molotov_rebuild_angles_up_right(var_5, anglestoright(self.castangles));

          if(var_9) {
            var_12 = molotov_branch_create_pool(var_4, var_7, self.shareddata.impactincidence, var_6);
            thread molotov_pool_start();
            pool_damage_ai(var_12.origin, self.shareddata.owner);
          }

          self.casttype = 2;
          self.caststart = var_4 + var_5 * 1;
          self.castangles = var_7;
          self.iswallcast = undefined;
        } else {
          molotov_branch_register_cast(self.casttype, undefined, undefined);

          if(isDefined(self.castdata.firstforwarddist)) {
            var_10 = self.castend - self.caststart;
            var_11 = vectordot(var_10, self.castdir);
            self.castdata.firstforwarddist -= var_11;

            if(self.castdata.firstforwarddist <= self.castdata.firstforwardmindist) {
              self.castdata.firstforwarddist = undefined;
            }
          }

          self.casttype = 1;
          self.caststart = self.castend;
        }

        break;
      case 1:
        if(istrue(var_3)) {
          var_7 = molotov_rebuild_angles_up_right(var_5, anglestoright(self.castangles));
          var_12 = molotov_branch_create_pool(var_4, var_7, self.shareddata.impactincidence, var_6);
          thread molotov_pool_start();
          pool_damage_ai(var_12.origin, self.shareddata.owner);
          var_13 = vectordot(anglestoup(self.castangles), var_5);

          if(var_13 < 0.9848) {
            molotov_branch_register_cast(self.casttype, 2, var_4);
            self.casttype = 2;
            self.caststart = var_4 + var_5 * 1;
            self.castangles = var_7;
          } else {
            molotov_branch_register_cast(self.casttype, 1, var_4);
            self.casttype = 0;
          }
        } else {
          molotov_branch_register_cast(self.casttype, undefined, undefined);
          self.caststart = self.castend;
        }

        break;
      case 2:
        if(istrue(var_3)) {
          molotov_branch_register_cast(self.casttype, 3, var_4);
          self.casttype = 0;
          self.caststart = var_4 + var_5 * 1;
        } else {
          molotov_branch_register_cast(self.casttype, undefined, undefined);
          self.casttype = 0;
        }

        break;
    }

    waittillframeend();
  }

  self.iscomplete = 1;
  molotov_shared_data_is_complete(self.shareddata, 1);
}

function molotov_branch_is_complete(var_0, var_1) {
  var_2 = 0;
  var_3 = undefined;

  if(!istrue(var_1)) {
    var_2 = molotov_shared_data_is_complete(self.shareddata);
  }

  if(!var_2) {
    if(isDefined(self.castdata) && isDefined(self.castdata.maxfails) && self.castfails >= self.castdata.maxfails) {
      var_2 = 1;
    } else if(isDefined(self.castdata) && isDefined(self.castdata.maxcasts) && self.casts >= self.castdata.maxcasts) {
      var_2 = 1;
    } else if(isDefined(self.castdata) && isDefined(self.castdata.maxents) && self.ents.size >= self.castdata.maxents) {
      var_2 = 1;
    } else if(istrue(var_0) && self.branches.size > 0) {
      var_3 = 1;

      foreach(var_5 in self.branches) {
        if(!molotov_branch_is_complete(var_5, var_0, var_1)) {
          var_3 = 0;
          break;
        }
      }

      if(var_3) {
        var_2 = 1;
      }
    }
  }

  if(var_2 && !istrue(self.iscomplete)) {
    var_7 = self.oncompletedfunc;
    self.oncompletedfunc = undefined;

    if(isDefined(var_7)) {
      self[[var_7]]();
    }

    if(istrue(var_3)) {
      var_2 = 0;

      foreach(var_5 in self.branches) {
        if(!molotov_branch_is_complete(var_5, 1, var_1)) {
          var_3 = 0;
          break;
        }
      }

      if(var_3) {
        var_2 = 1;
      }
    }
  }

  if(var_2) {
    self.iscomplete = 1;
    self.branches = [];
  }

  return var_2;
}

function molotov_branch_register_cast(var_0, var_1, var_2) {
  molotov_shared_data_register_cast(self.shareddata);
  self.casts++;

  if(isDefined(var_1)) {
    if(var_1 == 0 || var_1 == 1 || var_1 == 2) {
      self.castfails = 0;
      return;
    }

    return;
  }

  if(var_0 == 1) {
    self.castfails++;
    return;
  }
}

function molotov_create_pool(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawn("script_model", var_0);
  var_9.angles = var_1;
  var_9.stuckto = var_2;
  var_9.owner = var_3;
  var_9.burnsource = var_4;
  var_9.burnid = var_5;
  var_9.starttime = var_6;
  var_9.pooldata = var_7;
  var_9.poolmask = var_8;
  var_9 setModel("equip_molotov_pool_mp");

  if(isDefined(var_3)) {
    var_9 setotherent(var_3);
    var_9 setentityowner(var_3);
  }

  if(poolshouldlink(var_2)) {
    var_9 linkTo(var_2);
  }

  return var_9;
}

function poolshouldlink(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(var_0 == level.player) {
    return false;
  }

  if(isai(var_0)) {
    return false;
  }

  return true;
}

function molotov_branch_create_pool(var_0, var_1, var_2, var_3) {
  var_4 = self.pooldata.typeid;
  var_5 = anglestoup(var_1);
  var_6 = vectordot(var_5, (0, 0, 1));

  if(var_6 <= -0.81915) {
    var_4 |= 256;
  } else if(var_6 <= 0.5) {
    var_4 |= 128;
  } else {
    var_4 |= 64;
  }

  var_4 |= var_2;
  var_7 = self.preventstarttime + self.pooldata.startdelayms;
  var_8 = molotov_create_pool(var_0, var_1, var_3, self.shareddata.owner, self.shareddata.burnsource, self.shareddata.burnid, var_7, self.pooldata, var_4);
  self.preventstarttime = var_7;
  self.ents[self.ents.size] = var_8;
  molotov_shared_data_register_ent(self.shareddata);
  return var_8;
}

function molotov_pool_start() {
  if(istrue(self.started)) {
    return;
  }

  self.started = 1;
  self endon("death");
  self endon("molotov_pool_end");

  while(gettime() < self.starttime) {
    waitframe();
  }

  self.ended = 0;
  molotov_watch_pool();

  if(isDefined(self)) {
    thread molotov_pool_end();
    return;
  }
}

function molotov_watch_pool_explosion_extinguish() {
  var_0 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_explosionclip"]);

  for(;;) {
    level waittill("explosion_extinguish", var_1, var_2, var_3, var_4);

    if(distancesquared(var_1, self.origin) > var_2 * var_2) {
      continue;
    }

    if(!isDefined(var_4)) {
      var_4 = [];
      var_4 = self;
      var_4 = self.burnsource;
    } else if(isarray(var_4)) {
      var_4 = self;
      var_4 = self.burnsource;
    } else {
      var_5 = var_4;
      var_4 = [];
      var_4 = self;
      var_4 = self.burnsource;
      var_4 = var_5;
    }

    var_6 = min(15, self.pooldata.triggerheight);
    var_7 = self.origin + anglestoup(self.angles) * var_6;
    var_8 = physics_raycast(self.origin, var_1, var_0, var_4, 0, "physicsquery_closest", 1);

    if(isDefined(var_8) && var_8.size > 0) {
      continue;
    }

    thread molotov_pool_end();
  }
}

function molotov_watch_pool() {
  if(isDefined(self.stuckto)) {
    self.stuckto endon("death");
  }

  GscBinSkip4(0x35);
}

function molotov_pool_end(var_0) {
  self endon("death");

  if(istrue(self.ended)) {
    return;
  }

  self notify("molotov_pool_end");
  self.ended = 1;

  if(isDefined(self.poolmask)) {
    self.poolmask &= ~1;
    self.poolmask &= ~2;
  }

  if(!istrue(level.dbgmoloflareuponly) && !istrue(level.dbgmoloburnlooponly) && isDefined(self.poolmask)) {
    self.poolmask |= 4;
  }

  molotov_pool_update_scriptable();

  if(!istrue(var_0)) {
    wait 1;
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self setscriptablepartstate("decal", "neutral", 0);
  wait 3.5;
  self delete();
}

function molotov_create_pool_trigger(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self.origin - anglestoup(self.angles) * var_2;
  var_6 = spawn("trigger_radius_fire", var_5, 0, var_0, var_1);
  var_6.script_multiplier = 10;
  var_6.script_radius = var_0;
  var_6.angles = self.angles;
  thread scripts\sp\trigger::trigger_fire(var_6);
  level notify("molotov_fire_trigger", var_6);
  var_6 enablelinkTo();
  var_6 linkTo(self);
  var_6 hide();
  var_7 = spawnStruct();
  var_7.trigger = var_6;
  var_7.attacker = self.owner;
  var_7.inflictor = self.burnsource;
  var_7.killcament = self.burnsource;
  var_7.burnid = self.burnid;
  var_7.playersintrigger = [];
  var_6.struct = var_7;

  if(isDefined(var_3)) {}

  return var_6;
}

function molotov_pool_update_scriptable() {
  var_0 = level.molotovdata.pooldata;
  var_1 = self.poolmask & 7;
  var_2 = 1;
  var_3 = var_2;

  while((var_3 & 7) > 0) {
    var_4 = ~(7 &~var_3) &self.poolmask;
    var_5 = var_0.scriptableparts[var_3];
    var_6 = var_0.scriptablestates[var_4];
    self setscriptablepartstate(var_5, var_6, 0);
    var_3 <<= 1;
  }
}

function molotov_branch_create_sub_branch(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self.shareddata;
  var_10 = molotov_get_cast_data(var_0);
  var_11 = molotov_get_pool_data(var_0);

  if(isDefined(self.castdata)) {
    if(self.castfails > self.castdata.maxfails) {
      return;
    }

    if(self.castfails > var_10.maxfails) {
      return;
    }
  }

  if(isDefined(var_2)) {
    var_10.firstforwarddist = var_2;
  }

  if(isDefined(var_3)) {
    var_10.firstforwardmindist = var_3;
  }

  if(isDefined(var_4)) {
    var_10.firstforwardmodanglesfunc = var_4;
  }

  if(isDefined(var_5)) {
    var_10.firstforwarddistwall = var_5;
  }

  if(isDefined(var_6)) {
    var_10.maxcasts = var_6;
  }

  if(isDefined(var_7)) {
    var_10.maxents = var_7;
  }

  var_12 = molotov_create_branch(var_9, var_10, var_11, self, self.caststart, self.castangles, undefined, self.casttype, self.preventstarttime);
  var_12.castfails = self.castfails;
  self.branches[self.branches.size] = var_12;
  var_9.branches[var_9.branches.size] = var_12;

  if(istrue(var_8)) {
    thread molotov_start_branch();
  }

  return var_12;
}

function molotov_branch_create_forward_tendril_cone() {
  molotov_branch_create_sub_branch(32, self.preventstarttime, 35, 8, undefined, 44, undefined, undefined, 1);
}

function molotov_branch_create_left_tendril_cone() {
  molotov_branch_create_sub_branch(32, self.preventstarttime, 35, 8, &molotov_left_tendril_mod_angles, 44, undefined, undefined, 1);
}

function molotov_branch_create_right_tendril_cone() {
  molotov_branch_create_sub_branch(32, self.preventstarttime, 35, 8, &molotov_right_tendril_mod_angles, 44, undefined, undefined, 1);
}

function molotov_branch_create_tendril_radial() {
  molotov_branch_create_sub_branch(32, self.preventstarttime, 35, 8, &molotov_tendril_mod_angles_radial, 44, 6, 1, 1);
}

function molotov_rotate_angles_about_up(var_0, var_1) {
  var_2 = anglesToForward(var_0);
  var_3 = anglestoup(var_0);
  var_4 = undefined;
  var_2 = rotatepointaroundvector(var_3, var_2, var_1);
  var_4 = vectorNormalize(vectorcross(var_2, var_3));
  var_3 = vectorcross(var_4, var_2);
  return axistoangles(var_2, var_4, var_3);
}

function molotov_left_tendril_mod_angles(var_0) {
  var_1 = randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(var_0, var_1);
}

function molotov_right_tendril_mod_angles(var_0) {
  var_1 = -1 * randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(var_0, var_1);
}

function molotov_tendril_mod_angles_radial(var_0) {
  var_1 = randomfloatrange(-60, 60);
  return molotov_rotate_angles_about_up(var_0, var_1);
}

function molotov_get_cast_data(var_0) {
  if(!isDefined(level.molotovdata) || !isDefined(level.molotovdata.castdata)) {
    molotov_init_cast_data();
  }

  var_1 = level.molotovdata.castdata;
  var_2 = spawnStruct();
  var_2.distforward = var_1.distforward[var_0];
  var_2.distdown = var_1.distdown[var_0];
  var_2.distup = var_1.distup[var_0];
  var_2.maxcasts = var_1.maxcasts[var_0];
  var_2.maxfails = var_1.maxfails[var_0];
  var_2.maxents = var_1.maxents[var_0];
  var_2.distforwardwall = var_1.distforwardwall[var_0];

  if(isDefined(var_1.firstforwarddist[var_0])) {
    var_2.firstforwarddist = var_1.firstforwarddist[var_0];
    var_2.firstforwardmindist = var_1.firstforwardmindist[var_0];
    var_2.firstforwardmodanglesfunc = var_1.firstforwardmodanglesfunc[var_0];

    if(isDefined(var_1.firstforwarddistwall[var_0])) {
      var_2.firstforwarddistwall = var_1.firstforwarddistwall[var_0];
    }
  }

  return var_2;
}

function molotov_get_pool_data(var_0) {
  if(!isDefined(level.molotovdata) || !isDefined(level.molotovdata.pooldata)) {
    molotov_init_pool_data();
  }

  var_1 = level.molotovdata.pooldata;
  var_2 = spawnStruct();
  var_2.typeid = var_0;
  var_2.triggerradius = var_1.triggerradius[var_0];
  var_2.triggerheight = var_1.triggerheight[var_0];
  var_2.aikillradius = var_1.aikillradius[var_0];
  var_2.aidamageradius = var_1.aidamageradius[var_0];
  var_2.triggeroffset = var_1.triggeroffset[var_0];
  var_2.startdelayms = var_1.startdelayms[var_0];
  var_2.dangerzoneradius = var_1.dangerzoneradius[var_0];
  var_2.dangerzoneheight = var_1.dangerzoneheight[var_0];
  return var_2;
}

function molotov_get_cast_dir(var_0, var_1) {
  switch (var_1) {
    case 0:
      return anglesToForward(var_0);
    case 1:
      return (-1 * anglestoup(var_0));
    case 2:
      return anglestoup(var_0);
  }

  return undefined;
}

function molotov_get_cast_dist(var_0, var_1, var_2) {
  switch (var_0) {
    case 0:
      if(isDefined(var_1.firstforwarddist)) {
        return var_1.firstforwarddist;
      } else if(var_2 && isDefined(var_1.distforwardwall)) {
        return var_1.distforwardwall;
      } else {
        return var_1.distforward;
      }
    case 1:
      return var_1.distdown;
    case 2:
      return var_1.distup;
  }

  return undefined;
}

function molotov_get_cast_contents() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
}

function molotov_rebuild_angles_up_right(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_0, var_1));
  var_1 = vectorcross(var_2, var_0);
  return axistoangles(var_2, var_1, var_0);
}

function molotov_rebuild_angles_up_forward(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_1, var_0));
  var_1 = vectorcross(var_0, var_2);
  return axistoangles(var_1, var_2, var_0);
}

function molotov_get_next_burning_id() {
  if(!isDefined(level.molotovdata)) {
    level.molotovdata = spawnStruct();
  }

  if(!isDefined(level.molotovdata.burningid)) {
    level.molotovdata.burningid = 0;
  }

  var_0 = level.molotovdata.burningid;
  level.molotovdata.burningid++;
  return var_0;
}

function molotov_watch_fx() {
  self notify("molotov_fx_race");
  self endon("molotov_fx_race");
  var_0 = 0;
  var_1 = spawnStruct();

  if(var_0) {
    GscBinSkip4(0x35, var_1);
  }

  GscBinSkip4(0x35, var_1);
}

function molotov_fx_race_pullback(var_0) {
  self endon("molotov_fx_race_end");

  for(;;) {
    self waittill("grenade_pullback", var_1);

    if(var_1.basename == "molotov_mp") {
      break;
    }
  }

  var_0.pullback = 1;
  self notify("molotov_fx_race_start");
}

function molotov_fx_race_grenade_fired(var_0) {
  self endon("molotov_fx_race_end");

  for(;;) {
    self waittill("grenade_fire", var_1, var_2);

    if(var_2.basename == "molotov_mp") {
      break;
    }
  }

  var_0.fire = 1;
  self notify("molotov_fx_race_start");
}

function molotov_fx_race_super_started(var_0) {
  self endon("molotov_fx_race_end");
  self waittill("super_started");
  var_0.superstarted = 1;
  self notify("molotov_fx_race_start");
}

function molotov_fx_race_death(var_0) {
  self endon("molotov_fx_race_end");
  self waittill("death");
  var_0.death = 1;
  self notify("molotov_fx_race_start");
}

function molotov_fx_race_taken(var_0) {
  self endon("molotov_fx_race_end");
  self waittill("molotov_taken");
  var_0.taken = 1;
  self notify("molotov_fx_race_start");
}

function molotov_fx_race_held_offhand_break(var_0) {
  self endon("molotov_fx_race_end");
  waitframe();
  var_1 = getcompleteweaponname("molotov_mp");

  while(self getheldoffhand() == var_1) {
    waitframe();
  }

  var_0.heldoffhandbreak = 1;
  self notify("molotov_fx_race_start");
}

function molotov_begin_fx() {
  self notify("molotov_begin_fx");
  self endon("molotov_begin_fx");
  self endon("molotov_end_fx");
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "active", 0);
  wait 0.15;
  self setscriptablepartstate("equipMtovFXWorld", "active", 0);
}

function molotov_end_fx() {
  self notify("molotov_end_fx");
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "neutral", 0);
}

function delete_all_molotovs() {
  if(isDefined(level.molotovdata)) {
    foreach(var_1 in level.molotovdata.active) {
      thread delete_molotov(var_1);
    }

    return;
  }
}

function delete_molotov(var_0) {
  if(isDefined(var_0.deleting)) {
    return;
  }

  var_0.deleting = 1;

  while(!isDefined(var_0.initialized)) {
    waitframe();
  }

  while(!molotov_shared_data_is_complete(var_0, 1)) {
    waitframe();
  }

  level notify("explosion_extinguish", var_0.burnsource.origin, 500);
  var_0.burnsource delete();
}