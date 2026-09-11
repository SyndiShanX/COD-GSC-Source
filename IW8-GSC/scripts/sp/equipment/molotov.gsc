/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\molotov.gsc
***********************************************/

function precache(var0) {
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
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var0, &molotovfiremain);
}

function molotovfiremain(var0) {
  jumpiffalse(isPlayer(self) || isai(self)) LOC_0000001a;
  var1 = self;
  goto LOC_00000062;
}

function sortandreturnowner(var0, var1) {
  return sortbydistance(var0, var1.origin)[0];
}

function getlaunchangles(var0) {
  var1 = vectorNormalize(var0 - self.origin);
  var2 = vectortoangles(var1);
  var3 = (0, self.angles[1], 0);
  var4 = var3 + (45, 0, 0);
  return var4;
}

function molotovexplode(var0, var1, var2, var3, var4) {
  var5 = spawn("script_model", var0);
  var5 setModel("offhand_wm_molotov_sp");
  var6 = vectortoangles(var1);
  var7 = anglesToForward(var6);
  var8 = anglestoright(var6);
  var9 = anglestoup(var6);
  var5.angles = axistoangles(var8, var9, var7);
  var5.owner = var4;
  var10 = getlaunchangles(var4, var0);

  if(isDefined(var3) && isDefined(var3.classname) && var3.classname == "worldspawn") {
    var3 = undefined;
  }

  thread molotov_stuck(var5, var3, var10, var2);
}

function pool_damage_scriptables(var0) {
  var1 = self.pooldata.triggerradius * 3;

  foreach(var3 in self.shareddata.scriptables) {
    var4 = distance(var3.origin, var0);

    if(var4 <= var1) {
      if(var3 getscriptableparthasstate("base", "script_ignite")) {
        var3 setscriptablepartstate("base", "script_ignite", 1);
      }
    }
  }
}

function pool_damage_vehicles(var0, var1) {
  var2 = self.pooldata.triggerradius * 5;

  foreach(var4 in self.shareddata.vehicles) {
    var5 = distance(var4.origin, var0);

    if(var5 <= var2) {
      if(var4 isscriptable()) {
        thread molotovburnscriptablevehicle(var4);
        continue;
      }

      thread molotovburnvehicle(var4);
    }
  }
}

function molotovburnscriptablevehicle(var0) {
  self endon("death");
  wait 1;
  var1 = self getscriptablepartstate("body", 1);

  if(!isDefined(var1)) {
    var2 = ["flareup", "onfire"];

    foreach(var4 in var2) {
      if(self getscriptableparthasstate("body", var4)) {
        self setscriptablepartstate("body", var4, 1);
      }

      wait 0.5;
    }

    return;
  }
}

function molotovburnvehicle(var0) {
  self endon("death");
  var0 endon("molotov_pool_end");

  for(;;) {
    scripts\sp\utility::do_damage(75, self.origin, undefined, undefined, "MOD_FIRE");
    wait 0.5;
  }
}

function pool_damage_ai(var0, var1) {
  self.shareddata.ai = scripts\engine\utility::array_removeundefined(self.shareddata.ai);
  self.shareddata.ai = scripts\engine\utility::array_removedead_or_dying(self.shareddata.ai, 0);

  if(isDefined(var1) && isPlayer(var1)) {
    level.moloachievementvictims = 0;
  }

  foreach(var3 in self.shareddata.ai) {
    var4 = distance(var3.origin, var0);
    var5 = 100;

    if(issameteam(var3.team, var1.team)) {
      var6 = self.pooldata.aikillradius * 0.7;
      var7 = self.pooldata.aidamageradius * 0.5;
    } else {
      var6 = self.pooldata.aikillradius;
      var7 = self.pooldata.aidamageradius;
    }

    if(var4 <= var6) {
      thread achievement_watcher(var3, var1);
      molotovburnenemy(var3, 1, var0, var1);
      continue;
    }

    if(var4 <= var7) {
      thread achievement_watcher(var3, var1);
      molotovburnenemy(var3, 0, var0, var1);
    }
  }
}

function issameteam(var0, var1) {
  return isDefined(var0) && isDefined(var1) && var0 == var1;
}

function molotovburnenemy(var0, var1, var2, var3) {
  var0._blackboard.isburning = 1;
  var0.burningtodeath = var1;
  var0.burningdirection = undefined;

  if(var1) {
    if(istrue(var0.flashlight)) {
      var0 scripts\sp\nvg\nvg_ai::flashlight_off(0);
    }

    var0 scripts\engine\sp\utility::anim_stopanimScripted();
    var0 scripts\sp\utility::do_damage(var0.health + 9999, var2, var3, var3, "MOD_FIRE", "molotov");
    var4 = undefined;

    if(var0 isscriptable()) {
      var4 = var0 getscriptablepartstate("burn_to_death_by_molotov", 1);
    }

    if(!isDefined(var4)) {
      thread molotov_burn_sfx(var0);
    }
  } else {
    var5 = anglestoright(var0.angles);
    var6 = vectorNormalize(var2 - var0.origin);

    if(vectordot(var5, var6) > 0) {
      var0.burningdirection = "right";
    } else {
      var0.burningdirection = "left";
    }

    var0 scripts\sp\utility::do_damage(1, var2, var3, var3, "MOD_FIRE", "molotov");
    thread molotov_burn_sfx();
  }

  level thread scripts\sp\equipment\offhands::remove_blackboard_isburning(var0);
}

function achievement_watcher(var0, var1) {
  if(!isai(self)) {
    return;
  }

  if(!isDefined(var0) || !isPlayer(var0)) {
    return;
  }

  if(!istrue(var1.shareddata.thrownoffhand)) {
    return;
  }

  level.moloachievementvictims += 1;

  if(level.moloachievementvictims > 3) {
    level thread scripts\sp\utility::giveachievement_wrapper("ashes");
    return;
  }
}

function vector_empty(var0) {
  return var0 == (0, 0, 0);
}

function molotov_burn_sfx(var0) {
  if(isDefined(var0)) {
    var1 = 1;
  } else {
    var1 = 0.5;
  }

  if(!isDefined(self.burnsfxenabled)) {
    self.burnsfxenabled = 0;
  }

  if(!isDefined(self.burnsfx)) {
    var2 = spawn("script_origin", self.origin);
    var2 linkTo(self);
    self.burnsfx = var2;
    wait 0.05;
  } else {
    var2 = self.burnsfx;
  }

  if(isDefined(self) && self.burnsfxenabled == 0) {
    var2 playLoopSound("weap_molotov_fire_enemy_burn");
    self.burnsfxenabled = 1;
    wait var2;
    var2 playSound("weap_molotov_fire_enemy_burn_end");
    wait 0.15;
    var2 stoploopsound("weap_molotov_fire_enemy_burn");
    var2 delete();

    if(isDefined(self)) {
      self.burnsfxenabled = 1;
      return;
    }

    return;
  }
}

function molotov_fire_sfx(var0, var1) {
  wait 0.1;
  var2 = spawn("script_origin", var0 + (0, 0, 15));
  var2 playLoopSound("weap_molotov_fire_lp");
  wait var1;
  thread scripts\engine\utility::play_sound_in_space("weap_molotov_fire_end", var2.origin);
  var2 scripts\engine\sp\utility::sound_fade_and_delete(1, 1);
}

function molotovviewmodelfiremanager() {
  var0 = getcompleteweaponname("molotov");

  for(;;) {
    self waittill("grenade_pullback", var1);

    if(var1 == var0) {
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
  var0 = level.molotovdata;

  if(!isDefined(var0)) {
    var0 = spawnStruct();
    level.molotovdata = var0;
  }

  var1 = var0.castdata;

  if(!isDefined(var1)) {
    var1 = spawnStruct();
    var0.castdata = var1;
  }

  var1.distforward = [];
  var1.distdown = [];
  var1.distup = [];
  var1.maxcasts = [];
  var1.maxfails = [];
  var1.maxents = [];
  var1.firstforwarddist = [];
  var1.firstforwardmindist = [];
  var1.firstforwardmodanglesfunc = [];
  var2 = 8;
  var1.distforward[var2] = undefined;
  var1.distdown[var2] = undefined;
  var1.distup[var2] = undefined;
  var1.maxcasts[var2] = undefined;
  var1.maxfails[var2] = undefined;
  var1.maxents[var2] = 1;
  var2 = 16;
  var1.distforward[var2] = 50;
  var1.distdown[var2] = 50;
  var1.distup[var2] = 25;
  var1.maxcasts[var2] = 4;
  var1.maxfails[var2] = 3;
  var1.maxents[var2] = 1;
  var1.distforwardwall[var2] = 25;
  var2 = 32;
  var1.distforward[var2] = 15;
  var1.distdown[var2] = 50;
  var1.distup[var2] = 25;
  var1.maxcasts[var2] = 17;
  var1.maxfails[var2] = 3;
  var1.maxents[var2] = 3;
  var1.firstforwarddist[var2] = 85;
  var1.firstforwardmindist[var2] = 8;
  var1.distforwardwall[var2] = 8;
  var1.firstforwarddistwall[var2] = 44;
}

function molotov_init_pool_data() {
  var0 = level.molotovdata;

  if(!isDefined(var0)) {
    var0 = spawnStruct();
    level.molotovdata = var0;
  }

  var1 = var0.pooldata;

  if(!isDefined(var1)) {
    var1 = spawnStruct();
    var0.pooldata = var1;
  }

  var1.triggerradius = [];
  var1.triggerheight = [];
  var1.triggeroffset = [];
  var1.startdelayms = [];
  var2 = 8;
  var1.triggerradius[var2] = 30;
  var1.triggerheight[var2] = 55;
  var1.aikillradius[var2] = 80;
  var1.aidamageradius[var2] = 120;
  var1.triggeroffset[var2] = 15;
  var1.startdelayms[var2] = 0;
  var1.dangerzoneradius[var2] = 350;
  var1.dangerzoneheight[var2] = 128;
  var2 = 16;
  var1.triggerradius[var2] = 30;
  var1.triggerheight[var2] = 55;
  var1.aikillradius[var2] = 55;
  var1.aidamageradius[var2] = 90;
  var1.triggeroffset[var2] = 15;
  var1.startdelayms[var2] = 100;
  var2 = 32;
  var1.triggerradius[var2] = 10;
  var1.triggerheight[var2] = 55;
  var1.aikillradius[var2] = 50;
  var1.aidamageradius[var2] = 80;
  var1.triggeroffset[var2] = 15;
  var1.startdelayms[var2] = 100;
  molotov_init_pool_mask();
}

function molotov_init_pool_mask() {
  var0 = level.molotovdata;

  if(!isDefined(var0)) {
    var0 = spawnStruct();
    level.molotovdata = var0;
  }

  var1 = var0.pooldata;

  if(!isDefined(var1)) {
    var1 = spawnStruct();
    var0.pooldata = var1;
  }

  var2 = [];
  GscBinSkip0(0x2e, 1, "flareUp");
}

function molotov_stuck(var0, var1, var2, var3, var4) {
  var5 = undefined;
  var6 = vectorNormalize(var3);
  var7 = anglestoup(var0.angles);
  var8 = anglestoright(var2);

  if(abs(vectordot(var6, var7)) >= 0.9848) {
    var5 = molotov_rebuild_angles_up_right(var7, var8);
  } else {
    var5 = molotov_rebuild_angles_up_forward(var7, var6);
  }

  var0.angles = var5;
  var0 notify("death");
  var0 setscriptablepartstate("effects", "explode", 0);
  molotov_simulate_impact(var0, var0.origin, var5, var1, var3, gettime(), var4);
}

function molotovbadplace(var0) {
  var1 = createnavbadplacebybounds(var0, (128, 128, 100), (0, 0, 0));

  if(level.dbgmolodrawhits) {
    var2 = int(6250);
  }

  return var1;
}

function molotov_simulate_impact(var0, var1, var2, var3, var4, var5, var6) {
  var7 = level.molotovdata.active.size;
  level.molotovdata.active[var7] = spawnStruct();
  var8 = var0.owner;
  var9 = anglestoup(var2);
  var10 = var1 + var9 * 1;
  var11 = var10 + var9 * 25;
  var12 = molotov_get_cast_contents();
  var13 = getaiarray();
  var13 = scripts\engine\utility::array_add(var13, var0);

  if(level.dbgmolodrawhits) {}

  var14 = physics_raycast(var10, var11, var12, var13, 0, "physicsquery_closest", 1);

  if(isDefined(var14) && var14.size > 0) {
    var11 = var14[0]["position"] - var9 * 1;
  }

  var15 = var11;
  var16 = var0;
  var17 = molotov_get_next_burning_id();
  var18 = 0;
  var19 = 512;
  var20 = vectordot(vectorNormalize(var4), -1 * var9);

  if(var20 < 0.96593) {
    var18 = 1;
    var19 = 1024;
  }

  var21 = molotov_create_shared_data(var8, var5, var19, var16, var17, var6);
  var21.badplace = molotovbadplace(var1);
  var21.scriptables = moltovgetscriptables(var1);
  var21.vehicles = moltovgetvehicles(var1);
  var21.ai = moltovgetai(var1);
  var22 = 8;
  var23 = molotov_get_cast_data(var22);
  var24 = molotov_get_pool_data(var22);
  var25 = molotov_create_branch(var21, var23, var24, undefined, var1, var2, var3);
  var21.branches[var21.branches.size] = var25;
  var26 = 25;
  var27 = 65;
  var28 = 115;
  var29 = gettime() + var24.startdelayms;
  var22 = 16;
  var23 = molotov_get_cast_data(var22);
  var24 = molotov_get_pool_data(var22);
  var30 = &molotov_branch_create_tendril_radial;

  if(var18) {
    var30 = &molotov_branch_create_forward_tendril_cone;
  }

  var25 = molotov_create_branch(var21, var23, var24, undefined, var15, var2, var3, 0, var29, var30);
  var21.branches[var21.branches.size] = var25;
  var31 = anglesToForward(var2);
  var32 = anglestoright(var2);
  var33 = anglestoup(var2);
  var23 = molotov_get_cast_data(var22);
  var24 = molotov_get_pool_data(var22);
  var34 = var31 * -1;
  var35 = var32 * -1;
  var36 = var33;
  var37 = axistoangles(var34, var35, var36);
  var30 = &molotov_branch_create_tendril_radial;

  if(var18) {
    var30 = undefined;
  }

  var25 = molotov_create_branch(var21, var23, var24, undefined, var15, var37, var3, 0, var29, var30);
  var21.branches[var21.branches.size] = var25;
  var23 = molotov_get_cast_data(var22);
  var24 = molotov_get_pool_data(var22);
  var34 = rotatepointaroundvector(var33, var31, var27);
  var35 = vectorNormalize(vectorcross(var34, var33));
  var36 = vectorcross(var35, var31);
  var37 = axistoangles(var34, var35, var36);
  var30 = &molotov_branch_create_tendril_radial;

  if(var18) {
    var30 = &molotov_branch_create_right_tendril_cone;
  }

  var25 = molotov_create_branch(var21, var23, var24, undefined, var15, var37, var3, 0, var29, var30);
  var21.branches[var21.branches.size] = var25;
  var23 = molotov_get_cast_data(var22);
  var24 = molotov_get_pool_data(var22);
  var34 = rotatepointaroundvector(var33, var31, -1 * var27);
  var35 = vectorNormalize(vectorcross(var34, var33));
  var36 = vectorcross(var35, var31);
  var37 = axistoangles(var34, var35, var36);
  var30 = &molotov_branch_create_tendril_radial;

  if(var18) {
    var30 = &molotov_branch_create_left_tendril_cone;
  }

  var25 = molotov_create_branch(var21, var23, var24, undefined, var15, var37, var3, 0, var29, var30);
  var21.branches[var21.branches.size] = var25;
  var23 = molotov_get_cast_data(var22);
  var24 = molotov_get_pool_data(var22);
  var34 = rotatepointaroundvector(var33, var31, var28);
  var35 = vectorNormalize(vectorcross(var34, var33));
  var36 = vectorcross(var35, var31);
  var37 = axistoangles(var34, var35, var36);
  var30 = &molotov_branch_create_tendril_radial;

  if(var18) {
    var30 = undefined;
  }

  var25 = molotov_create_branch(var21, var23, var24, undefined, var15, var37, var3, 0, var29, var30);
  var21.branches[var21.branches.size] = var25;
  var23 = molotov_get_cast_data(var22);
  var24 = molotov_get_pool_data(var22);
  var34 = rotatepointaroundvector(var33, var31, -1 * var28);
  var35 = vectorNormalize(vectorcross(var34, var33));
  var36 = vectorcross(var35, var31);
  var37 = axistoangles(var34, var35, var36);
  var30 = &molotov_branch_create_tendril_radial;

  if(var18) {
    var30 = undefined;
  }

  var25 = molotov_create_branch(var21, var23, var24, undefined, var15, var37, var3, 0, var29, var30);
  var21.branches[var21.branches.size] = var25;
  molotov_shared_data_register_cast(var21);

  foreach(var25 in var21.branches) {
    thread molotov_start_branch();
  }

  thread molotov_cleanup();
  var21.initialized = 1;
  level.molotovdata.active[var7] = var21;
}

function moltovgetscriptables(var0) {
  GscBinSkip1(0x45, 0, "scriptable_container_gas_tank_01");
}

function moltovgetvehicles(var0) {
  var1 = [];
  var2 = getscriptablearray("scriptable", "code_classname");
  var2 = scripts\engine\utility::array_combine(var2, getEntArray("script_vehicle", "code_classname"));

  foreach(var4 in var2) {
    if(!isDefined(var4.model) || !isstartstr(var4.model, "veh8_")) {
      continue;
    }

    var5 = distancesquared(var4.origin, var0);

    if(var5 <= 65536) {
      var1 = scripts\engine\utility::array_add(var1, var4);
    }
  }

  return var1;
}

function moltovgetai(var0) {
  var1 = getaiarray();
  var1 = scripts\engine\utility::array_removeundefined(var1);
  var1 = scripts\engine\utility::array_removedead_or_dying(var1, 0);
  var2 = [];

  foreach(var4 in var1) {
    var5 = distancesquared(var4.origin, var0);

    if(var5 <= 65536) {
      var2 = scripts\engine\utility::array_add(var2, var4);
    }
  }

  return var2;
}

function molotov_cleanup() {
  self.burnsource scripts\engine\utility::waittill_notify_or_timeout("entitydeleted", 6.25);

  for(;;) {
    var0 = 1;

    foreach(var2 in self.branches) {
      if(!istrue(var2.iscomplete)) {
        var0 = 0;
        break;
      }

      if(!var0) {
        break;
      }
    }

    if(var0) {
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

function molotov_create_shared_data(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();
  var6.owner = var0;
  var6.team = var0.team;
  var6.impacttime = var1;
  var6.impactincidence = var2;
  var6.burnsource = var3;
  var6.burnid = var4;
  var6.branches = [];
  var6.thrownoffhand = var5;
  var6.entstotal = 0;
  var6.caststotal = 0;
  var6.caststhisframe = 0;
  var6.frametimestamp = gettime();
  var6.castcontents = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var6.castignore = getaiarray();
  var6.castignore = scripts\engine\utility::array_add(var6.castignore, level.player);
  return var6;
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

function molotov_shared_data_is_complete(var0) {
  var1 = 0;

  if(self.caststotal >= 60) {
    var1 = 1;
  } else if(self.entstotal >= 20) {
    var1 = 1;
  } else if(istrue(var0)) {
    var2 = 1;

    foreach(var4 in self.branches) {
      if(!molotov_branch_is_complete(var4, 1, 1)) {
        var2 = 0;
        break;
      }
    }

    if(var2) {
      var1 = 1;
    }
  }

  if(var1) {
    self.iscomplete = 1;
    self.branches = [];
  }

  return var1;
}

function molotov_create_branch(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = spawnStruct();
  var10.shareddata = var0;
  var10.castdata = var1;
  var10.pooldata = var2;
  var10.startingorigin = var4;
  var10.startingangles = var5;
  var10.startingstuckto = var6;
  var10.startingcasttype = var7;
  var10.oncompletedfunc = var9;
  var10.ents = [];
  var10.branches = [];
  var10.hitpositions = [];
  var10.hittypes = [];
  var10.casts = 0;
  var10.castfails = 0;
  var10.preventstarttime = var8;
  return var10;
}

function molotov_start_branch() {
  if(!isDefined(self.preventstarttime)) {
    self.preventstarttime = gettime();
  }

  if(!isDefined(self.startingcasttype)) {
    if(!molotov_shared_data_is_complete(self.shareddata)) {
      var0 = molotov_branch_create_pool(self.startingorigin, self.startingangles, self.shareddata.impactincidence, self.startingstuckto);
      thread molotov_pool_start();
      pool_damage_scriptables(var0.origin);
      pool_damage_vehicles(var0.origin, var0);
      pool_damage_ai(var0.origin, self.shareddata.owner);
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
      var1 = self.castdata.firstforwardmodanglesfunc;

      if(isDefined(var1)) {
        self.castangles = [[var1]](self.castangles);
        self.castdata.firstforwardmodanglesfunc = undefined;
        self.castdata.iswallcast = undefined;
      }
    }

    if(!isDefined(self.iswallcast)) {
      var2 = vectordot(anglestoup(self.castangles), (0, 0, 1));
      self.iswallcast = var2 > -0.81915 && var2 <= 0.5;

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
    var3 = undefined;
    var4 = undefined;
    var5 = undefined;
    var6 = undefined;
    var7 = undefined;

    if(level.dbgmolodrawhits) {}

    var8 = physics_raycast(self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var8) && var8.size > 0) {
      var3 = 1;
      var4 = var8[0]["position"];
      var5 = var8[0]["normal"];
      var6 = var8[0]["entity"];
    }

    switch (self.casttype) {
      case 0:
        if(istrue(var3)) {
          molotov_branch_register_cast(self.casttype, 0, var4);
          var9 = 1;

          if(isDefined(self.castdata.firstforwarddist)) {
            var10 = var4 - self.caststart;
            var11 = vectordot(var10, self.castdir);
            self.castdata.firstforwarddist -= var11;

            if(self.castdata.firstforwarddist > self.castdata.firstforwardmindist) {
              var9 = 0;
            } else {
              self.castdata.firstforwarddist = undefined;
            }
          }

          var7 = molotov_rebuild_angles_up_right(var5, anglestoright(self.castangles));

          if(var9) {
            var12 = molotov_branch_create_pool(var4, var7, self.shareddata.impactincidence, var6);
            thread molotov_pool_start();
            pool_damage_ai(var12.origin, self.shareddata.owner);
          }

          self.casttype = 2;
          self.caststart = var4 + var5 * 1;
          self.castangles = var7;
          self.iswallcast = undefined;
        } else {
          molotov_branch_register_cast(self.casttype, undefined, undefined);

          if(isDefined(self.castdata.firstforwarddist)) {
            var10 = self.castend - self.caststart;
            var11 = vectordot(var10, self.castdir);
            self.castdata.firstforwarddist -= var11;

            if(self.castdata.firstforwarddist <= self.castdata.firstforwardmindist) {
              self.castdata.firstforwarddist = undefined;
            }
          }

          self.casttype = 1;
          self.caststart = self.castend;
        }

        break;
      case 1:
        if(istrue(var3)) {
          var7 = molotov_rebuild_angles_up_right(var5, anglestoright(self.castangles));
          var12 = molotov_branch_create_pool(var4, var7, self.shareddata.impactincidence, var6);
          thread molotov_pool_start();
          pool_damage_ai(var12.origin, self.shareddata.owner);
          var13 = vectordot(anglestoup(self.castangles), var5);

          if(var13 < 0.9848) {
            molotov_branch_register_cast(self.casttype, 2, var4);
            self.casttype = 2;
            self.caststart = var4 + var5 * 1;
            self.castangles = var7;
          } else {
            molotov_branch_register_cast(self.casttype, 1, var4);
            self.casttype = 0;
          }
        } else {
          molotov_branch_register_cast(self.casttype, undefined, undefined);
          self.caststart = self.castend;
        }

        break;
      case 2:
        if(istrue(var3)) {
          molotov_branch_register_cast(self.casttype, 3, var4);
          self.casttype = 0;
          self.caststart = var4 + var5 * 1;
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

function molotov_branch_is_complete(var0, var1) {
  var2 = 0;
  var3 = undefined;

  if(!istrue(var1)) {
    var2 = molotov_shared_data_is_complete(self.shareddata);
  }

  if(!var2) {
    if(isDefined(self.castdata) && isDefined(self.castdata.maxfails) && self.castfails >= self.castdata.maxfails) {
      var2 = 1;
    } else if(isDefined(self.castdata) && isDefined(self.castdata.maxcasts) && self.casts >= self.castdata.maxcasts) {
      var2 = 1;
    } else if(isDefined(self.castdata) && isDefined(self.castdata.maxents) && self.ents.size >= self.castdata.maxents) {
      var2 = 1;
    } else if(istrue(var0) && self.branches.size > 0) {
      var3 = 1;

      foreach(var5 in self.branches) {
        if(!molotov_branch_is_complete(var5, var0, var1)) {
          var3 = 0;
          break;
        }
      }

      if(var3) {
        var2 = 1;
      }
    }
  }

  if(var2 && !istrue(self.iscomplete)) {
    var7 = self.oncompletedfunc;
    self.oncompletedfunc = undefined;

    if(isDefined(var7)) {
      self[[var7]]();
    }

    if(istrue(var3)) {
      var2 = 0;

      foreach(var5 in self.branches) {
        if(!molotov_branch_is_complete(var5, 1, var1)) {
          var3 = 0;
          break;
        }
      }

      if(var3) {
        var2 = 1;
      }
    }
  }

  if(var2) {
    self.iscomplete = 1;
    self.branches = [];
  }

  return var2;
}

function molotov_branch_register_cast(var0, var1, var2) {
  molotov_shared_data_register_cast(self.shareddata);
  self.casts++;

  if(isDefined(var1)) {
    if(var1 == 0 || var1 == 1 || var1 == 2) {
      self.castfails = 0;
      return;
    }

    return;
  }

  if(var0 == 1) {
    self.castfails++;
    return;
  }
}

function molotov_create_pool(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = spawn("script_model", var0);
  var9.angles = var1;
  var9.stuckto = var2;
  var9.owner = var3;
  var9.burnsource = var4;
  var9.burnid = var5;
  var9.starttime = var6;
  var9.pooldata = var7;
  var9.poolmask = var8;
  var9 setModel("equip_molotov_pool_mp");

  if(isDefined(var3)) {
    var9 setotherent(var3);
    var9 setentityowner(var3);
  }

  if(poolshouldlink(var2)) {
    var9 linkTo(var2);
  }

  return var9;
}

function poolshouldlink(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(var0 == level.player) {
    return false;
  }

  if(isai(var0)) {
    return false;
  }

  return true;
}

function molotov_branch_create_pool(var0, var1, var2, var3) {
  var4 = self.pooldata.typeid;
  var5 = anglestoup(var1);
  var6 = vectordot(var5, (0, 0, 1));

  if(var6 <= -0.81915) {
    var4 |= 256;
  } else if(var6 <= 0.5) {
    var4 |= 128;
  } else {
    var4 |= 64;
  }

  var4 |= var2;
  var7 = self.preventstarttime + self.pooldata.startdelayms;
  var8 = molotov_create_pool(var0, var1, var3, self.shareddata.owner, self.shareddata.burnsource, self.shareddata.burnid, var7, self.pooldata, var4);
  self.preventstarttime = var7;
  self.ents[self.ents.size] = var8;
  molotov_shared_data_register_ent(self.shareddata);
  return var8;
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
  var0 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle", "physicscontents_explosionclip"]);

  for(;;) {
    level waittill("explosion_extinguish", var1, var2, var3, var4);

    if(distancesquared(var1, self.origin) > var2 * var2) {
      continue;
    }

    if(!isDefined(var4)) {
      var4 = [];
      var4 = self;
      var4 = self.burnsource;
    } else if(isarray(var4)) {
      var4 = self;
      var4 = self.burnsource;
    } else {
      var5 = var4;
      var4 = [];
      var4 = self;
      var4 = self.burnsource;
      var4 = var5;
    }

    var6 = min(15, self.pooldata.triggerheight);
    var7 = self.origin + anglestoup(self.angles) * var6;
    var8 = physics_raycast(self.origin, var1, var0, var4, 0, "physicsquery_closest", 1);

    if(isDefined(var8) && var8.size > 0) {
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

function molotov_pool_end(var0) {
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

  if(!istrue(var0)) {
    wait 1;
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self setscriptablepartstate("decal", "neutral", 0);
  wait 3.5;
  self delete();
}

function molotov_create_pool_trigger(var0, var1, var2, var3, var4) {
  var5 = self.origin - anglestoup(self.angles) * var2;
  var6 = spawn("trigger_radius_fire", var5, 0, var0, var1);
  var6.script_multiplier = 10;
  var6.script_radius = var0;
  var6.angles = self.angles;
  thread scripts\sp\trigger::trigger_fire(var6);
  level notify("molotov_fire_trigger", var6);
  var6 enablelinkTo();
  var6 linkTo(self);
  var6 hide();
  var7 = spawnStruct();
  var7.trigger = var6;
  var7.attacker = self.owner;
  var7.inflictor = self.burnsource;
  var7.killcament = self.burnsource;
  var7.burnid = self.burnid;
  var7.playersintrigger = [];
  var6.struct = var7;

  if(isDefined(var3)) {}

  return var6;
}

function molotov_pool_update_scriptable() {
  var0 = level.molotovdata.pooldata;
  var1 = self.poolmask & 7;
  var2 = 1;
  var3 = var2;

  while((var3 & 7) > 0) {
    var4 = ~(7 &~var3) &self.poolmask;
    var5 = var0.scriptableparts[var3];
    var6 = var0.scriptablestates[var4];
    self setscriptablepartstate(var5, var6, 0);
    var3 <<= 1;
  }
}

function molotov_branch_create_sub_branch(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = self.shareddata;
  var10 = molotov_get_cast_data(var0);
  var11 = molotov_get_pool_data(var0);

  if(isDefined(self.castdata)) {
    if(self.castfails > self.castdata.maxfails) {
      return;
    }

    if(self.castfails > var10.maxfails) {
      return;
    }
  }

  if(isDefined(var2)) {
    var10.firstforwarddist = var2;
  }

  if(isDefined(var3)) {
    var10.firstforwardmindist = var3;
  }

  if(isDefined(var4)) {
    var10.firstforwardmodanglesfunc = var4;
  }

  if(isDefined(var5)) {
    var10.firstforwarddistwall = var5;
  }

  if(isDefined(var6)) {
    var10.maxcasts = var6;
  }

  if(isDefined(var7)) {
    var10.maxents = var7;
  }

  var12 = molotov_create_branch(var9, var10, var11, self, self.caststart, self.castangles, undefined, self.casttype, self.preventstarttime);
  var12.castfails = self.castfails;
  self.branches[self.branches.size] = var12;
  var9.branches[var9.branches.size] = var12;

  if(istrue(var8)) {
    thread molotov_start_branch();
  }

  return var12;
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

function molotov_rotate_angles_about_up(var0, var1) {
  var2 = anglesToForward(var0);
  var3 = anglestoup(var0);
  var4 = undefined;
  var2 = rotatepointaroundvector(var3, var2, var1);
  var4 = vectorNormalize(vectorcross(var2, var3));
  var3 = vectorcross(var4, var2);
  return axistoangles(var2, var4, var3);
}

function molotov_left_tendril_mod_angles(var0) {
  var1 = randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(var0, var1);
}

function molotov_right_tendril_mod_angles(var0) {
  var1 = -1 * randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(var0, var1);
}

function molotov_tendril_mod_angles_radial(var0) {
  var1 = randomfloatrange(-60, 60);
  return molotov_rotate_angles_about_up(var0, var1);
}

function molotov_get_cast_data(var0) {
  if(!isDefined(level.molotovdata) || !isDefined(level.molotovdata.castdata)) {
    molotov_init_cast_data();
  }

  var1 = level.molotovdata.castdata;
  var2 = spawnStruct();
  var2.distforward = var1.distforward[var0];
  var2.distdown = var1.distdown[var0];
  var2.distup = var1.distup[var0];
  var2.maxcasts = var1.maxcasts[var0];
  var2.maxfails = var1.maxfails[var0];
  var2.maxents = var1.maxents[var0];
  var2.distforwardwall = var1.distforwardwall[var0];

  if(isDefined(var1.firstforwarddist[var0])) {
    var2.firstforwarddist = var1.firstforwarddist[var0];
    var2.firstforwardmindist = var1.firstforwardmindist[var0];
    var2.firstforwardmodanglesfunc = var1.firstforwardmodanglesfunc[var0];

    if(isDefined(var1.firstforwarddistwall[var0])) {
      var2.firstforwarddistwall = var1.firstforwarddistwall[var0];
    }
  }

  return var2;
}

function molotov_get_pool_data(var0) {
  if(!isDefined(level.molotovdata) || !isDefined(level.molotovdata.pooldata)) {
    molotov_init_pool_data();
  }

  var1 = level.molotovdata.pooldata;
  var2 = spawnStruct();
  var2.typeid = var0;
  var2.triggerradius = var1.triggerradius[var0];
  var2.triggerheight = var1.triggerheight[var0];
  var2.aikillradius = var1.aikillradius[var0];
  var2.aidamageradius = var1.aidamageradius[var0];
  var2.triggeroffset = var1.triggeroffset[var0];
  var2.startdelayms = var1.startdelayms[var0];
  var2.dangerzoneradius = var1.dangerzoneradius[var0];
  var2.dangerzoneheight = var1.dangerzoneheight[var0];
  return var2;
}

function molotov_get_cast_dir(var0, var1) {
  switch (var1) {
    case 0:
      return anglesToForward(var0);
    case 1:
      return (-1 * anglestoup(var0));
    case 2:
      return anglestoup(var0);
  }

  return undefined;
}

function molotov_get_cast_dist(var0, var1, var2) {
  switch (var0) {
    case 0:
      if(isDefined(var1.firstforwarddist)) {
        return var1.firstforwarddist;
      } else if(var2 && isDefined(var1.distforwardwall)) {
        return var1.distforwardwall;
      } else {
        return var1.distforward;
      }
    case 1:
      return var1.distdown;
    case 2:
      return var1.distup;
  }

  return undefined;
}

function molotov_get_cast_contents() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
}

function molotov_rebuild_angles_up_right(var0, var1) {
  var2 = vectorNormalize(vectorcross(var0, var1));
  var1 = vectorcross(var2, var0);
  return axistoangles(var2, var1, var0);
}

function molotov_rebuild_angles_up_forward(var0, var1) {
  var2 = vectorNormalize(vectorcross(var1, var0));
  var1 = vectorcross(var0, var2);
  return axistoangles(var1, var2, var0);
}

function molotov_get_next_burning_id() {
  if(!isDefined(level.molotovdata)) {
    level.molotovdata = spawnStruct();
  }

  if(!isDefined(level.molotovdata.burningid)) {
    level.molotovdata.burningid = 0;
  }

  var0 = level.molotovdata.burningid;
  level.molotovdata.burningid++;
  return var0;
}

function molotov_watch_fx() {
  self notify("molotov_fx_race");
  self endon("molotov_fx_race");
  var0 = 0;
  var1 = spawnStruct();

  if(var0) {
    GscBinSkip4(0x35, var1);
  }

  GscBinSkip4(0x35, var1);
}

function molotov_fx_race_pullback(var0) {
  self endon("molotov_fx_race_end");

  for(;;) {
    self waittill("grenade_pullback", var1);

    if(var1.basename == "molotov_mp") {
      break;
    }
  }

  var0.pullback = 1;
  self notify("molotov_fx_race_start");
}

function molotov_fx_race_grenade_fired(var0) {
  self endon("molotov_fx_race_end");

  for(;;) {
    self waittill("grenade_fire", var1, var2);

    if(var2.basename == "molotov_mp") {
      break;
    }
  }

  var0.fire = 1;
  self notify("molotov_fx_race_start");
}

function molotov_fx_race_super_started(var0) {
  self endon("molotov_fx_race_end");
  self waittill("super_started");
  var0.superstarted = 1;
  self notify("molotov_fx_race_start");
}

function molotov_fx_race_death(var0) {
  self endon("molotov_fx_race_end");
  self waittill("death");
  var0.death = 1;
  self notify("molotov_fx_race_start");
}

function molotov_fx_race_taken(var0) {
  self endon("molotov_fx_race_end");
  self waittill("molotov_taken");
  var0.taken = 1;
  self notify("molotov_fx_race_start");
}

function molotov_fx_race_held_offhand_break(var0) {
  self endon("molotov_fx_race_end");
  waitframe();
  var1 = getcompleteweaponname("molotov_mp");

  while(self getheldoffhand() == var1) {
    waitframe();
  }

  var0.heldoffhandbreak = 1;
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
    foreach(var1 in level.molotovdata.active) {
      thread delete_molotov(var1);
    }

    return;
  }
}

function delete_molotov(var0) {
  if(isDefined(var0.deleting)) {
    return;
  }

  var0.deleting = 1;

  while(!isDefined(var0.initialized)) {
    waitframe();
  }

  while(!molotov_shared_data_is_complete(var0, 1)) {
    waitframe();
  }

  level notify("explosion_extinguish", var0.burnsource.origin, 500);
  var0.burnsource delete();
}