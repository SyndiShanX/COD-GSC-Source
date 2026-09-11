/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\stairtrain.gsc
***********************************************/

function stairtrain_thread(var0, var1, var2) {
  if(!scripts\engine\utility::ent_flag_exist("stairtrain_on")) {
    scripts\engine\utility::ent_flag_init("stairtrain_on");
  }

  if(!scripts\engine\utility::flag_exist("stairtrain_pause")) {
    scripts\engine\utility::flag_init("stairtrain_pause");
  }

  if(!scripts\engine\utility::flag_exist("stairtrain_nagging")) {
    scripts\engine\utility::flag_init("stairtrain_nagging");
  }

  scripts\engine\utility::flag_clear("stairtrain_nagging");
  scripts\engine\utility::ent_flag_set("stairtrain_on");

  if(!isDefined(var0.animfrac_min)) {
    var0.animfrac_min = 0.5;
  }

  self.stairtrain = spawnStruct();
  self.stairtrain.skiplogic = 0;
  self.stairtrain.safestop = 1;
  waitframe();

  if(!isDefined(var0.base_anime)) {
    var0.base_anime = "stairtrain";
  }

  thread stairtrain_notetracks(var0.base_anime);
  var3 = getstartorigin(var0.animnode.origin, var0.animnode.angles, var0.base_anim);
  var4 = getstartangles(var0.animnode.origin, var0.animnode.angles, var0.base_anim);
  self forceteleport(var3, var4);
  self orientmode("face angle", var4[1]);
  self setflaggedanim(var0.base_anime, var0.base_anim, 1, 0.4, 0);
  var5 = getanimlength(var0.base_anim);
  var6 = 0;
  level.stairtrain_rate = 1;

  if(!isDefined(var0.base_speedscale)) {
    var0.base_speedscale = 1;
  }

  var7 = 1;
  var8 = isDefined(var0.playerlead);

  if(isDefined(var0.additive_anim)) {
    self setanim(var0.additive_anim, 0, 0.2);
  }

  var9 = scripts\engine\utility::getStruct(var1, "targetname");
  init_path(var9);
  var9.startonpath = isDefined(var0.startonpath);
  var10 = 0;
  var0.nagtime = gettime() + 3000;
  var11 = "none";
  var12 = 0;
  var13 = gettime() + randomintrange(5000, 10000);

  for(;;) {
    if(self getanimtime(var0.base_anim) >= 1) {
      break;
    }

    var14 = stairtrain_player_data(var9, var0);

    if(self.stairtrain.skiplogic) {
      self setanimrate(var0.base_anim, 1);

      if(isDefined(var0.settle_anim)) {
        self clearanim(var0.settle_anim, 0.2);
      }

      if(isDefined(var0.additive_anim)) {
        self clearanim(var0.additive_anim, 0.2);
      }

      if(isDefined(var0.idle_twitch)) {
        clear_idle_twitch(var0);
      }

      if(!var8 && self == level.stairtrain_rearguy) {
        level.player scripts\engine\sp\utility::blend_movespeedscale(var14.playerspeedfrac * var0.base_speedscale, 0.05);
      }

      waitframe();
      continue;
    }

    if(getdvarint("scr_debug_stairtrain")) {}

    if(var14.animratefrac > 0 && !scripts\engine\utility::flag("stairtrain_nagging")) {
      if(isDefined(var0.settle_anim) && var11 == "settling") {
        self clearanim(var0.settle_anim, 0.4);
      }

      if(isDefined(var0.additive_anim) && var11 == "idling") {
        self clearanim(var0.additive_anim, 0.4);
      }

      if(isDefined(var0.additive_branch)) {
        self clearanim(var0.additive_branch, 0.4);
      }

      if(isDefined(var0.idle_twitch)) {
        clear_idle_twitch(var0);
      }

      var12 = 0;
      var11 = "none";

      if(self == level.stairtrain_rearguy && !var9.startonpath) {
        if(isDefined(var14.playerspeedfrac)) {
          level.player scripts\engine\sp\utility::blend_movespeedscale(var14.playerspeedfrac * var0.base_speedscale, 0.05);
        }
      }

      var15 = level.stairtrain_rate * var14.animratefrac;
      self setanimrate(var0.base_anim, var15);
      var10 = var14.playerdistfrac;
    } else if(canstop()) {
      var10 = 0;

      if(self == level.stairtrain_rearguy) {
        level.player scripts\engine\sp\utility::blend_movespeedscale(var0.base_speedscale, 0.3);
      }

      self setanimrate(var0.base_anim, 0);

      if(isDefined(var0.settle_anim)) {
        if(var11 == "none") {
          var11 = "settling";
          self setflaggedanimrestart(var0.base_anime + "_settle", var0.settle_anim, 1, 0.2);
        } else if(var11 == "settling") {
          if(self getanimtime(var0.settle_anim) == 1) {
            self clearanim(var0.settle_anim, 0.4);
            var11 = "startidle";
          }
        }
      }

      if(isDefined(var0.additive_anim)) {
        if(var11 == "startidle") {
          var11 = "idling";
          var0.nagtime = gettime() + randomintrange(3000, 5000);
          var15 = randomfloatrange(0.7, 1);
          self setflaggedanim(var0.base_anime + "_additive", var0.additive_anim, 1, 0.2, var15);
        } else if(var11 == "idling") {
          do_idle_twitch(var0);
        }
      } else if(var11 != "settling") {
        var11 = "idling";
      }

      if(var11 == "idling") {
        try_nag(var0);
      }
    }

    waitframe();
  }

  self notify("stairtrain_end");
  self notify("stairtrain_stop_notetracks");
  self.stairtrain = undefined;
  self.stairtrain_prevguy = undefined;
  self clearanim(var0.base_anim, 0.2);

  if(isDefined(var0.settle_anim)) {
    self clearanim(var0.settle_anim, 0.2);
  }

  if(isDefined(var0.additive_anim)) {
    self clearanim(var0.additive_anim, 0.2);
  }

  if(isDefined(var0.idle_twitch)) {
    clear_idle_twitch(var0);
  }

  if(self == level.stairtrain_rearguy) {
    level.player scripts\engine\sp\utility::blend_movespeedscale(var0.base_speedscale, 0.5);
  }

  level notify("stairtrain_reached_end");
  scripts\engine\utility::ent_flag_clear("stairtrain_on");
}

function do_idle_twitch(var0) {
  if(!isDefined(var0.fnadditive_twitch_get)) {
    return;
  }

  if(isDefined(var0.idle_twitch)) {
    if(self getanimtime(var0.idle_twitch) == 1) {
      clear_idle_twitch(var0);
      var0.next_twitch_time = gettime() + randomintrange(4000, 15000);
      self setanim(var0.additive_anim, 1, 0.2);
    }

    return;
  }

  if(!isDefined(var0.next_twitch_time)) {
    var0.next_twitch_time = gettime() + randomintrange(4000, 15000);
    return;
  }

  if(gettime() < var0.next_twitch_time) {
    return;
  }

  self setanim(var0.additive_anim, 0, 0.2);
  var0.idle_twitch = [[var0.fnadditive_twitch_get]]();
  self setflaggedanim(var0.base_anime + "_additive_twitch", var0.idle_twitch, 1, 0.2, 1);
}

function clear_idle_twitch(var0) {
  self clearanim(var0.idle_twitch, 0.2);
  var0.idle_twitch = undefined;
}

function try_nag(var0) {
  if(!isDefined(var0.fnnag)) {
    return 0;
  }

  if(gettime() < var0.nagtime) {
    return;
  }

  if(level.stairtrain_rearguy != self) {
    return;
  }

  if(scripts\engine\utility::flag("stairtrain_nagging")) {
    return;
  }

  if(gettime() > var0.nagtime) {
    var1 = 0;

    if(isDefined(var0.nag_anim)) {
      var1 = 1;
      thread nag_anim(var0);
    }

    GscBinSkip1(0x74, var0.fnnag);
  }
}

function nag_anim(var0) {
  var1 = "something";
  scripts\engine\utility::flag_set("stairtrain_nagging");
  self setflaggedanimrestart(var1, var0.nag_anim, 1, 0.2, 1);
  self waittillmatch(var1, "end");
  self clearanim(var0.nag_anim, 0.2);
  scripts\engine\utility::flag_clear("stairtrain_nagging");
  var0.nagtime = gettime() + randomintrange(5000, 10000);
}

function set_prevguy(var0) {
  self.stairtrain_prevguy = var0;
}

function canstop() {
  return self.stairtrain.safestop;
}

function stairtrain_notetracks(var0) {
  self endon("death");
  self notify("stairtrain_stop_notetracks");
  self endon("stairtrain_stop_notetracks");
  childthread scripts\sp\anim::animscriptdonotetracksthread(self, var0);
  var1 = [];
  var2 = spawnStruct();
  var2.dialog = [];
  var2.dialoguenotetrack = 0;
  var3 = self.animname;

  if(isDefined(level.scr_notetrack[var3])) {
    if(isDefined(level.scr_notetrack[var3][var0])) {
      var1 = level.scr_notetrack[var3][var0];
    }

    if(isDefined(level.scr_notetrack[var3]["any"])) {
      var1 = level.scr_notetrack[var3]["any"];
    }
  }

  foreach(var5 in var1) {
    foreach(var7 in level.scr_notetrack[var3][var12]) {
      foreach(var9 in var7) {
        if(isDefined(var9["dialog"])) {
          var2.dialog[var9["dialog"]] = 1;
        }
      }
    }
  }

  for(;;) {
    self waittill(var0, var13);

    if(!isarray(var13) && var13 == "end") {
      return;
    }

    foreach(var15 in var13) {
      scripts\common\notetrack::notetrack_handler(self, var0, var15, self.animname, var1, self, var2);

      switch (var15) {
        case "bypass_logic":
          self.stairtrain.skiplogic = 1;
          break;
        case "resume_logic":
          self.stairtrain.skiplogic = 0;
          break;
        case "end_stairtrain":
          self.stairtrain.skiplogic = 1;
          break;
        case "safe_stop":
          self.stairtrain.safestop = 1;
          break;
        case "unsafe_stop":
          self.stairtrain.safestop = 0;
          break;
      }
    }
  }
}

function stairtrain_player_data(var0, var1) {
  var2 = spawnStruct();
  var2.playerdistfrac = 0;
  var2.animratefrac = 0;
  var3 = isDefined(var1.playerlead);

  if(scripts\engine\utility::flag("stairtrain_pause")) {
    return var2;
  }

  if(self != level.stairtrain_rearguy) {
    if(isDefined(self.stairtrain_prevguy)) {
      var4 = scripts\engine\utility::flat_origin(self.stairtrain_prevguy.origin);
      var5 = scripts\engine\utility::flat_origin(self.origin);
      var6 = distance(var4, var5);

      if(getdvarint("scr_debug_stairtrain")) {}

      var7 = 23;

      if(isDefined(var1.prevguy_dist_max)) {
        var7 = var1.prevguy_dist_max;
      }

      var8 = 1 - scripts\engine\math::lerp_fraction(19, var7, var6);
      var2.playerdistfrac = 1;

      if(var8 > 0 && var8 < var1.animfrac_min) {
        var8 = var1.animfrac_min;
      } else if(var8 < 0) {
        var8 = 0;
      }

      var2.animratefrac = var8;
      return var2;
    } else if(isDefined(level.stairtrain_rearguy.stairtrain_data)) {
      return level.stairtrain_rearguy.stairtrain_data;
    } else {
      return var7;
    }
  }

  var9 = get_closest_on_path(level.stairtrain_rearguy.origin, var5);
  var10 = get_dist_on_segment(var9["origin"], var9["segment"]);

  if(var10 < 1) {
    var11 = [];
    GscBinSkip0(0x2e, "segment", var5.segments[0]);
  }

  if(var11 < var7.maxplayerdist) {
    var11 = get_closest_on_path(level.player.origin, var6);
    var13 = distance(level.player.origin, var10["origin"]);
    var14 = var11["segment"][0].radius;
  } else {
    var11 = get_closest_on_path(level.player.origin, var9);
    var12 = get_dist_on_segment(var11["origin"], var11["segment"]);
    var14 = var11["segment"][0].radius;
    var13 = abs(var14 - var12);
  }

  var15 = vectortoangles(var11["segment"][1].origin - var11["segment"][0].origin);
  var16 = anglestoright(var15);
  var17 = anglestoleft(var15);
  var18 = vectorNormalize(var11["origin"] + var17 * var14 - level.player.origin);
  var19 = vectordot(var17, var18);
  var18 = vectorNormalize(var11["origin"] + var16 * var14 - level.player.origin);
  var20 = vectordot(var16, var18);

  if(var19 < 0 || var20 < 0) {
    level.stairtrain_rearguy.stairtrain_data = var11;
    return var11;
  }

  if(var11) {
    var4 = scripts\engine\utility::flat_origin(var11["segment"][0].origin);
    var5 = scripts\engine\utility::flat_origin(var11["segment"][1].origin);
    var21 = vectorNormalize(var5 - var4);
    var18 = vectorNormalize(scripts\engine\utility::flat_origin(level.player.origin) - scripts\engine\utility::flat_origin(var13["origin"]));
    var22 = vectordot(var21, var18);

    if(var22 < 0) {
      return var11;
    }

    var11.playerdistfrac = scripts\engine\math::lerp_fraction(var10.minplayerdist, var10.maxplayerdist, var13);
    var11.animratefrac = var11.playerdistfrac;

    if(var11.animratefrac < var10.animfrac_min * 0.5) {
      var11.animratefrac = 0;
    } else if(var11.animratefrac < var10.animfrac_min) {
      var11.animratefrac = var10.animfrac_min;
    }

    var11.animratefrac = clamp(var11.animratefrac, 0, 1.5);
  } else {
    var11.playerdistfrac = scripts\engine\math::lerp_fraction(var10.maxplayerdist, var10.minplayerdist, var13);
    var11.animratefrac = var11.playerdistfrac;

    if(var11.animratefrac < var10.animfrac_min * 0.5) {
      var11.animratefrac = 0;
    } else if(var11.animratefrac < var10.animfrac_min) {
      var11.animratefrac = var10.animfrac_min;
    }
  }

  var11.playerdistfrac = clamp(var11.playerdistfrac, 0, 1);

  if(var9.startonpath && var11.animratefrac < 0.5) {
    if(var14 < 1) {
      var11.playerdistfrac = 1;
      var11.animratefrac = 0.5;
    } else {
      var9.startonpath = 0;
    }
  }

  if(!var11) {
    var11.playerspeedfrac = scripts\engine\math::lerp_fraction(var10.minplayerspeeddist, var10.maxplayerspeeddist, var13);
    var11.playerspeedfrac = clamp(var11.playerspeedfrac, 0, 1);
  }

  level.stairtrain_rearguy.stairtrain_data = var11;
  return var11;
}

function init_path() {
  self.path = get_patharray(self);
  self.segments = get_segments(self);
  self.targetnode = scripts\engine\utility::getStruct(self.target, "targetname");
}

function get_closest_on_path(var0, var1) {
  var2 = var1.segments[0];
  var3 = pointonsegmentnearesttopoint(var1.segments[0][0].origin, var1.segments[0][1].origin, var0);
  var4 = distancesquared(var0, var3);
  var5 = var3;

  for(var6 = 1; var6 < var1.segments.size; var6++) {
    var3 = pointonsegmentnearesttopoint(var1.segments[var6][0].origin, var1.segments[var6][1].origin, var0);
    var7 = distancesquared(var0, var3);

    if(var7 < var4) {
      var2 = var1.segments[var6];
      var4 = var7;
      var5 = var3;
    }
  }

  GscBinSkip1(0x45, "origin", var5);
}

function get_dist_on_segment(var0, var1) {
  return var1[0].dist + distance(var0, var1[0].origin);
}

function get_patharray(var0) {
  var1 = [var0];
  var2 = 0;

  while(isDefined(var0.target)) {
    if(var2 == 0) {
      var0.dist = 0;
    }

    var2++;
    var3 = var0;
    var0 = scripts\engine\utility::getStruct(var0.target, "targetname");
    var1 = var0;
    var0.dist = var3.dist + distance(var0.origin, var3.origin);

    if(!isDefined(var0.radius)) {
      var0.radius = var3.radius;
    }
  }

  return var1;
}

function get_segments(var0) {
  var1 = [];

  for(var2 = 0; var2 < var0.path.size - 1; var2++) {
    var1 = [var0.path[var2], var0.path[var2 + 1]];
  }

  return var1;
}