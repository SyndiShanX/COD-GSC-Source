/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_garden\mp_garden.gsc
***************************************************/

function main() {
  scripts\mp\maps\mp_garden\mp_garden_precache::main();
  scripts\mp\maps\mp_garden\gen\mp_garden_art::main();
  scripts\mp\maps\mp_garden\mp_garden_fx::main();
  scripts\mp\maps\mp_garden\mp_garden_lighting::main();
  scripts\mp\load::main();
  level.music_style = "england";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_garden", "codcaster_compass_map_mp_garden");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread ref_1327B();
  thread spawn_carepackage();
  thread play_movie("mp_garden_tv");
  thread monitor();
  thread lb_pitch_roll_dmg_factor("policeCarWithLights", "policecarlgt", 0);
  thread lb_pitch_roll_dmg_factor("destructVan", "redvan", 1);
  scripts\mp\flags::levelflagwait("scriptables_ready");
  wait 10;
  scripts\engine\utility::array_thread(getscriptablearray("scriptable_veh8_civ_lnd_victor40_police_mp_piccadilly", "classname"), &ref_141BD);
}

function spawn_carepackage() {
  level waittill("infil_setup_complete");

  if(scripts\mp\flags::gameflag("infil_will_run")) {
    var_0 = getEnt("infilCones", "targetname");
    var_0 hide();
    return;
  }

  var_1 = getEnt("infil_van_col", "targetname");

  if(isDefined(var_1)) {
    var_1 hide();
    return;
  }
}

function molotov_watch_cleanup_pool() {
  var_0 = easepower("maphint_offering", level.ref_11FAB.origin);
  waitframe();
  scripts\engine\scriptable::ref_12F5B("maphint_offering", &ref_11AE2);

  for(;;) {
    level waittill("OfferingPlaced");
    monitor_enemy_death();
    wait 20;
    var_0 setscriptablepartstate("maphint_offering", "on");
  }
}

function monitor() {
  level.ref_11FAB = scripts\engine\utility::getStruct("offeringLoc", "targetname");
  level.getrandomprematchequipment = getEnt("cheese", "targetname");
  level.getrandomprematchequipment hide();
  level.getridofkillstreakdeployweapon = getEnt("cheeseWedge", "targetname");
  level.getridofkillstreakdeployweapon.ref_1214A = level.getridofkillstreakdeployweapon.origin;
  level.getridofkillstreakdeployweapon.originalangles = level.getridofkillstreakdeployweapon.angles;
  level.getridofkillstreakdeployweapon hide();
  level.getrandomweaponfromgroup = scripts\engine\utility::getStructArray("cheeseLoc", "targetname");
  level.getrandomweaponfromgroup = scripts\engine\utility::array_randomize(level.getrandomweaponfromgroup);
  level.getrandomprematchequipment.origin = level.getrandomweaponfromgroup[0].origin;
  level.getrandomprematchequipment.angles = level.getrandomweaponfromgroup[0].angles;
  level.ref_11D7B = getEntArray("mouseTrap", "targetname");
  level.ref_11D7A = scripts\engine\utility::getStructArray("mouseTrapLoc", "targetname");

  foreach(var_1 in level.ref_11D7A) {
    if(var_1.origin == (362.93, -1485.9, 0)) {
      var_1.origin = (358.93, -1465.9, 0);
    }
  }

  level.ref_11D7A = scripts\engine\utility::array_randomize(level.ref_11D7A);
  level.ref_11D7C = 0;
  var_3 = 0;

  foreach(var_5 in level.ref_11D7B) {
    var_5.origin = level.ref_11D7A[var_3].origin;
    var_5.angles = level.ref_11D7A[var_3].angles;
    var_5.fx = scripts\engine\utility::spawn_tag_origin();
    var_5.fx.origin = var_5.origin;
    var_5.fx.angles = var_5.angles;
    var_5.fx show();
    thread ref_11D7D(var_5);
    var_3++;
  }

  level.gesture_checker = getEntArray("candle", "targetname");
  level.gesture_checker = scripts\engine\utility::array_randomize(level.gesture_checker);

  foreach(var_8 in level.gesture_checker) {
    var_8.fx = scripts\engine\utility::spawn_tag_origin();
    var_8.fx.origin = var_8.origin;
    var_8.fx.angles = var_8.angles;
    var_8.fx show();
    var_8 hide();
  }

  while(level.ref_11D7C < 5) {
    level waittill("TrapFound");
  }

  level.getsafeoriginaroundpoint = easepower("maphint_cheese2", level.getridofkillstreakdeployweapon.origin + (0, 0, 6));
  waitframe();
  scripts\engine\scriptable::ref_12F5B("maphint_cheese2", &ref_11ADD);
  level waittill("CheeseWedgeTaken");
  level.getridofkillstreakdeployweapon hide();
  level.getrandomprematchequipment show();
  level.getrewardvaluetype = easepower("maphint_cheese", level.getrandomprematchequipment.origin + (0, 0, 6));
  waitframe();
  scripts\engine\scriptable::ref_12F5B("maphint_cheese", &ref_11ADE);
  level waittill("CheeseTaken");
  level.getrandomprematchequipment hide();
  var_10 = easepower("maphint_offering", level.ref_11FAB.origin);
  waitframe();
  scripts\engine\scriptable::ref_12F5B("maphint_offering", &ref_11AE2);
  level waittill("OfferingPlaced");
  monitor_enemy_death();
}

function ref_11D7D(var_0) {
  var_0 setCanDamage(1);
  var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
  var_0 hide();
  level.ref_11D7C++;

  if(level.ref_11D7C < 5) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_trap"), var_0.fx, "tag_origin");
    var_0 playSound("mp_garden_pp_rat_trap");
  } else {
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_trap_final"), var_0.fx, "tag_origin");
    var_0 playSound("mp_garden_pp_rat_trap_final");
    level.getridofkillstreakdeployweapon.origin = var_0.origin;
    level.getridofkillstreakdeployweapon.angles = var_0.angles;
    waittillframeend();
    level.getridofkillstreakdeployweapon show();
  }

  level notify("TrapFound");
}

function monitor_enemy_death() {
  level.getrandomprematchequipment.origin = level.ref_11FAB.origin;
  level.getrandomprematchequipment.angles = level.ref_11FAB.angles;
  level.getridofkillstreakdeployweapon.origin = level.getridofkillstreakdeployweapon.ref_1214A;
  level.getridofkillstreakdeployweapon.angles = level.getridofkillstreakdeployweapon.originalangles;
  waittillframeend();
  level.getrandomprematchequipment show();
  wait 0.3;

  foreach(var_1 in level.gesture_checker) {
    var_1 show();
    waittillframeend();
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var_1.fx, "tag_origin");
    wait 0.1;
  }

  level.getridofkillstreakdeployweapon show();
  wait 1;
  scripts\engine\utility::exploder("pied_piper");
  wait 15;
  level.getrandomprematchequipment hide();

  foreach(var_1 in level.gesture_checker) {
    killfxontag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var_1.fx, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_trap_final"), var_1.fx, "tag_origin");
    wait 0.01;
    var_1 hide();
  }
}

function ref_11AE2(var_0, var_1, var_2, var_3, var_4) {
  thread allow_player_skip_laststand(level, var_0, var_1, var_2, var_3);
}

function allow_player_skip_laststand(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "on") {
    var_0 setscriptablepartstate("maphint_offering", "off");
    var_3 playlocalsound("ui_interact_cheese");
    wait 0.3;
    level notify("OfferingPlaced");
    return;
  }
}

function ref_11ADE(var_0, var_1, var_2, var_3, var_4) {
  thread allow_player_basejumping(level, var_0, var_1, var_2, var_3);
}

function allow_player_basejumping(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "on") {
    var_0 setscriptablepartstate("maphint_cheese", "off");
    var_3 playlocalsound("ui_interact_cheese_pickup");
    level notify("CheeseTaken");
    return;
  }
}

function ref_11ADD(var_0, var_1, var_2, var_3, var_4) {
  thread allow_pickup_atmine(level, var_0, var_1, var_2, var_3);
}

function allow_pickup_atmine(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "on") {
    var_0 setscriptablepartstate("maphint_cheese2", "off");
    level notify("CheeseWedgeTaken");
    return;
  }
}

function play_movie(var_0) {
  if(getdvarint("r_reflectionProbeGenerate") == 1) {
    return;
  }

  for(;;) {
    playcinematicforalllooping(var_0);
    wait 3;
  }
}

function ref_1327B() {
  wait 1;
  var_0 = getEntArray("Train", "targetname");
  level.ref_13CD2 = 15;
  wait level.ref_13CD2;

  foreach(var_2 in var_0) {
    switch (var_2.script_noteworthy) {
      case "front":
        playFXOnTag(level._effect["vfx_garden_train_headlight"], var_2, "TAG_TRAIN_LIGHT_FRONT_4");
        playFXOnTag(level._effect["vfx_garden_train_headlight"], var_2, "TAG_TRAIN_LIGHT_FRONT_2");
        break;
      case "mid":
        break;
      case "back":
        playFXOnTag(level._effect["vfx_garden_train_taillight"], var_2, "TAG_TRAIN_LIGHT_FRONT_4");
        playFXOnTag(level._effect["vfx_garden_train_taillight"], var_2, "TAG_TRAIN_LIGHT_FRONT_2");
        break;
      default:
        break;
    }

    thread ref_13CC9(var_2);
    thread ref_13C96();
  }
}

function ref_13CC9(var_0) {
  var_1 = 0.00125;
  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");

  for(var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");; var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname")) {
    var_3 = abs(distance(var_0.origin, var_2.origin) * var_1);
    var_0 moveTo(var_2.origin, var_3, 0, 0);

    if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "back") {
      var_0 rotateTo(var_2.angles + (0, 180, 0), var_3, 0, 0);
    } else {
      var_0 rotateTo(var_2.angles, var_3, 0, 0);
    }

    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    wait var_3;

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "teleport") {
      var_0.origin = var_2.origin;

      if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "back") {
        var_0.angles = var_2.angles + (0, 180, 0);
      } else {
        var_0.angles = var_2.angles;
      }

      if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "front") {
        level.ref_13CD2 = randomint(30);
      }

      switch (var_0.script_noteworthy) {
        case "front":
          killfxontag(level._effect["vfx_garden_train_headlight"], var_0, "TAG_TRAIN_LIGHT_FRONT_4");
          killfxontag(level._effect["vfx_garden_train_headlight"], var_0, "TAG_TRAIN_LIGHT_FRONT_2");
          break;
        case "mid":
          break;
        case "back":
          killfxontag(level._effect["vfx_garden_train_taillight"], var_0, "TAG_TRAIN_LIGHT_FRONT_4");
          killfxontag(level._effect["vfx_garden_train_taillight"], var_0, "TAG_TRAIN_LIGHT_FRONT_2");
          break;
        default:
          break;
      }

      wait level.ref_13CD2;

      switch (var_0.script_noteworthy) {
        case "front":
          playFXOnTag(level._effect["vfx_garden_train_headlight"], var_0, "TAG_TRAIN_LIGHT_FRONT_4");
          playFXOnTag(level._effect["vfx_garden_train_headlight"], var_0, "TAG_TRAIN_LIGHT_FRONT_2");
          break;
        case "mid":
          break;
        case "back":
          playFXOnTag(level._effect["vfx_garden_train_taillight"], var_0, "TAG_TRAIN_LIGHT_FRONT_4");
          playFXOnTag(level._effect["vfx_garden_train_taillight"], var_0, "TAG_TRAIN_LIGHT_FRONT_2");
          break;
        default:
          break;
      }
    }
  }
}

function ref_141BD() {
  level endon("game_ended");
  wait randomfloat(2);

  if(self getscriptablehaspart("lights_controller")) {
    if(self getscriptableparthasstate("lights_controller", "siren_off")) {
      self setscriptablepartstate("lights_controller", "siren_off");
    }
  }

  self.wire_think = scripts\engine\utility::spawn_tag_origin();
  self.wire_think.origin = self gettagorigin("tag_body_animate");
  self.wire_think.angles = self gettagangles("tag_body_animate");
  self.wire_think show();
  self.wire_think linkTo(self, "tag_body_animate");
  waitframe();

  if(self.classname == "scriptable_veh8_civ_lnd_victor40_police_mp_piccadilly") {
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_police_lights"), self.wire_think, "tag_origin");
    goto LOC_000000b2;
  }

  return;
}

function lb_pitch_roll_dmg_factor(var_0, var_1, var_2) {
  level endon("game_ended");
  wait 10;
  var_3 = getscriptablearray(var_0, "targetname");
  var_4 = getEntArray(var_1, "targetname");

  if(var_2) {
    var_3[0].showintelscriptablestoplayer = scripts\engine\utility::spawn_tag_origin();
    var_3[0].showintelscriptablestoplayer.origin = var_3[0] gettagorigin("tag_light_front_right");
    var_3[0].showintelscriptablestoplayer.angles = var_3[0] gettagangles("tag_light_front_right");
    var_3[0].showintelscriptablestoplayer show();
    var_3[0].showintelscriptablestoplayer linkTo(var_3[0], "tag_light_front_right");
    var_3[0].showintelinstancetoplayer = scripts\engine\utility::spawn_tag_origin();
    var_3[0].showintelinstancetoplayer.origin = var_3[0] gettagorigin("tag_light_front_Left");
    var_3[0].showintelinstancetoplayer.angles = var_3[0] gettagangles("tag_light_front_Left");
    var_3[0].showintelinstancetoplayer show();
    var_3[0].showintelinstancetoplayer linkTo(var_3[0], "tag_light_front_Left");
    var_3[0].ref_13A29 = scripts\engine\utility::spawn_tag_origin();
    var_3[0].ref_13A29.origin = var_3[0] gettagorigin("tag_light_back_right");
    var_3[0].ref_13A29.angles = var_3[0] gettagangles("tag_light_back_right");
    var_3[0].ref_13A29 show();
    var_3[0].ref_13A29 linkTo(var_3[0], "tag_light_back_right");
    var_3[0].ref_13A28 = scripts\engine\utility::spawn_tag_origin();
    var_3[0].ref_13A28.origin = var_3[0] gettagorigin("tag_light_back_Left");
    var_3[0].ref_13A28.angles = var_3[0] gettagangles("tag_light_back_Left");
    var_3[0].ref_13A28 show();
    var_3[0].ref_13A28 linkTo(var_3[0], "tag_light_back_Left");
    waitframe();
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_right"), var_3[0].showintelscriptablestoplayer, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_left"), var_3[0].showintelinstancetoplayer, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_right"), var_3[0].ref_13A29, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_left"), var_3[0].ref_13A28, "tag_origin");
  }

  if(isDefined(var_3) && isDefined(var_3[0])) {
    var_5 = var_3[0];
    var_6 = 1;

    while(var_6) {
      var_5 waittill("scriptableNotification", var_7, var_8);

      switch (var_7) {
        case "onfire":
        case "flareup":
        case "vehicle_death":
          trucklightsoff(var_4);

          if(var_2) {
            killfxontag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_right"), var_3[0].showintelscriptablestoplayer, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_left"), var_3[0].showintelinstancetoplayer, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_right"), var_3[0].ref_13A29, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_left"), var_3[0].ref_13A28, "tag_origin");
          }

          var_6 = 0;
          return;
        case "anim_explosion":
          trucklightsoff(var_4);

          if(var_2) {
            killfxontag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_right"), var_3[0].showintelscriptablestoplayer, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_left"), var_3[0].showintelinstancetoplayer, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_right"), var_3[0].ref_13A29, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_left"), var_3[0].ref_13A28, "tag_origin");
          }

          var_6 = 0;
          return;
      }
    }

    return;
  }
}

function trucklightsoff(var_0) {
  foreach(var_2 in var_0) {
    var_2 setlightintensity(0);
  }
}

function ref_13C96() {
  var_0 = spawn("script_origin", self.origin);
  var_0 endon("death");
  thread scripts\engine\utility::delete_on_death(var_0);
  var_1 = "";

  switch (self.script_noteworthy) {
    case "front":
      var_1 = "mp_garden_passby_long_front";
      break;
    case "mid":
      var_1 = "mp_garden_passby_long_middle";
      break;
    case "back":
      var_1 = "mp_garden_passby_long_back";
      break;
    default:
      break;
  }

  switch (self.script_noteworthy) {
    case "back":
    case "front":
      var_0 linkTo(self, "TAG_TRAIN_LIGHT_FRONT_4");
      break;
    default:
      var_0 linkTo(self);
      break;
  }

  wait 0.05;
  var_0 playLoopSound(var_1);
  var_0 waittill("stop sound" + var_1);
  var_0 stoploopsound(var_1);
  var_0 delete();
}