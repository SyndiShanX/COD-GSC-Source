/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_so_rts_squad.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_so_rts_catalog;
#include maps\_so_rts_squad;
#include maps\_so_rts_event;
#include maps\_so_rts_support;
#include maps\_so_rts_ai;
#include maps\_so_rts_main;
#include animscripts\combat_utility;

init() {
  level.rts.squads = [];
  level.rts.nextsquadid = 0;
  level.rts.selectedunits = [];
  level thread squadthink();
  packages_avail = maps\_so_rts_catalog::package_generateavailable("allies", 1);
  center = level.rts.player.origin;

  if(isDefined(level.rts.allied_base) && isDefined(level.rts.allied_base.entity))
    center = level.rts.allied_base.entity.origin;

  if(isDefined(level.rts.allied_center))
    center = level.rts.allied_center.origin;

  for(i = 0; i < packages_avail.size; i++) {
    if(packages_avail[i].delivery == "CODE") {
      continue;
    }
    maps\_so_rts_squad::createsquad(center, "allies", packages_avail[i]);
  }

  center = undefined;
  packages_avail = maps\_so_rts_catalog::package_generateavailable("axis", 1);

  if(isDefined(level.rts.enemy_base) && isDefined(level.rts.enemy_base.entity))
    center = level.rts.enemy_base.entity.origin;

  if(isDefined(level.rts.enemy_center))
    center = level.rts.enemy_center.origin;

  assert(isDefined(center), "Enemy center not defined");

  for(i = 0; i < packages_avail.size; i++) {
    if(packages_avail[i].delivery == "CODE") {
      continue;
    }
    maps\_so_rts_squad::createsquad(center, "axis", packages_avail[i]);
  }
}

rallysquadtoloc(spot, id) {
  ordersquaddefend(spot, id);
  maps\_so_rts_event::trigger_event("squad_move_fps");
  maps\_so_rts_event::trigger_event("move_" + level.rts.squads[id].pkg_ref.ref);
}

rts_is_pointok(point) {
  if(level.rts.trace_blockers.size > 0) {
    foreach(volume in level.rts.trace_blockers) {
      if(maps\_utility::is_point_inside_volume(point, volume))
        return false;
    }
  }

  return true;
}

rts_move_squadstocursor(squadid, tracepoint) {
  if(!isDefined(tracepoint)) {
    direction = maps\_so_rts_support::get_player_angles();
    direction_vec = anglestoforward(direction);
    eye = level.rts.player.origin + vectorscale((0, 0, 1), 60.0);
    trace = bullettrace(eye, eye + vectorscale(direction_vec, 100000), 1, level.rts.player);
    tracepoint = trace["position"];
  }

  thread maps\_so_rts_support::debug_sphere(tracepoint, 10, (0, 0, 1), 0.6, 60);

  if(isDefined(level.rts.squads[squadid].squad_nonodecheckonmove) && level.rts.squads[squadid].squad_nonodecheckonmove) {
    if(rts_is_pointok(tracepoint))
      rallysquadtoloc(tracepoint, squadid);

    return;
  }

  nodes = getnodesinradiussorted(tracepoint, 512, 0, 48);

  if(nodes.size == 0) {
    level thread maps\_so_rts_support::create_hud_message(&"SO_RTS_UNIT_CANT_MOVE_THERE");

    println("SQUAD: No Nodes located");
    thread maps\_so_rts_support::debug_circle(tracepoint, 512, (1, 0, 0), 3000);

    return;
  }

  if(!isDefined(squadid)) {
    if(isDefined(level.rts.player.ally))
      squadid = level.rts.player.ally.squadid;
    else
      return;
  }

  for(i = 0; i < nodes.size; i++) {
    if(findpath(tracepoint, nodes[i].origin)) {
      if(rts_is_pointok(nodes[i].origin))
        rallysquadtoloc(tracepoint, squadid);

      return;
    }
  }

  if(nodes.size && findpath(nodes[0].origin, level.rts.squads[squadid].centerpoint)) {
    distsq = distancesquared(nodes[0].origin, tracepoint);

    if(distsq < 65536) {
      if(rts_is_pointok(tracepoint))
        rallysquadtoloc(tracepoint, squadid);
    } else if(rts_is_pointok(nodes[0].origin))
      rallysquadtoloc(nodes[0].origin, squadid);
  } else {
    level thread maps\_so_rts_support::create_hud_message(&"SO_RTS_UNIT_CANT_MOVE_THERE");

    println("SQUAD: No path to node located(nodes tested=" + nodes.size + ")");

  }
}

getnextvalidsquad(cursquad, direction) {
  validsquads = [];

  if(!isDefined(cursquad))
    cursquad = 0;
  else {
    if(cursquad < 0)
      cursquad = level.rts.squads.size - 1;

    if(cursquad > level.rts.squads.size - 1)
      cursquad = 0;
  }

  maps\_so_rts_squad::removedeadfromsquad(cursquad);

  if(!isDefined(direction))
    direction = 1;

  assert(direction == 1 || direction == -1);

  for(i = 0; i < level.rts.squads.size; i++) {
    if(level.rts.squads[i].team == "allies" && level.rts.squads[i].members.size > 0 && (isDefined(level.rts.squads[i].selectable) && level.rts.squads[i].selectable))
      validsquads[validsquads.size] = level.rts.squads[i];
  }

  if(validsquads.size == 0)
    return -1;

  lastsquad = validsquads.size - 1;

  for(i = 0; i < validsquads.size; i++) {
    if(validsquads[i].id == cursquad) {
      if(direction == 1) {
        if(i + 1 < validsquads.size)
          return validsquads[i + 1].id;
        else
          return validsquads[0].id;
      }

      if(direction == -1)
        return validsquads[lastsquad].id;
    }

    lastsquad = i;
  }

  return validsquads[0].id;
}

squadselectnextaiandtakeover(nextsquad, norestore, targetent) {
  if(isDefined(level.rts.squadselectnext)) {
    return;
  }
  if(isDefined(level.rts.player.ally) && isDefined(level.rts.player.ally.vehicle) && isDefined(nextsquad) && level.rts.squads[nextsquad].members.size == 1 && level.rts.squads[nextsquad].members[0] == level.rts.player.ally.vehicle) {
    return;
  }
  if(isDefined(nextsquad) && level.rts.squads[nextsquad].members.size == 0)
    nextsquad = undefined;

  level.rts.squadselectnext = 1;
  level notify("switch_and_takeover");

  if(!isDefined(nextsquad)) {
    if(isDefined(level.rts.player.ally))
      cursquad = level.rts.player.ally.squadid;
    else
      cursquad = undefined;

    nextsquad = getnextvalidsquad(cursquad);
  }

  if(nextsquad != -1) {
    if(!maps\_so_rts_ai::ai_istakeoverpossible(targetent))
      targetent = undefined;

    if(!isDefined(targetent)) {
      maps\_so_rts_squad::removedeadfromsquad(nextsquad);
      sortedmemberlist = maps\_so_rts_support::sortarraybyclosest(level.rts.player.origin, level.rts.squads[nextsquad].members);

      for(i = 0; i < sortedmemberlist.size; i++) {
        guy = sortedmemberlist[i];

        if(isDefined(level.rts.player.ally.vehicle) && guy == level.rts.player.ally.vehicle) {
          continue;
        }
        if(maps\_so_rts_ai::ai_istakeoverpossible(guy)) {
          targetent = guy;
          break;
        }
      }
    }

    if(isDefined(targetent)) {
      flag_set("block_input");
      level.rts.player freezecontrols(1);
      level.rts.player enableinvulnerability();

      if(isDefined(targetent.classname) && targetent.classname == "script_vehicle")
        targetent veh_magic_bullet_shield(1);
      else
        targetent.takedamage = 0;

      maps\_so_rts_support::hide_player_hud();
      level clientnotify("chr_swtch_start");
      targetent notify("taken_control_over");
      level notify("taken_control_over", targetent);
      level.rts.player thread maps\_so_rts_support::do_switch_transition();
      rpc("clientscripts/_so_rts", "holdSwitchStatic", 1);
      level waittill("switch_fullstatic");
      luinotifyevent(&"hud_expand_ammo");

      if(!isDefined(norestore))
        level.rts.player maps\_so_rts_ai::restorereplacement();

      level.rts.player unlink();
      targetent = level.rts.player maps\_so_rts_ai::takeoverselected(targetent);

      if(!(isDefined(targetent.classname) && targetent.classname == "script_vehicle" || maps\_so_rts_ai::is_mechanical(targetent))) {
        level.rts.player showviewmodel();
        level.rts.player enableweapons();
      }

      rpc("clientscripts/_so_rts", "holdSwitchStatic", 0);
      level clientnotify("chr_swtch_end");
      wait 0.5;
      flag_clear("block_input");
      level.rts.player freezecontrols(0);
      maps\_so_rts_support::show_player_hud();

      if(!(isDefined(targetent.classname) && targetent.classname == "script_vehicle"))
        level.rts.player disableinvulnerability();
      else
        targetent veh_magic_bullet_shield(0);

      level notify("takeover_complete");
    } else {
      level.rts.lastfpspoint = level.rts.player.origin;
      level thread player_eyeinthesky();

      println("**** Player attempted to switch into squad:" + nextsquad + " but no units were acceptible to switch into.");

    }
  } else {
    level.rts.lastfpspoint = level.rts.player.origin;
    level thread maps\_so_rts_main::player_eyeinthesky();

    println("**** Player attempted to switch into squad but no valid squads found.");

  }

  level.rts.squadselectnext = undefined;
}

issquadalreadycreated(team, pkg_ref) {
  for(i = 0; i < level.rts.squads.size; i++) {
    if(level.rts.squads[i].team == team && level.rts.squads[i].pkg_ref == pkg_ref)
      return level.rts.squads[i];
  }

  return undefined;
}

hassquadmakeupchanged(squadid) {
  squad = level.rts.squads[squadid];

  if(!isDefined(squad)) {
    return;
  }
  if(isDefined(squad.dirty) && squad.dirty) {
    squad.lastsquadchecksum = -1;
    squad.dirty = 0;
  }

  chksum = 0;

  foreach(guy in squad.members) {
    if(isDefined(guy) && (isDefined(guy.initialized) && guy.initialized))
      chksum = chksum + guy getentitynumber();
  }

  changed = chksum == squad.lastsquadchecksum ? 0 : 1;
  squad.lastsquadchecksum = chksum;
  return changed;
}

createsquad(center, team, pkg_ref) {
  squad = issquadalreadycreated(team, pkg_ref);

  if(!isDefined(squad)) {
    squadid = level.rts.nextsquadid;
    level.rts.nextsquadid = level.rts.nextsquadid + 1;
    squad = spawnstruct();
    squad.members = [];
    squad.state = 1;
    squad.laststate = 0;
    squad.nextstate = team == level.rts.player.team ? 5 : 7;
    squad.centerpoint = center + vectorscale((0, 0, 1), 12.0);
    squad.id = squadid;
    squad.team = team;
    squad.think = ::squaddonothing;
    squad.pkg_ref = pkg_ref;
    squad.base_origin = center;
    squad.lastsquadchecksum = -1;

    if(isDefined(pkg_ref.marker)) {
      squad.marker = spawn("script_model", center);
      squad.marker setmodel(pkg_ref.marker);
      squad.marker hide();
      squad.marker.hidden = 1;
    }

    level.rts.squads[squadid] = squad;

    println("@@@@@@@@@@@@@@@@@@@@@SQUAD CREATED (" + squadid + ") for type: " + pkg_ref.ref + " on team: " + team);

  }

  squad.dirty = 1;
  return squad.id;
}

squad_hideallsquadmarkers(removeall) {
  if(!isDefined(removeall))
    removeall = 0;

  foreach(squad in level.rts.squads) {
    luinotifyevent(&"rts_move_squad_marker", 1, squad.id);

    if(removeall)
      luinotifyevent(&"rts_remove_squad", 1, squad.id);
  }
}

removesquadmarker(squadid, onempty) {
  if(!isDefined(onempty))
    onempty = 0;

  level notify("removeSquadMarker" + squadid);
  level endon("removeSquadMarker" + squadid);

  if(isDefined(onempty) && onempty) {
    while(true) {
      wait 1;

      if(isDefined(level.rts.switch_trans)) {
        continue;
      }
      maps\_so_rts_squad::removedeadfromsquad(squadid);

      if(isDefined(level.rts.player.ally) && level.rts.player.ally.squadid == squadid) {
        continue;
      }
      if(level.rts.squads[squadid].members.size == 0) {
        break;
      }
    }
  }

  luinotifyevent(&"rts_move_squad_marker", 1, squadid);
  luinotifyevent(&"rts_remove_squad", 1, squadid);
}

movesquadmarker(squadid, hide, point) {
  if(!isDefined(hide))
    hide = 0;

  if(!isDefined(level.rts.squads[squadid].marker)) {
    return;
  }
  if(!isDefined(point))
    point = level.rts.squads[squadid].centerpoint;

  if(level.rts.squads[squadid].team == "axis")
    hide = 1;

  if(isDefined(level.rts.squads[squadid].no_show_marker) && level.rts.squads[squadid].no_show_marker)
    hide = 1;

  level.rts.squads[squadid].marker.angles = (0, squadid * 70, 0);
  level.rts.squads[squadid].marker.origin = point;
  level.rts.squads[squadid].marker.hidden = hide;

  if(isDefined(hide) && hide)
    luinotifyevent(&"rts_move_squad_marker", 1, squadid);
  else
    luinotifyevent(&"rts_move_squad_marker", 4, squadid, int(point[0]), int(point[1]), int(point[2]));
}

squad_unloaded(squadid) {
  level.rts.squads[squadid].dirty = 1;

  foreach(guy in level.rts.squads[squadid].members) {
    if(isDefined(guy) && !isDefined(guy.ridingvehicle)) {
      if(!(isDefined(guy.initialized) && guy.initialized)) {
        guy maps\_so_rts_ai::ai_initialize(guy.ai_ref, level.rts.squads[squadid].team, isDefined(guy.initnode) ? guy.initnode.origin : undefined, squadid, isDefined(guy.initnode) ? guy.initnode.angles : undefined, level.rts.squads[squadid].pkg_ref);

        if(flag("rts_mode"))
          guy thread maps\_so_rts_support::perfect_aim_fortimeoruntilnotify(undefined, level.rts.game_rules.ally_perfect_aimtime);
      }

      guy maps\_so_rts_ai::ai_postinitialize();
      guy.rts_unloaded = 1;
    }
  }

  if(level.rts.squads[squadid].team == "allies")
    maps\_so_rts_event::trigger_event("ack_" + level.rts.squads[squadid].pkg_ref.ref);

  level.rts.squads[squadid].selectable = 1;
  level notify("squad_unloaded", squadid);
  reissuesquadlastorders(squadid);
}

swapsquads(fromsquadid, tosquadid) {
  removedeadfromsquad(fromsquadid);
  removedeadfromsquad(tosquadid);
  self removeaifromsquad();

  if(!isinarray(level.rts.squads[tosquadid].members, self)) {
    level.rts.squads[tosquadid].members[level.rts.squads[tosquadid].members.size] = self;
    luinotifyevent(&"rts_add_friendly_ai", 4, self getentitynumber(), tosquadid, 0, level.rts.squads[tosquadid].pkg_ref.idx);
  }

  self.squadid = tosquadid;
}

removeaifromsquad() {
  assert(isDefined(self) && isDefined(self.squadid));
  arrayremovevalue(level.rts.squads[self.squadid].members, self, 1);
  luinotifyevent(&"rts_remove_ai", 1, self getentitynumber());
  self.squadid = undefined;
}

addaitosquad(squadid) {
  if(!isinarray(level.rts.squads[squadid].members, self)) {
    self maps\_so_rts_ai::ai_preinitialize(self.ai_ref, level.rts.squads[squadid].pkg_ref, level.rts.squads[squadid].team, squadid);
    level.rts.squads[squadid].members[level.rts.squads[squadid].members.size] = self;
    self maps\_so_rts_support::set_gpr(maps\_so_rts_support::make_gpr_opcode(4) + squadid);
  }
}

removedeadfromsquad(squadid) {
  alive = [];

  if(!isDefined(squadid)) {
    return;
  }
  for(i = 0; i < level.rts.squads[squadid].members.size; i++) {
    ai = level.rts.squads[squadid].members[i];

    if(!isDefined(ai)) {
      continue;
    }
    if(isalive(ai))
      alive[alive.size] = ai;
  }

  level.rts.squads[squadid].members = alive;
}

getsquadlistfromselected() {
  squads = [];
  arrayremovevalue(level.rts.selectedunits, undefined);

  foreach(guy in level.rts.selectedunits) {
    squadid = guy.squadid;
    inalready = 0;

    for(i = 0; i < squads.size; i++) {
      if(squads[i].id == squadid) {
        inalready = 1;
        break;
      }
    }

    if(!inalready)
      squads[squads.size] = level.rts.squads[squadid];
  }

  return squads;
}

notifysquadmembersofneworders(squadid) {
  level notify("new_squad_orders" + squadid);
  level.rts.squads[squadid].dirty = 1;

  foreach(guy in level.rts.squads[squadid].members) {
    guy notify("new_squad_orders");

    if(isDefined(guy.last_goalradius)) {
      guy.goalradius = guy.last_goalradius;
      guy.last_goalradius = undefined;
    }

    guy.poi = undefined;
  }

  wait 0.05;
}

issquadmoving(squadid) {
  return level.rts.squads[squadid].state == 2;
}

doessquadhaveanyspeciesoftype(squadid, speciestype) {
  squad = maps\_so_rts_squad::getsquad(squadid);

  if(!isDefined(squad))
    return false;

  foreach(guy in squad.members) {
    if(guy.ai_ref.species == speciestype)
      return true;
  }

  return false;
}

getteamsquads(team) {
  squads = [];

  foreach(squad in level.rts.squads) {
    if(squad.team == team)
      squads[squads.size] = squad;
  }

  return squads;
}

gotopoint(goal) {
  self endon("new_squad_orders");
  self endon("death");
  self endon("taken_control_over");
  self notify("gotoPoint", goal);
  self endon("gotoPoint");

  if(isDefined(self.last_goalradius)) {
    self.goalradius = self.last_goalradius;
    self.last_goalradius = undefined;
  }

  if(!isDefined(self.goalradius))
    self.goalradius = 512;

  self.at_goal = undefined;

  if(self.goalradius > 512) {
    self.last_goalradius = self.goalradius;
    self.goalradius = 512;
  } else if(self.goalradius < 350) {
    self.last_goalradius = self.goalradius;
    self.goalradius = 350;
  }

  if(isai(self)) {
    self squaddebug("gotoPoint", goal);

    if(isDefined(self.isbigdog) && self.isbigdog) {
      goingtonode = 0;
      node = get_closest_doublewidenode(goal, self.goalradius, 100);

      if(isDefined(node)) {
        goal = node;
        goingtonode = 1;
      } else {
        node = get_closest_doublewidenode(goal, 1000, 600);

        if(isDefined(node)) {
          goal = node;
          goingtonode = 1;
        }
      }

      if(goingtonode)
        self setgoalnode(goal);
      else
        self setgoalpos(goal);

      self waittill("goal");
    } else {
      self setgoalpos(goal);
      self waittill("goal");
      self animscripts\combat_utility::lookforbettercover(0);
    }
  } else if(!issentient(self)) {
    if(self.classname == "script_vehicle") {
      self setvehgoalpos(goal, 1);
      self waittill_any("goal", "near_goal");
    }
  } else {
    self thread maps\_vehicle::defend(goal);
    self waittill("goal");
  }

  if(isDefined(self.last_goalradius)) {
    self.goalradius = self.last_goalradius;
    self.last_goalradius = undefined;
  }

  self.at_goal = 1;
}

moveout() {
  if(isDefined(self))
    self thread gotopoint(level.rts.squads[self.squadid].centerpoint);
}

squadmove(squadid) {
  if(hassquadmakeupchanged(squadid)) {
    foreach(guy in level.rts.squads[squadid].members)
    guy thread moveout();
  }
}

executesquadmoveto(squadid) {
  notifysquadmembersofneworders(squadid);

  if(level.rts.squads[squadid].state != level.rts.squads[squadid].nextstate) {
    level.rts.squads[squadid].laststate = level.rts.squads[squadid].state;
    level.rts.squads[squadid].state = level.rts.squads[squadid].nextstate;
  }

  level.rts.squads[squadid].think = ::squadmove;
  level.rts.squads[squadid].nextstate = 0;
}

ordersquadmoveto(point, squadid) {
  if(!isDefined(point))
    point = maps\_so_rts_support::playerlinkobj_gettargetgroundpos();

  if(isDefined(squadid)) {
    if(isDefined(level.rts.squads[squadid].no_move_commands) && level.rts.squads[squadid].no_move_commands) {
      return;
    }
    level.rts.squads[squadid].nextstate = 2;
    level.rts.squads[squadid].centerpoint = point + vectorscale((0, 0, 1), 12.0);
    movesquadmarker(squadid, 0, point);
  } else {
    squads = getsquadlistfromselected();

    for(i = 0; i < squads.size; i++) {
      if(isDefined(squads[i].no_move_commands) && squads[i].no_move_commands) {
        continue;
      }
      squadid = squads[i].id;
      level.rts.squads[squadid].nextstate = 2;
      level.rts.squads[squadid].centerpoint = point + vectorscale((0, 0, 1), 12.0);
      movesquadmarker(squadid, 0, point);
    }
  }
}

ordersquaddefend(point, squadid, hidemarker) {
  if(!isDefined(hidemarker))
    hidemarker = 0;

  if(!isDefined(point)) {
    assert(flag("rts_mode"));
    point = maps\_so_rts_support::playerlinkobj_gettargetgroundpos();
  }

  if(flag("fps_mode"))
    maps\_so_rts_event::trigger_event("squad_move_fps");
  else
    maps\_so_rts_event::trigger_event("squad_move_cmd");

  if(isDefined(squadid)) {
    level.rts.squads[squadid].state = 1;
    level.rts.squads[squadid].nextstate = 2;
    level.rts.squads[squadid].centerpoint = point + vectorscale((0, 0, 1), 12.0);
    level.rts.squads[squadid].foltarget = undefined;
    movesquadmarker(squadid, hidemarker);
  } else {
    squads = getsquadlistfromselected();

    for(i = 0; i < squads.size; i++) {
      squadid = squads[i].id;
      level.rts.squads[squadid].state = 1;
      level.rts.squads[squadid].nextstate = 2;
      level.rts.squads[squadid].centerpoint = point + vectorscale((0, 0, 1), 12.0);
      level.rts.squads[squadid].foltarget = undefined;
      movesquadmarker(squadid, hidemarker);
    }
  }
}

patrolpoint(point) {
  self endon("new_squad_orders");
  self endon("death");
  self endon("taken_control_over");
  self notify("patrolPoint");
  self endon("patrolPoint");
  nodes = getnodesinradius(point, 1024, 0, 700, "Cover");

  if(nodes.size > 8) {
    while(true) {
      if(!isDefined(self.poi)) {
        if(!(isDefined(self.enemy) && self cansee(self.enemy))) {
          pnode = nodes[randomint(nodes.size)];

          if(isnodeoccupied(pnode)) {
            wait 0.05;
            continue;
          }

          self squaddebug("patrolPoint", pnode.origin);

          self setgoalnode(pnode);
          self setgoalpos(pnode.origin);
          self waittill("goal");
        }
      }

      wait(randomintrange(20, 40));
    }
  }
}

patrol() {
  if(!(isDefined(self.classname) && self.classname == "script_vehicle"))
    self thread patrolpoint(level.rts.squads[self.squadid].centerpoint);
  else
    self thread maps\_vehicle::defend(level.rts.squads[self.squadid].centerpoint, 512);
}

squadpatrol(squadid) {
  if(hassquadmakeupchanged(squadid)) {
    foreach(guy in level.rts.squads[squadid].members) {
      if(!(isDefined(guy.initialized) && guy.initialized)) {
        continue;
      }
      guy thread patrol();
    }
  }
}

executeordersquadpatrol(squadid) {
  notifysquadmembersofneworders(squadid);

  if(level.rts.squads[squadid].state != level.rts.squads[squadid].nextstate) {
    level.rts.squads[squadid].laststate = level.rts.squads[squadid].state;
    level.rts.squads[squadid].state = level.rts.squads[squadid].nextstate;
  }

  level.rts.squads[squadid].think = ::squadpatrol;
  level.rts.squads[squadid].nextstate = 0;
}

ordersquadpatrol(point, squadid) {
  if(!isDefined(point))
    point = maps\_so_rts_support::playerlinkobj_gettargetgroundpos();

  if(isDefined(squadid)) {
    level.rts.squads[squadid].state = 3;
    level.rts.squads[squadid].nextstate = 2;
    level.rts.squads[squadid].centerpoint = point + vectorscale((0, 0, 1), 12.0);
    movesquadmarker(squadid);
  } else {
    squads = getsquadlistfromselected();

    for(i = 0; i < squads.size; i++) {
      squadid = squads[i].id;
      level.rts.squads[squadid].state = 3;
      level.rts.squads[squadid].nextstate = 2;
      level.rts.squads[squadid].centerpoint = point + vectorscale((0, 0, 1), 12.0);
      movesquadmarker(squadid);
    }
  }
}

attackorderwatcher(target) {
  self endon("death");
  self endon("taken_control_over");
  self notify("targetOrderWatcher");
  self endon("targetOrderWatcher");
  self waittill("new_squad_orders");

  if(!(isDefined(self.classname) && self.classname == "script_vehicle"))
    self clearentitytarget();
  else if(issentient(self))
    self vehclearentitytarget();
}

targetwatcher(target) {
  self endon("new_squad_orders");
  self endon("death");
  self endon("taken_control_over");
  self notify("targetWatcher");
  self endon("targetWatcher");
  target waittill("death");

  if(!(isDefined(self.classname) && self.classname == "script_vehicle"))
    self clearentitytarget();
  else if(issentient(self))
    self vehclearentitytarget();
}

attack() {
  self endon("death");

  if(isDefined(self.squadid) && isDefined(level.rts.squads[self.squadid].target) && is_alive(level.rts.squads[self.squadid].target)) {
    self thread gotopoint(level.rts.squads[self.squadid].target.origin);

    if(isDefined(level.rts.squads[self.squadid].target) && is_alive(level.rts.squads[self.squadid].target)) {
      self thread targetwatcher(level.rts.squads[self.squadid].target);
      self thread attackorderwatcher();

      if(!(isDefined(self.classname) && self.classname == "script_vehicle")) {
        self thread maps\_so_rts_support::perfect_aim_fortimeoruntilnotify("shoot", 5);
        self setentitytarget(level.rts.squads[self.squadid].target);
      } else if(issentient(self))
        self vehsetentitytarget(level.rts.squads[self.squadid].target);
    }
  }
}

targetlastknownlocation(target, squadid) {
  target endon("death");
  level notify("targetLastKnownLocation" + squadid);
  level endon("targetLastKnownLocation" + squadid);
  level endon("new_squad_orders" + squadid);

  while(isDefined(target)) {
    level.rts.squads[squadid].lastknowntargetloc = target.origin;
    wait 0.5;
  }
}

squadattacktarget(squadid) {
  level endon("new_squad_orders" + squadid);
  target = level.rts.squads[squadid].target;
  level thread targetlastknownlocation(target, squadid);

  if(hassquadmakeupchanged(squadid)) {
    level notify("squadAttackTarget" + squadid);
    level endon("squadAttackTarget" + squadid);

    foreach(guy in level.rts.squads[squadid].members) {
      if(!(isDefined(guy.initialized) && guy.initialized)) {
        continue;
      }
      guy thread attack();
    }

    target waittill("death");

    if(isDefined(level.rts.squads[squadid].foltarget))
      level thread ordersquadfollowai(squadid, level.rts.squads[squadid].foltarget, 0);
    else if(isDefined(level.rts.squads[squadid].lastknowntargetloc))
      level thread ordersquaddefend(level.rts.squads[squadid].lastknowntargetloc, squadid);
  }
}

executeordersquadattack(squadid) {
  notifysquadmembersofneworders(squadid);

  if(!isDefined(level.rts.squads[squadid].target)) {
    level.rts.squads[squadid].state = 1;
    level.rts.squads[squadid].nextstate = 2;
    return;
  }

  if(level.rts.squads[squadid].state != level.rts.squads[squadid].nextstate) {
    level.rts.squads[squadid].laststate = level.rts.squads[squadid].state;
    level.rts.squads[squadid].state = level.rts.squads[squadid].nextstate;
  }

  level.rts.squads[squadid].think = ::squadattacktarget;
  level.rts.squads[squadid].nextstate = 0;
}

ordersquadattack(squadid, ent, allsquads, height) {
  if(!isDefined(height))
    height = 50;

  if(!isDefined(ent)) {
    level.rts.squads[squadid].nextstate = 1;
    return;
  }

  level notify("squad_attack", ent);

  if(flag("fps_mode"))
    maps\_so_rts_event::trigger_event("squad_attack_fps");
  else
    maps\_so_rts_event::trigger_event("squad_attack_cmd");

  if(!(isDefined(allsquads) && allsquads)) {
    if(isDefined(squadid)) {
      level.rts.squads[squadid].nextstate = 4;

      if(isDefined(level.rts.squads[squadid].target) && level.rts.squads[squadid].target != ent)
        luinotifyevent(&"rts_squad_stop_attack", 2, squadid, level.rts.squads[squadid].target getentitynumber());

      level.rts.squads[squadid].target = ent;
      luinotifyevent(&"rts_squad_start_attack", 3, squadid, ent getentitynumber(), height);

      if(isDefined(ent.pkg_ref)) {
        if(flag("fps_mode"))
          maps\_so_rts_event::trigger_event("targetfps_" + ent.pkg_ref.ref);
        else
          maps\_so_rts_event::trigger_event("target_" + ent.pkg_ref.ref);
      }
    }
  } else {
    squads = getteamsquads(level.rts.player.team);

    for(i = 0; i < squads.size; i++) {
      if(!(isDefined(squads[i].selectable) && squads[i].selectable)) {
        continue;
      }
      squadid = squads[i].id;
      level.rts.squads[squadid].nextstate = 4;

      if(isDefined(level.rts.squads[squadid].target) && level.rts.squads[squadid].target != ent)
        luinotifyevent(&"rts_squad_stop_attack", 2, squadid, level.rts.squads[squadid].target getentitynumber());

      level.rts.squads[squadid].target = ent;
      luinotifyevent(&"rts_squad_start_attack", 3, squadid, ent getentitynumber(), height);
    }
  }
}

reissuesquadlastorders(squadid) {
  switch (level.rts.squads[squadid].state) {
    case 4:
      level.rts.squads[squadid].nextstate = 4;
      break;
    case 1:
      level.rts.squads[squadid].nextstate = 2;
      break;
    case 3:
      level.rts.squads[squadid].nextstate = 2;
      break;
    case 5:
      level.rts.squads[squadid].nextstate = 5;
      break;
    case 6:
      level.rts.squads[squadid].nextstate = 6;
      break;
  }
}

movewithai(target) {
  self endon("new_squad_orders");
  self endon("death");
  self endon("taken_control_over");
  self notify("moveWithAI");
  self endon("moveWithAI");

  while(true) {
    if(isDefined(self.rts_unloaded) && self.rts_unloaded && isDefined(target)) {
      if(isDefined(self.classname) && self.classname == "script_vehicle")
        self thread vehgoalentity(target);
      else
        self thread aigoalentity(target);

      return;
    }

    wait 0.2;
  }
}

squadmovewithai(squadid) {
  if(hassquadmakeupchanged(squadid)) {
    foreach(guy in level.rts.squads[squadid].members) {
      if(!(isDefined(guy.initialized) && guy.initialized)) {
        continue;
      }
      if(level.rts.squads[squadid].target == guy) {
        continue;
      }
      guy thread movewithai(level.rts.squads[squadid].target);
    }
  }
}

executeordermovewithai(squadid) {
  notifysquadmembersofneworders(squadid);

  if(level.rts.squads[squadid].state != level.rts.squads[squadid].nextstate) {
    level.rts.squads[squadid].laststate = level.rts.squads[squadid].state;
    level.rts.squads[squadid].state = level.rts.squads[squadid].nextstate;
  }

  level.rts.squads[squadid].think = ::squadmovewithai;
  level.rts.squads[squadid].nextstate = 0;
}

ordersquadfollowai(squadid, ent, allsquads, showmarker, height) {
  if(!isDefined(showmarker))
    showmarker = 1;

  if(!isDefined(height))
    height = 60;

  if(!isDefined(ent)) {
    level.rts.squads[squadid].nextstate = 1;
    return;
  }

  if(flag("fps_mode"))
    maps\_so_rts_event::trigger_event("squad_move_fps");
  else
    maps\_so_rts_event::trigger_event("squad_move_cmd");

  if(!(isDefined(allsquads) && allsquads)) {
    if(isDefined(squadid)) {
      level.rts.squads[squadid].nextstate = 6;

      if(isDefined(level.rts.squads[squadid].target) && level.rts.squads[squadid].target != ent) {
        luinotifyevent(&"rts_squad_stop_attack", 2, squadid, level.rts.squads[squadid].target getentitynumber());

        if(isDefined(level.rts.squads[squadid].foltarget) && ent == level.rts.squads[squadid].foltarget)
          wait 0.1;
      }

      level.rts.squads[squadid].foltarget = ent;
      level.rts.squads[squadid].target = ent;

      if(isDefined(showmarker) && showmarker)
        luinotifyevent(&"rts_squad_start_attack", 3, squadid, ent getentitynumber(), height);

      if(isDefined(ent.pkg_ref)) {
        if(flag("fps_mode"))
          maps\_so_rts_event::trigger_event("followfps_" + ent.pkg_ref.ref);
        else
          maps\_so_rts_event::trigger_event("follow_" + ent.pkg_ref.ref);
      }
    }
  } else {
    squads = getteamsquads(level.rts.player.team);

    for(i = 0; i < squads.size; i++) {
      if(!(isDefined(squads[i].selectable) && squads[i].selectable)) {
        continue;
      }
      squadid = squads[i].id;
      level.rts.squads[squadid].nextstate = 6;

      if(isDefined(level.rts.squads[squadid].target) && level.rts.squads[squadid].target != ent)
        luinotifyevent(&"rts_squad_stop_attack", 2, squadid, level.rts.squads[squadid].target getentitynumber());

      level.rts.squads[squadid].target = ent;
      level.rts.squads[squadid].foltarget = ent;
      luinotifyevent(&"rts_squad_start_attack", 3, squadid, ent getentitynumber(), height);
    }
  }
}

vehgoalentity(entity) {
  self notify("vehGoalEntity");
  self endon("vehGoalEntity");
  self endon("new_squad_orders");
  self endon("death");
  self endon("taken_control_over");

  while(isDefined(entity)) {
    if(entity == level.rts.player) {
      if(!isDefined(level.rts.player.ally)) {
        break;
      }
    }

    self maps\_vehicle::defend(entity.origin);
    wait 2;
  }
}

aigoalentity(entity) {
  self notify("aiGoalEntity");
  self endon("aiGoalEntity");
  self endon("new_squad_orders");
  self endon("death");
  self endon("taken_control_over");

  while(isDefined(entity)) {
    if(entity == level.rts.player) {
      if(!isDefined(level.rts.player.ally)) {
        break;
      }
    }

    if(isDefined(self.enemy))
      self squaddebug("goalentity", self.enemy.origin, (1, 0, 0));

    goalradiussquared = self.goalradius * 1.0 * (self.goalradius * 1.0);
    outsidegoalradius = distancesquared(self.origin, entity.origin) > goalradiussquared;
    findnewnode = 1;

    if(isDefined(self.node) && distancesquared(entity.origin, self.node.origin) < self.goalradius * self.goalradius)
      findnewnode = 0;
    else if(isDefined(self.fixednode) && self.fixednode)
      findnewnode = 0;
    else if(self getpathlength() > 0)
      findnewnode = 0;

    if(findnewnode) {
      if(outsidegoalradius) {
        self squaddebug("aiGoalEntity", entity.origin);

        self setgoalpos(entity.origin);
      }
    }

    wait(randomfloatrange(2.5, 3.5));
  }
}

movewithplayer() {
  self endon("new_squad_orders");
  self endon("death");
  self endon("taken_control_over");
  self notify("moveWithPlayer");
  self endon("moveWithPlayer");

  while(true) {
    if(isDefined(self.rts_unloaded) && self.rts_unloaded) {
      if(flag("rts_mode")) {
        if(self.ai_ref.species == "vehicle")
          self maps\_vehicle::defend(level.rts.lastfpspoint);
        else if(isDefined(level.rts.lastfpspoint)) {
          self squaddebug("moveWithPlayer", level.rts.lastfpspoint);

          self setgoalpos(level.rts.lastfpspoint);
        }
      } else if(isDefined(level.rts.player.ally)) {
        if(isDefined(self.classname) && self.classname == "script_vehicle")
          self thread vehgoalentity(level.rts.player);
        else
          self thread aigoalentity(level.rts.player);

        return;
      }
    }

    wait 0.2;
  }
}

squadmovewithplayer(squadid) {
  if(hassquadmakeupchanged(squadid)) {
    foreach(guy in level.rts.squads[squadid].members) {
      if(!(isDefined(guy.initialized) && guy.initialized)) {
        continue;
      }
      guy thread movewithplayer();
    }
  }
}

executeordermovewithplayer(squadid) {
  notifysquadmembersofneworders(squadid);

  if(level.rts.squads[squadid].state != level.rts.squads[squadid].nextstate) {
    level.rts.squads[squadid].laststate = level.rts.squads[squadid].state;
    level.rts.squads[squadid].state = level.rts.squads[squadid].nextstate;
  }

  level.rts.squads[squadid].think = ::squadmovewithplayer;
  level.rts.squads[squadid].nextstate = 0;
}

squaddonothing(squadid) {
}

ordersquadmanaged(squadid) {
  if(isDefined(squadid))
    level.rts.squads[squadid].nextstate = 7;
}

executesquadmanaged(squadid) {
  notifysquadmembersofneworders(squadid);

  if(level.rts.squads[squadid].state != level.rts.squads[squadid].nextstate) {
    level.rts.squads[squadid].laststate = level.rts.squads[squadid].state;
    level.rts.squads[squadid].state = level.rts.squads[squadid].nextstate;
  }

  level.rts.squads[squadid].think = ::squaddonothing;
  level.rts.squads[squadid].nextstate = 0;
}

ordersquadfollowplayer(squadid, allsquads) {
  if(isDefined(level.rts.player.ally)) {
    if(!isDefined(squadid))
      squadid = level.rts.player.ally.squadid;

    if(allsquads) {
      foreach(squad in level.rts.squads) {
        if(squad.team != level.rts.player.team) {
          continue;
        }
        squad.nextstate = 5;
        movesquadmarker(squad.id, 1);
      }
    } else {
      maps\_so_rts_event::trigger_event("squad_rally");
      maps\_so_rts_event::trigger_event("dlg_follow_" + level.rts.squads[squadid].pkg_ref.ref);
      level.rts.squads[squadid].nextstate = 5;
      movesquadmarker(squadid, 1);
    }

    return;
  }
}

squadthink() {
  level endon("rts_terminated");

  while(true) {
    foreach(squad in level.rts.squads) {
      removedeadfromsquad(squad.id);

      if(squad.members.size == 0) {
        continue;
      }
      if(squad.team == level.rts.player.team && !(isDefined(squad.selectable) && squad.selectable)) {
        continue;
      }
      if(squad.nextstate != 0 && squad.nextstate != squad.state)
        squad.lastsquadchecksum = -1;

      if(isDefined(squad.squad_execute_cb)) {
        if([
            [squad.squad_execute_cb]
          ](squad.id) == 0) {
          squad.nextstate = 0;
          continue;
        }
      }

      switch (squad.nextstate) {
        case 0:
          break;
        case 1:
        case 2:

          println("$$$$$$ SQUAD (" + squad.id + ") SQUAD_STATE_MOVE");

          executesquadmoveto(squad.id);
          break;
        case 3:

          println("$$$$$$ SQUAD (" + squad.id + ") SQUAD_STATE_PATROL");

          executeordersquadpatrol(squad.id);
          break;
        case 4:

          println("$$$$$$ SQUAD (" + squad.id + ") SQUAD_STATE_ATTACK");

          executeordersquadattack(squad.id);
          break;
        case 5:

          println("$$$$$$ SQUAD (" + squad.id + ") SQUAD_STATE_MOVEWITHPLAYER");

          executeordermovewithplayer(squad.id);
          break;
        case 6:

          println("$$$$$$ SQUAD (" + squad.id + ") SQUAD_STATE_MOVEWITHAI");

          executeordermovewithai(squad.id);
          break;
        case 7:

          println("$$$$$$ SQUAD (" + squad.id + ") SQUAD_STATE_MANAGED");

          executesquadmanaged(squad.id);
          break;
        default:
          assert(0, "squad in unknown think state");
          break;
      }

      assert(isDefined(squad.think), "squad in unknown think state");
      level thread[[squad.think]](squad.id);
    }

    wait 0.5;
  }
}

getsquadsbytype(type, team, onlywithmembers) {
  if(!isDefined(onlywithmembers))
    onlywithmembers = 0;

  squads = [];

  foreach(squad in level.rts.squads) {
    if(squad.team == team) {
      if(isDefined(squad.no_nag) && squad.no_nag) {
        continue;
      }
      if(isDefined(type) && squad.pkg_ref.squad_type != type) {
        continue;
      }
      if(isDefined(onlywithmembers) && onlywithmembers) {
        if(!isDefined(squad.members) || squad.members.size == 0)
          continue;
      }

      maps\_so_rts_squad::removedeadfromsquad(squad.id);
      squads[squads.size] = squad;
    }
  }

  return squads;
}

getsquadbypkg(ref, team) {
  foreach(squad in level.rts.squads) {
    if(squad.team == team && squad.pkg_ref.ref == ref) {
      maps\_so_rts_squad::removedeadfromsquad(squad.id);
      return squad;
    }
  }

  return undefined;
}

getactivesquads(team) {
  activesquads = [];

  foreach(squad in level.rts.squads) {
    if(squad.team == team && squad.members.size > 0 || isDefined(level.rts.player.ally) && level.rts.player.ally.squadid == squad.id) {
      maps\_so_rts_squad::removedeadfromsquad(squad.id);
      activesquads[activesquads.size] = squad;
    }
  }

  return activesquads;
}

getinactivesquads(team) {
  activesquads = [];

  foreach(squad in level.rts.squads) {
    if(squad.team == team && squad.members.size == 0)
      activesquads[activesquads.size] = squad;
  }

  return activesquads;
}

getsquad(squadid) {
  if(isDefined(level.rts.squads[squadid]))
    return level.rts.squads[squadid];

  return undefined;
}

getsquadcenter(squad) {
  assert(isDefined(squad));
  squadcenter = (0, 0, 0);
  squadcount = 0;

  foreach(guy in squad.members) {
    if(isalive(guy)) {
      squadcenter = squadcenter + guy.origin;
      squadcount++;
    }
  }

  if(squadcount > 0)
    squadcenter = vectorscale(squadcenter, 1 / squadcount);

  return squadcenter;
}

squaddebug(text, origin, color) {
  if(getdvarint(#"_id_498EBD49")) {
    if(!isDefined(color))
      color = (0, 1, 0);

    recordenttext(text, self, color, "Script");

    if(isDefined(origin))
      recordline(self.origin, origin, color, "Script");
  }

}