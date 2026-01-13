/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3467.gsc
**************************************/

init() {
  func_FAB1();
  scripts\mp\killstreaks\killstreaks::registerkillstreak("bombardment", ::func_128DC, undefined, undefined, ::triggeredbombardmentweapon, ::func_13C8B);
  level.dangermaxradius["bombardment"] = 160000;
  var_0 = ["passive_fast_launch", "passive_decreased_explosions", "passive_extra_selection", "passive_increased_cost", "passive_impulse_explosion", "passive_single_explosion"];
  scripts\mp\killstreak_loot::func_DF07("bombardment", var_0);
}

func_FAB1() {
  level._effect["spike_charge"] = loadfx("vfx\iw7\_requests\mp\vfx_bombard_blast_source.vfx");
  level._effect["spike_fire"] = loadfx("vfx\iw7\_requests\mp\vfx_bombardment_aerial_blast.vfx");
  level._effect["spike_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_bombard_projectile_trail.vfx");
}

func_13C8B(var_0) {
  if(scripts\mp\utility\game::istrue(level.var_2C48)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  scripts\mp\killstreaks\mapselect::func_10DC2(0, 0, undefined);
}

func_128DC(var_0) {
  var_1 = func_F1AC(var_0.lifeid, var_0.streakname, var_0);

  if(!isDefined(var_1) || !var_1) {
    return 0;
  }

  return 1;
}

func_F1AC(var_0, var_1, var_2) {
  scripts\engine\utility::allow_usability(0);
  scripts\engine\utility::allow_weapon_switch(0);
  var_3 = 3;
  var_4 = "Multi-Strike";
  var_5 = "used_bombardment";
  var_6 = scripts\mp\killstreak_loot::getrarityforlootitem(var_2.variantid);

  if(var_6 != "") {
    var_5 = var_5 + "_" + var_6;
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_extra_selection")) {
    var_3 = 4;
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_impulse_explosion")) {
    var_4 = "Single-Strike";
    var_7 = undefined;
  } else {
    var_8 = spawn("script_origin", self.origin);
    self playlocalsound("bombardment_killstreak_bootup");
    var_8 playLoopSound("bombardment_killstreak_hud_loop");
    self setsoundsubmix("mp_killstreak_overlay");
    var_7 = scripts\mp\killstreaks\mapselect::func_8112(var_1, var_3);
    self playlocalsound("bombardment_killstreak_shutdown");
    self clearsoundsubmix();
    var_8 stoploopsound("");

    if(isDefined(var_8)) {
      var_8 delete();
    }

    if(!isDefined(var_7)) {
      scripts\engine\utility::allow_usability(1);
      scripts\engine\utility::allow_weapon_switch(1);
      return 0;
    }
  }

  if(scripts\mp\utility\game::istrue(level.var_2C48)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
    return 0;
  }

  thread func_6CD4(var_7, var_1, var_4, var_2);
  level thread scripts\mp\utility\game::teamplayercardsplash(var_5, self);
  scripts\mp\matchdata::logkillstreakevent(var_1, self.origin);
  return 1;
}

func_6CD4(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");
  var_4 = getent("airstrikeheight", "targetname");
  var_5 = var_4.origin[2] + 10000;

  if(!isDefined(var_5)) {
    var_5 = 20000;
  }

  if(!isDefined(var_2)) {
    var_2 = "Multi-Strike";
  }

  level.var_2C48 = 1;
  thread func_139B2();
  var_6 = [];

  if(var_2 == "Single-Strike") {
    var_7 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
    var_8 = physics_createcontents(var_7);
    var_9 = [];

    foreach(var_11 in level.players) {
      if(!scripts\mp\utility\game::isreallyalive(var_11)) {
        continue;
      }
      if(level.teambased && var_11.team == self.team) {
        continue;
      }
      if(!level.teambased && var_11 == self) {
        continue;
      }
      if(var_11 isinphase()) {
        continue;
      }
      var_12 = var_11.origin + (0, 0, var_5);
      var_13 = scripts\engine\trace::ray_trace(var_12, var_11.origin - (0, 0, 10000), level.characters, var_8);
      var_14 = var_13["position"];
      var_9[var_9.size] = spawnStruct();
      var_9[var_9.size - 1].location = var_14;
    }

    var_6 = createkillcaments(var_9, var_5, var_3);
    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);

    foreach(var_19, var_17 in var_9) {
      var_18 = spawnStruct();
      var_18.origin = var_17.location;
      var_18.streakname = var_1;
      var_18.radius = 350;
      var_18.team = self.team;
      playLoopSound(var_17.location, "bombardment_laser_on_epic");
      level.artillerydangercenters[level.artillerydangercenters.size] = var_18;
      level thread func_6D84(self, var_5, var_17.location, self.angles, var_18, var_6[var_19], 0, var_3);
      wait 0.1;
    }
  } else {
    var_6 = createkillcaments(var_0, var_5, var_3);
    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);

    foreach(var_19, var_21 in var_0) {
      thread sfx_bombardment_designator(var_21.location, var_3);

      if(var_2 == "Multi-Strike") {
        var_22 = func_7DBB(var_21.location, var_5, 500, var_3);
        thread func_6D7D(var_22, var_5, var_1, var_6[var_19], var_3);

        if(scripts\mp\killstreaks\utility::func_A69F(var_3, "passive_fast_launch")) {
          wait 0.1;
        } else {
          wait 0.2;
        }
      }
    }
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(7);
  level.var_2C48 = undefined;
  self notify("bombardment_finished");
  thread func_D910();

  if(isDefined(var_6) && var_6.size > 0) {
    foreach(var_24 in var_6) {
      var_24 delete();
    }
  }
}

sfx_bombardment_designator(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("ks_bombardment_mp");
  var_3 = "active";
  var_4 = 5;

  if(scripts\mp\killstreaks\utility::func_A69F(var_1, "passive_fast_launch")) {
    var_3 = "active_fast";
    var_4 = 5;
  }

  var_2 setscriptablepartstate("buildup", var_3, 0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_4);
  var_2 setscriptablepartstate("buildup", "neutral", 0);
  var_2 delete();
}

createkillcaments(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 1.5;

  foreach(var_9, var_6 in var_0) {
    var_7 = findclosestunobstructedpointonnavmeshradius(var_6.location, var_1, 500, var_2);
    var_8 = spawn("script_model", var_7 + (0, 0, 30));
    var_8 thread func_5114(var_4, var_7 + (0, 0, 1500), 2.0, 1.0, 0.05);
    var_3[var_3.size] = var_8;
    wait 0.2;
    var_4 = var_4 - 0.2;
  }

  return var_3;
}

func_139B2() {
  self endon("bombardment_finished");
  level endon("game_ended");
  scripts\engine\utility::waittill_any("disconnect", "joined_team");

  if(scripts\mp\utility\game::istrue(level.var_2C48)) {
    level.var_2C48 = undefined;
  }
}

func_D910() {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(8.0);
  scripts\mp\utility\game::printgameaction("killstreak ended - bombardment", self);
}

func_5114(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  wait(var_0);

  if(scripts\mp\utility\game::istrue(var_5)) {
    var_7 = 0;
    var_8 = [];

    for(var_9 = 0; var_9 < var_6; var_9++) {
      var_10 = randomint(100);
      var_11 = randomint(360);
      var_12 = var_1[0] + var_10 * cos(var_11);
      var_13 = var_1[1] + var_10 * sin(var_11);
      var_14 = var_1[2];
      var_15 = (var_12, var_13, var_14);
      var_8[var_8.size] = var_15;
    }

    while(var_7 < var_6) {
      self moveto(var_8[var_7], 0.05);
      var_7++;
      scripts\engine\utility::waitframe();
    }
  } else
    self moveto(var_1, var_2, var_3, var_4);
}

findclosestunobstructedpointonnavmeshradius(var_0, var_1, var_2, var_3) {
  var_4 = getclosestpointonnavmesh(var_0);
  var_5 = undefined;
  var_6 = func_7DBB(var_0, var_1, var_2, var_3);

  foreach(var_8 in var_6) {
    var_9 = getclosestpointonnavmesh(var_8);
    var_10 = var_9 + (0, 0, 20);
    var_11 = var_10 + (0, 0, 10000);
    var_12 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
    var_13 = scripts\engine\trace::ray_trace(var_10, var_11, level.characters, var_12);

    if(isDefined(var_13["hittype"]) && var_13["hittype"] == "hittype_none") {
      var_14 = distance2dsquared(var_0, var_9);

      if(!isDefined(var_5) || var_14 < var_5) {
        var_5 = var_14;
        var_4 = var_9;
      }
    }
  }

  return var_4;
}

func_7DBB(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = 7;

  if(scripts\mp\killstreaks\utility::func_A69F(var_3, "passive_fast_launch")) {
    var_5 = 4;
  }

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = randomint(var_2);
    var_8 = randomint(360);
    var_9 = var_0[0] + var_7 * cos(var_8);
    var_10 = var_0[1] + var_7 * sin(var_8);
    var_11 = var_0[2];
    var_12 = (var_9, var_10, var_11);
    var_13 = var_12 + (0, 0, var_1);
    var_14 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
    var_15 = physics_createcontents(var_14);
    var_16 = scripts\engine\trace::ray_trace(var_13, var_12 - (0, 0, 10000), level.characters, var_15);
    var_4[var_4.size] = var_16["position"];
  }

  return var_4;
}

func_6D7D(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  level endon("game_ended");

  foreach(var_6 in var_0) {
    if(!isDefined(self)) {
      break;
    }
    var_7 = var_6 + (0, 0, var_1);
    var_8 = var_6;
    var_9 = randomfloatrange(0.3, 0.5);

    if(scripts\mp\killstreaks\utility::func_A69F(var_4, "passive_fast_launch")) {
      var_9 = randomfloatrange(0.1, 0.3);
    }

    var_10 = spawnStruct();
    var_10.origin = var_8;
    var_10.streakname = var_2;
    var_10.radius = 350;
    var_10.team = self.team;
    level.artillerydangercenters[level.artillerydangercenters.size] = var_10;
    level thread func_6D84(self, var_7, var_8, self.angles, var_10, var_3, 0, var_4);
    wait(var_9);
  }
}

func_6D84(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  var_8 = spawn("script_model", var_2 + (0, 0, 3));
  var_8 setModel("ks_bombardment_mp");
  var_8 setentityowner(var_0);
  var_8 setotherent(var_0);
  var_8.weapon_name = "bombproj_mp";
  var_8.streakinfo = var_7;
  var_8.killcament = var_5;

  if(scripts\mp\killstreaks\utility::func_A69F(var_7, "passive_fast_launch")) {
    var_8 setscriptablepartstate("target", "active_fast");
  } else {
    var_8 setscriptablepartstate("target", "active");
  }

  var_9 = 2;

  if(scripts\mp\killstreaks\utility::func_A69F(var_7, "passive_fast_launch")) {
    var_9 = 1.5;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_9);
  var_8 setscriptablepartstate("fire", "active");

  if(isDefined(var_0)) {
    wait 0.5;
    var_8 setscriptablepartstate("explosion", "active", 0);
    var_8 thread scripts\mp\utility\game::delayentdelete(5);
    level.artillerydangercenters = scripts\engine\utility::array_remove(level.artillerydangercenters, var_4);
  } else {
    level.artillerydangercenters = scripts\engine\utility::array_remove(level.artillerydangercenters, var_4);

    if(isDefined(var_5)) {
      var_5 delete();
    }
  }
}

func_511A(var_0, var_1, var_2) {
  self endon("death");
  wait(var_0);
  playFXOnTag(scripts\engine\utility::getfx(var_1), self, var_2);
}

triggeredbombardmentweapon(var_0) {
  if(scripts\mp\killstreaks\utility::func_A69F(var_0, "passive_impulse_explosion")) {
    var_0.var_EF88 = "gesture_script_weapon";
    var_0.weapon = "ks_gesture_generic_mp";
    var_0.var_6D6B = "offhand_fired";
  }

  return 1;
}