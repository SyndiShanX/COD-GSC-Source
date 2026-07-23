/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1556.gsc
**************************************/

sp_airdrop_preload() {
  precacheitem("airdrop_marker_mp");
  precachemodel("com_plasticcase_friendly");
  precachemodel("com_plasticcase_enemy");
  precachemodel("com_plasticcase_taskforce141");
  precacheshader("compass_objpoint_ammo_friendly");
}

sp_airdrop_init() {
  if(!isDefined(level.startingkillstreakcrateobjid)) {
    level.startingkillstreakcrateobjid = 24;
  }
  level.numairdropcrates = 0;
  level.ad = spawnStruct();
  sp_airdrop_setup_crate_collisions();
  level.ad.globalinitdone = 1;
}

sp_airdrop_init_done() {
  return isDefined(level.ad) && isDefined(level.ad.globalinitdone);
}

sp_try_use_airdrop(var_0) {
  var_1 = undefined;

  if(maps/_sp_killstreaks::isusingremote()) {
    return 0;
  }
  var_1 = sp_begin_airdrop_via_marker(var_0);

  if((!isDefined(var_1) || !var_1) && !isDefined(self.airdropmarker)) {
    return 0;
  }
  return 1;
}

sp_begin_airdrop_via_marker(var_0) {
  self endon("death");
  self endon("airdrop_marker_thrown");
  self.airdropmarker = undefined;
  thread sp_watch_airdrop_marker_usage(var_0);
  var_1 = self getcurrentweapon();

  if(isairdropmarker(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = undefined;
  }
  while(isairdropmarker(var_1)) {
    self waittill("weapon_change", var_1);

    if(isairdropmarker(var_1)) {
      var_2 = var_1;
    }
  }

  self notify("stopWatchingAirDropMarker");

  if(!isDefined(var_2)) {
    return 0;
  }
  return !(self getammocount(var_2) && self hasweapon(var_2));
}

sp_watch_airdrop_marker_usage(var_0) {
  self notify("watchAirDropMarkerUsage");
  self endon("disconnect");
  self endon("watchAirDropMarkerUsage");
  self endon("stopWatchingAirDropMarker");
  thread sp_watch_airdrop_marker(var_0);

  for(;;) {
    self waittill("grenade_pullback", var_1);

    if(!isairdropmarker(var_1)) {
      continue;
    }
    common_scripts\utility::_disableusability();
    beginairdropmarkertracking();
  }
}

sp_watch_airdrop_marker(var_0) {
  self notify("watchAirDropMarker");
  self endon("watchAirDropMarker");
  self endon("spawned_player");
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_1, var_2);

    if(!isairdropmarker(var_2)) {
      continue;
    }
    self notify("airdrop_marker_thrown");
    var_1 thread airdropdetonateonstuck();
    var_1.owner = self;
    var_1.weaponname = var_2;
    self.airdropmarker = var_1;
    var_1 thread sp_airdrop_marker_activate(var_0);
  }
}

sp_airdrop_marker_activate(var_0) {
  self notify("airDropMarkerActivate");
  self endon("airDropMarkerActivate");
  self waittill("explode", var_1);
  var_2 = self.owner;

  if(!isDefined(var_2)) {
    return;
  }
  wait 0.05;
  level sp_airdrop_do_flyby(var_0, var_2, var_1, randomfloat(360));
}

sp_airdrop_do_flyby(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getflyheightoffset(var_2);

  if(!isDefined(var_4)) {
    var_4 = 0;
  }
  var_5 = var_5 + var_4;

  if(!isDefined(var_1)) {
    return;
  }
  var_6 = var_2 * (1, 1, 0) + (0, 0, var_5);
  var_7 = getpathstart(var_6, var_3);
  var_8 = getpathend(var_6, var_3);
  var_6 = var_6 + anglesToForward((0, var_3, 0)) * -50;
  var_9 = sp_airdrop_heli_setup(var_1, var_7, var_6);
  var_9 endon("death");
  var_9 setvehgoalpos(var_6, 1);
  var_9 thread sp_airdrop_drop_the_crate(var_0, var_2, var_5, 0, undefined, var_7);
  wait 2;
  var_9 vehicle_setspeed(75, 40);
  var_9 setyawspeed(180, 180, 180, 0.3);
  var_9 waittill("goal");
  wait 0.1;
  var_9 notify("drop_crate");
  var_9 setvehgoalpos(var_8, 1);
  var_9 vehicle_setspeed(300, 75);
  var_9.leaving = 1;
  var_9 waittill("goal");
  var_9 notify("leaving");
  var_9 notify("delete");
  var_9 delete();
}

sp_airdrop_heli_setup(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = getEnt("airdrop_littlebird", "targetname");
  var_4.origin = var_1;
  var_4.angles = var_3;
  var_5 = maps\_vehicle::spawn_vehicle_from_targetname("airdrop_littlebird");
  var_5 hide();

  if(!isDefined(var_5)) {
    return;
  }
  if(isDefined(self.mgturret)) {
    self notify("mg_off");

    foreach(var_7 in self.mgturret) {
      var_7 turretfiredisable();
      var_7 setmode("manual");
    }
  }

  var_5.health = 500;
  var_5 setCanDamage(0);
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5 thread heli_existence();
  var_5 setmaxpitchroll(45, 85);
  var_5 vehicle_setspeed(250, 175);
  var_5 common_scripts\utility::delaycall(0.1, ::show);
  return var_5;
}

heli_existence() {
  common_scripts\utility::waittill_any("crashing", "leaving");
  self notify("helicopter_gone");
}

sp_airdrop_drop_the_crate(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  self.owner endon("disconnect");
  var_6 = sp_create_airdrop_crate(self.owner, var_0, var_5);
  var_6 linkTo(self, "tag_ground", (32, 0, 5), (0, 0, 0));
  var_6.angles = (0, 0, 0);
  var_6 show();
  var_7 = self.veh_speed;
  self waittill("drop_crate");
  var_6 unlink();
  var_6 physicslaunchserver((0, 0, 0), (randomint(5), randomint(5), randomint(5)));
  var_6 thread sp_airdrop_crate_physics_waiter();
  var_6 thread sp_airdrop_crate_damage_enemies_on_fall(var_1, 64);
}

sp_create_airdrop_crate(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_2);
  var_3.inuse = 0;
  var_3.curprogress = 0;
  var_3.usetime = 0;
  var_3.userate = 0;

  if(isDefined(var_0)) {
    var_3.owner = var_0;
  } else {
    var_3.owner = undefined;
  }
  var_3.cratetype = var_1;
  var_3.targetname = "care_package";
  var_3 setModel("com_plasticcase_taskforce141");
  var_3 sp_airdrop_crate_attach_collision();
  var_3.collision thread sp_airdrop_crate_unlink_collision(var_3);
  var_3.basemodel = spawn("script_model", var_2);
  var_3.basemodel setModel("com_plasticcase_friendly");
  var_3.basemodel common_scripts\utility::delaycall(0.25, ::linkto, var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_3 thread sp_airdrop_crate_delete_on_owner_death(var_0);
  level.numairdropcrates++;
  return var_3;
}

sp_delete_airdrop_crate() {
  if(isDefined(self.objidfriendly)) {
    objective_delete(self.objidfriendly);
  }
  if(isDefined(level.crates_on_ground) && level.crates_on_ground.size) {
    level.crates_on_ground = common_scripts\utility::array_remove(level.crates_on_ground, self);
    level.numairdropcrates--;
  }

  if(isDefined(self)) {
    self.basemodel delete();
    self delete();
  }
}

sp_airdrop_setup_crate_collisions() {
  var_0 = getEntArray("airdrop_crate_collision", "targetname");

  foreach(var_2 in var_0) {
    var_2 connectpaths();
    var_2 notsolid();
  }

  level.airdropcratecollisionboxes = var_0;
}

sp_airdrop_get_free_sbmodel_collision() {
  var_0 = undefined;

  foreach(var_2 in level.airdropcratecollisionboxes) {
    if(!isDefined(var_2.isinuse)) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

sp_airdrop_crate_attach_collision() {
  var_0 = sp_airdrop_get_free_sbmodel_collision();
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0 solid();
  var_0 linkTo(self);
  var_0.isinuse = 1;
  self.collision = var_0;
}

sp_airdrop_crate_damage_enemies_on_fall(var_0, var_1) {
  while(isDefined(self) && distancesquared(self.origin, var_0) > 1024) {
    wait 0.05;
  }
  if(!isDefined(self)) {
    return;
  }
  var_2 = getaispeciesarray("axis", "all");

  foreach(var_4 in var_2) {
    if(distancesquared(self.origin, var_4.origin) < var_1 * var_1) {
      if(isDefined(self.owner)) {
        var_4 dodamage(300, self.origin, self.owner, self);
        continue;
      }

      var_4 dodamage(300, self.origin);
    }
  }
}

sp_airdrop_crate_delete_on_owner_death(var_0) {
  var_0 waittill("death");
  sp_delete_airdrop_crate();
}

sp_airdrop_crate_unlink_collision(var_0) {
  var_0 waittill("death");
  self unlink();
  self connectpaths();
  self notsolid();
  self.isinuse = undefined;
}

sp_airdrop_crate_physics_waiter() {
  self waittill("physics_finished");
  self.crate_num = gettime();

  if(!isDefined(level.crates_on_ground)) {
    level.crates_on_ground = [];
  }
  level.crates_on_ground[level.crates_on_ground.size] = self;

  if(level.crates_on_ground.size > 4) {
    level.crates_on_ground[0] sp_delete_airdrop_crate();
  }
  thread sp_airdrop_crate_think();
  level thread sp_airdrop_crate_timeout(self, self.owner);
}

sp_airdrop_crate_timeout(var_0, var_1) {
  var_0 endon("death");
  var_2 = 120;

  if(isDefined(level.airdropcratetimeout)) {
    var_2 = level.airdropcratetimeout;
  }
  if(var_2 <= 0) {
    return;
  }
  wait(var_2);

  while(var_0.curprogress != 0) {
    wait 1;
  }
  var_0 sp_delete_airdrop_crate();
}

sp_airdrop_crate_think() {
  self endon("death");
  sp_airdrop_crate_setup_for_use();
  thread sp_airdrop_crate_owner_capture_think();
  thread sp_airdrop_teammate_capture_think();

  if(isDefined(level.sp_airdrop_crate_custom_thread)) {
    self thread[[level.sp_airdrop_crate_custom_thread]]();
  }
  for(;;) {
    self waittill("captured", var_0);

    if(isDefined(self.owner) && var_0 != self.owner) {
      thread sp_airdrop_crate_hijack_notify(var_0);
    }
    if(isPlayer(var_0)) {
      var_1 = var_0;
      var_1 playlocalsound("ammo_crate_use");

      if(isDefined(self.killstreakinfo.crateopenfunc)) {
        if(issubstr(self.killstreakinfo.streaktype, "specialty_")) {
          var_1 thread[[self.killstreakinfo.crateopenfunc]](self.killstreakinfo.streaktype);
        } else {
          var_1 thread[[self.killstreakinfo.crateopenfunc]]();
        }
      } else {
        var_1 thread maps/_sp_killstreaks::give_sp_killstreak(self.cratetype);
      }
    }

    sp_delete_airdrop_crate();
  }
}

sp_airdrop_crate_hijack_notify(var_0) {
  self notify("hijacked", var_0);

  if(!isPlayer(self.owner)) {
    return;
  }
  if(var_0.team == self.owner.team) {
    if(isDefined(level.sp_airdrop_crate_friendly_hijack_thread)) {
      self.owner thread[[level.sp_airdrop_crate_friendly_hijack_thread]](var_0);
    }
  } else if(isDefined(level.sp_airdrop_crate_enemy_hijack_thread)) {
    self.owner thread[[level.sp_airdrop_crate_enemy_hijack_thread]](var_0);
  }
}

sp_airdrop_crate_setup_for_use() {
  self.collision disconnectPaths();
  var_0 = maps/_sp_killstreaks::get_sp_killstreak_info(self.cratetype);
  self.killstreakinfo = var_0;
  var_1 = sp_airdrop_get_crate_obj_id();
  objective_add(var_1, "invisible", (0, 0, 0));
  objective_position(var_1, self.origin);
  objective_icon(var_1, "compass_objpoint_ammo_friendly");
  self.objidfriendly = var_1;
  sp_crate_world_icon(var_0.crateicon, (0, 0, 24), 14, 14);
  self setCursorHint("HINT_NOICON");
  self setHintString(var_0.cratehint);
  self makeusable();

  if(isDefined(level.airdropcrateunstuck) && level.airdropcrateunstuck) {
    thread sp_airdrop_unstuck_think();
  }
}

sp_airdrop_unstuck_think() {
  self endon("death");
  self endon("captured");
  wait 2;
  var_0 = undefined;
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(self.collision) && self.collision istouching(var_3)) {
      if(isDefined(self.owner) && self.owner == var_3) {
        var_0 = var_3;
        continue;
      }

      var_1[var_1.size] = var_3;
    }
  }

  if(isDefined(var_0)) {
    self notify("trigger", var_0);
    return;
  }

  if(var_1.size > 0) {
    self notify("trigger", var_1[0]);
  }
}

sp_airdrop_get_crate_obj_id() {
  var_0 = undefined;

  if(!isDefined(level.lastusedkillstreakcrateobjid)) {
    var_0 = level.startingkillstreakcrateobjid;
  } else {
    var_0 = level.lastusedkillstreakcrateobjid + 1;
  }
  if(var_0 > level.startingkillstreakcrateobjid + 7) {
    var_0 = level.startingkillstreakcrateobjid;
  }
  level.lastusedkillstreakcrateobjid = var_0;
  return var_0;
}

sp_crate_world_icon(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.archived = 1;
  var_4.x = self.origin[0] + var_1[0];
  var_4.y = self.origin[1] + var_1[1];
  var_4.z = self.origin[2] + var_1[2];
  var_4.alpha = 0.85;
  var_4 setshader(var_0, var_2, var_3);
  var_4 setwaypoint(1, 1, 0);
  var_4 thread keeppositioned(self, var_1);
  self.crateworldicon = var_4;
  thread destroyiconsondeath();
}

sp_airdrop_crate_owner_capture_think() {
  while(isDefined(self)) {
    self waittill("trigger", var_0);

    if(isDefined(self.owner) && var_0 != self.owner) {
      continue;
    }
    if(!sp_use_hold_think(var_0, 500)) {
      continue;
    }
    self notify("captured", var_0);
    level notify("crate_captured");
  }
}

sp_airdrop_teammate_capture_think() {
  while(isDefined(self)) {
    self waittill("trigger", var_0);

    if(isDefined(self.owner) && var_0 == self.owner) {
      continue;
    }
    if(!sp_use_hold_think(var_0)) {
      continue;
    }
    self notify("captured", var_0);
    level notify("crate_captured");
  }
}

sp_use_hold_think(var_0, var_1) {
  var_0 freezecontrols(1);
  var_0 common_scripts\utility::_disableweapon();
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;

  if(isDefined(level.airdropcrateusetime)) {
    self.usetime = level.airdropcrateusetime;
  } else if(isDefined(var_1)) {
    self.usetime = var_1;
  } else {
    self.usetime = 3000;
  }
  if(self.usetime > 0) {
    var_0 thread sp_personal_use_bar(self);
    var_2 = sp_use_hold_think_loop(var_0);
  } else {
    var_2 = 1;
  }
  if(isalive(var_0)) {
    var_0 common_scripts\utility::_enableweapon();
    var_0 freezecontrols(0);
  }

  if(!isDefined(self)) {
    return 0;
  }
  self.inuse = 0;
  self.curprogress = 0;
  return var_2;
}

sp_use_hold_think_loop(var_0) {
  while(isDefined(self) && isalive(var_0) && var_0 useButtonPressed() && self.curprogress < self.usetime) {
    self.curprogress = self.curprogress + 50 * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }
    if(self.curprogress >= self.usetime) {
      return isalive(var_0);
    }
    wait 0.05;
  }

  return 0;
}

sp_personal_use_bar(var_0) {
  self endon("disconnect");
  var_1 = createprimaryprogressbar(-25);
  var_2 = createprimaryprogressbartext(-25);
  var_2 settext(&"SP_KILLSTREAKS_CAPTURING_CRATE");
  var_3 = -1;

  while(isalive(self) && isDefined(var_0) && var_0.inuse) {
    if(var_3 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }
      var_1 updatebar(var_0.curprogress / var_0.usetime, 1000 / var_0.usetime * var_0.userate);

      if(!var_0.userate) {
        var_1 hideelem();
        var_2 hideelem();
      } else {
        var_1 showelem();
        var_2 showelem();
      }
    }

    var_3 = var_0.userate;
    wait 0.05;
  }

  var_1 destroyelem();
  var_2 destroyelem();
}

getflyheightoffset(var_0) {
  var_1 = 850;
  var_2 = getEnt("airstrikeheight", "targetname");

  if(!isDefined(var_2)) {
    if(isDefined(level.airstrikeheightscale)) {
      if(level.airstrikeheightscale > 2) {
        var_1 = 1500;
        return var_1 * level.airstrikeheightscale;
      }

      return var_1 * level.airstrikeheightscale + 256 + var_0[2];
    } else {
      return var_1 + var_0[2];
    }
  } else {
    return var_2.origin[2];
  }
}

getpathstart(var_0, var_1) {
  var_2 = 100;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_3);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

getpathend(var_0, var_1) {
  var_2 = 150;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4 + (0, 90, 0)) * var_3;
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

isairdropmarker(var_0) {
  switch (var_0) {
    case "airdrop_sentry_marker_mp":
    case "airdrop_mega_marker_mp":
    case "airdrop_marker_mp":
      return 1;
    default:
      return 0;
  }
}

beginairdropmarkertracking() {
  self notify("beginAirDropMarkerTracking");
  self endon("beginAirDropMarkerTracking");
  self endon("death");
  self endon("disconnect");
  common_scripts\utility::waittill_any("grenade_fire", "weapon_change");
  common_scripts\utility::_enableusability();
}

airdropdetonateonstuck() {
  self endon("death");
  self waittill("missile_stuck");
  self detonate();
}

destroyiconsondeath() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");
  self.crateworldicon destroy();
}

keeppositioned(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_2 = var_0.origin;

  for(;;) {
    if(var_2 != var_0.origin) {
      var_2 = var_0.origin;
      self.x = var_2[0] + var_1[0];
      self.y = var_2[0] + var_1[0];
      self.z = var_2[0] + var_1[0];
    }

    wait 0.05;
  }
}

keepiconpositioned() {
  self endon("kill_entity_headicon_thread");
  self endon("death");
  var_0 = self.origin;

  for(;;) {
    if(var_0 != self.origin) {
      updateheadiconorigin();
      var_0 = self.origin;
    }

    wait 0.05;
  }
}

destroyheadiconsondeath() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");

  if(!isDefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

updateheadiconorigin() {
  self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
  self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
  self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

createprimaryprogressbartext(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  var_1 = maps\_hud_util::createserverclientfontstring("hudbig", level.primaryprogressbarfontsize);
  var_1.hidden = 0;
  var_1 setpoint("CENTER", undefined, level.primaryprogressbartextx, level.primaryprogressbartexty - var_0);
  var_1.sort = -1;
  return var_1;
}

createprimaryprogressbar(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  var_1 = createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  var_1 setpoint("CENTER", undefined, level.primaryprogressbarx, level.primaryprogressbary - var_0);
  return var_1;
}

createbar(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.frac = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4.shader = "progress_bar_fill";
  var_4 setshader("progress_bar_fill", var_1, var_2);
  var_4.hidden = 0;

  if(isDefined(var_3)) {
    var_4.flashfrac = var_3;
  }
  var_5 = newclienthudelem(self);
  var_5.elemtype = "bar";
  var_5.width = var_1;
  var_5.height = var_2;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_4;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_5.padding = 0;
  var_5 maps\_hud_util::setparent(level.uiparent);
  var_5 setshader("progress_bar_bg", var_1 + 4, var_2 + 4);
  var_5.hidden = 0;
  return var_5;
}

setpoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }
  var_5 = maps\_hud_util::getparent();

  if(var_4) {
    self moveovertime(var_4);
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  self.xoffset = var_2;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  self.yoffset = var_3;
  self.point = var_0;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var_0, "TOP")) {
    self.aligny = "top";
  }
  if(issubstr(var_0, "BOTTOM")) {
    self.aligny = "bottom";
  }
  if(issubstr(var_0, "LEFT")) {
    self.alignx = "left";
  }
  if(issubstr(var_0, "RIGHT")) {
    self.alignx = "right";
  }
  if(!isDefined(var_1)) {
    var_1 = var_0;
  }
  self.relativepoint = var_1;
  var_6 = "center_adjustable";
  var_7 = "middle";

  if(issubstr(var_1, "TOP")) {
    var_7 = "top_adjustable";
  }
  if(issubstr(var_1, "BOTTOM")) {
    var_7 = "bottom_adjustable";
  }
  if(issubstr(var_1, "LEFT")) {
    var_6 = "left_adjustable";
  }
  if(issubstr(var_1, "RIGHT")) {
    var_6 = "right_adjustable";
  }
  if(var_5 == level.uiparent) {
    self.horzalign = var_6;
    self.vertalign = var_7;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(strip_suffix(var_6, "_adjustable") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_6 == "center" || var_5.alignx == "center") {
    var_8 = int(var_5.width / 2);

    if(var_6 == "left_adjustable" || var_5.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_5.width;

    if(var_6 == "left_adjustable") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_5.x + var_8 * var_9;

  if(strip_suffix(var_7, "_adjustable") == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_7 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5.height / 2);

    if(var_7 == "top_adjustable" || var_5.aligny == "bottom") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  } else {
    var_10 = var_5.height;

    if(var_7 == "top_adjustable") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  }

  self.y = var_5.y + var_10 * var_11;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;

  switch (self.elemtype) {
    case "bar":
      setpointbar(var_0, var_1, var_2, var_3);
      break;
  }

  maps\_hud_util::updatechildren();
}

setpointbar(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left") {
    self.bar.x = self.x;
  } else if(self.alignx == "right") {
    self.bar.x = self.x - self.width;
  } else {
    self.bar.x = self.x - int(self.width / 2);
  }
  if(self.aligny == "top") {
    self.bar.y = self.y;
  } else if(self.aligny == "bottom") {
    self.bar.y = self.y;
  }
  updatebar(self.bar.frac);
}

updatebar(var_0, var_1) {
  if(self.elemtype == "bar") {
    updatebarscale(var_0, var_1);
  }
}

updatebarscale(var_0, var_1) {
  var_2 = int(self.width * var_0 + 0.5);

  if(!var_2) {
    var_2 = 1;
  }
  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_2, self.height);

  if(isDefined(var_1) && var_2 < self.width) {
    if(var_1 > 0) {
      self.bar scaleovertime((1 - var_0) / var_1, self.width, self.height);
    } else if(var_1 < 0) {
      self.bar scaleovertime(var_0 / (-1 * var_1), 1, self.height);
    }
  }

  self.bar.rateofchange = var_1;
  self.bar.lastupdatetime = gettime();
}

hideelem() {
  if(self.hidden) {
    return;
  }
  self.hidden = 1;

  if(self.alpha != 0) {
    self.alpha = 0;
  }
  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar.hidden = 1;

    if(self.bar.alpha != 0) {
      self.bar.alpha = 0;
    }
  }
}

showelem() {
  if(!self.hidden) {
    return;
  }
  self.hidden = 0;

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    if(self.alpha != 0.5) {
      self.alpha = 0.5;
    }
    self.bar.hidden = 0;

    if(self.bar.alpha != 1) {
      self.bar.alpha = 1;
    }
  } else if(self.alpha != 1) {
    self.alpha = 1;
  }
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }
  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return getsubstr(var_0, 0, var_0.size - var_1.size);
  }
  return var_0;
}

destroyelem() {
  var_0 = [];

  for(var_1 = 0; var_1 < self.children.size; var_1++) {
    if(isDefined(self.children[var_1])) {
      var_0[var_0.size] = self.children[var_1];
    }
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] maps\_hud_util::setparent(maps\_hud_util::getparent());
  }
  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar destroy();
  }
  self destroy();
}