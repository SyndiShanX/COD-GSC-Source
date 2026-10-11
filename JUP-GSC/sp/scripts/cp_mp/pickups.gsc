/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\pickups.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_weapons;
#using scripts\cp\persistence;
#using scripts\cp\pickups;
#using scripts\cp\super;
#using scripts\cp\weapon;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\equipment\stimpistol;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\oxygenmask;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace pickups;

function issuperpickup(scriptablename) {
  return !isnonequippable(scriptablename) && isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"super";
}

function function_d7c5786a0c42ef6c(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"tactical";
}

function isnonequippable(scriptablename) {
  return scriptablename == "br_loot_cache" || isquesttablet(scriptablename);
}

function isquesttablet(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"tablet";
}

function isplunder(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"plunder";
}

function function_609bb538ed61b8d7(scriptablename) {
  return isDefined(scriptablename) && (scriptablename == "brloot_backpack" || scriptablename == "brloot_backpack_medium" || scriptablename == "brloot_backpack_large" || scriptablename == "brloot_backpack_player_small" || scriptablename == "brloot_backpack_player_medium" || scriptablename == "brloot_backpack_player_large");
}

function isperkpointpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"perkpoint";
}

function isammo(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"ammo";
}

function iskiosk(scriptablename) {
  return isDefined(scriptablename) && scriptablename == "br_plunder_box";
}

function function_b904849ea30d653f(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"powerup";
}

function isequipment(scriptablename) {
  return isarmorplate(scriptablename) || ishealitem(scriptablename) || isDefined(level.br_pickups.br_itemtype[scriptablename]) && (level.br_pickups.br_itemtype[scriptablename] == #"lethal" || level.br_pickups.br_itemtype[scriptablename] == #"tactical");
}

function ishealitem(scriptablename) {
  return scriptablename == "brloot_health_bandages" || scriptablename == "brloot_health_firstaid" || scriptablename == "brloot_health_adrenaline";
}

function isrevivepickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"revive";
}

function isarmor(scriptablename) {
  return ishelmet(scriptablename);
}

function ishelmet(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"armor" && issubstr(scriptablename, "helmet");
}

function function_15ecbc9a1a51007f(scriptablename) {
  return istrue(level.var_fb613f99e7d3b47e) && (scriptablename == "brloot_rock" || scriptablename == "brloot_offhand_jup_bottle");
}

function isarmorplate(scriptablename) {
  return scriptablename == "brloot_armor_plate";
}

function function_f262c137ed78e6eb(scriptablename) {
  return issubstr(scriptablename, "activity_starter");
}

function isattachment(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"attachment";
}

function isaccesscard(scriptablename) {
  return issubstr(scriptablename, "access_card");
}

function isxp(scriptablename) {
  return issubstr(scriptablename, "brloot_xp");
}

function isgasmask(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"gear" && issubstr(scriptablename, "gasmask");
}

function iskillstreak(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"killstreak";
}

function function_8ef153aa42520ac4(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"munition";
}

function function_4294e9b331377c31(scriptablename) {
  return scriptablename == "brloot_plate_carrier_high_capacity";
}

function function_51adf909541800d7(scriptablename) {
  return scriptablename == "jup_armor_platecarrier_upgrade";
}

function isvaluable(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"valuable";
}

function ispersonal(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"personal";
}

function function_cb1e30930c35f2e2(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"nvg";
}

function function_5449da9d3d0358a4(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"gascan";
}

function function_32125eba262380c7(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"mission";
}

function isdogtag(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"dogtag";
}

function isweaponcase(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"weaponcase";
}

function function_f92615e29aff3602(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"hash_a49b77de0306ea57";
}

function isweaponpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"weapon";
}

function function_b989edd9af4f42c7(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"lethal";
}

function iscache(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"cache";
}

function function_4aa12e0ed3f6b745(scriptablename) {
  return scriptablename == "brloot_plate_carrier_2" || scriptablename == "brloot_plate_carrier_3";
}

function iskey(scriptablename) {
  return issubstr(scriptablename, "loot_key") || issubstr(scriptablename, "loot_multi_key");
}

function function_692c3df266580df6(scriptablename) {
  if(scriptablename == "brloot_plate_carrier_2") {
    return 2;
  }

  if(scriptablename == "brloot_plate_carrier_3") {
    return 3;
  }

  return 1;
}

function function_7094c7010c5e3827(team) {
  return isDefined(level.contractmanager) && isDefined(level.contractmanager.var_b6fae9c9655c73bf) && isDefined(level.contractmanager.var_b6fae9c9655c73bf[team]);
}

function function_6b5f3fb6550ae6d5(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"gear" && issubstr(scriptablename, "iodine_pills");
}

function istokenpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"token";
}

function function_362d5a8d49b93721(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == #"note";
}

function takegenericgrenadepickup(pickupent) {
  ammocount = scripts\cp_mp\equipment::getequipmentslotammo("primary");

  if(isDefined(ammocount) && ammocount < 2) {
    scripts\cp_mp\equipment::incrementequipmentslotammo("primary");
  }

  ammocount = scripts\cp_mp\equipment::getequipmentslotammo("secondary");

  if(isDefined(ammocount) && ammocount < 2) {
    scripts\cp_mp\equipment::incrementequipmentslotammo("secondary");
  }
}

function takerespawntokenpickup(pickupent) {
  if(!respawntokendisabled() && !hasrespawntoken()) {
    addrespawntoken();
    return true;
  }

  return false;
}

function hasrespawntoken() {
  player = self;
  return istrue(player.hasrespawntoken);
}

function respawntokendisabled() {
  return getdvarint(@ "hash_4d250e4873e1753e", 0) || !istrue(level.br_pickups.respawntokenenabled) || istrue(level.br_pickups.respawntokenclosewithgulag) && isDefined(level.gulag) && istrue(level.gulag.shutdown);
}

function addrespawntoken(skipsplash) {
  player = self;
  assert(!istrue(player.hasrespawntoken));
  player.hasrespawntoken = 1;
  player sethasrespawntokenextrainfo(1);

  if(!istrue(skipsplash)) {
    player thread namespace_53fc9ddbb516e6e1::showsplashsharedfunc("br_respawn_token_pickup");
  }
}

function sethasrespawntokenextrainfo(value) {
  if(istrue(value)) {
    self.game_extrainfo |= 32768;
    return;
  }

  self.game_extrainfo &= -65536;
}

function fillmaxarmorplate() {
  player = self;
  fakepickup = spawnStruct();
  fakepickup.scriptablename = "brloot_armor_plate";
  fakepickup.equipname = level.br_pickups.br_equipname[fakepickup.scriptablename];
  fakepickup.origin = self.origin;
  fakepickup.maxcount = scripts\cp_mp\equipment::getequipmentmaxammo(fakepickup.equipname);
  fakepickup.count = fakepickup.maxcount;
  fakepickup.stackable = level.br_pickups.stackable[fakepickup.scriptablename];
  player scripts\cp\pickups::takeequipmentpickup(fakepickup);
}

function addplatepouch(skipsplash) {
  player = self;
  assert(!player hasplatepouch());

  if(getdvarint(@ "scr_br_skiplegendarypickupsound", 0) == 0) {
    self playsoundtoplayer("br_legendary_loot_pickup", self);
  }

  player.hasplatepouch = 1;
  player setclientomnvar("ui_br_has_plate_pouch", 1);

  if(!istrue(skipsplash)) {
    player thread namespace_53fc9ddbb516e6e1::showsplashsharedfunc("br_plate_pouch_pickup");
  }
}

function hasplatepouch() {
  player = self;
  return istrue(player.hasplatepouch);
}

function takekillstreakpickup(pickupent, fromkiosk, var_db943473454f6ea6) {
  killstreakref = level.br_pickups.var_14bd11727c4b6629[pickupent.scriptablename];
  assert(isDefined(killstreakref));

  if(function_a7cc24f3a189746a(killstreakref)) {
    function_381d14fb6e6aca9a(killstreakref);
  }
}

function function_a7cc24f3a189746a(killstreakref) {
  forceuse = 0;

  switch (killstreakref) {
    case #"hash_5a20d43f09c87c1d":
      forceuse = 1;
      break;
  }

  return forceuse;
}

function function_381d14fb6e6aca9a(killstreakref) {}

function playercanplaynotcriticalgesture() {
  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\engine\utility::getsharedfunc("player", "isPlayerADS")]]() || istrue(self.insertingarmorplate)) {
    return false;
  }

  curweap = self getcurrentweapon();

  if(isnullweapon(curweap)) {
    return false;
  }

  var_3964741f996d2827 = scripts\common\values::get("gesture");

  if(!istrue(var_3964741f996d2827)) {
    return false;
  }

  return true;
}

function function_66bdd7e1d2e05f14() {
  if(self isgestureplaying("iw8_ges_pickup_br")) {
    return true;
  }

  return false;
}

function function_f4361ea8ce0fbca4() {
  weapobj = makeweapon("iw8_ges_plyr_loot_pickup");

  if(self hasweapon(weapobj)) {
    if(self isgestureplaying("iw8_ges_pickup_br")) {
      self stopgestureviewmodel("iw8_ges_pickup_br", 0, 1);
    }

    self takeweapon(weapobj);
    waitframe();
  }
}

function function_db908ecaccbe933c(notification, var_421750c958bd3064) {
  if(istrue(level.infilcinematicactive)) {
    return;
  }

  if(isDefined(notification)) {
    switch (notification) {
      case #"hash_f9442c17e42ea782":
        itemtype = getinventoryitemtype(var_421750c958bd3064);
        itemindex = function_ab41acc7ac2f6642(var_421750c958bd3064);

        if(istrue(self.insertingarmorplate) && itemtype == 2 && "health" == function_4967838290cb31b9(itemindex)) {
          break;
        }

        if(isDefined(level.var_71afb87754f28af8)) {
          if(!self[[level.var_71afb87754f28af8]](itemtype, itemindex)) {
            return;
          }
        }

        if(!function_aa47c359a5db6132()) {
          scripts\cp\pickups::inventory_close();
          namespace_53fc9ddbb516e6e1::showerrormessagesharedfunc("COOP_GAME_PLAY/CANNOT_DROP_NOW");
          return;
        }

        if(istrue(self.var_23a6763562820c70) && self isswimming() && itemtype == 1) {
          scripts\cp\pickups::inventory_close();
          namespace_53fc9ddbb516e6e1::showerrormessagesharedfunc("COOP_GAME_PLAY/CANT_DROP_WEAPON_WHILE_SWIMMING");
          return;
        }

        thread quickdropitem(itemtype, itemindex);
        break;
      case #"hash_ae052d9aaad15cec":
        itemindex = var_421750c958bd3064;
        weap = function_13ecf3644442a3e7(self, itemindex);

        if(!isDefined(weap)) {
          break;
        }

        ammotype = scripts\cp\pickups::br_ammo_type_for_weapon(weap);

        if(isDefined(ammotype) && isDefined(self.br_ammo[ammotype]) && self.br_ammo[ammotype] > 0) {
          stacksize = level.br_pickups.counts[ammotype];

          if(!isDefined(stacksize)) {
            break;
          }

          var_1f11155517c54c34 = int(min(self.br_ammo[ammotype], stacksize));
          var_74806f0c4caa7e55 = var_1f11155517c54c34;
          currentweaponstock = self getweaponammostock(weap);

          if(self.br_ammo[ammotype] > currentweaponstock) {
            var_74806f0c4caa7e55 = var_1f11155517c54c34 + self.br_ammo[ammotype] - currentweaponstock;

            if(var_74806f0c4caa7e55 > self.br_ammo[ammotype]) {
              var_1f11155517c54c34 = currentweaponstock;
              var_74806f0c4caa7e55 = self.br_ammo[ammotype];
            }
          }

          if(var_1f11155517c54c34 > 0) {
            quickdropnewitem(10, ammotype, var_1f11155517c54c34);
          }

          br_ammo_take_type(self, ammotype, var_74806f0c4caa7e55);
        }

        break;
      case #"hash_24d3e929a240e2d7":
        itemtype = getinventoryitemtype(var_421750c958bd3064);
        itemindex = function_ab41acc7ac2f6642(var_421750c958bd3064);

        if(istrue(self.insertingarmorplate) && itemtype == 2 && "health" == function_4967838290cb31b9(itemindex)) {
          break;
        }

        if(isDefined(level.var_71afb87754f28af8)) {
          if(!self[[level.var_71afb87754f28af8]](itemtype, itemindex)) {
            return;
          }
        }

        if(!function_aa47c359a5db6132()) {
          scripts\cp\pickups::inventory_close();
          namespace_53fc9ddbb516e6e1::showerrormessagesharedfunc("WEAPON/CANNOT_DROP_EQUIPMENT");
          return;
        }

        quickdropall(itemtype, itemindex);
        break;
      case #"hash_344a8be1e67f4848":
        itemtype = getinventoryitemtype(var_421750c958bd3064);
        itemindex = function_ab41acc7ac2f6642(var_421750c958bd3064);

        if(istrue(self.insertingarmorplate) && itemtype == 2 && "health" == function_4967838290cb31b9(itemindex)) {
          break;
        }

        if(itemtype == 1 && itemindex == 2) {
          function_f5a1a13f0181bb66(self);
        } else {
          thread equipbackpackitem(itemindex);
        }

        break;
      default:
        break;
    }
  }
}

function function_aa47c359a5db6132() {
  if(self isgestureplaying()) {
    if(!self isgestureplaying("iw9_vm_ges_quickdraw_lhand_offset")) {
      return 1;
    }
  }

  if(self isthrowinggrenade()) {
    return 0;
  }

  return 1;
}

function getinventoryitemtype(var_421750c958bd3064) {
  return (var_421750c958bd3064 & 256 - 1 << 8) >> 8;
}

function function_ab41acc7ac2f6642(var_421750c958bd3064) {
  return var_421750c958bd3064 & 256 - 1;
}

function equipbackpackitem(itemslotindex) {
  [lootid, quantity] = function_6738846da50730f1(itemslotindex);
  itemref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

  if(itemref == "dmz_nvg") {
    if(self isnightvisionon()) {
      self nightvisionviewoff(1);
      return;
    }

    self nightvisionviewon(1);
    return;
  }

  if(!isDefined(itemref) || isDefined(itemref) && !isammo(itemref)) {
    equipitem(lootid, quantity, itemslotindex, undefined, 1);
  }
}

function function_6738846da50730f1(index) {
  lootid = getlootidatbackpackindex(index);
  quantity = getquantityatbackpackindex(index);
  return [lootid, quantity];
}

function quickdropitem(itemtype, itemindex, dontspawnitem) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  function_f95a2789ce5b15ff(itemtype, itemindex, 0, dontspawnitem);
}

function quickdropall(itemtype, itemindex) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  function_f95a2789ce5b15ff(itemtype, itemindex, 1);
}

function function_f95a2789ce5b15ff(itemtype, itemindex, dropall, dontspawnitem) {
  switch (itemtype) {
    case 0:
      function_8aab3cda02f81c09(self, itemtype, dropall, dontspawnitem);
      break;
    case 1:
      quickdropweapon(self, itemtype, itemindex, undefined, dropall, dontspawnitem);
      break;
    case 10:
      function_6f62cb4fc113349c(self, itemtype, itemindex, dropall, dontspawnitem);
      break;
    case 2:
      function_b130392812b25580(self, itemindex, itemtype, dropall, dontspawnitem);
      break;
    case 3:
      function_1503d0b5b4c9d010(self, dropall, dontspawnitem);
      break;
    case 4:
      function_b15e36b7bc247ddb(self, dropall, dontspawnitem);
      break;
    case 6:
      quickdropgasmaskitem(self, dontspawnitem);
      break;
    case 7:
      function_8f803ea058a13cbd(self, dontspawnitem);
      break;
    case 5:
      quickdropammo(self, itemindex, itemtype, dropall, dontspawnitem);
      break;
    default:
      assertmsg("Invalid quick drop item type: " + itemtype);
      return;
  }
}

function function_8aab3cda02f81c09(player, itemtype, dropall, dontspawnitem) {
  itemcount = getquickdropplundercount(dropall);

  if(itemcount == 0) {
    return false;
  }

  player playerplunderdrop(itemcount);
  var_8e5dd667f5bf1e1e = level.br_plunder.names[0];

  for(i = level.br_plunder.quantity.size - 1; i >= 0; i--) {
    if(itemcount > level.br_plunder.quantity[i]) {
      var_8e5dd667f5bf1e1e = level.br_plunder.names[i];
    }
  }

  if(istrue(dontspawnitem)) {
    return true;
  }

  if(itemcount >= 2500) {
    remainingcount = itemcount;

    while(remainingcount > 0) {
      newcount = ter_op(remainingcount > 2000, 2000, remainingcount);
      quickdropnewitem(itemtype, var_8e5dd667f5bf1e1e, newcount);
      remainingcount -= newcount;
    }
  } else {
    quickdropnewitem(itemtype, var_8e5dd667f5bf1e1e, itemcount);
  }

  return true;
}

function quickdropweapon(player, itemtype, itemindex, itemcount, dropall, dontspawnitem) {
  var_ec22a950f210e39 = function_13ecf3644442a3e7(player, itemindex);

  if(!isDefined(var_ec22a950f210e39) || isunderwaterweapon(var_ec22a950f210e39) || function_daacac69b2a7457d(var_ec22a950f210e39) || scripts\cp_mp\equipment\stimpistol::function_76ca0b3d8b2555ca(var_ec22a950f210e39)) {
    return;
  }

  itemcount = 0;
  itemcountlefthand = 0;
  var_dab81ead77442a10 = 0;
  weaponobj = undefined;

  if(!isDefined(var_ec22a950f210e39) || isnullweapon(var_ec22a950f210e39) || var_ec22a950f210e39 == makeweapon("iw9_me_fists_mp") || self isskydiving()) {
    return 0;
  } else {
    itemcount = player getweaponammoclip(var_ec22a950f210e39);
    itemcountlefthand = player getweaponammoclip(var_ec22a950f210e39, "left");

    if(var_ec22a950f210e39.hasalternate) {
      weaponaltobj = var_ec22a950f210e39 getaltweapon();
      var_dab81ead77442a10 = player getweaponammoclip(weaponaltobj);
    }

    weaponobj = var_ec22a950f210e39;
  }

  quickdropweapon = getquickdropweapon(itemindex);

  if(itemindex == 2) {
    function_590202daf6a1d4d7(player);
  } else {
    function_d655f2006cfe7789(var_ec22a950f210e39);
  }

  if(istrue(dontspawnitem)) {
    return 1;
  }

  quickdropnewitem(itemtype, quickdropweapon, itemcount, itemcountlefthand, var_dab81ead77442a10, weaponobj);
  return 1;
}

function function_13ecf3644442a3e7(player, itemindex) {
  if(itemindex == 2) {
    return scripts\cp\pickups::function_2985254128b1c262(player);
  }

  weaponlist = player getweaponslistprimaries();
  var_be28c7bbf8bd3f10 = itemindex == 0;

  foreach(weapon in weaponlist) {
    if(isunderwaterweapon(weapon)) {
      continue;
    }

    if(weaponinventorytype(weapon) == "altmode") {
      continue;
    }

    if(var_be28c7bbf8bd3f10) {
      return weapon;
    }

    var_be28c7bbf8bd3f10 = 1;
  }
}

function isunderwaterweapon(weapon) {
  weaponname = undefined;

  if(isweapon(weapon)) {
    weaponname = weapon.basename;
  } else {
    weaponname = weapon;
  }

  return weaponname == "iw9_me_diveknife_mp" || weaponname == "iw9_swimfists_mp";
}

function function_daacac69b2a7457d(weapon) {
  weaponname = undefined;

  if(isweapon(weapon)) {
    weaponname = weapon.basename;
  } else {
    weaponname = weapon;
  }

  return weaponname == "iw9_me_climbfists_mp" || weaponname == "iw9_me_climbfists";
}

function function_590202daf6a1d4d7(player) {
  player setplayerdata("cp", "dmzWeapon", "weapon", "none");
  player setplayerdata("cp", "dmzWeapon", "lootItemID", 0);
  player setplayerdata("cp", "dmzWeapon", "camo", "none");
  player setplayerdata("cp", "dmzWeapon", "reticle", "none");
  player setplayerdata("cp", "dmzWeapon", "cosmeticAttachment", "none");
  player setplayerdata("cp", "dmzWeapon", "variantID", 0);
  player setplayerdata("cp", "dmzWeapon", "blueprintName", "");

  for(attachindex = 0; attachindex < 5; attachindex++) {
    player setplayerdata("cp", "dmzWeapon", "attachmentSetup", attachindex, "attachment", "none");
    player setplayerdata("cp", "dmzWeapon", "attachmentSetup", attachindex, "variantID", 0);
  }

  for(var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 4; var_36d2abbdcbcb186c++) {
    player setplayerdata("cp", "dmzWeapon", "sticker", var_36d2abbdcbcb186c, "none");
  }
}

function function_d655f2006cfe7789(var_ec22a950f210e39) {
  fistsweapon = makeweapon("iw9_me_fists_mp");
  assert(isDefined(var_ec22a950f210e39));
  assert(!isnullweapon(var_ec22a950f210e39));
  assert(var_ec22a950f210e39 != fistsweapon);
  var_102d661b1caa8bc1 = fistsweapon;
  primaryweapons = self getweaponslistprimaries();

  foreach(weapon in primaryweapons) {
    if(weapon.inventorytype != "primary") {
      continue;
    }

    if(weapon != fistsweapon && weapon != var_ec22a950f210e39 && !scripts\cp\weapon::ismeleeoverrideweapon(weapon) && !isunderwaterweapon(weapon)) {
      var_102d661b1caa8bc1 = weapon;
      break;
    }
  }

  if(!scripts\cp_mp\utility\weapon_utility::isriotshield(var_ec22a950f210e39)) {
    ammostock = self getweaponammostock(var_ec22a950f210e39);
    weaponammotype = scripts\cp\pickups::br_ammo_type_for_weapon(var_ec22a950f210e39);

    if(isDefined(weaponammotype)) {
      self.br_ammo[weaponammotype] = min(ammostock, level.var_e6ea72fc5e3fcd00[weaponammotype]);
      self.br_ammo[weaponammotype] = get_int_or_0(self.br_ammo[weaponammotype]);
    }
  }

  if(scripts\cp_mp\weapon::isminigunweapon(var_ec22a950f210e39)) {
    self notify("dropped_minigun");
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_ec22a950f210e39);

  if(!self hasweapon(fistsweapon)) {
    self giveweapon(fistsweapon);
  }

  scripts\cp\pickups::br_ammo_update_weapons(self);

  if(scripts\cp_mp\oxygenmask::function_23a6763562820c70()) {
    return;
  }

  self switchtoweaponimmediate(var_102d661b1caa8bc1);
}

function function_4967838290cb31b9(index) {
  switch (index) {
    case 0:
      return "primary";
    case 1:
      return "secondary";
    case 2:
      return "health";
    default:
      assert(0, "Attempt to get slot for invalid equipment index " + index);
      break;
  }
}

function function_f5a1a13f0181bb66(player) {
  lootitemid = scripts\cp\pickups::function_d9b1550011525161(player);
  switchweapon = scripts\cp\pickups::function_2985254128b1c262(player);

  if(isDefined(player.weaponslotclip)) {
    count = player.weaponslotclip;
  } else {
    count = weaponclipsize(switchweapon);
  }

  countalt = undefined;

  if(switchweapon.hasalternate && isDefined(player.var_86b32aff94b5714e)) {
    countalt = player.var_86b32aff94b5714e;
  } else {
    countalt = weaponclipsize(switchweapon getaltweapon());
  }

  function_590202daf6a1d4d7(player);
  equipitem(lootitemid, count, undefined, countalt);
}

function equipitem(lootid, quantity, itemslotindex, countalt, backpackequip) {
  scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(scriptablename)) {
    return;
  }

  if(issuperpickup(scriptablename)) {
    if(scripts\cp\super::issuperinuse()) {
      namespace_53fc9ddbb516e6e1::showerrormessagesharedfunc("MP/SUPERS_UNAVAILABLE_EQUIP");
      return;
    }

    if(isDefined(self.equipment["super"])) {
      var_57b0241752598e4a = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["super"]);

      if(var_57b0241752598e4a == scriptablename) {
        return;
      }
    }
  }

  var_bada25504e8844d7 = spawnStruct();
  var_bada25504e8844d7.scriptablename = scriptablename;
  var_bada25504e8844d7.origin = self.origin;
  var_bada25504e8844d7.count = quantity;
  var_bada25504e8844d7.maxcount = level.br_pickups.maxcounts[scriptablename];
  var_bada25504e8844d7.stackable = level.br_pickups.stackable[scriptablename];

  if(isDefined(countalt)) {
    var_bada25504e8844d7.countalt = countalt;
  }

  var_bada25504e8844d7.countlefthand = 0;

  if(iskillstreak(scriptablename) || issuperpickup(scriptablename) || level.gametype == "dungeons" && function_8ef153aa42520ac4(scriptablename)) {
    var_bada25504e8844d7.count = 1;
  }

  scripts\cp\pickups::onusecompleted(var_bada25504e8844d7, undefined, 1, 0, itemslotindex, undefined, backpackequip);
}

function quickdropnewitem(itemtype, scriptablename, itemcount, itemcountlefthand, var_dab81ead77442a10, weaponobj) {
  var_285b7129b392cf3d = quickdropaddtoexisting(itemtype, scriptablename, itemcount, itemcountlefthand, var_dab81ead77442a10, weaponobj);

  if(var_285b7129b392cf3d) {
    return;
  }

  slot = function_4f4d537c794b2bf5();
  thread function_1e450adba8ddc914();
  dropinfo = scripts\cp\pickups::getitemdroporiginandangles(slot, self.origin, self.angles, self);
  newent = namespace_53fc9ddbb516e6e1::spawnpickupsharedfunc(scriptablename, dropinfo, itemcount, 1, weaponobj, 0, itemcountlefthand, var_dab81ead77442a10);
  quickdropaddtocache(scriptablename, slot, newent, dropinfo.origin, dropinfo.angles);

  if(isDefined(weaponobj)) {
    level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_trigger(newent, self, weaponobj);

    if(scripts\cp\pickups::function_b1dd9dcae2f63965()) {
      function_8e7e1da48d7746e5(self, newent);
    }
  }

  if(isplunder(scriptablename)) {
    scriptablename = scripts\cp\pickups::getplundernamebyamount(itemcount);
  }

  scripts\cp_mp\calloutmarkerping::function_1062f2af5c7d843e(scriptablename, weaponobj);
  quickdropplaySound(itemtype, dropinfo.origin, scriptablename, newent, weaponobj);
  return newent;
}

function quickdropaddtoexisting(itemtype, scriptablename, itemcount, itemcountlefthand, var_dab81ead77442a10, weaponobj) {
  cacheitem = quickdropfinditemincache(scriptablename);

  if(isDefined(cacheitem)) {
    oldent = cacheitem.ent;
    oldorigin = cacheitem.droporigin;
    oldangles = cacheitem.dropangles;
    oldcount = loot_getitemcount(oldent);
    var_74b23b8eea29a555 = loot_getitemcountlefthand(oldent);
    var_4ff1e9f60bcf8fe8 = function_3a5f7703319142dd(oldent);

    if(!ispickupstackable(scriptablename) && !issubstr(cacheitem.ent.type, "_cash")) {
      return false;
    }

    newcount = oldcount + itemcount;

    if(issubstr(cacheitem.ent.type, "_cash")) {
      if(newcount >= 2500) {
        return false;
      }
    }

    if(!isDefined(itemcountlefthand)) {
      itemcountlefthand = 0;
    }

    var_9e57dc7afe8604c8 = var_74b23b8eea29a555 + itemcountlefthand;

    if(!isDefined(var_dab81ead77442a10)) {
      var_dab81ead77442a10 = 0;
    }

    var_a69b5a02ffae97ff = var_4ff1e9f60bcf8fe8 + var_dab81ead77442a10;
    droppayload = calcscriptablepayloadgravityarc(oldorigin + (0, 0, 12), oldorigin);
    dropinfo = scripts\cp\pickups::getitemdropinfo(oldorigin, oldangles, droppayload);
    newent = namespace_53fc9ddbb516e6e1::spawnpickupsharedfunc(scriptablename, dropinfo, newcount, 1, weaponobj, 0, var_9e57dc7afe8604c8, var_a69b5a02ffae97ff);

    if(isDefined(weaponobj)) {
      level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_trigger(newent, self, weaponobj);
    }

    soundname = scriptablename;

    if(isplunder(scriptablename)) {
      soundname = scripts\cp\pickups::getplundernamebyamount(newcount);
    }

    quickdropplaySound(itemtype, oldorigin, soundname, newent);
    self.quickdropcache[scriptablename].ent = newent;
    thread quickdropcleanupcache();
    scripts\cp\pickups::deregisterscriptableinstance(oldent);

    if(isent(oldent)) {
      oldent delete();
    } else {
      oldent freescriptable();
    }

    return true;
  }

  return false;
}

function function_4f4d537c794b2bf5() {
  if(!isDefined(level.var_2dc1d82da1dbfeab)) {
    level.var_2dc1d82da1dbfeab = [0, 13, 1, 12, 2, 14, 27, 15, 26, 28, 41, 29, 40];
  }

  if(!isDefined(self.var_1ac656ba9c98b8db)) {
    self.var_1ac656ba9c98b8db = 0;
  } else {
    self.var_1ac656ba9c98b8db++;
  }

  return level.var_2dc1d82da1dbfeab[self.var_1ac656ba9c98b8db % level.var_2dc1d82da1dbfeab.size];
}

function function_1e450adba8ddc914() {
  if(isDefined(self.var_1ac656ba9c98b8db) && self.var_1ac656ba9c98b8db == 0) {
    startorigin = self.origin;
    startangles = self.angles;

    while(distancesquared(startorigin, self.origin) < 100 && anglesdelta(startangles, self.angles) < 10) {
      wait 1;
    }

    self.var_1ac656ba9c98b8db = undefined;
    self notify("reset_slots");
  }
}

function quickdropaddtocache(scriptablename, slot, ent, droporigin, dropangles) {
  if(!isDefined(self.quickdropcache)) {
    self.quickdropcache = [];
  }

  newitem = spawnStruct();
  newitem.scriptablename = scriptablename;
  newitem.slot = slot;
  newitem.ent = ent;
  newitem.droporigin = droporigin;
  newitem.dropangles = dropangles;
  newitem.playerorigin = self.origin;
  newitem.playeryaw = self.angles[1];
  self.quickdropcache[scriptablename] = newitem;
  thread quickdropcleanupcache();
}

function quickdropplaySound(itemtype, droporigin, scriptablename, newent, weaponobj) {
  aliasname = undefined;

  switch (itemtype) {
    case 5:
      aliasname = "br_inventory_drop_ammo";
      break;
    case 0:
      if(scriptablename == "brloot_plunder_cash_uncommon_1") {
        aliasname = "br_inventory_drop_plunder_sm";
      } else if(scriptablename == "brloot_plunder_cash_uncommon_2") {
        aliasname = "br_inventory_drop_plunder_sm";
      } else if(scriptablename == "brloot_plunder_cash_uncommon_3") {
        aliasname = "br_inventory_drop_plunder_sm";
      } else if(scriptablename == "brloot_plunder_cash_rare_1") {
        aliasname = "br_inventory_drop_plunder_med";
      } else if(scriptablename == "brloot_plunder_cash_rare_2") {
        aliasname = "br_inventory_drop_plunder_med";
      } else if(scriptablename == "brloot_plunder_cash_epic_1") {
        aliasname = "br_inventory_drop_plunder_lrg";
      } else if(scriptablename == "brloot_plunder_cash_epic_2") {
        aliasname = "br_inventory_drop_plunder_lrg";
      } else if(scriptablename == "brloot_plunder_cash_legendary_1") {
        aliasname = "br_inventory_drop_plunder_extra_lrg";
      } else {
        aliasname = "br_inventory_drop_plunder_med";
      }

      break;
    case 1:
      if(isDefined(weaponobj)) {
        thread function_aed7983cf10ca9e2(newent, weaponobj);
        return;
      } else {
        aliasname = "br_inventory_drop_weap";
      }

      break;
    case 2:
    case 3:
    case 4:
    case 10:
      aliasname = function_1ce1a3739db60bfb(scriptablename);
      break;
    default:
      assertmsg("invalid quick drop item type: " + itemtype);
      break;
  }

  if(isDefined(aliasname)) {
    if(isDefined(newent) && isvector(newent.origin)) {
      playsoundatpos(newent.origin, aliasname);
      return;
    }

    self playSound(aliasname);
  }
}

function function_aed7983cf10ca9e2(newent, weaponobj) {
  origin = self.origin;
  basename = default_to(weaponobj.basename, "");
  material = default_to(weaponobj.material, "");

  if(isDefined(newent) && isvector(newent.origin)) {
    origin = newent.origin;
  } else {
    view_origin = self getvieworigin();
    origin = view_origin + anglesToForward(self getplayerangles()) * 100;
    origin = (origin[0], origin[1], view_origin[2]);
  }

  self playSound("br_inventory_drop_weap_toss_only");
  wait 0.5;
  downward = origin + (0, 0, -120);
  trace = scripts\engine\trace::ray_trace(origin, downward, self, undefined, 1);
  surfacetype = trace["surfacetype"];
  waittillframeend();
  scripts\cp\cp_weapons::function_e7dbbe9220d5e27b(surfacetype);
}

function function_1ce1a3739db60bfb(scriptablename) {
  if(isplunder(scriptablename)) {
    return "br_inventory_drop_plunder";
  }

  if(isammo(scriptablename)) {
    return "br_inventory_drop_ammo";
  }

  if(scriptablename == "brloot_offhand_throwingknife") {
    return "iw9_br_inventory_drop_knife";
  }

  if(scriptablename == "brloot_gascan") {
    return "iw9_br_inventory_gas_can";
  }

  if(scripts\cp_mp\equipment::isequipmentlethal(scriptablename)) {
    return "iw9_br_inventory_drop_lethal";
  }

  if(scripts\cp_mp\equipment::isequipmenttactical(scriptablename)) {
    return "iw9_br_inventory_drop_tactical";
  }

  if(isarmorplate(scriptablename)) {
    return "br_inventory_drop_armor";
  }

  return "br_inventory_drop_weap";
}

function quickdropcleanupcache() {
  var_1ca69ee8605fc45d = 120;
  self notify("quickDropCleanupCache");
  self endon("quickDropCleanupCache");
  wait var_1ca69ee8605fc45d;
  self.quickdropcache = undefined;
}

function ispickupstackable(scriptablename) {
  return istrue(level.br_pickups.stackable[scriptablename]);
}

function quickdropfinditemincache(scriptablename) {
  if(!isDefined(self.quickdropcache)) {
    return;
  }

  if(!isDefined(self.quickdropcache[scriptablename])) {
    return;
  }

  if(!isDefined(self.quickdropcache[scriptablename].ent)) {
    self.quickdropcache[scriptablename] = undefined;
    return;
  }

  if(distancesquared(self.quickdropcache[scriptablename].droporigin, self.origin) > 12000) {
    return;
  }

  return self.quickdropcache[scriptablename];
}

function getquickdropweapon(itemindex) {
  dropweaponobj = function_13ecf3644442a3e7(self, itemindex);
  assert(isDefined(dropweaponobj));
  assert(!isnullweapon(dropweaponobj));
  assert(dropweaponobj != makeweapon("iw9_me_fists_mp"));
  weaponname = getcompleteweaponname(dropweaponobj);
  return weaponname;
}

function quickdropammo(player, itemindex, itemtype, dropall, dontspawnitem) {
  ammotype = function_5a80dba504420037(itemindex);
  ammocount = function_1352197e2482f1cf(player, ammotype);

  if(!isDefined(ammocount) || ammocount == 0) {
    return false;
  }

  if(!dropall) {
    ammocount = int(min(ammocount, function_2bf8eaf550fbe399(ammotype)));
  }

  br_ammo_take_type(player, ammotype, ammocount);

  if(!istrue(dontspawnitem)) {
    quickdropnewitem(itemtype, ammotype, ammocount);
  }

  return true;
}

function function_5a80dba504420037(index) {
  if(!isDefined(level.br_ammo_types)) {
    return;
  }

  if(isDefined(level.br_ammo_types[index])) {
    return level.br_ammo_types[index];
  }

  assert(0, "Attempt to get ammo type for invalid index " + index);
}

function function_1352197e2482f1cf(player, ammotype) {
  if(!isDefined(player) || !isDefined(player.br_ammo)) {
    return;
  }

  if(isDefined(player.br_ammo[ammotype])) {
    return player.br_ammo[ammotype];
  }

  assert(0, "Attempt to get ammo for invalid ammo type " + ammotype);
}

function br_ammo_take_type(player, ammotype, amount) {
  if(player.br_ammo[ammotype] <= 0) {
    return false;
  }

  player.br_ammo[ammotype] -= amount;

  if(player.br_ammo[ammotype] < 0) {
    player.br_ammo[ammotype] = 0;
  }

  player scripts\cp\pickups::br_ammo_player_hud_update_ammotype(ammotype);
  scripts\cp\pickups::br_ammo_update_weapons(player);
  return true;
}

function function_2bf8eaf550fbe399(ammotype) {
  if(!isDefined(level.br_ammo_clipsize)) {
    return;
  }

  if(isDefined(level.br_ammo_clipsize[ammotype])) {
    return level.br_ammo_clipsize[ammotype];
  }

  assert(0, "Attempt to get clip size for invalid ammo type " + ammotype);
}

function function_8f803ea058a13cbd(player, dontspawnitem) {
  if(!istrue(dontspawnitem)) {
    dropstruct = function_7b9f3966a7a42003();
    player dropbrselfrevivetoken(dropstruct);

    if(scripts\common\utility::iscp()) {
      self.pers["dropped_initial_revive_token"] = 1;
    }
  }

  return true;
}

function dropbrselfrevivetoken(dropstruct) {
  if(namespace_53fc9ddbb516e6e1::hasselfrevivetokensharedfunc()) {
    dropinfo = scripts\cp\pickups::getitemdroporiginandangles(dropstruct.dropidx, self.origin, self.angles, self);
    item = namespace_53fc9ddbb516e6e1::spawnpickupsharedfunc("brloot_self_revive", dropinfo, 1, 1);
    scripts\cp\pickups::function_2f4e0022c686dbe6(item);
    scripts\cp\pickups::removeselfrevivetoken();
  }
}

function quickdropgasmaskitem(player, dontspawnitem) {
  if(!istrue(dontspawnitem)) {
    dropstruct = function_7b9f3966a7a42003();
    player dropbrgasmask(dropstruct);
  }

  return true;
}

function dropbrgasmask(dropstruct) {
  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    dropinfo = scripts\cp\pickups::getitemdroporiginandangles(dropstruct.dropidx, self.origin, self.angles, self);

    if(!isDefined(self.gasmasktype)) {
      self.gasmasktype = "brloot_equip_gasmask_durable";
    }

    allowautopickup = isalive(self) || getdvarint(@ "hash_4508c701f27f5496", 0);
    gasmask = namespace_53fc9ddbb516e6e1::spawnpickupsharedfunc(self.gasmasktype, dropinfo, int(self.gasmaskhealth), 1, undefined, allowautopickup);

    if(isDefined(gasmask)) {
      gasmask.gasmaskmaxhealth = self.gasmaskmaxhealth;
    }

    function_75520ea44545c906();

    if(isDefined(gasmask)) {
      scripts\cp\pickups::function_2f4e0022c686dbe6(gasmask);
    }

    function_777c89585478357b(self);
  }
}

function function_75520ea44545c906() {
  if(istrue(self.gasmaskequipped)) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
  }

  self.gasmaskswapinprogress = 0;
  function_4d16b9c52efa3b8();
}

function function_4d16b9c52efa3b8() {
  self.gasmaskmaxhealth = undefined;
  self.gasmaskhealth = undefined;
  self.gasmaskrequests = undefined;
  self.has_gasmask = 0;
  self setclientomnvar("ui_gas_mask", 0);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
}

function function_777c89585478357b(player, var_61f04df489841f73) {
  if(!function_e0fc1230452cf4e7()) {
    return;
  }

  function_dc67872cc4cfae72(player, 1, 10, var_61f04df489841f73);
}

function function_e0fc1230452cf4e7() {
  if(!isDefined(level.var_8f125ba0dc7c4b33)) {
    level.var_8f125ba0dc7c4b33 = getdvarint(@ "hash_a31e837c3d3a9c9", 0);
  }

  return level.var_8f125ba0dc7c4b33;
}

function private function_dc67872cc4cfae72(player, location, sublocation, var_61f04df489841f73) {
  instance = player function_644ed519cac9722b(location, sublocation);

  if(instance.instanceid != "0") {
    player function_dd5661ebe3c9a5a2(instance.instanceid);
  }
}

function function_7b9f3966a7a42003() {
  dropstruct = spawnStruct();
  dropstruct.dropcount = 0;
  dropstruct.dropidx = 0;
  return dropstruct;
}

function function_b15e36b7bc247ddb(player, dropall, dontspawnitem) {}

function function_1503d0b5b4c9d010(player, dropall, dontspawnitem) {}

function function_b130392812b25580(player, itemindex, itemtype, dropall, dontspawnitem) {
  itemcount = player scripts\cp_mp\equipment::getequipmentslotammo(function_4967838290cb31b9(itemindex));

  if(!isDefined(itemcount) || itemcount == 0) {
    return false;
  }

  if(!dropall) {
    itemcount = 1;
  }

  slot = function_4967838290cb31b9(itemindex);
  scripts\cp_mp\equipment::decrementequipmentslotammo(slot, itemcount);

  if(!istrue(dontspawnitem)) {
    player scripts\cp\pickups::dropequipmentinslot(slot, 0, undefined, itemcount, undefined, 0, itemtype, 1);
  }

  return true;
}

function function_91c1be871300a518(lootid) {
  backpackname = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(backpackname)) {
    backpackname = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
  }

  return backpackname;
}

function setbackpackitem(lootid, pickup) {
  quantity = pickup.count;
  maxcount = level.br_pickups.var_4138f9ddc1cd22d[pickup.scriptablename];

  if(!isDefined(maxcount) || maxcount == 0) {
    maxcount = level.br_pickups.maxcounts[pickup.scriptablename];
  }

  backpacksize = getplayerbackpacksize(self);

  for(i = 0; i < backpacksize; i++) {
    currentlootid = self getplayerdata("cp", "dmzBackpack", i, "lootID");

    if(currentlootid == lootid) {
      slotquantity = self getplayerdata("cp", "dmzBackpack", i, "quantity");

      if(slotquantity + quantity <= maxcount) {
        scripts\cp\pickups::function_9f3a7767f1c1bd9e(lootid, i, quantity);
        return 0;
      } else {
        quantity = scripts\cp\pickups::function_91a0bab850d7db10(i, lootid, maxcount, quantity, slotquantity);
      }
    }

    if(quantity <= 0) {
      return 0;
    }
  }

  for(i = 0; i < backpacksize; i++) {
    currentlootid = self getplayerdata("cp", "dmzBackpack", i, "lootID");

    if(currentlootid == 0 && currentlootid != lootid) {
      if(quantity <= maxcount) {
        scripts\cp\pickups::function_9f3a7767f1c1bd9e(lootid, i, quantity);
        return 0;
      } else {
        quantity = scripts\cp\pickups::function_91a0bab850d7db10(i, lootid, maxcount, quantity, 0);
      }
    }

    if(quantity <= 0) {
      return 0;
    }
  }

  return quantity;
}

function function_6f62cb4fc113349c(player, itemtype, itemindex, dropall, dontspawnitem) {
  [lootid, quantity] = function_6738846da50730f1(itemindex);

  if(lootid == 0) {
    return;
  }

  itemcount = undefined;
  itemcountlefthand = undefined;
  var_dab81ead77442a10 = undefined;
  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
  isdogtag = scripts\cp\pickups::function_3c17a26ce6a4668(lootid);

  if(isdogtag) {
    [itemcount, itemcountlefthand, var_dab81ead77442a10] = function_379463a84adb07b4(quantity);
  } else if(dropall || isammo(ref)) {
    itemcount = quantity;
  } else {
    itemcount = 1;
  }

  if(ref == "dmz_nvg") {
    if(player isnightvisionon()) {
      player nightvisionviewoff(1);
    }
  }

  player function_db1dd76061352e5b(itemindex, scripts\engine\utility::ter_op(isdogtag, quantity, itemcount));

  if(istrue(dontspawnitem)) {
    return 1;
  }

  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
  scriptable = undefined;

  if(isammo(ref)) {
    scriptable = ref;
  } else {
    scriptable = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
  }

  droppeditem = quickdropnewitem(itemtype, scriptable, itemcount, itemcountlefthand, var_dab81ead77442a10);
  player notify("dropped_backpack_item", droppeditem);
  return 1;
}

function function_379463a84adb07b4(count) {
  if(!isDefined(count)) {
    return [61, 61, 0];
  }

  return [count & 64 - 1, count >> 6, 0];
}

function function_db1dd76061352e5b(index, var_74806f0c4caa7e55) {
  [lootid, _] = function_6738846da50730f1(index);
  currentquantity = getquantityatbackpackindex(index);
  thread scripts\cp\pickups::setbackpackitematindex(index, lootid, int(max(0, currentquantity - var_74806f0c4caa7e55)));
  backpackname = function_91c1be871300a518(lootid);

  if(isammo(backpackname)) {
    function_5143c54fb8c3c4fd(self, backpackname);
  }

  function_6355a9db4ea7ab55(lootid);
  return lootid;
}

function function_5143c54fb8c3c4fd(player, ammotype) {
  if(!isDefined(player) || !isDefined(ammotype)) {
    return;
  }

  var_509d86412c9d7426 = self getweaponslistprimaries();
  var_a9bc5314d494806d = 0;

  foreach(weap in var_509d86412c9d7426) {
    ammotypecomparison = scripts\cp\pickups::br_ammo_type_for_weapon(weap);

    if(isDefined(ammotypecomparison) && ammotype == ammotypecomparison) {
      newstockammo = self.br_ammo[ammotype];

      if(function_6b531c76815d77f3(ammotype)) {
        lootid = scripts\cp_mp\utility\loot::getlootidfromref(ammotype);
        newstockammo += gettotalitemcountinbag(lootid);
      }

      newstockammo = get_int_or_0(newstockammo);
      player scripts\cp\pickups::function_4906c10c3ffdd4ca(weap, newstockammo);
    }
  }

  player notify("ammo_update");
}

function function_6b531c76815d77f3(scriptablename) {
  if(isammo(scriptablename)) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(scriptablename);
  } else {
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(scriptablename);
  }

  if(isDefined(lootid)) {
    return function_36b1968bfe78916b(lootid);
  }

  return 0;
}

function function_36b1968bfe78916b(lootid) {
  return isDefined(function_821bfba97b1251ac(lootid));
}

function function_821bfba97b1251ac(lootid) {
  if(lootid == 0) {
    return undefined;
  }

  backpacksize = getplayerbackpacksize(self);

  for(i = 0; i < backpacksize; i++) {
    currentlootid = self getplayerdata("cp", "dmzBackpack", i, "lootID");

    if(lootid == currentlootid) {
      return i;
    }
  }

  return undefined;
}

function gettotalitemcountinbag(lootid) {
  total = 0;

  for(i = 0; i < getplayerbackpacksize(self); i++) {
    slotlootid = getlootidatbackpackindex(i);

    if(slotlootid == lootid) {
      total += getquantityatbackpackindex(i);
    }
  }

  return total;
}

function getlootidatbackpackindex(index) {
  if(utility::iscp()) {
    return self getplayerdata("cp", "dmzBackpack", index, "lootID");
  }

  if(isDefined(level.progressiongroup) && isDefined(level.backpackdata)) {
    return self getplayerdata(level.progressiongroup, level.backpackdata, index, "lootID");
  }

  return undefined;
}

function getquantityatbackpackindex(index) {
  if(utility::iscp()) {
    return self getplayerdata("cp", "dmzBackpack", index, "quantity");
  }

  if(isDefined(level.progressiongroup) && isDefined(level.backpackdata)) {
    return self getplayerdata(level.progressiongroup, level.backpackdata, index, "quantity");
  }

  return undefined;
}

function loot_getitemcount(instance) {
  assert(isDefined(instance));
  return instance.count >> 0 & 2048 - 1;
}

function loot_getitemcountlefthand(instance) {
  assert(isDefined(instance));
  return instance.count >> 11 & 2048 - 1;
}

function function_3a5f7703319142dd(instance) {
  assert(isDefined(instance));
  return instance.count >> 11 + 11 & 256 - 1;
}

function loot_setitemcount(instance, itemcount, itemcountlefthand, var_dab81ead77442a10) {
  count = 0;
  assert(isDefined(instance));
  assert(itemcount < 2048);
  count += (itemcount & 2048 - 1) << 0;

  if(isDefined(itemcountlefthand)) {
    assert(itemcountlefthand < 2048);
    count += (itemcountlefthand & 2048 - 1) << 11;
  }

  if(isDefined(var_dab81ead77442a10)) {
    assert(var_dab81ead77442a10 < 256);
    count += (var_dab81ead77442a10 & 256 - 1) << 11 + 11;
  }

  instance.count = count;
}

function function_6355a9db4ea7ab55(lootid) {
  if(!isDefined(lootid)) {
    return;
  }

  type = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);
  ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);

  switch (type) {
    case #"hash_1cac65e1b8bf24a7":
    case #"hash_27124c6c97ccffa1":
    case #"hash_325cb2e66f67d5b9":
    case #"hash_339227cb650975db":
    case #"hash_511d3c24fcedcdb1":
    case #"hash_850999d7864fa3b4":
    case #"hash_93c71e7b6c0b81d7":
    case #"hash_ab671284a3fc4e3d":
    case #"hash_b60679835e82a584":
    case #"hash_e534fd8ec73eafb4":
      return;
    case #"hash_7d516d84d0a82f2":
      if(isDefined(level.var_b33c035c483c2893) && isDefined(level.var_b33c035c483c2893["onDrop"]) && isDefined(level.var_b33c035c483c2893["onDrop"][ref])) {
        [[level.var_b33c035c483c2893["onDrop"][ref]]](self);
      }

      return;
  }
}

function function_3ab0a87eeaa203bf() {
  if(!istrue(level.var_2c93542553c664f5)) {
    return false;
  }

  foreach(weaponobj in self.primaryinventory) {
    if(weaponobj.basename == "iw9_me_fists_mp") {
      return false;
    }
  }

  return true;
}

function function_8e7e1da48d7746e5(player, weaponpickup) {
  assert(isDefined(weaponpickup.type));
  assert(isweaponpickup(weaponpickup.type));
  assert(-1);
  scripts\cp\pickups::function_b9da718e50063452();
  weaponshandler = level.br_pickups.var_c9015f26f73062a0[player.guid];

  if(!isDefined(weaponshandler)) {
    weaponshandler = spawnStruct();
    weaponshandler.array = [];
    weaponshandler.curindex = 0;
    weaponshandler.var_52fcfe909c72db5b = 0;
    level.br_pickups.var_c9015f26f73062a0[player.guid] = weaponshandler;
  }

  weaponshandler.array[weaponshandler.curindex] = weaponpickup.index;
  weaponshandler.curindex = math::wrap(0, 4, weaponshandler.curindex + 1);
  weaponshandler.var_52fcfe909c72db5b = gettime();
}

function function_823964aa15b30575() {
  var_6fb2d8460bbfeabe = undefined;

  if(self function_617199566a43446()) {
    foreach(weap in self.primaryweapons) {
      if(scripts\cp\weapon::iscacsecondaryweapon(weap)) {
        if(!isDefined(var_6fb2d8460bbfeabe)) {
          var_6fb2d8460bbfeabe = weap;
          continue;
        }

        var_6fb2d8460bbfeabe = undefined;
        break;
      }
    }
  }

  if(!isDefined(var_6fb2d8460bbfeabe) && self function_27bb46eaf2ecd374()) {
    currentweapon = self getcurrentweapon();

    foreach(weap in self.primaryweapons) {
      if(!issameweapon(currentweapon, weap)) {
        var_6fb2d8460bbfeabe = weap;
        break;
      }
    }
  }

  return var_6fb2d8460bbfeabe;
}

function function_55c5d35c8c76a95b(pickupent) {
  if(!isDefined(pickupent.weapon)) {
    attachments = [];
    newweapon = undefined;

    if(isDefined(pickupent.customweaponname)) {
      completeweaponname = pickupent.customweaponname;
      newweapon = makeweaponfromstring(completeweaponname);
    } else if(!isDefined(pickupent.completeweapon)) {
      newweapon = scripts\cp\pickups::getfullweaponobjforpickup(pickupent);
      completeweaponname = getcompleteweaponname(newweapon);
    } else {
      newweapon = scripts\cp_mp\weapon::buildweapon(pickupent.loadoutprimaryfullname, attachments, "none", "none", -1);
      completeweaponname = pickupent.loadoutprimaryfullname;
    }

    newweaponbasename = scripts\cp_mp\weapon::getweaponrootname(completeweaponname);
    weaponname = completeweaponname;
  } else {
    newweapon = pickupent.weapon;

    if(isDefined(pickupent.loadoutprimaryfullname)) {
      weaponname = pickupent.loadoutprimaryfullname;
    } else if(isDefined(pickupent.weapon.basename)) {
      weaponname = pickupent.weapon.basename;
    } else {
      weaponname = getsubstr(newweapon.classname, 7, newweapon.classname.size);
    }

    newweaponbasename = scripts\cp_mp\weapon::getweaponrootname(weaponname);
  }

  return [newweapon, newweaponbasename, weaponname];
}

function function_6f39f9916649ac48(lootid, quantity) {
  itemtype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(lootid);

  if(itemtype == "weapon") {
    function_590202daf6a1d4d7(self);
    return;
  }

  index = function_e05897f5d860188e(lootid, undefined, 1);

  if(!isDefined(index)) {
    return 0;
  }

  function_db1dd76061352e5b(index, quantity);
  return 1;
}

function function_e05897f5d860188e(lootid, quantity, drop) {
  if(!isDefined(lootid)) {
    return undefined;
  }

  lootname = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

  if(!isDefined(lootname)) {
    lootname = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
  }

  maxcount = level.br_pickups.var_4138f9ddc1cd22d[lootname];

  if(!isDefined(maxcount)) {
    maxcount = level.br_pickups.maxcounts[lootname];
  }

  backpacksize = getplayerbackpacksize(self);

  for(i = 0; i < backpacksize; i++) {
    currentlootid = self getplayerdata("cp", "dmzBackpack", i, "lootID");

    if(currentlootid == lootid) {
      if(istrue(drop)) {
        return i;
      }

      currentquantity = self getplayerdata("cp", "dmzBackpack", i, "quantity");

      if(currentquantity < maxcount) {
        return i;
      }
    }
  }

  return undefined;
}

function function_f77406a45e988898(equipname) {
  if(!isDefined(equipname)) {
    return "br_ammo";
  }

  switch (equipname) {
    case #"hash_4320d77f90725183":
      return "c4";
    case #"hash_2354208d9af64220":
      return "claymore";
    case #"hash_15d06a7d7efafe8":
      return "decoy";
    case #"hash_5a562592c930b7d6":
      return "flash";
    case #"hash_8c7819f0a3fbd1e0":
      return "frag";
    case #"hash_48d3196b46b0ba61":
    case #"hash_8770d1da0d7395b9":
      return "geiger";
    case #"hash_4b4a6458f00d9319":
      return "hb_sensor";
    case #"hash_b1c1a91eb12bd8e5":
      return "iodine_pills";
    case #"hash_142a787e36d7d7ce":
      return "molotov";
    case #"hash_8df9cfc147eb2d86":
      return "shockstick";
    case #"hash_fb6b649176cec75d":
      return "smoke";
    case #"hash_25ac81b822cf0c9f":
      return "stim";
    case #"hash_5fca4943a78ace9c":
      return "stun";
    case #"hash_de4641ddbc44a7ba":
      return "thermite";
    case #"hash_e156752cb79526e8":
      return "bunker_buster";
    case #"hash_4f62b5fa00ecd075":
      return "snapshot";
    case #"hash_3995658e01f4fac1":
      return "at_mine";
    case #"hash_f0907f858c134cb4":
      return "semtex";
    case #"hash_6d194c409057b2":
      return "binoculars";
    default:
      return "br_ammo";
  }
}

function function_84772ebf836af5db(index, amount) {
  var_e8db6afbf2180f7e = self getplayerdata("cp", "dmzBackpack", index, "quantity");
  newamount = int(max(0, var_e8db6afbf2180f7e + amount));
  lootid = self getplayerdata("cp", "dmzBackpack", index, "lootID");
  scripts\cp\pickups::setbackpackitematindex(index, lootid, newamount);
}

function pickupissameasequipmentslot(equipname, equipmentslot) {
  if(isDefined(self.equipment[equipmentslot]) && self.equipment[equipmentslot] == equipname) {
    return true;
  }

  return false;
}

function equipmentslothasroom(scriptablename, equipmentslot) {
  equip_ref = level.br_pickups.br_equipname[scriptablename];

  if(isDefined(equip_ref) && scripts\cp_mp\equipment::getequipmentslotammo(equipmentslot) < scripts\cp_mp\equipment::getequipmentmaxammo(equip_ref)) {
    return true;
  }

  return false;
}

function getquickdropplundercount(dropall) {
  var_a77325cf77e1a9cc = 500;

  if(istrue(dropall)) {
    return int(self.plundercount);
  }

  return int(min(self.plundercount, var_a77325cf77e1a9cc));
}

function playerplunderdrop(amount, data) {
  return scripts\cp\pickups::playerplunderevent(amount, 4, undefined, data);
}

function modify_plunder_itemsinworld(itemname, modification) {
  if(level.br_plunder_enabled) {
    level.br_plunder.itemsinworld[itemname] += modification;
  }
}

function function_c8a5593cbb13f17c(pickup, weaponobj) {
  var_fe4cd9dc9393409d = getdvarint(@ "hash_ef63562e5f3b14d0", 5000);
  currenttime = gettime();
  var_c8a5593cbb13f17c = !isDefined(self.var_e7f6950ddc75ef66) || currenttime - self.var_e7f6950ddc75ef66 > var_fe4cd9dc9393409d;

  if(var_c8a5593cbb13f17c && self function_c3a5505bc8f25a14()) {
    var_d05470192f5f4895 = 0;

    for(i = 0; !var_d05470192f5f4895 && i < self.primaryweapons.size; i++) {
      var_d05470192f5f4895 = isnullweapon(self.primaryweapons[i]) || scripts\cp\weapon::isfistweapon(self.primaryweapons[i]);
    }

    var_c8a5593cbb13f17c = var_d05470192f5f4895;
  }

  if(var_c8a5593cbb13f17c && self function_2ebb84ec61fcfaaf()) {}

  if(var_c8a5593cbb13f17c && self function_113c9c35caf6f029()) {
    var_c8a5593cbb13f17c = function_2b4b373533156a88(pickup, weaponobj);
  }

  if(var_c8a5593cbb13f17c) {
    if(self function_5329138a845b7aa6()) {
      baseweaponname = scripts\cp_mp\weapon::getweaponrootname(weaponobj);
      var_862e2d88178bc2c8 = 0;

      for(i = 0; !var_862e2d88178bc2c8 && i < self.primaryweapons.size; i++) {
        var_e9094c47c8dbe268 = scripts\cp_mp\weapon::getweaponrootname(self.primaryweapons[i]);

        if(var_e9094c47c8dbe268 == baseweaponname) {
          playerweaponrarity = getweaponpickuprarity(self.primaryweapons[i]);
          var_167e430a395b12ba = level.br_pickups.br_itemrarity[pickup.scriptablename];
          var_862e2d88178bc2c8 = playerweaponrarity < var_167e430a395b12ba;
        }
      }

      var_c8a5593cbb13f17c = var_862e2d88178bc2c8;
    } else if(self function_362521bcb3a1ba25()) {
      if(!isDefined(level.var_81369e82645391f0)) {
        scripts\cp\pickups::function_f8b204e807cc62ed();
      }

      currentweapon = self getcurrentweapon();
      var_185d0d5e6e0be607 = level.var_81369e82645391f0[weaponclass(currentweapon.basename)];
      var_a6fb744f02d4ffb8 = level.var_81369e82645391f0[weaponclass(weaponobj.basename)];

      if(var_185d0d5e6e0be607 != var_a6fb744f02d4ffb8) {
        var_8faddf4be83922 = self function_337e400ead27b7bd(var_185d0d5e6e0be607);
        var_439466f5277ef2d9 = self function_337e400ead27b7bd(var_a6fb744f02d4ffb8);
        var_c8a5593cbb13f17c = var_439466f5277ef2d9 > var_8faddf4be83922;
      } else {
        var_c8a5593cbb13f17c = 0;
      }
    }
  }

  return var_c8a5593cbb13f17c;
}

function function_2b4b373533156a88(pickup, weapon) {
  ammotype = scripts\cp\pickups::br_ammo_type_for_weapon(weapon);
  var_f68fc94bc895254 = function_88d62a65ff69eac(self, ammotype);
  return var_f68fc94bc895254 > 0 || pickup.count > 0 || pickup.countlefthand > 0;
}

function function_88d62a65ff69eac(player, ammotype) {
  newweaponstock = player.br_ammo[ammotype];

  if(function_6b531c76815d77f3(ammotype)) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(ammotype);
    newweaponstock += gettotalitemcountinbag(lootid);
  }

  return newweaponstock;
}

function function_cbbf9bf3544dc456(pickup, isautouse) {
  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
  result = scripts\cp\pickups::function_e01d9736b2d100ac(lootid, pickup.count);

  if(istrue(result)) {
    return 20;
  }

  if(istrue(isautouse)) {
    return 12;
  }

  return 4;
}

function getweaponpickuprarity(weaponobj) {
  weaponrarity = 0;
  weaponfullname = getcompleteweaponname(weaponobj);

  if(isDefined(level.br_pickups.br_weapontoscriptable[weaponfullname])) {
    scriptabledefname = level.br_pickups.br_weapontoscriptable[weaponfullname];
    weaponrarity = level.br_pickups.br_itemrarity[scriptabledefname];
  } else if(scripts\cp\pickups::isvalidcustomweapon(weaponobj)) {
    weaponrarity = 10;
  }

  return weaponrarity;
}

function function_99ab09ba7022d107(pickup, isautouse) {
  lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
  result = scripts\cp\pickups::function_e01d9736b2d100ac(lootid, pickup.count);

  if(istrue(result)) {
    return 1;
  }

  if(istrue(isautouse)) {
    return 12;
  }

  return 4;
}

function function_5e7049647595ab97() {
  if(!level.var_1d814f83596d0a02) {
    return false;
  }

  return isDefined(self.equipment["super"]) && scripts\cp_mp\equipment::getequipmentslotammo("super") > 0;
}

function function_d674d32c2d3ba5ed(player) {
  if(!istrue(level.var_472d7a6d15e57940)) {
    return false;
  }

  if(level.gametype == "dungeons") {
    return true;
  }

  return isDefined(player.streakdata) && isDefined(player.streakdata.streaks) && self.streakdata.streaks.size > 0;
}

function function_8f0bd51f5c6108b(pickup, player, bautouse, instance) {
  lootid = undefined;
  player scripts\cp\pickups::playpickupfeedback(pickup, bautouse);

  if(isammo(pickup.scriptablename)) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(pickup.scriptablename);
  } else {
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
  }

  if(isDefined(lootid)) {
    if(scripts\cp\pickups::isweaponpickupitem(pickup)) {
      pickup.count = 1;
    }

    if(function_4294e9b331377c31(pickup.scriptablename)) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_armor_plate");
      pickup.count = 8;
    }

    if(issubstr(pickup.scriptablename, "brloot_ammo")) {
      player namespace_53fc9ddbb516e6e1::additemtobackpacksharedfunc(lootid, pickup, undefined, 1);
    } else {
      player namespace_53fc9ddbb516e6e1::additemtobackpacksharedfunc(lootid, pickup);
    }

    if(isDefined(instance)) {
      scripts\cp\pickups::loothide(instance);
    }

    return 1;
  }
}

function function_60234aa487445085(pickup, player, bautouse, instance) {
  var_483ad0cab6e25673 = isDefined(pickup.scriptablename) && function_f262c137ed78e6eb(pickup.scriptablename);

  if(level.gametype == "dungeons" && istrue(pickup.skipsound)) {
    pickupremains = player scripts\cp\pickups::onusecompleted(pickup, 1, bautouse, undefined, undefined, instance);
  } else {
    pickupremains = player scripts\cp\pickups::onusecompleted(pickup, var_483ad0cab6e25673, bautouse, undefined, undefined, instance);
  }

  if(isDefined(instance) && pickupremains) {
    loot_setitemcount(instance, pickup.count, pickup.countlefthand, pickup.countalt);
  }

  if(!isDefined(instance) || pickupremains) {
    return true;
  }

  if(!var_483ad0cab6e25673) {
    scripts\cp\pickups::loothide(instance);
  }

  player setclientomnvar("ui_notify_show_minimal_hud", gettime());
  return true;
}

function function_7f04a682872040db(player) {
  for(itemindex = 0; itemindex < 50; itemindex++) {
    player setplayerdata("mp", "dmzInventory", itemindex, "lootedQuantity", 0);
  }
}

function printinventory() {
  for(i = 0; i < 50; i++) {
    lootid = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", i, "<dev string:x2c>");
    quantity = self getplayerdata("<dev string:x1c>", "<dev string:x1f>", i, "<dev string:x33>");
    ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
    println("<dev string:x3c>" + i + "<dev string:x3e>" + lootid + "<dev string:x44>" + ref + "<dev string:x47>" + quantity);
  }
}

function snapshotinventory() {
  items = [];
  inventoryweapons = getinventoryweapons(self);

  foreach(weapon in inventoryweapons) {
    variantid = weapon.variantid;

    if(!isDefined(weapon.variantid)) {
      variantid = 0;
    }

    rootname = scripts\cp_mp\weapon::getweaponrootname(weapon);
    lootid = scripts\cp_mp\weapon::function_79d6e6c22245687a(rootname, variantid);

    if(isDefined(lootid) && lootid > 0) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items[items.size] = item;
    }
  }

  ref = scripts\cp_mp\equipment::getcurrentequipment("primary");
  equipmentammo = scripts\cp_mp\equipment::getequipmentslotammo("primary");
  lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);

  if(isDefined(lootid) && equipmentammo > 0) {
    item = spawnStruct();
    item.lootid = lootid;
    item.quantity = 1;
    items[items.size] = item;
  }

  ref = scripts\cp_mp\equipment::getcurrentequipment("secondary");
  equipmentammo = scripts\cp_mp\equipment::getequipmentslotammo("secondary");
  lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);

  if(isDefined(lootid) && equipmentammo > 0) {
    item = spawnStruct();
    item.lootid = lootid;
    item.quantity = 1;
    items[items.size] = item;
  }

  ref = scripts\cp_mp\equipment::getcurrentequipment("super");
  ref = scripts\cp_mp\utility\loot::function_151b82e1257f4cde(ref);
  equipmentammo = getsuperweapondisabledammobr();
  lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref);

  if(isDefined(lootid) && equipmentammo > 0) {
    item = spawnStruct();
    item.lootid = lootid;
    item.quantity = 1;
    items[items.size] = item;
  }

  ref = undefined;

  if(isDefined(ref)) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref(ref.streakname);

    if(isDefined(lootid)) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items[items.size] = item;
    }
  }

  if(hasplatepouch()) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref("armor_satchel");

    if(isDefined(lootid)) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items[items.size] = item;
    }
  }

  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    lootid = scripts\cp_mp\utility\loot::getlootidfromref("gas_mask");

    if(isDefined(lootid)) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items[items.size] = item;
    }
  }

  itemname = self.equipment["health"];
  itemcount = scripts\cp_mp\equipment::getequipmentslotammo("health");

  if(isDefined(itemname) && isDefined(itemcount) && itemcount > 0) {
    item = spawnStruct();
    item.lootid = scripts\cp_mp\utility\loot::getlootidfromref("armor_plate");
    item.quantity = itemcount;
    items[items.size] = item;
  }

  return items;
}

function getinventoryweapons(player) {
  weapons = [];

  foreach(weapon in player getweaponslistprimaries()) {
    if(isunderwaterweapon(weapon)) {
      continue;
    }

    if(weaponinventorytype(weapon) == "altmode") {
      continue;
    }

    if(scripts\cp\weapon::ismeleeoverrideweapon(weapon)) {
      continue;
    }

    weapons[weapons.size] = weapon;
  }

  return weapons;
}

function getsuperweapondisabledammobr() {
  ammo = scripts\cp_mp\equipment::getequipmentslotammo("super");

  if(!istrue(self.issuperdisabled)) {
    return ammo;
  }

  if(istrue(self.var_1066fbd86c88a6df)) {
    ammo = 1;
  }

  return ammo;
}

function playersetplundercount(plundercount, data) {
  if(!isDefined(self.plundercount)) {
    self.plundercount = 0;
  }

  plunderdelta = plundercount - self.plundercount;

  if((!isDefined(data) || !istrue(data.setplunderifunchanged)) && plunderdelta == 0) {
    return;
  }

  self.plundercount = plundercount;

  if(self.plundercount > level.br_plunder.plunderlimit) {
    namespace_53fc9ddbb516e6e1::showerrormessagesharedfunc("MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED");
    self.plundercount = level.br_plunder.plunderlimit;
  }

  if(isDefined(self.petwatch)) {
    scripts\cp_mp\pet_watch::onplayergetsplunder();
  }

  amount = self.plundercount;
  scripts\cp\persistence::set_player_currency(int(amount), 1);
  scripts\cp\pickups::function_46ee9182cf6872d5(amount);

  if(plundercount > 0) {}
}

function getplayerbackpacksize(player) {
  if(istrue(level.var_a7f81dfdc88e53e6)) {
    return level.var_e247454ac2869696;
  }

  return player getplayerdata("mp", level.backpacksize);
}

function br_forcegivecustompickupitem(player, scriptablename, var_43fb3d97abb79854, countoverride, fromkiosk, droppurchased, var_db943473454f6ea6) {
  if(istrue(droppurchased)) {
    player dropbrcustompickupitem(scriptablename, countoverride, fromkiosk, droppurchased);
    return true;
  }

  fakepickup = spawnStruct();
  fakepickup.scriptablename = scriptablename;
  fakepickup.origin = player.origin;
  fakepickup.count = 0;
  fakepickup.maxcount = level.br_pickups.maxcounts[fakepickup.scriptablename];
  fakepickup.stackable = level.br_pickups.stackable[fakepickup.scriptablename];

  if(isDefined(countoverride)) {
    fakepickup.count = countoverride;
  }

  if(!fakepickup.count && isDefined(level.br_pickups.counts[fakepickup.scriptablename])) {
    fakepickup.count = level.br_pickups.counts[fakepickup.scriptablename];
  }

  results = player scripts\cp\pickups::cantakepickup(fakepickup);

  if(results == 1) {
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(fakepickup.scriptablename);
    player scripts\cp\pickups::onusecompleted(fakepickup, var_43fb3d97abb79854, undefined, fromkiosk, var_db943473454f6ea6);
    return true;
  } else if(results == 20) {
    lootid = undefined;

    if(isammo(fakepickup.scriptablename)) {
      lootid = scripts\cp_mp\utility\loot::getlootidfromref(fakepickup.scriptablename);
    } else {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(fakepickup.scriptablename);
    }

    if(isDefined(lootid)) {
      if(scripts\cp\pickups::isweaponpickupitem(fakepickup)) {
        fakepickup.count = 1;
      }

      if(function_4294e9b331377c31(fakepickup.scriptablename)) {
        lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_armor_plate");
        fakepickup.count = 8;
      }

      player namespace_53fc9ddbb516e6e1::additemtobackpacksharedfunc(lootid, fakepickup);
      return true;
    }
  }

  return false;
}

function dropbrcustompickupitem(scriptablename, countoverride, fromkiosk, droppurchased) {
  var_7feba4ec6c35d82d = istrue(droppurchased) && isDefined(scriptablename);

  if(var_7feba4ec6c35d82d) {
    scripts\cp\pickups::function_73ffc9bcd6d1e62d(fromkiosk);
    dropinfo = scripts\cp\pickups::getitemdroporiginandangles(0, self.origin, self.angles, self, level.br_pickups.yawoffsetoverride, level.br_pickups.distanceoverride);
    item = namespace_53fc9ddbb516e6e1::spawnpickupsharedfunc(scriptablename, dropinfo, countoverride);
    scripts\cp\pickups::function_2f4e0022c686dbe6(item);
  }
}

function br_ammo_player_is_maxed_out() {
  player = self;
  var_509d86412c9d7426 = player getweaponslistprimaries();

  foreach(weap in var_509d86412c9d7426) {
    ammotype = scripts\cp\pickups::br_ammo_type_for_weapon(weap);

    if(isDefined(ammotype)) {
      ammoclipright = player getweaponammoclip(weap, "right");
      ammoclipsize = weaponclipsize(weap);

      if(ammoclipright < ammoclipsize) {
        return false;
      }

      if(weap.isdualwield) {
        ammoclipleft = player getweaponammoclip(weap, "left");

        if(ammoclipleft < ammoclipsize) {
          return false;
        }
      }

      if(!scripts\cp\pickups::br_ammo_type_player_full(player, ammotype)) {
        return false;
      }
    }
  }

  return true;
}

function traceselectedmaplocation(location) {
  startlocationtrace = location + (0, 0, 10000);
  var_3cb14aea5687b8f6 = location - (0, 0, 10000);
  drivablevehicles = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
  killstreakmodels = level.activekillstreaks;
  var_b9d5783a4f34efbc = scripts\engine\utility::array_combine(drivablevehicles, killstreakmodels);
  contentoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 0, 0, 0);
  return scripts\engine\trace::ray_trace(startlocationtrace, var_3cb14aea5687b8f6, var_b9d5783a4f34efbc, contentoverride, 0, 1);
}

function br_ammo_player_max_out() {
  player = self;
  var_f32522625b3c7cf9 = [];
  var_509d86412c9d7426 = player getweaponslistprimaries();

  foreach(weap in var_509d86412c9d7426) {
    ammotype = scripts\cp\pickups::br_ammo_type_for_weapon(weap);

    if(isDefined(ammotype)) {
      var_f32522625b3c7cf9[ammotype] = "dummy_value";
      ammoclipsize = weaponclipsize(weap);
      player setweaponammoclip(weap, ammoclipsize);
    }
  }

  foreach(ammotype, unused in var_f32522625b3c7cf9) {
    player.br_ammo[ammotype] = level.var_e6ea72fc5e3fcd00[ammotype];
    player scripts\cp\pickups::br_ammo_player_hud_update_ammotype(ammotype);
  }

  scripts\cp\pickups::br_ammo_update_weapons(player);
}

function playerplunderkioskpurchase(amount, data) {
  return scripts\cp\pickups::playerplunderevent(amount, 4, undefined, data);
}

function br_give_weapon_clip(objweapon, numclips) {
  player = self;

  if(!isDefined(numclips)) {
    numclips = 1;
  }

  ammotype = scripts\cp\pickups::br_ammo_type_for_weapon(objweapon);

  if(isDefined(ammotype)) {
    var_c1192c297bbf292f = int(level.br_ammo_clipsize[ammotype] * numclips);
    maxammostock = level.var_e6ea72fc5e3fcd00[ammotype];

    if(function_6b531c76815d77f3(ammotype)) {
      lootid = scripts\cp_mp\utility\loot::getlootidfromref(ammotype);
      maxammostock += gettotalitemcountinbag(lootid);
    }

    var_7ff630bfbca7b961 = int(clamp(player.br_ammo[ammotype] + var_c1192c297bbf292f, 0, maxammostock));
    scripts\cp\pickups::br_ammo_update_ammotype_weapons(player, ammotype, var_7ff630bfbca7b961);
  }
}