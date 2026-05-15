#include maps\mp\_utility;

main() {
  maps\mp\mp_compact_precache::main();
  maps\createart\mp_compact_art::main();
  maps\mp\mp_compact_fx::main();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_compact");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.10);
  setDvar("r_lightGridContrast", 1);
  setDvar("compassmaxrange", "1700");
  setDvar("r_drawSun", 0);
  setDvar("r_tessellation", 0);
  setDvar("r_lodbiasrigid", -2000);
  setDvar("r_lodbiasskinned", -2000);
  setDvar("r_fog", 1);
  setDvar("r_smodelinstancedthreshold", 0);

  ambientPlay("ambient_mp_compact");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  setDvar("r_primaryLightUseTweaks", 1);
  setDvar("r_primaryLightTweakDiffuseStrength", 2.71);
  setDvar("r_primaryLightTweakSpecularStrength", 1);

  setDvar("r_viewModelPrimaryLightUseTweaks", 1);
  setDvar("r_viewModelPrimaryLightTweakDiffuseStrength", 2.71);
  setDvar("r_viewModelPrimaryLightTweakSpecularStrength", 1);

  setDvar("r_colorScaleUseTweaks", 1);
  setDvar("r_diffuseColorScale", 1.07);
  setDvar("r_specularColorScale", 2.69);

  setDvar("r_veil", 1);
  setDvar("r_veilusetweaks", 1);
  setDvar("r_veilStrength", 0.237);
  setDvar("r_veilBackgroundStrength", 1.343);
}

doMagnet() {
  strength = 18000;
  if(getDvar("scr_compact_magnet_strength") != "") {
    strength = getdvarfloat("scr_compact_magnet_strength");
  }
  if(strength == 0) {
    return;
  }
  radius = 250;
  if(getDvar("scr_compact_magnet_radius") != "") {
    radius = getdvarfloat("scr_compact_magnet_radius");
  }
  if(radius <= 0) {
    return;
  }
  magnet = getent("magnetorg", "targetname");
  Missile_CreateAttractorEnt(magnet, strength, radius);
}

crusherControl() {
  crusher = getEnt("crusher01", "targetname");

  crushTop = getEnt("crushtop01", "targetname");
  playerDetector = getEnt("onelevator", "targetname");

  upOrigin = crusher getOrigin();
  downOrigin = upOrigin + (0, 0, -128);

  crushTop thread triggerLinkThread(crusher);
  crushTop thread crushEmThread();
  playerDetector thread triggerLinkThread(crusher);
  playerDetector thread playerDetectorThread();

  for(;;) {
    /*
    button makeUsable();
    button waittill ( "trigger", player );
    button playSound( "vending_machine_button_press" );
    button makeUnusable();
    */

    crusher playSound("elev_run_start");
    crusher playLoopSound("elev_run_loop");

    crusher moveTo(downOrigin, 10.0);
    crusher waittill("movedone");

    crusher stopLoopSound("elev_run_loop");
    crusher playSound("elev_run_end");

    /*
    button makeUsable();
    button waittill ( "trigger", player );
    button playSound( "vending_machine_button_press" );
    button makeUnusable();
    */

    wait 2;

    playerDetector waittill("trigger", player);

    crusher playSound("elev_run_start");
    crusher playLoopSound("elev_run_loop");

    crusher moveTo(upOrigin, 10.0);
    crusher waittill("movedone");

    crusher stopLoopSound("elev_run_loop");
    crusher playSound("elev_run_end");

    wait 2;

    while(gettime() - playerDetector.triggertime <= 2000) {
      wait .05;
    }
  }
}

triggerLinkThread(crusher) {
  for(;;) {
    self.origin = crusher.origin;

    wait(0.05);
  }
}

playerDetectorThread() {
  self.triggertime = gettime();
  for(;;) {
    self waittill("trigger", player);
    self.triggertime = gettime();
  }
}

crushEmThread() {
  crushBottom = getEnt("crushbtm01", "targetname");

  for(;;) {
    self waittill("trigger", player);

    if(player isTouching(crushBottom) && isReallyAlive(player)) {
      player _suicide();
    }
  }
}