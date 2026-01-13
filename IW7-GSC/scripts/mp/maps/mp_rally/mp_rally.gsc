/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_rally\mp_rally.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_rally\mp_rally_precache::main();
  scripts\mp\maps\mp_rally\gen\mp_rally_art::main();
  scripts\mp\maps\mp_rally\mp_rally_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_rally");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("r_umbraAccurateOcclusionThreshold", 1024);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread setupintroexploders();
  thread burninatorsetup("burninator_kill_trigger", "burninator_activator");
  thread setupspinningblades();
  thread barreldroppersetup("gas_barrel_activator_trigger", "gas_barrel_activator", "gas_barrel_lever", "gas_damage_trigger");
  thread setuppowerlines();
  thread wiggletheballoon("balloon");
  thread scripts\mp\animation_suite::animationsuite();
  level._effect["burn_kill"] = loadfx("vfx\iw7\levels\mp_rally\vfx_burninator_death.vfx");
  level._effect["blade_kill"] = loadfx("vfx\iw7\levels\mp_rally\vfx_body_exp.vfx");
  level._effect["shock_kill"] = loadfx("vfx\iw7\levels\mp_rally\vfx_shock_death.vfx");
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread apex_not_outofbounds();
  level.modifiedspawnpoints["-560 -1344 131"]["mp_tdm_spawn"]["remove"] = 1;
  level.modifiedspawnpoints["-560 -1344 131"]["mp_dom_spawn"]["remove"] = 1;
  level.modifiedspawnpoints["-560 -1344 131"]["mp_dm_spawn"]["remove"] = 1;
  thread fixcollision();
}

fixcollision() {
  var_0 = getent("clip64x64x128", "targetname");
  var_1 = spawn("script_model", (818, 1916, 56));
  var_1.angles = (0, 333, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = spawn("script_model", (160, 784, 96));
  var_2.angles = (0, 330, -180);
  var_2 setModel("mp_desert_uplink_col_01");
  var_3 = spawn("script_model", (1148, -52, 64));
  var_3.angles = (0, 205, 0);
  var_3 setModel("mp_desert_uplink_col_01");
}

wiggletheballoon(var_0) {
  level endon("game_ended");
  var_1 = getent(var_0, "targetname");
  for(;;) {
    var_1 rotateto((0, 0, 3), 5, 1, 1);
    wait(5);
    var_1 rotateto((0, 0, 0), 5, 1, 1);
    wait(5);
  }
}

setupspinningblades() {
  level endon("game_ended");
  var_0 = getEntArray("spinning_blades", "targetname");
  foreach(var_2 in var_0) {
    thread spinthisblade(var_2);
  }

  var_4 = getent("decapitator_kill_trigger", "targetname");
  for(;;) {
    var_4 waittill("trigger", var_5);
    if(isDefined(var_5)) {
      if(isDefined(var_5.streakname) && var_5.streakname == "remote_c8") {
        var_5 scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_5.triggerportableradarping, var_4, var_5.triggerportableradarping.team, var_4.origin, "MOD_MELEE", "bombproj_mp");
        continue;
      }

      if(isplayer(var_5)) {
        if(var_5 isinphase()) {
          continue;
        }

        var_5 suicide();
        if(var_5.loadoutarchetype == "archetype_scout") {
          playFX(level._effect["reaper_kill_robot"], var_5.origin + (0, 0, 0));
        } else {
          playFX(level._effect["blade_kill"], var_5.origin + (0, 0, 0));
        }

        continue;
      }

      if(isDefined(var_5.classname) && var_5.classname == "script_vehicle") {
        if(isDefined(var_5.streakname)) {
          if(var_5.streakname == "minijackal") {
            var_5 notify("minijackal_end");
            continue;
          }

          if(var_5.streakname == "venom") {
            var_5 notify("venom_end", var_5.origin);
          }
        }
      }
    }
  }
}

spinthisblade(var_0) {
  level endon("game_ended");
  for(;;) {
    var_0 rotateyaw(360, 0.25, 0, 0);
    wait(0.25);
  }
}

setuppowerlines() {
  level endon("game_ended");
  var_0 = getent("power_line_death", "targetname");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(isDefined(var_1)) {
      if(isplayer(var_1)) {
        if(var_1 isinphase()) {
          continue;
        }

        var_1 suicide();
        playFX(level._effect["shock_kill"], var_1.origin + (0, 0, 0));
        continue;
      }

      if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
        if(isDefined(var_1.streakname)) {
          if(var_1.streakname == "minijackal") {
            var_1 notify("minijackal_end");
            continue;
          }

          if(var_1.streakname == "venom") {
            var_1 notify("venom_end", var_1.origin);
          }
        }
      }
    }
  }
}

barreldroppersetup(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_0, "targetname");
  var_4 makeusable();
  var_4 sethintstring(&"MP_RALLY_ACTIVATE_BARREL");
  var_4 _meth_84A4(64);
  var_4 _meth_84A6(60);
  var_4 setuserange(64);
  var_4 setusefov(60);
  var_5 = getent(var_3, "targetname");
  var_5.killcament = spawn("script_model", (-544, -1312, 352));
  var_5.killcament setModel("tag_origin");
  var_5.israllytrap = 1;
  var_6 = scripts\engine\utility::getstruct("gas_barrel_explosion_loc", "targetname");
  var_5.explosionloc = var_6.origin;
  var_5 scripts\engine\utility::trigger_off(var_5.var_336, "targetname");
  var_7 = getent(var_1, "targetname");
  var_7.initialpos = var_7.origin;
  var_7.activepos = var_7.origin + (0, 0, -16);
  var_8 = getent(var_2, "targetname");
  var_8.initialpos = var_8.origin;
  var_8.activepos = var_8.origin + (0, 0, -16);
  thread barreldropperloop(var_4, var_7, var_8, var_5);
  thread barrelhandelwobbel(var_7);
}

barrelhandelwobbel(var_0) {
  level endon("game_ended");
  for(;;) {
    var_1 = randomfloatrange(-0.1, 0.1);
    var_2 = randomfloatrange(-5, 5);
    var_3 = randomfloatrange(-0.1, 0.1);
    var_0 rotateto((var_1, var_2, var_3), 2, 0.25, 0.25);
    wait(2);
  }
}

barreldropperloop(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  for(;;) {
    var_0 waittill("trigger", var_4);
    var_0 makeunusable();
    var_5 = var_4.team;
    var_4 playlocalsound("barrel_lever");
    scripts\engine\utility::exploder(30);
    var_1 moveto(var_1.activepos, 1, 0.5, 0.5);
    var_2 moveto(var_2.activepos, 1, 0.5, 0.5);
    playsoundatpos((-803, -1234, 526), "barrel_tumble");
    wait(1);
    var_1 moveto(var_1.initialpos, 1, 0.5, 0.5);
    var_2 moveto(var_2.initialpos, 1, 0.5, 0.5);
    wait(1);
    var_6 = level.players;
    var_7 = level.var_1655;
    var_3 scripts\engine\utility::trigger_on(var_3.var_336, "targetname");
    var_8 = scripts\engine\utility::array_combine(var_6, var_7);
    foreach(var_0A in var_6) {
      if(!var_0A isinphase() && !isDefined(var_0A.isrewinding) && var_0A.isrewinding == 1) {
        if(var_0A.team == var_5 && var_0A istouching(var_3)) {
          var_0A suicide();
          continue;
        }

        if(var_0A istouching(var_3)) {
          if(isDefined(var_4)) {
            var_0A dodamage(1000, var_3.explosionloc, var_4, var_3);
            continue;
          }

          var_0A suicide();
        }
      }
    }

    if(isDefined(var_7)) {
      foreach(var_0D in var_7) {
        if(var_0D istouching(var_3)) {
          if(var_0D.streakname == "minijackal") {
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_4, var_3, var_0D.team, var_3.origin, "MOD_EXPLOSIVE", "bombproj_mp");
            continue;
          }

          if(var_0D.streakname == "venom") {
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_4, var_3, var_0D.team, var_3.origin, "MOD_EXPLOSIVE", "bombproj_mp");
            continue;
          }

          if(var_0D.streakname == "sentry_shock") {
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_4, var_3, var_0D.team, var_3.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_4, var_3, var_0D.team, var_3.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_4, var_3, var_0D.team, var_3.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_4, var_3, var_0D.team, var_3.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_4, var_3, var_0D.team, var_3.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_4, var_3, var_0D.team, var_3.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_4, var_3, var_0D.team, var_3.origin, "MOD_MELEE", "bombproj_mp");
          }
        }
      }
    }

    var_0F = scripts\mp\perks\_perkfunctions::func_7D96();
    if(isDefined(var_0F)) {
      foreach(var_11 in var_0F) {
        if(var_11 istouching(var_3)) {
          var_11 scripts\mp\killstreaks\_utility::dodamagetokillstreak(1000, var_4, var_3, var_11.team, var_3.origin, "MOD_EXPLOSIVE", "bombproj_mp");
        }
      }
    }

    playsoundatpos(var_3.explosionloc, "barrel_impact");
    physicsexplosionsphere(var_3.explosionloc, 160, 80, 150);
    scripts\engine\utility::waitframe();
    var_13 = 1;
    thread lingeringgascloudwatch(var_13, var_3, var_4, var_5);
    wait(10);
    var_13 = 0;
    var_3 scripts\engine\utility::trigger_off(var_3.var_336, "targetname");
    var_0 makeusable();
  }
}

lingeringgascloudwatch(var_0, var_1, var_2, var_3) {
  while(var_0) {
    var_1 waittill("trigger", var_4);
    if(isplayer(var_4)) {
      if(isDefined(var_4.isrewinding) && var_4.isrewinding == 1) {
        continue;
      }

      if(!isDefined(var_4.isindoomjuice)) {
        thread playeringaswatcher(var_4, var_0, var_1, var_2, var_3);
        continue;
      }

      if(!var_4.isindoomjuice) {
        thread playeringaswatcher(var_4, var_0, var_1, var_2, var_3);
      }
    }
  }
}

playeringaswatcher(var_0, var_1, var_2, var_3, var_4) {
  var_0.isindoomjuice = 1;
  while(var_1 && var_0.isindoomjuice) {
    if(scripts\mp\utility::func_9EF0(var_0)) {
      break;
    }

    if(var_0 istouching(var_2)) {
      if(var_0.team == var_4) {
        if(var_0.health > 20) {
          var_0 dodamage(20, var_2.explosionloc, var_2);
        } else {
          var_0 suicide();
        }
      } else if(isDefined(var_3)) {
        var_0 dodamage(20, var_2.explosionloc, var_3);
      } else if(var_0.health > 20) {
        var_0 dodamage(20, var_2.explosionloc, var_2);
      } else {
        var_0 suicide();
      }

      continue;
    }

    var_0.isindoomjuice = 0;
    wait(1);
  }
}

burninatorsetup(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2.bigredbutton = getent(var_1, "targetname");
  var_2.bigredbutton makeusable();
  var_2.bigredbutton sethintstring(&"MP_RALLY_ACTIVATE_FIRE");
  var_2.bigredbutton _meth_84A4(64);
  var_2.bigredbutton _meth_84A6(60);
  var_2.bigredbutton setuserange(64);
  var_2.bigredbutton setusefov(60);
  var_2.killcament = spawn("script_model", (956, 996, 268));
  var_2.killcament setModel("tag_origin");
  var_2.israllytrap = 1;
  thread burninatortriggerwatch(var_2);
  var_2.flameon = 0;
}

burninatortriggerwatch(var_0) {
  level endon("game_ended");
  for(;;) {
    var_0.bigredbutton waittill("trigger", var_1);
    var_0.bigredbutton makeunusable();
    scripts\engine\utility::exploder(22);
    wait(2);
    var_0.flameon = 1;
    thread watchforvictims(var_0, var_1);
    thread burninantordestroyequipment(var_0, var_1);
    wait(10);
    var_0.flameon = 0;
    var_0.bigredbutton makeusable();
  }
}

burninantordestroyequipment(var_0, var_1) {
  while(var_0.flameon) {
    var_2 = level.var_1655;
    var_3 = scripts\mp\perks\_perkfunctions::func_7D96();
    if(isDefined(var_3)) {
      foreach(var_5 in var_3) {
        if(var_5 istouching(var_0)) {
          var_5 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000, var_1, var_0, var_5.team, var_0.origin, "MOD_EXPLOSIVE", "bombproj_mp");
        }
      }
    }

    if(isDefined(var_2)) {
      foreach(var_5 in var_2) {
        if(var_5.streakname == "sentry_shock" && var_5 istouching(var_0)) {
          var_5 scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_1, var_0, var_5.team, var_0.origin, "MOD_MELEE", "bombproj_mp");
        }
      }
    }

    wait(0.25);
  }
}

watchforvictims(var_0, var_1) {
  level endon("game_ended");
  while(var_0.flameon) {
    var_0 waittill("trigger", var_2);
    if(!var_0.flameon) {
      break;
    }

    if(isDefined(var_2)) {
      if(isplayer(var_2)) {
        if(var_2 isinphase()) {
          continue;
        }

        if(isDefined(var_2.isrewinding) && var_2.isrewinding == 1) {
          continue;
        }

        burninatorplaydeathfx(var_0, var_2, var_1);
        scripts\engine\utility::waitframe();
        scripts\engine\utility::waitframe();
        continue;
      }

      if(isDefined(var_2.classname) && var_2.classname == "script_vehicle") {
        if(isDefined(var_2.streakname)) {
          if(var_2.streakname == "minijackal") {
            var_2 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000, var_1, var_0, var_2.team, var_0.origin, "MOD_EXPLOSIVE", "bombproj_mp");
            continue;
          }

          if(var_2.streakname == "venom") {
            var_2 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000, var_1, var_0, var_2.team, var_0.origin, "MOD_EXPLOSIVE", "bombproj_mp");
          }
        }
      }
    }
  }
}

burninatorplaydeathfx(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_1.team != var_2.team) {
    var_1 dodamage(10000, var_0.origin, var_2, var_0);
  } else {
    var_1 suicide();
  }

  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  var_3 = anglesToForward(var_1.angles);
  var_4 = var_1 _meth_8113();
  if(isDefined(var_4)) {
    var_4 hide(1);
    var_4.permanentcustommovetransition = 1;
    if(var_1.loadoutarchetype == "archetype_scout") {
      playFX(level._effect["reaper_kill_robot"], var_1.origin + (0, 0, 0));
      return;
    }

    playFX(level._effect["burn_kill"], var_1.origin + (0, 0, 0), var_3);
  }
}

setupintroexploders() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread fireintroexploders();
    var_0 thread watchforkillstreakuse();
  }
}

fireintroexploders() {
  self waittill("mapCamera_start");
  wait(0.5);
  scripts\engine\utility::exploder(10, self);
  wait(1);
  scripts\engine\utility::exploder(15, self);
}

watchforkillstreakuse() {
  self endon("disconnect");
  for(;;) {
    self waittill("killstreak_use_finished", var_0, var_1);
    if(!scripts\engine\utility::istrue(var_1)) {
      continue;
    }

    if(!killstreakactivateflares(var_0)) {
      continue;
    }

    scripts\engine\utility::exploder(15);
  }
}

killstreakactivateflares(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "thor":
    case "nuke":
    case "precision_airstrike":
    case "bombardment":
    case "jackal":
    case "sentry_shock":
    case "minijackal":
    case "remote_c8":
      var_1 = 1;
      break;
  }

  return var_1;
}

firebroshotexploders() {
  self waittill("bro_shot_start");
  wait(0.5);
  scripts\engine\utility::exploder(15, self);
}

apex_not_outofbounds() {
  level.outofboundstriggerpatches = [];
  var_0 = getent("apex_unoutofbounds", "targetname");
  level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_0;
  level waittill("game_ended");
  foreach(var_0 in level.outofboundstriggerpatches) {
    if(isDefined(var_0)) {
      var_0 delete();
    }
  }
}