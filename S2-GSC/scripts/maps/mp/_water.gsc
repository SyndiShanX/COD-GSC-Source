/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_water.gsc
**************************************/

init() {
  if(isDefined(level.water_wake)) {
    level._effect["water_wake"] = loadfx(level.water_wake);
  } else {
    level._effect["water_wake"] = loadfx("vfx/treadfx/body_wake_water");
  }

  if(isDefined(level.water_wake_stationary)) {
    level._effect["water_wake_stationary"] = loadfx(level.water_wake_stationary);
  } else {
    level._effect["water_wake_stationary"] = loadfx("vfx/treadfx/body_wake_water_stationary");
  }

  if(isDefined(level.water_splash_emerge)) {
    level._effect["water_splash_emerge"] = loadfx(level.water_splash_emerge);
  } else {
    level._effect["water_splash_emerge"] = loadfx("vfx/water/body_splash_exit");
  }

  if(isDefined(level.water_splash_enter)) {
    level._effect["water_splash_enter"] = loadfx(level.water_splash_enter);
  } else {
    level._effect["water_splash_enter"] = loadfx("vfx/water/body_splash");
  }

  _precacheshellshock("underwater");

  if(!isDefined(level.waterline_ents)) {
    level.waterline_ents = [];
  }

  if(!isDefined(level.waterline_offset)) {
    level.waterline_offset = 0;
  }

  if(!isDefined(level.shallow_water_weapon)) {
    if(isDefined(level.iszombiegame) && level.iszombiegame) {
      setshallowwaterweapon("shovel_zm");
    } else {
      setshallowwaterweapon("iw5_underwater_mp");
    }
  }

  if(!isDefined(level.deep_water_weapon)) {
    setdeepwaterweapon("iw5_underwater_mp");
  }

  if(!isDefined(level._id_0C19)) {
    level._id_0C19 = 1;
  }

  if(level.deep_water_weapon == level.shallow_water_weapon) {
    level._id_0C19 = 0;
  }

  if(!isDefined(level.swimming_depth)) {
    level.swimming_depth = 48;
  }

  var_0 = getEntArray("trigger_underwater", "targetname");
  level.water_triggers = var_0;

  foreach(var_2 in var_0) {
    var_2 create_clientside_water_ents();
    var_2 thread watchplayerenterwater();
  }

  level thread clearwatervarsonspawn(var_0);
  level thread onplayerconnectfunctions();
  setDvar("scr_ball_water_drop_delay", 10);
}

player_set_in_water(var_0) {
  if(var_0) {
    self.inwater = 1;
  } else {
    self.inwater = undefined;
  }
}

watchforhostmigration() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("player_migrated");

    foreach(var_1 in level.waterline_ents) {
      self initwaterclienttrigger(var_1._id_0165, var_1);
    }
  }
}

onplayerconnectfunctions() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread watchforhostmigration();

    foreach(var_2 in level.waterline_ents) {
      var_0 initwaterclienttrigger(var_2._id_0165, var_2);
    }
  }
}

create_clientside_water_ents() {
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");
  var_0.origin = var_0.origin + (0, 0, level.waterline_offset);
  var_1 = var_0 common_scripts\utility::spawn_tag_origin();
  var_1 show();

  if(isDefined(self._id_0165)) {
    var_1._id_0165 = self._id_0165;
    level.waterline_ents = common_scripts\utility::_id_0F6F(level.waterline_ents, var_1);
  }
}

clearwatervarsonspawn(var_0) {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_1);
    var_2 = 0;

    foreach(var_4 in var_0) {
      if(var_1 istouching(var_4)) {
        var_2 = 1;
        break;
      }
    }

    if(!var_2) {
      var_1 player_set_in_water(0);
      var_1.underwater = undefined;
      var_1.inthickwater = undefined;
      var_1 setmeleeradius();
      var_1.isswimming = undefined;
      var_1.iswading = undefined;
      var_1.water_last_weapon = undefined;
      var_1.watermovespeedscale = 1;
      var_1.isshocked = undefined;
      var_1 notify("out_of_water");
    }
  }
}

watchplayerenterwater() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0) && !_isai(var_0)) {
      continue;
    }
    if(!isalive(var_0)) {
      continue;
    }
    if(var_0 _id_028D::_id_5855()) {
      continue;
    }
    if(!isDefined(var_0.inwater)) {
      var_0 player_set_in_water(1);
      var_0 thread playerinwater(self);
    }
  }
}

playerinwater(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  thread inwaterwake(var_0);
  thread playerwaterclearwait();
  self.eyeheightlastframe = 0;
  self.eye_velocity = 0;

  for(;;) {
    if(maps\mp\_utility::isusingremote()) {
      if(isDefined(self.underwater) && isDefined(self.isshocked)) {
        self notify("stop_water_shellshock");
        self stopshellshock();
        self allowmelee(1);
        self.isshocked = undefined;
      }
    } else if(isDefined(self.underwater) && !isDefined(self.isshocked)) {
      thread playerapplyshellshock();
      self allowmelee(0);
    }

    if(!self istouching(var_0)) {
      player_set_in_water(0);
      self.underwater = undefined;
      self.inthickwater = undefined;
      self setmeleeradius();
      self.isswimming = undefined;
      self.watermovespeedscale = 1;
      _id_0513::updatemovespeedscale();
      self notify("out_of_water");
      self.iswading = undefined;

      if(!maps\mp\_utility::isusingremote()) {
        self stopshellshock();
        self allowmelee(1);
        self.isshocked = undefined;
      }

      playerdisableunderwater();
      maps\mp\_utility::_id_73AF(1);
      var_1 = distance(self getvelocity(), (0, 0, 0));
      var_2 = (self.origin[0], self.origin[1], getwaterline(var_0));
      playFX(level._effect["water_splash_emerge"], var_2, anglesToForward((0, self.angles[1], 0) + (270, 180, 0)));
      break;
    }

    if(isDefined(self.inthickwater) && inshallowwater(var_0, 32)) {
      self.inthickwater = undefined;
      self.watermovespeedscale = 1;
      _id_0513::updatemovespeedscale();
    }

    if(inshallowwater(var_0, 32)) {
      self.inthickwater = undefined;

      if(isDefined(level._id_A96A)) {
        self.watermovespeedscale = level._id_A96A;
      } else {
        self.watermovespeedscale = 1;
      }

      _id_0513::updatemovespeedscale();
    }

    if(!isDefined(self.inthickwater) && !inshallowwater(var_0, 32)) {
      self.inthickwater = 1;
      self.watermovespeedscale = 0.7;
      _id_0513::updatemovespeedscale();
    }

    if(!isDefined(self.underwater) && (!isabovewaterline(var_0, 0) || isunderwaterprop())) {
      if(isDefined(self.balldropdelay) && self.balldropdelay > 0) {
        self.balldropdelay--;
        waitframe();
        continue;
      }

      self.underwater = 1;

      if(isDefined(level.waterplayerhandledamagefunc)) {
        self thread[[level.waterplayerhandledamagefunc]]();
      } else if(!(level.gametype == "prop" && self.team != game["defenders"])) {
        thread playerhandledamage();
      }

      maps\mp\_utility::_id_73AF(0);

      if(!maps\mp\_utility::isusingremote()) {
        thread playerapplyshellshock();
        self allowmelee(0);
      }

      var_3 = self getcurrentweapon();

      if(var_3 != "none") {
        var_4 = weaponinventorytype(var_3);

        if(var_4 == "primary" || var_4 == "altmode") {
          self.water_last_weapon = var_3;
        } else if(maps\mp\_utility::iskillstreakweapon(var_3)) {
          self.water_last_weapon = _id_051E::playergetkillstreaklastweapon();
        } else if(isDefined(self.lastnonuseweapon) && self hasweapon(self.lastnonuseweapon)) {
          self.water_last_weapon = self.lastnonuseweapon;
        }
      }

      if(isDefined(level.gamemodeonunderwater)) {
        self[[level.gamemodeonunderwater]](var_0);
      }
    }

    if(isDefined(self.underwater) && (isDefined(self.isswimming) || !isDefined(self.iswading)) && (inshallowwater(var_0, level.swimming_depth) || self getstance() == "prone" || !level._id_0C19)) {
      self.iswading = 1;
      self setmarksman();
      self.isswimming = undefined;
      playerdisableunderwater();

      if(isDefined(self.isjuggernaut) && self.isjuggernaut == 1) {
        playerenableunderwater("none");
        self allowfire(0);
        self disableoffhandsecondaryweapons();
      } else if(!isDefined(level.iszombiegame) || !_isscriptedagent(self))
        playerenableunderwater("shallow");
    }

    if(isDefined(self.underwater) && (isDefined(self.iswading) || !isDefined(self.isswimming)) && (!inshallowwater(var_0, level.swimming_depth) && self getstance() != "prone" && level._id_0C19)) {
      self setmarksman();
      self.isswimming = 1;
      self.iswading = undefined;
      playerdisableunderwater();

      if(isDefined(self.isjuggernaut) && self.isjuggernaut == 1) {
        playerenableunderwater("none");
        self allowfire(0);
        self disableoffhandsecondaryweapons();
      } else if(!isDefined(level.iszombiegame) || !_isscriptedagent(self))
        playerenableunderwater("deep");
    }

    if(isDefined(self.balldropdelay)) {
      self.balldropdelay = getdvarint("scr_ball_water_drop_delay", 10);
    }

    if(isDefined(self.underwater) && isabovewaterline(var_0, 0) && !isunderwaterprop()) {
      self.underwater = undefined;
      self setmeleeradius();
      self.isswimming = undefined;
      self.iswading = undefined;
      self notify("above_water");
      var_1 = distance(self getvelocity(), (0, 0, 0));
      var_2 = (self.origin[0], self.origin[1], getwaterline(var_0));
      playFX(level._effect["water_splash_emerge"], var_2, anglesToForward((0, self.angles[1], 0) + (270, 180, 0)));

      if(!maps\mp\_utility::isusingremote()) {
        self stopshellshock();
        self allowmelee(1);
        self.isshocked = undefined;
      }

      playerdisableunderwater();
      maps\mp\_utility::_id_73AF(1);
    }

    waitframe();
  }
}

isunderwaterprop() {
  var_0 = level.gametype == "prop";
  var_1 = self.team == game["defenders"];
  var_2 = maps\mp\_utility::getmapname() != "mp_wolfslair";
  return var_0 && var_1 && var_2;
}

playerapplyshellshock() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("stop_water_shellshock");
  self endon("out_of_water");
  self endon("above_water");
  self.isshocked = 1;

  for(;;) {
    self shellshock("underwater", 19, undefined, 0);
    wait 19;
  }
}

isactivekillstreakwaterrestricted(var_0) {
  if(isDefined(var_0.killstreakindexweapon)) {
    var_1 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;

    if(isDefined(var_1)) {
      if(issubstr(var_1, "turret") || issubstr(var_1, "sentry")) {
        return 1;
      }
    }
  }

  return 0;
}

playerwaterclearwait() {
  var_0 = common_scripts\utility::waittill_any_return("death", "out_of_water");

  if(isDefined(self)) {
    self.underwatermotiontype = undefined;
    self.dont_give_or_take_weapon = undefined;
    player_set_in_water(0);
    self.underwater = undefined;
    self.inthickwater = undefined;
    self.water_last_weapon = undefined;
    self.watermovespeedscale = 1;
    _id_0513::updatemovespeedscale();
  }
}

inwaterwakevfxcleanup() {
  self endon("inWaterWakeVFXCleanup");

  if(_isagent(self)) {
    maps\mp\agents\_agent_utility::deleteentonagentdeath(self.fxentwake);
    maps\mp\agents\_agent_utility::deleteentonagentdeath(self.fxentstationary);
  }

  if(!isDefined(self.waterwakevfxdeletefunc)) {
    self.waterwakevfxdeletefunc = ::waterwakevfxdelete;
  }

  common_scripts\utility::waittill_any_ents(self, "death", level, "game_ended", self, "disconnect", self, "out_of_water", self.fxentwake, "entitydeleted", self.fxentstationary, "entitydeleted");
  thread waterwakevfxdelete();
}

waterwakevfxdelete() {
  self notify("inWaterWakeVFXCleanup");
  self notify("out_of_water");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.fxentwake)) {
    self.fxentwake delete();
  }

  if(isDefined(self.fxentstationary)) {
    self.fxentstationary delete();
  }

  if(isDefined(self.waterwakevfxdeletefunc)) {
    self.waterwakevfxdeletefunc = undefined;
  }
}

inwaterwake(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("out_of_water");
  var_1 = distance(self getvelocity(), (0, 0, 0));

  if(var_1 > 90) {
    var_2 = (self.origin[0], self.origin[1], getwaterline(var_0));
    playFX(level._effect["water_splash_enter"], var_2, anglesToForward((0, self.angles[1], 0) + (270, 180, 0)));
  }

  var_3 = _spawnlinkedfx(common_scripts\utility::getfx("water_wake"), self, "tag_origin");
  var_4 = _spawnlinkedfx(common_scripts\utility::getfx("water_wake_stationary"), self, "tag_origin");
  self.fxentwake = var_3;
  self.fxentstationary = var_4;
  thread inwaterwakevfxcleanup();
  _triggerfx(var_3);
  _triggerfx(var_4);
  var_5 = 0;
  var_6 = 4000;

  for(;;) {
    var_7 = self getvelocity();
    var_1 = distance(var_7, (0, 0, 0));

    if(var_1 > 0) {
      wait(max(1 - var_1 / 120, 0.1));
    } else {
      wait 0.3;
    }

    var_8 = getwaterline(var_0) - self.origin[2];

    if((self getstance() == "prone" && var_8 > 24) == 0) {
      if(var_1 > 5) {
        _triggerfx(var_3);
        continue;
      }

      _triggerfx(var_4);
    }
  }
}

playerhandledamage() {
  level endon("game_ended");
  self endon("death");
  self endon("stopped_using_remote");
  self endon("disconnect");
  self endon("above_water");
  self endon("out_of_water");
  thread onplayerdeath();
  wait 13;

  for(;;) {
    if(!isDefined(self.isjuggernaut) || self.isjuggernaut == 0) {
      self dodamage(20, self.origin + anglesToForward(self.angles) * 5, undefined, undefined, "MOD_TRIGGER_HURT");
    }

    wait 1;
  }
}

onplayerdeath() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("above_water");
  self endon("out_of_water");
  self waittill("death");
  player_set_in_water(0);
  self.underwater = undefined;
  self.inthickwater = undefined;
  self setmeleeradius();
  self.isswimming = undefined;
  self.iswading = undefined;
  self.water_last_weapon = undefined;
  self.underwatermotiontype = undefined;
  self.eye_velocity = 0;
  self.eyeheightlastframe = 0;
}

inshallowwater(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 32;
  }

  if(level getwaterline(var_0) - self.origin[2] <= var_1) {
    return 1;
  }

  return 0;
}

isabovewaterline(var_0, var_1) {
  if(getplayereyeheight() + var_1 >= level getwaterline(var_0)) {
    return 1;
  } else {
    return 0;
  }
}

getplayereyeheight() {
  var_0 = self getEye();
  self.eye_velocity = var_0[2] - self.eyeheightlastframe;
  self.eyeheightlastframe = var_0[2];
  return var_0[2];
}

getwaterline(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = var_1.origin[2];
  return var_2;
}

_id_5728() {
  return isDefined(self.inlaststand) && self.inlaststand;
}

playerenableunderwater(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("end_swimming");

  if(!isDefined(var_0)) {
    var_0 = "shallow";
  }

  if(var_0 == "shallow" && self hasweapon(level.shallow_water_weapon) || var_0 == "deep" && self hasweapon(level.deep_water_weapon) || isDefined(level.disable_water_weapon_swap)) {
    self.dont_give_or_take_weapon = 1;
  }

  switch (var_0) {
    case "deep":
      give_water_weapon(level.deep_water_weapon);

      if(!_id_5728()) {
        self switchtoweaponimmediate(level.deep_water_weapon);
      }

      self.underwatermotiontype = "deep";
      break;
    case "shallow":
      give_water_weapon(level.shallow_water_weapon);

      if(!_id_5728()) {
        self switchtoweaponimmediate(level.shallow_water_weapon);
      }

      self.underwatermotiontype = "shallow";
      break;
    case "none":
      self.underwatermotiontype = "none";
      break;
    default:
      give_water_weapon(level.shallow_water_weapon);

      if(!_id_5728()) {
        self switchtoweaponimmediate(level.shallow_water_weapon);
      }

      self.underwatermotiontype = "shallow";
      break;
  }

  self disableweaponpickup();
  common_scripts\utility::_id_0603();
  common_scripts\utility::_disableoffhandweapons();
}

playerdisableunderwater() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(isDefined(self.underwatermotiontype)) {
    var_0 = self.underwatermotiontype;
    self notify("end_swimming");
    self enableweaponpickup();
    common_scripts\utility::_id_0617();
    common_scripts\utility::_id_0614();

    if(isDefined(self.isjuggernaut) && self.isjuggernaut == 1 && isDefined(self.heavyexodata)) {
      self allowfire(1);

      if(!isDefined(self.heavyexodata.haslongpunch) || self.heavyexodata.haslongpunch == 0) {
        self disableoffhandweapons();
      }

      if(!isDefined(self.heavyexodata.hasrockets) || self.heavyexodata.hasrockets == 0) {
        self disableoffhandsecondaryweapons();
      } else {
        self enableoffhandsecondaryweapons();
      }
    } else if(isDefined(self.water_last_weapon)) {
      if(!_id_5728()) {
        maps\mp\_utility::switch_to_last_weapon(self.water_last_weapon);
      }
    }

    switch (var_0) {
      case "deep":
        take_water_weapon(level.deep_water_weapon);
        break;
      case "shallow":
        take_water_weapon(level.shallow_water_weapon);
        break;
      case "none":
        break;
      default:
        take_water_weapon(level.shallow_water_weapon);
        break;
    }

    self.underwatermotiontype = undefined;
    self.dont_give_or_take_weapon = undefined;
  }
}

give_water_weapon(var_0) {
  if(!isDefined(self.dont_give_or_take_weapon) || !self.dont_give_or_take_weapon) {
    self giveweapon(var_0);
  }
}

take_water_weapon(var_0) {
  if(!isDefined(self.dont_give_or_take_weapon) || !self.dont_give_or_take_weapon) {
    self takeweapon(var_0);
  }
}

setshallowwaterweapon(var_0) {
  level.shallow_water_weapon = var_0;
}

setdeepwaterweapon(var_0) {
  level.deep_water_weapon = var_0;
}

_id_5840(var_0) {
  switch (var_0) {
    case "combatknife_zm":
    case "iw5_underwater_mp":
    case "shovel_zm":
    case "boxing_gloves_mp":
    case "baseballbat_mp":
    case "trenchknife_mp":
    case "combatknife_mp":
    case "icepick_mp":
    case "shovel_mp":
    case "none":
      return 1;
    default:
      return 0;
  }
}