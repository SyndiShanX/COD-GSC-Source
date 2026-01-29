/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_shipbreaker.gsc
**********************************************/

main() {
  maps\mp\mp_shipbreaker_precache::main();
  maps\createart\mp_shipbreaker_art::main();
  maps\mp\mp_shipbreaker_fx::main();
  maps\mp\_explosive_barrels::main();
  maps\mp\_load::main();
  ambientplay("ambient_mp_shipbreaker");
  maps\mp\_compass::setupminimap("compass_map_mp_shipbreaker");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_diffuseColorScale", 1.55);
  setdvar("r_specularColorScale", 3.4);
  thread maps\mp\mp_shipbreaker_scriptlights::main();

  if(level.ps3) {
    setdvar("sm_sunShadowScale", "0.6");
  } else {
    setdvar("sm_sunShadowScale", "0.7");

  }
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  audio_settings();
  thread play_fx_onconnect();
}

audio_settings() {
  maps\mp\_audio::add_reverb("default", "quarry", 0.15, 0.9, 2);
}

play_fx_onconnect() {
  var_0 = getent("com_wall_fan_blade_rotate_sb", "targetname");
  var_0 thread spin_objects();
  var_1 = var_0 common_scripts\utility::spawn_tag_origin();
  var_1 show();
  var_1 moveto(var_1.origin + (0, 0, 70), 0.05);
  common_scripts\utility::waitframe();
  var_1 thread spin_objects();

  for(;;) {
    level waittill("connected", var_2);
    var_2 thread play_fx_delay(var_1);
  }
}

play_fx_delay(var_0) {
  thread check_if_spawned(var_0);

  foreach(var_2 in level.players) {}
  var_2 thread check_if_spawned(var_0);
}

check_if_spawned(var_0) {
  self waittill("spawned");
  wait 0.05;

  if(!isDefined(self.lighthouse_fx) || !self.lighthouse_fx) {
    self.lighthouse_fx = 1;
    playfxontagforclients(level._effect["Searchlight"], var_0, "tag_origin", self);
  }
}

spin_objects() {
  self endon("death");
  var_0 = 50;
  var_1 = 1;
  var_0 = var_0 * var_1;
  var_2 = self.angles;
  var_3 = anglestoright(self.angles) * 100;
  var_3 = vectornormalize(var_3);
  var_4 = 20000;

  for(;;) {
    var_5 = abs(vectordot(var_3, (1, 0, 0)));
    var_6 = abs(vectordot(var_3, (0, 1, 0)));
    var_7 = abs(vectordot(var_3, (0, 0, 1)));

    if(var_5 > 0.9) {
      self rotatevelocity((var_0, 0, 0), var_4);
    } else if(var_6 > 0.9) {
      self rotatevelocity((var_0, 0, 0), var_4);
    } else if(var_7 > 0.9) {
      self rotatevelocity((0, var_0, 0), var_4);
    } else {
      self rotatevelocity((0, var_0, 0), var_4);

    }
    wait(var_4);
  }
}