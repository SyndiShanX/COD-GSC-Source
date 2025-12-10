/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_apothicon_fury.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\archetype_apothicon_fury_interface;
#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_blackboard;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_selector_table;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;

class animationadjustmentinfoz {
  var adjustmentstarted;
  var readjustmentstarted;

  constructor() {
    adjustmentstarted = 0;
    readjustmentstarted = 0;
  }

  destructor() {}

}

class animationadjustmentinfoxy {
  var adjustmentstarted;

  constructor() {
    adjustmentstarted = 0;
  }

  destructor() {}

}

class jukeinfo {
  constructor() {}

  destructor() {}

}

#namespace apothiconfurybehavior;

function autoexec init() {
  initapothiconfurybehaviorsandasm();
  apothiconfuryinterface::registerapothiconfuryinterfaceattributes();
  spawner::add_archetype_spawn_function("apothicon_fury", &apothiconfuryblackboardinit);
  spawner::add_archetype_spawn_function("apothicon_fury", &zombie_utility::zombiespawnsetup);
  spawner::add_archetype_spawn_function("apothicon_fury", &apothiconfuryspawnsetup);
  if(ai::shouldregisterclientfieldforarchetype("apothicon_fury")) {
    clientfield::register("actor", "fury_fire_damage", 15000, getminbitcountfornum(7), "counter");
    clientfield::register("actor", "furious_level", 15000, 1, "int");
    clientfield::register("actor", "bamf_land", 15000, 1, "counter");
    clientfield::register("actor", "apothicon_fury_death", 15000, 2, "int");
    clientfield::register("actor", "juke_active", 15000, 1, "int");
  }
}

function private initapothiconfurybehaviorsandasm() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconCanJuke", &apothiconcanjuke);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconJukeInit", &apothiconjukeinit);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconPreemptiveJukeService", &apothiconpreemptivejukeservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconPreemptiveJukePending", &apothiconpreemptivejukepending);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconPreemptiveJukeDone", &apothiconpreemptivejukedone);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconMoveStart", &apothiconmovestart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconMoveUpdate", &apothiconmoveupdate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconCanMeleeAttack", &apothiconcanmeleeattack);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconShouldMeleeCondition", &apothiconshouldmeleecondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconCanBamf", &apothiconcanbamf);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconCanBamfAfterJuke", &apothiconcanbamfafterjuke);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconBamfInit", &apothiconbamfinit);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconShouldTauntAtPlayer", &apothiconshouldtauntatplayer);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconTauntAtPlayerEvent", &apothicontauntatplayerevent);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconFuriousModeInit", &apothiconfuriousmodeinit);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconKnockdownService", &apothiconknockdownservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconDeathStart", &apothicondeathstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconDeathTerminate", &apothicondeathterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_teleport@apothicon_fury", &mocompapothiconfuryteleportinit, undefined, &mocompapothiconfuryteleportterminate);
  animationstatenetwork::registeranimationmocomp("mocomp_juke@apothicon_fury", &mocompapothiconfuryjukeinit, &mocompapothiconfuryjukeupdate, &mocompapothiconfuryjuketerminate);
  animationstatenetwork::registeranimationmocomp("mocomp_bamf@apothicon_fury", &mocompapothiconfurybamfinit, &mocompapothiconfurybamfupdate, &mocompapothiconfurybamfterminate);
  animationstatenetwork::registernotetrackhandlerfunction("start_effect", &apothiconbamfout);
  animationstatenetwork::registernotetrackhandlerfunction("end_effect", &apothiconbamfin);
  animationstatenetwork::registernotetrackhandlerfunction("bamf_land", &apothiconbamfland);
  animationstatenetwork::registernotetrackhandlerfunction("start_dissolve", &apothicondeathdissolve);
  animationstatenetwork::registernotetrackhandlerfunction("dissolved", &apothicondeathdissolved);
}

function private apothiconfuryblackboardinit() {
  blackboard::createblackboardforentity(self);
  blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_apothicon_bamf_distance", undefined, &getbamfmeleedistance);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_idgun_damage_direction", "back", &bb_idgungetdamagedirection);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_variant_type", 0, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  self aiutility::registerutilityblackboardattributes();
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &apothiconfuryonanimscriptedcallback;
  self finalizetrackedblackboardattributes();
}

function private apothiconfuryspawnsetup() {
  self.entityradius = 30;
  self.jukemaxdistance = 1500;
  self.updatesight = 0;
  self allowpitchangle(1);
  self setpitchorient();
  self pushactors(1);
  self.skipautoragdoll = 1;
  aiutility::addaioverridedamagecallback(self, &apothicondamagecallback);
  aiutility::addaioverridekilledcallback(self, &apothiconondeath);
  self.zigzag_distance_min = 300;
  self.zigzag_distance_max = 700;
  self.isfurious = 0;
  self.furiouslevel = 0;
  self.nextbamfmeleetime = gettime();
  self.nextjuketime = gettime();
  self.nextpreemptivejukeads = randomfloatrange(0.7, 0.95);
  blackboard::setblackboardattribute(self, "_variant_type", randomintrange(0, 3));
}

function private apothiconfuryonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity apothiconfuryblackboardinit();
}

function apothicondeathdissolve(entity) {
  if(entity.archetype != "apothicon_fury") {
    return;
  }
  a_zombies = getaiarchetypearray("zombie");
  a_filtered_zombies = array::filter(a_zombies, 0, &apothiconzombieeligibleforknockdown, entity, entity.origin);
  if(a_filtered_zombies.size > 0) {
    foreach(zombie in a_filtered_zombies) {
      apothiconknockdownzombie(entity, zombie);
    }
  }
}

function apothicondeathdissolved(entity) {}

function private mocompapothiconfuryteleportinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity orientmode("face angle", entity.angles[1]);
  entity setrepairpaths(0);
  locomotionspeed = blackboard::getblackboardattribute(entity, "_locomotion_speed");
  if(locomotionspeed == "locomotion_speed_walk") {
    rate = 1.6;
  } else {
    rate = 2;
  }
  entity asmsetanimationrate(rate);
  assert(isDefined(entity.traverseendnode));
  entity animmode("noclip", 0);
  entity notsolid();
  entity.blockingpain = 1;
  entity.usegoalanimweight = 1;
  entity.bgbignorefearinheadlights = 1;
}

function private mocompapothiconfuryteleportterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(!isDefined(entity.traverseendnode)) {
    return;
  }
  entity forceteleport(entity.traverseendnode.origin, entity.angles);
  entity asmsetanimationrate(1);
  entity show();
  entity solid();
  entity.blockingpain = 0;
  entity.usegoalanimweight = 0;
  entity.bgbignorefearinheadlights = 0;
}

function mocompapothiconfuryjukeinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.isjuking = 1;
  if(isDefined(entity.jukeinfo)) {
    entity orientmode("face angle", entity.jukeinfo.jukestartangles);
  } else {
    entity orientmode("face angle", entity.angles[1]);
  }
  entity animmode("noclip", 1);
  entity.usegoalanimweight = 1;
  entity.blockingpain = 1;
  entity pushactors(0);
  entity.pushable = 0;
  movedeltavector = getmovedelta(mocompanim, 0, 1, entity);
  landpos = entity localtoworldcoords(movedeltavector);
  velocity = entity getvelocity();
  predictedpos = entity.origin + (velocity * 0.1);
  recordcircle(landpos, 8, (0, 0, 1), "", entity);
  record3dtext("" + distance(predictedpos, landpos), landpos, (0, 0, 1), "");
  landposonground = entity.jukeinfo.landposonground;
  heightdiff = landposonground[2] - landpos[2];
  recordcircle(landposonground, 8, (0, 1, 0), "", entity);
  recordline(landpos, landposonground, (0, 1, 0), "", entity);
  assert(animhasnotetrack(mocompanim, ""));
  starttime = getnotetracktimes(mocompanim, "start_effect")[0];
  vectortostarttime = getmovedelta(mocompanim, 0, starttime, entity);
  startpos = entity localtoworldcoords(vectortostarttime);
  assert(animhasnotetrack(mocompanim, ""));
  stoptime = getnotetracktimes(mocompanim, "end_effect")[0];
  vectortostoptime = getmovedelta(mocompanim, 0, stoptime, entity);
  stoppos = entity localtoworldcoords(vectortostoptime);
  recordsphere(startpos, 3, (0, 0, 1), "", entity);
  recordsphere(stoppos, 3, (0, 0, 1), "", entity);
  recordline(predictedpos, startpos, (0, 0, 1), "", entity);
  recordline(startpos, stoppos, (0, 0, 1), "", entity);
  recordline(stoppos, landpos, (0, 0, 1), "", entity);
  newstoppos = stoppos + (0, 0, heightdiff);
  recordline(startpos, newstoppos, (1, 1, 0), "", entity);
  recordline(newstoppos, landposonground, (1, 1, 0), "", entity);
  recordsphere(newstoppos, 3, (1, 1, 0), "", entity);
  entity.animationadjustmentinfoz = undefined;
  entity.animationadjustmentinfoz = new animationadjustmentinfoz();
  entity.animationadjustmentinfoz.starttime = starttime;
  entity.animationadjustmentinfoz.stoptime = stoptime;
  entity.animationadjustmentinfoz.enemy = entity.enemy;
  animlength = getanimlength(mocompanim) * 1000;
  starttime = starttime * animlength;
  stoptime = stoptime * animlength;
  starttime = floor(starttime / 50);
  stoptime = floor(stoptime / 50);
  adjustduration = stoptime - starttime;
  entity.animationadjustmentinfoz.stepsize = heightdiff / adjustduration;
  entity.animationadjustmentinfoz.landposonground = landposonground;
  if(heightdiff < 0) {
    record3dtext((((("" + distance(landpos, landposonground)) + "") + entity.animationadjustmentinfoz.stepsize) + "") + adjustduration, landposonground, (1, 0.5, 0), "");
  } else {
    record3dtext((((("" + distance(landpos, landposonground)) + "") + entity.animationadjustmentinfoz.stepsize) + "") + adjustduration, landposonground, (1, 0.5, 0), "");
  }
}

function mocompapothiconfuryjukeupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  times = getnotetracktimes(mocompanim, "end_effect");
  if(times.size) {
    time = times[0];
  }
  animtime = entity getanimtime(mocompanim);
  if(!entity.animationadjustmentinfoz.adjustmentstarted) {
    if(animtime >= entity.animationadjustmentinfoz.starttime) {
      entity.animationadjustmentinfoz.adjustmentstarted = 1;
    }
  }
  if(entity.animationadjustmentinfoz.adjustmentstarted && animtime < entity.animationadjustmentinfoz.stoptime) {
    adjustedorigin = entity.origin + (0, 0, entity.animationadjustmentinfoz.stepsize);
    entity forceteleport(adjustedorigin, entity.angles);
  } else if(isDefined(entity.enemy)) {
    entity orientmode("face direction", entity.enemy.origin - entity.origin);
  }
  recordcircle(entity.animationadjustmentinfoz.landposonground, 8, (0, 1, 0), "", entity);
}

function mocompapothiconfuryjuketerminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.blockingpain = 0;
  entity solid();
  entity pushactors(1);
  entity.isjuking = 0;
  entity.usegoalanimweight = 0;
  entity.pushable = 1;
  entity.jukeinfo = undefined;
  recordcircle(entity.animationadjustmentinfoz.landposonground, 8, (0, 1, 0), "", entity);
  if(isDefined(entity.enemy)) {
    entity orientmode("face direction", entity.enemy.origin - entity.origin);
  }
}

function private runbamfreadjustmentanalysis(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  assert(isDefined(entity.animationadjustmentinfoz.adjustmentstarted) && entity.animationadjustmentinfoz.adjustmentstarted);
  if(isDefined(entity.animationadjustmentinfoz.readjustmentstarted) && entity.animationadjustmentinfoz.readjustmentstarted) {
    return;
  }
  readjustmentanimtime = 0.45;
  animtime = entity getanimtime(mocompanim);
  if(animtime >= readjustmentanimtime && entity.enemy === entity.animationadjustmentinfoz.enemy) {
    meleestartposition = entity.animationadjustmentinfoz.landposonground;
    if(isDefined(entity.enemy.last_valid_position)) {
      meleeendposition = entity.enemy.last_valid_position;
    } else {
      meleeendposition = entity.enemy.origin;
      enemyforwarddir = anglesToForward(entity.enemy.angles);
      newmeleeendposition = meleeendposition + (enemyforwarddir * randomintrange(30, 50));
      newmeleeendposition = getclosestpointonnavmesh(newmeleeendposition, 20, 50);
      if(isDefined(newmeleeendposition)) {
        meleeendposition = newmeleeendposition;
      }
    }
    if(distancesquared(meleestartposition, meleeendposition) < 1024) {
      return;
    }
    if(!util::within_fov(meleeendposition, entity.enemy.angles, entity.origin, 0.642)) {
      return;
    }
    if(!util::within_fov(meleestartposition, entity.angles, meleeendposition, 0.642)) {
      return;
    }
    if(!ispointonnavmesh(meleestartposition, entity)) {
      return;
    }
    if(!ispointonnavmesh(meleeendposition, entity)) {
      return;
    }
    if(!tracepassedonnavmesh(meleestartposition, meleeendposition, entity.entityradius)) {
      return;
    }
    if(!entity findpath(meleestartposition, meleeendposition)) {
      return;
    }
    landpos = entity.animationadjustmentinfoz.landposonground;
    recordcircle(meleeendposition, 8, (0, 1, 1), "", entity);
    recordcircle(landpos, 8, (0, 0, 1), "", entity);
    zdiff = landpos[2] - meleeendposition[2];
    tracestart = undefined;
    traceend = undefined;
    if(zdiff < 0) {
      traceoffsetabove = (zdiff * -1) + 30;
      tracestart = meleeendposition + (0, 0, traceoffsetabove);
      traceend = meleeendposition + (vectorscale((0, 0, -1), 70));
    } else {
      traceoffsetbelow = (zdiff * -1) - 30;
      tracestart = meleeendposition + vectorscale((0, 0, 1), 70);
      traceend = meleeendposition + (0, 0, traceoffsetbelow);
    }
    trace = groundtrace(tracestart, traceend, 0, entity, 1, 1);
    landposonground = trace["position"];
    landposonground = getclosestpointonnavmesh(landposonground, 100, 50);
    if(!isDefined(landposonground)) {
      return;
    }
    recordcircle(landposonground, 8, (0, 1, 0), "", entity);
    recordline(landpos, landposonground, (0, 1, 0), "", entity);
    assert(isDefined(entity.animationadjustmentinfoz));
    starttime = readjustmentanimtime;
    stoptime = entity.animationadjustmentinfoz.stoptime;
    entity.animationadjustmentinfoz2 = new animationadjustmentinfoz();
    entity.animationadjustmentinfoz2.starttime = readjustmentanimtime;
    entity.animationadjustmentinfoz2.stoptime = stoptime;
    entity.animationadjustmentinfoz2.landposonground = landposonground;
    animlength = getanimlength(mocompanim) * 1000;
    starttime = starttime * animlength;
    stoptime = stoptime * animlength;
    starttime = floor(starttime / 50);
    stoptime = floor(stoptime / 50);
    adjustduration = stoptime - starttime;
    heightdiff = landposonground[2] - landpos[2];
    entity.animationadjustmentinfoz2.stepsize = heightdiff / adjustduration;
    if(heightdiff < 0) {
      record3dtext((("" + entity.animationadjustmentinfoz2.stepsize) + "") + adjustduration, landposonground, (1, 0.5, 0), "");
    } else {
      record3dtext((("" + entity.animationadjustmentinfoz2.stepsize) + "") + adjustduration, landposonground, (1, 0.5, 0), "");
    }
    meleeendposition = (meleeendposition[0], meleeendposition[1], landpos[2]);
    xydirection = vectornormalize(meleeendposition - landpos);
    xydistance = distance(meleeendposition, landpos);
    entity.animationadjustmentinfoxy = new animationadjustmentinfoxy();
    entity.animationadjustmentinfoxy.starttime = starttime;
    entity.animationadjustmentinfoxy.stoptime = stoptime;
    entity.animationadjustmentinfoxy.stepsize = xydistance / adjustduration;
    entity.animationadjustmentinfoxy.xydirection = xydirection;
    entity.animationadjustmentinfoxy.adjustmentstarted = 1;
    record3dtext(((("" + xydistance) + "") + entity.animationadjustmentinfoxy.stepsize) + "", meleeendposition, (0, 0, 1), "");
    entity.animationadjustmentinfoz.readjustmentstarted = 1;
  }
}

function mocompapothiconfurybamfinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  assert(isDefined(entity.enemy));
  entity.animationadjustmentinfoz = undefined;
  entity.animationadjustmentinfoz2 = undefined;
  entity.animationadjustmentinfoxy = undefined;
  entity clearpath();
  entity pathmode("dont move");
  entity.blockingpain = 1;
  entity.usegoalanimweight = 1;
  self pushactors(0);
  entity.isbamfing = 1;
  entity.pushable = 0;
  anglestoenemy = (0, vectortoangles(entity.enemy.origin - entity.origin)[1], 0);
  entity forceteleport(entity.origin, anglestoenemy);
  entity orientmode("face angle", anglestoenemy[1]);
  entity animmode("noclip", 1);
  movedeltavector = getmovedelta(mocompanim, 0, 1, entity);
  landpos = entity localtoworldcoords(movedeltavector);
  recordcircle(entity.enemy.origin, 8, (0, 1, 1), "", entity);
  recordline(landpos, entity.enemy.origin, (0, 1, 1), "", entity);
  recordcircle(landpos, 8, (0, 0, 1), "", entity);
  record3dtext("" + distance(entity.origin, landpos), landpos, (0, 0, 1), "");
  zdiff = entity.origin[2] - entity.enemy.origin[2];
  tracestart = undefined;
  traceend = undefined;
  if(zdiff < 0) {
    traceoffsetabove = (zdiff * -1) + 30;
    tracestart = landpos + (0, 0, traceoffsetabove);
    traceend = landpos + (vectorscale((0, 0, -1), 70));
  } else {
    traceoffsetbelow = (zdiff * -1) - 30;
    tracestart = landpos + vectorscale((0, 0, 1), 70);
    traceend = landpos + (0, 0, traceoffsetbelow);
  }
  trace = groundtrace(tracestart, traceend, 0, entity, 1, 1);
  landposonground = trace["position"];
  landposonground = getclosestpointonnavmesh(landposonground, 100, 25);
  if(!isDefined(landposonground)) {
    landposonground = entity.enemy.origin;
  }
  recordcircle(landposonground, 8, (0, 1, 0), "", entity);
  recordline(landpos, landposonground, (0, 1, 0), "", entity);
  heightdiff = landposonground[2] - landpos[2];
  assert(animhasnotetrack(mocompanim, ""));
  starttime = getnotetracktimes(mocompanim, "start_effect")[0];
  vectortostarttime = getmovedelta(mocompanim, 0, starttime, entity);
  startpos = entity localtoworldcoords(vectortostarttime);
  assert(animhasnotetrack(mocompanim, ""));
  stoptime = getnotetracktimes(mocompanim, "end_effect")[0];
  vectortostoptime = getmovedelta(mocompanim, 0, stoptime, entity);
  stoppos = entity localtoworldcoords(vectortostoptime);
  recordsphere(startpos, 3, (0, 0, 1), "", entity);
  recordsphere(stoppos, 3, (0, 0, 1), "", entity);
  recordline(entity.origin, startpos, (0, 0, 1), "", entity);
  recordline(startpos, stoppos, (0, 0, 1), "", entity);
  recordline(stoppos, landpos, (0, 0, 1), "", entity);
  newstoppos = stoppos + (0, 0, heightdiff);
  recordline(startpos, newstoppos, (0, 1, 0), "", entity);
  recordline(newstoppos, landposonground, (0, 1, 0), "", entity);
  recordsphere(newstoppos, 3, (0, 1, 0), "", entity);
  entity.animationadjustmentinfoz = new animationadjustmentinfoz();
  entity.animationadjustmentinfoz.starttime = starttime;
  entity.animationadjustmentinfoz.stoptime = stoptime;
  entity.animationadjustmentinfoz.enemy = entity.enemy;
  animlength = getanimlength(mocompanim) * 1000;
  starttime = starttime * animlength;
  stoptime = stoptime * animlength;
  starttime = floor(starttime / 50);
  stoptime = floor(stoptime / 50);
  adjustduration = stoptime - starttime;
  entity.animationadjustmentinfoz.stepsize = heightdiff / adjustduration;
  entity.animationadjustmentinfoz.landposonground = landposonground;
  if(heightdiff < 0) {
    record3dtext((((("" + distance(landpos, landposonground)) + "") + entity.animationadjustmentinfoz.stepsize) + "") + adjustduration, landposonground, (1, 0.5, 0), "");
  } else {
    record3dtext((((("" + distance(landpos, landposonground)) + "") + entity.animationadjustmentinfoz.stepsize) + "") + adjustduration, landposonground, (1, 0.5, 0), "");
  }
}

function mocompapothiconfurybamfupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  assert(isDefined(entity.animationadjustmentinfoz));
  if(!isDefined(entity.enemy)) {
    return;
  }
  animtime = entity getanimtime(mocompanim);
  if(!entity.animationadjustmentinfoz.adjustmentstarted) {
    if(animtime >= entity.animationadjustmentinfoz.starttime) {
      entity.animationadjustmentinfoz.adjustmentstarted = 1;
    }
  }
  if(entity.animationadjustmentinfoz.adjustmentstarted && animtime < entity.animationadjustmentinfoz.stoptime) {
    adjustedorigin = entity.origin + (0, 0, entity.animationadjustmentinfoz.stepsize);
    runbamfreadjustmentanalysis(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
    if(isDefined(entity.animationadjustmentinfoz.readjustmentstarted) && entity.animationadjustmentinfoz.readjustmentstarted) {
      if(isDefined(entity.animationadjustmentinfoz2)) {
        adjustedorigin = adjustedorigin + (0, 0, entity.animationadjustmentinfoz2.stepsize);
      }
      if(isDefined(entity.animationadjustmentinfoxy)) {
        adjustedorigin = adjustedorigin + (entity.animationadjustmentinfoxy.xydirection * entity.animationadjustmentinfoxy.stepsize);
      }
    }
    entity forceteleport(adjustedorigin, entity.angles);
  } else if(isDefined(entity.enemy)) {
    entity orientmode("face direction", entity.enemy.origin - entity.origin);
  }
}

function mocompapothiconfurybamfterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity pathmode("move allowed");
  entity solid();
  entity show();
  entity.blockingpain = 0;
  entity.usegoalanimweight = 0;
  entity orientmode("face angle", entity.angles[1]);
  entity animmode("gravity");
  entity.isbamfing = 0;
  entity.pushable = 1;
  self pushactors(1);
  entity.jukeinfo = undefined;
  if(!ispointonnavmesh(entity.origin)) {
    clamptonavmeshlocation = getclosestpointonnavmesh(entity.origin, 100, 25);
    if(isDefined(clamptonavmeshlocation)) {
      entity forceteleport(clamptonavmeshlocation);
    }
  }
}

function apothiconcanmeleeattack(entity) {
  return apothiconcanbamf(entity) || apothiconshouldmeleecondition(entity);
}

function apothiconshouldmeleecondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemyoverride) && isDefined(behaviortreeentity.enemyoverride[1])) {
    return false;
  }
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }
  if(isDefined(behaviortreeentity.marked_for_death)) {
    return false;
  }
  if(isDefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
    return false;
  }
  if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > 10000) {
    return false;
  }
  yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - (vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]));
  if(abs(yawtoenemy) > 60) {
    return false;
  }
  return true;
}

function apothiconcanbamfafterjuke(entity) {
  return apothiconcanbamfinternal(entity);
}

function apothiconcanbamf(entity) {
  return apothiconcanbamfinternal(entity);
}

function apothiconcanbamfinternal(entity, bamfafterjuke = 0) {
  if(!ai::getaiattribute(entity, "can_bamf")) {
    return false;
  }
  if(!isDefined(entity.enemy)) {
    return false;
  }
  if(!isplayer(entity.enemy)) {
    return false;
  }
  if(isDefined(entity.juking) && entity.juking) {
    return false;
  }
  if(isDefined(entity.isbamfing) && entity.isbamfing) {
    return false;
  }
  if(!bamfafterjuke) {
    if(gettime() < entity.nextbamfmeleetime) {
      return false;
    }
    jukeevents = blackboard::getblackboardevents("apothicon_fury_bamf");
    tooclosejukedistancesqr = 400 * 400;
    foreach(event in jukeevents) {
      if(distance2dsquared(entity.origin, event.data.origin) <= tooclosejukedistancesqr) {
        return false;
      }
    }
  }
  assert(isDefined(entity.enemy));
  enemyorigin = entity.enemy.origin;
  apothiconfurys = getaiarchetypearray("apothicon_fury");
  furiesnearplayer = 0;
  foreach(apothiconfury in apothiconfurys) {
    if(distancesquared(enemyorigin, apothiconfury.origin) <= 6400) {
      furiesnearplayer++;
    }
  }
  if(furiesnearplayer >= 4) {
    return false;
  }
  distancetoenemysq = distancesquared(enemyorigin, entity.origin);
  distanceminthresholdsq = 400 * 400;
  if(bamfafterjuke) {
    distanceminthresholdsq = 250 * 250;
  }
  if(distancetoenemysq > distanceminthresholdsq && distancetoenemysq < (750 * 750)) {
    if(!util::within_fov(enemyorigin, entity.enemy.angles, entity.origin, 0.642)) {
      return false;
    }
    if(!util::within_fov(entity.origin, entity.angles, enemyorigin, 0.642)) {
      return false;
    }
    meleestartposition = entity.origin;
    meleeendposition = enemyorigin;
    if(!ispointonnavmesh(meleestartposition, entity)) {
      return false;
    }
    if(!ispointonnavmesh(meleeendposition, entity)) {
      return false;
    }
    if(!tracepassedonnavmesh(meleestartposition, meleeendposition, entity.entityradius)) {
      return false;
    }
    if(!entity findpath(meleestartposition, meleeendposition)) {
      return false;
    }
    return true;
  }
  return false;
}

function getbamfmeleedistance(entity) {
  distancetoenemy = distance(self.enemy.origin, self.origin);
  return distancetoenemy;
}

function apothiconbamfinit(entity) {
  jukeinfo = spawnStruct();
  jukeinfo.origin = entity.origin;
  jukeinfo.entity = entity;
  blackboard::addblackboardevent("apothicon_fury_bamf", jukeinfo, 4500);
  if(isDefined(level.nextbamfmeleetimemin) && isDefined(level.nextbamfmeleetimemax)) {
    entity.nextbamfmeleetime = gettime() + randomfloatrange(level.nextbamfmeleetimemin, level.nextbamfmeleetimemax);
  } else {
    entity.nextbamfmeleetime = gettime() + randomfloatrange(4500, 6000);
  }
}

function apothiconshouldtauntatplayer(entity) {
  tauntevents = blackboard::getblackboardevents("apothicon_fury_taunt");
  if(isDefined(tauntevents) && tauntevents.size) {
    return false;
  }
  return true;
}

function apothicontauntatplayerevent(entity) {
  jukeinfo = spawnStruct();
  jukeinfo.origin = entity.origin;
  jukeinfo.entity = entity;
  blackboard::addblackboardevent("apothicon_fury_taunt", jukeinfo, 9500);
}

function bb_idgungetdamagedirection() {
  if(isDefined(self.damage_direction)) {
    return self.damage_direction;
  }
  return self aiutility::bb_getdamagedirection();
}

function apothiconbamfland(entity) {
  if(entity.archetype != "apothicon_fury") {
    return;
  }
  if(isDefined(entity.enemy)) {
    entity orientmode("face direction", entity.enemy.origin - entity.origin);
  }
  entity clientfield::increment("bamf_land");
  if(isDefined(entity.enemy) && isplayer(entity.enemy) && distancesquared(entity.enemy.origin, entity.origin) <= (250 * 250)) {
    entity.enemy dodamage(25, entity.origin, entity, entity, undefined, "MOD_MELEE");
  }
  physicsexplosionsphere(entity.origin, 100, 15, 10);
}

function apothiconmovestart(entity) {
  entity.movetime = gettime();
  entity.moveorigin = entity.origin;
}

function apothiconmoveupdate(entity) {
  if(isDefined(entity.move_anim_end_time) && gettime() >= entity.move_anim_end_time) {
    entity.move_anim_end_time = undefined;
    return;
  }
  if(!(isDefined(entity.missinglegs) && entity.missinglegs) && (gettime() - entity.movetime) > 1000) {
    distsq = distance2dsquared(entity.origin, entity.moveorigin);
    if(distsq < 144) {
      if(isDefined(entity.cant_move_cb)) {
        entity[[entity.cant_move_cb]]();
      }
    } else {
      entity.cant_move = 0;
    }
    entity.movetime = gettime();
    entity.moveorigin = entity.origin;
  }
}

function apothiconknockdownservice(entity) {
  if(isDefined(entity.isjuking) && entity.isjuking) {
    return;
  }
  if(isDefined(entity.isbamfing) && entity.isbamfing) {
    return;
  }
  velocity = entity getvelocity();
  predict_time = 0.5;
  predicted_pos = entity.origin + (velocity * predict_time);
  move_dist_sq = distancesquared(predicted_pos, entity.origin);
  speed = move_dist_sq / predict_time;
  if(speed >= 10) {
    a_zombies = getaiarchetypearray("zombie");
    a_filtered_zombies = array::filter(a_zombies, 0, &apothiconzombieeligibleforknockdown, entity, predicted_pos);
    if(a_filtered_zombies.size > 0) {
      foreach(zombie in a_filtered_zombies) {
        apothiconknockdownzombie(entity, zombie);
      }
    }
  }
}

function private apothiconzombieeligibleforknockdown(zombie, thrasher, predicted_pos) {
  if(zombie.knockdown === 1) {
    return false;
  }
  if(isDefined(zombie.missinglegs) && zombie.missinglegs) {
    return false;
  }
  knockdown_dist_sq = 2304;
  dist_sq = distancesquared(predicted_pos, zombie.origin);
  if(dist_sq > knockdown_dist_sq) {
    return false;
  }
  origin = thrasher.origin;
  facing_vec = anglesToForward(thrasher.angles);
  enemy_vec = zombie.origin - origin;
  enemy_yaw_vec = (enemy_vec[0], enemy_vec[1], 0);
  facing_yaw_vec = (facing_vec[0], facing_vec[1], 0);
  enemy_yaw_vec = vectornormalize(enemy_yaw_vec);
  facing_yaw_vec = vectornormalize(facing_yaw_vec);
  enemy_dot = vectordot(facing_yaw_vec, enemy_yaw_vec);
  if(enemy_dot < 0) {
    return false;
  }
  return true;
}

function apothiconknockdownzombie(entity, zombie) {
  zombie.knockdown = 1;
  zombie.knockdown_type = "knockdown_shoved";
  zombie_to_thrasher = entity.origin - zombie.origin;
  zombie_to_thrasher_2d = vectornormalize((zombie_to_thrasher[0], zombie_to_thrasher[1], 0));
  zombie_forward = anglesToForward(zombie.angles);
  zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
  zombie_right = anglestoright(zombie.angles);
  zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
  dot = vectordot(zombie_to_thrasher_2d, zombie_forward_2d);
  if(dot >= 0.5) {
    zombie.knockdown_direction = "front";
    zombie.getup_direction = "getup_back";
  } else {
    if(dot < 0.5 && dot > -0.5) {
      dot = vectordot(zombie_to_thrasher_2d, zombie_right_2d);
      if(dot > 0) {
        zombie.knockdown_direction = "right";
        if(math::cointoss()) {
          zombie.getup_direction = "getup_back";
        } else {
          zombie.getup_direction = "getup_belly";
        }
      } else {
        zombie.knockdown_direction = "left";
        zombie.getup_direction = "getup_belly";
      }
    } else {
      zombie.knockdown_direction = "back";
      zombie.getup_direction = "getup_belly";
    }
  }
}

function apothiconshouldswitchtofuriousmode(entity) {
  if(!ai::getaiattribute(entity, "can_be_furious")) {
    return false;
  }
  if(isDefined(entity.isfurious) && entity.isfurious) {
    return false;
  }
  apothiconfurys = getaiarchetypearray("apothicon_fury");
  count = 0;
  foreach(apothiconfury in apothiconfurys) {
    if(isDefined(apothiconfury.isfurious) && apothiconfury.isfurious) {
      count++;
    }
  }
  if(count >= 1) {
    return false;
  }
  furiousevents = blackboard::getblackboardevents("apothicon_furious_mode");
  if(!furiousevents.size && entity.furiouslevel >= 3) {
    return true;
  }
  return false;
}

function apothiconfuriousmodeinit(entity) {
  if(!apothiconshouldswitchtofuriousmode(entity)) {
    return;
  }
  furiousinfo = spawnStruct();
  furiousinfo.origin = entity.origin;
  furiousinfo.entity = entity;
  blackboard::addblackboardevent("apothicon_furious_mode", furiousinfo, randomintrange(5000, 7000));
  entity pushactors(0);
  entity.isfurious = 1;
  blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_super_sprint");
  entity clientfield::set("furious_level", 1);
  entity.health = entity.health * 2;
}

function apothiconpreemptivejukeservice(entity) {
  if(!(isDefined(entity.isfurious) && entity.isfurious)) {
    return false;
  }
  if(isDefined(entity.nextjuketime) && entity.nextjuketime > gettime()) {
    return false;
  }
  if(isDefined(entity.enemy)) {
    if(!isplayer(entity.enemy)) {
      return false;
    }
    if(entity.enemy playerads() < entity.nextpreemptivejukeads) {
      return false;
    }
  }
  if(apothiconcanjuke(entity)) {
    entity.apothiconpreemptivejuke = 1;
  }
}

function apothiconpreemptivejukepending(entity) {
  return isDefined(entity.apothiconpreemptivejuke) && entity.apothiconpreemptivejuke;
}

function apothiconpreemptivejukedone(entity) {
  entity.apothiconpreemptivejuke = 0;
}

function apothiconcanjuke(entity) {
  if(!ai::getaiattribute(entity, "can_juke")) {
    return false;
  }
  if(!isDefined(entity.enemy) || !isplayer(entity.enemy)) {
    return false;
  }
  if(isDefined(entity.isjuking) && entity.isjuking) {
    return false;
  }
  if(isDefined(entity.apothiconpreemptivejuke) && entity.apothiconpreemptivejuke) {
    return true;
  }
  if(isDefined(entity.nextjuketime) && gettime() < entity.nextjuketime) {
    return false;
  }
  jukeevents = blackboard::getblackboardevents("apothicon_fury_juke");
  tooclosejukedistancesqr = 250 * 250;
  foreach(event in jukeevents) {
    if(distance2dsquared(entity.origin, event.data.origin) <= tooclosejukedistancesqr) {
      return false;
    }
  }
  if(distance2dsquared(entity.origin, entity.enemy.origin) < (250 * 250)) {
    return false;
  }
  if(!util::within_fov(entity.enemy.origin, entity.enemy.angles, entity.origin, 0.642)) {
    return false;
  }
  if(!util::within_fov(entity.origin, entity.angles, entity.enemy.origin, 0.642)) {
    return false;
  }
  if(isDefined(entity.jukemaxdistance) && isDefined(entity.enemy)) {
    maxdistsquared = entity.jukemaxdistance * entity.jukemaxdistance;
    if(distance2dsquared(entity.origin, entity.enemy.origin) > maxdistsquared) {
      return false;
    }
  }
  jukeinfo = calculatejukeinfo(entity);
  if(isDefined(jukeinfo)) {
    return true;
  }
  return false;
}

function apothiconjukeinit(entity) {
  jukeinfo = calculatejukeinfo(entity);
  assert(isDefined(jukeinfo));
  blackboard::setblackboardattribute(entity, "_juke_distance", jukeinfo.jukedistance);
  blackboard::setblackboardattribute(entity, "_juke_direction", jukeinfo.jukedirection);
  entity clearpath();
  entity notify("bhtn_action_notify", "apothicon_fury_juke");
  jukeinfo = spawnStruct();
  jukeinfo.origin = entity.origin;
  jukeinfo.entity = entity;
  blackboard::addblackboardevent("apothicon_fury_juke", jukeinfo, 6000);
  entity.nextpreemptivejukeads = randomfloatrange(0.6, 0.8);
  if(isDefined(level.nextjukemeleetimemin) && isDefined(level.nextjukemeleetimemax)) {
    entity.nextjukemeleetime = gettime() + randomfloatrange(level.nextjukemeleetimemin, level.nextjukemeleetimemax);
  } else {
    entity.nextjuketime = gettime() + randomfloatrange(7000, 10000);
  }
}

function validatejuke(entity, entityradius, jukevector) {
  velocity = entity getvelocity();
  predictedpos = entity.origin + (velocity * 0.1);
  jukelandpos = predictedpos + jukevector;
  if(!isDefined(jukelandpos)) {
    return undefined;
  }
  tracestart = jukelandpos + vectorscale((0, 0, 1), 70);
  traceend = jukelandpos + (vectorscale((0, 0, -1), 70));
  trace = groundtrace(tracestart, traceend, 0, entity, 1, 1);
  landposonground = trace["position"];
  if(!isDefined(landposonground)) {
    return undefined;
  }
  if(!ispointonnavmesh(landposonground)) {
    return undefined;
  }
  recordline(entity.origin, predictedpos, (0, 1, 0), "", entity);
  recordsphere(jukelandpos, 2, (1, 0, 0), "", entity);
  recordline(predictedpos, jukelandpos, (1, 0, 0), "", entity);
  if(ispointonnavmesh(landposonground, entity.entityradius * 2.5) && tracepassedonnavmesh(predictedpos, landposonground, entity.entityradius)) {
    if(!entity isposinclaimedlocation(landposonground) && entity maymovefrompointtopoint(predictedpos, landposonground, 0, 0)) {
      recordsphere(landposonground, 2, (0, 1, 0), "", entity);
      recordline(predictedpos, landposonground, (0, 1, 0), "", entity);
      return landposonground;
    }
  }
  return undefined;
}

function private getjukevector(entity, jukeanimalias) {
  jukeanim = entity animmappingsearch(istring(jukeanimalias));
  localdeltavector = getmovedelta(jukeanim, 0, 1, entity);
  endpoint = entity localtoworldcoords(localdeltavector);
  return endpoint - entity.origin;
}

function private calculatejukeinfo(entity) {
  if(isDefined(entity.jukeinfo)) {
    return entity.jukeinfo;
  }
  directiontoenemy = vectornormalize(entity.enemy.origin - entity.origin);
  forwarddir = anglesToForward(entity.angles);
  possiblejukes = [];
  jukevaliddistancetype = [];
  entityradius = entity.entityradius;
  jukevector = getjukevector(entity, "anim_zombie_juke_left_long");
  landposonground = validatejuke(entity, entityradius, jukevector);
  if(isDefined(landposonground)) {
    jukeinfo = new jukeinfo();
    jukeinfo.jukedirection = "left";
    jukeinfo.jukedistance = "long";
    jukeinfo.landposonground = landposonground;
    if(!isDefined(possiblejukes)) {
      possiblejukes = [];
    } else if(!isarray(possiblejukes)) {
      possiblejukes = array(possiblejukes);
    }
    possiblejukes[possiblejukes.size] = jukeinfo;
  }
  jukevector = getjukevector(entity, "anim_zombie_juke_right_long");
  landposonground = validatejuke(entity, entityradius, jukevector);
  if(isDefined(landposonground)) {
    jukeinfo = new jukeinfo();
    jukeinfo.jukedirection = "right";
    jukeinfo.jukedistance = "long";
    jukeinfo.landposonground = landposonground;
    if(!isDefined(possiblejukes)) {
      possiblejukes = [];
    } else if(!isarray(possiblejukes)) {
      possiblejukes = array(possiblejukes);
    }
    possiblejukes[possiblejukes.size] = jukeinfo;
  }
  jukevector = getjukevector(entity, "anim_zombie_juke_left_front_long");
  landposonground = validatejuke(entity, entityradius, jukevector);
  if(isDefined(landposonground)) {
    jukeinfo = new jukeinfo();
    jukeinfo.jukedirection = "left_front";
    jukeinfo.jukedistance = "long";
    jukeinfo.landposonground = landposonground;
    if(!isDefined(possiblejukes)) {
      possiblejukes = [];
    } else if(!isarray(possiblejukes)) {
      possiblejukes = array(possiblejukes);
    }
    possiblejukes[possiblejukes.size] = jukeinfo;
  }
  jukevector = getjukevector(entity, "anim_zombie_juke_right_front_long");
  landposonground = validatejuke(entity, entityradius, jukevector);
  if(isDefined(landposonground)) {
    jukeinfo = new jukeinfo();
    jukeinfo.jukedirection = "right_front";
    jukeinfo.jukedistance = "long";
    jukeinfo.landposonground = landposonground;
    if(!isDefined(possiblejukes)) {
      possiblejukes = [];
    } else if(!isarray(possiblejukes)) {
      possiblejukes = array(possiblejukes);
    }
    possiblejukes[possiblejukes.size] = jukeinfo;
  }
  if(possiblejukes.size) {
    jukeinfo = array::random(possiblejukes);
    jukeinfo.jukestartangles = entity.angles;
    entity.lastjukeinfoupdatetime = gettime();
    entity.jukeinfo = jukeinfo;
    return jukeinfo;
  }
  return undefined;
}

function apothiconbamfout(entity) {
  if(entity.archetype != "apothicon_fury") {
    return;
  }
  entity ghost();
  entity notsolid();
  self clientfield::set("juke_active", 0);
  a_zombies = getaiarchetypearray("zombie");
  a_filtered_zombies = array::filter(a_zombies, 0, &apothiconzombieeligibleforknockdown, entity, entity.origin);
  if(a_filtered_zombies.size > 0) {
    foreach(zombie in a_filtered_zombies) {
      apothiconknockdownzombie(entity, zombie);
    }
  }
}

function apothiconbamfin(entity) {
  if(entity.archetype != "apothicon_fury") {
    return;
  }
  if(isDefined(entity.traverseendnode)) {
    entity forceteleport(entity.traverseendnode.origin, entity.angles);
    entity unlink();
    entity.istraveling = 0;
    entity notify("travel_complete");
    entity setrepairpaths(1);
    entity.blockingpain = 0;
    entity.usegoalanimweight = 0;
    entity.bgbignorefearinheadlights = 0;
    entity asmsetanimationrate(1);
    entity finishtraversal();
    entity animmode("gravity", 1);
  }
  entity show();
  entity solid();
  self clientfield::set("juke_active", 1);
  a_zombies = getaiarchetypearray("zombie");
  a_filtered_zombies = array::filter(a_zombies, 0, &apothiconzombieeligibleforknockdown, entity, entity.origin);
  if(a_filtered_zombies.size > 0) {
    foreach(zombie in a_filtered_zombies) {
      apothiconknockdownzombie(entity, zombie);
    }
  }
}

function apothicondeathstart(entity) {
  entity setModel("c_zom_dlc4_apothicon_fury_dissolve");
  entity clientfield::set("apothicon_fury_death", 2);
  entity notsolid();
}

function apothicondeathterminate(entity) {}

function apothicondamageclientfieldupdate(entity, shitloc) {
  increment = 0;
  if(isinarray(array("helmet", "head", "neck"), shitloc)) {
    increment = 1;
  } else {
    if(isinarray(array("torso_upper", "torso_mid"), shitloc)) {
      increment = 2;
    } else {
      if(isinarray(array("torso_lower"), shitloc)) {
        increment = 3;
      } else {
        if(isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
          increment = 4;
        } else {
          if(isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
            increment = 5;
          } else {
            if(isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), shitloc)) {
              increment = 7;
            } else {
              increment = 6;
            }
          }
        }
      }
    }
  }
  entity clientfield::increment("fury_fire_damage", increment);
}

function apothicondamagecallback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(!(isDefined(self.zombie_think_done) && self.zombie_think_done)) {
    return 0;
  }
  if(isDefined(eattacker) && isplayer(eattacker) && isDefined(shitloc)) {
    apothicondamageclientfieldupdate(self, shitloc);
  }
  if(isDefined(shitloc)) {
    if(!(isDefined(self.isfurious) && self.isfurious)) {
      self.furiouslevel = self.furiouslevel + 1;
    }
  }
  eattacker zombie_utility::show_hit_marker();
  return idamage;
}

function apothiconondeath(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettimes) {
  self clientfield::set("apothicon_fury_death", 1);
  self notsolid();
  return damage;
}

#namespace apothiconfurybehaviorinterface;

function movespeedattributecallback(entity, attribute, oldvalue, value) {
  if(isDefined(entity.isfurious) && entity.isfurious) {
    return;
  }
  switch (value) {
    case "walk": {
      blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_walk");
      break;
    }
    case "run": {
      blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_run");
      break;
    }
    case "sprint": {
      blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
      break;
    }
    case "super_sprint": {
      blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_super_sprint");
      break;
    }
    default: {
      break;
    }
  }
}