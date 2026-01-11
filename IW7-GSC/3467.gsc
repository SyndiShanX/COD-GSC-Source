/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3467.gsc
***************************************/

init() {
  func_FAB1();
  scripts\mp\killstreaks\killstreaks::registerkillstreak("bombardment", ::func_128DC, undefined, undefined, ::triggeredbombardmentweapon, ::func_13C8B);
  level.dangermaxradius["bombardment"] = 160000;
  var_00 = ["passive_fast_launch", "passive_decreased_explosions", "passive_extra_selection", "passive_increased_cost", "passive_impulse_explosion", "passive_single_explosion"];
  scripts\mp\killstreak_loot::func_DF07("bombardment", var_00);
}

func_FAB1() {
  level._effect["spike_charge"] = loadfx("vfx\iw7\_requests\mp\vfx_bombard_blast_source.vfx");
  level._effect["spike_fire"] = loadfx("vfx\iw7\_requests\mp\vfx_bombardment_aerial_blast.vfx");
  level._effect["spike_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_bombard_projectile_trail.vfx");
}

func_13C8B(var_00) {
  if(scripts\mp\utility\game::istrue(level.func_2C48)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  scripts\mp\killstreaks\mapselect::func_10DC2(0, 0, undefined);
}

func_128DC(var_00) {
  var_01 = func_F1AC(var_0.lifeid, var_0.streakname, var_00);

  if(!isDefined(var_01) || !var_01) {
    return 0;
  }

  return 1;
}

func_F1AC(var_00, var_01, var_02) {
  scripts\engine\utility::allow_usability(0);
  scripts\engine\utility::allow_weapon_switch(0);
  var_03 = 3;
  var_04 = "Multi-Strike";
  var_05 = "used_bombardment";
  var_06 = scripts\mp\killstreak_loot::getrarityforlootitem(var_2.variantid);

  if(var_06 != "") {
    var_05 = var_05 + "_" + var_06;
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_extra_selection")) {
    var_03 = 4;
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_impulse_explosion")) {
    var_04 = "Single-Strike";
    var_07 = undefined;
  } else {
    var_08 = spawn("script_origin", self.origin);
    self playlocalsound("bombardment_killstreak_bootup");
    var_08 playLoopSound("bombardment_killstreak_hud_loop");
    self setsoundsubmix("mp_killstreak_overlay");
    var_07 = scripts\mp\killstreaks\mapselect::_meth_8112(var_01, var_03);
    self playlocalsound("bombardment_killstreak_shutdown");
    self clearsoundsubmix();
    var_08 stoploopsound("");

    if(isDefined(var_08)) {
      var_08 delete();
    }

    if(!isDefined(var_07)) {
      scripts\engine\utility::allow_usability(1);
      scripts\engine\utility::allow_weapon_switch(1);
      return 0;
    }
  }

  if(scripts\mp\utility\game::istrue(level.func_2C48)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
    return 0;
  }

  thread func_6CD4(var_07, var_01, var_04, var_02);
  level thread scripts\mp\utility\game::teamplayercardsplash(var_05, self);
  scripts\mp\matchdata::logkillstreakevent(var_01, self.origin);
  return 1;
}

func_6CD4(var_00, var_01, var_02, var_03) {
  self endon("disconnect");
  level endon("game_ended");
  var_04 = getent("airstrikeheight", "targetname");
  var_05 = var_4.origin[2] + 10000;

  if(!isDefined(var_05)) {
    var_05 = 20000;
  }

  if(!isDefined(var_02)) {
    var_02 = "Multi-Strike";
  }

  level.func_2C48 = 1;
  thread func_139B2();
  var_06 = [];

  if(var_02 == "Single-Strike") {
    var_07 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
    var_08 = physics_createcontents(var_07);
    var_09 = [];

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
      var_12 = var_11.origin + (0, 0, var_05);
      var_13 = scripts\engine\trace::ray_trace(var_12, var_11.origin - (0, 0, 10000), level.characters, var_08);
      var_14 = var_13["position"];
      var_9[var_9.size] = spawnStruct();
      var_9[var_9.size - 1].location = var_14;
    }

    var_06 = createkillcaments(var_09, var_05, var_03);
    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);

    foreach(var_19, var_17 in var_09) {
      var_18 = spawnStruct();
      var_18.origin = var_17.location;
      var_18.streakname = var_01;
      var_18.radius = 350;
      var_18.team = self.team;
      playLoopSound(var_17.location, "bombardment_laser_on_epic");
      level.artillerydangercenters[level.artillerydangercenters.size] = var_18;
      level thread func_6D84(self, var_05, var_17.location, self.angles, var_18, var_6[var_19], 0, var_03);
      wait 0.1;
    }
  } else {
    var_06 = createkillcaments(var_00, var_05, var_03);
    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);

    foreach(var_19, var_21 in var_00) {
      thread sfx_bombardment_designator(var_21.location, var_03);

      if(var_02 == "Multi-Strike") {
        var_22 = func_7DBB(var_21.location, var_05, 500, var_03);
        thread func_6D7D(var_22, var_05, var_01, var_6[var_19], var_03);

        if(scripts\mp\killstreaks\utility::func_A69F(var_03, "passive_fast_launch")) {
          wait 0.1;
        } else {
          wait 0.2;
        }
      }
    }
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(7);
  level.func_2C48 = undefined;
  self notify("bombardment_finished");
  thread func_D910();

  if(isDefined(var_06) && var_6.size > 0) {
    foreach(var_24 in var_06) {
      var_24 delete();
    }
  }
}

sfx_bombardment_designator(var_00, var_01) {
  var_02 = spawn("script_model", var_00);
  var_02 setModel("ks_bombardment_mp");
  var_03 = "active";
  var_04 = 5;

  if(scripts\mp\killstreaks\utility::func_A69F(var_01, "passive_fast_launch")) {
    var_03 = "active_fast";
    var_04 = 5;
  }

  var_02 setscriptablepartstate("buildup", var_03, 0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_04);
  var_02 setscriptablepartstate("buildup", "neutral", 0);
  var_02 delete();
}

createkillcaments(var_00, var_01, var_02) {
  var_03 = [];
  var_04 = 1.5;

  foreach(var_09, var_06 in var_00) {
    var_07 = findclosestunobstructedpointonnavmeshradius(var_6.location, var_01, 500, var_02);
    var_08 = spawn("script_model", var_07 + (0, 0, 30));
    var_08 thread func_5114(var_04, var_07 + (0, 0, 1500), 2.0, 1.0, 0.05);
    var_3[var_3.size] = var_08;
    wait 0.2;
    var_04 = var_04 - 0.2;
  }

  return var_03;
}

func_139B2() {
  self endon("bombardment_finished");
  level endon("game_ended");
  scripts\engine\utility::waittill_any("disconnect", "joined_team");

  if(scripts\mp\utility\game::istrue(level.func_2C48)) {
    level.func_2C48 = undefined;
  }
}

func_D910() {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(8.0);
  scripts\mp\utility\game::printgameaction("killstreak ended - bombardment", self);
}

func_5114(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  wait(var_00);

  if(scripts\mp\utility\game::istrue(var_05)) {
    var_07 = 0;
    var_08 = [];

    for(var_09 = 0; var_09 < var_06; var_9++) {
      var_10 = randomint(100);
      var_11 = randomint(360);
      var_12 = var_1[0] + var_10 * cos(var_11);
      var_13 = var_1[1] + var_10 * sin(var_11);
      var_14 = var_1[2];
      var_15 = (var_12, var_13, var_14);
      var_8[var_8.size] = var_15;
    }

    while(var_07 < var_06) {
      self moveto(var_8[var_07], 0.05);
      var_7++;
      scripts\engine\utility::waitframe();
    }
  } else
    self moveto(var_01, var_02, var_03, var_04);
}

findclosestunobstructedpointonnavmeshradius(var_00, var_01, var_02, var_03) {
  var_04 = getclosestpointonnavmesh(var_00);
  var_05 = undefined;
  var_06 = func_7DBB(var_00, var_01, var_02, var_03);

  foreach(var_08 in var_06) {
    var_09 = getclosestpointonnavmesh(var_08);
    var_10 = var_09 + (0, 0, 20);
    var_11 = var_10 + (0, 0, 10000);
    var_12 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
    var_13 = scripts\engine\trace::ray_trace(var_10, var_11, level.characters, var_12);

    if(isDefined(var_13["hittype"]) && var_13["hittype"] == "hittype_none") {
      var_14 = distance2dsquared(var_00, var_09);

      if(!isDefined(var_05) || var_14 < var_05) {
        var_05 = var_14;
        var_04 = var_09;
      }
    }
  }

  return var_04;
}

func_7DBB(var_00, var_01, var_02, var_03) {
  var_04 = [];
  var_05 = 7;

  if(scripts\mp\killstreaks\utility::func_A69F(var_03, "passive_fast_launch")) {
    var_05 = 4;
  }

  for(var_06 = 0; var_06 < var_05; var_6++) {
    var_07 = randomint(var_02);
    var_08 = randomint(360);
    var_09 = var_0[0] + var_07 * cos(var_08);
    var_10 = var_0[1] + var_07 * sin(var_08);
    var_11 = var_0[2];
    var_12 = (var_09, var_10, var_11);
    var_13 = var_12 + (0, 0, var_01);
    var_14 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
    var_15 = physics_createcontents(var_14);
    var_16 = scripts\engine\trace::ray_trace(var_13, var_12 - (0, 0, 10000), level.characters, var_15);
    var_4[var_4.size] = var_16["position"];
  }

  return var_04;
}

func_6D7D(var_00, var_01, var_02, var_03, var_04) {
  self endon("disconnect");
  level endon("game_ended");

  foreach(var_06 in var_00) {
    if(!isDefined(self)) {
      break;
    }
    var_07 = var_06 + (0, 0, var_01);
    var_08 = var_06;
    var_09 = randomfloatrange(0.3, 0.5);

    if(scripts\mp\killstreaks\utility::func_A69F(var_04, "passive_fast_launch")) {
      var_09 = randomfloatrange(0.1, 0.3);
    }

    var_10 = spawnStruct();
    var_10.origin = var_08;
    var_10.streakname = var_02;
    var_10.radius = 350;
    var_10.team = self.team;
    level.artillerydangercenters[level.artillerydangercenters.size] = var_10;
    level thread func_6D84(self, var_07, var_08, self.angles, var_10, var_03, 0, var_04);
    wait(var_09);
  }
}

func_6D84(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  level endon("game_ended");
  var_08 = spawn("script_model", var_02 + (0, 0, 3));
  var_08 setModel("ks_bombardment_mp");
  var_08 setentityowner(var_00);
  var_08 setotherent(var_00);
  var_8.weapon_name = "bombproj_mp";
  var_8.streakinfo = var_07;
  var_8.killcament = var_05;

  if(scripts\mp\killstreaks\utility::func_A69F(var_07, "passive_fast_launch")) {
    var_08 setscriptablepartstate("target", "active_fast");
  } else {
    var_08 setscriptablepartstate("target", "active");
  }

  var_09 = 2;

  if(scripts\mp\killstreaks\utility::func_A69F(var_07, "passive_fast_launch")) {
    var_09 = 1.5;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_09);
  var_08 setscriptablepartstate("fire", "active");

  if(isDefined(var_00)) {
    wait 0.5;
    var_08 setscriptablepartstate("explosion", "active", 0);
    var_08 thread scripts\mp\utility\game::delayentdelete(5);
    level.artillerydangercenters = scripts\engine\utility::array_remove(level.artillerydangercenters, var_04);
  } else {
    level.artillerydangercenters = scripts\engine\utility::array_remove(level.artillerydangercenters, var_04);

    if(isDefined(var_05)) {
      var_05 delete();
    }
  }
}

func_511A(var_00, var_01, var_02) {
  self endon("death");
  wait(var_00);
  playFXOnTag(scripts\engine\utility::getfx(var_01), self, var_02);
}

triggeredbombardmentweapon(var_00) {
  if(scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_impulse_explosion")) {
    var_0.func_EF88 = "gesture_script_weapon";
    var_0.weapon = "ks_gesture_generic_mp";
    var_0.func_6D6B = "offhand_fired";
  }

  return 1;
}