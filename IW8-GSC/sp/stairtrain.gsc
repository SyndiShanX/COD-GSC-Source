/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\stairtrain.gsc
***********************************************/

stairtrain_thread(var_0, var_1, var_2) {
  if(!scripts\engine\utility::ent_flag_exist("stairtrain_on"))
    scripts\engine\utility::ent_flag_init("stairtrain_on");

  if(!scripts\engine\utility::flag_exist("stairtrain_pause"))
    scripts\engine\utility::flag_init("stairtrain_pause");

  if(!scripts\engine\utility::flag_exist("stairtrain_nagging"))
    scripts\engine\utility::flag_init("stairtrain_nagging");

  scripts\engine\utility::flag_clear("stairtrain_nagging");
  scripts\engine\utility::ent_flag_set("stairtrain_on");

  if(!isDefined(var_0.animfrac_min))
    var_0.animfrac_min = 0.5;

  self.stairtrain = spawnStruct();
  self.stairtrain.skiplogic = 0;
  self.stairtrain.safestop = 1;
  waitframe();

  if(!isDefined(var_0.base_anime))
    var_0.base_anime = "stairtrain";

  thread stairtrain_notetracks(var_0.base_anime);
  var_3 = getstartorigin(var_0.animnode.origin, var_0.animnode.angles, var_0.base_anim);
  var_4 = getstartangles(var_0.animnode.origin, var_0.animnode.angles, var_0.base_anim);
  self forceteleport(var_3, var_4);
  self orientmode("face angle", var_4[1]);
  self setflaggedanim(var_0.base_anime, var_0.base_anim, 1.0, 0.4, 0);
  var_5 = getanimlength(var_0.base_anim);
  var_6 = 0;
  level.stairtrain_rate = 1;

  if(!isDefined(var_0.base_speedscale))
    var_0.base_speedscale = 1;

  var_7 = 1;
  var_8 = isDefined(var_0.playerlead);

  if(isDefined(var_0.additive_anim))
    self setanim(var_0.additive_anim, 0, 0.2);

  var_9 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_9 init_path();
  var_9.startonpath = isDefined(var_0.startonpath);
  var_10 = 0;
  var_0.nagtime = gettime() + 3000;
  var_11 = "none";
  var_12 = 0;
  var_13 = gettime() + randomintrange(5000, 10000);

  for(;;) {
    if(self getanimtime(var_0.base_anim) >= 1) {
      break;
    }

    var_14 = stairtrain_player_data(var_9, var_0);

    if(self.stairtrain.skiplogic) {
      self setanimrate(var_0.base_anim, 1);

      if(isDefined(var_0.settle_anim))
        self clearanim(var_0.settle_anim, 0.2);

      if(isDefined(var_0.additive_anim))
        self clearanim(var_0.additive_anim, 0.2);

      if(isDefined(var_0.idle_twitch))
        clear_idle_twitch(var_0);

      if(!var_8 && self == level.stairtrain_rearguy)
        level.player scripts\engine\sp\utility::blend_movespeedscale(var_14.playerspeedfrac * var_0.base_speedscale, 0.05);

      waitframe();
      continue;
    }

    if(getdvarint("scr_debug_stairtrain")) {}

    if(var_14.animratefrac > 0 && !scripts\engine\utility::flag("stairtrain_nagging")) {
      if(isDefined(var_0.settle_anim) && var_11 == "settling")
        self clearanim(var_0.settle_anim, 0.4);

      if(isDefined(var_0.additive_anim) && var_11 == "idling")
        self clearanim(var_0.additive_anim, 0.4);

      if(isDefined(var_0.additive_branch))
        self clearanim(var_0.additive_branch, 0.4);

      if(isDefined(var_0.idle_twitch))
        clear_idle_twitch(var_0);

      var_12 = 0;
      var_11 = "none";

      if(self == level.stairtrain_rearguy && !var_9.startonpath) {
        if(isDefined(var_14.playerspeedfrac))
          level.player scripts\engine\sp\utility::blend_movespeedscale(var_14.playerspeedfrac * var_0.base_speedscale, 0.05);
      }

      var_15 = level.stairtrain_rate * var_14.animratefrac;
      self setanimrate(var_0.base_anim, var_15);
      var_10 = var_14.playerdistfrac;
    } else if(canstop()) {
      var_10 = 0;

      if(self == level.stairtrain_rearguy)
        level.player scripts\engine\sp\utility::blend_movespeedscale(var_0.base_speedscale, 0.3);

      self setanimrate(var_0.base_anim, 0);

      if(isDefined(var_0.settle_anim)) {
        if(var_11 == "none") {
          var_11 = "settling";
          self setflaggedanimrestart(var_0.base_anime + "_settle", var_0.settle_anim, 1.0, 0.2);
        } else if(var_11 == "settling") {
          if(self getanimtime(var_0.settle_anim) == 1) {
            self clearanim(var_0.settle_anim, 0.4);
            var_11 = "startidle";
          }
        }
      }

      if(isDefined(var_0.additive_anim)) {
        if(var_11 == "startidle") {
          var_11 = "idling";
          var_0.nagtime = gettime() + randomintrange(3000, 5000);
          var_15 = randomfloatrange(0.7, 1.0);
          self setflaggedanim(var_0.base_anime + "_additive", var_0.additive_anim, 1.0, 0.2, var_15);
        } else if(var_11 == "idling")
          do_idle_twitch(var_0);
      } else if(var_11 != "settling")
        var_11 = "idling";

      if(var_11 == "idling")
        try_nag(var_0);
    }

    waitframe();
  }

  self notify("stairtrain_end");
  self notify("stairtrain_stop_notetracks");
  self.stairtrain = undefined;
  self.stairtrain_prevguy = undefined;
  self clearanim(var_0.base_anim, 0.2);

  if(isDefined(var_0.settle_anim))
    self clearanim(var_0.settle_anim, 0.2);

  if(isDefined(var_0.additive_anim))
    self clearanim(var_0.additive_anim, 0.2);

  if(isDefined(var_0.idle_twitch))
    clear_idle_twitch(var_0);

  if(self == level.stairtrain_rearguy)
    level.player scripts\engine\sp\utility::blend_movespeedscale(var_0.base_speedscale, 0.5);

  level notify("stairtrain_reached_end");
  scripts\engine\utility::ent_flag_clear("stairtrain_on");
}

do_idle_twitch(var_0) {
  if(!isDefined(var_0.fnadditive_twitch_get)) {
    return;
  }
  if(isDefined(var_0.idle_twitch)) {
    if(self getanimtime(var_0.idle_twitch) == 1) {
      clear_idle_twitch(var_0);
      var_0.next_twitch_time = gettime() + randomintrange(4000, 15000);
      self setanim(var_0.additive_anim, 1, 0.2);
    }
  } else {
    if(!isDefined(var_0.next_twitch_time)) {
      var_0.next_twitch_time = gettime() + randomintrange(4000, 15000);
      return;
    }

    if(gettime() < var_0.next_twitch_time) {
      return;
    }
    self setanim(var_0.additive_anim, 0, 0.2);
    var_0.idle_twitch = [[var_0.fnadditive_twitch_get]]();
    self setflaggedanim(var_0.base_anime + "_additive_twitch", var_0.idle_twitch, 1, 0.2, 1);
  }
}

clear_idle_twitch(var_0) {
  self clearanim(var_0.idle_twitch, 0.2);
  var_0.idle_twitch = undefined;
}

try_nag(var_0) {
  if(!isDefined(var_0.fnnag))
    return 0;

  if(gettime() < var_0.nagtime) {
    return;
  }
  if(level.stairtrain_rearguy != self) {
    return;
  }
  if(scripts\engine\utility::flag("stairtrain_nagging")) {
    return;
  }
  if(gettime() > var_0.nagtime) {
    var_1 = 0;

    if(isDefined(var_0.nag_anim)) {
      var_1 = 1;
      thread nag_anim(var_0);
    }

    thread[[var_0.fnnag]]();

    if(!var_1)
      var_0.nagtime = gettime() + randomintrange(5000, 10000);
  }
}

nag_anim(var_0) {
  var_1 = "something";
  scripts\engine\utility::flag_set("stairtrain_nagging");
  self setflaggedanimrestart(var_1, var_0.nag_anim, 1, 0.2, 1);
  self waittillmatch(var_1, "end");
  self clearanim(var_0.nag_anim, 0.2);
  scripts\engine\utility::flag_clear("stairtrain_nagging");
  var_0.nagtime = gettime() + randomintrange(5000, 10000);
}

set_prevguy(var_0) {
  self.stairtrain_prevguy = var_0;
}

canstop() {
  return self.stairtrain.safestop;
}

stairtrain_notetracks(var_0) {
  self endon("death");
  self notify("stairtrain_stop_notetracks");
  self endon("stairtrain_stop_notetracks");
  childthread scripts\sp\anim::animscriptdonotetracksthread(self, var_0);
  var_1 = [];
  var_2 = spawnStruct();
  var_2.dialog = [];
  var_2.dialoguenotetrack = 0;
  var_3 = self.animname;

  if(isDefined(level.scr_notetrack[var_3])) {
    if(isDefined(level.scr_notetrack[var_3][var_0]))
      var_1[var_0] = level.scr_notetrack[var_3][var_0];

    if(isDefined(level.scr_notetrack[var_3]["any"]))
      var_1["any"] = level.scr_notetrack[var_3]["any"];
  }

  foreach(var_12, var_5 in var_1) {
    foreach(var_7 in level.scr_notetrack[var_3][var_12]) {
      foreach(var_9 in var_7) {
        if(isDefined(var_9["dialog"]))
          var_2.dialog[var_9["dialog"]] = 1;
      }
    }
  }

  for(;;) {
    self waittill(var_0, var_13);

    if(!isarray(var_13) && var_13 == "end") {
      return;
    }
    foreach(var_15 in var_13) {
      scripts\common\notetrack::notetrack_handler(self, var_0, var_15, self.animname, var_1, self, var_2);

      switch (var_15) {
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

stairtrain_player_data(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.playerdistfrac = 0;
  var_2.animratefrac = 0;
  var_3 = isDefined(var_1.playerlead);

  if(scripts\engine\utility::flag("stairtrain_pause"))
    return var_2;

  if(self != level.stairtrain_rearguy) {
    if(isDefined(self.stairtrain_prevguy)) {
      var_4 = scripts\engine\utility::flat_origin(self.stairtrain_prevguy.origin);
      var_5 = scripts\engine\utility::flat_origin(self.origin);
      var_6 = distance(var_4, var_5);

      if(getdvarint("scr_debug_stairtrain")) {}

      var_7 = 23;

      if(isDefined(var_1.prevguy_dist_max))
        var_7 = var_1.prevguy_dist_max;

      var_8 = 1 - scripts\engine\math::lerp_fraction(19, var_7, var_6);
      var_2.playerdistfrac = 1;

      if(var_8 > 0 && var_8 < var_1.animfrac_min)
        var_8 = var_1.animfrac_min;
      else if(var_8 < 0)
        var_8 = 0;

      var_2.animratefrac = var_8;
      return var_2;
    } else if(isDefined(level.stairtrain_rearguy.stairtrain_data))
      return level.stairtrain_rearguy.stairtrain_data;
    else
      return var_2;
  }

  var_9 = get_closest_on_path(level.stairtrain_rearguy.origin, var_0);
  var_10 = get_dist_on_segment(var_9["origin"], var_9["segment"]);

  if(var_10 < 1) {
    var_11 = [];
    var_11["segment"] = var_0.segments[0];
    var_11["origin"] = level.stairtrain_rearguy.origin;
    var_12 = distance(level.player.origin, var_11["origin"]);
    var_13 = var_12 - var_10;
    var_14 = var_1.maxplayerdist;
  } else if(var_10 < var_1.maxplayerdist) {
    var_11 = get_closest_on_path(level.player.origin, var_0);
    var_13 = distance(level.player.origin, var_9["origin"]);
    var_14 = var_11["segment"][0].radius;
  } else {
    var_11 = get_closest_on_path(level.player.origin, var_0);
    var_12 = get_dist_on_segment(var_11["origin"], var_11["segment"]);
    var_14 = var_11["segment"][0].radius;
    var_13 = abs(var_10 - var_12);
  }

  var_15 = vectortoangles(var_11["segment"][1].origin - var_11["segment"][0].origin);
  var_16 = anglestoright(var_15);
  var_17 = anglestoleft(var_15);
  var_18 = vectorNormalize(var_11["origin"] + var_17 * var_14 - level.player.origin);
  var_19 = vectordot(var_17, var_18);
  var_18 = vectorNormalize(var_11["origin"] + var_16 * var_14 - level.player.origin);
  var_20 = vectordot(var_16, var_18);

  if(var_19 < 0 || var_20 < 0) {
    level.stairtrain_rearguy.stairtrain_data = var_2;
    return var_2;
  }

  if(var_3) {
    var_4 = scripts\engine\utility::flat_origin(var_11["segment"][0].origin);
    var_5 = scripts\engine\utility::flat_origin(var_11["segment"][1].origin);
    var_21 = vectorNormalize(var_5 - var_4);
    var_18 = vectorNormalize(scripts\engine\utility::flat_origin(level.player.origin) - scripts\engine\utility::flat_origin(var_9["origin"]));
    var_22 = vectordot(var_21, var_18);

    if(var_22 < 0)
      return var_2;

    var_2.playerdistfrac = scripts\engine\math::lerp_fraction(var_1.minplayerdist, var_1.maxplayerdist, var_13);
    var_2.animratefrac = var_2.playerdistfrac;

    if(var_2.animratefrac < var_1.animfrac_min * 0.5)
      var_2.animratefrac = 0;
    else if(var_2.animratefrac < var_1.animfrac_min)
      var_2.animratefrac = var_1.animfrac_min;

    var_2.animratefrac = clamp(var_2.animratefrac, 0, 1.5);
  } else {
    var_2.playerdistfrac = scripts\engine\math::lerp_fraction(var_1.maxplayerdist, var_1.minplayerdist, var_13);
    var_2.animratefrac = var_2.playerdistfrac;

    if(var_2.animratefrac < var_1.animfrac_min * 0.5)
      var_2.animratefrac = 0;
    else if(var_2.animratefrac < var_1.animfrac_min)
      var_2.animratefrac = var_1.animfrac_min;
  }

  var_2.playerdistfrac = clamp(var_2.playerdistfrac, 0, 1);

  if(var_0.startonpath && var_2.animratefrac < 0.5) {
    if(var_10 < 1) {
      var_2.playerdistfrac = 1;
      var_2.animratefrac = 0.5;
    } else
      var_0.startonpath = 0;
  }

  if(!var_3) {
    var_2.playerspeedfrac = scripts\engine\math::lerp_fraction(var_1.minplayerspeeddist, var_1.maxplayerspeeddist, var_13);
    var_2.playerspeedfrac = clamp(var_2.playerspeedfrac, 0, 1);
  }

  level.stairtrain_rearguy.stairtrain_data = var_2;
  return var_2;
}

init_path() {
  self.path = get_patharray(self);
  self.segments = get_segments(self);
  self.targetnode = scripts\engine\utility::getStruct(self.target, "targetname");
}

get_closest_on_path(var_0, var_1) {
  var_2 = var_1.segments[0];
  var_3 = pointonsegmentnearesttopoint(var_1.segments[0][0].origin, var_1.segments[0][1].origin, var_0);
  var_4 = distancesquared(var_0, var_3);
  var_5 = var_3;

  for(var_6 = 1; var_6 < var_1.segments.size; var_6++) {
    var_3 = pointonsegmentnearesttopoint(var_1.segments[var_6][0].origin, var_1.segments[var_6][1].origin, var_0);
    var_7 = distancesquared(var_0, var_3);

    if(var_7 < var_4) {
      var_2 = var_1.segments[var_6];
      var_4 = var_7;
      var_5 = var_3;
    }
  }

  var_8["origin"] = var_5;
  var_8["segment"] = var_2;
  return var_8;
}

get_dist_on_segment(var_0, var_1) {
  return var_1[0].dist + distance(var_0, var_1[0].origin);
}

get_patharray(var_0) {
  var_1 = [var_0];
  var_2 = 0;

  while(isDefined(var_0.target)) {
    if(var_2 == 0)
      var_0.dist = 0;

    var_2++;
    var_3 = var_0;
    var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_1[var_1.size] = var_0;
    var_0.dist = var_3.dist + distance(var_0.origin, var_3.origin);

    if(!isDefined(var_0.radius))
      var_0.radius = var_3.radius;
  }

  return var_1;
}

get_segments(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.path.size - 1; var_2++)
    var_1[var_1.size] = [var_0.path[var_2], var_0.path[var_2 + 1]];

  return var_1;
}