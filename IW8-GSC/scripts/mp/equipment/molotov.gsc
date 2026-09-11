/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\molotov.gsc
***********************************************/

function molotov_init() {
  var_0 = spawnStruct();
  level.molotov = var_0;
  var_0.ref_11b6e = getdvarint("scr_molotovMaxPools", 100);
  var_0.ref_11b57 = getdvarint("scr_molotovMaxCastsPerFrame", 8);
  var_0.start_airfield_safehouse = getdvarint("scr_molotovInstantCleanup", 1) > 0;
  var_0.ref_13f0c = 0;
  var_0.ref_127e4 = [];
  var_0.scriptables = [];
  var_0.triggers = [];
  var_0.frametimestamp = 0;
  var_0.caststhisframe = 0;
  molotov_init_cast_data();
  molotov_init_pool_data();
}

function molotov_init_cast_data() {
  var_0 = ref_11cc2();
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
  var_2 = 4;
  var_1.distforward[var_2] = undefined;
  var_1.distdown[var_2] = undefined;
  var_1.distup[var_2] = undefined;
  var_1.maxcasts[var_2] = undefined;
  var_1.maxfails[var_2] = undefined;
  var_1.maxents[var_2] = 1;
  var_2 = 8;
  var_1.distforward[var_2] = 50;
  var_1.distdown[var_2] = 50;
  var_1.distup[var_2] = 25;
  var_1.maxcasts[var_2] = 4;
  var_1.maxfails[var_2] = 3;
  var_1.maxents[var_2] = 1;
  var_1.distforwardwall[var_2] = 25;
  var_2 = 16;
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
  var_0 = ref_11cc2();
  var_1 = var_0.pooldata;

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_0.pooldata = var_1;
  }

  var_1.triggerradius = [];
  var_1.triggerheight = [];
  var_1.triggeroffset = [];
  var_1.startdelayms = [];
  var_2 = 4;
  var_1.triggerradius[var_2] = 30;
  var_1.triggerheight[var_2] = 55;
  var_1.triggeroffset[var_2] = 15;
  var_1.startdelayms[var_2] = 0;
  var_2 = 8;
  var_1.triggerradius[var_2] = 30;
  var_1.triggerheight[var_2] = 55;
  var_1.triggeroffset[var_2] = 15;
  var_1.startdelayms[var_2] = 100;
  var_2 = 16;
  var_1.triggerradius[var_2] = 10;
  var_1.triggerheight[var_2] = 55;
  var_1.triggeroffset[var_2] = 15;
  var_1.startdelayms[var_2] = 100;
  molotov_init_pool_mask();
}

function molotov_init_pool_mask() {
  var_0 = ref_11cc3();
  var_1 = [];
  GscBinSkip0(0x2e, 4, "coreCenter");
}

function molotov_on_give(var_0, var_1) {
  thread molotov_watch_fx();
}

function molotov_on_take(var_0, var_1) {
  self notify("molotov_taken");
}

function molotov_used(var_0) {
  var_0 endon("death");
  var_1 = self getgunangles();
  var_2 = gettime();
  var_3 = anglesToForward(var_1) * 940 + anglestoup(var_1) * 120;
  thread molotov_cleanup_grenade(var_0);
  var_0 waittill("missile_stuck", var_4, var_5, var_6, var_7, var_8, var_9);
  var_0.surfacetype = var_6;

  if(isDefined(level.ref_132a4) && [[level.ref_132a4.make_control_station_interaction]](var_0)) {
    if(isDefined(level.ref_132a4) && isDefined(level.ref_132a4.setupbobbingboatmultiple)) {
      [[level.ref_132a4.setupbobbingboatmultiple]](var_0);
      return;
    }
  }

  if(isDefined(level.playerzombieupdateongamepadchange)) {
    [[level.playerzombieupdateongamepadchange]](var_0, self);
  }

  var_10 = (gettime() - var_2) / 1000;
  var_11 = var_3 + (0, 0, -800 * var_10);

  if(isDefined(var_4) && isPlayer(var_4)) {
    thread molotov_stuck_player(var_0, var_4, var_1, var_11);
    return;
  }

  thread molotov_stuck(var_0, var_4, var_1, var_11);
}

function molotov_stuck(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = vectorNormalize(var_3);
  var_6 = anglestoup(var_0.angles);
  var_7 = anglestoright(var_2);

  if(abs(vectordot(var_5, var_6)) >= 0.9848) {
    var_4 = molotov_rebuild_angles_up_right(var_6, var_7);
  } else {
    var_4 = molotov_rebuild_angles_up_forward(var_6, var_5);
  }

  var_0.angles = var_4;
  var_0 notify("death");
  var_0.exploding = 1;

  if(var_0 isscriptable()) {
    var_0 setscriptablepartstate("effects", "explode", 0);
  }

  if(isvalidmissile(var_0)) {
    var_0 missilehidetrail();
  }

  molotov_simulate_impact(var_0, var_0.origin, var_4, var_1, var_3, gettime());
}

function molotov_stuck_player(var_0, var_1, var_2, var_3) {
  scripts\mp\weapons::grenadestuckto(var_0, var_1);

  if(!isDefined(level.ref_132a4) || ![[level.ref_132a4.getheliflyheight]](var_1)) {
    thread molotov_burn_for_time(var_1, 6, self, var_0);
  }

  var_0.exploding = 1;
  var_0 setscriptablepartstate("effects", "explode", 0);
  var_0 missilehidetrail();

  if(!isDefined(level.ref_132a4) || ![[level.ref_132a4.gethelinextgroupafterwait]](var_1)) {
    var_3 *= (0, 0, 1);
    var_4 = var_0.origin;
    var_5 = (0, 0, -1);
    var_6 = var_4 + var_5 * 128;
    var_7 = molotov_get_cast_contents();
    var_8 = physics_raycast(var_4, var_6, var_7, var_0, 0, "physicsquery_closest", 1);

    if(isDefined(var_8) && var_8.size > 0) {
      var_6 = var_8[0]["position"];
      var_9 = var_8[0]["normal"];
      var_10 = var_8[0]["entity"];
      var_6 -= var_9 * 1;
      var_11 = vectordot(var_6 - var_4, var_5);
      var_12 = sqrt(2 * var_11 / 800);
      var_13 = var_9;
      var_14 = anglestoright(var_2);
      var_15 = molotov_rebuild_angles_up_right(var_13, var_14);
      thread molotov_simulate_impact(var_0, var_6, var_15, var_10, var_3, gettime() + var_12 * 1000);
      return;
    }
  }

  waitframe();

  if(isDefined(var_7)) {
    thread molotov_cleanup_burn_source();
    return;
  }
}

function molotovbadplace(var_0) {
  if(!scripts\mp\bots\bots_util::bot_bots_enabled_or_added() && !scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe()) {
    return;
  }

  var_1 = createnavbadplacebybounds(var_0, (128, 128, 100), (0, 0, 0));
  return var_1;
}

function molotov_simulate_impact(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0.owner;

  if(!istrue(level.iscacprimaryweapongroup)) {
    var_7 = scripts\engine\utility::ter_op(level.players.size > 15, 10, 20);
    scripts\mp\spawnlogic::addspawndangerzone(var_1 - (0, 0, 128), 225, 256, var_6.team, var_7, var_6, 1);
  }

  var_8 = anglestoup(var_2);
  var_9 = var_1 + var_8 * 1;
  var_10 = var_9 + var_8 * 25;
  var_11 = molotov_get_cast_contents();
  var_12 = physics_raycast(var_9, var_10, var_11, var_0, 0, "physicsquery_closest", 1);

  if(isDefined(var_12) && var_12.size > 0) {
    var_10 = var_12[0]["position"] - var_8 * 1;
  }

  var_13 = var_10;
  var_14 = var_0;
  thread molotov_cleanup_burn_source();
  var_15 = molotov_get_next_burning_id();
  var_16 = 0;
  var_17 = vectordot(vectorNormalize(var_4), -1 * var_8);

  if(var_17 < 0.96593) {
    var_16 = 1;
  }

  var_18 = molotov_create_shared_data(var_6, var_5, var_14, var_15);
  var_18.badplace = molotovbadplace(var_1);
  thread molotov_cleanup();
  var_19 = 4;
  var_20 = molotov_get_cast_data(var_19);
  var_21 = molotov_get_pool_data(var_19);
  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_1, var_2, var_3);
  var_18.branches[var_18.branches.size] = var_22;
  var_23 = 25;
  var_24 = 65;
  var_25 = 115;
  var_26 = gettime() + var_21.startdelayms;
  var_19 = 8;
  var_20 = molotov_get_cast_data(var_19);
  var_21 = molotov_get_pool_data(var_19);
  var_27 = &molotov_branch_create_tendril_radial;

  if(var_16) {
    var_27 = &molotov_branch_create_forward_tendril_cone;
  }

  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_13, var_2, var_3, 0, var_26, var_27);
  var_18.branches[var_18.branches.size] = var_22;
  var_28 = anglesToForward(var_2);
  var_29 = anglestoright(var_2);
  var_30 = anglestoup(var_2);
  var_20 = molotov_get_cast_data(var_19);
  var_21 = molotov_get_pool_data(var_19);
  var_31 = var_28 * -1;
  var_32 = var_29 * -1;
  var_33 = var_30;
  var_34 = axistoangles(var_31, var_32, var_33);
  var_27 = &molotov_branch_create_tendril_radial;

  if(var_16) {
    var_27 = undefined;
  }

  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18.branches[var_18.branches.size] = var_22;
  var_20 = molotov_get_cast_data(var_19);
  var_21 = molotov_get_pool_data(var_19);
  var_31 = rotatepointaroundvector(var_30, var_28, var_24);
  var_32 = vectorNormalize(vectorcross(var_31, var_30));
  var_33 = vectorcross(var_32, var_28);
  var_34 = axistoangles(var_31, var_32, var_33);
  var_27 = &molotov_branch_create_tendril_radial;

  if(var_16) {
    var_27 = &molotov_branch_create_right_tendril_cone;
  }

  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18.branches[var_18.branches.size] = var_22;
  var_20 = molotov_get_cast_data(var_19);
  var_21 = molotov_get_pool_data(var_19);
  var_31 = rotatepointaroundvector(var_30, var_28, -1 * var_24);
  var_32 = vectorNormalize(vectorcross(var_31, var_30));
  var_33 = vectorcross(var_32, var_28);
  var_34 = axistoangles(var_31, var_32, var_33);
  var_27 = &molotov_branch_create_tendril_radial;

  if(var_16) {
    var_27 = &molotov_branch_create_left_tendril_cone;
  }

  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18.branches[var_18.branches.size] = var_22;
  var_20 = molotov_get_cast_data(var_19);
  var_21 = molotov_get_pool_data(var_19);
  var_31 = rotatepointaroundvector(var_30, var_28, var_25);
  var_32 = vectorNormalize(vectorcross(var_31, var_30));
  var_33 = vectorcross(var_32, var_28);
  var_34 = axistoangles(var_31, var_32, var_33);
  var_27 = &molotov_branch_create_tendril_radial;

  if(var_16) {
    var_27 = undefined;
  }

  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18.branches[var_18.branches.size] = var_22;
  var_20 = molotov_get_cast_data(var_19);
  var_21 = molotov_get_pool_data(var_19);
  var_31 = rotatepointaroundvector(var_30, var_28, -1 * var_25);
  var_32 = vectorNormalize(vectorcross(var_31, var_30));
  var_33 = vectorcross(var_32, var_28);
  var_34 = axistoangles(var_31, var_32, var_33);
  var_27 = &molotov_branch_create_tendril_radial;

  if(var_16) {
    var_27 = undefined;
  }

  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18.branches[var_18.branches.size] = var_22;
  ref_11cc7(var_18);

  foreach(var_22 in var_18.branches) {
    thread molotov_start_branch();
  }
}

function molotov_cleanup() {
  self.burnsource scripts\engine\utility::waittill_notify_or_timeout("entitydeleted", 6.75);

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

  if(isDefined(self.badplace)) {
    destroynavobstacle(self.badplace);
    return;
  }
}

function molotov_create_shared_data(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.owner = var_0;
  var_4.team = var_0.team;
  var_4.impacttime = var_1;
  var_4.burnsource = var_2;
  var_4.burnid = var_3;
  var_4.branches = [];
  var_4.ref_12f6e = 0;
  var_4.caststotal = 0;
  var_4.caststhisframe = 0;
  var_4.frametimestamp = gettime();
  var_4.castcontents = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var_2.shareddata = var_4;
  return var_4;
}

function ref_11cc7(var_0) {
  var_0.caststotal++;
  var_0.caststhisframe++;
  var_0.frametimestamp = gettime();
  var_1 = ref_11cc2();
  var_1.caststhisframe++;
}

function ref_11cc8(var_0) {
  var_0.ref_12f6e++;
  var_1 = ref_11cc2();
  var_1.scriptables[self.id] = self;

  if(var_1.scriptables.size > var_1.ref_11b6e) {
    ref_11cbc();
    return;
  }
}

function ref_11cc9(var_0) {
  var_1 = ref_11cc2();
  var_1.triggers[self.id] = self;

  if(var_1.triggers.size > var_1.ref_11b6e) {
    ref_11cbd();
    return;
  }
}

function ref_11cbf() {
  var_0 = ref_11cc2();
  var_0.scriptables[self.id] = undefined;
  var_1 = var_0.triggers[self.id];

  if(!isDefined(var_1)) {
    var_0.ref_127e4 = scripts\engine\utility::array_remove(var_0.ref_127e4, self.id);
  }

  self notify("death");
  self freescriptable();
}

function ref_11cc0() {
  var_0 = ref_11cc2();
  var_0.triggers[self.id] = undefined;
  var_1 = var_0.scriptables[self.id];

  if(!isDefined(var_1)) {
    var_0.ref_127e4 = scripts\engine\utility::array_remove(var_0.ref_127e4, self.id);
  }

  self delete();
}

function ref_11cbc(var_0) {
  var_1 = ref_11cc2();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_3 in var_1.ref_127e4) {
    var_2 = var_1.scriptables[var_3];

    if(isDefined(var_2)) {
      break;
    }
  }

  var_0 = istrue(var_0) || var_1.start_airfield_safehouse;

  if(!isDefined(var_2)) {
    ref_11cbe(var_3, var_0);
    return;
  }
}

function ref_11cbd(var_0) {
  var_1 = ref_11cc2();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_3 in var_1.ref_127e4) {
    var_2 = var_1.triggers[var_3];

    if(isDefined(var_2)) {
      break;
    }
  }

  var_0 = istrue(var_0) || var_1.start_airfield_safehouse;

  if(isDefined(var_2)) {
    ref_11cbe(var_3, var_0);
    return;
  }
}

function ref_11cbe(var_0, var_1) {
  var_2 = ref_11cc2();
  var_3 = var_2.scriptables[var_0];

  if(isDefined(var_3)) {
    if(!istrue(var_1)) {
      var_2.scriptables[var_0] = undefined;
      var_2.triggers[var_0] = undefined;
      var_2.ref_127e4 = scripts\engine\utility::array_remove(var_2.ref_127e4, var_0);
      thread molotov_pool_end();
      return;
    }

    thread ref_11cbf();
  }

  var_4 = var_2.triggers[var_0];

  if(isDefined(var_4)) {
    thread ref_11cc0();
    return;
  }
}

function ref_11cb3(var_0) {
  if(var_0.frametimestamp < gettime()) {
    var_0.frametimestamp = gettime();
    var_0.caststhisframe = 0;
  }

  if(var_0.caststhisframe >= 3) {
    return false;
  }

  var_1 = ref_11cc2();

  if(var_1.frametimestamp < gettime()) {
    var_1.frametimestamp = gettime();
    var_1.caststhisframe = 0;
  }

  if(var_1.caststhisframe >= var_1.ref_11b57) {
    return false;
  }

  return true;
}

function molotov_shared_data_is_complete(var_0) {
  var_1 = 0;
  var_2 = 60;
  var_3 = 20;

  if(self.caststotal >= var_2) {
    var_1 = 1;
  } else if(self.ref_12f6e >= var_3) {
    var_1 = 1;
  } else if(istrue(var_0)) {
    var_4 = 1;

    foreach(var_6 in self.branches) {
      if(!molotov_branch_is_complete(var_6, 1, 1)) {
        var_4 = 0;
        break;
      }
    }

    if(var_4) {
      var_1 = 1;
    }
  }

  if(var_1) {
    self.iscomplete = 1;
    ref_11cca();
    self.branches = [];
  }

  return var_1;
}

function ref_11cca() {
  var_0 = self;

  if(isDefined(self.shareddata)) {
    var_0 = self.shareddata;
  }

  if(!isDefined(var_0.ref_11fc8)) {
    var_0.ref_11fc8 = [];
  }

  foreach(var_2 in self.branches) {
    foreach(var_4 in var_2.ents) {
      if(isDefined(var_4)) {
        var_0.ref_11fc8[var_0.ref_11fc8.size] = var_4;
      }
    }
  }
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
  self endon("cleanup_branch");

  if(!isDefined(self.preventstarttime)) {
    self.preventstarttime = gettime();
  }

  if(!isDefined(self.startingcasttype)) {
    if(!molotov_shared_data_is_complete(self.shareddata)) {
      var_0 = molotov_branch_create_pool(self.startingorigin, self.startingangles, self.startingstuckto);
      var_0 = thread molotov_pool_start();
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
            var_12 = molotov_branch_create_pool(var_4, var_7, var_6);
            thread molotov_pool_start();
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
          var_12 = molotov_branch_create_pool(var_4, var_7, var_6);
          thread molotov_pool_start();
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
    ref_11cca();
    self.branches = [];
  }

  return var_2;
}

function molotov_branch_register_cast(var_0, var_1, var_2) {
  ref_11cc7(self.shareddata);
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

function molotov_create_pool(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = "equip_molotov_pool_mp_p";

  if(isDefined(var_4) && isDefined(var_4.weapon_name) && (var_4.weapon_name == "gasoline_can_mp" || var_4.weapon_name == "gas_can_mp")) {
    var_10 = "equip_propane_tank_pool_br";
  }

  var_11 = easepower(var_10, var_0, var_1);
  var_11.stuckto = var_2;
  var_11.owner = var_3;
  var_11.burnsource = var_4;
  var_11.burnid = var_5;
  var_11.starttime = var_6;
  var_11.pooldata = var_7;
  var_11.poolmask = var_8;
  var_11.id = var_9;

  if(isDefined(var_2)) {
    var_12 = rotatevectorinverted(var_0 - var_2.origin, var_2.angles);
    var_13 = combineangles(invertangles(var_2.angles), var_1);
    var_11 validatecollision(var_2, var_12, var_13);
  }

  thread ref_11ccc();
  return var_11;
}

function molotov_branch_create_pool(var_0, var_1, var_2) {
  var_3 = self.pooldata.typeid;
  var_4 = anglestoup(var_1);
  var_5 = vectordot(var_4, (0, 0, 1));

  if(var_5 <= -0.81915) {
    var_3 |= 128;
  } else if(var_5 <= 0.5) {
    var_3 |= 64;
  } else {
    var_3 |= 32;
  }

  var_6 = self.preventstarttime + self.pooldata.startdelayms;
  var_7 = molotov_create_pool(var_0, var_1, var_2, self.shareddata.owner, self.shareddata.burnsource, self.shareddata.burnid, var_6, self.pooldata, var_3);
  self.preventstarttime = var_6;
  self.ents[self.ents.size] = var_7;
  var_7.id = ref_11cc4();
  ref_11cc8(var_7, self.shareddata);
  return var_7;
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
  var_0 = self.id;
  var_1 = molotov_watch_pool();

  if(isDefined(self)) {
    thread molotov_pool_end();
    return;
  }

  thread ref_11cc6(level, var_1);
}

function molotov_watch_pool() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self.stuckto)) {
    self.stuckto endon("death");
  }

  self notify("molotov_pool_watch");
  self.trigger = molotov_create_pool_trigger(self.pooldata.triggerradius, self.pooldata.triggerheight, self.pooldata.triggeroffset);
  var_0 = self.trigger;
  self.poolmask |= 1;
  molotov_pool_update_scriptable();
  var_1 = scripts\mp\utility\game::unset_relic_grounded();
  var_2 = scripts\engine\utility::ter_op(var_1, randomfloatrange(12.5, 12.75), randomfloatrange(6.5, 6.75));
  wait var_2;
  return var_0;
}

function molotov_pool_end(var_0) {
  self endon("death");

  if(istrue(self.ended)) {
    return;
  }

  self notify("molotov_pool_end");
  self.ended = 1;
  self.poolmask &= ~1;
  self.poolmask |= 2;
  molotov_pool_update_scriptable();

  if(!istrue(var_0)) {
    wait 1;
  }

  if(isDefined(self.trigger)) {
    thread ref_11cc0();
  }

  if(!istrue(var_0)) {
    wait 3.5;
  }

  thread ref_11cbf();
}

function ref_11cc6(var_0, var_1) {
  if(isDefined(var_0)) {
    thread ref_11cc0();
  }

  var_2 = ref_11cc2();
  var_2.scriptables[var_1] = undefined;
  var_0 = var_2.triggers[var_1];

  if(!isDefined(var_0)) {
    var_2.ref_127e4 = scripts\engine\utility::array_remove(var_2.ref_127e4, var_1);
    return;
  }
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

function molotov_create_pool_trigger(var_0, var_1, var_2) {
  var_3 = self.origin - anglestoup(self.angles) * var_2;
  var_4 = spawn("trigger_rotatable_radius", var_3, 0, var_0, var_1);
  var_4.angles = self.angles;
  var_4.id = self.id;

  if(isDefined(self.stuckto) && !(isagent(self.stuckto) && !isalive(self.stuckto))) {
    var_4 enablelinkTo();
    var_4 linkTo(self.stuckto);
  }

  var_4 hide();
  var_5 = spawnStruct();
  var_5.trigger = var_4;
  var_5.attacker = self.owner;
  var_5.inflictor = self.burnsource;
  var_5.killcament = self.burnsource;
  var_5.burnid = self.burnid;
  var_5.stuckto = self.stuckto;
  var_5.playersintrigger = [];
  var_4.struct = var_5;
  thread molotov_watch_pool_trigger_enter();
  thread molotov_watch_pool_trigger_exit();
  thread molotov_cleanup_pool_trigger();
  ref_11cc9(var_4);
  return var_4;
}

function molotov_watch_pool_trigger_enter() {
  if(isDefined(self.inflictor)) {
    self.inflictor endon("death");
  }

  self.trigger endon("death");
  self.attacker endon("disconnect");
  self.attacker endon("joined_team");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(!isPlayer(var_0) && !istrue(var_0.brking_getcirclepercentmoved)) {
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }

    var_1 = scripts\engine\utility::ter_op(isDefined(var_0.owner), var_0.owner, var_0);

    if(var_1 != self.attacker && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_1, self.attacker))) {
      continue;
    }

    var_2 = var_0 getentitynumber();

    if(isDefined(self.playersintrigger[var_2])) {
      continue;
    }

    self.playersintrigger[var_2] = var_0;
    molotov_start_burning(var_0, self.attacker, self.inflictor, self.killcament, self.burnid);
  }
}

function molotov_watch_pool_trigger_exit() {
  self.trigger endon("death");

  for(;;) {
    foreach(var_1 in self.playersintrigger) {
      if(!isDefined(var_1)) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var_1)) {
        continue;
      }

      if(var_1 istouching(self.trigger)) {
        continue;
      }

      self.playersintrigger[var_2] = undefined;
      molotov_stop_burning(var_1, self.burnid);
    }

    waitframe();
  }
}

function molotov_cleanup_pool_trigger() {
  molotov_cleanup_pool_trigger_end_early();

  foreach(var_1 in self.playersintrigger) {
    if(isDefined(var_1)) {
      molotov_stop_burning(var_1, self.burnid);
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

  if(isDefined(self.stuckto)) {
    self.stuckto endon("death");
  }

  for(;;) {
    waitframe();
  }
}

function molotov_pool_update_scriptable() {
  var_0 = ref_11cc3();
  var_1 = var_0.scriptablestates[self.poolmask];
  self setscriptablepartstate("effects", var_1, 0);
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
  var_0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, undefined, 44, undefined, undefined, 1);
}

function molotov_branch_create_left_tendril_cone() {
  var_0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, &molotov_left_tendril_mod_angles, 44, undefined, undefined, 1);
}

function molotov_branch_create_right_tendril_cone() {
  var_0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, &molotov_right_tendril_mod_angles, 44, undefined, undefined, 1);
}

function molotov_branch_create_tendril_radial() {
  var_0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, &molotov_tendril_mod_angles_radial, 44, 6, 1, 1);
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

function molotov_cleanup_burn_source() {
  self endon("death");
  wait 20;
  self delete();
}

function molotov_cleanup_grenade(var_0) {
  var_0 endon("death");
  scripts\engine\utility::ref_143ba(7, "disconnect", "joined_team");
  var_0 delete();
}

function ref_11cc2() {
  return level.molotov;
}

function ref_11cc3() {
  var_0 = ref_11cc2();
  var_1 = var_0.pooldata;
  return var_1;
}

function ref_11cc1() {
  var_0 = ref_11cc2();
  var_1 = var_0.castdata;
  return var_1;
}

function ref_11cc4() {
  var_0 = ref_11cc2();
  var_1 = var_0.ref_13f0c;
  var_0.ref_13f0c++;
  var_0.ref_127e4 = scripts\engine\utility::array_add(var_0.ref_127e4, var_1);
  return var_1;
}

function molotov_get_cast_data(var_0) {
  var_1 = ref_11cc1();
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
  var_1 = ref_11cc3();
  var_2 = spawnStruct();
  var_2.typeid = var_0;
  var_2.triggerradius = var_1.triggerradius[var_0];
  var_2.triggerheight = var_1.triggerheight[var_0];
  var_2.triggeroffset = var_1.triggeroffset[var_0];
  var_2.startdelayms = var_1.startdelayms[var_0];
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

function molotov_start_burning(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {}

  if(isDefined(level.ref_132a4) && [[level.ref_132a4.getheliflyheight]](self)) {
    return;
  }

  var_4 = molotov_get_burning_info(1);

  if(!isDefined(var_3)) {
    var_3 = molotov_get_next_burning_id();
  }

  var_5 = molotov_get_burning_source(var_0, var_1, var_2, var_4, var_3, 1);
  var_6 = 0;

  if(var_5.count <= 0) {
    var_6 = 1;
  }

  var_5.count++;

  if(var_6) {
    thread molotov_update_burning();
    return;
  }
}

function molotov_stop_burning(var_0) {
  var_1 = molotov_get_burning_info();

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = molotov_get_burning_source(undefined, undefined, undefined, var_1, var_0, 0);

  if(isDefined(var_2)) {
    if(var_2.count > 0) {
      var_3 = 0;

      if(var_2.count == 1) {
        var_3 = 1;
      }

      var_2.count--;

      if(var_3) {
        thread molotov_update_burning();
        return;
      }

      return;
    }

    return;
  }
}

function molotov_burn_for_time(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  var_4 = molotov_get_next_burning_id();
  molotov_start_burning(var_1, var_2, var_3, var_4);
  wait var_0;
  molotov_stop_burning(var_4);
}

function molotov_clear_burning(var_0) {
  self notify("clear_burning");

  if(isDefined(self.burninginfo) && isDefined(self.burninginfo.sources)) {
    foreach(var_2 in self.burninginfo.sources) {
      self.burninginfo.sources[var_2.id] = undefined;
    }
  }

  self.burninginfo = undefined;
}

function molotov_update_burning() {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  level endon("game_ended");
  self notify("update_burning");
  self endon("update_burning");
  thread molotov_cleanup_burning();
  var_0 = molotov_get_burning_info();
  jumpiffalse(gettime() <= var_0.updatetimestamp) LOC_00000040;
  waitframe();

  for(;;) {
    var_0 = molotov_get_burning_info();
    var_1 = undefined;

    foreach(var_3 in var_0.sources) {
      if(molotov_burning_source_is_valid(var_3)) {
        if(!isDefined(var_1) || var_3.id > var_1) {
          var_1 = var_3.id;
        }

        continue;
      }

      var_0.sources[var_3.id] = undefined;
    }

    if(isDefined(var_1)) {
      var_0.timeoff = 0;
      var_0.timeon += 0.05;
      var_3 = var_0.sources[var_1];
      var_5 = 15;

      if(var_0.timeon > 1.5) {
        var_5 = 30;
      } else if(var_0.timeon > 0.5) {
        var_5 = 25;
      }

      var_6 = undefined;
      var_7 = var_3.attacker.origin;

      if(isDefined(var_3.inflictor)) {
        var_6 = var_3.inflictor;
        var_7 = var_3.inflictor.origin;
      }

      if(var_0.timetodamage <= 0) {
        self dodamage(var_5, var_7, var_3.attacker, var_6, "MOD_EXPLOSIVE", "molotov_mp");
        var_0.firstdamagedone = 1;
        var_0.timetodamage = 0.25;
      } else {
        if(!var_0.firstdamagedone) {
          self dodamage(var_5, var_7, var_3.attacker, var_6, "MOD_EXPLOSIVE", "molotov_mp");
          var_0.firstdamagedone = 1;
        }

        var_0.timetodamage -= 0.05;
      }
    } else {
      var_0.timeoff += 0.05;

      if(var_0.timeoff >= 0.25) {
        thread molotov_clear_burning();
      }
    }

    var_0.updatetimestamp = gettime();
    wait 0.05;
  }
}

function molotov_is_burning() {
  var_0 = molotov_get_burning_info();
  return isDefined(var_0) && var_0.sources.size > 0;
}

function molotov_get_burning_info(var_0) {
  var_1 = self.burninginfo;

  if(!isDefined(var_1) && istrue(var_0)) {
    var_1 = spawnStruct();
    var_1.timeon = 0;
    var_1.timeoff = 0;
    var_1.timetodamage = 0.25;
    var_1.updatetimestamp = 0;
    var_1.victim = self;
    var_1.sources = [];
    var_1.firstdamagedone = 0;
    self.burninginfo = var_1;
  }

  return var_1;
}

function molotov_get_burning_source(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_3.sources[var_4];

  if(!isDefined(var_6)) {
    if(istrue(var_5)) {
      var_6 = spawnStruct();
      var_6.attacker = var_0;
      var_6.inflictor = var_1;
      var_6.hasinflictor = isDefined(var_1);
      var_6.killcament = var_2;
      var_6.info = var_3;
      var_6.id = var_4;
      var_6.count = 0;
      var_3.sources[var_4] = var_6;
    }
  }

  return var_6;
}

function molotov_burning_source_is_valid() {
  if(!isDefined(self.attacker)) {
    return false;
  }

  if(!isDefined(self.info.victim)) {
    return false;
  }

  if(!scripts\mp\utility\player::isreallyalive(self.info.victim)) {
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
  var_0 = ref_11cc2();

  if(!isDefined(var_0.burningid)) {
    var_0.burningid = 0;
  }

  var_1 = var_0.burningid;
  var_0.burningid++;
  return var_1;
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

function molotov_on_player_damaged(var_0) {
  if(var_0.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  var_0.victim thread scripts\mp\weapons::enableburnfxfortime(0.5);
  return true;
}

function molotov_watch_fx() {
  self notify("molotov_clear_fx");
  self endon("molotov_clear_fx");
  self endon("death_or_disconnect");
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = self getheldoffhand();

    if(!nullweapon(var_2) && var_2.basename == "molotov_mp") {
      var_1 = 1;
    }

    if(var_1 && !var_0) {
      thread molotov_begin_fx();
    } else if(var_0 && !var_1) {
      thread molotov_end_fx();
    }

    var_0 = var_1;
    waitframe();
  }
}

function molotov_begin_fx() {
  self endon("death_or_disconnect");
  self endon("molotov_end_fx");
  self.ref_12743 = 1;
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "active", 0);
  var_0 = 0.4;
  wait var_0;
  self setscriptablepartstate("equipMtovFXWorld", "active", 0);
  self waittill("offhand_fired");
  waitframe();
  thread molotov_end_fx();
}

function molotov_end_fx() {
  self notify("molotov_end_fx");

  if(istrue(self.ref_12743)) {
    self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
    self setscriptablepartstate("equipMtovFXView", "neutral", 0);
  }

  self.ref_12743 = undefined;
}

function ref_11cb6() {
  self notify("molotov_clear_fx");
  thread molotov_end_fx();
}

function ref_11cb4(var_0, var_1) {
  var_0 notify("cleanup_branch");

  if(isDefined(var_0.ents)) {
    foreach(var_3 in var_0.ents) {
      if(isDefined(var_3)) {
        thread molotov_pool_end(var_3);
      }
    }

    return;
  }
}

function ref_11cb5(var_0, var_1) {
  if(isDefined(var_0.shareddata)) {
    if(isDefined(var_0.shareddata.branches)) {
      foreach(var_3 in var_0.shareddata.branches) {
        ref_11cb4(var_3, var_1);
      }
    }

    if(isDefined(var_0.shareddata.ref_11fc8)) {
      foreach(var_6 in var_0.shareddata.ref_11fc8) {
        if(isDefined(var_6)) {
          thread molotov_pool_end(var_6);
        }
      }

      return;
    }

    return;
  }
}