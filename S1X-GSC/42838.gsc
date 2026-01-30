/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42838.gsc
**************************************/

init() {
  level._threatdetection = spawnStruct();
  level._threatdetection.default_style = "stencil_outline";
  level._threatdetection.activestyle = getdvar("threat_detection_highlight_style", level._threatdetection.default_style);
  level thread onplayerconnect();
  level thread watchagentspawn();
}

changethreatstyle(var_0) {
  if(var_0 == level._threatdetection.activestyle) {
    return;
  }
  foreach(var_2 in level.players) {
    if(isDefined(var_2._threatdetection.mark_enemy_model)) {
      var_2._threatdetection.mark_enemy_model delete();
    }

    if(isDefined(var_2._threatdetection.mark_friendly_model)) {
      var_2._threatdetection.mark_friendly_model delete();
    }

    if(isDefined(var_2.mark_fx) && isDefined(var_2.mark_fx.fx_ent)) {
      foreach(var_5, var_4 in var_2.mark_fx.fx_ent) {
        if(isDefined(var_4.enemymarker)) {
          var_4.enemymarker delete();
        }

        if(isDefined(var_4.friendlymarker)) {
          var_4.friendlymarker delete();
        }

        if(isDefined(var_4.enemylosmarker)) {
          var_4.enemylosmarker delete();
        }

        if(isDefined(var_4.friendlylosmarker)) {
          var_4.friendlylosmarker delete();
        }
      }
    }
  }

  foreach(var_2 in level.players) {
    var_2 threat_init(var_0);
  }

  level._threatdetection.activestyle = var_0;
}

getthreatstyle() {
  var_0 = getdvar("threat_detection_highlight_style", level._threatdetection.default_style);

  if(var_0 != level._threatdetection.activestyle) {
    changethreatstyle(var_0);
  }

  return var_0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

watchagentspawn() {
  for(;;) {
    level waittill("spawned_agent", var_0);
    var_0._threatdetection = spawnStruct();
    var_0._threatdetection.showlist = [];
    var_0 thread onagentspawned();
  }
}

onagentspawned() {
  self endon("death");
  childthread monitorthreathighlight();
  childthread cleanupondeath();
}

onplayerspawned() {
  self endon("disconnect");
  self._threatdetection = spawnStruct();
  self._threatdetection.showlist = [];
  self waittill("spawned_player");
  childthread monitorthreathighlight();
  childthread cleanupondeath();
  childthread monitorthreathighlightnotification();

  for(;;) {
    self waittill("spawned_player");
    var_0 = getthreatstyle();

    if(var_0 == "attached_glow") {
      visitfxent(::visitorrelink, ::gethostilemarker, undefined);
    }
  }
}

monitorthreathighlightnotification() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0 setshader("paint_overlay", 640, 480);
  var_0.alpha = 0.0;
  var_0.color = (0, 0, 0);
  var_0.sort = -3;
  var_0.hidden = 1;
  var_1 = 0.5;
  var_2 = 0.3;

  for(;;) {
    if(self._threatdetection.showlist.size != 0) {
      if(var_0.hidden) {
        var_0.hidden = 0;
        var_0 childthread threatnotificationoverlayflash(var_1, var_2);
      }
    } else if(!var_0.hidden) {
      var_0.hidden = 1;
      var_0 notify("stop_overlay_flash");

      if(var_0.alpha > 0.0) {
        var_0 fadeovertime(var_2);
        var_0.color = (0, 0, 0);
        var_0.alpha = 0.0;
        wait(var_2);
      }
    }

    wait 0.05;
  }
}

threatnotificationoverlayflash(var_0, var_1) {
  self endon("stop_overlay_flash");
  self fadeovertime(var_0);
  self.color = (1, 1, 1);
  self.alpha = 1.0;
}

debughelper() {
  for(;;) {
    var_0 = distance(self.origin, level.players[0].origin);
    thread common_scripts\utility::draw_line_for_time(level.players[0].origin, self.origin, 1, 1, 1, 0.3);

    if(isDefined(self._threatdetection.mark_enemy_model)) {
      thread common_scripts\utility::draw_line_for_time(level.players[0].origin, self._threatdetection.mark_enemy_model.origin, 1, 1, 1, 0.3);
    }

    wait 0.3;
  }
}

cleanupondeath() {
  self endon("disconnect");

  for(;;) {
    self waittill("death");
    removethreatevents();
  }
}

removethreatevents() {
  foreach(var_1 in level.players) {
    foreach(var_3 in var_1._threatdetection.showlist) {
      if(var_3.player == self) {
        var_3.endtime = 0;
      }
    }
  }

  var_6 = getthreatstyle();

  if(var_6 == "attached_glow") {
    visitfxent(::visitorhideall, ::gethostilemarker, undefined);
  }
}

detection_highlight_hud_effect_on(var_0, var_1, var_2) {
  var_3 = newclienthudelem(var_0);

  if(isDefined(var_2) && var_2) {
    var_3.color = (0.1, 0.0015, 0.0015);
  } else {
    var_3.color = (1, 0.015, 0.015);
  }

  var_3.alpha = 1.0;
  var_3 setradarhighlight(var_1);
  return var_3;
}

detection_highlight_hud_effect_off(var_0) {
  if(isDefined(var_0)) {
    var_0 destroy();
  }
}

detection_highlight_hud_effect(var_0, var_1, var_2, var_3) {
  var_4 = detection_highlight_hud_effect_on(var_0, var_1, var_2);

  if(isDefined(var_3)) {
    var_0 common_scripts\utility::waittill_notify_or_timeout(var_3, var_1);
  } else {
    wait(var_1);
  }

  detection_highlight_hud_effect_off(var_4);
}

detection_grenade_hud_effect(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.x = var_1[0];
  var_4.y = var_1[1];
  var_4.z = var_1[2];
  var_4.color = (getdvarfloat("scr_paintexplosionred"), getdvarfloat("scr_paintexplosiongreen"), getdvarfloat("scr_paintexplosionblue"));
  var_4.alpha = getdvarfloat("scr_paintexplosionalpha");
  var_5 = getdvarint("paintexplosionwidth");
  var_4 setradarping(int(var_3 + var_5 / 2), int(var_5), var_2 + 0.05);
  wait(var_2);

  if(isDefined(var_4)) {
    var_4 destroy();
  }
}

exo_ping_hud_effect(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_5 = newclienthudelem(var_3);
  } else {
    var_5 = newhudelem();
  }

  var_5.x = var_0[0];
  var_5.y = var_0[1];
  var_5.z = var_0[2];

  if(isDefined(var_4) && var_4) {
    var_5.color = (0.05, 0.05, 0.05);
  } else {
    var_5.color = (0.8, 0.8, 0.8);
  }

  var_5.alpha = 0.05;
  var_6 = getdvarint("scr_exopingwidth", 100);
  var_5 setradarping(int(var_2), int(var_6), var_1 + 0.05);
  wait(var_1);

  if(isDefined(var_5)) {
    var_5 destroy();
  }
}

addthreatevent(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isalive(self)) {
    return;
  }
  var_6 = gettime();
  var_7 = var_6 + var_1 * 1000;
  var_8 = var_7 - 9 * (var_1 * 1000) / 10;
  var_9 = getthreatstyle();

  if(var_7 - var_8 < 250) {
    var_8 = 250 + var_6;
  }

  if(var_9 == "model") {
    var_8 = var_6;
  } else if(var_9 == "vfx_model") {
    var_8 = var_6;
  } else if(var_9 == "attached_glow") {
    var_8 = var_7;
  } else if(var_9 == "stencil_outline") {
    var_8 = var_7;
  }

  foreach(var_11 in var_0) {
    var_12 = 0;

    foreach(var_14 in self._threatdetection.showlist) {
      if(var_14.player == var_11) {
        if(var_7 > var_14.endtime) {
          var_14.endtime = var_7;
          var_14.losendtime = var_8;
          var_14.eventtype = var_2;
        }

        var_12 = 1;
        break;
      }
    }

    if(!var_12) {
      var_16 = self._threatdetection.showlist.size;
      self._threatdetection.showlist[var_16] = spawnStruct();
      self._threatdetection.showlist[var_16].player = var_11;
      self._threatdetection.showlist[var_16].endtime = var_7;
      self._threatdetection.showlist[var_16].losendtime = var_8;
      self._threatdetection.showlist[var_16].eventtype = var_2;

      if(isplayer(self)) {
        if(!isDefined(var_5) || var_5) {
          self playlocalsound("flag_spawned");
        }
      }
    }
  }

  if(isplayer(self)) {
    if(var_4) {
      visitfxent(::visitorupdatemarkerpos, ::getfriendlymarker, undefined);
    }

    if(var_3) {
      visitfxent(::visitorupdatemarkerpos, ::gethostilemarker, undefined);
    }
  }
}

stopthreateventtype(var_0) {
  foreach(var_2 in self._threatdetection.showlist) {
    if(var_2.eventtype == var_0) {
      var_2.endtime = 0;
    }
  }

  var_4 = getthreatstyle();

  if(var_4 == "attached_glow") {
    visitfxent(::visitorhideall, ::gethostilemarker, undefined);
  }
}

visitfxent(var_0, var_1, var_2) {
  var_3 = getthreatstyle();

  if(var_3 == "glow") {
    foreach(var_6, var_5 in self.mark_fx.fx_ent)[[var_0]]([[var_1]](var_5), var_2, level._threatdetection.fx_data[var_6][0]);
  } else if(var_3 == "model") {
    [[var_0]]([[var_1]](self._threatdetection), var_2, "tag_origin");
  } else if(var_3 == "vfx_model") {
    [[var_0]]([[var_1]](self._threatdetection), var_2, "tag_origin");
  } else if(var_3 == "attached_glow") {
    foreach(var_6, var_5 in self.mark_fx.fx_ent)[[var_0]]([[var_1]](var_5), var_2, level._threatdetection.fx_data[var_6][0]);
  } else if(var_3 == "stencil_outline") {
    [[var_0]](self, var_2, "tag_origin");
  } else {}
}

visitorrelink(var_0, var_1, var_2) {
  var_0 unlink();
  var_0.origin = self gettagorigin(var_2);
  var_0.angles = self gettagangles(var_2);
  var_0 linkto(self, var_2);
  wait 0.05;
  playFXOnTag(var_0.fx, var_0, "tag_origin");
}

visitorhideall(var_0, var_1, var_2) {
  var_3 = getthreatstyle();

  if(var_3 == "attached_glow") {
    stopFXOnTag(var_0.fx, var_0, "tag_origin");
  }
}

visitorupdatemarkerpos(var_0, var_1, var_2) {
  var_3 = getthreatstyle();
  var_0.origin = self gettagorigin(var_2);
  var_0.angles = self gettagangles(var_2);

  if(var_3 == "glow") {
    triggerfx(var_0);
  } else if(var_3 == "model") {
    var_4 = "mp_hud_" + self getstance() + "_char";
    var_5 = var_0 != self._threatdetection.mark_friendly_model;

    if(var_5) {
      var_4 = var_4 + "_hostile";
    }

    var_6 = var_0.model;

    if(var_4 != var_6) {
      var_0 setModel(var_4);
      return;
    }
  } else if(var_3 == "vfx_model") {
    switch (self getstance()) {
      case "prone":
        var_4 = "threat_detect_model_prone";
        break;
      case "crouch":
        var_4 = "threat_detect_model_crouch";
        break;
      case "stand":
      default:
        var_4 = "threat_detect_model_stand";
        break;
    }

    var_5 = var_0 != self._threatdetection.mark_friendly_model;
    var_6 = self._threatdetection.friendly_pose;

    if(var_5) {
      var_4 = var_4 + "_hostile";
      var_6 = self._threatdetection.hostile_pose;
    }

    if(var_6 != var_4) {
      var_7 = anglesToForward(self.angles);
      var_8 = anglestoup(self.angles);

      if(var_5) {
        self._threatdetection.mark_enemy_model delete();
        self._threatdetection.mark_enemy_model = spawnfx(common_scripts\utility::getfx(var_4), self.origin, var_7, var_8);
        self._threatdetection.mark_enemy_model hide();
        self._threatdetection.hostile_pose = var_4;
      } else {
        self._threatdetection.mark_friendly_model delete();
        self._threatdetection.mark_friendly_model = spawnfx(common_scripts\utility::getfx(var_4), self.origin, var_7, var_8);
        self._threatdetection.mark_friendly_model hide();
        self._threatdetection.friendly_pose = var_4;
      }
    }

    if(var_5) {
      triggerfx(self._threatdetection.mark_enemy_model);
      return;
    }

    triggerfx(self._threatdetection.mark_friendly_model);
    return;
  } else {
    if(var_3 == "attached_glow") {
      return;
    }
    if(var_3 == "stencil_outline") {
      return;
    }
    return;
    return;
  }
}

gethostilemarker(var_0) {
  var_1 = getthreatstyle();

  if(var_1 == "glow") {
    return var_0.enemymarker;
  } else if(var_1 == "model") {
    return var_0.mark_enemy_model;
  } else if(var_1 == "vfx_model") {
    return var_0.mark_enemy_model;
  } else if(var_1 == "attached_glow") {
    return var_0;
  } else if(var_1 == "stencil_outline") {
    return var_0;
  } else {}
}

getfriendlymarker(var_0) {
  var_1 = getthreatstyle();

  if(var_1 == "glow") {
    return var_0.friendlymarker;
  } else if(var_1 == "model") {
    return var_0.mark_friendly_model;
  } else if(var_1 == "vfx_model") {
    return var_0.mark_friendly_model;
  } else {}
}

getfriendlylosmarker(var_0) {
  var_1 = getthreatstyle();

  if(var_1 == "glow") {
    return var_0.friendlylosmarker;
  } else if(var_1 == "model") {
    return var_0.mark_friendly_model;
  } else if(var_1 == "vfx_model") {
    return var_0.mark_friendly_model;
  } else {}
}

gethostilelosmarker(var_0) {
  var_1 = getthreatstyle();

  if(var_1 == "glow") {
    return var_0.enemylosmarker;
  } else if(var_1 == "model") {
    return var_0.mark_enemy_model;
  } else if(var_1 == "vfx_model") {
    return var_0.mark_enemy_model;
  } else if(var_1 == "attached_glow") {
    return var_0;
  } else if(var_1 == "stencil_outline") {
    return var_0;
  } else {}
}

visithideallmarkers(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 hide();
  }
}

accessallmarkers(var_0) {
  return [var_0.friendlymarker, var_0.enemymarker, var_0.friendlylosmarker, var_0.enemylosmarker];
}

getnormaldirectionvec(var_0) {
  return vectornormalize(common_scripts\utility::flat_origin(var_0));
}

monitorthreathighlight() {
  threat_init(getthreatstyle());
  var_0 = (0, 0, 32);
  var_1 = 0;

  for(;;) {
    wait 0.05;
    var_2 = gettime();
    var_3 = 0;

    foreach(var_5 in self._threatdetection.showlist) {
      if(var_5.endtime >= var_2) {
        if(!isDefined(var_5.player)) {
          self._threatdetection.showlist = common_scripts\utility::array_remove(self._threatdetection.showlist, var_5);
          continue;
        }

        var_5.los = 0;
        var_6 = getnormaldirectionvec(anglesToForward(var_5.player.angles));
        var_7 = getnormaldirectionvec(self.origin - var_5.player.origin);
        var_8 = vectordot(var_7, var_6);

        if(var_8 < 0) {
          continue;
        }
        if(check_los(var_5)) {
          var_5.los = 1;

          if(var_5.losendtime <= var_2) {
            self._threatdetection.showlist = common_scripts\utility::array_remove(self._threatdetection.showlist, var_5);
            continue;
          }
        }

        var_3 = 1;
        continue;
      }

      self._threatdetection.showlist = common_scripts\utility::array_remove(self._threatdetection.showlist, var_5);
    }

    var_10 = getthreatstyle();

    if(!var_1) {
      var_1 = 1;

      if(var_10 == "glow") {
        foreach(var_13, var_12 in self.mark_fx.fx_ent) {
          var_12.enemymarker hide();
          var_12.friendlymarker hide();
          var_12.enemylosmarker hide();
          var_12.friendlylosmarker hide();
        }
      } else if(var_10 == "model") {
        self._threatdetection.mark_friendly_model hide();
        self._threatdetection.mark_enemy_model hide();
      } else if(var_10 == "vfx_model") {
        self._threatdetection.mark_friendly_model hide();
        self._threatdetection.mark_enemy_model hide();
      } else if(var_10 == "attached_glow") {
        foreach(var_13, var_5 in self.mark_fx.fx_ent) {
          stopFXOnTag(var_5.fx, var_5, "tag_origin");
          var_5 hide();
        }
      } else if(var_10 == "stencil_outline") {
        self clearthreatdetected();
      } else {}
    }

    if(!var_3) {
      continue;
    }
    foreach(var_16 in self._threatdetection.showlist) {
      if(var_16.los) {
        showthreat(var_16.player, ::getfriendlylosmarker, ::gethostilelosmarker, ::visitorupdatelosmarker);
        prepare_show_threat(var_1, var_10, var_16.player);
        var_1 = 0;
        continue;
      }

      var_17 = bulletTrace(var_16.player.origin + var_0, self.origin + var_0, 1, var_16.player);

      if(var_17["fraction"] < 1 && !isplayer(var_17["entity"])) {
        showthreat(var_16.player, ::getfriendlymarker, ::gethostilemarker, ::visitorshowtoplayer);
        prepare_show_threat(var_1, var_10, var_16.player);
        var_1 = 0;
      }
    }
  }
}

prepare_show_threat(var_0, var_1, var_2) {
  if(var_0) {
    if(var_1 == "attached_glow") {
      showthreat(var_2, ::getfriendlylosmarker, ::gethostilelosmarker, ::visitorretriggerfx);
    }
  }
}

visitorretriggerfx(var_0, var_1, var_2) {
  playFXOnTag(var_0.fx, var_0, "tag_origin");
}

check_los(var_0) {
  if(bullettracepassed(var_0.player getEye(), self getEye(), 0, var_0.player)) {
    return 1;
  }

  return 0;
}

threat_init(var_0) {
  var_1 = spawnStruct();
  var_1.fx_ent = [];

  if(var_0 == "glow") {
    foreach(var_5, var_3 in level._threatdetection.fx_data) {
      var_4 = spawnStruct();
      var_4.origin = self gettagorigin(var_3[0]);
      var_4.angles = self gettagangles(var_3[0]);
      var_4.enemymarker = spawnfx(var_3[1], var_4.origin);
      triggerfx(var_4.enemymarker);
      var_4.enemymarker hide();
      var_4.enemylosmarker = spawnfx(var_3[3], var_4.origin);
      triggerfx(var_4.enemylosmarker);
      var_4.enemylosmarker hide();
      var_4.friendlymarker = spawnfx(var_3[2], var_4.origin);
      triggerfx(var_4.friendlymarker);
      var_4.friendlymarker hide();
      var_4.friendlylosmarker = spawnfx(var_3[4], var_4.origin);
      triggerfx(var_4.friendlylosmarker);
      var_4.friendlylosmarker hide();
      var_1.fx_ent[var_5] = var_4;
    }

    self.mark_fx = var_1;
  } else if(var_0 == "model") {
    var_6 = spawn("script_model", self.origin);
    var_6.origin = self.origin;
    var_6.angles = self.angles;
    var_6 setModel(level._threatdetection.friendlymodel);
    var_6 setcontents(0);
    self._threatdetection.mark_friendly_model = var_6;
    var_6 = spawn("script_model", self.origin);
    var_6.origin = self.origin;
    var_6.angles = self.angles;
    var_6 setModel(level._threatdetection.hostilemodel);
    var_6 setcontents(0);
    self._threatdetection.mark_enemy_model = var_6;
  } else if(var_0 == "vfx_model") {
    self._threatdetection.mark_friendly_model = spawnStruct();
    self._threatdetection.mark_friendly_model = spawnfx(common_scripts\utility::getfx("threat_detect_model_stand"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    self._threatdetection.friendly_pose = "threat_detect_model_stand";
    self._threatdetection.mark_enemy_model = spawnStruct();
    self._threatdetection.mark_enemy_model = spawnfx(common_scripts\utility::getfx("threat_detect_model_stand_hostile"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    self._threatdetection.hostile_pose = "threat_detect_model_stand_hostile";
  } else if(var_0 == "attached_glow") {
    foreach(var_5, var_3 in level._threatdetection.fx_data) {
      var_8 = common_scripts\utility::spawn_tag_origin();
      var_8 show();
      var_8.origin = self gettagorigin(var_3[0]);
      var_8.angles = self gettagangles(var_3[0]);
      var_8 linkto(self, var_3[0]);
      var_8.fx = var_3[1];
      var_1.fx_ent[var_5] = var_8;
    }

    self.mark_fx = var_1;
  } else {
    if(var_0 == "stencil_outline") {
      return;
    }
    return;
  }
}

visitorupdatelosmarker(var_0, var_1, var_2) {
  visitorupdatemarkerpos(var_0, var_1, var_2);
  visitorshowtoplayer(var_0, var_1, var_2);
}

visitorshowtoplayer(var_0, var_1, var_2) {
  var_3 = getthreatstyle();

  if(var_3 == "stencil_outline") {
    var_0 threatdetectedtoplayer(var_1);
  } else {
    var_0 showtoplayer(var_1);
  }
}

showthreat(var_0, var_1, var_2, var_3) {
  if(var_0 == self) {
    return;
  }
  var_4 = var_2;

  if((level.teambased || level.multiteambased) && var_0.team == self.team) {
    var_4 = var_1;
  } else if(var_0 == self) {
    var_4 = var_1;
  }

  visitfxent(var_3, var_4, var_0);
}