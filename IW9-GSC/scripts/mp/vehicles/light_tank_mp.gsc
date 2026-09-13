/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\light_tank_mp.gsc
*************************************************/

light_tank_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "activate", ::light_tank_mp_activate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "startCapture", ::light_tank_mp_startcapture);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "endCapture", ::light_tank_mp_endcapture);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "filterDropSpawns", ::light_tank_mp_filterdropspawns);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "getDropSpawnIgnoreList", ::light_tank_mp_getdropspawnignorelist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "spawn", ::light_tank_mp_spawncallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "initLate", ::light_tank_mp_initlate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "onDeathRespawn", ::light_tank_mp_ondeathrespawncallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_limitgameinstances("light_tank", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_limitteaminstances("light_tank", 3);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "updateHeadIconForPlayerOnJoinTeam"));
  light_tank_mp_initspawning();
  light_tank_mp_initcapture();
}

light_tank_mp_initlate() {}

light_tank_mp_initspawning() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("light_tank");
  _id_E2818AD39A3341B4.abandonedtimeoutcallback = scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "timeOut");

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "risk") {
    _id_E2818AD39A3341B4.abandonedtimeoutdelay = 105;
    _id_E2818AD39A3341B4.respawndelay = level.tankrespawntime;
  } else
    _id_E2818AD39A3341B4.abandonedtimeoutdelay = 40;
}

light_tank_mp_initcapture() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("vehicleCapture", ["offhand_weapons", "weapon", "killstreaks", "supers"]);
}

light_tank_mp_activate(vehicle) {
  vehicle thread bctracking();
  scripts\mp\outofbounds::registerentforoob(vehicle, "vehicle");
}

light_tank_mp_startcapture(vehicle, owner, team) {
  if(isDefined(owner))
    light_tank_mp_createownercaptureobject(vehicle, owner);

  if(level.teambased)
    light_tank_mp_createothercaptureobject(vehicle);
}

light_tank_mp_endcapture(vehicle) {
  vehicle light_tank_mp_deletecaptureobjects();
}

light_tank_mp_createownercaptureobject(vehicle, owner) {
  _id_D18E18E423FC0C22 = spawn("script_model", vehicle gettagorigin("TAG_PLAYER"));
  _id_D18E18E423FC0C22 linkTo(vehicle);
  _id_D18E18E423FC0C22 light_tank_mp_setupcaptureobject(0.5);
  _id_D18E18E423FC0C22.vehicle = vehicle;
  vehicle.ownercaptureobject = _id_D18E18E423FC0C22;
  _id_D18E18E423FC0C22 thread light_tank_mp_monitorownercapture(owner, vehicle);
  _id_D18E18E423FC0C22 thread light_tank_mp_monitorownercapturevisibility(owner);
  return _id_D18E18E423FC0C22;
}

light_tank_mp_createothercaptureobject(vehicle) {
  _id_D18E18E423FC0C22 = spawn("script_model", vehicle gettagorigin("TAG_PLAYER"));
  _id_D18E18E423FC0C22 linkTo(vehicle);
  _id_D18E18E423FC0C22 light_tank_mp_setupcaptureobject(3);
  _id_D18E18E423FC0C22.vehicle = vehicle;
  vehicle.othercaptureobject = _id_D18E18E423FC0C22;
  _id_D18E18E423FC0C22 thread light_tank_mp_monitorothercapture(vehicle);
  _id_D18E18E423FC0C22 thread light_tank_mp_monitorothercapturevisibility();
  return _id_D18E18E423FC0C22;
}

light_tank_mp_setupcaptureobject(usetime) {
  self makeusable();
  self setCursorHint("HINT_BUTTON");

  if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    self setHintString(&"KILLSTREAKS_HINTS/BRADLEY_CAPTURE");

  self sethinttag("none");
  self sethintdisplayrange(200);
  self sethintdisplayfov(360);
  self setuserange(200);
  self setusefov(360);
  self sethintonobstruction("show");
  self setuseholdduration("duration_none");
  self setusehideprogressbar(1);
  self.userate = 1;
  self.curprogress = 0;
  self.usetime = usetime;
  self.inuse = 0;
  self.playerusing = undefined;
  self.id = "care_package";
}

light_tank_mp_deletecaptureobject() {
  if(isDefined(self.playerusing))
    light_tank_mp_playerstopcapture(self.playerusing);

  self delete();
}

light_tank_mp_deletecaptureobjects() {
  if(isDefined(self.ownercaptureobject))
    self.ownercaptureobject light_tank_mp_deletecaptureobject();

  if(isDefined(self.othercaptureobject))
    self.othercaptureobject light_tank_mp_deletecaptureobject();
}

light_tank_mp_monitorownercapture(owner, vehicle) {
  self endon("death");
  owner endon("disconnect");
  self.vehicle = vehicle;

  for(;;) {
    self waittillmatch("trigger", owner);

    if(light_tank_mp_canstartcapture(owner)) {
      self.playerusing = owner;
      self.inuse = 1;
      light_tank_mp_playerstartcapture(owner);
      _id_6DFAEE5EE2B3FA4B = light_tank_mp_monitorcaptureinternal();
      self.playerusing = undefined;
      self.curprogress = 0;
      self.inuse = 0;
      light_tank_mp_playerstopcapture(owner);

      if(istrue(_id_6DFAEE5EE2B3FA4B) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "capture"))
        thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "capture")]](vehicle, owner);

      waitframe();
    }
  }
}

light_tank_mp_monitorothercapture(vehicle) {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(light_tank_mp_canstartcapture(player)) {
      self.playerusing = player;
      self.inuse = 1;
      light_tank_mp_playerstartcapture(player);
      _id_6DFAEE5EE2B3FA4B = light_tank_mp_monitorcaptureinternal();
      self.playerusing = undefined;
      self.curprogress = 0;
      self.inuse = 0;

      if(isDefined(player))
        light_tank_mp_playerstopcapture(player);

      if(istrue(_id_6DFAEE5EE2B3FA4B) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "capture"))
        thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "capture")]](vehicle, player);

      waitframe();
    }
  }
}

light_tank_mp_monitorcaptureinternal() {
  self.playerusing endon("death_or_disconnect");

  while(light_tank_mp_cankeepcapturing()) {
    self.curprogress = self.curprogress + level.framedurationseconds * self.userate;

    if(self.curprogress >= self.usetime)
      return 1;

    self.playerusing scripts\mp\gameobjects::updateuiprogress(self, 1);
    waitframe();
  }
}

light_tank_mp_monitorownercapturevisibility(owner) {
  self endon("death");

  while(isDefined(owner)) {
    foreach(player in level.players) {
      self disableplayeruse(player);

      if(player == owner) {
        if(isDefined(self.playerusing)) {
          if(light_tank_mp_cankeepcapturing())
            self enableplayeruse(owner);

          continue;
        }

        if(light_tank_mp_canstartcapture(owner))
          self enableplayeruse(owner);
      }
    }

    wait 0.1;
  }

  thread light_tank_mp_deletecaptureobject();
}

light_tank_mp_monitorothercapturevisibility() {
  self endon("death");

  for(;;) {
    if(isDefined(self.playerusing)) {
      foreach(player in level.players) {
        self disableplayeruse(player);

        if(player == self.playerusing) {
          if(light_tank_mp_cankeepcapturing())
            self enableplayeruse(player);
        }
      }
    } else {
      foreach(player in level.players) {
        self disableplayeruse(player);

        if(light_tank_mp_canstartcapture(player))
          self enableplayeruse(player);
      }
    }

    wait 0.1;
  }
}

light_tank_mp_canstartcapture(player) {
  if(istrue(self.vehicle.isdestroyed))
    return 0;

  if(!isDefined(player))
    return 0;

  if(!player scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(player.team == "spectator")
    return 0;

  if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("vehicle_use"))
    return 0;

  if(!istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_playercanusevehicle(player, self.vehicle)))
    return 0;

  return 1;
}

light_tank_mp_cankeepcapturing() {
  if(istrue(self.vehicle.isdestroyed))
    return 0;

  if(!self.playerusing _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("vehicle_use"))
    return 0;

  if(!istrue(scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_playercanusevehicle(self.playerusing, self.vehicle)))
    return 0;

  if(!self.playerusing useButtonPressed())
    return 0;

  if(self.playerusing isonladder())
    return 0;

  if(self.playerusing meleeButtonPressed())
    return 0;

  if(distancesquared(self.playerusing.origin, self.origin) > 90000)
    return 0;

  return 1;
}

light_tank_mp_playerstartcapture(player) {
  player _id_3B64EB40368C1450::_id_3633B947164BE4F3("vehicleCapture", 0);
  player scripts\mp\gameobjects::updateuiprogress(self, 0);
}

light_tank_mp_playerstopcapture(player) {
  if(player scripts\cp_mp\utility\player_utility::_isalive())
    player _id_3B64EB40368C1450::_id_588F2307A3040610("vehicleCapture");

  player scripts\mp\gameobjects::updateuiprogress(self, 0);
}

light_tank_mp_shouldawardattacker(vehicle, attacker) {
  if(!isDefined(attacker))
    return 0;

  if(level.teambased && attacker.team == vehicle.team)
    return 0;

  if(isDefined(vehicle.owner) && attacker == vehicle.owner)
    return 0;

  return 1;
}

bctracking() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(scripts\mp\utility\teams::isgameplayteam(self.team)) {
      _id_EF269077A28646EB = scripts\common\utility::playersinsphere(self.origin, 3000);

      foreach(player in _id_EF269077A28646EB) {
        validplayer = isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive() && scripts\cp_mp\utility\player_utility::isenemy(player);

        if(!validplayer) {
          continue;
        }
        _id_ED24AF7CF5CDC3DD = anglesToForward(player getplayerangles());
        _id_E402C093911C20EE = scripts\engine\math::anglebetweenvectors(_id_ED24AF7CF5CDC3DD, self.origin - player.origin);

        if(isDefined(_id_E402C093911C20EE) && _id_E402C093911C20EE <= 60) {
          if(self sightconetrace(player getEye(), self) > 0.1) {}

          waitframe();
        }
      }
    }

    wait 0.1;
  }
}

light_tank_mp_spawncallback(spawndata, _id_EE8DA5624236DC89) {
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "initSpawnData")]](spawndata);

  if(!isDefined(spawndata.spawnmethod))
    spawndata.spawnmethod = "place_at_position_unsafe";

  if(!isDefined(spawndata.showheadicon))
    spawndata.showheadicon = 0;

  spawndata.cantimeout = 0;
  vehicle = [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "tankSpawn")]](spawndata, _id_EE8DA5624236DC89);
  return vehicle;
}

light_tank_mp_ondeathrespawncallback() {
  thread light_tank_mp_waitandspawn();
}

light_tank_mp_waitandspawn() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1("light_tank")) {
    return;
  }
  _id_575EF651FFAB4369 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(_id_575EF651FFAB4369._id_6DC04302DA1A9D03))
    _id_575EF651FFAB4369 = _id_575EF651FFAB4369._id_6DC04302DA1A9D03;

  spawndata = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(_id_575EF651FFAB4369, spawndata);
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "copySpawnData")]](_id_575EF651FFAB4369, spawndata);
  _id_EE8DA5624236DC89 = spawnStruct();
  vehicle = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_waitandrespawn("light_tank", spawndata, _id_EE8DA5624236DC89);

  if(isDefined(vehicle)) {
    if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "risk") {
      if(scripts\mp\flags::gameflag("prematch_done"))
        _id_27C2DB69A21775A0::droptank_playincomingdialog(spawndata);

      foreach(player in level.players) {
        if(player.team == vehicle.team)
          player scripts\mp\utility\lower_message::setlowermessageomnvar("gw_iav_respawn", undefined, 5);
      }
    }
  }
}

light_tank_mp_filterdropspawns(dropspawns) {
  _id_30492E606AC5CCFF = dropspawns;

  if(isDefined(level.vehspawnvol)) {
    _id_30492E606AC5CCFF = [];

    foreach(dropspawn in dropspawns) {
      if(ispointinvolume(dropspawn.origin, level.vehspawnvol))
        _id_30492E606AC5CCFF[_id_30492E606AC5CCFF.size] = dropspawn;
    }
  }

  return _id_30492E606AC5CCFF;
}

light_tank_mp_getdropspawnignorelist(ignorelist) {
  _id_8496E2572C67CB8C = [];
  _id_8496E2572C67CB8C[_id_8496E2572C67CB8C.size] = ignorelist;

  if(isDefined(level.helis))
    _id_8496E2572C67CB8C[_id_8496E2572C67CB8C.size] = level.helis;

  if(isDefined(level.littlebirds))
    _id_8496E2572C67CB8C[_id_8496E2572C67CB8C.size] = level.littlebirds;

  if(isDefined(level.supportdrones))
    _id_8496E2572C67CB8C[_id_8496E2572C67CB8C.size] = level.supportdrones;

  _id_8496E2572C67CB8C[_id_8496E2572C67CB8C.size] = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("emp_drone");
  _id_8496E2572C67CB8C[_id_8496E2572C67CB8C.size] = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("cruise_predator");
  return scripts\engine\utility::array_combine_multiple(_id_8496E2572C67CB8C);
}