/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_28091398fc96955.gsc
***********************************************/

main() {
  _id_3743AF7D6A1C5B91::main();
  _id_4E6AE22C30A950BC::main();
  _id_099236BAF60F156E::main();
  _id_23B7DED7C7CF4834::main();
  _id_099236BAF60F156E::_id_D9A27307877FA33E();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_skerries_v2");
  setDvar("sm_sunCascadeSizeMultiplier1", 4);
  setDvar("sm_sunCascadeSizeMultiplier2", 4);
  setDvar("fx_gpu_lighting", 1);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraAccurateOcclusionThreshold", 1024);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread _id_B1262E3CB659ADD1();
  level thread _id_B2EA85004441D320();
}

_id_B1262E3CB659ADD1() {
  level waittill("infil_setup_complete");
  _id_EE23F0B1F42DA962 = getEnt("static_infil_rhib", "targetname");

  if(scripts\mp\flags::gameflag("infil_will_run") && isDefined(_id_EE23F0B1F42DA962)) {
    _id_EE23F0B1F42DA962 hide();
    level waittill("prematch_over");
    _id_EE23F0B1F42DA962 show();
  }
}

_id_B2EA85004441D320() {
  wait 0.5;

  foreach(player in level.players) {
    player._id_DF894B570D3259D4 = spawnfxforclient(level._effect["vfx_skerries_cam_rain_scripted"], player getEye(), player);

    if(isDefined(player._id_DF894B570D3259D4))
      triggerfx(player._id_DF894B570D3259D4);
  }

  if(scripts\mp\flags::gameflag("infil_will_run")) {
    level waittill("infil_started");
    players = scripts\mp\utility\teams::getteamdata("axis", "players");

    foreach(player in players) {
      if(isDefined(player._id_DF894B570D3259D4)) {
        player._id_DF894B570D3259D4 delete();
        player._id_DF894B570D3259D4 = undefined;
      }

      player._id_DF894B570D3259D4 = spawnfxforclient(level._effect["vfx_skerries_cam_rain_scripted"], player getEye(), player);

      if(isDefined(player._id_DF894B570D3259D4))
        triggerfx(player._id_DF894B570D3259D4);
    }

    players = scripts\mp\utility\teams::getteamdata("allies", "players");

    foreach(player in players) {
      if(isDefined(player._id_DF894B570D3259D4)) {
        player._id_DF894B570D3259D4 delete();
        player._id_DF894B570D3259D4 = undefined;
      }

      player._id_966200FFE8CED2C9 = spawnfxforclient(level._effect["vfx_skerries_cam_rain_infil_scripted"], player getEye(), player);

      if(isDefined(player._id_966200FFE8CED2C9))
        triggerfx(player._id_966200FFE8CED2C9);
    }

    wait 8.0;
    players = scripts\mp\utility\teams::getteamdata("allies", "players");

    foreach(player in players) {
      if(isDefined(player._id_966200FFE8CED2C9)) {
        player._id_966200FFE8CED2C9 delete();
        player._id_966200FFE8CED2C9 = undefined;
      }

      player._id_DF894B570D3259D4 = spawnfxforclient(level._effect["vfx_skerries_cam_rain_scripted"], player getEye(), player);

      if(isDefined(player._id_DF894B570D3259D4))
        triggerfx(player._id_DF894B570D3259D4);
    }
  }
}