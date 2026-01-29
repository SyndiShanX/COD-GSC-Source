/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_morningwood.gsc
**********************************************/

main() {
  maps\mp\mp_morningwood_precache::main();
  maps\createart\mp_morningwood_art::main();
  maps\mp\mp_morningwood_fx::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_morningwood");
  maps\mp\_compass::setupminimap("compass_map_mp_morningwood");
  setdvar("sm_sunShadowScale", "0.7");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  thread maps\mp\_utility::killtrigger((-328, -712, 824), 40, 50);
  thread maps\mp\_utility::killtrigger((-368, -724, 824), 40, 50);
  thread maps\mp\_utility::killtrigger((-404, -752, 824), 40, 50);
  thread maps\mp\_utility::killtrigger((-440, -772, 824), 40, 50);
  thread spawn_blocker_collision((-324, -742.5, 816), (0, 27.4, 0));
  thread spawn_blocker_collision((-341, -751, 816), (0, 27.4, 0));
  thread spawn_blocker_collision((-392, -777, 816), (0, 26.8, 0));
  thread spawn_blocker_collision((-442.5, -802, 816), (0, 27.3, 0));
  audio_settings();
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "city", 0.15, 0.9, 2);
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