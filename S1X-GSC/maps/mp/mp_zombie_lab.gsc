/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_lab.gsc
**************************************/

main() {
  maps\mp\mp_zombie_lab_precache::main();
  maps\mp\mp_zombie_lab_fx::main();
  maps\createart\mp_zombie_lab_fog::main();
  maps\createart\mp_zombie_lab_fog_hdr::main();
  maps\createart\mp_zombie_lab_art::main();

  if(getdvar("r_reflectionProbeGenerate") == "1") {
    onreflectionprobecompile();
  }

  maps\mp\_load::main();
  maps\mp\mp_zombie_lab_lighting::main();
  maps\mp\mp_zombie_lab_aud::main();
  maps\mp\mp_zombie_lab_sq::init_sidequest();
  zombielabfixupminimapcorners();
  maps\mp\_compass::setupminimap("compass_map_mp_zombie_lab");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.zombiehostinit = maps\mp\zombies\zombie_host::init;
  level.zombiedoginit = maps\mp\zombies\zombie_dog::init;
  maps\mp\zombies\_util::enabletokens();
  level.zombies_using_civilians = 0;
  level.zombieinfectedvisionset = "mp_zombie_lab_infected";
  level.zombieinfectedvisionset2 = "mp_zombie_lab_infected_crazy";
  level.zombieinfectedlightset = "mp_zombie_lab_infected";
  level.onstartgametypelevelfunc = ::onzombielabstartgame;
  level._zmbvoxlevelspecific = ::initwaveintermissiondialog;
  level.shouldignoreplayercallback = ::labshouldignoreplayer;
  thread initlabmutators();
  thread initzones();
  thread initcharactermodels();
  thread biochamber();
  thread deleteexoterminallargetriggeronpower();

  if(level.nextgen) {
    thread crashhelianim();
  }

  if(level.nextgen) {
    level thread zombielabpatchclip();
  }

  level.zmpatchshovefunc = ::zombielabpatchshove;

  if(level.currentgen) {
    var_0 = getEntArray("CG_ExtraExploitTriggers", "targetname");

    foreach(var_2 in var_0) {
      var_2 thread cg_exploittriggermonitor();
    }

    var_0 = getEntArray("cg_trigger_break_glass", "targetname");

    foreach(var_2 in var_0) {
      var_2 thread cg_breakglasstriggermonitor();
    }

    thread zombiestuckspotfix01();
  }
}

zombiestuckspotfix01() {
  level endon("game_ended");
  var_0 = spawn("trigger_radius", (-956, 3572, 68), 0, 164, 128);

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1) && !isremovedentity(var_1) && isalive(var_1) && isagent(var_1) && !isDefined(var_1.object_avoid) && isDefined(var_1.team) && var_1.team == level.enemyteam) {
      var_1 scragentsetobstacleavoid(1);
      var_1.object_avoid = 1;
      var_1 thread resetavoidtimer();
    }
  }
}

resetavoidtimer() {
  level endon("game_ended");
  wait 4;

  if(isDefined(self) && !isremovedentity(self)) {
    self scragentsetobstacleavoid(0);
    self.object_avoid = undefined;
  }
}

onreflectionprobecompile() {
  var_0 = getEntArray("power_show", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }

  var_4 = getEntArray("power_hide", "targetname");

  foreach(var_2 in var_4) {
    var_2 delete();
  }
}

zombielabfixupminimapcorners() {
  var_0 = getEntArray("minimap_corner", "targetname");

  if(var_0.size != 2) {
    return;
  }
  var_0[0].origin = (-4608, 6912, 192);
  var_0[1].origin = (3072, -768, 128);
}

zombielabpatchclip() {
  maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32", (185, 1627, 136), (0, -42.7, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32", (348, 3126, 180), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32", (348, 3146, 180), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (1355, 1095, 170), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (988, 1287, 144), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64", (785, 1089, 144), (0, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128", (703, 1373, 104), (0, -45, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128", (-1009, 3372, 253), (-5, 0, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128", (1094.5, 3422.5, 392), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (-571.5, 2502.5, 192), (0, 45, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (878, 1988.5, 324), (0, 90, 0));
  maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256", (1586.5, 1152, 336), (5, 45, 0));
  level thread killglass();
}

zombielabpatchshove(var_0, var_1) {
  if(var_0) {
    if(self.currentzone == "military" && distancesquared(self.origin, (-1845.12, 2704, 267.125)) < 16) {
      self setvelocity((100, 0, 0));
    } else if(self.currentzone == "experimentation") {
      if(abs(self.origin[2] - 300) < 5 && abs(self.origin[1] - 3187) < 5) {
        var_2 = self getnearestnode();

        if(isDefined(var_2) && self.origin[2] - var_2.origin[2] > 40) {
          self setvelocity((0, -100, 0));
          return;
        }
      } else if(distancesquared(self.origin, (376.846, 3177.79, 286.386)) < 100) {
        self setvelocity((100, -100, 0));
      } else if(distancesquared(self.origin, (375.539, 3164.19, 284.327)) < 64) {
        self setvelocity((100, 0, 0));
      } else if(distancesquared(self.origin, (375.551, 3156.28, 279.062)) < 16) {
        self setvelocity((100, 0, 0));
      } else if(distancesquared(self.origin, (375.59, 3144.32, 271.104)) < 64) {
        self setvelocity((100, 0, 0));
      } else if(distancesquared(self.origin, (378.329, 3131.99, 262.901)) < 16) {
        self setvelocity((100, 0, 0));
      } else if(distancesquared(self.origin, (375.024, 3115.55, 251.955)) < 16) {
        self setvelocity((100, 0, 0));
      }
    }
  } else if(var_1) {
    if(self.currentzone == "roundabout") {
      var_3 = (112, 1543, 272);
      var_4 = vectornormalize((self.origin - var_3) * (1, 1, 0));

      if(abs(self.origin[2] - 200) < 14) {
        var_2 = self getnearestnode();

        if(isDefined(var_2) && self.origin[2] - var_2.origin[2] > 68) {
          self setvelocity(var_4 * 200);
          return;
        }

        return;
      }

      if(distancesquared(self.origin, (-60.1366, 1600.78, 248.625)) < 100) {
        self setvelocity(var_4 * 200);
        return;
      }

      if(distancesquared(self.origin, (-53.4371, 1619.16, 248.625)) < 16) {
        self setvelocity(var_4 * 200);
        return;
      }

      return;
      return;
    } else if(self.currentzone == "experimentation" && distancesquared(self.origin, (265.649, 3985.21, 291.625)) < 64) {
      var_2 = self getnearestnode();

      if(isDefined(var_2)) {
        var_5 = vectornormalize((var_2.origin - self.origin) * (1, 1, 0));
        self setvelocity(var_5 * 100);
        return;
      }
    } else if(self.currentzone == "lab_hall") {
      if(self.origin[2] > 125) {
        if(self.origin[0] > 1135 && self.origin[0] < 1382 && self.origin[1] > 1601 && self.origin[1] < 1638) {
          self setvelocity((0, -200, 0));
        }
      }
    }
  }
}

killglass() {
  for(;;) {
    var_0 = 1;
    var_1 = 1;

    if(!isDefined(level.players)) {
      wait 1.0;
    }

    foreach(var_3 in level.players) {
      if(!isalive(var_3)) {
        continue;
      }
      if(var_3.sessionstate == "spectator" || var_3.sessionstate == "intermission") {
        continue;
      }
      if(var_0 && isglassdestroyed(3)) {
        var_0 = 0;
      }

      if(var_1 && isglassdestroyed(11)) {
        var_1 = 0;
      }

      if(!var_0 && !var_1) {
        break;
      }

      if(isDefined(var_3.currentzone) && var_3.currentzone == "lab") {
        if(abs(var_3.origin[0] - 1248) < 6 && abs(var_3.origin[2] - 224) < 5) {
          if(var_0 && abs(var_3.origin[1] - 3261.5) < 50) {
            destroyglass(3);
          }

          if(var_1 && abs(var_3.origin[1] - 3344.5) < 50) {
            destroyglass(11);
          }
        }
      }
    }

    wait 1.0;
  }
}

onzombielabstartgame() {
  level thread maps\mp\zombies\_teleport::init();
  level thread maps\mp\zombies\_util::outofboundswatch(0);
  maps\mp\zombies\_traps::register_trap_state_models("dlc_trap_activation_console_01_no_signal", "dlc_trap_activation_console_01_ready", "dlc_trap_activation_console_01_active", "dlc_trap_activation_console_01_cooldown");
}

initlabmutators() {
  maps\mp\zombies\_mutators::initfastmutator();
  maps\mp\zombies\_mutators::initexplodermutator();
  maps\mp\zombies\_mutators::initemzmutator();
}

initzones() {
  maps\mp\zombies\_zombies_zone_manager::init();
  maps\mp\zombies\_zombies_zone_manager::initializezone("courtyard", 1);
  maps\mp\zombies\_zombies_zone_manager::initializezone("roundabout");
  maps\mp\zombies\_zombies_zone_manager::initializezone("administration");
  maps\mp\zombies\_zombies_zone_manager::initializezone("lab");
  maps\mp\zombies\_zombies_zone_manager::initializezone("lab_hall");
  maps\mp\zombies\_zombies_zone_manager::initializezone("military");
  maps\mp\zombies\_zombies_zone_manager::initializezone("experimentation");
  maps\mp\zombies\_zombies_zone_manager::initializezone("experimentation_stairs");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("courtyard", "roundabout", "courtyard_to_roundabout");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("courtyard", "administration", "courtyard_to_administration");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("roundabout", "military", "roundabout_to_military");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("roundabout", "lab_hall", "roundabout_to_lab");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("administration", "lab_hall", "administration_to_lab");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("lab", "experimentation", "lab_to_experimentation");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("military", "experimentation_stairs", "military_to_experimentation");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("experimentation", "experimentation_stairs", "military_or_lab_to_experimentation");
  maps\mp\zombies\_util::flag_link("military_to_experimentation", "military_or_lab_to_experimentation");
  maps\mp\zombies\_util::flag_link("lab_to_experimentation", "military_or_lab_to_experimentation");
  maps\mp\zombies\_zombies_zone_manager::addadjacentzone("lab", "lab_hall", "roundabout_or_administration_or_experimentation_to_lab");
  maps\mp\zombies\_util::flag_link("administration_to_lab", "roundabout_or_administration_or_experimentation_to_lab");
  maps\mp\zombies\_util::flag_link("roundabout_to_lab", "roundabout_or_administration_or_experimentation_to_lab");
  maps\mp\zombies\_util::flag_link("lab_to_experimentation", "roundabout_or_administration_or_experimentation_to_lab");
  maps\mp\zombies\_zombies_zone_manager::activate();
  level.doorbitmaskarray = [];
  level.doorbitmaskarray["courtyard_to_roundabout"] = 1;
  level.doorbitmaskarray["roundabout_to_lab"] = 2;
  level.doorbitmaskarray["roundabout_to_military"] = 4;
  level.doorbitmaskarray["courtyard_to_administration"] = 8;
  level.doorbitmaskarray["administration_to_lab"] = 16;
  level.doorbitmaskarray["lab_to_experimentation"] = 32;
  level.doorbitmaskarray["military_to_experimentation"] = 64;
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_ROUNDABOUT", "courtyard_to_roundabout", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_COURTYARD", "courtyard_to_roundabout", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_LAB", "roundabout_to_lab", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_ROUNDABOUT", "roundabout_to_lab", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_MILITARY", "roundabout_to_military", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_ROUNDABOUT", "roundabout_to_military", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_ADMIN", "courtyard_to_administration", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_COURTYARD", "courtyard_to_administration", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_LAB", "administration_to_lab", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_ADMIN", "administration_to_lab", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_EXPER", "lab_to_experimentation", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_LAB", "lab_to_experimentation", 1);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_EXPER", "military_to_experimentation", 0);
  maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_MILITARY", "military_to_experimentation", 1);
}

initcharactermodels() {
  maps\mp\zombies\_util::initializecharactermodel("security", "security_guard_body", "viewhands_security_guard", ["security_guard_head"]);
  maps\mp\zombies\_util::initializecharactermodel("exec", "executive_body", "viewhands_executive", ["executive_head"]);
  maps\mp\zombies\_util::initializecharactermodel("it", "lilith_body", "viewhands_lilith", ["lilith_head"]);
  maps\mp\zombies\_util::initializecharactermodel("janitor", "janitor_body", "viewhands_janitor", ["janitor_head"]);
  maps\mp\zombies\_util::initializecharactermodel("security_exo", "security_guard_body_exo", "viewhands_security_guard_exo", ["security_guard_head"]);
  maps\mp\zombies\_util::initializecharactermodel("exec_exo", "executive_body_exo", "viewhands_executive_exo", ["executive_head"]);
  maps\mp\zombies\_util::initializecharactermodel("it_exo", "lilith_body_exo", "viewhands_lilith_exo", ["lilith_head"]);
  maps\mp\zombies\_util::initializecharactermodel("janitor_exo", "janitor_body_exo", "viewhands_janitor_exo", ["janitor_head"]);
  maps\mp\zombies\_util::initializecharactermodel("security_host", "security_guard_body", undefined, ["security_guard_head_z"]);
  maps\mp\zombies\_util::initializecharactermodel("exec_host", "executive_body", undefined, ["executive_head_z"]);
  maps\mp\zombies\_util::initializecharactermodel("it_host", "lilith_body", undefined, ["lilith_head_z"]);
  maps\mp\zombies\_util::initializecharactermodel("janitor_host", "janitor_body", undefined, ["janitor_head_z"]);
}

biochamber() {
  precachempanim("dlc_lab_exo_cage_closed_idle");
  precachempanim("dlc_lab_exo_cage_open");
  var_0 = getEntArray("biochamber_top", "targetname");

  foreach(var_2 in var_0) {
    var_2 linktargetedents();
  }

  var_4 = getEntArray("biochamber_bottom", "targetname");

  foreach(var_6 in var_4) {
    var_6 linktargetedents();
  }

  var_8 = common_scripts\utility::getstruct("exo_cage_animnode", "targetname");
  var_9 = getent("exo_cage", "targetname");

  if(isDefined(var_9) && isDefined(var_8)) {
    var_9 scriptmodelplayanimdeltamotionfrompos("dlc_lab_exo_cage_closed_idle", var_8.origin, var_8.angles);
  }

  activatepersistentclientexploder(99);
  level waittill("power_experimentation_01");
  stopclientexploder(99);
  common_scripts\_exploder::activate_clientside_exploder(100);

  if(isDefined(var_9) && isDefined(var_8)) {
    var_9 scriptmodelplayanimdeltamotionfrompos("dlc_lab_exo_cage_open", var_8.origin, var_8.angles);
  }

  foreach(var_2 in var_0) {
    if(var_2 maps\mp\_movers::script_mover_is_dynamic_path()) {
      var_2 connectpaths();
    }

    var_2 moveto(var_2.origin + (0, 0, 132), 2);
  }

  foreach(var_6 in var_4) {
    if(var_6 maps\mp\_movers::script_mover_is_dynamic_path()) {
      var_6 connectpaths();
    }

    var_6 moveto(var_6.origin - (0, 0, 132), 2);
  }

  wait 3.5;
  maps\mp\zombies\_zombies_audio_announcer::announcerexoonlinedialog();
  thread playexosuitvoattractor();
}

playexosuitvoattractor() {
  var_0 = 360000;
  var_1 = getEntArray("exo_terminal", "targetname");

  if(var_1.size == 0) {
    return;
  }
  wait 10;
  var_2 = var_1[0];

  for(;;) {
    if(maps\mp\zombies\_zombies_audio_announcer::isannouncerspeaking()) {
      maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
      wait 1;
      continue;
    }

    var_3 = [];
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(maps\mp\zombies\_util::is_true(var_6.exosuitonline)) {
        continue;
      }
      var_4++;

      if(distance2dsquared(var_2.origin, var_6.origin) > var_0) {
        continue;
      }
      var_3[var_3.size] = var_6;
    }

    if(var_4 == 0) {
      return;
    } else {
      maps\mp\zombies\_zombies_audio_announcer::announcerglobalattractordialog("exo_suit_avail", var_3);
    }

    wait 15;
  }
}

linktargetedents() {
  if(!isDefined(self.target)) {
    return;
  }
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    var_2 linkto(self);
  }
}

deleteexoterminallargetriggeronpower() {
  waitframe();
  var_0 = getent("exo_terminal_large_power_off", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  common_scripts\utility::flag_wait(var_0.script_flag_true);
  var_0 delete();
}

initwaveintermissiondialog() {
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_exec_1", "it_exec_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_exec_2", "it_exec_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_3", "it_exec_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_4", "it_exec_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_exec_5", "it_exec_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_exec_6", "it_exec_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_exec_7", "it_exec_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_it_8", "it_exec_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_exec_9", "it_exec_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_exec_10", "it_exec_wave_intermission_ctx10", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_1", "guard_exec_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_2", "guard_exec_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_3", "guard_exec_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_4", "guard_exec_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_5", "guard_exec_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_6", "guard_exec_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_7", "guard_exec_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_exec_8", "guard_exec_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_guard_9", "guard_exec_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_guard_10", "guard_exec_wave_intermission_ctx10", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_guard_11", "guard_exec_wave_intermission_ctx11", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_exec_1", "janitor_exec_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_2", "janitor_exec_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_3", "janitor_exec_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_4", "janitor_exec_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_5", "janitor_exec_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "exec_janitor_6", "janitor_exec_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_exec_7", "janitor_exec_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_exec_8", "janitor_exec_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_guard_1", "it_guard_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_guard_2", "it_guard_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_guard_3", "it_guard_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_guard_4", "it_guard_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_5", "it_guard_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_6", "it_guard_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_guard_7", "it_guard_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_8", "it_guard_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_9", "it_guard_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_guard_10", "it_guard_wave_intermission_ctx10", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_it_11", "it_guard_wave_intermission_ctx11", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_it_1", "it_janitor_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_2", "it_janitor_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_3", "it_janitor_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_4", "it_janitor_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_5", "it_janitor_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_it_6", "it_janitor_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_7", "it_janitor_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_8", "it_janitor_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_it_9", "it_janitor_wave_intermission_ctx10", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_10", "it_janitor_wave_intermission_ctx11", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_11", "it_janitor_wave_intermission_ctx12", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "it_janitor_12", "it_janitor_wave_intermission_ctx13", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_it_13", "it_janitor_wave_intermission_ctx14", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "janitor_it_14", "it_janitor_wave_intermission_ctx15", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_1", "guard_janitor_wave_intermission_ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_2", "guard_janitor_wave_intermission_ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_3", "guard_janitor_wave_intermission_ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_4", "guard_janitor_wave_intermission_ctx04", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_5", "guard_janitor_wave_intermission_ctx05", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_6", "guard_janitor_wave_intermission_ctx06", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_7", "guard_janitor_wave_intermission_ctx07", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_8", "guard_janitor_wave_intermission_ctx08", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_9", "guard_janitor_wave_intermission_ctx09", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "conversation", "guard_janitor_10", "guard_janitor_wave_intermission_ctx10", undefined);
  level.mysteryguystruct = spawnStruct();
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer2", "end_game_atlas_mysteryguy_", level.mysteryguystruct, 0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer2", "global_priority", "conversation0", "ctx01", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer2", "global_priority", "conversation1", "ctx02", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer2", "global_priority", "conversation2", "ctx03", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer2", "global_priority", "conversation3", "ctx04", undefined);
  level.endgamewaitfunc = ::endgamedialog;
  thread endgamestatic();
}

endgamestatic() {
  level waittill("spawning_intermission");

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_zm_hud_static", 2);
  }

  wait 0.5;

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_zm_hud_static", 1);
  }
}

endgamedialog(var_0, var_1, var_2, var_3) {
  if(var_3 != level.enemyteam) {
    if(!var_0 && !level.postgamenotifies) {
      if(!maps\mp\_utility::wasonlyround()) {
        wait(6.0 + var_2);
      } else {
        wait(min(10.0, 4.0 + var_2 + level.postgamenotifies));
      }
    } else {
      wait(min(10.0, 4.0 + var_2 + level.postgamenotifies));
    }

    return;
  }

  var_4 = "global_priority";
  var_5 = "conversation" + randomint(4);
  var_6 = 1;

  for(var_7 = 1; var_6; var_7++) {
    var_6 = level.mysteryguystruct maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_4, var_5, undefined, var_7, 1, undefined, level.players);

    if(isDefined(var_6) && var_6) {
      level.mysteryguystruct waittill("done_speaking");
      wait 0.5;
    }
  }

  wait 2;
}

crashhelianim() {
  var_0 = "dlc_heli_blade_loop";
  precachempanim(var_0);
  var_1 = getent("crashed_heli_blades", "targetname");
  var_2 = common_scripts\utility::getstruct("crashed_heli_node", "targetname");

  if(isDefined(var_1) && isDefined(var_2)) {
    var_1 scriptmodelplayanim(var_0);
  }
}

cg_exploittriggermonitor() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(isplayer(var_0)) {
      var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

      foreach(var_3 in var_1) {
        var_4 = distance(var_0.origin, var_3.origin);

        if(var_4 < 100) {
          var_5 = common_scripts\utility::getstruct(self.target, "targetname");

          if(isDefined(var_5)) {
            var_6 = vectornormalize((var_5.origin - var_0.origin) * (1, 1, 0));
            var_0 setvelocity(var_6 * 100);
          }

          break;
        }

        wait 0.1;
      }
    }

    wait 1;
  }
}

cg_breakglasstriggermonitor() {
  level endon("game_ended");
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");
  self waittill("trigger", var_1);
  glassradiusdamage(var_0.origin, var_0.radius, 100, 100);
}

labshouldignoreplayer(var_0) {
  if(maps\mp\zombies\_util::is_true(level.incinerator_active)) {
    var_1 = maps\mp\mp_zombie_lab_sq::stage4_get_players_in_incinerator();

    if(common_scripts\utility::array_contains(var_1, var_0)) {
      return 1;
    }
  }

  return 0;
}