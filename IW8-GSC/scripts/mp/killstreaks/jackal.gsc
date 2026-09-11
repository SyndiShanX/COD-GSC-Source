/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\jackal.gsc
***********************************************/

function beginjackal(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.jackals)) {
    level.jackals = [];
  }

  var_5 = undefined;

  if(isDefined(var_4)) {
    var_5 = var_4.marker;
    var_6 = 2;

    if(!isDefined(var_5)) {
      var_5 = spawnStruct();

      if(isDefined(var_4.location)) {
        var_5.location = var_4.location;
      } else {
        var_5.location = var_4.trigger.origin;
      }

      var_5.angles = (0, 0, 0);
      var_5.string = "equip_deploy_succeeded";
      var_5.visual = spawn("script_model", var_5.location);
      var_5.visual setModel("ks_marker_mp");
      var_5.visual setotherent(self);
    }

    if(!isDefined(var_5.location)) {
      self notify("cancel_jackal");
      return 0;
    } else if(isDefined(level.jackal_incoming) || level.jackals.size >= var_6) {
      if(isDefined(var_5.visual)) {
        var_5.visual delete();
      }

      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

      if(isDefined(var_3.objweapon) && var_3.objweapon.basename != "none") {
        self notify("killstreak_finished_with_weapon_" + var_3.weaponname);
      }

      self notify("cancel_jackal");
      return 0;
    }
  }

  self notify("called_in_jackal");
  level.jackal_incoming = 1;
  var_7 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var_7)) {
    var_8 = var_7.origin[2] + 500;
  } else {
    var_8 = 1300;
  }

  if(isDefined(var_7) && isDefined(var_7.location)) {
    var_3 = var_7.location;
  }

  var_3 *= (1, 1, 0);
  var_9 = var_3 + (0, 0, var_8);
  var_10 = spawnksjackal(var_1, self, var_2, var_9, var_4, var_5);
  var_10.tacopslz = var_5;
  var_11 = var_9;
  var_12 = var_9 + anglestoright(self.angles) * 2000;
  var_13 = var_9 - anglestoright(self.angles) * 2000;
  var_14 = [var_11, var_12, var_13];

  foreach(var_16 in var_14) {
    if(!jackalcanseelocation(var_10, var_16)) {
      continue;
    }

    var_9 = var_16;
    break;
  }

  var_10.pathgoal = var_9;
  thread defendlocation(var_10, var_7);
  return var_10;
}

function spawnksjackal(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_3 - var_2);
  var_7 = 4;
  var_8 = 50;
  var_9 = 175;
  var_10 = 10000;
  var_11 = "veh8_mil_air_lbravo";
  var_12 = "jackal_turret_mp";
  var_13 = "veh_mil_air_ca_dropship_mp_turret";
  var_14 = 1;
  var_15 = "jackal_cannon_mp";
  var_16 = "veh_mil_air_ca_dropship_turret_missile";
  var_17 = 1;
  var_18 = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
  var_19 = "follow_player";

  if(isDefined(var_5)) {
    var_19 = "guard_location";
  }

  var_20 = spawnhelicopter(var_1, var_2, var_6, "veh_airdrop_mp", var_11);

  if(!isDefined(var_20)) {
    return;
  }

  if(isDefined(var_5)) {
    var_20.lz = var_5;
  }

  thread handledestroydamage();
  var_20.damagecallback = &callback_vehicledamage;
  var_20.speed = var_8;
  var_20.accel = var_9;
  var_20.health = var_10;
  var_20.maxhealth = var_20.health;
  var_20.team = var_1.team;
  var_20.owner = var_1;
  var_20 setCanDamage(1);
  var_20.defendloc = var_3;
  var_20.lifeid = var_0;
  var_20.jackal = 1;
  var_20.streakinfo = var_4;
  var_20.streakname = var_4.streakname;
  var_20.evasivemaneuvers = 0;
  var_20.combatmode = var_19;
  var_20.currentstring = var_18;
  var_20.streakinfo = var_4;
  var_20.flaresreservecount = var_7;
  var_20.turreton = var_14;
  var_20.turretweapon = var_12;
  var_20.cannonweapon = var_15;
  var_20.cannonon = var_17;
  var_20 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var_4.streakname, "Killstreak_Air", var_1, 0, 1, 100);
  var_20 setmaxpitchroll(0, 90);
  var_20 vehicle_setspeed(var_20.speed, var_20.accel);
  var_20 sethoverparams(50, 100, 50);
  var_20 setturningability(0.05);
  var_20 setyawspeed(45, 25, 25, 0.5);
  var_20 setotherent(var_1);
  var_21 = anglesToForward(var_20.angles);

  if(!isDefined(var_5)) {
    var_20.turret = spawnturret("misc_turret", var_20 gettagorigin("tag_origin"), var_12);
    var_20.turret setModel(var_13);
    var_20.turret.owner = var_1;
    var_20.turret.team = var_1.team;
    var_20.turret.angles = var_20.angles;
    var_20.turret.type = "Machine_Gun";
    var_20.turret.streakinfo = var_4;
    var_20.turret linkTo(var_20, "tag_origin", (200, 0, 55), (0, 0, 0));
    var_20.turret setturretmodechangewait(0);
    var_20.turret setmode("manual_target");
    var_20.turret setsentryowner(var_1);
    var_20.cannon = spawnturret("misc_turret", var_20 gettagorigin("tag_origin"), var_15);
    var_20.cannon setModel(var_16);
    var_20.cannon.owner = var_1;
    var_20.cannon.team = var_1.team;
    var_20.cannon.angles = var_20.angles;
    var_20.cannon.type = "Cannon";
    var_20.cannon.streakinfo = var_4;
    var_20.cannon linkTo(var_20, "tag_origin", (-100, 0, 55), (0, 0, 0));
    var_20.cannon setturretmodechangewait(0);
    var_20.cannon setmode("manual_target");
    var_20.cannon setsentryowner(var_1);
  }

  var_20.useobj = spawn("script_model", var_20 gettagorigin("tag_origin"));
  var_20.useobj linkTo(var_20, "tag_origin");
  level.jackals[level.jackals.size] = var_20;
  level.jackals = scripts\engine\utility::array_removeundefined(level.jackals);
  level.jackal_incoming = undefined;

  if(isDefined(var_5)) {
    var_20 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  }

  thread jackaldestroyed();
  thread delayjackalloopsfx(var_20, 0.05);
  thread delay_jackal_arrive_sfx();

  if(!isDefined(var_5)) {
    var_20.turret.vehicle_fired_from = var_20;
    var_20.cannon.vehicle_fired_from = var_20;
    var_20.turret.vehicle_fired_from.killcament = spawn("script_model", var_20 gettagorigin("tag_origin"));
    var_20.turret.vehicle_fired_from.killcament linkTo(var_20, "tag_origin");
    var_20.cannon.vehicle_fired_from.killcament = var_20.turret.vehicle_fired_from.killcament;
  }

  var_22 = anglesToForward(var_20.angles);
  return var_20;
}

function getnumownedjackals(var_0) {
  var_1 = 0;
  jumpiffalse(level.teambased) LOC_00000055;

  foreach(var_3 in level.jackals) {
    if(var_3.team != var_0.team) {
      continue;
    }

    var_1++;
  }

  goto LOC_00000091;
}

function delay_jackal_arrive_sfx() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
}

function delayjackalloopsfx(var_0, var_1) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self playLoopSound(var_1);
}

function defendlocation(var_0, var_1) {
  var_0 endon("death");
  var_0 setvehgoalpos(var_0.pathgoal, 1);
  thread closetogoalcheck(var_0);
  thread monitorowner();

  if(isDefined(var_0.dropcrates)) {
    thread watchdropcratesearly(var_0);
  }

  var_0 waittill("goal");

  if(isDefined(var_1) && isDefined(var_0.lz)) {
    thread jackaltimer();
    thread watchgameendleave();
    thread engageprimarytarget();
    var_0.speed = 250;
    var_0 vehicle_setspeed(50, 15);
    jackalmovetolocation(var_0, var_1.location);
    var_0 waittill("extract_hostages");
    thread jackalleave(var_0, 50);
  } else if(isDefined(var_1) && isDefined(var_0.dropcrates)) {
    thread jackaltimer();
    thread watchgameendleave();
    thread engageprimarytarget();
    thread engagesecondarytarget();
    var_0 vehicle_setspeed(50, 15);
    jackalmovetolocation(var_0, var_1.location);
    thread dropcrates(var_0, var_0.dropcrates);
    thread watchjackalcratepickup();
    var_0 scripts\engine\utility::ref_143b9(10, "all_crates_gone");
    var_0.combatmode = "follow_player";
  } else {
    thread jackaltimer();
    thread watchgameendleave();
    thread engageprimarytarget();
    thread engagesecondarytarget();
    var_0 vehicle_setspeed(int(var_0.speed / 14), int(var_0.accel / 16));
  }

  if(!isDefined(var_0.lz)) {
    var_0.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(var_0.owner, var_0.currentstring, 360, 360, 30000, 30000, 2);
    thread patrolfield();
    thread watchmodechange(var_0, getothermode(var_0.combatmode));
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
      var_0 = jackalgettargets();

      if(isDefined(var_0) && var_0.size > 0) {
        acquireturrettarget(var_0);
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
  var_0 = weaponfiretime(self.cannonweapon);

  if(istrue(self.cannonon)) {
    for(;;) {
      var_1 = jackalgettargets();

      if(!isDefined(var_1) || var_1.size < 2) {
        waitframe();
        continue;
      }

      acquirecannontarget(var_1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
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
    var_0 = undefined;

    if(istrue(self.evasivemaneuvers)) {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_3 = var_1 + randomintrange(-500, 500);
      var_4 = var_2 + randomintrange(-500, 500);
      var_5 = getcorrectheight(var_3, var_4, 350);
      var_0 = (var_3, var_4, var_5);
    } else {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_5 = getcorrectheight(var_1, var_2, 20);
      var_0 = (var_1, var_2, var_5);
    }

    self setlookatent(self.owner);
    self setvehgoalpos(var_0, 1);
    self.lastaction = "following_player";
    scripts\engine\utility::ref_143a5("goal", "begin_evasive_maneuvers");
    self clearlookatent();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

function guardposition(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("follow_player");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_2 = var_0[0];
    var_3 = var_0[1];
    var_4 = getcorrectheight(var_2, var_3, 20);
    var_1 = (var_2, var_3, var_4);
  } else if(istrue(self.evasivemaneuvers)) {
    var_2 = self.owner.origin[0];
    var_3 = self.owner.origin[1];
    var_5 = var_2 + randomintrange(-500, 500);
    var_6 = var_3 + randomintrange(-500, 500);
    var_4 = getcorrectheight(var_5, var_6, 350);
    var_4 = (var_5, var_6, var_4);
  } else {
    var_2 = self.owner.origin[0];
    var_3 = self.owner.origin[1];
    var_4 = getcorrectheight(var_2, var_3, 20);
    var_4 = (var_2, var_3, var_4);
  }

  self setlookatent(self.owner);
  self setvehgoalpos(var_4, 1);
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
    var_0 = undefined;

    if(isDefined(self.patroltarget) && isalive(self.patroltarget) && isPlayer(self.patroltarget) && !self.patroltarget scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
      if(!jackalcanseeenemy(self.patroltarget) || distance2dsquared(self.origin, self.patroltarget.origin) > 4194304) {
        jackalmovetoenemy(self.patroltarget);
      }
    } else {
      var_1 = jackalfindclosestenemy();

      if(isDefined(var_1)) {
        self.patroltarget = var_1;
        thread watchpatroltarget();
        jackalmovetoenemy(var_1);
      } else {
        self.patroltarget = undefined;
        var_2 = jackalfindfirstopenpoint();

        if(isDefined(var_2)) {
          jackalmovetolocation(var_2.origin);
        }
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

function jackalfindfirstopenpoint() {
  var_0 = undefined;

  if(isDefined(level.carepackagedropnodes) && level.carepackagedropnodes.size > 0) {
    foreach(var_2 in level.carepackagedropnodes) {
      if(isDefined(var_2.free) && !var_2.free) {
        continue;
      }

      if(!jackalcanseelocation(self, var_2.origin)) {
        continue;
      }

      var_2.free = 0;
      var_0 = var_2;

      if(!isDefined(self.initialpatrolpoint)) {
        self.initialpatrolpoint = var_0;
      }

      break;
    }

    if(!isDefined(var_0)) {
      if(isDefined(self.initialpatrolpoint)) {
        foreach(var_2 in level.carepackagedropnodes) {
          if(var_2 != self.initialpatrolpoint) {
            var_2.free = undefined;
          }
        }

        var_0 = self.initialpatrolpoint;
      }
    }
  }

  return var_0;
}

function jackalcanseelocation(var_0, var_1) {
  var_2 = 0;
  var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);

  if(scripts\engine\trace::ray_trace_passed(var_0.origin, var_1, var_0, var_3)) {
    var_2 = 1;
  }

  return var_2;
}

function jackalcanseeenemy(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);
  var_3 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_origin")];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_4], self, var_2)) {
      continue;
    }

    var_1 = 1;
    break;
  }

  return var_1;
}

function jackalmovetoenemy(var_0) {
  if(isDefined(self.patroltarget)) {
    var_0 = self.patroltarget;
  }

  if(jackalcanseeenemy(var_0)) {
    self setlookatent(var_0);
  }

  var_1 = undefined;

  if(istrue(self.evasivemaneuvers)) {
    var_2 = var_0.origin[0];
    var_3 = var_0.origin[1];
    var_4 = var_2 + randomintrange(-500, 500);
    var_5 = var_3 + randomintrange(-500, 500);
    var_6 = getcorrectheight(var_4, var_5, 350);
    var_1 = (var_4, var_5, var_6);
  } else {
    var_2 = var_3.origin[0];
    var_3 = var_3.origin[1];
    var_6 = getcorrectheight(var_2, var_3, 20);
    var_6 = (var_2, var_3, var_6);
  }

  var_7 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_8 = scripts\engine\trace::ray_trace(self.origin, var_6, level.characters, var_7);

  if(var_8["hittype"] != "hittype_none") {
    var_9 = getcorrectheight(var_8["position"][0], var_8["position"][1], 20);
    var_6 = (var_8["position"][0], var_8["position"][1], var_9);
  }

  self setvehgoalpos(var_6 + (0, 0, 500), 2);
  self.lastaction = "patrol";
  scripts\engine\utility::ref_143a5("goal", "begin_evasive_maneuvers");
  self clearlookatent();
}

function jackalfindclosestenemy() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2.ignoreme || isDefined(var_2.owner) && var_2.owner.ignoreme) {
      continue;
    }

    if(!isalive(var_2)) {
      continue;
    }

    if(isDefined(level.teambased) && isDefined(var_2.team) && self.team == var_2.team) {
      continue;
    }

    if(var_2 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
      continue;
    }

    if(isjackalenemyindoors(var_2)) {
      continue;
    }

    var_0 = var_2;
    waitframe();
  }

  var_4 = undefined;

  if(var_0.size > 0) {
    var_4 = sortbydistance(var_0, self.origin);
  }

  if(isDefined(var_4) && var_4.size > 0) {
    return var_4[0];
  }

  return undefined;
}

function isjackalenemyindoors() {
  var_0 = 0;
  var_1 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 10000), self, var_1)) {
    var_0 = 1;
  }

  return var_0;
}

function watchpatroltarget() {
  self endon("death");
  self endon("leaving");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  var_0 = self.patroltarget scripts\engine\utility::ref_143b9(5, "death_or_disconnect");
  self.patroltarget = undefined;
}

function jackalmovetolocation(var_0) {
  var_1 = undefined;

  if(istrue(self.evasivemaneuvers)) {
    var_2 = var_0[0];
    var_3 = var_0[1];
    var_4 = var_2 + randomintrange(-500, 500);
    var_5 = var_3 + randomintrange(-500, 500);
    var_6 = getcorrectheight(var_4, var_5, 350);
    var_1 = (var_4, var_5, var_6);
  } else {
    var_2 = var_3[0];
    var_3 = var_3[1];

    if(!isDefined(self.tacopslz)) {
      var_6 = getcorrectheight(var_2, var_3, 20);
    } else {
      var_6 = 160;
    }

    var_2 = (var_3, var_6, var_6);
  }

  self clearlookatent();
  self setvehgoalpos(var_2 + (0, 0, 500), 10);
  scripts\engine\utility::ref_143a5("goal", "begin_evasive_maneuvers");
}

function jackalleave(var_0, var_1) {
  self endon("death");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self clearlookatent();
  self.turret setsentryowner(undefined);

  if(isDefined(self.turrettarget) && isDefined(self.targetoutline)) {
    scripts\mp\utility\outline::outlinedisable(self.targetoutline, self.turrettarget);
  }

  var_2 = int(self.speed / 14);
  var_3 = int(self.accel / 16);

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  self vehicle_setspeed(var_2, var_3);
  var_4 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_4 += (0, 0, 1000);
  self setvehgoalpos(var_4, 1);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self waittill("goal");
  var_5 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_5, 1);
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

  foreach(var_1 in level.carepackagedropnodes) {
    var_1.free = undefined;
  }

  self delete();
}

function jackaltimer() {
  self endon("death");
  level endon("game_ended");
  var_0 = 9999;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);

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
  var_0 = self.defendloc;
  var_1 = getrandompoint(self.origin);
  self setvehgoalpos(var_1, 1);
  thread scripts\mp\utility\debug::drawline(self.origin, var_1, 5, (1, 0, 1));
  self waittill("goal");
}

function getrandompoint(var_0) {
  self clearlookatent();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    var_1 = self.owner.origin[0];
    var_2 = self.owner.origin[1];
    var_3 = getcorrectheight(var_1, var_2, 20);
    var_4 = (var_1, var_2, var_3);
    self setlookatent(self.owner);
    return var_4;
  }

  var_5 = self.angles[1];
  var_6 = int(var_5 - 60);
  var_7 = int(var_5 + 60);
  var_8 = randomintrange(var_6, var_7);
  var_9 = (0, var_8, 0);
  [var_11] = self.origin + anglesToForward(var_9) * randomintrange(400, 800);
  var_12 = var_10[1];
  var_13 = getcorrectheight(var_11, var_12, 20);
  var_14 = tracenewpoint(var_11, var_12, var_13);

  if(var_14 != 0) {
    return var_14;
  }

  var_11 = randomfloatrange(var_4[0] - 1200, var_4[0] + 1200);
  var_12 = randomfloatrange(var_4[1] - 1200, var_4[1] + 1200);
  var_15 = (var_11, var_12, var_13);
  return var_15;
}

function getnewpoint(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = [];

  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }

    if(!level.teambased || var_4.team != self.team) {
      var_2 = var_4.origin;
    }
  }

  jumpiffalse(var_2.size > 0) LOC_0000009a;
  [var_7] = averagepoint(var_2);
  var_8 = var_6[1];
  goto LOC_000000d1;
}

function getpathstart(var_0) {
  var_1 = 100;
  var_2 = 15000;
  var_3 = randomfloat(360);
  var_4 = (0, var_3, 0);
  var_5 = var_0 + anglesToForward(var_4) * -1 * var_2;
  var_5 += ((randomfloat(2) - 1) * var_1, (randomfloat(2) - 1) * var_1, 0);
  return var_5;
}

function getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

function fireonturrettarget(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_timeout");

  if(istrue(var_0) && scripts\mp\utility\player::isreallyalive(self.owner) && (!isDefined(self.lastfiretime) || self.lastfiretime + 10000 <= gettime())) {
    self.owner scripts\cp_mp\utility\dialog_utility::operatordialogonplayer("jackal_fire");
    self.lastfiretime = gettime();
  }

  var_1 = scripts\mp\utility\outline::outlineenableforplayer(self.turrettarget, self.owner, "outline_depth_orange", "killstreak_personal");
  self.targetoutline = var_1;
  var_2 = 3;
  thread watchforlosttarget(self.turret, self.turrettarget, "target_timeout", var_2);
  self.turret waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::saytoself(self.turrettarget, "plr_killstreak_target");
  self.turret notify("start_firing");
  var_3 = weaponfiretime(self.turretweapon);

  while(isDefined(self.turrettarget) && scripts\mp\utility\player::isreallyalive(self.turrettarget) && isDefined(self.turret getturrettarget(1)) && self.turret getturrettarget(1) == self.turrettarget) {
    self.turret shootturret();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_3);
  }
}

function fireoncannontarget(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  var_1 = 3;
  thread watchforlosttarget(self.cannon, self.cannontarget, "target_cannon_timeout", var_1);
  self.cannon waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::saytoself(self.cannontarget, "plr_killstreak_target");
  self.cannon notify("start_firing");
  var_2 = weaponfiretime(self.cannonweapon);

  if(isDefined(self.cannontarget) && scripts\mp\utility\player::isreallyalive(self.cannontarget) && isDefined(self.cannon getturrettarget(1)) && self.cannon getturrettarget(1) == self.cannontarget) {
    thread watchmissilelaunch();
    self.cannon shootturret();
    return;
  }
}

function watchmissilelaunch() {
  self endon("death");
  self waittill("missile_fire", var_0);
  var_0.streakinfo = self.streakinfo;
}

function setmissilekillcament() {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  self.cannon waittill("missile_fire", var_0);
  var_0.vehicle_fired_from = self;
  var_0.vehicle_fired_from.killcament = self.cannon.vehicle_fired_from.killcament;
}

function watchforlosttarget(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("leaving");
  var_0 endon("stop_firing");
  var_4 = self.targetoutline;
  var_5 = var_1 scripts\engine\utility::ref_143b9(var_3, "death_or_disconnect");

  if(var_5 == "timeout") {
    self notify(var_2);
  }

  if(var_0.type == "Machine_Gun") {
    if(isDefined(var_4) && isDefined(var_1)) {
      scripts\mp\utility\outline::outlinedisable(var_4, var_1);
    }

    self clearlookatent();
  }

  var_0 cleartargetentity();
  var_0 notify("stop_firing");
}

function isreadytofire(var_0) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = self.turrettarget.origin - self.origin;
  var_1 *= (1, 1, 0);
  var_2 *= (1, 1, 0);
  var_2 = vectorNormalize(var_2);
  var_1 = vectorNormalize(var_1);
  var_3 = vectordot(var_2, var_1);
  var_4 = cos(var_0);

  if(var_3 >= var_4) {
    return 1;
  }

  return 0;
}

function acquireturrettarget(var_0) {
  self endon("death");
  self endon("leaving");
  self notify("priority_target");

  if(isDefined(self.outlinedent) && isDefined(self.turrettarget)) {
    scripts\mp\utility\outline::outlinedisable(self.outlinedent, self.turrettarget);
  }

  if(var_0.size == 1) {
    self.turrettarget = var_0[0];
  } else {
    self.turrettarget = getbesttarget(var_0);
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

function acquirecannontarget(var_0) {
  self endon("death");
  self endon("leaving");
  self.cannontarget = getbesttarget(var_0);

  if(isDefined(self.cannontarget)) {
    self.cannon settargetentity(self.cannontarget);
    thread fireoncannontarget(0);
    return;
  }
}

function jackalgettargets() {
  self endon("death");
  self endon("leaving");
  var_0 = [];
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(istarget(var_3)) {
      if(isDefined(var_1[var_2])) {
        var_0 = var_1[var_2];
      }
    } else {
      continue;
    }

    wait 0.05;
  }

  return var_0;
}

function istarget(var_0) {
  self endon("death");

  if(!isalive(var_0) || var_0.sessionstate != "playing") {
    return false;
  }

  if(isDefined(self.owner) && var_0 == self.owner) {
    return false;
  }

  if(!isDefined(var_0.pers["team"])) {
    return false;
  }

  if(level.teambased && var_0.pers["team"] == self.team) {
    return false;
  }

  if(var_0.pers["team"] == "spectator") {
    return false;
  }

  if(isDefined(var_0.spawntime) && (gettime() - var_0.spawntime) / 1000 <= 5) {
    return false;
  }

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
    return false;
  }

  if(distance2dsquared(self.origin, var_0.origin) > 4194304) {
    return false;
  }

  var_1 = (0, 0, 35);
  var_2 = var_0.origin + rotatevector(var_1, var_0 getworldupreferenceangles());
  var_3 = [self];
  var_4 = scripts\engine\trace::ray_trace(self.origin, var_2, var_3, undefined, 1);

  if(!isDefined(var_4["entity"])) {
    return false;
  }

  return true;
}

function getbesttarget(var_0) {
  self endon("death");
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(isDefined(self.turrettarget) && self.turrettarget == var_4) {
      continue;
    }

    var_5 = abs(vectortoangles(var_4.origin - self.origin)[1]);
    var_6 = abs(self gettagangles("tag_origin")[1]);
    var_5 = abs(var_5 - var_6);
    var_7 = var_4 getweaponslistitems();

    foreach(var_9 in var_7) {
      var_10 = var_9.basename;

      if(issubstr(var_10, "chargeshot") || issubstr(var_10, "lockon")) {
        var_5 -= 40;
      }
    }

    if(distance(self.origin, var_4.origin) > 4000) {
      var_5 += 40;
    }

    if(!isDefined(var_1)) {
      var_1 = var_5;
      var_2 = var_4;
      continue;
    }

    if(var_1 > var_5) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  return var_2;
}

function handledestroydamage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::mapweapon(var_9, var_13);

    if((var_9.basename == "aamissile_projectile_mp" || var_9.basename == "nuke_mp") && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health) {
      callback_vehicledamage(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
    }
  }
}

function callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level.friendlyfire && level.teambased) && var_1 != self.owner) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  var_2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self, var_4, var_2);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("");
  scripts\mp\damage::logattackerkillstreak(self, var_2, var_1, var_7, var_6, var_4, var_10, undefined, var_11, var_3, createheadicon(var_5));

  if(self.health <= var_2) {
    if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
      scripts\mp\damage::onkillstreakkilled("jackal", var_1, var_5, var_4, var_2, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier");
    }
  }

  if(self.health - var_2 <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

function getcorrectheight(var_0, var_1, var_2) {
  var_3 = 600;
  var_4 = tracegroundpoint(var_0, var_1);
  var_5 = var_4 + var_3;
  var_5 += randomint(var_2);
  return var_5;
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
  var_0 = self.owner;
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

function jackalcrash(var_0) {
  self endon("explode");
  self clearlookatent();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

function tracenewpoint(var_0, var_1, var_2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");
  var_3 = scripts\engine\trace::sphere_trace(self.origin, (var_0, var_1, var_2), 256, self, undefined, 1);

  if(var_3["surfacetype"] != "surftype_none") {
    return 0;
  }

  var_4 = (var_0, var_1, var_2);
  return var_4;
}

function tracegroundpoint(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_2 = -99999;
  var_3 = self.origin[2] + 2000;
  var_4 = level.averagealliesz;
  var_5 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var_7 in self.dropcrates) {
      var_5 = var_7;
    }
  }

  var_9 = scripts\engine\trace::sphere_trace((var_0, var_1, var_3), (var_0, var_1, var_2), 256, var_5, undefined, 1);

  if(var_9["position"][2] < var_4) {
    var_10 = var_4;
  } else {
    var_10 = var_10["position"][2];
  }

  return var_10;
}

function closetogoalcheck(var_0) {
  self endon("goal");
  self endon("death");

  for(;;) {
    if(distance2d(self.origin, var_0) < 768) {
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
  var_2 = level.framedurationseconds;

  for(;;) {
    self.useobj waittill("trigger", var_3);

    if(var_3 != self.owner) {
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

    var_4 = 0;

    while(self.owner useButtonPressed()) {
      var_4 += var_2;

      if(var_4 > 0.1) {
        var_5 = getothermode(self.combatmode);

        if(var_5 == "guard_location") {
          var_6 = self.owner.origin[0];
          var_7 = self.owner.origin[1];
          var_8 = self.origin[2];
          var_9 = (var_6, var_7, var_8);
          var_10 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);

          if(!scripts\engine\trace::ray_trace_passed(self.origin, var_9, self, var_10)) {
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

function getothermode(var_0) {
  if(var_0 == "follow_player") {
    var_0 = "guard_location";
  } else {
    var_0 = "follow_player";
  }

  return var_0;
}

function looptriggeredeffect(var_0, var_1) {
  level endon("game_ended");

  for(;;) {
    triggerfx(var_0);
    wait 0.05;

    if(!isDefined(var_1) || !isDefined(var_0)) {
      break;
    }
  }

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function attacklasedtarget(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 6000;
  var_5 = (0, 0, var_4);
  var_6 = 3000;
  var_7 = anglesToForward(self.angles);
  var_8 = self.origin;
  var_9 = var_8 + var_5 + var_7 * var_6 * -1;
  var_10 = [self];
  var_11 = 0;
  var_12 = scripts\engine\trace::ray_trace(var_0 + (0, 0, var_4), var_0);

  if(var_12["fraction"] > 0.99) {
    var_11 = 1;
    var_9 = var_0 + (0, 0, var_4);
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, 0, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, 0, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (0, 300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (0, 300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (0, -300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (0, -300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, 300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, 300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (-300, 0, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (-300, 0, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (-300, -300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (-300, -300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, -300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, -300, var_4);
    }
  }

  if(!var_11) {
    for(var_13 = 0; var_13 < 5; var_13++) {
      var_4 /= 2;
      var_5 = (0, 0, var_4);
      var_9 = var_8 + var_5 + var_7 * var_6 * -1;
      var_14 = scripts\engine\trace::ray_trace(var_0, var_9, var_10);

      if(var_14["fraction"] > 0.99) {
        var_11 = 1;
        break;
      }

      wait 0.05;
    }
  }

  if(!var_11) {
    for(var_13 = 0; var_13 < 5; var_13++) {
      var_4 *= 2.5;
      var_5 = (0, 0, var_4);
      var_9 = var_8 + var_5 + var_7 * var_6 * -1;
      var_14 = scripts\engine\trace::ray_trace(var_0, var_9, var_10);

      if(var_14["fraction"] > 0.99) {
        var_11 = 1;
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
  var_0 = scripts\engine\utility::ref_143b9(3, "death");

  if(var_0 == "timeout") {
    self.evasivemaneuvers = 0;
    return;
  }
}

function watchguardevadedamage() {
  self endon("death");
  self endon("leaving");
  self endon("following_player");

  for(;;) {
    var_0 = undefined;

    if(istrue(self.evasivemaneuvers)) {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_3 = var_1 + randomintrange(-500, 500);
      var_4 = var_2 + randomintrange(-500, 500);
      var_5 = getcorrectheight(var_3, var_4, 350);
      var_0 = (var_3, var_4, var_5);
    }

    if(isDefined(var_0)) {
      self setvehgoalpos(var_0, 1);
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

function watchdropcratesearly(var_0) {
  self endon("dropped_crates");
  var_1 = self.dropcrates;
  self waittill("death");
  thread dropcrates(var_1, var_0);
}

function dropcrates(var_0, var_1) {
  self notify("dropped_crates");
}

function watchforcapture(var_0, var_1) {
  scripts\engine\utility::ref_143a5("captured", "death");
  var_0 notify("crate_captured_" + var_1);
}

function watchjackalcratepickup() {
  self endon("death");
  self endon("leaving");
  var_0 = 0;

  for(;;) {
    scripts\engine\utility::ref_143a6("crate_captured_0", "crate_captured_1", "crate_captured_2");
    var_0++;

    if(var_0 == self.dropcrates.size) {
      self notify("all_crates_gone");
      break;
    }
  }
}

function beginjackalescort(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.jackals)) {
    level.jackals = [];
  }

  var_6 = undefined;
  self notify("called_in_jackal");
  var_7 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_2 *= (1, 1, 0);
  var_8 = 1000;
  var_9 = var_2 + (0, 0, var_8);
  var_10 = spawnksjackal(var_0, self, var_1, var_9, var_3, var_4);
  var_10.pathgoal = var_9;
  thread defendlocationescort(var_10, var_6);
  return var_10;
}

function defendlocationescort(var_0, var_1) {
  var_0 endon("death");
  var_0 setvehgoalpos(var_0.pathgoal, 1);
  var_0 playsoundonmovingent("dropship_killstreak_thrust_change");
  thread closetogoalcheck(var_0);
  thread monitorowner();
  var_0 waittill("goal");
  thread watchgameendleave();
  thread engageprimarytarget();
  thread engagesecondarytarget();
  var_0 vehicle_setspeed(int(var_0.speed / 14), int(var_0.accel / 16));
}

function guardpositionescort(var_0, var_1, var_2) {
  self endon("death");
  self endon("leaving");
  self endon("follow_player");
  self endon("jackal_crashing");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));

  if(isDefined(var_1)) {
    self setlookatent(var_1);
  }

  if(isDefined(var_0)) {
    var_3 = undefined;
    var_4 = var_0[0];
    var_5 = var_0[1];

    if(istrue(self.evasivemaneuvers)) {
      var_6 = var_4 + randomintrange(-500, 500);
      var_7 = var_5 + randomintrange(-500, 500);
      var_8 = getcorrectheightescort(var_6, var_7, 350, var_2);
      var_3 = (var_6, var_7, var_8);
    } else {
      var_8 = getcorrectheightescort(var_5, var_8, 20, var_3);
      var_4 = (var_5, var_8, var_8);
    }

    self setvehgoalpos(var_4, 1);
    self.lastaction = "following_player";
    scripts\engine\utility::ref_143a5("goal", "begin_evasive_maneuvers");
    self clearlookatent();
    return;
  }
}

function getcorrectheightescort(var_0, var_1, var_2, var_3) {
  var_4 = 200;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  var_5 = tracegroundpoint(var_0, var_1);
  var_6 = var_5 + var_4;
  var_6 += randomint(var_2);
  return var_6;
}