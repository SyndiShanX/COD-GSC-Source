/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58260.gsc
***********************************************/

function init() {
  level.setplayervargulagjail = [];
  level.setplunderifunchanged = [];
  level.setplayervargulagjail[0] = 20;
  level.setplunderifunchanged[0] = 30;
  level.setplayervargulagjail[1] = 50;
  level.setplayervargulagjail[2] = 80;
  level.setplayervargulagjail[3] = 120;
  level.setplayervargulagjail[4] = 160;
  level.setplunderifunchanged[1] = 180;
  level.setplayervargulagjail[5] = 220;
  level.setplayervargulagjail[6] = 280;
  level.setplayervargulagjail[7] = 340;
  level.setplunderifunchanged[2] = 370;
  level.setplayervargulagjail[8] = 400;
  level.setplunderifunchanged[3] = 450;
  level.setplayervargulagjail[9] = 460;
  level.setplunderifunchanged[4] = 510;
  level.setplunderifunchanged[5] = 520;
  level.setplayervargulagjail[10] = 530;
  level.setplunderifunchanged[6] = 590;
  level.setplayervargulagjail[11] = 650;
  level.setplayervargulagjail[12] = 710;
  level.setplunderifunchanged[7] = 750;
  level.setplayervargulagjail[13] = 780;
  level.setplunderifunchanged[8] = 830;
  level.setplunderifunchanged[9] = 840;
  level.setplayervargulagjail[14] = 850;
  level._effect["candySmall"] = loadfx("vfx/iw8_br/gameplay/hween/vfx_loot_candy_sml.vfx");
  level._effect["candyBig"] = loadfx("vfx/iw8_br/gameplay/hween/vfx_loot_candy_lrg.vfx");
  level._effect["vfx_loot_candy_prize"] = loadfx("vfx/iw8_br/gameplay/hween/vfx_loot_candy_prize.vfx");
}

function ref_12120(var0, var1, var2, var3) {
  level endon("game_ended");
  var4 = getdvarint("scr_halloween_candy_value", 10);
  var5 = getdvarint("scr_halloween_candy_value_variance", 0);
  var6 = var0 == "br_loot_cache_lege";

  if(var6) {
    var4 *= 2;
  }

  if(var5 > 0) {
    var4 += randomintrange(var5 * -1, var5);
  }

  if(getdvarint("scr_halloween_vfx_every_cache", 0) == 1) {
    if(var6) {
      thread ref_12458(level, var1);
    } else {
      thread ref_12458(level, var1);
    }
  }

  if(_calloutmarkerping_handleluinotify_enemyrepinged::ref_124f5()) {
    var7 = self getplayerdata("common", "halloweenTrickOrTreatLocations", 16);

    if(!var7) {
      thread ref_12776(level);
      var8 = forceexplosivedeath();
      self reportchallengeuserevent("collect_item", "halloween_treat_15");
      self dlog_recordplayerevent("dlog_event_halloween_treat", ["reward_id", 15]);
      self setplayerdata("common", "halloweenTrickOrTreatLocations", 16, 1);
      ref_13e12();
    }

    return;
  }

  var9 = -1;

  if(isDefined(var4)) {
    var9 = var4;
  } else if(isDefined(var3)) {
    switch (var3) {
      case "militarybase":
      case "airfield":
        var9 = 0;
        break;
      case "graveyard":
      case "transit":
      case "junkyard":
      case "boneyard":
        var9 = 1;
        break;
      case "dam":
        var9 = 2;
        break;
      case "downtown":
        var9 = 3;
        break;
      case "storagetown":
        var9 = 4;
        break;
      case "hospital":
        var9 = 5;
        break;
      case "layover":
        var9 = 6;
        break;
      case "quarry":
        var9 = 7;
        break;
      case "port":
        var9 = 8;
        break;
      case "stadium":
        var9 = 9;
        break;
      case "gulag":
        var9 = 10;
        break;
      case "farm":
      case "lumber":
      case "farms":
        var9 = 11;
        break;
      case "tvstation":
        var9 = 12;
        break;
      case "super":
        var9 = 13;
        break;
      case "shopping_district_e":
      case "shopping_district_w":
      case "hills":
        var9 = 14;
        break;
      default:
        break;
    }
  }

  if(var9 == -1) {
    return;
  }

  var10 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var9);

  if(var10) {
    ref_13e19();

    if(!istrue(self.setplayersquadindex)) {
      self.setplayersquadindex = 1;
      ref_13e12();
    }

    return;
  }

  var11 = self getplayerdata("common", "halloweenTrickOrTreatCandy");
  var8 = forceexplosivedeath();
  var12 = regulateturretrateoffire(var8, var11, var5);
  ref_128b2(var9, var12, var2, var7);
}

function ref_13e19() {
  var0 = randomfloat(1);

  if(var0 < getdvarfloat("scr_halloween_finished_trick_chance", 0)) {
    var1 = randomint(11);
    self setclientomnvar("ui_halloween_event", var1);
    return true;
  }

  return false;
}

function ref_128b2(var0, var1, var2, var3) {
  if(var1 == 0) {
    thread ref_12458(level, var2);
  }

  if(var1 < 0) {
    if(getdvarint("scr_halloween_trick_killswitch", 0) == 0) {
      ref_12d34(var1);
      return;
    }

    return;
  }

  if(var1 > 0) {
    self setclientomnvar("ui_halloween_event", 99);
    thread ref_12776(level);
    thread ref_12d33(var1, var0);
    return;
  }
}

function isskydivestatedisabled() {
  var0 = 0;

  for(var1 = 0; var1 < 15; var1++) {
    var2 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var1);
    var0 = var1;

    if(!var2) {
      break;
    }
  }

  var3 = self getplayerdata("common", "halloweenTrickOrTreatCandy");
  var4 = getdvarint("scr_halloween_candy_value", 10);
  var5 = forceexplosivedeath();
  var6 = regulateturretrateoffire(var5, var3, var4);
  ref_128b2(var0, var6);
}

function isstandardsandbox(var0) {
  issmallsplashdamage();

  for(var1 = 0; var1 < var0; var1++) {
    var2 = 0;

    for(var1 = 0; var1 < 15; var1++) {
      var3 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var1);
      var2 = var1;

      if(!var3) {
        break;
      }
    }

    ref_12120("", undefined, "", var2);
  }
}

function issmallsplashdamage() {
  var0 = self getplayerdata("common", "halloweenTrickOrTreatLocations", 16);

  if(!var0) {
    self reportchallengeuserevent("collect_item", "halloween_treat_15");
    self dlog_recordplayerevent("dlog_event_halloween_treat", ["reward_id", 15]);
    self setplayerdata("common", "halloweenTrickOrTreatLocations", 16, 1);
    return;
  }
}

function isthrowingknifeequipment() {
  for(var0 = 0; var0 <= 14; var0++) {
    var1 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var0);

    if(!var1) {
      var2 = "";

      switch (var0) {
        case 0:
          var2 = "Mil Base";
          break;
        case 1:
          var2 = "Boneyard";
          break;
        case 2:
          var2 = "Dam";
          break;
        case 3:
          var2 = "Downtown";
          break;
        case 4:
          var2 = "Storage Town";
          break;
        case 5:
          var2 = "Hospital";
          break;
        case 6:
          var2 = "Layover";
          break;
        case 7:
          var2 = "Quarry";
          break;
        case 8:
          var2 = "Port";
          break;
        case 9:
          var2 = "Stadium";
          break;
        case 10:
          var2 = "Gulag";
          break;
        case 11:
          var2 = "Lumber";
          break;
        case 12:
          var2 = "TV Station";
          break;
        case 13:
          var2 = "Super";
          break;
        case 14:
          var2 = "Hills";
          break;
        default:
          var2 = "Unkown_" + var0;
          break;
      }

      self iprintln("Unfinished " + var2);
    }
  }

  var3 = self getplayerdata("common", "halloweenTrickOrTreatLocations", 16);

  if(!var3) {
    self iprintln("Unfinished Train");
    return;
  }
}

function issmokinggun() {
  var0 = forceexplosivedeath();

  for(var1 = 0; var1 < var0 + 1; var1++) {
    var2 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var1);

    if(!var2) {
      isstunnedby(var1);
    }
  }
}

function isstunnedby(var0) {
  self iprintln("Finishing location " + var0);
  self setclientomnvar("ui_halloween_event", 99);
  thread ref_12d33(10, var0);

  if(var0 == 14) {
    self iprintln("Final Loot award!");
    wait 3;
    cheesewedge();
    return;
  }
}

function regulateturretrateoffire(var0, var1, var2) {
  var3 = var1 + var2;
  self setplayerdata("common", "halloweenTrickOrTreatCandy", var3);
  var4 = level.setplayervargulagjail[var0];
  var5 = -1;

  if(var3 >= var4) {
    var5 = var0;
    return (var5 + 1);
  }

  var6 = -1;

  for(var7 = 0; var7 < level.setplunderifunchanged.size; var7++) {
    var8 = level.setplunderifunchanged[var7];

    if(var3 >= var8 && var1 < var8) {
      var6 = var7;
    }
  }

  return (var6 + 1) * -1;
}

function ref_12d33(var0, var1) {
  self setclientomnvar("ui_halloween_event", 99);
  var2 = 0;
  var3 = "";

  switch (var1) {
    case 0:
      var3 = "halloween_treat_0";
      break;
    case 1:
      var3 = "halloween_treat_1";
      break;
    case 2:
      var3 = "halloween_treat_2";
      break;
    case 3:
      var3 = "halloween_treat_3";
      break;
    case 4:
      var3 = "halloween_treat_4";
      break;
    case 5:
      var3 = "halloween_treat_5";
      break;
    case 6:
      var3 = "halloween_treat_6";
      break;
    case 7:
      var3 = "halloween_treat_7";
      break;
    case 8:
      var3 = "halloween_treat_8";
      break;
    case 9:
      var3 = "halloween_treat_9";
      break;
    case 10:
      var3 = "halloween_treat_10";
      break;
    case 11:
      var3 = "halloween_treat_11";
      break;
    case 12:
      var3 = "halloween_treat_12";
      break;
    case 13:
      var3 = "halloween_treat_13";
      break;
    case 14:
      var3 = "halloween_treat_14";
      break;
  }

  if(var3 != "") {
    self reportchallengeuserevent("collect_item", var3);
    self dlog_recordplayerevent("dlog_event_halloween_treat", ["reward_id", var0]);
    self setplayerdata("common", "halloweenTrickOrTreatLocations", var1, 1);
    ref_13e12();
    return;
  }
}

function ref_13e12() {
  var0 = 0;

  for(var1 = 0; var1 < 15; var1++) {
    var2 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var1);
    var0 += var2;
    var3 = var1;
  }

  var4 = self getplayerdata("common", "halloweenTrickOrTreatLocations", 16);
  var0 += var4;

  if(var0 == 16) {
    wait 3;
    cheesewedge();
    return;
  }
}

function ref_12d34(var0) {
  self setclientomnvar("ui_halloween_event", var0 * -1);
}

function ref_12458(var0, var1) {
  level endon("game_ended");

  if(!isDefined(var0)) {
    return;
  }

  var2 = "candySmall";

  if(var1) {
    var2 = "candyBig";
  }

  var3 = spawnfx(level._effect[var2], var0.origin + (0, 0, 10));
  var3.angles = var0.angles;
  wait 0.1;
  triggerfx(var3);
}

function ref_12776(var0) {
  level endon("game_ended");

  if(!isDefined(var0)) {
    return;
  }

  var1 = spawnfx(level._effect["vfx_loot_candy_prize"], var0.origin + (0, 0, 10));
  var1.angles = var0.angles;
  wait 0.1;
  triggerfx(var1);
}

function forceexplosivedeath() {
  var0 = 0;

  for(var1 = 0; var1 < 14; var1++) {
    var2 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var1);

    if(var2) {
      var0++;
    }
  }

  return var0;
}

function isusingtacmap(var0) {
  if(!isbot(self)) {
    self setclientomnvar("ui_halloween_event", 99);
    self reportchallengeuserevent("collect_item", "halloween_treat_" + var0);
    self dlog_recordplayerevent("dlog_event_halloween_treat", ["reward_id", int(var0)]);
    return;
  }
}

function isvalidanimsuiteentity(var0) {
  if(int(var0) < 0) {
    ref_13e19();
    return;
  }

  if(!isbot(self)) {
    self setclientomnvar("ui_halloween_event", int(var0));
    return;
  }
}

function cheesewedge() {
  self reportchallengeuserevent("collect_item", "halloween_treat_16");
  self dlog_recordplayerevent("dlog_event_halloween_treat", ["reward_id", 16]);
}