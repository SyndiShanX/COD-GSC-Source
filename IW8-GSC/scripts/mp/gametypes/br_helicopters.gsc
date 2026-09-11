/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_helicopters.gsc
***************************************************/

function setuphalodropplayer(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 notify("cancel_heli");
  var1 = spawn("script_model", (0, 0, 0));
  var1 setModel("tag_origin");
  self.playerlinkent = var1;
  self.playerstartpos = var0.origin;

  if(istrue(var0.isbombcarrier)) {
    level.bombdroploc = self.playerstartpos;
  }

  var1 playLoopSound("veh_apache_killstreak_amb_lr");
  var1 linkTo(self, "tag_origin", self.playeroffsets[self.playerslots.size], (0, 90, 0));
  var0 setstance("stand");
  var0 setCanDamage(0);
  var0 cancelmantle();
  var0 playerlinktodelta(var1, "tag_player", 1, 40, 40, -5, 70, 0);
  scripts\mp\flags::gameflagwait("prematch_done");
  var0 notifyonplayercommand("halo_jump_c130", "+gostand");
  var0 thread scripts\mp\gametypes\br_c130::listenjump(self, 1);
  var0 thread scripts\mp\gametypes\br_c130::listenkick(self, 1);
}

function spawnplayertohelicam(var0) {
  var0.angles = self.angles;
  var0 thread scripts\mp\gametypes\br_c130::listenjump(self, 1);
  var0 thread scripts\mp\gametypes\br_c130::listenkick(self, 1);
  var0.br_infil_type = "heli";
  thread orbitcam(var0);
}

function orbitcam(var0) {
  var1 = 450;
  var2 = (-5, 0, 0);
  var3 = anglesToForward(var2) * var1 * -1;
  var0.br_vieworigin = var3 + (150, 150, 0);
  self.angles = var0.angles;
  self playerlinkTo(var0, "tag_origin");
  self playerhide();

  if(isDefined(level.ref_142d1)) {
    scripts\mp\utility\player::_visionsetnaked(level.ref_142d1, 0);
  } else {
    scripts\mp\utility\player::_visionsetnaked("", 0);
  }

  if(isDefined(self.br_orbitcam)) {
    self.br_orbitcam delete();
  }

  var4 = spawn("script_model", var0.origin);
  var4 setModel("tag_player");
  var4 linkTo(var0, "tag_origin", (0, 0, 50), (0, 0, 0));
  self.br_orbitcam = var4;
  self cameraset("camera_custom_orbit_2");
}

function forceejectall() {
  foreach(var1 in level.players) {
    var1 notify("halo_jump");
    var1 notify("halo_kick_c130");
  }
}

function jumplistener(var0, var1) {
  level endon("game_ended");
  self endon("br_jump");
  scripts\common\utility::allow_melee(0);
  scripts\mp\utility\player::enableplayerforspawnlogic(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_usability(0);
  self notifyonplayercommand("halo_jump", "+gostand");
  self waittill("halo_jump");
  var2 = self getplayerangles();
  var3 = getfirstopenjumporigin(var0);
  var4 = anglestoleft(var0.angles);
  var5 = var3.origin + var4 * 200;
  var6 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_playerclip", "physicscontents_vehicleclip"]);
  var7 = (0, 0, 0);
  var8 = physics_raycast(var5, var5 + (0, 0, -20000), var6, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var8) && var8.size > 0) {
    var9 = var8[0]["position"];
    var7 = getclosestpointonnavmesh(var9);
  } else {
    iprintln("ERROR NOTHING BELOW TO CAST ON");
  }

  self unlink();
  var10 = spawn("script_model", self.origin);
  var10.angles = self.angles;
  var10 setModel("tag_origin");
  self playerlinkTo(var10);
  var10 moveTo(var7 + (0, 0, 24), var1, 0, 1);
  self playerlinkTo(var10);
  var11 = spawn("script_model", self.origin + (0, 0, 300));
  var11 setModel("ctl_parachute_player");
  var11 notsolid();
  GscBinSkip4(0x35, var11);
}

function parachuteupdater(var0) {
  for(;;) {
    if(self isonground() || !isalive(self)) {
      self.br_fallaccel = (0, 0, 0);
      var0 delete();
      break;
    } else {
      var0.angles = self.angles;
      var0.origin = self.origin + (0, 0, 360);
    }

    waitframe();
  }
}

function spawnheli(var0, var1) {
  var2 = "jackal";
  var3 = fakestreakinfo();
  var4 = "veh_blima_gunner_proto_mp";
  var5 = "veh8_mil_air_blima_gunner_streak_proto";
  var6 = 1500;
  var7 = spawnVehicle(var5, "br_spawn_heli_" + var0, var4, var1, (0, -90, 0));
  var7.streakinfo = var3;
  var7 vehicle_setspeed(30, 15, 5);
  var7 notsolid(0);
  var7 setCanDamage(0);
  var7 setscriptablepartstate("engine", "on");
  var7 playLoopSound("lbravo_engine_high");
  var7.health = var6;
  var7.targetpos = level.mapcenter;
  var7.targetent = undefined;
  var7.team = "allies";
  var7.dying = 0;
  var7.leaving = 0;
  var7.queuetokens = 0;
  var7.playerslots = [];
  var7.playeroffsets = [(32, 30, -135), (-32, 30, -135), (0, 30, -135), (16, 30, -135), (-16, 30, -135)];
  var7.jumpslots = [];

  for(var8 = 0; var8 < 10; var8++) {
    var7.jumpslots[var8] = 0;
  }

  return var7;
}

function getfirstopenjumporigin() {
  if(!isDefined(self.jumpslots)) {
    return self.trail[0];
  }

  for(var0 = 0; var0 < 10; var0++) {
    if(self.jumpslots[var0] == 0) {
      self.jumpslots[var0] = 1;
      return self.trail[var0];
    }
  }

  return self.trail[9];
}

function helipathmemory() {
  self endon("death");
  self endon("leaving");
  self.trail = [];

  for(var0 = 0; var0 < 10; var0++) {
    var1 = spawnStruct();
    var1.origin = self.origin;
    var1.angles = self.angles;
    self.trail[var0] = var1;
  }

  for(;;) {
    for(var0 = 9; var0 > 0; var0--) {
      self.trail[var0].origin = self.trail[var0 - 1].origin;
      self.trail[var0].angles = self.trail[var0 - 1].angles;
      self.jumpslots[var0] = self.jumpslots[var0 - 1];
    }

    self.trail[0].origin = self.origin;
    self.trail[0].angles = self.angles;
    self.jumpslots[0] = 0;
    wait 1;
  }
}

function fakestreakinfo() {
  var0 = spawnStruct();
  var0.available = 1;
  var0.firednotify = "offhand_fired";
  var0.isgimme = 1;
  var0.kid = 5;
  var0.lifeid = 0;
  var0.madeavailabletime = gettime();
  var0.scriptuseagetype = "gesture_script_weapon";
  var0.streakname = "jackal";
  var0.streaksetupinfo = undefined;
  var0.variantid = -1;
  var0.weaponname = "ks_gesture_generic_mp";
  var0.objweapon = getcompleteweaponname(var0.weaponname);
  var0.hits = 0;
  return var0;
}

function ishelicopterfull(var0) {
  return var0.playerslots.size == 10;
}

function sorthelosize(var0, var1) {
  return var0.playerslots.size < var1.playerslots.size;
}

function getnexthelicopterwithroom(var0) {
  if(level.teambased) {
    foreach(var2 in level.br_helicopters) {
      if(isDefined(var2.spawnteam) && var2.spawnteam == var0 && !ishelicopterfull(var2)) {
        return var2;
      }
    }

    foreach(var2 in level.br_helicopters) {
      if(!isDefined(var2.spawnteam)) {
        var2.spawnteam = var0;
        return var2;
      }
    }
  } else {
    var6 = scripts\engine\utility::array_sort_with_func(level.br_helicopters, &sorthelosize);

    foreach(var8 in var6) {
      if(!ishelicopterfull(var8)) {
        return var8;
      }
    }
  }

  return undefined;
}

function kickanyremainingplayers() {
  foreach(var1 in self.playerslots) {
    if(isDefined(var1) && isDefined(var1.br_infil_type) && var1.br_infil_type == "heli") {
      var1 cameradefault();
      var1 notify("halo_kick_c130");
    }
  }
}

function exitandcleanup() {
  self endon("death");
  level notify("infil_locked");
  kickanyremainingplayers();
  self notify("begin_exit");
  self.leaving = 1;
  var0 = getEnt("airstrikeheight", "targetname");
  var1 = var0.origin[2];
  var2 = (level.br_level.br_mapbounds[0] + level.br_level.br_mapbounds[1]) * 0.5;
  var3 = self.origin - var2;
  var3 = (var3[0], var3[1], 0);
  var4 = vectorNormalize(var3);
  var5 = self.origin + var4 * 10000 + (0, 0, 1) * var1;
  var6 = 150;
  var7 = 50;
  var8 = 350;
  self vehicle_setspeed(var6, var7, var7);
  self setvehgoalpos(var5, 0);
  self setneargoalnotifydist(var8);
  self waittill("near_goal");
  self delete();
}

function jumpdone() {
  foreach(var1 in level.br_helicopters) {
    if(isDefined(var1) && var1.playerslots.size == 0) {
      thread exitandcleanup();
    }
  }
}