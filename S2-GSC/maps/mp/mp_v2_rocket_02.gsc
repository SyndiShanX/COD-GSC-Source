/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_v2_rocket_02.gsc
*********************************************/

func_00F9() {
  maps\mp\mp_v2_rocket_02_precache::main();
  maps\createart\mp_v2_rocket_02_art::main();
  maps\mp\mp_v2_rocket_02_fx::main();
  maps\mp\_load::main();
  maps\mp\mp_v2_rocket_02_lighting::main();
  maps\mp\mp_v2_rocket_02_aud::main();
  maps\mp\_compass::func_8A2F("compass_map_mp_v2_rocket_02");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_6C5F = "mp_v2_rocket_02_osp";
  level.var_6C5E = "mp_v2_rocket_02_osp";
  level.var_3445 = "mp_v2_rocket_02_drone";
  level.var_343A = "mp_v2_rocket_02_drone";
  level.var_A853 = "mp_v2_rocket_02_warbird";
  level.var_A852 = "mp_v2_rocket_02_warbird";
  level.var_6C5F = "mp_v2_rocket_01_osp";
  level.var_6C5E = "mp_v2_rocket_01_osp";
  level.var_3445 = "mp_v2_rocket_01_drone";
  level.var_343A = "mp_v2_rocket_01_drone";
  level.var_A853 = "mp_v2_rocket_01_warbird";
  level.var_A852 = "mp_v2_rocket_01_warbird";
  level.var_5A7C = "mp_v2_rocket_02_killstreak";
  level.var_5A6B = "mp_v2_rocket_02_killstreak";
  level.var_47CD = "mp_v2_rocket_02_glide1";
  level.var_47CE = "mp_v2_rocket_02_glide2";
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  level.var_A4BE["intensity"] = 0.5;
  level.var_A4BE["falloff"] = 1.2;
  level.var_A4BE["scaleX"] = 1;
  level.var_A4BE["scaleY"] = 1;
  level.var_A4BE["squareAspectRatio"] = 0;
  level.var_A4BE["lerpDuration"] = 0.4;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  thread animate_tanks();
  thread animate_trucks();
  thread deletepostshipents();
  level.alarmarray = getEntArray("alarm_red", "targetname");
  if(level.gametype != "prop") {
    thread rocketengine();
  }

  if(isDefined(level.alarmarray)) {
    thread hidealarmmeshes();
  }

  level waittill("matchStartTimer");
  activateclientexploder(4);
  setDvar("5800", 3);
  thread alarm_off();
}

deletepostshipents() {
  wait(1);
  var_00 = 0;
  var_01 = 3;
  var_02 = getEntArray("script_model", "classname");
  var_02 = common_scripts\utility::array_randomize(var_02);
  foreach(var_04 in var_02) {
    if(isDefined(var_04.model) && isstring(var_04.model)) {
      if(var_04.model == "mp_lase2_dyn_chain_quater" || var_04.model == "v2_rocket_windsock_01") {
        var_00++;
        if(var_00 == var_01) {
          var_00 = 0;
          continue;
        }

        var_04 delete();
      }
    }
  }

  var_06 = getEntArray("script_brushmodel", "classname");
  foreach(var_08 in var_06) {
    if(isDefined(var_08.targetname) && isstring(var_08.targetname)) {
      if(issubstr(var_08.targetname, "patchclip_player_")) {
        var_08 delete();
      }
    }
  }
}

animate_tanks() {
  var_00 = getEntArray("tank_scripted_node", "targetname");
  foreach(var_02 in var_00) {
    var_03 = spawn("script_model", var_02.origin);
    var_03 setModel("rkt_tank_oxygen_rig");
    var_03 method_8495("rkt_convoy_tank_anim", var_02.origin, var_02.var_1D);
    wait(20);
  }
}

animate_trucks() {
  var_00 = getEntArray("truck_scripted_node", "targetname");
  foreach(var_02 in var_00) {
    var_03 = spawn("script_model", var_02.origin);
    var_03 setModel("vehicle_ger_trans_opel_blitz");
    var_03 method_8495("rkt_convoy_truck_anim", var_02.origin, var_02.var_1D);
    var_03 lib_0378::func_8D74("aud_mp_rocket_facility_truck_drive");
    wait(20);
  }
}

setuprocketkillcament() {
  var_00 = spawn("script_model", (0, 0, 0));
  var_00 setModel("tag_origin");
  var_00.origin = (-669, 762, 487);
  var_00.var_1D = (7.76, 0, 0);
  var_00 setscriptmoverkillcam("script_entity");
  self.var_5A2C = var_00;
}

rocketengine() {
  level endon("game_ended");
  var_00 = 0.5;
  var_01 = 5;
  var_02 = 10;
  var_03 = 120;
  var_04 = getEnt("rocket_engine_trigger", "targetname");
  var_04.var_6C4E = var_04.origin;
  var_04 method_808C();
  var_04.origin = var_04.origin + (0, 0, -5000);
  var_04.damage_on = 0;
  var_05 = getEnt("rocket_button", "targetname");
  var_05 makeusable();
  var_05 setHintString(&"MAP_DLC2_V2_START_ENGINE");
  var_06 = common_scripts\utility::func_46B5("button_blink", "targetname");
  var_05 setuprocketkillcament();
  var_07 = common_scripts\utility::func_46B7("rocket_smoke", "targetname");
  var_08 = common_scripts\utility::func_46B5("rocket_engine_fx", "targetname");
  var_09 = loadfx("vfx/map/mp_v2_rocket/mp_v2_engineFire_01");
  var_0A = loadfx("vfx/map/mp_v2_rocket/mp_v2_engineSmoke_01");
  var_0B = loadfx("vfx/lights/aircraft_light_red_blink_large");
  var_0C = loadfx("vfx/map/mp_v2_rocket/mp_v2_light_blink_green");
  wait(1);
  var_0D = spawnfx(var_0C, var_06.origin);
  triggerfx(var_0D);
  for(;;) {
    var_05 waittill("trigger", var_0E);
    var_05 makeunusable();
    var_0D delete();
    var_0F = spawnfx(var_0B, var_06.origin);
    triggerfx(var_0F);
    if(isDefined(level.alarmarray)) {
      thread alarm_flash(var_01);
    }

    lib_0378::func_8D74("aud_v2_rocket_siren_start", var_08.origin);
    lib_0378::func_8D74("aud_v2_rocket_engine_fire_start");
    wait(var_01 - var_00);
    var_05.var_5A2C.var_5A32 = gettime();
    wait(var_00);
    var_04 method_808C();
    var_04.origin = var_04.var_6C4E;
    var_04.damage_on = 1;
    thread triggerdamage(var_04, var_0E, var_05);
    var_10 = spawnfx(var_09, var_08.origin, anglesToForward(var_08.var_1D) * -1, anglestoup(var_08.var_1D) * -1);
    triggerfx(var_10);
    var_10 thread smokethink(var_02);
    foreach(var_12 in var_07) {
      var_13 = spawnfx(var_0A, var_12.origin, anglesToForward(var_12.var_1D), anglestoup(var_12.var_1D));
      triggerfx(var_13);
      var_13 thread smokethink(var_02);
    }

    wait(var_02);
    var_04.damage_on = 0;
    var_04.origin = var_04.origin + (0, 0, -5000);
    wait(var_03 - var_02 - var_01);
    var_0F delete();
    var_0D = spawnfx(var_0C, var_06.origin);
    triggerfx(var_0D);
    var_05 makeusable();
  }
}

hidealarmmeshes() {
  foreach(var_01 in level.alarmarray) {
    var_01.light_mesh = getEnt(var_01.target, "targetname");
    if(isDefined(var_01.light_mesh)) {
      var_01.light_mesh linkTo(var_01);
      var_01.light_mesh save_undo_buffer();
    }
  }
}

alarm_flash(param_00) {
  var_01 = function_021F("alarm_flash", "targetname");
  if(!isDefined(var_01)) {
    return;
  }

  foreach(var_03 in var_01) {
    var_03 setscriptablepartstate("lightpart", "on");
    while(param_00 > 0) {
      var_03 setscriptablepartstate("lightpart", "on");
      wait(0.45);
      var_03 setscriptablepartstate("lightpart", "off");
      wait(1);
      param_00 = param_00 - 1;
    }

    thread alarm_off();
  }
}

alarm_off() {
  var_00 = function_021F("alarm_flash", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "off");
  }
}

triggerdamage(param_00, param_01, param_02) {
  while(param_00.damage_on == 1) {
    foreach(var_04 in level.players) {
      if(isDefined(var_04) && isalive(var_04)) {
        if(var_04 istouching(param_00)) {
          if(var_04.team == param_01.team && var_04 != param_01) {
            var_04 dodamage(17, var_04.origin, undefined, param_02, "MOD_BURNED");
            continue;
          }

          var_04 dodamage(17, var_04.origin, param_01, param_02, "MOD_BURNED");
        }
      }
    }

    wait(0.25);
  }
}

smokethink(param_00) {
  wait(param_00);
  self delete();
}

setup_fire_lighting() {
  thread maps\mp\_utility::func_5C98("rocket_fire_light_01", 1, 20000);
  thread maps\mp\_utility::func_5C98("rocket_fire_light_02", 1, 20000);
  thread maps\mp\_utility::func_5C98("rocket_fire_light_03", 1, 150000);
  wait(16);
  thread maps\mp\_utility::func_5C98("rocket_fire_light_01", 1, 0);
  thread maps\mp\_utility::func_5C98("rocket_fire_light_02", 1, 0);
  thread maps\mp\_utility::func_5C98("rocket_fire_light_03", 1, 0);
}