/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\jackal.gsc
***********************************************/

function beginjackal(var0, var1, var2, var3, var4) {
  if(!isDefined(level.jackals)) {
    level.jackals = [];
  }

  var5 = undefined;

  if(isDefined(var4)) {
    var5 = var4.marker;
    var6 = 2;

    if(!isDefined(var5)) {
      var5 = spawnStruct();

      if(isDefined(var4.location)) {
        var5.location = var4.location;
      } else {
        var5.location = var4.trigger.origin;
      }

      var5.angles = (0, 0, 0);
      var5.string = "equip_deploy_succeeded";
      var5.visual = spawn("script_model", var5.location);
      var5.visual setModel("ks_marker_mp");
      var5.visual setotherent(self);
    }

    if(!isDefined(var5.location)) {
      self notify("cancel_jackal");
      return 0;
    } else if(isDefined(level.jackal_incoming) || level.jackals.size >= var6) {
      if(isDefined(var5.visual)) {
        var5.visual delete();
      }

      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

      if(isDefined(var3.objweapon) && var3.objweapon.basename != "none") {
        self notify("killstreak_finished_with_weapon_" + var3.weaponname);
      }

      self notify("cancel_jackal");
      return 0;
    }
  }

  self notify("called_in_jackal");
  level.jackal_incoming = 1;
  var7 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var7)) {
    var8 = var7.origin[2] + 500;
  } else {
    var8 = 1300;
  }

  if(isDefined(var7) && isDefined(var7.location)) {
    var3 = var7.location;
  }

  var3 *= (1, 1, 0);
  var9 = var3 + (0, 0, var8);
  var10 = spawnksjackal(var1, self, var2, var9, var4, var5);
  var10.tacopslz = var5;
  var11 = var9;
  var12 = var9 + anglestoright(self.angles) * 2000;
  var13 = var9 - anglestoright(self.angles) * 2000;
  var14 = [var11, var12, var13];

  foreach(var16 in var14) {
    if(!jackalcanseelocation(var10, var16)) {
      continue;
    }

    var9 = var16;
    break;
  }

  var10.pathgoal = var9;
  thread defendlocation(var10, var7);
  return var10;
}

function spawnksjackal(var0, var1, var2, var3, var4, var5) {
  var6 = vectortoangles(var3 - var2);
  var7 = 4;
  var8 = 50;
  var9 = 175;
  var10 = 10000;
  var11 = "veh8_mil_air_lbravo";
  var12 = "jackal_turret_mp";
  var13 = "veh_mil_air_ca_dropship_mp_turret";
  var14 = 1;
  var15 = "jackal_cannon_mp";
  var16 = "veh_mil_air_ca_dropship_turret_missile";
  var17 = 1;
  var18 = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
  var19 = "follow_player";

  if(isDefined(var5)) {
    var19 = "guard_location";
  }

  var20 = spawnhelicopter(var1, var2, var6, "veh_airdrop_mp", var11);

  if(!isDefined(var20)) {
    return;
  }

  if(isDefined(var5)) {
    var20.lz = var5;
  }

  thread handledestroydamage();
  var20.damagecallback = &callback_vehicledamage;
  var20.speed = var8;
  var20.accel = var9;
  var20.health = var10;
  var20.maxhealth = var20.health;
  var20.team = var1.team;
  var20.owner = var1;
  var20 setCanDamage(1);
  var20.defendloc = var3;
  var20.lifeid = var0;
  var20.jackal = 1;
  var20.streakinfo = var4;
  var20.streakname = var4.streakname;
  var20.evasivemaneuvers = 0;
  var20.combatmode = var19;
  var20.currentstring = var18;
  var20.streakinfo = var4;
  var20.flaresreservecount = var7;
  var20.turreton = var14;
  var20.turretweapon = var12;
  var20.cannonweapon = var15;
  var20.cannonon = var17;
  var20 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var4.streakname, "Killstreak_Air", var1, 0, 1, 100);
  var20 setmaxpitchroll(0, 90);
  var20 vehicle_setspeed(var20.speed, var20.accel);
  var20 sethoverparams(50, 100, 50);
  var20 setturningability(0.05);
  var20 setyawspeed(45, 25, 25, 0.5);
  var20 setotherent(var1);
  var21 = anglesToForward(var20.angles);

  if(!isDefined(var5)) {
    var20.turret = spawnturret("misc_turret", var20 gettagorigin("tag_origin"), var12);
    var20.turret setModel(var13);
    var20.turret.owner = var1;
    var20.turret.team = var1.team;
    var20.turret.angles = var20.angles;
    var20.turret.type = "Machine_Gun";
    var20.turret.streakinfo = var4;
    var20.turret linkTo(var20, "tag_origin", (200, 0, 55), (0, 0, 0));
    var20.turret setturretmodechangewait(0);
    var20.turret setmode("manual_target");
    var20.turret setsentryowner(var1);
    var20.cannon = spawnturret("misc_turret", var20 gettagorigin("tag_origin"), var15);
    var20.cannon setModel(var16);
    var20.cannon.owner = var1;
    var20.cannon.team = var1.team;
    var20.cannon.angles = var20.angles;
    var20.cannon.type = "Cannon";
    var20.cannon.streakinfo = var4;
    var20.cannon linkTo(var20, "tag_origin", (-100, 0, 55), (0, 0, 0));
    var20.cannon setturretmodechangewait(0);
    var20.cannon setmode("manual_target");
    var20.cannon setsentryowner(var1);
  }

  var20.useobj = spawn("script_model", var20 gettagorigin("tag_origin"));
  var20.useobj linkTo(var20, "tag_origin");
  level.jackals[level.jackals.size] = var20;
  level.jackals = scripts\engine\utility::array_removeundefined(level.jackals);
  level.jackal_incoming = undefined;

  if(isDefined(var5)) {
    var20 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  }

  thread jackaldestroyed();
  thread delayjackalloopsfx(var20, 0.05);
  thread delay_jackal_arrive_sfx();

  if(!isDefined(var5)) {
    var20.turret.vehicle_fired_from = var20;
    var20.cannon.vehicle_fired_from = var20;
    var20.turret.vehicle_fired_from.killcament = spawn("script_model", var20 gettagorigin("tag_origin"));
    var20.turret.vehicle_fired_from.killcament linkTo(var20, "tag_origin");
    var20.cannon.vehicle_fired_from.killcament = var20.turret.vehicle_fired_from.killcament;
  }

  var22 = anglesToForward(var20.angles);
  return var20;
}

function getnumownedjackals(var0) {
  var1 = 0;
  jumpiffalse(level.teambased) LOC_00000055;

  foreach(var3 in level.jackals) {
    if(var3.team != var0.team) {
      continue;
    }

    var1++;
  }

  goto LOC_00000091;
}

function delay_jackal_arrive_sfx() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
}

function delayjackalloopsfx(var0, var1) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);
  self playLoopSound(var1);
}

function defendlocation(var0, var1) {
  var0 endon("death");
  var0 setvehgoalpos(var0.pathgoal, 1);
  thread closetogoalcheck(var0);
  thread monitorowner();

  if(isDefined(var0.dropcrates)) {
    thread watchdropcratesearly(var0);
  }

  var0 waittill("goal");

  if(isDefined(var1) && isDefined(var0.lz)) {
    thread jackaltimer();
    thread watchgameendleave();
    thread engageprimarytarget();
    var0.speed = 250;
    var0 vehicle_setspeed(50, 15);
    jackalmovetolocation(var0, var1.location);
    var0 waittill("extract_hostages");
    thread jackalleave(var0, 50);
  } else if(isDefined(var1) && isDefined(var0.dropcrates)) {
    thread jackaltimer();
    thread watchgameendleave();
    thread engageprimarytarget();
    thread engagesecondarytarget();
    var0 vehicle_setspeed(50, 15);
    jackalmovetolocation(var0, var1.location);
    thread dropcrates(var0, var0.dropcrates);
    thread watchjackalcratepickup();
    var0 scripts\engine\utility::ref_143b9(10, "all_crates_gone");
    var0.combatmode = "follow_player";
  } else {
    thread jackaltimer();
    thread watchgameendleave();
    thread engageprimarytarget();
    thread engagesecondarytarget();
    var0 vehicle_setspeed(int(var0.speed / 14), int(var0.accel / 16));
  }

  if(!isDefined(var0.lz)) {
    var0.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(var0.owner, var0.currentstring, 360, 360, 30000, 30000, 2);
    thread patrolfield();
    thread watchmodechange(var0, getothermode(var0.combatmode));
    return;
  }
}

function engageprimarytarget() {
  self notify("engagePrimary");
  self endon("engagePrimary");
  self endon("leaving");
  self endon("death");
  self.lastaction = undefined;

  if(istrue(self.turreton)) {
    for(;;) {
      var0 = jackalgettargets();

      if(isDefined(var0) && var0.size > 0) {
        acquireturrettarget(var0);
        self.turret waittill("stop_firing");

        if(self.combatmode == "follow_player") {
          thread patrolfield();
        }
      } else {
        self.lastaction = "noTargetsFound";
      }

      wait 0.05;
    }

    return;
  }
}

function engagesecondarytarget() {
  self notify("engageSecondary");
  self endon("engageSecondary");
  self endon("leaving");
  self endon("death");
  var0 = weaponfiretime(self.cannonweapon);

  if(istrue(self.cannonon)) {
    for(;;) {
      var1 = jackalgettargets();

      if(!isDefined(var1) || var1.size < 2) {
        waitframe();
        continue;
      }

      acquirecannontarget(var1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);
    }

    return;
  }
}

function followplayer() {
  self endon("death");
  self endon("leaving");
  self endon("guard_location");
  self endon("priority_target");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self notify("following_player");
  self vehicle_setspeed(50, 15);

  for(;;) {
    var0 = undefined;

    if(istrue(self.evasivemaneuvers)) {
      var1 = self.owner.origin[0];
      var2 = self.owner.origin[1];
      var3 = var1 + randomintrange(-500, 500);
      var4 = var2 + randomintrange(-500, 500);
      var5 = getcorrectheight(var3, var4, 350);
      var0 = (var3, var4, var5);
    } else {
      var1 = self.owner.origin[0];
      var2 = self.owner.origin[1];
      var5 = getcorrectheight(var1, var2, 20);
      var0 = (var1, var2, var5);
    }

    self setlookatent(self.owner);
    self setvehgoalpos(var0, 1);
    self.lastaction = "following_player";
    scripts\engine\utility::ref_143a5("goal", "begin_evasive_maneuvers");
    self clearlookatent();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

function guardposition(var0) {
  self endon("death");
  self endon("leaving");
  self endon("follow_player");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));
  var1 = undefined;

  if(isDefined(var0)) {
    var2 = var0[0];
    var3 = var0[1];
    var4 = getcorrectheight(var2, var3, 20);
    var1 = (var2, var3, var4);
  } else if(istrue(self.evasivemaneuvers)) {
    var2 = self.owner.origin[0];
    var3 = self.owner.origin[1];
    var5 = var2 + randomintrange(-500, 500);
    var6 = var3 + randomintrange(-500, 500);
    var4 = getcorrectheight(var5, var6, 350);
    var4 = (var5, var6, var4);
  } else {
    var2 = self.owner.origin[0];
    var3 = self.owner.origin[1];
    var4 = getcorrectheight(var2, var3, 20);
    var4 = (var2, var3, var4);
  }

  self setlookatent(self.owner);
  self setvehgoalpos(var4, 1);
  self.lastaction = "following_player";
  scripts\engine\utility::ref_143a5("goal", "begin_evasive_maneuvers");
  self clearlookatent();
}

function patrolfield() {
  self endon("death");
  self endon("leaving");
  self endon("guard_location");
  self endon("priority_target");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));

  for(;;) {
    var0 = undefined;

    if(isDefined(self.patroltarget) && isalive(self.patroltarget) && isPlayer(self.patroltarget) && !self.patroltarget scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
      if(!jackalcanseeenemy(self.patroltarget) || distance2dsquared(self.origin, self.patroltarget.origin) > 4194304) {
        jackalmovetoenemy(self.patroltarget);
      }
    } else {
      var1 = jackalfindclosestenemy();

      if(isDefined(var1)) {
        self.patroltarget = var1;
        thread watchpatroltarget();
        jackalmovetoenemy(var1);
      } else {
        self.patroltarget = undefined;
        var2 = jackalfindfirstopenpoint();

        if(isDefined(var2)) {
          jackalmovetolocation(var2.origin);
        }
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

function jackalfindfirstopenpoint() {
  var0 = undefined;

  if(isDefined(level.carepackagedropnodes) && level.carepackagedropnodes.size > 0) {
    foreach(var2 in level.carepackagedropnodes) {
      if(isDefined(var2.free) && !var2.free) {
        continue;
      }

      if(!jackalcanseelocation(self, var2.origin)) {
        continue;
      }

      var2.free = 0;
      var0 = var2;

      if(!isDefined(self.initialpatrolpoint)) {
        self.initialpatrolpoint = var0;
      }

      break;
    }

    if(!isDefined(var0)) {
      if(isDefined(self.initialpatrolpoint)) {
        foreach(var2 in level.carepackagedropnodes) {
          if(var2 != self.initialpatrolpoint) {
            var2.free = undefined;
          }
        }

        var0 = self.initialpatrolpoint;
      }
    }
  }

  return var0;
}

function jackalcanseelocation(var0, var1) {
  var2 = 0;
  var3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);

  if(scripts\engine\trace::ray_trace_passed(var0.origin, var1, var0, var3)) {
    var2 = 1;
  }

  return var2;
}

function jackalcanseeenemy(var0) {
  var1 = 0;
  var2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);
  var3 = [var0 gettagorigin("j_head"), var0 gettagorigin("j_mainroot"), var0 gettagorigin("tag_origin")];

  for(var4 = 0; var4 < var3.size; var4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var3[var4], self, var2)) {
      continue;
    }

    var1 = 1;
    break;
  }

  return var1;
}

function jackalmovetoenemy(var0) {
  if(isDefined(self.patroltarget)) {
    var0 = self.patroltarget;
  }

  if(jackalcanseeenemy(var0)) {
    self setlookatent(var0);
  }

  var1 = undefined;

  if(istrue(self.evasivemaneuvers)) {
    var2 = var0.origin[0];
    var3 = var0.origin[1];
    var4 = var2 + randomintrange(-500, 500);
    var5 = var3 + randomintrange(-500, 500);
    var6 = getcorrectheight(var4, var5, 350);
    var1 = (var4, var5, var6);
  } else {
    var2 = var3.origin[0];
    var3 = var3.origin[1];
    var6 = getcorrectheight(var2, var3, 20);
    var6 = (var2, var3, var6);
  }

  var7 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var8 = scripts\engine\trace::ray_trace(self.origin, var6, level.characters, var7);

  if(var8["hittype"] != "hittype_none") {
    var9 = getcorrectheight(var8["position"][0], var8["position"][1], 20);
    var6 = (var8["position"][0], var8["position"][1], var9);
  }

  self setvehgoalpos(var6 + (0, 0, 500), 2);
  self.lastaction = "patrol";
  scripts\engine\utility::ref_143a5("goal", "begin_evasive_maneuvers");
  self clearlookatent();
}

function jackalfindclosestenemy() {
  var0 = [];

  foreach(var2 in level.players) {
    if(var2.ignoreme || isDefined(var2.owner) && var2.owner.ignoreme) {
      continue;
    }

    if(!isalive(var2)) {
      continue;
    }

    if(isDefined(level.teambased) && isDefined(var2.team) && self.team == var2.team) {
      continue;
    }

    if(var2 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
      continue;
    }

    if(isjackalenemyindoors(var2)) {
      continue;
    }

    var0 = var2;
    waitframe();
  }

  var4 = undefined;

  if(var0.size > 0) {
    var4 = sortbydistance(var0, self.origin);
  }

  if(isDefined(var4) && var4.size > 0) {
    return var4[0];
  }

  return undefined;
}

function isjackalenemyindoors() {
  var0 = 0;
  var1 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 10000), self, var1)) {
    var0 = 1;
  }

  return var0;
}

function watchpatroltarget() {
  self endon("death");
  self endon("leaving");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  var0 = self.patroltarget scripts\engine\utility::ref_143b9(5, "death_or_disconnect");
  self.patroltarget = undefined;
}

function jackalmovetolocation(var0) {
  var1 = undefined;

  if(istrue(self.evasivemaneuvers)) {
    var2 = var0[0];
    var3 = var0[1];
    var4 = var2 + randomintrange(-500, 500);
    var5 = var3 + randomintrange(-500, 500);
    var6 = getcorrectheight(var4, var5, 350);
    var1 = (var4, var5, var6);
  } else {
    var2 = var3[0];
    var3 = var3[1];

    if(!isDefined(self.tacopslz)) {
      var6 = getcorrectheight(var2, var3, 20);
    } else {
      var6 = 160;
    }

    var2 = (var3, var6, var6);
  }

  self clearlookatent();
  self setvehgoalpos(var2 + (0, 0, 500), 10);
  scripts\engine\utility::ref_143a5("goal", "begin_evasive_maneuvers");
}

function jackalleave(var0, var1) {
  self endon("death");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self clearlookatent();
  self.turret setsentryowner(undefined);

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline)) {
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);
  }

  var2 = int(self.speed / 14);
  var3 = int(self.accel / 16);

  if(isDefined(var0)) {
    var2 = var0;
  }

  if(isDefined(var1)) {
    var3 = var1;
  }

  self vehicle_setspeed(var2, var3);
  var4 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var4 += (0, 0, 1000);
  self setvehgoalpos(var4, 1);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self waittill("goal");
  var5 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var5, 1);
  self waittill("goal");
  self stoploopsound();
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("jackal_gone");
  thread jackaldelete();
}

function jackaldelete() {
  scripts\mp\utility\print::printgameaction("killstreak ended - jackal", self.owner);

  if(isDefined(self.turret)) {
    self.turret delete();
  }

  if(isDefined(self.cannon)) {
    self.cannon delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  foreach(var1 in level.carepackagedropnodes) {
    var1.free = undefined;
  }

  self delete();
}

function jackaltimer() {
  self endon("death");
  level endon("game_ended");
  var0 = 9999;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);

  if(isDefined(self.owner)) {
    self.owner scripts\mp\utility\dialog::playkillstreakdialogonplayer("jackal_end", undefined, undefined, self.owner.origin);
  }

  thread jackalleave();
}

function watchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread jackalleave();
}

function randomjackalmovement() {
  self notify("randomJackalMovement");
  self endon("randomJackalMovement");
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self.lastaction = "randomMovement";
  var0 = self.defendloc;
  var1 = getrandompoint(self.origin);
  self setvehgoalpos(var1, 1);
  thread scripts\mp\utility\debug::drawline(self.origin, var1, 5, (1, 0, 1));
  self waittill("goal");
}

function getrandompoint(var0) {
  self clearlookatent();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    var1 = self.owner.origin[0];
    var2 = self.owner.origin[1];
    var3 = getcorrectheight(var1, var2, 20);
    var4 = (var1, var2, var3);
    self setlookatent(self.owner);
    return var4;
  }

  var5 = self.angles[1];
  var6 = int(var5 - 60);
  var7 = int(var5 + 60);
  var8 = randomintrange(var6, var7);
  var9 = (0, var8, 0);
  [var11] = self.origin + anglesToForward(var9) * randomintrange(400, 800);
  var12 = var10[1];
  var13 = getcorrectheight(var11, var12, 20);
  var14 = tracenewpoint(var11, var12, var13);

  if(var14 != 0) {
    return var14;
  }

  var11 = randomfloatrange(var4[0] - 1200, var4[0] + 1200);
  var12 = randomfloatrange(var4[1] - 1200, var4[1] + 1200);
  var15 = (var11, var12, var13);
  return var15;
}

function getnewpoint(var0, var1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");

  if(!isDefined(var1)) {
    return;
  }

  var2 = [];

  foreach(var4 in level.players) {
    if(var4 == self) {
      continue;
    }

    if(!level.teambased || var4.team != self.team) {
      var2 = var4.origin;
    }
  }

  jumpiffalse(var2.size > 0) LOC_0000009a;
  [var7] = averagepoint(var2);
  var8 = var6[1];
  goto LOC_000000d1;
}

function getpathstart(var0) {
  var1 = 100;
  var2 = 15000;
  var3 = randomfloat(360);
  var4 = (0, var3, 0);
  var5 = var0 + anglesToForward(var4) * -1 * var2;
  var5 += ((randomfloat(2) - 1) * var1, (randomfloat(2) - 1) * var1, 0);
  return var5;
}

function getpathend() {
  var0 = 150;
  var1 = 15000;
  var2 = self.angles[1];
  var3 = (0, var2, 0);
  var4 = self.origin + anglesToForward(var3) * var1;
  return var4;
}

function fireonturrettarget(var0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_timeout");

  if(istrue(var0) && scripts\mp\utility\player::isreallyalive(self.owner) && (!isDefined(self.lastfiretime) || self.lastfiretime + 10000 <= gettime())) {
    self.owner scripts\cp_mp\utility\dialog_utility::operatordialogonplayer("jackal_fire");
    self.lastfiretime = gettime();
  }

  var1 = scripts\mp\utility\outline::outlineenableforplayer(self.turrettarget, self.owner, "outline_depth_orange", "killstreak_personal");
  self.targetoutline = var1;
  var2 = 3;
  thread watchforlosttarget(self.turret, self.turrettarget, "target_timeout", var2);
  self.turret waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::saytoself(self.turrettarget, "plr_killstreak_target");
  self.turret notify("start_firing");
  var3 = weaponfiretime(self.turretweapon);

  while(isDefined(self.turrettarget) && scripts\mp\utility\player::isreallyalive(self.turrettarget) && isDefined(self.turret getturrettarget(1)) && self.turret getturrettarget(1) == self.turrettarget) {
    self.turret shootturret();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var3);
  }
}

function fireoncannontarget(var0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  var1 = 3;
  thread watchforlosttarget(self.cannon, self.cannontarget, "target_cannon_timeout", var1);
  self.cannon waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::saytoself(self.cannontarget, "plr_killstreak_target");
  self.cannon notify("start_firing");
  var2 = weaponfiretime(self.cannonweapon);

  if(isDefined(self.cannontarget) && scripts\mp\utility\player::isreallyalive(self.cannontarget) && isDefined(self.cannon getturrettarget(1)) && self.cannon getturrettarget(1) == self.cannontarget) {
    thread watchmissilelaunch();
    self.cannon shootturret();
    return;
  }
}

function watchmissilelaunch() {
  self endon("death");
  self waittill("missile_fire", var0);
  var0.streakinfo = self.streakinfo;
}

function setmissilekillcament() {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  self.cannon waittill("missile_fire", var0);
  var0.vehicle_fired_from = self;
  var0.vehicle_fired_from.killcament = self.cannon.vehicle_fired_from.killcament;
}

function watchforlosttarget(var0, var1, var2, var3) {
  self endon("death");
  self endon("leaving");
  var0 endon("stop_firing");
  var4 = self.targetoutline;
  var5 = var1 scripts\engine\utility::ref_143b9(var3, "death_or_disconnect");

  if(var5 == "timeout") {
    self notify(var2);
  }

  if(var0.type == "Machine_Gun") {
    if(isDefined(var4) && isDefined(var1)) {
      scripts\mp\utility\outline::outlinedisable(var4, var1);
    }

    self clearlookatent();
  }

  var0 cleartargetentity();
  var0 notify("stop_firing");
}

function isreadytofire(var0) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(var0)) {
    var0 = 10;
  }

  var1 = anglesToForward(self.angles);
  var2 = self.turrettarget.origin - self.origin;
  var1 *= (1, 1, 0);
  var2 *= (1, 1, 0);
  var2 = vectorNormalize(var2);
  var1 = vectorNormalize(var1);
  var3 = vectordot(var2, var1);
  var4 = cos(var0);

  if(var3 >= var4) {
    return 1;
  }

  return 0;
}

function acquireturrettarget(var0) {
  self endon("death");
  self endon("leaving");
  self notify("priority_target");

  if(isDefined(self.outlinedent) && isDefined(self.turrettarget)) {
    scripts\mp\utility\outline::outlinedisable(self.outlinedent, self.turrettarget);
  }

  if(var0.size == 1) {
    self.turrettarget = var0[0];
  } else {
    self.turrettarget = getbesttarget(var0);
  }

  if(isDefined(self.turrettarget)) {
    self clearlookatent();
    self setlookatent(self.turrettarget);
    self.turret settargetentity(self.turrettarget);
    self.lastaction = "attackTarget";
    thread fireonturrettarget(1);
    return;
  }
}

function acquirecannontarget(var0) {
  self endon("death");
  self endon("leaving");
  self.cannontarget = getbesttarget(var0);

  if(isDefined(self.cannontarget)) {
    self.cannon settargetentity(self.cannontarget);
    thread fireoncannontarget(0);
    return;
  }
}

function jackalgettargets() {
  self endon("death");
  self endon("leaving");
  var0 = [];
  var1 = level.players;

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(istarget(var3)) {
      if(isDefined(var1[var2])) {
        var0 = var1[var2];
      }
    } else {
      continue;
    }

    wait 0.05;
  }

  return var0;
}

function istarget(var0) {
  self endon("death");

  if(!isalive(var0) || var0.sessionstate != "playing") {
    return false;
  }

  if(isDefined(self.owner) && var0 == self.owner) {
    return false;
  }

  if(!isDefined(var0.pers["team"])) {
    return false;
  }

  if(level.teambased && var0.pers["team"] == self.team) {
    return false;
  }

  if(var0.pers["team"] == "spectator") {
    return false;
  }

  if(isDefined(var0.spawntime) && (gettime() - var0.spawntime) / 1000 <= 5) {
    return false;
  }

  if(var0 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
    return false;
  }

  if(distance2dsquared(self.origin, var0.origin) > 4194304) {
    return false;
  }

  var1 = (0, 0, 35);
  var2 = var0.origin + rotatevector(var1, var0 getworldupreferenceangles());
  var3 = [self];
  var4 = scripts\engine\trace::ray_trace(self.origin, var2, var3, undefined, 1);

  if(!isDefined(var4["entity"])) {
    return false;
  }

  return true;
}

function getbesttarget(var0) {
  self endon("death");
  var1 = undefined;
  var2 = undefined;

  foreach(var4 in var0) {
    if(isDefined(self.turrettarget) && self.turrettarget == var4) {
      continue;
    }

    var5 = abs(vectortoangles(var4.origin - self.origin)[1]);
    var6 = abs(self gettagangles("tag_origin")[1]);
    var5 = abs(var5 - var6);
    var7 = var4 getweaponslistitems();

    foreach(var9 in var7) {
      var10 = var9.basename;

      if(issubstr(var10, "chargeshot") || issubstr(var10, "lockon")) {
        var5 -= 40;
      }
    }

    if(distance(self.origin, var4.origin) > 4000) {
      var5 += 40;
    }

    if(!isDefined(var1)) {
      var1 = var5;
      var2 = var4;
      continue;
    }

    if(var1 > var5) {
      var1 = var5;
      var2 = var4;
    }
  }

  return var2;
}

function handledestroydamage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
    var9 = scripts\mp\utility\weapon::mapweapon(var9, var13);

    if((var9.basename == "aamissile_projectile_mp" || var9.basename == "nuke_mp") && var4 == "MOD_EXPLOSIVE" && var0 >= self.health) {
      callback_vehicledamage(var1, var1, 9001, 0, var4, var9, var3, var2, var3, 0, 0, var7);
    }
  }
}

function callback_vehicledamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  if(isDefined(var1)) {
    if(isDefined(var1.owner)) {
      var1 = var1.owner;
    }
  }

  if((var1 == self || isDefined(var1.pers) && var1.pers["team"] == self.team && !level.friendlyfire && level.teambased) && var1 != self.owner) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  var2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var1, var5, var4, var2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var1, var5, self, var4, var2);
  var1 scripts\mp\damagefeedback::updatedamagefeedback("");
  scripts\mp\damage::logattackerkillstreak(self, var2, var1, var7, var6, var4, var10, undefined, var11, var3, createheadicon(var5));

  if(self.health <= var2) {
    if(isPlayer(var1) && (!isDefined(self.owner) || var1 != self.owner)) {
      scripts\mp\damage::onkillstreakkilled("jackal", var1, var5, var4, var2, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier");
    }
  }

  if(self.health - var2 <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
}

function getcorrectheight(var0, var1, var2) {
  var3 = 600;
  var4 = tracegroundpoint(var0, var1);
  var5 = var4 + var3;
  var5 += randomint(var2);
  return var5;
}

function playdamageefx() {
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

function jackaldestroyed() {
  self endon("jackal_gone");
  var0 = self.owner;
  self waittill("death");

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline)) {
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);
  }

  if(!isDefined(self)) {
    return;
  }

  self.owner scripts\mp\utility\lower_message::clearlowermessage(getothermode(self.combatmode));

  if(!isDefined(self.largeprojectiledamage)) {
    self vehicle_setspeed(25, 5);
    thread jackalcrash(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  if(isDefined(self.lz)) {
    self.lz notify("extraction_destroyed");
  }

  jackalexplode();
}

function jackalexplode() {
  self playSound("dropship_explode_mp");
  level.jackals[level.jackals.size - 1] = undefined;
  self notify("explode");

  if(isDefined(self.lz)) {
    playFXOnTag(scripts\engine\utility::getfx("jackal_explosion"), self, "tag_origin");
  }

  wait 0.35;
  thread jackaldelete();
}

function jackalcrash(var0) {
  self endon("explode");
  self clearlookatent();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var0, var0, var0);
  self settargetyaw(self.angles[1] + var0 * 2.5);
}

function tracenewpoint(var0, var1, var2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");
  var3 = scripts\engine\trace::sphere_trace(self.origin, (var0, var1, var2), 256, self, undefined, 1);

  if(var3["surfacetype"] != "surftype_none") {
    return 0;
  }

  var4 = (var0, var1, var2);
  return var4;
}

function tracegroundpoint(var0, var1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var2 = -99999;
  var3 = self.origin[2] + 2000;
  var4 = level.averagealliesz;
  var5 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var7 in self.dropcrates) {
      var5 = var7;
    }
  }

  var9 = scripts\engine\trace::sphere_trace((var0, var1, var3), (var0, var1, var2), 256, var5, undefined, 1);

  if(var9["position"][2] < var4) {
    var10 = var4;
  } else {
    var10 = var10["position"][2];
  }

  return var10;
}

function closetogoalcheck(var0) {
  self endon("goal");
  self endon("death");

  for(;;) {
    if(distance2d(self.origin, var0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

function monitorowner() {
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread jackalexplode();
    return;
  }

  self.owner scripts\engine\utility::ref_143a5("joined_team", "disconnect");
  jackalexplode();
}

function watchmodechange() {
  self.owner endon("disconnect");
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var2 = level.framedurationseconds;

  for(;;) {
    self.useobj waittill("trigger", var3);

    if(var3 != self.owner) {
      continue;
    }

    if(self.owner scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    if(!self.owner scripts\common\utility::is_usability_allowed()) {
      continue;
    }

    if(scripts\mp\utility\entity::istouchingboundstrigger(self.owner)) {
      continue;
    }

    var4 = 0;

    while(self.owner useButtonPressed()) {
      var4 += var2;

      if(var4 > 0.1) {
        var5 = getothermode(self.combatmode);

        if(var5 == "guard_location") {
          var6 = self.owner.origin[0];
          var7 = self.owner.origin[1];
          var8 = self.origin[2];
          var9 = (var6, var7, var8);
          var10 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);

          if(!scripts\engine\trace::ray_trace_passed(self.origin, var9, self, var10)) {
            self.owner scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_BE_CALLED");
            break;
          }
        }

        self.combatmode = < error > ;
        self notify(self.combatmode);

        if(self.combatmode == "guard_location") {
          <
          error > = "follow_player"; <
          error > = &"KILLSTREAKS_HINTS_JACKAL_FOLLOW";
          self.owner scripts\cp_mp\utility\dialog_utility::operatordialogonplayer("jackal_guard");
          thread dropship_change_thrust_sfx();
          thread guardposition();
        } else {
          <
          error > = "guard_location"; <
          error > = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
          thread patrolfield();
          thread dropship_change_thrust_sfx();
        }

        self.useobj makeunusable();
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
        self.currentstring = < error > ;
        self.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(self.owner, self.currentstring, 360, 360, 30000, 30000, 2);
        break;
      }

      wait < error > ;
    }

    wait < error > ;
  }
}

function dropship_change_thrust_sfx() {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  self playsoundonmovingent("dropship_killstreak_thrust_change");
}

function getothermode(var0) {
  if(var0 == "follow_player") {
    var0 = "guard_location";
  } else {
    var0 = "follow_player";
  }

  return var0;
}

function looptriggeredeffect(var0, var1) {
  level endon("game_ended");

  for(;;) {
    triggerfx(var0);
    wait 0.05;

    if(!isDefined(var1) || !isDefined(var0)) {
      break;
    }
  }

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function attacklasedtarget(var0, var1) {
  var2 = undefined;
  var3 = undefined;
  var4 = 6000;
  var5 = (0, 0, var4);
  var6 = 3000;
  var7 = anglesToForward(self.angles);
  var8 = self.origin;
  var9 = var8 + var5 + var7 * var6 * -1;
  var10 = [self];
  var11 = 0;
  var12 = scripts\engine\trace::ray_trace(var0 + (0, 0, var4), var0);

  if(var12["fraction"] > 0.99) {
    var11 = 1;
    var9 = var0 + (0, 0, var4);
  }

  if(!var11) {
    var12 = scripts\engine\trace::ray_trace(var0 + (300, 0, var4), var0);

    if(var12["fraction"] > 0.99) {
      var11 = 1;
      var9 = var0 + (300, 0, var4);
    }
  }

  if(!var11) {
    var12 = scripts\engine\trace::ray_trace(var0 + (0, 300, var4), var0);

    if(var12["fraction"] > 0.99) {
      var11 = 1;
      var9 = var0 + (0, 300, var4);
    }
  }

  if(!var11) {
    var12 = scripts\engine\trace::ray_trace(var0 + (0, -300, var4), var0);

    if(var12["fraction"] > 0.99) {
      var11 = 1;
      var9 = var0 + (0, -300, var4);
    }
  }

  if(!var11) {
    var12 = scripts\engine\trace::ray_trace(var0 + (300, 300, var4), var0);

    if(var12["fraction"] > 0.99) {
      var11 = 1;
      var9 = var0 + (300, 300, var4);
    }
  }

  if(!var11) {
    var12 = scripts\engine\trace::ray_trace(var0 + (-300, 0, var4), var0);

    if(var12["fraction"] > 0.99) {
      var11 = 1;
      var9 = var0 + (-300, 0, var4);
    }
  }

  if(!var11) {
    var12 = scripts\engine\trace::ray_trace(var0 + (-300, -300, var4), var0);

    if(var12["fraction"] > 0.99) {
      var11 = 1;
      var9 = var0 + (-300, -300, var4);
    }
  }

  if(!var11) {
    var12 = scripts\engine\trace::ray_trace(var0 + (300, -300, var4), var0);

    if(var12["fraction"] > 0.99) {
      var11 = 1;
      var9 = var0 + (300, -300, var4);
    }
  }

  if(!var11) {
    for(var13 = 0; var13 < 5; var13++) {
      var4 /= 2;
      var5 = (0, 0, var4);
      var9 = var8 + var5 + var7 * var6 * -1;
      var14 = scripts\engine\trace::ray_trace(var0, var9, var10);

      if(var14["fraction"] > 0.99) {
        var11 = 1;
        break;
      }

      wait 0.05;
    }
  }

  if(!var11) {
    for(var13 = 0; var13 < 5; var13++) {
      var4 *= 2.5;
      var5 = (0, 0, var4);
      var9 = var8 + var5 + var7 * var6 * -1;
      var14 = scripts\engine\trace::ray_trace(var0, var9, var10);

      if(var14["fraction"] > 0.99) {
        var11 = 1;
        break;
      }

      wait 0.05;
    }

    return;
  }
}

function playlocksound() {
  if(isDefined(self.playinglocksound) && self.playinglocksound) {
    return;
  }

  scripts\engine\utility::play_loopsound_in_space("javelin_clu_lock", self.origin);
  self.playinglocksound = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.75);
  self stoploopsound("javelin_clu_lock");
  self.playinglocksound = 0;
}

function playlockerrorsound() {
  if(isDefined(self.playinglocksound) && self.playinglocksound) {
    return;
  }

  self playlocalsound("javelin_clu_aquiring_lock");
  self.playinglocksound = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.75);
  self stoplocalsound("javelin_clu_aquiring_lock");
  self.playinglocksound = 0;
}

function beginevasivemaneuvers() {
  self endon("death");
  self notify("begin_evasive_maneuvers");
  self endon("begin_evasive_maneuvers");
  self.evasivemaneuvers = 1;
  var0 = scripts\engine\utility::ref_143b9(3, "death");

  if(var0 == "timeout") {
    self.evasivemaneuvers = 0;
    return;
  }
}

function watchguardevadedamage() {
  self endon("death");
  self endon("leaving");
  self endon("following_player");

  for(;;) {
    var0 = undefined;

    if(istrue(self.evasivemaneuvers)) {
      var1 = self.owner.origin[0];
      var2 = self.owner.origin[1];
      var3 = var1 + randomintrange(-500, 500);
      var4 = var2 + randomintrange(-500, 500);
      var5 = getcorrectheight(var3, var4, 350);
      var0 = (var3, var4, var5);
    }

    if(isDefined(var0)) {
      self setvehgoalpos(var0, 1);
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

function watchdropcratesearly(var0) {
  self endon("dropped_crates");
  var1 = self.dropcrates;
  self waittill("death");
  thread dropcrates(var1, var0);
}

function dropcrates(var0, var1) {
  self notify("dropped_crates");
}

function watchforcapture(var0, var1) {
  scripts\engine\utility::ref_143a5("captured", "death");
  var0 notify("crate_captured_" + var1);
}

function watchjackalcratepickup() {
  self endon("death");
  self endon("leaving");
  var0 = 0;

  for(;;) {
    scripts\engine\utility::ref_143a6("crate_captured_0", "crate_captured_1", "crate_captured_2");
    var0++;

    if(var0 == self.dropcrates.size) {
      self notify("all_crates_gone");
      break;
    }
  }
}

function beginjackalescort(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level.jackals)) {
    level.jackals = [];
  }

  var6 = undefined;
  self notify("called_in_jackal");
  var7 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var2 *= (1, 1, 0);
  var8 = 1000;
  var9 = var2 + (0, 0, var8);
  var10 = spawnksjackal(var0, self, var1, var9, var3, var4);
  var10.pathgoal = var9;
  thread defendlocationescort(var10, var6);
  return var10;
}

function defendlocationescort(var0, var1) {
  var0 endon("death");
  var0 setvehgoalpos(var0.pathgoal, 1);
  var0 playsoundonmovingent("dropship_killstreak_thrust_change");
  thread closetogoalcheck(var0);
  thread monitorowner();
  var0 waittill("goal");
  thread watchgameendleave();
  thread engageprimarytarget();
  thread engagesecondarytarget();
  var0 vehicle_setspeed(int(var0.speed / 14), int(var0.accel / 16));
}

function guardpositionescort(var0, var1, var2) {
  self endon("death");
  self endon("leaving");
  self endon("follow_player");
  self endon("jackal_crashing");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));

  if(isDefined(var1)) {
    self setlookatent(var1);
  }

  if(isDefined(var0)) {
    var3 = undefined;
    var4 = var0[0];
    var5 = var0[1];

    if(istrue(self.evasivemaneuvers)) {
      var6 = var4 + randomintrange(-500, 500);
      var7 = var5 + randomintrange(-500, 500);
      var8 = getcorrectheightescort(var6, var7, 350, var2);
      var3 = (var6, var7, var8);
    } else {
      var8 = getcorrectheightescort(var5, var8, 20, var3);
      var4 = (var5, var8, var8);
    }

    self setvehgoalpos(var4, 1);
    self.lastaction = "following_player";
    scripts\engine\utility::ref_143a5("goal", "begin_evasive_maneuvers");
    self clearlookatent();
    return;
  }
}

function getcorrectheightescort(var0, var1, var2, var3) {
  var4 = 200;

  if(isDefined(var3)) {
    var4 = var3;
  }

  var5 = tracegroundpoint(var0, var1);
  var6 = var5 + var4;
  var6 += randomint(var2);
  return var6;
}