/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58260.gsc
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

function ref_12120(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_4 = getdvarint("scr_halloween_candy_value", 10);
  var_5 = getdvarint("scr_halloween_candy_value_variance", 0);
  var_6 = var_0 == "br_loot_cache_lege";

  if(var_6) {
    var_4 *= 2;
  }

  if(var_5 > 0) {
    var_4 += randomintrange(var_5 * -1, var_5);
  }

  if(getdvarint("scr_halloween_vfx_every_cache", 0) == 1) {
    if(var_6) {
      thread ref_12458(level, var_1);
    } else {
      thread ref_12458(level, var_1);
    }
  }

  if(_calloutmarkerping_handleluinotify_enemyrepinged::ref_124f5()) {
    var_7 = self getplayerdata("common", "halloweenTrickOrTreatLocations", 16);

    if(!var_7) {
      thread ref_12776(level);
      var_8 = forceexplosivedeath();
      self reportchallengeuserevent("collect_item", "halloween_treat_15");
      self dlog_recordplayerevent("dlog_event_halloween_treat", ["reward_id", 15]);
      self setplayerdata("common", "halloweenTrickOrTreatLocations", 16, 1);
      ref_13e12();
    }

    return;
  }

  var_9 = -1;

  if(isDefined(var_4)) {
    var_9 = var_4;
  } else if(isDefined(var_3)) {
    switch (var_3) {
      case "militarybase":
      case "airfield":
        var_9 = 0;
        break;
      case "graveyard":
      case "transit":
      case "junkyard":
      case "boneyard":
        var_9 = 1;
        break;
      case "dam":
        var_9 = 2;
        break;
      case "downtown":
        var_9 = 3;
        break;
      case "storagetown":
        var_9 = 4;
        break;
      case "hospital":
        var_9 = 5;
        break;
      case "layover":
        var_9 = 6;
        break;
      case "quarry":
        var_9 = 7;
        break;
      case "port":
        var_9 = 8;
        break;
      case "stadium":
        var_9 = 9;
        break;
      case "gulag":
        var_9 = 10;
        break;
      case "farm":
      case "lumber":
      case "farms":
        var_9 = 11;
        break;
      case "tvstation":
        var_9 = 12;
        break;
      case "super":
        var_9 = 13;
        break;
      case "shopping_district_e":
      case "shopping_district_w":
      case "hills":
        var_9 = 14;
        break;
      default:
        break;
    }
  }

  if(var_9 == -1) {
    return;
  }

  var_10 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var_9);

  if(var_10) {
    ref_13e19();

    if(!istrue(self.setplayersquadindex)) {
      self.setplayersquadindex = 1;
      ref_13e12();
    }

    return;
  }

  var_11 = self getplayerdata("common", "halloweenTrickOrTreatCandy");
  var_8 = forceexplosivedeath();
  var_12 = regulateturretrateoffire(var_8, var_11, var_5);
  ref_128b2(var_9, var_12, var_2, var_7);
}

function ref_13e19() {
  var_0 = randomfloat(1);

  if(var_0 < getdvarfloat("scr_halloween_finished_trick_chance", 0)) {
    var_1 = randomint(11);
    self setclientomnvar("ui_halloween_event", var_1);
    return true;
  }

  return false;
}

function ref_128b2(var_0, var_1, var_2, var_3) {
  if(var_1 == 0) {
    thread ref_12458(level, var_2);
  }

  if(var_1 < 0) {
    if(getdvarint("scr_halloween_trick_killswitch", 0) == 0) {
      ref_12d34(var_1);
      return;
    }

    return;
  }

  if(var_1 > 0) {
    self setclientomnvar("ui_halloween_event", 99);
    thread ref_12776(level);
    thread ref_12d33(var_1, var_0);
    return;
  }
}

function isskydivestatedisabled() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 15; var_1++) {
    var_2 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var_1);
    var_0 = var_1;

    if(!var_2) {
      break;
    }
  }

  var_3 = self getplayerdata("common", "halloweenTrickOrTreatCandy");
  var_4 = getdvarint("scr_halloween_candy_value", 10);
  var_5 = forceexplosivedeath();
  var_6 = regulateturretrateoffire(var_5, var_3, var_4);
  ref_128b2(var_0, var_6);
}

function isstandardsandbox(var_0) {
  issmallsplashdamage();

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = 0;

    for(var_1 = 0; var_1 < 15; var_1++) {
      var_3 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var_1);
      var_2 = var_1;

      if(!var_3) {
        break;
      }
    }

    ref_12120("", undefined, "", var_2);
  }
}

function issmallsplashdamage() {
  var_0 = self getplayerdata("common", "halloweenTrickOrTreatLocations", 16);

  if(!var_0) {
    self reportchallengeuserevent("collect_item", "halloween_treat_15");
    self dlog_recordplayerevent("dlog_event_halloween_treat", ["reward_id", 15]);
    self setplayerdata("common", "halloweenTrickOrTreatLocations", 16, 1);
    return;
  }
}

function isthrowingknifeequipment() {
  for(var_0 = 0; var_0 <= 14; var_0++) {
    var_1 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var_0);

    if(!var_1) {
      var_2 = "";

      switch (var_0) {
        case 0:
          var_2 = "Mil Base";
          break;
        case 1:
          var_2 = "Boneyard";
          break;
        case 2:
          var_2 = "Dam";
          break;
        case 3:
          var_2 = "Downtown";
          break;
        case 4:
          var_2 = "Storage Town";
          break;
        case 5:
          var_2 = "Hospital";
          break;
        case 6:
          var_2 = "Layover";
          break;
        case 7:
          var_2 = "Quarry";
          break;
        case 8:
          var_2 = "Port";
          break;
        case 9:
          var_2 = "Stadium";
          break;
        case 10:
          var_2 = "Gulag";
          break;
        case 11:
          var_2 = "Lumber";
          break;
        case 12:
          var_2 = "TV Station";
          break;
        case 13:
          var_2 = "Super";
          break;
        case 14:
          var_2 = "Hills";
          break;
        default:
          var_2 = "Unkown_" + var_0;
          break;
      }

      self iprintln("Unfinished " + var_2);
    }
  }

  var_3 = self getplayerdata("common", "halloweenTrickOrTreatLocations", 16);

  if(!var_3) {
    self iprintln("Unfinished Train");
    return;
  }
}

function issmokinggun() {
  var_0 = forceexplosivedeath();

  for(var_1 = 0; var_1 < var_0 + 1; var_1++) {
    var_2 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var_1);

    if(!var_2) {
      isstunnedby(var_1);
    }
  }
}

function isstunnedby(var_0) {
  self iprintln("Finishing location " + var_0);
  self setclientomnvar("ui_halloween_event", 99);
  thread ref_12d33(10, var_0);

  if(var_0 == 14) {
    self iprintln("Final Loot award!");
    wait 3;
    cheesewedge();
    return;
  }
}

function regulateturretrateoffire(var_0, var_1, var_2) {
  var_3 = var_1 + var_2;
  self setplayerdata("common", "halloweenTrickOrTreatCandy", var_3);
  var_4 = level.setplayervargulagjail[var_0];
  var_5 = -1;

  if(var_3 >= var_4) {
    var_5 = var_0;
    return (var_5 + 1);
  }

  var_6 = -1;

  for(var_7 = 0; var_7 < level.setplunderifunchanged.size; var_7++) {
    var_8 = level.setplunderifunchanged[var_7];

    if(var_3 >= var_8 && var_1 < var_8) {
      var_6 = var_7;
    }
  }

  return (var_6 + 1) * -1;
}

function ref_12d33(var_0, var_1) {
  self setclientomnvar("ui_halloween_event", 99);
  var_2 = 0;
  var_3 = "";

  switch (var_1) {
    case 0:
      var_3 = "halloween_treat_0";
      break;
    case 1:
      var_3 = "halloween_treat_1";
      break;
    case 2:
      var_3 = "halloween_treat_2";
      break;
    case 3:
      var_3 = "halloween_treat_3";
      break;
    case 4:
      var_3 = "halloween_treat_4";
      break;
    case 5:
      var_3 = "halloween_treat_5";
      break;
    case 6:
      var_3 = "halloween_treat_6";
      break;
    case 7:
      var_3 = "halloween_treat_7";
      break;
    case 8:
      var_3 = "halloween_treat_8";
      break;
    case 9:
      var_3 = "halloween_treat_9";
      break;
    case 10:
      var_3 = "halloween_treat_10";
      break;
    case 11:
      var_3 = "halloween_treat_11";
      break;
    case 12:
      var_3 = "halloween_treat_12";
      break;
    case 13:
      var_3 = "halloween_treat_13";
      break;
    case 14:
      var_3 = "halloween_treat_14";
      break;
  }

  if(var_3 != "") {
    self reportchallengeuserevent("collect_item", var_3);
    self dlog_recordplayerevent("dlog_event_halloween_treat", ["reward_id", var_0]);
    self setplayerdata("common", "halloweenTrickOrTreatLocations", var_1, 1);
    ref_13e12();
    return;
  }
}

function ref_13e12() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 15; var_1++) {
    var_2 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var_1);
    var_0 += var_2;
    var_3 = var_1;
  }

  var_4 = self getplayerdata("common", "halloweenTrickOrTreatLocations", 16);
  var_0 += var_4;

  if(var_0 == 16) {
    wait 3;
    cheesewedge();
    return;
  }
}

function ref_12d34(var_0) {
  self setclientomnvar("ui_halloween_event", var_0 * -1);
}

function ref_12458(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(var_0)) {
    return;
  }

  var_2 = "candySmall";

  if(var_1) {
    var_2 = "candyBig";
  }

  var_3 = spawnfx(level._effect[var_2], var_0.origin + (0, 0, 10));
  var_3.angles = var_0.angles;
  wait 0.1;
  triggerfx(var_3);
}

function ref_12776(var_0) {
  level endon("game_ended");

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = spawnfx(level._effect["vfx_loot_candy_prize"], var_0.origin + (0, 0, 10));
  var_1.angles = var_0.angles;
  wait 0.1;
  triggerfx(var_1);
}

function forceexplosivedeath() {
  var_0 = 0;

  for(var_1 = 0; var_1 < 14; var_1++) {
    var_2 = self getplayerdata("common", "halloweenTrickOrTreatLocations", var_1);

    if(var_2) {
      var_0++;
    }
  }

  return var_0;
}

function isusingtacmap(var_0) {
  if(!isbot(self)) {
    self setclientomnvar("ui_halloween_event", 99);
    self reportchallengeuserevent("collect_item", "halloween_treat_" + var_0);
    self dlog_recordplayerevent("dlog_event_halloween_treat", ["reward_id", int(var_0)]);
    return;
  }
}

function isvalidanimsuiteentity(var_0) {
  if(int(var_0) < 0) {
    ref_13e19();
    return;
  }

  if(!isbot(self)) {
    self setclientomnvar("ui_halloween_event", int(var_0));
    return;
  }
}

function cheesewedge() {
  self reportchallengeuserevent("collect_item", "halloween_treat_16");
  self dlog_recordplayerevent("dlog_event_halloween_treat", ["reward_id", 16]);
}