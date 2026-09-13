/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\helicopter.gsc
*************************************************/

init() {
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
  level._effect["jet_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_harrier_angel_flares.vfx");

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    level thread getaveragelowspawnpoint();
}

getaveragelowspawnpoint() {
  spawnpoints = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  count = 0;
  _id_D9FB82610410DF01 = 0;

  foreach(point in spawnpoints) {
    count++;
    _id_D9FB82610410DF01 = _id_D9FB82610410DF01 + point.origin[2];
  }

  if(count > 0)
    level.averagealliesz = _id_D9FB82610410DF01 / count;
  else
    level.averagealliesz = 0;
}

makehelitype(helitype, deathfx, lightfxfunc) {
  level.chopper_fx["explode"]["death"][helitype] = loadfx(deathfx);
  level.lightfxfunc[helitype] = lightfxfunc;
}

addairexplosion(helitype, _id_069D36ADBDEC29DC) {
  level.chopper_fx["explode"]["air_death"][helitype] = loadfx(_id_069D36ADBDEC29DC);
}

defaultlightfx() {
  playFXOnTag(level.chopper_fx["light"]["left"], self, "tag_light_L_wing");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["right"], self, "tag_light_R_wing");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
}

usehelicopter(lifeid, streakname) {
  return tryusehelicopter(lifeid, "helicopter");
}

tryusehelicopter(lifeid, helitype) {
  _id_4440147083ABAF0A = 1;

  if(isDefined(level.chopper))
    _id_54AA70777DF37FF1 = 1;
  else
    _id_54AA70777DF37FF1 = 0;

  if(isDefined(level.chopper) && _id_54AA70777DF37FF1) {
    self iprintlnbold(&"KILLSTREAKS_HELI_IN_QUEUE");

    if(isDefined(helitype) && helitype != "helicopter")
      streakname = "helicopter_" + helitype;
    else
      streakname = "helicopter";

    _id_872A3D52FC91C4A1 = spawn("script_origin", (0, 0, 0));
    _id_872A3D52FC91C4A1 hide();
    _id_872A3D52FC91C4A1 thread deleteonentnotify(self, "disconnect");
    _id_872A3D52FC91C4A1.player = self;
    _id_872A3D52FC91C4A1.lifeid = lifeid;
    _id_872A3D52FC91C4A1.helitype = helitype;
    _id_872A3D52FC91C4A1.streakname = streakname;
    scripts\mp\utility\script::queueadd("helicopter", _id_872A3D52FC91C4A1);
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + _id_4440147083ABAF0A >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return 0;
  }

  _id_4440147083ABAF0A = 1;
  starthelicopter(lifeid, helitype);
  return 1;
}

deleteonentnotify(ent, notifystring) {
  self endon("death");
  ent waittill(notifystring);
  self delete();
}

starthelicopter(lifeid, helitype) {
  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  startnode = undefined;

  if(!isDefined(helitype))
    helitype = "";

  eventtype = "helicopter";
  team = self.pers["team"];
  startnode = level.heli_start_nodes[randomint(level.heli_start_nodes.size)];
  scripts\common\utility::trycall(level.matchdata_logkillstreakevent, eventtype, self.origin);
  thread heli_think(lifeid, self, startnode, self.pers["team"], helitype);
}

precachehelicoptersounds() {
  level.heli_sound["allies"]["hit"] = "veh_chopper_support_hit";
  level.heli_sound["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level.heli_sound["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
  level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["allies"]["crash"] = "exp_helicopter_fuel";
  level.heli_sound["allies"]["missilefire"] = "weap_cobra_missile_fire";
  level.heli_sound["axis"]["hit"] = "veh_chopper_support_hit";
  level.heli_sound["axis"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level.heli_sound["axis"]["spinloop"] = "cobra_helicopter_dying_loop";
  level.heli_sound["axis"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["axis"]["crash"] = "exp_helicopter_fuel";
  level.heli_sound["axis"]["missilefire"] = "weap_cobra_missile_fire";
}

heli_getteamforsoundclip() {
  _id_FABF84450735DD93 = self.team;

  if(level.multiteambased)
    _id_FABF84450735DD93 = "axis";

  return _id_FABF84450735DD93;
}

spawn_helicopter(owner, origin, angles, vehicletype, modelname) {
  chopper = spawnhelicopter(owner, origin, angles, vehicletype, modelname);

  if(!isDefined(chopper))
    return undefined;

  if(modelname == "vehicle_battle_hind")
    chopper.heli_type = "cobra";
  else
    chopper.heli_type = level.heli_types[modelname];

  chopper thread[[level.lightfxfunc[chopper.heli_type]]]();
  chopper scripts\mp\utility\killstreak::addtohelilist(chopper getentitynumber());
  chopper.zoffset = (0, 0, chopper gettagorigin("tag_origin")[2] - chopper gettagorigin("tag_ground")[2]);
  chopper.attractor = missile_createattractorent(chopper, level.heli_attract_strength, level.heli_attract_range);
  return chopper;
}

helidialog(_id_9E3CBCDA4B9BDCBC) {
  if(gettime() - level.lasthelidialogtime < 6000) {
    return;
  }
  level.lasthelidialogtime = gettime();
  _id_610520BE555433B2 = randomint(level.helidialog[_id_9E3CBCDA4B9BDCBC].size);
  soundalias = level.helidialog[_id_9E3CBCDA4B9BDCBC][_id_610520BE555433B2];
  _id_AEECA9F734EA50C1 = scripts\mp\utility\teams::getteamvoiceinfix(self.team) + "tl" + soundalias;
  self playlocalsound(_id_AEECA9F734EA50C1);
}

updateareanodes(_id_AAE00E2788791D65) {
  _id_45A9094092727403 = [];

  foreach(node in _id_AAE00E2788791D65) {
    node.validplayers = [];
    node.nodescore = 0;
  }

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    if(player.team == self.team) {
      continue;
    }
    foreach(node in _id_AAE00E2788791D65) {
      if(distancesquared(player.origin, node.origin) > 1048576) {
        continue;
      }
      node.validplayers[node.validplayers.size] = player;
    }
  }

  _id_B88AA9CCEE86B6A3 = _id_AAE00E2788791D65[0];

  foreach(node in _id_AAE00E2788791D65) {
    _id_23D42B1195DDA679 = getEnt(node.target, "targetname");

    foreach(player in node.validplayers) {
      node.nodescore = node.nodescore + 1;

      if(scripts\engine\trace::_bullet_trace_passed(player.origin + (0, 0, 32), _id_23D42B1195DDA679.origin, 0, player))
        node.nodescore = node.nodescore + 3;
    }

    if(node.nodescore > _id_B88AA9CCEE86B6A3.nodescore)
      _id_B88AA9CCEE86B6A3 = node;
  }

  return getEnt(_id_B88AA9CCEE86B6A3.target, "targetname");
}

heli_think(lifeid, owner, startnode, _id_9B49F96D1AA048AB, helitype) {
  _id_800E2481BCB35003 = startnode.origin;
  _id_06C26E549B220A7D = startnode.angles;
  vehicletype = "cobra_mp";
  _id_B8957CD52D1EFA30 = "vehicle_battle_hind";
  chopper = spawn_helicopter(owner, _id_800E2481BCB35003, _id_06C26E549B220A7D, vehicletype, _id_B8957CD52D1EFA30);

  if(!isDefined(chopper)) {
    return;
  }
  level.chopper = chopper;

  if(_id_9B49F96D1AA048AB == "allies")
    level.allieschopper = chopper;
  else
    level.axischopper = chopper;

  chopper.helitype = helitype;
  chopper.lifeid = lifeid;
  chopper.team = _id_9B49F96D1AA048AB;
  chopper.pers["team"] = _id_9B49F96D1AA048AB;
  chopper.owner = owner;
  chopper setotherent(owner);
  chopper.startnode = startnode;
  chopper.maxhealth = level.heli_maxhealth;
  chopper.targeting_delay = level.heli_targeting_delay;
  chopper.primarytarget = undefined;
  chopper.secondarytarget = undefined;
  chopper.attacker = undefined;
  chopper.currentstate = "ok";
  chopper scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);
  chopper.empgrenaded = 0;

  if(helitype == "flares" || helitype == "minigun")
    chopper thread scripts\mp\killstreaks\flares::flares_monitor(1);

  chopper thread heli_leave_on_disconnect(owner);
  chopper thread heli_leave_on_changeteams(owner);
  chopper thread heli_leave_on_gameended(owner);
  chopper thread heli_damage_monitor(helitype);
  chopper thread heli_watchempdamage();
  chopper thread heli_watchdeath();
  chopper thread heli_existance();
  chopper endon("helicopter_done");
  chopper endon("crashing");
  chopper endon("leaving");
  chopper endon("death");
  _id_8CAD8AD1DFB1B849 = getEntArray("heli_attack_area", "targetname");
  _id_036F77433815409F = undefined;
  _id_036F77433815409F = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
  chopper heli_fly_simple_path(startnode);
  chopper thread heli_targeting();
  chopper thread heli_leave_on_timeout(60.0);
  chopper thread heli_fly_loop_path(_id_036F77433815409F);
}

heli_existance() {
  entitynumber = self getentitynumber();
  scripts\engine\utility::waittill_any_3("death", "crashing", "leaving");
  scripts\mp\utility\killstreak::removefromhelilist(entitynumber);
  self notify("helicopter_done");
  self notify("helicopter_removed");
  player = undefined;
  _id_872A3D52FC91C4A1 = scripts\mp\utility\script::queueremovefirst("helicopter");

  if(!isDefined(_id_872A3D52FC91C4A1))
    level.chopper = undefined;
  else {
    player = _id_872A3D52FC91C4A1.player;
    lifeid = _id_872A3D52FC91C4A1.lifeid;
    streakname = _id_872A3D52FC91C4A1.streakname;
    helitype = _id_872A3D52FC91C4A1.helitype;
    _id_872A3D52FC91C4A1 delete();

    if(isDefined(player) && (player.sessionstate == "playing" || player.sessionstate == "dead")) {
      player starthelicopter(lifeid, helitype);
      return;
    }

    level.chopper = undefined;
  }
}

heli_targeting() {
  self notify("heli_targeting");
  self endon("heli_targeting");
  self endon("death");
  self endon("helicopter_done");

  for(;;) {
    targets = [];
    self.primarytarget = undefined;
    self.secondarytarget = undefined;

    foreach(player in level.characters) {
      wait 0.05;

      if(!cantarget_turret(player)) {
        continue;
      }
      targets[targets.size] = player;
    }

    if(targets.size) {
      for(targetplayer = getbestprimarytarget(targets); !isDefined(targetplayer); targetplayer = getbestprimarytarget(targets))
        waitframe();

      self.primarytarget = targetplayer;
      self notify("primary acquired");
    }

    if(isDefined(self.primarytarget)) {
      fireontarget(self.primarytarget);
      continue;
    }

    wait 0.25;
  }
}

cantarget_turret(player) {
  _id_B2FA5E17C1E26C94 = 1;

  if(!isalive(player) || isDefined(player.sessionstate) && player.sessionstate != "playing")
    return 0;

  if(distance(player.origin, self.origin) > level.heli_visual_range)
    return 0;

  if(!self.owner scripts\cp_mp\utility\player_utility::isenemy(player))
    return 0;

  if(isDefined(player.spawntime) && (gettime() - player.spawntime) / 1000 <= 5)
    return 0;

  if(player scripts\mp\utility\perk::_hasperk("specialty_blindeye"))
    return 0;

  _id_7B77385ED087305E = self.origin + (0, 0, -160);
  _id_6570683A627A6866 = anglesToForward(self.angles);
  _id_545C091E72EE3A4D = _id_7B77385ED087305E + 144 * _id_6570683A627A6866;

  if(player sightconetrace(_id_545C091E72EE3A4D, self) < level.heli_target_recognition)
    return 0;

  return _id_B2FA5E17C1E26C94;
}

getbestprimarytarget(targets) {
  foreach(player in targets) {
    if(!isDefined(player)) {
      continue;
    }
    update_player_threat(player);
  }

  _id_FCB005BA59DA2C8B = 0;
  primarytarget = undefined;
  _id_7BA521E5CC4CB125 = getEntArray("minimap_corner", "targetname");

  foreach(player in targets) {
    if(!isDefined(player)) {
      continue;
    }
    if(_id_7BA521E5CC4CB125.size == 2) {
      min = _id_7BA521E5CC4CB125[0].origin;
      max = _id_7BA521E5CC4CB125[0].origin;

      if(_id_7BA521E5CC4CB125[1].origin[0] > max[0])
        max = (_id_7BA521E5CC4CB125[1].origin[0], max[1], max[2]);
      else
        min = (_id_7BA521E5CC4CB125[1].origin[0], min[1], min[2]);

      if(_id_7BA521E5CC4CB125[1].origin[1] > max[1])
        max = (max[0], _id_7BA521E5CC4CB125[1].origin[1], max[2]);
      else
        min = (min[0], _id_7BA521E5CC4CB125[1].origin[1], min[2]);

      if(player.origin[0] < min[0] || player.origin[0] > max[0] || player.origin[1] < min[1] || player.origin[1] > max[1])
        continue;
    }

    if(player.threatlevel < _id_FCB005BA59DA2C8B) {
      continue;
    }
    if(!scripts\engine\trace::_bullet_trace_passed(player.origin + (0, 0, 32), self.origin, 0, self)) {
      wait 0.05;
      continue;
    }

    _id_FCB005BA59DA2C8B = player.threatlevel;
    primarytarget = player;
  }

  return primarytarget;
}

update_player_threat(player) {
  player.threatlevel = 0;
  dist = distance(player.origin, self.origin);
  player.threatlevel = player.threatlevel + (level.heli_visual_range - dist) / level.heli_visual_range * 100;

  if(isDefined(self.attacker) && player == self.attacker)
    player.threatlevel = player.threatlevel + 100;

  if(isPlayer(player))
    player.threatlevel = player.threatlevel + player.score * 4;

  if(isDefined(player.antithreat))
    player.threatlevel = player.threatlevel - player.antithreat;

  if(player.threatlevel <= 0)
    player.threatlevel = 1;
}

heli_reset() {
  self cleartargetyaw();
  self cleargoalyaw();
  self vehicle_setspeed(80, 35);
  self setyawspeed(75, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(256);
  self setturningability(0.9);
}

addrecentdamage(damage) {
  self endon("death");
  self.recentdamageamount = self.recentdamageamount + damage;
  wait 4.0;
  self.recentdamageamount = self.recentdamageamount - damage;
}

modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;
  _id_CB15FA5174E71840 = 2;
  _id_BE7C04516C5D9CCD = 3;
  _id_CA960A517459FE15 = 4;

  if(isDefined(self.helitype) && self.helitype == "dronedrop") {
    _id_CB15FA5174E71840 = 1;
    _id_BE7C04516C5D9CCD = 1;
    _id_CA960A517459FE15 = 2;
  }

  _id_702BFC08FABD86CB = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, type, _id_702BFC08FABD86CB, self.maxhealth, _id_CB15FA5174E71840, _id_BE7C04516C5D9CCD, _id_CA960A517459FE15);
  thread addrecentdamage(_id_702BFC08FABD86CB);
  self notify("heli_damage_fx");
  return _id_702BFC08FABD86CB;
}

handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;

  if(isDefined(attacker)) {
    config = level.heliconfigs[self.streakname];
    _id_3737240CEFE2C793 = scripts\mp\damage::onkillstreakkilled(self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo, config.callout);

    if(_id_3737240CEFE2C793) {
      attacker notify("destroyed_helicopter");
      self.killingattacker = attacker;
    }
  }
}

heli_damage_monitor(type, _id_66816DFF4D94B0B3, _id_A39FF9E13BBC6340) {
  self endon("crashing");
  self endon("leaving");
  self.streakname = type;
  self.recentdamageamount = 0;

  if(!istrue(_id_A39FF9E13BBC6340))
    thread heli_health();

  scripts\mp\damage::monitordamage(self.maxhealth, "helicopter", ::handledeathdamage, ::modifydamage, 1, _id_66816DFF4D94B0B3);
}

heli_watchempdamage() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("emp_damage", attacker, duration);
    self.empgrenaded = 1;

    if(isDefined(self.mgturretleft))
      self.mgturretleft notify("stop_shooting");

    if(isDefined(self.mgturretright))
      self.mgturretright notify("stop_shooting");

    wait(duration);
    self.empgrenaded = 0;

    if(isDefined(self.mgturretleft))
      self.mgturretleft notify("turretstatechange");

    if(isDefined(self.mgturretright))
      self.mgturretright notify("turretstatechange");
  }
}

heli_health() {
  self endon("leaving");
  self endon("crashing");
  self.currentstate = "ok";
  self.laststate = "ok";
  self setdamagestage(3);
  damagestate = 3;
  self setdamagestage(damagestate);
  config = level.heliconfigs[self.streakname];

  for(;;) {
    self waittill("heli_damage_fx");

    if(damagestate > 0 && self.damagetaken >= self.maxhealth) {
      damagestate = 0;
      self setdamagestage(damagestate);
      stopFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, config.enginevfxtag);
      self notify("death");
      break;
    } else {
      if(damagestate > 1 && self.damagetaken >= self.maxhealth * 0.66) {
        damagestate = 1;
        self setdamagestage(damagestate);
        self.currentstate = "heavy smoke";
        stopFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, config.enginevfxtag);
        playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, config.enginevfxtag);
        continue;
      }

      if(damagestate > 2 && self.damagetaken >= self.maxhealth * 0.33) {
        damagestate = 2;
        self setdamagestage(damagestate);
        self.currentstate = "light smoke";
        playFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, config.enginevfxtag);
      }
    }
  }
}

heli_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");

  if(isDefined(self.largeprojectiledamage) && self.largeprojectiledamage)
    thread heli_explode(1);
  else {
    config = level.heliconfigs[self.streakname];
    playFXOnTag(level.chopper_fx["damage"]["on_fire"], self, config.enginevfxtag);
    thread heli_crash();
  }
}

heli_crash() {
  self notify("crashing");
  self clearlookatent();
  _id_5BAC506D468BC5E8 = level.heli_crash_nodes[randomint(level.heli_crash_nodes.size)];

  if(isDefined(self.mgturretleft))
    self.mgturretleft notify("stop_shooting");

  if(isDefined(self.mgturretright))
    self.mgturretright notify("stop_shooting");

  thread heli_spin(180);
  thread heli_secondary_explosions();
  heli_fly_simple_path(_id_5BAC506D468BC5E8);
  thread heli_explode();
}

heli_secondary_explosions() {
  _id_FABF84450735DD93 = heli_getteamforsoundclip();
  config = level.heliconfigs[self.streakname];
  playFXOnTag(level.chopper_fx["explode"]["large"], self, config.enginevfxtag);
  self playSound(level.heli_sound[_id_FABF84450735DD93]["hitsecondary"]);
  wait 3.0;

  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(level.chopper_fx["explode"]["large"], self, config.enginevfxtag);
  self playSound(level.heli_sound[_id_FABF84450735DD93]["hitsecondary"]);
}

heli_spin(speed) {
  self endon("death");
  _id_FABF84450735DD93 = heli_getteamforsoundclip();
  self playSound(level.heli_sound[_id_FABF84450735DD93]["hit"]);
  thread spinsoundshortly();
  self setyawspeed(speed, speed, speed);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.9);
    wait 1;
  }
}

spinsoundshortly() {
  self endon("death");
  wait 0.25;
  _id_FABF84450735DD93 = heli_getteamforsoundclip();
  self stoploopsound();
  wait 0.05;
  self playLoopSound(level.heli_sound[_id_FABF84450735DD93]["spinloop"]);
  wait 0.05;
  self playLoopSound(level.heli_sound[_id_FABF84450735DD93]["spinstart"]);
}

heli_explode(_id_878A6A7F24D66385) {
  self notify("death");

  if(isDefined(_id_878A6A7F24D66385) && isDefined(level.chopper_fx["explode"]["air_death"][self.heli_type])) {
    _id_027BC369E650ADD5 = self gettagangles("tag_deathfx");
    playFX(level.chopper_fx["explode"]["air_death"][self.heli_type], self gettagorigin("tag_deathfx"), anglesToForward(_id_027BC369E650ADD5), anglestoup(_id_027BC369E650ADD5));
  } else {
    org = self.origin;
    forward = self.origin + (0, 0, 1) - self.origin;
    playFX(level.chopper_fx["explode"]["death"][self.heli_type], org, forward);
  }

  _id_FABF84450735DD93 = heli_getteamforsoundclip();
  self playSound(level.heli_sound[_id_FABF84450735DD93]["crash"]);
  waitframe();

  if(isDefined(self.killcament))
    self.killcament delete();

  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}

check_owner() {
  if(!isDefined(self.owner) || !isDefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team) {
    thread heli_leave();
    return 0;
  }

  return 1;
}

heli_leave_on_disconnect(owner) {
  self endon("death");
  self endon("helicopter_done");
  owner waittill("disconnect");
  thread heli_leave();
}

heli_leave_on_changeteams(owner) {
  self endon("death");
  self endon("helicopter_done");
  owner scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  thread heli_leave();
}

heli_leave_on_spawned(owner) {
  self endon("death");
  self endon("helicopter_done");
  owner waittill("spawned");
  thread heli_leave();
}

heli_leave_on_gameended(owner) {
  self endon("death");
  self endon("helicopter_done");
  level waittill("game_ended");
  thread heli_leave();
}

heli_leave_on_timeout(timeout) {
  self endon("death");
  self endon("helicopter_done");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(timeout);
  thread heli_leave();
}

fireontarget(targetplayer) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  _id_F8819918DB5085EF = 15;
  _id_66A64BC395B4FF7B = 0;
  _id_811DC7CFCFD29886 = 0;

  foreach(node in level.heli_loop_nodes) {
    _id_66A64BC395B4FF7B++;
    _id_811DC7CFCFD29886 = _id_811DC7CFCFD29886 + node.origin[2];
  }

  _id_9B53FC8FA63D4127 = _id_811DC7CFCFD29886 / _id_66A64BC395B4FF7B;
  self notify("newTarget");

  if(isDefined(self.secondarytarget) && self.secondarytarget.damagetaken < self.secondarytarget.maxhealth) {
    return;
  }
  if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
    return;
  }
  currenttarget = self.primarytarget;
  currenttarget.antithreat = 0;
  _id_BBE89BB08D4AAA08 = self.primarytarget.origin * (1, 1, 0);
  _id_4BB61811B9080546 = self.origin * (0, 0, 1);
  _id_2A530280D4341A8A = _id_BBE89BB08D4AAA08 + _id_4BB61811B9080546;
  _id_9A0013A4ACE3B419 = distance2d(self.origin, currenttarget.origin);

  if(_id_9A0013A4ACE3B419 < 1000)
    _id_F8819918DB5085EF = 600;

  _id_4A05B5B6307A4629 = anglesToForward(currenttarget.angles);
  _id_4A05B5B6307A4629 = _id_4A05B5B6307A4629 * (1, 1, 0);
  _id_3F662D6595827E55 = _id_2A530280D4341A8A + _id_F8819918DB5085EF * _id_4A05B5B6307A4629;
  _id_C43FA317DC81B416 = _id_3F662D6595827E55 - _id_2A530280D4341A8A;
  _id_72D48BEAD49642A4 = vectortoangles(_id_C43FA317DC81B416);
  _id_72D48BEAD49642A4 = _id_72D48BEAD49642A4 * (1, 1, 0);
  thread attackgroundtarget(currenttarget);
  self vehicle_setspeed(80);

  if(distance2d(self.origin, _id_3F662D6595827E55) < 1000)
    _id_3F662D6595827E55 = _id_3F662D6595827E55 * 1.5;

  _id_3F662D6595827E55 = _id_3F662D6595827E55 * (1, 1, 0);
  _id_3F662D6595827E55 = _id_3F662D6595827E55 + (0, 0, _id_9B53FC8FA63D4127);
  _setvehgoalpos(_id_3F662D6595827E55, 1, 1);
  self waittill("near_goal");

  if(!isDefined(currenttarget) || !isalive(currenttarget)) {
    return;
  }
  self setlookatent(currenttarget);
  thread isfacing(10, currenttarget);
  scripts\engine\utility::waittill_any_timeout_1(4, "facing");

  if(!isDefined(currenttarget) || !isalive(currenttarget)) {
    return;
  }
  self clearlookatent();
  _id_1969616B8D0C188C = _id_2A530280D4341A8A + _id_F8819918DB5085EF * anglesToForward(_id_72D48BEAD49642A4);
  self setmaxpitchroll(40, 30);
  _setvehgoalpos(_id_1969616B8D0C188C, 1, 1);
  self setmaxpitchroll(30, 30);

  if(isDefined(currenttarget) && isalive(currenttarget)) {
    if(isDefined(currenttarget.antithreat))
      currenttarget.antithreat = currenttarget.antithreat + 100;
    else
      currenttarget.antithreat = 100;
  }

  scripts\engine\utility::waittill_any_timeout_1(3, "near_goal");
}

attackgroundtarget(currenttarget) {
  self notify("attackGroundTarget");
  self endon("attackGroundTarget");
  self stoploopsound();
  self.isattacking = 1;
  self setturrettargetEnt(currenttarget);
  waitontargetordeath(currenttarget, 3.0);

  if(!isalive(currenttarget))
    self.isattacking = 0;
  else {
    _id_72FDE5447014F573 = distance2dsquared(self.origin, currenttarget.origin);

    if(_id_72FDE5447014F573 < 640000) {
      thread dropbombs(currenttarget);
      self.isattacking = 0;
      return;
    } else {
      if(checkisfacing(50, currenttarget) && scripts\engine\utility::cointoss()) {
        thread firemissile(currenttarget);
        self.isattacking = 0;
        return;
        return;
      }

      _id_5B4FB986B8388491 = weaponfiretime("cobra_20mm_mp");
      _id_922819DE2D68C5E7 = 0;
      _id_900A892CF774EA30 = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.heli_turretclipsize; _id_AC0E594AC96AA3A8++) {
        if(!isDefined(self)) {
          break;
        }

        if(self.empgrenaded) {
          break;
        }

        if(!isDefined(currenttarget)) {
          break;
        }

        if(!isalive(currenttarget)) {
          break;
        }

        if(self.damagetaken >= self.maxhealth) {
          continue;
        }
        if(!checkisfacing(55, currenttarget)) {
          self stoploopsound();
          _id_900A892CF774EA30 = 0;
          wait(_id_5B4FB986B8388491);
          _id_AC0E594AC96AA3A8--;
          continue;
        }

        if(_id_AC0E594AC96AA3A8 < level.heli_turretclipsize - 1)
          wait(_id_5B4FB986B8388491);

        if(!isDefined(currenttarget) || !isalive(currenttarget)) {
          break;
        }

        if(!_id_900A892CF774EA30) {
          self playLoopSound("weap_hind_20mm_fire_npc");
          _id_900A892CF774EA30 = 1;
        }

        self setvehweapon("cobra_20mm_mp");
        self fireweapon("tag_flash", currenttarget);
      }

      if(!isDefined(self)) {
        return;
      }
      self stoploopsound();
      _id_900A892CF774EA30 = 0;
      self.isattacking = 0;
    }
  }
}

checkisfacing(tolerance, currenttarget) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(tolerance))
    tolerance = 10;

  _id_596005145E41EAB5 = anglesToForward(self.angles);
  _id_6D9D6722A1121A79 = currenttarget.origin - self.origin;
  _id_596005145E41EAB5 = _id_596005145E41EAB5 * (1, 1, 0);
  _id_6D9D6722A1121A79 = _id_6D9D6722A1121A79 * (1, 1, 0);
  _id_6D9D6722A1121A79 = vectorNormalize(_id_6D9D6722A1121A79);
  _id_596005145E41EAB5 = vectorNormalize(_id_596005145E41EAB5);
  _id_466E87CE09CA407B = vectordot(_id_6D9D6722A1121A79, _id_596005145E41EAB5);
  _id_5762B77F73EDA7C0 = cos(tolerance);

  if(_id_466E87CE09CA407B >= _id_5762B77F73EDA7C0)
    return 1;
  else
    return 0;
}

isfacing(tolerance, currenttarget) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(tolerance))
    tolerance = 10;

  while(isalive(currenttarget)) {
    _id_596005145E41EAB5 = anglesToForward(self.angles);
    _id_6D9D6722A1121A79 = currenttarget.origin - self.origin;
    _id_596005145E41EAB5 = _id_596005145E41EAB5 * (1, 1, 0);
    _id_6D9D6722A1121A79 = _id_6D9D6722A1121A79 * (1, 1, 0);
    _id_6D9D6722A1121A79 = vectorNormalize(_id_6D9D6722A1121A79);
    _id_596005145E41EAB5 = vectorNormalize(_id_596005145E41EAB5);
    _id_466E87CE09CA407B = vectordot(_id_6D9D6722A1121A79, _id_596005145E41EAB5);
    _id_5762B77F73EDA7C0 = cos(tolerance);

    if(_id_466E87CE09CA407B >= _id_5762B77F73EDA7C0) {
      self notify("facing");
      break;
    }

    wait 0.1;
  }
}

waitontargetordeath(target, timeout) {
  self endon("death");
  self endon("helicopter_done");
  target endon("death_or_disconnect");
  scripts\engine\utility::waittill_notify_or_timeout("turret_on_target", timeout);
}

firemissile(_id_6D87867F43E1D612) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  _id_585F84A1C35D91B1 = 2;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_585F84A1C35D91B1; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(_id_6D87867F43E1D612)) {
      return;
    }
    if(scripts\engine\utility::cointoss()) {
      missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_missile_mp"), self gettagorigin("tag_missile_right") - (0, 0, 64), _id_6D87867F43E1D612.origin, self.owner);
      missile.vehicle_fired_from = self;
    } else {
      missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_missile_mp"), self gettagorigin("tag_missile_left") - (0, 0, 64), _id_6D87867F43E1D612.origin, self.owner);
      missile.vehicle_fired_from = self;
    }

    missile missile_settargetEnt(_id_6D87867F43E1D612);
    missile.owner = self;
    missile missile_setflightmodedirect();
    wait(0.5 / _id_585F84A1C35D91B1);
  }
}

dropbombs(_id_6D87867F43E1D612) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(!isDefined(_id_6D87867F43E1D612)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < randomintrange(2, 5); _id_AC0E594AC96AA3A8++) {
    if(scripts\engine\utility::cointoss()) {
      missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_bomb_mp"), self gettagorigin("tag_missile_left") - (0, 0, 45), _id_6D87867F43E1D612.origin, self.owner);
      missile.vehicle_fired_from = self;
    } else {
      missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hind_bomb_mp"), self gettagorigin("tag_missile_right") - (0, 0, 45), _id_6D87867F43E1D612.origin, self.owner);
      missile.vehicle_fired_from = self;
    }

    wait(randomfloatrange(0.35, 0.65));
  }
}

getoriginoffsets(goalnode) {
  startorigin = self.origin;
  endorigin = goalnode.origin;
  _id_17ADD9E21FF7EBFD = 0;
  _id_2F99083E1BBAC6D7 = 40;
  _id_5985D426AA39D205 = (0, 0, -196);

  for(_id_32EDCDCF986B48C4 = scripts\engine\trace::_bullet_trace(startorigin + _id_5985D426AA39D205, endorigin + _id_5985D426AA39D205, 0, self); distancesquared(_id_32EDCDCF986B48C4["position"], endorigin + _id_5985D426AA39D205) > 10 && _id_17ADD9E21FF7EBFD < _id_2F99083E1BBAC6D7; _id_32EDCDCF986B48C4 = scripts\engine\trace::_bullet_trace(startorigin + _id_5985D426AA39D205, endorigin + _id_5985D426AA39D205, 0, self)) {
    if(startorigin[2] < endorigin[2])
      startorigin = startorigin + (0, 0, 128);
    else if(startorigin[2] > endorigin[2])
      endorigin = endorigin + (0, 0, 128);
    else {
      startorigin = startorigin + (0, 0, 128);
      endorigin = endorigin + (0, 0, 128);
    }

    _id_17ADD9E21FF7EBFD++;
  }

  offsets = [];
  offsets["start"] = startorigin;
  offsets["end"] = endorigin;
  return offsets;
}

traveltonode(goalnode) {
  _id_518DE3237BEEE8A6 = getoriginoffsets(goalnode);

  if(_id_518DE3237BEEE8A6["start"] != self.origin) {
    self vehicle_setspeed(75, 35);
    _setvehgoalpos(_id_518DE3237BEEE8A6["start"] + (0, 0, 30), 0);
    self setgoalyaw(goalnode.angles[1] + level.heli_angle_offset);
    self waittill("goal");
  }

  if(_id_518DE3237BEEE8A6["end"] != goalnode.origin) {
    if(isDefined(goalnode.script_airspeed) && isDefined(goalnode.script_accel)) {
      _id_E4CF8DCD09CD238D = goalnode.script_airspeed;
      _id_95C6B16B38DE3E56 = goalnode.script_accel;
    } else {
      _id_E4CF8DCD09CD238D = 30 + randomint(20);
      _id_95C6B16B38DE3E56 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(_id_518DE3237BEEE8A6["end"] + (0, 0, 30), 0);
    self setgoalyaw(goalnode.angles[1] + level.heli_angle_offset);
    self waittill("goal");
  }
}

_setvehgoalpos(_id_2F38DABD01860335, _id_0E6A6756BBBE9A3E, _id_10947963C8A8A722) {
  if(!isDefined(_id_0E6A6756BBBE9A3E))
    _id_0E6A6756BBBE9A3E = 0;

  _id_10947963C8A8A722 = 0;

  if(_id_10947963C8A8A722)
    thread _setvehgoalposadheretomesh(_id_2F38DABD01860335, _id_0E6A6756BBBE9A3E);
  else
    self setvehgoalpos(_id_2F38DABD01860335, _id_0E6A6756BBBE9A3E);
}

_setvehgoalposadheretomesh(_id_2F38DABD01860335, _id_0E6A6756BBBE9A3E) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  _id_7CF2E671D5CE666F = _id_2F38DABD01860335;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(scripts\engine\utility::distance_2d_squared(self.origin, _id_7CF2E671D5CE666F) < 65536) {
      self setvehgoalpos(_id_7CF2E671D5CE666F, _id_0E6A6756BBBE9A3E);
      break;
    }

    _id_8B299BC599C459A5 = vectortoangles(_id_7CF2E671D5CE666F - self.origin);
    _id_C7645062191FD7C6 = anglesToForward(_id_8B299BC599C459A5);
    _id_7A7EAF576C2DCC51 = self.origin + _id_C7645062191FD7C6 * (1, 1, 0) * 250;
    _id_5985D426AA39D205 = (0, 0, 2500);
    tracestart = _id_7A7EAF576C2DCC51 + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() + _id_5985D426AA39D205);
    _id_8B39E5984DA1FFAF = _id_7A7EAF576C2DCC51 + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() - _id_5985D426AA39D205);
    _id_29AEA598C15F22F8 = scripts\engine\trace::_bullet_trace(tracestart, _id_8B39E5984DA1FFAF, 0, self, 0, 0, 1);
    _id_7C00EB979037C433 = _id_29AEA598C15F22F8;

    if(isDefined(_id_29AEA598C15F22F8["entity"]) && _id_29AEA598C15F22F8["entity"] == self && _id_29AEA598C15F22F8["normal"][2] > 0.1) {
      _id_0A38B0F14438E3E6 = _id_29AEA598C15F22F8["position"][2] - 4400;
      _id_CDFF5D407723F731 = _id_0A38B0F14438E3E6 - self.origin[2];

      if(_id_CDFF5D407723F731 > 256) {
        _id_29AEA598C15F22F8["position"] = _id_29AEA598C15F22F8["position"] * (1, 1, 0);
        _id_29AEA598C15F22F8["position"] = _id_29AEA598C15F22F8["position"] + (0, 0, self.origin[2] + 256);
      } else if(_id_CDFF5D407723F731 < -256) {
        _id_29AEA598C15F22F8["position"] = _id_29AEA598C15F22F8["position"] * (1, 1, 0);
        _id_29AEA598C15F22F8["position"] = _id_29AEA598C15F22F8["position"] + (0, 0, self.origin[2] - 256);
      }

      _id_7C00EB979037C433 = _id_29AEA598C15F22F8["position"] - scripts\mp\utility\killstreak::gethelipilotmeshoffset() + (0, 0, 600);
    } else
      _id_7C00EB979037C433 = _id_7CF2E671D5CE666F;

    self setvehgoalpos(_id_7C00EB979037C433, 0);
    wait 0.15;
  }
}

heli_fly_simple_path(startnode) {
  self endon("death");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();
  currentnode = startnode;

  while(isDefined(currentnode.target)) {
    nextnode = getEnt(currentnode.target, "targetname");

    if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel)) {
      _id_E4CF8DCD09CD238D = currentnode.script_airspeed;
      _id_95C6B16B38DE3E56 = currentnode.script_accel;
    } else {
      _id_E4CF8DCD09CD238D = 30 + randomint(20);
      _id_95C6B16B38DE3E56 = 15 + randomint(15);
    }

    if(isDefined(self.isattacking) && self.isattacking) {
      waitframe();
      continue;
    }

    if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      waitframe();
      continue;
    }

    self vehicle_setspeed(75, 35);

    if(!isDefined(nextnode.target)) {
      _setvehgoalpos(nextnode.origin + self.zoffset, 1);
      self waittill("near_goal");
    } else {
      _setvehgoalpos(nextnode.origin + self.zoffset, 0);
      self waittill("near_goal");
      self setgoalyaw(nextnode.angles[1]);
      self waittillmatch("goal");
    }

    currentnode = nextnode;
  }
}

heli_fly_loop_path(startnode) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();
  thread heli_loop_speed_control(startnode);
  currentnode = startnode;

  while(isDefined(currentnode.target)) {
    nextnode = getEnt(currentnode.target, "targetname");

    if(isDefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      wait 0.25;
      continue;
    }

    if(isDefined(self.isattacking) && self.isattacking) {
      wait 0.1;
      continue;
    }

    if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel)) {
      self.desired_speed = currentnode.script_airspeed;
      self.desired_accel = currentnode.script_accel;
    } else {
      self.desired_speed = 30 + randomint(20);
      self.desired_accel = 15 + randomint(15);
    }

    if(self.helitype == "flares") {
      self.desired_speed = self.desired_speed * 0.5;
      self.desired_accel = self.desired_accel * 0.5;
    }

    if(isDefined(nextnode.script_delay) && isDefined(self.primarytarget) && !heli_is_threatened()) {
      _setvehgoalpos(nextnode.origin + self.zoffset, 1, 1);
      self waittill("near_goal");
      wait(nextnode.script_delay);
    } else {
      _setvehgoalpos(nextnode.origin + self.zoffset, 0, 1);
      self waittill("near_goal");
      self setgoalyaw(nextnode.angles[1]);
      self waittillmatch("goal");
    }

    currentnode = nextnode;
  }
}

heli_loop_speed_control(currentnode) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel)) {
    self.desired_speed = currentnode.script_airspeed;
    self.desired_accel = currentnode.script_accel;
  } else {
    self.desired_speed = 30 + randomint(20);
    self.desired_accel = 15 + randomint(15);
  }

  _id_E803426D2ABADFC0 = 0;
  _id_B1D46319AA26B913 = 0;

  for(;;) {
    _id_AF03A5AC7D47D6CD = self.desired_speed;
    _id_4C3FE0AF18132696 = self.desired_accel;

    if(isDefined(self.isattacking) && self.isattacking) {
      waitframe();
      continue;
    }

    if(self.helitype != "flares" && isDefined(self.primarytarget) && !heli_is_threatened())
      _id_AF03A5AC7D47D6CD = _id_AF03A5AC7D47D6CD * 0.25;

    if(_id_E803426D2ABADFC0 != _id_AF03A5AC7D47D6CD || _id_B1D46319AA26B913 != _id_4C3FE0AF18132696) {
      self vehicle_setspeed(75, 35);
      _id_E803426D2ABADFC0 = _id_AF03A5AC7D47D6CD;
      _id_B1D46319AA26B913 = _id_4C3FE0AF18132696;
    }

    wait 0.05;
  }
}

heli_is_threatened() {
  if(self.recentdamageamount > 50)
    return 1;

  if(self.currentstate == "heavy smoke")
    return 1;

  return 0;
}

heli_fly_well(_id_3797DE2C5011A2D6) {
  self notify("flying");
  self endon("flying");
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for(;;) {
    if(isDefined(self.isattacking) && self.isattacking) {
      waitframe();
      continue;
    }

    currentnode = get_best_area_attack_node(_id_3797DE2C5011A2D6);
    traveltonode(currentnode);

    if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel)) {
      _id_E4CF8DCD09CD238D = currentnode.script_airspeed;
      _id_95C6B16B38DE3E56 = currentnode.script_accel;
    } else {
      _id_E4CF8DCD09CD238D = 30 + randomint(20);
      _id_95C6B16B38DE3E56 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(currentnode.origin + self.zoffset, 1);
    self setgoalyaw(currentnode.angles[1] + level.heli_angle_offset);

    if(level.heli_forced_wait != 0) {
      self waittill("near_goal");
      wait(level.heli_forced_wait);
      continue;
    }

    if(!isDefined(currentnode.script_delay)) {
      self waittill("near_goal");
      wait(5 + randomint(5));
      continue;
    }

    self waittillmatch("goal");
    wait(currentnode.script_delay);
  }
}

get_best_area_attack_node(_id_3797DE2C5011A2D6) {
  return updateareanodes(_id_3797DE2C5011A2D6);
}

heli_leave(_id_58CF87EA08AB452E) {
  self notify("leaving");
  self clearlookatent();

  if(isDefined(self.helitype) && self.helitype == "osprey" && isDefined(self.pathgoal)) {
    _setvehgoalpos(self.pathgoal, 1);
    scripts\engine\utility::waittill_any_timeout_1(5, "goal");
  }

  if(!isDefined(_id_58CF87EA08AB452E)) {
    _id_4D501DC6FD1A00A0 = level.heli_leave_nodes[randomint(level.heli_leave_nodes.size)];
    _id_58CF87EA08AB452E = _id_4D501DC6FD1A00A0.origin;
  }

  _id_60347FD2432F3A63 = spawn("script_origin", _id_58CF87EA08AB452E);

  if(isDefined(_id_60347FD2432F3A63)) {
    self setlookatent(_id_60347FD2432F3A63);
    _id_60347FD2432F3A63 thread wait_and_delete(3.0);
  }

  _id_B2805E2F86AC4904 = (_id_58CF87EA08AB452E - self.origin) * 2000;
  heli_reset();
  self vehicle_setspeed(180, 45);
  _setvehgoalpos(_id_B2805E2F86AC4904, 1);
  scripts\engine\utility::waittill_any_timeout_1(12, "goal");
  self notify("gone");
  self notify("death");
  waitframe();

  if(isDefined(self.killcament))
    self.killcament delete();

  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}

wait_and_delete(waittime) {
  self endon("death");
  level endon("game_ended");
  wait(waittime);
  self delete();
}

debug_print3d(message, color, ent, origin_offset, _id_1AAD8F38CB38F703) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0)
    thread draw_text(message, color, ent, origin_offset, _id_1AAD8F38CB38F703);
}

debug_print3d_simple(message, ent, offset, _id_1AAD8F38CB38F703) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0) {
    if(isDefined(_id_1AAD8F38CB38F703))
      thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, _id_1AAD8F38CB38F703);
    else
      thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, 0);
  }
}

debug_line(from, to, color, _id_1AAD8F38CB38F703) {
  if(isDefined(level.heli_debug) && level.heli_debug == 1.0 && !isDefined(_id_1AAD8F38CB38F703))
    thread draw_line(from, to, color);
  else if(isDefined(level.heli_debug) && level.heli_debug == 1.0)
    thread draw_line(from, to, color, _id_1AAD8F38CB38F703);
}

draw_text(msg, color, ent, offset, _id_1AAD8F38CB38F703) {
  if(_id_1AAD8F38CB38F703 == 0) {
    while(isDefined(ent))
      wait 0.05;
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1AAD8F38CB38F703; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(ent)) {
        break;
      }

      wait 0.05;
    }
  }
}

draw_line(from, to, color, _id_1AAD8F38CB38F703) {
  if(isDefined(_id_1AAD8F38CB38F703)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1AAD8F38CB38F703; _id_AC0E594AC96AA3A8++)
      wait 0.05;
  } else {
    for(;;)
      wait 0.05;
  }
}

exceededmaxlittlebirds(streakname) {
  if(level.littlebirds.size >= 4 || level.littlebirds.size >= 2 && streakname == "littlebird_flock")
    return 1;
  else
    return 0;
}

pavelowmadeselectionvo() {
  self endon("death_or_disconnect");
  self playlocalsound(game["voice"][self.team] + "KS_hqr_pavelow");
  wait 3.5;
  self playlocalsound(game["voice"][self.team] + "KS_pvl_inbound");
}

lbonkilled() {
  self endon("gone");

  if(!isDefined(self)) {
    return;
  }
  self notify("crashing");

  if(isDefined(self.largeprojectiledamage) && self.largeprojectiledamage)
    waitframe();
  else {
    self vehicle_setspeed(25, 5);
    thread lbspin(randomintrange(180, 220));
    wait(randomfloatrange(1.0, 2.0));
  }

  lbexplode();
}

lbspin(speed) {
  self endon("explode");
  playFXOnTag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  thread trail_fx(level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke");
  self setyawspeed(speed, speed, speed);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.9);
    wait 1;
  }
}

lbexplode() {
  forward = self.origin + (0, 0, 1) - self.origin;
  _id_027BC369E650ADD5 = self gettagangles("tag_deathfx");
  playFX(level.chopper_fx["explode"]["air_death"]["littlebird"], self gettagorigin("tag_deathfx"), anglesToForward(_id_027BC369E650ADD5), anglestoup(_id_027BC369E650ADD5));
  self playSound("exp_helicopter_fuel");
  self notify("explode");
  removelittlebird();
}

trail_fx(trail_fx, _id_67ADF4A70AEED798, _id_DA34C68A2CA176D7) {
  self notify(_id_DA34C68A2CA176D7);
  self endon(_id_DA34C68A2CA176D7);
  self endon("death");

  for(;;) {
    playFXOnTag(trail_fx, self, _id_67ADF4A70AEED798);
    wait 0.05;
  }
}

removelittlebird() {
  if(isDefined(self.mgturretleft)) {
    if(isDefined(self.mgturretleft.killcament))
      self.mgturretleft.killcament delete();

    self.mgturretleft delete();
  }

  if(isDefined(self.mgturretright)) {
    if(isDefined(self.mgturretright.killcament))
      self.mgturretright.killcament delete();

    self.mgturretright delete();
  }

  if(isDefined(self.marker))
    self.marker delete();

  if(isDefined(level.heli_pilot[self.team]) && level.heli_pilot[self.team] == self)
    level.heli_pilot[self.team] = undefined;

  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}