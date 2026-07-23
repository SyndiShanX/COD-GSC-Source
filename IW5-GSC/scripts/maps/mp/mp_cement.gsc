/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_cement.gsc
*****************************************/

main() {
  if(!isDefined(level.func)) {
    level.func = [];
  }
  level.func["precacheMpAnim"] = ::precachempanim;
  level.func["scriptModelPlayAnim"] = ::scriptmodelplayanim;
  level.func["scriptModelClearAnim"] = ::scriptmodelclearanim;
  common_scripts\_interactive::init();
  maps\mp\mp_cement_precache::main();
  maps\createart\mp_cement_art::main();
  maps\mp\mp_cement_fx::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_cement");
  maps\mp\_compass::setupminimap("compass_map_mp_cement");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  if(level.ps3) {
    setDvar("sm_sunShadowScale", "0.5");
  } else {
    setDvar("sm_sunShadowScale", "0.8");
  }
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  thread spawn_blocker_collision((166, -670, 388), (0, 270, 0));
  thread spawn_blocker_collision((166, -670, 360), (0, 270, 0));
  thread spawn_blocker_collision((166, -728, 388), (0, 270, 0));
  thread spawn_blocker_collision((166, -728, 360), (0, 270, 0));
  thread spawn_blocker_collision((166, -786, 388), (0, 270, 0));
  thread spawn_blocker_collision((166, -786, 360), (0, 270, 0));
}

spawn_blocker_collision(var_0, var_1) {
  while(!isDefined(level.airdropcratecollision)) {
    wait 0.05;
  }
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("tag_origin");
  var_2.origin = var_0;
  var_2.angles = var_1;
  var_2 clonebrushmodeltoscriptmodel(level.airdropcratecollision);
}