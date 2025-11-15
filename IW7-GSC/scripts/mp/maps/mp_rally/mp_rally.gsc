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
  var_00 = getent("clip64x64x128", "targetname");
  var_01 = spawn("script_model", (818, 1916, 56));
  var_01.angles = (0, 333, 0);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = spawn("script_model", (160, 784, 96));
  var_02.angles = (0, 330, -180);
  var_02 setModel("mp_desert_uplink_col_01");
  var_03 = spawn("script_model", (1148, -52, 64));
  var_03.angles = (0, 205, 0);
  var_03 setModel("mp_desert_uplink_col_01");
}

wiggletheballoon(param_00) {
  level endon("game_ended");
  var_01 = getent(param_00, "targetname");
  for(;;) {
    var_01 rotateto((0, 0, 3), 5, 1, 1);
    wait(5);
    var_01 rotateto((0, 0, 0), 5, 1, 1);
    wait(5);
  }
}

setupspinningblades() {
  level endon("game_ended");
  var_00 = getEntArray("spinning_blades", "targetname");
  foreach(var_02 in var_00) {
    thread spinthisblade(var_02);
  }

  var_04 = getent("decapitator_kill_trigger", "targetname");
  for(;;) {
    var_04 waittill("trigger", var_05);
    if(isDefined(var_05)) {
      if(isDefined(var_05.streakname) && var_05.streakname == "remote_c8") {
        var_05 scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_05.triggerportableradarping, var_04, var_05.triggerportableradarping.team, var_04.origin, "MOD_MELEE", "bombproj_mp");
        continue;
      }

      if(isplayer(var_05)) {
        if(var_05 isinphase()) {
          continue;
        }

        var_05 suicide();
        if(var_05.loadoutarchetype == "archetype_scout") {
          playFX(level._effect["reaper_kill_robot"], var_05.origin + (0, 0, 0));
        } else {
          playFX(level._effect["blade_kill"], var_05.origin + (0, 0, 0));
        }

        continue;
      }

      if(isDefined(var_05.classname) && var_05.classname == "script_vehicle") {
        if(isDefined(var_05.streakname)) {
          if(var_05.streakname == "minijackal") {
            var_05 notify("minijackal_end");
            continue;
          }

          if(var_05.streakname == "venom") {
            var_05 notify("venom_end", var_05.origin);
          }
        }
      }
    }
  }
}

spinthisblade(param_00) {
  level endon("game_ended");
  for(;;) {
    param_00 rotateyaw(360, 0.25, 0, 0);
    wait(0.25);
  }
}

setuppowerlines() {
  level endon("game_ended");
  var_00 = getent("power_line_death", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(isDefined(var_01)) {
      if(isplayer(var_01)) {
        if(var_01 isinphase()) {
          continue;
        }

        var_01 suicide();
        playFX(level._effect["shock_kill"], var_01.origin + (0, 0, 0));
        continue;
      }

      if(isDefined(var_01.classname) && var_01.classname == "script_vehicle") {
        if(isDefined(var_01.streakname)) {
          if(var_01.streakname == "minijackal") {
            var_01 notify("minijackal_end");
            continue;
          }

          if(var_01.streakname == "venom") {
            var_01 notify("venom_end", var_01.origin);
          }
        }
      }
    }
  }
}

barreldroppersetup(param_00, param_01, param_02, param_03) {
  var_04 = getent(param_00, "targetname");
  var_04 makeusable();
  var_04 sethintstring( & "MP_RALLY_ACTIVATE_BARREL");
  var_04 _meth_84A4(64);
  var_04 _meth_84A6(60);
  var_04 setuserange(64);
  var_04 setusefov(60);
  var_05 = getent(param_03, "targetname");
  var_05.killcament = spawn("script_model", (-544, -1312, 352));
  var_05.killcament setModel("tag_origin");
  var_05.israllytrap = 1;
  var_06 = scripts\engine\utility::getstruct("gas_barrel_explosion_loc", "targetname");
  var_05.explosionloc = var_06.origin;
  var_05 scripts\engine\utility::trigger_off(var_05.var_336, "targetname");
  var_07 = getent(param_01, "targetname");
  var_07.initialpos = var_07.origin;
  var_07.activepos = var_07.origin + (0, 0, -16);
  var_08 = getent(param_02, "targetname");
  var_08.initialpos = var_08.origin;
  var_08.activepos = var_08.origin + (0, 0, -16);
  thread barreldropperloop(var_04, var_07, var_08, var_05);
  thread barrelhandelwobbel(var_07);
}

barrelhandelwobbel(param_00) {
  level endon("game_ended");
  for(;;) {
    var_01 = randomfloatrange(-0.1, 0.1);
    var_02 = randomfloatrange(-5, 5);
    var_03 = randomfloatrange(-0.1, 0.1);
    param_00 rotateto((var_01, var_02, var_03), 2, 0.25, 0.25);
    wait(2);
  }
}

barreldropperloop(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  for(;;) {
    param_00 waittill("trigger", var_04);
    param_00 makeunusable();
    var_05 = var_04.team;
    var_04 playlocalsound("barrel_lever");
    scripts\engine\utility::exploder(30);
    param_01 moveto(param_01.activepos, 1, 0.5, 0.5);
    param_02 moveto(param_02.activepos, 1, 0.5, 0.5);
    playsoundatpos((-803, -1234, 526), "barrel_tumble");
    wait(1);
    param_01 moveto(param_01.initialpos, 1, 0.5, 0.5);
    param_02 moveto(param_02.initialpos, 1, 0.5, 0.5);
    wait(1);
    var_06 = level.players;
    var_07 = level.var_1655;
    param_03 scripts\engine\utility::trigger_on(param_03.var_336, "targetname");
    var_08 = scripts\engine\utility::array_combine(var_06, var_07);
    foreach(var_0A in var_06) {
      if(!var_0A isinphase() && !isDefined(var_0A.isrewinding) && var_0A.isrewinding == 1) {
        if(var_0A.team == var_05 && var_0A istouching(param_03)) {
          var_0A suicide();
          continue;
        }

        if(var_0A istouching(param_03)) {
          if(isDefined(var_04)) {
            var_0A dodamage(1000, param_03.explosionloc, var_04, param_03);
            continue;
          }

          var_0A suicide();
        }
      }
    }

    if(isDefined(var_07)) {
      foreach(var_0D in var_07) {
        if(var_0D istouching(param_03)) {
          if(var_0D.streakname == "minijackal") {
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_04, param_03, var_0D.team, param_03.origin, "MOD_EXPLOSIVE", "bombproj_mp");
            continue;
          }

          if(var_0D.streakname == "venom") {
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_04, param_03, var_0D.team, param_03.origin, "MOD_EXPLOSIVE", "bombproj_mp");
            continue;
          }

          if(var_0D.streakname == "sentry_shock") {
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_04, param_03, var_0D.team, param_03.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_04, param_03, var_0D.team, param_03.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_04, param_03, var_0D.team, param_03.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_04, param_03, var_0D.team, param_03.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_04, param_03, var_0D.team, param_03.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_04, param_03, var_0D.team, param_03.origin, "MOD_MELEE", "bombproj_mp");
            scripts\engine\utility::waitframe();
            var_0D scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, var_04, param_03, var_0D.team, param_03.origin, "MOD_MELEE", "bombproj_mp");
          }
        }
      }
    }

    var_0F = scripts\mp\perks\_perkfunctions::func_7D96();
    if(isDefined(var_0F)) {
      foreach(var_11 in var_0F) {
        if(var_11 istouching(param_03)) {
          var_11 scripts\mp\killstreaks\_utility::dodamagetokillstreak(1000, var_04, param_03, var_11.team, param_03.origin, "MOD_EXPLOSIVE", "bombproj_mp");
        }
      }
    }

    playsoundatpos(param_03.explosionloc, "barrel_impact");
    physicsexplosionsphere(param_03.explosionloc, 160, 80, 150);
    scripts\engine\utility::waitframe();
    var_13 = 1;
    thread lingeringgascloudwatch(var_13, param_03, var_04, var_05);
    wait(10);
    var_13 = 0;
    param_03 scripts\engine\utility::trigger_off(param_03.var_336, "targetname");
    param_00 makeusable();
  }
}

lingeringgascloudwatch(param_00, param_01, param_02, param_03) {
  while(param_00) {
    param_01 waittill("trigger", var_04);
    if(isplayer(var_04)) {
      if(isDefined(var_04.isrewinding) && var_04.isrewinding == 1) {
        continue;
      }

      if(!isDefined(var_04.isindoomjuice)) {
        thread playeringaswatcher(var_04, param_00, param_01, param_02, param_03);
        continue;
      }

      if(!var_04.isindoomjuice) {
        thread playeringaswatcher(var_04, param_00, param_01, param_02, param_03);
      }
    }
  }
}

playeringaswatcher(param_00, param_01, param_02, param_03, param_04) {
  param_00.isindoomjuice = 1;
  while(param_01 && param_00.isindoomjuice) {
    if(scripts\mp\utility::func_9EF0(param_00)) {
      break;
    }

    if(param_00 istouching(param_02)) {
      if(param_00.team == param_04) {
        if(param_00.health > 20) {
          param_00 dodamage(20, param_02.explosionloc, param_02);
        } else {
          param_00 suicide();
        }
      } else if(isDefined(param_03)) {
        param_00 dodamage(20, param_02.explosionloc, param_03);
      } else if(param_00.health > 20) {
        param_00 dodamage(20, param_02.explosionloc, param_02);
      } else {
        param_00 suicide();
      }

      continue;
    }

    param_00.isindoomjuice = 0;
    wait(1);
  }
}

burninatorsetup(param_00, param_01) {
  var_02 = getent(param_00, "targetname");
  var_02.bigredbutton = getent(param_01, "targetname");
  var_02.bigredbutton makeusable();
  var_02.bigredbutton sethintstring( & "MP_RALLY_ACTIVATE_FIRE");
  var_02.bigredbutton _meth_84A4(64);
  var_02.bigredbutton _meth_84A6(60);
  var_02.bigredbutton setuserange(64);
  var_02.bigredbutton setusefov(60);
  var_02.killcament = spawn("script_model", (956, 996, 268));
  var_02.killcament setModel("tag_origin");
  var_02.israllytrap = 1;
  thread burninatortriggerwatch(var_02);
  var_02.flameon = 0;
}

burninatortriggerwatch(param_00) {
  level endon("game_ended");
  for(;;) {
    param_00.bigredbutton waittill("trigger", var_01);
    param_00.bigredbutton makeunusable();
    scripts\engine\utility::exploder(22);
    wait(2);
    param_00.flameon = 1;
    thread watchforvictims(param_00, var_01);
    thread burninantordestroyequipment(param_00, var_01);
    wait(10);
    param_00.flameon = 0;
    param_00.bigredbutton makeusable();
  }
}

burninantordestroyequipment(param_00, param_01) {
  while(param_00.flameon) {
    var_02 = level.var_1655;
    var_03 = scripts\mp\perks\_perkfunctions::func_7D96();
    if(isDefined(var_03)) {
      foreach(var_05 in var_03) {
        if(var_05 istouching(param_00)) {
          var_05 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000, param_01, param_00, var_05.team, param_00.origin, "MOD_EXPLOSIVE", "bombproj_mp");
        }
      }
    }

    if(isDefined(var_02)) {
      foreach(var_05 in var_02) {
        if(var_05.streakname == "sentry_shock" && var_05 istouching(param_00)) {
          var_05 scripts\mp\killstreaks\_utility::dodamagetokillstreak(100000, param_01, param_00, var_05.team, param_00.origin, "MOD_MELEE", "bombproj_mp");
        }
      }
    }

    wait(0.25);
  }
}

watchforvictims(param_00, param_01) {
  level endon("game_ended");
  while(param_00.flameon) {
    param_00 waittill("trigger", var_02);
    if(!param_00.flameon) {
      break;
    }

    if(isDefined(var_02)) {
      if(isplayer(var_02)) {
        if(var_02 isinphase()) {
          continue;
        }

        if(isDefined(var_02.isrewinding) && var_02.isrewinding == 1) {
          continue;
        }

        burninatorplaydeathfx(param_00, var_02, param_01);
        scripts\engine\utility::waitframe();
        scripts\engine\utility::waitframe();
        continue;
      }

      if(isDefined(var_02.classname) && var_02.classname == "script_vehicle") {
        if(isDefined(var_02.streakname)) {
          if(var_02.streakname == "minijackal") {
            var_02 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000, param_01, param_00, var_02.team, param_00.origin, "MOD_EXPLOSIVE", "bombproj_mp");
            continue;
          }

          if(var_02.streakname == "venom") {
            var_02 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000, param_01, param_00, var_02.team, param_00.origin, "MOD_EXPLOSIVE", "bombproj_mp");
          }
        }
      }
    }
  }
}

burninatorplaydeathfx(param_00, param_01, param_02) {
  if(isDefined(param_02) && param_01.team != param_02.team) {
    param_01 dodamage(10000, param_00.origin, param_02, param_00);
  } else {
    param_01 suicide();
  }

  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  var_03 = anglesToForward(param_01.angles);
  var_04 = param_01 _meth_8113();
  if(isDefined(var_04)) {
    var_04 hide(1);
    var_04.permanentcustommovetransition = 1;
    if(param_01.loadoutarchetype == "archetype_scout") {
      playFX(level._effect["reaper_kill_robot"], param_01.origin + (0, 0, 0));
      return;
    }

    playFX(level._effect["burn_kill"], param_01.origin + (0, 0, 0), var_03);
  }
}

setupintroexploders() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread fireintroexploders();
    var_00 thread watchforkillstreakuse();
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
    self waittill("killstreak_use_finished", var_00, var_01);
    if(!scripts\engine\utility::istrue(var_01)) {
      continue;
    }

    if(!killstreakactivateflares(var_00)) {
      continue;
    }

    scripts\engine\utility::exploder(15);
  }
}

killstreakactivateflares(param_00) {
  var_01 = 0;
  switch (param_00) {
    case "thor":
    case "nuke":
    case "precision_airstrike":
    case "bombardment":
    case "jackal":
    case "sentry_shock":
    case "minijackal":
    case "remote_c8":
      var_01 = 1;
      break;
  }

  return var_01;
}

firebroshotexploders() {
  self waittill("bro_shot_start");
  wait(0.5);
  scripts\engine\utility::exploder(15, self);
}

apex_not_outofbounds() {
  level.outofboundstriggerpatches = [];
  var_00 = getent("apex_unoutofbounds", "targetname");
  level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_00;
  level waittill("game_ended");
  foreach(var_00 in level.outofboundstriggerpatches) {
    if(isDefined(var_00)) {
      var_00 delete();
    }
  }
}