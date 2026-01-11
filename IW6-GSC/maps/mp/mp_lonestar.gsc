/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_lonestar.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_lonestar_precache::main();
  maps\createart\mp_lonestar_art::main();
  maps\mp\mp_lonestar_fx::main();

  level thread maps\mp\_movers::main();
  level thread maps\mp\_movable_cover::init();
  level thread quakes();

  maps\mp\_load::main();
  thread maps\mp\_fx::func_glass_handler();

  maps\mp\_compass::setupMiniMap("compass_map_mp_lonestar");

  SetDvar("r_ssaofadedepth", 384);
  SetDvar("r_ssaorejectdepth", 1152);

  setdvar_cg_ng("r_specularColorScale", 3, 15);
  setdvar_cg_ng("r_diffuseColorScale", 1.25, 3.5);

  SetDvar("r_lightGridEnableTweaks", 1);
  SetDvar("r_lightGridIntensity", 1.33);

  if(level.ps3) {
    SetDvar("sm_sunShadowScale", "0.5");
    SetDvar("sm_sunsamplesizenear", ".19");
  } else if(level.xenon) {
    SetDvar("sm_sunShadowScale", "0.8");
    SetDvar("sm_sunsamplesizenear", ".25");
  } else {
    SetDvar("sm_sunShadowScale", "0.9");
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level thread exploder_triggers();

  level thread exploder_test();

  level thread initExtraCollision();
}

initExtraCollision() {
  collision1 = GetEnt("clip128x128x128", "targetname");
  collision1Ent = spawn("script_model", (-714, -2022, 102));
  collision1Ent.angles = (0, 0, 0);
  collision1Ent CloneBrushmodelToScriptmodel(collision1);

  collision2 = GetEnt("clip128x128x128", "targetname");
  collision2Ent = spawn("script_model", (-828, -2160, 80));
  collision2Ent.angles = (0, 0, 0);
  collision2Ent CloneBrushmodelToScriptmodel(collision2);

  collision3 = GetEnt("clip256x256x256", "targetname");
  collision3Ent = spawn("script_model", (-2048, -336, 112));
  collision3Ent.angles = (0, 0, 0);
  collision3Ent CloneBrushmodelToScriptmodel(collision3);

  collision4 = GetEnt("player32x32x256", "targetname");
  collision4Ent = spawn("script_model", (-572, -822, 276));
  collision4Ent.angles = (0, 0, 0);
  collision4Ent CloneBrushmodelToScriptmodel(collision4);

  collision5 = GetEnt("clip64x64x128", "targetname");
  collision5Ent = spawn("script_model", (-990, -209.5, 323));
  collision5Ent.angles = (90, 0, 0);
  collision5Ent CloneBrushmodelToScriptmodel(collision5);
}

exploder_test() {
  dvar_name = "test_exploder";
  default_value = -1;
  SetDevDvarIfUninitialized(dvar_name, default_value);
  while(1) {
    value = GetDvarInt(dvar_name, default_value);
    if(value < 0) {
      waitframe();
    } else {
      exploder(value);
      SetDvar(dvar_name, default_value);
    }
  }
}

exploder_triggers() {
  triggers = getEntArray("exploder_trigger", "targetname");
  foreach(trigger in triggers) {
    if(!isDefined(trigger.script_index)) {
      continue;
    }
    trigger thread exploder_trigger_run();
  }
}

exploder_trigger_run() {
  self endon("death");

  sounds_for_exploder = [];
  sounds_for_exploder[3] = "scn_mp_lonestar_bat";
  sounds_for_exploder[4] = "scn_mp_lonestar_bat";

  while(1) {
    self waittill("trigger");
    exploder(self.script_index);

    if(isDefined(sounds_for_exploder[self.script_index]) && isDefined(self.target)) {
      sound_origins = getstructarray(self.target, "targetname");
      foreach(org in sound_origins) {
        playSoundAtPos(org.origin, sounds_for_exploder[self.script_index]);
      }
    }

    wait RandomFloatRange(60 * 1, 60 * 2);
  }
}

#using_animtree("animated_props");
quakes() {
  if(GetDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }

  PrecacheMpAnim("mp_lonestar_bat_effect_path");
  level._effect["bats"] = LoadFX("fx/animals/bats_swarm");

  level._effect["gas_leak"] = LoadFX("fx/fire/heat_lamp_distortion");
  level._effect["gas_leak_fire"] = LoadFX("fx/maps/mp_lonestar/mp_ls_gaspipe_fire");

  level.quake_anims = [];
  level.quake_anims["ground_collapse"] = "mp_lonestar_road_slab_quake";
  level.quake_anims["ground_collapse_start_idle"] = "mp_lonestar_road_slab_quake_idle";
  level.quake_anims["pole_fall_on_police_car"] = "mp_lonestar_police_car_crush_pole";
  level.quake_anims["police_car_hit_by_pole"] = "mp_lonestar_police_car_crush_car";
  level.quake_anims["wire_shake"] = "mp_lonestar_earthquake_wire_shake";
  level.quake_anims["hanging_cable_loop"] = "mp_lonestar_hanging_wire_loop";
  level.quake_anims["hanging_cable"] = "mp_lonestar_hanging_wire_earthquake";

  level.quake_anims_ref = [];
  level.quake_anims_ref["hanging_cable"] = % mp_lonestar_hanging_wire_earthquake;

  foreach(key, value in level.quake_anims) {
    PrecacheMpAnim(value);
  }

  level.pre_quake_scriptables = [];
  level.quake_scriptables = [];
  add_quake_scriptable("qauke_script_hanging_wire", GetAnimLength( % mp_lonestar_hanging_wire_earthquake), false);
  add_quake_scriptable("qauke_script_telephone_wire", GetAnimLength( % mp_lonestar_earthquake_wire_shake), true);

  level.quake_anim_funcs["police_car_hit_by_pole"] = [];
  level.quake_anim_funcs["police_car_hit_by_pole"][0] = ::quake_event_pole_fall_on_car;

  level.quake_anim_init_funcs["police_car_hit_by_pole"] = [];
  level.quake_anim_init_funcs["police_car_hit_by_pole"][0] = ::quake_event_pole_fall_on_car_init;

  waitframe();

  if(level.createFX_enabled) {
    return;
  }
  start_time = GetTime();
  quake_events = quake_events();

  quake = getstruct("quake", "targetname");

  num_quakes = 3;

  quake_event_lists = [];
  list_order = [];
  for(i = 0; i < num_quakes; i++) {
    quake_event_lists[i] = [];
    list_order[i] = i;
  }

  quake_events = array_randomize(quake_events);
  foreach(event in quake_events) {
    if(event.count > 0) {
      list_order = array_shift(list_order);
    }
    for(i = 0; i < list_order.size && event.count != 0; i++) {
      o = list_order[i];
      quake_event_lists[o][quake_event_lists[o].size] = event;
      event.count--;
    }
  }
  quake_event_lists = array_randomize(quake_event_lists);

  time_limit = max(5, getTimeLimit());
  quake_times = [];
  for(i = 0; i < num_quakes; i++) {
    min_time = (1 / num_quakes) * (i + 0.2);
    max_time = (1 / num_quakes) * (i + 0.8);
    quake_times[i] = RandomFloatRange(min_time, max_time) * time_limit * 60;
  }

  for(i = 0; i < num_quakes; i++) {
    time = quake_times[i];
    earthqauke_wait(time);
    quake thread quake_run(quake_event_lists[i]);
  }
}

earthqauke_wait(time) {
  level endon("earthquake_start");

  level thread earthqauke_wait_dvar();

  wait time;
  level notify("earthquake_start");
}

earthqauke_wait_dvar() {
  level endon("earthquake_start");

  dvar_name = "trigger_earthquake";
  default_value = 0;
  SetDevDvarIfUninitialized(dvar_name, default_value);
  while(1) {
    value = GetDvarInt(dvar_name, default_value);
    if(value == default_value) {
      waitframe();
    } else {
      SetDvar(dvar_name, default_value);
      level notify("earthquake_start");
    }
  }
}

array_shift(array) {
  new_array = [];
  for(i = 0; i < array.size - 1; i++) {
    new_array[i] = array[i + 1];
  }
  new_array[new_array.size] = array[0];
  return new_array;
}

add_quake_scriptable(targetname, animTime, is_pre_quake) {
  scriptables = GetScriptableArray(targetname, "targetname");

  foreach(thing in scriptables) {
    thing.quake_scriptable_time = animTime;
  }

  if(is_pre_quake) {
    level.pre_quake_scriptables = array_combine(level.pre_quake_scriptables, scriptables);
  } else {
    level.quake_scriptables = array_combine(level.quake_scriptables, scriptables);
  }

}

quake_run_scriptables(scriptables) {
  foreach(scriptable in scriptables) {
    scriptable SetScriptablePartState("main", "quake");

    scriptable delayCall(scriptable.quake_scriptable_time, ::SetScriptablePartState, "main", "idle");
  }
}

quake_run(quake_events) {
  quake_run_scriptables(level.pre_quake_scriptables);

  wire_event = undefined;
  foreach(event in quake_events) {
    if(isDefined(event.script_noteworthy) && (event.script_noteworthy == "wires")) {
      wire_event = event;
      wire_event thread quake_event_trigger(0, wire_event quake_event_wait());
      break;
    }
  }

  wait(4.0);

  quake_run_scriptables(level.quake_scriptables);

  duration = RandomFloatRange(7, 9);

  playSoundAtPos((0, 0, 0), "mp_earthquake_lr");
  Earthquake(0.3, duration, self.origin, self.radius);

  exploder(1);

  foreach(event in quake_events) {
    if(!isDefined(wire_event) || event != wire_event) {
      event thread quake_event_trigger(duration, event quake_event_wait());
    }
  }
}

quake_event_trigger(duration, waitTime) {
  if(isDefined(waitTime) && waitTime > 0) {
    wait waitTime;
  }

  self notify("trigger", duration);
}

quake_event_wait() {
  if(isDefined(self.script_wait)) {
    return self.script_wait;
  } else if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    return RandomFloatRange(self.script_wait_min, self.script_wait_max);
  }

  return 0;
}

quake_event_trigger_wait(func, var1, var2, var3, var4, var5, var6) {
  while(1) {
    self waittill("trigger", quakeTime);
    if(isDefined(var6)) {
      self thread[[func]](quakeTime, var1, var2, var3, var4, var5, var6);
    } else if(isDefined(var5)) {
      self thread[[func]](quakeTime, var1, var2, var3, var4, var5);
    } else if(isDefined(var4)) {
      self thread[[func]](quakeTime, var1, var2, var3, var4);
    } else if(isDefined(var3)) {
      self thread[[func]](quakeTime, var1, var2, var3);
    } else if(isDefined(var2)) {
      self thread[[func]](quakeTime, var1, var2);
    } else if(isDefined(var1)) {
      self thread[[func]](quakeTime, var1);
    } else {
      self thread[[func]](quakeTime);
    }
  }
}

quake_events() {
  events = getstructarray("quake_event", "targetname");
  array_thread(events, ::quake_event_init);
  return events;
}

quake_event_init() {
  ents = getEntArray(self.target, "targetname");

  if(isDefined(self.script_noteworthy)) {
    extra_targets = StrTok(self.script_noteworthy, ",");
    foreach(script_noteworthy_target in extra_targets) {
      extra_target_ents = getEntArray(script_noteworthy_target, "targetname");
      ents = array_combine(ents, extra_target_ents);
    }
  }

  foreach(ent in ents) {
    if(ent maps\mp\_movers::script_mover_is_script_mover()) {
      self thread quake_event_trigger_wait(::quake_event_send_notify, ent, "trigger");
      continue;
    }

    quake_event_init_ent(ent);

    if(!isDefined(ent.script_noteworthy)) {
      continue;
    }
    tokens = StrTok(ent.script_noteworthy, ",");

    foreach(token in tokens) {
      switch (token) {
        case "ground_collapse":
          self thread quake_event_trigger_wait(::quake_event_move_to, ent, 1, undefined, 1, 0, true);
          break;
        case "shake":
          self thread quake_event_trigger_wait(::quake_event_shake, ent);
          break;
        case "hurt":
          if(!isDefined(ent.script_damage)) {
            ent.script_damage = 25;
          }
          if(!isDefined(ent.script_delay)) {
            ent.script_delay = 1;
          }
          self thread quake_event_trigger_wait(::quake_event_hurt, ent, ent.script_delay, ent.script_damage);
          break;
        case "hurt_fire":
          self thread quake_event_trigger_wait(::quake_event_hurt, ent, 1, 25);
          break;
        case "delete":
          self thread quake_event_trigger_wait(::quake_event_delete, ent);
          break;
        case "animate":
          if(isDefined(ent.script_animation)) {
            if(isDefined(level.quake_anim_init_funcs[ent.script_animation])) {
              foreach(func in level.quake_anim_init_funcs[ent.script_animation]) {
                level thread[[func]](ent);
              }
            }

            if(isDefined(level.quake_anims[ent.script_animation + "_start_idle"])) {
              ent ScriptModelPlayAnim(level.quake_anims[ent.script_animation + "_start_idle"]);
            }

            if(isDefined(level.quake_anims[ent.script_animation + "_loop"])) {
              ent ScriptModelPlayAnim(level.quake_anims[ent.script_animation + "_loop"]);
            }

            if(isDefined(level.quake_anims[ent.script_animation])) {
              self thread quake_event_trigger_wait(::quake_event_animate, ent, ent.script_animation);
            }
          }
          break;
        case "show":
          ent Hide();
          self thread quake_event_trigger_wait(::quake_event_show, ent);
          break;
        case "move_to_end":
          move_time = 1;
          if(isDefined(ent.script_parameters)) {
            move_time = Float(ent.script_parameters);
          }
          self thread quake_event_trigger_wait(::quake_event_move_to, ent, .5, ent.script_delay);
          break;
        case "gas_leak":
          if(isDefined(self.target)) {
            ent.fx_location = getstruct(ent.target, "targetname");
            ent.hurt_trigger = GetEnt(ent.target, "targetname");

            self thread quake_event_trigger_wait(::quake_event_gas_leak, ent);
          }
          break;
        case "sound":
          self thread quake_event_trigger_wait(::quake_event_playSound, ent);
          break;
        default:
          break;
      }
    }
  }

  structs = getstructarray(self.target, "targetname");
  foreach(struct in structs) {
    if(!isDefined(struct.script_noteworthy)) {
      continue;
    }
    switch (struct.script_noteworthy) {
      case "fx":
        if(!isDefined(struct.script_parameters)) {
          struct.script_parameters = "gas_leak";
        }
        if(!isDefined(struct.angles)) {
          struct.angles = (0, 0, 0);
        }

        fx_ent = SpawnFx(level._effect[struct.script_parameters], struct.origin, anglesToForward(struct.angles));
        self thread quake_event_trigger_wait(::quake_event_fx, fx_ent);
        break;
      case "exploder":
        exploder_id = struct.script_prefab_exploder;
        if(!isDefined(exploder_id)) {
          exploder_id = struct.script_exploder;
        }
        if(isDefined(exploder_id)) {
          self thread quake_event_trigger_wait(::quake_event_exploder, exploder_id);
        }
        break;
      case "sound":
        self thread quake_event_trigger_wait(::quake_event_playSound, struct);
        break;
      default:
        break;
    }
  }

  nodes = GetVehicleNodeArray(self.target, "targetname");
  foreach(node in nodes) {
    if(!isDefined(node.script_noteworthy)) {
      continue;
    }
    switch (node.script_noteworthy) {
      case "bats":
        self thread quake_event_trigger_wait(::quake_event_bats, node);
      default:
        break;
    }
  }

  linked_nodes = getLinknameNodes();
  foreach(node in linked_nodes) {
    if(!isDefined(node.script_noteworthy)) {
      continue;
    }
    switch (node.script_noteworthy) {
      case "connect_traverse":
        disconnect_traverse(node);
        self thread quake_event_trigger_wait(::quake_event_connect_traverse, node);
        break;
      case "disconnect_traverse":
        self thread quake_event_trigger_wait(::quake_event_disconnect_traverse, node);
        break;
      case "connect":
        node DisconnectNode();
        self thread quake_event_trigger_wait(::quake_event_connect_node, node);
        break;
      case "disconnect":
        self thread quake_event_trigger_wait(::quake_event_disconnect_node, node);
        break;
      default:
        break;
    }
  }

  if(!isDefined(self.count)) {
    self.count = 1;
  }
}

is_dynamic_path() {
  return isDefined(self.spawnflags) && self.spawnflags & 1;
}

quake_event_init_ent(ent) {
  ent.move_ent = ent;

  if(!isDefined(ent.target)) {
    return;
  }
  structs = getstructarray(ent.target, "targetname");
  ents = getEntArray(ent.target, "targetname");

  targets = array_combine(structs, ents);

  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "link":
        target LinkTo(ent);
        break;
      case "origin":
        ent.move_ent = spawn("script_model", target.origin);
        ent.move_ent.angles = (0, 0, 0);
        if(isDefined(target.angles)) {
          ent.move_ent.angles = target.angles;
        }
        ent.move_ent setModel("tag_origin");
        ent LinkTo(ent.move_ent);
        break;
      case "end":
        ent.end_location = target;
        break;
      case "start":
        if(ent is_dynamic_path()) {
          ent ConnectPaths();
        }
        ent.origin = target.origin;
        if(isDefined(target.angles)) {
          ent.angles = target.angles;
        }
        break;
      default:
        break;
    }
  }
}

quake_event_move_to(quakeTime, ent, time, delay, accel, decel, delete_at_end) {
  if(!isDefined(ent.end_location)) {
    return;
  }
  if(!isDefined(accel)) {
    accel = 0;
  }
  if(!isDefined(decel)) {
    decel = 0;
  }
  if(!isDefined(delete_at_end)) {
    delete_at_end = false;
  }

  if(isDefined(delay) && delay > 0) {
    wait delay;
  }

  if(ent.end_location.origin != ent.origin) {
    ent.move_ent MoveTo(ent.end_location.origin, time, accel, decel);
  }

  if(isDefined(ent.end_location.angles) && ent.end_location.angles != ent.angles) {
    ent.move_ent RotateTo(ent.end_location.angles, time, accel, decel);
  }

  wait time;

  if(ent is_dynamic_path()) {
    ent DisconnectPaths();
  }

  if(delete_at_end) {
    ent.move_ent Delete();
    if(isDefined(ent)) {
      ent Delete();
    }
  }

}

#using_animtree("animated_props");
quake_event_bats(quakeTime, start_node) {
  bat_origin = (752, -3536, 132);
  bat_model = spawn("script_model", bat_origin);
  bat_model.angles = (0, 0, 0);
  bat_model setModel("generic_prop_raven");

  waitframe();

  bat_sound_ent = spawn("script_model", bat_origin);
  bat_sound_ent setModel("tag_origin");
  bat_sound_ent LinkTo(bat_model, "j_prop_2");

  waitframe();

  playFXOnTag(level._effect["bats"], bat_model, "j_prop_2");

  bat_model ScriptModelPlayAnimDeltaMotion("mp_lonestar_bat_effect_path");
  bat_sound_ent playLoopSound("mp_quake_bat_lp");

  wait(GetAnimLength( % mp_lonestar_bat_effect_path));

  bat_sound_ent Delete();
  bat_model Delete();
}

quake_event_hurt(quakeTime, hurt_trigger, damage_rate, damage) {
  thread quake_hurt_trigger(hurt_trigger, damage_rate, damage);
}

quake_hurt_trigger(hurt_trigger, damage_rate, damage) {
  self endon("stop_hurt_trigger");

  ent_num = hurt_trigger GetEntityNumber();
  damage_rate_ms = damage_rate * 1000;

  while(1) {
    hurt_trigger waittill("trigger", player);

    if(!isDefined(player.quake_hurt_time)) {
      player.quake_hurt_time = [];
    }

    if(!isDefined(player.quake_hurt_time[ent_num])) {
      player.quake_hurt_time[ent_num] = -1 * damage_rate_ms;
    }

    if(player.quake_hurt_time[ent_num] + damage_rate_ms > GetTime()) {
      continue;
    }
    player.quake_hurt_time[ent_num] = GetTime();

    player DoDamage(damage, hurt_trigger.origin);

  }
}

quake_event_show(quakeTime, ent) {
  ent Show();
}

quake_event_delete(quakeTime, ent) {
  ent Delete();
}

quake_event_fx(quakeTime, fx_ent) {
  TriggerFX(fx_ent);
}

quake_event_exploder(quakeTime, exploder_id) {
  exploder(exploder_id);
}

quake_event_send_notify(quakeTime, ent, note) {
  ent notify(note);
}

quake_event_animate(quakeTime, ent, anim_name) {
  ent ScriptModelPlayAnimDeltaMotion(level.quake_anims[anim_name]);

  if(isDefined(level.quake_anim_funcs[anim_name])) {
    foreach(func in level.quake_anim_funcs[anim_name]) {
      level thread[[func]](quakeTime, ent);
    }
  }

  if(isDefined(level.quake_anims[anim_name + "_loop"]) && isDefined(level.quake_anims_ref[anim_name])) {
    anim_length = GetAnimLength(level.quake_anims_ref[anim_name]);
    wait anim_length;
    ent ScriptModelPlayAnim(level.quake_anims[ent.script_animation + "_loop"]);
  }
}

quake_event_gas_leak(quakeTime, ent) {
  while(1) {
    fire_fx = SpawnFx(level._effect["gas_leak_fire"], ent.fx_location.origin, anglesToForward(ent.fx_location.angles));
    TriggerFX(fire_fx);
    ent playLoopSound("emt_lone_gas_pipe_fire_lp");

    self thread quake_hurt_trigger(ent.hurt_trigger, .25, 10);

    wait 30;

    self notify("stop_hurt_trigger");
    fire_fx Delete();
    ent StopLoopSound("emt_lone_gas_pipe_fire_lp");

    gas_fx = SpawnFx(level._effect["gas_leak"], ent.fx_location.origin, anglesToForward(ent.fx_location.angles));
    TriggerFX(gas_fx);

    ent waittill_notify_or_timeout("trigger", 30);

    gas_fx Delete();
  }
}

quake_event_pole_unlink_nodes() {
  nodes = getnodearray("dog_pole_vault", "script_noteworthy");
  if(isDefined(nodes)) {
    assert(nodes.size == 2);
    DisconnectNodePair(nodes[0], nodes[1]);
  }

  nodes2 = getnodearray("dog_pole_vault2", "script_noteworthy");
  if(isDefined(nodes2)) {
    assert(nodes2.size == 2);
    DisconnectNodePair(nodes2[0], nodes2[1]);
  }
}

quake_event_pole_link_nodes() {
  nodes = getnodearray("dog_pole_vault", "script_noteworthy");
  if(isDefined(nodes)) {
    assert(nodes.size == 2);
    if(isDefined(nodes[0].target) && isDefined(nodes[1].targetname) && nodes[0].target == nodes[1].targetname) {
      ConnectNodePair(nodes[0], nodes[1], true);
    } else {
      ConnectNodePair(nodes[1], nodes[0], true);
    }
  }

  nodes2 = getnodearray("dog_pole_vault2", "script_noteworthy");
  if(isDefined(nodes2)) {
    assert(nodes2.size == 2);
    if(isDefined(nodes2[0].target) && isDefined(nodes2[1].targetname) && nodes2[0].target == nodes2[1].targetname) {
      ConnectNodePair(nodes2[0], nodes2[1], true);
    } else {
      ConnectNodePair(nodes2[1], nodes2[0], true);
    }
  }
}

quake_event_pole_fall_on_car_init(ent) {
  broken_base = GetEnt("pole_that_falls_on_cop_car_base", "targetname");
  if(isDefined(broken_base)) {
    broken_base hide();
  }

  pole = GetEnt("pole_that_falls_on_cop_car", "targetname");
  if(!isDefined(pole)) {
    return;
  }
  clips = getEntArray(pole.target, "targetname");
  foreach(clip in clips) {
    if(clip.script_noteworthy == "clip_up") {
      clip LinkTo(pole);
      pole.clip_up = clip;
    } else if(clip.script_noteworthy == "clip_down") {
      clip ConnectPaths();
      clip trigger_off();
      pole.clip_down = clip;
    }
  }

  quake_event_pole_unlink_nodes();
}

quake_event_pole_fall_on_car(quakeTime, ent) {
  broken_base = GetEnt("pole_that_falls_on_cop_car_base", "targetname");
  if(isDefined(broken_base)) {
    broken_base Show();
  }

  pole = GetEnt("pole_that_falls_on_cop_car", "targetname");
  if(!isDefined(pole)) {
    return;
  }
  pole setModel("ls_telephone_pole_snap");

  pole playSound("scn_pole_fall");

  animated_prop = spawn("script_model", pole.origin);
  animated_prop setModel("generic_prop_raven");
  animated_prop.angles = pole.angles;

  pole LinkTo(animated_prop, "j_prop_1");

  animated_prop ScriptModelPlayAnimDeltaMotion("mp_lonestar_police_car_crush_pole");

  car_swap = GetNotetrackTimes( % mp_lonestar_police_car_crush_pole, "car_swap");
  anim_length = GetAnimLength( % mp_lonestar_police_car_crush_pole);

  wait car_swap[0] * anim_length;

  ent playSound("scn_police_car_crush");

  exploder(7);

  pole.clip_down trigger_on();
  pole.clip_down DisconnectPaths();
  quake_event_pole_link_nodes();
  pole.clip_up Delete();
  ent setModel("ls_police_sedan_smashed");

  foreach(character in level.characters) {
    if(character IsTouching(pole.clip_down)) {
      character maps\mp\_movers::mover_suicide();
    }
  }

}

quake_event_playSound(quakeTime, ent) {
  if(!isDefined(ent.script_sound)) {
    return;
  }
  playSoundAtPos(ent.origin, ent.script_sound);
}

quake_event_disconnect_node(quakeTime, node) {
  node DisconnectNode();
}

quake_event_connect_node(quakeTime, node) {
  node ConnectNode();
}

quake_event_disconnect_traverse(quakeTime, begin_node) {
  disconnect_traverse(begin_node);
}

disconnect_traverse(begin_node) {
  if(!isDefined(begin_node.end_nodes)) {
    begin_node.end_nodes = GetNodeArray(begin_node.target, "targetname");
  }

  foreach(end_node in begin_node.end_nodes) {
    DisconnectNodePair(begin_node, end_node, true);
  }
}

quake_event_connect_traverse(quakeTime, begin_node) {
  connect_traverse(begin_node);
}

connect_traverse(begin_node) {
  if(!isDefined(begin_node.end_nodes)) {
    begin_node.end_nodes = GetNodeArray(begin_node.target, "targetname");
  }

  foreach(end_node in begin_node.end_nodes) {
    ConnectNodePair(begin_node, end_node, true);
  }
}