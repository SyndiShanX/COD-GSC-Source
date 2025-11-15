/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_chain.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\flag_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace bot_chain;

class class_92792865 {
  var activecolor;
  var activestruct;
  var startstruct;
  var var_d1e3e893;

  constructor() {
    activestruct = undefined;
    startstruct = undefined;
    activecolor = undefined;
    var_d1e3e893 = undefined;
  }

}

autoexec __init__system__() {
  system::register(#"bot_chain", &__init__, undefined, undefined);
}

__init__() {
  function_e3eaa42b();
  level thread function_ea764100();
}

private function_b1487cfa(var_72284260) {
  entities = bot::get_bots();

  foreach(entity in entities) {
    if(!isDefined(entity.bot)) {
      continue;
    }

    if(!isDefined(entity.bot.var_53ffa4c4)) {
      continue;
    }

    if(isDefined(entity.bot.var_53ffa4c4.activestruct) && entity.bot.var_53ffa4c4.activestruct == var_72284260) {
      return true;
    }
  }

  return false;
}

private function_8ded619(var_72284260, targetstructs = undefined, duration = 1) {
  drawheight = 8;
  active = function_b1487cfa(var_72284260);

  if(active) {
    sphere(var_72284260.origin, 8, (0, 1, 0), 1, 0, 12, duration);
  } else if(isinarray(level.var_40ed3318, var_72284260)) {
    sphere(var_72284260.origin, 6, (0.75, 0.75, 0.75), 0.7, 0, 10, duration);
  } else {
    sphere(var_72284260.origin, 6, (1, 0.5, 0), 0.7, 0, 10, duration);
  }

  if(!isDefined(targetstructs)) {
    targetstructs = [];

    if(isDefined(var_72284260.target)) {
      structs = struct::get_array(var_72284260.target);

      foreach(struct in structs) {
        if(struct.variantname === "<dev string:x38>") {
          array::add(targetstructs, struct);
        }
      }
    }

    if(isDefined(var_72284260.script_bot_chain_src)) {
      var_354db6a0 = var_72284260 namespace_2e6206f9::get_target_structs("<dev string:x44>");

      if(var_354db6a0.size > 0) {
        targetstructs = arraycombine(targetstructs, var_354db6a0, 0, 0);
      }
    }
  }

  foreach(struct in targetstructs) {
    if(active) {
      line(var_72284260.origin, struct.origin, (0, 1, 0), 1, 0, duration);
      continue;
    }

    line(var_72284260.origin, struct.origin, (1, 0.5, 0), 0.7, 0, duration);
  }

  if(isDefined(var_72284260.targetname)) {
    if(active) {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x57>" + var_72284260.targetname, (0, 1, 0), 1, 0.2, duration);
    } else {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x57>" + var_72284260.targetname, (1, 0.5, 0), 1, 0.2, duration);
    }

    drawheight += 4;
  }

  if(isDefined(var_72284260.script_flag_set)) {
    if(level flag::get(var_72284260.script_flag_set)) {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x60>" + var_72284260.script_flag_set, (0, 1, 0), 1, 0.2, duration);
    } else {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x60>" + var_72284260.script_flag_set, (1, 0.5, 0), 1, 0.2, duration);
    }

    drawheight += 4;
  }

  if(isDefined(var_72284260.script_flag_set)) {
    if(level flag::get(var_72284260.script_flag_set)) {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x69>" + var_72284260.script_flag_set, (0, 1, 0), 1, 0.2, duration);
    } else {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x69>" + var_72284260.script_flag_set, (1, 0.5, 0), 1, 0.2, duration);
    }

    drawheight += 4;
  }

  if(isDefined(var_72284260.script_flag_wait)) {
    if(level flag::get(var_72284260.script_flag_wait)) {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x76>" + var_72284260.script_flag_wait, (0, 1, 0), 1, 0.2, duration);
    } else {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x76>" + var_72284260.script_flag_wait, (1, 0.5, 0), 1, 0.2, duration);
    }

    drawheight += 4;
  }

  if(isDefined(var_72284260.script_flag_clear)) {
    if(level flag::get(var_72284260.script_flag_wait)) {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x84>" + var_72284260.script_flag_clear, (0, 1, 0), 1, 0.2, duration);
    } else {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x84>" + var_72284260.script_flag_clear, (1, 0.5, 0), 1, 0.2, duration);
    }

    drawheight += 4;
  }

  if(isDefined(var_72284260.script_flag_activate)) {
    if(level flag::get(var_72284260.script_flag_activate)) {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x93>" + var_72284260.script_flag_activate, (0, 1, 0), 1, 0.2, duration);
    } else {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x93>" + var_72284260.script_flag_activate, (1, 0.5, 0), 1, 0.2, duration);
    }

    drawheight += 4;
  }

  if(isDefined(var_72284260.script_aigroup)) {
    if(level flag::exists(var_72284260.script_aigroup) && level flag::get(var_72284260.script_aigroup)) {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:xa5>" + var_72284260.script_aigroup, (0, 1, 0), 1, 0.2, duration);
    } else {
      print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:xa5>" + var_72284260.script_aigroup, (1, 0.5, 0), 1, 0.2, duration);
    }

    drawheight += 4;
  }

  if(isDefined(var_72284260.script_ent_flag_set)) {
    print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:xb2>" + var_72284260.script_ent_flag_set, (1, 1, 1), 1, 0.2, duration);
    drawheight += 4;
  }

  if(isDefined(var_72284260.script_ent_flag_clear)) {
    print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:xc3>" + var_72284260.script_ent_flag_clear, (1, 1, 1), 1, 0.2, duration);
    drawheight += 4;
  }

  if(!active) {
    return targetstructs;
  }

  if(!isDefined(var_72284260.target) && !isDefined(var_72284260.script_botchain_goal)) {
    return targetstructs;
  }

  goals = [];

  if(isDefined(var_72284260.target)) {
    nodes = getnodearray(var_72284260.target, "<dev string:xd6>");

    if(isDefined(nodes) && nodes.size > 0) {
      goals = arraycombine(goals, nodes, 0, 0);
    }
  }

  if(isDefined(var_72284260.script_botchain_goal)) {
    nodes = getnodearray(var_72284260.script_botchain_goal, "<dev string:xe3>");

    if(isDefined(nodes) && nodes.size > 0) {
      goals = arraycombine(goals, nodes, 0, 0);
    }
  }

  if(isDefined(var_72284260.target)) {
    volumes = getEntArray(var_72284260.target, "<dev string:xd6>");

    if(isDefined(volumes) && volumes.size > 0) {
      goals = arraycombine(goals, volumes, 0, 0);
    }
  }

  if(isDefined(var_72284260.script_botchain_goal)) {
    volumes = getEntArray(var_72284260.script_botchain_goal, "<dev string:xe3>");

    if(isDefined(volumes) && volumes.size > 0) {
      goals = arraycombine(goals, volumes, 0, 0);
    }
  }

  if(!goals.size) {
    return targetstructs;
  }

  foreach(goal in goals) {
    if(ispathnode(goal)) {
      line(var_72284260.origin, goal.origin, (0, 1, 0), 1, 0, duration);
      nodecolor = (0, 1, 0);

      if(isDefined(goal.radius)) {
        circle(goal.origin, goal.radius, (0, 1, 0), 0, 1, duration);
      } else {
        nodecolor = (1, 0, 0);
      }

      box(goal.origin, (-16, -16, 0), (16, 16, 0), 0, nodecolor, 1, 1, duration);
      continue;
    }

    if(goal.classname === "<dev string:xfa>") {
      maxs = goal getmaxs();
      mins = goal getmins();
      box(goal.origin, mins, maxs, 0, (0, 1, 0), 1, 1, duration);
      line(var_72284260.origin, goal.origin, (0, 1, 0), 1, 0, duration);
      continue;
    }

    if(goal.variantname === "<dev string:x38>") {
      if(isDefined(goal.radius)) {
        searchradius = goal.radius;
      } else {
        print3d(var_72284260.origin + (0, 0, drawheight), "<dev string:x108>", (1, 0, 0), 1, 0.2);
        drawheight += 4;
      }

      circle(goal.origin, searchradius, (0, 1, 0), 0, 1, duration);
      line(var_72284260.origin, goal.origin, (0, 1, 0), 1, 0, duration);
    }
  }

  return targetstructs;
}

private function_ea764100() {
  level.var_40ed3318 = [];
  structs = struct::get_array("<dev string:x38>", "<dev string:x118>");
  targetstructs = [];
  duration = 10;
  viewdistancesq = 3000 * 3000;

  while(true) {
    waitframe(duration);
    var_b1285611 = getdvarint(#"hash_5bc9f81b4f504592", 0);

    if(!var_b1285611) {
      targetstructs = [];
      continue;
    }

    entities = bot::get_bots();
    players = getplayers();
    campos = (0, 0, 0);

    if(players.size > 0) {
      campos = players[0].origin;
    }

    foreach(entity in entities) {
      if(!isDefined(entity.bot)) {
        continue;
      }

      if(!isDefined(entity.bot.var_53ffa4c4)) {
        continue;
      }

      if(isDefined(entity.bot.var_53ffa4c4.activestruct)) {
        line(entity.origin, entity.bot.var_53ffa4c4.activestruct.origin, (0, 1, 1), 1, 0, duration);
      }
    }

    for(index = 0; index < structs.size; index++) {
      if(distance2dsquared(campos, structs[index].origin) <= viewdistancesq) {
        targetstructs[index] = function_8ded619(structs[index], targetstructs[index], duration);
      }
    }
  }

}

private function_e3eaa42b() {
  structs = struct::get_array("bot_chain", "variantname");

  if(!isDefined(structs)) {
    return;
  }

  foreach(struct in structs) {
    if(isDefined(struct.script_flag_set)) {
      if(!isDefined(level.flag[struct.script_flag_set])) {
        level flag::init(struct.script_flag_set);
      }
    }

    if(isDefined(struct.script_flag_wait)) {
      if(!isDefined(level.flag[struct.script_flag_wait])) {
        level flag::init(struct.script_flag_wait);
      }
    }

    if(isDefined(struct.script_flag_activate)) {
      if(!isDefined(level.flag[struct.script_flag_activate])) {
        level flag::init(struct.script_flag_activate);
      }
    }
  }
}

private function_e7b80b1e(var_72284260) {
  self endon(#"hash_382a628dad5ecbb5");
  assert(isDefined(var_72284260));

  if(!isDefined(var_72284260.target) && !isDefined(var_72284260.script_bot_chain_src)) {
    return undefined;
  }

  structs = [];

  if(isDefined(var_72284260.target)) {
    var_436fb4d0 = struct::get_array(var_72284260.target);

    if(isDefined(var_436fb4d0) && var_436fb4d0.size) {
      structs = arraycombine(structs, var_436fb4d0, 0, 0);
    }
  }

  if(isDefined(var_72284260.script_bot_chain_src)) {
    var_436fb4d0 = var_72284260 namespace_2e6206f9::get_target_structs("script_bot_chain");

    if(var_436fb4d0.size > 0) {
      structs = arraycombine(structs, var_436fb4d0, 0, 0);
    }
  }

  var_d8bb5bb6 = [];

  foreach(struct in structs) {
    if(struct.variantname === "bot_chain") {
      array::add(var_d8bb5bb6, struct);
    }
  }

  var_7bc3c842 = [];
  var_653c94ca = [];
  flagarray = [];

  foreach(struct in var_d8bb5bb6) {
    if(!isDefined(struct.script_flag_activate) || level flag::get(struct.script_flag_activate)) {
      array::add(var_7bc3c842, struct);
    }

    if(isDefined(struct.script_flag_activate) && !level flag::get(struct.script_flag_activate)) {
      array::add(var_653c94ca, struct);
      array::add(flagarray, struct.script_flag_activate);
    }
  }

  if(var_7bc3c842.size) {
    return array::random(var_7bc3c842);
  }

  if(var_653c94ca.size) {
    assert(flagarray.size);
    level flag::wait_till_any(flagarray);

    foreach(struct in var_653c94ca) {
      assert(isDefined(struct.script_flag_activate));

      if(level flag::get(struct.script_flag_activate)) {
        return struct;
      }
    }
  }

  if(var_d8bb5bb6.size > 0) {
    return array::random(var_d8bb5bb6);
  }

  return undefined;
}

private function_ea88f102(entity, goal) {
  assert(isDefined(goal));

  if(!isDefined(entity.bot.var_53ffa4c4)) {
    return false;
  }

  if(isDefined(entity.bot.var_53ffa4c4.var_d1e3e893) && entity.bot.var_53ffa4c4.var_d1e3e893 == goal) {
    return true;
  }

  return false;
}

private function_ce1ee70(goal, bot) {
  assert(isDefined(bot));
  assert(isDefined(goal));
  bots = bot bot::get_friendly_bots();
  arrayremovevalue(bots, bot);

  if(!bot.size) {
    return false;
  }

  if(ispathnode(goal)) {
    foreach(entity in bots) {
      if(function_ea88f102(entity, goal)) {
        return true;
      }
    }

    return false;
  } else if(goal.classname === "info_volume") {
    foreach(entity in bots) {
      if(function_ea88f102(entity, goal)) {
        return true;
      }
    }

    return false;
  }

  assert(isvec(goal));

  foreach(entity in bots) {
    if(function_ea88f102(entity, goal)) {
      return true;
    }
  }

  return false;
}

private function_c2d874f1(var_72284260, bot) {
  assert(isDefined(var_72284260));
  assert(isDefined(bot));

  if(!isDefined(var_72284260.target) && !isDefined(var_72284260.script_botchain_goal)) {
    return var_72284260;
  }

  assert(isDefined(var_72284260.target) || isDefined(var_72284260.script_botchain_goal));
  goals = [];

  if(isDefined(var_72284260.target)) {
    var_cfc087ec = getnodearray(var_72284260.target, "targetname");

    if(isDefined(var_cfc087ec) && var_cfc087ec.size) {
      goals = arraycombine(goals, var_cfc087ec, 0, 0);
    }
  }

  if(isDefined(var_72284260.script_botchain_goal)) {
    var_cfc087ec = getnodearray(var_72284260.script_botchain_goal, "script_botchain_goal");

    if(isDefined(var_cfc087ec) && var_cfc087ec.size) {
      goals = arraycombine(goals, var_cfc087ec, 0, 0);
    }
  }

  if(isDefined(var_72284260.target)) {
    var_ddf842e8 = getEntArray(var_72284260.target, "targetname");

    if(isDefined(var_ddf842e8) && var_ddf842e8.size) {
      goals = arraycombine(goals, var_ddf842e8, 0, 0);
    }
  }

  if(isDefined(var_72284260.script_botchain_goal)) {
    var_ddf842e8 = getEntArray(var_72284260.script_botchain_goal, "script_botchain_goal");

    if(isDefined(var_ddf842e8) && var_ddf842e8.size) {
      goals = arraycombine(goals, var_ddf842e8, 0, 0);
    }
  }

  if(!goals.size) {
    return var_72284260;
  }

  var_1bfc6c1d = [];

  if(isDefined(self.bot.var_53ffa4c4.activecolor)) {
    foreach(goal in goals) {
      if(isDefined(goal.script_botchain_color) && goal.script_botchain_color == self.bot.var_53ffa4c4.activecolor) {
        array::add(var_1bfc6c1d, goal);
      }
    }
  }

  if(var_1bfc6c1d.size) {
    return var_1bfc6c1d;
  }

  var_133e0bbb = [];

  foreach(goal in goals) {
    if(function_ce1ee70(goal, bot)) {
      array::add(var_133e0bbb, goal);
    }
  }

  foreach(goal in var_133e0bbb) {
    arrayremovevalue(goals, goal);
  }

  if(goals.size) {
    return goals;
  }

  if(var_133e0bbb.size) {
    goals = arraycombine(goals, var_133e0bbb, 0, 0);
  }

  return goals;
}

private set_goalradius_based_on_settings(goal) {
  assert(isbot(self) || isvehicle(self));
  assert(isDefined(goal));

  if(isDefined(goal.script_forcegoal) && goal.script_forcegoal) {
    return;
  }

  if(spawner::node_has_radius(goal)) {
    self.goalradius = goal.radius;
  }

  if(isDefined(goal.height)) {
    self.goalheight = goal.height;
  }
}

function_95d17a51(startstruct) {
  structs = array();

  if(isstring(startstruct)) {
    startstruct = struct::get(startstruct);
    assert(isDefined(startstruct));
  } else {
    assert(isDefined(startstruct) && isstruct(startstruct));
  }

  seentargets = array();
  targets = array();

  if(isDefined(startstruct.target)) {
    targets[targets.size] = startstruct.target;
    seentargets[startstruct.target] = 1;
  }

  structs[structs.size] = startstruct;

  while(targets.size > 0) {
    target = targets[0];
    arrayremoveindex(targets, 0);
    targetstructs = struct::get_array(target);

    foreach(struct in targetstructs) {
      structs[structs.size] = struct;

      if(isDefined(struct.target) && !isDefined(seentargets[struct.target])) {
        targets[targets.size] = struct.target;
        seentargets[struct.target] = 1;
      }
    }
  }

  targets = array();

  if(isDefined(startstruct.script_bot_chain_src)) {
    targets[targets.size] = startstruct.script_bot_chain_src;
    seentargets[startstruct.script_bot_chain_src] = 1;
  }

  while(targets.size > 0) {
    target = targets[0];
    arrayremoveindex(targets, 0);
    targetstructs = struct::get_array(target, "script_bot_chain_target");

    foreach(struct in targetstructs) {
      structs[structs.size] = struct;

      if(isDefined(struct.script_bot_chain_src) && !isDefined(seentargets[struct.script_bot_chain_src])) {
        targets[targets.size] = struct.script_bot_chain_src;
        seentargets[struct.script_bot_chain_src] = 1;
      }
    }
  }

  return structs;
}

function_cf70f2fe(startstruct, resuming = 0) {
  assert(isbot(self));
  assert(isDefined(self.bot));

  if(isstring(startstruct)) {
    startstruct = struct::get(startstruct);
    assert(isDefined(startstruct));
  } else {
    assert(isDefined(startstruct) && isstruct(startstruct));
  }

  assert(startstruct.variantname == "<dev string:x38>");
  goalent = self isinvehicle() ? self getvehicleoccupied() : self;
  goalent endon(#"death");
  self endon(#"death");
  self notify(#"hash_382a628dad5ecbb5");
  self endon(#"hash_382a628dad5ecbb5");
  debugstart = startstruct;

  if(resuming && isDefined(self.bot.var_53ffa4c4)) {
    debugstart = self.bot.var_53ffa4c4.startstruct;
  }

  self.bot.var_53ffa4c4 = new class_92792865();
  self.bot.var_53ffa4c4.activestruct = startstruct;
  self.bot.var_53ffa4c4.startstruct = debugstart;

  for(;;) {
    activestruct = self.bot.var_53ffa4c4.activestruct;
    goals = function_c2d874f1(activestruct, self);

    if(!isDefined(goals)) {
      break;
    }

    if(isarray(goals)) {
      goal = array::random(goals);
    } else if(goals == activestruct) {
      goal = goals;
    }

    if(ispathnode(goal) || isstruct(goal)) {
      goalent set_goalradius_based_on_settings(goal);
    }

    if(ispathnode(goal)) {
      goalent setgoal(goal, isDefined(goal.script_forcegoal) && goal.script_forcegoal);
    } else if(isstruct(goal)) {
      goalent setgoal(goal.origin, isDefined(goal.script_forcegoal) && goal.script_forcegoal);
    } else {
      goalent setgoal(goal);
    }

    self.bot.var_53ffa4c4.var_d1e3e893 = goal;
    goalent waittill(#"goal");

    if(isDefined(activestruct.script_notify)) {
      self notify(activestruct.script_notify);
    }

    if(isDefined(goal.script_botchain_color)) {
      self.bot.var_53ffa4c4.activecolor = goal.script_botchain_color;
    }

    if(isDefined(activestruct.script_flag_set)) {
      level flag::set(activestruct.script_flag_set);
    }

    if(isDefined(activestruct.script_flag_clear)) {
      level flag::set(activestruct.script_flag_clear);
    }

    if(isDefined(activestruct.script_ent_flag_set)) {
      if(!self flag::exists(activestruct.script_ent_flag_set)) {
        assertmsg("<dev string:x126>" + activestruct.script_ent_flag_set + "<dev string:x142>");
      }

      self flag::set(activestruct.script_ent_flag_set);
    }

    if(isDefined(activestruct.script_ent_flag_clear)) {
      if(!self flag::exists(activestruct.script_ent_flag_clear)) {
        assertmsg("<dev string:x15a>" + activestruct.script_ent_flag_clear + "<dev string:x142>");
      }

      self flag::clear(activestruct.script_ent_flag_clear);
    }

    if(isDefined(activestruct.script_flag_wait)) {
      level flag::wait_till(activestruct.script_flag_wait);
    }

    if(isDefined(activestruct.script_aigroup)) {
      if(isDefined(level._ai_group[activestruct.script_aigroup])) {
        spawner::waittill_ai_group_cleared(activestruct.script_aigroup);
      }
    }

    activestruct util::script_delay();
    var_18c2bdb3 = function_e7b80b1e(activestruct);

    array::add(level.var_40ed3318, activestruct, 0);

    if(!isDefined(var_18c2bdb3)) {
      break;
    }

    self.bot.var_53ffa4c4.activestruct = var_18c2bdb3;
  }

  self function_73d1cfe6();
}

function_34a84039() {
  assert(isbot(self));

  if(isDefined(self.bot.var_53ffa4c4) && isDefined(self.bot.var_53ffa4c4.activestruct)) {
    self thread function_cf70f2fe(self.bot.var_53ffa4c4.activestruct, 1);
  }
}

function_73d1cfe6() {
  assert(isbot(self));

  if(isDefined(self.bot.var_53ffa4c4)) {
    self.bot.var_53ffa4c4 = undefined;
  }

  self notify(#"hash_382a628dad5ecbb5");
}

function_58b429fb() {
  assert(isbot(self));

  if(isDefined(self.bot.var_53ffa4c4)) {
    return true;
  }

  return false;
}