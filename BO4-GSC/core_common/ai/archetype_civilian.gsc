/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_civilian.gsc
*************************************************/

#include scripts\core_common\ai\archetype_civilian_interface;
#include scripts\core_common\ai\archetype_human_cover;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\ai_blackboard;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\util_shared;

#namespace archetype_civilian;

autoexec main() {
  archetypecivilian::registerbehaviorscriptfunctions();
  civilianinterface::registercivilianinterfaceattributes();
}

#namespace archetypecivilian;

registerbehaviorscriptfunctions() {
  spawner::add_archetype_spawn_function(#"civilian", &civilianblackboardinit);
  spawner::add_archetype_spawn_function(#"civilian", &civilianinit);
  assert(!isDefined(&civilianmoveactioninitialize) || isscriptfunctionptr(&civilianmoveactioninitialize));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&civilianmoveactionfinalize) || isscriptfunctionptr(&civilianmoveactionfinalize));
  behaviortreenetworkutility::registerbehaviortreeaction("civilianMoveAction", &civilianmoveactioninitialize, undefined, &civilianmoveactionfinalize);
  assert(isscriptfunctionptr(&civilianwanderservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("civilianWanderService", &civilianwanderservice, 1);
  assert(isscriptfunctionptr(&civilianpanicescapechooseposition));
  behaviortreenetworkutility::registerbehaviortreescriptapi("civilianPanicEscapeChoosePosition", &civilianpanicescapechooseposition, 1);
  assert(isscriptfunctionptr(&rioterchoosepositionservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("rioterChoosePositionService", &rioterchoosepositionservice, 1);
  assert(isscriptfunctionptr(&civilianfollowservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("civilianFollowService", &civilianfollowservice, 1);
  assert(isscriptfunctionptr(&civiliancanthrowmolotovgrenade));
  behaviortreenetworkutility::registerbehaviortreescriptapi("civilianCanThrowMolotovGrenade", &civiliancanthrowmolotovgrenade);
  assert(isscriptfunctionptr(&civilianpreparetothrowgrenade));
  behaviortreenetworkutility::registerbehaviortreescriptapi("civilianPrepareToThrowGrenade", &civilianpreparetothrowgrenade);
  assert(isscriptfunctionptr(&civiliancleanuptothrowgrenade));
  behaviortreenetworkutility::registerbehaviortreescriptapi("civilianCleanUpToThrowGrenade", &civiliancleanuptothrowgrenade);
  assert(isscriptfunctionptr(&civilianispanicked));
  behaviortreenetworkutility::registerbehaviortreescriptapi("civilianIsPanicked", &civilianispanicked);
  assert(isscriptfunctionptr(&civilianarrivalallowed));
  behaviorstatemachine::registerbsmscriptapiinternal("civilianArrivalAllowed", &civilianarrivalallowed);
  assert(isscriptfunctionptr(&civilianareturnsallowed));
  behaviorstatemachine::registerbsmscriptapiinternal("civilianAreTurnsAllowed", &civilianareturnsallowed);
  assert(isscriptfunctionptr(&civilianisrioter));
  behaviorstatemachine::registerbsmscriptapiinternal("civilianIsRioter", &civilianisrioter);
  assert(isscriptfunctionptr(&civilianisrioter));
  behaviortreenetworkutility::registerbehaviortreescriptapi("civilianIsRioter", &civilianisrioter);
  assert(isscriptfunctionptr(&rioterreaquireservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("rioterReaquireService", &rioterreaquireservice);

  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>" + "<dev string:x5f>" + "<dev string:x66>" + "<dev string:x5f>" + "<dev string:x83>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>" + "<dev string:x88>" + "<dev string:x90>" + "<dev string:x88>" + "<dev string:x83>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>" + "<dev string:xad>" + "<dev string:xb4>" + "<dev string:xad>" + "<dev string:x83>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>" + "<dev string:xd1>" + "<dev string:xd7>" + "<dev string:xd1>" + "<dev string:x83>");
  level thread function_686ab596();
}

private function_686ab596() {
  wait 5;

  while(true) {
    debug_civ_mode = getdvarstring(#"debug_civ_mode", "");
    ais = getaiarchetypearray(#"civilian");

    foreach(ai in ais) {
      switch (debug_civ_mode) {
        case #"riot":
          ai::setaiattribute(ai, #"_civ_mode", "riot");
          ai setteam(#"team3");
          break;
        case #"panic":
          ai::setaiattribute(ai, #"_civ_mode", "panic");
          break;
        case #"calm":
          ai::setaiattribute(ai, #"_civ_mode", "calm");
          break;
        case #"run":
          ai::setaiattribute(ai, #"_civ_mode", "run");
          break;
        default:
          break;
      }
    }

    wait 0.05;
  }
}

private civilianblackboardinit() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &civilianonanimscriptedcallback;
}

function_49d80e54(civilian, attribute, oldvalue, value) {
  assert(issentient(civilian));
  civilian setblackboardattribute("follow", value);
}

private civilianinit() {
  entity = self;
  locomotiontypes = array("alt1", "alt2", "alt3");
  altindex = entity getentitynumber() % locomotiontypes.size;
  entity setblackboardattribute("_human_locomotion_variation", locomotiontypes[altindex]);
  entity setavoidancemask("avoid none");
  entity disableaimassist();
  entity.ignorepathenemyfightdist = 1;
}

private civilianonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity civilianblackboardinit();
}

private function_ebea502e(entity) {
  if(entity asmistransitionrunning() || entity getbehaviortreestatus() != 5 || entity asmissubstatepending() || entity asmistransdecrunning()) {
    return true;
  }

  if(entity getpathmode() == "dont move") {
    return false;
  }

  return false;
}

private rioterchoosepositionservice(entity) {
  if(entity getblackboardattribute(#"_civ_mode") != "riot") {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(function_ebea502e(entity)) {
    return false;
  }

  goalinfo = entity function_4794d6a3();
  forcedgoal = isDefined(goalinfo.goalforced) && goalinfo.goalforced;
  isatscriptgoal = entity isatgoal() || entity isapproachinggoal();
  itsbeenawhile = gettime() > entity.nextfindbestcovertime;
  isinbadplace = entity isinanybadplace();
  lastknownpos = entity lastknownpos(entity.enemy);
  dist = distance2d(entity.origin, lastknownpos);
  shouldfindbetterposition = itsbeenawhile || !isatscriptgoal || isinbadplace;

  if(!shouldfindbetterposition) {
    return false;
  }

  if(forcedgoal) {
    assert(isDefined(goalinfo.goalpos));
    entity function_a57c34b7(goalinfo.goalpos);
    aiutility::setnextfindbestcovertime(entity, undefined);
    return true;
  }

  center = entity.origin;

  if(isDefined(entity.goalpos)) {
    center = entity.goalpos;
  }

  cylinder = ai::t_cylinder(center, entity.goalradius, entity.goalheight);
  pixbeginevent("rioter_tacquery_combat");
  aiprofile_beginentry("rioter_tacquery_combat");
  tacpoints = tacticalquery("rioter_tacquery_combat", center, entity, cylinder);
  pixendevent();
  aiprofile_endentry();
  pickedpoint = undefined;

  if(isDefined(tacpoints)) {
    tacpoints = array::randomize(tacpoints);

    foreach(tacpoint in tacpoints) {
      if(self isingoal(tacpoint.origin)) {
        if(isDefined(entity.pathgoalpos) && entity.pathgoalpos == tacpoint.origin) {
          continue;
        }

        pickedpoint = tacpoint;
        break;
      }
    }
  }

  if(isDefined(pickedpoint)) {
    entity function_a57c34b7(pickedpoint.origin);
    aiutility::setnextfindbestcovertime(entity, undefined);
    return true;
  }

  return false;
}

private civilianpanicescapechooseposition(entity) {
  if(entity getblackboardattribute(#"_civ_mode") == "riot") {
    return 0;
  }

  if(isDefined(entity.ai.escaping) && entity.ai.escaping) {
    return 0;
  }

  if(!ai::getaiattribute(entity, "auto_escape")) {
    return 0;
  }

  escape_nodes = getnodearray("civ_escape", "targetname");

  if(escape_nodes.size) {
    var_cc364bf7 = arraygetclosest(entity.origin, escape_nodes);
    entity function_a57c34b7(var_cc364bf7.origin);
    entity.ai.escaping = 1;
  }
}

private civilianwanderservice(entity) {
  if(isentity(entity getblackboardattribute("follow"))) {
    return false;
  }

  if(entity getblackboardattribute(#"_civ_mode") == "riot") {
    return false;
  }

  if(entity getblackboardattribute(#"_civ_mode") == "panic" && ai::getaiattribute(entity, "auto_escape")) {
    return false;
  }

  if(!ai::getaiattribute(entity, "auto_wander")) {
    return false;
  }

  if(function_ebea502e(entity)) {
    return false;
  }

  goalinfo = entity function_4794d6a3();
  forcedgoal = isDefined(goalinfo.goalforced) && goalinfo.goalforced;
  isatscriptgoal = entity isatgoal() || entity isapproachinggoal();
  itsbeenawhile = gettime() > entity.nextfindbestcovertime;
  shouldfindbetterposition = itsbeenawhile || !isatscriptgoal;

  if(!shouldfindbetterposition) {
    return false;
  }

  if(forcedgoal) {
    assert(isDefined(goalinfo.goalpos));
    entity function_a57c34b7(goalinfo.goalpos);
    aiutility::setnextfindbestcovertime(entity, undefined);
    return true;
  }

  cylinder = ai::t_cylinder(entity.goalpos, entity.goalradius, entity.goalheight);
  pixbeginevent("civilian_wander_tacquery");
  aiprofile_beginentry("civilian_wander_tacquery");
  tacpoints = tacticalquery("civilian_wander_tacquery", entity.goalpos, entity, cylinder);
  pixendevent();
  aiprofile_endentry();
  pickedpoint = undefined;

  if(isDefined(tacpoints)) {
    tacpoints = array::randomize(tacpoints);

    foreach(tacpoint in tacpoints) {
      if(!self isposinclaimedlocation(tacpoint.origin) && self isingoal(tacpoint.origin)) {
        if(isDefined(entity.pathgoalpos) && entity.pathgoalpos == tacpoint.origin) {
          continue;
        }

        pickedpoint = tacpoint;
        break;
      }
    }
  }

  if(isDefined(pickedpoint)) {
    entity function_a57c34b7(pickedpoint.origin);
    aiutility::setnextfindbestcovertime(entity, undefined);
    return true;
  }

  return false;
}

private civilianfollowservice(entity) {
  followradiussq = 300 * 300;
  followent = entity getblackboardattribute("follow");

  if(!isentity(followent)) {
    return false;
  }

  if(entity getblackboardattribute(#"_civ_mode") == "panic" && ai::getaiattribute(entity, "auto_escape")) {
    return false;
  }

  if(function_ebea502e(entity)) {
    return false;
  }

  goalinfo = entity function_4794d6a3();
  distsq = isDefined(entity.overridegoalpos) ? distancesquared(entity.overridegoalpos, followent.origin) : -1;
  forcedgoal = isDefined(goalinfo.goalforced) && goalinfo.goalforced;
  isatscriptgoal = entity isatgoal() || entity isapproachinggoal();
  itsbeenawhile = gettime() > entity.nextfindbestcovertime;
  shouldfindbetterposition = itsbeenawhile || !isatscriptgoal || distsq < 0 || distsq > followradiussq;

  if(!shouldfindbetterposition) {
    return false;
  }

  pixbeginevent("civilian_follow_tacquery");
  aiprofile_beginentry("civilian_follow_tacquery");
  tacpoints = tacticalquery("civilian_follow_tacquery", followent, entity, followent);
  pixendevent();
  aiprofile_endentry();
  pickedpoint = undefined;

  if(isDefined(tacpoints)) {
    tacpoints = array::randomize(tacpoints);

    if(tacpoints.size == 0) {
      pickedpoint = followent;
    } else {
      foreach(tacpoint in tacpoints) {
        if(!self isposinclaimedlocation(tacpoint.origin) && self isingoal(tacpoint.origin)) {
          if(isDefined(entity.pathgoalpos) && entity.pathgoalpos == tacpoint.origin) {
            continue;
          }

          pickedpoint = tacpoint;
          break;
        }
      }
    }
  }

  if(isDefined(pickedpoint)) {
    entity function_a57c34b7(pickedpoint.origin);
    aiutility::setnextfindbestcovertime(entity, undefined);
    return true;
  }

  return false;
}

private civilianmoveactioninitialize(entity, asmstatename) {
  entity setblackboardattribute("_desired_stance", "stand");
  animationstatenetworkutility::requeststate(entity, asmstatename);
  return 5;
}

private civilianmoveactionfinalize(entity, asmstatename) {
  if(entity getblackboardattribute("_stance") != "stand") {
    entity setblackboardattribute("_desired_stance", "stand");
  }

  return 4;
}

private civilianispanicked(entity) {
  return entity getblackboardattribute(#"_civ_mode") == "panic";
}

private function_e27d2a1b() {
  return ai::getaiattribute(self, #"_civ_mode");
}

private civilianarrivalallowed(entity) {
  if(ai::getaiattribute(entity, "disablearrivals")) {
    return false;
  }

  return true;
}

private civilianareturnsallowed(entity) {
  if(entity getblackboardattribute(#"_civ_mode") == "calm") {
    return false;
  }

  return true;
}

civilianisrioter(entity) {
  if(entity getblackboardattribute(#"_civ_mode") == "riot") {
    return true;
  }

  return false;
}

civiliancanthrowmolotovgrenade(behaviortreeentity, throwifpossible = 0) {
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }

  if(!issentient(behaviortreeentity.enemy)) {
    return false;
  }

  if(isvehicle(behaviortreeentity.enemy) && behaviortreeentity.enemy.vehicleclass === "helicopter") {
    return false;
  }

  if(!ai::getaiattribute(behaviortreeentity, "useGrenades")) {
    return false;
  }

  entityangles = behaviortreeentity.angles;
  toenemy = behaviortreeentity.enemy.origin - behaviortreeentity.origin;
  toenemy = vectornormalize((toenemy[0], toenemy[1], 0));
  entityforward = anglesToForward(entityangles);
  entityforward = vectornormalize((entityforward[0], entityforward[1], 0));

  if(vectordot(toenemy, entityforward) < 0.5) {
    return false;
  }

  if(!throwifpossible) {
    foreach(player in level.players) {
      if(player laststand::player_is_in_laststand() && distancesquared(behaviortreeentity.enemy.origin, player.origin) <= 640000) {
        return false;
      }
    }

    grenadethrowinfos = blackboard::getblackboardevents("team_grenade_throw");

    foreach(grenadethrowinfo in grenadethrowinfos) {
      if(grenadethrowinfo.data.grenadethrowerteam === behaviortreeentity.team) {
        return false;
      }
    }

    grenadethrowinfos = blackboard::getblackboardevents("riot_grenade_throw");

    foreach(grenadethrowinfo in grenadethrowinfos) {
      if(isDefined(grenadethrowinfo.data.grenadethrownat) && isalive(grenadethrowinfo.data.grenadethrownat)) {
        if(grenadethrowinfo.data.grenadethrower == behaviortreeentity) {
          return false;
        }

        if(isDefined(grenadethrowinfo.data.grenadethrownat) && grenadethrowinfo.data.grenadethrownat == behaviortreeentity.enemy) {
          return false;
        }

        if(isDefined(grenadethrowinfo.data.grenadethrownposition) && isDefined(behaviortreeentity.grenadethrowposition) && distancesquared(grenadethrowinfo.data.grenadethrownposition, behaviortreeentity.grenadethrowposition) <= 1440000) {
          return false;
        }
      }
    }
  }

  throw_dist = distance2dsquared(behaviortreeentity.origin, behaviortreeentity lastknownpos(behaviortreeentity.enemy));

  if(throw_dist < 300 * 300 || throw_dist > 1250 * 1250) {
    return false;
  }

  arm_offset = archetype_human_cover::temp_get_arm_offset(behaviortreeentity, behaviortreeentity lastknownpos(behaviortreeentity.enemy));
  throw_vel = behaviortreeentity canthrowgrenadepos(arm_offset, behaviortreeentity lastknownpos(behaviortreeentity.enemy));

  if(!isDefined(throw_vel)) {
    return false;
  }

  return true;
}

private civilianpreparetothrowgrenade(behaviortreeentity) {
  aiutility::keepclaimnode(behaviortreeentity);

  if(isDefined(behaviortreeentity.enemy)) {
    behaviortreeentity.grenadethrowposition = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
  }

  grenadethrowinfo = spawnStruct();
  grenadethrowinfo.grenadethrower = behaviortreeentity;
  grenadethrowinfo.grenadethrownat = behaviortreeentity.enemy;
  grenadethrowinfo.grenadethrownposition = behaviortreeentity.grenadethrowposition;
  blackboard::addblackboardevent("riot_grenade_throw", grenadethrowinfo, randomintrange(15000, 20000));
  grenadethrowinfo = spawnStruct();
  grenadethrowinfo.grenadethrowerteam = behaviortreeentity.team;
  blackboard::addblackboardevent("team_grenade_throw", grenadethrowinfo, randomintrange(8000, 12000));
  behaviortreeentity.preparegrenadeammo = behaviortreeentity.grenadeammo;
}

private civiliancleanuptothrowgrenade(behaviortreeentity) {
  aiutility::releaseclaimnode(behaviortreeentity);

  if(behaviortreeentity.preparegrenadeammo == behaviortreeentity.grenadeammo) {
    if(behaviortreeentity.health <= 0) {
      grenade = undefined;

      if(isactor(behaviortreeentity.enemy) && isDefined(behaviortreeentity.grenadeweapon)) {
        grenade = behaviortreeentity.enemy magicgrenadetype(behaviortreeentity.grenadeweapon, behaviortreeentity gettagorigin("j_wrist_ri"), (0, 0, 0), float(behaviortreeentity.grenadeweapon.aifusetime) / 1000);
      } else if(isplayer(behaviortreeentity.enemy) && isDefined(behaviortreeentity.grenadeweapon)) {
        grenade = behaviortreeentity.enemy magicgrenadeplayer(behaviortreeentity.grenadeweapon, behaviortreeentity gettagorigin("j_wrist_ri"), (0, 0, 0));
      }

      if(isDefined(grenade)) {
        grenade.owner = behaviortreeentity;
        grenade.team = behaviortreeentity.team;
        grenade setcontents(grenade setcontents(0)&~(32768 | 67108864 | 8388608 | 33554432));
      }
    }
  }
}

private rioterreaquireservice(entity) {
  if(entity getblackboardattribute(#"_civ_mode") != "riot") {
    return false;
  }

  if(!isDefined(entity.reacquire_state)) {
    entity.reacquire_state = 0;
  }

  if(!isDefined(entity.enemy)) {
    entity.reacquire_state = 0;
    return false;
  }

  if(entity haspath()) {
    return false;
  }

  if(entity seerecently(entity.enemy, 3)) {
    entity.reacquire_state = 0;
    return false;
  }

  dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
  forward = anglesToForward(entity.angles);

  if(vectordot(dirtoenemy, forward) < 0.5) {
    entity.reacquire_state = 0;
    return false;
  }

  switch (entity.reacquire_state) {
    case 0:
    case 1:
    case 2:
      step_size = 32 + entity.reacquire_state * 32;
      reacquirepos = entity reacquirestep(step_size);
      break;
    case 4:
      if(!entity cansee(entity.enemy) || !entity canshootenemy()) {
        entity flagenemyunattackable();
      }

      break;
    default:
      if(entity.reacquire_state > 15) {
        entity.reacquire_state = 0;
        return false;
      }

      break;
  }

  if(isvec(reacquirepos)) {
    entity function_a57c34b7(reacquirepos);
    entity.reacquire_state = 0;
    return true;
  }

  entity.reacquire_state++;
  return false;
}