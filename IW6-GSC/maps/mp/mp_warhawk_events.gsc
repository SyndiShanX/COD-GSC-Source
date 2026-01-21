/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_warhawk_events.gsc
*****************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#using_animtree("animated_props");
precache() {
  level.heli_anims = [];
  level.heli_anims["heli_flyby_01"] = "mp_warhawk_heli_flyby_01";
  level.heli_anims["heli_flyby_02"] = "mp_warhawk_heli_flyby_02";
  level.heli_anims_length = [];
  level.heli_anims_length["heli_flyby_01"] = GetAnimLength(%mp_warhawk_heli_flyby_01);
  level.heli_anims_length["heli_flyby_02"] = GetAnimLength(%mp_warhawk_heli_flyby_02);

  level.air_raid_active = false;

  PrecacheMpAnim("mp_warhawk_metal_door_open_in");
  PrecacheMpAnim("mp_warhawk_metal_door_open_in_loop");
  PrecacheMpAnim("mp_warhawk_metal_door_open_out");
  PrecacheMpAnim("mp_warhawk_metal_door_open_out_loop");
  PrecacheMpAnim("mp_frag_metal_door_chain");

  flag_init("chain_broken");
}

random_destruction_wait(min_wait_time, max_wait_time) {
  level endon("random_destruction");

  level thread random_destruction_wait_dvar();

  if(!level.createFX_enabled) {
    wait_time = RandomFloatRange(min_wait_time, max_wait_time);
    wait(wait_time);

    level.next_random_mortar_index++;
    level notify("random_destruction", level.randomDestructionIndicies[level.next_random_mortar_index - 1]);
  }
}

random_destruction_wait_dvar() {
  dvar_name = "trigger_random_destruction";
  default_value = 0;
  SetDevDvarIfUninitialized(dvar_name, default_value);
  while(1) {
    value = GetDvarInt(dvar_name, default_value);
    if(value == default_value) {
      waitframe();
    } else {
      SetDvar(dvar_name, 0);
      level notify("random_destruction", value);
    }
  }
}

random_destruction(min_wait_time, max_wait_time) {
  level endon("stop_dynamic_events");
  waitframe();
  if(!isDefined(level.destructible_array)) {
    level.destructible_array = getstructarray("random_destructible", "targetname");
  }
  random_destruction_preprocess(level.destructible_array);

  while(true) {
    thread random_destruction_wait(min_wait_time, max_wait_time);
    level waittill("random_destruction", index);
    if(!isDefined(index)) {
      continue;
    }
    index -= 1;

    if(index < 0) {
      closest_index = undefined;
      closest_dist = undefined;
      for(i = 0; i < level.destructible_array.size; i++) {
        if(level.destructible_array[i].mortar_ends.size) {
          dist = Distance2DSquared(level.player.origin, level.destructible_array[i].mortar_ends[0].origin);
          if(!isDefined(closest_dist) || dist < closest_dist) {
            closest_index = i;
            closest_dist = dist;
          }
        }
      }

      if(!isDefined(closest_index)) {
        continue;
      }
      index = closest_index;
    }

    if(level.destructible_array[index].fired) {
      random_destruction_restore(index);
      level.destructible_array[index].fired = false;
    } else {
      random_destruction_destroy(index);
      level.destructible_array[index].fired = true;
    }

    if(level.next_random_mortar_index >= level.randomDestructionIndicies.size) {
      break;
    }
  }
}

random_destruction_restore(index) {
  destructible_entity_targets = getEntArray(level.destructible_array[index].target, "targetname");
  foreach(destructible_element in destructible_entity_targets) {
    switch (destructible_element.script_noteworthy) {
      case "destructible_before":
        destructible_element trigger_on();
        break;

      case "destructible_after":
        destructible_element trigger_off();
        break;

      case "undefined":
      default:
        break;
    }
  }

}

exploders_explode_for_late_player() {
  self endon("disconnect");
  if(isDefined(level.exploders_cached)) {
    num_exploders_this_frame = 0;
    foreach(expl in level.exploders_cached) {
      exploder(expl.index, self, expl.time);
      num_exploders_this_frame++;
      if(num_exploders_this_frame >= 4) {
        wait(0.05);
        num_exploders_this_frame = 0;
      }
    }
  }
}

exploders_watch_late_players() {
  for(;;) {
    level waittill("connected", player);
    player thread exploders_explode_for_late_player();
  }
}

exploder_cache(index) {
  if(!isDefined(level.exploders_cached))
    level.exploders_cached = [];

  exploderData = spawnStruct();
  exploderData.index = (index);
  exploderData.time = level.time;
  level.exploders_cached[level.exploders_cached.size] = exploderData;
}

random_destruction_destroy(index) {
  if(!level.destructible_array[index].mortar_starts.size || !level.destructible_array[index].mortar_ends.size) {
    return;
  }
  start = random(level.destructible_array[index].mortar_starts);
  end = random(level.destructible_array[index].mortar_ends);
  random_mortars_fire(start.origin, end.origin, start.script_duration, undefined, false, false);

  destructible_entity_targets = getEntArray(level.destructible_array[index].target, "targetname");
  foreach(destructible_element in destructible_entity_targets) {
    switch (destructible_element.script_noteworthy) {
      case "destructible_before":
        destructible_element maps\mp\_movers::notify_moving_platform_invalid();
        destructible_element trigger_off();
        break;

      case "destructible_after":
        destructible_element trigger_on();
        break;

      case "undefined":
      default:
        break;
    }
  }
  exploder(50 + index);
  exploder_cache(50 + index);

  destructible_struct_targets = getstructarray(level.destructible_array[index].target, "targetname");
  foreach(destructible_element in destructible_struct_targets) {
    if(isDefined(destructible_element.script_noteworthy) && isDefined(level._effect[destructible_element.script_noteworthy])) {
      playFX(level._effect[destructible_element.script_noteworthy], destructible_element.origin);
    }
  }

  if(isDefined(level.destructible_array[index].script_parameters)) {
    params = StrTok(level.destructible_array[index].script_parameters, ";");
    foreach(param in params) {
      toks = StrTok(param, "=");
      if(toks.size != 2) {
        continue;
      }

      switch (toks[0]) {
        case "play_sound":
          playSoundAtPos(level.destructible_array[index].origin, toks[1]);
          break;
        case "play_loopsound":
          level.destructible_array[index].loop_sound_ent playLoopSound(toks[1]);
          break;
        case "play_fx":
          playFX(level._effect[toks[1]], level.destructible_array[index].origin);
          break;
        default:
          break;
      }
    }
  }
}

random_destruction_preprocess(destructible_array) {
  level.next_random_mortar_index = 0;
  level.randomDestructionIndicies = [];

  for(i = 0; i < destructible_array.size; i++) {
    level.randomDestructionIndicies[i] = i + 1;
  }
  level.randomDestructionIndicies = array_randomize(level.randomDestructionIndicies);

  foreach(element in destructible_array) {
    element.mortar_starts = [];
    element.mortar_ends = [];
    element.fired = false;

    destructible_before = [];

    before_start_origin = undefined;
    before_end_origin = undefined;
    after_start_origin = undefined;
    after_end_origin = undefined;

    structs = getstructarray(element.target, "targetname");
    foreach(destructible_element in structs) {
      switch (destructible_element.script_noteworthy) {
        case "before_start_origin":
          before_start_origin = destructible_element.origin;
          break;
        case "before_end_origin":
          before_end_origin = destructible_element.origin;
          break;
        case "after_start_origin":
          after_start_origin = destructible_element.origin;
          break;
        case "after_end_origin":
          after_end_origin = destructible_element.origin;
          break;
        case "mortar_start":
          element.mortar_starts[element.mortar_starts.size] = destructible_element;
          break;
        case "mortar_end":
          element.mortar_ends[element.mortar_ends.size] = destructible_element;
          break;
        default:
          break;
      }
    }

    before_offset = undefined;
    after_offset = undefined;
    if(isDefined(before_start_origin) && isDefined(before_end_origin))
      before_offset = before_end_origin - before_start_origin;

    if(isDefined(after_start_origin) && isDefined(after_end_origin))
      after_offset = after_end_origin - after_start_origin;

    ents = getEntArray(element.target, "targetname");
    foreach(destructible_element in ents) {
      switch (destructible_element.script_noteworthy) {
        case "destructible_before":

          destructible_before[destructible_before.size] = destructible_element;
          if(isDefined(before_offset))
            destructible_element.origin += before_offset;
          break;
        case "destructible_after":
          if(isDefined(after_offset))
            destructible_element.origin += after_offset;
          destructible_element trigger_off();
          break;
        case "loop_sound_ent":
          element.loop_sound_ent = destructible_element;
          break;
        case "delete":
          destructible_element Delete();
          break;
        default:
          break;
      }
    }

    if(element.mortar_starts.size == 0) {
      element.mortar_starts = getstructarray("air_raid", "targetname");
    }

    if(element.mortar_ends.size == 0) {
      element.mortar_ends = destructible_before;
    }

  }
}

#using_animtree("animated_props");

plane_crash_init() {
  if(!isDefined(self.target))
    return;
  if(!isDefined(self.script_animation) || !isDefined(level.plane_crash_anims[self.script_animation])) {
    return;
  }
  ents = getEntArray(self.target, "targetname");
  structs = getstructarray(self.target, "targetname");

  targets = array_combine(ents, structs);
  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "plane":
        self.plane = target;
        self thread run_func_on_notify("end", ::delete_ent, target);
        break;
      case "scene_node":
        self.scene_node = target;
        if(!isDefined(self.scene_node.angles))
          self.scene_node.angles = (0, 0, 0);
        break;
      case "show":
        target Hide();
        self thread run_func_on_notify(target.script_parameters, ::show_ent, target);
        break;
      case "show_trigger":
        target trigger_off();
        self thread run_func_on_notify(target.script_parameters, ::show_trigger, target);
        break;
      case "kill_players":
        self thread run_func_on_notify(target.script_parameters, ::kill_players_touching_ent, target);
        break;
      case "delete":
        self thread run_func_on_notify(target.script_parameters, ::delete_ent, target);
        break;
      case "fx":
        self thread run_func_on_notify(target.script_parameters, ::play_fx, target);
        break;
      case "trigger_fx":
        if(isDefined(target.script_fxid) && isDefined(level._effect[target.script_fxid])) {
          fx_ent = SpawnFx(level._effect[target.script_fxid], target.origin, anglesToForward(target.angles));
          self thread run_func_on_notify(target.script_parameters, ::trigger_fx, fx_ent);
        }
        break;
      default:
        break;
    }
  }

  if(self.script_animation == "mp_warhawk_osprey_crash") {
    self thread run_func_on_notify("start", ::play_fx_on_tag, "osprey_trail", "tag_engine_ri_fx2", self.plane);
    self thread run_func_on_notify("crash_sound", ::play_sound_on_ent, self.plane, "osprey_crash");
    self thread run_func_on_notify("hit_watertower", ::play_sound_at_ent, self.plane, "osprey_hit_tower");
    self thread run_func_on_notify("hit_ground", ::stop_fx_on_tag, "osprey_trail", "tag_engine_ri_fx2", self.plane);
  }

}

plan_crash_run(waitTime) {
  level endon("stop_dynamic_events");

  if(isDefined(waitTime))
    wait waitTime;

  if(isDefined(self.scene_node)) {
    self.plane.origin = self.scene_node.origin;
    self.plane.angles = self.scene_node.angles;
  }
  self.plane ScriptModelPlayAnimDeltaMotion(self.script_animation);
  self thread run_anim_events(level.plane_crash_anims_events[self.script_animation]);
}

create_anim_event(note, time) {
  s = spawnStruct();
  s.time = time;
  s.note = note;
  s.done = false;

  return s;
}

run_anim_events(events) {
  start_time = GetTime();
  while(1) {
    foreach(event in events) {
      if(event.done) {
        continue;
      }
      if((GetTime() - start_time) / 1000 >= event.time) {
        self notify(event.note);
        event.done = true;
        if(event.note == "end")
          return;
      }
    }
    wait .05;
  }
}

run_func_on_notify(note, func, param1, param2, param3) {
  self waittill(note);

  if(isDefined(param3)) {
    self thread[[func]](param1, param2, param3);
  } else if(isDefined(param2)) {
    self thread[[func]](param1, param2);
  } else if(isDefined(param1)) {
    self thread[[func]](param1);
  } else {
    self thread[[func]]();
  }
}

show_ent(ent) {
  ent Show();
}

show_trigger(ent) {
  ent trigger_on();
}

delete_ent(ent) {
  ent Delete();
}

play_sound_on_ent(ent, sound) {
  ent playSound(sound);
}

play_sound_at_ent(ent, sound) {
  playSoundAtPos(ent.origin, sound);
}

kill_players_touching_ent(ent) {
  foreach(player in level.players) {
    if(player IsTouching(ent)) {
      player maps\mp\_movers::mover_suicide();
    }
  }
}

play_fx(ent) {
  if(!isDefined(ent.script_fxid) || !isDefined(level._effect[ent.script_fxid])) {
    return;
  }
  playFX(level._effect[ent.script_fxid], ent.origin, anglesToForward(ent.angles));
}

trigger_fx(ent) {
  TriggerFX(ent);
}

play_fx_on_tag(fx, tag, ent) {
  playFXOnTag(getfx(fx), ent, tag);
}

stop_fx_on_tag(fx, tag, ent) {
  stopFXOnTag(getfx(fx), ent, tag);
}

random_mortars_fire(start_org, end_org, air_time, owner, trace_test, play_fx) {
  gravity = (0, 0, -800);

  if(!isDefined(air_time)) {
    air_time = RandomFloatRange(3, 4);
  }
  launch_dir = trajectorycalculateinitialvelocity(start_org, end_org, gravity, air_time);

  if(isDefined(trace_test) && trace_test) {
    delta_height = trajectorycomputedeltaheightattime(launch_dir[2], -1 * gravity[2], air_time / 2);
    trace_point = ((end_org - start_org) / 2) + start_org + (0, 0, delta_height);

    if(BulletTracePassed(trace_point, end_org, false, undefined)) {
      thread random_mortars_fire_run(start_org, end_org, air_time, owner, launch_dir, play_fx);
      return true;
    } else {
      return false;
    }
  }

  random_mortars_fire_run(start_org, end_org, air_time, owner, launch_dir, play_fx);
}

random_mortars_fire_run(start_org, end_org, air_time, owner, launch_dir, play_fx) {
  dirt_effect_radius = 350;

  mortar_model = random_mortars_get_model(start_org);
  mortar_model.origin = start_org;
  mortar_model.in_use = true;

  waitframe();
  playFXOnTag(getfx("random_mortars_trail"), mortar_model, "tag_fx");

  mortar_model.angles = VectorToAngles(launch_dir) * (-1, 1, 1);

  delayThread(air_time - 2.0, ::random_mortars_incoming_sound, end_org);

  mortar_model MoveGravity(launch_dir, air_time - 0.05);

  mortar_model waittill("movedone");

  if(level.createFX_enabled && !isDefined(level.players))
    level.players = [];

  if(isDefined(owner)) {
    mortar_model RadiusDamage(end_org, 250, 750, 500, owner, "MOD_EXPLOSIVE", "warhawk_mortar_mp");
  } else {
    mortar_model RadiusDamage(end_org, 140, 5, 5, undefined, "MOD_EXPLOSIVE", "warhawk_mortar_mp");
  }

  PlayRumbleOnPosition("artillery_rumble", end_org);

  foreach(player in level.players) {
    if(player isUsingRemote()) {
      continue;
    }

    if(distance(end_org, player.origin) > dirt_effect_radius) {
      continue;
    }

    if(player DamageConeTrace(end_org)) {
      player thread maps\mp\gametypes\_shellshock::dirtEffect(end_org);
    }
  }

  if(play_fx) {
    playFX(getfx("mortar_impact_00"), end_org);
  }

  mortar_model Delete();
}

random_mortars_incoming_sound(org) {
  playSoundAtPos(org, "mortar_incoming");;
}

random_mortars_get_target() {
  targets = getstructarray(self.target, "targetname");
  if(targets.size == 0)
    return undefined;

  target = random(targets);

  org = target.origin;
  if(isDefined(target.radius)) {
    dir = anglesToForward((0, RandomFloatRange(0, 360), 0));
    org = org + (dir * RandomFloatRange(0, target.radius));
  }
  return org;
}

random_mortars_get_model(origin) {
  mortar_model = spawn("script_model", origin);
  mortar_model setModel("projectile_rpg7");
  return mortar_model;
}

draw_move_path() {
  self endon("movedone");

  while(1) {
    org1 = self.origin;
    wait .5;
    self thread drawLine(org1, self.origin, 60 * 10, (1, 0, 0));
  }
}

draw_model_path() {
  self endon("movedone");

  models = [];
  while(1) {
    wait .5;
    model = spawn("script_model", self.origin);
    model setModel(self.model);
    model.angles = self.angles;
    models[models.size] = model;
  }

  wait 10;

  foreach(model in models) {
    model delete();
  }
}

jet_flyby() {
  jet_flyby = [];
  jet_flyby_radial = getstructarray("jet_flyby_radial", "targetname");

  planes = array_combine(jet_flyby, jet_flyby_radial);
  foreach(plane in planes) {
    plane.radial = plane.targetname == "jet_flyby_radial";
  }

  while(1) {
    wait RandomFloatRange(10, 20);

    planes = array_randomize(planes);
    for(i = 0; i < planes.size; i++) {
      plane = planes[i];

      start = undefined;
      end = undefined;
      if(plane.radial) {
        start = spawnStruct();
        end = spawnStruct();

        if(!isDefined(plane.radius))
          plane.radius = 8000;

        fly_angles = (0, RandomFloatRange(0, 360), 0);
        fly_dir = anglesToForward(fly_angles);

        start.origin = plane.origin - (plane.radius * fly_dir);
        start.angles = (fly_angles[0] + 3, fly_angles[1], (0));

        end.origin = plane.origin + (plane.radius * fly_dir);
        end.angles = (fly_angles[0] + 5, fly_angles[1], (0));

        if(isDefined(plane.height)) {
          start.origin = start.origin + (0, 0, RandomFloatRange(0, plane.height));
          end.origin = end.origin + (0, 0, RandomFloatRange(0, plane.height));
        }
      } else {
        targets = getstructarray(plane.target, "targetname");

        target = random(targets);
        if(!isDefined(target)) {
          continue;
        }
        start = plane;
        end = target;
      }

      speed = RandomFloatRange(1500, 1600);
      dist = Distance(start.origin, end.origin);
      time = dist / speed;

      model = spawn("script_model", start.origin);
      model.angles = end.angles;

      model setModel("vehicle_pavelow");
      waitframe();

      model playLoopSound("cobra_helicopter_dying_loop");

      model MoveTo(end.origin, time);
      model RotateTo(end.angles, time);
      model waittill("movedone");
      model Delete();

      wait RandomFloatRange(10, 20);
    }
  }
}

air_raid() {
  level endon("stop_dynamic_events");

  waitframe();

  level.air_raids = getstructarray("air_raid", "targetname");
  foreach(air_raid_path in level.air_raids) {
    if(!isDefined(air_raid_path.radius))
      air_raid_path.radius = 300;

    air_raid_path.current_end = 0;
    air_raid_path.ends = [];
    end = air_raid_path;
    while(isDefined(end.target)) {
      end = getstruct(end.target, "targetname");
      if(!isDefined(end.radius))
        end.radius = 100;
      air_raid_path.ends[air_raid_path.ends.size] = end;
    }
  }

  while(1) {
    level.air_raid_active = false;
    level.air_raid_team_called = "none";
    level waittill("warhawk_mortar_killstreak", player);
    level.air_raid_active = true;
    level.air_raid_team_called = player.team;
    thread air_raid_siren(10);
    wait 3;
    air_raid_fire(.5, .6, 25, player);
  }
}

air_raid_siren(siren_time) {
  if(!isDefined(level.air_raid_siren_ent)) {
    level.air_raid_siren_ent = getEnt("air_raid_siren", "targetname");
  }

  if(isDefined(level.air_raid_siren_ent)) {
    level.air_raid_siren_ent playSound("air_raid_siren");
  }
  wait siren_time;

  if(isDefined(level.air_raid_siren_ent)) {
    level.air_raid_siren_ent StopSounds();
  }
}

air_raid_fire(delay_min, delay_max, mortar_time_sec, owner) {
  motar_strike_end_time = GetTime() + mortar_time_sec * 1000;

  level.air_raids = array_randomize(level.air_raids);

  air_raid_num = 0;
  while(motar_strike_end_time > GetTime()) {
    mortars_per_loop = 12;
    mortars_launched = 0;
    foreach(player in level.players) {
      if(!isReallyAlive(player)) {
        continue;
      }
      if(level.teamBased) {
        if(player.team == level.air_raid_team_called)
          continue;
      } else {
        if(isDefined(owner) && player == owner)
          continue;
      }

      if(player.spawnTime + 8000 > GetTime()) {
        continue;
      }
      vel = player GetVelocity();

      mortar_air_time = RandomFloatRange(3, 4);

      mortar_target_pos = player.origin + (vel * mortar_air_time);

      nodes_near = GetNodesInRadiusSorted(mortar_target_pos, 100, 0, 60);
      foreach(node in nodes_near) {
        if(NodeExposedToSky(node)) {
          start_struct = random(level.air_raids);
          if(random_mortars_fire(start_struct.origin, node.origin, undefined, owner, true, true)) {
            wait RandomFloatRange(delay_min, delay_max);
            mortars_launched++;
            break;
          }
        }
      }
    }

    while(mortars_launched < mortars_per_loop) {
      start_struct = level.air_raids[air_raid_num];
      air_raid_num++;
      if(air_raid_num >= level.air_raids.size)
        air_raid_num = 0;

      end_struct = start_struct.ends[start_struct.current_end];
      start_struct.current_end++;
      if(start_struct.current_end >= start_struct.ends.size)
        start_struct.current_end = 0;

      start = random_point_in_circle(start_struct.origin, start_struct.radius);
      end = random_point_in_circle(end_struct.origin, end_struct.radius);
      thread random_mortars_fire(start, end, undefined, owner, false, true);
      wait RandomFloatRange(delay_min, delay_max);
      mortars_launched++;
    }
  }
}

random_point_in_circle(origin, radius) {
  if(radius > 0) {
    rand_dir = anglesToForward((0, RandomFloatRange(0, 360), 0));
    rand_radius = RandomFloatRange(0, radius);
    origin = origin + (rand_dir * rand_radius);
  }

  return origin;
}

heli_anims() {
  level endon("stop_dynamic_events");

  heli_anims = getstructarray("heli_anim", "targetname");
  if(heli_anims.size == 0) {
    return;
  }
  heli_index = heli_anims.size;

  foreach(heli in heli_anims) {
    if(!isDefined(heli.angles))
      heli.angles = (0, 0, 0);
  }

  while(1) {
    heli_index++;
    if(heli_index >= heli_anims.size) {
      heli_anims = array_randomize(heli_anims);
      heli_index = 0;
    }

    wait RandomFloatRange(10, 20);

    if(level.air_raid_active) {
      continue;
    }
    heli = heli_anims[heli_index];
    if(!isDefined(heli.script_animation) || !isDefined(level.heli_anims[heli.script_animation]) || !isDefined(level.heli_anims_length[heli.script_animation])) {
      continue;
    }
    model = spawn("script_model", heli.origin);
    model.angles = heli.angles;

    model setModel("vehicle_battle_hind");
    model playLoopSound("heli_flyover");

    model ScriptModelPlayAnimDeltaMotion(level.heli_anims[heli.script_animation]);

    wait level.heli_anims_length[heli.script_animation];

    model Delete();

  }
}

chain_gate_trigger_wait_damage(gate_trigger) {
  self endon("chain_gate_trigger_damage");
  gate_trigger waittill("damage", amount, attacker, direction_vec, point, type);

  self notify("chain_gate_trigger_damage", amount, attacker, direction_vec, point, type);
}

chain_gate() {
  left_gate = GetEnt("left_gate", "targetname");
  right_gate = GetEnt("right_gate", "targetname");
  lock = GetEnt("lock", "targetname");
  gate_clip = GetEnt("gate_clip", "targetname");
  gate_triggers = getEntArray("gate_trigger", "targetname");

  gate_anim_node = spawn("script_model", left_gate.origin);
  gate_anim_node setModel("generic_prop_raven");
  gate_anim_node.angles = left_gate.angles;
  waitframe();
  gate_clip ConnectPaths();
  waitframe();
  left_gate LinkTo(gate_anim_node, "j_prop_1");
  right_gate LinkTo(gate_anim_node, "j_prop_2");
  waitframe();
  centerpoint = (0, 0, 0);
  num_trigs = 0;
  foreach(gate_trigger in gate_triggers) {
    add_to_bot_damage_targets(gate_trigger);
    centerpoint += gate_trigger.origin;
    num_trigs++;
  }
  centerpoint = centerpoint / num_trigs;

  level thread bot_outside_gate_watch();
  lock ScriptModelPlayAnim("mp_frag_metal_door_chain");

  left_gate setCanDamage(false);
  left_gate setCanRadiusDamage(false);

  right_gate setCanDamage(false);
  right_gate setCanRadiusDamage(false);

  lock setCanDamage(false);
  lock setCanRadiusDamage(false);

  foreach(gate_trigger in gate_triggers) {
    thread chain_gate_trigger_wait_damage(gate_trigger);
  }

  self waittill("chain_gate_trigger_damage", amount, attacker, direction_vec, point, type);

  lock playSound("scn_breach_gate_lock");

  if(IsExplosiveDamageMOD(type)) {
    direction_vec = centerpoint - point;
  }

  open_in = (direction_vec[0] > 0);

  lock Delete();
  foreach(gate_trigger in gate_triggers) {
    remove_from_bot_damage_targets(gate_trigger);
    gate_trigger Delete();
  }
  flag_set("chain_broken");

  if(open_in) {
    gate_anim_node ScriptModelPlayAnimDeltaMotion("mp_warhawk_metal_door_open_in");
  } else {
    gate_anim_node ScriptModelPlayAnimDeltaMotion("mp_warhawk_metal_door_open_out");
  }

  left_gate playSound("scn_breach_gate_open_left");
  right_gate playSound("scn_breach_gate_open_right");

  wait(0.5);

  waitframe();
  gate_clip Delete();
}

bot_outside_gate_watch() {
  level endon("chain_broken");

  gate_triggers = getEntArray("gate_trigger", "targetname");
  near_gate_volume = GetEnt("near_gate_volume", "targetname");

  while(1) {
    if(isDefined(level.participants)) {
      foreach(participant in level.participants) {
        if(IsAI(participant) && participant IsTouching(near_gate_volume)) {
          gate_triggers[0] set_high_priority_target_for_bot(participant);
        }
      }
    }
    wait(1.0);
  }
}