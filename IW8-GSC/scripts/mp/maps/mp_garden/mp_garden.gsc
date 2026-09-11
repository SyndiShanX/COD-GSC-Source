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
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread ref_1327b();
  thread spawn_carepackage();
  thread play_movie("mp_garden_tv");
  thread monitor();
  thread lb_pitch_roll_dmg_factor("policeCarWithLights", "policecarlgt", 0);
  thread lb_pitch_roll_dmg_factor("destructVan", "redvan", 1);
  scripts\mp\flags::levelflagwait("scriptables_ready");
  wait 10;
  scripts\engine\utility::array_thread(getscriptablearray("scriptable_veh8_civ_lnd_victor40_police_mp_piccadilly", "classname"), &ref_141bd);
}

function spawn_carepackage() {
  level waittill("infil_setup_complete");

  if(scripts\mp\flags::gameflag("infil_will_run")) {
    var0 = getEnt("infilCones", "targetname");
    var0 hide();
    return;
  }

  var1 = getEnt("infil_van_col", "targetname");

  if(isDefined(var1)) {
    var1 hide();
    return;
  }
}

function molotov_watch_cleanup_pool() {
  var0 = easepower("maphint_offering", level.ref_11fab.origin);
  waitframe();
  scripts\engine\scriptable::ref_12f5b("maphint_offering", &ref_11ae2);

  for(;;) {
    level waittill("OfferingPlaced");
    monitor_enemy_death();
    wait 20;
    var0 setscriptablepartstate("maphint_offering", "on");
  }
}

function monitor() {
  level.ref_11fab = scripts\engine\utility::getStruct("offeringLoc", "targetname");
  level.getrandomprematchequipment = getEnt("cheese", "targetname");
  level.getrandomprematchequipment hide();
  level.getridofkillstreakdeployweapon = getEnt("cheeseWedge", "targetname");
  level.getridofkillstreakdeployweapon.ref_1214a = level.getridofkillstreakdeployweapon.origin;
  level.getridofkillstreakdeployweapon.originalangles = level.getridofkillstreakdeployweapon.angles;
  level.getridofkillstreakdeployweapon hide();
  level.getrandomweaponfromgroup = scripts\engine\utility::getStructArray("cheeseLoc", "targetname");
  level.getrandomweaponfromgroup = scripts\engine\utility::array_randomize(level.getrandomweaponfromgroup);
  level.getrandomprematchequipment.origin = level.getrandomweaponfromgroup[0].origin;
  level.getrandomprematchequipment.angles = level.getrandomweaponfromgroup[0].angles;
  level.ref_11d7b = getEntArray("mouseTrap", "targetname");
  level.ref_11d7a = scripts\engine\utility::getStructArray("mouseTrapLoc", "targetname");

  foreach(var1 in level.ref_11d7a) {
    if(var1.origin == (362.93, -1485.9, 0)) {
      var1.origin = (358.93, -1465.9, 0);
    }
  }

  level.ref_11d7a = scripts\engine\utility::array_randomize(level.ref_11d7a);
  level.ref_11d7c = 0;
  var3 = 0;

  foreach(var5 in level.ref_11d7b) {
    var5.origin = level.ref_11d7a[var3].origin;
    var5.angles = level.ref_11d7a[var3].angles;
    var5.fx = scripts\engine\utility::spawn_tag_origin();
    var5.fx.origin = var5.origin;
    var5.fx.angles = var5.angles;
    var5.fx show();
    thread ref_11d7d(var5);
    var3++;
  }

  level.gesture_checker = getEntArray("candle", "targetname");
  level.gesture_checker = scripts\engine\utility::array_randomize(level.gesture_checker);

  foreach(var8 in level.gesture_checker) {
    var8.fx = scripts\engine\utility::spawn_tag_origin();
    var8.fx.origin = var8.origin;
    var8.fx.angles = var8.angles;
    var8.fx show();
    var8 hide();
  }

  while(level.ref_11d7c < 5) {
    level waittill("TrapFound");
  }

  level.getsafeoriginaroundpoint = easepower("maphint_cheese2", level.getridofkillstreakdeployweapon.origin + (0, 0, 6));
  waitframe();
  scripts\engine\scriptable::ref_12f5b("maphint_cheese2", &ref_11add);
  level waittill("CheeseWedgeTaken");
  level.getridofkillstreakdeployweapon hide();
  level.getrandomprematchequipment show();
  level.getrewardvaluetype = easepower("maphint_cheese", level.getrandomprematchequipment.origin + (0, 0, 6));
  waitframe();
  scripts\engine\scriptable::ref_12f5b("maphint_cheese", &ref_11ade);
  level waittill("CheeseTaken");
  level.getrandomprematchequipment hide();
  var10 = easepower("maphint_offering", level.ref_11fab.origin);
  waitframe();
  scripts\engine\scriptable::ref_12f5b("maphint_offering", &ref_11ae2);
  level waittill("OfferingPlaced");
  monitor_enemy_death();
}

function ref_11d7d(var0) {
  var0 setCanDamage(1);
  var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);
  var0 hide();
  level.ref_11d7c++;

  if(level.ref_11d7c < 5) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_trap"), var0.fx, "tag_origin");
    var0 playSound("mp_garden_pp_rat_trap");
  } else {
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_trap_final"), var0.fx, "tag_origin");
    var0 playSound("mp_garden_pp_rat_trap_final");
    level.getridofkillstreakdeployweapon.origin = var0.origin;
    level.getridofkillstreakdeployweapon.angles = var0.angles;
    waittillframeend();
    level.getridofkillstreakdeployweapon show();
  }

  level notify("TrapFound");
}

function monitor_enemy_death() {
  level.getrandomprematchequipment.origin = level.ref_11fab.origin;
  level.getrandomprematchequipment.angles = level.ref_11fab.angles;
  level.getridofkillstreakdeployweapon.origin = level.getridofkillstreakdeployweapon.ref_1214a;
  level.getridofkillstreakdeployweapon.angles = level.getridofkillstreakdeployweapon.originalangles;
  waittillframeend();
  level.getrandomprematchequipment show();
  wait 0.3;

  foreach(var1 in level.gesture_checker) {
    var1 show();
    waittillframeend();
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var1.fx, "tag_origin");
    wait 0.1;
  }

  level.getridofkillstreakdeployweapon show();
  wait 1;
  scripts\engine\utility::exploder("pied_piper");
  wait 15;
  level.getrandomprematchequipment hide();

  foreach(var1 in level.gesture_checker) {
    killfxontag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var1.fx, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_trap_final"), var1.fx, "tag_origin");
    wait 0.01;
    var1 hide();
  }
}

function ref_11ae2(var0, var1, var2, var3, var4) {
  thread allow_player_skip_laststand(level, var0, var1, var2, var3);
}

function allow_player_skip_laststand(var0, var1, var2, var3, var4) {
  if(var2 == "on") {
    var0 setscriptablepartstate("maphint_offering", "off");
    var3 playlocalsound("ui_interact_cheese");
    wait 0.3;
    level notify("OfferingPlaced");
    return;
  }
}

function ref_11ade(var0, var1, var2, var3, var4) {
  thread allow_player_basejumping(level, var0, var1, var2, var3);
}

function allow_player_basejumping(var0, var1, var2, var3, var4) {
  if(var2 == "on") {
    var0 setscriptablepartstate("maphint_cheese", "off");
    var3 playlocalsound("ui_interact_cheese_pickup");
    level notify("CheeseTaken");
    return;
  }
}

function ref_11add(var0, var1, var2, var3, var4) {
  thread allow_pickup_atmine(level, var0, var1, var2, var3);
}

function allow_pickup_atmine(var0, var1, var2, var3, var4) {
  if(var2 == "on") {
    var0 setscriptablepartstate("maphint_cheese2", "off");
    level notify("CheeseWedgeTaken");
    return;
  }
}

function play_movie(var0) {
  if(getdvarint("LLQQOPKTKM") == 1) {
    return;
  }

  for(;;) {
    playcinematicforalllooping(var0);
    wait 3;
  }
}

function ref_1327b() {
  wait 1;
  var0 = getEntArray("Train", "targetname");
  level.ref_13cd2 = 15;
  wait level.ref_13cd2;

  foreach(var2 in var0) {
    switch (var2.script_noteworthy) {
      case "front":
        playFXOnTag(level._effect["vfx_garden_train_headlight"], var2, "TAG_TRAIN_LIGHT_FRONT_4");
        playFXOnTag(level._effect["vfx_garden_train_headlight"], var2, "TAG_TRAIN_LIGHT_FRONT_2");
        break;
      case "mid":
        break;
      case "back":
        playFXOnTag(level._effect["vfx_garden_train_taillight"], var2, "TAG_TRAIN_LIGHT_FRONT_4");
        playFXOnTag(level._effect["vfx_garden_train_taillight"], var2, "TAG_TRAIN_LIGHT_FRONT_2");
        break;
      default:
        break;
    }

    thread ref_13cc9(var2);
    thread ref_13c96();
  }
}

function ref_13cc9(var0) {
  var1 = 0.00125;
  var2 = scripts\engine\utility::getStruct(var0.target, "targetname");

  for(var2 = scripts\engine\utility::getStruct(var2.target, "targetname");; var2 = scripts\engine\utility::getStruct(var2.target, "targetname")) {
    var3 = abs(distance(var0.origin, var2.origin) * var1);
    var0 moveTo(var2.origin, var3, 0, 0);

    if(isDefined(var0.script_noteworthy) && var0.script_noteworthy == "back") {
      var0 rotateTo(var2.angles + (0, 180, 0), var3, 0, 0);
    } else {
      var0 rotateTo(var2.angles, var3, 0, 0);
    }

    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
    wait var3;

    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "teleport") {
      var0.origin = var2.origin;

      if(isDefined(var0.script_noteworthy) && var0.script_noteworthy == "back") {
        var0.angles = var2.angles + (0, 180, 0);
      } else {
        var0.angles = var2.angles;
      }

      if(isDefined(var0.script_noteworthy) && var0.script_noteworthy == "front") {
        level.ref_13cd2 = randomint(30);
      }

      switch (var0.script_noteworthy) {
        case "front":
          killfxontag(level._effect["vfx_garden_train_headlight"], var0, "TAG_TRAIN_LIGHT_FRONT_4");
          killfxontag(level._effect["vfx_garden_train_headlight"], var0, "TAG_TRAIN_LIGHT_FRONT_2");
          break;
        case "mid":
          break;
        case "back":
          killfxontag(level._effect["vfx_garden_train_taillight"], var0, "TAG_TRAIN_LIGHT_FRONT_4");
          killfxontag(level._effect["vfx_garden_train_taillight"], var0, "TAG_TRAIN_LIGHT_FRONT_2");
          break;
        default:
          break;
      }

      wait level.ref_13cd2;

      switch (var0.script_noteworthy) {
        case "front":
          playFXOnTag(level._effect["vfx_garden_train_headlight"], var0, "TAG_TRAIN_LIGHT_FRONT_4");
          playFXOnTag(level._effect["vfx_garden_train_headlight"], var0, "TAG_TRAIN_LIGHT_FRONT_2");
          break;
        case "mid":
          break;
        case "back":
          playFXOnTag(level._effect["vfx_garden_train_taillight"], var0, "TAG_TRAIN_LIGHT_FRONT_4");
          playFXOnTag(level._effect["vfx_garden_train_taillight"], var0, "TAG_TRAIN_LIGHT_FRONT_2");
          break;
        default:
          break;
      }
    }
  }
}

function ref_141bd() {
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

function lb_pitch_roll_dmg_factor(var0, var1, var2) {
  level endon("game_ended");
  wait 10;
  var3 = getscriptablearray(var0, "targetname");
  var4 = getEntArray(var1, "targetname");

  if(var2) {
    var3[0].showintelscriptablestoplayer = scripts\engine\utility::spawn_tag_origin();
    var3[0].showintelscriptablestoplayer.origin = var3[0] gettagorigin("tag_light_front_right");
    var3[0].showintelscriptablestoplayer.angles = var3[0] gettagangles("tag_light_front_right");
    var3[0].showintelscriptablestoplayer show();
    var3[0].showintelscriptablestoplayer linkTo(var3[0], "tag_light_front_right");
    var3[0].showintelinstancetoplayer = scripts\engine\utility::spawn_tag_origin();
    var3[0].showintelinstancetoplayer.origin = var3[0] gettagorigin("tag_light_front_Left");
    var3[0].showintelinstancetoplayer.angles = var3[0] gettagangles("tag_light_front_Left");
    var3[0].showintelinstancetoplayer show();
    var3[0].showintelinstancetoplayer linkTo(var3[0], "tag_light_front_Left");
    var3[0].ref_13a29 = scripts\engine\utility::spawn_tag_origin();
    var3[0].ref_13a29.origin = var3[0] gettagorigin("tag_light_back_right");
    var3[0].ref_13a29.angles = var3[0] gettagangles("tag_light_back_right");
    var3[0].ref_13a29 show();
    var3[0].ref_13a29 linkTo(var3[0], "tag_light_back_right");
    var3[0].ref_13a28 = scripts\engine\utility::spawn_tag_origin();
    var3[0].ref_13a28.origin = var3[0] gettagorigin("tag_light_back_Left");
    var3[0].ref_13a28.angles = var3[0] gettagangles("tag_light_back_Left");
    var3[0].ref_13a28 show();
    var3[0].ref_13a28 linkTo(var3[0], "tag_light_back_Left");
    waitframe();
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_right"), var3[0].showintelscriptablestoplayer, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_left"), var3[0].showintelinstancetoplayer, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_right"), var3[0].ref_13a29, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_left"), var3[0].ref_13a28, "tag_origin");
  }

  if(isDefined(var3) && isDefined(var3[0])) {
    var5 = var3[0];
    var6 = 1;

    while(var6) {
      var5 waittill("scriptableNotification", var7, var8);

      switch (var7) {
        case "onfire":
        case "flareup":
        case "vehicle_death":
          trucklightsoff(var4);

          if(var2) {
            killfxontag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_right"), var3[0].showintelscriptablestoplayer, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_left"), var3[0].showintelinstancetoplayer, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_right"), var3[0].ref_13a29, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_left"), var3[0].ref_13a28, "tag_origin");
          }

          var6 = 0;
          return;
        case "anim_explosion":
          trucklightsoff(var4);

          if(var2) {
            killfxontag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_right"), var3[0].showintelscriptablestoplayer, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_headlight_lensflare_left"), var3[0].showintelinstancetoplayer, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_right"), var3[0].ref_13a29, "tag_origin");
            killfxontag(scripts\engine\utility::getfx("vfx_garden_taillight_lensflare_left"), var3[0].ref_13a28, "tag_origin");
          }

          var6 = 0;
          return;
      }
    }

    return;
  }
}

function trucklightsoff(var0) {
  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }
}

function ref_13c96() {
  var0 = spawn("script_origin", self.origin);
  var0 endon("death");
  thread scripts\engine\utility::delete_on_death(var0);
  var1 = "";

  switch (self.script_noteworthy) {
    case "front":
      var1 = "mp_garden_passby_long_front";
      break;
    case "mid":
      var1 = "mp_garden_passby_long_middle";
      break;
    case "back":
      var1 = "mp_garden_passby_long_back";
      break;
    default:
      break;
  }

  switch (self.script_noteworthy) {
    case "back":
    case "front":
      var0 linkTo(self, "TAG_TRAIN_LIGHT_FRONT_4");
      break;
    default:
      var0 linkTo(self);
      break;
  }

  wait 0.05;
  var0 playLoopSound(var1);
  var0 waittill("stop sound" + var1);
  var0 stoploopsound(var1);
  var0 delete();
}