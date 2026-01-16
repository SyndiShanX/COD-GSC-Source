/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_utility.gsc
************************************************/

#include scripts\core_common\ai\archetype_aivsaimelee;
#include scripts\core_common\ai\archetype_mocomps_utility;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\systems\shared;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;

#namespace aiutility;

autoexec registerbehaviorscriptfunctions() {
  assert(iscodefunctionptr(&btapi_forceragdoll));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_forceragdoll", &btapi_forceragdoll);
  assert(iscodefunctionptr(&btapi_hasammo));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_hasammo", &btapi_hasammo);
  assert(iscodefunctionptr(&btapi_haslowammo));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_haslowammo", &btapi_haslowammo);
  assert(iscodefunctionptr(&btapi_hasenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_hasenemy", &btapi_hasenemy);
  assert(iscodefunctionptr(&btapi_issafefromgrenades));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_issafefromgrenades", &btapi_issafefromgrenades);
  assert(isscriptfunctionptr(&issafefromgrenades));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"issafefromgrenades", &issafefromgrenades);
  assert(isscriptfunctionptr(&ingrenadeblastradius));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"ingrenadeblastradius", &ingrenadeblastradius);
  assert(isscriptfunctionptr(&recentlysawenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"recentlysawenemy", &recentlysawenemy);
  assert(isscriptfunctionptr(&shouldbeaggressive));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldbeaggressive", &shouldbeaggressive);
  assert(isscriptfunctionptr(&shouldonlyfireaccurately));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldonlyfireaccurately", &shouldonlyfireaccurately);
  assert(isscriptfunctionptr(&shouldreacttonewenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldreacttonewenemy", &shouldreacttonewenemy);
  assert(isscriptfunctionptr(&shouldreacttonewenemy));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldreacttonewenemy", &shouldreacttonewenemy);
  assert(isscriptfunctionptr(&hasweaponmalfunctioned));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hasweaponmalfunctioned", &hasweaponmalfunctioned);
  assert(isscriptfunctionptr(&shouldstopmoving));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstopmoving", &shouldstopmoving);
  assert(isscriptfunctionptr(&shouldstopmoving));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldstopmoving", &shouldstopmoving);
  assert(isscriptfunctionptr(&choosebestcovernodeasap));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"choosebestcovernodeasap", &choosebestcovernodeasap);
  assert(isscriptfunctionptr(&choosebettercoverservicecodeversion));
  behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBetterCoverService", &choosebettercoverservicecodeversion, 1);
  assert(iscodefunctionptr(&btapi_trackcoverparamsservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_trackcoverparamsservice", &btapi_trackcoverparamsservice);
  assert(isscriptfunctionptr(&trackcoverparamsservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"trackcoverparamsservice", &trackcoverparamsservice);
  assert(iscodefunctionptr(&btapi_refillammoifneededservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_refillammoifneededservice", &btapi_refillammoifneededservice);
  assert(isscriptfunctionptr(&refillammo));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"refillammoifneededservice", &refillammo);
  assert(isscriptfunctionptr(&trystoppingservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"trystoppingservice", &trystoppingservice);
  assert(isscriptfunctionptr(&isfrustrated));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isfrustrated", &isfrustrated);
  assert(iscodefunctionptr(&btapi_updatefrustrationlevel));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_updatefrustrationlevel", &btapi_updatefrustrationlevel);
  assert(isscriptfunctionptr(&updatefrustrationlevel));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"updatefrustrationlevel", &updatefrustrationlevel);
  assert(isscriptfunctionptr(&islastknownenemypositionapproachable));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"islastknownenemypositionapproachable", &islastknownenemypositionapproachable);
  assert(isscriptfunctionptr(&tryadvancingonlastknownpositionbehavior));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"tryadvancingonlastknownpositionbehavior", &tryadvancingonlastknownpositionbehavior);
  assert(isscriptfunctionptr(&trygoingtoclosestnodetoenemybehavior));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"trygoingtoclosestnodetoenemybehavior", &trygoingtoclosestnodetoenemybehavior);
  assert(isscriptfunctionptr(&tryrunningdirectlytoenemybehavior));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"tryrunningdirectlytoenemybehavior", &tryrunningdirectlytoenemybehavior);
  assert(isscriptfunctionptr(&flagenemyunattackableservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"flagenemyunattackableservice", &flagenemyunattackableservice);
  assert(isscriptfunctionptr(&keepclaimnode));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"keepclaimnode", &keepclaimnode);
  assert(isscriptfunctionptr(&keepclaimnode));
  behaviorstatemachine::registerbsmscriptapiinternal(#"keepclaimnode", &keepclaimnode);
  assert(isscriptfunctionptr(&releaseclaimnode));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"releaseclaimnode", &releaseclaimnode);
  assert(isscriptfunctionptr(&releaseclaimnode));
  behaviorstatemachine::registerbsmscriptapiinternal(#"releaseclaimnode", &releaseclaimnode);
  assert(isscriptfunctionptr(&scriptstartragdoll));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"startragdoll", &scriptstartragdoll);
  assert(isscriptfunctionptr(&notstandingcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"notstandingcondition", &notstandingcondition);
  assert(isscriptfunctionptr(&notcrouchingcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"notcrouchingcondition", &notcrouchingcondition);
  assert(isscriptfunctionptr(&meleeacquiremutex));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"meleeacquiremutex", &meleeacquiremutex);
  assert(isscriptfunctionptr(&meleereleasemutex));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"meleereleasemutex", &meleereleasemutex);
  assert(isscriptfunctionptr(&prepareforexposedmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"prepareforexposedmelee", &prepareforexposedmelee);
  assert(isscriptfunctionptr(&cleanupmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupmelee", &cleanupmelee);
  assert(iscodefunctionptr(&btapi_shouldnormalmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldnormalmelee", &btapi_shouldnormalmelee);
  assert(iscodefunctionptr(&btapi_shouldnormalmelee));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldnormalmelee", &btapi_shouldnormalmelee);
  assert(isscriptfunctionptr(&shouldnormalmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldnormalmelee", &shouldnormalmelee);
  assert(iscodefunctionptr(&btapi_shouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldmelee", &btapi_shouldmelee);
  assert(iscodefunctionptr(&btapi_shouldmelee));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldmelee", &btapi_shouldmelee);
  assert(isscriptfunctionptr(&shouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldmelee", &shouldmelee);
  assert(isscriptfunctionptr(&shouldmelee));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldmelee", &shouldmelee);
  assert(isscriptfunctionptr(&hascloseenemytomelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hascloseenemymelee", &hascloseenemytomelee);
  assert(isscriptfunctionptr(&isbalconydeath));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isbalconydeath", &isbalconydeath);
  assert(isscriptfunctionptr(&balconydeath));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"balconydeath", &balconydeath);
  assert(isscriptfunctionptr(&usecurrentposition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"usecurrentposition", &usecurrentposition);
  assert(isscriptfunctionptr(&isunarmed));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isunarmed", &isunarmed);
  assert(iscodefunctionptr(&btapi_shouldchargemelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldchargemelee", &btapi_shouldchargemelee);
  assert(isscriptfunctionptr(&shouldchargemelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchargemelee", &shouldchargemelee);
  assert(iscodefunctionptr(&btapi_shouldchargemelee));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldchargemelee", &btapi_shouldchargemelee);
  assert(isscriptfunctionptr(&shouldattackinchargemelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldattackinchargemelee", &shouldattackinchargemelee);
  assert(isscriptfunctionptr(&cleanupchargemelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchargemelee", &cleanupchargemelee);
  assert(isscriptfunctionptr(&cleanupchargemeleeattack));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchargemeleeattack", &cleanupchargemeleeattack);
  assert(isscriptfunctionptr(&setupchargemeleeattack));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"setupchargemeleeattack", &setupchargemeleeattack);
  assert(isscriptfunctionptr(&shouldchoosespecialpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpain", &shouldchoosespecialpain);
  assert(isscriptfunctionptr(&function_9b0e7a22));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_50fc16dcf1175197", &function_9b0e7a22);
  assert(isscriptfunctionptr(&shouldchoosespecialpronepain));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpronepain", &shouldchoosespecialpronepain);
  assert(isscriptfunctionptr(&function_89cb7bfd));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_78675d76c0c51e10", &function_89cb7bfd);
  assert(isscriptfunctionptr(&shouldchoosespecialdeath));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialdeath", &shouldchoosespecialdeath);
  assert(isscriptfunctionptr(&shouldchoosespecialpronedeath));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpronedeath", &shouldchoosespecialpronedeath);
  assert(isscriptfunctionptr(&setupexplosionanimscale));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"setupexplosionanimscale", &setupexplosionanimscale);
  assert(isscriptfunctionptr(&shouldstealth));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstealth", &shouldstealth);
  assert(isscriptfunctionptr(&stealthreactcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactcondition", &stealthreactcondition);
  assert(isscriptfunctionptr(&locomotionshouldstealth));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldstealth", &locomotionshouldstealth);
  assert(isscriptfunctionptr(&shouldstealthresume));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstealthresume", &shouldstealthresume);
  assert(isscriptfunctionptr(&locomotionshouldstealth));
  behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldstealth", &locomotionshouldstealth);
  assert(isscriptfunctionptr(&stealthreactcondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"stealthreactcondition", &stealthreactcondition);
  assert(isscriptfunctionptr(&stealthreactstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactstart", &stealthreactstart);
  assert(isscriptfunctionptr(&stealthreactterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactterminate", &stealthreactterminate);
  assert(isscriptfunctionptr(&stealthidleterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthidleterminate", &stealthidleterminate);
  assert(iscodefunctionptr(&btapi_isinphalanx));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_isinphalanx", &btapi_isinphalanx);
  assert(isscriptfunctionptr(&isinphalanx));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinphalanx", &isinphalanx);
  assert(isscriptfunctionptr(&isinphalanxstance));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinphalanxstance", &isinphalanxstance);
  assert(isscriptfunctionptr(&togglephalanxstance));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"togglephalanxstance", &togglephalanxstance);
  assert(isscriptfunctionptr(&isatattackobject));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatattackobject", &isatattackobject);
  assert(isscriptfunctionptr(&shouldattackobject));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldattackobject", &shouldattackobject);
  assert(isscriptfunctionptr(&generictryreacquireservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"generictryreacquireservice", &generictryreacquireservice);
  behaviortreenetworkutility::registerbehaviortreeaction(#"defaultaction", undefined, undefined, undefined);
  archetype_aivsaimelee::registeraivsaimeleebehaviorfunctions();
}

private bb_getstairsnumskipsteps() {
  assert(isDefined(self._stairsstartnode) && isDefined(self._stairsendnode));
  numtotalsteps = self getblackboardattribute("_staircase_num_total_steps");
  stepssofar = self getblackboardattribute("_staircase_num_steps");
  direction = self getblackboardattribute("_staircase_direction");
  numoutsteps = 2;
  totalstepswithoutout = numtotalsteps - numoutsteps;
  assert(stepssofar < totalstepswithoutout);
  remainingsteps = totalstepswithoutout - stepssofar;

  if(remainingsteps >= 8) {
    return "staircase_skip_8";
  } else if(remainingsteps >= 6) {
    return "staircase_skip_6";
  }

  assert(remainingsteps >= 3);
  return "staircase_skip_3";
}

private bb_gettraversalheight() {
  entity = self;
  startposition = entity.traversalstartpos;
  endposition = entity.traversalendpos;

  if(isDefined(entity.traveseheightoverride)) {
    record3dtext("<dev string:x38>" + entity.traveseheightoverride, self.origin + (0, 0, 32), (1, 0, 0), "<dev string:x4c>");

    return entity.traveseheightoverride;
  }

  if(isDefined(entity.traversemantlenode)) {
    pivotorigin = archetype_mocomps_utility::calculatepivotoriginfromedge(entity, entity.traversemantlenode, entity.origin);
    traversalheight = pivotorigin[2] - (isDefined(entity.var_fad2bca9) && entity.var_fad2bca9 && isDefined(entity.traversalstartpos) ? entity.traversalstartpos[2] : entity.origin[2]);

    record3dtext("<dev string:x38>" + traversalheight, self.origin + (0, 0, 32), (1, 0, 0), "<dev string:x4c>");

    return traversalheight;
  } else if(isDefined(startposition) && isDefined(endposition)) {
    traversalheight = endposition[2] - startposition[2];

    if(bb_getparametrictraversaltype() == "jump_across_traversal") {
      traversalheight = abs(traversalheight);
    }

    record3dtext("<dev string:x38>" + traversalheight, self.origin + (0, 0, 32), (1, 0, 0), "<dev string:x4c>");

    return traversalheight;
  }

  return 0;
}

private bb_gettraversalwidth() {
  entity = self;
  startposition = entity.traversalstartpos;
  endposition = entity.traversalendpos;

  if(isDefined(entity.travesewidthoverride)) {
    record3dtext("<dev string:x55>" + entity.travesewidthoverride, self.origin + (0, 0, 48), (1, 0, 0), "<dev string:x4c>");

    return entity.travesewidthoverride;
  }

  if(isDefined(startposition) && isDefined(endposition)) {
    var_d4b651b8 = distance2d(startposition, endposition);

    record3dtext("<dev string:x55>" + var_d4b651b8, self.origin + (0, 0, 48), (1, 0, 0), "<dev string:x4c>");

    return var_d4b651b8;
  }

  return 0;
}

function_a0d0fc27(entity, startnode, endnode, mantlenode) {
  assert(isDefined(startnode));
  assert(isDefined(endnode));
  assert(isDefined(mantlenode));

  if(!(isDefined(entity.var_20e07206) && entity.var_20e07206)) {
    return;
  }

  if(isDefined(mantlenode.uneven_mantle_traversal) && mantlenode.uneven_mantle_traversal) {
    return;
  }

  heightdiff = abs(endnode.origin[2] - startnode.origin[2]);

  if(heightdiff > 40) {
    mantlenode.uneven_mantle_traversal = 1;
  }
}

function_b882ba71(entity, startnode, endnode, mantlenode) {
  assert(isDefined(startnode));
  assert(isDefined(endnode));
  assert(isDefined(mantlenode));
  var_3efada15 = abs(startnode.origin[2] - mantlenode.origin[2]);
  var_6d4236a3 = abs(endnode.origin[2] - mantlenode.origin[2]);

  if(var_3efada15 > var_6d4236a3) {
    return var_3efada15;
  }

  return var_6d4236a3;
}

bb_getparametrictraversaltype() {
  entity = self;
  startposition = entity.traversalstartpos;
  endposition = entity.traversalendpos;

  if(sessionmodeiswarzonegame()) {
    entity.traveseheightoverride = undefined;
  }

  if(isDefined(entity.travesetypeoverride)) {
    return entity.travesetypeoverride;
  }

  if(!isDefined(entity.traversestartnode) || entity.traversestartnode.type != "Volume" || !isDefined(entity.traverseendnode) || entity.traverseendnode.type != "Volume") {
    return "unknown_traversal";
  }

  if(isDefined(entity.traversestartnode) && isDefined(entity.traversemantlenode)) {
    function_a0d0fc27(entity, entity.traversestartnode, entity.traverseendnode, entity.traversemantlenode);

    if(sessionmodeiswarzonegame() && isDefined(entity.traversemantlenode.uneven_mantle_traversal) && entity.traversemantlenode.uneven_mantle_traversal) {
      entity.traveseheightoverride = abs(function_b882ba71(entity, entity.traversestartnode, entity.traverseendnode, entity.traversemantlenode));
    }

    if(isDefined(entity.traversemantlenode.uneven_mantle_traversal) && entity.traversemantlenode.uneven_mantle_traversal && isDefined(entity.var_2c628c0f) && entity.var_2c628c0f) {
      isendpointaboveorsamelevel = startposition[2] < endposition[2];
      traversaltype = "jump_down_mantle_traversal";

      if(isendpointaboveorsamelevel) {
        traversaltype = "jump_up_mantle_traversal";
      }

      if(sessionmodeiswarzonegame()) {
        entity.traveseheightoverride = function_b882ba71(entity, entity.traversestartnode, entity.traverseendnode, entity.traversemantlenode);

        if(traversaltype == "jump_down_mantle_traversal") {
          entity.traveseheightoverride *= -1;
        }
      }

      return traversaltype;
    }

    return "mantle_traversal";
  }

  if(isDefined(startposition) && isDefined(endposition)) {
    traversaldistance = distance2d(startposition, endposition);
    isendpointaboveorsamelevel = startposition[2] <= endposition[2];

    if(traversaldistance >= 108 && abs(endposition[2] - startposition[2]) <= 100) {
      return "jump_across_traversal";
    }

    if(isendpointaboveorsamelevel) {
      if(isDefined(entity.traverseendnode.hanging_traversal) && entity.traverseendnode.hanging_traversal && isDefined(entity.var_1731eda3) && entity.var_1731eda3) {
        return "jump_up_hanging_traversal";
      } else {
        return "jump_up_traversal";
      }
    }

    return "jump_down_traversal";
  }

  return "unknown_traversal";
}

bb_getawareness() {
  return self.awarenesslevelcurrent;
}

bb_getawarenessprevious() {
  return self.awarenesslevelprevious;
}

function_cc26899f() {
  if(isDefined(self.zombie_move_speed)) {
    if(self.zombie_move_speed == "walk") {
      return "locomotion_speed_walk";
    } else if(self.zombie_move_speed == "run") {
      return "locomotion_speed_run";
    } else if(self.zombie_move_speed == "sprint") {
      return "locomotion_speed_sprint";
    } else if(self.zombie_move_speed == "super_sprint") {
      return "locomotion_speed_super_sprint";
    } else if(self.zombie_move_speed == "super_super_sprint") {
      return "locomotion_speed_super_super_sprint";
    }
  }

  return "locomotion_speed_walk";
}

private bb_getgibbedlimbs() {
  entity = self;
  rightarmgibbed = gibserverutils::isgibbed(entity, 16);
  leftarmgibbed = gibserverutils::isgibbed(entity, 32);

  if(rightarmgibbed && leftarmgibbed) {
    return "both_arms";
  } else if(rightarmgibbed) {
    return "right_arm";
  } else if(leftarmgibbed) {
    return "left_arm";
  }

  return "none";
}

private bb_getyawtocovernode() {
  if(!isDefined(self.node)) {
    return 0;
  }

  disttonodesqr = distance2dsquared(self getnodeoffsetposition(self.node), self.origin);

  if(isDefined(self.keepclaimednode) && self.keepclaimednode) {
    if(disttonodesqr > 64 * 64) {
      return 0;
    }
  } else if(disttonodesqr > 24 * 24) {
    return 0;
  }

  angletonode = ceil(angleclamp180(self.angles[1] - self getnodeoffsetangles(self.node)[1]));
  return angletonode;
}

bb_gethigheststance() {
  if(self isatcovernodestrict() && self shouldusecovernode()) {
    higheststance = gethighestnodestance(self.node);
    return higheststance;
  }

  return self getblackboardattribute("_stance");
}

bb_getlocomotionfaceenemyquadrantprevious() {
  if(isDefined(self.prevrelativedir)) {
    direction = self.prevrelativedir;

    switch (direction) {
      case 0:
        return "locomotion_face_enemy_none";
      case 1:
        return "locomotion_face_enemy_front";
      case 2:
        return "locomotion_face_enemy_right";
      case 3:
        return "locomotion_face_enemy_left";
      case 4:
        return "locomotion_face_enemy_back";
    }
  }

  return "locomotion_face_enemy_none";
}

bb_getcurrentcovernodetype() {
  return getcovertype(self.node);
}

bb_getcoverconcealed() {
  if(iscoverconcealed(self.node)) {
    return "concealed";
  }

  return "unconcealed";
}

bb_getcurrentlocationcovernodetype() {
  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 48 * 48) {
    return bb_getcurrentcovernodetype();
  }

  return bb_getpreviouscovernodetype();
}

bb_getshouldturn() {
  if(isDefined(self.should_turn) && self.should_turn) {
    return "should_turn";
  }

  return "should_not_turn";
}

bb_getarmsposition() {
  if(isDefined(self.zombie_arms_position)) {
    if(self.zombie_arms_position == "up") {
      return "arms_up";
    }

    return "arms_down";
  }

  return "arms_up";
}

bb_gethaslegsstatus() {
  if(self.missinglegs) {
    return "has_legs_no";
  }

  return "has_legs_yes";
}

function_f61d3341() {
  if(gibserverutils::isgibbed(self, 256)) {
    return "has_left_leg_no";
  }

  return "has_left_leg_yes";
}

function_9b395e55() {
  if(gibserverutils::isgibbed(self, 128)) {
    return "has_right_leg_no";
  }

  return "has_right_leg_yes";
}

function_99e55609() {
  if(gibserverutils::isgibbed(self, 32)) {
    return "has_left_arm_no";
  }

  return "has_left_arm_yes";
}

function_aa8f1e69() {
  if(gibserverutils::isgibbed(self, 16)) {
    return "has_right_arm_no";
  }

  return "has_right_arm_yes";
}

function_5b03a448() {
  if(isDefined(self.e_grapplee)) {
    return "has_grapplee_yes";
  }

  return "has_grapplee_no";
}

actorgetpredictedyawtoenemy(entity, lookaheadtime) {
  if(isDefined(entity.predictedyawtoenemy) && isDefined(entity.predictedyawtoenemytime) && entity.predictedyawtoenemytime == gettime()) {
    return entity.predictedyawtoenemy;
  }

  selfpredictedpos = entity.origin;
  moveangle = entity.angles[1] + entity getmotionangle();
  selfpredictedpos += (cos(moveangle), sin(moveangle), 0) * 200 * lookaheadtime;
  yaw = vectortoangles(entity lastknownpos(entity.enemy) - selfpredictedpos)[1] - entity.angles[1];
  yaw = absangleclamp360(yaw);
  entity.predictedyawtoenemy = yaw;
  entity.predictedyawtoenemytime = gettime();
  return yaw;
}

bb_actorispatroling() {
  entity = self;

  if(entity ai::has_behavior_attribute("patrol") && entity ai::get_behavior_attribute("patrol")) {
    return "patrol_enabled";
  }

  return "patrol_disabled";
}

bb_actorhasenemy() {
  entity = self;

  if(isDefined(entity.enemy)) {
    return "has_enemy";
  }

  return "no_enemy";
}

bb_actorgetenemyyaw() {
  enemy = self.enemy;

  if(!isDefined(enemy)) {
    return 0;
  }

  toenemyyaw = actorgetpredictedyawtoenemy(self, 0.2);
  return toenemyyaw;
}

bb_actorgetperfectenemyyaw() {
  enemy = self.enemy;

  if(!isDefined(enemy)) {
    return 0;
  }

  toenemyyaw = vectortoangles(enemy.origin - self.origin)[1] - self.angles[1];
  toenemyyaw = absangleclamp360(toenemyyaw);

  recordenttext("<dev string:x68>" + toenemyyaw, self, (1, 0, 0), "<dev string:x75>");

  return toenemyyaw;
}

function_caea19a8() {
  result = self.angles[1];
  v_origin = self geteventpointofinterest();

  if(!isDefined(v_origin) && isDefined(self.ai.var_2a2d6d17)) {
    v_origin = self.ai.var_2a2d6d17.origin;
  }

  if(isDefined(v_origin)) {
    str_typename = self getcurrenteventtypename();
    e_originator = self getcurrenteventoriginator();

    if(str_typename == "bullet" && isDefined(e_originator)) {
      v_origin = e_originator.origin;
    }

    deltaorigin = v_origin - self.origin;
    result = vectortoangles(deltaorigin)[1];
  }

  return result;
}

bb_actorgetreactyaw() {
  return absangleclamp360(self.angles[1] - self getblackboardattribute("_react_yaw_world"));
}

getangleusingdirection(direction) {
  directionyaw = vectortoangles(direction)[1];
  yawdiff = directionyaw - self.angles[1];
  yawdiff *= 0.00277778;
  flooredyawdiff = floor(yawdiff + 0.5);
  turnangle = (yawdiff - flooredyawdiff) * 360;
  return absangleclamp360(turnangle);
}

wasatcovernode() {
  if(isDefined(self.prevnode)) {
    if(self.prevnode.type == #"cover left" || self.prevnode.type == #"cover right" || self.prevnode.type == #"cover pillar" || self.prevnode.type == #"cover stand" || self.prevnode.type == #"conceal stand" || self.prevnode.type == #"cover crouch" || self.prevnode.type == #"cover crouch window" || self.prevnode.type == #"conceal crouch") {
      return true;
    }
  }

  return false;
}

bb_getlocomotionexityaw(blackboard, yaw) {
  if(self haspath()) {
    predictedlookaheadinfo = self predictexit();
    status = predictedlookaheadinfo[#"path_prediction_status"];

    if(!isDefined(self.pathgoalpos)) {
      return -1;
    }

    if(status == 3) {
      start = self.origin;
      end = start + vectorscale((0, predictedlookaheadinfo[#"path_prediction_travel_vector"][1], 0), 100);
      angletoexit = vectortoangles(predictedlookaheadinfo[#"path_prediction_travel_vector"])[1];
      exityaw = absangleclamp360(angletoexit - self.prevnode.angles[1]);

      record3dtext("<dev string:x82>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x75>", undefined, 0.4);

      return exityaw;
    } else if(status == 4) {
      start = self.origin;
      end = start + vectorscale((0, predictedlookaheadinfo[#"path_prediction_travel_vector"][1], 0), 100);
      angletoexit = vectortoangles(predictedlookaheadinfo[#"path_prediction_travel_vector"])[1];
      exityaw = absangleclamp360(angletoexit - self.angles[1]);

      record3dtext("<dev string:x82>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x75>", undefined, 0.4);

      return exityaw;
    } else if(status == 0) {
      if(wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
        end = self.pathgoalpos;
        angletodestination = vectortoangles(end - self.origin)[1];
        exityaw = absangleclamp360(angletodestination - self.prevnode.angles[1]);

        record3dtext("<dev string:x82>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x75>", undefined, 0.4);

        return exityaw;
      }

      start = predictedlookaheadinfo[#"path_prediction_start_point"];
      end = start + predictedlookaheadinfo[#"path_prediction_travel_vector"];
      exityaw = getangleusingdirection(predictedlookaheadinfo[#"path_prediction_travel_vector"]);

      record3dtext("<dev string:x82>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x75>", undefined, 0.4);

      return exityaw;
    } else if(status == 2) {
      if(wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
        end = self.pathgoalpos;
        angletodestination = vectortoangles(end - self.origin)[1];
        exityaw = absangleclamp360(angletodestination - self.prevnode.angles[1]);

        record3dtext("<dev string:x82>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x75>", undefined, 0.4);

        return exityaw;
      }

      exityaw = getangleusingdirection(vectornormalize(self.pathgoalpos - self.origin));

      record3dtext("<dev string:x82>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x75>", undefined, 0.4);

      return exityaw;
    }
  }

  return -1;
}

bb_getlocomotionfaceenemyquadrant() {
  walkstring = getdvarstring(#"tacticalwalkdirection");

  switch (walkstring) {
    case #"right":
      return "<dev string:x8f>";
    case #"left":
      return "<dev string:xad>";
    case #"back":
      return "<dev string:xca>";
  }

  if(isDefined(self.relativedir)) {
    direction = self.relativedir;

    switch (direction) {
      case 0:
        return "locomotion_face_enemy_front";
      case 1:
        return "locomotion_face_enemy_front";
      case 2:
        return "locomotion_face_enemy_right";
      case 3:
        return "locomotion_face_enemy_left";
      case 4:
        return "locomotion_face_enemy_back";
    }
  }

  return "locomotion_face_enemy_front";
}

bb_getlocomotionpaintype() {
  if(self haspath()) {
    predictedlookaheadinfo = self predictpath();
    status = predictedlookaheadinfo[#"path_prediction_status"];
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

bb_getlookaheadangle() {
  return absangleclamp360(vectortoangles(self.lookaheaddir)[1] - self.angles[1]);
}

bb_getpreviouscovernodetype() {
  return getcovertype(self.prevnode);
}

bb_actorgettrackingturnyaw() {
  var_71a0045b = undefined;

  if(isDefined(self.enemy)) {
    if(self cansee(self.enemy)) {
      var_71a0045b = self.enemy.origin;
    } else if(issentient(self.enemy)) {
      if(self.highlyawareradius && distance2dsquared(self.enemy.origin, self.origin) < self.highlyawareradius * self.highlyawareradius) {
        var_71a0045b = self.enemy.origin;
      } else {
        var_18c9035f = self function_18c9035f(self.enemy);
        attackedrecently = self attackedrecently(self.enemy, 2);

        if(attackedrecently && isDefined(var_18c9035f)) {
          if(self canshoot(var_18c9035f)) {
            var_71a0045b = self.var_18c9035f;
          }
        }

        if(!isDefined(var_71a0045b)) {
          if(issentient(self.enemy)) {
            lastknownpostime = self lastknowntime(self.enemy);
            lastknownpos = self lastknownpos(self.enemy);
          } else {
            lastknownpostime = gettime();
            lastknownpos = self.enemy.origin;
          }

          if(gettime() <= lastknownpostime + 2) {
            if(sighttracepassed(self getEye(), lastknownpos, 0, self, self.enemy)) {
              var_71a0045b = lastknownpos;
            }
          }
        }
      }
    }
  } else if(isDefined(self.ai.var_3af1add3)) {
    var_71a0045b = [[self.ai.var_3af1add3]](self);
  } else if(isDefined(self.likelyenemyposition)) {
    if(self canshoot(self.likelyenemyposition)) {
      var_71a0045b = self.likelyenemyposition;
    }
  }

  if(isDefined(var_71a0045b)) {
    turnyaw = absangleclamp360(self.angles[1] - vectortoangles(var_71a0045b - self.origin)[1]);
    return turnyaw;
  }

  return 0;
}

bb_getweaponclass() {
  return "rifle";
}

function_6f949118() {
  angles = self gettagangles("tag_origin");
  return angleclamp180(angles[0]);
}

function_38855dc8() {
  if(!isDefined(self.favoriteenemy)) {
    return 0;
  }

  velocity = self.favoriteenemy getvelocity();
  return length(velocity);
}

function_ebaa4b7c() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  return self.enemy.origin[2] - self.origin[2];
}

notstandingcondition(behaviortreeentity) {
  if(behaviortreeentity getblackboardattribute("_stance") != "stand") {
    return true;
  }

  return false;
}

notcrouchingcondition(behaviortreeentity) {
  if(behaviortreeentity getblackboardattribute("_stance") != "crouch") {
    return true;
  }

  return false;
}

scriptstartragdoll(behaviortreeentity) {
  behaviortreeentity startragdoll();
}

private prepareforexposedmelee(behaviortreeentity) {
  keepclaimnode(behaviortreeentity);
  meleeacquiremutex(behaviortreeentity);
  currentstance = behaviortreeentity getblackboardattribute("_stance");

  if(isDefined(behaviortreeentity.enemy) && behaviortreeentity.enemy.scriptvehicletype === "firefly") {
    behaviortreeentity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
  }

  if(currentstance == "crouch") {
    behaviortreeentity setblackboardattribute("_desired_stance", "stand");
  }
}

isfrustrated(behaviortreeentity) {
  return isDefined(behaviortreeentity.ai.frustrationlevel) && behaviortreeentity.ai.frustrationlevel > 0;
}

clampfrustration(frustrationlevel) {
  if(frustrationlevel > 4) {
    return 4;
  } else if(frustrationlevel < 0) {
    return 0;
  }

  return frustrationlevel;
}

updatefrustrationlevel(entity) {
  if(!isDefined(entity.ai.frustrationlevel)) {
    entity.ai.frustrationlevel = 0;
  }

  if(!isDefined(entity.enemy)) {
    entity.ai.frustrationlevel = 0;
    return false;
  }

  record3dtext("<dev string:xe7>" + entity.ai.frustrationlevel, entity.origin, (1, 0.5, 0), "<dev string:x75>");

  if(isactor(entity.enemy) || isplayer(entity.enemy)) {
    if(entity.ai.aggressivemode) {
      if(!isDefined(entity.ai.lastfrustrationboost)) {
        entity.ai.lastfrustrationboost = gettime();
      }

      if(entity.ai.lastfrustrationboost + 5000 < gettime()) {
        entity.ai.frustrationlevel++;
        entity.ai.lastfrustrationboost = gettime();
        entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
      }
    }

    isawareofenemy = gettime() - entity lastknowntime(entity.enemy) < int(10 * 1000);

    if(entity.ai.frustrationlevel == 4) {
      hasseenenemy = entity seerecently(entity.enemy, 2);
    } else {
      hasseenenemy = entity seerecently(entity.enemy, 5);
    }

    hasattackedenemyrecently = entity attackedrecently(entity.enemy, 5);

    if(!isawareofenemy || isactor(entity.enemy)) {
      if(!hasseenenemy) {
        entity.ai.frustrationlevel++;
      } else if(!hasattackedenemyrecently) {
        entity.ai.frustrationlevel += 2;
      }

      entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
      return true;
    }

    if(hasattackedenemyrecently) {
      entity.ai.frustrationlevel -= 2;
      entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
      return true;
    } else if(hasseenenemy) {
      entity.ai.frustrationlevel--;
      entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
      return true;
    }
  }

  return false;
}

flagenemyunattackableservice(behaviortreeentity) {
  behaviortreeentity flagenemyunattackable();
}

islastknownenemypositionapproachable(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy)) {
    lastknownpositionofenemy = behaviortreeentity lastknownpos(behaviortreeentity.enemy);

    if(behaviortreeentity isingoal(lastknownpositionofenemy) && behaviortreeentity findpath(behaviortreeentity.origin, lastknownpositionofenemy, 1, 0)) {
      return true;
    }
  }

  return false;
}

tryadvancingonlastknownpositionbehavior(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy)) {
    if(isDefined(behaviortreeentity.ai.aggressivemode) && behaviortreeentity.ai.aggressivemode) {
      lastknownpositionofenemy = behaviortreeentity lastknownpos(behaviortreeentity.enemy);

      if(behaviortreeentity isingoal(lastknownpositionofenemy) && behaviortreeentity findpath(behaviortreeentity.origin, lastknownpositionofenemy, 1, 0)) {
        behaviortreeentity function_a57c34b7(lastknownpositionofenemy, lastknownpositionofenemy);
        setnextfindbestcovertime(behaviortreeentity, undefined);
        return true;
      }
    }
  }

  return false;
}

trygoingtoclosestnodetoenemybehavior(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy)) {
    closestrandomnode = behaviortreeentity findbestcovernodes(behaviortreeentity.engagemaxdist, behaviortreeentity.enemy.origin)[0];

    if(isDefined(closestrandomnode) && behaviortreeentity isingoal(closestrandomnode.origin) && behaviortreeentity findpath(behaviortreeentity.origin, closestrandomnode.origin, 1, 0)) {
      usecovernodewrapper(behaviortreeentity, closestrandomnode);
      return true;
    }
  }

  return false;
}

tryrunningdirectlytoenemybehavior(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy) && isDefined(behaviortreeentity.ai.aggressivemode) && behaviortreeentity.ai.aggressivemode) {
    origin = behaviortreeentity.enemy.origin;

    if(behaviortreeentity isingoal(origin) && behaviortreeentity findpath(behaviortreeentity.origin, origin, 1, 0)) {
      behaviortreeentity function_a57c34b7(origin, origin);
      setnextfindbestcovertime(behaviortreeentity, undefined);
      return true;
    }
  }

  return false;
}

shouldreacttonewenemy(behaviortreeentity) {
  return false;
}

hasweaponmalfunctioned(behaviortreeentity) {
  return isDefined(behaviortreeentity.malfunctionreaction) && behaviortreeentity.malfunctionreaction;
}

issafefromgrenades(entity) {
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

ingrenadeblastradius(entity) {
  return !entity issafefromgrenade();
}

recentlysawenemy(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy) && behaviortreeentity seerecently(behaviortreeentity.enemy, 6)) {
    return true;
  }

  return false;
}

shouldonlyfireaccurately(behaviortreeentity) {
  if(isDefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
    return true;
  }

  return false;
}

shouldbeaggressive(behaviortreeentity) {
  if(isDefined(behaviortreeentity.ai.aggressivemode) && behaviortreeentity.ai.aggressivemode) {
    return true;
  }

  return false;
}

usecovernodewrapper(behaviortreeentity, node) {
  samenode = behaviortreeentity.node === node;
  behaviortreeentity usecovernode(node);

  if(!samenode) {
    behaviortreeentity setblackboardattribute("_cover_mode", "cover_mode_none");
    behaviortreeentity setblackboardattribute("_previous_cover_mode", "cover_mode_none");
  }

  setnextfindbestcovertime(behaviortreeentity, node);
}

setnextfindbestcovertime(behaviortreeentity, node) {
  behaviortreeentity.nextfindbestcovertime = behaviortreeentity getnextfindbestcovertime(behaviortreeentity.engagemindist, behaviortreeentity.engagemaxdist, behaviortreeentity.coversearchinterval);
}

trackcoverparamsservice(behaviortreeentity) {
  if(isDefined(behaviortreeentity.node) && behaviortreeentity isatcovernodestrict() && behaviortreeentity shouldusecovernode()) {
    if(!isDefined(behaviortreeentity.covernode)) {
      behaviortreeentity.covernode = behaviortreeentity.node;
      setnextfindbestcovertime(behaviortreeentity, behaviortreeentity.node);
    }

    return;
  }

  behaviortreeentity.covernode = undefined;
}

choosebestcovernodeasap(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.enemy)) {
    return 0;
  }

  node = getbestcovernodeifavailable(behaviortreeentity);

  if(isDefined(node)) {
    usecovernodewrapper(behaviortreeentity, node);
  }
}

shouldchoosebettercover(behaviortreeentity) {
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
        if(isDefined(behaviortreeentity.ai.frustrationlevel) && behaviortreeentity.ai.frustrationlevel > 0 && behaviortreeentity haspath()) {
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

    recordenttext("<dev string:xfb>" + shouldusecovernoderesult + "<dev string:x11b>" + islookingaroundforenemy + "<dev string:x123>" + abouttoarriveatcover + "<dev string:x12b>" + iswithineffectiverangealready + "<dev string:x133>" + shouldbeboredatcurrentcover, behaviortreeentity, color, "<dev string:x75>");

  } else {
    return !(behaviortreeentity shouldusecovernode() && behaviortreeentity isapproachinggoal());
  }

  return shouldlookforbettercover;
}

choosebettercoverservicecodeversion(behaviortreeentity) {
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

  if(isDefined(behaviortreeentity.keepclaimednode) && behaviortreeentity.keepclaimednode) {
    return false;
  }

  newnode = behaviortreeentity choosebettercovernode();

  if(isDefined(newnode)) {
    usecovernodewrapper(behaviortreeentity, newnode);
    return true;
  }

  setnextfindbestcovertime(behaviortreeentity, undefined);
  return false;
}

private choosebettercoverservice(behaviortreeentity) {
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

refillammo(behaviortreeentity) {
  if(behaviortreeentity.weapon != level.weaponnone) {
    behaviortreeentity.ai.bulletsinclip = behaviortreeentity.weapon.clipsize;
  }
}

getbestcovernodeifavailable(behaviortreeentity) {
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

getsecondbestcovernodeifavailable(behaviortreeentity) {
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

getcovertype(node) {
  if(isDefined(node)) {
    if(node.type == #"cover pillar") {
      return "cover_pillar";
    } else if(node.type == #"cover left") {
      return "cover_left";
    } else if(node.type == #"cover right") {
      return "cover_right";
    } else if(node.type == #"cover stand" || node.type == #"conceal stand") {
      return "cover_stand";
    } else if(node.type == #"cover crouch" || node.type == #"cover crouch window" || node.type == #"conceal crouch") {
      return "cover_crouch";
    } else if(node.type == #"exposed" || node.type == #"guard") {
      return "cover_exposed";
    }
  }

  return "cover_none";
}

iscoverconcealed(node) {
  if(isDefined(node)) {
    return (node.type == #"conceal crouch" || node.type == #"conceal stand");
  }

  return false;
}

canseeenemywrapper() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(!isDefined(self.node)) {
    return self cansee(self.enemy);
  }

  node = self.node;
  enemyeye = self.enemy getEye();
  yawtoenemy = angleclamp180(node.angles[1] - vectortoangles(enemyeye - node.origin)[1]);

  if(node.type == #"cover left" || node.type == #"cover right") {
    if(yawtoenemy > 60 || yawtoenemy < -60) {
      return 0;
    }

    if(isDefined(node.spawnflags) && (node.spawnflags&4) == 4) {
      if(node.type == #"cover left" && yawtoenemy > 10) {
        return 0;
      }

      if(node.type == #"cover right" && yawtoenemy < -10) {
        return 0;
      }
    }
  }

  nodeoffset = (0, 0, 0);

  if(node.type == #"cover pillar") {
    assert(!(isDefined(node.spawnflags) && (node.spawnflags&2048) == 2048) || !(isDefined(node.spawnflags) && (node.spawnflags&1024) == 1024));
    canseefromleft = 1;
    canseefromright = 1;
    nodeoffset = (-32, 3.7, 60);
    lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
    canseefromleft = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
    nodeoffset = (32, 3.7, 60);
    lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
    canseefromright = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
    return (canseefromright || canseefromleft);
  }

  if(node.type == #"cover left") {
    nodeoffset = (-36, 7, 63);
  } else if(node.type == #"cover right") {
    nodeoffset = (36, 7, 63);
  } else if(node.type == #"cover stand" || node.type == #"conceal stand") {
    nodeoffset = (-3.7, -22, 63);
  } else if(node.type == #"cover crouch" || node.type == #"cover crouch window" || node.type == #"conceal crouch") {
    nodeoffset = (3.5, -12.5, 45);
  }

  lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);

  if(sighttracepassed(lookfrompoint, enemyeye, 0, undefined)) {
    return 1;
  }

  return 0;
}

calculatenodeoffsetposition(node, nodeoffset) {
  right = anglestoright(node.angles);
  forward = anglesToForward(node.angles);
  return node.origin + vectorscale(right, nodeoffset[0]) + vectorscale(forward, nodeoffset[1]) + (0, 0, nodeoffset[2]);
}

gethighestnodestance(node) {
  assert(isDefined(node));

  if(isDefined(node.spawnflags) && (node.spawnflags&4) == 4) {
    return "stand";
  }

  if(isDefined(node.spawnflags) && (node.spawnflags&8) == 8) {
    return "crouch";
  }

  if(isDefined(node.spawnflags) && (node.spawnflags&16) == 16) {
    return "prone";
  }

  errormsg(node.type + "<dev string:x13b>" + node.origin + "<dev string:x146>");

  if(node.type == #"cover crouch" || node.type == #"cover crouch window" || node.type == #"conceal crouch") {
    return "crouch";
  }

  return "stand";
}

isstanceallowedatnode(stance, node) {
  assert(isDefined(stance));
  assert(isDefined(node));

  if(stance == "stand" && isDefined(node.spawnflags) && (node.spawnflags&4) == 4) {
    return true;
  }

  if(stance == "crouch" && isDefined(node.spawnflags) && (node.spawnflags&8) == 8) {
    return true;
  }

  if(stance == "prone" && isDefined(node.spawnflags) && (node.spawnflags&16) == 16) {
    return true;
  }

  return false;
}

trystoppingservice(behaviortreeentity) {
  if(behaviortreeentity shouldholdgroundagainstenemy()) {
    behaviortreeentity clearpath();
    behaviortreeentity.keepclaimednode = 1;
    return true;
  }

  behaviortreeentity.keepclaimednode = 0;
  return false;
}

shouldstopmoving(behaviortreeentity) {
  if(behaviortreeentity shouldholdgroundagainstenemy()) {
    return true;
  }

  return false;
}

setcurrentweapon(weapon) {
  self.weapon = weapon;
  self.weaponclass = weapon.weapclass;

  if(weapon != level.weaponnone) {
    assert(isDefined(weapon.worldmodel), "<dev string:x15d>" + weapon.name + "<dev string:x168>");
  }

  self.weaponmodel = weapon.worldmodel;
}

setprimaryweapon(weapon) {
  self.primaryweapon = weapon;
  self.primaryweaponclass = weapon.weapclass;

  if(weapon != level.weaponnone) {
    assert(isDefined(weapon.worldmodel), "<dev string:x15d>" + weapon.name + "<dev string:x168>");
  }
}

setsecondaryweapon(weapon) {
  self.secondaryweapon = weapon;
  self.secondaryweaponclass = weapon.weapclass;

  if(weapon != level.weaponnone) {
    assert(isDefined(weapon.worldmodel), "<dev string:x15d>" + weapon.name + "<dev string:x168>");
  }
}

keepclaimnode(behaviortreeentity) {
  behaviortreeentity.keepclaimednode = 1;
  return true;
}

releaseclaimnode(behaviortreeentity) {
  behaviortreeentity.keepclaimednode = 0;
  return true;
}

getaimyawtoenemyfromnode(behaviortreeentity, node, enemy) {
  return angleclamp180(vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[1] - node.angles[1]);
}

getaimpitchtoenemyfromnode(behaviortreeentity, node, enemy) {
  return angleclamp180(vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[0] - node.angles[0]);
}

choosefrontcoverdirection(behaviortreeentity) {
  coverdirection = behaviortreeentity getblackboardattribute("_cover_direction");
  behaviortreeentity setblackboardattribute("_previous_cover_direction", coverdirection);
  behaviortreeentity setblackboardattribute("_cover_direction", "cover_front_direction");
}

shouldtacticalwalk(behaviortreeentity) {
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

shouldstealth(behaviortreeentity) {
  if(behaviortreeentity ai::has_behavior_attribute("stealth") && behaviortreeentity ai::get_behavior_attribute("stealth")) {
    return true;
  }

  return false;
}

locomotionshouldstealth(behaviortreeentity) {
  if(behaviortreeentity haspath()) {
    return true;
  }

  return false;
}

shouldstealthresume(behaviortreeentity) {
  if(!shouldstealth(behaviortreeentity)) {
    return false;
  }

  if(isDefined(behaviortreeentity.stealth_resume) && behaviortreeentity.stealth_resume) {
    behaviortreeentity.stealth_resume = undefined;
    return true;
  }

  return false;
}

private stealthreactcondition(entity) {
  inscene = isDefined(self._o_scene) && isDefined(self._o_scene._str_state) && self._o_scene._str_state == "play";
  return !(isDefined(entity.stealth_reacting) && entity.stealth_reacting) && entity hasvalidinterrupt("react") && !inscene;
}

private stealthreactstart(behaviortreeentity) {
  behaviortreeentity.stealth_reacting = 1;
}

private stealthreactterminate(behaviortreeentity) {
  behaviortreeentity.stealth_reacting = undefined;
}

private stealthidleterminate(behaviortreeentity) {
  behaviortreeentity notify(#"stealthidleterminate");

  if(isDefined(behaviortreeentity.stealth_resume_after_idle) && behaviortreeentity.stealth_resume_after_idle) {
    behaviortreeentity.stealth_resume_after_idle = undefined;
    behaviortreeentity.stealth_resume = 1;
  }
}

locomotionshouldpatrol(behaviortreeentity) {
  if(shouldstealth(behaviortreeentity)) {
    return false;
  }

  if(behaviortreeentity haspath() && behaviortreeentity ai::has_behavior_attribute("patrol") && behaviortreeentity ai::get_behavior_attribute("patrol")) {
    return true;
  }

  return false;
}

private _dropriotshield(riotshieldinfo) {
  entity = self;
  entity shared::throwweapon(riotshieldinfo.weapon, riotshieldinfo.tag, 1, 0);

  if(isDefined(entity)) {
    entity detach(riotshieldinfo.model, riotshieldinfo.tag);
  }
}

attachriotshield(entity, riotshieldweapon, riotshieldmodel, riotshieldtag) {
  riotshield = spawnStruct();
  riotshield.weapon = riotshieldweapon;
  riotshield.tag = riotshieldtag;
  riotshield.model = riotshieldmodel;
  entity attach(riotshieldmodel, riotshield.tag);
  entity.riotshield = riotshield;
}

dropriotshield(behaviortreeentity) {
  if(isDefined(behaviortreeentity.riotshield)) {
    riotshieldinfo = behaviortreeentity.riotshield;
    behaviortreeentity.riotshield = undefined;
    behaviortreeentity thread _dropriotshield(riotshieldinfo);
  }
}

meleeacquiremutex(behaviortreeentity) {
  if(isDefined(behaviortreeentity) && isDefined(behaviortreeentity.enemy)) {
    behaviortreeentity.meleeenemy = behaviortreeentity.enemy;

    if(isplayer(behaviortreeentity.meleeenemy)) {
      if(!isDefined(behaviortreeentity.meleeenemy.meleeattackers)) {
        behaviortreeentity.meleeenemy.meleeattackers = 0;
      }

      behaviortreeentity.meleeenemy.meleeattackers++;
    }
  }
}

meleereleasemutex(behaviortreeentity) {
  if(isDefined(behaviortreeentity.meleeenemy)) {
    if(isplayer(behaviortreeentity.meleeenemy)) {
      if(isDefined(behaviortreeentity.meleeenemy.meleeattackers)) {
        behaviortreeentity.meleeenemy.meleeattackers -= 1;

        if(behaviortreeentity.meleeenemy.meleeattackers <= 0) {
          behaviortreeentity.meleeenemy.meleeattackers = undefined;
        }
      }
    }
  }

  behaviortreeentity.meleeenemy = undefined;
}

shouldmutexmelee(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy)) {
    if(!isplayer(behaviortreeentity.enemy)) {
      if(behaviortreeentity.enemy.meleeattackers) {
        return false;
      }
    } else {
      if(!sessionmodeiscampaigngame()) {
        return true;
      }

      behaviortreeentity.enemy.meleeattackers = 0;
      return (behaviortreeentity.enemy.meleeattackers < 1);
    }
  }

  return true;
}

shouldnormalmelee(behaviortreeentity) {
  return hascloseenemytomelee(behaviortreeentity);
}

shouldmelee(entity) {
  if(isDefined(entity.ai.lastshouldmeleeresult) && !entity.ai.lastshouldmeleeresult && entity.ai.lastshouldmeleechecktime + 50 >= gettime()) {
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

  if(isvehicle(entity.enemy) && !(isDefined(entity.enemy.ai.good_melee_target) && entity.enemy.ai.good_melee_target)) {
    return false;
  }

  if(isplayer(entity.enemy) && entity.enemy getstance() == "prone") {
    return false;
  }

  if(distancesquared(entity.origin, entity.enemy.origin) > 140 * 140) {
    return false;
  }

  if(ai::hasaiattribute(entity, "can_melee") && !ai::getaiattribute(entity, "can_melee")) {
    return false;
  }

  if(ai::hasaiattribute(entity.enemy, "can_be_meleed") && !ai::getaiattribute(entity.enemy, "can_be_meleed")) {
    return false;
  }

  if(!shouldmutexmelee(entity)) {
    return false;
  }

  if(shouldnormalmelee(entity) || shouldchargemelee(entity)) {
    entity.ai.lastshouldmeleeresult = 1;
    return true;
  }

  return false;
}

hascloseenemytomelee(entity) {
  return hascloseenemytomeleewithrange(entity, 64 * 64);
}

hascloseenemytomeleewithrange(entity, melee_range_sq) {
  assert(isDefined(entity.enemy));

  if(!entity cansee(entity.enemy)) {
    return false;
  }

  predicitedposition = entity.enemy.origin + vectorscale(entity getenemyvelocity(), 0.25);
  distsq = distancesquared(entity.origin, predicitedposition);
  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(distsq <= 36 * 36) {
    return (abs(yawtoenemy) <= 40);
  }

  if(distsq <= melee_range_sq && entity maymovetopoint(entity.enemy.origin)) {
    return (abs(yawtoenemy) <= 80);
  }

  return false;
}

shouldchargemelee(entity) {
  assert(isDefined(entity.enemy));
  currentstance = entity getblackboardattribute("_stance");

  if(currentstance != "stand") {
    return false;
  }

  if(isDefined(entity.ai.nextchargemeleetime)) {
    if(gettime() < entity.ai.nextchargemeleetime) {
      return false;
    }
  }

  enemydistsq = distancesquared(entity.origin, entity.enemy.origin);

  if(enemydistsq < 64 * 64) {
    return false;
  }

  offset = entity.enemy.origin - vectornormalize(entity.enemy.origin - entity.origin) * 36;

  if(enemydistsq < 140 * 140 && entity maymovetopoint(offset, 1, 1)) {
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    return (abs(yawtoenemy) <= 80);
  }

  return false;
}

private shouldattackinchargemelee(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy)) {
    if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) < 74 * 74) {
      yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);

      if(abs(yawtoenemy) > 80) {
        return 0;
      }

      return 1;
    }
  }
}

private setupchargemeleeattack(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy) && behaviortreeentity.enemy.scriptvehicletype === "firefly") {
    behaviortreeentity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
  }

  meleeacquiremutex(behaviortreeentity);
  keepclaimnode(behaviortreeentity);
}

private cleanupmelee(behaviortreeentity) {
  meleereleasemutex(behaviortreeentity);
  releaseclaimnode(behaviortreeentity);
  behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);

  if(isDefined(behaviortreeentity.ai.var_aba9dcfd) && isDefined(behaviortreeentity.ai.var_38ee3a42)) {
    behaviortreeentity pathmode("move delayed", 1, randomfloatrange(behaviortreeentity.ai.var_aba9dcfd, behaviortreeentity.ai.var_38ee3a42));
  }
}

private cleanupchargemelee(behaviortreeentity) {
  behaviortreeentity.ai.nextchargemeleetime = gettime() + 2000;
  behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);
  meleereleasemutex(behaviortreeentity);
  releaseclaimnode(behaviortreeentity);
  behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.75, 1.5));
}

cleanupchargemeleeattack(behaviortreeentity) {
  meleereleasemutex(behaviortreeentity);
  releaseclaimnode(behaviortreeentity);
  behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);

  if(isDefined(behaviortreeentity.ai.var_aba9dcfd) && isDefined(behaviortreeentity.ai.var_38ee3a42)) {
    behaviortreeentity pathmode("move delayed", 1, randomfloatrange(behaviortreeentity.ai.var_aba9dcfd, behaviortreeentity.ai.var_38ee3a42));
    return;
  }

  behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.5, 1));
}

private shouldchoosespecialpronepain(behaviortreeentity) {
  stance = behaviortreeentity getblackboardattribute("_stance");
  return stance == "prone_back" || stance == "prone_front";
}

private function_9b0e7a22(behaviortreeentity) {
  return behaviortreeentity.var_40543c03 === "concussion";
}

private shouldchoosespecialpain(behaviortreeentity) {
  return isDefined(behaviortreeentity.var_40543c03);
}

private function_89cb7bfd(behaviortreeentity) {
  return behaviortreeentity.var_ab2486b4;
}

private shouldchoosespecialdeath(behaviortreeentity) {
  if(isDefined(behaviortreeentity.damageweapon)) {
    return behaviortreeentity.damageweapon.specialpain;
  }

  return 0;
}

private shouldchoosespecialpronedeath(behaviortreeentity) {
  stance = behaviortreeentity getblackboardattribute("_stance");
  return stance == "prone_back" || stance == "prone_front";
}

private setupexplosionanimscale(entity, asmstatename) {
  self.animtranslationscale = 2;
  self asmsetanimationrate(0.7);
  return 4;
}

isbalconydeath(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.node)) {
    return false;
  }

  if(!(behaviortreeentity.node.spawnflags&1024 || behaviortreeentity.node.spawnflags&2048)) {
    return false;
  }

  covermode = behaviortreeentity getblackboardattribute("_cover_mode");

  if(isDefined(behaviortreeentity.node.script_balconydeathchance) && randomint(100) > int(100 * behaviortreeentity.node.script_balconydeathchance)) {
    return false;
  }

  distsq = distancesquared(behaviortreeentity.origin, behaviortreeentity.node.origin);

  if(distsq > 64 * 64) {
    return false;
  }

  self.b_balcony_death = 1;
  return true;
}

balconydeath(behaviortreeentity) {
  behaviortreeentity.clamptonavmesh = 0;

  if(behaviortreeentity.node.spawnflags&1024) {
    behaviortreeentity setblackboardattribute("_special_death", "balcony");
    return;
  }

  if(behaviortreeentity.node.spawnflags&2048) {
    behaviortreeentity setblackboardattribute("_special_death", "balcony_norail");
  }
}

usecurrentposition(entity) {
  entity function_a57c34b7(entity.origin);
}

isunarmed(behaviortreeentity) {
  if(behaviortreeentity.weapon == level.weaponnone) {
    return true;
  }

  return false;
}

preshootlaserandglinton(ai) {
  self endon(#"death");

  if(!isDefined(ai.laserstatus)) {
    ai.laserstatus = 0;
  }

  sniper_glint = #"hash_3db1ecb54b192a49";

  while(true) {
    self waittill(#"about_to_fire");

    if(ai.laserstatus !== 1) {
      ai laseron();
      ai.laserstatus = 1;
      tag = ai gettagorigin("tag_flash");

      if(isDefined(tag)) {
        playFXOnTag(sniper_glint, ai, "tag_flash");
        continue;
      }

      type = isDefined(ai.classname) ? "" + ai.classname : "";
      println("<dev string:x18a>" + type + "<dev string:x190>");
      playFXOnTag(sniper_glint, ai, "tag_eye");
    }
  }
}

postshootlaserandglintoff(ai) {
  self endon(#"death");

  while(true) {
    self waittill(#"stopped_firing");

    if(ai.laserstatus === 1) {
      ai laseroff();
      ai.laserstatus = 0;
    }
  }
}

private isinphalanx(entity) {
  return entity ai::get_behavior_attribute("phalanx");
}

private isinphalanxstance(entity) {
  phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
  currentstance = entity getblackboardattribute("_stance");

  switch (phalanxstance) {
    case #"stand":
      return (currentstance == "stand");
    case #"crouch":
      return (currentstance == "crouch");
  }

  return true;
}

private togglephalanxstance(entity) {
  phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");

  switch (phalanxstance) {
    case #"stand":
      entity setblackboardattribute("_desired_stance", "stand");
      break;
    case #"crouch":
      entity setblackboardattribute("_desired_stance", "crouch");
      break;
  }
}

isatattackobject(entity) {
  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1])) {
    return false;
  }

  if(isDefined(entity.attackable) && isDefined(entity.attackable.is_active) && entity.attackable.is_active) {
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

shouldattackobject(entity) {
  if(isDefined(entity.enemyoverride) && isDefined(entity.enemyoverride[1])) {
    return false;
  }

  if(isDefined(entity.attackable) && isDefined(entity.attackable.is_active) && entity.attackable.is_active) {
    if(isDefined(entity.is_at_attackable) && entity.is_at_attackable) {
      return true;
    }
  }

  return false;
}

meleeattributescallback(entity, attribute, oldvalue, value) {
  switch (attribute) {
    case #"can_melee":
      if(value) {
        entity.canmelee = 1;
      } else {
        entity.canmelee = 0;
      }

      break;
    case #"can_be_meleed":
      if(value) {
        entity.canbemeleed = 1;
      } else {
        entity.canbemeleed = 0;
      }

      break;
  }
}

arrivalattributescallback(entity, attribute, oldvalue, value) {
  switch (attribute) {
    case #"disablearrivals":
      if(value) {
        entity.ai.disablearrivals = 1;
      } else {
        entity.ai.disablearrivals = 0;
      }

      break;
  }
}

phalanxattributecallback(entity, attribute, oldvalue, value) {
  if(value) {
    entity.ai.phalanx = 1;
    return;
  }

  entity.ai.phalanx = 0;
}

private generictryreacquireservice(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.reacquire_state)) {
    behaviortreeentity.reacquire_state = 0;
  }

  if(!isDefined(behaviortreeentity.enemy)) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  if(behaviortreeentity haspath()) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  if(behaviortreeentity seerecently(behaviortreeentity.enemy, 4)) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  dirtoenemy = vectornormalize(behaviortreeentity.enemy.origin - behaviortreeentity.origin);
  forward = anglesToForward(behaviortreeentity.angles);

  if(vectordot(dirtoenemy, forward) < 0.5) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  switch (behaviortreeentity.reacquire_state) {
    case 0:
    case 1:
    case 2:
      step_size = 32 + behaviortreeentity.reacquire_state * 32;
      reacquirepos = behaviortreeentity reacquirestep(step_size);
      break;
    case 4:
      if(!behaviortreeentity cansee(behaviortreeentity.enemy) || !behaviortreeentity canshootenemy()) {
        behaviortreeentity flagenemyunattackable();
      }

      break;
    default:
      if(behaviortreeentity.reacquire_state > 15) {
        behaviortreeentity.reacquire_state = 0;
        return false;
      }

      break;
  }

  if(isvec(reacquirepos)) {
    behaviortreeentity function_a57c34b7(reacquirepos);
    return true;
  }

  behaviortreeentity.reacquire_state++;
  return false;
}