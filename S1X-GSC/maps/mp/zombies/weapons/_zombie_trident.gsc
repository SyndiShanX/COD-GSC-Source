/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_trident.gsc
*******************************************************/

init() {
  if(!isDefined(level.onzombiespawnfuncs)) {
    level.onzombiespawnfuncs = [];
  }

  level.onzombiespawnfuncs[level.onzombiespawnfuncs.size] = ::onzombiespawn;
  level._effect["trident_trail_green"] = loadfx("vfx/trail/trail_trident_green");
  level._effect["trident_trail_purple"] = loadfx("vfx/trail/trail_trident_purple");
  level.trident = spawnStruct();
  level.trident.attractorstrength = 1000;
  level.trident.attractordist = 300;
  level.trident.name = "iw5_tridentzm_mp";
  level.trident.maxdist = 5000;
  level.trident.movespeed = 1300;
  level.trident.startoffset = (30, 0, 0);
  level.trident.hipfireangles = (2, 2, 0);
  level.trident.damage = 1200;
  level.trident.lifetime = 2500;
  level.trident.impulseradius = 30;
  level.trident.impulseforce = 10;
  level.trident.smartdot = 0.75;
  level.trident.smartdist = 1500;
  level.trident.penetratecount = 5;
  level.trident.trailfxlist = common_scripts\utility::array_randomize(["trident_trail_green", "trident_trail_purple"]);
  level.trident.trailfxindex = 0;
  level.trident.sqsmartdot = 0.8;

  if(level.currentgen) {
    level.trident.lifetime = 1750;
  }

  level.modifyweapondamage[level.trident.name] = ::tridentmodifydamage;
}

onplayerspawn() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self notify("onPlayerSpawnTrident");
  self endon("onPlayerSpawnTrident");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);
    var_2 = getweaponbasename(var_1);

    if(var_2 != level.trident.name) {
      continue;
    }
    var_0 delete();
    thread firetrident();
  }
}

tridentmodifydamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return int(level.trident.damage);
}

onzombiespawn() {
  self endon("death");

  for(;;) {
    waittillframeend;
    self.prevorigin = self.origin;
    waitframe();
  }
}

addattractor() {
  var_0 = missile_createattractorent(self, level.tridentdata.attractorstrength, level.tridentdata.attractordist, undefined, undefined, (0, 0, 35));
  self waittill("death");
  missile_deleteattractor(var_0);
}

firetrident() {
  var_0 = self playerads();
  var_1 = self getangles();
  var_2 = (var_1[0], var_1[1], 0);
  var_3 = randomfloatrange(-1.0, 1.0) * (1.0 - var_0);
  var_4 = randomfloatrange(-1.0, 1.0) * (1.0 - var_0);
  var_5 = var_2 + (level.trident.hipfireangles[0] * var_3, level.trident.hipfireangles[1] * var_4, 0);
  var_6 = anglesToForward(var_5);
  var_7 = self getvieworigin();
  var_8 = var_7 + self getvelocity() * 0.05 + rotatevector(level.trident.startoffset, var_2);
  var_9 = tridentgetprojectileent(var_8, self.angles);
  var_10 = level.trident.maxdist / level.trident.movespeed;
  var_9 moveto(var_7 + var_6 * level.trident.maxdist, var_10);
  var_11 = var_7;
  var_12 = var_8 + level.trident.movespeed * 0.05 * var_6;
  var_13 = self;
  var_14 = undefined;
  var_15 = level.trident.penetratecount;

  for(var_16 = gettime() + level.trident.lifetime; gettime() < var_16; var_12 = var_11 + level.trident.movespeed * 0.05 * var_6) {
    for(;;) {
      var_17 = bulletTrace(var_11, var_12, 1, var_13, 0, 1, 0, 0, 1, 0, 0);

      if(isDefined(var_17["glass"])) {
        destroyglass(var_17["glass"], var_6);
        continue;
      }

      if(var_17["fraction"] < 1) {
        var_18 = 1;
        var_19 = var_17["normal"];
        var_20 = var_17["position"] + var_19;
        var_21 = var_17["entity"];
        var_22 = 0;

        if(isDefined(var_21)) {
          tridentdamageent(var_21, var_20, var_6, var_17["hitLoc"]);
          var_22 = isagent(var_21);
        }

        if(var_22) {
          if(var_15 > 0) {
            var_13 = var_21;
            var_11 = var_20;
            var_15--;
            continue;
          }
        } else {
          var_15 = 0;
        }

        var_9.origin = var_20;
        var_23 = vectordot(var_19, var_6);
        var_6 = -2.0 * var_23 * var_19 + var_6;

        if(var_18) {
          var_24 = var_6;
          var_25 = level.trident.smartdot;
          var_26 = var_25;
          var_27 = undefined;
          var_28 = level.characters;

          if(isDefined(level.bossozstage1) && isDefined(level.bossozstage1.damagecallback)) {
            var_28[var_28.size] = level.bossozstage1;
          }

          var_29 = [level.ammodrone, level.ammodrone2];

          foreach(var_31 in var_29) {
            if(!isDefined(var_31)) {
              continue;
            }
            var_28[var_28.size] = var_31;
          }

          foreach(var_34 in var_28) {
            if(isplayer(var_34)) {
              continue;
            }
            if(!isalive(var_34)) {
              continue;
            }
            if(isDefined(var_34.team) && var_34.team == self.team) {
              continue;
            }
            if(isDefined(var_14) && var_14 == var_34) {
              continue;
            }
            var_35 = var_34.origin;

            if(isDefined(var_34.agent_type) && var_34.agent_type == "zombie_dog") {
              var_35 = var_35 + (0, 0, 15);
            } else if(var_34 maps\mp\agents\humanoid\_humanoid_util::iscrawling()) {
              var_35 = var_35 + (0, 0, 5);
            } else {
              var_35 = var_35 + (0, 0, 40);
            }

            var_36 = (0, 0, 0);

            if(isDefined(var_34.prevorigin)) {
              var_36 = (var_34.origin - var_34.prevorigin) * 20;
            }

            if(distance(var_35, var_20) > level.trident.smartdist) {
              continue;
            }
            var_37 = calculateintersectdirection(var_35, var_36, var_20, level.trident.movespeed);
            var_23 = vectordot(var_24, var_37);

            if(var_23 > var_26) {
              var_38 = bulletTrace(var_20, var_35, 0, var_13, 0, 0, 0, 0, 0, 0, 0);

              if(var_38["fraction"] >= 1 || isDefined(var_38["entity"]) && var_38["entity"] == var_34) {
                var_26 = var_23;
                var_6 = var_37;
                var_27 = var_34;
              }
            }
          }

          var_14 = var_27;
        }

        var_9 playSound("wpn_trident_bounce_snap");
        var_10 = level.trident.maxdist / level.trident.movespeed;
        var_9 moveto(var_9.origin + var_6 * level.trident.maxdist, var_10);
      }

      break;
    }

    waitframe();

    if(!isDefined(self)) {
      break;
    }

    var_11 = var_9.origin;
  }

  tridentreleaseprojectileent(var_9);
}

calculateintersectdirection(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_0 - var_2);
  var_5 = vectordot(var_4, var_1);
  var_6 = var_4 * var_5;
  var_7 = var_1 - var_6;
  var_8 = length(var_7);
  var_9 = var_7;

  if(var_8 <= var_3) {
    var_10 = var_4 * sqrt(var_3 * var_3 - var_8 * var_8);
    var_9 = var_10 + var_7;
  }

  var_9 = vectornormalize(var_9);
  return var_9;
}

tridentdamageent(var_0, var_1, var_2, var_3) {
  if(!isalive(var_0)) {
    return;
  }
  if(isplayer(var_0)) {
    return;
  }
  if(isagent(var_0)) {
    var_0.ragdollimmediately = 1;
    var_0 dodamage(level.trident.damage, var_1, self, self, "MOD_PROJECTILE", level.trident.name, var_3);
    var_0.ragdollimmediately = 0;
    level thread tridentphysicsexplosion(var_1);
  } else {
    var_0 dodamage(level.trident.damage, var_1, self, self, "MOD_PROJECTILE", level.trident.name);
    return;
  }
}

tridentphysicsexplosion(var_0) {
  wait 0.1;
  physicsexplosionsphere(var_0, level.trident.impulseradius, 0, level.trident.impulseforce, 0);
}

tridentgetprojectileent(var_0, var_1) {
  var_2 = undefined;
  var_3 = getEntArray("trident_projectile", "targetname");

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.inuse) || !var_5.inuse) {
      var_2 = var_5;
      var_2 dontinterpolate();
      var_2 show();
      break;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = spawn("script_model", var_0);
    var_2.targetname = "trident_projectile";
  }

  var_2 setModel("tag_origin");
  var_2 setcontents(0);
  var_2.origin = var_0;
  var_2.angles = var_1;

  if(!isDefined(self.tridentfx)) {
    self.tridentfx = level.trident.trailfxlist[level.trident.trailfxindex % level.trident.trailfxlist.size];
    level.trident.trailfxindex++;
  }

  var_2.fxname = self.tridentfx;
  var_2.fxtag = "tag_origin";
  playFXOnTag(common_scripts\utility::getfx(var_2.fxname), var_2, var_2.fxtag);
  var_2 playLoopSound("wpn_trident_prj_loop");
  var_2.inuse = 1;
  return var_2;
}

tridentreleaseprojectileent(var_0) {
  var_0 setModel("tag_origin");
  var_0 notify("released");
  stopFXOnTag(common_scripts\utility::getfx(var_0.fxname), var_0, var_0.fxtag);
  var_0 stoploopsound("wpn_trident_prj_loop");
  wait 1.0;
  var_0.inuse = 0;
}