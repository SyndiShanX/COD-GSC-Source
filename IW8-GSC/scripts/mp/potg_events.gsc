/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\potg_events.gsc
***********************************************/

function init() {
  if(!level.potgenabled) {
    return;
  }

  level.potgglobals.eventdata = spawnStruct();
  var0 = level.potgglobals.eventdata;
  var0.lastkillearner = undefined;
  var0.lastkilltime = undefined;

  if(level.teambased) {
    var0.lastteamkillearners = [];
    var0.lastteamkilltimes = [];
  }
}

function onpotgrecordingstopped() {
  clearshotgroup();
}

function getentityeventdata() {
  var0 = scripts\mp\potg::getentitypotgdata(self);

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var0.trackingdata)) {
    var0.trackingdata = createentityeventdata();
  }

  return var0.trackingdata;
}

function createentityeventdata() {
  var0 = spawnStruct();
  var0.shotgroupactive = 0;
  var0.shotgroupcount = 0;
  var0.shotgroupaccuracy = 0;
  var0.shotgrouplastcount = 0;
  var0.shotgrouplastaccuracy = 0;
  return var0;
}

function onroundended(var0) {
  var1 = level.potgglobals.eventdata;
  handlefinalkill(var0);
}

function handlefinalkill(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = level.potgglobals.eventdata;
  var2 = undefined;
  var3 = undefined;

  if(level.teambased) {
    if(isDefined(var1.lastteamkillearners[var0])) {
      var2 = var1.lastteamkillearners[var0];
      var3 = var1.lastteamkilltimes[var0];
    } else {
      var2 = var1.lastkillearner;
      var3 = var1.lastkilltime;
    }
  } else {
    var2 = var1.lastkillearner;
    var3 = var1.lastkilltime;
  }

  if(isDefined(var2) && isDefined(var3)) {
    var2 scripts\mp\potg::processevent("final_kill", var3);
    return;
  }
}

function onplayerdamaged(var0, var1, var2) {
  if(!level.potgenabled) {
    return;
  }

  if(scripts\common\utility::getdamagetype(var2) == "splash" && !var1 scripts\mp\utility\game::isspawnprotected()) {
    var1 scripts\mp\potg::processevent("hit_by_explosive");
    return;
  }
}

function onplayerkilled(var0, var1, var2, var3, var4, var5) {
  if(!level.potgenabled) {
    return;
  }

  var6 = level.potgglobals.eventdata;
  var7 = gettime();

  if(!isPlayer(var0)) {
    return;
  }

  var8 = getentityeventdata(var0);
  var9 = getentityeventdata(var2);
  var10 = calckillmultiplier(var0, var0);
  var11 = var3 == "MOD_EXPLOSIVE" || var3 == "MOD_GRENADE" || var3 == "MOD_GRENADE_SPLASH" || var3 == "MOD_PROJECTILE";
  var12 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1);
  var13 = physics_raycast(var0 getEye(), var2 getEye(), var12, undefined, 0, "physicsquery_closest", 1);
  var14 = isDefined(var13) && var13.size > 0;
  var15 = scripts\engine\utility::within_fov(var0 getEye(), var0 getplayerangles(), var2.origin, cos(80));
  var16 = var4.basename == "iw8_la_juliet_mp";
  var17 = (var16 || var11) && (!var15 || var14);

  if(!var17) {
    var0 scripts\mp\potg::processevent("kill", var7, var7, var5, undefined, var10);
  }

  if(isDefined(self.prevlastkilltime) && isDefined(var0.lastspawntime)) {
    if(var0.lastspawntime < self.prevlastkilltime) {
      var18 = var7 - self.prevlastkilltime;

      if(var18 < 1800) {
        var19 = 1 - var18 / 1800;
        var0 scripts\mp\potg::processevent("kill_rate_bonus", self.prevlastkilltime, var7, var5, undefined, var19);
      }
    }
  }

  handlekillmodifiers(var0, var0, var3, var4, var2, var10, var5);

  if(var3 == "MOD_PROJECTILE_SPLASH" && !var16) {
    var0 scripts\mp\potg::processevent("missile_splash_kill", var7, var7, var5, undefined, var10);
  }

  if(scripts\common\utility::getdamagetype(var3) == "splash") {
    if(scripts\mp\utility\game::gettimepassed() <= 12000 && randomintrange(0, 2) == 0) {
      var0 scripts\mp\potg::processevent("round_start_grenade");
    }
  }

  if(istrue(var0.modifiers["bullet_damage"]) && var2 scripts\mp\equipment\molotov::molotov_is_burning()) {
    var0 scripts\mp\potg::processevent("victim_on_fire", var7, var7, var5, undefined, var10);
  }

  if(var0 scripts\mp\equipment\molotov::molotov_is_burning()) {
    var0 scripts\mp\potg::processevent("kill_while_on_fire", var7, var7, var5, undefined, var10);
  }

  if(istrue(var0.modifiers["airborne"])) {
    var8.lastinairkilltime = var7;
    var8.inairsincelastkill = 1;
    thread watchforpostkilllanding();
  }

  if(isDefined(var0.lastdooropentime) && var7 - var0.lastdooropentime < 3500) {
    var0 scripts\mp\potg::processevent("open_door_before_kill", var0.lastdooropentime, var7, var5, undefined, var10);
  }

  if(isDefined(var0.attackerdata) && var0.attackerdata.size > 3) {
    var0 scripts\mp\potg::processevent("outnumbered", var7, var7, var5, undefined, var10);
  }

  if(isDefined(var9.lastteabagtime) && var7 - var9.lastteabagtime < 1000 && randomintrange(0, 2) == 0) {
    var0 scripts\mp\potg::processevent("kill_teabagger", var9.lastteabagtime, var7, var5, undefined, var10);
  }

  handleequipmentkills(var0, var0, var1, var2, var3, var4, var10);
  handlemeleekills(var0, var0, var1, var2, var3, var4, var10, var5);

  if(var8.shotgroupactive) {
    if(var8.shotgroupaccuracy >= 0.9) {
      var0 scripts\mp\potg::processevent("accuracy_good", var7, var7, var5, undefined, var10);
    } else if(var8.shotgroupaccuracy <= 0.075) {
      var0 scripts\mp\potg::processevent("accuracy_very_bad", var7, var7, var5, undefined, var10);
    } else if(var8.shotgroupaccuracy <= 0.15) {
      var0 scripts\mp\potg::processevent("accuracy_bad", var7, var7, var5, undefined, var10);
    }
  }

  if(level.teambased) {
    var6.lastteamkillearners[var0.team] = var0;
    var6.lastteamkilltimes[var0.team] = var7;
  }

  var6.lastkillearner = var0;
  var6.lastkilltime = var7;
}

function calckillmultiplier(var0) {
  var1 = 1;

  if(!istrue(var0.modifiers["victim_in_standard_view"])) {
    var1 *= 0.15;
  }

  return var1;
}

function handlemeleekills(var0, var1, var2, var3, var4, var5, var6) {
  if(var3 == "MOD_MELEE") {
    if(isDefined(var0.lastspawntime)) {
      var7 = isDefined(var0.lastshotfiredtime) && var0.lastshotfiredtime >= var0.lastspawntime;

      if(!var7) {
        var0 scripts\mp\potg::processevent("no_shots_fired_kill", undefined, undefined, var6, undefined, var5);
        return;
      }

      return;
    }

    return;
  }
}

function handleequipmentkills(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var1) && istrue(var1.isequipment) || scripts\mp\utility\weapon::validatefuelstability(var4, var1)) {
    var6 = scripts\mp\utility\weapon::isthrowingknife(var4) || scripts\mp\utility\weapon::validatefuelstability(var4, var1);

    if(isDefined(var1.spawnpos)) {
      var7 = distancesquared(var1.spawnpos, var1.origin);

      if(var6) {
        if(var7 >= 640000) {
          var0 scripts\mp\potg::processevent("long_throwing_knife");
        } else {
          var0 scripts\mp\potg::processevent("throwing_knife");
        }
      } else if(var7 >= 1440000) {
        var0 scripts\mp\potg::processevent("long_grenade_throw");
      }
    }

    if(scripts\mp\utility\game::gettimepassed() <= 12000) {
      if(var6 && level.mapname != "mp_shipment") {
        var0 scripts\mp\potg::processevent("round_start_throwing_knife");
        return;
      }

      return;
    }

    return;
  }
}

function handlekillmodifiers(var0, var1, var2, var3, var4, var5) {
  var6 = gettime();
  var7 = scripts\mp\utility\weapon::getweapongroup(var2);

  foreach(var10, var9 in var0.modifiers) {
    switch (var10) {
      case "backstab":
        if(var1 == "MOD_MELEE") {
          var0 scripts\mp\potg::processevent("backstab", var6, var6, var5, undefined, var4);
        }

        break;
      case "pointblank":
        if(var7 == "weapon_sniper") {
          var0 scripts\mp\potg::processevent("pointblank_sniper", var6, var6, var5, undefined, var4);
        } else {
          var0 scripts\mp\potg::processevent("pointblank", var6, var6, var5, undefined, var4);
        }

        break;
      case "airborne":
        if(isDefined(var0.modifiers["ads"])) {
          if(var7 == "weapon_sniper") {
            var0 scripts\mp\potg::processevent("airborne_ads_sniper_kill", var6, var6, var5, undefined, var4);
          } else {
            var0 scripts\mp\potg::processevent("airborne_ads_kill", var6, var6, var5, undefined, var4);
          }
        }

        break;
      case "victim_airborne":
        if(var7 == "weapon_sniper") {
          var0 scripts\mp\potg::processevent("victim_airborne_sniper", var6, var6, var5, undefined, var4);
        } else {
          var0 scripts\mp\potg::processevent("victim_airborne", var6, var6, var5, undefined, var4);
        }

        break;
      case "longshot":
        if(!isDefined(var0.modifiers["very_longshot"])) {
          var0 scripts\mp\potg::processevent("longshot", var6, var6, var5, undefined, var4);
        }

        break;
      case "last_bullet_kill":
        if(var7 != "weapon_sniper" && var7 != "weapon_projectile") {
          var0 scripts\mp\potg::processevent("last_bullet_kill", var6, var6, var5, undefined, var4);
        }

        break;
      case "victim_sprinting":
        if(var7 == "weapon_sniper") {
          var0 scripts\mp\potg::processevent("victim_sprinting_sniper", var6, var6, var5, undefined, var4);
        }

        break;
      default:
        if(scripts\mp\potg::eventtable_isevent(var10)) {
          var0 scripts\mp\potg::processevent(var10, var6, var6, var5, undefined, var4);
        }

        break;
    }
  }
}

function collateral(var0, var1) {
  if(!level.potgenabled) {
    return;
  }

  if(var1 == 2) {
    var0 scripts\mp\potg::processevent("collateral");
    return;
  }

  if(var1 == 3) {
    var0 scripts\mp\potg::processevent("triple_collateral");
    return;
  }

  var0 scripts\mp\potg::processevent("multi_collateral");
}

function shotguncollateral(var0, var1) {
  if(!level.potgenabled) {
    return;
  }

  if(var1 == 2) {
    var0 scripts\mp\potg::processevent("shotgun_collateral");
    return;
  }

  var0 scripts\mp\potg::processevent("shotgun_multi_collateral");
}

function quadfeed(var0, var1, var2) {
  if(!level.potgenabled) {
    return;
  }

  var0 scripts\mp\potg::processevent("quad_feed", var1, var2);
}

function processeventforwitnesses(var0, var1, var2, var3, var4) {
  var5 = scripts\common\utility::playersnear(var0, 1000);

  foreach(var7 in var5) {
    if(!scripts\mp\utility\player::isreallyalive(var7)) {
      continue;
    }

    var8 = var0 - var7 getEye();
    var9 = anglesToForward(var7 getplayerangles());

    if(vectordot(var8, var9) < 0) {
      continue;
    }

    var7 scripts\mp\potg::processevent(var2, var3, var4);
  }
}

function watchforpostkilllanding() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var0 = getentityeventdata();

  for(;;) {
    if(self isonground()) {
      var0.inairsincelastkill = 0;
      break;
    }

    waitframe();
  }
}

function predatormissileimpact(var0) {
  if(!level.potgenabled) {
    return;
  }

  processeventforwitnesses(var0, 1000000, "witness_predator_impact");
}

function largevehicleexplosion(var0) {
  if(!level.potgenabled) {
    return;
  }

  processeventforwitnesses(var0, 640000, "witness_vehicle_explode");
}

function vehiclekilled(var0) {
  if(!level.potgenabled) {
    return;
  }

  if(!isDefined(var0.attacker) || !isPlayer(var0.attacker)) {
    return;
  }

  var0.attacker scripts\mp\potg::processevent("vehicle_destroyed");
}

function missilewhizby(var0) {
  if(!level.potgenabled) {
    return;
  }

  var0 scripts\mp\potg::processevent("witness_missile_whizby");
}

function bombdefused(var0, var1, var2) {
  if(!level.potgenabled) {
    return;
  }

  if(var2) {
    var0 scripts\mp\potg::processevent("ninja_defuse");
    return;
  }

  if(var1) {
    var0 scripts\mp\potg::processevent("last_alive_defuse");
    return;
  }

  var0 scripts\mp\potg::processevent("defuse");
}

function revivedplayer(var0, var1) {
  if(!level.potgenabled) {
    return;
  }

  var0 scripts\mp\potg::processevent("revived_ally");
}

function playerworlddeath(var0, var1) {
  if(!level.potgenabled) {
    return;
  }

  var2 = getentityeventdata();

  if(istrue(var2.inairsincelastkill)) {
    var0 scripts\mp\potg::processevent("fall_to_death_kill", var2.lastinairkilltime, gettime());
    return;
  }
}

function doorused(var0, var1) {
  if(!level.potgenabled) {
    return;
  }

  if(!var1 && isDefined(var0.lastkilltime) && gettime() - var0.lastkilltime < 2000) {
    var0 scripts\mp\potg::processevent("closed_door_after_kill");
    return;
  }
}

function playerstancechanged(var0) {
  if(!level.potgenabled || !(isDefined(self.petwatch) && self.petwatch.ref_12314 == "pet_turbo")) {
    return;
  }

  var1 = getentityeventdata();
  var2 = gettime();

  if(var0 == "crouch") {
    scripts\mp\potg::processevent("recent_crouch");

    if(isDefined(self.lastkillvictimpos)) {
      if(distancesquared(self.lastkillvictimpos, self.origin) < 40000) {
        var3 = var2 - self.laststancetimes["crouch"];

        if(var3 < 750) {
          var4 = isDefined(self.lastspawntime) && isDefined(var1.lastteabagtime) && self.lastspawntime < var1.lastteabagtime;

          if(!var4) {
            scripts\mp\potg::processevent("teabag");
          }

          if(!isDefined(var1.lastteabagtime) || var2 - var1.lastteabagtime > 5000) {
            if(!isDefined(self.pers["teaBags"])) {
              self.pers["teaBags"] = 0;
            }

            self.pers["teaBags"]++;
            scripts\cp_mp\pet_watch::bearwatch();
          }

          var1.lastteabagtime = var2;
          return;
        }

        return;
      }

      return;
    }

    return;
  }

  if(var2 == "prone") {
    scripts\mp\potg::processevent("recent_prone");
    return;
  }
}

function shothit() {
  if(!level.potgenabled) {
    return;
  }

  var0 = getentityeventdata();
  updateshotgroup(1);
}

function shotmissed() {
  if(!level.potgenabled) {
    return;
  }

  var0 = getentityeventdata();
  updateshotgroup(0);
}

function updateshotgroup(var0) {
  if(!level.potgenabled) {
    return;
  }

  var1 = getentityeventdata();
  var2 = scripts\engine\utility::ter_op(var0, 1, 0);
  var1.shotgroupaccuracy = (var1.shotgroupaccuracy * var1.shotgroupcount + var2) / (var1.shotgroupcount + 1);
  var1.shotgroupcount++;
  thread shotgroupendwatcher();
}

function shotgroupendwatcher() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("clearShotGroup");
  self notify("shotGroupEndWatcher()");
  self endon("shotGroupEndWatcher()");

  if(!level.potgenabled) {
    return;
  }

  var0 = getentityeventdata();
  var0.shotgroupactive = 1;
  wait 2;
  clearshotgroup();
}

function clearshotgroup() {
  if(!level.potgenabled) {
    return;
  }

  var0 = getentityeventdata();
  var0.shotgroupactive = 0;
  var0.shotgrouplastcount = var0.shotgroupcount;
  var0.shotgrouplastaccuracy = var0.shotgroupaccuracy;
  var0.shotgroupcount = 0;
  var0.shotgroupaccuracy = 0;
  self notify("clearShotGroup");
}

function grenadethrownevent(var0) {
  if(!level.potgenabled) {
    return;
  }

  if(var0) {
    scripts\mp\potg::processevent("recent_lethal");
    return;
  }

  scripts\mp\potg::processevent("recent_tactical");
}

function crouch() {
  if(!level.potgenabled) {
    return;
  }

  scripts\mp\potg::processevent("recent_crouch");
}

function jump() {
  if(!level.potgenabled) {
    return;
  }

  scripts\mp\potg::processevent("recent_jump");
}

function prone() {
  if(!level.potgenabled) {
    return;
  }

  scripts\mp\potg::processevent("recent_prone");
}

function slide() {
  if(!level.potgenabled) {
    return;
  }

  scripts\mp\potg::processevent("recent_slide");
}

function mantle() {
  if(!level.potgenabled) {
    return;
  }

  scripts\mp\potg::processevent("recent_mantle");
}