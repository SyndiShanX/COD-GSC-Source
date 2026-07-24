/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_breakneck\mp_breakneck.gsc
*********************************************************/

main() {
  scripts\mp\maps\mp_breakneck\mp_breakneck_precache::main();
  scripts\mp\maps\mp_breakneck\gen\mp_breakneck_art::main();
  scripts\mp\maps\mp_breakneck\mp_breakneck_fx::main();
  level _id_D80C();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_breakneck");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraShadowCasters", 1);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("r_umbraAccurateOcclusionThreshold", 1000);
  setDvar("sm_sunCascadeSizeMultiplier1", 3);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  level _id_2FBC();
  thread scripts\mp\animation_suite::animationsuite();
  thread fix_collision();
}

fix_collision() {
  var_0 = getEnt("clip512x512x8", "targetname");
  var_1 = spawn("script_model", (-43104, 296, 512));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("clip512x512x8", "targetname");
  var_3 = spawn("script_model", (-43104, 808, 512));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = spawn("script_model", (-37408, 288, 80));
  var_4.angles = (0, 270, 0);
  var_4 setModel("panel_metal_03_16x208_mp_parkour_patch");
  var_5 = spawn("script_model", (-37408, 496, 80));
  var_5.angles = (0, 270, 0);
  var_5 setModel("panel_metal_03_16x208_mp_parkour_patch");
  var_6 = spawn("script_model", (-37504, 208, 80));
  var_6.angles = (0, 180, 0);
  var_6 setModel("panel_metal_03_16x208_mp_parkour_patch");
}

_id_D80C() {
  level._id_2B31 = ["superstructure_hull_chunk_01", "superstructure_hull_chunk_02", "debris_exterior_damaged_metal_panels_01", "debris_exterior_damaged_metal_panels_02", "debris_exterior_damaged_metal_panels_03", "debris_exterior_damaged_metal_panels_08", "machinery_tower_pipe_beam_support_01_destroyed"];

  foreach(var_1 in level._id_2B31)
  precachemodel(var_1);

  level._id_871B = ["weapon_spas12_wm", "weapon_ripper_rare_wm", "weapon_vr_rifle_wm"];

  foreach(var_4 in level._id_871B)
  precachemodel(var_4);

  precachemodel("armory_weapon_locker_clamp_bn");
}

_id_2FBC() {
  if(getDvar("r_reflectionProbeGenerate") != "1") {
    thread _id_CDA4("mp_breakneck_collision_bink_01");
    thread _id_FA92();
    thread _id_226A();
  }
}

_id_226A() {
  scripts\engine\utility::waitframe();

  if(isDefined(scripts\engine\utility::getStruct("gunrack_up", "targetname")) && isDefined(scripts\engine\utility::getStruct("gunrack_down", "targetname"))) {
    level._id_871A = spawnStruct();
    level._id_871A._id_12F6C = spawnStruct();
    level._id_871A._id_12F6C.start = scripts\engine\utility::getStruct("gunrack_up", "targetname");
    level._id_871A._id_12F6C.end = scripts\engine\utility::getStruct(level._id_871A._id_12F6C.start.target, "targetname");
    level._id_871A._id_12F6C._id_871C = _id_226B(level._id_871A._id_12F6C.start.origin, 1);
    level._id_871A._id_5AF4 = spawnStruct();
    level._id_871A._id_5AF4.start = scripts\engine\utility::getStruct("gunrack_down", "targetname");
    level._id_871A._id_5AF4.end = scripts\engine\utility::getStruct(level._id_871A._id_5AF4.start.target, "targetname");
    level._id_871A._id_5AF4._id_871C = _id_226B(level._id_871A._id_5AF4.start.origin, 0);
    level._id_871A._id_12F6C thread _id_2268();
    level._id_871A._id_5AF4 thread _id_2268();
  }
}

_id_226B(var_0, var_1) {
  level endon("game_ended");
  var_2 = [];

  for(;;) {
    var_3 = spawn("script_model", (0, 0, 0));
    var_3 setModel("armory_weapon_locker_clamp_bn");
    var_3._id_870F = spawn("script_model", (0, 0, 0));
    var_3._id_870F setModel("tag_origin");
    var_3._id_870F.offsets = [];

    if(var_1 == 1) {
      var_3.angles = (90, 0, 0);
      var_3._id_870F.angles = (0, 354, 0);
      var_3._id_870F.offsets["weapon_spas12_wm"] = (-15.7, -5, 3.2);
      var_3._id_870F.offsets["weapon_ripper_rare_wm"] = (-14.1, -3.7, 2.8);
      var_3._id_870F.offsets["weapon_vr_rifle_wm"] = (-15.5, -4.8, 2.3);
    } else {
      var_3.angles = (90, 0, -180);
      var_3._id_870F.angles = (0, 174, 0);
      var_3._id_870F.offsets["weapon_spas12_wm"] = (15.7, 5, 3.2);
      var_3._id_870F.offsets["weapon_ripper_rare_wm"] = (14.1, 3.7, 2.8);
      var_3._id_870F.offsets["weapon_vr_rifle_wm"] = (15.5, 4.8, 2.3);
    }

    var_3._id_870F linkTo(var_3);
    var_3.origin = var_0;
    var_2[var_2.size] = var_3;

    if(var_2.size == 10) {
      break;
    }
  }

  return var_2;
}

_id_2268() {
  foreach(var_1 in self._id_871C) {
    thread _id_2269(var_1);
    wait 8;
  }
}

_id_2269(var_0) {
  for(;;) {
    var_0._id_870F unlink();
    var_0 dontinterpolate();
    var_0.origin = self.start.origin;
    scripts\engine\utility::waitframe();

    if(randomint(100) < 90) {
      var_0._id_870F setModel(scripts\engine\utility::random(level._id_871B));
      var_0._id_870F.origin = var_0.origin + var_0._id_870F.offsets[var_0._id_870F.model];
    } else {
      var_0._id_870F setModel("tag_origin");
      var_0._id_870F.origin = var_0.origin;
    }

    var_0._id_870F linkTo(var_0);
    var_0 moveTo(self.end.origin, 80);
    var_0 waittill("movedone");
  }
}

_id_FA92() {
  level._id_2B2F = spawnStruct();
  level thread _id_FA94();
}

_id_FA94() {
  if(!isDefined(game["roundsPlayed"])) {
    level._id_2B2F._id_DAE3 = scripts\engine\utility::getStruct("breakneck_blackhole_target_loc", "script_noteworthy");
    level._id_2B2F._id_DAE5 = _id_FA93(scripts\engine\utility::getStructArray("breakneck_blackhole_spawn_loc", "script_noteworthy"));
    level._id_2B2F._id_DAE4 = getEntArray("breakneck_blackhole_pull", "targetname");

    if(isDefined(level._id_2B2F._id_DAE3)) {
      if(level._id_2B2F._id_DAE3.size != 0)
        scripts\engine\utility::array_thread(level._id_2B2F._id_DAE5, ::_id_139AE);

      if(level._id_2B2F._id_DAE4.size != 0)
        level thread _id_139AF();
    }
  }

  level thread _id_2B44();
}

_id_FA93(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    var_4 setModel("tag_origin");
    var_4.angles = (0, 0, 0);
    var_4._id_2887 = var_4.origin;
    var_4.physicsactivated = 0;
    var_4._id_C2CD = 0;
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_2B44() {
  level waittill("match_start_real_countdown");
  var_0 = getscriptablearray("scriptable_spawn_pulls", "targetname");

  if(game["roundsPlayed"] == 0) {
    foreach(var_2 in var_0)
    var_2 setscriptablepartstate("default", "countdown_anim");
  } else {
    foreach(var_2 in var_0)
    var_2 setscriptablepartstate("default", "fast_anim");
  }
}

_id_139AE() {
  level endon("game_ended");
  wait(randomint(15));

  for(;;) {
    self.angles = (scripts\engine\utility::cointoss() * randomint(360), scripts\engine\utility::cointoss() * randomint(360), scripts\engine\utility::cointoss() * randomint(360));
    self setModel(scripts\engine\utility::random(level._id_2B31));
    self moveTo(level._id_2B2F._id_DAE3.origin, 60 + scripts\engine\utility::cointoss() * randomint(15), 0, 0);
    self rotateby((scripts\engine\utility::cointoss() * randomint(360), scripts\engine\utility::cointoss() * randomint(360), scripts\engine\utility::cointoss() * randomint(360)), 30, 0, 0);
    self waittill("movedone");
    wait(15 + scripts\engine\utility::cointoss() * randomint(15));
    self dontinterpolate();
    self.origin = self._id_2887;
    scripts\engine\utility::waitframe();
  }
}

_id_139AF() {
  level endon("game_ended");

  foreach(var_1 in level._id_2B2F._id_DAE4)
  var_1.physicsactivated = 0;

  for(;;) {
    wait(15 + scripts\engine\utility::cointoss() * randomint(15));
    var_3 = scripts\engine\utility::random(level._id_2B2F._id_DAE4);
    var_3 thread _id_2B43();
    level._id_2B2F._id_DAE4 = scripts\engine\utility::array_remove(level._id_2B2F._id_DAE4, var_3);

    if(level._id_2B2F._id_DAE4.size == 0) {
      break;
    }
  }
}

_id_2B43() {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);

  var_0 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 32), self.angles);
  var_0 show();
  var_1 = vectortoangles(level._id_2B2F._id_DAE3.origin - self.origin);
  self rotateTo(var_1, 1);
  wait 1;
  self moveTo(level._id_2B2F._id_DAE3.origin, 60 + scripts\engine\utility::cointoss() * randomint(15), 0, 0);
  wait 0.1;
  playFXOnTag(level._effect["vfx_breakneck_explosion_01"], var_0, "tag_origin");
  self rotatevelocity((var_1[0] / 4, 0, 0), 30);
  self waittill("movedone");
  stopFXOnTag(level._effect["vfx_breakneck_explosion_01"], var_0, "tag_origin");
  var_0 delete();
  self delete();
}

_id_CDA4(var_0) {
  wait 30;
  playcinematicforalllooping(var_0);
}