/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\nuke_mp.gsc
***********************************************/

function ref_13fd1() {
  var0 = getDvar("scr_moveVehicle", "");

  if(var0 != "") {
    var1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var1)) {
      thread level_death_notify(var1);
    }
  }

  var2 = getDvar("scr_planeContrails", "");

  if(var2 != "") {
    var1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var1)) {
      thread ref_123aa(var1);
    }
  }

  var3 = getDvar("scr_dropBomberBomb", "");

  if(var3 != "") {
    var1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var1)) {
      thread minplunderdropondeath(var1);
    }
  }

  var4 = getDvar("scr_airplaneAutoShoot", "");

  if(var4 != "") {
    var1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var1)) {
      thread br_laststandfinishplayerisincapacitated(var1);
    }
  }

  var5 = getDvar("scr_runFTD", "");

  if(var5 != "") {
    level thread scripts\mp\gametypes\ftd::left_side_spawn_adjuster(var5);
    return;
  }
}

function level_death_notify(var0) {
  var1 = self;
  level endon("game_ended");

  if(!isDefined(var0)) {
    iprintlnbold("scr_brdev move_vehicle needs a parameter. Example: ground");
  }

  var2 = var1.origin;
  var3 = var1 getplayerangles();
  var4 = anglesToForward(var3);
  var5 = (var2[0], var2[1], var2[2] + var1 getplayerviewheight());
  var6 = var5 + var4 * 5000;
  var7 = scripts\engine\trace::create_default_contents(0);
  var8 = scripts\engine\trace::ray_trace(var5, var6, var1, var7);

  switch (var0) {
    case "air":
      var9 = (0, 0, 200);
      break;
    case "ground":
      var9 = (0, 0, 0);
      break;
    default:
      iprintlnbold("Invalid move_vehicle parameter");
      return;
  }

  var10 = var9["entity"];

  if(!isDefined(var10)) {
    var11 = undefined;
    var12 = 9000;

    foreach(var14 in level.vehicle.instances) {
      foreach(var10 in var14) {
        var16 = distance(var10.origin, var2.origin);

        if(var16 == 0 || var16 < var12) {
          var12 = var16;
          var11 = var10;
        }
      }
    }

    var10 = var11;

    if(!isDefined(var10)) {
      iprintlnbold("No valid vehicle to move was found.");
      return;
    }
  }

  var19 = var10.origin;
  var20 = var10.angles;
  var21 = 10;
  var22 = 0;

  if(!isDefined(var10)) {
    return;
  }

  iprintlnbold("Vehicle Moving Debug: Moving ON");
  wait 1;

  if(var10 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var10.origin += var9;
    var10 vehicle_turnengineon();
    var10 vehicle_setspeed(10, 1, 1);

    while(var22 < var21) {
      var22++;
      wait 1;

      if(!isDefined(var10)) {
        return;
      }
    }

    var10 vehicle_setspeed(0, 0, 20);
    var10 vehicle_turnengineoff();
    wait 0.3;

    if(!isDefined(var10)) {
      return;
    }

    var10.origin = var19;
    var10.angles = var20;
    return;
  }
}

function ref_123aa(var0) {
  var1 = self;
  var2 = var1.origin;
  var3 = var1 getplayerangles();
  var4 = anglesToForward(var3);
  var5 = (var2[0], var2[1], var2[2] + var1 getplayerviewheight());
  var6 = var5 + var4 * 5000;
  var7 = scripts\engine\trace::create_default_contents(0);
  var8 = scripts\engine\trace::ray_trace(var5, var6, var1, var7);
  var9 = var8["entity"];
  var10 = scripts\engine\utility::array_combine(level.vehicle.instances["veh_a10fd"], level.vehicle.instances["veh_bt"]);

  if(!isDefined(var9)) {
    var11 = undefined;
    var12 = 9000;

    foreach(var9 in var10) {
      var14 = distance(var9.origin, var1.origin);

      if(var14 == 0 || var14 < var12) {
        var12 = var14;
        var11 = var9;
      }
    }

    var9 = var11;

    if(!isDefined(var9)) {
      iprintlnbold("No valid vehicle to move was found.");
      return;
    }
  }

  if(!isDefined(var9 getscriptablepartstate("fx", 1))) {
    iprintlnbold("Vehicle does not have fx scriptable part state.");
    return;
  }

  if(!isDefined(var9.hours)) {
    var9.hours = 0;
  }

  if(var9.hours) {
    iprintlnbold("Plane Debug: Contrails Off");
    var9.hours = 0;
    var9 setscriptablepartstate("fx", "base", 0);
    return;
  }

  var9 notify("vehicle_contrails_debug");
  iprintlnbold("Plane Debug: Contrails On");
  var9.hours = 1;
  var9 setscriptablepartstate("fx", "trails", 0);
}

function minplunderdropondeath(var0) {
  var1 = self;
  var2 = strtok(var0, ",");
  var3 = int(var2[0]);
  var4 = int(var2[1]);
  var5 = int(var2[2]);

  if(!isDefined(var3) || !isDefined(var4) || !isDefined(var5)) {
    iprintlnbold("Invalid bomb test: specify distance, height, wait seconds");
    return;
  }

  var6 = anglesToForward(var1.angles);
  var7 = var1.origin + var6 * var3 + (0, 0, int(var4));
  iprintlnbold("Drop Bomb Debug: Bomb incoming!");
  wait var5;
  _calloutmarkerping_handleluinotify_mappingdeletemarker::crushing_players(var7);
}

function br_laststandfinishplayerisincapacitated(var0) {
  var1 = self;
  var2 = int(var0);

  if(!isDefined(var2)) {
    iprintlnbold("AirplaneAutoShoot debug function requires height parameter. Example: 500");
    return;
  }

  var3 = var1.origin;
  var4 = var1 getplayerangles();
  var5 = anglesToForward(var4);
  var6 = (var3[0], var3[1], var3[2] + var1 getplayerviewheight());
  var7 = var6 + var5 * 5000;
  var8 = scripts\engine\trace::create_default_contents(0);
  var9 = scripts\engine\trace::ray_trace(var6, var7, var1, var8);
  var10 = var9["entity"];
  var11 = scripts\engine\utility::array_combine(level.vehicle.instances["veh_a10fd"]);

  if(!isDefined(var10)) {
    var12 = undefined;
    var13 = 9000;

    foreach(var10 in var11) {
      var15 = distance(var10.origin, var1.origin);

      if(var15 == 0 || var15 < var13) {
        var13 = var15;
        var12 = var10;
      }
    }

    var10 = var12;

    if(!isDefined(var10)) {
      iprintlnbold("No valid vehicle to move was found.");
      return;
    }
  }

  if(!isDefined(var10)) {
    return;
  }

  if(istrue(var10.turn_on_steam)) {
    var10.turn_on_steam = 0;
  } else {
    var10.turn_on_steam = 1;
    var10.isuseobject = var10.origin;
    var10.isteamvoplaying = var10.origin + (0, 0, var2);
  }

  var17 = 0.2;

  if(isDefined(level.picking_up_minigun)) {
    var17 = level.picking_up_minigun;
  }

  if(var10 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var10.angles = (90, 0, 0);
    var18 = scripts\cp_mp\vehicles\vehicle::ref_14192(var10, var10.ref_13e92);
    var19 = 6;
    iprintlnbold("Plane Shooting Debug: Shooting ON");

    for(;;) {
      if(isDefined(var10.isteamvoplaying)) {
        var10.origin = var10.isteamvoplaying;
      }

      var18 shootturret("tag_flash", var19);
      wait var17;

      if(!istrue(var10.turn_on_steam)) {
        var10.origin = var10.isuseobject;
        var10.angles = (0, 0, 0);
        iprintlnbold("Plane Shooting Debug: Shooting OFF");
        return;
      }
    }

    return;
  }
}