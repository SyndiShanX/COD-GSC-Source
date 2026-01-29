/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_qadeem.gsc
*****************************************/

main() {
  maps\mp\mp_qadeem_precache::main();
  maps\createart\mp_qadeem_art::main();
  maps\mp\mp_qadeem_fx::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_qadeem");
  maps\mp\_compass::setupminimap("compass_map_mp_qadeem");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_diffuseColorScale", 1.32);
  setdvar("r_specularColorScale", 3.25);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  thread maps\mp\_utility::killtrigger((-678, 1968, 56), 40, 72);
  thread maps\mp\_utility::killtrigger((-678, 1928, 56), 40, 72);
  thread maps\mp\_utility::killtrigger((-678, 1888, 56), 40, 72);
  thread maps\mp\_utility::killtrigger((-678, 1848, 56), 40, 72);
  thread maps\mp\_utility::killtrigger((-678, 1808, 56), 40, 72);
  thread spawn_blocker_collision((1464, 2004, 428), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2004, 458), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2004, 488), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2037, 428), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2037, 458), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2037, 488), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2070, 428), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2070, 458), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2070, 488), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2103, 428), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2103, 458), (0, 0, 0));
  thread spawn_blocker_collision((1464, 2103, 488), (0, 0, 0));
  audio_settings();
  var_0 = getent("trigger_underwater", "targetname");
  var_0 thread watchplayerenterwater();
  level thread clearwatervarsonspawn(var_0);
  level thread waitcarryobjects();
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "city", 0.2, 0.9, 2);
}

clearwatervarsonspawn(var_0) {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_1);

    if(!var_1 istouching(var_0)) {
      var_1._id_1E8A = undefined;
      var_1.underwater = undefined;
      var_1 notify("out_of_water");
    }
  }
}

watchplayerenterwater() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isplayer(var_0)) {
      if(isDefined(var_0.helitype) && var_0.helitype == "remote_uav") {
        wait 0.5;
        var_0 notify("death");
      }

      if(isDefined(var_0.tanktype) && var_0.tanktype == "remote_tank") {
        wait 0.5;
        var_0 notify("death");
      }

      continue;
    } else {
      playFXOnTag(level._effect["water_bubbles_random_runner_qad"], var_0, "tag_origin");

    }
    if(!isalive(var_0)) {
      continue;
    }
    if(!isDefined(var_0._id_1E8A)) {
      var_0._id_1E8A = 1;
      var_0 thread playerunderwater(self);
    }
  }
}

playerunderwater(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self.selectinglocation = 1;
  self notify("force_cancel_placement");
  playFX(level._effect["body_splash"], self.origin);

  if(!maps\mp\_utility::isusingremote()) {
    self shellshock("default", 8);

  }
  var_1 = self.origin;
  var_2 = self.angles;
  thread underwater_damage();
  common_scripts\utility::waittill_any("death", "disconnect");
  self.selectinglocation = undefined;
  self notify("force_cancel_placement");

  if(isDefined(self.setspawnpoint) && self.setspawnpoint istouching(var_0)) {
    maps\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
  }
}

underwater_damage() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    radiusdamage(self.origin + anglesToForward(self.angles) * 5, 16, 34, 34, undefined, "MOD_TRIGGER_HURT");
    wait 1;
  }
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
  if(!isDefined(level.nodroptriggers)) {
    getnodrops();

  }
  for(;;) {
    self waittill("dropped");
    wait 0.1;

    foreach(var_1 in level.nodroptriggers) {
      if(self.visuals[0] istouching(var_1)) {
        if(level.gametype == "ctf") {
          maps\mp\gametypes\_gameobjects::returnhome();
        } else {
          var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");
          thread movecarryobject(var_2.origin, var_2.angles);
        }

        break;
      }
    }
  }
}

getnodrops() {
  level.nodroptriggers = [];
  var_0 = getEntArray("no_drop", "targetname");

  foreach(var_2 in var_0) {
    if(var_2.classname == "trigger_multiple") {
      level.nodroptriggers = common_scripts\utility::add_to_array(level.nodroptriggers, var_2);
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

spawn_blocker_collision(var_0, var_1) {
  while(!isDefined(level.airdropcratecollision)) {
    wait 0.05;

  }
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("tag_origin");
  var_2.origin = var_0;
  var_2.angles = var_1;
  var_2 clonebrushmodeltoscriptmodel(level.airdropcratecollision);
}