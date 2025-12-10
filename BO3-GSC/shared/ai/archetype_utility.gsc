/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_utility.gsc
*************************************************/

#using scripts\shared\ai\archetype_aivsaimelee;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_state_machine;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\util_shared;
#namespace aiutility;

function autoexec registerbehaviorscriptfunctions() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("forceRagdoll", &forceragdoll);
  behaviortreenetworkutility::registerbehaviortreescriptapi("hasAmmo", &hasammo);
  behaviortreenetworkutility::registerbehaviortreescriptapi("hasLowAmmo", &haslowammo);
  behaviortreenetworkutility::registerbehaviortreescriptapi("hasEnemy", &hasenemy);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isSafeFromGrenades", &issafefromgrenades);
  behaviortreenetworkutility::registerbehaviortreescriptapi("inGrenadeBlastRadius", &ingrenadeblastradius);
  behaviortreenetworkutility::registerbehaviortreescriptapi("recentlySawEnemy", &recentlysawenemy);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldBeAggressive", &shouldbeaggressive);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldOnlyFireAccurately", &shouldonlyfireaccurately);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldReactToNewEnemy", &shouldreacttonewenemy);
  behaviorstatemachine::registerbsmscriptapiinternal("shouldReactToNewEnemy", &shouldreacttonewenemy);
  behaviortreenetworkutility::registerbehaviortreescriptapi("hasWeaponMalfunctioned", &hasweaponmalfunctioned);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStopMoving", &shouldstopmoving);
  behaviorstatemachine::registerbsmscriptapiinternal("shouldStopMoving", &shouldstopmoving);
  behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBestCoverNodeASAP", &choosebestcovernodeasap);
  behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBetterCoverService", &choosebettercoverservicecodeversion);
  behaviortreenetworkutility::registerbehaviortreescriptapi("trackCoverParamsService", &trackcoverparamsservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("refillAmmoIfNeededService", &refillammo);
  behaviortreenetworkutility::registerbehaviortreescriptapi("tryStoppingService", &trystoppingservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isFrustrated", &isfrustrated);
  behaviortreenetworkutility::registerbehaviortreescriptapi("updatefrustrationLevel", &updatefrustrationlevel);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isLastKnownEnemyPositionApproachable", &islastknownenemypositionapproachable);
  behaviortreenetworkutility::registerbehaviortreescriptapi("tryAdvancingOnLastKnownPositionBehavior", &tryadvancingonlastknownpositionbehavior);
  behaviortreenetworkutility::registerbehaviortreescriptapi("tryGoingToClosestNodeToEnemyBehavior", &trygoingtoclosestnodetoenemybehavior);
  behaviortreenetworkutility::registerbehaviortreescriptapi("tryRunningDirectlyToEnemyBehavior", &tryrunningdirectlytoenemybehavior);
  behaviortreenetworkutility::registerbehaviortreescriptapi("flagEnemyUnAttackableService", &flagenemyunattackableservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("keepClaimNode", &keepclaimnode);
  behaviorstatemachine::registerbsmscriptapiinternal("keepClaimNode", &keepclaimnode);
  behaviortreenetworkutility::registerbehaviortreescriptapi("releaseClaimNode", &releaseclaimnode);
  behaviortreenetworkutility::registerbehaviortreescriptapi("startRagdoll", &scriptstartragdoll);
  behaviortreenetworkutility::registerbehaviortreescriptapi("notStandingCondition", &notstandingcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("notCrouchingCondition", &notcrouchingcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("explosiveKilled", &explosivekilled);
  behaviortreenetworkutility::registerbehaviortreescriptapi("electrifiedKilled", &electrifiedkilled);
  behaviortreenetworkutility::registerbehaviortreescriptapi("burnedKilled", &burnedkilled);
  behaviortreenetworkutility::registerbehaviortreescriptapi("rapsKilled", &rapskilled);
  behaviortreenetworkutility::registerbehaviortreescriptapi("meleeAcquireMutex", &meleeacquiremutex);
  behaviortreenetworkutility::registerbehaviortreescriptapi("meleeReleaseMutex", &meleereleasemutex);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldMutexMelee", &shouldmutexmelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("prepareForExposedMelee", &prepareforexposedmelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupMelee", &cleanupmelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldNormalMelee", &shouldnormalmelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldMelee", &shouldmelee);
  behaviorstatemachine::registerbsmscriptapiinternal("shouldMelee", &shouldmelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("hasCloseEnemyMelee", &hascloseenemytomelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isBalconyDeath", &isbalconydeath);
  behaviortreenetworkutility::registerbehaviortreescriptapi("balconyDeath", &balconydeath);
  behaviortreenetworkutility::registerbehaviortreescriptapi("useCurrentPosition", &usecurrentposition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isUnarmed", &isunarmed);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChargeMelee", &shouldchargemelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldAttackInChargeMelee", &shouldattackinchargemelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupChargeMelee", &cleanupchargemelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupChargeMeleeAttack", &cleanupchargemeleeattack);
  behaviortreenetworkutility::registerbehaviortreescriptapi("setupChargeMeleeAttack", &setupchargemeleeattack);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialPain", &shouldchoosespecialpain);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialPronePain", &shouldchoosespecialpronepain);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialDeath", &shouldchoosespecialdeath);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialProneDeath", &shouldchoosespecialpronedeath);
  behaviortreenetworkutility::registerbehaviortreescriptapi("setupExplosionAnimScale", &setupexplosionanimscale);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStealth", &shouldstealth);
  behaviortreenetworkutility::registerbehaviortreescriptapi("stealthReactCondition", &stealthreactcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionShouldStealth", &locomotionshouldstealth);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStealthResume", &shouldstealthresume);
  behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldStealth", &locomotionshouldstealth);
  behaviorstatemachine::registerbsmscriptapiinternal("stealthReactCondition", &stealthreactcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("stealthReactStart", &stealthreactstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("stealthReactTerminate", &stealthreactterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("stealthIdleTerminate", &stealthidleterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isInPhalanx", &isinphalanx);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isInPhalanxStance", &isinphalanxstance);
  behaviortreenetworkutility::registerbehaviortreescriptapi("togglePhalanxStance", &togglephalanxstance);
  behaviortreenetworkutility::registerbehaviortreescriptapi("tookFlashbangDamage", &tookflashbangdamage);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isAtAttackObject", &isatattackobject);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldAttackObject", &shouldattackobject);
  behaviortreenetworkutility::registerbehaviortreeaction("defaultAction", undefined, undefined, undefined);
  archetype_aivsaimelee::registeraivsaimeleebehaviorfunctions();
}

function registerutilityblackboardattributes() {
  blackboard::registerblackboardattribute(self, "_arrival_stance", undefined, &bb_getarrivalstance);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_context", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_context2", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_cover_concealed", undefined, &bb_getcoverconcealed);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_cover_direction", "cover_front_direction", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_cover_mode", "cover_mode_none", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_cover_type", undefined, &bb_getcurrentcovernodetype);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_current_location_cover_type", undefined, &bb_getcurrentlocationcovernodetype);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_exposed_type", undefined, &bb_getcurrentexposedtype);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_damage_direction", undefined, &bb_getdamagedirection);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_damage_location", undefined, &bb_actorgetdamagelocation);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_damage_weapon_class", undefined, &bb_getdamageweaponclass);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_damage_weapon", undefined, &bb_getdamageweapon);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_damage_mod", undefined, &bb_getdamagemod);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_damage_taken", undefined, &bb_getdamagetaken);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_desired_stance", "stand", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_enemy", undefined, &bb_actorhasenemy);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_enemy_yaw", undefined, &bb_actorgetenemyyaw);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_react_yaw", undefined, &bb_actorgetreactyaw);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_fatal_damage_location", undefined, &bb_actorgetfataldamagelocation);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_fire_mode", undefined, &getfiremode);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_gib_location", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_juke_direction", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_juke_distance", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_arrival_distance", undefined, &bb_getlocomotionarrivaldistance);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_arrival_yaw", undefined, &bb_getlocomotionarrivalyaw);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_exit_yaw", undefined, &bb_getlocomotionexityaw);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_face_enemy_quadrant", "locomotion_face_enemy_none", &bb_getlocomotionfaceenemyquadrant);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_motion_angle", undefined, &bb_getlocomotionmotionangle);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_face_enemy_quadrant_previous", "locomotion_face_enemy_none", &bb_getlocomotionfaceenemyquadrantprevious);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_pain_type", undefined, &bb_getlocomotionpaintype);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_locomotion_turn_yaw", undefined, &bb_getlocomotionturnyaw);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_lookahead_angle", undefined, &bb_getlookaheadangle);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_patrol", undefined, &bb_actorispatroling);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_perfect_enemy_yaw", undefined, &bb_actorgetperfectenemyyaw);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_previous_cover_direction", "cover_front_direction", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_previous_cover_mode", "cover_mode_none", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_previous_cover_type", undefined, &bb_getpreviouscovernodetype);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_stance", "stand", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_traversal_type", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_melee_distance", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_tracking_turn_yaw", undefined, &bb_actorgettrackingturnyaw);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_weapon_class", "rifle", &bb_getweaponclass);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_throw_distance", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_yaw_to_cover", undefined, &bb_getyawtocovernode);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_special_death", "none", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_awareness", "combat", &bb_getawareness);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_awareness_prev", "combat", &bb_getawarenessprevious);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_melee_enemy_type", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_staircase_num_steps", 0, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_staircase_num_total_steps", 0, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_staircase_state", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_staircase_direction", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_staircase_exit_type", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_staircase_skip_num", undefined, &bb_getstairsnumskipsteps);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  self finalizetrackedblackboardattributes();
}

function private bb_getstairsnumskipsteps() {
  assert(isDefined(self._stairsstartnode) && isDefined(self._stairsendnode));
  numtotalsteps = blackboard::getblackboardattribute(self, "_staircase_num_total_steps");
  stepssofar = blackboard::getblackboardattribute(self, "_staircase_num_steps");
  direction = blackboard::getblackboardattribute(self, "_staircase_direction");
  numoutsteps = 2;
  totalstepswithoutout = numtotalsteps - numoutsteps;
  assert(stepssofar < totalstepswithoutout);
  remainingsteps = totalstepswithoutout - stepssofar;
  if(remainingsteps >= 8) {
    return "staircase_skip_8";
  }
  if(remainingsteps >= 6) {
    return "staircase_skip_6";
  }
  assert(remainingsteps >= 3);
  return "staircase_skip_3";
}

function private bb_getawareness() {
  if(!isDefined(self.stealth) || !isDefined(self.awarenesslevelcurrent)) {
    return "combat";
  }
  return self.awarenesslevelcurrent;
}

function private bb_getawarenessprevious() {
  if(!isDefined(self.stealth) || !isDefined(self.awarenesslevelprevious)) {
    return "combat";
  }
  return self.awarenesslevelprevious;
}

function private bb_getyawtocovernode() {
  if(!isDefined(self.node)) {
    return 0;
  }
  disttonodesqr = distance2dsquared(self getnodeoffsetposition(self.node), self.origin);
  if(isDefined(self.keepclaimednode) && self.keepclaimednode) {
    if(disttonodesqr > (64 * 64)) {
      return 0;
    }
  } else if(disttonodesqr > (24 * 24)) {
    return 0;
  }
  angletonode = ceil(angleclamp180(self.angles[1] - self getnodeoffsetangles(self.node)[1]));
  return angletonode;
}

function bb_gethigheststance() {
  if(self isatcovernodestrict() && self shouldusecovernode()) {
    higheststance = gethighestnodestance(self.node);
    return higheststance;
  }
  return blackboard::getblackboardattribute(self, "_stance");
}

function bb_getlocomotionfaceenemyquadrantprevious() {
  if(isDefined(self.prevrelativedir)) {
    direction = self.prevrelativedir;
    switch (direction) {
      case 0: {
        return "locomotion_face_enemy_none";
      }
      case 1: {
        return "locomotion_face_enemy_front";
      }
      case 2: {
        return "locomotion_face_enemy_right";
      }
      case 3: {
        return "locomotion_face_enemy_left";
      }
      case 4: {
        return "locomotion_face_enemy_back";
      }
    }
  }
  return "locomotion_face_enemy_none";
}

function bb_getcurrentcovernodetype() {
  return getcovertype(self.node);
}

function bb_getcoverconcealed() {
  if(iscoverconcealed(self.node)) {
    return "concealed";
  }
  return "unconcealed";
}

function bb_getcurrentlocationcovernodetype() {
  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < (48 * 48)) {
    return bb_getcurrentcovernodetype();
  }
  return bb_getpreviouscovernodetype();
}

function bb_getdamagedirection() {
  if(isDefined(level._debug_damage_direction)) {
    return level._debug_damage_direction;
  }
  if(self.damageyaw > 135 || self.damageyaw <= -135) {
    self.damage_direction = "front";
    return "front";
  }
  if(self.damageyaw > 45 && self.damageyaw <= 135) {
    self.damage_direction = "right";
    return "right";
  }
  if(self.damageyaw > -45 && self.damageyaw <= 45) {
    self.damage_direction = "back";
    return "back";
  }
  self.damage_direction = "left";
  return "left";
}

function bb_actorgetdamagelocation() {
  if(isDefined(level._debug_damage_pain_location)) {
    return level._debug_damage_pain_location;
  }
  shitloc = self.damagelocation;
  possiblehitlocations = array();
  if(isinarray(array("helmet", "head", "neck"), shitloc)) {
    possiblehitlocations[possiblehitlocations.size] = "head";
  }
  if(isinarray(array("torso_upper", "torso_mid"), shitloc)) {
    possiblehitlocations[possiblehitlocations.size] = "chest";
  }
  if(isinarray(array("torso_lower"), shitloc)) {
    possiblehitlocations[possiblehitlocations.size] = "groin";
  }
  if(isinarray(array("torso_lower"), shitloc)) {
    possiblehitlocations[possiblehitlocations.size] = "legs";
  }
  if(isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
    possiblehitlocations[possiblehitlocations.size] = "left_arm";
  }
  if(isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
    possiblehitlocations[possiblehitlocations.size] = "right_arm";
  }
  if(isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc)) {
    possiblehitlocations[possiblehitlocations.size] = "legs";
  }
  if(isDefined(self.lastdamagetime) && gettime() > self.lastdamagetime && gettime() <= (self.lastdamagetime + 1000)) {
    if(isDefined(self.lastdamagelocation)) {
      arrayremovevalue(possiblehitlocations, self.lastdamagelocation);
    }
  }
  if(possiblehitlocations.size == 0) {
    possiblehitlocations = undefined;
    possiblehitlocations = [];
    possiblehitlocations[0] = "chest";
    possiblehitlocations[1] = "groin";
  }
  assert(possiblehitlocations.size > 0, possiblehitlocations.size);
  damagelocation = possiblehitlocations[randomint(possiblehitlocations.size)];
  self.lastdamagelocation = damagelocation;
  return damagelocation;
}

function bb_getdamageweaponclass() {
  if(isDefined(self.damagemod)) {
    if(isinarray(array("mod_rifle_bullet"), tolower(self.damagemod))) {
      return "rifle";
    }
    if(isinarray(array("mod_pistol_bullet"), tolower(self.damagemod))) {
      return "pistol";
    }
    if(isinarray(array("mod_melee", "mod_melee_assassinate", "mod_melee_weapon_butt"), tolower(self.damagemod))) {
      return "melee";
    }
    if(isinarray(array("mod_grenade", "mod_grenade_splash", "mod_projectile", "mod_projectile_splash", "mod_explosive"), tolower(self.damagemod))) {
      return "explosive";
    }
  }
  return "rifle";
}

function bb_getdamageweapon() {
  if(isDefined(self.special_weapon) && isDefined(self.special_weapon.name)) {
    return self.special_weapon.name;
  }
  if(isDefined(self.damageweapon) && isDefined(self.damageweapon.name)) {
    return self.damageweapon.name;
  }
  return "unknown";
}

function bb_getdamagemod() {
  if(isDefined(self.damagemod)) {
    return tolower(self.damagemod);
  }
  return "unknown";
}

function bb_getdamagetaken() {
  if(isDefined(level._debug_damage_intensity)) {
    return level._debug_damage_intensity;
  }
  damagetaken = self.damagetaken;
  maxhealth = self.maxhealth;
  damagetakentype = "light";
  if(isalive(self)) {
    ratio = damagetaken / self.maxhealth;
    if(ratio > 0.7) {
      damagetakentype = "heavy";
    }
    self.lastdamagetime = gettime();
  } else {
    ratio = damagetaken / self.maxhealth;
    if(ratio > 0.7) {
      damagetakentype = "heavy";
    }
  }
  return damagetakentype;
}

function addaioverridedamagecallback(entity, callback, addtofront) {
  assert(isentity(entity));
  assert(isfunctionptr(callback));
  assert(!isDefined(entity.aioverridedamage) || isarray(entity.aioverridedamage));
  if(!isDefined(entity.aioverridedamage)) {
    entity.aioverridedamage = [];
  } else if(!isarray(entity.aioverridedamage)) {
    entity.aioverridedamage = array(entity.aioverridedamage);
  }
  if(isDefined(addtofront) && addtofront) {
    damageoverrides = [];
    damageoverrides[damageoverrides.size] = callback;
    foreach(override in entity.aioverridedamage) {
      damageoverrides[damageoverrides.size] = override;
    }
    entity.aioverridedamage = damageoverrides;
  } else {
    if(!isDefined(entity.aioverridedamage)) {
      entity.aioverridedamage = [];
    } else if(!isarray(entity.aioverridedamage)) {
      entity.aioverridedamage = array(entity.aioverridedamage);
    }
    entity.aioverridedamage[entity.aioverridedamage.size] = callback;
  }
}

function removeaioverridedamagecallback(entity, callback) {
  assert(isentity(entity));
  assert(isfunctionptr(callback));
  assert(isarray(entity.aioverridedamage));
  currentdamagecallbacks = entity.aioverridedamage;
  entity.aioverridedamage = [];
  foreach(value in currentdamagecallbacks) {
    if(value != callback) {
      entity.aioverridedamage[entity.aioverridedamage.size] = value;
    }
  }
}

function clearaioverridedamagecallbacks(entity) {
  entity.aioverridedamage = [];
}

function addaioverridekilledcallback(entity, callback) {
  assert(isentity(entity));
  assert(isfunctionptr(callback));
  assert(!isDefined(entity.aioverridekilled) || isarray(entity.aioverridekilled));
  if(!isDefined(entity.aioverridekilled)) {
    entity.aioverridekilled = [];
  } else if(!isarray(entity.aioverridekilled)) {
    entity.aioverridekilled = array(entity.aioverridekilled);
  }
  entity.aioverridekilled[entity.aioverridekilled.size] = callback;
}

function actorgetpredictedyawtoenemy(entity, lookaheadtime) {
  if(isDefined(entity.predictedyawtoenemy) && isDefined(entity.predictedyawtoenemytime) && entity.predictedyawtoenemytime == gettime()) {
    return entity.predictedyawtoenemy;
  }
  selfpredictedpos = entity.origin;
  moveangle = entity.angles[1] + entity getmotionangle();
  selfpredictedpos = selfpredictedpos + (((cos(moveangle), sin(moveangle), 0) * 200) * lookaheadtime);
  yaw = (vectortoangles(entity lastknownpos(entity.enemy) - selfpredictedpos)[1]) - entity.angles[1];
  yaw = absangleclamp360(yaw);
  entity.predictedyawtoenemy = yaw;
  entity.predictedyawtoenemytime = gettime();
  return yaw;
}

function bb_actorispatroling() {
  entity = self;
  if(entity ai::has_behavior_attribute("patrol") && entity ai::get_behavior_attribute("patrol")) {
    return "patrol_enabled";
  }
  return "patrol_disabled";
}

function bb_actorhasenemy() {
  entity = self;
  if(isDefined(entity.enemy)) {
    return "has_enemy";
  }
  return "no_enemy";
}

function bb_actorgetenemyyaw() {
  enemy = self.enemy;
  if(!isDefined(enemy)) {
    return 0;
  }
  toenemyyaw = actorgetpredictedyawtoenemy(self, 0.2);
  return toenemyyaw;
}

function bb_actorgetperfectenemyyaw() {
  enemy = self.enemy;
  if(!isDefined(enemy)) {
    return 0;
  }
  toenemyyaw = (vectortoangles(enemy.origin - self.origin)[1]) - self.angles[1];
  toenemyyaw = absangleclamp360(toenemyyaw);
  recordenttext("" + toenemyyaw, self, (1, 0, 0), "");
  return toenemyyaw;
}

function bb_actorgetreactyaw() {
  result = 0;
  if(isDefined(self.react_yaw)) {
    result = self.react_yaw;
    self.react_yaw = undefined;
  } else {
    v_origin = self geteventpointofinterest();
    if(isDefined(v_origin)) {
      str_typename = self getcurrenteventtypename();
      e_originator = self getcurrenteventoriginator();
      if(str_typename == "bullet" && isDefined(e_originator)) {
        v_origin = e_originator.origin;
      }
      deltaorigin = v_origin - self.origin;
      deltaangles = vectortoangles(deltaorigin);
      result = absangleclamp360(self.angles[1] - deltaangles[1]);
    }
  }
  return result;
}

function bb_actorgetfataldamagelocation() {
  if(isDefined(level._debug_damage_location)) {
    return level._debug_damage_location;
  }
  shitloc = self.damagelocation;
  if(isDefined(shitloc)) {
    if(isinarray(array("helmet", "head", "neck"), shitloc)) {
      return "head";
    }
    if(isinarray(array("torso_upper", "torso_mid"), shitloc)) {
      return "chest";
    }
    if(isinarray(array("torso_lower"), shitloc)) {
      return "hips";
    }
    if(isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
      return "right_arm";
    }
    if(isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
      return "left_arm";
    }
    if(isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc)) {
      return "legs";
    }
  }
  randomlocs = array("chest", "hips");
  return randomlocs[randomint(randomlocs.size)];
}

function getangleusingdirection(direction) {
  directionyaw = vectortoangles(direction)[1];
  yawdiff = directionyaw - self.angles[1];
  yawdiff = yawdiff * 0.002777778;
  flooredyawdiff = floor(yawdiff + 0.5);
  turnangle = (yawdiff - flooredyawdiff) * 360;
  return absangleclamp360(turnangle);
}

function wasatcovernode() {
  if(isDefined(self.prevnode)) {
    if(self.prevnode.type == "Cover Left" || self.prevnode.type == "Cover Right" || self.prevnode.type == "Cover Pillar" || (self.prevnode.type == "Cover Stand" || self.prevnode.type == "Conceal Stand") || (self.prevnode.type == "Cover Crouch" || self.prevnode.type == "Cover Crouch Window" || self.prevnode.type == "Conceal Crouch")) {
      return true;
    }
  }
  return false;
}

function bb_getlocomotionexityaw(blackboard, yaw) {
  exityaw = undefined;
  if(self haspath()) {
    predictedlookaheadinfo = self predictexit();
    status = predictedlookaheadinfo["path_prediction_status"];
    if(!isDefined(self.pathgoalpos)) {
      return -1;
    }
    if(distancesquared(self.origin, self.pathgoalpos) <= 4096) {
      return -1;
    }
    if(status == 3) {
      start = self.origin;
      end = start + vectorscale((0, predictedlookaheadinfo["path_prediction_travel_vector"][1], 0), 100);
      angletoexit = vectortoangles(predictedlookaheadinfo["path_prediction_travel_vector"])[1];
      exityaw = absangleclamp360(angletoexit - self.prevnode.angles[1]);
    } else {
      if(status == 4) {
        start = self.origin;
        end = start + vectorscale((0, predictedlookaheadinfo["path_prediction_travel_vector"][1], 0), 100);
        angletoexit = vectortoangles(predictedlookaheadinfo["path_prediction_travel_vector"])[1];
        exityaw = absangleclamp360(angletoexit - self.angles[1]);
      } else {
        if(status == 0) {
          if(wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
            end = self.pathgoalpos;
            angletodestination = vectortoangles(end - self.origin)[1];
            angledifference = absangleclamp360(angletodestination - self.prevnode.angles[1]);
            return angledifference;
          }
          start = predictedlookaheadinfo["path_prediction_start_point"];
          end = start + predictedlookaheadinfo["path_prediction_travel_vector"];
          exityaw = getangleusingdirection(predictedlookaheadinfo["path_prediction_travel_vector"]);
        } else if(status == 2) {
          if(distancesquared(self.origin, self.pathgoalpos) <= 4096) {
            return undefined;
          }
          if(wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
            end = self.pathgoalpos;
            angletodestination = vectortoangles(end - self.origin)[1];
            angledifference = absangleclamp360(angletodestination - self.prevnode.angles[1]);
            return angledifference;
          }
          start = self.origin;
          end = self.pathgoalpos;
          exityaw = getangleusingdirection(vectornormalize(end - start));
        }
      }
    }
  }
  if(isDefined(exityaw)) {
    record3dtext("" + int(exityaw), self.origin - vectorscale((0, 0, 1), 5), (1, 0, 0), "", undefined, 0.4);
  }
  return exityaw;
}

function bb_getlocomotionfaceenemyquadrant() {
  walkstring = getdvarstring("");
  switch (walkstring) {
    case "": {
      return "";
    }
    case "": {
      return "";
    }
    case "": {
      return "";
    }
  }
  if(isDefined(self.relativedir)) {
    direction = self.relativedir;
    switch (direction) {
      case 0: {
        return "locomotion_face_enemy_front";
      }
      case 1: {
        return "locomotion_face_enemy_front";
      }
      case 2: {
        return "locomotion_face_enemy_right";
      }
      case 3: {
        return "locomotion_face_enemy_left";
      }
      case 4: {
        return "locomotion_face_enemy_back";
      }
    }
  }
  return "locomotion_face_enemy_front";
}

function bb_getlocomotionpaintype() {
  if(self haspath()) {
    predictedlookaheadinfo = self predictpath();
    status = predictedlookaheadinfo["path_prediction_status"];
    startpos = self.origin;
    furthestpointtowardsgoalclear = 1;
    if(status == 2) {
      furthestpointalongtowardsgoal = startpos + vectorscale(self.lookaheaddir, 300);
      furthestpointtowardsgoalclear = self findpath(startpos, furthestpointalongtowardsgoal, 0, 0) && self maymovetopoint(furthestpointalongtowardsgoal);
    }
    if(furthestpointtowardsgoalclear) {
      forwarddir = anglesToForward(self.angles);
      possiblepaintypes = [];
      endpos = startpos + vectorscale(forwarddir, 300);
      if(self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
        possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_long";
      }
      endpos = startpos + vectorscale(forwarddir, 200);
      if(self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
        possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_med";
      }
      endpos = startpos + vectorscale(forwarddir, 150);
      if(self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
        possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_short";
      }
      if(possiblepaintypes.size) {
        return array::random(possiblepaintypes);
      }
    }
  }
  return "locomotion_inplace_pain";
}

function bb_getlookaheadangle() {
  return absangleclamp360(vectortoangles(self.lookaheaddir)[1] - self.angles[1]);
}

function bb_getpreviouscovernodetype() {
  return getcovertype(self.prevnode);
}

function bb_actorgettrackingturnyaw() {
  pixbeginevent("BB_ActorGetTrackingTurnYaw");
  if(isDefined(self.enemy)) {
    predictedpos = undefined;
    if(distance2dsquared(self.enemy.origin, self.origin) < (180 * 180)) {
      predictedpos = self.enemy.origin;
      self.newenemyreaction = 0;
    } else if(!issentient(self.enemy) || (self lastknowntime(self.enemy) + 5000) >= gettime()) {
      predictedpos = self lastknownpos(self.enemy);
    }
    if(isDefined(predictedpos)) {
      turnyaw = absangleclamp360(self.angles[1] - (vectortoangles(predictedpos - self.origin)[1]));
      pixendevent();
      return turnyaw;
    }
  }
  pixendevent();
  return undefined;
}

function bb_getweaponclass() {
  return "rifle";
}

function notstandingcondition(behaviortreeentity) {
  if(blackboard::getblackboardattribute(behaviortreeentity, "_stance") != "stand") {
    return true;
  }
  return false;
}

function notcrouchingcondition(behaviortreeentity) {
  if(blackboard::getblackboardattribute(behaviortreeentity, "_stance") != "crouch") {
    return true;
  }
  return false;
}

function scriptstartragdoll(behaviortreeentity) {
  behaviortreeentity startragdoll();
}

function private prepareforexposedmelee(behaviortreeentity) {
  keepclaimnode(behaviortreeentity);
  meleeacquiremutex(behaviortreeentity);
  currentstance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
  if(isDefined(behaviortreeentity.enemy) && isDefined(behaviortreeentity.enemy.vehicletype) && issubstr(behaviortreeentity.enemy.vehicletype, "firefly")) {
    blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", "fireflyswarm");
  }
  if(currentstance == "crouch") {
    blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
  }
}

function isfrustrated(behaviortreeentity) {
  return isDefined(behaviortreeentity.frustrationlevel) && behaviortreeentity.frustrationlevel > 0;
}

function clampfrustration(frustrationlevel) {
  if(frustrationlevel > 4) {
    return 4;
  }
  if(frustrationlevel < 0) {
    return 0;
  }
  return frustrationlevel;
}

function updatefrustrationlevel(entity) {
  if(!entity isbadguy()) {
    return false;
  }
  if(!isDefined(entity.frustrationlevel)) {
    entity.frustrationlevel = 0;
  }
  if(!isDefined(entity.enemy)) {
    entity.frustrationlevel = 0;
    return false;
  }
  record3dtext("" + entity.frustrationlevel, entity.origin, (1, 0.5, 0), "");
  if(isactor(entity.enemy) || isplayer(entity.enemy)) {
    if(entity.aggressivemode) {
      if(!isDefined(entity.lastfrustrationboost)) {
        entity.lastfrustrationboost = gettime();
      }
      if((entity.lastfrustrationboost + 5000) < gettime()) {
        entity.frustrationlevel++;
        entity.lastfrustrationboost = gettime();
        entity.frustrationlevel = clampfrustration(entity.frustrationlevel);
      }
    }
    isawareofenemy = (gettime() - entity lastknowntime(entity.enemy)) < 10000;
    if(entity.frustrationlevel == 4) {
      hasseenenemy = entity seerecently(entity.enemy, 2);
    } else {
      hasseenenemy = entity seerecently(entity.enemy, 5);
    }
    hasattackedenemyrecently = entity attackedrecently(entity.enemy, 5);
    if(!isawareofenemy || isactor(entity.enemy)) {
      if(!hasseenenemy) {
        entity.frustrationlevel++;
      } else if(!hasattackedenemyrecently) {
        entity.frustrationlevel = entity.frustrationlevel + 2;
      }
      entity.frustrationlevel = clampfrustration(entity.frustrationlevel);
      return true;
    }
    if(hasattackedenemyrecently) {
      entity.frustrationlevel = entity.frustrationlevel - 2;
      entity.frustrationlevel = clampfrustration(entity.frustrationlevel);
      return true;
    }
    if(hasseenenemy) {
      entity.frustrationlevel--;
      entity.frustrationlevel = clampfrustration(entity.frustrationlevel);
      return true;
    }
  }
  return false;
}

function flagenemyunattackableservice(behaviortreeentity) {
  behaviortreeentity flagenemyunattackable();
}

function islastknownenemypositionapproachable(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy)) {
    lastknownpositionofenemy = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
    if(behaviortreeentity isingoal(lastknownpositionofenemy) && behaviortreeentity findpath(behaviortreeentity.origin, lastknownpositionofenemy, 1, 0)) {
      return true;
    }
  }
  return false;
}

function tryadvancingonlastknownpositionbehavior(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy)) {
    if(isDefined(behaviortreeentity.aggressivemode) && behaviortreeentity.aggressivemode) {
      lastknownpositionofenemy = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
      if(behaviortreeentity isingoal(lastknownpositionofenemy) && behaviortreeentity findpath(behaviortreeentity.origin, lastknownpositionofenemy, 1, 0)) {
        behaviortreeentity useposition(lastknownpositionofenemy, lastknownpositionofenemy);
        setnextfindbestcovertime(behaviortreeentity, undefined);
        return true;
      }
    }
  }
  return false;
}

function trygoingtoclosestnodetoenemybehavior(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy)) {
    closestrandomnode = behaviortreeentity findbestcovernodes(behaviortreeentity.engagemaxdist, behaviortreeentity.enemy.origin)[0];
    if(isDefined(closestrandomnode) && behaviortreeentity isingoal(closestrandomnode.origin) && behaviortreeentity findpath(behaviortreeentity.origin, closestrandomnode.origin, 1, 0)) {
      usecovernodewrapper(behaviortreeentity, closestrandomnode);
      return true;
    }
  }
  return false;
}

function tryrunningdirectlytoenemybehavior(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy) && (isDefined(behaviortreeentity.aggressivemode) && behaviortreeentity.aggressivemode)) {
    origin = behaviortreeentity.enemy.origin;
    if(behaviortreeentity isingoal(origin) && behaviortreeentity findpath(behaviortreeentity.origin, origin, 1, 0)) {
      behaviortreeentity useposition(origin, origin);
      setnextfindbestcovertime(behaviortreeentity, undefined);
      return true;
    }
  }
  return false;
}

function shouldreacttonewenemy(behaviortreeentity) {
  return false;
}

function hasweaponmalfunctioned(behaviortreeentity) {
  return isDefined(behaviortreeentity.malfunctionreaction) && behaviortreeentity.malfunctionreaction;
}

function issafefromgrenades(entity) {
  if(isDefined(entity.grenade) && isDefined(entity.grenade.weapon) && entity.grenade !== entity.knowngrenade && !entity issafefromgrenade()) {
    if(isDefined(entity.node)) {
      offsetorigin = entity getnodeoffsetposition(entity.node);
      percentradius = distance(entity.grenade.origin, offsetorigin);
      if(entity.grenadeawareness >= percentradius) {
        return true;
      }
    } else {
      percentradius = distance(entity.grenade.origin, entity.origin) / entity.grenade.weapon.explosionradius;
      if(entity.grenadeawareness >= percentradius) {
        return true;
      }
    }
    entity.knowngrenade = entity.grenade;
    return false;
  }
  return true;
}

function ingrenadeblastradius(entity) {
  return !entity issafefromgrenade();
}

function recentlysawenemy(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy) && behaviortreeentity seerecently(behaviortreeentity.enemy, 6)) {
    return true;
  }
  return false;
}

function shouldonlyfireaccurately(behaviortreeentity) {
  if(isDefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
    return true;
  }
  return false;
}

function shouldbeaggressive(behaviortreeentity) {
  if(isDefined(behaviortreeentity.aggressivemode) && behaviortreeentity.aggressivemode) {
    return true;
  }
  return false;
}

function usecovernodewrapper(behaviortreeentity, node) {
  samenode = behaviortreeentity.node === node;
  behaviortreeentity usecovernode(node);
  if(!samenode) {
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_mode_none");
    blackboard::setblackboardattribute(behaviortreeentity, "_previous_cover_mode", "cover_mode_none");
  }
  setnextfindbestcovertime(behaviortreeentity, node);
}

function setnextfindbestcovertime(behaviortreeentity, node) {
  behaviortreeentity.nextfindbestcovertime = behaviortreeentity getnextfindbestcovertime(behaviortreeentity.engagemindist, behaviortreeentity.engagemaxdist, behaviortreeentity.coversearchinterval);
}

function trackcoverparamsservice(behaviortreeentity) {
  if(isDefined(behaviortreeentity.node) && behaviortreeentity isatcovernodestrict() && behaviortreeentity shouldusecovernode()) {
    if(!isDefined(behaviortreeentity.covernode)) {
      behaviortreeentity.covernode = behaviortreeentity.node;
      setnextfindbestcovertime(behaviortreeentity, behaviortreeentity.node);
    }
    return;
  }
  behaviortreeentity.covernode = undefined;
}

function choosebestcovernodeasap(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }
  node = getbestcovernodeifavailable(behaviortreeentity);
  if(isDefined(node)) {
    usecovernodewrapper(behaviortreeentity, node);
  }
}

function shouldchoosebettercover(behaviortreeentity) {
  if(behaviortreeentity ai::has_behavior_attribute("stealth") && behaviortreeentity ai::get_behavior_attribute("stealth")) {
    return 0;
  }
  if(isDefined(behaviortreeentity.avoid_cover) && behaviortreeentity.avoid_cover) {
    return 0;
  }
  if(behaviortreeentity isinanybadplace()) {
    return 1;
  }
  if(isDefined(behaviortreeentity.enemy)) {
    shouldusecovernoderesult = 0;
    shouldbeboredatcurrentcover = 0;
    abouttoarriveatcover = 0;
    iswithineffectiverangealready = 0;
    islookingaroundforenemy = 0;
    if(behaviortreeentity shouldholdgroundagainstenemy()) {
      return 0;
    }
    if(behaviortreeentity haspath() && isDefined(behaviortreeentity.arrivalfinalpos) && isDefined(behaviortreeentity.pathgoalpos) && self.pathgoalpos == behaviortreeentity.arrivalfinalpos) {
      if(distancesquared(behaviortreeentity.origin, behaviortreeentity.arrivalfinalpos) < 4096) {
        abouttoarriveatcover = 1;
      }
    }
    shouldusecovernoderesult = behaviortreeentity shouldusecovernode();
    if(self isatgoal()) {
      if(shouldusecovernoderesult && isDefined(behaviortreeentity.node) && self isatgoal()) {
        lastknownpos = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
        dist = distance2d(behaviortreeentity.origin, lastknownpos);
        if(dist > behaviortreeentity.engageminfalloffdist && dist <= behaviortreeentity.engagemaxfalloffdist) {
          iswithineffectiverangealready = 1;
        }
      }
      shouldbeboredatcurrentcover = !iswithineffectiverangealready && behaviortreeentity isatcovernode() && gettime() > self.nextfindbestcovertime;
      if(!shouldusecovernoderesult) {
        if(isDefined(behaviortreeentity.frustrationlevel) && behaviortreeentity.frustrationlevel > 0 && behaviortreeentity haspath()) {
          islookingaroundforenemy = 1;
        }
      }
    }
    shouldlookforbettercover = !islookingaroundforenemy && !abouttoarriveatcover && !iswithineffectiverangealready && (!shouldusecovernoderesult || shouldbeboredatcurrentcover || !self isatgoal());
    if(shouldlookforbettercover) {
      color = (0, 1, 0);
    } else {
      color = (1, 0, 0);
    }
    recordenttext((((((((("" + shouldusecovernoderesult) + "") + islookingaroundforenemy) + "") + abouttoarriveatcover) + "") + iswithineffectiverangealready) + "") + shouldbeboredatcurrentcover, behaviortreeentity, color, "");
  } else {
    return !(behaviortreeentity shouldusecovernode() && behaviortreeentity isapproachinggoal());
  }
  return shouldlookforbettercover;
}

function choosebettercoverservicecodeversion(behaviortreeentity) {
  if(isDefined(behaviortreeentity.stealth) && behaviortreeentity ai::get_behavior_attribute("stealth")) {
    return false;
  }
  if(isDefined(behaviortreeentity.avoid_cover) && behaviortreeentity.avoid_cover) {
    return false;
  }
  if(isDefined(behaviortreeentity.knowngrenade)) {
    return false;
  }
  if(!issafefromgrenades(behaviortreeentity)) {
    behaviortreeentity.nextfindbestcovertime = 0;
  }
  newnode = behaviortreeentity choosebettercovernode();
  if(isDefined(newnode)) {
    usecovernodewrapper(behaviortreeentity, newnode);
    return true;
  }
  setnextfindbestcovertime(behaviortreeentity, undefined);
  return false;
}

function private choosebettercoverservice(behaviortreeentity) {
  shouldchoosebettercoverresult = shouldchoosebettercover(behaviortreeentity);
  if(shouldchoosebettercoverresult && !behaviortreeentity.keepclaimednode) {
    transitionrunning = behaviortreeentity asmistransitionrunning();
    substatepending = behaviortreeentity asmissubstatepending();
    transdecrunning = behaviortreeentity asmistransdecrunning();
    isbehaviortreeinrunningstate = behaviortreeentity getbehaviortreestatus() == 5;
    if(!transitionrunning && !substatepending && !transdecrunning && isbehaviortreeinrunningstate) {
      node = getbestcovernodeifavailable(behaviortreeentity);
      goingtodifferentnode = isDefined(node) && (!isDefined(behaviortreeentity.node) || node != behaviortreeentity.node);
      if(goingtodifferentnode) {
        usecovernodewrapper(behaviortreeentity, node);
        return true;
      }
      setnextfindbestcovertime(behaviortreeentity, undefined);
    }
  }
  return false;
}

function refillammo(behaviortreeentity) {
  if(behaviortreeentity.weapon != level.weaponnone) {
    behaviortreeentity.bulletsinclip = behaviortreeentity.weapon.clipsize;
  }
}

function hasammo(behaviortreeentity) {
  if(behaviortreeentity.bulletsinclip > 0) {
    return true;
  }
  return false;
}

function haslowammo(behaviortreeentity) {
  if(behaviortreeentity.weapon != level.weaponnone) {
    return behaviortreeentity.bulletsinclip < (behaviortreeentity.weapon.clipsize * 0.2);
  }
  return 0;
}

function hasenemy(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy)) {
    return true;
  }
  return false;
}

function getbestcovernodeifavailable(behaviortreeentity) {
  node = behaviortreeentity findbestcovernode();
  if(!isDefined(node)) {
    return undefined;
  }
  if(behaviortreeentity nearclaimnode()) {
    currentnode = self.node;
  }
  if(isDefined(currentnode) && node == currentnode) {
    return undefined;
  }
  if(isDefined(behaviortreeentity.covernode) && node == behaviortreeentity.covernode) {
    return undefined;
  }
  return node;
}

function getsecondbestcovernodeifavailable(behaviortreeentity) {
  if(isDefined(behaviortreeentity.fixednode) && behaviortreeentity.fixednode) {
    return undefined;
  }
  nodes = behaviortreeentity findbestcovernodes(behaviortreeentity.goalradius, behaviortreeentity.origin);
  if(nodes.size > 1) {
    node = nodes[1];
  }
  if(!isDefined(node)) {
    return undefined;
  }
  if(behaviortreeentity nearclaimnode()) {
    currentnode = self.node;
  }
  if(isDefined(currentnode) && node == currentnode) {
    return undefined;
  }
  if(isDefined(behaviortreeentity.covernode) && node == behaviortreeentity.covernode) {
    return undefined;
  }
  return node;
}

function getcovertype(node) {
  if(isDefined(node)) {
    if(node.type == "Cover Pillar") {
      return "cover_pillar";
    }
    if(node.type == "Cover Left") {
      return "cover_left";
    }
    if(node.type == "Cover Right") {
      return "cover_right";
    }
    if(node.type == "Cover Stand" || node.type == "Conceal Stand") {
      return "cover_stand";
    }
    if(node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch") {
      return "cover_crouch";
    }
    if(node.type == "Exposed" || node.type == "Guard") {
      return "cover_exposed";
    }
  }
  return "cover_none";
}

function iscoverconcealed(node) {
  if(isDefined(node)) {
    return node.type == "Conceal Crouch" || node.type == "Conceal Stand";
  }
  return 0;
}

function canseeenemywrapper() {
  if(!isDefined(self.enemy)) {
    return 0;
  }
  if(!isDefined(self.node)) {
    return self cansee(self.enemy);
  }
  node = self.node;
  enemyeye = self.enemy getEye();
  yawtoenemy = angleclamp180(node.angles[1] - (vectortoangles(enemyeye - node.origin)[1]));
  if(node.type == "Cover Left" || node.type == "Cover Right") {
    if(yawtoenemy > 60 || yawtoenemy < -60) {
      return 0;
    }
    if(isDefined(node.spawnflags) && (node.spawnflags & 4) == 4) {
      if(node.type == "Cover Left" && yawtoenemy > 10) {
        return 0;
      }
      if(node.type == "Cover Right" && yawtoenemy < -10) {
        return 0;
      }
    }
  }
  nodeoffset = (0, 0, 0);
  if(node.type == "Cover Pillar") {
    assert(!(isDefined(node.spawnflags) && (node.spawnflags & 2048) == 2048) || (!(isDefined(node.spawnflags) && (node.spawnflags & 1024) == 1024)));
    canseefromleft = 1;
    canseefromright = 1;
    nodeoffset = (-32, 3.7, 60);
    lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
    canseefromleft = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
    nodeoffset = (32, 3.7, 60);
    lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
    canseefromright = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
    return canseefromright || canseefromleft;
  }
  if(node.type == "Cover Left") {
    nodeoffset = (-36, 7, 63);
  } else {
    if(node.type == "Cover Right") {
      nodeoffset = (36, 7, 63);
    } else {
      if(node.type == "Cover Stand" || node.type == "Conceal Stand") {
        nodeoffset = (-3.7, -22, 63);
      } else if(node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch") {
        nodeoffset = (3.5, -12.5, 45);
      }
    }
  }
  lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
  if(sighttracepassed(lookfrompoint, enemyeye, 0, undefined)) {
    return 1;
  }
  return 0;
}

function calculatenodeoffsetposition(node, nodeoffset) {
  right = anglestoright(node.angles);
  forward = anglesToForward(node.angles);
  return (node.origin + vectorscale(right, nodeoffset[0])) + vectorscale(forward, nodeoffset[1]) + (0, 0, nodeoffset[2]);
}

function gethighestnodestance(node) {
  assert(isDefined(node));
  if(isDefined(node.spawnflags) && (node.spawnflags & 4) == 4) {
    return "stand";
  }
  if(isDefined(node.spawnflags) && (node.spawnflags & 8) == 8) {
    return "crouch";
  }
  if(isDefined(node.spawnflags) && (node.spawnflags & 16) == 16) {
    return "prone";
  }
  errormsg(((node.type + "") + node.origin) + "");
  if(node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch") {
    return "crouch";
  }
  return "stand";
}

function isstanceallowedatnode(stance, node) {
  assert(isDefined(stance));
  assert(isDefined(node));
  if(stance == "stand" && (isDefined(node.spawnflags) && (node.spawnflags & 4) == 4)) {
    return true;
  }
  if(stance == "crouch" && (isDefined(node.spawnflags) && (node.spawnflags & 8) == 8)) {
    return true;
  }
  if(stance == "prone" && (isDefined(node.spawnflags) && (node.spawnflags & 16) == 16)) {
    return true;
  }
  return false;
}

function trystoppingservice(behaviortreeentity) {
  if(behaviortreeentity shouldholdgroundagainstenemy()) {
    behaviortreeentity clearpath();
    behaviortreeentity.keepclaimednode = 1;
    return true;
  }
  behaviortreeentity.keepclaimednode = 0;
  return false;
}

function shouldstopmoving(behaviortreeentity) {
  if(behaviortreeentity shouldholdgroundagainstenemy()) {
    return true;
  }
  return false;
}

function setcurrentweapon(weapon) {
  self.weapon = weapon;
  self.weaponclass = weapon.weapclass;
  if(weapon != level.weaponnone) {
    assert(isDefined(weapon.worldmodel), ("" + weapon.name) + "");
  }
  self.weaponmodel = weapon.worldmodel;
}

function setprimaryweapon(weapon) {
  self.primaryweapon = weapon;
  self.primaryweaponclass = weapon.weapclass;
  if(weapon != level.weaponnone) {
    assert(isDefined(weapon.worldmodel), ("" + weapon.name) + "");
  }
}

function setsecondaryweapon(weapon) {
  self.secondaryweapon = weapon;
  self.secondaryweaponclass = weapon.weapclass;
  if(weapon != level.weaponnone) {
    assert(isDefined(weapon.worldmodel), ("" + weapon.name) + "");
  }
}

function keepclaimnode(behaviortreeentity) {
  behaviortreeentity.keepclaimednode = 1;
  return true;
}

function releaseclaimnode(behaviortreeentity) {
  behaviortreeentity.keepclaimednode = 0;
  return true;
}

function getaimyawtoenemyfromnode(behaviortreeentity, node, enemy) {
  return angleclamp180((vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[1]) - node.angles[1]);
}

function getaimpitchtoenemyfromnode(behaviortreeentity, node, enemy) {
  return angleclamp180((vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[0]) - node.angles[0]);
}

function choosefrontcoverdirection(behaviortreeentity) {
  coverdirection = blackboard::getblackboardattribute(behaviortreeentity, "_cover_direction");
  blackboard::setblackboardattribute(behaviortreeentity, "_previous_cover_direction", coverdirection);
  blackboard::setblackboardattribute(behaviortreeentity, "_cover_direction", "cover_front_direction");
}

function shouldtacticalwalk(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }
  if(ai::hasaiattribute(behaviortreeentity, "forceTacticalWalk") && ai::getaiattribute(behaviortreeentity, "forceTacticalWalk")) {
    return true;
  }
  if(ai::hasaiattribute(behaviortreeentity, "disablesprint") && !ai::getaiattribute(behaviortreeentity, "disablesprint")) {
    if(ai::hasaiattribute(behaviortreeentity, "sprint") && ai::getaiattribute(behaviortreeentity, "sprint")) {
      return false;
    }
  }
  goalpos = undefined;
  if(isDefined(behaviortreeentity.arrivalfinalpos)) {
    goalpos = behaviortreeentity.arrivalfinalpos;
  } else {
    goalpos = behaviortreeentity.pathgoalpos;
  }
  if(isDefined(behaviortreeentity.pathstartpos) && isDefined(goalpos)) {
    pathdist = distancesquared(behaviortreeentity.pathstartpos, goalpos);
    if(pathdist < 9216) {
      return true;
    }
  }
  if(behaviortreeentity shouldfacemotion()) {
    return false;
  }
  if(!behaviortreeentity issafefromgrenade()) {
    return false;
  }
  return true;
}

function shouldstealth(behaviortreeentity) {
  if(isDefined(behaviortreeentity.stealth)) {
    now = gettime();
    if(behaviortreeentity isinscriptedstate()) {
      return false;
    }
    if(behaviortreeentity hasvalidinterrupt("react")) {
      behaviortreeentity.stealth_react_last = now;
      return true;
    }
    if(isDefined(behaviortreeentity.stealth_reacting) && behaviortreeentity.stealth_reacting || (isDefined(behaviortreeentity.stealth_react_last) && (now - behaviortreeentity.stealth_react_last) < 250)) {
      return true;
    }
    if(behaviortreeentity ai::has_behavior_attribute("stealth") && behaviortreeentity ai::get_behavior_attribute("stealth")) {
      return true;
    }
  }
  return false;
}

function locomotionshouldstealth(behaviortreeentity) {
  if(!shouldstealth(behaviortreeentity)) {
    return false;
  }
  if(behaviortreeentity haspath()) {
    if(isDefined(behaviortreeentity.arrivalfinalpos) || isDefined(behaviortreeentity.pathgoalpos)) {
      haswait = isDefined(self.currentgoal) && isDefined(self.currentgoal.script_wait_min) && isDefined(self.currentgoal.script_wait_max);
      if(haswait) {
        haswait = self.currentgoal.script_wait_min > 0 || self.currentgoal.script_wait_max > 0;
      }
      if(haswait || !isDefined(self.currentgoal) || (isDefined(self.currentgoal) && isDefined(self.currentgoal.scriptbundlename))) {
        goalpos = undefined;
        if(isDefined(behaviortreeentity.arrivalfinalpos)) {
          goalpos = behaviortreeentity.arrivalfinalpos;
        } else {
          goalpos = behaviortreeentity.pathgoalpos;
        }
        goaldistsq = distancesquared(behaviortreeentity.origin, goalpos);
        if(goaldistsq <= 1936 && goaldistsq <= (behaviortreeentity.goalradius * behaviortreeentity.goalradius)) {
          return false;
        }
      }
    }
    return true;
  }
  return false;
}

function shouldstealthresume(behaviortreeentity) {
  if(!shouldstealth(behaviortreeentity)) {
    return false;
  }
  if(isDefined(behaviortreeentity.stealth_resume) && behaviortreeentity.stealth_resume) {
    behaviortreeentity.stealth_resume = undefined;
    return true;
  }
  return false;
}

function private stealthreactcondition(entity) {
  inscene = isDefined(self._o_scene) && isDefined(self._o_scene._str_state) && self._o_scene._str_state == "play";
  return !(isDefined(entity.stealth_reacting) && entity.stealth_reacting) && entity hasvalidinterrupt("react") && !inscene;
}

function private stealthreactstart(behaviortreeentity) {
  behaviortreeentity.stealth_reacting = 1;
}

function private stealthreactterminate(behaviortreeentity) {
  behaviortreeentity.stealth_reacting = undefined;
}

function private stealthidleterminate(behaviortreeentity) {
  behaviortreeentity notify("stealthidleterminate");
  if(isDefined(behaviortreeentity.stealth_resume_after_idle) && behaviortreeentity.stealth_resume_after_idle) {
    behaviortreeentity.stealth_resume_after_idle = undefined;
    behaviortreeentity.stealth_resume = 1;
  }
}

function locomotionshouldpatrol(behaviortreeentity) {
  if(shouldstealth(behaviortreeentity)) {
    return false;
  }
  if(behaviortreeentity haspath() && behaviortreeentity ai::has_behavior_attribute("patrol") && behaviortreeentity ai::get_behavior_attribute("patrol")) {
    return true;
  }
  return false;
}

function explosivekilled(behaviortreeentity) {
  if(blackboard::getblackboardattribute(behaviortreeentity, "_damage_weapon_class") == "explosive") {
    return true;
  }
  return false;
}

function private _dropriotshield(riotshieldinfo) {
  entity = self;
  entity shared::throwweapon(riotshieldinfo.weapon, riotshieldinfo.tag, 0);
  if(isDefined(entity)) {
    entity detach(riotshieldinfo.model, riotshieldinfo.tag);
  }
}

function attachriotshield(entity, riotshieldweapon, riotshieldmodel, riotshieldtag) {
  riotshield = spawnStruct();
  riotshield.weapon = riotshieldweapon;
  riotshield.tag = riotshieldtag;
  riotshield.model = riotshieldmodel;
  entity attach(riotshieldmodel, riotshield.tag);
  entity.riotshield = riotshield;
}

function dropriotshield(behaviortreeentity) {
  if(isDefined(behaviortreeentity.riotshield)) {
    riotshieldinfo = behaviortreeentity.riotshield;
    behaviortreeentity.riotshield = undefined;
    behaviortreeentity thread _dropriotshield(riotshieldinfo);
  }
}

function electrifiedkilled(behaviortreeentity) {
  if(behaviortreeentity.damageweapon.rootweapon.name == "shotgun_pump_taser") {
    return true;
  }
  if(blackboard::getblackboardattribute(behaviortreeentity, "_damage_mod") == "mod_electrocuted") {
    return true;
  }
  return false;
}

function burnedkilled(behaviortreeentity) {
  if(blackboard::getblackboardattribute(behaviortreeentity, "_damage_mod") == "mod_burned") {
    return true;
  }
  return false;
}

function rapskilled(behaviortreeentity) {
  if(isDefined(self.attacker) && isDefined(self.attacker.archetype) && self.attacker.archetype == "raps") {
    return true;
  }
  return false;
}

function meleeacquiremutex(behaviortreeentity) {
  if(isDefined(behaviortreeentity) && isDefined(behaviortreeentity.enemy)) {
    behaviortreeentity.melee = spawnStruct();
    behaviortreeentity.melee.enemy = behaviortreeentity.enemy;
    if(isplayer(behaviortreeentity.melee.enemy)) {
      if(!isDefined(behaviortreeentity.melee.enemy.meleeattackers)) {
        behaviortreeentity.melee.enemy.meleeattackers = 0;
      }
      behaviortreeentity.melee.enemy.meleeattackers++;
    }
  }
}

function meleereleasemutex(behaviortreeentity) {
  if(isDefined(behaviortreeentity.melee)) {
    if(isDefined(behaviortreeentity.melee.enemy)) {
      if(isplayer(behaviortreeentity.melee.enemy)) {
        if(isDefined(behaviortreeentity.melee.enemy.meleeattackers)) {
          behaviortreeentity.melee.enemy.meleeattackers = behaviortreeentity.melee.enemy.meleeattackers - 1;
          if(behaviortreeentity.melee.enemy.meleeattackers <= 0) {
            behaviortreeentity.melee.enemy.meleeattackers = undefined;
          }
        }
      }
    }
    behaviortreeentity.melee = undefined;
  }
}

function shouldmutexmelee(behaviortreeentity) {
  if(isDefined(behaviortreeentity.melee)) {
    return 0;
  }
  if(isDefined(behaviortreeentity.enemy)) {
    if(!isplayer(behaviortreeentity.enemy)) {
      if(isDefined(behaviortreeentity.enemy.melee)) {
        return 0;
      }
    } else {
      if(!sessionmodeiscampaigngame()) {
        return 1;
      }
      if(!isDefined(behaviortreeentity.enemy.meleeattackers)) {
        behaviortreeentity.enemy.meleeattackers = 0;
      }
      return behaviortreeentity.enemy.meleeattackers < 1;
    }
  }
  return 1;
}

function shouldnormalmelee(behaviortreeentity) {
  return hascloseenemytomelee(behaviortreeentity);
}

function shouldmelee(entity) {
  if(isDefined(entity.lastshouldmeleeresult) && !entity.lastshouldmeleeresult && (entity.lastshouldmeleechecktime + 50) >= gettime()) {
    return false;
  }
  entity.lastshouldmeleechecktime = gettime();
  entity.lastshouldmeleeresult = 0;
  if(!isDefined(entity.enemy)) {
    return false;
  }
  if(!entity.enemy.allowdeath) {
    return false;
  }
  if(!isalive(entity.enemy)) {
    return false;
  }
  if(!issentient(entity.enemy)) {
    return false;
  }
  if(isvehicle(entity.enemy) && (!(isDefined(entity.enemy.good_melee_target) && entity.enemy.good_melee_target))) {
    return false;
  }
  if(isplayer(entity.enemy) && entity.enemy getstance() == "prone") {
    return false;
  }
  chargedistsq = (isDefined(entity.melee_charge_rangesq) ? entity.melee_charge_rangesq : 140 * 140);
  if(distancesquared(entity.origin, entity.enemy.origin) > chargedistsq) {
    return false;
  }
  if(!shouldmutexmelee(entity)) {
    return false;
  }
  if(ai::hasaiattribute(entity, "can_melee") && !ai::getaiattribute(entity, "can_melee")) {
    return false;
  }
  if(ai::hasaiattribute(entity.enemy, "can_be_meleed") && !ai::getaiattribute(entity.enemy, "can_be_meleed")) {
    return false;
  }
  if(shouldnormalmelee(entity) || shouldchargemelee(entity)) {
    entity.lastshouldmeleeresult = 1;
    return true;
  }
  return false;
}

function hascloseenemytomelee(entity) {
  return hascloseenemytomeleewithrange(entity, 64 * 64);
}

function hascloseenemytomeleewithrange(entity, melee_range_sq) {
  assert(isDefined(entity.enemy));
  if(!entity cansee(entity.enemy)) {
    return 0;
  }
  predicitedposition = entity.enemy.origin + vectorscale(entity getenemyvelocity(), 0.25);
  distsq = distancesquared(entity.origin, predicitedposition);
  yawtoenemy = angleclamp180(entity.angles[1] - (vectortoangles(entity.enemy.origin - entity.origin)[1]));
  if(distsq <= (36 * 36)) {
    return abs(yawtoenemy) <= 40;
  }
  if(distsq <= melee_range_sq && entity maymovetopoint(entity.enemy.origin)) {
    return abs(yawtoenemy) <= 80;
  }
  return 0;
}

function shouldchargemelee(entity) {
  assert(isDefined(entity.enemy));
  currentstance = blackboard::getblackboardattribute(entity, "_stance");
  if(currentstance != "stand") {
    return 0;
  }
  if(isDefined(entity.nextchargemeleetime)) {
    if(gettime() < entity.nextchargemeleetime) {
      return 0;
    }
  }
  enemydistsq = distancesquared(entity.origin, entity.enemy.origin);
  if(enemydistsq < (64 * 64)) {
    return 0;
  }
  offset = entity.enemy.origin - ((vectornormalize(entity.enemy.origin - entity.origin)) * 36);
  chargedistsq = (isDefined(entity.melee_charge_rangesq) ? entity.melee_charge_rangesq : 140 * 140);
  if(enemydistsq < chargedistsq && entity maymovetopoint(offset, 1, 1)) {
    yawtoenemy = angleclamp180(entity.angles[1] - (vectortoangles(entity.enemy.origin - entity.origin)[1]));
    return abs(yawtoenemy) <= 80;
  }
  return 0;
}

function private shouldattackinchargemelee(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy)) {
    if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) < (74 * 74)) {
      yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - (vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]));
      if(abs(yawtoenemy) > 80) {
        return false;
      }
      return true;
    }
  }
}

function private setupchargemeleeattack(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy) && isDefined(behaviortreeentity.enemy.vehicletype) && issubstr(behaviortreeentity.enemy.vehicletype, "firefly")) {
    blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", "fireflyswarm");
  }
  meleeacquiremutex(behaviortreeentity);
  keepclaimnode(behaviortreeentity);
}

function private cleanupmelee(behaviortreeentity) {
  meleereleasemutex(behaviortreeentity);
  releaseclaimnode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", undefined);
}

function private cleanupchargemelee(behaviortreeentity) {
  behaviortreeentity.nextchargemeleetime = gettime() + 2000;
  blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", undefined);
  meleereleasemutex(behaviortreeentity);
  releaseclaimnode(behaviortreeentity);
  behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.75, 1.5));
}

function cleanupchargemeleeattack(behaviortreeentity) {
  meleereleasemutex(behaviortreeentity);
  releaseclaimnode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", undefined);
  behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.5, 1));
}

function private shouldchoosespecialpronepain(behaviortreeentity) {
  stance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
  return stance == "prone_back" || stance == "prone_front";
}

function private shouldchoosespecialpain(behaviortreeentity) {
  if(isDefined(behaviortreeentity.damageweapon)) {
    return behaviortreeentity.damageweapon.specialpain || isDefined(behaviortreeentity.special_weapon);
  }
  return 0;
}

function private shouldchoosespecialdeath(behaviortreeentity) {
  if(isDefined(behaviortreeentity.damageweapon)) {
    return behaviortreeentity.damageweapon.specialpain;
  }
  return 0;
}

function private shouldchoosespecialpronedeath(behaviortreeentity) {
  stance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
  return stance == "prone_back" || stance == "prone_front";
}

function private setupexplosionanimscale(entity, asmstatename) {
  self.animtranslationscale = 2;
  self asmsetanimationrate(0.7);
  return 4;
}

function isbalconydeath(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.node)) {
    return false;
  }
  if(!(behaviortreeentity.node.spawnflags & 1024 || behaviortreeentity.node.spawnflags & 2048)) {
    return false;
  }
  covermode = blackboard::getblackboardattribute(behaviortreeentity, "_cover_mode");
  if(covermode == "cover_alert" || covermode == "cover_mode_none") {
    return false;
  }
  if(isDefined(behaviortreeentity.node.script_balconydeathchance) && randomint(100) > (int(100 * behaviortreeentity.node.script_balconydeathchance))) {
    return false;
  }
  distsq = distancesquared(behaviortreeentity.origin, behaviortreeentity.node.origin);
  if(distsq > (16 * 16)) {
    return false;
  }
  if(isDefined(level.players) && level.players.size > 0) {
    closest_player = util::get_closest_player(behaviortreeentity.origin, level.players[0].team);
    if(isDefined(closest_player)) {
      if((abs(closest_player.origin[2] - behaviortreeentity.origin[2])) < 100) {
        distance2dfromplayersq = distance2dsquared(closest_player.origin, behaviortreeentity.origin);
        if(distance2dfromplayersq < (600 * 600)) {
          return false;
        }
      }
    }
  }
  self.b_balcony_death = 1;
  return true;
}

function balconydeath(behaviortreeentity) {
  behaviortreeentity.clamptonavmesh = 0;
  if(behaviortreeentity.node.spawnflags & 1024) {
    blackboard::setblackboardattribute(behaviortreeentity, "_special_death", "balcony");
  } else if(behaviortreeentity.node.spawnflags & 2048) {
    blackboard::setblackboardattribute(behaviortreeentity, "_special_death", "balcony_norail");
  }
}

function usecurrentposition(entity) {
  entity useposition(entity.origin);
}

function isunarmed(behaviortreeentity) {
  if(behaviortreeentity.weapon == level.weaponnone) {
    return true;
  }
  return false;
}

function forceragdoll(entity) {
  entity startragdoll();
}

function preshootlaserandglinton(ai) {
  self endon("death");
  if(!isDefined(ai.laserstatus)) {
    ai.laserstatus = 0;
  }
  sniper_glint = "lensflares/fx_lensflare_sniper_glint";
  while(true) {
    self waittill("about_to_fire");
    if(ai.laserstatus !== 1) {
      ai laseron();
      ai.laserstatus = 1;
      if(ai.team != "allies") {
        tag = ai gettagorigin("tag_glint");
        if(isDefined(tag)) {
          playFXOnTag(sniper_glint, ai, "tag_glint");
        } else {
          type = (isDefined(ai.classname) ? "" + ai.classname : "");
          println(("" + type) + "");
          playFXOnTag(sniper_glint, ai, "tag_eye");
        }
      }
    }
  }
}

function postshootlaserandglintoff(ai) {
  self endon("death");
  while(true) {
    self waittill("stopped_firing");
    if(ai.laserstatus === 1) {
      ai laseroff();
      ai.laserstatus = 0;
    }
  }
}

function private isinphalanx(entity) {
  return entity ai::get_behavior_attribute("phalanx");
}

function private isinphalanxstance(entity) {
  phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
  currentstance = blackboard::getblackboardattribute(entity, "_stance");
  switch (phalanxstance) {
    case "stand": {
      return currentstance == "stand";
    }
    case "crouch": {
      return currentstance == "crouch";
    }
  }
  return 1;
}

function private togglephalanxstance(entity) {
  phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
  switch (phalanxstance) {
    case "stand": {
      blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
      break;
    }
    case "crouch": {
      blackboard::setblackboardattribute(entity, "_desired_stance", "crouch");
      break;
    }
  }
}

function private tookflashbangdamage(entity) {
  if(isDefined(entity.damageweapon) && isDefined(entity.damagemod)) {
    weapon = entity.damageweapon;
    return entity.damagemod == "MOD_GRENADE_SPLASH" && isDefined(weapon.rootweapon) && (issubstr(weapon.rootweapon.name, "flash_grenade") || issubstr(weapon.rootweapon.name, "concussion_grenade") || issubstr(weapon.rootweapon.name, "proximity_grenade"));
  }
  return 0;
}

function isatattackobject(entity) {
  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1])) {
    return false;
  }
  if(isDefined(entity.attackable) && (isDefined(entity.attackable.is_active) && entity.attackable.is_active)) {
    if(!isDefined(entity.attackable_slot)) {
      return false;
    }
    if(entity isatgoal()) {
      entity.is_at_attackable = 1;
      return true;
    }
  }
  return false;
}

function shouldattackobject(entity) {
  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1])) {
    return false;
  }
  if(isDefined(entity.attackable) && (isDefined(entity.attackable.is_active) && entity.attackable.is_active)) {
    if(isDefined(entity.is_at_attackable) && entity.is_at_attackable) {
      return true;
    }
  }
  return false;
}