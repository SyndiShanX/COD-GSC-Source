/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\accessories.gsc
***********************************************/

function init() {
  level.accessoryinfo = [];
  level.accessoryinfobyindex = [];
  level.armsrace_c4_charge_detonate_think = [];
  level.armsrace_c4_charge_think = [];
  level.accessoryattachment = [];
  level.accessorylogic = [];
  level.accessoryfullweapon = [];
  level.accessoryweaponbyindex = [];
  level.arms2think = [];
  level.arms_race_p1 = [];
  level.arms4think = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/accessorytable.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/accessorytable.csv", var_0, 1);

    if(!isDefined(var_2) || var_2 == "") {
      var_0++;
      continue;
    }

    var_3 = tablelookupbyrow("mp/accessorytable.csv", var_0, 2);

    if(!isDefined(var_3) || var_3 == "") {
      var_0++;
      continue;
    }

    var_4 = tablelookupbyrow("mp/accessorytable.csv", var_0, 3);

    if(isDefined(var_4) && var_4 == "") {
      var_4 = undefined;
    }

    var_5 = int(tablelookupbyrow("mp/accessorytable.csv", var_0, 10));

    if(isDefined(var_5)) {
      level.accessoryinfobyindex[var_5] = var_2;
    }

    var_6 = tablelookupbyrow("mp/accessorytable.csv", var_0, 15);

    if(var_6 != "") {
      level.accessorylogic[var_1] = var_6;
      level.armsrace_c4_charge_detonate_think[var_5] = var_6;
    }

    var_7 = tablelookupbyrow("mp/accessorytable.csv", var_0, 16);

    if(var_7 != "") {
      level.arms4think[var_3] = var_7;
    }

    var_8 = tablelookupbyrow("mp/accessorytable.csv", var_0, 17);

    if(var_8 != "" && var_7 != "") {
      if(isDefined(var_4) && var_4 != "") {
        var_9 = tablelookupbyrow("mp/accessorytable.csv", var_0, 19);

        if(var_9 != "") {
          level.arms2think[var_3 + "+" + var_7 + "+" + var_4] = var_3 + "+" + var_8 + "+" + var_9;
        } else {
          level.arms2think[var_3 + "+" + var_7 + "+" + var_4] = var_3 + "+" + var_8;
        }
      } else {
        level.arms2think[var_3 + "+" + var_7] = var_3 + "+" + var_8;
      }
    }

    var_10 = tablelookupbyrow("mp/accessorytable.csv", var_0, 18);

    if(var_10 != "" && var_7 != "") {
      if(isDefined(var_4) && var_4 != "") {
        var_11 = tablelookupbyrow("mp/accessorytable.csv", var_0, 21);

        if(var_11 != "") {
          level.arms_race_p1[var_3 + "+" + var_7 + "+" + var_4] = var_3 + "+" + var_10 + "+" + var_11;
        } else {
          level.arms_race_p1[var_3 + "+" + var_7 + "+" + var_4] = var_3 + "+" + var_10;
        }
      } else {
        level.arms_race_p1[var_3 + "+" + var_7] = var_3 + "+" + var_10;
      }
    }

    var_12 = scripts\engine\utility::multitablelookup(["mp/itemsourcetable.csv", "mp/itemsourcetable_ch2.csv"], 2, var_1, 3);

    if(var_12 != "") {
      level.armsrace_c4_charge_think[var_2] = var_12;
    }

    level.accessoryinfo[var_1] = var_2;
    level.accessoryattachment[var_1] = var_4;

    if(var_7 != "") {
      if(isDefined(var_4) && var_4 != "") {
        level.accessoryfullweapon[var_1] = var_3 + "+" + var_7 + "+" + var_4;
        level.accessoryweaponbyindex[var_5] = var_3 + "+" + var_7 + "+" + var_4;
      } else {
        level.accessoryfullweapon[var_1] = var_3 + "+" + var_7;
        level.accessoryweaponbyindex[var_5] = var_3 + "+" + var_7;
      }

      continue;
    }

    if(isDefined(var_4) && var_4 != "") {
      level.accessoryfullweapon[var_1] = var_3 + "+" + var_4;
      level.accessoryweaponbyindex[var_5] = var_3 + "+" + var_4;
      continue;
    }

    level.accessoryfullweapon[var_1] = var_3;
    level.accessoryweaponbyindex[var_5] = var_3;
  }

  thread scripts\cp_mp\pet_watch::init();
  thread scripts\cp_mp\utility\callback_group::init();
}

function getaccessorylogic(var_0) {
  if(!isDefined(level.accessorylogic)) {
    return undefined;
  }

  return level.accessorylogic[var_0];
}

function getaccessorydata(var_0) {
  if(!isDefined(level.accessoryinfo)) {
    return undefined;
  }

  return level.accessoryinfo[var_0];
}

function getaccessoryweapon(var_0) {
  if(!isDefined(level.accessoryfullweapon)) {
    return undefined;
  }

  return level.accessoryfullweapon[var_0];
}

function getaccessoryweaponbyindex(var_0) {
  if(isDefined(level.accessoryweaponbyindex)) {
    return level.accessoryweaponbyindex[var_0];
  }

  return "none";
}

function getaccessorydatabyindex(var_0) {
  if(isDefined(level.accessoryinfobyindex)) {
    return level.accessoryinfobyindex[var_0];
  }

  return "none";
}

function register_respawn_functions(var_0) {
  if(isDefined(level.armsrace_c4_charge_detonate_think)) {
    return level.armsrace_c4_charge_detonate_think[var_0];
  }

  return "none";
}

function register_script_model_animation(var_0) {
  if(isDefined(level.armsrace_c4_charge_think)) {
    return level.armsrace_c4_charge_think[var_0];
  }

  return undefined;
}

function giveplayeraccessory(var_0, var_1, var_2) {
  clearplayeraccessory();
  var_3 = resettimeronkill(var_1);

  if(!isDefined(var_3)) {
    return;
  }

  if(scripts\mp\gametypes\br_public::ref_125EC()) {
    return;
  }

  self.accessorydata = var_0;
  self.accessorylogic = var_2;
  self.accessoryfullweapon = var_3;
  var_4 = ref_1330D();
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.accessoryfullweapon);
  self giveaccessory(self.accessorydata, self.accessoryfullweapon, var_4);

  if(isDefined(var_2)) {
    switch (var_2) {
      case "pet":
      case "pet_turbo":
      case "pet_black":
        scripts\cp_mp\pet_watch::initpet(0, var_2);
        break;
      case "pet_go":
        scripts\cp_mp\utility\callback_group::initpet(0);
        break;
      case "heartbeat":
        break;
      case "thermometer":
        tower_ground_mortar_2();
        break;
      case "holo":
        scripts\cp_mp\gestures::ref_13850();
        break;
      case "holo2":
        scripts\cp_mp\gestures::ref_13851();
        break;
      case "holo3":
        scripts\cp_mp\gestures::ref_13852();
        break;
      default:
        break;
    }

    return;
  }
}

function ref_1330D() {
  var_0 = scripts\mp\teams::getcustomization();
  var_1 = var_0["body"];
  var_2 = tablelookup("mp/cac/bodies.csv", 1, var_1, 22);
  return isDefined(var_2) && var_2 == "1";
}

function resettimeronkill(var_0) {
  var_1 = scripts\mp\teams::getcustomization();
  var_2 = var_1["body"];
  var_3 = tablelookup("mp/cac/bodies.csv", 1, var_2, 23);

  if(isDefined(var_3)) {
    switch (var_3) {
      case "fem":
        var_4 = level.arms_race_p1[var_0];

        if(isDefined(var_4)) {
          var_0 = var_4;
        }

        break;
      case "big":
        var_5 = level.arms2think[var_0];

        if(isDefined(var_5)) {
          var_0 = var_5;
        }

        break;
      case "hide":
        var_0 = undefined;
        break;
    }
  }

  if(isDefined(var_0)) {
    var_6 = level.accessoryattachment[var_0];

    if(isDefined(var_6)) {
      var_0 += var_6;
    }
  }

  return var_0;
}

function ref_13B0A(var_0) {
  if(var_0 == 1) {
    scripts\cp_mp\gestures::ref_13838();
    return;
  }

  if(var_0 == 2) {
    self setscriptablepartstate("watchVFXPlayer", "goWatchOn");
    return;
  }
}

function clearplayeraccessory() {
  if(!isDefined(self)) {
    return;
  }

  self clearaccessory();

  if(isDefined(self.accessoryfullweapon) && self.accessoryfullweapon != "none") {
    if(self hasweapon(self.accessoryfullweapon)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.accessoryfullweapon);
    }

    self.gestureweapon = "none";
    return;
  }
}

function tower_ground_mortar_2() {
  if(!isDefined(self.ref_13B2D)) {
    self.ref_13B2D = 1;
    var_0 = removeriotshield();
    self setclientomnvar("ui_pet_watch_state", var_0);
    return;
  }
}

function removeriotshield() {
  switch (level.mapname) {
    case "cp_donetsk":
      return 74;
    case "mp_aniyah":
      return 81;
    case "mp_cave":
      return 80;
    case "mp_cave_am":
      return 40;
    case "mp_deadzone":
      return 36;
    case "mp_euphrates":
      return 95;
    case "mp_hackney_yard":
      return 49;
    case "mp_hackney_am":
      return 30;
    case "mp_petrograd":
      return 35;
    case "mp_piccadilly":
      return 55;
    case "mp_raid":
      return 65;
    case "mp_runner":
      return 50;
    case "mp_runner_pm":
      return 42;
    case "mp_spear":
      return 92;
    case "mp_spear_pm":
      return 82;
    case "mp_shipment":
      return 100;
    case "mp_m_exclusion":
      return 80;
    case "mp_m_hill":
      return 54;
    case "mp_m_hook":
      return 64;
    case "mp_m_king":
      return 68;
    case "mp_m_king_pm":
      return 68;
    case "mp_m_overunder":
      return 72;
    case "mp_m_pine":
      return 88;
    case "mp_rust":
      return 90;
    case "mp_m_speed":
      return 72;
    case "mp_m_speedball":
      return 79;
    case "mp_m_stack":
      return 65;
    case "mp_m_showers":
      return 38;
    case "mp_m_cargo":
      return 68;
    case "mp_m_cage":
      return 96;
    case "mp_quarry2":
      return 57;
    case "mp_downtown_gw":
      return 60;
    case "mp_farms2_gw":
      return 78;
    case "mp_m_overwinter":
      return 12;
    case "mp_port_gw":
      return 79;
    case "mp_vacant":
      return 80;
    case "mp_tenement":
      return 55;
    case "mp_aniyah_tac":
      return 81;
    default:
      return 68;
  }
}