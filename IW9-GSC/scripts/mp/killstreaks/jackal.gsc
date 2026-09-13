/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\jackal.gsc
***********************************************/

beginjackal(lifeid, startpoint, pos, streakinfo, tacopslz) {
  if(!isDefined(level.jackals))
    level.jackals = [];

  marker = undefined;

  if(isDefined(tacopslz)) {
    marker = tacopslz.marker;
    _id_4F358D69033A2C70 = 2;

    if(!isDefined(marker)) {
      marker = spawnStruct();

      if(isDefined(tacopslz.location))
        marker.location = tacopslz.location;
      else
        marker.location = tacopslz.trigger.origin;

      marker.angles = (0, 0, 0);
      marker.string = "equip_deploy_succeeded";
      marker.visual = spawn("script_model", marker.location);
      marker.visual setModel("ks_marker_mp");
      marker.visual setotherent(self);
    }

    if(!isDefined(marker.location)) {
      self notify("cancel_jackal");
      return 0;
    } else if(isDefined(level.jackal_incoming) || level.jackals.size >= _id_4F358D69033A2C70) {
      if(isDefined(marker.visual))
        marker.visual delete();

      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

      if(isDefined(streakinfo.objweapon) && streakinfo.objweapon.basename != "none")
        self notify("killstreak_finished_with_weapon_" + streakinfo.weaponname);

      self notify("cancel_jackal");
      return 0;
    }
  }

  self notify("called_in_jackal");
  level.jackal_incoming = 1;
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

  if(isDefined(_id_5FA1E1697A302583))
    _id_1DC672CFE0F0128E = _id_5FA1E1697A302583.origin[2] + 500;
  else
    _id_1DC672CFE0F0128E = 1300;

  if(isDefined(marker) && isDefined(marker.location))
    pos = marker.location;

  pos = pos * (1, 1, 0);
  pathgoal = pos + (0, 0, _id_1DC672CFE0F0128E);
  jackal = spawnksjackal(lifeid, self, startpoint, pathgoal, streakinfo, tacopslz);
  jackal.tacopslz = tacopslz;
  _id_EC558BCB59D5D0B9 = pathgoal;
  _id_EC5588CB59D5CA20 = pathgoal + anglestoright(self.angles) * 2000;
  _id_EC5589CB59D5CC53 = pathgoal - anglestoright(self.angles) * 2000;
  _id_DE2DFFA9E85BC167 = [_id_EC558BCB59D5D0B9, _id_EC5588CB59D5CA20, _id_EC5589CB59D5CC53];

  foreach(goal in _id_DE2DFFA9E85BC167) {
    if(!jackalcanseelocation(jackal, goal)) {
      continue;
    }
    pathgoal = goal;
    break;
  }

  jackal.pathgoal = pathgoal;
  thread defendlocation(jackal, marker);
  return jackal;
}

spawnksjackal(lifeid, owner, pathstart, pathgoal, streakinfo, tacopslz) {
  forward = vectortoangles(pathgoal - pathstart);
  numflares = 4;
  _id_F751B396E9B232E6 = 50;
  _id_A001268025A19C55 = 175;
  maxhealth = 10000;
  _id_1ABFBB19B71BCCF8 = "veh8_mil_air_lbravo";
  _id_44DD671F6E49B125 = "jackal_turret_mp";
  _id_C5836308D0A5013A = "veh_mil_air_ca_dropship_mp_turret";
  _id_D9F3116109296870 = 1;
  _id_B06E96E3D35F4D9E = "jackal_cannon_mp";
  _id_C3203D1148C1E58B = "veh_mil_air_ca_dropship_turret_missile";
  _id_403A5AABBD2FDAB7 = 1;
  currentstring = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
  _id_09B3F7C7B98C0754 = "follow_player";

  if(isDefined(tacopslz))
    _id_09B3F7C7B98C0754 = "guard_location";

  jackal = spawnhelicopter(owner, pathstart, forward, "veh_airdrop_mp", _id_1ABFBB19B71BCCF8);

  if(!isDefined(jackal)) {
    return;
  }
  if(isDefined(tacopslz))
    jackal.lz = tacopslz;

  jackal thread handledestroydamage();
  jackal.damagecallback = ::callback_vehicledamage;
  jackal.speed = _id_F751B396E9B232E6;
  jackal.accel = _id_A001268025A19C55;
  jackal.health = maxhealth;
  jackal.maxhealth = jackal.health;
  jackal.team = owner.team;
  jackal.owner = owner;
  jackal setCanDamage(1);
  jackal.defendloc = pathgoal;
  jackal.lifeid = lifeid;
  jackal.jackal = 1;
  jackal.streakinfo = streakinfo;
  jackal.streakname = streakinfo.streakname;
  jackal.evasivemaneuvers = 0;
  jackal.combatmode = _id_09B3F7C7B98C0754;
  jackal.currentstring = currentstring;
  jackal.streakinfo = streakinfo;
  jackal.flaresreservecount = numflares;
  jackal.turreton = _id_D9F3116109296870;
  jackal.turretweapon = _id_44DD671F6E49B125;
  jackal.cannonweapon = _id_B06E96E3D35F4D9E;
  jackal.cannonon = _id_403A5AABBD2FDAB7;
  jackal scripts\mp\utility\killstreak::addtoactivekillstreaklist(streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);
  jackal setmaxpitchroll(0, 90);
  jackal vehicle_setspeed(jackal.speed, jackal.accel);
  jackal sethoverparams(50, 100, 50);
  jackal setturningability(0.05);
  jackal setyawspeed(45, 25, 25, 0.5);
  jackal setotherent(owner);
  _id_3DF8FF290801ABE5 = anglesToForward(jackal.angles);

  if(!isDefined(tacopslz)) {
    jackal.turret = spawnturret("misc_turret", jackal gettagorigin("tag_origin"), _id_44DD671F6E49B125);
    jackal.turret setModel(_id_C5836308D0A5013A);
    jackal.turret.owner = owner;
    jackal.turret.team = owner.team;
    jackal.turret.angles = jackal.angles;
    jackal.turret.type = "Machine_Gun";
    jackal.turret.streakinfo = streakinfo;
    jackal.turret linkTo(jackal, "tag_origin", (200, 0, 55), (0, 0, 0));
    jackal.turret setturretmodechangewait(0);
    jackal.turret setmode("manual_target");
    jackal.turret setsentryowner(owner);
    jackal.cannon = spawnturret("misc_turret", jackal gettagorigin("tag_origin"), _id_B06E96E3D35F4D9E);
    jackal.cannon setModel(_id_C3203D1148C1E58B);
    jackal.cannon.owner = owner;
    jackal.cannon.team = owner.team;
    jackal.cannon.angles = jackal.angles;
    jackal.cannon.type = "Cannon";
    jackal.cannon.streakinfo = streakinfo;
    jackal.cannon linkTo(jackal, "tag_origin", (-100, 0, 55), (0, 0, 0));
    jackal.cannon setturretmodechangewait(0);
    jackal.cannon setmode("manual_target");
    jackal.cannon setsentryowner(owner);
  }

  jackal.useobj = spawn("script_model", jackal gettagorigin("tag_origin"));
  jackal.useobj linkTo(jackal, "tag_origin");
  level.jackals[level.jackals.size] = jackal;
  level.jackals = scripts\engine\utility::array_removeundefined(level.jackals);
  level.jackal_incoming = undefined;

  if(isDefined(tacopslz))
    jackal thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);

  jackal thread jackaldestroyed();
  jackal thread delayjackalloopsfx(0.05, "dropship_enemy_hover_world_grnd");
  jackal thread delay_jackal_arrive_sfx();

  if(!isDefined(tacopslz)) {
    jackal.turret.vehicle_fired_from = jackal;
    jackal.cannon.vehicle_fired_from = jackal;
    jackal.turret.vehicle_fired_from.killcament = spawn("script_model", jackal gettagorigin("tag_origin"));
    jackal.turret.vehicle_fired_from.killcament linkTo(jackal, "tag_origin");
    jackal.cannon.vehicle_fired_from.killcament = jackal.turret.vehicle_fired_from.killcament;
  }

  _id_7A05F5CEED8AB610 = anglesToForward(jackal.angles);
  return jackal;
}

getnumownedjackals(owner) {
  counter = 0;

  if(level.teambased) {
    foreach(jackal in level.jackals) {
      if(jackal.team != owner.team) {
        continue;
      }
      counter++;
    }
  } else {
    foreach(jackal in level.jackals) {
      if(jackal.owner != owner) {
        continue;
      }
      counter++;
    }
  }

  return counter;
}

delay_jackal_arrive_sfx() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
}

delayjackalloopsfx(_id_74B5B12BB6514385, alias) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(_id_74B5B12BB6514385);
  self playLoopSound(alias);
}

defendlocation(jackal, marker) {
  jackal endon("death");
  jackal setvehgoalpos(jackal.pathgoal, 1);
  jackal thread closetogoalcheck(jackal.pathgoal);
  jackal thread monitorowner();

  if(isDefined(jackal.dropcrates))
    jackal thread watchdropcratesearly(marker);

  jackal waittill("goal");

  if(isDefined(marker) && isDefined(jackal.lz)) {
    jackal thread jackaltimer();
    jackal thread watchgameendleave();
    jackal thread engageprimarytarget();
    jackal.speed = 250;
    jackal vehicle_setspeed(50, 15);
    jackal jackalmovetolocation(marker.location);
    jackal waittill("extract_hostages");
    jackal thread jackalleave(50, 15);
  } else if(isDefined(marker) && isDefined(jackal.dropcrates)) {
    jackal thread jackaltimer();
    jackal thread watchgameendleave();
    jackal thread engageprimarytarget();
    jackal thread engagesecondarytarget();
    jackal vehicle_setspeed(50, 15);
    jackal jackalmovetolocation(marker.location);
    jackal thread dropcrates(jackal.dropcrates, marker);
    jackal thread watchjackalcratepickup();
    jackal scripts\engine\utility::waittill_any_timeout_1(10, "all_crates_gone");
    jackal.combatmode = "follow_player";
  } else {
    jackal thread jackaltimer();
    jackal thread watchgameendleave();
    jackal thread engageprimarytarget();
    jackal thread engagesecondarytarget();
    jackal vehicle_setspeed(int(jackal.speed / 14), int(jackal.accel / 16));
  }

  if(!isDefined(jackal.lz)) {
    jackal.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(jackal.owner, jackal.currentstring, 360, 360, 30000, 30000, 2);
    jackal thread patrolfield();
    jackal thread watchmodechange(getothermode(jackal.combatmode), jackal.currentstring);
  }
}

engageprimarytarget() {
  self notify("engagePrimary");
  self endon("engagePrimary");
  self endon("leaving");
  self endon("death");
  self.lastaction = undefined;

  if(istrue(self.turreton)) {
    for(;;) {
      targets = jackalgettargets();

      if(isDefined(targets) && targets.size > 0) {
        acquireturrettarget(targets);
        self.turret waittill("stop_firing");

        if(self.combatmode == "follow_player")
          thread patrolfield();
      } else
        self.lastaction = "noTargetsFound";

      wait 0.05;
    }
  }
}

engagesecondarytarget() {
  self notify("engageSecondary");
  self endon("engageSecondary");
  self endon("leaving");
  self endon("death");
  _id_81E7EE4D98262708 = weaponfiretime(self.cannonweapon);

  if(istrue(self.cannonon)) {
    for(;;) {
      targets = jackalgettargets();

      if(!isDefined(targets) || targets.size < 2) {
        waitframe();
        continue;
      }

      acquirecannontarget(targets);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(_id_81E7EE4D98262708);
    }
  }
}

followplayer() {
  self endon("death");
  self endon("leaving");
  self endon("guard_location");
  self endon("priority_target");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self notify("following_player");
  self vehicle_setspeed(50, 15);

  for(;;) {
    _id_6C53D859D582A421 = undefined;

    if(istrue(self.evasivemaneuvers)) {
      _id_52A499A16497488C = self.owner.origin[0];
      _id_52A49AA164974ABF = self.owner.origin[1];
      _id_F7CD955C75C5D1BF = _id_52A499A16497488C + randomintrange(-500, 500);
      _id_F7CD945C75C5CF8C = _id_52A49AA164974ABF + randomintrange(-500, 500);
      _id_7504C8791E34DC73 = getcorrectheight(_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, 350);
      _id_6C53D859D582A421 = (_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, _id_7504C8791E34DC73);
    } else {
      _id_52A499A16497488C = self.owner.origin[0];
      _id_52A49AA164974ABF = self.owner.origin[1];
      _id_7504C8791E34DC73 = getcorrectheight(_id_52A499A16497488C, _id_52A49AA164974ABF, 20);
      _id_6C53D859D582A421 = (_id_52A499A16497488C, _id_52A49AA164974ABF, _id_7504C8791E34DC73);
    }

    self setlookatent(self.owner);
    self setvehgoalpos(_id_6C53D859D582A421, 1);
    self.lastaction = "following_player";
    scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");
    self clearlookatent();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

guardposition(position) {
  self endon("death");
  self endon("leaving");
  self endon("follow_player");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));
  _id_6C53D859D582A421 = undefined;

  if(isDefined(position)) {
    _id_52A499A16497488C = position[0];
    _id_52A49AA164974ABF = position[1];
    _id_7504C8791E34DC73 = getcorrectheight(_id_52A499A16497488C, _id_52A49AA164974ABF, 20);
    _id_6C53D859D582A421 = (_id_52A499A16497488C, _id_52A49AA164974ABF, _id_7504C8791E34DC73);
  } else if(istrue(self.evasivemaneuvers)) {
    _id_52A499A16497488C = self.owner.origin[0];
    _id_52A49AA164974ABF = self.owner.origin[1];
    _id_F7CD955C75C5D1BF = _id_52A499A16497488C + randomintrange(-500, 500);
    _id_F7CD945C75C5CF8C = _id_52A49AA164974ABF + randomintrange(-500, 500);
    _id_7504C8791E34DC73 = getcorrectheight(_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, 350);
    _id_6C53D859D582A421 = (_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, _id_7504C8791E34DC73);
  } else {
    _id_52A499A16497488C = self.owner.origin[0];
    _id_52A49AA164974ABF = self.owner.origin[1];
    _id_7504C8791E34DC73 = getcorrectheight(_id_52A499A16497488C, _id_52A49AA164974ABF, 20);
    _id_6C53D859D582A421 = (_id_52A499A16497488C, _id_52A49AA164974ABF, _id_7504C8791E34DC73);
  }

  self setlookatent(self.owner);
  self setvehgoalpos(_id_6C53D859D582A421, 1);
  self.lastaction = "following_player";
  scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");
  self clearlookatent();
}

patrolfield() {
  self endon("death");
  self endon("leaving");
  self endon("guard_location");
  self endon("priority_target");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));

  for(;;) {
    _id_6C53D859D582A421 = undefined;

    if(isDefined(self.patroltarget) && isalive(self.patroltarget) && isPlayer(self.patroltarget) && !self.patroltarget scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
      if(!jackalcanseeenemy(self.patroltarget) || distance2dsquared(self.origin, self.patroltarget.origin) > 4194304)
        jackalmovetoenemy(self.patroltarget);
    } else {
      target = jackalfindclosestenemy();

      if(isDefined(target)) {
        self.patroltarget = target;
        thread watchpatroltarget();
        jackalmovetoenemy(target);
      } else {
        self.patroltarget = undefined;
        location = jackalfindfirstopenpoint();

        if(isDefined(location))
          jackalmovetolocation(location.origin);
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

jackalfindfirstopenpoint() {
  point = undefined;

  if(isDefined(level.carepackagedropnodes) && level.carepackagedropnodes.size > 0) {
    foreach(loc in level.carepackagedropnodes) {
      if(isDefined(loc.free) && !loc.free) {
        continue;
      }
      if(!jackalcanseelocation(self, loc.origin)) {
        continue;
      }
      loc.free = 0;
      point = loc;

      if(!isDefined(self.initialpatrolpoint))
        self.initialpatrolpoint = point;

      break;
    }

    if(!isDefined(point)) {
      if(isDefined(self.initialpatrolpoint)) {
        foreach(loc in level.carepackagedropnodes) {
          if(loc != self.initialpatrolpoint)
            loc.free = undefined;
        }

        point = self.initialpatrolpoint;
      }
    }
  }

  return point;
}

jackalcanseelocation(jackal, loc) {
  _id_027B697504D9397D = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);

  if(scripts\engine\trace::ray_trace_passed(jackal.origin, loc, jackal, contents))
    _id_027B697504D9397D = 1;

  return _id_027B697504D9397D;
}

jackalcanseeenemy(target) {
  _id_027B697504D9397D = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);
  _id_D895C679F6A927E5 = [target gettagorigin("j_head"), target gettagorigin("j_mainroot"), target gettagorigin("tag_origin")];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], self, contents)) {
      continue;
    }
    _id_027B697504D9397D = 1;
    break;
  }

  return _id_027B697504D9397D;
}

jackalmovetoenemy(target) {
  if(isDefined(self.patroltarget))
    target = self.patroltarget;

  if(jackalcanseeenemy(target))
    self setlookatent(target);

  _id_6C53D859D582A421 = undefined;

  if(istrue(self.evasivemaneuvers)) {
    _id_52A499A16497488C = target.origin[0];
    _id_52A49AA164974ABF = target.origin[1];
    _id_F7CD955C75C5D1BF = _id_52A499A16497488C + randomintrange(-500, 500);
    _id_F7CD945C75C5CF8C = _id_52A49AA164974ABF + randomintrange(-500, 500);
    _id_7504C8791E34DC73 = getcorrectheight(_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, 350);
    _id_6C53D859D582A421 = (_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, _id_7504C8791E34DC73);
  } else {
    _id_52A499A16497488C = target.origin[0];
    _id_52A49AA164974ABF = target.origin[1];
    _id_7504C8791E34DC73 = getcorrectheight(_id_52A499A16497488C, _id_52A49AA164974ABF, 20);
    _id_6C53D859D582A421 = (_id_52A499A16497488C, _id_52A49AA164974ABF, _id_7504C8791E34DC73);
  }

  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  trace = scripts\engine\trace::ray_trace(self.origin, _id_6C53D859D582A421, level.characters, contentoverride);

  if(trace["hittype"] != "hittype_none") {
    _id_F7CD975C75C5D625 = getcorrectheight(trace["position"][0], trace["position"][1], 20);
    _id_6C53D859D582A421 = (trace["position"][0], trace["position"][1], _id_F7CD975C75C5D625);
  }

  self setvehgoalpos(_id_6C53D859D582A421 + (0, 0, 500), 2);
  self.lastaction = "patrol";
  scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");
  self clearlookatent();
}

jackalfindclosestenemy() {
  _id_395824552AD4CB06 = [];

  foreach(_id_7DC3241E7F3C6B24 in level.players) {
    if(_id_7DC3241E7F3C6B24.ignoreme || isDefined(_id_7DC3241E7F3C6B24.owner) && _id_7DC3241E7F3C6B24.owner.ignoreme) {
      continue;
    }
    if(!isalive(_id_7DC3241E7F3C6B24)) {
      continue;
    }
    if(isDefined(level.teambased) && isDefined(_id_7DC3241E7F3C6B24.team) && self.team == _id_7DC3241E7F3C6B24.team) {
      continue;
    }
    if(_id_7DC3241E7F3C6B24 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
      continue;
    }
    if(_id_7DC3241E7F3C6B24 isjackalenemyindoors()) {
      continue;
    }
    _id_395824552AD4CB06[_id_395824552AD4CB06.size] = _id_7DC3241E7F3C6B24;
    waitframe();
  }

  _id_6293B832D8F1FE43 = undefined;

  if(_id_395824552AD4CB06.size > 0)
    _id_6293B832D8F1FE43 = sortbydistance(_id_395824552AD4CB06, self.origin);

  if(isDefined(_id_6293B832D8F1FE43) && _id_6293B832D8F1FE43.size > 0)
    return _id_6293B832D8F1FE43[0];

  return undefined;
}

isjackalenemyindoors() {
  _id_DF3DA2640FE45887 = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 10000), self, contents))
    _id_DF3DA2640FE45887 = 1;

  return _id_DF3DA2640FE45887;
}

watchpatroltarget() {
  self endon("death");
  self endon("leaving");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  result = self.patroltarget scripts\engine\utility::waittill_any_timeout_1(5, "death_or_disconnect");
  self.patroltarget = undefined;
}

jackalmovetolocation(location) {
  _id_6C53D859D582A421 = undefined;

  if(istrue(self.evasivemaneuvers)) {
    _id_0FCFB56E6D8CC156 = location[0];
    _id_0FCFB66E6D8CC389 = location[1];
    _id_F7CD955C75C5D1BF = _id_0FCFB56E6D8CC156 + randomintrange(-500, 500);
    _id_F7CD945C75C5CF8C = _id_0FCFB66E6D8CC389 + randomintrange(-500, 500);
    _id_7504C8791E34DC73 = getcorrectheight(_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, 350);
    _id_6C53D859D582A421 = (_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, _id_7504C8791E34DC73);
  } else {
    _id_0FCFB56E6D8CC156 = location[0];
    _id_0FCFB66E6D8CC389 = location[1];

    if(!isDefined(self.tacopslz))
      _id_7504C8791E34DC73 = getcorrectheight(_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, 20);
    else
      _id_7504C8791E34DC73 = 160;

    _id_6C53D859D582A421 = (_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, _id_7504C8791E34DC73);
  }

  self clearlookatent();
  self setvehgoalpos(_id_6C53D859D582A421 + (0, 0, 500), 10);
  scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");
}

jackalleave(_id_CDDC894CCDF6DE54, _id_AF4A339E05408E87) {
  self endon("death");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self clearlookatent();
  self.turret setsentryowner(undefined);

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline))
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);

  _id_F751B396E9B232E6 = int(self.speed / 14);
  _id_A001268025A19C55 = int(self.accel / 16);

  if(isDefined(_id_CDDC894CCDF6DE54))
    _id_F751B396E9B232E6 = _id_CDDC894CCDF6DE54;

  if(isDefined(_id_AF4A339E05408E87))
    _id_A001268025A19C55 = _id_AF4A339E05408E87;

  self vehicle_setspeed(_id_F751B396E9B232E6, _id_A001268025A19C55);
  pathgoal = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  pathgoal = pathgoal + (0, 0, 1000);
  self setvehgoalpos(pathgoal, 1);

  if(isDefined(self.useobj))
    self.useobj delete();

  self waittill("goal");
  _id_8B79D0E3AD3FB617 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(_id_8B79D0E3AD3FB617, 1);
  self waittill("goal");
  self stoploopsound();
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("jackal_gone");
  thread jackaldelete();
}

jackaldelete() {
  scripts\mp\utility\print::printgameaction("killstreak ended - jackal", self.owner);

  if(isDefined(self.turret))
    self.turret delete();

  if(isDefined(self.cannon))
    self.cannon delete();

  if(isDefined(self.useobj))
    self.useobj delete();

  foreach(loc in level.carepackagedropnodes)
  loc.free = undefined;

  self delete();
}

jackaltimer() {
  self endon("death");
  level endon("game_ended");
  lifetime = 9999;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(lifetime);
  thread jackalleave();
}

watchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread jackalleave();
}

randomjackalmovement() {
  self notify("randomJackalMovement");
  self endon("randomJackalMovement");
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self.lastaction = "randomMovement";
  pos = self.defendloc;
  _id_6C53D859D582A421 = getrandompoint(self.origin);
  self setvehgoalpos(_id_6C53D859D582A421, 1);
  thread scripts\mp\utility\debug::drawline(self.origin, _id_6C53D859D582A421, 5, (1, 0, 1));
  self waittill("goal");
}

getrandompoint(pos) {
  self clearlookatent();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    x = self.owner.origin[0];
    y = self.owner.origin[1];
    z = getcorrectheight(x, y, 20);
    _id_01E2777328B6B536 = (x, y, z);
    self setlookatent(self.owner);
    return _id_01E2777328B6B536;
  } else {
    yaw = self.angles[1];
    yawmin = int(yaw - 60);
    yawmax = int(yaw + 60);
    _id_DEE36AD33D9E9755 = randomintrange(yawmin, yawmax);
    direction = (0, _id_DEE36AD33D9E9755, 0);
    _id_7EBC0C4339BDFD35 = self.origin + anglesToForward(direction) * randomintrange(400, 800);
    _id_BF6A113C5A54166F = _id_7EBC0C4339BDFD35[0];
    _id_BF6A103C5A54143C = _id_7EBC0C4339BDFD35[1];
    _id_B42E60E1AC25640A = getcorrectheight(_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, 20);
    point = tracenewpoint(_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, _id_B42E60E1AC25640A);

    if(point != 0)
      return point;

    _id_BF6A113C5A54166F = randomfloatrange(pos[0] - 1200, pos[0] + 1200);
    _id_BF6A103C5A54143C = randomfloatrange(pos[1] - 1200, pos[1] + 1200);
    _id_1EDD9350013A11A0 = (_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, _id_B42E60E1AC25640A);
    return _id_1EDD9350013A11A0;
  }
}

getnewpoint(pos, _id_B8E70FF71A02E32D) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");

  if(!isDefined(_id_B8E70FF71A02E32D)) {
    return;
  }
  _id_8156649A5A358B7C = [];

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }
    if(!level.teambased || player.team != self.team)
      _id_8156649A5A358B7C[_id_8156649A5A358B7C.size] = player.origin;
  }

  if(_id_8156649A5A358B7C.size > 0) {
    _id_D6669BC3A02D67D4 = averagepoint(_id_8156649A5A358B7C);
    _id_BF6A113C5A54166F = _id_D6669BC3A02D67D4[0];
    _id_BF6A103C5A54143C = _id_D6669BC3A02D67D4[1];
  } else {
    center = level.mapcenter;
    _id_8444F490AB96C6D4 = level.mapsize / 4;
    _id_BF6A113C5A54166F = randomfloatrange(center[0] - _id_8444F490AB96C6D4, center[0] + _id_8444F490AB96C6D4);
    _id_BF6A103C5A54143C = randomfloatrange(center[1] - _id_8444F490AB96C6D4, center[1] + _id_8444F490AB96C6D4);
  }

  _id_B42E60E1AC25640A = getcorrectheight(_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, 20);
  point = tracenewpoint(_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, _id_B42E60E1AC25640A);

  if(point != 0)
    return point;

  _id_BF6A113C5A54166F = randomfloatrange(pos[0] - 1200, pos[0] + 1200);
  _id_BF6A103C5A54143C = randomfloatrange(pos[1] - 1200, pos[1] + 1200);
  _id_B42E60E1AC25640A = getcorrectheight(_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, 20);
  _id_1EDD9350013A11A0 = (_id_BF6A113C5A54166F, _id_BF6A103C5A54143C, _id_B42E60E1AC25640A);
  return _id_1EDD9350013A11A0;
}

getpathstart(_id_6E7C70B904418DAA) {
  _id_CE2E2CFD0619F6CA = 100;
  _id_90783CCFB7B260FB = 15000;
  yaw = randomfloat(360);
  direction = (0, yaw, 0);
  startpoint = _id_6E7C70B904418DAA + anglesToForward(direction) * (-1 * _id_90783CCFB7B260FB);
  startpoint = startpoint + ((randomfloat(2) - 1) * _id_CE2E2CFD0619F6CA, (randomfloat(2) - 1) * _id_CE2E2CFD0619F6CA, 0);
  return startpoint;
}

getpathend() {
  _id_CE2E2CFD0619F6CA = 150;
  _id_90783CCFB7B260FB = 15000;
  yaw = self.angles[1];
  direction = (0, yaw, 0);
  endpoint = self.origin + anglesToForward(direction) * _id_90783CCFB7B260FB;
  return endpoint;
}

fireonturrettarget(_id_8A61C99BBF018323) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_timeout");

  if(istrue(_id_8A61C99BBF018323) && scripts\mp\utility\player::isreallyalive(self.owner) && (!isDefined(self.lastfiretime) || self.lastfiretime + 10000 <= gettime()))
    self.lastfiretime = gettime();

  outline = scripts\mp\utility\outline::outlineenableforplayer(self.turrettarget, self.owner, "outline_depth_orange", "killstreak_personal");
  self.targetoutline = outline;
  timeouttime = 3;
  thread watchforlosttarget(self.turret, self.turrettarget, "target_timeout", timeouttime);
  self.turret waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::saytoself(self.turrettarget, "plr_killstreak_target");
  self.turret notify("start_firing");
  firetime = weaponfiretime(self.turretweapon);

  while(isDefined(self.turrettarget) && scripts\mp\utility\player::isreallyalive(self.turrettarget) && isDefined(self.turret getturrettarget(1)) && self.turret getturrettarget(1) == self.turrettarget) {
    self.turret shootturret();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(firetime);
  }
}

fireoncannontarget(_id_8A61C99BBF018323) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  timeouttime = 3;
  thread watchforlosttarget(self.cannon, self.cannontarget, "target_cannon_timeout", timeouttime);
  self.cannon waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::saytoself(self.cannontarget, "plr_killstreak_target");
  self.cannon notify("start_firing");
  firetime = weaponfiretime(self.cannonweapon);

  if(isDefined(self.cannontarget) && scripts\mp\utility\player::isreallyalive(self.cannontarget) && isDefined(self.cannon getturrettarget(1)) && self.cannon getturrettarget(1) == self.cannontarget) {
    self.cannon thread watchmissilelaunch();
    self.cannon shootturret();
  }
}

watchmissilelaunch() {
  self endon("death");
  self waittill("missile_fire", missile);
  missile.streakinfo = self.streakinfo;
}

setmissilekillcament() {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  self.cannon waittill("missile_fire", missile);
  missile.vehicle_fired_from = self;
  missile.vehicle_fired_from.killcament = self.cannon.vehicle_fired_from.killcament;
}

watchforlosttarget(turret, besttarget, _id_22019A90F96BD145, cooldowntime) {
  self endon("death");
  self endon("leaving");
  turret endon("stop_firing");
  _id_FD5BEC4B454541FF = self.targetoutline;
  result = besttarget scripts\engine\utility::waittill_any_timeout_1(cooldowntime, "death_or_disconnect");

  if(result == "timeout")
    self notify(_id_22019A90F96BD145);

  if(turret.type == "Machine_Gun") {
    if(isDefined(_id_FD5BEC4B454541FF) && isDefined(besttarget))
      scripts\mp\utility\outline::outlinedisable(_id_FD5BEC4B454541FF, besttarget);

    self clearlookatent();
  }

  turret cleartargetentity();
  turret notify("stop_firing");
}

isreadytofire(tolerance) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(tolerance))
    tolerance = 10;

  _id_6AD4CDF6404EB26F = anglesToForward(self.angles);
  _id_6FA7E7954B1F35E7 = self.turrettarget.origin - self.origin;
  _id_6AD4CDF6404EB26F = _id_6AD4CDF6404EB26F * (1, 1, 0);
  _id_6FA7E7954B1F35E7 = _id_6FA7E7954B1F35E7 * (1, 1, 0);
  _id_6FA7E7954B1F35E7 = vectorNormalize(_id_6FA7E7954B1F35E7);
  _id_6AD4CDF6404EB26F = vectorNormalize(_id_6AD4CDF6404EB26F);
  _id_466E87CE09CA407B = vectordot(_id_6FA7E7954B1F35E7, _id_6AD4CDF6404EB26F);
  _id_5762B77F73EDA7C0 = cos(tolerance);

  if(_id_466E87CE09CA407B >= _id_5762B77F73EDA7C0)
    return 1;
  else
    return 0;
}

acquireturrettarget(targets) {
  self endon("death");
  self endon("leaving");
  self notify("priority_target");

  if(isDefined(self.outlinedent) && isDefined(self.turrettarget))
    scripts\mp\utility\outline::outlinedisable(self.outlinedent, self.turrettarget);

  if(targets.size == 1)
    self.turrettarget = targets[0];
  else
    self.turrettarget = getbesttarget(targets);

  if(isDefined(self.turrettarget)) {
    self clearlookatent();
    self setlookatent(self.turrettarget);
    self.turret settargetentity(self.turrettarget);
    self.lastaction = "attackTarget";
    thread fireonturrettarget(1);
  }
}

acquirecannontarget(targets) {
  self endon("death");
  self endon("leaving");
  self.cannontarget = getbesttarget(targets);

  if(isDefined(self.cannontarget)) {
    self.cannon settargetentity(self.cannontarget);
    thread fireoncannontarget(0);
  }
}

jackalgettargets() {
  self endon("death");
  self endon("leaving");
  targets = [];
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    _id_BD73C7ACC56CD20C = players[_id_AC0E594AC96AA3A8];

    if(istarget(_id_BD73C7ACC56CD20C)) {
      if(isDefined(players[_id_AC0E594AC96AA3A8]))
        targets[targets.size] = players[_id_AC0E594AC96AA3A8];
    } else
      continue;

    wait 0.05;
  }

  return targets;
}

istarget(_id_BD73C7ACC56CD20C) {
  self endon("death");

  if(!isalive(_id_BD73C7ACC56CD20C) || _id_BD73C7ACC56CD20C.sessionstate != "playing")
    return 0;

  if(isDefined(self.owner) && _id_BD73C7ACC56CD20C == self.owner)
    return 0;

  if(!isDefined(_id_BD73C7ACC56CD20C.pers["team"]))
    return 0;

  if(level.teambased && _id_BD73C7ACC56CD20C.pers["team"] == self.team)
    return 0;

  if(_id_BD73C7ACC56CD20C.pers["team"] == "spectator")
    return 0;

  if(isDefined(_id_BD73C7ACC56CD20C.spawntime) && (gettime() - _id_BD73C7ACC56CD20C.spawntime) / 1000 <= 5)
    return 0;

  if(_id_BD73C7ACC56CD20C scripts\mp\utility\perk::_hasperk("specialty_blindeye"))
    return 0;

  if(distance2dsquared(self.origin, _id_BD73C7ACC56CD20C.origin) > 4194304)
    return 0;

  offset = (0, 0, 35);
  endpoint = _id_BD73C7ACC56CD20C.origin + rotatevector(offset, _id_BD73C7ACC56CD20C getworldupreferenceangles());
  ignorelist = [self];
  _id_D740D9B67690A550 = scripts\engine\trace::ray_trace(self.origin, endpoint, ignorelist, undefined, 1);

  if(!isDefined(_id_D740D9B67690A550["entity"]))
    return 0;

  return 1;
}

getbesttarget(targets) {
  self endon("death");
  _id_88C2B48BA3714B8E = undefined;
  besttarget = undefined;

  foreach(_id_B8E70FF71A02E32D in targets) {
    if(isDefined(self.turrettarget) && self.turrettarget == _id_B8E70FF71A02E32D) {
      continue;
    }
    angle = abs(vectortoangles(_id_B8E70FF71A02E32D.origin - self.origin)[1]);
    _id_A6F54781E7E6CB25 = abs(self gettagangles("tag_origin")[1]);
    angle = abs(angle - _id_A6F54781E7E6CB25);
    _id_D6E9347C3618A5BB = _id_B8E70FF71A02E32D getweaponslistitems();

    foreach(weapon in _id_D6E9347C3618A5BB) {
      weaponname = weapon.basename;

      if(issubstr(weaponname, "chargeshot") || issubstr(weaponname, "lockon"))
        angle = angle - 40;
    }

    if(distance(self.origin, _id_B8E70FF71A02E32D.origin) > 4000)
      angle = angle + 40;

    if(!isDefined(_id_88C2B48BA3714B8E)) {
      _id_88C2B48BA3714B8E = angle;
      besttarget = _id_B8E70FF71A02E32D;
      continue;
    }

    if(_id_88C2B48BA3714B8E > angle) {
      _id_88C2B48BA3714B8E = angle;
      besttarget = _id_B8E70FF71A02E32D;
    }
  }

  return besttarget;
}

handledestroydamage() {
  self endon("death");

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = scripts\mp\utility\weapon::mapweapon(objweapon, inflictor);

    if((objweapon.basename == "aamissile_projectile_mp" || objweapon.basename == "nuke_mp") && meansofdeath == "MOD_EXPLOSIVE" && damage >= self.health)
      callback_vehicledamage(attacker, attacker, 9001, 0, meansofdeath, objweapon, point, direction_vec, point, 0, 0, partname);
  }
}

callback_vehicledamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner))
      attacker = attacker.owner;
  }

  if((attacker == self || isDefined(attacker.pers) && attacker.pers["team"] == self.team && !level.friendlyfire && level.teambased) && attacker != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  damage = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(attacker, objweapon, self, meansofdeath, damage);
  attacker _id_5762AC2F22202BA2::updatedamagefeedback("");
  scripts\mp\damage::logattackerkillstreak(self, damage, attacker, dir, point, meansofdeath, modelindex, undefined, partname, _id_44E290FB31B85206, getcompleteweaponname(objweapon));

  if(self.health <= damage) {
    if(isPlayer(attacker) && (!isDefined(self.owner) || attacker != self.owner))
      scripts\mp\damage::onkillstreakkilled("jackal", attacker, objweapon, meansofdeath, damage, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier");
  }

  if(self.health - damage <= 900 && (!isDefined(self.smoking) || !self.smoking))
    self.smoking = 1;

  self vehicle_finishdamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

getcorrectheight(x, y, _id_00AE14C5A8B1B582) {
  _id_DC8BB6300463CF1E = 600;
  _id_E7A7D619F927D791 = tracegroundpoint(x, y);
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  _id_1DC672CFE0F0128E = _id_1DC672CFE0F0128E + randomint(_id_00AE14C5A8B1B582);
  return _id_1DC672CFE0F0128E;
}

playdamageefx() {
  self endon("death");
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_left");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_left");
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_right");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_right");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.15);
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_left2");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_left2");
  stopFXOnTag(level.harrier_afterburnerfx, self, "tag_engine_right2");
  playFXOnTag(level.harrier_smoke, self, "tag_engine_right2");
  playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_engine_left");
}

jackaldestroyed() {
  self endon("jackal_gone");
  owner = self.owner;
  self waittill("death");

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline))
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);

  if(!isDefined(self)) {
    return;
  }
  self.owner scripts\mp\utility\lower_message::clearlowermessage(getothermode(self.combatmode));

  if(!isDefined(self.largeprojectiledamage)) {
    self vehicle_setspeed(25, 5);
    thread jackalcrash(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  if(isDefined(self.lz))
    self.lz notify("extraction_destroyed");

  jackalexplode();
}

jackalexplode() {
  self playSound("dropship_explode_mp");
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("explode");

  if(isDefined(self.lz))
    playFXOnTag(scripts\engine\utility::getfx("jackal_explosion"), self, "tag_origin");

  wait 0.35;
  thread jackaldelete();
}

jackalcrash(speed) {
  self endon("explode");
  self clearlookatent();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(speed, speed, speed);
  self settargetyaw(self.angles[1] + speed * 2.5);
}

tracenewpoint(x, y, z) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");
  _id_E96577032A7740FC = scripts\engine\trace::sphere_trace(self.origin, (x, y, z), 256, self, undefined, 1);

  if(_id_E96577032A7740FC["surfacetype"] != "surftype_none")
    return 0;

  pathgoal = (x, y, z);
  return pathgoal;
}

tracegroundpoint(x, y) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  z = -99999;
  _id_E531AFBE1391F499 = self.origin[2] + 2000;
  _id_3C590B0EE220AFA3 = level.averagealliesz;
  ignorelist = [self];

  if(isDefined(self.dropcrates)) {
    foreach(crate in self.dropcrates)
    ignorelist[ignorelist.size] = crate;
  }

  _id_E96577032A7740FC = scripts\engine\trace::sphere_trace((x, y, _id_E531AFBE1391F499), (x, y, z), 256, ignorelist, undefined, 1);

  if(_id_E96577032A7740FC["position"][2] < _id_3C590B0EE220AFA3)
    _id_0FA83E3A4C4E6902 = _id_3C590B0EE220AFA3;
  else
    _id_0FA83E3A4C4E6902 = _id_E96577032A7740FC["position"][2];

  return _id_0FA83E3A4C4E6902;
}

closetogoalcheck(pathgoal) {
  self endon("goal");
  self endon("death");

  for(;;) {
    if(distance2d(self.origin, pathgoal) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

monitorowner() {
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread jackalexplode();
    return;
  }

  self.owner scripts\engine\utility::waittill_any_2("joined_team", "disconnect");
  jackalexplode();
}

watchmodechange(_id_531859A10696FC85, _id_0AFDB365AC9503B7) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  _id_038FC7BD1495C4B2 = level.framedurationseconds;

  for(;;) {
    self.useobj waittill("trigger", player);

    if(player != self.owner) {
      continue;
    }
    if(self.owner scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    if(!self.owner _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("usability")) {
      continue;
    }
    if(scripts\mp\utility\entity::istouchingboundstrigger(self.owner)) {
      continue;
    }
    _id_23B90B34FECC58CD = 0;

    while(self.owner useButtonPressed()) {
      _id_23B90B34FECC58CD = _id_23B90B34FECC58CD + _id_038FC7BD1495C4B2;

      if(_id_23B90B34FECC58CD > 0.1) {
        _id_FF788554F45F9D12 = getothermode(self.combatmode);

        if(_id_FF788554F45F9D12 == "guard_location") {
          _id_52A499A16497488C = self.owner.origin[0];
          _id_52A49AA164974ABF = self.owner.origin[1];
          _id_3AD8C1EE301E4523 = self.origin[2];
          _id_6C53D859D582A421 = (_id_52A499A16497488C, _id_52A49AA164974ABF, _id_3AD8C1EE301E4523);
          contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);

          if(!scripts\engine\trace::ray_trace_passed(self.origin, _id_6C53D859D582A421, self, contents)) {
            self.owner scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_CALLED");
            break;
          }
        }

        self.combatmode = _id_FF788554F45F9D12;
        self notify(self.combatmode);

        if(self.combatmode == "guard_location") {
          _id_531859A10696FC85 = "follow_player";
          _id_0AFDB365AC9503B7 = &"KILLSTREAKS_HINTS_JACKAL_FOLLOW";
          thread dropship_change_thrust_sfx();
          thread guardposition();
        } else {
          _id_531859A10696FC85 = "guard_location";
          _id_0AFDB365AC9503B7 = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
          thread patrolfield();
          thread dropship_change_thrust_sfx();
        }

        self.useobj makeunusable();
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
        self.currentstring = _id_0AFDB365AC9503B7;
        self.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(self.owner, self.currentstring, 360, 360, 30000, 30000, 2);
        break;
      }

      wait(_id_038FC7BD1495C4B2);
    }

    wait(_id_038FC7BD1495C4B2);
  }
}

dropship_change_thrust_sfx() {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  self playsoundonmovingent("dropship_killstreak_thrust_change");
}

getothermode(mode) {
  if(mode == "follow_player")
    mode = "guard_location";
  else
    mode = "follow_player";

  return mode;
}

looptriggeredeffect(effect, missile) {
  level endon("game_ended");

  for(;;) {
    triggerfx(effect);
    wait 0.05;

    if(!isDefined(missile) || !isDefined(effect)) {
      break;
    }
  }

  if(isDefined(effect))
    effect delete();
}

attacklasedtarget(_id_726FA5D13E90F8F9, _id_FACF9F5A4B563C03) {
  _id_60A448DF9C59A413 = undefined;
  _id_12EE62362C758131 = undefined;
  _id_73789545E7E2F109 = 6000;
  _id_2CF4A7DBEF8201F3 = (0, 0, _id_73789545E7E2F109);
  _id_1124265EE011BB02 = 3000;
  forward = anglesToForward(self.angles);
  _id_673145AE1316069A = self.origin;
  startpos = _id_673145AE1316069A + _id_2CF4A7DBEF8201F3 + forward * _id_1124265EE011BB02 * -1;
  ignorelist = [self];
  _id_2A224218E7468E4A = 0;
  _id_BF701DC10DE6A877 = scripts\engine\trace::ray_trace(_id_726FA5D13E90F8F9 + (0, 0, _id_73789545E7E2F109), _id_726FA5D13E90F8F9);

  if(_id_BF701DC10DE6A877["fraction"] > 0.99) {
    _id_2A224218E7468E4A = 1;
    startpos = _id_726FA5D13E90F8F9 + (0, 0, _id_73789545E7E2F109);
  }

  if(!_id_2A224218E7468E4A) {
    _id_BF701DC10DE6A877 = scripts\engine\trace::ray_trace(_id_726FA5D13E90F8F9 + (300, 0, _id_73789545E7E2F109), _id_726FA5D13E90F8F9);

    if(_id_BF701DC10DE6A877["fraction"] > 0.99) {
      _id_2A224218E7468E4A = 1;
      startpos = _id_726FA5D13E90F8F9 + (300, 0, _id_73789545E7E2F109);
    }
  }

  if(!_id_2A224218E7468E4A) {
    _id_BF701DC10DE6A877 = scripts\engine\trace::ray_trace(_id_726FA5D13E90F8F9 + (0, 300, _id_73789545E7E2F109), _id_726FA5D13E90F8F9);

    if(_id_BF701DC10DE6A877["fraction"] > 0.99) {
      _id_2A224218E7468E4A = 1;
      startpos = _id_726FA5D13E90F8F9 + (0, 300, _id_73789545E7E2F109);
    }
  }

  if(!_id_2A224218E7468E4A) {
    _id_BF701DC10DE6A877 = scripts\engine\trace::ray_trace(_id_726FA5D13E90F8F9 + (0, -300, _id_73789545E7E2F109), _id_726FA5D13E90F8F9);

    if(_id_BF701DC10DE6A877["fraction"] > 0.99) {
      _id_2A224218E7468E4A = 1;
      startpos = _id_726FA5D13E90F8F9 + (0, -300, _id_73789545E7E2F109);
    }
  }

  if(!_id_2A224218E7468E4A) {
    _id_BF701DC10DE6A877 = scripts\engine\trace::ray_trace(_id_726FA5D13E90F8F9 + (300, 300, _id_73789545E7E2F109), _id_726FA5D13E90F8F9);

    if(_id_BF701DC10DE6A877["fraction"] > 0.99) {
      _id_2A224218E7468E4A = 1;
      startpos = _id_726FA5D13E90F8F9 + (300, 300, _id_73789545E7E2F109);
    }
  }

  if(!_id_2A224218E7468E4A) {
    _id_BF701DC10DE6A877 = scripts\engine\trace::ray_trace(_id_726FA5D13E90F8F9 + (-300, 0, _id_73789545E7E2F109), _id_726FA5D13E90F8F9);

    if(_id_BF701DC10DE6A877["fraction"] > 0.99) {
      _id_2A224218E7468E4A = 1;
      startpos = _id_726FA5D13E90F8F9 + (-300, 0, _id_73789545E7E2F109);
    }
  }

  if(!_id_2A224218E7468E4A) {
    _id_BF701DC10DE6A877 = scripts\engine\trace::ray_trace(_id_726FA5D13E90F8F9 + (-300, -300, _id_73789545E7E2F109), _id_726FA5D13E90F8F9);

    if(_id_BF701DC10DE6A877["fraction"] > 0.99) {
      _id_2A224218E7468E4A = 1;
      startpos = _id_726FA5D13E90F8F9 + (-300, -300, _id_73789545E7E2F109);
    }
  }

  if(!_id_2A224218E7468E4A) {
    _id_BF701DC10DE6A877 = scripts\engine\trace::ray_trace(_id_726FA5D13E90F8F9 + (300, -300, _id_73789545E7E2F109), _id_726FA5D13E90F8F9);

    if(_id_BF701DC10DE6A877["fraction"] > 0.99) {
      _id_2A224218E7468E4A = 1;
      startpos = _id_726FA5D13E90F8F9 + (300, -300, _id_73789545E7E2F109);
    }
  }

  if(!_id_2A224218E7468E4A) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
      _id_73789545E7E2F109 = _id_73789545E7E2F109 / 2;
      _id_2CF4A7DBEF8201F3 = (0, 0, _id_73789545E7E2F109);
      startpos = _id_673145AE1316069A + _id_2CF4A7DBEF8201F3 + forward * _id_1124265EE011BB02 * -1;
      _id_981DE761DFBB8F8B = scripts\engine\trace::ray_trace(_id_726FA5D13E90F8F9, startpos, ignorelist);

      if(_id_981DE761DFBB8F8B["fraction"] > 0.99) {
        _id_2A224218E7468E4A = 1;
        break;
      }

      wait 0.05;
    }
  }

  if(!_id_2A224218E7468E4A) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
      _id_73789545E7E2F109 = _id_73789545E7E2F109 * 2.5;
      _id_2CF4A7DBEF8201F3 = (0, 0, _id_73789545E7E2F109);
      startpos = _id_673145AE1316069A + _id_2CF4A7DBEF8201F3 + forward * _id_1124265EE011BB02 * -1;
      _id_981DE761DFBB8F8B = scripts\engine\trace::ray_trace(_id_726FA5D13E90F8F9, startpos, ignorelist);

      if(_id_981DE761DFBB8F8B["fraction"] > 0.99) {
        _id_2A224218E7468E4A = 1;
        break;
      }

      wait 0.05;
    }
  }
}

playlocksound() {
  if(isDefined(self.playinglocksound) && self.playinglocksound) {
    return;
  }
  scripts\engine\utility::play_loopsound_in_space("javelin_clu_lock", self.origin);
  self.playinglocksound = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.75);
  self stoploopsound("javelin_clu_lock");
  self.playinglocksound = 0;
}

playlockerrorsound() {
  if(isDefined(self.playinglocksound) && self.playinglocksound) {
    return;
  }
  self playlocalsound("javelin_clu_aquiring_lock");
  self.playinglocksound = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.75);
  self stoplocalsound("javelin_clu_aquiring_lock");
  self.playinglocksound = 0;
}

beginevasivemaneuvers() {
  self endon("death");
  self notify("begin_evasive_maneuvers");
  self endon("begin_evasive_maneuvers");
  self.evasivemaneuvers = 1;
  result = scripts\engine\utility::waittill_any_timeout_1(3.0, "death");

  if(result == "timeout")
    self.evasivemaneuvers = 0;
}

watchguardevadedamage() {
  self endon("death");
  self endon("leaving");
  self endon("following_player");

  for(;;) {
    _id_6C53D859D582A421 = undefined;

    if(istrue(self.evasivemaneuvers)) {
      _id_52A499A16497488C = self.owner.origin[0];
      _id_52A49AA164974ABF = self.owner.origin[1];
      _id_F7CD955C75C5D1BF = _id_52A499A16497488C + randomintrange(-500, 500);
      _id_F7CD945C75C5CF8C = _id_52A49AA164974ABF + randomintrange(-500, 500);
      _id_7504C8791E34DC73 = getcorrectheight(_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, 350);
      _id_6C53D859D582A421 = (_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, _id_7504C8791E34DC73);
    }

    if(isDefined(_id_6C53D859D582A421))
      self setvehgoalpos(_id_6C53D859D582A421, 1);

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

watchdropcratesearly(marker) {
  self endon("dropped_crates");
  _id_2E0D8BA0A46CE1B1 = self.dropcrates;
  self waittill("death");
  thread dropcrates(_id_2E0D8BA0A46CE1B1, marker);
}

dropcrates(_id_2E0D8BA0A46CE1B1, marker) {
  self notify("dropped_crates");
}

watchforcapture(jackal, index) {
  scripts\engine\utility::waittill_any_2("captured", "death");
  jackal notify("crate_captured_" + index);
}

watchjackalcratepickup() {
  self endon("death");
  self endon("leaving");
  _id_D6D0DD717FDCE328 = 0;

  for(;;) {
    scripts\engine\utility::waittill_any_3("crate_captured_0", "crate_captured_1", "crate_captured_2");
    _id_D6D0DD717FDCE328++;

    if(_id_D6D0DD717FDCE328 == self.dropcrates.size) {
      self notify("all_crates_gone");
      break;
    }
  }
}

beginjackalescort(lifeid, startpoint, pos, streakinfo, tacopslz, _id_FAE759765E65830A) {
  if(!isDefined(level.jackals))
    level.jackals = [];

  marker = undefined;
  self notify("called_in_jackal");
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  pos = pos * (1, 1, 0);
  _id_1DC672CFE0F0128E = 1000;
  pathgoal = pos + (0, 0, _id_1DC672CFE0F0128E);
  jackal = spawnksjackal(lifeid, self, startpoint, pathgoal, streakinfo, tacopslz);
  jackal.pathgoal = pathgoal;
  thread defendlocationescort(jackal, marker);
  return jackal;
}

defendlocationescort(jackal, marker) {
  jackal endon("death");
  jackal setvehgoalpos(jackal.pathgoal, 1);
  jackal playsoundonmovingent("dropship_killstreak_thrust_change");
  jackal thread closetogoalcheck(jackal.pathgoal);
  jackal thread monitorowner();
  jackal waittill("goal");
  jackal thread watchgameendleave();
  jackal thread engageprimarytarget();
  jackal thread engagesecondarytarget();
  jackal vehicle_setspeed(int(jackal.speed / 14), int(jackal.accel / 16));
}

guardpositionescort(position, _id_9523E27B0F4FE3AF, _id_DC8BB6300463CF1E) {
  self endon("death");
  self endon("leaving");
  self endon("follow_player");
  self endon("jackal_crashing");

  if(isDefined(self.owner))
    self.owner endon("disconnect");

  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));

  if(isDefined(_id_9523E27B0F4FE3AF))
    self setlookatent(_id_9523E27B0F4FE3AF);

  if(isDefined(position)) {
    _id_6C53D859D582A421 = undefined;
    _id_52A499A16497488C = position[0];
    _id_52A49AA164974ABF = position[1];

    if(istrue(self.evasivemaneuvers)) {
      _id_F7CD955C75C5D1BF = _id_52A499A16497488C + randomintrange(-500, 500);
      _id_F7CD945C75C5CF8C = _id_52A49AA164974ABF + randomintrange(-500, 500);
      _id_7504C8791E34DC73 = getcorrectheightescort(_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, 350, _id_DC8BB6300463CF1E);
      _id_6C53D859D582A421 = (_id_F7CD955C75C5D1BF, _id_F7CD945C75C5CF8C, _id_7504C8791E34DC73);
    } else {
      _id_7504C8791E34DC73 = getcorrectheightescort(_id_52A499A16497488C, _id_52A49AA164974ABF, 20, _id_DC8BB6300463CF1E);
      _id_6C53D859D582A421 = (_id_52A499A16497488C, _id_52A49AA164974ABF, _id_7504C8791E34DC73);
    }

    self setvehgoalpos(_id_6C53D859D582A421, 1);
    self.lastaction = "following_player";
    scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");
    self clearlookatent();
  }
}

getcorrectheightescort(x, y, _id_00AE14C5A8B1B582, _id_F3F4EB55AED6E784) {
  _id_DC8BB6300463CF1E = 200;

  if(isDefined(_id_F3F4EB55AED6E784))
    _id_DC8BB6300463CF1E = _id_F3F4EB55AED6E784;

  _id_E7A7D619F927D791 = tracegroundpoint(x, y);
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  _id_1DC672CFE0F0128E = _id_1DC672CFE0F0128E + randomint(_id_00AE14C5A8B1B582);
  return _id_1DC672CFE0F0128E;
}