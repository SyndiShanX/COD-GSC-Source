/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_airdrop.gsc
****************************************************/

init() {
  if(getdvarint("4017", 0) || _func_367()) {
    return;
  }
  setairdropcratecollision("care_package");
  level.cratetypes = [];
  _id_09F1();
  _id_401A();
}

_id_09F1() {
  _id_09F0("uav", 120, "support", &"MP_UAV_PICKUP");
  _id_09F0("counter_uav", 110, "support", &"MP_COUNTER_UAV_PICKUP");
  _id_09F0("fritzx", 100, "missile", &"MP_FRITZX_PICKUP");
  _id_09F0("mortar_strike", 90, "missile", &"MP_MORTAR_STRIKE_PICKUP");
  _id_09F0("flak_gun", 85, "support", &"MP_FLAK_GUN_PICKUP");
  _id_09F0("flamethrower", 85, "support", &"MP_FLAMETHROWER_PICKUP");
  _id_09F0("missile_strike", 80, "missile", &"MP_MISSILE_STRIKE_PICKUP");
  _id_09F0("airstrike", 75, "plane", &"MP_AIRSTRIKE_PICKUP");
  _id_09F0("firebomb", 70, "plane", &"MP_FIREBOMB_PICKUP");
  _id_09F0("attack_dogs", 50, "plane", &"MP_DOGS_PICKUP");
  _id_09F0("fighter_strike", 40, "plane", &"MP_FIGHTER_STRIKE_PICKUP");
  _id_09F0("plane_gunner", 20, "plane", &"MP_PLANE_GUNNER_PICKUP");
}

_id_401A() {
  level._id_274B["all"] = 0;

  foreach(var_1 in level.cratetypes) {
    var_2 = var_1._id_944E;
    var_3 = var_1._id_9451;

    if(!isDefined(level._id_274B[var_1._id_9451])) {
      level._id_274B[var_1._id_9451] = 0;
    }

    level._id_274B[var_3] = level._id_274B[var_3] + var_1._id_7A8F;
    level.cratetypes[var_2]._id_9452 = level._id_274B[var_3];
    level._id_274B["all"] = level._id_274B["all"] + var_1._id_7A8F;
    level.cratetypes[var_2]._id_0C36 = level._id_274B["all"];
  }
}

setairdropcratecollision(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  level._id_0B80 = _getEnt(var_1[0].target, "targetname");

  foreach(var_3 in var_1) {
    var_3 deletecrate();
  }
}

_id_09F0(var_0, var_1, var_2, var_3) {
  level.cratetypes[var_0] = spawnStruct();
  level.cratetypes[var_0]._id_944E = var_0;
  level.cratetypes[var_0]._id_9451 = var_2;
  level.cratetypes[var_0]._id_7A8F = var_1;
  level.cratetypes[var_0]._id_0C36 = var_1;
  level.cratetypes[var_0]._id_9452 = var_1;

  if(isDefined(var_3)) {
    game["strings"][var_0 + "_hint"] = var_3;
  }
}

_id_4479(var_0) {
  var_2 = undefined;

  if(isDefined(var_0) && var_0 != "all") {
    var_3 = randomint(level._id_274B[var_0]);

    foreach(var_5 in level.cratetypes) {
      if(var_5._id_9451 != var_0) {
        continue;
      }
      var_2 = var_5._id_944E;

      if(var_5._id_9452 > var_3) {
        break;
      }
    }
  } else {
    var_3 = randomint(level._id_274B["all"]);

    foreach(var_5 in level.cratetypes) {
      var_2 = var_5._id_944E;

      if(var_5._id_0C36 > var_3) {
        break;
      }
    }
  }

  return var_2;
}

special_array_remove(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1) {
      var_2[var_4.type] = var_4;
    }
  }

  return var_2;
}

deleteonownerdeath(var_0) {
  self linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 waittill("death");
  self delete();
}

crateteammodelupdater() {
  self endon("death");
  self hide();

  foreach(var_1 in level.players) {
    if(var_1.team != "spectator") {
      self showtoplayer(var_1);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_1 in level.players) {
      if(var_1.team != "spectator") {
        self showtoplayer(var_1);
      }
    }
  }
}

cratemodelteamupdater(var_0, var_1) {
  self endon("death");
  self hide();

  foreach(var_3 in level.players) {
    if(var_3.team == var_0 || var_1 && var_3.team == "spectator") {
      self showtoplayer(var_3);
    }
  }

  for(;;) {
    level common_scripts\utility::waittill_any("joined_team", "joined_spectators");
    self hide();

    foreach(var_3 in level.players) {
      if(var_3.team == var_0 || var_1 && var_3.team == "spectator") {
        self showtoplayer(var_3);
      }
    }
  }
}

cratemodelplayerupdater(var_0, var_1) {
  self endon("death");
  self hide();

  foreach(var_3 in level.players) {
    if(var_1 && isDefined(var_0) && var_3 != var_0) {
      continue;
    }
    if(!var_1 && isDefined(var_0) && var_3 == var_0) {
      continue;
    }
    self showtoplayer(var_3);
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_3 in level.players) {
      if(var_1 && isDefined(var_0) && var_3 != var_0) {
        continue;
      }
      if(!var_1 && isDefined(var_0) && var_3 == var_0) {
        continue;
      }
      self showtoplayer(var_3);
    }
  }
}

crateuseteamupdater(var_0) {
  self endon("death");

  for(;;) {
    setusablebyteam(var_0);
    level waittill("joined_team");
  }
}

createairdropcrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  var_7 = spawn("script_model", var_3);
  var_7.angles = var_4;
  var_7.curprogress = 0;
  var_7.userate = 0;
  var_7.team = self.team;

  if(isDefined(var_0)) {
    var_7._id_0117 = var_0;
  } else {
    var_7._id_0117 = undefined;
  }

  var_7._id_944E = var_2;
  var_7._id_34B5 = var_1;
  var_7.targetname = "care_package";

  if(var_7.team == "any") {
    var_7 setModel("ger_carepackage_crate");
    var_7.friendlymodel = spawn("script_model", var_7.origin);
    var_7.friendlymodel setModel("tag_origin");
    var_7.friendlymodel thread deleteonownerdeath(var_7);
  } else {
    var_7 setModel(_id_0510::getteamcratemodel(var_7.team));
    var_7 thread crateteammodelupdater();
    var_8 = "ger_carepackage_crate";
    var_9 = "ger_carepackage_crate";
    var_7.friendlymodel = spawn("script_model", var_3);
    var_7.friendlymodel setModel(var_8);
    var_7.friendlymodel.parentcrate = var_7;
    var_7.friendlymodel notsolid();
    var_7.enemymodel = spawn("script_model", var_3);
    var_7.enemymodel setModel(var_9);
    var_7.enemymodel.parentcrate = var_7;
    var_7.enemymodel notsolid();
    var_7.friendlymodel thread deleteonownerdeath(var_7);

    if(level.teambased) {
      var_7.friendlymodel thread cratemodelteamupdater(var_7.team, 1);
    } else {
      var_7.friendlymodel thread cratemodelplayerupdater(var_0, 1);
    }

    var_7.enemymodel thread deleteonownerdeath(var_7);

    if(level.teambased) {
      var_7.enemymodel thread cratemodelteamupdater(level.otherteam[var_7.team], 0);
    } else {
      var_7.enemymodel thread cratemodelplayerupdater(var_0, 0);
    }
  }

  var_7.inuse = 0;

  if(var_6) {
    var_7 clonebrushmodeltoscriptmodel(level._id_0B80);
  }

  var_7.killcament = spawn("script_model", var_7.origin + (0, 0, -200));
  var_7.killcament setscriptmoverkillcam("missile");
  var_7.killcament _meth_80B1();
  var_7.killcament linkTo(var_7);
  return var_7;
}

cratesetuphintstrings(var_0) {
  self setCursorHint("HINT_NOICON");
  self setHintString(var_0);
}

cratesetupforuse(var_0) {
  self makeusable();

  if(self.team == "any") {
    var_1 = _id_04D1::_id_45A9();
    _objective_add(var_1, "invisible", (0, 0, 0));
    _objective_position(var_1, self.origin);
    _objective_state(var_1, "active");
    var_2 = "compass_objpoint_ammo_friendly";
    _objective_icon(var_1, var_2);
    _objective_team(var_1, "none");
    self._id_698E = var_1;
  } else {
    if(level.teambased || isDefined(self._id_0117)) {
      var_1 = _id_04D1::_id_45A9();
      _objective_add(var_1, "invisible", (0, 0, 0));
      _objective_position(var_1, self.origin);
      _objective_state(var_1, "active");
      var_2 = "compass_objpoint_ammo_friendly";
      _objective_icon(var_1, var_2);

      if(!level.teambased && isDefined(self._id_0117)) {
        _objective_playerenemyteam(var_1, self._id_0117 getentitynumber());
      } else {
        _objective_team(var_1, self.team);
      }

      self._id_698E = var_1;
    }

    if(isDefined(self._id_0117)) {
      var_1 = _id_04D1::_id_45A9();
      _objective_add(var_1, "invisible", (0, 0, 0));
      _objective_position(var_1, self.origin);
      _objective_state(var_1, "active");
      _objective_icon(var_1, "compass_objpoint_ammo_enemy");

      if(!level.teambased && isDefined(self._id_0117)) {
        _objective_playerteam(var_1, self._id_0117 getentitynumber());
      } else {
        _objective_team(var_1, level.otherteam[self.team]);
      }

      self._id_698D = var_1;
    }
  }

  if(self.team == "any") {
    foreach(var_4 in level.teamnamelist) {
      if(isDefined(var_0) && _isarray(var_0)) {
        setheadicon_multiple(var_4, var_0);
        continue;
      }

      _id_0479::setheadicon(var_4, var_0, (0, 0, 60), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
    }
  } else {
    thread crateuseteamupdater();
    var_6 = self._id_944E;

    if(level.teambased) {
      if(isDefined(var_0) && _isarray(var_0)) {
        setheadicon_multiple(self.team, var_0);
      } else {
        _id_0479::setheadicon(self.team, var_0, (0, 0, 60), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
      }
    } else if(isDefined(self._id_0117)) {
      if(isDefined(var_0) && _isarray(var_0)) {
        setheadicon_multiple(self._id_0117, var_0);
      } else {
        _id_0479::setheadicon(self._id_0117, var_0, (0, 0, 60), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
      }
    }
  }
}

setheadicon_multiple(var_0, var_1) {
  var_2 = 10;
  var_3 = 0;
  self.iconents = [];

  foreach(var_5 in var_1) {
    self.iconents[var_5] = common_scripts\utility::spawn_tag_origin();
    self.iconents[var_5] _id_0479::setheadicon(var_0, var_5, (0, 0, 55 + var_3 * var_2), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
    var_3++;
  }
}

setusablebyteam(var_0) {
  var_1 = self._id_944E;

  foreach(var_3 in level.players) {
    if(!isDefined(var_0) || var_0 == var_3.team) {
      self enableplayeruse(var_3);
      continue;
    }

    self disableplayeruse(var_3);
  }
}

physicswaiter(var_0, var_1) {
  self waittill("physics_finished");
  self.droppingtoground = 0;
  thread _id_5A5F(var_1);
  level thread droptimeout(self);
  var_2 = getEntArray("trigger_hurt", "classname");

  foreach(var_4 in var_2) {
    if(self.friendlymodel istouching(var_4)) {
      deletecrate();
      return;
    }
  }

  if(isDefined(self._id_0117) && _abs(self.origin[2] - self._id_0117.origin[2]) > 4000) {
    deletecrate();
    return;
  }

  var_6 = spawnStruct();
  var_6.deathoverridecallback = ::_id_64EB;
  var_6.touchingplatformvalid = ::movingplatformtouchvalid;
  thread _id_0488::handle_moving_platforms(var_6);
}

_id_64EB(var_0) {
  deletecrate(1, 1);
}

movingplatformtouchvalid(var_0) {
  return carepackageandcarepackagevalid(var_0) && _id_1FFB(var_0);
}

carepackageandcarepackagevalid(var_0) {
  return !isDefined(self.targetname) || !isDefined(var_0.targetname) || self.targetname != "care_package" || var_0.targetname != "care_package";
}

_id_1FFB(var_0) {
  return !isDefined(self.targetname) || !isDefined(var_0.carepackagetouchvalid) || self.targetname != "care_package" || !var_0.carepackagetouchvalid;
}

droptimeout(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(90);

  while(var_0.curprogress != 0) {
    wait 1;
  }

  var_0 deletecrate(1, 1);
}

_id_2744() {
  self endon("captured");

  while(isDefined(self)) {
    self waittill("trigger", var_0);
    thread _id_11C3(var_0);
  }
}

_id_11C3(var_0) {
  if(var_0 isjumping()) {
    return;
  }
  if(!var_0 isonground() && !waitplayerstuckoncarepackagereturn(var_0)) {
    return;
  }
  if(!validateopenconditions(var_0)) {
    return;
  }
  var_1 = 3000;

  if(var_0 == self._id_0117) {
    var_1 = 500;
  }

  var_0.iscapturingcrate = 1;
  var_2 = _id_2836();
  var_3 = var_2 useholdthink(var_0, var_1);

  if(isDefined(var_2)) {
    var_2 delete();
  }

  if(isDefined(var_0)) {
    var_0.iscapturingcrate = 0;
  }

  if(!var_3) {
    return;
  }
  self notify("captured", var_0);
}

waitplayerstuckoncarepackagereturn(var_0) {
  if(var_0 isonground()) {
    return 0;
  }

  var_1 = 200;
  var_2 = var_0.origin;
  var_3 = gettime();

  while(isDefined(var_0) && maps\mp\_utility::isreallyalive(var_0) && !var_0 isonground() && var_2 == var_0.origin && var_0 useButtonPressed()) {
    var_4 = gettime() - var_3;

    if(var_4 >= var_1) {
      return 1;
    }

    waitframe();
  }

  return 0;
}

validateopenconditions(var_0) {
  var_1 = var_0 getcurrentprimaryweapon();

  if(issubstr(var_1, "turrethead") || issubstr(var_1, "flamethrower") || issubstr(var_1, "carepackage")) {
    return 1;
  }

  if(!var_0 _id_051E::canshufflewithkillstreakweapon()) {
    return 0;
  }

  if(isDefined(var_0.changingweapon) && !var_0 _id_051E::canshufflewithkillstreakweapon()) {
    return 0;
  }

  return 1;
}

_id_5A5F(var_0) {
  self endon("death");
  var_1 = undefined;

  if(isDefined(game["strings"][var_0 + "_hint"])) {
    var_1 = game["strings"][var_0 + "_hint"];
  } else {
    var_1 = &"PLATFORM_GET_KILLSTREAK";
  }

  cratesetupforuse(_id_051E::getkillstreakcrateicon(var_0));

  if(isDefined(self._id_56C5) && self._id_56C5) {
    self waittill("physics_finished");
  }

  cratesetuphintstrings(var_1);
  thread _id_2744();

  for(;;) {
    self waittill("captured", var_2);

    if(isDefined(self._id_0117) && var_2 != self._id_0117) {
      if(!level.teambased || var_2.team != self.team) {
        var_2 thread _id_047A::hijackerevent(self._id_0117);
      } else {
        self._id_0117 thread _id_047A::sharedevent();
      }
    }

    var_2 playlocalsound("scavenger_pack_pickup");
    var_3 = var_2 _id_051E::getnextkillstreakslotindex(self._id_944E, 0);
    var_2 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(self._id_944E, undefined, undefined, var_3);
    var_2 thread _id_051E::givekillstreak(self._id_944E, 0, 0, self._id_0117);
    var_2 _id_0468::_id_0A28("packageCapped");
    deletecrate(1);
  }
}

deletecrate(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(self._id_698E)) {
    maps\mp\_utility::_objective_delete(self._id_698E);
  }

  if(isDefined(self._id_698D)) {
    maps\mp\_utility::_objective_delete(self._id_698D);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self._id_6DB1)) {
    self._id_6DB1 delete();
  }

  if(isDefined(self._id_6C62)) {
    self._id_6C62 delete();
  }

  if(isDefined(self._id_34B5)) {
    if(var_0) {
      playFX(common_scripts\utility::getfx("care_package_axis_destroy"), self.origin, anglesToForward(self.angles));
    }

    if(var_1) {
      playsoundatpos(self.origin, "orbital_pkg_self_destruct");
    }
  }

  if(isDefined(self.iconents)) {
    foreach(var_3 in self.iconents) {
      var_3 delete();
    }
  }

  thread _id_27DF(self.origin, self.angles);
  self delete();
}

_id_27DF(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("hub_lootcrate_a_pieces_chunks");
  var_2.angles = var_1;
  var_2 show();
  waitframe();
  _physicsexplosionsphere(var_0, 100, 80, 0.6);
  wait 2;
  var_2 delete();
}

useholdthink(var_0, var_1) {
  if(isPlayer(var_0)) {
    var_0 playerlinkTo(self);
  } else {
    var_0 linkTo(self);
  }

  var_0 common_scripts\utility::_id_0602();
  thread useholdthinkplayerreset(var_0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;

  if(isPlayer(var_0)) {
    var_0 thread personalusebar(self, var_1);
  }

  var_2 = useholdthinkloop(var_0, var_1);

  if(!isDefined(self)) {
    return 0;
  }

  self notify("useHoldThinkLoopDone");
  self.inuse = 0;
  self.curprogress = 0;
  return var_2;
}

useholdthinkplayerreset(var_0) {
  var_0 endon("death");
  common_scripts\utility::waittill_any("death", "captured", "useHoldThinkLoopDone");

  if(isalive(var_0)) {
    var_0 common_scripts\utility::_id_0616();

    if(var_0 islinked()) {
      var_0 unlink();
    }
  }
}

personalusebar(var_0, var_1) {
  self endon("disconnect");
  self setclientomnvar("ui_use_bar_text", 1);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  var_2 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0) && var_0.inuse && !level.gameended) {
    if(var_2 != var_0.userate) {
      if(var_0.curprogress > var_1) {
        var_0.curprogress = var_1;
      }

      if(var_0.userate > 0) {
        var_3 = gettime();
        var_4 = var_0.curprogress / var_1;
        var_5 = var_3 + (1 - var_4) * (var_1 / var_0.userate);
        self setclientomnvar("ui_use_bar_end_time", int(var_5));
      }

      var_2 = var_0.userate;
    }

    waitframe();
  }

  self setclientomnvar("ui_use_bar_end_time", 0);
}

useholdthinkloop(var_0, var_1) {
  while(!level.gameended && isDefined(self) && maps\mp\_utility::isreallyalive(var_0) && var_0 useButtonPressed() && self.curprogress < var_1) {
    self.curprogress = self.curprogress + self.userate * 50;

    if(!self.userate) {
      self.userate = 1;
    }

    if(self.curprogress >= var_1) {
      return maps\mp\_utility::isreallyalive(var_0);
    }

    waitframe();
  }

  return 0;
}

_id_2836() {
  var_0 = spawn("script_origin", self.origin);
  var_0.curprogress = 0;
  var_0.userate = 0;
  var_0.inuse = 0;
  var_0 thread _id_2D57(self);
  return var_0;
}

_id_2D57(var_0) {
  self endon("death");
  var_0 waittill("death");
  self delete();
}