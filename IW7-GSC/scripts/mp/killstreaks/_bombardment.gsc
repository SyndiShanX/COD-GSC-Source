/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_bombardment.gsc
***************************************************/

init() {
  func_FAB1();
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("bombardment", ::func_128DC, undefined, undefined, ::triggeredbombardmentweapon, ::func_13C8B);
  level.dangermaxradius["bombardment"] = 160000;
  var_00 = ["passive_fast_launch", "passive_decreased_explosions", "passive_extra_selection", "passive_increased_cost", "passive_impulse_explosion", "passive_single_explosion"];
  scripts\mp\killstreak_loot::func_DF07("bombardment", var_00);
}

func_FAB1() {
  level._effect["spike_charge"] = loadfx("vfx\iw7\_requests\mp\vfx_bombard_blast_source.vfx");
  level._effect["spike_fire"] = loadfx("vfx\iw7\_requests\mp\vfx_bombardment_aerial_blast.vfx");
  level._effect["spike_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_bombard_projectile_trail.vfx");
}

func_13C8B(param_00) {
  if(scripts\mp\utility::istrue(level.var_2C48)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  scripts\mp\killstreaks\_mapselect::func_10DC2(0, 0, undefined);
}

func_128DC(param_00) {
  var_01 = func_F1AC(param_00.lifeid, param_00.streakname, param_00);
  if(!isDefined(var_01) || !var_01) {
    return 0;
  }

  return 1;
}

func_F1AC(param_00, param_01, param_02) {
  scripts\engine\utility::allow_usability(0);
  scripts\engine\utility::allow_weapon_switch(0);
  var_03 = 3;
  var_04 = "Multi-Strike";
  var_05 = "used_bombardment";
  var_06 = scripts\mp\killstreak_loot::getrarityforlootitem(param_02.variantid);
  if(var_06 != "") {
    var_05 = var_05 + "_" + var_06;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_extra_selection")) {
    var_03 = 4;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_impulse_explosion")) {
    var_04 = "Single-Strike";
    var_07 = undefined;
  } else {
    var_08 = spawn("script_origin", self.origin);
    self playlocalsound("bombardment_killstreak_bootup");
    var_08 playLoopSound("bombardment_killstreak_hud_loop");
    self setsoundsubmix("mp_killstreak_overlay");
    var_07 = scripts\mp\killstreaks\_mapselect::_meth_8112(param_01, var_03);
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

  if(scripts\mp\utility::istrue(level.var_2C48)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
    return 0;
  }

  thread func_6CD4(var_07, param_01, var_04, param_02);
  level thread scripts\mp\utility::teamplayercardsplash(var_05, self);
  scripts\mp\matchdata::logkillstreakevent(param_01, self.origin);
  return 1;
}

func_6CD4(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  level endon("game_ended");
  var_04 = getent("airstrikeheight", "targetname");
  var_05 = var_04.origin[2] + 10000;
  if(!isDefined(var_05)) {
    var_05 = 20000;
  }

  if(!isDefined(param_02)) {
    param_02 = "Multi-Strike";
  }

  level.var_2C48 = 1;
  thread func_139B2();
  var_06 = [];
  if(param_02 == "Single-Strike") {
    var_07 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
    var_08 = physics_createcontents(var_07);
    var_09 = [];
    foreach(var_0B in level.players) {
      if(!scripts\mp\utility::isreallyalive(var_0B)) {
        continue;
      }

      if(level.teambased && var_0B.team == self.team) {
        continue;
      }

      if(!level.teambased && var_0B == self) {
        continue;
      }

      if(var_0B isinphase()) {
        continue;
      }

      var_0C = var_0B.origin + (0, 0, var_05);
      var_0D = scripts\common\trace::ray_trace(var_0C, var_0B.origin - (0, 0, 10000), level.characters, var_08);
      var_0E = var_0D["position"];
      var_09[var_09.size] = spawnStruct();
      var_09[var_09.size - 1].location = var_0E;
    }

    var_06 = createkillcaments(var_09, var_05, param_03);
    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
    foreach(var_13, var_11 in var_09) {
      var_12 = spawnStruct();
      var_12.origin = var_11.location;
      var_12.streakname = param_01;
      var_12.fgetarg = 350;
      var_12.team = self.team;
      playsoundatpos(var_11.location, "bombardment_laser_on_epic");
      level.artillerydangercenters[level.artillerydangercenters.size] = var_12;
      level thread func_6D84(self, var_05, var_11.location, self.angles, var_12, var_06[var_13], 0, param_03);
      wait(0.1);
    }
  } else {
    var_13 = createkillcaments(param_01, var_06, var_04);
    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
    foreach(var_13, var_15 in param_01) {
      thread sfx_bombardment_designator(var_15.location, param_03);
      if(param_02 == "Multi-Strike") {
        var_16 = func_7DBB(var_15.location, var_05, 500, param_03);
        thread func_6D7D(var_16, var_05, param_01, var_06[var_13], param_03);
        if(scripts\mp\killstreaks\_utility::func_A69F(param_03, "passive_fast_launch")) {
          wait(0.1);
        } else {
          wait(0.2);
        }
      }
    }
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(7);
  level.var_2C48 = undefined;
  self notify("bombardment_finished");
  thread func_D910();
  if(isDefined(var_06) && var_06.size > 0) {
    foreach(var_18 in var_06) {
      var_18 delete();
    }
  }
}

sfx_bombardment_designator(param_00, param_01) {
  var_02 = spawn("script_model", param_00);
  var_02 setModel("ks_bombardment_mp");
  var_03 = "active";
  var_04 = 5;
  if(scripts\mp\killstreaks\_utility::func_A69F(param_01, "passive_fast_launch")) {
    var_03 = "active_fast";
    var_04 = 5;
  }

  var_02 setscriptablepartstate("buildup", var_03, 0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_04);
  var_02 setscriptablepartstate("buildup", "neutral", 0);
  var_02 delete();
}

createkillcaments(param_00, param_01, param_02) {
  var_03 = [];
  var_04 = 1.5;
  foreach(var_06 in param_00) {
    var_07 = findclosestunobstructedpointonnavmeshradius(var_06.location, param_01, 500, param_02);
    var_08 = spawn("script_model", var_07 + (0, 0, 30));
    var_08 thread func_5114(var_04, var_07 + (0, 0, 1500), 2, 1, 0.05);
    var_03[var_03.size] = var_08;
    wait(0.2);
    var_04 = var_04 - 0.2;
  }

  return var_03;
}

func_139B2() {
  self endon("bombardment_finished");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("disconnect", "joined_team");
  if(scripts\mp\utility::istrue(level.var_2C48)) {
    level.var_2C48 = undefined;
  }
}

func_D910() {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(8);
  scripts\mp\utility::printgameaction("killstreak ended - bombardment", self);
}

func_5114(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  wait(param_00);
  if(scripts\mp\utility::istrue(param_05)) {
    var_07 = 0;
    var_08 = [];
    for(var_09 = 0; var_09 < param_06; var_09++) {
      var_0A = randomint(100);
      var_0B = randomint(360);
      var_0C = param_01[0] + var_0A * cos(var_0B);
      var_0D = param_01[1] + var_0A * sin(var_0B);
      var_0E = param_01[2];
      var_0F = (var_0C, var_0D, var_0E);
      var_08[var_08.size] = var_0F;
    }

    while(var_07 < param_06) {
      self moveto(var_08[var_07], 0.05);
      var_07++;
      scripts\engine\utility::waitframe();
    }

    return;
  }

  self moveto(param_01, param_02, param_03, param_04);
}

findclosestunobstructedpointonnavmeshradius(param_00, param_01, param_02, param_03) {
  var_04 = getclosestpointonnavmesh(param_00);
  var_05 = undefined;
  var_06 = func_7DBB(param_00, param_01, param_02, param_03);
  foreach(var_08 in var_06) {
    var_09 = getclosestpointonnavmesh(var_08);
    var_0A = var_09 + (0, 0, 20);
    var_0B = var_0A + (0, 0, 10000);
    var_0C = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
    var_0D = scripts\common\trace::ray_trace(var_0A, var_0B, level.characters, var_0C);
    if(isDefined(var_0D["hittype"]) && var_0D["hittype"] == "hittype_none") {
      var_0E = distance2dsquared(param_00, var_09);
      if(!isDefined(var_05) || var_0E < var_05) {
        var_05 = var_0E;
        var_04 = var_09;
      }
    }
  }

  return var_04;
}

func_7DBB(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_05 = 7;
  if(scripts\mp\killstreaks\_utility::func_A69F(param_03, "passive_fast_launch")) {
    var_05 = 4;
  }

  for(var_06 = 0; var_06 < var_05; var_06++) {
    var_07 = randomint(param_02);
    var_08 = randomint(360);
    var_09 = param_00[0] + var_07 * cos(var_08);
    var_0A = param_00[1] + var_07 * sin(var_08);
    var_0B = param_00[2];
    var_0C = (var_09, var_0A, var_0B);
    var_0D = var_0C + (0, 0, param_01);
    var_0E = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
    var_0F = physics_createcontents(var_0E);
    var_10 = scripts\common\trace::ray_trace(var_0D, var_0C - (0, 0, 10000), level.characters, var_0F);
    var_04[var_04.size] = var_10["position"];
  }

  return var_04;
}

func_6D7D(param_00, param_01, param_02, param_03, param_04) {
  self endon("disconnect");
  level endon("game_ended");
  foreach(var_06 in param_00) {
    if(!isDefined(self)) {
      break;
    }

    var_07 = var_06 + (0, 0, param_01);
    var_08 = var_06;
    var_09 = randomfloatrange(0.3, 0.5);
    if(scripts\mp\killstreaks\_utility::func_A69F(param_04, "passive_fast_launch")) {
      var_09 = randomfloatrange(0.1, 0.3);
    }

    var_0A = spawnStruct();
    var_0A.origin = var_08;
    var_0A.streakname = param_02;
    var_0A.fgetarg = 350;
    var_0A.team = self.team;
    level.artillerydangercenters[level.artillerydangercenters.size] = var_0A;
    level thread func_6D84(self, var_07, var_08, self.angles, var_0A, param_03, 0, param_04);
    wait(var_09);
  }
}

func_6D84(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  level endon("game_ended");
  var_08 = spawn("script_model", param_02 + (0, 0, 3));
  var_08 setModel("ks_bombardment_mp");
  var_08 setentityowner(param_00);
  var_08 setotherent(param_00);
  var_08.weapon_name = "bombproj_mp";
  var_08.streakinfo = param_07;
  var_08.killcament = param_05;
  if(scripts\mp\killstreaks\_utility::func_A69F(param_07, "passive_fast_launch")) {
    var_08 setscriptablepartstate("target", "active_fast");
  } else {
    var_08 setscriptablepartstate("target", "active");
  }

  var_09 = 2;
  if(scripts\mp\killstreaks\_utility::func_A69F(param_07, "passive_fast_launch")) {
    var_09 = 1.5;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_09);
  var_08 setscriptablepartstate("fire", "active");
  if(isDefined(param_00)) {
    wait(0.5);
    var_08 setscriptablepartstate("explosion", "active", 0);
    var_08 thread scripts\mp\utility::delayentdelete(5);
    level.artillerydangercenters = scripts\engine\utility::array_remove(level.artillerydangercenters, param_04);
    return;
  }

  level.artillerydangercenters = scripts\engine\utility::array_remove(level.artillerydangercenters, param_04);
  if(isDefined(param_05)) {
    param_05 delete();
  }
}

func_511A(param_00, param_01, param_02) {
  self endon("death");
  wait(param_00);
  playFXOnTag(scripts\engine\utility::getfx(param_01), self, param_02);
}

triggeredbombardmentweapon(param_00) {
  if(scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_impulse_explosion")) {
    param_00.var_EF88 = "gesture_script_weapon";
    param_00.var_394 = "ks_gesture_generic_mp";
    param_00.var_6D6B = "offhand_fired";
  }

  return 1;
}