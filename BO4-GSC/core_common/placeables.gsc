/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\placeables.gsc
***********************************************/

#include scripts\core_common\laststand_shared;
#include scripts\core_common\oob;
#include scripts\core_common\scene_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\weapons\deployable;

#namespace placeables;

spawnplaceable(onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, ondamagecallback, var_d0dd7e76, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately = 0, var_c71994b5 = undefined) {
  player = self;
  placeable = spawn("script_model", player.origin);
  placeable.cancelable = 1;
  placeable.held = 0;
  placeable.validmodel = validmodel;
  placeable.invalidmodel = invalidmodel;
  placeable.oncancel = oncancelcallback;
  placeable.onemp = onempcallback;
  placeable.onmove = onmovecallback;
  placeable.onplace = onplacecallback;
  placeable.onshutdown = onshutdowncallback;
  placeable.ondeath = ondeathcallback;
  placeable.ondamagecallback = ondamagecallback;
  placeable.var_d0dd7e76 = var_d0dd7e76;
  placeable.owner = player;
  placeable.originalowner = player;
  placeable.ownerentnum = player.entnum;
  placeable.originalownerentnum = player.entnum;
  placeable.pickupstring = pickupstring;
  placeable.placedmodel = model;
  placeable.spawnsvehicle = spawnsvehicle;
  placeable.originalteam = player.team;
  placeable.team = player.team;
  placeable.timedout = 0;
  placeable.timeout = timeout;
  placeable.timeoutstarted = 0;
  placeable.angles = (0, player.angles[1], 0);
  placeable.placehintstring = placehintstring;
  placeable.invalidlocationhintstring = invalidlocationhintstring;
  placeable.placeimmediately = placeimmediately;

  if(!isDefined(placeable.placehintstring)) {
    placeable.placehintstring = "";
  }

  if(!isDefined(placeable.invalidlocationhintstring)) {
    placeable.invalidlocationhintstring = "";
  }

  placeable notsolid();

  if(isDefined(placeable.vehicle)) {
    placeable.vehicle notsolid();
  }

  placeable.othermodel = spawn("script_model", player.origin);
  placeable.othermodel setModel(placeable.placedmodel);
  placeable.othermodel setinvisibletoplayer(player);
  placeable.othermodel notsolid();

  if(isDefined(health) && health > 0 && isDefined(var_c71994b5)) {
    placeable.health = health;
    placeable setCanDamage(0);
    placeable thread[[var_c71994b5]](ondamagecallback, &ondeath, empdamage, &onemp);
  }

  player thread carryplaceable(placeable);
  level thread cancelongameend(placeable);
  player thread shutdownoncancelevent(placeable);
  player thread cancelonplayerdisconnect(placeable);
  placeable thread watchownergameevents();
  return placeable;
}

function_e4fd9a4c(placeable) {
  player = self;

  if(isDefined(placeable)) {
    if(isDefined(placeable.weapon)) {
      if(placeable.weapon.deployable) {
        deployable::register_deployable(placeable.weapon, placeable.var_8f4513d1, undefined, placeable.placehintstring, placeable.invalidlocationhintstring);

        if(isplayer(player)) {
          player giveweapon(placeable.weapon);
          player givestartammo(placeable.weapon);
          player switchtoweapon(placeable.weapon);
        }
      }
    }
  }
}

function_df4e6283(placeable) {
  player = self;

  if(isDefined(placeable)) {
    if(isDefined(placeable.weapon)) {
      if(placeable.weapon.deployable) {
        if(isplayer(player)) {
          player takeweapon(placeable.weapon);
        }
      }
    }
  }
}

function_f872b831(onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, ondamagecallback, var_d0dd7e76, var_c6d99e09, weapon, pickupstring, placehintstring, invalidlocationhintstring, timeout) {
  player = self;
  placeable = spawn("script_model", player.origin);
  placeable.cancelable = 1;
  placeable.held = 0;
  placeable.oncancel = oncancelcallback;
  placeable.onemp = onempcallback;
  placeable.onmove = onmovecallback;
  placeable.onplace = onplacecallback;
  placeable.onshutdown = onshutdowncallback;
  placeable.ondeath = ondeathcallback;
  placeable.ondamagecallback = ondamagecallback;
  placeable.var_d0dd7e76 = var_d0dd7e76;
  placeable.owner = player;
  placeable.originalowner = player;
  placeable.ownerentnum = player.entnum;
  placeable.originalownerentnum = player.entnum;
  placeable.pickupstring = pickupstring;
  placeable.placehintstring = placehintstring;
  placeable.invalidlocationhintstring = invalidlocationhintstring;
  placeable.originalteam = player.team;
  placeable.team = player.team;
  placeable.timedout = 0;
  placeable.timeout = timeout;
  placeable.timeoutstarted = 0;
  placeable.angles = (0, player.angles[1], 0);
  placeable.placeimmediately = 0;
  placeable.weapon = weapon;
  placeable.var_8f4513d1 = var_c6d99e09;

  if(!isDefined(placeable.placehintstring)) {
    placeable.placehintstring = "";
  }

  if(!isDefined(placeable.invalidlocationhintstring)) {
    placeable.invalidlocationhintstring = "";
  }

  player function_e4fd9a4c(placeable);
  player thread function_b7fcffdd(placeable);
  player thread shutdownoncancelevent(placeable);
  player thread cancelonplayerdisconnect(placeable);
  placeable thread watchownergameevents();
  return placeable;
}

function_b7fcffdd(placeable) {
  player = self;
  player endon(#"disconnect", #"death");
  placeable endon(#"placed", #"cancelled");
  player notify(#"placeable_deployable");
  player endon(#"placeable_deployable");
  placeable notsolid();

  if(isDefined(placeable.vehicle)) {
    placeable.vehicle notsolid();
  }

  player thread watchcarrycancelevents(placeable);
  player thread function_e222876f(placeable);

  while(player getcurrentweapon() != placeable.weapon) {
    waitframe(1);
  }

  while(true) {
    waitresult = player waittill(#"weapon_fired", #"weapon_switch_started");

    if(waitresult.weapon != placeable.weapon) {
      placeable notify(#"cancelled");
      return;
    }

    if(isDefined(level.var_69959686)) {
      [
        [level.var_69959686]
      ](placeable.weapon);
    }

    if(isDefined(self.var_7a3f3edf) && self.var_7a3f3edf && isDefined(self.var_b8878ba9) && isDefined(self.var_b8878ba9)) {
      placeable.held = 0;
      player.holding_placeable = undefined;
      placeable.cancelable = 0;
      placeable.origin = self.var_b8878ba9;
      placeable.angles = self.var_ddc03e10;
      player onplace(placeable);
      return;
    }
  }
}

updateplacementmodels(model, validmodel, invalidmodel) {
  placeable = self;
  placeable.placedmodel = model;
  placeable.validmodel = validmodel;
  placeable.invalidmodel = invalidmodel;
}

carryplaceable(placeable) {
  player = self;
  placeable show();
  placeable notsolid();

  if(isDefined(placeable.vehicle)) {
    placeable.vehicle notsolid();
  }

  if(isDefined(placeable.othermodel)) {
    placeable thread util::ghost_wait_show_to_player(player, 0.05, "abort_ghost_wait_show");
    placeable.othermodel thread util::ghost_wait_show_to_others(player, 0.05, "abort_ghost_wait_show");
    placeable.othermodel notsolid();
  }

  placeable.held = 1;
  player.holding_placeable = placeable;
  player carryturret(placeable, (40, 0, 0), (0, 0, 0));
  player val::set(#"placeable", "disable_weapons");
  player thread watchplacement(placeable);
}

innoplacementtrigger() {
  placeable = self;

  if(isDefined(level.noturretplacementtriggers)) {
    for(i = 0; i < level.noturretplacementtriggers.size; i++) {
      if(placeable istouching(level.noturretplacementtriggers[i])) {
        return true;
      }
    }
  }

  if(isDefined(level.fatal_triggers)) {
    for(i = 0; i < level.fatal_triggers.size; i++) {
      if(placeable istouching(level.fatal_triggers[i])) {
        return true;
      }
    }
  }

  if(placeable oob::istouchinganyoobtrigger()) {
    return true;
  }

  return false;
}

waitforplaceabletobebuilt(player) {
  placeable = self;
  buildlength = int(placeable.buildtime * 1000);

  if(isDefined(placeable.buildstartedfunc)) {
    if(![
        [placeable.buildstartedfunc]
      ](placeable, player)) {
      return 0;
    }
  }

  starttime = gettime();
  endtime = starttime + buildlength;
  finishedbuilding = 1;

  while(gettime() < endtime) {
    if(!player attackbuttonpressed()) {
      finishedbuilding = 0;
      break;
    }

    if(isDefined(placeable.buildprogressfunc)) {
      [
        [placeable.buildprogressfunc]
      ](placeable, player, (gettime() - starttime) / buildlength);
    }

    waitframe(1);
  }

  finished = player attackbuttonpressed();

  if(isDefined(placeable.buildfinishedfunc)) {
    [[placeable.buildfinishedfunc]](placeable, player, finishedbuilding);
  }

  return finishedbuilding;
}

function_238e6d1e(callbackfunc) {
  placeable = self;
  placeable.var_d944a140 = callbackfunc;
}

function_e679057e() {
  self.var_d4083518 = 1;
}

watchplacement(placeable) {
  player = self;
  player endon(#"disconnect", #"death");
  placeable endon(#"placed", #"cancelled");
  player thread watchcarrycancelevents(placeable);
  player thread function_e222876f(placeable);
  lastattempt = -1;
  placeable.canbeplaced = 0;
  waitingforattackbuttonrelease = 1;

  while(true) {
    placement = player canplayerplaceturret();
    placeable.origin = placement[#"origin"];
    placeable.angles = placement[#"angles"];
    placeable.canbeplaced = placement[#"result"] && !placeable innoplacementtrigger();
    laststand = player laststand::player_is_in_laststand();
    in_igc = player scene::is_igc_active();

    if(laststand || in_igc) {
      placeable.canbeplaced = 0;
    }

    if(isDefined(placeable.othermodel)) {
      placeable.othermodel.origin = placement[#"origin"];
      placeable.othermodel.angles = placement[#"angles"];
    }

    if(placeable.canbeplaced != lastattempt) {
      if(placeable.canbeplaced) {
        placeable setModel(placeable.validmodel);
        player sethintstring(placeable.placehintstring);
      } else {
        placeable setModel(placeable.invalidmodel);
        player sethintstring(placeable.invalidlocationhintstring);
      }

      lastattempt = placeable.canbeplaced;
    }

    while(waitingforattackbuttonrelease && !player attackbuttonpressed()) {
      waitingforattackbuttonrelease = 0;
    }

    if(!waitingforattackbuttonrelease && placeable.canbeplaced && player attackbuttonpressed() || placeable.placeimmediately) {
      buildallowed = 1;

      if(isDefined(placeable.buildtime) && placeable.buildtime > 0) {
        player sethintstring(placeable.buildinghintstring);
        finishedbuilding = placeable waitforplaceabletobebuilt(player);

        if(!finishedbuilding) {
          buildallowed = 0;
          player sethintstring(placeable.placehintstring);
        }
      }

      if(placement[#"result"] && buildallowed && isDefined(placeable.var_d944a140)) {
        buildallowed = placeable[[placeable.var_d944a140]](placement[#"origin"], player);
      }

      if(placement[#"result"] && buildallowed) {
        placeable.origin = placement[#"origin"];
        placeable.angles = placement[#"angles"];
        player sethintstring("");
        player stopcarryturret(placeable);
        player val::reset(#"placeable", "disable_weapons");
        placeable.held = 0;
        player.holding_placeable = undefined;
        placeable.cancelable = 0;

        if(isDefined(placeable.health) && placeable.health) {
          placeable setCanDamage(1);
          placeable solid();
        }

        if(isDefined(placeable.placedmodel) && !placeable.spawnsvehicle) {
          placeable setModel(placeable.placedmodel);
        } else {
          placeable notify(#"abort_ghost_wait_show");
          placeable.abort_ghost_wait_show_to_player = 1;
          placeable.abort_ghost_wait_show_to_others = 1;
          placeable ghost();

          if(isDefined(placeable.othermodel)) {
            placeable.othermodel notify(#"abort_ghost_wait_show");
            placeable.othermodel.abort_ghost_wait_show_to_player = 1;
            placeable.othermodel.abort_ghost_wait_show_to_others = 1;
            placeable.othermodel ghost();
          }
        }

        if(isDefined(placeable.timeout)) {
          if(!placeable.timeoutstarted) {
            placeable.timeoutstarted = 1;

            if(isDefined(placeable.var_d0dd7e76)) {
              placeable thread[[placeable.var_d0dd7e76]](placeable.timeout, &ontimeout, "death", "cancelled");
            }
          } else if(placeable.timedout) {
            placeable thread[[placeable.var_d0dd7e76]](5000, &ontimeout, "cancelled");
          }
        }

        player onplace(placeable);
      }
    }

    waitframe(1);
  }
}

function_613a226a(allow_alt) {
  self.var_e3be448 = allow_alt;
}

watchcarrycancelevents(placeable) {
  player = self;
  assert(isplayer(player));
  placeable endon(#"cancelled", #"placed");
  player waittill(#"death", #"emp_jammed", #"emp_grenaded", #"disconnect", #"joined_team");
  placeable notify(#"cancelled");
}

function_e222876f(placeable) {
  player = self;
  assert(isplayer(player));
  player endon(#"disconnect", #"death");
  placeable endon(#"placed", #"cancelled");

  while(true) {
    if((isDefined(placeable.var_e3be448) ? placeable.var_e3be448 : 0) && player changeseatbuttonpressed()) {
      placeable notify(#"cancelled");
    } else if(!(isDefined(placeable.var_e3be448) ? placeable.var_e3be448 : 0) && placeable.cancelable && player actionslotfourbuttonpressed()) {
      placeable notify(#"cancelled");
    } else if(isDefined(placeable.var_25404db4) && placeable.var_25404db4 && player laststand::player_is_in_laststand()) {
      placeable notify(#"cancelled");
    } else if(player scene::is_igc_active()) {
      placeable notify(#"cancelled");
    } else if(player isinvehicle()) {
      placeable notify(#"cancelled");
    }

    waitframe(1);
  }
}

ontimeout() {
  placeable = self;

  if(isDefined(placeable.held) && placeable.held) {
    placeable.timedout = 1;
    return;
  }

  placeable notify(#"delete_placeable_trigger");
  placeable thread[[placeable.var_d0dd7e76]](5000, &forceshutdown, "cancelled");
}

onplace(placeable) {
  player = self;

  if(isDefined(placeable.vehicle)) {
    placeable.vehicle setCanDamage(1);
    placeable.vehicle solid();
  }

  player function_df4e6283(placeable);

  if(isDefined(placeable.onplace)) {
    player[[placeable.onplace]](placeable);

    if(isDefined(placeable.onmove) && !placeable.timedout) {
      spawnmovetrigger(placeable, player);
    }
  }

  placeable notify(#"placed");
}

onmove(placeable) {
  player = self;
  player function_e4fd9a4c(placeable);
  assert(isDefined(placeable.onmove));

  if(isDefined(placeable.onmove)) {
    player[[placeable.onmove]](placeable);
  }

  if(isDefined(placeable.weapon) && placeable.weapon.deployable) {
    player thread function_b7fcffdd(placeable);
    return;
  }

  player thread carryplaceable(placeable);
}

oncancel(placeable) {
  player = self;
  player function_df4e6283(placeable);

  if(isDefined(placeable.oncancel)) {
    player[[placeable.oncancel]](placeable);
  }
}

ondeath(attacker, weapon) {
  placeable = self;

  if(isDefined(placeable.ondeath)) {
    [[placeable.ondeath]](attacker, weapon);
  }

  placeable notify(#"cancelled");
}

onemp(attacker) {
  placeable = self;

  if(isDefined(placeable.onemp)) {
    placeable[[placeable.onemp]](attacker);
  }
}

cancelonplayerdisconnect(placeable) {
  placeable endon(#"hacked");
  player = self;
  assert(isplayer(player));
  placeable endon(#"cancelled", #"death");
  player waittill(#"disconnect", #"joined_team");
  placeable notify(#"cancelled");
}

cancelongameend(placeable) {
  placeable endon(#"cancelled", #"death");
  level waittill(#"game_ended");
  placeable notify(#"cancelled");
}

spawnmovetrigger(placeable, player) {
  pos = placeable.origin + (0, 0, 15);
  placeable.pickuptrigger = spawn("trigger_radius_use", pos);
  placeable.pickuptrigger setcursorhint("HINT_NOICON", placeable);
  placeable.pickuptrigger sethintstring(placeable.pickupstring);
  placeable.pickuptrigger setteamfortrigger(player.team);
  player clientclaimtrigger(placeable.pickuptrigger);
  placeable thread watchpickup(player);
  placeable.pickuptrigger thread watchmovetriggershutdown(placeable);
}

watchmovetriggershutdown(placeable) {
  trigger = self;
  placeable waittill(#"cancelled", #"picked_up", #"death", #"delete_placeable_trigger", #"hacker_delete_placeable_trigger");
  placeable.pickuptrigger delete();
}

watchpickup(player) {
  placeable = self;
  placeable endon(#"death", #"cancelled");
  assert(isDefined(placeable.pickuptrigger));
  trigger = placeable.pickuptrigger;

  while(true) {
    waitresult = trigger waittill(#"trigger");
    player = waitresult.activator;

    if(!isalive(player)) {
      continue;
    }

    if(player isusingoffhand()) {
      continue;
    }

    if(!player isonground()) {
      continue;
    }

    if(isDefined(placeable.vehicle) && placeable.vehicle.control_initiated === 1) {
      continue;
    }

    if(isDefined(player.carryobject) && player.carryobject.disallowplaceablepickup === 1) {
      continue;
    }

    if(isDefined(trigger.triggerteam) && player.team != trigger.triggerteam) {
      continue;
    }

    if(isDefined(trigger.claimedby) && player != trigger.claimedby) {
      continue;
    }

    if(player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() && !player attackbuttonpressed() && !(isDefined(player.isplanting) && player.isplanting) && !(isDefined(player.isdefusing) && player.isdefusing) && !player isremotecontrolling() && !isDefined(player.holding_placeable)) {
      placeable notify(#"picked_up");

      if(isDefined(placeable.weapon_instance)) {
        placeable.weapon_instance notify(#"picked_up");
      }

      placeable.held = 1;
      placeable setCanDamage(0);
      player onmove(placeable);
      return;
    }
  }
}

forceshutdown() {
  placeable = self;
  placeable.cancelable = 0;
  placeable notify(#"cancelled");
}

watchownergameevents() {
  self notify(#"watchownergameevents_singleton");
  self endon(#"watchownergameevents_singleton");
  placeable = self;
  placeable endon(#"cancelled");
  placeable.owner waittill(#"joined_team", #"disconnect", #"joined_spectators");

  if(isDefined(placeable)) {
    placeable.abandoned = 1;
    placeable forceshutdown();
  }
}

shutdownoncancelevent(placeable) {
  placeable endon(#"hacked");
  player = self;
  assert(isplayer(player));
  vehicle = placeable.vehicle;
  othermodel = placeable.othermodel;

  for(var_a94c08f3 = 1; var_a94c08f3; var_a94c08f3 = 0) {
    waitresult = placeable waittill(#"cancelled", #"death");

    if((isDefined(placeable.var_d4083518) ? placeable.var_d4083518 : 0) && waitresult._notify == "death") {
      continue;
    }
  }

  if(isDefined(placeable.weapon) && placeable.weapon.deployable) {
    if(isDefined(level.var_69959686)) {
      [
        [level.var_69959686]
      ](placeable.weapon);
    }

    if(isDefined(self.var_7a3f3edf) && self.var_7a3f3edf && isDefined(player.var_b8878ba9) && isDefined(player.var_b8878ba9)) {
      placeable.origin = player.var_b8878ba9;
      placeable.angles = player.var_ddc03e10;
    }
  }

  if(isDefined(player) && isDefined(placeable) && placeable.held === 1) {
    player sethintstring("");
    player stopcarryturret(placeable);
    player val::reset(#"placeable", "disable_weapons");
  }

  if(isDefined(placeable)) {
    if(placeable.cancelable) {
      player oncancel(placeable);
    } else if(isDefined(placeable.onshutdown)) {
      [
        [placeable.onshutdown]
      ](placeable);
    }

    if(isDefined(placeable)) {
      if(isDefined(placeable.vehicle)) {
        placeable.vehicle.selfdestruct = 1;
        placeable.vehicle._no_death_state = 1;
        placeable.vehicle kill();
        vehicle = undefined;
      }

      placeable.vehicle = undefined;

      if(isDefined(placeable.othermodel)) {
        placeable.othermodel delete();
      }

      placeable.othermodel = undefined;
      placeable delete();
    }
  }

  if(function_3132f113(placeable)) {
    if(isDefined(vehicle)) {
      vehicle.selfdestruct = 1;
      vehicle._no_death_state = 1;
      vehicle kill();
    }

    if(isDefined(othermodel)) {
      othermodel delete();
    }
  }
}

setbuildable(buildtime, buildstartfunction, buildprogressupdatedfunction, buildfinishedfunction, buildingstring) {
  placeable = self;
  placeable.buildtime = buildtime;
  placeable.buildstartedfunc = buildstartfunction;
  placeable.buildprogressfunc = buildprogressupdatedfunction;
  placeable.buildfinishedfunc = buildfinishedfunction;
  placeable.buildinghintstring = buildingstring;
}