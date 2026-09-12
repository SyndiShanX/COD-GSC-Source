/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_cage\mp_m_cage.gsc
***************************************************/

function main() {
  scripts\mp\maps\mp_m_cage\mp_m_cage_precache::main();
  scripts\mp\maps\mp_m_cage\gen\mp_m_cage_art::main();
  scripts\mp\maps\mp_m_cage\mp_m_cage_fx::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_cage", "codcaster_compass_map_mp_m_cage");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread lighting_setup_dvars();
  thread scripts\mp\animation_suite::animationsuite();
  thread ref_11d80();
  thread ref_121f4();
}

function lighting_setup_dvars() {
  setDvar("sm_spotDistCull", 1500);
  setDvar("sm_spotUpdateLimit", 4);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  thread ref_14051();
}

function ref_14051() {
  setDvar("sm_sunSampleSizeNear", 0.25);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_compressedSunShadowFiltering", 1);
  setDvar("sm_compressedSunShadowFilteringMaxRadius", 4);
}

function ref_11e8d() {
  setDvar("sm_sunSampleSizeNear", 0.25);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  setDvar("sm_sunDistantShadows", 1);
}

function ref_11d80() {
  if(level.gametype == "arena") {
    wait 1;
    var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_axis_start");

    foreach(var_2 in var_0) {
      if(distance(var_2.origin, (64, -528, 16)) < 10) {
        var_2.origin = (90, -528, 16);
        continue;
      }

      if(distance(var_2.origin, (-64, -528, 16)) < 10) {
        var_2.origin = (-90, -528, 16);
      }
    }

    var_4 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_allies_start");

    foreach(var_2 in var_4) {
      if(distance(var_2.origin, (64, 528, 16)) < 10) {
        var_2.origin = (90, 528, 16);
        continue;
      }

      if(distance(var_2.origin, (-64, 528, 16)) < 10) {
        var_2.origin = (-90, 528, 16);
      }
    }

    return;
  }
}

function ref_121f4() {
  var_0 = spawn("script_model", (-3, 36, 12));
  var_0 setModel("mp_m_cage_shotblocker");
  var_0.angles = (0, 0, 0);
  var_1 = spawn("script_model", (63, -36, 12));
  var_1 setModel("mp_m_cage_shotblocker");
  var_1.angles = (0, 0, 0);
}