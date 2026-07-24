/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_skyway\mp_skyway.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_skyway\mp_skyway_precache::main();
  scripts\mp\maps\mp_skyway\gen\mp_skyway_art::main();
  scripts\mp\maps\mp_skyway\mp_skyway_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_skyway");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_drawsun", 0);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraAccurateOcclusionThreshold", 800);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread _id_CDA4("mp_moon_screen_destinations_v2");
  thread _id_5364();
  thread securitymetaldetectors();
  level.removedspawnpoints = [];
  level.removedspawnpoints[247] = 1;
}

_id_CDA4(var_0) {
  level scripts\engine\utility::waittill_either("allRigsBooted", "prematch_done");
  playcinematicforalllooping(var_0);
}

_id_5364() {
  wait 5;
  var_0 = getEntArray("destructible_screens", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_5365);
}

_id_5365() {
  self endon("death");
  var_0 = getglass(self.target);

  if(!isDefined(var_0)) {
    iprintlnbold("GLASS ID AT " + self.origin + "IS UNDEFINED");
    return;
  }

  while(!isglassdestroyed(var_0)) {
    wait 0.05;
  }

  if(!isDefined(self._id_ED83)) {
    playFX(scripts\engine\utility::getfx("vfx_moon_adscreen_sparks_runner"), self.origin);
  }

  self delete();
}

securitymetaldetectors() {
  level endon("game_ended");
  var_0 = getEnt("audio_metal_detector", "targetname");

  if(isDefined(var_0)) {
    for(;;) {
      var_0 waittill("trigger", var_1);
      playsoundatpos(var_1.origin + (0, 0, 80), "skyway_metal_detector_beep");
    }
  }
}