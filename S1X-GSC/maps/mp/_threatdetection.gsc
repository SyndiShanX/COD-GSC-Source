/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_threatdetection.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

init() {
  level._threatdetection = spawnStruct();
  level._threatdetection.default_style = "stencil_outline";

  SetDevDvarIfUninitialized("threat_detection_mark_time", 3);
  SetDevDvarIfUninitialized("threat_detection_highlight_style", level._threatdetection.default_style);

  level._threatdetection.activeStyle = GetDvar("threat_detection_highlight_style", level._threatdetection.default_style);
  level thread onPlayerConnect();
  level thread watchAgentspawn();
}

changeThreatStyle(threatStyle) {
  if(threatStyle == level._threatdetection.activeStyle) {
    return;
  }

  foreach(p in level.players) {
    if(isDefined(p._threatdetection.mark_enemy_model)) {
      p._threatdetection.mark_enemy_model Delete();
    }

    if(isDefined(p._threatdetection.mark_friendly_model)) {
      p._threatdetection.mark_friendly_model Delete();
    }

    if(isDefined(p.mark_fx) && isDefined(p.mark_fx.fx_ent)) {
      foreach(i, fx in p.mark_fx.fx_ent) {
        if(isDefined(fx.enemyMarker)) {
          fx.enemyMarker Delete();
        }

        if(isDefined(fx.friendlyMarker)) {
          fx.friendlyMarker Delete();
        }

        if(isDefined(fx.enemyLosMarker)) {
          fx.enemyLosMarker Delete();
        }

        if(isDefined(fx.friendlyLosMarker)) {
          fx.friendlyLosMarker Delete();
        }
      }
    }

  }

  foreach(p in level.players) {
    p threat_init(threatStyle);
  }

  level._threatdetection.activeStyle = threatStyle;
}

GetThreatStyle() {
  threatStyle = GetDvar("threat_detection_highlight_style", level._threatdetection.default_style);
  if(threatStyle != level._threatdetection.activeStyle) {
    changeThreatStyle(threatStyle);
  }
  return threatStyle;
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);
    player thread onPlayerSpawned();
  }
}

watchAgentspawn() {
  while(true) {
    level waittill("spawned_agent", agent);
    agent._threatdetection = spawnStruct();
    agent._threatdetection.showlist = [];
    agent thread onAgentSpawned();
  }
}

onAgentSpawned() {
  self endon("death");
  self childthread monitorThreatHighlight();
  self childthread cleanUpOnDeath();
}

onPlayerSpawned() {
  self endon("disconnect");

  self._threatdetection = spawnStruct();
  self._threatdetection.showlist = [];
  self waittill("spawned_player");

  childthread monitorThreatHighlight();
  childthread cleanUpOnDeath();

  childthread monitorThreatHighlightNotification();

  while(1) {
    self waittill("spawned_player");

    threatStyle = GetThreatStyle();
    if(threatStyle == "attached_glow") {
      visitFXEnt(::visitorRelink, ::getHostileMarker, undefined);
    }
  }
}

monitorThreatHighlightNotification() {
  notification_overlay_element = NewClientHudElem(self);
  notification_overlay_element.x = 0;
  notification_overlay_element.y = 0;
  notification_overlay_element.alignX = "left";
  notification_overlay_element.alignY = "top";
  notification_overlay_element.horzAlign = "fullscreen";
  notification_overlay_element.vertAlign = "fullscreen";
  notification_overlay_element SetShader("paint_overlay", 640, 480);
  notification_overlay_element.alpha = 0.0;
  notification_overlay_element.color = (0, 0, 0);
  notification_overlay_element.sort = -3;

  Assert(!isDefined(notification_overlay_element.hidden));

  notification_overlay_element.hidden = true;

  FadeInTime = 0.5;
  FadeOutTime = .3;

  while(1) {
    AssertEx(isDefined(self._threatdetection), "_threatdetection isn't defined");

    if(self._threatdetection.showlist.size != 0) {
      if(notification_overlay_element.hidden) {
        notification_overlay_element.hidden = false;
        notification_overlay_element childthread threatNotificationOverlayFlash(FadeInTime, FadeOutTime);
      }
    } else {
      if(!notification_overlay_element.hidden) {
        notification_overlay_element.hidden = true;
        notification_overlay_element notify("stop_overlay_flash");

        if(notification_overlay_element.alpha > 0.0) {
          notification_overlay_element FadeOverTime(FadeOutTime);
          notification_overlay_element.color = (0, 0, 0);
          notification_overlay_element.alpha = 0.0;
          wait(FadeOutTime);
        }

      }
    }

    wait(0.05);
  }
}

threatNotificationOverlayFlash(FadeInTime, FadeOutTime) {
  self endon("stop_overlay_flash");

  self FadeOverTime(FadeInTime);
  self.color = (1, 1, 1);
  self.alpha = 1.0;
}

debugHelper() {
  while(1) {
    dist = Distance(self.origin, level.players[0].origin);
    Print3d(self.origin + (0, 0, 64), dist);
    thread draw_line_for_time(level.players[0].origin, self.origin, 1, 1, 1, 0.3);
    if(isDefined(self._threatdetection.mark_enemy_model)) {
      thread draw_line_for_time(level.players[0].origin, self._threatdetection.mark_enemy_model.origin, 1, 1, 1, 0.3);
    }
    wait 0.3;
  }
}

cleanUpOnDeath() {
  self endon("disconnect");

  while(1) {
    self waittill("death");
    self removeThreatEvents();
  }
}

removeThreatEvents() {
  foreach(player in level.players) {
    foreach(obj in player._threatdetection.showlist) {
      if(obj.player == self) {
        obj.endTime = 0;
      }
    }
  }

  threatStyle = GetThreatStyle();
  if(threatStyle == "attached_glow") {
    visitFXEnt(::visitorHideAll, ::getHostileMarker, undefined);
  }
}

detection_highlight_hud_effect_on(player, duration, bLessIntense) {
  Assert(isDefined(player));

  radar_highlight = NewClientHudElem(player);

  if(isDefined(bLessIntense) && bLessIntense) {
    radar_highlight.color = (0.1, 0.0015, 0.0015);
  } else {
    radar_highlight.color = (1.0, 0.015, 0.015);
  }

  radar_highlight.alpha = 1.0;

  radar_highlight SetRadarHighlight(duration);

  return radar_highlight;
}

detection_highlight_hud_effect_off(radar_highlight) {
  if(isDefined(radar_highlight)) {
    radar_highlight Destroy();
  }
}

detection_highlight_hud_effect(player, duration, bLessIntense, playerEndonString) {
  radar_highlight = detection_highlight_hud_effect_on(player, duration, bLessIntense);

  if(isDefined(playerEndonString)) {
    player waittill_notify_or_timeout(playerEndonString, duration);
  } else {
    wait duration;
  }

  detection_highlight_hud_effect_off(radar_highlight);
}

detection_grenade_hud_effect(player, position, duration, radius) {
  Assert(isDefined(player));

  radar_ping = NewHudElem();

  radar_ping.x = position[0];
  radar_ping.y = position[1];
  radar_ping.z = position[2];

  SetDevDvarIfUninitialized("scr_paintexplosionalpha", 1.0);
  SetDevDvarIfUninitialized("scr_paintexplosionred", 1.0);
  SetDevDvarIfUninitialized("scr_paintexplosiongreen", 0.015);
  SetDevDvarIfUninitialized("scr_paintexplosionblue", 0.015);
  SetDevDvarIfUninitialized("scr_paintexplosionwidth", 500);

  radar_ping.color = (GetDvarFloat("scr_paintexplosionred"), GetDvarFloat("scr_paintexplosiongreen"), GetDvarFloat("scr_paintexplosionblue"));
  radar_ping.alpha = GetDvarFloat("scr_paintexplosionalpha");

  width = GetDvarInt("paintexplosionwidth");

  radar_ping SetRadarPing(int(radius + width / 2), int(width), duration + .05);

  wait duration;

  if(isDefined(radar_ping)) {
    radar_ping Destroy();
  }
}

exo_ping_hud_effect(position, duration, radius, player, bLessIntense) {
  radar_ping = undefined;
  if(isDefined(player)) {
    radar_ping = NewClientHudElem(player);
  } else {
    radar_ping = NewHudElem();
  }

  radar_ping.x = position[0];
  radar_ping.y = position[1];
  radar_ping.z = position[2];

  SetDevDvarIfUninitialized("scr_exopingwidth", 100);

  if(isDefined(bLessIntense) && bLessIntense) {
    radar_ping.color = (0.05, 0.05, 0.05);
  } else {
    radar_ping.color = (0.8, 0.8, 0.8);
  }

  radar_ping.alpha = 0.05;

  width = GetDvarInt("scr_exopingwidth", 100);

  radar_ping SetRadarPing(int(radius), int(width), duration + .05);
  wait duration;
  if(isDefined(radar_ping)) {
    radar_ping Destroy();
  }
}

addThreatEvent(players_arr, event_duration_sec, event_type, updateHostile, updateFriendly, bPlaySound) {
  if(!IsAlive(self)) {
    return;
  }

  currTime = GetTime();
  endTime = currTime + (event_duration_sec * 1000);
  losEndTime = endTime - (9 * (event_duration_sec * 1000) / 10);

  threatStyle = GetThreatStyle();

  if(endTime - losEndTime < 250) {
    losEndTime = 250 + currTime;
  }

  if(threatStyle == "model") {
    losEndTime = currTime;
  } else if(threatStyle == "vfx_model") {
    losEndTime = currTime;
  } else if(threatStyle == "attached_glow") {
    losEndTime = endTime;
  } else if(threatStyle == "stencil_outline") {
    losEndTime = endTime;
  }

  foreach(p in players_arr) {
    found = false;
    foreach(obj in self._threatdetection.showlist) {
      if(obj.player == p) {
        if(endTime > obj.endTime) {
          obj.endTime = endTime;
          obj.losEndTime = losEndTime;
          obj.eventType = event_type;
        }
        found = true;
        break;
      }
    }

    if(!found) {
      index = self._threatdetection.showlist.size;

      self._threatdetection.showlist[index] = spawnStruct();
      self._threatdetection.showlist[index].player = p;
      self._threatdetection.showlist[index].endTime = endTime;
      self._threatdetection.showlist[index].losEndTime = losEndTime;
      self._threatdetection.showlist[index].eventType = event_type;

      if(IsPlayer(self)) {
        if(!isDefined(bPlaySound) || bPlaySound) {
          self PlayLocalSound("flag_spawned");
        }
      }
    }
  }

  if(IsPlayer(self)) {
    if(updateFriendly) {
      visitFXEnt(::visitorUpdateMarkerPos, ::getFriendlyMarker, undefined);
    }

    if(updateHostile) {
      visitFXEnt(::visitorUpdateMarkerPos, ::getHostileMarker, undefined);
    }
  }
}

stopThreatEventType(eventType) {
  foreach(obj in self._threatdetection.showlist) {
    if(obj.eventType == eventType) {
      obj.endTime = 0;
    }
  }

  threatStyle = GetThreatStyle();
  if(threatStyle == "attached_glow") {
    visitFXEnt(::visitorHideAll, ::getHostileMarker, undefined);
  }
}

visitFXEnt(visitorFn, accessorFn, show_to) {
  threatStyle = GetThreatStyle();
  if(threatStyle == "glow") {
    assert(IsPlayer(self));
    foreach(i, fx in self.mark_fx.fx_ent) {
      assert(isDefined([[accessorFn]](fx)));
      [[visitorFn]]([[accessorFn]](fx), show_to, level._threatdetection.fx_data[i][0]);
    }
  } else if(threatStyle == "model") {
    assert(IsPlayer(self));
    assert(isDefined([[accessorFn]](self._threatdetection)));
    [[visitorFn]]([[accessorFn]](self._threatdetection), show_to, "tag_origin");
  } else if(threatStyle == "vfx_model") {
    assert(IsPlayer(self));
    assert(isDefined([[accessorFn]](self._threatdetection)));
    [[visitorFn]]([[accessorFn]](self._threatdetection), show_to, "tag_origin");
  } else if(threatStyle == "attached_glow") {
    assert(IsPlayer(self));
    foreach(i, fx in self.mark_fx.fx_ent) {
      assert(isDefined([[accessorFn]](fx)));
      [[visitorFn]]([[accessorFn]](fx), show_to, level._threatdetection.fx_data[i][0]);
    }
  } else if(threatStyle == "stencil_outline") {
    [[visitorFn]](self, show_to, "tag_origin");
  } else {
    AssertEx(0, "unknown threat style " + threatStyle + ".i dont know how to set it up");
  }
}

visitorRelink(member, player, bone) {
  member Unlink();
  member.origin = self GetTagOrigin(bone);
  member.angles = self GetTagAngles(bone);
  member LinkTo(self, bone);
  wait .05;
  playFXOnTag(member.fx, member, "tag_origin");
}

visitorHideAll(member, player, bone) {
  threatStyle = GetThreatStyle();
  if(threatStyle == "attached_glow") {
    stopFXOnTag(member.fx, member, "tag_origin");
  }
}

visitorUpdateMarkerPos(member, player, bone) {
  threatStyle = GetThreatStyle();
  member.origin = self GetTagOrigin(bone);
  member.angles = self GetTagAngles(bone);
  if(threatStyle == "glow") {
    triggerFx(member);
  } else if(threatStyle == "model") {
    desired_pose = "mp_hud_" + self GetStance() + "_char";
    assert(isDefined(member));
    is_hostile = (member != self._threatDetection.mark_friendly_model);

    if(is_hostile) {
      desired_pose += "_hostile";
    }

    current_pose = member.model;

    if(desired_pose != current_pose) {
      member setModel(desired_pose);
    }
  } else if(threatStyle == "vfx_model") {
    switch (self GetStance()) {
      case "prone":
        desired_pose = "threat_detect_model_prone";
        break;
      case "crouch":
        desired_pose = "threat_detect_model_crouch";
        break;
      case "stand":

      default:
        desired_pose = "threat_detect_model_stand";
        break;
    }

    assert(isDefined(member));
    is_hostile = (member != self._threatDetection.mark_friendly_model);
    current_pose = self._threatdetection.friendly_pose;

    if(is_hostile) {
      desired_pose += "_hostile";
      current_pose = self._threatdetection.hostile_pose;
    }

    assert(isDefined(current_pose));
    if(current_pose != desired_pose) {
      forward = anglesToForward(self.angles);
      up = AnglesToUp(self.angles);
      if(is_hostile) {
        self._threatdetection.mark_enemy_model delete();
        self._threatdetection.mark_enemy_model = SpawnFx(GetFX(desired_pose), self.origin, forward, up);
        self._threatdetection.mark_enemy_model hide();
        self._threatdetection.hostile_pose = desired_pose;
      } else {
        self._threatdetection.mark_friendly_model delete();
        self._threatdetection.mark_friendly_model = SpawnFx(GetFX(desired_pose), self.origin, forward, up);
        self._threatdetection.mark_friendly_model hide();
        self._threatdetection.friendly_pose = desired_pose;
      }
    }

    if(is_hostile) {
      TriggerFX(self._threatdetection.mark_enemy_model);
    } else {
      TriggerFX(self._threatdetection.mark_friendly_model);
    }
  } else if(threatStyle == "attached_glow") {} else if(threatStyle == "stencil_outline") {} else {
    AssertEx(0, "unknown threat style " + threatStyle + ".i dont know how to set it up");
  }
}

getHostileMarker(obj) {
  threatStyle = GetThreatStyle();
  if(threatStyle == "glow") {
    return obj.enemyMarker;
  } else if(threatStyle == "model") {
    return obj.mark_enemy_model;
  } else if(threatStyle == "vfx_model") {
    return obj.mark_enemy_model;
  } else if(threatStyle == "attached_glow") {
    return obj;
  } else if(threatStyle == "stencil_outline") {
    return obj;
  } else {
    AssertEx(0, "unknown threat style " + threatStyle + ".i dont know how to set it up");
  }
}

getFriendlyMarker(obj) {
  threatStyle = GetThreatStyle();
  if(threatStyle == "glow") {
    return obj.friendlyMarker;
  } else if(threatStyle == "model") {
    return obj.mark_friendly_model;
  } else if(threatStyle == "vfx_model") {
    return obj.mark_friendly_model;
  } else {
    AssertEx(0, "unknown threat style " + threatStyle + ".i dont know how to set it up");
  }
}

getFriendlyLOSMarker(obj) {
  threatStyle = GetThreatStyle();
  if(threatStyle == "glow") {
    return obj.friendlyLOSMarker;
  } else if(threatStyle == "model") {
    return obj.mark_friendly_model;
  } else if(threatStyle == "vfx_model") {
    return obj.mark_friendly_model;
  } else {
    AssertEx(0, "unknown threat style " + threatStyle + ".i dont know how to set it up");
  }
}

getHostileLOSMarker(obj) {
  threatStyle = GetThreatStyle();
  if(threatStyle == "glow") {
    return obj.enemyLOSMarker;
  } else if(threatStyle == "model") {
    return obj.mark_enemy_model;
  } else if(threatStyle == "vfx_model") {
    return obj.mark_enemy_model;
  } else if(threatStyle == "attached_glow") {
    return obj;
  } else if(threatStyle == "stencil_outline") {
    return obj;
  } else {
    AssertEx(0, "unknown threat style " + threatStyle + ".i dont know how to set it up");
  }
}

visitHideAllMarkers(memberArr, player, bone) {
  assert(!isDefined(player));
  foreach(m in memberArr) {
    m Hide();
  }
}

accessAllMarkers(obj) {
  assert(isDefined(obj));
  return [obj.friendlyMarker, obj.enemyMarker, obj.friendlyLOSMarker, obj.enemyLOSMarker];
}

getNormalDirectionVec(raw_vec) {
  return VectorNormalize(flat_origin(raw_vec));
}

monitorThreatHighlight() {
  self threat_init(GetThreatStyle());

  height_offset = (0, 0, 32);
  all_hidden = false;
  while(1) {
    wait .05;
    currTime = GetTime();

    anyoneNeedsDraw = false;
    foreach(obj in self._threatdetection.showlist) {
      if(obj.endTime >= currTime) {
        if(!isDefined(obj.player)) {
          self._threatdetection.showlist = array_remove(self._threatdetection.showlist, obj);
          continue;
        }

        obj.los = false;

        forward = getNormalDirectionVec(anglesToForward(obj.player.angles));
        toTarget = getNormalDirectionVec(self.origin - obj.player.origin);
        cos = VectorDot(toTarget, forward);

        if(cos < 0) {
          continue;
        }

        if(check_los(obj)) {
          obj.los = true;

          if(obj.losEndTime <= currTime) {
            self._threatdetection.showlist = array_remove(self._threatdetection.showlist, obj);
            continue;
          }
        }
        anyoneNeedsDraw = true;
      } else {
        self._threatdetection.showlist = array_remove(self._threatdetection.showlist, obj);
      }
    }

    threatStyle = GetThreatStyle();
    if(!all_hidden) {
      all_hidden = true;
      if(threatStyle == "glow") {
        foreach(i, fx in self.mark_fx.fx_ent) {
          fx.enemyMarker hide();
          fx.friendlyMarker hide();
          fx.enemyLosMarker hide();
          fx.friendlyLosMarker hide();
        }
      } else if(threatStyle == "model") {
        self._threatdetection.mark_friendly_model hide();
        self._threatdetection.mark_enemy_model hide();
      } else if(threatStyle == "vfx_model") {
        self._threatdetection.mark_friendly_model hide();
        self._threatdetection.mark_enemy_model hide();
      } else if(threatStyle == "attached_glow") {
        foreach(i, obj in self.mark_fx.fx_ent) {
          stopFXOnTag(obj.fx, obj, "tag_origin");
          obj hide();
        }
      } else if(threatStyle == "stencil_outline") {
        self clearThreatDetected();
      } else {
        AssertEx(0, "unknown threat style " + threatStyle + ".i dont know how to set it up");
      }

    }
    if(!anyoneNeedsDraw) {
      continue;
    }

    foreach(p in self._threatdetection.showlist) {
      assert(isDefined(p));
      if(p.los) {
        assert(p.losEndTime >= currTime);
        showThreat(p.player, ::getFriendlyLOSMarker, ::getHostileLOSMarker, ::visitorUpdateLOSMarker);
        prepare_show_threat(all_hidden, threatStyle, p.player);
        all_hidden = false;
      } else {
        assert(p.endTime >= currTime);

        result = bulletTrace(p.player.origin + height_offset, self.origin + height_offset, true, p.player);

        if(result["fraction"] < 1 && !isplayer(result["entity"])) {
          showThreat(p.player, ::getFriendlyMarker, ::getHostileMarker, ::visitorShowToPlayer);
          prepare_show_threat(all_hidden, threatStyle, p.player);
          all_hidden = false;
        }
      }
    }

  }
}

prepare_show_threat(already_drawn, threatStyle, player) {
  if(already_drawn) {
    if(threatStyle == "attached_glow") {
      assert(IsPlayer(self));
      showThreat(player, ::getFriendlyLOSMarker, ::getHostileLOSMarker, ::visitorRetriggerFX);
    }
  }
}

visitorRetriggerFX(member, player, bone) {
  threatStyle = GetThreatStyle();
  assert(threatStyle == "attached_glow");

  playFXOnTag(member.fx, member, "tag_origin");
}

check_los(obj) {
  if(BulletTracePassed(obj.player getEye(), self getEye(), false, obj.player)) {
    return true;
  }

  return false;
}

threat_init(threatStyle) {
  mark_fx_struct = spawnStruct();
  mark_fx_struct.fx_ent = [];

  if(threatStyle == "glow") {
    foreach(i, fx in level._threatdetection.fx_data) {
      mark_fx_ent = spawnStruct();
      mark_fx_ent.origin = self GetTagOrigin(fx[0]);
      mark_fx_ent.angles = self GetTagAngles(fx[0]);

      mark_fx_ent.enemyMarker = SpawnFx(fx[1], mark_fx_ent.origin);
      triggerFx(mark_fx_ent.enemyMarker);
      mark_fx_ent.enemyMarker hide();

      mark_fx_ent.enemyLosMarker = SpawnFx(fx[3], mark_fx_ent.origin);
      triggerFx(mark_fx_ent.enemyLosMarker);
      mark_fx_ent.enemyLosMarker hide();

      mark_fx_ent.friendlyMarker = SpawnFx(fx[2], mark_fx_ent.origin);
      triggerFx(mark_fx_ent.friendlyMarker);
      mark_fx_ent.friendlyMarker hide();

      mark_fx_ent.friendlyLosMarker = SpawnFx(fx[4], mark_fx_ent.origin);
      triggerFx(mark_fx_ent.friendlyLosMarker);
      mark_fx_ent.friendlyLosMarker hide();

      mark_fx_struct.fx_ent[i] = mark_fx_ent;
    }

    self.mark_fx = mark_fx_struct;
  } else if(threatStyle == "model") {
    model = spawn("script_model", self.origin);
    model.origin = self.origin;
    model.angles = self.angles;

    model setModel(level._threatdetection.friendlyModel);
    model SetContents(0);

    self._threatDetection.mark_friendly_model = model;

    model = spawn("script_model", self.origin);
    model.origin = self.origin;
    model.angles = self.angles;

    model setModel(level._threatdetection.hostileModel);
    model SetContents(0);

    self._threatDetection.mark_enemy_model = model;
  } else if(threatStyle == "vfx_model") {
    self._threatDetection.mark_friendly_model = spawnStruct();
    self._threatDetection.mark_friendly_model = SpawnFx(GetFX("threat_detect_model_stand"), self.origin, anglesToForward(self.angles), AnglesToUp(self.angles));
    self._threatDetection.friendly_pose = "threat_detect_model_stand";

    self._threatDetection.mark_enemy_model = spawnStruct();
    self._threatDetection.mark_enemy_model = SpawnFx(GetFX("threat_detect_model_stand_hostile"), self.origin, anglesToForward(self.angles), AnglesToUp(self.angles));
    self._threatDetection.hostile_pose = "threat_detect_model_stand_hostile";
  } else if(threatStyle == "attached_glow") {
    foreach(i, fx in level._threatdetection.fx_data) {
      tag_org = spawn_tag_origin();
      tag_org show();
      tag_org.origin = self GetTagOrigin(fx[0]);
      tag_org.angles = self GetTagAngles(fx[0]);
      tag_org LinkTo(self, fx[0]);
      tag_org.fx = fx[1];

      mark_fx_struct.fx_ent[i] = tag_org;
    }

    self.mark_fx = mark_fx_struct;
  } else if(threatStyle == "stencil_outline") {} else {
    AssertEx(0, "unknown threat style " + threatStyle + ".i dont know how to set it up");
  }
}

visitorUpdateLOSMarker(member, player, bone) {
  visitorUpdateMarkerPos(member, player, bone);
  visitorShowToPlayer(member, player, bone);
}

visitorShowToPlayer(member, player, bone) {
  assert(isDefined(player) && isplayer(player));
  assert(isDefined(member));

  threatStyle = GetThreatStyle();

  if(threatStyle == "stencil_outline") {
    member threatDetectedToPlayer(player);
  } else {
    member showToPlayer(player);
  }
}

showThreat(player, friendlyFn, hostileFn, visitorFn) {
  if(player == self) {
    return;
  }

  memberFunc = hostileFn;

  if((level.teamBased || level.multiteambased) && player.team == self.team) {
    memberFunc = friendlyFn;
  } else if(player == self) {
    memberFunc = friendlyFn;
  }

  visitFXEnt(visitorFn, memberFunc, player);
}