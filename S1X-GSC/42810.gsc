/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42810.gsc
**************************************/

watchexplosivegelusage() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "explosive_gel_mp") {
      if(!isalive(self)) {
        var_0 delete();
        return;
      }

      thread tryuseexplosivegel(var_0);
    }
  }
}

init() {
  precachemodel("weapon_c4");
  precachemodel("weapon_c4_bombsquad");
  level.explosivegelsettings = spawnStruct();
  level.explosivegelsettings.stuckmesh = "weapon_c4";
  level.explosivegelsettings.gelbombsquadmesh = "weapon_c4_bombsquad";
  level.explosivegelsettings.gelexplosionfx = loadfx("vfx/explosion/frag_grenade_default");
  level.explosivegelsettings.beacon["enemy"] = loadfx("vfx/lights/light_c4_blink");
  level.explosivegelsettings.beacon["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
}

tryuseexplosivegel(var_0) {
  thread launchexplosivegel(var_0);
  return 1;
}

launchexplosivegel(var_0) {
  thread watchexplosivegelaltdetonate(var_0);
  var_1 = stickexplosivegel(var_0);
}

watchexplosivegelaltdetonate(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("change_owner");
  var_0 endon("missile_stuck");
  var_0 endon("death");
  var_1 = 0;

  for(;;) {
    if(self usebuttonpressed()) {
      var_1 = 0;

      while(self usebuttonpressed()) {
        var_1 = var_1 + 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }
      var_1 = 0;

      while(!self usebuttonpressed() && var_1 < 0.5) {
        var_1 = var_1 + 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }
      thread earlydetonate(var_0);
    }

    wait 0.05;
  }
}

stickexplosivegel(var_0) {
  self endon("earlyNotify");
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
  var_9 setModel(level.explosivegelsettings.stuckmesh);
  var_9.owner = self;
  var_9 setotherent(self);
  var_9.killcamoffset = (0, 0, 55);
  var_9.killcament = spawn("script_model", var_9.origin + var_9.killcamoffset);
  var_9.stunned = 0;
  var_9.weaponname = "explosive_gel_mp";
  var_0 delete();
  level.mines[level.mines.size] = var_9;
  var_9 thread createbombsquadmodel(level.explosivegelsettings.gelbombsquadmesh, "tag_origin", self);
  var_9 thread minebeacon();
  var_9 thread setexplosivegelteamheadicon(self.team);
  var_9 thread minedamagemonitor();
  var_9 thread explosivegelcountdowndetonation(self);
  return var_9;
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
  var_0["friendly"] = spawnfx(level.explosivegelsettings.beacon["friendly"], self gettagorigin("tag_fx"));
  var_0["enemy"] = spawnfx(level.explosivegelsettings.beacon["enemy"], self gettagorigin("tag_fx"));
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

setexplosivegelteamheadicon(var_0) {
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
  playFX(level.explosivegelsettings.gelexplosionfx, var_1);
  wait 0.05;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self hide();
  self radiusdamage(self.origin, 192, 100, 100, var_0, "MOD_EXPLOSIVE");

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

earlydetonate(var_0) {
  self notify("earlyNotify");
  var_1 = var_0 gettagorigin("tag_fx");
  playFX(level.explosivegelsettings.gelexplosionfx, var_1);
  var_0 detonate();
}

apm_mine_deletekillcament() {
  wait 3;
  self.killcament delete();
  self delete();
  level.mines = common_scripts\utility::array_removeundefined(level.mines);
}

explosivegelcountdowndetonation(var_0) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait 3;
  self notify("mine_triggered");
  thread mineexplode();
}