/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_accessories.gsc
***********************************************/

init() {
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
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_924316FB50D510A69F5A6B93022363709EDA7153A6AEF874", var_0, 0);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tablelookup("_encstr_968317A04A15C3311D1833E2CDD030E923911E09E22EF99B35", 2, var_1, 3);

    if(isDefined(var_2) && var_2 != "_encstr_B40101" && var_2 != "_encstr_B21904D2EE0E") {
      var_0++;
      continue;
    }

    var_3 = tablelookupbyrow("_encstr_924316FB50D510A69F5A6B93022363709EDA7153A6AEF874", var_0, 1);

    if(!isDefined(var_3) || var_3 == "_encstr_B40101") {
      var_0++;
      continue;
    }

    var_4 = tablelookupbyrow("_encstr_924316FB50D510A69F5A6B93022363709EDA7153A6AEF874", var_0, 2);

    if(!isDefined(var_4) || var_4 == "_encstr_B40101") {
      var_0++;
      continue;
    }

    var_5 = tablelookupbyrow("_encstr_924316FB50D510A69F5A6B93022363709EDA7153A6AEF874", var_0, 3);

    if(isDefined(var_5) && var_5 == "_encstr_B40101")
      var_5 = undefined;

    var_6 = int(tablelookupbyrow("_encstr_924316FB50D510A69F5A6B93022363709EDA7153A6AEF874", var_0, 10));

    if(isDefined(var_6))
      level.accessoryinfobyindex[var_6] = var_3;

    var_7 = tablelookupbyrow("_encstr_924316FB50D510A69F5A6B93022363709EDA7153A6AEF874", var_0, 15);

    if(var_7 != "_encstr_B40101") {
      level.accessorylogic[var_1] = var_7;
      level.armsrace_c4_charge_detonate_think[var_6] = var_7;
    }

    var_8 = tablelookupbyrow("_encstr_924316FB50D510A69F5A6B93022363709EDA7153A6AEF874", var_0, 17);

    if(var_8 != "_encstr_B40101")
      level.arms2think[var_4] = var_8;

    var_9 = tablelookupbyrow("_encstr_924316FB50D510A69F5A6B93022363709EDA7153A6AEF874", var_0, 18);

    if(var_9 != "_encstr_B40101")
      level.arms_race_p1[var_4] = var_9;

    var_10 = tablelookupbyrow("_encstr_924316FB50D510A69F5A6B93022363709EDA7153A6AEF874", var_0, 16);

    if(var_10 != "_encstr_B40101")
      level.arms4think[var_4] = var_10;

    var_11 = tablelookupbyrow("_encstr_924316FB50D510A69F5A6B93022363709EDA7153A6AEF874", var_0, 21);

    if(var_11 != "_encstr_B40101")
      level.armsdealer_loadout_interaction[var_4] = var_11;

    level.accessoryinfo[var_1] = var_3;
    level.accessoryattachment[var_1] = var_5;

    if(var_10 != "_encstr_B40101") {
      if(isDefined(var_5) && var_5 != "_encstr_B40101") {
        level.accessoryfullweapon[var_1] = var_4 + "_encstr_BE4C0295" + var_10 + "_encstr_BE4C0295" + var_5;
        level.accessoryweaponbyindex[var_6] = var_4 + "_encstr_BE4C0295" + var_10 + "_encstr_BE4C0295" + var_5;
      } else {
        level.accessoryfullweapon[var_1] = var_4 + "_encstr_BE4C0295" + var_10;
        level.accessoryweaponbyindex[var_6] = var_4 + "_encstr_BE4C0295" + var_10;
      }
    } else if(isDefined(var_5) && var_5 != "_encstr_B40101") {
      level.accessoryfullweapon[var_1] = var_4 + "_encstr_BE4C0295" + var_5;
      level.accessoryweaponbyindex[var_6] = var_4 + "_encstr_BE4C0295" + var_5;
    } else {
      level.accessoryfullweapon[var_1] = var_4;
      level.accessoryweaponbyindex[var_6] = var_4;
    }

    var_0++;
  }

  thread scripts\cp_mp\pet_watch::init();
}

getaccessorylogic(var_0) {
  return level.accessorylogic[var_0];
}

getaccessorydata(var_0) {
  return level.accessoryinfo[var_0];
}

getaccessoryweapon(var_0) {
  return level.accessoryfullweapon[var_0];
}

getaccessoryweaponbyindex(var_0) {
  if(isDefined(level.accessoryweaponbyindex))
    return level.accessoryweaponbyindex[var_0];

  return "_encstr_8BBA05185F8B99";
}

getaccessorydatabyindex(var_0) {
  if(isDefined(level.accessoryinfobyindex))
    return level.accessoryinfobyindex[var_0];

  return "_encstr_8BBA05185F8B99";
}

register_respawn_functions(var_0) {
  if(isDefined(level.armsrace_c4_charge_detonate_think))
    return level.armsrace_c4_charge_detonate_think[var_0];

  return "_encstr_8BBA05185F8B99";
}

giveplayeraccessory(var_0, var_1, var_2) {
  clearplayeraccessory();
  var_3 = resettimeronkill(var_1);

  if(!isDefined(var_3)) {
    return;
  }
  self.accessorydata = var_0;
  self.accessoryfullweapon = var_3;
  self.accessorylogic = var_2;
  var_4 = _id_1330D();
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self.accessoryfullweapon);
  self giveaccessory(self.accessorydata, self.accessoryfullweapon, var_4);

  if(isDefined(var_2)) {
    switch (var_2) {
      case "_encstr_AC190471F593":
      case "_encstr_A7730AAB40E32F3393461E55":
      case "_encstr_A1270A78AAE3BF49BB71A6AA":
        scripts\cp_mp\pet_watch::initpet(0, var_2);
        break;
      case "_encstr_A2820A33B8B9EADB6515F6AB":
        break;
      case "_encstr_8BE50C397382EEB08FBD417BA77A":
        tower_ground_mortar_2();
        break;
      case "_encstr_BACC05C9770D68":
        scripts\cp_mp\gestures::_id_13850();
        break;
      case "_encstr_877A067A5714507E":
        scripts\cp_mp\gestures::_id_13851();
        break;
      default:
        break;
    }
  }

  if(isDefined(self.suit) && self.suit == "_encstr_AB6C0C1784D2171608824D4727A0")
    thread scripts\cp_mp\gestures::_id_13E1A();
}

_id_1330D() {
  var_0 = scripts\cp\survival\survival_loadout::getcustomization();
  var_1 = var_0["_encstr_AD9B0589ED9197"];
  var_2 = tablelookup("_encstr_8EB912CDAFC7AAC1C9D23B07E0E0BDD3AD4ED283", 1, var_1, 22);
  return isDefined(var_2) && var_2 == "_encstr_A34C02BB";
}

resettimeronkill(var_0) {
  var_1 = scripts\cp\survival\survival_loadout::getcustomization();
  var_2 = var_1["_encstr_AD9B0589ED9197"];
  var_3 = tablelookup("_encstr_8EB912CDAFC7AAC1C9D23B07E0E0BDD3AD4ED283", 1, var_2, 23);

  if(isDefined(var_3)) {
    switch (var_3) {
      case "_encstr_8D1804CC95B5":
        var_4 = level.arms_race_p1[var_0];
        var_5 = level.arms1think[var_0];

        if(isDefined(var_4)) {
          var_0 = var_0 + var_4;

          if(isDefined(var_5))
            var_0 = var_0 + var_5;
        }

        break;
      case "_encstr_B61904314BB3":
        var_6 = level.arms2think[var_0];

        if(isDefined(var_6))
          var_0 = var_0 + var_6;

        break;
      case "_encstr_BECC055CF3811A":
        var_0 = undefined;
        break;
    }
  }

  if(isDefined(var_0)) {
    var_7 = level.accessoryattachment[var_0];

    if(isDefined(var_7))
      var_0 = var_0 + var_7;
  }

  return var_0;
}

clearplayeraccessory() {
  self clearaccessory();

  if(isDefined(self.accessoryfullweapon) && self.accessoryfullweapon != "_encstr_8BBA05185F8B99") {
    if(self hasweapon(self.accessoryfullweapon))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.accessoryfullweapon);

    self.gestureweapon = "_encstr_8BBA05185F8B99";
  }
}

tower_ground_mortar_2() {
  if(!isDefined(self._id_13B2D)) {
    self._id_13B2D = 1;
    var_0 = removeriotshield();
    self setclientomnvar("_encstr_A14D13F3CA276F785317AFFB44FE58A0CFB3C95B92", var_0);
  }
}

removeriotshield() {
  switch (level.mapname) {
    case "_encstr_ACFA0BB7B381457BEEDF03FB44":
      return 74;
    case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
      return 81;
    case "_encstr_BDFF088922C9FF1946BF":
      return 80;
    case "_encstr_99020BB0027F38974BA78783FF":
      return 40;
    case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
      return 36;
    case "_encstr_A6640D9D1109AF2FC7082B029395FF":
      return 95;
    case "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0":
      return 49;
    case "_encstr_86570E71DA311191DB1FD8887FCFA9A3":
      return 30;
    case "_encstr_BA4D0DED61799A1FB5DB6AD2E30753":
      return 35;
    case "_encstr_B4870E0751AFABC1B8F1CE97A8181CF3":
      return 55;
    case "_encstr_A3890850E25F90B79A83":
      return 65;
    case "_encstr_B6EE0A72AB0863F3C065A5BA":
      return 50;
    case "_encstr_91B90DB6E0D7935D9B7356C9AF0EAD":
      return 42;
    case "_encstr_AB5D0960CBB77E40E7D955":
      return 92;
    case "_encstr_8E940C29F87032C3FF82F50F725A":
      return 82;
    case "_encstr_A2200CDA13D6CBC897E1A0EBAA93":
      return 100;
    case "_encstr_85940FDDBF375ACF39582F1B18D3A1223D":
      return 80;
    case "_encstr_8A8F0ABBA391D191182CF008":
      return 54;
    case "_encstr_9A8F0AB5C1BED6D734EDBD5B":
      return 64;
    case "_encstr_A6990AD8730FD991BC09859F":
      return 68;
    case "_encstr_A25C0D5833E1E3D6EF2178E43FABD8":
      return 68;
    case "_encstr_AA160FAD077DB6FA7B9D2B9CBAE62359C9":
      return 72;
    case "_encstr_AAD50ADAE0D7ADAF385ADC59":
      return 88;
    case "_encstr_9B8808AD1CD7E457DC1D":
      return 90;
    case "_encstr_A5110B50E25F68A83BD3D3EBBB":
      return 72;
    case "_encstr_8E020FABE7B9F00F4EC0F83381FDDA9004":
      return 79;
    case "_encstr_8C340BB60EBE5BD7373A85B1D6":
      return 65;
    case "_encstr_8FD60D2D6829B511E32BDF83200323":
      return 38;
    case "_encstr_8C180B57600E8519374762DFB8":
      return 68;
    case "_encstr_92580A9FC988F27F1B39D75F":
      return 96;
    case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
      return 57;
    case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
      return 60;
    case "_encstr_93D20D28714743B99070632BAF3944":
      return 78;
    case "_encstr_99D9106DE1F95D77B8DB4A03C383FB53708D":
      return 12;
    case "_encstr_86F10B5BE0F507DB271DBECEEE":
      return 79;
    case "_encstr_9B2D0A451FCEFB46DF18EA43":
      return 80;
    case "_encstr_9B720C87D1806B4D50B14D57C858":
      return 55;
    case "_encstr_83970EDA1CFAC2E65AF21686BE47C28D":
      return 81;
    default:
      return 68;
  }
}