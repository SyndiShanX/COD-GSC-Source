/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\powers\coop_molotov.gsc
***********************************************/

molotov_init() {
  var_0 = spawnStruct();
  level.molotov = var_0;
  var_0._id_11B6E = getdvarint("_encstr_87F714DCC639EBDA7BB17B3A7BD96A168705F6DE36B9", 100);
  var_0._id_11B57 = getdvarint("_encstr_933F1C5B708DB1D7B0613F3C88FB1F46E119E2D37027BA0FCB4C2A2191A1", 8);
  var_0.start_airfield_safehouse = getdvarint("_encstr_87211A3A560D199D1898BFDB68D361D2A77506F5451762DDE1902FD3", 1) > 0;
  var_0._id_13F0C = 0;
  var_0._id_127E4 = [];
  var_0.scriptables = [];
  var_0.triggers = [];
  var_0.frametimestamp = 0;
  var_0.caststhisframe = 0;
  molotov_init_cast_data();
  molotov_init_pool_data();
  level.g_effect["_encstr_83E7116D1B032898E50A504EF5DDE0601A5717"] = loadfx("_encstr_AA83364E5B1227BC978A673725FE735768303B7E31963DC5A84A1B22B34D036C9028F5A8F70477B0D82B0798BED570474105A05060A02232");
  level.g_effect["_encstr_A6D9117BD1235FBE80D5561FAF3845174168E3"] = loadfx("_encstr_83C436CE33C3792DEEC197EE562C83BCBECC5A39B2E5B5BDD8BDA3BDCE79B3993CEB6BD1EDB3EBF6371D2C9DAFE6B563AF8DF6DDE2EC330F");
  level.g_effect["_encstr_8E7C16CE991EBEC4BAC9377D6E6B8DEB43562C32FA8DEDDD"] = loadfx("_encstr_AF7837484D50F852633885E7A5707806F72020831D0DC29F18A7B3AF33D28CC468513FD870ED87E09D1B32DF8028591F6A68B25743B6054E5B");
}

molotov_init_cast_data() {
  var_0 = _id_11CC2();
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

molotov_init_pool_data() {
  var_0 = _id_11CC2();
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

molotov_init_pool_mask() {
  var_0 = _id_11CC3();
  var_1 = [];
  var_1[4] = "_encstr_9ACA0BAFE026FDA761A08BE94A";
  var_1[8] = "_encstr_8391057BC78847";
  var_1[16] = "_encstr_B689088E9573914EA5D8";
  var_1[1] = "_encstr_B40101";
  var_1[2] = "_encstr_A9520822D2B211DBEE73";
  var_1[32] = "_encstr_B40101";
  var_1[64] = "_encstr_AFF605A1F9E16B";
  var_1[128] = "_encstr_9A9005D6A9486C";
  var_2 = [];
  var_3 = 1;
  var_4 = 4;
  var_5 = 32;

  for(var_6 = var_3;
    (var_6 & 3) > 0; var_6 = var_6 << 1) {
    for(var_7 = var_4;
      (var_7 & 28) > 0; var_7 = var_7 << 1) {
      for(var_8 = var_5;
        (var_8 & 224) > 0; var_8 = var_8 << 1) {
        var_9 = var_6 | var_7 | var_8;
        var_2[var_9] = var_1[var_7] + var_1[var_6] + var_1[var_8];
        var_9 = var_7 | var_8;
        var_2[var_9] = "_encstr_A7A408B9CA5D1D4E2C63";
      }
    }
  }

  var_0.scriptablestates = var_2;
}

molotov_on_give(var_0, var_1) {
  thread molotov_watch_fx();
}

molotov_on_take(var_0, var_1) {
  self notify("_encstr_AF500EAD7BC6EDE8DED9FA4716B6B2E6");
}

molotov_used(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = self getgunangles();
  var_2 = gettime();
  var_3 = anglesToForward(var_1) * 940 + anglestoup(var_1) * 120;

  if(isDefined(self.offhands))
    self.offhands.lastusedoffhandtime = 0;

  thread molotov_cleanup_grenade(var_0);
  var_4 = self.name;
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_5);
  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", var_0, "_encstr_BA730BF8AFF178988293F158B9", var_4);
  var_6 = (gettime() - var_2) / 1000;
  var_7 = var_3 + (0, 0, -800 * var_6);

  if(isPlayer(self)) {
    self.ascender_deathwatcher = postspawn_vindia();
    thread _id_14445(self.ascender_deathwatcher);
  }

  if(isDefined(var_5) && (isPlayer(var_5) || isagent(var_5)))
    thread molotov_stuck_player(var_0, var_5, var_1, var_7);
  else
    thread molotov_stuck(var_0, var_5, var_1, var_7);
}

bomber_shouldusetraversals(var_0, var_1) {
  var_2 = gettime();
  var_3 = var_0.origin;
  var_4 = var_0.angles;
  var_1 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_5, var_6, var_7, var_8, var_9, var_10);
  var_11 = getlaunchangles(var_3, var_4, var_9);
  var_12 = var_8;
  var_13 = (gettime() - var_2) / 1000;
  var_14 = var_12 + (0, 0, -800 * var_13);

  if(isDefined(var_0))
    var_1.owner = var_0;

  if(isDefined(var_5) && (isPlayer(var_5) || isagent(var_5)))
    level thread molotov_stuck_player(var_1, var_5, var_11, var_14);
  else
    level thread molotov_stuck(var_1, var_5, var_11, var_14);
}

getlaunchangles(var_0, var_1, var_2) {
  var_3 = vectorNormalize(var_2 - var_0);
  var_4 = vectortoangles(var_3);
  var_5 = (0, var_1[1], 0);
  var_6 = var_5 + (45, 0, 0);
  return var_6;
}

postspawn_vindia() {
  return scripts\cp\utility\player::getuniqueid();
}

_id_14445(var_0) {
  self notify("_encstr_A98B1CE8114BAA84EFD487A6498FD303EB2F295186FC1A87B34F0D17D5C0");
  self endon("_encstr_A98B1CE8114BAA84EFD487A6498FD303EB2F295186FC1A87B34F0D17D5C0");
  self endon("_encstr_9556193AF9231827C4423010AA5D1771979734B84587C0BF6B7A10" + var_0);
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.moloachievementvictims = 0;

  if(istrue(self.scriptedspawns)) {
    return;
  }
  for(;;) {
    if(self.moloachievementvictims > 3) {
      self giveachievement("_encstr_B6BC0661923878EE");
      self.scriptedspawns = 1;
      self notify("_encstr_9556193AF9231827C4423010AA5D1771979734B84587C0BF6B7A10" + var_0);
    }

    waitframe();
  }
}

molotov_stuck(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = vectorNormalize(var_3);
  var_7 = anglestoup(var_0.angles);
  var_8 = anglestoright(var_2);

  if(abs(vectordot(var_6, var_7)) >= 0.9848)
    var_5 = molotov_rebuild_angles_up_right(var_7, var_8);
  else
    var_5 = molotov_rebuild_angles_up_forward(var_7, var_6);

  var_0.angles = var_5;
  var_0 notify("_encstr_AD75063D571AE108");
  var_0.exploding = 1;
  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_860808CB78E2984063BA", 0);

  if(!isDefined(var_4))
    var_0 missilehidetrail();

  molotov_simulate_impact(var_0, var_0.origin, var_5, var_1, var_3, gettime());
}

molotov_stuck_player(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_weapon::grenadestuckto(var_0, var_1);
  var_4 = 1;

  if(isagent(var_1) && istrue(var_1.clearsoundsubmixmpbrinfilanim)) {
    var_5 = -1 * vectorNormalize((var_3[0], var_3[1], 0));
    var_6 = -1 * vectorNormalize(var_3);

    if(vectordot(anglesToForward(var_1.angles), var_5) > 0.5 && -0.5 < var_6[2] && var_6[2] < 0.5)
      var_4 = 0;
  }

  if(var_4)
    var_1 thread molotov_burn_for_time(6, self, var_0, var_0);

  var_0.exploding = 1;
  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_860808CB78E2984063BA", 0);
  var_0 missilehidetrail();
  var_3 = var_3 * (0, 0, 1);
  var_7 = var_0.origin;
  var_8 = (0, 0, -1);
  var_9 = var_7 + var_8 * 128;
  var_10 = molotov_get_cast_contents();
  var_11 = physics_raycast(var_7, var_9, var_10, var_0, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_11) && var_11.size > 0) {
    var_9 = var_11[0]["_encstr_BD260953AA97E3F014279D"];
    var_12 = var_11[0]["_encstr_820E07FAE8780B3A4C"];
    var_13 = var_11[0]["_encstr_850E077B0BF30318B9"];
    var_9 = var_9 - var_12 * 1;
    var_14 = vectordot(var_9 - var_7, var_8);
    var_15 = sqrt(2 * var_14 / 800);
    var_16 = var_12;
    var_17 = anglestoright(var_2);
    var_18 = molotov_rebuild_angles_up_right(var_16, var_17);
    thread molotov_simulate_impact(var_0, var_9, var_18, var_13, var_3, gettime() + var_15 * 1000);
    return;
  }

  var_0 notify("_encstr_AD75063D571AE108");
  waitframe();

  if(isDefined(var_0))
    var_0 delete();
}

molotovbadplace(var_0) {
  var_1 = createnavbadplacebybounds(var_0, (128, 128, 100), (0, 0, 0));
  return var_1;
}

molotov_simulate_impact(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0.owner;
  var_7 = scripts\engine\utility::ter_op(level.players.size > 15, 10, 20);
  var_8 = anglestoup(var_2);
  var_9 = var_1 + var_8 * 1;
  var_10 = var_9 + var_8 * 25;
  var_11 = molotov_get_cast_contents();
  var_12 = physics_raycast(var_9, var_10, var_11, var_0, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_12) && var_12.size > 0)
    var_10 = var_12[0]["_encstr_BD260953AA97E3F014279D"] - var_8 * 1;

  var_13 = var_10;
  var_14 = var_0;
  var_14 thread molotov_cleanup_burn_source();
  var_15 = molotov_get_next_burning_id();
  var_16 = 0;
  var_17 = vectordot(vectorNormalize(var_4), -1 * var_8);

  if(var_17 < 0.96593)
    var_16 = 1;

  var_18 = molotov_create_shared_data(var_6, var_5, var_14, var_15);
  var_18.badplace = molotovbadplace(var_1);
  var_18 thread molotov_cleanup();
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
  var_27 = ::molotov_branch_create_tendril_radial;

  if(var_16)
    var_27 = ::molotov_branch_create_forward_tendril_cone;

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
  var_27 = ::molotov_branch_create_tendril_radial;

  if(var_16)
    var_27 = undefined;

  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18.branches[var_18.branches.size] = var_22;
  var_20 = molotov_get_cast_data(var_19);
  var_21 = molotov_get_pool_data(var_19);
  var_31 = rotatepointaroundvector(var_30, var_28, var_24);
  var_32 = vectorNormalize(vectorcross(var_31, var_30));
  var_33 = vectorcross(var_32, var_28);
  var_34 = axistoangles(var_31, var_32, var_33);
  var_27 = ::molotov_branch_create_tendril_radial;

  if(var_16)
    var_27 = ::molotov_branch_create_right_tendril_cone;

  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18.branches[var_18.branches.size] = var_22;
  var_20 = molotov_get_cast_data(var_19);
  var_21 = molotov_get_pool_data(var_19);
  var_31 = rotatepointaroundvector(var_30, var_28, -1 * var_24);
  var_32 = vectorNormalize(vectorcross(var_31, var_30));
  var_33 = vectorcross(var_32, var_28);
  var_34 = axistoangles(var_31, var_32, var_33);
  var_27 = ::molotov_branch_create_tendril_radial;

  if(var_16)
    var_27 = ::molotov_branch_create_left_tendril_cone;

  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18.branches[var_18.branches.size] = var_22;
  var_20 = molotov_get_cast_data(var_19);
  var_21 = molotov_get_pool_data(var_19);
  var_31 = rotatepointaroundvector(var_30, var_28, var_25);
  var_32 = vectorNormalize(vectorcross(var_31, var_30));
  var_33 = vectorcross(var_32, var_28);
  var_34 = axistoangles(var_31, var_32, var_33);
  var_27 = ::molotov_branch_create_tendril_radial;

  if(var_16)
    var_27 = undefined;

  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18.branches[var_18.branches.size] = var_22;
  var_20 = molotov_get_cast_data(var_19);
  var_21 = molotov_get_pool_data(var_19);
  var_31 = rotatepointaroundvector(var_30, var_28, -1 * var_25);
  var_32 = vectorNormalize(vectorcross(var_31, var_30));
  var_33 = vectorcross(var_32, var_28);
  var_34 = axistoangles(var_31, var_32, var_33);
  var_27 = ::molotov_branch_create_tendril_radial;

  if(var_16)
    var_27 = undefined;

  var_22 = molotov_create_branch(var_18, var_20, var_21, undefined, var_13, var_34, var_3, 0, var_26, var_27);
  var_18.branches[var_18.branches.size] = var_22;
  _id_11CC7(var_18);

  foreach(var_22 in var_18.branches)
  var_22 thread molotov_start_branch();
}

molotov_cleanup() {
  self.burnsource scripts\engine\utility::waittill_notify_or_timeout("_encstr_8A490E5973475A8EE546CA63B23ACA46", 6.75);

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

  if(isDefined(self.badplace))
    destroynavobstacle(self.badplace);
}

molotov_create_shared_data(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.owner = var_0;
  var_4.team = var_0.team;
  var_4.impacttime = var_1;
  var_4.burnsource = var_2;
  var_4.burnid = var_3;
  var_4.branches = [];
  var_4._id_12F6E = 0;
  var_4.caststotal = 0;
  var_4.caststhisframe = 0;
  var_4.frametimestamp = gettime();
  var_4.castcontents = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  var_2.shareddata = var_4;
  return var_4;
}

_id_11CC7(var_0) {
  var_0.caststotal++;
  var_0.caststhisframe++;
  var_0.frametimestamp = gettime();
  var_1 = _id_11CC2();
  var_1.caststhisframe++;
}

_id_11CC8(var_0) {
  var_0._id_12F6E++;
  var_1 = _id_11CC2();
  var_1.scriptables[self.id] = self;

  if(var_1.scriptables.size > var_1._id_11B6E)
    _id_11CBC();
}

_id_11CC9(var_0) {
  var_1 = _id_11CC2();
  var_1.triggers[self.id] = self;

  if(var_1.triggers.size > var_1._id_11B6E)
    _id_11CBD();
}

_id_11CBF() {
  var_0 = _id_11CC2();
  var_0.scriptables[self.id] = undefined;
  var_1 = var_0.triggers[self.id];

  if(!isDefined(var_1))
    var_0._id_127E4 = scripts\engine\utility::array_remove(var_0._id_127E4, self.id);

  self notify("_encstr_AD75063D571AE108");
  self freescriptable();
}

_id_11CC0() {
  var_0 = _id_11CC2();
  var_0.triggers[self.id] = undefined;
  var_1 = var_0.scriptables[self.id];

  if(!isDefined(var_1))
    var_0._id_127E4 = scripts\engine\utility::array_remove(var_0._id_127E4, self.id);

  self delete();
}

_id_11CBC(var_0) {
  var_1 = _id_11CC2();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_3 in var_1._id_127E4) {
    var_2 = var_1.scriptables[var_3];

    if(isDefined(var_2)) {
      break;
    }
  }

  var_0 = istrue(var_0) || var_1.start_airfield_safehouse;

  if(!isDefined(var_2))
    _id_11CBE(var_3, var_0);
}

_id_11CBD(var_0) {
  var_1 = _id_11CC2();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_3 in var_1._id_127E4) {
    var_2 = var_1.triggers[var_3];

    if(isDefined(var_2)) {
      break;
    }
  }

  var_0 = istrue(var_0) || var_1.start_airfield_safehouse;

  if(isDefined(var_2))
    _id_11CBE(var_3, var_0);
}

_id_11CBE(var_0, var_1) {
  var_2 = _id_11CC2();
  var_3 = var_2.scriptables[var_0];

  if(isDefined(var_3)) {
    if(!istrue(var_1)) {
      var_2.scriptables[var_0] = undefined;
      var_2.triggers[var_0] = undefined;
      var_2._id_127E4 = scripts\engine\utility::array_remove(var_2._id_127E4, var_0);
      var_3 thread molotov_pool_end();
      return;
    }

    var_3 thread _id_11CBF();
  }

  var_4 = var_2.triggers[var_0];

  if(isDefined(var_4))
    var_4 thread _id_11CC0();
}

_id_11CB3(var_0) {
  if(var_0.frametimestamp < gettime()) {
    var_0.frametimestamp = gettime();
    var_0.caststhisframe = 0;
  }

  if(var_0.caststhisframe >= 3)
    return 0;

  var_1 = _id_11CC2();

  if(var_1.frametimestamp < gettime()) {
    var_1.frametimestamp = gettime();
    var_1.caststhisframe = 0;
  }

  if(var_1.caststhisframe >= var_1._id_11B57)
    return 0;

  return 1;
}

molotov_shared_data_is_complete(var_0) {
  var_1 = 0;
  var_2 = 60;
  var_3 = 20;

  if(self.caststotal >= var_2)
    var_1 = 1;
  else if(self._id_12F6E >= var_3)
    var_1 = 1;
  else if(istrue(var_0)) {
    var_4 = 1;

    foreach(var_6 in self.branches) {
      if(!var_6 molotov_branch_is_complete(1, 1)) {
        var_4 = 0;
        break;
      }
    }

    if(var_4)
      var_1 = 1;
  }

  if(var_1) {
    self.iscomplete = 1;
    _id_11CCA();
    self.branches = [];
  }

  return var_1;
}

_id_11CCA() {
  var_0 = self;

  if(isDefined(self.shareddata))
    var_0 = self.shareddata;

  if(!isDefined(var_0._id_11FC8))
    var_0._id_11FC8 = [];

  foreach(var_2 in self.branches) {
    foreach(var_4 in var_2.ents) {
      if(isDefined(var_4))
        var_0._id_11FC8[var_0._id_11FC8.size] = var_4;
    }
  }
}

molotov_create_branch(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
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

molotov_start_branch() {
  self endon("_encstr_A6C30F0B93974EABB33F5066936F18C37B");

  if(!isDefined(self.preventstarttime))
    self.preventstarttime = gettime();

  if(!isDefined(self.startingcasttype)) {
    if(!self.shareddata molotov_shared_data_is_complete()) {
      var_0 = molotov_branch_create_pool(self.startingorigin, self.startingangles, self.startingstuckto);
      var_0 = var_0 thread molotov_pool_start();
      self.iscomplete = 1;
      self.shareddata molotov_shared_data_is_complete(1);
    }
  } else {
    self.caststart = self.startingorigin;
    self.castend = undefined;
    self.castangles = self.startingangles;
    self.castdir = undefined;
    self.casttype = self.startingcasttype;
    self.startingorigin = undefined;
    self.startingangles = undefined;
    self.startingcasttype = undefined;

    for(;;) {
      if(self.shareddata molotov_shared_data_is_complete()) {
        break;
      }

      if(molotov_branch_is_complete(undefined, 1)) {
        break;
      }

      if(!_id_11CB3(self.shareddata)) {
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
          } else
            self.castdata.firstforwarddistwall = undefined;
        }
      }

      self.castdir = molotov_get_cast_dir(self.castangles, self.casttype);
      self.castend = self.caststart + self.castdir * molotov_get_cast_dist(self.casttype, self.castdata, self.iswallcast);
      var_3 = undefined;
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;
      var_8 = physics_raycast(self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

      if(isDefined(var_8) && var_8.size > 0) {
        var_3 = 1;
        var_4 = var_8[0]["_encstr_BD260953AA97E3F014279D"];
        var_5 = var_8[0]["_encstr_820E07FAE8780B3A4C"];
        var_6 = var_8[0]["_encstr_850E077B0BF30318B9"];
      }

      switch (self.casttype) {
        case 0:
          if(istrue(var_3)) {
            molotov_branch_register_cast(self.casttype, 0, var_4);
            var_9 = 1;

            if(isDefined(self.castdata.firstforwarddist)) {
              var_10 = var_4 - self.caststart;
              var_11 = vectordot(var_10, self.castdir);
              self.castdata.firstforwarddist = self.castdata.firstforwarddist - var_11;

              if(self.castdata.firstforwarddist > self.castdata.firstforwardmindist)
                var_9 = 0;
              else
                self.castdata.firstforwarddist = undefined;
            }

            var_7 = molotov_rebuild_angles_up_right(var_5, anglestoright(self.castangles));

            if(var_9) {
              var_12 = molotov_branch_create_pool(var_4, var_7, var_6);
              var_12 thread molotov_pool_start();
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
              self.castdata.firstforwarddist = self.castdata.firstforwarddist - var_11;

              if(self.castdata.firstforwarddist <= self.castdata.firstforwardmindist)
                self.castdata.firstforwarddist = undefined;
            }

            self.casttype = 1;
            self.caststart = self.castend;
          }

          break;
        case 1:
          if(istrue(var_3)) {
            var_7 = molotov_rebuild_angles_up_right(var_5, anglestoright(self.castangles));
            var_12 = molotov_branch_create_pool(var_4, var_7, var_6);
            var_12 thread molotov_pool_start();
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

      waittillframeend;
    }

    self.iscomplete = 1;
    self.shareddata molotov_shared_data_is_complete(1);
  }
}

molotov_branch_is_complete(var_0, var_1) {
  var_2 = 0;
  var_3 = undefined;

  if(!istrue(var_1))
    var_2 = self.shareddata molotov_shared_data_is_complete();

  if(!var_2) {
    if(isDefined(self.castdata) && isDefined(self.castdata.maxfails) && self.castfails >= self.castdata.maxfails)
      var_2 = 1;
    else if(isDefined(self.castdata) && isDefined(self.castdata.maxcasts) && self.casts >= self.castdata.maxcasts)
      var_2 = 1;
    else if(isDefined(self.castdata) && isDefined(self.castdata.maxents) && self.ents.size >= self.castdata.maxents)
      var_2 = 1;
    else if(istrue(var_0) && self.branches.size > 0) {
      var_3 = 1;

      foreach(var_5 in self.branches) {
        if(!var_5 molotov_branch_is_complete(var_0, var_1)) {
          var_3 = 0;
          break;
        }
      }

      if(var_3)
        var_2 = 1;
    }
  }

  if(var_2 && !istrue(self.iscomplete)) {
    var_7 = self.oncompletedfunc;
    self.oncompletedfunc = undefined;

    if(isDefined(var_7))
      self[[var_7]]();

    if(istrue(var_3)) {
      var_2 = 0;

      foreach(var_5 in self.branches) {
        if(!var_5 molotov_branch_is_complete(1, var_1)) {
          var_3 = 0;
          break;
        }
      }

      if(var_3)
        var_2 = 1;
    }
  }

  if(var_2) {
    self.iscomplete = 1;
    _id_11CCA();
    self.branches = [];
  }

  return var_2;
}

molotov_branch_register_cast(var_0, var_1, var_2) {
  _id_11CC7(self.shareddata);
  self.casts++;

  if(isDefined(var_1)) {
    if(var_1 == 0 || var_1 == 1 || var_1 == 2)
      self.castfails = 0;
  } else if(var_0 == 1)
    self.castfails++;
}

molotov_create_pool(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = easepower("_encstr_BA361853F723EB5970A5C0843FA1A83BEF502A274B0E4AC36183", var_0, var_1);
  var_10.stuckto = var_2;
  var_10.owner = var_3;
  var_10.burnsource = var_4;
  var_10.burnid = var_5;
  var_10.starttime = var_6;
  var_10.pooldata = var_7;
  var_10.poolmask = var_8;
  var_10.id = var_9;

  if(isDefined(var_2)) {
    var_11 = rotatevectorinverted(var_0 - var_2.origin, var_2.angles);
    var_12 = combineangles(invertangles(var_2.angles), var_1);
    var_10 validatecollision(var_2, var_11, var_12);
  }

  return var_10;
}

molotov_branch_create_pool(var_0, var_1, var_2) {
  var_3 = self.pooldata.typeid;
  var_4 = anglestoup(var_1);
  var_5 = vectordot(var_4, (0, 0, 1));

  if(var_5 <= -0.81915)
    var_3 = var_3 | 128;
  else if(var_5 <= 0.5)
    var_3 = var_3 | 64;
  else
    var_3 = var_3 | 32;

  var_6 = self.preventstarttime + self.pooldata.startdelayms;
  var_7 = molotov_create_pool(var_0, var_1, var_2, self.shareddata.owner, self.shareddata.burnsource, self.shareddata.burnid, var_6, self.pooldata, var_3);
  self.preventstarttime = var_6;
  self.ents[self.ents.size] = var_7;
  var_7.id = _id_11CC4();
  var_7 _id_11CC8(self.shareddata);
  return var_7;
}

molotov_pool_start() {
  if(istrue(self.started)) {
    return;
  }
  self.started = 1;
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A7F7116BB7D8BD8EEDCED707DBDBB1F5B2E623");

  while(gettime() < self.starttime)
    waitframe();

  self.ended = 0;
  molotov_watch_pool();
  thread molotov_pool_end();
}

molotov_watch_pool() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");

  if(isDefined(self.stuckto))
    self.stuckto endon("_encstr_AD75063D571AE108");

  self notify("_encstr_869F13412D322F63873B215077AF3817EBD645DE44");
  self.trigger = molotov_create_pool_trigger(self.pooldata.triggerradius, self.pooldata.triggerheight, self.pooldata.triggeroffset);
  self.poolmask = self.poolmask | 1;
  molotov_pool_update_scriptable();
  var_0 = randomfloatrange(6.5, 6.75);
  wait(var_0);
}

molotov_pool_end() {
  self endon("_encstr_AD75063D571AE108");

  if(istrue(self.ended)) {
    return;
  }
  self notify("_encstr_A7F7116BB7D8BD8EEDCED707DBDBB1F5B2E623");
  self.ended = 1;
  self.poolmask = self.poolmask &~1;
  self.poolmask = self.poolmask | 2;
  molotov_pool_update_scriptable();
  wait 1;

  if(isDefined(self.trigger))
    self.trigger thread _id_11CC0();

  wait 3.5;
  thread _id_11CBF();
}

_id_11CCC() {
  self endon("_encstr_AD75063D571AE108");
  _id_11CCD();
  thread _id_11CBF();
}

_id_11CCD() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");

  if(isDefined(self.stuckto))
    self.stuckto endon("_encstr_AD75063D571AE108");

  self waittill("_encstr_ABA008615A631510C7EA");
}

molotov_create_pool_trigger(var_0, var_1, var_2) {
  var_3 = self.origin - anglestoup(self.angles) * var_2;
  var_4 = spawn("_encstr_BE66191DB6995910437226C04038E353EE95B49957DAAE91C3AD72", var_3, 0, var_0, var_1);
  var_4.angles = self.angles;
  var_4.id = self.id;

  if(isDefined(self.stuckto)) {
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
  var_5.playersintrigger = [];
  var_4.struct = var_5;
  var_5 thread molotov_watch_pool_trigger_enter();
  var_5 thread molotov_watch_pool_trigger_exit();
  var_5 thread molotov_cleanup_pool_trigger();
  var_4 thread _id_11CCB();
  var_4 _id_11CC9();
  return var_4;
}

_id_11CCB() {
  self endon("_encstr_AD75063D571AE108");
  self.struct.attacker endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.struct.attacker endon("_encstr_81170C244F9CBDE72C01BB99A298");

  if(isDefined(self.struct.stuckto)) {
    var_0 = self.struct.stuckto;
    var_0 waittill("_encstr_AD75063D571AE108");
    thread _id_11CC0();
    thread _id_11CBF();
  }
}

molotov_watch_pool_trigger_enter() {
  if(isDefined(self.inflictor))
    self.inflictor endon("_encstr_AD75063D571AE108");

  self.trigger endon("_encstr_AD75063D571AE108");
  self.attacker endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.attacker endon("_encstr_81170C244F9CBDE72C01BB99A298");

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0) && !isagent(var_0)) {
      continue;
    }
    if(!scripts\cp\utility\player::isreallyalive(var_0)) {
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
    if(isagent(var_0) && istrue(var_0.clearsoundsubmixmpbrinfilanim) && isDefined(self.inflictor)) {
      var_3 = self.inflictor.origin - var_0.origin;
      var_3 = vectorNormalize((var_3[0], var_3[1], 0));

      if(vectordot(anglesToForward(var_0.angles), var_3) > 0.5)
        continue;
    }

    self.playersintrigger[var_2] = var_0;
    var_0 molotov_start_burning(self.attacker, self.inflictor, self.killcament, self.burnid);
  }
}

molotov_watch_pool_trigger_exit() {
  self.trigger endon("_encstr_AD75063D571AE108");

  for(;;) {
    foreach(var_2, var_1 in self.playersintrigger) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(!scripts\cp\utility\player::isreallyalive(var_1)) {
        continue;
      }
      if(var_1 istouching(self.trigger)) {
        continue;
      }
      self.playersintrigger[var_2] = undefined;
      var_1 molotov_stop_burning(self.burnid);
    }

    waitframe();
  }
}

molotov_cleanup_pool_trigger() {
  molotov_cleanup_pool_trigger_end_early();

  foreach(var_1 in self.playersintrigger) {
    if(isDefined(var_1))
      var_1 molotov_stop_burning(self.burnid);
  }

  if(isDefined(self.trigger))
    self.trigger thread _id_11CC0();
}

molotov_cleanup_pool_trigger_end_early() {
  self.trigger endon("_encstr_AD75063D571AE108");
  self.attacker endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.attacker endon("_encstr_81170C244F9CBDE72C01BB99A298");

  for(;;)
    waitframe();
}

molotov_pool_update_scriptable() {
  var_0 = _id_11CC3();
  var_1 = var_0.scriptablestates[self.poolmask];
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", var_1, 0);
}

molotov_branch_create_sub_branch(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self.shareddata;
  var_10 = molotov_get_cast_data(var_0);
  var_11 = molotov_get_pool_data(var_0);

  if(isDefined(self.castdata)) {
    if(self.castfails > self.castdata.maxfails) {
      return;
    }
    if(self.castfails > var_10.maxfails)
      return;
  }

  if(isDefined(var_2))
    var_10.firstforwarddist = var_2;

  if(isDefined(var_3))
    var_10.firstforwardmindist = var_3;

  if(isDefined(var_4))
    var_10.firstforwardmodanglesfunc = var_4;

  if(isDefined(var_5))
    var_10.firstforwarddistwall = var_5;

  if(isDefined(var_6))
    var_10.maxcasts = var_6;

  if(isDefined(var_7))
    var_10.maxents = var_7;

  var_12 = molotov_create_branch(var_9, var_10, var_11, self, self.caststart, self.castangles, undefined, self.casttype, self.preventstarttime);
  var_12.castfails = self.castfails;
  self.branches[self.branches.size] = var_12;
  var_9.branches[var_9.branches.size] = var_12;

  if(istrue(var_8))
    var_12 thread molotov_start_branch();

  return var_12;
}

molotov_branch_create_forward_tendril_cone() {
  var_0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, undefined, 44, undefined, undefined, 1);
}

molotov_branch_create_left_tendril_cone() {
  var_0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, ::molotov_left_tendril_mod_angles, 44, undefined, undefined, 1);
}

molotov_branch_create_right_tendril_cone() {
  var_0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, ::molotov_right_tendril_mod_angles, 44, undefined, undefined, 1);
}

molotov_branch_create_tendril_radial() {
  var_0 = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, ::molotov_tendril_mod_angles_radial, 44, 6, 1, 1);
}

molotov_rotate_angles_about_up(var_0, var_1) {
  var_2 = anglesToForward(var_0);
  var_3 = anglestoup(var_0);
  var_4 = undefined;
  var_2 = rotatepointaroundvector(var_3, var_2, var_1);
  var_4 = vectorNormalize(vectorcross(var_2, var_3));
  var_3 = vectorcross(var_4, var_2);
  return axistoangles(var_2, var_4, var_3);
}

molotov_left_tendril_mod_angles(var_0) {
  var_1 = randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(var_0, var_1);
}

molotov_right_tendril_mod_angles(var_0) {
  var_1 = -1 * randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(var_0, var_1);
}

molotov_tendril_mod_angles_radial(var_0) {
  var_1 = randomfloatrange(-60, 60);
  return molotov_rotate_angles_about_up(var_0, var_1);
}

molotov_cleanup_burn_source() {
  self endon("_encstr_AD75063D571AE108");
  wait 20;
  self delete();
}

molotov_cleanup_grenade(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::_id_143A5("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_81170C244F9CBDE72C01BB99A298");
  var_0 delete();
}

_id_11CC2() {
  return level.molotov;
}

_id_11CC3() {
  var_0 = _id_11CC2();
  var_1 = var_0.pooldata;
  return var_1;
}

_id_11CC1() {
  var_0 = _id_11CC2();
  var_1 = var_0.castdata;
  return var_1;
}

_id_11CC4() {
  var_0 = _id_11CC2();
  var_1 = var_0._id_13F0C;
  var_0._id_13F0C++;
  var_0._id_127E4 = scripts\engine\utility::array_add(var_0._id_127E4, var_1);
  return var_1;
}

molotov_get_cast_data(var_0) {
  var_1 = _id_11CC1();
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

    if(isDefined(var_1.firstforwarddistwall[var_0]))
      var_2.firstforwarddistwall = var_1.firstforwarddistwall[var_0];
  }

  return var_2;
}

molotov_get_pool_data(var_0) {
  var_1 = _id_11CC3();
  var_2 = spawnStruct();
  var_2.typeid = var_0;
  var_2.triggerradius = var_1.triggerradius[var_0];
  var_2.triggerheight = var_1.triggerheight[var_0];
  var_2.triggeroffset = var_1.triggeroffset[var_0];
  var_2.startdelayms = var_1.startdelayms[var_0];
  return var_2;
}

molotov_get_cast_dir(var_0, var_1) {
  switch (var_1) {
    case 0:
      return anglesToForward(var_0);
    case 1:
      return -1 * anglestoup(var_0);
    case 2:
      return anglestoup(var_0);
  }

  return undefined;
}

molotov_get_cast_dist(var_0, var_1, var_2) {
  switch (var_0) {
    case 0:
      if(isDefined(var_1.firstforwarddist))
        return var_1.firstforwarddist;
      else if(var_2 && isDefined(var_1.distforwardwall))
        return var_1.distforwardwall;
      else
        return var_1.distforward;
    case 1:
      return var_1.distdown;
    case 2:
      return var_1.distup;
  }

  return undefined;
}

molotov_get_cast_contents() {
  return physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
}

molotov_rebuild_angles_up_right(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_0, var_1));
  var_1 = vectorcross(var_2, var_0);
  return axistoangles(var_2, var_1, var_0);
}

molotov_rebuild_angles_up_forward(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_1, var_0));
  var_1 = vectorcross(var_0, var_2);
  return axistoangles(var_1, var_2, var_0);
}

molotov_start_burning(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {}

  var_4 = molotov_get_burning_info(1);

  if(!isDefined(var_3))
    var_3 = molotov_get_next_burning_id();

  var_5 = molotov_get_burning_source(var_0, var_1, var_2, var_4, var_3, 1);
  var_6 = 0;

  if(var_5.count <= 0)
    var_6 = 1;

  var_5.count++;

  if(var_6)
    thread molotov_update_burning();
}

molotov_stop_burning(var_0) {
  var_1 = molotov_get_burning_info();

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = molotov_get_burning_source(undefined, undefined, undefined, var_1, var_0, 0);

  if(isDefined(var_2)) {
    if(var_2.count > 0) {
      var_3 = 0;

      if(var_2.count == 1)
        var_3 = 1;

      var_2.count--;

      if(var_3)
        thread molotov_update_burning();
    }
  }
}

molotov_burn_for_time(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88660EE03537E73A3FF39DDA0209EDD0");
  var_4 = molotov_get_next_burning_id();
  molotov_start_burning(var_1, var_2, var_3, var_4);
  wait(var_0);
  molotov_stop_burning(var_4);
}

molotov_clear_burning(var_0) {
  self notify("_encstr_88660EE03537E73A3FF39DDA0209EDD0");
  self.burninginfo = undefined;
}

molotov_update_burning() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88660EE03537E73A3FF39DDA0209EDD0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_977F0FBA0EC8B0A3CAF589AB27735A379D");
  self endon("_encstr_977F0FBA0EC8B0A3CAF589AB27735A379D");
  thread molotov_cleanup_burning();
  var_0 = molotov_get_burning_info();

  if(gettime() <= var_0.updatetimestamp)
    waitframe();

  var_1 = 0;

  for(;;) {
    var_0 = molotov_get_burning_info();
    var_2 = undefined;

    if(!isPlayer(self)) {
      self._blackboard.isburning = undefined;
      self.burningdirection = undefined;
    }

    foreach(var_4 in var_0.sources) {
      if(var_4 molotov_burning_source_is_valid()) {
        if(!isDefined(var_2) || var_4.id > var_2)
          var_2 = var_4.id;

        continue;
      }

      var_0.sources[var_4.id] = undefined;
    }

    if(isDefined(var_2)) {
      var_0.timeoff = 0;
      var_0.timeon = var_0.timeon + 0.05;
      var_4 = var_0.sources[var_2];
      var_6 = 15;

      if(var_0.timeon > 1.5)
        var_6 = 30;
      else if(var_0.timeon > 0.5)
        var_6 = 25;

      if(isagent(self)) {
        if(!istrue(self._id_13A35)) {
          if(isPlayer(var_4.attacker) && var_4.attacker _id_11CCE()) {
            if(!istrue(var_4.attacker.scriptedspawns))
              var_4.attacker.moloachievementvictims = var_4.attacker.moloachievementvictims + 1;

            self._id_13A35 = 1;
          }
        }
      }

      var_7 = var_4.attacker.origin;

      if(isDefined(var_4.inflictor))
        var_7 = var_4.inflictor.origin;
      else
        var_4.inflictor = undefined;

      if(!isPlayer(self)) {
        if(self.health <= var_6)
          self.burningtodeath = 1;
        else if(!var_1) {
          self._blackboard.isburning = 1;
          self.burningtodeath = 0;
          var_8 = anglestoright(self.angles);
          var_9 = vectorNormalize(var_7 - self.origin);

          if(vectordot(var_8, var_9) > 0)
            self.burningdirection = "_encstr_8253060E2B5FE330";
          else
            self.burningdirection = "_encstr_A5AD056A019C63";

          var_1 = 1;
        }
      }

      if(var_0.timetodamage <= 0) {
        var_10 = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";

        if(isagent(self))
          var_10 = "_encstr_9B0D099AD3887D91252954";

        self dodamage(var_6, var_7, var_4.attacker, var_4.inflictor, var_10, "_encstr_BA730BF8AFF178988293F158B9");
        var_0.firstdamagedone = 1;
        var_0.timetodamage = 0.25;
      } else {
        var_10 = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";

        if(isagent(self))
          var_10 = "_encstr_9B0D099AD3887D91252954";

        if(!var_0.firstdamagedone) {
          self dodamage(var_6, var_7, var_4.attacker, var_4.inflictor, var_10, "_encstr_BA730BF8AFF178988293F158B9");
          var_0.firstdamagedone = 1;
        }

        var_0.timetodamage = var_0.timetodamage - 0.05;
      }
    } else {
      var_0.timeoff = var_0.timeoff + 0.05;

      if(var_0.timeoff >= 2.5)
        thread molotov_clear_burning();
    }

    var_0.updatetimestamp = gettime();
    wait 0.05;
  }
}

_id_11CCE() {
  if(isDefined(self.waittill_any_timeout_no_endon_death_4) && gettime() - self.waittill_any_timeout_no_endon_death_4 < 4000)
    return 1;
  else
    return 0;
}

molotov_is_burning() {
  var_0 = molotov_get_burning_info();
  return isDefined(var_0) && var_0.sources.size > 0;
}

molotov_get_burning_info(var_0) {
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

molotov_get_burning_source(var_0, var_1, var_2, var_3, var_4, var_5) {
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

molotov_burning_source_is_valid() {
  if(!isDefined(self.attacker))
    return 0;

  if(!isDefined(self.info.victim))
    return 0;

  if(!scripts\cp\utility\player::isreallyalive(self.info.victim))
    return 0;

  if(self.attacker != self.info.victim && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.attacker, self.info.victim)))
    return 0;

  if(self.hasinflictor && !isDefined(self.inflictor))
    return 0;

  if(self.count <= 0)
    return 0;

  return 1;
}

molotov_get_next_burning_id() {
  var_0 = _id_11CC2();

  if(!isDefined(var_0.burningid))
    var_0.burningid = 0;

  var_1 = var_0.burningid;
  var_0.burningid++;
  return var_1;
}

molotov_cleanup_burning() {
  self notify("_encstr_BAAE104FC1C0D6FE1BC77958AB6873A30E59");
  self endon("_encstr_BAAE104FC1C0D6FE1BC77958AB6873A30E59");
  childthread molotov_cleanup_burning_on_death();
  childthread molotov_cleanup_burning_on_game_end();
}

molotov_cleanup_burning_on_death() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88660EE03537E73A3FF39DDA0209EDD0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  thread molotov_clear_burning(1);
}

molotov_cleanup_burning_on_game_end() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88660EE03537E73A3FF39DDA0209EDD0");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread molotov_clear_burning();
}

molotov_on_player_damaged(var_0) {
  if(var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83")
    return 1;

  var_0.victim thread scripts\cp\cp_weapons::enableburnfxfortime(0.5);
  return 1;
}

molotov_watch_fx() {
  self endon("_encstr_A6491180F55C480DCA9BF797EB32DFE8D70FAA");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = self getheldoffhand();

    if(!nullweapon(var_2) && var_2.basename == "_encstr_BA730BF8AFF178988293F158B9")
      var_1 = 1;

    if(var_1 && !var_0)
      thread molotov_begin_fx();
    else if(var_0 && !var_1)
      thread molotov_end_fx();

    var_0 = var_1;
    waitframe();
  }
}

molotov_begin_fx() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_B6EE0F72489117B3C8559FAD0DF8316BC3");
  self._id_12743 = 1;
  self setscriptablepartstate("_encstr_BD8411955CEA2D07A6A3B7B3C816AEDE393619", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_915110C201FF735285933AA351C30E3A0358", "_encstr_930B07BB1B6B3854FF", 0);
  var_0 = 0.4;
  wait(var_0);
  self setscriptablepartstate("_encstr_BD8411955CEA2D07A6A3B7B3C816AEDE393619", "_encstr_930B07BB1B6B3854FF", 0);
}

molotov_end_fx() {
  self notify("_encstr_B6EE0F72489117B3C8559FAD0DF8316BC3");

  if(istrue(self._id_12743)) {
    self setscriptablepartstate("_encstr_BD8411955CEA2D07A6A3B7B3C816AEDE393619", "_encstr_A7A408B9CA5D1D4E2C63", 0);
    self setscriptablepartstate("_encstr_915110C201FF735285933AA351C30E3A0358", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  }

  self._id_12743 = undefined;
}

_id_11CB4(var_0) {
  var_0 notify("_encstr_A6C30F0B93974EABB33F5066936F18C37B");

  if(isDefined(var_0.ents)) {
    foreach(var_2 in var_0.ents) {
      if(isDefined(var_2))
        var_2 thread molotov_pool_end();
    }
  }
}

_id_11CB5(var_0) {
  if(isDefined(var_0.shareddata)) {
    if(isDefined(var_0.shareddata.branches)) {
      foreach(var_2 in var_0.shareddata.branches)
      _id_11CB4(var_2);
    }

    if(isDefined(var_0.shareddata._id_11FC8)) {
      foreach(var_5 in var_0.shareddata._id_11FC8) {
        if(isDefined(var_5))
          var_5 thread molotov_pool_end();
      }
    }
  }
}

_id_11CB6() {
  self notify("_encstr_A6491180F55C480DCA9BF797EB32DFE8D70FAA");
  thread molotov_end_fx();
}