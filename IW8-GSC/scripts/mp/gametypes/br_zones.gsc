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

function targetsite(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = spawnStruct();
  var8.name = var0;
  var8.set_just_keep_moving = var1;
  var8.testing_linked_anims = var2;
  var8.ref_13386 = var3;
  var8.nuke_vault_oil_puddle_watch = var4;
  var8.onpostkillcamcallback = var5;
  var8.play_loop_nagging_hostage_on_convoy = var6;
  var8.ref_11da4 = var7;
  var8.ref_13c00 = [];
  level.deployingplayer.types[var0] = var8;
}

function targetsshot(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.color = var1;
  var4.icon = var2;
  var4.style = var3;
  level.deployingplayer.types[var0].mapcircle = var4;
}

function register_module_died_poorly_func(var0) {
  return level.deployingplayer.zones[var0];
}

function ref_135fc(var0, var1, var2) {
  if(!isDefined(level.deployingplayer.types[var0])) {
    return;
  }

  var3 = level.deployingplayer.types[var0];
  var4 = spawnStruct();
  var4.type = var0;
  var4.ref_13c00 = [];
  var4.moving = 0;
  var5 = (var1[0], var1[1], var2);

  if(isDefined(var3.mapcircle)) {
    var6 = var3.mapcircle.color;
    var7 = var3.mapcircle.icon;
    var8 = var3.mapcircle.style;
    var4 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(var6, var7, var8, var5);
    var4.mapcircle show();
  } else {
    var4 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(0, 0, 0, var5);
  }

  var4.id = "zone_" + level.deployingplayer.ref_11e66;
  level.deployingplayer.ref_11e66++;
  var4 thread[[var3.testing_linked_anims]]();
  level.deployingplayer.zones[var4.id] = var4;
  ref_135fd(var4, var1, var2);
  return var4.id;
}

function ref_135fd(var0, var1) {
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self.trigger = spawn("trigger_radius", (var0[0], var0[1], -2000), 0, int(var1), 12000);
  thread ref_1471f();
}

function ref_14714() {
  var0 = level.deployingplayer.types[self.type];
  self thread[[var0.ref_13386]]();
  self.trigger delete();
  self.mapcircle delete();
  self notify("delete");
  level.deployingplayer.zones[self.id] = undefined;
}

function ref_1471f() {
  self.trigger endon("death");
  var0 = level.deployingplayer.types[self.type];

  for(;;) {
    self.trigger waittill("trigger", var1);

    if(!isPlayer(var1)) {
      continue;
    }

    if(self.moving) {
      var2 = ref_14718();
      var3 = ref_14719();
      var3 *= var3;

      if(distance2dsquared(var1.origin, var2) > var3) {
        continue;
      }
    }

    if(isDefined(var0.play_loop_nagging_hostage_on_convoy) && [[var0.play_loop_nagging_hostage_on_convoy]](var1)) {
      continue;
    }

    var4 = var1.guid;

    if(!isDefined(self.ref_13c00[var4])) {
      var5 = spawnStruct();
      var5.player = var1;
      var5.start = gettime();
      var6 = 0;

      if(var0.set_just_keep_moving) {
        self.ref_13c00[var4] = spawnStruct();

        if(!isDefined(var0.ref_13c00[var4])) {
          var5.ref_12ac2 = 0;
          var0.ref_13c00[var4] = var5;
          var6 = 1;
        }

        var0.ref_13c00[var4].ref_12ac2++;
      } else {
        if(!isDefined(var0.ref_13c00[var4])) {
          var0.ref_13c00[var4] = 0;
        }

        var0.ref_13c00[var4]++;
        self.ref_13c00[var4] = var5;
        var6 = 1;
      }

      if(var6) {
        self thread[[var0.nuke_vault_oil_puddle_watch]](var5);
      }
    }

    thread applyprematchplotarmor(var4);
  }
}

function applyprematchplotarmor(var0) {
  var1 = self.ref_13c00[var0];
  var1 notify("trigger_exit");
  var1 endon("trigger_exit");
  waitframe();
  waittillframeend();
  var2 = level.deployingplayer.types[self.type];
  self.ref_13c00[var0] = undefined;
  var3 = 0;

  if(var2.set_just_keep_moving) {
    var2.ref_13c00[var0].ref_12ac2--;

    if(!var2.ref_13c00[var0].ref_12ac2) {
      var1 = var2.ref_13c00[var0];
      var2.ref_13c00[var0] = undefined;
      var3 = 1;
    }
  } else {
    var2.ref_13c00[var0]--;

    if(!var2.ref_13c00[var0]) {
      var2.ref_13c00[var0] = undefined;
    }

    var3 = 1;
  }

  if(var3) {
    self thread[[var2.onpostkillcamcallback]](var1);
    return;
  }
}

function ref_1471b(var0, var1, var2) {
  self notify("move");
  self endon("move");
  self endon("delete");
  var3 = ref_14718();

  if(!isDefined(var0)) {
    var0 = var3;
  }

  var4 = ref_14719();

  if(!isDefined(var1)) {
    var1 = var4;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var5 = level.deployingplayer.types[self.type];

  if(isDefined(var5.ref_11da4)) {
    self thread[[var5.ref_11da4]](var0, var1, var2);
  }

  var6 = var3 != var0 || var4 != var1;

  if(var6) {
    var7 = (var0[0], var0[1], var1);

    if(var2 <= 0) {
      self.mapcircle.origin = ref_135fd(var7, var0, var1);
    } else {
      self.moving = 1;

      if(var4 < var1) {
        ref_135fd(var0, var1);
      }

      self.mapcircle moveTo(var7, var2);
      GscBinSkip4(0x35);
    }
  }

  self.moving = 0;
}

function applymovingcircles() {
  self.trigger endon("death");

  for(;;) {
    var0 = ref_14718();
    self.trigger.origin = (var0[0], var0[1], -2000);
    waitframe();
  }
}

function ref_14718() {
  return (self.mapcircle.origin[0], self.mapcircle.origin[1], 0);
}

function ref_14719() {
  return self.mapcircle.origin[2];
}

function offlight(var0) {
  return var0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();
}

function og_mbradial(var0) {
  return var0 scripts\mp\gametypes\br_public::ref_125f3();
}

function ref_1471a() {
  var0 = loadfx("vfx/iw8_br/gameplay/corruptzone/vfx_corruptzone_spores_10k");
  self.ref_1239c = spawnfx(var0, ref_14718());
  self.ref_1239c unmarkkeyframedmover(1);
  triggerfx(self.ref_1239c);
}

function ref_1471d() {
  if(isDefined(self.ref_1239c)) {
    self.ref_1239c delete();
    return;
  }
}

function ref_14715(var0) {
  if(!var0.player scripts\mp\gametypes\br_public::ref_125f3()) {
    var0.player scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("mp_don3_plague", 0.5);
    thread ref_14721(var0);
    thread ref_14722(var0);
  }

  var0.player setscriptablepartstate("plague_zone", "enter");
}

function ref_14721(var0) {
  var1 = getdvarint("scr_br_zones_plague_damage", 3);
  var2 = getdvarfloat("scr_br_zones_plague_jugg_damage_scale", 7);
  var3 = getdvarfloat("scr_br_zones_plague_damage_rate", 2);
  var4 = getdvarint("scr_br_zones_plague_cough", 0);
  var0 endon("end_plague_update");
  var0.player endon("disconnect");

  for(;;) {
    var5 = var0.player;

    if(!istrue(var5.start_death_from_above_sequence)) {
      if(scripts\cp_mp\gasmask::hasgasmask(var5)) {
        var5 scripts\cp_mp\gasmask::processdamage(var1);
      } else {
        var6 = var1;

        if(isDefined(level.ref_11c95)) {
          var6 = var5[[level.ref_11c95]](var6);
        }

        if(var5 scripts\mp\utility\killstreak::isjuggernaut()) {
          var6 = int(var6 * var2);
        }

        var5 dodamage(var6, var5.origin, var5, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");

        if(var5 scripts\mp\gametypes\br_public::hasarmor()) {
          var5 scripts\mp\gametypes\br_public::damagearmor(var6);
        }

        if(var4) {
          var5 scripts\mp\gametypes\br_circle::ref_13e18();
        }
      }
    }

    wait var3;
  }
}

function ref_14722(var0) {
  var0 endon("end_plague_update");
  var0.player endon("disconnect");

  for(;;) {
    if(scripts\cp_mp\gasmask::hasgasmask(var0.player)) {
      var0.player scripts\mp\gametypes\br_pickups::plunderrepositoryref("plague_zone");
    }

    wait 1;
  }
}

function ref_14716(var0) {
  var0 notify("end_plague_update");

  if(!isDefined(var0.player)) {
    return;
  }

  var0.player setscriptablepartstate("plague_zone", "exit");

  if(!var0.player scripts\mp\gametypes\br_public::ref_125f3()) {
    if(scripts\cp_mp\gasmask::hasgasmask(var0.player)) {
      var0.player scripts\mp\gametypes\br_pickups::plunderrankupdate("plague_zone");
    }

    var0.player scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("", 0.5);
    return;
  }
}

function ref_1471c(var0, var1, var2) {}

function swaphelifordrivable(var0, var1, var2) {
  var3 = getDvar(var0, var1);

  if(var3 == "") {
    return;
  }

  waittillframeend();

  if(isDefined(var2)) {
    scripts\mp\flags::gameflagwait(var2);
  }

  var4 = getdvarint("scr_br_plague_zone_locations_max", -1);
  var5 = strtok(var3, ",");

  if(var4 < 0) {
    var4 = var5.size;
  } else {
    var4 = min(var4, var5.size);
    var5 = scripts\engine\utility::array_randomize(var5);
  }

  for(var6 = 0; var6 < var4; var6++) {
    var7 = var5[var6];
    swap_access_card(var7);
    thread ref_12df0(var7);
  }
}

function ref_12df0(var0) {
  var1 = level.deployingplayer.ref_11e27[var0];

  if(!isDefined(var1)) {
    return;
  }

  if(var1.ks_circlemoving > var1.ks_circlemovedist) {
    var2 = randomfloatrange(var1.ks_circlemovedist, var1.ks_circlemoving);
  } else {
    var2 = var2.ks_circlemovedist;
  }

  wait var2;

  if(var2.set_mark_distances > 0) {
    var3 = ref_135fc("plague", var2.origin, 50);
    var4 = register_module_died_poorly_func(var3);
    thread ref_1471b(var4, undefined, var2.radius);
  } else {
    var3 = ref_135fc("plague", var2.origin, var2.radius);
  }

  level waittill("game_ended");
  var4 = register_module_died_poorly_func(var3);

  if(isDefined(var4)) {
    ref_14714(var4);
    return;
  }
}

function swap_access_card(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level.deployingplayer.ref_11e27)) {
    level.deployingplayer.ref_11e27 = [];
  }

  if(isDefined(level.deployingplayer.ref_11e27[var0])) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  if(!isDefined(var2)) {
    var2 = -1;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  switch (var0) {
    case "dam":
      var6 = [(-21543, 47479, 0), 10000, 75, 5, 10];
      var1 = var6[0];
      var2 = var6[1];
      var3 = var6[2];
      var4 = var6[3];
      var5 = var6[4];
      var6 = undefined;
      break;
    case "stadium":
      var7 = [(28696, 2288, 0), 10000, 75, 5, 10];
      var1 = var7[0];
      var2 = var7[1];
      var3 = var7[2];
      var4 = var7[3];
      var5 = var7[4];
      var7 = undefined;
      break;
    case "hospital":
      var8 = [(9443, -11877, 0), 10000, 75, 5, 10];
      var1 = var8[0];
      var2 = var8[1];
      var3 = var8[2];
      var4 = var8[3];
      var5 = var8[4];
      var8 = undefined;
      break;
    case "ship":
      var9 = [(38750, -43340, 0), 10000, 75, 5, 10];
      var1 = var9[0];
      var2 = var9[1];
      var3 = var9[2];
      var4 = var9[3];
      var5 = var9[4];
      var9 = undefined;
      break;
    case "tv":
      var10 = [(15258, 17988, 0), 10000, 75, 5, 10];
      var1 = var10[0];
      var2 = var10[1];
      var3 = var10[2];
      var4 = var10[3];
      var5 = var10[4];
      var10 = undefined;
      break;
    case "super":
      var11 = [(-13027, 9242, 0), 10000, 75, 5, 10];
      var1 = var11[0];
      var2 = var11[1];
      var3 = var11[2];
      var4 = var11[3];
      var5 = var11[4];
      var11 = undefined;
      break;
    case "gulag":
      var12 = [(51158, -38213, 0), 10000, 75, 5, 10];
      var1 = var12[0];
      var2 = var12[1];
      var3 = var12[2];
      var4 = var12[3];
      var5 = var12[4];
      var12 = undefined;
      break;
    case "quarry":
      var13 = [(34267, 43134, 0), 10000, 75, 5, 10];
      var1 = var13[0];
      var2 = var13[1];
      var3 = var13[2];
      var4 = var13[3];
      var5 = var13[4];
      var13 = undefined;
      break;
    case "boneyard":
      var14 = [(-27531, -10899, 0), 10000, 75, 5, 10];
      var1 = var14[0];
      var2 = var14[1];
      var3 = var14[2];
      var4 = var14[3];
      var5 = var14[4];
      var14 = undefined;
      break;
    case "bank":
      var15 = [(21767, -19846, 0), 10000, 75, 5, 10];
      var1 = var15[0];
      var2 = var15[1];
      var3 = var15[2];
      var4 = var15[3];
      var5 = var15[4];
      var15 = undefined;
      break;
    default:
      break;
  }

  var16 = spawnStruct();
  var17 = "scr_br_plague_zone_" + var0 + "_";
  var16.origin = getdvarvector(var17 + "origin", var1);
  var16.radius = getdvarfloat(var17 + "radius", var2) * getdvarfloat("scr_br_plague_zone_radius_scale", 1);
  var16.set_mark_distances = getdvarfloat(var17 + "grow_time", var3) * getdvarfloat("scr_br_plague_zone_grow_time_scale", 1);
  var16.ks_circlemovedist = getdvarfloat(var17 + "delay", var4) * getdvarfloat("scr_br_plague_zone_delay_scale", 1);
  var16.ks_circlemoving = getdvarfloat(var17 + "delay_max", var5) * getdvarfloat("scr_br_plague_zone_delay_max_scale", 1);

  if(var16.radius < 0) {
    return;
  }

  level.deployingplayer.ref_11e27[var0] = var16;
}

function ref_1239d(var0) {
  return offlight(var0);
}

function updatelocationbesttimehud(var0, var1) {
  if(!isDefined(level.deployingplayer) || !isDefined(level.deployingplayer.zones) || !isDefined(level.deployingplayer.types[var0])) {
    return false;
  }

  return isDefined(level.deployingplayer.types[var0].ref_13c00[var1.guid]);
}