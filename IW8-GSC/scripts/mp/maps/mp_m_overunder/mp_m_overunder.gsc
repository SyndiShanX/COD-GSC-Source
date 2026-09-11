/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_overunder\mp_m_overunder.gsc
*************************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  scripts\mp\maps\mp_m_overunder\mp_m_overunder_precache::main();
  scripts\mp\maps\mp_m_overunder\gen\mp_m_overunder_art::main();
  scripts\mp\maps\mp_m_overunder\mp_m_overunder_fx::main();
  scripts\mp\maps\mp_m_overunder\mp_m_overunder_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_overunder", "codcaster_compass_map_mp_m_overunder");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("PKKMTTRQO", 8);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("LTMPKRLLNM", 5000);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "urban";
  thread setupbobbingboat("bobbingBoat");
  thread setup_vista_driving_boats();
  thread player_fired_gun_monitor();
  thread scripts\mp\destructible::rockable_cars_init();
}

function player_fired_gun_monitor() {
  var_0 = getEnt("player256x256x8", "targetname");
  var_1 = spawn("script_model", (296, -124, 128));
  var_1.angles = (90, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("mount32", "targetname");
  var_3 = spawn("script_model", (316, 866, 51));
  var_3.angles = (0, 342, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2, 1);
}

function setupbobbingboat(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1.startpos = var_1.origin;
  var_1.startang = var_1.angles;
  thread boatbob(var_1);
  thread boatwobble(var_1);
}

function boatbob(var_0) {
  level endon("game_ended");

  for(;;) {
    var_1 = randomfloatrange(4, 7);
    var_0.goalpos = var_0.startpos + (randomintrange(-2, 2), randomintrange(-2, 2), randomintrange(-3, 3));
    var_0 moveTo(var_0.goalpos, var_1, var_1 * 0.25, var_1 * 0.25);
    wait var_1;
  }
}

function boatwobble(var_0) {
  level endon("game_ended");

  for(;;) {
    var_1 = randomfloatrange(4, 6);
    var_0.goalang = var_0.startang + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1));
    var_0 rotateTo(var_0.goalang, var_1, var_1 * 0.25, var_1 * 0.25);
    wait var_1;
  }
}

function setup_vista_driving_boats() {
  wait 10;
  var_0 = getEntArray("boat_vista", "targetname");
  var_1 = 0.0125;
  var_2 = 0.0166667;
  var_3 = 0.0333333;
  wait 2;

  foreach(var_5 in var_0) {
    var_5.boatfx = scripts\engine\utility::spawn_tag_origin();
    var_5.boatfx.origin = var_5.origin;
    var_5.boatfx.angles = var_5.angles;
    var_5.boatfx.targetname = "boatFX";
    var_5.boatfx show();
    var_5.boatfx linkTo(var_5);
    wait 0.1;

    if(isDefined(var_5.script_label)) {
      if(var_5.script_label == "ship") {
        thread vista_boat_drive(var_5, var_3);
        playFXOnTag(scripts\engine\utility::getfx("cargo_ship_wake"), var_5.boatfx, "tag_origin");
        var_5 playLoopSound("emt_cargo_ship_wake");
      } else {
        thread vista_boat_drive(var_5, var_2);
        playFXOnTag(scripts\engine\utility::getfx("vfx_sailboat_wake"), var_5.boatfx, "tag_origin");
      }

      continue;
    }

    thread vista_boat_drive(var_5, var_1);
    playFXOnTag(scripts\engine\utility::getfx("vfx_tourboat_wake"), var_5.boatfx, "tag_origin");
    var_5 playLoopSound("emt_tour_boat_wake");
  }
}

function vista_boat_drive(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");

  for(;;) {
    var_3 = abs(distance(var_0.origin, var_2.origin) * var_1);
    var_0 moveTo(var_2.origin, var_3, 0, 0);
    var_0 rotateTo(var_2.angles, var_3, 0, 0);
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    wait var_3;
  }
}