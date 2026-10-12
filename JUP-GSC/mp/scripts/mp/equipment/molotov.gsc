/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\molotov.gsc
***********************************************/

#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_util;
#using scripts\mp\equipment;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\weapons;
#namespace molotov;

function molotov_init() {
  assertex(!isDefined(level.molotov), "<dev string:x1c>");
  leveldata = spawnStruct();
  level.molotov = leveldata;
  level.molotovdamagethrottle = throttle_initialize("molotovDamageThrottle", 4, 0.05);
  leveldata.maxpools = getdvarint(@ "hash_541e147e1379b35e", 100);
  leveldata.maxcastsperframe = getdvarint(@ "hash_3b54ad814e59b401", 8);
  leveldata.immediatecleanup = getdvarint(@ "hash_ec13dc5b3ae7d79c", 1) > 0;
  leveldata.uniquepoolid = 0;
  leveldata.poolids = [];
  leveldata.scriptables = [];
  leveldata.triggers = [];
  leveldata.frametimestamp = 0;
  leveldata.caststhisframe = 0;
  level.g_effect["vfx_burn_med_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx");
  level.g_effect["vfx_burn_sml_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx");
  level.g_effect["vfx_burn_sml_head_low"] = loadfx("vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx");
  molotov_init_cast_data();
  molotov_init_pool_data();
  registersharedfunc("molotov", "molotov_simulate_impact", &molotov_simulate_impact);
  registersharedfunc("molotov", "molotov_get_cast_contents", &molotov_get_cast_contents);
  registersharedfunc("molotov", "molotov_rebuild_angles_up_right", &molotov_rebuild_angles_up_right);
  registersharedfunc("molotov", "molotov_rebuild_angles_up_forward", &molotov_rebuild_angles_up_forward);
}

function molotov_init_cast_data() {
  leveldata = molotov_get_level_data();
  castdata = leveldata.castdata;

  if(!isDefined(castdata)) {
    castdata = spawnStruct();
    leveldata.castdata = castdata;
  }

  castdata.distforward = [];
  castdata.distdown = [];
  castdata.distup = [];
  castdata.maxcasts = [];
  castdata.maxfails = [];
  castdata.maxents = [];
  castdata.firstforwarddist = [];
  castdata.firstforwardmindist = [];
  castdata.firstforwardmodanglesfunc = [];
  id = 4;
  castdata.distforward[id] = undefined;
  castdata.distdown[id] = undefined;
  castdata.distup[id] = undefined;
  castdata.maxcasts[id] = undefined;
  castdata.maxfails[id] = undefined;
  castdata.maxents[id] = 1;
  id = 8;
  castdata.distforward[id] = 50;
  castdata.distdown[id] = 50;
  castdata.distup[id] = 25;
  castdata.maxcasts[id] = 4;
  castdata.maxfails[id] = 3;
  castdata.maxents[id] = 1;
  castdata.distforwardwall[id] = 25;
  id = 16;
  castdata.distforward[id] = 15;
  castdata.distdown[id] = 50;
  castdata.distup[id] = 25;
  castdata.maxcasts[id] = 17;
  castdata.maxfails[id] = 3;
  castdata.maxents[id] = 3;
  castdata.firstforwarddist[id] = 85;
  castdata.firstforwardmindist[id] = 8;
  castdata.distforwardwall[id] = 8;
  castdata.firstforwarddistwall[id] = 44;
}

function molotov_init_pool_data() {
  leveldata = molotov_get_level_data();
  pooldata = leveldata.pooldata;

  if(!isDefined(pooldata)) {
    pooldata = spawnStruct();
    leveldata.pooldata = pooldata;
  }

  pooldata.triggerradius = [];
  pooldata.triggerheight = [];
  pooldata.triggeroffset = [];
  pooldata.startdelayms = [];
  id = 4;
  pooldata.triggerradius[id] = 30;
  pooldata.triggerheight[id] = 55;
  pooldata.triggeroffset[id] = 15;
  pooldata.startdelayms[id] = 0;
  id = 8;
  pooldata.triggerradius[id] = 30;
  pooldata.triggerheight[id] = 55;
  pooldata.triggeroffset[id] = 15;
  pooldata.startdelayms[id] = 100;
  id = 16;
  pooldata.triggerradius[id] = 10;
  pooldata.triggerheight[id] = 55;
  pooldata.triggeroffset[id] = 15;
  pooldata.startdelayms[id] = 100;
  molotov_init_pool_mask();
}

function molotov_init_pool_mask() {
  var_dcf9401f976e906f = molotov_get_pool_level_data();
  var_6f6efec7e89387e8 = [];
  var_6f6efec7e89387e8[4] = "coreCenter";
  var_6f6efec7e89387e8[8] = "core";
  var_6f6efec7e89387e8[16] = "tendril";
  var_6f6efec7e89387e8[1] = "";
  var_6f6efec7e89387e8[2] = "DieDown";
  var_6f6efec7e89387e8[32] = "";
  var_6f6efec7e89387e8[64] = "Wall";
  var_6f6efec7e89387e8[128] = "Ceil";
  scriptablestates = [];
  var_e42c4a59211c25aa = (1 | 2) ^ (1 | 2) &(1 | 2) - 1;
  var_a56ffa08fd7c6e21 = (4 | 8 | 16) ^ (4 | 8 | 16) &(4 | 8 | 16) - 1;
  var_880b6bd9b71c4abc = (32 | 64 | 128) ^ (32 | 64 | 128) &(32 | 64 | 128) - 1;
  statebit = var_e42c4a59211c25aa;

  while((statebit &(1 | 2)) > 0) {
    typebit = var_a56ffa08fd7c6e21;

    while((typebit &(4 | 8 | 16)) > 0) {
      orientbit = var_880b6bd9b71c4abc;

      while((orientbit &(32 | 64 | 128)) > 0) {
        mask = statebit | typebit | orientbit;
        scriptablestates[mask] = var_6f6efec7e89387e8[typebit] + var_6f6efec7e89387e8[statebit] + var_6f6efec7e89387e8[orientbit];
        mask = typebit | orientbit;
        scriptablestates[mask] = "neutral";
        orientbit <<= 1;
      }

      typebit <<= 1;
    }

    statebit <<= 1;
  }

  var_dcf9401f976e906f.scriptablestates = scriptablestates;
}

function molotov_on_give(equipmentref, slot, variantid) {
  thread molotov_watch_fx();
}

function molotov_on_take(equipmentref, slot) {
  self notify("molotov_taken");
}

function molotov_used(grenade) {
  grenade endon("death");
  grenade endon("molotov_water_impact");

  if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    grenade endon("missile_water_impact");
    thread function_e56975d29612c12a(grenade);
  }

  launchangles = self getgunangles();
  launchtimems = gettime();
  launchvelocity = anglesToForward(launchangles) * 940 + anglestoup(launchangles) * 120;
  thread molotov_cleanup_grenade(grenade);
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(level.gamemodemolotovfunc)) {
    [[level.gamemodemolotovfunc]](grenade, self);
  }

  traveltime = (gettime() - launchtimems) / 1000;
  impactvelocity = launchvelocity + (0, 0, -800 * traveltime);

  if(isDefined(stuckto) && (isPlayer(stuckto) || isagent(stuckto))) {
    thread molotov_stuck_player(grenade, stuckto, launchangles, impactvelocity);
    return;
  }

  thread molotov_stuck(grenade, stuckto, launchangles, impactvelocity);
}

function function_e56975d29612c12a(grenade) {
  grenade endon("explode");
  self endon("death");
  grenade waittill("missile_water_impact");
  grenade delete();
}

function molotov_stuck(grenade, stuckto, launchangles, impactvelocity) {
  angles = undefined;
  forward = vectorNormalize(impactvelocity);
  up = anglestoup(grenade.angles);
  right = anglestoright(launchangles);

  if(abs(vectordot(forward, up)) >= 0.9848) {
    angles = molotov_rebuild_angles_up_right(up, right);
  } else {
    angles = molotov_rebuild_angles_up_forward(up, forward);
  }

  grenade.angles = angles;
  grenade.exploding = 1;
  grenade setscriptablepartstate("effects", "explode", 0);
  grenade missilehidetrail();
  grenade.prevent_knockdown = 1;
  grenade notify("death");
  var_79fe84c0e97de2eb = undefined;
  bundle = function_d89c621ce916f11e();

  if(isDefined(bundle)) {
    var_79fe84c0e97de2eb = bundle.var_1731b5299dbc3a45;
  }

  molotov_simulate_impact(grenade, grenade.origin, angles, stuckto, impactvelocity, gettime(), var_79fe84c0e97de2eb);
}

function molotov_stuck_player(grenade, stuckto, launchangles, impactvelocity) {
  grenadestuckto(grenade, stuckto);
  stuckto thread molotov_burn_for_time(6, self, grenade, grenade);
  grenade.exploding = 1;
  grenade setscriptablepartstate("effects", "explode", 0);
  grenade missilehidetrail();
  impactvelocity *= (0, 0, 1);
  caststart = grenade.origin;
  castdir = (0, 0, -1);
  castend = caststart + castdir * 128;
  contents = molotov_get_cast_contents();
  castresults = physics_raycast(caststart, castend, contents, grenade, 0, "physicsquery_closest", 1);

  if(isDefined(castresults) && castresults.size > 0) {
    castend = castresults[0]["position"];
    casthitnorm = castresults[0]["normal"];
    casthitent = castresults[0]["entity"];
    castend -= casthitnorm * 1;
    d = vectordot(castend - caststart, castdir);
    t = sqrt(2 * d / -1 * -800);
    up = casthitnorm;
    right = anglestoright(launchangles);
    impactangles = molotov_rebuild_angles_up_right(up, right);
    grenade.prevent_knockdown = 1;
    var_79fe84c0e97de2eb = undefined;
    bundle = function_d89c621ce916f11e();

    if(isDefined(bundle)) {
      var_79fe84c0e97de2eb = bundle.var_1731b5299dbc3a45;
    }

    thread molotov_simulate_impact(grenade, castend, impactangles, casthitent, impactvelocity, gettime() + t * 1000, var_79fe84c0e97de2eb);
    return;
  }

  grenade notify("death");
  waitframe();

  if(isDefined(grenade)) {
    grenade delete();
  }
}

function molotovbadplace(impactorigin) {
  if(!scripts\mp\bots\bots_util::bot_bots_enabled_or_added() && !scripts\common\utility::function_a10967d736dc56e5()) {
    return;
  }

  if(isDefined(level.var_85f0faee1e7958bb)) {
    badplace = function_619cdac2efb21978(impactorigin, (128, 128, 100), (0, 0, 0), level.var_85f0faee1e7958bb);
  } else {
    badplace = createnavbadplacebybounds(impactorigin, (128, 128, 100), (0, 0, 0));
  }

  return badplace;
}

function molotov_simulate_impact(grenade, impactorigin, impactangles, impactent, impactvelocity, impacttime, var_54c186a6b8a2ae1) {
  owner = grenade.owner;

  if(!istrue(level.dangerzoneskipequipment)) {
    var_a53fbeeb744eae5c = ter_op(level.players.size > 15, 10, 20);
    scripts\mp\spawnlogic::addspawndangerzone(impactorigin - (0, 0, 128), 225, 256, owner.team, var_a53fbeeb744eae5c, owner, 1);
  }

  impactnormal = anglestoup(impactangles);
  caststart = impactorigin + impactnormal * 1;
  castend = caststart + impactnormal * 25;
  contents = molotov_get_cast_contents();
  castresults = physics_raycast(caststart, castend, contents, grenade, 0, "physicsquery_closest", 1);

  if(isDefined(castresults) && castresults.size > 0) {
    castend = castresults[0]["position"] - impactnormal * 1;
  }

  borigin = castend;
  burnsource = grenade;
  burnsource thread molotov_cleanup_burn_source();
  burnid = molotov_get_next_burning_id();
  coneimpact = 0;
  impactdot = vectordot(vectorNormalize(impactvelocity), -1 * impactnormal);

  if(impactdot < 0.96593) {
    coneimpact = 1;
  }

  shareddata = molotov_create_shared_data(owner, impacttime, burnsource, burnid);
  shareddata.badplace = molotovbadplace(impactorigin);
  shareddata thread molotov_cleanup();
  grenade function_49197cd063a740ea(&function_946f8ebb6c6efd92);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      if(isarray(elevators)) {
        foreach(arrelevator in elevators) {
          arrelevator thread scripts\common\elevators::isentitytouchingdoortrigger(grenade);
        }

        continue;
      }

      elevators thread scripts\common\elevators::isentitytouchingdoortrigger(grenade);
    }
  }

  id = 4;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, impactorigin, impactangles, impactent);
  shareddata.branches[shareddata.branches.size] = branch;
  var_6f2b46872df538de = 25;
  var_df64badccf60fd69 = 65;
  var_144e6d19329167bd = 115;
  sidepreventstarttime = gettime() + pooldata.startdelayms;
  id = 8;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = &molotov_branch_create_forward_tendril_cone;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, impactangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  forward = anglesToForward(impactangles);
  right = anglestoright(impactangles);
  up = anglestoup(impactangles);
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  bforward = forward * -1;
  bright = right * -1;
  bup = up;
  bangles = axistoangles(bforward, bright, bup);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = undefined;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  bforward = rotatepointaroundvector(up, forward, var_df64badccf60fd69);
  bright = vectorNormalize(vectorcross(bforward, up));
  bup = vectorcross(bright, forward);
  bangles = axistoangles(bforward, bright, bup);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = &molotov_branch_create_right_tendril_cone;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  bforward = rotatepointaroundvector(up, forward, -1 * var_df64badccf60fd69);
  bright = vectorNormalize(vectorcross(bforward, up));
  bup = vectorcross(bright, forward);
  bangles = axistoangles(bforward, bright, bup);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = &molotov_branch_create_left_tendril_cone;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  bforward = rotatepointaroundvector(up, forward, var_144e6d19329167bd);
  bright = vectorNormalize(vectorcross(bforward, up));
  bup = vectorcross(bright, forward);
  bangles = axistoangles(bforward, bright, bup);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = undefined;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);
  bforward = rotatepointaroundvector(up, forward, -1 * var_144e6d19329167bd);
  bright = vectorNormalize(vectorcross(bforward, up));
  bup = vectorcross(bright, forward);
  bangles = axistoangles(bforward, bright, bup);
  oncompletedfunc = &molotov_branch_create_tendril_radial;

  if(coneimpact) {
    oncompletedfunc = undefined;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc);
  shareddata.branches[shareddata.branches.size] = branch;
  molotov_register_cast(shareddata);

  foreach(branch in shareddata.branches) {
    branch thread molotov_start_branch(var_54c186a6b8a2ae1);
  }
}

function molotov_cleanup() {
  self.burnsource waittill_notify_or_timeout("entitydeleted", 6.75);

  while(true) {
    branchesterminated = 1;

    foreach(branch in self.branches) {
      if(!istrue(branch.iscomplete)) {
        branchesterminated = 0;
        break;
      }

      if(!branchesterminated) {
        break;
      }
    }

    if(branchesterminated) {
      break;
    }

    waitframe();
  }

  if(isDefined(self.badplace)) {
    destroynavobstacle(self.badplace);
  }
}

function molotov_create_shared_data(owner, impacttime, burnsource, burnid) {
  shareddata = spawnStruct();
  shareddata.owner = owner;
  shareddata.team = owner.team;
  shareddata.impacttime = impacttime;
  shareddata.burnsource = burnsource;
  shareddata.burnid = burnid;
  shareddata.branches = [];
  shareddata.scriptablecount = 0;
  shareddata.caststotal = 0;
  shareddata.caststhisframe = 0;
  shareddata.frametimestamp = gettime();
  shareddata.castcontents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  burnsource.shareddata = shareddata;
  return shareddata;
}

function molotov_register_cast(shareddata) {
  shareddata.caststotal++;
  shareddata.caststhisframe++;
  shareddata.frametimestamp = gettime();
  leveldata = molotov_get_level_data();
  leveldata.caststhisframe++;
}

function molotov_register_scriptable(shareddata) {
  assertex(isDefined(self.id), "<dev string:x49>");
  shareddata.scriptablecount++;
  leveldata = molotov_get_level_data();
  leveldata.scriptables[self.id] = self;
  println("<dev string:xab>" + leveldata.scriptables.size);

  if(leveldata.scriptables.size > leveldata.maxpools) {
    molotov_delete_oldest_scriptable();
  }
}

function molotov_register_trigger(trigger) {
  leveldata = molotov_get_level_data();
  leveldata.triggers[self.id] = self;
  println("<dev string:xe4>" + self getentitynumber() + "<dev string:x110>" + leveldata.triggers.size);

  if(leveldata.triggers.size > leveldata.maxpools) {
    molotov_delete_oldest_trigger();
  }
}

function molotov_delete_scriptable() {
  leveldata = molotov_get_level_data();
  leveldata.scriptables[self.id] = undefined;
  trigger = leveldata.triggers[self.id];

  if(!isDefined(trigger)) {
    leveldata.poolids = array_remove(leveldata.poolids, self.id);
  }

  self notify("death");
  self freescriptable();
}

function molotov_delete_trigger() {
  leveldata = molotov_get_level_data();
  leveldata.triggers[self.id] = undefined;
  scriptable = leveldata.scriptables[self.id];

  if(!isDefined(scriptable)) {
    leveldata.poolids = array_remove(leveldata.poolids, self.id);
  }

  println("<dev string:x121>" + self getentitynumber() + "<dev string:x110>" + leveldata.triggers.size);
  self delete();
}

function molotov_delete_oldest_scriptable(immediate) {
  leveldata = molotov_get_level_data();
  scriptable = undefined;
  id = undefined;

  foreach(id in leveldata.poolids) {
    scriptable = leveldata.scriptables[id];

    if(isDefined(scriptable)) {
      break;
    }
  }

  immediate = istrue(immediate) || leveldata.immediatecleanup;

  if(getdvarint(@ "hash_7dfd0d2d59762b9e", 1) == 1) {
    if(isDefined(scriptable)) {
      molotov_delete_pool_by_id(id, immediate);
    }

    return;
  }

  if(!isDefined(scriptable)) {
    molotov_delete_pool_by_id(id, immediate);
  }
}

function molotov_delete_oldest_trigger(immediate) {
  leveldata = molotov_get_level_data();
  trigger = undefined;
  id = undefined;

  foreach(id in leveldata.poolids) {
    trigger = leveldata.triggers[id];

    if(isDefined(trigger)) {
      break;
    }
  }

  immediate = istrue(immediate) || leveldata.immediatecleanup;

  if(isDefined(trigger)) {
    molotov_delete_pool_by_id(id, immediate);
  }
}

function molotov_delete_pool_by_id(id, immediate) {
  leveldata = molotov_get_level_data();
  scriptable = leveldata.scriptables[id];

  if(isDefined(scriptable)) {
    if(!istrue(immediate)) {
      leveldata.scriptables[id] = undefined;
      leveldata.triggers[id] = undefined;
      leveldata.poolids = array_remove(leveldata.poolids, id);
      scriptable thread molotov_pool_end();
      println("<dev string:x14d>" + leveldata.scriptables.size);
      return;
    }

    scriptable thread molotov_delete_scriptable();
    println("<dev string:x193>" + leveldata.scriptables.size);
  }

  trigger = leveldata.triggers[id];

  if(isDefined(trigger)) {
    trigger thread molotov_delete_trigger();
  }
}

function molotov_can_cast_this_frame(shareddata) {
  if(shareddata.frametimestamp < gettime()) {
    shareddata.frametimestamp = gettime();
    shareddata.caststhisframe = 0;
  }

  if(shareddata.caststhisframe >= 3) {
    return false;
  }

  leveldata = molotov_get_level_data();

  if(leveldata.frametimestamp < gettime()) {
    leveldata.frametimestamp = gettime();
    leveldata.caststhisframe = 0;
  }

  if(leveldata.caststhisframe >= leveldata.maxcastsperframe) {
    return false;
  }

  return true;
}

function molotov_shared_data_is_complete(var_af8745e2185687a8) {
  iscomplete = 0;
  maxcasts = 60;
  maxents = 20;

  if(self.caststotal >= maxcasts) {
    iscomplete = 1;
  } else if(self.scriptablecount >= maxents) {
    iscomplete = 1;
  } else if(istrue(var_af8745e2185687a8)) {
    var_3ce5d6eb962629fa = 1;

    foreach(branch in self.branches) {
      if(!branch molotov_branch_is_complete(1, 1)) {
        var_3ce5d6eb962629fa = 0;
        break;
      }
    }

    if(var_3ce5d6eb962629fa) {
      iscomplete = 1;
    }
  }

  if(iscomplete) {
    self.iscomplete = 1;
    molotov_store_branch_ents();
    self.branches = [];
  }

  return iscomplete;
}

function molotov_store_branch_ents() {
  shareddata = self;

  if(isDefined(self.shareddata)) {
    shareddata = self.shareddata;
  }

  if(!isDefined(shareddata.oldbranchents)) {
    shareddata.oldbranchents = [];
  }

  foreach(branch in self.branches) {
    foreach(ent in branch.ents) {
      if(isDefined(ent)) {
        shareddata.oldbranchents[shareddata.oldbranchents.size] = ent;
      }
    }
  }
}

function molotov_create_branch(shareddata, castdata, pooldata, parent, startingorigin, startingangles, startingstuckto, startingcasttype, preventstarttime, oncompletedfunc) {
  branch = spawnStruct();
  branch.shareddata = shareddata;
  branch.castdata = castdata;
  branch.pooldata = pooldata;
  branch.startingorigin = startingorigin;
  branch.startingangles = startingangles;
  branch.startingstuckto = startingstuckto;
  branch.startingcasttype = startingcasttype;
  branch.oncompletedfunc = oncompletedfunc;
  branch.ents = [];
  branch.branches = [];
  branch.hitpositions = [];
  branch.hittypes = [];
  branch.casts = 0;
  branch.castfails = 0;
  branch.preventstarttime = preventstarttime;
  return branch;
}

function molotov_start_branch(var_54c186a6b8a2ae1) {
  self endon("cleanup_branch");

  thread molotov_branch_draw_hits();

  if(!isDefined(self.preventstarttime)) {
    self.preventstarttime = gettime();
  }

  if(!isDefined(self.startingcasttype)) {
    if(!self.shareddata molotov_shared_data_is_complete()) {
      pool = molotov_branch_create_pool(self.startingorigin, self.startingangles, self.startingstuckto, var_54c186a6b8a2ae1);
      pool = pool thread molotov_pool_start();
      self.iscomplete = 1;
      self.shareddata molotov_shared_data_is_complete(1);

      self.hitpositions[self.hitpositions.size] = self.startingorigin;
      self.hittypes[self.hittypes.size] = 1;
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

  while(true) {
    if(self.shareddata molotov_shared_data_is_complete()) {
      break;
    }

    if(molotov_branch_is_complete(undefined, 1, var_54c186a6b8a2ae1)) {
      break;
    }

    if(!molotov_can_cast_this_frame(self.shareddata)) {
      waitframe();
      continue;
    }

    if(self.casttype == 0) {
      firstforwardmodanglesfunc = self.castdata.firstforwardmodanglesfunc;

      if(isDefined(firstforwardmodanglesfunc)) {
        self.castangles = [[firstforwardmodanglesfunc]](self.castangles);
        self.castdata.firstforwardmodanglesfunc = undefined;
        self.castdata.iswallcast = undefined;
      }
    }

    if(!isDefined(self.iswallcast)) {
      updot = vectordot(anglestoup(self.castangles), (0, 0, 1));
      self.iswallcast = updot > -0.81915 && updot <= 0.5;

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
    casthit = undefined;
    casthitpos = undefined;
    casthitnorm = undefined;
    casthitent = undefined;
    casthitangles = undefined;
    castresults = physics_raycast(self.caststart, self.castend, self.shareddata.castcontents, undefined, 1, "physicsquery_closest", 1);

    if(isDefined(castresults) && castresults.size > 0) {
      casthit = 1;
      casthitpos = castresults[0]["position"];
      casthitnorm = castresults[0]["normal"];
      casthitent = castresults[0]["entity"];
    }

    switch (self.casttype) {
      case 0:
        if(istrue(casthit)) {
          molotov_branch_register_cast(self.casttype, 0, casthitpos);
          shouldcreatepool = 1;

          if(isDefined(self.castdata.firstforwarddist)) {
            castvec = casthitpos - self.caststart;
            castdist = vectordot(castvec, self.castdir);
            self.castdata.firstforwarddist -= castdist;

            if(self.castdata.firstforwarddist > self.castdata.firstforwardmindist) {
              shouldcreatepool = 0;
            } else {
              self.castdata.firstforwarddist = undefined;
            }
          }

          casthitangles = molotov_rebuild_angles_up_right(casthitnorm, anglestoright(self.castangles));

          if(shouldcreatepool) {
            ent = molotov_branch_create_pool(casthitpos, casthitangles, casthitent, var_54c186a6b8a2ae1);
            ent thread molotov_pool_start();
          }

          self.casttype = 2;
          self.caststart = casthitpos + casthitnorm * 1;
          self.castangles = casthitangles;
          self.iswallcast = undefined;
        } else {
          molotov_branch_register_cast(self.casttype, undefined, undefined);

          if(isDefined(self.castdata.firstforwarddist)) {
            castvec = self.castend - self.caststart;
            castdist = vectordot(castvec, self.castdir);
            self.castdata.firstforwarddist -= castdist;

            if(self.castdata.firstforwarddist <= self.castdata.firstforwardmindist) {
              self.castdata.firstforwarddist = undefined;
            }
          }

          self.casttype = 1;
          self.caststart = self.castend;
        }

        break;
      case 1:
        if(istrue(casthit)) {
          casthitangles = molotov_rebuild_angles_up_right(casthitnorm, anglestoright(self.castangles));
          ent = molotov_branch_create_pool(casthitpos, casthitangles, casthitent, var_54c186a6b8a2ae1);
          ent thread molotov_pool_start();
          normdot = vectordot(anglestoup(self.castangles), casthitnorm);

          if(normdot < 0.9848) {
            molotov_branch_register_cast(self.casttype, 2, casthitpos);
            self.casttype = 2;
            self.caststart = casthitpos + casthitnorm * 1;
            self.castangles = casthitangles;
          } else {
            molotov_branch_register_cast(self.casttype, 1, casthitpos);
            self.casttype = 0;
          }
        } else {
          molotov_branch_register_cast(self.casttype, undefined, undefined);
          self.caststart = self.castend;
        }

        break;
      case 2:
        if(istrue(casthit)) {
          molotov_branch_register_cast(self.casttype, 3, casthitpos);
          self.casttype = 0;
          self.caststart = casthitpos + casthitnorm * 1;
        } else {
          molotov_branch_register_cast(self.casttype, undefined, undefined);
          self.casttype = 0;
        }

        break;
    }

    waittillframeend();
  }

  self.iscomplete = 1;
  self.shareddata molotov_shared_data_is_complete(1);
}

function molotov_branch_is_complete(var_af8745e2185687a8, var_f7d3f0b0605b5824, var_54c186a6b8a2ae1) {
  iscomplete = 0;
  var_3ce5d6eb962629fa = undefined;

  if(!istrue(var_f7d3f0b0605b5824)) {
    iscomplete = self.shareddata molotov_shared_data_is_complete();
  }

  if(!iscomplete) {
    if(isDefined(self.castdata) && isDefined(self.castdata.maxfails) && self.castfails >= self.castdata.maxfails) {
      iscomplete = 1;
    } else if(isDefined(self.castdata) && isDefined(self.castdata.maxcasts) && self.casts >= self.castdata.maxcasts) {
      iscomplete = 1;
    } else if(isDefined(self.castdata) && isDefined(self.castdata.maxents) && self.ents.size >= self.castdata.maxents) {
      iscomplete = 1;
    } else if(istrue(var_af8745e2185687a8) && self.branches.size > 0) {
      var_3ce5d6eb962629fa = 1;

      foreach(branch in self.branches) {
        if(!branch molotov_branch_is_complete(var_af8745e2185687a8, var_f7d3f0b0605b5824)) {
          var_3ce5d6eb962629fa = 0;
          break;
        }
      }

      if(var_3ce5d6eb962629fa) {
        iscomplete = 1;
      }
    }
  }

  if(iscomplete && !istrue(self.iscomplete)) {
    oncompletedfunc = self.oncompletedfunc;
    self.oncompletedfunc = undefined;

    if(isDefined(oncompletedfunc)) {
      self[[oncompletedfunc]](var_54c186a6b8a2ae1);
    }

    if(istrue(var_3ce5d6eb962629fa)) {
      iscomplete = 0;

      foreach(branch in self.branches) {
        if(!branch molotov_branch_is_complete(1, var_f7d3f0b0605b5824)) {
          var_3ce5d6eb962629fa = 0;
          break;
        }
      }

      if(var_3ce5d6eb962629fa) {
        iscomplete = 1;
      }
    }
  }

  if(iscomplete) {
    self.iscomplete = 1;
    molotov_store_branch_ents();
    self.branches = [];
  }

  return iscomplete;
}

function molotov_branch_register_cast(casttype, casthittype, hitposition) {
  molotov_register_cast(self.shareddata);
  self.casts++;

  if(isDefined(casthittype)) {
    if(casthittype == 0 || casthittype == 1 || casthittype == 2) {
      self.castfails = 0;
    }
  } else if(casttype == 1) {
    self.castfails++;
  }

  debugmsg = undefined;

  if(isDefined(casthittype)) {
    debugmsg = undefined;

    switch (casthittype) {
      case 0:
        debugmsg = "<dev string:x1d8>";
        break;
      case 1:
        debugmsg = "<dev string:x1e7>";
        break;
      case 2:
        debugmsg = "<dev string:x1f3>";
        break;
      case 3:
        debugmsg = "<dev string:x206>";
        break;
    }

    self.hitpositions[self.hitpositions.size] = hitposition;
    self.hittypes[self.hittypes.size] = casthittype;
  } else {
    switch (casttype) {
      case 0:
        debugmsg = "<dev string:x210>";
        break;
      case 1:
        debugmsg = "<dev string:x21b>";
        break;
      case 2:
        debugmsg = "<dev string:x228>";
        break;
    }
  }

  if(istrue(level.var_4482770c326f1498)) {
    if(isDefined(debugmsg)) {
      println(debugmsg);
    }
  }

}

function molotov_create_pool(origin, angles, stuckto, owner, burnsource, burnid, starttime, pooldata, poolmask, id, var_54c186a6b8a2ae1) {
  scriptablename = default_to(var_54c186a6b8a2ae1, "equip_molotov_pool_mp_p");

  if(isDefined(burnsource.weapon_name) && burnsource.weapon_name == "gas_can_mp") {
    scriptablename = "equip_propane_tank_pool_br";
  }

  var_ac27801892c6c401 = ter_op(isDefined(burnsource.blueprintdefindex), [#"genericblueprint", burnsource.blueprintdefindex], undefined);
  scriptable = spawnscriptable(scriptablename, origin, angles, undefined, var_ac27801892c6c401);
  scriptable.stuckto = stuckto;
  scriptable.owner = owner;
  scriptable.burnsource = burnsource;
  scriptable.burnid = burnid;
  scriptable.starttime = starttime;
  scriptable.pooldata = pooldata;
  scriptable.poolmask = poolmask;
  scriptable.id = id;

  if(isDefined(stuckto) && isent(stuckto)) {
    offset = rotatevectorinverted(origin - stuckto.origin, stuckto.angles);
    angleoffset = combineangles(invertangles(stuckto.angles), angles);
    scriptable utility::scriptable_setparententity(stuckto, offset, angleoffset);
  }

  scriptable thread molotov_watch_cleanup_pool();
  return scriptable;
}

function molotov_branch_create_pool(origin, angles, stuckto, var_54c186a6b8a2ae1) {
  poolmask = self.pooldata.typeid;
  up = anglestoup(angles);
  dot = vectordot(up, (0, 0, 1));

  if(dot <= -0.81915) {
    poolmask |= 128;
  } else if(dot <= 0.5) {
    poolmask |= 64;
  } else {
    poolmask |= 32;
  }

  starttime = self.preventstarttime + self.pooldata.startdelayms;
  scriptable = molotov_create_pool(origin, angles, stuckto, self.shareddata.owner, self.shareddata.burnsource, self.shareddata.burnid, starttime, self.pooldata, poolmask, undefined, var_54c186a6b8a2ae1);
  self.preventstarttime = starttime;
  self.ents[self.ents.size] = scriptable;
  scriptable.id = molotov_get_unique_pool_id();
  scriptable molotov_register_scriptable(self.shareddata);
  return scriptable;
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

  if(isDefined(self.burnsource.var_e569b726ededed94)) {
    var_53c09eb3450b400e = default_to(self.burnsource.var_e569b726ededed94.var_2d8b92ed79acc178, 6.5);
    var_539d90b344e4d98c = default_to(self.burnsource.var_e569b726ededed94.flamemaxduration, 6.75);
    burnloopduration = randomfloatrange(var_53c09eb3450b400e, var_539d90b344e4d98c);
  } else {
    burnloopduration = randomfloatrange(6.5, 6.75);
  }

  wait burnloopduration;
}

function molotov_pool_end(immediate) {
  self endon("death");

  if(istrue(self.ended)) {
    return;
  }

  self notify("molotov_pool_end");
  self.ended = 1;
  self.poolmask &= ~1;
  self.poolmask |= 2;
  molotov_pool_update_scriptable();

  if(!istrue(immediate)) {
    wait 1;
  }

  if(isDefined(self.trigger)) {
    self.trigger thread molotov_delete_trigger();
  }

  if(!istrue(immediate)) {
    wait 3.5;
  }

  thread molotov_delete_scriptable();
}

function molotov_watch_cleanup_pool() {
  self endon("death");
  molotov_watch_cleanup_pool_internal();
  thread molotov_delete_scriptable();
}

function molotov_watch_cleanup_pool_internal() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self.stuckto)) {
    self.stuckto endon("death");
  }

  self waittill("forever");
}

function molotov_create_pool_trigger(triggerradius, triggerheight, triggeroffset) {
  origin = self.origin - anglestoup(self.angles) * triggeroffset;
  trigger = spawn("trigger_rotatable_radius", origin, 0, triggerradius, triggerheight);
  trigger.angles = self.angles;
  trigger.id = self.id;

  if(isDefined(self.stuckto) && isent(self.stuckto) && (!isai(self.stuckto) || isalive(self.stuckto))) {
    trigger enablelinkTo();
    trigger linkTo(self.stuckto);
  }

  trigger hide();
  struct = spawnStruct();
  struct.trigger = trigger;
  struct.attacker = self.owner;
  struct.inflictor = self.burnsource;
  struct.killcament = self.burnsource;
  struct.burnid = self.burnid;
  struct.stuckto = self.stuckto;
  struct.playersintrigger = [];
  trigger.struct = struct;
  struct thread molotov_watch_pool_trigger_enter();
  struct thread molotov_watch_pool_trigger_exit();
  struct thread molotov_cleanup_pool_trigger();
  trigger molotov_register_trigger();
  return trigger;
}

function molotov_watch_pool_trigger_enter() {
  if(isDefined(self.inflictor)) {
    self.inflictor endon("death");
  }

  level endon("game_ended");
  self.trigger endon("death");
  self.attacker endon("disconnect");
  self.attacker endon("joined_team");

  while(true) {
    self.trigger waittill("trigger", player);

    if(!isPlayer(player) && !isagent(player)) {
      continue;
    }

    if(!isreallyalive(player)) {
      continue;
    }

    playerowner = ter_op(isDefined(player.owner), player.owner, player);

    if(playerowner != self.attacker && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(playerowner, self.attacker)) && !istrue(self.inflictor.var_88fe704adf00eadf)) {
      continue;
    }

    entnum = player getentitynumber();

    if(isDefined(self.playersintrigger[entnum])) {
      continue;
    }

    self.playersintrigger[entnum] = player;
    player molotov_start_burning(self.attacker, self.inflictor, self.killcament, self.burnid);
  }
}

function molotov_watch_pool_trigger_exit() {
  level endon("game_ended");
  self.trigger endon("death");

  while(true) {
    foreach(id, player in self.playersintrigger) {
      if(!isDefined(player)) {
        continue;
      }

      if(!isreallyalive(player)) {
        continue;
      }

      if(player istouching(self.trigger)) {
        continue;
      }

      self.playersintrigger[id] = undefined;
      player molotov_stop_burning(self.burnid);
    }

    waitframe();
  }
}

function molotov_cleanup_pool_trigger() {
  level endon("game_ended");
  molotov_cleanup_pool_trigger_end_early();

  foreach(player in self.playersintrigger) {
    if(isDefined(player)) {
      player molotov_stop_burning(self.burnid);
    }
  }

  if(isDefined(self.trigger)) {
    self.trigger thread molotov_delete_trigger();
  }
}

function molotov_cleanup_pool_trigger_end_early() {
  self.trigger endon("death");
  self.attacker endon("disconnect");
  self.attacker endon("joined_team");

  if(isDefined(self.stuckto)) {
    self.stuckto endon("death");
  }

  while(true) {
    waitframe();
  }
}

function molotov_pool_update_scriptable() {
  var_dcf9401f976e906f = molotov_get_pool_level_data();
  state = var_dcf9401f976e906f.scriptablestates[self.poolmask];
  self setscriptablepartstate("effects", state, 0);
}

function molotov_branch_create_sub_branch(id, starttime, firstforwarddist, firstforwardmindist, firstforwardmodanglesfunc, firstforwarddistwall, maxcasts, maxents, startbranch, var_54c186a6b8a2ae1) {
  shareddata = self.shareddata;
  castdata = molotov_get_cast_data(id);
  pooldata = molotov_get_pool_data(id);

  if(isDefined(self.castdata)) {
    if(self.castfails > self.castdata.maxfails) {
      return;
    }

    if(self.castfails > castdata.maxfails) {
      return;
    }
  }

  if(isDefined(firstforwarddist)) {
    castdata.firstforwarddist = firstforwarddist;
  }

  if(isDefined(firstforwardmindist)) {
    castdata.firstforwardmindist = firstforwardmindist;
  }

  if(isDefined(firstforwardmodanglesfunc)) {
    castdata.firstforwardmodanglesfunc = firstforwardmodanglesfunc;
  }

  if(isDefined(firstforwarddistwall)) {
    castdata.firstforwarddistwall = firstforwarddistwall;
  }

  if(isDefined(maxcasts)) {
    castdata.maxcasts = maxcasts;
  }

  if(isDefined(maxents)) {
    castdata.maxents = maxents;
  }

  branch = molotov_create_branch(shareddata, castdata, pooldata, self, self.caststart, self.castangles, undefined, self.casttype, self.preventstarttime);
  branch.castfails = self.castfails;
  self.branches[self.branches.size] = branch;
  shareddata.branches[shareddata.branches.size] = branch;

  if(istrue(startbranch)) {
    branch thread molotov_start_branch(var_54c186a6b8a2ae1);
  }

  return branch;
}

function molotov_branch_create_forward_tendril_cone(var_54c186a6b8a2ae1) {
  branch = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, undefined, 44, undefined, undefined, 1, var_54c186a6b8a2ae1);
}

function molotov_branch_create_left_tendril_cone(var_54c186a6b8a2ae1) {
  branch = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, &molotov_left_tendril_mod_angles, 44, undefined, undefined, 1, var_54c186a6b8a2ae1);
}

function molotov_branch_create_right_tendril_cone(var_54c186a6b8a2ae1) {
  branch = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, &molotov_right_tendril_mod_angles, 44, undefined, undefined, 1, var_54c186a6b8a2ae1);
}

function molotov_branch_create_tendril_radial(var_54c186a6b8a2ae1) {
  branch = molotov_branch_create_sub_branch(16, self.preventstarttime, 35, 8, &molotov_tendril_mod_angles_radial, 44, 6, 1, 1, var_54c186a6b8a2ae1);
}

function molotov_rotate_angles_about_up(angles, amount) {
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  right = undefined;
  forward = rotatepointaroundvector(up, forward, amount);
  right = vectorNormalize(vectorcross(forward, up));
  up = vectorcross(right, forward);
  return axistoangles(forward, right, up);
}

function molotov_left_tendril_mod_angles(angles) {
  amount = randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(angles, amount);
}

function molotov_right_tendril_mod_angles(angles) {
  amount = -1 * randomfloatrange(50, 75);
  return molotov_rotate_angles_about_up(angles, amount);
}

function molotov_tendril_mod_angles_radial(angles) {
  amount = randomfloatrange(-60, 60);
  return molotov_rotate_angles_about_up(angles, amount);
}

function molotov_cleanup_burn_source() {
  self endon("death");
  wait 20;
  self delete();
}

function molotov_cleanup_grenade(grenade) {
  grenade endon("death");
  waittill_any_2("disconnect", "joined_team");
  grenade delete();
}

function molotov_get_level_data() {
  assertex(isDefined(level.molotov), "<dev string:x22e>");
  return level.molotov;
}

function molotov_get_pool_level_data() {
  leveldata = molotov_get_level_data();
  var_dcf9401f976e906f = leveldata.pooldata;
  assertex(isDefined(var_dcf9401f976e906f), "<dev string:x268>");
  return var_dcf9401f976e906f;
}

function molotov_get_cast_level_data() {
  leveldata = molotov_get_level_data();
  var_ab59026cfe871548 = leveldata.castdata;
  assertex(isDefined(var_ab59026cfe871548), "<dev string:x2b1>");
  return var_ab59026cfe871548;
}

function molotov_get_unique_pool_id() {
  leveldata = molotov_get_level_data();
  uniquepoolid = leveldata.uniquepoolid;
  leveldata.uniquepoolid++;
  leveldata.poolids = array_add(leveldata.poolids, uniquepoolid);
  return uniquepoolid;
}

function molotov_get_cast_data(castid) {
  var_ab59026cfe871548 = molotov_get_cast_level_data();
  castdata = spawnStruct();
  castdata.distforward = var_ab59026cfe871548.distforward[castid];
  castdata.distdown = var_ab59026cfe871548.distdown[castid];
  castdata.distup = var_ab59026cfe871548.distup[castid];
  castdata.maxcasts = var_ab59026cfe871548.maxcasts[castid];
  castdata.maxfails = var_ab59026cfe871548.maxfails[castid];
  castdata.maxents = var_ab59026cfe871548.maxents[castid];
  castdata.distforwardwall = var_ab59026cfe871548.distforwardwall[castid];

  if(isDefined(var_ab59026cfe871548.firstforwarddist[castid])) {
    castdata.firstforwarddist = var_ab59026cfe871548.firstforwarddist[castid];
    castdata.firstforwardmindist = var_ab59026cfe871548.firstforwardmindist[castid];
    castdata.firstforwardmodanglesfunc = var_ab59026cfe871548.firstforwardmodanglesfunc[castid];

    if(isDefined(var_ab59026cfe871548.firstforwarddistwall[castid])) {
      castdata.firstforwarddistwall = var_ab59026cfe871548.firstforwarddistwall[castid];
    }
  }

  return castdata;
}

function molotov_get_pool_data(typeid) {
  var_dcf9401f976e906f = molotov_get_pool_level_data();
  pooldata = spawnStruct();
  pooldata.typeid = typeid;
  pooldata.triggerradius = var_dcf9401f976e906f.triggerradius[typeid];
  pooldata.triggerheight = var_dcf9401f976e906f.triggerheight[typeid];
  pooldata.triggeroffset = var_dcf9401f976e906f.triggeroffset[typeid];
  pooldata.startdelayms = var_dcf9401f976e906f.startdelayms[typeid];
  return pooldata;
}

function molotov_get_cast_dir(angles, casttype) {
  switch (casttype) {
    case 0:
      return anglesToForward(angles);
    case 1:
      return (-1 * anglestoup(angles));
    case 2:
      return anglestoup(angles);
  }

  return undefined;
}

function molotov_get_cast_dist(casttype, castdata, iswallcast) {
  switch (casttype) {
    case 0:
      if(isDefined(castdata.firstforwarddist)) {
        return castdata.firstforwarddist;
      } else if(iswallcast && isDefined(castdata.distforwardwall)) {
        return castdata.distforwardwall;
      } else {
        return castdata.distforward;
      }
    case 1:
      return castdata.distdown;
    case 2:
      return castdata.distup;
  }

  return undefined;
}

function molotov_get_cast_contents() {
  return physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
}

function molotov_rebuild_angles_up_right(up, right) {
  forward = vectorNormalize(vectorcross(up, right));
  right = vectorcross(forward, up);
  return axistoangles(forward, right, up);
}

function molotov_rebuild_angles_up_forward(up, forward) {
  right = vectorNormalize(vectorcross(forward, up));
  forward = vectorcross(up, right);
  return axistoangles(forward, right, up);
}

function function_d89c621ce916f11e() {
  outbundle = undefined;

  if(!isDefined(level)) {
    return outbundle;
  }

  if(!isDefined(level.molotov)) {
    return outbundle;
  }

  if(!isDefined(level.molotov.bundledata)) {
    bundledata = scripts\mp\equipment::getequipmentbundlefromweaponname("molotov_mp");

    if(!isDefined(bundledata)) {
      bundledata = level.equipment.table["equip_molotov"].bundle;
    }

    level.molotov.bundledata = bundledata;
  }

  outbundle = level.molotov.bundledata;
  return outbundle;
}

function molotov_start_burning(attacker, inflictor, killcament, id) {
  if(self isswimunderwater()) {
    return;
  }

  if(scripts\common\utility::function_ec40425fb125f6cf("molotov", attacker.team)) {
    return;
  }

  if(!isDefined(id)) {
    assertmsg(isDefined(attacker), "<dev string:x2fa>");
  }

  info = molotov_get_burning_info(1);

  if(!isDefined(id)) {
    id = molotov_get_next_burning_id();
  }

  source = molotov_get_burning_source(attacker, inflictor, killcament, info, id, 1);
  var_baf9609a24c2d400 = isDefined(inflictor.var_e569b726ededed94) && (isPlayer(self) || istrue(inflictor.var_e569b726ededed94.var_e2d8f199fd43170d) && isagent(self));

  if(var_baf9609a24c2d400) {
    source.bundle = inflictor.var_e569b726ededed94;
  }

  codcastersetplayerstatuseffect("fire", -1);
  updateburning = 0;

  if(source.count <= 0) {
    updateburning = 1;
  }

  source.count++;

  if(updateburning) {
    thread molotov_update_burning(source);
  }
}

function molotov_stop_burning(id) {
  info = molotov_get_burning_info();

  if(!isDefined(info)) {
    return;
  }

  source = molotov_get_burning_source(undefined, undefined, undefined, info, id, 0);

  if(isDefined(source)) {
    if(source.count > 0) {
      updateburning = 0;

      if(source.count == 1) {
        updateburning = 1;
      }

      source.count--;

      if(updateburning) {
        thread molotov_update_burning(source);
      }
    }
  }
}

function molotov_burn_for_time(time, attacker, inflictor, killcament) {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  id = molotov_get_next_burning_id();
  molotov_start_burning(attacker, inflictor, killcament, id);
  wait time;
  molotov_stop_burning(id);
}

function molotov_clear_burning(immediate) {
  self notify("clear_burning");

  if(isDefined(self.burninginfo) && isDefined(self.burninginfo.sources)) {
    foreach(source in self.burninginfo.sources) {
      self.burninginfo.sources[source.id] = undefined;
    }
  }

  codcastersetplayerstatuseffect("fire", 0);
  self.burninginfo = undefined;
}

function molotov_update_burning(burningsource) {
  self endon("death_or_disconnect");
  self endon("clear_burning");
  level endon("game_ended");
  self notify("update_burning");
  self endon("update_burning");
  thread molotov_cleanup_burning();
  info = molotov_get_burning_info();

  if(gettime() <= info.updatetimestamp) {
    waitframe();
  }

  while(true) {
    info = molotov_get_burning_info();
    var_1cc80627b9bdb202 = undefined;

    if(self isswimunderwater()) {
      thread molotov_clear_burning();
    }

    foreach(source in info.sources) {
      if(source molotov_burning_source_is_valid()) {
        if(!isDefined(var_1cc80627b9bdb202) || source.id > var_1cc80627b9bdb202) {
          var_1cc80627b9bdb202 = source.id;
        }

        continue;
      }

      info.sources[source.id] = undefined;
    }

    if(isDefined(var_1cc80627b9bdb202)) {
      info.timeoff = 0;
      info.timeon += 0.05;
      source = info.sources[var_1cc80627b9bdb202];

      if(isDefined(burningsource) && isDefined(burningsource.bundle)) {
        burnbundle = burningsource.bundle;
      } else {
        burnbundle = function_d89c621ce916f11e();
      }

      stage3time = default_to(burnbundle.var_1b01e583ecc2fb9a, 1.5);
      stage2time = default_to(burnbundle.var_9369d29bfd0aec71, 0.5);
      damage = default_to(burnbundle.var_e0cf068ccab49e34, 15);

      if(info.timeon > stage3time) {
        damage = default_to(burnbundle.var_81c84c326caec1d2, 30);
      } else if(info.timeon > stage2time) {
        damage = default_to(burnbundle.var_74fbf35a2265fa59, 25);
      }

      damageweapon = default_to(burnbundle.useweapon, "molotov_mp");
      inflictor = undefined;
      damageorigin = source.attacker.origin;

      if(isDefined(source.inflictor)) {
        inflictor = source.inflictor;
        damageorigin = source.inflictor.origin;
      }

      meansofdeath = default_to(burnbundle.means_of_death, "MOD_EXPLOSIVE");

      if(istrue(burnbundle.var_ff298245b12a34fa) && damage >= self.health) {
        function_f632348cbb773537(level.molotovdamagethrottle, self);
      }

      if(info.timetodamage <= 0) {
        self.var_604d21c5b1326910 = gettime();
        self dodamage(damage, damageorigin, source.attacker, inflictor, meansofdeath, damageweapon, "none", undefined, 65536);
        info.firstdamagedone = 1;
        info.timetodamage = default_to(burnbundle.var_439885d26a2f9bf5, 0.25);
      } else {
        if(!istrue(info.firstdamagedone)) {
          self.var_604d21c5b1326910 = gettime();
          self dodamage(damage, damageorigin, source.attacker, inflictor, meansofdeath, damageweapon, "none", undefined, 65536);
          info.firstdamagedone = 1;
        }

        info.timetodamage -= 0.05;
      }
    } else {
      info.timeoff += 0.05;

      if(info.timeoff >= 0.25) {
        thread molotov_clear_burning();
      }
    }

    info.updatetimestamp = gettime();
    wait 0.05;
  }
}

function molotov_is_burning() {
  info = molotov_get_burning_info();
  return isDefined(info) && info.sources.size > 0;
}

function molotov_get_burning_info(create) {
  info = self.burninginfo;

  if(!isDefined(info) && istrue(create)) {
    info = spawnStruct();
    info.timeon = 0;
    info.timeoff = 0;
    info.timetodamage = 0.25;
    info.updatetimestamp = 0;
    info.victim = self;
    info.sources = [];
    info.firstdamagedone = 0;
    self.burninginfo = info;
  }

  return info;
}

function molotov_get_burning_source(attacker, inflictor, killcament, info, id, shouldcreate) {
  source = info.sources[id];

  if(!isDefined(source)) {
    if(istrue(shouldcreate)) {
      source = spawnStruct();
      source.attacker = attacker;
      source.inflictor = inflictor;
      source.hasinflictor = isDefined(inflictor);
      source.killcament = killcament;
      source.info = info;
      source.id = id;
      source.count = 0;
      info.sources[id] = source;
    }
  }

  return source;
}

function molotov_burning_source_is_valid() {
  if(!isDefined(self.attacker)) {
    return false;
  }

  if(!isDefined(self.info.victim)) {
    return false;
  }

  if(!isreallyalive(self.info.victim)) {
    return false;
  }

  if(self.attacker != self.info.victim && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.attacker, self.info.victim)) && isDefined(self.inflictor) && !istrue(self.inflictor.var_88fe704adf00eadf)) {
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
  leveldata = molotov_get_level_data();

  if(!isDefined(leveldata.burningid)) {
    leveldata.burningid = 0;
  }

  id = leveldata.burningid;
  leveldata.burningid++;
  return id;
}

function molotov_cleanup_burning() {
  self notify("cleanup_burning");
  self endon("cleanup_burning");
  childthread molotov_cleanup_burning_on_death();
  childthread molotov_cleanup_burning_on_game_end();
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

function molotov_on_player_damaged(data) {
  if(data.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  data.victim.var_aaa78716e99a2760 = 0;

  if(isDefined(data.inflictor) && is_equal(data.inflictor.weapon_name, "molotov_mp")) {
    data.victim.var_aaa78716e99a2760 = 1;
  }

  data.victim thread scripts\mp\weapons::enableburnfxfortime(0.5);
  return true;
}

function molotov_watch_fx() {
  self notify("molotov_clear_fx");
  self endon("molotov_clear_fx");
  self endon("death_or_disconnect");
  var_8e784b7cb7322eb = 0;

  while(true) {
    var_b818f06c051b78f0 = 0;
    objweapon = self getheldoffhand();

    if(!isnullweapon(objweapon) && objweapon.basename == "molotov_mp") {
      var_b818f06c051b78f0 = 1;
    }

    if(var_b818f06c051b78f0 && !var_8e784b7cb7322eb) {
      thread molotov_begin_fx();
    } else if(var_8e784b7cb7322eb && !var_b818f06c051b78f0) {
      thread molotov_end_fx();
    }

    var_8e784b7cb7322eb = var_b818f06c051b78f0;
    waitframe();
  }
}

function molotov_begin_fx() {
  self endon("death_or_disconnect");
  self endon("molotov_end_fx");
  self.playingmolotovwickfx = 1;
  self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
  self setscriptablepartstate("equipMtovFXView", "active", 0);
  waittime = 0.4;
  wait waittime;
  self setscriptablepartstate("equipMtovFXWorld", "active", 0);
  self waittill("offhand_fired");
  waitframe();
  thread molotov_end_fx();
}

function molotov_end_fx() {
  self notify("molotov_end_fx");

  if(istrue(self.playingmolotovwickfx)) {
    self setscriptablepartstate("equipMtovFXWorld", "neutral", 0);
    self setscriptablepartstate("equipMtovFXView", "neutral", 0);
  }

  self.playingmolotovwickfx = undefined;
}

function molotov_clear_fx() {
  self notify("molotov_clear_fx");
  thread molotov_end_fx();
}

function molotov_cleanup_branch(branch, immediate) {
  branch notify("cleanup_branch");

  if(isDefined(branch.ents)) {
    foreach(scriptable in branch.ents) {
      if(isDefined(scriptable)) {
        scriptable thread molotov_pool_end(immediate);
      }
    }
  }
}

function molotov_cleanup_pool(grenade, immediate) {
  if(isDefined(grenade.shareddata)) {
    if(isDefined(grenade.shareddata.branches)) {
      foreach(branch in grenade.shareddata.branches) {
        molotov_cleanup_branch(branch, immediate);
      }
    }

    if(isDefined(grenade.shareddata.oldbranchents)) {
      foreach(scriptable in grenade.shareddata.oldbranchents) {
        if(isDefined(scriptable)) {
          scriptable thread molotov_pool_end(immediate);
        }
      }
    }
  }
}

function function_946f8ebb6c6efd92() {
  self.shareddata.burnsource delete();
  molotov_cleanup_pool(self, 0);
}

function function_49197cd063a740ea(callbackfunction) {
  self.elevatordoorsclosecallback = callbackfunction;
}

function molotov_branch_draw_hits() {
  while(true) {
    if(istrue(self.shareddata.iscomplete)) {
      break;
    }

    if(istrue(self.iscomplete)) {
      break;
    }

    if(istrue(level.dbgmolodrawhits)) {
      ids = getarraykeys(self.hitpositions);

      foreach(id in ids) {
        hitposition = self.hitpositions[id];
        hittype = self.hittypes[id];
        function_5ac76a3e234f3e1a(hitposition, hittype, 0.05);
      }
    }

    wait 0.05;
  }

  if(istrue(level.dbgmolodrawhits)) {
    ids = getarraykeys(self.hitpositions);

    foreach(id in ids) {
      hitposition = self.hitpositions[id];
      hittype = self.hittypes[id];
      function_5ac76a3e234f3e1a(hitposition, hittype, 5);
    }
  }
}

function function_5ac76a3e234f3e1a(hitposition, hittype, duration) {
  color = undefined;

  switch (hittype) {
    case 0:
      color = (1, 1, 0);
      break;
    case 2:
      color = (1, 0, 0);
      break;
    case 3:
      color = (0, 0, 1);
      break;
    default:
      color = (1, 1, 1);
      break;
  }

  thread scripts\mp\utility\debug::drawsphere(hitposition, 2, duration, color);
}

# /