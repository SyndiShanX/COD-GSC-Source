/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42841.gsc
**************************************/

watchtridroneusage() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  tridroneammoinit();

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "tri_drone_mp") {
      if(!isalive(self)) {
        var_0 delete();
        return;
      }

      thread tryusetridrone(var_0);
    }
  }
}

init() {
  precacheshellshock("flashbang_mp");
  precachemodel("projectile_bouncing_betty_grenade_small");
  precachemodel("projectile_bouncing_betty_grenade_small_bombsquad");
  level.tridronesettings = spawnStruct();
  level.tridronesettings.minecountdown = 1;
  level.tridronesettings.blastradius = 132;
  level.tridronesettings.dronebounceheight = 128;
  level.tridronesettings.dronemesh = "projectile_bouncing_betty_grenade_small";
  level.tridronesettings.dronebombsquadmesh = "projectile_bouncing_betty_grenade_small_bombsquad";
  level.tridronesettings.droneexplosionfx = loadfx("vfx/explosion/frag_grenade_default");
  level.tridronesettings.beacon["enemy"] = loadfx("vfx/lights/light_c4_blink");
  level.tridronesettings.beacon["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
  level.tridronesettings.dome = loadfx("vfx/unique/orbital_dome_ground_friendly");
}

tridroneammoinit() {
  if(!isDefined(self.tridroneammo)) {
    self.tridroneammo = 0;
    thread showammocount();
  }

  self.tridroneammo = 0;
  self.tridroneammo = self.tridroneammo + 3;

  if(!isDefined(self.tridronedeployed)) {
    self.tridronedeployed = [];
  }
}

tryusetridrone(var_0) {
  if(self.tridroneammo <= 0) {
    tridroneammoinit();
  }

  if(self.tridroneammo > 0) {
    thread launchtridrone(var_0);
    self.tridroneammo--;

    if(self.tridroneammo >= 1) {
      self giveweapon("tri_drone_mp");
    }
  }

  return 1;
}

launchtridrone(var_0) {
  var_1 = spawnmine(var_0);
  self.tridronedeployed = common_scripts\utility::array_add(self.tridronedeployed, var_1);
  thread monitorplayerdeath(var_1);
}

activategroupedtridrones(var_0) {
  self endon("death");

  foreach(var_2 in var_0.tridronedeployed) {
    if(isDefined(var_2)) {
      if(var_2 != self) {
        var_2.trigger notify("trigger");
        wait 0.25;
      }
    }
  }
}

removegroupedtridrone() {
  self.owner.tridronedeployed = common_scripts\utility::array_remove(self.owner.tridronedeployed, self);
}

monitorplayerdeath(var_0) {
  var_0 endon("death");
  self waittill("death");
  self.tridroneammo = 0;

  if(isDefined(var_0.pickuptrigger)) {
    var_0.pickuptrigger delete();
  }

  var_0 delete();
}

spawnmine(var_0) {
  var_0 waittill("missile_stuck");
  var_1 = bulletTrace(var_0.origin, var_0.origin - (0, 0, 4), 0, var_0);
  var_2 = bulletTrace(var_0.origin, var_0.origin + (0, 0, 4), 0, var_0);
  var_3 = anglesToForward(var_0.angles);
  var_4 = bulletTrace(var_0.origin + (0, 0, 4), var_0.origin + var_3 * 4, 0, var_0);
  var_5 = undefined;
  var_6 = 0;
  var_7 = 0;

  if(var_4["surfacetype"] != "none") {
    var_5 = var_4;
    var_7 = 1;
  } else if(var_2["surfacetype"] != "none") {
    var_5 = var_2;
    var_6 = 1;
  } else if(var_1["surfacetype"] != "none") {
    var_5 = var_1;
  } else {
    var_5 = var_1;
  }

  var_8 = var_5["position"];

  if(var_8 == var_2["position"]) {
    var_8 = var_8 + (0, 0, -5);
  }

  var_9 = spawn("script_model", var_8);
  var_9.isup = var_6;
  var_9.isforward = var_7;
  var_10 = vectornormalize(var_5["normal"]);
  var_11 = vectortoangles(var_10);
  var_11 = var_11 + (90, 0, 0);
  var_9.angles = var_11;
  var_9 setModel(level.tridronesettings.dronemesh);
  var_9.owner = self;
  var_9 setotherent(self);
  var_9.killcamoffset = (0, 0, 55);
  var_9.killcament = spawn("script_model", var_9.origin + var_9.killcamoffset);
  var_9.stunned = 0;
  var_9.weaponname = "tri_drone_mp";
  var_0 delete();
  level.mines[level.mines.size] = var_9;
  var_9 thread createbombsquadmodel(level.tridronesettings.dronebombsquadmesh, "tag_origin", self);
  var_9 thread minebeacon();
  var_9 thread settridroneteamheadicon(self.team);
  var_9 thread minedamagemonitor();
  var_9 thread mineproximitytrigger(self);
  var_9 thread mineselfdestruct();
  var_9 thread deletemineonteamswitch(self);
  var_9 thread handleemp(self, "apm_mine");
  return var_9;
}

showdebugradius() {
  var_0["dome"] = spawnfx(level.tridronesettings.dome, self gettagorigin("tag_fx"));
  triggerfx(var_0["dome"]);
  self waittill("death");
  var_0["dome"] delete();
}

showammocount() {
  self endon("disconnect");

  for(;;) {
    if("tri_drone_mp" == self getlethalweapon()) {
      self setclientomnvar("ui_tri_drone_count", self.tridroneammo);
    }

    waitframe();
  }
}

createbombsquadmodel(var_0, var_1, var_2) {
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 hide();
  wait 0.05;
  var_3 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater(var_2);
  var_3 setModel(var_0);
  var_3 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  var_3 setcontents(0);
  self waittill("death");

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  var_3 delete();
}

minebeacon() {
  var_0["friendly"] = spawnfx(level.tridronesettings.beacon["friendly"], self gettagorigin("tag_fx"));
  var_0["enemy"] = spawnfx(level.tridronesettings.beacon["enemy"], self gettagorigin("tag_fx"));
  thread minebeaconteamupdater(var_0);
  self waittill("death");
  var_0["friendly"] delete();
  var_0["enemy"] delete();
}

minebeaconteamupdater(var_0, var_1) {
  self endon("death");
  var_2 = self.owner.team;
  wait 0.05;
  triggerfx(var_0["friendly"]);
  triggerfx(var_0["enemy"]);

  for(;;) {
    var_0["friendly"] hide();
    var_0["enemy"] hide();

    foreach(var_4 in level.players) {
      if(level.teambased) {
        if(var_4.team == var_2) {
          var_0["friendly"] showtoplayer(var_4);
        } else {
          var_0["enemy"] showtoplayer(var_4);
        }

        continue;
      }

      if(var_4 == self.owner) {
        var_0["friendly"] showtoplayer(var_4);
        continue;
      }

      var_0["enemy"] showtoplayer(var_4);
    }

    level common_scripts\utility::waittill_either("joined_team", "player_spawned");
  }
}

settridroneteamheadicon(var_0) {
  self endon("death");
  wait 0.05;

  if(level.teambased) {
    if(self.isup == 1 || self.isforward == 1) {
      maps\mp\_entityheadicons::setteamheadicon(var_0, (0, 0, 28), undefined, 1);
    } else {
      maps\mp\_entityheadicons::setteamheadicon(var_0, (0, 0, 28));
    }
  } else if(isDefined(self.owner)) {
    if(self.isup == 1) {
      maps\mp\_entityheadicons::setplayerheadicon(self.owner, (28, 0, 28));
    } else {
      maps\mp\_entityheadicons::setplayerheadicon(self.owner, (0, 0, 28));
    }
  }
}

minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isplayer(var_0)) {
      continue;
    }
    if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner, var_0)) {
      continue;
    }
    if(isDefined(var_9)) {
      var_10 = maps\mp\_utility::strip_suffix(var_9, "_lefthand");

      switch (var_10) {
        case "smoke_grenade_var_mp":
        case "smoke_grenade_mp":
          continue;
      }
    }

    break;
  }

  self notify("mine_destroyed");
  removegroupedtridrone();

  if(isDefined(var_4) && (issubstr(var_4, "MOD_GRENADE") || issubstr(var_4, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(var_8) && var_8 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;

  if(isplayer(var_0)) {
    var_0 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("bouncing_betty");
  }

  if(level.teambased) {
    if(isDefined(var_0) && isDefined(var_0.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers["team"])) {
      if(var_0.pers["team"] != self.owner.pers["team"]) {
        var_0 notify("destroyed_explosive");
      }
    }
  } else if(isDefined(self.owner) && isDefined(var_0) && var_0 != self.owner) {
    var_0 notify("destroyed_explosive");
  }

  thread mineexplode(var_0);
}

mineexplode(var_0) {
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  self playSound("null");
  var_1 = self gettagorigin("tag_fx");
  playFX(level.tridronesettings.droneexplosionfx, var_1);
  wait 0.05;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self hide();
  self radiusdamage(self.origin, 192, 60, 60, var_0, "MOD_EXPLOSIVE", "bouncingbetty_mp");

  foreach(var_3 in level.players) {
    var_4 = distance(self.origin, var_3.origin);

    if(var_4 < 192) {
      var_3 shellshock("flashbang_mp", 2.5);
    }
  }

  if(isDefined(self.owner) && isDefined(level.leaderdialogonplayer_func)) {
    self.owner thread[[level.leaderdialogonplayer_func]]("mine_destroyed", undefined, undefined, self.origin);
  }

  wait 0.2;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  thread apm_mine_deletekillcament();
  self notify("death");

  if(isDefined(self.pickuptrigger)) {
    self.pickuptrigger delete();
  }

  self hide();
}

apm_mine_deletekillcament() {
  wait 3;
  self.killcament delete();
  self delete();
  level.mines = common_scripts\utility::array_removeundefined(level.mines);
}

equipmentwatchuse() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("change_owner");
  self.pickuptrigger setcursorhint("HINT_NOICON");
  var_0 = self.pickuptrigger.owner;
  equipmentenableuse(var_0);

  for(;;) {
    self.pickuptrigger waittill("trigger", var_0);
    var_0 playlocalsound("scavenger_pack_pickup");
    var_0.tridroneammo++;

    if(var_0.tridroneammo == 1) {
      var_0 giveweapon("tri_drone_mp");
    }

    if(isDefined(self.pickuptrigger)) {
      self.pickuptrigger delete();
    }

    self.killcament delete();
    self delete();
    level.mines = common_scripts\utility::array_removeundefined(level.mines);
  }
}

equipmentenableuse(var_0) {
  self notify("equipmentWatchUse");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self endon("change_owner");
  self.pickuptrigger setcursorhint("HINT_NOICON");
  self.pickuptrigger sethintstring(&"MP_PICKUP_TRI_DRONE");
  self.pickuptrigger maps\mp\_utility::setselfusable(var_0);
}

equipmentdisableuse(var_0) {
  self.trigger sethintstring("");
  self.trigger maps\mp\_utility::setselfunusuable();
}

mineproximitytrigger(var_0) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait 2;
  self.pickuptrigger = spawn("script_origin", self.origin);
  self.pickuptrigger.owner = var_0;
  thread equipmentwatchuse();
  var_1 = spawn("trigger_radius", self.origin + (0, 0, -96), 0, 192, 192);
  var_1.owner = self;
  self.trigger = var_1;
  thread minedeletetrigger(var_1);
  var_2 = undefined;

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(!isDefined(var_2)) {
      break;
    }

    if(getdvarint("scr_minesKillOwner") != 1) {
      if(isDefined(self.owner)) {
        if(var_2 == self.owner) {
          continue;
        }
        if(isDefined(var_2.owner) && var_2.owner == self.owner) {
          continue;
        }
      }

      if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner, var_2, 0)) {
        continue;
      }
    }

    if(lengthsquared(var_2 getentityvelocity()) < 10) {
      continue;
    }
    if(var_2 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  removegroupedtridrone();
  self notify("mine_triggered");
  self playSound("claymore_activated");
  self playSound("mine_betty_spin");
  playFX(level.mine_launch, self.origin);
  var_3 = anglestoup(self.angles);
  var_4 = self.origin + var_3 * 64;
  self moveto(var_4, 0.75, 0, 0.25);
  self.killcament moveto(var_4 + self.killcamoffset, 0.75, 0, 0.25);
  self rotatevelocity((0, 750, 32), 0.7, 0, 0.65);
  thread playspinnerfx();

  if(isplayer(var_2) && var_2 maps\mp\_utility::_hasperk("specialty_class_engineer")) {
    var_2 notify("triggered_mine");
    wait 3;
  } else {
    wait 1;
  }

  thread mineexplode();
}

playspinnerfx() {
  self endon("death");
  var_0 = gettime() + 1000;

  while(gettime() < var_0) {
    wait 0.05;
    playFXOnTag(level.mine_spin, self, "tag_fx_spin1");
    playFXOnTag(level.mine_spin, self, "tag_fx_spin3");
    wait 0.05;
    playFXOnTag(level.mine_spin, self, "tag_fx_spin2");
    playFXOnTag(level.mine_spin, self, "tag_fx_spin4");
  }
}

minedeletetrigger(var_0) {
  common_scripts\utility::waittill_any("mine_triggered", "mine_destroyed", "death");
  var_0 delete();
}

mineselfdestruct() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait 120;
  self notify("mine_selfdestruct");

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  playFX(level._effect["equipment_explode"], self.origin);
  self delete();
}

deletemineonteamswitch(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  self endon("death");
  var_0 waittill("joined_team");
  self delete();
  self notify("death");
}

handleemp(var_0, var_1) {
  self endon("death");

  if(var_0 maps\mp\_utility::isemped()) {
    self notify("death");

    if(var_1 == "apm_mine") {
      playFX(level._effect["equipment_explode"], self.origin);
      self delete();
    }

    return;
  }

  for(;;) {
    level waittill("emp_update");

    if(!var_0 maps\mp\_utility::isemped()) {
      continue;
    }
    if(var_1 == "apm_mine") {
      playFX(level._effect["equipment_explode"], self.origin);
      self delete();
    }

    self notify("death");
  }
}