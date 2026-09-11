/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\powers\coop_molotov.gsc
***********************************************/

function molotov_init() {
  var0 = spawnStruct();
  level.molotov = var0;
  var0.ref_11b6e = getdvarint("scr_molotovMaxPools", 100);
  var0.ref_11b57 = getdvarint("scr_molotovMaxCastsPerFrame", 8);
  var0.start_airfield_safehouse = getdvarint("scr_molotovInstantCleanup", 1) > 0;
  var0.ref_13f0c = 0;
  var0.ref_127e4 = [];
  var0.scriptables = [];
  var0.triggers = [];
  var0.frametimestamp = 0;
  var0.caststhisframe = 0;
  molotov_init_cast_data();
  molotov_init_pool_data();
  level.g_effect["vfx_burn_med_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx");
  level.g_effect["vfx_burn_sml_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx");
  level.g_effect["vfx_burn_sml_head_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx");
}

function molotov_init_cast_data() {
  var0 = ref_11cc2();
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
  var2 = 4;
  var1.distforward[var2] = undefined;
  var1.distdown[var2] = undefined;
  var1.distup[var2] = undefined;
  var1.maxcasts[var2] = undefined;
  var1.maxfails[var2] = undefined;
  var1.maxents[var2] = 1;
  var2 = 8;
  var1.distforward[var2] = 50;
  var1.distdown[var2] = 50;
  var1.distup[var2] = 25;
  var1.maxcasts[var2] = 4;
  var1.maxfails[var2] = 3;
  var1.maxents[var2] = 1;
  var1.distforwardwall[var2] = 25;
  var2 = 16;
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
  var0 = ref_11cc2();
  var1 = var0.pooldata;

  if(!isDefined(var1)) {
    var1 = spawnStruct();
    var0.pooldata = var1;
  }

  var1.triggerradius = [];
  var1.triggerheight = [];
  var1.triggeroffset = [];
  var1.startdelayms = [];
  var2 = 4;
  var1.triggerradius[var2] = 30;
  var1.triggerheight[var2] = 55;
  var1.triggeroffset[var2] = 15;
  var1.startdelayms[var2] = 0;
  var2 = 8;
  var1.triggerradius[var2] = 30;
  var1.triggerheight[var2] = 55;
  var1.triggeroffset[var2] = 15;
  var1.startdelayms[var2] = 100;
  var2 = 16;
  var1.triggerradius[var2] = 10;
  var1.triggerheight[var2] = 55;
  var1.triggeroffset[var2] = 15;
  var1.startdelayms[var2] = 100;
  molotov_init_pool_mask();
}

function molotov_init_pool_mask() {
  var0 = ref_11cc3();
  var1 = [];
  GscBinSkip0(0x2e, 4, "coreCenter");
}

function molotov_on_give(var0, var1) {
  thread molotov_watch_fx();
}

function molotov_on_take(var0, var1) {
  self notify("molotov_taken");
}

function molotov_used(var0) {
  var0 endon("death");
  var1 = self getgunangles();
  var2 = gettime();
  var3 = anglesToForward(var1) * 940 + anglestoup(var1) * 120;

  if(isDefined(self.offhands)) {
    self.offhands.lastusedoffhandtime = 0;
  }

  thread molotov_cleanup_grenade(var0);
  var4 = self.name;
  var0 waittill("missile_stuck", var5);
  level notify("grenade_exploded_during_stealth", var0, "molotov_mp", var4);
  var6 = (gettime() - var2) / 1000;
  var7 = var3 + (0, 0, -800 * var6);

  if(isPlayer(self)) {
    self.ascender_deathwatcher = postspawn_vindia();
    thread ref_14445(self.ascender_deathwatcher);
  }

  if(isDefined(var5) && (isPlayer(var5) || isagent(var5))) {
    thread molotov_stuck_player(var0, var5, var1, var7);
    return;
  }

  thread molotov_stuck(var0, var5, var1, var7);
}

function bomber_shouldusetraversals(var0, var1) {
  var2 = gettime();
  var3 = var0.origin;
  var4 = var0.angles;
  var1 waittill("missile_stuck", var5, var6, var7, var8, var9, var10);
  var11 = getlaunchangles(var3, var4, var9);
  var12 = var8;
  var13 = (gettime() - var2) / 1000;
  var14 = var12 + (0, 0, -800 * var13);

  if(isDefined(var0)) {
    var1.owner = var0;
  }

  if(isDefined(var5) && (isPlayer(var5) || isagent(var5))) {
    thread molotov_stuck_player(level, var1, var5, var11);
    return;
  }

  thread molotov_stuck(level, var1, var5, var11);
}

function getlaunchangles(var0, var1, var2) {
  var3 = vectorNormalize(var2 - var0);
  var4 = vectortoangles(var3);
  var5 = (0, var1[1], 0);
  var6 = var5 + (45, 0, 0);
  return var6;
}

function postspawn_vindia() {
  return scripts\cp\utility\player::getuniqueid();
}

function ref_14445(var0) {
  self notify("watch_for_ashes_achievement");
  self endon("watch_for_ashes_achievement");
  self endon("kill_instance_of_molotov" + var0);
  self endon("disconnect");
  level endon("game_ended");
  self.moloachievementvictims = 0;

  if(istrue(self.scriptedspawns)) {
    return;
  }

  for(;;) {
    if(self.moloachievementvictims > 3) {
      self giveachievement("ashes");
      self.scriptedspawns = 1;
      self notify("kill_instance_of_molotov" + var0);
    }

    waitframe();
  }
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
  var0.exploding = 1;
  var0 setscriptablepartstate("effects", "explode", 0);

  if(!isDefined(var4)) {
    var0 missilehidetrail();
  }

  molotov_simulate_impact(var0, var0.origin, var5, var1, var3, gettime());
}

function molotov_stuck_player(var0, var1, var2, var3) {
  scripts\cp\cp_weapon::grenadestuckto(var0, var1);
  var4 = 1;

  if(isagent(var1) && istrue(var1.clearsoundsubmixmpbrinfilanim)) {
    var5 = -1 * vectorNormalize((var3[0], var3[1], 0));
    var6 = -1 * vectorNormalize(var3);

    if(vectordot(anglesToForward(var1.angles), var5) > 0.5 && -0.5 < var6[2] && var6[2] < 0.5) {
      var4 = 0;
    }
  }

  if(var4) {
    thread molotov_burn_for_time(var1, 6, self, var0);
  }

  var0.exploding = 1;
  var0 setscriptablepartstate("effects", "explode", 0);
  var0 missilehidetrail();
  var3 *= (0, 0, 1);
  var7 = var0.origin;
  var8 = (0, 0, -1);
  var9 = var7 + var8 * 128;
  var10 = molotov_get_cast_contents();
  var11 = physics_raycast(var7, var9, var10, var0, 0, "physicsquery_closest", 1);

  if(isDefined(var11) && var11.size > 0) {
    var9 = var11[0]["position"];
    var12 = var11[0]["normal"];
    var13 = var11[0]["entity"];
    var9 -= var12 * 1;
    var14 = vectordot(var9 - var7, var8);
    var15 = sqrt(2 * var14 / 800);
    var16 = var12;
    var17 = anglestoright(var2);
    var18 = molotov_rebuild_angles_up_right(var16, var17);
    thread molotov_simulate_impact(var0, var9, var18, var13, var3, gettime() + var15 * 1000);
    return;
  }

  var9 notify("death");
  waitframe();

  if(isDefined(var9)) {
    var9 delete();
    return;
  }
}

function molotovbadplace(var0) {
  var1 = createnavbadplacebybounds(var0, (128, 128, 100), (0, 0, 0));
  return var1;
}

function molotov_simulate_impact(var0, var1, var2, var3, var4, var5) {
  var6 = var0.owner;
  var7 = scripts\engine\utility::ter_op(level.players.size > 15, 10, 20);
  var8 = anglestoup(var2);
  var9 = var1 + var8 * 1;
  var10 = var9 + var8 * 25;
  var11 = molotov_get_cast_contents();
  var12 = physics_raycast(var9, var10, var11, var0, 0, "physicsquery_closest", 1);

  if(isDefined(var12) && var12.size > 0) {
    var10 = var12[0]["position"] - var8 * 1;
  }

  var13 = var10;
  var14 = var0;
  thread molotov_cleanup_burn_source();
  var15 = molotov_get_next_burning_id();
  var16 = 0;
  var17 = vectordot(vectorNormalize(var4), -1 * var8);

  if(var17 < 0.96593) {
    var16 = 1;
  }

  var18 = molotov_create_shared_data(var6, var5, var14, var15);
  var18.badplace = molotovbadplace(var1);
  thread molotov_cleanup();
  var19 = 4;
  var20 = molotov_get_cast_data(var19);
  var21 = molotov_get_pool_data(var19);
  var22 = molotov_create_branch(var18, var20, var21, undefined, var1, var2, var3);
  var18.branches[var18.branches.size] = var22;
  var23 = 25;
  var24 = 65;
  var25 = 115;
  var26 = gettime() + var21.startdelayms;
  var19 = 8;
  var20 = molotov_get_cast_data(var19);
  var21 = molotov_get_pool_data(var19);
  var27 = &molotov_branch_create_tendril_radial;

  if(var16) {
    var27 = &molotov_branch_create_forward_tendril_cone;
  }

  var22 = molotov_create_branch(var18, var20, var21, undefined, var13, var2, var3, 0, var26, var27);
  var18.branches[var18.branches.size] = var22;
  var28 = anglesToForward(var2);
  var29 = anglestoright(var2);
  var30 = anglestoup(var2);
  var20 = molotov_get_cast_data(var19);
  var21 = molotov_get_pool_data(var19);
  var31 = var28 * -1;
  var32 = var29 * -1;
  var33 = var30;
  var34 = axistoangles(var31, var32, var33);
  var27 = &molotov_branch_create_tendril_radial;

  if(var16) {
    var27 = undefined;
  }

  var22 = molotov_create_branch(var18, var20, var21, undefined, var13, var34, var3, 0, var26, var27);
  var18.branches[var18.branches.size] = var22;
  var20 = molotov_get_cast_data(var19);
  var21 = molotov_get_pool_data(var19);
  var31 = rotatepointaroundvector(var30, var28, var24);
  var32 = vectorNormalize(vectorcross(var31, var30));
  var33 = vectorcross(var32, var28);
  var34 = axistoangles(var31, var32, var33);
  var27 = &molotov_branch_create_tendril_radial;

  if(var16) {
    var27 = &molotov_branch_create_right_tendril_cone;
  }

  var22 = molotov_create_branch(var18, var20, var21, undefined, var13, var34, var3, 0, var26, var27);
  var18.branches[var18.branches.size] = var22;
  var20 = molotov_get_cast_data(var19);
  var21 = molotov_get_pool_data(var19);
  var31 = rotatepointaroundvector(var30, var28, -1 * var24);
  var32 = vectorNormalize(vectorcross(var31, var30));
  var33 = vectorcross(var32, var28);
  var34 = axistoangles(var31, var32, var33);
  var27 = &molotov_branch_create_tendril_radial;

  if(var16) {
    var27 = &molotov_branch_create_left_tendril_cone;
  }

  var22 = molotov_create_branch(var18, var20, var21, undefined, var13, var34, var3, 0, var26, var27);
  var18.branches[var18.branches.size] = var22;
  var20 = molotov_get_cast_data(var19);
  var21 = molotov_get_pool_data(var19);
  var31 = rotatepointaroundvector(var30, var28, var25);
  var32 = vectorNormalize(vectorcross(var31, var30));
  var33 = vectorcross(var32, var28);
  var34 = axistoangles(var31, var32, var33);
  var27 = &molotov_branch_create_tendril_radial;

  if(var16) {
    var27 = undefined;
  }

  var22 = molotov_create_branch(var18, var20, var21, undefined, var13, var34, var3, 0, var26, var27);
  var18.branches[var18.branches.size] = var22;
  var20 = molotov_get_cast_data(var19);
  var21 = molotov_get_pool_data(var19);
  var31 = rotatepointaroundvector(var30, var28, -1 * var25);
  var32 = vectorNormalize(vectorcross(var31, var30));
  var33 = vectorcross(var32, var28);
  var34 = axistoangles(var31, var32, var33);
  var27 = &molotov_branch_create_tendril_radial;

  if(var16) {
    var27 = undefined;
  }

  var22 = molotov_create_branch(var18, var20, var21, undefined, var13, var34, var3, 0, var26, var27);
  var18.branches[var18.branches.size] = var22;
  ref_11cc7(var18);

  foreach(var22 in var18.branches) {
    thread molotov_start_branch();
  }
}

function molotov_cleanup() {
  self.burnsource scripts\engine\utility::waittill_notify_or_timeout("entitydeleted", 6.75);

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

  if(isDefined(self.badplace)) {
    destroynavobstacle(self.badplace);
    return;
  }
}

function molotov_create_shared_data(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.owner = var0;
  var4.team = var0.team;
  var4.impacttime = var1;
  var4.burnsource = var2;
  var4.burnid = var3;
  var4.branches = [];
  var4.ref_12f6e = 0;
  var4.caststotal = 0;
  var4.caststhisframe = 0;
  var4.frametimestamp = gettime();
  var4.castcontents = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var2.shareddata = var4;
  return var4;
}

function ref_11cc7(var0) {
  var0.caststotal++;
  var0.caststhisframe++;
  var0.frametimestamp = gettime();
  var1 = ref_11cc2();
  var1.caststhisframe++;
}

function ref_11cc8(var0) {
  var0.ref_12f6e++;
  var1 = ref_11cc2();
  var1.scriptables[self.id] = self;

  if(var1.scriptables.size > var1.ref_11b6e) {
    ref_11cbc();
    return;
  }
}

function ref_11cc9(var0) {
  var1 = ref_11cc2();
  var1.triggers[self.id] = self;

  if(var1.triggers.size > var1.ref_11b6e) {
    ref_11cbd();
    return;
  }
}

function ref_11cbf() {
  var0 = ref_11cc2();
  var0.scriptables[self.id] = undefined;
  var1 = var0.triggers[self.id];

  if(!isDefined(var1)) {
    var0.ref_127e4 = scripts\engine\utility::array_remove(var0.ref_127e4, self.id);
  }

  self notify("death");
  self freescriptable();
}

function ref_11cc0() {
  var0 = ref_11cc2();
  var0.triggers[self.id] = undefined;
  var1 = var0.scriptables[self.id];

  if(!isDefined(var1)) {
    var0.ref_127e4 = scripts\engine\utility::array_remove(var0.ref_127e4, self.id);
  }

  self delete();
}

function ref_11cbc(var0) {
  var1 = ref_11cc2();
  var2 = undefined;
  var3 = undefined;

  foreach(var3 in var1.ref_127e4) {
    var2 = var1.scriptables[var3];

    if(isDefined(var2)) {
      break;
    }
  }

  var0 = istrue(var0) || var1.start_airfield_safehouse;

  if(!isDefined(var2)) {
    ref_11cbe(var3, var0);
    return;
  }
}

function ref_11cbd(var0) {
  var1 = ref_11cc2();
  var2 = undefined;
  var3 = undefined;

  foreach(var3 in var1.ref_127e4) {
    var2 = var1.triggers[var3];

    if(isDefined(var2)) {
      break;
    }
  }

  var0 = istrue(var0) || var1.start_airfield_safehouse;

  if(isDefined(var2)) {
    ref_11cbe(var3, var0);
    return;
  }
}

function ref_11cbe(var0, var1) {
  var2 = ref_11cc2();
  var3 = var2.scriptables[var0];

  if(isDefined(var3)) {
    if(!istrue(var1)) {
      var2.scriptables[var0] = undefined;
      var2.triggers[var0] = undefined;
      var2.ref_127e4 = scripts\engine\utility::array_remove(var2.ref_127e4, var0);
      thread molotov_pool_end();
      return;
    }

    thread ref_11cbf();
  }

  var4 = var2.triggers[var0];

  if(isDefined(var4)) {
    thread ref_11cc0();
    return;
  }
}

function ref_11cb3(var0) {
  if(var0.frametimestamp < gettime()) {
    var0.frametimestamp = gettime();
    var0.caststhisframe = 0;
  }

  if(var0.caststhisframe >= 3) {
    return false;
  }

  var1 = ref_11cc2();

  if(var1.frametimestamp < gettime()) {
    var1.frametimestamp = gettime();
    var1.caststhisframe = 0;
  }

  if(var1.caststhisframe >= var1.ref_11b57) {
    return false;
  }

  return true;
}

function molotov_shared_data_is_complete(var0) {
  var1 = 0;
  var2 = 60;
  var3 = 20;

  if(self.caststotal >= var2) {
    var1 = 1;
  } else if(self.ref_12f6e >= var3) {
    var1 = 1;
  } else if(istrue(var0)) {
    var4 = 1;

    foreach(var6 in self.branches) {
      if(!molotov_branch_is_complete(var6, 1, 1)) {
        var4 = 0;
        break;
      }
    }

    if(var4) {
      var1 = 1;
    }
  }

  if(var1) {
    self.iscomplete = 1;
    ref_11cca();
    self.branches = [];
  }

  return var1;
}

function ref_11cca() {
  var0 = self;

  if(isDefined(self.shareddata)) {
    var0 = self.shareddata;
  }

  if(!isDefined(var0.ref_11fc8)) {
    var0.ref_11fc8 = [];
  }

  foreach(var2 in self.branches) {
    foreach(var4 in var2.ents) {
      if(isDefined(var4)) {
        var0.ref_11fc8[var0.ref_11fc8.size] = var4;
      }
    }
  }
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
  self endon("cleanup_branch");

  if(!isDefined(self.preventstarttime)) {
    self.preventstarttime = gettime();
  }

  if(!isDefined(self.startingcasttype)) {
    if(!molotov_shared_data_is_complete(self.shareddata)) {
      var0 = molotov_branch_create_pool(self.startingorigin, self.startingangles, self.startingstuckto);
      var0 = thread molotov_pool_start();
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

    if(!ref_11cb3(self.shareddata)) {
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
            var12 = molotov_branch_create_pool(var4, var7, var6);
            thread molotov_pool_start();
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
          var12 = molotov_branch_create_pool(var4, var7, var6);
          thread molotov_pool_start();
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
    ref_11cca();
    self.branches = [];
  }

  return var2;
}

function molotov_branch_register_cast(var0, var1, var2) {
  ref_11cc7(self.shareddata);
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

function molotov_create_pool(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = easepower("equip_molotov_pool_mp_p", var0, var1);
  var10.stuckto = var2;
  var10.owner = var3;
  var10.burnsource = var4;
  var10.burnid = var5;
  var10.starttime = var6;
  var10.pooldata = var7;
  var10.poolmask = var8;
  var10.id = var9;

  if(isDefined(var2)) {
    var11 = rotatevectorinverted(var0 - var2.origin, var2.angles);
    var12 = combineangles(invertangles(var2.angles), var1);
    var10 validatecollision(var2, var11, var12);
  }

  return var10;
}

function molotov_branch_create_pool(var0, var1, var2) {
  var3 = self.pooldata.typeid;
  var4 = anglestoup(var1);
  var5 = vectordot(var4, (0, 0, 1));

  if(var5 <= -0.81915) {
    var3 |= 128;
  } else if(var5 <= 0.5) {
    var3 |= 64;
  } else {
    var3 |= 32;
  }

  var6 = self.preventstarttime + self.pooldata.startdelayms;
  var7 = molotov_create_pool(var0, var1, var2, self.shareddata.owner, self.shareddata.burnsource, self.shareddata.burnid, var6, self.pooldata, var3);
  self.preventstarttime = var6;
  self.ents[self.ents.size] = var7;
  var7.id = ref_11cc4();
  ref_11cc8(var7, self.shareddata);
  return var7;
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
  thread molotov_pool_end();
}

function molotov_watch_pool() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self.stuckto)) {
    self.stuckto endon("death");
  }

  self notify("molotov_pool_watch");
  self.trigger = molotov_create_pool_trigger(self.pooldata.triggerradius, self.pooldata.triggerheight, self.pooldata.triggeroffset);
  self.poolmask |= 1;
  molotov_pool_update_scriptable();
  var0 = randomfloatrange(6.5, 6.75);
  wait var0;
}

function molotov_pool_end() {
  self endon("death");

  if(istrue(self.ended)) {
    return;
  }

  self notify("molotov_pool_end");
  self.ended = 1;
  self.poolmask &= ~1;
  self.poolmask |= 2;
  molotov_pool_update_scriptable();
  wait 1;

  if(isDefined(self.trigger)) {
    thread ref_11cc0();
  }

  wait 3.5;
  thread ref_11cbf();
}

function ref_11ccc() {
  self endon("death");
  ref_11ccd();
  thread ref_11cbf();
}

function ref_11ccd() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self.stuckto)) {
    self.stuckto endon("death");
  }

  self waittill("forever");
}

function molotov_create_pool_trigger(var0, var1, var2) {
  var3 = self.origin - anglestoup(self.angles) * var2;
  var4 = spawn("trigger_rotatable_radius", var3, 0, var0, var1);
  var4.angles = self.angles;
  var4.id = self.id;

  if(isDefined(self.stuckto)) {
    var4 enablelinkTo();
    var4 linkTo(self.stuckto);
  }

  var4 hide();
  var5 = spawnStruct();
  var5.trigger = var4;
  var5.attacker = self.owner;
  var5.inflictor = self.burnsource;
  var5.killcament = self.burnsource;
  var5.burnid = self.burnid;
  var5.playersintrigger = [];
  var4.struct = var5;
  thread molotov_watch_pool_trigger_enter();
  thread molotov_watch_pool_trigger_exit();
  thread molotov_cleanup_pool_trigger();
  thread ref_11ccb();
  ref_11cc9(var4);
  return var4;
}

function ref_11ccb() {
  self endon("death");
  self.struct.attacker endon("disconnect");
  self.struct.attacker endon("joined_team");

  if(isDefined(self.struct.stuckto)) {
    var0 = self.struct.stuckto;
    var0 waittill("death");
    thread ref_11cc0();
    thread ref_11cbf();
    return;
  }
}

function molotov_watch_pool_trigger_enter() {
  if(isDefined(self.inflictor)) {
    self.inflictor endon("death");
  }

  self.trigger endon("death");
  self.attacker endon("disconnect");
  self.attacker endon("joined_team");

  for(;;) {
    self.trigger waittill("trigger", var0);

    if(!isPlayer(var0) && !isagent(var0)) {
      continue;
    }

    if(!scripts\cp\utility\player::isreallyalive(var0)) {
      continue;
    }

    var1 = scripts\engine\utility::ter_op(isDefined(var0.owner), var0.owner, var0);

    if(var1 != self.attacker && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var1, self.attacker))) {
      continue;
    }

    var2 = var0 getentitynumber();

    if(isDefined(self.playersintrigger[var2])) {
      continue;
    }

    if(isagent(var0) && istrue(var0.clearsoundsubmixmpbrinfilanim) && isDefined(self.inflictor)) {
      var3 = self.inflictor.origin - var0.origin;
      var3 = vectorNormalize((var3[0], var3[1], 0));

      if(vectordot(anglesToForward(var0.angles), var3) > 0.5) {
        continue;
      }
    }

    self.playersintrigger[var2] = var0;
    molotov_start_burning(var0, self.attacker, self.inflictor, self.killcament, self.burnid);
  }
}

function molotov_watch_pool_trigger_exit() {
  self.trigger endon("death");

  for(;;) {
    foreach(var1 in self.playersintrigger) {
      if(!isDefined(var1)) {
        continue;
      }

      if(!scripts\cp\utility\player::isreallyalive(var1)) {
        continue;
      }

      if(var1 istouching(self.trigger)) {
        continue;
      }

      self.playersintrigger[var2] = undefined;
      molotov_stop_burning(var1, self.burnid);
    }

    waitframe();
  }
}

function molotov_cleanup_pool_trigger() {
  molotov_cleanup_pool_trigger_end_early();

  foreach(var1 in self.playersintrigger) {
    if(isDefined(var1)) {
      molotov_stop_burning(var1, self.burnid);
    }
  }

  if(isDefined(self.trigger)) {
    thread ref_11cc0();
    return;
  }
}

function molotov_cleanup_pool_trigger_end_early() {
  self.trigger endon("death");
  self.attacker endon("disconnect");
  self.attacker endon("joined_team");

  for(;;) {
    waitframe();
  }
}

function molotov_pool_update_scriptable() {
  var0 = ref_11cc3();
  var1 = var0.scriptablestates[self.poolmask];
  self setscriptablepartstate("effects", var1, 0);
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
  var0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, undefined, 44, undefined, undefined, 1);
}

function molotov_branch_create_left_tendril_cone() {
  var0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, &molotov_left_tendril_mod_angles, 44, undefined, undefined, 1);
}

function molotov_branch_create_right_tendril_cone() {
  var0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, &molotov_right_tendril_mod_angles, 44, undefined, undefined, 1);
}

function molotov_branch_create_tendril_radial() {
  var0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, &molotov_tendril_mod_angles_radial, 44, 6, 1, 1);
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

function molotov_cleanup_burn_source() {
  self endon("death");
  wait 20;
  self delete();
}

function molotov_cleanup_grenade(var0) {
  var0 endon("death");
  scripts\engine\utility::ref_143a5("disconnect", "joined_team");
  var0 delete();
}

function ref_11cc2() {
  return level.molotov;
}

function ref_11cc3() {
  var0 = ref_11cc2();
  var1 = var0.pooldata;
  return var1;
}

function ref_11cc1() {
  var0 = ref_11cc2();
  var1 = var0.castdata;
  return var1;
}

function ref_11cc4() {
  var0 = ref_11cc2();
  var1 = var0.ref_13f0c;
  var0.ref_13f0c++;
  var0.ref_127e4 = scripts\engine\utility::array_add(var0.ref_127e4, var1);
  return var1;
}

function molotov_get_cast_data(var0) {
  var1 = ref_11cc1();
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
  var1 = ref_11cc3();
  var2 = spawnStruct();
  var2.typeid = var0;
  var2.triggerradius = var1.triggerradius[var0];
  var2.triggerheight = var1.triggerheight[var0];
  var2.triggeroffset = var1.triggeroffset[var0];
  var2.startdelayms = var1.startdelayms[var0];
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

function molotov_start_burning(var0, var1, var2, var3) {
  if(isDefined(var3)) {}

  var4 = molotov_get_burning_info(1);

  if(!isDefined(var3)) {
    var3 = molotov_get_next_burning_id();
  }

  var5 = molotov_get_burning_source(var0, var1, var2, var4, var3, 1);
  var6 = 0;

  if(var5.count <= 0) {
    var6 = 1;
  }

  var5.count++;

  if(var6) {
    thread molotov_update_burning();
    return;
  }
}

function molotov_stop_burning(var0) {
  var1 = molotov_get_burning_info();

  if(!isDefined(var1)) {
    return;
  }

  var2 = molotov_get_burning_source(undefined, undefined, undefined, var1, var0, 0);

  if(isDefined(var2)) {
    if(var2.count > 0) {
      var3 = 0;

      if(var2.count == 1) {
        var3 = 1;
      }

      var2.count--;

      if(var3) {
        thread molotov_update_burning();
        return;
      }

      return;
    }

    return;
  }
}

function molotov_burn_for_time(var0, var1, var2, var3) {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  var4 = molotov_get_next_burning_id();
  molotov_start_burning(var1, var2, var3, var4);
  wait var0;
  molotov_stop_burning(var4);
}

function molotov_clear_burning(var0) {
  self notify("clear_burning");
  self.burninginfo = undefined;
}

function molotov_update_burning() {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  level endon("game_ended");
  self notify("update_burning");
  self endon("update_burning");
  thread molotov_cleanup_burning();
  var0 = molotov_get_burning_info();

  if(gettime() <= var0.updatetimestamp) {
    waitframe();
  }

  var1 = 0;

  for(;;) {
    var0 = molotov_get_burning_info();
    var2 = undefined;

    if(!isPlayer(self)) {
      self._blackboard.isburning = undefined;
      self.burningdirection = undefined;
    }

    foreach(var5, var4 in var0.sources) {
      if(molotov_burning_source_is_valid(var4)) {
        if(!isDefined(var2) || var4.id > var2) {
          var2 = var4.id;
        }

        continue;
      }

      var0.sources[var4.id] = undefined;
    }

    if(isDefined(var2)) {
      var0.timeoff = 0;
      var0.timeon += 0.05;
      var4 = var0.sources[var2];
      var6 = 15;

      if(var0.timeon > 1.5) {
        var6 = 30;
      } else if(var0.timeon > 0.5) {
        var6 = 25;
      }

      if(isagent(self)) {
        if(!istrue(self.ref_13a35)) {
          if(isPlayer(var4.attacker) && ref_11cce(var4.attacker)) {
            if(!istrue(var4.attacker.scriptedspawns)) {
              var4.attacker.moloachievementvictims += 1;
            }

            self.ref_13a35 = 1;
          }
        }
      }

      var7 = var4.attacker.origin;

      if(isDefined(var4.inflictor)) {
        var7 = var4.inflictor.origin;
      } else {
        var4.inflictor = undefined;
      }

      if(!isPlayer(self)) {
        if(self.health <= var6) {
          self.burningtodeath = 1;
        } else if(!var1) {
          self._blackboard.isburning = 1;
          self.burningtodeath = 0;
          var8 = anglestoright(self.angles);
          var9 = vectorNormalize(var7 - self.origin);

          if(vectordot(var8, var9) > 0) {
            self.burningdirection = "right";
          } else {
            self.burningdirection = "left";
          }

          var1 = 1;
        }
      }

      if(var0.timetodamage <= 0) {
        var10 = "MOD_EXPLOSIVE";

        if(isagent(self)) {
          var10 = "MOD_FIRE";
        }

        self dodamage(var6, var7, var4.attacker, var4.inflictor, var10, "molotov_mp");
        var0.firstdamagedone = 1;
        var0.timetodamage = 0.25;
      } else {
        var10 = "MOD_EXPLOSIVE";

        if(isagent(self)) {
          var10 = "MOD_FIRE";
        }

        if(!var1.firstdamagedone) {
          self dodamage(var7, var10, var5.attacker, var5.inflictor, var10, "molotov_mp");
          var1.firstdamagedone = 1;
        }

        var1.timetodamage -= 0.05;
      }
    } else {
      var1.timeoff += 0.05;

      if(var1.timeoff >= 2.5) {
        thread molotov_clear_burning();
      }
    }

    var1.updatetimestamp = gettime();
    wait 0.05;
  }
}

function ref_11cce() {
  if(isDefined(self.waittill_any_timeout_no_endon_death_4) && gettime() - self.waittill_any_timeout_no_endon_death_4 < 4000) {
    return 1;
  }

  return 0;
}

function molotov_is_burning() {
  var0 = molotov_get_burning_info();
  return isDefined(var0) && var0.sources.size > 0;
}

function molotov_get_burning_info(var0) {
  var1 = self.burninginfo;

  if(!isDefined(var1) && istrue(var0)) {
    var1 = spawnStruct();
    var1.timeon = 0;
    var1.timeoff = 0;
    var1.timetodamage = 0.25;
    var1.updatetimestamp = 0;
    var1.victim = self;
    var1.sources = [];
    var1.firstdamagedone = 0;
    self.burninginfo = var1;
  }

  return var1;
}

function molotov_get_burning_source(var0, var1, var2, var3, var4, var5) {
  var6 = var3.sources[var4];

  if(!isDefined(var6)) {
    if(istrue(var5)) {
      var6 = spawnStruct();
      var6.attacker = var0;
      var6.inflictor = var1;
      var6.hasinflictor = isDefined(var1);
      var6.killcament = var2;
      var6.info = var3;
      var6.id = var4;
      var6.count = 0;
      var3.sources[var4] = var6;
    }
  }

  return var6;
}

function molotov_burning_source_is_valid() {
  if(!isDefined(self.attacker)) {
    return false;
  }

  if(!isDefined(self.info.victim)) {
    return false;
  }

  if(!scripts\cp\utility\player::isreallyalive(self.info.victim)) {
    return false;
  }

  if(self.attacker != self.info.victim && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.attacker, self.info.victim))) {
    return false;
  }

  if(self.hasinflictor && !isDefined(self.inflictor)) {
    return false;
  }

  if(self.count <= 0) {
    return false;
  }

  return true;
}

function molotov_get_next_burning_id() {
  var0 = ref_11cc2();

  if(!isDefined(var0.burningid)) {
    var0.burningid = 0;
  }

  var1 = var0.burningid;
  var0.burningid++;
  return var1;
}

function molotov_cleanup_burning() {
  self notify("cleanup_burning");
  self endon("cleanup_burning");
  GscBinSkip4(0x35);
}

function molotov_cleanup_burning_on_death() {
  self endon("disconnect");
  self endon("clear_burning");
  level endon("game_ended");
  self waittill("death");
  thread molotov_clear_burning(1);
}

function molotov_cleanup_burning_on_game_end() {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  level waittill("game_ended");
  thread molotov_clear_burning();
}

function molotov_on_player_damaged(var0) {
  if(var0.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  var0.victim thread scripts\cp\cp_weapons::enableburnfxfortime(0.5);
  return true;
}

function molotov_watch_fx() {
  self endon("molotov_clear_fx");
  self endon("death_or_disconnect");
  var0 = 0;

  for(;;) {
    var1 = 0;
    var2 = self getheldoffhand();

    if(!nullweapon(var2) && var2.basename == "molotov_mp") {
      var1 = 1;
    }

    if(var1 && !var0) {
      thread molotov_begin_fx();
    } else if(var0 && !var1) {
      thread molotov_end_fx();
    }

    var0 = var1;
    waitframe();
  }
}

function molotov_begin_fx() {
  self endon("death_or_disconnect");
  self endon("molotov_end_fx");
  self.ref_12743 = 1;
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "active", 0);
  var0 = 0.4;
  wait var0;
  self setscriptablepartstate("equipMtovFXWorld", "active", 0);
}

function molotov_end_fx() {
  self notify("molotov_end_fx");

  if(istrue(self.ref_12743)) {
    self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
    self setscriptablepartstate("equipMtovFXView", "neutral", 0);
  }

  self.ref_12743 = undefined;
}

function ref_11cb4(var0) {
  var0 notify("cleanup_branch");

  if(isDefined(var0.ents)) {
    foreach(var2 in var0.ents) {
      if(isDefined(var2)) {
        thread molotov_pool_end();
      }
    }

    return;
  }
}

function ref_11cb5(var0) {
  if(isDefined(var0.shareddata)) {
    if(isDefined(var0.shareddata.branches)) {
      foreach(var2 in var0.shareddata.branches) {
        ref_11cb4(var2);
      }
    }

    if(isDefined(var0.shareddata.ref_11fc8)) {
      foreach(var5 in var0.shareddata.ref_11fc8) {
        if(isDefined(var5)) {
          thread molotov_pool_end();
        }
      }

      return;
    }

    return;
  }
}

function ref_11cb6() {
  self notify("molotov_clear_fx");
  thread molotov_end_fx();
}