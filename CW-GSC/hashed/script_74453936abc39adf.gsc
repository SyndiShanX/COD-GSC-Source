/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_74453936abc39adf.gsc
***********************************************/

#using script_1435f3c9fc699e04;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\util_shared;
#namespace namespace_38ee089b;

function preinit() {
  if(util::is_frontend_map()) {
    return;
  }

  if(!sessionmodeisprivate()) {
    if(isshipbuild() || !getdvarint(#"hash_199dcc375667485", 0)) {
      return;
    }
  }

  onstartgametype = function_72b9b674();

  if(isDefined(onstartgametype)) {
    callback::on_start_gametype(onstartgametype);
  }
}

function private function_72b9b674() {
  if(!isDefined(level.gametype)) {
    return undefined;
  }

  switch (level.gametype) {
    case # "conf":
    case # "conf_hc":
      return &function_13821498;
    case # "control":
    case # "control_hc":
    case # "control_cdlpro":
    case # "hash_594c4ab1d31aa150":
      return &control_start;
    case # "dm":
    case # "dm_hc":
    case # "dm_bots":
      return &function_13821498;
    case # "dom_hc":
    case # "dom":
    case # "dom_bots":
      return &dom_start;
    case # "dropkick":
      return &function_35d61d4;
    case # "gun":
      return &function_13821498;
    case # "gunfight_3v3":
    case # "gunfight":
      return &function_8d249e99;
    case # "koth":
    case # "hash_156594d96f8a6568":
    case # "hash_35a6541d081acef5":
    case # "koth_hc":
      return &koth_start;
    case # "tdm_bots":
    case # "tdm_hc":
    case # "tdm":
      return &function_13821498;
  }

  return undefined;
}

function private control_start() {
  level endon(#"game_ended");

  foreach(team in level.teams) {
    level function_8f96464(team, undefined, #"chase_enemy", #"patrol");
  }

  while(!isDefined(level.zones) || level.zones.size <= 0) {
    waitframe(1);
  }

  controlinfo = [];

  foreach(zone in level.zones) {
    info = level function_5f64ef84(zone.gameobject);
    controlinfo[controlinfo.size] = info;

    foreach(team in level.teams) {
      order = # "defend";
      weight = &function_e8d188ad;

      if(team == game.attackers) {
        order = # "capture";
        weight = &function_1fb784fb;
      }

      level function_8f96464(team, info, order, #"assault", weight);
    }
  }

  while(!isDefined(level.capturedzones)) {
    waitframe(1);
  }

  while(true) {
    var_23c361c9 = [];

    foreach(info in controlinfo) {
      object = info.target;

      if(!object.trigger istriggerenabled()) {
        var_23c361c9[var_23c361c9.size] = info;
        continue;
      }

      objectives = level function_574923ee(info);

      foreach(objective in objectives) {
        objective.secure = function_84750938(object, objective.team);
      }
    }

    foreach(info in var_23c361c9) {
      level function_add82897(info);
      arrayremovevalue(controlinfo, info);
    }

    waitframe(1);
  }
}

function private function_e8d188ad(objective) {
  return 5;
}

function private function_1fb784fb(objective) {
  return 5;
}

function private dom_start() {
  level endon(#"game_ended");

  foreach(team in level.teams) {
    level function_8f96464(team, undefined, #"chase_enemy", #"patrol", undefined);
  }

  var_654bc2bc = [# "capture": &function_19d221fa, #"defend": &function_d5bf23f5];

  while(!isDefined(level.domflags) || level.domflags.size <= 0) {
    waitframe(1);
  }

  var_647c4a69 = [];

  foreach(object in level.domflags) {
    info = level function_5f64ef84(object);
    var_647c4a69[var_647c4a69.size] = info;
    var_ba83b5af = # "capture";

    foreach(team in level.teams) {
      level function_8f96464(team, info, var_ba83b5af, #"assault", var_654bc2bc[var_ba83b5af]);
    }
  }

  waitframe(1);

  while(true) {
    foreach(info in var_647c4a69) {
      object = info.target;
      ownerteam = object gameobjects::get_owner_team();
      objectives = level function_574923ee(info);

      foreach(objective in objectives) {
        team = objective.team;
        order = team == ownerteam ? # "defend" : # "capture";

        if(objective.var_a1980fcb != order) {
          level remove_objective(objective);
          weight = var_654bc2bc[order];
          level function_8f96464(team, info, order, #"assault", weight);
        }

        objective.secure = function_84750938(object, team);
      }
    }

    waitframe(1);
  }
}

function private function_19d221fa(objective) {
  teamcount = getplayers(self.team).size;
  objectivecount = level function_994c497(objective);

  if(objectivecount > 0) {
    return (teamcount / objectivecount);
  }

  return teamcount;
}

function private function_d5bf23f5(objective) {
  teamcount = getplayers(self.team).size;
  objectivecount = level function_994c497(objective);

  if(objectivecount > 0) {
    return (teamcount / objectivecount);
  }

  return teamcount;
}

function private function_35d61d4() {
  level endon(#"game_ended");

  while(!isDefined(level.var_bb695b91)) {
    waitframe(1);
  }

  var_b84a8f51 = function_5f64ef84(level.var_bb695b91);
  var_9c4aa862 = {
    #var_dd2331cb: var_b84a8f51.var_dd2331cb, #neighborids: var_b84a8f51.neighborids
  };

  while(true) {
    foreach(team in level.teams) {
      level function_8f96464(team, var_b84a8f51, #"capture", #"assault");
    }

    while(!isDefined(var_b84a8f51.target.carrier)) {
      waitframe(1);
    }

    level function_add82897(var_b84a8f51);
    carrier = var_b84a8f51.target.carrier;
    var_9c4aa862.target = carrier;
    var_8cc3a02f = carrier.team;
    level function_8f96464(var_8cc3a02f, var_9c4aa862, #"hash_2fc0534d4a96a7ea", #"camp", &function_69fcc325);
    level function_8f96464(var_8cc3a02f, var_9c4aa862, #"defend", #"assault", &function_dda40c33);

    foreach(team in level.teams) {
      if(team == var_8cc3a02f) {
        level function_8f96464(team, var_9c4aa862, #"chase_enemy", #"patrol", &function_a4ce3b72);
        continue;
      }

      level function_8f96464(team, var_9c4aa862, #"chase_enemy", #"patrol", undefined);
    }

    waitframe(1);

    while(isDefined(var_b84a8f51.target.carrier)) {
      level function_e58e3486(var_9c4aa862);
      waitframe(1);
    }

    level function_add82897(var_9c4aa862);
  }
}

function private function_69fcc325(objective) {
  carrier = objective.info.target;

  if(isDefined(carrier) && carrier == self) {
    return true;
  }

  return false;
}

function private function_dda40c33(objective) {
  carrier = objective.info.target;

  if(isDefined(carrier) && carrier == self) {
    return 0;
  }

  if(objective.count < 3) {
    return 3;
  }

  return 1;
}

function private function_a4ce3b72(objective) {
  carrier = objective.info.target;

  if(isDefined(carrier) && carrier == self) {
    return false;
  }

  return true;
}

function private function_8d249e99() {
  level endon(#"game_ended");
  var_f0ed42da = {};

  foreach(team in level.teams) {
    level function_8f96464(team, var_f0ed42da, #"chase_enemy", #"patrol", &function_8b5d7508);
  }

  var_a5e6be6d = {};

  foreach(team in level.teams) {
    level function_8f96464(team, var_a5e6be6d, #"hash_2fc0534d4a96a7ea", #"camp", &function_b4c402b);
  }

  zoneinfo = undefined;

  while(!isDefined(level.zones) || level.zones.size <= 0 || !isDefined(level.zones[0].gameobject)) {
    waitframe(1);
  }

  zoneinfo = function_5f64ef84(level.zones[0].gameobject);

  while(zoneinfo.target.interactteam != # "group_all") {
    waitframe(1);
  }

  foreach(team in level.teams) {
    level function_8f96464(team, zoneinfo, #"capture", #"assault", undefined);
  }

  level function_add82897(var_f0ed42da);

  foreach(team in level.teams) {
    level function_8f96464(team, var_f0ed42da, #"chase_enemy", #"patrol", &function_a6535861);
  }

  level function_add82897(var_a5e6be6d);
}

function private function_8b5d7508(objective) {
  return true;
}

function private function_b4c402b(objective) {
  return 4;
}

function private function_a6535861(objective) {
  if(self.bot.enemyseen) {
    return 3;
  }

  return 0;
}

function private koth_start() {
  level endon(#"game_ended");

  foreach(team in level.teams) {
    level function_8f96464(team, undefined, #"chase_enemy", #"patrol", undefined);
  }

  while(!isDefined(level.zones) || level.zones.size <= 0) {
    waitframe(1);
  }

  var_4185bc81 = [];

  foreach(zone in level.zones) {
    if(!isDefined(zone.gameobject)) {
      continue;
    }

    info = level function_5f64ef84(zone.gameobject);
    var_4185bc81[var_4185bc81.size] = info;
  }

  var_df910e1 = undefined;

  while(true) {
    if(isDefined(var_df910e1)) {
      object = var_df910e1.target;

      if(!object.trigger istriggerenabled()) {
        level function_add82897(var_df910e1);
        var_df910e1 = undefined;
      }
    }

    if(!isDefined(var_df910e1)) {
      foreach(info in var_4185bc81) {
        object = info.target;

        if(object.trigger istriggerenabled()) {
          var_df910e1 = info;

          foreach(team in level.teams) {
            level function_8f96464(team, info, #"capture", #"assault", &function_16dd5162);
            level function_8f96464(team, info, #"defend", #"assault", &function_9cb54b7c);
          }

          break;
        }
      }
    }

    if(isDefined(var_df910e1)) {
      object = var_df910e1.target;
      objectives = function_574923ee(var_df910e1);
      var_c0121fed = [];

      foreach(team in level.teams) {
        var_c0121fed[team] = function_84750938(object, team);
      }

      foreach(objective in objectives) {
        secure = var_c0121fed[objective.team];
        objective.secure = secure;
        objective.secure = secure;
      }
    }

    waitframe(1);
  }
}

function private function_16dd5162(objective) {
  return 5;
}

function private function_9cb54b7c(objective) {
  return 4;
}

function private function_13821498() {
  foreach(team in level.teams) {
    level function_8f96464(team, undefined, #"chase_enemy", #"patrol", undefined);
  }
}

function private function_5f64ef84(target) {
  info = {
    #target: target
  };
  regions = level function_5c2d40ff(target);
  neighbors = level function_323a3bdf(regions);
  info.var_dd2331cb = level function_8d2aa32e(regions);
  info.neighborids = level function_8d2aa32e(neighbors);
  return info;
}

function private function_e58e3486(info) {
  if(!isDefined(info.target)) {
    return;
  }

  regions = level function_5c2d40ff(info.target);

  if(regions.size <= 0) {
    return;
  }

  var_dd2331cb = level function_8d2aa32e(regions);

  if(var_dd2331cb.size == info.var_dd2331cb.size) {
    intersect = arrayintersect(var_dd2331cb, info.var_dd2331cb);

    if(var_dd2331cb.size == intersect.size) {
      return;
    }
  }

  neighbors = level function_323a3bdf(regions);
  neighborids = level function_8d2aa32e(neighbors);
  info.var_dd2331cb = var_dd2331cb;
  info.neighborids = neighborids;
}

function private function_5c2d40ff(target) {
  regions = [];

  if(isDefined(target.trigger)) {
    points = tacticalquery(#"hash_6ab834dd93762a6e", target.trigger);

    foreach(point in points) {
      info = function_b507a336(point.region);

      if(info.tacpoints.size < 5) {
        continue;
      }

      regions[info.id] = info;
    }
  }

  if(regions.size <= 0) {
    tpoint = getclosesttacpoint(target.origin);

    if(isDefined(tpoint)) {
      region = function_b507a336(tpoint.region);
      regions[region.id] = region;
    }
  }

  return regions;
}

function private function_84750938(object, team) {
  if(object gameobjects::function_3a29539b(team)) {
    return false;
  }

  if(object gameobjects::get_num_touching(team)) {
    return true;
  }

  owner = object gameobjects::get_owner_team();

  if(isDefined(owner) && owner == team) {
    return true;
  }

  return false;
}

function private function_323a3bdf(regions) {
  neighbors = [];

  foreach(regioninfo in regions) {
    foreach(id in regioninfo.neighbors) {
      if(isDefined(regions[id])) {
        continue;
      }

      region = function_b507a336(id);

      if(region.tacpoints.size < 5) {
        continue;
      }

      neighbors[id] = region;
    }
  }

  return neighbors;
}

function private function_8d2aa32e(regions) {
  ids = [];

  foreach(id, region in regions) {
    ids[ids.size] = id;
  }

  return ids;
}

function private function_8f96464(team, info, var_a1980fcb, var_5e99151a, weight) {
  objective = {
    #team: team, #info: info, #var_a1980fcb: var_a1980fcb, #var_5e99151a: var_5e99151a, #count: 0, #weight: weight, #active: 1
  };
  objectives = level.var_774ed7e9[team];
  objectives[objectives.size] = objective;
  return objective;
}

function private remove_objective(objective) {
  objective.active = 0;
  objectives = level.var_774ed7e9[objective.team];
  arrayremovevalue(objectives, objective);
}

function private function_add82897(info) {
  objectives = function_574923ee(info);

  foreach(objective in objectives) {
    remove_objective(objective);
  }
}

function private function_574923ee(info) {
  var_554456a7 = [];

  foreach(objectives in level.var_774ed7e9) {
    foreach(objective in objectives) {
      if(isDefined(objective.info) && objective.info == info) {
        var_554456a7[var_554456a7.size] = objective;
      }
    }
  }

  return var_554456a7;
}

function private function_994c497(objective) {
  count = objective.count;
  players = objective.info.target.users[objective.team].touching.players;

  if(!isDefined(players)) {
    return count;
  }

  foreach(player in players) {
    if(!isbot(player)) {
      count++;
    }
  }

  return count;
}