/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_62b017dcf7b211f5.gsc
***********************************************/

main() {
  _id_4644B59366E572F1::main();
  _id_55278401AF972B92::main();
  _id_1CA56F1554A1454E::main();
  _id_5393EDFD98FC4F94::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_narcos");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("sm_sunSampleSizeNear", 1);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "mexico";
  thread _id_7D599A7369CD77F0();
  level thread _id_20A03E300905ECD6();
}

_id_7D599A7369CD77F0() {
  wait 12;
  scripts\engine\utility::exploder("birds_flyaway");
}

_id_20A03E300905ECD6() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  scriptables = getentitylessscriptablearray("shed_screens", "targetname", undefined, undefined, "screen");

  foreach(scriptable in scriptables)
  scriptable setscriptablepartstate("screen", "full");
}