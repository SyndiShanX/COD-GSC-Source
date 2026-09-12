/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\nuke_mp.gsc
***********************************************/

function ref_13FD1() {
  var_0 = getDvar("scr_moveVehicle", "");

  if(var_0 != "") {
    var_1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var_1)) {
      thread level_death_notify(var_1);
    }
  }

  var_2 = getDvar("scr_planeContrails", "");

  if(var_2 != "") {
    var_1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var_1)) {
      thread ref_123AA(var_1);
    }
  }

  var_3 = getDvar("scr_dropBomberBomb", "");

  if(var_3 != "") {
    var_1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var_1)) {
      thread minplunderdropondeath(var_1);
    }
  }

  var_4 = getDvar("scr_airplaneAutoShoot", "");

  if(var_4 != "") {
    var_1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var_1)) {
      thread br_laststandfinishplayerisincapacitated(var_1);
    }
  }

  var_5 = getDvar("scr_runFTD", "");

  if(var_5 != "") {
    level thread scripts\mp\gametypes\ftd::left_side_spawn_adjuster(var_5);
    return;
  }
}

function level_death_notify(var_0) {
  var_1 = self;
  level endon("game_ended");

  if(!isDefined(var_0)) {
    iprintlnbold("scr_brdev move_vehicle needs a parameter. Example: ground");
  }

  var_2 = var_1.origin;
  var_3 = var_1 getplayerangles();
  var_4 = anglesToForward(var_3);
  var_5 = (var_2[0], var_2[1], var_2[2] + var_1 getplayerviewheight());
  var_6 = var_5 + var_4 * 5000;
  var_7 = scripts\engine\trace::create_default_contents(0);
  var_8 = scripts\engine\trace::ray_trace(var_5, var_6, var_1, var_7);

  switch (var_0) {
    case "air":
      var_9 = (0, 0, 200);
      break;
    case "ground":
      var_9 = (0, 0, 0);
      break;
    default:
      iprintlnbold("Invalid move_vehicle parameter");
      return;
  }

  var_10 = var_9["entity"];

  if(!isDefined(var_10)) {
    var_11 = undefined;
    var_12 = 9000;

    foreach(var_14 in level.vehicle.instances) {
      foreach(var_10 in var_14) {
        var_16 = distance(var_10.origin, var_2.origin);

        if(var_16 == 0 || var_16 < var_12) {
          var_12 = var_16;
          var_11 = var_10;
        }
      }
    }

    var_10 = var_11;

    if(!isDefined(var_10)) {
      iprintlnbold("No valid vehicle to move was found.");
      return;
    }
  }

  var_19 = var_10.origin;
  var_20 = var_10.angles;
  var_21 = 10;
  var_22 = 0;

  if(!isDefined(var_10)) {
    return;
  }

  iprintlnbold("Vehicle Moving Debug: Moving ON");
  wait 1;

  if(var_10 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_10.origin += var_9;
    var_10 vehicle_turnengineon();
    var_10 vehicle_setspeed(10, 1, 1);

    while(var_22 < var_21) {
      var_22++;
      wait 1;

      if(!isDefined(var_10)) {
        return;
      }
    }

    var_10 vehicle_setspeed(0, 0, 20);
    var_10 vehicle_turnengineoff();
    wait 0.3;

    if(!isDefined(var_10)) {
      return;
    }

    var_10.origin = var_19;
    var_10.angles = var_20;
    return;
  }
}

function ref_123AA(var_0) {
  var_1 = self;
  var_2 = var_1.origin;
  var_3 = var_1 getplayerangles();
  var_4 = anglesToForward(var_3);
  var_5 = (var_2[0], var_2[1], var_2[2] + var_1 getplayerviewheight());
  var_6 = var_5 + var_4 * 5000;
  var_7 = scripts\engine\trace::create_default_contents(0);
  var_8 = scripts\engine\trace::ray_trace(var_5, var_6, var_1, var_7);
  var_9 = var_8["entity"];
  var_10 = scripts\engine\utility::array_combine(level.vehicle.instances["veh_a10fd"], level.vehicle.instances["veh_bt"]);

  if(!isDefined(var_9)) {
    var_11 = undefined;
    var_12 = 9000;

    foreach(var_9 in var_10) {
      var_14 = distance(var_9.origin, var_1.origin);

      if(var_14 == 0 || var_14 < var_12) {
        var_12 = var_14;
        var_11 = var_9;
      }
    }

    var_9 = var_11;

    if(!isDefined(var_9)) {
      iprintlnbold("No valid vehicle to move was found.");
      return;
    }
  }

  if(!isDefined(var_9 getscriptablepartstate("fx", 1))) {
    iprintlnbold("Vehicle does not have fx scriptable part state.");
    return;
  }

  if(!isDefined(var_9.hours)) {
    var_9.hours = 0;
  }

  if(var_9.hours) {
    iprintlnbold("Plane Debug: Contrails Off");
    var_9.hours = 0;
    var_9 setscriptablepartstate("fx", "base", 0);
    return;
  }

  var_9 notify("vehicle_contrails_debug");
  iprintlnbold("Plane Debug: Contrails On");
  var_9.hours = 1;
  var_9 setscriptablepartstate("fx", "trails", 0);
}

function minplunderdropondeath(var_0) {
  var_1 = self;
  var_2 = strtok(var_0, ",");
  var_3 = int(var_2[0]);
  var_4 = int(var_2[1]);
  var_5 = int(var_2[2]);

  if(!isDefined(var_3) || !isDefined(var_4) || !isDefined(var_5)) {
    iprintlnbold("Invalid bomb test: specify distance, height, wait seconds");
    return;
  }

  var_6 = anglesToForward(var_1.angles);
  var_7 = var_1.origin + var_6 * var_3 + (0, 0, int(var_4));
  iprintlnbold("Drop Bomb Debug: Bomb incoming!");
  wait var_5;
  _calloutmarkerping_handleluinotify_mappingdeletemarker::crushing_players(var_7);
}

function br_laststandfinishplayerisincapacitated(var_0) {
  var_1 = self;
  var_2 = int(var_0);

  if(!isDefined(var_2)) {
    iprintlnbold("AirplaneAutoShoot debug function requires height parameter. Example: 500");
    return;
  }

  var_3 = var_1.origin;
  var_4 = var_1 getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = (var_3[0], var_3[1], var_3[2] + var_1 getplayerviewheight());
  var_7 = var_6 + var_5 * 5000;
  var_8 = scripts\engine\trace::create_default_contents(0);
  var_9 = scripts\engine\trace::ray_trace(var_6, var_7, var_1, var_8);
  var_10 = var_9["entity"];
  var_11 = scripts\engine\utility::array_combine(level.vehicle.instances["veh_a10fd"]);

  if(!isDefined(var_10)) {
    var_12 = undefined;
    var_13 = 9000;

    foreach(var_10 in var_11) {
      var_15 = distance(var_10.origin, var_1.origin);

      if(var_15 == 0 || var_15 < var_13) {
        var_13 = var_15;
        var_12 = var_10;
      }
    }

    var_10 = var_12;

    if(!isDefined(var_10)) {
      iprintlnbold("No valid vehicle to move was found.");
      return;
    }
  }

  if(!isDefined(var_10)) {
    return;
  }

  if(istrue(var_10.turn_on_steam)) {
    var_10.turn_on_steam = 0;
  } else {
    var_10.turn_on_steam = 1;
    var_10.isuseobject = var_10.origin;
    var_10.isteamvoplaying = var_10.origin + (0, 0, var_2);
  }

  var_17 = 0.2;

  if(isDefined(level.picking_up_minigun)) {
    var_17 = level.picking_up_minigun;
  }

  if(var_10 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_10.angles = (90, 0, 0);
    var_18 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_10, var_10.ref_13E92);
    var_19 = 6;
    iprintlnbold("Plane Shooting Debug: Shooting ON");

    for(;;) {
      if(isDefined(var_10.isteamvoplaying)) {
        var_10.origin = var_10.isteamvoplaying;
      }

      var_18 shootturret("tag_flash", var_19);
      wait var_17;

      if(!istrue(var_10.turn_on_steam)) {
        var_10.origin = var_10.isuseobject;
        var_10.angles = (0, 0, 0);
        iprintlnbold("Plane Shooting Debug: Shooting OFF");
        return;
      }
    }

    return;
  }
}