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
  var0 = getEnt("player256x256x8", "targetname");
  var1 = spawn("script_model", (296, -124, 128));
  var1.angles = (90, 0, 0);
  var1 clonebrushmodeltoscriptmodel(var0);
  var2 = getEnt("mount32", "targetname");
  var3 = spawn("script_model", (316, 866, 51));
  var3.angles = (0, 342, 0);
  var3 clonebrushmodeltoscriptmodel(var2, 1);
}

function setupbobbingboat(var0) {
  var1 = getEnt(var0, "targetname");
  var1.startpos = var1.origin;
  var1.startang = var1.angles;
  thread boatbob(var1);
  thread boatwobble(var1);
}

function boatbob(var0) {
  level endon("game_ended");

  for(;;) {
    var1 = randomfloatrange(4, 7);
    var0.goalpos = var0.startpos + (randomintrange(-2, 2), randomintrange(-2, 2), randomintrange(-3, 3));
    var0 moveTo(var0.goalpos, var1, var1 * 0.25, var1 * 0.25);
    wait var1;
  }
}

function boatwobble(var0) {
  level endon("game_ended");

  for(;;) {
    var1 = randomfloatrange(4, 6);
    var0.goalang = var0.startang + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1));
    var0 rotateTo(var0.goalang, var1, var1 * 0.25, var1 * 0.25);
    wait var1;
  }
}

function setup_vista_driving_boats() {
  wait 10;
  var0 = getEntArray("boat_vista", "targetname");
  var1 = 0.0125;
  var2 = 0.0166667;
  var3 = 0.0333333;
  wait 2;

  foreach(var5 in var0) {
    var5.boatfx = scripts\engine\utility::spawn_tag_origin();
    var5.boatfx.origin = var5.origin;
    var5.boatfx.angles = var5.angles;
    var5.boatfx.targetname = "boatFX";
    var5.boatfx show();
    var5.boatfx linkTo(var5);
    wait 0.1;

    if(isDefined(var5.script_label)) {
      if(var5.script_label == "ship") {
        thread vista_boat_drive(var5, var3);
        playFXOnTag(scripts\engine\utility::getfx("cargo_ship_wake"), var5.boatfx, "tag_origin");
        var5 playLoopSound("emt_cargo_ship_wake");
      } else {
        thread vista_boat_drive(var5, var2);
        playFXOnTag(scripts\engine\utility::getfx("vfx_sailboat_wake"), var5.boatfx, "tag_origin");
      }

      continue;
    }

    thread vista_boat_drive(var5, var1);
    playFXOnTag(scripts\engine\utility::getfx("vfx_tourboat_wake"), var5.boatfx, "tag_origin");
    var5 playLoopSound("emt_tour_boat_wake");
  }
}

function vista_boat_drive(var0, var1) {
  var2 = scripts\engine\utility::getStruct(var0.target, "targetname");

  for(;;) {
    var3 = abs(distance(var0.origin, var2.origin) * var1);
    var0 moveTo(var2.origin, var3, 0, 0);
    var0 rotateTo(var2.angles, var3, 0, 0);
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
    wait var3;
  }
}