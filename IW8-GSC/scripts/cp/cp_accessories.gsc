/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_accessories.gsc
***********************************************/

function init() {
  level.accessoryinfo = [];
  level.accessoryinfobyindex = [];
  level.armsrace_c4_charge_detonate_think = [];
  level.accessoryattachment = [];
  level.accessorylogic = [];
  level.accessoryfullweapon = [];
  level.accessoryweaponbyindex = [];
  level.arms2think = [];
  level.arms_race_p1 = [];
  level.arms1think = [];
  level.arms4think = [];

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/accessorytable.csv", var0, 0);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var2 = tablelookup("mp/itemsourcetable.csv", 2, var1, 3);

    if(isDefined(var2) && var2 != "" && var2 != "iw8") {
      var0++;
      continue;
    }

    var3 = tablelookupbyrow("mp/accessorytable.csv", var0, 1);

    if(!isDefined(var3) || var3 == "") {
      var0++;
      continue;
    }

    var4 = tablelookupbyrow("mp/accessorytable.csv", var0, 2);

    if(!isDefined(var4) || var4 == "") {
      var0++;
      continue;
    }

    var5 = tablelookupbyrow("mp/accessorytable.csv", var0, 3);

    if(isDefined(var5) && var5 == "") {
      var5 = undefined;
    }

    var6 = int(tablelookupbyrow("mp/accessorytable.csv", var0, 10));

    if(isDefined(var6)) {
      level.accessoryinfobyindex[var6] = var3;
    }

    var7 = tablelookupbyrow("mp/accessorytable.csv", var0, 15);

    if(var7 != "") {
      level.accessorylogic[var1] = var7;
      level.armsrace_c4_charge_detonate_think[var6] = var7;
    }

    var8 = tablelookupbyrow("mp/accessorytable.csv", var0, 17);

    if(var8 != "") {
      level.arms2think[var4] = var8;
    }

    var9 = tablelookupbyrow("mp/accessorytable.csv", var0, 18);

    if(var9 != "") {
      level.arms_race_p1[var4] = var9;
    }

    var10 = tablelookupbyrow("mp/accessorytable.csv", var0, 16);

    if(var10 != "") {
      level.arms4think[var4] = var10;
    }

    var11 = tablelookupbyrow("mp/accessorytable.csv", var0, 21);

    if(var11 != "") {
      level.armsdealer_loadout_interaction[var4] = var11;
    }

    level.accessoryinfo[var1] = var3;
    level.accessoryattachment[var1] = var5;

    if(var10 != "") {
      if(isDefined(var5) && var5 != "") {
        level.accessoryfullweapon[var1] = var4 + "+" + var10 + "+" + var5;
        level.accessoryweaponbyindex[var6] = var4 + "+" + var10 + "+" + var5;
      } else {
        level.accessoryfullweapon[var1] = var4 + "+" + var10;
        level.accessoryweaponbyindex[var6] = var4 + "+" + var10;
      }

      continue;
    }

    if(isDefined(var5) && var5 != "") {
      level.accessoryfullweapon[var1] = var4 + "+" + var5;
      level.accessoryweaponbyindex[var6] = var4 + "+" + var5;
      continue;
    }

    level.accessoryfullweapon[var1] = var4;
    level.accessoryweaponbyindex[var6] = var4;
  }

  thread scripts\cp_mp\pet_watch::init();
}

function getaccessorylogic(var0) {
  return level.accessorylogic[var0];
}

function getaccessorydata(var0) {
  return level.accessoryinfo[var0];
}

function getaccessoryweapon(var0) {
  return level.accessoryfullweapon[var0];
}

function getaccessoryweaponbyindex(var0) {
  if(isDefined(level.accessoryweaponbyindex)) {
    return level.accessoryweaponbyindex[var0];
  }

  return "none";
}

function getaccessorydatabyindex(var0) {
  if(isDefined(level.accessoryinfobyindex)) {
    return level.accessoryinfobyindex[var0];
  }

  return "none";
}

function register_respawn_functions(var0) {
  if(isDefined(level.armsrace_c4_charge_detonate_think)) {
    return level.armsrace_c4_charge_detonate_think[var0];
  }

  return "none";
}

function giveplayeraccessory(var0, var1, var2) {
  clearplayeraccessory();
  var3 = resettimeronkill(var1);

  if(!isDefined(var3)) {
    return;
  }

  self.accessorydata = var0;
  self.accessoryfullweapon = var3;
  self.accessorylogic = var2;
  var4 = ref_1330d();
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.accessoryfullweapon);
  self giveaccessory(self.accessorydata, self.accessoryfullweapon, var4);

  if(isDefined(var2)) {
    switch (var2) {
      case "pet":
      case "pet_turbo":
      case "pet_black":
        scripts\cp_mp\pet_watch::initpet(0, var2);
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
      default:
        break;
    }
  }

  if(isDefined(self.suit) && self.suit == "iw8_suit_cp") {
    thread scripts\cp_mp\gestures::ref_13e1a();
    return;
  }
}

function ref_1330d() {
  var0 = scripts\cp\survival\survival_loadout::getcustomization();
  var1 = var0["body"];
  var2 = tablelookup("mp/cac/bodies.csv", 1, var1, 22);
  return isDefined(var2) && var2 == "1";
}

function resettimeronkill(var0) {
  var1 = scripts\cp\survival\survival_loadout::getcustomization();
  var2 = var1["body"];
  var3 = tablelookup("mp/cac/bodies.csv", 1, var2, 23);

  if(isDefined(var3)) {
    switch (var3) {
      case "fem":
        var4 = level.arms_race_p1[var0];
        var5 = level.arms1think[var0];

        if(isDefined(var4)) {
          var0 += var4;

          if(isDefined(var5)) {
            var0 += var5;
          }
        }

        break;
      case "big":
        var6 = level.arms2think[var0];

        if(isDefined(var6)) {
          var0 += var6;
        }

        break;
      case "hide":
        var0 = undefined;
        break;
    }
  }

  if(isDefined(var0)) {
    var7 = level.accessoryattachment[var0];

    if(isDefined(var7)) {
      var0 += var7;
    }
  }

  return var0;
}

function clearplayeraccessory() {
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
  if(!isDefined(self.ref_13b2d)) {
    self.ref_13b2d = 1;
    var0 = removeriotshield();
    self setclientomnvar("ui_pet_watch_state", var0);
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