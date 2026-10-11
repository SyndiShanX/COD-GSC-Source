/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_armory_kiosk.gsc
*******************************************************/

#using script_15ca41a3fbb0e379;
#using script_263974019a8ba3fa;
#using script_2d9d24f7c63ac143;
#using script_342e51952b63e594;
#using script_3583ff375ab3a91e;
#using script_5307834cd39b435c;
#using script_55e418c5cc946593;
#using script_5bab271917698dc4;
#using script_64acb6ce534155b7;
#using script_67cc94c07ab18d3a;
#using script_744cad313ed0a87e;
#using script_b7a9ce0a2282b79;
#using scripts\common\ae_utility;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\structspawnconfig;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_airdrop;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\killstreaks\emp;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_dom_gulag;
#using scripts\mp\gametypes\br_extract_quest;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametype_truckwar;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\killstreaks\mapselect;
#using scripts\mp\menus;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\supers;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\trigger;
#namespace br_armory_kiosk;

function init() {
  level.br_armory_kiosk = spawnStruct();
  level.br_armory_kiosk.scriptables = [];
  level.br_armory_kiosk_enabled = getdvarint(@ "scr_br_armory_kiosk", 1) != 0;
  level.var_11a3973390a71e8 = getDvar(@ "br_buy_station", "purchases");
  level.var_8dea6607b3189a60 = getdvarint(@ "hash_32c09327627c883c", 0);
  level.var_77e4add813fca6ae = getdvarint(@ "hash_e024cf932ef753dc", 0);
  level.var_f38c74334d6ff472 = getdvarint(@ "scr_br_kiosk_perk_package_enabled", 0);
  level.br_armory_kiosk.var_aaa31c1e28a5663c = getdvarint(@ "hash_95d75e4aac93c20d", 0);
  level.br_armory_kiosk.var_da1e0a23728ec36 = getdvarint(@ "hash_650073c7a7222ae2", 138);
  level.var_ee08b1f41e7c2444 = ismagellanmode();
  level.var_e7cee4fbb5b46ef2 = scripts\cp_mp\utility\loot::function_54b046aa3ba2678a(level.var_11a3973390a71e8);

  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("kiosk")) {
    level.br_armory_kiosk_enabled = 0;
    return;
  }

  if(level.br_armory_kiosk_enabled) {
    function_665291fdc0b65758();
    scripts\engine\scriptable::scriptable_addusedcallback(&armorykioskused);
    scripts\engine\scriptable::scriptable_addautousecallback(&armorykioskused);
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&onarmorykioskpurchase);
    thread function_28d7437a275a45c7();
    level.var_d03e6ba38b56b4ab = getdvarint(@ "hash_e77ab3a32453ae92", 1);
    level.var_e9f7702d839b262c = getdvarint(@ "hash_624b1f6964c696d", 180);
    level.randomanglemax = getdvarint(@ "hash_69c62cae4d7929c9", 10);
    level.var_fb60f0244999d528 = getdvarint(@ "hash_9c3612143e0ad401", 1);
    level.var_8b92cb4447668562 = getdvarint(@ "hash_1b89015decb21663", 1) == 1;
    _initsalesdiscount();
    _parsepurchaseitemtables();
    function_6f3bd3113a48f7b7();
    function_3e6ddd0ae062ac75();
    level thread _watchforcircleclosure();

    level thread function_54fdd9330a3bed3e();

    level.var_a4078546548cb0a = &function_a4078546548cb0a;
    level.var_4fecf02c9241f7f0 = &function_4fecf02c9241f7f0;
    scripts\mp\gametypes\br_circle::registercirclecallbacks(4, &dangercircletick, &function_1a1709943670772a, &function_d9a3848f71c7c63a, &disableallarmorykiosks);
    flag_set("br_armory_kiosk_initialized");
  }
}

function function_28d7437a275a45c7() {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("ssc_initialized");
  scripts\cp_mp\structspawnconfig::function_4f7660cfd85cd517("buy_station", &function_e6c1c35181a2870f);
  scripts\cp_mp\structspawnconfig::function_412f527ef0863f0e("buy_station", &function_53542c92143aa5eb);
  scripts\cp_mp\structspawnconfig::function_eded5b87f8f7bdfd("buy_station", &function_86f5339f1334e16);
}

function function_b38f5ffe645943c3(stationref) {
  setDvar(@ "br_buy_station", stationref);
  level.var_e7cee4fbb5b46ef2 = scripts\cp_mp\utility\loot::function_54b046aa3ba2678a(stationref);

  if(!isDefined(level.var_6be7b375ec4a629c)) {
    level.var_6be7b375ec4a629c = [];
  }

  buystations = utility::array_combine(level.var_6be7b375ec4a629c, level.var_4531798404d47e45);

  foreach(var_eb7139726cc569b5 in buystations) {
    if(var_eb7139726cc569b5["index"] == level.var_e7cee4fbb5b46ef2) {
      return;
    }
  }

  level.var_6be7b375ec4a629c[level.var_6be7b375ec4a629c.size] = function_d84cdb7463425ba(stationref);
}

function _initsalesdiscount() {
  var_db834d1cac99ea96 = getdvarint(@ "br_kiosk_sales_discount", 0);
  level.br_armory_kiosk.sales_discount = int(clamp(var_db834d1cac99ea96, 0, 100));
  var_bc97c6f634d832a0 = getDvar(@ "hash_68eb502c50f9a22", "");
  level.br_armory_kiosk.sales_discount_items = strtok(var_bc97c6f634d832a0, ",");
  var_997f4424a87b464e = 20;
  var_f587fa837f6bf48f = level.br_armory_kiosk.sales_discount % var_997f4424a87b464e;

  if(var_f587fa837f6bf48f > 0) {
    var_9a7512c4544fd449 = int(floor(level.br_armory_kiosk.sales_discount / var_997f4424a87b464e) * var_997f4424a87b464e);
    var_50c417a2a6400d = var_f587fa837f6bf48f / var_997f4424a87b464e >= 0.5;

    if(var_50c417a2a6400d) {
      var_9a7512c4544fd449 += var_997f4424a87b464e;
    }

    level.br_armory_kiosk.sales_discount = int(var_9a7512c4544fd449);
  }

  if(var_db834d1cac99ea96 != level.br_armory_kiosk.sales_discount) {
    setDvar(@ "br_kiosk_sales_discount", level.br_armory_kiosk.sales_discount);
    assertmsg("<dev string:x1c>" + var_db834d1cac99ea96 + "<dev string:x3f>" + level.br_armory_kiosk.sales_discount + "<dev string:x6d>");
  }
}

function _applysalesdiscount(originalprice, discount) {
  if(!isDefined(discount) || discount == 0) {
    return originalprice;
  } else if(discount == 100) {
    return 0;
  }

  fraction = (100 - discount) * 0.01;
  return int(floor(originalprice * fraction + 0.5));
}

function function_a0389e3244a68894(kiosk, var_cf9d634ef87d898b) {
  var_dc5ca81f164df863 = function_879d297885591207(kiosk);

  if(!isDefined(var_dc5ca81f164df863)) {
    var_dc5ca81f164df863 = level.var_e7cee4fbb5b46ef2;
  }

  var_8e9c7fc5d7cdc62b = function_2a50f66eb0ec8756(kiosk);

  if(!isDefined(var_dc5ca81f164df863)) {
    var_8e9c7fc5d7cdc62b = level.var_e7cee4fbb5b46ef2;
  }

  allbuys = array_combine(level.var_6be7b375ec4a629c, level.var_4531798404d47e45);

  foreach(var_eb7139726cc569b5 in allbuys) {
    if(var_eb7139726cc569b5["index"] == var_dc5ca81f164df863) {
      var_b0f4dcc20c3b0c76 = var_eb7139726cc569b5["items"];

      if(isDefined(var_b0f4dcc20c3b0c76[var_cf9d634ef87d898b])) {
        return true;
      }

      break;
    }
  }

  foreach(weapondata in level.var_3899105ceec08fb8) {
    if(weapondata["index"] == var_8e9c7fc5d7cdc62b) {
      weaponitemdata = weapondata["items"];

      if(isDefined(weaponitemdata[var_cf9d634ef87d898b])) {
        return true;
      }

      break;
    }
  }

  return false;
}

function function_a83ac2899e1fe5eb(kiosk) {
  if(getdvarint(@ "hash_8bd31284e87b0865", 1) == 0) {
    return false;
  }

  if(!isDefined(kiosk) || !isDefined(kiosk.index)) {
    return false;
  }

  if(getdvarint(@ "hash_5f15a3e117466c52", 0) == 1) {
    kiosk.overrideindex = undefined;
    kiosk.var_ded92ccb217bbaeb = undefined;
  }

  var_d584af5cdd0345d8 = getsystemtime();

  if(!isDefined(kiosk.overrideindex) && isDefined(level.var_6be7b375ec4a629c) && level.var_6be7b375ec4a629c.size > 0) {
    var_dc5ca81f164df863 = (kiosk.index + var_d584af5cdd0345d8) % level.var_6be7b375ec4a629c.size;
    var_b25a062b16392edd = level.var_6be7b375ec4a629c[var_dc5ca81f164df863];
    kiosk.overrideindex = var_b25a062b16392edd["index"];
  }

  if(!isDefined(kiosk.var_ded92ccb217bbaeb) && isDefined(level.var_3899105ceec08fb8) && level.var_3899105ceec08fb8.size > 0) {
    var_2d4419c241fcb284 = (kiosk.index + var_d584af5cdd0345d8) % level.var_3899105ceec08fb8.size;
    var_aba76bfe006a0128 = level.var_3899105ceec08fb8[var_2d4419c241fcb284];
    kiosk.var_ded92ccb217bbaeb = var_aba76bfe006a0128["index"];
  }

  return true;
}

function function_879d297885591207(kiosk) {
  if(!function_a83ac2899e1fe5eb(kiosk)) {
    return undefined;
  }

  found = 0;
  buystations = utility::array_combine(level.var_6be7b375ec4a629c, level.var_4531798404d47e45);

  foreach(var_eb7139726cc569b5 in buystations) {
    if(var_eb7139726cc569b5["index"] == kiosk.overrideindex) {
      found = 1;
      break;
    }
  }

  if(!found) {
    function_ad499107951c0a81(kiosk.overrideindex);
  }

  return kiosk.overrideindex;
}

function function_2a50f66eb0ec8756(kiosk) {
  if(!function_a83ac2899e1fe5eb(kiosk)) {
    return undefined;
  }

  return kiosk.var_ded92ccb217bbaeb;
}

function function_ac84b48bb39d674f(kiosk) {
  if(getdvarint(@ "hash_b0634929cd39973b", 1) == 0) {
    return false;
  }

  if(!isDefined(kiosk) || !isDefined(kiosk.index)) {
    return false;
  }

  if(!isDefined(level.var_6be7b375ec4a629c)) {
    return false;
  }

  var_3c79041b6898ccbe = function_879d297885591207(kiosk);

  if(!isDefined(var_3c79041b6898ccbe)) {
    return false;
  }

  if(!isDefined(level.var_44235d71492fa1a5)) {
    level.var_44235d71492fa1a5 = [];
  }

  if(isDefined(level.var_44235d71492fa1a5[kiosk.index]) && level.var_44235d71492fa1a5[kiosk.index].defindex == var_3c79041b6898ccbe) {
    return true;
  }

  buystations = utility::array_combine(level.var_6be7b375ec4a629c, level.var_4531798404d47e45);

  foreach(var_eb7139726cc569b5 in buystations) {
    if(var_eb7139726cc569b5["index"] == var_3c79041b6898ccbe) {
      var_44235d71492fa1a5 = spawnStruct();
      var_44235d71492fa1a5.defindex = var_3c79041b6898ccbe;
      var_44235d71492fa1a5.stock = [];

      foreach(var_541fd62b8d9c236d, var_cf29bd90372e77 in var_eb7139726cc569b5["items"]) {
        var_44235d71492fa1a5.stock[var_541fd62b8d9c236d] = var_cf29bd90372e77["defaultStock"];

        if(isDefined(level.gulag) && istrue(level.gulag.shutdown) && var_541fd62b8d9c236d == "brloot_gulag_token") {
          var_44235d71492fa1a5.stock[var_541fd62b8d9c236d] = 0;
        }
      }

      level.var_44235d71492fa1a5[kiosk.index] = var_44235d71492fa1a5;
      return true;
    }
  }

  foreach(var_eb7139726cc569b5 in level.var_4531798404d47e45) {
    if(var_eb7139726cc569b5["index"] == var_3c79041b6898ccbe) {
      var_44235d71492fa1a5 = spawnStruct();
      var_44235d71492fa1a5.defindex = var_3c79041b6898ccbe;
      var_44235d71492fa1a5.stock = [];

      foreach(var_541fd62b8d9c236d, var_cf29bd90372e77 in var_eb7139726cc569b5["items"]) {
        var_44235d71492fa1a5.stock[var_541fd62b8d9c236d] = var_cf29bd90372e77["defaultStock"];

        if(isDefined(level.gulag) && istrue(level.gulag.shutdown) && var_541fd62b8d9c236d == "brloot_gulag_token") {
          var_44235d71492fa1a5.stock[var_541fd62b8d9c236d] = 0;
        }
      }

      level.var_44235d71492fa1a5[kiosk.index] = var_44235d71492fa1a5;
      return true;
    }
  }

  return false;
}

function function_6af40e269aae683e(kiosk, var_cf9d634ef87d898b) {
  player = self;
  assert(isPlayer(player));

  if(!function_ac84b48bb39d674f(kiosk)) {
    return undefined;
  }

  if(scripts\mp\gametypes\br_pickups::isweaponpickup(var_cf9d634ef87d898b)) {
    return undefined;
  }

  var_b0f4dcc20c3b0c76 = undefined;
  var_602c39c79c517a48 = level.var_44235d71492fa1a5[kiosk.index].defindex;
  buystations = utility::array_combine(level.var_6be7b375ec4a629c, level.var_4531798404d47e45);

  foreach(var_eb7139726cc569b5 in buystations) {
    if(var_eb7139726cc569b5["index"] == var_602c39c79c517a48) {
      var_b0f4dcc20c3b0c76 = var_eb7139726cc569b5["items"];
      break;
    }
  }

  if(isDefined(level.var_4531798404d47e45)) {
    foreach(var_eb7139726cc569b5 in level.var_4531798404d47e45) {
      if(var_eb7139726cc569b5["index"] == var_602c39c79c517a48) {
        var_b0f4dcc20c3b0c76 = var_eb7139726cc569b5["items"];
        break;
      }
    }
  }

  assert(isDefined(var_b0f4dcc20c3b0c76));
  isfiresale = iskioskfiresaleactiveforplayer(kiosk, player);
  itemstock = level.var_44235d71492fa1a5[kiosk.index].stock[var_cf9d634ef87d898b];

  if(isDefined(itemstock)) {
    if(istrue(kiosk.var_114e759371623080)) {
      newstock = scripts\mp\gametypes\br_gametype_truckwar::function_de1ac98379235d8b(var_cf9d634ef87d898b, itemstock);
      itemstock = ter_op(isDefined(newstock), newstock, itemstock);
    }

    ishidden = !isfiresale && var_b0f4dcc20c3b0c76[var_cf9d634ef87d898b]["hidden"];

    if(ishidden) {
      return 0;
    } else {
      return itemstock;
    }

    return;
  }

  unlimiteditem = var_b0f4dcc20c3b0c76[var_cf9d634ef87d898b];

  if(isDefined(unlimiteditem)) {
    assert(!isDefined(var_b0f4dcc20c3b0c76[var_cf9d634ef87d898b]["<dev string:x73>"]));
    return 1;
  }

  return 0;
}

function function_66cd523e6167613(kiosk) {
  player = self;
  assert(isPlayer(player));

  if(!function_ac84b48bb39d674f(kiosk)) {
    return undefined;
  }

  var_b0f4dcc20c3b0c76 = undefined;
  var_602c39c79c517a48 = level.var_44235d71492fa1a5[kiosk.index].defindex;
  buystations = utility::array_combine(level.var_6be7b375ec4a629c, level.var_4531798404d47e45);

  foreach(var_eb7139726cc569b5 in buystations) {
    if(var_eb7139726cc569b5["index"] == var_602c39c79c517a48) {
      var_b0f4dcc20c3b0c76 = var_eb7139726cc569b5["items"];
      break;
    }
  }

  if(isDefined(level.var_4531798404d47e45)) {
    foreach(var_eb7139726cc569b5 in level.var_4531798404d47e45) {
      if(var_eb7139726cc569b5["index"] == var_602c39c79c517a48) {
        var_b0f4dcc20c3b0c76 = var_eb7139726cc569b5["items"];
        break;
      }
    }
  }

  assert(isDefined(var_b0f4dcc20c3b0c76));
  isfiresale = iskioskfiresaleactiveforplayer(kiosk, player);
  itemstocks = [];
  var_aedd70527004e768 = 0;

  foreach(itemkey, itemstock in level.var_44235d71492fa1a5[kiosk.index].stock) {
    if(isDefined(itemstock)) {
      if(istrue(kiosk.var_114e759371623080)) {
        newstock = scripts\mp\gametypes\br_gametype_truckwar::function_de1ac98379235d8b(itemkey, itemstock);
        itemstock = ter_op(isDefined(newstock), newstock, itemstock);
      }

      ishidden = !isfiresale && var_b0f4dcc20c3b0c76[itemkey]["hidden"];

      if(ishidden) {
        itemstocks[var_aedd70527004e768] = 0;
      } else {
        itemstocks[var_aedd70527004e768] = itemstock;
      }
    }

    var_aedd70527004e768++;
  }

  return itemstocks;
}

function function_3c3bca629d687994(kiosk) {
  player = self;
  assert(isPlayer(player));

  if(!function_ac84b48bb39d674f(kiosk)) {
    return undefined;
  }

  return level.var_44235d71492fa1a5[kiosk.index].stock;
}

function function_b88d64cd67bbe60f(kiosk) {
  if(!function_ac84b48bb39d674f(kiosk)) {
    return undefined;
  }

  itemspacked = 0;
  var_89ffab3d9d3c9cdd = 0;
  var_4a7f6ec38e1f5220 = function_66cd523e6167613(kiosk);

  foreach(var_e5b48212891e8513 in var_4a7f6ec38e1f5220) {
    if(isDefined(var_e5b48212891e8513)) {
      assert(0 <= var_e5b48212891e8513 && var_e5b48212891e8513 <= 3);
      assert(itemspacked < 16);
      var_89ffab3d9d3c9cdd |= var_e5b48212891e8513 << 2 * itemspacked;
      itemspacked++;
    }
  }

  return var_89ffab3d9d3c9cdd;
}

function function_469cfcbc4a5185c1(kiosk, var_cf9d634ef87d898b) {
  if(!function_ac84b48bb39d674f(kiosk)) {
    return;
  }

  itemstock = level.var_44235d71492fa1a5[kiosk.index].stock[var_cf9d634ef87d898b];

  if(isDefined(itemstock)) {
    level.var_44235d71492fa1a5[kiosk.index].stock[var_cf9d634ef87d898b] = ter_op(itemstock > 0, itemstock - 1, 0);
  }
}

function function_ef08eb6f31f46bc3(lootid) {
  if(!isDefined(lootid)) {
    return 0;
  }

  var_25978461c6e4f61b = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(var_25978461c6e4f61b)) {
    return 0;
  }

  return issubstr(getDvar(@ "hash_275014452ae83a52", ""), var_25978461c6e4f61b);
}

function function_3fb403d950df330a(var_cf9d634ef87d898b) {
  assert(isDefined(level.br_armory_kiosk.items));

  foreach(itemdata in level.br_armory_kiosk.items) {
    if(var_cf9d634ef87d898b == itemdata.entryref) {
      return itemdata.filtered;
    }
  }

  return 1;
}

function function_596ce27c393e3593(kiosk) {
  var_dc5ca81f164df863 = function_879d297885591207(kiosk);

  if(!isDefined(var_dc5ca81f164df863)) {
    var_dc5ca81f164df863 = level.var_e7cee4fbb5b46ef2;
  }

  buystations = utility::array_combine(level.var_6be7b375ec4a629c, level.var_4531798404d47e45);

  foreach(var_eb7139726cc569b5 in buystations) {
    if(var_eb7139726cc569b5["index"] == var_dc5ca81f164df863) {
      return var_eb7139726cc569b5["itemFilter"];
    }
  }

  if(isDefined(level.var_4531798404d47e45)) {
    foreach(var_eb7139726cc569b5 in level.var_4531798404d47e45) {
      if(var_eb7139726cc569b5["index"] == var_dc5ca81f164df863) {
        return var_eb7139726cc569b5["itemFilter"];
      }
    }
  }
}

function function_d84cdb7463425ba(var_9023cea8f03e72d2) {
  var_eb7139726cc569b5 = [];
  var_3d329ebb0d03d6db = scripts\cp_mp\utility\loot::function_54b046aa3ba2678a(var_9023cea8f03e72d2);
  var_eb7139726cc569b5["index"] = var_3d329ebb0d03d6db;
  var_eb7139726cc569b5["ref"] = var_9023cea8f03e72d2;
  var_eb7139726cc569b5["items"] = [];
  var_eb7139726cc569b5["itemFilter"] = 0;
  var_904eefa8f06ceecb = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 0, var_3d329ebb0d03d6db);
  stationitem = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 3);
  itemindex = 0;
  var_ac75b489772f26ce = 4 * itemindex;

  while(stationitem != "") {
    itemfiltered = function_3fb403d950df330a(stationitem);

    if(!itemfiltered) {
      assertex(!isDefined(var_eb7139726cc569b5["<dev string:x83>"][stationitem]), "<dev string:x8c>" + var_9023cea8f03e72d2 + "<dev string:xb5>" + stationitem);
      itemcost = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 4 + var_ac75b489772f26ce);
      var_685cb12f08da73b = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 5 + var_ac75b489772f26ce);
      itemhidden = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 6 + var_ac75b489772f26ce);
      var_eb7139726cc569b5["items"][stationitem] = [];

      if(itemcost != "") {
        var_eb7139726cc569b5["items"][stationitem]["cost"] = int(itemcost);
      } else {
        var_eb7139726cc569b5["items"][stationitem]["cost"] = -1;
      }

      if(var_685cb12f08da73b != "") {
        var_685cb12f08da73b = int(var_685cb12f08da73b);

        if(0 <= var_685cb12f08da73b && var_685cb12f08da73b <= 3) {
          var_eb7139726cc569b5["items"][stationitem]["defaultStock"] = var_685cb12f08da73b;
        } else {
          var_eb7139726cc569b5["items"][stationitem]["defaultStock"] = randomintrange(0, 3);
        }
      } else {
        var_eb7139726cc569b5["items"][stationitem]["defaultStock"] = undefined;
      }

      if(itemhidden != "") {
        var_eb7139726cc569b5["items"][stationitem]["hidden"] = int(itemhidden);
      } else {
        var_eb7139726cc569b5["items"][stationitem]["hidden"] = 0;
      }
    }

    if(itemindex < 15) {
      if(itemfiltered) {
        var_434b72e73a9cd4b9 = 1 << itemindex;
        var_eb7139726cc569b5["itemFilter"] = var_eb7139726cc569b5["itemFilter"] | var_434b72e73a9cd4b9;
      }
    } else {
      println("<dev string:xbe>" + itemindex + 1 + "<dev string:xeb>" + 15 + "<dev string:xf5>" + stationitem + "<dev string:xff>" + var_9023cea8f03e72d2);
    }

    itemindex++;
    var_ac75b489772f26ce = 4 * itemindex;
    stationitem = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 3 + var_ac75b489772f26ce);
  }

  return var_eb7139726cc569b5;
}

function function_fe176342ed52b44f(itemref) {
  return int(tablelookup("mp/buyStation/buyStationItems.csv", 1, itemref, 0));
}

function function_517b8730ddec7f59(itemref) {
  return int(tablelookup("mp/buyStation/buyStationItems.csv", 1, itemref, 4));
}

function function_7e0281196d6407c8() {
  return getdvarint(@ "hash_1696df050ad70202", 0);
}

function private function_4d81ae9cb22f4180(dvar, backupref) {
  var_c95404cd83f761b6 = [];
  var_fffdbfff87ab6316 = getDvar(dvar);

  if(isDefined(var_fffdbfff87ab6316) && var_fffdbfff87ab6316 != "") {
    var_3d321e8859561813 = [];
    var_3d08c62a01a4bedd = strtok(var_fffdbfff87ab6316, ",");

    if(var_3d08c62a01a4bedd.size == 2 && (int(var_3d08c62a01a4bedd[0]) || int(var_3d08c62a01a4bedd[1]))) {
      var_919b9496930895b6 = int(var_3d08c62a01a4bedd[0]);
      var_36336cefcad243f5 = int(var_3d08c62a01a4bedd[1]);

      for(var_c5dcc7e2f341bf0b = var_919b9496930895b6; var_c5dcc7e2f341bf0b <= var_36336cefcad243f5; var_c5dcc7e2f341bf0b++) {
        var_904eefa8f06ceecb = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 0, var_c5dcc7e2f341bf0b);

        if(var_904eefa8f06ceecb != -1) {
          var_9023cea8f03e72d2 = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 1);

          if(var_9023cea8f03e72d2 != "") {
            var_3d321e8859561813[var_3d321e8859561813.size] = var_9023cea8f03e72d2;
          }
        }
      }
    } else {
      var_3d321e8859561813 = var_3d08c62a01a4bedd;
    }

    var_3d321e8859561813 = array_randomize(var_3d321e8859561813);

    for(var_3d329ebb0d03d6db = 0; var_3d329ebb0d03d6db < var_3d321e8859561813.size; var_3d329ebb0d03d6db++) {
      var_c95404cd83f761b6[var_c95404cd83f761b6.size] = function_d84cdb7463425ba(var_3d321e8859561813[var_3d329ebb0d03d6db]);
    }
  } else if(isDefined(backupref)) {
    var_c95404cd83f761b6[var_c95404cd83f761b6.size] = function_d84cdb7463425ba(backupref);
  }

  return var_c95404cd83f761b6;
}

function private function_ad499107951c0a81(index) {
  if(!isDefined(level.var_4531798404d47e45)) {
    level.var_4531798404d47e45 = [];
  }

  foreach(var_eb7139726cc569b5 in level.var_4531798404d47e45) {
    if(var_eb7139726cc569b5["index"] == index) {
      return true;
    }
  }

  var_904eefa8f06ceecb = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 0, index);

  if(var_904eefa8f06ceecb != -1) {
    var_9023cea8f03e72d2 = tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_904eefa8f06ceecb, 1);

    if(var_9023cea8f03e72d2 != "") {
      level.var_4531798404d47e45[level.var_4531798404d47e45.size] = function_d84cdb7463425ba(var_9023cea8f03e72d2);
      return true;
    }
  }

  return false;
}

function function_9bd43636f6f0d8c4() {
  assert(isDefined(level.br_armory_kiosk.weapons));
  level.br_armory_kiosk.weapons.staticprices = [];
  var_f615e27fabb97e45 = tablelookupgetnumrows("mp/buyStation/staticPriceList.csv");

  for(var_46d56db0a72eb5d4 = 0; var_46d56db0a72eb5d4 < var_f615e27fabb97e45; var_46d56db0a72eb5d4++) {
    var_46ba7eb0a7107f2d = tablelookupbyrow("mp/buyStation/staticPriceList.csv", var_46d56db0a72eb5d4, 0);
    var_87d8e30fbd1164a5 = tablelookupbyrow("mp/buyStation/staticPriceList.csv", var_46d56db0a72eb5d4, 1);
    assert(!isDefined(level.br_armory_kiosk.weapons.staticprices[var_46ba7eb0a7107f2d]));
    level.br_armory_kiosk.weapons.staticprices[var_46ba7eb0a7107f2d] = var_87d8e30fbd1164a5;
  }
}

function function_2d02167adeb2e60d() {
  assert(isDefined(level.br_armory_kiosk.weapons));
  level.br_armory_kiosk.weapons.weaponprices = [];
  var_63cec4db64e32297 = tablelookupgetnumrows("mp/buyStation/weaponPriceList.csv");

  for(var_279c628b1346e27e = 0; var_279c628b1346e27e < var_63cec4db64e32297; var_279c628b1346e27e++) {
    var_2770738b1316a17b = tablelookupbyrow("mp/buyStation/weaponPriceList.csv", var_279c628b1346e27e, 1);
    var_fa1ab16b7b374db3 = tablelookupbyrow("mp/buyStation/weaponPriceList.csv", var_279c628b1346e27e, 2);
    assert(!isDefined(level.br_armory_kiosk.weapons.weaponprices[var_2770738b1316a17b]));
    level.br_armory_kiosk.weapons.weaponprices[var_2770738b1316a17b] = var_fa1ab16b7b374db3;
  }
}

function function_d872d1b4b7c3c32e() {
  assert(isDefined(level.br_armory_kiosk.weapons));
  level.br_armory_kiosk.weapons.var_f6619d771d944fd2 = [];
  var_648068a3992692f7 = tablelookupgetnumrows("mp/buyStation/weaponPriceScalars.csv");

  for(var_6dca16d75df1105e = 0; var_6dca16d75df1105e < var_648068a3992692f7; var_6dca16d75df1105e++) {
    var_6d9e27d75dc0cf5b = tablelookupbyrow("mp/buyStation/weaponPriceScalars.csv", var_6dca16d75df1105e, 1);
    var_facc5533af7abe13 = tablelookupbyrow("mp/buyStation/weaponPriceScalars.csv", var_6dca16d75df1105e, 2);
    assert(!isDefined(level.br_armory_kiosk.weapons.var_f6619d771d944fd2[var_6d9e27d75dc0cf5b]));
    level.br_armory_kiosk.weapons.var_f6619d771d944fd2[var_6d9e27d75dc0cf5b] = var_facc5533af7abe13;
  }
}

function function_723777567250afb4() {
  assert(isDefined(level.br_armory_kiosk.weapons));
  level.br_armory_kiosk.weapons.attachmentprices = [];
  var_522088a531963514 = tablelookupgetnumrows("mp/buyStation/attachmentPriceList.csv");

  for(var_a1d7492c6665aaef = 0; var_a1d7492c6665aaef < var_522088a531963514; var_a1d7492c6665aaef++) {
    var_a1f1582c6681f4f6 = tablelookupbyrow("mp/buyStation/attachmentPriceList.csv", var_a1d7492c6665aaef, 1);
    var_dba2830453494044 = tablelookupbyrow("mp/buyStation/attachmentPriceList.csv", var_a1d7492c6665aaef, 2);
    assert(!isDefined(level.br_armory_kiosk.weapons.attachmentprices[var_a1f1582c6681f4f6]));
    level.br_armory_kiosk.weapons.attachmentprices[var_a1f1582c6681f4f6] = var_dba2830453494044;
  }
}

function function_98b7422b7dcbcd5d() {
  assert(isDefined(level.br_armory_kiosk.weapons));
  level.br_armory_kiosk.weapons.var_40484251044547c1 = [];
  var_22c065782099074 = tablelookupgetnumrows("mp/buyStation/attachmentPriceScalars.csv");

  for(var_e3113d8479a341cf = 0; var_e3113d8479a341cf < var_22c065782099074; var_e3113d8479a341cf++) {
    var_e32b4c8479bf8bd6 = tablelookupbyrow("mp/buyStation/attachmentPriceScalars.csv", var_e3113d8479a341cf, 1);
    var_8bae00b6a3bc9ba4 = tablelookupbyrow("mp/buyStation/attachmentPriceScalars.csv", var_e3113d8479a341cf, 2);
    assert(!isDefined(level.br_armory_kiosk.weapons.var_40484251044547c1[var_e32b4c8479bf8bd6]));
    level.br_armory_kiosk.weapons.var_40484251044547c1[var_e32b4c8479bf8bd6] = var_8bae00b6a3bc9ba4;
  }
}

function function_6f3bd3113a48f7b7() {
  level.br_armory_kiosk.weapons = spawnStruct();
  function_9bd43636f6f0d8c4();
  function_2d02167adeb2e60d();
  function_d872d1b4b7c3c32e();
  function_723777567250afb4();
  function_98b7422b7dcbcd5d();
}

function _parsepurchaseitemtables() {
  level.br_armory_kiosk.items = [];
  var_50b073ec9558c3a4 = getdvarint(@ "hash_ee52115cbca6f7cc", 1);
  var_5a3d34c6e7bf27e4 = getdvarint(@ "hash_51099664f5b3c5c", 1);
  numrows = tablelookupgetnumrows("mp/buyStation/buyStationItems.csv");

  for(row = 0; row < numrows; row++) {
    itemindex = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 0));
    assert(!isDefined(level.br_armory_kiosk.items[itemindex]));
    var_97642cc850f90ca0 = spawnStruct();
    var_97642cc850f90ca0.entryref = tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 1);
    var_97642cc850f90ca0.type = tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 2);
    var_97642cc850f90ca0.ref = tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 3);
    var_97642cc850f90ca0.cost = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 4));
    var_97642cc850f90ca0.var_41f94bca374ed58a = tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 13);

    if(var_97642cc850f90ca0.var_41f94bca374ed58a != "") {
      var_97642cc850f90ca0.var_41f94bca374ed58a = int(var_97642cc850f90ca0.var_41f94bca374ed58a);
    } else {
      var_97642cc850f90ca0.var_41f94bca374ed58a = undefined;
    }

    var_d3329a62a63406e9 = getdvarint(@ "hash_950c868de7e98dbf", 0);

    if(var_d3329a62a63406e9 != 0) {
      var_97642cc850f90ca0.firesalediscount = var_d3329a62a63406e9;
    } else {
      var_97642cc850f90ca0.firesalediscount = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 10));
    }

    var_97642cc850f90ca0.lootid = int(tablelookupbyrow("mp/buyStation/buyStationItems.csv", row, 11));

    if(var_50b073ec9558c3a4) {
      var_140518973901ac9f = function_ef08eb6f31f46bc3(var_97642cc850f90ca0.lootid);
      var_df48480fcaab21b9 = var_5a3d34c6e7bf27e4 && scripts\cp_mp\utility\loot::function_5d47301f7bb7a6ba(var_97642cc850f90ca0.lootid);
      var_97642cc850f90ca0.filtered = var_140518973901ac9f || var_df48480fcaab21b9;
    } else {
      var_97642cc850f90ca0.filtered = 0;
    }

    level.br_armory_kiosk.items[itemindex] = var_97642cc850f90ca0;
  }
}

function function_6ce8d88dab67a185(entryref, cost) {
  foreach(var_97642cc850f90ca0 in level.br_armory_kiosk.items) {
    if(var_97642cc850f90ca0.entryref == entryref) {
      var_97642cc850f90ca0.cost = cost;
    }
  }
}

function function_3cb66deb101988ce(var_cf9d634ef87d898b, stock) {
  if(!isDefined(level.var_44235d71492fa1a5)) {
    return;
  }

  foreach(index, kiosk in level.var_44235d71492fa1a5) {
    if(isDefined(level.var_44235d71492fa1a5[index].stock[var_cf9d634ef87d898b])) {
      level.var_44235d71492fa1a5[index].stock[var_cf9d634ef87d898b] = stock;
    }
  }
}

function function_3e6ddd0ae062ac75() {
  if(!isDefined(level.var_6be7b375ec4a629c)) {
    level.var_6be7b375ec4a629c = function_4d81ae9cb22f4180(@ "scr_buy_station_pool", level.var_11a3973390a71e8);
  }

  if(!isDefined(level.var_3899105ceec08fb8)) {
    level.var_3899105ceec08fb8 = function_4d81ae9cb22f4180(@ "hash_f4138ad8e0de3ac6");
  }
}

function private function_d1687e85988049bb(itemref, var_c95404cd83f761b6) {
  foreach(var_eb7139726cc569b5 in var_c95404cd83f761b6) {
    if(var_eb7139726cc569b5["index"] == level.var_e7cee4fbb5b46ef2 || isDefined(level.var_747666592ae8cb22) && var_eb7139726cc569b5["index"] == level.var_747666592ae8cb22) {
      if(isDefined(var_eb7139726cc569b5["items"][itemref]) && var_eb7139726cc569b5["items"][itemref]["cost"] > 0) {
        return var_eb7139726cc569b5["items"][itemref]["cost"];
      }

      return undefined;
    }
  }
}

function private function_d0e1afe1bd3614df(itemref) {
  buystations = utility::array_combine(level.var_6be7b375ec4a629c, level.var_4531798404d47e45);
  cost = function_d1687e85988049bb(itemref, buystations);

  if(!isDefined(cost) && isDefined(level.var_3899105ceec08fb8)) {
    cost = function_d1687e85988049bb(itemref, level.var_3899105ceec08fb8);
  }

  return cost;
}

function function_3cc8b2630d4f56e7(weaponref, attachmentrefs) {
  assert(isDefined(level.br_armory_kiosk.weapons));
  weaponcost = level.br_armory_kiosk.weapons.weaponprices[weaponref];

  if(!isDefined(weaponcost)) {
    weaponcost = level.br_armory_kiosk.weapons.staticprices["base_weapon_price"];
    assert(isDefined(weaponcost));
    var_2c8d5f3760cefb99 = strtok(weaponref, "_");
    weaponcostscalar = level.br_armory_kiosk.weapons.var_f6619d771d944fd2[var_2c8d5f3760cefb99[1]];

    if(isDefined(weaponcostscalar)) {
      weaponcost = floor(float(weaponcost) * float(weaponcostscalar));
    }
  }

  weaponcost = int(weaponcost);
  var_b4a5b92285739a05 = 0;
  var_d92fa0cdae417729 = 0;
  var_1617f2212c6b2c64 = level.br_armory_kiosk.weapons.staticprices["base_attachment_price"];
  assert(isDefined(var_1617f2212c6b2c64));

  foreach(attachmentref in attachmentrefs) {
    if(attachmentref != "none") {
      var_b4a5b92285739a05++;
      attachmentcost = level.br_armory_kiosk.weapons.attachmentprices[attachmentref];

      if(!isDefined(attachmentcost)) {
        attachmentcost = var_1617f2212c6b2c64;
        var_694af79c48f661b4 = strtok(attachmentref, "_");
        var_ba578616096ecac9 = level.br_armory_kiosk.weapons.var_40484251044547c1[var_694af79c48f661b4[0]];

        if(isDefined(var_ba578616096ecac9)) {
          attachmentcost = floor(float(var_1617f2212c6b2c64) * float(var_ba578616096ecac9));
        }
      }

      attachmentcost = int(attachmentcost);
      var_d92fa0cdae417729 += attachmentcost;
    }
  }

  var_74c73d277613a6ab = level.br_armory_kiosk.weapons.staticprices[string_join(["rigging_", string(min(var_b4a5b92285739a05, 7))])];

  if(isDefined(var_74c73d277613a6ab)) {
    var_74c73d277613a6ab = int(var_74c73d277613a6ab);
  } else {
    var_74c73d277613a6ab = 0;
  }

  return weaponcost + var_d92fa0cdae417729 + var_74c73d277613a6ab;
}

function _getactualcost(player, itemdata) {
  isfiresale = 0;

  if(isDefined(player.br_kiosk)) {
    isfiresale = iskioskfiresaleactiveforplayer(player.br_kiosk, player);
  }

  finalcost = itemdata.cost;

  if(isDefined(player.var_8d0b00b4f85bf258) && player.var_8d0b00b4f85bf258 > 0) {
    return 0;
  }

  var_bbd3ced9f1e6acbf = function_d0e1afe1bd3614df(itemdata.entryref);

  if(isDefined(var_bbd3ced9f1e6acbf)) {
    finalcost = var_bbd3ced9f1e6acbf;
  }

  var_32a4b97aaf1048c3 = getDvar(hashcat(@ "scr_", itemdata.ref, "_cost_override"), "");

  if(var_32a4b97aaf1048c3 != "") {
    var_708c98cf00cfdb10 = strtok(var_32a4b97aaf1048c3, ",");
    var_781ca8aede77fa50 = scripts\mp\utility\teams::getteamcount(player.team) - 1;

    if(var_708c98cf00cfdb10.size > 0) {
      var_c4a9d9ccdf6eccb9 = var_708c98cf00cfdb10.size <= var_781ca8aede77fa50 ? var_708c98cf00cfdb10.size - 1 : var_781ca8aede77fa50;
      finalcost = int(var_708c98cf00cfdb10[var_c4a9d9ccdf6eccb9]);
    } else {
      scripts\mp\utility\script::demoforcesre("Invalid \"scr_" + itemdata.ref + "_cost_override\" dvar value. Value: \"" + var_32a4b97aaf1048c3 + "\".");
    }
  }

  if(level.br_armory_kiosk.sales_discount > 0) {
    var_3719b75d66108f99 = level.br_armory_kiosk.sales_discount_items.size == 0 || array_contains(level.br_armory_kiosk.sales_discount_items, itemdata.ref);

    if(var_3719b75d66108f99) {
      finalcost = _applysalesdiscount(finalcost, level.br_armory_kiosk.sales_discount);
    }
  }

  var_2d4fa166958b2bbc = namespace_a38a2e1fe7519183::function_39f56604458d5a9b(player, itemdata);

  if(isDefined(var_2d4fa166958b2bbc) && var_2d4fa166958b2bbc > 0) {
    finalcost = _applysalesdiscount(finalcost, var_2d4fa166958b2bbc * 100);
  }

  if(isDefined(player.br_kiosk) && istrue(player.br_kiosk.var_a84a6acb3c2edcae) && array_contains(player.br_kiosk.players, player)) {
    return _applysalesdiscount(finalcost, 100);
  } else if(isfiresale) {
    return _applysalesdiscount(finalcost, itemdata.firesalediscount);
  }

  return finalcost;
}

function function_59e987d44a301ef5(kiosk) {
  if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && isint(kiosk)) {
    kiosk = self;
  }

  player = self;
  var_525b03beaf285c54 = getdvarint(@ "hash_c37f7e3bb9eca843", 0);
  maxdistsquared = var_525b03beaf285c54 * var_525b03beaf285c54;

  while(true) {
    if(!isDefined(kiosk) || distancesquared(player.origin, kiosk.origin) > maxdistsquared) {
      player notify("exit_quick_purchase_zone");
      break;
    }

    wait 0.1;
  }
}

function _watchforcircleclosure() {
  level endon("game_ended");
  setdvarifuninitialized(@ "hash_acddd0026cc9adad", 0);

  while(true) {
    level waittill("br_circle_set");
    var_dff50030f50c58ea = getdvarint(@ "hash_acddd0026cc9adad", 0);

    if(var_dff50030f50c58ea == 0) {
      continue;
    }

    if(level.br_circle.circleindex + 1 >= var_dff50030f50c58ea) {
      disableallarmorykiosks();

      foreach(player in level.players) {
        if(!isDefined(player) || !isalive(player)) {
          continue;
        }

        player thread scripts\mp\hud_message::showsplash("br_kiosks_disabled");
      }

      break;
    }
  }
}

function function_54fdd9330a3bed3e() {
  while(true) {
    if(getdvarint(@ "hash_ca216e77fa44180c", 0) > 0) {
      foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
        line(armorykiosk.origin, armorykiosk.origin + (0, 0, 5000), (0.7, 0.2, 0.1), 1, 1, 1);
      }
    }

    waitframe();
  }
}

function showdiscountsplash(delayseconds) {
  player = self;
  player endon("disconnect");
  level endon("game_ended");

  if(istrue(player.hasseendiscountsplash)) {
    return;
  }

  if(!isDefined(level.br_armory_kiosk.sales_discount)) {
    return;
  }

  if(level.br_armory_kiosk.sales_discount == 0) {
    return;
  }

  player.hasseendiscountsplash = 1;

  if(isDefined(delayseconds) && delayseconds > 0) {
    wait delayseconds;
  }

  if(level.br_armory_kiosk.sales_discount_items.size == 0) {
    player thread scripts\mp\hud_message::showsplash("br_sales_event_all");
    return;
  }

  player thread scripts\mp\hud_message::showsplash("br_sales_event_selective");
}

function function_8807282a387bb5b4() {
  return getdvarint(@ "hash_e6b890d479b028f4", 0);
}

function function_f29b0d39f0da104d() {
  if(!function_8807282a387bb5b4()) {
    return;
  }

  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    armorykiosk.var_60b371eba77d2372 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
    objective_setshowdistance(armorykiosk.var_60b371eba77d2372, 0);
    objective_state(armorykiosk.var_60b371eba77d2372, "invisible");
    objective_icon(armorykiosk.var_60b371eba77d2372, "ui_mobile_buystation_visual_marker");
    objective_setbackground(armorykiosk.var_60b371eba77d2372, 1);
    objective_position(armorykiosk.var_60b371eba77d2372, armorykiosk.origin + (0, 0, 40));
    function_4eb76f8d303679f4(armorykiosk.var_60b371eba77d2372, 1);
    var_a7c6c5d6c3d369aa = getdvarfloat(@ "hash_b57f7c58a492252b", 0);
    var_467f4d9b8d9063b = getdvarfloat(@ "hash_d56247cfc459711f", 0);
    function_c047d7ffe7a83501(armorykiosk.var_60b371eba77d2372, var_a7c6c5d6c3d369aa, var_467f4d9b8d9063b);
  }
}

function onprematchdone() {
  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    armorykiosk setscriptablepartstate("br_plunder_box", "visible");
    armorykiosk.visible = 1;
  }

  function_f29b0d39f0da104d();
}

function dangercircletick(dangercircleorigin, dangercircleradius, thresholdradius) {
  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("kiosk") || getdvarint(@ "scr_br_kiosk_ignore_circle", 0) == 1 || istrue(level.br_armory_kiosk.all_disabled)) {
    return;
  }

  var_52d59c928eb97c81 = dangercircleradius + getdvarfloat(@ "scr_br_circle_object_long_distance_cleanup_threshold", 1574);
  var_c434624ff361bba2 = var_52d59c928eb97c81 * var_52d59c928eb97c81;

  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    var_e4e4ae4481958d2e = !isDefined(armorykiosk.deconeffectcount) && exclusion_zones::function_de57b9616f575a63(armorykiosk.origin, 0, 0) == -1 && distance2dsquared(armorykiosk.origin, dangercircleorigin) + level.var_53c0fa66001cff52 > var_c434624ff361bba2;

    if(istrue(armorykiosk.visible)) {
      if(var_e4e4ae4481958d2e) {
        disablearmorykiosk(armorykiosk);
      }

      continue;
    }

    if(!var_e4e4ae4481958d2e && !istrue(armorykiosk.isemped)) {
      function_d9a3848f71c7c63a(armorykiosk);
    }
  }
}

function function_1a1709943670772a() {
  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("kiosk") || getdvarint(@ "scr_br_kiosk_ignore_circle", 0) == 1 || istrue(level.br_armory_kiosk.all_disabled)) {
    return;
  }

  hiddenkiosks = [];

  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    var_e4e4ae4481958d2e = !isDefined(armorykiosk.deconeffectcount) && exclusion_zones::function_de57b9616f575a63(armorykiosk.origin, 0, 0) == -1 && !scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(armorykiosk.origin, level.var_53c0fa66001cff52);

    if(istrue(armorykiosk.visible)) {
      if(var_e4e4ae4481958d2e) {
        hiddenkiosks[hiddenkiosks.size] = armorykiosk;
        disablearmorykiosk(armorykiosk);
      }

      continue;
    }

    if(!var_e4e4ae4481958d2e && !istrue(armorykiosk.isemped)) {
      function_d9a3848f71c7c63a(armorykiosk);
    }
  }

  return hiddenkiosks;
}

function disableallarmorykiosks() {
  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("kiosk")) {
    return;
  }

  level.br_armory_kiosk.all_disabled = 1;

  foreach(armorykiosk in level.br_armory_kiosk.scriptables) {
    if(isDefined(armorykiosk.visible)) {
      disablearmorykiosk(armorykiosk);
    }
  }
}

function function_d9a3848f71c7c63a(armorykiosk) {
  if(!isDefined(armorykiosk)) {
    return;
  }

  armorykiosk setscriptablepartstate("br_plunder_box", "visible");
  armorykiosk.visible = 1;
  armorykiosk.disabled = undefined;
  armorykiosk.disablederrormsg = undefined;
}

function disablearmorykiosk(armorykiosk) {
  if(!isDefined(armorykiosk)) {
    return;
  }

  if(istrue(level.var_8b92cb4447668562)) {
    armorykiosk.disablederrormsg = 1;
    armorykiosk setscriptablepartstate("br_plunder_box", "closing");
  } else {
    armorykiosk setscriptablepartstate("br_plunder_box", "closing");
  }

  armorykiosk.visible = undefined;
  armorykiosk.disabled = 1;

  if(armorykiosk namespace_1eb3c4e0e28fac71::checkforactiveobjicon()) {
    armorykiosk namespace_1eb3c4e0e28fac71::deletequestobjicon();
  }

  foreach(p in level.players) {
    if(isDefined(p.br_kiosk) && p.br_kiosk == armorykiosk) {
      p _closepurchasemenuwithresponse(2);
    }
  }

  level notify("buystation_kill_callout_" + armorykiosk.origin);
}

function setspawninstances(instances) {
  assert(isarray(instances));
  level.br_armory_kiosk.scriptables = instances;
}

function getallspawninstances() {
  if(!level.br_armory_kiosk_enabled) {
    return;
  }

  var_82aaa7c31b818b16 = getentitylessscriptablearray("scriptable_br_plunder_box", "classname");
  return var_82aaa7c31b818b16;
}

function function_68f55b32ad3368e1() {
  if(!isDefined(level.var_68f55b32ad3368e1)) {
    level.var_68f55b32ad3368e1 = getdvarint(@ "hash_ca9c84470ead8181", 0);
  }

  return level.var_68f55b32ad3368e1;
}

function private function_315d0a115fe536ee() {
  if(!isDefined(level.var_315d0a115fe536ee)) {
    level.var_315d0a115fe536ee = getdvarint(@ "hash_3aff3e8d6e0b45da", 0);
  }

  return level.var_315d0a115fe536ee;
}

function function_785d7c2ae5066f66(var_3d329ebb0d03d6db, var_c95404cd83f761b6) {
  if(var_c95404cd83f761b6.size == 0) {
    return;
  }

  var_3d329ebb0d03d6db %= var_c95404cd83f761b6.size;
  return var_c95404cd83f761b6[var_3d329ebb0d03d6db];
}

function private function_96e56767b949c013(stationstruct, var_3d329ebb0d03d6db, var_849e91c5e0d0e0df) {
  if(!isDefined(stationstruct.angles)) {
    stationstruct.angles = (0, 0, 0);
  }

  kioskname = "br_plunder_box";

  if(!isDefined(stationstruct.scriptableid)) {
    stationstruct.scriptableid = "br_plunder_box";
  }

  if(isDefined(stationstruct.hightier)) {
    stationstruct.scriptableid = "br_plunder_box_high_tier";
  }

  buystation = spawnscriptable(stationstruct.scriptableid, stationstruct.origin, stationstruct.angles);
  var_11a7769e6c3c691f = "visible";

  if(getdvarint(@ "scr_ssc_use_buy_station", 0) && getdvarint(@ "hash_bac643b1a9d211a7", 0)) {
    var_11a7769e6c3c691f = "hidden";
  }

  buystation setscriptablepartstate("br_plunder_box", var_11a7769e6c3c691f);
  buystation.centerbottom = buystation.origin + rotatevector((12, 0, 0), buystation.angles);

  namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x128>", "<dev string:x137>", undefined, "<dev string:x149>", undefined, undefined, stationstruct.poi, stationstruct.origin);

  if(isDefined(var_3d329ebb0d03d6db)) {
    buystation.overrideindex = var_3d329ebb0d03d6db;
  }

  if(isDefined(var_3d329ebb0d03d6db)) {
    buystation.var_ded92ccb217bbaeb = var_849e91c5e0d0e0df;
  }

  if(istrue(level.br_armory_kiosk.var_aaa31c1e28a5663c)) {
    scripts\killstreaks\emp::function_43755e1816ee895b(buystation, &function_d1e097b50729f36e, &function_d9a3848f71c7c63a);
  }

  if(isDefined(stationstruct.target)) {
    foreach(struct in getStructArray(stationstruct.target, "targetname")) {
      if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "kiosk_spawn_jltv_mg") {
        buystation.vehiclespawn = struct;
      }
    }
  }

  return buystation;
}

function private function_b8e0fea098fb260b(var_cb8ce683e2999310) {
  if(!isDefined(var_cb8ce683e2999310.target)) {
    return;
  }

  var_459c7f8de067151 = getStructArray(var_cb8ce683e2999310.target, "targetname");

  foreach(struct in var_459c7f8de067151) {
    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "workbench") {
      if(!isDefined(struct.angles)) {
        struct.angles = (0, 0, 0);
      }

      workbench = spawnscriptable("br_workbench", struct.origin, struct.angles);
      workbench setscriptablepartstate("br_workbench", "visible");

      namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x174>", "<dev string:x181>", undefined, "<dev string:x191>", undefined, undefined, struct.poi, struct.origin);

      return;
    }
  }
}

function function_e486c07c28a71f34() {
  if(!istrue(level.var_8dea6607b3189a60)) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  var_d3a06cc30bc1f068 = getdvarint(@ "hash_1891a7c9188f098a", 1);
  var_ac63cd16a707ecea = getdvarint(@ "hash_1eaaeec5fba02706", 3);
  var_7de18efb644429dc = getdvarint(@ "hash_4cc790851bc37d7c", 3);
  var_abd2eabec6cf5f1e = randomintrange(var_ac63cd16a707ecea, var_7de18efb644429dc + 1);
  var_5fda87ce72d1d195 = getdvarint(@ "hash_eecbc418c6540507", 0);
  var_48cb4df1fbab9006 = getdvarint(@ "hash_5d7d5915e01d1303", 0);
  var_d1167a8340d7b64 = squared(getdvarint(@ "hash_61f3403e27e2815f", 3000));
  level.var_6aa304e25520289f = getStructArray("buy_station", "targetname");

  if(level.var_6aa304e25520289f.size == 0) {
    return;
  }

  var_a165c118f696aa70 = getdvarint(@ "hash_4409a87281d77ed1", 0);
  var_68f55b32ad3368e1 = function_68f55b32ad3368e1();

  if(var_5fda87ce72d1d195 > 0) {
    stationsspawned = 0;
    numlocations = level.var_6aa304e25520289f.size;
    var_2446ae45ef06bf3d = [];
    level.var_6aa304e25520289f = array_randomize(level.var_6aa304e25520289f);

    for(stationindex = 0; stationindex < numlocations; stationindex++) {
      if(scripts\mp\gametypes\br_circle::ispointwithininitialdangercircle(level.var_6aa304e25520289f[stationindex].origin)) {
        inrange = 0;

        foreach(station in var_2446ae45ef06bf3d) {
          if(distance2dsquared(station.origin, level.var_6aa304e25520289f[stationindex].origin) < var_d1167a8340d7b64) {
            inrange = 1;
            break;
          }
        }

        if(inrange) {
          continue;
        }

        var_2446ae45ef06bf3d[var_2446ae45ef06bf3d.size] = function_2fcaa447c4e7d4a0(level.var_6aa304e25520289f[stationindex], stationsspawned);
        stationsspawned++;

        if(stationsspawned == var_5fda87ce72d1d195) {
          break;
        }
      }
    }
  } else if(!var_a165c118f696aa70 && !var_68f55b32ad3368e1) {
    var_a503ff4c72c94afe = [];
    var_932be85924f099d8 = [];
    numlocations = level.var_6aa304e25520289f.size;

    for(stationindex = 0; stationindex < numlocations; stationindex++) {
      buystation = level.var_6aa304e25520289f[stationindex];

      if(!isDefined(buystation.poi)) {
        continue;
      }

      if(!isDefined(var_a503ff4c72c94afe[buystation.poi])) {
        var_a503ff4c72c94afe[buystation.poi] = [];
        var_932be85924f099d8[var_932be85924f099d8.size] = buystation.poi;
      }

      var_a503ff4c72c94afe[buystation.poi][var_a503ff4c72c94afe[buystation.poi].size] = buystation;
    }

    var_932be85924f099d8 = array_randomize(var_932be85924f099d8);
    stationsspawned = 0;
    var_97218eef96cd3102 = 0;

    foreach(var_72f29fa8dac796bb in var_932be85924f099d8) {
      if(var_97218eef96cd3102 == var_abd2eabec6cf5f1e) {
        break;
      }

      if(!scripts\mp\poi::poi_ispoiactive(var_72f29fa8dac796bb)) {
        continue;
      }

      if(scripts\mp\utility\game::getsubgametype() == "dmz" && scripts\cp_mp\utility\game_utility::function_7ee65fae13124702()) {
        stationsspawned = function_eaca292314678f38(stationsspawned, var_a503ff4c72c94afe[var_72f29fa8dac796bb], var_72f29fa8dac796bb);
        continue;
      }

      var_8761fecdf09added = var_a503ff4c72c94afe[var_72f29fa8dac796bb];
      var_2a980b0531901c38 = var_d3a06cc30bc1f068;

      if(var_2a980b0531901c38 > var_8761fecdf09added.size) {
        var_2a980b0531901c38 = var_8761fecdf09added.size;
      }

      var_8761fecdf09added = array_slice(array_randomize(var_8761fecdf09added), 0, var_2a980b0531901c38);

      for(stationindex = 0; stationindex < var_8761fecdf09added.size; stationindex++) {
        scripts\mp\gametypes\br_armory_kiosk::function_2fcaa447c4e7d4a0(var_8761fecdf09added[stationindex], stationsspawned);
        stationsspawned++;
      }
    }
  } else {
    var_6aa304e25520289f = level.var_6aa304e25520289f;

    if(!var_68f55b32ad3368e1) {
      var_6aa304e25520289f = array_slice(array_randomize(level.var_6aa304e25520289f), 0, var_d3a06cc30bc1f068);
    }

    numlocations = var_6aa304e25520289f.size;
    stationsspawned = 0;

    for(stationindex = 0; stationindex < numlocations; stationindex++) {
      scripts\mp\gametypes\br_armory_kiosk::function_2fcaa447c4e7d4a0(var_6aa304e25520289f[stationindex], stationsspawned);
      stationsspawned++;
    }
  }

  if(var_48cb4df1fbab9006 > 0) {
    circlecount = level.br_level.br_circlecenters.size;
    circlecount = int(max(circlecount - 1, 0));
    dangercenterorigin = (level.br_level.br_circlecenters[circlecount][0], level.br_level.br_circlecenters[circlecount][1], 0);
    level.var_6aa304e25520289f = sortbydistance(level.var_6aa304e25520289f, dangercenterorigin);
    stationsinrange = 0;

    for(stationindex = 0; stationindex < level.var_6aa304e25520289f.size; stationindex++) {
      inrange = 0;

      foreach(buystation in level.br_armory_kiosk.scriptables) {
        if(distance2dsquared(level.var_6aa304e25520289f[stationindex].origin, buystation.origin) < var_d1167a8340d7b64) {
          inrange = 1;
          break;
        }
      }

      if(inrange) {
        stationsinrange++;

        if(stationsinrange == var_48cb4df1fbab9006) {
          break;
        } else {
          continue;
        }
      }

      function_2fcaa447c4e7d4a0(level.var_6aa304e25520289f[stationindex], stationsspawned);
      stationsspawned++;
      stationsinrange++;

      if(stationsinrange == var_48cb4df1fbab9006) {
        break;
      }
    }
  }
}

function function_86f5339f1334e16(structname) {
  level endon("game_ended");

  if(!level.br_debugsolotest) {
    level waittill("prematch_done");
    waitframe();
  }

  if(!isDefined(level.var_f3bff22d504c243a) || level.var_f3bff22d504c243a.size == 0) {
    return;
  }

  for(i = 0; i < level.var_f3bff22d504c243a.size; i++) {
    function_7cb54f604c35be8c(level.var_f3bff22d504c243a[i]);
  }

  flag_set("buy_stations_spawned");
}

function function_2fcaa447c4e7d4a0(stationstruct, stationsspawned) {
  if(isDefined(level.var_6aa304e25520289f)) {
    level.var_6aa304e25520289f = array_remove(level.var_6aa304e25520289f, stationstruct);
  }

  if(isDefined(stationstruct.var_5ea299587b551f9f)) {
    var_bf02f24d129fcca9 = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 1, stationstruct.var_5ea299587b551f9f);
    var_3d329ebb0d03d6db = int(tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_bf02f24d129fcca9, 0));
  } else {
    var_3d329ebb0d03d6db = undefined;

    if(isDefined(level.var_6be7b375ec4a629c) && level.var_6be7b375ec4a629c.size > 0) {
      var_3d329ebb0d03d6db = function_785d7c2ae5066f66(stationsspawned, level.var_6be7b375ec4a629c)["index"];
    }
  }

  if(isDefined(stationstruct.var_c4231c7dde966d14)) {
    var_bf02f24d129fcca9 = tablelookuprownum("mp/buyStation/buyStationDefs.csv", 1, stationstruct.var_c4231c7dde966d14);
    var_849e91c5e0d0e0df = int(tablelookupbyrow("mp/buyStation/buyStationDefs.csv", var_bf02f24d129fcca9, 0));
  } else {
    var_849e91c5e0d0e0df = undefined;

    if(isDefined(level.var_3899105ceec08fb8) && level.var_3899105ceec08fb8.size > 0) {
      var_849e91c5e0d0e0df = function_785d7c2ae5066f66(stationsspawned, level.var_3899105ceec08fb8)["index"];
    }
  }

  if(namespace_dbfbff3eb10fab94::function_19598c1ea1487b84()) {
    function_b8e0fea098fb260b(stationstruct);
  }

  buystation = function_96e56767b949c013(stationstruct, var_3d329ebb0d03d6db, var_849e91c5e0d0e0df);
  buystation.var_5ea299587b551f9f = stationstruct.var_5ea299587b551f9f;
  level.br_armory_kiosk.scriptables[level.br_armory_kiosk.scriptables.size] = buystation;
  return buystation;
}

function function_53542c92143aa5eb(structname, stationstruct) {
  if(!isDefined(level.var_f3bff22d504c243a)) {
    level.var_f3bff22d504c243a = [];
  }

  level.var_f3bff22d504c243a[level.var_f3bff22d504c243a.size] = stationstruct;
  return stationstruct;
}

function function_7cb54f604c35be8c(stationstruct) {
  assert(isDefined(level.br_armory_kiosk));
  stationsspawned = level.br_armory_kiosk.scriptables.size;
  scriptedkiosk = function_2fcaa447c4e7d4a0(stationstruct, stationsspawned);
  return scriptedkiosk;
}

function function_27c1cd609d90c09(stationstructs) {
  for(stationsspawned = 0; stationsspawned < stationstructs.size; stationsspawned++) {
    scriptedkiosk = function_2fcaa447c4e7d4a0(stationstructs[stationsspawned], stationsspawned);
    level.br_armory_kiosk.scriptables[level.br_armory_kiosk.scriptables.size] = scriptedkiosk;
  }
}

function function_e6c1c35181a2870f(structname) {
  if(!istrue(level.br_armory_kiosk_enabled)) {
    return;
  }

  var_82aaa7c31b818b16 = getentitylessscriptablearray("scriptable_br_plunder_box", "classname");
  allspawnlocations = var_82aaa7c31b818b16;

  if(istrue(level.var_8dea6607b3189a60)) {
    var_91b00de1b63a7e5a = getStructArray(structname, "targetname");
    allspawnlocations = array_combine_unique(allspawnlocations, var_91b00de1b63a7e5a);
  }

  return allspawnlocations;
}

function canusekiosk(instance, player) {
  if(istrue(level.gameended)) {
    return false;
  }

  if((!player scripts\cp_mp\utility\player_utility::_isalive() || istrue(player.inlaststand)) && !scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
    return false;
  }

  if(player scripts\common\utility::isusingremote()) {
    return false;
  }

  if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(isDefined(player) && isDefined(player.var_e5520effcbe8bd30)) {
    return false;
  }

  if(istrue(player scripts\mp\gametypes\br_gametypes::runbrgametypefunc("playerSkipKioskUse", instance))) {
    return false;
  }

  if(istrue(player.iscarrying)) {
    player scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
    return false;
  }

  if(istrue(player.isjuggernaut)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyjuggernaut);
    return false;
  }

  if(istrue(instance.locked)) {
    if(!isDefined(instance.var_8d6dbcf5443a11f0)) {
      instance.var_8d6dbcf5443a11f0 = 0;
    }

    instance.var_8d6dbcf5443a11f0++;
    return false;
  }

  return true;
}

function armorykioskused(instance, part, state, player, bautouse, usestring) {
  if(!scripts\mp\gametypes\br_public::iskiosk(instance.type) && !scripts\mp\gametypes\br_public::function_a84a6acb3c2edcae(instance.type)) {
    return;
  }

  if(istrue(instance.var_a84a6acb3c2edcae) && !array_contains(instance.players, player)) {
    return;
  }

  if(istrue(bautouse) && !function_7e0281196d6407c8()) {
    return;
  }

  if(!isDefined(player)) {
    player = self;
  }

  if(istrue(bautouse) && !isDefined(player.armorykioskpurchaseallowed)) {
    player.armorykioskpurchaseallowed = 0;
  }

  if(getdvarint(@ "hash_ece0c71aa9d5c939", 0)) {
    player function_c471a0358a06a7f0();
  }

  if(!canusekiosk(instance, player)) {
    if(istrue(bautouse)) {
      player.armorykioskpurchaseallowed = 0;
    }

    return;
  }

  if(!isDefined(instance.playersused)) {
    instance.playersused = [];
  }

  if(!array_contains(instance.playersused, player)) {
    instance.playersused[instance.playersused.size] = player;
  }

  if(istrue(instance.disablederrormsg) && istrue(instance.isemped)) {
    if(soundexists("br_plunder_atm_cancel")) {
      player playlocalsound("br_plunder_atm_cancel");
    }

    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/EMPED_DEPLOYABLE_KIOSK");
    return;
  }

  if(istrue(instance.disablederrormsg)) {
    if(soundexists("br_plunder_atm_cancel")) {
      player playlocalsound("br_plunder_atm_cancel");
    }

    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/UNUSABLE_KIOSK");
    return;
  }

  if(!isDefined(instance.playersusing)) {
    instance.playersusing = [];
  }

  instance.playersusing[instance.playersusing.size] = player;

  if(scripts\engine\utility::issharedfuncdefined(#"biometricscan", #"reportkeycardcount")) {
    [[scripts\engine\utility::getsharedfunc(#"biometricscan", #"reportkeycardcount")]](player);
  }

  if(istrue(bautouse)) {
    if(!player.armorykioskpurchaseallowed) {
      function_28d837f720b03bfa(instance, player);
    }

    return;
  }

  if(istrue(player.insertingarmorplate)) {
    player notify("try_armor_cancel", "armory_kiosk_used");
  }

  if(isDefined(instance)) {
    function_9bca399aafce0b41(instance, part, state);
  }

  player thread _runpurchasemenu(instance);
  player thread function_3b647c2b49a4e63e();
}

function function_3b647c2b49a4e63e() {
  self endon("death_or_disconnect");
  self endon("_watchToAutoCloseMenu_end");
  level endon("game_ended");
  self waittillmatch("luinotifyserver", "br_cancel_purchase");
  _purchasemenuclosedbyclient(self);
}

function function_9bca399aafce0b41(kiosk, part, currentstate) {
  if(!isDefined(part)) {
    if(scripts\mp\gametypes\br_public::iskiosk(kiosk.type)) {
      part = "br_plunder_box";
    } else if(istrue(kiosk.var_a84a6acb3c2edcae)) {
      part = "br_plunder_box_stronghold";
    } else {
      return;
    }
  }

  if(!isDefined(currentstate)) {
    currentstate = kiosk getscriptablepartstate(part);
  }

  switch (currentstate) {
    case #"hash_2a59780b5f94bfdd":
    case #"hash_30df217077b73b50":
    case #"hash_b799d1d25a80c481":
    case #"hash_b8e6f37f38dbc6b1":
    case #"hash_fb4008fe550f76ab":
      break;
    default:
      return;
  }

  newstate = "opening";

  if(currentstate == "firesale_visible") {
    newstate = "firesale_opening";
  }

  kiosk setscriptablepartstate(part, newstate);
  kiosk thread kioskfixupproneplayers();
}

function function_c471a0358a06a7f0() {
  player = self;

  foreach(p in level.teamdata[player.team]["players"]) {
    if(!isDefined(p)) {
      continue;
    }

    if(istrue(level.usegulag)) {
      gulagjail = p.game_extrainfo & 512;
      gulagarena = p.game_extrainfo & 1024;
      var_43fb259f4877f32c = istrue(p.wasingulag);
      var_c3ff2e180fe8a431 = isDefined(p.gulag);
      var_bc61b790659a94dc = istrue(p.gulag);
      var_5507b0bf5d504e84 = isDefined(p.gulagarena);
      var_9a5b643e836607ef = istrue(p.gulagarena);
      var_80668ba94093c0c7 = istrue(p.gulagloser);
      arena = namespace_ad49798629176e96::function_2f4344abdc200e43(p);
      playerarena = isDefined(arena);
    } else {
      gulagjail = 0;
      gulagarena = 0;
      var_43fb259f4877f32c = 0;
      var_c3ff2e180fe8a431 = 0;
      var_bc61b790659a94dc = 0;
      var_5507b0bf5d504e84 = 0;
      var_9a5b643e836607ef = 0;
      var_80668ba94093c0c7 = 0;
      arena = 0;
      playerarena = 0;
    }

    eliminated = istrue(p.br_iseliminated);
    isplayeralive = isalive(p);
    playersessionstate = p.sessionstate;
    playerspectating = isDefined(p getspectatingplayer());
    isplayerspectating = playerspectating;
    sessionuimemberindex = p.sessionuimemberindex;
    logstring("[ WHY_NO_BUYBACK TEST] : " + p.name + ", " + eliminated + ", " + gulagjail + ", " + gulagarena + ", " + var_43fb259f4877f32c + ", " + var_c3ff2e180fe8a431 + ", " + var_bc61b790659a94dc + ", " + var_5507b0bf5d504e84 + ", " + var_9a5b643e836607ef + ", " + var_80668ba94093c0c7 + ", " + playerarena + ", " + isplayeralive + ", " + playersessionstate + ", " + isplayerspectating + ", " + sessionuimemberindex);
  }
}

function kioskfixupproneplayers() {
  if(!getdvarint(@ "hash_636451c6314df097", 1)) {
    return;
  }

  radius = getdvarfloat(@ "hash_3990f3347374d18e", 300);
  closeplayers = sortbydistancecullbyradius(level.players, self.origin, radius);

  foreach(player in closeplayers) {
    if(!isDefined(player) || !isalive(player)) {
      continue;
    }

    if(player getstance() != "prone") {
      continue;
    }

    halfsize = player getboundshalfsize();
    radius = halfsize[0];
    height = 2 * halfsize[2];

    if(capsuletracepassed(player.origin, radius, height, undefined, 0, 0)) {
      continue;
    }

    player setstance("crouch", 1);
  }
}

function kiosksetupfiresaleforplayer(kiosk, player) {
  if(!isDefined(kiosk.firesaleforplayers)) {
    kiosk.firesaleforplayers = [player];
  } else if(!array_contains(kiosk.firesaleforplayers, player)) {
    kiosk.firesaleforplayers = array_add(kiosk.firesaleforplayers, player);
  }

  if(!kiosk namespace_1eb3c4e0e28fac71::checkforactiveobjicon()) {
    kiosk namespace_1eb3c4e0e28fac71::createquestobjicon("ui_mp_br_mapmenu_icon_poi_plunder_box_firesale", "active", kiosk.origin);
  }

  kiosk namespace_1eb3c4e0e28fac71::showquestobjicontoplayer(player);

  if(istrue(kiosk.var_ce5c1024bca39998) && !istrue(kiosk.iconmoving)) {
    kiosk thread function_7e681bf3d2159ccf();
  }
}

function function_7e681bf3d2159ccf() {
  if(!istrue(self.iconmoving)) {
    self.iconmoving = 1;
  }

  while(namespace_1eb3c4e0e28fac71::checkforactiveobjicon()) {
    scripts\mp\gametypes\br_quest_util::movequestobjicon(self.origin);
    waitframe();
  }

  self.iconmoving = 0;
}

function function_d7f25b3c73157f5c() {
  if(scripts\mp\gametypes\br_publicevents::ispubliceventoftypeactive(%"firesale")) {
    return true;
  }

  return false;
}

function iskioskfiresaleactiveforplayer(kiosk, player) {
  if(!isDefined(kiosk)) {
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && (!isDefined(kiosk) || isint(kiosk))) {
    kiosk = player;
  }

  if(function_d7f25b3c73157f5c()) {
    return 1;
  }

  if(istrue(player.var_f33cc04cfb0810b7)) {
    return 1;
  }

  if(!isDefined(kiosk.firesaleforplayers)) {
    return 0;
  }

  return array_contains(kiosk.firesaleforplayers, player);
}

function kioskfiresaledoneforplayer(kiosk, player) {
  if(!isDefined(kiosk.firesaleforplayers)) {
    return;
  }

  kiosk namespace_1eb3c4e0e28fac71::hidequestobjiconfromplayer(player);
  kiosk.firesaleforplayers = array_remove(kiosk.firesaleforplayers, player);

  if(!function_d7f25b3c73157f5c()) {
    setomnvar("ui_br_kiosk_hide_discount", 1);
  }
}

function function_1a8066ccdb91c1d1() {
  if(isDefined(level.var_d03e6ba38b56b4ab) && istrue(level.var_d03e6ba38b56b4ab)) {
    return level.var_fb60f0244999d528;
  }

  return 0;
}

function getkioskyawoffsetoverride() {
  if(isDefined(level.var_d03e6ba38b56b4ab) && istrue(level.var_d03e6ba38b56b4ab)) {
    finaloffset = level.var_e9f7702d839b262c;

    if(level.randomanglemax > 0) {
      finaloffset += randomfloatrange(level.randomanglemax * -1, level.randomanglemax);
    }

    return finaloffset;
  }

  return 180 + randomfloatrange(-10, 10);
}

function function_33ee0ada0b02b12a(kiosk) {
  if(!isDefined(kiosk.dropstruct)) {
    kiosk.dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    kiosk.var_ef9b890e5f828228 = gettime();
    return;
  }

  if(kiosk.var_ef9b890e5f828228 + getdvarint(@ "hash_30955f4b3a383805", 90) * 1000 < gettime()) {
    kiosk.dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    kiosk.var_ef9b890e5f828228 = gettime();
    kiosk.var_1ac656ba9c98b8db = undefined;
    return;
  }

  kiosk.var_ef9b890e5f828228 = gettime();
}

function function_a5f8189dc840e9d6(blocktime) {
  player = self;

  if(isDefined(player.var_b8993f862c953db4) && player.var_b8993f862c953db4) {
    return;
  }

  player allowmovement(0);
  player.var_b8993f862c953db4 = 1;
  wait blocktime;
  player allowmovement(1);
  player.var_b8993f862c953db4 = 0;
}

function _runpurchasemenu(kiosk) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("death");
  player.br_kiosk = kiosk;
  function_33ee0ada0b02b12a(kiosk);

  if(scripts\mp\gametypes\br_public::isbrpracticemode()) {
    player notify("kiosk_used");
  }

  if(isDefined(level.var_6beff7b631ab7e18)) {
    [[level.var_6beff7b631ab7e18]](kiosk, player);
  }

  if(level.var_ee08b1f41e7c2444) {
    player thread function_a5f8189dc840e9d6(2);
  }

  if(getdvarint(@ "hash_80e2d358a4c12e43", 0) > 0) {
    kiosksetupfiresaleforplayer(kiosk, player);
    setDvar(@ "hash_80e2d358a4c12e43", 0);
  }

  isfiresale = iskioskfiresaleactiveforplayer(kiosk, player);
  var_b25a062b16392edd = function_879d297885591207(kiosk);

  if(isDefined(var_b25a062b16392edd)) {
    level.var_e7cee4fbb5b46ef2 = var_b25a062b16392edd;
    player setclientomnvar("ui_buystation_override", var_b25a062b16392edd);
  } else if(isDefined(level.var_4b3d0771df2c44a9) && !istrue(player.var_e5b7a6a0ec2b440e)) {
    level.var_e7cee4fbb5b46ef2 = level.var_4b3d0771df2c44a9;
    player setclientomnvar("ui_buystation_override", level.var_4b3d0771df2c44a9);
  }

  if(istrue(level.var_c153eac6e7c0e1a2)) {
    var_78b116ff4ed463b9 = namespace_25c7d0f5cb1e4346::function_6b9fb04b51e91720(player, kiosk);
    player setclientomnvar("ui_barter_list_index", var_78b116ff4ed463b9);
  }

  var_aba76bfe006a0128 = function_2a50f66eb0ec8756(kiosk);

  if(isDefined(var_aba76bfe006a0128)) {
    level.var_747666592ae8cb22 = var_aba76bfe006a0128;
    player setclientomnvar("ui_weapon_buystation_override", var_aba76bfe006a0128);
  }

  var_6b3c6b40c0598d85 = function_b88d64cd67bbe60f(kiosk);

  if(isDefined(var_6b3c6b40c0598d85)) {
    player setclientomnvar("ui_buystation_limited_item_amount", var_6b3c6b40c0598d85);
  }

  var_5dcb74bc7c559130 = function_596ce27c393e3593(kiosk);

  if(isDefined(var_5dcb74bc7c559130)) {
    player setclientomnvar("ui_buystation_item_filter", var_5dcb74bc7c559130);
  }

  setomnvar("ui_br_kiosk_hide_discount", 0);
  player setclientomnvar("ui_buystation_purchase_response", 0);

  if(istrue(player.br_kiosk.var_a84a6acb3c2edcae)) {
    player setclientomnvar("ui_options_menu", 2);
  } else {
    openvalue = 0;

    if(istrue(player.br_kiosk.isdeployablekiosk)) {
      openvalue += 16;
    } else {
      openvalue += 2;
    }

    if(isfiresale) {
      openvalue += 4;
    }

    if(istrue(kiosk.var_114e759371623080)) {
      openvalue += 32;
    }

    player setclientomnvar("ui_buystation_open", openvalue);
  }

  player.armorykioskpurchaseallowed = 1;
  scripts\mp\gametypes\br_analytics::branalytics_kiosk_menu_event(player, "menu_open");
  player thread watchtoautoclosemenu(kiosk);

  if(getdvarint(@ "hash_b4ff8c1463b8bc79", 1)) {
    player setsoundsubmix("iw8_br_plunder_kiosk_menu");
  }

  player scripts\cp_mp\calloutmarkerping::function_faa3cbec7243fe72();
  player scripts\mp\gametypes\br_gametypes::runbrgametypefunc("playerKioskUsed", kiosk);
}

function function_28d837f720b03bfa(kiosk, player) {
  player.br_kiosk = kiosk;

  if(getdvarint(@ "hash_80e2d358a4c12e43", 0) > 0) {
    kiosksetupfiresaleforplayer(kiosk, player);
    setDvar(@ "hash_80e2d358a4c12e43", 0);
  }

  player.armorykioskpurchaseallowed = 1;
  player thread function_ab62cd6135dfe6(kiosk);
  player scripts\cp_mp\calloutmarkerping::function_faa3cbec7243fe72();
}

function function_5221f0c9bdea6589() {
  player = self;
  player.br_kiosk = undefined;
  player.var_e5b7a6a0ec2b440e = undefined;
  player.var_c77002478cdfd85f = undefined;
  player.armorykioskpurchaseallowed = undefined;
  player scripts\cp_mp\calloutmarkerping::function_faa3cbec7243fe72();
}

function function_ab62cd6135dfe6(kiosk) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("death");
  player childthread function_59e987d44a301ef5(kiosk);
  waittill_any_ents(player, "death", player, "last_stand_start", player, "exit_quick_purchase_zone", level, "game_ended");

  if(isDefined(player)) {
    function_5221f0c9bdea6589();
  }
}

function private function_ef547f1865e05653(var_97aa74c2193a9dc6) {
  player = self;
  player setclientomnvar("ui_buystation_purchase_response", var_97aa74c2193a9dc6);
}

function private function_c8bd59cde912455f(var_97aa74c2193a9dc6) {
  player = self;

  if(var_97aa74c2193a9dc6 == 1 && getdvarint(@ "hash_ed6e4ffa933af621", 1)) {
    if(!isDefined(player.br_kiosk) || !istrue(player.br_kiosk.var_a84a6acb3c2edcae)) {
      player function_ef547f1865e05653(1);
      return;
    }
  }

  player _closepurchasemenuwithresponse(var_97aa74c2193a9dc6);
}

function _closepurchasemenuwithresponse(var_97aa74c2193a9dc6) {
  player = self;
  player setclientomnvar("ui_buystation_purchase_response", var_97aa74c2193a9dc6);
  player setclientomnvar("ui_buystation_open", 1);
  player setclientomnvar("ui_buystation_override", -1);
  player setclientomnvar("ui_weapon_buystation_override", -1);
  player clearsoundsubmix("iw8_br_plunder_kiosk_menu");
  scripts\cp_mp\vehicles\vehicle_interact::function_fed77cd5c54efe19(player.var_c77002478cdfd85f, player);

  if(isDefined(player.br_kiosk)) {
    if(isDefined(player.br_kiosk) && isDefined(player.br_kiosk.playersusing) && array_contains(player.br_kiosk.playersusing, player)) {
      player.br_kiosk.playersusing = array_remove(player.br_kiosk.playersusing, player);
    }

    if(istrue(player.br_kiosk.var_a84a6acb3c2edcae)) {
      if(var_97aa74c2193a9dc6 == 1 && array_contains(player.br_kiosk.players, player)) {
        player.br_kiosk.players = array_remove(player.br_kiosk.players, player);
        player.br_kiosk.var_4261eb2ab67db6f7 = array_add(player.br_kiosk.var_4261eb2ab67db6f7, player);
        player.br_kiosk namespace_bd614c3c2275579a::function_648d8f21bd9dc5c4(player);

        if(player.br_kiosk.players.size <= 0 && !istrue(level.var_25e8b4afe5e06169)) {
          player.br_kiosk setscriptablepartstate("br_plunder_box_stronghold", "visible_blank");
        }
      }

      player setclientomnvar("ui_options_menu", 0);
    }
  }

  player.br_kiosk = undefined;
  player.var_e5b7a6a0ec2b440e = undefined;
  player.var_c77002478cdfd85f = undefined;
  player.armorykioskpurchaseallowed = undefined;
  player.var_192cbab14de92a20 = undefined;

  if(level.var_ee08b1f41e7c2444 && isDefined(player.var_b8993f862c953db4) && player.var_b8993f862c953db4) {
    player allowmovement(1);
    player.var_b8993f862c953db4 = 0;
  }

  scripts\mp\gametypes\br_analytics::branalytics_kiosk_menu_event(player, "menu_close", "reason: " + var_97aa74c2193a9dc6);
  player notify("_watchToAutoCloseMenu_end");
  player scripts\cp_mp\calloutmarkerping::function_faa3cbec7243fe72();
}

function _purchasemenuclosedbyclient(player) {
  player function_c8bd59cde912455f(0);
  player notify("_watchToAutoCloseMenu_end");
}

function watchtoautoclosemenu(kiosk) {
  player = self;
  player endon("disconnect");
  player notify("_watchToAutoCloseMenu_end");
  player endon("_watchToAutoCloseMenu_end");
  player childthread _proximitywatcher(kiosk);
  waittill_any_ents(player, "death", player, "last_stand_start", player, "pushed_too_far", level, "game_ended");

  if(isDefined(player.pers["telemetry"])) {
    if(istrue(player.pers["telemetry"].var_399eb9ea9da87875)) {
      player.pers["telemetry"].var_b04abd5d84312acb = 1;
      player.pers["telemetry"].var_399eb9ea9da87875 = 0;
    }
  }

  player function_c8bd59cde912455f(2);
}

function _proximitywatcher(kiosk) {
  if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && isint(kiosk)) {
    kiosk = self;
  }

  player = self;
  var_23d839b7d0ace88a = 64;
  var_525b03beaf285c54 = getdvarfloat(@ "hash_ecd52993b5dab130", 128) + var_23d839b7d0ace88a;
  maxdistsquared = var_525b03beaf285c54 * var_525b03beaf285c54;

  while(true) {
    wait 0.1;
    var_77c977c78b3f7d84 = distancesquared(player.origin, kiosk.origin);

    if(var_77c977c78b3f7d84 > maxdistsquared) {
      player notify("pushed_too_far");
      break;
    }
  }
}

function _getequipmentammotomax(equipmentref) {
  player = self;

  if(!isDefined(equipmentref)) {
    return 0;
  }

  ammo = player scripts\mp\equipment::getequipmentammo(equipmentref);
  ammomax = player scripts\mp\equipment::getequipmentmaxammo(equipmentref);
  return max(0, ammomax - ammo);
}

function _maxoutequipmentammo(equipmentref) {
  player = self;

  if(!isDefined(equipmentref)) {
    return 0;
  }

  ammo = player scripts\mp\equipment::getequipmentammo(equipmentref);
  ammomax = player scripts\mp\equipment::getequipmentmaxammo(equipmentref);

  if(ammo < ammomax) {
    player scripts\mp\equipment::setequipmentammo(equipmentref, ammomax);
  }
}

function function_8c8f1e3f153a6fa3() {}

function _findgivearmoramountanddropleftovers(fromkiosk, var_2737cac9ee8f6098) {
  player = self;
  armorcount = player scripts\mp\equipment::getequipmentslotammo("health");

  if(!isDefined(armorcount)) {
    armorcount = 0;
  }

  maxarmorcount = player scripts\mp\equipment::getequipmentmaxammo("equip_armorplate");

  if(getdvarint(@ "scr_br_alt_mode_gg", 0)) {
    bundlecount = 2;
  } else {
    bundlecount = 5;
  }

  var_bf203ce62dd1c99c = int(max(min(bundlecount, maxarmorcount - armorcount), 0));
  dropamount = bundlecount - var_bf203ce62dd1c99c;
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

  if(istrue(fromkiosk) && isDefined(player.br_kiosk)) {
    slotindex = player.br_kiosk scripts\mp\gametypes\br_pickups::function_4f4d537c794b2bf5();
    player.br_kiosk.dropstruct.dropidx = slotindex;
    dropstruct = player.br_kiosk.dropstruct;
  }

  if(namespace_aead94004cf4c147::function_7e103028c464ab9a("brloot_armor_plate")) {
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_armor_plate");
    fakepickup = spawnStruct();
    fakepickup.scriptablename = "brloot_armor_plate";
    fakepickup.count = dropamount;
    leftover = player namespace_aead94004cf4c147::additemtobackpack(lootid, fakepickup, 1);

    if(leftover > 0 && !istrue(var_2737cac9ee8f6098)) {
      baseorigin = player.origin;
      baseangles = player.angles;

      if(istrue(fromkiosk) && isDefined(player.br_kiosk)) {
        baseorigin = default_to(player.br_kiosk.centerbottom, player.br_kiosk.origin);
        baseangles = player.br_kiosk.angles;
      }

      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, player, undefined);
      scripts\mp\gametypes\br_pickups::spawnpickup("brloot_armor_plate", dropinfo, dropamount, 1);
    }
  } else if(dropamount > 0 && !istrue(var_2737cac9ee8f6098)) {
    baseorigin = player.origin;
    baseangles = player.angles;

    if(istrue(fromkiosk) && isDefined(player.br_kiosk)) {
      baseorigin = default_to(player.br_kiosk.centerbottom, player.br_kiosk.origin);
      baseangles = player.br_kiosk.angles;
    }

    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, player, undefined);
    scripts\mp\gametypes\br_pickups::spawnpickup("brloot_armor_plate", dropinfo, dropamount, 1);
  }

  return var_bf203ce62dd1c99c;
}

function _validateitempurchase(kiosk, itemdata, var_6dc0e605ecd21eee, var_7c3865dee4abed6, var_d260df4653b74cef) {
  player = self;
  var_3bdc75a8b6e7b7cd = ter_op(var_d260df4653b74cef, 2, 0);
  var_a55838d829a2c54b = ter_op(var_3bdc75a8b6e7b7cd == 2, 0, 1);

  if(istrue(itemdata.filtered)) {
    player function_c8bd59cde912455f(24);
    return 0;
  }

  var_b690d52fa5cc0957 = function_a0389e3244a68894(kiosk, itemdata.entryref);

  if(!istrue(var_b690d52fa5cc0957)) {
    player function_c8bd59cde912455f(24);
    return 0;
  }

  itemstock = function_6af40e269aae683e(kiosk, itemdata.entryref);

  if(isDefined(itemstock) && itemstock <= 0) {
    player function_c8bd59cde912455f(24);
    return 0;
  }

  var_fbd5fada61ae8341 = _getactualcost(player, itemdata);

  if(!isDefined(player.plundercount)) {
    player.plundercount = 0;
  }

  if(player.plundercount < var_fbd5fada61ae8341) {
    player function_c8bd59cde912455f(3);
    return 0;
  }

  if(isDefined(itemdata.var_41f94bca374ed58a)) {
    var_e75264e51d24bb57 = namespace_a38a2e1fe7519183::function_59352c09a417a5e2(player, itemdata.var_41f94bca374ed58a);

    var_539ff4424cd96b25 = getdvarint(@ "hash_7c258033cf2231ad", -1);

    if(var_539ff4424cd96b25 >= 0) {
      var_e75264e51d24bb57 = itemdata.var_41f94bca374ed58a == var_539ff4424cd96b25;
    }

    if(!var_e75264e51d24bb57) {
      return 0;
    }
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("kioskValidateItemPurchase")) {
    result = player scripts\mp\gametypes\br_gametypes::runbrgametypefunc("kioskValidateItemPurchase", kiosk, itemdata);

    if(isDefined(result)) {
      if(!istrue(result)) {
        return 0;
      } else {
        return 1;
      }
    }
  }

  if(itemdata.type == "killstreak") {
    if(!istrue(var_6dc0e605ecd21eee)) {
      if(player scripts\mp\gametypes\br_pickups::haskillstreak(itemdata.ref)) {
        if(var_a55838d829a2c54b) {
          player function_c8bd59cde912455f(4);
        }

        return var_3bdc75a8b6e7b7cd;
      }
    }
  } else if(itemdata.type == "fieldupgrade" || itemdata.type == "super") {
    if(player scripts\mp\supers::issuperinuse()) {
      if(var_a55838d829a2c54b) {
        player function_c8bd59cde912455f(6);
      }

      return var_3bdc75a8b6e7b7cd;
    }

    if(!istrue(var_6dc0e605ecd21eee)) {
      currentsuperref = player scripts\mp\supers::getcurrentsuperref();

      if(isDefined(currentsuperref) && itemdata.ref == currentsuperref) {
        if(var_a55838d829a2c54b) {
          player function_c8bd59cde912455f(5);
        }

        return var_3bdc75a8b6e7b7cd;
      }
    }
  } else if(itemdata.type == "perk") {
    if(player scripts\mp\utility\perk::_hasperk(itemdata.ref)) {
      if(var_a55838d829a2c54b) {
        player function_c8bd59cde912455f(5);
      }

      return var_3bdc75a8b6e7b7cd;
    }
  } else if(itemdata.type == "equipment") {
    if(istrue(var_7c3865dee4abed6)) {
      return 2;
    }

    var_6a8b46e184e181cc = spawnStruct();
    var_6a8b46e184e181cc.scriptablename = itemdata.entryref;
    var_6a8b46e184e181cc.count = 1;
    canpickupresult = scripts\mp\gametypes\br_pickups::cantakepickup(var_6a8b46e184e181cc, 1);

    switch (canpickupresult) {
      case 1:
      case 20:
        break;
      default:
        if(var_a55838d829a2c54b) {
          player function_c8bd59cde912455f(7);
        }

        return var_3bdc75a8b6e7b7cd;
    }
  } else if(itemdata.type == "weapon") {
    if(istrue(player.var_859654e0445a36d9)) {
      if(isDefined(level.br_pickups) && isDefined(level.br_pickups.var_355cddb773cb000d)) {
        player scripts\mp\hud_message::showerrormessage(level.br_pickups.var_355cddb773cb000d);
      }

      return 0;
    }

    newweapon = scripts\mp\gametypes\br_pickups::getfullweaponobjforscriptablepartname(itemdata.ref);

    if(isDefined(newweapon)) {
      foreach(weap in player.primaryweapons) {
        if(issameweapon(weap, newweapon)) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(7);
          }

          return 0;
        }
      }

      if(namespace_aead94004cf4c147::function_efab78b72d131d76(player)) {
        var_9ac5e72784815708 = namespace_aead94004cf4c147::function_2985254128b1c262(player);

        if(issameweapon(var_9ac5e72784815708, newweapon)) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(7);
          }

          return 0;
        }
      }
    }

    return 1;
  } else if(itemdata.type == "special" || itemdata.type == "persistent") {
    switch (itemdata.ref) {
      case #"hash_2dcde97962801ba9":
      case #"hash_25789111b74943b4":
      case #"hash_43f2312fe01322cf":
        if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
          var_6a8b46e184e181cc = spawnStruct();
          var_6a8b46e184e181cc.scriptablename = "brloot_armor_plate";

          if(itemdata.ref == "armor_bundle") {
            var_6a8b46e184e181cc.count = 5;
          } else {
            var_6a8b46e184e181cc.count = 1;
          }

          canpickupresult = scripts\mp\gametypes\br_pickups::cantakepickup(var_6a8b46e184e181cc);

          if(canpickupresult != 1) {
            if(var_a55838d829a2c54b) {
              player function_c8bd59cde912455f(7);
            }

            return var_3bdc75a8b6e7b7cd;
          }
        }

        break;
      case #"hash_a7a7446a3194cb49":
        var_1f158ccaa5d9c0be = scripts\cp_mp\armor::function_92fec40b905c5112();

        if(!var_1f158ccaa5d9c0be) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(7);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_1b71e2c3430cd301":
      case #"hash_2d1a1b811aed6b26":
      case #"hash_dcf82d1f65a6b16e":
      case #"hash_d01e387e6d238502":
      case #"hash_4808e1f340e11163":
        if(istrue(var_7c3865dee4abed6)) {
          return 2;
        }

        var_6a8b46e184e181cc = spawnStruct();
        var_6a8b46e184e181cc.scriptablename = scripts\cp_mp\gasmask::getscriptablename(itemdata.ref);
        assert(isDefined(var_6a8b46e184e181cc.scriptablename));
        var_6a8b46e184e181cc.count = scripts\cp_mp\gasmask::getmaxhealth(var_6a8b46e184e181cc.scriptablename);
        canpickupresult = scripts\mp\gametypes\br_pickups::cantakepickup(var_6a8b46e184e181cc, 1);

        switch (canpickupresult) {
          case 1:
          case 20:
            break;
          default:
            if(var_a55838d829a2c54b) {
              player function_c8bd59cde912455f(7);
            }

            return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_e67a71b27007444":
        if(istrue(var_7c3865dee4abed6)) {
          return 2;
        }

        var_b1db5698237fe274 = 0;

        if(player _getequipmentammotomax(player.equipment["primary"]) > 0) {
          var_b1db5698237fe274 = 1;
        } else if(player _getequipmentammotomax(player.equipment["secondary"]) > 0) {
          var_b1db5698237fe274 = 1;
        } else if(!player scripts\mp\gametypes\br_weapons::br_ammo_player_is_maxed_out()) {
          var_b1db5698237fe274 = 1;
        }

        if(!var_b1db5698237fe274) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(7);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_3839e36b1d747574":
      case #"hash_6613e243265c4795":
        if(scripts\mp\gametypes\br_pickups::respawntokendisabled()) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(9);
          }

          return 0;
        }

        if(istrue(var_7c3865dee4abed6)) {
          return 2;
        }

        if(istrue(player.hasrespawntoken)) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(10);
          }

          return 0;
        }

        break;
      case #"hash_f7eba4352eb7f7ba":
        if(scripts\mp\gametypes\br_public::function_8b2396647673be50()) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(9);
          }

          return 0;
        }

        if(istrue(var_7c3865dee4abed6)) {
          return 2;
        }

        if(istrue(player scripts\mp\gametypes\br_public::function_15da77dc195bd80a())) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(10);
          }

          return 0;
        }

        break;
      case #"hash_1c3e21ffbc842487":
      case #"hash_4f292feb06ad9942":
        if(istrue(var_7c3865dee4abed6)) {
          return 2;
        }

        if(player scripts\mp\gametypes\br_public::hasselfrevivetoken()) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(10);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_3a0285dc5b457e3a":
        if(istrue(var_7c3865dee4abed6)) {
          return 2;
        }

        var_6a8b46e184e181cc = spawnStruct();
        var_6a8b46e184e181cc.scriptablename = "brloot_offhand_advancedsupplydrop";
        var_6a8b46e184e181cc.count = 1;
        canpickupresult = scripts\mp\gametypes\br_pickups::cantakepickup(var_6a8b46e184e181cc, 1);

        if(canpickupresult != 1) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(7);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_b41ab83f39326993":
        if(isDefined(level.br_circle)) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(17);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_532a5678aa4979f3":
        if(isDefined(level.br_circle) || istrue(level.brgametype.circlerunning)) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(9);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_83584572ba67a745":
        if(!player function_334bee7871c3ae0f()) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(21);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_546ee28ea1d0dc10":
        if(!player function_ff0081ca56b5a384("armor")) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(20);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_99e995f94c6d662b":
        if(!player function_a037837dc6c85636()) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(19);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_63edc28701e80b73":
        if(!player function_ff0081ca56b5a384("trophy")) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(20);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_8db3828479a5780b":
        if(!player function_ff0081ca56b5a384("uav")) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(20);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_7cf102dbc7cbbbc5":
        if(!player function_ff0081ca56b5a384("barrel")) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(20);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_63d4978a15e681a8":
        if(!player scripts\mp\gametypes\br_gametype_truckwar::function_81124b7b16101f8b()) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(23);
          }

          return 0;
        }

        break;
      case #"hash_5cdbaa0bf3e5ebfe":
      case #"hash_75ca97f27fab119c":
      case #"hash_8709a7ef11ecdbea":
      case #"hash_ac45395faab66eb2":
      case #"hash_ac453a5faab67045":
      case #"hash_a500f53d3e52d6e":
        if(istrue(var_7c3865dee4abed6)) {
          return 1;
        }

        var_6a8b46e184e181cc = spawnStruct();
        var_6a8b46e184e181cc.scriptablename = itemdata.entryref;
        var_6a8b46e184e181cc.count = 1;
        canpickupresult = scripts\mp\gametypes\br_pickups::cantakepickup(var_6a8b46e184e181cc);

        switch (canpickupresult) {
          case 1:
          case 20:
            break;
          default:
            if(var_a55838d829a2c54b) {
              player function_c8bd59cde912455f(7);
            }

            return var_3bdc75a8b6e7b7cd;
        }
      case #"hash_a179b8412a3a0354":
      case #"hash_a179bb412a3a080d":
      case #"hash_a2240c78d2ced063":
      case #"hash_6235851dae0eeca8":
      case #"hash_2fc44f64748f8c8e":
      case #"hash_baa7a6f9de5c563d":
      case #"hash_bb639a6ed9e9b88a":
      case #"hash_bbf617dca645120c":
      case #"hash_bbf61adca64516c5":
      case #"hash_2e68cd53eaf9b329":
      case #"hash_2e68ca53eaf9ae70":
      case #"hash_dda8890cb35ca0bf":
      case #"hash_e4154ddbab061c63":
      case #"hash_f6bd03bdc3846abe":
      case #"hash_6c0c806bbf705a0c":
      case #"hash_fd8da3bdddb8e1c2":
        objective = undefined;

        if(isDefined(level.var_d23c7c1add9fb181)) {
          objective = player[[level.var_d23c7c1add9fb181]]();
        }

        if(isDefined(objective) && isDefined(level.var_4de8052758f986f3) && [[level.var_4de8052758f986f3]](objective.objectivekey, player.team, itemdata.ref)) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(17);
          }

          return var_3bdc75a8b6e7b7cd;
        }

        break;
      case #"hash_bd3c5bede4f8165f":
      case #"hash_c31089e2e50b5079":
        break;
      case #"hash_9789620b82d8908c":
      case #"hash_f0fd4758cf2900f0":
      case #"hash_f4fe496941705c28":
        break;
      case #"hash_76bc74c0e064def4":
      case #"hash_b1354cc795fd9a39":
        itemname = getsubstr(itemdata.ref, 7);

        if(player scripts\mp\gametypes\br_pickups::function_e351a4b1c26ec991(itemname)) {
          if(var_a55838d829a2c54b) {
            player function_c8bd59cde912455f(17);
          }

          return 0;
        }

        break;
    }
  } else if(itemdata.type == "secondary_victory") {
    if(isDefined(level.secondaryvictory) && isDefined(level.secondaryvictory.var_228bbb92952e5f9f)) {
      response = [[level.secondaryvictory.var_228bbb92952e5f9f]]();

      if(response == 1 || response == 2) {
        return 1;
      } else {
        player function_c8bd59cde912455f(response);
        return 0;
      }
    } else {
      return 0;
    }
  }

  return 1;
}

function _killstreakneedslocationselection(killstreakref) {
  switch (killstreakref) {
    case #"hash_8c766d6477287bb6":
    case #"hash_b4ac3581c343a029":
      return 1;
    case #"hash_634b246c3da5c56f":
      return 0;
    default:
      assertmsg("<dev string:x1b9>" + killstreakref);
      return 0;
  }
}

function _locationselectioninterrupt() {
  player = self;
  waittill_any_ents(player, "death", level, "game_ended");
  player notify("cancel_location");
}

function _handlekillstreakpurchase(itemdata, dropcurrent, droppurchased, var_db943473454f6ea6) {
  player = self;
  player endon("disconnect");
  activateimmediately = getdvarint(@ "hash_e516a6aa0d85b36d", 0);

  if(!activateimmediately) {
    player scripts\mp\gametypes\br_pickups::forcegivekillstreak(itemdata.ref, dropcurrent, 1, droppurchased, var_db943473454f6ea6);
    function_a573b91325f9ea32(player, itemdata, "killstreak", "br_killstreak_purchased");
    return;
  }

  if(_killstreakneedslocationselection(itemdata.ref)) {
    var_6eb64f3fea3bbe81 = player.br_kiosk;
    player function_c8bd59cde912455f(16);
    player scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "kiosk");
    player beginlocationselection(0, 0, "circle_marker", 0, 4);
    player childthread _locationselectioninterrupt();
    returninfo = player scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("confirm_location", "cancel_location");
    player endlocationselection();
    player scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "kiosk");

    if(isDefined(returninfo) && returninfo.string == "confirm_location") {
      locationtrace = scripts\mp\gametypes\br::traceselectedmaplocation(returninfo.location);
      player.kstargetlocation = locationtrace["position"];
      usesuccess = player scripts\mp\gametypes\br_pickups::forceusekillstreak(itemdata.ref);

      if(istrue(usesuccess)) {
        function_a573b91325f9ea32(player, itemdata, "killstreak", "br_killstreak_purchased_and_activated");
      }
    } else {
      player thread _runpurchasemenu(var_6eb64f3fea3bbe81);
    }

    return;
  }

  player scripts\mp\gametypes\br_pickups::forcegivekillstreak(itemdata.ref, dropcurrent, 1, var_db943473454f6ea6);
  usesuccess = player scripts\mp\gametypes\br_pickups::forceusekillstreak(itemdata.ref);

  if(istrue(usesuccess)) {
    function_a573b91325f9ea32(player, itemdata, "killstreak", "br_killstreak_purchased_and_activated");
  }
}

function function_90b0e9eb26e38443(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  scriptablename = itemdata.ref;
  var_bada25504e8844d7 = spawnStruct();
  var_bada25504e8844d7.scriptablename = scriptablename;
  var_bada25504e8844d7.origin = self.origin;
  var_bada25504e8844d7.count = 1;
  var_bada25504e8844d7.maxcount = level.br_pickups.maxcounts[scriptablename];
  var_bada25504e8844d7.stackable = level.br_pickups.stackable[scriptablename];
  [ammo, ammoleft, var_35ead47ed0d7507e] = scripts\mp\gametypes\br_gametype_dmz::getdefaultweaponammo(level.br_lootiteminfo[scriptablename].fullweaponobj);
  var_bada25504e8844d7.count = ammo * 3;
  var_bada25504e8844d7.countlefthand = ammoleft;
  var_bada25504e8844d7.countalt = var_35ead47ed0d7507e;
  scripts\mp\gametypes\br_weapons::takeweaponpickup(var_bada25504e8844d7, undefined, undefined, undefined, 1);
  function_a573b91325f9ea32(self, itemdata, "weapon");
}

function _handlefieldupgradepurchase(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  if(scripts\mp\supers::issuperinuse()) {
    var_733d60a5f3a8c170 = undefined;

    foreach(scriptablename, supername in level.br_pickups.var_14bd11727c4b6629) {
      if(supername == itemdata.ref) {
        var_733d60a5f3a8c170 = scriptablename;
        break;
      }
    }

    if(isDefined(var_733d60a5f3a8c170)) {
      fakepickup = spawnStruct();
      fakepickup.scriptablename = var_733d60a5f3a8c170;
      fakepickup.count = 1;
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_733d60a5f3a8c170);
      namespace_aead94004cf4c147::additemtobackpack(lootid, fakepickup, undefined, undefined, 1);
      function_a573b91325f9ea32(self, itemdata, "fieldUpgrade", "br_field_upgrade_purchased");
    }

    return;
  }

  scripts\mp\gametypes\br_pickups::forcegivesuper(itemdata.ref, var_7dddac09987d559e, 1, var_452130d9d126e506, var_db943473454f6ea6);
  function_a573b91325f9ea32(self, itemdata, "fieldUpgrade", "br_field_upgrade_purchased");

  if((level.allowsupers || scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe()) && !istrue(var_452130d9d126e506)) {
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);
  }
}

function function_b140d6e72b665c8f(itemdata, var_7dddac09987d559e, var_452130d9d126e506, kiosk) {
  player = self;
  purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, itemdata.entryref, 1, undefined, 1, var_452130d9d126e506);

  if(!purchasesuccess) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

    if(isDefined(kiosk.dropstruct)) {
      slotindex = kiosk scripts\mp\gametypes\br_pickups::function_4f4d537c794b2bf5();
      kiosk.dropstruct.dropidx = slotindex;
      dropstruct = kiosk.dropstruct;
    }

    count = 1;

    if(scripts\mp\gametypes\br_pickups::function_d345eec68e01361f(itemdata.lootid, itemdata.entryref)) {
      count = level.br_pickups.counts[itemdata.entryref];
    }

    var_285b7129b392cf3d = kiosk scripts\mp\gametypes\br_pickups::quickdropaddtoexisting(undefined, itemdata.entryref, count);

    if(!var_285b7129b392cf3d) {
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, default_to(kiosk.centerbottom, kiosk.origin), kiosk.angles, player);
      pickupent = scripts\mp\gametypes\br_pickups::spawnpickup(itemdata.entryref, dropinfo, count, 1, undefined, 0);
      kiosk scripts\mp\gametypes\br_pickups::quickdropaddtocache(itemdata.entryref, undefined, pickupent, dropinfo.origin, dropinfo.angles);
    }

    purchasesuccess = 1;
  }

  if(purchasesuccess) {
    function_a573b91325f9ea32(player, itemdata, "equipment", "br_item_purchased");
  }

  if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
    if(isDefined(level.var_8ec1a1ca587a6487)) {
      player[[level.var_8ec1a1ca587a6487]](itemdata.ref);
    }
  }

  scripts\mp\gametypes\br_armory_kiosk::armorykioskused(kiosk, undefined, undefined, self);
}

function function_bddeda747a14d679(purchasesuccess, kiosk, player, scriptablename, count, shoulddrop, quickdropcache) {
  if(!purchasesuccess && shoulddrop) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

    if(isDefined(kiosk.dropstruct)) {
      slotindex = kiosk scripts\mp\gametypes\br_pickups::function_4f4d537c794b2bf5();
      kiosk.dropstruct.dropidx = slotindex;
      dropstruct = kiosk.dropstruct;
    }

    var_285b7129b392cf3d = 0;

    if(istrue(quickdropcache)) {
      var_285b7129b392cf3d = kiosk scripts\mp\gametypes\br_pickups::quickdropaddtoexisting(undefined, scriptablename, count);
    }

    if(!var_285b7129b392cf3d) {
      baseorigin = default_to(kiosk.centerbottom, kiosk.origin);

      if(isDefined(kiosk.linkedparent)) {
        baseorigin = kiosk.linkedparent.origin + rotatevector(baseorigin, kiosk.linkedparent.angles);
      }

      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, baseorigin, kiosk.angles, player);
      pickupent = scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, count, 1, undefined, 0);

      if(istrue(quickdropcache)) {
        kiosk scripts\mp\gametypes\br_pickups::quickdropaddtocache(scriptablename, undefined, pickupent, dropinfo.origin, dropinfo.angles);
      }
    }

    return 1;
  }

  assert(purchasesuccess);
  return purchasesuccess;
}

function _handlespecialpurchase(itemdata, var_7dddac09987d559e, var_452130d9d126e506, kiosk, var_682e4b53880a6720, var_db943473454f6ea6) {
  player = self;
  shoulddrop = var_7dddac09987d559e && var_682e4b53880a6720;
  purchasesuccess = 1;
  var_b517df938986556f = 1;
  armorcount = undefined;
  quantity = 1;
  overridedist = undefined;

  switch (itemdata.ref) {
    case #"hash_43f2312fe01322cf":
    case #"hash_25789111b74943b4":
      purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, "brloot_armor_plate", 1, undefined, 1, var_452130d9d126e506);
      purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, player, "brloot_armor_plate", 1, shoulddrop, 1);
      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_armor_plate");
      break;
    case #"hash_2dcde97962801ba9":
      var_2b83f7cf5dd2cf23 = player _findgivearmoramountanddropleftovers(1);

      if(var_2b83f7cf5dd2cf23 <= 0) {
        purchasesuccess = 1;
      } else {
        purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, "brloot_armor_plate", 1, var_2b83f7cf5dd2cf23, 1, var_452130d9d126e506);
      }

      purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, player, "brloot_armor_plate", var_2b83f7cf5dd2cf23, shoulddrop, 1);
      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_armor_plate");
      quantity = var_2b83f7cf5dd2cf23;
      break;
    case #"hash_4808e1f340e11163":
      gasmaskscriptablename = "brloot_equip_gasmask";
      purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, gasmaskscriptablename, 1, undefined, 1, var_452130d9d126e506);
      purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, player, gasmaskscriptablename, 108, shoulddrop);
      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(gasmaskscriptablename);
      break;
    case #"hash_dcf82d1f65a6b16e":
      gasmaskscriptablename = "brloot_equip_gasmask";
      purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, gasmaskscriptablename, 1, undefined, 1, var_452130d9d126e506);
      purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, player, gasmaskscriptablename, 108, shoulddrop);
      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(gasmaskscriptablename);
      break;
    case #"hash_e67a71b27007444":
      player scripts\mp\gametypes\br_weapons::br_ammo_player_max_out();
      player _maxoutequipmentammo(player.equipment["primary"]);
      player _maxoutequipmentammo(player.equipment["secondary"]);
      break;
    case #"hash_6613e243265c4795":
    case #"hash_3839e36b1d747574":
      player scripts\mp\gametypes\br_pickups::addrespawntoken();
      var_b517df938986556f = 0;
      break;
    case #"hash_f7eba4352eb7f7ba":
      purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, "brloot_gulag_token", 1, undefined, 1, var_452130d9d126e506);
      break;
    case #"hash_1c3e21ffbc842487":
      var_5db3e79ef6900447 = "brloot_self_revive";

      if(istrue(var_452130d9d126e506)) {
        purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, var_5db3e79ef6900447, 1, undefined, 1, var_452130d9d126e506);
        purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, player, var_5db3e79ef6900447, 1, 0);
      } else if(player scripts\mp\gametypes\br_public::hasselfrevivetoken()) {
        purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, var_5db3e79ef6900447, 1, undefined, 1, var_452130d9d126e506);
        purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, player, var_5db3e79ef6900447, 1, shoulddrop);
      } else {
        player scripts\mp\gametypes\br_pickups::addselfrevivetoken();
      }

      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_5db3e79ef6900447);
      var_b517df938986556f = 0;
      break;
    case #"hash_4f292feb06ad9942":
      var_5db3e79ef6900447 = "brloot_self_revive";

      if(istrue(var_452130d9d126e506)) {
        purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, var_5db3e79ef6900447, 1, undefined, 1, var_452130d9d126e506);
        purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, player, var_5db3e79ef6900447, 1, 0);
      } else if(player scripts\mp\gametypes\br_public::hasselfrevivetoken()) {
        purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, var_5db3e79ef6900447, 1, undefined, 1, var_452130d9d126e506);
        purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, player, var_5db3e79ef6900447, 1, shoulddrop);
      } else {
        player scripts\mp\gametypes\br_pickups::addselfrevivetoken();
      }

      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(var_5db3e79ef6900447);
      var_b517df938986556f = 0;
      break;
    case #"hash_3a0285dc5b457e3a":
      purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, "brloot_offhand_advancedsupplydrop", 1, undefined, 1, var_452130d9d126e506);
      purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, player, "brloot_offhand_advancedsupplydrop", 1, shoulddrop);
      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_offhand_advancedsupplydrop");
      break;
    case #"hash_b41ab83f39326993":
      purchasesuccess = player playerhandlecirclepickitem();
      break;
    case #"hash_532a5678aa4979f3":
      purchasesuccess = player playerhandleredeploy();
      break;
    case #"hash_83584572ba67a745":
      purchasesuccess = player _handlevehiclerepair();
      break;
    case #"hash_546ee28ea1d0dc10":
      purchasesuccess = player function_388aa30e37abbb0("armor");
      var_b517df938986556f = 0;
      break;
    case #"hash_99e995f94c6d662b":
      purchasesuccess = player function_9fc999a4450eacb2("trophy_refill");
      var_b517df938986556f = 0;
      break;
    case #"hash_63edc28701e80b73":
      purchasesuccess = player function_388aa30e37abbb0("trophy");
      var_b517df938986556f = 0;
      break;
    case #"hash_8db3828479a5780b":
      purchasesuccess = player function_388aa30e37abbb0("uav");
      var_b517df938986556f = 0;
      break;
    case #"hash_7cf102dbc7cbbbc5":
      purchasesuccess = player function_388aa30e37abbb0("barrel");
      var_b517df938986556f = 0;
      break;
    case #"hash_3b012bc05e7f47ab":
      purchasesuccess = player function_388aa30e37abbb0("turret");
      var_b517df938986556f = 0;
      break;
    case #"hash_7bdbc30d7514e1da":
      purchasesuccess = player function_388aa30e37abbb0("smoke");
      var_b517df938986556f = 0;
      break;
    case #"hash_cde24a9cca75ace7":
      purchasesuccess = player function_388aa30e37abbb0("engine");
      var_b517df938986556f = 0;
      break;
    case #"hash_63d4978a15e681a8":
      purchasesuccess = player function_202bf25cc40d87b4(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      var_b517df938986556f = 0;
      break;
    case #"hash_d63b8f48fb92540d":
    case #"hash_9396a18356201b4a":
      purchasesuccess = player _handlevehiclepurchase(itemdata, var_7dddac09987d559e);

      if(purchasesuccess) {
        player thread scripts\mp\hud_message::showsplash("br_vehicle_purchased");
      } else {
        player scripts\mp\hud_message::showerrormessage("MP/VEHICLE_PURCHASE_FAILED");
      }

      break;
    case #"hash_631c673653b33de8":
      if(isDefined(level.secondaryvictory)) {
        var_b517df938986556f = 0;
        purchasesuccess = 1;

        if(isDefined(level.secondaryvictory.onkioskpurchase)) {
          player[[level.secondaryvictory.onkioskpurchase]](itemdata.cost);
        }
      }

      break;
    case #"hash_488cf778b792ae68":
      purchasesuccess = player namespace_25b25d188ef778c4::function_7ff5e35e992df372();

      if(purchasesuccess) {
        players = scripts\mp\utility\teams::getteamdata(player.team, "players");

        foreach(teammate in players) {
          teammate setclientomnvar("ui_owns_personal_exfil", 1);
          teammate.var_5a4d470f2093fff1 = 1;
        }

        player thread scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_exfil_purchased", players);
      } else {
        player scripts\mp\hud_message::showerrormessage("DMZ/EXFIL_PURCHASED_FAILED");
      }

      break;
    case #"hash_e1f05d0a4963cf16":
    case #"hash_1b71e2c3430cd301":
    case #"hash_2d1a1b811aed6b26":
    case #"hash_d01e387e6d238502":
      count = scripts\cp_mp\gasmask::getmaxhealth(itemdata.ref);
      purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, itemdata.entryref, 1, count, 1, var_452130d9d126e506);
      purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, player, itemdata.entryref, count, shoulddrop);
      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(itemdata.entryref);
      break;
    case #"hash_2018bfed562022d2":
    case #"hash_20325b59c2da2936":
    case #"hash_210f3d6b4b08bd07":
    case #"hash_2bc7ffbdef75ed18":
    case #"hash_3d84e9db23ad073b":
    case #"hash_5af11de11fded396":
    case #"hash_5cdbaa0bf3e5ebfe":
    case #"hash_6dad43a1ac2837c4":
    case #"hash_75ca97f27fab119c":
    case #"hash_7831706d83a17090":
    case #"hash_8709a7ef11ecdbea":
    case #"hash_88c36c9296658e86":
    case #"hash_95671226354aabf5":
    case #"hash_ac45395faab66eb2":
    case #"hash_ac453a5faab67045":
    case #"hash_aedd3497c0500b02":
    case #"hash_b96c2612a81aa097":
    case #"hash_e6923f1a8d2fa559":
    case #"hash_dcdeb92788aa1513":
    case #"hash_e005f0e4596a34f3":
    case #"hash_ed2b8ec873f222c8":
    case #"hash_ee0eccfbafbb6d43":
    case #"hash_f6715e451a157da4":
    case #"hash_a500f53d3e52d6e":
      purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(player, itemdata.entryref, 1, undefined, 1, var_452130d9d126e506);
      purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, player, itemdata.entryref, 1, shoulddrop);
      itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(itemdata.entryref);
      break;
    case #"hash_baa7a6f9de5c563d":
    case #"hash_bb639a6ed9e9b88a":
    case #"hash_bbf617dca645120c":
    case #"hash_bbf61adca64516c5":
    case #"hash_a179b8412a3a0354":
    case #"hash_2fc44f64748f8c8e":
    case #"hash_2e68cd53eaf9b329":
    case #"hash_a179bb412a3a080d":
    case #"hash_2e68ca53eaf9ae70":
    case #"hash_dda8890cb35ca0bf":
    case #"hash_a2240c78d2ced063":
    case #"hash_e4154ddbab061c63":
    case #"hash_6235851dae0eeca8":
    case #"hash_f0fd4758cf2900f0":
    case #"hash_f4fe496941705c28":
    case #"hash_6c0c806bbf705a0c":
    case #"hash_f6bd03bdc3846abe":
    case #"hash_9789620b82d8908c":
    case #"hash_fd8da3bdddb8e1c2":
      purchasesuccess = isDefined(level.var_3ce1055115edcbbb) && [[level.var_3ce1055115edcbbb]](player, itemdata.ref);
      break;
    case #"hash_bd3c5bede4f8165f":
      purchasesuccess = isDefined(level.skydiveredeploy);
      player thread[[level.skydiveredeploy]]();
      break;
    case #"hash_c31089e2e50b5079":
      purchasesuccess = 1;
      player thread scripts\mp\hud_message::showkillstreaksplash("sentry_gun");
      player scripts\mp\killstreaks\killstreaks::awardkillstreak("sentry_gun", "other", undefined, undefined, undefined, 0);
      break;
    case #"hash_a7a7446a3194cb49":
      purchasesuccess = scripts\cp_mp\armor::function_92fec40b905c5112();
      break;
    case #"hash_b0eb18371d980895":
      purchasesuccess = 1;
      player.supportcranked = 1;
      player thread[[level.var_68a1353068460d1]]();
      break;
    case #"hash_76e7f1333202ca0":
      player.var_89bd3a34ac165f4f = 1;
      player scripts\mp\gametypes\br_dom_gulag::function_37f6a694b8c6656a();
      break;
    case #"hash_499bd626715353e3":
    case #"hash_4ce6dd1c9ebdc3ec":
      player scripts\mp\gametypes\br_pickups::function_7cb3c8630787467e(itemdata.ref);
      break;
    case #"hash_197fd1ba9278b715":
    case #"hash_f2a746c0bddd2c8c":
      weapon_name = getsubstr(itemdata.entryref, 14) + "_mp";
      weapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(weapon_name);
      dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
      object = scripts\mp\gametypes\br_lootcache::lootspawnitem(weapon, dropstruct, kiosk.origin, kiosk.angles, 0, 0);
      break;
    default:
      supported = 0;

      if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("kioskHandleSpecialPurchase")) {
        [supported, purchasesuccess, var_b517df938986556f, quantity] = player scripts\mp\gametypes\br_gametypes::function_d72af9ccedfc923b("kioskHandleSpecialPurchase", itemdata, var_7dddac09987d559e, var_452130d9d126e506, kiosk, purchasesuccess, var_b517df938986556f, quantity);
      }

      if(!supported) {
        assertmsg("<dev string:x1e2>" + itemdata.ref);
      }

      break;
  }

  if(purchasesuccess) {
    splash = undefined;

    if(var_b517df938986556f) {
      splash = "br_item_purchased";
    }

    function_a573b91325f9ea32(player, itemdata, "special", splash, quantity);
  }

  if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a()) {
    if(isDefined(level.var_8ec1a1ca587a6487)) {
      player[[level.var_8ec1a1ca587a6487]](itemdata.ref);
    }

    scripts\mp\gametypes\br_armory_kiosk::armorykioskused(0, undefined, undefined, self);
  }
}

function function_202bf25cc40d87b4(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  dummydata = spawnStruct();
  purchasesuccess = 0;
  scripts\mp\gametypes\br_gametype_truckwar::function_60d5992f51286201();

  if(scripts\mp\gametypes\br_gametype_truckwar::function_59566a4ce3c2c3e2()) {
    assertex(isDefined(level.br_pickups.var_14bd11727c4b6629["<dev string:x1fe>"]), "<dev string:x224>");
    dummydata.ref = level.br_pickups.var_14bd11727c4b6629["brloot_offhand_advancedvehicledrop"];

    if(scripts\mp\supers::issuperinuse()) {
      fakepickup = spawnStruct();
      fakepickup.scriptablename = "brloot_offhand_advancedvehicledrop";
      fakepickup.count = 1;
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_offhand_advancedvehicledrop");
      namespace_aead94004cf4c147::additemtobackpack(lootid, fakepickup, undefined, undefined, 1);
    } else {
      scripts\mp\gametypes\br_pickups::forcegivesuper(dummydata.ref, var_7dddac09987d559e, 1, var_452130d9d126e506, var_db943473454f6ea6);

      if((level.allowsupers || scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe()) && !istrue(var_452130d9d126e506)) {
        scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);
      }
    }

    purchasesuccess = 1;
  } else {
    dummydata.ref = "veh9_mil_lnd_mrap";
    purchasesuccess = _handlevehiclepurchase(dummydata, var_7dddac09987d559e, 1);

    if(purchasesuccess) {
      thread scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("truckwar_vehicle_deploying", level.teamdata[self.team]["players"]);
    } else {
      thread scripts\mp\hud_message::showerrormessage("MP/VEHICLE_PURCHASE_FAILED");
    }
  }

  return purchasesuccess;
}

function _handlevehiclepurchase(itemdata, var_7dddac09987d559e, var_5c529b214774f72d) {
  assertex(isDefined(self.br_kiosk), "<dev string:x2bf>");
  var_26d956b5a9e59a2e = (1, 1, 1);
  var_10a5a10c444aefbb = (1, 0, 0);
  var_42b28c7586481d92 = (0, 1, 0);
  var_1efdce79e6a210ae = (0, 1, 1);
  dbgradius = 3;
  dbgtime = 8;

  if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle(itemdata.ref, undefined, undefined, "KIOSK")) {
    return false;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    return false;
  }

  isontrain = scripts\cp_mp\utility\train_utility::player_standing_on_train();
  spawndata = spawnStruct();

  if(isDefined(self.br_kiosk.vehiclespawn)) {
    spawndata.origin = self.br_kiosk.vehiclespawn.origin;
    spawndata.angles = self.br_kiosk.vehiclespawn.angles;
  }

  if(!isDefined(spawndata.origin)) {
    if(isontrain) {
      spawndata.origin = self.br_kiosk.origin + anglesToForward(self.br_kiosk.angles) * -150 + (0, 0, 60);
    } else {
      spawndata.origin = self.br_kiosk.origin + anglesToForward(self.br_kiosk.angles) * 100 + (0, 0, 60);
    }
  }

  if(!isDefined(spawndata.angles)) {
    spawndata.angles = (0, self.br_kiosk.angles[1] + 90, 0);
  }

  if(istrue(var_5c529b214774f72d)) {
    spawndata.var_427538f5a2ad4f8b = 1;
    spawndata.var_ec76ffdbe2f37c5b = 1;
    spawndata.var_65da0a245b653cc = 1;
    spawndata.var_d04816fe2f5bcee6 = 1;
  }

  if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_checkspawnclearance(spawndata.origin, itemdata.ref)) {
    return false;
  }

  thread function_3f45b3c575ec001b(itemdata, spawndata, var_5c529b214774f72d);
  return true;
}

function function_3f45b3c575ec001b(itemdata, spawndata, var_5c529b214774f72d) {
  level endon("game_ended");
  spawndata.spawntype = "KIOSK";

  if(scripts\cp_mp\vehicles\vehicle_airdrop::function_ccdcf48542c8a5b7(itemdata.ref)) {
    vehicle = scripts\cp_mp\vehicles\vehicle_airdrop::vehicle_airdrop(itemdata.ref, spawndata);
  } else {
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(itemdata.ref, spawndata);
  }

  if(istrue(var_5c529b214774f72d)) {
    scripts\mp\gametypes\br_gametype_truckwar::function_20b77fbf1af1a5d(vehicle, self.team, 1);
    thread scripts\mp\gametypes\br_gametype_truckwar::function_c1bfb96a5e39a0a7(vehicle);
    thread scripts\mp\gametypes\br_gametype_truckwar::function_2d381b790dc27f9f(vehicle);
    vehicle setscriptablepartstate("tag_buystation", "buystation_usable");
    scripts\mp\gametypes\br_gametype_truckwar::function_d5d633c35998ebe7(self.team);
    thread scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("truckwar_vehicle_spawn_enabled", level.teamdata[self.team]["alivePlayers"]);
  }

  if(!isDefined(vehicle)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_preventrespawn(vehicle);

  if(isDefined(self)) {
    newpingindex = scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(21, (0, 0, 100), vehicle getentitynumber());
    vehicle thread scripts\cp_mp\calloutmarkerping::function_9a7200f5142066ba(self, newpingindex, ["death"], ["vehicle_owner_update"]);
  }
}

function function_334bee7871c3ae0f() {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    if(vehicle.health == vehicle.maxhealth) {
      return false;
    }

    return true;
  }

  return false;
}

function function_a037837dc6c85636() {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    if(isDefined(vehicle.trophyammo) && isDefined(vehicle.var_c1cc7f4fbebfb815) && vehicle.trophyammo == vehicle.var_c1cc7f4fbebfb815) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}

function function_ff0081ca56b5a384(upgradetype) {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, upgradetype)) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}

function _handlevehiclerepair(itemdata, var_7dddac09987d559e) {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    if(vehicle.health == vehicle.maxhealth) {
      return false;
    }

    var_6d294b74de0d301e = getdvarfloat(@ "hash_3c1b0adf9da014a0", 0.25);
    var_e4f8ad64a6e67d4b = int(vehicle.maxhealth * var_6d294b74de0d301e);
    vehicle scripts\cp_mp\vehicles\vehicle_damage::function_653b96ce8310763e(var_e4f8ad64a6e67d4b);
    playsoundatpos(vehicle.origin + (0, 0, 20), "veh_truckwars_repair");
    scripts\mp\gametypes\br_gametype_truckwar::function_35f2ff0427594776(vehicle);

    if(istrue(vehicle.var_4f3e23ee48660f12)) {
      scripts\mp\gametypes\br_gametype_truckwar::function_e9b1e17b0d0ba3(vehicle);
    }

    players = scripts\mp\utility\teams::getteamdata(self.team, "players");

    foreach(player in players) {
      if(getdvarint(@ "hash_38d15e2d7ddbf066", 1) == 1) {
        player hudicontype("truckheal");
      }

      player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", vehicle.health);
      player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", vehicle.maxhealth);
    }

    return true;
  }

  return false;
}

function function_9fc999a4450eacb2(upgradetype) {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    scripts\cp_mp\vehicles\vehicle_interact::function_c4b9d8e33849435e(vehicle, upgradetype, player);
    return true;
  }

  return false;
}

function function_388aa30e37abbb0(upgradetype) {
  player = self;
  vehicle = player.var_c77002478cdfd85f;

  if(isDefined(vehicle)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::function_97c32f66eff29610(vehicle, upgradetype)) {
      return false;
    } else {
      scripts\cp_mp\vehicles\vehicle_interact::function_c4b9d8e33849435e(vehicle, upgradetype, player);
      return true;
    }
  }

  return false;
}

function function_365e64606d4f3da8(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  scripts\mp\killstreaks\killstreaks::awardkillstreak(itemdata.ref, "other");
  thread scripts\mp\hud_message::showsplash("br_killstreak_purchased");
  scripts\mp\gametypes\br_armory_kiosk::armorykioskused(0, undefined, undefined, self);
}

function function_6c02b611541421d2(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades(itemdata.ref);
  scripts\mp\supers::givesuper(itemdata.ref, 1);
  thread scripts\mp\hud_message::showsplash("br_field_upgrade_purchased");

  if((level.allowsupers || scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe()) && !istrue(var_452130d9d126e506)) {
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);
  }

  scripts\mp\gametypes\br_armory_kiosk::armorykioskused(0, undefined, undefined, self);
}

function function_f1d968fd69ab759a(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades(itemdata.ref);
  scripts\mp\supers::givesuper(itemdata.ref, 1);
  thread scripts\mp\hud_message::showsplash("br_field_upgrade_purchased");

  if((level.allowsupers || scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe()) && !istrue(var_452130d9d126e506)) {
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, undefined, undefined, 1);
  }

  scripts\mp\gametypes\br_armory_kiosk::armorykioskused(0, undefined, undefined, self);
}

function function_157316f7321dd26b(itemdata, dropcurrent, droppurchased, var_db943473454f6ea6) {
  self endon("disconnect");
  scripts\mp\utility\perk::giveperk(itemdata.ref);
  function_a573b91325f9ea32(self, itemdata, "perk", itemdata.ref);
  scripts\mp\gametypes\br_armory_kiosk::armorykioskused(0, undefined, undefined, self);
}

function function_9c38fec481b62d3b(itemdata, dropcurrent, droppurchased, kiosk, var_db943473454f6ea6) {
  self endon("disconnect");

  if(level.var_f38c74334d6ff472 && namespace_708f627020de59d3::function_c0d385a09d173a36()) {
    purchasesuccess = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, itemdata.entryref, 1, undefined, 1, droppurchased);
    purchasesuccess = function_bddeda747a14d679(purchasesuccess, kiosk, self, itemdata.entryref, 1, droppurchased);
    itemdata.lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(itemdata.entryref);
    function_a573b91325f9ea32(self, itemdata, "perkpackage");
  }
}

function function_bc5f62f877be030f(func, itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6) {
  level endon("game_ended");
  function_a573b91325f9ea32(self, itemdata, itemdata.type);

  if(!isalive(self)) {
    scripts\mp\gametypes\br_armory_kiosk::armorykioskused(0, undefined, undefined, self);
  }

  while(!isalive(self)) {
    waitframe();
  }

  self thread[[func]](itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
}

function _purchaseloadout(player, loadoutindex, var_7dddac09987d559e) {
  defaultloadout = scripts\mp\menus::isloadoutindexdefault(loadoutindex);
  loadoutitemdata = undefined;

  if(istrue(defaultloadout)) {
    loadoutitemdata = function_601181692f53e4ed("loadout_default");
  } else {
    loadoutitemdata = function_601181692f53e4ed("loadout_custom");
  }

  assert(isDefined(loadoutitemdata));
  var_2502897ae7bfd1e = getdvarint(@ "hash_b7252f55210dd7e9", 0);

  if(var_2502897ae7bfd1e != 0) {
    loadoutitemdata.cost = var_2502897ae7bfd1e;
  }

  var_3e487e0c00e4a4c = _getactualcost(player, loadoutitemdata);

  if(player.plundercount < var_3e487e0c00e4a4c) {
    player function_c8bd59cde912455f(3);
    return;
  }

  newclasschoice = scripts\mp\menus::getclasschoice(loadoutindex);
  scripts\mp\gametypes\br_analytics::branalytics_inventory_snapshot(self, "purchasing_new_loadout");
  dropbehind = getdvarint(@ "hash_6d746a5b4acee20d", 1);
  player.pers["class"] = newclasschoice;
  player.class = newclasschoice;
  newclassdata = player scripts\mp\class::preloadandqueueclass(newclasschoice);
  scripts\mp\gametypes\br::br_giveselectedclass(player, var_7dddac09987d559e, dropbehind);
  function_a573b91325f9ea32(player, loadoutitemdata, "loadout", "br_loadout_purchased");

  if(istrue(defaultloadout)) {
    scripts\mp\gametypes\br_analytics::branalytics_kiosk_purchaseitem(self, var_3e487e0c00e4a4c, "defaultLoadout", "loadout_" + loadoutindex);
    return;
  }

  scripts\mp\gametypes\br_analytics::branalytics_kiosk_purchaseloadout(self, var_3e487e0c00e4a4c, newclassdata);
}

function function_9353e641ab9b0884(weaponref, attachmentrefs) {
  itemdata = spawnStruct();
  itemdata.ref = "loadout_primary";
  itemdata.entryref = "loadoutPrimary";
  itemdata.type = "loadout";
  itemdata.cost = function_3cc8b2630d4f56e7(weaponref, attachmentrefs);
  firesalediscount = level.br_armory_kiosk.weapons.staticprices["firesale_weapon_discount"];

  if(isDefined(firesalediscount)) {
    itemdata.firesalediscount = int(firesalediscount);
  } else {
    itemdata.firesalediscount = 0;
  }

  return itemdata;
}

function function_601181692f53e4ed(itemref) {
  foreach(item in level.br_armory_kiosk.items) {
    if(item.ref == itemref) {
      return item;
    }
  }
}

function onarmorykioskpurchase(channel, purchaseindex) {
  player = self;
  kiosk = player.br_kiosk;

  if(!istrue(player.armorykioskpurchaseallowed) && !istrue(level.var_d804888d9484ff69) && !istrue(level.var_c5dc0e983c929728)) {
    return;
  }

  if(channel == "exit_loadout_bag") {
    purchaseindex = 0;
  }

  menueventparam = "channel: " + channel;

  if(isDefined(purchaseindex)) {
    menueventparam = menueventparam + ", index: " + purchaseindex;
  }

  kiosktype = "standard_kiosk";

  if(isDefined(kiosk) && isDefined(kiosk.type) && kiosk.type == "drone_deployable_kiosk") {
    kiosktype = "deployable_kiosk";
  }

  scripts\mp\gametypes\br_analytics::branalytics_kiosk_menu_event(player, "menu_purchase", menueventparam, kiosktype);
  var_7dddac09987d559e = getdvarint(@ "hash_d6a60f25ef560a17", 1);
  var_452130d9d126e506 = getdvarint(@ "hash_8e3b1991482f0d41", 0);
  var_295d6f5d7716affa = getdvarint(@ "hash_ce452a7faefd9e7d", 1);

  if(player scripts\mp\utility\killstreak::isjuggernaut()) {
    var_452130d9d126e506 = 1;
  }

  if(channel == "exit_loadout_bag") {
    _purchasemenuclosedbyclient(player);
    return;
  }

  if(channel == "br_item_purchase") {
    itemindex = purchaseindex;
    assert(isDefined(level.br_armory_kiosk.items[itemindex]));
    itemdata = level.br_armory_kiosk.items[itemindex];
    result = player _validateitempurchase(kiosk, itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_295d6f5d7716affa);
    canpurchase = result == 1 || result == 2;

    if(canpurchase) {
      function_469cfcbc4a5185c1(kiosk, itemdata.entryref);
      var_6b3c6b40c0598d85 = function_b88d64cd67bbe60f(kiosk);

      if(isDefined(var_6b3c6b40c0598d85)) {
        foreach(usingplayer in kiosk.playersusing) {
          if(isDefined(usingplayer)) {
            usingplayer setclientomnvar("ui_buystation_limited_item_amount", var_6b3c6b40c0598d85);
          }
        }
      }

      var_db943473454f6ea6 = undefined;
      var_25978461c6e4f61b = scripts\cp_mp\utility\loot::function_b88cfb4893ceedac(itemdata.ref);

      if(!isDefined(var_25978461c6e4f61b) || namespace_aead94004cf4c147::function_7e103028c464ab9a(var_25978461c6e4f61b)) {
        var_db943473454f6ea6 = namespace_aead94004cf4c147::getavailabledmzbackpackindex();
      }

      if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && itemdata.type == "killstreak") {
        player thread function_bc5f62f877be030f(&function_365e64606d4f3da8, itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && itemdata.type == "fieldupgrade" || itemdata.type == "super") {
        player thread function_bc5f62f877be030f(&function_6c02b611541421d2, itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() && itemdata.type == "perk") {
        player thread function_bc5f62f877be030f(&function_157316f7321dd26b, itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(itemdata.type == "killstreak") {
        player thread _handlekillstreakpurchase(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(itemdata.type == "fieldupgrade" || itemdata.type == "super") {
        player _handlefieldupgradepurchase(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(itemdata.type == "weapon") {
        player function_90b0e9eb26e38443(itemdata, var_7dddac09987d559e, var_452130d9d126e506, var_db943473454f6ea6);
      } else if(itemdata.type == "perk") {
        player function_157316f7321dd26b(itemdata, var_7dddac09987d559e, var_452130d9d126e506);
      } else if(itemdata.type == "equipment") {
        player function_b140d6e72b665c8f(itemdata, var_7dddac09987d559e, var_452130d9d126e506, kiosk);
      } else if(itemdata.type == "special" || itemdata.type == "persistent" || itemdata.type == "secondary_victory") {
        player _handlespecialpurchase(itemdata, var_7dddac09987d559e, var_452130d9d126e506, kiosk, var_295d6f5d7716affa, var_db943473454f6ea6);
      } else if(itemdata.type == "perkpackage") {
        player function_9c38fec481b62d3b(itemdata, var_7dddac09987d559e, var_452130d9d126e506, kiosk, var_db943473454f6ea6);
      }
    }

    return;
  }

  if(channel == "br_loadout_purchase") {
    loadoutindex = purchaseindex;

    if(getdvarint(@ "hash_e10d9168500bd034", 0) == 0) {
      classchoice = scripts\mp\menus::getclasschoice(loadoutindex);
      classstruct = scripts\mp\class::loadout_getorbuildclassstruct(classchoice);
      assert(isDefined(classstruct));

      if(!isDefined(classstruct.loadoutprimary) || !isDefined(classstruct.loadoutprimaryattachments) || !isDefined(classstruct.loadoutprimaryobject) || !isDefined(classstruct.loadoutprimaryfullname)) {
        player function_c8bd59cde912455f(2);
        return;
      }

      var_7afe454b9be1b7e8 = function_9353e641ab9b0884(classstruct.loadoutprimary, classstruct.loadoutprimaryattachments);
      assert(isDefined(var_7afe454b9be1b7e8));
      var_3e487e0c00e4a4c = _getactualcost(player, var_7afe454b9be1b7e8);

      if(player.plundercount < var_3e487e0c00e4a4c) {
        player function_c8bd59cde912455f(3);
        return;
      }

      if(getdvarint(@ "hash_4a50d6714d2a1d0c") <= 0) {
        function_2d04108c0a0ed7a5(player, classstruct.loadoutprimaryobject);
      }

      if(scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon(player, classstruct.loadoutprimaryobject, classstruct.loadoutprimaryfullname, classstruct.loadoutprimary)) {
        function_a573b91325f9ea32(player, var_7afe454b9be1b7e8, var_7afe454b9be1b7e8.type);
        scripts\mp\gametypes\br_analytics::function_6039c3ffa983858f(player, var_3e487e0c00e4a4c, classstruct.loadoutprimary, classstruct.loadoutprimaryattachments);
      }
    } else {
      _purchaseloadout(player, loadoutindex, var_7dddac09987d559e);
    }

    return;
  }

  if(channel == "class_select") {
    loadoutindex = purchaseindex;
    _purchaseloadout(player, loadoutindex, var_7dddac09987d559e);
    return;
  }

  if(channel == "br_team_revive") {
    var_bf5d82befbb59efe = purchaseindex - 1;
    var_69fac551dcf6c2fb = function_601181692f53e4ed("teamrevive");
    var_a120356b021f8e8 = _getactualcost(player, var_69fac551dcf6c2fb);
    var_eb276d34779513e3 = level.var_77e4add813fca6ae && !scripts\mp\gametypes\br_gametypes::isfeaturedisabled("useTokenToReviveTeammate");
    usetoken = istrue(player.hasrespawntoken) && var_eb276d34779513e3 && player.plundercount < var_a120356b021f8e8;

    if(!usetoken && player.plundercount < var_a120356b021f8e8) {
      player function_c8bd59cde912455f(3);
      return 0;
    }

    if(getdvarint(@ "hash_ece0c71aa9d5c939", 0)) {
      logstring("[ WHY_NO_BUYBACK TEST] buyback from - " + player.name + " for squadmateSquadIndex = " + var_bf5d82befbb59efe);
    }

    var_c7869d69dbcf7fd3 = undefined;
    squad = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(squadmate in squad) {
      if(!isDefined(squadmate) || squadmate == player) {
        continue;
      }

      if(isDefined(squadmate.sessionuimemberindex) && squadmate.sessionuimemberindex == var_bf5d82befbb59efe) {
        if(getdvarint(@ "hash_ece0c71aa9d5c939", 0)) {
          logstring("[ WHY_NO_BUYBACK TEST] buyback player - " + squadmate.name + ", sessionuimemberindex = " + squadmate.sessionuimemberindex);
        }

        var_c7869d69dbcf7fd3 = squadmate;
        break;
      }
    }

    if(!isDefined(var_c7869d69dbcf7fd3)) {
      player function_c8bd59cde912455f(12);
      return;
    }

    if(!var_c7869d69dbcf7fd3 scripts\mp\gametypes\br_public::iseligibleforteamrevive() && !getdvarint(@ "hash_4d250e4873e1753e", 0)) {
      if(scripts\mp\gametypes\br_public::isrespawningfromtoken(var_c7869d69dbcf7fd3)) {
        player function_c8bd59cde912455f(14);
        return;
      }

      if(scripts\mp\utility\player::isreallyalive(var_c7869d69dbcf7fd3)) {
        player function_c8bd59cde912455f(15);
        return;
      }

      player function_c8bd59cde912455f(13);
      return;
    }

    player scripts\mp\utility\stats::incpersstat("kioskRevives", 1);
    var_c7869d69dbcf7fd3 scripts\mp\utility\stats::incpersstat("revivedFromKiosk", 1);
    var_a4c6cda2e74187f2 = 0;

    if(!usetoken) {
      cost = level.br_armory_kiosk.teamrevivecost;
      firesalediscount = level.br_armory_kiosk.teamrevivefiresalediscount;
      function_a573b91325f9ea32(player, var_69fac551dcf6c2fb, "teamrevive");

      if(istrue(player.hasrespawntoken)) {
        var_a4c6cda2e74187f2 = 1;
      } else {
        player scripts\mp\gametypes\br_pickups::addrespawntoken(1);
      }
    } else {
      var_3a93448a74526680 = spawnStruct();
      var_3a93448a74526680.cost = 0;
      var_3a93448a74526680.firesalediscount = 0;
      function_a573b91325f9ea32(player, var_3a93448a74526680, "teamrevive");
    }

    if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("kioskRevivePlayer")) {
      var_c7869d69dbcf7fd3 thread scripts\mp\gametypes\br_gametypes::runbrgametypefunc("kioskRevivePlayer", player, usetoken);
    } else {
      var_c7869d69dbcf7fd3 thread scripts\mp\gametypes\br_gulag::playergulagautowin("kioskRevivePlayer", player, usetoken, 1);
    }

    if(var_a4c6cda2e74187f2) {
      player scripts\mp\gametypes\br_pickups::addrespawntoken(1);
    }

    flareoverride = getDvar(@ "hash_58d8dfa7b8338078", "");

    if(flareoverride != "") {
      level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare(kiosk.origin, flareoverride);
    } else {
      level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare(kiosk.origin, "revive");
    }

    player thread scripts\mp\hud_message::showsplash("br_squadmate_revived");
    return;
  }

  if(channel == "insure_slot") {
    if(!getdvarint(@ "hash_ebf8a842c7dd2d82", 0)) {
      return;
    }

    if(!isDefined(player.var_6317f2446d7f722)) {
      player.var_6317f2446d7f722 = [0, 0, 0];
    }

    if(istrue(player.var_6317f2446d7f722[purchaseindex])) {
      return;
    }

    itemref = function_fbea988da0967dbc(purchaseindex);
    itemdata = spawnStruct();
    itemdata.lootid = scripts\cp_mp\utility\loot::getlootidfromref(itemref);
    itemdata.cost = int(scripts\cp_mp\utility\loot::function_afa71c22d9dcfdc5(itemdata.lootid));
    itemdata.ref = itemref;
    itemdata.var_8f0cc1f91f9b12ed = 1;

    if(!isDefined(player.plundercount) || player.plundercount < itemdata.cost) {
      return;
    }

    function_a573b91325f9ea32(player, itemdata, "buy_station_insured_slot");
    player.var_6317f2446d7f722[purchaseindex] = 1;
    return;
  }

  if(channel == "br_biometric_scan_keycard_exchange") {
    if(scripts\engine\utility::issharedfuncdefined(#"biometricscan", #"handlekeycardexchange")) {
      itemdata = [[scripts\engine\utility::getsharedfunc(#"biometricscan", #"handlekeycardexchange")]](player, kiosk, purchaseindex, var_452130d9d126e506);
    }

    if(isDefined(itemdata)) {
      function_a573b91325f9ea32(player, itemdata, itemdata.type, "br_item_purchased", 1);
    }
  }
}

function function_2d04108c0a0ed7a5(player, targetweapon) {
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  dropstruct.weaponpickups = [];
  dropstruct.equipprimarypickup = undefined;
  dropstruct.dropidx = int(4);

  if(getdvarint(@ "hash_ac8187887a7808aa", 0)) {
    dropstruct.dropidx += 9;
  }

  foreach(weapon in player.equippedweapons) {
    basename = scripts\cp_mp\weapon::getweaponrootname(weapon.basename);

    if(isweapon(weapon) && weapon.inventorytype == "primary" && issameweapon(weapon, targetweapon)) {
      if(scripts\mp\gametypes\br_pickups::shoulddropbrprimary(weapon, player)) {
        ismissionweapon = player scripts\mp\gametypes\br_extract_quest::extract_ismissionweapon(weapon);

        if(!ismissionweapon) {
          if(getdvarint(@ "hash_625378754c018440", 1) && isDefined(player.br_kiosk)) {
            dropinfo = player function_345964aeab85e020(player.br_kiosk, dropstruct);
          } else {
            dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
          }

          pickupent = scripts\mp\gametypes\br_weapons::weaponspawn(weapon, player, dropinfo, 0, 1);

          if(isDefined(pickupent)) {
            var_5413c446d646561a = player getweaponammoclip(weapon);
            var_5f1e64f3e8613c52 = player getweaponammoclip(weapon, "left");
            altammo = 0;

            if(weapon.hasalternate) {
              weaponalt = weapon getaltweapon();

              if(scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(weaponalt) != scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(weapon)) {
                altammo = player getweaponammoclip(weaponalt);
              }
            }

            scripts\mp\gametypes\br_pickups::loot_setitemcount(pickupent, var_5413c446d646561a, var_5f1e64f3e8613c52, altammo);
            dropstruct.weaponpickups[dropstruct.weaponpickups.size] = pickupent;
          }
        }
      }

      player scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
    }
  }
}

function _makekioskpurchase(itemdata) {
  player = self;
  isfiresale = iskioskfiresaleactiveforplayer(player.br_kiosk, player);
  cost = itemdata.cost;

  if(!istrue(itemdata.var_8f0cc1f91f9b12ed)) {
    cost = _getactualcost(player, itemdata);
  }

  assert(player.plundercount >= cost);

  if(isfiresale && isDefined(itemdata.firesalediscount) && itemdata.firesalediscount > 0) {
    kioskfiresaledoneforplayer(player.br_kiosk, player);
  }

  if(!(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("kioskXP") || scripts\mp\gametypes\br_public::isanytutorialorbotpracticematch())) {
    player thread scripts\mp\utility\points::doscoreevent(#"br_kioskBuy", undefined, scripts\mp\gametypes\br::calculatepurchasexp(cost, itemdata.type));
  }

  if(cost > 0) {
    player scripts\mp\gametypes\br_plunder::playerplunderkioskpurchase(cost);
  }

  if(!isDefined(level.br_plunder)) {
    level.br_plunder = spawnStruct();
  }

  if(!isDefined(level.br_plunder.kiosk_spent_total)) {
    level.br_plunder.kiosk_spent_total = 0;
  }

  level.br_plunder.kiosk_spent_total += cost;

  if(!isDefined(level.br_plunder.kiosk_num_purchases)) {
    level.br_plunder.kiosk_num_purchases = 0;
  }

  level.br_plunder.kiosk_num_purchases++;
  response = 1;

  if(itemdata.type == "secondary_victory") {
    response = 2;
  }

  if(itemdata.type != "biometric_scan_keycard") {
    if(scripts\engine\utility::issharedfuncdefined(#"biometricscan", #"updatefreeitemcount")) {
      [[scripts\engine\utility::getsharedfunc(#"biometricscan", #"updatefreeitemcount")]](player, -1);
    }
  }

  player function_c8bd59cde912455f(response);
  return cost;
}

function function_a573b91325f9ea32(player, itemdata, itemtyperef, splashref, quantity) {
  cashspent = player _makekioskpurchase(itemdata);

  if(!isDefined(quantity)) {
    quantity = 1;
  }

  lootid = itemdata.lootid;

  if(!isDefined(lootid) || lootid == 0) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(itemdata.ref);

    if(!isDefined(lootid) || lootid == 0) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(itemdata.ref);

      if(!isDefined(lootid)) {
        lootid = 0;
      }
    }
  }

  if(isDefined(lootid) && lootid > 0) {
    method = scripts\cp_mp\challenges::function_6d40f12a09494350(0, function_e2ff8f4b4e94f723(#"hash_2af1f13aa6ae3b5f", #"loot"));
    scripts\cp_mp\challenges::function_d24138b32084fc3e(player, lootid, undefined, method, quantity);
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    scripts\mp\pmc_missions::function_7184abfe5941a710(player, cashspent);
  }

  level notify("buy_station_cash_spent_" + player.team, player, cashspent);

  if(isDefined(player.br_kiosk) && istrue(player.br_kiosk.var_8b199355950fb72)) {
    scripts\mp\pmc_missions::function_c2b3319eb135740(player);
  }

  var_827283fbf3803e56 = 0;

  if(!isDefined(player.var_d782c6e738455363)) {
    player.var_d782c6e738455363 = [];
  }

  if(!array_contains(player.var_d782c6e738455363, player.br_kiosk)) {
    player.var_d782c6e738455363 = array_add(player.var_d782c6e738455363, player.br_kiosk);
    var_827283fbf3803e56 = 1;
  }

  player scripts\cp_mp\challenges::onkioskpurchaseitem(itemtyperef, itemdata.ref, lootid, quantity, cashspent, var_827283fbf3803e56);
  player function_2fc170c3c08ec46(cashspent);

  if(isDefined(player.br_kiosk) && istrue(player.br_kiosk.var_ac9aff06fcbd2b98)) {
    scripts\mp\pmc_missions::function_4f23417a848e2f5f(player);
  }

  if(isDefined(itemtyperef)) {
    scripts\mp\gametypes\br_analytics::branalytics_kiosk_purchaseitem(player, cashspent, itemtyperef, itemdata.ref);
  }
}

function function_2fc170c3c08ec46(plunderspent) {
  if(!isDefined(self.var_7d3ea67ce4fc9efa) || self.var_7d3ea67ce4fc9efa == 0) {
    return;
  }

  var_a2167f3299d7f85c = self.var_7d3ea67ce4fc9efa >= plunderspent ? plunderspent : self.var_7d3ea67ce4fc9efa;
  self.var_7d3ea67ce4fc9efa = max(self.var_7d3ea67ce4fc9efa - var_a2167f3299d7f85c, 0);

  if(var_a2167f3299d7f85c > 0) {
    scripts\cp_mp\challenges::function_8359cadd253f9604(self, "spend_friends_cash", var_a2167f3299d7f85c);
  }
}

function playerlocationselectinterrupt() {
  player = self;
  level endon("game_ended");
  self endon("disconnect");
  player endon("confirm_location");
  waittill_any_ents(player, "death", level, "game_ended");
  player notify("cancel_location");
}

function playerhandlecirclepickitem() {
  self setclientomnvar("ui_buystation_purchase_response", 1);
  self setclientomnvar("ui_buystation_open", 1);
  self setclientomnvar("ui_show_tac_map", 1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "playerHandleCirclePickItem");
  self beginlocationselection(0, 0, "circle_marker", 0, 4);
  thread playerlocationselectinterrupt();
  returninfo = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("confirm_location", "cancel_location");
  success = 0;
  self endlocationselection();

  if(isDefined(returninfo) && returninfo.string == "confirm_location") {
    if(scripts\mp\gametypes\br_circle::isvalidpointinbounds(returninfo.location, 1)) {
      locationtrace = scripts\mp\gametypes\br::traceselectedmaplocation(returninfo.location);
      groundorg = locationtrace["position"];

      if(scripts\mp\gametypes\br_circle::isvalidpointinbounds(groundorg, 1)) {
        thread restartcircleelimination(groundorg);
        success = 1;
      } else {
        function_c8bd59cde912455f(18);
      }
    }
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "playerHandleCirclePickItem");
  self setclientomnvar("ui_show_tac_map", 0);
  return success;
}

function restartcircleelimination(origin) {
  level endon("game_ended");
  level notify("restartCircleElimination");
  var_7c409a7d87b3c6b6 = 60;
  var_5e344cd3618ee701 = 4;
  var_55a74749a759fc2d = -1;
  var_4d700b38444fab26 = 15;
  startcircledelay = getdvarint(@ "hash_5ef97113d77c0835", var_7c409a7d87b3c6b6);
  startcircleindex = getdvarint(@ "hash_341f671cd388b556", var_5e344cd3618ee701);
  startcircleclosetime = getdvarint(@ "hash_b925987adb7fbd3e", var_55a74749a759fc2d);
  var_937dd942e0664f1a = getdvarint(@ "hash_3c88a1d746d97236", var_4d700b38444fab26);

  if(level.script == "<dev string:x2f1>") {
    if(startcircledelay == var_7c409a7d87b3c6b6) {
      startcircledelay = 25;
    }

    if(startcircleindex == var_5e344cd3618ee701) {
      startcircleindex = 2;
    }
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("restartCircleElimination")) {
    thread scripts\mp\gametypes\br_gametypes::runbrgametypefunc("restartCircleElimination", origin, startcircledelay);
  }

  foreach(player in level.players) {
    player scripts\mp\hud_message::showsplash("br_late_circle_soon");
  }

  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("circle")) {
    scripts\mp\gametypes\br_circle::initcirclepoststarttocircleindex(origin, startcircledelay, startcircleindex, startcircleclosetime);
    level.brgametype.disabledfeatures["circle"] = undefined;
  }

  if(scripts\mp\gametypes\br_gametypes::isfeatureenabled("allowLateJoiners")) {
    level.allowlatecomers = 0;
    setnojiptime(1, 1);
    setnojipscore(1, 1);
  }

  var_efcf5eb682ef5688 = max(0, startcircledelay - var_937dd942e0664f1a);
  wait var_efcf5eb682ef5688;

  foreach(player in level.players) {
    player scripts\mp\hud_message::showsplash("br_late_circle_now");
  }

  var_ad75dbc17e0faf18 = startcircledelay - var_efcf5eb682ef5688;
  wait var_ad75dbc17e0faf18;

  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("teamSpectate")) {
    level thread scripts\mp\gametypes\br_spectate::spectate_init();
    level.brgametype.disabledfeatures["teamSpectate"] = undefined;
  }

  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar(hashcat(@ "scr_", scripts\mp\utility\game::getgametype(), "_numLives"), 1);
  }
}

function playerhandleredeploy() {
  self setclientomnvar("ui_buystation_purchase_response", 1);
  self setclientomnvar("ui_buystation_open", 1);
  self setclientomnvar("ui_show_tac_map", 1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "playerHandleRedeploy");
  self beginlocationselection(0, 0, "circle_marker", 0, 4);
  thread playerlocationselectinterrupt();
  returninfo = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("confirm_location", "cancel_location");
  success = 0;
  self endlocationselection();

  if(isDefined(returninfo) && returninfo.string == "confirm_location") {
    if(scripts\mp\gametypes\br_circle::isvalidpointinbounds(returninfo.location, 1)) {
      locationtrace = scripts\mp\gametypes\br::traceselectedmaplocation(returninfo.location);
      groundorg = locationtrace["position"];

      if(scripts\mp\gametypes\br_circle::isvalidpointinbounds(groundorg, 1)) {
        self notify("_watchToAutoCloseMenu_end");
        playerredeploy(groundorg);
        success = 1;
      } else {
        function_c8bd59cde912455f(18);
      }
    }
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "playerHandleRedeploy");
  self setclientomnvar("ui_show_tac_map", 0);
  return success;
}

function playerredeploy(groundorigin, overrideheight, overrideyaw) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  var_4630a5df954561f2 = 12000;
  height = overrideheight;

  if(!isDefined(height)) {
    height = var_4630a5df954561f2;
  }

  yaw = overrideyaw;

  if(!isDefined(yaw)) {
    yaw = 0;
  }

  spawnpoint = spawnStruct();
  spawnpoint.origin = groundorigin + (0, 0, height);
  spawnpoint.angles = (0, yaw, 0);
  spawnpoint.height = height;
  streamorigin = player namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin(spawnpoint);
  player.forcespawnorigin = streamorigin;
  var_b59f471c2c064e56 = 1;
  player namespace_8bfdb6eb5a3df67a::function_334a8fe67e88bbe7();
  wait var_b59f471c2c064e56;
  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  startorigin = spawnorigin;

  if(isDefined(streamorigin)) {
    startorigin = streamorigin;
  }

  player namespace_8bfdb6eb5a3df67a::function_961b4afc4c695b94();
  player namespace_8bfdb6eb5a3df67a::function_ab31cf673d70f72d(startorigin, spawnangles);
  linker = spawn("script_model", startorigin);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(player);
  player playerlinktoabsolute(linker, "tag_origin");
  player function_a593971d75d82113();
  player function_379bb555405c16bb("br_armory_kiosk::playerRedeploy()");
  player thread namespace_8bfdb6eb5a3df67a::playercleanupentondisconnect(linker);
  waitframe();
  player scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
  player scripts\mp\gametypes\br_public::playerclearstreamhintorigin();

  if(isDefined(streamorigin)) {
    linker.origin = spawnorigin;
  }

  linker playsoundtoplayer("br_ac130_flyby", player);
  wait 1.5;

  if(!player islinked()) {
    player namespace_8bfdb6eb5a3df67a::function_ab31cf673d70f72d(spawnorigin, spawnangles);

    scripts\mp\utility\script::demoforcesre("<dev string:x304>" + player.name + "<dev string:x30f>");
  }

  player unlink();
  player scripts\common\damage_effects::function_a2b4e6088394bade();
  player clearclienttriggeraudiozone(1);
  player function_6fb380927695ee76();
  player function_985b0973f29da4f8("br_armory_kiosk::playerRedeploy()");
  falltime = 0;

  if(isDefined(level.parachutedeploydelay)) {
    falltime = level.parachutedeploydelay;
  }

  player.isredeploykeepweapons = 1;
  player thread scripts\cp_mp\parachute::startfreefall(falltime, 0, undefined, undefined, 1);
  player setclientomnvar("ui_br_transition_type", 0);
  player setclientomnvar("ui_show_spectateHud", -1);
  player namespace_8bfdb6eb5a3df67a::resetplayermovespeedscale();
  wait 0.5;
  player namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
  waitframe();
  linker delete();
}

function function_8301ce82f0ae1be6() {
  if(istrue(level.br_circle_disabled)) {
    return level.br_armory_kiosk.scriptables.size;
  }

  var_35c1e70b1d29218 = 0;

  foreach(kiosk in level.br_armory_kiosk.scriptables) {
    if(scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(kiosk.origin)) {
      var_35c1e70b1d29218++;
    }
  }

  return var_35c1e70b1d29218;
}

function function_a4078546548cb0a() {
  if(istrue(level.br_armory_kiosk_enabled)) {
    foreach(station in level.br_armory_kiosk.scriptables) {
      currentstate = station getscriptablepartstate("br_plunder_box");

      if(currentstate != "disabled" && currentstate != "hidden") {
        if(!string_starts_with(currentstate, "firesale_")) {
          newstate = "firesale_" + currentstate;
          station setscriptablepartstate("br_plunder_box", newstate);
        }
      }
    }
  }
}

function function_4fecf02c9241f7f0() {
  if(istrue(level.br_armory_kiosk_enabled)) {
    foreach(station in level.br_armory_kiosk.scriptables) {
      currentstate = station getscriptablepartstate("br_plunder_box");

      if(string_starts_with(currentstate, "firesale_")) {
        splitstr = strtok(currentstate, "_");

        if(!isDefined(splitstr) || splitstr.size < 2) {
          continue;
        }

        newstate = splitstr[splitstr.size - 1];
        station setscriptablepartstate("br_plunder_box", newstate);
      }
    }
  }
}

function function_665291fdc0b65758() {
  foreach(kiosk in getentitylessscriptablearray("scriptable_br_plunder_box", "classname")) {
    kiosk.centerbottom = kiosk.origin + rotatevector((12, 0, 0), kiosk.angles);
  }
}

function function_fbea988da0967dbc(index) {
  switch (index) {
    case 0:
      return "buy_station_insured_slot_1";
    case 1:
      return "buy_station_insured_slot_2";
    case 2:
      return "buy_station_insured_slot_3";
    default:
      return "buy_station_insured_slot_1";
  }

  return "buy_station_insured_slot_1";
}

function kiosk_lock(kiosk) {
  kiosk.locked = 1;
}

function kiosk_unlock(kiosk) {
  kiosk.locked = 0;
}

function function_eaca292314678f38(stationsspawned, var_f3bff22d504c243a, poiname) {
  remainingstations = [];

  foreach(stationloc in var_f3bff22d504c243a) {
    if(isDefined(stationloc.blackmarket) && istrue(int(stationloc.blackmarket))) {
      scripts\mp\gametypes\br_armory_kiosk::function_2fcaa447c4e7d4a0(stationloc, stationsspawned);
      stationsspawned++;
      continue;
    }

    remainingstations[remainingstations.size] = stationloc;
  }

  if(remainingstations.size == 0) {
    return stationsspawned;
  }

  numtospawn = randomintrange(level.poi[poiname]["minExtraBuyStations"], level.poi[poiname]["maxExtraBuyStations"] + 1);
  remainingstations = array_randomize(remainingstations);

  for(i = 0; i < numtospawn; i++) {
    if(!isDefined(remainingstations[i])) {
      continue;
    }

    scripts\mp\gametypes\br_armory_kiosk::function_2fcaa447c4e7d4a0(remainingstations[i], stationsspawned);
    stationsspawned++;
  }

  return stationsspawned;
}

function function_d1e097b50729f36e(data) {
  disablearmorykiosk(self);
  thread function_ed7c6787b596188e(data);
}

function function_ed7c6787b596188e(data) {
  self notify("buyStationDisableForTime");
  self endon("buyStationDisableForTime");
  level endon("game_ended");
  self endon("death");
  self.isemped = 1;

  if(!isDefined(self.temptrigger)) {
    self.temptrigger = spawn("trigger_radius", self.origin, 0, level.br_armory_kiosk.var_da1e0a23728ec36, 62);
    scripts\mp\utility\trigger::makeenterexittrigger(self.temptrigger, &function_874033fd7b181f01, &function_96d54069af0dee07);
    self.temptrigger.endtime = int(gettime() + function_a5b14435e3229bed(data.time));

    if(isDefined(self.traincar)) {
      self.temptrigger enablelinkTo();
      self.temptrigger linkTo(self.traincar);
    }
  } else if(isDefined(self.temptrigger.triggerenterents)) {
    self.temptrigger.endtime = int(gettime() + function_a5b14435e3229bed(data.time));

    foreach(player in self.temptrigger.triggerenterents) {
      player scripts\mp\utility\lower_message::setlowermessageomnvar("buystation_offline", self.temptrigger.endtime);
    }
  }

  wait data.time;
  self[[self.reactivatefunc]](self);
  self.isemped = 0;
  self.temptrigger delete();
}

function function_874033fd7b181f01(player, trigger) {
  self endon("buyStationDisableForTime");
  scripts\mp\utility\lower_message::setlowermessageomnvar("buystation_offline", trigger.endtime);

  for(timeleft = function_c89ed1840c8d0f0f(trigger.endtime - gettime()); isDefined(trigger) && timeleft > 0; timeleft = function_c89ed1840c8d0f0f(trigger.endtime - gettime())) {
    wait timeleft;
  }

  waitframe();
  thread function_96d54069af0dee07(player, trigger);
}

function function_96d54069af0dee07(player, trigger) {
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  self notify("buyStationDisableForTime");
}

function function_345964aeab85e020(kiosk, dropstruct) {
  if(!isDefined(dropstruct)) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  }

  target_direction = self.origin - kiosk.origin;
  yaw = vectortoyaw(target_direction);
  baseangles = (0, yaw, 0);
  slot = scripts\mp\gametypes\br_pickups::function_4f4d537c794b2bf5();
  thread scripts\mp\gametypes\br_pickups::function_1e450adba8ddc914();
  dropstruct.dropidx = slot;
  return scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, baseangles, self);
}