/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_orders.gsc
***********************************************/

#using scripts\core_common\bots\bot;
#namespace bot_orders;

function preinit() {
  level.var_774ed7e9 = [];

  foreach(team in level.teams) {
    level.var_774ed7e9[team] = [];
  }

  level.var_d3b9615b = function_b6e6a59b();
  level.var_4b98dc10 = [];
  level register_state(#"assault", &function_2fe359ab, &assault_start, &function_6a672c6d);
  level register_state(#"capture", &function_bcd00fa7, &capture_start, &function_423ecbc1);
  level register_state(#"defend", &function_1ba5e803, &defend_start, &function_72084729);
  level register_state(#"chase_enemy", &function_7c479af0, &function_6790cfd3, &function_63b3aa81);
  level register_state(#"hash_2fc0534d4a96a7ea", &function_199c516, &function_36d63786, &function_91d9d948);
  level register_state(#"camp", &function_c5686e54, &function_c35b807e, &function_17d77980);
  level register_state(#"patrol", &function_82c1a3e9, &patrol_start, &patrol_think);

  level thread function_7a7ab1a2();
}

function shutdown() {
  self clear();
}

function think() {
  pixbeginevent(#"");
  info = self function_4794d6a3();

  if(info.goalforced || self.ignoreall) {
    self clear();
    pixendevent();
    return;
  }

  bot = self.bot;

  if(isDefined(bot.objective) && !bot.objective.active) {
    self clear();
  }

  if(!isDefined(bot.objective)) {
    objective = self function_79241feb();

    if(isDefined(objective)) {
      self function_b35e00d9(objective);
    }
  }

  if(isDefined(bot.order)) {
    state = level.var_4b98dc10[bot.order];

    if(bot.order != bot.objective.var_a1980fcb && self function_4b2723cf(bot.objective.var_a1980fcb, bot.objective)) {
      state = level.var_4b98dc10[bot.order];
    }

    self[[state.think]](bot.objective);
  }

  if(self bot::should_record(#"hash_bb5c278818b000b")) {
    self function_26b3a2f();
    self function_d966fb1c();
  }

  pixendevent();
}

function private function_79241feb() {
  var_271aef88 = level.var_774ed7e9[self.team];

  if(var_271aef88.size <= 0) {
    return 0;
  }

  totalweight = 0;
  weights = [];

  foreach(objective in var_271aef88) {
    weight = 1;

    if(isDefined(objective.weight)) {
      weight = self[[objective.weight]](objective);
    }

    totalweight += weight;
    weights[weights.size] = totalweight;
  }

  var_e8351662 = randomfloat(totalweight);
  objective = undefined;

  foreach(i, weight in weights) {
    if(var_e8351662 < weight) {
      return var_271aef88[i];
    }
  }

  return undefined;
}

function private function_b35e00d9(objective) {
  if(!self function_4b2723cf(objective.var_a1980fcb, objective) && !self function_4b2723cf(objective.var_5e99151a, objective)) {
    return false;
  }

  self.bot.objective = objective;
  objective.count++;
  return true;
}

function private function_4b2723cf(order, objective) {
  if(!isDefined(order)) {
    return false;
  }

  state = level.var_4b98dc10[order];

  if(!isDefined(state)) {
    return false;
  }

  if(!self[[state.ready]](objective) || !self[[state.start]](objective)) {
    return false;
  }

  self.bot.order = order;
  return true;
}

function private register_state(order, var_47dfc5f2, var_20ef4046, var_7b441679) {
  state = {
    #order: order, #ready: var_47dfc5f2, #start: var_20ef4046, #think: var_7b441679
  };
  level.var_4b98dc10[order] = state;
}

function private clear() {
  if(isDefined(self.bot.objective)) {
    self.bot.objective.count--;
  }

  self.bot.objective = undefined;
  self.bot.order = undefined;
  self.bot.defendtime = undefined;
  self.bot.var_f0015c1 = undefined;
  self.bot.var_6b695775 = undefined;
  self.bot.var_3d1abfb9 = undefined;
  self.bot.var_941ba251 = undefined;
  self function_9392d2c9();
}

function private function_82c1a3e9(objective) {
  players = function_f6f34851(self.team);
  return players.size > 0;
}

function private patrol_start(objective) {
  id = self function_e559e4d5();

  if(!isDefined(id)) {
    return false;
  }

  route = self function_89751246(id);

  if(route.size <= 0) {
    return false;
  }

  self function_fd78dbc(route);
  return true;
}

function private patrol_think(objective) {
  self function_db3a19e8();

  if(!self function_28557cd1()) {
    self clear();
  }
}

function private function_e559e4d5() {
  players = function_f6f34851(self.team);

  if(players.size <= 0) {
    return undefined;
  }

  player = players[randomint(players.size)];
  tpoint = getclosesttacpoint(player.origin);

  if(!isDefined(tpoint)) {
    return undefined;
  }

  ids = [];
  info = function_b507a336(tpoint.region);

  if(info.tacpoints.size >= 10) {
    ids[ids.size] = info.id;
  }

  foreach(id in info.neighbors) {
    info = function_b507a336(id);

    if(info.tacpoints.size < 10) {
      continue;
    }

    ids[ids.size] = id;
  }

  if(ids.size <= 0) {
    return undefined;
  }

  return ids[randomint(ids.size)];
}

function private function_7c479af0(objective) {
  return self.bot.enemyseen;
}

function private function_6790cfd3(objective) {
  bot = self.bot;

  if(!isDefined(bot.var_494658cd)) {
    return false;
  }

  route = self function_89751246(bot.var_494658cd.region);

  if(route.size <= 0) {
    return false;
  }

  self function_fd78dbc(route);
  return true;
}

function private function_63b3aa81(objective) {
  self function_db3a19e8();

  if(!self.bot.enemyseen && !self function_28557cd1()) {
    info = self function_4794d6a3();

    if(is_true(info.var_9e404264)) {
      self clear();
      return;
    }
  }

  bot = self.bot;

  if(self.bot.enemyvisible && isDefined(bot.var_494658cd) && isDefined(bot.tpoint) && bot.var_494658cd.region != bot.tpoint.region) {
    if(!self function_28557cd1() || bot.var_494658cd.region != self function_f25530e3()) {
      route = self function_89751246(bot.var_494658cd.region);

      if(route.size > 0) {
        self function_fd78dbc(route);
      }
    }
  }
}

function private function_199c516(objective) {
  return self.bot.enemyseen;
}

function private function_36d63786(objective) {
  info = self function_4794d6a3();

  if(isDefined(info.regionid)) {
    return true;
  }

  if(!isDefined(self.bot.tpoint)) {
    return false;
  }

  self setgoal(self.bot.tpoint.region);
  return true;
}

function private function_91d9d948(objective) {
  goalinfo = self function_4794d6a3();

  if(!self.bot.enemyseen || !isDefined(goalinfo.regionid)) {
    self clear();
    return;
  }

  var_494658cd = self.bot.var_494658cd;

  if(!isDefined(var_494658cd)) {
    return;
  }

  if(var_494658cd.region != goalinfo.regionid) {
    return;
  }

  enemyfwd = vectornormalize(self.enemy.origin - self.origin);
  var_6dc3b94d = [];
  regioninfo = function_b507a336(goalinfo.regionid);

  foreach(neighborid in regioninfo.neighbors) {
    var_a110f1ae = function_b507a336(neighborid);

    if(vectordot(enemyfwd, var_a110f1ae.origin) <= 0.866) {
      var_6dc3b94d[var_6dc3b94d.size] = neighborid;
    }
  }

  if(var_6dc3b94d.size <= 0) {
    self clear();
    return;
  }

  var_41cf0e63 = var_6dc3b94d[randomint(var_6dc3b94d.size)];
  self setgoal(var_41cf0e63);
}

function private function_bcd00fa7(objective) {
  return self function_8b26cb41(objective);
}

function private capture_start(objective) {
  self function_9392d2c9();
  trigger = objective.info.target.trigger;
  self setgoal(trigger);
  return true;
}

function private function_423ecbc1(objective) {
  self update_threat(objective);
}

function private function_1ba5e803(objective) {
  return self function_8b26cb41(objective);
}

function defend_start(objective) {
  self function_9392d2c9();
  return true;
}

function private function_72084729(objective) {
  if(!isDefined(self.bot.defendtime)) {
    self.bot.defendtime = gettime() + int(randomintrange(20, 60) * 1000);
  } else if(!isDefined(self.bot.defendtime) || self.bot.defendtime <= gettime()) {
    if(self.bot.enemyseen || !is_true(objective.secure)) {
      self.bot.defendtime = gettime() + int(randomintrange(20, 60) * 1000);
    } else {
      self clear();
      return;
    }
  }

  info = self function_4794d6a3();
  trigger = objective.info.target.trigger;

  if(isDefined(trigger) && !is_true(objective.secure)) {
    if(!isDefined(info.goalvolume) || info.goalvolume != trigger) {
      self setgoal(trigger);
      self.bot.var_6b695775 = undefined;
    }
  } else if(!isDefined(self.bot.var_6b695775) && isDefined(info.regionid) && isDefined(self.bot.tpoint) && info.regionid == self.bot.tpoint.region) {
    self.bot.var_6b695775 = gettime() + int(randomfloatrange(5, 10) * 1000);
  } else if((!isDefined(self.bot.var_6b695775) || self.bot.var_6b695775 <= gettime()) && is_true(info.var_9e404264) && !self.bot.enemyseen) {
    id = objective.info.var_dd2331cb[randomint(objective.info.var_dd2331cb.size)];

    if(isDefined(id)) {
      self setgoal(id);
      self.bot.var_6b695775 = undefined;
    }
  } else if(!isinarray(objective.info.var_dd2331cb, info.regionid)) {
    id = objective.info.var_dd2331cb[randomint(objective.info.var_dd2331cb.size)];

    if(isDefined(id)) {
      self setgoal(id);
      self.bot.var_6b695775 = undefined;
    }
  }

  self update_threat(objective);
}

function private function_2fe359ab(objective) {
  return objective.info.var_dd2331cb.size > 0;
}

function private assault_start(objective) {
  return self function_c3253ef(objective);
}

function private function_6a672c6d(objective) {
  self function_db3a19e8();

  if(!self function_99dcd0bd(objective)) {
    self function_c3253ef(objective);
  }
}

function private function_c5686e54(objective) {
  return !self.bot.enemyvisible;
}

function private function_c35b807e(objective) {
  regioncount = function_548ca110();

  if(regioncount <= 0) {
    return false;
  }

  var_de0b3c66 = randomintrange(1, regioncount);
  var_f1120f81 = function_b507a336(var_de0b3c66);

  if(var_f1120f81.tacpoints.size < 15 || var_f1120f81.neighbors.size < 2) {
    return false;
  }

  route = self function_89751246(var_de0b3c66);

  if(route.size <= 0) {
    return false;
  }

  self function_fd78dbc(route);
  return true;
}

function private function_17d77980(objective) {
  self function_db3a19e8();

  if(self function_28557cd1()) {
    return;
  }

  self update_threat(objective);

  if(!isDefined(self.bot.var_f0015c1)) {
    self.bot.var_f0015c1 = gettime() + int(randomintrange(20, 60) * 1000);
    return;
  }

  if(!isDefined(self.bot.var_f0015c1) || self.bot.var_f0015c1 <= gettime()) {
    self clear();
  }
}

function private function_8b26cb41(objective) {
  tpoint = self.bot.tpoint;

  if(!isDefined(tpoint)) {
    return false;
  }

  foreach(id in objective.info.var_dd2331cb) {
    if(tpoint.region == id) {
      return true;
    }
  }

  return false;
}

function private function_c3253ef(objective) {
  if(!isDefined(objective.info.var_dd2331cb) || objective.info.var_dd2331cb.size <= 0) {
    return false;
  }

  id = objective.info.var_dd2331cb[randomint(objective.info.var_dd2331cb.size)];
  route = self function_89751246(id);

  if(route.size <= 0) {
    return false;
  }

  self function_fd78dbc(route);
  return true;
}

function private function_99dcd0bd(objective) {
  if(!self function_28557cd1()) {
    return 0;
  }

  endindex = self.bot.route.size - 1;
  var_69c6b167 = self.bot.route[endindex];
  return isinarray(objective.info.var_dd2331cb, var_69c6b167);
}

function private function_89751246(regionid) {
  pixbeginevent(#"");
  var_66e7b0ba = self.bot.tpoint;

  if(!isDefined(var_66e7b0ba) || var_66e7b0ba.region == regionid) {
    pixendevent();
    return array(regionid);
  }

  var_d3547bb1 = function_b507a336(regionid);
  var_cdea01dc = randomfloatrange(-1, 1);
  self function_ca06456b(self.origin, var_d3547bb1.origin, level.var_d3b9615b, var_cdea01dc);
  pixendevent();
  return function_afd64b51(var_66e7b0ba.region, regionid);
}

function private function_ca06456b(start, end, bounds, var_cdea01dc) {
  pixbeginevent(#"");
  directdir = end - start;
  var_8c171e74 = length(directdir);
  var_43bc5205 = vectortoangles(directdir);
  var_d62fe1dc = anglesToForward(var_43bc5205);
  var_cb764353 = anglestoright(var_43bc5205);

  if(var_cdea01dc < 0) {
    var_cb764353 = (0, 0, 0) - var_cb764353;
    var_cdea01dc = abs(var_cdea01dc);
  }

  var_c7a2a5bd = var_cb764353 * var_8c171e74 * 0.75;
  clipstart = function_24531a26(start, start + var_c7a2a5bd, bounds.absmins, bounds.absmaxs);
  var_6d229307 = vectorlerp(start, clipstart.end, var_cdea01dc);
  var_c7a484a2 = distance(start, var_6d229307);
  clipend = function_24531a26(end, end + var_c7a2a5bd, bounds.absmins, bounds.absmaxs);
  var_57a5b0 = vectorlerp(end, clipend.end, var_cdea01dc);
  var_315d734c = distance(end, var_57a5b0);
  var_acfd9e68 = var_c7a484a2 > 500;
  var_16eedbee = var_315d734c > 500;
  var_22405e9b = var_57a5b0 - var_6d229307;
  var_ccb07583 = length(var_22405e9b);
  var_f8c9ffb2 = vectortoangles(var_22405e9b);
  var_beaef07d = anglesToForward(var_f8c9ffb2);
  var_75128d22 = anglestoright(var_f8c9ffb2);

  shouldrecord = self bot::should_record(#"hash_bb5c278818b000b");

  if(shouldrecord) {
    recordline(start, var_6d229307, (1, 0, 1), "<dev string:x38>", self);
    recordline(var_6d229307, var_57a5b0, (1, 0, 1), "<dev string:x38>", self);
    recordline(var_57a5b0, end, (1, 0, 1), "<dev string:x38>", self);
  }

  points = array(start, var_6d229307, var_57a5b0, end);
  function_c36796ff(10, 0.2, 500, points, 10, 20);
  pixendevent();
}

function private function_fd78dbc(route) {
  self.bot.route = route;
  self.bot.routeindex = 0;
}

function private function_9392d2c9() {
  self.bot.route = undefined;
  self.bot.routeindex = undefined;
}

function private function_28557cd1() {
  return isDefined(self.bot.route);
}

function private function_f25530e3() {
  route = self.bot.route;

  if(!isDefined(route)) {
    return undefined;
  }

  return route[route.size - 1];
}

function private function_db3a19e8() {
  pixbeginevent(#"");

  if(self isplayinganimscripted() || self arecontrolsfrozen() || self function_5972c3cf() || self isinvehicle()) {
    pixendevent();
    return;
  }

  bot = self.bot;

  if(!isarray(bot.route) || bot.route.size <= 0) {
    pixendevent();
    return;
  }

  id = bot.route[bot.routeindex];

  if(bot.route.size == 1) {
    self setgoal(id);
    self forceupdategoalpos();
    self function_9392d2c9();
  } else if(isDefined(bot.tpoint) && bot.tpoint.region == id) {
    bot.routeindex++;

    if(bot.routeindex < bot.route.size) {
      self setgoal(bot.route[bot.routeindex]);
      self forceupdategoalpos();
    } else {
      self function_9392d2c9();
    }
  } else {
    info = self function_4794d6a3();

    if(!isDefined(info.regionid) || info.regionid != id) {
      self setgoal(id);
      self forceupdategoalpos();
    }
  }

  pixendevent();
}

function private function_b6e6a59b() {
  bounds = function_5ac49687();

  if(isDefined(bounds)) {
    bounds.var_f521d351 = (bounds.maxs[0], bounds.maxs[1], bounds.mins[2]);
  }

  return bounds;
}

function private update_threat(objective) {
  if(self.bot.enemyseen) {
    self.bot.var_3d1abfb9 = undefined;
    return;
  }

  if(!(!isDefined(self.bot.var_3d1abfb9) || self.bot.var_3d1abfb9 <= gettime()) && self.bot.var_9931c7dc) {
    return;
  }

  pixbeginevent("update_threat");
  trigger = objective.info.target.trigger;

  if(isDefined(trigger) && !is_true(objective.secure)) {
    point = self function_f217ace2(trigger);

    if(isDefined(point)) {
      self.bot.var_941ba251 = point;
      self.bot.var_3d1abfb9 = gettime() + int(randomfloatrange(1.5, 3) * 1000);
    }
  } else {
    neighborids = objective.info.neighborids;

    if(!isDefined(neighborids) && isDefined(self.bot.tpoint)) {
      info = function_b507a336(self.bot.tpoint.region);
      neighborids = info.neighbors;
    }

    point = self function_146c03bd(neighborids);

    if(isDefined(point)) {
      self.bot.var_941ba251 = point;
      self.bot.var_3d1abfb9 = gettime() + int(randomfloatrange(2, 5) * 1000);
    }
  }

  pixendevent();
}

function private function_146c03bd(var_dd2331cb) {
  if(!isDefined(var_dd2331cb) || var_dd2331cb.size <= 0) {
    return undefined;
  }

  id = var_dd2331cb[randomint(var_dd2331cb.size)];
  points = tacticalquery(#"hash_74b4463994f96eae", id, self);

  if(points.size <= 0) {
    return undefined;
  }

  return points[randomint(points.size)].origin + (0, 0, 50);
}

function private function_f217ace2(volume) {
  points = tacticalquery(#"hash_eea3b34d24d4bdd", volume, self);

  if(points.size <= 0) {
    return undefined;
  }

  return points[randomint(points.size)].origin + (0, 0, 50);
}

function private function_7a7ab1a2() {
  level endon(#"game_ended");

  while(true) {
    waitframe(1);

    if(getdvarint(#"hash_bb5c278818b000b", 0) <= 0) {
      continue;
    }

    recordbox(level.var_d3b9615b.origin, level.var_d3b9615b.mins, level.var_d3b9615b.var_f521d351, 0, (1, 0, 0), "<dev string:x38>");
    zoffset = 0;
    var_dd2331cb = [];
    neighborids = [];

    foreach(team, var_271aef88 in level.var_774ed7e9) {
      foreach(objective in var_271aef88) {
        if(!isDefined(objective.info) || !isDefined(objective.info.target)) {
          continue;
        }

        record3dtext(level.teams[team] + "<dev string:x42>" + objective.count + "<dev string:x48>" + function_9e72a96(objective.var_a1980fcb) + "<dev string:x4f>" + function_9e72a96(objective.var_5e99151a), objective.info.target.origin + (0, 0, zoffset), (0, 1, 1), "<dev string:x38>");

        if(isDefined(objective.info.var_dd2331cb)) {
          foreach(id in objective.info.var_dd2331cb) {
            var_dd2331cb[id] = id;
          }
        }

        if(isDefined(objective.info.neighborids)) {
          foreach(id in objective.info.neighborids) {
            neighborids[id] = id;
          }
        }
      }

      zoffset += -10;
    }

    foreach(id in var_dd2331cb) {
      info = function_b507a336(id);

      foreach(point in info.tacpoints) {
        recordstar(point.origin, (0, 1, 1), "<dev string:x38>");
      }

      record3dtext(id, info.origin, (0, 1, 1), "<dev string:x38>");
    }

    foreach(id in neighborids) {
      info = function_b507a336(id);

      foreach(point in info.tacpoints) {
        recordstar(point.origin, (0, 0, 1), "<dev string:x38>");
      }

      record3dtext(id, info.origin, (0, 0, 1), "<dev string:x38>");
    }
  }
}

function private function_26b3a2f() {
  order = self.bot.order;

  if(!isDefined(order)) {
    record3dtext(function_9e72a96(#"hash_266967e49741306c"), self.origin, (0, 1, 1), "<dev string:x38>", self, 0.5);
  } else {
    record3dtext(function_9e72a96(#"hash_15017f84fb1a2e46") + function_9e72a96(order), self.origin, (0, 1, 1), "<dev string:x38>", self, 0.5);
  }

  objective = self.bot.objective;

  if(isDefined(objective) && isDefined(objective.info) && isDefined(objective.info.target)) {
    recordline(self.origin, objective.info.target.origin, (0, 1, 1), "<dev string:x38>", self);
  }
}

function private function_d966fb1c() {
  route = self.bot.route;

  if(!isDefined(route)) {
    return;
  }

  routeindex = self.bot.routeindex;
  lastorigin = undefined;

  foreach(i, id in route) {
    info = function_b507a336(id);
    color = (0, 1, 0);

    if(i > routeindex) {
      color = (0, 1, 1);
    } else if(i < routeindex) {
      color = (0, 0, 1);
    }

    text = id + "<dev string:x55>" + i + "<dev string:x5c>" + info.tacpoints.size;
    record3dtext(text, info.origin, color, "<dev string:x38>", self);

    if(isDefined(lastorigin)) {
      recordline(lastorigin, info.origin, color, "<dev string:x38>", self);
    }

    lastorigin = info.origin;
  }
}