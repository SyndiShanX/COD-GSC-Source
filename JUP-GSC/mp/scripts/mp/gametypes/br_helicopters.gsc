/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_helicopters.gsc
******************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\utility\game;
#namespace br_helicopters;

function setuphalodropplayer(player) {
  level endon("game_ended");
  player endon("disconnect");
  player notify("cancel_heli");
  playerlinkent = spawn("script_model", (0, 0, 0));
  playerlinkent setModel("tag_origin");
  self.playerlinkent = playerlinkent;
  self.playerstartpos = player.origin;

  if(istrue(player.isbombcarrier)) {
    level.bombdroploc = self.playerstartpos;
  }

  playerlinkent playLoopSound("veh_apache_killstreak_amb_lr");
  playerlinkent linkTo(self, "tag_origin", self.playeroffsets[self.playerslots.size], (0, 90, 0));
  player setstance("stand");
  player setCanDamage(0);
  player cancelmantle();
  player playerlinktodelta(playerlinkent, "tag_player", 1, 40, 40, -5, 70, 0);
  scripts\mp\flags::gameflagwait("prematch_done");
  player notifyonplayercommand("halo_jump_c130", "+gostand");
  player thread scripts\mp\gametypes\br_c130::listenjump(self, 1);
  player thread scripts\mp\gametypes\br_c130::listenkick(self, 1);
}

function spawnplayertohelicam(player) {
  player.angles = self.angles;
  player thread scripts\mp\gametypes\br_c130::listenjump(self, 1);
  player thread scripts\mp\gametypes\br_c130::listenkick(self, 1);
  player.br_infil_type = "heli";
  player thread orbitcam(self);
}

function orbitcam(heli) {
  radius = 450;
  var_fe0c08ddc602e96 = (-5, 0, 0);
  initialoffset = anglesToForward(var_fe0c08ddc602e96) * radius * -1;
  heli.br_vieworigin = initialoffset + (150, 150, 0);
  self.angles = heli.angles;
  self playerlinkTo(heli, "tag_origin");
  function_a593971d75d82113();
  function_379bb555405c16bb("br_helicopters::orbitCam()");
  _visionsetnaked("", 0);

  if(isDefined(self.br_orbitcam)) {
    self.br_orbitcam delete();
  }

  pov = spawn("script_model", heli.origin);
  pov setModel("tag_player");
  pov linkTo(heli, "tag_origin", (0, 0, 50), (0, 0, 0));
  self.br_orbitcam = pov;
  self cameraset("camera_custom_orbit_2");
}

function forceejectall() {
  foreach(player in level.players) {
    player notify("halo_jump");
    player notify("halo_kick_c130");
  }
}

function jumplistener(heli, jumptime) {
  level endon("game_ended");
  self endon("br_jump");
  val::set("br_heli", "melee", 0);
  val::set("br_heli", "player_for_spawn_logic", 0);
  val::set("br_heli", "offhand_weapons", 0);
  val::set("br_heli", "usability", 0);
  self notifyonplayercommand("halo_jump", "+gostand");
  self waittill("halo_jump");
  lookangles = self getplayerangles();
  jumporigin = heli getfirstopenjumporigin();
  left = anglestoleft(heli.angles);
  var_f9805aad354a150e = jumporigin.origin + left * 200;
  contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_playerclip", "physicscontents_vehicleclip"]);
  spawnpos = (0, 0, 0);
  castresults = physics_raycast(var_f9805aad354a150e, var_f9805aad354a150e + (0, 0, -1) * 20000, contents, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(castresults) && castresults.size > 0) {
    castend = castresults[0]["position"];
    spawnpos = getclosestpointonnavmesh(castend);
  } else {
    iprintln("ERROR NOTHING BELOW TO CAST ON");
  }

  self unlink();
  fallent = spawn("script_model", self.origin);
  fallent.angles = self.angles;
  fallent setModel("tag_origin");
  self playerlinkTo(fallent);
  fallent moveTo(spawnpos + (0, 0, 24), jumptime, 0, 1);
  self playerlinkTo(fallent);
  parachute = spawn("script_model", self.origin + (0, 0, 300));
  parachute setModel("ctl_parachute_player");
  parachute notsolid();
  childthread parachuteupdater(parachute);
  wait jumptime - 0.333;
  self unlink();
  heli.playerslots = array_remove(heli.playerslots, self);
  self setCanDamage(1);
  val::reset_all("br_heli");

  if(isDefined(heli)) {
    heli jumpdone();
  }
}

function parachuteupdater(parachute) {
  while(true) {
    if(self isonground() || !isalive(self)) {
      self.br_fallaccel = (0, 0, 0);
      parachute delete();
      break;
    } else {
      parachute.angles = self.angles;
      parachute.origin = self.origin + (0, 0, 360);
    }

    waitframe();
  }
}

function spawnheli(helinum, spawnpos) {
  streakname = "jackal";
  streakinfo = fakestreakinfo();
  heli_vehicle = "veh_blima_gunner_proto_mp";
  heli_model = "veh8_mil_air_blima_gunner_streak_proto";
  var_75e017ae58f23a0 = 1500;
  heli = spawnVehicle(heli_model, "br_spawn_heli_" + helinum, heli_vehicle, spawnpos, (0, -90, 0));
  heli.streakinfo = streakinfo;
  heli vehicle_setspeed(30, 15, 5);
  heli notsolid(0);
  heli setCanDamage(0);
  heli setscriptablepartstate("engine", "on");
  heli playLoopSound("lbravo_engine_high");
  heli.health = var_75e017ae58f23a0;
  heli.targetpos = level.mapcenter;
  heli.targetent = undefined;
  heli.team = "allies";
  heli.dying = 0;
  heli.leaving = 0;
  heli.queuetokens = 0;
  heli.playerslots = [];
  heli.playeroffsets = [(32, 30, -135), (-32, 30, -135), (0, 30, -135), (16, 30, -135), (-16, 30, -135)];
  heli.jumpslots = [];

  for(i = 0; i < 10; i++) {
    heli.jumpslots[i] = 0;
  }

  return heli;
}

function getfirstopenjumporigin() {
  if(!isDefined(self.jumpslots)) {
    return self.trail[0];
  }

  for(i = 0; i < 10; i++) {
    if(self.jumpslots[i] == 0) {
      self.jumpslots[i] = 1;
      return self.trail[i];
    }
  }

  return self.trail[9];
}

function calctrailpoint() {
  droppoint = self.origin - anglesToForward(self.angles) * 150;
  return droppoint;
}

function helipathmemory() {
  self endon("death");
  self endon("leaving");
  self.trail = [];

  for(i = 0; i < 10; i++) {
    struct = spawnStruct();
    struct.origin = self.origin;
    struct.angles = self.angles;
    self.trail[i] = struct;
  }

  while(true) {
    for(i = 9; i > 0; i--) {
      self.trail[i].origin = self.trail[i - 1].origin;
      self.trail[i].angles = self.trail[i - 1].angles;
      self.jumpslots[i] = self.jumpslots[i - 1];
    }

    self.trail[0].origin = self.origin;
    self.trail[0].angles = self.angles;
    self.jumpslots[0] = 0;
    wait 1;
  }
}

function fakestreakinfo() {
  streakinfo = spawnStruct();
  streakinfo.available = 1;
  streakinfo.firednotify = "offhand_fired";
  streakinfo.isgimme = 1;
  streakinfo.kid = 5;
  streakinfo.lifeid = 0;
  streakinfo.madeavailabletime = gettime();
  streakinfo.scriptuseagetype = "gesture_script_weapon";
  streakinfo.streakname = "jackal";
  streakinfo.streaksetupinfo = undefined;
  streakinfo.variantid = -1;
  streakinfo.weaponname = "ks_gesture_generic_mp";
  streakinfo.objweapon = makeweapon(streakinfo.weaponname);
  streakinfo.hits = 0;
  return streakinfo;
}

function ishelicopterfull(copter) {
  return copter.playerslots.size == 10;
}

function sorthelosize(a, b) {
  return a.playerslots.size < b.playerslots.size;
}

function getnexthelicopterwithroom(team) {
  if(level.teambased) {
    foreach(heli in level.br_helicopters) {
      if(isDefined(heli.spawnteam) && heli.spawnteam == team && !ishelicopterfull(heli)) {
        return heli;
      }
    }

    foreach(heli in level.br_helicopters) {
      if(!isDefined(heli.spawnteam)) {
        heli.spawnteam = team;
        return heli;
      }
    }
  } else {
    var_2cc0a74e48cbf1cf = array_sort_with_func(level.br_helicopters, &sorthelosize);

    foreach(helo in var_2cc0a74e48cbf1cf) {
      if(!ishelicopterfull(helo)) {
        return helo;
      }
    }
  }

  return undefined;
}

function kickanyremainingplayers() {
  foreach(p in self.playerslots) {
    if(isDefined(p) && isDefined(p.br_infil_type) && p.br_infil_type == "heli") {
      p cameradefault();
      p notify("halo_kick_c130");
    }
  }
}

function exitandcleanup() {
  self endon("death");
  level notify("infil_locked");
  kickanyremainingplayers();
  self notify("begin_exit");
  self.leaving = 1;
  heightent = getEnt("airstrikeheight", "targetname");
  spawnheight = heightent.origin[2];
  mapcenter = (level.br_level.br_mapbounds[0] + level.br_level.br_mapbounds[1]) * 0.5;
  exitvec = self.origin - mapcenter;
  exitvec = (exitvec[0], exitvec[1], 0);
  exitdir = vectorNormalize(exitvec);
  exitendpoint = self.origin + exitdir * 10000 + (0, 0, 1) * spawnheight;
  exit_speed = 150;
  exit_accel = 50;
  var_62773ac99d83d437 = 350;
  self vehicle_setspeed(exit_speed, exit_accel, exit_accel);
  self setvehgoalpos(exitendpoint, 0);
  self setneargoalnotifydist(var_62773ac99d83d437);
  self waittill("near_goal");
  self delete();
}

function jumpdone() {
  foreach(heli in level.br_helicopters) {
    if(isDefined(heli) && heli.playerslots.size == 0) {
      heli thread exitandcleanup();
    }
  }
}