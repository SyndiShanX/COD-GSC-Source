/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1940fc077a028a81.gsc
***********************************************/

#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_utility;
#namespace namespace_e292b080;

function private autoexec __init__system__() {
  system::register(#"hash_1f8830cd01b39f8f", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  function_7ff2a0fc();
  level thread function_96ef8382();
  level.var_87bca031 = &zombieshouldmelee;
  val::register("blockingpain", 1);
  val::default_value("blockingpain", 0);
}

function private function_7ff2a0fc() {
  if(zm_utility::is_survival() && getDvar(#"hash_2d0879ab385bc2c8", 0)) {
    assert(isscriptfunctionptr(&function_e91d8371));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieupdatethrottle", &function_e91d8371, 1);
  } else {
    assert(isscriptfunctionptr(&function_e91d8371));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieupdatethrottle", &function_e91d8371, 2);
  }

  assert(isscriptfunctionptr(&function_5aeeecac));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3ac312897079296a", &function_5aeeecac, 2);
  assert(isscriptfunctionptr(&function_eea7a68a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_300dd0c6326499f2", &function_eea7a68a, 1);
  assert(isscriptfunctionptr(&function_1ca9d31b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_35bf14858fe8b5cf", &function_1ca9d31b, 3);
  assert(isscriptfunctionptr(&function_a9602314));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_398253cb51d92e3c", &function_a9602314);
  assert(isscriptfunctionptr(&zombieshouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieshouldmelee", &zombieshouldmelee);
  assert(isscriptfunctionptr(&function_d8b225ae));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieshouldmeleeattackable", &function_d8b225ae);
  assert(isscriptfunctionptr(&zombieshouldmove));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieshouldmove", &zombieshouldmove);
  assert(isscriptfunctionptr(&function_bfc25c77));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_502cf2e8eca970f0", &function_bfc25c77);
  assert(isscriptfunctionptr(&function_b9b03294));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_91cfd1edd5185d1", &function_b9b03294);
  assert(isscriptfunctionptr(&zombieshouldknockdown));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieshouldknockdown", &zombieshouldknockdown);
  assert(isscriptfunctionptr(&function_2a7b4aab));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieinwire", &function_2a7b4aab);
  assert(isscriptfunctionptr(&function_931b615f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5ecbb3fc61f4458c", &function_931b615f);
  assert(isscriptfunctionptr(&function_e1b85c34));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_570afe82cdfa6969", &function_e1b85c34);
  assert(isscriptfunctionptr(&function_e9e6482));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7d363abffd05f58a", &function_e9e6482);
  assert(isscriptfunctionptr(&function_10b38c5a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1d366f17af8db750", &function_10b38c5a);
  assert(isscriptfunctionptr(&function_10b38c5a));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1d366f17af8db750", &function_10b38c5a);
  assert(isscriptfunctionptr(&function_573545a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_35721134610efe59", &function_573545a);
  assert(isscriptfunctionptr(&function_573545a));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_35721134610efe59", &function_573545a);
  assert(isscriptfunctionptr(&function_67d5c154));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_68b1f7fd11065924", &function_67d5c154);
  assert(isscriptfunctionptr(&function_837931eb));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1fb23f2490e563bd", &function_837931eb);
  assert(isscriptfunctionptr(&function_837931eb));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1fb23f2490e563bd", &function_837931eb);
  assert(isscriptfunctionptr(&function_5ac985fe));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_9d432cd960b099a", &function_5ac985fe);
  assert(isscriptfunctionptr(&function_5ac985fe));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_9d432cd960b099a", &function_5ac985fe);
  assert(isscriptfunctionptr(&zombiemoveactionstart));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombiemoveactionstart", &zombiemoveactionstart);
  assert(isscriptfunctionptr(&zombiemoveactionupdate));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombiemoveactionupdate", &zombiemoveactionupdate);
  assert(isscriptfunctionptr(&zombiemoveactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombiemoveactionstart", &zombiemoveactionstart);
  assert(isscriptfunctionptr(&zombiemoveactionupdate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombiemoveactionupdate", &zombiemoveactionupdate);
  assert(isscriptfunctionptr(&function_7c8e35e8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5b037e170b517862", &function_7c8e35e8);
  assert(!isDefined(&function_7c8e35e8) || isscriptfunctionptr(&function_7c8e35e8));
  assert(!isDefined(&function_fee7d867) || isscriptfunctionptr(&function_fee7d867));
  assert(!isDefined(&function_3f71b9c2) || isscriptfunctionptr(&function_3f71b9c2));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_5bd00a38dffd47e", &function_7c8e35e8, &function_fee7d867, &function_3f71b9c2);
  assert(isscriptfunctionptr(&zombieknockdownactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieknockdownactionstart", &zombieknockdownactionstart);
  assert(isscriptfunctionptr(&function_c8939973));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a21325931f5ca2f", &function_c8939973);
  assert(isscriptfunctionptr(&zombiegetupactionterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombiegetupactionterminate", &zombiegetupactionterminate);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_78106a79) || isscriptfunctionptr(&function_78106a79));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"wzzombiestunnedloop", undefined, &function_78106a79, undefined);
  assert(isscriptfunctionptr(&function_f8250d5e));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieidleactionstart", &function_f8250d5e);
  assert(isscriptfunctionptr(&function_860d5d8));
  behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieidleactionupdate", &function_860d5d8);
  assert(isscriptfunctionptr(&function_f8250d5e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieidleactionstart", &function_f8250d5e);
  assert(isscriptfunctionptr(&function_860d5d8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieidleactionupdate", &function_860d5d8);
  assert(isscriptfunctionptr(&function_f37b0fbd));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombiewaitfortraversalstart", &function_f37b0fbd);
  assert(isscriptfunctionptr(&function_da99776f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_45589afe0073d903", &function_da99776f);
  assert(isscriptfunctionptr(&function_da99776f));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_45589afe0073d903", &function_da99776f);
  assert(isscriptfunctionptr(&function_c8caa34b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1cb57a93258839fc", &function_c8caa34b);
  assert(isscriptfunctionptr(&function_c8caa34b));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1cb57a93258839fc", &function_c8caa34b);
  assert(!isDefined(&function_83a4da79) || isscriptfunctionptr(&function_83a4da79));
  assert(!isDefined(&function_596c95b0) || isscriptfunctionptr(&function_596c95b0));
  assert(!isDefined(&function_5abf1ae8) || isscriptfunctionptr(&function_5abf1ae8));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_69494c58be35bb56", &function_83a4da79, &function_596c95b0, &function_5abf1ae8);
  assert(isscriptfunctionptr(&function_62fb515e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7aebffd77debd56e", &function_62fb515e);
  animationstatenetwork::registernotetrackhandlerfunction("zombieRiserFx", &function_79c3a487);
  animationstatenetwork::registernotetrackhandlerfunction("showZombie", &showzombie);
  animationstatenetwork::registernotetrackhandlerfunction("damageDoor", &damagedoor);
  animationstatenetwork::registeranimationmocomp("mocomp_zombie_attack_attackable", &function_81349d20, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_attack_traversal_blocker", &function_8aa7d53, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_force_face_attackable_or_enemy", &function_933af241, undefined, undefined);
}

function private function_96ef8382() {
  if(!zm_utility::is_survival()) {
    return;
  }

  var_25d1f8b = getEntArray("sr_building", "script_noteworthy");
  level.var_afa5478b = [];
  level.var_1b2515eb = 0;

  for(i = 0; i < var_25d1f8b.size; i++) {
    if(var_25d1f8b[i].classname == "info_volume" || var_25d1f8b[i].classname == "trigger_box") {
      volume = var_25d1f8b[i];
      var_d6702980 = struct::get_array(volume.targetname, "target");
      nodes = [];

      foreach(node in var_d6702980) {
        dropped = function_9cc082d2(node.origin, 100);

        if(isDefined(dropped[#"point"])) {
          node.origin = dropped[#"point"];
        }

        node.origin = getclosestpointonnavmesh(node.origin, 200, 50);

        if(isDefined(node.origin)) {
          nodes[nodes.size] = node;
        }

        waitframe(1);
      }

      nodes = array::quick_sort(nodes, &function_ad2dc5e5);
      volume.nodes = nodes;
      entrance_nodes = [];

      foreach(node in nodes) {
        if(is_true(node.var_6fff1a72)) {
          entrance_nodes[entrance_nodes.size] = node;
        }
      }

      volume.entrance_nodes = entrance_nodes;
      volume.var_2dfb472b = [];
      volume.var_8b2a5592 = [];

      foreach(node in nodes) {
        floor = max(isDefined(int(node.floor)) ? int(node.floor) : 1, 0);

        while(floor >= volume.var_2dfb472b.size) {
          volume.var_2dfb472b[volume.var_2dfb472b.size] = [undefined];
        }
      }

      for(o = 0; o < volume.var_2dfb472b.size; o++) {
        volume.var_2dfb472b[o] = function_b9b83baf(nodes, o);
        volume.var_8b2a5592[o] = function_a3627e9d(volume, o);
      }

      if(isDefined(volume.var_1fa7d27e)) {
        volume.var_1fa7d27e = int(volume.var_1fa7d27e);
      }

      level.var_afa5478b[level.var_afa5478b.size] = volume;
      var_3380ebc8 = var_25d1f8b[i] getmaxs();
      level.var_1b2515eb = max(level.var_1b2515eb, max(var_3380ebc8[0], max(var_3380ebc8[1], var_3380ebc8[2])));
    }
  }
}

function private function_ad2dc5e5(left, right) {
  return left.origin[2] < right.origin[2];
}

function private function_e91d8371(entity) {
  if(!is_true(entity.ai.var_870d0893)) {
    return;
  }

  if(!isDefined(level.var_a2fbb776)) {
    level.var_a2fbb776 = 0;
  }

  level.var_8de0b84e[level.var_a2fbb776] = entity getentitynumber();
  level.var_a2fbb776 = (level.var_a2fbb776 + 1) % 2;

  if(is_true(level.is_survival) && is_true(entity.has_awareness)) {
    function_eea7a68a(entity);
  }
}

function private function_5aeeecac(entity) {
  if(is_true(entity.var_4c85ebad)) {
    return;
  }

  radiusmultiplier = entity.var_e729ffb;

  if(!isDefined(radiusmultiplier)) {
    radiusmultiplier = 3;
  }

  forwardoffset = anglesToForward(entity.angles) * entity getpathfindingradius() * radiusmultiplier;
  var_d54999e4 = namespace_85745671::ee_head(entity, 0.8, forwardoffset);

  foreach(dynent in var_d54999e4) {
    if(!is_true(dynent.destroyed) && namespace_85745671::function_8f57dc52(dynent)) {
      entity.var_4c85ebad = 1;
      return;
    }
  }
}

function function_eea7a68a(entity) {
  entity.enemy_override = namespace_85745671::function_b67c088d();
  namespace_85745671::function_744beb04(entity);
  awareness::target_update(entity);
}

function function_1ca9d31b(entity) {
  if(!getdvarint(#"hash_397bf855bf5ab4de", 0)) {
    return;
  }

  var_577fefe8 = entity getpathfindingradius() + getDvar(#"hash_13d07d8f76be4095", 275);
  var_e86a4d9 = function_c3d68575(entity.origin, (var_577fefe8, var_577fefe8, entity function_6a9ae71()));
  height_check = max(entity function_6a9ae71(), 95);
  var_21bdf069 = sqr(isDefined(entity.var_c50d964) ? entity.var_c50d964 : entity getpathfindingradius());

  foreach(dynent in var_e86a4d9) {
    if(is_true(dynent.destroyed) || abs(dynent.origin[2] - entity.origin[2]) > height_check || !namespace_85745671::function_8f57dc52(dynent, 1)) {
      continue;
    }

    should_break = 0;
    var_144ce0a0 = dynent.script_noteworthy == # "hash_4d1fb8524fdfd254";

    if(var_144ce0a0 || dynent.destructible) {
      bundle = isDefined(dynent.bundle) ? dynent.bundle : zm_utility::function_b42da08a(dynent);
      state = function_ffdbe8c2(dynent);
      should_break = namespace_85745671::function_5ba8b9d4(entity, var_21bdf069, dynent, bundle, state, var_144ce0a0);
    }

    if(should_break && isDefined(bundle)) {
      dynent dodamage(dynent.health, entity.origin, entity, entity, undefined, "MOD_MELEE");
    }
  }
}

function zombieshouldmelee(entity) {
  if(is_true(entity.var_8a96267d) || is_true(entity.var_8ba6ede3)) {
    return false;
  }

  if(is_true(entity.var_4c85ebad)) {
    return true;
  }

  if(function_d8b225ae(entity)) {
    return true;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(!namespace_85745671::is_player_valid(entity.enemy) && !namespace_85745671::function_1b9ed9b0(entity.enemy) && !namespace_85745671::function_65e1fbbe(entity.enemy) && entity.team === level.zombie_team) {
    return false;
  }

  if(is_true(entity.ignoremelee)) {
    return false;
  }

  meleedistsq = zombiebehavior::function_997f1224(entity);
  enemy_vehicle = undefined;
  enemy = zm_ai_utility::function_825317c(entity);
  enemy = isDefined(enemy) ? enemy : entity.enemy;
  test_origin = enemy.origin;

  if(isPlayer(enemy)) {
    if(namespace_85745671::function_142c3c86(enemy)) {
      enemy_vehicle = enemy getvehicleoccupied();
      test_origin = namespace_85745671::function_401070dd(enemy_vehicle, enemy);

      if(!isDefined(test_origin)) {
        test_origin = enemy.origin;
      }

      test_origin = getclosestpointonnavmesh(test_origin, 200, entity getpathfindingradius());

      if(!isDefined(test_origin)) {
        test_origin = enemy.origin;
      }
    } else if(isvehicle(enemy getgroundent())) {
      enemy_vehicle = enemy getgroundent();
      test_origin = isDefined(enemy.last_valid_position) ? enemy.last_valid_position : entity.enemy.origin;
    } else if(isvehicle(enemy getmoverent())) {
      enemy_vehicle = enemy getmoverent();
      test_origin = isDefined(enemy.last_valid_position) ? enemy.last_valid_position : enemy.origin;
    }

    if(isDefined(enemy_vehicle) && isDefined(entity.var_cbc65493)) {
      meleedistsq *= entity.var_cbc65493;
    }

    if(isDefined(enemy_vehicle) && isDefined(entity.var_a9db7324) && abs(enemy_vehicle getspeed()) > 0) {
      meleedistsq *= entity.var_a9db7324;
    }
  }

  z_delta = abs(entity.origin[2] - test_origin[2]);

  if(z_delta > (isDefined(entity.var_737e8510) ? entity.var_737e8510 : 64)) {
    return false;
  }

  if(z_delta < (isDefined(entity.var_f7f0128b) ? entity.var_f7f0128b : 40)) {
    if(distance2dsquared(entity.origin, test_origin) > meleedistsq) {
      return false;
    }
  } else if(distancesquared(entity.origin, test_origin) > meleedistsq) {
    return false;
  }

  if(!entity flag::get(#"hash_49b119b42f4610ea")) {
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(enemy.origin - entity.origin)[1]);

    if(abs(yawtoenemy) > (isDefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60)) {
      return false;
    }

    if(!entity cansee(isDefined(enemy_vehicle) ? enemy_vehicle : enemy)) {
      return false;
    }
  }

  if(distancesquared(entity.origin, test_origin) < sqr(40)) {
    entity.idletime = gettime();
    entity.idleorigin = entity.origin;
    return true;
  }

  if(isDefined(enemy_vehicle)) {
    entity.idletime = gettime();
    entity.idleorigin = entity.origin;
    return true;
  }

  if(is_true(self.isonnavmesh) && !tracepassedonnavmesh(entity.origin, isDefined(enemy.last_valid_position) ? enemy.last_valid_position : enemy.origin, enemy getpathfindingradius())) {
    return false;
  }

  entity.idletime = gettime();
  entity.idleorigin = entity.origin;
  return true;
}

function function_d8b225ae(entity) {
  if(!isDefined(entity.attackable)) {
    return false;
  }

  radius = entity.goalradius;

  if(is_true(entity.allowoffnavmesh)) {
    radius = 16;
  }

  if(isDefined(entity.var_b238ef38) && distance2dsquared(entity.origin, entity.var_b238ef38.position) < sqr(radius) && abs(entity.origin[2] - entity.var_b238ef38.position[2]) < 50) {
    return true;
  }

  return false;
}

function function_e8983bf3(target) {
  meleedistsq = 4096;

  if(isDefined(self.meleeweapon) && self.meleeweapon !== level.weaponnone) {
    meleedistsq = self.meleeweapon.aimeleerange * self.meleeweapon.aimeleerange;
  }

  distsq = distancesquared(self.origin, target.origin);

  if(distsq > meleedistsq * 1.44) {
    return false;
  }

  return true;
}

function private zombieshouldmove(entity) {
  return entity.allowoffnavmesh || entity haspath();
}

function private function_bfc25c77(entity) {
  if(!(isDefined(getgametypesetting(#"hash_2d40f1434ed94a2b")) ? getgametypesetting(#"hash_2d40f1434ed94a2b") : 0)) {
    return false;
  }

  if(self function_3c566724()) {
    return false;
  }

  startnode = entity.traversestartnode;

  if(!isnodeenabled(startnode)) {
    return false;
  }

  if(namespace_85745671::function_f4087909(startnode.var_597f08bf)) {
    entity.var_597f08bf = startnode.var_597f08bf;
    return true;
  }

  return false;
}

function private function_b9b03294(entity) {
  if(self function_3c566724()) {
    return true;
  }

  startnode = entity.traversestartnode;

  if(!isDefined(startnode) || !isnodeenabled(startnode)) {
    return false;
  }

  return true;
}

function private zombieshouldknockdown(entity) {
  return entity.knockdown === 1;
}

function private function_2a7b4aab(entity) {
  return entity.var_85c3882d === 1;
}

function private function_931b615f(entity) {
  if(entity hasvalidinterrupt("pain") || entity hasvalidinterrupt("death") || is_true(entity.knockdown)) {
    function_3f71b9c2(entity);
  }
}

function private function_e1b85c34(entity) {
  return is_true(entity.var_df840b81);
}

function function_e9e6482(entity) {
  if(!is_true(entity.var_8c4d3e5d)) {
    return false;
  }

  return true;
}

function function_67d5c154(entity) {
  if(isDefined(entity.var_62b4721) && entity.var_62b4721 + getdvarfloat(#"hash_2cc8a2770c6d6662", 3000) > gettime()) {
    return false;
  }

  return true;
}

function function_83a4da79(entity, asmstate) {
  animationstatenetworkutility::requeststate(entity, asmstate);
  return 5;
}

function function_596c95b0(entity, asmstate) {
  if(asmstate namespace_85745671::function_dc276637(asmstate)) {
    return 5;
  }

  return 4;
}

function function_5abf1ae8(entity, asmstate) {
  return 4;
}

function function_62fb515e(entity) {
  entity.var_62b4721 = gettime();
}

function function_10b38c5a(entity) {
  enemy = zm_ai_utility::function_825317c(entity);

  if(isPlayer(enemy)) {
    if(enemy isplayerswimming()) {
      return false;
    }

    if(enemy isinvehicle()) {
      vehicle = enemy getvehicleoccupied();

      if(namespace_85745671::function_7243fef2(vehicle)) {
        return false;
      }
    }
  }

  if(is_true(entity.var_1033fa72) && is_true(entity.var_9f6112bb) && (!isDefined(entity.var_6324ed63) || gettime() > entity.var_6324ed63)) {
    return true;
  }

  return false;
}

function function_837931eb(entity) {
  if(self.awarenesslevelcurrent != "combat") {
    return false;
  }

  return function_10b38c5a(entity);
}

function function_5ac985fe(entity) {
  if(getDvar(#"hash_2d0879ab385bc2c8", 0)) {
    return false;
  }

  return true;
}

function function_da99776f(entity) {
  entity.var_1033fa72 = undefined;
  entity.var_9f6112bb = undefined;

  if(isDefined(entity.var_5aaa7f76)) {
    toenemy = entity.var_5aaa7f76 - entity.origin;
    toenemyyaw = vectortoangles(toenemy)[1];
    forwardyaw = entity.angles[1];
    deltayaw = angleclamp180(toenemyyaw - forwardyaw);
    var_a94379e2 = abs(deltayaw) > 45 ? deltayaw - math::sign(deltayaw) * 45 : 0;
    targetyaw = toenemyyaw - ceil(abs(var_a94379e2) / 90) * 90 * math::sign(var_a94379e2);
    newangles = (entity.angles[0], targetyaw, entity.angles[2]);
    entity teleport(entity.origin, newangles);

    forwardangles = anglesToForward(newangles);
    recordline(entity.origin, entity.origin + forwardangles * 50, (0, 1, 0));
  }

  return true;
}

function function_a9602314(entity) {
  entity.var_1033fa72 = undefined;
  entity.var_9f6112bb = undefined;
}

function function_573545a(entity) {
  return is_true(entity.var_2772a472);
}

function function_c8caa34b(entity) {
  entity.var_2772a472 = undefined;
  return true;
}

function private zombiemoveactionstart(entity) {
  entity.movetime = gettime();
  entity.moveorigin = entity.origin;
  entity.var_13138acf = 0;
  entity.var_16b73748 = entity asmgetcurrentdeltaanimation();

  if(isDefined(entity.var_16b73748)) {
    entity.var_cb2a43c0 = getmovedelta(entity.var_16b73748) / getanimlength(entity.var_16b73748) * 0.5;
  }

  return true;
}

function private zombiemoveactionupdate(entity) {
  if(!isDefined(entity.var_16b73748) || entity asmgetcurrentdeltaanimation() !== entity.var_16b73748) {
    entity.var_16b73748 = entity asmgetcurrentdeltaanimation();

    if(isDefined(entity.var_16b73748)) {
      entity.var_cb2a43c0 = getmovedelta(entity.var_16b73748) / getanimlength(entity.var_16b73748) * 0.5;
    }
  }

  if(!is_true(entity.missinglegs) && gettime() - entity.movetime >= 1000 && isDefined(entity.var_cb2a43c0)) {
    distsq = distancesquared(entity.origin, entity.moveorigin);

    if(distsq < lengthsquared(entity.var_cb2a43c0) && !is_true(entity.cant_move)) {
      if(isDefined(entity.cant_move_cb)) {
        entity thread[[entity.cant_move_cb]]();
      }
    }

    entity.movetime = gettime();
    entity.moveorigin = entity.origin;
  }

  return true;
}

function private function_7c8e35e8(entity, asmstate) {
  if(isDefined(self.traversestartnode)) {
    node = entity.traversestartnode;

    if(entity.traversestartnode.type !== # "begin" && entity.traversestartnode.type !== "Volume") {
      node = getothernodeinnegotiationpair(node);
    }

    unlinktraversal(node);
    entity.var_834b0770 = node;
    node.owner = entity;

    if(entity.archetype !== # "zombie" && !isentity(entity.var_597f08bf)) {
      entity callback::function_d8abfc3d(#"on_ai_melee", &damagedoor);
    }

    if(isDefined(asmstate)) {
      animationstatenetworkutility::requeststate(entity, asmstate);
    }

    entity pathmode("dont move");
  }

  if(isDefined(entity.var_597f08bf)) {
    entity.var_a476b329 = entity.var_597f08bf.angles;
  }

  if(!isDefined(self.traversemantlenode)) {
    entity.var_df840b81 = 1;
  } else {
    entity.var_df840b81 = undefined;
  }

  return 5;
}

function private function_fee7d867(entity, asmstate) {
  if(entity asmgetstatus() == "asm_status_complete" && isDefined(asmstate)) {
    animationstatenetworkutility::requeststate(entity, asmstate);
  }

  if(isDefined(entity.var_597f08bf) && isDefined(entity.var_a476b329) && abs(vectordot(anglesToForward(entity.var_a476b329), anglesToForward(entity.var_597f08bf.angles)) < 0.5)) {
    return 4;
  }

  if(!namespace_85745671::function_f4087909(entity.var_597f08bf)) {
    return 4;
  }

  goalinfo = entity function_4794d6a3();

  if(isDefined(goalinfo) && isDefined(goalinfo.goalpos)) {
    var_f940b57b = goalinfo.goalpos;
  }

  if(!isDefined(var_f940b57b) && isDefined(entity.favoriteenemy)) {
    var_f940b57b = entity.favoriteenemy.last_valid_position;
  }

  if(isDefined(var_f940b57b) && abs(var_f940b57b[2] - entity.origin[2]) < 100 && vectordot(anglesToForward(entity.angles), var_f940b57b - entity.origin) < 0) {
    entity.var_df840b81 = undefined;
    return 4;
  }

  return 5;
}

function private function_3f71b9c2(entity, asmstate) {
  asmstate finishtraversal();
  asmstate pathmode("move allowed", 1);

  if(isDefined(asmstate.var_834b0770)) {
    linktraversal(asmstate.var_834b0770);
    asmstate.var_834b0770.owner = undefined;
    asmstate.var_834b0770 = undefined;
  }

  asmstate.var_597f08bf = undefined;
  asmstate.var_a476b329 = undefined;
  asmstate callback::function_52ac9652(#"on_ai_melee", &damagedoor);

  if(asmstate asmgetstatus() == "asm_status_running") {
    asmstate.var_fc781a6f = 1;
  }

  return 4;
}

function zombieknockdownactionstart(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_knockdown_type", behaviortreeentity.knockdown_type);
  behaviortreeentity setblackboardattribute("_knockdown_direction", behaviortreeentity.knockdown_direction);
  behaviortreeentity setblackboardattribute("_getup_direction", behaviortreeentity.getup_direction);
  behaviortreeentity collidewithactors(0);
  behaviortreeentity val::set(#"zombie_knockdown", "blockingpain", 1);
}

function private function_c8939973(behaviortreeentity) {
  behaviortreeentity.knockdown = 0;
  behaviortreeentity collidewithactors(1);
  behaviortreeentity clearpath();
  behaviortreeentity val::reset(#"zombie_knockdown", "blockingpain");
}

function private zombiegetupactionterminate(behaviortreeentity) {
  behaviortreeentity.knockdown = 0;
  behaviortreeentity collidewithactors(1);
  behaviortreeentity clearpath();
  behaviortreeentity val::reset(#"zombie_knockdown", "blockingpain");
}

function private function_78106a79(entity, asmstatename) {
  if(asmstatename ai::is_stunned() || is_true(asmstatename.var_85c3882d)) {
    return 5;
  }

  return 4;
}

function private function_f8250d5e(entity) {
  entity.idletime = gettime();
  entity.idleorigin = entity.origin;
  return true;
}

function private function_860d5d8(entity) {
  if(!is_true(entity.missinglegs) && gettime() - entity.idletime > 1000) {
    if(is_true(level.is_survival) == 1 && gettime() - entity.idletime < 1700) {
      return;
    }

    distsq = distance2dsquared(entity.origin, entity.idleorigin);

    if(distsq < 144) {
      if(isDefined(entity.cant_move_cb)) {
        entity thread[[entity.cant_move_cb]]();
      }
    }

    entity.idletime = gettime();
    entity.idleorigin = entity.origin;
  }

  return 1;
}

function private function_f37b0fbd(entity) {
  entity clearpath();
}

function private function_79c3a487(entity) {
  entity clientfield::set("zombie_riser_fx", 1);
}

function private showzombie(entity) {
  entity show();
}

function private damagedoor(entity) {
  if(isDefined(self.var_597f08bf)) {
    if(self.var_597f08bf.targetname !== "barricade_window") {
      damage = isDefined(self.var_1a6dcdff) ? self.var_1a6dcdff : 30;

      if(is_true(self.instakill_doors)) {
        damage = self.var_597f08bf.health;
      }

      self.var_597f08bf dodamage(damage, self.origin, self, self, "none", "MOD_EXPLOSIVE");

      if(!isDefined(self.var_597f08bf) || self.var_597f08bf.health <= 0) {
        self.var_597f08bf = undefined;
      }

      return;
    }

    self.var_597f08bf notify(#"hash_5cfbbb6ee8378665");
  }
}

function private function_81349d20(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(self.attackable)) {
    self orientmode("face point", self.attackable.origin);
  } else {
    self orientmode("face current");
  }

  self animmode("angle deltas");
}

function function_8aa7d53(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  forward = mocompduration.traversalendpos - mocompduration.traversalstartpos;
  forward = (forward[0], forward[1], 0);

  if(!isDefined(mocompduration.traversemantlenode)) {
    mocompduration forceteleport(mocompduration.origin, mocompduration.angles, 0);
    mocompduration animmode("noclip", 0);
    mocompduration orientmode("face angle", vectortoangles(forward)[1]);
    return;
  }

  var_ce870aa5 = 13 + mocompduration getpathfindingradius();
  mocompduration.var_910c3b2c = mocompduration.traversemantlenode.origin - vectornormalize(forward) * var_ce870aa5;
  mocompduration.var_910c3b2c = (mocompduration.var_910c3b2c[0], mocompduration.var_910c3b2c[1], mocompduration.traversalstartpos[2]);
  mocompduration animmode("angle deltas noclip", 0);
  mocompduration orientmode("face angle", vectortoangles(forward)[1]);
  mocompduration forceteleport(mocompduration.var_910c3b2c, mocompduration.angles, 0);
}

function function_933af241(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(mocompduration.attackable)) {
    self orientmode("face point", self.attackable.origin);
    return;
  }

  enemy = isDefined(self.enemy) ? self.enemy : self.favoriteenemy;

  if(isDefined(enemy)) {
    self orientmode("face point", enemy.origin);
    return;
  }

  self orientmode("face enemy");
}

function zombieupdategoal(goalpos) {
  aiprofile_beginentry("zombieUpdateGoal");
  shouldrepath = 0;
  zigzag_activation_distance = level.zigzag_activation_distance;

  if(isDefined(self.zigzag_activation_distance)) {
    zigzag_activation_distance = self.zigzag_activation_distance;
  }

  pathgoalpos = self.pathgoalpos;
  var_c7dee8e5 = distancesquared(self.origin, goalpos);
  var_e24852e1 = distance2dsquared(self.origin, goalpos);
  var_61cfbe48 = 0;
  var_12846c4b = 0;
  var_243f24d9 = function_da10cda3(self.origin, goalpos, self);

  if(isDefined(var_243f24d9) && isDefined(self.var_6cf4ab11)) {
    goalpos = var_243f24d9;
    var_12846c4b = 1;
  }

  if(isDefined(self.var_40e7d5fb)) {
    self[[self.var_40e7d5fb]](goalpos);
  }

  if(getdvarint(#"hash_6e49c9088d49cb70", 1) > 0) {
    var_20edce9c = isDefined(self.var_62561fdc) ? self.var_62561fdc : getdvarfloat(#"hash_53b69693de5913be", 1250);

    if(var_e24852e1 > sqr(var_20edce9c)) {
      vectogoal = goalpos - self.origin;
      disttogoal = sqrt(var_c7dee8e5);
      dirtogoal = vectorscale(vectogoal, 1 / disttogoal);
      var_625d15c1 = getdvarint(#"hash_2d576274bf096bb1", 5);
      var_e8b40f42 = isDefined(self.var_cfb82e92) ? self.var_cfb82e92 : 2;
      var_2a45598f = isDefined(self.var_a44ca810) ? self.var_a44ca810 : getdvarfloat(#"hash_70d5ce88e4373b4a", 500);
      var_188c33e9 = [self.origin + dirtogoal * var_2a45598f];

      for(point_i = 0; point_i < var_625d15c1; point_i++) {
        percentage = 0.3 + point_i * 0.1;

        if(disttogoal * percentage > var_2a45598f) {
          var_188c33e9[var_188c33e9.size] = self.origin + dirtogoal * disttogoal * percentage;
        }
      }

      var_a2dcc3fb = undefined;
      best_point = undefined;
      var_dd9d0d3b = 0;
      var_f7a5acc7 = isDefined(level.var_177b14f8) ? level.var_177b14f8 : getdvarfloat(#"hash_340ef7499f8caf47", 500);

      if(var_12846c4b) {
        var_f7a5acc7 *= 0.2;
      }

      for(point_i = 0; point_i < var_188c33e9.size; point_i++) {
        point = var_188c33e9[point_i];
        var_b3e12265 = function_9cc082d2(point, var_f7a5acc7);

        if(isDefined(var_b3e12265[#"point"])) {
          if(ispointonnavmesh(var_b3e12265[#"point"], self)) {
            if(getdvarint(#"hash_8379681233f9701", 0) > 0) {
              recordline(point, var_b3e12265[#"point"], (1, 0, 1));
            }

            z_dist = abs(var_b3e12265[#"point"][2] - point[2]);

            if(!isDefined(var_a2dcc3fb) || var_a2dcc3fb > z_dist) {
              var_a2dcc3fb = z_dist;
              best_point = var_b3e12265[#"point"];
            }

            var_dd9d0d3b++;

            if(var_dd9d0d3b >= var_e8b40f42) {
              if(getdvarint(#"hash_8379681233f9701", 0) > 0) {
                recordline(point, self.origin, (1, 0, 1));
              }

              break;
            }
          }
        }
      }

      if(getdvarint(#"hash_8379681233f9701", 0) > 0) {
        if(isDefined(best_point)) {
          recordsphere(best_point, 10, (1, 0, 1));
        } else {
          foreach(point in var_188c33e9) {
            recordsphere(point, 8, (1, 0, 0));
          }
        }
      }

      if(isDefined(best_point)) {
        goalpos = best_point;
        var_61cfbe48 = 1;
      }
    }
  }

  if(is_true(self.var_4fe4e626)) {
    self.var_4fe4e626 = 0;
    shouldrepath = 1;
  } else if(!var_61cfbe48 && isDefined(self.var_9e6e6645) && distancesquared(self.var_9e6e6645, goalpos) > sqr(18)) {
    shouldrepath = 1;
  } else if(var_61cfbe48 && isDefined(self.var_9e6e6645) && isDefined(self.var_d4118e22) && distancesquared(self.var_9e6e6645, goalpos) > self.var_d4118e22 * 0.5) {
    shouldrepath = 1;
  } else if(!isDefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
    shouldrepath = 1;
  } else if(var_c7dee8e5 <= sqr(zigzag_activation_distance)) {
    shouldrepath = 1;
  } else if(isDefined(pathgoalpos)) {
    distancetogoalsqr = distancesquared(self.origin, pathgoalpos);
    shouldrepath = distancetogoalsqr < sqr(72);
  }

  if(is_true(level.validate_on_navmesh)) {
    if(!ispointonnavmesh(self.origin, self)) {
      shouldrepath = 0;
    }
  }

  if(is_true(self.keep_moving)) {
    if(gettime() > self.keep_moving_time) {
      self.keep_moving = 0;
    }
  }

  if(self function_dd070839() || self isplayinganimscripted()) {
    shouldrepath = 0;
  }

  if(isactor(self) && self asmistransitionrunning() || self asmistransdecrunning()) {
    shouldrepath = 0;
  }

  if(shouldrepath) {
    self setgoal(goalpos);
    self.var_9e6e6645 = goalpos;

    if(var_61cfbe48) {
      self.var_d4118e22 = distancesquared(self.origin, goalpos);
    }

    should_zigzag = 0;

    if(isDefined(level.should_zigzag)) {
      should_zigzag = self[[level.should_zigzag]]();
    } else if(isDefined(self.should_zigzag)) {
      should_zigzag = self.should_zigzag;
    }

    if(isDefined(self.var_592a8227)) {
      should_zigzag = should_zigzag && self.var_592a8227;
    }

    var_eb1c6f1c = 0;

    if(is_true(level.do_randomized_zigzag_path) && should_zigzag) {
      if(distancesquared(self.origin, goalpos) > sqr(zigzag_activation_distance)) {
        self.keep_moving = 1;
        self.keep_moving_time = gettime() + 700;
        path = undefined;

        if(is_true(self.var_ceed8829)) {
          pathdata = generatenavmeshpath(self.origin, goalpos, self);

          if(isDefined(pathdata) && pathdata.status === "succeeded" && isDefined(pathdata.pathpoints)) {
            path = pathdata.pathpoints;
          }
        } else {
          path = self calcapproximatepathtoposition(goalpos, 0);
        }

        if(isDefined(path)) {
          if(getdvarint(#"ai_debugzigzag", 0)) {
            for(index = 1; index < path.size; index++) {
              recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x38>", self);
              record3dtext(abs(path[index - 1][2] - path[index][2]), path[index - 1], (1, 0, 0));
            }
          }

          deviationdistance = randomintrange(level.zigzag_distance_min, level.zigzag_distance_max);

          if(isDefined(self.zigzag_distance_min) && isDefined(self.zigzag_distance_max)) {
            deviationdistance = randomintrange(self.zigzag_distance_min, self.zigzag_distance_max);
          }

          segmentlength = 0;

          for(index = 1; index < path.size; index++) {
            if(isDefined(level.var_562c8f67) && abs(path[index - 1][2] - path[index][2]) > level.var_562c8f67) {
              break;
            }

            currentseglength = distance(path[index - 1], path[index]);
            var_570a7c72 = segmentlength + currentseglength > deviationdistance;

            if(index == path.size - 1 && !var_570a7c72) {
              deviationdistance = segmentlength + currentseglength - 1;
              var_eb1c6f1c = 1;
            }

            if(var_570a7c72 || var_eb1c6f1c) {
              remaininglength = deviationdistance - segmentlength;
              dir = vectornormalize(path[index] - path[index - 1]);
              seedposition = path[index - 1] + dir * remaininglength;

              recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x38>", self);

              innerzigzagradius = level.inner_zigzag_radius;

              if(var_eb1c6f1c) {
                innerzigzagradius = 0;
              } else if(isDefined(self.inner_zigzag_radius)) {
                innerzigzagradius = self.inner_zigzag_radius;
              }

              outerzigzagradius = level.outer_zigzag_radius;

              if(var_eb1c6f1c) {
                outerzigzagradius = 48;
              } else if(isDefined(self.outer_zigzag_radius)) {
                outerzigzagradius = self.outer_zigzag_radius;
              }

              if(getdvarint(#"hash_32b7866126eb3f6", 1)) {
                queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
              } else {
                queryresult = {
                  #data: function_bc777234(seedposition, dir, 4, max(innerzigzagradius, outerzigzagradius / 2), outerzigzagradius, 36, self getpathfindingradius())
                };
              }

              positionquery_filter_inclaimedlocation(queryresult, self);
              queryresult.data = function_7b8e26b3(queryresult.data, 0, "inClaimedLocation");

              if(queryresult.data.size > 0) {
                a_data = array::randomize(queryresult.data);

                for(i = 0; i < a_data.size; i++) {
                  point = a_data[i];
                  n_z_diff = seedposition[2] - point.origin[2];

                  if(abs(n_z_diff) < 32) {
                    if(getdvarint(#"ai_debugzigzag", 0)) {
                      recordstar(point.origin, (1, 0.5, 0), "<dev string:x38>");
                    }

                    self setgoal(point.origin);
                    break;
                  }
                }
              }

              break;
            }

            segmentlength += currentseglength;
          }
        }
      }
    }

    if(!isDefined(self.attackable)) {
      var_6f520cc1 = isDefined(self.var_9b6bfdb7) ? self.var_9b6bfdb7 : 500;
      self.nextgoalupdate = gettime() + randomintrange(var_6f520cc1, var_6f520cc1 + 500);
    }
  }

  aiprofile_endentry();
}

function function_bc777234(position, forward, max_points, inner_radius, outer_radius, max_height, var_5e95f317) {
  points = [];
  var_467c5362 = getclosestpointonnavmesh(position, 256);
  var_8bd451f5 = sqr(inner_radius);
  angles = vectortoangles(forward);
  z_axis = (0, 0, 1);

  if(isDefined(var_467c5362)) {
    for(i = 0; i < max_points; i++) {
      point2d = namespace_85745671::function_4ed3741d(var_467c5362, angles, 0, outer_radius, inner_radius, 45, 135);
      traceresult = checknavmeshdirection(var_467c5362, point2d, randomfloatrange(inner_radius, outer_radius), var_5e95f317);

      if(abs(traceresult[2] - var_467c5362[2]) <= max_height && distancesquared(traceresult, var_467c5362) < var_8bd451f5) {
        points[points.size] = {
          #origin: traceresult
        };
      }
    }
  }

  return points;
}

function function_da10cda3(start_pos, target_pos, entity) {
  var_779f1a5a = function_4a66d8b8(start_pos);
  var_2bd0375c = function_4a66d8b8(target_pos);

  if(!isDefined(var_779f1a5a) && !isDefined(var_2bd0375c)) {
    return undefined;
  }

  if(!isDefined(var_779f1a5a)) {
    if(abs(start_pos[2] - target_pos[2]) < 100) {
      return undefined;
    }

    entrance = arraygetclosest(start_pos, var_2bd0375c.entrance_nodes);
    return entrance.origin;
  }

  var_bc4e29ad = undefined;

  if(!isDefined(var_2bd0375c)) {
    target_node = arraygetclosest(start_pos, var_779f1a5a.entrance_nodes);
    var_bc4e29ad = isDefined(target_node.floor) ? target_node.floor : 1;
  } else {
    var_bc4e29ad = function_f9fdba15(target_pos, var_779f1a5a);
  }

  if(isDefined(var_779f1a5a.var_1fa7d27e)) {
    if(var_bc4e29ad < var_779f1a5a.var_1fa7d27e) {
      return undefined;
    }
  }

  var_e9521bba = function_f9fdba15(start_pos, var_779f1a5a);

  if(var_e9521bba === var_bc4e29ad) {
    return undefined;
  }

  if(isDefined(var_e9521bba) && isDefined(var_bc4e29ad) && abs(var_e9521bba - var_bc4e29ad) <= 1) {
    return undefined;
  }

  if(isDefined(entity)) {
    if(entity.var_6cf4ab11 === var_e9521bba && entity.var_4bee9956 === var_bc4e29ad && isDefined(entity.var_bd780e50)) {
      return entity.var_bd780e50.origin;
    }

    entity.var_6cf4ab11 = var_e9521bba;
    entity.var_4bee9956 = var_bc4e29ad;
  }

  var_d236d431 = int(math::sign(var_bc4e29ad - var_e9521bba));
  var_f35f1428 = int(var_e9521bba + var_d236d431);

  if(!isarray(var_779f1a5a.var_2dfb472b) || !isarray(var_779f1a5a.var_2dfb472b[var_f35f1428])) {
    return undefined;
  }

  var_7e1aa280 = arraygetclosest(start_pos, var_779f1a5a.var_2dfb472b[var_f35f1428]);

  if(isDefined(entity)) {
    entity.var_bd780e50 = var_7e1aa280;
  }

  return var_7e1aa280.origin;
}

function private function_f9fdba15(pos, volume) {
  for(i = 0; i < volume.var_8b2a5592.size; i++) {
    var_8b2a5592 = volume.var_8b2a5592[i];
    var_f3fed7c8 = getdvarfloat(#"hash_2e8b86373453b320", 100);

    if(i > 0 && isDefined(volume.var_8b2a5592[i - 1])) {
      var_f3fed7c8 = min(var_f3fed7c8, (volume.var_8b2a5592[i] - volume.var_8b2a5592[i - 1]) * 0.5);
    }

    if(pos[2] < var_8b2a5592 - var_f3fed7c8) {
      return max(i - 1, 1);
    }
  }

  if(pos[2] > volume.var_8b2a5592[volume.var_8b2a5592.size - 1] - var_f3fed7c8) {
    return (volume.var_8b2a5592.size - 1);
  }

  return 1;
}

function private function_b9b83baf(nodes, floor) {
  var_2f50719 = [];

  foreach(node in nodes) {
    if(node.floor === floor) {
      var_2f50719[var_2f50719.size] = node;
    }
  }

  return var_2f50719;
}

function private function_a3627e9d(volume, var_7f631617) {
  if(!isDefined(volume.var_2dfb472b[var_7f631617])) {
    return -2147483647;
  }

  var_9f7113d2 = [];

  foreach(node in volume.var_2dfb472b[var_7f631617]) {
    var_9f7113d2[var_9f7113d2.size] = node.origin[2];
  }

  if(var_9f7113d2.size <= 0) {
    return -2147483647;
  }

  return math::array_average(var_9f7113d2);
}

function private function_4a66d8b8(pos) {
  if(!isDefined(level.var_afa5478b)) {
    return undefined;
  }

  volume = undefined;
  var_7c9ec4a4 = arraysortclosest(level.var_afa5478b, pos, 1, undefined, level.var_1b2515eb);

  foreach(var_d0b125c in var_7c9ec4a4) {
    if(function_fc3f770b(var_d0b125c.origin + var_d0b125c getmins(), var_d0b125c.origin + var_d0b125c getmaxs(), pos)) {
      if(isDefined(volume)) {
        println("<dev string:x46>" + pos);
      }

      volume = var_d0b125c;
    }
  }

  return volume;
}