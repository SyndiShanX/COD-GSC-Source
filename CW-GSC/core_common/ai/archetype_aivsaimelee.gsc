/****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_aivsaimelee.gsc
****************************************************/

#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace archetype_aivsaimelee;

function autoexec main() {
  meleebundles = getscriptbundles("aiassassination");
  level._aivsai_meleebundles = [];

  foreach(meleebundle in meleebundles) {
    attacker_archetype = meleebundle.attackerarchetype;
    defender_archetype = meleebundle.defenderarchetype;
    attacker_variant = meleebundle.attackervariant;
    defender_variant = meleebundle.defendervariant;

    if(!isDefined(level._aivsai_meleebundles[attacker_archetype])) {
      level._aivsai_meleebundles[attacker_archetype] = [];
      level._aivsai_meleebundles[attacker_archetype][defender_archetype] = [];
      level._aivsai_meleebundles[attacker_archetype][defender_archetype][attacker_variant] = [];
    } else if(!isDefined(level._aivsai_meleebundles[attacker_archetype][defender_archetype])) {
      level._aivsai_meleebundles[attacker_archetype][defender_archetype] = [];
      level._aivsai_meleebundles[attacker_archetype][defender_archetype][attacker_variant] = [];
    } else if(!isDefined(level._aivsai_meleebundles[attacker_archetype][defender_archetype][attacker_variant])) {
      level._aivsai_meleebundles[attacker_archetype][defender_archetype][attacker_variant] = [];
    }

    level._aivsai_meleebundles[attacker_archetype][defender_archetype][attacker_variant][defender_variant] = meleebundle;
  }
}

function registeraivsaimeleebehaviorfunctions() {
  assert(isscriptfunctionptr(&hasaivsaienemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hasaivsaienemy", &hasaivsaienemy);
  assert(isscriptfunctionptr(&decideinitiator));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"decideinitiator", &decideinitiator);
  assert(isscriptfunctionptr(&isinitiator));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinitiator", &isinitiator);
  assert(isscriptfunctionptr(&hascloseaivsaienemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hascloseaivsaienemy", &hascloseaivsaienemy);
  assert(isscriptfunctionptr(&chooseaivsaimeleeanimations));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"chooseaivsaimeleeanimations", &chooseaivsaimeleeanimations);
  assert(isscriptfunctionptr(&iscloseenoughforaivsaimelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"iscloseenoughforaivsaimelee", &iscloseenoughforaivsaimelee);
  assert(isscriptfunctionptr(&haspotentalaivsaimeleeenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"haspotentalaivsaimeleeenemy", &haspotentalaivsaimeleeenemy);
  assert(!isDefined(&aivsaimeleeinitialize) || isscriptfunctionptr(&aivsaimeleeinitialize));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"aivsaimeleeaction", &aivsaimeleeinitialize, undefined, undefined);
}

function haspotentalaivsaimeleeenemy(behaviortreeentity) {
  if(!hasaivsaienemy(behaviortreeentity)) {
    return false;
  }

  if(!chooseaivsaimeleeanimations(behaviortreeentity)) {
    return false;
  }

  if(!hascloseaivsaienemy(behaviortreeentity)) {
    return true;
  }

  return false;
}

function iscloseenoughforaivsaimelee(behaviortreeentity) {
  if(!hasaivsaienemy(behaviortreeentity)) {
    return false;
  }

  if(!chooseaivsaimeleeanimations(behaviortreeentity)) {
    return false;
  }

  if(!hascloseaivsaienemy(behaviortreeentity)) {
    return false;
  }

  return true;
}

function private shouldaquiremutexonenemyforaivsaimelee(behaviortreeentity) {
  if(isPlayer(behaviortreeentity.enemy)) {
    return false;
  }

  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }

  if(isDefined(behaviortreeentity.meleeenemy) && behaviortreeentity.meleeenemy == behaviortreeentity.enemy) {
    return true;
  }

  if(isDefined(behaviortreeentity.enemy.meleeenemy) && behaviortreeentity.enemy.meleeenemy != behaviortreeentity) {
    return false;
  }

  return true;
}

function private hasaivsaienemy(behaviortreeentity) {
  enemy = behaviortreeentity.enemy;

  if(getdvarint(#"disable_aivsai_melee", 0)) {
    record3dtext("<dev string:x38>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(!isDefined(enemy)) {
    record3dtext("<dev string:x72>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(!(isalive(behaviortreeentity) && isalive(enemy))) {
    record3dtext("<dev string:x96>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(!isai(enemy) || !isactor(enemy)) {
    record3dtext("<dev string:xd0>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(isDefined(enemy.archetype)) {
    if(enemy.archetype != # "human" && enemy.archetype != # "human_riotshield" && enemy.archetype != # "robot") {
      record3dtext("<dev string:xff>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

      return false;
    }
  }

  if(enemy.team == behaviortreeentity.team) {
    record3dtext("<dev string:x13b>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(enemy isragdoll()) {
    record3dtext("<dev string:x16c>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(is_true(enemy.ignoreme)) {
    record3dtext("<dev string:x19b>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(is_true(enemy._ai_melee_markeddead)) {
    record3dtext("<dev string:x1ce>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(behaviortreeentity ai::has_behavior_attribute("can_initiateaivsaimelee") && !behaviortreeentity ai::get_behavior_attribute("can_initiateaivsaimelee")) {
    record3dtext("<dev string:x211>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(behaviortreeentity ai::has_behavior_attribute("can_melee") && !behaviortreeentity ai::get_behavior_attribute("can_melee")) {
    record3dtext("<dev string:x25a>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(enemy ai::has_behavior_attribute("can_be_meleed") && !enemy ai::get_behavior_attribute("can_be_meleed")) {
    record3dtext("<dev string:x295>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(distance2dsquared(behaviortreeentity.origin, enemy.origin) > 22500) {
    record3dtext("<dev string:x2cd>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    behaviortreeentity._ai_melee_initiator = undefined;
    return false;
  }

  forwardvec = vectornormalize(anglesToForward(behaviortreeentity.angles));
  rightvec = vectornormalize(anglestoright(behaviortreeentity.angles));
  toenemyvec = vectornormalize(enemy.origin - behaviortreeentity.origin);
  fdot = vectordot(toenemyvec, forwardvec);

  if(fdot < 0) {
    record3dtext("<dev string:x2f6>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(enemy isinscriptedstate()) {
    record3dtext("<dev string:x321>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  currentstance = behaviortreeentity getblackboardattribute("_stance");
  enemystance = enemy getblackboardattribute("_stance");

  if(currentstance != "stand" || enemystance != "stand") {
    record3dtext("<dev string:x354>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(!shouldaquiremutexonenemyforaivsaimelee(behaviortreeentity)) {
    record3dtext("<dev string:x38e>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(abs(behaviortreeentity.origin[2] - behaviortreeentity.enemy.origin[2]) > 16) {
    record3dtext("<dev string:x3c8>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  raisedenemyentorigin = (behaviortreeentity.enemy.origin[0], behaviortreeentity.enemy.origin[1], behaviortreeentity.enemy.origin[2] + 8);

  if(!behaviortreeentity maymovetopoint(raisedenemyentorigin, 0, 1, behaviortreeentity.enemy)) {
    record3dtext("<dev string:x3f5>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  if(isDefined(enemy.allowdeath) && !enemy.allowdeath) {
    if(isDefined(behaviortreeentity.allowdeath) && !behaviortreeentity.allowdeath) {
      record3dtext("<dev string:x41d>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

      self notify(#"failed_melee_mbs", {
        #entity: enemy
      });
      return false;
    }

    behaviortreeentity._ai_melee_attacker_loser = 1;
    return true;
  }

  return true;
}

function private decideinitiator(behaviortreeentity) {
  if(!isDefined(behaviortreeentity._ai_melee_initiator)) {
    if(!isDefined(behaviortreeentity.enemy._ai_melee_initiator)) {
      behaviortreeentity._ai_melee_initiator = 1;
      return true;
    }
  }

  return false;
}

function private isinitiator(behaviortreeentity) {
  if(!is_true(behaviortreeentity._ai_melee_initiator)) {
    return false;
  }

  return true;
}

function private hascloseaivsaienemy(behaviortreeentity) {
  if(!(isDefined(behaviortreeentity._ai_melee_animname) && isDefined(behaviortreeentity.enemy._ai_melee_animname))) {
    record3dtext("<dev string:x456>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  animationstartorigin = getstartorigin(behaviortreeentity.enemy gettagorigin("tag_sync"), behaviortreeentity.enemy gettagangles("tag_sync"), behaviortreeentity._ai_melee_animname);

  record3dtext("<dev string:x485>" + sqrt(900), behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
  record3dtext("<dev string:x4b7>" + distance(animationstartorigin, behaviortreeentity.origin), behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
  recordcircle(behaviortreeentity.enemy gettagorigin("<dev string:x4e0>"), 8, (1, 0, 0), "<dev string:x64>", behaviortreeentity);
  recordcircle(animationstartorigin, 8, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity);
  recordline(animationstartorigin, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity);

  if(distance2dsquared(behaviortreeentity.origin, animationstartorigin) <= 900) {
    return true;
  }

  if(behaviortreeentity haspath()) {
    selfpredictedpos = behaviortreeentity.origin;
    moveangle = behaviortreeentity.angles[1] + behaviortreeentity getmotionangle();
    selfpredictedpos += (cos(moveangle), sin(moveangle), 0) * 200 * 0.2;

    record3dtext("<dev string:x4ec>" + distance(selfpredictedpos, animationstartorigin), behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    if(distance2dsquared(selfpredictedpos, animationstartorigin) <= 900) {
      return true;
    }
  }

  return false;
}

function private chooseaivsaimeleeanimations(behaviortreeentity) {
  anglestoenemy = vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin);
  yawtoenemy = angleclamp180(behaviortreeentity.enemy.angles[1] - anglestoenemy[1]);

  record3dtext("<dev string:x51d>" + abs(yawtoenemy), behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

  behaviortreeentity._ai_melee_animname = undefined;
  behaviortreeentity.enemy._ai_melee_animname = undefined;
  attacker_variant = choosearchetypevariant(behaviortreeentity);
  defender_variant = choosearchetypevariant(behaviortreeentity.enemy);

  if(!aivsaimeleebundleexists(behaviortreeentity, attacker_variant, defender_variant)) {
    record3dtext("<dev string:x530>" + function_9e72a96(behaviortreeentity.archetype) + "<dev string:x566>" + behaviortreeentity.enemy.archetype + "<dev string:x566>" + attacker_variant + "<dev string:x566>" + defender_variant, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

    return false;
  }

  animbundle = level._aivsai_meleebundles[behaviortreeentity.archetype][behaviortreeentity.enemy.archetype][attacker_variant][defender_variant];

  if(is_true(behaviortreeentity._ai_melee_attacker_loser)) {
    record3dtext("<dev string:x56b>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
  }

  foundanims = 0;
  possiblemelees = [];

  if(abs(yawtoenemy) > 120) {
    if(isDefined(behaviortreeentity.__forceaiflipmelee)) {
      possiblemelees[possiblemelees.size] = &chooseaivsaimeleefrontflipanimations;
    } else if(isDefined(behaviortreeentity.__forceaiwrestlemelee)) {
      possiblemelees[possiblemelees.size] = &chooseaivsaimeleefrontwrestleanimations;
    } else {
      possiblemelees[possiblemelees.size] = &chooseaivsaimeleefrontflipanimations;
      possiblemelees[possiblemelees.size] = &chooseaivsaimeleefrontwrestleanimations;
    }
  } else if(abs(yawtoenemy) < 60) {
    possiblemelees[possiblemelees.size] = &chooseaivsaimeleebackanimations;
  } else {
    rightvec = vectornormalize(anglestoright(behaviortreeentity.enemy.angles));
    toattackervec = vectornormalize(behaviortreeentity.origin - behaviortreeentity.enemy.origin);
    rdot = vectordot(toattackervec, rightvec);

    if(rdot > 0) {
      possiblemelees[possiblemelees.size] = &chooseaivsaimeleerightanimations;
    } else {
      possiblemelees[possiblemelees.size] = &chooseaivsaimeleeleftanimations;
    }
  }

  if(possiblemelees.size > 0) {
    [[array::random(possiblemelees)]](behaviortreeentity, animbundle);
  }

  if(isDefined(behaviortreeentity._ai_melee_animname)) {
    debug_chosenmeleeanimations(behaviortreeentity);
    return true;
  }

  return false;
}

function private choosearchetypevariant(entity) {
  if(entity.archetype == # "robot") {
    robot_state = entity ai::get_behavior_attribute("rogue_control");

    if(isinarray(array("forced_level_1", "level_1", "level_0"), robot_state)) {
      return "regular";
    }

    if(isinarray(array("forced_level_2", "level_2", "level_3", "forced_level_3"), robot_state)) {
      return "melee";
    }
  }

  return "regular";
}

function private aivsaimeleebundleexists(behaviortreeentity, attacker_variant, defender_variant) {
  if(!isDefined(level._aivsai_meleebundles[behaviortreeentity.archetype])) {
    return false;
  } else if(!isDefined(level._aivsai_meleebundles[behaviortreeentity.archetype][behaviortreeentity.enemy.archetype])) {
    return false;
  } else if(!isDefined(level._aivsai_meleebundles[behaviortreeentity.archetype][behaviortreeentity.enemy.archetype][attacker_variant])) {
    return false;
  } else if(!isDefined(level._aivsai_meleebundles[behaviortreeentity.archetype][behaviortreeentity.enemy.archetype][attacker_variant][defender_variant])) {
    return false;
  }

  return true;
}

function aivsaimeleeinitialize(behaviortreeentity, asmstatename) {
  asmstatename.blockingpain = 1;
  asmstatename.enemy.blockingpain = 1;
  aiutility::meleeacquiremutex(asmstatename);
  asmstatename._ai_melee_opponent = asmstatename.enemy;
  asmstatename.enemy._ai_melee_opponent = asmstatename;

  if(is_true(asmstatename._ai_melee_attacker_loser)) {
    asmstatename._ai_melee_markeddead = 1;
    asmstatename.enemy thread playscriptedmeleeanimations();
  } else {
    asmstatename.enemy._ai_melee_markeddead = 1;
    asmstatename thread playscriptedmeleeanimations();
  }

  return 5;
}

function playscriptedmeleeanimations() {
  self endon(#"death");
  assert(isDefined(self._ai_melee_opponent));
  opponent = self._ai_melee_opponent;

  if(!(isalive(self) && isalive(opponent))) {
    record3dtext("<dev string:x599>", self.origin, (1, 0.5, 0), "<dev string:x64>", self, 0.4);

    return 0;
  }

  if(self isragdoll() || opponent isragdoll()) {
    record3dtext("<dev string:x5dc>", self.origin, (1, 0.5, 0), "<dev string:x64>", self, 0.4);

    return 0;
  }

  if(is_true(opponent._ai_melee_attacker_loser)) {
    opponent animscripted("aivsaimeleeloser", self gettagorigin("tag_sync"), self gettagangles("tag_sync"), opponent._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3);
    self animscripted("aivsaimeleewinner", self gettagorigin("tag_sync"), self gettagangles("tag_sync"), self._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3);

    recordcircle(self gettagorigin("<dev string:x4e0>"), 2, (1, 0.5, 0), "<dev string:x64>");
    recordline(self gettagorigin("<dev string:x4e0>"), opponent.origin, (1, 0.5, 0), "<dev string:x64>");
  } else {
    self animscripted("aivsaimeleewinner", opponent gettagorigin("tag_sync"), opponent gettagangles("tag_sync"), self._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3);
    opponent animscripted("aivsaimeleeloser", opponent gettagorigin("tag_sync"), opponent gettagangles("tag_sync"), opponent._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3);

    recordcircle(opponent gettagorigin("<dev string:x4e0>"), 2, (1, 0.5, 0), "<dev string:x64>");
    recordline(opponent gettagorigin("<dev string:x4e0>"), self.origin, (1, 0.5, 0), "<dev string:x64>");
  }

  opponent thread handledeath(opponent._ai_melee_animname, self);

  if(getdvarint(#"tu1_aivsaimeleedisablegib", 1)) {
    if(opponent ai::has_behavior_attribute("can_gib")) {
      opponent ai::set_behavior_attribute("can_gib", 0);
    }
  }

  self thread processinterrupteddeath();
  opponent thread processinterrupteddeath();
  self waittillmatch({
    #notetrack: "end"}, #"aivsaimeleewinner");
  self.fixedlinkyawonly = 0;
  aiutility::cleanupchargemeleeattack(self);

  if(is_true(self._ai_melee_attachedknife)) {
    self detach(#"wpn_t7_knife_combat_prop", "TAG_WEAPON_LEFT");
    self._ai_melee_attachedknife = 0;
  }

  self.blockingpain = 0;
  self._ai_melee_initiator = undefined;
  self notify(#"meleecompleted");
  self pathmode("move delayed", 1, 3);
}

function private chooseaivsaimeleefrontflipanimations(behaviortreeentity, animbundle) {
  record3dtext("<dev string:x61b>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

  assert(isDefined(animbundle));

  if(is_true(behaviortreeentity._ai_melee_attacker_loser)) {
    behaviortreeentity._ai_melee_animname = animbundle.attackerloserfrontanim;
    behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerfrontanim;
  } else {
    behaviortreeentity._ai_melee_animname = animbundle.attackerfrontanim;
    behaviortreeentity.enemy._ai_melee_animname = animbundle.victimfrontanim;
  }

  behaviortreeentity._ai_melee_animtype = 1;
  behaviortreeentity.enemy._ai_melee_animtype = 1;
}

function private chooseaivsaimeleefrontwrestleanimations(behaviortreeentity, animbundle) {
  record3dtext("<dev string:x61b>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

  assert(isDefined(animbundle));

  if(is_true(behaviortreeentity._ai_melee_attacker_loser)) {
    behaviortreeentity._ai_melee_animname = animbundle.attackerloseralternatefrontanim;
    behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinneralternatefrontanim;
  } else {
    behaviortreeentity._ai_melee_animname = animbundle.attackeralternatefrontanim;
    behaviortreeentity.enemy._ai_melee_animname = animbundle.victimalternatefrontanim;
  }

  behaviortreeentity._ai_melee_animtype = 0;
  behaviortreeentity.enemy._ai_melee_animtype = 0;
}

function private chooseaivsaimeleebackanimations(behaviortreeentity, animbundle) {
  record3dtext("<dev string:x641>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

  assert(isDefined(animbundle));

  if(is_true(behaviortreeentity._ai_melee_attacker_loser)) {
    behaviortreeentity._ai_melee_animname = animbundle.attackerloserbackanim;
    behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerbackanim;
  } else {
    behaviortreeentity._ai_melee_animname = animbundle.attackerbackanim;
    behaviortreeentity.enemy._ai_melee_animname = animbundle.victimbackanim;
  }

  behaviortreeentity._ai_melee_animtype = 2;
  behaviortreeentity.enemy._ai_melee_animtype = 2;
}

function private chooseaivsaimeleerightanimations(behaviortreeentity, animbundle) {
  record3dtext("<dev string:x666>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

  assert(isDefined(animbundle));

  if(is_true(behaviortreeentity._ai_melee_attacker_loser)) {
    behaviortreeentity._ai_melee_animname = animbundle.attackerloserrightanim;
    behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerrightanim;
  } else {
    behaviortreeentity._ai_melee_animname = animbundle.attackerrightanim;
    behaviortreeentity.enemy._ai_melee_animname = animbundle.victimrightanim;
  }

  behaviortreeentity._ai_melee_animtype = 3;
  behaviortreeentity.enemy._ai_melee_animtype = 3;
}

function private chooseaivsaimeleeleftanimations(behaviortreeentity, animbundle) {
  record3dtext("<dev string:x68c>", behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);

  assert(isDefined(animbundle));

  if(is_true(behaviortreeentity._ai_melee_attacker_loser)) {
    behaviortreeentity._ai_melee_animname = animbundle.attackerloserleftanim;
    behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerleftanim;
  } else {
    behaviortreeentity._ai_melee_animname = animbundle.attackerleftanim;
    behaviortreeentity.enemy._ai_melee_animname = animbundle.victimleftanim;
  }

  behaviortreeentity._ai_melee_animtype = 4;
  behaviortreeentity.enemy._ai_melee_animtype = 4;
}

function private debug_chosenmeleeanimations(behaviortreeentity) {
  if(isDefined(behaviortreeentity._ai_melee_animname) && isDefined(behaviortreeentity.enemy._ai_melee_animname)) {
    record3dtext("<dev string:x6b1>" + behaviortreeentity._ai_melee_animname, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
    record3dtext("<dev string:x6cc>" + behaviortreeentity.enemy._ai_melee_animname, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x64>", behaviortreeentity, 0.4);
  }
}

function handledeath(animationname, attacker) {
  self endon(#"death", #"interrupteddeath");
  self.skipdeath = 1;
  self.diedinscriptedanim = 1;
  totaltime = getanimlength(animationname);
  wait totaltime - 0.2;
  self killwrapper(attacker);
}

function processinterrupteddeath() {
  self endon(#"meleecompleted");
  assert(isDefined(self._ai_melee_opponent));
  opponent = self._ai_melee_opponent;

  if(!is_true(self.allowdeath)) {
    return;
  }

  self waittill(#"death");

  if(isDefined(self) && is_true(self._ai_melee_attachedknife)) {
    self detach(#"wpn_t7_knife_combat_prop", "TAG_WEAPON_LEFT");
  }

  if(isalive(opponent)) {
    if(is_true(opponent._ai_melee_markeddead)) {
      opponent.diedinscriptedanim = 1;
      opponent.skipdeath = 1;
      opponent notify(#"interrupteddeath");
      opponent notify(#"meleecompleted");
      opponent stopanimscripted();
      opponent killwrapper();
      opponent startragdoll();
    } else {
      opponent._ai_melee_initiator = undefined;
      opponent.blockingpain = 0;
      opponent._ai_melee_markeddead = undefined;
      opponent.skipdeath = 0;
      opponent.diedinscriptedanim = 0;
      aiutility::cleanupchargemeleeattack(opponent);
      opponent notify(#"interrupteddeath");
      opponent notify(#"meleecompleted");
      opponent stopanimscripted();
    }
  }

  if(isDefined(self)) {
    self.diedinscriptedanim = 1;
    self.skipdeath = 1;
    self notify(#"interrupteddeath");
    self stopanimscripted();
    self killwrapper();
    self startragdoll();
  }
}

function killwrapper(attacker) {
  if(isDefined(self.overrideactordamage)) {
    self.overrideactordamage = undefined;
  }

  self.tokubetsukogekita = undefined;

  if(isDefined(attacker) && util::function_fbce7263(self.team, attacker.team)) {
    self kill(self.origin, attacker);
    return;
  }

  self kill();
}