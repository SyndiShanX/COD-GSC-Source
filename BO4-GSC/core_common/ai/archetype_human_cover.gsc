/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_human_cover.gsc
****************************************************/

#include scripts\core_common\ai\archetype_cover_utility;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\ai_blackboard;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\laststand_shared;

#namespace archetype_human_cover;

autoexec registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&shouldreturntocovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldreturntocovercondition", &shouldreturntocovercondition);
  assert(isscriptfunctionptr(&shouldreturntosuppressedcover));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldreturntosuppressedcover", &shouldreturntosuppressedcover);
  assert(isscriptfunctionptr(&shouldadjusttocover));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldadjusttocover", &shouldadjusttocover);
  assert(isscriptfunctionptr(&prepareforadjusttocover));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"prepareforadjusttocover", &prepareforadjusttocover);
  assert(isscriptfunctionptr(&coverblindfireshootactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverblindfireshootstart", &coverblindfireshootactionstart);
  assert(isscriptfunctionptr(&canchangestanceatcovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"canchangestanceatcovercondition", &canchangestanceatcovercondition);
  assert(isscriptfunctionptr(&coverchangestanceactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverchangestanceactionstart", &coverchangestanceactionstart);
  assert(isscriptfunctionptr(&preparetochangestancetostand));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"preparetochangestancetostand", &preparetochangestancetostand);
  assert(isscriptfunctionptr(&cleanupchangestancetostand));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchangestancetostand", &cleanupchangestancetostand);
  assert(isscriptfunctionptr(&preparetochangestancetocrouch));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"preparetochangestancetocrouch", &preparetochangestancetocrouch);
  assert(isscriptfunctionptr(&cleanupchangestancetocrouch));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchangestancetocrouch", &cleanupchangestancetocrouch);
  assert(isscriptfunctionptr(&shouldvantageatcovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldvantageatcovercondition", &shouldvantageatcovercondition);
  assert(isscriptfunctionptr(&supportsvantagecovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportsvantagecovercondition", &supportsvantagecovercondition);
  assert(isscriptfunctionptr(&covervantageinitialize));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"covervantageinitialize", &covervantageinitialize);
  assert(isscriptfunctionptr(&shouldthrowgrenadeatcovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldthrowgrenadeatcovercondition", &shouldthrowgrenadeatcovercondition);
  assert(isscriptfunctionptr(&coverpreparetothrowgrenade));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverpreparetothrowgrenade", &coverpreparetothrowgrenade);
  assert(isscriptfunctionptr(&covercleanuptothrowgrenade));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"covercleanuptothrowgrenade", &covercleanuptothrowgrenade);
  assert(isscriptfunctionptr(&sensenearbyplayers));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"sensenearbyplayers", &sensenearbyplayers);
  assert(isscriptfunctionptr(&function_f120d301));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5b614e766fc4d283", &function_f120d301);
  assert(isscriptfunctionptr(&function_ae382dda));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2078ca98b094c39", &function_ae382dda);
  assert(isscriptfunctionptr(&function_e17114c2));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_914aa2c9d4ad21c", &function_e17114c2);
  assert(isscriptfunctionptr(&switchtogrenadelauncher));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"switchtogrenadelauncher", &switchtogrenadelauncher);
  assert(isscriptfunctionptr(&switchtolightninggun));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"switchtolightninggun", &switchtolightninggun);
  assert(isscriptfunctionptr(&switchtoannihilator));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"switchtoannihilator", &switchtoannihilator);
}

shouldthrowgrenadeatcovercondition(entity, throwifpossible = 0) {
  if(isDefined(self.hero) && self.hero && isDefined(self.var_6fe3ea59) && self.var_6fe3ea59) {
    throwifpossible = 1;
  }

  if(isDefined(level.aidisablegrenadethrows) && level.aidisablegrenadethrows) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(!issentient(entity.enemy)) {
    return false;
  }

  if(isvehicle(entity.enemy) && isairborne(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.grenadeammo) && entity.grenadeammo <= 0) {
    return false;
  }

  if(ai::hasaiattribute(entity, "useGrenades") && !ai::getaiattribute(entity, "useGrenades")) {
    return false;
  }

  if(isplayer(entity.enemy) && entity.enemy laststand::player_is_in_laststand()) {
    return false;
  }

  entityangles = entity.angles;

  if(isDefined(entity.node) && (entity.node.type == #"cover left" || entity.node.type == #"cover right" || entity.node.type == #"cover pillar" || entity.node.type == #"cover stand" || entity.node.type == #"conceal stand" || entity.node.type == #"cover crouch" || entity.node.type == #"cover crouch window" || entity.node.type == #"conceal crouch") && entity isatcovernodestrict()) {
    entityangles = entity.node.angles;
  }

  toenemy = entity.enemy.origin - entity.origin;
  toenemy = vectornormalize((toenemy[0], toenemy[1], 0));
  entityforward = anglesToForward(entityangles);
  entityforward = vectornormalize((entityforward[0], entityforward[1], 0));

  if(vectordot(toenemy, entityforward) < 0.5) {
    return false;
  }

  if(!throwifpossible) {
    friendlyplayers = getplayers(entity.team);
    allplayers = getplayers();

    if(isDefined(friendlyplayers) && friendlyplayers.size) {
      foreach(player in friendlyplayers) {
        if(distancesquared(entity.enemy.origin, player.origin) <= 640000) {
          return false;
        }
      }
    }

    if(isDefined(allplayers) && allplayers.size) {
      foreach(player in allplayers) {
        if(isDefined(player) && player laststand::player_is_in_laststand() && distancesquared(entity.enemy.origin, player.origin) <= 640000) {
          return false;
        }
      }
    }

    grenadethrowinfos = blackboard::getblackboardevents("team_grenade_throw");

    foreach(grenadethrowinfo in grenadethrowinfos) {
      if(grenadethrowinfo.data.grenadethrowerteam === entity.team) {
        return false;
      }
    }

    grenadethrowinfos = blackboard::getblackboardevents("human_grenade_throw");

    foreach(grenadethrowinfo in grenadethrowinfos) {
      if(isDefined(grenadethrowinfo.data.grenadethrownat) && isalive(grenadethrowinfo.data.grenadethrownat)) {
        if(grenadethrowinfo.data.grenadethrower == entity) {
          return false;
        }

        if(isDefined(grenadethrowinfo.data.grenadethrownat) && grenadethrowinfo.data.grenadethrownat == entity.enemy) {
          return false;
        }

        if(isDefined(grenadethrowinfo.data.grenadethrownposition) && isDefined(entity.grenadethrowposition) && distancesquared(grenadethrowinfo.data.grenadethrownposition, entity.grenadethrowposition) <= 1440000) {
          return false;
        }
      }
    }
  }

  throw_dist = distance2dsquared(entity.origin, entity lastknownpos(entity.enemy));

  if(throw_dist < 500 * 500 || throw_dist > 1250 * 1250) {
    return false;
  }

  arm_offset = temp_get_arm_offset(entity, entity lastknownpos(entity.enemy));
  throw_vel = entity canthrowgrenadepos(arm_offset, entity lastknownpos(entity.enemy));

  if(!isDefined(throw_vel)) {
    return false;
  }

  return true;
}

private sensenearbyplayers(entity) {
  players = getplayers();

  foreach(player in players) {
    distancesq = distancesquared(player.origin, entity.origin);

    if(distancesq <= 360 * 360) {
      distancetoplayer = sqrt(distancesq);
      chancetodetect = randomfloat(1);

      if(chancetodetect < distancetoplayer / 360) {
        entity getperfectinfo(player);
      }
    }
  }
}

private coverpreparetothrowgrenade(entity) {
  aiutility::keepclaimednodeandchoosecoverdirection(entity);

  if(isDefined(entity.enemy)) {
    entity.grenadethrowposition = entity lastknownpos(entity.enemy);
  }

  grenadethrowinfo = spawnStruct();
  grenadethrowinfo.grenadethrower = entity;
  grenadethrowinfo.grenadethrownat = entity.enemy;
  grenadethrowinfo.grenadethrownposition = entity.grenadethrowposition;
  blackboard::addblackboardevent("human_grenade_throw", grenadethrowinfo, randomintrange(15000, 20000));
  grenadethrowinfo = spawnStruct();
  grenadethrowinfo.grenadethrowerteam = entity.team;
  blackboard::addblackboardevent("team_grenade_throw", grenadethrowinfo, randomintrange(8000, 12000));
  entity.preparegrenadeammo = entity.grenadeammo;
}

private covercleanuptothrowgrenade(entity) {
  aiutility::resetcoverparameters(entity);

  if(entity.preparegrenadeammo == entity.grenadeammo) {
    if(entity.health <= 0) {
      grenade = undefined;

      if(isactor(entity.enemy) && isDefined(entity.grenadeweapon)) {
        grenade = entity.enemy magicgrenadetype(entity.grenadeweapon, entity gettagorigin("j_wrist_ri"), (0, 0, 0), float(entity.grenadeweapon.aifusetime) / 1000);
      } else if(isplayer(entity.enemy) && isDefined(entity.grenadeweapon)) {
        grenade = entity.enemy magicgrenadeplayer(entity.grenadeweapon, entity gettagorigin("j_wrist_ri"), (0, 0, 0));
      }

      if(isDefined(grenade)) {
        grenade.owner = entity;
        grenade.team = entity.team;
        grenade setcontents(grenade setcontents(0)&~(32768 | 67108864 | 8388608 | 33554432));
      }
    }
  }
}

private canchangestanceatcovercondition(entity) {
  switch (entity getblackboardattribute("_stance")) {
    case #"stand":
      return aiutility::isstanceallowedatnode("crouch", entity.node);
    case #"crouch":
      return aiutility::isstanceallowedatnode("stand", entity.node);
  }

  return 0;
}

private shouldreturntosuppressedcover(entity) {
  if(!entity isatgoal()) {
    return true;
  }

  return false;
}

private shouldreturntocovercondition(entity) {
  if(entity asmistransitionrunning()) {
    return false;
  }

  if(isDefined(entity.covershootstarttime)) {
    if(gettime() < entity.covershootstarttime + 800) {
      return false;
    }

    if(isDefined(entity.enemy) && isplayer(entity.enemy) && entity.enemy.health < entity.enemy.maxhealth * 0.5) {
      if(gettime() < entity.covershootstarttime + 3000) {
        return false;
      }
    }
  }

  if(aiutility::issuppressedatcovercondition(entity)) {
    return true;
  }

  if(!entity isatgoal()) {
    if(isDefined(entity.node)) {
      offsetorigin = entity getnodeoffsetposition(entity.node);
      return !entity isposatgoal(offsetorigin);
    }

    return true;
  }

  if(!entity issafefromgrenade()) {
    return true;
  }

  return false;
}

private shouldadjusttocover(entity) {
  if(!isDefined(entity.node)) {
    return false;
  }

  highestsupportedstance = aiutility::gethighestnodestance(entity.node);
  currentstance = entity getblackboardattribute("_stance");

  if(currentstance == "crouch" && highestsupportedstance == "crouch") {
    return false;
  }

  covermode = entity getblackboardattribute("_cover_mode");
  previouscovermode = entity getblackboardattribute("_previous_cover_mode");

  if(covermode != "cover_alert" && previouscovermode != "cover_alert" && !entity.keepclaimednode) {
    return true;
  }

  if(!aiutility::isstanceallowedatnode(currentstance, entity.node)) {
    return true;
  }

  return false;
}

private shouldvantageatcovercondition(entity) {
  if(!isDefined(entity.node) || !isDefined(entity.node.type) || !isDefined(entity.enemy) || !isDefined(entity.enemy.origin)) {
    return 0;
  }

  yawtoenemyposition = aiutility::getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
  pitchtoenemyposition = aiutility::getaimpitchtoenemyfromnode(entity, entity.node, entity.enemy);
  aimlimitsforcover = entity getaimlimitsfromentry("cover_vantage");
  legalaim = 0;

  if(yawtoenemyposition < aimlimitsforcover[#"aim_left"] && yawtoenemyposition > aimlimitsforcover[#"aim_right"] && pitchtoenemyposition < 85 && pitchtoenemyposition > 25 && entity.node.origin[2] - entity.enemy.origin[2] >= 36) {
    legalaim = 1;
  }

  return legalaim;
}

private supportsvantagecovercondition(entity) {
  return false;
}

private covervantageinitialize(entity, asmstatename) {
  aiutility::keepclaimnode(entity);
  entity setblackboardattribute("_cover_mode", "cover_vantage");
}

private coverblindfireshootactionstart(entity, asmstatename) {
  aiutility::keepclaimnode(entity);
  entity setblackboardattribute("_cover_mode", "cover_blind");
  aiutility::choosecoverdirection(entity);
}

private preparetochangestancetostand(entity, asmstatename) {
  aiutility::cleanupcovermode(entity);
  entity setblackboardattribute("_desired_stance", "stand");
}

private cleanupchangestancetostand(entity, asmstatename) {
  aiutility::releaseclaimnode(entity);
  entity.newenemyreaction = 0;
}

private preparetochangestancetocrouch(entity, asmstatename) {
  aiutility::cleanupcovermode(entity);
  entity setblackboardattribute("_desired_stance", "crouch");
}

private cleanupchangestancetocrouch(entity, asmstatename) {
  aiutility::releaseclaimnode(entity);
  entity.newenemyreaction = 0;
}

private prepareforadjusttocover(entity, asmstatename) {
  aiutility::keepclaimnode(entity);
  highestsupportedstance = aiutility::gethighestnodestance(entity.node);
  entity setblackboardattribute("_desired_stance", highestsupportedstance);
}

private coverchangestanceactionstart(entity, asmstatename) {
  entity setblackboardattribute("_cover_mode", "cover_alert");
  aiutility::keepclaimnode(entity);

  switch (entity getblackboardattribute("_stance")) {
    case #"stand":
      entity setblackboardattribute("_desired_stance", "crouch");
      break;
    case #"crouch":
      entity setblackboardattribute("_desired_stance", "stand");
      break;
  }
}

temp_get_arm_offset(entity, throwposition) {
  stance = entity getblackboardattribute("_stance");
  arm_offset = undefined;

  if(stance == "crouch") {
    arm_offset = (13, -1, 56);
  } else {
    arm_offset = (14, -3, 80);
  }

  if(isDefined(entity.node) && entity isatcovernodestrict()) {
    if(entity.node.type == #"cover left") {
      if(stance == "crouch") {
        arm_offset = (-38, 15, 23);
      } else {
        arm_offset = (-45, 0, 40);
      }
    } else if(entity.node.type == #"cover right") {
      if(stance == "crouch") {
        arm_offset = (46, 12, 26);
      } else {
        arm_offset = (34, -21, 50);
      }
    } else if(entity.node.type == #"cover stand" || entity.node.type == #"conceal stand") {
      arm_offset = (10, 7, 77);
    } else if(entity.node.type == #"cover crouch" || entity.node.type == #"cover crouch window" || entity.node.type == #"conceal crouch") {
      arm_offset = (19, 5, 60);
    } else if(entity.node.type == #"cover pillar") {
      leftoffset = undefined;
      rightoffset = undefined;

      if(stance == "crouch") {
        leftoffset = (-20, 0, 35);
        rightoffset = (34, 6, 50);
      } else {
        leftoffset = (-24, 0, 76);
        rightoffset = (24, 0, 76);
      }

      if(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&1024) == 1024) {
        arm_offset = rightoffset;
      } else if(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&2048) == 2048) {
        arm_offset = leftoffset;
      } else {
        yawtoenemyposition = angleclamp180(vectortoangles(throwposition - entity.node.origin)[1] - entity.node.angles[1]);
        aimlimitsfordirectionright = entity getaimlimitsfromentry("pillar_right_lean");
        legalrightdirectionyaw = yawtoenemyposition >= aimlimitsfordirectionright[#"aim_right"] - 10 && yawtoenemyposition <= 0;

        if(legalrightdirectionyaw) {
          arm_offset = rightoffset;
        } else {
          arm_offset = leftoffset;
        }
      }
    }
  }

  return arm_offset;
}

private function_f120d301(entity) {
  return ai::hasaiattribute(entity, "useGrenadeLauncher") && ai::getaiattribute(entity, "useGrenadeLauncher");
}

private function_ae382dda(entity) {
  return ai::hasaiattribute(entity, "useLightningGun") && ai::getaiattribute(entity, "useLightningGun");
}

private function_e17114c2(entity) {
  return ai::hasaiattribute(entity, "useAnnihilator") && ai::getaiattribute(entity, "useAnnihilator");
}

private switchtogrenadelauncher(entity) {
  entity.blockingpain = 1;
  entity ai::gun_switchto("hero_pineapplegun", "right");
}

private switchtolightninggun(entity) {
  entity.blockingpain = 1;
  entity ai::gun_switchto("hero_lightninggun", "right");
}

private switchtoannihilator(entity) {
  entity.blockingpain = 1;
  entity ai::gun_switchto("hero_annihilator", "right");
}