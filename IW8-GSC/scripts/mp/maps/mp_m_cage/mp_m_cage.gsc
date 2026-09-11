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
  setDvar("LKOLRONRNQ", 1500);
  setDvar("LTQMSPKRKO", 4);
  setDvar("MROOOROPKL", 8);
  setDvar("PKKMTTRQO", 8);
  setDvar("MNQKPNLOPT", 1);
  setDvar("NRSOTSLSSO", 1);
  thread ref_14051();
}

function ref_14051() {
  setDvar("NPONLLLSPL", 0.25);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 2);
  setDvar("TMNTMTQRM", 0);
  setDvar("sm_compressedSunShadowFiltering", 1);
  setDvar("sm_compressedSunShadowFilteringMaxRadius", 4);
}

function ref_11e8d() {
  setDvar("NPONLLLSPL", 0.25);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 2);
  setDvar("TMNTMTQRM", 1);
}

function ref_11d80() {
  if(level.gametype == "arena") {
    wait 1;
    var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_axis_start");

    foreach(var2 in var0) {
      if(distance(var2.origin, (64, -528, 16)) < 10) {
        var2.origin = (90, -528, 16);
        continue;
      }

      if(distance(var2.origin, (-64, -528, 16)) < 10) {
        var2.origin = (-90, -528, 16);
      }
    }

    var4 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_allies_start");

    foreach(var2 in var4) {
      if(distance(var2.origin, (64, 528, 16)) < 10) {
        var2.origin = (90, 528, 16);
        continue;
      }

      if(distance(var2.origin, (-64, 528, 16)) < 10) {
        var2.origin = (-90, 528, 16);
      }
    }

    return;
  }
}

function ref_121f4() {
  var0 = spawn("script_model", (-3, 36, 12));
  var0 setModel("mp_m_cage_shotblocker");
  var0.angles = (0, 0, 0);
  var1 = spawn("script_model", (63, -36, 12));
  var1 setModel("mp_m_cage_shotblocker");
  var1.angles = (0, 0, 0);
}