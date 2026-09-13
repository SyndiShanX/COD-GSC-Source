/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7c1225e893c677f9.gsc
***********************************************/

main() {
  _id_58989565E9A3BDE8::main();
  _id_0CAB1C8DED8DA82A::main();
  _id_28E46EEEEC9480C0::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registersmallmap();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_alley");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraAccurateOcclusionThreshold", 512);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread _id_6E3CCE6A02667476();
  thread _id_771F3D37D84F3215();
  _id_DA52D377FF534ECC();
}

_id_DA7C9335E454C032(player) {
  if(getdvarint("camera_thirdPerson") == 1 || istrue(level._id_DC65C33DFDD9EFE8))
    setDvar("camera_thirdpersonforceinteriorcamera", 1);
}

_id_6E3CCE6A02667476() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    _id_DA7C9335E454C032(player);
    player thread _id_5B2361E97848CABD();
  }
}

_id_5B2361E97848CABD() {
  self endon("disconnect");
  level waittill("game_ended");
  setDvar("camera_thirdpersonforceinteriorcamera", 0);
}

_id_771F3D37D84F3215() {
  _id_771F7B37D84FBA6F = spawn("trigger_rotatable_radius", (-288, -128, 192), 0, 256, 320);
  _id_771F7B37D84FBA6F.angles = (0, 0, 90);
  _id_771F7B37D84FBA6F.targetname = "callout_area";
  _id_771F7B37D84FBA6F.script_noteworthy = "market";
  _id_771F7C37D84FBCA2 = spawn("trigger_rotatable_radius", (512, -96, 128), 0, 512, 600);
  _id_771F7C37D84FBCA2.angles = (90, 0, 0);
  _id_771F7C37D84FBCA2.targetname = "callout_area";
  _id_771F7C37D84FBCA2.script_noteworthy = "wall";
  _id_771F7D37D84FBED5 = spawn("trigger_rotatable_radius", (-512, 96, 128), 0, 512, 600);
  _id_771F7D37D84FBED5.angles = (-90, 0, 0);
  _id_771F7D37D84FBED5.targetname = "callout_area";
  _id_771F7D37D84FBED5.script_noteworthy = "junk";
  _id_771F7637D84FAF70 = spawn("trigger_rotatable_radius", (0, 0, 120), 0, 192, 128);
  _id_771F7637D84FAF70.angles = (0, 0, 0);
  _id_771F7637D84FAF70.targetname = "callout_area";
  _id_771F7637D84FAF70.script_noteworthy = "bridge";
  _id_771F7737D84FB1A3 = spawn("trigger_rotatable_radius", (288, 128, 192), 0, 256, 320);
  _id_771F7737D84FB1A3.angles = (0, 0, -90);
  _id_771F7737D84FB1A3.targetname = "callout_area";
  _id_771F7737D84FB1A3.script_noteworthy = "hookah";
  _id_771F7837D84FB3D6 = spawn("trigger_rotatable_radius", (576, -704, 128), 0, 256, 320);
  _id_771F7837D84FB3D6.angles = (0, 0, 90);
  _id_771F7837D84FB3D6.targetname = "callout_area";
  _id_771F7837D84FB3D6.script_noteworthy = "carpet";
  _id_771F7937D84FB609 = spawn("trigger_rotatable_radius", (-576, 704, 128), 0, 256, 320);
  _id_771F7937D84FB609.angles = (0, 0, -90);
  _id_771F7937D84FB609.targetname = "callout_area";
  _id_771F7937D84FB609.script_noteworthy = "basket";
  _id_771F8237D84FC9D4 = spawn("trigger_rotatable_radius", (0, 0, -40), 0, 512, 128);
  _id_771F8237D84FC9D4.angles = (0, 0, 0);
  _id_771F8237D84FC9D4.targetname = "callout_area";
  _id_771F8237D84FC9D4.script_noteworthy = "alley";
}

_id_DA52D377FF534ECC() {
  _id_29D9D2428185616D = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "oic":
    case "aon":
    case "gun":
    case "dm":
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", (-768, 448, 0), (0, 270, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", (128, 384, 144), (0, 330, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", (-640, 960, 144), (0, 300, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", (768, -448, 0), (0, 90, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", (-144, -384, 144), (0, 150, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn_start", (640, -960, 144), (0, 120, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (-960, 0, -20), (0, 0, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (-384, 960, 144), (0, 270, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (128, 384, 144), (0, 330, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (720, 352, 208), (0, 270, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (488, -480, 128), (0, 90, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (-144, -384, 144), (0, 150, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (384, -960, 144), (0, 90, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (-448, 480, 128), (0, 270, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (768, -448, 0), (0, 90, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (-768, 448, 0), (0, 270, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (-712, -360, 208), (0, 90, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (960, 0, -20), (0, 180, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (0, -768, 144), (0, 90, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (760, -960, 144), (0, 135, 0));
      _id_29D9D2428185616D[_id_29D9D2428185616D.size] = scripts\mp\spawnlogic::createscriptedspawnpoint("mp_dm_spawn", (0, 768, 144), (0, 270, 0));
      break;
  }

  if(_id_29D9D2428185616D.size > 0)
    scripts\mp\spawnlogic::addscriptedspawnpoints(_id_29D9D2428185616D);
}