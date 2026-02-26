/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_210ec734a4149bac.gsc
***********************************************/

#using scripts\core_common\ai\archetype_civilian;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_f592a7b;

function private autoexec __init__system__() {
  system::register(#"hash_2846a4f4bd094545", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  assert(isscriptfunctionptr(&civilianpaniccoverservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("civilianPanicCoverService", &civilianpaniccoverservice, 1);
  level.var_ec54dc19 = &function_251c139d;
  callback::on_ai_killed(&on_ai_killed);
  spawner::add_archetype_spawn_function(#"civilian", &function_478f2963);
  level thread function_dcfd9c90();

  adddebugcommand("<dev string:x38>");
}

function private postinit() {
  level.__ai_interface[#"civilian"][#"_civ_mode"][#"callback"] = &function_e2953db0;
}

function private function_478f2963() {
  self.var_702fecae = 0;
  self thread function_f1d19be1();
  self thread function_c96b0450();

  self thread function_a8f579e();
}

function private function_9308c21b() {
  result = 0;

  if(isDefined(self.node) && self.node.type == # "exposed" && self isatcovernode()) {
    result = 1;
  }

  return result;
}

function private function_c96b0450() {
  level endon(#"game_ended");
  self endon(#"death");
  self.var_ce60d915 = 0;

  while(true) {
    waitframe(1);

    if(self getblackboardattribute(#"_civ_mode") == "panic") {
      if(isDefined(level.players) && level.players.size > 0 && function_9308c21b()) {
        player = level.players[0];
        var_49122837 = distance2dsquared(self.origin, player.origin);

        if(var_49122837 < sqr(300)) {
          player_angles = player getplayerangles();
          player_facing = anglesToForward(player_angles);
          var_3495bfe6 = self.origin - player.origin;

          if(vectordot(var_3495bfe6, player_facing) > 0) {
            self.var_ce60d915 += float(function_60d95f53()) / 1000;

            if(self.var_ce60d915 > 1.5 && self.nextfindbestcovertime > gettime()) {
              self.nextfindbestcovertime = gettime();
            }
          }

          continue;
        }

        self.var_ce60d915 = 0;
      }
    }
  }
}

function private function_74f41e14(entity) {
  goalinfo = entity function_4794d6a3();
  forcedgoal = is_true(goalinfo.goalforced);
  itsbeenawhile = gettime() > entity.nextfindbestcovertime;
  shouldfindbetterposition = itsbeenawhile;

  if(forcedgoal || !shouldfindbetterposition) {
    return false;
  }

  if(isDefined(level.var_72b8905c)) {
    var_be34b5c6 = entity[[level.var_72b8905c]]();
    entity function_387a6908(var_be34b5c6);
    entity.nextfindbestcovertime = 2147483647;
    return true;
  }

  pickedpoint = undefined;
  var_cab884f3 = randomfloat(1);

  if((is_true(entity.var_6fc509b9) || !function_9308c21b()) && var_cab884f3 < 0.5) {
    if(is_true(entity.var_ac4fe74b)) {
      pickedpoint = function_251c139d(entity, goalinfo, "civilian_region_exposed_cover_tacquery");
    } else {
      pickedpoint = function_251c139d(entity, goalinfo, "civilian_exposed_cover_tacquery");
    }
  }

  if(!isDefined(pickedpoint)) {
    if(is_true(entity.var_ac4fe74b)) {
      pickedpoint = function_251c139d(entity, goalinfo, "civilian_region_cover_tacquery");
    } else {
      pickedpoint = function_251c139d(entity, goalinfo, "civilian_cover_tacquery");
    }
  }

  if(isDefined(pickedpoint) && isDefined(pickedpoint.node)) {
    entity function_387a6908(pickedpoint.node);
    entity.nextfindbestcovertime = gettime() + 9999999;

    if(isDefined(entity.var_5557ac4d)) {
      entity[[entity.var_5557ac4d]]();
    }

    if(is_true(entity.var_6fc509b9)) {
      entity.var_6fc509b9 = 0;
    }

    return true;
  } else {
    entity.nextfindbestcovertime = gettime() + 3000;
  }

  return false;
}

function private function_ddb1fd83(nearestnode, tacpoints, pickedpoint) {
  self notify("7fec587c06753641");
  self endon("7fec587c06753641");
  self endon(#"death");
  goalinfo = self function_4794d6a3();

  while(true) {
    waitframe(1);
    color = (1, 0.752941, 0.796078);
    var_f08d182b = " cover goalpos";

    if(pickedpoint.node.type == # "exposed") {
      color = (1, 0, 1);
      var_f08d182b = " exposed goalpos";
    }

    line(goalinfo.goalpos, nearestnode.origin, (1, 0.5, 0), 1, 0, 1);
    print3d(goalinfo.goalpos, "<dev string:x65>" + self getentitynumber() + var_f08d182b, color, 1, 1, 1);

    foreach(tacpoint in tacpoints) {
      if(tacpoint != pickedpoint) {
        line(goalinfo.goalpos, tacpoint.origin, color, 1, 0, 1);

        continue;
      }

      print3d(tacpoint.origin, "<dev string:x69>", (0, 1, 0), 1, 1, 1);
      line(goalinfo.goalpos, tacpoint.origin, (0, 1, 0), 1, 0, 1);
    }
  }
}

function private function_251c139d(entity, goalinfo, var_1fe38bcc) {
  nearestnode = getnearestnode(goalinfo.goalpos);
  tacpoints = undefined;
  pickedpoint = undefined;

  if(!isDefined(nearestnode)) {
    nearestnode = getnearestnode(entity.origin);
  }

  if(isDefined(nearestnode)) {
    pixbeginevent(var_1fe38bcc);
    aiprofile_beginentry(var_1fe38bcc);
    tacpoints = tacticalquery(var_1fe38bcc, entity.origin, entity, goalinfo.goalpos, nearestnode);
    pixendevent();
    aiprofile_endentry();
  }

  if(isDefined(tacpoints)) {
    foreach(tacpoint in tacpoints) {
      if(!entity isposinclaimedlocation(tacpoint.origin)) {
        if(isDefined(entity.pathgoalpos) && entity.pathgoalpos == tacpoint.origin) {
          continue;
        }

        pickedpoint = tacpoint;
        break;
      }
    }

    enabled = getdvarint(#"hash_40c63080b0f73497", 0);

    if(enabled && isDefined(pickedpoint)) {
      entity thread function_ddb1fd83(nearestnode, tacpoints, pickedpoint);
    }
  }

  return pickedpoint;
}

function function_387a6908(node) {
  self endon(#"death");
  aiutility::releaseclaimnode(self);
  aiutility::usecovernodewrapper(self, node);
}

function private civilianpaniccoverservice(entity) {
  result = 0;

  if(entity getblackboardattribute(#"_civ_mode") == "panic") {
    result = function_74f41e14(entity);

    if(!result) {
      result = archetypecivilian::civilianpanicescapechooseposition(entity);
    }
  }

  return result;
}

function private function_9cefbbde(var_5f60ac6c) {
  contact_point = var_5f60ac6c.origin;
  initial_force = (0, 0, -1);

  switch (var_5f60ac6c.var_2e23b67d) {
    case # "umbrella_left":
      initial_force = (0, 0.25, 0.5);
      initial_force = rotatepoint(initial_force, self.angles);
      var_9fa53333 = (0, -10, 10);
      var_9fa53333 = rotatepoint(var_9fa53333, self.angles);
      contact_point += var_9fa53333;
      break;
    case # "umbrella_right":
      initial_force = (0, -0.25, 0.5);
      initial_force = rotatepoint(initial_force, self.angles);
      var_9fa53333 = (0, 10, 10);
      var_9fa53333 = rotatepoint(var_9fa53333, self.angles);
      contact_point += var_9fa53333;
      break;
    default:
      break;
  }

  var_5f60ac6c unlink();
  var_5f60ac6c physicslaunch(contact_point, initial_force);
}

function private on_ai_killed(params) {
  if(self.archetype === # "civilian") {
    if(isDefined(self.civilian_props)) {
      foreach(var_5f60ac6c in self.civilian_props) {
        function_9cefbbde(var_5f60ac6c);
      }
    }

    if(isDefined(params.eattacker) && isPlayer(params.eattacker)) {
      if(isDefined(level.var_f4ed1999)) {
        level thread[[level.var_f4ed1999]](self, params);
      }
    }
  }
}

function private function_dcfd9c90() {
  self notify("2e7cf0b3ed141929");
  self endon("2e7cf0b3ed141929");
  level endon(#"game_ended");
  level.var_2feffa6b = 0;

  while(true) {
    waitframe(1);

    if(isDefined(level.players) && level.players.size > 0 && gettime() > level.var_2feffa6b) {
      player = level.players[0];
      civilians = getaiarchetypearray(#"civilian");
      var_b88ec851 = arraysortclosest(civilians, player.origin);

      foreach(civilian in civilians) {
        if(isDefined(civilian) && is_true(civilian.var_c0321be9) && civilian getblackboardattribute(#"_civ_mode") != "panic") {
          civilian ai::set_behavior_attribute(#"_civ_mode", "panic");
          civilian.var_c0321be9 = undefined;
          level.var_2feffa6b = gettime() + function_60d95f53();
          break;
        }
      }
    }
  }
}

function function_8e430c8(var_47b961dc) {
  self.var_6fc509b9 = 1;
  self setgoal(var_47b961dc);
}

function private function_e2953db0(entity, attribute, oldvalue, value) {
  if(value != oldvalue && value == "panic") {
    if(isDefined(attribute.civilian_props)) {
      foreach(var_5f60ac6c in self.civilian_props) {
        function_9cefbbde(var_5f60ac6c);
      }
    }

    var_47b961dc = attribute.origin;

    if(isDefined(attribute.var_5313e2e3)) {
      var_47b961dc = attribute.var_5313e2e3;
    }

    function_8e430c8(var_47b961dc);
    attribute setblackboardattribute("_prop_overlay", "NONE");
  }
}

function function_7bd21c92(value) {
  oldvalue = self getblackboardattribute("_prop_overlay");

  if(value === oldvalue) {
    return;
  }

  self setblackboardattribute("_prop_overlay", value);
  function_b0876f77(value);
}

function private function_5c56272f(var_df71f499, var_c72571dd, var_2e23b67d) {
  if(!isDefined(self.civilian_props)) {
    self.civilian_props = [];
  }

  var_5f60ac6c = util::spawn_model(var_df71f499);
  var_5f60ac6c linkto(self, var_c72571dd, (0, 0, 0), (0, 0, 0));
  var_5f60ac6c.var_2e23b67d = var_2e23b67d;
  self.civilian_props[self.civilian_props.size] = var_5f60ac6c;
}

function function_b0876f77(value) {
  if(isDefined(self.civilian_props)) {
    array::delete_all(self.civilian_props);
    self.civilian_props = [];
  }

  var_df71f499 = undefined;
  var_c72571dd = undefined;

  switch (value) {
    case # "briefcase_left":
      function_5c56272f("z_briefcase_01_closed", "tag_accessory_left", "BRIEFCASE_LEFT");
      break;
    case # "umbrella_left":
      function_5c56272f("par_umbrella_open_01", "tag_accessory_left", "UMBRELLA_LEFT");
      break;
    case # "hash_4ac48798a0be234b":
      function_5c56272f("par_umbrella_open_01_anim", "tag_accessory_left", "UMBRELLA_LEFT");
      function_5c56272f("z_briefcase_01_closed", "tag_accessory_right", "BRIEFCASE_RIGHT");
      break;
    case # "umbrella_right":
      function_5c56272f("par_umbrella_open_01", "tag_accessory_right", "UMBRELLA_RIGHT");
      break;
    case # "none":
    default:
      break;
  }
}

function private function_f1d19be1() {
  self notify(#"hash_5048c5b7622d6841");
  self endon(#"hash_5048c5b7622d6841");
  level endon(#"game_ended");
  self endon(#"death");
  self addsentienteventlistener("bulletwhizby");
  self addsentienteventlistener("explode");
  self addsentienteventlistener("grenade danger");
  self addsentienteventlistener("gunshot");
  self addsentienteventlistener("grenade danger");
  self addsentienteventlistener("projectile_impact");

  while(true) {
    if(self getblackboardattribute(#"_civ_mode") != "panic") {
      waitframe(1);
      continue;
    }

    if(isDefined(self.node) && !self isatcovernode()) {
      waitframe(1);
      continue;
    }

    wait_result = self waittill(#"ai_events");
    waittillframeend();

    if(self.ignoreall || self isragdoll()) {
      continue;
    }

    foreach(event in wait_result.events) {
      if(!isDefined(event.entity)) {
        continue;
      }

      if(event.type == "projectile_impact" && isDefined(event.entity.owner)) {
        event.entity = event.entity.owner;
      }

      if(issentient(event.entity) && (event.entity.ignoreme || is_true(event.entity isnotarget()))) {
        continue;
      }

      self.nextfindbestcovertime = gettime();

      enabled = getdvarint(#"hash_40c63080b0f73497", 0);

      if(enabled) {
        line(self getcentroid(), event.origin, (1, 0.5, 0), 1, 0, 500);
        print3d(event.origin, "<dev string:x65>" + event.type, (1, 0.5, 0), 1, 1, 500);
      }
    }
  }
}

function private function_a8f579e() {
  level endon(#"game_ended");
  self endon(#"death");

  while(true) {
    waitframe(1);
    enabled = getdvarint(#"hash_40c63080b0f73497", 0);

    if(!enabled) {
      continue;
    }

    if(self getblackboardattribute(#"_civ_mode") != "panic") {
      continue;
    }

    if(self isatcovernode()) {
      print3d(self getcentroid(), "<dev string:x7a>", (1, 1, 0), 1, 1, 1);
    }
  }
}