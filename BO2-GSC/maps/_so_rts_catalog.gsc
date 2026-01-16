/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_so_rts_catalog.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_so_rts_support;
#include maps\_so_rts_event;
#include maps\_so_rts_poi;
#include maps\_so_rts_squad;
#include maps\_so_rts_ai;
#include maps\_so_rts_main;
#include maps\_so_rts_catalog;

preload() {
  assert(isDefined(level.rts));
  assert(isDefined(level.rts_def_table));
  level.rts.packages = [];
  level.rts.packages_avail = [];
  level.rts.packages = package_populate();

  foreach(pkg in level.rts.packages) {
    if(isDefined(pkg.marker) && pkg.marker != "")
      precachemodel(pkg.marker);
  }
}

lookup_value(ref, idx, column_index) {
  assert(isDefined(idx));
  return tablelookup(level.rts_def_table, 0, idx, column_index);
}

pkg_exist(ref) {
  return isDefined(level.rts.packages) && isDefined(level.rts.packages[ref]);
}

get_pkg_ref_by_index(idx) {
  return tablelookup(level.rts_def_table, 0, idx, 1);
}

init() {
  level.rts.packages_avail = package_generateavailable("allies");
  assert(isDefined(level.rts.rules), "rules must be initialized first");
  level.rts.transport = spawnstruct();
  level.rts.transport.helo = [];
  level.rts.transport.vtol = [];
  level.rts.enemy_notification = 0;
  unith = 0;
  unitv = 0;

  for(i = 0; i < level.rts.game_rules.player_helo; i++) {
    unith = level.rts.transport.helo.size;
    level.rts.transport.helo[unith] = spawnstruct();
    level.rts.transport.helo[unith].state = 0;
    level.rts.transport.helo[unith].type = "helo";
    level.rts.transport.helo[unith].num = unith;
    level.rts.transport.helo[unith].team = "allies";
    level thread transportthink(level.rts.transport.helo[unith]);
  }

  for(i = 0; i < level.rts.game_rules.enemy_helo; i++) {
    unith = level.rts.transport.helo.size;
    level.rts.transport.helo[unith] = spawnstruct();
    level.rts.transport.helo[unith].state = 0;
    level.rts.transport.helo[unith].type = "helo";
    level.rts.transport.helo[unith].num = unith;
    level.rts.transport.helo[unith].team = "axis";
    level thread transportthink(level.rts.transport.helo[unith]);
  }

  for(i = 0; i < level.rts.game_rules.player_vtol; i++) {
    unitv = level.rts.transport.vtol.size;
    level.rts.transport.vtol[unitv] = spawnstruct();
    level.rts.transport.vtol[unitv].state = 0;
    level.rts.transport.vtol[unitv].type = "vtol";
    level.rts.transport.vtol[unitv].num = unitv;
    level.rts.transport.vtol[unitv].team = "allies";
    level thread transportthink(level.rts.transport.vtol[unitv]);
  }

  for(i = 0; i < level.rts.game_rules.enemy_vtol; i++) {
    unitv = level.rts.transport.vtol.size;
    level.rts.transport.vtol[unitv] = spawnstruct();
    level.rts.transport.vtol[unitv].state = 0;
    level.rts.transport.vtol[unitv].type = "vtol";
    level.rts.transport.vtol[unitv].num = unitv;
    level.rts.transport.vtol[unitv].team = "axis";
    level thread transportthink(level.rts.transport.vtol[unitv]);
  }

  maps\_so_rts_support::set_closestunitparams();
}

package_populate() {
  pkg_types = [];

  for(i = 100; i <= 120; i++) {
    ref = get_pkg_ref_by_index(i);

    if(!isDefined(ref) || ref == "") {
      continue;
    }
    pkg = spawnstruct();
    pkg.idx = i;
    pkg.ref = ref;
    pkg.name = lookup_value(ref, i, 2);
    pkg.desc = lookup_value(ref, i, 3);
    pkg.cost = [];
    cost = strtok(lookup_value(ref, i, 4), " ");
    assert(cost.size >= 1 && cost.size <= 2, "unexpected cost parameters");

    if(cost.size == 1) {
      if(cost[0] == "na")
        cost[0] = -1;

      pkg.cost["axis"] = int(cost[0]);
      pkg.cost["allies"] = int(cost[0]);
    } else {
      if(cost[0] == "na")
        cost[0] = -1;

      if(cost[1] == "na")
        cost[1] = -1;

      pkg.cost["axis"] = int(cost[0]);
      pkg.cost["allies"] = int(cost[1]);
    }

    if(pkg.cost["axis"] != -1)
      pkg.cost["axis"] = pkg.cost["axis"] * 1000;

    if(pkg.cost["allies"] != -1)
      pkg.cost["allies"] = pkg.cost["allies"] * 1000;

    pkg.units = [];
    pkg.units = strtok(lookup_value(ref, i, 5), " ");
    pkg.numunits = pkg.units.size;
    pkg.delivery = lookup_value(ref, i, 6);
    pkg.marker = lookup_value(ref, i, 7);
    pkg.selectable = 0;
    pkg.nextavail = [];
    pkg.nextavail["axis"] = gettime();
    pkg.nextavail["allies"] = gettime();
    pkg.poi_deps = [];
    pkg.poi_deps = strtok(lookup_value(ref, i, 8), " ");
    assert(isDefined(pkg.name));
    assert(isDefined(pkg.desc));
    assert(isDefined(pkg.delivery));

    if(pkg.delivery != "CODE") {
      foreach(unit in pkg.units)
      assert(isDefined(level.rts.ai[unit]), "Package is referencing undefined ai unit-->" + unit);
    }

    pkg.enforce_deps = [];
    pkg.enforce_deps["axis"] = 1;
    pkg.enforce_deps["allies"] = 1;
    pkg.squad_type = lookup_value(ref, i, 9);
    pkg.squad_material = lookup_value(ref, i, 10);
    pkg.qty = [];
    qty = strtok(lookup_value(ref, i, 11), " ");
    assert(qty.size >= 1 && qty.size <= 2, "unexpected qty parameters");

    if(qty.size == 1) {
      if(qty[0] == "inf")
        qty[0] = -1;

      pkg.qty["axis"] = -1;
      pkg.qty["allies"] = int(qty[0]);
    } else {
      if(qty[0] == "inf")
        qty[0] = -1;

      if(qty[1] == "inf")
        qty[1] = -1;

      pkg.qty["axis"] = int(qty[0]);
      pkg.qty["allies"] = int(qty[1]);
    }

    pkg.min_friendly = int(lookup_value(ref, i, 12));
    pkg.max_friendly = int(lookup_value(ref, i, 13));
    assert(pkg.min_friendly <= pkg.max_friendly, "Bad data");
    pkg.min_axis = pkg.min_friendly;
    pkg.max_axis = pkg.max_friendly;
    pkg.hot_key_buy = lookup_value(ref, i, 14);
    pkg.hot_key_command = lookup_value(ref, i, 15);
    pkg.hot_key_takeover = lookup_value(ref, i, 16);

    if(pkg.hot_key_buy != "")
      maps\_so_rts_support::registerkeybinding(pkg.hot_key_buy, ::package_buyunitpressed, pkg);
    else
      pkg.hot_key_buy = undefined;

    if(pkg.hot_key_command != "")
      maps\_so_rts_support::registerkeybinding(pkg.hot_key_command, ::package_commandunitpressed, pkg);
    else
      pkg.hot_key_command = undefined;

    if(pkg.hot_key_takeover != "")
      maps\_so_rts_support::registerkeybinding(pkg.hot_key_takeover, ::package_takeoverunitpressed, pkg);
    else
      pkg.hot_key_takeover = undefined;

    pkg.notifyavail = lookup_value(ref, i, 17);

    if(pkg.notifyavail == "")
      pkg.notifyavail = undefined;

    pkg.gateflag = lookup_value(ref, i, 18);

    if(pkg.gateflag == "")
      pkg.gateflag = undefined;

    pkg_types[pkg_types.size] = pkg;
  }

  return pkg_types;
}

package_commandunitfps(squadid) {
  assert(flag("fps_mode"));

  if(!isDefined(squadid)) {
    return;
  }
  squads = [];

  if(squadid == 99) {
    if(isDefined(level.rts.targetteamenemy)) {
      level notify("all_squads_attack");
      wait 0.05;
    } else {
      level notify("all_squads_move");
      wait 0.05;
    }

    maps\_so_rts_event::trigger_event("move_all_fps");
    allysquads = getteamsquads(level.rts.player.team);

    for(i = 0; i < allysquads.size; i++) {
      if(!is_true(allysquads[i].selectable)) {
        continue;
      }
      if(is_true(allysquads[i].no_group_commands)) {
        continue;
      }
      squads[squads.size] = allysquads[i];
    }
  } else {
    squad = level.rts.squads[squadid];
    squads[0] = squad;
  }

  direction = maps\_so_rts_support::get_player_angles();

  if(isDefined(level.rts.player.ally) && isDefined(level.rts.player.ally.vehicle)) {
    if(isDefined(level.rts.player.ally.vehicle.ai_ref.cmd_tag))
      eye = level.rts.player.ally.vehicle gettagorigin(level.rts.player.ally.vehicle.ai_ref.cmd_tag);
    else
      eye = level.rts.player.origin;
  } else
    eye = level.rts.player.origin + vectorscale((0, 0, 1), 60.0);

  direction_vec = anglestoforward(direction);
  trace = bullettrace(eye, eye + vectorscale(direction_vec, 100000), 1, level.rts.player);
  hitent = trace["entity"];
  tracepoint = trace["position"];

  thread maps\_so_rts_support::debugline(eye, tracepoint, (0, 0, 1), 3);
  thread maps\_so_rts_support::debug_sphere(tracepoint, 10, (0, 0, 1), 0.6, 3);

  if(level.rts.trace_blockers.size > 0) {
    foreach(volume in level.rts.trace_blockers) {
      if(maps\_utility::is_point_inside_volume(tracepoint, volume)) {
        level thread maps\_so_rts_support::create_hud_message(&"SO_RTS_UNIT_CANT_MOVE_THERE");
        return;
      }
    }
  }

  level.rts.targetpoi = undefined;
  level.rts.targetteamenemy = undefined;
  level.rts.targetteammate = undefined;

  if(isDefined(hitent)) {
    if(isDefined(maps\_so_rts_poi::ispoient(hitent)))
      level.rts.targetpoi = hitent;
    else {
      if(!isDefined(hitent.team)) {
        return;
      }
      if(hitent.team != level.rts.player.team)
        level.rts.targetteamenemy = hitent;
      else
        level.rts.targetteammate = hitent;
    }
  }

  foreach(squad in squads) {
    if(isDefined(squad.package_commandunitfps_cb))
      [[squad.package_commandunitfps_cb]](trace);

    if(isDefined(level.rts.targetteamenemy)) {
      thread maps\_so_rts_support::debug_sphere(tracepoint, 8, (1, 0, 0), 0.6, 3);

      maps\_so_rts_squad::ordersquadattack(squad.id, level.rts.targetteamenemy);
      continue;
    }

    if(isDefined(level.rts.targetpoi)) {
      thread maps\_so_rts_support::debug_sphere(tracepoint, 8, (0, 0, 1), 0.6, 3);

      if(!isDefined(level.rts.targetpoi.ai_ref))
        maps\_so_rts_squad::ordersquaddefend(level.rts.targetpoi.origin, squad.id);
      else
        maps\_so_rts_squad::ordersquadfollowai(squad.id, level.rts.targetpoi);

      if(level.rts.targetpoi.team != level.rts.player.team) {
        luinotifyevent(&"rts_squad_start_attack", 3, squad.id, level.rts.targetpoi getentitynumber(), int(level.rts.targetpoi.ref.obj_zoff));
        maps\_so_rts_event::trigger_event("dlg_target_fps_" + level.rts.targetpoi.ref.ref);
      }

      continue;
    }

    if(level.rts.closestunitparams.allowplayerteampip) {
      if(isDefined(level.rts.targetteammate)) {
        thread maps\_so_rts_support::debug_sphere(tracepoint, 8, (1, 0, 0), 0.6, 3);

        maps\_so_rts_squad::ordersquadfollowai(squad.id, level.rts.targetteammate);
        continue;
      }
    }

    groundpos = bullettrace(tracepoint + vectorscale(trace["normal"], 36), tracepoint + vectorscale(trace["normal"], 36) + vectorscale((0, 0, -1), 100000.0), 0, level.rts.player)["position"] + vectorscale((0, 0, 1), 6.0);
    level notify("squad_moved", groundpos, squad.id);
    level thread maps\_so_rts_squad::rts_move_squadstocursor(squad.id, groundpos);
  }
}

package_commandunitrts(squadid) {
  assert(flag("rts_mode"));
  squads = [];

  if(!isDefined(squadid)) {
    if(isDefined(level.rts.targetteammate))
      level.rts.activesquad = level.rts.targetteammate.squadid;

    return;
  }

  if(squadid == 99) {
    if(isDefined(level.rts.targetteamenemy)) {
      level notify("all_squads_attack");
      wait 0.05;
    } else {
      level notify("all_squads_move");
      wait 0.05;
    }

    maps\_so_rts_event::trigger_event("move_all_pkg");
    allysquads = getteamsquads(level.rts.player.team);

    for(i = 0; i < allysquads.size; i++) {
      if(!is_true(allysquads[i].selectable)) {
        continue;
      }
      if(is_true(allysquads[i].no_group_commands)) {
        continue;
      }
      squads[squads.size] = allysquads[i];
    }
  } else {
    squad = level.rts.squads[squadid];
    squads[0] = squad;
  }

  foreach(squad in squads) {
    if(isDefined(level.rts.targetteamenemy)) {
      maps\_so_rts_squad::ordersquadattack(squad.id, level.rts.targetteamenemy);
      continue;
    }

    if(isDefined(level.rts.targetpoi)) {
      maps\_so_rts_squad::ordersquaddefend(level.rts.targetpoi.origin, squad.id);

      if(level.rts.targetpoi.team != level.rts.player.team) {
        luinotifyevent(&"rts_squad_start_attack", 3, squad.id, level.rts.targetpoi getentitynumber(), int(level.rts.targetpoi.ref.obj_zoff));
        maps\_so_rts_event::trigger_event("dlg_target_" + level.rts.targetpoi.ref.ref);
      }

      continue;
    }

    if(level.rts.closestunitparams.allowplayerteampip) {
      if(isDefined(level.rts.targetteammate) && level.rts.targetteammate.squadid != squad.id) {
        maps\_so_rts_squad::ordersquadfollowai(squad.id, level.rts.targetteammate);
        continue;
      }
    }

    point = maps\_so_rts_support::playerlinkobj_gettargetgroundpos();

    if(!isDefined(point)) {
      level thread maps\_so_rts_support::create_hud_message(&"SO_RTS_UNIT_CANT_MOVE_THERE");
      return;
    }

    if(level.rts.trace_blockers.size > 0) {
      foreach(volume in level.rts.trace_blockers) {
        if(maps\_utility::is_point_inside_volume(point, volume)) {
          level thread maps\_so_rts_support::create_hud_message(&"SO_RTS_UNIT_CANT_MOVE_THERE");
          return;
        }
      }
    }

    level notify("squad_moved", point, squad.id);
    level thread maps\_so_rts_squad::rts_move_squadstocursor(squad.id, point);
  }
}

package_highlightunits(squadid, clear) {
  if(!isDefined(clear))
    clear = 1;

  if(squadid == 99) {
    if(is_true(clear)) {
      luinotifyevent(&"rts_highlight_squad", 1, -1);
      rpc("clientscripts/_so_rts", "set_SquadIsHighlighted", -1);
    }

    level.rts.activesquad = squadid;
    luinotifyevent(&"rts_highlight_squad", 1, level.rts.activesquad);
    squads = [];
    allysquads = getteamsquads(level.rts.player.team);

    for(i = 0; i < allysquads.size; i++) {
      if(!is_true(allysquads[i].selectable)) {
        continue;
      }
      if(is_true(allysquads[i].no_group_commands)) {
        continue;
      }
      squads[squads.size] = allysquads[i];
    }

    foreach(squad in squads)
    rpc("clientscripts/_so_rts", "set_SquadIsHighlighted", squad.id);
  } else if(level.rts.squads[squadid].selectable) {
    if(is_true(clear)) {
      luinotifyevent(&"rts_highlight_squad", 1, -1);
      rpc("clientscripts/_so_rts", "set_SquadIsHighlighted", -1);
    }

    level.rts.activesquad = squadid;
    luinotifyevent(&"rts_highlight_squad", 1, level.rts.activesquad);
    rpc("clientscripts/_so_rts", "set_SquadIsHighlighted", squadid);
  }
}

package_commandunitpressed(pkg_ref, squad) {
  if(!isDefined(squad))
    squad = maps\_so_rts_squad::getsquadbypkg(pkg_ref.ref, level.rts.player.team);

  if(isDefined(squad)) {
    if(!is_true(squad.selectable)) {
      return;
    }
    package_highlightunits(squad.id);
  }
}

package_takeoverunitpressed(pkg_ref) {
  squad = maps\_so_rts_squad::getsquadbypkg(pkg_ref.ref, level.rts.player.team);

  if(isDefined(squad)) {
    maps\_so_rts_squad::removedeadfromsquad(squad.id);

    if(squad.members.size == 0 || !is_true(squad.selectable)) {
      return;
    }
    maps\_so_rts_event::trigger_event("switch_character");
    maps\_so_rts_event::trigger_event("switch_" + squad.pkg_ref.ref);

    if(flag("rts_mode")) {
      point = maps\_so_rts_support::playerlinkobj_gettargetgroundpos();
      closest = undefined;
      sortedunits = sortarraybyclosest(point, squad.members);

      for(i = 0; i < sortedunits.size; i++) {
        unit = sortedunits[i];

        if(!maps\_so_rts_ai::ai_isselectable(unit)) {
          continue;
        }
        closest = unit;
        break;
      }

      if(isDefined(level.rts.targetteammate)) {
        luinotifyevent(&"rts_deselect", 1, level.rts.targetteammate getentitynumber());
        level.rts.targetteammate = undefined;
      }

      if(isDefined(level.rts.targetteamenemy)) {
        luinotifyevent(&"rts_deselect_enemy", 1, level.rts.targetteamenemy getentitynumber());
        level.rts.targetteamenemy = undefined;
      }

      if(isDefined(level.rts.targetpoi)) {
        luinotifyevent(&"rts_deselect_poi", 1, level.rts.targetpoi getentitynumber());
        level.rts.targetpoi = undefined;
      }

      level.rts.targetteammate = closest;
      thread maps\_so_rts_main::player_in_control();
    } else {
      direction = maps\_so_rts_support::get_player_angles();
      direction_vec = anglestoforward(direction);
      eye = level.rts.player geteye();
      trace = bullettrace(eye, eye + vectorscale(direction_vec, 10000), 1, level.rts.player);
      hitent = trace["entity"];

      if(isDefined(hitent) && isDefined(hitent.squadid) && hitent.squadid == squad.id)
        thread maps\_so_rts_squad::squadselectnextaiandtakeover(squad.id, undefined, hitent);
      else if(isDefined(level.rts.squads[squad.id].primary_ai_switchtarget))
        thread maps\_so_rts_squad::squadselectnextaiandtakeover(squad.id, undefined, level.rts.squads[squad.id].primary_ai_switchtarget);
      else
        thread maps\_so_rts_squad::squadselectnextaiandtakeover(squad.id);
    }
  }
}

package_buyunitpressed(pkg_ref) {
  if(flag("block_input")) {
    return;
  }
  level.rts.packages_avail = package_generateavailable(level.rts.player.team);

  if(isinarray(level.rts.packages_avail, pkg_ref) && pkg_ref.selectable)
    package_select(pkg_ref.ref);
  else
    return;
}

package_getnumteamresources(team) {
  resources = 0;

  for(i = 0; i < level.rts.packages_avail.size; i++) {
    if(level.rts.packages_avail[i].selectable == 0)
      continue;
    else if(level.rts.packages_avail[i].cost[team] >= 0)
      resources = resources + level.rts.packages_avail[i].qty[team] == -1 ? 1 : level.rts.packages_avail[i].qty[team];
  }

  resources = resources + numtransportsinboundforteam(team);

  foreach(squad in level.rts.squads) {
    if(squad.team != team) {
      continue;
    }
    resources = resources + squad.members.size;
  }

  if(team == "allies" && isDefined(level.rts.player.ally))
    resources = resources + 1;

  return resources;
}

package_select(pkg_ref, initial, cb) {
  if(!isDefined(initial))
    initial = 0;

  if(!isDefined(pkg_ref)) {
    if(level.rts.packages_avail[level.rts.package_index].selectable)
      thread spawn_package(level.rts.packages_avail[level.rts.package_index].ref, "allies", initial, cb);
    else
      level thread maps\_so_rts_support::create_hud_message(&"SO_RTS_UNIT_NOTAVAIL");
  } else {
    for(i = 0; i < level.rts.packages_avail.size; i++) {
      if(level.rts.packages_avail[i].ref == pkg_ref) {
        level.rts.package_index = i;
        thread spawn_package(pkg_ref, "allies", initial, cb);
        break;
      }
    }
  }
}

package_setpackagecost(ref, axiscost, allycost) {
  pkg = package_getpackagebytype(ref);
  assert(isDefined(ref));
  axiscost = int(axiscost);

  if(axiscost != -1)
    axiscost = axiscost * 1000;

  allycost = int(allycost);

  if(allycost != -1)
    allycost = allycost * 1000;

  pkg.cost["axis"] = axiscost;
  pkg.cost["allies"] = allycost;
}

package_getpackagebytype(ref) {
  for(i = 0; i < level.rts.packages.size; i++) {
    if(level.rts.packages[i].ref == ref)
      return level.rts.packages[i];
  }

  return undefined;
}

package_generateavailable(myteam, forceall) {
  if(!isDefined(myteam))
    myteam = "allies";

  available_pkgs = [];
  time = gettime();

  for(i = 0; i < level.rts.packages.size; i++) {
    pkg = level.rts.packages[i];

    if(pkg.cost[myteam] == -1) {
      continue;
    }
    if(pkg.qty[myteam] == 0 && !is_true(forceall)) {
      continue;
    }
    if(isDefined(pkg.gateflag) && !flag(pkg.gateflag)) {
      continue;
    }
    pkg.lastselectablestate = pkg.selectable;
    pkg.selectable = gettime() > pkg.nextavail[myteam];

    if(is_true(pkg.enforce_deps[myteam]) && pkg.poi_deps.size > 0) {
      foreach(dep in pkg.poi_deps) {
        poi = strtok(dep, "|");
        hasone = 0;

        for(j = 0; j < poi.size; j++) {
          actualpoi = maps\_so_rts_poi::getpoibyref(poi[j]);

          if(!isDefined(actualpoi) || isDefined(actualpoi) && actualpoi.team == myteam) {
            hasone = 1;
            break;
          }
        }

        if(!hasone) {
          pkg.selectable = 0;
          break;
        }
      }
    }

    available_pkgs[available_pkgs.size] = pkg;
  }

  if(!isDefined(forceall)) {
    foreach(pkg in available_pkgs) {
      if(isDefined(pkg.notifyavail) && pkg.selectable == 1 && pkg.selectable != pkg.lastselectablestate)
        level notify(pkg.notifyavail);
    }
  }

  return available_pkgs;
}

setpkgdelivery(ref, delivery) {
  assert(isDefined(delivery));
  assert(delivery == "STANDARD" || delivery == "CODE" || delivery == "FASTROPE_HELO" || delivery == "FASTROPE_VTOL" || delivery == "CARGO_VTOL", "Unknown delivery option");
  pkg_ref = package_getpackagebytype(ref);

  if(isDefined(pkg_ref))
    pkg_ref.delivery = delivery;
}

setpkgqty(ref, team, qty, squadid) {
  pkg_ref = package_getpackagebytype(ref);

  if(isDefined(pkg_ref)) {
    pkg_ref.qty[team] = qty;

    println("Setting pkg quantity for(" + ref + ") of team:" + team + " to:" + qty);

  }

  if(team == "allies") {
    level.rts.packages_avail = package_generateavailable("allies");

    if(isDefined(squadid))
      luinotifyevent(&"rts_update_remaining_count", 2, squadid, pkg_ref.qty["allies"] > 0 ? pkg_ref.qty["allies"] : -1);
  }
}

setpkgdependancyenforcement(ref, team, state) {
  pkg_ref = package_getpackagebytype(ref);

  if(isDefined(pkg_ref))
    pkg_ref.enforce_deps[team] = state;

  if(team == "allies")
    level.rts.packages_avail = package_generateavailable("allies");
}

candeliverpkg(team, delivery, pkg_ref) {
  if(pkg_ref.delivery == "CODE" || pkg_ref.delivery == "STANDARD") {
    if(pkg_ref.nextavail["allies"] > gettime())
      return "not_ready";
  }

  if(pkg_ref.qty[team] != -1) {
    if(pkg_ref.qty[team] > 0)
      return "ok";
    else
      return "not_ready";
  }

  return "ok";
}

spawn_package(package_name, team, initial, callback) {
  pkg_ref = maps\_so_rts_catalog::package_getpackagebytype(package_name);
  assert(isDefined(pkg_ref));
  delivery = pkg_ref.delivery;

  if(is_true(initial) && delivery != "CODE")
    delivery = "STANDARD";

  if(delivery == "STANDARD" || delivery == "CODE") {
    if(is_true(initial) || pkg_ref.selectable && gettime() >= pkg_ref.nextavail[team]) {
      if(pkg_ref.qty[team] > 0)
        pkg_ref.qty[team]--;

      pkg_ref.nextavail[team] = gettime() + pkg_ref.cost[team];

      switch (delivery) {
        case "STANDARD":
          squadid = maps\_so_rts_ai::spawn_ai_package_standard(pkg_ref, team, callback);

          if(isDefined(squadid) && squadid == -1)
            squadid = undefined;

          if(team == level.rts.player.team && pkg_ref.qty[team] >= 0)
            luinotifyevent(&"rts_update_remaining_count", 2, squadid, pkg_ref.qty[team] > 0 ? pkg_ref.qty[team] : -1);

          return squadid;
          break;
        case "CODE":
          squadid = maps\_so_rts_catalog::spawn_package_code(pkg_ref, team, callback);

          if(isDefined(squadid) && squadid == -1)
            squadid = undefined;

          if(team == level.rts.player.team && pkg_ref.qty[team] >= 0)
            luinotifyevent(&"rts_update_remaining_count", 2, squadid, pkg_ref.qty[team] > 0 ? pkg_ref.qty[team] : -1);

          return squadid;
          break;
      }
    } else
      return undefined;
  }

  result = candeliverpkg(team, delivery, pkg_ref);

  if(result == "ok") {
    cb = undefined;
    type = "helo";

    switch (delivery) {
      case "FASTROPE_HELO":
        cb = maps\_so_rts_ai::spawn_ai_package_helo;
        break;
      case "FASTROPE_VTOL":
        cb = maps\_so_rts_ai::spawn_ai_package_helo;
        type = "vtol";
        break;
      case "CARGO_VTOL":
        cb = maps\_so_rts_ai::spawn_ai_package_cargo;
        type = "vtol";
        break;
      default:
        assert(0, "Unhandled case");
        break;
    }

    unit = allocatetransport(team, type, pkg_ref, cb, callback);

    if(isDefined(unit)) {
      if(pkg_ref.qty[team] > 0)
        pkg_ref.qty[team]--;

      if(team == level.rts.player.team && pkg_ref.qty[team] >= 0)
        luinotifyevent(&"rts_update_remaining_count", 2, unit.squadid, pkg_ref.qty[team] > 0 ? pkg_ref.qty[team] : -1);
    }
  }

  if(result == "ok" && isDefined(unit))
    return unit.squadid;

  return undefined;
}

spawn_package_code(pkg_ref, team, callback) {
  if(isDefined(level.rts.codespawncb)) {
    squadid = [
      [level.rts.codespawncb]
    ](pkg_ref, team, callback);
    assert(isDefined(squadid), "Custom Code must return squadID");
    return squadid;
  }

  if(isDefined(level.rts.switch_trans))
    return -1;

  foreach(unit in pkg_ref.units) {
    switch (unit) {
      case "airstrike":
        thread maps\_so_rts_support::fire_missile();
        break;
      default:
        assert(0, "Unhandled case");
        break;
    }
  }

  return -1;
}

transportthink(unit) {
  level endon("rts_terminated");
  flag_wait("start_rts");
  unit.state = 0;
  unit.refueltime = 0;
  unit.loadtime = 0;
  waittillframeend;

  while(true) {
    switch (unit.state) {
      case 0:
        break;
      case 2:
        if(gettime() > unit.refueltime) {
          unit.delivered_pkg = undefined;
          unit.state = 0;
          unit.refueltime = 0;
          unit.loadtime = 0;
        } else if(!is_true(level.rts.blockfastdelivery) && unit.team != level.rts.player.team && level.rts.squads[unit.squadid].members.size == 0)
          unit.refueltime = gettime();

        break;
      case 3:
        if(gettime() > unit.loadtime) {
          if(unit.team == "allies")
            maps\_so_rts_event::trigger_event("inc_" + unit.pkg_ref.ref);

          unit.state = 1;

          if([
              [unit.cb]
            ](unit) == -1) {
            unit.delivered_pkg = undefined;
            unit.state = 0;
            unit.refueltime = 0;
            unit.loadtime = 0;
          }

          unit.flightannounce = gettime() + 4000;
        } else if(!is_true(level.rts.blockfastdelivery) && unit.team != level.rts.player.team && level.rts.squads[unit.squadid].members.size == 0) {
          unit.loadtime = gettime();

          println("@@@@@@@@@@@@@@@@@@@Transport loadTime for [" + unit.pkg_ref.ref + "] zero'd out due to insufficient units (0)");

        }

        break;
      case 1:
        if(isDefined(unit.flightannounce) && gettime() > unit.flightannounce && unit.team == "allies")
          unit.flightannounce = undefined;

        break;
    }

    wait 0.25;
  }
}

getnumtransports(type, team, avail) {
  count = 0;

  if(type == "helo")
    transports = level.rts.transport.helo;
  else if(type == "vtol")
    transports = level.rts.transport.vtol;

  for(i = 0; i < transports.size; i++) {
    if(transports[i].team == team) {
      if(isDefined(avail)) {
        if(transports[i].state == 0)
          count++;

        continue;
      }

      count++;
    }
  }

  return count;
}

units_delivered(team, squadid) {
  if(team == "allies" && isDefined(level.rts.squads[squadid].pkg_ref.hot_key_takeover)) {
    luinotifyevent(&"rts_add_squad", 3, squadid, level.rts.squads[squadid].pkg_ref.idx, 0);
    wait 0.05;
  }

  maps\_so_rts_squad::squad_unloaded(squadid);

  if(team == level.rts.player.team) {
    level thread maps\_so_rts_support::create_hud_message(&"SO_RTS_DELIVERY_ARRIVED");
    level.rts.squads[squadid].selectable = 1;
  } else if(level.rts.enemy_notification < gettime()) {
    level thread maps\_so_rts_support::create_hud_message(&"SO_RTS_ENEMY_ARRIVED");
    level.rts.enemy_notification = gettime() + 6000;
  }

  if(isDefined(level.rts.activesquad))
    package_highlightunits(level.rts.activesquad);
}

unloadtransport(unit) {
  unit.delivered_pkg = unit.pkg_ref;
  unit.cb = undefined;
  unit.param = undefined;
  unit.pkg_ref = undefined;
}

deallocatetransport(unit) {
  unit.refueltime = gettime() + level.rts.transport_refuel_delay;
  unit.state = 2;
}

istransportavailable(team, type) {
  availtransport = undefined;

  if(type == "helo")
    transports = level.rts.transport.helo;
  else if(type == "vtol")
    transports = level.rts.transport.vtol;
  else
    assert(0, "bad type passed");

  for(i = 0; i < transports.size; i++) {
    if(transports[i].team == team && transports[i].state == 0) {
      availtransport = transports[i];
      break;
    }
  }

  return isDefined(availtransport);
}

allocatetransport(team, type, pkg_ref, cb, paramcb) {
  availtransport = undefined;

  if(type == "helo")
    transports = level.rts.transport.helo;
  else if(type == "vtol")
    transports = level.rts.transport.vtol;
  else
    assert(0, "bad type passed");

  for(i = 0; i < transports.size; i++) {
    if(transports[i].team == team && transports[i].state == 0) {
      availtransport = transports[i];
      break;
    }
  }

  if(isDefined(availtransport)) {
    availtransport.cb = cb;
    availtransport.param = paramcb;
    availtransport.pkg_ref = pkg_ref;
    availtransport.type = type;
    availtransport.state = 3;
    availtransport.loadtime = gettime() + pkg_ref.cost[team];
    availtransport.droptarget = get_package_drop_target(team);
    availtransport.squadid = maps\_so_rts_squad::createsquad(availtransport.droptarget, team, pkg_ref);

    if(team == level.rts.player.team) {
      startloc = maps\_so_rts_support::get_transport_startloc(availtransport.droptarget, team, type);
      lastnode = startloc;
      unloadnode = undefined;

      while(isDefined(lastnode.target)) {
        if(!isDefined(unloadnode) && isDefined(lastnode.script_unload))
          unloadnode = lastnode;

        lastnode = getvehiclenode(lastnode.target, "targetname");
      }

      assert(isDefined(unloadnode), "no script_unload was found");
      timeto = gettimefromvehiclenodetonode(startloc, unloadnode) * 1000 + pkg_ref.cost[team];
      timeback = gettimefromvehiclenodetonode(unloadnode, lastnode) * 1000 + level.rts.transport_refuel_delay;

      println("**** transport - timeTo: (" + timeto + ") timeBack: (" + timeback + ")");

      if(team == "allies" && isDefined(pkg_ref.hot_key_takeover)) {
      }
    }
  }

  return availtransport;
}

getnumberofpkgsbeingtransported(team, ref) {
  transports = arraycombine(level.rts.transport.helo, level.rts.transport.vtol, 0, 0);
  count = 0;

  for(i = 0; i < transports.size; i++) {
    if(transports[i].team == team && transports[i].state != 0 && isDefined(transports[i].pkg_ref) && transports[i].pkg_ref.ref == ref)
      count++;
  }

  return count;
}

getnumberoftypebeingtransported(team, pkgtype) {
  transports = arraycombine(level.rts.transport.helo, level.rts.transport.vtol, 0, 0);
  count = 0;

  for(i = 0; i < transports.size; i++) {
    if(transports[i].team == team && transports[i].state != 0 && isDefined(transports[i].pkg_ref) && transports[i].pkg_ref.squad_type == pkgtype)
      count++;
  }

  return count;
}

numtransportsinboundforteam(team) {
  transports = arraycombine(level.rts.transport.helo, level.rts.transport.vtol, 0, 0);
  count = 0;

  for(i = 0; i < transports.size; i++) {
    if(transports[i].team == team && transports[i].state != 0 && isDefined(transports[i].pkg_ref))
      count++;
  }

  return count;
}

pkg_ref_checkmaxspawn(pkg, team) {
  assert(isDefined(pkg));
  ai_list = arraycombine(getaiarray(team), getvehiclearray(team), 0, 0);
  count = 0;

  foreach(guy in ai_list) {
    if(isDefined(guy.squadid)) {
      if(level.rts.squads[guy.squadid].pkg_ref.ref == pkg.ref)
        count++;
    }
  }

  if(team == "allies")
    max = pkg.max_friendly;
  else
    max = pkg.max_axis;

  return count < max;
}