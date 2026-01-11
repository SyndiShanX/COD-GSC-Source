/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_breach.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

main() {
  thread main_thread();
}

main_thread() {
  breach_precache();
  waitframe();

  breach = getstructarray("breach", "targetname");
  array_thread(breach, ::breach_init);
}

breach_precache() {
  level.breach_icon_count = -1;

  level._effect["default"] = loadfx("fx/explosions/breach_room_cheap");
}

breach_init() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  if(!isDefined(self.target)) {
    return;
  }
  self.breach_targets = [];
  self.auto_breach_gametypes = [];

  if(isDefined(self.script_noteworthy)) {
    toks = StrTok(self.script_noteworthy, ",");
    foreach(tok in toks) {
      if(GetSubStr(tok, 0, 7) == "not_in_") {
        self.auto_breach_gametypes[self.auto_breach_gametypes.size] = GetSubStr(tok, 7, tok.size);
      }

      if(tok == "only_if_allowClassChoice") {
        if(!allowClassChoice()) {
          self.auto_breach_gametypes[self.auto_breach_gametypes.size] = level.gameType;
        }
      }
    }
  }

  ents = getEntArray(self.target, "targetname");
  structs = getstructarray(self.target, "targetname");
  targets = array_combine(ents, structs);
  nodes = self getLinknameNodes();
  foreach(node in nodes) {
    node.isPathNode = true;
  }
  targets = array_combine(targets, nodes);

  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy)) {
      target.script_noteworthy = target.classname;
    }

    if(target.script_noteworthy == "trigger_use_touch") {
      target UseTriggerRequireLookAt();
      target.script_noteworthy = "trigger_use";
    }
    if(!isDefined(target.isPathNode) || target.isPathNode == false) {
      target.script_noteworthy = ToLower(target.script_noteworthy);
    }
    types = StrTok(target.script_noteworthy, ", ");

    foreach(type in types) {
      event_name = undefined;
      toks = StrTok(type, "_");
      if(toks.size >= 3 && toks[toks.size - 2] == "on") {
        event_name = toks[toks.size - 1];
        type = toks[0];
        for(i = 1; i < toks.size - 2; i++) {
          type = type + "_" + toks[i];
        }
      }

      useSide = false;
      toks = StrTok(type, "_");
      if(toks.size >= 2 && toks[toks.size - 1] == "useside") {
        useSide = true;
        type = toks[0];
        for(i = 1; i < toks.size - 2; i++) {
          type = type + "_" + toks[i];
        }
      }

      add_breach_target(target, type, event_name, useSide);

      switch (type) {
        case "show":
        case "animated":
          target Hide();
          break;
        case "solid":
          if(isDefined(target.spawnflags) && (target.spawnflags & 2)) {
            target SetAISightLineVisible(0);
          }
          target NotSolid();
          break;
        case "teleport_show":
          target trigger_off();
          break;
        case "use_icon":

          break;
        case "trigger_damage":
          self thread breach_damage_watch(target);
          break;
        case "fx":
          if(!isDefined(target.angles)) {
            target.angles = (0, 0, 0);
          }
          break;
        case "connect_node":
          target DisconnectNode();
          break;
        case "disconnect_node":
          target ConnectNode();
          break;
        case "delete":
          if(isDefined(target.spawnflags) && (target.spawnflags & 2)) {
            target SetAISightLineVisible(1);
          }
          break;
        default:
          break;
      }
    }
  }

  if(level.createFX_enabled) {
    return;
  }
  use_trigger = get_breach_target("trigger_use");
  if(isDefined(use_trigger)) {
    if(!isDefined(get_breach_target("sound"))) {
      script_origin = spawn("script_origin", use_trigger.origin);
      add_breach_target(script_origin, "sound");
    }
    if(!isDefined(get_breach_target("damage"))) {
      damage = spawnStruct();
      damage.origin = use_trigger.origin;
      add_breach_target(damage, "damage");
    }

    damages = get_breach_targets("damage");
    foreach(damage in damages) {
      if(!isDefined(damage.radius)) {
        damage.radius = 128;
      }
      if(!isDefined(damage.max_damage)) {
        damage.max_damage = 100;
      }
      if(!isDefined(damage.min_damage)) {
        damage.min_damage = 1;
      }
    }
    self thread breach_use_watch();
  }

  self thread breach_on_activate();

  self breach_on_event("init");

  foreach(type in self.auto_breach_gametypes) {
    if(level.gametype == type) {
      self notify("breach_activated", undefined, true);
      break;
    }
  }

}

add_breach_target(target, action, event_name, useSide) {
  if(!isDefined(event_name)) {
    event_name = "activate";
  }
  if(!isDefined(useSide)) {
    useSide = false;
  }

  if(!isDefined(self.breach_targets[event_name])) {
    self.breach_targets[event_name] = [];
  }

  if(!isDefined(self.breach_targets[event_name][action])) {
    self.breach_targets[event_name][action] = [];
  }

  s = spawnStruct();
  s.target = target;

  if(useSide) {
    s.facing_dot = 0;
    s.facing_angles3d = false;
    s.facing_dir = anglesToForward(target.angles);

    if(isDefined(target.target)) {
      target_targets = getstructarray(target.target, "targetname");
      foreach(target_target in target_targets) {
        if(!isDefined(target_target.script_noteworthy)) {
          continue;
        }
        switch (target_target.script_noteworthy) {
          case "angles":
          case "angles_3d":
            s.facing_angles3d = true;

          case "angles_2d":
            if(!isDefined(s.angles3d)) {
              s.facing_angles3d = false;
            }
            s.facing_dir = anglesToForward(target_target.angles);
            if(isDefined(target_target.script_dot)) {
              s.facing_dot = target_target.script_dot;
            }
            break;
          default:
            break;
        }
      }
    }
  }

  size = self.breach_targets[event_name][action].size;
  self.breach_targets[event_name][action][size] = s;
}

get_breach_target(action, event_name, player) {
  targets = get_breach_targets(action, event_name, player);
  if(targets.size > 0) {
    return targets[0];
  } else {
    return undefined;
  }
}

get_breach_targets(action, event_name, player) {
  targets = [];

  if(!isDefined(event_name)) {
    event_name = "activate";
  }

  if(!isDefined(self.breach_targets[event_name])) {
    return targets;
  }
  if(!isDefined(self.breach_targets[event_name][action])) {
    return targets;
  }

  foreach(s in self.breach_targets[event_name][action]) {
    if(isDefined(s.facing_dir) && isDefined(player)) {
      player_dir = player.origin - s.target.origin;
      if(!s.facing_angles3d) {
        player_dir = (player_dir[0], player_dir[1], 0);
      }
      player_dir = VectorNormalize(player_dir);

      dot = VectorDot(player_dir, s.facing_dir);
      if(dot < s.facing_dot) {
        continue;
      }
    }

    targets[targets.size] = s.target;
  }

  return targets;
}

breach_damage_watch(trigger) {
  self endon("breach_activated");

  trigger waittill("trigger", player);

  self notify("breach_activated", player, false);
}

breach_on_activate() {
  self waittill("breach_activated", player, no_fx);
  if(!isDefined(no_fx)) {
    no_fx = false;
  }

  if(isDefined(self.useObject) && !no_fx) {
    self.useObject breach_set_2dIcon("hud_grenadeicon_back_red");
    self.useObject delayThread(3, ::breach_set_2dIcon, undefined);
  }

  breach_on_event("activate", player, no_fx);

  if(isDefined(self.useObject)) {
    self.useObject.visuals = [];
  }

  breach_set_can_use(false);
}

breach_on_event(event_name, player, no_fx) {
  if(!isDefined(no_fx)) {
    no_fx = false;
  }

  if(event_name == "use") {
    targets = get_breach_targets("damage", "activate", player);
    foreach(target in targets) {
      target.planted = true;
    }
  }

  array_call(get_breach_targets("solid", event_name, player), ::Solid);
  array_call(get_breach_targets("notsolid", event_name, player), ::NotSolid);
  array_thread(get_breach_targets("hide", event_name, player), ::breach_hide);
  array_thread(get_breach_targets("show", event_name, player), ::breach_show);
  array_thread(get_breach_targets("teleport_show", event_name, player), ::trigger_on);
  array_thread(get_breach_targets("delete", event_name, player), ::breach_delete);
  array_thread(get_breach_targets("teleport_hide", event_name, player), ::trigger_off);
  array_call(get_breach_targets("connect_node", event_name, player), ::ConnectNode);
  array_call(get_breach_targets("disconnect_node", event_name, player), ::DisconnectNode);
  array_thread(get_breach_targets("break_glass", event_name, player), ::breach_break_glass);
  array_thread(get_breach_targets("animated", event_name, player), ::breach_animate_model);

  if(!no_fx) {
    array_thread(get_breach_targets("fx", event_name, player), ::breach_play_fx, self);
    array_thread(get_breach_targets("damage", event_name, player), ::breach_damage_radius, player);
  }
}

breach_delete() {
  if(isDefined(self.script_index)) {
    exploder(self.script_index);
  }

  self SetAISightLineVisible(0);
  self delete();
}

breach_hide() {
  self SetAISightLineVisible(0);
  self Hide();
}

breach_show() {
  self SetAISightLineVisible(1);
  self Show();
}

breach_play_fx(root) {
  fx_name = undefined;
  if(isDefined(self.script_fxid)) {
    fx_name = self.script_fxid;
  } else if(isDefined(root.script_fxid)) {
    fx_name = root.script_fxid;
  }

  if(!isDefined(fx_name) || !isDefined(level._effect[fx_name])) {
    fx_name = "default";
  }

  playFX(level._effect[fx_name], self.origin, anglesToForward(self.angles), AnglesToUp(self.angles));
}

breach_damage_radius(attacker) {
  stuntime = 2.0;

  if(isDefined(self.planted) && (self.planted == true)) {
    foreach(participant in level.participants) {
      participant_to_breach_dist_sq = DistanceSquared(self.origin, participant.origin);
      if(participant_to_breach_dist_sq < (self.radius * self.radius)) {
        participant ShellShock("mp_radiation_high", stuntime);
      }
    }
  }

  PlayRumbleOnPosition("artillery_rumble", self.origin);
}

breach_break_glass() {
  GlassRadiusDamage(self.origin, 128, 500, 500);
}

breach_animate_model() {
  self SetAISightLineVisible(1);
  self Show();

  if(isDefined(self.animation)) {
    self ScriptModelPlayAnim(self.animation);
  }
}

breach_use_watch() {
  self endon("breach_activated");
  wait .05;

  self.useObject = maps\mp\gametypes\_gameobjects::createUseObject("neutral", get_breach_target("trigger_use"), get_breach_targets("use_model"), (0, 0, 0));
  self.useObject.parent = self;
  self.useObject.useWeapon = "breach_plant_mp";
  self.useObject.id = "breach";

  self breach_set_can_use(true);
  self.useObject maps\mp\gametypes\_gameobjects::setUseTime(0.5);
  self.useObject maps\mp\gametypes\_gameobjects::setUseText(&"MP_BREACHING");
  self.useObject maps\mp\gametypes\_gameobjects::setUseHintText(&"MP_BREACH");
  self.useObject maps\mp\gametypes\_gameobjects::setVisibleTeam("any");
  self.useObject.onUse = ::breach_onUse;
  self.useObject.onEndUse = ::breach_onEndUse;
}

breach_set_can_use(canUse) {
  if(!isDefined(self.useObject)) {
    return;
  }

  if(canUse) {
    foreach(vis in self.useObject.visuals) {
      if(vis.model == "mil_semtex_belt") {
        vis setModel("mil_semtex_belt_obj");
      }
    }
    self.useObject maps\mp\gametypes\_gameobjects::allowUse("any");
  } else {
    foreach(vis in self.useObject.visuals) {
      if(vis.model == "mil_semtex_belt") {
        vis setModel("mil_semtex_belt");
      }
    }
    self.useObject notify("disabled");
    self.useObject maps\mp\gametypes\_gameobjects::allowUse("none");
  }
}

breach_onUse(player) {
  self.parent endon("breach_activated");

  self.parent notify("breach_used");
  self.parent breach_set_can_use(false);

  self.parent breach_on_event("use", player);

  self.parent thread breach_warning_icon(self);

  sound_ent = undefined;
  sound_targets = self.parent get_breach_targets("sound");
  if(sound_targets.size > 1) {
    sound_targets = SortByDistance(sound_targets, player.origin);
    sound_ent = sound_targets[0];
  } else if(sound_targets.size > 0) {
    sound_ent = sound_targets[0];
  }

  breaching_team = player.team;

  if(isDefined(sound_ent)) {
    for(i = 0; i < 3; i++) {
      sound_ent playSound("breach_beep");
      wait .75;
    }

    if(isDefined(sound_ent.script_parameters)) {
      params = StrTok(sound_ent.script_parameters, ";");
      foreach(param in params) {
        toks = StrTok(param, "=");
        if(toks.size < 2) {
          continue;
        }

        switch (toks[0]) {
          case "play_sound":
            switch (toks[1]) {
              case "concrete":
                sound_ent playSound("detpack_explo_concrete");
                break;
              case "wood":
                sound_ent playSound("detpack_explo_wood");
                break;
              case "custom":
                if(toks.size == 3) {
                  sound_ent playSound(toks[2]);
                }
                break;
              case "metal":
              case "undefined":
              default:
                sound_ent playSound("detpack_explo_metal");
                break;
            }
            break;
          default:
            break;
        }
      }

    } else {
      sound_ent playSound("detpack_explo_metal");
    }
  }

  self.parent notify("breach_activated", player, undefined, breaching_team);
}

breach_onEndUse(team, player, success) {
  if(IsPlayer(player)) {
    player maps\mp\gametypes\_gameobjects::updateUIProgress(self, false);
  }
}

breach_set_2dIcon(icon) {
  self maps\mp\gametypes\_gameobjects::set2DIcon("enemy", icon);
  self maps\mp\gametypes\_gameobjects::set2DIcon("friendly", icon);
}

breach_warning_icon(useObject) {
  icon_origin = useObject.curOrigin + (0, 0, 5);
  if(useobject.parent get_breach_targets("use_icon").size) {
    icon_origin = useobject.parent get_breach_targets("use_icon")[0].origin;
  }

  useObject.parent thread breach_icon("warning", icon_origin, undefined, "breach_activated");
}

breach_icon(type, origin, angles, end_ons) {
  if(level.createFX_enabled) {
    return;
  }
  level.breach_icon_count++;

  icon_id = "breach_icon_" + level.breach_icon_count;

  breach_icon_update(type, origin, angles, icon_id, end_ons);

  foreach(player in level.players) {
    if(isDefined(player.breach_icons) && isDefined(player.breach_icons[icon_id])) {
      player.breach_icons[icon_id] thread breach_icon_fade_out();
    }
  }
}

breach_icon_update(type, origin, angles, icon_id, end_ons) {
  if(isDefined(end_ons)) {
    if(IsString(end_ons)) {
      end_ons = [end_ons];
    }

    foreach(end_on in end_ons) {
    self endon(end_on);
    }
  }

  show_dist = 100;
  show_z = 70;
  icon = "hud_grenadeicon";
  pin = true;
  switch (type) {
    case "use":
      show_dist = 300;
      icon = "breach_icon";
      pin = false;
      break;
    case "warning":
      show_dist = 400;
      damage_info = get_breach_target("damage");
      if(isDefined(damage_info)) {
        show_dist = damage_info.radius;
      }
      icon = "hud_grenadeicon";
      pin = true;
      break;
    default:
      break;
  }

  show_dir = undefined;
  if(isDefined(angles)) {
    show_dir = anglesToForward(angles);
  }

  while(1) {
    foreach(player in level.players) {
      if(!isDefined(player.breach_icons)) {
        player.breach_icons = [];
      }

      if(breach_icon_update_is_player_in_range(player, origin, show_dist, show_dir, show_z)) {
        if(!isDefined(player.breach_icons[icon_id])) {
          player.breach_icons[icon_id] = breach_icon_create(player, icon, origin, pin);
          player.breach_icons[icon_id].alpha = 0;
        }

        player.breach_icons[icon_id] notify("stop_fade");
        player.breach_icons[icon_id] thread breach_icon_fade_in();
      } else {
        if(isDefined(player.breach_icons[icon_id])) {
          player.breach_icons[icon_id] thread breach_icon_fade_out();
        }
      }
    }
    wait 0.05;
  }
}

breach_icon_update_is_player_in_range(player, origin, show_dist, show_dir, show_z) {
  test_origin = player.origin + (0, 0, 30);

  if(isDefined(show_z) && abs(test_origin[2] - origin[2]) > show_z) {
    return false;
  }

  if(isDefined(show_dist)) {
    show_dist_sqr = show_dist * show_dist;
    dist_sqr = DistanceSquared(test_origin, origin);
    if(dist_sqr > show_dist_sqr) {
      return false;
    }
  }

  if(isDefined(show_dir)) {
    dir_to_player = test_origin - origin;

    if(VectorDot(show_dir, dir_to_player) < 0) {
      return false;
    }
  }

  return true;
}

breach_icon_create(player, icon, origin, pin) {
  icon = player createIcon(icon, 16, 16);
  icon setWayPoint(true, pin);
  icon.x = origin[0];
  icon.y = origin[1];
  icon.z = origin[2];
  return icon;
}

breach_icon_fade_in() {
  self endon("death");

  if(self.alpha == 1) {
    return;
  }
  self FadeOverTime(.5);
  self.alpha = 1;
}

breach_icon_fade_out() {
  self endon("death");
  self endon("stop_fade");

  if(self.alpha == 0) {
    return;
  }
  time = .5;
  self FadeOverTime(time);
  self.alpha = 0;
  wait time;

  self Destroy();
}