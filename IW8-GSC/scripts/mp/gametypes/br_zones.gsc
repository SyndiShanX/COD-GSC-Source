/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_zones.gsc
***********************************************/

function init() {
  level.deployingplayer = spawnStruct();
  level.deployingplayer.types = [];
  targetsite("plague", 1, &ref_1471a, &ref_1471d, &ref_14715, &ref_14716, &ref_1239d, &ref_1471c);
  targetsshot("plague", 1, 9, 0);
  level.deployingplayer.zones = [];
  level.deployingplayer.ref_11e66 = 0;
  thread swaphelifordrivable("scr_br_plague_zone_locations", "", "prematch_done");
}

function targetsite(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawnStruct();
  var_8.name = var_0;
  var_8.set_just_keep_moving = var_1;
  var_8.testing_linked_anims = var_2;
  var_8.ref_13386 = var_3;
  var_8.nuke_vault_oil_puddle_watch = var_4;
  var_8.onpostkillcamcallback = var_5;
  var_8.play_loop_nagging_hostage_on_convoy = var_6;
  var_8.ref_11da4 = var_7;
  var_8.ref_13c00 = [];
  level.deployingplayer.types[var_0] = var_8;
}

function targetsshot(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.color = var_1;
  var_4.icon = var_2;
  var_4.style = var_3;
  level.deployingplayer.types[var_0].mapcircle = var_4;
}

function register_module_died_poorly_func(var_0) {
  return level.deployingplayer.zones[var_0];
}

function ref_135fc(var_0, var_1, var_2) {
  if(!isDefined(level.deployingplayer.types[var_0])) {
    return;
  }

  var_3 = level.deployingplayer.types[var_0];
  var_4 = spawnStruct();
  var_4.type = var_0;
  var_4.ref_13c00 = [];
  var_4.moving = 0;
  var_5 = (var_1[0], var_1[1], var_2);

  if(isDefined(var_3.mapcircle)) {
    var_6 = var_3.mapcircle.color;
    var_7 = var_3.mapcircle.icon;
    var_8 = var_3.mapcircle.style;
    var_4 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(var_6, var_7, var_8, var_5);
    var_4.mapcircle show();
  } else {
    var_4 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(0, 0, 0, var_5);
  }

  var_4.id = "zone_" + level.deployingplayer.ref_11e66;
  level.deployingplayer.ref_11e66++;
  var_4 thread[[var_3.testing_linked_anims]]();
  level.deployingplayer.zones[var_4.id] = var_4;
  ref_135fd(var_4, var_1, var_2);
  return var_4.id;
}

function ref_135fd(var_0, var_1) {
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self.trigger = spawn("trigger_radius", (var_0[0], var_0[1], -2000), 0, int(var_1), 12000);
  thread ref_1471f();
}

function ref_14714() {
  var_0 = level.deployingplayer.types[self.type];
  self thread[[var_0.ref_13386]]();
  self.trigger delete();
  self.mapcircle delete();
  self notify("delete");
  level.deployingplayer.zones[self.id] = undefined;
}

function ref_1471f() {
  self.trigger endon("death");
  var_0 = level.deployingplayer.types[self.type];

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }

    if(self.moving) {
      var_2 = ref_14718();
      var_3 = ref_14719();
      var_3 *= var_3;

      if(distance2dsquared(var_1.origin, var_2) > var_3) {
        continue;
      }
    }

    if(isDefined(var_0.play_loop_nagging_hostage_on_convoy) && [[var_0.play_loop_nagging_hostage_on_convoy]](var_1)) {
      continue;
    }

    var_4 = var_1.guid;

    if(!isDefined(self.ref_13c00[var_4])) {
      var_5 = spawnStruct();
      var_5.player = var_1;
      var_5.start = gettime();
      var_6 = 0;

      if(var_0.set_just_keep_moving) {
        self.ref_13c00[var_4] = spawnStruct();

        if(!isDefined(var_0.ref_13c00[var_4])) {
          var_5.ref_12ac2 = 0;
          var_0.ref_13c00[var_4] = var_5;
          var_6 = 1;
        }

        var_0.ref_13c00[var_4].ref_12ac2++;
      } else {
        if(!isDefined(var_0.ref_13c00[var_4])) {
          var_0.ref_13c00[var_4] = 0;
        }

        var_0.ref_13c00[var_4]++;
        self.ref_13c00[var_4] = var_5;
        var_6 = 1;
      }

      if(var_6) {
        self thread[[var_0.nuke_vault_oil_puddle_watch]](var_5);
      }
    }

    thread applyprematchplotarmor(var_4);
  }
}

function applyprematchplotarmor(var_0) {
  var_1 = self.ref_13c00[var_0];
  var_1 notify("trigger_exit");
  var_1 endon("trigger_exit");
  waitframe();
  waittillframeend();
  var_2 = level.deployingplayer.types[self.type];
  self.ref_13c00[var_0] = undefined;
  var_3 = 0;

  if(var_2.set_just_keep_moving) {
    var_2.ref_13c00[var_0].ref_12ac2--;

    if(!var_2.ref_13c00[var_0].ref_12ac2) {
      var_1 = var_2.ref_13c00[var_0];
      var_2.ref_13c00[var_0] = undefined;
      var_3 = 1;
    }
  } else {
    var_2.ref_13c00[var_0]--;

    if(!var_2.ref_13c00[var_0]) {
      var_2.ref_13c00[var_0] = undefined;
    }

    var_3 = 1;
  }

  if(var_3) {
    self thread[[var_2.onpostkillcamcallback]](var_1);
    return;
  }
}

function ref_1471b(var_0, var_1, var_2) {
  self notify("move");
  self endon("move");
  self endon("delete");
  var_3 = ref_14718();

  if(!isDefined(var_0)) {
    var_0 = var_3;
  }

  var_4 = ref_14719();

  if(!isDefined(var_1)) {
    var_1 = var_4;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_5 = level.deployingplayer.types[self.type];

  if(isDefined(var_5.ref_11da4)) {
    self thread[[var_5.ref_11da4]](var_0, var_1, var_2);
  }

  var_6 = var_3 != var_0 || var_4 != var_1;

  if(var_6) {
    var_7 = (var_0[0], var_0[1], var_1);

    if(var_2 <= 0) {
      self.mapcircle.origin = ref_135fd(var_7, var_0, var_1);
    } else {
      self.moving = 1;

      if(var_4 < var_1) {
        ref_135fd(var_0, var_1);
      }

      self.mapcircle moveTo(var_7, var_2);
      GscBinSkip4(0x35);
    }
  }

  self.moving = 0;
}

function applymovingcircles() {
  self.trigger endon("death");

  for(;;) {
    var_0 = ref_14718();
    self.trigger.origin = (var_0[0], var_0[1], -2000);
    waitframe();
  }
}

function ref_14718() {
  return (self.mapcircle.origin[0], self.mapcircle.origin[1], 0);
}

function ref_14719() {
  return self.mapcircle.origin[2];
}

function offlight(var_0) {
  return var_0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();
}

function og_mbradial(var_0) {
  return var_0 scripts\mp\gametypes\br_public::ref_125f3();
}

function ref_1471a() {
  var_0 = loadfx("vfx/iw8_br/gameplay/corruptzone/vfx_corruptzone_spores_10k");
  self.ref_1239c = spawnfx(var_0, ref_14718());
  self.ref_1239c unmarkkeyframedmover(1);
  triggerfx(self.ref_1239c);
}

function ref_1471d() {
  if(isDefined(self.ref_1239c)) {
    self.ref_1239c delete();
    return;
  }
}

function ref_14715(var_0) {
  if(!var_0.player scripts\mp\gametypes\br_public::ref_125f3()) {
    var_0.player scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("mp_don3_plague", 0.5);
    thread ref_14721(var_0);
    thread ref_14722(var_0);
  }

  var_0.player setscriptablepartstate("plague_zone", "enter");
}

function ref_14721(var_0) {
  var_1 = getdvarint("scr_br_zones_plague_damage", 3);
  var_2 = getdvarfloat("scr_br_zones_plague_jugg_damage_scale", 7);
  var_3 = getdvarfloat("scr_br_zones_plague_damage_rate", 2);
  var_4 = getdvarint("scr_br_zones_plague_cough", 0);
  var_0 endon("end_plague_update");
  var_0.player endon("disconnect");

  for(;;) {
    var_5 = var_0.player;

    if(!istrue(var_5.start_death_from_above_sequence)) {
      if(scripts\cp_mp\gasmask::hasgasmask(var_5)) {
        var_5 scripts\cp_mp\gasmask::processdamage(var_1);
      } else {
        var_6 = var_1;

        if(isDefined(level.ref_11c95)) {
          var_6 = var_5[[level.ref_11c95]](var_6);
        }

        if(var_5 scripts\mp\utility\killstreak::isjuggernaut()) {
          var_6 = int(var_6 * var_2);
        }

        var_5 dodamage(var_6, var_5.origin, var_5, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

        if(var_5 scripts\mp\gametypes\br_public::hasarmor()) {
          var_5 scripts\mp\gametypes\br_public::damagearmor(var_6);
        }

        if(var_4) {
          var_5 scripts\mp\gametypes\br_circle::ref_13e18();
        }
      }
    }

    wait var_3;
  }
}

function ref_14722(var_0) {
  var_0 endon("end_plague_update");
  var_0.player endon("disconnect");

  for(;;) {
    if(scripts\cp_mp\gasmask::hasgasmask(var_0.player)) {
      var_0.player scripts\mp\gametypes\br_pickups::plunderrepositoryref("plague_zone");
    }

    wait 1;
  }
}

function ref_14716(var_0) {
  var_0 notify("end_plague_update");

  if(!isDefined(var_0.player)) {
    return;
  }

  var_0.player setscriptablepartstate("plague_zone", "exit");

  if(!var_0.player scripts\mp\gametypes\br_public::ref_125f3()) {
    if(scripts\cp_mp\gasmask::hasgasmask(var_0.player)) {
      var_0.player scripts\mp\gametypes\br_pickups::plunderrankupdate("plague_zone");
    }

    var_0.player scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("", 0.5);
    return;
  }
}

function ref_1471c(var_0, var_1, var_2) {}

function swaphelifordrivable(var_0, var_1, var_2) {
  var_3 = getDvar(var_0, var_1);

  if(var_3 == "") {
    return;
  }

  waittillframeend();

  if(isDefined(var_2)) {
    scripts\mp\flags::gameflagwait(var_2);
  }

  var_4 = getdvarint("scr_br_plague_zone_locations_max", -1);
  var_5 = strtok(var_3, ",");

  if(var_4 < 0) {
    var_4 = var_5.size;
  } else {
    var_4 = min(var_4, var_5.size);
    var_5 = scripts\engine\utility::array_randomize(var_5);
  }

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_7 = var_5[var_6];
    swap_access_card(var_7);
    thread ref_12df0(var_7);
  }
}

function ref_12df0(var_0) {
  var_1 = level.deployingplayer.ref_11e27[var_0];

  if(!isDefined(var_1)) {
    return;
  }

  if(var_1.ks_circlemoving > var_1.ks_circlemovedist) {
    var_2 = randomfloatrange(var_1.ks_circlemovedist, var_1.ks_circlemoving);
  } else {
    var_2 = var_2.ks_circlemovedist;
  }

  wait var_2;

  if(var_2.set_mark_distances > 0) {
    var_3 = ref_135fc("plague", var_2.origin, 50);
    var_4 = register_module_died_poorly_func(var_3);
    thread ref_1471b(var_4, undefined, var_2.radius);
  } else {
    var_3 = ref_135fc("plague", var_2.origin, var_2.radius);
  }

  level waittill("game_ended");
  var_4 = register_module_died_poorly_func(var_3);

  if(isDefined(var_4)) {
    ref_14714(var_4);
    return;
  }
}

function swap_access_card(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.deployingplayer.ref_11e27)) {
    level.deployingplayer.ref_11e27 = [];
  }

  if(isDefined(level.deployingplayer.ref_11e27[var_0])) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = -1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  switch (var_0) {
    case "dam":
      var_6 = [(-21543, 47479, 0), 10000, 75, 5, 10];
      var_1 = var_6[0];
      var_2 = var_6[1];
      var_3 = var_6[2];
      var_4 = var_6[3];
      var_5 = var_6[4];
      var_6 = undefined;
      break;
    case "stadium":
      var_7 = [(28696, 2288, 0), 10000, 75, 5, 10];
      var_1 = var_7[0];
      var_2 = var_7[1];
      var_3 = var_7[2];
      var_4 = var_7[3];
      var_5 = var_7[4];
      var_7 = undefined;
      break;
    case "hospital":
      var_8 = [(9443, -11877, 0), 10000, 75, 5, 10];
      var_1 = var_8[0];
      var_2 = var_8[1];
      var_3 = var_8[2];
      var_4 = var_8[3];
      var_5 = var_8[4];
      var_8 = undefined;
      break;
    case "ship":
      var_9 = [(38750, -43340, 0), 10000, 75, 5, 10];
      var_1 = var_9[0];
      var_2 = var_9[1];
      var_3 = var_9[2];
      var_4 = var_9[3];
      var_5 = var_9[4];
      var_9 = undefined;
      break;
    case "tv":
      var_10 = [(15258, 17988, 0), 10000, 75, 5, 10];
      var_1 = var_10[0];
      var_2 = var_10[1];
      var_3 = var_10[2];
      var_4 = var_10[3];
      var_5 = var_10[4];
      var_10 = undefined;
      break;
    case "super":
      var_11 = [(-13027, 9242, 0), 10000, 75, 5, 10];
      var_1 = var_11[0];
      var_2 = var_11[1];
      var_3 = var_11[2];
      var_4 = var_11[3];
      var_5 = var_11[4];
      var_11 = undefined;
      break;
    case "gulag":
      var_12 = [(51158, -38213, 0), 10000, 75, 5, 10];
      var_1 = var_12[0];
      var_2 = var_12[1];
      var_3 = var_12[2];
      var_4 = var_12[3];
      var_5 = var_12[4];
      var_12 = undefined;
      break;
    case "quarry":
      var_13 = [(34267, 43134, 0), 10000, 75, 5, 10];
      var_1 = var_13[0];
      var_2 = var_13[1];
      var_3 = var_13[2];
      var_4 = var_13[3];
      var_5 = var_13[4];
      var_13 = undefined;
      break;
    case "boneyard":
      var_14 = [(-27531, -10899, 0), 10000, 75, 5, 10];
      var_1 = var_14[0];
      var_2 = var_14[1];
      var_3 = var_14[2];
      var_4 = var_14[3];
      var_5 = var_14[4];
      var_14 = undefined;
      break;
    case "bank":
      var_15 = [(21767, -19846, 0), 10000, 75, 5, 10];
      var_1 = var_15[0];
      var_2 = var_15[1];
      var_3 = var_15[2];
      var_4 = var_15[3];
      var_5 = var_15[4];
      var_15 = undefined;
      break;
    default:
      break;
  }

  var_16 = spawnStruct();
  var_17 = "scr_br_plague_zone_" + var_0 + "_";
  var_16.origin = getdvarvector(var_17 + "origin", var_1);
  var_16.radius = getdvarfloat(var_17 + "radius", var_2) * getdvarfloat("scr_br_plague_zone_radius_scale", 1);
  var_16.set_mark_distances = getdvarfloat(var_17 + "grow_time", var_3) * getdvarfloat("scr_br_plague_zone_grow_time_scale", 1);
  var_16.ks_circlemovedist = getdvarfloat(var_17 + "delay", var_4) * getdvarfloat("scr_br_plague_zone_delay_scale", 1);
  var_16.ks_circlemoving = getdvarfloat(var_17 + "delay_max", var_5) * getdvarfloat("scr_br_plague_zone_delay_max_scale", 1);

  if(var_16.radius < 0) {
    return;
  }

  level.deployingplayer.ref_11e27[var_0] = var_16;
}

function ref_1239d(var_0) {
  return offlight(var_0);
}

function updatelocationbesttimehud(var_0, var_1) {
  if(!isDefined(level.deployingplayer) || !isDefined(level.deployingplayer.zones) || !isDefined(level.deployingplayer.types[var_0])) {
    return false;
  }

  return isDefined(level.deployingplayer.types[var_0].ref_13c00[var_1.guid]);
}