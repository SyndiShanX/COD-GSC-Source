/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_meteora.gsc
******************************************/

main() {
  maps\mp\mp_meteora_precache::main();
  maps\createart\mp_meteora_art::main();
  maps\mp\mp_meteora_fx::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_meteoradlc");
  maps\mp\_compass::setupminimap("compass_map_mp_meteora");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  game["attackers"] = "allies";
  game["defenders"] = "axis";

  if(level.gametype == "grnd") {
    thread movedropzone();
  } else {
    thread waitcarryobjects();
  }
}

movedropzone() {
  level endon("game_ended");

  for(;;) {
    if(isDefined(level.grnd_dropzones) && isDefined(level.grnd_dropzones["mp_meteora"]) && level.grnd_dropzones["mp_meteora"].size) {
      break;
    }

    wait 0.05;
  }

  for(var_0 = 0; var_0 < level.grnd_dropzones["mp_meteora"].size; var_0++) {
    if(level.grnd_dropzones["mp_meteora"][var_0] == (1591.2, 1583.3, 1740)) {
      level.grnd_dropzones["mp_meteora"][var_0] = (-1003.93, -873.069, 1592.93);
      break;
    }
  }

  level.grnd_dropzones["mp_meteora"][level.grnd_dropzones["mp_meteora"].size] = (-449.789, 1658.05, 1611.67);
}

waitcarryobjects() {
  level endon("game_ended");

  if(level.gametype == "sd") {
    while(!isDefined(level.sdbomb)) {
      wait 0.05;

    }
    level.sdbomb thread watchcarryobjects();
  } else if(level.gametype == "sab") {
    while(!isDefined(level.sabbomb)) {
      wait 0.05;

    }
    level.sabbomb thread watchcarryobjects();
  } else if(level.gametype == "tdef") {
    while(!isDefined(level.gameflag)) {
      wait 0.05;

    }
    level.gameflag thread watchcarryobjects();
  } else if(level.gametype == "ctf") {
    while(!isDefined(level.teamflags) || !isDefined(level.teamflags[game["defenders"]]) || !isDefined(level.teamflags[game["attackers"]])) {
      wait 0.05;

    }
    level.teamflags[game["defenders"]] thread watchcarryobjects();
    level.teamflags[game["attackers"]] thread watchcarryobjects();
  }
}

watchcarryobjects() {
  if(!isDefined(level.nodrops)) {
    createnodrops();

  }
  for(;;) {
    self waittill("dropped");
    wait 0.1;

    foreach(var_1 in level.nodrops) {
      if(distance2d(self.curorigin, var_1.pos) < var_1.radius && self.curorigin[2] > var_1.pos[2] && self.curorigin[2] < var_1.pos[2] + var_1.height) {
        if(level.gametype == "ctf") {
          maps\mp\gametypes\_gameobjects::returnhome();
        } else {
          thread movecarryobject(var_1.safepos, var_1.safeangle);

        }
        break;
      }
    }
  }
}

movecarryobject(var_0, var_1) {
  self notify("stop_pickup_timeout");
  self notify("picked_up");
  self.isresetting = 1;

  for(var_2 = 0; var_2 < self.visuals.size; var_2++) {
    self.visuals[var_2].origin = var_0;
    self.visuals[var_2].angles = var_1;
    self.visuals[var_2] show();
  }

  self.trigger.origin = var_0;
  self.curorigin = self.trigger.origin;
  maps\mp\gametypes\_gameobjects::clearcarrier();
  maps\mp\gametypes\_gameobjects::updateworldicons();
  maps\mp\gametypes\_gameobjects::updatecompassicons();
  self.isresetting = 0;
}

createnodrops() {
  level.nodrops = [];
  level.nodrops[0] = spawnStruct();
  level.nodrops[0].pos = (551, -184, 1381);
  level.nodrops[0].radius = 150;
  level.nodrops[0].height = 130;
  level.nodrops[0].safepos = (705.125, -314.924, 1599.82);
  level.nodrops[0].safeangle = (0, -30.5861, 0);
  level.nodrops[1] = spawnStruct();
  level.nodrops[1].pos = (-653, -718, 1416);
  level.nodrops[1].radius = 180;
  level.nodrops[1].height = 100;
  level.nodrops[1].safepos = (-834.061, -522.471, 1600.21);
  level.nodrops[1].safeangle = (0, 155.764, 0);
  level.nodrops[2] = spawnStruct();
  level.nodrops[2].pos = (120, 1576, 1448);
  level.nodrops[2].radius = 200;
  level.nodrops[2].height = 100;
  level.nodrops[2].safepos = (210.198, 1686.45, 1601.13);
  level.nodrops[2].safeangle = (0, 62.0453, 0);
  level.nodrops[3] = spawnStruct();
  level.nodrops[3].pos = (-318, 2547, 1440);
  level.nodrops[3].radius = 200;
  level.nodrops[3].height = 100;
  level.nodrops[3].safepos = (-449.421, 2778.5, 1561.22);
  level.nodrops[3].safeangle = (0, 139.462, 0);
  level.nodrops[4] = spawnStruct();
  level.nodrops[4].pos = (-574, -1576, 1032);
  level.nodrops[4].radius = 200;
  level.nodrops[4].height = 200;
  level.nodrops[4].safepos = (-738.896, -1343.13, 1519.59);
  level.nodrops[4].safeangle = (0, -125.039, 0);
}