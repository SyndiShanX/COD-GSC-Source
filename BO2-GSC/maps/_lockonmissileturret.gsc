/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_lockonmissileturret.gsc
*****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_dds;

init(buseadslockon, func_getbestmissileturrettarget, maxtargets, bmanualtargetset) {
  game["locking_on_sound"] = "wpn_sam_locking";
  game["locked_on_sound"] = "wpn_sam_lockon";
  game["locked_on_loop"] = "wpn_f35_lockon";
  game["acquired_sound"] = "wpn_sam_acquired";
  game["killshot_sound"] = "wpn_sam_hit";
  game["tracking_sound"] = "wpn_sam_tracking";
  game["lost_target_sound"] = "wpn_sam_target_lost";
  game["tracking_loop_sound"] = "wpn_sam_tracking_loop";
  precachestring(&"hud_weapon_locking");
  precachestring(&"hud_weapon_locked");
  precachestring(&"hud_missile_fire");
  precachestring(&"hud_turret_zoom");

  if(!isDefined(buseadslockon))
    buseadslockon = 0;

  game["missileTurret_useadslockon"] = buseadslockon;
  thread onplayerconnect();

  if(!isDefined(func_getbestmissileturrettarget))
    level.func_getbestmissileturrettarget = ::getbestmissileturrettarget;
  else
    level.func_getbestmissileturrettarget = func_getbestmissileturrettarget;

  if(!isDefined(maxtargets))
    level.missileturretmaxtargets = 1;
  else
    level.missileturretmaxtargets = maxtargets;

  if(!isDefined(bmanualtargetset))
    level.bmanualtargetset = 0;
  else
    level.bmanualtargetset = bmanualtargetset;
}

main() {
  self endon("disconnect");
  self endon("death");
  self.lockonmissilezoom = 0;

  for(;;) {
    self waittill_any("turretownerchange", "enter_vehicle");

    if(usingvalidweapon()) {
      self.lockonmissileturret = self.viewlockedentity;
      self notify("missileTurret_on");

      if(level.missileturretmaxtargets > 1) {
        self thread missileturretmultilockloop();
        self thread missilefirednotify(1);
      } else {
        self thread missileturretloop();
        self thread missilefirednotify(0);
      }
    }

    self waittill_any("turretownerchange", "exit_vehicle");
    self notify("missileTurret_off");
    self clearlockontarget();
    self clearviewlockent();

    if(isDefined(self.lockonmissileturret)) {
      if(isDefined(self.seat)) {
        self.lockonmissileturret cleartargetentity(self.seat - 1);
        self.seat = undefined;
      } else
        self.lockonmissileturret cleartargetentity();

      self.lockonmissileturret = undefined;
    }
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self clearlockontarget();
    thread main();
  }
}

clearlockontarget() {
  self notify("stinger_irt_cleartarget");
  self notify("stop_lockon_sound");
  self notify("stop_locked_sound");
  self notify("stop_tracking_sound");
  self.missileturretlocksound = undefined;
  self.missileturretkillshotsound = undefined;
  target_clearreticlelockon();
  luinotifyevent(&"hud_weapon_locking", 1, 0);
  luinotifyevent(&"hud_weapon_locked", 1, 0);
  level notify("missile_turret_lock_off");
  self.missileturretlockstarttime = 0;
  self.missileturretlockstarted = 0;
  self.missileturretlockfinalized = 0;
  self.missileturretlockloststarttime = 0;

  if(isDefined(self.missileturrettarget)) {
    self.missileturrettarget notify("missileLockTurret_cleared");

    if(level.missileturretmaxtargets == 1) {
      self.missileturrettarget.locked_on = 0;
      level notify("lock_on_reset");
    }
  }

  self.missileturrettarget = undefined;
  turret = self getturretweapon();

  if(isDefined(turret)) {
    if(isDefined(self.seat)) {
      turret cleartargetentity(self.seat - 1);
      self.seat = undefined;
    } else
      turret cleartargetentity();
  }

  self weaponlockfree();
  self weaponlocktargettooclose(0);
  self weaponlocknoclearance(0);
}

missilefirednotify(b_multi_target_turret) {
  self endon("disconnect");
  self endon("death");
  self endon("missileTurret_off");
  self.missileturretfiring = 0;

  while(true) {
    turret = self getturretweapon();

    if(!isDefined(turret)) {
      continue;
    }
    level.player waittill("missile_fire", missile);

    if(!usingvalidweapon()) {
      return;
    }
    if(isDefined(self.missileturrettarget)) {
      if(!b_multi_target_turret) {
        self.missileturrettarget notify("missileTurret_fired_at_me", missile);
        self.missileturrettarget thread missiletargetdeath();
      } else {
        self.missileturrettarget.locked_on = 1;
        self.missileturrettargetlist[self.missileturrettargetlist.size] = self.missileturrettarget;
        self.missileturrettarget setclientflag(0);
        self.missileturrettarget thread missileturrettargetdeathtread(self);
        self clearlockontarget();
      }

      luinotifyevent(&"hud_weapon_locked", 1, 2);
    }

    if(isDefined(b_multi_target_turret) && b_multi_target_turret) {
      if(isDefined(self.missileturretfiring) && !self.missileturretfiring) {
        if(level.missileturretmaxtargets > 1 && self.missileturrettargetlist.size > 0)
          self thread multilockmissilefire();
        else
          missile missile_settarget(undefined);
      }
    }

    luinotifyevent(&"hud_missile_fire", 2, 1, int(weaponfiretime(self getturretweaponname()) * 1000));
    self notify("missileTurret_fired");
  }
}

multilockmissilefire() {
  self endon("disconnect");
  self endon("death");
  self endon("missileTurret_off");
  self.missileturretfiring = 1;
  wait 0.1;
  turret = self getturretweapon();
  seat = turret getoccupantseat(level.player);

  if(isDefined(turret))
    turret cleargunnertarget(seat);

  for(i = 1; i < self.missileturrettargetlist.size; i++) {
    if(isstillvalidtarget(self.missileturrettargetlist[i])) {
      if(seat == 0)
        turret fireweapon(self.missileturrettargetlist[i]);
      else {
        turret setgunnertargetent(self.missileturrettargetlist[i], (0, 0, 0), seat - 1);
        missile = turret firegunnerweapon(seat - 1);
        missile setforcenocull();
      }

      luinotifyevent(&"hud_missile_fire", 2, i + 1, int(weaponfiretime(self getturretweaponname()) * 1000));
      self.missileturrettargetlist[i] notify("missileTurret_fired_at_me", missile);
      self.missileturrettargetlist[i].locked_on = 0;
      earthquake(0.25, 0.25, self.origin, 512, self);
    }

    wait 0.1;
  }

  turret cleargunnertarget(seat);
  self notify("missile_turret_firing_done");
  wait 0.05;

  for(i = 0; i < self.missileturrettargetlist.size; i++) {
    if(isDefined(self.missileturrettargetlist[i])) {
      self.missileturrettargetlist[i].locked_on = 0;
      self.missileturrettargetlist[i] clearclientflag(0);
    }
  }

  self.missileturrettargetlist = [];
  self.missileturretfiring = 0;
  vehicles = getvehiclearray("axis");

  foreach(vehicle in vehicles) {
    if(isDefined(vehicle.locked_on) && vehicle.locked_on)
      vehicle.locked_on = 0;
  }

  self thread missileturretclientflags();
}

missileturretclientflags() {
  self endon("damage");
  rpc("clientscripts/_vehicle", "damage_filter_light");
  wait 0.25;
  rpc("clientscripts/_vehicle", "damage_filter_off");
}

missiletargetdeath() {
  self waittill("death", attacker, damagefromunderneath, weaponname);
  luinotifyevent(&"hud_weapon_locked", 1, 3);
}

missledeath() {
  self endon("missile_hit");
  self waittill("death");
  luinotifyevent(&"hud_weapon_locked", 1, 4);
}

missileturretloop() {
  self endon("disconnect");
  self endon("death");
  self endon("missileTurret_off");
  locklength = weaponlockonspeed(self getturretweaponname());
  lock_lost_time = 1000;
  self thread oneshot_lockon_sound();

  if(isDefined(self.missile_turret_lock_lost_time) && isint(self.missile_turret_lock_lost_time))
    lock_lost_time = self.missile_turret_lock_lost_time;

  for(;;) {
    wait 0.05;

    if(self.missileturretlockfinalized) {
      if(!isstillvalidtarget(self.missileturrettarget) || !canlockon()) {
        self clearlockontarget();
        continue;
      }

      if(!insidemissileturretreticlelocked(self.missileturrettarget)) {
        if(self.missileturretlockloststarttime == 0)
          self.missileturretlockloststarttime = gettime();

        timepassed = gettime() - self.missileturretlockloststarttime;

        if(timepassed > lock_lost_time) {
          self clearlockontarget();
          self playlocalsound(game["lost_target_sound"]);
        }

        continue;
      }

      thread looplocallocksound(game["locked_on_loop"], 0.5);
      thread looplocaltrackingsoundrealloop(game["tracking_loop_sound"], self.missileturrettarget);
      thread playlocalkillshotsound(game["killshot_sound"], self.missileturrettarget);
      self.missileturrettarget notify("missileLockTurret_locked");
      self.missileturrettarget.locked_on = 1;
      level notify("lock_on_acquired");

      if(!level.bmanualtargetset) {
        turret = self getturretweapon();
        turret settargetentity(self.missileturrettarget);
      }

      self settargettooclose(self.missileturrettarget);
      continue;
    }

    if(self.missileturretlockstarted) {
      if(!isstillvalidtarget(self.missileturrettarget) || !canlockon() || !isstillbesttarget(self.missileturrettarget)) {
        self clearlockontarget();
        continue;
      }

      timepassed = gettime() - self.missileturretlockstarttime;

      if(timepassed < locklength) {
        luinotifyevent(&"hud_weapon_locking", 3, 1, int(timepassed), int(locklength));
        continue;
      }

      assert(isDefined(self.missileturrettarget));

      if(!canlockon()) {
        continue;
      }
      self notify("stop_lockon_sound");
      self.missileturretlockfinalized = 1;
      self weaponlockfinalize(self.missileturrettarget);
      self settargettooclose(self.missileturrettarget);
      luinotifyevent(&"hud_weapon_locking", 1, 0);
      luinotifyevent(&"hud_weapon_locked", 1, 1);
      level notify("missile_turret_locked");
      continue;
    }

    if(!canlockon()) {
      continue;
    }
    besttarget = self[[level.func_getbestmissileturrettarget]]();

    if(!isDefined(besttarget)) {
      continue;
    }
    self.missileturrettarget = besttarget;
    self.missileturretlockstarttime = gettime();
    self.missileturretlockstarted = 1;
    self weaponlockstart(besttarget);
    target_startreticlelockon(besttarget, 2);
    luinotifyevent(&"hud_weapon_locking", 1, 1);
    self thread looplocalseeksound(game["locking_on_sound"], 0.8);
    self notify("lock_on_missile_turret_start");
  }
}

missileturretmultilockloop() {
  self endon("disconnect");
  self endon("death");
  self endon("missileTurret_off");
  locklength = weaponlockonspeed(self getturretweaponname());

  if(!isDefined(self.missileturrettargetlist))
    self.missileturrettargetlist = [];
  else {
    for(i = 0; i < self.missileturrettargetlist.size; i++)
      self.missileturrettargetlist[i] = undefined;

    arrayremovevalue(self.missileturrettargetlist, undefined);
  }

  for(;;) {
    wait 0.05;

    if(isDefined(self.missileturretfiring) && self.missileturretfiring) {
      continue;
    }
    for(i = 0; i < self.missileturrettargetlist.size; i++) {
      if(!isstillvalidtarget(self.missileturrettargetlist[i]) || !insidemissileturretreticlelocked(self.missileturrettargetlist[i], 1000)) {
        if(isDefined(self.missileturrettargetlist[i])) {
          self.missileturrettargetlist[i].locked_on = 0;
          self.missileturrettargetlist[i] clearclientflag(0);
          arrayremovevalue(self.missileturrettargetlist, self.missileturrettargetlist[i]);
        }
      }
    }

    arrayremovevalue(self.missileturrettargetlist, undefined);

    if(self.missileturrettargetlist.size >= level.missileturretmaxtargets) {
      continue;
    }
    if(self.missileturretlockfinalized) {
      if(!isstillvalidtarget(self.missileturrettarget) || !canlockon()) {
        self clearlockontarget();
        continue;
      }

      if(!insidemissileturretreticlelocked(self.missileturrettarget)) {
        if(self.missileturretlockloststarttime == 0)
          self.missileturretlockloststarttime = gettime();

        timepassed = gettime() - self.missileturretlockloststarttime;

        if(timepassed > 1000) {
          self clearlockontarget();
          self playlocalsound(game["lost_target_sound"]);
        }

        continue;
      }

      thread looplocallocksound(game["locked_on_loop"], 0.5);
      thread looplocaltrackingsoundrealloop(game["tracking_loop_sound"], self.missileturrettarget);
      thread playlocalkillshotsound(game["killshot_sound"], self.missileturrettarget);
      self.missileturrettarget notify("missileLockTurret_locked");
      self settargettooclose(self.missileturrettarget);
      self.missileturrettarget.locked_on = 1;
      self.missileturrettargetlist[self.missileturrettargetlist.size] = self.missileturrettarget;
      self.missileturrettarget setclientflag(0);
      self.missileturrettarget thread missileturrettargetdeathtread(self);
      self clearlockontarget();

      if(!level.bmanualtargetset) {
        turret = self getturretweapon();

        if(isDefined(turret))
          turret cleartargetentity();

        self.seat = turret getoccupantseat(level.player);

        if(self.seat == 0)
          turret settargetentity(self.missileturrettargetlist[0]);
        else
          turret settargetentity(self.missileturrettargetlist[0], (0, 0, 0), self.seat - 1);
      }

      continue;
    }

    if(self.missileturretlockstarted) {
      if(!isstillvalidtarget(self.missileturrettarget) || !canlockon()) {
        self clearlockontarget();
        continue;
      }

      timepassed = gettime() - self.missileturretlockstarttime;
      locktime = locklength - locklength * (self.missileturrettargetlist.size * 0.1);

      if(timepassed < locktime) {
        luinotifyevent(&"hud_weapon_locking", 3, 1, int(timepassed), int(locklength));
        continue;
      }

      assert(isDefined(self.missileturrettarget));

      if(!canlockon()) {
        continue;
      }
      self notify("stop_lockon_sound");
      self.missileturretlockfinalized = 1;
      self weaponlockfinalize(self.missileturrettarget);
      self settargettooclose(self.missileturrettarget);
      luinotifyevent(&"hud_weapon_locking", 1, 0);
      luinotifyevent(&"hud_weapon_locked", 1, 1);
      continue;
    }

    if(!canlockon()) {
      continue;
    }
    besttarget = self[[level.func_getbestmissileturrettarget]]();

    if(!isDefined(besttarget)) {
      continue;
    }
    self.missileturrettarget = besttarget;
    self.missileturretlockstarttime = gettime();
    self.missileturretlockstarted = 1;
    self weaponlockstart(besttarget);
    target_startreticlelockon(besttarget, 2);
    luinotifyevent(&"hud_weapon_locking", 1, 1);
    self thread looplocalseeksound(game["locking_on_sound"], 0.8);
    self notify("lock_on_missile_turret_start");
  }
}

missileturrettargetdeathtread(player) {
  self waittill("death");

  if(isDefined(player.missileturretfiring) && player.missileturretfiring)
    player waittill("missile_turret_firing_done");

  for(i = 0; i < player.missileturrettargetlist.size; i++) {
    if(isDefined(player.missileturrettargetlist[i])) {
      if(self == player.missileturrettargetlist[i])
        player.missileturrettargetlist[i] = undefined;
    }
  }
}

locksighttest(target) {
  eyepos = self geteye();

  if(!isDefined(target))
    return false;

  passed = bullettracepassed(eyepos, target.origin, 0, target);

  if(!passed)
    return false;

  front = target getpointinbounds(1, 0, 0);
  bullettracepassed(eyepos, front, 0, target);

  if(!passed)
    return false;

  back = target getpointinbounds(-1, 0, 0);
  passed = bullettracepassed(eyepos, back, 0, target);

  if(!passed)
    return false;

  return true;
}

softsighttest() {
  if(self locksighttest(self.missileturrettarget)) {
    self.missileturretlostsightlinetime = 0;
    return true;
  }

  if(self.missileturretlostsightlinetime == 0)
    self.missileturretlostsightlinetime = gettime();

  timepassed = gettime() - self.missileturretlostsightlinetime;

  if(timepassed >= 500) {
    self clearlockontarget();
    return false;
  }

  return true;
}

getbestmissileturrettarget() {
  targetsall = target_getarray();
  targetsvalid = [];

  for(idx = 0; idx < targetsall.size; idx++) {
    if(isai(targetsall[idx])) {
      continue;
    }
    if(isDefined(targetsall[idx].locked_on) && targetsall[idx].locked_on == 1) {
      continue;
    }
    if(self insidemissileturretreticlenolock(targetsall[idx]))
      targetsvalid[targetsvalid.size] = targetsall[idx];
  }

  if(targetsvalid.size == 0)
    return undefined;

  chosenent = targetsvalid[0];
  bestdot = -999;
  chosenindex = -1;

  if(targetsvalid.size > 1) {
    forward = anglestoforward(self getplayerangles());

    for(i = 0; i < targetsvalid.size; i++) {
      vec_to_target = vectornormalize(targetsvalid[i].origin - self get_eye());
      dot = vectordot(vec_to_target, forward);

      if(dot > bestdot) {
        bestdot = dot;
        chosenindex = i;
      }
    }
  }

  if(chosenindex > -1)
    chosenent = targetsvalid[chosenindex];

  return chosenent;
}

getbestmissileturrettargetlist() {
}

insidemissileturretreticlenolock(target) {
  weaponname = self getturretweaponname();

  if(weaponname == "none")
    return 0;

  fov = getdvarfloat(#"cg_fov");
  radius = weaponlockonradius(weaponname);
  return target_isincircle(target, self, fov, radius);
}

insidemissileturretreticlelocked(target, falloff) {
  weaponname = self getturretweaponname();

  if(weaponname == "none")
    return 0;

  fov = getdvarfloat(#"cg_fov");
  radius = isDefined(falloff) ? weaponlockonradius(weaponname) + falloff : weaponlockonradius(weaponname);
  return target_isincircle(target, self, fov, radius);
}

isstillvalidtarget(ent) {
  if(!isDefined(ent))
    return false;

  if(!target_istarget(ent))
    return false;

  if(isDefined(ent.isacorpse) && ent.isacorpse)
    return false;

  if(isDefined(ent.classname) && ent.classname == "script_vehicle_corpse")
    return false;

  if(ent.health <= 0)
    return false;

  return true;
}

isstillbesttarget(ent) {
  besttarget = [[level.func_getbestmissileturrettarget]]();

  if(isDefined(besttarget) && ent == besttarget)
    return true;

  return false;
}

setnoclearance() {
  color_passed = (0, 1, 0);
  color_failed = (1, 0, 0);
  checks = [];
  checks[0] = vectorscale((0, 0, 1), 80.0);
  checks[1] = (-40, 0, 120);
  checks[2] = (40, 0, 120);
  checks[3] = vectorscale((-1, 0, 1), 40.0);
  checks[4] = vectorscale((1, 0, 1), 40.0);
  debug = 0;

  if(getdvar(#"_id_64296AD0") == "1")
    debug = 1;

  playerangles = self getplayerangles();
  forward = anglestoforward(playerangles);
  right = anglestoright(playerangles);
  up = anglestoup(playerangles);
  origin = self.origin + (0, 0, 60) + right * 10;
  obstructed = 0;

  for(idx = 0; idx < checks.size; idx++) {
    endpoint = origin + forward * 400 + up * checks[idx][2] + right * checks[idx][0];
    trace = bullettrace(origin, endpoint, 0, undefined);

    if(trace["fraction"] < 1) {
      obstructed = 1;

      if(debug) {
        line(origin, trace["position"], color_failed, 1);

      } else
        break;
    } else {
      if(debug)
        line(origin, trace["position"], color_passed, 1);

    }
  }

  self weaponlocknoclearance(obstructed);
  self.noclearance = obstructed;
}

settargettooclose(ent) {
  if(!isDefined(ent))
    return false;

  dist = distance2d(self.origin, ent.origin);

  if(dist < 0) {
    self.targettoclose = 1;
    self weaponlocktargettooclose(1);
  } else {
    self.targettoclose = 0;
    self weaponlocktargettooclose(0);
  }
}

looplocalseeksound(alias, interval) {
  self endon("stop_lockon_sound");
  self endon("stop_seeking_sound");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self playlocalsound(alias);
    wait(interval);
  }
}

looplocallocksound(alias, interval) {
  self endon("stop_locked_sound");
  self endon("disconnect");
  self endon("death");

  if(isDefined(self.missileturretlocksound)) {
    return;
  }
  self.missileturretlocksound = 1;
  self playlocalsound(game["acquired_sound"]);
  wait 0.5;
  self thread missile_lock_loop_audio(alias);

  for(;;)
    wait(interval);

  self.missileturretlocksound = undefined;
}

missile_lock_loop_audio(alias) {
  player = get_players()[0];
  player playloopsound(alias, 0.05);
  self waittill_any("stop_locked_sound", "disconnect", "death");
  player stoploopsound(0.05);
}

looplocaltrackingsound(alias, drone) {
  self endon("stop_tracking_sound");
  self endon("disconnect");
  self endon("death");
  drone endon("missileLockTurret_cleared");
  drone endon("death");
  drone waittill("missileTurret_fired_at_me", missile);
  self notify("stop_seeking_sound");
  self notify("stop_locked_sound");

  for(olde = undefined; isDefined(missile) && isDefined(drone); olde = e) {
    d = sqrt(distance2d(missile.origin, drone.origin));
    e = d * 0.001;

    if(!isDefined(olde))
      olde = e;

    de = e - olde;

    if(de > 0.1)
      de = 0.1;

    if(de < 0.1 * -1)
      de = 0.1 * -1;

    e = de + olde;

    if(e > 1)
      e = 1;

    if(e < 0.05)
      e = 0.05;

    self playlocalsound(alias);
    wait(e);
  }
}

oneshot_lockon_sound() {
  self endon("disconnect");
  self endon("death");

  while(true) {
    level waittill("lock_on_acquired");
    self playlocalsound("wpn_sam_lockon");
    level waittill("lock_on_reset");
  }
}

waittill_drone_done(player, drone, missile) {
  player endon("stop_tracking_sound");
  player endon("disconnect");
  player endon("death");
  missile endon("death");
  drone endon("missileLockTurret_cleared");
  drone waittill("death");
}

looplocaltrackingsoundrealloop(alias, drone) {
  drone waittill("missileTurret_fired_at_me", missile);
  self notify("stop_seeking_sound");
  self notify("stop_locked_sound");
  self playloopsound(alias);
  waittill_drone_done(self, drone, missile);
  self stoploopsound();
}

playlocalkillshotsound(alias, drone) {
  self endon("disconnect");
  self endon("death");

  if(isDefined(self.missileturretkillshotsound)) {
    return;
  }
  self.missileturretkillshotsound = 1;
  drone waittill("death");
  self playlocalsound(alias);
  self notify("stop_lockon_sound");
  self.missileturretkillshotsound = undefined;
  wait 1;
  self thread maps\_dds::dds_notify("kill_confirm", 1);
}

usingvalidweapon() {
  weapon_name = getturretweaponname();

  if(isDefined(weapon_name) && weaponguidedmissiletype(weapon_name) != "none")
    return true;

  return false;
}

getturretweaponname() {
  weapon_name = "none";
  viewlockedent = self.viewlockedentity;

  if(isDefined(viewlockedent)) {
    if(viewlockedent.classname == "misc_turret")
      return viewlockedent.weaponinfo;
    else if(viewlockedent.classname == "script_vehicle") {
      for(i = 0; i < 5; i++) {
        weapon_name = viewlockedent seatgetweapon(i);

        if(isDefined(weapon_name) && weaponguidedmissiletype(weapon_name) != "none")
          return weapon_name;
      }
    }
  }

  if(!isDefined(weapon_name))
    weapon_name = "none";

  return weapon_name;
}

getturretweapon() {
  viewlockent = self.viewlockedentity;

  if(isDefined(viewlockent))
    return viewlockent;

  return undefined;
}

startmissilecam() {
  script_model = spawn("script_model", (0, 0, 0));
  script_model setmodel(self.model);
  script_model hide();
  script_model linkto(self, "tag_origin", vectorscale((1, 0, 0), 25.0));
  script_model setclientflag(0);
  self waittill("death");
  script_model clearclientflag(0);
  script_model delete();
}

canlockon() {
  if(isDefined(self.lockondisabled) && self.lockondisabled)
    return false;

  if(game["missileTurret_useadslockon"]) {
    if(self adsbuttonpressed()) {
      if(self.lockonmissilezoom == 0) {
        self.lockonmissilezoom = 1;
        luinotifyevent(&"hud_turret_zoom", 1, 1);
      }

      return true;
    } else {
      if(self.lockonmissilezoom == 1) {
        self.lockonmissilezoom = 0;
        luinotifyevent(&"hud_turret_zoom", 1, 0);
      }

      return false;
    }
  }

  return true;
}

disablelockon() {
  level.player.lockondisabled = 1;
}

enablelockon() {
  level.player.lockondisabled = 0;
}