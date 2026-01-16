/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_water.gsc
********************************/

init() {
  level._effect["water_wake"] = loadfx("vfx\treadfx\body_wake_water");
  level._effect["water_wake_stationary"] = loadfx("vfx\treadfx\body_wake_water_stationary");
  level._effect["water_splash_emerge"] = loadfx("vfx\water\body_splash_exit");
  level._effect["water_splash_enter"] = loadfx("vfx\water\body_splash");
  precacheshellshock("underwater");

  if(!isdefined(level.waterline_ents))
    level.waterline_ents = [];

  if(!isdefined(level.waterline_offset))
    level.waterline_offset = 0;

  if(!isdefined(level.shallow_water_weapon))
    setshallowwaterweapon("iw5_combatknife_mp");

  if(!isdefined(level.deep_water_weapon))
    setdeepwaterweapon("iw5_underwater_mp");

  if(!isdefined(level.allow_swimming))
    level.allow_swimming = 1;

  if(level.deep_water_weapon == level.shallow_water_weapon)
    level.allow_swimming = 0;

  if(!isdefined(level.swimming_depth))
    level.swimming_depth = 48;

  var_0 = getentarray("trigger_underwater", "targetname");
  level.water_triggers = var_0;

  foreach(var_2 in var_0) {
    var_2 create_clientside_water_ents();
    var_2 thread watchplayerenterwater();
    level thread clearwatervarsonspawn(var_2);
  }

  level thread onplayerconnectfunctions();
}

player_set_in_water(var_0) {
  if(var_0)
    self.inwater = 1;
  else
    self.inwater = undefined;
}

watchforhostmigration() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  for (;;) {
    self waittill("player_migrated");

    foreach(var_1 in level.waterline_ents)
    self initwaterclienttrigger(var_1.script_noteworthy, var_1);
  }
}

onplayerconnectfunctions() {
  level endon("game_ended");

  for (;;) {
    level waittill("connected", var_0);
    var_0 thread watchforhostmigration();

    foreach(var_2 in level.waterline_ents)
    var_0 initwaterclienttrigger(var_2.script_noteworthy, var_2);
  }
}

create_clientside_water_ents() {
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");
  var_0.origin = var_0.origin + (0, 0, level.waterline_offset);
  var_1 = var_0 common_scripts\utility::spawn_tag_origin();
  var_1 show();

  if(isdefined(self.script_noteworthy)) {
    var_1.script_noteworthy = self.script_noteworthy;
    level.waterline_ents = common_scripts\utility::array_add(level.waterline_ents, var_1);
  }
}

clearwatervarsonspawn(var_0) {
  level endon("game_ended");

  for (;;) {
    level waittill("player_spawned", var_1);

    if(!var_1 istouching(var_0)) {
      var_1 player_set_in_water(0);
      var_1.underwater = undefined;
      var_1.inthickwater = undefined;
      var_1.isswimming = undefined;
      var_1.iswading = undefined;
      var_1.water_last_weapon = undefined;
      var_1.isshocked = undefined;
      var_1 notify("out_of_water");
    }
  }
}

watchplayerenterwater() {
  level endon("game_ended");

  for (;;) {
    self waittill("trigger", var_0);

    if(isdefined(level.ishorde) && level.ishorde && isagent(var_0) && isdefined(var_0.horde_type) && var_0.horde_type == "Quad" && !isdefined(var_0.inwater))
      var_0 thread hordedoginwater(self);

    if(!isplayer(var_0) && !isai(var_0)) {
      continue;
    }
    if(!isalive(var_0)) {
      continue;
    }
    if(!isdefined(var_0.inwater)) {
      var_0 player_set_in_water(1);
      var_0 thread playerinwater(self);
    }
  }
}

hordedoginwater(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  player_set_in_water(1);

  for (;;) {
    if(!inshallowwater(var_0, 40)) {
      wait 2.5;

      if(!inshallowwater(var_0, 20))
        self dodamage(self.health, self.origin);
    }

    waitframe();
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

  for (;;) {
    if(maps\mp\_utility::isusingremote()) {
      if(isdefined(self.underwater) && isdefined(self.isshocked)) {
        self stopshellshock();
        self.isshocked = undefined;
      }
    } else if(isdefined(self.underwater) && !isdefined(self.isshocked)) {
      self shellshock("underwater", 19, 0, 0);
      self.isshocked = 1;
    }

    if(!self istouching(var_0)) {
      player_set_in_water(0);
      self.underwater = undefined;
      self.inthickwater = undefined;
      self.isswimming = undefined;
      self.movespeedscaler = level.baseplayermovescale;
      maps\mp\gametypes\_weapons::updatemovespeedscale();
      self notify("out_of_water");
      break;
    }

    if(isdefined(self.inthickwater) && inshallowwater(var_0, 32)) {
      self.inthickwater = undefined;
      self.movespeedscaler = level.baseplayermovescale;
      maps\mp\gametypes\_weapons::updatemovespeedscale();
    }

    if(inshallowwater(var_0, 32)) {
      self.inthickwater = undefined;

      if(isdefined(level.watermovescale))
        self.movespeedscaler = level.baseplayermovescale * level.watermovescale;
      else
        self.movespeedscaler = level.baseplayermovescale;

      maps\mp\gametypes\_weapons::updatemovespeedscale();
    }

    if(!isdefined(self.inthickwater) && !inshallowwater(var_0, 32)) {
      self.inthickwater = 1;
      self.movespeedscaler = 0.7 * level.baseplayermovescale;
      maps\mp\gametypes\_weapons::updatemovespeedscale();
    }

    if(!isdefined(self.underwater) && !isabovewaterline(var_0, 0)) {
      self.underwater = 1;
      thread playerhandledamage();

      if(maps\mp\_utility::isaugmentedgamemode())
        disableexo();

      if(!maps\mp\_utility::isusingremote()) {
        self shellshock("underwater", 19, 0, 0);
        self.isshocked = 1;
      }

      var_1 = self getcurrentweapon();

      if(var_1 != "none") {
        var_2 = weaponinventorytype(var_1);

        if(var_2 == "primary" || var_2 == "altmode")
          self.water_last_weapon = var_1;
        else if(isdefined(self.lastnonuseweapon) && self hasweapon(self.lastnonuseweapon))
          self.water_last_weapon = self.lastnonuseweapon;
      }

      if(isdefined(level.gamemodeonunderwater))
        self[[level.gamemodeonunderwater]](var_0);

      if(isdefined(level.hordeonunderwater))
        self[[level.hordeonunderwater]](var_0);
    }

    if(isdefined(self.underwater) && (isdefined(self.isswimming) || !isdefined(self.iswading)) && (inshallowwater(var_0, level.swimming_depth) || self getstance() == "prone" || !level.allow_swimming)) {
      self.iswading = 1;
      self.isswimming = undefined;
      playerdisableunderwater();

      if(isdefined(self.isjuggernaut) && self.isjuggernaut == 1) {
        playerenableunderwater("none");
        self allowfire(0);
        self disableoffhandsecondaryweapons();
      } else if(!isdefined(level.iszombiegame) || !isscriptedagent(self))
        playerenableunderwater("shallow");
    }

    if(isdefined(self.underwater) && (isdefined(self.iswading) || !isdefined(self.isswimming)) && (!inshallowwater(var_0, level.swimming_depth) && self getstance() != "prone" && level.allow_swimming)) {
      self.isswimming = 1;
      self.iswading = undefined;
      playerdisableunderwater();

      if(isdefined(self.isjuggernaut) && self.isjuggernaut == 1) {
        playerenableunderwater("none");
        self allowfire(0);
        self disableoffhandsecondaryweapons();
      } else if(!isdefined(level.iszombiegame) || !isscriptedagent(self))
        playerenableunderwater("deep");
    }

    if(isdefined(self.underwater) && isabovewaterline(var_0, 0)) {
      self.underwater = undefined;
      self.isswimming = undefined;
      self.iswading = undefined;
      self notify("above_water");
      var_3 = distance(self getvelocity(), (0, 0, 0));
      var_4 = (self.origin[0], self.origin[1], getwaterline(var_0));
      playfx(level._effect["water_splash_emerge"], var_4, anglestoforward((0, self.angles[1], 0) + (270, 180, 0)));

      if(!maps\mp\_utility::isusingremote()) {
        self stopshellshock();
        self.isshocked = undefined;
      }

      playerdisableunderwater();

      if(maps\mp\_utility::isaugmentedgamemode())
        enableexo();
    }

    wait 0.05;
  }
}

isactivekillstreakwaterrestricted(var_0) {
  if(isdefined(var_0.killstreakindexweapon)) {
    var_1 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;

    if(isdefined(var_1)) {
      if(common_scripts\utility::string_find(var_1, "turret") > 0)
        return 1;
    }
  }

  return 0;
}

playerwaterclearwait() {
  var_0 = common_scripts\utility::waittill_any_return("death", "out_of_water");
  self.underwatermotiontype = undefined;
  self.dont_give_or_take_weapon = undefined;
  player_set_in_water(0);
  self.underwater = undefined;
  self.inthickwater = undefined;
  self.water_last_weapon = undefined;
  self.movespeedscaler = level.baseplayermovescale;
  maps\mp\gametypes\_weapons::updatemovespeedscale();
}

inwaterwake(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("out_of_water");
  var_1 = distance(self getvelocity(), (0, 0, 0));

  if(var_1 > 90) {
    var_2 = (self.origin[0], self.origin[1], getwaterline(var_0));
    playfx(level._effect["water_splash_enter"], var_2, anglestoforward((0, self.angles[1], 0) + (270, 180, 0)));
  }

  for (;;) {
    var_3 = self getvelocity();
    var_1 = distance(var_3, (0, 0, 0));

    if(var_1 > 0)
      wait(max(1 - var_1 / 120, 0.1));
    else
      wait 0.3;

    if(var_1 > 5) {
      var_4 = vectornormalize((var_3[0], var_3[1], 0));
      var_5 = anglestoforward(vectortoangles(var_4) + (270, 180, 0));
      var_2 = (self.origin[0], self.origin[1], getwaterline(var_0)) + var_1 / 4 * var_4;
      playfx(level._effect["water_wake"], var_2, var_5);
      continue;
    }

    var_2 = (self.origin[0], self.origin[1], getwaterline(var_0));
    playfx(level._effect["water_wake_stationary"], var_2, anglestoforward((0, self.angles[1], 0) + (270, 180, 0)));
  }
}

playerhandledamage() {
  level endon("game_ended");
  self endon("death");
  self endon("stopped_using_remote");
  self endon("disconnect");
  self endon("above_water");

  if(isdefined(level.ishorde) && level.ishorde)
    self endon("becameSpectator");

  thread onplayerdeath();
  wait 13;

  for (;;) {
    if(!isdefined(self.isjuggernaut) || self.isjuggernaut == 0)
      radiusdamage(self.origin + anglestoforward(self.angles) * 5, 1, 20, 20, undefined, "MOD_TRIGGER_HURT");

    wait 1;
  }
}

onplayerdeath() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("above_water");

  if(isdefined(level.ishorde) && level.ishorde)
    common_scripts\utility::waittill_any("death", "becameSpectator");
  else
    self waittill("death");

  player_set_in_water(0);
  self.underwater = undefined;
  self.inthickwater = undefined;
  self.isswimming = undefined;
  self.iswading = undefined;
  self.water_last_weapon = undefined;
  self.underwatermotiontype = undefined;
  self.eye_velocity = 0;
  self.eyeheightlastframe = 0;
}

inshallowwater(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 32;

  if(level getwaterline(var_0) - self.origin[2] <= var_1)
    return 1;

  return 0;
}

isabovewaterline(var_0, var_1) {
  if(getplayereyeheight() + var_1 >= level getwaterline(var_0))
    return 1;
  else
    return 0;
}

getplayereyeheight() {
  var_0 = self geteye();
  self.eye_velocity = var_0[2] - self.eyeheightlastframe;
  self.eyeheightlastframe = var_0[2];
  return var_0[2];
}

getwaterline(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = var_1.origin[2];
  return var_2;
}

playerenableunderwater(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("end_swimming");

  if(!isdefined(var_0))
    var_0 = "shallow";

  if(var_0 == "shallow" && self hasweapon(level.shallow_water_weapon) || var_0 == "deep" && self hasweapon(level.deep_water_weapon))
    self.dont_give_or_take_weapon = 1;

  switch (var_0) {
    case "deep":
      give_water_weapon(level.deep_water_weapon);
      self switchtoweaponimmediate(level.deep_water_weapon);
      self.underwatermotiontype = "deep";
      break;
    case "shallow":
      give_water_weapon(level.shallow_water_weapon);
      self switchtoweaponimmediate(level.shallow_water_weapon);
      self.underwatermotiontype = "shallow";
      break;
    case "none":
      self.underwatermotiontype = "none";
      break;
    default:
      give_water_weapon(level.shallow_water_weapon);
      self switchtoweaponimmediate(level.shallow_water_weapon);
      self.underwatermotiontype = "shallow";
      break;
  }

  self disableweaponpickup();
  common_scripts\utility::_disableweaponswitch();
  common_scripts\utility::_disableoffhandweapons();
}

playerdisableunderwater() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  if(isdefined(self.underwatermotiontype)) {
    var_0 = self.underwatermotiontype;
    self notify("end_swimming");
    self enableweaponpickup();
    common_scripts\utility::_enableweaponswitch();
    common_scripts\utility::_enableoffhandweapons();

    if(isdefined(self.isjuggernaut) && self.isjuggernaut == 1 && isdefined(self.heavyexodata)) {
      self allowfire(1);

      if(!isdefined(self.heavyexodata.haslongpunch) || self.heavyexodata.haslongpunch == 0)
        self disableoffhandweapons();

      if(!isdefined(self.heavyexodata.hasrockets) || self.heavyexodata.hasrockets == 0)
        self disableoffhandsecondaryweapons();
      else
        self enableoffhandsecondaryweapons();
    }

    if(isdefined(level.ishorde) && isplayer(self))
      maps\mp\gametypes\_weapons::restoreweapon("underwater");
    else if(isdefined(self.water_last_weapon))
      maps\mp\_utility::switch_to_last_weapon(self.water_last_weapon);

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
  if(!isdefined(self.dont_give_or_take_weapon) || !self.dont_give_or_take_weapon)
    self giveweapon(var_0);
}

take_water_weapon(var_0) {
  if(!isdefined(self.dont_give_or_take_weapon) || !self.dont_give_or_take_weapon)
    self takeweapon(var_0);
}

enableexo() {
  maps\mp\_utility::playerallowhighjump(1);
  maps\mp\_utility::playerallowhighjumpdrop(1);
  maps\mp\_utility::playerallowboostjump(1);
  maps\mp\_utility::playerallowpowerslide(1);
  maps\mp\_utility::playerallowdodge(1);
}

disableexo() {
  maps\mp\_utility::playerallowhighjump(0);
  maps\mp\_utility::playerallowhighjumpdrop(0);
  maps\mp\_utility::playerallowboostjump(0);
  maps\mp\_utility::playerallowpowerslide(0);
  maps\mp\_utility::playerallowdodge(0);
}

setshallowwaterweapon(var_0) {
  level.shallow_water_weapon = var_0;
}

setdeepwaterweapon(var_0) {
  level.deep_water_weapon = var_0;
}

isvalidunderwaterweapon(var_0) {
  switch (var_0) {
    case "none":
    case "iw5_underwater_mp":
    case "iw5_combatknife_mp":
      return 1;
    default:
      return 0;
  }
}