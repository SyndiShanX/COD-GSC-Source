/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_dart_events.gsc
**************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#using_animtree("animated_props");

gas_station() {
  gas_station_precache();

  flag_init("gas_station_exploded");
  flag_init("breach_connect_nodes");

  wait 0.05;

  structs = getstructarray("gas", "targetname");
  array_thread(structs, ::gas_station_init);
}

gas_station_init() {
  target_ents = getEntArray(self.target, "targetname");
  target_structs = getstructarray(self.target, "targetname");
  target_ents = array_combine(target_ents, target_structs);
  nodes = self getLinknameNodes();
  targets = array_combine(target_ents, nodes);

  self.clip_up = [];
  self.clip_down = [];
  self.launch_ents = [];
  self.linked_ents = [];

  if(GetDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  foreach(target_ent in targets) {
    if(!isDefined(target_ent.script_noteworthy)) {
      continue;
    }
    if(!isDefined(target_ent.script_parameters))
      target_ent.script_parameters = "corner1_hit";

    switch (target_ent.script_noteworthy) {
      case "clip_up":
        self.clip_up[self.clip_up.size] = target_ent;
        self.linked_ents[self.linked_ents.size] = target_ent;
        break;
      case "clip_down_traverse":
        target_ent.nodisconnect = true;

      case "clip_down":
        self.clip_down[self.clip_down.size] = target_ent;
        target_ent SetAISightLineVisible(0);
        target_ent ConnectPaths();
        target_ent trigger_off();
        break;
      case "link_to_launch":
        self thread gas_station_run_func_on_notify(target_ent.script_parameters, ::gas_station_launch_ent, target_ent);
        self.launch_ents[self.launch_ents.size] = target_ent;

      case "link_to":
        self.linked_ents[self.linked_ents.size] = target_ent;
        break;
      case "fx":
        self thread gas_station_run_func_on_notify(target_ent.script_parameters, ::gas_station_play_fx, target_ent);
        break;
      case "animated":
        self.animated_model = target_ent;
        break;
      case "earthquake":
        self thread gas_station_run_func_on_notify(target_ent.script_parameters, ::gas_station_earthquake, target_ent);
        break;
      case "sound":
        self thread gas_station_run_func_on_notify(target_ent.script_parameters, ::gas_station_playSound, target_ent);
        break;
      case "connect_node":
        target_ent DisconnectNode();
        self thread gas_station_run_func_on_notify(target_ent.script_parameters, ::gas_station_connect_node, target_ent);
        break;
      case "disconnect_node":
        self thread gas_station_run_func_on_notify(target_ent.script_parameters, ::gas_station_disconnect_node, target_ent);
        break;
      case "prone_kill_trigger":
        self.prone_kill_trigger = target_ent;
        target_ent trigger_off();
        break;
      case "killcam":
        self.killCamEnt = spawn("script_model", target_ent.origin);
        self.killCamEnt setModel("tag_origin");
        break;
      default:
        break;
    }
  }

  if(isDefined(self.animated_model)) {
    foreach(ent in self.linked_ents) {
      ent LinkTo(self.animated_model, "j_awning_main");
    }
  }

  self thread care_package_watch();

  gas_pumps = GetScriptableArray("gaspump", "targetname");

  level.last_player_to_damage_gas_pump = undefined;
  level.player_who_caused_gas_station_explosion = undefined;

  foreach(pump in gas_pumps) {
    pump thread gas_pump_damage_monitor(self);
    pump thread notify_explode(self, gas_pumps);
  }

  self waittill("gas_station_explode", exploded_pump);

  flag_set("gas_station_exploded");
  foreach(player in level.players) {
    player.present_for_gas_station_explosion = true;
  }

  foreach(pump in gas_pumps) {
    if(pump == exploded_pump)
      continue;
    if(isDefined(level.player_who_caused_gas_station_explosion)) {
      pump.attacker = level.player_who_caused_gas_station_explosion;
      if(isDefined(level.player_who_caused_gas_station_explosion.team)) {
        pump.team = level.player_who_caused_gas_station_explosion.team;
      }
    }
    if(isDefined(pump.attacker)) {
      pump SetScriptableDamageOwner(pump.attacker);
    }
    pump SetScriptablePartState(0, "destroyed");
  }

  time = GetAnimLength(%mp_dart_gas_awning_fall);

  self.gas_station_events = [];

  self gas_station_add_event("start", 0.0);
  self gas_station_add_event("beam_break", 0.1);
  self gas_station_add_event("corner1_hit", 1.9);
  self gas_station_add_event("corner2_hit", 2.15);
  self gas_station_add_event("sign_hit", 2.5);
  self gas_station_add_event("end", time);

  self thread gas_station_run_func_on_notify("corner1_hit", ::gas_station_update_clip);

  self thread gas_station_run_events();

  if(isDefined(self.animated_model)) {
    self.animated_model ScriptModelPlayAnimDeltaMotion("mp_dart_gas_awning_fall");
    exploder(22);

    sound_origins = getEntArray("gas_pump_fire_sound_origin", "targetname");
    foreach(sound_origin in sound_origins) {
      sound_origin playLoopSound("emt_dart_fire_small_ext_lp");
    }
  }
}

gas_station_run_func_on_notify(note, func, param1) {
  self waittill(note);

  if(isDefined(param1)) {
    self thread[[func]](param1);
  } else {
    self thread[[func]]();
  }
}

gas_station_update_clip() {
  killcam_struct = getstruct("gas_station_killcam", "targetname");

  foreach(clip in self.clip_up) {
    clip SetAISightLineVisible(0);
    clip Delete();
  }

  foreach(clip in self.clip_down) {
    clip SetAISightLineVisible(1);

    clip.unresolved_collision_func = maps\mp\_movers::unresolved_collision_void;

    clip trigger_on();
    if(!isDefined(clip.nodisconnect) || !clip.nodisconnect)
      clip DisconnectPaths();

    foreach(character in level.characters) {
      if(character IsTouching(clip) && IsAlive(character)) {
        if(isDefined(self.attacker) && isDefined(self.attacker.team) && (self.attacker.team == character.team)) {
          character maps\mp\_movers::mover_suicide();
        } else {
          clip.killCamEnt = self.killCamEnt;

          if(isDefined(level.player_who_caused_gas_station_explosion)) {
            character DoDamage(character.health + 10000, character.origin, level.player_who_caused_gas_station_explosion, clip, "MOD_EXPLOSIVE");
          } else {
            character DoDamage(character.health + 10000, character.origin, self.attacker, clip, "MOD_EXPLOSIVE");
          }
        }
      }
    }

    foreach(vanguard in level.remote_uav) {
      if(vanguard IsTouching(clip)) {
        vanguard notify("death");
      }
    }
  }

  if(isDefined(self.prone_kill_trigger)) {
    self.prone_kill_trigger trigger_on();
    foreach(character in level.characters) {
      if(character IsTouching(self.prone_kill_trigger) && IsAlive(character)) {
        if(isDefined(self.attacker) && isDefined(self.attacker.team) && (self.attacker.team == character.team)) {
          character maps\mp\_movers::mover_suicide();
        } else {
          self.prone_kill_trigger.killCamEnt = self.killCamEnt;
          if(isDefined(level.player_who_caused_gas_station_explosion)) {
            character DoDamage(character.health + 20, character.origin, level.player_who_caused_gas_station_explosion, self.prone_kill_trigger, "MOD_EXPLOSIVE");
          } else {
            character DoDamage(character.health + 20, character.origin, self.attacker, self.prone_kill_trigger, "MOD_EXPLOSIVE");
          }
        }
      }
    }

    wait(10);
    self.prone_kill_trigger Delete();
  }

}

gas_station_launch_ent(ent) {
  angles = self.animated_model GetTagAngles("j_awning_main");
  launch_dir = AnglesToUp(angles);
  ent Unlink();

  org_offset = (RandomFloatRange(-1, 1), RandomFloatRange(-1, 1), 0);
  ent PhysicsLaunchClient(ent.origin + org_offset, launch_dir * 15000);
}

gas_station_play_fx(ent) {
  if(!isDefined(ent.script_fxid) || !isDefined(level._effect[ent.script_fxid])) {
    return;
  }
  playFX(level._effect[ent.script_fxid], ent.origin, anglesToForward(ent.angles));
}

gas_station_earthquake(ent) {
  Earthquake(0.3, .5, ent.origin, 800);
}

gas_station_playSound(ent) {
  if(!isDefined(ent.script_sound)) {
    return;
  }
  playSoundAtPos(ent.origin, ent.script_sound);
}

gas_station_connect_node(node) {
  node ConnectNode();
}

gas_station_disconnect_node(node) {
  node DisconnectNode();
}

gas_station_run_events() {
  start_time = GetTime();
  while(1) {
    foreach(event in self.gas_station_events) {
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
    wait 0.05;
  }
}

gas_station_add_event(note, time) {
  if(!isDefined(self.gas_station_events))
    self.gas_station_events = [];
  s = spawnStruct();
  s.time = time;
  s.note = note;
  s.done = false;

  self.gas_station_events[self.gas_station_events.size] = s;
}

gas_station_precache() {
  PrecacheMpAnim("mp_dart_gas_awning_fall");
}

gas_pump_damage_monitor(gas_station) {
  gas_station endon("gas_station_explode");

  self.killCamEnt = gas_station.killCamEnt;

  while(1) {
    self waittill("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);

    if(IsPlayer(attacker) || IsAgent(attacker)) {
      if(IsAgent(attacker) && isDefined(attacker.owner)) {
        attacker = attacker.owner;
      }

      level.last_player_to_damage_gas_pump = attacker;
      self SetScriptableDamageOwner(attacker);
    }
  }
}

notify_explode(gas_station, gas_pumps) {
  self waittill("death", attacker, mod, weapon);

  if(!isDefined(level.player_who_caused_gas_station_explosion)) {
    if(IsPlayer(attacker) || IsAgent(attacker)) {
      if(IsAgent(attacker) && isDefined(attacker.owner)) {
        attacker = attacker.owner;
      }

      level.player_who_caused_gas_station_explosion = attacker;
    } else if(isDefined(level.last_player_to_damage_gas_pump)) {
      level.player_who_caused_gas_station_explosion = level.last_player_to_damage_gas_pump;
    }
    self SetScriptableDamageOwner(level.player_who_caused_gas_station_explosion);
  }
  self.attacker = level.player_who_caused_gas_station_explosion;
  gas_station.attacker = level.player_who_caused_gas_station_explosion;
  if(isDefined(level.player_who_caused_gas_station_explosion.team)) {
    self.team = level.player_who_caused_gas_station_explosion.team;
    gas_station.team = level.player_who_caused_gas_station_explosion.team;
  }

  gas_station notify("gas_station_explode", self);
}

broken_walls() {
  walls = getstructarray("broken_wall", "targetname");
  array_thread(walls, ::broken_wall_init);
}

broken_wall_init(requires_explosive) {
  self.trigger_show = [];
  self.delete_ents = [];
  self.show_ents = [];
  self.trigger_damage = [];

  targets = getEntArray(self.target, "targetname");

  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy)) {
      target.script_noteworthy = target.classname;
    }

    switch (target.script_noteworthy) {
      case "delete":
        self.delete_ents[self.delete_ents.size] = target;
        break;
      case "trigger_damage":
        self.trigger_damage[self.trigger_damage.size] = target;
        self thread broken_wall_damage_watch(target);
        break;
      case "show":
        target Hide();
        self.show_ents[self.show_ents.size] = target;
        break;
      case "trigger_show":
        target trigger_off();
        self.trigger_show[self.trigger_show.size] = target;
        break;
      case "trigger_use_touch":
        target UseTriggerRequireLookAt();
        target.script_noteworthy = "trigger_use";
        break;
      default:
        break;
    }
  }
}

broken_wall_damage_watch(trigger, requires_explosive) {
  self endon("break_wall");

  trigger waittill("trigger");

  array_thread(self.show_ents, ::broken_wall_show);
  array_call(self.trigger_damage, ::Delete);

  array_thread(self.delete_ents, ::broken_wall_delete);
  array_thread(self.trigger_show, ::trigger_on);

  self notify("break_wall");
}

broken_wall_delete() {
  if(isDefined(self.script_index)) {
    exploder(self.script_index);
  }

  self SetAISightLineVisible(0);
  self Delete();
}

broken_wall_show() {
  self SetAISightLineVisible(1);
  self Show();
}

breach() {
  if(GetDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  maps\mp\_breach::breach_precache();
  dart_breach_precache();
  dart_breach_anims_init();
  waitframe();

  breaches = getstructarray("breach", "targetname");

  proxy = getstructarray("breach_proxy", "targetname");
  foreach(p in proxy) {
    if(!isDefined(p.target)) {
      continue;
    }
    breach = getstruct(p.target, "targetname");
    if(!isDefined(breach)) {
      continue;
    }
    breach = setExtraBreachExceptions(breach);

    breaches[breaches.size] = breach;
  }

  array_thread(breaches, ::breach_init);
  array_thread(breaches, maps\mp\_breach::breach_init);
}

setExtraBreachExceptions(breach) {
  if(!isDefined(breach.script_noteworthy))
    return breach;

  if(level.gametype == "siege")
    breach.script_noteworthy = breach.script_noteworthy + "," + "not_in_siege";

  return breach;
}

dart_breach_precache() {
  PrecacheMpAnim("mp_dart_container_breach_side1");
  PrecacheMpAnim("mp_dart_container_breach_side2");
  PrecacheMpAnim("mp_dart_container_breach_top");
  PrecacheMpAnim("mp_dart_container_idle_side1");
  PrecacheMpAnim("mp_dart_container_idle_side2");
  PrecacheMpAnim("mp_dart_container_idle_top");
}

dart_breach_anims_init() {
  level.breach_anims = [];
  level.breach_anims["mp_dart_container_breach_side1"] = "mp_dart_container_breach_side1";
  level.breach_anims["mp_dart_container_breach_side1_idle"] = "mp_dart_container_idle_side1";
  level.breach_anims["mp_dart_container_breach_side2"] = "mp_dart_container_breach_side2";
  level.breach_anims["mp_dart_container_breach_side2_idle"] = "mp_dart_container_idle_side2";
  level.breach_anims["mp_dart_container_breach_top"] = "mp_dart_container_breach_top";
  level.breach_anims["mp_dart_container_breach_top_idle"] = "mp_dart_container_idle_top";
}

breach_init() {
  self.animated_doors = [];
  self.care_packages = [];
  self.delete_ents = [];
  self.doors = [];
  self.notsolid_ents = [];
  self.solid_ents = [];

  target_ents = getEntArray(self.target, "targetname");
  target_structs = getstructarray(self.target, "targetname");

  targets = array_combine(target_structs, target_ents);

  foreach(target in targets) {
    if(isDefined(target.classname) && target.classname == "trigger_use_touch")
      add_to_bot_use_targets(target, 1.5);

    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "door":
        self.doors[self.doors.size] = target;
        self breach_door_init(target);
        break;
      case "triggers_with":
        if(isDefined(target.target)) {
          other_breach = getstruct(target.target, "targetname");
          if(isDefined(other_breach))
            self thread breach_other_watch(other_breach);
        }
        break;
      case "care_package":
        self.care_packages[self.care_packages.size] = target;
        break;
      case "animated_door":
        door = GetEnt(target.target, "targetname");
        self.animated_doors[self.animated_doors.size] = door;
        self breach_animated_door_init(door);
        break;
      default:
        break;
    }
  }

  foreach(door in self.doors) {
    self thread breach_close_door(door);
  }

  self thread breach_open_watch();
}

add_care_package(origin, angles, owner, owner_team, crateType, dropType) {
  if(!isDefined(dropType)) {
    dropType = "airdrop_assault";
    if(isDefined(crateType)) {
      possible_dropTypes = ["airdrop_assault", "airdrop_support"];
      foreach(possible_dropType in possible_dropTypes) {
        if(is_valid_crateType(possible_dropType, crateType)) {
          dropType = possible_dropType;
          break;
        }
      }
    }
  }

  if(!is_valid_dropType(dropType)) {
    return;
  }
  if(!isDefined(crateType)) {
    crateType = random(GetArrayKeys(level.crateTypes[dropType]));
  }

  if(!is_valid_crateType(dropType, crateType)) {
    return;
  }
  if(!isDefined(angles))
    angles = (0, 0, 0);

  dropCrate = spawn("script_model", origin);
  dropCrate setModel(maps\mp\killstreaks\_airdrop::get_friendly_crate_model());
  dropCrate.angles = angles;
  dropCrate.crateType = crateType;
  dropCrate.owner = owner;
  if(isDefined(owner_team)) {
    dropCrate.team = owner_team;
  } else {
    dropCrate.team = owner.team;
  }
  dropCrate.targetname = "care_package";
  dropCrate.droppingToGround = false;
  dropCrate.id = "care_package";

  dropCrate CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
  dropCrate thread entity_path_disconnect_thread(1.0);
  dropCrate PhysicsLaunchServer((0, 0, 0), (0, 0, 1));

  dropCrate thread[[level.crateTypes[dropType][crateType].func]](dropType);

  if(IsBot(owner)) {
    wait(0.1);
    owner notify("new_crate_to_take");
  }
}

is_valid_dropType(dropType) {
  if(!isDefined(dropType))
    return false;

  foreach(key, value in level.crateTypes) {
    if(key == dropType)
      return true;
  }

  return false;
}

is_valid_crateType(dropType, crateType) {
  if(!is_valid_dropType(dropType))
    return false;

  if(!isDefined(crateType))
    return false;

  foreach(key, value in level.crateTypes[dropType]) {
    if(key == crateType)
      return true;
  }

  return false;
}

breach_animated_door_init(door) {
  breach_struct = self;

  AssertEx(isDefined(door.script_noteworthy), "animated_door in breach without animation defined in door.script_noteworthy");
  if(isDefined(level.breach_anims[door.script_noteworthy + "_idle"])) {
    door ScriptModelPlayAnimDeltaMotion(level.breach_anims[door.script_noteworthy + "_idle"]);
  }

  door thread clear_attached_items(breach_struct);
}

clear_attached_items(breach_struct) {
  breach_struct waittill("breach_activated");
  self maps\mp\_movers::notify_moving_platform_invalid();
}

breach_door_init(door) {
  target_ents = getEntArray(door.target, "targetname");
  target_structs = getstructarray(door.target, "targetname");

  targets = array_combine(target_structs, target_ents);

  door_parts = [];
  pivot = undefined;
  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "open":
        door.open_pos = target;
        break;
      case "closed":
        door.closed_pos = target;
        break;
      case "door_part":
        door_parts[door_parts.size] = target;
        break;
      case "pivot":
        pivot = target;
        break;
      default:
        break;
    }
  }

  if(!isDefined(door.open_pos) || !isDefined(door.closed_pos) || !isDefined(pivot) || door_parts.size == 0)
    return false;

  door.closed_pos.move_angles = get_rotate_angle(door.open_pos.angles, door.closed_pos.angles, pivot.angles);
  door.open_pos.move_angles = -1 * door.closed_pos.move_angles;

  link_ent = spawn("script_model", pivot.origin);
  link_ent setModel("tag_origin");
  link_ent.angles = pivot.angles;

  foreach(ent in door_parts) {
    ent LinkTo(link_ent);
  }

  door.link_ent = link_ent;
  return true;
}

breach_other_watch(other) {
  other waittill("breach_activated", player, no_fx, breaching_team);
  self notify("breach_activated", player, no_fx, breaching_team);
}

breach_open_watch() {
  self waittill("breach_activated", player, no_fx, breaching_team);

  target_ents = getEntArray(self.target, "targetname");
  foreach(target_ent in target_ents) {
    if(isDefined(target_ent.classname) && target_ent.classname == "trigger_use_touch")
      remove_from_bot_use_targets(target_ent);
  }

  if(isDefined(player) && !isMLGMatch()) {
    foreach(package in self.care_packages) {
      crateType = random(["uplink_support", "deployable_vest", "deployable_ammo", "ball_drone_radar", "aa_launcher", "jammer", "ims"]);
      add_care_package(package.origin, package.angles, player, breaching_team, crateType);
    }
  }

  door_time = 0.2;

  foreach(door in self.doors) {
    self thread breach_open_door(door, door_time);
  }

  foreach(animated_door in self.animated_doors) {
    animated_door ScriptModelPlayAnimDeltaMotion(level.breach_anims[animated_door.script_noteworthy]);

    switch (animated_door.script_noteworthy) {
      case "mp_dart_container_breach_side1":
        playSoundAtPos(animated_door.origin, "scn_dart_trailer_breach_side");
        break;
      case "mp_dart_container_breach_side2":
        playSoundAtPos(animated_door.origin, "scn_dart_trailer_breach_side");
        break;
      case "mp_dart_container_breach_top":
        playSoundAtPos(animated_door.origin, "scn_dart_trailer_breach_top");
        break;
      default:
        break;
    }

  }

  wait door_time;

  array_call(self.notsolid_ents, ::NotSolid);
  array_call(self.delete_ents, ::Delete);

  array_call(self.solid_ents, ::Solid);
  foreach(ent in self.solid_ents) {
    ent Solid();
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(player IsTouching(ent)) {
          self thread breach_kill_player(player);
        }
      }
    }
  }

  flag_set("breach_connect_nodes");
}

breach_kill_player(player) {
  RadiusDamage(player.origin, 8, 1000, 1000, self.owner, "MOD_CRUSH");
}

breach_open_door(door, time) {
  breach_move_door(door, door.open_pos, time);
}

breach_close_door(door, time) {
  breach_move_door(door, door.closed_pos, time);
}

breach_move_door(door, pos, time) {
  angles = pos.angles;
  origin = pos.origin;

  if(isDefined(time) && time > 0) {
    if(isDefined(angles) && angles != door.link_ent.angles)
      door.link_ent RotateBy(pos.move_angles, time, time);
    if(isDefined(origin) && origin != door.link_ent.origin)
      door.link_ent MoveTo(origin, time);
  } else {
    if(isDefined(angles))
      door.link_ent.angles = angles;
    if(isDefined(origin))
      door.link_ent.origin = origin;
  }
}

is_explosive(cause) {
  if(!isDefined(cause))
    return false;

  cause = ToLower(cause);
  switch (cause) {
    case "mod_grenade_splash":
    case "mod_projectile_splash":
    case "mod_explosive":
    case "splash":
      return true;
    default:
      return false;
  }
  return false;
}

normalize_angles_180(angles) {
  return (AngleClamp180(angles[0]), AngleClamp180(angles[1]), AngleClamp180(angles[2]));
}

get_rotate_angle(start, end, through) {
  delta = end - start;
  delta = normalize_angles_180(delta);

  if(isDefined(through)) {
    dir = through - start;
    dir = normalize_angles_180(dir);

    for(i = 0; i < 3; i++) {
      if(dir[i] * delta[i] < 0) {
        change = 360;
        if(dir[i] < 0)
          change = -360;
        delta = (delta[0] + (change * (i == 0)), delta[1] + (change * (i == 1)), delta[2] + (change * (i == 2)));
      }
    }
  }

  return delta;
}

ceiling_rubble() {
  level thread ceiling_rubble_onPlayerConnect();
  wait 0.05;

  if(!isDefined(level.fx_tag_origin))
    level.fx_tag_origin = spawn_tag_origin();

  rubbles = [];

  fxvolumes = getEntArray("fx_building_impact", "targetname");

  level thread do_rubble(fxvolumes);
}

wait_and_trigger_fx() {
  wait(RandomFloatRange(0.0, 0.4));
  TriggerFX(self);
}

do_rubble(fxvolumes) {
  while(1) {
    level waittill("do_rubble", position);

    foreach(volume in fxvolumes) {
      if(isDefined(volume.script_index)) {
        level.fx_tag_origin.origin = position;
        if(level.fx_tag_origin IsTouching(volume)) {
          if(isDefined(volume.script_index)) {
            if(!isDefined(volume.playing_effect))
              volume.playing_effect = false;
            if(volume.playing_effect == false) {
              volume.playing_effect = true;
              exploder(volume.script_index);

              volume thread clear_volume_flag();
            }
          }
        }
      }
    }

  }
}

clear_volume_flag() {
  wait(1.5);
  self.playing_effect = false;
}

ceiling_rubble_onPlayerConnect() {
  while(1) {
    level waittill("connected", player);
    player thread ceiling_rubble_watchUsage("missile_fire");
    player thread ceiling_rubble_watchUsage("grenade_fire");
  }
}

ceiling_rubble_watchUsage(note) {
  self endon("disconnect");

  while(1) {
    self waittill(note, missile, weaponName);

    if(isDefined(weaponName)) {
      switch (weaponName) {
        case "ac130_25mm_mp":
        case "flash_grenade_mp":
        case "concussion_grenade_mp":
        case "smoke_grenade_mp":
        case "smoke_grenadejugg_mp":
          continue;

        default:
          break;
      }

    }

    missile thread ceiling_rubble_missile_explode_watch();
  }
}

endOnDeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_of_frame_death");
}

ceiling_rubble_missile_explode_watch() {
  self thread endOnDeath();
  self endon("end_of_frame_death");
  self waittill("explode", position);
  level notify("do_rubble", position);
}

search_bot() {
  while(!isDefined(level.players) || level.players.size == 0)
    wait 0.05;

  allnodes = GetAllNodes();
  current_node = random(allnodes);
  player = level.players[0];

  search_bot = spawn("script_model", current_node.origin);
  search_bot setModel("com_deploy_ballistic_vest_friend_world");

  while(1) {
    path_nodes = GetNodesOnPath(current_node.origin, player.origin);
    if(!isDefined(path_nodes) || path_nodes.size == 0) {
      wait 0.1;
      continue;
    }

    goal_node = path_nodes[0];
    if(Distance(search_bot.origin, path_nodes[0].origin) < 6) {
      if(path_nodes.size <= 1) {
        wait 0.1;
        continue;
      }
      goal_node = path_nodes[1];
    }
    dir = goal_node.origin - current_node.origin;
    dir_angles = VectorToAngles(dir);

    speed = 180;
    dist = Length(dir);
    time = dist / speed;

    if(time <= 0) {
      wait 0.1;
      continue;
    }

    search_bot RotateTo(dir_angles, min(0.5, time));
    search_bot MoveTo(goal_node.origin, time);
    search_bot waittill("movedone");
    current_node = goal_node;
  }

}

player_connect_watch() {
  while(1) {
    level waittill("connected", player);
    if(flag("gas_station_exploded")) {
      hide_gas_station_physics_pieces();
    }
  }
}

hide_gas_station_physics_pieces() {
  structs = getstructarray("gas", "targetname");
  foreach(struct in structs) {
    foreach(ent in struct.launch_ents) {
      ent Hide();
      foreach(player in level.players) {
        if(isDefined(player.present_for_gas_station_explosion) && (player.present_for_gas_station_explosion == true)) {
          ent ShowToPlayer(player);
        }
      }
    }
  }
}

care_package_watch() {
  self endon("end");

  watch_volume = GetEnt("care_package_volume", "targetname");

  flag_wait("gas_station_exploded");

  care_packages = level.carePackages;
  if(isDefined(care_packages)) {
    foreach(package in care_packages) {
      if(isDefined(package.inUse) && package.inUse) {
        continue;
      }
      if((isDefined(package.droppingtoground) && !package.droppingtoground) && (isDefined(package.friendlyModel) && package.friendlyModel IsTouching(watch_volume))) {
        owner = package.owner;
        dropType = package.dropType;
        crateType = package.crateType;
        origin = package.origin;

        package maps\mp\killstreaks\_airdrop::deleteCrate();

        newCrate = owner maps\mp\killstreaks\_airdrop::createAirDropCrate(owner, dropType, crateType, origin + (0, 0, 250), origin + (0, 0, 250));
        newCrate.droppingtoground = true;

        newCrate thread[[level.crateTypes[newCrate.dropType][newCrate.crateType].func]](newCrate.dropType);

        waitframe();

        newCrate CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
        newCrate thread entity_path_disconnect_thread(1.0);
        newCrate PhysicsLaunchServer(newCrate.origin, (0, -20000, 20000));

        if(IsBot(newCrate.owner)) {
          wait(0.1);
          newCrate.owner notify("new_crate_to_take");
        }
      }
    }
  }
}

deleteOnOwnerDeath(owner) {
  wait(0.25);
  self LinkTo(owner, "tag_origin", (0, 0, 0), (0, 0, 0));

  owner waittill("death");

  self Delete();
}

container_pathnode_watch() {
  node_array = GetNodeArray("disconnect_until_container_opens", "targetname");

  foreach(pathnode in node_array) {
    pathnode DisconnectNode();
  }

  flag_wait("breach_connect_nodes");

  foreach(pathnode in node_array) {
    pathnode ConnectNode();
  }
}