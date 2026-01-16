/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_so_rts_poi.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_so_rts_support;
#include maps\_so_rts_event;

preload() {
  assert(isDefined(level.rts));
  assert(isDefined(level.rts_def_table));
  level.rts.poi = [];
  level.rts.poi = poi_populate();

  foreach(poi in level.rts.poi) {
    if(isDefined(poi.model) && poi.model != "")
      precachemodel(poi.model);

    if(isDefined(poi.compassicon) && poi.compassicon != "")
      precacheshader(poi.compassicon);
  }
}

lookup_value(ref, idx, column_index) {
  assert(isDefined(idx));
  return tablelookup(level.rts_def_table, 0, idx, column_index);
}

get_poi_ref_by_index(idx) {
  return tablelookup(level.rts_def_table, 0, idx, 1);
}

init() {
  level.rts.networkintruders["axis"] = [];
  level.rts.networkintruders["allies"] = [];
  level.rts.nointruderzones = getentarray("no_intruder", "targetname");
  level.rts.intruderplantstring = & "SO_RTS_PLANT_INTRUDER";
  initpois();
}

poi_populate() {
  poi_types = [];

  for(i = 200; i <= 210; i++) {
    ref = get_poi_ref_by_index(i);

    if(!isDefined(ref) || ref == "") {
      continue;
    }
    poi = spawnstruct();
    poi.idx = i;
    poi.ref = ref;
    poi.model = lookup_value(ref, i, 2);
    poi.health = int(lookup_value(ref, i, 3));
    poi.capture_time = int(lookup_value(ref, i, 4));

    if(poi.capture_time < 0) {
      poi.reverse_timer = 1;
      poi.capture_time = poi.capture_time * -1;
    }

    poi.need_device = int(lookup_value(ref, i, 5));
    poi.team = lookup_value(ref, i, 6);
    poi.objtext = lookup_value(ref, i, 7);
    poi.obj_zoff = int(lookup_value(ref, i, 8));
    poi.canbe_retaken = int(lookup_value(ref, i, 9));
    poi.compassicon = lookup_value(ref, i, 10);
    poi.target = lookup_value(ref, i, 11);
    poi.alttrig = lookup_value(ref, i, 12);
    poi.extraweight = float(lookup_value(ref, i, 13));

    if(poi.model == "")
      poi.model = undefined;

    if(poi.objtext == "")
      poi.objtext = undefined;

    if(poi.compassicon == "")
      poi.compassicon = undefined;

    if(poi.target == "")
      poi.target = undefined;

    if(poi.alttrig == "")
      poi.alttrig = undefined;

    poi_types[poi_types.size] = poi;
  }

  return poi_types;
}

checkpoint_save_restored() {
  wait 3;
  numpoiswithcapturetime = 0;

  foreach(poi in level.rts.poi) {
    if(!isDefined(poi.entity))
      poi.entity = getent(poi.ref, "targetname");

    if(isDefined(poi.entity)) {
      poinum = 0;

      if(poi.capture_time > 0 || poi.entity.takedamage) {
        numpoiswithcapturetime++;
        poinum = numpoiswithcapturetime;
      }

      poi.poinum = poinum;
      luinotifyevent(&"rts_add_poi", 2, poi.entity getentitynumber(), poinum);

      if(poi.entity.team == "allies")
        luinotifyevent(&"rts_protect_poi", 1, poi.entity getentitynumber());

      if(poi.capture_time > 0)
        luinotifyevent(&"rts_secure_poi", 1, poi.entity getentitynumber());
    }
  }
}

poicaptured(entity, capteam) {
  if(!isDefined(capteam))
    capteam = "allies";

  valid = [];

  for(i = 0; i < level.rts.poi.size; i++) {
    poi = level.rts.poi[i];

    if(isDefined(poi.entity) && poi.entity != entity) {
      valid[valid.size] = poi;
      continue;
    }

    if(isDefined(poi.entity)) {
      poi.entity maps\_so_rts_support::set_gpr(maps\_so_rts_support::make_gpr_opcode(2) + 0);
      luinotifyevent(&"rts_captured_poi", 1, poi.entity getentitynumber());
      poi.ignoreme = 1;

      if(isDefined(poi.entity.destroyed_cb))
        [[poi.entity.destroyed_cb]](poi.entity);
    }

    if(isDefined(poi.trigger))
      poi.trigger delete();

    if(isDefined(poi.fakevehicle)) {
      if(isarray(poi.fakevehicle)) {
        foreach(fake in poi.fakevehicle)
        fake delete();
      } else
        poi.fakevehicle delete();
    }

    if(isDefined(poi.objectivenum))
      objective_state(poi.objectivenum, capteam == "allies" ? "done" : "failed");

    level notify("poi_deleted_" + poi.ref);
  }

  level.rts.poi = valid;
}

del_poi(poi) {
  if(!isDefined(poi)) {
    return;
  }
  level notify("poi_deleted_" + poi.ref);

  if(isDefined(poi.entity)) {
    poi.entity maps\_so_rts_support::set_gpr(maps\_so_rts_support::make_gpr_opcode(2) + 0);
    luinotifyevent(&"rts_captured_poi", 1, poi.entity getentitynumber());
    poi.entity delete();
  }

  if(isDefined(poi.trigger))
    poi.trigger delete();

  if(isDefined(poi.fakevehicle)) {
    if(isarray(poi.fakevehicle)) {
      foreach(fake in poi.fakevehicle)
      fake delete();
    } else
      poi.fakevehicle delete();
  }
}

deleteallpoi(substr) {
  valid = [];

  for(i = 0; i < level.rts.poi.size; i++) {
    poi = level.rts.poi[i];

    if(isDefined(substr)) {
      if(!issubstr(poi.ref, substr)) {
        valid[valid.size] = poi;
        continue;
      }
    }

    del_poi(poi);
  }

  level.rts.poi = valid;
}

add_poi(ref, entity, team, ui, ignore, useenthp, ui_note) {
  if(!isDefined(ui))
    ui = 1;

  if(!isDefined(ignore))
    ignore = 0;

  if(!isDefined(useenthp))
    useenthp = 0;

  if(!isDefined(ui_note))
    ui_note = undefined;

  poi = getpoibyref(ref);

  if(isDefined(poi) && isDefined(entity)) {
    poi.entity = entity;
    entity.poi = poi;
    poi.origin = poi.entity.origin;
    poi.angles = poi.entity.angles;

    if(isDefined(poi.model) && poi.model != "") {
      poi.entity setmodel(poi.model);
      poi.entity disconnectpaths();
    }

    claimpoi(poi, poi.team);
    poi.entity.ref = poi;

    if(poi.health > 0) {
      if(!is_true(useenthp))
        poi.entity.health = poi.health;

      poi.entity.takedamage = 1;

      if(isDefined(poi.target)) {
        targets = getentarray(poi.target, "targetname");
        poi.fakevehicle = [];

        foreach(target in targets) {
          fakevehicle = maps\_vehicle::spawn_vehicle_from_targetname("fake_vehicle");
          fakevehicle.team = team;
          fakevehicle.vteam = team;
          fakevehicle.origin = target.origin;
          fakevehicle linkto(poi.entity);
          poi.fakevehicle[poi.fakevehicle.size] = fakevehicle;
        }
      } else if(poi.entity.classname == "script_model") {
        poi.fakevehicle = maps\_vehicle::spawn_vehicle_from_targetname("fake_vehicle");
        poi.fakevehicle.team = team;
        poi.fakevehicle.vteam = team;
        poi.fakevehicle.origin = poi.origin + vectorscale((0, 0, 1), 24.0);
        poi.fakevehicle linkto(poi.entity);
      }
    } else {
      poi.entity.health = 100;
      poi.entity.takedamage = 0;
    }

    poinum = 0;

    if(poi.capture_time > 0 || poi.entity.takedamage || isDefined(ui_note)) {
      level.numpoiswithcapturetime++;
      poinum = level.numpoiswithcapturetime;
    } else
      ui = 0;

    println("$$$$ Adding POI(" + poinum + "): " + ref + " at (" + entity.origin + ") EntNum: " + entity getentitynumber());

    if(is_true(ui)) {
      poi.poinum = poinum;
      luinotifyevent(&"rts_add_poi", 2, poi.entity getentitynumber(), poinum);

      if(isDefined(ui_note))
        luinotifyevent(ui_note, 1, poi.entity getentitynumber());
      else if(poi.entity.team == "axis")
        luinotifyevent(&"rts_secure_poi", 1, poi.entity getentitynumber());
      else if(poi.entity.team == "allies")
        luinotifyevent(&"rts_defend_poi", 1, poi.entity getentitynumber());
    }

    poi.nodes = getnodesinradiussorted(poi.origin, 256, 0);
    poi.entity.ignoreme = ignore;
    level thread poithink(poi);
  }
}

initpois() {
  level.poiobjectivenum = 10;
  level.rts.allied_center = getent("rts_player_center", "targetname");
  level.rts.enemy_center = getent("rts_enemy_center", "targetname");
  assert(isDefined(level.rts.allied_center), "spawn center not defined");
  assert(isDefined(level.rts.enemy_center), "spawn center not defined");
  assert(maps\_so_rts_support::clampenttomapboundary(level.rts.allied_center), "This location is out of boundary");
  assert(maps\_so_rts_support::clampenttomapboundary(level.rts.enemy_center), "This location is out of boundary");
  level.numpoiswithcapturetime = 0;
  level.rts.poiradius = 450;

  if(level.rts.game_mode == "attack") {
    level.rts.enemy_base = getpoibyref("rts_base_enemy");
    level.rts.enemy_base.entity = getent("rts_base_enemy", "targetname");
    claimpoi(level.rts.enemy_base, "axis");
  }

  foreach(poi in level.rts.poi) {
    if(!isDefined(poi.entity))
      poi.entity = getent(poi.ref, "targetname");

    if(isDefined(poi.entity)) {
      assert(isDefined(poi.model), "Entity declared as POI but no model specified");
      ent = poi.entity;
      poi.entity = spawn("script_model", ent.origin, 1);
      poi.entity.angles = ent.angles;
      poi.entity.targetname = ent.targetname;

      if(isDefined(ent.radius))
        poi.entity.radius = ent.radius;

      ent delete();
      poi.entity.ref = poi;
      poi.origin = poi.entity.origin;

      if(poi.health > 0) {
        poi.entity.health = poi.health;
        poi.entity.takedamage = 1;
      } else {
        poi.entity.health = 100;
        poi.entity.takedamage = 0;
      }

      add_poi(poi.ref, poi.entity, poi.team, 1);
    }
  }

  if(isDefined(level.rts.allied_base) && isDefined(level.rts.allied_base.entity))
    level.rts.allied_base.entity maps\_so_rts_support::set_as_target("allies");
}

claimpoi(poi, team) {
  poi.team = team;

  if(isDefined(poi.entity))
    poi.entity.team = team;

  if(team == "axis")
    poi.dominate_weight = poi.capture_time * -1;
  else if(team == "allies")
    poi.dominate_weight = poi.capture_time;
  else
    poi.dominate_weight = 0;

  if(isDefined(poi.claimcallback))
    poi thread[[poi.claimcallback]](team);
}

getpoibyref(refname) {
  foreach(poi in level.rts.poi) {
    if(poi.ref == refname)
      return poi;
  }

  return undefined;
}

getpoients() {
  ents = [];

  foreach(poi in level.rts.poi) {
    if(isDefined(poi.entity))
      ents[ents.size] = poi.entity;
  }

  return ents;
}

poi_setobjectivenumber(ref, num, compassicon) {
  poi = getpoibyref(ref);
  poi.objectivenum = num;

  if(isDefined(compassicon)) {
    objective_icon(poi.objectivenum, compassicon);

    if(isDefined(poi.trigger))
      objective_size(poi.objectivenum, poi.trigger getentitynumber());
    else
      objective_size(poi.objectivenum, poi.entity getentitynumber());

    objective_position(poi.objectivenum, poi.origin + (0, 0, poi.obj_zoff));
  }
}

poi_addobjective(poi) {
  if(!isDefined(poi.objtext) && !isDefined(poi.compassicon)) {
    return;
  }
  poi.objectivenum = level.poiobjectivenum;

  if(isDefined(poi.objtext))
    objective_add(poi.poiobjectivenum, "active", poi.objtext, poi.entity);

  if(isDefined(poi.compassicon)) {
    objective_icon(poi.objectivenum, poi.compassicon);

    if(isDefined(poi.trigger))
      objective_size(poi.objectivenum, poi.trigger getentitynumber());
    else
      objective_size(poi.objectivenum, poi.entity getentitynumber());

    objective_position(poi.objectivenum, poi.origin + (0, 0, poi.obj_zoff));
  }

  level.poiobjectivenum++;
}

getpoiobjectives() {
  pois = [];

  foreach(poi in level.rts.poi) {
    if(poi.capture_time > 0)
      pois[pois.size] = poi;
  }

  return pois;
}

poi_damagepulse(poi) {
  level endon("rts_terminated");
  level endon("poi_deleted_" + poi.ref);
  level notify("poi_damagePulse" + poi.ref);
  level endon("poi_damagePulse" + poi.ref);
  pulseon = 0;
  luinotifyevent(&"rts_pulse_poi", 2, poi.entity getentitynumber(), 0);

  while(true) {
    time = gettime();

    if(poi.pulsealert > time) {
      if(!pulseon) {
        pulseon = 1;
        luinotifyevent(&"rts_pulse_poi", 2, poi.entity getentitynumber(), 1);
      }
    } else if(pulseon) {
      pulseon = 0;
      luinotifyevent(&"rts_pulse_poi", 2, poi.entity getentitynumber(), 0);
    }

    wait 0.25;
  }
}

poi_deathwatch(poi) {
  level endon("rts_terminated");
  level endon("poi_deleted_" + poi.ref);

  if(poi.team == "allies")
    capteam = "axis";
  else
    capteam = "allies";

  origin = self.origin;
  entnum = self getentitynumber();
  max_health = self.health;
  next_dmg_alert = 0;
  poi.pulsealert = 0;
  val = maps\_so_rts_support::make_gpr_opcode(2) + 65280 + 255;
  poi.entity thread maps\_so_rts_support::set_gpr(val);
  poi.entity thread poi_damagepulse(poi);

  while(isDefined(self) && self.health > 0) {
    self waittill("damage", damage, attacker, direction_vec, point, type);
    time = gettime();
    poi.pulsealert = time + 3000;
    health = self.health;

    if(health < 0)
      health = 0;
    else
      health = int(health / max_health * 255);

    val = maps\_so_rts_support::make_gpr_opcode(2) + 65280 + health;
    poi.entity thread maps\_so_rts_support::set_gpr(val);
  }

  val = maps\_so_rts_support::make_gpr_opcode(2) + 65280 + 0;
  poi.entity thread maps\_so_rts_support::set_gpr(val);
  level notify(poi.ref + "_destroyed", poi.entity);
  level notify("poi_captured_" + capteam, poi.ref);
  poi.entity notify("taken_perm");
  luinotifyevent(&"rts_captured_poi", 1, poi.entity getentitynumber());
  level thread poicaptured(poi.entity, capteam);
}

poi_dominationwatch(poi) {
  level endon("rts_terminated");
  level endon("poi_deleted_" + poi.ref);
  luinotifyevent(&"rts_secure_poi", 1, poi.entity getentitynumber());
  poi.trigger = spawn("trigger_radius", poi.entity.origin, 0, isDefined(poi.entity.radius) ? poi.entity.radius : level.rts.poiradius, 64);
  time_required_to_dominate = poi.capture_time;
  time_required_to_dominate2x = time_required_to_dominate + time_required_to_dominate;
  lastval = 0;

  while(true) {
    poi.touchers["axis"] = 0;
    poi.touchers["allies"] = 0;
    aitouchers = poi.trigger maps\_so_rts_support::get_ents_touching_trigger();

    foreach(ai in aitouchers) {
      if(ai.team == "allies")
        poi.dominate_weight = poi.dominate_weight + 1;
      else
        poi.dominate_weight = poi.dominate_weight - 1;

      poi.touchers[ai.team]++;
    }

    if(poi.dominate_weight >= time_required_to_dominate) {
      poi.dominate_weight = time_required_to_dominate;

      if(poi.entity.team != "allies") {
        claimpoi(poi, "allies");
        level notify("poi_captured_allies", poi.entity);
      }
    } else if(poi.dominate_weight <= time_required_to_dominate * -1) {
      poi.dominate_weight = time_required_to_dominate * -1;

      if(poi.entity.team != "axis") {
        claimpoi(poi, "axis");
        level notify("poi_captured_axis", poi.entity);
      }
    } else if(poi.entity.team != "none") {
      claimpoi(poi, "none");
      level notify("poi_contested", poi.entity);
    }

    wait 1;
  }
}

ai_can_plantintruder(poi, ai) {
  if(poi.team == "allies")
    capteam = "axis";
  else
    capteam = "allies";

  if(is_true(poi.intruder_being_planted))
    return false;

  if(is_true(poi.has_intruder))
    return false;

  if(is_true(poi.block_intruder))
    return false;

  if(capteam == "allies" && !flag("rts_mode"))
    return false;

  if(gettime() < poi.plant_attempt + 2000)
    return false;

  if(isDefined(ai)) {
    if(!isDefined(ai.initialized))
      return false;

    if(!isDefined(ai.ai_ref))
      return false;

    if(ai != level.rts.player && ai.ai_ref.species != "human")
      return false;

    if(level.rts.nointruderzones.size) {
      foreach(zone in level.rts.nointruderzones) {
        if(ai istouching(zone))
          return false;
      }
    }

    if(!ai istouching(poi.intruder_trigger))
      return false;
  }

  return true;
}

poi_capturewatch(poi) {
  level endon("rts_terminated");
  level endon("poi_deleted_" + poi.ref);

  if(poi.team == "allies")
    capteam = "axis";
  else
    capteam = "allies";

  if(isDefined(poi.alttrig))
    poi.trigger = getent(poi.alttrig, "targetname");
  else
    poi.trigger = spawn("trigger_radius", poi.entity.origin, 0, isDefined(poi.entity.radius) ? poi.entity.radius : level.rts.poiradius, 72);

  time_required_to_dominate = poi.capture_time;
  time_required_to_dominate2x = time_required_to_dominate + time_required_to_dominate;
  poi_addobjective(poi);

  if(isDefined(poi.alttrig))
    poi.intruder_trigger = getent(poi.alttrig, "targetname");
  else
    poi.intruder_trigger = spawn("trigger_radius", poi.entity.origin, 0, isDefined(poi.entity.radius) ? poi.entity.radius : level.rts.poiradius / 2, 128);

  assert(isDefined(poi.intruder_trigger));
  poi.intruder_trigger thread watchnetworkintruder(poi);
  poi.has_intruder = 0;
  poi.plant_attempt = 0;
  poi.intruder_prefix = "intruder";
  lastval = 0;

  while(true) {
    networkintruders = poi.trigger maps\_so_rts_support::get_ents_touching_trigger(level.rts.networkintruders[capteam]);

    if(networkintruders.size > 0) {
      if(capteam == "allies")
        poi.dominate_weight = poi.dominate_weight + 1;
      else
        poi.dominate_weight = poi.dominate_weight - 1;

      if(!is_true(poi.has_intruder)) {
        poi.has_intruder = 1;
        level notify("poi_contested", poi.entity);

        if(capteam == "allies")
          luinotifyevent(&"rts_hide_poi", 1, poi.entity getentitynumber());
      }
    } else {
      if(capteam == "allies") {
        if(poi.dominate_weight != time_required_to_dominate * -1) {
          claimpoi(poi, "axis");

          if(is_true(poi.has_intruder)) {
            level notify("poi_nolonger_contested", poi.entity);
            poi.intruder = undefined;
            luinotifyevent(&"rts_unhide_poi", 1, poi.entity getentitynumber());
          }
        }
      } else if(poi.dominate_weight != time_required_to_dominate) {
        claimpoi(poi, "allies");

        if(is_true(poi.has_intruder)) {
          level notify("poi_nolonger_contested", poi.entity);
          poi.intruder = undefined;
          luinotifyevent(&"rts_unhide_poi", 1, poi.entity getentitynumber());
        }
      }

      poi.has_intruder = 0;

      if(ai_can_plantintruder(poi)) {
        aitouchers = poi.trigger maps\_so_rts_support::get_ents_touching_trigger(getaiarray(capteam));

        foreach(ai in aitouchers) {
          ai notify("near_poi", poi);

          if(!ai_can_plantintruder(poi, ai)) {
            thread maps\_so_rts_support::debugline(ai.origin, poi.origin, (1, 0, 0), 40);

            continue;
          }

          poi.plant_attempt = gettime();
          ai thread maps\_so_rts_support::ai_plant_network_intruder(poi);
          break;
        }
      }
    }

    if(capteam == "allies" && poi.dominate_weight >= time_required_to_dominate)
      poi.dominate_weight = time_required_to_dominate;

    if(capteam == "axis" && poi.dominate_weight <= time_required_to_dominate * -1)
      poi.dominate_weight = time_required_to_dominate * -1;

    if(poi.dominate_weight != lastval) {
      if(capteam == "allies") {
        weight = poi.dominate_weight + time_required_to_dominate;
        progress = weight / time_required_to_dominate2x;
      }

      if(capteam == "axis") {
        weight = poi.dominate_weight - time_required_to_dominate;
        progress = weight * -1 / time_required_to_dominate2x;
      }

      lastval = poi.dominate_weight;

      if(!is_true(poi.reverse_timer))
        val = maps\_so_rts_support::make_gpr_opcode(2) + ((time_required_to_dominate2x << 8) + int(progress * time_required_to_dominate2x));
      else {
        progress = 1.0 - progress;
        val = maps\_so_rts_support::make_gpr_opcode(2) + ((time_required_to_dominate2x << 8) + int(progress * time_required_to_dominate2x));
      }

      poi.entity thread maps\_so_rts_support::set_gpr(val);

      foreach(unit in networkintruders)
      unit thread maps\_so_rts_support::set_gpr(val);
    }

    if(capteam == "allies" && poi.dominate_weight == time_required_to_dominate && poi.entity.team != capteam) {
      claimpoi(poi, capteam);
      level thread maps\_so_rts_support::create_hud_message(&"SO_RTS_INFRA_WON");
      level notify("poi_captured_allies", poi.ref);
      maps\_so_rts_event::trigger_event("poi_captured");
      poi.captured = 1;
      poi.trigger delete();
      poi.trigger = undefined;
      val = maps\_so_rts_support::make_gpr_opcode(2) + 0;
      poi.entity thread maps\_so_rts_support::set_gpr(val);
      poi.entity notify("taken_perm");
      luinotifyevent(&"rts_captured_poi", 1, poi.entity getentitynumber());

      foreach(unit in networkintruders)
      unit dodamage(10000, unit.origin, unit);

      maps\_so_rts_event::trigger_event(poi.intruder_prefix + "_success_" + capteam);
      maps\_so_rts_event::trigger_event("sfx_intruder_success");
      level thread poicaptured(poi.entity, capteam);
      return;
    }

    if(capteam == "axis" && poi.dominate_weight == time_required_to_dominate * -1 && poi.entity.team != capteam) {
      claimpoi(poi, capteam);
      level thread maps\_so_rts_support::create_hud_message(&"SO_RTS_INFRA_LOST");
      level notify("poi_captured_axis", poi.ref);
      maps\_so_rts_event::trigger_event("poi_lost");
      poi.captured = 1;
      poi.trigger delete();
      poi.trigger = undefined;
      val = maps\_so_rts_support::make_gpr_opcode(2) + 0;
      poi.entity thread maps\_so_rts_support::set_gpr(val);
      poi.entity notify("taken_perm");
      luinotifyevent(&"rts_captured_poi", 1, poi.entity getentitynumber());

      foreach(unit in networkintruders)
      unit dodamage(10000, unit.origin, unit);

      level thread poicaptured(poi.entity, capteam);
      return;
    }

    wait 1;
  }
}

poi_watch(poi) {
  level endon("rts_terminated");
  level endon("poi_deleted_" + poi.ref);
  poi.trigger = spawn("trigger_radius", poi.entity.origin, 0, isDefined(poi.entity.radius) ? poi.entity.radius : level.rts.poiradius, 64);
  time_required_to_dominate = poi.capture_time;
  time_required_to_dominate2x = time_required_to_dominate + time_required_to_dominate;
  lastval = 0;

  while(isDefined(poi.trigger) && isDefined(poi.entity)) {
    poi.touchers["axis"] = 0;
    poi.touchers["allies"] = 0;
    aitouchers = poi.trigger maps\_so_rts_support::get_ents_touching_trigger();

    foreach(ai in aitouchers) {
      if(ai.team == "neutral") {
        continue;
      }
      poi.touchers[ai.team]++;
    }

    if(poi.entity.team == "axis") {
      if(poi.touchers["axis"] == 0 && poi.touchers["allies"] > 0) {
        if(!isDefined(poi.captime))
          poi.captime = gettime();

        if(gettime() - poi.captime > 3000) {
          claimpoi(poi, "allies");
          level notify("poi_captured_allies", poi.ref);
          maps\_so_rts_event::trigger_event("poi_captured");
          poi.captured = 1;
          poi.trigger delete();
          poi.trigger = undefined;
          val = maps\_so_rts_support::make_gpr_opcode(2) + 0;
          poi.entity thread maps\_so_rts_support::set_gpr(val);
          poi.entity notify("taken_perm");
          luinotifyevent(&"rts_captured_poi", 1, poi.entity getentitynumber());
          arrayremovevalue(level.rts.poi, poi);
          return;
        }
      } else
        poi.captime = undefined;
    }

    wait 1;
  }
}

ispoient(ent) {
  foreach(poi in level.rts.poi) {
    if(isDefined(poi.entity) && ent == poi.entity)
      return poi.ref;
  }

  return undefined;
}

poithink(poi) {
  if(is_true(poi.entity.takedamage)) {
    assert(isDefined(poi.entity.health) && poi.entity.health < 65535, "POI health is set beyond maximum");
    poi.entity thread poi_deathwatch(poi);
  } else if(poi.capture_time > 0 && poi.canbe_retaken != 0)
    level thread poi_dominationwatch(poi);
  else if(poi.capture_time > 0 && poi.canbe_retaken == 0) {
    if(is_true(poi.need_device))
      level thread poi_capturewatch(poi);
    else
      level thread poi_watch(poi);
  } else {
  }
}

getclosestpoi(myorigin, myteam, threshsq) {
  closest = undefined;
  closestsq = 9999999;

  foreach(poi in level.rts.poi) {
    if(isDefined(myteam)) {
      if(poi.team == myteam)
        continue;
    }

    distsq = distancesquared(poi.entity.origin, myorigin);

    if(isDefined(threshsq) && distsq > threshsq) {
      continue;
    }
    if(distsq < closestsq) {
      closestsq = distsq;
      closest = poi;
    }
  }

  return closest;
}

watchnetworkintruderplant(poi) {
  self notify("watchNetworkIntruderPlant");
  self endon("watchNetworkIntruderPlant");
  level endon("rts_terminated");
  self endon("death");

  while(true) {
    level waittill("intruder_placed_" + poi.trigger getentitynumber());
    level.rts.player maps\_so_rts_support::player_plant_network_intruder(poi);
  }
}

networkintruder_watchgunuse(poi) {
  wastouching = 0;

  while(isDefined(poi.trigger)) {
    if(level.rts.player istouching(poi.trigger)) {
      allow = is_true(poi.has_intruder);
      level.rts.player allowpickupweapons(allow);
      wastouching = 1;
    } else if(wastouching) {
      level.rts.player allowpickupweapons(1);
      wastouching = 0;
    }

    wait 0.05;
  }

  level.rts.player allowpickupweapons(1);
}

watchnetworkintruder(poi) {
  level endon("rts_terminated");
  self endon("death");

  if(poi.team == "allies")
    capteam = "axis";
  else
    capteam = "allies";

  self thread watchnetworkintruderplant(poi);
  level thread trigger_use(poi.trigger, level.rts.intruderplantstring, "intruder_placed_" + poi.trigger getentitynumber(), undefined, capteam);

  if(capteam == "allies")
    level thread networkintruder_watchgunuse(poi);

  while(isDefined(poi.trigger)) {
    poi.trigger.disable_use = undefined;
    networkintruders = poi.trigger maps\_so_rts_support::get_ents_touching_trigger(level.rts.networkintruders[capteam]);

    if(networkintruders.size > 0)
      poi.trigger.disable_use = 1;

    if(capteam == level.rts.player.team && !level.rts.player isonground())
      poi.trigger.disable_use = 1;

    if(isDefined(level.rts.player.ally) && isDefined(level.rts.player.ally.vehicle))
      poi.trigger.disable_use = 1;

    if(is_true(level.rts.switch_trans))
      poi.trigger.disable_use = 1;

    wait 0.05;
  }
}