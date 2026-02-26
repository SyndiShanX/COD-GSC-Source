/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2fe8f3019ef027c7.gsc
***********************************************/

#using script_1940fc077a028a81;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\ai\zm_ai_hulk;
#using scripts\zm_common\zm_utility;
#namespace namespace_45b55437;

function private autoexec __init__system__() {
  system::register(#"hash_7d755ebddd333af6", &preinit, undefined, undefined, undefined);
}

function preinit() {
  spawner::add_archetype_spawn_function(#"hulk", &function_a8e554a7);
  clientfield::register("scriptmover", "hs_heal_station_cf", 1, 1, "int");
  level.var_36bc0c68 = &function_36bc0c68;
  level.var_36f62b58 = [];

  for(i = 0; i < 4; i++) {
    station = spawn("script_model", (0, 0, 0));
    station.var_4f67a9d8 = 0;
    level.var_36f62b58[level.var_36f62b58.size] = station;
  }
}

function function_a8e554a7() {
  function_db7f78a1();
  self flag::set(#"hash_7b1f9f26f086bf39");
  self.ai.var_870d0893 = 1;
  setup_awareness(self);
  self.var_95ee6823 = 0.3;
  self callback::function_d8abfc3d(#"on_ai_killed", &function_914f5e7);
}

function private function_db7f78a1() {
  blackboard::createblackboardforentity(self);
  self.___archetypeonanimscriptedcallback = &function_4668e5c8;
}

function private function_4668e5c8(entity) {
  entity.__blackboard = undefined;
  entity function_db7f78a1();
}

function private function_36bc0c68(var_c165d3f1) {
  if(isDefined(var_c165d3f1)) {
    awareness::function_c241ef9a(self, var_c165d3f1, 10);
  }

  self.var_958e7ee4 = 1;
  self.var_eb3258b = 1.5;
  self.wander_radius = 300;
  self callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_e0569aac);
}

function private function_e0569aac(entity) {
  if(self.current_state.name === # "wander") {
    self namespace_85745671::function_9758722(#"run");
  }
}

function private setup_awareness(entity) {
  entity.fovcosine = 0.5;
  entity.maxsightdistsqrd = sqr(1000);
  entity.has_awareness = 1;
  entity.ignorelaststandplayers = 1;
  entity.var_1267fdea = 1;
  self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
  self callback::function_d8abfc3d(#"hash_4afe635f36531659", &function_2d6a2f29);
  awareness::register_state(entity, #"wander", &function_f15c97d9, &function_9e9747be, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
  awareness::register_state(entity, #"investigate", &function_901d8509, &function_592c1713, &awareness::function_34162a25, undefined, &awareness::function_a360dd00);
  awareness::register_state(entity, #"chase", &function_56c1d8bd, &function_69a0630b, &awareness::function_b9f81e8b, &function_eabb6f2f);
  awareness::set_state(entity, #"wander");
  entity callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &function_bf7037e9);
  entity thread awareness::function_fa6e010d();
}

function private function_2d6a2f29(entity) {
  if(self.current_state.name === # "wander") {
    function_1eaaceab(self.var_4dfe3675);

    if(self.var_4dfe3675.size > 3) {
      self.var_4dfe3675 = arraysortclosest(self.var_4dfe3675, self.origin);

      for(i = self.var_4dfe3675.size; i > self.var_886fb230; i--) {
        if(!isDefined(self.var_4dfe3675[i])) {
          continue;
        }

        self.var_4dfe3675[i] callback::callback(#"hash_10ab46b52df7967a");
        self.var_4dfe3675[i] = -1;
      }

      arrayremovevalue(self.var_4dfe3675, -1);
    }

    return;
  }

  if(self.current_state.name === # "chase") {
    if(isarray(self.var_4dfe3675)) {
      function_1eaaceab(self.var_4dfe3675);
      enemy_array = [];

      foreach(ent_num, struct in self.var_f7c25ec3) {
        ent = getentbynum(ent_num);

        if(namespace_85745671::is_player_valid(ent)) {
          enemy_array[enemy_array.size] = ent;
        }
      }

      foreach(zombie in self.var_4dfe3675) {
        if(zombie.current_state.name === # "wander" && !isDefined(zombie.favoriteenemy)) {
          var_c50b055c = undefined;

          if(enemy_array.size) {
            var_c50b055c = arraygetclosest(zombie.origin, enemy_array);
          } else if(isDefined(self.favoriteenemy)) {
            var_c50b055c = self.favoriteenemy;
          }

          if(isDefined(var_c50b055c)) {
            awareness::function_c241ef9a(zombie, var_c50b055c, 10);
          }
        }
      }
    }
  }
}

function function_bf7037e9(params) {
  self endon(#"death");

  if(isDefined(self.attackable)) {
    namespace_85745671::function_2b925fa5(self);
  }

  self.var_98f1f37c = 1;
  function_5b676fe6(self);
  self kill(undefined, undefined, undefined, undefined, 0, 1);
}

function function_f15c97d9(entity) {
  entity.var_f7c25ec3 = [];
  self.var_9f6112bb = 1;
  entity.awarenesslevelcurrent = "unaware";
  entity.var_eb5eeb0f = [];
  entity flag::clear(#"hash_796c46c58710430a");
  entity.favoriteenemy = undefined;
  entity.var_41611e5c = undefined;
  function_5b676fe6(entity);

  if(entity.health >= entity.maxhealth) {
    entity notify(#"hash_3f015eab8b2c125a");
  }

  if(entity zm_ai_hulk::function_e0487da2()) {
    entity thread function_e3ea1f6f(entity);
  } else if(ispointonnavmesh(entity.origin, entity) && !is_true(entity.var_7496eca2)) {
    entity thread awareness::function_3bac247(entity);
  }

  entity callback::function_d8abfc3d(#"awareness_event", &awareness::function_cf2fab43);
}

function function_e3ea1f6f(entity) {
  entity endon(#"death", #"state_changed");

  while(true) {
    flag::wait_till_clear(#"pause_awareness");
    goal = function_c8417113(entity);

    if(flag::get(#"pause_awareness")) {
      continue;
    }

    if(!isDefined(goal)) {
      goal = entity.origin;
    }

    entity namespace_e292b080::zombieupdategoal(goal);
    waitframe(1);
  }
}

function function_9e9747be(entity) {
  if(isDefined(entity.enemy)) {
    var_e91a592a = entity awareness::function_c91092d2(entity.enemy, entity.var_1267fdea) || entity seerecently(entity.enemy, 1) && namespace_85745671::function_142c3c86(entity.enemy);
    var_7be806db = entity attackedrecently(entity.enemy, 1);
    var_8bbedf63 = entity.enemy attackedrecently(entity, 1);

    if(var_e91a592a || var_7be806db || var_8bbedf63) {
      entity.favoriteenemy = entity.enemy;
      entity.var_5aaa7f76 = entity.favoriteenemy.origin;
    }
  }

  if(isDefined(entity.favoriteenemy)) {
    awareness::set_state(entity, #"chase");
    return;
  }

  if(isDefined(entity.var_b4b8ad5f) && distance2dsquared(entity.var_b4b8ad5f.position, entity.origin) < sqr(2500)) {
    awareness::set_state(entity, #"investigate");
    return;
  }
}

function function_901d8509(entity) {}

function function_592c1713(entity) {
  player = awareness::function_d7fedde2(self);

  if(isDefined(player) && distance2dsquared(player.origin, self.origin) < sqr(2500)) {
    entity.favoriteenemy = player;
    awareness::set_state(entity, #"chase");
    return;
  }

  awareness::set_state(entity, #"wander");
}

function function_a7eadb40(entity, target) {
  n_players = getplayers().size;

  if(!isDefined(target) || n_players <= 1) {
    return;
  }

  if(!isDefined(entity.var_c6c4dded)) {
    entity.var_c6c4dded = [];
  }

  if(!isDefined(entity.var_c6c4dded)) {
    entity.var_c6c4dded = [];
  } else if(!isarray(entity.var_c6c4dded)) {
    entity.var_c6c4dded = array(entity.var_c6c4dded);
  }

  if(!isinarray(entity.var_c6c4dded, target)) {
    entity.var_c6c4dded[entity.var_c6c4dded.size] = target;
  }
}

function function_e88cf541(entity, target) {
  return isDefined(entity.var_c6c4dded) && isinarray(entity.var_c6c4dded, target);
}

function function_56c1d8bd(entity) {
  entity.var_36f62b58 = [];
  entity.var_c6c4dded = [];
  entity thread function_98e8c136(entity);

  if(zm_ai_hulk::function_3104c18c(entity)) {
    zm_ai_hulk::function_96319b66(entity);
  }

  if(isDefined(entity.enemy)) {
    zm_ai_hulk::function_e5717670(entity.enemy);
  }

  awareness::function_978025e4(entity);
}

function function_eabb6f2f(entity) {
  if(!isDefined(entity.var_c6845438)) {
    entity.var_c6845438 = 0;
  }

  if(entity.ignoreall) {
    entity.favoriteenemy = undefined;
    entity.var_bd1d170c = 1;
    return;
  }

  var_27ae492c = float(gettime() - entity.var_c6845438) / 1000 > 10;
  var_3b649c5c = !zm_utility::is_player_valid(entity.favoriteenemy, 1) || isDefined(entity.favoriteenemy) && distance2dsquared(entity.favoriteenemy.origin, entity.origin) > sqr(2500);

  if(var_27ae492c || var_3b649c5c) {
    if(is_true(entity.var_26a916e5)) {
      possible_targets = function_a1ef346b();
      possible_targets = arraysortclosest(possible_targets, entity.origin, undefined, 0, 2500);
      valid_targets = [];

      foreach(target in possible_targets) {
        if(!zm_utility::is_player_valid(target)) {
          continue;
        }

        valid_targets[valid_targets.size] = target;

        if(vectordot(target.origin - entity.origin, anglesToForward(entity.angles)) > 0) {
          entity.favoriteenemy = target;
          return;
        }
      }

      entity.favoriteenemy = valid_targets[0];

      if(!isDefined(entity.favoriteenemy)) {
        entity.var_bd1d170c = 1;
      }

      return;
    }

    closest = awareness::function_d7fedde2(entity);

    if(!isDefined(closest) || distance2dsquared(closest.origin, entity.origin) > sqr(2500)) {
      entity.favoriteenemy = undefined;
      entity.var_bd1d170c = 1;
      var_16969010 = 0;

      foreach(player in getplayers()) {
        if(player.ignoreme || player isnotarget()) {
          var_16969010 = 1;
        }
      }

      entity.var_3c066529 = var_16969010;
      return;
    }

    var_400d4b0c = undefined;
    nodes = zm_ai_hulk::function_71979c65(entity, closest.origin);

    if(nodes.size <= 0 || function_e88cf541(entity, closest)) {
      possible_targets = function_a1ef346b();

      if(isDefined(entity.var_c6c4dded) && entity.var_c6c4dded.size >= possible_targets.size) {
        entity.var_c6c4dded = [];
      }

      arraysortclosest(possible_targets, entity.origin);

      foreach(target in possible_targets) {
        if(zm_utility::is_player_valid(target) && !function_e88cf541(entity, target)) {
          var_49defc50 = zm_ai_hulk::function_71979c65(entity, target.origin);

          if(var_49defc50.size > 0) {
            var_400d4b0c = target;
            break;
          }

          function_a7eadb40(entity, target);
        }
      }
    } else {
      var_400d4b0c = closest;
    }

    entity flag::set_val(#"hash_796c46c58710430a", isDefined(var_400d4b0c));
    var_e9cc7ca4 = isDefined(var_400d4b0c) ? var_400d4b0c : closest;

    if(entity.favoriteenemy !== var_e9cc7ca4) {
      entity.var_c6845438 = gettime();
    }

    if(var_e9cc7ca4 === undefined) {}

    entity.favoriteenemy = var_e9cc7ca4;
    entity.var_41611e5c = isDefined(entity.favoriteenemy) ? entity.favoriteenemy : entity.var_41611e5c;
  }
}

function function_69a0630b(entity) {
  if(isDefined(entity.favoriteenemy) || is_true(entity.var_f0ee16db)) {
    goal = undefined;

    if(entity zm_ai_hulk::function_e0487da2() && !namespace_e292b080::function_10b38c5a(entity)) {
      goal = function_c8417113(entity);
    } else if(isDefined(entity.favoriteenemy)) {
      goal = awareness::function_d0939c67(entity, entity.favoriteenemy, 32);
    }

    if(isDefined(goal)) {
      entity namespace_e292b080::zombieupdategoal(goal);
    }

    return;
  }

  if(!is_true(entity.var_3c066529)) {
    entity callback::function_52ac9652(#"awareness_event", &awareness::function_cf2fab43);
    awareness::set_state(entity, #"wander");
  }
}

function private function_c8417113(entity) {
  if(!isDefined(entity.var_7f73c6e1)) {
    entity.var_7f73c6e1 = [];
  }

  var_d673b0d0 = zm_ai_hulk::function_5e80cd88(entity);
  potential_targets = zm_ai_hulk::function_f0bafed1(entity, var_d673b0d0, !var_d673b0d0, !var_d673b0d0);
  var_2375c133 = isarray(potential_targets) && potential_targets.size > 0;
  best_node = undefined;
  entity.var_14dfe7c6 = var_d673b0d0;

  if(var_2375c133 && var_d673b0d0) {
    var_f3e6a062 = vectornormalize(anglesToForward(entity.angles));
    var_259c498c = undefined;

    foreach(node in potential_targets) {
      dot = vectordot(vectornormalize(node.origin - entity.origin), var_f3e6a062);

      if(node === entity.var_6265733) {
        dot = -1;
      }

      if(!isDefined(var_259c498c) || dot > var_259c498c) {
        var_259c498c = dot;
        best_node = node;
      }
    }

    var_259c498c = undefined;
    var_c302bfc5 = undefined;

    if(best_node.delay <= 0) {
      foreach(node in best_node.connected_nodes) {
        dot = vectordot(vectornormalize(node.origin - entity.origin), var_f3e6a062);

        if(!isDefined(var_259c498c) || dot > var_259c498c) {
          var_259c498c = dot;
          var_c302bfc5 = node;
        }
      }
    }
  } else if(!var_d673b0d0) {
    if(is_true(entity.var_f0ee16db) && isDefined(entity.var_6a4a7aea)) {
      var_bff30208 = distance2dsquared(entity.origin, entity.var_6a4a7aea.origin);

      if(var_bff30208 < sqr(getdvarfloat(#"hash_9d165ff03f04351", 200))) {
        entity.var_14dfe7c6 = 1;
      } else {
        goal = entity.var_6a4a7aea.origin;
      }
    }

    if(!is_true(entity.var_f0ee16db)) {
      target_nodes = zm_ai_hulk::function_71979c65(entity, entity.favoriteenemy.origin);
      var_dfa0d2db = 0;

      foreach(node in target_nodes) {
        if(isinarray(entity.var_7f73c6e1, node)) {
          var_dfa0d2db = 1;
        }

        if(isinarray(potential_targets, node)) {
          best_node = node;
          var_c302bfc5 = undefined;
          var_dfa0d2db = 1;
          break;
        }
      }
    }

    if(!is_true(var_dfa0d2db) && !is_true(entity.var_f0ee16db) && var_2375c133) {
      var_cb5eaea3 = vectornormalize(entity.favoriteenemy.origin - entity.origin);
      var_259c498c = undefined;

      foreach(node in potential_targets) {
        dot = vectordot(vectornormalize(node.origin - entity.origin), var_cb5eaea3);

        if(!isDefined(var_259c498c) || dot > var_259c498c) {
          var_259c498c = dot;
          best_node = node;
        }
      }

      var_9629476a = 35;

      if(distance2dsquared(best_node.origin, entity.favoriteenemy.origin) > sqr(distance2d(entity.origin, entity.favoriteenemy.origin) + var_9629476a)) {
        best_node = undefined;
      }

      if(isDefined(best_node)) {
        var_259c498c = undefined;
        var_c302bfc5 = undefined;

        foreach(node in best_node.connected_nodes) {
          dot = vectordot(vectornormalize(node.origin - best_node.origin), var_cb5eaea3);

          if(!isDefined(var_259c498c) || dot > var_259c498c) {
            var_259c498c = dot;
            var_c302bfc5 = node;
          }
        }

        if(isDefined(var_c302bfc5) && distance2dsquared(var_c302bfc5.origin, entity.favoriteenemy.origin) > distance2dsquared(entity.origin, entity.favoriteenemy.origin)) {
          var_c302bfc5 = undefined;
        }
      }
    }

    if(!is_true(var_dfa0d2db) && !is_true(entity.var_f0ee16db) && !isDefined(best_node)) {
      function_a7eadb40(entity, entity.favoriteenemy);
      entity.var_1c62b9e9 = undefined;
      var_f7a7b873 = undefined;

      if(isDefined(entity.var_7f73c6e1) && entity.var_7f73c6e1.size > 0) {
        var_160cb6cf = [];
        var_9da026c8 = entity getpathfindingradius() + getdvarint(#"hash_6cdd46b3330d7af7", 100);

        foreach(node in entity.var_7f73c6e1) {
          var_1a4cb070 = max(node.radius - var_9da026c8, 0);
          pos = vectornormalize(entity.favoriteenemy.origin - node.origin) * var_1a4cb070 + node.origin;
          var_160cb6cf[var_160cb6cf.size] = pos;
        }

        var_f7a7b873 = arraygetclosest(entity.favoriteenemy.origin, var_160cb6cf);
      }

      if(isDefined(var_f7a7b873) && distance2dsquared(entity.origin, entity.favoriteenemy.origin) < sqr(distance2d(var_f7a7b873, entity.favoriteenemy.origin) + 50)) {
        var_f7a7b873 = undefined;
      }

      var_47efca42 = function_e7f9bcfd(entity, var_f7a7b873);
      goal = isDefined(var_47efca42) ? var_47efca42 : entity.origin;
    }
  }

  var_b047cc53 = undefined;
  var_c302bfc5 = zm_ai_hulk::function_9ce857d4(entity, var_c302bfc5, best_node);

  if(!zm_ai_hulk::function_4a60f34e(entity, best_node, var_c302bfc5)) {
    zm_ai_hulk::function_4306cd59(entity, best_node, entity.var_7f73c6e1);
  }

  zm_ai_hulk::function_3a92faf9(entity, best_node, var_c302bfc5, var_dfa0d2db, goal);
  var_7b5ed862 = undefined;

  if(is_true(var_dfa0d2db)) {
    var_7b5ed862 = awareness::function_d0939c67(entity, entity.favoriteenemy, entity getpathfindingradius());
  } else if(isDefined(best_node)) {
    var_7b5ed862 = zm_ai_hulk::function_5675af77(entity, best_node);
  }

  if(isDefined(var_c302bfc5)) {
    var_c5eb6510 = min(getdvarfloat(#"hash_72328e4462f91c62", 300), distance(var_c302bfc5.origin, best_node.origin));
    dist = distance(entity.origin, best_node.origin);
    var_e9347624 = max(var_c5eb6510 - dist, 0);
    var_7b5ed862 += vectornormalize(var_c302bfc5.origin - best_node.origin) * var_e9347624;
  }

  if(isDefined(var_7b5ed862)) {
    var_47efca42 = function_e7f9bcfd(entity, var_7b5ed862);

    if(isDefined(var_47efca42)) {
      goal = var_47efca42;
    } else if(isDefined(best_node)) {
      goal = best_node.origin;
    }
  }

  if(!zm_ai_hulk::function_5e80cd88(entity)) {
    goal_info = entity function_4794d6a3();

    if(is_true(goal_info.isatgoal)) {
      if(isDefined(goal) && distance2dsquared(goal, entity.origin) < sqr(getdvarfloat(#"hash_9d165ff03f04351", 200))) {
        goal = undefined;
      }
    } else if(isDefined(goal_info.goalpos) && isDefined(goal) && isDefined(entity.var_fe1e4b1b) && distance2dsquared(entity.origin, goal_info.goalpos) < sqr(getdvarfloat(#"hash_9d165ff03f04351", 200)) && distance2dsquared(entity.var_fe1e4b1b, goal_info.goalpos) < sqr(getdvarfloat(#"hash_9d165ff03f04351", 200))) {
      goal = undefined;
    }
  }

  return goal;
}

function private function_e7f9bcfd(entity, point) {
  if(!(isDefined(entity) && isDefined(point))) {
    return undefined;
  }

  goal = undefined;
  var_9ee64b0c = function_9cc082d2(point, 200);

  if(isDefined(var_9ee64b0c[#"point"])) {
    if(ispointonnavmesh(var_9ee64b0c[#"point"], entity)) {
      goal = var_9ee64b0c[#"point"];
    } else {
      var_47efca42 = getclosestpointonnavmesh(var_9ee64b0c[#"point"], 200, entity getpathfindingradius() * 1.2);

      if(isDefined(var_47efca42) && ispointonnavmesh(var_47efca42, entity)) {
        goal = var_47efca42;
      }
    }
  }

  return goal;
}

function function_98e8c136(entity) {
  self endon(#"death");

  if(!isDefined(entity.var_36f62b58)) {
    entity.var_36f62b58 = [];
  }

  if(!(isDefined(entity.var_8ede206) && isDefined(level.var_36f62b58))) {
    return;
  }

  var_bd037b03 = 0;

  foreach(station in level.var_36f62b58) {
    if(station.var_8ede206 === entity.var_8ede206) {
      if(isinarray(entity.var_36f62b58, station)) {
        return;
      }

      var_bd037b03 = 1;
      station.var_4f67a9d8 = 1;
      entity.var_36f62b58[entity.var_36f62b58.size] = station;
    }
  }

  if(var_bd037b03) {
    return;
  }

  var_3bd3af71 = zm_ai_hulk::function_9fe24e6(entity);

  foreach(node in var_3bd3af71) {
    foreach(station in level.var_36f62b58) {
      if(station.var_4f67a9d8 <= 0) {
        station.var_4f67a9d8++;
        station.var_8ede206 = node.var_ec6eb3b4;
        station.origin = node.origin;
        util::wait_network_frame();
        entity.var_36f62b58[entity.var_36f62b58.size] = station;
        station clientfield::set("hs_heal_station_cf", 1);
        break;
      }
    }
  }
}

function function_5b676fe6(entity) {
  if(!isDefined(entity.var_36f62b58)) {
    return;
  }

  foreach(station in entity.var_36f62b58) {
    if(!isDefined(station.var_4f67a9d8)) {
      station.var_4f67a9d8 = 1;
    }

    station.var_4f67a9d8--;

    if(station.var_4f67a9d8 <= 0) {
      station.var_8ede206 = undefined;
      station clientfield::set("hs_heal_station_cf", 0);
    }
  }

  entity.var_36f62b58 = [];
}

function function_914f5e7(params) {
  function_5b676fe6(self);
}