/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_helicopters.gsc
***************************************************/

function setuphalodropplayer(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("cancel_heli");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("tag_origin");
  self.playerlinkent = var_1;
  self.playerstartpos = var_0.origin;

  if(istrue(var_0.isbombcarrier)) {
    level.bombdroploc = self.playerstartpos;
  }

  var_1 playLoopSound("veh_apache_killstreak_amb_lr");
  var_1 linkTo(self, "tag_origin", self.playeroffsets[self.playerslots.size], (0, 90, 0));
  var_0 setstance("stand");
  var_0 setCanDamage(0);
  var_0 cancelmantle();
  var_0 playerlinktodelta(var_1, "tag_player", 1, 40, 40, -5, 70, 0);
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 notifyonplayercommand("halo_jump_c130", "+gostand");
  var_0 thread scripts\mp\gametypes\br_c130::listenjump(self, 1);
  var_0 thread scripts\mp\gametypes\br_c130::listenkick(self, 1);
}

function spawnplayertohelicam(var_0) {
  var_0.angles = self.angles;
  var_0 thread scripts\mp\gametypes\br_c130::listenjump(self, 1);
  var_0 thread scripts\mp\gametypes\br_c130::listenkick(self, 1);
  var_0.br_infil_type = "heli";
  thread orbitcam(var_0);
}

function orbitcam(var_0) {
  var_1 = 450;
  var_2 = (-5, 0, 0);
  var_3 = anglesToForward(var_2) * var_1 * -1;
  var_0.br_vieworigin = var_3 + (150, 150, 0);
  self.angles = var_0.angles;
  self playerlinkTo(var_0, "tag_origin");
  self playerhide();

  if(isDefined(level.ref_142d1)) {
    scripts\mp\utility\player::_visionsetnaked(level.ref_142d1, 0);
  } else {
    scripts\mp\utility\player::_visionsetnaked("", 0);
  }

  if(isDefined(self.br_orbitcam)) {
    self.br_orbitcam delete();
  }

  var_4 = spawn("script_model", var_0.origin);
  var_4 setModel("tag_player");
  var_4 linkTo(var_0, "tag_origin", (0, 0, 50), (0, 0, 0));
  self.br_orbitcam = var_4;
  self cameraset("camera_custom_orbit_2");
}

function forceejectall() {
  foreach(var_1 in level.players) {
    var_1 notify("halo_jump");
    var_1 notify("halo_kick_c130");
  }
}

function jumplistener(var_0, var_1) {
  level endon("game_ended");
  self endon("br_jump");
  scripts\common\utility::allow_melee(0);
  scripts\mp\utility\player::enableplayerforspawnlogic(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_usability(0);
  self notifyonplayercommand("halo_jump", "+gostand");
  self waittill("halo_jump");
  var_2 = self getplayerangles();
  var_3 = getfirstopenjumporigin(var_0);
  var_4 = anglestoleft(var_0.angles);
  var_5 = var_3.origin + var_4 * 200;
  var_6 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_playerclip", "physicscontents_vehicleclip"]);
  var_7 = (0, 0, 0);
  var_8 = physics_raycast(var_5, var_5 + (0, 0, -20000), var_6, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var_8) && var_8.size > 0) {
    var_9 = var_8[0]["position"];
    var_7 = getclosestpointonnavmesh(var_9);
  } else {
    iprintln("ERROR NOTHING BELOW TO CAST ON");
  }

  self unlink();
  var_10 = spawn("script_model", self.origin);
  var_10.angles = self.angles;
  var_10 setModel("tag_origin");
  self playerlinkTo(var_10);
  var_10 moveTo(var_7 + (0, 0, 24), var_1, 0, 1);
  self playerlinkTo(var_10);
  var_11 = spawn("script_model", self.origin + (0, 0, 300));
  var_11 setModel("ctl_parachute_player");
  var_11 notsolid();
  GscBinSkip4(0x35, var_11);
}

function parachuteupdater(var_0) {
  for(;;) {
    if(self isonground() || !isalive(self)) {
      self.br_fallaccel = (0, 0, 0);
      var_0 delete();
      break;
    } else {
      var_0.angles = self.angles;
      var_0.origin = self.origin + (0, 0, 360);
    }

    waitframe();
  }
}

function spawnheli(var_0, var_1) {
  var_2 = "jackal";
  var_3 = fakestreakinfo();
  var_4 = "veh_blima_gunner_proto_mp";
  var_5 = "veh8_mil_air_blima_gunner_streak_proto";
  var_6 = 1500;
  var_7 = spawnVehicle(var_5, "br_spawn_heli_" + var_0, var_4, var_1, (0, -90, 0));
  var_7.streakinfo = var_3;
  var_7 vehicle_setspeed(30, 15, 5);
  var_7 notsolid(0);
  var_7 setCanDamage(0);
  var_7 setscriptablepartstate("engine", "on");
  var_7 playLoopSound("lbravo_engine_high");
  var_7.health = var_6;
  var_7.targetpos = level.mapcenter;
  var_7.targetent = undefined;
  var_7.team = "allies";
  var_7.dying = 0;
  var_7.leaving = 0;
  var_7.queuetokens = 0;
  var_7.playerslots = [];
  var_7.playeroffsets = [(32, 30, -135), (-32, 30, -135), (0, 30, -135), (16, 30, -135), (-16, 30, -135)];
  var_7.jumpslots = [];

  for(var_8 = 0; var_8 < 10; var_8++) {
    var_7.jumpslots[var_8] = 0;
  }

  return var_7;
}

function getfirstopenjumporigin() {
  if(!isDefined(self.jumpslots)) {
    return self.trail[0];
  }

  for(var_0 = 0; var_0 < 10; var_0++) {
    if(self.jumpslots[var_0] == 0) {
      self.jumpslots[var_0] = 1;
      return self.trail[var_0];
    }
  }

  return self.trail[9];
}

function helipathmemory() {
  self endon("death");
  self endon("leaving");
  self.trail = [];

  for(var_0 = 0; var_0 < 10; var_0++) {
    var_1 = spawnStruct();
    var_1.origin = self.origin;
    var_1.angles = self.angles;
    self.trail[var_0] = var_1;
  }

  for(;;) {
    for(var_0 = 9; var_0 > 0; var_0--) {
      self.trail[var_0].origin = self.trail[var_0 - 1].origin;
      self.trail[var_0].angles = self.trail[var_0 - 1].angles;
      self.jumpslots[var_0] = self.jumpslots[var_0 - 1];
    }

    self.trail[0].origin = self.origin;
    self.trail[0].angles = self.angles;
    self.jumpslots[0] = 0;
    wait 1;
  }
}

function fakestreakinfo() {
  var_0 = spawnStruct();
  var_0.available = 1;
  var_0.firednotify = "offhand_fired";
  var_0.isgimme = 1;
  var_0.kid = 5;
  var_0.lifeid = 0;
  var_0.madeavailabletime = gettime();
  var_0.scriptuseagetype = "gesture_script_weapon";
  var_0.streakname = "jackal";
  var_0.streaksetupinfo = undefined;
  var_0.variantid = -1;
  var_0.weaponname = "ks_gesture_generic_mp";
  var_0.objweapon = getcompleteweaponname(var_0.weaponname);
  var_0.hits = 0;
  return var_0;
}

function ishelicopterfull(var_0) {
  return var_0.playerslots.size == 10;
}

function sorthelosize(var_0, var_1) {
  return var_0.playerslots.size < var_1.playerslots.size;
}

function getnexthelicopterwithroom(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.br_helicopters) {
      if(isDefined(var_2.spawnteam) && var_2.spawnteam == var_0 && !ishelicopterfull(var_2)) {
        return var_2;
      }
    }

    foreach(var_2 in level.br_helicopters) {
      if(!isDefined(var_2.spawnteam)) {
        var_2.spawnteam = var_0;
        return var_2;
      }
    }
  } else {
    var_6 = scripts\engine\utility::array_sort_with_func(level.br_helicopters, &sorthelosize);

    foreach(var_8 in var_6) {
      if(!ishelicopterfull(var_8)) {
        return var_8;
      }
    }
  }

  return undefined;
}

function kickanyremainingplayers() {
  foreach(var_1 in self.playerslots) {
    if(isDefined(var_1) && isDefined(var_1.br_infil_type) && var_1.br_infil_type == "heli") {
      var_1 cameradefault();
      var_1 notify("halo_kick_c130");
    }
  }
}

function exitandcleanup() {
  self endon("death");
  level notify("infil_locked");
  kickanyremainingplayers();
  self notify("begin_exit");
  self.leaving = 1;
  var_0 = getEnt("airstrikeheight", "targetname");
  var_1 = var_0.origin[2];
  var_2 = (level.br_level.br_mapbounds[0] + level.br_level.br_mapbounds[1]) * 0.5;
  var_3 = self.origin - var_2;
  var_3 = (var_3[0], var_3[1], 0);
  var_4 = vectorNormalize(var_3);
  var_5 = self.origin + var_4 * 10000 + (0, 0, 1) * var_1;
  var_6 = 150;
  var_7 = 50;
  var_8 = 350;
  self vehicle_setspeed(var_6, var_7, var_7);
  self setvehgoalpos(var_5, 0);
  self setneargoalnotifydist(var_8);
  self waittill("near_goal");
  self delete();
}

function jumpdone() {
  foreach(var_1 in level.br_helicopters) {
    if(isDefined(var_1) && var_1.playerslots.size == 0) {
      thread exitandcleanup();
    }
  }
}